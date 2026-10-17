"""tools/leftover_code.py: trial decoding of the bytes after a routine's end (E-0395, M4)."""
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import leftover_code  # noqa: E402


def rom_with(bank: int, addr: int, data: bytes) -> bytes:
    rom = bytearray(0x4000 * (bank + 1))
    off = bank * 0x4000 + addr - (0 if bank == 0 else 0x4000)
    rom[off:off + len(data)] = data
    return bytes(rom)


class Trial(unittest.TestCase):
    def check(self, data, labels=(), bank=5, addr=0x4100):
        rom = rom_with(bank, addr, data)
        return leftover_code.trial(rom, bank, addr, addr + len(data), set(labels))

    def test_a_call_to_a_known_label_then_ret_is_code(self):
        r = self.check(bytes([0xCD, 0x00, 0x02, 0xC9]), labels={(0, 0x0200)})  # call $0200; ret
        self.assertEqual(r["verdict"], "code")
        self.assertEqual(r["end"], 0x4104)

    def test_an_unknown_target_is_only_code_question(self):
        self.assertEqual(self.check(bytes([0xCD, 0x00, 0x02, 0xC9]))["verdict"], "code?")

    def test_a_jump_inside_the_gap_counts_as_known(self):
        r = self.check(bytes([0x3E, 0x01, 0x18, 0xFC]))  # ld a, 1; jr back to the start
        self.assertEqual(r["verdict"], "code")

    def test_fill_invalid_and_open(self):
        self.assertEqual(self.check(bytes(8))["verdict"], "fill")
        self.assertEqual(self.check(bytes([0x3E, 0x01, 0xD3, 0xC9]))["verdict"], "not code")  # $D3 is invalid
        self.assertEqual(self.check(bytes([0x3E, 0x01, 0x3C, 0x3C]))["verdict"], "open")  # no end
        self.assertEqual(self.check(bytes([0x3E, 0x01, 0xCD]))["verdict"], "not code")  # a call cut by the gap end

    def test_a_conditional_return_is_not_an_end(self):
        self.assertEqual(self.check(bytes([0xC8, 0x3C]))["verdict"], "open")  # ret z; inc a
        self.assertTrue(leftover_code.is_end("ret", "ret"))
        self.assertFalse(leftover_code.is_end("ret z", "retc"))
        self.assertTrue(leftover_code.is_end("jr {T}", "jr"))
        self.assertFalse(leftover_code.is_end("jr nz, {T}", "jrc"))


if __name__ == "__main__":
    unittest.main()
