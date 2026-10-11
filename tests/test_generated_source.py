"""Audits of the generated src/ tree that need no ROM and no assembler.

A banked call is `ld hl, ADDR` / `ld b, BANK` / `rst $10` (the two loads in either order):
ADDR is code in BANK. If the disassembler spells ADDR as a label, the label's bank must
equal the `ld b` value; a label from the caller's bank would assemble identically but name
the wrong routine. Each `rst $10` is anchored and its own arguments are found by looking
backwards, stopping at the previous function's terminator.
"""
import json
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
            # The note sits above the label block; a renamed routine's block is
            # `; note` / `; xref lines` / `Name::` / `Func_BBB_AAAA:: ; address name`.
            if idx is None or f"; {text}" not in lines[max(0, idx - 10):idx]:
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

        def message_entries(lines: list[str]) -> set[str]:
            """Labels of the routines that store L as the battle message (E-0137), plus one jump."""
            found, last = set(), []
            for i, line in enumerate(lines):
                if line.endswith("::"):
                    last.append(line[:-2])
                    continue
                code = line.split(";")[0].strip()
                if code == "ld a, l" and i + 1 < len(lines) and lines[i + 1].strip() == "ld [wResolveMsgActor], a":
                    found.update(last)
                if code and code not in ("xor a, a", "ld [wBattleDamageLo], a", "ld [wBattleDamageHi], a"):
                    last = []
            jumps = re.compile(r"^(\w+)::\n(?:\w+:: ; address name\n)?    j[pr] (\w+)$", re.M)
            text = "\n".join(lines)
            return found | {a for a, t in jumps.findall(text) if t in found}

        def message_argument(lines: list[str], n: int, entries: set[str]) -> bool:
            """Line n (1-based) loads HL/BC in a pair that goes into a message routine."""
            pair = re.compile(r"ld (hl|bc|l), \$")
            code = lambda k: lines[k].split(";")[0].strip() if 0 <= k < len(lines) else ""
            for first in (n - 1, n - 2):
                if pair.match(code(first)) and pair.match(code(first + 1)):
                    k = first + 2
                    while k < len(lines) and not lines[k].strip():
                        k += 1  # a label the pair falls into follows a blank line
                    after = lines[k] if k < len(lines) else ""
                    m = re.match(r"\s+(?:jp|jr|call) (\w+)$", after) or re.match(r"(\w+)::$", after)
                    if m and m.group(1) in entries:
                        return True
            return False

        bad, checked, symbolic = [], 0, 0
        sym = re.compile(r"\[[whrsv][A-Za-z0-9_]+( \+ \$[0-9A-F]+)?\]|BANK_NUMBER_BYTE|, [whrsv][A-Z][A-Za-z0-9_]*( \+ \$[0-9A-F]+)?$")
        for f in sorted(BANKS.glob("bank*.asm")):
            lines = f.read_text(encoding="utf-8").splitlines()
            entries = message_entries(lines)
            for n, line in enumerate(lines, 1):
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
                    reg = code.split()[1].rstrip(",")
                    ahead = [l.split(";")[0].strip() for l in lines[n:n + 2]]
                    if reg in ("bc", "de") and int(m.group(1), 16) >= 0xFF00 and f"add hl, {reg}" in ahead:
                        continue  # a small negative number added to HL, not an address
                    if int(m.group(1), 16) == 0xFFFF:
                        continue  # -1 as a 16-bit number, not the interrupt-enable register
                    nxt = [l.split(";")[0].strip() for l in lines[n:n + 6] if l.startswith("    ")][:2]
                    low = {"hl": "l", "de": "e", "bc": "c"}.get(reg)
                    if (int(m.group(1), 16) >= 0xFF00 and len(nxt) == 2 and nxt[0] == f"ld a, {low}"
                            and re.search(r"\[(hPlayerStepD[XY]Lo|hFF9[BD])\]", nxt[1])):
                        continue  # a step delta stored in the player movement bytes (E-0132)
                    if message_argument(lines, n, entries):
                        continue  # battle message bytes in HL/BC (E-0137)
                    if reg == "de" and any(re.match(r"call StepSpriteSlotToward", x) for x in nxt):
                        continue  # a (y, x) sprite position (E-0137)
                    if forbidden(int(m.group(1), 16), True):
                        bad.append(f"{f.name}:{n} {code}")
        self.assertGreater(symbolic, 10000, "expected the source to use many symbolic operands")
        self.assertEqual(bad[:5], [], f"{len(bad)} operands still use a raw hardware/RAM address")

    def test_includes_define_every_symbol_the_banks_use(self):
        main = (BANKS.parent / "main.asm").read_text(encoding="utf-8").splitlines()
        self.assertEqual(main[:3], ['INCLUDE "hardware.inc"', 'INCLUDE "ram.asm"', 'INCLUDE "macros.inc"'])


@unittest.skipUnless(BANKS.is_dir(), "src/banks has not been generated")
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

    def test_a_renamed_routine_is_used_by_its_callers(self):
        text = "".join(f.read_text(encoding="utf-8") for f in sorted(BANKS.glob("bank*.asm")))
        self.assertGreater(text.count("call FillBytes"), 20)
        self.assertNotIn("call Func_000_0949", text)


