"""tools/text.py on the text in code and data banks (E-0417): exported, reinserted, and read by the game.

1,084 entries live outside src/text/: bank $0E's messages, item descriptions, default names, the link and gift
banks' dialogue, the staff credits, the name-entry keyboard and record fields. Entries the game finds by their own
label may change length; record fields keep their bytes. A copy of src/ with four of them grown (bank $0E's after a
spill, since that bank had 19 free bytes) builds, and on tools/sm83.py the game's own lookups reach the new text.
"""
import shutil
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import mod_check  # noqa: E402
import shift_test  # noqa: E402
import text as X  # noqa: E402
import text_spill as S  # noqa: E402

REF = ROOT / "local/roms/dwm2-cobi-us.gbc"
EDITS = {  # entry -> new text (the first three longer than the original, the credit line the same length)
    "MessageBank0E_00": "<VOICE1>*: Its accessory is<LINE>in the Vault.<PROMPT><NEXT>Go and see it!<WAIT>@",
    "ItemDescription_ATKseed": "Raises ATK<LINE>by three points.@",
    "Text_ItsGANight": "<VOICE1>*: It's <BUF0>G a<LINE>night, my friend.<PROMPT><NEXT>Will you stay with<NEXT>"
                       "us tonight?<CHOICE>@",
    "String_E0_00_00": "EXECUTIVE PRODUCER@",
}


