#!/usr/bin/env python3
"""Render the current LCD state of tools/sm83.py to a PNG (background, window, sprites).

A once-per-frame approximation: it ignores per-scanline register changes, so raster effects
(for example the LCD-status scroll handler) are not reproduced. Output is for looking at what
the game shows; anything learned from it is an OBSERVATION of our own emulator (C1 at most).
"""
from __future__ import annotations

import struct
import zlib


def _rgb555(lo: int, hi: int) -> tuple[int, int, int]:
    v = lo | (hi << 8)
    r, g, b = v & 31, (v >> 5) & 31, (v >> 10) & 31
    return (r << 3 | r >> 2, g << 3 | g >> 2, b << 3 | b >> 2)


def _palette(ram: bytearray, n: int) -> list[tuple[int, int, int]]:
    return [_rgb555(ram[n * 8 + 2 * i], ram[n * 8 + 2 * i + 1]) for i in range(4)]


def _tile_row(gb, bank: int, tile: int, y: int, xflip: bool) -> list[int]:
    base = tile * 16 + y * 2
    lo, hi = gb.vram[bank][base], gb.vram[bank][base + 1]
    row = [((hi >> (7 - x)) & 1) << 1 | ((lo >> (7 - x)) & 1) for x in range(8)]
    return row[::-1] if xflip else row


def render(gb) -> tuple[int, int, bytes]:
    """Return (160, 144, rgb bytes) for the machine's current video state."""
    lcdc = gb.io[0x40]
    px = bytearray(160 * 144 * 3)
    prio = [[0] * 160 for _ in range(144)]
    cgb = True
    bgp = [_palette(gb.bgpal, i) for i in range(8)]
    objp = [_palette(gb.objpal, i) for i in range(8)]
    if not lcdc & 0x80:
        return 160, 144, bytes(px)

    def tile_index(tile: int) -> int:
        # LCDC bit 4 set: tiles 0-255 at $8000. Clear: tile 0-127 at $9000, 128-255 at $8800.
        return tile if lcdc & 0x10 else (tile if tile >= 128 else tile + 256)

    def draw_plane(map_base: int, ox: int, oy: int, top: int, left: int, window: bool):
        for sy in range(top, 144):
            yy = (sy - top + oy) if window else ((sy + oy) & 0xFF)
            for sx in range(left, 160):
                xx = (sx - left + ox) if window else ((sx + ox) & 0xFF)
                mi = map_base + (yy >> 3) * 32 + ((xx >> 3) & 31)
                tile = gb.vram[0][(mi - 0x8000) & 0x1FFF]
                attr = gb.vram[1][(mi - 0x8000) & 0x1FFF]
                y = yy & 7
                if attr & 0x40:
                    y = 7 - y
                c = _tile_row(gb, (attr >> 3) & 1, tile_index(tile), y, bool(attr & 0x20))[xx & 7]
                o = (sy * 160 + sx) * 3
                px[o:o + 3] = bytes(bgp[attr & 7][c])
                prio[sy][sx] = (1 if attr & 0x80 else 0) | (2 if c else 0)

    bg_map = 0x9C00 if lcdc & 0x08 else 0x9800
    win_map = 0x9C00 if lcdc & 0x40 else 0x9800
    draw_plane(bg_map, gb.io[0x43], gb.io[0x42], 0, 0, False)
    if lcdc & 0x20 and gb.io[0x4A] < 144 and gb.io[0x4B] < 167:
        draw_plane(win_map, 0, 0, gb.io[0x4A], max(0, gb.io[0x4B] - 7), True)
    if lcdc & 0x02:
        tall = bool(lcdc & 0x04)
        for i in range(39, -1, -1):
            y, x, tile, attr = gb.oam[i * 4:i * 4 + 4]
            y -= 16
            x -= 8
            if y <= -16 or y >= 144 or x <= -8 or x >= 160:
                continue
            for dy in range(16 if tall else 8):
                sy = y + dy
                if not 0 <= sy < 144:
                    continue
                ry = (15 - dy) if attr & 0x40 and tall else (7 - dy if attr & 0x40 else dy)
                t = (tile & 0xFE) + (ry >> 3) if tall else tile
                row = _tile_row(gb, (attr >> 3) & 1, t, ry & 7, bool(attr & 0x20))
                for dx in range(8):
                    sx = x + dx
                    if not 0 <= sx < 160 or row[dx] == 0:
                        continue
                    if attr & 0x80 and prio[sy][sx] & 2:
                        continue
                    if prio[sy][sx] & 1 and prio[sy][sx] & 2:
                        continue
                    o = (sy * 160 + sx) * 3
                    px[o:o + 3] = bytes(objp[attr & 7][row[dx]])
    return 160, 144, bytes(px)


def write_png(path, width: int, height: int, rgb: bytes, scale: int = 2) -> None:
    rows = []
    for y in range(height):
        line = rgb[y * width * 3:(y + 1) * width * 3]
        big = b"".join(line[x * 3:x * 3 + 3] * scale for x in range(width))
        rows.extend([b"\x00" + big] * scale)

    def chunk(tag: bytes, data: bytes) -> bytes:
        body = tag + data
        return struct.pack(">I", len(data)) + body + struct.pack(">I", zlib.crc32(body) & 0xFFFFFFFF)

    png = b"\x89PNG\r\n\x1a\n" + chunk(b"IHDR", struct.pack(">IIBBBBB", width * scale, height * scale, 8, 2, 0, 0, 0))
    png += chunk(b"IDAT", zlib.compress(b"".join(rows), 6)) + chunk(b"IEND", b"")
    with open(path, "wb") as f:
        f.write(png)
