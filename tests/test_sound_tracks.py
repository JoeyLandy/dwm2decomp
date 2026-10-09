"""Tests for tools/sound_tracks.py: synthetic cases for each event class and ROM-level alignment."""
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import sound_tracks as st  # noqa: E402

HEADER = bytes([0x06, 0x00, 0x0D, 0x00])


def region(*events: bytes) -> bytes:
    return HEADER + b"".join(events)


class Events(unittest.TestCase):
    def test_note_octave_and_semitone(self):
        ev, used = st.decode_event(bytes([0x2A, 0x12]), 0)
        self.assertEqual((ev["kind"], ev["text"], used), ("note", "note A#2 dur 18", 2))

    def test_low_nibble_c_or_above_is_a_rest(self):
        ev, _ = st.decode_event(bytes([0x3C, 0x08]), 0)
        self.assertEqual(ev["mnemonic"], "rest")

    def test_label_repeat_and_jump(self):
        self.assertEqual(st.decode_event(bytes([0xFD, 0xF0]), 0)[0]["kind"], "label")
        self.assertEqual(st.decode_event(bytes([0xB3, 0xF0]), 0)[0]["kind"], "repeat")
        self.assertEqual(st.decode_event(bytes([0xB0, 0xF0]), 0)[0]["kind"], "jump")

    def test_call_consumes_a_second_event_as_a_byte_offset(self):
        ev, used = st.decode_event(bytes([0xAC, 0x02, 0x3C, 0x0A]), 0)
        self.assertEqual((ev["kind"], used, ev["target"]), ("call", 4, 0x0A3C))

    def test_end_may_lack_its_operand(self):
        ev, used = st.decode_event(bytes([0xFF]), 0)
        self.assertEqual((ev["kind"], used, ev["b1"]), ("end", 1, None))

    def test_command_ranges(self):
        self.assertEqual(st.classify(0xC5)[1], "env")
        self.assertEqual(st.classify(0xD3)[1], "step+")
        self.assertEqual(st.classify(0xE3)[1], "step-")
        self.assertEqual(st.classify(0xF7)[0], "skip")
        self.assertEqual(st.classify(0xA4)[0], "skip")


class Regions(unittest.TestCase):
    def test_header_fields(self):
        h = st.decode_header(HEADER, 0)
        self.assertEqual((h["param"], h["volume_nibble"], h["volume_swapped"]), (6, 13, 0xD0))

    def test_region_with_terminator_decodes(self):
        data = region(bytes([0xA0, 0x0C]), bytes([0x2A, 0x06]), bytes([0xFF, 0x00]))
        evs = st.decode_region(data, 0, len(data))
        self.assertEqual([e["kind"] for e in evs], ["set", "note", "end"])

    def test_lone_final_ff_is_accepted(self):
        data = region(bytes([0x2A, 0x06]), bytes([0xFF]))
        evs = st.decode_region(data, 0, len(data))
        self.assertIsNone(evs[-1]["b1"])

    def test_misaligned_region_is_rejected(self):
        data = region(bytes([0xAC, 0x02, 0x3C]))  # call target cut short
        self.assertIsNone(st.decode_region(data, 0, len(data)))

    def test_section_after_a_mid_track_end_is_decoded(self):
        data = region(bytes([0xFF, 0xFF]), bytes([0xFD, 0xF0]), bytes([0x2A, 0x06]), bytes([0xFF, 0x00]))
        self.assertEqual(len(st.decode_region(data, 0, len(data))), 4)


REF = ROOT / "local" / "roms" / "dwm2-cobi-us.gbc"


@unittest.skipUnless(REF.exists(), "reference ROM not present")
class RealTracks(unittest.TestCase):
    def test_every_track_between_two_pointers_decodes_to_the_next_boundary(self):
        rom = REF.read_bytes()
        decoded = 0
        for bank, n in ((0x40, 28), (0x41, 21), (0x42, 119), (0x43, 55)):
            bd = rom[bank * 0x4000:(bank + 1) * 0x4000]
            ptrs = sorted({bd[1 + 4 * i + 2] | (bd[1 + 4 * i + 3] << 8) for i in range(n)})
            for p, nxt in zip(ptrs, ptrs[1:]):
                evs = st.decode_region(bd, p - 0x4000, nxt - 0x4000)
                self.assertIsNotNone(evs, f"{bank:02X}:{p:04X}")
                decoded += 1
        self.assertGreater(decoded, 200)

    def test_first_track_of_bank_40_starts_like_the_runtime_trace(self):
        rom = REF.read_bytes()
        bd = rom[0x40 * 0x4000:0x41 * 0x4000]
        evs, end = st.decode_track(bd, 0x4077 - 0x4000, 0x4000)
        self.assertEqual(st.decode_header(bd, 0x4077 - 0x4000)["volume_nibble"], 13)
        self.assertEqual(evs[0]["text"], "param $04")
        self.assertEqual(0x4000 + end, 0x42F3)  # exactly the next track in the record array


if __name__ == "__main__":
    unittest.main()
