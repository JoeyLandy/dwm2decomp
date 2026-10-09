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
        wrong, checked, macros = [], 0, 0
        for f in sorted(BANKS.glob("bank*.asm")):
            lines = f.read_text(encoding="utf-8").splitlines()
            for i, line in enumerate(lines):
                macros += line.startswith(("    farcall ", "    farcall_b "))
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
        # `farcall L` expands to ld b, BANK(L), so its bank is right by construction; every
        # explicit setup that remains is audited here.
        self.assertGreater(macros + checked, 1000, "audit found too few banked calls to be meaningful")
        self.assertGreater(macros, 3000, "banked calls should be written with the farcall macros")
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


@unittest.skipUnless(BANKS.is_dir(), "src/banks has not been generated")
class SymbolicOperands(unittest.TestCase):
    """Instruction operands name hardware and RAM instead of repeating addresses."""

    MEM = re.compile(r"\[\$([0-9A-F]{4})\]")
    IMM = re.compile(r"^ld (?:hl|de|bc|sp), \$([0-9A-F]{4})$")

    def test_no_instruction_uses_a_raw_hardware_or_ram_address(self):
        import sys
        sys.path.insert(0, str(BANKS.parents[1] / "tools"))
        import gb_symbols as gbs

        def forbidden(addr: int, pointer: bool) -> bool:
            if addr in gbs.IO or 0xFF30 <= addr < 0xFF40:
                return True
            if not pointer and (addr in gbs.MBC or addr == gbs.BANK_NUMBER_BYTE[1]):
                return True
            return 0x8000 <= addr < 0xE000 or gbs.HRAM_START <= addr <= gbs.HRAM_END

        bad, checked, symbolic = [], 0, 0
        sym = re.compile(r"\[[whrsv][A-Za-z0-9_]+( \+ \$[0-9A-F]+)?\]|BANK_NUMBER_BYTE|, [whrsv][A-Z][A-Za-z0-9_]*( \+ \$[0-9A-F]+)?$")
        for f in sorted(BANKS.glob("bank*.asm")):
            for n, line in enumerate(f.read_text(encoding="utf-8").splitlines(), 1):
                if not line.startswith("    ") or line.lstrip().startswith(("db", "dw", "ds", "INCBIN")):
                    continue
                code = line.split(";")[0].strip()
                symbolic += bool(sym.search(code))
                m = self.MEM.search(code)
                if m:
                    checked += 1
                    if forbidden(int(m.group(1), 16), False):
                        bad.append(f"{f.name}:{n} {code}")
                    continue
                m = self.IMM.match(code)
                if m:
                    checked += 1
                    if forbidden(int(m.group(1), 16), True):
                        bad.append(f"{f.name}:{n} {code}")
        self.assertGreater(symbolic, 10000, "expected the source to use many symbolic operands")
        self.assertEqual(bad[:5], [], f"{len(bad)} operands still use a raw hardware/RAM address")

    def test_includes_define_every_symbol_the_banks_use(self):
        main = (BANKS.parent / "main.asm").read_text(encoding="utf-8").splitlines()
        self.assertEqual(main[:3], ['INCLUDE "hardware.inc"', 'INCLUDE "ram.asm"', 'INCLUDE "macros.inc"'])


REF = BANKS.parents[1] / "local" / "roms" / "dwm2-cobi-us.gbc"


@unittest.skipUnless(BANKS.is_dir() and REF.exists(), "needs generated source and the reference ROM")
class CompressedAssetNotes(unittest.TestCase):
    def test_every_stream_note_matches_a_fresh_decompression(self):
        import sys
        sys.path.insert(0, str(BANKS.parents[1] / "tools"))
        import lzss_gfx

        rom = REF.read_bytes()
        note = re.compile(r"^; LZSS-compressed asset: (\d+) bytes expand to (\d+) ")
        label = re.compile(r"^Data_([0-9A-F]{3})_([0-9A-F]{4})::")
        checked, wrong = 0, []
        for f in sorted(BANKS.glob("bank*.asm")):
            lines = f.read_text(encoding="utf-8").splitlines()
            for i, line in enumerate(lines[:-1]):
                m = note.match(line)
                if not m:
                    continue
                lm = label.match(lines[i + 1])
                self.assertIsNotNone(lm, f"{f.name}:{i + 1}: note is not followed by a Data_ label")
                bank, addr = int(lm.group(1), 16), int(lm.group(2), 16)
                out, used, ev = lzss_gfx.decompress(rom, bank, addr)
                checked += 1
                if (used, len(out)) != (int(m.group(1)), int(m.group(2))) or ev["unwritten_reads"]:
                    wrong.append(f"{f.name}:{i + 1} {lm.group(0)}")
        self.assertGreater(checked, 1000, "expected the generated source to annotate many streams")
        self.assertEqual(wrong[:5], [], f"{len(wrong)} of {checked} stream notes disagree with the ROM")


if __name__ == "__main__":
    unittest.main()
