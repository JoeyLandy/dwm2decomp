"""The source tree src/ as the checks see it after D-015 (H1b): files, the bank of every label, and a build of it.

Since H1a, src/ is hand-edited and build/listing/ (the generator's annotated listing) may be stale or absent, so
checks of the source read src/ itself. A label's bank comes from src/ alone: the SECTION it is defined in, and the
bank src/layout.link places that section in (E-0393), so a section moved in the layout is followed. Addresses need
a build: fresh_sym() returns the .sym of the newest build whose report records the current tree's digest, never a
build of another tree.

    python -I tools/source_tree.py           the current digest and the fresh build, if any
"""
from __future__ import annotations

import hashlib
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SECTION = re.compile(r'^SECTION "([^"]+)"')
GLOBAL = re.compile(r"^([A-Za-z_]\w*)::")


def bank_files(src: Path | None = None) -> list[Path]:
    """The bank files src/<dir>/bankNN_<topic>.asm, in bank order (D-010)."""
    src = src or ROOT / "src"
    return sorted(src.glob("*/bank[0-9a-f][0-9a-f]_*.asm"), key=lambda p: p.name)


def code_lines(path: Path) -> list[str]:
    return path.read_text(encoding="utf-8").split("\n")


def section_banks(src: Path | None = None) -> dict[str, int]:
    """Section name -> bank, from src/layout.link (ROM0 is bank 0, `ROMX $BB` bank BB)."""
    src = src or ROOT / "src"
    out, bank = {}, None
    for ln in (src / "layout.link").read_text(encoding="utf-8").split("\n"):
        if ln.startswith("ROM0"):
            bank = 0
        elif m := re.match(r"ROMX \$([0-9A-Fa-f]+)", ln):
            bank = int(m.group(1), 16)
        elif m := re.match(r'\s+"([^"]+)"', ln):
            out[m.group(1)] = bank
    return out


def label_banks(src: Path | None = None) -> dict[str, int]:
    """Global label -> the bank its section is placed in. A label outside any placed section is left out."""
    secs = section_banks(src)
    out = {}
    for f in bank_files(src):
        cur = None
        for ln in code_lines(f):
            if m := SECTION.match(ln):
                cur = m.group(1)
            elif (m := GLOBAL.match(ln)) and cur in secs:
                out[m.group(1)] = secs[cur]
    return out


def digest(src: Path | None = None) -> str:
    """SHA-256 over every file of src/ in path order, each as its relative path, a NUL, then its bytes."""
    src = src or ROOT / "src"
    h = hashlib.sha256()
    for p in sorted((p for p in src.rglob("*") if p.is_file()), key=lambda p: p.relative_to(src).as_posix()):
        h.update(p.relative_to(src).as_posix().encode() + b"\0" + p.read_bytes())
    return h.hexdigest()


def fresh_build(root: Path | None = None) -> Path | None:
    """The newest build/run*/ whose report.json records the current src/ digest and a pass, or None."""
    root = root or ROOT
    want = digest(root / "src")
    runs = sorted(root.glob("build/run*/report.json"), key=lambda p: p.stat().st_mtime, reverse=True)
    for rep in runs:
        try:
            r = json.loads(rep.read_text(encoding="utf-8"))
        except (OSError, ValueError):
            continue
        if r.get("source_digest") == want and r.get("pass") and (rep.parent / "dwm2.sym").exists():
            return rep.parent
    return None


def fresh_sym(root: Path | None = None) -> dict[str, tuple[int, int]] | None:
    """Label -> (bank, address) from the fresh build's .sym, or None when no build matches src/."""
    run = fresh_build(root)
    if run is None:
        return None
    out = {}
    for ln in (run / "dwm2.sym").read_text(encoding="utf-8").split("\n"):
        if m := re.match(r"([0-9a-fA-F]{2,3}):([0-9a-fA-F]{4}) (\S+)$", ln):
            out[m.group(3)] = (int(m.group(1), 16), int(m.group(2), 16))
    return out


if __name__ == "__main__":
    run = fresh_build()
    print(f"src/ digest {digest()}")
    print(f"fresh build: {run.relative_to(ROOT).as_posix() if run else 'none (run python -I tools/build.py --out build/runN)'}")
    sys.exit(0)
