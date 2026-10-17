#!/usr/bin/env python3
"""Two linked copies of the reference ROM in tools/sm83.py, played by input recipes (E-0406).

Both consoles share one cable (tools/sm83.py's serial model) and run in cycle lockstep: the one behind steps next.
Each side plays its own recipe in tools/play.py's step syntax (`W60`, `A`, `D2`, `A*4` ...).

A link recipe file has one run per line, `STATE | FROM | RECIPE_A | RECIPE_B`, with `#` comments. FROM is empty
(power on both with blank cartridge RAM), `sram:STATE` (power on both with the cartridge RAM of a tools/play.py
state, which `--sram-recipe` replays first) or an earlier link STATE. States stay in memory; `--shots DIR` saves
both screens of every run (DIR under build/).

    python -I tools/link_play.py tools/recipes/link_e0404.txt --sram-recipe tools/recipes/e0323_save.txt --shots build/link

Observations of the project's own emulator (serial timing is a model), not hardware.
"""
from __future__ import annotations

import argparse
import pickle
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import boot_trace  # noqa: E402
import play  # noqa: E402
from sm83 import GameBoy  # noqa: E402

FRAME = play.FRAME


def schedule(segments: list[tuple[int, int]]) -> list[tuple[int, int]]:
    """(mask, frames) segments as (end frame offset, mask)."""
    out, f = [], 0
    for mask, frames in segments:
        f += frames
        out.append((f, mask))
    return out


def step(gb: GameBoy) -> None:
    if gb.halted:
        gb.tick(456 - gb.line_cycles if gb.io[0x40] & 0x80 else 456)
    else:
        gb.tick(gb.step())
    gb.service()


def run_pair(a: GameBoy, b: GameBoy, rec_a: str, rec_b: str, labels: dict | None = None,
             seen: dict | None = None, hooks=None) -> None:
    """Play both recipes, the console that is behind in cycles stepping next. labels/seen as tools/play.run, for
    console A; hooks (callable(gb, side) before each step) for observation."""
    a.link, b.link = b, a
    plans = []
    for gb, rec in ((a, rec_a), (b, rec_b)):
        plans.append([gb.cycles // FRAME, schedule(play.parse(rec)), 0])
    # both end on the same frame, so neither starts the next run ahead and plays alone while the other catches up
    end = max(start + (sch[-1][0] if sch else 0) for start, sch, _i in plans)
    for plan in plans:
        start, sch, _i = plan
        if not sch or start + sch[-1][0] < end:
            sch.append((end - start, 0))
    entry_at = set(labels or {})
    while True:
        live = [k for k in (0, 1) if plans[k][2] < len(plans[k][1])]
        if not live:
            break
        k = min(live, key=lambda j: (a, b)[j].cycles)
        gb, plan = (a, b)[k], plans[k]
        start, sch, i = plan
        f = gb.cycles // FRAME - start
        while i < len(sch) and f >= sch[i][0]:
            i += 1
        plan[2] = i
        if i >= len(sch):
            continue
        gb.joy = 0xFF & ~sch[i][1]
        if k == 0 and seen is not None:
            pc = gb.pc
            key = (gb.rombank if pc >= 0x4000 else 0, pc) if pc < 0x8000 else None
            if key in entry_at:
                seen.setdefault(key, set()).add(gb.rb(boot_trace.wGameMode))
        if hooks:
            hooks(gb, k)
        step(gb)


def lines_of(path: Path) -> list[list[str]]:
    return [[x.strip() for x in ln.split("|")] for ln in path.read_text(encoding="utf-8").splitlines()
            if ln.strip() and not ln.startswith("#")]


def replay(path: Path, sram_states: dict[str, bytes], rom: bytes | None = None, shots: Path | None = None,
           on_run=None) -> dict[str, tuple[bytes, bytes]]:
    """Replay a link recipe file; returns {state: (pickled A, pickled B)}. on_run(state, a, b) after each run."""
    rom = rom or (ROOT / "local/roms/dwm2-cobi-us.gbc").read_bytes()
    states: dict[str, tuple[bytes, bytes]] = {}
    for state, old, rec_a, rec_b in lines_of(path):
        if old.startswith("sram:"):
            pair = []
            for _ in range(2):
                gb = GameBoy(rom)
                gb.sram[:] = sram_states[old[5:]]
                pair.append(gb)
            a, b = pair
        elif old:
            a, b = (pickle.loads(x) for x in states[old])
            a.rom = b.rom = rom
        else:
            a, b = GameBoy(rom), GameBoy(rom)
        if on_run is None:
            run_pair(a, b, rec_a, rec_b)
        else:
            on_run(state, a, b, rec_a, rec_b)
        if shots:
            import screen
            shots.mkdir(parents=True, exist_ok=True)
            screen.save_png(a, shots / f"{state.strip('!')}_A.png")
            screen.save_png(b, shots / f"{state.strip('!')}_B.png")
        a.link = b.link = None
        ra, rb_ = a.rom, b.rom
        a.rom = b.rom = b""
        states[state] = (pickle.dumps(a), pickle.dumps(b))
        a.rom, b.rom = ra, rb_
        print(f"{state}: frame {a.cycles // FRAME}/{b.cycles // FRAME}, wGameMode {a.rb(boot_trace.wGameMode)}/"
              f"{b.rb(boot_trace.wGameMode)}")
    return states


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("recipe", type=Path)
    ap.add_argument("--sram-recipe", type=Path, help="tools/play.py recipe whose states give cartridge RAM")
    ap.add_argument("--shots", type=Path)
    args = ap.parse_args(argv)
    if args.shots and (ROOT / "build").resolve() not in args.shots.resolve().parents:
        sys.exit("--shots must be under build/")
    need = {old[5:] for _s, old, _a, _b in lines_of(args.recipe) if old.startswith("sram:")}
    srams = {}
    if need:
        if not args.sram_recipe:
            sys.exit("the recipe powers on from a play state: give --sram-recipe")
        kept, _ran = play.replay(str(args.sram_recipe), need, stop_when_kept=True)
        srams = {k: bytes(gb.sram) for k, gb in kept.items()}
    replay(args.recipe, srams, shots=args.shots)
    return 0


if __name__ == "__main__":
    sys.exit(main())
