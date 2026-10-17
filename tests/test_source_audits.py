"""Audits of the source src/ (D-015, H1b; formerly tests/test_generated_source.py, which read build/listing/).

They read src/ itself, with label banks from tools/source_tree.py (each label's SECTION placed by src/layout.link),
so they hold for a hand-edited tree. Where an address is needed they use the .sym of a build of exactly this tree
(source_tree.fresh_sym) and skip when there is none. The generator's own checks (notes and names copied from
config/ into its listing) are in tests/test_generator_listing.py.
"""
import json
import re
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import source_tree  # noqa: E402

SRC = ROOT / "src"
FILES = source_tree.bank_files()
HEX = re.compile(r"\$([0-9a-fA-F]+)")
LB = re.compile(r"^lb (hl|de|bc), \$([0-9a-fA-F]{2}), \$([0-9a-fA-F]{2})$")


def bank_file(bank: int) -> Path:
    return next(SRC.glob(f"*/bank{bank:02x}_*.asm"))


def text_of(bank: int) -> str:
    return bank_file(bank).read_text(encoding="utf-8")


def all_text() -> str:
    return "".join(f.read_text(encoding="utf-8") for f in FILES)


def code_of(line: str) -> str:
    """The instruction of a source line in the listing's spelling: comment dropped, hex in capitals, and the
    `lb rr, $hi, $lo` macro written as the `ld rr, $hilo` it assembles to."""
    code = HEX.sub(lambda m: "$" + m.group(1).upper(), line.split(";")[0].strip())
    if m := LB.match(code.lower()):
        code = f"ld {m.group(1)}, ${m.group(2).upper()}{m.group(3).upper()}"
    return code


def field_message_targets(text: str) -> set[str]:
    """E-0357/E-0358: recognize message-word consumers from instructions, not names or quotes."""
    heads = list(re.finditer(r"^(\w+)::(?! ; address name)[^\n]*\n", text, re.M))
    targets = set()
    for i, head in enumerate(heads):
        end = heads[i + 1].start() if i + 1 < len(heads) else len(text)
        body = [code_of(ln) for ln in text[head.end():end].splitlines() if ln.startswith('    ')]
        front = body[:4]
        direct = front == ['ld a, l', 'ld [wMessageIndex], a', 'ld a, h', 'ld [wMessageGroup], a']
        command = (front == ['ld a, l', 'ld [wScriptParam0], a', 'ld a, h', 'ld [wScriptParam1], a']
                   and 'ld a, $09\nld [wScriptCommandType], a' in '\n'.join(body))
        joined = '\n'.join(body)
        display = (('ld a, h\nand a, $3F\nld h, a' in joined or 'ld a, h\nand $3F\nld h, a' in joined)
                   and 'ld a, l\nld [wStringIndex], a' in joined)
        if direct or command or display:
            targets.add(head.group(1))
    return targets


def field_message_argument(lines: list[str], n: int, targets: set[str]) -> bool:
    """A numeric HL value goes straight to a proven message-word consumer; n is one-based."""
    if not re.fullmatch(r'ld hl, \$[0-9A-F]{4}', code_of(lines[n - 1])):
        return False
    for ln in lines[n:]:
        code = code_of(ln)
        if not code or re.fullmatch(r'[.\w]+::?', code) or code.startswith("ASSERT"):
            continue
        m = re.fullmatch(r'(?:call|jp)(?: (?:nz|z|nc|c),)? (\w+)', code)
        return bool(m and m.group(1) in targets)
    return False


