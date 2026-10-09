#!/usr/bin/env python3
"""Decompress the compressed assets found by tools/disasm_all.py into an ignored directory.

Reads the stream list written by `disasm_all.py --export-streams build/streams.json` and the
local reference ROM, expands each stream with tools/lzss_gfx.py, and writes
<out>/bank<BB>_<AAAA>.bin plus <out>/manifest.json (sizes, SHA-256 of each output, and how
many bytes are a whole number of 16-byte tiles). Extracted bytes are derived from the game
and stay under build/ (git-ignored); nothing here is committed.

Usage: extract_assets.py [--streams build/streams.json] [--out build/assets]
"""
from __future__ import annotations

import argparse
import hashlib
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from lzss_gfx import decompress  # noqa: E402

ROOT = Path(__file__).resolve().parents[1]


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--streams", type=Path, default=ROOT / "build/streams.json")
    ap.add_argument("--out", type=Path, default=ROOT / "build/assets")
    ap.add_argument("--rom", type=Path, default=ROOT / "local/roms/dwm2-cobi-us.gbc")
    a = ap.parse_args()
    for path, what in ((a.streams, "stream list (run tools/disasm_all.py --export-streams first)"),
                       (a.rom, "reference ROM")):
        if not path.exists():
            print(f"missing {what}: {path}", file=sys.stderr)
            return 1
    out_dir = (ROOT / "build").resolve()
    if out_dir not in a.out.resolve().parents and a.out.resolve() != out_dir:
        print("output directory must be inside build/ so extracted game data stays ignored", file=sys.stderr)
        return 1
    a.out.mkdir(parents=True, exist_ok=True)
    rom = a.rom.read_bytes()
    manifest, bad = [], []
    for s in json.loads(a.streams.read_text(encoding="utf-8")):
        data, used, ev = decompress(rom, s["bank"], s["addr"])
        if len(data) != s["size"] or used != s["compressed"]:
            bad.append(s)
            continue
        name = f"bank{s['bank']:02x}_{s['addr']:04x}.bin"
        (a.out / name).write_bytes(data)
        manifest.append({"file": name, "bank": s["bank"], "addr": s["addr"], "compressed": used,
                         "size": len(data), "sha256": hashlib.sha256(data).hexdigest(),
                         "whole_tiles": len(data) % 16 == 0, "events": ev})
    (a.out / "manifest.json").write_text(json.dumps(manifest, indent=1), encoding="utf-8")
    tiles = sum(1 for m in manifest if m["whole_tiles"])
    print(f"extracted {len(manifest)} assets ({sum(m['size'] for m in manifest)} bytes) to {a.out}; "
          f"{tiles} are a whole number of 16-byte tiles; {len(bad)} listed streams did not reproduce")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
