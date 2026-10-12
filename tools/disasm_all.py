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
from sound_tracks import decode_event, decode_header, decode_region  # noqa: E402
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
BANK_SUFFIX_RE = re.compile(r"_Bank[0-9A-F]{2}(?:_[0-9A-F]{4})?$")  # a per-bank copy suffix
SUFFIX_RE = re.compile(r"(_(?:Sub|Case|Shared|Table\d*_Case)[0-9A-F]{2})+$")  # helper-name suffixes of a routine name
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

; A far pointer in data: the address, then its ROM bank (E-0141).
MACRO dfar
    dw \\1
    db BANK(\\1)
ENDM

; Event script commands (E-0152). FetchScriptCommand (bank $10) reads one opcode byte and
; the inline bytes of the dedicated opcodes; any other opcode is a command type with no
; inline bytes. Relative targets are forward offsets from the byte after the offset
; (in a db list, @ is the address of the byte being assembled).
MACRO script_end
    db $FF
ENDM

MACRO script_message
    db $00
    dw \\1
ENDM

MACRO script_skip_if_no
    db $06, (\\1) - @ - 1 ; in a db list, @ is the address of the byte being assembled
ENDM

MACRO script_jump
    db $07
    dw \\1
ENDM

MACRO script_set_flag
    db $0A
    dw \\1
ENDM

MACRO script_add_gold
    db $0E
    dw \\1
ENDM

MACRO script_sound
    db $0F, \\1
ENDM

MACRO script_choice_jump
    db $E4
    REPT _NARG
        db (\\1) - @ - 1
        SHIFT
    ENDR
ENDM

MACRO script_jump_data_bank
    db $E7
    dw \\1
ENDM

MACRO script_op
    db \\#
ENDM

MACRO script_command
    db \\1
ENDM

; Map object selectors (E-0163): entries tried in order by LoadMapObjectsForScreen.
MACRO objsel_none
    dw $FFFF
ENDM

MACRO objsel_list
    dw $FFFE, \\1
ENDM

MACRO objsel_unless_flag
    dw \\1, \\2
ENDM

MACRO objsel_unless_flags
    dw $FFFD, \\1, \\2, \\3
ENDM

MACRO objsel_skip_if_clear
    dw $FFFC, \\1
    db \\2, \\3
ENDM

MACRO objsel_skip_if_set
    dw $FFFB, \\1
    db \\2, \\3
ENDM

