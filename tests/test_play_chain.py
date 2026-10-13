"""A new game played to GreatLog's farm, then the debug menu's battle (E-0320; tools/recipes/e0320_farm_battle.txt,
replayed in memory). Pins the routines each step ran, which the screen pictures of E-0320 showed together with the
text their names quote, and the party records the status page showed. An observation of our own emulator; the
battle part is forced through the debug menu."""
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
ROM = ROOT / "local/roms/dwm2-cobi-us.gbc"
HAVE_SYM = any(ROOT.glob("build/run*/dwm2.sym"))
CHAIN = ROOT / "tools/recipes/e0320_farm_battle.txt"


@unittest.skipUnless(ROM.is_file() and HAVE_SYM, "reference ROM or a build's .sym file not present")
class FarmChain(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        import play
        cls.kept, cls.ran = play.replay(str(CHAIN), {"d08!"})

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


if __name__ == "__main__":
    unittest.main()
