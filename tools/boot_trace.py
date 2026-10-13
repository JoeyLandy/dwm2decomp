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
import gb_text  # noqa: E402
import screen  # noqa: E402

wGameMode = 0xC5DB
wStringCategory, wStringIndex = 0xC528, 0xC529
LOOKUP_STRING_RET = 0x2E5C  # the `ret` of LookupString: DE = the string pointer in the current ROM bank
MESSAGE_ROUTINE = re.compile(r"(TalkMsg|TalkScript|Msg|ShowString|ShowMessage)")


def load_labels():
    """(bank, addr) -> name from the build's .sym file (the newest build directory)."""
    syms = sorted(ROOT.glob("build/run*/dwm2.sym"), key=lambda p: p.stat().st_mtime)
    out = {}
    for ln in syms[-1].read_text(encoding="utf-8").split("\n"):
        m = re.match(r"([0-9a-f]{2,3}):([0-9a-f]{4}) (\S+)", ln)
        if m and "." not in m.group(3) and not re.match(r"(Func|Jump|Data)_", m.group(3)):
            out.setdefault((int(m.group(1), 16), int(m.group(2), 16)), m.group(3))
    return out


def main(instructions: int = 3_000_000, explore: bool = False, shot_frames=()) -> None:
    gb = GameBoy((ROOT / "local/roms/dwm2-cobi-us.gbc").read_bytes())
    labels = load_labels()
    entry_at = {k for k in labels}
    seen: dict[tuple[int, int], tuple[int, int]] = {}  # (bank, addr) -> (wGameMode, frame) at first run
    events: list[list] = []  # message routines entered and the strings LookupString found, in order
    shots: dict[int, str] = {f: "requested" for f in shot_frames}  # frame -> what is pictured then
    (ROOT / "build/shots").mkdir(parents=True, exist_ok=True)
    t0 = time.time()
    n = 0
    while n < instructions:
        # press A for a few frames every ~2 seconds of game time, Start in between
        frame = gb.cycles // 70224
        gb.joy = 0xFF & ~(0x10 if frame % 120 < 4 else 0) & ~(0x80 if 60 <= frame % 120 < 64 else 0)
        if explore and frame >= 4000:  # walk in a square, talk with A, back out with B, open the menu with Start
            f = frame - 4000
            direction = (0x01, 0x08, 0x02, 0x04)[(f // 120) % 4]
            press = direction | (0x10 if f % 30 < 2 else 0) | (0x20 if f % 97 < 2 else 0) | (0x80 if f % 997 < 3 else 0)
            gb.joy = 0xFF & ~press
        pc = gb.pc
        key = (gb.rombank if pc >= 0x4000 else 0, pc) if pc < 0x8000 else None
        if key in entry_at and key not in seen:
            seen[key] = (gb.rb(wGameMode), frame)
        if key in entry_at and len(events) < 4000 and MESSAGE_ROUTINE.match(labels[key]):
            events.append(["enter", frame, labels[key]])
            if labels[key].startswith("TalkMsg") and len(shots) < 12 and labels[key] not in shots.values():
                for d in (20, 45, 90):
                    shots[frame + d] = labels[key]
        elif key == (0, LOOKUP_STRING_RET) and len(events) < 4000:
            p, raw = gb.d << 8 | gb.e, []
            while len(raw) < 80 and gb.rb(p) != 0xF0:
                raw.append(gb.rb(p))
                p += 1
            events.append(["string", frame, gb.rombank, gb.d << 8 | gb.e, gb.rb(wStringCategory),
                           gb.rb(wStringIndex), "".join(gb_text.BYTE_TO_TEXT.get(b, " ") for b in raw)])
        if gb.ly == 144:  # picture the screen once vblank begins on a frame chosen above
            for k in [k for k in shots if k <= frame]:
                screen.save_png(gb, ROOT / f"build/shots/f{frame:06d}_{shots.pop(k)}.png")
        if gb.halted:
            gb.tick(456 - gb.line_cycles if gb.io[0x40] & 0x80 else 456)
        else:
            gb.tick(gb.step())
        gb.service()
        n += 1
    dt = time.time() - t0
    named = {labels[k]: m for k, (m, _f) in seen.items()}
    by_mode: dict[int, list[str]] = {}
    for name, mode in named.items():
        by_mode.setdefault(mode, []).append(name)
    print(f"{n} instructions in {dt:.0f}s, {gb.cycles // 70224} frames; {len(named)} named routines executed")
    for mode in sorted(by_mode):
        print(f"  wGameMode {mode}: {len(by_mode[mode])} routines, e.g. {', '.join(sorted(by_mode[mode])[:12])}")
    (ROOT / "build/boot_trace.json").write_text(json.dumps(
        {"instructions": n, "frames": gb.cycles // 70224, "executed": {f"{b:02X}:{a:04X}": [labels[(b, a)], m, f]
                                                                        for (b, a), (m, f) in sorted(seen.items())},
         "events": events},
        indent=1), encoding="utf-8")


if __name__ == "__main__":
    main(int(sys.argv[1]) if len(sys.argv) > 1 else 3_000_000, '--explore' in sys.argv,
         [int(a.split('=')[1]) for a in sys.argv if a.startswith('--shot=')])
