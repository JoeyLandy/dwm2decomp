"""Every TalkMsgNNNN_<words> routine, called in tools/sm83.py from the farm reached by play (E-0320, state s26),
starts the message its name quotes: the text the game looks up begins with <words> (E-0324)."""
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
ROM = ROOT / "local/roms/dwm2-cobi-us.gbc"
HAVE_SYM = any(ROOT.glob("build/run*/dwm2.sym"))


@unittest.skipUnless(ROM.is_file() and HAVE_SYM, "reference ROM or a build's .sym file not present")
class TalkMessages(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        import talk_check
        cls.res = talk_check.run(str(ROOT / "tools/recipes/e0320_farm_battle.txt"), "s26")

    def test_every_talk_routine_starts_the_message_its_name_quotes(self):
        self.assertGreater(len(self.res), 450)
        self.assertEqual([r[:2] for r in self.res if r[1]], [])

    def test_the_check_rejects_another_routines_message(self):
        """Negative control: each name compared with the text the next routine looked up passes rarely (only where
        two messages begin alike, such as 'Hero peered into the vase')."""
        import talk_check
        n = len(self.res)
        passed = 0
        for i, (name, _p, _text) in enumerate(self.res):
            words = talk_check.NAME.fullmatch(name).group(2).lower()
            passed += self.res[(i + 1) % n][2].startswith(words)
        self.assertLess(passed / n, 0.10, passed)


if __name__ == "__main__":
    unittest.main()
