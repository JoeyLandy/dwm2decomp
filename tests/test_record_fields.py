"""Record field constants for the offset a record-access routine takes in C (tools/disasm_all.py, E-0290)."""
import json
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import disasm_all  # noqa: E402

FIELDS = {0x5B: {"const": "MON_HP", "size": 2}, 0x56: {"const": "MON_LEVEL"}}
CALLEES = {"SRAMRecordAddress", "LoadSRAMRecordByte"}


def run(text):
    (out,), n = disasm_all.name_record_offsets([text], FIELDS, CALLEES)
    return out, n


class RecordFields(unittest.TestCase):
    def test_offset_reaching_a_record_routine_is_named(self):
        out, n = run("    ld a, [wMenuSelectedMember]\n    ld c, $5B\n    call SRAMRecordAddress\n")
        self.assertEqual(n, 1)
        self.assertIn("    ld c, MON_HP\n", out)

    def test_instructions_that_keep_c_may_sit_between(self):
        out, n = run("    ld c, $56\n    ld a, [wTemp0]\n    ld hl, wPartyList\n    call LoadSRAMRecordByte\n")
        self.assertEqual(n, 1)

    def test_an_instruction_that_changes_c_blocks_it(self):
        text = "    ld c, $5B\n    inc c\n    call SRAMRecordAddress\n"
        self.assertEqual(run(text), (text, 0))

    def test_an_offset_inside_a_sized_field_is_field_plus_n(self):
        out, n = run("    ld c, $5C
    call SRAMRecordAddress
")
        self.assertEqual((out, n), ("    ld c, MON_HP + 1
    call SRAMRecordAddress
", 1))

    def test_other_callees_and_unknown_offsets_stay_numeric(self):
        for text in ("    ld c, $5B\n    call Multiply8\n", "    ld c, $57\n    call SRAMRecordAddress\n"):
            self.assertEqual(run(text), (text, 0))

    def test_config_offsets_and_names_are_unique_and_callees_are_real_routines(self):
        cfg = json.loads((ROOT / "config/record_fields.json").read_text(encoding="utf-8"))
        consts = [v["const"] for v in cfg["fields"].values()]
        self.assertEqual(len(consts), len(set(consts)))
        self.assertTrue(all(v.get("evidence") for v in cfg["fields"].values()))
        banks = ROOT / "src/banks"
        if banks.is_dir():
            text = "".join(f.read_text(encoding="utf-8") for f in banks.glob("bank*.asm"))
            missing = [c for c in cfg["callees"] if f"\n{c}::" not in text]
            self.assertEqual(missing, [])


if __name__ == "__main__":
    unittest.main()
