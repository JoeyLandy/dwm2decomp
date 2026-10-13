"""The AI's per-skill scoring routines run for the skills their table assigns and that a battling monster holds
(E-0332; tools/ai_check.py over three debug battles)."""
import random
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
ROM = ROOT / "local/roms/dwm2-cobi-us.gbc"
HAVE_SYM = any(ROOT.glob("build/run*/dwm2.sym"))


@unittest.skipUnless(ROM.is_file() and HAVE_SYM, "reference ROM or a build's .sym file not present")
class AIScoring(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        import ai_check
        cls.pairs, cls.problems = ai_check.run([95, 295, 370])

    def test_each_scoring_routine_matches_its_skill(self):
        self.assertGreater(len(self.pairs), 100)
        self.assertGreater(len({n for _t, _s, n in self.pairs}), 10)
        self.assertEqual(self.problems, [])
        self.assertIn("AIScore_Fight", {n for _t, s, n in self.pairs if s == 0})

    def test_the_table_check_rejects_another_skill(self):
        """Negative control: a routine paired with a random other skill seldom is that skill's table entry."""
        import ai_check
        import boot_trace
        labels = {v: k for k, v in boot_trace.load_labels().items()}
        rom = ROM.read_bytes()
        tables = [ai_check.table(rom, labels, n) for n in ("AIScoreRoutineTableA", "AIScoreRoutineTableB")]
        rng = random.Random(7)
        hits = 0
        for _t, _s, name in self.pairs:
            other = rng.randrange(256)
            hits += labels[name] in {tb[other] for tb in tables}
        self.assertLess(hits / len(self.pairs), 0.15, hits)


if __name__ == "__main__":
    unittest.main()
