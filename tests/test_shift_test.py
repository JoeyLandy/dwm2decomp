"""tools/shift_test.py and tools/hardcoded_refs.py: the M1 shiftability audit (E-0388)."""
import sys
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import hardcoded_refs  # noqa: E402
import shift_test  # noqa: E402

BANK05 = """SECTION "Bank 05", ROMX[$4000], BANK[$05]
BankNumber05::
    db $05
First::
    ld hl, Table
    ret
Table::
    db $01, $02
    ds $10, $00
Tail::
    db $03
    ds $20, $FF ; free space
"""
SYM = {"BankNumber05": (5, 0x4000), "First": (5, 0x4001), "Table": (5, 0x4005), "Tail": (5, 0x4017)}


class PadBank(unittest.TestCase):
    def test_pads_before_the_first_label_past_the_bank_number_and_shrinks_the_last_ds(self):
        text, label = shift_test.pad_bank(BANK05, 5, SYM, 3)
        lines = text.split("\n")
        self.assertEqual(label, "First")
        self.assertEqual(lines[lines.index("First::") - 1], f"    ds 3, $00 {shift_test.MARK}")
        self.assertIn("    ds $1D, $FF ; free space", lines)
        self.assertIn("    ds $10, $00", lines)  # an earlier ds is left alone

    def test_a_ds_used_up_exactly_is_removed(self):
        text, _ = shift_test.pad_bank(BANK05, 5, SYM, 0x20)
        self.assertNotIn("$FF ; free space", text)
        self.assertIn("; ds removed by shift_test", text)

    def test_a_ds_too_small_is_skipped_for_an_earlier_one_after_the_label(self):
        text, _ = shift_test.pad_bank(BANK05.replace("ds $20, $FF", "ds $02, $FF"), 5, SYM, 4)
        self.assertIn("    ds $C, $00", text)
        self.assertIn("ds $02, $FF", text)

    def test_no_room_and_no_label_raise(self):
        with self.assertRaises(ValueError):
            shift_test.pad_bank(BANK05, 5, SYM, 0x40)  # no ds that large
        with self.assertRaises(ValueError):
            shift_test.pad_bank(BANK05, 5, {"BankNumber05": (5, 0x4000)}, 1)  # nothing past $4000
        with self.assertRaises(ValueError):
            shift_test.pad_bank(BANK05, 5, {k: (6, a) for k, (_, a) in SYM.items()}, 1)  # labels of another bank

    def test_bank_00_keeps_everything_below_0150(self):
        text = 'SECTION "Bank 00", ROM0[$0000]\nRst00::\n    ret\nEntry::\n    nop\n    ds 4, $00\n'
        _, label = shift_test.pad_bank(text, 0, {"Rst00": (0, 0), "Entry": (0, 0x150)}, 1)
        self.assertEqual(label, "Entry")


class Frames(unittest.TestCase):
    def test_first_difference(self):
        self.assertIsNone(shift_test.first_difference(["a", "b"], ["a", "b"]))
        self.assertEqual(shift_test.first_difference(["a", "b", "c"], ["a", "x", "c"]), 1)
        self.assertEqual(shift_test.first_difference(["a", "b"], ["a"]), 1)  # a run that stopped early differs

    def test_a_crashing_rom_stops_early_and_so_differs(self):
        rom = bytes([0xD3]) * 0x8000  # $D3 is not an SM83 opcode: the CPU stops at $0100
        hashes = shift_test.frame_hashes(rom, 3)
        self.assertLess(len(hashes), 3)
        self.assertIsNotNone(shift_test.first_difference(["x"] * 3, hashes))

    def test_bad_arguments_are_refused(self):
        with self.assertRaises(SystemExit):
            shift_test.main(["--pad", "0", "--out", "build/shift_unit"])
        with self.assertRaises(SystemExit):
            shift_test.main(["--out", "elsewhere"])


class Inventory(unittest.TestCase):
    SRC = """SECTION "Bank 07", ROMX[$4000], BANK[$07]
Here::
    ld hl, $4002
    ld hl, $4003
    call $0200
    ld b, $09
    ld hl, Far
    rst $10
    ld b, $08
    ld hl, Far
    dw $4002, $1234
    dw $4003
    db $09
    dw Far
    db $02, $40
    db $03, $40
    db "text, $02, $40"
    ld de, $4100
    ld hl, $0876
    add $74
    ld l, a
    ld a, h
    adc $41
    add $10
    adc $00
    dw $4100, $4110, $ffff
    dw $4101, $4110
    dw $4100, Far
"""

    def test_each_kind_and_its_negatives(self):
        at = {(7, 0x4000), (7, 0x4002), (0, 0x0200), (9, 0x5000)}
        names = {"Here": (7, 0x4000), "Far": (9, 0x5000)}
        with tempfile.TemporaryDirectory() as d:
            (Path(d) / "engine").mkdir()
            (Path(d) / "engine/bank07_x.asm").write_text(self.SRC, encoding="utf-8")
            found = hardcoded_refs.scan(Path(d), names, at)
        lines = {k: [r[2] for r in v] for k, v in found.items()}
        self.assertEqual(lines["code_address"], [3, 5])  # $4003 and a mismatched bank are not labels
        self.assertEqual(lines["code_bank"], [6])  # ld b, $08 is not Far's bank
        self.assertEqual(lines["data_word"], [11])
        self.assertEqual(lines["data_bank"], [13])
        self.assertEqual(lines["data_pair"], [15])  # $4003 has no label, and a string is not bytes
        self.assertEqual(lines["code_number"], [3, 4, 18])  # not $0876: a bank-$00 number may be a message id
        self.assertEqual(lines["code_split"], [20])  # $0010 is below the ROM window
        self.assertEqual(lines["data_tiles"], [26, 26])  # one per address; unaligned or mixed lines are not lists

    def test_a_label_in_another_switchable_bank_is_not_matched(self):
        self.assertFalse(hardcoded_refs.is_label_at({(9, 0x5000)}, 7, 0x5000))
        self.assertTrue(hardcoded_refs.is_label_at({(0, 0x0200)}, 7, 0x0200))
        self.assertFalse(hardcoded_refs.is_label_at({(0, 0x0100)}, 7, 0x0100))  # the header and vectors


if __name__ == "__main__":
    unittest.main()
