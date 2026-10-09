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

Usage: disasm_all.py [--stats] [--quiet]
Progress goes to stderr. All banks are rendered in memory first; src/banks/*.asm
and src/main.asm are written only after the whole analysis succeeds, so an
interrupted run leaves the previous generated tree untouched.
"""
from __future__ import annotations

import re
import sys
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from trace_disasm import decode  # noqa: E402

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
        (>= 4 distinct), lie in $4000-$7FFF, and point past the end of the table into
        untraced bytes. Random data does not do this; compressed-asset indexes, far-pointer
        records and word tables do. Only labels and `dw` lines change, never bytes."""
        tables = entries = dropped = 0
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
                if (len(best) >= 8 and best[0][1] >= best[-1][0] + 2
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
        log(f"data structure: {tables} monotone pointer tables, {entries} pointers, "
            f"{dropped} dropped (targets inside another table)")

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
                elif bank != 0:
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
                if a in paired:
                    strong += 1
                else:
                    weak += 1
        log(f"banked-call operands resolved to code labels: {coded}")
        log(f"data references: {strong} via bank-switching helpers, {weak} same-bank loads, "
            f"{sum(len(d) for d in self.dlabels.values())} data labels in total")

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
        self.label_data_refs()

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
                out.append(f"\n{labels[pc]}::" + (f" ; {why}; C0" if why else ""))
            it = ins.get(pc)
            if it is None:
                if pc in dl:
                    why = self.dreason.get((bank, pc), "target of a monotone pointer table")
                    out.append(f"\n{dl[pc]}:: ; heuristic: {why}; C0")
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
            if text == "stop":
                out.append(f"    db $10, ${self.data[bank*BANK+pc-base+1]:02X} ; stop")
            else:
                out.append(f"    {text}")
            pc += n
        return hdr + "\n".join(out) + "\n"


def main() -> int:
    global _QUIET
    _QUIET = "--quiet" in sys.argv
    log(f"reading {REF}")
    rom = Rom(REF.read_bytes())
    log(f"{rom.nbanks} banks, {len(rom.zero)} all-zero")
    rom.run()
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
    (ROOT / "src/main.asm").write_text(
        "".join(f'INCLUDE "banks/bank{b:02x}.asm"\n' for b in range(rom.nbanks)),
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
