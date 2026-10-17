"""tools/rename.py: a name changed everywhere in src/, and nothing else (D-015, H1d)."""
import json
import shutil
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import rename  # noqa: E402

TREE = {
    "engine/bank01_x.asm": ('SECTION "Bank 01 Foo", ROMX\n'
                            "; Foo reads wBar; FooBar is another routine\n"
                            "Foo::\n    call FooBar\n.loop:\n    jr .loop\n.Foo:\n    jp Foo.loop\n"
                            "FooBar::\n    ret\n"),
    "layout.link": 'ROMX $01\n\t"Bank 01 Foo"\n',
    "ram.asm": "DEF wBar EQU $C000\n",
}


class Rename(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.src = Path(self.tmp.name) / "src"
        for path, text in TREE.items():
            (self.src / path).parent.mkdir(parents=True, exist_ok=True)
            (self.src / path).write_text(text, encoding="utf-8")

    def tearDown(self):
        self.tmp.cleanup()

    def read(self, path):
        return (self.src / path).read_text(encoding="utf-8")

    def test_whole_words_everywhere(self):
        changed = rename.rename(self.src, "Foo", "ReadBar")
        text = self.read("engine/bank01_x.asm")
        self.assertIn('SECTION "Bank 01 ReadBar", ROMX', text)
        self.assertIn("; ReadBar reads wBar; FooBar is another routine", text)
        self.assertIn("ReadBar::\n    call FooBar\n", text)
        self.assertIn("    jp ReadBar.loop\n", text)
        self.assertIn(".Foo:\n", text)  # a local label of the same spelling is another name
        self.assertIn('"Bank 01 ReadBar"', self.read("layout.link"))
        self.assertEqual(changed, {"engine/bank01_x.asm": 4, "layout.link": 1})

    def test_a_ram_symbol(self):
        rename.rename(self.src, "wBar", "wBarCount")
        self.assertIn("DEF wBarCount EQU $C000", self.read("ram.asm"))
        self.assertIn("reads wBarCount;", self.read("engine/bank01_x.asm"))

    def test_refusals_change_nothing(self):
        before = {p: self.read(p) for p in TREE}
        for old, new in (("Nope", "Other"), ("Foo", "FooBar"), ("Foo", "wBar"), ("Foo", "9Lives"), ("Foo", "a-b")):
            with self.assertRaises(ValueError, msg=(old, new)):
                rename.rename(self.src, old, new)
        self.assertEqual(before, {p: self.read(p) for p in TREE})

    def test_dry_run_writes_nothing(self):
        before = self.read("engine/bank01_x.asm")
        self.assertTrue(rename.rename(self.src, "Foo", "ReadBar", dry_run=True))
        self.assertEqual(self.read("engine/bank01_x.asm"), before)

    def test_cli_exit_status(self):
        self.assertEqual(rename.main(["Nope", "Other", "--src", str(self.src)]), 2)
        self.assertEqual(rename.main(["Foo", "ReadBar", "--src", str(self.src)]), 0)


REF = ROOT / "local/roms/dwm2-cobi-us.gbc"


@unittest.skipUnless(REF.exists() and __import__("toolchain").installed(), "needs the reference ROM and RGBDS")
class RealTree(unittest.TestCase):
    def test_renaming_a_routine_keeps_the_rom(self):
        """A copy of src/ with a routine renamed (its callers, notes and section with it) still builds the
        reference byte for byte."""
        with tempfile.TemporaryDirectory(dir=ROOT / "build") as t:
            src = Path(t) / "src"
            shutil.copytree(ROOT / "src", src)
            changed = rename.rename(src, "NextTableByte", "StepTableRandom")
            self.assertGreater(sum(changed.values()), 40)
            self.assertIn("layout.link", changed)
            out = Path(t).relative_to(ROOT).as_posix() + "/run"
            subprocess.run([sys.executable, "-I", str(ROOT / "tools/build.py"), "--out", out, "--src", str(src)],
                           cwd=ROOT, capture_output=True, text=True, check=True)
            rep = json.loads((ROOT / out / "report.json").read_text())
            self.assertTrue(rep["pass"])
            self.assertIn("StepTableRandom", (ROOT / out / "dwm2.sym").read_text())


if __name__ == "__main__":
    unittest.main()
