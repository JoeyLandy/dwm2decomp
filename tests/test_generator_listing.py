"""Checks of the generator's own output, build/listing/ (D-015, H1b; split from tests/test_generated_source.py).

tools/disasm_all.py stays as a re-analysis tool: it traces the ROM and copies the names and notes of config/ into
an annotated listing. These tests check that copy and the generator's banked-call labels. They read
build/listing/ and skip without it; the source itself is checked by tests/test_source_audits.py.
"""
import json
import re
import unittest
from pathlib import Path

BANKS = Path(__file__).resolve().parents[1] / "build" / "listing"
LD_HL = re.compile(r"\s+ld hl, (?:(?:Func|Jump|Data)_([0-9A-F]{3})_([0-9A-F]{4})|\$([0-9A-F]{4}))$")
LD_B = re.compile(r"\s+ld b, \$([0-9A-F]{2})$")
CALL = re.compile(r"\s+(?:rst \$10|call \$0010)$")
TERMINATOR = re.compile(r"\s+(?:ret|reti|jp |jr |jp$)")

@unittest.skipUnless(BANKS.is_dir(), "build/listing has not been generated (tools/disasm_all.py)")
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


@unittest.skipUnless(BANKS.is_dir(), "build/listing has not been generated (tools/disasm_all.py)")
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
            # The note sits above the label block; a renamed routine's block is
            # `; note` / `; xref lines` / `Name::` / `Func_BBB_AAAA:: ; address name`.
            if idx is None or f"; {text}" not in lines[max(0, idx - 10):idx]:
                missing.append(key)
        self.assertEqual(missing, [], "annotation not emitted directly above its label")


@unittest.skipUnless(BANKS.is_dir(), "build/listing has not been generated (tools/disasm_all.py)")
class RoutineNames(unittest.TestCase):
    def test_every_configured_name_is_a_label_with_its_address_alias(self):
        import json
        names = json.loads((BANKS.parents[1] / "config" / "names.json").read_text(encoding="utf-8"))
        problems = []
        for key, info in names.items():
            if key.startswith("_"):
                continue
            bank_s, addr_s = key.split(":")
            bank, addr = int(bank_s, 16), int(addr_s, 16)
            lines = (BANKS / f"bank{bank:02x}.asm").read_text(encoding="utf-8").splitlines()
            alias = f"Func_{bank:03X}_{addr:04X}:: ; address name"
            alt = f"Jump_{bank:03X}_{addr:04X}:: ; address name"
            if info.get("data"):
                alias = alt = f"Data_{bank:03X}_{addr:04X}:: ; address name"
            i = next((k for k, l in enumerate(lines) if l.startswith(info["name"] + "::")), None)
            if i is None or lines[i + 1] not in (alias, alt):
                problems.append(key)
        self.assertEqual(problems, [])


