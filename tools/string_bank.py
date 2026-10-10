#!/usr/bin/env python3
"""Print strings of a per-bank string table: string_bank.py BANK TABLE_ADDR CATEGORY [FIRST [COUNT]]

BANK and TABLE_ADDR are hex (the `ld de, ...` of the bank's BeginStringDisplay stub); strings are
rendered with the game's character map (tools/gb_text.py) and `<XX>` for control bytes. Reads the
reference ROM from local/roms/; prints to the terminal only."""
from __future__ import annotations

import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import gb_text  # noqa: E402


def main(argv: list[str]) -> int:
    if len(argv) < 3:
        print(__doc__)
        return 2
    bank, table, cat = int(argv[0], 16), int(argv[1], 16), int(argv[2])
    first = int(argv[3]) if len(argv) > 3 else 0
    count = int(argv[4]) if len(argv) > 4 else 20
    rom = (ROOT / "local/roms/dwm2-cobi-us.gbc").read_bytes()
    base = bank * 0x4000 - 0x4000

    def word(a: int) -> int:
        return rom[base + a] | (rom[base + a + 1] << 8)

    inv = {v: k for k, v in gb_text.CHARMAP.items()}

    def text(p: int) -> str:
        out, q = "", base + p
        while rom[q] != 0xF0 and len(out) < 80:
            out += inv.get(rom[q], f"<{rom[q]:02X}>")
            q += 1
        return out

    ctab = word(table + 2 * cat)
    for i in range(first, first + count):
        print(i, text(word(ctab + 2 * i)))
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
