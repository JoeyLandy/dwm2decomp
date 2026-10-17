"""The resistance names (E-0338) agree with the code that reads them.

PackResistanceFieldsToDE (bank $19) packs the 27 one-byte levels of a record into the 7-byte slot record: index 26
in byte 0 bits 7-6, indexes 0-2 in byte 0 bits 5-4, 3-2 and 1-0, then four per byte from index 3 (bits 7-6 first).
Every routine named `...<Name>Resistance` loads one byte (GetTargetSlotResistancesByteN) and isolates one 2-bit field
with rotates and `and $03`; that field must be the packed position of RESIST_<NAME>.
"""
import re
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
LISTING = ROOT / "build" / "listing"


def packed_position(index: int) -> tuple[int, int]:
    """(byte, low bit of the field) of resistance `index` in the packed record."""
    if index == 26:
        return 0, 6
    if index < 3:
        return 0, 4 - 2 * index
    k = index - 3
    return 1 + k // 4, 6 - 2 * (k % 4)


def field_of(ops: list[str]) -> int | None:
    """Low bit of the field the rotates before `and $03` bring to bits 1-0 (rlca twice = bits 7-6, ...)."""
    shift = 0  # right rotation, in bits
    for op in ops:
        if op.lower() in ("and a, $03", "and $03"):  # the listing's spelling and src/'s
            return shift % 8
        shift += {"rrca": 1, "rlca": -1, "swap a": 4}.get(op, 0) if op in ("rrca", "rlca", "swap a") else 0
        if op not in ("rrca", "rlca", "swap a"):
            return None
    return None


class ResistanceNamesTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        rec = (ROOT / "src" / "records.inc").read_text(encoding="utf-8")
        cls.index = {n: int(v) for n, v in re.findall(r"^DEF RESIST_(\w+) EQU (\d+)$", rec, re.M)}
        import source_tree
        cls.text = source_tree.text()  # D-015 (H1b): the source, src/

    def test_packing_formula_matches_the_packer(self):
        self.assertEqual(len(self.index), 27)
        seen = {packed_position(i) for i in range(27)}
        self.assertEqual(len(seen), 27)
        self.assertNotIn((6, 0), seen)  # the last field of byte 6 is unused
        self.assertIn("PackResistanceFieldsToDE::", self.text)

    def readers(self) -> list[tuple[str, str, int, int]]:
        """(routine, resistance name, byte read, low bit of the field isolated) for each named reader."""
        out = []
        for m in re.finditer(r"^((?:Roll|Scale|Attack|Skill)\w*?(?:By|Vs)(\w+?)Resistance)::.*\n(?=((?:.*\n){0,12}))",
                             self.text, re.M):
            name, field, body = m.group(1), m.group(2).upper(), m.group(3)
            ops = [ln.strip() for ln in body.split("\n") if ln.startswith("    ") and not ln.strip().startswith(";")]
            call = next((i for i, op in enumerate(ops) if re.match(r"call GetTargetSlotResistancesByte\d$", op)), None)
            if field in self.index and call is not None:
                out.append((name, field, int(ops[call][-1]), field_of(ops[call + 1:])))
        return out

    def test_named_readers_isolate_their_field(self):
        found = self.readers()
        self.assertGreaterEqual(len(found), 10)
        for name, field, byte, low in found:
            self.assertEqual((byte, low), packed_position(self.index[field]), name)

    def test_control_shifted_names_are_caught(self):
        """With every name moved to the next index, the same check fails for most readers."""
        names = sorted(self.index, key=self.index.get)
        shifted = {n: (self.index[n] + 1) % 27 for n in names}
        wrong = sum((byte, low) != packed_position(shifted[field]) for _n, field, byte, low in self.readers())
        self.assertGreaterEqual(wrong, len(self.readers()) - 1)


if __name__ == "__main__":
    unittest.main()
