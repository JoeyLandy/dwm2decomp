#!/usr/bin/env python3
"""List the ROM data a scene reads (bank, address ranges), to find tables by use.

  rom_reads.py MODE [BUTTON...]   boot, force wGameMode = MODE, press the buttons, then record the
                                  switchable-window ROM bytes read as data (not instruction
                                  fetches) over the next 3 million instructions.

Reads are grouped into runs of nearby addresses. Evidence from our own emulator (C1 at most).
"""
from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import explore  # noqa: E402


def collect(gb, instructions: int) -> dict[int, set[int]]:
    reads: dict[int, set[int]] = {}

    def hook(pc, bank, addr):
        if addr != gb.pc:  # opcode and operand fetches read at the program counter
            reads.setdefault(bank, set()).add(addr)

    gb.on_rom_read = hook
    gb.run(instructions)
    gb.on_rom_read = None
    return reads


def runs(addrs: set[int], gap: int = 24):
    out, cur = [], None
    for a in sorted(addrs):
        if cur and a - cur[1] <= gap:
            cur[1] = a
            cur[2] += 1
        else:
            cur = [a, a, 1]
            out.append(cur)
    return out


def main(argv: list[str]) -> int:
    if not argv:
        print(__doc__)
        return 2
    gb = explore.boot()
    gb.wb(explore.WGAMEMODE, int(argv[0]))
    gb.wb(explore.WMODECHANGE, 1)
    gb.run(6_000_000)
    for name in argv[1:]:
        explore.press(gb, name)
    for bank, addrs in sorted(collect(gb, 3_000_000).items()):
        for lo, hi, n in runs(addrs):
            print(f"{bank:02X}:{lo:04X}-{hi:04X}  {n} bytes read")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
