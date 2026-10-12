"""Behavioural checks of readings made in E-0289 to E-0312, run on tools/sm83.py against the reference ROM.

Each test executes the real routine and compares it with the reading written in the evidence log. Our
emulator has not been checked against hardware, so these back the readings within that scope (E-0314).
Skipped without the reference ROM, which is kept out of the repository."""
import random
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tests"))
sys.path.insert(0, str(ROOT / "tools"))
from test_routine_behaviour import ROM, call  # noqa: E402

wKeyNameBuf, wBattleResultStep = 0xC895, 0xC899  # four result counters start at wKeyNameBuf (E-0314)
wLinkRuleTurnLimit, wWildLevel, wWildBand, wWildByteE5, wWorkBuf = 0xD04B, 0xCFE3, 0xCFE4, 0xCFE5, 0xD09D
wChildRecord, wSpeciesRecord, wRandomLo, wRandomHi = 0xCAD0, 0xD008, 0xC5E7, 0xC5E8
wPendingGiftItem, wGiftRecord, wFamilyScores = 0xCEC1, 0xCECE, 0xCEC3
MON_SPECIES, MON_SEX, MON_MAX_HP = 0x0B, 0x0E, 0x5D


def count_at_or_below(a: int, table: list[int]) -> int:
    n = 0
    for t in table:
        if a < t:
            break
        n += 1
    return n


def signed(b: int) -> int:
    return b - 256 if b & 0x80 else b


def rank_model(step, counts, turns, level):
    """counts: the four result counters at $C895-$C898 (E-0314)."""
    counts = list(counts)
    counts[step] = min(counts[step] + 1, 99)
    adj1 = [0x14, 0x0A, 0x05, 0x00, 0xFB, 0xF6, 0xEC][count_at_or_below(turns, [0x06, 0x0B, 0x15, 0x29, 0x33, 0x3D, 0xFF])]
    first_two = (counts[0] + counts[1]) & 0xFF
    band = (first_two * 10 // (first_two + counts[2] + counts[3])) & 0xFF
    adj2 = [0xEC, 0xF6, 0xFB, 0x00, 0x05, 0x0A][count_at_or_below(band, [0x01, 0x03, 0x05, 0x07, 0x09, 0xFF])]
    lv = level + signed(adj2) + signed(adj1)
    lv = 0 if lv < 0 else min(lv, 99)
    return counts, band, count_at_or_below(lv, [0x14, 0x28, 0x32, 0x3C, 0x46, 0x50, 0x5A, 0xFF])


@unittest.skipUnless(ROM.is_file(), "reference ROM not present")
class BattleResultRank(unittest.TestCase):
    def test_rank_matches_the_e0289_reading_with_four_counters(self):
        rng = random.Random(7)
        for _ in range(200):
            step = rng.randrange(4)
            counts = [rng.randrange(1, 100)] + [rng.randrange(0, 100) for _ in range(3)]
            turns, level = rng.randrange(256), rng.randrange(100)
            mem = {wKeyNameBuf + i: v for i, v in enumerate(counts)}
            mem.update({wBattleResultStep: step, wLinkRuleTurnLimit: turns, wWildLevel: level})
            gb = call(0xA0, 0x5A6C, mem=mem)
            new_counts, band, rank = rank_model(step, counts, turns, level)
            got = ([gb.rb(wKeyNameBuf + i) for i in range(4)], gb.rb(wWildBand), gb.rb(wWildByteE5), gb.rb(wWorkBuf + 1))
            self.assertEqual(got, (new_counts, band, rank, rank), (step, counts, turns, level))


@unittest.skipUnless(ROM.is_file(), "reference ROM not present")
class ChildSexRoll(unittest.TestCase):
    def test_sex_follows_the_species_sex_ratio_class(self):
        """E-0307/E-0311: class 0 is always male (0); classes 1-3 give female (1) about 10, 50, 90 percent."""
        rng = random.Random(3)
        seen: dict[int, list[int]] = {}
        for species in range(1, 300, 7):
            for _ in range(12):
                mem = {wChildRecord + MON_SPECIES: species & 0xFF, wChildRecord + MON_SPECIES + 1: species >> 8,
                       wRandomLo: rng.randrange(256), wRandomHi: rng.randrange(256)}
                gb = call(0x0E, 0x61C1, mem=mem)
                cls = gb.rb(wSpeciesRecord + 1)
                cls = 0 if cls == 0 else (cls & 3)
                seen.setdefault(cls, []).append(gb.rb(wChildRecord + MON_SEX))
        self.assertTrue(all(v == 0 for v in seen.get(0, [])))
        for cls, sexes in seen.items():
            self.assertTrue(set(sexes) <= {0, 1}, cls)
        rates = {cls: sum(v) / len(v) for cls, v in seen.items() if len(v) >= 20}
        if 2 in rates and 3 in rates:
            self.assertLess(rates[2], rates[3])
        if 1 in rates:
            self.assertLess(rates[1], 0.35)


@unittest.skipUnless(ROM.is_file(), "reference ROM not present")
class GiftEffect(unittest.TestCase):
    def test_a_herb_raises_the_egg_max_hp_by_one_and_clears_the_pending_gift(self):
        """E-0295/E-0312: GiftEffect_Herb adds 1 to wGiftRecord + MON_MAX_HP (capped at 999)."""
        for hp in (0, 500, 999):
            mem = {wPendingGiftItem: 0x01, wGiftRecord + MON_MAX_HP: hp & 0xFF, wGiftRecord + MON_MAX_HP + 1: hp >> 8}
            mem.update({wFamilyScores + i: 10 for i in range(11)})
            gb = call(0xF0, 0x72C8, mem=mem)
            new_hp = gb.rb(wGiftRecord + MON_MAX_HP) | gb.rb(wGiftRecord + MON_MAX_HP + 1) << 8
            self.assertEqual(new_hp, min(hp + 1, 999), hp)
            self.assertEqual(gb.rb(wPendingGiftItem), 0)


if __name__ == "__main__":
    unittest.main()
