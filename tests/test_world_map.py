"""Select opens the world map (E-0339): field state 8, wWorldMapRegion from the map number."""
import sys
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
REF = ROOT / "local" / "roms" / "dwm2-cobi-us.gbc"
wModeState, wWorldMapState, wWorldMapRegion, hMapId = 0xC5DC, 0xC5DD, 0xC944, 0xFF90


@unittest.skipUnless(REF.exists() and any(ROOT.glob("build/run*/dwm2.sym")), "needs the reference ROM and a build")
class WorldMapTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        import play
        desert = (ROOT / "tools/recipes/e0321_desert.txt").as_posix()
        recipe = ("@ " + desert + "\n"
                  "w01! | k03! | hMapId=0x30 hMapScreenX=0 hMapScreenY=0 hPlayerX=0x50 hPlayerY=0x70 wStoryFlags=0x06 "
                  "wFieldReturnPhase=0 wModeState=0 wGameMode=1 wModeChangeRequest=1 | W200\n"
                  "w02! | w01! |  | E W120\n"
                  "w03! | w01! |  | B W120\n")
        with tempfile.TemporaryDirectory() as d:
            path = Path(d) / "wm.txt"
            path.write_text(recipe, encoding="utf-8")
            cls.kept, _ = play.replay(str(path), {"w01!", "w02!", "w03!"})

    def test_select_opens_the_world_map(self):
        before, after = self.kept["w01!"], self.kept["w02!"]
        self.assertEqual((before.rb(hMapId), before.rb(wModeState)), (0x30, 0))
        self.assertEqual(after.rb(wModeState), 8)  # FieldState_WorldMap
        self.assertNotEqual(after.rb(wWorldMapState), 0)
        self.assertEqual(after.rb(wWorldMapRegion), 1)  # maps $30-$47

    def test_control_another_button_does_not(self):
        self.assertEqual(self.kept["w03!"].rb(wModeState), 0)


if __name__ == "__main__":
    unittest.main()
