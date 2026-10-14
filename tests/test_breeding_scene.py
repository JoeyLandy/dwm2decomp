"""E-0360: link/breeding presentation probes on the original ROM in tools/sm83.py.

Direct calls use disabled interrupts and WRAM bank 1. They do not establish link
protocol behavior, a full breeding playthrough, or independent hardware timing.
"""
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'tests'))
sys.path.insert(0, str(ROOT / 'tools'))
from test_routine_behaviour import ROM, call  # noqa: E402
import gb_text  # noqa: E402
import lzss_gfx  # noqa: E402

PARAM, PARAM1, STEP, INDEX, GROUP, STATE = range(0xC921, 0xC927)
SLOTS, OBJ1, OBJ2, OBJ5 = 0xCB7F, 0xCB8F, 0xCB9F, 0xCBCF
SAVED, VALID, CHILD, CLIP = 0xC937, 0xC936, 0xCAD0, 0xFFB9
OBJ_PALETTES = 0xC4DF
MAP, MAP_X, MAP_Y, DEST_X, DEST_Y = 0xFF90, 0xFF8F, 0xFF92, 0xC8C8, 0xC8C9
TALK_INDEX, TALK_GROUP = 0xC917, 0xC916
RETURN = {0xC91C: 0x2A, 0xC91D: 0x67, 0xC91E: 0x45}


