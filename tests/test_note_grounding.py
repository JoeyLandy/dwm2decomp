"""The notes on code labels in src/ are grounded in the code they describe (E-0317; src/ since D-015, H1b)."""
import random
import re
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import check_note_grounding as cng  # noqa: E402

BASELINE = ROOT / "tests/data/ungrounded_mentions.txt"


def baseline() -> set[tuple[str, str]]:
    out = set()
    for ln in BASELINE.read_text(encoding="utf-8").splitlines():
        if ln and not ln.startswith("#"):
            nm, x = ln.split("\t")
            out.add((nm, x))
    return out


class NoteGrounding(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.src = cng.Source()

    def test_no_new_ungrounded_mention(self):
        """Every mention is connected to its routine, except those recorded in tests/data/ungrounded_mentions.txt
        (older C1 notes): a hand edit that leaves a note naming code it no longer reaches fails here."""
        grounded, total, bad = cng.check(src=self.src)
        self.assertGreater(total, 30000)
        new = sorted(set(bad) - baseline())
        self.assertEqual(new[:20], [], f"{len(new)} mentions not connected to their routine and not recorded")

    def test_notes_name_only_ram_symbols_that_exist(self):
        """E-0320: a RAM name in a note is a symbol of src/ram.asm, the stem of several (wGold for wGoldLo/Mid/Hi),
        or a former name after "was"."""
        stale = []
        for nm, v in self.src.names.items():
            note = v.get("note", "")
            for t in re.findall(r"\b([wsh][A-Z][A-Za-z0-9_]*[a-z][A-Za-z0-9_]*)\b", note):
                if t in self.src.ramsyms or re.search(r"\bwas\s+" + t, note):
                    continue
                if not any(s.startswith(t) for s in self.src.ramsyms):
                    stale.append((nm, t))
        self.assertEqual(stale[:20], [])

    def test_the_check_rejects_unrelated_symbols(self):
        """Negative control: one random RAM symbol, or one random routine, per note is accepted rarely."""
        syms = sorted(self.src.ramsyms)
        routines = sorted(n for n in self.src.regions if "_" not in n[1:] and not n.startswith(("Data", "String")))
        for pool in (syms, routines):
            rng = random.Random(5)
            g, t, _ = cng.check(control=lambda nm, note: {rng.choice(pool)}, src=self.src)
            self.assertLess(g / t, 0.10, (g, t))

    def test_a_note_naming_unreached_code_is_caught(self):
        """A mention added to one note that names a routine the code never reaches is reported as new."""
        nm = next(n for n in self.src.names if n in self.src.regions)
        far = next(r for r in sorted(self.src.regions) if r not in self.src.closure(nm) and len(r) > 8
                   and r[0].isupper() and "_" not in r)
        self.src.names[nm] = {"name": nm, "note": self.src.names[nm]["note"] + f" It calls {far}."}
        try:
            _g, _t, bad = cng.check(src=self.src)
            self.assertIn((nm, far), set(bad) - baseline())
        finally:
            self.src.names[nm]["note"] = self.src.names[nm]["note"].replace(f" It calls {far}.", "")


if __name__ == "__main__":
    unittest.main()
