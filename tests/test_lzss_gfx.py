"""Tests for tools/lzss_gfx.py: synthetic streams for each branch, plus golden real assets."""
import hashlib
import json
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import lzss_gfx  # noqa: E402

M = 0xEE  # marker byte used by the synthetic streams


def stream(size: int, body: bytes, marker: int = M) -> bytes:
    """Wrap a body in the 3-byte header: u16 size (LE), marker."""
    return bytes([size & 0xFF, size >> 8, marker]) + body


def run(data: bytes):
    # Place the stream at the start of bank 0 so file offset == address.
    return lzss_gfx.decompress(data + bytes(16), 0, 0)


class SyntheticStreams(unittest.TestCase):
    def test_literals_only(self):
        out, used, ev = run(stream(4, b"\x01\x02\x03\x04"))
        self.assertEqual(out, b"\x01\x02\x03\x04")
        self.assertEqual(used, 3 + 4)

    def test_back_reference_copies_from_output_start(self):
        # literals 1 2 3 4, then marker lo=0 b2=0x00 -> length 4, offset 0 -> repeats 1 2 3 4
        out, used, ev = run(stream(8, b"\x01\x02\x03\x04" + bytes([M, 0x00, 0x00])))
        self.assertEqual(out, b"\x01\x02\x03\x04\x01\x02\x03\x04")
        self.assertEqual(used, 3 + 4 + 3)

    def test_overlapping_reference_repeats_the_pattern(self):
        # one literal then a length-4 reference to offset 0 reads bytes it is producing.
        out, _, _ = run(stream(5, b"\x07" + bytes([M, 0x00, 0x00])))
        self.assertEqual(out, b"\x07" * 5)

    def test_offset_uses_high_nibble_of_second_byte(self):
        body = bytes(range(1, 20)) + bytes([M, 0x02, 0x00])  # offset 2 -> starts at the 3rd byte
        out, _, _ = run(stream(19 + 4, body))
        self.assertEqual(out[19:], bytes([3, 4, 5, 6]))

    def test_extended_length(self):
        # nibble 0xF -> length byte follows; length = byte + 0x13. byte=2 -> 21 bytes.
        body = b"\x09" + bytes([M, 0x00, 0x0F, 0x02])
        out, used, ev = run(stream(1 + 21, body))
        self.assertEqual(out, b"\x09" * 22)
        self.assertEqual(ev["extended"], 1)
        self.assertEqual(used, 3 + 1 + 4)

    def test_reference_past_the_output_end_reads_zero(self):
        # offset 0x010 with size 8: source is >= end and 0x10-0x1000 < 0 -> zero fill.
        out, _, ev = run(stream(8, b"\xAA\xBB\xCC\xDD" + bytes([M, 0x10, 0x00])))
        self.assertEqual(out, b"\xAA\xBB\xCC\xDD\x00\x00\x00\x00")
        self.assertEqual(ev["zero_fills"], 4)

    def test_decoding_stops_exactly_at_the_declared_size(self):
        out, _, _ = run(stream(6, b"\x01\x02\x03\x04" + bytes([M, 0x00, 0x00])))
        self.assertEqual(len(out), 6)

    def test_marker_value_is_taken_from_the_header(self):
        out, _, _ = run(stream(5, b"\x07" + bytes([0x55, 0x00, 0x00]), marker=0x55))
        self.assertEqual(out, b"\x07" * 5)


GOLDEN = ROOT / "tests" / "golden_gfx_assets.json"
REF = ROOT / "local" / "roms" / "dwm2-cobi-us.gbc"


@unittest.skipUnless(REF.exists(), "reference ROM not present")
class RealAssets(unittest.TestCase):
    def test_every_observed_asset_decompresses_to_the_recorded_digest(self):
        rom = REF.read_bytes()
        assets = json.loads(GOLDEN.read_text(encoding="utf-8"))["assets"]
        self.assertGreater(len(assets), 20)
        for a in assets:
            out, used, _ = lzss_gfx.decompress(rom, a["bank"], a["addr"])
            self.assertEqual(len(out), a["size"], f"{a['bank']:02X}:{a['addr']:04X} size")
            self.assertEqual(used, a["compressed_bytes"], f"{a['bank']:02X}:{a['addr']:04X} consumed")
            self.assertEqual(hashlib.sha256(out).hexdigest(), a["sha256"], f"{a['bank']:02X}:{a['addr']:04X}")


if __name__ == "__main__":
    unittest.main()
