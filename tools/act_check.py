"""Force one personality-act flag in a debug battle and see which battle text appears (E-0337).

wPersonalityActs ($D854) holds a word per battle slot; its low byte gets one bit per personality extreme from the
trait rolls (RollPersonality*/RollSlotTrait*). Before each routine that reads it runs, `run(mask)` ORs `mask` into the
low byte of all eight slots, and records the category-0 battle texts (bank $2F) looked up during the battle. An
observation of our own emulator; the battle is forced through the debug menu as in E-0332.

    python -I tools/act_check.py
"""
import pickle
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import boot_trace  # noqa: E402
import play  # noqa: E402

wPersonalityActs = 0xD854
READERS = {(0x32, 0x544A), (0x32, 0x54AF), (0x36, 0x4025), (0x36, 0x4356), (0x36, 0x438A)}
BATTLE_TEXT = (0x2F, 0)  # bank and category of ShowBattleTextCategory0's texts
RECIPE = "S W300 A*60 W60 A*60 W60"


def base(template: int = 95) -> bytes:
    kept, _ = play.replay(str(ROOT / "tools/recipes/e0320_farm_battle.txt"), {"d05!"}, stop_when_kept=True)
    gb = kept["d05!"]
    gb.wb(0xD09F, template & 0xFF)
    gb.wb(0xD0A0, template >> 8)
    return pickle.dumps(gb)


def run(start: bytes, mask: int) -> list[int]:
    """The category-0 battle text ids looked up, in order, with `mask` forced into every slot's act flags."""
    gb = pickle.loads(start)
    shown: list[int] = []

    def force(g):
        if (g.rombank, g.pc) in READERS:
            for s in range(8):
                g.wb(wPersonalityActs + 2 * s, g.rb(wPersonalityActs + 2 * s) | mask)

    def on_lookup(g):
        if (g.rombank, g.rb(boot_trace.wStringCategory)) == BATTLE_TEXT:
            shown.append(g.rb(boot_trace.wStringIndex))

    for _b, a in READERS:
        gb.pc_hooks[a] = force
    gb.pc_hooks[boot_trace.LOOKUP_STRING_RET] = on_lookup
    play.run(gb, play.parse(RECIPE), boot_trace.load_labels(), {})
    return shown


if __name__ == "__main__":
    start = base()
    print("none", sorted(set(run(start, 0))))
    for bit in range(8):
        print(f"bit {bit}", sorted(set(run(start, 1 << bit))))
