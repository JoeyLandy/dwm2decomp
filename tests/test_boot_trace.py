"""Power-on run in tools/sm83.py with scripted A/Start presses (E-0318). Checks that game-meaning names agree with
where the code really runs: game mode 5 holds the opening, title, name entry and new-player setup; the game then
enters mode 1, the field, where the opening scene SceneAtSea runs. An observation of our own emulator."""
import json
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
ROM = ROOT / "local/roms/dwm2-cobi-us.gbc"
HAVE_SYM = any(ROOT.glob("build/run*/dwm2.sym"))


@unittest.skipUnless(ROM.is_file() and HAVE_SYM, "reference ROM or a build's .sym file not present")
class BootTrace(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        import boot_trace
        boot_trace.main(40_000_000)
        data = json.loads((ROOT / "build/boot_trace.json").read_text(encoding="utf-8"))
        cls.mode = {name: mode for name, mode in data["executed"].values()}

    def test_title_flow_runs_in_game_mode_5(self):
        for name in ("GameMode5_Init", "GameMode5_Update_LoadScreens_ScreenWithMusic", "RunNameEntryStateWhenNotFading"):
            self.assertEqual(self.mode.get(name), 5, name)

    def test_the_field_and_the_opening_scene_run_in_game_mode_1(self):
        for name in ("FieldModeStateDispatch", "UpdatePlayerMovement", "SceneAtSea", "RunEventScriptFrame"):
            self.assertEqual(self.mode.get(name), 1, name)

    def test_battle_code_has_not_run_before_any_battle(self):
        self.assertFalse([n for n in self.mode if n.startswith(("RunBattleSetup", "BattleEnd_"))])


if __name__ == "__main__":
    unittest.main()
