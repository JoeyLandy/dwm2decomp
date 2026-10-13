"""tools/build.py extracts the asset files of src/assets.txt only from the verified reference ROM (D-008)."""
import sys
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import build  # noqa: E402


@unittest.skipUnless((ROOT / "src" / "assets.txt").exists(), "src/assets.txt has not been generated")
class ExtractAssetsTest(unittest.TestCase):
    def test_a_wrong_reference_is_refused(self):
        with tempfile.TemporaryDirectory() as d:
            fake = Path(d) / "fake.gbc"
            fake.write_bytes(bytes(4194304))  # right length, wrong bytes
            saved = build.REF
            build.REF = fake
            try:
                with self.assertRaises(SystemExit):
                    build.extract_assets(Path(d) / "assets")
            finally:
                build.REF = saved
            self.assertFalse((Path(d) / "assets").exists(), "nothing is written from an unverified reference")

    @unittest.skipUnless(build.REF.exists(), "reference ROM not present")
    def test_extracted_files_are_the_listed_slices(self):
        rom = build.REF.read_bytes()
        rows = [ln.split("\t") for ln in (ROOT / "src" / "assets.txt").read_text(encoding="utf-8").splitlines()
                if ln and not ln.startswith("#")]
        with tempfile.TemporaryDirectory() as d:
            n = build.extract_assets(Path(d))
            self.assertEqual(n, len(rows))
            for path, off, size in rows[::97]:
                o, s = int(off[1:], 16), int(size[1:], 16)
                self.assertEqual((Path(d) / path).read_bytes(), rom[o:o + s], path)


if __name__ == "__main__":
    unittest.main()
