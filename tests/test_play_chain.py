"""A new game played to GreatLog's farm, then the debug menu's battle (E-0320; tools/recipes/e0320_farm_battle.txt),
then the Desert key world with random encounters, the field menu and a PLAN battle (E-0321; e0321_desert.txt), then
the field menu's ITEM, SKILLS and PLAN (E-0322; e0322_menus.txt, which includes the others), replayed in memory. Pins the routines each step ran, which the screen pictures showed together
with the text or screen their names describe, and the records the status pages showed. An observation of our own
emulator; everything after the farm is forced (debug menu, location bytes, one story flag)."""
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
ROM = ROOT / "local/roms/dwm2-cobi-us.gbc"
HAVE_SYM = any(ROOT.glob("build/run*/dwm2.sym"))
CHAIN = ROOT / "tools/recipes/e0322_menus.txt"


@unittest.skipUnless(ROM.is_file() and HAVE_SYM, "reference ROM or a build's .sym file not present")
class FarmChain(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        import play
        cls.kept, cls.ran = play.replay(str(CHAIN), {"d08!", "k02!", "k05!", "k08!", "m03!", "m04!", "m07!",
                                                             "m09!", "m11!", "m12!"})
        cls.labels = {v: k for k, v in __import__("boot_trace").load_labels().items()}
        import re
        cls.ram = {n: int(a, 16) for n, a in re.findall(r"^DEF (\w+) EQU \$([0-9A-F]{4})",
                                                         (ROOT / "src/ram.asm").read_text(encoding="utf-8"), re.M)}

    def test_story_scenes_run_at_the_steps_that_showed_their_text(self):
        expect = {"s14": ["TalkMsg000A_WellSoonBeReachingGreatLog"],  # talking to the mother
                  "s22": ["SceneLandHo"],  # talking to Tara
                  "s24": ["SceneLandHo_ShowThisIsATale"],  # "This is a tale of children who came"
                  "s25": ["SceneHorsingAround", "TalkScript5111_ListenYouTwoQuitYourHorsing"]}
        for state, names in expect.items():
            for name in names:
                self.assertEqual(self.ran[state].get(name), {1}, (state, name))

    def test_party_records_in_state_2_and_kept_ones_in_state_1(self):
        sram = self.kept["d08!"].sram
        self.assertEqual([sram[i * 0xA5] for i in range(8)], [2, 2, 2, 1, 1, 1, 1, 1])

    def test_the_status_page_monster(self):
        """Patta: Dracky (species $73), level 4 of cap 50, female, 15 EXP (the page showed Lv 4, the female
        mark, Dracky, Ex 15 and 12 more for the next level)."""
        r = self.kept["d08!"].sram[0:0xA5]
        self.assertEqual(r[0x0B] | r[0x0C] << 8, 0x73)
        self.assertEqual((r[0x56], r[0x57], r[0x0E] & 1), (4, 50, 1))
        self.assertEqual(int.from_bytes(r[0x58:0x5B], "little"), 15)
        rom = ROM.read_bytes()
        row = 0x19 * 0x4000 + 0x4E60 - 0x4000 + 2 * 0x129  # ExpTable row 2, Dracky's EXP curve
        need5 = int.from_bytes(rom[row + 3 * 4:row + 3 * 5], "little")
        self.assertEqual(need5 - 15, 12)

    def test_a_random_encounter_in_the_desert_world(self):
        """Walking in the Desert key world counts down the encounter counter, runs the battle transition and enters
        battle mode 4 (the picture showed a CactiBall and the FIGHT/ITEM/PLAN/FLEE menu)."""
        ran = self.ran["k02!"]
        for name in ("TickRandomEncounterCounter", "RunBattleTransitionStep", "RunBattleIntroKindCase"):
            self.assertEqual(ran.get(name), {1}, name)
        self.assertEqual(self.kept["k02!"].rb(0xC5DB), 4)  # wGameMode

    def test_the_field_menu_and_the_gold(self):
        """With story flag 2 set, A opens the field menu, which shows G99999 and the party status window."""
        ran = self.ran["k05!"]
        for name in ("ShowIdlePartyStatusWindow", "BuildPartyStatusWindowRows", "DrawGoldDigitsAtHLWrapped"):
            self.assertEqual(ran.get(name), {1}, name)
        gb = self.kept["k05!"]
        self.assertEqual(gb.rb(0xC617) | gb.rb(0xC618) << 8 | gb.rb(0xC619) << 16, 99999)  # wGoldLo/Mid/Hi

    def test_the_pause_menu_is_game_mode_2_and_shows_the_skills(self):
        """INFO runs the pause menu in mode 2; its skill page showed 'Sleep' for Patta, whose first MON_SKILLS
        byte names String_08_04_2F; MON_SKILL_LIST holds Dracky's three natural skills."""
        for name in ("GameMode2_Update", "PauseMenu_Info"):
            self.assertEqual(self.ran["k06!"].get(name), {2}, name)
        self.assertEqual(self.ran["k08!"].get("ShowRecordSpeciesAndSkillNames"), {2})
        r = self.kept["k08!"].sram[0:0xA5]
        self.assertEqual(r[0x34], 0x2F)
        rom = ROM.read_bytes()
        b, a = self.labels["String_08_04_2F"]
        sleep = bytes([0x1C, 0x2F, 0x28, 0x28, 0x33, 0xF0])  # "Sleep", $F0
        self.assertEqual(rom[b * 0x4000 + a - 0x4000:b * 0x4000 + a - 0x4000 + 6], sleep)
        b, a = self.labels["SpeciesRecord_Dracky"]
        natural = rom[b * 0x4000 + a - 0x4000 + 8:b * 0x4000 + a - 0x4000 + 11]
        self.assertEqual(bytes(r[0x3C:0x3F]), natural)
        self.assertEqual(natural, bytes([0x21, 0x2F, 0x32]))

    def test_plan_command_and_the_skill_page_in_battle(self):
        self.assertEqual(self.ran["k14!"].get("RunBattleSetup_CommandMenu"), {4})
        self.assertEqual(self.ran["k15!"].get("SetSlotTacticAndSlotLastTacticForCommandMonster"), {4})
        self.assertEqual(self.ran["k16!"].get("ShowSkillPageNames"), {4})


    def test_the_field_menu_choice_is_the_pause_menu_state(self):
        """wMenuState is the field menu's cursor and becomes wModeState of game mode 2: 0 INFO, 1 ITEM, 2 SKILLS,
        3 PLAN (pictured: the ITEM list, the SKILLS list and the PLAN menu)."""
        self.assertEqual(self.kept["m03!"].rb(self.ram["wMenuState"]), 1)
        for state, mode_state, name in (("m04!", 1, "PauseMenu_Items"), ("m09!", 2, "PauseMenu_Skills"),
                                        ("m11!", 3, "PauseMenu_Plan")):
            self.assertEqual(self.ran[state].get(name), {2}, name)
            gb = self.kept[state]
            self.assertEqual((gb.rb(0xC5DB), gb.rb(self.ram["wModeState"])), (2, mode_state), state)

    def test_the_inventory_holds_item_ids(self):
        """The ITEM list's first page is Herb, LoveWater, WorldDew, Potion; wInventory starts 1, 2, 3, 4, and
        String_08_05_01-04 are those names."""
        import gb_text
        inv = [self.kept["m04!"].rb(0xC61D + i) for i in range(4)]
        self.assertEqual(inv, [1, 2, 3, 4])
        rom = ROM.read_bytes()
        names = []
        for i in inv:
            b, a = self.labels[f"String_08_05_{i:02X}"]
            o = b * 0x4000 + a - 0x4000
            names.append("".join(gb_text.BYTE_TO_TEXT[c] for c in rom[o:rom.index(0xF0, o)]))
        self.assertEqual(names, ["Herb", "LoveWater", "WorldDew", "Potion"])

    def test_a_herb_on_a_monster_at_full_hp_is_kept(self):
        for name in ("PauseMenu_Items_UseItem", "CheckItemUsable", "ItemUsable_Herb"):
            self.assertEqual(self.ran["m06!"].get(name, set()) | self.ran["m07!"].get(name, set()), {2}, name)
        gb = self.kept["m07!"]
        self.assertEqual(gb.rb(0xC61D), 1)  # still a Herb in slot 0
        self.assertEqual(gb.sram[0x5B] | gb.sram[0x5C] << 8, gb.sram[0x5D] | gb.sram[0x5E] << 8)

    def test_saving_is_refused_in_a_key_world(self):
        """PLAN's Journal showed 'You can't save here.' in the Desert world: SaveForbiddenHere ran with wMapType
        bit 7 clear, so the refusal is bit 4 of MapItemUseFlags for map $20, which is clear there and set for
        GreatLog's maps."""
        for name in ("TestSaveForbiddenHere", "SaveForbiddenHere"):
            self.assertEqual(self.ran["m12!"].get(name), {2}, name)
        gb = self.kept["m12!"]
        self.assertEqual((gb.rb(self.ram["wMapType"]) & 0x80, gb.rb(0xFF90)), (0, 0x20))  # hMapId
        b, a = self.labels["MapItemUseFlags"]
        flags = ROM.read_bytes()[b * 0x4000 + a - 0x4000:][:0x100]
        self.assertFalse(flags[0x20] & 0x10)
        self.assertTrue(all(f & 0x10 for f in flags[:0x20]))


if __name__ == "__main__":
    unittest.main()
