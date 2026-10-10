"""Synthetic checks of tools/render_frame.py and the CGB palette registers of tools/sm83.py."""
import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "tools"))
from sm83 import GameBoy  # noqa: E402
import render_frame  # noqa: E402


def machine() -> GameBoy:
    g = GameBoy(bytes(0x8000))
    g.io[0x40] = 0x91  # LCD on, BG on, tiles at $8000
    return g


def pixel(rgb: bytes, x: int, y: int):
    o = (y * 160 + x) * 3
    return tuple(rgb[o:o + 3])


class Palettes(unittest.TestCase):
    def test_auto_increment_writes_and_reads_back(self):
        g = machine()
        g.wio(0x68, 0x80)
        for v in (0x1F, 0x00, 0xE0, 0x03):
            g.wio(0x69, v)
        self.assertEqual(list(g.bgpal[:4]), [0x1F, 0x00, 0xE0, 0x03])
        self.assertEqual(g.io[0x68], 0x84)
        g.wio(0x68, 0x02)
        self.assertEqual(g.rio(0x69), 0xE0)


class Rendering(unittest.TestCase):
    def test_background_tile_uses_its_palette_colour(self):
        g = machine()
        g.vram[0][0:2] = bytes([0xFF, 0x00])  # tile 0, row 0: colour 1 across
        g.bgpal[2:4] = bytes([0x1F, 0x00])  # palette 0 colour 1 = pure red
        _, _, rgb = render_frame.render(g)
        self.assertEqual(pixel(rgb, 0, 0), (255, 0, 0))
        self.assertEqual(pixel(rgb, 0, 1), (0, 0, 0))  # row 1 is colour 0 (black: palette RAM is zero)

    def test_sprite_draws_over_the_background(self):
        g = machine()
        g.io[0x40] |= 0x02
        g.vram[0][16:18] = bytes([0xFF, 0xFF])  # tile 1, row 0: colour 3
        g.objpal[6:8] = bytes([0xE0, 0x03])  # palette 0 colour 3 = pure green
        g.oam[0:4] = bytes([16, 8, 1, 0])  # at screen (0, 0)
        _, _, rgb = render_frame.render(g)
        self.assertEqual(pixel(rgb, 0, 0), (0, 255, 0))

    def test_lcd_off_renders_blank(self):
        g = machine()
        g.io[0x40] = 0
        self.assertEqual(set(render_frame.render(g)[2]), {0})

    def test_png_has_signature_and_size(self):
        import tempfile
        with tempfile.TemporaryDirectory() as d:
            p = Path(d) / "x.png"
            render_frame.write_png(p, 160, 144, bytes(160 * 144 * 3), 2)
            data = p.read_bytes()
        self.assertEqual(data[:8], b"\x89PNG\r\n\x1a\n")
        self.assertEqual(int.from_bytes(data[16:20], "big"), 320)


if __name__ == "__main__":
    unittest.main()
