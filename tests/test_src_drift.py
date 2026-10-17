"""tools/src_drift.py, and the generator's output folder (D-015, H1a)."""
import io
import sys
import tempfile
import unittest
from contextlib import redirect_stdout
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import present  # noqa: E402
import src_drift  # noqa: E402


def tree(root: Path, files: dict[str, str]) -> Path:
    for path, text in files.items():
        (root / path).parent.mkdir(parents=True, exist_ok=True)
        (root / path).write_bytes(text.encode("utf-8"))
    return root


class Drift(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.base = {"main.asm": 'INCLUDE "a.inc"\n', "engine/bank01_x.asm": "Foo::\n    ret\n", "a.inc": "DEF X EQU 1\n"}

    def tearDown(self):
        self.tmp.cleanup()

    def run_main(self, *args):
        out = io.StringIO()
        with redirect_stdout(out):
            code = src_drift.main([str(a) for a in args])
        return code, out.getvalue()

    def pair(self, src_files):
        t = Path(self.tmp.name)
        return tree(t / "regen", self.base), tree(t / "src", src_files)

    def test_identical_trees(self):
        regen, src = self.pair(dict(self.base))
        self.assertEqual(src_drift.drift(regen, src), {"differ": [], "missing": [], "extra": []})
        self.assertEqual(self.run_main(regen, src)[0], 0)

    def test_a_hand_edit_is_reported(self):
        regen, src = self.pair({**self.base, "engine/bank01_x.asm": "; my note\nFoo::\n    ret\n"})
        d = src_drift.drift(regen, src)
        self.assertEqual(d["differ"], [("engine/bank01_x.asm", 1)])
        code, out = self.run_main(regen, src)
        self.assertEqual(code, 1)
        self.assertIn("differs  engine/bank01_x.asm", out)

    def test_one_byte_change_is_reported(self):
        regen, src = self.pair({**self.base, "a.inc": "DEF X EQU 2\n"})
        self.assertEqual(src_drift.drift(regen, src)["differ"], [("a.inc", 2)])

    def test_line_endings_count_as_drift(self):
        regen, src = self.pair({**self.base, "a.inc": "DEF X EQU 1\r\n"})
        self.assertEqual([p for p, _ in src_drift.drift(regen, src)["differ"]], ["a.inc"])

    def test_missing_and_extra_files(self):
        files = {k: v for k, v in self.base.items() if k != "a.inc"}
        regen, src = self.pair({**files, "mods/new.asm": "Bar::\n"})
        d = src_drift.drift(regen, src)
        self.assertEqual((d["missing"], d["extra"]), (["a.inc"], ["mods/new.asm"]))
        code, out = self.run_main(regen, src)
        self.assertEqual(code, 1)
        self.assertIn("missing  a.inc", out)
        self.assertIn("extra    mods/new.asm", out)

    def test_no_regenerated_tree(self):
        t = Path(self.tmp.name)
        self.assertEqual(self.run_main(t / "nothing", tree(t / "src", self.base))[0], 2)

    def test_diff_of_one_file(self):
        regen, src = self.pair({**self.base, "a.inc": "DEF X EQU 2\n"})
        code, out = self.run_main(regen, src, "--diff", "a.inc")
        self.assertEqual(code, 1)
        self.assertIn("-DEF X EQU 1", out)
        self.assertIn("+DEF X EQU 2", out)


class GeneratorOutput(unittest.TestCase):
    def test_default_output_is_not_src(self):
        self.assertEqual(present.REGEN.as_posix(), "build/regen/src")

    def test_present_writes_only_its_destination(self):
        """present.main into a scratch folder leaves src/ untouched (no listing needed for an empty one)."""
        with tempfile.TemporaryDirectory() as t:
            listing, dest = Path(t) / "listing", Path(t) / "out"
            listing.mkdir()
            before = {p: p.stat().st_mtime_ns for p in (ROOT / "src").glob("*.*")}
            with redirect_stdout(io.StringIO()):
                self.assertEqual(present.main([str(listing), str(dest)]), 0)
            self.assertTrue((dest / "main.asm").exists())
            self.assertTrue((dest / "layout.link").exists())
            self.assertEqual(before, {p: p.stat().st_mtime_ns for p in (ROOT / "src").glob("*.*")})


if __name__ == "__main__":
    unittest.main()
