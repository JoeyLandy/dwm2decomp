"""Audits of the generated src/ tree that need no ROM and no assembler.

A banked call is `ld hl, ADDR` / `ld b, BANK` / `rst $10` (the two loads in either order):
ADDR is code in BANK. If the disassembler spells ADDR as a label, the label's bank must
equal the `ld b` value; a label from the caller's bank would assemble identically but name
the wrong routine. Each `rst $10` is anchored and its own arguments are found by looking
backwards, stopping at the previous function's terminator.
"""
import re
import unittest
from pathlib import Path

BANKS = Path(__file__).resolve().parents[1] / "src" / "banks"
LD_HL = re.compile(r"\s+ld hl, (?:(?:Func|Jump|Data)_([0-9A-F]{3})_([0-9A-F]{4})|\$([0-9A-F]{4}))$")
LD_B = re.compile(r"\s+ld b, \$([0-9A-F]{2})$")
CALL = re.compile(r"\s+(?:rst \$10|call \$0010)$")
TERMINATOR = re.compile(r"\s+(?:ret|reti|jp |jr |jp$)")


@unittest.skipUnless(BANKS.is_dir(), "src/banks has not been generated")
class GeneratedSource(unittest.TestCase):
    def test_banked_call_labels_name_the_target_bank(self):
        wrong, checked = [], 0
        for f in sorted(BANKS.glob("bank*.asm")):
            lines = f.read_text(encoding="utf-8").splitlines()
            for i, line in enumerate(lines):
                if not CALL.match(line):
                    continue
                hl = bnk = None
                for j in range(i - 1, max(-1, i - 9), -1):
                    w = lines[j]
                    if TERMINATOR.match(w):
                        break
                    if hl is None and LD_HL.match(w):
                        hl = (j, LD_HL.match(w))
                    if bnk is None and LD_B.match(w):
                        bnk = LD_B.match(w)
                if hl is None or bnk is None or hl[1].group(1) is None:
                    continue  # numeric operand: nothing to contradict
                checked += 1
                if int(hl[1].group(1), 16) != int(bnk.group(1), 16):
                    wrong.append(f"{f.name}:{hl[0] + 1} {lines[hl[0]].strip()} but ld b,${bnk.group(1)}")
        self.assertGreater(checked, 1000, "audit found too few banked-call setups to be meaningful")
        self.assertEqual(wrong[:5], [], f"{len(wrong)} of {checked} banked-call labels name the wrong bank")


@unittest.skipUnless(BANKS.is_dir(), "src/banks has not been generated")
class Annotations(unittest.TestCase):
    def test_every_annotation_appears_above_its_label(self):
        import json
        notes = json.loads((BANKS.parents[1] / "config" / "annotations.json").read_text(encoding="utf-8"))
        missing = []
        for key, text in notes.items():
            if key.startswith("_"):
                continue
            bank_s, addr_s = key.split(":")
            lines = (BANKS / f"bank{int(bank_s, 16):02x}.asm").read_text(encoding="utf-8").splitlines()
            label = re.compile(rf"^(?:Func|Jump)_{int(bank_s, 16):03X}_{int(addr_s, 16):04X}::")
            idx = next((i for i, l in enumerate(lines) if label.match(l)), None)
            if idx is None or lines[idx - 1] != f"; {text}":
                missing.append(key)
        self.assertEqual(missing, [], "annotation not emitted directly above its label")


if __name__ == "__main__":
    unittest.main()
