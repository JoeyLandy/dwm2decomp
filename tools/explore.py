#!/usr/bin/env python3
"""Dynamic exploration of the reference ROM on tools/sm83.py (our own emulator, C1 at most).

  explore.py play  BUTTON...      boot, then press each button; screenshots in build/shots/
  explore.py modes                boot, force wGameMode = 0..8 and screenshot each (build/shots/)
  explore.py scene BUTTON...      boot, press the buttons, then list the functions that run in
                                  the next 1.5 million instructions (names from the bank files in src/)

Buttons: right left up down a b select start. Screenshots come from tools/render_frame.py, which
draws once per frame and ignores per-scanline effects. The reference ROM is read from
local/roms/ and is never copied anywhere.
"""
from __future__ import annotations

import bisect
import collections
import copy
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
from sm83 import GameBoy  # noqa: E402
import render_frame  # noqa: E402

BTN = {"right": 0, "left": 1, "up": 2, "down": 3, "a": 4, "b": 5, "select": 6, "start": 7}
SHOTS = ROOT / "build/shots"
BOOT_INSTRUCTIONS = 12_000_000  # about the title screen
WGAMEMODE, WMODECHANGE = 0xC5DB, 0xC5DF


def boot() -> GameBoy:
    gb = GameBoy((ROOT / "local/roms/dwm2-cobi-us.gbc").read_bytes())
    gb.run(BOOT_INSTRUCTIONS)
    return gb


def press(gb: GameBoy, name: str, hold: int = 300_000, after: int = 1_500_000) -> None:
    gb.joy = 0xFF & ~(1 << BTN[name])
    gb.run(hold)
    gb.joy = 0xFF
    gb.run(after)


def shot(gb: GameBoy, tag: str, scale: int = 2) -> None:
    SHOTS.mkdir(parents=True, exist_ok=True)
    w, h, rgb = render_frame.render(gb)
    render_frame.write_png(SHOTS / f"{tag}.png", w, h, rgb, scale)
    print(f"{tag}: pc={gb.pc:04X} wGameMode={gb.rb(WGAMEMODE)}")


def function_table() -> dict[int, tuple[list[int], dict[int, str]]]:
    """bank -> (sorted function addresses, address -> label) read from the generated source."""
    table = {}
    for path in (ROOT / "build/listing").glob("bank*.asm"):
        bank = int(path.stem[4:], 16)
        lines = path.read_text(encoding="utf-8").split("\n")
        ents: dict[int, str] = {}
        for i, line in enumerate(lines):
            m = re.match(r"(\w+)::", line)
            if not m:
                continue
            addr_name = re.match(r"Func_[0-9A-F]{3}_([0-9A-F]{4})$", m.group(1))
            if addr_name:
                ents.setdefault(int(addr_name.group(1), 16), m.group(1))
            elif i + 1 < len(lines):
                alias = re.match(r"Func_[0-9A-F]{3}_([0-9A-F]{4})::", lines[i + 1])
                if alias:
                    ents[int(alias.group(1), 16)] = m.group(1)
        table[bank] = (sorted(ents), ents)
    return table


class Traced(GameBoy):
    """GameBoy that counts executed (bank, pc) pairs while `tracing` is set."""

    def __init__(self, rom: bytes):
        super().__init__(rom)
        self.cover: collections.Counter = collections.Counter()
        self.tracing = False

    def step(self) -> int:
        if self.tracing:
            self.cover[(self.rombank if self.pc >= 0x4000 else 0, self.pc)] += 1
        return super().step()


def main(argv: list[str]) -> int:
    if not argv or argv[0] not in ("play", "modes", "scene"):
        print(__doc__)
        return 2
    cmd, buttons = argv[0], argv[1:]
    if cmd == "modes":
        base = boot()
        for mode in range(9):
            gb = copy.deepcopy(base)
            gb.wb(WGAMEMODE, mode)
            gb.wb(WMODECHANGE, 1)
            gb.run(6_000_000)
            shot(gb, f"mode{mode}", 1)
        return 0
    if cmd == "play":
        gb = boot()
        shot(gb, "play_0_boot")
        for i, name in enumerate(buttons, 1):
            press(gb, name)
            shot(gb, f"play_{i}_{name}")
        return 0
    gb = Traced((ROOT / "local/roms/dwm2-cobi-us.gbc").read_bytes())
    gb.run(BOOT_INSTRUCTIONS)
    for name in buttons:
        press(gb, name)
    gb.tracing = True
    gb.run(1_500_000)
    table = function_table()
    counts: collections.Counter = collections.Counter()
    for (bank, pc), n in gb.cover.items():
        addrs, ents = table.get(0 if pc < 0x4000 else bank, ([], {}))
        i = bisect.bisect_right(addrs, pc) - 1
        counts[ents[addrs[i]] if i >= 0 else f"{bank:02X}:{pc:04X}"] += n
    for name, n in counts.most_common():
        print(f"{n:9d} {name}")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
