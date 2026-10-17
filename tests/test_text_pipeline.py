"""tools/text.py: the text exported for translators and reinserted, the font as a PNG (H3, E-0406).

The H3 gate: unchanged text reinserts with no change to src/ (so the matching build is unaffected), and a test
translation that grows the text and adds a letter builds, and the game draws it: the farmhand's first message,
in German with a new letter "ü" (a CHARMAP line and a glyph drawn into the font PNG), is shown on tools/sm83.py
by replaying the E-0320 recipe to just before the conversation on the modded ROM.
"""
import json
import pickle
import re
import shutil
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import gb_text as T  # noqa: E402
import text as X  # noqa: E402

REF = ROOT / "local/roms/dwm2-cobi-us.gbc"
UE = 0x49  # a blank glyph code no text uses (tools/text.py free-glyphs)
UE_ROWS = [0x24, 0x00, 0x42, 0x42, 0x42, 0x46, 0x3a, 0x00]  # a small u with two dots above
GERMAN = "<VOICE2>*: Gleich sind wir<LINE>über GreatLog da.<PROMPT><NEXT>Ich bin gespannt!<PROMPT>"


class TextForm(unittest.TestCase):
    def test_text_and_bytes_round_trip(self):
        ops = ['"<VOICE1>Cobi: <BUF0>!<LINE>"', '"Papa\'s calling.<PROMPT>"', '"<SFX_WAIT>", $7e', '"@"']
        text = X.to_text(ops)
        self.assertEqual(text, "<VOICE1>Cobi: <BUF0>!<LINE>Papa's calling.<PROMPT><SFX_WAIT>{$7e}@")
        self.assertEqual(X.to_bytes(text), b"".join(T.parse(o) for o in ops))

    def test_unknown_character_is_refused(self):
        with self.assertRaises(ValueError):
            X.to_bytes("Grüße@")

    def test_widths(self):
        self.assertEqual(X.widths("*: We'll soon be<LINE>reaching GreatLog.<PROMPT>"), [14, 18])  # "*:" and "'l": one cell each
        self.assertEqual(X.widths("Lv<BUF1><CURSOR>{$0a}{$01}Max. MP +<BUF2>"), [2, 9])

    def test_the_text_round_trips_and_two_blocks_relayout(self):
        self.assertEqual(X.check(ROOT / "src"), [])
        self.assertEqual(X.relayout(ROOT / "src"), ["Message_0B_8F", "String_88_02_AD"])

    def test_export(self):
        data = X.export(ROOT / "src")
        self.assertGreater(len(data["entries"]), 5000)
        e = next(e for e in data["entries"] if e["id"] == "Message_00_0A")
        self.assertEqual((e["kind"], e["max_width"], e["bank"]), ("message", 18, "28"))
        self.assertTrue(e["used_by"])

    def test_a_too_wide_line_is_refused(self):
        with tempfile.TemporaryDirectory() as t:
            src = Path(t) / "src"
            shutil.copytree(ROOT / "src", src)
            data = X.export(src)
            e = next(e for e in data["entries"] if e["id"] == "Message_00_0A")
            e["text"] = "<VOICE2>*: This line is far too long<LINE>@"
            with self.assertRaises(ValueError):
                X.apply(src, {"entries": [e]})

    def test_a_bank_without_room_is_refused(self):
        with tempfile.TemporaryDirectory() as t:
            src = Path(t) / "src"
            shutil.copytree(ROOT / "src", src)
            data = X.export(src)
            grow = [e for e in data["entries"] if e["file"].endswith("bank28_messages_28.asm")][:30]
            for e in grow:
                e["text"] = e["text"].replace("@", "<PROMPT><NEXT>And more.<PROMPT>@", 1)
            with self.assertRaises(ValueError):
                X.apply(src, {"entries": grow})