; 24-bit little-endian values in data (E-0148).
MACRO d24
    REPT _NARG
        db LOW(\\1), HIGH(\\1), LOW((\\1) >> 16)
        SHIFT
    ENDR
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
        self.table_words: dict[tuple[int, int], list[int]] = {}  # inline table -> word addresses
        self.reason: dict[tuple[int, int], str] = {}  # heuristic provenance of entries
        self._spec: dict[tuple[int, int], object] = {}  # speculative-trace cache
        self.dtab: dict[int, dict[int, int]] = {b: {} for b in range(self.nbanks)}  # data pointer words
        self.dlabels: dict[int, dict[int, str]] = {b: {} for b in range(self.nbanks)}
        self.notes: dict[tuple[int, int], str] = {}  # config/annotations.json, by (bank, address)
        self.names: dict[tuple[int, int], dict] = {}  # config/names.json: evidence-backed routine names
        self.dispatch: dict[tuple[int, int], list] = {}  # rst $00 table start -> [(bank, target)]
        self.families: list[dict] = []  # config/name_families.json: names for copies of library routines
        self.text_enabled = True  # render prose runs as db strings (--no-text turns it off)
        self._text_runs: dict[int, list[tuple[int, int]]] = {}
        self.alias: dict[tuple[int, int], str] = {}  # address name kept as an alias after a rename
        self.dalias: dict[tuple[int, int], str] = {}  # the same for data labels
        self.streams: dict[tuple[int, int], tuple[int, int]] = {}  # (bank, addr) -> (decompressed, compressed)
        self.symbols: dict[int, dict] = {}  # config/symbols.json: evidence-named RAM addresses
        self.zeroed_streams: set[tuple[int, int]] = set()  # streams that read their cleared destination (E-0150)
        self.split_ptr: dict[tuple[int, int], tuple[str, int, int]] = {}  # ld e/d/b of a stream address (E-0150)
        self.data_regions: dict[int, list[tuple[int, int]]] = {}  # config/data_regions.json: proven data
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

    def in_data_region(self, bank: int, addr: int) -> bool:
        """True when config/data_regions.json proves the byte at bank:addr is data, not code."""
        return any(lo <= addr < hi for lo, hi in self.data_regions.get(bank, ()))

    def add_entry(self, bank: int, addr: int, name: str, why: str | None = None) -> None:
        if bank in self.zero or not (0 <= bank < self.nbanks):
            return
        if why and why.startswith("heuristic") and self.in_data_region(bank, addr):
            return  # a guess that lands in proven data
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
                self.dispatch[(bank, pc + 1)] = []  # inline jump table of `rst $00`
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
            # E-0207: an `rst $00` table runs to its lowest target and may hold $0000 for unused indexes
            limit = 256 if (bank, start) in self.dispatch else MAX_TABLE
            while len(words) < limit and pos + 2 <= base + BANK:
                if pos in cov or pos + 1 in cov or (floor is not None and pos >= floor):
                    break
                w = rom[pos - base] | (rom[pos - base + 1] << 8)
                if w == 0 and floor is not None and (bank, start) in self.dispatch:
                    words.append((pos, w, None))
                    pos += 2
                    continue
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
            while words and words[-1][2] is None:  # a table does not end with an unused index
                words.pop()
            if (bank, start) in self.dispatch:
                self.dispatch[(bank, start)] = [r for _p, _w, r in words]  # None: unused index
            self.table_words[(bank, start)] = [p for p, _w, _r in words]
            for p, w, r in words:
                self.insn[bank][p] = ("dw", w)
                cov.update((p, p + 1))
                if r:
                    self.add_entry(r[0], r[1], "Jump")
        return did

    def trim_tables(self) -> bool:
        """Cut an inline table at the first word that is also a routine entry (E-0126).

        A table's length is a guess (words that look like pointers); a `call` found later can
        prove that the bytes after the real end are code. Those words are uncovered and the
        entry is traced as code."""
        did = False
        for (bank, start), poss in self.table_words.items():
            for i, p in enumerate(poss):
                if p > start and self.labels[bank].get(p, "").startswith("Func_"):
                    for q in poss[i:]:
                        if self.insn[bank].get(q, (None,))[0] == "dw":
                            del self.insn[bank][q]
                        self.covered[bank].discard(q)
                        self.covered[bank].discard(q + 1)
                    self.table_words[(bank, start)] = poss[:i]
                    if (bank, start) in self.dispatch:
                        self.dispatch[(bank, start)] = self.dispatch[(bank, start)][:i]
                    if p not in self.pending[bank]:
                        self.pending[bank].append(p)
                    did = True
                    break
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

    def _rect_relays(self) -> set[tuple[int, int]]:
        """Copies of the DrawTileRectAtHLFromDE family (E-0093): routines whose first 23 bytes
        equal the canonical's (HL, DE to wArg5/6, wArg1/2, then a far call)."""
        fam = next((f for f in self.families if f["name"] == "DrawTileRectAtHLFromDE"), None)
        if not fam:
            return set()
        cb, ca = int(fam["canonical"][:2], 16), int(fam["canonical"][3:], 16)
        sig = lambda b, a: bytes(self.data[b * BANK + a - self.base(b):b * BANK + a - self.base(b) + 23])
        want = sig(cb, ca)
        return {(b, a) for b in range(self.nbanks) for a in self.labels[b]
                if a in self.insn[b] and a <= self.base(b) + BANK - 23 and sig(b, a) == want}

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
        if self.in_data_region(bank, start):
            return False
        base = self.base(bank)
        tr = self.spec_trace(bank, start)
        fb = self.data[bank * BANK + start - base:bank * BANK + start - base + 16]
        if not self.plausible(tr, fb):
            return False
        if self.contradicted(bank, tr):
            self.vetoed += 1
            return False
        return True

    def discover_copies(self) -> bool:
        """E-0212: untraced bytes whose first 16 equal the first 16 of a traced routine (all of
        them decoded as code there) are a copy of that routine: queue them as code. Library
        routines are copied into many banks; a copy no traced code reaches stays data otherwise."""
        def norm(b: int, a: int):
            """Whole instructions covering 16 bytes from `a`; a 16-bit operand into the switchable
            window is replaced by its offset from `a`, so a relocated copy of a block matches."""
            base = self.base(b)
            o0 = b * BANK - base
            out, pc = [], a
            while pc - a < 16:
                if pc + 3 > base + BANK:
                    return None
                n, _t, kind, _tg = decode(self.data, o0 + pc, pc)
                if kind == "bad":
                    return None
                raw = bytes(self.data[o0 + pc:o0 + pc + n])
                if n == 3 and raw[0] != 0x01 and 0x4000 <= (raw[1] | raw[2] << 8) < 0x8000:  # not ld bc (a count)
                    out.append((raw[0], "rel", (raw[1] | raw[2] << 8) - a))
                else:
                    out.append(raw)
                pc += n
            return tuple(out)

        sig: dict[tuple, str] = {}
        for b in range(self.nbanks):
            base, ins, cov = self.base(b), self.insn[b], self.covered[b]
            for a, lab in self.labels[b].items():
                v = ins.get(a)
                if v is None or v[0] == "dw" or a + 16 > base + BANK:
                    continue
                if not (lab.startswith("Func_") or (b, a) in self.names):
                    continue
                if not all(x in cov for x in range(a, a + 16)) or any(ins.get(x, ("",))[0] == "dw" for x in range(a, a + 16)):
                    continue
                k = norm(b, a)
                if k:
                    sig.setdefault(k, f"{b:02X}:{a:04X}")
        spans = [(t["bank"], t["addr"], t["addr"] + t.get("tail", 0) + t["count"] * sum(
            2 if f["type"] == "ptr" else f.get("size", 1) for f in t["fields"])) for t in self.schemas]
        found = 0
        for b in range(1, self.nbanks):
            if b in self.zero:
                continue
            base, ins, cov = self.base(b), self.insn[b], self.covered[b]
            o0 = b * BANK - base
            cands = set()  # as for fall-through: right after a terminator or a table word
            for a, v in ins.items():
                nxt = a + 2 if v[0] == "dw" else (a + v[0] if v[2] in ("jr", "jp", "ret", "jphl") else None)
                if nxt is not None and nxt + 16 <= base + BANK and nxt not in cov:
                    cands.add(nxt)
            for p in sorted(cands):
                k = norm(b, p)
                src = sig.get(k) if k else None
                if src and not any(x in cov for x in range(p, p + 16)) and not self.in_data_region(b, p) \
                        and not any(tb == b and lo <= p < hi for tb, lo, hi in spans) and f"{b:02X}:{p:04X}" != src:
                    self.add_entry(b, p, "Func", f"heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at {src}")
                    found += 1
                    # the rest of a copied block: the source's later routines at the same distance
                    sb, sa = int(src[:2], 16), int(src[3:], 16)
                    for sa2 in sorted(x for x, lab in self.labels[sb].items() if sa < x < sa + 0x200 and x in self.insn[sb]
                                      and (lab.startswith("Func_") or ((sb, x) in self.names and not self.names[(sb, x)].get("data")))):
                        p2 = p + sa2 - sa
                        k2 = norm(sb, sa2)
                        if not k2 or p2 + 16 > base + BANK or any(x in cov for x in range(p2, p2 + 16)) \
                                or self.in_data_region(b, p2) or any(tb == b and lo <= p2 < hi for tb, lo, hi in spans):
                            continue
                        if norm(b, p2) == k2:  # each key is relative to its own start
                            self.add_entry(b, p2, "Func", f"heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at {sb:02X}:{sa2:04X}")
                            found += 1
        log(f"  (c) copies of traced routines: {found} queued")
        return found > 0

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
                while q + 2 <= base + BANK and q not in cov and q + 1 not in cov \
                        and not self.in_data_region(bank, q):
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
        def parse(bank: int, addr: int, zeroed: bool = False):
            """zeroed: the destination is cleared first, so reading not-yet-written output is fine"""
            fo = bank * BANK + addr - 0x4000
            try:
                size = self.data[fo] | (self.data[fo + 1] << 8)
                if not 1 <= size <= 0x4000:
                    return None
                out, used, ev = lzss_decompress(self.data, bank, addr)
            except IndexError:
                return None
            if (ev["unwritten_reads"] and not zeroed) or addr - 0x4000 + used > BANK:
                return None
            return len(out), used

        tables = streams = exact = 0
        spans = [(t["bank"], t["addr"], t["addr"] + t.get("tail", 0) + t["count"] * sum(
            2 if f["type"] == "ptr" else f.get("size", 1) for f in t["fields"])) for t in self.schemas]
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
                # E-0203: a target inside a declared table is that table's data, not a stream
                found = {t: None if any(b == bank and lo <= t < hi for b, lo, hi in spans) else parse(bank, t)
                         for t in targets}
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
        sgb = {a for (b, a), info in self.names.items() if b == 0 and info["name"] == "SGBTransferCompressed"}
        ld_de = re.compile(r"ld de, \$([0-9A-F]{4})$")
        ld_b = re.compile(r"ld b, \$([0-9A-F]{2})$")
        ld_e = re.compile(r"ld e, \$([0-9A-F]{2})$")  # LoadSGBBorderForSetA loads E and D apart (E-0150)
        ld_d = re.compile(r"ld d, \$([0-9A-F]{2})$")
        calls = literal = added = 0
        for bank in range(self.nbanks):
            ins = self.insn[bank]
            order = sorted(a for a, v in ins.items() if v[0] != "dw")
            index = {a: k for k, a in enumerate(order)}
            jumps_to: dict[int, list[int]] = {}
            for a, v in ins.items():
                if v[0] != "dw" and v[2] in ("jr", "jp") and v[3] is not None:
                    jumps_to.setdefault(v[3], []).append(a)

            def args_before(k: int):
                """(de, bank, split loads, first address scanned) from the instructions before order[k]."""
                de = bnk = lo = hi = None
                at: dict[str, int] = {}
                first = order[k]
                for x in reversed(order[max(0, k - 10):k]):
                    if ins[x][2] in SETUP_BARRIER:
                        break
                    first = x
                    if de is None and (m := ld_de.match(ins[x][1])):
                        de = int(m.group(1), 16)
                    if bnk is None and (m := ld_b.match(ins[x][1])):
                        bnk, at["BANK"] = int(m.group(1), 16), x
                    if lo is None and (m := ld_e.match(ins[x][1])):
                        lo, at["LOW"] = int(m.group(1), 16), x
                    if hi is None and (m := ld_d.match(ins[x][1])):
                        hi, at["HIGH"] = int(m.group(1), 16), x
                if de is None and lo is not None and hi is not None:
                    de = hi << 8 | lo
                return de, bnk, at, first

            for k, a in enumerate(order):
                n, text, kind, tgt = ins[a]
                if kind != "call" or tgt not in entries:
                    continue
                calls += 1
                de, bnk, at, first = args_before(k)
                found = [(de, bnk, at)]
                if de is None and bnk is None:
                    found = []
                if True:  # E-0216: also the arguments set before each jump into the scanned instructions
                    for src in [j for y in order[index[first]:k + 1] for j in jumps_to.get(y, [])]:
                        if src in index:
                            d2, b2, at2, _ = args_before(index[src])
                            found.append((d2, b2, at2))
                for de, bnk, at in found:
                    if de is not None and at and ("LOW" in at or "HIGH" in at):
                        for fn, x in at.items():  # print the split loads as LOW/HIGH/BANK of the stream label
                            self.split_ptr[(bank, x)] = (fn, bnk, de)
                    if de is None or bnk is None or not 0x4000 <= de < 0x8000:
                        continue
                    if not 0 < bnk < self.nbanks or bnk in self.zero:
                        continue
                    literal += 1
                    if (bnk, de) in self.streams or de in self.covered[bnk] or (de - 1) in self.dtab[bnk]:
                        continue
                    r = parse(bnk, de, zeroed=tgt in sgb)  # SGBTransferCompressed clears vTiles1 first (E-0150)
                    if r:
                        self.streams[(bnk, de)] = r
                        if tgt in sgb and not parse(bnk, de):
                            self.zeroed_streams.add((bnk, de))
                        self.dlabels[bnk].setdefault(de, f"Data_{bnk:03X}_{de:04X}")
                        self.dreason.setdefault((bnk, de), "stream decompressed by a call to DecompressTo*")
                        added += 1
        log(f"compressed assets from decompress call sites: {calls} calls, {literal} with literal "
            f"arguments, {added} new streams")
        # Third and fourth sources (E-0035): streams the emulated game decompressed
        # (config/observed_streams.json) and runs of six or more back-to-back streams
        # (config/stream_chains.json). Every one is re-checked with the decompressor and skipped
        # when it starts inside decoded code or a structured table.
        in_table = [(t["bank"], t["addr"], t["addr"] + t.get("tail", 0) + t["count"] * sum(
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
        # Fifth source (E-0139): far-pointer fields marked "stream" in config/tables.json, whose
        # consumer passes them to a decompress routine.
        from_tables = 0
        for t in self.schemas:
            fields = t["fields"]
            sizes = [2 if f["type"] == "ptr" else f.get("size", 1) for f in fields]
            for i in range(t["count"]):
                q, vals = t["addr"] + i * sum(sizes), []
                for f, sz in zip(fields, sizes):
                    vals.append(self._u16(t["bank"], q) if f["type"] == "ptr"
                                else self.data[t["bank"] * BANK + q - self.base(t["bank"])])
                    q += sz
                for fi, f in enumerate(fields):
                    if f.get("stream") or f.get("stream_skip"):
                        tb = vals[f["bank_from"]] if "bank_from" in f else int(f.get("target_bank", "%X" % t["bank"]), 16)
                        from_tables += register(tb, vals[fi] + f.get("stream_skip", 0), f.get("stream_reason", f.get("reason", "stream named by a table field")))
        log(f"compressed assets from table fields: {from_tables} new streams")

    def _decompress_entries(self) -> set[int]:
        """Bank-0 addresses of the decompress routines, taken from config/names.json.
        SGBTransferCompressed also decompresses DE from bank B (E-0150)."""
        return {a for (b, a), info in self.names.items()
                if b == 0 and info["name"].startswith(("DecompressTo", "SGBTransferCompressed"))}

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
        # E-0186: `ld de, SRC` copied to wArg1/wArg2 ($D7F1/$D7F2) before a far call to a routine
        # that reads its source there points into that routine's bank, not the caller's.
        arg_readers = {k for k, info in self.names.items() if not info.get("data") and
                       info["name"] in ("DrawTileRectFromArg1Params", "FillTileRectWithArg1Tile")}
        far_targets = {}  # (bank, rst $10 address) -> (target bank, address)
        for (bank, a), t in code_args.items():
            ins = self.insn[bank]
            for nxt in (a + 3, a + 5):  # ld hl / ld b / rst $10 in either order
                if ins.get(nxt, ("", "", ""))[2] == "rst":
                    far_targets[(bank, nxt)] = t
        bank0_tables = {t["addr"] for t in self.schemas if t["bank"] == 0 and 0x150 <= t["addr"] < 0x4000}
        own_tables = {(t["bank"], t["addr"]) for t in self.schemas if "E-0157 (derived" not in t.get("note", "")}
        arg_src: dict[tuple[int, int], tuple[int, str]] = {}
        for bank in range(self.nbanks):
            ins = self.insn[bank]
            order = sorted(a for a, v in ins.items() if v[0] != "dw")
            for k, a in enumerate(order):
                t = far_targets.get((bank, a))
                if t not in arg_readers:
                    continue
                de, stored = None, False
                for x in order[max(0, k - 20):k]:
                    if (m := ld16.match(ins[x][1])) and m.group(1) == "de":
                        de, stored = x, False
                    if ins[x][1] in ("ld [$D7F1], a", "ld [$D7F2], a") and de is not None:
                        stored = True
                if de is not None and stored:
                    arg_src[(bank, de)] = (t[0], f"wArg1/wArg2 source of a far call to {self.names[t]['name']}")
        # config/arg_banks.json (E-0192): routines that read their pointer argument in a fixed bank.
        fixed = {(b, a): (r["reg"], int(r["bank"], 16), r["name"]) for r in getattr(self, "arg_banks", [])
                 for (b, a), info in self.names.items() if info["name"] == r["name"] and not info.get("data")}
        for bank in range(self.nbanks):
            ins = self.insn[bank]
            order = sorted(a for a, v in ins.items() if v[0] != "dw")
            for k, a in enumerate(order):
                v = ins[a]
                if v[2] != "call" or v[3] is None or self.resolve(bank, v[3]) not in fixed:
                    continue
                reg, fb, nm = fixed[self.resolve(bank, v[3])]
                for x in reversed(order[max(0, k - 8):k]):
                    if ins[x][2] in SETUP_BARRIER:
                        break
                    if (m := ld16.match(ins[x][1])) and m.group(1) == reg:
                        arg_src[(bank, x)] = (fb, f"{reg.upper()} argument of {nm}, read in bank ${fb:02X}")
                        break
        # E-0187: the DrawTileRectAtHLFromDE_Bank* relays store DE in wArg1/wArg2 themselves, then far-call
        # DrawTileRectFromArg1Params: DE before a call to one points into that routine's bank.
        rect_bank = next((b for (b, a) in arg_readers
                          if self.names[(b, a)]["name"] == "DrawTileRectFromArg1Params"), None)
        relays = self._rect_relays()
        for bank in range(self.nbanks):
            ins = self.insn[bank]
            order = sorted(a for a, v in ins.items() if v[0] != "dw")
            for k, a in enumerate(order):
                v = ins[a]
                if rect_bank is None or v[2] != "call" or v[3] is None or self.resolve(bank, v[3]) not in relays:
                    continue
                for x in reversed(order[max(0, k - 12):k]):
                    if ins[x][2] in SETUP_BARRIER:
                        break
                    if (m := ld16.match(ins[x][1])) and m.group(1) == "de":
                        arg_src[(bank, x)] = (rect_bank, "DE source of a DrawTileRectAtHLFromDE relay")
                        break
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
                n1 = ins.get(a + ins[a][0], ("", ""))
                n2 = ins.get(a + ins[a][0] + n1[0], ("", "")) if isinstance(n1[0], int) else ("", "")
                if n1[1] == "ld a, l" and n2[1] == "ld [$C52F], a":
                    continue  # E-0211: rows / width of the text window (wTextWindowRows/Width), not an address
                if imm in bank0_tables:  # E-0189: a bank-0 address is in bank 0 from any bank
                    self.dlabels[0].setdefault(imm, f"Data_000_{imm:04X}")
                    self.dreason.setdefault((0, imm), "load of a declared bank-0 table")
                    self.dref[(bank, a)] = (0, imm)
                    strong += 1
                    continue
                if not 0x4000 <= imm < 0x8000:
                    continue
                if a in paired:
                    tb, why = paired[a][0], "argument of a bank-switching copy helper"
                elif (bank, a) in arg_src:
                    tb, why = arg_src[(bank, a)]
                elif (bank, a) in bv_pairs:
                    tb = bv_pairs[(bank, a)][0]
                    why = f"bank from RAM variable ${bv_pairs[(bank, a)][2]}"
                elif bank != 0 and (bank, imm) in own_tables:  # E-0196: exact start of a declared table
                    tb, why = bank, "same-bank load of a declared table's start"
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
                        nx = ins.get(pc + n)
                        s = self.symbolize(text, (nx[1],) if nx and nx[0] != "dw" else (), (b, pc))
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

    def name_single_caller_helpers(self) -> None:
        """Name a routine that has exactly one calling routine `Parent_SubNN` (E-0047).

        Only a named parent counts (hand names, family names, table-derived names), the helper must
        not also be reached through a table, and the pass repeats three times so helpers of helpers
        are named. NN counts the parent's helpers in address order. The name says where a routine
        is used, not what it does; the address name stays as an alias."""
        table_targets = set()
        for b in range(self.nbanks):
            for a, v in self.insn[b].items():
                if v[0] == "dw":
                    r = self.resolve(b, v[1])
                    if r:
                        table_targets.add(r)
        used = {i["name"] for i in self.names.values()}
        total = 0
        for _round in range(3):
            plan: dict[tuple[int, int], list[tuple[int, int]]] = {}
            shared: dict[str, list[tuple[int, int]]] = {}
            for (b, a), sites in self.callers.items():
                label = self.labels[b].get(a, "")
                if not label.startswith("Func_") or (b, a) in self.names or a not in self.insn[b]                         or (b, a) in table_targets:
                    continue
                parents = set()
                for cb, ca in sites:
                    ents = self.entries[cb]
                    k = bisect.bisect_right(ents, ca) - 1
                    parents.add((cb, ents[k]) if k >= 0 else None)
                if None in parents:
                    continue
                if len(parents) > 1:
                    # several callers that all belong to one named routine (its _SubNN, _CaseNN or
                    # _SharedNN helpers, or the routine itself): Root_SharedNN (E-0098)
                    roots = {SUFFIX_RE.sub("", self.labels[pb][pa]) for pb, pa in parents}
                    if len(roots) == 1:
                        (root,) = roots
                        if not root.startswith(("Func_", "Jump_")) and (b, a) not in parents:
                            shared.setdefault(root, []).append((b, a))
                    continue
                (parent,) = parents
                if parent == (b, a) or self.labels[parent[0]][parent[1]].startswith("Func_"):
                    continue
                plan.setdefault(parent, []).append((b, a))
            for root, helpers in shared.items():
                if len(root) > 48:
                    continue
                n = 0
                for b, a in sorted(helpers):
                    while True:
                        n += 1
                        name = f"{root}_Shared{n:02X}"
                        if name not in used:
                            break
                    used.add(name)
                    self.alias[(b, a)] = self.labels[b][a]
                    self.labels[b][a] = name
                    self.names[(b, a)] = {"name": name, "note": f"only called from routines of {root} (E-0098)",
                                          "evidence": "call graph"}
                    total += 1
            if not plan and not shared:
                break
            for (pb, pa), subs in plan.items():
                stem = self.labels[pb][pa]
                if len(stem) > 48:
                    continue
                for n, (b, a) in enumerate(sorted(subs, key=lambda x: (x[0], x[1])), 1):
                    name = f"{stem}_Sub{n:02X}"
                    if name in used:
                        continue
                    used.add(name)
                    old = self.labels[b][a]
                    self.alias[(b, a)] = old
                    self.labels[b][a] = name
                    self.names[(b, a)] = {"name": name, "note": f"only called from {stem} (E-0047)",
                                          "evidence": "call graph"}
                    total += 1
        log(f"single-caller helpers named: {total}")

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

    def name_copies(self) -> None:
        """E-0212: a routine found as a copy (discover_copies: its first 16 bytes equal a traced
        routine's) takes the source's name with its own bank suffix (`Name_BankBB`)."""
        used = {lab for b in range(self.nbanks) for lab in self.labels[b].values()}
        named = 0
        for (b, a), why in sorted(self.reason.items()):
            m = re.search(r"same first 16 bytes (?:\(in-bank addresses taken relative\) )?as the routine at ([0-9A-F]{2}):([0-9A-F]{4})", why or "")
            if not m or not self.labels[b].get(a, "").startswith("Func_"):
                continue
            sb, sa = int(m.group(1), 16), int(m.group(2), 16)
            src = self.labels[sb].get(sa, "")
            if src.startswith(("Func_", "Jump_")) or not src:
                continue  # the 16 equal bytes that found the copy are its evidence
            stem = re.sub(r"_Bank[0-9A-F]{2}$", "", src)
            name = f"{stem}_Bank{b:02X}"
            if name in used:
                name = f"{stem}_{b:02X}_{a:04X}"
            if name in used:
                continue
            used.add(name)
            self.alias[(b, a)] = self.labels[b][a]
            self.labels[b][a] = name
            named += 1
        log(f"copies named after their source routine: {named}")

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
        self.name_copies_of_named_routines(used)

    def name_copies_of_named_routines(self, used: set[str]) -> None:
        """Give byte-identical copies of every hand-named leaf routine the same name plus its bank.

        A routine named in config/names.json that has no call into a switchable bank may be
        repeated in other banks (the library of E-0027). Identical bytes behave identically, so the
        copies take `Name_BankBB` (with the address added when a bank holds two). Routines under
        4 bytes are skipped: a `ret` or `ld a, b` would match everywhere."""
        by_size: dict[int, list] = {}
        for (bank, addr), info in list(self.names.items()):
            if info.get("data") or info.get("evidence", "").startswith(("structure", "call graph")):
                continue  # names made from table position, stub shape or callers say nothing about a copy
            if addr not in self.insn.get(bank, {}) or self.labels[bank].get(addr, "").startswith(("Jump_", "Jr_")):
                continue
            size = self.routine_extent(bank, addr)
            if size and size >= 4:
                by_size.setdefault(size, []).append((bank, addr, info))
        entries = {}
        for bank in range(self.nbanks):
            for addr, label in self.labels[bank].items():
                if label.startswith("Func_") and addr in self.insn[bank] and (bank, addr) not in self.names:
                    entries.setdefault(bank, []).append(addr)
        added = 0
        for size, items in by_size.items():
            for bank, addr, info in items:
                want = self.data[bank * BANK + addr - self.base(bank):][:size]
                for cb, addrs in entries.items():
                    for ca in addrs:
                        if (cb, ca) in self.names or (cb, ca) == (bank, addr):
                            continue
                        off = cb * BANK + ca - self.base(cb)
                        if self.data[off:off + size] != want or self.routine_extent(cb, ca) != size:
                            continue
                        base = BANK_SUFFIX_RE.sub("", info["name"])  # a copy of X_Bank39 is X_BankBB (E-0105)
                        name = f"{base}_Bank{cb:02X}"
                        if name in used:
                            name += f"_{ca:04X}"
                        used.add(name)
                        self.names[(cb, ca)] = {"name": name, "evidence": info.get("evidence", "reading"),
                                                "note": f"the same {size} bytes as {info['name']} ({bank:02X}:{addr:04X})"}
                        added += 1
        log(f"copies of hand-named routines named: {added}")

    def name_dispatch_cases(self) -> None:
        """Name the jump targets of `rst $00` inline tables `Parent_CaseNN` (E-0040).

        The parent is the routine whose code holds the `rst $00`; NN is the entry's index in the
        table. A target takes the name of the first table that lists it, and only plain `Jump_`
        labels are renamed (routines already have a name or an address name of their own)."""
        done = 0
        tables_of: dict[str, int] = {}
        for (bank, start), targets in sorted(self.dispatch.items()):
            if not targets:
                continue
            labels = self.labels[bank]
            parents = [a for a in labels if a < start and labels[a].startswith(("Func_", "Data_")) is False
                       and not labels[a].startswith("Jump_")] + [a for a in labels if a < start and labels[a].startswith("Func_")]
            if not parents:
                continue
            owner = max(parents)
            # a table inside an already-named jump-table case belongs to that case, not to the
            # routine label before it (E-0123)
            nearest = max((a for a in labels if a < start), default=owner)
            if nearest > owner and (bank, nearest) in self.names:
                owner = nearest
            parent = labels[owner]
            info = self.names.get((bank, owner))
            if info:
                parent = info["name"]
            tables_of[parent] = k = tables_of.get(parent, 0) + 1
            stem = f"{parent}_Case" if k == 1 else f"{parent}_Table{k}_Case"  # a routine can hold several tables
            for n, tgt in enumerate(targets):
                if tgt is None:
                    continue
                tb, ta = tgt
                if tb != bank or (tb, ta) in self.names or not self.labels[tb].get(ta, "").startswith("Jump_"):
                    continue
                if ta not in self.insn[tb]:
                    continue
                self.names[(tb, ta)] = {"name": f"{stem}{n:02X}",
                                        "note": f"entry {n} of the `rst $00` table in {parent}",
                                        "evidence": "structure of the table"}
                done += 1
        log(f"jump-table cases named: {done}")

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
        for (bank, addr), t in self.table_at.items():  # operands name the table, not its address
            cur = self.dlabels[bank].get(addr)
            if cur and cur.startswith("Data_") and t.get("label") and t["label"] not in seen:
                self.dalias.setdefault((bank, addr), cur)
                self.dlabels[bank][addr] = t["label"]
        log(f"routines renamed from config/names.json: {len(self.names)}")

    def _u16(self, bank: int, addr: int) -> int:
        o = bank * BANK + (addr - self.base(bank))
        return self.data[o] | (self.data[o + 1] << 8)

    def add_map_schemas(self) -> None:
        """Derive layouts for the bank-$11 map records and their screen arrays (E-0142).

        LoadMapHeader / LoadMapScreen read a record as: far pointer to the tileset stream,
        far pointer to the BG palette, 10 header bytes (width and height in screens first),
        the RAM address of a flag byte, then 6-byte variants (far pointer to the tile-map
        array, far pointer to the attribute-map array); the highest set bit of the flag byte
        picks variant 1-8, none picks variant 0. An array holds width * height far pointers,
        row by row, to compressed 20 x 18 screens. A record ends where the next begins (the
        last at MapWarpTable). Leading variants are kept while both arrays decode completely;
        later bytes stay `db`."""
        from lzss_gfx import decompress
        mt = next((t for t in self.schemas if t["label"] == "MapTable"), None)
        wt = next((t for t in self.schemas if t["label"] == "MapWarpTable"), None)
        if not mt or not wt:
            return
        b11, end_all = mt["bank"], wt["addr"]
        ptrs = [self._u16(b11, mt["addr"] + 2 * i) for i in range(mt["count"])]
        recs = sorted({p for p in ptrs if mt["addr"] + 2 * mt["count"] <= p < end_all} | {int(x, 16) for x in mt.get("extra_records", [])})  # E-0201: records no map uses
        nb = len(self.data) // BANK

        def fp(bank: int, addr: int) -> tuple[int, int]:
            o = bank * BANK + addr - self.base(bank)
            return self.data[o + 2], self.data[o] | self.data[o + 1] << 8

        def screens_ok(bank: int, addr: int, n: int) -> bool:
            if not (0 < bank < nb and 0x4000 <= addr and addr + 3 * n <= 0x8000):
                return False
            for i in range(n):
                sb, sa = fp(bank, addr + 3 * i)
                if not (0 < sb < nb and 0x4000 <= sa < 0x7FF0):
                    return False
                try:
                    out, _, ev = decompress(self.data, sb, sa)
                except IndexError:
                    return False
                if ev["unwritten_reads"] or len(out) != 360:
                    return False
            return True

        dfar = lambda name, reason, stream: [
            {"type": "ptr", "bank_from": None, "name": name, "reason": reason, **({"stream": True} if stream else {})},
            {"type": "db", "size": 1, "name": "its ROM bank"}]
        arrays: dict[tuple[int, int], tuple[int, str]] = {}
        palettes: dict[tuple[int, int], str] = {}
        named: set[tuple[int, int]] = set()
        added = 0
        for r, nxt in zip(recs, recs[1:] + [end_all]):
            first = min((i for i, p in enumerate(ptrs) if p == r), default=None)
            tag = f"{first:02X}" if first is not None else f"X{r:04X}"  # X: no MapTable entry
            o = b11 * BANK + r - self.base(b11)
            wd, ht = self.data[o + 6], self.data[o + 7]
            fields = dfar("tileset", "map tileset stream", True) + dfar("palettes", "map BG palettes", False) + [
                {"type": "db", "size": 10, "name": "width, height, wMaxBlockingTile, wMapHeaderByte7, "
                 "wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes"},
                {"type": "words", "size": 2, "ram": True, "name": "variant flag byte"}]
            tiles, pal = fp(b11, r), fp(b11, r + 3)
            if tiles not in self.names and tiles not in named:
                named.add(tiles)
                self.names[tiles] = {"name": f"Map{tag}Tileset", "data": True, "evidence": "E-0142",
                                     "note": f"compressed tileset of map ${tag} (the first map record using it)"}
            palettes.setdefault(pal, f"Map{tag}Palettes")
            k, q = 0, r + 0x12
            while q + 6 <= nxt and k < 9:
                (tb, ta), (ab, aa) = fp(b11, q), fp(b11, q + 3)
                if not (screens_ok(tb, ta, wd * ht) and screens_ok(ab, aa, wd * ht)):
                    break
                for (bb, aa_, kind) in ((tb, ta, "Screens"), (ab, aa, "Attrs")):
                    arrays.setdefault((bb, aa_), (wd * ht, f"Map{tag}{kind}{k}"))
                fields += dfar(f"variant {k} screens", "map screen array", False) + \
                    dfar(f"variant {k} attributes", "map screen array", False)
                k, q = k + 1, q + 6
            if nxt > q:
                fields.append({"type": "db", "size": nxt - q, "name": "bytes after the decoded variants"})
            for i, f in enumerate(fields):
                if f.get("bank_from", 0) is None:
                    f["bank_from"] = i + 1
            self.schemas.append({"bank": b11, "addr": r, "label": f"MapRecord{tag}", "count": 1,
                                 "fields": fields, "record": "tileset; palettes; width, height, wMaxBlockingTile, "
                                 "wMapHeaderByte7, wFieldEventKind, encounter rate, wMapMoveType, wMapSpriteKind, 2 bytes; "
                                 "variant flag byte; then per variant: screen array, attribute array", "note": (f"E-0142 (derived: map record of map ${first:02X}, " if first is not None else "E-0142, E-0201 (derived: map record that no MapTable entry points to, ")
                                 + f"{wd} x {ht} screens, {k} decoded variant(s))"})
            added += 1
        sm = next((t for t in self.schemas if t["label"] == "SpecialMapRecords"), None)
        if sm:  # 26-byte special map records (E-0144): arrays at +$14 / +$17, size from +6 / +7
            for i in range(sm["count"]):
                r = sm["addr"] + 26 * i
                o = sm["bank"] * BANK + r - self.base(sm["bank"])
                wd, ht = self.data[o + 6], self.data[o + 7]
                palettes.setdefault(fp(sm["bank"], r + 3), f"SpecialMap{i:02X}Palettes")
                tiles = fp(sm["bank"], r)
                if tiles not in self.names and tiles not in named:
                    named.add(tiles)
                    self.names[tiles] = {"name": f"SpecialMap{i:02X}Tileset", "data": True, "evidence": "E-0144",
                                         "note": f"compressed tileset of special map record {i} (SpecialMapRecords)"}
                for j, kind in ((0x14, "Screens"), (0x17, "Attrs")):
                    tb, ta = fp(sm["bank"], r + j)
                    if screens_ok(tb, ta, wd * ht):
                        arrays.setdefault((tb, ta), (wd * ht, f"SpecialMap{i:02X}{kind}"))
        kc = next((t for t in self.schemas if t["label"] == "KeyWorldChunkLists"), None)
        chunk_groups: list[tuple[int, int, int]] = []
        if kc:  # key-world chunk groups (E-0146): n sub-chunks of $60 bytes, then n order bytes
            starts = sorted({fp(kc["bank"], kc["addr"] + 3 * i) for i in range(kc["count"])})
            for (bank, addr), nxt in zip(starts, starts[1:] + [(None, None)]):
                if nxt[0] == bank and (nxt[1] - addr) % 0x61 == 0:
                    n = (nxt[1] - addr) // 0x61
                else:  # the last group of a bank: its order bytes are a permutation of 0..n-1
                    n = next((k for k in range(1, 10) if addr + 0x61 * k <= 0x8000 and sorted(
                        self.data[bank * BANK + addr + 0x60 * k - self.base(bank) + j] for j in range(k)) == list(range(k))), 0)
                def screen_ok(sb: int, sa: int) -> bool:
                    if not (0 < sb < nb and 0x4000 <= sa < 0x7FF0):
                        return False
                    try:
                        out, _, ev = decompress(self.data, sb, sa)
                    except IndexError:
                        return False
                    return not ev["unwritten_reads"] and len(out) == 360

                ok = n and all(
                    screen_ok(fp(bank, addr + 0x60 * k + 3 * i)[0], fp(bank, addr + 0x60 * k + 3 * i)[1] + 8)
                    and screen_ok(*fp(bank, addr + 0x60 * k + 0x30 + 3 * i))
                    for k in range(n) for i in range(16))
                if ok:
                    chunk_groups.append((bank, addr, n))
        taken: list[tuple[int, int, int]] = []  # config layouts win over derived ones
        for t in self.schemas:
            if not t["label"].startswith(("MapRecord",)):
                size = sum(2 if f["type"] == "ptr" else f.get("size", 1) for f in t["fields"]) * t["count"] + t.get("tail", 0)
                taken.append((t["bank"], t["addr"], t["addr"] + size))
        for (bank, addr), (n, label) in sorted(arrays.items()):
            if any(b == bank and lo < addr + 3 * n and addr < hi for b, lo, hi in taken):
                continue  # arrays that overlap another stay inside it
            taken.append((bank, addr, addr + 3 * n))
            self.schemas.append({"bank": bank, "addr": addr, "label": label, "count": n,
                                 "fields": dfar("compressed 20 x 18 screen", "map screen stream", True),
                                 "note": f"E-0142 (derived: {n} screen far pointers, row by row)"})
            self.schemas[-1]["fields"][0]["bank_from"] = 1
            added += 1
        for g, (bank, addr, n) in enumerate(chunk_groups):
            if any(b == bank and lo < addr + 0x61 * n and addr < hi for b, lo, hi in taken):
                continue
            taken.append((bank, addr, addr + 0x61 * n))
            fields = []
            for i in range(16):
                fields += [{"type": "ptr", "bank_from": len(fields) + 1, "stream_skip": 8,
                            "name": f"screen {i}: 8-byte header, then the compressed tile map",
                            "reason": "key-world screen header", "stream_reason": "key-world screen tile map"},
                           {"type": "db", "size": 1, "name": "its ROM bank"}]
            for i in range(16):
                fields += [{"type": "ptr", "bank_from": len(fields) + 1, "stream": True,
                            "name": f"screen {i}: compressed attribute map", "reason": "key-world screen attribute map"},
                           {"type": "db", "size": 1, "name": "its ROM bank"}]
            self.schemas.append({"bank": bank, "addr": addr, "label": f"KeyWorldChunkGroup{g:02X}", "count": n,
                                 "fields": fields, "id_base": 0,
                                 "record": "16 far pointers to screen tile maps (each behind an 8-byte header whose "
                                           "bytes 6-7 pick the AutomapBlocks entry), then 16 to their attribute maps",
                                 "note": f"E-0146 (derived: {n} sub-chunk(s) of a 4 x 4 grid of screens; "
                                 "Func_061_4472_Case00 skips the 8-byte header before each tile map)"})
            self.schemas.append({"bank": bank, "addr": addr + 0x60 * n, "label": f"KeyWorldChunkGroup{g:02X}Order",
                                 "count": 1, "fields": [{"type": "db", "size": n, "name": "sub-chunk order"}],
                                 "note": "E-0146 (derived: a permutation of the sub-chunk numbers)"})
            added += 1
        npal = 0
        for (bank, addr), label in sorted(palettes.items()):
            if not (0 < bank < nb and 0x4000 <= addr <= 0x8000 - 0x40) or any(
                    b == bank and lo < addr + 0x40 and addr < hi for b, lo, hi in taken):
                continue
            taken.append((bank, addr, addr + 0x40))
            self.schemas.append({"bank": bank, "addr": addr, "label": label, "count": 8,
                                 "fields": [{"type": "words", "size": 8, "name": "one CGB palette: 4 BGR555 colours"}],
                                 "note": "E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)"})
            npal += 1
        log(f"map layouts derived from MapTable: {len(recs)} records, {len(arrays)} screen arrays, {npal} palette sets, "
            f"{len(chunk_groups)} key-world chunk groups")

    def add_list_schemas(self) -> None:
        """Derive layouts for terminated record lists named by pointer tables marked "lists" (E-0157).

        The option gives the record size, the terminator byte (checked at a record start), the
        record fields and a label prefix; each distinct non-zero target becomes a table of its
        records plus the terminator, labelled <prefix><first index>."""
        taken = [(t["bank"], t["addr"], t["addr"] + t.get("tail", 0) + t["count"] * sum(
            2 if f["type"] == "ptr" else f.get("size", 1) for f in t["fields"])) for t in self.schemas]
        made = 0
        for t in [t for t in self.schemas if t.get("lists")]:
            spec, bank = t["lists"], t["bank"]
            base = bank * BANK - self.base(bank)
            words = [self._u16(bank, t["addr"] + 2 * i) for i in range(t["count"])]
            if spec.get("until"):  # E-0199: contiguous lists, each running to the next target
                end, size = int(spec["until"], 16), spec["size"]
                targets = sorted(set(words) - {end})  # a pointer to the end names an empty list
                ok = all(0x4000 <= a < end for a in targets) and all(
                    (b - a) % size == 0 for a, b in zip(targets, targets[1:] + [end]))
                if not ok or any(b == bank and lo < end and targets[0] < e for b, lo, e in taken):
                    log(f"{t['label']}: lists do not tile [{targets[0]:04X}, {end:04X})")
                    continue
                for a, b in zip(targets, targets[1:] + [end]):
                    first = words.index(a) + t.get("id_base", 0)
                    taken.append((bank, a, b))
                    one = spec.get("one_line")  # the whole list as one db line
                    self.schemas.append({"bank": bank, "addr": a, "label": f"{spec['label']}{first:03X}",
                                         "count": 1 if one else (b - a) // size, "id_base": 0,
                                         "fields": [dict(spec["fields"][0], size=b - a)] if one else spec["fields"],
                                         "record": spec.get("record"),
                                         "note": f"E-0199 (derived: list for entry ${first:02X}"
                                                 + (f" ({self.monster_name(first)})" if t.get("id_names") == "monster"
                                                    and 0 < first < 0x180 else "")
                                                 + f" of {t['label']}; it runs to the next list)"})
                    made += 1
                continue
            for a in sorted(set(words)):
                if not 0x4000 <= a < 0x8000:
                    continue
                n = 0
                while n < 255 and a + spec["size"] * n < 0x8000 and self.data[base + a + spec["size"] * n] != spec["end"]:
                    n += 1
                hi = a + spec["size"] * n + 1
                if n == 255 or hi > 0x8000 or any(b == bank and lo < hi and a < e for b, lo, e in taken):
                    continue
                taken.append((bank, a, hi))
                first = words.index(a) + t.get("id_base", 0)
                self.schemas.append({"bank": bank, "addr": a, "label": f"{spec['label']}{first:02X}", "count": n,
                                     "tail": 1, "fields": spec["fields"], "id_base": 0,
                                     "record": spec.get("record"),
                                     "note": f"E-0157 (derived: list for entry ${first:02X} of {t['label']}; "
                                             f"{n} record(s), then ${spec['end']:02X})"})
                made += 1
        log(f"record lists derived from pointer tables: {made}")

    def add_metasprite_schemas(self) -> None:
        """Derive set, frame-list and frame layouts below tables marked "metasprite" (E-0147).

        The meta-sprite builders (DrawMetaSpriteSet_Bank25 and its copies, DrawMetaSpriteAt)
        take a word table of sets; a set is a list of frame pointers (hSpriteSubIndex indexes
        it; it ends where the first frame begins); a frame is 4-byte sprites (Y offset,
        X offset, tile, attribute) until a byte $80 in the Y position."""
        taken = [(t["bank"], t["addr"], t["addr"] + t.get("tail", 0) + t["count"] * sum(
            2 if f["type"] == "ptr" else f.get("size", 1) for f in t["fields"])) for t in self.schemas]

        def free(bank: int, lo: int, hi: int) -> bool:
            return not any(b == bank and a < hi and lo < e for b, a, e in taken)

        sets = frames = 0
        for t in [t for t in self.schemas if t.get("metasprite")]:
            bank, prefix = t["bank"], t["label"].removesuffix("Table")
            base = bank * BANK - self.base(bank)
            words = [self._u16(bank, t["addr"] + 2 * i) for i in range(t["count"])]
            for a in sorted(set(words)):
                si = words.index(a) + t.get("id_base", 0)  # numbered by the first set index that uses it
                if not 0x4000 <= a < 0x8000:
                    continue
                ptrs, lo = [], 0x8000
                while a + 2 * len(ptrs) < lo:
                    w = self._u16(bank, a + 2 * len(ptrs))
                    if not a < w < 0x8000:
                        ptrs = []
                        break
                    ptrs.append(w)
                    lo = min(lo, w)
                if not ptrs or a + 2 * len(ptrs) != lo or not free(bank, a, lo):
                    continue
                taken.append((bank, a, lo))
                self.schemas.append({"bank": bank, "addr": a, "label": f"{prefix}Set{si:02X}", "count": len(ptrs),
                                     "fields": [{"type": "ptr", "name": "frame", "reason": "meta-sprite frame"}],
                                     "note": f"E-0147 (derived: meta-sprite set {si} of {t['label']}: "
                                             f"{len(ptrs)} frame pointer(s), chosen by hSpriteSubIndex)"})
                sets += 1
                for fi, fa in enumerate(sorted(set(ptrs))):
                    n = 0
                    while n < 128 and fa + 4 * n < 0x8000 and self.data[base + fa + 4 * n] != 0x80:
                        n += 1
                    if n == 128 or fa + 4 * n >= 0x8000 or not free(bank, fa, fa + 4 * n + 1):
                        continue
                    taken.append((bank, fa, fa + 4 * n + 1))
                    self.schemas.append({"bank": bank, "addr": fa, "label": f"{prefix}Set{si:02X}Frame{fi}",
                                         "count": n, "tail": 1,
                                         "fields": [{"type": "db", "size": 4, "line": True,
                                                     "name": "sprite: Y offset, X offset, tile, attribute"}],
                                         "note": f"E-0147 (derived: frame {fi} of {prefix}Set{si:02X}; ends with $80)"})
                    frames += 1
        log(f"meta-sprite layouts: {sets} sets, {frames} frames")

    def drop_tile_pointer_runs(self) -> None:
        """Undo heuristic `dw` runs that are tile bytes (E-0165): a run of four or more pointer
        words (with up to 6 bytes between them), at least 60% of them with equal low and high bytes ($5757, $5656 ...), is data
        such as a tile map. Its words go back to bytes, and the target labels that only these
        words created (reason 'target of a monotone pointer table', no code reference, no
        layout) are removed."""
        dropped = labels = 0
        for b in range(self.nbanks):
            dt = self.dtab[b]
            keys = sorted(dt)
            runs, cur = [], []
            for k in keys:
                if cur and not 2 <= k - cur[-1] <= 8:  # the scan also makes runs of dw + db (strides 3-6)
                    runs.append(cur)
                    cur = []
                cur.append(k)
            if cur:
                runs.append(cur)
            for run in runs:
                eq = sum(1 for k in run if dt[k] >> 8 == dt[k] & 0xFF)
                if len(run) < 4 or eq * 5 < len(run) * 3:
                    continue
                targets = {dt[k] for k in run}
                for k in run:
                    del dt[k]
                    dropped += 1
                still = set(dt.values()) | {t for (bb, _), (tb, t) in self.dref.items() if tb == b}
                for t in targets:
                    if t in still or (b, t) in self.table_at or (b, t) in self.streams or \
                            (b, t) in getattr(self, "script_at", {}) or (b, t) in self.names:
                        continue
                    if self.dreason.get((b, t), "target of a monotone pointer table").startswith(
                            "target of a monotone pointer table") and \
                            t in self.dlabels[b]:
                        del self.dlabels[b][t]
                        labels += 1
        log(f"tile-byte pointer runs undone: {dropped} words, {labels} labels")

    def data_readers(self, bank: int, addr: int) -> list[str]:
        """Names of the routines whose instructions load the address of data label (bank, addr)
        (from the resolved `ld rr, n` references), nearest named code label first (E-0162)."""
        if not hasattr(self, "_readers"):
            self._readers: dict[tuple[int, int], list[str]] = {}
            starts = {b: sorted(a for a in self.labels[b] if a in self.insn[b] and not
                                self.labels[b][a].startswith("Jump_")) for b in range(self.nbanks)}
            import bisect
            for (b, pc), tgt in self.dref.items():
                lst = starts[b]
                i = bisect.bisect_right(lst, pc) - 1
                if i >= 0:
                    name = self.labels[b][lst[i]]
                    if name not in self._readers.setdefault(tgt, []):
                        self._readers[tgt].append(name)
        return self._readers.get((bank, addr), [])

    def prepare_object_selectors(self) -> None:
        """Map object data in bank $69 (E-0163).

        LoadMapObjectsForScreen reads the word $4174 + 2 * hMapId, then the word at that address
        + 2 * (hMapScreenY * wMapWidthScreens + hMapScreenX): a selector. A selector is a list of
        entries: a story-flag word (high byte not $FF) and an object-list pointer, used when the
        flag is clear; $FFFF ends with no objects; $FFFE + pointer always uses the list; $FFFD +
        two flags + pointer; $FFFC / $FFFB + flag + two bytes skip that many bytes when the flag
        is clear / set. An object list is a count, then 11 bytes per object (sprite slot fields
        and a graphics number for DecompressGraphicsTemp0ToTemp4)."""
        B = 0x69
        self.objsel_at: dict[tuple[int, int], dict] = {}
        mt = next((t for t in self.schemas if t["label"] == "MapTable"), None)
        ot = next((t for t in self.schemas if t["label"] == "MapObjectTable"), None)
        if not mt or not ot or ot["bank"] != B:
            return
        base = B * BANK - self.base(B)
        rd = lambda a: self.data[base + a]
        rw = lambda a: self.data[base + a] | self.data[base + a + 1] << 8

        def list_ok(a: int) -> bool:
            n = rd(a) if 0x4000 <= a < 0x8000 else 0
            return 0 < n <= 40 and a + 1 + 11 * n <= 0x8000

        def decode(s: int):
            pc, ops = s, []
            while len(ops) < 40 and 0x4000 <= pc < 0x7FF8:
                e, d = rd(pc), rd(pc + 1)
                if d != 0xFF:
                    ops.append((pc, "flag", rw(pc), rw(pc + 2))); pc += 4; continue
                if e == 0xFF:
                    ops.append((pc, "end")); return ops, pc + 2
                if e == 0xFE:
                    ops.append((pc, "list", rw(pc + 2))); return ops, pc + 4
                if e == 0xFD:
                    ops.append((pc, "flags", rw(pc + 2), rw(pc + 4), rw(pc + 6))); pc += 8; continue
                if e in (0xFC, 0xFB):
                    ops.append((pc, "skip", e, rw(pc + 2), rd(pc + 4), rd(pc + 5))); pc += 6; continue
                return None, pc
            return None, pc

        sels: set[int] = set()
        arrays: dict[int, int] = {}
        for mid in range(ot["count"]):
            p = self._u16(B, ot["addr"] + 2 * mid)
            rec = self._u16(mt["bank"], mt["addr"] + 2 * mid)
            if not p or not 0x4000 <= p < 0x8000 or not mt["addr"] < rec < 0x8000:
                continue
            o = mt["bank"] * BANK + rec - self.base(mt["bank"])
            n = self.data[o + 6] * self.data[o + 7]
            arrays.setdefault(p, n)
            arrays[p] = max(arrays[p], n)
        lists, good = set(), {}
        for p, n in arrays.items():
            for i in range(n):
                s = rw(p + 2 * i)
                if s:
                    sels.add(s)
        for s in sorted(sels):
            ops, end = decode(s) if 0x4000 <= s < 0x8000 else (None, 0)
            if not ops:
                continue
            ptrs = [op[3] if op[1] == "flag" else op[2] if op[1] == "list" else op[4]
                    for op in ops if op[1] in ("flag", "list", "flags")]
            if all(list_ok(q) for q in ptrs):
                good[s] = (ops, end)
                lists |= set(ptrs)
        good = {s: v for s, v in good.items() if s not in lists}
        taken = [(t["bank"], t["addr"], t["addr"] + t.get("tail", 0) + t["count"] * sum(
            2 if f["type"] == "ptr" else f.get("size", 1) for f in t["fields"])) for t in self.schemas]

        def free(lo: int, hi: int) -> bool:
            return not any(b == B and a < hi and lo < e for b, a, e in taken) and \
                not any(a in self.covered[B] for a in range(lo, hi))

        nl = ns = na = 0
        for a in sorted(lists):
            n = rd(a)
            if not free(a, a + 1 + 11 * n):
                continue
            taken.append((B, a, a + 1 + 11 * n))
            self.schemas.append({"bank": B, "addr": a, "label": f"MapObjects_{a:04X}", "count": 1,
                                 "fields": [{"type": "db", "size": 1, "line": True, "name": "object count"}]
                                 + [{"type": "db", "size": 11, "line": True, "name": f"object {k}"} for k in range(n)],
                                 "record": f"count, then {n} object(s): VRAM page, graphics table (0 = monster "
                                           "sprites), graphics number (2 bytes), slot byte 0, X, Y, palette slot, "
                                           "slot byte 7, talk event group, slot byte 15",
                                 "note": "E-0163 (derived: an object list of LoadMapObjectsForScreen)"})
            nl += 1
        for p, n in sorted(arrays.items()):
            entries = [rw(p + 2 * i) for i in range(n)]
            if all(e == 0 or e in good for e in entries) and free(p, p + 2 * n):
                taken.append((B, p, p + 2 * n))
                self.schemas.append({"bank": B, "addr": p, "label": f"MapObjectScreens_{p:04X}", "count": n,
                                     "id_base": 0, "fields": [{"type": "ptr", "name": "selector for this screen",
                                                               "reason": "map object selector"}],
                                     "note": "E-0163 (derived: one selector per screen, row by row)"})
                na += 1
        dl = self.dlabels[B]
        for s, (ops, end) in sorted(good.items()):
            if not free(s, end):
                continue
            taken.append((B, s, end))
            for a in [a for a in dl if s < a < end]:
                del dl[a]
            for k in [k for k in self.dtab[B] if s <= k < end]:
                del self.dtab[B][k]
            dl.setdefault(s, f"Data_{B:03X}_{s:04X}")
            if dl[s].startswith("Data_"):
                self.dalias.setdefault((B, s), dl[s])
                dl[s] = f"ObjSelector_{s:04X}"
            self.dreason[(B, s)] = "map object selector"
            self.objsel_at[(B, s)] = {"ops": ops, "end": end}
            ns += 1
        # E-0218: gaps between these layouts that tile exactly as further lists and selectors
        # (reached by no screen array the map records size): object lists start with a count and
        # a VRAM page byte ($8x); selectors are read with the same grammar.
        def add_list(a: int, n: int) -> None:
            taken.append((B, a, a + 1 + 11 * n))
            self.schemas.append({"bank": B, "addr": a, "label": f"MapObjects_{a:04X}", "count": 1,
                                 "fields": [{"type": "db", "size": 1, "line": True, "name": "object count"}]
                                 + [{"type": "db", "size": 11, "line": True, "name": f"object {k}"} for k in range(n)],
                                 "record": f"count, then {n} object(s), the layout of the other object lists",
                                 "note": "E-0218 (derived: an object list found by tiling a gap between map object layouts)"})

        tiled = 0
        spans = sorted((a, e) for b, a, e in taken if b == B)
        for (a0, e0), (a1, e1) in zip(spans, spans[1:]):
            lo, hi = e0, a1
            if not 0 < hi - lo <= 0x400 or not free(lo, hi):
                continue
            pc, plan = lo, []
            while pc < hi:
                if rd(pc + 1) != 0xFF and list_ok(pc) and rd(pc + 1) & 0xF0 == 0x80 and pc + 1 + 11 * rd(pc) <= hi:
                    plan.append(("list", pc, rd(pc))); pc += 1 + 11 * rd(pc); continue
                ops, end = decode(pc)
                if not ops or end > hi:
                    break
                ptrs = [op[3] if op[1] == "flag" else op[2] if op[1] == "list" else op[4]
                        for op in ops if op[1] in ("flag", "list", "flags")]
                if not all(list_ok(q) for q in ptrs):
                    break
                plan.append(("sel", pc, (ops, end))); pc = end
            if pc != hi or not plan:
                continue
            for kind, a, x in plan:
                if kind == "list":
                    add_list(a, x)
                    nl += 1
                else:
                    ops, end = x
                    taken.append((B, a, end))
                    for q in [q for q in dl if a < q < end]:
                        del dl[q]
                    for k in [k for k in self.dtab[B] if a <= k < end]:
                        del self.dtab[B][k]
                    dl.setdefault(a, f"Data_{B:03X}_{a:04X}")
                    if dl[a].startswith("Data_"):
                        self.dalias.setdefault((B, a), dl[a])
                        dl[a] = f"ObjSelector_{a:04X}"
                    self.dreason[(B, a)] = "map object selector found by tiling a gap"
                    self.objsel_at[(B, a)] = {"ops": ops, "end": end}
                    ns += 1
            tiled += 1
        log(f"map objects: {nl} object lists, {na} screen arrays, {ns} selectors ({tiled} gaps tiled)")

    def emit_object_selector(self, bank: int, p: int, sel: dict, out: list[str]) -> None:
        dl = self.dlabels[bank]
        lab = lambda a: (self.table_at[(bank, a)]["label"] if (bank, a) in self.table_at else dl.get(a, f"${a:04X}"))
        out.append("")
        out.append("; map object selector (E-0163): the first entry that applies picks the object list")
        out.append(f"{dl[p]}:: ; heuristic: {self.dreason.get((bank, p), 'map object selector')}; C0")
        if (bank, p) in self.dalias:
            out.append(f"{self.dalias[(bank, p)]}:: ; address name")
        for op in sel["ops"]:
            if op[1] == "end":
                out.append("    objsel_none")
            elif op[1] == "list":
                out.append(f"    objsel_list {lab(op[2])}")
            elif op[1] == "flag":
                out.append(f"    objsel_unless_flag ${op[2]:04X}, {lab(op[3])}")
            elif op[1] == "flags":
                out.append(f"    objsel_unless_flags ${op[2]:04X}, ${op[3]:04X}, {lab(op[4])}")
            else:
                macro = "objsel_skip_if_clear" if op[2] == 0xFC else "objsel_skip_if_set"
                out.append(f"    {macro} ${op[3]:04X}, ${op[4]:02X}, ${op[5]:02X}")

    def tile_keyworld_screen_gaps(self) -> None:
        """E-0222: after a key-world screen map stream, the bytes up to the next known layout that
        tile exactly as further 360-byte screen streams, each optionally behind an 8-byte screen
        header (the E-0146 layout), are those screens; no chunk group reaches them."""
        from lzss_gfx import decompress as lz
        spans = sorted([(t["bank"], t["addr"], t["addr"] + t.get("tail", 0) + t["count"] * sum(
            2 if f["type"] == "ptr" else f.get("size", 1) for f in t["fields"])) for t in self.schemas])

        def screen(b: int, a: int):
            try:
                out, used, ev = lz(self.data, b, a)
            except IndexError:
                return None
            return used if len(out) == 360 and not ev["unwritten_reads"] and a - 0x4000 + used <= BANK else None

        added = gaps = 0
        for (b, a), (size, used) in sorted(self.streams.items()):
            if size != 360 or "screen" not in self.dreason.get((b, a), ""):
                continue
            lo = a + used
            marks = [x for x in self.dlabels[b] if x >= lo] + [x for (bb, x) in self.streams if bb == b and x >= lo] + \
                    [s for bb, s, e in spans if bb == b and s >= lo] + [0x8000]
            hi = min(marks)
            if hi == lo or hi - lo > 0x1000 or any(x in self.covered[b] for x in range(lo, hi)):
                continue
            pc, plan = lo, []
            while pc < hi:
                if hi - pc == 8 and (b, hi) in self.streams:  # the header of the stream that follows
                    plan.append((pc, None, 0)); pc = hi; continue
                u = screen(b, pc)
                if u and pc + u <= hi:
                    plan.append((None, pc, u)); pc += u; continue
                u = screen(b, pc + 8) if pc + 8 < hi else None
                if u and pc + 8 + u <= hi:
                    plan.append((pc, pc + 8, u)); pc += 8 + u; continue
                break
            if pc != hi or not plan:
                continue
            gaps += 1
            for hdr, s, u in plan:
                if s is None:  # a header only
                    self.schemas.append({"bank": b, "addr": hdr, "label": f"KeyWorldScreenHeader_{b:02X}_{hdr:04X}",
                                         "count": 1, "fields": [{"type": "db", "size": 8, "name": "screen header"}],
                                         "note": "E-0222 (derived: the 8-byte header of the screen stream that follows)"})
                    continue
                if hdr is not None:
                    self.schemas.append({"bank": b, "addr": hdr, "label": f"KeyWorldScreenHeader_{b:02X}_{hdr:04X}",
                                         "count": 1, "fields": [{"type": "db", "size": 8, "name": "screen header"}],
                                         "note": "E-0222 (derived: an 8-byte key-world screen header (bytes 6-7 pick "
                                                 "the AutomapBlocks entry, E-0146) found by tiling a gap)"})
                self.streams[(b, s)] = (360, u)
                self.dlabels[b].setdefault(s, f"Data_{b:03X}_{s:04X}")
                self.dreason.setdefault((b, s), "key-world screen map found by tiling a gap after another")
                added += 1
        log(f"key-world screen gaps tiled: {gaps} ({added} streams)")

    def add_tile_copy_lists(self) -> None:
        """E-0225: VRAM destination lists (HL, words up to one whose low byte is $FF) and their
        source lists (DE, as many words) passed to tile-list copiers: routines whose first 64
        bytes load B = $1F, C = $10, call CopyFromBankWaitVRAM and compare with $FF."""
        cfb = {k for k, info in self.names.items() if info["name"] == "CopyFromBankWaitVRAM"}
        if not cfb:
            return
        copiers = set()
        for b in range(self.nbanks):
            ins = self.insn[b]
            for a, lab in self.labels[b].items():
                if a not in ins or ins[a][0] == "dw":
                    continue
                texts, calls, pc = [], set(), a
                while pc in ins and ins[pc][0] != "dw" and pc - a < 64:
                    v = ins[pc]
                    texts.append(v[1])
                    if v[2] == "call" and v[3] is not None:
                        calls.add(self.resolve(b, v[3]))
                    pc += v[0]
                if "ld b, $1F" in texts and "ld c, $10" in texts and "cp a, $FF" in texts and calls & cfb:
                    copiers.add((b, a))
        taken = [(t["bank"], t["addr"], t["addr"] + t.get("tail", 0) + t["count"] * sum(
            2 if f["type"] == "ptr" else f.get("size", 1) for f in t["fields"])) for t in self.schemas]
        ld_hl = re.compile(r"ld hl, \$([0-9A-F]{4})$")
        ld_de = re.compile(r"ld de, \$([0-9A-F]{4})$")
        pairs = set()
        for cb in range(1, self.nbanks):
            ins = self.insn[cb]
            order = sorted(a for a, v in ins.items() if v[0] != "dw")
            for k, a in enumerate(order):
                v = ins[a]
                if v[2] not in ("call", "jp") or v[3] is None or self.resolve(cb, v[3]) not in copiers:
                    continue
                hl = de = None
                for x in reversed(order[max(0, k - 4):k]):
                    if ins[x][2] in SETUP_BARRIER:
                        break
                    if hl is None and (m := ld_hl.match(ins[x][1])):
                        hl = int(m.group(1), 16)
                    if de is None and (m := ld_de.match(ins[x][1])):
                        de = int(m.group(1), 16)
                if hl and de and 0x4000 <= hl < 0x8000 and 0x4000 <= de < 0x8000:
                    pairs.add((cb, hl, de))
        made = 0
        done: set[tuple[int, int]] = set()
        for cb, hl, de in sorted(pairs):
            n = 0
            o = cb * BANK - self.base(cb)
            while hl + 2 * n < 0x8000 and self.data[o + hl + 2 * n] != 0xFF and n < 128:
                n += 1
            if n == 128 or hl + 2 * n + 2 > 0x8000:
                continue
            src_n = n + (1 if self._u16(cb, de + 2 * n) == 0xFFFF else 0)
            for addr, size, kind in ((hl, 2 * n + 2, "Dest"), (de, 2 * src_n, "Src")):
                if (cb, addr) in done or size == 0:
                    continue
                end = addr + size
                if any(b == cb and lo < end and addr < hi for b, lo, hi in taken) or \
                        any(q in self.covered[cb] for q in range(addr, end)):
                    continue
                taken.append((cb, addr, end))
                done.add((cb, addr))
                self.schemas.append({"bank": cb, "addr": addr, "label": f"TileCopy{kind}List_{cb:02X}_{addr:04X}",
                                     "count": 1, "fields": [{"type": "words", "size": size, "per_line": 8,
                                                             "ram": kind == "Dest",
                                                             "name": "VRAM destinations, then $FFxx" if kind == "Dest"
                                                             else "bank-$1F tile sources"}],
                                     "note": "E-0225 (derived: a list passed to a tile-list copier, which copies 16 "
                                             "bytes from bank $1F per destination until a low byte of $FF)"})
                made += 1
        log(f"tile copy lists derived: {made} ({len(copiers)} copiers)")

    def add_string_table_schemas(self) -> None:
        """E-0217: string tables passed in DE to BeginStringDisplay / CopyStringToBuffer.

        LookupString reads word wStringCategory of the table at DE (a category list), then word
        wStringIndex of that list (a string). The category table runs to its lowest target; each
        list runs to the next list, the last one to the lowest string it names. Tables that
        overlap another layout are left alone."""
        users = {(b, a) for (b, a), info in self.names.items() if not info.get("data")
                 and info["name"] in ("BeginStringDisplay", "CopyStringToBuffer")}
        if not users:
            return
        ld_de = re.compile(r"ld de, \$([0-9A-F]{4})$")
        taken = [(t["bank"], t["addr"], t["addr"] + t.get("tail", 0) + t["count"] * sum(
            2 if f["type"] == "ptr" else f.get("size", 1) for f in t["fields"])) for t in self.schemas]
        tables = set()
        for cb in range(1, self.nbanks):
            ins = self.insn[cb]
            order = sorted(a for a, v in ins.items() if v[0] != "dw")
            for k, a in enumerate(order):
                v = ins[a]
                if v[2] not in ("call", "jp") or v[3] is None or self.resolve(cb, v[3]) not in users:
                    continue
                for x in reversed(order[max(0, k - 3):k]):
                    if ins[x][2] in SETUP_BARRIER:
                        break
                    if (m := ld_de.match(ins[x][1])):
                        tables.add((cb, int(m.group(1), 16)))
                        break
        made = 0
        for cb, t in sorted(tables):
            if not 0x4000 <= t < 0x8000:
                continue
            w = lambda a: self._u16(cb, a)
            cats, p = [], t
            while p < 0x8000 and (not cats or p < min(cats)):
                x = w(p)
                if not (p < x < 0x8000):
                    break
                cats.append(x)
                p += 2
            if not cats or p != min(cats):
                continue
            lists = sorted(set(cats))
            strings: list[int] = []
            ok = True
            for i, ls in enumerate(lists):
                end = lists[i + 1] if i + 1 < len(lists) else None
                q, items = ls, []
                while q < 0x8000 and (end is None or q < end) and (not strings or q < min(strings)) \
                        and (not items or q < min(items)):
                    x = w(q)
                    if not (lists[-1] <= x < 0x8000):
                        break
                    items.append(x)
                    q += 2
                if not items or (end is not None and q != end):
                    ok = False
                    break
                strings += items
            if not ok:
                continue
            spans = [(t, p)] + [(ls, (lists[i + 1] if i + 1 < len(lists) else min(strings))) for i, ls in enumerate(lists)]
            if any(b == cb and lo < e and s < hi for s, e in spans for b, lo, hi in taken) or \
                    any(a in self.covered[cb] for s, e in spans for a in range(s, e)):
                continue
            label = self.labels[cb].get(t) or f"StringCategories_{cb:02X}_{t:04X}"
            self.schemas.append({"bank": cb, "addr": t, "label": f"StringCategories_{cb:02X}_{t:04X}",
                                 "count": len(cats), "id_base": 0,
                                 "fields": [{"type": "ptr", "name": "string list", "reason": "string list"}],
                                 "note": "E-0217 (derived: string table passed in DE to BeginStringDisplay or "
                                         "CopyStringToBuffer; LookupString reads word wStringCategory, then word "
                                         "wStringIndex of that list)"})
            for i, (s, e) in enumerate(spans[1:]):
                self.schemas.append({"bank": cb, "addr": s, "label": f"StringList_{cb:02X}_{s:04X}",
                                     "count": (e - s) // 2, "id_base": 0,
                                     "fields": [{"type": "ptr", "name": "string", "reason": "string"}],
                                     "note": f"E-0217 (derived: category list of StringCategories_{cb:02X}_{t:04X}; "
                                             f"one pointer per wStringIndex)"})
            taken += [(cb, s, e) for s, e in spans]
            made += 1
        log(f"string tables derived: {made}")

    def add_rect_record_schemas(self) -> None:
        """Lay out the tile-rectangle records HL points at for the record copiers (E-0161).

        CopyRecordRectToScreenBuffer and its copies read a word offset into wScreenTileBuffer
        (32-byte rows), a width and a row count, then width * rows tile bytes. Sources are the
        `ld hl, n` within three instructions before a call or jump to one of them; a record is
        used only when it fits the bank and touches no code, table or other layout."""
        copiers = {(b, a) for (b, a), info in self.names.items()
                   if info["name"].startswith(("CopyRecordRectToScreenBuffer",)) and not info.get("data")}
        # E-0216: every copy of the two families that read this header (same first 16 bytes)
        sig16 = lambda b, a: bytes(self.data[b * BANK + a - self.base(b):b * BANK + a - self.base(b) + 16])
        fam_sigs = {sig16(int(f["canonical"][:2], 16), int(f["canonical"][3:], 16)) for f in self.families
                    if f["name"] in ("CopyRecordRectToScreenBuffer", "ReadScreenBufferRectHeader")}
        copiers |= {(b, a) for b in range(self.nbanks) for a in self.labels[b]
                    if a in self.insn[b] and a <= self.base(b) + BANK - 16 and sig16(b, a) in fam_sigs}
        taken = [(t["bank"], t["addr"], t["addr"] + t.get("tail", 0) + t["count"] * sum(
            2 if f["type"] == "ptr" else f.get("size", 1) for f in t["fields"])) for t in self.schemas]
        def add_record(cb: int, src: int) -> bool:
            o = cb * BANK + src - self.base(cb)
            w, rows = self.data[o + 2], self.data[o + 3]
            end = src + 4 + w * rows
            if not (0 < w <= 32 and 0 < rows <= 32) or end > 0x8000 or                     any(p in self.covered[cb] for p in range(src, end)) or                     any(b == cb and lo < end and src < hi for b, lo, hi in taken) or                     any(b == cb and a2 < end and src < a2 + used for (b, a2), (_, used) in self.streams.items()):
                return False
            taken.append((cb, src, end))
            off = self.data[o] | self.data[o + 1] << 8
            self.schemas.append({
                "bank": cb, "addr": src, "label": f"TileRect_{cb:02X}_{src:04X}", "count": 1,
                "fields": [{"type": "words", "size": 2, "name": "offset into wScreenTileBuffer"},
                           {"type": "db", "size": 2, "line": True, "name": "width, rows"}]
                          + [{"type": "db", "size": w, "line": True, "name": f"row {r}"} for r in range(rows)],
                "record": f"offset ${off:04X} (row {off // 32}, column {off % 32}); {w} x {rows} tiles",
                "note": "E-0161 (derived: a tile-rectangle record for CopyRecordRectToScreenBuffer)"})
            return True

        ld_hl = re.compile(r"ld hl, \$([0-9A-F]{4})$")
        found = 0
        for cb in range(self.nbanks):
            ins = self.insn[cb]
            order = sorted(a for a, v in ins.items() if v[0] != "dw")
            for k, a in enumerate(order):
                v = ins[a]
                if v[2] not in ("call", "jp") or v[3] is None or self.resolve(cb, v[3]) not in copiers:
                    continue
                src = None
                for x in reversed(order[max(0, k - 3):k]):
                    if ins[x][2] in SETUP_BARRIER:
                        break
                    if (m := ld_hl.match(ins[x][1])):
                        src = int(m.group(1), 16)
                        break
                if src is None and k >= 3 and [ins[order[k - j]][1] for j in (3, 2, 1)] ==                         ["ld a, [hl+]", "ld h, [hl]", "ld l, a"]:
                    # E-0221: HL = word n of a table of records (ld hl, T / index / deref)
                    for x in reversed(order[max(0, k - 10):k - 3]):
                        if ins[x][2] in SETUP_BARRIER:
                            break
                        if (m := ld_hl.match(ins[x][1])):
                            tab = int(m.group(1), 16)
                            recs = []
                            while 0x4000 <= tab + 2 * len(recs) < 0x8000 and len(recs) < 64:
                                r = self._u16(cb, tab + 2 * len(recs))
                                if not (tab < r < 0x8000) or (recs and tab + 2 * len(recs) >= min(recs)):
                                    break
                                recs.append(r)
                            if recs and tab + 2 * len(recs) <= min(recs) and                                     not any(b == cb and lo < tab + 2 * len(recs) and tab < hi for b, lo, hi in taken)                                     and not any(q in self.covered[cb] for q in range(tab, tab + 2 * len(recs))):
                                good = [r for r in recs if add_record(cb, r)]
                                if good:
                                    taken.append((cb, tab, tab + 2 * len(recs)))
                                    self.schemas.append({
                                        "bank": cb, "addr": tab, "label": f"TileRectTable_{cb:02X}_{tab:04X}",
                                        "count": len(recs), "id_base": 0,
                                        "fields": [{"type": "ptr", "name": "rectangle record", "reason": "rectangle record"}],
                                        "note": "E-0221 (derived: a word table of tile-rectangle records; the code "
                                                "derefs one entry into HL for a record copier)"})
                                    found += len(good)
                            break
                    continue
                if src is None or not 0x4000 <= src < 0x8000:
                    continue
                found += add_record(cb, src)

        log(f"tile-rectangle records: {found}")
        # Raw rectangles (E-0161): DE = packed source, B = width, C = rows, for the copiers whose
        # source rows are contiguous. Copies of a canonical routine (same first 16 bytes) count too.
        canon = {(b, a) for (b, a), info in self.names.items() if not info.get("data") and
                 info["name"] in ("CopyRectToBGMap", "CopyRectToBGMapWrapped", "CopyRectToBGMapWrapped_Bank1D",
                                  "CopyRectToBGMapWrapped_1C", "CopyRectTo20ByteRowsJp_Bank24",
                                  "DrawRectSetTextCursorLoPlus21_Bank1D", "DrawRectBothBanksSetTextCursorLoPlus1C1_Bank1D",
                                  "DrawRectBothBanksSetTextCursorLoPlus1C1")}  # E-0226: wrappers that copy from DE
        canon |= {(int(f["canonical"][:2], 16), int(f["canonical"][3:], 16)) for f in self.families
                  if f["name"] == "CopyRectTo20ByteRows"}
        sig = lambda b, a: bytes(self.data[b * BANK + a - self.base(b):b * BANK + a - self.base(b) + 16])
        sigs = {sig(b, a) for b, a in canon}
        raw_copiers = {(b, a) for b in range(self.nbanks) for a in self.labels[b]
                       if a in self.insn[b] and a <= self.base(b) + BANK - 16 and sig(b, a) in sigs}
        ld_de = re.compile(r"ld de, \$([0-9A-F]{4})$")
        ld_bc = re.compile(r"ld bc, \$([0-9A-F]{2})([0-9A-F]{2})$")
        ld_a = re.compile(r"ld a, \$([0-9A-F]{2})$")
        bank_copiers = {(b, a) for (b, a), info in self.names.items() if not info.get("data") and
                        info["name"] in ("CopyRectFromBankToVRAM", "CopyRectFromBankToBGMapWrapped")}
        raw_copiers |= bank_copiers  # A = the source's ROM bank
        uses: dict[tuple[int, int], set] = {}
        for cb in range(self.nbanks):
            ins = self.insn[cb]
            order = sorted(a for a, v in ins.items() if v[0] != "dw")
            for k, a in enumerate(order):
                v = ins[a]
                if v[2] not in ("call", "jp") or v[3] is None or self.resolve(cb, v[3]) not in raw_copiers:
                    continue
                de = bc = sb = None
                for x in reversed(order[max(0, k - 4):k]):
                    if ins[x][2] in SETUP_BARRIER:
                        break
                    if de is None and (m := ld_de.match(ins[x][1])):
                        de = int(m.group(1), 16)
                    if bc is None and (m := ld_bc.match(ins[x][1])):
                        bc = (int(m.group(1), 16), int(m.group(2), 16))
                    if sb is None and (m := ld_a.match(ins[x][1])):
                        sb = int(m.group(1), 16)
                if self.resolve(cb, v[3]) not in bank_copiers:
                    sb = cb
                if de is None or bc is None or sb is None or not 0x4000 <= de < 0x8000 or not 0 < sb < self.nbanks:
                    continue
                uses.setdefault((sb, de), set()).add(bc)
        # DrawTileRectFromArg1Params (and copies with the same first 16 bytes): wArg1/wArg2 = source
        # (high, low), wArg3 = width, wArg4 = rows, set through `ld a, n` / `ld [wArgN], a` (E-0177).
        arg_canon = {(b, a) for (b, a), info in self.names.items() if not info.get("data") and
                     info["name"] == "DrawTileRectFromArg1Params"}
        arg_sigs = {sig(b, a) for b, a in arg_canon}
        arg_copiers = {(b, a) for b in range(self.nbanks) for a in self.labels[b]
                       if a in self.insn[b] and a <= self.base(b) + BANK - 16 and sig(b, a) in arg_sigs}
        far_rect = {}  # (bank, rst $10 address) -> bank of the far-called copier (E-0187)
        for (bank, a), t in self.banked_call_args().items():
            for nxt in (a + 3, a + 5):
                if self.insn[bank].get(nxt, ("", "", ""))[2] == "rst" and t in arg_canon:
                    far_rect[(bank, nxt)] = t[0]
        for cb in range(self.nbanks):
            ins = self.insn[cb]
            order = sorted(a for a, v in ins.items() if v[0] != "dw")
            for k, a in enumerate(order):
                v = ins[a]
                db = far_rect.get((cb, a), cb)
                if (cb, a) not in far_rect and (
                        v[2] not in ("call", "jp") or v[3] is None or self.resolve(cb, v[3]) not in arg_copiers):
                    continue
                window = order[max(0, k - 16):k]
                stores: dict[int, int] = {}
                de = None
                for j, x in enumerate(window):
                    t = ins[x][1]
                    if (m := ld_de.match(t)):
                        de = int(m.group(1), 16)
                    m = re.match(r"ld \[\$D7F([1-4])\], a$", t)
                    if m and j:
                        prev = ins[window[j - 1]][1]
                        if (mm := ld_a.match(prev)):
                            stores[int(m.group(1))] = int(mm.group(1), 16)
                        elif prev == "ld a, d" and de is not None:
                            stores[int(m.group(1))] = de >> 8
                        elif prev == "ld a, e" and de is not None:
                            stores[int(m.group(1))] = de & 0xFF
                if all(i in stores for i in (1, 2, 3, 4)):
                    src = stores[1] << 8 | stores[2]
                    if 0x4000 <= src < 0x8000:
                        uses.setdefault((db, src), set()).add((stores[3], stores[4]))
        # The DrawTileRectAtHLFromDE_Bank* relays (E-0187): DE = source in DrawTileRectFromArg1Params'
        # bank, wArg3/wArg4 = width and rows stored by the caller.
        rect_bank = next((b for b, a in arg_canon), None)
        relays = self._rect_relays()
        for cb in range(self.nbanks):
            ins = self.insn[cb]
            order = sorted(a for a, v in ins.items() if v[0] != "dw")
            for k, a in enumerate(order):
                v = ins[a]
                if rect_bank is None or v[2] != "call" or v[3] is None or self.resolve(cb, v[3]) not in relays:
                    continue
                de, stores = None, {}
                window = order[max(0, k - 12):k]
                for j in range(len(window) - 1, -1, -1):
                    t = ins[window[j]][1]
                    if ins[window[j]][2] in SETUP_BARRIER:
                        break
                    if de is None and (m := ld_de.match(t)):
                        de = int(m.group(1), 16)
                    m = re.match(r"ld \[\$D7F([34])\], a$", t)
                    if m and j and int(m.group(1)) not in stores and (mm := ld_a.match(ins[window[j - 1]][1])):
                        stores[int(m.group(1))] = int(mm.group(1), 16)
                if de is not None and 0x4000 <= de < 0x8000 and 3 in stores and 4 in stores:
                    uses.setdefault((rect_bank, de), set()).add((stores[3], stores[4]))
        raw = 0
        for (cb, src), dims in sorted(uses.items()):
            widths = {w for w, _ in dims}
            if len(widths) != 1:
                continue
            w = widths.pop()
            rows = max(r for _, r in dims)
            end = src + w * rows
            if not (0 < w <= 32 and 0 < rows <= 32) or end > 0x8000 or \
                    any(p in self.covered[cb] for p in range(src, end)) or \
                    any(b == cb and lo < end and src < hi for b, lo, hi in taken) or \
                    any(b == cb and a2 < end and src < a2 + used for (b, a2), (_, used) in self.streams.items()):
                continue
            taken.append((cb, src, end))
            self.schemas.append({
                "bank": cb, "addr": src, "label": f"TileRect_{cb:02X}_{src:04X}", "count": rows,
                "fields": [{"type": "db", "size": w, "line": True, "name": "row"}], "id_base": 0,
                "record": f"{w} x {rows} tiles, one row per line",
                "note": "E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, "
                        "as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and "
                        "wArg4 = rows)"})
            raw += 1
        log(f"raw tile rectangles: {raw}")
        # Palette sources (E-0164): CopyFromBank (DE, bank B, HL, C bytes) and CopyBytesDEToHL_Bank00
        # (DE in this bank or bank 0, HL, BC bytes) into wBGPaletteBuffer / wOBJPaletteBuffer
        # ($C49F-$C51E), and LoadBGPaletteBufferFromBank (DE, bank B, $40 bytes).
        pal_fns = {(b, a): info["name"] for (b, a), info in self.names.items() if not info.get("data") and
                   info["name"] in ("CopyFromBank", "CopyBytesDEToHL_Bank00", "LoadBGPaletteBufferFromBank")}
        ld_hl = re.compile(r"ld hl, \$([0-9A-F]{4})$")
        ld_b = re.compile(r"ld b, \$([0-9A-F]{2})$")
        ld_c = re.compile(r"ld c, \$([0-9A-F]{2})$")
        pals: dict[tuple[int, int], int] = {}
        for cb in range(self.nbanks):
            ins = self.insn[cb]
            order = sorted(a for a, v in ins.items() if v[0] != "dw")
            for k, a in enumerate(order):
                v = ins[a]
                fn = pal_fns.get(self.resolve(cb, v[3])) if v[2] in ("call", "jp") and v[3] is not None else None
                if not fn:
                    continue
                regs: dict[str, int] = {}
                for x in reversed(order[max(0, k - 6):k]):
                    if ins[x][2] in SETUP_BARRIER:
                        break
                    for r, rx in (("de", ld_de), ("hl", ld_hl), ("b", ld_b), ("c", ld_c), ("bc", ld_bc)):
                        if r not in regs and (m := rx.match(ins[x][1])):
                            regs[r] = int("".join(m.groups()), 16)
                de = regs.get("de")
                if de is None or not 0x4000 <= de < 0x8000:
                    continue
                if fn == "LoadBGPaletteBufferFromBank":
                    sb, n = regs.get("b"), 0x40
                elif fn == "CopyFromBank":
                    sb, n = regs.get("b"), regs.get("c")
                    if not 0xC49F <= regs.get("hl", 0) < 0xC51F:
                        continue
                else:
                    sb, n = cb, regs.get("bc")
                    if not 0xC49F <= regs.get("hl", 0) < 0xC51F:
                        continue
                if sb is None or n is None or not 0 < sb < self.nbanks or n % 8 or not 0 < n <= 0x40:
                    continue
                pals[(sb, de)] = max(pals.get((sb, de), 0), n)
        npal = 0
        for (sb, src), n in sorted(pals.items()):
            end = src + n
            o = sb * BANK + src - self.base(sb)
            if end > 0x8000 or any(self.data[o + j + 1] & 0x80 for j in range(0, n, 2)) or \
                    any(p in self.covered[sb] for p in range(src, end)) or \
                    any(b == sb and lo < end and src < hi for b, lo, hi in taken) or \
                    any(b == sb and a2 < end and src < a2 + used for (b, a2), (_, used) in self.streams.items()):
                continue
            taken.append((sb, src, end))
            self.schemas.append({"bank": sb, "addr": src, "label": f"Palettes_{sb:02X}_{src:04X}", "count": n // 8,
                                 "id_base": 0, "fields": [{"type": "words", "size": 8, "name": "one CGB palette: 4 BGR555 colours"}],
                                 "note": f"E-0164 (derived: {n} bytes copied into a palette buffer by CopyFromBank, "
                                         "CopyBytesDEToHL_Bank00 or LoadBGPaletteBufferFromBank)"})
            npal += 1
        log(f"palette sources: {npal}")
        # Uncompressed tiles (E-0168): sources of copies into vTiles ($8000-$97FF) whose length is
        # a multiple of 16: CopyBBytesToVRAMFromDE (DE -> HL, B bytes), CopyCBytesToVRAMWaitSTAT
        # (HL -> DE, C bytes) and CopyFromBank (DE in bank B -> HL, C bytes).
        tile_fns = {(b, a): info["name"] for (b, a), info in self.names.items() if not info.get("data") and
                    info["name"] in ("CopyBBytesToVRAMFromDE", "CopyCBytesToVRAMWaitSTAT", "CopyFromBank")}
        tiles: dict[tuple[int, int], int] = {}
        for cb in range(self.nbanks):
            ins = self.insn[cb]
            order = sorted(a for a, v in ins.items() if v[0] != "dw")
            for k, a in enumerate(order):
                v = ins[a]
                fn = tile_fns.get(self.resolve(cb, v[3])) if v[2] in ("call", "jp") and v[3] is not None else None
                if not fn:
                    continue
                regs: dict[str, int] = {}
                for x in reversed(order[max(0, k - 6):k]):
                    if ins[x][2] in SETUP_BARRIER:
                        break
                    for r, rx in (("de", ld_de), ("hl", ld_hl), ("b", ld_b), ("c", ld_c)):
                        if r not in regs and (m := rx.match(ins[x][1])):
                            regs[r] = int("".join(m.groups()), 16)
                if fn == "CopyBBytesToVRAMFromDE":
                    src, dst, n, sb = regs.get("de"), regs.get("hl"), regs.get("b"), cb
                elif fn == "CopyCBytesToVRAMWaitSTAT":
                    src, dst, n, sb = regs.get("hl"), regs.get("de"), regs.get("c"), cb
                else:
                    src, dst, n, sb = regs.get("de"), regs.get("hl"), regs.get("c"), regs.get("b")
                if None in (src, dst, n, sb) or not 0x8000 <= dst < 0x9800 or not n or n % 16:
                    continue
                if not 0x4000 <= src < 0x8000:
                    if src < 0x4000:
                        sb = 0
                    else:
                        continue
                if not 0 <= sb < self.nbanks:
                    continue
                tiles[(sb, src)] = max(tiles.get((sb, src), 0), n)
        nt = 0
        for (sb, src), n in sorted(tiles.items()):
            end = src + n
            if end > self.base(sb) + BANK or any(p in self.covered[sb] for p in range(src, end)) or \
                    any(b == sb and lo < end and src < hi for b, lo, hi in taken) or \
                    any(b == sb and a2 < end and src < a2 + used for (b, a2), (_, used) in self.streams.items()):
                continue
            taken.append((sb, src, end))
            self.schemas.append({"bank": sb, "addr": src, "label": f"Tiles_{sb:02X}_{src:04X}", "count": n // 16,
                                 "id_base": 0, "fields": [{"type": "db", "size": 16, "line": True, "name": "tile"}],
                                 "record": "one 16-byte tile (2bpp) per line",
                                 "note": f"E-0168 (derived: {n} bytes copied into vTiles uncompressed)"})
            nt += 1
        log(f"uncompressed tile sources: {nt}")

    def prepare_tables(self) -> None:
        """Validate config/tables.json against the ROM and register data labels for their
        pointer targets. Raises if a layout overlaps code or an existing label would fall in
        the middle of a field (it could not be emitted)."""
        for t in self.schemas:
            bank, addr, count = t["bank"], t["addr"], t["count"]
            fields = t["fields"]
            sizes = [2 if f["type"] == "ptr" else f.get("size", 1) for f in fields]
            stride = sum(sizes)
            end = addr + stride * count + t.get("tail", 0)  # "tail": bytes after the records, e.g. a terminator
            cov, dt, dl = self.covered[bank], self.dtab[bank], self.dlabels[bank]
            ins = self.insn[bank]
            for a in [a for a in ins if addr <= a < end and ins[a][0] == "dw"]:
                del ins[a]  # an inline `dw` the tracer found at the start of this table
                cov.discard(a)
                cov.discard(a + 1)
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
                    why = self.dreason.get((bank, a), "")
                    if not why or any(k in why for k in ("pointer load", "stream", "monotone pointer table",
                                                          "bank from RAM variable")):
                        del dl[a]  # a guess (C0) inside a table the configuration proves
                        self.streams.pop((bank, a), None)
                        continue
                    raise AssertionError(f"label {dl[a]} ({why}) falls inside a field of table {t['label']}")
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
                    tb = vals[f["bank_from"]] if "bank_from" in f else int(f.get("target_bank", "%X" % bank), 16)
                    tgt = vals[fi]
                    if f.get("name_targets") and tgt and (tb, tgt) not in self.names and tgt in self.insn[tb] and not (
                            f.get("name_unique_only") and sum(
                                1 for j in range(count) if self._u16(bank, addr + j * stride) == tgt) > 1):
                        # the first table entry that points at a routine names it (E-0038)
                        self.names[(tb, tgt)] = {
                            "name": f"{f['name_targets']}{i + f.get('name_base', 0):02X}",
                            "note": f"{f.get('name_note', 'handler')} {i + f.get('name_base', 0):02X} "
                                    f"(entry {i} of {t['label']})",
                            "evidence": "structure of the table"}
                    if tb in range(self.nbanks) and tb not in self.zero and \
                            self.base(tb) <= tgt < self.base(tb) + BANK and tgt not in self.covered[tb] \
                            and not (tb == bank and addr <= tgt < end):
                        self.dlabels[tb].setdefault(tgt, f"Data_{tb:03X}_{tgt:04X}")
                        self.dreason.setdefault((tb, tgt), f.get("reason", "pointer in a sound table"))
            dl.setdefault(addr, f"Data_{bank:03X}_{addr:04X}")  # a data slice must start at the table
            self.dreason.setdefault((bank, addr), "start of a structured table")
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
            # E-0190: the last track ends at an `end` event after which only one fill byte repeats
            # up to the next label, decoded code or the end of the bank.
            p = ptrs[-1] if ptrs else None
            if p is None or not 0x4000 <= p < 0x8000 or (bank, p) in self.track_at:
                continue
            limit = min([a for a in dl if a > p] + [0x8000])
            limit = next((a for a in range(p, limit) if a in self.covered[bank]), limit)
            off, evs, end = p - 0x4000 + 4, [], None
            while off < limit - 0x4000:
                ev, n = decode_event(bd, off)
                if off + n > limit - 0x4000:
                    break
                evs.append(ev)
                off += n
                rest = bd[off:limit - 0x4000]
                if ev["kind"] == "end" and len(set(rest)) <= 1:
                    end = off + 0x4000
                    break
            if end is None:
                skipped += 1
                continue
            for k in [k for k in dt if p <= k < end]:
                del dt[k]
            self.track_at[(bank, p)] = {"events": evs, "end": end, "header": decode_header(bd, p - 0x4000)}
            used += 1
        log(f"sound tracks emitted as events: {used} (skipped {skipped}; "
            f"{sum(len(v['events']) for v in self.track_at.values())} events)")

    SCRIPT_ARGS = {0x00: 2, 0x01: 3, 0x02: 3, 0x03: 2, 0x04: 2, 0x05: 2, 0x06: 1, 0x07: 2, 0x0A: 2, 0x0B: 1,
                   0x0C: 1, 0x0D: 1, 0x0E: 2, 0x0F: 1, 0xE4: 2, 0xE7: 2, 0xEA: 2, 0xF5: 2}

    def prepare_scripts(self) -> None:
        """Decode the event scripts that code starts in bank $10 (E-0152).

        An entry is the `ld hl, n` before a call to StartScriptAtHL_*, unless wScriptInDataBank
        is written nearby (then the bytes come from the data bank instead). FetchScriptCommand
        (bank $10) reads the opcode; ScriptOpcodeHandlers says which opcodes exist; SCRIPT_ARGS
        gives the inline bytes the dedicated fetch handlers read (every other opcode only names
        the command type). $06 skips forward by its byte when wTextYesNoResult is 0, $07 jumps,
        $E4 jumps by one of N forward offsets (wTwoChoiceCursor; N from the layout, E-0188), $E7 continues in the data
        bank, $FF ends the script. The data bank is the one the caller stores in wDataBank before
        StartScriptAtHL_* (`ld a, n` / `ld [wDataBank], a`); $E7 targets are traced there (E-0160)."""
        b = 0x10
        oh = next((t for t in self.schemas if t["label"] == "ScriptOpcodeHandlers"), None)
        self.script_at: dict[tuple[int, int], dict] = {}
        self.script_refs: dict[tuple[int, int], str] = {}
        if not oh:
            return
        valid = {i for i in range(oh["count"]) if self._u16(b, oh["addr"] + 2 * i)}
        starters = {(sb, a) for (sb, a), info in self.names.items()
                    if info["name"].startswith("StartScriptAtHL") and not info.get("data")}
        ld_hl = re.compile(r"ld hl, \$([0-9A-F]{4})$")
        ld_a = re.compile(r"ld a, \$([0-9A-F]{2})$")
        sites: list[tuple[int, int, int]] = []
        site_bank: dict[int, set] = {}  # script address -> data banks its callers set (None = unknown)
        entry_like = {k for k, info in self.names.items() if not info.get("data")}
        entry_like |= {t for ts in self.dispatch.values() for t in ts if t}
        for cb in range(self.nbanks):
            for v in self.insn[cb].values():
                if v[0] != "dw" and v[2] in ("call", "callc") and v[3] is not None:
                    entry_like.add(self.resolve(cb, v[3]))
        for cb in range(self.nbanks):
            ins = self.insn[cb]
            order = sorted(a for a, v in ins.items() if v[0] != "dw")
            for k, a in enumerate(order):
                v = ins[a]
                if v[2] not in ("call", "jp") or v[3] is None or self.resolve(cb, v[3]) not in starters:
                    continue
                hl, dbank = None, None
                window = order[max(0, k - 10):k]
                for x in reversed(window):
                    if ins[x][2] in SETUP_BARRIER or "[$D7FD]" in ins[x][1]:
                        break
                    if hl is None and (m := ld_hl.match(ins[x][1])):
                        hl = (x, int(m.group(1), 16))
                for j, x in enumerate(window):  # ld a, $BB / ld [wDataBank], a before the call
                    if ins[x][1] == "ld [$D7FE], a" and j and (m := ld_a.match(ins[window[j - 1]][1])):
                        dbank = int(m.group(1), 16)
                pc, prev = a + v[0], ""  # E-0184: a store after the call, before the script next runs
                for _ in range(16):
                    x = ins.get(pc)
                    if x is None or x[0] == "dw":
                        break
                    if x[2] in ("jr", "jp") and "," not in x[1] and x[3] is not None:
                        pc, prev = x[3], ""  # follow an unconditional jump
                        continue
                    if x[2] in SETUP_BARRIER:
                        break
                    if x[1] == "ld [$D7FE], a":
                        if m := ld_a.match(prev):
                            dbank = int(m.group(1), 16)
                        break
                    pc, prev = pc + x[0], x[1]
                if dbank is None:  # E-0184: the store can open the routine, above its other branches
                    i = k - 1
                    while i > 0 and k - i < 120 and order[i - 1] + ins[order[i - 1]][0] == order[i] \
                            and (cb, order[i]) not in entry_like:
                        if ins[order[i]][1] == "ld [$D7FE], a":
                            if m := ld_a.match(ins[order[i - 1]][1]):
                                dbank = int(m.group(1), 16)
                            break
                        i -= 1
                if hl and 0x4000 <= hl[1] < 0x8000:
                    sites.append((cb, hl[0], hl[1]))
                    site_bank.setdefault(hl[1], set()).add(dbank)
        code: dict[tuple[int, int], tuple[int, bytes]] = {}
        targets: set[tuple[int, int]] = set()
        self.e7_banks: dict[tuple[int, int], set] = {}

        def trace(sb: int, entry: int, dbanks: set) -> list[int]:
            """Trace from (sb, entry); returns the $E7 targets reached."""
            base = sb * BANK - self.base(sb)
            out, todo, seen = [], [entry], set()
            targets.add((sb, entry))
            while todo:
                pc = todo.pop()
                while 0x4000 <= pc < 0x8000 and pc not in seen:
                    seen.add(pc)
                    op = self.data[base + pc]
                    if op != 0xFF and op not in valid:
                        break
                    n = 0 if op == 0xFF else self.SCRIPT_ARGS.get(op, 0)
                    if op == 0xE4:
                        n = self.e4_count(base, pc)
                    code[(sb, pc)] = (op, bytes(self.data[base + pc + 1:base + pc + 1 + n]))
                    arg = code[(sb, pc)][1]
                    nxt = []
                    if op == 0x06:
                        nxt = [pc + 2 + arg[0]]
                    if op == 0x07:
                        nxt = [arg[0] | arg[1] << 8]
                    if op == 0xE4:
                        nxt = [pc + 2 + i + o for i, o in enumerate(arg)]
                    for t in nxt:
                        targets.add((sb, t))
                        todo.append(t)
                    if op == 0xE7:
                        out.append(arg[0] | arg[1] << 8)
                        self.e7_banks.setdefault((sb, pc), set()).update(dbanks)
                    if op in (0xFF, 0x07, 0xE4, 0xE7):
                        break
                    pc += 1 + n
            return out

        data_entries: set[tuple[int, int]] = set()
        for a, banks in site_bank.items():
            for t in trace(b, a, banks):
                for db in banks - {None}:  # E-0160: $E7 continues in the bank the caller set in wDataBank
                    data_entries.add((db, t))
        done = set()
        while data_entries - done:
            sb, t = sorted(data_entries - done)[0]
            done.add((sb, t))
            if 0 < sb < self.nbanks and sb not in self.zero and 0x4000 <= t < 0x8000:
                for t2 in trace(sb, t, {sb}):
                    data_entries.add((sb, t2))
        self.data_script_entries = done
        used = 0
        for sb in sorted({k[0] for k in code}):
            dl, dt = self.dlabels[sb], self.dtab[sb]
            pcs = sorted(pc for bb, pc in code if bb == sb)
            regions, cur = [], []
            for pc in pcs:
                if cur and cur[-1] + 1 + len(code[(sb, cur[-1])][1]) != pc:
                    regions.append(cur)
                    cur = []
                cur.append(pc)
            if cur:
                regions.append(cur)
            for reg in regions:
                lo, hi = reg[0], reg[-1] + 1 + len(code[(sb, reg[-1])][1])
                bounds = set(reg)
                if any(a in self.covered[sb] for a in range(lo, hi)) or any(
                        (sb, a) in self.table_at or (sb, a) in self.track_at or (sb, a) in self.streams
                        for a in range(lo, hi)):
                    continue
                for a in [a for a in dl if lo <= a < hi and a not in bounds]:
                    del dl[a]  # a C0 guess inside a decoded script instruction
                for a in [a for a in dt if lo <= a < hi]:
                    del dt[a]
                for a in reg:
                    if (sb, a) in targets:
                        if a in dl and dl[a].startswith("Data_"):
                            self.dalias.setdefault((sb, a), dl[a])
                        if a not in dl or dl[a].startswith("Data_"):
                            dl[a] = f"Script_{a:04X}" if sb == b else f"Script_{sb:02X}_{a:04X}"
                            self.dreason[(sb, a)] = "event script entry or jump target"
                self.script_at[(sb, lo)] = {"ins": [(a, *code[(sb, a)]) for a in reg], "end": hi}
                used += 1
        dl = self.dlabels[b]
        for cb, x, a in sites:
            if a in dl and any(bb == b and r["ins"][0][0] <= a < r["end"] for (bb, _), r in self.script_at.items()):
                self.script_refs[(cb, x)] = dl[a]
                wrong = self.dref.pop((cb, x), None)  # the load names the script, not wDataBank data
                if wrong and wrong[0] != b and "$D7FE" in self.dreason.get(wrong, "") and \
                        wrong not in self.dref.values() and wrong[1] in self.dlabels[wrong[0]] and \
                        not self.dlabels[wrong[0]][wrong[1]].startswith(("Script", "Map")):
                    del self.dlabels[wrong[0]][wrong[1]]
        log(f"event scripts: {len(sites)} start sites, {len(code)} commands in {used} regions, "
            f"{len(self.data_script_entries)} data-bank entries" + f", {getattr(self, 'e4_fallbacks', 0)} $E4 counts not fixed by layout")

    MESSAGE_GROUP_BANKS = [0x28, 0x29, 0x2A, 0x2B, 0x2C, 0x2D, 0x2E, 0x2E, 0x7C, 0x80, 0x80, 0x82, 0x86, 0x89]

    def e4_count(self, base: int, pc: int) -> int:
        """Offsets after a $E4 at pc (E-0188). ScriptFetchE4 skips wTwoChoiceCursor offset bytes and
        jumps by the one it lands on (target = offset address + 1 + offset), so a menu of N options
        has N offsets and the count is not encoded. $E4 always jumps, so the first target follows
        the offsets directly: N is the smallest count (2 or more) whose nearest target is the byte
        after its last offset. Falls back to 2."""
        for k in range(2, 9):
            offs = self.data[base + pc + 1:base + pc + 1 + k]
            if min(pc + 2 + i + o for i, o in enumerate(offs)) == pc + 1 + k:
                return k
        self.e4_fallbacks = getattr(self, "e4_fallbacks", 0) + 1
        return 2

    def message_preview(self, word: int) -> str | None:
        """First words of message `word` on ShowMessageHL's normal path (E-0080/E-0081): group =
        high byte & $3F picks the bank (MESSAGE_GROUP_BANKS, from ShowMessageHL's 14 cases); the
        low byte indexes MessageStrings_BankBB ($4032; bank $86: $4016), or the bank's overflow
        table (minus the threshold at $4005) at and above that threshold. None when unknown."""
        g, i = (word >> 8) & 0x3F, word & 0xFF
        if g >= len(self.MESSAGE_GROUP_BANKS):
            return None
        bank = self.MESSAGE_GROUP_BANKS[g]
        if not hasattr(self, "_name_addr"):
            self._name_addr = {v["name"]: k for k, v in self.names.items()}
        table = 0x4016 if bank == 0x86 else 0x4032
        o = bank * BANK
        if bank != 0x86 and self.data[o + 4] == 0xFE and i >= self.data[o + 5]:
            ov = self._name_addr.get(f"MessageStrings_Bank{bank:02X}_Overflow")
            if not ov:
                return None
            i -= self.data[o + 5]
            bank, table = ov
        p = self._u16(bank, table + 2 * i)
        if not 0x4000 <= p < 0x8000:
            return None
        chars = []
        q = bank * BANK + p - BANK
        while len(chars) < 80 and self.data[q] != 0xF0:
            chars.append(gb_text.BYTE_TO_TEXT.get(self.data[q], " "))
            q += 1
        words = "".join(chars).split()
        return " ".join(words[:6]) if words else None

    def emit_script(self, bank: int, p: int, sc: dict, out: list[str]) -> None:
        dl = self.dlabels[bank]
        out.append("")
        out.append("; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)")
        for a, op, arg in sc["ins"]:
            if a in dl:
                out.append(f"{dl[a]}:: ; heuristic: {self.dreason.get((bank, a), 'inside an event script')}; C0")
                if (bank, a) in self.dalias:
                    out.append(f"{self.dalias[(bank, a)]}:: ; address name")
            w = arg[0] | arg[1] << 8 if len(arg) >= 2 else None
            lab = lambda t: dl.get(t, f"${t:04X}")
            if op == 0xFF:
                out.append("    script_end")
            elif op in (0x00, 0xEA, 0xF5):
                text = self.message_preview(w)
                macro = f"    script_message ${w:04X}" if op == 0x00 else f"    script_op ${op:02X}, ${arg[0]:02X}, ${arg[1]:02X}"
                out.append(macro + (f" ; '{text}'" if text else ""))
            elif op == 0x06:
                out.append(f"    script_skip_if_no {lab(a + 2 + arg[0])}")
            elif op == 0x07:
                out.append(f"    script_jump {lab(w)}")
            elif op == 0x0A:
                out.append(f"    script_set_flag ${w:04X}")
            elif op == 0x0E:
                out.append(f"    script_add_gold {w}")
            elif op == 0x0F:
                out.append(f"    script_sound ${arg[0]:02X}")
            elif op == 0xE4:
                out.append("    script_choice_jump " + ", ".join(lab(a + 2 + i + o) for i, o in enumerate(arg)))
            elif op == 0xE7:
                banks = getattr(self, "e7_banks", {}).get((bank, a), set())
                tb = next(iter(banks)) if len(banks) == 1 and None not in banks else None
                tl = self.dlabels.get(tb, {}).get(w) if tb is not None else None
                out.append(f"    script_jump_data_bank {tl or f'${w:04X}'}"
                           + ("" if tl else " ; data bank not known here"))
            elif arg:
                out.append(f"    script_op ${op:02X}, " + ", ".join(f"${v:02X}" for v in arg))
            else:
                out.append(f"    script_command ${op:02X}")

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

    def monster_name(self, mid: int) -> str:
        """Name of monster id `mid`: StringTable_MonsterNames (bank 8, $4258) for ids below 256,
        StringTable_MonsterNames2 ($4458) above, indexed by the low byte (E-0138)."""
        table = 0x4258 if mid < 0x100 else 0x4458
        p = self._u16(8, table + 2 * (mid & 0xFF))
        chars = []
        while (c := self.data[8 * BANK + p - BANK]) != 0xF0 and len(chars) < 16:
            chars.append(gb_text.BYTE_TO_TEXT.get(c, "?"))
            p += 1
        return "".join(chars)

    def word_note(self, kind: str, v: int) -> str:
        """What a 16-bit word in a table names (E-0199): a monster id, or a breeding-rule code
        as ComputeBreedingChild reads it (codes are in the high byte)."""
        hi, lo = v >> 8, v & 0xFF
        if kind == "breeding":
            codes = {0xFF: "end of list", 0xFD: "next result",
                     0xFE: f"same species, parent B +{lo} or more",
                     0xFC: f"same species, parent A +{lo} or more",
                     0xFB: "next result when wArg1 = 2, else end of list"}
            if hi in codes:
                return codes[hi]
        if kind == "message":  # E-0214: a message word, quoted like script messages
            text = self.message_preview(v) if v else None
            return f"'{text}'" if text else ("none" if v == 0 else "")
        if kind == "pedigree":  # E-0211: $FExx = family xx, $FEFE = none
            if v == 0xFEFE:
                return "none"
            if hi == 0xFE:
                return f"family {lo}"
        if kind == "breeding_result":
            if v == 0xFFFF:
                return "parent A's species"
            if hi == 0xFE:
                return "no child"
        return self.monster_name(v) if 0 < v < 0x180 else ""

    def emit_table(self, bank: int, t: dict, out: list[str]) -> None:
        """Emit a schema table: one record per entry, `db` runs and `dw` pointers."""
        dl = self.dlabels[bank]
        fields, sizes, stride = t["fields"], t["sizes"], t["stride"]
        out.append("")
        out.append(f"; {t['note']}")
        out.append("; record: " + (t.get("record") or "; ".join(f["name"] for f in fields)))
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
            if t.get("id_names") == "monster" and 0 < t["id_base"] + i < 0x200:
                tag += f" {self.monster_name(t['id_base'] + i)}"
            if t.get("id_names") == "charmap" and (t["id_base"] + i) in gb_text.BYTE_TO_TEXT:
                tag += f" '{gb_text.BYTE_TO_TEXT[t['id_base'] + i]}'"  # glyph number = text byte (E-0169)
            run: list[int] = []
            tagged = False

            def flush() -> None:
                nonlocal tagged
                if run:
                    out.append("    db " + ", ".join(f"${v:02X}" for v in run) + ("" if tagged else tag))
                    tagged = True
                    run.clear()

            q = p
            skip_bank = -1
            for fi, (f, sz) in enumerate(zip(fields, sizes)):
                if q in dl:
                    flush()
                    if dl[q] != t["label"]:  # a data name equal to the table label is printed once
                        out.append(f"{dl[q]}:: ; heuristic: {self.dreason.get((bank, q), 'label inside a table')}; C0")
                    if (bank, q) in self.dalias:
                        out.append(f"{self.dalias[(bank, q)]}:: ; address name")
                if f["type"] == "u24":  # 24-bit little-endian values in decimal, 11 per line (E-0148)
                    flush()
                    r = raws[fi]
                    vals24 = [r[j] | r[j + 1] << 8 | r[j + 2] << 16 for j in range(0, len(r), 3)]
                    for j in range(0, len(vals24), 11):
                        out.append("    d24 " + ", ".join(str(v) for v in vals24[j:j + 11]) + ("" if tagged else tag))
                        tagged = True
                elif f["type"] == "words":  # little-endian 16-bit values, e.g. BGR555 colours (E-0139)
                    flush()
                    r = raws[fi]
                    words = [r[j] | r[j + 1] << 8 for j in range(0, len(r), 2)]
                    per = f.get("per_line", len(words))  # long rows wrap after "per_line" words
                    for v in words if f.get("names") else []:  # one word per line with what it names (E-0199)
                        note = self.word_note(f["names"], v)
                        out.append(f"    dw ${v:04X}" + (tag if not tagged else " ;") + (f" {note}" if note else ""))
                        tagged = True
                    for j in range(0, len(words) if not f.get("names") else 0, per):
                        out.append("    dw " + ", ".join((f.get("ram") and self.sym_name(v, True))
                                                         or (str(v) if f.get("decimal") else f"${v:04X}")
                                                         for v in words[j:j + per]) + ("" if tagged else tag))
                        tagged = True
                    tagged = True
                elif f["type"] == "text":  # a string up to $F0 through charmap.inc, then raw padding (E-0191)
                    flush()
                    r = raws[fi]
                    k = r.index(0xF0) + 1 if 0xF0 in r else len(r)
                    parts = gb_text.render(bytes(r[:k])) + [f"${v:02X}" for v in r[k:]]
                    out.append("    db " + ", ".join(parts) + ("" if tagged else tag))
                    tagged = True
                elif skip_bank == fi:
                    pass  # emitted by the `dfar` of the pointer before it
                elif f["type"] == "ptr":
                    flush()
                    tb = vals[f["bank_from"]] if "bank_from" in f else int(f.get("target_bank", "%X" % bank), 16)
                    tgt = vals[fi]
                    nm = self.table_at[(tb, tgt)]["label"] if (tb, tgt) in self.table_at else None
                    nm = nm or self.dlabels.get(tb, {}).get(tgt)
                    if nm is None and tgt in self.insn.get(tb, {}):
                        nm = self.labels[tb].get(tgt)
                    nxt = fi + 1
                    if (nm and f.get("bank_from") == nxt and nxt < len(fields) and fields[nxt]["type"] == "db"
                            and sizes[nxt] == 1 and (q + sz) not in dl):
                        out.append(f"    dfar {nm}" + ("" if tagged else tag))  # address and bank in one line
                        skip_bank = nxt
                    else:
                        out.append(f"    dw {nm or f'${tgt:04X}'}" + ("" if tagged else tag))
                    tagged = True
                else:
                    if f.get("line"):
                        flush()  # a field marked "line" gets a db line of its own
                    run.extend(raws[fi])
                    if f.get("line"):
                        flush()
                q += sz
            flush()
        if t.get("tail"):
            o = bank * BANK + t["addr"] + t["count"] * stride - self.base(bank)
            out.append("    db " + ", ".join(f"${v:02X}" for v in self.data[o:o + t["tail"]]) + " ; end")

    def summary(self) -> str:
        code = sum(v[0] if v[0] != "dw" else 2 for ins in self.insn.values() for v in ins.values())
        banks = sum(1 for ins in self.insn.values() if ins)
        return f"{code} code bytes in {banks} banks, {len(self.reason)} heuristic entries"

    def seed_table_code(self) -> None:
        """Add the targets of pointer fields marked "code" in config/tables.json as code entries."""
        n = 0
        for t in self.schemas:
            fields = t["fields"]
            sizes = [2 if f["type"] == "ptr" else f.get("size", 1) for f in fields]
            stride = sum(sizes)
            for i in range(t["count"]):
                q = t["addr"] + i * stride
                for f, sz in zip(fields, sizes):
                    if f["type"] == "ptr" and f.get("code"):
                        tgt = self._u16(t["bank"], q)
                        if tgt:
                            self.add_entry(t["bank"], tgt, "Func", f"code pointer of the table {t['label']}")
                            n += 1
                    q += sz
        if n:
            log(f"code entries from structured tables: {n}")

    def run(self) -> None:
        for v in VECTORS:
            self.add_entry(0, v, "Func")
        for b, a, why in getattr(self, "code_entries", []):  # config/code_entries.json (E-0175)
            self.add_entry(b, a, "Func", why)
        self.seed_table_code()
        rnd = 0
        while True:
            rnd += 1
            passes = 0
            while True:
                passes += 1
                a = self.trace_pending()
                b = self.parse_tables()
                b = self.trim_tables() or b
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
            if self.discover_copies():
                continue
            log(f"round {rnd}: fall-through exhausted; pointer-table scan")
            if not self.discover_tables():
                log(f"round {rnd}: no new entries; analysis complete")
                break
        self.structure_data()
        self.find_compressed_assets()
        self.tile_keyworld_screen_gaps()
        self.label_data_refs()
        self.add_string_table_schemas()
        self.add_tile_copy_lists()
        self.add_rect_record_schemas()
        self.prepare_object_selectors()
        self.prepare_tables()
        self.prepare_tracks()
        self.prepare_scripts()
        self.drop_tile_pointer_runs()
        self.expand_families(self.families)
        self.name_dispatch_cases()
        self.apply_names()
        self.name_copies()
        self.build_xrefs()
        self.name_single_caller_helpers()
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
        for (b, a), sc in getattr(self, "script_at", {}).items():
            if b == bank:
                mask(a, sc["end"])
        for (b, a), sel in getattr(self, "objsel_at", {}).items():
            if b == bank:
                mask(a, sel["end"])
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
        if info and "of" in info:
            # an "of" entry places the address inside a buffer the size rule would not pick, e.g. the
            # WRAM-bank-2 attribute buffers that share addresses with bank-1 records (E-0136)
            base = info["of"]
            self.ram_used[base] = self.symbols[base]["name"]
            return f"{self.symbols[base]['name']} + ${addr - base:X}"
        if not info:
            # inside a named buffer (a symbol with a "size"): BufferName + $offset (E-0132)
            for base, binfo in self._sized:
                if base < addr < base + binfo["size"]:
                    self.ram_used[base] = binfo["name"]
                    return f"{binfo['name']} + ${addr - base:X}"
        name = info["name"] if info else f"{prefix}{addr:04X}"
        self.ram_used[addr] = name
        return name

    @property
    def _sized(self) -> list[tuple[int, dict]]:
        if not hasattr(self, "_sized_cache"):
            self._sized_cache = sorted(((a, i) for a, i in self.symbols.items() if i.get("size")),
                                       key=lambda t: t[1]["size"])  # smallest buffer first
        return self._sized_cache

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

    @property
    def _numeric_args(self) -> set[tuple[int, int]]:
        """`ld hl, n` (or `ld l, n`) / `ld bc, n` pairs that pass battle message bytes, not addresses (E-0137).

        The battle text routines store L, H, C and B into wDAC2, wDAC3, wDAC0 and wDAC1
        (`ld a, l` / `ld [$DAC2], a`, possibly after clearing the damage word). A pair of
        immediate loads that falls into or jumps to such a routine (directly or through one
        `jp`/`jr`) keeps both values numeric."""
        if hasattr(self, "_numeric_cache"):
            return self._numeric_cache
        prolog = ("xor a, a", "ld [$D872], a", "ld [$D873], a")
        found: set[tuple[int, int]] = set()
        for b in range(self.nbanks):
            ins = self.insn[b]
            entries = set()
            for pc, v in ins.items():
                q, steps = pc, 0
                while q in ins and ins[q][0] != "dw" and steps < 5:
                    t = ins[q][1]
                    nx = ins.get(q + ins[q][0])
                    if t == "ld a, l" and nx and nx[0] != "dw" and nx[1] == "ld [$DAC2], a":
                        entries.add(pc)
                        break
                    if t not in prolog:
                        break
                    q, steps = q + ins[q][0], steps + 1
            if not entries:
                continue
            entries |= {pc for pc, v in ins.items() if v[0] != "dw" and v[2] in ("jp", "jr") and v[3] in entries}
            loads = ("ld hl, $", "ld bc, $", "ld l, $")
            for pc, v in ins.items():
                if v[0] == "dw" or not v[1].startswith(loads):
                    continue
                q = pc + v[0]
                w = ins.get(q)
                if not w or w[0] == "dw" or not w[1].startswith(loads) or (w[1][3] == "b") == (v[1][3] == "b"):
                    continue
                q += w[0]
                x = ins.get(q)
                into = q in entries or (x and x[0] != "dw" and x[2] in ("jp", "jr", "call") and x[3] in entries)
                if into:
                    found |= {(b, pc), (b, pc + v[0])}
        # DE = a (y, x) screen position for the sprite step routines, e.g. $A070 (E-0137)
        for b in range(self.nbanks):
            ins = self.insn[b]
            for pc, v in ins.items():
                if v[0] == "dw" or not v[1].startswith("ld de, $"):
                    continue
                q = pc + v[0]
                for _ in range(2):
                    x = ins.get(q)
                    if not x or x[0] == "dw":
                        break
                    r = self.resolve(b, x[3]) if x[2] == "call" and x[3] is not None else None
                    if r and self.labels[r[0]].get(r[1], "").startswith("StepSpriteSlotToward"):
                        found.add((b, pc))
                        break
                    q += x[0]
        self._numeric_cache = found
        return found

    def symbolize(self, text: str, following: tuple[str, ...] = (), key: tuple[int, int] | None = None) -> str:
        """Replace absolute addresses in memory operands and pointer immediates by symbols.

        `following` holds the next instructions' text: a 16-bit immediate that is then added
        to HL (`add hl, bc`) is arithmetic (for example $FF9C is -100), not a pointer, so it
        stays numeric. `key` (bank, address) marks message-argument loads (_numeric_args)."""
        if key is not None and key in self._numeric_args:
            return text
        m = self._MEM.search(text)
        if m:
            nm = self.sym_name(int(m.group(1), 16), False)
            return text[:m.start()] + "[" + nm + "]" + text[m.end():] if nm else text
        m = self._IMM.match(text)
        if m:
            reg = m.group(1).split()[1].rstrip(",")
            if reg in ("bc", "de") and f"add hl, {reg}" in following and int(m.group(2), 16) >= 0xFF00:
                return text  # a small negative number, not an address
            low = {"hl": "l", "de": "e", "bc": "c"}.get(reg)
            if (int(m.group(2), 16) >= 0xFF00 and low and len(following) > 1
                    and following[0] == f"ld a, {low}" and re.search(r"\[\$FF9[BD]\]", following[1])):
                return text  # a step delta (-16, -128 ...) for the movement bytes hFF9B/hFF9D, not an address (E-0132)
            if int(m.group(2), 16) == 0xFFFF:
                return text  # -1 as a 16-bit number; rIE would only be a pointer in a memory operand
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
            if it is None and (bank, pc) in getattr(self, "objsel_at", {}):
                sel = self.objsel_at[(bank, pc)]
                self.emit_object_selector(bank, pc, sel, out)
                pc = sel["end"]
                continue
            if it is None and (bank, pc) in getattr(self, "script_at", {}):
                sc = self.script_at[(bank, pc)]
                self.emit_script(bank, pc, sc, out)
                pc = sc["end"]
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
                    readers = self.data_readers(bank, pc)
                    if readers:
                        more = f" and {len(readers) - 4} more" if len(readers) > 4 else ""
                        out.append(f"; address loaded by {', '.join(readers[:4])}{more}")
                    if stream:
                        zf = " into a zero-filled buffer" if (bank, pc) in self.zeroed_streams else ""
                        out.append(f"; LZSS-compressed asset: {stream[1]} bytes expand to {stream[0]}{zf} "
                                   f"(tools/lzss_gfx.py, E-0016/E-0017; C1)")
                    out.append(f"{dl[pc]}:: ; heuristic: {why}; C0")
                    if (bank, pc) in self.dalias:
                        out.append(f"{self.dalias[(bank, pc)]}:: ; address name")
                if pc in dt:  # the target's guessed label may have been dropped inside a layout
                    out.append(f"    dw {dl.get(dt[pc], f'${dt[pc]:04X}')}")
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
                elif r and r[0] == 0 and w and w in self.insn[0] and self.insn[0][w][0] != "dw":
                    nm = self.labels[0].get(w)
                out.append(f"    dw {nm or f'${w:04X}'}" + (" ; unused index (E-0207)" if w == 0 else ""))
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
            text = self.symbolize(text, tuple(look), (bank, pc))
            if (bank, pc) in getattr(self, "script_refs", {}):
                text = f"ld hl, {self.script_refs[(bank, pc)]}"  # the script FetchScriptCommand runs (bank $10)
            sp = self.split_ptr.get((bank, pc))
            if sp and sp[2] in self.dlabels.get(sp[1], {}):
                text = re.sub(r"\$[0-9A-F]{2}$", f"{sp[0]}({self.dlabels[sp[1]][sp[2]]})", text)
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
    arg_banks_path = ROOT / "config/arg_banks.json"
    if arg_banks_path.exists():
        rom.arg_banks = json.loads(arg_banks_path.read_text(encoding="utf-8"))["routines"]
    symbols_path = ROOT / "config/symbols.json"
    if symbols_path.exists():
        for key, info in json.loads(symbols_path.read_text(encoding="utf-8")).items():
            if not key.startswith("_"):
                if isinstance(info.get("size"), str):
                    info = dict(info, size=int(info["size"], 16))
                if "of" in info:
                    info = dict(info, of=int(info["of"], 16))
                rom.symbols[int(key, 16)] = info
        log(f"loaded {len(rom.symbols)} evidence-named RAM symbols")
    entries_path = ROOT / "config/code_entries.json"
    if entries_path.exists():
        rom.code_entries = [(int(e["bank"], 16), int(e["addr"], 16), f"configured code entry ({e['evidence']})")
                            for e in json.loads(entries_path.read_text(encoding="utf-8"))["entries"]]
        log(f"loaded {len(rom.code_entries)} configured code entries")
    regions_path = ROOT / "config/data_regions.json"
    if regions_path.exists():
        for r in json.loads(regions_path.read_text(encoding="utf-8"))["regions"]:
            rom.data_regions.setdefault(int(r["bank"], 16), []).append((int(r["start"], 16), int(r["end"], 16)))
        log(f"loaded {sum(len(v) for v in rom.data_regions.values())} proven data regions")
    tables_path = ROOT / "config/tables.json"
    if tables_path.exists():
        for t in json.loads(tables_path.read_text(encoding="utf-8"))["tables"]:
            rom.schemas.append(dict(t, bank=int(t["bank"], 16), addr=int(t["addr"], 16)))
        log(f"loaded {len(rom.schemas)} table layouts from {tables_path.name}")
    rom.add_map_schemas()
    rom.add_metasprite_schemas()
    rom.add_list_schemas()
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