class Helpers(unittest.TestCase):
    def test_code_of_matches_the_listing_spelling(self):
        self.assertEqual(code_of("    ld hl, $c48a ; note"), "ld hl, $C48A")
        self.assertEqual(code_of("    lb hl, $b5, $8e"), "ld hl, $B58E")
        self.assertEqual(code_of("    ld a, [wFoo + $1f]"), "ld a, [wFoo + $1F]")

    def test_flags_are_values_when_the_callee_copies_hl_to_message_fields(self):
        text = ('Message::\n'
                '    ld a, l\n    ld [wMessageIndex], a\n    ld a, h\n    ld [wMessageGroup], a\n    ret\n')
        targets = field_message_targets(text)
        self.assertEqual(targets, {'Message'})
        self.assertTrue(field_message_argument(['    ld hl, $c48a', '    call Message'], 1, targets))

    def test_a_quote_or_message_like_name_does_not_exempt_a_pointer_reader(self):
        targets = field_message_targets('StartMessageHL::\n    ld a, [hl]\n    ret\n')
        self.assertFalse(field_message_argument(["    ld hl, $c48a ; 'dialogue'", '    call StartMessageHL'],
                                               1, targets))

    def test_an_intervening_instruction_or_memory_operand_is_not_exempt(self):
        self.assertFalse(field_message_argument(['    ld hl, $c48a', '    inc hl', '    call Message'],
                                               1, {'Message'}))
        self.assertFalse(field_message_argument(['    ld a, [$c48a]', '    call Message'], 1, {'Message'}))

    def test_label_banks_follow_the_layout(self):
        """A section moved to another bank in src/layout.link moves its labels' bank with it."""
        import tempfile
        with tempfile.TemporaryDirectory() as t:
            src = Path(t) / "src"
            (src / "engine").mkdir(parents=True)
            (src / "engine/bank01_x.asm").write_text('SECTION "Bank 01", ROMX\nA::\n    ret\n'
                                                     'SECTION "Bank 01 B", ROMX\nB::\n    ret\n', encoding="utf-8")
            (src / "layout.link").write_text('ROMX $01\n\t"Bank 01"\nROMX $02\n\t"Bank 01 B"\n', encoding="utf-8")
            self.assertEqual(source_tree.label_banks(src), {"A": 1, "B": 2})

    def test_digest_sees_every_file_and_its_path(self):
        import tempfile
        with tempfile.TemporaryDirectory() as t:
            src = Path(t) / "src"
            src.mkdir()
            (src / "a.inc").write_text("DEF X EQU 1\n", encoding="utf-8")
            d0 = source_tree.digest(src)
            (src / "a.inc").write_text("DEF X EQU 2\n", encoding="utf-8")
            d1 = source_tree.digest(src)
            (src / "a.inc").rename(src / "b.inc")
            d2 = source_tree.digest(src)
            self.assertEqual(len({d0, d1, d2}), 3)

    def test_a_build_of_another_tree_is_not_fresh(self):
        import tempfile
        with tempfile.TemporaryDirectory() as t:
            root = Path(t)
            (root / "src").mkdir()
            (root / "src/main.asm").write_text("x\n", encoding="utf-8")
            run = root / "build/run1"
            run.mkdir(parents=True)
            (run / "dwm2.sym").write_text("01:4000 Foo\n", encoding="utf-8")
            (run / "report.json").write_text(json.dumps({"pass": True, "source_digest": "0" * 64}), encoding="utf-8")
            self.assertIsNone(source_tree.fresh_build(root))
            (run / "report.json").write_text(json.dumps({"pass": True, "source_digest": source_tree.digest(root / "src")}),
                                             encoding="utf-8")
            self.assertEqual(source_tree.fresh_build(root), run)
            self.assertEqual(source_tree.fresh_sym(root), {"Foo": (1, 0x4000)})
            (run / "report.json").write_text(json.dumps({"pass": False, "source_digest": source_tree.digest(root / "src")}),
                                             encoding="utf-8")
            self.assertIsNone(source_tree.fresh_build(root))  # a failed build is not used


