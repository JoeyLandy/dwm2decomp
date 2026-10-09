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

Usage: disasm_all.py [--stats] [--quiet] [--export-streams PATH.json]
Progress goes to stderr. All banks are rendered in memory first; src/banks/*.asm
and src/main.asm are written only after the whole analysis succeeds, so an
interrupted run leaves the previous generated tree untouched.
"""
from __future__ import annotations

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
"""


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
                    if ins[x][2] in ("ret", "jp", "jr", "jphl"):
                        break  # previous function; its loads are not this call's arguments
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
                    if xk in ("ret", "jp", "jr", "jphl"):
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
            vals, q = [], p
            for f in fields:
                o = bank * BANK + (q - self.base(bank))
                vals.append(self._u16(bank, q) if f["type"] == "ptr" else self.data[o])
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
                    run.append(vals[fi])
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

    # ---- emission -------------------------------------------------------
    def emit_gap(self, bank: int, lo: int, hi: int, out: list[str]) -> None:
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

    def symbolize(self, text: str) -> str:
        """Replace absolute addresses in memory operands and pointer immediates by symbols."""
        m = self._MEM.search(text)
        if m:
            nm = self.sym_name(int(m.group(1), 16), False)
            return text[:m.start()] + "[" + nm + "]" + text[m.end():] if nm else text
        m = self._IMM.match(text)
        if m:
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
                out.append("")
                if note:
                    out.append(f"; {note}")
                out.append(f"{labels[pc]}::" + (f" ; {why}; C0" if why else ""))
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
                    if stream:
                        out.append(f"; LZSS-compressed asset: {stream[1]} bytes expand to {stream[0]} "
                                   f"(tools/lzss_gfx.py, E-0016/E-0017; C1)")
                    out.append(f"{dl[pc]}:: ; heuristic: {why}; C0")
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
            text = self.symbolize(text)
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
    notes_path = ROOT / "config/annotations.json"
    if notes_path.exists():
        for key, text in json.loads(notes_path.read_text(encoding="utf-8")).items():
            if not key.startswith("_"):
                bank_s, addr_s = key.split(":")
                rom.notes[(int(bank_s, 16), int(addr_s, 16))] = text
        log(f"loaded {len(rom.notes)} annotations from {notes_path.name}")
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
    rom.write_ram_inc(ROOT / "src/ram.asm")
    log(f"symbols: {len(rom.ram_used)} RAM addresses named "
        f"({sum(1 for a in rom.ram_used if a in rom.symbols)} with evidence)")
    (ROOT / "src/main.asm").write_text(
        'INCLUDE "hardware.inc"\nINCLUDE "ram.asm"\nINCLUDE "macros.inc"\n'
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
