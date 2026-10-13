"""Personality-act flags forced in a debug battle show their battle text (E-0337, tools/act_check.py)."""
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
REF = ROOT / "local" / "roms" / "dwm2-cobi-us.gbc"

# bit -> the category-0 battle text it brings ($2E "struck at full power!", $2F "tucked tighter in fear!",
# $30 "concentrated!", $32 "Light fell softly on <BUF0>!", $33 "ducked behind <BUF1>!", $34 "pumped itself up!",
# $35 "rolled out of the way!")
TEXT_OF_BIT = {0: 0x2E, 1: 0x2F, 2: 0x30, 4: 0x32, 5: 0x33, 6: 0x34, 7: 0x35}


@unittest.skipUnless(REF.exists() and any(ROOT.glob("build/run*/dwm2.sym")), "needs the reference ROM and a build")
class PersonalityActsTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        import act_check
        cls.a = act_check
        cls.start = act_check.base()
        cls.none = set(act_check.run(cls.start, 0))

    def test_no_act_text_without_a_flag(self):
        self.assertIn(0x03, self.none)  # "Monsters appear!": the battle ran
        self.assertFalse(self.none & set(TEXT_OF_BIT.values()))

    def test_each_flag_shows_its_text(self):
        for bit in (5, 6, 7, 2):
            shown = set(self.a.run(self.start, 1 << bit))
            self.assertIn(TEXT_OF_BIT[bit], shown, bit)
            others = set(TEXT_OF_BIT.values()) - {TEXT_OF_BIT[bit], 0x2E}  # bit 7 also shows $2E
            self.assertFalse(shown & others, bit)


if __name__ == "__main__":
    unittest.main()
