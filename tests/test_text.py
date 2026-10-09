"""Tests for tools/gb_text.py: the charmap, run detection, rendering, and the generated source."""
import random
import re
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import gb_text as T  # noqa: E402


def encode(text: str) -> bytes:
    """Encode with the charmap, longest match first."""
    out, k = bytearray(), 0
    while k < len(text):
        for n in (2, 1):
            if text[k:k + n] in T.CHARMAP:
                out.append(T.CHARMAP[text[k:k + n]])
                k += n
                break
        else:
            raise ValueError(text[k])
    return bytes(out)


class Charmap(unittest.TestCase):
    def test_every_character_has_its_own_byte(self):
        self.assertEqual(len(set(T.CHARMAP.values())), len(T.CHARMAP))

    def test_known_values(self):
        self.assertEqual(encode("0Aa Z z"), bytes([0x00, 0x0A, 0x24, 0x90, 0x23, 0x90, 0x3D]))
        self.assertEqual(encode("don't"), bytes([0x27, 0x32, 0x31, 0x41]))

    def test_render_then_parse_returns_the_same_bytes(self):
        rng = random.Random(5)
        for _ in range(300):
            raw = bytes(rng.choice([rng.randrange(256), 0x90, 0xF7, 0xB5, 0x3E, rng.randrange(0x0A, 0x3E)])
                        for _ in range(rng.randrange(1, 120)))
            back = b"".join(T.parse(line) for line in T.render(raw))
            self.assertEqual(back, raw)

    def test_a_contraction_glyph_renders_as_text(self):
        self.assertEqual(T.render(encode("it's fine."))[0], '"it\'s fine."')

    def test_lines_break_after_end_of_message_codes(self):
        lines = T.render(encode("a") + bytes([0xF7]) + encode("b"))
        self.assertEqual(lines, ['"a", $F7', '"b"'])


class Detection(unittest.TestCase):
    PROSE = encode("The old tavern keeps a quiet corner where travellers rest, and the keeper "
                   "never asks questions about where they go next.")

    def test_prose_is_found(self):
        runs = T.find_text_runs(bytes(40) + self.PROSE + bytes(40))
        self.assertEqual(len(runs), 1)
        s, e = runs[0]
        self.assertGreaterEqual(e - s, len(self.PROSE) - 4)

    def test_random_bytes_contain_no_text(self):
        rng = random.Random(1)
        raw = bytes(rng.randrange(256) for _ in range(20000))
        self.assertEqual(T.find_text_runs(raw), [])

    def test_letter_range_data_without_spaces_is_not_text(self):
        rng = random.Random(2)
        raw = bytes(rng.randrange(0x0A, 0x3E) for _ in range(2000))
        self.assertEqual(T.find_text_runs(raw), [])

    def test_short_fragments_are_ignored(self):
        self.assertEqual(T.find_text_runs(encode("hi there") + bytes(30)), [])


REF = ROOT / "local" / "roms" / "dwm2-cobi-us.gbc"
BANKS = ROOT / "src" / "banks"


@unittest.skipUnless(REF.exists(), "reference ROM not present")
class RealRom(unittest.TestCase):
    def test_the_title_menu_text_is_in_the_rom(self):
        rom = REF.read_bytes()
        needle = bytes(T.CHARMAP[c] for c in "DRAGON") + bytes([0x90]) + bytes(T.CHARMAP[c] for c in "WARRIOR")
        self.assertIn(needle, rom)

    def test_detection_covers_a_large_prose_share_with_exact_round_trips(self):
        rom = REF.read_bytes()
        total = 0
        for b in range(0x80, 0x84):
            raw = rom[b * 0x4000:(b + 1) * 0x4000]
            for s, e in T.find_text_runs(raw):
                total += e - s
                self.assertEqual(b"".join(T.parse(l) for l in T.render(raw[s:e])), raw[s:e])
        self.assertGreater(total, 40000)


@unittest.skipUnless(BANKS.is_dir(), "src/banks has not been generated")
class GeneratedText(unittest.TestCase):
    def test_charmap_is_included_before_the_banks_and_defines_each_byte_once(self):
        main = (ROOT / "src" / "main.asm").read_text(encoding="utf-8").splitlines()
        self.assertLess(main.index('INCLUDE "charmap.inc"'), main.index('INCLUDE "banks/bank00.asm"'))
        codes = re.findall(r'^CHARMAP ".+", \$([0-9A-F]{2})$',
                           (ROOT / "src" / "charmap.inc").read_text(encoding="utf-8"), re.M)
        self.assertEqual(len(codes), len(set(codes)))

    def test_text_blocks_hold_string_lines(self):
        blocks = strings = 0
        for f in BANKS.glob("bank*.asm"):
            lines = f.read_text(encoding="utf-8").splitlines()
            for i, line in enumerate(lines):
                if line.startswith("; text (E-0024)"):
                    blocks += 1
                    self.assertTrue(lines[i + 1].startswith("    db "), f"{f.name}:{i + 2}")
                    strings += lines[i + 1].count('"') >= 2
        self.assertGreater(blocks, 3000)
        self.assertGreater(strings, 2500)


if __name__ == "__main__":
    unittest.main()
