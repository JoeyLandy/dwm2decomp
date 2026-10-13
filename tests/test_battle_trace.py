"""A battle from power-on in tools/sm83.py (E-0320). The title screen is reached by play; wGameMode is then forced to
0 (the debug menu, E-0029), whose 6:BATTLE entry sets up a battle with one DrakSlime and starts game mode 4. One
FIGHT round is played and the first party monster's status page opened. Checks that battle names run in battle,
debug-menu names in mode 0, and that the monster record and the battler record hold the same monster at the offsets
config/record_fields.json gives them. An observation of our own emulator; the RAM poke makes the start forced."""
import json
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
ROM = ROOT / "local/roms/dwm2-cobi-us.gbc"
HAVE_SYM = any(ROOT.glob("build/run*/dwm2.sym"))

# debug menu: down to 6:BATTLE, choose it; one foe, own monster 001, foe species 001 at level 5; start; FIGHT
RECIPE = ("W120 D W10 D W10 D W10 D W10 D W30 A W200 R W10 R W10 W30 L W10 D W10 R W10 D W10 D W10 D W10 D W10 D W10 "
          "R W10 D W10 R*5 W30 S W300 A W30 A*30 W100")
wGameMode, wModeChangeRequest, wBattlerRecords = 0xC5DB, 0xC5DF, 0xD0D5


@unittest.skipUnless(ROM.is_file() and HAVE_SYM, "reference ROM or a build's .sym file not present")
class BattleTrace(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        import boot_trace
        import play
        from sm83 import GameBoy
        gb = GameBoy(ROM.read_bytes())
        labels = boot_trace.load_labels()
        seen: dict = {}
        play.run(gb, play.parse("W800"), labels, seen)
        cls.title_names = {labels[k] for k in seen}
        gb.wb(wGameMode, 0)
        gb.wb(wModeChangeRequest, 1)
        play.run(gb, play.parse(RECIPE), labels, seen)
        cls.modes = {labels[k]: m for k, m in seen.items()}
        cls.gb = gb
        cls.fields = json.loads((ROOT / "config/record_fields.json").read_text(encoding="utf-8"))

    def test_debug_menu_names_run_in_mode_0(self):
        for name in ("GameMode0_Init", "DebugMainMenu_Init", "DebugMainMenu_Update", "DebugBattleSetup_Init",
                     "DebugBattleSetup_Update"):
            self.assertEqual(self.modes.get(name), {0}, name)

    def test_battle_names_run_in_battle_mode_4(self):
        for name in ("GameMode4_Init", "GameMode4_Update", "RunBattlePhase", "BattlePhase0", "GetBattleATK_Bank05",
                     "GetBattleDEF_Bank05", "LoadSlotSkillsFromBattlerRecord", "ActorCanPayMPCost_Bank05",
                     "AnyFoeNotBlocked", "BattlerRecordFieldAddress", "AIChooseActionForActor",
                     "BattleEnd_GainExperience", "BattleEnd_AskToJoin_ShowHeroGotUpLooking"):
            self.assertEqual(self.modes.get(name), {4}, name)

    def test_field_and_title_code_does_not_run_in_battle(self):
        for name in ("FieldModeStateDispatch", "UpdatePlayerMovement", "GameMode5_Update",
                     "RunNameEntryStateWhenNotFading"):
            self.assertNotIn(4, self.modes.get(name, set()), name)

    def test_no_battle_or_ai_routine_runs_on_the_title_screen(self):
        self.assertEqual(sorted(n for n in self.title_names if n.startswith(("Battle", "RunBattle", "AIScore",
                                                                              "AIChoose", "GameMode4"))), [])

    def test_record_and_battler_record_hold_the_same_monster(self):
        """SRAM record 0 (the main record layout, at $A000 in SRAM bank 0) and battler record 0 (wBattlerRecords)
        agree on the fields both layouts name; the status page pictured in E-0320 shows these values."""
        main = {v["const"][4:]: (int(k, 16), v.get("size", 1)) for k, v in self.fields["fields"].items()}
        bat = {v["const"][8:]: (int(k, 16), v.get("size", 1)) for k, v in self.fields["battler"]["fields"].items()}
        rec = bytes(self.gb.sram[0:0xA5])
        brec = bytes(self.gb.wram[1][wBattlerRecords - 0xD000:wBattlerRecords - 0xD000 + 0x4E])
        self.assertEqual(rec[0], 2)  # MON_STATE: in use
        common = ["LEVEL", "HP", "MAX_HP", "MP", "MAX_MP", "ATK", "DEF", "AGL", "INT", "WLD", "SPECIES"]
        for f in common:
            (a, n), (b, m) = main[f], bat[f]
            self.assertEqual(rec[a:a + n], brec[b:b + m], f)
        self.assertEqual(rec[main["NAME"][0]:main["NAME"][0] + 5], brec[0:5])  # the five name letters
        hp, max_hp = (int.from_bytes(rec[main[f][0]:main[f][0] + 2], "little") for f in ("HP", "MAX_HP"))
        self.assertTrue(0 < hp <= max_hp < 1000, (hp, max_hp))


if __name__ == "__main__":
    unittest.main()
