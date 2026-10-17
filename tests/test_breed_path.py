"""tools/breed_path.py: wild species per map and breeding routes, checked against the game's routines (E-0400)."""
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import breed_path as B  # noqa: E402
import mechanics as M  # noqa: E402

HAVE = M.ROM_PATH.is_file() and any(ROOT.glob("build/run*/dwm2.sym"))


class FakeRom:
    """Bank-agnostic bytes at chosen addresses (0 elsewhere)."""

    def __init__(self, at: dict[int, list[int]]):
        self.mem = {}
        for base, bs in at.items():
            for k, v in enumerate(bs):
                self.mem[base + k] = v

    def b(self, bank, addr):
        return self.mem.get(addr, 0)

    def w(self, bank, addr):
        return self.b(bank, addr) | self.b(bank, addr + 1) << 8


def entry(cap, thresholds, words):
    ws = [x for w in words for x in (w & 0xFF, w >> 8)]
    return [1, cap] + thresholds + [0] * (5 - len(thresholds)) + ws


class Pure(unittest.TestCase):
    def test_slots_follow_cap_and_thresholds(self):
        r = FakeRom({0x100: entry(10, [4, 8, 12], [0x11, 0x22, 0x33])})
        slots = B.entry_slots(r, 0, 0x100)
        self.assertEqual([s["monster"] for s in slots], [0x11, 0x22, 0x33])
        self.assertEqual([s["reachable"] for s in slots], [True, True, True])  # r 9-10 reach the third
        r = FakeRom({0x100: entry(8, [4, 8, 12], [0x11, 0x22, 0x33])})
        self.assertEqual([s["reachable"] for s in B.entry_slots(r, 0, 0x100)], [True, True, False])  # cap 8

    def test_slot_needs_a_roll_value_in_its_range(self):
        r = FakeRom({0x100: entry(20, [6, 18, 19], [0x11, 0x22, 0x33])})
        values = set(range(128)) - {19}
        self.assertEqual([s["reachable"] for s in B.entry_slots(r, 0, 0x100, values)], [True, True, False])
        self.assertEqual([s["reachable"] for s in B.entry_slots(r, 0, 0x100)], [True, True, True])

    def test_zero_threshold_ends_and_falling_threshold_is_unreachable(self):
        r = FakeRom({0x100: [1, 30, 10, 5, 0, 20, 0, 1, 0, 2, 0, 3, 0, 4, 0]})
        slots = B.entry_slots(r, 0, 0x100)
        self.assertEqual([s["monster"] for s in slots], [1, 2])
        self.assertEqual([s["reachable"] for s in slots], [True, False])

    def test_search_keeps_the_fewest_breedings(self):
        table = {(1, 2): 3, (3, 3): 5, (1, 1): 4, (4, 2): 5, (5, 1): 6}
        cost, how = B.search({1, 2}, lambda a, b: table.get((a, b)))
        self.assertEqual(cost[3], 1)
        self.assertEqual(cost[5], 2)          # 4 x 2 (1 + 0 + 1) beats 3 x 3 (1 + 1 + 1)
        self.assertEqual(how[5], (4, 2))
        self.assertEqual(cost[6], 3)
        self.assertNotIn(7, cost)

    def test_needs_counts_each_copy(self):
        how = {5: (3, 3), 3: (1, 2)}
        self.assertEqual(B.needs(how, 5), {5: 1, 3: 2, 1: 2, 2: 2})

    def test_dispatch_rejects_unknown_code(self):
        L = {"R": (0x0A, 0x100), "ReadMapCellWordForScreenXY": (0x0A, 0x900),
             "LoadEncounterIdsForScreenCell": (0x0A, 0x910)}
        good = [0xF0, 0x90, 0xFE, 0x20, 0xCA, 0x08, 0x01, 0xC9]
        branch = [0x11, 0x00, 0x60, 0x3E, 0x08, 0xCD, 0x00, 0x09, 0xC9]
        d = B.decode_dispatch(FakeRom({0x100: good, 0x108: branch}), L, "R")
        self.assertEqual(d, {0x20: [{"kind": "grid", "table": 0x6000, "per_row": 8, "bit3": None}]})
        with self.assertRaises(ValueError):
            B.decode_dispatch(FakeRom({0x100: good, 0x108: [0x00] + branch}), L, "R")
        with self.assertRaises(ValueError):
            B.decode_dispatch(FakeRom({0x100: [0xF0, 0x91] + good[2:]}), L, "R")

    def test_parse_range(self):
        self.assertEqual(B.parse_range("30-45"), (0x30, 0x45))
        self.assertEqual(B.parse_range("70"), (0x70, 0x70))


