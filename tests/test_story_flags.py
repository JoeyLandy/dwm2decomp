"""Story flag and battle status names (D-009) agree with the code that sets and uses them."""
import re
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
LISTING = ROOT / "build" / "listing"


@unittest.skipUnless(LISTING.is_dir(), "build/listing has not been generated (tools/disasm_all.py)")
class StoryFlagNamesTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        inc = (ROOT / "src" / "constants.inc").read_text(encoding="utf-8")
        cls.events = {n: int(v, 16) for n, v in re.findall(r"^DEF (EVENT_\w+) EQU \$([0-9A-F]+)", inc, re.M)}
        cls.bstat = {n: int(v) for n, v in re.findall(r"^DEF (BSTAT\d_\w+) EQU (\d)", inc, re.M)}
        cls.text = "\n".join(p.read_text(encoding="utf-8") for p in sorted(LISTING.glob("bank*.asm")))

    def test_names_are_unique_and_many(self):
        self.assertGreaterEqual(len(self.events), 200)
        self.assertEqual(len(set(self.events.values())), len(self.events))

    def test_every_event_is_set_under_its_name(self):
        set_by_call = set(re.findall(r"ld de, (EVENT_\w+)\s*\n(?:\s*;.*\n)*\s+(?:call|farcall) SetFlagBit", self.text))
        set_by_script = set(re.findall(r"script_set_flag (EVENT_\w+)", self.text))
        self.assertEqual(set(self.events) - set_by_call - set_by_script, set())

    def test_event_loads_feed_flag_routines(self):
        for m in re.finditer(r"ld de, (EVENT_\w+)\s*\n((?:\s*;.*\n)*)(.*)", self.text):
            self.assertRegex(m.group(3), r"^\s+(?:call|farcall) (?:Set|Clear|Test)FlagBit", m.group(1))

    def test_status_bits_only_on_status_bytes(self):
        """Each BSTATk_ use sits after `ld hl, wBattleStatusk` (or a TargetStatuskAddress helper) of the same byte."""
        lines = self.text.split("\n")
        uses = 0
        for i, ln in enumerate(lines):
            m = re.search(r"\b(?:bit|set|res) BSTAT(\d)_\w+, \[hl\]", ln)
            if not m:
                continue
            uses += 1
            back = "\n".join(lines[max(0, i - 12):i])
            k = m.group(1)
            sources = re.findall(r"ld hl, wBattleStatus(\d?)\b|TargetStatus(\d)Address|HLToBattleStatus(8)Entry", back)
            last = next((a or b or c or "0" for a, b, c in reversed(sources)), None) if sources else None
            self.assertEqual(last, k, ln)
        self.assertGreaterEqual(uses, 100)


REF = ROOT / "local" / "roms" / "dwm2-cobi-us.gbc"


@unittest.skipUnless(REF.exists() and any(ROOT.glob("build/run*/dwm2.sym")), "needs the reference ROM and a build")
class StatusBitsInBattleTest(unittest.TestCase):
    """tools/status_check.py: a forced status bit brings its battle text (E-0339)."""

    @classmethod
    def setUpClass(cls):
        import status_check
        cls.s = status_check
        cls.start = status_check.base()
        cls.none = set(status_check.run(cls.start, None, None))

    def check(self, byte, bit, cat_index):
        shown = set(self.s.run(self.start, byte, bit))
        self.assertIn(cat_index, shown)
        self.assertNotIn(cat_index, self.none)

    def test_asleep_wakes_up(self):
        self.check(0, 7, self._find("woke up!"))

    def test_frozen(self):
        self.check(3, 0, self._find("is frozen solid!"))

    def test_ironized(self):
        self.check(5, 6, self._find("is a hunk of iron!"))

    @staticmethod
    def _find(words: str) -> tuple[int, int]:
        t = next((ROOT / "src" / "banks").glob("bank2f_*.asm")).read_text(encoding="utf-8")
        for m in re.finditer(r"^String_2F_(\d\d)_([0-9A-F]{2})::\n((?:    db .*\n)+)", t, re.M):
            body = " ".join(re.findall(r'"([^"]*)"', m.group(3)))
            if words in re.sub(r"<[A-Z_0-9]+>", " ", body).replace("  ", " "):
                return int(m.group(1)), int(m.group(2), 16)
        raise AssertionError(words)


if __name__ == "__main__":
    unittest.main()
