"""tools/datatables.py: the data tables exported from src/ and imported back (H2, E-0405).

The H2 gate: each table round-trips unchanged (so the matching build is unaffected), and an edit made through the
tool reaches the game: a copy of src/ with one edit per table is built, and the game's own reader of each table,
run on tools/sm83.py from the modded ROM, returns the edited value (C2 on the project's emulator).
"""
import copy
import json
import shutil
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import datatables as D  # noqa: E402

REF = ROOT / "local/roms/dwm2-cobi-us.gbc"


def table(data: dict, label: str) -> dict:
    return next(t for g in data.values() for t in g["tables"] if t["label"] == label)


class Parsing(unittest.TestCase):
    def test_operands_split_at_top_level_commas(self):
        self.assertEqual(D.split_operands("$01, BANK(Foo), LOW(Bar + 2)"), ["$01", "BANK(Foo)", "LOW(Bar + 2)"])

    def test_fill_takes_the_growth_and_refuses_too_much(self):
        lines = ["Foo::", "    db $01", "    ds $10, $00"]
        D.take_from_fill(lines, 3, "x")
        self.assertEqual(lines[2], "    ds $d, $00")
        D.take_from_fill(lines, -2, "x")
        self.assertEqual(lines[2], "    ds $f, $00")
        with self.assertRaises(ValueError):
            D.take_from_fill(lines, 0x10, "x")
        with self.assertRaises(ValueError):
            D.take_from_fill(["Foo::", "    db $01"], 1, "x")


class RoundTrip(unittest.TestCase):
    def test_export_covers_the_tables(self):
        data = D.export(ROOT / "src")
        self.assertEqual(sorted(data), sorted(D.FIXED))
        labels = {t["label"] for g in data.values() for t in g["tables"]}
        for label in ("SpeciesRecords", "MonsterTable", "SkillTable", "ItemTable", "ShopItemListTable",
                      "ShopPercentTable", "AIPersonalityWeightTable", "BreedSpeciesRuleTable",
                      "FamilyPairResultTable", "ScriptedEncounterTable", "EncounterGrid_1", "EncounterGroup_Direct1",
                      "ArenaEncounterList0"):
            self.assertIn(label, labels)
        self.assertGreater(len(labels), 170)
        sp = table(data, "SpeciesRecords")["records"]
        self.assertEqual(len(sp), 324)
        self.assertEqual(sp[1]["fields"]["natural_skills"], ["SKILL_BEDRAGON", "SKILL_FIREAIR", "SKILL_SUCKAIR"])

    def test_unchanged_import_changes_nothing(self):
        self.assertEqual(D.check(ROOT / "src"), [])

    def test_a_token_count_change_in_a_fixed_field_is_refused(self):
        with tempfile.TemporaryDirectory() as t:
            src = Path(t) / "src"
            shutil.copytree(ROOT / "src", src)
            data = D.export(src)
            sp = copy.deepcopy(table(data, "SpeciesRecords"))
            sp["records"] = [sp["records"][1]]
            sp["records"][0]["fields"]["natural_skills"] = ["SKILL_BEDRAGON"]
            with self.assertRaises(ValueError):
                D.apply(src, [{"tables": [sp]}])


