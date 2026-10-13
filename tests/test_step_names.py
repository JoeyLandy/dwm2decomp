"""Structural steps named after what they show, call or write (E-0340): every such name is backed by its body."""
import re
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
LISTING = ROOT / "build" / "listing"
STEP = re.compile(r"^([A-Za-z_]\w*?(?:_(?:Case|Sub|Shared)[0-9A-F]{2}|_Table\d))_([A-Z][A-Za-z0-9]+)::", re.M)


@unittest.skipUnless(LISTING.is_dir(), "build/listing has not been generated (tools/disasm_all.py)")
class StepNamesTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        import json
        cls.made = set(json.loads((LISTING / "step_names.json").read_text(encoding="utf-8")).values())
        cls.bodies = {}
        for p in sorted(LISTING.glob("bank*.asm")):
            text = p.read_text(encoding="utf-8")
            heads = [(m.start(), m.group(0)[:-2]) for m in re.finditer(r"^[A-Za-z_]\w*::(?! ; address name)", text, re.M)]
            for (a, name), (b, _n) in zip(heads, heads[1:] + [(len(text), "")]):
                cls.bodies[name] = text[a:b]

    def test_set_and_advance_suffixes_write_their_variable(self):
        checked = 0
        for name, body in self.bodies.items():
            m = re.match(r"^\w*?(?:_(?:Case|Sub|Shared)[0-9A-F]{2}|_Table\d)_(Set|Advance|Back)([A-Z][A-Za-z0-9]*)$", name)
            if not m or name not in self.made:
                continue
            var = m.group(2)
            called = re.search(r"\b(?:call|farcall|jp)(?: \w+,)? " + m.group(1) + re.escape(var) + r"\b", body)
            if m.group(1) == "Set":  # a write, or (an older rule's name) a call to Set<X>
                self.assertTrue(called or re.search(r"ldh? \[[wh]" + re.escape(var) + r"\], a", body), name)
            else:
                self.assertTrue(called or re.search(r"ld hl, [wh]" + re.escape(var) + r"\s*\n\s+(inc|dec) \[hl\]", body),
                                name)
            checked += 1
        self.assertGreaterEqual(checked, 50)

    def test_call_suffixes_are_called(self):
        checked = 0
        for name, body in self.bodies.items():
            m = STEP.match(name + "::")
            if not m or m.group(2) not in self.bodies or name not in self.made:
                continue  # a quoted-words suffix, or Set/Advance
            targets = re.findall(r"\b(?:call|farcall|farcall_b|jp)(?: \w+,)? (\w+)", body)
            self.assertTrue(any(m.group(2) in tgt for tgt in targets), name)  # the callee or its family
            checked += 1
        self.assertGreaterEqual(checked, 100)


if __name__ == "__main__":
    unittest.main()