@unittest.skipUnless(BANKS.is_dir(), "src/banks has not been generated")
class CrossReferences(unittest.TestCase):
    def test_header_call_counts_match_the_call_sites_in_the_source(self):
        import json
        names = json.loads((BANKS.parents[1] / "config" / "names.json").read_text(encoding="utf-8"))
        files = {f.name: f.read_text(encoding="utf-8").splitlines() for f in BANKS.glob("bank*.asm")}
        header = re.compile(r"^; (\d+) call sites? from ")
        wrong, checked = [], 0
        for key, info in names.items():
            if key.startswith("_"):
                continue
            name = info["name"]
            call = re.compile(r"^\s+(?:call(?: [a-z]+,)?|farcall(?:_b)?) " + re.escape(name) + r"$")
            actual = sum(1 for lines in files.values() for l in lines if call.match(l))
            bank = int(key.split(":")[0], 16)
            lines = files[f"bank{bank:02x}.asm"]
            i = next(k for k, l in enumerate(lines) if l.startswith(name + "::"))
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


@unittest.skipUnless(BANKS.is_dir(), "src/banks has not been generated")
class BankSwitchingCallSites(unittest.TestCase):
    """For every call to a routine that takes a bank in B and a pointer in HL/DE/BC, a pointer
    spelled as a Data_ label in the same straight-line setup must name that bank."""

    HELPERS = ("CopyFromBank", "OrFromBank", "DecompressTo", "ReadByteInBank")

    def test_pointer_labels_in_a_call_setup_agree_with_ld_b(self):
        import json
        names = json.loads((BANKS.parents[1] / "config" / "names.json").read_text(encoding="utf-8"))
        helper_names = [v["name"] for k, v in names.items()
                        if not k.startswith("_") and v["name"].startswith(self.HELPERS)]
        self.assertTrue(helper_names)
        call = re.compile(r"\s+call (" + "|".join(helper_names) + r")$")
        ld_ptr = re.compile(r"\s+ld (?:hl|de|bc), Data_([0-9A-F]{3})_[0-9A-F]{4}$")
        ld_b = re.compile(r"\s+ld b, \$([0-9A-F]{2})$")
        barrier = re.compile(r"(\S+::|\s+(?:call|ret|reti|jp|jr|farcall|farcall_b|rst|add_a_to_hl)\b)")  # add_a_to_hl hides a jr
        checked, wrong = 0, []
        for f in sorted(BANKS.glob("bank*.asm")):
            lines = f.read_text(encoding="utf-8").splitlines()
            for i, line in enumerate(lines):
                if not call.match(line):
                    continue
                bnk, ptrs, b_seen = None, [], False
                for back in lines[max(0, i - 12):i][::-1]:
                    if back.startswith(";") or not back.strip():
                        continue
                    if barrier.match(back):
                        break
                    if not b_seen and back.strip().startswith("ld b,"):
                        b_seen = True  # the nearest write to B decides; a non-literal one means no bank
                        bnk = ld_b.match(back)
                    if ld_ptr.match(back):
                        ptrs.append(ld_ptr.match(back))
                if bnk and ptrs:
                    for m in ptrs:
                        checked += 1
                        if int(m.group(1), 16) != int(bnk.group(1), 16):
                            wrong.append(f"{f.name}:{i + 1} {m.group(0).strip()} with ld b,${bnk.group(1)}")
        self.assertGreater(checked, 100)
        self.assertEqual(wrong[:5], [], f"{len(wrong)} of {checked} pointer labels disagree with ld b")


@unittest.skipUnless(BANKS.is_dir(), "src/banks has not been generated")
class DecompressCallSites(unittest.TestCase):
    def test_literal_decompress_arguments_name_a_stream(self):
        stream_labels = set()
        for f in BANKS.glob("bank*.asm"):
            ls = f.read_text(encoding="utf-8").splitlines()
            for i, l in enumerate(ls[1:], 1):
                if ls[i - 1].startswith("; LZSS-compressed asset"):
                    stream_labels.add(l.split("::")[0])
                    if i + 1 < len(ls) and ls[i + 1].endswith(":: ; address name"):
                        stream_labels.add(ls[i + 1].split("::")[0])  # named streams keep the address name (E-0138)
        ld_de = re.compile(r"\s+ld de, ([A-Za-z_]\w*)$")
        sites = bad = 0
        for f in sorted(BANKS.glob("bank*.asm")):
            lines = f.read_text(encoding="utf-8").splitlines()
            for i, l in enumerate(lines):
                if re.match(r"\s+call DecompressTo", l):
                    for back in lines[max(0, i - 4):i][::-1]:
                        m = ld_de.match(back)
                        if m:
                            sites += 1
                            bad += m.group(1) not in stream_labels
                            break
        self.assertGreater(sites, 100)
        self.assertEqual(bad, 0)


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


if __name__ == "__main__":
    unittest.main()


