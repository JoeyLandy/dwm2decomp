"""Slow checks that run the reference ROM on tools/sm83.py (set DWM2_SLOW=1 to enable).

They back the names of the frame loop, game mode and player variables in config/symbols.json
and config/names.json (E-0029, E-0030): about a minute of emulation."""
import os
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
ROM = ROOT / "local/roms/dwm2-cobi-us.gbc"
ENABLED = os.environ.get("DWM2_SLOW") == "1" and ROM.is_file()

if ENABLED:
    import explore


@unittest.skipUnless(ENABLED, "set DWM2_SLOW=1 and provide the reference ROM")
class FieldMode(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.gb = explore.boot()
        cls.boot_mode = cls.gb.rb(explore.WGAMEMODE)
        for b in ("start", "start", "a", "a", "start"):
            explore.press(cls.gb, b)
        for _ in range(11):
            explore.press(cls.gb, "a", hold=200_000, after=1_200_000)
        cls.gb.run(3_000_000)

    def state(self):
        rb = self.gb.rb
        return {"facing": rb(0xFF98), "x": rb(0xFF8E), "y": rb(0xFF91), "mode": rb(0xC5DB),
                "seconds": rb(0xC82E)}

    def test_boot_mode_is_5_and_field_mode_is_1(self):
        self.assertEqual(self.boot_mode, 5)
        self.assertEqual(self.state()["mode"], 1)

    def test_directions_set_facing_and_axes(self):
        import explore as ex
        seen = {}
        for name in ("left", "right", "up", "down"):
            before = self.state()
            ex.press(self.gb, name, hold=150_000, after=500_000)
            seen[name] = (before, self.state())
        self.assertEqual({k: v[1]["facing"] for k, v in seen.items()},
                         {"down": 0, "right": 1, "up": 2, "left": 3})
        for name in ("left", "right"):  # a horizontal step changes hPlayerX only
            self.assertEqual(seen[name][1]["y"], seen[name][0]["y"])

    def test_play_time_counts_seconds(self):
        before = self.state()["seconds"]
        self.gb.run(3_000_000)
        self.assertNotEqual(self.state()["seconds"], before)


if __name__ == "__main__":
    unittest.main()
