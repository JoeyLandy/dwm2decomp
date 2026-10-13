"""List every instruction of the listing (build/listing) that names a RAM symbol, with its routine, to read a
symbol's meaning from its uses. `+N` extra lines of context after each use.

    python -I tools/ram_uses.py wSlotFlags854 [wOther ...] [+3]
"""
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
LAB = re.compile(r"^([A-Za-z_]\w*)::")


def uses(names: list[str], ctx: int = 0) -> list[str]:
    pat = re.compile(r"\b(" + "|".join(map(re.escape, names)) + r")\b")
    out = []
    for p in sorted((ROOT / "build/listing").glob("bank*.asm")):
        lines = p.read_text(encoding="utf-8").split("\n")
        routine = "?"
        for i, ln in enumerate(lines):
            m = LAB.match(ln)
            if m and "address name" not in ln:
                routine = m.group(1)
            if ln.startswith("    ") and not ln.lstrip().startswith(";") and pat.search(ln.split(";")[0]):
                out.append(f"{p.stem[4:]} {routine}: {ln.strip()}")
                for k in range(1, ctx + 1):
                    if i + k < len(lines) and lines[i + k].startswith("    "):
                        out.append(f"        {lines[i + k].strip()}")
    return out


if __name__ == "__main__":
    ctx = next((int(a[1:]) for a in sys.argv[1:] if a.startswith("+")), 0)
    print("\n".join(uses([a for a in sys.argv[1:] if not a.startswith("+")], ctx)))