@unittest.skipUnless(REF.exists() and (ROOT / "tools/rgbds/rgbasm.exe").exists(), "needs the reference ROM and RGBDS")
class EditsReachTheReaders(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        import mechanics as M
        cls.M = M
        cls.tmp = tempfile.TemporaryDirectory(dir=ROOT / "build")
        src = Path(cls.tmp.name) / "src"
        shutil.copytree(ROOT / "src", src)
        data = D.export(src)
        edits = []

        def edit(label, rid, field, values):
            t = copy.deepcopy(table(data, label))
            t["records"] = [r for r in t["records"] if r["id"] == rid]
            t["records"][0]["fields"] = {field: values}
            edits.append({"tables": [t]})

        edit("SpeciesRecords", 1, "level_cap", ["$30"])                  # DrakSlime's record
        edit("ItemTable", 1, "amount", ["25"])
        edit("SkillTable", 1, "word9", ["$34", "$12"])
        edit("ShopPercentTable", 0, "percent", ["$64"])
        edit("AIPersonalityWeightTable", 0, "weights", ["$0123"] + table(data, "AIPersonalityWeightTable")
             ["records"][0]["fields"]["weights"][1:])
        edit("EncounterGroup_Grid1_4", 0, "f2", ["$0006", "$0003", "$0005"])
        edit("MonsterTable", 1, "hp", ["300"])
        edit("EncounterGrid_1", 0, "f0", ["EncounterGroup_Grid1_4"])     # map $20, screen (0, 0)
        edit("ScriptedEncounterTable", 1, "monsters", ["$0005", "$0001", "$0001"])
        arena = table(data, "ArenaEncounterList0")["records"][0]["fields"]["f0"]
        edit("ArenaEncounterList0", 0, "f0", ["$0001"] + arena[1:])
        br = copy.deepcopy(table(data, "BreedSpeciesResultTable"))
        lab = br["pointers"][1]  # DrakSlime's results; its first rule is DrakSlime x SwordGon
        br["lists"] = {lab: ["MONSTER_SLIME"] + br["lists"][lab][1:]}
        edits.append({"tables": [br]})
        shop = copy.deepcopy(table(data, "ShopItemListTable"))
        cls.shop_list = shop["lists"]["ShopItems000"][:-1] + ["$0a", "$ff"]
        shop["lists"] = {"ShopItems000": cls.shop_list}
        edits.append({"tables": [shop]})
        cls.result = D.apply(src, edits)
        out = Path(cls.tmp.name).relative_to(ROOT).as_posix() + "/run"
        cls.build = subprocess.run([sys.executable, "-I", str(ROOT / "tools/build.py"), "--out", out, "--src", str(src)],
                                   cwd=ROOT, capture_output=True, text=True)
        cls.outdir = ROOT / out
        cls.rom = (cls.outdir / "dwm2.gbc").read_bytes() if (cls.outdir / "dwm2.gbc").exists() else b""
        cls.L = M.rom_labels(cls.outdir / "dwm2.sym") if (cls.outdir / "dwm2.sym").exists() else {}
        cls.R = M.ram()

    @classmethod
    def tearDownClass(cls):
        cls.tmp.cleanup()

    def call(self, label, mem=None, regs=None):
        return self.M.call(self.rom, *self.L[label], mem or {}, regs)

    def test_the_edited_tree_builds_as_a_mod(self):
        self.assertEqual(self.build.returncode, 0, self.build.stdout + self.build.stderr)
        rep = json.loads((self.outdir / "report.json").read_text())
        self.assertFalse(rep["pass"])  # a mod: not the reference
        self.assertEqual(self.result, {"lines": 10, "lists": 2})

    def test_species(self):
        R = self.R
        gb = self.call("LoadSpeciesRecord", {R["wSpeciesIdLo"]: 1, R["wSpeciesIdHi"]: 0})
        self.assertEqual(gb.rb(R["wSpeciesRecord"] + 6), 0x30)

    def test_item(self):
        R = self.R
        gb = self.call("LoadItemRecord", {R["wItemId"]: 1})
        self.assertEqual(gb.rb(R["wItemRecord"] + 1) | gb.rb(R["wItemRecord"] + 2) << 8, 25)

    def test_skill(self):
        R = self.R
        gb = self.call("LoadSkillRecord", {R["wRecordBuffer"]: 1, R["wRecordBuffer"] + 1: 0})
        self.assertEqual((gb.rb(R["wRecordBufferData"] + 9), gb.rb(R["wRecordBufferData"] + 10)), (0x34, 0x12))

    def test_shop_percent(self):
        R = self.R
        gb = self.call("ComputeSellPrice", {R["wScreenTableIndex"]: 0}, {"d": 0, "e": 2})  # item 1, Herb (value 10)
        self.assertEqual(gb.h << 8 | gb.l, 10)  # 100 percent of its value

    def test_shop_list_grew(self):
        R = self.R
        gb = self.call("LoadArg1PointerForScreenTableIndex", {R["wScreenTableIndex"]: 0})
        p = gb.rb(R["wArg2"]) << 8 | gb.rb(R["wArg1"])
        bank = self.L["ShopItemListTable"][0]
        got = [self.rom[bank * 0x4000 + p - 0x4000 + k] for k in range(len(self.shop_list))]
        self.assertEqual(got, [int(t[1:], 16) for t in self.shop_list])

    def test_ai_weight(self):
        R = self.R
        gb = self.call("ReadBank6TableWord", {R["wPersonalityIndex"]: 0}, {"b": 0, "c": 0})
        self.assertEqual(gb.b << 8 | gb.c, 0x0123)

    def test_encounter(self):
        import breed_path
        got = breed_path.game_draws(self.rom, self.L, self.R, self.L["EncounterGroup_Grid1_4"][1])
        self.assertIn(6, got)
        self.assertNotIn(2, got)

    def test_monster(self):
        R = self.R
        gb = self.call("LoadMonsterRecord", {R["wMonsterId"]: 1, R["wMonsterId"] + 1: 0})
        self.assertEqual(gb.rb(R["wRecordBuffer"] + 10) | gb.rb(R["wRecordBuffer"] + 11) << 8, 300)

    def test_encounter_grid(self):
        import breed_path
        got = breed_path.game_list(self.rom, self.L, self.R, 0x20, 0, 0, False)
        # the screen now lists Grid1_4's three words (as edited above: $0006, $0003, $0005), as species
        want = [breed_path.species_of(self.M.Rom(self.rom), self.L, w) for w in (6, 3, 5)]
        self.assertEqual(got, want)
        self.assertNotEqual(got, [breed_path.species_of(self.M.Rom(self.rom), self.L, w) for w in (2, 3)])

    def test_scripted_encounter(self):
        R = self.R
        gb = self.call("StartScriptedEncounterTemp0", {0xFFC6: 1})  # hTemp0
        self.assertEqual([gb.rb(R["wEncounterMonsters"] + 2 * k) | gb.rb(R["wEncounterMonsters"] + 2 * k + 1) << 8
                          for k in range(3)], [5, 1, 1])

    def test_arena_list_bytes(self):
        """The arena's reader runs inside a scene (E-0183), so the list is checked at its label in the modded ROM."""
        bank, addr = self.L["ArenaEncounterList0"]
        at = bank * 0x4000 + addr - 0x4000
        self.assertEqual((self.rom[at], self.rom[at + 1], self.rom[at + 2]), (0x01, 0x00, 0x05))

    def test_breeding(self):
        import breed_path
        fam = lambda s: breed_path.family(self.M.Rom(self.rom), self.L, s)  # noqa: E731
        child = breed_path.game_child(self.rom, self.L, self.R, 0x01, self._swordgon(), fam)
        self.assertEqual(child, 0x0A)  # MONSTER_SLIME

    def _swordgon(self):
        import re
        inc = (ROOT / "src/constants.inc").read_text(encoding="utf-8")
        return int(re.search(r"^DEF MONSTER_SWORDGON EQU \$([0-9A-Fa-f]+)", inc, re.M).group(1), 16)


if __name__ == "__main__":
    unittest.main()
