"""tools/label_map.py and tools/readability_queue.py: rename bookkeeping and the work queue (E-0368)."""
import json
import sys
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import label_map  # noqa: E402
import readability_queue  # noqa: E402

LISTING = """SECTION "Bank 05", ROMX[$4000], BANK[$05]
Inn::
Func_005_4001:: ; address name
    ret
Inn_Step:: ; heuristic: follows a terminator; C0
Func_005_4002:: ; address name
    ret
Inn_Data::
Data_005_4003:: ; address name
    db $00
"""


class Snapshots(unittest.TestCase):
    def snap(self, text):
        with tempfile.TemporaryDirectory() as d:
            (Path(d) / "bank05.asm").write_text(text, encoding="utf-8")
            return label_map.snapshot(Path(d))

    def test_labels_by_address(self):
        self.assertEqual(self.snap(LISTING), {"05:4001": "Inn", "05:4002": "Inn_Step", "05:4003": "Inn_Data"})

    def test_an_empty_listing_has_no_labels(self):
        self.assertEqual(self.snap(""), {})

    def test_diff_maps_changed_names_by_address(self):
        old = self.snap(LISTING)
        new = self.snap(LISTING.replace("Inn", "InnMenu"))
        self.assertEqual(label_map.diff(old, new), {"Inn": "InnMenu", "Inn_Step": "InnMenu_Step",
                                                    "Inn_Data": "InnMenu_Data"})
        self.assertEqual(label_map.diff(old, old), {})


class Rewrite(unittest.TestCase):
    MP = {"Inn": "InnMenu", "Inn_Step": "InnMenu_Init"}

    def test_whole_names_only(self):
        t, n = label_map.rewrite("calls Inn_Step and Inn, not Inn_Steps or MyInn or .Inn", self.MP)
        self.assertEqual(t, "calls InnMenu_Init and InnMenu, not Inn_Steps or MyInn or .Inn")
        self.assertEqual(n, 2)

    def test_former_names_are_kept(self):
        t, n = label_map.rewrite("now Inn_Step (was Inn_Step; renamed from Inn)", self.MP)
        self.assertEqual(t, "now InnMenu_Init (was Inn_Step; renamed from Inn)")
        self.assertEqual(n, 1)

    def test_apply_keeps_json_valid(self):
        with tempfile.TemporaryDirectory() as d:
            root = Path(d)
            (root / "config").mkdir()
            (root / "tests").mkdir()
            (root / "config/names.json").write_text(json.dumps({"05:4001": {"note": "runs Inn_Step"}}), encoding="utf-8")
            (root / "tests/test_x.py").write_text("NAME = 'Inn'\n", encoding="utf-8")
            self.assertEqual(label_map.apply(self.MP, root), 2)
            self.assertIn("InnMenu_Init", (root / "config/names.json").read_text(encoding="utf-8"))
            self.assertEqual((root / "tests/test_x.py").read_text(encoding="utf-8"), "NAME = 'InnMenu'\n")


class Queue(unittest.TestCase):
    GIVEN = {"Inn", "CopyBytes", "ShopMenu"}

    def test_instruction_named(self):
        q = readability_queue.instruction_named
        for name in ("Inn_WriteTemp0AndTemp1Etc", "Inn_ToCopyBytes", "Inn_Skip", "Inn_ReadByteAtHLPlusA",
                     "Inn_Skip_Bank05"):
            self.assertTrue(q(name, self.GIVEN), name)
        for name in ("Inn", "CopyBytes_Bank05", "CopyBytes_B13_2", "Inn_ShowWelcomeToOurInn", "TalkMsg0047_HeroRead",
                     "ScriptCommandEE", "BattleTextPrep01"):
            self.assertFalse(q(name, self.GIVEN), name)

    def test_queues_from_a_bank_file(self):
        text = ("; reads it (C1, E-0357)\nInn::\n    ret\n\n; old note (E-0100)\nInn_Skip::\n    ret\n\n"
                "; data read by Inn (2 bytes) (E-0347)\nInn_Data::\n    db $00, $01\n"
                "Inn_Data2::\n    db $02\n\n; a table of prices (E-0100)\nPrices::\n    db $05\n")
        with tempfile.TemporaryDirectory() as d:
            root = Path(d)
            (root / "config").mkdir()
            (root / "config/names.json").write_text(json.dumps({"05:4001": {"name": "Inn"}}), encoding="utf-8")
            f = root / "bank05_inn.asm"
            f.write_text(text, encoding="utf-8")
            q = readability_queue.queues([f], root)
        self.assertEqual([w.split()[-1] for w in q["instruction"]], ["Inn_Skip"])
        self.assertEqual([w.split()[-1] for w in q["unread"]], ["Inn_Skip"])
        self.assertEqual([w.split()[-1] for w in q["data"]], ["Inn_Data", "Inn_Data2"])
        self.assertEqual(q["long"], [])

    def test_an_asset_with_a_hand_note_leaves_the_asset_queue(self):
        text = ('; LZSS-compressed (E-0016)\nGfx16_1::\n    INCBIN "gfx/misc/gfx16_1.lz"\n\n'
                '; The title logo tiles: loaded to vTiles1 by the title screen. (C1, E-0373)\nTitleLogoTiles::\n'
                '    INCBIN "gfx/misc/title_logo_tiles.lz"\n')
        with tempfile.TemporaryDirectory() as d:
            root = Path(d)
            (root / "config").mkdir()
            (root / "config/names.json").write_text(json.dumps({}), encoding="utf-8")
            f = root / "bank16_items.asm"
            f.write_text(text, encoding="utf-8")
            q = readability_queue.queues([f], root)
        self.assertEqual([w.split()[-1] for w in q["asset"]], ["gfx/misc/gfx16_1.lz"])


if __name__ == "__main__":
    unittest.main()
