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
        # E-0419: a farcall or a literal `ld b, $06` beside a load no longer names its bank; only BANK(label) does
        self.assertEqual([w.split(": ", 1)[1] for w in warnings], ["ld hl, There points into bank 06",
                                                                   "ld hl, Far points into bank 06",
                                                                   "ld de, Other points into bank 07"])
        with tempfile.TemporaryDirectory() as d:
            (Path(d) / "engine").mkdir()
            (Path(d) / "engine/bank05_x.asm").write_text(self.SRC.replace("ld b, $06", "ld b, BANK(Far)"),
                                                         encoding="utf-8")
            _errors, warnings = bank_check.check(Path(d), self.SYM)
        self.assertNotIn("ld hl, Far points into bank 06", [w.split(": ", 1)[1] for w in warnings])

    def test_bank_00_jumps_are_not_checked_but_its_pointer_loads_are(self):
        """Home code calls into the bank it has mapped; its pointer loads into a switchable bank are checked like any
        other bank's (E-0419: twelve were tied to a bank by a number, with no ASSERT)."""
        with tempfile.TemporaryDirectory() as d:
            (Path(d) / "home").mkdir()
            (Path(d) / "home/bank00_x.asm").write_text(self.SRC.replace("Bank 05", "Bank 00").replace("Here", "Zero"),
                                                       encoding="utf-8")
            errors, warnings = bank_check.check(Path(d), dict(self.SYM, Zero=(0, 0x0150)))
        self.assertEqual(errors, [])
        self.assertEqual([w.split(": ", 1)[1] for w in warnings], ["ld hl, There points into bank 06",
                                                                   "ld hl, Far points into bank 06",
                                                                   "ld de, Mine points into bank 05",
                                                                   "ld de, Other points into bank 07"])


