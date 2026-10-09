#!/usr/bin/env python3
"""One-time bootstrap: emit src/ with one section per 16 KiB bank.

Banks that are entirely $00 become `DS $4000, $00` (assembled, not copied).
Every other bank is an opaque `INCBIN` slice of the local reference at a fixed
offset -- scaffolding, NOT disassembly progress. Run only on an empty src/.
"""
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
REF = ROOT / "local/roms/dwm2-cobi-us.gbc"
BANK = 0x4000


def main() -> int:
    data = REF.read_bytes()
    out = ROOT / "src"
    if out.exists() and any(out.iterdir()):
        print("src/ is not empty; refusing to overwrite", file=sys.stderr)
        return 1
    (out / "banks").mkdir(parents=True, exist_ok=True)
    incs = []
    for b in range(len(data) // BANK):
        chunk = data[b * BANK:(b + 1) * BANK]
        if b == 0:
            hdr = 'SECTION "Bank 00", ROM0[$0000]\n'
        else:
            hdr = f'SECTION "Bank {b:02X}", ROMX[$4000], BANK[${b:02X}]\n'
        if not any(chunk):
            body = f"; bank ${b:02X}: all $00 in the reference\nDS $4000, $00\n"
        else:
            body = (f"; bank ${b:02X}: opaque slice, file [${b*BANK:06X}, ${(b+1)*BANK:06X}); C0\n"
                    f'INCBIN "dwm2-cobi-us.gbc", ${b*BANK:06X}, $4000\n')
        (out / "banks" / f"bank{b:02x}.asm").write_text(hdr + body, encoding="utf-8", newline="\n")
        incs.append(f'INCLUDE "banks/bank{b:02x}.asm"')
    (out / "main.asm").write_text("\n".join(incs) + "\n", encoding="utf-8", newline="\n")
    return 0


if __name__ == "__main__":
    sys.exit(main())
