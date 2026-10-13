#!/usr/bin/env python3
"""Rank routines (or RAM addresses) that still have only an address name by how often the generated source refers to them.

Routines: counts every operand reference (call, jp, jr, dw, ld) to a bare `Func_BBB_AAAA` label in build/listing/*.asm.
A label that also has an evidence name (`Name::` followed by `Func_BBB_AAAA:: ; address name`) is skipped.
RAM (--ram): counts operands that use an address name (`wXXXX`, `hFFXX`, `sXXXX`), i.e. a RAM address that
config/symbols.json does not name yet.
Output: count, label, bank file. Reading only; it says nothing about what a routine or variable does.
"""
from __future__ import annotations

import argparse
import re
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
LABEL = re.compile(r"^(Func_([0-9A-F]{3})_[0-9A-F]{4})::(.*)$")
REF = re.compile(r"\bFunc_[0-9A-F]{3}_[0-9A-F]{4}\b")
RAM = re.compile(r"\b(w[CD][0-9A-F]{3}|hFF[0-9A-F]{2}|s[AB][0-9A-F]{3})\b")


def rank_ram(top: int) -> None:
    refs: Counter[str] = Counter()
    where: dict[str, set[str]] = {}
    for path in sorted((ROOT / "build/listing").glob("*.asm")):
        for line in path.read_text(encoding="utf-8").splitlines():
            code = line.split(";", 1)[0]
            for name in RAM.findall(code):
                refs[name] += 1
                where.setdefault(name, set()).add(path.name)
    print(f"{len(refs)} RAM addresses with only an address name ({sum(refs.values())} uses)")
    for name, count in refs.most_common(top):
        print(f"{count:5d}  {name}  {len(where[name])} bank file(s)")


def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--banks", help="comma-separated hex banks to keep, e.g. 00,36")
    ap.add_argument("--top", type=int, default=40)
    ap.add_argument("--ram", action="store_true", help="rank address-named RAM operands instead of routines")
    args = ap.parse_args()
    if args.ram:
        rank_ram(args.top)
        return
    keep = {int(b, 16) for b in args.banks.split(",")} if args.banks else None

    bare: dict[str, str] = {}
    refs: Counter[str] = Counter()
    for path in sorted((ROOT / "build/listing").glob("*.asm")):
        for line in path.read_text(encoding="utf-8").splitlines():
            m = LABEL.match(line)
            if m:
                if "address name" not in m.group(3):
                    bare[m.group(1)] = path.name
                continue
            code = line.split(";", 1)[0]
            refs.update(REF.findall(code))
    ranked = sorted(((refs[n], n) for n in bare if keep is None or int(n[5:8], 16) in keep), reverse=True)
    print(f"{len(bare)} routines with only an address name")
    for count, name in ranked[: args.top]:
        print(f"{count:5d}  {name}  {bare[name]}")


if __name__ == "__main__":
    main()
