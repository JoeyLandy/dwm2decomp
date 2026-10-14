"""E-0362: original-ROM sprite/warp probes in the project's unvalidated emulator.

Direct calls disable interrupts and use WRAM bank 1; no full story playthrough
or hardware-timing assertion. Synthetic slot/script fixtures are explicit.
"""
import json
import re
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'tests'))
sys.path.insert(0, str(ROOT / 'tools'))
from test_routine_behaviour import ROM, GameBoy, call  # noqa: E402
import lzss_gfx  # noqa: E402

RAM = {name: int(value, 16) for name, value in re.findall(
    r'^DEF (\w+) EQU \$([0-9A-F]+)', (ROOT / 'src/ram.asm').read_text(encoding='utf-8'), re.M)}
RAM.update({v['name']: int(k, 16) for k, v in json.loads(
    (ROOT / 'config/symbols.json').read_text(encoding='utf-8')).items()
            if not k.startswith('_') and isinstance(v, dict) and 'name' in v})
SLOTS, FOLLOWERS = RAM['wSpriteSlots'], RAM['wFollowerRecords']


def memory(**values):
    return {RAM[name]: value for name, value in values.items()}


def offset(bank, address):
    return bank * 0x4000 + address - 0x4000


def word(rom, pos):
    return rom[pos] | rom[pos+1] << 8


def graphics(rom, kind, ident):
    if kind:
        pointer = word(rom, offset(4, 0x43AC) + 2*ident)
        bank = 0x7D if (ident & 255) < 0x50 else 0x7E
        palette_id = rom[offset(4, 0x4A46) + (ident & 255)]
        palette_pos = offset(0x7E, 0x4B15) + ((8*palette_id) & 255)
    else:
        pos = offset(4, 0x4EAA) + 3*ident
        pointer, bank = word(rom, pos), rom[pos+2]
        palette_pos = offset(0x27, 0x7328) + 8*ident
    data, _, _ = lzss_gfx.decompress(rom, bank, pointer)
    return bytes(data), rom[palette_pos:palette_pos+8]


