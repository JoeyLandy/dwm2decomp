"""tools/sm83.py's serial model and tools/link_play.py (E-0406)."""
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import link_play  # noqa: E402
from sm83 import GameBoy  # noqa: E402

BLANK = bytes(0x8000)  # NOPs: the CPU runs on, nothing else happens


class Serial(unittest.TestCase):
    def pair(self):
        a, b = GameBoy(BLANK), GameBoy(BLANK)
        a.link, b.link = b, a
        return a, b

    def test_a_clocked_byte_swaps_with_a_waiting_partner(self):
        a, b = self.pair()
        b.wb(0xFF01, 0x42)
        b.wb(0xFF02, 0x80)  # waits on the external clock
        a.wb(0xFF01, 0x17)
        a.wb(0xFF02, 0x81)  # clocks it
        a.tick(4000)
        self.assertEqual(a.io[0x02] & 0x80, 0x80)  # 8 bits take 4,096 cycles
        a.tick(96)
        self.assertEqual((a.io[0x01], b.io[0x01]), (0x42, 0x17))
        self.assertEqual((a.io[0x02] & 0x80, b.io[0x02] & 0x80), (0, 0))
        self.assertEqual((a.io[0x0F] & 0x08, b.io[0x0F] & 0x08), (0x08, 0x08))

    def test_two_clocking_sides_exchange_once(self):
        a, b = self.pair()
        a.wb(0xFF01, 0x01)
        b.wb(0xFF01, 0x02)
        a.wb(0xFF02, 0x81)
        b.wb(0xFF02, 0x81)
        a.tick(4096)
        self.assertEqual((a.io[0x01], b.io[0x01]), (0x02, 0x01))
        self.assertIsNone(b.serial_left)  # the partner's transfer ended with it

    def test_nothing_waiting_reads_ff_and_no_cable_never_ends(self):
        a, b = self.pair()
        a.wb(0xFF01, 0x55)
        a.wb(0xFF02, 0x81)
        a.tick(4096)
        self.assertEqual(a.io[0x01], 0xFF)
        alone = GameBoy(BLANK)
        alone.wb(0xFF02, 0x81)
        alone.tick(100000)
        self.assertEqual(alone.io[0x02] & 0x80, 0x80)  # as before the serial model: observations stay comparable
        self.assertEqual(alone.io[0x0F] & 0x08, 0)

    def test_fast_clock_bit(self):
        a, b = self.pair()
        b.wb(0xFF02, 0x80)
        a.wb(0xFF02, 0x83)
        a.tick(128)
        self.assertEqual(a.io[0x02] & 0x80, 0)


class Runner(unittest.TestCase):
    def test_both_consoles_end_a_run_on_the_same_frame(self):
        a, b = GameBoy(BLANK), GameBoy(BLANK)
        link_play.run_pair(a, b, "W10", "W25 A2")
        self.assertEqual(a.cycles // link_play.FRAME, b.cycles // link_play.FRAME)
        self.assertGreaterEqual(a.cycles // link_play.FRAME, 37)

    def test_lines_and_shots_outside_build_are_refused(self):
        with self.assertRaises(SystemExit):
            link_play.main([str(ROOT / "tools/recipes/link_e0406_breeding.txt"), "--shots", str(ROOT / "docs")])


if __name__ == "__main__":
    unittest.main()
