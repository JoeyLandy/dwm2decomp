"""tools/apply_drafts.py: reading drafts are validated before they reach config/ (E-0368)."""
import json
import sys
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import apply_drafts  # noqa: E402

SNAP = {"05:4001": "Inn", "05:4002": "Inn_Skip", "05:4010": "Inn_Data", "05:4020": "ShopMenu"}
NAMES = ('{\n  "_comment": "x",\n  "05:4001": {\n    "name": "Inn",\n    "evidence": "E-0001"\n  },\n'
         '  "05:4020": {"name": "ShopMenu", "evidence": "E-0002"}\n}\n')


def entry(**kw):
    e = {"label": "Inn_Skip", "bank": "05", "address": "4002", "kind": "code", "proposed_name": "Inn_CloseWindow",
         "note": "Closes the inn's window and returns to the field.", "confidence": "C1",
         "evidence_read": ["Inn_Skip body"], "open_questions": [], "_draft": "d.json"}
    e.update(kw)
    return e


class Root:
    def __enter__(self):
        self.d = tempfile.TemporaryDirectory()
        root = Path(self.d.name)
        (root / "config").mkdir()
        (root / "src").mkdir()
        (root / "config/names.json").write_text(NAMES, encoding="utf-8")
        (root / "config/annotations.json").write_text(json.dumps({"_comment": "x"}, indent=2) + "\n", encoding="utf-8")
        (root / "config/tables.json").write_text(json.dumps({"_comment": "x", "tables": []}, indent=2) + "\n",
                                                 encoding="utf-8")
        (root / "src/ram.asm").write_text("DEF wInnState EQU $C000\n", encoding="utf-8")
        return root

    def __exit__(self, *a):
        self.d.cleanup()


class Validate(unittest.TestCase):
    def check(self, *entries):
        with Root() as root:
            return apply_drafts.validate(list(entries), SNAP, root)

    def test_a_good_entry(self):
        self.assertEqual(self.check(entry(note="Clears wInnState, then jumps to ShopMenu.")), [])

    def test_wrong_label_at_the_address(self):
        self.assertIn("the label at 05:4002 is Inn_Skip, not Inn", self.check(entry(label="Inn"))[0])

    def test_collisions_and_duplicates(self):
        self.assertTrue(any("already the label" in p for p in self.check(entry(proposed_name="ShopMenu"))))
        dup = self.check(entry(), entry(label="Inn_Data", address="4010", kind="data"))
        self.assertTrue(any("also proposed" in p for p in dup))

    def test_a_label_renamed_away_frees_its_name(self):
        both = self.check(entry(label="ShopMenu", address="4020", proposed_name="ShopMenu_Main"),
                          entry(proposed_name="ShopMenu"))
        self.assertEqual(both, [])

    def test_mechanical_and_long_names(self):
        for bad in ("Inn_WriteAEtc", "Inn_Step_2", "Inn_Case05", "Func_005_4002", "inn_skip", "Inn" + "X" * 50):
            self.assertTrue(self.check(entry(proposed_name=bad)), bad)

    def test_notes_cite_only_existing_names(self):
        probs = self.check(entry(note="Calls MissingRoutine_Helper and returns to the field."))
        self.assertTrue(any("MissingRoutine_Helper" in p for p in probs))
        self.assertTrue(self.check(entry(note="short")))
        self.assertTrue(self.check(entry(note="Closes the window and returns (C1, E-0357)")))
        self.assertTrue(self.check(entry(note="Closes the window — and returns to the field.")))

    def test_confidence_and_evidence_are_required(self):
        self.assertTrue(self.check(entry(confidence="high")))
        self.assertTrue(self.check(entry(evidence_read=[])))
        self.assertTrue(self.check(entry(proposed_name=None, note=None)))


class Apply(unittest.TestCase):
    def test_writes_names_and_notes_keeping_other_entries(self):
        with Root() as root:
            counts = apply_drafts.apply([entry(), entry(label="Inn", address="4001", proposed_name="InnMenu",
                                                        note=None)], SNAP, "E-0369", root)
            self.assertEqual(counts, {"renamed": 2, "code_notes": 1, "data_notes": 0})
            text = (root / "config/names.json").read_text(encoding="utf-8")
            names = json.loads(text)
            self.assertEqual(names["05:4002"], {"name": "Inn_CloseWindow",
                                                "evidence": "E-0369 (named from its reading; was Inn_Skip)"})
            self.assertEqual(names["05:4001"]["name"], "InnMenu")
            self.assertIn("renamed from Inn (E-0369)", names["05:4001"]["evidence"])
            self.assertIn('  "05:4020": {"name": "ShopMenu", "evidence": "E-0002"},\n', text)  # untouched entry
            ann = json.loads((root / "config/annotations.json").read_text(encoding="utf-8"))
            self.assertEqual(ann["05:4002"], "Closes the inn's window and returns to the field. (C1, E-0369)")

    def test_data_notes_go_to_names_with_the_data_flag(self):
        with Root() as root:
            apply_drafts.apply([entry(label="Inn_Data", address="4010", kind="data", proposed_name=None,
                                      note="Eight prices, one word each, in gold.")], SNAP, "E-0369", root)
            names = json.loads((root / "config/names.json").read_text(encoding="utf-8"))
            self.assertEqual(names["05:4010"], {"name": "Inn_Data", "evidence": "E-0369", "data": True,
                                                "note": "Eight prices, one word each, in gold. (C1, E-0369)"})


if __name__ == "__main__":
    unittest.main()
