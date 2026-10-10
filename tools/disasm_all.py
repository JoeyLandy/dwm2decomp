#!/usr/bin/env python3
"""Whole-ROM recursive-descent disassembler: regenerates src/banks/bankNN.asm.

Starts from the reset/interrupt/RST vectors and the cartridge entry in bank 0,
follows jumps/calls, and mines two game idioms found in bank 0 (C1, local
observation only):
  * `ld hl, ADDR` + `ld b, BANK` + `rst $10`  -> call ADDR in bank BANK
  * `rst $00` + inline word table             -> table of jump targets
Reached bytes become instructions/`dw`; everything else is opaque data
(`ds` for runs of one byte, short `db`, long INCBIN slice). Decoding is
byte-exact, so classification errors cannot change the ROM -- only the build
gate (tools/build.py) certifies identity. Reachability is not proof of runtime
execution and names carry no semantics.

Usage: disasm_all.py [--stats] [--quiet] [--no-text] [--export-streams PATH.json]
  --no-text keeps prose as opaque INCBIN data instead of rendering it as db strings.
Progress goes to stderr. All banks are rendered in memory first; src/banks/*.asm
and src/main.asm are written only after the whole analysis succeeds, so an
interrupted run leaves the previous generated tree untouched.
"""
from __future__ import annotations

import bisect
import collections
import json
import re
import sys
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from trace_disasm import decode  # noqa: E402
from lzss_gfx import decompress as lzss_decompress  # noqa: E402
from sound_tracks import decode_header, decode_region  # noqa: E402
import gb_symbols as gbs  # noqa: E402
import gb_text  # noqa: E402

_T0 = time.monotonic()
_QUIET = False


def log(msg: str) -> None:
    """Progress line on stderr with elapsed seconds (suppressed by --quiet)."""
    if not _QUIET:
        print(f"[{time.monotonic() - _T0:7.1f}s] {msg}", file=sys.stderr, flush=True)

ROOT = Path(__file__).resolve().parents[1]
REF = ROOT / "local/roms/dwm2-cobi-us.gbc"
BANK = 0x4000
ROM_NAME = "dwm2-cobi-us.gbc"
VECTORS = [0x00, 0x10, 0x30, 0x38, 0x40, 0x48, 0x58, 0x80, 0x100, 0x150]
LD_HL = re.compile(r"ld hl, \$([0-9A-F]{4})$")
LD_B = re.compile(r"ld b, \$([0-9A-F]{2})$")
MAX_TABLE = 128
# Instruction kinds that end an argument setup when scanning backwards from a call: another call
# consumes or clobbers the registers, and a return or jump leaves the straight-line code.
SETUP_BARRIER = ("ret", "jp", "jr", "jphl", "call", "callc", "rst")

MACROS_INC = """; Macros that name instruction idioms found in the ROM (E-0007). They expand to exactly
; the instructions the ROM contains, so the bytes do not change.

; A far call: `rst $10` calls the code at HL with ROM bank B mapped, then restores the caller's
; bank (Func_000_0010). The ROM loads the two registers in either order, hence two macros.
MACRO farcall
    ld hl, \\1
    ld b, BANK(\\1)
    rst $10
ENDM

MACRO farcall_b
    ld b, BANK(\\1)
    ld hl, \\1
    rst $10
ENDM

; HL += A, the way the ROM spells it: add into L, carry into H.
MACRO add_a_to_hl
    add a, l
    ld l, a
    jr nc, .skip\\@
    inc h
.skip\\@:
ENDM

; HL = the word at [HL]: low byte first, then the high byte.
MACRO deref_hl
    ld a, [hl+]
    ld h, [hl]
    ld l, a
ENDM
"""

ADD_A_TO_HL = re.compile(r"    add a, l\n    ld l, a\n    jr nc, (\w+)\n    inc h\n\n\1::\n")
DEREF_HL = "    ld a, [hl+]\n    ld h, [hl]\n    ld l, a\n"
LABEL_TOKEN = re.compile(r"\b(?:Jump|Jr|Label)_\w+")


def fold_idioms(texts: list[str]) -> tuple[list[str], dict[str, int]]:
    """Replace the two commonest multi-instruction idioms by their macros (macros.inc).

    `add_a_to_hl` folds the five-line add/carry sequence only when the branch label that ends it
    is referenced nowhere else, so no other code can jump into the middle of the idiom. Both
    macros expand to the removed instructions, so the bytes are unchanged."""
    uses = collections.Counter(t for text in texts for t in LABEL_TOKEN.findall(text))
    counts = {"add_a_to_hl": 0, "deref_hl": 0}

    def fold_add(m):
        if uses[m.group(1)] != 2:
            return m.group(0)
        counts["add_a_to_hl"] += 1
        return "    add_a_to_hl\n"

    out = []
    for text in texts:
        text = ADD_A_TO_HL.sub(fold_add, text)
        counts["deref_hl"] += text.count(DEREF_HL)
        out.append(text.replace(DEREF_HL, "    deref_hl\n"))
    return out, counts


