"""Behavioural checks of helpers named by reading in E-0305, run on tools/sm83.py against the reference ROM
(E-0315). Each test compares the executed routine with the note its name was given. Skipped without the ROM."""
import random
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tests"))
sys.path.insert(0, str(ROOT / "tools"))
from test_routine_behaviour import ROM, call  # noqa: E402

wDMGPaletteBGP, wEffectCounter, wInventory, wRecordBufA = 0xC5E9, 0xD807, 0xC61D, 0xC986
MON_SKILLS = 0x34


def shades(b: int) -> list[int]:
    return [(b >> (2 * i)) & 3 for i in range(4)]


def pack(sh: list[int]) -> int:
    return sum(s << (2 * i) for i, s in enumerate(sh))


def palette_model(pal: list[int], darken: bool) -> list[int]:
    """Exact model of both routines (E-0315): shades 0-2 step by one, capped (3 up, 0 down); the top shade
    steps too, but on darkening 3 wraps to 0 ($C0 + $40 = $00 passes the cap check); C collects the low
    shades and is never cleared, so each byte also gets the earlier bytes' low shades ORed in."""
    c, out = 0, []
    for b in pal:
        for mask, unit in ((0x03, 0x01), (0x0C, 0x04), (0x30, 0x10)):
            v = b & mask
            v = min(v + unit, mask) if darken else (v - unit if v else 0)
            c |= v
        top = b & 0xC0
        top = (top + 0x40) & 0xFF if darken else (top - 0x40 if top else 0)
        out.append(top | c)
    return out


@unittest.skipUnless(ROM.is_file(), "reference ROM not present")
class PaletteSteps(unittest.TestCase):
    def test_lighten_and_darken_match_the_exact_model(self):
        rng = random.Random(11)
        for _ in range(60):
            pal = [rng.randrange(256) for _ in range(3)]
            mem = {wDMGPaletteBGP + i: v for i, v in enumerate(pal)}
            mem[wEffectCounter] = 5
            for addr, darken in ((0x50D9, False), (0x4EC3, True)):
                gb = call(0x3A, addr, mem=mem)
                self.assertEqual([gb.rb(wDMGPaletteBGP + i) for i in range(3)], palette_model(pal, darken), (pal, darken))
                self.assertEqual(gb.rb(wEffectCounter), 6)

    def test_darkening_wraps_the_top_shade(self):
        gb = call(0x3A, 0x4EC3, mem={wDMGPaletteBGP: 0xE4, wDMGPaletteBGP + 1: 0, wDMGPaletteBGP + 2: 0})
        self.assertEqual(gb.rb(wDMGPaletteBGP), 0x39)  # shades 0,1,2,3 -> 1,2,3,0


@unittest.skipUnless(ROM.is_file(), "reference ROM not present")
class SmallHelpers(unittest.TestCase):
    def test_modulo_b_plus_one(self):
        for l, b in ((0, 7), (6, 7), (7, 7), (200, 13), (255, 1)):
            gb = call(0xF0, 0x7E5D, l=l, b=b)
            self.assertEqual((gb.d << 8) | gb.e, l % b + 1, (l, b))

    def test_record_knows_skill(self):
        skills = [0x10, 0x22, 0x35, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF]
        mem = {wRecordBufA + MON_SKILLS + i: v for i, v in enumerate(skills)}
        self.assertEqual(call(0x1A, 0x6306, mem=mem, a=0x22).a, 0xFF)
        self.assertEqual(call(0x1A, 0x6306, mem=mem, a=0x23).a, 0x23)

    def test_count_battler_records(self):
        base = 0xD0D5
        for used, want in (((0, 0), 1), ((1, 0), 2), ((1, 1), 3)):
            mem = {base + 0x4E: used[0], base + 0x9C: used[1]}
            gb = call(0x19, 0x4186, mem=mem, h=base >> 8, l=base & 0xFF)
            self.assertEqual(gb.a, want, used)

    def test_inventory_counters(self):
        inv = [0x2C, 0x05, 0x2C, 0x01] + [0xFF] * 20
        mem = {wInventory + i: v for i, v in enumerate(inv)}
        self.assertEqual(call(0x0D, 0x6DD0, mem=mem).a, 2)        # MedalPrizeMenu_CountItem2C
        self.assertEqual(call(0x0D, 0x6D09, mem=mem).a, 0)        # a free ($FF) slot exists
        full = {wInventory + i: 0x05 for i in range(24)}
        self.assertEqual(call(0x0D, 0x6DD0, mem=full).a, 0xFF)    # no $2C at all
        self.assertEqual(call(0x0D, 0x6D09, mem=full).a, 0xFF)    # no free slot

    def test_subtract_floor_zero(self):
        # RunBattleSetup_MainMenu_SubtractFloor0: [DE + C] -= [HL], not below 0
        for a, b in ((10, 3), (3, 10), (0, 0)):
            mem = {0xC100 + 2: a, 0xC200: b}
            gb = call(0x31, 0x4EB9, mem=mem, d=0xC1, e=0x00, c=2, h=0xC2, l=0x00)
            self.assertEqual(gb.rb(0xC102), max(a - b, 0), (a, b))
        # ApplyMeatToRecordField6B_SubtractDEFloor0: the word at HL -= DE, not below 0
        for w, de in ((500, 20), (10, 20)):
            mem = {0xC300: w & 0xFF, 0xC301: w >> 8}
            gb = call(0x16, 0x58E0, mem=mem, h=0xC3, l=0x00, d=de >> 8, e=de & 0xFF)
            self.assertEqual(gb.rb(0xC300) | gb.rb(0xC301) << 8, max(w - de, 0), (w, de))


if __name__ == "__main__":
    unittest.main()
