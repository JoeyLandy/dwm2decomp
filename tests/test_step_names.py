"""Structural steps named after what they show, call or write (E-0340): every such name is backed by its body."""
import json
import re
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
LISTING = ROOT / "build" / "listing"
STRUCT = re.compile(r"_(?:Case|Sub|Shared)[0-9A-F]{2}|_Table\d")


@unittest.skipUnless((LISTING / "step_names.json").is_file(), "build/listing has not been generated")
class StepNamesTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        renames = json.loads((LISTING / "step_names.json").read_text(encoding="utf-8"))
        cls.tags = {}  # new name -> the description added
        for old, new in renames.items():
            root = STRUCT.split(old)[0]
            if new.startswith(old + "_"):
                cls.tags[new] = new[len(old) + 1:]
            elif new.startswith(root + "_"):
                cls.tags[new] = new[len(root) + 1:]
        cls.bodies = {}
        for p in sorted(LISTING.glob("bank*.asm")):
            text = p.read_text(encoding="utf-8")
            heads = [(m.start(), m.group(0)[:-2]) for m in re.finditer(r"^[A-Za-z_]\w*::(?! ; address name)", text, re.M)]
            for (a, name), (b, _n) in zip(heads, heads[1:] + [(len(text), "")]):
                cls.bodies[name] = text[a:b]

    def test_every_rename_has_a_description(self):
        self.assertGreaterEqual(len(self.tags), 500)
        self.assertTrue(all(self.tags.values()))

    def test_set_and_advance_descriptions_write_their_variable(self):
        checked = 0
        for name, tag in self.tags.items():
            m = re.fullmatch(r"(Set|Advance|Back)([A-Z][A-Za-z0-9]*)", tag)
            if not m or tag in self.bodies or name not in self.bodies:
                continue  # a routine named Set..., checked below
            body, var = self.bodies[name], m.group(2)
            if m.group(1) == "Set":
                self.assertRegex(body, r"ldh? \[[wh]" + re.escape(var) + r"\], a", name)
            else:
                self.assertRegex(body, r"ld hl, [wh]" + re.escape(var) + r"\s*\n\s+(inc|dec) \[hl\]", name)
            checked += 1
        self.assertGreaterEqual(checked, 50)

    def test_call_descriptions_are_called(self):
        checked = 0
        for name, tag in self.tags.items():
            if tag not in self.bodies or name not in self.bodies:
                continue  # quoted words, or Set/Advance
            self.assertRegex(self.bodies[name], r"\b(?:call|farcall|farcall_b|jp)(?: \w+,)? " + re.escape(tag) + r"\b",
                             name)
            checked += 1
        self.assertGreaterEqual(checked, 100)


if __name__ == "__main__":
    unittest.main()
