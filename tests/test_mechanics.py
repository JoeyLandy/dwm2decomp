"""tools/mechanics.py and tools/tables_export.py: mechanics and data tables checked against the game (E-0396, M5;
damage E-0397)."""
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import mechanics  # noqa: E402
import tables_export  # noqa: E402

HAVE = mechanics.ROM_PATH.is_file() and any(ROOT.glob("build/run*/dwm2.sym"))


class Pure(unittest.TestCase):
    def test_clamp_to_999(self):
        self.assertEqual(mechanics.clamp_delta_999(990, 5), 5)
        self.assertEqual(mechanics.clamp_delta_999(990, 20), 9)
        self.assertEqual(mechanics.clamp_delta_999(999, 7), 0)
        self.assertEqual(mechanics.clamp_delta_999(1000, 3), 255)  # above 999: the meaningless low byte

    def test_random_in_range_equal_bounds_take_no_step(self):
        class Counting:
            steps = 0

            def next(self):
                self.steps += 1
                return 0x1234
        r = Counting()
        self.assertEqual(mechanics.random_in_range(r, 7, 7), 7)
        self.assertEqual(r.steps, 0)
        self.assertEqual(mechanics.random_in_range(r, -1, 1), (0x1234 % 3 - 1) & 0xFFFF)
        self.assertEqual(r.steps, 1)

    def test_resistance_level_fields(self):
        self.assertEqual(mechanics.resistance_level(0b10_01_11_00, ["swap a"]), 0b01)
        self.assertEqual(mechanics.resistance_level(0b10_01_11_00, ["rlca", "rlca"]), 0b10)
        self.assertEqual(mechanics.resistance_level(0b10_01_11_00, ["rrca", "rrca"]), 0b11)
        self.assertEqual(mechanics.resistance_level(0b10_01_11_00, []), 0b00)

    def test_resistance_routines_are_found(self):
        shapes = mechanics.resistance_routines()
        self.assertEqual(len(shapes), 16)
        self.assertEqual(shapes["ActionEffect_Blaze_Damage"],
                         {"source": "skill", "byte": 0, "rot": ["swap a"], "picker": "ScaleDamageByFlagsAtHL"})
        self.assertEqual(shapes["ActionEffect_Infernos_Damage"]["byte"], 1)  # runs into ScaleDamageByVacuumResistance

    def test_random_steps_wrap_at_128(self):
        class FakeRom:
            def b(self, bank, addr):
                return addr & 0xFF
        r = mechanics.Random(FakeRom(), 0x0900, 0x7F, 0)
        self.assertEqual(r.next() >> 8, 0)
        self.assertEqual(r.next() >> 8, 1)


@unittest.skipUnless(HAVE, "reference ROM or a build's .sym not present")
class AgainstTheGame(unittest.TestCase):
    rom = mechanics.ROM_PATH.read_bytes() if mechanics.ROM_PATH.is_file() else b""

    def test_models_agree(self):
        for name, fn in mechanics.CHECKS.items():
            self.assertEqual(fn(self.rom, 400, 11)[:3], [], name)

    def test_a_wrong_model_is_caught(self):
        def wrong_join(r, L, s):
            o = good_join(r, L, s)
            return dict(o, display_slot=0xFF) if o["display_slot"] != 0xFF else o
        good_join = mechanics.join_model
        good_growth = mechanics.growth_model
        good_breed = mechanics.breed_model
        try:
            mechanics.join_model = wrong_join  # a model that never offers
            self.assertTrue(mechanics.join_check(self.rom, 300, 11))
            mechanics.growth_model = lambda r, L, rec: [0] * 8  # a model with no growth
            self.assertTrue(mechanics.growth_check(self.rom, 300, 11))
            mechanics.breed_model = lambda r, L, a, b, k: dict(good_breed(r, L, a, b, k), arg5=0)
            self.assertTrue(mechanics.breed_check(self.rom, 100, 11))
        finally:
            mechanics.join_model, mechanics.growth_model, mechanics.breed_model = good_join, good_growth, good_breed

    def test_a_wrong_damage_model_is_caught(self):
        good_attack, good_step7, levels = mechanics.attack_damage, mechanics.step7_model, dict(mechanics.SCALE_LEVELS)
        try:
            def attack_full_def(rnd, atk, def_):  # DEF not halved
                rnd.next()
                return mechanics.basic_damage(rnd, atk, def_)
            mechanics.attack_damage = attack_full_def
            self.assertTrue(mechanics.attack_check(self.rom, 300, 11))
            mechanics.attack_damage = good_attack
            mechanics.SCALE_LEVELS["1_085_05_0"] = (lambda d: d, lambda d: d * 3 // 4, lambda d: d >> 1, lambda d: 0)
            self.assertTrue(mechanics.resist_check(self.rom, 300, 11))
            mechanics.SCALE_LEVELS.update(levels)

            def no_berserk(r, L, C, s):  # a model that forgets the target's BSTAT6_BERSERK
                return good_step7(r, L, C, dict(s, status=[x[:6] + [x[6] & ~0x04] + x[7:] for x in s["status"]]))
            mechanics.step7_model = no_berserk
            self.assertTrue(mechanics.step7_check(self.rom, 300, 11))
        finally:
            mechanics.attack_damage, mechanics.step7_model = good_attack, good_step7
            mechanics.SCALE_LEVELS.update(levels)

    def test_tables_round_trip_and_readers(self):
        res = tables_export.check(self.rom)
        self.assertTrue(all(res["round_trip"].values()), res["round_trip"])
        self.assertEqual(res["pointers"]["outside_or_misaligned"], [])
        self.assertEqual({k: v["differ"] for k, v in res["readers"].items()},
                         {"LoadSpeciesRecord": [], "LoadSkillRecord": [], "LoadItemRecord": []})

    def test_a_changed_export_no_longer_packs_to_the_rom(self):
        t = tables_export.export_data(self.rom)
        t["items"][0]["fields"][0] ^= 1
        L = tables_export.layouts()["ItemTable"]
        rom_items = tables_export.raw(self.rom, L["bank"], L["addr"], L["count"] * L["stride"])
        self.assertNotEqual(tables_export.pack(t)["ItemTable"], rom_items)


class Export(unittest.TestCase):
    def test_exports_stay_in_an_ignored_directory(self):
        if not mechanics.ROM_PATH.is_file():
            self.skipTest("reference ROM not present")
        with self.assertRaises(SystemExit):
            tables_export.main(["export", "--out", str(ROOT / "docs" / "tables")])


if __name__ == "__main__":
    unittest.main()
