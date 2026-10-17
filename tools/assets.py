#!/usr/bin/env python3
"""M3 editable assets (E-0394): the compressed asset files of src/assets.txt from decoded, editable data.

Every `.lz` file src/ includes is an LZSS stream (tools/lzss_gfx.py). tools/build.py no longer copies those
bytes from the reference ROM: it decodes each stream and encodes the data again with tools/lzss_encode.py, which
reproduces all 3,546 original streams byte for byte. With `--mod DIR` the data comes from edited files instead:

  DIR/<path>.png   tile graphics (2bpp tiles: paths under gfx/ and map tilesets), read with rgbgfx
  DIR/<path>.bin   any asset as raw decoded bytes

where <path> is the asset path without `.lz` (gfx/monster_pics/slime). `export` writes every asset in both
forms (.png where it is tile graphics) to start from. Extracted data comes from the game, so it stays in an
ignored directory (local/ or build/), as the reference ROM does.

A PNG is as many tiles wide as the largest divisor of its tile count up to 16, so it has no padding tiles and
converts back to exactly the same bytes (rgbgfx -r, then rgbgfx).

Usage: assets.py export [--out local/assets] [--png-only]
"""
from __future__ import annotations

import argparse
import hashlib
import json
import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import lzss_encode  # noqa: E402
import lzss_gfx  # noqa: E402

import toolchain  # noqa: E402  (H6)
RGBGFX = toolchain.exe("rgbgfx")
REF = ROOT / "local/roms/dwm2-cobi-us.gbc"
MANIFEST = ROOT / "config/targets/dwm2-cobi-us-rev0.json"


def listed() -> list[tuple[str, int, int]]:
    """(path, file offset, length) of every asset line of src/assets.txt."""
    out = []
    for ln in (ROOT / "src/assets.txt").read_text(encoding="utf-8").splitlines():
        parts = ln.split("\t")
        if ln.strip() and not ln.startswith("#") and len(parts) == 3:
            out.append((parts[0], int(parts[1].lstrip("$"), 16), int(parts[2].lstrip("$"), 16)))
    return out


def reference() -> bytes:
    data = REF.read_bytes()
    want = json.loads(MANIFEST.read_text())["sha256"].lower()
    if hashlib.sha256(data).hexdigest() != want:
        sys.exit("FAIL: the reference ROM does not match the target manifest; assets not extracted")
    return data


def decoded(rom: bytes, off: int) -> bytes:
    bank, addr = off // 0x4000, off % 0x4000 + (0x4000 if off >= 0x4000 else 0)
    return lzss_gfx.decompress(rom, bank, addr)[0]


def is_tiles(path: str, data: bytes) -> bool:
    """Tile graphics: 2bpp tiles under gfx/ or a map tileset (screens and attribute maps are bytes, not tiles)."""
    return len(data) % 16 == 0 and len(data) > 0 and (path.startswith("gfx/") or "tileset" in Path(path).name)


def png_width(ntiles: int) -> int:
    return max(d for d in range(1, 17) if ntiles % d == 0)


