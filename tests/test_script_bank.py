"""tools/script_bank.py (E-0421): event scripts outside bank $10, for mods.

E-0423: the patch adds far variants of the handlers in unused opcode slots and leaves the game's own unchanged.
A copy of src/ gets the patched interpreter and every movable script run of bank $10 (650 of 656: E-0422's leftovers
are read as script, and E-0423 keeps the six talk scripts that run while a data-bank script waits) moved to the empty
bank $9F, with stubs for the 418 labels named from outside. It builds, with no byte of any bank left over. On
tools/sm83.py the E-0320 farm chain (35 runs, the opening to the farm and a debug battle) fetches the same script
positions as the reference, through the stubs and bank $9F, and every run ends on the reference's screen; the
screens differ for at most three VBlanks in a run (the patched reads take more cycles). A stub whose bank byte is
broken is caught. Refusals change nothing.
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
import play  # noqa: E402
import script_bank as SB  # noqa: E402
import shift_test  # noqa: E402

REF = ROOT / "local/roms/dwm2-cobi-us.gbc"
FARM = str(ROOT / "tools/recipes/e0320_farm_battle.txt")


def tree_bytes(src: Path) -> dict[str, bytes]:
    return {p.relative_to(src).as_posix(): p.read_bytes() for p in src.rglob("*") if p.is_file()}


def build(src: Path, out: Path):
    p = subprocess.run([sys.executable, "-I", str(ROOT / "tools/build.py"), "--out", out.relative_to(ROOT).as_posix()]
                       + (["--src", str(src)] if src else []), cwd=ROOT, capture_output=True, text=True)
    return p, ((out / "dwm2.gbc").read_bytes() if p.returncode == 0 else b""), \
        (shift_test.read_sym(out / "dwm2.sym") if p.returncode == 0 else {})


class Runs(unittest.TestCase):
    def test_the_runs_of_bank_10(self):
        s = SB.summary(ROOT / "src")
        self.assertEqual((s["runs"], s["movable"], s["bytes"]), (656, 650, 6440))
        # E-0422: the leftovers after scripts' ends are read as script; E-0423: the six talk scripts the breeding,
        # arena and NPC breeding menus run while their data-bank script waits stay in bank $10
        self.assertEqual(sorted(k.split(":")[0] for k in s["not"]), sorted(SB.NESTED))

    def test_line_sizes_follow_the_macros(self):
        self.assertEqual([SB.line_bytes(x) for x in ("script_end", "script_message $0030", "script_walk 1, 0, 2",
                                                     "script_choice_jump A, B, C", "db $ff, $ff", "script_jump_far X",
                                                     "script_walk_far 1, 0, 2", "script_command_far SCRIPT_SHOP",
                                                     "script_command_far $62")],
                         [1, 3, 4, 4, 2, 4, 4, 2, 1])

    def test_the_game_handlers_are_unchanged(self):
        """E-0423: the patch adds handlers and table entries in unused slots; the game's handlers stay as they are, so
        every unmoved script runs with the original instructions."""
        with tempfile.TemporaryDirectory(dir=ROOT / "build") as d:
            src = Path(d) / "src"
            shutil.copytree(ROOT / "src", src)
            SB.patch(src)
            before = (ROOT / "src" / SB.SCRIPTS).read_text(encoding="utf-8").split("\n")
            after = (src / SB.SCRIPTS).read_text(encoding="utf-8").split("\n")
        import difflib
        removed = [x[2:] for x in difflib.ndiff(before, after) if x.startswith("- ")]
        # only the fill and the unused table entries go
        self.assertTrue(all(x.startswith("    dw $0000") or x.lstrip().startswith("ds ") for x in removed), removed[:5])
        self.assertEqual(sum(x.startswith("    dw $0000") for x in removed), 14)


class LabelPokes(unittest.TestCase):
    def test_a_poke_names_a_label_and_finds_a_moved_one(self):
        names = {"Script_A": (0x10, 0x50DB), "Script_B": (0x10, 0x6000), "Script_B_Far": (0x9F, 0x41BE)}
        self.assertEqual([play.value(v, names) for v in ("0x80", "BANK(Script_A)", "LOW(Script_A)", "HIGH(Script_A+33)",
                                                         "BANK(Script_B)", "LOW(Script_B+2)")],
                         [0x80, 0x10, 0xDB, 0x50, 0x9F, 0xC0])
        with self.assertRaises(ValueError):
            play.value("LOW(Script_A)")

    def test_the_recipes_name_their_scripts(self):
        """E-0421, E-0422: no recipe starts a script by a raw address, which a moved script would not follow."""
        for f in sorted((ROOT / "tools/recipes").glob("*.txt")):
            self.assertNotIn("wScriptPointerLo=0x", f.read_text(encoding="utf-8"), f.name)
        text = (ROOT / "tools/recipes/e0406_late_story.txt").read_text(encoding="utf-8")
        # E-0423: a byte offset into a script would not follow a moved one, whose far opcodes can be longer
        self.assertNotRegex(text, r"\(Script_\w+\+")
        self.assertIn("wScriptPointerLo=LOW(Script_SurprisinglyObedientAreYou_AfterBattle)", text)


class Refusals(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory(dir=ROOT / "build")
        self.src = Path(self.tmp.name) / "src"
        shutil.copytree(ROOT / "src", self.src)
        self.before = tree_bytes(self.src)

    def tearDown(self):
        self.tmp.cleanup()

    def test_refusals_change_nothing(self):
        cases = [(SB.move, (["Script_HehSoTheseAre"], "10"), "in bank $10 already"),
                 (SB.move, (["Script_HehSoTheseAre"], "01"), "not one of the empty banks"),
                 (SB.move, (["Script_NoSuchScript"], "9F"), "not a script label")]
        for fn, args, says in cases:
            with self.assertRaises(ValueError) as r:
                fn(self.src, *args)
            self.assertIn(says, str(r.exception))
        self.assertEqual(tree_bytes(self.src), self.before)

    def test_raw_bytes_in_a_run_are_refused(self):
        """Bytes not read as script (none are left in bank $10 since E-0422) keep their run in bank $10."""
        f = self.src / "scripts/bank10_scripts.asm"
        text = f.read_text(encoding="utf-8")
        f.write_text(text.replace("Script_WowYouKidsSure::\n", "Script_WowYouKidsSure::\n    db $00, $01\n", 1),
                     encoding="utf-8")
        before = tree_bytes(self.src)
        self.assertEqual(SB.summary(self.src)["not"]["raw bytes `...`"], 2)  # its run, and the one skipping to it
        with self.assertRaises(ValueError) as r:
            SB.move(self.src, ["Script_WowYouKidsSure"], "9F")
        self.assertIn("raw bytes", str(r.exception))
        self.assertEqual(tree_bytes(self.src), before)

    def test_src_itself_is_refused(self):
        for fn, args in ((SB.patch, ()), (SB.move, (None, "9F"))):
            with self.assertRaises(ValueError):
                fn(ROOT / "src", *args)

    def test_patching_twice_changes_nothing_more(self):
        self.assertTrue(SB.patch(self.src)["patched"])
        once = tree_bytes(self.src)
        self.assertFalse(SB.patch(self.src)["patched"])
        self.assertEqual(tree_bytes(self.src), once)
        self.assertIn("MACRO script_jump_far", (self.src / "macros.inc").read_text(encoding="utf-8"))


@unittest.skipUnless(REF.exists(), "needs the reference ROM")
class PatchOnly(unittest.TestCase):
    """E-0423: with the interpreter patched and no script moved, the farm chain plays VBlank for VBlank as the
    original (E-0421's patch differed in four runs)."""

    def test_the_patch_keeps_the_original_timing(self):
        with tempfile.TemporaryDirectory(dir=ROOT / "build") as d:
            src = Path(d) / "src"
            shutil.copytree(ROOT / "src", src)
            SB.patch(src)
            p, rom, sym = build(src, Path(d) / "run")
            self.assertEqual(p.returncode, 0, p.stdout + p.stderr)
            _p, _r, ref_sym = build(None, Path(d) / "ref")
            ta, tb = [], []
            r = mod_check.recipe_compare(FARM, REF.read_bytes(), ref_sym, rom, sym, SB.fetch_trace(sym, tb, src),
                                         SB.fetch_trace(ref_sym, ta, ROOT / "src"))
        self.assertEqual((r["runs"], r["differ"]), (35, []))
        self.assertEqual(ta, tb)


@unittest.skipUnless(REF.exists(), "needs the reference ROM")
class Moved(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.tmp = tempfile.TemporaryDirectory(dir=ROOT / "build")
        src = cls.src = Path(cls.tmp.name) / "src"
        shutil.copytree(ROOT / "src", src)
        cls.result = SB.move(src, None, "9F")
        cls.build, cls.rom, cls.sym = build(src, Path(cls.tmp.name) / "run")
        _p, _rom, cls.ref_sym = build(None, Path(cls.tmp.name) / "ref")
        cls.ref = REF.read_bytes()
        cls.ref_trace, cls.trace, cls.far = [], [], []
        hooks = SB.fetch_trace(cls.sym, cls.trace, src)
        b, a = cls.sym["ScriptFetchJumpFar"]
        hooks[a] = lambda g: cls.far.append(g.rb(SB.W_SCRIPT_IN_DATA_BANK)) if g.rombank == b else None
        cls.compare = mod_check.recipe_compare(FARM, cls.ref, cls.ref_sym, cls.rom, cls.sym, hooks,
                                               SB.fetch_trace(cls.ref_sym, cls.ref_trace, ROOT / "src")) if cls.rom else None

    @classmethod
    def tearDownClass(cls):
        cls.tmp.cleanup()

    def test_the_scripts_move_and_build(self):
        r = self.result
        self.assertEqual((r["runs"], r["labels"], r["stubs"], r["bytes"], r["left"]), (650, 667, 418, 6440, 6))
        self.assertGreater(r["bank_10_gain"], 4000)
        self.assertEqual(self.build.returncode, 0, self.build.stdout + self.build.stderr)
        self.assertEqual(self.sym["Script_HehSoTheseAre_Far"][0], 0x9F)
        self.assertEqual(self.sym["Script_ListenYouTwoQuit"][0], 0x10)  # its stub
        mapfile = (Path(self.tmp.name) / "run/dwm2.map").read_text(encoding="utf-8")
        self.assertIn("ROMX: 4177920 bytes used / 0 free", mapfile)  # every bank exactly full: the sizes add up
        self.assertIn("ROM0: 16384 bytes used / 0 free", mapfile)

    def test_the_moved_tree_passes_the_bank_check(self):
        import bank_check
        errors, warnings = bank_check.check(self.src, self.sym)
        self.assertEqual((errors, warnings), ([], []))

    def test_the_farm_chain_runs_the_same_scripts(self):
        self.assertEqual(self.compare["runs"], 35)
        self.assertGreater(len(self.ref_trace), 30)
        self.assertEqual(self.trace, self.ref_trace)
        self.assertIn(0, set(self.far))  # stubs' far jumps ran, from bank $10 (mode 0); moved scripts' own in mode 1
        self.assertLessEqual(set(self.far), {0, 1})

    def test_every_run_ends_on_the_same_screen(self):
        self.assertGreater(self.compare["frames"], 13000)
        for state, _first, n, _of, same_end in self.compare["differ"]:
            self.assertTrue(same_end, state)
            self.assertLessEqual(n, 3, state)  # the patched reads take more cycles: a frame's update may slip

    def test_a_broken_stub_is_caught(self):
        b, a = self.sym["Script_InTheMiddleOf"]
        at = b * 0x4000 + a - 0x4000
        self.assertEqual(self.rom[at:at + 2], bytes([0x08, 0x9F]))  # script_jump_far, bank $9F
        broken = bytearray(self.rom)
        broken[at + 1] = 0x9E  # an empty bank
        labels = {(bb, aa): n for n, (bb, aa) in self.sym.items() if "." not in n}

        def screen(rom):
            kept, _ = play.replay(FARM, {"s06"}, True, rom=rom, labels=labels)
            return shift_test.video_state(kept["s06"])

        self.assertNotEqual(screen(bytes(broken)), screen(self.rom))


if __name__ == "__main__":
    unittest.main()
