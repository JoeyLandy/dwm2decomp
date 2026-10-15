"""Run routine probes: one routine of the reference ROM, from a chosen state, on tools/sm83.py (D-012).

A probe file is a JSON list of probes. Each probe:

    {"id": "Multiply8By16#1", "label": "Multiply8By16", "bank": "00", "address": "16AA",
     "regs": {"a": 3, "b": 1, "c": 2},                    registers a b c d e h l (and sp is set by the runner)
     "flags": {"z": false, "c": true},                    optional starting flags
     "mem": {"C0A0": 5, "D7FE": [1, 2, 3]},               bytes written before the call (WRAM/HRAM/IO through the bus)
     "wram_bank": 2,                                      optional rSVBK value for $D000-$DFFF
     "sram": {"1:A000": [0, 1]},                          optional save RAM bytes, "BANK:ADDR"
     "expect": {"regs": {"e": 0, "h": 0, "l": 6}, "flags": {"z": false},
                "mem": {"C0A0": 6}, "sram": {"1:A000": [0, 1]}},
     "claim": "the part of the note this checks"}

Values are integers or "0x.." / "$.." strings. The runner pushes a sentinel return address, runs until the routine
returns to it (at most `max_steps` instructions, default 2,000,000) and compares. A probe passes when it returns and
every expected value matches. The ROM is read from local/roms/; nothing is written.

    python -I -B tools/probe.py PROBES.json [PROBES.json ...] [--id ID]
"""
import argparse
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
from sm83 import GameBoy  # noqa: E402

ROM = ROOT / "local/roms/dwm2-cobi-us.gbc"
RETURN = 0xC800  # the sentinel return address (in WRAM; never executed)
FLAG_BITS = {"z": 0x80, "n": 0x40, "h": 0x20, "c": 0x10}


class Returned(Exception):
    pass


def num(v) -> int:
    if isinstance(v, int):
        return v
    s = str(v).strip().lower().replace("$", "0x")
    return int(s, 16) if s.startswith("0x") else int(s)


def _bytes(v) -> list[int]:
    return [num(x) for x in v] if isinstance(v, list) else [num(v)]


def _sram_index(key: str) -> int:
    bank, addr = key.split(":")
    return num("0x" + bank) * 0x2000 + num("0x" + addr) - 0xA000


def run(probe: dict, rom: bytes) -> list[str]:
    """Mismatches of one probe (empty when it passes)."""
    gb = GameBoy(rom)
    bank = num("0x" + str(probe["bank"]))
    gb.rombank = bank if bank else 1
    if "wram_bank" in probe:
        gb.wb(0xFF70, num(probe["wram_bank"]))
    if probe.get("sram"):
        gb.ramen = True
        for k, v in probe["sram"].items():
            for i, b in enumerate(_bytes(v)):
                gb.sram[_sram_index(k) + i] = b
    for k, v in (probe.get("mem") or {}).items():
        for i, b in enumerate(_bytes(v)):
            gb.wb(num("0x" + k) + i, b)
    for r, v in (probe.get("regs") or {}).items():
        setattr(gb, r, num(v))
    f = 0
    for k, v in (probe.get("flags") or {}).items():
        f |= FLAG_BITS[k] if v else 0
    if probe.get("flags"):
        gb.f = f
    gb.sp = 0xDFF0
    gb.wb(gb.sp, RETURN & 0xFF)
    gb.wb(gb.sp + 1, RETURN >> 8)
    gb.pc = num("0x" + str(probe["address"]))

    def stop(_):
        raise Returned

    gb.pc_hooks[RETURN] = stop
    try:
        gb.run(int(probe.get("max_steps", 2_000_000)))
    except Returned:
        pass
    else:
        return ["did not return"]
    bad = []
    exp = probe.get("expect") or {}
    for r, v in (exp.get("regs") or {}).items():
        got = getattr(gb, r)
        if got != num(v):
            bad.append(f"{r} = ${got:02X}, expected ${num(v):02X}")
    for k, v in (exp.get("flags") or {}).items():
        got = bool(gb.f & FLAG_BITS[k])
        if got != bool(v):
            bad.append(f"flag {k} = {int(got)}, expected {int(bool(v))}")
    for k, v in (exp.get("mem") or {}).items():
        want = _bytes(v)
        got = [gb.rb(num("0x" + k) + i) for i in range(len(want))]
        if got != want:
            bad.append(f"[{k}] = {' '.join(f'{x:02X}' for x in got)}, expected {' '.join(f'{x:02X}' for x in want)}")
    for k, v in (exp.get("sram") or {}).items():
        want = _bytes(v)
        got = list(gb.sram[_sram_index(k):_sram_index(k) + len(want)])
        if got != want:
            bad.append(f"sram {k} = {got}, expected {want}")
    return bad


def load(paths) -> list[dict]:
    out = []
    for p in paths:
        out.extend(json.loads(Path(p).read_text(encoding="utf-8")))
    return out


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("files", nargs="+", type=Path)
    ap.add_argument("--id")
    args = ap.parse_args()
    rom = ROM.read_bytes()
    probes = [p for p in load(args.files) if not args.id or p.get("id") == args.id]
    failed = 0
    for p in probes:
        bad = run(p, rom)
        failed += bool(bad)
        print(f"{'PASS' if not bad else 'FAIL'} {p.get('id', p.get('label'))}" + (": " + "; ".join(bad) if bad else ""))
    print(f"{len(probes) - failed} of {len(probes)} probes pass")
    return 1 if failed else 0


if __name__ == "__main__":
    sys.exit(main())