@unittest.skipUnless(ROM.is_file(), 'reference ROM not present')
class BreedingScene(unittest.TestCase):
    def test_parent_movement_is_gated_by_wrapping_counter_low_two_bits(self):
        for addr, obj, direction, x, target in ((0x4D15, OBJ1, 3, 0x49, 0x48),
                                               (0x4CDF, OBJ2, 1, 0x57, 0x58)):
            for phase in (0, 2, 3, 255):
                gb = call(0x12, addr, mem={PARAM: phase, STEP: 4, obj + 11: x})
                moved = phase in (3, 255)
                self.assertEqual(gb.rb(obj + 11), target if moved else x)
                self.assertEqual(gb.rb(obj + 7), 0 if moved else direction)
                self.assertEqual((gb.rb(PARAM), gb.rb(STEP)),
                                 (0, 5) if moved else (phase + 1, 4))

    def test_reveal_timers_and_slot_zero_walk_use_exact_equality(self):
        for addr, obj in ((0x4D46, OBJ1), (0x4D05, OBJ2)):
            for phase in (58, 59, 60, 255):
                gb = call(0x12, addr, mem={PARAM: phase, STEP: 2, obj + 12: 0xE0})
                finished = phase == 59
                self.assertEqual(gb.rb(obj + 12), 0x40 if finished else 0xE0)
                self.assertEqual((gb.rb(PARAM), gb.rb(STEP)),
                                 (0, 3) if finished else ((phase + 1) & 255, 2))
        for addr, y, expected_y in ((0x4D56, 0x59, 0x58), (0x4D56, 0, 255),
                                    (0x4CBC, 0xC7, 0xC8), (0x4CBC, 255, 0)):
            gb = call(0x12, addr, mem={STEP: 10, SLOTS + 12: y, SLOTS + 13: 0x24})
            self.assertEqual(gb.rb(SLOTS + 12), expected_y)
            arrived = expected_y in (0x58, 0xC8)
            self.assertEqual(gb.rb(STEP), 11 if arrived else 10)
            if addr == 0x4D56 and arrived:
                self.assertEqual(gb.rb(SLOTS + 13), 0x20)
            if addr == 0x4CBC and arrived:
                self.assertEqual((gb.rb(OBJ1 + 7), gb.rb(OBJ2 + 7)), (1, 3))

    def test_npc_return_selector_covers_all_ten_maps_and_screens(self):
        for selector, map_id in enumerate((4, 0x17, 4, 0x17, 4, 0x17, 0x17, 0x17, 4, 4)):
            gb = call(0x12, 0x49C8, mem={0xD7FB: selector, STEP: 23, PARAM: 9})
            x = 0 if selector in (1, 3, 5, 6, 7) else 2
            self.assertEqual(tuple(gb.rb(a) for a in (MAP, MAP_X, MAP_Y, DEST_X, DEST_Y)),
                             (map_id, x, 0, 0x40, 0x40))
            self.assertEqual((gb.rb(VALID), gb.rb(STEP), gb.rb(PARAM), gb.rb(0xC5DC)), (1, 24, 0, 4))
            self.assertEqual(gb.rombank, 0x12)

    def test_child_name_plus_digits_and_zero_branch_clipping_difference(self):
        name = bytes(gb_text.CHARMAP[c] for c in 'Dracky') + b'\xF0'
        for plus in (0, 5, 10, 99, 100, 255):
            mem = {CHILD + 11: 0x73, CHILD + 12: 0, CHILD + 0x6D: plus,
                   CLIP: 2, PARAM: 7, STEP: 25, GROUP: 0xC4, 0xC150: 0xA5}
            mem.update({0xC17E + i: 0xA5 for i in range(3)})
            gb = call(0x12, 0x4B19, mem=mem)
            self.assertEqual(bytes(gb.rb(0xC151 + i) for i in range(len(name))), name)
            self.assertEqual(gb.rb(0xC150), 0xA5)
            self.assertEqual((gb.rb(STEP), gb.rb(GROUP), gb.rb(STATE)), (26, 0xC4, 0))
            if plus:
                digits = ([plus // 10] if plus >= 10 else []) + [plus % 10, 0xF0]
                self.assertEqual([gb.rb(0xC17E + i) for i in range(len(digits))], digits)
                self.assertEqual((gb.rb(INDEX), gb.rb(CLIP), gb.rb(PARAM)), (0x18, 0, 2))
            else:
                self.assertEqual([gb.rb(0xC17E + i) for i in range(3)], [0xA5] * 3)
                self.assertEqual((gb.rb(INDEX), gb.rb(CLIP), gb.rb(PARAM)), (0x17, 2, 7))
            # The closing stage always copies the parameter, even when the zero
            # branch did not save clipping there. This is a deliberately stale input.
            closed = call(0x12, 0x4B0A, mem={STATE: 0xFF, STEP: 26, CLIP: gb.rb(CLIP), PARAM: gb.rb(PARAM)})
            self.assertEqual((closed.rb(CLIP), closed.rb(STEP)), (2 if plus else 7, 27))

    def test_child_effect_cue_precedes_increment_and_completion_clears_objects(self):
        for phase in (0xC1, 0xC2, 0xDF, 0xFF):
            mem = {PARAM: phase, STEP: 21, OBJ5: 0x80, OBJ1 + 7: 1, OBJ1 + 12: 0x40, 0xC60B: 0xFF}
            gb = call(0x12, 0x4B77, mem=mem)
            self.assertEqual(gb.rb(0xC60B), 0x74 if phase == 0xC2 else 0xFF)
            if phase == 0xDF:
                self.assertEqual((gb.rb(PARAM), gb.rb(STEP), gb.rb(OBJ5), gb.rb(OBJ1 + 7), gb.rb(OBJ1 + 12)),
                                 (0, 22, 0, 0, 0x3C))
            else:
                self.assertEqual((gb.rb(PARAM), gb.rb(STEP), gb.rb(OBJ5)), ((phase + 1) & 255, 21, 0x80))

    def test_graphics_use_record_species_and_separate_vram_slots(self):
        rom = ROM.read_bytes()
        mem = {0xC986 + 11: 0x73, 0xC986 + 12: 0, 0xCA2B + 11: 0, 0xCA2B + 12: 1,
               STEP: 0, 0xC525: 0}
        gb = call(0x12, 0x4D6B, mem=mem)
        for species, obj, dest in ((0x73, OBJ1, 0x8600), (0x100, OBJ2, 0x8700)):
            self.assertEqual(gb.rb(obj + 2) | gb.rb(obj + 3) << 8, species)
            p = 4 * 0x4000 + (0x4EAA - 0x4000) + species * 3
            address, bank = rom[p] | rom[p + 1] << 8, rom[p + 2]
            output, _, _ = lzss_gfx.decompress(rom, bank, address)
            self.assertEqual(bytes(gb.rb(dest + i) for i in range(len(output))), bytes(output))
        self.assertEqual((gb.rb(STEP), gb.rb(0xC527), gb.rombank), (1, 0x7F, 0x12))
        self.assertEqual(gb.rb(SLOTS + 13) & 4, 4)

    def test_snapshot_copies_thirteen_values_and_skips_follower_targets(self):
        mem = {SLOTS + 7: 3, 0xFF8E: 0x40, 0xFF91: 0x50, 0xFF98: 2, STEP: 255, VALID: 0}
        mem.update({0xC8EF + i: 0x10 + i for i in range(15)})
        mem[SAVED + 13] = 0xA5
        gb = call(0x12, 0x4DFB, mem=mem)
        expected = [3, 0x40, 0x50, 2] + [0x10 + i for i in (0, 1, 2, 5, 6, 7, 10, 11, 12)]
        self.assertEqual([gb.rb(SAVED + i) for i in range(13)], expected)
        self.assertEqual((gb.rb(SAVED + 13), gb.rb(STEP), gb.rb(VALID)), (0xA5, 0, 0))

    def test_distinct_returns_publish_saved_script_and_link_mode(self):
        for flag in (0, 1, 0x80):
            gb = call(0x12, 0x494B, mem={0xC965: flag, 0xC91F: 1})
            self.assertEqual(tuple(gb.rb(a) for a in (0xC88D, 0xC5DB, 0xC5DC, 0xC5DF, 0xC91F)),
                             (flag, 8, 0, 1, 0))
        for addr, group, command in ((0x499B, 0x89, 0xF4), (0x4AC0, 0x6A, 0xED)):
            gb = call(0x12, addr, mem=RETURN | {SAVED: 3, OBJ5: 0x80, 0xCB7D: 3, 0xC90D: 7})
            self.assertEqual(tuple(gb.rb(a) for a in (0xC919, 0xC91A, 0xC91B, TALK_INDEX, TALK_GROUP, 0xC920, 0xD7FD)),
                             (0x2A, 0x67, 0x45, 1, group, command, 1))
            if addr == 0x499B:
                self.assertEqual(gb.rb(SLOTS + 7), 3)
            else:
                self.assertEqual(tuple(gb.rb(a) for a in (MAP, MAP_X, MAP_Y, 0xFF8E, 0xFF91, OBJ5, 0xCB7D, 0xC90D, CLIP)),
                                 (0x0D, 1, 0, 0x40, 0x40, 0, 0, 0, 2))

    def test_fade_wait_returns_only_when_fade_state_is_zero(self):
        for fade in (0, 1, 0x80):
            gb = call(0x12, 0x4C3D, mem=RETURN | {0xC56C: fade, 0xC919: 0x80, 0xC920: 0x8B})
            if fade:
                self.assertEqual((gb.rb(0xC919), gb.rb(0xC920)), (0x80, 0x8B))
            else:
                self.assertEqual((gb.rb(0xC919), gb.rb(0xC920), gb.rb(0xD7FD)), (0x2A, 0xED, 1))

    def test_field_graphics_readers_return_byte_two_and_use_distinct_slots(self):
        rom = ROM.read_bytes()
        for command in (0, 13, 14, 20):
            p = 0x12 * 0x4000 + (0x704C - 0x4000) + 4 * command
            pointer, selector, trailing = rom[p] | rom[p + 1] << 8, rom[p + 2], rom[p + 3]
            output, _, _ = lzss_gfx.decompress(rom, 0x7E, pointer)
            palette_start = 0x7E * 0x4000 + (0x4BBD - 0x4000) + 8 * (selector & 0x7F)
            for address, dest, palette_offset in ((0x6E0B, 0x8400, 0x20), (0x6E61, 0x8300, 0x18)):
                for cgb in (0, 1):
                    gb = call(0x12, address, mem={0xFFC6: command, 0xC525: cgb, 0xC527: 0})
                    self.assertEqual(gb.a, selector)
                    self.assertEqual(bytes(gb.rb(dest + i) for i in range(len(output))), bytes(output))
                    if cgb:
                        self.assertEqual(bytes(gb.rb(OBJ_PALETTES + palette_offset + i) for i in range(8)),
                                         rom[palette_start:palette_start + 8])
                        self.assertEqual(gb.rb(0xC527), 0x7F)
                    else:
                        self.assertEqual(gb.rb(0xC527), 0)
            if command == 0:
                self.assertNotEqual(selector, trailing)  # distinguishes the earlier byte-3 hypothesis


if __name__ == '__main__':
    unittest.main()
