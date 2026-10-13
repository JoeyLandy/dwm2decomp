"""Readability measures of the presented source (src/): how much of it still reads as machine output.

Counts, over src/banks and src/ram.asm:
- global labels, and those whose name is structural or mechanical: a `_CaseNN`/`_SubNN`/`_TableN` part, an `Etc`
  suffix, a raw hex address or byte in the name (`..._Data_46EE`, `wResolveByte81`), or a `_BankNN` copy suffix;
- RAM symbols, and those that spell an address or byte number (`wSlotFlags854`, `wUnk...`, `...ByteNN`);
- instruction operands that are bare numbers where a name exists elsewhere: `ld hl, $XXXX` into ROM ($4000-$7FFF)
  or RAM ($8000+), `call/jp $XXXX`;
- `db`/`dw` lines and INCBIN slices of the reference.

    python -I tools/readability.py
"""
import re
import sys
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
STRUCT = re.compile(r"_(?:Case|Sub|Table|Shared)[0-9A-F]{0,2}(?=_|$)|Etc(?=_|$)|(?:^|_)(?:Data|Func|Jump)_|"
                    r"[A-Za-z][0-9A-F]{3,4}(?=_|$)|Byte[0-9A-F]{2}|_Bank[0-9A-F]{2}$")
RAM_MECH = re.compile(r"[A-Za-z][0-9A-F]{2,4}(?:$|[A-Z_])|Byte[0-9A-F]{2}|Unk|^[wsh][0-9A-F]{4}$")


def measure() -> dict:
    texts = [p.read_text(encoding="utf-8") for p in sorted((ROOT / "src/banks").glob("bank*.asm"))]
    labels = [m for t in texts for m in re.findall(r"^([A-Za-z_]\w*)::", t, re.M)]
    mech = [n for n in labels if STRUCT.search(n)]
    ram = re.findall(r"^DEF ([wsh]\w+) EQU", (ROOT / "src/ram.asm").read_text(encoding="utf-8"), re.M)
    ram_mech = [n for n in ram if RAM_MECH.search(n[1:])]
    code = [ln.split(";")[0] for t in texts for ln in t.split("\n") if ln.startswith("    ") and not
            ln.lstrip().startswith(";")]
    raw_ptr = sum(1 for c in code if re.match(r"\s+(?:ld (?:hl|de|bc), |call |jp )\$[4-9a-f][0-9a-f]{3}\b", c))
    data = sum(1 for c in code if re.match(r"\s+(?:db|dw) ", c))
    incbin = sum(1 for c in code if c.lstrip().startswith("INCBIN"))
    lines = sum(len(t.split("\n")) for t in texts)
    return {"lines": lines, "labels": len(labels), "mechanical_labels": len(mech), "ram": len(ram),
            "mechanical_ram": len(ram_mech), "raw_pointer_operands": raw_ptr, "data_lines": data,
            "incbin": incbin, "examples": (Counter(re.sub(r"[0-9A-F]{2,}", "#", STRUCT.search(n).group(0))
                                                    for n in mech).most_common(8), ram_mech[:12])}


if __name__ == "__main__":
    for k, v in measure().items():
        print(f"{k}: {v}")
    sys.exit(0)
