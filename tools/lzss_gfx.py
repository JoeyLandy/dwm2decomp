#!/usr/bin/env python3
"""Decompressor for the game's LZSS-style asset format (C1 until fully cross-checked).

Reimplements, from a static reading of Func_000_0DA8 / Func_000_0C69 / Func_000_0CF5, the
routine that expands compressed assets into RAM (0C69) or VRAM (0CF5). Stream layout:

    u16  output size (little endian)
    u8   marker byte
    ...  any byte other than the marker is a literal; the marker introduces a
         back-reference of two bytes, `lo` then `b2`:
           length = (b2 & 15) + 4; if that equals 0x13, one more byte follows and
                    length = that byte + 0x13
           offset = ((b2 >> 4) << 8) | lo, measured from the START of the output

A source position at or past the output end is moved back by 0x1000; if the result is
before the output start the byte is 0, so the window behaves as if pre-filled with zeros.
Decoding stops as soon as `size` bytes have been produced.

Cross-check: tests/golden_gfx_assets.json lists assets that the emulator (tools/sm83.py)
saw the game decompress; every one matched this implementation byte for byte.

Usage: lzss_gfx.py BANK ADDR   (hex)   -> prints size, bytes consumed and a hex preview
"""
from __future__ import annotations

import sys
from pathlib import Path

BANK = 0x4000


def file_offset(bank: int, addr: int) -> int:
    return addr if addr < 0x4000 else bank * BANK + addr - 0x4000


def decompress(rom: bytes, bank: int, addr: int, prior: bytes | None = None):
    """Return (output, bytes_consumed, events). `prior` is the destination memory before
    the call (used only when a back-reference reads a not-yet-written position, which the
    original code reads as whatever memory held); events counts such reads."""
    p0 = file_offset(bank, addr)
    p = p0
    size = rom[p] | (rom[p + 1] << 8)
    marker = rom[p + 2]
    p += 3
    out = bytearray()
    events = {"unwritten_reads": 0, "zero_fills": 0, "wraps": 0, "extended": 0}
    while len(out) < size:
        b = rom[p]
        p += 1
        if b != marker:
            out.append(b)
            continue
        lo = rom[p]
        b2 = rom[p + 1]
        p += 2
        length = (b2 & 0x0F) + 4
        if length == 0x13:
            length = rom[p] + 0x13
            p += 1
            events["extended"] += 1
        src = ((b2 >> 4) << 8) | lo
        for _ in range(length):
            if src >= size:  # at or past the output end
                t = src - 0x1000
                if t >= 0:
                    events["wraps"] += 1
                    src = t
                    byte = out[t] if t < len(out) else _unwritten(prior, t, events)
                else:
                    events["zero_fills"] += 1
                    byte = 0
            else:
                byte = out[src] if src < len(out) else _unwritten(prior, src, events)
            out.append(byte)
            src += 1
            if len(out) >= size:
                break
    return bytes(out), p - p0, events


def _unwritten(prior, pos, events):
    events["unwritten_reads"] += 1
    return prior[pos] if prior is not None and pos < len(prior) else 0


def main() -> int:
    rom = (Path(__file__).resolve().parents[1] / "local/roms/dwm2-cobi-us.gbc").read_bytes()
    bank, addr = int(sys.argv[1], 16), int(sys.argv[2], 16)
    out, used, ev = decompress(rom, bank, addr)
    print(f"output {len(out)} bytes from {used} compressed bytes; events {ev}")
    print(out[:64].hex(" "))
    return 0


if __name__ == "__main__":
    sys.exit(main())
