#!/usr/bin/env python3
"""Compare a regenerated tree with src/ (D-015, H1a).

Since H1a, tools/disasm_all.py writes its presented tree to build/regen/src/ and src/ is the hand-edited source.
This lists every file that differs between the two, is only in the regenerated tree (missing from src/), or is
only in src/ (extra), with the number of changed lines. It changes nothing.

    python -I tools/src_drift.py [REGEN [SRC]] [--diff PATH]

REGEN defaults to build/regen/src and SRC to src. --diff prints the unified diff of one file (a path relative to
the trees). The exit status is 0 when the trees are identical, 1 when they drift, 2 when REGEN is missing.
"""
from __future__ import annotations

import difflib
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def files(root: Path) -> set[str]:
    return {p.relative_to(root).as_posix() for p in root.rglob("*") if p.is_file()}


def drift(regen: Path, src: Path) -> dict[str, list]:
    """{"differ": [(path, changed lines)], "missing": [paths only in regen], "extra": [paths only in src]}."""
    a, b = files(regen), files(src)
    differ = []
    for path in sorted(a & b):
        x, y = (regen / path).read_bytes(), (src / path).read_bytes()
        if x != y:
            lx = x.decode("utf-8", "replace").split("\n")
            ly = y.decode("utf-8", "replace").split("\n")
            n = sum(1 for d in difflib.ndiff(lx, ly) if d[:1] in "+-")
            differ.append((path, n))
    return {"differ": differ, "missing": sorted(a - b), "extra": sorted(b - a)}


def main(argv: list[str]) -> int:
    args = [a for a in argv if not a.startswith("--")]
    diff_path = None
    if "--diff" in argv:
        diff_path = argv[argv.index("--diff") + 1]
        args.remove(diff_path)
    regen = Path(args[0]) if args else ROOT / "build/regen/src"
    src = Path(args[1]) if len(args) > 1 else ROOT / "src"
    if not regen.is_dir():
        print(f"{regen}: not found; run python -I tools/disasm_all.py first", file=sys.stderr)
        return 2
    if diff_path:
        x = (regen / diff_path).read_text(encoding="utf-8").split("\n") if (regen / diff_path).exists() else []
        y = (src / diff_path).read_text(encoding="utf-8").split("\n") if (src / diff_path).exists() else []
        sys.stdout.writelines(l + "\n" for l in difflib.unified_diff(x, y, f"regen/{diff_path}", f"src/{diff_path}",
                                                                      lineterm=""))
    d = drift(regen, src)
    for path, n in d["differ"]:
        print(f"differs  {path} ({n} lines)")
    for path in d["missing"]:
        print(f"missing  {path} (only in the regenerated tree)")
    for path in d["extra"]:
        print(f"extra    {path} (only in src/)")
    total = len(d["differ"]) + len(d["missing"]) + len(d["extra"])
    print(f"{len(files(src))} files in src/; {total} drift" if total else f"no drift: {len(files(src))} files identical")
    return 1 if total else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
