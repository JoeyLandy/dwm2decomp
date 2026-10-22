"""E-0422: event scripts in sections of their own, so the data-bank scripts move with their section.

tools/present.py starts a section at a Script_ label after data or ended code, and at another label after a
script's last line. The data-bank script blocks (arena, breeding, NPC breeding, priest and library, swap, keys,
hibernation, renaming and egg service) each get one, which the bytes do not see. tools/bank_check.py makes a
script jump into another bank an error, so the arena's two sections, which jump to each other, cannot move apart;
together they move. With the breeding scripts in an empty bank, the E-0328 breeding chain (122 runs, through the
breeding menu's resume of its script in data-bank mode) fetches the same scripts and shows the same screens as the
original on tools/sm83.py. E-0423: an empty target bank gets its number at $4000 first (EmptyBank), and the moved
bank begins with it.
"""
import json
import subprocess
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import mod_check  # noqa: E402
import present  # noqa: E402
import script_bank as SB  # noqa: E402
import shift_test  # noqa: E402

REF = ROOT / "local/roms/dwm2-cobi-us.gbc"


def move(sections: list[str], out: str) -> tuple[int, dict]:
    args = [sys.executable, "-I", str(ROOT / "tools/move_section.py"), "--to", "9F", "--frames", "60", "--out", out]
    for s in sections:
        args += ["--move", s]
    p = subprocess.run(args, cwd=ROOT, capture_output=True, text=True)
    return p.returncode, json.loads((ROOT / out / "report.json").read_text(encoding="utf-8"))


class Sections(unittest.TestCase):
    def test_the_data_bank_scripts_have_sections(self):
        layout = (ROOT / "src/layout.link").read_text(encoding="utf-8")
        for name in ("Bank 0C Script_Arena", "Bank 0C Script_Arena_9", "Bank 0D Script_KeyAppraisal",
                     "Bank 0E Script_ItsAccessoryIsIn", "Bank 15 Script_Breed", "Bank 1D Script_Hibernate",
                     "Bank 1F Script_Priest", "Bank 1F Script_SwapMonsters", "Bank 96 Script_EggService"):
            self.assertIn(f'"{name}"', layout)

    def test_the_section_rules(self):
        text = "\n".join([
            'SECTION "Bank 05", ROMX', "Data::", "    db $ff, $00, $ff", "Tail::", "    db $ff", "    db $01",
            "Script_A::", "    script_message $0001", "    script_end", "Code::", "    ret", "Script_B::",
            "    script_jump Script_A", "    db $ff", "Other::", "    db $01"])
        _t, names = present.split_sections(text, 5)
        # a data line ending in $ff runs on into Tail (no script above it); scripts start and end sections (a lone
        # `db $ff` just before a script is read as a script's end byte, so it is no boundary)
        self.assertEqual(names, ["Bank 05", "Bank 05 Script_A", "Bank 05 Code", "Bank 05 Script_B", "Bank 05 Other"])


class EmptyBank(unittest.TestCase):
    def test_an_empty_bank_gets_its_number_first(self):
        """E-0423: a section moved into an empty bank must not land at $4000, which holds the bank's number."""
        import tempfile
        import move_section
        with tempfile.TemporaryDirectory() as d:
            f = Path(d) / "bank9f_empty.asm"
            f.write_text('SECTION "Bank 9F", ROMX\n; bank $9F: all $00 in the reference\nDS $4000, $00\n', encoding="utf-8")
            layout = move_section.claim_empty(f, 0x9F, 'ROMX $15\n\t"Bank 15 Script_Breed"\nROMX $9F\n\t"Bank 9F"\nROMX $A0\n')
            text = f.read_text(encoding="utf-8")
            layout = move_section.move(layout, "Bank 15 Script_Breed", 0x9F)
            again = move_section.claim_empty(f, 0x9F, layout)  # a bank with a number is left as it is
        self.assertIn("    db $9f", text)
        self.assertIn('SECTION "Bank 9F Fill", ROMX\n    ds $3fff, $00', text)
        self.assertEqual(layout, 'ROMX $15\nROMX $9F\n\t"Bank 9F"\n\t"Bank 15 Script_Breed"\n\t"Bank 9F Fill"\nROMX $A0\n')
        self.assertEqual(again, layout)


@unittest.skipUnless(REF.exists(), "needs the reference ROM")
class Moves(unittest.TestCase):
    def test_the_arena_halves_move_together_only(self):
        code, rep = move(["Bank 0C Script_Arena"], "build/test_script_sections/arena1")
        self.assertEqual(code, 1)
        self.assertIn("script_jump Script_Arena_9 jumps to bank 0C", rep["bank_check_errors"][0])
        code, rep = move(["Bank 0C Script_Arena", "Bank 0C Script_Arena_9"], "build/test_script_sections/arena")
        self.assertEqual((code, rep["bank_check_errors"], rep["labels_now_in_bank"]), (0, [], ["9F"]))

    def test_the_breeding_chain_with_its_scripts_moved(self):
        code, rep = move(["Bank 15 Script_Breed"], "build/test_script_sections/breed")
        self.assertEqual(code, 0, rep)
        d = ROOT / "build/test_script_sections/breed"
        ref_sym = shift_test.read_sym(d / "base/dwm2.sym")
        mod, sym = (d / "moved/dwm2.gbc").read_bytes(), shift_test.read_sym(d / "moved/dwm2.sym")
        self.assertEqual(sym["Script_Breed"][0], 0x9F)
        self.assertEqual(mod[0x9F * 0x4000], 0x9F)  # the bank's number at $4000, not the script's first byte
        ta, tb = [], []
        r = mod_check.recipe_compare(str(ROOT / "tools/recipes/e0328_breed.txt"), REF.read_bytes(), ref_sym, mod, sym,
                                     SB.fetch_trace(sym, tb), SB.fetch_trace(ref_sym, ta))
        self.assertEqual((r["runs"], r["differ"]), (122, []))
        self.assertGreater(len(ta), 150)
        self.assertEqual(ta, tb)
        self.assertTrue(any(x.startswith("Script_Breed") for x in tb))


if __name__ == "__main__":
    unittest.main()
