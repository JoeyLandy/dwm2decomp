"""Steer the reference ROM in tools/sm83.py by an input recipe, keeping state between runs (E-0320).

    python -I tools/play.py STATE RECIPE [--from OLDSTATE | --sram-from OLDSTATE] [--poke SYMBOL=VALUE ...]
                            [--call LABEL]
    python -I tools/play.py --chain tools/recipes/FILE.txt    (replays one run per line)

RECIPE is space-separated steps: `W60` waits 60 frames; `A`, `B`, `S` (Start), `E` (Select), `U`, `D`, `L`, `R`
press that button for 6 frames and release it for 10; a number after a direction or button holds it that many
frames (`R32`); `A*4` repeats a step. The run starts from power-on, or from OLDSTATE (a pickle under build/states),
and saves the result as STATE plus a picture build/states/STATE.png. Each named routine that first executes during
the run is added to build/states/coverage.json with the state name and wGameMode (an observation of our own
emulator). `--poke` writes a byte before the run (a symbol from src/ram.asm, a hex address, or sram+HEX for
cartridge RAM); such a state
is forced, not reached by play, and its name is recorded with a `!` in the coverage file. States and pictures stay
local (build/ is not tracked). `--call` calls a routine at the main loop's halt (forced too). `--sram-from` powers on afresh with OLDSTATE's cartridge RAM, as after switching the
console off and on with the battery-backed save."""
import json
import pickle
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
from sm83 import GameBoy  # noqa: E402
import boot_trace  # noqa: E402
import screen  # noqa: E402

STATES = ROOT / "build/states"
BUTTON = {"R": 0x01, "L": 0x02, "U": 0x04, "D": 0x08, "A": 0x10, "B": 0x20, "E": 0x40, "S": 0x80}
FRAME = 70224


def parse(recipe: str) -> list[tuple[int, int]]:
    """(joypad mask pressed, frames) segments."""
    out = []
    for step in recipe.split():
        m = re.fullmatch(r"([WRLUDABES])(\d*)(?:\*(\d+))?", step)
        if not m:
            raise ValueError(f"bad step {step!r}")
        kind, n, rep = m.group(1), m.group(2), int(m.group(3) or 1)
        for _ in range(rep):
            if kind == "W":
                out.append((0, int(n or 1)))
            else:
                out.append((BUTTON[kind], int(n or 6)))
                out.append((0, 10))
    return out


def value(val: str, names: dict | None = None) -> int:
    """A poke's value: a number, or BANK(X), LOW(X) or HIGH(X) of a ROM label X or X+N (E-0421), from `names`
    (label -> (bank, address), the played ROM's own). A label that tools/script_bank.py moved is found as X_Far,
    its body (X itself is then a 4-byte stub)."""
    m = re.fullmatch(r"(BANK|LOW|HIGH)\((\w+)(?:\+(\w+))?\)", val)
    if not m:
        return int(val, 0)
    if names is None:
        raise ValueError(f"{val}: a label value needs the ROM's symbols")
    name = m.group(2) + "_Far" if m.group(2) + "_Far" in names else m.group(2)
    bank, addr = names[name]
    addr += int(m.group(3), 0) if m.group(3) else 0
    return {"BANK": bank, "LOW": addr & 0xFF, "HIGH": addr >> 8}[m.group(1)]


def poke(gb: GameBoy, ram: dict, spec: str, names: dict | None = None) -> None:
    """SYMBOL=VALUE or HEXADDR=VALUE writes a byte through the bus; sram+HEX=VALUE writes cartridge RAM directly
    (byte HEX of the 32 KB, bank * $2000 + offset). VALUE may be BANK(Label), LOW(Label) or HIGH(Label)."""
    sym, val = spec.split("=")
    if sym.startswith("sram+"):
        gb.sram[int(sym[5:], 16)] = value(val, names)
    else:
        gb.wb(int(ram.get(sym, sym), 16), value(val, names))


def call_at_halt(gb: GameBoy, bank: int, addr: int) -> bool:
    """Runs to the main loop's `halt` (outside an interrupt) and calls bank:addr there: the bank is mapped, the
    return address pushed. False when no such halt comes within 200,000 instructions."""
    for _ in range(200000):
        if gb.halted and gb.pc < 0x4000 and gb.ime:
            break
        gb.tick(gb.step() if not gb.halted else 456 - gb.line_cycles)
        gb.service()
    else:
        return False
    gb.halted = False
    gb.push(gb.pc)
    gb.rombank = bank
    gb.pc = addr
    return True


