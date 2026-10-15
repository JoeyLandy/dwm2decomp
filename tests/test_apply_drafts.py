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


@unittest.skipUnless((ROOT / "local/roms/dwm2-cobi-us.gbc").is_file(), "reference ROM not present")
class Probes(unittest.TestCase):
    """D-012: a draft's probes must pass and belong to labels it marks probed; a kept note becomes C2."""

    MUL = {"label": "Multiply8By16", "bank": "00", "address": "16AA", "kind": "code", "proposed_name": None,
           "note": None, "confidence": "C1", "probe_status": "probed", "evidence_read": ["body"], "_draft": "d.json"}
    PROBE = {"id": "00:16AA#1", "label": "Multiply8By16", "bank": "00", "address": "16AA",
             "regs": {"a": 3, "b": 1, "c": 2}, "expect": {"regs": {"e": 0, "h": 3, "l": 6}}, "_draft": "d.json"}

    def test_a_passing_probe_of_a_probed_label(self):
        self.assertEqual(apply_drafts.validate_probes([dict(self.PROBE)], [dict(self.MUL)]), [])

    def test_failing_orphan_and_missing_probes(self):
        bad = dict(self.PROBE, expect={"regs": {"l": 7}})
        self.assertTrue(any("fails" in p for p in apply_drafts.validate_probes([bad], [dict(self.MUL)])))
        orphan = apply_drafts.validate_probes([dict(self.PROBE)], [dict(self.MUL, probe_status="not_probed")])
        self.assertTrue(any("not a drafted label marked probed" in p for p in orphan))
        self.assertTrue(any("has no probe" in p for p in apply_drafts.validate_probes([], [dict(self.MUL)])))
        twice = apply_drafts.validate_probes([dict(self.PROBE), dict(self.PROBE)], [dict(self.MUL)])
        self.assertTrue(any("repeated id" in p for p in twice))

    def test_c2_needs_a_probe(self):
        probs = apply_drafts.validate_probes([], [dict(self.MUL, probe_status="not_probed", confidence="C2")])
        self.assertTrue(any("C2 without a probe" in p for p in probs))

    def test_a_kept_hand_note_becomes_c2(self):
        with Root() as root:
            (root / "config/annotations.json").write_text(json.dumps(
                {"_comment": "x", "00:16AA": "E:H:L = A * BC. (C1, E-0357)"}, indent=2) + "\n", encoding="utf-8")
            apply_drafts.apply([dict(self.MUL)], {"00:16AA": "Multiply8By16"}, "E-0372", root)
            ann = json.loads((root / "config/annotations.json").read_text(encoding="utf-8"))
            self.assertEqual(ann["00:16AA"], "E:H:L = A * BC. (C2, E-0357; probed E-0372)")
            import present
            self.assertTrue(present.HAND_NOTE.search(ann["00:16AA"]))  # still a hand reading


if __name__ == "__main__":
    unittest.main()
