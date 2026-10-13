"""Battle actions run the effect routine their table assigns, after the battle text names the same skill (E-0333;
tools/effect_check.py over three debug battles)."""
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
ROM = ROOT / "local/roms/dwm2-cobi-us.gbc"
HAVE_SYM = any(ROOT.glob("build/run*/dwm2.sym"))


@unittest.skipUnless(ROM.is_file() and HAVE_SYM, "reference ROM or a build's .sym file not present")
class ActionEffects(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        import effect_check
        cls.out, cls.problems = effect_check.run([95, 295, 370])

    def test_each_action_runs_its_table_routine_after_its_skill_name(self):
        self.assertGreater(len(self.out), 40)
        self.assertGreater(len([r for r in self.out if r[1] and r[3]]), 3)
        self.assertEqual(self.problems, [])
        self.assertIn("ActionEffect_Fight", {r[2] for r in self.out if r[1] == 0})

    def test_the_name_check_rejects_another_id(self):
        """Negative control: the skill name shown before an action is not the id of the next different action."""
        named = [r for r in self.out if r[1] and r[3]]
        mism = sum(1 for a, b in zip(named, named[1:]) if a[1] != b[1] and b[3][-1] == a[1])
        self.assertLessEqual(mism, len(named) // 10)


if __name__ == "__main__":
    unittest.main()
