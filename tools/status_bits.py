"""Which routines set, clear and test each bit of the battle status bytes (E-0339).

A battle slot's status bytes are wBattleStatus, wBattleStatus1 ... wBattleStatus8: nine arrays with a stride of 9
bytes (AddAx9ToHL). This scans the annotated listing for `ld hl, wBattleStatusK` (or `ld de` / TargetStatusNAddress
helpers) followed within a few instructions by `call AddAx9ToHL` and a `set`/`res`/`bit N, [hl]` or an `or`/`and`
mask on [hl], and lists the routines per (byte, bit).

    python -I tools/status_bits.py [--setters]
"""
import re
import sys
from collections import defaultdict
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import source_tree  # noqa: E402

ROOT = Path(__file__).resolve().parents[1]
LAB = re.compile(r"^([A-Za-z_]\w*)::")
LOAD = re.compile(r"\s+ld hl, wBattleStatus(\d?)$")
BITS = {n: v for n, v in re.findall(r"^DEF (BSTAT\d_\w+) EQU (\d)",
                                    (ROOT / "src/constants.inc").read_text(encoding="utf-8"), re.M)}


def norm(code: str) -> str:
    """An instruction of src/ in the listing's spelling, with a BSTATk_ bit name as its number (D-009)."""
    code = source_tree.listing_spelling(code)
    return re.sub(r"BSTAT\d_\w+", lambda m: BITS.get(m.group(0), m.group(0)), code)


def scan() -> dict:
    """{(byte, bit): {"set": set(routines), "res": ..., "bit": ...}}"""
    out: dict = defaultdict(lambda: {"set": set(), "res": set(), "bit": set()})
    for p in source_tree.bank_files():  # src/ (D-015, H1b)
        lines = p.read_text(encoding="utf-8").split("\n")
        routine = "?"
        for i, ln in enumerate(lines):
            m = LAB.match(ln)
            if m and "address name" not in ln:
                routine = m.group(1)
            m = LOAD.match(ln.split(";")[0].rstrip())
            if not m:
                continue
            k = int(m.group(1) or 0)
            ops = [norm(x.split(";")[0]) for x in lines[i + 1:i + 9] if x.startswith("    ") and
                   not x.strip().startswith(";")]
            if not ops or ops[0] != "call AddAx9ToHL":
                continue
            a_from_hl = False
            for op in ops[1:6]:
                mm = re.match(r"(set|res|bit) (\d), \[hl\]$", op)
                if mm:
                    out[(k, int(mm.group(2)))][mm.group(1)].add(routine)
                    continue
                if op == "ld a, [hl]":
                    a_from_hl = True
                    continue
                mm = re.match(r"(or|and) a, \$([0-9A-F]{2})$", op)
                if mm and a_from_hl:
                    v = int(mm.group(2), 16)
                    kind = "set" if mm.group(1) == "or" else "res"
                    bits = [b for b in range(8) if (v >> b) & 1] if kind == "set" else \
                        [b for b in range(8) if not (v >> b) & 1]
                    for b in bits:
                        out[(k, b)][kind].add(routine)
                    continue
                if re.match(r"(bit|set|res|and|or|ld|jr|jp|ret|call|cp|inc|push|pop)", op):
                    if op.startswith(("jr", "jp", "ret", "call")):
                        break
                    continue
                break
    return out


if __name__ == "__main__":
    data = scan()
    for (k, b), d in sorted(data.items()):
        setters = sorted(r for r in d["set"] if r.startswith("ActionEffect_"))
        print(f"status{k} bit {b}: set by {setters[:4]} ({len(d['set'])} setters), "
              f"{len(d['res'])} clear, {len(d['bit'])} test")
