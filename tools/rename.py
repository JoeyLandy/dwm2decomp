#!/usr/bin/env python3
"""Rename a label, constant or RAM symbol everywhere in src/ (D-015, H1d).

Since src/ is the hand-edited source, a name is changed where it is written: its definition, every reference, every
comment that mentions it, and (for a global label) the SECTION it starts and its line in src/layout.link, so the
layout keeps placing the section. Only whole words change: renaming Foo leaves FooBar, Foo_2 and .foo alone.
Nothing the assembler reads changes except the name, so the build must still match the reference.

    python -I tools/rename.py OLD NEW [--src DIR] [--dry-run]

It refuses when OLD is not defined, when NEW is already a name, or when NEW is not a valid RGBDS symbol.
"""
from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SYMBOL = re.compile(r"^[A-Za-z_][A-Za-z0-9_]*$")


def files(src: Path) -> list[Path]:
    return sorted(p for p in src.rglob("*") if p.is_file() and p.suffix in (".asm", ".inc", ".link"))


def defined(src: Path) -> set[str]:
    """Every global label, DEF constant, MACRO and charmap-free symbol defined in the tree."""
    out = set()
    for p in files(src):
        text = p.read_text(encoding="utf-8")
        out |= set(re.findall(r"^([A-Za-z_]\w*)::?", text, re.M))
        out |= set(re.findall(r"^\s*DEF ([A-Za-z_]\w*)\b", text, re.M))
        out |= set(re.findall(r"^MACRO ([A-Za-z_]\w*)", text, re.M))
    return out


def rename(src: Path, old: str, new: str, dry_run: bool = False) -> dict[str, int]:
    """Returns {relative path: number of replacements}. Raises ValueError when the rename is not safe."""
    if not SYMBOL.match(new):
        raise ValueError(f"{new} is not a valid symbol name")
    names = defined(src)
    if old not in names:
        raise ValueError(f"{old} is not defined in {src}")
    if new in names:
        raise ValueError(f"{new} is already defined")
    word = re.compile(r"(?<![\w.])" + re.escape(old) + r"(?!\w)")  # not FooBar, not .Foo (a local label)
    out = {}
    for p in files(src):
        text = p.read_text(encoding="utf-8")
        new_text, n = word.subn(new, text)
        if n:
            out[p.relative_to(src).as_posix()] = n
            if not dry_run:
                p.write_text(new_text, encoding="utf-8", newline="\n")
    return out


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("old")
    ap.add_argument("new")
    ap.add_argument("--src", type=Path, default=ROOT / "src")
    ap.add_argument("--dry-run", action="store_true")
    a = ap.parse_args(argv)
    try:
        changed = rename(a.src, a.old, a.new, a.dry_run)
    except ValueError as e:
        print(f"refused: {e}", file=sys.stderr)
        return 2
    for path, n in changed.items():
        print(f"{n:5d}  {path}")
    print(f"{sum(changed.values())} replacements in {len(changed)} files" + (" (dry run)" if a.dry_run else ""))
    return 0


if __name__ == "__main__":
    sys.exit(main())
