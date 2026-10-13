"""Power-on run in tools/sm83.py with scripted A/Start presses (E-0318). Checks that game-meaning names agree with
where the code really runs: game mode 5 holds the opening, title, name entry and new-player setup; the game then
enters mode 1, the field, where the opening scene SceneAtSea runs. E-0319: every string the game looks up sits at a
string label of the source. An observation of our own emulator."""
import json
import re
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
        boot_trace.main(40_000_000, explore=True)
        data = json.loads((ROOT / "build/boot_trace.json").read_text(encoding="utf-8"))
        cls.mode = {name: mode for name, mode, _frame in data["executed"].values()}
        cls.events = data["events"]
        cls.strings = [e[2:] for e in data["events"] if e[0] == "string"]
        cls.labels = boot_trace.load_labels()

    def test_every_string_the_game_looks_up_has_its_string_label(self):
        """E-0319: at each return of LookupString, DE (in the current ROM bank) is a label of a string the source
        lays out, and the label's category and index are the wStringCategory and wStringIndex the game used."""
        self.assertGreater(len(self.strings), 8)
        for bank, ptr, cat, idx, text in self.strings:
            name = self.labels.get((bank, ptr), "")
            self.assertRegex(name, r"^(String|Message)_", (bank, hex(ptr), text))
            if name.startswith("String_"):
                self.assertEqual(name.split("_")[-2:], [f"{cat:02X}", f"{idx:02X}"], (name, text))

    def test_each_talk_message_routine_looks_up_the_message_its_name_quotes(self):
        """E-0319: TalkMsgNNNN_<words> (named from the text at `ld hl, $NNNN`) is followed by a lookup of message
        index $NN (category 0) whose text begins with <words>."""
        checked = 0
        for k, e in enumerate(self.events):
            if e[0] != "enter" or not e[2].startswith("TalkMsg"):
                continue
            nxt = next(x for x in self.events[k + 1:] if x[0] == "string")
            _s, _f, bank, ptr, cat, idx, text = nxt
            self.assertEqual((cat, idx), (0, int(e[2][7:11], 16) & 0xFF), (e, nxt))
            self.assertEqual(self.labels[(bank, ptr)], f"Message_00_{idx:02X}")
            words = e[2].split("_", 1)[1]
            letters = re.sub(r"[^a-z0-9]", "", (" " + text).replace(" 0 ", " Hero ").lower())
            self.assertEqual(letters[:len(words)], words.lower(), (e[2], text))
            checked += 1
        self.assertGreaterEqual(checked, 3)

    def test_the_strings_read_as_the_game_text(self):
        texts = [t for *_x, t in self.strings]
        self.assertIn("CONTINUE NEW GAME", texts[0])
        self.assertTrue(any(t.startswith("In the middle of the sea") for t in texts), texts)

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
