"""Synthetic cases for the monotone pointer-table rule in tools/disasm_all.py (no real ROM)."""
import struct
import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "tools"))
import disasm_all  # noqa: E402

BANK = disasm_all.BANK
disasm_all._QUIET = True


def table_at(offset: int, words: list[int], stride: int = 2) -> dict[int, int]:
    """Run structure_data on a 2-bank ROM whose bank 1 holds `words` at CPU address `offset`."""
    data = bytearray(2 * BANK)
    data[0] = 0xC9  # bank 0 must not be all zero
    data[BANK] = 0x01  # bank id byte
    for i, w in enumerate(words):
        pos = BANK + (offset - 0x4000) + i * stride
        data[pos:pos + 2] = struct.pack("<H", w)
    rom = disasm_all.Rom(bytes(data))
    rom.structure_data()
    return rom.dtab[1]


class MonotoneTables(unittest.TestCase):
    def test_plain_table_is_found(self):
        words = [0x4100 + 8 * i for i in range(10)]  # targets after the table
        self.assertEqual(sorted(table_at(0x4010, words)), [0x4010 + 2 * i for i in range(10)])

    def test_self_pointing_table_is_found(self):
        # Multi-level index: the first targets lie inside the table (0x4018 < 0x4010 + 20).
        words = [0x4018, 0x401C, 0x4020, 0x4120, 0x4130, 0x4140, 0x4150, 0x4160, 0x4170, 0x4180]
        self.assertEqual(len(table_at(0x4010, words)), 10)

    def test_a_trailing_word_on_the_tables_own_target_is_data(self):
        # E-0301: the 11th word sits at 0x4024, the first target, and only continues the run by chance
        words = [0x4024 + 0x10 * i for i in range(10)] + [0x5D79]
        dt = table_at(0x4010, words)
        self.assertEqual(sorted(dt), [0x4010 + 2 * i for i in range(10)])

    def test_pointing_before_the_table_is_rejected(self):
        words = [0x4020 + 8 * i for i in range(10)]  # all targets precede the table at 0x4100
        self.assertEqual(table_at(0x4100, words), {})

    def test_too_short_is_rejected(self):
        self.assertEqual(table_at(0x4010, [0x4100 + 8 * i for i in range(7)]), {})

    def test_constant_run_is_rejected(self):
        self.assertEqual(table_at(0x4010, [0x4100] * 12), {})

    def test_decreasing_values_break_the_chain(self):
        words = [0x4100 + 8 * i for i in range(5)] + [0x4100 - 8 * i for i in range(1, 5)]
        self.assertEqual(table_at(0x4010, words), {})

    def test_three_byte_records(self):
        # far-pointer style records: bank byte then pointer (stride 3, pointer at +1).
        data = bytearray(2 * BANK)
        data[0] = 0xC9
        data[BANK] = 0x01
        for i in range(10):
            pos = BANK + 0x10 + 3 * i
            data[pos] = 0x01
            data[pos + 1:pos + 3] = struct.pack("<H", 0x4100 + 16 * i)
        rom = disasm_all.Rom(bytes(data))
        rom.structure_data()
        self.assertEqual(len(rom.dtab[1]), 10)


if __name__ == "__main__":
    unittest.main()