class Rom:
    def __init__(self, data: bytes):
        self.data = data
        self.nbanks = len(data) // BANK
        self.zero = {b for b in range(self.nbanks) if not any(data[b * BANK:(b + 1) * BANK])}
        # insn[bank][addr] = (len, text, kind, tgt) or ("dw", word)
        self.insn: dict[int, dict[int, tuple]] = {b: {} for b in range(self.nbanks)}
        self.covered: dict[int, set[int]] = {b: set() for b in range(self.nbanks)}
        self.labels: dict[int, dict[int, str]] = {b: {} for b in range(self.nbanks)}
        self.pending: dict[int, list[int]] = {b: [] for b in range(self.nbanks)}
        self.tables: list[tuple[int, int]] = []  # (bank, address of first word)
        self.reason: dict[tuple[int, int], str] = {}  # heuristic provenance of entries
        self._spec: dict[tuple[int, int], object] = {}  # speculative-trace cache
        self.dtab: dict[int, dict[int, int]] = {b: {} for b in range(self.nbanks)}  # data pointer words
        self.dlabels: dict[int, dict[int, str]] = {b: {} for b in range(self.nbanks)}
        self.notes: dict[tuple[int, int], str] = {}  # config/annotations.json, by (bank, address)
        self.names: dict[tuple[int, int], dict] = {}  # config/names.json: evidence-backed routine names
        self.families: list[dict] = []  # config/name_families.json: names for copies of library routines
        self.text_enabled = True  # render prose runs as db strings (--no-text turns it off)
        self._text_runs: dict[int, list[tuple[int, int]]] = {}
        self.alias: dict[tuple[int, int], str] = {}  # address name kept as an alias after a rename
        self.dalias: dict[tuple[int, int], str] = {}  # the same for data labels
        self.streams: dict[tuple[int, int], tuple[int, int]] = {}  # (bank, addr) -> (decompressed, compressed)
        self.symbols: dict[int, dict] = {}  # config/symbols.json: evidence-named RAM addresses
        self.ram_used: dict[int, str] = {}  # RAM address -> symbol name used in the source
        self.schemas: list[dict] = []  # config/tables.json
        self.table_at: dict[tuple[int, int], dict] = {}  # (bank, addr) -> prepared schema
        self.track_at: dict[tuple[int, int], dict] = {}  # (bank, addr) -> decoded sound track region
        self.pdata: dict[int, set[int]] = {b: set() for b in range(self.nbanks)}
        self.vetoed = 0  # heuristic candidates rejected by data-pointer evidence
        self.dreason: dict[tuple[int, int], str] = {}  # why a Data_ label exists
        self.dref: dict[tuple[int, int], tuple[int, int]] = {}  # (bank, insn addr) -> (bank, ptr)

    @staticmethod
    def base(bank: int) -> int:
        return 0 if bank == 0 else 0x4000

    def resolve(self, cur: int, addr: int):
        """(bank, addr) a CPU address refers to when executing in `cur`; None if not ROM."""
        if addr < 0x4000:
            return 0, addr
        if addr < 0x8000:
            return cur, addr
        return None

    def add_entry(self, bank: int, addr: int, name: str, why: str | None = None) -> None:
        if bank in self.zero or not (0 <= bank < self.nbanks):
            return
        lo = self.base(bank)
        if not (lo <= addr < lo + BANK):
            return
        if addr not in self.insn[bank] and addr not in self.pending[bank]:
            self.pending[bank].append(addr)
            if why:
                self.reason.setdefault((bank, addr), why)
        cur = self.labels[bank].get(addr, "")
        if not cur or (name == "Func" and not cur.startswith("Func")):
            self.labels[bank][addr] = f"{name}_{bank:03X}_{addr:04X}"

    def trace_pending(self) -> bool:
        did = False
        for bank in range(self.nbanks):
            while self.pending[bank]:
                did = True
                self.trace_from(bank, self.pending[bank].pop())
        return did

    def trace_from(self, bank: int, pc: int) -> None:
        base = self.base(bank)
        rom = self.data[bank * BANK:(bank + 1) * BANK]
        ins, cov = self.insn[bank], self.covered[bank]
        recent: list[str] = []
        while base <= pc < base + BANK:
            if pc in ins:
                return
            n, text, kind, tgt = decode(rom, pc - base, pc)
            if kind == "bad" or (pc - base) + n > BANK or any((pc + i) in cov for i in range(n)):
                return
            ins[pc] = (n, text, kind, tgt)
            cov.update(range(pc, pc + n))
            if kind in ("jr", "jrc", "jp", "jpc", "call", "callc"):
                r = self.resolve(bank, tgt)
                if r:
                    self.add_entry(r[0], r[1], "Func" if kind.startswith("call") else "Jump")
            recent = (recent + [text])[-8:]
            if kind == "rst" and tgt == 0x10:
                hl = next((int(m.group(1), 16) for t in reversed(recent[:-1])
                           if (m := LD_HL.match(t))), None)
                b = next((int(m.group(1), 16) for t in reversed(recent[:-1])
                          if (m := LD_B.match(t))), None)
                if hl is not None and b is not None and hl >= 0x4000 and hl < 0x8000:
                    self.add_entry(b, hl, "Func")
            if kind == "call" and tgt == 0x0010:
                hl = next((int(m.group(1), 16) for t in reversed(recent[:-1])
                           if (m := LD_HL.match(t))), None)
                b = next((int(m.group(1), 16) for t in reversed(recent[:-1])
                          if (m := LD_B.match(t))), None)
                if hl is not None and b is not None and 0x4000 <= hl < 0x8000:
                    self.add_entry(b, hl, "Func")
            if kind == "rst" and tgt == 0x00:
                self.tables.append((bank, pc + 1))
                return
            if kind in ("jr", "jp", "ret", "jphl"):
                return
            pc += n

    def parse_tables(self) -> bool:
        did = False
        todo, self.tables = self.tables, []
        for bank, start in todo:
            if start in self.insn[bank] or start in self.covered[bank]:
                continue
            base = self.base(bank)
            rom = self.data[bank * BANK:(bank + 1) * BANK]
            cov = self.covered[bank]
            pos, words, floor = start, [], None
            while len(words) < MAX_TABLE and pos + 2 <= base + BANK:
                if pos in cov or pos + 1 in cov or (floor is not None and pos >= floor):
                    break
                w = rom[pos - base] | (rom[pos - base + 1] << 8)
                r = self.resolve(bank, w)
                if not r or w < 0x0100:
                    break
                tb, ta = r
                if tb in self.zero or not (self.base(tb) <= ta < self.base(tb) + BANK):
                    break
                if tb == bank and ta > start:
                    floor = ta if floor is None else min(floor, ta)
                words.append((pos, w, r))
                pos += 2
            if not words:
                continue
            did = True
            for p, w, (tb, ta) in words:
                self.insn[bank][p] = ("dw", w)
                cov.update((p, p + 1))
                self.add_entry(tb, ta, "Jump")
        return did

    # ---- heuristic discovery (C0: plausibility, not proof) ---------------
    def spec_trace(self, bank: int, start: int):
        """Trace from `start` without mutating state. Return {addr: insn} if the flow is
        internally consistent (valid opcodes, no overlap with known bytes, in-ROM
        targets), else None."""
        key = (bank, start)
        if key in self._spec:
            return self._spec[key]
        self._spec[key] = r = self._spec_trace(bank, start)
        return r

    def _spec_trace(self, bank: int, start: int):
        """Speculative flow from (bank, start). Calls/jumps into bank 0 that are not yet
        traced are followed too: bank 0 is always mapped, so a transfer there from another
        bank is evidence that code starts at that address. Result keys are (bank, addr)."""
        new: dict[tuple[int, int], tuple] = {}
        ncov: dict[int, set[int]] = {}
        work = [(bank, start)]
        while work:
            cb, pc = work.pop()
            base = self.base(cb)
            rb = self.data[cb * BANK:(cb + 1) * BANK]
            cov, ins = self.covered[cb], self.insn[cb]
            nc = ncov.setdefault(cb, set())
            while True:
                if pc in ins or (cb, pc) in new:
                    break
                if not (base <= pc < base + BANK):
                    return None
                n, t, k, tg = decode(rb, pc - base, pc)
                if k == "bad" or (pc - base) + n > BANK:
                    return None
                rng = range(pc, pc + n)
                if any(x in cov or x in nc for x in rng):
                    return None
                new[(cb, pc)] = (n, t, k, tg)
                nc.update(rng)
                if len(new) > 3000:
                    return None
                if tg is not None and k in ("jr", "jrc", "jp", "jpc", "call", "callc"):
                    r = self.resolve(cb, tg)
                    if r is None:
                        if not (0xFF80 <= tg <= 0xFFFE):
                            return None
                    elif r[0] == cb:
                        if not (base <= tg < base + BANK) or (tg in cov and tg not in ins):
                            return None
                        work.append((cb, tg))
                    else:  # r[0] == 0: ROM0 target from a switchable bank
                        c0 = self.covered[0]
                        if tg in c0 and tg not in self.insn[0]:
                            return None
                        if tg not in self.insn[0]:
                            work.append((0, tg))
                if k in ("jr", "jp", "ret", "jphl"):
                    break
                if k == "rst" and tg == 0:
                    break  # inline word table follows; the main tracer parses it
                pc += n
        return new

    @staticmethod
    def plausible(tr: dict, first_bytes: bytes) -> bool:
        """Cheap code-likeness gate for a clean speculative trace."""
        if tr is None or len(tr) < 4 or first_bytes[:1] in (b"\x00", b"\xff"):
            return False
        ops = list(tr.values())
        n = len(ops)
        regreg = sum(1 for o in ops if o[1].startswith("ld ") and
                     re.fullmatch(r"ld [bcdehla], [bcdehla]", o[1]))
        nops = sum(1 for o in ops if o[1] == "nop")
        struct = sum(1 for o in ops if o[2] in ("ret", "call", "callc", "jp", "jpc", "jr", "jrc", "jphl"))
        words = [first_bytes[i] | (first_bytes[i + 1] << 8) for i in range(0, min(len(first_bytes), 16) - 1, 2)]
        tablelike = len(words) >= 6 and sum(0x4000 <= w < 0x8000 for w in words) >= 0.75 * len(words)
        return regreg <= 0.25 * n and nops <= 0.2 * n and struct >= 1 and not tablelike

    def banked_call_args(self) -> dict[tuple[int, int], tuple[int, int]]:
        """`ld hl, ADDR` loads that feed a banked code call (`rst $10` / `call $0010`).

        Returns {(bank, address of the ld hl): (target bank from the nearby `ld b`, ADDR)}.
        These are CODE pointers into the bank named by `ld b`, not data pointers into the
        caller's bank, so they must not be labelled or counted as same-bank data."""
        ld_hl = re.compile(r"ld hl, \$([0-9A-F]{4})$")
        ld_b = re.compile(r"ld b, \$([0-9A-F]{2})$")
        out: dict[tuple[int, int], tuple[int, int]] = {}
        for bank in range(self.nbanks):
            ins = self.insn[bank]
            order = sorted(a for a, v in ins.items() if v[0] != "dw")
            for k, a in enumerate(order):
                n, text, kind, tgt = ins[a]
                if not ((kind == "rst" and tgt == 0x10) or (kind == "call" and tgt == 0x0010)):
                    continue
                hl = bnk = None
                for x in reversed(order[max(0, k - 8):k]):
                    if ins[x][2] in SETUP_BARRIER:
                        break  # an earlier call or function: its loads are not this call's arguments
                    if hl is None:
                        m = ld_hl.match(ins[x][1])
                        if m:
                            hl = (x, int(m.group(1), 16))
                    if bnk is None:
                        m = ld_b.match(ins[x][1])
                        if m:
                            bnk = int(m.group(1), 16)
                if hl is not None and bnk is not None and 0x4000 <= hl[1] < 0x8000:
                    out[(bank, hl[0])] = (bnk, hl[1])
        return out

    def _interior_bytes(self) -> dict[int, set[int]]:
        """Per bank, addresses that lie strictly inside a decoded instruction or table word."""
        out: dict[int, set[int]] = {}
        for bank in range(self.nbanks):
            s: set[int] = set()
            for a, v in self.insn[bank].items():
                n = 2 if v[0] == "dw" else v[0]
                s.update(range(a + 1, a + n))
            out[bank] = s
        return out

    def bank_variable_pairs(self, code_args, interior):
        """Find WRAM bytes that behave as a data-bank selector (C1, statistical).

        Pattern: `ld a, N` / `ld [$Cxxx|$Dxxx], a`, then `ld hl|de|bc, $4000-$7FFF` within the
        next 8 instructions. A variable qualifies when >= 20 such pairs exist and pairing the
        pointer with bank N lands inside already-decoded code far less often (<= 20% and
        <= half) than assuming the caller's own bank. Returns ({(bank, ld address): (N, ptr,
        var)}, [var...])."""
        lda = re.compile(r"ld a, \$([0-9A-F]{2})$")
        st = re.compile(r"ld \[\$([CD][0-9A-F]{3})\], a$")
        ld16 = re.compile(r"ld (?:hl|de|bc), \$([0-9A-F]{4})$")
        pairs: dict[str, list[tuple[int, int, int, int]]] = {}
        for bank in range(1, self.nbanks):
            ins = self.insn[bank]
            order = sorted(a for a, v in ins.items() if v[0] != "dw")
            for k, a in enumerate(order):
                m = st.match(ins[a][1])
                if not m:
                    continue
                n_val = None
                for x in reversed(order[max(0, k - 3):k]):
                    ma = lda.match(ins[x][1])
                    if ma:
                        n_val = int(ma.group(1), 16)
                        break
                    if ins[x][2] in ("ret", "jp", "jr", "call"):
                        break
                if n_val is None or not 1 <= n_val < self.nbanks or n_val in self.zero:
                    continue
                for y in order[k + 1:k + 9]:
                    if ins[y][2] in ("ret", "jp", "jr"):
                        break
                    if (bank, y) in code_args:
                        continue
                    ml = ld16.match(ins[y][1])
                    if ml and 0x4000 <= int(ml.group(1), 16) < 0x8000:
                        pairs.setdefault(m.group(1), []).append((bank, y, n_val, int(ml.group(1), 16)))

        def in_code(b: int, x: int) -> bool:
            return x in interior[b] or x in self.insn[b]

        chosen, out = [], {}
        for var, lst in pairs.items():
            if len(lst) < 20:
                continue
            in_n = sum(1 for _, _, n_val, p in lst if in_code(n_val, p))
            in_s = sum(1 for b, _, _, p in lst if in_code(b, p))
            if in_n <= 0.2 * len(lst) and in_n * 2 <= in_s:
                chosen.append(f"${var} ({len(lst)} pairs: {100 * in_n // len(lst)}% in code if N is the bank, "
                              f"{100 * in_s // len(lst)}% if same bank)")
                for b, y, n_val, p in lst:
                    out[(b, y)] = (n_val, p, var)
        return out, chosen

    def snapshot_data_pointers(self) -> None:
        """Record `ld hl|de|bc, $4000-$7FFF` targets of the directly traced (non-heuristic)
        code, per bank (same bank assumed). Taken once, before any heuristic runs, so
        bogus heuristic code cannot veto good code."""
        ld16 = re.compile(r"ld (?:hl|de|bc), \$([0-9A-F]{4})$")
        code_args = self.banked_call_args()  # code pointers into another bank, not data
        for bank in range(1, self.nbanks):
            for a, v in self.insn[bank].items():
                if v[0] != "dw" and (bank, a) not in code_args:
                    m = ld16.match(v[1])
                    if m and 0x4000 <= int(m.group(1), 16) < 0x8000:
                        self.pdata[bank].add(int(m.group(1), 16))
        log(f"data-pointer evidence: {sum(len(s) for s in self.pdata.values())} targets "
            f"from directly traced code")

    def contradicted(self, bank: int, tr: dict) -> bool:
        """True if a data pointer targets the interior of one of the candidate's instructions."""
        pd = self.pdata[bank]
        if not pd:
            return False
        interior: set[int] = set()
        for (cb, pc), v in tr.items():
            if cb == bank:
                interior.update(range(pc + 1, pc + v[0]))
        return bool(pd & interior)

    def accept(self, bank: int, start: int) -> bool:
        base = self.base(bank)
        tr = self.spec_trace(bank, start)
        fb = self.data[bank * BANK + start - base:bank * BANK + start - base + 16]
        if not self.plausible(tr, fb):
            return False
        if self.contradicted(bank, tr):
            self.vetoed += 1
            return False
        return True

    def discover_fallthrough(self) -> bool:
        """Cheap pass: queue plausible code that starts right after known code or a table."""
        did = False
        examined = accepted = 0
        for bank in range(self.nbanks):
            if bank in self.zero:
                continue
            base = self.base(bank)
            ins, cov = self.insn[bank], self.covered[bank]
            cands = set()
            if bank != 0 and base + 1 not in cov:  # byte $4000 is the bank's own number
                cands.add(base + 1)
            for a, v in ins.items():
                nxt = a + 2 if v[0] == "dw" else (a + v[0] if v[2] in ("jr", "jp", "ret", "jphl") else None)
                if nxt is not None and nxt < base + BANK and nxt not in cov:
                    cands.add(nxt)
            for c in sorted(cands):
                examined += 1
                if self.accept(bank, c):
                    self.add_entry(bank, c, "Func", "heuristic: follows a terminator")
                    accepted += 1
                    did = True
        log(f"  (a) fall-through: {examined} examined, {accepted} accepted")
        return did

    def discover_tables(self) -> bool:
        """Slow pass (~45 s): runs of >=4 consecutive in-ROM words whose targets all look like code."""
        did = False
        tables = tentries = 0
        for bank in range(self.nbanks):
            if bank in self.zero:
                continue
            if bank % 8 == 0:
                log(f"  (b) pointer-table scan: bank {bank:02X}, {tables} tables, "
                    f"{tentries} entries, spec cache {len(self._spec)}")
            base = self.base(bank)
            cov = self.covered[bank]
            rb = self.data[bank * BANK:(bank + 1) * BANK]
            p = base
            while p + 2 <= base + BANK:
                run = []
                q = p
                while q + 2 <= base + BANK and q not in cov and q + 1 not in cov:
                    w = rb[q - base] | (rb[q - base + 1] << 8)
                    r = self.resolve(bank, w)
                    if w < 0x0100 or not r or r[0] in self.zero:
                        break
                    tb, ta = r
                    if not (self.base(tb) <= ta < self.base(tb) + BANK) or not self.accept(tb, ta):
                        break
                    run.append((q, w, tb, ta))
                    q += 2
                if len(run) >= 4:
                    for qa, w, tb, ta in run:
                        self.insn[bank][qa] = ("dw", w)
                        cov.update((qa, qa + 1))
                        self.add_entry(tb, ta, "Func", "heuristic: target of a pointer table")
                    tables += 1
                    tentries += len(run)
                    did = True
                    p = q
                else:
                    p += 1
        log(f"  (b) done: {tables} tables, {tentries} entries")
        return did

    def structure_data(self) -> None:
        """Find monotone in-bank pointer tables in untraced bytes (C1 structure, not meaning).

        A chain is >= 8 pointers at a fixed stride (2..6 bytes) whose values never decrease
        (>= 4 distinct), lie in $4000-$7FFF, and do not point before the table's own start
        into untraced bytes. Pointing into the table itself is allowed: a multi-level index
        has sub-table pointers inside its first words (bank $08, $4032). Random data does
        not do this; compressed-asset indexes, far-pointer records and word tables do.
        Only labels and `dw` lines change, never bytes."""
        tables = entries = dropped = selfptr = 0
        for bank in range(1, self.nbanks):
            if bank in self.zero:
                continue
            chains: list[list[tuple[int, int]]] = []
            cov, dt = self.covered[bank], self.dtab[bank]
            rb = self.data[bank * BANK:(bank + 1) * BANK]
            end = 0x4000 + BANK
            p = 0x4000
            while p + 1 < end:
                if p in cov or p + 1 in cov:
                    p += 1
                    continue
                best: list[tuple[int, int]] = []
                for stride in (2, 3, 4, 5, 6):
                    chain, q, prev = [], p, 0
                    while q + 1 < end and q not in cov and q + 1 not in cov:
                        w = rb[q - 0x4000] | (rb[q - 0x4000 + 1] << 8)
                        if not (0x4000 <= w < 0x8000) or w < prev:
                            break
                        chain.append((q, w))
                        prev = w
                        q += stride
                    if len(chain) > len(best):
                        best = chain
                if (len(best) >= 8 and best[0][1] >= best[0][0]
                        and len({w for _, w in best}) >= 4
                        and all(w not in cov for _, w in best)):
                    chains.append(best)
                    p = best[-1][0] + 2
                else:
                    p += 1
            # A target on the second byte of another table's `dw` cannot carry a label;
            # drop those tables rather than emit a symbol that is never defined.
            mid = {q + 1 for ch in chains for q, _ in ch}
            for ch in chains:
                if any(w in mid for _, w in ch):
                    dropped += 1
                    continue
                for q, w in ch:
                    dt[q] = w
                    self.dlabels[bank].setdefault(w, f"Data_{bank:03X}_{w:04X}")
                tables += 1
                entries += len(ch)
                selfptr += ch[0][1] < ch[-1][0] + 2  # first target lies inside the table itself
        log(f"data structure: {tables} monotone pointer tables ({selfptr} self-pointing), "
            f"{entries} pointers, {dropped} dropped (targets inside another table)")

    def find_compressed_assets(self) -> None:
        """Mark pointer-table targets that parse as the game's compressed-asset format (C1).

        A target is a stream when the decompressor (tools/lzss_gfx.py, cross-checked against
        the emulated game, E-0016) runs on it without reading unwritten output, produces
        1..$4000 bytes and stays inside the bank. A table counts as an asset index only when
        >= 8 distinct targets exist and >= 60% of them parse; such a miss rate is far above
        what random data gives, and in real indexes each stream usually ends exactly where
        the next target begins. Only comments change; no bytes."""
        def parse(bank: int, addr: int):
            fo = bank * BANK + addr - 0x4000
            try:
                size = self.data[fo] | (self.data[fo + 1] << 8)
                if not 1 <= size <= 0x4000:
                    return None
                out, used, ev = lzss_decompress(self.data, bank, addr)
            except IndexError:
                return None
            if ev["unwritten_reads"] or addr - 0x4000 + used > BANK:
                return None
            return len(out), used

        tables = streams = exact = 0
        for bank in range(1, self.nbanks):
            keys = sorted(self.dtab[bank])
            i = 0
            while i < len(keys):
                j = i
                while j + 1 < len(keys) and 2 <= keys[j + 1] - keys[j] <= 6 and (
                        j == i or keys[j + 1] - keys[j] == keys[i + 1] - keys[i]):
                    j += 1
                run, i = keys[i:j + 1], j + 1
                targets = sorted({self.dtab[bank][k] for k in run})
                if len(run) < 8 or len(targets) < 8:
                    continue
                found = {t: parse(bank, t) for t in targets}
                ok = [t for t in targets if found[t]]
                if len(ok) < 0.6 * len(targets):
                    continue
                tables += 1
                for n, t in enumerate(targets):
                    if found[t]:
                        self.streams[(bank, t)] = found[t]
                        streams += 1
                        if n + 1 < len(targets) and t + found[t][1] == targets[n + 1]:
                            exact += 1
        log(f"compressed assets: {streams} streams in {tables} index tables "
            f"({exact} end exactly where the next target begins)")
        # Second source: literal arguments of calls to the decompress routines (b = bank,
        # de = stream), which no pointer table need mention.
        entries = self._decompress_entries()
        ld_de = re.compile(r"ld de, \$([0-9A-F]{4})$")
        ld_b = re.compile(r"ld b, \$([0-9A-F]{2})$")
        calls = literal = added = 0
        for bank in range(self.nbanks):
            ins = self.insn[bank]
            order = sorted(a for a, v in ins.items() if v[0] != "dw")
            for k, a in enumerate(order):
                n, text, kind, tgt = ins[a]
                if kind != "call" or tgt not in entries:
                    continue
                calls += 1
                de = bnk = None
                for x in reversed(order[max(0, k - 10):k]):
                    if ins[x][2] in SETUP_BARRIER:
                        break
                    if de is None and (m := ld_de.match(ins[x][1])):
                        de = int(m.group(1), 16)
                    if bnk is None and (m := ld_b.match(ins[x][1])):
                        bnk = int(m.group(1), 16)
                if de is None or bnk is None or not 0x4000 <= de < 0x8000:
                    continue
                if not 0 < bnk < self.nbanks or bnk in self.zero:
                    continue
                literal += 1
                if (bnk, de) in self.streams or de in self.covered[bnk] or (de - 1) in self.dtab[bnk]:
                    continue
                r = parse(bnk, de)
                if r:
                    self.streams[(bnk, de)] = r
                    self.dlabels[bnk].setdefault(de, f"Data_{bnk:03X}_{de:04X}")
                    self.dreason.setdefault((bnk, de), "stream decompressed by a call to DecompressTo*")
                    added += 1
        log(f"compressed assets from decompress call sites: {calls} calls, {literal} with literal "
            f"arguments, {added} new streams")
        # Third and fourth sources (E-0035): streams the emulated game decompressed
        # (config/observed_streams.json) and runs of six or more back-to-back streams
        # (config/stream_chains.json). Every one is re-checked with the decompressor and skipped
        # when it starts inside decoded code or a structured table.
        in_table = [(t["bank"], t["addr"], t["addr"] + t["count"] * sum(
            2 if f["type"] == "ptr" else f.get("size", 1) for f in t["fields"])) for t in self.schemas]

        def usable(bnk: int, addr: int) -> bool:
            return (0 < bnk < self.nbanks and bnk not in self.zero and 0x4000 <= addr < 0x8000
                    and (bnk, addr) not in self.streams and addr not in self.covered[bnk]
                    and not any(tb == bnk and lo <= addr < hi for tb, lo, hi in in_table))

        def register(bnk: int, addr: int, why: str) -> bool:
            if not usable(bnk, addr):
                return False
            r = parse(bnk, addr)
            if not r:
                return False
            self.streams[(bnk, addr)] = r
            self.dlabels[bnk].setdefault(addr, f"Data_{bnk:03X}_{addr:04X}")
            self.dreason.setdefault((bnk, addr), why)
            return True

        seen_new = chained = 0
        obs_path = ROOT / "config/observed_streams.json"
        if obs_path.exists():
            for key in json.loads(obs_path.read_text(encoding="utf-8"))["streams"]:
                bnk, addr = (int(x, 16) for x in key.split(":"))
                seen_new += register(bnk, addr, "stream decompressed while the game ran on the emulator")
        chain_path = ROOT / "config/stream_chains.json"
        if chain_path.exists():
            for bank_s, runs in json.loads(chain_path.read_text(encoding="utf-8"))["chains"].items():
                for start_s, count in runs:
                    bnk, addr = int(bank_s, 16), int(start_s, 16)
                    for _ in range(count):
                        r = self.streams.get((bnk, addr)) or parse(bnk, addr)
                        if not r:
                            break
                        chained += register(bnk, addr, "stream in a run of back-to-back compressed streams")
                        addr += r[1]
        log(f"compressed assets from emulated runs: {seen_new} new streams; from chains: {chained} new streams")

    def _decompress_entries(self) -> set[int]:
        """Bank-0 addresses of the decompress routines, taken from config/names.json."""
        return {a for (b, a), info in self.names.items() if b == 0 and info["name"].startswith("DecompressTo")}

    def label_data_refs(self) -> None:
        """Resolve `ld hl|de|bc, $4000-$7FFF` in traced code to labelled data starts (C1).

        Strong case: the load is an argument of a call to a bank-0 helper that writes the
        bank register ($2100); the `ld b, BANK` nearby then names the bank. Weak case: a
        bare load in a switchable bank is assumed to point into the same bank. Bank-0
        loads without a helper call are skipped (bank unknown). Only labels, operand
        spelling and blob boundaries change -- the assembled value is identical."""
        ld16 = re.compile(r"ld (hl|de|bc), \$([0-9A-F]{4})$")
        ldb = re.compile(r"ld b, \$([0-9A-F]{2})$")
        helpers = set()
        i0 = self.insn[0]
        order0 = sorted(a for a, v in i0.items() if v[0] != "dw")
        for k, a in enumerate(order0):
            if (0, a) in self.reason or self.labels[0].get(a, "").startswith("Func"):
                if any(i0[x][1] == "ld [$2100], a" for x in order0[k:k + 10]):
                    helpers.add(a)
        strong = weak = coded = 0
        code_args = self.banked_call_args()
        # Banked code calls: the operand names code in the bank given by `ld b`.
        for (bank, a), (tb, imm) in code_args.items():
            if tb < self.nbanks and tb not in self.zero and imm in self.insn[tb] \
                    and self.labels[tb].get(imm):
                self.dref[(bank, a)] = (tb, imm)
                coded += 1
        helpers.discard(0x10)  # the rst $10 handler transfers to code, not data
        helpers |= self._decompress_entries()  # b = bank, de = stream (E-0016)
        interior = self._interior_bytes()
        bv_pairs, bv_vars = self.bank_variable_pairs(code_args, interior)
        for desc in bv_vars:
            log(f"data-bank variable: {desc}")
        # Banks where many pointer loads land inside decoded code cannot be reading their own
        # bank's data (a same-bank pointer into a code-dense bank would hit data, not code);
        # the same-bank guess is withheld there rather than naming data in the wrong bank.
        untrusted = set()
        for bank in range(1, self.nbanks):
            tot = hit = 0
            for a, v in self.insn[bank].items():
                if v[0] == "dw" or (bank, a) in code_args or (bank, a) in bv_pairs:
                    continue
                m = ld16.match(v[1])
                if m and 0x4000 <= int(m.group(2), 16) < 0x8000:
                    tot += 1
                    hit += int(m.group(2), 16) in interior[bank]
            if hit >= 5 and hit >= 0.10 * tot:
                untrusted.add(bank)
        log(f"same-bank pointer guess withheld in {len(untrusted)} banks with high contradiction rate: "
            + " ".join(f"{b:02X}" for b in sorted(untrusted)))
        for bank in range(self.nbanks):
            ins = self.insn[bank]
            order = sorted(a for a, v in ins.items() if v[0] != "dw")
            paired: dict[int, tuple[int, int]] = {}
            for k, a in enumerate(order):
                n, text, kind, tgt = ins[a]
                if kind != "call" or tgt not in helpers:
                    continue
                loads, bnk = [], None
                for x in reversed(order[max(0, k - 8):k]):
                    xt, xk = ins[x][1], ins[x][2]
                    if xk in SETUP_BARRIER:
                        break
                    mb = ldb.match(xt)
                    if mb and bnk is None:
                        bnk = int(mb.group(1), 16)
                    ml = ld16.match(xt)
                    if ml and 0x4000 <= int(ml.group(2), 16) < 0x8000:
                        loads.append((x, int(ml.group(2), 16)))
                if bnk is not None:
                    for x, imm in loads:
                        paired[x] = (bnk, imm)
            for a in order:
                if (bank, a) in code_args:
                    continue  # handled above as a code pointer
                m = ld16.match(ins[a][1])
                if not m:
                    continue
                imm = int(m.group(2), 16)
                if not 0x4000 <= imm < 0x8000:
                    continue
                if a in paired:
                    tb, why = paired[a][0], "argument of a bank-switching copy helper"
                elif (bank, a) in bv_pairs:
                    tb = bv_pairs[(bank, a)][0]
                    why = f"bank from RAM variable ${bv_pairs[(bank, a)][2]}"
                elif bank != 0 and bank not in untrusted:
                    tb, why = bank, "pointer load in the same bank (bank assumed)"
                else:
                    continue
                if tb >= self.nbanks or tb in self.zero:
                    continue
                if not (self.base(tb) <= imm < self.base(tb) + BANK):
                    continue
                if imm in self.insn[tb]:  # points at known code: reuse its label
                    if self.labels[tb].get(imm):
                        self.dref[(bank, a)] = (tb, imm)
                    continue
                if imm in self.covered[tb] or (imm - 1) in self.dtab[tb]:
                    continue  # inside an instruction or the second byte of a table word
                name = f"Data_{tb:03X}_{imm:04X}"
                self.dlabels[tb].setdefault(imm, name)
                self.dreason.setdefault((tb, imm), why)
                self.dref[(bank, a)] = (tb, imm)
                if a in paired or (bank, a) in bv_pairs:
                    strong += 1
                else:
                    weak += 1
        log(f"banked-call operands resolved to code labels: {coded}")
        log(f"data references: {strong} with a bank evidence (helper call or RAM variable), "
            f"{weak} same-bank loads, "
            f"{sum(len(d) for d in self.dlabels.values())} data labels in total")

    # Symbol names have an upper-case letter after their prefix (wC5FC, hFFC6, rLCDC, wDataBank);
    # that keeps register operands such as [hl] from matching.
    _SYM_MEM = re.compile(r"\[([whsr][A-Z][A-Za-z0-9_]*)(?: \+ \$[0-9A-F]+)?\]")
    _SYM_PTR = re.compile(r"^ld (?:hl|de|bc), ([whs][A-Z][A-Za-z0-9_]*)$")

    def build_xrefs(self) -> None:
        """Static cross-references: who calls each routine, and which RAM it touches.

        Call sites are `call`/`call cc`, plus the far calls the tracer mined (`ld hl, X` /
        `ld b, BANK` / `rst $10`). RAM use follows a routine's own jumps and branches to its
        returns, never into callees, and lists only absolute symbols (no pointer arithmetic)."""
        self.callers: dict[tuple[int, int], list[tuple[int, int]]] = {}
        for b in range(self.nbanks):
            for a, v in self.insn[b].items():
                if v[0] != "dw" and v[2] in ("call", "callc") and v[3] is not None:
                    r = self.resolve(b, v[3])
                    if r:
                        self.callers.setdefault(r, []).append((b, a))
        for (b, a), (tb, imm) in self.banked_call_args().items():
            self.callers.setdefault((tb, imm), []).append((b, a))
        self.entries: dict[int, list[int]] = {}
        for b in range(self.nbanks):
            self.entries[b] = sorted(
                a for a in self.labels[b]
                if a in self.insn[b] and (self.labels[b][a].startswith("Func_") or (b, a) in self.alias))
        self.ram_use: dict[tuple[int, int], tuple[list[str], list[str], list[str]]] = {}
        for b in range(self.nbanks):
            ins = self.insn[b]
            for e in self.entries[b]:
                reads: dict[str, None] = {}
                writes: dict[str, None] = {}
                ptrs: dict[str, None] = {}
                seen, work = set(), [e]
                while work and len(seen) < 400:
                    pc = work.pop()
                    while pc in ins and pc not in seen and ins[pc][0] != "dw":
                        seen.add(pc)
                        n, text, kind, tgt = ins[pc]
                        s = self.symbolize(text)
                        m = self._SYM_MEM.search(s)
                        if m:
                            if s.startswith(("ld [", "ldh [")):
                                writes[m.group(1)] = None
                            elif s.startswith(("ld a, [", "ldh a, [")):
                                reads[m.group(1)] = None
                        m = self._SYM_PTR.match(s)
                        if m:
                            ptrs[m.group(1)] = None
                        if kind in ("jr", "jrc", "jp", "jpc") and tgt is not None:
                            r = self.resolve(b, tgt)
                            if r and r[0] == b and tgt in ins:
                                work.append(tgt)
                        if kind in ("ret", "jp", "jr", "jphl") or (kind == "rst" and tgt == 0):
                            break
                        pc += n
                self.ram_use[(b, e)] = (list(reads), list(writes), list(ptrs))

    def xref_lines(self, bank: int, addr: int) -> list[str]:
        out = []
        calls = self.callers.get((bank, addr), [])
        if calls:
            names = []
            for cb, ca in calls:
                ents = self.entries[cb]
                k = bisect.bisect_right(ents, ca) - 1
                names.append(self.labels[cb].get(ents[k], "?") if k >= 0 else "?")
            uniq = list(dict.fromkeys(names))
            eg = ", ".join(uniq[:4]) + (", ..." if len(uniq) > 4 else "")
            out.append(f"; {len(calls)} call site{'s' if len(calls) != 1 else ''} from "
                       f"{len(uniq)} routine{'s' if len(uniq) != 1 else ''} (e.g. {eg})")
        else:
            out.append("; no direct call (reached through a table, a jump or a vector)")
        r, w, p = self.ram_use.get((bank, addr), ([], [], []))
        for label, items in (("reads", r), ("writes", w), ("points at", p)):
            if items:
                out.append(f"; {label}: " + ", ".join(items[:8]) + (", ..." if len(items) > 8 else ""))
        return out

    def routine_extent(self, bank: int, addr: int) -> int | None:
        """Length in bytes of the self-contained routine at `addr`, or None.

        The routine ends at the first `ret` or `jp` that no forward branch in it jumps past. Its
        bytes mean the same in every bank when every branch stays inside them, and every call or
        jump that leaves them lands in bank 0 (fixed in every bank) or is a restart. A call or
        jump into the switchable window would reach different code in another bank."""
        ins, pc, far, start = self.insn[bank], addr, addr, addr
        while pc in ins and not isinstance(ins[pc][0], str) and pc - start < 400:
            n, _text, kind, tgt = ins[pc]
            if kind in ("jphl", "bad"):
                return None
            if kind in ("call", "callc", "jp", "jpc") and tgt >= 0x4000:
                if kind in ("call", "callc") or not start <= tgt < start + 400:
                    return None
                far = max(far, tgt)
            if kind in ("jr", "jrc"):
                if tgt < start:
                    return None
                far = max(far, tgt)
            pc += n
            if kind in ("ret", "jp") and pc > far:
                return pc - start
        return None

    def expand_families(self, families: list[dict]) -> None:
        """Name every function whose bytes equal a family's canonical routine (config/name_families.json).

        The ROM repeats a small library in many banks. A family names one canonical routine; each
        function entry in any bank whose bytes are identical is a copy and gets `Name_BankBB`
        (plain `Name` when it is the only one). Identical bytes with no calls or jumps behave
        identically, so one reading covers every copy."""
        used = {info["name"] for info in self.names.values()}
        for fam in families:
            cb, ca = (int(x, 16) for x in fam["canonical"].split(":"))
            size = self.routine_extent(cb, ca)
            if size is None:
                raise AssertionError(f"family {fam['name']}: {fam['canonical']} is not a leaf routine")
            base = self.base(cb)
            want = self.data[cb * BANK + ca - base:cb * BANK + ca - base + size]
            found = []
            for bank in range(self.nbanks):
                b0 = self.base(bank)
                for addr, label in self.labels[bank].items():
                    if not label.startswith("Func_") or addr not in self.insn[bank]:
                        continue
                    off = bank * BANK + addr - b0
                    if self.data[off:off + size] == want and self.routine_extent(bank, addr) == size:
                        found.append((bank, addr))
            if (cb, ca) not in found:
                raise AssertionError(f"family {fam['name']}: canonical {fam['canonical']} not a function entry")
            for bank, addr in found:
                if (bank, addr) in self.names:
                    raise AssertionError(f"{bank:02X}:{addr:04X} named twice ({fam['name']})")
                name = fam["name"]
                if len(found) > 1:
                    name += f"_Bank{bank:02X}"
                if name in used:
                    name += f"_{addr:04X}"  # another copy or variant in this bank has the name
                used.add(name)
                info = {"name": name, "evidence": fam.get("evidence", "reading")}
                if fam.get("note"):
                    info["note"] = fam["note"] + (
                        f" (the same {size} bytes appear in {len(found)} banks)" if len(found) > 1 else "")
                self.names[(bank, addr)] = info
            log(f"family {fam['name']}: {len(found)} copies of {size} bytes")

    def apply_names(self) -> None:
        """Rename code labels listed in config/names.json; keep the address name as an alias.

        A name must be unique, a valid identifier, and sit on a traced instruction that already
        has a label; anything else raises so a stale entry cannot go unnoticed."""
        seen: set[str] = set()
        for (bank, addr), info in sorted(self.names.items()):
            name = info["name"]
            if not re.fullmatch(r"[A-Za-z_][A-Za-z0-9_]*", name) or name in seen:
                raise AssertionError(f"bad or duplicate name {name!r} at {bank:02X}:{addr:04X}")
            seen.add(name)
            if info.get("data"):
                old = self.dlabels[bank].get(addr)
                if old is None:
                    raise AssertionError(f"{name}: no data label at {bank:02X}:{addr:04X}")
                self.dalias[(bank, addr)] = old
                self.dlabels[bank][addr] = name
                continue
            old = self.labels[bank].get(addr)
            if old is None or addr not in self.insn[bank]:
                raise AssertionError(f"{name}: no traced code label at {bank:02X}:{addr:04X}")
            self.alias[(bank, addr)] = old
            self.labels[bank][addr] = name
        log(f"routines renamed from config/names.json: {len(self.names)}")

    def _u16(self, bank: int, addr: int) -> int:
        o = bank * BANK + (addr - self.base(bank))
        return self.data[o] | (self.data[o + 1] << 8)

    def prepare_tables(self) -> None:
        """Validate config/tables.json against the ROM and register data labels for their
        pointer targets. Raises if a layout overlaps code or an existing label would fall in
        the middle of a field (it could not be emitted)."""
        for t in self.schemas:
            bank, addr, count = t["bank"], t["addr"], t["count"]
            fields = t["fields"]
            sizes = [2 if f["type"] == "ptr" else f.get("size", 1) for f in fields]
            stride = sum(sizes)
            end = addr + stride * count
            cov, dt, dl = self.covered[bank], self.dtab[bank], self.dlabels[bank]
            if any(a in cov for a in range(addr, end)):
                raise AssertionError(f"table {t['label']} overlaps decoded code")
            bounds = set()
            for i in range(count):
                p = addr + i * stride
                for sz in sizes:
                    bounds.add(p)
                    p += sz
            for a in list(dl):
                if addr < a < end and a not in bounds:
                    raise AssertionError(f"label {dl[a]} falls inside a field of table {t['label']}")
            for k in [k for k in dt if addr <= k < end]:
                del dt[k]  # the schema emits these bytes
            for i in range(count):
                p = addr + i * stride
                vals, q = [], p
                for f, sz in zip(fields, sizes):  # read the whole record first
                    o = bank * BANK + (q - self.base(bank))
                    vals.append(self._u16(bank, q) if f["type"] == "ptr" else self.data[o])
                    q += sz
                for fi, f in enumerate(fields):
                    if f["type"] != "ptr":
                        continue
                    tb = vals[f["bank_from"]] if "bank_from" in f else bank
                    tgt = vals[fi]
                    if tb in range(self.nbanks) and tb not in self.zero and \
                            self.base(tb) <= tgt < self.base(tb) + BANK and tgt not in self.covered[tb] \
                            and not (tb == bank and addr <= tgt < end):
                        self.dlabels[tb].setdefault(tgt, f"Data_{tb:03X}_{tgt:04X}")
                        self.dreason.setdefault((tb, tgt), f.get("reason", "pointer in a sound table"))
            self.table_at[(bank, addr)] = dict(t, stride=stride, end=end, sizes=sizes)
        log(f"structured tables: {len(self.table_at)} ({sum(t['count'] for t in self.schemas)} records)")

    def prepare_tracks(self) -> None:
        """Decode the sound track regions named by tables flagged "tracks" (E-0019).

        Regions run from one track pointer to the next; a region is used only if it decodes
        in alignment (every event whole, last event ending exactly at the next pointer) and
        every existing label inside it falls on an event boundary. The last track of a bank
        has no known end and is left as data."""
        used = skipped = 0
        for t in self.schemas:
            if not t.get("tracks"):
                continue
            bank, addr, count = t["bank"], t["addr"], t["count"]
            ptrs = sorted({self._u16(bank, addr + 4 * i + 2) for i in range(count)})
            bd = self.data[bank * BANK:(bank + 1) * BANK]
            dt, dl = self.dtab[bank], self.dlabels[bank]
            for p, nxt in zip(ptrs, ptrs[1:]):
                evs = decode_region(bd, p - 0x4000, nxt - 0x4000)
                if evs is None:
                    skipped += 1
                    continue
                bounds = {p, nxt} | {0x4000 + e["off"] for e in evs}
                if any(p < a < nxt and a not in bounds for a in dl) or                         any(a in self.covered[bank] for a in range(p, nxt)):
                    skipped += 1
                    continue
                for k in [k for k in dt if p <= k < nxt]:
                    del dt[k]
                self.track_at[(bank, p)] = {"events": evs, "end": nxt, "header": decode_header(bd, p - 0x4000)}
                used += 1
        log(f"sound tracks emitted as events: {used} (skipped {skipped}; "
            f"{sum(len(v['events']) for v in self.track_at.values())} events)")

    def emit_track(self, bank: int, p: int, tr: dict, out: list[str]) -> None:
        dl = self.dlabels[bank]
        h = tr["header"]
        out.append("")
        out.append(f"; sound track, {len(tr['events'])} events after the header (E-0019: grammar C2, meaning C0)")
        if p in dl:
            out.append(f"{dl[p]}:: ; heuristic: {self.dreason.get((bank, p), 'sound track')}; C0")
            if (bank, p) in self.dalias:
                out.append(f"{self.dalias[(bank, p)]}:: ; address name")
        out.append("    db " + ", ".join(f"${v:02X}" for v in h["bytes"]) + f" ; header: {h['text'][7:]}")
        for ev in tr["events"]:
            a = 0x4000 + ev["off"]
            if a in dl:
                out.append(f"{dl[a]}:: ; heuristic: {self.dreason.get((bank, a), 'inside a sound track')}; C0")
            if ev["b1"] is None:
                out.append(f"    db ${ev['b0']:02X} ; {ev['text']}")
            elif ev["kind"] == "call":
                out.append(f"    db ${ev['b0']:02X}, ${ev['b1']:02X} ; {ev['text'].split(' ->')[0]}")
                out.append(f"    dw ${ev['target']:04X} ; byte offset of the called section from the track start")
            else:
                out.append(f"    db ${ev['b0']:02X}, ${ev['b1']:02X} ; {ev['text']}")

    def emit_table(self, bank: int, t: dict, out: list[str]) -> None:
        """Emit a schema table: one record per entry, `db` runs and `dw` pointers."""
        dl = self.dlabels[bank]
        fields, sizes, stride = t["fields"], t["sizes"], t["stride"]
        out.append("")
        out.append(f"; {t['note']}")
        out.append("; record: " + "; ".join(f["name"] for f in fields))
        out.append(f"{t['label']}::")
        for i in range(t["count"]):
            p = t["addr"] + i * stride
            vals, raws, q = [], [], p
            for f in fields:
                o = bank * BANK + (q - self.base(bank))
                vals.append(self._u16(bank, q) if f["type"] == "ptr" else self.data[o])
                raws.append(list(self.data[o:o + f.get("size", 1)]))  # every byte of a db field
                q += 2 if f["type"] == "ptr" else f.get("size", 1)
            tag = f" ; id {t['id_base'] + i}" if "id_base" in t else f" ; entry {i}"
            run: list[int] = []
            tagged = False

            def flush() -> None:
                nonlocal tagged
                if run:
                    out.append("    db " + ", ".join(f"${v:02X}" for v in run) + ("" if tagged else tag))
                    tagged = True
                    run.clear()

            q = p
            for fi, (f, sz) in enumerate(zip(fields, sizes)):
                if q in dl:
                    flush()
                    out.append(f"{dl[q]}:: ; heuristic: {self.dreason.get((bank, q), 'label inside a table')}; C0")
                    if (bank, q) in self.dalias:
                        out.append(f"{self.dalias[(bank, q)]}:: ; address name")
                if f["type"] == "ptr":
                    flush()
                    tb = vals[f["bank_from"]] if "bank_from" in f else bank
                    tgt = vals[fi]
                    nm = self.table_at[(tb, tgt)]["label"] if (tb, tgt) in self.table_at else None
                    nm = nm or self.dlabels.get(tb, {}).get(tgt)
                    if nm is None and tgt in self.insn.get(tb, {}):
                        nm = self.labels[tb].get(tgt)
                    out.append(f"    dw {nm or f'${tgt:04X}'}" + ("" if tagged else tag))
                    tagged = True
                else:
                    run.extend(raws[fi])
                q += sz
            flush()

    def summary(self) -> str:
        code = sum(v[0] if v[0] != "dw" else 2 for ins in self.insn.values() for v in ins.values())
        banks = sum(1 for ins in self.insn.values() if ins)
        return f"{code} code bytes in {banks} banks, {len(self.reason)} heuristic entries"

    def run(self) -> None:
        for v in VECTORS:
            self.add_entry(0, v, "Func")
        rnd = 0
        while True:
            rnd += 1
            passes = 0
            while True:
                passes += 1
                a = self.trace_pending()
                b = self.parse_tables()
                if not (a or b) and not any(self.pending.values()):
                    break
            log(f"round {rnd}: trace fixpoint after {passes} passes: {self.summary()}")
            if rnd == 1:
                self.snapshot_data_pointers()
            self._spec.clear()
            # Cheap fall-through discovery first (each hit exposes the next function in a
            # chain); the slow pointer-table scan only runs once that is exhausted.
            if self.discover_fallthrough():
                continue
            log(f"round {rnd}: fall-through exhausted; pointer-table scan")
            if not self.discover_tables():
                log(f"round {rnd}: no new entries; analysis complete")
                break
        self.structure_data()
        self.find_compressed_assets()
        self.label_data_refs()
        self.prepare_tables()
        self.prepare_tracks()
        self.expand_families(self.families)
        self.apply_names()
        self.build_xrefs()
        log(f"cross-references: {len(self.callers)} routines are called, "
            f"{sum(len(v) for v in self.callers.values())} call sites")

    # ---- emission -------------------------------------------------------
    def text_runs_for(self, bank: int) -> list[tuple[int, int]]:
        """Prose runs of a bank as absolute CPU address ranges. Bytes already owned by code,
        pointer words, structured tables, sound tracks and compressed streams are masked first,
        so a run never swallows them."""
        if bank in self._text_runs:
            return self._text_runs[bank]
        base = self.base(bank)
        raw = bytearray(self.data[bank * BANK:(bank + 1) * BANK])

        def mask(lo: int, hi: int) -> None:
            for a in range(max(lo, base), min(hi, base + BANK)):
                raw[a - base] = 0xFF

        for a in self.covered[bank]:
            mask(a, a + 1)
        for k in self.dtab[bank]:
            mask(k, k + 2)
        for (b, a), t in self.table_at.items():
            if b == bank:
                mask(a, t["end"])
        for (b, a), tr in self.track_at.items():
            if b == bank:
                mask(a, tr["end"])
        for (b, a), (size, used) in self.streams.items():
            if b == bank:
                mask(a, a + used)
        runs = [(base + s, base + e) for s, e in gb_text.find_text_runs(bytes(raw))]
        self._text_runs[bank] = runs
        return runs

    def emit_text(self, bank: int, lo: int, hi: int, out: list[str]) -> None:
        raw = self.data[bank * BANK + lo - self.base(bank):bank * BANK + hi - self.base(bank)]
        out.append("; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning")
        for line in gb_text.render(raw):
            out.append("    db " + line)

    def emit_gap(self, bank: int, lo: int, hi: int, out: list[str]) -> None:
        """Emit uncovered bytes [lo, hi): prose as readable strings, the rest as opaque data."""
        pos, pieces = lo, []
        if self.text_enabled:
            for s, e in self.text_runs_for(bank):
                cs, ce = max(s, lo), min(e, hi)
                if ce - cs >= 4:
                    if cs > pos:
                        pieces.append((False, pos, cs))
                    pieces.append((True, cs, ce))
                    pos = ce
        if pos < hi:
            pieces.append((False, pos, hi))
        for is_text, a, b in pieces:
            if is_text:
                self.emit_text(bank, a, b, out)
            else:
                self.emit_gap_plain(bank, a, b, out)

    def emit_gap_plain(self, bank: int, lo: int, hi: int, out: list[str]) -> None:
        base = self.base(bank)
        raw = self.data[bank * BANK + lo - base:bank * BANK + hi - base]
        i = 0
        while i < len(raw):
            j = i
            while j < len(raw) and raw[j] == raw[i]:
                j += 1
            if j - i >= 16:
                out.append(f"    ds ${j - i:X}, ${raw[i]:02X}")
                i = j
                continue
            k = i
            # extend until the next >=16-byte uniform run
            while k < len(raw):
                m = k
                while m < len(raw) and raw[m] == raw[k]:
                    m += 1
                if m - k >= 16:
                    break
                k = m
            seg = raw[i:k]
            off = bank * BANK + lo - base + i
            if len(seg) > 64:
                out.append(f'    INCBIN "{ROM_NAME}", ${off:06X}, ${len(seg):X}')
            else:
                for c in range(0, len(seg), 16):
                    out.append("    db " + ", ".join(f"${x:02X}" for x in seg[c:c + 16]))
            i = k

    _FC_HL = re.compile(r"^    ld hl, ([A-Za-z_][A-Za-z0-9_]*)$")
    _FC_B = re.compile(r"^    ld b, \$([0-9A-F]{2})$")

    def _label_banks(self) -> dict[str, int]:
        if not hasattr(self, "_lb"):
            self._lb = {}
            for b in range(self.nbanks):
                for d in (self.labels[b], self.dlabels[b]):
                    for name in d.values():
                        self._lb[name] = b
        return self._lb

    def compress_farcalls(self, out: list[str]) -> list[str]:
        """Rewrite `ld hl, L / ld b, BANK / rst $10` (either load first) as one macro call when
        L is a label in bank BANK. The macros expand to the same three instructions, so the
        bytes do not change; a label or comment between the lines prevents the rewrite."""
        banks = self._label_banks()
        res, i = [], 0
        while i < len(out):
            if i + 2 < len(out) and out[i + 2] == "    rst $10":
                a, b = out[i], out[i + 1]
                m1, m2 = self._FC_HL.match(a), self._FC_B.match(b)
                if m1 and m2 and banks.get(m1.group(1)) == int(m2.group(1), 16):
                    res.append(f"    farcall {m1.group(1)}")
                    i += 3
                    continue
                m1, m2 = self._FC_B.match(a), self._FC_HL.match(b)
                if m1 and m2 and banks.get(m2.group(1)) == int(m1.group(1), 16):
                    res.append(f"    farcall_b {m2.group(1)}")
                    i += 3
                    continue
            res.append(out[i])
            i += 1
        return res

    _MEM = re.compile(r"\[\$([0-9A-F]{4})\]")
    _IMM = re.compile(r"^(ld (?:hl|de|bc|sp), )\$([0-9A-F]{4})$")

    def _ram_symbol(self, addr: int, prefix: str) -> str:
        info = self.symbols.get(addr)
        name = info["name"] if info else f"{prefix}{addr:04X}"
        self.ram_used[addr] = name
        return name

    def sym_name(self, addr: int, pointer: bool) -> str | None:
        """Symbol text for an absolute address, or None to keep it numeric.

        Hardware names are Pan Docs facts; RAM names are address names (wC5FC, hFFC6, sA000)
        unless config/symbols.json supplies an evidence-backed name. MBC registers are only
        ever written, so they are not used for pointer immediates."""
        if 0xFF30 <= addr < 0xFF40:
            return "rWAVE" if addr == 0xFF30 else f"rWAVE + ${addr - 0xFF30:X}"
        if addr in gbs.IO:
            return gbs.IO[addr]
        if not pointer and addr in gbs.MBC:
            return gbs.MBC[addr]
        if not pointer and addr == gbs.BANK_NUMBER_BYTE[1]:
            return gbs.BANK_NUMBER_BYTE[0]
        if 0x8000 <= addr < 0xA000:
            return gbs.vram_expr(addr)
        if 0xA000 <= addr < 0xC000:
            return self._ram_symbol(addr, "s")
        if 0xC000 <= addr < 0xE000:
            return self._ram_symbol(addr, "w")
        if gbs.HRAM_START <= addr <= gbs.HRAM_END:
            return self._ram_symbol(addr, "h")
        return None

    def symbolize(self, text: str, following: tuple[str, ...] = ()) -> str:
        """Replace absolute addresses in memory operands and pointer immediates by symbols.

        `following` holds the next instructions' text: a 16-bit immediate that is then added
        to HL (`add hl, bc`) is arithmetic (for example $FF9C is -100), not a pointer, so it
        stays numeric."""
        m = self._MEM.search(text)
        if m:
            nm = self.sym_name(int(m.group(1), 16), False)
            return text[:m.start()] + "[" + nm + "]" + text[m.end():] if nm else text
        m = self._IMM.match(text)
        if m:
            reg = m.group(1).split()[1].rstrip(",")
            if reg in ("bc", "de") and f"add hl, {reg}" in following and int(m.group(2), 16) >= 0xFF00:
                return text  # a small negative number, not an address
            nm = self.sym_name(int(m.group(2), 16), True)
            if nm:
                return m.group(1) + nm
        return text

    def write_ram_inc(self, path) -> None:
        lines = ["; RAM symbols referenced by the code. Names of the form wXXXX / hXXXX / sXXXX are",
                 "; address names (no meaning claimed); any other name cites its evidence.", ""]
        sections = [("SRAM ($A000-$BFFF)", 0xA000, 0xBFFF), ("WRAM ($C000-$DFFF)", 0xC000, 0xDFFF),
                    ("HRAM ($FF80-$FFFE)", 0xFF80, 0xFFFE)]
        for title, lo, hi in sections:
            used = sorted(a for a in self.ram_used if lo <= a <= hi)
            if not used:
                continue
            lines.append(f"; {title}")
            for a in used:
                info = self.symbols.get(a)
                note = f" ; {info['note']} ({info['evidence']})" if info else ""
                lines.append(f"DEF {self.ram_used[a]} EQU ${a:04X}{note}")
            lines.append("")
        path.write_text("\n".join(lines) + "\n", encoding="utf-8", newline="\n")

    def emit_bank(self, bank: int) -> str:
        hdr = ('SECTION "Bank 00", ROM0[$0000]\n' if bank == 0
               else f'SECTION "Bank {bank:02X}", ROMX[$4000], BANK[${bank:02X}]\n')
        if bank in self.zero:
            return hdr + f"; bank ${bank:02X}: all $00 in the reference\nDS $4000, $00\n"
        base = self.base(bank)
        ins, labels = self.insn[bank], self.labels[bank]
        out: list[str] = []
        dt, dl = self.dtab[bank], self.dlabels[bank]
        pc, end = base, base + BANK
        while pc < end:
            if pc in labels and pc in ins:
                why = self.reason.get((bank, pc))
                note = self.notes.get((bank, pc))
                nm_info = self.names.get((bank, pc))
                out.append("")
                if note:
                    out.append(f"; {note}")
                if nm_info and nm_info.get("note"):
                    out.append(f"; {nm_info['note']}")
                if pc in self.entries.get(bank, ()) and getattr(self, "ram_use", None) is not None:
                    out.extend(self.xref_lines(bank, pc))
                out.append(f"{labels[pc]}::" + (f" ; {why}; C0" if why else ""))
                if (bank, pc) in self.alias:
                    out.append(f"{self.alias[(bank, pc)]}:: ; address name")
            it = ins.get(pc)
            if it is None and (bank, pc) in self.track_at:
                tr = self.track_at[(bank, pc)]
                self.emit_track(bank, pc, tr, out)
                pc = tr["end"]
                continue
            if it is None and (bank, pc) in self.table_at:
                tbl = self.table_at[(bank, pc)]
                self.emit_table(bank, tbl, out)
                pc = tbl["end"]
                continue
            if it is None:
                if pc in dl:
                    why = self.dreason.get((bank, pc), "target of a monotone pointer table")
                    stream = self.streams.get((bank, pc))
                    out.append("")
                    dinfo = self.names.get((bank, pc))
                    if dinfo and dinfo.get("data") and dinfo.get("note"):
                        out.append(f"; {dinfo['note']}")
                    if stream:
                        out.append(f"; LZSS-compressed asset: {stream[1]} bytes expand to {stream[0]} "
                                   f"(tools/lzss_gfx.py, E-0016/E-0017; C1)")
                    out.append(f"{dl[pc]}:: ; heuristic: {why}; C0")
                    if (bank, pc) in self.dalias:
                        out.append(f"{self.dalias[(bank, pc)]}:: ; address name")
                if pc in dt:
                    out.append(f"    dw {dl[dt[pc]]}")
                    pc += 2
                    continue
                q = pc + 1
                while q < end and q not in ins and q not in dt and q not in dl:
                    q += 1
                self.emit_gap(bank, pc, q, out)
                pc = q
                continue
            if it[0] == "dw":
                w = it[1]
                r = self.resolve(bank, w)
                nm = None
                if r and r[0] == bank and w in ins and ins[w][0] != "dw":
                    nm = labels.get(w)
                elif r and r[0] == 0 and w in self.insn[0] and self.insn[0][w][0] != "dw":
                    nm = self.labels[0].get(w)
                out.append(f"    dw {nm or f'${w:04X}'}")
                pc += 2
                continue
            n, text, kind, tgt = it
            ref = self.dref.get((bank, pc))
            if ref:
                rb_, ra = ref
                nm = self.dlabels[rb_].get(ra) or (self.labels[rb_].get(ra) if ra in self.insn[rb_] else None)
                if nm:
                    text = re.sub(r"\$[0-9A-F]{4}$", nm, text)
            if "{T}" in text:
                r = self.resolve(bank, tgt)
                nm = None
                if r and r[0] == bank and tgt in ins:
                    nm = labels.get(tgt)
                elif r and r[0] == 0 and tgt in self.insn[0]:
                    nm = self.labels[0].get(tgt)
                text = text.replace("{T}", nm or f"${tgt:04X}")
            look, q = [], pc + n
            for _ in range(2):
                nx = ins.get(q)
                if nx is None or nx[0] == "dw":
                    break
                look.append(nx[1])
                q += nx[0]
            text = self.symbolize(text, tuple(look))
            if text == "stop":
                out.append(f"    db $10, ${self.data[bank*BANK+pc-base+1]:02X} ; stop")
            else:
                out.append(f"    {text}")
            pc += n
        return hdr + "\n".join(self.compress_farcalls(out)) + "\n"


