"""E-0419: readers that picked a table's bank by number now name it as BANK(table), so the table can move.

MonsterAttributeMapTable (bank $38, 383 far pointers) was read by two home-bank routines that map bank $38 by
number (`ld a, $38 / ld [rROMB0], a`). Both now write `ld a, BANK(MonsterAttributeMapTable)`, which assembles to the
same bytes. In a copy of src/ the table moves to the empty bank $9E; it builds, and on tools/sm83.py
LoadMonsterPictureAttributes writes the same 6 x 6 attribute block to VRAM bank 1 for every monster id. Put back to
the number $38 in that ROM, the reader reads the wrong bank, so the check sees a broken move.
"""
import re
import shutil
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import shift_test  # noqa: E402
import text_spill as TS  # noqa: E402
from sm83 import GameBoy  # noqa: E402

REF = ROOT / "local/roms/dwm2-cobi-us.gbc"
HTEMP0 = int(re.search(r"DEF hTemp0 EQU \$([0-9A-F]+)", (ROOT / "src/ram.asm").read_text(encoding="utf-8")).group(1), 16)


def attributes(rom: bytes, sym: dict, monster: int) -> bytes:
    """VRAM bank 1's first six rows of the BG map after LoadMonsterPictureAttributes (DE = monster, HL = $9800,
    hTemp0 = palette 5), the LCD off so VRAM is open."""
    class Returned(Exception):
        pass

    gb = GameBoy(rom)
    gb.rombank = 1
    gb.wb(0xFF40, 0)
    gb.sp = 0xDFF0
    gb.wb(gb.sp, 0x00)
    gb.wb(gb.sp + 1, 0xC8)
    gb.d, gb.e, gb.h, gb.l = monster >> 8, monster & 0xFF, 0x98, 0x00
    gb.wb(HTEMP0, 5)
    gb.pc = sym["LoadMonsterPictureAttributes"][1]

    def stop(_):
        raise Returned

    gb.pc_hooks[0xC800] = stop
    try:
        gb.run(300_000)
    except Returned:
        return bytes(gb.vram[1][0x1800:0x18C0])
    raise RuntimeError(f"no return for monster {monster}")


class Source(unittest.TestCase):
    def test_the_home_readers_name_the_bank(self):
        home = (ROOT / "src/home/bank00_home.asm").read_text(encoding="utf-8")
        self.assertEqual(home.count("ld a, BANK(MonsterAttributeMapTable)"), 2)
        self.assertNotIn("ASSERT BANK(MonsterAttributeMapTable)", home)


@unittest.skipUnless(REF.exists(), "needs the reference ROM")
class MovedTable(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.tmp = tempfile.TemporaryDirectory(dir=ROOT / "build")
        src = Path(cls.tmp.name) / "src"
        shutil.copytree(ROOT / "src", src)
        f = src / "gfx/bank38_monster_pictures.asm"
        L = f.read_text(encoding="utf-8").split("\n")
        i = L.index("MonsterAttributeMapTable::")
        b = i + 1
        while b < len(L) and L[b].startswith("    dfar "):
            b += 1
        cls.entries = b - i - 1
        block = L[TS.comment_start(L, i):b]
        del L[TS.comment_start(L, i):b]
        TS.fill_change(L, f.name, 3 * cls.entries)
        f.write_text("\n".join(L), encoding="utf-8")
        (src / "unused/bank9e_empty.asm").write_text("\n".join(
            ['SECTION "Bank 9E", ROMX'] + block + [f"    ds ${0x4000 - 3 * cls.entries:x}, $00", ""]), encoding="utf-8")
        base = Path(cls.tmp.name).relative_to(ROOT).as_posix()
        cls.builds = {}
        for name, args in (("moved", ["--src", str(src)]), ("ref", [])):
            p = subprocess.run([sys.executable, "-I", str(ROOT / "tools/build.py"), "--out", f"{base}/{name}"] + args,
                               cwd=ROOT, capture_output=True, text=True)
            cls.builds[name] = p
        cls.ref = REF.read_bytes()
        cls.ref_sym = shift_test.read_sym(ROOT / base / "ref/dwm2.sym")
        cls.rom = (ROOT / base / "moved/dwm2.gbc").read_bytes()
        cls.sym = shift_test.read_sym(ROOT / base / "moved/dwm2.sym")

    @classmethod
    def tearDownClass(cls):
        cls.tmp.cleanup()

    def test_the_moved_table_builds_in_bank_9e(self):
        self.assertEqual(self.builds["moved"].returncode, 0, self.builds["moved"].stdout + self.builds["moved"].stderr)
        self.assertEqual(self.entries, 383)
        self.assertEqual(self.sym["MonsterAttributeMapTable"][0], 0x9E)

    def test_every_monster_gets_the_same_attributes(self):
        same = [attributes(self.ref, self.ref_sym, m) == attributes(self.rom, self.sym, m) for m in range(self.entries)]
        self.assertTrue(all(same), [m for m, ok in enumerate(same) if not ok][:10])

    def test_the_old_number_would_read_the_wrong_bank(self):
        b, a = self.sym["LoadMonsterPictureAttributes"]
        at = self.rom.index(bytes([0x3E, 0x9E, 0xEA, 0x00, 0x21]), a, a + 16)  # ld a, BANK(...) / ld [rROMB0], a
        broken = bytearray(self.rom)
        broken[at + 1] = 0x38
        wrong = sum(attributes(self.ref, self.ref_sym, m) != attributes(bytes(broken), self.sym, m)
                    for m in range(self.entries))
        self.assertGreater(wrong, 300)


if __name__ == "__main__":
    unittest.main()
