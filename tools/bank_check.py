#!/usr/bin/env python3
"""M2 bank check (E-0393): does code reach other banks only through bank-switching paths?

A routine in a switchable bank runs while its own bank is mapped at $4000-$7FFF. A plain `call`, `jp` or `jr` from
there to a label in another switchable bank, or a pointer load (`ld hl/de/bc, Label`) into another switchable bank
with no bank named beside it, works only while both happen to sit in the same bank. After a section moves to
another bank (src/layout.link), such a reference would run or read the wrong bank's bytes. This check reads the
banks from a build's .sym file (where each label actually landed) and the instructions from src/.

  errors    call / jp / jr (any condition) from a switchable bank to a label in a different switchable bank
  warnings  ld hl/de/bc, Label into a different switchable bank, with no BANK(...), farcall or `ld b, $NN` within
            three lines (a far helper may still take the bank from RAM; read the routine)

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
BANKED = re.compile(r"BANK\(|^\s+farcall|^\s+ld b, \$")


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


def check(src: Path, sym: dict[str, tuple[int, int]]) -> tuple[list[str], list[str]]:
    errors, warnings = [], []
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
            if here == 0 or sym[cur][1] < 0x4000:
                continue  # bank $00 code can reach any bank's labels only through its own switching
            mj, ml = JUMP.match(ln), LOAD.match(ln)
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
            elif not any(BANKED.search(x) for x in lines[max(0, i - 3):i + 4]):
                warnings.append(f"{where}: {ln.strip()} points into bank {tb:02X}")
    return errors, warnings


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--sym", type=Path)
    ap.add_argument("--src", type=Path, default=ROOT / "src")
    ap.add_argument("--json", type=Path)
    ap.add_argument("--examples", type=int, default=5)
    args = ap.parse_args(argv)
    errors, warnings = check(args.src, load_sym(args.sym or newest_sym()))
    for kind, items in (("errors", errors), ("warnings", warnings)):
        print(f"{kind}: {len(items)}")
        for x in items[:args.examples]:
            print("   ", x)
    if args.json:
        args.json.write_text(json.dumps({"errors": errors, "warnings": warnings}, indent=0), encoding="utf-8")
    return 1 if errors else 0


if __name__ == "__main__":
    sys.exit(main())
