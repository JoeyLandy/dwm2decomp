"""E-0393: floating sections, src/layout.link, the bank check and section moves (M2)."""
import sys
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import bank_check  # noqa: E402
import move_section  # noqa: E402
import present  # noqa: E402

BANK = """SECTION "Bank 05", ROMX[$4000], BANK[$05]
First::
    ld a, 1
    ret z
Second::
    ret

; note on Third
Third::
    jp First
Fourth::
    db $01
Fifth::
    jr .x
.x:
    ret
Sixth::
    ds $10, $00"""


class Split(unittest.TestCase):
    def test_sections_start_after_unconditional_ends_only(self):
        text, names = present.split_sections(BANK, 5)
        self.assertEqual(names, ["Bank 05", "Bank 05 Third", "Bank 05 Fourth", "Bank 05 Sixth"])
        self.assertTrue(text.startswith('SECTION "Bank 05", ROMX\n'))  # floating: the layout places it
        lines = text.split("\n")
        k = lines.index('SECTION "Bank 05 Third", ROMX')
        self.assertEqual(lines[k + 1:k + 4], ["", "; note on Third", "Third::"])  # the comment stays with Third
        self.assertNotIn('SECTION "Bank 05 Second", ROMX', lines)  # `ret z` runs on into Second
        self.assertNotIn('SECTION "Bank 05 Fifth", ROMX', lines)  # data before it is not an end of flow

    def test_bank_00_is_rom0_and_the_layout_pins_the_header(self):
        _, names = present.split_sections('SECTION "Bank 00", ROM0[$0000]\nA::\n    ret\nCartridgeHeader::\n    db 0', 0)
        layout = present.layout_text({0: names, 1: ["Bank 01"]})
        self.assertIn('ROM0\n\t"Bank 00"\n\tORG $0104\n\t"Bank 00 CartridgeHeader"\nROMX $01\n\t"Bank 01"', layout)


class Move(unittest.TestCase):
    LAYOUT = 'ROM0\n\t"Bank 00"\nROMX $01\n\t"Bank 01"\n\t"Bank 01 A"\n\t"Bank 01 Tail"\nROMX $02\n\t"Bank 02"\n\t"Bank 02 B"'

    def test_a_section_goes_before_the_last_section_of_its_new_bank(self):
        out = move_section.move(self.LAYOUT, "Bank 02 B", 1)
        self.assertIn('\t"Bank 01 A"\n\t"Bank 02 B"\n\t"Bank 01 Tail"', out)
        self.assertNotIn('ROMX $02\n\t"Bank 02"\n\t"Bank 02 B"', out)

    def test_unknown_sections_and_banks_are_refused(self):
        with self.assertRaises(ValueError):
            move_section.move(self.LAYOUT, "Bank 09 Nope", 1)
        with self.assertRaises(ValueError):
            move_section.move(self.LAYOUT, "Bank 02 B", 3)


class BankCheck(unittest.TestCase):
    SRC = """SECTION "Bank 05", ROMX
Here::
    call There
    farcall There
    ld hl, There
    ld b, $06
    ld hl, Far
    call Home
    ld de, Mine
    ld de, Other
"""
    SYM = {"Here": (5, 0x4000), "There": (6, 0x4100), "Far": (6, 0x4200), "Home": (0, 0x0200),
           "Mine": (5, 0x4300), "Other": (7, 0x5000)}

    def test_cross_bank_jumps_are_errors_and_unbanked_pointers_warnings(self):
        with tempfile.TemporaryDirectory() as d:
            (Path(d) / "engine").mkdir()
            (Path(d) / "engine/bank05_x.asm").write_text(self.SRC, encoding="utf-8")
            errors, warnings = bank_check.check(Path(d), self.SYM)
        self.assertEqual(len(errors), 1)
        self.assertIn("call There reaches bank 06", errors[0])
        # ld hl, There and ld hl, Far have a bank (farcall, ld b) beside them; ld de, Other has none in reach
        self.assertEqual([w.split(": ", 1)[1] for w in warnings], ["ld de, Other points into bank 07"])

    def test_bank_00_code_is_not_checked(self):
        with tempfile.TemporaryDirectory() as d:
            (Path(d) / "home").mkdir()
            (Path(d) / "home/bank00_x.asm").write_text(self.SRC.replace("Bank 05", "Bank 00").replace("Here", "Zero"),
                                                       encoding="utf-8")
            errors, warnings = bank_check.check(Path(d), dict(self.SYM, Zero=(0, 0x0150)))
        self.assertEqual((errors, warnings), ([], []))


if __name__ == "__main__":
    unittest.main()
