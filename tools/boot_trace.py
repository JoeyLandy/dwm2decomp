"""Run the reference ROM from power-on in tools/sm83.py with scripted button presses and record which code runs
(E-0318). Prints the named routines that executed, by the wGameMode value they first ran in, and writes the
executed (bank, address) set to build/boot_trace.json. An observation of our own emulator (not hardware)."""
import json
import re
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
from sm83 import GameBoy  # noqa: E402

wGameMode = 0xC5DB


def load_labels():
    """(bank, addr) -> name from the build's .sym file (the newest build directory)."""
    syms = sorted(ROOT.glob("build/run*/dwm2.sym"), key=lambda p: p.stat().st_mtime)
    out = {}
    for ln in syms[-1].read_text(encoding="utf-8").split("\n"):
        m = re.match(r"([0-9a-f]{2,3}):([0-9a-f]{4}) (\S+)", ln)
        if m and "." not in m.group(3) and not re.match(r"(Func|Jump|Data)_", m.group(3)):
            out.setdefault((int(m.group(1), 16), int(m.group(2), 16)), m.group(3))
    return out


def main(instructions: int = 3_000_000) -> None:
    gb = GameBoy((ROOT / "local/roms/dwm2-cobi-us.gbc").read_bytes())
    labels = load_labels()
    entry_at = {k for k in labels}
    seen: dict[tuple[int, int], int] = {}
    t0 = time.time()
    n = 0
    while n < instructions:
        # press A for a few frames every ~2 seconds of game time, Start in between
        frame = gb.cycles // 70224
        gb.joy = 0xFF & ~(0x10 if frame % 120 < 4 else 0) & ~(0x80 if 60 <= frame % 120 < 64 else 0)
        pc = gb.pc
        key = (gb.rombank if pc >= 0x4000 else 0, pc) if pc < 0x8000 else None
        if key in entry_at and key not in seen:
            seen[key] = gb.rb(wGameMode)
        if gb.halted:
            gb.tick(456 - gb.line_cycles if gb.io[0x40] & 0x80 else 456)
        else:
            gb.tick(gb.step())
        gb.service()
        n += 1
    dt = time.time() - t0
    named = {labels[k]: m for k, m in seen.items()}
    by_mode: dict[int, list[str]] = {}
    for name, mode in named.items():
        by_mode.setdefault(mode, []).append(name)
    print(f"{n} instructions in {dt:.0f}s, {gb.cycles // 70224} frames; {len(named)} named routines executed")
    for mode in sorted(by_mode):
        print(f"  wGameMode {mode}: {len(by_mode[mode])} routines, e.g. {', '.join(sorted(by_mode[mode])[:12])}")
    (ROOT / "build/boot_trace.json").write_text(json.dumps(
        {"instructions": n, "frames": gb.cycles // 70224, "executed": {f"{b:02X}:{a:04X}": [labels[(b, a)], m]
                                                                        for (b, a), m in sorted(seen.items())}},
        indent=1), encoding="utf-8")


if __name__ == "__main__":
    main(int(sys.argv[1]) if len(sys.argv) > 1 else 3_000_000)
