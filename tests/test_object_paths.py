"""E-0358: boundary probes for the bank-$12 scripted paths on the reference ROM.

These execute the original instructions in tools/sm83.py. They establish observations
of that emulator, not hardware timing or which scene reaches these commands in play.
"""
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tests"))
from test_routine_behaviour import ROM, call  # noqa: E402

PARAM, STEP, PARTY = 0xC921, 0xC923, 0xC6FD
FOLLOWERS = 0xC8EF


@unittest.skipUnless(ROM.is_file(), "reference ROM not present")
class ObjectPaths(unittest.TestCase):
    def test_counter_finishes_on_equality_and_preserves_odd_phase(self):
        # This is the shared tail, without the curve read. Odd phases never reach $20.
        for start, expected, advanced in ((0, 2, False), (30, 0, True),
                                          (31, 33, False), (254, 0, False), (255, 1, False)):
            gb = call(0x12, 0x43C6, mem={PARAM: start, STEP: 0xFF})
            self.assertEqual(gb.rb(PARAM), expected)
            self.assertEqual(gb.rb(STEP), 0 if advanced else 0xFF)
        phase = 1
        for _ in range(128):
            gb = call(0x12, 0x43C6, mem={PARAM: phase, STEP: 7})
            self.assertEqual(gb.rb(STEP), 7)
            phase = gb.rb(PARAM)
        self.assertEqual(phase, 1)

    def test_hop_curve_wraps_coordinate_and_restores_calling_bank(self):
        # Predicted Y positions from the 16 signed deltas, starting at Y = 0.
        positions = [254, 253, 252, 252, 251, 251, 250, 250,
                     250, 251, 251, 252, 252, 253, 254, 0]
        y, phase, step = 0, 0, 7
        for i, expected in enumerate(positions):
            gb = call(0x12, 0x42B5, mem={0xC200: y, PARAM: phase, STEP: step}, d=0xC2, e=0)
            y, phase, step = gb.rb(0xC200), gb.rb(PARAM), gb.rb(STEP)
            self.assertEqual(y, expected)
            self.assertEqual((phase, step), (0, 8) if i == 15 else (2 * (i + 1), 7))
            self.assertEqual(gb.rombank, 0x12)
            self.assertEqual((gb.rb(0xC928), gb.rb(0xC929)), (0, 0xC2))

    def test_second_follower_finish_skips_third_hop_only_for_two_members(self):
        for party in (0, 1, 2, 3):
            for address, expected in ((0x424B, (19, 255, 19)),
                                      (0x4092, (20, 0, 21))):
                mem = {PARAM: 30, STEP: 9, PARTY: party,
                       FOLLOWERS + 6: 0, FOLLOWERS + 7: 17, FOLLOWERS + 12: 20}
                gb = call(0x12, address, mem=mem)
                self.assertEqual(tuple(gb.rb(FOLLOWERS + i) for i in (7, 6, 12)), expected)
                self.assertEqual(gb.rb(PARAM), 0)
                self.assertEqual(gb.rb(STEP), 11 if party == 2 else 10)

    def test_left_path_third_follower_uses_x_while_previous_stage_uses_y(self):
        gb = call(0x12, 0x4238, mem={PARAM: 0, STEP: 10,
                                   FOLLOWERS + 11: 0, FOLLOWERS + 12: 20})
        self.assertEqual((gb.rb(FOLLOWERS + 11), gb.rb(FOLLOWERS + 12)), (255, 18))
        self.assertEqual((gb.rb(PARAM), gb.rb(STEP)), (2, 10))

    def test_first_follower_finish_skips_remaining_hops_only_for_one_member(self):
        for party in (0, 1, 2, 3):
            for address, expected in ((0x426F, (255, 19, 19, 19)),
                                      (0x40B8, (0, 20, 21, 21))):
                mem = {PARAM: 30, STEP: 8, PARTY: party, FOLLOWERS + 1: 0,
                       FOLLOWERS + 2: 17, FOLLOWERS + 7: 20, FOLLOWERS + 12: 20}
                gb = call(0x12, address, mem=mem)
                self.assertEqual(tuple(gb.rb(FOLLOWERS + i) for i in (1, 2, 7, 12)), expected)
                self.assertEqual(gb.rb(PARAM), 0)
                self.assertEqual(gb.rb(STEP), 11 if party == 1 else 9)


if __name__ == "__main__":
    unittest.main()