class Font(unittest.TestCase):
    def test_png_round_trip_changes_nothing_and_free_codes_exist(self):
        with tempfile.TemporaryDirectory() as t:
            src = Path(t) / "src"
            shutil.copytree(ROOT / "src", src)
            png = Path(t) / "font.png"
            X.font_export(src, png)
            w, h, _px = X.read_png(png)
            self.assertEqual((w, h), (128, 96))
            self.assertEqual(X.font_import(src, png), 0)
            f = next(src.glob("*/bank1f_*.asm"))
            self.assertEqual(f.read_bytes(), next((ROOT / "src").glob("*/bank1f_*.asm")).read_bytes())
        free = X.free_glyphs(ROOT / "src")
        self.assertIn((UE, True), free)
        self.assertGreaterEqual(sum(1 for _g, blank in free if blank), 45)  # 49 blank on 2026-10-17


def set_glyph(png: Path, code: int, rows: list[int]) -> None:
    w, h, px = X.read_png(png)
    gx, gy = code % 16 * 8, code // 16 * 8
    for y, bits in enumerate(rows):
        for x in range(8):
            px[gy + y][gx + x] = 0 if bits & (0x80 >> x) else 255
    X.write_png(png, w, h, bytes(v for row in px for v in row))


@unittest.skipUnless(REF.exists() and (ROOT / "tools/rgbds/rgbasm.exe").exists(), "needs the reference ROM and RGBDS")
class GermanTestTranslation(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.tmp = tempfile.TemporaryDirectory(dir=ROOT / "build")
        src = Path(cls.tmp.name) / "src"
        shutil.copytree(ROOT / "src", src)
        inc = src / "charmap.inc"
        inc.write_text(inc.read_text(encoding="utf-8") + f'CHARMAP "ü", ${UE:02X} ; a test translation\'s letter\n',
                       encoding="utf-8")
        X.load_charmap(src)
        png = Path(cls.tmp.name) / "font.png"
        X.font_export(src, png)
        set_glyph(png, UE, UE_ROWS)
        cls.glyphs_changed = X.font_import(src, png)
        data = X.export(src)
        e = next(e for e in data["entries"] if e["id"] == "Message_00_0A")
        cls.original = e["text"]
        e["text"] = GERMAN + e["text"].split("<PROMPT>", 1)[1]
        cls.result = X.apply(src, {"entries": [e]})
        out = Path(cls.tmp.name).relative_to(ROOT).as_posix() + "/run"
        cls.build = subprocess.run([sys.executable, "-I", str(ROOT / "tools/build.py"), "--out", out, "--src", str(src)],
                                   cwd=ROOT, capture_output=True, text=True)
        cls.outdir = ROOT / out
        cls.rom = (cls.outdir / "dwm2.gbc").read_bytes() if (cls.outdir / "dwm2.gbc").exists() else b""

    @classmethod
    def tearDownClass(cls):
        cls.tmp.cleanup()
        T.CHARMAP.pop("ü", None)
        T.BYTE_TO_TEXT.pop(UE, None)

    def test_the_translation_builds_as_a_mod_with_longer_text(self):
        self.assertEqual(self.build.returncode, 0, self.build.stdout + self.build.stderr)
        self.assertEqual(self.glyphs_changed, 1)
        self.assertEqual(self.result["entries"], 1)
        self.assertGreater(self.result["bytes"], 0)  # the German is longer, and bank $28's fill took it up
        rep = json.loads((self.outdir / "report.json").read_text())
        self.assertFalse(rep["pass"])

    def test_the_game_draws_it(self):
        import mechanics
        import text_check as TC
        gb = pickle.loads(TC.base("s13"))  # the reference machine just before the conversation
        gb.rom = self.rom                 # the modded ROM differs only in banks $1F and $28 (font and text)
        log, _gb = TC.run(pickle.dumps(gb), TC.TALK + " W300")
        drawn = [v for _f, kind, v, _p in log if kind == "glyph"]
        want = X.to_bytes(re.sub(r"<[^>]*>", "", GERMAN.split("<PROMPT>")[0]))
        self.assertEqual(bytes(drawn[:len(want)]), want)
        self.assertIn(UE, drawn)
        # the glyph rows the printer copies from: GlyphFont + 16 * $49 in the modded ROM holds the new letter
        L = mechanics.rom_labels(self.outdir / "dwm2.sym")
        bank, addr = L["GlyphFont"]
        at = bank * 0x4000 + addr - 0x4000 + 16 * UE
        self.assertEqual(list(self.rom[at + 1:at + 16:2]), UE_ROWS)


if __name__ == "__main__":
    unittest.main()
