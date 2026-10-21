#!/usr/bin/env python3
"""Smoke test for a modded ROM: does it still run, and where does it first look different? (H5)

The mod and the reference ROM run side by side on tools/sm83.py from power-on with the same scripted buttons (the
title screen, the opening and, from frame 4000, a walk with A, B and Start presses: tools/shift_test.py's script).
At the end of every frame their video state (VRAM, OAM, palettes, LCD registers) is compared. The report gives:
- a crash: the frame and the routine (from the mod's .sym) where the mod hit an invalid opcode;
- running data (with --src): the first instruction fetched from inside a data label of the mod's tree, the mark of a
  pointer or jump that leads into data (the reference fetches none in 6,000 frames);
- progress: the game modes it goes through (wGameMode: the opening and title, the field, menus, battles) must be
  the original's, in the same order;
- a stall: a mod whose screen stops changing for `--stall` frames while the reference's still changes;
- the first frame from which the screens differ, and how many frames differ.
A mod that changes what is shown is expected to differ; the frame says where. With `--recipe`
it also replays a tools/play.py recipe chain on the mod and lists the runs that crash; with `--compare` too, it
replays the chain on both ROMs and lists the runs whose screens differ at some VBlank (E-0421).

    python -I tools/mod_check.py ROM [--sym SYM] [--frames 6000] [--recipe FILE [--compare]] [--json OUT]
    python -I tools/mod_check.py --src DIR [...]        build that tree (tools/build.py --src) and check it

Exit 0 when the mod neither crashes, runs data, loses the original's progress nor stalls (differences in what is
shown are reported, not failed), 1 otherwise. An
observation of the project's own emulator, not hardware.
"""
from __future__ import annotations

import argparse
import json
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import shift_test  # noqa: E402
from sm83 import GameBoy  # noqa: E402

REF = ROOT / "local/roms/dwm2-cobi-us.gbc"
FRAME = 70224
W_GAME_MODE = 0xC5DB  # wGameMode (src/ram.asm): 5 opening and title, 1 field, 2 pause menu, 4 battle, 0 debug menu


def label_at(sym: dict[str, tuple[int, int]], bank: int, pc: int) -> str:
    if not sym:
        return f"{bank:02X}:{pc:04X}"
    return shift_test.label_of(sym, bank if pc >= 0x4000 else 0, pc)


def data_map(src: Path, sym: dict[str, tuple[int, int]], size: int) -> bytearray:
    """One flag per ROM byte: 1 inside a data label of the tree (its first line is db, dw, INCBIN, ...; the range
    runs to the next label of the .sym in that bank). An instruction fetched from such a byte is code running data."""
    import bisect
    import doc_coverage
    import source_tree
    data = {name for f in source_tree.bank_files(src) for name, kind, *_ in doc_coverage.scan(f) if kind == "data"}
    by_bank: dict[int, list[int]] = {}
    for _n, (b, a) in sym.items():
        by_bank.setdefault(b, []).append(a)
    for b in by_bank:
        by_bank[b] = sorted(set(by_bank[b]))
    flags = bytearray(size)
    for name in data:
        if name not in sym:
            continue
        b, a = sym[name]
        addrs = by_bank[b]
        k = bisect.bisect_right(addrs, a)
        end = addrs[k] if k < len(addrs) else (0x4000 if a < 0x4000 else 0x8000)
        base = a if a < 0x4000 else b * 0x4000 + a - 0x4000
        flags[base:base + (end - a)] = bytes([1]) * (end - a)
    return flags


def run(rom: bytes, frames: int, data: bytearray | None = None) -> dict:
    """Video-state hashes per frame; the crash (frame, bank, pc) if the run stopped on an invalid opcode; with a
    data map, the first instruction fetched from data."""
    shift_test.EXPLORE = True
    gb = GameBoy(rom)
    hashes, crash, ran_data, modes = [], None, None, []
    while len(hashes) < frames:
        frame = gb.cycles // FRAME
        gb.joy = shift_test.buttons(frame)
        try:
            gb.run(1)
        except RuntimeError as e:
            crash = {"frame": frame, "bank": gb.rombank, "pc": gb.pc, "error": str(e)}
            break
        if data is not None and ran_data is None and gb.pc < 0x8000:
            at = gb.pc if gb.pc < 0x4000 else gb.rombank * 0x4000 + gb.pc - 0x4000
            if at < len(data) and data[at]:
                ran_data = {"frame": frame, "bank": gb.rombank if gb.pc >= 0x4000 else 0, "pc": gb.pc}
        if gb.cycles // FRAME > frame:
            hashes.append(shift_test.video_state(gb))
            m = gb.rb(W_GAME_MODE)
            if not modes or modes[-1][0] != m:
                modes.append((m, len(hashes)))
    return {"hashes": hashes, "crash": crash, "ran_data": ran_data, "modes": modes}


