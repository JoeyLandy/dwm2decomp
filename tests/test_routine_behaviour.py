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


class SkillTableSource(unittest.TestCase):
    """Audit of the committed src/: the skill table keeps every byte of its 17-byte records."""

    def test_175_records_of_17_bytes(self):
        import re
        text = (ROOT / "src/banks/bank1a.asm").read_text(encoding="utf-8")
        rows = re.findall(r"^    db ((?:\$[0-9A-F]{2}(?:, )?)+) ; id (\d+)$", text, re.M)
        self.assertEqual([int(i) for _, i in rows], list(range(175)))
        self.assertTrue(all(len(v.split(", ")) == 17 for v, _ in rows))

    @unittest.skipUnless(ROM.is_file(), "reference ROM not present")
    def test_rows_equal_the_rom_bytes(self):
        import re
        text = (ROOT / "src/banks/bank1a.asm").read_text(encoding="utf-8")
        rows = re.findall(r"^    db ((?:\$[0-9A-F]{2}(?:, )?)+) ; id (\d+)$", text, re.M)
        rom = ROM.read_bytes()
        for values, ident in rows[:175]:
            at = 0x1A * 0x4000 + 0x40D4 - 0x4000 + 17 * int(ident)
            self.assertEqual(bytes(int(v[1:], 16) for v in values.split(", ")), rom[at:at + 17], ident)


class StreamSources(unittest.TestCase):
    """Audit of the committed src/ and config/: the extra stream sources (E-0035) are used."""

    def test_asset_pack_banks_carry_stream_labels(self):
        import re
        for bank, minimum in (("7d", 80), ("20", 70), ("74", 50)):
            text = (ROOT / f"src/banks/bank{bank}.asm").read_text(encoding="utf-8")
            self.assertGreaterEqual(len(re.findall(r"^; LZSS-compressed asset", text, re.M)), minimum, bank)

    def test_chains_skip_the_monster_table(self):
        import json
        chains = json.loads((ROOT / "config/stream_chains.json").read_text(encoding="utf-8"))["chains"]
        text = (ROOT / "src/banks/bank34.asm").read_text(encoding="utf-8")
        self.assertIn("MonsterTable::", text)
        self.assertNotRegex(text.split("MonsterTable::")[1][:200000], r"LZSS-compressed asset")
        self.assertTrue(all(count >= 6 for runs in chains.values() for _, count in runs))


class DispatchCases(unittest.TestCase):
    """Audit of the committed src/: jump-table targets carry Parent_CaseNN names (E-0040)."""

    def test_cases_are_named_after_their_table_owner(self):
        import re
        text = "".join(f.read_text(encoding="utf-8") for f in (ROOT / "src/banks").glob("bank*.asm"))
        cases = re.findall(r"^(\w+)_Case([0-9A-F]{2})::", text, re.M)
        self.assertGreater(len(cases), 4000)
        self.assertIn("RunGameModeInit", {p for p, _ in cases})
        self.assertEqual(len(re.findall(r"^\w+_Case[0-9A-F]{2}::", text, re.M)),
                         len(set(re.findall(r"^(\w+_Case[0-9A-F]{2})::", text, re.M))))


@unittest.skipUnless(ROM.is_file(), "reference ROM not present")
class RandomAndDivision(unittest.TestCase):
    def test_divide_hl_by_bc(self):
        rng = random.Random(5)
        for _ in range(40):
            n, d = rng.randrange(65536), rng.randrange(1, 65536)
            gb = call(0, 0x3F04, h=n >> 8, l=n & 0xFF, b=d >> 8, c=d & 0xFF)
            self.assertEqual(((gb.h << 8) | gb.l, (gb.b << 8) | gb.c), divmod(n, d), (n, d))

    def test_random_in_range_stays_inside_and_uses_the_table(self):
        rng = random.Random(6)
        seen = set()
        for _ in range(60):
            lo = rng.randrange(0, 500)
            hi = lo + rng.randrange(0, 300)
            gb = call(0, 0x3E98, {0xC5E8: rng.randrange(128), 0xC58A: 0}, h=lo >> 8, l=lo & 0xFF, b=hi >> 8, c=hi & 0xFF)
            got = (gb.d << 8) | gb.e
            self.assertTrue(lo <= got <= hi, (lo, hi, got))
            seen.add(got - lo)
        self.assertGreater(len(seen), 10)

    def test_equal_bounds_return_the_bound(self):
        gb = call(0, 0x3E98, h=0, l=7, b=0, c=7)
        self.assertEqual((gb.d << 8) | gb.e, 7)


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


