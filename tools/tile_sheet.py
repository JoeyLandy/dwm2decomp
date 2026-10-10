#!/usr/bin/env python3
"""Draw compressed streams as 2bpp tile sheets: tile_sheet.py OUT.png BANK:ADDR [BANK:ADDR ...]

Each stream is decompressed (tools/lzss_gfx.py) and drawn as 8x8 tiles, 16 tiles per row, in four
grays, one stream under the other. For looking at what an asset is, not for conversion."""
from __future__ import annotations

import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
from lzss_gfx import decompress  # noqa: E402
import render_frame  # noqa: E402

GRAY = [(255, 255, 255), (170, 170, 170), (85, 85, 85), (0, 0, 0)]


def sheet(streams: list[bytes], per_row: int = 16):
    rows_px = []
    width = per_row * 8
    for data in streams:
        tiles = len(data) // 16
        n_rows = max(1, -(-tiles // per_row))
        block = [[GRAY[0]] * width for _ in range(n_rows * 8 + 2)]
        for t in range(tiles):
            tx, ty = (t % per_row) * 8, (t // per_row) * 8
            for y in range(8):
                lo, hi = data[t * 16 + y * 2], data[t * 16 + y * 2 + 1]
                for x in range(8):
                    block[ty + y][tx + x] = GRAY[((hi >> (7 - x)) & 1) << 1 | ((lo >> (7 - x)) & 1)]
        block[-1] = [(255, 0, 0)] * width
        rows_px.extend(block)
    rgb = bytearray()
    for row in rows_px:
        for c in row:
            rgb.extend(c)
    return width, len(rows_px), bytes(rgb)


def main(argv: list[str]) -> int:
    if len(argv) < 2:
        print(__doc__)
        return 2
    rom = (ROOT / "local/roms/dwm2-cobi-us.gbc").read_bytes()
    streams = []
    for spec in argv[1:]:
        bank, addr = (int(x, 16) for x in spec.split(":"))
        streams.append(decompress(rom, bank, addr)[0])
    w, h, rgb = sheet(streams)
    render_frame.write_png(argv[0], w, h, rgb, 3)
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
