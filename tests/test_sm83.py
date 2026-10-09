"""Hand-computed instruction cases for tools/sm83.py (our own emulator; see its docstring)."""
import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "tools"))
from sm83 import GameBoy  # noqa: E402


def machine(code: bytes, at: int = 0x100) -> GameBoy:
    rom = bytearray(0x8000)
    rom[at:at + len(code)] = code
    g = GameBoy(bytes(rom))
    g.pc = at
    return g


def steps(g: GameBoy, n: int) -> GameBoy:
    for _ in range(n):
        g.step()
    return g


class Instructions(unittest.TestCase):
    def test_add_sets_carry_without_half_carry(self):
        g = steps(machine(bytes([0x3E, 0xF0, 0xC6, 0x20])), 2)  # ld a,$F0 ; add a,$20
        self.assertEqual((g.a, g.f), (0x10, 0x10))

    def test_add_sets_half_carry(self):
        g = steps(machine(bytes([0x3E, 0x0F, 0xC6, 0x01])), 2)  # ld a,$0F ; add a,$01
        self.assertEqual((g.a, g.f), (0x10, 0x20))

    def test_sub_sets_negative_and_half_borrow(self):
        g = steps(machine(bytes([0x3E, 0x10, 0xD6, 0x01])), 2)  # ld a,$10 ; sub $01
        self.assertEqual((g.a, g.f), (0x0F, 0x60))

    def test_xor_a_clears_a_and_sets_zero(self):
        g = steps(machine(bytes([0x3E, 0x55, 0xAF])), 2)
        self.assertEqual((g.a, g.f), (0, 0x80))

    def test_inc_memory_through_hl(self):
        g = steps(machine(bytes([0x21, 0x00, 0xC0, 0x36, 0xAB, 0x34])), 3)  # ld hl,$C000 ; ld [hl],$AB ; inc [hl]
        self.assertEqual(g.rb(0xC000), 0xAC)

    def test_push_pop_roundtrip(self):
        g = steps(machine(bytes([0x01, 0x34, 0x12, 0xC5, 0xD1])), 3)  # ld bc,$1234 ; push bc ; pop de
        self.assertEqual((g.d, g.e, g.sp), (0x12, 0x34, 0xFFFE))

    def test_call_and_ret(self):
        code = bytearray(0x20)
        code[0:3] = bytes([0xCD, 0x10, 0x01])  # call $0110
        code[3:5] = bytes([0x3E, 0x05])  # ld a,5
        code[0x10:0x13] = bytes([0x06, 0x07, 0xC9])  # ld b,7 ; ret
        g = steps(machine(bytes(code)), 4)
        self.assertEqual((g.b, g.a, g.pc), (7, 5, 0x105))

    def test_cb_swap_and_bit(self):
        g = steps(machine(bytes([0x3E, 0xA5, 0xCB, 0x37, 0xCB, 0x7F])), 3)  # swap a ; bit 7,a
        self.assertEqual(g.a, 0x5A)
        self.assertEqual(g.f & 0x80, 0x80)  # bit 7 of $5A is clear -> Z set

    def test_daa_after_add(self):
        g = steps(machine(bytes([0x3E, 0x09, 0xC6, 0x01, 0x27])), 3)  # 9 + 1 -> $0A ; daa -> $10
        self.assertEqual(g.a, 0x10)

    def test_16_bit_increment_wraps(self):
        g = steps(machine(bytes([0x21, 0xFF, 0xFF, 0x23])), 2)
        self.assertEqual((g.h, g.l), (0, 0))

    def test_mbc5_bank_switch_selects_rom_window(self):
        rom = bytearray(0x4000 * 4)
        rom[0x100:0x108] = bytes([0x3E, 0x03, 0xEA, 0x00, 0x21, 0xFA, 0x00, 0x40])  # ld a,3 ; ld [$2100],a ; ld a,[$4000]
        rom[0x4000 * 3] = 0x33
        g = GameBoy(bytes(rom))
        g.pc = 0x100
        steps(g, 3)
        self.assertEqual((g.rombank, g.a), (3, 0x33))

    def test_hram_and_wram_bank_register(self):
        g = machine(bytes([0x3E, 0x03, 0xE0, 0x70, 0x3E, 0x77, 0xEA, 0x00, 0xD0]))  # SVBK=3 ; ld [$D000],$77
        steps(g, 4)
        self.assertEqual(g.wram[3][0], 0x77)


if __name__ == "__main__":
    unittest.main()
