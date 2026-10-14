"""Named ids (D-007, tools/gb_constants.py): each constant names its own string in the ROM's name tables."""
import re
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
REF = ROOT / "local" / "roms" / "dwm2-cobi-us.gbc"


@unittest.skipUnless(REF.exists(), "reference ROM not present")
class ConstantsTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        import gb_constants
        cls.c = gb_constants.build(REF.read_bytes())

    def test_names_are_unique_identifiers(self):
        names = [n for t in self.c.values() for n, _ in t.values()]
        self.assertEqual(len(names), len(set(names)))
        self.assertTrue(all(re.fullmatch(r"[A-Z][A-Z0-9_]*", n) for n in names))

    def test_each_name_spells_its_string(self):
        for prefix, table in self.c.items():
            for v, (name, text) in table.items():
                stem = re.sub(r"[^A-Za-z0-9]", "", text).upper()
                if stem and not name.startswith("ACTION_"):
                    self.assertTrue(name == f"{prefix}_{stem}" or name == f"{prefix}_{stem}_{v:02X}", (name, text))

    def test_known_ids(self):
        self.assertEqual(self.c["MONSTER"][0x73][0], "MONSTER_DRACKY")  # E-0320: Patta's species
        self.assertEqual(self.c["SKILL"][0x83][0], "SKILL_DEMAGIC")
        self.assertEqual(self.c["SKILL"][0][0], "ACTION_FIGHT")  # E-0333
        self.assertEqual(self.c["ITEM"][1][0], "ITEM_HERB")  # E-0326

    def test_generated_file_and_uses(self):
        inc = (ROOT / "src" / "constants.inc").read_text(encoding="utf-8")
        self.assertIn("DEF SKILL_DEMAGIC EQU $83", inc)
        main = (ROOT / "src" / "main.asm").read_text(encoding="utf-8")
        self.assertLess(main.index('INCLUDE "constants.inc"'), main.index('INCLUDE "home/bank00'))
        text = "\n".join(p.read_text(encoding="utf-8") for p in ROOT.glob("src/*/bank3*.asm"))
        self.assertIn("cp SKILL_DEMAGIC", text)  # ResolveStepBranchOnAction: $83 DeMagic
        self.assertIn("db SKILL_BEDRAGON, SKILL_FIREAIR, SKILL_SUCKAIR ; natural skills", text)

    def test_action_ids_whose_string_repeats_a_skill(self):
        """E-0365: ids from 175 on whose string only repeats an earlier skill's name are actions, not skills."""
        self.assertEqual(self.c["SKILL"][0xB2], ("ACTION_B2", "HighJump"))
        self.assertEqual(self.c["SKILL"][0xAA][0], "SKILL_AHHH_AA")  # below 175: a skill table entry
        inc = (ROOT / "src" / "constants.inc").read_text(encoding="utf-8")
        self.assertNotIn("SKILL_HIGHJUMP_", inc)
        self.assertIn("DEF ACTION_CF EQU $CF ; a battle action whose StringTable_SkillNames entry only repeats 'LoveRain'", inc)

    def test_indexed_cases_sit_at_their_id(self):
        """E-0342: ApplyEquipmentEffect_<Item> is entry (item id - $40) of ApplyEquipmentEffectKeepA_ByItem."""
        text = next(ROOT.glob("src/*/bank*_items_battle_end.asm")).read_text(encoding="utf-8")
        m = re.search(r"^ApplyEquipmentEffectKeepA_ByItem::\n(?:.*\n)*?\s+jumptable\n((?:\s+dw \w+\n)+)", text, re.M)
        entries = re.findall(r"dw (\w+)", m.group(1))
        named = [(k, e) for k, e in enumerate(entries) if e.startswith("ApplyEquipmentEffect_")]
        self.assertGreaterEqual(len(named), 10)
        for k, e in named:
            want = re.sub(r"[^A-Za-z0-9]", "", self.c["ITEM"][0x40 + k][1]).upper()
            self.assertEqual(e.split("_", 1)[1].upper(), want, e)


if __name__ == "__main__":
    unittest.main()
