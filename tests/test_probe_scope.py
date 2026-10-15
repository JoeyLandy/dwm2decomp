"""tools/probe_scope.py: which routines a register-and-RAM probe can observe (D-012, E-0370)."""
import sys
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import probe_scope  # noqa: E402

LISTING = """SECTION "Bank 05", ROMX[$4000], BANK[$05]
Pure::
Func_005_4001:: ; address name
    ld a, [wTemp0]
    ret z
    inc a
    ld [wTemp0], a
    ret
UsesBankRegs::
    ld a, $0a
    ld [rRAMG], a
    ldh [rSVBK], a
    call Pure
    ret
Screen::
    ldh a, [rLCDC]
    ret
CallsScreen::
    call Pure
    jp Screen
FallsIntoScreen::
    ld a, $01
DrawsTiles::
    ld [vTiles0 + $100], a
    ret
Waits::
    halt
    ret
Computed::
    jp hl
Dispatch::
    ld a, [wTemp0]
    jumptable
    dw Pure
    dw UsesBankRegs
Table::
    db $01, $02
"""


class Scope(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        with tempfile.TemporaryDirectory() as d:
            (Path(d) / "bank05.asm").write_text(LISTING, encoding="utf-8")
            cls.rs = probe_scope.routines(Path(d))
        cls.cls = probe_scope.classify(cls.rs)

    def test_ram_only_routines_and_bank_registers_are_probeable(self):
        self.assertEqual(self.cls["Pure"], "probe")
        self.assertEqual(self.cls["UsesBankRegs"], "probe")
        self.assertEqual(self.cls["Dispatch"], "probe")  # a jumptable's entries are its callees

    def test_hardware_reaches_callers_and_fall_through(self):
        self.assertEqual(self.cls["Screen"], "hardware")
        self.assertEqual(self.cls["CallsScreen"], "hardware")
        self.assertEqual(self.cls["FallsIntoScreen"], "hardware")  # runs on into DrawsTiles
        self.assertEqual(self.cls["DrawsTiles"], "hardware")

    def test_interrupts_and_computed_jumps(self):
        self.assertEqual(self.cls["Waits"], "interrupts")
        self.assertEqual(self.cls["Computed"], "unresolved")

    def test_a_conditional_return_does_not_end_a_routine(self):
        self.assertFalse(self.rs["Pure"]["calls"])  # `ret z` runs on; its last instruction, `ret`, ends it
        self.assertIn("DrawsTiles", self.rs["FallsIntoScreen"]["calls"])

    def test_data_is_not_classified(self):
        self.assertNotIn("Table", self.cls)


if __name__ == "__main__":
    unittest.main()
