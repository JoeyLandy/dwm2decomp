"""tools/mod_check.py: the smoke test reports what a mod breaks (H5, E-0411).

The H5 gate: a mod that breaks a pointer and one that breaks a table are both reported, and an unchanged build is
not. Each mod is a copy of src/ with one edit, built with tools/build.py --src and run beside the reference.
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

REF = ROOT / "local/roms/dwm2-cobi-us.gbc"
FRAMES = 3000


def build(edit) -> tuple[bytes, dict, bytearray]:
    """A copy of src/ changed by edit(src), built; (ROM, symbols, its data map)."""
    with tempfile.TemporaryDirectory(dir=ROOT / "build") as t:
        src = Path(t) / "src"
        shutil.copytree(ROOT / "src", src)
        edit(src)
        out = Path(t).relative_to(ROOT).as_posix() + "/run"
        p = subprocess.run([sys.executable, "-I", str(ROOT / "tools/build.py"), "--out", out, "--src", str(src)],
                           cwd=ROOT, capture_output=True, text=True)
        if p.returncode:
            raise AssertionError(p.stdout + p.stderr)
        rom, sym = (ROOT / out / "dwm2.gbc").read_bytes(), shift_test.read_sym(ROOT / out / "dwm2.sym")
        return rom, sym, mod_check.data_map(src, sym, len(rom))


def replace(src: Path, pattern: str, old: str, new: str) -> None:
    f = next(src.glob(pattern))
    text = f.read_text(encoding="utf-8")
    assert text.count(old) == 1, old
    f.write_text(text.replace(old, new), encoding="utf-8", newline="\n")


class Pure(unittest.TestCase):
    def test_progress_allows_a_late_tail_only(self):
        ref = [(0, 1), (5, 22), (1, 1331)]
        self.assertIsNone(mod_check.progress(ref, ref, 3000))
        self.assertIsNotNone(mod_check.progress(ref, [(0, 1), (5, 22), (0, 63)], 3000))
        self.assertIsNotNone(mod_check.progress(ref, [(0, 1), (5, 22)], 3000))  # the field at 1331 is not late
        self.assertIsNone(mod_check.progress(ref, [(0, 1), (5, 22)], 1400))

    def test_stall_needs_the_original_to_keep_changing(self):
        a = ["x"] * 10 + ["y"] * 30
        b = [str(i) for i in range(40)]
        self.assertEqual(mod_check.stall(a, b, 20), 10)
        self.assertIsNone(mod_check.stall(a, ["z"] * 40, 20))  # both still: a pause, not a stall


@unittest.skipUnless(REF.exists() and __import__("toolchain").installed(), "needs the reference ROM and RGBDS")
class Reports(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.ref = REF.read_bytes()

    def check(self, rom, sym, data):
        return mod_check.check(rom, sym, FRAMES, ref=self.ref, data=data)

    def test_an_unchanged_build_is_not_reported(self):
        rom, sym, data = build(lambda src: None)
        self.assertEqual(rom, self.ref)
        res = self.check(rom, sym, data)
        self.assertTrue(res["identical"])
        self.assertIsNone(res["crash"])
        self.assertIsNone(res["ran_data"])
        self.assertIsNone(res["progress"])
        self.assertIsNone(res["stall"])

    def test_a_broken_pointer_is_reported(self):
        """The title screen's entry of the game-mode jump table points at the font (data) instead."""
        rom, sym, data = build(lambda src: replace(src, "home/bank00_*.asm", "    dw RunGameModeInit_Title\n",
                                             "    dw GlyphFont\n"))
        res = self.check(rom, sym, data)
        self.assertFalse(res["identical"])
        self.assertTrue(res["crash"] or res["ran_data"] or res["progress"] or res["stall"] is not None, res)
        self.assertIsNotNone(res["progress"])  # 0 -> 5 -> 0: it never reaches the field (the original: 0 -> 5 -> 1)
        self.assertLess(res["first_difference"], FRAMES)

    def test_a_broken_table_is_reported(self):
        """The glyph of 'I' (code $12) is blanked: the opening text ("In the middle of ...") looks different, and the
        game still runs."""
        def edit(src):
            f = next(src.glob("*/bank1f_*.asm"))
            lines = f.read_text(encoding="utf-8").split("\n")
            k = next(i for i, ln in enumerate(lines) if ln.rstrip().endswith("; id 18 'I'"))
            lines[k] = "    db " + ", ".join(["$ff, $00"] * 8) + " ; id 18 'I' (blanked by the test)"
            f.write_text("\n".join(lines), encoding="utf-8", newline="\n")
        rom, sym, data = build(edit)
        res = self.check(rom, sym, data)
        self.assertFalse(res["identical"])
        self.assertIsNone(res["crash"])
        self.assertIsNone(res["ran_data"])
        self.assertIsNone(res["progress"])  # the same modes, in the same order
        self.assertIsNotNone(res["first_difference"])


if __name__ == "__main__":
    unittest.main()
