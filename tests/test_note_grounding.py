"""The notes of names given by reading are grounded in the code they describe (E-0317)."""
import random
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import check_note_grounding as cng  # noqa: E402


@unittest.skipUnless((ROOT / "src/banks").is_dir(), "src/banks has not been generated")
class NoteGrounding(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.src = cng.Source()

    def test_every_mention_in_a_reading_note_is_connected_to_its_routine(self):
        grounded, total, bad = cng.check(src=self.src)
        self.assertGreater(total, 4000)
        self.assertEqual(bad[:20], [], f"{len(bad)} of {total} mentions are not connected to their routine")

    def test_the_check_rejects_unrelated_symbols(self):
        """Negative control: one random RAM symbol, or one random routine, per note is accepted rarely."""
        syms = sorted(self.src.ramsyms)
        routines = sorted(n for n in self.src.regions if "_" not in n[1:] and not n.startswith(("Data", "String")))
        for pool in (syms, routines):
            rng = random.Random(5)
            g, t, _ = cng.check(control=lambda nm, note: {rng.choice(pool)}, src=self.src)
            self.assertLess(g / t, 0.10, (g, t))


if __name__ == "__main__":
    unittest.main()