def skill_cost(rom: bytes, number: int) -> int:
    """Byte 0 of the 17-byte record at SkillTable ($40D4, bank $1A) + 17 * number."""
    return rom[0x1A * 0x4000 + 0xD4 + 17 * number]


@unittest.skipUnless(ROM.is_file(), "reference ROM not present")
class BattleSkillCost(unittest.TestCase):
    """Byte 0 of a skill record is read as a cost against the actor's MP (E-0048; C2 on our emulator)."""

    def test_affordable_list_keeps_skills_costing_less_than_mp(self):
        rom = ROM.read_bytes()
        numbers = list(range(1, 9))
        for mp in (0, 1, 2, 3, 5, 10, 40):
            mem = {0xD8A4: 0, 0xD8DF: mp, 0xD8E0: 0}
            for slot, number in enumerate(numbers):
                mem[0xC0A0 + slot] = number
            gb = call(0x30, 0x5129, mem=mem)
            kept = [gb.rb(0xC0A0 + slot) for slot in range(8)]
            expected = [n if skill_cost(rom, n) < mp else 0xFF for n in numbers]
            self.assertEqual(kept, expected, f"MP {mp}")

    def test_mp_check_refuses_only_when_cost_exceeds_mp(self):
        cases = [(2, 10, True), (10, 10, True), (6, 4, False), (11, 10, False)]
        for cost, mp, allowed in cases:
            mem = {0xD8A4: 0, 0xD8A6: 0x10, 0xFFC8: cost, 0xCFEE: cost,
                   0xD8DF: mp, 0xD8E0: 0, 0xDAAC: 0xFF, 0xCFF3: 0}
            gb = call(0x32, 0x51F9, mem=mem)
            self.assertEqual(gb.d == 1, not allowed, (cost, mp))
            self.assertEqual(bool(gb.f & 0x10), allowed, (cost, mp))
            self.assertEqual(gb.rb(0xD8DF), mp, "routine must not write the MP")


@unittest.skipUnless(ROM.is_file(), "reference ROM not present")
class ActionGates(unittest.TestCase):
    """Refusal codes of the battle action gates and the queued-action predicate (E-0049; C2 on our emulator)."""

    PAIRS = [(0x34, 0xAD), (0x35, 0xAE), (0x6A, 0xCC), (0xA1, 0xCF), (0x8F, 0xAA)]

    def test_queued_action_matches_itself_and_its_partner(self):
        for x, y in self.PAIRS:
            for a, c in ((x, y), (y, x)):
                gb = call(0x00, 0x3F47, a=a, mem={0xDAAC: c})
                self.assertTrue(gb.f & 0x80, f"{a:02x} vs {c:02x}")
        gb = call(0x00, 0x3F47, a=0x10, mem={0xDAAC: 0x10})
        self.assertTrue(gb.f & 0x80)
        gb = call(0x00, 0x3F47, a=0x11, mem={0xDAAC: 0x10})
        self.assertFalse(gb.f & 0x80)

    def test_action_matching_the_queued_one_is_refused_with_code_2(self):
        mem = {0xD8A4: 0, 0xD8A6: 0x34, 0xFFC8: 2, 0xCFEE: 2, 0xD8DF: 10, 0xD8E0: 0,
               0xDAAC: 0xAD, 0xCFF3: 0}
        gb = call(0x32, 0x51F9, mem=mem)
        self.assertEqual((gb.d, bool(gb.f & 0x10)), (2, False))

    def test_bit6_of_status_byte_refuses_with_code_6(self):
        gb = call(0x32, 0x534A, mem={0xD8A4: 0, 0xD80D: 0x40})
        self.assertEqual((gb.d, bool(gb.f & 0x10)), (6, False))
        gb = call(0x32, 0x534A, mem={0xD8A4: 0, 0xD80D: 0x00})
        self.assertTrue(gb.f & 0x10)

    def test_bit0_of_status_byte_refuses_with_code_3(self):
        gb = call(0x32, 0x529E, mem={0xD8A4: 0, 0xD80D: 0x01})
        self.assertEqual((gb.d, bool(gb.f & 0x10)), (3, False))

    def test_side_flag_bit3_refuses_with_code_4(self):
        gb = call(0x32, 0x529E, mem={0xD8A4: 0, 0xD80D: 0x00, 0xD80A: 0x08})
        self.assertEqual((gb.d, bool(gb.f & 0x10)), (4, False))

    def test_bit7_of_status_byte_refuses_with_code_5(self):
        gb = call(0x32, 0x5303, mem={0xD8A4: 0, 0xD80D: 0x80})
        self.assertEqual((gb.d, bool(gb.f & 0x10)), (5, False))