@unittest.skipUnless(ROM.is_file(), 'reference ROM not present')
class SpriteWarpCommands(unittest.TestCase):
    def test_flash_start_saves_only_cgb_background_palettes(self):
        for cgb in (0, 1):
            mem = memory(wIsCGB=cgb, wScriptStep=0, wScriptParam0=9, wSoundEffectRequest=255)
            mem.update({RAM['wBGPaletteBuffer']+i: i ^ 0xA5 for i in range(64)})
            mem.update({RAM['wBGPaletteCopy']+i: 0xCC for i in range(64)})
            gb = call(0x12, 0x4FEA, mem)
            self.assertEqual(bytes(gb.rb(RAM['wBGPaletteCopy']+i) for i in range(64)),
                             bytes(i ^ 0xA5 for i in range(64)) if cgb else bytes([0xCC]*64))
            self.assertEqual((gb.rb(RAM['wScriptStep']), gb.rb(RAM['wScriptParam0']),
                              gb.rb(RAM['wSoundEffectRequest'])), (1, 9, 0x7A))

    def test_flash_uses_incoming_bit_two_and_updated_exact_counter(self):
        for cgb in (0, 1):
            for phase in (0, 3, 4, 7, 8, 29, 30, 255):
                mem = memory(wIsCGB=cgb, wScriptParam0=phase, wScriptStep=1)
                mem.update({RAM['wBGPaletteCopy']+i: i for i in range(64)})
                mem.update({RAM['wBGPaletteBuffer']+i: 0xCC for i in range(64)})
                gb = call(0x12, 0x5090, mem)
                normal = bool(phase & 4)
                self.assertEqual([gb.rb(RAM[n]) for n in ('wDMGPaletteBGP', 'wDMGPaletteOBP0', 'wDMGPaletteOBP1')],
                                 [0xD2, 0xD2, 0xE2] if normal else [0x2D, 0x2D, 0x1D])
                self.assertEqual(bytes(gb.rb(RAM['wBGPaletteBuffer']+i) for i in range(64)),
                                 bytes(i if normal else i ^ 255 for i in range(64)) if cgb else bytes([0xCC]*64))
                self.assertEqual(gb.rb(RAM['wBGPaletteUploadRequest']), 0x7F if cgb else 0)
                self.assertEqual((gb.rb(RAM['wScriptParam0']), gb.rb(RAM['wScriptStep'])),
                                 (0, 2) if phase == 29 else ((phase+1)&255, 1))
                self.assertEqual(gb.rombank, 0x12)

    def test_turns_wait_for_three_and_wrap_facing_and_phase(self):
        for phase in (0, 1, 2, 3, 255):
            gb = call(0x12, 0x501E, memory(wScriptParam0=phase, hPlayerFacing=3, wScriptStep=255))
            self.assertEqual([gb.rb(RAM[n]) for n in ('wScriptParam0', 'hPlayerFacing', 'wScriptStep')],
                             [0, 0, 0] if phase == 2 else [(phase+1)&255, 3, 255])

    def test_activation_loads_once_before_shared_turn_counting(self):
        data, _ = graphics(ROM.read_bytes(), 1, 1)
        for phase in (0, 1, 2, 255):
            mem = memory(wScriptParam0=phase, hPlayerSpriteOverride=1,
                         hPlayerSpriteGfxIdLo=1, hPlayerSpriteGfxIdHi=0, wScriptStep=4,
                         hPlayerFacing=1)
            mem.update({0x8000+i: 0xA5 for i in range(len(data))})
            gb = call(0x12, 0x5007, mem)
            self.assertEqual(bytes(gb.rb(0x8000+i) for i in range(len(data))),
                             data if phase == 0 else bytes([0xA5]*len(data)))
            self.assertEqual(gb.rb(RAM['hPlayerSpriteOverride']), 0x81 if phase == 0 else 1)
            self.assertEqual(gb.rb(RAM['wOBJPaletteUploadRequest']), 0x7F if phase == 0 else 0)
            self.assertEqual((gb.rb(RAM['hPlayerFacing']), gb.rb(RAM['wScriptStep'])),
                             (2, 5) if phase == 2 else (1, 4))

    def test_selection_copies_bytes_one_to_three_without_slot_state_filter(self):
        mem = memory(wSpriteSlotCount=12, wScriptStep=2, wScriptParam0=7)
        for n in range(12):
            mem.update({SLOTS+16*n: 0xEE, SLOTS+16*n+11: 0xA0, SLOTS+16*n+12: 0x90})
        mem.update({SLOTS+16*3: 0, SLOTS+16*3+1: 0, SLOTS+16*3+2: 0x01,
                    SLOTS+16*3+3: 1, SLOTS+16*3+11: 0x9F, SLOTS+16*3+12: 0x8F})
        # An eligible ninth slot must remain unsampled.
        mem.update({SLOTS+16*8+1: 1, SLOTS+16*8+2: 2,
                    SLOTS+16*8+11: 0x20, SLOTS+16*8+12: 0x20})
        gb = call(0x12, 0x5038, mem)
        self.assertEqual([gb.rb(RAM[n]) for n in ('hPlayerSpriteOverride', 'hPlayerSpriteGfxIdLo',
                         'hPlayerSpriteGfxIdHi', 'hPlayerSpriteTimerLo', 'hPlayerSpriteTimerHi',
                         'hPlayerFacing', 'wScriptParam0', 'wScriptStep')], [0, 1, 1, 100, 0, 0, 0, 3])
        self.assertEqual(gb.rb(RAM['wKeyRandomHi']) & 7, 3)

    def test_selection_rejects_exact_field_5e_but_accepts_kind_81(self):
        for kind in (1, 0x81):
            mem = memory(wSpriteSlotCount=2, wScriptStep=2)
            mem.update({SLOTS+1: kind, SLOTS+2: 0x5E, SLOTS+3: 0,
                        SLOTS+11: 0x20, SLOTS+12: 0x20,
                        SLOTS+17: 0, SLOTS+18: 2, SLOTS+19: 0,
                        SLOTS+27: 0x20, SLOTS+28: 0x20})
            gb = call(0x12, 0x5038, mem)
            self.assertEqual((gb.rb(RAM['hPlayerSpriteOverride']), gb.rb(RAM['hPlayerSpriteGfxIdLo'])),
                             (0, 2) if kind == 1 else (0x81, 0x5E))

    def test_graphics_loader_uses_table_ids_and_slot_zero_palette(self):
        rom = ROM.read_bytes()
        for kind, ident in ((0, 1), (0, 0x100), (1, 1), (1, 0x5E)):
            data, palette = graphics(rom, kind, ident)
            for cgb in (0, 1):
                mem = memory(hPlayerSpriteOverride=0x80|kind, hPlayerSpriteGfxIdLo=ident&255,
                             hPlayerSpriteGfxIdHi=ident>>8, hPlayerSpriteVariant=9, wIsCGB=cgb)
                mem.update({RAM['wOBJPaletteBuffer']+i: 0xCC for i in range(16)})
                gb = call(4, 0x4B2D, mem)
                self.assertEqual(bytes(gb.rb(0x8000+i) for i in range(len(data))), data)
                self.assertEqual(bytes(gb.rb(RAM['wOBJPaletteBuffer']+i) for i in range(8)),
                                 palette if cgb else bytes([0xCC]*8))
                self.assertEqual(bytes(gb.rb(RAM['wOBJPaletteBuffer']+8+i) for i in range(8)), bytes([0xCC]*8))
                self.assertEqual(gb.rb(RAM['hPlayerSpriteVariant']), 9)
                self.assertEqual(gb.rb(RAM['wOBJPaletteUploadRequest']), 0)

    def test_restore_disables_override_and_keeps_id_timer_bytes(self):
        for flag in (0, 1):
            data, _ = graphics(ROM.read_bytes(), 1, flag)
            mem = memory(hPlayerSpriteOverride=0x81, hPlayerSpriteGfxIdLo=0x5E,
                         hPlayerSpriteGfxIdHi=1, hPlayerSpriteTimerLo=0xAA, hPlayerSpriteTimerHi=0xBB,
                         wStoryFlags=flag, wScriptStep=2)
            gb = call(0x12, 0x50BD, mem)
            self.assertEqual(bytes(gb.rb(0x8000+i) for i in range(len(data))), data)
            self.assertEqual([gb.rb(RAM[n]) for n in ('hPlayerSpriteOverride', 'hPlayerSpriteVariant',
                             'hPlayerSpriteGfxIdLo', 'hPlayerSpriteGfxIdHi', 'hPlayerSpriteTimerLo',
                             'hPlayerSpriteTimerHi', 'wOBJPaletteUploadRequest', 'wScriptStartRequest',
                             'wScriptStep')], [0, flag, 0x5E, 1, 0xAA, 0xBB, 0x7F, 0x80, 2])

    def test_message_open_idle_wait_and_flash_resume(self):
        gb = call(0x12, 0x50B3, memory(wScriptStep=0, wMessageGroup=0x22, wMessageState=0xFF))
        self.assertEqual([gb.rb(RAM[n]) for n in ('wMessageIndex', 'wMessageGroup', 'wMessageState', 'wScriptStep')],
                         [0x12, 0x22, 0, 1])
        gb = call(0x12, 0x50B3, memory(wScriptStep=1, wMessageState=0xFF, hPlayerSpriteOverride=0x81))
        self.assertEqual((gb.rb(RAM['wScriptStep']), gb.rb(RAM['hPlayerSpriteOverride'])), (2, 0x81))
        gb = call(0x12, 0x4FEA, memory(wScriptStep=7, hSpriteWindowClipMode=2,
                                     hPlayerSpriteOverride=0x81, hPlayerSpriteTimerLo=100))
        self.assertEqual([gb.rb(RAM[n]) for n in ('hSpriteWindowClipMode', 'wScriptStartRequest',
                         'hPlayerSpriteOverride', 'hPlayerSpriteTimerLo')], [0, 0x80, 0x81, 100])

    def test_override_timer_gates_and_sign_test_including_zero_underflow(self):
        for override, running, timer, expected in ((0, 0, 10, 10), (0x80, 1, 10, 10),
                                                   (0x80, 0, 1, 0), (0x80, 0, 0x8000, 0x7FFF)):
            gb = call(0x0A, 0x5748, memory(hPlayerSpriteOverride=override, wScriptRunning=running,
                                         hPlayerSpriteTimerLo=timer&255, hPlayerSpriteTimerHi=timer>>8,
                                         wTalkEventGroup=0x55))
            self.assertEqual(gb.rb(RAM['hPlayerSpriteTimerLo']) | gb.rb(RAM['hPlayerSpriteTimerHi'])<<8, expected)
            self.assertEqual(gb.rb(RAM['wTalkEventGroup']), 0x55)
        gb = call(0x0A, 0x5748, memory(hPlayerSpriteOverride=0x80, wScriptRunning=0,
                                     hPlayerSpriteTimerLo=0, hPlayerSpriteTimerHi=0, wTalkEventGroup=0x55))
        self.assertEqual((gb.rb(RAM['hPlayerSpriteTimerLo']), gb.rb(RAM['hPlayerSpriteTimerHi'])), (255, 255))
        self.assertEqual((gb.rb(RAM['wTalkEventGroup']), gb.rb(RAM['wTalkEventIndex'])), (0x0A, 0))
        self.assertEqual(gb.rombank, 0x0A)
        for eligible_call in (100, 101):
            # Incoming value on that eligible call, from an initial timer 100.
            incoming = 101 - eligible_call
            gb = call(0x0A, 0x5748, memory(hPlayerSpriteOverride=0x80,
                                         hPlayerSpriteTimerLo=incoming, wTalkEventGroup=0x55))
            self.assertEqual(gb.rb(RAM['wTalkEventGroup']), 0x55 if eligible_call == 100 else 0x0A)

    def test_general_graphics_helper_palette_slot_wrap_and_no_upload(self):
        data, palette = graphics(ROM.read_bytes(), 0, 1)
        for slot in (1, 7, 32):
            mem = memory(hTemp0=1, hTemp1=0, hTemp2=0, hTemp3=slot,
                         hTemp4=0, hTemp5=0x86, wIsCGB=1)
            gb = call(4, 0x431F, mem)
            self.assertEqual(bytes(gb.rb(0x8600+i) for i in range(len(data))), data)
            self.assertEqual(bytes(gb.rb(RAM['wOBJPaletteBuffer']+((8*slot)&255)+i) for i in range(8)), palette)
            self.assertEqual(gb.rb(RAM['wOBJPaletteUploadRequest']), 0)

    def test_renderer_prefix_adds_scroll_and_routes_each_override_kind(self):
        class AtDraw(Exception):
            pass
        for override, ident, bank, set_index in ((0, 0, 0x7F, 9), (0x81, 0x5E, 0x7F, 0x5E),
                                                (0x80, 1, 0x25, 1), (0x80, 0x81, 0x26, 1),
                                                (0x80, 0x101, 0x27, 1)):
            gb = GameBoy(ROM.read_bytes())
            gb.rombank, gb.pc, gb.sp = 4, 0x4C96, 0xDFF0
            mem = memory(hPlayerSpriteOverride=override, hPlayerSpriteGfxIdLo=ident&255,
                         hPlayerSpriteGfxIdHi=ident>>8, hPlayerSpriteVariant=9, hMapId=1,
                         hPlayerX=0xFC, hPlayerY=0xFC, hPlayerFacing=3, hPlayerAnimCounter=0x20,
                         hScrollX=0xFF, hScrollXHi=1, hScrollY=0xFF, hScrollYHi=2, hPlayerSpriteMode=2)
            for addr, value in mem.items():
                gb.wb(addr, value)
            def stop(_):
                if gb.rombank in (0x25, 0x26, 0x27, 0x7F):
                    raise AtDraw
            gb.pc_hooks[0x4001] = stop
            with self.assertRaises(AtDraw):
                gb.run(10000)
            self.assertEqual(gb.rombank, bank)
            self.assertEqual([gb.rb(RAM[n]) for n in ('hSpriteOriginX', 'hSpriteOriginXHi',
                             'hSpriteOriginY', 'hSpriteOriginYHi', 'hSpriteSetIndex', 'hSpriteSubIndex',
                             'hSpriteAttrXor', 'hSpriteTileOffset')], [3, 2, 3, 3, set_index, 3, 0x20, 0])
        gb = call(4, 0x4C96, memory(hFieldDrawFlags=1, hSpriteSetIndex=0x55, hSpriteOriginX=0xAA))
        self.assertEqual((gb.rb(RAM['hSpriteSetIndex']), gb.rb(RAM['hSpriteOriginX'])), (0x55, 0xAA))

    def test_special_pose_helper_has_nine_normal_regions_and_distinct_fade_path(self):
        rom = ROM.read_bytes()
        for n in range(9):
            map_id, sx, sy, x, low, high = rom[offset(4, 0x4E73)+6*n:offset(4, 0x4E73)+6*n+6]
            for y, result in ((low, 1), (high, 1), ((low-1)&255, 0), (high+1, 0)):
                gb = call(4, 0x4E0F, memory(hMapId=map_id, hMapScreenX=sx, hMapScreenY=sy),
                          b=x, c=y, h=0xC1, l=0x23, d=0x45, e=0x67)
                self.assertEqual(gb.a, result, (n, y))
                self.assertEqual((gb.h, gb.l, gb.d, gb.e), (0xC1, 0x23, 0x45, 0x67))
        for player_y, result in ((0x80, 1), (0x7F, 0)):
            gb = call(4, 0x4E0F, memory(wFadeState=1, hMapId=0x5A, hPlayerY=player_y), b=255, c=255)
            self.assertEqual(gb.a, result)

    def test_normal_map_records_all_decode_and_miss_has_no_transition(self):
        rom = ROM.read_bytes()
        for n in range(16):
            row = rom[offset(0x12, 0x5130)+5*n:offset(0x12, 0x5130)+5*n+5]
            mem = memory(hMapId=row[0], wScriptStep=1, hPlayerStateFlags=255, wFieldInitStage=255)
            gb = call(0x12, 0x50E5, mem)
            self.assertEqual([gb.rb(RAM[k]) for k in ('hMapId', 'wWarpDestX', 'wWarpDestY',
                             'hMapScreenX', 'hMapScreenY', 'wFieldTransitionStep', 'wFieldTransitionKind',
                             'wModeState', 'wFieldInitStage', 'hPlayerStateFlags', 'wScriptStartRequest')],
                             [row[1], row[3]&0xF0, (row[3]&15)<<4, row[4]>>4, row[4]&15,
                              0x80, 1, 4, 0, 0x77, 0x80])
        mem = memory(hMapId=1, wScriptStep=1, wWarpDestX=0x23, wModeState=9, wFieldTransitionStep=5)
        gb = call(0x12, 0x50E5, mem)
        self.assertEqual([gb.rb(RAM[k]) for k in ('hMapId', 'wWarpDestX', 'wModeState',
                         'wFieldTransitionStep', 'wScriptStartRequest')], [1, 0x23, 9, 5, 0x80])
        self.assertEqual(gb.c, 0)

    def test_saved_goal_override_and_key_world_direct_goal_paths(self):
        for active, key, slot, packed in ((1, 1, 0, True), (0, 1, 0, False)):
            mem = memory(hMapId=0x2F, wScriptStep=1, wKeyWorldActive=active, wKeyWorldKey=key,
                         wKeyWorldSlot=slot, wKeyWorldGoal=0xA3, wKeyWorldGoalCell=0xB4)
            gb = call(0x12, 0x50E5, mem)
            self.assertEqual([gb.rb(RAM[n]) for n in ('hMapId', 'wWarpDestX', 'wWarpDestY', 'hMapScreenX', 'hMapScreenY')],
                             [0x20, 0xA0, 0x30, 0xB, 4] if packed else [0x20, 0x40, 0x40, 0, 0])
        for active, key, slot, packed in ((1, 0x83, 3, True), (0, 0x83, 3, False),
                                         (1, 3, 3, False), (1, 0x83, 2, False)):
            mem = memory(hMapId=0x66, wMapType=0x80, wScriptStep=1, wKeyWorldActive=active,
                         wKeyWorldKey=key, wKeyWorldSlot=slot, wKeyWorldGoal=0xA3,
                         wKeyWorldGoalCell=0xB4, wKeyWorldGoalPos=0x23, wKeyWorldGoalPos2=0x56,
                         wKeyWorldGoalScreen=0x87, wWarpDestFacing=3)
            gb = call(0x12, 0x50E5, mem)
            self.assertEqual([gb.rb(RAM[n]) for n in ('hMapId', 'wWarpDestX', 'wWarpDestY',
                             'hMapScreenX', 'hMapScreenY', 'wWarpDestFacing')],
                             [0x66, 0xA0, 0x30, 0xB, 4, 3] if packed else [0x66, 0x23, 0x56, 8, 7, 3])

    def test_party_lift_uses_phase_gates_equality_sentinel_and_wrap(self):
        for phase in (0, 7, 8, 15, 16, 23, 24, 89, 255):
            mem = memory(wScriptParam0=phase, hPlayerY=0, hPlayerFacing=3,
                         wScriptStep=0, hPlayerStateFlags=255, wPartyCount=1, wFollowerDelay=1)
            mem.update({FOLLOWERS+2: 0, FOLLOWERS+7: 0, FOLLOWERS+12: 0})
            gb = call(0x12, 0x557C, mem)
            self.assertEqual(gb.rb(RAM['hPlayerY']), 0xFC)
            self.assertEqual(gb.rb(RAM['hPlayerFacing']), (phase>>1)&3)
            self.assertEqual([gb.rb(FOLLOWERS+i) for i in (2, 7, 12)],
                             [0xFC if phase >= threshold else 0 for threshold in (8, 16, 24)])
            self.assertEqual((gb.rb(RAM['wScriptParam0']), gb.rb(RAM['wScriptStep']), gb.rb(RAM['hPlayerStateFlags'])),
                             (0, 1, 0xB7) if phase == 89 else ((phase+1)&255, 0, 255))
        mem = memory(wScriptParam0=24, hPlayerY=0xE0, hPlayerFacing=3)
        mem.update({FOLLOWERS+2: 0xE0, FOLLOWERS+7: 0xE1, FOLLOWERS+12: 0xE0})
        gb = call(0x12, 0x557C, mem)
        self.assertEqual([gb.rb(RAM['hPlayerY']), gb.rb(RAM['hPlayerFacing']),
                          gb.rb(FOLLOWERS+2), gb.rb(FOLLOWERS+7), gb.rb(FOLLOWERS+12)],
                         [0xE0, 3, 0xE0, 0xDD, 0xE0])

    def test_rng_recurrence_wraps_and_preserves_bc_hl(self):
        for seed in (0, 1, 0x7FFF, 0x8000, 0xFFFF):
            gb = call(0, 0x09F3, memory(wKeyRandomLo=seed&255, wKeyRandomHi=seed>>8),
                      b=0x12, c=0x34, h=0x56, l=0x78)
            self.assertEqual(gb.rb(RAM['wKeyRandomLo']) | gb.rb(RAM['wKeyRandomHi'])<<8,
                             (5*seed+11)&65535)
            self.assertEqual((gb.b, gb.c, gb.h, gb.l), (0x12, 0x34, 0x56, 0x78))


if __name__ == '__main__':
    unittest.main()