def stall(a: list[str], b: list[str], window: int) -> int | None:
    """The first frame from which `a` stays the same for `window` frames while `b` changes in that time."""
    same = 0
    for i in range(1, min(len(a), len(b))):
        same = same + 1 if a[i] == a[i - 1] else 0
        if same >= window and len(set(b[i - window:i + 1])) > 1:
            return i - window
    return None


def progress(ref: list[tuple[int, int]], mod: list[tuple[int, int]], frames: int) -> dict | None:
    """None when the mod goes through the original's game modes in the same order (a tail the original reached in
    the last tenth of the run may be missing: timing); else both sequences, each mode with its first frame."""
    a, b = [m for m, _f in ref], [m for m, _f in mod]
    if a == b:
        return None
    if len(b) < len(a) and a[:len(b)] == b and ref[len(b)][1] >= 0.9 * frames:
        return None
    return {"original": ref, "mod": mod}


def check(mod: bytes, sym: dict, frames: int, window: int = 600, ref: bytes | None = None,
          data: bytearray | None = None) -> dict:
    """`data`: the mod's data map (data_map), to catch code running data."""
    ref = ref if ref is not None else REF.read_bytes()
    r, m = run(ref, frames), run(mod, frames, data)
    first = shift_test.first_difference(r["hashes"], m["hashes"])
    crash = m["crash"]
    if crash:
        crash["routine"] = label_at(sym, crash["bank"], crash["pc"])
    ran = m["ran_data"]
    if ran:
        ran["label"] = label_at(sym, ran["bank"], ran["pc"])
    return {"frames": len(m["hashes"]), "reference_frames": len(r["hashes"]), "crash": crash, "ran_data": ran,
            "progress": progress(r["modes"], m["modes"], frames),
            "stall": stall(m["hashes"], r["hashes"], window), "first_difference": first,
            "differing_frames": shift_test.transient_frames(r["hashes"], m["hashes"]) +
            abs(len(r["hashes"]) - len(m["hashes"])), "identical": r["hashes"] == m["hashes"]}


def recipe_crashes(mod: bytes, recipe: str, sym: dict | None = None) -> list[str]:
    """Runs of a recipe chain that raise on the mod (an invalid opcode or a recipe step that cannot be done)."""
    import play
    labels = {(b, a): n for n, (b, a) in (sym or {}).items() if "." not in n} or None
    bad = []
    try:
        play.replay(recipe, set(), rom=mod, labels=labels)
    except Exception as e:  # noqa: BLE001 - every failure is reported
        bad.append(f"{type(e).__name__}: {e}")
    return bad


def recipe_frames(path: str, rom: bytes, sym: dict, hooks: dict | None = None) -> dict[str, list[str]]:
    """E-0421: replay a recipe chain on a ROM (`call:` steps by the names in its .sym) and return each run's video
    state at every VBlank interrupt (the entry at $0040). `hooks` (address -> callable(gb)) are set during the runs
    and taken off before a state is kept, so the states pickle."""
    import pickle
    import re
    import play
    labels = {(b, a): n for n, (b, a) in sym.items() if "." not in n}
    by_name = {v: k for k, v in labels.items()}
    ram = dict(re.findall(r"^DEF (\w+) EQU \$([0-9A-F]{4})", (ROOT / "src/ram.asm").read_text(encoding="utf-8"), re.M))
    states: dict[str, bytes] = {}
    out: dict[str, list[str]] = {}
    for ln in play.recipe_lines(path):
        state, old, pokes, recipe = (x.strip() for x in ln.split("|"))
        if old.startswith("sram:"):
            gb = GameBoy(rom)
            gb.sram[:] = pickle.loads(states[old[5:]]).sram
        else:
            gb = pickle.loads(states[old]) if old else GameBoy(rom)
        for p in pokes.split():
            if p.startswith("call:"):
                play.call_at_halt(gb, *by_name[p[5:]])
            else:
                play.poke(gb, ram, p, by_name)
        frames: list[str] = []
        gb.pc_hooks = dict(hooks or {})
        gb.pc_hooks[0x0040] = lambda g: frames.append(shift_test.video_state(g))
        play.run(gb, play.parse(recipe), {}, {})
        gb.pc_hooks = {}
        states[state] = pickle.dumps(gb)
        out[state] = frames
    return out


