"""Force one battle status bit in a debug battle and see which battle texts it brings (E-0339).

A battle slot's status is nine bytes, wBattleStatus ... wBattleStatus8 (stride 9, AddAx9ToHL). `run(byte, bit)` sets
that bit for all eight slots each time an action starts resolving (RunBattleResolveStep, 36:$4001) or a turn's
status checks run (32:$544A), and records every battle text looked up in bank $2F (category 0 or 1). Compared with
an unforced battle, the new texts show what the bit means. An observation of our own emulator; the battle is forced
through the debug menu as in E-0332, against template 95.

    python -I tools/status_check.py BYTE [BIT ...]       (prints JSON: {"byte.bit": [[category, index], ...]})
"""
import json
import pickle
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import boot_trace  # noqa: E402
import play  # noqa: E402

wBattleStatus = 0xD80C
HOOKS = {(0x36, 0x4001), (0x32, 0x544A)}
RECIPE = "S W300 A*60 W60 A*60 W60 A*60 W60"


def base(template: int = 95) -> bytes:
    kept, _ = play.replay(str(ROOT / "tools/recipes/e0320_farm_battle.txt"), {"d05!"}, stop_when_kept=True)
    gb = kept["d05!"]
    gb.wb(0xD09F, template & 0xFF)
    gb.wb(0xD0A0, template >> 8)
    return pickle.dumps(gb)


def run(start: bytes, byte: int | None, bit: int | None) -> list[tuple[int, int]]:
    """The (category, index) battle texts looked up in order, with status byte `byte` bit `bit` forced."""
    gb = pickle.loads(start)
    shown: list[tuple[int, int]] = []

    def force(g):
        if (g.rombank, g.pc) in HOOKS and byte is not None:
            for s in range(8):
                a = wBattleStatus + 9 * s + byte
                g.wb(a, g.rb(a) | 1 << bit)

    def on_lookup(g):
        if g.rombank == 0x2F and g.rb(boot_trace.wStringCategory) in (0, 1):
            shown.append((g.rb(boot_trace.wStringCategory), g.rb(boot_trace.wStringIndex)))

    for _b, a in HOOKS:
        gb.pc_hooks[a] = force
    gb.pc_hooks[boot_trace.LOOKUP_STRING_RET] = on_lookup
    play.run(gb, play.parse(RECIPE), boot_trace.load_labels(), {})
    return shown


if __name__ == "__main__":
    start = base()
    byte = int(sys.argv[1])
    bits = [int(b) for b in sys.argv[2:]] or list(range(8))
    res = {"none": sorted(set(run(start, None, None)))}
    for b in bits:
        res[f"{byte}.{b}"] = sorted(set(run(start, byte, b)))
    print(json.dumps(res))
