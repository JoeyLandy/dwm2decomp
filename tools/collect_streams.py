#!/usr/bin/env python3
"""Record the compressed streams the game actually decompresses while scripted scenes run.

Hooks DecompressReadHeader ($0DA8: B = bank, DE = stream) on tools/sm83.py through the title screen,
name entry, the opening field, every game mode forced in turn and the debug menu's items, and merges
the addresses into config/observed_streams.json. tools/disasm_all.py verifies each one with the
decompressor before it annotates it. An OBSERVATION of our own emulator (C1): only streams the
scenes reach are found."""
from __future__ import annotations

import copy
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import explore  # noqa: E402

OUT = explore.ROOT / "config/observed_streams.json"
READ_HEADER = 0x0DA8


def main() -> int:
    seen: set[tuple[int, int]] = set()

    def hook(gb):
        seen.add((gb.b, (gb.d << 8) | gb.e))

    def watch(gb):
        gb.pc_hooks[READ_HEADER] = hook
        return gb

    base = watch(explore.boot())
    scenes = []
    for mode in range(9):
        g = copy.deepcopy(base)
        g.wb(explore.WGAMEMODE, mode)
        g.wb(explore.WMODECHANGE, 1)
        scenes.append(g)
    for g in scenes:
        g.run(6_000_000)
    for downs in range(7):  # debug menu items
        g = copy.deepcopy(base)
        g.wb(explore.WGAMEMODE, 0)
        g.wb(explore.WMODECHANGE, 1)
        g.run(6_000_000)
        for _ in range(downs):
            explore.press(g, "down", hold=200_000, after=600_000)
        explore.press(g, "a", hold=200_000, after=3_000_000)
    g = copy.deepcopy(base)  # new game: title, name entry, opening
    for name in ("start", "start", "a", "a", "start"):
        explore.press(g, name)
    for _ in range(14):
        explore.press(g, "a", hold=200_000, after=1_200_000)
    old = set()
    if OUT.exists():
        old = {tuple(int(x, 16) for x in k.split(":")) for k in json.loads(OUT.read_text())["streams"]}
    merged = sorted(old | {(b, a) for b, a in seen if 0x4000 <= a < 0x8000})
    OUT.write_text(json.dumps({
        "_comment": "Compressed streams observed at run time by tools/collect_streams.py (C1). "
                    "tools/disasm_all.py checks each with the decompressor before using it.",
        "streams": [f"{b:02X}:{a:04X}" for b, a in merged]}, indent=1) + "\n", encoding="utf-8")
    print(f"{len(seen)} streams seen, {len(merged)} recorded")
    return 0


if __name__ == "__main__":
    sys.exit(main())