@unittest.skipUnless(BANKS.is_dir(), "build/listing has not been generated (tools/disasm_all.py)")
class CrossReferences(unittest.TestCase):
    def test_header_call_counts_match_the_call_sites_in_the_source(self):
        import json
        from collections import Counter
        names = json.loads((BANKS.parents[1] / "config" / "names.json").read_text(encoding="utf-8"))
        files = {f.name: f.read_text(encoding="utf-8").splitlines() for f in BANKS.glob("bank*.asm")}
        header = re.compile(r"^; (\d+) call sites? from ")
        # E-0368: one pass over the listing counts every call operand (the same lines a per-name
        # `^\s+(?:call(?: [a-z]+,)?|farcall(?:_b)?) <name>$` matches), and indexes each bank's label lines
        call = re.compile(r"^\s+(?:call(?: [a-z]+,)?|farcall(?:_b)?) (.+)$")
        calls = Counter(m.group(1) for lines in files.values() for l in lines if (m := call.match(l)))
        heads = {fname: {l.split("::")[0]: k for k, l in reversed(list(enumerate(lines))) if "::" in l}
                 for fname, lines in files.items()}
        wrong, checked = [], 0
        for key, info in names.items():
            if key.startswith("_"):
                continue
            name = info["name"]
            actual = calls[name]
            bank = int(key.split(":")[0], 16)
            lines = files[f"bank{bank:02x}.asm"]
            i = heads[f"bank{bank:02x}.asm"][name]
            claimed = next((int(m.group(1)) for k in range(i - 1, max(0, i - 8), -1)
                            if (m := header.match(lines[k]))), 0)
            checked += 1
            # rst-vector and jump-only entries have no direct call line; only compare when called
            if claimed != actual and actual > 0:
                wrong.append(f"{name}: header {claimed}, source {actual}")
        self.assertGreater(checked, 40)
        self.assertEqual(wrong, [])

    def test_header_ram_lists_never_name_a_register_operand(self):
        for f in BANKS.glob("bank*.asm"):
            for line in f.read_text(encoding="utf-8").splitlines():
                if line.startswith(("; reads: ", "; writes: ", "; points at: ")):
                    self.assertNotRegex(line, r"\b(hl|bc|de|af)\b", line)


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
                if lm is None and i + 2 < len(lines) and re.match(r"^[A-Za-z_]\w*::", lines[i + 1]):
                    lm = label.match(lines[i + 2])  # a named stream keeps Data_BBB_AAAA as its alias (E-0138)
                self.assertIsNotNone(lm, f"{f.name}:{i + 1}: note is not followed by a Data_ label")
                bank, addr = int(lm.group(1), 16), int(lm.group(2), 16)
                out, used, ev = lzss_gfx.decompress(rom, bank, addr)
                checked += 1
                zero_filled = "into a zero-filled buffer" in line  # SGB transfers clear vTiles1 first (E-0150)
                if (used, len(out)) != (int(m.group(1)), int(m.group(2))) or (ev["unwritten_reads"] and not zero_filled):
                    wrong.append(f"{f.name}:{i + 1} {lm.group(0)}")
        self.assertGreater(checked, 1000, "expected the generated source to annotate many streams")
        self.assertEqual(wrong[:5], [], f"{len(wrong)} of {checked} stream notes disagree with the ROM")


@unittest.skipUnless(BANKS.is_dir(), "build/listing has not been generated (tools/disasm_all.py)")
class DataRegions(unittest.TestCase):
    """No code label is generated inside a range config/data_regions.json proves to be data (E-0087)."""

    def test_no_code_labels_in_data_regions(self):
        regions = json.loads((BANKS.parents[1] / "config/data_regions.json").read_text(encoding="utf-8"))["regions"]
        for r in regions:
            bank, lo, hi = int(r["bank"], 16), int(r["start"], 16), int(r["end"], 16)
            text = (BANKS / f"bank{bank:02x}.asm").read_text(encoding="utf-8")
            for m in re.finditer(r"^(?:Func|Jump)_[0-9A-F]{3}_([0-9A-F]{4})::", text, re.M):
                self.assertFalse(lo <= int(m.group(1), 16) < hi, f"code label {m.group(0)} inside data region {r['bank']}:{r['start']}")



@unittest.skipUnless(BANKS.is_dir() and (BANKS.parents[1] / "config/name_families.json").exists(),
                     "needs the generator's listing and config/name_families.json")
class FamilyNamesAreApplied(unittest.TestCase):
    """The generator names each family of config/name_families.json (from tests/test_routine_behaviour.py, H1b)."""

    def test_every_family_name_is_defined_in_the_listing(self):
        text = "".join(f.read_text(encoding="utf-8") for f in BANKS.glob("bank*.asm"))
        families = json.loads((BANKS.parents[1] / "config/name_families.json").read_text(encoding="utf-8"))["families"]
        self.assertGreater(len(families), 20)
        for fam in families:
            self.assertRegex(text, r"(?m)^" + re.escape(fam["name"]) + r"(_Bank[0-9A-F]{2}(_[0-9A-F]{4})?)?::",
                             fam["name"])


if __name__ == "__main__":
    unittest.main()
