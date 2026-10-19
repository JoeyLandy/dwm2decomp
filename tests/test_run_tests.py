"""tools/run_tests.py: the parallel runner's log parsing and run comparison (E-0368)."""
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import run_tests  # noqa: E402
import suite_progress  # noqa: E402

LOG = """test_a (test_x.A.test_a) ... ok
test_b (test_x.A.test_b)
A docstring line ... FAIL
test_c (test_y.B.test_c) ... skipped 'no listing'
test_d (test_y.B.test_d) ... ERROR

----------------------------------------------------------------------
Ran 4 tests in 0.010s
"""


class Parse(unittest.TestCase):
    def test_outcomes_and_count(self):
        self.assertEqual(run_tests.outcomes(LOG), {"test_x.A.test_a": "ok", "test_x.A.test_b": "FAIL",
                                                   "test_y.B.test_c": "skipped", "test_y.B.test_d": "ERROR"})
        self.assertEqual(run_tests.ran(LOG), 4)

    def test_identical_logs_agree(self):
        self.assertEqual(run_tests.compare(LOG, LOG), [])

    def test_a_changed_outcome_is_reported(self):
        diffs = run_tests.compare(LOG, LOG.replace("... ERROR", "... ok"))
        self.assertEqual(diffs, ["test_y.B.test_d: ERROR vs ok"])

    def test_a_missing_test_is_reported(self):
        short = LOG.replace("test_d (test_y.B.test_d) ... ERROR\n", "").replace("Ran 4", "Ran 3")
        diffs = run_tests.compare(LOG, short)
        self.assertIn("test_y.B.test_d: ERROR vs not run", diffs)
        self.assertIn("tests run: 4 vs 3", diffs)

    def test_a_line_the_test_prints_before_its_outcome(self):
        # test_rename and test_src_drift print a message after the dots; the outcome is on the next line
        log = LOG.replace("test_a (test_x.A.test_a) ... ok", "test_a (test_x.A.test_a) ... refused: Nope\nok")
        self.assertEqual(run_tests.outcomes(log), run_tests.outcomes(LOG))

    def test_unparsed_outcomes_are_reported(self):
        garbled = LOG.replace("test_a (test_x.A.test_a) ... ok", "test_a (test_x.A.test_a) ...noise ok")
        self.assertIn("outcomes parsed: 4 of 4 vs 3 of 4", run_tests.compare(LOG, garbled))


class Progress(unittest.TestCase):
    """tools/suite_progress.py: what a serial log says while it is still being written."""

    def test_a_log_part_way(self):
        part = LOG.split("test_d")[0] + "test_d (test_y.B.test_d) ... "
        snap = suite_progress.snapshot(part, 10)
        self.assertEqual((snap["done"], snap["total"], snap["running"], snap["finished"]), (3, 10, "test_y.B.test_d", None))
        self.assertEqual(snap["failed"], ["test_x.A.test_b"])
        self.assertEqual(snap["counts"], {"ok": 1, "skipped": 1, "FAIL": 1, "ERROR": 0})

    def test_a_finished_log(self):
        snap = suite_progress.snapshot(LOG + "\nFAILED (failures=1, errors=1)\n", 4)
        self.assertEqual((snap["done"], snap["running"], snap["finished"]), (4, None, 4))
        self.assertEqual(snap["result"], "FAILED (failures=1, errors=1)")
        self.assertIn("4/4 (100%)", suite_progress.render("x.log", snap, 1)[0])

    def test_the_total_is_the_test_count(self):
        self.assertGreater(suite_progress.total_tests(), 500)


if __name__ == "__main__":
    unittest.main()