@unittest.skipUnless(HAVE, "reference ROM or a build's .sym not present")
class AgainstTheGame(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.rom = M.ROM_PATH.read_bytes()
        cls.r, cls.L, cls.R = M.Rom(cls.rom), M.rom_labels(), M.ram()
        cls.names = B.monster_names()
        cls.ids = {v: k for k, v in cls.names.items()}

    def test_both_dispatches_pick_the_same_tables(self):
        a = B.decode_dispatch(self.r, self.L, "RunBattleIntroKindCase_RandomEncounter")
        b = B.decode_dispatch(self.r, self.L, "CollectUniqueEncounterIdsToWorkBuf2_FindTable")
        self.assertEqual(len(a), 56)
        self.assertEqual(set(a), set(b))
        def strip(p):
            return {k: v for k, v in p.items() if k != "kind"}
        for m in a:
            want = [strip(p) for p in a[m]]
            if m == 0xB8:  # the listing ignores bit 3 there: it reads the grid only
                want = [{**p, "bit3": None} for p in want if p["bit3"] is False]
            self.assertEqual(want, [strip(p) for p in b[m]], f"map {m:02X}")

    def test_roll_values(self):
        v = B.roll_values(self.r, self.L)
        self.assertEqual(len(v), 94)
        self.assertNotIn(19, v)

    def test_lists_match_the_game_listing(self):
        self.assertEqual(B.check_lists(self.rom, self.r, self.L, self.R), [])

    def test_draws_match_the_game_over_all_random_states(self):
        bad, n = B.check_draws(self.rom, self.r, self.L, self.R)
        self.assertEqual(bad, [])
        self.assertEqual(n, 109)

    def test_a_model_that_lets_every_roll_occur_is_caught(self):
        for addr, lost in ((0x5F83, "METALY"), (0x5FB0, "PHOENIX")):
            naive = {s["monster"] for s in B.entry_slots(self.r, 0x0A, addr) if s["reachable"]}
            got = B.game_draws(self.rom, self.L, self.R, addr)
            self.assertNotEqual(naive, got)
            self.assertEqual({self.names[B.species_of(self.r, self.L, m)] for m in naive - got}, {lost})

    def test_pirate_world_darkdrium_route(self):
        p = B.pool(B.wild(self.r, self.L, [(0x30, 0x45)]))
        self.assertEqual(len(p), 37)
        cost, how = B.search(set(p), B.farm_child(self.r, self.L))
        t = self.ids["DARKDRIUM"]
        self.assertEqual(cost[t], 132)
        self.assertEqual(how[t], (self.ids["DEATHMORE_170"], self.ids["GRANSLIME"]))
        need = B.needs(how, t)
        self.assertEqual(sum(n for s, n in need.items() if s not in how), 133)
        fam = lambda s: B.family(self.r, self.L, s)  # noqa: E731
        pairs = {how[c] + (c,) for c in need if c in how}
        self.assertEqual(len(pairs), 40)
        for a, b, c in pairs:
            self.assertEqual(B.game_child(self.rom, self.L, self.R, a, b, fam), c, f"{a} x {b}")
        # a model with the parents swapped is caught
        child = B.farm_child(self.r, self.L)
        wrong = [(a, b) for a, b, c in pairs if child(b, a) != B.game_child(self.rom, self.L, self.R, a, b, fam)]
        self.assertTrue(wrong)

    def test_cli(self):
        self.assertEqual(B.main(["check", "--maps", "30-45", "--target", "DARKDRIUM"]), 0)
        self.assertEqual(B.main(["route", "DARKDRIUM", "--maps", "30-45"]), 0)
        self.assertEqual(B.main(["route", "SLIME", "--maps", "37-37"]), 1)  # Hork and RayGigas alone: no Slime


if __name__ == "__main__":
    unittest.main()
