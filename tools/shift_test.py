#!/usr/bin/env python3
"""M1 shift test (E-0388): does the source survive moving code and data?

A scratch copy of src/ is assembled twice under the output directory (default build/shift/): once unchanged
("base") and once with N bytes of `ds N, $00` (N `nop`s) inserted before the first label of each chosen bank past
its fixed start ($0150 in bank $00, after the bank-number byte at $4000 in the others), with the bank's last `ds`
fill shortened by N so the bank keeps its size. Labels after the insertion point move by N; a value written as a
number instead of a label expression does not follow them. Neither output is the matching target, and neither is
verified against the reference: the matching build stays tools/build.py.

Both ROMs then run in tools/sm83.py from power-on with the same scripted buttons, and at the end of every frame
the video state (both VRAM banks, OAM, CGB palette RAM and LCDC/scroll/window registers) is compared. Moving code
does not change instruction timing on this CPU, so a ROM that still works shows the same screen frame for frame;
the first differing frame is where a hard-coded reference took effect. An observation of the project's own
emulator, not hardware (C2 at best).

`--reads` compares ROM data reads instead of frames (E-0389); with `--recipe FILE` it replays a tools/play.py recipe
chain on both ROMs and compares each reading instruction's own stream of reads, which interrupt timing and
time-budgeted loops do not reorder (E-0401).

Usage: shift_test.py [--pad 1] [--banks all | 00,02,...] [--frames 3000] [--out build/shift]
       shift_test.py --pad 16 --reads all --recipe tools/recipes/e0335_swap.txt [--until STATE]
Exit 0 when the padded build assembles and its frames (or reads) match the base build; 1 otherwise.
"""
from __future__ import annotations

import argparse
import hashlib
import json
import re
import shutil
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
RGBDS = ROOT / "tools/rgbds"
LABEL = re.compile(r"^([A-Za-z_]\w*)::")
DS = re.compile(r"^(\s*)(ds|DS) (\$[0-9A-Fa-f]+|\d+)(\s*,\s*[^;]*)?(\s*;.*)?$")
SECTION = re.compile(r'^SECTION "Bank ([0-9A-F]{2})"')
MARK = "; shift_test padding"


def bank_files(src: Path) -> dict[int, Path]:
    """Bank number -> its file, from the SECTION line."""
    out = {}
    for p in sorted(src.glob("*/bank*.asm")):
        for ln in p.read_text(encoding="utf-8").split("\n"):
            m = SECTION.match(ln)
            if m:
                out[int(m.group(1), 16)] = p
                break
    return out


def read_sym(path: Path) -> dict[str, tuple[int, int]]:
    """Global label -> (bank, address) from an rgblink .sym file."""
    out = {}
    for ln in path.read_text(encoding="utf-8").split("\n"):
        m = re.match(r"([0-9a-fA-F]{2,3}):([0-9a-fA-F]{4}) (\S+)$", ln)
        if m and "." not in m.group(3):
            out[m.group(3)] = (int(m.group(1), 16), int(m.group(2), 16))
    return out


def pad_bank(text: str, bank: int, sym: dict[str, tuple[int, int]], pad: int) -> tuple[str, str]:
    """Insert `ds pad, $00` before the first label past the bank's fixed start and shorten the last `ds` after it.
    Returns (new text, the label padded before); raises ValueError when the bank has no room."""
    lines = text.split("\n")
    first = 0x0150 if bank == 0 else 0x4001
    cands = [(sym[m.group(1)][1], i, m.group(1)) for i, ln in enumerate(lines)
             for m in [LABEL.match(ln)] if m and sym.get(m.group(1), (None,))[0] == bank
             and sym[m.group(1)][1] >= first]
    if not cands:
        raise ValueError("no label past the bank's fixed start")
    _addr, at, label = min(cands)
    for j in range(len(lines) - 1, at, -1):
        m = DS.match(lines[j])
        if not m:
            continue
        size = int(m.group(3)[1:], 16) if m.group(3).startswith("$") else int(m.group(3))
        if size < pad:
            continue
        rest = size - pad
        lines[j] = (f"{m.group(1)}{m.group(2)} ${rest:X}{m.group(4) or ''}{m.group(5) or ''}" if rest else
                    f"{m.group(1)}; ds removed by shift_test")
        break
    else:
        raise ValueError(f"no `ds` of at least {pad} bytes after {label}")
    lines.insert(at, f"    ds {pad}, $00 {MARK}")
    return "\n".join(lines), label