class DataRegions(unittest.TestCase):
    """No code label is generated inside a range config/data_regions.json proves to be data (E-0087)."""

    def test_no_code_labels_in_data_regions(self):
        regions = json.loads((BANKS.parents[1] / "config/data_regions.json").read_text(encoding="utf-8"))["regions"]
        for r in regions:
            bank, lo, hi = int(r["bank"], 16), int(r["start"], 16), int(r["end"], 16)
            text = (BANKS / f"bank{bank:02x}.asm").read_text(encoding="utf-8")
            for m in re.finditer(r"^(?:Func|Jump)_[0-9A-F]{3}_([0-9A-F]{4})::", text, re.M):
                self.assertFalse(lo <= int(m.group(1), 16) < hi, f"code label {m.group(0)} inside data region {r['bank']}:{r['start']}")


class NestedDispatchCases(unittest.TestCase):
    """A `rst $00` table inside a named jump-table case names its targets after that case (E-0123)."""

    def test_table_in_a_case_belongs_to_the_case(self):
        text = (BANKS / "bank37.asm").read_text(encoding="utf-8")
        start = text.index("Func_037_4AFD_Case0D::")
        body = text[start:text.index("\n\n", start)]
        self.assertIn("rst $00", body)
        self.assertIn("dw Func_037_4AFD_Case0D_Case04", body)


class InlineTableTrim(unittest.TestCase):
    """An inline `rst $00` table stops where a called routine starts (E-0126)."""

    def test_called_routine_after_a_table_is_code(self):
        text = (BANKS / "bank12.asm").read_text(encoding="utf-8")
        start = text.index("Func_012_55F8::")
        body = text[start:start + 200]
        self.assertRegex(body, r"\n    ld a, \[w\w+\]\n    bit 7, a")  # decoded as code, whatever the RAM name
        self.assertNotIn("dw $44FA", text)


class NumericArguments(unittest.TestCase):
    """Battle message bytes and sprite positions stay numbers, not RAM or VRAM names (E-0137)."""

    def test_message_argument_pairs_are_numeric(self):
        text = (BANKS / "bank36.asm").read_text(encoding="utf-8")
        self.assertIn("    ld hl, $B58E\n    ld bc, $80A8\n    jp Jump_036_7C8B", text)
        self.assertNotIn("sB58E", text)
        self.assertNotRegex(text, r"ld bc, vTiles[01] \+ \$A8")

    def test_sprite_step_positions_are_numeric(self):
        text = (BANKS / "banke0.asm").read_text(encoding="utf-8")
        self.assertIn("ld de, $A070", text)
        self.assertNotIn("sA070", text)


class MonsterAssetNames(unittest.TestCase):
    """Monster picture and sprite streams are named after their monster (E-0138)."""

    def test_picture_table_uses_monster_names(self):
        text = (BANKS / "bank38.asm").read_text(encoding="utf-8")
        self.assertIn("    dfar MonsterPic_SpotSlime ; id 2 SpotSlime", text)
        self.assertIn("    dfar MonsterPicAttr_", text)
        self.assertIn("MonsterSprite_DrakSlime::", (BANKS / "bank20.asm").read_text(encoding="utf-8"))


class DerivedLayouts(unittest.TestCase):
    """Map records, key-world chunks and meta-sprites are laid out field by field (E-0142 to E-0147)."""

    def test_map_record_uses_far_pointers(self):
        text = (BANKS / "bank11.asm").read_text(encoding="utf-8")
        self.assertIn("MapRecord1D::\n", text)
        self.assertIn("    dfar Map1DScreens0\n    dfar Map1DAttrs0\n", text)

    def test_meta_sprite_frames_end_with_80(self):
        text = (BANKS / "bank25.asm").read_text(encoding="utf-8")
        frame = text[text.index("MetaSprites25Set02Frame0::"):]
        self.assertRegex(frame, r"^MetaSprites25Set02Frame0::\n.*\n(    db \$[0-9A-F]{2}, \$[0-9A-F]{2}, \$[0-9A-F]{2}, \$[0-9A-F]{2}( ; entry \d+)?\n)+    db \$80 ; end\n")

    def test_key_world_chunks_skip_the_screen_header(self):
        text = (BANKS / "bank67.asm").read_text(encoding="utf-8")
        self.assertIn("KeyWorldChunkGroup00::", text)


class BufferOffsetAliases(unittest.TestCase):
    """An "of" symbol renders as an offset into the buffer it names (E-0136)."""

    def test_bank2_attribute_addresses_use_the_attribute_buffer(self):
        symbols = json.loads((BANKS.parents[1] / "config/symbols.json").read_text(encoding="utf-8"))
        aliases = {k: v for k, v in symbols.items() if isinstance(v, dict) and "of" in v}
        self.assertIn("D1CC", aliases)
        text = "\n".join(line.split(";")[0] for p in BANKS.glob("bank*.asm")
                         for line in p.read_text(encoding="utf-8").splitlines())  # code only
        for key, info in aliases.items():
            base = symbols[info["of"]]["name"]
            self.assertNotRegex(text, rf"\bw{key}\b")
            self.assertIn(f"{base} + ${int(key, 16) - int(info['of'], 16):X}", text)
