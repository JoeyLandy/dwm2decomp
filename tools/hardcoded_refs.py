#!/usr/bin/env python3
"""M1 inventory (E-0388): values in src/ written as numbers where a label expression would follow moved code.

Reads src/ and the symbol file of a matching build (default: the newest build/run*/dwm2.sym) and counts, by kind
and bank, the places that would not follow their target if code or data moved (tools/shift_test.py finds which of
them matter at run time). A candidate is a number that equals a label's address (or bank) in the context it is
used; a number that only happens to equal an address is a false positive, so every kind except `incbin_raw` is a
candidate list, not a proof (C1). Kinds:

  code_address   an instruction operand $XXXX (ld rr / jp / call / ld [nn]) equal to a label in bank $00 or the
                 instruction's own bank
  code_number    `ld bc/de/hl, $XXXX` with $XXXX in the switchable window ($4000-$7FFF) of a switchable bank, label or
                 not: a pointer into the middle of a block (FillTilesFromRequest's `ld de, $2940` is the bank-$00 kind,
                 found by tools/shift_test.py; bank-$00 numbers are not counted here, as message ids share that range)
  code_split     `add $LO` then, within four lines, `adc $HI`: a table address split into two 8-bit immediates
                 (hMapId * 2 + $4174 in LoadMapObjectsForScreen), with $HI:$LO in $0150-$7FFF
  code_bank      `ld r, $NN` within three instruction lines of an operand label whose bank is $NN (a bank switch
                 or far copy written with a literal bank instead of BANK(label))
  data_word      a `dw $XXXX` item equal to a label in bank $00 or the line's own bank
  data_tiles     a `dw` line of two or more $4000-$7FFF values, all multiples of 16 (tile addresses), ending in
                 $FFFF or not: tile and glyph source lists that point into another bank's graphics by number
                 (the glyph source lists into GlyphFont, bank $1F, that tools/shift_test.py found); counted by items
  data_bank      a lone `db $NN` right before or after a `dw Label` line whose bank is $NN (a far pointer written
                 without dfar or BANK())
  data_pair      two consecutive `db` bytes lo, hi that spell a label address in the line's own bank ($4000-$7FFF)
                 or bank $00 ($0150-$3FFF); many are coincidences
  incbin_raw     an asset slice that is not an LZSS stream (src/assets.txt, not .lz): bytes the source cannot
                 relocate, with the number of little-endian words in it that equal a label address of its bank

Usage: hardcoded_refs.py [--sym build/runN/dwm2.sym] [--json out.json] [--examples 5]
"""
from __future__ import annotations

import argparse
import collections
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SECTION = re.compile(r'^SECTION "Bank ([0-9A-F]{2})"')
NUM16 = re.compile(r"(?<![\w$])\$([0-9A-Fa-f]{4})\b")
INSN_ADDR = re.compile(r"^\s+(ld|jp|call)\b")
LD16 = re.compile(r"^\s+ld (bc|de|hl), \$([0-9A-Fa-f]{4})\s*$")
ADD = re.compile(r"^\s+add (?:a, )?\$([0-9A-Fa-f]{2})\s*$")
ADC = re.compile(r"^\s+adc (?:a, )?\$([0-9A-Fa-f]{2})\s*$")
LD8 = re.compile(r"^\s+ld ([abcdehl]), \$([0-9A-Fa-f]{2})\s*$")
OPERAND_LABEL = re.compile(r"^\s+(?:ld|jp|call|farcall\w*)\b[^;]*?\b([A-Za-z_][A-Za-z0-9_]*)\b\s*\]?\s*$")
DW_LABEL = re.compile(r"^\s+dw ([A-Za-z_]\w*)\s*$")
LONE_DB = re.compile(r"^\s+db \$([0-9A-Fa-f]{2})\s*$")
DB = re.compile(r"^\s+db (.*)$")


def strip_comment(ln: str) -> str:
    out, q = [], False
    for ch in ln:
        if ch == '"':
            q = not q
        if ch == ";" and not q:
            break
        out.append(ch)
    return "".join(out).rstrip()


def newest_sym() -> Path:
    syms = sorted(ROOT.glob("build/run*/dwm2.sym"), key=lambda p: p.stat().st_mtime)
    if not syms:
        sys.exit("no build/run*/dwm2.sym; run tools/build.py first")
    return syms[-1]


def load_sym(path: Path) -> tuple[dict[str, tuple[int, int]], set[tuple[int, int]]]:
    """name -> (bank, addr) for every label, local ones included, and the set of (bank, addr) with a label."""
    names, at = {}, set()
    for ln in path.read_text(encoding="utf-8").split("\n"):
        m = re.match(r"([0-9a-fA-F]{2,3}):([0-9a-fA-F]{4}) (\S+)$", ln)
        if m:
            k = (int(m.group(1), 16), int(m.group(2), 16))
            names[m.group(3)] = k
            at.add(k)
    return names, at


def is_label_at(at: set, bank: int, addr: int) -> bool:
    """A label at addr seen from code or data in `bank`: bank $00 below $4000, the own bank above."""
    if 0x0150 <= addr < 0x4000:
        return (0, addr) in at
    if 0x4000 <= addr < 0x8000 and bank:
        return (bank, addr) in at
    return False


