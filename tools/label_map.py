"""Labels by address, before and after a rename batch (E-0368).

Renaming a routine in config/names.json lets tools/disasm_all.py re-derive the names of its steps, copies and
tables, so a batch changes more labels than it names. This tool records every global label of the listing
(build/listing/bankNN.asm, where each label is followed by its `Func_BBB_AAAA:: ; address name` alias) by its
address, compares two such snapshots, and rewrites the old names that config/ and tests/ cite.

    python -I tools/label_map.py snapshot OUT.json
    python -I tools/label_map.py diff OLD.json NEW.json [--out MAP.json]   old name -> new name, by address
    python -I tools/label_map.py apply MAP.json                             rewrite citations in config/ and tests/

A citation that follows "was", "from" or "formerly" names a former label on purpose and is kept.
"""
import argparse
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
LABEL = re.compile(r"^([A-Za-z_]\w*)::(?: ; (.*))?$")
ADDR = re.compile(r"^(?:Func|Jump|Data)_([0-9A-F]{3})_([0-9A-F]{4})$")
HISTORY = re.compile(r"(?:\bwas|\bfrom|\bformerly|\brenamed from)[:\s]+$")


def snapshot(listing: Path) -> dict[str, str]:
    """'BB:AAAA' -> label, for every label the listing pairs with an address name."""
    out: dict[str, str] = {}
    for p in sorted(listing.glob("bank[0-9a-f][0-9a-f].asm")):
        prev = None
        for ln in p.read_text(encoding="utf-8").split("\n"):
            m = LABEL.match(ln)
            if not m:
                continue
            a = ADDR.match(m.group(1))
            if a and m.group(2) == "address name" and prev:
                out[f"{int(a.group(1), 16):02X}:{a.group(2)}"] = prev
                prev = None
            else:
                prev = m.group(1)
    return out


def diff(old: dict[str, str], new: dict[str, str]) -> dict[str, str]:
    mp = {}
    for k, o in old.items():
        n = new.get(k)
        if n and n != o:
            mp[o] = n
    return mp


def rewrite(text: str, mp: dict[str, str]) -> tuple[str, int]:
    if not mp:
        return text, 0
    pat = re.compile(r"(?<![\w.])(" + "|".join(re.escape(k) for k in sorted(mp, key=len, reverse=True)) + r")(?![\w])")
    count = 0

    def one(m: re.Match) -> str:
        nonlocal count
        if HISTORY.search(text[max(0, m.start() - 20):m.start()]):
            return m.group(0)
        count += 1
        return mp[m.group(1)]
    return pat.sub(one, text), count


def apply(mp: dict[str, str], root: Path = ROOT) -> int:
    total = 0
    for p in sorted(list((root / "config").glob("*.json")) + list((root / "tests").glob("test_*.py"))):
        s = p.read_text(encoding="utf-8")
        t, n = rewrite(s, mp)
        if n:
            if p.suffix == ".json":
                json.loads(t)  # never write a file that no longer parses
            p.write_text(t, encoding="utf-8", newline="\n")
            total += n
    return total


def main() -> int:
    ap = argparse.ArgumentParser()
    sub = ap.add_subparsers(dest="cmd", required=True)
    s = sub.add_parser("snapshot")
    s.add_argument("out", type=Path)
    s.add_argument("--listing", type=Path, default=ROOT / "build/listing")
    d = sub.add_parser("diff")
    d.add_argument("old", type=Path)
    d.add_argument("new", type=Path)
    d.add_argument("--out", type=Path)
    a = sub.add_parser("apply")
    a.add_argument("map", type=Path)
    args = ap.parse_args()
    if args.cmd == "snapshot":
        snap = snapshot(args.listing)
        if not snap:
            print(f"no labels in {args.listing}")
            return 1
        args.out.write_text(json.dumps(snap, indent=0, sort_keys=True), encoding="utf-8")
        print(f"{len(snap)} labels")
    elif args.cmd == "diff":
        mp = diff(*(json.loads(p.read_text(encoding="utf-8")) for p in (args.old, args.new)))
        if args.out:
            args.out.write_text(json.dumps(mp, indent=0, sort_keys=True), encoding="utf-8")
        print(f"{len(mp)} labels renamed")
    else:
        print(f"citations rewritten: {apply(json.loads(args.map.read_text(encoding='utf-8')))}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
