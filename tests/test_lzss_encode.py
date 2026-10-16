"""tools/lzss_encode.py and tools/assets.py: editable assets rebuilt byte for byte (E-0394, M3)."""
import random
import shutil
import sys
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import assets  # noqa: E402
import lzss_encode  # noqa: E402
import lzss_gfx  # noqa: E402

ROM = ROOT / "local/roms/dwm2-cobi-us.gbc"


def roundtrip(data: bytes) -> bytes:
    enc = lzss_encode.encode(data)
    return lzss_gfx.decompress(enc + bytes(300), 0, 0)[0]


class Encoder(unittest.TestCase):
    def test_round_trips(self):
        rnd = random.Random(7)
        cases = [b"\x00" * 300, bytes(range(200)) * 3, b"abcd" * 50 + b"\x00" * 20,
                 bytes(rnd.randrange(4) for _ in range(4096)), b"x"]
        for data in cases:
            self.assertEqual(roundtrip(data), data)

    def test_marker_is_the_lowest_absent_byte_and_lengths_cap_at_96(self):
        enc = lzss_encode.encode(bytes([0, 1, 3]) * 100)
        self.assertEqual(enc[2], 2)
        self.assertEqual(enc[:2], bytes([44, 1]))  # 300 bytes, little endian
        refs, p, m = [], 3, enc[2]
        while p < len(enc):
            if enc[p] != m:
                p += 1
                continue
            n = (enc[p + 2] & 15) + 4
            n = enc[p + 3] + 19 if n == 19 else n
            refs.append(n)
            p += 4 if (enc[p + 2] & 15) == 15 else 3
        self.assertTrue(refs and max(refs) <= 96)

    def test_data_it_cannot_encode_is_refused(self):
        with self.assertRaises(ValueError):
            lzss_encode.encode(bytes(range(256)))  # no free marker
        with self.assertRaises(ValueError):
            lzss_encode.encode(bytes(4097))  # longer than the ring

    @unittest.skipUnless(ROM.is_file(), "reference ROM not present")
    def test_every_rom_stream_reencodes_byte_for_byte(self):
        rom = ROM.read_bytes()
        bad = []
        for path, off, _size in assets.listed():
            if not path.endswith(".lz"):
                continue
            bank, addr = off // 0x4000, off % 0x4000 + (0x4000 if off >= 0x4000 else 0)
            data, used, _ = lzss_gfx.decompress(rom, bank, addr)
            if lzss_encode.encode(data) != rom[off:off + used]:
                bad.append(path)
        self.assertEqual(bad[:5], [], f"{len(bad)} streams differ")


class Assets(unittest.TestCase):
    def test_png_width_has_no_padding(self):
        self.assertEqual(assets.png_width(36), 12)
        self.assertEqual(assets.png_width(37), 1)
        self.assertEqual(assets.png_width(256), 16)

    def test_only_tile_graphics_become_png(self):
        self.assertTrue(assets.is_tiles("gfx/monster_pics/slime.lz", bytes(32)))
        self.assertTrue(assets.is_tiles("maps/map0_a/tileset.lz", bytes(32)))
        self.assertFalse(assets.is_tiles("maps/key_worlds/x_tiles.lz", bytes(32)))  # a screen's tile map
        self.assertFalse(assets.is_tiles("gfx/misc/x.lz", bytes(30)))

    @unittest.skipUnless(ROM.is_file() and assets.RGBGFX.is_file(), "reference ROM or rgbgfx not present")
    def test_png_round_trip_on_a_sample(self):
        rom = assets.reference()
        tiles = [(p, o) for p, o, _s in assets.listed() if p.endswith(".lz") and assets.is_tiles(p, assets.decoded(rom, o))]
        with tempfile.TemporaryDirectory() as d:
            for p, o in tiles[::50]:
                data = assets.decoded(rom, o)
                png = Path(d) / (Path(p).stem + ".png")
                assets.to_png(data, png)
                self.assertEqual(assets.from_png(png), data, p)

    def test_size_changes_come_out_of_the_bank_fill(self):
        with tempfile.TemporaryDirectory() as d:
            src = Path(d)
            (src / "gfx").mkdir()
            f = src / "gfx/bank74_x.asm"
            f.write_text('SECTION "Bank 74", ROMX\nPic::\n    INCBIN "gfx/a.lz"\n    ds $4a, $00\n', encoding="utf-8")
            notes = assets.absorb_size_changes(src, {"gfx/a.lz": 1})
            self.assertIn("    ds $49, $00", f.read_text(encoding="utf-8"))
            self.assertEqual(notes, ["bank74_x.asm: fill 74 -> 73 bytes"])
            assets.absorb_size_changes(src, {"gfx/a.lz": -3})
            self.assertIn("    ds $4C, $00", f.read_text(encoding="utf-8"))
            with self.assertRaises(SystemExit):  # more growth than the fill holds
                assets.absorb_size_changes(src, {"gfx/a.lz": 0x100})
            with self.assertRaises(SystemExit):  # no bank includes it
                assets.absorb_size_changes(src, {"gfx/b.lz": 1})

    def test_export_stays_in_an_ignored_directory(self):
        with self.assertRaises(SystemExit):
            assets.main(["export", "--out", str(ROOT / "docs" / "assets")])


if __name__ == "__main__":
    unittest.main()