def recipe_compare(path: str, ref: bytes, ref_sym: dict, mod: bytes, mod_sym: dict,
                   hooks: dict | None = None, ref_hooks: dict | None = None) -> dict:
    """E-0421: a recipe chain on the reference and on a mod, VBlank by VBlank: {"runs", "frames", "differ": [state,
    first differing VBlank, differing VBlanks, of how many, same last screen]} (`hooks` on the mod's runs,
    `ref_hooks` on the reference's)."""
    a = recipe_frames(path, ref, ref_sym, ref_hooks)
    b = recipe_frames(path, mod, mod_sym, hooks)
    differ = []
    for state, fa in a.items():
        fb = b.get(state, [])
        d = [i for i, (x, y) in enumerate(zip(fa, fb)) if x != y]
        if d or len(fa) != len(fb):
            differ.append([state, d[0] if d else min(len(fa), len(fb)), len(d) + abs(len(fa) - len(fb)), len(fa),
                           bool(fa and fb and fa[-1] == fb[-1])])
    return {"runs": len(a), "frames": sum(len(f) for f in a.values()), "differ": differ}


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("rom", nargs="?", type=Path)
    ap.add_argument("--src", type=Path, help="build this tree first")
    ap.add_argument("--sym", type=Path)
    ap.add_argument("--frames", type=int, default=6000)
    ap.add_argument("--stall", type=int, default=600)
    ap.add_argument("--recipe")
    ap.add_argument("--compare", action="store_true", help="with --recipe: compare the chain's screens with the original's")
    ap.add_argument("--json", type=Path)
    a = ap.parse_args(argv)
    if a.src:
        out = "build/mod_check"
        p = subprocess.run([sys.executable, "-I", str(ROOT / "tools/build.py"), "--out", out, "--src", str(a.src)],
                           cwd=ROOT, capture_output=True, text=True)
        if p.returncode:
            print(p.stdout + p.stderr)
            print("the mod does not build")
            return 1
        a.rom, a.sym = ROOT / out / "dwm2.gbc", ROOT / out / "dwm2.sym"
    if a.rom is None:
        ap.error("give a ROM or --src")
    sym = shift_test.read_sym(a.sym) if a.sym and a.sym.exists() else {}
    rom = a.rom.read_bytes()
    data = data_map(a.src, sym, len(rom)) if a.src and sym else None  # needs the tree the ROM was built from
    res = check(rom, sym, a.frames, a.stall, data=data)
    if a.recipe:
        res["recipe_crashes"] = recipe_crashes(a.rom.read_bytes(), a.recipe, sym)
        if a.compare and not res["recipe_crashes"]:
            ref_sym = shift_test.read_sym(sorted(ROOT.glob("build/run*/dwm2.sym"), key=lambda q: q.stat().st_mtime)[-1])
            res["recipe_compare"] = recipe_compare(a.recipe, REF.read_bytes(), ref_sym, rom, sym)
    if res["crash"]:
        c = res["crash"]
        print(f"CRASH at frame {c['frame']}: {c['routine']} ({c['bank']:02X}:{c['pc']:04X}): {c['error']}")
    if res["ran_data"]:
        r = res["ran_data"]
        print(f"RAN DATA at frame {r['frame']}: an instruction fetched from {r['label']} ({r['bank']:02X}:{r['pc']:04X}), "
              f"a data label: a pointer or jump leads into data")
    if res["progress"]:
        show = lambda seq: " -> ".join(f"mode {m} (frame {f})" for m, f in seq)  # noqa: E731
        print(f"PROGRESS differs: the original goes {show(res['progress']['original'])}; the mod goes "
              f"{show(res['progress']['mod'])}")
    if res["stall"] is not None:
        print(f"STALL from frame {res['stall']}: the screen stops changing while the original's does not")
    if res["identical"]:
        print(f"same screens as the original for all {res['frames']} frames")
    elif res["first_difference"] is not None:
        print(f"screens differ from frame {res['first_difference']} ({res['differing_frames']} of "
              f"{res['reference_frames']} frames differ): expected where the mod changes what is shown")
    for b in res.get("recipe_crashes", []):
        print(f"recipe: {b}")
    if "recipe_compare" in res:
        rc = res["recipe_compare"]
        print(f"recipe: {rc['runs']} runs, {rc['frames']} frames compared; "
              + ("same screens as the original" if not rc["differ"] else f"{len(rc['differ'])} runs differ"))
        for state, k, nd, n, same_end in rc["differ"][:10]:
            print(f"    {state}: {nd} of {n} VBlanks differ, from VBlank {k}; "
                  + ("same last screen" if same_end else "a different last screen"))
    if a.json:
        a.json.write_text(json.dumps(res, indent=1), encoding="utf-8")
    bad = res["crash"] or res["ran_data"] or res["progress"] or res["stall"] is not None or res.get("recipe_crashes")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