class Export(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.entries = {e["id"]: e for e in X.export(ROOT / "src")["entries"]}

    def test_the_other_banks_are_exported(self):
        outside = [e for e in self.entries.values() if not e["file"].startswith("text/")]
        self.assertGreater(len(outside), 1000)
        self.assertNotIn("CartridgeHeader", self.entries)  # the home bank is left out
        want = {"MessageBank0E_00": ("data/bank0e_breeding_data.asm", "message", None),
                "Text_ItsGANight": ("engine/bankf0_link_gifts.asm", "message", None),
                "ItemDescription_ATKseed": ("engine/bank24_link_priest.asm", "string", None),
                "DefaultName_Beast_05": ("engine/bank14_names_hibernate.asm", "string", None),
                "PresetMonsterRecords_01": ("engine/bank0d_medals_eggs_keys.asm", "string", 11),
                "NameEntryKeyboard": ("engine/bank14_names_hibernate.asm", "string", 181)}
        for label, (file, kind, fixed) in want.items():
            e = self.entries[label]
            self.assertEqual((e["file"], e["kind"], e.get("fixed_bytes")), (file, kind, fixed), label)

    def test_glyphs_used_outside_src_text_are_not_free(self):
        free = [g for g, _blank in X.free_glyphs(ROOT / "src")]
        self.assertNotIn(0x5F, free)  # only the name-entry keyboard uses it
        self.assertIn(0x49, free)  # the German test translation's letter
        self.assertLess(len(free), 75)  # 75 when only src/text/ was read


class Refusals(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.src = Path(self.tmp.name) / "src"
        shutil.copytree(ROOT / "src", self.src)
        self.entries = {e["id"]: e for e in X.export(self.src)["entries"]}

    def tearDown(self):
        self.tmp.cleanup()

    def test_a_record_field_keeps_its_bytes(self):
        # a 10-byte name field inside a 32-byte record (E-0034): one byte more is refused
        e = dict(self.entries["PresetMonsterRecords_01"])
        e["text"] = e["text"] + "{$f0}"
        with self.assertRaises(ValueError) as cm:
            X.apply(self.src, {"entries": [e]})
        self.assertIn("must stay 11 bytes", str(cm.exception))
        e["text"] = self.entries["PresetMonsterRecords_01"]["text"].replace("???@", "Bob@", 1)
        self.assertEqual(X.apply(self.src, {"entries": [e]}), {"entries": 1, "bytes": 0})
        lines = (self.src / "engine/bank0d_medals_eggs_keys.asm").read_text(encoding="utf-8")
        self.assertIn('    db $01 ; id 1: state: 0 empty, 1 or 2 in use (E-0104)\n'
                      '    db "Bob@", $f0, $f0, $f0, $f0, $f0, $f0 ; name, bytes 1-10 (E-0034)', lines)

    def test_a_bank_without_room_names_the_spill(self):
        # bank $0E has 19 free bytes; ten of its messages each 13 bytes longer do not fit
        grown = [dict(e) for e in self.entries.values() if e["file"] == "data/bank0e_breeding_data.asm"
                 and e["text"].endswith("<WAIT>@")][:10]
        for e in grown:
            e["text"] = e["text"][:-len("<WAIT>@")] + "<PROMPT><NEXT>Yes.<WAIT>@"
        with self.assertRaises(ValueError) as cm:
            X.apply(self.src, {"entries": grown})
        self.assertIn("text_spill", str(cm.exception))


@unittest.skipUnless(REF.exists(), "needs the reference ROM")
class Built(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.tmp = tempfile.TemporaryDirectory(dir=ROOT / "build")
        src = cls.src = Path(cls.tmp.name) / "src"
        shutil.copytree(ROOT / "src", src)
        entries = {e["id"]: e for e in X.export(src)["entries"]}
        cls.new = {}
        for label, text in EDITS.items():
            e = entries[label]
            e["text"] = text
            cls.new[label] = X.to_bytes(e["text"])
        cls.spill = S.spill(src, "0E", 11)  # bank $0E's last 11 messages to bank $96, which has room
        cls.applied = X.apply(src, {"entries": [entries[k] for k in EDITS]})
        build = Path(cls.tmp.name).relative_to(ROOT).as_posix()
        cls.build = subprocess.run([sys.executable, "-I", str(ROOT / "tools/build.py"), "--out", build + "/run",
                                    "--src", str(src)], cwd=ROOT, capture_output=True, text=True)
        cls.rom = (ROOT / build / "run/dwm2.gbc").read_bytes() if cls.build.returncode == 0 else b""
        cls.sym = shift_test.read_sym(ROOT / build / "run/dwm2.sym") if cls.rom else {}
        ref = subprocess.run([sys.executable, "-I", str(ROOT / "tools/build.py"), "--out", build + "/ref"],
                             cwd=ROOT, capture_output=True, text=True)
        assert ref.returncode == 0, ref.stdout + ref.stderr
        cls.ref, cls.ref_sym = REF.read_bytes(), shift_test.read_sym(ROOT / build / "ref/dwm2.sym")

    @classmethod
    def tearDownClass(cls):
        cls.tmp.cleanup()

    def at(self, label: str) -> bytes:
        bank, addr = self.sym[label]
        off = bank * 0x4000 + addr - 0x4000
        return self.rom[off:off + len(self.new[label])]

    def test_it_builds_with_the_edits(self):
        self.assertEqual(self.build.returncode, 0, self.build.stdout + self.build.stderr)
        self.assertEqual(self.applied["entries"], 4)
        self.assertGreater(self.applied["bytes"], 0)
        self.assertEqual(self.spill["split"], "$88 -> $7D")

    def test_the_game_shows_the_new_text(self):
        # bank $0E's message group: ids 0-11 name MessageBank0E_00; every other id is unchanged
        diffs = [d for d in S.verify(self.ref, self.ref_sym, self.rom, self.sym, {"0E": 160})
                 if not d.startswith("skipped")]
        self.assertEqual({d.split(":")[0] for d in diffs}, {f"bank $0E id ${i:02X}" for i in range(12)})
        self.assertEqual(S.shown(self.rom, self.sym, "0E", 0), self.new["MessageBank0E_00"])
        # the gift bank's and the credits' own string lookups (category 0, id 0)
        self.assertEqual(S.shown(self.rom, self.sym, "F0", 0), self.new["Text_ItsGANight"])
        self.assertEqual(S.shown(self.rom, self.sym, "E0", 0), self.new["String_E0_00_00"])

    def test_the_item_description_table_points_at_the_new_text(self):
        bank, addr = self.sym["ItemDescriptionTable"]
        off = bank * 0x4000 + addr - 0x4000 + 2 * 13
        self.assertEqual(self.rom[off] | self.rom[off + 1] << 8, self.sym["ItemDescription_ATKseed"][1])
        self.assertEqual(self.at("ItemDescription_ATKseed"), self.new["ItemDescription_ATKseed"])

    def test_the_opening_plays_like_the_reference(self):
        res = mod_check.check(self.rom, self.sym, 3000, data=mod_check.data_map(self.src, self.sym, len(self.rom)),
                              ref=self.ref)
        self.assertEqual((res["crash"], res["ran_data"], res["progress"], res["stall"], res["first_difference"]),
                         (None, None, None, None, None))


if __name__ == "__main__":
    unittest.main()
