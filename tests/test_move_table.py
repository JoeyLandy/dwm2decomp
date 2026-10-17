"""H4 (E-0414): a table whose readers named its bank by number, moved to another bank with its readers following it.

ScreenNumberListTable and its price lists (bank $F2) were read by LoadScreenNumberListPointer,
ShopMenu_Buy_DrawPrices, ShopMenu_Buy_EnterQuantity_ComputeTotal and ShopMenu_Buy_ApplyGoldPass with `ld b, $f2`.
Those are now `ld b, BANK(ScreenNumberListTable)` (the same bytes), and the table and lists are their own section.
tools/move_section.py moves that section to bank $8A in a copy; it builds, tools/bank_check.py finds nothing, and the
game's own ShopMenu_Buy_EnterQuantity_ComputeTotal gives every total of every shop as before, with and without the
GoldPass discount (on tools/sm83.py).
"""
import json
import subprocess
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import mechanics as M  # noqa: E402
import toolchain  # noqa: E402

REF = ROOT / "local/roms/dwm2-cobi-us.gbc"
SECTION = "Bank F2 ScreenNumberListTable"


def totals(run: Path) -> dict:
    """(shop, item place, GoldPass) -> the 24-bit total for 3 of the item."""
    R = M.ram()
    rom = (run / "dwm2.gbc").read_bytes()
    L = M.rom_labels(run / "dwm2.sym")
    r = M.Rom(rom)
    lb, la = L["ShopItemListTable"]
    out = {}
    for shop in range(24):
        p = r.w(lb, la + 2 * shop)
        n = 0
        while r.b(lb, p + n) != 0xFF and n < 20:
            n += 1
        for k in range(n):
            for gold in (False, True):
                mem = {R["wNumberTens"]: 0, R["wNumberOnes"]: 3, R["wScreenTableIndex"]: shop,
                       R["wItemGridX"]: k % 4, R["wItemGridY"]: k // 4}
                for s in range(24):
                    mem[R["wInventory"] + s] = 0x2D if gold and s == 5 else 0  # ITEM_GOLDPASS
                gb = M.call(rom, *L["ShopMenu_Buy_EnterQuantity_ComputeTotal"], mem)
                out[(shop, k, gold)] = (gb.rb(R["wThreeDigits"]) | gb.rb(R["wThreeDigits"] + 1) << 8
                                        | gb.rb(R["wThreeDigits"] + 2) << 16)
    return out


class Source(unittest.TestCase):
    def test_the_readers_name_the_tables_bank(self):
        shops = next((ROOT / "src").glob("*/bank1c_*.asm")).read_text(encoding="utf-8")
        self.assertEqual(shops.count("ld b, BANK(ScreenNumberListTable)"), 4)
        self.assertNotIn("    ld b, $f2\n    call ReadFarPointerAtDEInBankB", shops)
        self.assertIn(f'\t"{SECTION}"\n', (ROOT / "src/layout.link").read_text(encoding="utf-8"))


@unittest.skipUnless(REF.exists() and toolchain.installed(), "needs the reference ROM and RGBDS")
class Moved(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.out = ROOT / "build/test_move_table"
        cls.proc = subprocess.run([sys.executable, "-I", str(ROOT / "tools/move_section.py"), "--move", SECTION,
                                   "--to", "8A", "--frames", "600", "--out", str(cls.out.relative_to(ROOT))],
                                  cwd=ROOT, capture_output=True, text=True)

    def test_it_moves_and_builds(self):
        self.assertEqual(self.proc.returncode, 0, self.proc.stdout[-2000:] + self.proc.stderr[-2000:])
        rep = json.loads((self.out / "report.json").read_text(encoding="utf-8"))
        self.assertEqual((rep["assembled"], rep["bank_check_errors"], rep["labels_now_in_bank"]), (True, [], ["8A"]))
        self.assertEqual(M.rom_labels(self.out / "moved/dwm2.sym")["ScreenNumberListTable"][0], 0x8A)
        self.assertEqual(M.rom_labels(self.out / "base/dwm2.sym")["ScreenNumberListTable"][0], 0xF2)

    def test_the_game_reads_the_same_prices(self):
        base, moved = totals(self.out / "base"), totals(self.out / "moved")
        self.assertGreater(len(base), 300)
        self.assertEqual(base, moved)
        self.assertEqual(base[(0, 0, False)], 30)  # three Herbs at 10G
        self.assertEqual(base[(0, 0, True)], 27)   # with the GoldPass, 90 percent


if __name__ == "__main__":
    unittest.main()