@unittest.skipUnless(FILES, "src/ has no bank files")
class BankedCalls(unittest.TestCase):
    def test_banked_calls_use_the_farcall_macros(self):
        """A banked call is `ld hl, ADDR / ld b, BANK / rst $10`; `farcall L` writes ld b, BANK(L), so its bank is
        right by construction. A bare `rst $10` is left only where HL and B are computed (a pointer read from
        memory or registers), which no macro spells; one with a literal label and bank should be a farcall."""
        macros, literal, computed = 0, [], 0
        for f in FILES:
            lines = f.read_text(encoding="utf-8").splitlines()
            for i, ln in enumerate(lines):
                code = code_of(ln)
                macros += code.startswith(("farcall ", "farcall_b "))
                if code not in ("rst $10", "call $0010"):
                    continue
                hl = b = False
                for back in lines[max(0, i - 8):i][::-1]:
                    c = code_of(back)
                    if re.match(r"(ret|reti|jp|jr)\b", c) or re.match(r"[A-Za-z_]\w*::", back):
                        break
                    hl |= bool(re.fullmatch(r"ld hl, [A-Za-z_][\w.]*", c))
                    b |= bool(re.fullmatch(r"ld b, (\$[0-9A-F]{2}|BANK\(\w+\))", c))
                if hl and b:
                    literal.append(f"{f.name}:{i + 1}")
                else:
                    computed += 1
        self.assertGreater(macros, 3000, "banked calls should be written with the farcall macros")
        self.assertEqual(literal, [])
        self.assertLessEqual(computed, 3)  # bank $30, $E0 and $10 on 2026-10-17 (E-0403)

    def test_pointer_labels_in_a_call_setup_agree_with_ld_b(self):
        """For every call to a routine that takes a bank in B and a pointer in HL/DE/BC, a pointer spelled as a
        label in the same straight-line setup must be in that bank."""
        helpers = ("CopyFromBank", "OrFromBank", "DecompressTo", "ReadByteInBank")
        banks = source_tree.label_banks()
        names = [n for n in banks if n.startswith(helpers)]
        self.assertTrue(names)
        call = re.compile(r"call (" + "|".join(map(re.escape, names)) + r")$")
        bank_of = {k: v for k, v in banks.items() if v}
        ld_ptr = re.compile(r"ld (?:hl|de|bc), ([A-Za-z_]\w*)$")
        ld_b = re.compile(r"ld b, (?:\$([0-9A-F]{2})|BANK\(([A-Za-z_]\w*)\))$")
        barrier = re.compile(r"(\S+::|(?:call|ret|reti|jp|jr|farcall|farcall_b|rst|add_a_to_hl)\b)")
        checked, wrong = 0, []
        for f in FILES:
            lines = f.read_text(encoding="utf-8").splitlines()
            for i, line in enumerate(lines):
                if not call.match(code_of(line)):
                    continue
                bnk, ptrs, b_seen = None, [], False
                for back in lines[max(0, i - 12):i][::-1]:
                    code = code_of(back)
                    if back.startswith(";") or not code or code.startswith("ASSERT"):
                        continue
                    if barrier.match(back.strip()) or barrier.match(code):
                        break
                    if not b_seen and (code.startswith("ld b,") or code.startswith("lb bc,")):
                        b_seen = True  # the nearest write to B decides; a non-literal one means no bank
                        bnk = ld_b.match(code)
                    m = ld_ptr.match(code)
                    if m and m.group(1) in bank_of:
                        ptrs.append(m.group(1))
                if bnk and ptrs and (bnk.group(1) or bnk.group(2) in bank_of):
                    want = int(bnk.group(1), 16) if bnk.group(1) else bank_of[bnk.group(2)]
                    for lab in ptrs:
                        checked += 1
                        if bank_of[lab] != want:
                            wrong.append(f"{f.name}:{i + 1} {lab} with ld b,{bnk.group(1) or bnk.group(2)}")
        self.assertGreater(checked, 100)
        self.assertEqual(wrong[:5], [], f"{len(wrong)} of {checked} pointer labels disagree with ld b")


