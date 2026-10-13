"""The text printer's commands observed in tools/sm83.py (E-0336, tools/text_check.py)."""
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
REF = ROOT / "local" / "roms" / "dwm2-cobi-us.gbc"


@unittest.skipUnless(REF.exists() and any(ROOT.glob("build/run*/dwm2.sym")), "needs the reference ROM and a build")
class TextPrinterTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        import text_check
        cls.t = text_check
        cls.talk = text_check.base("s13", text_check.TALK)  # a farmhand's first line is printing
        cls.battle = text_check.base("d06!")  # a debug-menu battle about to start

    def test_glyphs_come_text_speed_frames_apart(self):
        for speed, allowed in ((0, {1, 2}), (1, {1, 2}), (2, {2, 3}), (6, {6, 7})):
            gaps = self.t.glyph_gaps(self.t.run(self.talk, "W200", speed)[0])
            self.assertGreater(len(gaps), 15, speed)
            self.assertLessEqual(set(gaps), allowed, speed)
        # control: the gaps really follow the speed (a fixed printer rate would give one set for both)
        slow = self.t.glyph_gaps(self.t.run(self.talk, "W200", 6)[0])
        fast = self.t.glyph_gaps(self.t.run(self.talk, "W200", 1)[0])
        self.assertGreater(min(slow), max(fast))

    def test_wait_holds_until_a_button(self):
        log, _ = self.t.run(self.talk, "W200", 1)
        codes = [(f, v) for f, k, v, _p in log if k == "code"]
        self.assertEqual([v for _f, v in codes[-2:]], [0xFA, 0xF7])  # <PROMPT>
        end = log[-1][0]
        self.assertEqual(log[-1][1:3], ("code", 0xF7))
        log2, _ = self.t.run(self.talk, "W200 A W80", 1)
        self.assertTrue(any(f > end for f, *_ in log2), "the text goes on after A")
        self.assertGreater(len(log2), len(log))

    def test_next_is_one_line_move_with_a_pause(self):
        log, _ = self.t.run(self.talk, "W200 A W120", 1)
        codes = [(f, v) for f, k, v, _p in log if k == "code"]
        pairs = [(codes[i], codes[i + 1]) for i in range(len(codes) - 1) if codes[i][1] == 0xEF]
        self.assertGreaterEqual(len(pairs), 2)
        for (f1, _a), (f2, b) in pairs:
            self.assertEqual(b, 0xEE)  # <NEXT_LINE> then <CLEAR_LINE>
            self.assertGreaterEqual(f2 - f1, 4)  # the scroll waits 4 frames

    def test_buf_prints_the_text_buffer(self):
        log, _ = self.t.run(self.battle, "A W30 A*30 W200 A*20 W100")
        ins = self.t.inserts(log, self.t.run.snaps)
        self.assertGreaterEqual(len(ins), 10)
        self.assertEqual([x for x in ins if x[1] != x[2]], [])
        self.assertEqual({x[0] for x in ins}, {0x00, 0x10})  # <BUF0> and <BUF1>
        # control: where the other slot holds a different text, the glyphs never match it
        differ = [x for x in ins if x[3] != x[1]]
        self.assertGreaterEqual(len(differ), 5)
        self.assertEqual([x for x in differ if x[3] == x[2]], [])


if __name__ == "__main__":
    unittest.main()
