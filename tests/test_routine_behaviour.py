"""Behavioural checks of named ROM routines, run on tools/sm83.py against the reference ROM.

These back the `note` text in config/names.json for arithmetic routines (C1: our own emulator
executes the real instructions; it has not been checked against hardware). Skipped without the
reference ROM, which is kept out of the repository."""
import random
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
from sm83 import GameBoy  # noqa: E402

ROM = ROOT / "local/roms/dwm2-cobi-us.gbc"
RETURN = 0xC800  # sentinel return address in WRAM


class Done(Exception):
    pass


def call(bank: int, addr: int, mem=None, sram=None, **regs) -> GameBoy:
    """Run the routine at `addr` (bank mapped) with the given registers until it returns."""
    gb = GameBoy(ROM.read_bytes())
    gb.rombank = bank
    if sram:
        gb.ramen = True
        for offset, value in sram.items():
            gb.sram[offset] = value
    for address, value in (mem or {}).items():
        gb.wb(address, value)
    for name, value in regs.items():
        setattr(gb, name, value)
    gb.sp = 0xDFF0
    gb.wb(gb.sp, RETURN & 0xFF)
    gb.wb(gb.sp + 1, RETURN >> 8)
    gb.pc = addr

    def stop(_):
        raise Done

    gb.pc_hooks[RETURN] = stop
    try:
        gb.run(200000)
    except Done:
        pass
    else:
        raise AssertionError("routine did not return")
    return gb


@unittest.skipUnless(ROM.is_file(), "reference ROM not present")
class Arithmetic(unittest.TestCase):
    def test_multiply_a_by_bc_gives_24_bits_in_ehl(self):
        rng = random.Random(1)
        for _ in range(60):
            a, bc = rng.randrange(256), rng.randrange(65536)
            gb = call(0, 0x16AA, a=a, b=bc >> 8, c=bc & 0xFF)
            self.assertEqual((gb.e << 16) | (gb.h << 8) | gb.l, a * bc, (a, bc))

    def test_divide_b_by_a_gives_quotient_in_b_and_remainder_in_a(self):
        rng = random.Random(2)
        for _ in range(60):
            n, d = rng.randrange(256), rng.randrange(1, 256)
            gb = call(0, 0x16BF, a=d, b=n)
            self.assertEqual((gb.b, gb.a), divmod(n, d), (n, d))

    def test_divide_ehl_by_a_gives_24_bit_quotient_and_remainder_in_a(self):
        rng = random.Random(3)
        for _ in range(60):
            n, d = rng.randrange(1 << 24), rng.randrange(1, 256)
            gb = call(0, 0x16E2, a=d, e=n >> 16, h=(n >> 8) & 0xFF, l=n & 0xFF)
            self.assertEqual(((gb.e << 16) | (gb.h << 8) | gb.l, gb.a), divmod(n, d), (n, d))


@unittest.skipUnless(ROM.is_file(), "reference ROM not present")
class ClampedByteUpdates(unittest.TestCase):
    def test_add_b_to_byte_stops_at_c(self):
        for value in (0, 5, 10, 20, 100):
            for b in (0, 1, 3, 9, 30):
                for c in (1, 10, 15):
                    gb = call(0xF0, 0x7C51, {0xC000: value}, h=0xC0, l=0, b=b, c=c)
                    if value + b < 0x100:
                        self.assertEqual(gb.rb(0xC000), min(value + b, c), (value, b, c))

    def test_subtract_b_from_byte_stops_at_zero(self):
        for value in (0, 5, 10, 20, 100):
            for b in (0, 1, 3, 9, 30, 120):
                gb = call(0xF0, 0x7C5B, {0xC000: value}, h=0xC0, l=0, b=b)
                self.assertEqual(gb.rb(0xC000), max(value - b, 0), (value, b))


