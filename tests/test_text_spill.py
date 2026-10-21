"""tools/text_spill.py: room in a full message bank, by moving its last messages to its overflow table, and in a
bank without a split (the battle text), by moving whole string categories to an empty bank (CategorySpill, E-0418).

The thirteen split message groups (bank $0E's with E-0417) are read from src/ (the split is the first list's length in each). A copy of src/
has three groups spilled (bank $28's to the empty bank $9A, bank $80's in place, bank $82's to $8F), then 30 bank-$28
messages grown by more than the bank had free (refused before the spill). The copy builds, and on tools/sm83.py every
id of the three groups shows and copies the same string as the reference, except the 30 grown ones, which show
their new text. A ROM with two overflow pointers swapped is caught, and the opening plays, showing the grown
narration. ReaderSpills (E-0420): banks $09 and $0D, whose tables other code reads directly.
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
GROUPS = {"0E": ("96", 0x88), "28": ("97", 0xDA), "29": ("97", 0x8E), "2A": ("97", 0x95), "2B": ("98", 0x8A), "2C": ("98", 0x91),
          "2D": ("99", 0xD5), "2E": ("99", 0xA6), "7C": ("99", 0x87), "80": ("96", 0xC8), "82": ("96", 0x90),
          "83": ("97", 0xC7), "89": ("98", 0xDE)}
MORE = "<PROMPT><NEXT>And more.<PROMPT>@"


_REF: dict = {}


def reference() -> tuple[bytes, dict]:
    """The reference ROM and the symbols of a build of src/ (built once for the module's classes)."""
    if not _REF:
        _REF["tmp"] = tempfile.TemporaryDirectory(dir=ROOT / "build")
        out = Path(_REF["tmp"].name).relative_to(ROOT).as_posix() + "/ref"
        p = subprocess.run([sys.executable, "-I", str(ROOT / "tools/build.py"), "--out", out], cwd=ROOT,
                           capture_output=True, text=True)
        assert p.returncode == 0, p.stdout + p.stderr
        _REF["rom"], _REF["sym"] = REF.read_bytes(), shift_test.read_sym(ROOT / out / "dwm2.sym")
    return _REF["rom"], _REF["sym"]


def tearDownModule():
    if _REF:
        _REF["tmp"].cleanup()


def tree_bytes(src: Path) -> dict[str, bytes]:
    return {p.relative_to(src).as_posix(): p.read_bytes() for p in src.rglob("*") if p.is_file()}


class Groups(unittest.TestCase):
    def test_the_thirteen_split_groups(self):
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
        cls.ref, cls.ref_sym = reference()
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


@unittest.skipUnless(REF.exists(), "needs the reference ROM")
class CategorySpill(unittest.TestCase):
    """Battle text (bank $2F, 725 free bytes) has no split: categories 1-5 move to the empty bank $9D, then 60
    category-1 strings grown by 18 bytes each (more than the bank had free) fit. Every (category, id) shows and copies
    the reference's string except the grown ones. A debug battle (E-0320 d06!) prints what the reference prints, up to
    a grown string it shows, whose added words follow; its categories 1 and 5 are read through the new bank."""

    @classmethod
    def setUpClass(cls):
        cls.tmp = tempfile.TemporaryDirectory(dir=ROOT / "build")
        src = cls.src = Path(cls.tmp.name) / "src"
        shutil.copytree(ROOT / "src", src)
        with tempfile.TemporaryDirectory() as t:
            shutil.copytree(src, Path(t) / "src")
            for args in (("2F", 0, "9D"), ("2F", 6, "9D"), ("09", 1, "9D"), ("2F", 1, "29")):
                with _raises(ValueError):
                    S.spill_categories(Path(t) / "src", *args)
            cls.unchanged = tree_bytes(Path(t) / "src") == tree_bytes(src)
        cls.result = S.spill_categories(src, "2F", 1, "9D")
        data = X.export(src)
        cls.grow = [e for e in data["entries"] if any(u.startswith("StringList_Bank2F_StringCategories_1[")
                                                      for u in e["used_by"])][:60]
        for e in cls.grow:
            e["text"] = e["text"][:-1] + "<PROMPT><NEXT>It is over.@"
        cls.applied = X.apply(src, {"entries": cls.grow})
        out = Path(cls.tmp.name).relative_to(ROOT).as_posix() + "/run"
        cls.build = subprocess.run([sys.executable, "-I", str(ROOT / "tools/build.py"), "--out", out, "--src", str(src)],
                                   cwd=ROOT, capture_output=True, text=True)
        cls.rom = (ROOT / out / "dwm2.gbc").read_bytes() if cls.build.returncode == 0 else b""
        cls.sym = shift_test.read_sym(ROOT / out / "dwm2.sym") if cls.rom else {}
        cls.ref, cls.ref_sym = reference()

    @classmethod
    def tearDownClass(cls):
        cls.tmp.cleanup()

    def test_refusals_change_nothing(self):
        self.assertTrue(self.unchanged)

    def test_the_battle_text_moves_and_grows(self):
        self.assertEqual((self.result["categories"], self.result["to"]), ("$01-$05", "9D"))
        self.assertEqual(self.result["lists"], {0: 137, 1: 256, 2: 4, 3: 1, 4: 1, 5: 34})
        self.assertEqual(self.applied["entries"], 60)
        self.assertGreater(self.applied["bytes"], 725)  # more than bank $2F had free
        self.assertEqual(self.build.returncode, 0, self.build.stdout + self.build.stderr)

    def test_every_string_but_the_grown_ones_is_the_same(self):
        grown = {e["id"] for e in self.grow}
        lists = {k: v for k, v in self.result["lists"].items()}
        bad = [b for b in S.verify_categories(self.ref, self.ref_sym, self.rom, self.sym, "2F", lists)
               if not b.startswith("skipped")]
        ids = {(int(b.split("category ")[1].split()[0]), int(b.split("id $")[1][:2], 16)) for b in bad}
        self.assertTrue(ids)
        self.assertTrue(all(c == 1 for c, _ in ids))
        self.assertEqual(len(ids), len(grown))
        self.assertEqual(S.call(self.rom, *self.sym["BeginStringDisplay_Bank2F"], 0, 1).rb(S.W_STRING_BANK), 0x9D)

    def test_a_battle_prints_the_same_through_the_new_bank(self):
        import pickle
        import boot_trace
        import play
        import text_check as TC
        spill = self.sym["BeginStringDisplay_Bank2F_Spill"]
        start = TC.base("d06!")
        recipe = play.parse("A W30 A*30 W100 A*30 W200 A*30 W200")

        def drawn(rom):
            gb = pickle.loads(start)
            gb.rom = rom  # only banks $2F and $9D differ, and the machine is not in them here
            log, hits = [], []
            for addr, kind in ((TC.GLYPH, "glyph"), (TC.CODE, "code")):
                gb.pc_hooks[addr] = (lambda k: lambda g: log.append((g.cycles // play.FRAME, k, g.a))
                                     if g.pc < 0x4000 else None)(kind)
            gb.pc_hooks[spill[1]] = lambda g: hits.append(g.rb(S.W_STRING_CATEGORY)) if g.rombank == spill[0] else None
            play.run(gb, recipe, boot_trace.load_labels(), {})
            return log, hits

        # the battle shows one of the grown category-1 strings: the printer draws what the reference draws up to its
        # end, then the added "It is over." (read from bank $9D)
        ref_log, _ = drawn(self.ref)
        mod_log, hits = drawn(self.rom)
        self.assertGreater(len(ref_log), 1000)
        k = next(i for i, (x, y) in enumerate(zip(ref_log, mod_log)) if x != y)
        self.assertGreater(k, 10)
        self.assertEqual(ref_log[k][1:], ("code", 0xF0))  # the reference's string ends here
        glyphs = bytes(v for _f, kind, v in mod_log[k:] if kind == "glyph")
        self.assertIn(X.to_bytes("It is over."), glyphs)
        self.assertEqual(sorted(set(hits)), [1, 5])


class ReaderSpills(unittest.TestCase):
    """E-0420: the banks whose tables other code reads directly. Bank $09 (6,790 free bytes) moves categories 4-9 to
    the empty bank $9D; its key-name readers (DrawKeyListPageNames, LinkKeyTrade_WriteStoryKeyName) read category 6
    through the new bank's table, and name the bank they copy from as BANK(StringList_Bank09_StringCategories_6).
    Bank $0D (152 free bytes) moves its first 37 strings to $9E; MedalPrizeMenu_DrawPrizeNames reads ids $28 and up
    straight from the list, which keeps its length. Ten moved strings then grow by more than bank $0D had free."""

    KEYS = [bytes([i, 6, 0x25, 0x80]) for i in range(13)]  # story keys 0-12 (byte 3 bit 7), wKeyList records

    @classmethod
    def setUpClass(cls):
        cls.tmp = tempfile.TemporaryDirectory(dir=ROOT / "build")
        src = cls.src = Path(cls.tmp.name) / "src"
        shutil.copytree(ROOT / "src", src)
        cls.refusals = {}
        with tempfile.TemporaryDirectory() as t:
            shutil.copytree(src, Path(t) / "src")
            for key, fn, args in (("09_3", S.spill_categories, ("09", 3, "9D")), ("0D_40", S.spill_strings, ("0D", 40, "9E")),
                                  ("2F_strings", S.spill_strings, ("2F", 5, "9E"))):
                with _raises(ValueError) as r:
                    fn(Path(t) / "src", *args)
                cls.refusals[key] = str(r.exception)
            data = X.export(Path(t) / "src")
            cls.grow = [e for e in data["entries"] if e["id"].startswith("String_0D_00_")][:10]
            for e in cls.grow:
                e["text"] = e["text"][:-1] + "<PROMPT><NEXT>There is more<NEXT>to say about it.@"
            with _raises(ValueError) as r:
                X.apply(Path(t) / "src", {"entries": cls.grow})
            cls.no_room = str(r.exception)
            cls.unchanged = tree_bytes(Path(t) / "src") == tree_bytes(src)
        cls.r09 = S.spill_categories(src, "09", 4, "9D")
        cls.r0d = S.spill_strings(src, "0D", 37, "9E")
        cls.applied = X.apply(src, {"entries": cls.grow})
        out = Path(cls.tmp.name).relative_to(ROOT).as_posix() + "/run"
        cls.build = subprocess.run([sys.executable, "-I", str(ROOT / "tools/build.py"), "--out", out, "--src", str(src)],
                                   cwd=ROOT, capture_output=True, text=True)
        cls.rom = (ROOT / out / "dwm2.gbc").read_bytes() if cls.build.returncode == 0 else b""
        cls.sym = shift_test.read_sym(ROOT / out / "dwm2.sym") if cls.rom else {}
        cls.ref, cls.ref_sym = reference()

    @classmethod
    def tearDownClass(cls):
        cls.tmp.cleanup()

    def key_names(self, rom, sym):
        return [n for p in range(0, 13, 4)
                for n in S.names_drawn(rom, sym, "DrawKeyListPageNames", list(range(p, min(p + 4, 13))), self.KEYS)]

    def test_refusals_change_nothing(self):
        self.assertTrue(self.unchanged)
        self.assertIn("CopyKeyNameWordToDE_StringList (category 3) is read outside the table", self.refusals["09_3"])
        self.assertIn("the largest N below that works is 37", self.refusals["0D_40"])
        self.assertIn("has 6 categories", self.refusals["2F_strings"])
        self.assertIn("text_spill", self.no_room)

    def test_both_spill_and_build(self):
        self.assertEqual((self.r09["categories"], self.r09["to"], self.r09["readers"]),
                         ("$04-$09", "9D", ["DrawKeyListPageNames (category 6)", "LinkKeyTrade_WriteStoryKeyName (category 6)"]))
        self.assertEqual((self.r0d["ids"], self.r0d["to"], self.r0d["readers_from"]), ("$00-$24", "9E", "$28"))
        self.assertGreater(self.applied["bytes"], 152)  # more than bank $0D had free
        self.assertEqual(self.build.returncode, 0, self.build.stdout + self.build.stderr)

    def test_every_string_is_the_same_but_the_grown_ones(self):
        lengths = {0: 3, 1: 26, 2: 10, 3: 73, 4: 1, 5: 84, 6: 13, 7: 15, 8: 1, 9: 34}
        self.assertEqual(self.r09["lists"], lengths)
        self.assertEqual(S.verify_categories(self.ref, self.ref_sym, self.rom, self.sym, "09", lengths), [])
        tree = S.Tree(self.src)  # ids that name a grown string (some ids share one)
        f, i = tree.where("StringList_Bank0D_Spill")
        labels = {e["id"] for e in self.grow}
        grown = {k for k, (_l, x) in enumerate(S.dw_list(tree.files[f], i)) if x in labels}
        self.assertGreaterEqual(len(grown), 10)
        bad = S.verify_categories(self.ref, self.ref_sym, self.rom, self.sym, "0D", {0: 47})
        self.assertEqual({int(b.split("id $")[1][:2], 16) for b in bad}, grown)
        self.assertEqual(S.call(self.rom, *self.sym["BeginStringDisplay_Bank0D"], 0).rb(S.W_STRING_BANK), 0x9E)
        self.assertEqual(S.call(self.rom, *self.sym["BeginStringDisplay_Bank09"], 0, 5).rb(S.W_STRING_BANK), 0x9D)

    def test_the_direct_readers_draw_the_same_names(self):
        self.assertEqual(self.key_names(self.ref, self.ref_sym), self.key_names(self.rom, self.sym))
        prizes = lambda rom, sym: (S.names_drawn(rom, sym, "MedalPrizeMenu_DrawPrizeNames", [0, 1, 2, 3]) +
                                   S.names_drawn(rom, sym, "MedalPrizeMenu_DrawPrizeNames", [4, 5, 6]))
        want = prizes(self.ref, self.ref_sym)
        self.assertEqual(len(want), 7)
        self.assertEqual(want, prizes(self.rom, self.sym))

    def test_a_reader_left_on_the_old_bank_is_caught(self):
        b, a = self.sym["DrawKeyListPageNames"]
        rom = bytearray(self.rom)
        at = rom.index(bytes([0x3E, 0x9D, 0xEA, 0xFE, 0xD7]), b * 0x4000 + a - 0x4000)  # ld a, $9D / ld [wDataBank], a
        rom[at + 1] = 0x09
        self.assertNotEqual(self.key_names(self.ref, self.ref_sym), self.key_names(bytes(rom), self.sym))


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
