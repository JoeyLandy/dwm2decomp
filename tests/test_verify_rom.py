"""Negative-case tests for tools/verify_rom.py using synthetic data (no real ROM)."""
import hashlib
import json
import sys
import tempfile
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "tools"))
import verify_rom  # noqa: E402


class VerifyRom(unittest.TestCase):
    def setUp(self):
        self.d = Path(tempfile.mkdtemp())
        self.ref_bytes = bytes(range(256)) * 64  # 16 KiB
        self.ref = self.d / "ref.gbc"
        self.out = self.d / "out.gbc"
        self.ref.write_bytes(self.ref_bytes)
        self.man = self.d / "m.json"
        self.write_manifest(self.ref_bytes)

    def write_manifest(self, data):
        self.man.write_text(json.dumps({
            "id": "synthetic", "size_bytes": len(data),
            "sha256": hashlib.sha256(data).hexdigest()}))

    def run_v(self, out_bytes=None, **kw):
        if out_bytes is not None:
            self.out.write_bytes(out_bytes)
        return verify_rom.verify(kw.get("man", self.man), kw.get("ref", self.ref),
                                 kw.get("out", self.out))

    def test_identical_passes(self):
        r = self.run_v(self.ref_bytes)
        self.assertTrue(r["pass"], r)
        self.assertEqual(r["differing_bytes"], 0)

    def test_interior_byte(self):
        b = bytearray(self.ref_bytes); b[5000] ^= 1
        r = self.run_v(bytes(b))
        self.assertFalse(r["pass"]); self.assertEqual(r["first_diff_offset"], 5000)
        self.assertEqual(r["differing_bytes"], 1)

    def test_header_byte(self):
        b = bytearray(self.ref_bytes); b[0x14D] ^= 0xFF
        r = self.run_v(bytes(b))
        self.assertFalse(r["pass"]); self.assertEqual(r["first_diff_offset"], 0x14D)

    def test_shorter_and_longer(self):
        self.assertFalse(self.run_v(self.ref_bytes[:-1])["pass"])
        r = self.run_v(self.ref_bytes + b"\0")
        self.assertFalse(r["pass"]); self.assertEqual(r["differing_bytes"], 1)

    def test_missing_output_and_reference(self):
        self.out.unlink(missing_ok=True)
        self.assertFalse(self.run_v()["pass"])
        self.out.write_bytes(self.ref_bytes)
        self.assertFalse(self.run_v(ref=self.d / "nope.gbc")["pass"])

    def test_wrong_reference_hash(self):
        self.ref.write_bytes(self.ref_bytes[:-1] + b"\x01")
        r = self.run_v(self.ref_bytes)
        self.assertFalse(r["pass"])
        self.assertIn("approved manifest", r["errors"][0])

    def test_path_collision(self):
        self.assertFalse(self.run_v(out=self.ref)["pass"])

    def test_bad_manifest(self):
        self.man.write_text("not json")
        self.assertFalse(self.run_v(self.ref_bytes)["pass"])

    def test_stale_output_is_not_a_pass(self):
        # A leftover matching file must not be certified if the build step is
        # skipped by the caller; the verifier only judges bytes, so the build
        # driver must delete the output first. Here: deleted output fails.
        self.out.write_bytes(self.ref_bytes)
        self.out.unlink()
        self.assertFalse(self.run_v()["pass"])


if __name__ == "__main__":
    unittest.main()