@unittest.skipUnless(FILES, "src/ has no bank files")
class SymbolicOperands(unittest.TestCase):
    """Instruction operands name hardware and RAM instead of repeating addresses."""

    MEM = re.compile(r"\[\$([0-9A-F]{4})\]")
    IMM = re.compile(r"^ld (?:hl|de|bc|sp), \$([0-9A-F]{4})$")

    def test_no_instruction_uses_a_raw_hardware_or_ram_address(self):
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
                if re.fullmatch(r"[.\w]+::?", line):
                    last.append(line.rstrip(":"))  # a global or a local label (E-0287)
                    continue
                code = code_of(line)
                if code == "ld a, l" and i + 1 < len(lines) and code_of(lines[i + 1]) == "ld [wResolveMsgActor], a":
                    found.update(last)
                if code and code not in ("xor a, a", "xor a", "ld [wBattleDamageLo], a", "ld [wBattleDamageHi], a"):
                    last = []
            jumps = re.compile(r"^([.\w]+)::?\n    j[pr] ([.\w]+)$", re.M)
            return found | {a for a, t in jumps.findall("\n".join(lines)) if t in found}

        def message_argument(lines: list[str], n: int, entries: set[str]) -> bool:
            """Line n (1-based) loads HL/BC in a pair that goes into a message routine."""
            pair = re.compile(r"ld (hl|bc|l), \$")
            code = lambda k: code_of(lines[k]) if 0 <= k < len(lines) else ""
            for first in (n - 1, n - 2):
                if pair.match(code(first)) and pair.match(code(first + 1)):
                    k = first + 2
                    while k < len(lines) and (not lines[k].strip() or lines[k].startswith(";")):
                        k += 1  # a label the pair falls into follows a blank line and its note
                    after = lines[k] if k < len(lines) else ""
                    m = re.match(r"\s+(?:jp|jr|call) ([.\w]+)$", after) or re.match(r"([.\w]+)::?$", after)
                    if m and m.group(1) in entries:
                        return True
            return False

        bad, checked, symbolic = [], 0, 0
        field_targets = field_message_targets(all_text())
        sym = re.compile(r"\[[whrsv][A-Za-z0-9_]+( \+ \$[0-9A-F]+)?\]|BANK_NUMBER_BYTE|, [whrsv][A-Z][A-Za-z0-9_]*( \+ \$[0-9A-F]+)?$")
        data = ("db", "dw", "ds", "dfar", "INCBIN", "ASSERT")
        for f in FILES:
            lines = f.read_text(encoding="utf-8").splitlines()
            entries = message_entries(lines)
            for n, line in enumerate(lines, 1):
                if not line.startswith("    ") or line.lstrip().startswith(data):
                    continue
                code = code_of(line)
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
                    ahead = [code_of(l) for l in lines[n:n + 2]]
                    if reg in ("bc", "de") and int(m.group(1), 16) >= 0xFF00 and f"add hl, {reg}" in ahead:
                        continue  # a small negative number added to HL, not an address
                    if int(m.group(1), 16) == 0xFFFF:
                        continue  # -1 as a 16-bit number, not the interrupt-enable register
                    nxt = [code_of(l) for l in lines[n:n + 6] if l.startswith("    ")][:2]
                    low = {"hl": "l", "de": "e", "bc": "c"}.get(reg)
                    if (int(m.group(1), 16) >= 0xFF00 and len(nxt) == 2 and nxt[0] == f"ld a, {low}"
                            and re.search(r"\[(hPlayerStepD[XY]Lo|hFF9[BD])\]", nxt[1])):
                        continue  # a step delta stored in the player movement bytes (E-0132)
                    if message_argument(lines, n, entries):
                        continue  # battle message bytes in HL/BC (E-0137)
                    if field_message_argument(lines, n, field_targets):
                        continue  # field message word, including keep-open/already-open flag bits (E-0357)
                    if reg == "de" and any(re.match(r"call StepSpriteSlotToward", x) for x in nxt):
                        continue  # a (y, x) sprite position (E-0137)
                    if forbidden(int(m.group(1), 16), True):
                        bad.append(f"{f.name}:{n} {code}")
        self.assertGreater(symbolic, 10000, "expected the source to use many symbolic operands")
        self.assertGreater(checked, 1000)
        self.assertEqual(bad[:5], [], f"{len(bad)} operands still use a raw hardware/RAM address")

    def test_includes_define_every_symbol_the_banks_use(self):
        main = (SRC / "main.asm").read_text(encoding="utf-8").splitlines()
        self.assertEqual(main[:3], ['INCLUDE "hardware.inc"', 'INCLUDE "ram.asm"', 'INCLUDE "macros.inc"'])


@unittest.skipUnless(FILES, "src/ has no bank files")
class Streams(unittest.TestCase):
    @staticmethod
    def is_stream(rom: bytes, sym: dict, label: str) -> bool:
        """The bytes at the label decode as an LZSS stream (tools/lzss_gfx.py) of at most 4,096 bytes (the format's
        limit, docs/ASSETS.md) that never reads an unwritten byte and ends at or before the next label. On
        2026-10-17 all 126 decompress arguments pass and 6 of 400 code labels in banks $0A, $10, $12 and $36 do."""
        import lzss_gfx
        bank, addr = sym[label]
        nxt = min((a for b, a in sym.values() if b == bank and a > addr), default=0x8000)
        out, used, ev = lzss_gfx.decompress(rom, bank, addr)
        return len(out) <= 0x1000 and not ev["unwritten_reads"] and addr + used <= nxt

    def test_literal_decompress_arguments_name_a_stream(self):
        """`ld de, X` before a DecompressTo call names a stream in the ROM built from this src/ (is_stream).
        Most such labels are an asset file (INCBIN "*.lz"); short streams are kept as db bytes."""
        sym = source_tree.fresh_sym()
        if sym is None:
            self.skipTest("no build of this src/ (python -I tools/build.py --out build/runN)")
        rom = (source_tree.fresh_build() / "dwm2.gbc").read_bytes()
        self.assertFalse(self.is_stream(rom, sym, next(n for n in sym if n.startswith("DecompressTo"))))
        sites, files, bad = 0, 0, []
        for f in FILES:
            lines = f.read_text(encoding="utf-8").splitlines()
            for i, l in enumerate(lines):
                if not re.match(r"call DecompressTo", code_of(l)):
                    continue
                for back in lines[max(0, i - 4):i][::-1]:
                    m = re.match(r"ld de, ([A-Za-z_]\w*)$", code_of(back))
                    if m:
                        sites += 1
                        if not self.is_stream(rom, sym, m.group(1)):
                            bad.append(f"{f.name}:{i + 1} {m.group(1)}")
                        break
        for f in FILES:
            files += len(re.findall(r'^\s+INCBIN "[^"]+\.lz"', f.read_text(encoding="utf-8"), re.M))
        self.assertGreater(files, 1000)
        self.assertGreater(sites, 100)
        self.assertEqual(bad, [])


