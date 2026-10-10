#!/usr/bin/env python3
"""Join several 160x144 screenshots from build/shots/ into one PNG: contact_sheet.py OUT COLS NAME...

NAME is a file stem in build/shots/ saved at scale 1 (tools/explore.py writes scale 2 for play, 1 for modes)."""
from __future__ import annotations

import struct
import sys
import zlib
from pathlib import Path

SHOTS = Path(__file__).resolve().parents[1] / "build/shots"


def read_png(path: Path):
    data = path.read_bytes()
    pos, idat, w, h = 8, b"", 0, 0
    while pos < len(data):
        length = struct.unpack(">I", data[pos:pos + 4])[0]
        tag, body = data[pos + 4:pos + 8], data[pos + 8:pos + 8 + length]
        if tag == b"IHDR":
            w, h = struct.unpack(">II", body[:8])
        elif tag == b"IDAT":
            idat += body
        pos += 12 + length
    raw = zlib.decompress(idat)
    return w, h, [raw[y * (w * 3 + 1) + 1:(y + 1) * (w * 3 + 1)] for y in range(h)]


def main(argv: list[str]) -> int:
    if len(argv) < 3:
        print(__doc__)
        return 2
    out, cols, names = Path(argv[0]), int(argv[1]), argv[2:]
    imgs = [read_png(SHOTS / f"{n}.png") for n in names]
    w, h, _ = imgs[0]
    rows = []
    for r in range(0, len(imgs), cols):
        group = imgs[r:r + cols]
        for y in range(h):
            line = b"".join(im[2][y] + b"\x80\x80\x80" for im in group)
            line += b"\x80\x80\x80" * (w + 1) * (cols - len(group))
            rows.append(b"\x00" + line)

    def chunk(tag: bytes, body: bytes) -> bytes:
        b = tag + body
        return struct.pack(">I", len(body)) + b + struct.pack(">I", zlib.crc32(b) & 0xFFFFFFFF)

    png = b"\x89PNG\r\n\x1a\n" + chunk(b"IHDR", struct.pack(">IIBBBBB", (w + 1) * cols, len(rows), 8, 2, 0, 0, 0))
    png += chunk(b"IDAT", zlib.compress(b"".join(rows))) + chunk(b"IEND", b"")
    out.write_bytes(png)
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