def run(gb: GameBoy, segments, labels, seen: dict) -> None:
    """Play the (mask, frames) segments; seen[(bank, addr)] collects every wGameMode a named routine ran in."""
    entry_at = set(labels)
    lines = getattr(gb, "line_regs", None) or [None] * 144
    gb.line_regs = lines
    for mask, frames in segments:
        gb.joy = 0xFF & ~mask
        end = (gb.cycles // FRAME + frames) * FRAME
        while gb.cycles < end:
            if gb.ly < 144:  # the registers each scanline is drawn with (screen.py uses them)
                lines[gb.ly] = (gb.io[0x40], gb.io[0x42], gb.io[0x43], gb.io[0x4A], gb.io[0x4B])
            pc = gb.pc
            key = (gb.rombank if pc >= 0x4000 else 0, pc) if pc < 0x8000 else None
            if key in entry_at:
                seen.setdefault(key, set()).add(gb.rb(boot_trace.wGameMode))
            if gb.halted:
                gb.tick(456 - gb.line_cycles if gb.io[0x40] & 0x80 else 456)
            else:
                gb.tick(gb.step())
            gb.service()
    # finish on the start of a vertical blank so the picture shows a whole frame
    while gb.ly != 144 and gb.io[0x40] & 0x80:
        if gb.halted:
            gb.tick(456 - gb.line_cycles)
        else:
            gb.tick(gb.step())
        gb.service()


def main(argv: list[str]) -> None:
    state, recipe = argv[0], argv[1]
    old = argv[argv.index("--from") + 1] if "--from" in argv else None
    STATES.mkdir(parents=True, exist_ok=True)
    if old:
        gb = pickle.loads((STATES / f"{old}.pkl").read_bytes())
    else:
        gb = GameBoy((ROOT / "local/roms/dwm2-cobi-us.gbc").read_bytes())
    if "--sram-from" in argv:
        src = argv[argv.index("--sram-from") + 1]
        gb.sram[:] = pickle.loads((STATES / f"{src}.pkl").read_bytes()).sram
        old = src  # inherits the source's forced mark
    forced = bool(old and "!" in old)  # a state continued from a forced one is forced too
    ram = dict(re.findall(r"^DEF (\w+) EQU \$([0-9A-F]{4})", (ROOT / "src/ram.asm").read_text(encoding="utf-8"), re.M))
    for k, a in enumerate(argv):
        if a == "--poke":
            poke(gb, ram, argv[k + 1], {v: k2 for k2, v in boot_trace.load_labels().items()})
            forced = True
    labels = boot_trace.load_labels()
    if "--call" in argv:  # call a routine at the main loop's halt, as an event would (E-0327)
        by_name = {v: k for k, v in labels.items()}
        call_at_halt(gb, *by_name[argv[argv.index("--call") + 1]])
        forced = True
    if forced and not state.endswith("!"):
        state += "!"
    seen: dict = {}
    run(gb, parse(recipe), labels, seen)
    (STATES / f"{state}.pkl").write_bytes(pickle.dumps(gb))
    screen.save_png(gb, STATES / f"{state}.png")
    cov_path = STATES / "coverage.json"
    cov = json.loads(cov_path.read_text(encoding="utf-8")) if cov_path.is_file() else {}
    new = []
    for (b, a), modes in sorted(seen.items()):
        name = labels[(b, a)]
        if name not in cov:
            cov[name] = [state, sorted(modes)]
            new.append(name)
        else:
            cov[name][1] = sorted(set(cov[name][1]) | modes)
    cov_path.write_text(json.dumps(cov, indent=0, sort_keys=True), encoding="utf-8")
    print(f"{state}: frame {gb.cycles // FRAME}, wGameMode {gb.rb(boot_trace.wGameMode)}, "
          f"{len(seen)} routines ran, {len(new)} new (coverage {len(cov)})")
    for n in new[:80]:
        print("  +", n)


def recipe_lines(path: str) -> list[str]:
    """The run lines of a recipe file; `@ FILE` includes another recipe file (relative to this one) first."""
    out = []
    for ln in Path(path).read_text(encoding="utf-8").splitlines():
        if ln.startswith("@"):
            out += recipe_lines(str(Path(path).parent / ln[1:].strip()))
        elif ln.strip() and not ln.startswith("#"):
            out.append(ln)
    return out


def replay(path: str, keep: set[str], stop_when_kept: bool = False, rom: bytes | None = None,
           labels: dict | None = None) -> tuple[dict, dict]:
    """Replay a recipe file in memory (nothing written): returns ({state: GameBoy} for the states in `keep`,
    {state: {routine name: wGameMode values}} for every run). With `stop_when_kept` it stops once every state in
    `keep` exists. `rom` and its `labels` ((bank, addr) -> name) replay another ROM, a mod (H5)."""
    labels = labels if labels is not None else boot_trace.load_labels()
    rom = rom if rom is not None else (ROOT / "local/roms/dwm2-cobi-us.gbc").read_bytes()
    by_name = {v: k for k, v in labels.items()}
    ram = dict(re.findall(r"^DEF (\w+) EQU \$([0-9A-F]{4})", (ROOT / "src/ram.asm").read_text(encoding="utf-8"), re.M))
    states: dict[str, bytes] = {}
    kept, ran = {}, {}
    for ln in recipe_lines(path):
        state, old, pokes, recipe = (x.strip() for x in ln.split("|"))
        if old.startswith("sram:"):  # power on afresh with that state's cartridge RAM
            gb = GameBoy(rom)
            gb.sram[:] = pickle.loads(states[old[5:]]).sram
        else:
            gb = pickle.loads(states[old]) if old else GameBoy(rom)
        for p in pokes.split():
            if p.startswith("call:"):
                call_at_halt(gb, *by_name[p[5:]])
            else:
                poke(gb, ram, p, by_name)
        seen: dict = {}
        run(gb, parse(recipe), labels, seen)
        states[state] = pickle.dumps(gb)
        ran[state] = {labels[k]: m for k, m in seen.items()}
        if state in keep:
            kept[state] = gb
        if stop_when_kept and len(kept) == len(keep):
            break
    return kept, ran


def chain(path: str) -> None:
    """Replay a recipe file: `STATE | FROM | POKES | RECIPE` per line, `#` comments, `@ FILE` includes; FROM
    `sram:STATE` powers on afresh with that state's cartridge RAM; `call:LABEL` among the pokes calls that routine at
    the main loop's halt after the pokes."""
    for ln in recipe_lines(path):
        state, old, pokes, recipe = (x.strip() for x in ln.split("|"))
        if old.startswith("sram:"):
            argv = [state, recipe, "--sram-from", old[5:]]
        else:
            argv = [state, recipe] + (["--from", old] if old else [])
        for p in pokes.split():
            argv += ["--call", p[5:]] if p.startswith("call:") else ["--poke", p]
        main(argv)


if __name__ == "__main__":
    if sys.argv[1] == "--chain":
        chain(sys.argv[2])
    else:
        main(sys.argv[1:])
