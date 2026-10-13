"""Draw the background, window and sprite layers of a tools/sm83.py GameBoy as a PNG (E-0319, E-0320).

A diagnostic picture of VRAM at one moment: the CGB tile map attributes (palette, tile bank, flips) and palette
RAM are used, and OAM sprites are drawn on top; mid-frame scroll changes and priority are not. Standard library only."""
import struct
import zlib
from pathlib import Path


def _rgb(pal: bytes, p: int, c: int) -> tuple[int, int, int]:
    w = pal[p * 8 + c * 2] | pal[p * 8 + c * 2 + 1] << 8
    return tuple((w >> s & 0x1F) * 255 // 31 for s in (0, 5, 10))


def render(gb) -> list[list[tuple[int, int, int]]]:
    lcdc, scy, scx, wy, wx = gb.io[0x40], gb.io[0x42], gb.io[0x43], gb.io[0x4A], gb.io[0x4B] - 7
    v0, v1 = gb.vram

    def pixel(map_base: int, x: int, y: int) -> tuple[int, int, int]:
        m = map_base + (y // 8) * 32 + x // 8
        tile, attr = v0[m], v1[m]
        if not lcdc & 0x10:
            tile = (tile ^ 0x80) + 0x80  # $8800 addressing: signed tile numbers around $9000
        bank = v1 if attr & 0x08 else v0
        ty, tx = (7 - y % 8) if attr & 0x40 else y % 8, (7 - x % 8) if attr & 0x20 else x % 8
        lo, hi = bank[tile * 16 + ty * 2], bank[tile * 16 + ty * 2 + 1]
        c = (lo >> (7 - tx) & 1) | (hi >> (7 - tx) & 1) << 1
        return _rgb(gb.bgpal, attr & 7, c)

    bg = 0x1C00 if lcdc & 0x08 else 0x1800
    win = 0x1C00 if lcdc & 0x40 else 0x1800
    out = []
    for y in range(144):
        row = []
        for x in range(160):
            if lcdc & 0x20 and y >= wy and x >= wx:
                row.append(pixel(win, x - wx, y - wy))
            else:
                row.append(pixel(bg, (x + scx) & 0xFF, (y + scy) & 0xFF))
        out.append(row)
    if lcdc & 0x02:  # sprites from OAM, drawn over everything (priority ignored); colour 0 is transparent
        h = 16 if lcdc & 0x04 else 8
        for i in range(39, -1, -1):
            sy, sx, tile, attr = (gb.oam[i * 4 + k] for k in range(4))
            sy, sx = sy - 16, sx - 8
            if h == 16:
                tile &= 0xFE
            bank = v1 if attr & 0x08 else v0
            for dy in range(h):
                y = sy + dy
                if not 0 <= y < 144:
                    continue
                ty = h - 1 - dy if attr & 0x40 else dy
                lo, hi = bank[tile * 16 + ty * 2], bank[tile * 16 + ty * 2 + 1]
                for dx in range(8):
                    x = sx + dx
                    tx = 7 - dx if attr & 0x20 else dx
                    c = (lo >> (7 - tx) & 1) | (hi >> (7 - tx) & 1) << 1
                    if c and 0 <= x < 160:
                        out[y][x] = _rgb(gb.objpal, attr & 7, c)
    return out


def save_png(gb, path: Path, scale: int = 2) -> None:
    rows = render(gb)
    raw = b"".join(b"\0" + b"".join(bytes(px) * scale for px in row) for row in rows for _ in range(scale))

    def chunk(t: bytes, d: bytes) -> bytes:
        return struct.pack(">I", len(d)) + t + d + struct.pack(">I", zlib.crc32(t + d))

    Path(path).write_bytes(b"\x89PNG\r\n\x1a\n" + chunk(b"IHDR", struct.pack(">IIBBBBB", 160 * scale, 144 * scale,
                                                                                8, 2, 0, 0, 0))
                           + chunk(b"IDAT", zlib.compress(raw, 6)) + chunk(b"IEND", b""))
