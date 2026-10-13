"""Check the battle's action effects in tools/sm83.py debug battles (E-0333).

At each DispatchActionEffectTable (36:$6717) wBattleActionId is read and the next ActionEffect_* routine to start is
paired with it; the string lookups since the previous dispatch are kept. For an action other than 0, the routine must
be the ActionEffectTable entry of that id, and the latest skill-name lookup before it (category 4 of the bank-$08
string tables, the battle text naming the skill) must be that same id. Action 0, which no skill name precedes, is the
plain attack. An observation of our own emulator; the battles are forced through the debug menu.

    python -I tools/effect_check.py [TEMPLATE ...]
"""
import pickle
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import boot_trace  # noqa: E402
import play  # noqa: E402

wBattleActionId = 0xD8A6
SKILL_NAMES = (0x08, 4)  # bank and string category of the skill names
RECIPE = "S W300 A*60 W60 A*60 W60 A*60 W60"


def run(templates):
    """Returns ([(template, action id, effect routine, skill-name lookups before it)], [problems])."""
    labels = boot_trace.load_labels()
    by_name = {v: k for k, v in labels.items()}
    kept, _ran = play.replay(str(ROOT / "tools/recipes/e0320_farm_battle.txt"), {"d05!"}, stop_when_kept=True)
    base = pickle.dumps(kept["d05!"])
    rom = (ROOT / "local/roms/dwm2-cobi-us.gbc").read_bytes()
    tb, ta = by_name["ActionEffectTable"]
    o = tb * 0x4000 + ta - 0x4000
    table = [(tb, rom[o + 2 * i] | rom[o + 2 * i + 1] << 8) for i in range(240)]
    disp = by_name["DispatchActionEffectTable"]
    effects = {a: n for n, a in by_name.items() if n.startswith("ActionEffect_") and "_" not in n[13:]}
    out, problems = [], []
    for t in templates:
        gb = pickle.loads(base)
        gb.wb(0xD09F, t & 0xFF)
        gb.wb(0xD0A0, t >> 8)
        log: list[dict] = []
        names: list[int] = []  # skill-name lookups since the previous dispatch

        def on_disp(g):
            if g.rombank == disp[0]:
                log.append({"id": g.rb(wBattleActionId), "effect": None, "names": list(names)})
                names.clear()

        def on_effect(addr):
            def hook(g):
                if log and log[-1]["effect"] is None and (g.rombank, addr) in effects:
                    log[-1]["effect"] = (g.rombank, addr)
            return hook

        def on_lookup(g):
            if (g.rombank, g.rb(boot_trace.wStringCategory)) == SKILL_NAMES:
                names.append(g.rb(boot_trace.wStringIndex))

        gb.pc_hooks[disp[1]] = on_disp
        for (_b, a) in effects:
            gb.pc_hooks.setdefault(a, on_effect(a))
        gb.pc_hooks[boot_trace.LOOKUP_STRING_RET] = on_lookup
        play.run(gb, play.parse(RECIPE), labels, {})
        for e in log:
            if e["effect"] is None:
                continue
            out.append((t, e["id"], effects[e["effect"]], e["names"]))
            if e["effect"] != table[e["id"]]:
                problems.append((t, e["id"], effects[e["effect"]], "not the table entry"))
            elif e["id"] and e["names"] and e["names"][-1] != e["id"]:
                problems.append((t, e["id"], effects[e["effect"]], f"skill name {e['names'][-1]} shown"))
    return out, problems


if __name__ == "__main__":
    ts = [int(a, 0) for a in sys.argv[1:]] or [95, 295, 370]
    out, problems = run(ts)
    named = [r for r in out if r[1] and r[3]]
    print(f"{len(out)} effects ({len(named)} skills with their name shown), "
          f"{len({r[2] for r in out})} routines, {len(problems)} problems")
    for p in problems[:30]:
        print("  ", p)
