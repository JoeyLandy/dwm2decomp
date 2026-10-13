"""Check the AI's per-skill scoring routines in tools/sm83.py battles (E-0332).

From the debug battle set-up of tools/recipes/e0320_farm_battle.txt (state d05!), the first foe row (wWorkBuf + $2,
a MonsterTable template id) is set and the battle played with A presses. At each call of ScoreSkillForAI (30:$4BA0)
the skill number in A is recorded; the next AIScore_* routine to start is paired with it. Each pair must agree with
the ROM's AI table that ScoreSkillForAI reads (AIScoreRoutineTableA or B, three bytes per skill: address, bank), and
the skill must be one that a battling monster holds (wBattleSkills: eight skills per battle slot), or skill 0 or $AC
(Guard), which every monster's turn scores, like the Command menu's Fight and Guard. An observation of our
own emulator; the battles are forced through the debug menu.

    python -I tools/ai_check.py [TEMPLATE ...]
"""
import pickle
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import boot_trace  # noqa: E402
import play  # noqa: E402

SCORE_SKILL_FOR_AI = (0x30, 0x4BA0)
ALWAYS = {0x00, 0xAC}  # Fight (skill 0, an empty name) and Guard (skill $AC): scored every turn, held by no record
wBattleSkills = 0xD989  # 8 battle slots, 16 bytes each: 8 skill numbers at even offsets
RECIPE = "S W300 A*60 W60 A*60 W60 A*60 W60"


def table(rom: bytes, labels: dict, name: str) -> list[tuple[int, int]]:
    b, a = labels[name]
    o = b * 0x4000 + a - 0x4000
    return [(rom[o + 3 * i + 2], rom[o + 3 * i] | rom[o + 3 * i + 1] << 8) for i in range(256)]


def battle(base: bytes, template: int, routines: dict) -> list[tuple[int, str, set]]:
    """[(skill, AIScore routine, skills the battlers hold)] for one battle against a template."""
    gb = pickle.loads(base)
    gb.wb(0xD09F, template & 0xFF)
    gb.wb(0xD0A0, template >> 8)
    pairs, pending = [], []

    def on_score(g):
        if g.rombank == SCORE_SKILL_FOR_AI[0]:
            held = {g.rb(wBattleSkills + 16 * slot + 2 * k) for slot in range(8) for k in range(8)}
            pending[:] = [(g.a, held)]

    def on_routine(addr):
        def hook(g):
            if pending and (g.rombank, addr) in routines:
                skill, held = pending.pop()
                pairs.append((skill, routines[(g.rombank, addr)], held))
        return hook

    gb.pc_hooks[SCORE_SKILL_FOR_AI[1]] = on_score
    for (_b, a) in routines:
        gb.pc_hooks.setdefault(a, on_routine(a))
    labels = boot_trace.load_labels()
    play.run(gb, play.parse(RECIPE), labels, {})
    return pairs


def run(templates):
    kept, _ran = play.replay(str(ROOT / "tools/recipes/e0320_farm_battle.txt"), {"d05!"}, stop_when_kept=True)
    base = pickle.dumps(kept["d05!"])
    labels = {v: k for k, v in boot_trace.load_labels().items()}
    rom = (ROOT / "local/roms/dwm2-cobi-us.gbc").read_bytes()
    tables = {name: table(rom, labels, name) for name in ("AIScoreRoutineTableA", "AIScoreRoutineTableB")
              if name in labels}
    routines = {addr: name for name, addr in labels.items() if name.startswith("AIScore_") and "_" not in name[8:]}
    pairs, problems = [], []
    for t in templates:
        for skill, name, held in battle(base, t, routines):
            pairs.append((t, skill, name))
            entries = {tb[skill] for tb in tables.values()}
            if labels[name] not in entries:
                problems.append((t, skill, name, "not this skill's table entry"))
            elif skill not in held and skill not in ALWAYS:
                problems.append((t, skill, name, "no battler holds this skill"))
    return pairs, problems


if __name__ == "__main__":
    ts = [int(a, 0) for a in sys.argv[1:]] or [70, 95, 295, 320, 370, 420, 445]
    pairs, problems = run(ts)
    print(f"{len(pairs)} AIScore calls, {len({n for _t, _s, n in pairs})} routines, {len(problems)} problems")
    for p in problems[:30]:
        print("  ", p)
