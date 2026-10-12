"""Every INCBIN slice is introduced by an asset comment (E-0240, E-0301, E-0316): an unexplained slice means a
region lost its identification, as when a near-constant copy signature made padding trace as code."""
import re
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
BANKS = ROOT / "src/banks"


@unittest.skipUnless(BANKS.is_dir(), "src/banks has not been generated")
class IncbinIdentified(unittest.TestCase):
    def test_no_incbin_without_an_asset_comment(self):
        bad = []
        for p in sorted(BANKS.glob("bank*.asm")):
            prev: list[str] = []
            for n, line in enumerate(p.read_text(encoding="utf-8").split("\n"), 1):
                if line.startswith("SECTION"):
                    prev = []
                if 'INCBIN "' in line and not re.search(r"compressed asset|LZSS|stream|expand", " ".join(prev[-4:]), re.I):
                    bad.append(f"{p.name}:{n}")
                if line.strip():
                    prev = (prev + [line.strip()])[-6:]
        self.assertEqual(bad, [])


if __name__ == "__main__":
    unittest.main()