@unittest.skipUnless(ROM.is_file(), "reference ROM not present")
class ResolveStepHelpers(unittest.TestCase):
    """Resolve-step cases and helpers read on the emulator (E-0050; C2 on our emulator)."""

    def test_case0f_advances_sub_phase_and_restarts_resolve_steps(self):
        gb = call(0x36, 0x490F, mem={0xCFCA: 3, 0xCFCB: 0x0F})
        self.assertEqual((gb.rb(0xCFCA), gb.rb(0xCFCB)), (4, 0))

    def test_action91_with_status_bit6_sets_zero_flag(self):
        gb = call(0x36, 0x433F, mem={0xD8A4: 0, 0xD8A6: 0x91, 0xD80F: 0x40})
        self.assertTrue(gb.f & 0x80)
        gb = call(0x36, 0x433F, mem={0xD8A4: 0, 0xD8A6: 0x91, 0xD80F: 0x00})
        self.assertFalse(gb.f & 0x80)
        gb = call(0x36, 0x433F, mem={0xD8A4: 0, 0xD8A6: 0x90, 0xD80F: 0x40})
        self.assertFalse(gb.f & 0x80)


@unittest.skipUnless(ROM.is_file(), "reference ROM not present")
class BattleText(unittest.TestCase):
    """ShowBattleText stores the message index and category 1 (E-0056; C2 on our emulator)."""

    def test_show_battle_text_selects_category_1_and_the_index(self):
        for index in (0x05, 0x35, 0x8B):
            gb = call(0x3A, 0x7193, d=index)
            self.assertEqual((gb.rb(0xC528), gb.rb(0xC529)), (1, index), hex(index))

    def test_category_0_variant_stores_category_0(self):
        for index in (0x02, 0x40):
            gb = call(0x3A, 0x6EE5, d=index)
            self.assertEqual((gb.rb(0xC528), gb.rb(0xC529)), (0, index), hex(index))


@unittest.skipUnless(ROM.is_file(), "reference ROM not present")
class SlotStatusBlock(unittest.TestCase):
    """CheckSlotStatusBlock: carry set when the slot is absent or one of its status masks is set (E-0058; C2 on our emulator)."""

    def test_absent_slot_and_each_mask(self):
        gb = call(0x00, 0x3E25, a=0x08)
        self.assertTrue(gb.f & 0x10, "slot 8 is out of range")
        gb = call(0x00, 0x3E25, a=0x00, mem={0xDA63: 0x01})
        self.assertTrue(gb.f & 0x10, "absent slot")
        for offset, mask in ((0, 0x10), (3, 0x01), (5, 0x40), (8, 0x08)):
            gb = call(0x00, 0x3E25, a=0x00, mem={0xD80C + offset: mask})
            self.assertTrue(gb.f & 0x10, f"offset {offset} mask {mask:#x}")
        gb = call(0x00, 0x3E25, a=0x00)
        self.assertFalse(gb.f & 0x10, "present and clear")


@unittest.skipUnless(ROM.is_file(), "reference ROM not present")
class DamageDivisors(unittest.TestCase):
    """ComputeBasicDamage divides by 16, not 4 (E-0064; C2 on our emulator). Actor ATK 1000, varied random state."""

    def damage_range(self, bc: int) -> tuple[int, int]:
        out = []
        for seed in range(0, 128, 4):
            gb = call(0x36, 0x5025, mem={0xD8A4: 0, 0xD8FF: 1000 & 0xFF, 0xD900: 1000 >> 8, 0xC5E8: seed, 0xC5E7: seed * 7 & 0xFF},
                      b=bc >> 8, c=bc & 0xFF)
            out.append(gb.rb(0xD872) | gb.rb(0xD873) << 8)
        return min(out), max(out)

    def test_large_difference(self):
        # half = 500: damage = 500 + RandomInRange(-31, 31) + RandomInRange(-1, 1); with /4 it would reach 250-750
        low, high = self.damage_range(0)
        self.assertGreaterEqual(low, 500 - 32)
        self.assertLessEqual(high, 500 + 32)

    def test_small_difference(self):
        # half = 5 <= ATK / 16 = 62: damage = RandomInRange(0, 62); with /4 it would reach 250
        low, high = self.damage_range(990)
        self.assertGreaterEqual(low, 0)
        self.assertLessEqual(high, 62)
        self.assertGreater(high, 31, "the range is not narrower than ATK / 16")


if __name__ == "__main__":
    unittest.main()
