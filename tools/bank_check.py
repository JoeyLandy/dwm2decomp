#!/usr/bin/env python3
"""M2 bank check (E-0393): does code reach other banks only through bank-switching paths?

A routine in a switchable bank runs while its own bank is mapped at $4000-$7FFF. A plain `call`, `jp` or `jr` from
there to a label in another switchable bank, or a pointer load (`ld hl/de/bc, Label`) into another switchable bank
with no bank named beside it, works only while both happen to sit in the same bank. After a section moves to
another bank (src/layout.link), such a reference would run or read the wrong bank's bytes. This check reads the
banks from a build's .sym file (where each label actually landed) and the instructions from src/.

  errors    call / jp / jr (any condition) from a switchable bank to a label in a different switchable bank
  warnings  ld hl/de/bc, Label into a different switchable bank (from any bank, the home bank too), with no
            BANK(Label) within three lines (eight above in the home bank) or in the code that runs on to the read
            (E-0419: a literal `ld b, $NN` or a nearby farcall no longer counts)
  asserted  such a load followed by `ASSERT BANK(Label) == $BB` (tools/present.py, E-0401): the reader maps that
            bank itself, and the link fails if the label leaves it
  literal   a bank given by number where a reader takes it from: `ld a, $NN / ld [wDataBank], a`, or `ld b, $NN`
            before a call to CopyFromBank* or OrFromBank* (E-0420). src/ names these BANK(Label) where a label
            fixes the bank; what is left has no data it reads in that bank (reported, not a warning)

Usage: bank_check.py [--sym build/runN/dwm2.sym] [--src src] [--json out.json]
Exit 1 when there are errors.
"""
from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
GLOBAL = re.compile(r"^([A-Za-z_]\w*)::")
LOCAL = re.compile(r"^(\.[A-Za-z_]\w*):")
JUMP = re.compile(r"^\s+(?:call|jp|jr)(?: (?:z|nz|c|nc),)? ([A-Za-z_.][\w.]*)\s*(?:;.*)?$")
LOAD = re.compile(r"^\s+ld (?:hl|de|bc), ([A-Za-z_][\w.]*)\s*(?:;.*)?$")
LITERAL_A = re.compile(r"^\s+ld a, \$([0-9a-fA-F]{2})\s*(?:;.*)?$")
LITERAL_B = re.compile(r"^\s+ld b, \$([0-9a-fA-F]{2})\s*(?:;.*)?$")
BANK_COPY = re.compile(r"^\s+call (?:CopyFromBank|OrFromBank)\w*")


def literal_bank(lines: list[str], i: int) -> int | None:
    """E-0420: the bank number line i gives a bank-taking reader by number: `ld a, $NN` stored in wDataBank (for
    ReadWordFromDataBank and the data-bank script mode), or `ld b, $NN` for CopyFromBank*/OrFromBank* within the
    next two lines. None otherwise, and for bank 0."""
    m = LITERAL_A.match(lines[i])
    if m and i + 1 < len(lines) and lines[i + 1].split(";")[0].strip() == "ld [wDataBank], a":
        return int(m.group(1), 16) or None
    m = LITERAL_B.match(lines[i])
    if m and any(BANK_COPY.match(x) for x in lines[i + 1:i + 3]):
        return int(m.group(1), 16) or None
    return None


def load_sym(path: Path) -> dict[str, tuple[int, int]]:
    out = {}
    for ln in path.read_text(encoding="utf-8").split("\n"):
        m = re.match(r"([0-9a-fA-F]{2,3}):([0-9a-fA-F]{4}) (\S+)$", ln)
        if m:
            out[m.group(3)] = (int(m.group(1), 16), int(m.group(2), 16))
    return out


def newest_sym() -> Path:
    syms = sorted(ROOT.glob("build/run*/dwm2.sym"), key=lambda p: p.stat().st_mtime)
    if not syms:
        sys.exit("no build/run*/dwm2.sym; run tools/build.py first")
    return syms[-1]


def names_bank_later(lines: list[str], i: int, label: str) -> bool:
    """H4: BANK(label) of this same label in the code that runs straight on from the load, as when a far-read helper
    is called with the table's own bank in B, or the home bank maps it (`ld a, BANK(label) / ld [rROMB0], a`). E-0419: that code is tools/present.py's: up to the first call, jump
    or return, past a conditional `jr` and a local label jumped to only from it."""
    sys.path.insert(0, str(ROOT / "tools"))
    from present import _run_after
    return any(f"BANK({label})" in x.split(";")[0] for x in _run_after(lines, i))  # ld b, or ld a for rROMB0


def check(src: Path, sym: dict[str, tuple[int, int]], asserted: list[str] | None = None,
          literal: list[str] | None = None) -> tuple[list[str], list[str]]:
    errors, warnings = [], []
    asserted = [] if asserted is None else asserted
    literal = [] if literal is None else literal
    for p in sorted(src.glob("*/bank*.asm")):
        lines = p.read_text(encoding="utf-8").split("\n")
        cur = None
        for i, ln in enumerate(lines):
            m = GLOBAL.match(ln)
            if m:
                cur = m.group(1)
                continue
            if cur is None or cur not in sym:
                continue
            here = sym[cur][0]
            if (nb := literal_bank(lines, i)) is not None:
                literal.append(f"{p.relative_to(src).as_posix()}:{i + 1} {cur} (bank {here:02X}): {ln.strip()} "
                               f"names bank {nb:02X} by number")
            home = here == 0 or sym[cur][1] < 0x4000
            mj, ml = JUMP.match(ln), LOAD.match(ln)
            if home:  # bank $00 code jumps into a bank it has mapped; its pointer loads are checked (E-0419)
                mj = None
            m = mj or ml
            if not m:
                continue
            name = m.group(1)
            full = cur + name if name.startswith(".") else name
            if full not in sym:
                continue
            tb, ta = sym[full]
            if tb == 0 or ta < 0x4000 or tb == here or ta >= 0x8000:
                continue
            where = f"{p.relative_to(src).as_posix()}:{i + 1} {cur} (bank {here:02X})"
            if mj:
                errors.append(f"{where}: {ln.strip()} reaches bank {tb:02X}")
            elif i + 1 < len(lines) and lines[i + 1].strip().startswith(f"ASSERT BANK({full}) =="):
                asserted.append(f"{where}: {ln.strip()} asserted in bank {tb:02X}")
            elif not any(f"BANK({full})" in x for x in lines[max(0, i - (8 if home else 3)):i + 4]) \
                    and not names_bank_later(lines, i, full):
                warnings.append(f"{where}: {ln.strip()} points into bank {tb:02X}")
    return errors, warnings


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--sym", type=Path)
    ap.add_argument("--src", type=Path, default=ROOT / "src")
    ap.add_argument("--json", type=Path)
    ap.add_argument("--examples", type=int, default=5)
    args = ap.parse_args(argv)
    asserted: list[str] = []
    literal: list[str] = []
    errors, warnings = check(args.src, load_sym(args.sym or newest_sym()), asserted, literal)
    print(f"asserted: {len(asserted)}")
    print(f"literal: {len(literal)}")
    for x in literal[:args.examples]:
        print("   ", x)
    for kind, items in (("errors", errors), ("warnings", warnings)):
        print(f"{kind}: {len(items)}")
        for x in items[:args.examples]:
            print("   ", x)
    if args.json:
        args.json.write_text(json.dumps({"errors": errors, "warnings": warnings, "asserted": asserted, "literal": literal}, indent=0),
                             encoding="utf-8")
    return 1 if errors else 0


if __name__ == "__main__":
    sys.exit(main())