def assemble(src: Path, out: Path) -> tuple[bytes | None, str]:
    """rgbasm + rgblink of src/main.asm into out/ (no rgbfix, no identity gate). Returns (ROM or None, log)."""
    out.mkdir(parents=True, exist_ok=True)
    import build
    build.extract_assets(out / "assets")
    obj, rom = out / "main.o", out / "dwm2.gbc"
    log = []
    for cmd in ([RGBDS / "rgbasm.exe", "-I", src, "-I", out / "assets", "-I", ROOT / "local/roms", "-o", obj,
                 src / "main.asm"],
                [RGBDS / "rgblink.exe", *(["-l", src / "layout.link"] if (src / "layout.link").exists() else []),
                 "-n", out / "dwm2.sym", "-o", rom, obj]):
        p = subprocess.run([str(c) for c in cmd], cwd=out, capture_output=True, text=True)
        log.append(p.stdout + p.stderr)
        if p.returncode:
            return None, "\n".join(log)
    return rom.read_bytes(), "\n".join(log)


EXPLORE = False  # --explore: from frame 4000 walk, talk and open menus (tools/boot_trace.py --explore)


def buttons(frame: int) -> int:
    """The scripted joypad of tools/boot_trace.py: A for 4 frames every 120, Start 60 frames later; with EXPLORE,
    from frame 4000 a walk in a square with A, B and Start presses."""
    if EXPLORE and frame >= 4000:
        f = frame - 4000
        direction = (0x01, 0x08, 0x02, 0x04)[(f // 120) % 4]
        return 0xFF & ~(direction | (0x10 if f % 30 < 2 else 0) | (0x20 if f % 97 < 2 else 0)
                        | (0x80 if f % 997 < 3 else 0))
    return 0xFF & ~(0x10 if frame % 120 < 4 else 0) & ~(0x80 if 60 <= frame % 120 < 64 else 0)


def video_state(gb) -> str:
    h = hashlib.sha1()
    for part in (gb.vram[0], gb.vram[1], gb.oam, gb.bgpal, gb.objpal, bytes(gb.io[0x40:0x4C])):
        h.update(bytes(part))
    return h.hexdigest()


def frame_hashes(rom: bytes, frames: int) -> list[str]:
    """Run from power-on for `frames` frames; the video-state hash at the end of each. A run that stops on an
    invalid opcode (a jump into data) ends early, so it differs from a complete run at the frame it stopped in."""
    from sm83 import GameBoy
    gb = GameBoy(rom)
    out = []
    while len(out) < frames:
        frame = gb.cycles // 70224
        gb.joy = buttons(frame)
        try:
            gb.run(1)
        except RuntimeError:
            break
        if gb.cycles // 70224 > frame:
            out.append(video_state(gb))
    return out


def locate(base: bytes, rom: bytes, bank: int, start: int, pad: int, frames: int) -> dict | None:
    """Run both ROMs in lockstep, one instruction at a time, and return the first instruction whose PC or ROM reads
    in the padded ROM are not those of the base ROM moved by the padding (bank `bank` from address `start` on, by
    `pad`). The reads of an instruction are compared in order; a padded ROM that still works maps one to one."""
    from sm83 import GameBoy

    def moved(rb: int, a: int) -> int:
        return a + pad if a < 0x8000 and rom_place(rb, a) >= (bank, start) and rom_place(rb, a)[0] == bank else a

    def traced(gb) -> list:
        reads = []
        orig = gb.rb

        def rb(a: int) -> int:
            if a < 0x8000:
                reads.append((gb.rombank, a))
            return orig(a)
        gb.rb = rb
        return reads

    ga, gb_ = GameBoy(base), GameBoy(rom)
    ra, rb_ = traced(ga), traced(gb_)
    n = 0
    while ga.cycles // 70224 < frames:
        frame = ga.cycles // 70224
        n += 1
        ga.joy = gb_.joy = buttons(frame)
        pa, pb = (ga.rombank if 0x4000 <= ga.pc < 0x8000 else 0, ga.pc), gb_.pc
        ra.clear()
        rb_.clear()
        ga.run(1)
        gb_.run(1)
        if moved(*pa) != pb or [moved(*r) for r in ra] != [r[1] for r in rb_]:
            kind = "read" if moved(*pa) == pb else "control flow"  # a split can be a benign carry (E-0389)
            return {"kind": kind, "instruction": n, "frame": frame, "base_pc": f"{pa[0]:02X}:{pa[1]:04X}",
                    "padded_pc": f"{pa[0]:02X}:{pb:04X}", "base_reads": [f"{b:02X}:{a:04X}" for b, a in ra],
                    "padded_reads": [f"{b:02X}:{a:04X}" for b, a in rb_]}
    return None


def rom_place(rombank: int, a: int) -> tuple[int, int]:
    """(bank, address in that bank's own space) of a CPU read below $8000: bank $00 at $0000-$3FFF, also when the
    MBC selects bank 0 into the switchable window (SoundTick reads $4000 that way: ROM byte $0000)."""
    if a < 0x4000:
        return 0, a
    return (0, a - 0x4000) if rombank == 0 else (rombank, a)


def data_reads(rom: bytes, starts: dict[int, int], pad: int, frames: int, mapit: bool) -> list[tuple[int, int, int]]:
    """Every ROM data read (opcode and operand fetches left out) as (bank, address, PC) over `frames` frames; with
    mapit, addresses in each padded bank from its start (`starts`: bank -> address) on are moved by `pad`, as the
    padded ROM should read them. Unlike the
    frame comparison this does not depend on timing: an address whose low byte moved can make code take a few
    cycles more (an `add a, l` that now carries), which moves later events across frame boundaries, but the order
    of reads stays the same unless something reads an address the padding did not move (E-0389)."""
    from sm83 import GameBoy
    gb = GameBoy(rom)
    out = []
    orig = gb.rb

    def rb(a: int) -> int:
        if a < 0x8000 and not gb.cur_pc <= a < gb.cur_pc + 3:
            b, ia = rom_place(gb.rombank, a)
            out.append((b, a + pad if mapit and b in starts and ia >= starts[b] else a, gb.cur_pc))
        return orig(a)
    gb.rb = rb
    while gb.cycles // 70224 < frames:
        gb.joy = buttons(gb.cycles // 70224)
        try:
            gb.run(1)
        except RuntimeError:
            break
    return out


def shifted_pokes(pokes: list[str], starts: dict[int, int], pad: int) -> list[str]:
    """A recipe's pokes for the padded ROM: a script pointer (wScriptPointerLo/Hi, in the bank wDataBank names)
    into a padded bank, at or after its padding, moves by `pad`; every other poke is a RAM value and stays."""
    vals = dict(p.split("=", 1) for p in pokes if "=" in p and not p.startswith("call:"))
    if "wScriptPointerLo" not in vals or "wScriptPointerHi" not in vals:
        return pokes
    bank = int(vals.get("wDataBank", "0"), 0)
    addr = int(vals["wScriptPointerLo"], 0) | int(vals["wScriptPointerHi"], 0) << 8
    if bank not in starts or addr < starts[bank]:
        return pokes
    addr += pad
    out = []
    for p in pokes:
        if p.startswith("wScriptPointerLo="):
            p = f"wScriptPointerLo={addr & 0xFF:#x}"
        elif p.startswith("wScriptPointerHi="):
            p = f"wScriptPointerHi={addr >> 8:#x}"
        out.append(p)
    return out


def recipe_reads(base: bytes, rom: bytes, sym_base: dict, sym_pad: dict, starts: dict[int, int], pad: int,
                 path: Path, until: str | None = None) -> dict:
    """Replays a tools/play.py recipe chain on the base and the padded ROM, one run line at a time in lockstep, and
    compares the order of their ROM data reads (the base's mapped through the padding, as in data_reads). Returns
    the number of runs and reads, the routines the base run executed, and the first differing read, if any."""
    import pickle
    import play
    from sm83 import GameBoy
    ram = dict(re.findall(r"^DEF (\w+) EQU \$([0-9A-F]{4})", (ROOT / "src/ram.asm").read_text(encoding="utf-8"),
                          re.M))
    lines = [[x.strip() for x in ln.split("|")] for ln in play.recipe_lines(str(path))]
    last_use: dict[str, int] = {}
    for i, (_s, old, _p, _r) in enumerate(lines):
        if old:
            last_use[old.removeprefix("sram:")] = i
    labels = {(b, a): n for n, (b, a) in sym_base.items() if "." not in n}
    states: dict[str, dict[str, bytes]] = {"base": {}, "pad": {}}
    seen: dict = {}
    reads = 0
    for i, (state, old, pokes, recipe) in enumerate(lines):
        res = []
        for side, data, mapit, sym in (("base", base, True, sym_base), ("pad", rom, False, sym_pad)):
            st = states[side]
            if old.startswith("sram:"):
                gb = GameBoy(data)
                gb.sram[:] = pickle.loads(st[old[5:]]).sram
            elif old:
                gb = pickle.loads(st[old])
                gb.rom = data
            else:
                gb = GameBoy(data)
            # each reading instruction is its own stream, keyed by its address (the base's mapped through the padding)
            # and by the interrupt it runs in: when an interrupt arrives, and how much a time-budgeted loop does in
            # one frame, depend on timing, which a moved address can change by a few cycles (a carry), but what each
            # instruction reads, in order, does not
            out: dict[tuple, list[tuple[int, int, int]]] = {}
            isr: list[tuple[int, int]] = []  # (stack pointer, vector) of each interrupt dispatch still running
            orig, osvc = gb.rb, gb.service
            count = [0]

            def rb(a: int, gb=gb, out=out, orig=orig, isr=isr, count=count, mapit=mapit) -> int:
                if a < 0x8000 and not gb.cur_pc <= a < gb.cur_pc + 3:
                    while isr and gb.sp > isr[-1][0]:
                        isr.pop()  # that handler returned
                    b, ia = rom_place(gb.rombank, a)
                    if ia == 0x4000:  # the bank-number byte: which bank is mapped, which timing decides; never moves
                        return orig(a)
                    pb, pa = rom_place(gb.rombank, gb.cur_pc)
                    if mapit and pb in starts and pa >= starts[pb]:
                        pa += pad
                    count[0] += 1
                    out.setdefault((isr[-1][1] if isr else 0, pb, pa), []).append(
                        (b, a + pad if mapit and b in starts and ia >= starts[b] else a, count[0]))
                return orig(a)

            def service(gb=gb, osvc=osvc, isr=isr) -> None:
                pc = gb.pc
                osvc()
                if gb.pc != pc and gb.pc in (0x40, 0x48, 0x50, 0x58, 0x60):
                    isr.append((gb.sp, gb.pc))
            gb.rb, gb.service = rb, service
            for p in (pokes.split() if side == "base" else shifted_pokes(pokes.split(), starts, pad)):
                if p.startswith("call:"):
                    play.call_at_halt(gb, *sym[p[5:]])
                else:
                    play.poke(gb, ram, p)
            play.run(gb, play.parse(recipe), labels if side == "base" else {}, seen if side == "base" else {})
            del gb.rb, gb.service
            if last_use.get(state, -1) > i:
                gb.rom = b""  # the state without its ROM image; the replay puts it back
                st[state] = pickle.dumps(gb)
            res.append(out)
        for k in [k for k, v in last_use.items() if v <= i]:
            for st in states.values():
                st.pop(k, None)
        reads += sum(len(v) for v in res[0].values())
        worst = first_stream_difference(res[0], res[1])
        if worst is not None:
            key, ra, rp, x, y = worst
            vec, pb, pa = key
            return {"runs": i + 1, "reads": reads, "routines": len(seen), "first_differing_read": {
                "run": state, "in": f"the interrupt at ${vec:04X}" if vec else "main code",
                "instruction": label_of(sym_base, pb, pa if not (pb in starts and pa >= starts[pb] + pad)
                                        else pa - pad),
                "base": f"{x[0]:02X}:{x[1]:04X}", "padded": f"{y[0]:02X}:{y[1]:04X}",
                "base_reads": [f"{b:02X}:{a:04X}" for b, a, _n in ra],
                "padded_reads": [f"{b:02X}:{a:04X}" for b, a, _n in rp]}}
        if state == until:
            return {"runs": i + 1, "reads": reads, "routines": len(seen), "first_differing_read": None}
    return {"runs": len(lines), "reads": reads, "routines": len(seen), "first_differing_read": None}


def first_stream_difference(a: dict, b: dict) -> tuple | None:
    """Per-instruction read streams ({key: [(bank, address, sequence number)]}) of the base and the padded run: the
    earliest read (by the base's sequence number) where the common part of one instruction's two streams disagrees,
    as (key, base reads near it, padded reads near it, base read, padded read); None when every one agrees. A
    stream may be longer on one side (the run ended one loop pass apart), and an instruction only one side ran is
    not compared."""
    worst = None
    for key in a.keys() & b.keys():
        ra, rp = a[key], b[key]
        for j, (x, y) in enumerate(zip(ra, rp)):
            if x[:2] != y[:2]:
                if worst is None or x[2] < worst[3][2]:
                    worst = (key, ra[max(0, j - 3):j + 4], rp[max(0, j - 3):j + 4], x, y)
                break
    return worst


def first_read_difference(a: list, b: list) -> int | None:
    for i, (x, y) in enumerate(zip(a, b)):
        if x[:2] != y[:2]:
            return i
    return None if len(a) == len(b) else min(len(a), len(b))


def label_of(sym: dict[str, tuple[int, int]], bank: int, addr: int) -> str:
    """The nearest label at or below (bank, addr), as Label+offset."""
    best = max(((a, n) for n, (b, a) in sym.items() if b == (0 if addr < 0x4000 else bank) and a <= addr),
               default=None)
    return f"{best[1]}+${addr - best[0]:X}" if best else f"{bank:02X}:{addr:04X}"


PERSIST = 8  # --persist: frames a difference must last to count


def first_difference(a: list[str], b: list[str], persist: int = 1) -> int | None:
    """The first frame from which the two runs differ for `persist` frames in a row (or to the end of the shorter
    run). Shorter differences are timing: an address whose low byte moved can make `add a, l` carry where it did
    not, a few cycles more, and a palette upload then lands one frame boundary later (E-0389). A run that stopped
    early differs from where it stopped."""
    run = 0
    for i, (x, y) in enumerate(zip(a, b)):
        run = run + 1 if x != y else 0
        if run >= persist:
            return i - persist + 1
    n = min(len(a), len(b))
    if len(a) != len(b):
        return n - run if run else n
    return None


def transient_frames(a: list[str], b: list[str]) -> int:
    """Frames that differ, counted whether or not the difference lasts."""
    return sum(1 for x, y in zip(a, b) if x != y)


def padded_rom(out: Path, pristine: Path, files: dict[int, Path], sym: dict, banks: list[int], pad: int, tag: str
               ) -> tuple[bytes | None, dict, dict, str]:
    """Copy the pristine src/ to out/<tag>/src, pad `banks`, assemble. Returns (ROM, padded, skipped, log)."""
    src = out / tag / "src"
    shutil.rmtree(out / tag, ignore_errors=True)
    shutil.copytree(pristine, src)
    padded, skipped = {}, {}
    for b in banks:
        f = src / files[b].relative_to(pristine)
        try:
            text, label = pad_bank(f.read_text(encoding="utf-8"), b, sym, pad)
        except ValueError as e:
            skipped[f"{b:02X}"] = str(e)
            continue
        f.write_text(text, encoding="utf-8", newline="\n")
        padded[f"{b:02X}"] = label
    rom, log = assemble(src, out / tag)
    return rom, padded, skipped, log


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--pad", type=int, default=1)
    ap.add_argument("--banks", default="all", help="all, or hex bank numbers separated by commas")
    ap.add_argument("--frames", type=int, default=3000)
    ap.add_argument("--bisect", type=int, default=0, metavar="K",
                    help="when the frames differ, find up to K banks whose padding alone makes them differ")
    ap.add_argument("--locate", metavar="BB", help="pad only bank BB and report the first instruction that "
                    "reads or jumps to an address the padding did not move with it")
    ap.add_argument("--reads", metavar="BB", help="pad only bank BB (or all) and compare the order of ROM data "
                    "reads, which timing does not change, instead of the frames")
    ap.add_argument("--explore", action="store_true", help="from frame 4000 walk, talk and open menus")
    ap.add_argument("--recipe", type=Path, help="with --reads: replay this tools/play.py recipe chain (with its "
                    "includes) on both ROMs instead of the scripted joypad")
    ap.add_argument("--until", metavar="STATE", help="with --recipe: stop after the run that makes this state")
    ap.add_argument("--persist", type=int, default=8, help="frames a difference must last to count (default 8)")
    ap.add_argument("--out", default="build/shift")
    args = ap.parse_args(argv)
    global EXPLORE, PERSIST
    EXPLORE, PERSIST = args.explore, max(1, args.persist)
    out = (ROOT / args.out).resolve()
    if (ROOT / "build").resolve() not in out.parents:
        sys.exit("output dir must be beneath build/")
    if args.pad < 1:
        sys.exit("--pad must be at least 1")
    if args.recipe and not args.reads:
        sys.exit("--recipe needs --reads")
    shutil.rmtree(out, ignore_errors=True)
    pristine = out / "base/src"
    shutil.copytree(ROOT / "src", pristine)
    base, log = assemble(pristine, out / "base")
    if base is None:
        print(log)
        sys.exit("FAIL: the unpadded copy of src/ does not assemble")
    if base != (ROOT / "local/roms/dwm2-cobi-us.gbc").read_bytes():  # the copy itself must still match
        sys.exit("FAIL: the unpadded copy of src/ does not rebuild the reference; fix the matching build first")
    sym = read_sym(out / "base/dwm2.sym")
    files = bank_files(pristine)
    chosen = sorted(files) if args.banks == "all" else [int(b, 16) for b in args.banks.split(",")]
    if args.locate or (args.reads and args.reads != "all"):
        chosen = [int(args.locate or args.reads, 16)]
    for b in chosen:
        if b not in files:
            sys.exit(f"no bank file for bank ${b:02X}")
    rom, padded, skipped, log = padded_rom(out, pristine, files, sym, chosen, args.pad, "padded")
    report = {"pad": args.pad, "banks_padded": padded, "banks_skipped": skipped, "assembled": rom is not None}
    if rom is None:
        report["assembler_log"] = log[-4000:]
    else:
        moved = read_sym(out / "padded/dwm2.sym")
        report["labels_moved"] = sum(1 for k, v in sym.items() if moved.get(k) != v)
        report["frames"] = args.frames
        if args.recipe:
            starts = {int(b, 16): sym[label][1] for b, label in padded.items()}
            res = recipe_reads(base, rom, sym, moved, starts, args.pad, args.recipe, args.until)
            report.update(recipe=str(args.recipe), **res)
            ok = res["first_differing_read"] is None
            (out / "report.json").write_text(json.dumps(report, indent=1), encoding="utf-8")
            print(json.dumps({k: report[k] for k in ("pad", "recipe", "runs", "reads", "routines",
                                                     "first_differing_read")}, indent=1))
            print(f"{'PASS' if ok else 'FAIL'}: recipe data reads with {len(padded)} banks padded by {args.pad}")
            return 0 if ok else 1
        ha = frame_hashes(base, args.frames)
        if args.reads:
            starts = {int(b, 16): sym[label][1] for b, label in padded.items()}
            ra = data_reads(base, starts, args.pad, args.frames, True)
            rp = data_reads(rom, starts, args.pad, args.frames, False)
            i = first_read_difference(ra, rp)
            report["data_reads"] = len(ra)
            report["first_differing_read"] = None if i is None else {
                "index": i, "base": f"{ra[i][0]:02X}:{ra[i][1]:04X}" if i < len(ra) else None,
                "padded": f"{rp[i][0]:02X}:{rp[i][1]:04X}" if i < len(rp) else None,
                "routine": label_of(sym, ra[i][0], ra[i][2]) if i < len(ra) else None}
            ok = report["first_differing_read"] is None
            (out / "report.json").write_text(json.dumps(report, indent=1), encoding="utf-8")
            print(json.dumps({k: report[k] for k in ("pad", "data_reads", "first_differing_read")}, indent=1))
            print(f"{'PASS' if ok else 'FAIL'}: data reads with {len(padded)} banks padded by {args.pad}")
            return 0 if ok else 1
        hb = frame_hashes(rom, args.frames)
        report["persist"] = PERSIST
        report["first_differing_frame"] = first_difference(ha, hb, PERSIST)
        report["differing_frames"] = transient_frames(ha, hb)
        if args.locate and padded:
            b = chosen[0]
            start = sym[padded[f"{b:02X}"]][1]
            hit = locate(base, rom, b, start, args.pad, args.frames)
            if hit:
                pb, pa = int(hit["base_pc"][:2], 16), int(hit["base_pc"][3:], 16)
                hit["base_routine"] = label_of(sym, pb, pa)
                hit["base_reads_named"] = [label_of(sym, int(r[:2], 16), int(r[3:], 16)) for r in hit["base_reads"]]
            report["located"] = hit
        if args.bisect and report["first_differing_frame"] is not None:
            report["culprits"] = bisect(out, pristine, files, sym, [int(b, 16) for b in padded], args, ha)
    (out / "report.json").write_text(json.dumps(report, indent=1), encoding="utf-8")
    ok = rom is not None and report.get("first_differing_frame") is None
    print(json.dumps({k: v for k, v in report.items() if k not in ("banks_padded", "banks_skipped", "assembler_log")},
                     indent=1))
    print(f"{'PASS' if ok else 'FAIL'}: {len(padded)} banks padded by {args.pad} ({len(skipped)} could not be); "
          f"report {out / 'report.json'}")
    return 0 if ok else 1


def bisect(out: Path, pristine: Path, files: dict, sym: dict, banks: list[int], args, ha: list[str]) -> list[dict]:
    """Up to args.bisect banks whose padding alone changes the frames, each with its first differing frame; after
    each one is found it is left unpadded and the rest are tried again. A failure that needs two banks together
    is reported as the set that still fails."""
    def fails(bs: list[int]) -> int | None:
        rom, _p, _s, _log = padded_rom(out, pristine, files, sym, bs, args.pad, "trial")
        if rom is None:
            return -1  # does not assemble
        return first_difference(ha, frame_hashes(rom, args.frames), PERSIST)

    found, rest = [], list(banks)
    while rest and len(found) < args.bisect:
        f = fails(rest)
        if f is None:
            break
        cur = rest
        while len(cur) > 1:
            half = cur[:len(cur) // 2]
            fh = fails(half)
            if fh is not None:
                cur, f = half, fh
                continue
            other = cur[len(cur) // 2:]
            fo = fails(other)
            if fo is None:
                break  # only the two halves together fail
            cur, f = other, fo
        found.append({"banks": [f"{b:02X}" for b in cur], "first_differing_frame": f})
        print(f"culprit: banks {', '.join(f'{b:02X}' for b in cur)}, first differing frame {f}", flush=True)
        rest = [b for b in rest if b not in cur]
    return found


if __name__ == "__main__":
    sys.exit(main())