def scan(src: Path, names: dict, at: set) -> dict[str, list[tuple[int, str, int, str]]]:
    """kind -> [(bank, file, line number, text)]."""
    found: dict[str, list] = collections.defaultdict(list)
    for p in sorted(src.glob("*/bank*.asm")):
        bank = None
        lines = p.read_text(encoding="utf-8").split("\n")
        code = [strip_comment(ln) for ln in lines]
        for i, ln in enumerate(code):
            m = SECTION.match(ln)
            if m:
                bank = int(m.group(1), 16)
                continue
            if bank is None or not ln.strip():
                continue
            rel = p.relative_to(src).as_posix()
            rec = (bank, rel, i + 1, lines[i].strip()[:160])
            if INSN_ADDR.match(ln):
                if any(is_label_at(at, bank, int(v, 16)) for v in NUM16.findall(ln)):
                    found["code_address"].append(rec)
            m = LD16.match(ln)
            if m and bank and 0x4000 <= int(m.group(2), 16) < 0x8000:
                found["code_number"].append(rec)
            m = ADD.match(ln)
            if m:
                for j in range(i + 1, min(len(code), i + 5)):
                    mh = ADC.match(code[j])
                    if mh:
                        if 0x0150 <= (int(mh.group(1), 16) << 8 | int(m.group(1), 16)) < 0x8000:
                            found["code_split"].append(rec)
                        break
            m = LD8.match(ln)
            if m:
                nn = int(m.group(2), 16)
                for j in range(max(0, i - 3), min(len(code), i + 4)):
                    mo = OPERAND_LABEL.match(code[j]) if j != i else None
                    if mo and mo.group(1) in names and names[mo.group(1)][0] == nn and nn:
                        found["code_bank"].append(rec)
                        break
            s = ln.strip()
            if s.startswith("dw "):
                if any(is_label_at(at, bank, int(v, 16)) for v in NUM16.findall(s)):
                    found["data_word"].append(rec)
            if s.startswith("dw "):
                ws = [int(v, 16) for v in re.findall(r"\$([0-9A-Fa-f]{4})", s)]
                tiles = [w for w in ws if w != 0xFFFF]
                if len(tiles) >= 2 and len(ws) == len([x for x in s[3:].split(",") if x.strip()]) and                         all(0x4000 <= w < 0x8000 and w % 16 == 0 for w in tiles):
                    found["data_tiles"].extend([rec] * len(tiles))
            m = LONE_DB.match(ln)
            if m:
                nn = int(m.group(1), 16)
                for j in (i - 1, i + 1):
                    md = DW_LABEL.match(code[j]) if 0 <= j < len(code) else None
                    if md and md.group(1) in names and names[md.group(1)][0] == nn and nn:
                        found["data_bank"].append(rec)
                        break
            m = DB.match(ln)
            if m and '"' not in m.group(1):
                items = [x.strip() for x in m.group(1).split(",")]
                vals = [int(x[1:], 16) if re.fullmatch(r"\$[0-9A-Fa-f]{1,2}", x) else None for x in items]
                if any(lo is not None and hi is not None and is_label_at(at, bank, lo | hi << 8)
                       for lo, hi in zip(vals, vals[1:])):
                    found["data_pair"].append(rec)
    return found


def incbin_raw(at: set) -> list[tuple[int, str, int, int]]:
    """Non-LZSS asset slices: (bank, path, length, words equal to a label address of the slice's bank)."""
    rom = (ROOT / "local/roms/dwm2-cobi-us.gbc").read_bytes()
    out = []
    for ln in (ROOT / "src/assets.txt").read_text(encoding="utf-8").splitlines():
        parts = ln.split("\t")
        if ln.startswith("#") or len(parts) != 3 or parts[0].endswith(".lz"):
            continue
        off, n = int(parts[1].lstrip("$"), 16), int(parts[2].lstrip("$"), 16)
        bank = off // 0x4000
        hits = sum(1 for k in range(off, off + n - 1) if is_label_at(at, bank, rom[k] | rom[k + 1] << 8))
        out.append((bank, parts[0], n, hits))
    return out


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--sym", type=Path)
    ap.add_argument("--src", type=Path, default=ROOT / "src")
    ap.add_argument("--json", type=Path)
    ap.add_argument("--examples", type=int, default=3)
    args = ap.parse_args(argv)
    names, at = load_sym(args.sym or newest_sym())
    found = scan(args.src, names, at)
    raw = incbin_raw(at) if (ROOT / "local/roms/dwm2-cobi-us.gbc").is_file() else []
    summary = {k: {"count": len(v), "banks": len({r[0] for r in v})} for k, v in sorted(found.items())}
    summary["incbin_raw"] = {"count": len(raw), "bytes": sum(r[2] for r in raw),
                             "with_label_words": sum(1 for r in raw if r[3])}
    for k, v in sorted(found.items()):
        print(f"{k}: {len(v)} in {len({r[0] for r in v})} banks")
        for b, f, n, t in v[:args.examples]:
            print(f"    {f}:{n} ({b:02X}) {t}")
    r = summary["incbin_raw"]
    print(f"incbin_raw: {r['count']} slices, {r['bytes']} bytes, {r['with_label_words']} holding a word equal to a "
          f"label address of their bank")
    if args.json:
        args.json.write_text(json.dumps({"summary": summary,
                                         "by_bank": {k: dict(collections.Counter(f"{x[0]:02X}" for x in v))
                                                     for k, v in found.items()},
                                         "items": {k: [list(x) for x in v] for k, v in found.items()},
                                         "incbin_raw": [list(x) for x in raw]}, indent=0), encoding="utf-8")
    return 0


if __name__ == "__main__":
    sys.exit(main())