@unittest.skipUnless(FILES, "src/ has no bank files")
class Spellings(unittest.TestCase):
    """Things the source keeps written by name or as a number (E-0123 to E-0364)."""

    def test_a_renamed_routine_is_used_by_its_callers(self):
        text = all_text()
        self.assertGreater(text.count("call FillBytes"), 20)
        self.assertNotIn("Func_000_0949", text)

    def test_table_in_a_case_belongs_to_the_case(self):
        """E-0123: a `jumptable` inside a named case names its targets after that case."""
        text = text_of(0x37)
        start = text.index("PartnerStats::")
        body = text[start:text.index("\n\n", start)]
        self.assertIn("    jumptable\n", body)
        self.assertRegex(body, r"dw PartnerStats_\w+")

    def test_called_routine_after_a_table_is_code(self):
        """E-0126: the routine at 12:$55F8, right after an inline table, is decoded as code."""
        sym = source_tree.fresh_sym()
        if sym is None:
            self.skipTest("no build of this src/ (python -I tools/build.py --out build/runN)")
        name = next(n for n, (b, a) in sym.items() if (b, a) == (0x12, 0x55F8) and "." not in n)
        text = text_of(0x12)
        body = text[text.index(f"{name}::"):][:300]
        self.assertRegex(body, r"\n    ld a, \[w\w+\]\n    bit 7, a")
        self.assertNotIn("dw $44fa", text.lower())

    def test_message_argument_pairs_are_numeric(self):
        """E-0137: battle message bytes stay numbers, not RAM or VRAM names."""
        text = text_of(0x36)
        self.assertIn("    lb hl, $b5, $8e\n    lb bc, $80, $a8\n    jp StoreResolveMessage_Bank36", text)
        self.assertNotIn("sB58E", text)
        self.assertNotRegex(text, r"ld bc, vTiles[01] \+ \$a8")

    def test_sprite_step_positions_are_numeric(self):
        text = text_of(0xE0)
        self.assertRegex(text, r"(?i)(ld de, \$a070|lb de, \$a0, \$70)")
        self.assertNotIn("sA070", text)

    def test_picture_table_uses_monster_names(self):
        """E-0138."""
        text = text_of(0x38)
        self.assertIn("    dfar MonsterPic_SpotSlime ; id 2 SpotSlime", text)
        self.assertIn("    dfar MonsterPicAttr_", text)
        self.assertIn("MonsterSprite_DrakSlime::", text_of(0x20))

    def test_map_record_uses_far_pointers(self):
        """E-0142."""
        self.assertRegex(text_of(0x11), r"MapRecord1D::\n(?:.*\n){1,6}    dfar Map1DScreens0( ;[^\n]*)?\n    dfar Map1DAttrs0( ;[^\n]*)?\n")

    def test_breeding_tables_name_species_and_codes(self):
        """E-0199: breeding rule lists show partners and rule codes."""
        text = text_of(0x0E)
        self.assertIn("    dw $fe04 ; id 0 same species, parent B +4 or more\n", text)
        self.assertIn("FamilyPairResults000::\n    dw $ffff ; id 0 parent A's species\n    dw MONSTER_DRAKSLIME\n", text)

    def test_fill_tile_callers_use_the_callee_bank(self):
        """E-0186: wArg1/wArg2 sources of far calls take the called routine's bank."""
        text = all_text()
        self.assertEqual(text.count("    ld de, BGFillTile\n"), 10)

    def test_world_map_screen_cells_fill_bank_5d(self):
        """E-0185."""
        self.assertRegex(text_of(0xA1), r"    db \$88 ; id 0[^\n]*\n    dfar WorldMapScreenCells0( ;[^\n]*)?\n")
        text = text_of(0x5D)
        self.assertEqual(text.count("INCBIN"), 2)
        self.assertIn("WorldMapScreenCells10::\n", text)

    def test_meta_sprite_frames_end_with_80(self):
        text = text_of(0x25)
        frame = text[text.index("MetaSprites25Set02Frame0::"):]
        self.assertRegex(frame, r"^MetaSprites25Set02Frame0::\n(    db \$[0-9a-f]{2}, \$[0-9a-f]{2}, \$[0-9a-f]{2}, \$[0-9a-f]{2}( ; entry \d+)?\n)+    db \$80 ; end\n")

    def test_key_world_chunks_skip_the_screen_header(self):
        self.assertIn("KeyWorldChunkGroup00::", text_of(0x67))

    def test_script_uses_macros_and_labels(self):
        """E-0152, E-0344."""
        text = text_of(0x10)
        target = re.search(r"^    script_skip_if_no (Script_\w+)\n", text, re.M)
        self.assertIsNotNone(target)
        self.assertRegex(text, rf"(?m)^{target.group(1)}::")
        self.assertGreater(text.count("    script_end\n"), 100)

    def test_callers_name_their_script(self):
        """E-0342: callers load the script by name and quote its first message."""
        calls = re.findall(r"    ld hl, (Script_\w+)( ; script '[^'\n]+')?\n(?:    ASSERT [^\n]*\n)?    call StartScriptAtHL_B13\n",
                           text_of(0x13))
        self.assertGreater(len(calls), 50)
        self.assertGreater(sum(1 for _, quote in calls if quote), 50)

    def test_choice_jump_takes_one_offset_per_option(self):
        """E-0188: $E4 has as many offsets as menu options; the first target follows them."""
        self.assertRegex(text_of(0x10), r"    script_choice_jump (?:Script_\w+, )+(Script_\w+)\n\1::")
        macros = (SRC / "macros.inc").read_text(encoding="utf-8")
        self.assertIn("    REPT _NARG\n", macros[macros.index("MACRO script_choice_jump"):])

    def test_data_bank_jumps_name_their_target(self):
        """E-0184."""
        text = all_text()
        self.assertNotIn("data bank not known here", text)
        targets = re.findall(r"^    script_jump_data_bank (\w+)\n", text, re.M)
        self.assertTrue(targets)
        for t in set(targets):
            self.assertRegex(text, rf"(?m)^{t}::")

    def test_record_byte_pair_after_a_record_load_is_not_the_attribute_buffer(self):
        """E-0357: $D000 read just before $D001 is byte $12 of the record at wRecordBufferData (WRAM bank 1)."""
        pairs = 0
        for p in FILES:
            code = [code_of(line) for line in p.read_text(encoding="utf-8").splitlines()]
            for i, line in enumerate(code):
                if "[wRecordBufferData + $13]" in "".join(code[i + 1:i + 3]):
                    self.assertNotIn("[wScreenAttrBuffer]", line, f"{p.name}:{i + 1}")
                    pairs += "[wRecordBufferData + $12]" in line
        self.assertGreaterEqual(pairs, 7)

    def test_traveler_event_lines_come_from_bank09_category5(self):
        """E-0364."""
        text = text_of(0x73)
        self.assertIn("ld hl, $0044 ; '*: Lucky, kid! You've won 500G!'", text)
        self.assertIn("Welcome aboard the casino ship!", text)
        self.assertNotIn("Go help your mother", text)
        self.assertIn("TravelerEvents_CasinoShip::", text)

    def test_bank2_attribute_addresses_use_the_attribute_buffer(self):
        """E-0136: an "of" symbol is written as an offset into the buffer it names."""
        symbols = json.loads((ROOT / "config/symbols.json").read_text(encoding="utf-8"))
        aliases = {k: v for k, v in symbols.items() if isinstance(v, dict) and "of" in v}
        self.assertIn("D1CC", aliases)
        text = "\n".join(code_of(line) for p in FILES for line in p.read_text(encoding="utf-8").splitlines())
        for key, info in aliases.items():
            base = symbols[info["of"]]["name"]
            self.assertNotRegex(text, rf"\bw{key}\b")
            self.assertIn(f"{base} + ${int(key, 16) - int(info['of'], 16):X}", text)


if __name__ == "__main__":
    unittest.main()