class FixedBanks(unittest.TestCase):
    """E-0401: pointer loads into another bank, read with that bank mapped by the reader, carry a link-time ASSERT."""
    BODIES = {
        0x10: "Script_X::\n    db 1\n",
        0x04: "Talk::\n    ld hl, Script_X\n    call StartScript\n    ret\n\n\n\nOther::\n    ld de, Near\n    ret\n"
              "Near::\n    db 2\n",
        0x05: "Far::\n    ld b, $10\n    ld hl, Script_X\n    rst $10\n",
        0x00: "Home::\n    ld hl, Script_X\n    ret\n",
    }

    def test_only_unbanked_loads_into_other_switchable_banks_are_asserted(self):
        out, n = present.assert_fixed_banks(self.BODIES)
        self.assertEqual(n, 3)
        self.assertIn('    ld hl, Script_X\n    ASSERT BANK(Script_X) == $10, "Script_X is read with bank $10 mapped"',
                      out[0x04])
        self.assertNotIn("ASSERT", out[0x04].split("Other::")[1])  # its own bank
        # E-0419: a literal `ld b, $10` beside the load no longer names its bank, and the home bank's loads are
        # asserted too (its code maps a bank by number); E-0401 had left both unasserted
        self.assertIn("ASSERT BANK(Script_X) == $10", out[0x05])
        self.assertIn("ASSERT BANK(Script_X) == $10", out[0x00])
        named = {**self.BODIES, 0x05: "Far::\n    ld b, BANK(Script_X)\n    ld hl, Script_X\n    rst $10\n",
                                     0x00: "Home::\n    ld a, BANK(Script_X)\n    ld [rROMB0], a\n    ld hl, Script_X\n"
                                           "    ret\n"}
        out, n = present.assert_fixed_banks(named)
        self.assertEqual((out[0x05], out[0x00]), (named[0x05], named[0x00]))  # BANK(label) beside it

    def test_an_asserted_load_is_counted_not_warned(self):
        src = 'Here::\n    ld de, Other\n    ASSERT BANK(Other) == $07, "Other is read with bank $07 mapped"\n'
        with tempfile.TemporaryDirectory() as d:
            (Path(d) / "engine").mkdir()
            (Path(d) / "engine/bank05_x.asm").write_text(src, encoding="utf-8")
            asserted: list[str] = []
            errors, warnings = bank_check.check(Path(d), {"Here": (5, 0x4000), "Other": (7, 0x5000)}, asserted)
        self.assertEqual((errors, warnings, len(asserted)), ([], [], 1))

    def test_a_later_bank_of_the_same_label_names_it(self):
        """H4 (E-0414): `ld b, BANK(Other)` later in the same straight-line code names the bank; a BANK() of another
        label, or one after a call, does not."""
        cases = {
            "ok": "Here::\n    ld de, Other\n    add hl, de\n    ld e, l\n    ld b, BANK(Other)\n    call ReadIt\n",
            # past the older three-line window, so only the new rule could accept it
            "other": "Here::\n    ld de, Other\n    nop\n    nop\n    nop\n    ld b, BANK(Elsewhere)\n    call ReadIt\n",
            "after_call": "Here::\n    ld de, Other\n    call Something\n    nop\n    nop\n    ld b, BANK(Other)\n",
        }
        got = {}
        for key, src in cases.items():
            with tempfile.TemporaryDirectory() as d:
                (Path(d) / "engine").mkdir()
                (Path(d) / "engine/bank05_x.asm").write_text(src, encoding="utf-8")
                _e, warnings = bank_check.check(Path(d), {"Here": (5, 0x4000), "Other": (7, 0x5000)})
                got[key] = len(warnings)
        self.assertEqual(got, {"ok": 0, "other": 1, "after_call": 1})

    def test_a_bank_by_number_for_a_reader_is_reported(self):
        """E-0420: a number stored in wDataBank, or passed in B to a bank copy, is reported; BANK(Label) is not, nor
        an `ld a` or `ld b` that no such reader takes."""
        cases = {
            "data_bank": "Here::\n    ld a, $09\n    ld [wDataBank], a\n    ret\n",
            "copy": "Here::\n    ld b, $1f\n    ld c, $10\n    call CopyFromBankWaitVRAM\n    ret\n",
            "named": "Here::\n    ld a, BANK(Other)\n    ld [wDataBank], a\n    ld b, BANK(Other)\n"
                     "    call CopyFromBankWaitVRAM\n",
            "unrelated": "Here::\n    ld a, $09\n    ld [wOther], a\n    ld b, $10\n    call Elsewhere\n",
        }
        got = {}
        for key, src in cases.items():
            with tempfile.TemporaryDirectory() as d:
                (Path(d) / "engine").mkdir()
                (Path(d) / "engine/bank05_x.asm").write_text(src, encoding="utf-8")
                literal: list[str] = []
                bank_check.check(Path(d), {"Here": (5, 0x4000), "Other": (7, 0x5000)}, literal=literal)
                got[key] = len(literal)
        self.assertEqual(got, {"data_bank": 1, "copy": 1, "named": 0, "unrelated": 0})

    def test_a_script_jump_into_another_bank_is_an_error(self):
        """E-0422: script sections that jump to each other must stay in one bank."""
        src = "Here::\n    script_jump Other\n    script_skip_if_no Near\nNear::\n    script_end\n"
        with tempfile.TemporaryDirectory() as d:
            (Path(d) / "engine").mkdir()
            (Path(d) / "engine/bank05_x.asm").write_text(src, encoding="utf-8")
            errors, _w = bank_check.check(Path(d), {"Here": (5, 0x4000), "Near": (5, 0x4005), "Other": (7, 0x5000)})
        self.assertEqual(len(errors), 1)
        self.assertIn("jumps to bank 07", errors[0])

    def test_the_source_has_no_unasserted_fixed_bank_load(self):
        syms = sorted(ROOT.glob("build/run*/dwm2.sym"), key=lambda q: q.stat().st_mtime)
        if not syms:
            self.skipTest("no build")
        asserted: list[str] = []
        literal: list[str] = []
        unread: list[str] = []
        errors, warnings = bank_check.check(ROOT / "src", bank_check.load_sym(syms[-1]), asserted, literal, unread)
        self.assertEqual((errors, warnings, literal), ([], [], []))
        self.assertGreater(len(asserted), 400)
        # E-0420, E-0422: GreatLogTalkEvents_Breeder's wDataBank = $0E, which nothing reads (tools/sm83.py)
        self.assertEqual([x.split()[1] for x in unread], ["GreatLogTalkEvents_Breeder"])


if __name__ == "__main__":
    unittest.main()