@unittest.skipUnless(ROM.is_file(), "reference ROM not present")
class LibraryRoutines(unittest.TestCase):
    """The notes in config/name_families.json, checked on the canonical copy and one other copy."""

    def test_add_double_a_to_hl(self):
        for bank, addr in ((0x36, 0x7E65), (0x32, 0x6826)):
            for a, hl in ((0, 0xC000), (5, 0xC000), (0x7F, 0xC0F0), (0x90, 0xC000)):
                gb = call(bank, addr, a=a, h=hl >> 8, l=hl & 0xFF)
                self.assertEqual((gb.h << 8) | gb.l, (hl + ((a * 2) & 0xFF)) & 0xFFFF, (bank, a, hl))

    def test_bg_map_address_at_scroll_both_encodings(self):
        for bank, addr in ((0x0C, 0x5156), (0x14, 0x6BCF)):
            for sx, sy in ((0, 0), (8, 8), (0xA3, 0x47), (0xFF, 0xFF)):
                gb = call(bank, addr, {0xFFA1: sx, 0xFFA5: sy})
                self.assertEqual((gb.h << 8) | gb.l, 0x9800 + (sy & 0xF8) * 4 + sx // 8, (bank, sx, sy))

    def test_store_b_at_word_table_entry_both_encodings(self):
        for bank, addr in ((0x0C, 0x525B), (0x1B, 0x6308)):
            mem = {0xC000 + 2 * i: 0x00 for i in range(8)}
            for i in range(4):
                mem[0xC000 + 2 * i] = (0xD000 + 16 * i) & 0xFF
                mem[0xC001 + 2 * i] = (0xD000 + 16 * i) >> 8
            gb = call(bank, addr, mem, a=2, b=0x5A, h=0xC0, l=0)
            self.assertEqual(gb.rb(0xD020), 0x5A)
            self.assertEqual(gb.b, 0x5A)

    def test_next_bg_map_column_wraps_inside_its_row(self):
        for hl in (0x9800, 0x981E, 0x981F, 0x9A3F, 0x9A20):
            gb = call(0, 0x304F, h=hl >> 8, l=hl & 0xFF)
            want = (hl & 0xFFE0) | ((hl + 1) & 0x1F)
            self.assertEqual((gb.h << 8) | gb.l, want, hex(hl))

    def test_add_word_at_hl_to_bc(self):
        gb = call(0x30, 0x4396, {0xC000: 0xFF, 0xC001: 0x01}, h=0xC0, l=0, b=0x10, c=0x01)
        self.assertEqual((gb.b << 8) | gb.c, 0x1100 + 0x0100)
        self.assertEqual((gb.h << 8) | gb.l, 0xC002)

    def test_bit_helpers(self):
        for addr, fn in ((0x7ED3, lambda v: v & 0xFB), (0x7EC4, lambda v: v | 0x02), (0x7EC9, lambda v: v & 0xFD)):
            for v in (0x00, 0xFF, 0x5A):
                gb = call(0x0F, addr, {0xC000: v}, h=0xC0, l=0)
                self.assertEqual(gb.rb(0xC000), fn(v), (hex(addr), v))

    def test_step_counter_wc921(self):
        gb = call(0x0F, 0x7EB2, {0xC921: 1}, b=3)
        self.assertEqual((gb.rb(0xC921), gb.f & 0x10), (2, 0))
        gb = call(0x0F, 0x7EB2, {0xC921: 2}, b=3)
        self.assertEqual((gb.rb(0xC921), gb.f & 0x10), (0, 0x10))


@unittest.skipUnless(ROM.is_file(), "reference ROM not present")
class DecimalRoutines(unittest.TestCase):
    def test_number24_to_packed_bcd(self):
        rng = random.Random(4)
        for n in (0, 9, 10, 99, 100, 12345, 999999, 1000000, 9999999) + tuple(rng.randrange(10_000_000) for _ in range(20)):
            gb = call(0, 0x173A, {0xC8C0: n & 0xFF, 0xC8C1: (n >> 8) & 0xFF, 0xC8C2: n >> 16})
            digits = f"{n:08d}"
            got = "".join(f"{gb.rb(a):02X}" for a in (0xFFC9, 0xFFC8, 0xFFC7, 0xFFC6))
            self.assertEqual(got[-7:], digits[-7:], n)  # hFFC9 holds the millions digit in its low nibble

    def test_write_decimal_digit_tiles(self):
        for digits, want in (((0, 0, 7), [0xC3, 0xC3, 0xE7]), ((1, 0, 5), [0xE1, 0xE0, 0xE5]), ((0, 3, 0), [0xC3, 0xE3, 0xE0])):
            mem = {0xC8C0 + i: d for i, d in enumerate(digits)}
            gb = call(0, 0x2123, mem, d=0xC0, e=0x00, h=0, l=0)
            self.assertEqual([gb.rb(0xC000 + i) for i in range(3)], want, digits)


@unittest.skipUnless(ROM.is_file(), "reference ROM not present")
class PersonalityIndex(unittest.TestCase):
    def test_index_combines_three_graded_record_bytes(self):
        def grade(v):
            return 0 if v >= 0xC0 else 1 if v >= 0x40 else 2
        for record in (0, 1, 3):
            base = record * 0xA5
            for b6f, b72, b70 in ((0xFF, 0xFF, 0xFF), (0x00, 0x00, 0x00), (0xC0, 0x40, 0x3F), (0x7F, 0xBF, 0x01), (0x40, 0xC0, 0xFF)):
                gb = call(0, 0x2391, sram={base + 0x6F: b6f, base + 0x72: b72, base + 0x70: b70}, a=record)
                self.assertEqual(gb.a, 9 * grade(b6f) + 3 * grade(b72) + grade(b70), (record, b6f, b72, b70))

    def test_every_index_from_0_to_26_is_reachable(self):
        seen = set()
        for v1 in (0xFF, 0x80, 0x00):
            for v2 in (0xFF, 0x80, 0x00):
                for v3 in (0xFF, 0x80, 0x00):
                    gb = call(0, 0x2391, sram={0x6F: v1, 0x72: v2, 0x70: v3}, a=0)
                    seen.add(gb.a)
        self.assertEqual(seen, set(range(27)))


class FamilyNamesAreApplied(unittest.TestCase):
    """Audit of the committed src/: each family in config/name_families.json names its copies."""

    def test_every_family_name_is_defined_in_the_source(self):
        import json
        import re
        text = "".join(f.read_text(encoding="utf-8") for f in (ROOT / "src/banks").glob("bank*.asm"))
        families = json.loads((ROOT / "config/name_families.json").read_text(encoding="utf-8"))["families"]
        self.assertGreater(len(families), 20)
        for fam in families:
            self.assertRegex(text, r"(?m)^" + re.escape(fam["name"]) + r"(_Bank[0-9A-F]{2}(_[0-9A-F]{4})?)?::",
                             fam["name"])

    def test_copies_share_the_note_and_differ_in_bank_suffix(self):
        import re
        text = "".join(f.read_text(encoding="utf-8") for f in (ROOT / "src/banks").glob("bank*.asm"))
        copies = re.findall(r"(?m)^AddDoubleAToHL_Bank[0-9A-F]{2}(?:_[0-9A-F]{4})?::", text)
        self.assertGreaterEqual(len(copies), 10)
        self.assertEqual(len(copies), len(set(copies)))


if __name__ == "__main__":
    unittest.main()