def to_png(data: bytes, png: Path) -> None:
    with tempfile.TemporaryDirectory() as d:
        raw = Path(d) / "a.2bpp"
        raw.write_bytes(data)
        png.parent.mkdir(parents=True, exist_ok=True)
        subprocess.run([str(RGBGFX), "-r", str(png_width(len(data) // 16)), "-o", str(raw), str(png)], check=True,
                       capture_output=True)


def from_png(png: Path) -> bytes:
    with tempfile.TemporaryDirectory() as d:
        raw = Path(d) / "a.2bpp"
        subprocess.run([str(RGBGFX), "-o", str(raw), str(png)], check=True, capture_output=True)
        return raw.read_bytes()


def asset_data(path: str, rom: bytes, off: int, mod: Path | None) -> tuple[bytes, str]:
    """The decoded data of one asset and where it came from: an edited file in `mod`, else the ROM."""
    stem = path[:-3] if path.endswith(".lz") else path
    if mod is not None:
        if (mod / f"{stem}.png").exists():
            return from_png(mod / f"{stem}.png"), "png"
        if (mod / f"{stem}.bin").exists():
            return (mod / f"{stem}.bin").read_bytes(), "bin"
    return decoded(rom, off), "rom"


def build_assets(dest: Path, mod: Path | None = None, rom: bytes | None = None) -> dict[str, int]:
    """Write every asset file src/ includes under dest, each encoded from its decoded data (`rom`: the verified
    reference, read here when not given). Without `mod` the result must equal the ROM's bytes (checked here, so a
    build never hides an encoder difference)."""
    rom = rom if rom is not None else reference()
    counts = {"rom": 0, "png": 0, "bin": 0, "unchanged": 0, "deltas": {}}
    for path, off, size in listed():
        target = dest / path
        target.parent.mkdir(parents=True, exist_ok=True)
        if not path.endswith(".lz"):
            target.write_bytes(rom[off:off + size])
            counts["rom"] += 1
            continue
        data, where = asset_data(path, rom, off, mod)
        if where != "rom" and data == decoded(rom, off):
            where = "rom"  # an edited file that holds the original data builds exactly like the reference
            counts["unchanged"] += 1
        enc = lzss_encode.encode(data)
        bank, addr = off // 0x4000, off % 0x4000 + (0x4000 if off >= 0x4000 else 0)
        used = lzss_gfx.decompress(rom, bank, addr)[1]  # the original stream's length
        tail = rom[off + used:off + size]  # bytes of the slice after its stream, never decoded (3 slices)
        if where == "rom":
            # four streams end in the first byte or two of the next slice (tests/test_asset_streams.py SHARED_TAIL):
            # the slice holds the stream up to there, and the rest must be the bytes that follow it in the ROM
            if enc != rom[off:off + len(enc)]:
                sys.exit(f"FAIL: {path} does not re-encode to the reference bytes")
            enc = enc[:size]
        target.write_bytes(enc + tail)
        if len(enc + tail) != size:
            counts["deltas"][path] = len(enc + tail) - size
        counts[where] += 1
    return counts


def absorb_size_changes(src: Path, deltas: dict[str, int]) -> list[str]:
    """In a copy of src/, take each edited asset's change in size out of the trailing `ds` fill of the bank file
    that includes it, so every bank keeps its size and the sections after the asset move (labels follow them).
    Stops with the bank and the bytes missing when a bank has too little free space: then move a section to
    another bank first (tools/move_section.py, src/layout.link)."""
    import re
    ds = re.compile(r"^(\s*)(ds|DS) (\$[0-9A-Fa-f]+|\d+)(\s*,\s*[^;]*)?(\s*;.*)?$")
    per_file: dict[Path, int] = {}
    for path, delta in deltas.items():
        f = next((p for p in src.glob("*/bank*.asm") if f'INCBIN "{path}"' in p.read_text(encoding="utf-8")), None)
        if f is None:
            sys.exit(f"FAIL: no bank file includes {path}")
        per_file[f] = per_file.get(f, 0) + delta
    notes = []
    for f, delta in per_file.items():
        lines = f.read_text(encoding="utf-8").split("\n")
        k = max((i for i, ln in enumerate(lines) if ds.match(ln)), default=None)
        if k is None:
            sys.exit(f"FAIL: {f.name} has no trailing fill to take {delta} bytes from; move a section to another bank")
        m = ds.match(lines[k])
        free = int(m.group(3)[1:], 16) if m.group(3).startswith("$") else int(m.group(3))
        if free < delta:
            sys.exit(f"FAIL: {f.name} needs {delta - free} more bytes than its {free}-byte fill; move a section to "
                     f"another bank first (tools/move_section.py)")
        lines[k] = f"{m.group(1)}{m.group(2)} ${free - delta:X}{m.group(4) or ''}{m.group(5) or ''}"
        f.write_text("\n".join(lines), encoding="utf-8", newline="\n")
        notes.append(f"{f.name}: fill {free} -> {free - delta} bytes")
    return notes


def export(out: Path, png_only: bool = False) -> dict[str, int]:
    rom = reference()
    n = {"bin": 0, "png": 0}
    for path, off, _size in listed():
        if not path.endswith(".lz"):
            continue
        data = decoded(rom, off)
        stem = out / path[:-3]
        stem.parent.mkdir(parents=True, exist_ok=True)
        if is_tiles(path, data):
            to_png(data, stem.with_suffix(".png"))
            n["png"] += 1
        if not png_only:
            stem.with_suffix(".bin").write_bytes(data)
            n["bin"] += 1
    return n


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    sub = ap.add_subparsers(dest="cmd", required=True)
    e = sub.add_parser("export")
    e.add_argument("--out", type=Path, default=ROOT / "local/assets")
    e.add_argument("--png-only", action="store_true")
    args = ap.parse_args(argv)
    out = args.out.resolve()
    if not any(p in out.parents for p in ((ROOT / "local").resolve(), (ROOT / "build").resolve())):
        sys.exit("extracted assets stay in an ignored directory: give a path under local/ or build/")
    n = export(out, args.png_only)
    print(f"wrote {n['png']} PNG and {n['bin']} .bin files under {out}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
