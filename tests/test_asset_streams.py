"""E-0387: every compressed asset slice (src/assets.txt) holds its whole stream, so no stream is split in two."""
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import lzss_gfx  # noqa: E402

ROM = ROOT / "local/roms/dwm2-cobi-us.gbc"
# the decoder's last read is the first byte or two of the next slice: the streams share those bytes in the ROM
SHARED_TAIL = {"gfx/battle_effects/3_b.lz": 1, "gfx/misc/gfx16_1.lz": 1, "gfx/monster_pics/cloud_king.lz": 1,
               "gfx/monster_pics/lamia.lz": 2}


@unittest.skipUnless(ROM.is_file(), "reference ROM not present")
class AssetStreams(unittest.TestCase):
    def test_each_compressed_slice_holds_its_whole_stream(self):
        rom = ROM.read_bytes()
        short = {}
        for ln in (ROOT / "src/assets.txt").read_text(encoding="utf-8").splitlines():
            parts = ln.split()
            if ln.startswith("#") or len(parts) != 3 or not parts[0].endswith(".lz"):
                continue
            off, size = int(parts[1].lstrip("$"), 16), int(parts[2].lstrip("$"), 16)
            bank, addr = off // 0x4000, off % 0x4000 + (0x4000 if off >= 0x4000 else 0)
            _, used, _ = lzss_gfx.decompress(rom, bank, addr)
            if used > size:
                short[parts[0]] = used - size
        self.assertEqual(short, SHARED_TAIL, "a compressed stream split across slices (E-0387)")


if __name__ == "__main__":
    unittest.main()