def main() -> int:
    global _QUIET
    _QUIET = "--quiet" in sys.argv
    log(f"reading {REF}")
    rom = Rom(REF.read_bytes())
    log(f"{rom.nbanks} banks, {len(rom.zero)} all-zero")
    rom.text_enabled = "--no-text" not in sys.argv
    notes_path = ROOT / "config/annotations.json"
    if notes_path.exists():
        for key, text in json.loads(notes_path.read_text(encoding="utf-8")).items():
            if not key.startswith("_"):
                bank_s, addr_s = key.split(":")
                rom.notes[(int(bank_s, 16), int(addr_s, 16))] = text
        log(f"loaded {len(rom.notes)} annotations from {notes_path.name}")
    names_path = ROOT / "config/names.json"
    if names_path.exists():
        for key, info in json.loads(names_path.read_text(encoding="utf-8")).items():
            if not key.startswith("_"):
                bank_s, addr_s = key.split(":")
                rom.names[(int(bank_s, 16), int(addr_s, 16))] = info
        log(f"loaded {len(rom.names)} routine names")
    families_path = ROOT / "config/name_families.json"
    if families_path.exists():
        rom.families = json.loads(families_path.read_text(encoding="utf-8"))["families"]
        log(f"loaded {len(rom.families)} routine families")
    symbols_path = ROOT / "config/symbols.json"
    if symbols_path.exists():
        for key, info in json.loads(symbols_path.read_text(encoding="utf-8")).items():
            if not key.startswith("_"):
                rom.symbols[int(key, 16)] = info
        log(f"loaded {len(rom.symbols)} evidence-named RAM symbols")
    tables_path = ROOT / "config/tables.json"
    if tables_path.exists():
        for t in json.loads(tables_path.read_text(encoding="utf-8"))["tables"]:
            rom.schemas.append(dict(t, bank=int(t["bank"], 16), addr=int(t["addr"], 16)))
        log(f"loaded {len(rom.schemas)} table layouts from {tables_path.name}")
    rom.run()
    if "--export-streams" in sys.argv:
        dest = Path(sys.argv[sys.argv.index("--export-streams") + 1])
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_text(json.dumps(
            [{"bank": b, "addr": a, "compressed": u, "size": s}
             for (b, a), (s, u) in sorted(rom.streams.items())], indent=1), encoding="utf-8")
        log(f"exported {len(rom.streams)} streams to {dest}")
    log("rendering all banks in memory (no files written yet)")
    texts = [rom.emit_bank(b) for b in range(rom.nbanks)]
    texts, folded = fold_idioms(texts)
    log(f"folded idioms: {folded}")
    out = ROOT / "src/banks"
    out.mkdir(parents=True, exist_ok=True)
    log(f"writing {len(texts)} bank files and src/main.asm")
    tot_code = 0
    reached = []
    for b, text in enumerate(texts):
        (out / f"bank{b:02x}.asm").write_text(text, encoding="utf-8", newline="\n")
        code = sum(v[0] if v[0] != "dw" else 2 for v in rom.insn[b].values())
        tot_code += code
        if code:
            reached.append((b, code))
    (ROOT / "src/macros.inc").write_text(MACROS_INC, encoding="utf-8", newline="\n")
    gbs.write_hardware_inc(ROOT / "src/hardware.inc")
    gb_text.write_charmap_inc(ROOT / "src/charmap.inc")
    rom.write_ram_inc(ROOT / "src/ram.asm")
    log(f"symbols: {len(rom.ram_used)} RAM addresses named "
        f"({sum(1 for a in rom.ram_used if a in rom.symbols)} with evidence)")
    (ROOT / "src/main.asm").write_text(
        'INCLUDE "hardware.inc"\nINCLUDE "ram.asm"\nINCLUDE "macros.inc"\nINCLUDE "charmap.inc"\n'
        + "".join(f'INCLUDE "banks/bank{b:02x}.asm"\n' for b in range(rom.nbanks)),
        encoding="utf-8", newline="\n")
    log("done writing; rebuild and verify with tools/build.py")
    if "--stats" in sys.argv:
        nz = rom.nbanks - len(rom.zero)
        print(f"banks with traced code: {len(reached)} of {nz} non-zero banks; "
              f"{tot_code} bytes of {nz*BANK} non-zero-bank bytes", file=sys.stderr)
        print(" ".join(f"{b:02X}:{c}" for b, c in reached), file=sys.stderr)
    return 0


if __name__ == "__main__":
    sys.exit(main())
