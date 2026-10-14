"""E-0359: arena scene boundary probes against the original ROM in tools/sm83.py.

Direct calls, default WRAM bank 1 and disabled interrupts; these are observations
of the project's emulator, not a full arena playthrough or hardware validation.
"""
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'tests'))
from test_routine_behaviour import ROM, call  # noqa: E402

PARAM, PARAM1, STEP, INDEX, GROUP, STATE = range(0xC921, 0xC927)
RANK, FLAGS, CAPACITY = 0xC82C, 0xC94A, 0xD7FF
SLOTS, SLOT_COUNT = 0xCB7F, 0xCB7D
PLAYER_X, PLAYER_Y, FACING, PLAYER_FLAGS = 0xFF8E, 0xFF91, 0xFF98, 0xFF8C
FOLLOWERS, FIELD_KIND, DRAW = 0xC8EF, 0xC90D, 0xFF8D
ROUND, USAGE, FOES, AREA = 0xD588, 0xD589, 0xD5B1, 0xD7FC
ENCOUNTER_KIND = 0xCFDC


def offset(bank, address):
    return bank * 0x4000 + address - 0x4000


@unittest.skipUnless(ROM.is_file(), 'reference ROM not present')
class ArenaScene(unittest.TestCase):
    def test_message_table_reads_low_byte_and_preserves_group(self):
        rom = ROM.read_bytes()
        for rank in range(5):
            for column in range(8):
                for flags in (0, 0x80):
                    row = 5 if flags & 0x80 else rank
                    expected = rom[offset(0x12, 0x48B9) + 16 * row + 2 * column]
                    gb = call(0x12, 0x488B, mem={RANK: rank, FLAGS: flags, GROUP: 0xC4, STATE: 3}, a=column)
                    self.assertEqual((gb.rb(INDEX), gb.rb(GROUP), gb.rb(STATE)), (expected, 0xC4, 0))
        # SLA wraps rather than multiplying in an unbounded integer, and SWAP
        # rotates nibbles rather than multiplying arbitrary ranks by sixteen.
        self.assertEqual(call(0x12, 0x488B, mem={RANK: 0, FLAGS: 0}, a=0x80).rb(INDEX), 0x40)
        self.assertEqual(call(0x12, 0x488B, mem={RANK: 0x10, FLAGS: 0}, a=0).rb(INDEX), 0)

    def test_object_arrival_timer_and_negative_y_wrap(self):
        for timer, count, expected_count in ((0x0F, 1, 2), (0x1F, 2, 3), (0x2F, 3, 4), (0x60, 4, 4)):
            mem = {INDEX: timer, STEP: 8, SLOT_COUNT: count}
            for i in range(4):
                mem[SLOTS + 16 * i + 12] = 0xFF
                mem[SLOTS + 16 * i + 11] = 0x50
            gb = call(0x12, 0x461A, mem=mem)
            self.assertEqual(gb.rb(INDEX), timer if timer == 0x60 else timer + 1)
            self.assertEqual(gb.rb(SLOT_COUNT), expected_count)
            self.assertEqual(gb.rb(STEP), 8)
            self.assertEqual([gb.rb(SLOTS + 16 * i + 12) for i in range(4)], [0] * 4)

    def test_object_arrival_can_advance_step_once_per_object_in_one_call(self):
        for arrivals in (1, 4):
            mem = {INDEX: 0x60, STEP: 8, SLOT_COUNT: 1}
            for i in range(4):
                mem[SLOTS + 16 * i + 12] = 0x40
                mem[SLOTS + 16 * i + 11] = 0x6F if i < arrivals else 0x70
            gb = call(0x12, 0x461A, mem=mem)
            self.assertEqual(gb.rb(STEP), 8 + arrivals)
            # All four slots move, even though only one is currently drawable.
            self.assertEqual([gb.rb(SLOTS + 16 * i + 11) for i in range(4)],
                             [0x70 if i < arrivals else 0x71 for i in range(4)])

    def test_player_route_advances_legs_and_restores_saved_field_kind(self):
        cases = ((0, 0x40, 0x1F, 0x40, 0x20), (1, 0x31, 0x20, 0x30, 0x20),
                 (2, 0x30, 0x3F, 0x30, 0x40), (3, 0x21, 0x40, 0x20, 0x40),
                 (4, 0x20, 0x31, 0x20, 0x30))
        for phase, x, y, nx, ny in cases:
            mem = {PARAM: phase, PARAM1: 7, INDEX: 0x60, STEP: 2,
                   PLAYER_X: x, PLAYER_Y: y, PLAYER_FLAGS: 0x20, FIELD_KIND: 0, RANK: 0, FLAGS: 0}
            gb = call(0x12, 0x474A, mem=mem)
            self.assertEqual((gb.rb(PLAYER_X), gb.rb(PLAYER_Y)), (nx, ny))
            if phase < 4:
                self.assertEqual((gb.rb(PARAM), gb.rb(STEP)), (phase + 1, 2))
            else:
                self.assertEqual((gb.rb(PARAM), gb.rb(PARAM1), gb.rb(STEP)), (0, 0, 3))
                self.assertEqual((gb.rb(FIELD_KIND), gb.rb(FACING), gb.rb(PLAYER_FLAGS)), (7, 1, 0x20))
                self.assertEqual([gb.rb(FOLLOWERS + i) for i in (0, 5, 10)], [1] * 3)
                self.assertEqual((gb.rb(INDEX), gb.rb(STATE)), (0x13, 0))
            self.assertEqual(gb.rombank, 0x12)

    def test_after_first_battle_uses_exact_counter_condition_and_still_prepares_foes(self):
        for capacity, step, message in ((3, 22, 0x20), (2, 6, 0x19), (0, 6, 0x19)):
            mem = {CAPACITY: capacity, STEP: 5, FLAGS: 0x80, GROUP: 0x84, ROUND: 0, AREA: 3}
            gb = call(0x12, 0x444D, mem=mem)
            self.assertEqual((gb.rb(CAPACITY), gb.rb(STEP), gb.rb(INDEX)),
                             ((capacity - 1) & 0xFF, step, message))
            self.assertEqual((gb.rb(ROUND), gb.rb(0xC903), gb.rb(ENCOUNTER_KIND)), (1, 4, 2))
            self.assertEqual(gb.rb(GROUP), 0x84)
            self.assertEqual(gb.rombank, 0x12)

    def test_round_helpers_wrap_counts_and_reuse_the_arena_class(self):
        for value in (0, 2, 255):
            gb = call(0x0C, 0x703D, mem={ROUND: value, AREA: 5})
            self.assertEqual((gb.rb(ROUND), gb.rb(0xD78C)), ((value + 1) & 255, 5))
            gb = call(0x0C, 0x704B, mem={CAPACITY: value, AREA: 4})
            self.assertEqual((gb.rb(CAPACITY), gb.rb(0xD78E), gb.rb(0xD786)),
                             ((value + 1) & 255, (value + 1) & 255, 4))

    def test_random_builder_fills_individual_foes_only_in_remaining_rounds(self):
        rom = ROM.read_bytes()
        for area in range(6):
            p = offset(0x0C, 0x7905) + 2 * area
            start = offset(0x0C, rom[p] | rom[p + 1] << 8)
            allowed = {rom[start + 2 * i] | rom[start + 2 * i + 1] << 8 for i in range(39)}
            for first_round in range(3):
                mem = {ROUND: first_round, AREA: area}
                mem.update({FOES + i: 0xA5 for i in range(18)})
                mem.update({USAGE + i: 0xFF for i in range(40)})
                gb = call(0x0C, 0x7326, mem=mem)
                self.assertEqual([gb.rb(FOES + i) for i in range(6 * first_round)], [0xA5] * (6 * first_round))
                chosen = [gb.rb(FOES + i) | gb.rb(FOES + i + 1) << 8 for i in range(6 * first_round, 18, 2)]
                self.assertTrue(set(chosen) <= allowed)
                usage = [gb.rb(USAGE + i) for i in range(40)]
                self.assertEqual(sum(usage), 3 * (3 - first_round))
                self.assertLessEqual(max(usage), 3)
                self.assertEqual(usage[39], 0)

    def test_party_heal_follows_record_indexes_and_uses_selected_sram_bank(self):
        for indexes, bank in (((2,), 0), ((2, 5, 7), 0), ((2,), 1)):
            mem = {0xC6FD: len(indexes)} | {0xC6FE + i: n for i, n in enumerate(indexes)}
            sram = {bank * 0x2000: 0xA5}
            for i, n in enumerate(indexes):
                base = bank * 0x2000 + n * 0xA5
                for field, value in ((0x5D, 0x234 + i), (0x61, 0x351 + i)):
                    sram[base + field] = value & 255
                    sram[base + field + 1] = value >> 8
                sram[base + 0x55] = 0xFF
            gb = call(0x12, 0x64F8, mem=mem, sram=sram, rambank=bank)
            for i, n in enumerate(indexes):
                base = bank * 0x2000 + n * 0xA5
                hp = gb.sram[base + 0x5B] | gb.sram[base + 0x5C] << 8
                mp = gb.sram[base + 0x5F] | gb.sram[base + 0x60] << 8
                self.assertEqual((hp, mp, gb.sram[base + 0x55]), (0x234 + i, 0x351 + i, 0))
            self.assertEqual(gb.sram[bank * 0x2000], 0xA5)
            self.assertFalse(gb.ramen)
            self.assertEqual(gb.rambank, bank)


if __name__ == '__main__':
    unittest.main()
