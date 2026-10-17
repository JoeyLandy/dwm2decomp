"""tools/setup.py and tools/toolchain.py: the pinned RGBDS for each platform, and the ROM check (H6, E-0412)."""
import json
import sys
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import setup  # noqa: E402
import toolchain  # noqa: E402


class Lock(unittest.TestCase):
    def test_every_platform_has_an_asset_and_a_digest(self):
        lock = json.loads(toolchain.LOCK.read_text(encoding="utf-8"))["rgbds"]
        self.assertEqual(set(lock["platforms"]), {"windows", "linux", "macos"})
        for key, e in lock["platforms"].items():
            self.assertTrue(e["source"].endswith("/v1.0.4/" + e["asset"]), key)
            self.assertRegex(e["sha256"], r"^[0-9a-f]{64}$")
        self.assertEqual(lock["platforms"]["windows"]["sha256"], lock["sha256"])  # the digest checked since 2026-10-09

    def test_program_names_follow_the_platform(self):
        name = toolchain.exe("rgbasm").name
        self.assertEqual(name, "rgbasm.exe" if sys.platform.startswith("win") else "rgbasm")


@unittest.skipUnless(toolchain.archive().exists(), "RGBDS not installed by tools/setup.py")
class Install(unittest.TestCase):
    def test_the_installed_archive_holds_the_four_programs(self):
        with tempfile.TemporaryDirectory() as t:
            got = setup.unpack(toolchain.archive(), Path(t))
        self.assertEqual(len(got), 4)
        self.assertEqual(sorted(Path(n).stem for n in got), sorted(setup.PROGRAMS))

    def test_a_download_with_the_wrong_digest_installs_nothing(self):
        with tempfile.TemporaryDirectory() as t:
            saved = toolchain.RGBDS
            toolchain.RGBDS = Path(t) / "rgbds"
            try:
                with self.assertRaises(SystemExit):
                    setup.install_rgbds(download=lambda url, dest: Path(dest).write_bytes(b"not the release"))
                self.assertFalse(toolchain.installed())
                self.assertFalse(toolchain.archive().exists())
            finally:
                toolchain.RGBDS = saved


class Rom(unittest.TestCase):
    def test_a_wrong_rom_is_refused(self):
        with tempfile.TemporaryDirectory() as t:
            bad = Path(t) / "other.gbc"
            bad.write_bytes(b"\0" * 1024)
            with self.assertRaises(SystemExit):
                setup.install_rom(bad)


if __name__ == "__main__":
    unittest.main()
