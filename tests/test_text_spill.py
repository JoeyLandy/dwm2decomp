"""tools/text_spill.py: room in a full message bank, by moving its last messages to its overflow table.

The twelve split message groups are read from src/ (the split is the first list's length in each). A copy of src/
has three groups spilled (bank $28's to the empty bank $9A, bank $80's in place, bank $82's to $8F), then 30 bank-$28
messages grown by more than the bank had free (refused before the spill). The copy builds, and on tools/sm83.py every
id of the three groups shows and copies the same string as the reference, except the 30 grown ones, which show
their new text. A ROM with two overflow pointers swapped is caught, and the opening plays, showing the grown
narration.
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
GROUPS = {"28": ("97", 0xDA), "29": ("97", 0x8E), "2A": ("97", 0x95), "2B": ("98", 0x8A), "2C": ("98", 0x91),
          "2D": ("99", 0xD5), "2E": ("99", 0xA6), "7C": ("99", 0x87), "80": ("96", 0xC8), "82": ("96", 0x90),
          "83": ("97", 0xC7), "89": ("98", 0xDE)}
MORE = "<PROMPT><NEXT>And more.<PROMPT>@"


def tree_bytes(src: Path) -> dict[str, bytes]:
    return {p.relative_to(src).as_posix(): p.read_bytes() for p in src.rglob("*") if p.is_file()}


class Groups(unittest.TestCase):
    def test_the_twelve_split_groups(self):
        got = {g.bank: (g.over_file.name[4:6].upper(), g.split) for g in S.groups(S.Tree(ROOT / "src"))}
        self.assertEqual(got, GROUPS)
        for g in S.groups(S.Tree(ROOT / "src")):
            self.assertEqual(len(g.main_list), g.split)


class Refusals(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.src = Path(self.tmp.name) / "src"
        shutil.copytree(ROOT / "src", self.src)
        self.before = tree_bytes(self.src)

    def tearDown(self):
        self.tmp.cleanup()

    def refused(self, *args, says=""):
        with self.assertRaises(ValueError) as e:
            S.spill(*args)
        self.assertIn(says, str(e.exception))
        self.assertEqual(tree_bytes(self.src), self.before)  # nothing written

    def test_refusals_change_nothing(self):
        self.refused(self.src, "28", 0, "9A", says="N must be")
        self.refused(self.src, "28", 0xDA, "9A", says="N must be")
        self.refused(self.src, "2F", 1, "9A", says="no split message group")
        # Message_00_AC is shown for ids on both sides of a split lowered by 10
        self.refused(self.src, "28", 10, "9A", says="spill 8 or 9 instead")
        self.refused(self.src, "28", 9, None, says="bank97_strings_97.asm is full")  # $97 has no fill
        self.refused(self.src, "28", 9, "29", says="not one of the empty banks")

    def test_src_itself_is_refused(self):
        with self.assertRaises(ValueError):
            S.spill(ROOT / "src", "28", 9, "9A")

    def test_the_cli_reports_a_refusal(self):
        p = subprocess.run([sys.executable, "-I", str(ROOT / "tools/text_spill.py"), "spill", "28", "10", "--to", "9A",
                            "--src", str(self.src)], capture_output=True, text=True)
        self.assertEqual(p.returncode, 1)
        self.assertIn("refused:", p.stdout)


@unittest.skipUnless(REF.exists(), "needs the reference ROM")
class Spilled(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.tmp = tempfile.TemporaryDirectory(dir=ROOT / "build")
        src = cls.src = Path(cls.tmp.name) / "src"
        shutil.copytree(ROOT / "src", src)
        data = X.export(src)
        cls.grow = [e for e in data["entries"] if e["file"].endswith("bank28_messages_28.asm")][:30]
        for e in cls.grow:
            e["text"] = e["text"].replace("@", MORE, 1)
        with tempfile.TemporaryDirectory() as t:  # the same growth without a spill has no room
            shutil.copytree(src, Path(t) / "src")
            with _raises(ValueError) as cls.no_room:
                X.apply(Path(t) / "src", {"entries": cls.grow})
        cls.spills = [S.spill(src, "28", 9, "9A"), S.spill(src, "80", 17), S.spill(src, "82", 15, "8F")]
        cls.applied = X.apply(src, {"entries": cls.grow})
        out = Path(cls.tmp.name).relative_to(ROOT).as_posix() + "/run"
        cls.build = subprocess.run([sys.executable, "-I", str(ROOT / "tools/build.py"), "--out", out, "--src", str(src)],
                                   cwd=ROOT, capture_output=True, text=True)
        cls.outdir = ROOT / out
        cls.ref = REF.read_bytes()
        refbuild = subprocess.run([sys.executable, "-I", str(ROOT / "tools/build.py"), "--out",
                                   Path(cls.tmp.name).relative_to(ROOT).as_posix() + "/ref"],
                                  cwd=ROOT, capture_output=True, text=True)
        assert refbuild.returncode == 0, refbuild.stdout + refbuild.stderr
        cls.ref_sym = shift_test.read_sym(Path(cls.tmp.name) / "ref/dwm2.sym")
        cls.rom = (cls.outdir / "dwm2.gbc").read_bytes() if (cls.outdir / "dwm2.gbc").exists() else b""
        cls.sym = shift_test.read_sym(cls.outdir / "dwm2.sym") if cls.rom else {}
        cls.counts = {g.bank: len(g.main_list) + len(g.over_list) for g in S.groups(S.Tree(ROOT / "src"))
                      if g.bank in ("28", "80", "82")}

    @classmethod
    def tearDownClass(cls):
        cls.tmp.cleanup()

    def test_the_growth_needed_the_spill(self):
        self.assertIn("tools/text_spill.py", str(self.no_room.exception))
        self.assertEqual([r["split"] for r in self.spills], ["$DA -> $D1", "$C8 -> $B7", "$90 -> $81"])
        self.assertEqual([r["overflow_bank"] for r in self.spills], ["9A", "96", "8F"])
        self.assertEqual(self.applied["entries"], 30)

    def test_the_spilled_copy_builds(self):
        self.assertEqual(self.build.returncode, 0, self.build.stdout + self.build.stderr)
        self.assertIn("MODDED BUILD", self.build.stdout)

    def test_every_id_shows_the_same_string_except_the_grown_ones(self):
        bad = [b for b in S.verify(self.ref, self.ref_sym, self.rom, self.sym, self.counts)
               if not b.startswith("skipped")]
        grown_ids = {f"bank $28 id ${i:02X}: shows another string" for i in range(30)} | \
                    {f"bank $28 id ${i:02X}: copies another string" for i in range(30)}
        self.assertEqual(set(bad), grown_ids)
        self.assertEqual(S.shown(self.rom, self.sym, "28", 0)[-len(X.to_bytes(MORE)):], X.to_bytes(MORE))

    def test_moved_strings_are_in_the_new_bank(self):
        b, _ = self.sym["BeginStringDisplay_Bank28_Overflow"]
        self.assertEqual(b, 0x9A)
        self.assertEqual(self.rom[0x9A * 0x4000], 0x9A)  # the byte LookupString reads
        gb = S.call(self.rom, *self.sym["BeginStringDisplay_Bank28"], 0xD9)
        self.assertEqual(gb.rb(S.W_STRING_BANK), 0x9A)

    def test_a_swapped_pointer_is_caught(self):
        bank, addr = self.sym["StringList_Bank28_Overflow_0"]
        off = bank * 0x4000 + addr - 0x4000
        rom = bytearray(self.rom)
        rom[off:off + 4] = rom[off + 2:off + 4] + rom[off:off + 2]
        bad = [b for b in S.verify(self.ref, self.ref_sym, bytes(rom), self.sym, {"28": 256})
               if "id $D1" in b or "id $D2" in b]
        self.assertEqual(len(bad), 4)

    def test_the_text_round_trips_and_exports_the_new_file(self):
        self.assertEqual(X.check(self.src), [])
        files = {e["id"]: e["file"] for e in X.export(self.src)["entries"]}
        self.assertEqual(files["Message_00_D9"], "text/bank9a_messages_28_overflow.asm")
        self.assertEqual(files["Text_YouHaveRaisedYour"], "text/bank9a_messages_28_overflow.asm")

    def test_the_opening_plays_and_shows_the_grown_text(self):
        # the opening narration is Message_00_00, one of the 30 grown messages: the screens are the reference's
        # until it is drawn (frame 2,042), then differ, with no crash, data run, lost progress or stall
        res = mod_check.check(self.rom, self.sym, 3000, data=mod_check.data_map(self.src, self.sym, len(self.rom)),
                              ref=self.ref)
        self.assertEqual((res["crash"], res["ran_data"], res["progress"], res["stall"]), (None, None, None, None))
        self.assertGreater(res["first_difference"], 2000)


class _raises:
    """assertRaises outside a test method (setUpClass): keeps the exception for a later assertion."""

    def __init__(self, kind):
        self.kind = kind
        self.exception = None

    def __enter__(self):
        return self

    def __exit__(self, kind, value, tb):
        if kind is None:
            raise AssertionError(f"{self.kind.__name__} not raised")
        if not issubclass(kind, self.kind):
            return False
        self.exception = value
        return True


if __name__ == "__main__":
    unittest.main()
