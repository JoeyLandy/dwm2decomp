#!/usr/bin/env python3
"""Find runs of back-to-back compressed streams in the ROM and merge them into config/stream_chains.json.

  find_stream_chains.py FIRST_BANK LAST_BANK     (hex, inclusive; about 4 seconds per bank)

A stream is the game's compressed-asset format (tools/lzss_gfx.py) that decodes without reading
unwritten output. A chain is six or more streams (chains of 3-4 also appear in table data such as the monster table) where each starts exactly where the previous one
ends. That is far more than random bytes give and is how the game's asset packs look (E-0016, E-0035).
The decoder is the only evidence: an OBSERVATION (C1). tools/disasm_all.py re-checks every stream
before it uses it."""
from __future__ import annotations

import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
from lzss_gfx import decompress  # noqa: E402

OUT = ROOT / "config/stream_chains.json"
BANK = 0x4000


def parse(data: bytes, bank: int, addr: int):
    fo = bank * BANK + addr - BANK
    size = data[fo] | (data[fo + 1] << 8)
    if not 32 <= size <= BANK:
        return None
    try:
        out, used, ev = decompress(data, bank, addr)
    except IndexError:
        return None
    if ev["unwritten_reads"] or addr - BANK + used > BANK or used < 24 or len(set(out)) < 6:
        return None  # runs of one byte and tiny inputs decode "validly" almost anywhere
    return len(out), used


def chains_in_bank(data: bytes, bank: int, min_len: int = 6):
    starts = {}
    for addr in range(BANK, 2 * BANK - 3):
        p = parse(data, bank, addr)
        if p:
            starts[addr] = p
    covered, found = set(), []
    for addr in sorted(starts):
        if addr in covered:
            continue
        run, x = [], addr
        while x in starts:
            run.append(x)
            x += starts[x][1]
        if len(run) >= min_len:
            found.append((run[0], len(run)))
            covered.update(range(addr, x))
    return found


def main(argv: list[str]) -> int:
    first, last = int(argv[0], 16), int(argv[1], 16)
    data = (ROOT / "local/roms/dwm2-cobi-us.gbc").read_bytes()
    result = json.loads(OUT.read_text()) if OUT.exists() else {"_comment": __doc__.split("\n")[0], "chains": {}}
    for bank in range(max(first, 1), last + 1):
        if not any(data[bank * BANK:(bank + 1) * BANK]):
            continue
        found = chains_in_bank(data, bank)
        result["chains"][f"{bank:02X}"] = [[f"{a:04X}", n] for a, n in found]
        print(f"{bank:02X}: {len(found)} chains, {sum(n for _, n in found)} streams", flush=True)
        OUT.write_text(json.dumps(result, indent=1) + "\n", encoding="utf-8")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
