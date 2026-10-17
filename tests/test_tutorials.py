"""The three tutorials of docs/tutorials/, followed from a clean copy of src/ (H7, E-0413).

Each tutorial's mod folder (mods/tutorial_*) is built by tools/make_mod.py, which also runs the smoke test
(tools/mod_check.py), and then the change the tutorial describes is checked on the modded ROM with the game's own
routine, on tools/sm83.py.
"""
import json
import re
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import mechanics as M  # noqa: E402
import toolchain  # noqa: E402

REF = ROOT / "local/roms/dwm2-cobi-us.gbc"


def make(name: str, frames: int, out: Path) -> tuple[subprocess.CompletedProcess, dict]:
    p = subprocess.run([sys.executable, "-I", str(ROOT / "tools/make_mod.py"), str(ROOT / "mods" / name), "--out",
                        str(out), "--frames", str(frames)], cwd=ROOT, capture_output=True, text=True)
    rep = json.loads((out / "report.json").read_text(encoding="utf-8")) if (out / "report.json").exists() else {}
    return p, rep


def constant(name: str) -> int:
    inc = (ROOT / "src/constants.inc").read_text(encoding="utf-8")
    return int(re.search(rf"^DEF {name} EQU \$([0-9A-Fa-f]+)", inc, re.M).group(1), 16)


@unittest.skipUnless(REF.exists() and toolchain.installed(), "needs the reference ROM and RGBDS")
class Tutorials(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.tmp = tempfile.TemporaryDirectory(dir=ROOT / "build")

    @classmethod
    def tearDownClass(cls):
        cls.tmp.cleanup()

    def built(self, name, frames=1500):
        out = Path(self.tmp.name) / name
        p, rep = make(name, frames, out)
        self.assertEqual(p.returncode, 0, p.stdout + p.stderr)
        sm = rep["smoke_test"]
        self.assertIsNone(sm["crash"])
        self.assertIsNone(sm["ran_data"])
        self.assertIsNone(sm["progress"])
        rom = (out / f"{name}.gbc").read_bytes()
        return rom, M.rom_labels(out / "build/dwm2.sym"), rep

    def test_1_monster_stats(self):
        rom, L, rep = self.built("tutorial_stats")
        self.assertEqual(rep["done"], ["data: 1 lines and 0 lists"])
        R = M.ram()
        gb = M.call(rom, *L["LoadMonsterRecord"], {R["wMonsterId"]: 1, R["wMonsterId"] + 1: 0})
        self.assertEqual(gb.rb(R["wRecordBuffer"] + 10) | gb.rb(R["wRecordBuffer"] + 11) << 8, 99)

    def test_2_text(self):
        rom, L, rep = self.built("tutorial_text", frames=3000)
        sm = rep["smoke_test"]
        self.assertIsNotNone(sm["first_difference"])  # the narration is in the scripted opening
        import gb_text as T
        bank, addr = L["Message_00_00"]
        at = bank * 0x4000 + addr - 0x4000
        want = T.parse('"Far out in the<LINE>southern sea lies<PROMPT>"')
        self.assertEqual(rom[at:at + len(want)], want)

    def test_3_breeding(self):
        rom, L, rep = self.built("tutorial_breeding")
        self.assertEqual(rep["done"], ["data: 0 lines and 2 lists"])
        import breed_path
        R = M.ram()
        fam = lambda s: breed_path.family(M.Rom(rom), L, s)  # noqa: E731
        drak, slime, swordgon = (constant(n) for n in ("MONSTER_DRAKSLIME", "MONSTER_SLIME", "MONSTER_SWORDGON"))
        self.assertEqual(breed_path.game_child(rom, L, R, drak, slime, fam), constant("MONSTER_METALKING"))
        self.assertEqual(breed_path.game_child(rom, L, R, drak, swordgon, fam), constant("MONSTER_SLIMEBORG"))


if __name__ == "__main__":
    unittest.main()
