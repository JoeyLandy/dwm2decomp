#!/usr/bin/env python3
"""BPS patches: a mod is shared as the difference from the original ROM, never as a ROM (H6).

  make ORIGINAL MOD OUT.bps [--name TEXT]   write a patch that turns ORIGINAL into MOD
  apply ORIGINAL PATCH.bps OUT              apply a patch; refuses a wrong original or a damaged patch
  info PATCH.bps                            sizes, checksums and the metadata text

The format is BPS (beat patch, version 1), which common patchers (Floating IPS, Beat, Rom Patcher JS) apply:
"BPS1", the source, target and metadata sizes as variable-length numbers, the metadata, a list of actions
(SourceRead, TargetRead, SourceCopy, TargetCopy, each with a length and, for the copies, a signed relative offset),
then the CRC32 of the source, the target and the patch. The source CRC32 is what lets a patcher refuse a ROM that is
not the one the patch was made from. Standard library only.
"""
from __future__ import annotations

import argparse
import sys
import zlib
from pathlib import Path

SOURCE_READ, TARGET_READ, SOURCE_COPY, TARGET_COPY = range(4)
BLOCK = 8  # bytes hashed to find copies


def encode_number(n: int) -> bytes:
    out = bytearray()
    while True:
        x = n & 0x7F
        n >>= 7
        if n == 0:
            out.append(0x80 | x)
            return bytes(out)
        out.append(x)
        n -= 1


def decode_number(data: bytes, p: int) -> tuple[int, int]:
    n, shift = 0, 1
    while True:
        x = data[p]
        p += 1
        n += (x & 0x7F) * shift
        if x & 0x80:
            return n, p
        shift <<= 7
        n += shift


def make(source: bytes, target: bytes, metadata: str = "") -> bytes:
    """A BPS patch from source to target. SourceRead where the bytes are unchanged in place; SourceCopy where a run
    of the target is found elsewhere in the source (data that moved, as when a list grows); TargetRead for the
    rest."""
    index: dict[bytes, list[int]] = {}
    for i in range(0, len(source) - BLOCK + 1, 1 if len(source) <= 1 << 16 else 4):
        index.setdefault(source[i:i + BLOCK], []).append(i)
    meta = metadata.encode("utf-8")
    out = bytearray(b"BPS1" + encode_number(len(source)) + encode_number(len(target)) + encode_number(len(meta)) + meta)
    literal = bytearray()
    source_rel = 0
    t = 0

    def flush():
        nonlocal literal
        if literal:
            out.extend(encode_number(((len(literal) - 1) << 2) | TARGET_READ))
            out.extend(literal)
            literal = bytearray()

    while t < len(target):
        # unchanged in place
        n = 0
        while t + n < len(target) and t + n < len(source) and target[t + n] == source[t + n]:
            n += 1
        if n >= 4:
            flush()
            out.extend(encode_number(((n - 1) << 2) | SOURCE_READ))
            t += n
            continue
        # found elsewhere in the source
        best, at = 0, -1
        for cand in index.get(target[t:t + BLOCK], [])[:32]:
            m = 0
            while t + m < len(target) and cand + m < len(source) and target[t + m] == source[cand + m]:
                m += 1
            if m > best:
                best, at = m, cand
        if best >= BLOCK + 4:
            flush()
            out.extend(encode_number(((best - 1) << 2) | SOURCE_COPY))
            rel = at - source_rel
            out.extend(encode_number((abs(rel) << 1) | (rel < 0)))
            source_rel = at + best
            t += best
            continue
        literal.append(target[t])
        t += 1
    flush()
    out.extend(zlib.crc32(source).to_bytes(4, "little"))
    out.extend(zlib.crc32(target).to_bytes(4, "little"))
    out.extend(zlib.crc32(bytes(out)).to_bytes(4, "little"))
    return bytes(out)


def parse_header(patch: bytes) -> dict:
    if patch[:4] != b"BPS1":
        raise ValueError("not a BPS patch")
    if zlib.crc32(patch[:-4]) != int.from_bytes(patch[-4:], "little"):
        raise ValueError("the patch is damaged (its checksum does not match)")
    p = 4
    src_size, p = decode_number(patch, p)
    tgt_size, p = decode_number(patch, p)
    meta_size, p = decode_number(patch, p)
    meta = patch[p:p + meta_size].decode("utf-8", "replace")
    return {"source_size": src_size, "target_size": tgt_size, "metadata": meta, "start": p + meta_size,
            "source_crc": int.from_bytes(patch[-12:-8], "little"), "target_crc": int.from_bytes(patch[-8:-4], "little")}


def apply(source: bytes, patch: bytes) -> bytes:
    h = parse_header(patch)
    if len(source) != h["source_size"] or zlib.crc32(source) != h["source_crc"]:
        raise ValueError("this ROM is not the one the patch was made for (size or CRC32 differs)")
    out = bytearray()
    p, end = h["start"], len(patch) - 12
    source_rel = target_rel = 0
    while p < end:
        data, p = decode_number(patch, p)
        action, length = data & 3, (data >> 2) + 1
        if action == SOURCE_READ:
            out += source[len(out):len(out) + length]
        elif action == TARGET_READ:
            out += patch[p:p + length]
            p += length
        else:
            off, p = decode_number(patch, p)
            off = -(off >> 1) if off & 1 else off >> 1
            if action == SOURCE_COPY:
                source_rel += off
                out += source[source_rel:source_rel + length]
                source_rel += length
            else:
                target_rel += off
                for _ in range(length):  # may overlap what it writes
                    out.append(out[target_rel])
                    target_rel += 1
    if len(out) != h["target_size"] or zlib.crc32(bytes(out)) != h["target_crc"]:
        raise ValueError("the patched ROM does not match the patch's checksum")
    return bytes(out)


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    sub = ap.add_subparsers(dest="command", required=True)
    m = sub.add_parser("make")
    m.add_argument("original", type=Path)
    m.add_argument("mod", type=Path)
    m.add_argument("out", type=Path)
    m.add_argument("--name", default="")
    a_ = sub.add_parser("apply")
    a_.add_argument("original", type=Path)
    a_.add_argument("patch", type=Path)
    a_.add_argument("out", type=Path)
    i = sub.add_parser("info")
    i.add_argument("patch", type=Path)
    a = ap.parse_args(argv)
    try:
        if a.command == "make":
            data = make(a.original.read_bytes(), a.mod.read_bytes(), a.name)
            a.out.write_bytes(data)
            print(f"{a.out}: {len(data)} bytes")
        elif a.command == "apply":
            a.out.write_bytes(apply(a.original.read_bytes(), a.patch.read_bytes()))
            print(f"{a.out}: patched")
        else:
            h = parse_header(a.patch.read_bytes())
            print(f"source {h['source_size']} bytes, CRC32 {h['source_crc']:08X}; target {h['target_size']} bytes, "
                  f"CRC32 {h['target_crc']:08X}; {h['metadata']!r}")
    except ValueError as e:
        print(f"refused: {e}", file=sys.stderr)
        return 2
    return 0


if __name__ == "__main__":
    sys.exit(main())
