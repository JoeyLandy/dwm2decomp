"""E-0361: follower command probes on original ROM bytes in tools/sm83.py.

Disabled interrupts, WRAM bank 1; no hardware or complete map-warp validation.
The next-screen setup probe stops at the first callee and checks its input only.
"""
import re
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'tests'))
from test_routine_behaviour import ROM, GameBoy, call  # noqa: E402

RAM = {name: int(value, 16) for name, value in re.findall(
    r'^DEF (\w+) EQU \$([0-9A-F]+)', (ROOT / 'src/ram.asm').read_text(), re.M)}


def memory(**values):
    return {RAM[name]: value for name, value in values.items()}


F = RAM['wFollowerRecords']


@unittest.skipUnless(ROM.is_file(), 'reference ROM not present')
class FollowerCommands(unittest.TestCase):
    def test_initialization_preserves_other_bits_and_wraps_step(self):
        gb = call(0x12, 0x4FD7, memory(hPlayerStateFlags=0xA4, hPlayerFacing=3,
                                     wScriptStep=255, wSoundEffectRequest=255))
        self.assertEqual((gb.rb(RAM['hPlayerStateFlags']), gb.rb(RAM['hPlayerFacing']),
                          gb.rb(RAM['wScriptStep']), gb.rb(RAM['wSoundEffectRequest'])),
                         (0xA6, 0, 0, 0x65))
        for command in (0x4E4B, 0x4E55, 0x4ECE, 0x4EF9, 0x4F1E):
            gb = call(0x12, command, memory(hPlayerStateFlags=0xA4, wScriptStep=0,
                                           wSoundEffectRequest=255))
            self.assertEqual((gb.rb(RAM['hPlayerStateFlags']), gb.rb(RAM['wScriptStep']),
                              gb.rb(RAM['wSoundEffectRequest'])), (0xA6, 1, 0x65))

    def test_all_four_walk_thresholds_use_updated_exact_byte_equality(self):
        for addr, threshold in ((0x4EDE, 0x20), (0x4F03, 0x60),
                                (0x4F5C, 0x50), (0x4FBC, 0x80)):
            for y in (threshold - 2, threshold - 1, threshold, 254, 255):
                gb = call(0x12, addr, memory(hPlayerY=y, wScriptStep=7, wFollowerDelay=1))
                new_y = (y + 2) & 255
                self.assertEqual(gb.rb(RAM['hPlayerY']), new_y)
                self.assertEqual(gb.rb(RAM['wScriptStep']), 8 if new_y == threshold else 7)

    def test_target_capture_at_intermediate_boundary_precedes_second_step(self):
        mem = memory(hPlayerX=0x20, hPlayerY=0x0F, wScriptStep=1)
        for n in range(3):
            mem.update({F + 5*n: 3, F + 5*n + 1: 0x20,
                        F + 5*n + 2: 8 - n, F + 5*n + 3: 0x20,
                        F + 5*n + 4: 9 - n})
        gb = call(0x12, 0x4FBC, mem)
        self.assertEqual(gb.rb(RAM['hPlayerY']), 0x11)
        # First call advances to 9,8,7; boundary capture takes those positions.
        self.assertEqual([gb.rb(F + 5*n + 4) for n in range(3)], [0x10, 9, 8])
        self.assertEqual([gb.rb(F + 5*n + 2) for n in range(3)], [10, 9, 8])
        self.assertEqual(gb.rombank, 0x12)

    def test_last_party_y_alone_controls_completion_after_two_steps(self):
        for count in (1, 2, 3):
            for last_y in (0x42, 0x43):
                mem = memory(hPlayerY=0x42, hPlayerX=0x20, wPartyCount=count,
                             wFollowerDelay=1, hPlayerStateFlags=0xA6,
                             wScriptStartRequest=0x55, wScriptStep=8)
                mem.update({F + 5*n + 1: 0xE0 for n in range(3)})
                mem.update({F + 5*n + 2: 0x99 for n in range(3)})
                mem[F + 5*(count-1) + 2] = last_y
                gb = call(0x12, 0x4F2E, mem)
                self.assertEqual(gb.rb(RAM['wScriptStartRequest']), 0x80 if last_y == 0x42 else 0x55)
                self.assertEqual(gb.rb(RAM['hPlayerStateFlags']), 0xA4 if last_y == 0x42 else 0xA6)
                self.assertEqual(gb.rb(RAM['wScriptStep']), 8)
        mem = memory(hPlayerY=0x42, wPartyCount=1)
        mem.update({F+1: 0x20, F+2: 0x40, F+3: 0x20, F+4: 0x42})
        gb = call(0x12, 0x4F2E, mem)
        self.assertEqual((gb.rb(F+2), gb.rb(RAM['wScriptStartRequest'])), (0x42, 0x80))
        for command, stage in ((0x4E4B, 2), (0x4E55, 4), (0x4ECE, 5),
                               (0x4EF9, 2), (0x4F1E, 5)):
            mem = memory(hPlayerY=0x42, wPartyCount=1, wFollowerDelay=1,
                         wScriptStep=stage, hPlayerStateFlags=2)
            mem[F+2] = 0x42
            gb = call(0x12, command, mem)
            self.assertEqual((gb.rb(RAM['wScriptStartRequest']), gb.rb(RAM['hPlayerStateFlags'])),
                             (0x80, 0))
        # $80 requests fetching; only the next opcode determines whether the
        # whole script ends. A normal opcode starts another command.
        for opcode in (0x90, 0xFF):
            mem = memory(wScriptStartRequest=0x80, wScriptRunning=1,
                         wScriptPointerLo=0, wScriptPointerHi=0xC0)
            mem[0xC000] = opcode
            gb = call(0x10, 0x4008, mem)
            self.assertEqual(gb.rb(RAM['wScriptStartRequest']), 0)
            self.assertEqual(gb.rb(RAM['wScriptRunning']), 0 if opcode == 0xFF else 1)
            self.assertEqual(gb.rb(RAM['wScriptCommandType']), 0 if opcode == 0xFF else 0x90)

    def test_warp_gates_read_preupdate_upstream_and_always_move_player(self):
        for player_y, y1, y2, y3 in ((0xDF, 0xDF, 0xDF, 0xFE),
                                     (0xE0, 0xE0, 0xE0, 0x40),
                                     (0x4E, 0xFE, 0x20, 0x30),
                                     (0xFE, 0x20, 0xFE, 0x30)):
            mem = memory(hPlayerY=player_y, hPlayerStateFlags=0xA4, wScriptStep=3)
            mem.update({F: 3, F+2: y1, F+5: 3, F+7: y2, F+10: 3, F+12: y3})
            gb = call(0x12, 0x4E63, mem)
            expected = [(y1 + (2 if player_y < 0xE0 else 0)) & 255,
                        (y2 + (2 if y1 < 0xE0 else 0)) & 255,
                        (y3 + (2 if y2 < 0xE0 else 0)) & 255]
            self.assertEqual([gb.rb(F+n) for n in (2, 7, 12)], expected)
            self.assertEqual([gb.rb(F+n) for n in (0, 5, 10)], [0, 0, 0])
            self.assertEqual(gb.rb(RAM['hPlayerY']), (player_y+2) & 255)
            self.assertEqual(gb.rb(RAM['wScriptStep']), 4 if player_y == 0x4E else 3)
            self.assertEqual(gb.rb(RAM['hPlayerStateFlags']), 0xA6)

    def test_targets_snapshot_positions_without_changing_direction(self):
        mem = memory(hPlayerX=0x70, hPlayerY=0x40)
        for n in range(3):
            mem.update({F+5*n: 3, F+5*n+1: 0x60-n*0x10, F+5*n+2: 0x30-n*0x10})
        gb = call(2, 0x5923, mem)
        self.assertEqual([(gb.rb(F+5*n+3), gb.rb(F+5*n+4)) for n in range(3)],
                         [(0x70, 0x40), (0x60, 0x30), (0x50, 0x20)])
        self.assertEqual([gb.rb(F+5*n) for n in range(3)], [3, 3, 3])

    def test_follower_motion_prioritizes_x_and_preserves_delay_and_targets(self):
        for request, speed in ((0, 1), (0x80, 4)):
            mem = memory(wFieldActionRequest=request, wPartyCount=1)
            records = ((7, 0xFE, 8, 0xFF, 0), (7, 8, 1, 8, 0), (7, 8, 0xFE, 8, 0xFF))
            mem.update({F+5*n+i: v for n, row in enumerate(records) for i, v in enumerate(row)})
            gb = call(2, 0x5946, mem)
            self.assertEqual([(gb.rb(F+5*n), gb.rb(F+5*n+1), gb.rb(F+5*n+2)) for n in range(3)],
                             [(1, (0xFE+speed)&255, 8), (2, 8, (1-speed)&255),
                              (0, 8, (0xFE+speed)&255)])
            self.assertEqual([(gb.rb(F+5*n+3), gb.rb(F+5*n+4)) for n in range(3)],
                             [(0xFF, 0), (8, 0), (8, 0xFF)])
            mem[RAM['wFollowerDelay']] = 2
            gb = call(2, 0x5946, mem)
            self.assertEqual(gb.rb(RAM['wFollowerDelay']), 2)
            self.assertEqual([gb.rb(F+i) for i in range(15)], [v for row in records for v in row])

    def test_entry_fade_publishes_destination_without_moving_coordinates(self):
        gb = call(0x12, 0x4EAD, memory(hPlayerX=0x38, hPlayerY=0x80,
                                     wScriptStep=2, wScriptParam0=9))
        self.assertEqual([gb.rb(RAM[n]) for n in ('hMapId', 'hMapScreenX', 'hMapScreenY',
                         'wWarpDestX', 'wWarpDestY', 'wFieldTransitionKind',
                         'wModeState', 'wFieldTransitionStep', 'wScriptParam0', 'wScriptStep')],
                         [1, 1, 0, 0x38, 0xF0, 0, 4, 0, 0, 3])
        self.assertEqual(gb.rb(RAM['hPlayerY']), 0x80)
        self.assertEqual(gb.rombank, 0x12)

    def test_next_screen_prefix_sets_delta_and_preserves_horizontal_delta(self):
        class ReachedMovement(Exception):
            pass
        gb = GameBoy(ROM.read_bytes())
        gb.rombank = 0x12
        mem = memory(hMapScreenY=255, hPlayerStateFlags=0xA6,
                     hPlayerStepDXLo=0x34, hPlayerStepDXHi=0x12, wScriptStep=2)
        for addr, value in mem.items():
            gb.wb(addr, value)
        gb.pc, gb.sp = 0x4F8E, 0xDFF0
        def stop(_):
            raise ReachedMovement
        gb.pc_hooks[0x541B] = stop
        with self.assertRaises(ReachedMovement):
            gb.run(1000)
        self.assertEqual(gb.rombank, 2)
        self.assertEqual([gb.rb(RAM[n]) for n in ('wFieldActionRequest', 'wScreenScrollDir',
                         'hMapScreenY', 'hPlayerStateFlags', 'hPlayerStepDYLo', 'hPlayerStepDYHi',
                         'hPlayerStepDXLo', 'hPlayerStepDXHi', 'wScriptStep')],
                         [0x80, 8, 0, 0xA7, 0x80, 0xFF, 0x34, 0x12, 2])

    def test_wait_advances_only_after_action_bit_seven_is_clear(self):
        for request in (0, 1, 0x81):
            gb = call(0x12, 0x4F77, memory(wFadeState=1, wFieldActionRequest=request,
                                         wScreenScrollDir=8, wScriptStep=3))
            self.assertEqual(gb.rb(RAM['wScriptStep']), 3 if request & 0x80 else 4)
            self.assertEqual(gb.rombank, 0x12)


if __name__ == '__main__':
    unittest.main()
