#!/usr/bin/env python3
"""Encoder for the game's LZSS asset format (tools/lzss_gfx.py decodes it), E-0394 (M3).

The original compressed streams are reproduced by Haruhiko Okumura's LZSS.C binary-tree search (public-domain
1989 reference code), with the parameters and token format read from the game's data:

- ring of N = 4096 bytes, lookahead F = 96 (no reference in the ROM is longer than 96), THRESHOLD = 3 (a match of
  4 or more becomes a reference); the ring starts at position 0 and is zero-filled, and the F positions before it
  (4000-4095) are in the tree from the start, as LZSS.C inserts them, so a reference may read leading zeros;
- a match is the longest the tree walk finds, and a tie keeps the node reached first (LZSS.C replaces the match only
  on a strictly longer one); the parse is greedy;
- output: u16 size, then a marker byte, the lowest byte value absent from the data (true of all 3,546 streams);
  a literal is the byte itself; a reference is the marker, the low 8 bits of the ring position, and a byte with the
  position's high 4 bits on top and length - 4 below; lengths of 19 or more write 15 there and length - 19 after.

Usage: lzss_encode.py IN OUT   (raw bytes in, compressed stream out)
       lzss_encode.py --check  (encode every decoded stream of src/assets.txt and compare with the ROM)
"""
from __future__ import annotations

import sys
from pathlib import Path

N, F, THRESHOLD = 4096, 96, 3
NIL = N


def encode(data: bytes) -> bytes:
    """The compressed stream for `data` (at most 4096 bytes, and some byte value must be absent from it)."""
    if len(data) > N:
        raise ValueError("streams longer than the 4096-byte ring are not supported")
    marker = next((v for v in range(256) if v not in set(data)), None)
    if marker is None:
        raise ValueError("every byte value occurs in the data: no marker is free")
    out = bytearray([len(data) & 0xFF, len(data) >> 8, marker])
    text = bytearray(N + F - 1)
    lson, rson, dad = [NIL] * (N + 1), [NIL] * (N + 257), [NIL] * (N + 1)
    match = [0, 0]  # position, length

    def insert(r: int) -> None:
        cmp, key = 1, r
        p = N + 1 + text[key]
        rson[r] = lson[r] = NIL
        match[1] = 0
        while True:
            if cmp >= 0:
                if rson[p] != NIL:
                    p = rson[p]
                else:
                    rson[p] = r
                    dad[r] = p
                    return
            else:
                if lson[p] != NIL:
                    p = lson[p]
                else:
                    lson[p] = r
                    dad[r] = p
                    return
            i = 1
            while i < F:
                cmp = text[key + i] - text[p + i]
                if cmp != 0:
                    break
                i += 1
            if i > match[1]:
                match[0], match[1] = p, i
                if i >= F:
                    break
        dad[r], lson[r], rson[r] = dad[p], lson[p], rson[p]
        dad[lson[p]] = r
        dad[rson[p]] = r
        if rson[dad[p]] == p:
            rson[dad[p]] = r
        else:
            lson[dad[p]] = r
        dad[p] = NIL

    def delete(p: int) -> None:
        if dad[p] == NIL:
            return
        if rson[p] == NIL:
            q = lson[p]
        elif lson[p] == NIL:
            q = rson[p]
        else:
            q = lson[p]
            if rson[q] != NIL:
                while rson[q] != NIL:
                    q = rson[q]
                rson[dad[q]] = lson[q]
                dad[lson[q]] = dad[q]
                lson[q] = lson[p]
                dad[lson[p]] = q
            rson[q] = rson[p]
            dad[rson[p]] = q
        dad[q] = dad[p]
        if rson[dad[p]] == p:
            rson[dad[p]] = q
        else:
            lson[dad[p]] = q
        dad[p] = NIL

    r = 0  # LZSS.C starts r at N - F; this game's ring starts at 0 (zeros before it)
    s = F  # where the next input byte goes: the end of the lookahead, r + F, as in LZSS.C (E-0394)
    length = 0
    while length < F and length < len(data):
        text[r + length] = data[length]
        if length < F - 1:
            text[N + length] = data[length]  # the ring's mirror: strings at 4000-4095 run on into the data
        length += 1
    pos = length
    for i in range(1, F + 1):
        insert((r - i) % N)
    insert(r)
    while length > 0:
        if match[1] > length:
            match[1] = length
        if match[1] <= THRESHOLD:
            match[1] = 1
            out.append(text[r])
        else:
            mp, ml = match
            out += bytes([marker, mp & 0xFF])
            if ml - 4 < 15:
                out.append((mp >> 8) << 4 | (ml - 4))
            else:
                out += bytes([(mp >> 8) << 4 | 15, ml - 19])
        last = match[1]
        i = 0
        while i < last and pos < len(data):
            delete(s)
            c = data[pos]
            pos += 1
            text[s] = c
            if s < F - 1:
                text[s + N] = c
            s = (s + 1) % N
            r = (r + 1) % N
            insert(r)
            i += 1
        while i < last:
            delete(s)
            s = (s + 1) % N
            r = (r + 1) % N
            length -= 1
            if length:
                insert(r)
            i += 1
    return bytes(out)


def check() -> int:
    """Encode every decoded stream listed in src/assets.txt and compare with its ROM bytes."""
    sys.path.insert(0, str(Path(__file__).resolve().parent))
    import lzss_gfx
    root = Path(__file__).resolve().parents[1]
    rom = (root / "local/roms/dwm2-cobi-us.gbc").read_bytes()
    same = differ = 0
    first = []
    for ln in (root / "src/assets.txt").read_text(encoding="utf-8").splitlines():
        parts = ln.split("\t")
        if ln.startswith("#") or len(parts) != 3 or not parts[0].endswith(".lz"):
            continue
        off, size = int(parts[1].lstrip("$"), 16), int(parts[2].lstrip("$"), 16)
        bank, addr = off // 0x4000, off % 0x4000 + (0x4000 if off >= 0x4000 else 0)
        data, used, _ = lzss_gfx.decompress(rom, bank, addr)
        enc = encode(data)
        if enc == rom[off:off + used]:
            same += 1
        else:
            differ += 1
            if len(first) < 10:
                k = next((i for i, (a, b) in enumerate(zip(enc, rom[off:off + used])) if a != b), min(len(enc), used))
                first.append(f"{parts[0]}: {len(enc)} vs {used} bytes, first difference at byte {k}")
    print(f"{same} of {same + differ} streams re-encode byte for byte")
    for x in first:
        print("   ", x)
    return 0 if differ == 0 else 1


def main(argv: list[str]) -> int:
    if argv == ["--check"]:
        return check()
    if len(argv) != 2:
        print(__doc__)
        return 2
    Path(argv[1]).write_bytes(encode(Path(argv[0]).read_bytes()))
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
