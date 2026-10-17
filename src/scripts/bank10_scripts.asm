; ROM bank $10: event script engine: command fetch and handlers, scripts
; The annotated listing of this bank is build/listing/bank10.asm.

SECTION "Bank 10", ROMX
    db $10

; One frame of the event-script engine: FetchScriptCommand (fetches opcodes from wScriptPointerLo/Hi
; when wScriptStartRequest bit 7 is set), then ExecuteScriptCommand (runs one frame of the command
; in wScriptCommandType). Far-called from bank $02. (C2, E-0376)
; one frame of the event-script engine: FetchScriptCommand, then ExecuteScriptCommand
RunEventScriptFrame::
    call FetchScriptCommand
    call ExecuteScriptCommand
    ret

SECTION "Bank 10 FetchScriptCommand", ROMX

; Does nothing during a fade (wFadeState non-zero) or unless wScriptStartRequest bit 7 is set;
; otherwise clears that bit (the low bits stay), sets wScriptRunning = 1 and falls into
; FetchScriptCommand_NextOpcode, which fetches opcodes from wScriptPointerLo/Hi until one starts a
; command or $FF ends the script. A command asks for the next fetch by setting wScriptStartRequest =
; $80. Far-called from banks $02 and $07 and called by RunEventScriptFrame. (C2, E-0376)
; does nothing during a fade or unless wScriptStartRequest bit 7 is set (then it clears that bit and
; sets wScriptRunning); reads the opcode at wScriptPointer (through ReadWordFromDataBank when
; wScriptInDataBank is set) and jumps through a 13-entry opcode table; $FF ends the script
; (wScriptRunning, wScriptCommandType and wScriptInDataBank cleared, wModeState = 0, or 5 when
; wMapType bit 7 is set); the opcode handlers set wScriptCommandType and its parameters and advance
; wScriptPointer
FetchScriptCommand::
    ld a, [wFadeState]
    or a
    ret nz
    ld a, [wScriptStartRequest]
    bit 7, a
    ret z
    and $7f
    ld [wScriptStartRequest], a
    ld a, $01
    ld [wScriptRunning], a

; Reads the next script opcode (from the data bank when wScriptInDataBank is set): $FF ends the
; script (clears the running, command and data-bank flags; mode state 0, or 5 in a key world); any
; other opcode runs its fetch handler (ScriptOpcodeHandlers). (C2, E-0357; probed E-0376)
FetchScriptCommand_NextOpcode::
    ld a, [wScriptPointerLo]
    ld l, a
    ld a, [wScriptPointerHi]
    ld h, a
    ld a, [wScriptInDataBank]
    and a
    jr z, .skip
    call ReadWordFromDataBank
    ld a, b
    inc hl
    jr .cp_FF

.skip:
    ld a, [hli]

.cp_FF:
    cp $ff
    jr nz, .skip2
    xor a
    ld [wScriptRunning], a
    ld [wScriptCommandType], a
    ld [wScriptInDataBank], a
    ld a, [wMapType]
    bit 7, a
    jr nz, .set_mode_state_to_05
    ld a, $00
    ld [wModeState], a
    ret

.set_mode_state_to_05:
    ld a, $05
    ld [wModeState], a
    ret

.skip2:
    push hl
    jumptable

; the inline table after FetchScriptCommand's `rst $00`, indexed by the script byte; 249 words, 49
; distinct handlers: opcodes 0-12 each have their own, and most others share ScriptFetchGeneric,
; which makes the opcode byte the command type and starts the command (the command then reads its
; own arguments from the script pointer); a zero word is an unused opcode (E-0039, C1)
; record: fetch handler for this script byte (opcode)
ScriptOpcodeHandlers::
    dw ScriptFetchMessage ; entry 0
    dw ScriptFetchWalk ; entry 1
    dw ScriptFetchWalkFast ; entry 2
    dw ScriptFetchWait ; entry 3
    dw ScriptFetchHoldDpad ; entry 4
    dw ScriptFetchFace ; entry 5
    dw ScriptFetchSkipIfNo ; entry 6
    dw ScriptFetchJump ; entry 7
    dw $0000 ; entry 8
    dw $0000 ; entry 9
    dw ScriptFetchSetFlag ; entry 10
    dw ScriptFetchSlideY ; entry 11
    dw ScriptFetchHideObject ; entry 12
    dw ScriptFetchEncounter ; entry 13
    dw ScriptFetchAddGold ; entry 14
    dw ScriptFetchSound ; entry 15
    dw $0000 ; entry 16
    dw ScriptFetchGeneric ; entry 17
    dw ScriptFetchGeneric ; entry 18
    dw ScriptFetchGeneric ; entry 19
    dw ScriptFetchGeneric ; entry 20
    dw ScriptFetchGeneric ; entry 21
    dw ScriptFetchGeneric ; entry 22
    dw ScriptFetchGeneric ; entry 23
    dw ScriptFetchGeneric ; entry 24
    dw ScriptFetchGeneric ; entry 25
    dw ScriptFetchGeneric ; entry 26
    dw ScriptFetchGeneric ; entry 27
    dw ScriptFetch1C ; entry 28
    dw ScriptFetch1D ; entry 29
    dw ScriptFetchGeneric ; entry 30
    dw ScriptFetchGeneric ; entry 31
    dw ScriptFetchGeneric ; entry 32
    dw ScriptFetchGeneric ; entry 33
    dw ScriptFetchGeneric ; entry 34
    dw ScriptFetch23 ; entry 35
    dw ScriptFetchGeneric ; entry 36
    dw ScriptFetchGeneric ; entry 37
    dw ScriptFetchGeneric ; entry 38
    dw ScriptFetchGeneric ; entry 39
    dw ScriptFetchGeneric ; entry 40
    dw ScriptFetchGeneric ; entry 41
    dw ScriptFetchGeneric ; entry 42
    dw ScriptFetchGeneric ; entry 43
    dw ScriptFetchGeneric ; entry 44
    dw ScriptFetchGeneric ; entry 45
    dw ScriptFetchGeneric ; entry 46
    dw ScriptFetchGeneric ; entry 47
    dw ScriptFetchGeneric ; entry 48
    dw ScriptFetchGeneric ; entry 49
    dw ScriptFetchGeneric ; entry 50
    dw ScriptFetchGeneric ; entry 51
    dw ScriptFetchGeneric ; entry 52
    dw ScriptFetchGeneric ; entry 53
    dw ScriptFetchGeneric ; entry 54
    dw ScriptFetchGeneric ; entry 55
    dw ScriptFetchGeneric ; entry 56
    dw ScriptFetchGeneric ; entry 57
    dw ScriptFetchGeneric ; entry 58
    dw ScriptFetchGeneric ; entry 59
    dw ScriptFetchGeneric ; entry 60
    dw ScriptFetchGeneric ; entry 61
    dw ScriptFetchGeneric ; entry 62
    dw ScriptFetchGeneric ; entry 63
    dw ScriptFetchGeneric ; entry 64
    dw ScriptFetchGeneric ; entry 65
    dw ScriptFetchGeneric ; entry 66
    dw ScriptFetchGeneric ; entry 67
    dw ScriptFetchGeneric ; entry 68
    dw ScriptFetchGeneric ; entry 69
    dw ScriptFetchGeneric ; entry 70
    dw ScriptFetchGeneric ; entry 71
    dw ScriptFetchGeneric ; entry 72
    dw ScriptFetchGeneric ; entry 73
    dw ScriptFetchGeneric ; entry 74
    dw ScriptFetchGeneric ; entry 75
    dw ScriptFetchGeneric ; entry 76
    dw ScriptFetchGeneric ; entry 77
    dw ScriptFetchGeneric ; entry 78
    dw ScriptFetchGeneric ; entry 79
    dw ScriptFetchGeneric ; entry 80
    dw ScriptFetchGeneric ; entry 81
    dw ScriptFetchGeneric ; entry 82
    dw ScriptFetchGeneric ; entry 83
    dw ScriptFetchGeneric ; entry 84
    dw ScriptFetchGeneric ; entry 85
    dw ScriptFetchGeneric ; entry 86
    dw ScriptFetchGeneric ; entry 87
    dw ScriptFetchGeneric ; entry 88
    dw ScriptFetchGeneric ; entry 89
    dw ScriptFetchGeneric ; entry 90
    dw ScriptFetchGeneric ; entry 91
    dw ScriptFetchGeneric ; entry 92
    dw ScriptFetchGeneric ; entry 93
    dw ScriptFetchGeneric ; entry 94
    dw ScriptFetchGeneric ; entry 95
    dw ScriptFetchGeneric ; entry 96
    dw ScriptFetchGeneric ; entry 97
    dw ScriptFetch62 ; entry 98
    dw ScriptFetchGeneric ; entry 99
    dw ScriptFetchGeneric ; entry 100
    dw ScriptFetchGeneric ; entry 101
    dw ScriptFetchGeneric ; entry 102
    dw ScriptFetchGeneric ; entry 103
    dw ScriptFetchGeneric ; entry 104
    dw ScriptFetchGeneric ; entry 105
    dw ScriptFetchGeneric ; entry 106
    dw ScriptFetchGeneric ; entry 107
    dw ScriptFetchGeneric ; entry 108
    dw ScriptFetchGeneric ; entry 109
    dw ScriptFetchGeneric ; entry 110
    dw ScriptFetchGeneric ; entry 111
    dw ScriptFetchGeneric ; entry 112
    dw ScriptFetchGeneric ; entry 113
    dw ScriptFetchGeneric ; entry 114
    dw ScriptFetchGeneric ; entry 115
    dw ScriptFetchGeneric ; entry 116
    dw ScriptFetchGeneric ; entry 117
    dw ScriptFetchGeneric ; entry 118
    dw ScriptFetchGeneric ; entry 119
    dw ScriptFetchGeneric ; entry 120
    dw ScriptFetchGeneric ; entry 121
    dw ScriptFetchGeneric ; entry 122
    dw ScriptFetchGeneric ; entry 123
    dw ScriptFetchGeneric ; entry 124
    dw ScriptFetchGeneric ; entry 125
    dw ScriptFetchGeneric ; entry 126
    dw ScriptFetchGeneric ; entry 127
    dw ScriptFetchGeneric2 ; entry 128
    dw ScriptFetch81 ; entry 129
    dw ScriptFetchGeneric2 ; entry 130
    dw ScriptFetch83 ; entry 131
    dw ScriptFetchGeneric2 ; entry 132
    dw ScriptFetchGeneric2 ; entry 133
    dw ScriptFetch86 ; entry 134
    dw ScriptFetchGeneric2 ; entry 135
    dw ScriptFetchGeneric2 ; entry 136
    dw ScriptFetchGeneric2 ; entry 137
    dw ScriptFetchGeneric2 ; entry 138
    dw ScriptFetchGeneric2 ; entry 139
    dw ScriptFetchGeneric2 ; entry 140
    dw ScriptFetchGeneric2 ; entry 141
    dw ScriptFetchGeneric2 ; entry 142
    dw ScriptFetchGeneric2 ; entry 143
    dw ScriptFetchGeneric2 ; entry 144
    dw ScriptFetchGeneric2 ; entry 145
    dw ScriptFetchGeneric2 ; entry 146
    dw ScriptFetchGeneric2 ; entry 147
    dw ScriptFetchGeneric2 ; entry 148
    dw ScriptFetchGeneric2 ; entry 149
    dw ScriptFetchGeneric2 ; entry 150
    dw $0000 ; entry 151
    dw ScriptFetchGeneric2 ; entry 152
    dw ScriptFetchGeneric2 ; entry 153
    dw ScriptFetchGeneric2 ; entry 154
    dw ScriptFetchGeneric2 ; entry 155
    dw ScriptFetchGeneric2 ; entry 156
    dw ScriptFetchGeneric2 ; entry 157
    dw ScriptFetchGeneric2 ; entry 158
    dw ScriptFetchGeneric2 ; entry 159
    dw ScriptFetchGeneric2 ; entry 160
    dw ScriptFetchGeneric2 ; entry 161
    dw $0000 ; entry 162
    dw $0000 ; entry 163
    dw $0000 ; entry 164
    dw $0000 ; entry 165
    dw $0000 ; entry 166
    dw $0000 ; entry 167
    dw $0000 ; entry 168
    dw $0000 ; entry 169
    dw $0000 ; entry 170
    dw $0000 ; entry 171
    dw $0000 ; entry 172
    dw $0000 ; entry 173
    dw $0000 ; entry 174
    dw $0000 ; entry 175
    dw $0000 ; entry 176
    dw $0000 ; entry 177
    dw $0000 ; entry 178
    dw $0000 ; entry 179
    dw $0000 ; entry 180
    dw $0000 ; entry 181
    dw $0000 ; entry 182
    dw $0000 ; entry 183
    dw $0000 ; entry 184
    dw $0000 ; entry 185
    dw $0000 ; entry 186
    dw $0000 ; entry 187
    dw $0000 ; entry 188
    dw $0000 ; entry 189
    dw $0000 ; entry 190
    dw $0000 ; entry 191
    dw ScriptFetchGeneric ; entry 192
    dw ScriptFetchGeneric ; entry 193
    dw ScriptFetchGeneric ; entry 194
    dw ScriptFetchGeneric ; entry 195
    dw ScriptFetchGeneric ; entry 196
    dw ScriptFetchGeneric ; entry 197
    dw ScriptFetchGeneric ; entry 198
    dw ScriptFetchGeneric ; entry 199
    dw ScriptFetchGeneric ; entry 200
    dw ScriptFetchGeneric ; entry 201
    dw ScriptFetchGeneric ; entry 202
    dw ScriptFetchGeneric ; entry 203
    dw ScriptFetchGeneric ; entry 204
    dw ScriptFetchGeneric ; entry 205
    dw ScriptFetchGeneric ; entry 206
    dw ScriptFetchGeneric ; entry 207
    dw $0000 ; entry 208
    dw $0000 ; entry 209
    dw $0000 ; entry 210
    dw $0000 ; entry 211
    dw $0000 ; entry 212
    dw $0000 ; entry 213
    dw $0000 ; entry 214
    dw $0000 ; entry 215
    dw $0000 ; entry 216
    dw $0000 ; entry 217
    dw $0000 ; entry 218
    dw $0000 ; entry 219
    dw $0000 ; entry 220
    dw $0000 ; entry 221
    dw $0000 ; entry 222
    dw $0000 ; entry 223
    dw ScriptFetchE0 ; entry 224
    dw ScriptFetchE1 ; entry 225
    dw ScriptFetchE2 ; entry 226
    dw ScriptFetchE3 ; entry 227
    dw ScriptFetchChoiceJump ; entry 228
    dw ScriptFetchE5 ; entry 229
    dw ScriptFetchE6 ; entry 230
    dw ScriptFetchJumpDataBank ; entry 231
    dw ScriptFetchE8 ; entry 232
    dw ScriptFetchE9 ; entry 233
    dw ScriptFetchMessageUnlessFlag0 ; entry 234
    dw ScriptFetchEB ; entry 235
    dw ScriptFetchEC ; entry 236
    dw ScriptFetchED ; entry 237
    dw ScriptFetchEE ; entry 238
    dw ScriptFetchEF ; entry 239
    dw ScriptFetchF0 ; entry 240
    dw ScriptFetchF1 ; entry 241
    dw ScriptFetchF2 ; entry 242
    dw ScriptFetchF3 ; entry 243
    dw ScriptFetchF4 ; entry 244
    dw ScriptFetchMessageByScreen ; entry 245
    dw ScriptFetchF6 ; entry 246
    dw ScriptFetchF7 ; entry 247
    dw ScriptFetchF8 ; entry 248

; Fetch handler of the opcodes $80, $82, $84, $85, $87-$96 and $98-$A1 (ScriptOpcodeHandlers entries
; 128-161 except 129, 131, 134 and the unused 151): the same code as ScriptFetchGeneric: pops the
; script pointer (just after the opcode), makes the opcode byte wScriptCommandType and calls
; BeginScriptCommand, which clears the command work bytes and stores the pointer. (C2, E-0376)
; the same five instructions as ScriptFetchGeneric, used by 30 opcodes
ScriptFetchGeneric2::
    pop hl
    dec hl
    ld a, [hli]
    ld [wScriptCommandType], a
    call BeginScriptCommand
    ret

SECTION "Bank 10 ScriptFetch81", ROMX

; Fetch handler of opcode $81 (SCRIPT_AREA_ITEM): wScriptCommandType = $81; clears wScriptStep,
; wMessageIndex, wMessageGroup and wMessageState but, unlike BeginScriptCommand, keeps wScriptParam0
; and wScriptParam1; stores the pointer after the opcode in wScriptPointerLo/Hi. (C2, E-0376)
; fetch handler for script opcode 81 (entry 129 of ScriptOpcodeHandlers) (E-0039)
ScriptFetch81::
    pop hl
    ld a, $81
    ld [wScriptCommandType], a
    xor a
    ld [wScriptStep], a
    ld [wMessageIndex], a
    ld [wMessageGroup], a
    ld [wMessageState], a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    ret

SECTION "Bank 10 ScriptFetch83", ROMX

; Fetch handler of opcode $83 (SCRIPT_FIELD_SCENE_01): starts command $83 (BeginScriptCommand), then
; sets wScriptParam1, the variant FieldScene01 runs: 2 when wMapSpriteKind & 3 is not 1, otherwise 3
; when hPlayerStateFlags bit 3 is set, else 1. (C2, E-0376)
; fetch handler for script opcode 83 (entry 131 of ScriptOpcodeHandlers) (E-0039)
ScriptFetch83::
    pop hl
    ld a, $83
    ld [wScriptCommandType], a
    call BeginScriptCommand
    ld a, [wMapSpriteKind]
    and $03
    dec a
    jr nz, .set_script_param1_to_02
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr nz, .set_script_param1_to_03
    ld a, $01
    ld [wScriptParam1], a
    ret

.set_script_param1_to_03:
    ld a, $03
    ld [wScriptParam1], a
    ret

.set_script_param1_to_02:
    ld a, $02
    ld [wScriptParam1], a
    ret

SECTION "Bank 10 ScriptFetch86", ROMX

; Fetch handler of opcode $86 (SCRIPT_KEY_WORLD_DOOR_ITEM): the same code as ScriptFetch81 with type
; $86: clears wScriptStep and the message word and state, keeps wScriptParam0/1 and stores the
; pointer after the opcode. (C2, E-0376)
; fetch handler for script opcode 86 (entry 134 of ScriptOpcodeHandlers) (E-0039)
ScriptFetch86::
    pop hl
    ld a, $86
    ld [wScriptCommandType], a
    xor a
    ld [wScriptStep], a
    ld [wMessageIndex], a
    ld [wMessageGroup], a
    ld [wMessageState], a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    ret

SECTION "Bank 10 ScriptFetchMessage", ROMX

; Fetch handler of opcode $00 (script_message): wScriptCommandType = 1 (the message command,
; ScriptCommand01); wScriptParam0 = the low byte of the message word (the message) and wScriptParam1
; = the high byte (group and box flags), read through ReadWordFromDataBank when wScriptInDataBank is
; set; clears wScriptStep and stores the pointer past the word. wMessageIndex/Group/State are left
; alone. (C2, E-0376)
ScriptFetchMessage::
    pop hl
    ld a, [wScriptInDataBank]
    and a
    jr z, .set_script_command_type_to_01
    ld a, $01
    ld [wScriptCommandType], a
    call ReadWordFromDataBank
    ld a, b
    ld [wScriptParam0], a
    ld a, c
    ld [wScriptParam1], a
    inc hl
    inc hl
    jr .clear_script_step

.set_script_command_type_to_01:
    ld a, $01
    ld [wScriptCommandType], a
    ld a, [hli]
    ld [wScriptParam0], a
    ld a, [hli]
    ld [wScriptParam1], a

.clear_script_step:
    xor a
    ld [wScriptStep], a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    ret

SECTION "Bank 10 ScriptFetchWalk", ROMX

; Fetch handler of opcode $01 (script_walk object, direction, tiles): wScriptCommandType = 2
; (ScriptCommand02, one ScriptStepObject a frame), then ScriptFetch02_ReadOperands: wScriptParam0 =
; object | direction << 4, wScriptParam1 = tiles, wScriptStep = 0, pointer past the three bytes.
; (C2, E-0376)
ScriptFetchWalk::
    ld a, $02
    ld [wScriptCommandType], a
    jr ScriptFetch02_ReadOperands

SECTION "Bank 10 ScriptFetchWalkFast", ROMX

; Fetch handler of opcode $02 (script_walk_fast): wScriptCommandType = 3 (ScriptCommand03 runs
; ScriptStepObject twice a frame) and falls into ScriptFetch02_ReadOperands for the same three
; operands as script_walk. (C2, E-0376)
ScriptFetchWalkFast::
    ld a, $03
    ld [wScriptCommandType], a

; Shared tail of script opcodes 01 and 02 (the caller sets wScriptCommandType 2 or 3): pops the
; script pointer and reads three operand bytes from the current bank (no wScriptInDataBank check):
; wScriptParam0 = byte 0 OR byte 1 with its nibbles swapped, wScriptParam1 = byte 2; clears
; wScriptStep and stores the pointer past them in wScriptPointerLo/wScriptPointerHi. (C2, E-0370;
; probed E-0376)
ScriptFetch02_ReadOperands::
    pop hl
    ld a, [hli]
    ld c, a
    ld a, [hli]
    swap a
    or c
    ld [wScriptParam0], a
    ld a, [hli]
    ld [wScriptParam1], a
    xor a
    ld [wScriptStep], a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    ret

SECTION "Bank 10 ScriptFetchWait", ROMX

; Fetch handler of opcode $03 (script_wait frames): wScriptCommandType = 4 (ScriptWaitFrames);
; wScriptParam0/1 = the 16-bit frame count (low, high); stores the pointer past it. wScriptStep is
; not cleared here. (C2, E-0376)
ScriptFetchWait::
    pop hl
    ld a, $04
    ld [wScriptCommandType], a
    ld a, [hli]
    ld [wScriptParam0], a
    ld a, [hli]
    ld [wScriptParam1], a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    ret

SECTION "Bank 10 ScriptFetchHoldDpad", ROMX

; Fetch handler of opcode $04 (script_hold_dpad direction, frames): wScriptCommandType = 5
; (ScriptCommand05_Run); wScriptParam0 = direction, wScriptParam1 = frames; clears wScriptStep and
; hPlayerTurnDelay; pointer past them. (C2, E-0376)
ScriptFetchHoldDpad::
    pop hl
    ld a, $05
    ld [wScriptCommandType], a
    ld a, [hli]
    ld [wScriptParam0], a
    ld a, [hli]
    ld [wScriptParam1], a
    xor a
    ld [wScriptStep], a
    ldh [hPlayerTurnDelay], a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    ret

SECTION "Bank 10 ScriptFetchFace", ROMX

; Fetch handler of opcode $05 (script_face target, direction): wScriptCommandType = 6
; (ScriptSetDirection); wScriptParam0 = target (0 the player, n follower record n, $80 + n object
; n), wScriptParam1 = direction; pointer past them. wScriptStep is not cleared here. (C2, E-0376)
ScriptFetchFace::
    pop hl
    ld a, $06
    ld [wScriptCommandType], a
    ld a, [hli]
    ld [wScriptParam0], a
    ld a, [hli]
    ld [wScriptParam1], a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    ret

SECTION "Bank 10 CopyCBytesToVRAMWaitSTAT_Bank10", ROMX

; Copies C bytes from HL to DE (both advance, C ends 0), waiting before each byte until rSTAT bit 1
; is clear so VRAM can be written. A bank $10 copy of CopyCBytesToVRAMWaitSTAT; its only caller is
; ScriptFetchSkipIfNo. (C1, E-0376)
; the same 13 bytes as CopyCBytesToVRAMWaitSTAT (CopyCBytesToVRAMWaitSTAT) (E-0090)
CopyCBytesToVRAMWaitSTAT_Bank10::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, CopyCBytesToVRAMWaitSTAT_Bank10
    ld a, [hli]
    ld [de], a
    inc de
    dec c
    jr nz, CopyCBytesToVRAMWaitSTAT_Bank10
    ret

SECTION "Bank 10 ScriptFetchSkipIfNo", ROMX

; Fetch handler of opcode $06 (script_skip_if_no offset): first copies the two saved tiles
; wScriptTileBuf0 and wScriptTileBuf1 to VRAM $8EE0 and $8EF0 (CopyCBytesToVRAMWaitSTAT_Bank10);
; then, when wTextYesNoResult is 0, adds the offset byte to the pointer past it (a forward jump),
; otherwise just steps over the offset (read through ReadWordFromDataBank in data-bank mode); stores
; the pointer and fetches the next opcode at once. (C1, E-0376)
ScriptFetchSkipIfNo::
    push bc
    push de
    ld hl, wScriptTileBuf0
    ld de, vTiles1 + $6e0
    ld c, $10
    call CopyCBytesToVRAMWaitSTAT_Bank10
    ld hl, wScriptTileBuf1
    ld de, vTiles1 + $6f0
    ld c, $10
    call CopyCBytesToVRAMWaitSTAT_Bank10
    pop de
    pop bc
    pop hl
    ld a, [wScriptInDataBank]
    and a
    jr z, .check_text_yes_no_result
    ld a, [wTextYesNoResult]
    or a
    jr nz, .next
    call ReadWordFromDataBank
    inc hl
    ld a, b
    add l
    ld l, a
    jr nc, .set_script_pointer_lo
    inc h

.set_script_pointer_lo:
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    jp FetchScriptCommand_NextOpcode

.next:
    inc hl
    jr .set_script_pointer_lo

.check_text_yes_no_result:
    ld a, [wTextYesNoResult]
    or a
    jr nz, .set_script_pointer_lo2
    ld a, [hli]
    add_a_to_hl
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    jp FetchScriptCommand_NextOpcode

.set_script_pointer_lo2:
    inc hl
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    jp FetchScriptCommand_NextOpcode

SECTION "Bank 10 ScriptFetchJump", ROMX

; Fetch handler of opcode $07 (script_jump address): sets wScriptPointerLo/Hi to the word after the
; opcode (read through ReadWordFromDataBank in data-bank mode) and fetches the opcode there at once.
; (C2, E-0376)
ScriptFetchJump::
    pop hl
    ld a, [wScriptInDataBank]
    and a
    jr z, .set_script_pointer_lo
    call ReadWordFromDataBank
    ld a, b
    ld [wScriptPointerLo], a
    ld a, c
    ld [wScriptPointerHi], a
    inc hl
    jp FetchScriptCommand_NextOpcode

.set_script_pointer_lo:
    ld a, [hli]
    ld [wScriptPointerLo], a
    ld a, [hl]
    ld [wScriptPointerHi], a
    jp FetchScriptCommand_NextOpcode

SECTION "Bank 10 ScriptFetchSetFlag", ROMX

; Fetch handler of opcode $0A (script_set_flag flag): reads the flag word, stores the pointer past
; it, sets that story flag (SetFlagBit) and fetches the next opcode at once. It reads the operand
; from the mapped bank even in data-bank mode. (C2, E-0376)
ScriptFetchSetFlag::
    pop hl
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    call SetFlagBit
    jp FetchScriptCommand_NextOpcode

SECTION "Bank 10 ScriptFetchSlideY", ROMX

; Fetch handler of opcode $0B (script_slide_y target): wScriptCommandType = $0C
; (ScriptSlideObjectY); wScriptParam1 = target, wScriptParam0 = 0; pointer past it. wScriptStep is
; not cleared here. (C2, E-0376)
ScriptFetchSlideY::
    pop hl
    ld a, $0c
    ld [wScriptCommandType], a
    ld a, [hli]
    ld [wScriptParam1], a
    xor a
    ld [wScriptParam0], a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    ret

SECTION "Bank 10 ScriptFetchHideObject", ROMX

; Fetch handler of opcode $0C (script_hide_object n): writes $E0 to byte $C (the Y) of sprite slot n
; (wSpriteSlots + $C + 16 n), stores the pointer past n and fetches the next opcode at once. (C2,
; E-0376)
ScriptFetchHideObject::
    pop hl
    ld a, [hli]
    swap a
    ld de, wSpriteSlots + $c
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, $e0
    ld [de], a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    jp FetchScriptCommand_NextOpcode

SECTION "Bank 10 ScriptFetchEncounter", ROMX

; Fetch handler of opcode $0D (script_encounter n): wScriptCommandType = $0E (ScriptCommand0E_Run);
; wScriptParam0 = n (the ScriptedEncounterTable record); clears wScriptStep; pointer past it. (C2,
; E-0376)
ScriptFetchEncounter::
    pop hl
    ld a, $0e
    ld [wScriptCommandType], a
    ld a, [hli]
    ld [wScriptParam0], a
    xor a
    ld [wScriptStep], a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    ret

SECTION "Bank 10 ScriptFetchAddGold", ROMX

; Fetch handler of opcode $0E (script_add_gold amount): hTemp0/hTemp1 = the amount word, stores the
; pointer past it, adds it to the gold (AddGoldCapped, capped at 99,999) and fetches the next opcode
; at once. (C2, E-0376)
ScriptFetchAddGold::
    pop hl
    ld a, [hli]
    ldh [hTemp0], a
    ld a, [hli]
    ldh [hTemp1], a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    farcall AddGoldCapped
    jp FetchScriptCommand_NextOpcode

SECTION "Bank 10 ScriptFetchSound", ROMX

; Fetch handler of opcode $0F (script_sound id): stores the pointer past the id; $FF restarts the
; map music (RestartMapMusic), ids below $60 are queued as music (QueueMusic), the rest as sound
; effects (QueueSoundEffect); then fetches the next opcode at once. (C1, E-0376)
ScriptFetchSound::
    pop hl
    ld a, [hli]
    push af
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    pop af
    cp $ff
    jr z, .call_restart_map_music
    cp $60
    jr c, .call_queue_music
    call QueueSoundEffect
    jp FetchScriptCommand_NextOpcode

.call_queue_music:
    call QueueMusic
    jp FetchScriptCommand_NextOpcode

.call_restart_map_music:
    farcall RestartMapMusic
    jp FetchScriptCommand_NextOpcode

SECTION "Bank 10 ScriptFetchGeneric", ROMX

; Fetch handler of 123 opcodes ($11-$7F except $1C, $1D, $23 and $62, and $C0-$CF): pops the pointer
; just after the opcode, makes the opcode byte wScriptCommandType and calls BeginScriptCommand; the
; command reads its own arguments from the script. (C2, E-0376)
; fetch handler shared by 123 opcodes: wScriptCommandType = the opcode byte, then BeginScriptCommand
; with the pointer just after it; the command reads its own arguments from the script
ScriptFetchGeneric::
    pop hl
    dec hl
    ld a, [hli]
    ld [wScriptCommandType], a
    call BeginScriptCommand
    ret

SECTION "Bank 10 ScriptFetch1C", ROMX

; Fetch handler of opcode $1C (SCRIPT_SCENE_WARUBOU_WARNING): turns the first follower away from the
; facing of the player ((hPlayerFacing + 2) & 3), starts command $1C (BeginScriptCommand), then
; starts message $0088 (Tara: 'Oh, wow. This is terrible.'), or the Cobi line $0087 when
; EVENT_NEVER_SET is set, through wMessageIndex/wMessageGroup and wMessageState = 0. (C2, E-0376)
; fetch handler for script opcode 1C (entry 28 of ScriptOpcodeHandlers) (E-0039)
ScriptFetch1C::
    pop hl
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and $03
    ld [wFollowerRecords], a
    ld a, $1c
    ld [wScriptCommandType], a
    call BeginScriptCommand
    ld de, EVENT_NEVER_SET
    call TestFlagBit
    jr c, .set_message_index
    ld hl, $0088
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    xor a
    ld [wMessageState], a
    ret

.set_message_index:
    ld hl, $0087
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    xor a
    ld [wMessageState], a
    ret

SECTION "Bank 10 ScriptFetch1D", ROMX

; Fetch handler of opcode $1D (SCRIPT_SCENE_LONG_FACES): starts command $1D (BeginScriptCommand),
; then message $0097 kept open (MSG_KEEP_OPEN), the question SceneLongFaces_Answer answers, or the
; Cobi line $008D when EVENT_NEVER_SET is set. (C2, E-0376)
; fetch handler for script opcode 1D (entry 29 of ScriptOpcodeHandlers) (E-0039)
ScriptFetch1D::
    pop hl
    ld a, $1d
    ld [wScriptCommandType], a
    call BeginScriptCommand
    ld de, EVENT_NEVER_SET
    call TestFlagBit
    jr c, .set_message_index
    ld hl, MSG_KEEP_OPEN | $0097
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    xor a
    ld [wMessageState], a
    ret

.set_message_index:
    ld hl, MSG_KEEP_OPEN | $008d
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    xor a
    ld [wMessageState], a
    ret

SECTION "Bank 10 ScriptFetch23", ROMX

; Fetch handler of opcode $23 (SCRIPT_SCENE_WATER_SHORTAGE): sets bit 2 of story byte $61 and starts
; command $23 (BeginScriptCommand). (C2, E-0376)
; fetch handler for script opcode 23 (entry 35 of ScriptOpcodeHandlers) (E-0039)
ScriptFetch23::
    pop hl
    ld a, [wStoryFlags + $61]
    set 2, a
    ld [wStoryFlags + $61], a
    ld a, $23
    ld [wScriptCommandType], a
    call BeginScriptCommand
    ret

SECTION "Bank 10 ScriptFetch62", ROMX

; Fetch handler of opcode $62 (SCRIPT_PERSONALITY_MESSAGE): starts the command of the opcode byte
; like ScriptFetchGeneric but saves wScriptParam1 around BeginScriptCommand, so the value set before
; the fetch survives. (C2, E-0376)
; fetch handler for script opcode 62 (entry 98 of ScriptOpcodeHandlers) (E-0039)
ScriptFetch62::
    pop hl
    dec hl
    ld a, [hli]
    ld [wScriptCommandType], a
    ld a, [wScriptParam1]
    push af
    call BeginScriptCommand
    pop af
    ld [wScriptParam1], a
    ret

SECTION "Bank 10 ScriptFetchE0", ROMX

; Fetch handler of opcode $E0 (SCRIPT_INN): wScriptCommandType = $E0 and BeginScriptCommand with the
; pointer after the opcode (work bytes cleared); ScriptCommandE0 then runs InnMenu each frame. (C2,
; E-0376)
; fetch handler for script opcode E0 (entry 224 of ScriptOpcodeHandlers) (E-0039)
ScriptFetchE0::
    pop hl
    ld a, $e0
    ld [wScriptCommandType], a
    call BeginScriptCommand
    ret

SECTION "Bank 10 ScriptFetchE1", ROMX

; Fetch handler of opcode $E1 (SCRIPT_INN_CLOSE): wScriptCommandType = $E1 and BeginScriptCommand
; with the pointer after the opcode (work bytes cleared); ScriptCommandE1 then runs CloseInnMenu
; each frame. (C2, E-0376)
; fetch handler for script opcode E1 (entry 225 of ScriptOpcodeHandlers) (E-0039)
ScriptFetchE1::
    pop hl
    ld a, $e1
    ld [wScriptCommandType], a
    call BeginScriptCommand
    ret

SECTION "Bank 10 ScriptFetchE2", ROMX

; Fetch handler of opcode $E2 (SCRIPT_SHOP): wScriptCommandType = $E2 and BeginScriptCommand with
; the pointer after the opcode (work bytes cleared); ScriptCommandE2 then runs ShopMenu each frame.
; (C2, E-0376)
; fetch handler for script opcode E2 (entry 226 of ScriptOpcodeHandlers) (E-0039)
ScriptFetchE2::
    pop hl
    ld a, $e2
    ld [wScriptCommandType], a
    call BeginScriptCommand
    ret

SECTION "Bank 10 ScriptFetchE3", ROMX

; Fetch handler of opcode $E3 (SCRIPT_SHOP_CLOSE): wScriptCommandType = $E3 and BeginScriptCommand
; with the pointer after the opcode (work bytes cleared); ScriptCommandE3 then runs CloseShopMenu
; each frame. (C2, E-0376)
; fetch handler for script opcode E3 (entry 227 of ScriptOpcodeHandlers) (E-0039)
ScriptFetchE3::
    pop hl
    ld a, $e3
    ld [wScriptCommandType], a
    call BeginScriptCommand
    ret

SECTION "Bank 10 ScriptFetchE5", ROMX

; Fetch handler of opcode $E5 (SCRIPT_VAULT): wScriptCommandType = $E5 and BeginScriptCommand with
; the pointer after the opcode (work bytes cleared); ScriptCommandE5 then runs VaultMenu each frame.
; (C2, E-0376)
; fetch handler for script opcode E5 (entry 229 of ScriptOpcodeHandlers) (E-0039)
ScriptFetchE5::
    pop hl
    ld a, $e5
    ld [wScriptCommandType], a
    call BeginScriptCommand
    ret

SECTION "Bank 10 ScriptFetchE6", ROMX

; Fetch handler of opcode $E6 (SCRIPT_VAULT_CLOSE): wScriptCommandType = $E6 and BeginScriptCommand
; with the pointer after the opcode (work bytes cleared); ScriptCommandE6 then runs CloseVaultMenu
; each frame. (C2, E-0376)
; fetch handler for script opcode E6 (entry 230 of ScriptOpcodeHandlers) (E-0039)
ScriptFetchE6::
    pop hl
    ld a, $e6
    ld [wScriptCommandType], a
    call BeginScriptCommand
    ret

SECTION "Bank 10 ScriptFetchE8", ROMX

; Fetch handler of opcode $E8 (SCRIPT_SWAP_MONSTERS): wScriptCommandType = $E8 and
; BeginScriptCommand with the pointer after the opcode (work bytes cleared); ScriptCommandE8 then
; runs SwapMonstersMenu each frame. (C2, E-0376)
; fetch handler for script opcode E8 (entry 232 of ScriptOpcodeHandlers) (E-0039)
ScriptFetchE8::
    pop hl
    ld a, $e8
    ld [wScriptCommandType], a
    call BeginScriptCommand
    ret

SECTION "Bank 10 ScriptFetchE9", ROMX

; Fetch handler of opcode $E9 (SCRIPT_MENU_CLOSE): wScriptCommandType = $E9 and BeginScriptCommand
; with the pointer after the opcode (work bytes cleared); ScriptCommandE9 then runs CloseMenuE9 each
; frame. (C2, E-0376)
; fetch handler for script opcode E9 (entry 233 of ScriptOpcodeHandlers) (E-0039)
ScriptFetchE9::
    pop hl
    ld a, $e9
    ld [wScriptCommandType], a
    call BeginScriptCommand
    ret

SECTION "Bank 10 ScriptFetchEB", ROMX

; Fetch handler of opcode $EB (SCRIPT_HIBERNATE): wScriptCommandType = $EB and BeginScriptCommand
; with the pointer after the opcode (work bytes cleared); ScriptCommandEB then runs HibernateMenu
; each frame. (C2, E-0376)
; fetch handler for script opcode EB (entry 235 of ScriptOpcodeHandlers) (E-0039)
ScriptFetchEB::
    pop hl
    ld a, $eb
    ld [wScriptCommandType], a
    call BeginScriptCommand
    ret

SECTION "Bank 10 ScriptFetchEC", ROMX

; Fetch handler of opcode $EC (SCRIPT_HIBERNATE_CLOSE): wScriptCommandType = $EC and
; BeginScriptCommand with the pointer after the opcode (work bytes cleared); ScriptCommandEC then
; runs CloseHibernateMenu each frame. (C2, E-0376)
; fetch handler for script opcode EC (entry 236 of ScriptOpcodeHandlers) (E-0039)
ScriptFetchEC::
    pop hl
    ld a, $ec
    ld [wScriptCommandType], a
    call BeginScriptCommand
    ret

SECTION "Bank 10 ScriptFetchED", ROMX

; Fetch handler of opcode $ED (SCRIPT_BREED): wScriptCommandType = $ED and BeginScriptCommand with
; the pointer after the opcode (work bytes cleared); ScriptCommandED then runs BreedMenu each frame.
; (C2, E-0376)
; fetch handler for script opcode ED (entry 237 of ScriptOpcodeHandlers) (E-0039)
ScriptFetchED::
    pop hl
    ld a, $ed
    ld [wScriptCommandType], a
    call BeginScriptCommand
    ret

SECTION "Bank 10 ScriptFetchEE", ROMX

; Fetch handler of opcode $EE (SCRIPT_BREED_CLOSE): wScriptCommandType = $EE and BeginScriptCommand
; with the pointer after the opcode (work bytes cleared); ScriptCommandEE then runs CloseBreedMenu
; each frame. (C2, E-0376)
; fetch handler for script opcode EE (entry 238 of ScriptOpcodeHandlers) (E-0039)
ScriptFetchEE::
    pop hl
    ld a, $ee
    ld [wScriptCommandType], a
    call BeginScriptCommand
    ret

SECTION "Bank 10 ScriptFetchEF", ROMX

; Fetch handler of opcode $EF (SCRIPT_EGG_SERVICE): wScriptCommandType = $EF and BeginScriptCommand
; with the pointer after the opcode (work bytes cleared); ScriptCommandEF then runs EggServiceMenu
; each frame. (C2, E-0376)
; fetch handler for script opcode EF (entry 239 of ScriptOpcodeHandlers) (E-0039)
ScriptFetchEF::
    pop hl
    ld a, $ef
    ld [wScriptCommandType], a
    call BeginScriptCommand
    ret

SECTION "Bank 10 ScriptFetchF0", ROMX

; Fetch handler of opcode $F0 (SCRIPT_RENAME): wScriptCommandType = $F0 and BeginScriptCommand with
; the pointer after the opcode (work bytes cleared); ScriptCommandF0 then runs RenameMenu each
; frame. (C2, E-0376)
; fetch handler for script opcode F0 (entry 240 of ScriptOpcodeHandlers) (E-0039)
ScriptFetchF0::
    pop hl
    ld a, $f0
    ld [wScriptCommandType], a
    call BeginScriptCommand
    ret

SECTION "Bank 10 ScriptFetchF1", ROMX

; Fetch handler of opcode $F1 (SCRIPT_RENAME_CLOSE): wScriptCommandType = $F1 and BeginScriptCommand
; with the pointer after the opcode (work bytes cleared); ScriptCommandF1 then runs CloseRenameMenu
; each frame. (C2, E-0376)
; fetch handler for script opcode F1 (entry 241 of ScriptOpcodeHandlers) (E-0039)
ScriptFetchF1::
    pop hl
    ld a, $f1
    ld [wScriptCommandType], a
    call BeginScriptCommand
    ret

SECTION "Bank 10 ScriptFetchF2", ROMX

; Fetch handler of opcode $F2 (SCRIPT_KEY_APPRAISAL): wScriptCommandType = $F2 and
; BeginScriptCommand with the pointer after the opcode (work bytes cleared); ScriptCommandF2 then
; runs KeyAppraisalMenu each frame. (C2, E-0376)
; fetch handler for script opcode F2 (entry 242 of ScriptOpcodeHandlers) (E-0039)
ScriptFetchF2::
    pop hl
    ld a, $f2
    ld [wScriptCommandType], a
    call BeginScriptCommand
    ret

SECTION "Bank 10 ScriptFetchF3", ROMX

; Fetch handler of opcode $F3 (SCRIPT_MEDAL_PRIZES): wScriptCommandType = $F3 and BeginScriptCommand
; with the pointer after the opcode (work bytes cleared); ScriptCommandF3 then runs MedalPrizeMenu
; each frame. (C2, E-0376)
; fetch handler for script opcode F3 (entry 243 of ScriptOpcodeHandlers) (E-0039)
ScriptFetchF3::
    pop hl
    ld a, $f3
    ld [wScriptCommandType], a
    call BeginScriptCommand
    ret

SECTION "Bank 10 ScriptFetchF4", ROMX

; Fetch handler of opcode $F4 (SCRIPT_NPC_BREED): wScriptCommandType = $F4 and BeginScriptCommand
; with the pointer after the opcode (work bytes cleared); ScriptCommandF4 then runs NpcBreedMenu
; each frame. (C2, E-0376)
; fetch handler for script opcode F4 (entry 244 of ScriptOpcodeHandlers) (E-0039)
ScriptFetchF4::
    pop hl
    ld a, $f4
    ld [wScriptCommandType], a
    call BeginScriptCommand
    ret

SECTION "Bank 10 ScriptFetchMessageByScreen", ROMX

; Fetch handler of opcode $F5 (script_message_by_screen): command type 1 (the message command);
; wScriptParam0/1 = the message word (through ReadWordFromDataBank in data-bank mode), then
; wScriptParam0 += 16 * wScreenTableIndex as a byte (no carry into the group); clears wScriptStep;
; pointer past the word. (C2, E-0376)
ScriptFetchMessageByScreen::
    pop hl
    ld a, [wScriptInDataBank]
    and a
    jr z, .set_script_command_type_to_01
    ld a, $01
    ld [wScriptCommandType], a
    call ReadWordFromDataBank
    ld a, b
    ld [wScriptParam0], a
    ld a, c
    ld [wScriptParam1], a
    inc hl
    inc hl
    jr .read_screen_table_index

.set_script_command_type_to_01:
    ld a, $01
    ld [wScriptCommandType], a
    ld a, [hli]
    ld [wScriptParam0], a
    ld a, [hli]
    ld [wScriptParam1], a

.read_screen_table_index:
    push hl
    ld a, [wScreenTableIndex]
    add a
    add a
    add a
    add a
    ld b, a
    ld a, [wScriptParam0]
    add b
    ld [wScriptParam0], a
    pop hl
    xor a
    ld [wScriptStep], a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    ret

SECTION "Bank 10 ScriptFetchF6", ROMX

; Fetch handler of opcode $F6 (SCRIPT_LIBRARY): wScriptCommandType = $F6 and BeginScriptCommand with
; the pointer after the opcode (work bytes cleared); ScriptCommandF6 then runs LibraryMenu each
; frame. (C2, E-0376)
; fetch handler for script opcode F6 (entry 246 of ScriptOpcodeHandlers) (E-0039)
ScriptFetchF6::
    pop hl
    ld a, $f6
    ld [wScriptCommandType], a
    call BeginScriptCommand
    ret

SECTION "Bank 10 ScriptFetchF7", ROMX

; Fetch handler of opcode $F7 (SCRIPT_ARENA): wScriptCommandType = $F7 and BeginScriptCommand with
; the pointer after the opcode (work bytes cleared); ScriptCommandF7 then runs ArenaMenu each frame.
; (C2, E-0376)
; fetch handler for script opcode F7 (entry 247 of ScriptOpcodeHandlers) (E-0039)
ScriptFetchF7::
    pop hl
    ld a, $f7
    ld [wScriptCommandType], a
    call BeginScriptCommand
    ret

SECTION "Bank 10 ScriptFetchF8", ROMX

; Fetch handler of opcode $F8 (SCRIPT_PRIEST): wScriptCommandType = $F8 and BeginScriptCommand with
; the pointer after the opcode (work bytes cleared); ScriptCommandF8 then runs PriestMenu each
; frame. (C2, E-0376)
; fetch handler for script opcode F8 (entry 248 of ScriptOpcodeHandlers) (E-0039)
ScriptFetchF8::
    pop hl
    ld a, $f8
    ld [wScriptCommandType], a
    call BeginScriptCommand
    ret

SECTION "Bank 10 ScriptFetchMessageUnlessFlag0", ROMX

; Fetch handler of opcode $EA (script_message_unless_flag0): command type 1 (the message command);
; wScriptParam0/1 = the message word (through ReadWordFromDataBank in data-bank mode), and
; wScriptParam0 += $20 (a byte add) unless EVENT_NEVER_SET is set; clears wScriptStep; pointer past
; the word. (C2, E-0376)
ScriptFetchMessageUnlessFlag0::
    pop hl
    ld a, [wScriptInDataBank]
    and a
    jr z, .set_script_command_type_to_01
    ld a, $01
    ld [wScriptCommandType], a
    call ReadWordFromDataBank
    ld a, b
    ld [wScriptParam0], a
    ld a, c
    ld [wScriptParam1], a
    inc hl
    inc hl
    jr .call_test_flag_bit

.set_script_command_type_to_01:
    ld a, $01
    ld [wScriptCommandType], a
    ld a, [hli]
    ld [wScriptParam0], a
    ld a, [hli]
    ld [wScriptParam1], a

.call_test_flag_bit:
    push hl
    ld de, EVENT_NEVER_SET
    call TestFlagBit
    jr c, .clear_script_step
    ld a, [wScriptParam0]
    add $20
    ld [wScriptParam0], a

.clear_script_step:
    pop hl
    xor a
    ld [wScriptStep], a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    ret

SECTION "Bank 10 ScriptFetchJumpDataBank", ROMX

; Fetch handler of opcode $E7 (script_jump_data_bank address): sets wScriptInDataBank = 1, makes the
; word after the opcode (read from the mapped bank) the script pointer and fetches the opcode there
; at once, from now on from the bank in wDataBank. (C2, E-0376)
ScriptFetchJumpDataBank::
    pop hl
    ld a, $01
    ld [wScriptInDataBank], a
    ld a, [hli]
    ld c, a
    ld a, [hl]
    ld h, a
    ld l, c
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    jp FetchScriptCommand_NextOpcode

SECTION "Bank 10 ScriptFetchChoiceJump", ROMX

; Fetch handler of opcode $E4 (script_choice_jump offsets): skips wTwoChoiceCursor offset bytes,
; reads the chosen offset (through ReadWordFromDataBank in data-bank mode) and sets
; wScriptPointerLo/Hi to the byte after it plus the offset; then fetches the opcode there at once.
; (C2, E-0376)
ScriptFetchChoiceJump::
    pop hl
    ld a, [wTwoChoiceCursor]
    ld c, a

.skip:
    ld a, c
    and a
    jr z, .check_script_in_data_bank
    inc hl
    dec c
    jr .skip

.check_script_in_data_bank:
    ld a, [wScriptInDataBank]
    and a
    jr z, .skip2
    call ReadWordFromDataBank
    inc hl
    ld a, b
    add_a_to_hl
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    jp FetchScriptCommand_NextOpcode

.skip2:
    ld a, [hli]
    add_a_to_hl
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    jp FetchScriptCommand_NextOpcode

SECTION "Bank 10 BeginScriptCommand", ROMX

; HL = script pointer: clears wScriptParam0, wScriptParam1, wScriptStep, wMessageIndex,
; wMessageGroup and wMessageState and stores HL in wScriptPointerLo/Hi. Called only by the fetch
; handlers of bank $10 (28 sites) to begin a command, with HL just after its opcode; it does not set
; wScriptStartRequest or start a script. (C2, E-0376)
; HL = script address: clears wScriptParam0-wMessageState (parameters and step) and stores HL in
; wScriptPointer; the script is run by RunEventScriptFrame (28 call sites)
BeginScriptCommand::
    xor a
    ld [wScriptParam0], a
    ld [wScriptParam1], a
    ld [wScriptStep], a
    ld [wMessageIndex], a
    ld [wMessageGroup], a
    ld [wMessageState], a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    ret

SECTION "Bank 10 ExecuteScriptCommand", ROMX

; Does nothing during a fade (wFadeState non-zero) or while wScriptCommandType is 0; otherwise jumps
; through ScriptCommandHandlers[wScriptCommandType - 1] to run one frame of the current command.
; Called by RunEventScriptFrame. (C2, E-0376)
; does nothing during a fade or while wScriptCommandType is 0; otherwise jumps through
; ScriptCommandHandlers[wScriptCommandType - 1] to run one frame of the current command
ExecuteScriptCommand::
    ld a, [wFadeState]
    or a
    ret nz
    ld a, [wScriptCommandType]
    or a
    ret z
    dec a
    jumptable

; ExecuteScriptCommand indexes it with wScriptCommandType - 1; command types are set by the fetch
; handlers of FetchScriptCommand; a zero word is an unused type; all 248 words are code pointers
; inside the bank and the table ends where the next bytes stop being pointers (E-0038, C1)
; record: handler that runs one frame of script command type (index + 1)
ScriptCommandHandlers::
    dw ScriptCommand01 ; entry 0
    dw ScriptCommand02 ; entry 1
    dw ScriptCommand03 ; entry 2
    dw ScriptCommand04 ; entry 3
    dw ScriptCommand05 ; entry 4
    dw ScriptCommand06 ; entry 5
    dw $0000 ; entry 6
    dw $0000 ; entry 7
    dw ScriptCommand09 ; entry 8
    dw ScriptCommand0A ; entry 9
    dw $0000 ; entry 10
    dw ScriptCommand0C ; entry 11
    dw $0000 ; entry 12
    dw ScriptCommand0E ; entry 13
    dw $0000 ; entry 14
    dw $0000 ; entry 15
    dw ScriptCommand11 ; entry 16
    dw ScriptCommand12 ; entry 17
    dw ScriptCommand13 ; entry 18
    dw ScriptCommand14 ; entry 19
    dw ScriptCommand15 ; entry 20
    dw ScriptCommand16 ; entry 21
    dw ScriptCommand17 ; entry 22
    dw ScriptCommand18 ; entry 23
    dw ScriptCommand19 ; entry 24
    dw ScriptCommand1A ; entry 25
    dw ScriptCommand1B ; entry 26
    dw ScriptCommand1C ; entry 27
    dw ScriptCommand1D ; entry 28
    dw ScriptCommand1E ; entry 29
    dw ScriptCommand1F ; entry 30
    dw ScriptCommand20 ; entry 31
    dw ScriptCommand21 ; entry 32
    dw ScriptCommand22 ; entry 33
    dw ScriptCommand23 ; entry 34
    dw ScriptCommand24 ; entry 35
    dw ScriptCommand25 ; entry 36
    dw ScriptCommand26 ; entry 37
    dw ScriptCommand27 ; entry 38
    dw ScriptCommand28 ; entry 39
    dw ScriptCommand29 ; entry 40
    dw ScriptCommand2A ; entry 41
    dw ScriptCommand2B ; entry 42
    dw ScriptCommand2C ; entry 43
    dw ScriptCommand2D ; entry 44
    dw ScriptCommand2E ; entry 45
    dw ScriptCommand2F ; entry 46
    dw ScriptCommand30 ; entry 47
    dw ScriptCommand31 ; entry 48
    dw ScriptCommand32 ; entry 49
    dw ScriptCommand33 ; entry 50
    dw ScriptCommand34 ; entry 51
    dw ScriptCommand35 ; entry 52
    dw ScriptCommand36 ; entry 53
    dw ScriptCommand37 ; entry 54
    dw ScriptCommand38 ; entry 55
    dw ScriptCommand39 ; entry 56
    dw ScriptCommand3A ; entry 57
    dw ScriptCommand3B ; entry 58
    dw ScriptCommand3C ; entry 59
    dw ScriptCommand3D ; entry 60
    dw ScriptCommand3E ; entry 61
    dw ScriptCommand3F ; entry 62
    dw ScriptCommand40 ; entry 63
    dw ScriptCommand41 ; entry 64
    dw ScriptCommand42 ; entry 65
    dw ScriptCommand43 ; entry 66
    dw ScriptCommand44 ; entry 67
    dw ScriptCommand45 ; entry 68
    dw ScriptCommand46 ; entry 69
    dw ScriptCommand47 ; entry 70
    dw ScriptCommand48 ; entry 71
    dw ScriptCommand49 ; entry 72
    dw ScriptCommand4A ; entry 73
    dw ScriptCommand4B ; entry 74
    dw ScriptCommand4C ; entry 75
    dw ScriptCommand4D ; entry 76
    dw ScriptCommand4E ; entry 77
    dw ScriptCommand4F ; entry 78
    dw ScriptCommand50 ; entry 79
    dw ScriptCommand51 ; entry 80
    dw ScriptCommand52 ; entry 81
    dw ScriptCommand53 ; entry 82
    dw ScriptCommand54 ; entry 83
    dw ScriptCommand55 ; entry 84
    dw ScriptCommand56 ; entry 85
    dw ScriptCommand57 ; entry 86
    dw ScriptCommand58 ; entry 87
    dw ScriptCommand59 ; entry 88
    dw ScriptCommand5A ; entry 89
    dw ScriptCommand5B ; entry 90
    dw ScriptCommand5C ; entry 91
    dw ScriptCommand5D ; entry 92
    dw ScriptCommand5E ; entry 93
    dw ScriptCommand5F ; entry 94
    dw ScriptCommand60 ; entry 95
    dw ScriptCommand61 ; entry 96
    dw ScriptCommand62 ; entry 97
    dw ScriptCommand63 ; entry 98
    dw ScriptCommand64 ; entry 99
    dw ScriptCommand65 ; entry 100
    dw ScriptCommand66 ; entry 101
    dw ScriptCommand67 ; entry 102
    dw ScriptCommand68 ; entry 103
    dw ScriptCommand69 ; entry 104
    dw ScriptCommand6A ; entry 105
    dw ScriptCommand6B ; entry 106
    dw ScriptCommand6C ; entry 107
    dw ScriptCommand6D ; entry 108
    dw ScriptCommand6E ; entry 109
    dw ScriptCommand6F ; entry 110
    dw ScriptCommand70 ; entry 111
    dw ScriptCommand71 ; entry 112
    dw ScriptCommand72 ; entry 113
    dw ScriptCommand73 ; entry 114
    dw ScriptCommand74 ; entry 115
    dw ScriptCommand75 ; entry 116
    dw ScriptCommand76 ; entry 117
    dw ScriptCommand77 ; entry 118
    dw ScriptCommand78 ; entry 119
    dw ScriptCommand79 ; entry 120
    dw ScriptCommand7A ; entry 121
    dw ScriptCommand7B ; entry 122
    dw ScriptCommand7C ; entry 123
    dw ScriptCommand7D ; entry 124
    dw ScriptCommand7E ; entry 125
    dw ScriptCommand7F ; entry 126
    dw ScriptCommand80 ; entry 127
    dw ScriptCommand81 ; entry 128
    dw ScriptCommand82 ; entry 129
    dw ScriptCommand83 ; entry 130
    dw ScriptCommand84 ; entry 131
    dw ScriptCommand85 ; entry 132
    dw ScriptCommand86 ; entry 133
    dw ScriptCommand87 ; entry 134
    dw ScriptCommand88 ; entry 135
    dw ScriptCommand89 ; entry 136
    dw ScriptCommand8A ; entry 137
    dw ScriptCommand8B ; entry 138
    dw ScriptCommand8C ; entry 139
    dw ScriptCommand8D ; entry 140
    dw ScriptCommand8E ; entry 141
    dw ScriptCommand8F ; entry 142
    dw ScriptCommand90 ; entry 143
    dw ScriptCommand91 ; entry 144
    dw ScriptCommand92 ; entry 145
    dw ScriptCommand93 ; entry 146
    dw ScriptCommand94 ; entry 147
    dw ScriptCommand95 ; entry 148
    dw ScriptCommand96 ; entry 149
    dw $0000 ; entry 150
    dw ScriptCommand98 ; entry 151
    dw ScriptCommand99 ; entry 152
    dw ScriptCommand9A ; entry 153
    dw ScriptCommand9B ; entry 154
    dw ScriptCommand9C ; entry 155
    dw ScriptCommand9D ; entry 156
    dw ScriptCommand9E ; entry 157
    dw ScriptCommand9F ; entry 158
    dw ScriptCommandA0 ; entry 159
    dw ScriptCommandA1 ; entry 160
    dw $0000 ; entry 161
    dw $0000 ; entry 162
    dw $0000 ; entry 163
    dw $0000 ; entry 164
    dw $0000 ; entry 165
    dw $0000 ; entry 166
    dw $0000 ; entry 167
    dw $0000 ; entry 168
    dw $0000 ; entry 169
    dw $0000 ; entry 170
    dw $0000 ; entry 171
    dw $0000 ; entry 172
    dw $0000 ; entry 173
    dw $0000 ; entry 174
    dw $0000 ; entry 175
    dw $0000 ; entry 176
    dw $0000 ; entry 177
    dw $0000 ; entry 178
    dw $0000 ; entry 179
    dw $0000 ; entry 180
    dw $0000 ; entry 181
    dw $0000 ; entry 182
    dw $0000 ; entry 183
    dw $0000 ; entry 184
    dw $0000 ; entry 185
    dw $0000 ; entry 186
    dw $0000 ; entry 187
    dw $0000 ; entry 188
    dw $0000 ; entry 189
    dw $0000 ; entry 190
    dw ScriptCommandC0 ; entry 191
    dw ScriptCommandC1 ; entry 192
    dw ScriptCommandC2 ; entry 193
    dw ScriptCommandC3 ; entry 194
    dw ScriptCommandC4 ; entry 195
    dw ScriptCommandC5 ; entry 196
    dw ScriptCommandC6 ; entry 197
    dw ScriptCommandC7 ; entry 198
    dw ScriptCommandC8 ; entry 199
    dw ScriptCommandC9 ; entry 200
    dw ScriptCommandCA ; entry 201
    dw ScriptCommandCB ; entry 202
    dw ScriptCommandCC ; entry 203
    dw ScriptCommandCD ; entry 204
    dw ScriptCommandCE ; entry 205
    dw ScriptCommandCF ; entry 206
    dw $0000 ; entry 207
    dw $0000 ; entry 208
    dw $0000 ; entry 209
    dw $0000 ; entry 210
    dw $0000 ; entry 211
    dw $0000 ; entry 212
    dw $0000 ; entry 213
    dw $0000 ; entry 214
    dw $0000 ; entry 215
    dw $0000 ; entry 216
    dw $0000 ; entry 217
    dw $0000 ; entry 218
    dw $0000 ; entry 219
    dw $0000 ; entry 220
    dw $0000 ; entry 221
    dw $0000 ; entry 222
    dw ScriptCommandE0 ; entry 223
    dw ScriptCommandE1 ; entry 224
    dw ScriptCommandE2 ; entry 225
    dw ScriptCommandE3 ; entry 226
    dw $0000 ; entry 227
    dw ScriptCommandE5 ; entry 228
    dw ScriptCommandE6 ; entry 229
    dw $0000 ; entry 230
    dw ScriptCommandE8 ; entry 231
    dw ScriptCommandE9 ; entry 232
    dw ScriptCommand01 ; entry 233
    dw ScriptCommandEB ; entry 234
    dw ScriptCommandEC ; entry 235
    dw ScriptCommandED ; entry 236
    dw ScriptCommandEE ; entry 237
    dw ScriptCommandEF ; entry 238
    dw ScriptCommandF0 ; entry 239
    dw ScriptCommandF1 ; entry 240
    dw ScriptCommandF2 ; entry 241
    dw ScriptCommandF3 ; entry 242
    dw ScriptCommandF4 ; entry 243
    dw ScriptCommand01 ; entry 244
    dw ScriptCommandF6 ; entry 245
    dw ScriptCommandF7 ; entry 246
    dw ScriptCommandF8 ; entry 247

; Script command $9E (SCRIPT_KEY_WORLD_FLOOR_BATTLE), entry 157 of ScriptCommandHandlers: one frame
; of the command, a far call of KeyWorldFloorBattle. (C1, E-0376)
; runs one frame of script command type 9E (entry 157 of ScriptCommandHandlers) (E-0038)
ScriptCommand9E::
    farcall KeyWorldFloorBattle
    ret

SECTION "Bank 10 ScriptCommand9D", ROMX

; Script command $9D (SCRIPT_COUNTDOWN_MESSAGE), entry 156 of ScriptCommandHandlers: one frame of
; the command, a far call of CountdownMessage. (C1, E-0376)
; runs one frame of script command type 9D (entry 156 of ScriptCommandHandlers) (E-0038)
ScriptCommand9D::
    farcall CountdownMessage
    ret

SECTION "Bank 10 ScriptCommand9C", ROMX

; Script command $9C (SCRIPT_ENCOUNTER_MESSAGE), entry 155 of ScriptCommandHandlers: one frame of
; the command, a far call of EncounterCounterMessage. (C1, E-0376)
; runs one frame of script command type 9C (entry 155 of ScriptCommandHandlers) (E-0038)
ScriptCommand9C::
    farcall EncounterCounterMessage
    ret

SECTION "Bank 10 ScriptCommand9B", ROMX

; Script command $9B (SCRIPT_HEAL_PARTY), entry 154 of ScriptCommandHandlers: one frame of the
; command, a far call of HealPartyEvent. (C1, E-0376)
; runs one frame of script command type 9B (entry 154 of ScriptCommandHandlers) (E-0038)
ScriptCommand9B::
    farcall HealPartyEvent
    ret

SECTION "Bank 10 ScriptCommand9A", ROMX

; Script command $9A (SCRIPT_RANDOM_BATTLE), entry 153 of ScriptCommandHandlers: one frame of the
; command, a far call of RandomBattleEvent. (C1, E-0376)
; runs one frame of script command type 9A (entry 153 of ScriptCommandHandlers) (E-0038)
ScriptCommand9A::
    farcall RandomBattleEvent
    ret

SECTION "Bank 10 ScriptCommand99", ROMX

; Script command $99 (SCRIPT_OBJECT_PATH_1C), entry 152 of ScriptCommandHandlers: one frame of the
; command, a far call of ObjectPath1C. (C1, E-0376)
; runs one frame of script command type 99 (entry 152 of ScriptCommandHandlers) (E-0038)
ScriptCommand99::
    farcall ObjectPath1C
    ret

SECTION "Bank 10 ScriptCommand98", ROMX

; Script command $98 (SCRIPT_OBJECT_PATH_1B), entry 151 of ScriptCommandHandlers: one frame of the
; command, a far call of ObjectPath1B. (C1, E-0376)
; runs one frame of script command type 98 (entry 151 of ScriptCommandHandlers) (E-0038)
ScriptCommand98::
    farcall ObjectPath1B
    ret

SECTION "Bank 10 ScriptCommand95", ROMX

; Script command $95 (SCRIPT_ARENA_GRID_BATTLE), entry 148 of ScriptCommandHandlers: one frame of
; the command, a far call of ArenaGridBattle. (C1, E-0376)
; runs one frame of script command type 95 (entry 148 of ScriptCommandHandlers) (E-0038)
ScriptCommand95::
    farcall ArenaGridBattle
    ret

SECTION "Bank 10 ScriptCommand96", ROMX

; Script command $96 (SCRIPT_ARENA_ROUNDS), entry 149 of ScriptCommandHandlers: one frame of the
; command, a far call of ArenaRounds. (C1, E-0376)
; runs one frame of script command type 96 (entry 149 of ScriptCommandHandlers) (E-0038)
ScriptCommand96::
    farcall ArenaRounds
    ret

SECTION "Bank 10 ScriptCommand90", ROMX

; Script command $90 (SCRIPT_FOLLOWERS_STEP_10), entry 143 of ScriptCommandHandlers: one frame of
; the command, a far call of FollowersStep10. (C1, E-0376)
; runs one frame of script command type 90 (entry 143 of ScriptCommandHandlers) (E-0038)
ScriptCommand90::
    farcall FollowersStep10
    ret

SECTION "Bank 10 ScriptCommand91", ROMX

; Script command $91 (SCRIPT_FOLLOWERS_STEP_11), entry 144 of ScriptCommandHandlers: one frame of
; the command, a far call of FollowersStep11 (by wScriptStep: the player faces down with sound $65,
; walks down two pixels a frame to Y $60 with the followers, then waits for the last follower and
; resumes the script). (C2, E-0376)
; runs one frame of script command type 91 (entry 144 of ScriptCommandHandlers) (E-0038)
ScriptCommand91::
    farcall FollowersStep11
    ret

SECTION "Bank 10 ScriptCommand92", ROMX

; Script command $92 (SCRIPT_PLAYER_AND_FOLLOWERS_STEP), entry 145 of ScriptCommandHandlers: one
; frame of the command, a far call of PlayerAndFollowersStep. (C1, E-0376)
; runs one frame of script command type 92 (entry 145 of ScriptCommandHandlers) (E-0038)
ScriptCommand92::
    farcall PlayerAndFollowersStep
    ret

SECTION "Bank 10 ScriptCommand93", ROMX

; Script command $93 (SCRIPT_WARP_WITH_FOLLOWERS), entry 146 of ScriptCommandHandlers: one frame of
; the command, a far call of WarpWithFollowers. (C1, E-0376)
; runs one frame of script command type 93 (entry 146 of ScriptCommandHandlers) (E-0038)
ScriptCommand93::
    farcall WarpWithFollowers
    ret

SECTION "Bank 10 ScriptCommand94", ROMX

; Script command $94 (SCRIPT_FOLLOWERS_STEP_14), entry 147 of ScriptCommandHandlers: one frame of
; the command, a far call of FollowersStep14 (by wScriptStep: the player faces down with sound $65,
; walks down two pixels a frame to Y $80 with the followers, then waits for the last follower and
; resumes the script). (C2, E-0376)
; runs one frame of script command type 94 (entry 147 of ScriptCommandHandlers) (E-0038)
ScriptCommand94::
    farcall FollowersStep14
    ret

SECTION "Bank 10 ScriptCommand8D", ROMX

; Script command $8D (SCRIPT_BREED_CHILD_SCENE), entry 140 of ScriptCommandHandlers: one frame of
; the command, a far call of BreedChildScene. (C1, E-0376)
; runs one frame of script command type 8D (entry 140 of ScriptCommandHandlers) (E-0038)
ScriptCommand8D::
    farcall BreedChildScene
    ret

SECTION "Bank 10 ScriptCommand8C", ROMX

; Script command $8C (SCRIPT_BREED_CHILD_SPRITE), entry 139 of ScriptCommandHandlers: one frame of
; the command, a far call of BreedChildSprite. (C1, E-0376)
; runs one frame of script command type 8C (entry 139 of ScriptCommandHandlers) (E-0038)
ScriptCommand8C::
    farcall BreedChildSprite
    ret

SECTION "Bank 10 ScriptCommand8B", ROMX

; Script command $8B (SCRIPT_BREED_FADE), entry 138 of ScriptCommandHandlers: one frame of the
; command, a far call of BreedFade. (C1, E-0376)
; runs one frame of script command type 8B (entry 138 of ScriptCommandHandlers) (E-0038)
ScriptCommand8B::
    farcall BreedFade
    ret

SECTION "Bank 10 ScriptCommand8F", ROMX

; Script command $8F (SCRIPT_NPC_BREED_WARP), entry 142 of ScriptCommandHandlers: one frame of the
; command, a far call of NpcBreedWarp. (C1, E-0376)
; runs one frame of script command type 8F (entry 142 of ScriptCommandHandlers) (E-0038)
ScriptCommand8F::
    farcall NpcBreedWarp
    ret

SECTION "Bank 10 ScriptCommand9F", ROMX

; Script command $9F (SCRIPT_LINK_MESSAGE), entry 158 of ScriptCommandHandlers: one frame of the
; command, a far call of LinkMessageEvent. (C1, E-0376)
; runs one frame of script command type 9F (entry 158 of ScriptCommandHandlers) (E-0038)
ScriptCommand9F::
    farcall LinkMessageEvent
    ret

SECTION "Bank 10 ScriptCommandA0", ROMX

; Script command $A0 (SCRIPT_PLAYER_SPRITE_FLASH), entry 159 of ScriptCommandHandlers: one frame of
; the command, a far call of PlayerSpriteFlash. (C1, E-0376)
; runs one frame of script command type A0 (entry 159 of ScriptCommandHandlers) (E-0038)
ScriptCommandA0::
    farcall PlayerSpriteFlash
    ret

SECTION "Bank 10 ScriptCommandA1", ROMX

; Script command $A1 (SCRIPT_PLAYER_SPRITE_MESSAGE), entry 160 of ScriptCommandHandlers: one frame
; of the command, a far call of PlayerSpriteMessage. (C1, E-0376)
; runs one frame of script command type A1 (entry 160 of ScriptCommandHandlers) (E-0038)
ScriptCommandA1::
    farcall PlayerSpriteMessage
    ret

SECTION "Bank 10 ScriptCommand8E", ROMX

; Script command $8E (entry 141 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $8E): calls MapLinkWarp in bank $12 and returns.
; MapLinkWarp runs stage wScriptStep of its 2 stages (WarpScene_LiftPartyFor90Calls first,
; MapLinkWarp_SelectDestination last). Its only script is Script_MapLinkWarp, the one-command script
; that Talk_MapLinkWarp (field talk 8) starts (StartScriptAtHL_B04). (C1, E-0376)
; runs one frame of script command type 8E (entry 141 of ScriptCommandHandlers) (E-0038)
ScriptCommand8E::
    farcall MapLinkWarp
    ret

SECTION "Bank 10 ScriptCommand8A", ROMX

; Script command $8A (entry 137 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $8A): calls MapExitWarp in bank $12 and returns.
; MapExitWarp runs stage wScriptStep of its 2 stages (WarpScene_LiftPartyFor90Calls first,
; MapExitWarp_StartFade last). Its only script is Script_MapExitWarp, the one-command script that
; Talk_MapExitWarp (field talk 7) starts (StartScriptAtHL_B04). (C1, E-0376)
; runs one frame of script command type 8A (entry 137 of ScriptCommandHandlers) (E-0038)
ScriptCommand8A::
    farcall MapExitWarp
    ret

SECTION "Bank 10 ScriptCommand80", ROMX

; Script command $80 (entry 127 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $80): calls StepTriggerReward in bank $12 and
; returns. StepTriggerReward runs stage wScriptStep of its 6 stages (StepTriggerReward_ShowMessage
; first, StepTriggerReward_SetScriptStartRequestTo80 last). Its only script is
; Script_StepTriggerReward, the one-command script that Talk_StepTriggerReward (field talk 15)
; starts (StartScriptAtHL_B04). (C1, E-0376)
; runs one frame of script command type 80 (entry 127 of ScriptCommandHandlers) (E-0038)
ScriptCommand80::
    farcall StepTriggerReward
    ret

SECTION "Bank 10 ScriptCommand81", ROMX

; Script command $81 (entry 128 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $81): calls AreaItemEvent in bank $12 and returns.
; AreaItemEvent runs stage wScriptStep of its 3 stages (AreaItemEvent_ShowItemMessage first,
; AreaItemEvent_GiveItem last). Its only script is Script_AreaItem, the one-command script that
; Talk_AreaItem (field talk 14) starts (StartScriptAtHL_B04). (C1, E-0376)
; runs one frame of script command type 81 (entry 128 of ScriptCommandHandlers) (E-0038)
ScriptCommand81::
    farcall AreaItemEvent
    ret

SECTION "Bank 10 ScriptCommand86", ROMX

; Script command $86 (entry 133 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $86): calls KeyWorldDoorItem in bank $12 and
; returns. KeyWorldDoorItem runs stage wScriptStep of its 5 stages (KeyWorldDoorItem_ShowItemMessage
; first, KeyWorldDoorItem_OpenDoor last). Its only script is Script_KeyWorldDoorItem, the
; one-command script that Talk_KeyWorldDoorItem (field talks 11-13) starts (StartScriptAtHL_B04).
; (C1, E-0376)
; runs one frame of script command type 86 (entry 133 of ScriptCommandHandlers) (E-0038)
ScriptCommand86::
    farcall KeyWorldDoorItem
    ret

SECTION "Bank 10 ScriptCommand82", ROMX

; Script command $82 (entry 129 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $82): calls TravelerEvents in bank $73 and
; returns. TravelerEvents jumps by wPendingFieldEvent & $0F to one of 16 traveler handlers
; (TravelerEvents_Healer first; entries 12-15 are all TravelerEvents_Thief). Its only script is
; Script_TravelerEvent, the one-command script that Talk_TravelerEvent starts (StartScriptAtHL_B13).
; (C1, E-0376)
; runs one frame of script command type 82 (entry 129 of ScriptCommandHandlers) (E-0038)
ScriptCommand82::
    farcall TravelerEvents
    ret

SECTION "Bank 10 ScriptCommand83", ROMX

; Script command $83 (entry 130 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $83): calls FieldScene01 in bank $12 and returns.
; FieldScene01 picks by wScriptParam1: 1 runs FieldScene01_Variant1, 2 FieldScene01_Variant2,
; anything else FieldScene01_GetOff; ScriptFetch83 sets wScriptParam1 when the command starts (2
; unless wMapSpriteKind & 3 is 1, then 3 with hPlayerStateFlags bit 3 set, else 1). Its only script
; is Script_FieldScene01, the one-command script that Talk_FieldScene01 (field talk 1) starts
; (StartScriptAtHL_B04). (C1, E-0376)
; runs one frame of script command type 83 (entry 130 of ScriptCommandHandlers) (E-0038)
ScriptCommand83::
    farcall FieldScene01
    ret

SECTION "Bank 10 ScriptCommand84", ROMX

; Script command $84 (entry 131 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $84): calls RandomGoldOrItem in bank $12 and
; returns. RandomGoldOrItem clears wJoypadHeld and wJoypadPressed unless wScriptStep is 7, then runs
; stage wScriptStep of its 9 stages (SetupScriptSpriteInFrontOfPlayer first, RandomGoldOrItem_Give
; last). Its only script is Script_RandomGoldOrItem, the one-command script that
; Talk_RandomGoldOrItem (field talk 2) starts (StartScriptAtHL_B04). (C1, E-0376)
; runs one frame of script command type 84 (entry 131 of ScriptCommandHandlers) (E-0038)
ScriptCommand84::
    farcall RandomGoldOrItem
    ret

SECTION "Bank 10 ScriptCommand85", ROMX

; Script command $85 (entry 132 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $85): calls KeyWorldBossBattle in bank $12 and
; returns. KeyWorldBossBattle runs stage wScriptStep of its 8 stages (KeyWorldBossBattle_ShowMessage
; first, KeyWorldBossBattle_MarkCleared last). Its only script is Script_KeyWorldBossBattle, the
; one-command script that Talk_KeyWorldBossBattle (key world talk 0) starts (StartScriptAtHL_B04).
; (C1, E-0376)
; runs one frame of script command type 85 (entry 132 of ScriptCommandHandlers) (E-0038)
ScriptCommand85::
    farcall KeyWorldBossBattle
    ret

SECTION "Bank 10 ScriptCommand87", ROMX

; Script command $87 (entry 134 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $87): calls PartyDefeatedReturn in bank $12 and
; returns. PartyDefeatedReturn runs stage wScriptStep of its 9 stages
; (PartyDefeatedReturn_CountMarked first, PartyDefeatedReturn_ShowReturnMessage last). Its only
; script is Script_PartyDefeatedReturn, the one-command script that Talk_PartyDefeatedReturn (field
; talk 4) starts (StartScriptAtHL_B04). (C1, E-0376)
; runs one frame of script command type 87 (entry 134 of ScriptCommandHandlers) (E-0038)
ScriptCommand87::
    farcall PartyDefeatedReturn
    ret

SECTION "Bank 10 ScriptCommand88", ROMX

; Script command $88 (entry 135 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $88): calls ReturnMessage in bank $12 and returns.
; ReturnMessage runs stage wScriptStep of its 6 stages (ReturnMessage_SetGoldAndShow first,
; HealPartyEvent_WaitAndResume last). Its only script is Script_ReturnMessage, the one-command
; script that Talk_ReturnMessage (field talk 5) starts (StartScriptAtHL_B04). (C1, E-0376)
; runs one frame of script command type 88 (entry 135 of ScriptCommandHandlers) (E-0038)
ScriptCommand88::
    farcall ReturnMessage
    ret

SECTION "Bank 10 ScriptCommand89", ROMX

; Script command $89 (entry 136 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $89): calls ReturnWarp in bank $12 and returns.
; ReturnWarp runs stage wScriptStep of its 8 stages (WarpScene_LiftPartyFor90Calls first,
; HealPartyEvent_WaitAndResume last). Its only script is Script_ReturnWarp, the one-command script
; that Talk_ReturnWarp (field talk 6) starts (StartScriptAtHL_B04). (C1, E-0376)
; runs one frame of script command type 89 (entry 136 of ScriptCommandHandlers) (E-0038)
ScriptCommand89::
    farcall ReturnWarp
    ret

SECTION "Bank 10 ScriptCommand06", ROMX

; Script command $06 (entry 5 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $06): calls ScriptSetDirection in bank $5F and
; returns. ScriptSetDirection stores wScriptParam1 at the target that wScriptParam0 picks: 0 =
; hPlayerFacing, n = the first byte of the n-th 5-byte record at wFollowerRecords, $80 + n = byte 7
; of the 16-byte object entry n at wSpriteSlots; then wScriptStartRequest = $80, so the next script
; byte is read on the next frame (wScriptCommandType is not cleared). Scripts write it as
; script_face (opcode $05; ScriptFetchFace sets type $06 and the two parameters). (C2, E-0376)
; runs one frame of script command type 06 (entry 5 of ScriptCommandHandlers) (E-0038)
ScriptCommand06::
    farcall ScriptSetDirection
    ret

SECTION "Bank 10 ScriptCommand05", ROMX

; Script command $05 (entry 4 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $05): calls ScriptCommand05_Run in bank $5F and
; returns. ScriptCommand05_Run clears wJoypadHeld and wJoypadPressed; while a field action is
; pending (wFieldActionRequest bit 7) or a step is in progress (hPlayerStateFlags bit 0) it does
; nothing more. Otherwise, with wScriptParam1 = 0 it sets wScriptStartRequest = $80 (the command
; ends when the next byte is fetched); else it decrements wScriptParam1 and sets the D-pad bit of
; direction wScriptParam0 in wJoypadHeld (0 down bit 7, 1 right bit 4, 2 up bit 6, any other value
; left bit 5). Scripts write it as script_hold_dpad (opcode $04; ScriptFetchHoldDpad sets type $05,
; the parameters, wScriptStep = 0 and hPlayerTurnDelay = 0). (C2, E-0376)
; runs one frame of script command type 05 (entry 4 of ScriptCommandHandlers) (E-0038)
ScriptCommand05::
    farcall ScriptCommand05_Run
    ret

SECTION "Bank 10 ScriptCommand04", ROMX

; Script command $04 (entry 3 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $04): calls ScriptWaitFrames in bank $5F and
; returns. ScriptWaitFrames decrements the 16-bit count wScriptParam0 (low)/wScriptParam1 (high);
; when it reaches 0 it clears wScriptCommandType and sets wScriptStartRequest = $80. Scripts write
; it as script_wait (opcode $03; ScriptFetchWait sets type $04 and the count). (C2, E-0376)
; runs one frame of script command type 04 (entry 3 of ScriptCommandHandlers) (E-0038)
ScriptCommand04::
    farcall ScriptWaitFrames
    ret

SECTION "Bank 10 ScriptCommand03", ROMX

; Script command $03 (entry 2 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $03): calls ScriptStepObject in bank $5F, then
; falls into ScriptCommand02 (there is no ret), which calls it again and returns. ScriptStepObject
; moves the object one pixel per call (see ScriptCommand02), so the object moves two pixels a frame
; and a tile takes 8 frames; the tile count reaches 0 on the second call of a frame, so the extra
; call never overshoots. Scripts write it as script_walk_fast (opcode $02; ScriptFetchWalkFast sets
; type $03). (C2, E-0376)
; runs one frame of script command type 03 (entry 2 of ScriptCommandHandlers) (E-0038)
ScriptCommand03::
    farcall ScriptStepObject

; Script command $02 (entry 1 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $02): calls ScriptStepObject in bank $5F and
; returns. ScriptStepObject moves object wScriptParam0 & $0F (the 16-byte entry at wSpriteSlots) one
; pixel in direction wScriptParam0 >> 4 (0 Y + 1, 1 X + 1, 2 Y - 1, 3 X - 1), sets bit 2 of its
; flags (byte $D) and stores the direction in byte 7; every 16 calls (wScriptStep) it decrements the
; tile count wScriptParam1, and at 0 clears bit 2, clears wScriptCommandType and sets
; wScriptStartRequest = $80. Scripts write it as script_walk (opcode $01; ScriptFetchWalk sets type
; $02). (C2, E-0376)
; runs one frame of script command type 02 (entry 1 of ScriptCommandHandlers) (E-0038)
ScriptCommand02::
    farcall ScriptStepObject
    ret

SECTION "Bank 10 ScriptCommand0A", ROMX

; Script command $0A (entry 9 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $0A): calls RunOneTimeTreasure in bank $5F and
; returns. RunOneTimeTreasure runs stage wScriptStep of its 5 stages
; (RunOneTimeTreasure_PrepareMessage first, RunOneTimeTreasure_RedrawChest last). No script opcode
; sets type $0A: StartTreasureFlagDE_B04 and StartTreasureFlagDE_B13 start it directly for the
; chest, vase and barrel handlers, with the story flag of the treasure in
; wMessageIndex/wMessageGroup. (C1, E-0376)
; runs one frame of script command type 0A (entry 9 of ScriptCommandHandlers) (E-0038)
ScriptCommand0A::
    farcall RunOneTimeTreasure
    ret

SECTION "Bank 10 ScriptCommand09", ROMX

; Script command $09 (entry 8 of ScriptCommandHandlers): the one-message talk reply.
; StartMessageCommand09HL_B04, StartMessageCommand09HL_B13 and other talk code of bank $13 start it
; directly with the message word in wScriptParam0 (low) and wScriptParam1 (high); no script opcode
; sets type $09. It jumps by wScriptStep: 0 ScriptCommand09_OpenWindow, 1 ScriptCommand09_ShowText,
; 2 ScriptCommand09_CloseWindow, 3 ScriptCommand09_Finish, which ends the whole script
; (wScriptRunning = 0, wModeState = 0) instead of asking for the next script byte. (C1, E-0376)
; runs one frame of script command type 09 (entry 8 of ScriptCommandHandlers) (E-0038)
ScriptCommand09::
    ld a, [wScriptStep]
    jumptable
    dw ScriptCommand09_OpenWindow
    dw ScriptCommand09_ShowText
    dw ScriptCommand09_CloseWindow
    dw ScriptCommand09_Finish

; Command 09, step 3: once the window has closed, unfreezes the player and objects and ends the
; script (mode state 0). (C2, E-0357; probed E-0376)
ScriptCommand09_Finish::
    ld a, [wTextWindowState]
    and $03
    ret nz
    farcall ResumeFieldAnimation
    xor a
    ld [wScriptCommandType], a
    xor a
    ld [wScriptRunning], a
    ld a, $00
    ld [wModeState], a
    ret

SECTION "Bank 10 ScriptCommand01", ROMX

; Script command $01 (entries 0, 233 and 244 of ScriptCommandHandlers): a message inside a script.
; ScriptFetchMessage (script_message), ScriptFetchMessageUnlessFlag0 (script_message_unless_flag0)
; and ScriptFetchMessageByScreen (script_message_by_screen) all set type $01 with the message word
; in wScriptParam0 (low) and wScriptParam1 (high; bit 7 = the window is already open, bit 6 = keep
; it open), so entries 233 ($EA) and 244 ($F5) are reached only if something stores those types, and
; no store in src does. It jumps by wScriptStep through the first three steps of command $09
; (ScriptCommand09_OpenWindow, ScriptCommand09_ShowText, ScriptCommand09_CloseWindow), then
; ScriptCommand01_CloseWindow, which ends the command and asks for the next script byte
; (wScriptStartRequest = $80). (C1, E-0376)
; runs one frame of script command type 01 (entry 0 of ScriptCommandHandlers) (E-0038)
ScriptCommand01::
    ld a, [wScriptStep]
    jumptable
    dw ScriptCommand09_OpenWindow
    dw ScriptCommand09_ShowText
    dw ScriptCommand09_CloseWindow
    dw ScriptCommand01_CloseWindow

; Command 09, step 0: unless wScriptParam1 bit 7 (the window is already open), freezes the player
; and objects, clears the window tiles, plays sound $69 and opens the text window (at the top when
; the player is low on the screen); next step. (C1, E-0357)
ScriptCommand09_OpenWindow::
    ld a, [wScriptParam1]
    bit 7, a
    jr nz, .done
    farcall FreezeFieldAnimation
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    call FillTilesFromRequest
    ld a, $69
    call QueueSoundEffect
    ld a, $01
    ld [wTextWindowState], a
    ld a, $00
    ld [wTextWindowStep], a
    ld a, $02
    ldh [hSpriteWindowClipMode], a
    ldh a, [hPlayerY]
    cp $48
    jr c, .done
    ld a, $81
    ld [wTextWindowState], a
    ld a, $01
    ldh [hSpriteWindowClipMode], a

.done:
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 10 ScriptCommand09_ShowText", ROMX

; Command 09, step 1: once the window has opened (or at once with bit 7), starts message
; wScriptParam0 of group wScriptParam1 (StartMessageForGroup); next step. (C1, E-0357)
ScriptCommand09_ShowText::
    ld a, [wScriptParam1]
    bit 7, a
    jr nz, .read_script_param0
    ld a, [wTextWindowState]
    and $03
    ret nz

.read_script_param0:
    ld a, [wScriptParam0]
    ld l, a
    ld a, [wScriptParam1]
    ld h, a
    call StartMessageForGroup
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 10 ScriptCommand09_CloseWindow", ROMX

; Command 09, step 2: waits for the text; unless wScriptParam1 bit 6 (keep the window open), plays
; sound $69 and starts closing it; next step. (C2, E-0357; probed E-0376)
ScriptCommand09_CloseWindow::
    ld a, [wTextFlags]
    bit 0, a
    ret nz
    ld a, [wScriptParam1]
    bit 6, a
    jr nz, .done
    ld a, $69
    call QueueSoundEffect
    xor a
    ldh [hSpriteWindowClipMode], a
    ld a, $02
    ld [wTextWindowState], a
    ld a, $00
    ld [wTextWindowStep], a
    ldh a, [hPlayerY]
    cp $48
    jr c, .done
    ld a, $82
    ld [wTextWindowState], a

.done:
    ld hl, wScriptStep
    inc [hl]
    ret

SECTION "Bank 10 ScriptCommand01_CloseWindow", ROMX

; Command 01, step 3: unless wScriptParam1 bit 6, waits for the window to close and unfreezes the
; player and objects; then ends the command and asks for the next one (wScriptStartRequest $80).
; (C2, E-0357; probed E-0376)
ScriptCommand01_CloseWindow::
    ld a, [wScriptParam1]
    bit 6, a
    jr nz, .clear_script_command_type
    ld a, [wTextWindowState]
    and $03
    ret nz
    farcall ResumeFieldAnimation

.clear_script_command_type:
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

SECTION "Bank 10 StartMessageForGroup", ROMX

; Starts message L of group H (bits 0-5): with a message mode set (wMessageMode) through that mode's
; far routine from the table (rst $10), otherwise by group (StartMessageForGroup_ByGroup). (C1,
; E-0357)
StartMessageForGroup::
    ld a, h
    and $3f
    ld h, a
    push hl
    ld a, [wMessageMode]
    and a
    jr z, StartMessageForGroup_ByGroup
    dec a
    ld c, a
    sla a
    add c
    ld de, StartMessageForGroup_Data
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    inc de
    ld a, [de]
    ld d, a
    pop hl
    ld a, l
    ld [wStringIndex], a
    ld a, $00
    ld [wStringCategory], a
    ld l, c
    ld h, b
    ld b, d
    rst $10
    ret

SECTION "Bank 10 StartMessageForGroup_Data", ROMX

; Eleven 3-byte far pointers (address low, address high, bank), indexed by wMessageMode - 1: the
; per-mode begin-message routines BeginStringDisplay_BankF0 (modes 1 and 2),
; BeginStringDisplay_Bank1F, BeginStringDisplay_Bank1D, BeginBreedingStringDisplay,
; BeginStringDisplay_BankF2, BeginStringDisplay_Bank0D, BeginMessageDisplay_Bank0E,
; BeginStringDisplay_Bank0B, BeginStringDisplay_Bank33 and BeginStringDisplay_Bank24.
; StartMessageForGroup calls the chosen one through rst $10 with wStringCategory 0 and wStringIndex
; = the message L. (C1, E-0381)
; StartMessageForGroup reads entry wMessageMode - 1 (3 bytes: address, bank) and calls it through
; rst $10 with wStringIndex = the message; read as raw bytes until tools/shift_test.py --recipe
; found the padded ROM's Egg Evaluator calling the old address (E-0400, C1)
; record: far pointer to the routine that begins a message in this wMessageMode
StartMessageForGroup_Data::
    dfar BeginStringDisplay_BankF0 ; id 1
    dfar BeginStringDisplay_BankF0 ; id 2
    dfar BeginStringDisplay_Bank1F ; id 3
    dfar BeginStringDisplay_Bank1D ; id 4
    dfar BeginBreedingStringDisplay ; id 5
    dfar BeginStringDisplay_BankF2 ; id 6
    dfar BeginStringDisplay_Bank0D ; id 7
    dfar BeginMessageDisplay_Bank0E ; id 8
    dfar BeginStringDisplay_Bank0B ; id 9
    dfar BeginStringDisplay_Bank33 ; id 10
    dfar BeginStringDisplay_Bank24 ; id 11

; Starts message L of group H (HL pushed by StartMessageForGroup, which comes here when wMessageMode
; is 0): in a key world (wMapType bit 7 set but not exactly $80) StartMessageForGroup_KeyWorld
; decides instead; otherwise sets wStringIndex = L, wStringCategory = 0 and jumps by H to the
; group's bank: groups 0-13 use banks $28, $29, $2A, $2B, $2C, $2D, $2E, $2E, $7C, $80, $80, $82,
; $86 and $89 (no bounds check). (C1, E-0370)
StartMessageForGroup_ByGroup::
    pop hl
    ld a, [wMapType]
    cp $80
    jr z, .set_string_index
    bit 7, a
    jp nz, StartMessageForGroup_KeyWorld

.set_string_index:
    ld a, l
    ld [wStringIndex], a
    xor a
    ld [wStringCategory], a
    ld a, h
    jumptable
    dw StartMessageForGroup_Group00
    dw StartMessageForGroup_Group01
    dw StartMessageForGroup_Group02
    dw StartMessageForGroup_Group03
    dw StartMessageForGroup_Group04
    dw StartMessageForGroup_Group05
    dw StartMessageForGroup_Groups06And07
    dw StartMessageForGroup_Groups06And07
    dw StartMessageForGroup_Group08
    dw StartMessageForGroup_Groups09And0A
    dw StartMessageForGroup_Groups09And0A
    dw StartMessageForGroup_Group0B
    dw StartMessageForGroup_Group0C
    dw StartMessageForGroup_Group0D

; Group 0: bank $28's strings (BeginStringDisplay_Bank28). (C1, E-0357)
StartMessageForGroup_Group00::
    farcall BeginStringDisplay_Bank28
    ret

SECTION "Bank 10 StartMessageForGroup_Group01", ROMX

; Group 1: bank $29's strings. (C1, E-0357)
StartMessageForGroup_Group01::
    farcall BeginStringDisplay_Bank29
    ret

SECTION "Bank 10 StartMessageForGroup_Group02", ROMX

; Group 2: bank $2A's strings. (C1, E-0357)
StartMessageForGroup_Group02::
    farcall BeginStringDisplay_Bank2A
    ret

SECTION "Bank 10 StartMessageForGroup_Group03", ROMX

; Group 3: bank $2B's strings. (C1, E-0357)
StartMessageForGroup_Group03::
    farcall BeginStringDisplay_Bank2B
    ret

SECTION "Bank 10 StartMessageForGroup_Group04", ROMX

; Group 4: bank $2C's strings. (C1, E-0357)
StartMessageForGroup_Group04::
    farcall BeginStringDisplay_Bank2C
    ret

SECTION "Bank 10 StartMessageForGroup_Group05", ROMX

; Group 5: bank $2D's strings. (C1, E-0357)
StartMessageForGroup_Group05::
    farcall BeginStringDisplay_Bank2D
    ret

SECTION "Bank 10 StartMessageForGroup_Groups06And07", ROMX

; Groups 6 and 7: bank $2E's strings. (C1, E-0357)
StartMessageForGroup_Groups06And07::
    farcall BeginStringDisplay_Bank2E
    ret

SECTION "Bank 10 StartMessageForGroup_Group08", ROMX

; Group 8: bank $7C's strings. (C1, E-0357)
StartMessageForGroup_Group08::
    farcall BeginStringDisplay_Bank7C
    ret

SECTION "Bank 10 StartMessageForGroup_Groups09And0A", ROMX

; Groups 9 and 10: bank $80's strings. (C1, E-0357)
StartMessageForGroup_Groups09And0A::
    farcall BeginStringDisplay_Bank80
    ret

SECTION "Bank 10 StartMessageForGroup_Group0B", ROMX

; Group 11: bank $82's strings. (C1, E-0357)
StartMessageForGroup_Group0B::
    farcall BeginStringDisplay_Bank82
    ret

SECTION "Bank 10 StartMessageForGroup_Group0C", ROMX

; Group 12: bank $86's strings. (C1, E-0357)
StartMessageForGroup_Group0C::
    farcall BeginStringDisplay_Bank86
    ret

SECTION "Bank 10 StartMessageForGroup_Group0D", ROMX

; Group 13: bank $89's strings. (C1, E-0357)
StartMessageForGroup_Group0D::
    farcall BeginStringDisplay_Bank89
    ret

SECTION "Bank 10 StartMessageForGroup_KeyWorld", ROMX

; Key-world messages: group 0 with an index of $20 or more uses bank $83; other messages use bank
; $8A. (C1, E-0357)
StartMessageForGroup_KeyWorld::
    ld a, h
    or a
    jr nz, .set_string_index
    ld a, l
    cp $20
    jr c, .set_string_index
    ld [wStringIndex], a
    xor a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank83
    ret

.set_string_index:
    ld a, l
    ld [wStringIndex], a
    xor a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank8A
    ret

SECTION "Bank 10 ScriptCommand0C", ROMX

; Script command $0C (entry 11 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $0C): calls ScriptSlideObjectY in bank $5F and
; returns. ScriptSlideObjectY adds ScriptSlideObjectY_Data[wScriptParam0 / 2] to the Y byte of the
; target that wScriptParam1 picks (0 = hPlayerY, n = byte 2 of the n-th 5-byte record at
; wFollowerRecords, $80 + n = byte $C of object entry n) and increments wScriptParam0; at $20 (32
; frames) it clears wScriptCommandType and sets wScriptStartRequest = $80. Scripts write it as
; script_slide_y (opcode $0B; ScriptFetchSlideY sets type $0C, wScriptParam1 = the target and
; wScriptParam0 = 0). (C2, E-0376)
; runs one frame of script command type 0C (entry 11 of ScriptCommandHandlers) (E-0038)
ScriptCommand0C::
    farcall ScriptSlideObjectY
    ret

SECTION "Bank 10 ScriptCommand0E", ROMX

; Script command $0E (entry 13 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $0E): calls ScriptCommand0E_Run in bank $5F and
; returns. ScriptCommand0E_Run: at stage 0 it starts scripted encounter wScriptParam0
; (StartScriptedEncounterTemp0) and moves to stage 1; the next call (after the battle) clears
; wScriptCommandType, sets wScriptStartRequest = $80 and jumps by wScriptParam0 through a 51-entry
; table, whose entry $1E is ScriptCommand0E_Run_HideSprites (wSpriteSlotCount = 0) and all others
; ScriptCommand0E_Run_DoNothing. Scripts write it as script_encounter (opcode $0D;
; ScriptFetchEncounter sets type $0E, wScriptParam0 = the encounter and wScriptStep = 0). (C1,
; E-0376)
; runs one frame of script command type 0E (entry 13 of ScriptCommandHandlers) (E-0038)
ScriptCommand0E::
    farcall ScriptCommand0E_Run
    ret

SECTION "Bank 10 ScriptCommand11", ROMX

; Script command $11 (entry 16 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $11): calls SceneFarmKids in bank $73 and returns.
; SceneFarmKids has 2 stages by wScriptStep: SceneFarmKids_ShowObject shows wObject5 at ($40, $30)
; for 60 frames; SceneFarmKids_SinkObject lowers it on a 16-frame hop, hides it and sets
; wScriptStartRequest = $80. Scripts start it with SCRIPT_SCENE_FARM_KIDS: Script_YouMustBeThe
; (after 'You must be the farm...'). (C2, E-0376)
; runs one frame of script command type 11 (entry 16 of ScriptCommandHandlers) (E-0038)
ScriptCommand11::
    farcall SceneFarmKids
    ret

SECTION "Bank 10 ScriptCommand12", ROMX

; Script command $12 (entry 17 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $12): calls SceneLearnQuick in bank $73 and
; returns. SceneLearnQuick runs stage wScriptStep of its 6 stages (SceneLearnQuick_StartLegs first,
; SceneLearnQuick_SpinUntilStopped last); stage 0 sets wMessageIndex = 1 and wMessageGroup = 0 and
; moves on. Scripts start it with SCRIPT_SCENE_LEARN_QUICK: Script_OhIt. (C2, E-0376)
; runs one frame of script command type 12 (entry 17 of ScriptCommandHandlers) (E-0038)
ScriptCommand12::
    farcall SceneLearnQuick
    ret

SECTION "Bank 10 ScriptCommand13", ROMX

; Script command $13 (entry 18 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $13): calls SceneSpinning in bank $73 and returns.
; SceneSpinning runs stage wScriptStep of its 17 stages (SceneSpinning_PlaceObjects first,
; SceneSpinning_WalkUpOff last). Scripts start it with SCRIPT_SCENE_SPINNING: Script_SceneSpinning.
; (C1, E-0376)
; runs one frame of script command type 13 (entry 18 of ScriptCommandHandlers) (E-0038)
ScriptCommand13::
    farcall SceneSpinning
    ret

SECTION "Bank 10 ScriptCommand14", ROMX

; Script command $14 (entry 19 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $14): calls SceneWarubouSmells in bank $73 and
; returns. SceneWarubouSmells runs stage wScriptStep of its 4 stages; stage 0
; (SceneWarubouSmells_WalkObject2Right) moves object 2 right one pixel a frame until X = $40, and
; the last (SceneWarubouSmells_Wait) waits 60 frames and sets wScriptStartRequest = $80. Scripts
; start it with SCRIPT_SCENE_WARUBOU_SMELLS: Script_WarubouWhaISmell (before 'Warubou: What is this?
; Food? Perfect!'). (C2, E-0376)
; runs one frame of script command type 14 (entry 19 of ScriptCommandHandlers) (E-0038)
ScriptCommand14::
    farcall SceneWarubouSmells
    ret

SECTION "Bank 10 ScriptCommand15", ROMX

; Script command $15 (entry 20 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $15): calls SceneWarubouFood in bank $73 and
; returns. SceneWarubouFood runs stage wScriptStep of its 11 stages (SceneWarubouFood_WalkPlayer
; first); the last, SceneWarubouFood_WalkObjects, walks objects 1 and 2 right two pixels a frame
; toward X = $50, moving each off screen (X = $E0) on arrival, then sets wScriptStartRequest = $80.
; Scripts start it with SCRIPT_SCENE_WARUBOU_FOOD: Script_WarubouWhaISmell (after 'Warubou: What is
; this? Food? Perfect!'). (C2, E-0376)
; runs one frame of script command type 15 (entry 20 of ScriptCommandHandlers) (E-0038)
ScriptCommand15::
    farcall SceneWarubouFood
    ret

SECTION "Bank 10 ScriptCommand16", ROMX

; Script command $16 (entry 21 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $16): calls SceneWarubouFood2 in bank $73 and
; returns. SceneWarubouFood2 runs stage wScriptStep of its 29 stages (ScriptStepSetObjectBit2AndWait
; first, SceneWarubouFood2_WalkPlayerLeft last). Scripts start it with SCRIPT_SCENE_WARUBOU_FOOD_2:
; Script_WarubouCalmDownAnd (before 'Warubou: Calm down and listen! What...'). (C1, E-0376)
; runs one frame of script command type 16 (entry 21 of ScriptCommandHandlers) (E-0038)
ScriptCommand16::
    farcall SceneWarubouFood2
    ret

SECTION "Bank 10 ScriptCommand17", ROMX

; Script command $17 (entry 22 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $17): calls ScenePackage in bank $73 and returns.
; ScenePackage: at stage 0 it shows wObject5 at the position of the player; then each call moves it
; one pixel by the position of the player (X + 1 at hPlayerX $30, X - 1 at $50, otherwise Y + 1 at
; hPlayerY $20, else Y - 1) on a 16-frame hop (ScriptApplyStepDeltaAtDE_Bank73), then hides it and
; sets wScriptStartRequest = $80. Scripts start it with SCRIPT_SCENE_PACKAGE: Script_DidYouGetThe
; (after 'Did you get the package...'). (C2, E-0376)
; runs one frame of script command type 17 (entry 22 of ScriptCommandHandlers) (E-0038)
ScriptCommand17::
    farcall ScenePackage
    ret

SECTION "Bank 10 ScriptCommand18", ROMX

; Script command $18 (entry 23 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $18): calls SceneGreatlogKey in bank $85 and
; returns. SceneGreatlogKey runs stage wScriptStep of its 5 stages
; (SceneGreatlogKey_ShowWarubouWaheyForgotSomething first, SceneGreatlogKey_FlyOff last). Scripts
; start it with SCRIPT_SCENE_GREATLOG_KEY: Script_HeroReceivedTheGreatLog (before '0 received the
; GreatLog Key.'). (C1, E-0376)
; runs one frame of script command type 18 (entry 23 of ScriptCommandHandlers) (E-0038)
ScriptCommand18::
    farcall SceneGreatlogKey
    ret

SECTION "Bank 10 ScriptCommand19", ROMX

; Script command $19 (entry 24 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $19): calls SceneWarubouMagicKey in bank $73 and
; returns. SceneWarubouMagicKey: at stage 0 it shows wObject5 (byte 0 = $80); then it raises it one
; pixel a frame on a 16-frame hop and sets wScriptStartRequest = $80, leaving it shown. Scripts
; start it with SCRIPT_SCENE_WARUBOU_MAGIC_KEY: Script_WarubouWaHeyGood_2 (between 'Warubou: Wa-hey!
; Good, good, good! In...' and 'Warubou: This here is a Magic...'). (C2, E-0376)
; runs one frame of script command type 19 (entry 24 of ScriptCommandHandlers) (E-0038)
ScriptCommand19::
    farcall SceneWarubouMagicKey
    ret

SECTION "Bank 10 ScriptCommand1A", ROMX

; Script command $1A (entry 25 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $1A): calls SceneOasisKey in bank $73 and returns.
; SceneOasisKey moves wObject5 by the position of the player (X + 1 and Y + 1 at hPlayerX $50, X - 1
; and Y + 1 at $30, otherwise Y + 2 unless hPlayerY is $20) on a 16-frame hop; then it hides it,
; puts it back at ($40, $30) and sets wScriptStartRequest = $80. Scripts start it with
; SCRIPT_SCENE_OASIS_KEY: Script_WarubouWaHeyGood_2 (between 'Warubou: This here is a Magic...' and
; '0 received the Oasis Key.'). (C2, E-0376)
; runs one frame of script command type 1A (entry 25 of ScriptCommandHandlers) (E-0038)
ScriptCommand1A::
    farcall SceneOasisKey
    ret

SECTION "Bank 10 ScriptCommand1B", ROMX

; Script command $1B (entry 26 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $1B): calls SceneWarubouLeaves in bank $85 and
; returns. SceneWarubouLeaves runs stage wScriptStep of its 4 stages (SceneWarubouLeaves_WalkObjects
; first); the last, SceneWarubouLeaves_WalkOff, walks objects 1 and 2 left toward X = $E0 and sets
; wScriptStartRequest = $80 when object 2 arrives. Scripts start it with
; SCRIPT_SCENE_WARUBOU_LEAVES: Script_HehSoTheseAre. (C2, E-0376)
; runs one frame of script command type 1B (entry 26 of ScriptCommandHandlers) (E-0038)
ScriptCommand1B::
    farcall SceneWarubouLeaves
    ret

SECTION "Bank 10 ScriptCommand1C", ROMX

; Script command $1C (entry 27 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $1C): calls SceneWarubouWarning in bank $0F and
; returns. SceneWarubouWarning runs stage wScriptStep of its 5 stages (SceneWarubouWarning_Warp
; first, PersonalityMessage_WaitForMessage last). Scripts start it with
; SCRIPT_SCENE_WARUBOU_WARNING: Script_HeroReceivedTheGreatLog (between 'Warubou: Dangerous are
; other worlds! So...' and 'Slash: Hey, why the long faces?'). (C1, E-0376)
; runs one frame of script command type 1C (entry 27 of ScriptCommandHandlers) (E-0038)
ScriptCommand1C::
    farcall SceneWarubouWarning
    ret

SECTION "Bank 10 ScriptCommand1D", ROMX

; Script command $1D (entry 28 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $1D): calls SceneLongFaces in bank $0F and
; returns. SceneLongFaces runs stage wScriptStep of its 13 stages (SceneHomecoming_WaitMessage
; first, SceneLongFaces_Finish last). Scripts start it with SCRIPT_SCENE_LONG_FACES:
; Script_HeroReceivedTheGreatLog (after 'Slash: Hey, why the long faces?'). (C1, E-0376)
; runs one frame of script command type 1D (entry 28 of ScriptCommandHandlers) (E-0038)
ScriptCommand1D::
    farcall SceneLongFaces
    ret

SECTION "Bank 10 ScriptCommand1E", ROMX

; Script command $1E (entry 29 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $1E): calls ReplaceFoodWithWaterCall in bank $73
; and returns. ReplaceFoodWithWaterCall looks for items $19, $1A, $1B and $1C in that order
; (FindTemp0InInventoryList); the first one found is replaced by item $30, wInventorySortFlags bit 6
; is set and wScriptStartRequest = $80. With none of them it returns without ending, so the command
; runs again next frame. Scripts start it with SCRIPT_CHECK_ITEM: Script_HeroHandedOverSome (after
; 'That will help you for...'). (C2, E-0376)
; runs one frame of script command type 1E (entry 29 of ScriptCommandHandlers) (E-0038)
ScriptCommand1E::
    farcall ReplaceFoodWithWaterCall
    ret

SECTION "Bank 10 ScriptCommand1F", ROMX

; Script command $1F (entry 30 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $1F): calls SceneMonsterInspection in bank $0F and
; returns. SceneMonsterInspection runs stage wScriptStep of its 10 stages
; (SceneMonsterInspection_ShowAndThatWasThe first, SceneMonsterInspection_Finish last). Scripts
; start it with SCRIPT_SCENE_MONSTER_INSPECTION: Script_DidYouSayYes and
; Script_AhThreeHealthyMonsters (between 'Did you say yes? Yes,...' and 'Very good show! That
; was...'). (C1, E-0376)
; runs one frame of script command type 1F (entry 30 of ScriptCommandHandlers) (E-0038)
ScriptCommand1F::
    farcall SceneMonsterInspection
    ret

SECTION "Bank 10 ScriptCommand20", ROMX

; Script command $20 (entry 31 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $20): calls ScriptCommand20_Run in bank $73 and
; returns. ScriptCommand20_Run runs stage wScriptStep of its 4 stages: stage 0 sets wScriptParam0 =
; 0 when the second follower record is at ($40, $20), else 1; the last,
; ScriptCommand20_Run_FaceAndSetFlag, after 60 frames plays sound $72, turns object 0 (wSpriteSlots
; + 7 = (hPlayerFacing + 2) & 3, X = $40), sets EVENT_SCRIPT_COMMAND20_TURNED and
; wScriptStartRequest = $80. No script_command in src names type $20. (C2, E-0376)
; runs one frame of script command type 20 (entry 31 of ScriptCommandHandlers) (E-0038)
ScriptCommand20::
    farcall ScriptCommand20_Run
    ret

SECTION "Bank 10 ScriptCommand21", ROMX

; Script command $21 (entry 32 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $21): calls SceneKingAudience in bank $73 and
; returns. SceneKingAudience runs stage wScriptStep of its 2 stages (SceneKingAudience_Wait first,
; SceneKingAudience_HideObject last). Scripts start it with SCRIPT_SCENE_KING_AUDIENCE:
; Script_KingYouWishTo (between 'King: You wish to see our...' and 'King: I see. This is what...').
; (C1, E-0376)
; runs one frame of script command type 21 (entry 32 of ScriptCommandHandlers) (E-0038)
ScriptCommand21::
    farcall SceneKingAudience
    ret

SECTION "Bank 10 ScriptCommand22", ROMX

; Script command $22 (entry 33 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $22): calls SceneCanalGate in bank $85 and
; returns. SceneCanalGate runs stage wScriptStep of its 7 stages (SceneCanalGate_Hop first,
; SceneCanalGate_RaiseGate last). Scripts start it with SCRIPT_SCENE_CANAL_GATE:
; Script_WhatOpenTheCanal (after 'What? Open the Canal Gate...'). (C1, E-0376)
; runs one frame of script command type 22 (entry 33 of ScriptCommandHandlers) (E-0038)
ScriptCommand22::
    farcall SceneCanalGate
    ret

SECTION "Bank 10 ScriptCommand23", ROMX

; Script command $23 (entry 34 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $23): calls SceneWaterShortage in bank $0F and
; returns. SceneWaterShortage runs stage wScriptStep of its 5 stages (SceneWaterShortage_WalkPlayer
; first, SceneWaterShortage_Finish last). Scripts start it with SCRIPT_SCENE_WATER_SHORTAGE:
; Script_KingTheTown (before 'King: Wha-what? What happened?'). (C1, E-0376)
; runs one frame of script command type 23 (entry 34 of ScriptCommandHandlers) (E-0038)
ScriptCommand23::
    farcall SceneWaterShortage
    ret

SECTION "Bank 10 ScriptCommand24", ROMX

; Script command $24 (entry 35 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $24): calls SceneTreasureTheft in bank $85 and
; returns. SceneTreasureTheft runs stage wScriptStep of its 9 stages
; (SceneTreasureTheft_ShowKingTheHideoutOf first, SceneTreasureTheft_WalkOff last). Scripts start it
; with SCRIPT_SCENE_TREASURE_THEFT: Script_KingTheTown (between 'King: What? Arrrrgh! Round up
; all...' and 'King: I apologize, but my treasures...'). (C1, E-0376)
; runs one frame of script command type 24 (entry 35 of ScriptCommandHandlers) (E-0038)
ScriptCommand24::
    farcall SceneTreasureTheft
    ret

SECTION "Bank 10 ScriptCommand25", ROMX

; Script command $25 (entry 36 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $25): calls SceneWaterSolved in bank $73 and
; returns. SceneWaterSolved runs stage wScriptStep of its 2 stages (SceneWaterSolved_Warp first,
; SceneWaterSolved_SetScriptStartRequestTo80 last). Scripts start it with SCRIPT_SCENE_WATER_SOLVED:
; Script_I_13 (between 'You will? So we can...' and 'King: This should solve the water...'). (C1,
; E-0376)
; runs one frame of script command type 25 (entry 36 of ScriptCommandHandlers) (E-0038)
ScriptCommand25::
    farcall SceneWaterSolved
    ret

SECTION "Bank 10 ScriptCommand26", ROMX

; Script command $26 (entry 37 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $26): calls SceneMonstersInTow in bank $73 and
; returns. SceneMonstersInTow runs stage wScriptStep of its 4 stages
; (SceneMonstersInTow_SavePalettes first, SceneMonstersInTow_SetScriptStartRequestTo80 last).
; Scripts start it with SCRIPT_SCENE_MONSTERS_IN_TOW: Script_SceneMonstersInTow. (C1, E-0376)
; runs one frame of script command type 26 (entry 37 of ScriptCommandHandlers) (E-0038)
ScriptCommand26::
    farcall SceneMonstersInTow
    ret

SECTION "Bank 10 ScriptCommand27", ROMX

; Script command $27 (entry 38 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $27): calls SceneRivalDefeated in bank $0F and
; returns. SceneRivalDefeated runs stage wScriptStep of its 36 stages (SceneRivalDefeated_BlinkOut
; first, SceneRivalDefeated_GiveKey last). Scripts start it with SCRIPT_SCENE_RIVAL_DEFEATED:
; Script_HehYouHaveMonsters and Script_YouAgainYou. (C1, E-0376)
; runs one frame of script command type 27 (entry 38 of ScriptCommandHandlers) (E-0038)
ScriptCommand27::
    farcall SceneRivalDefeated
    ret

SECTION "Bank 10 ScriptCommand28", ROMX

; Script command $28 (entry 39 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $28): calls ShakeScreen in bank $0F and returns.
; ShakeScreen runs stage wScriptStep of its 3 stages (ShakeScreen_Start first, ShakeScreen_Finish
; last). Scripts start it with SCRIPT_SHAKE_SCREEN: Script_TheBirdsAreNoisy. (C1, E-0376)
; runs one frame of script command type 28 (entry 39 of ScriptCommandHandlers) (E-0038)
ScriptCommand28::
    farcall ShakeScreen
    ret

SECTION "Bank 10 ScriptCommand29", ROMX

; Script command $29 (entry 40 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $29): calls SceneWhoAreYou in bank $0F and
; returns. SceneWhoAreYou runs stage wScriptStep of its 10 stages (SceneWhoAreYou_MoveDown first,
; SceneWhoAreYou_KeepInStep last). Scripts start it with SCRIPT_SCENE_WHO_ARE_YOU:
; Script_SceneWhoAreYou. (C1, E-0376)
; runs one frame of script command type 29 (entry 40 of ScriptCommandHandlers) (E-0038)
ScriptCommand29::
    farcall SceneWhoAreYou
    ret

SECTION "Bank 10 ScriptCommand2A", ROMX

; Script command $2A (entry 41 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $2A): calls SceneWatchOut in bank $85 and returns.
; SceneWatchOut runs stage wScriptStep of its 19 stages (SceneWatchOut_ShowHmYouAreQuite first,
; SceneWatchOut_BackToStep14 last). Scripts start it with SCRIPT_SCENE_WATCH_OUT:
; Script_WhoAreYouThis, Script_YouCanKeepTrying and Script_SceneWatchOut (after 'Who are you? This
; is...'). (C1, E-0376)
; runs one frame of script command type 2A (entry 41 of ScriptCommandHandlers) (E-0038)
ScriptCommand2A::
    farcall SceneWatchOut
    ret

SECTION "Bank 10 ScriptCommand2B", ROMX

; Script command $2B (entry 42 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $2B): calls SceneMermaidSong in bank $73 and
; returns. SceneMermaidSong runs stage wScriptStep of its 13 stages (SceneMermaidSong2_WalkPlayer
; first, SceneMermaidSong_MoveOff last). Scripts start it with SCRIPT_SCENE_MERMAID_SONG:
; Script_ThenI_2. (C1, E-0376)
; runs one frame of script command type 2B (entry 42 of ScriptCommandHandlers) (E-0038)
ScriptCommand2B::
    farcall SceneMermaidSong
    ret

SECTION "Bank 10 ScriptCommand2C", ROMX

; Script command $2C (entry 43 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $2C): calls SceneDancing in bank $73 and returns.
; SceneDancing runs stage wScriptStep of its 9 stages (the first five shared with
; SceneMermaidSong2); the last, SceneDancing_SetScriptStartRequestTo80, only sets
; wScriptStartRequest = $80. Scripts start it with SCRIPT_SCENE_DANCING: Script_ThenI. (C2, E-0376)
; runs one frame of script command type 2C (entry 43 of ScriptCommandHandlers) (E-0038)
ScriptCommand2C::
    farcall SceneDancing
    ret

SECTION "Bank 10 ScriptCommand2D", ROMX

; Script command $2D (entry 44 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $2D): calls SceneMermaidSong2 in bank $73 and
; returns. SceneMermaidSong2 runs stage wScriptStep of its 11 stages (SceneMermaidSong2_WalkPlayer
; first, SceneMermaidSong2_SetScriptStartRequestTo80 last). Scripts start it with
; SCRIPT_SCENE_MERMAID_SONG_2: Script_ThenI_3. (C1, E-0376)
; runs one frame of script command type 2D (entry 44 of ScriptCommandHandlers) (E-0038)
ScriptCommand2D::
    farcall SceneMermaidSong2
    ret

SECTION "Bank 10 ScriptCommand2E", ROMX

; Script command $2E (entry 45 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $2E): calls WarpMap41 in bank $73 and returns.
; WarpMap41: at stage 0 it calls WarpToMap41 (map $41, screen (0, 1), position ($70, $30),
; transition kind 1, ScriptStartFadeAndAdvanceStep, sets EVENT_IN_THE_PAST_MERMAIDS_ARE); a later
; call sets wScriptStartRequest = $80. Scripts start it with SCRIPT_WARP_MAP41:
; Script_CloseYourEyesA (after 'Close your eyes a little...'). (C1, E-0376)
; runs one frame of script command type 2E (entry 45 of ScriptCommandHandlers) (E-0038)
ScriptCommand2E::
    farcall WarpMap41
    ret

SECTION "Bank 10 ScriptCommand2F", ROMX

; Script command $2F (entry 46 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $2F): calls SceneTentacles in bank $73 and
; returns. SceneTentacles: at stage 0 it sets a warp to map $3C, screen (0, 0), position ($50, $40),
; transition kind 4 and starts it (ScriptStartFadeAndAdvanceStep: palette fade, wModeState = 4, next
; stage); a later call sets wScriptStartRequest = $80. Scripts start it with SCRIPT_SCENE_TENTACLES:
; Script_CloseYourEyesFor (after 'Close your eyes for a...'). (C1, E-0376)
; runs one frame of script command type 2F (entry 46 of ScriptCommandHandlers) (E-0038)
ScriptCommand2F::
    farcall SceneTentacles
    ret

SECTION "Bank 10 ScriptCommand30", ROMX

; Script command $30 (entry 47 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $30): calls SceneSailorRing in bank $73 and
; returns. SceneSailorRing runs stage wScriptStep of its 2 stages (SceneSailorRing_Warp first,
; SceneSailorRing_SetScriptStartRequestTo80 last). Scripts start it with SCRIPT_SCENE_SAILOR_RING:
; Script_SceneSailorRing. (C1, E-0376)
; runs one frame of script command type 30 (entry 47 of ScriptCommandHandlers) (E-0038)
ScriptCommand30::
    farcall SceneSailorRing
    ret

SECTION "Bank 10 ScriptCommand31", ROMX

; Script command $31 (entry 48 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $31): calls ScenePirateGhosts in bank $85 and
; returns. ScenePirateGhosts runs stage wScriptStep of its 3 stages (ScenePirateGhosts_CrateHint
; first, ScenePirateGhosts_BlinkOut last). Scripts start it with SCRIPT_SCENE_PIRATE_GHOSTS:
; Script_HowCouldWeDie, Script_TheTreasuresAreOurs and Script_ItNagsAndNags (after 'How could we die
; before...'). (C1, E-0376)
; runs one frame of script command type 31 (entry 48 of ScriptCommandHandlers) (E-0038)
ScriptCommand31::
    farcall ScenePirateGhosts
    ret

SECTION "Bank 10 ScriptCommand32", ROMX

; Script command $32 (entry 49 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $32): calls GiveItemBlink in bank $0F and returns.
; GiveItemBlink has one stage: it blinks object 0 at Y $20 (or $40 when EVENT_GIVE_ITEM_BLINK is
; set) for 120 frames (ScriptStepBlinkObjectTemp0); after a blink at $40 it adds item $33
; (AppendItemStepPtrLoToInventory) when EVENT_YOU_WILL_THANK_YOU_LET is set; then it hides the
; sprites (wSpriteSlotCount = 0) and sets wScriptStartRequest = $80. Scripts start it with
; SCRIPT_GIVE_ITEM_BLINK: Script_WhoDisturbsUsIn, Script_YouSeemToNot, Script_YouStartledMeI,
; Script_YouStartledMeI_2, Script_YouWillThankYou, Script_YouStartledMeI_3, Script_IDon_2,
; Script_IDon_3, Script_YouWillThankYou_3 and Script_IDon_4 (between 'You will? Thank you! Let...'
; and '0 obtained YunaSoul.'). (C2, E-0376)
; runs one frame of script command type 32 (entry 49 of ScriptCommandHandlers) (E-0038)
ScriptCommand32::
    farcall GiveItemBlink
    ret

SECTION "Bank 10 ScriptCommand33", ROMX

; Script command $33 (entry 50 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $33): calls SceneCrate in bank $73 and returns.
; SceneCrate runs stage wScriptStep of its 9 stages (SceneCrate_Warp first,
; ScriptStepBlinkSpritesThenEnd last). Scripts start it with SCRIPT_SCENE_CRATE:
; Script_HeroCheckedTheTreasure (after '0 checked the treasure chest. 0...'). (C1, E-0376)
; runs one frame of script command type 33 (entry 50 of ScriptCommandHandlers) (E-0038)
ScriptCommand33::
    farcall SceneCrate
    ret

SECTION "Bank 10 ScriptCommand34", ROMX

; Script command $34 (entry 51 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $34): calls SetTilesFlag310 in bank $73 and
; returns. SetTilesFlag310 writes tiles $58-$5B into wScreenTileBuffer + $AA, $AB, $BE and $BF,
; redraws the screen (DrawFullScreenBufferAtScroll), sets wStoryFlags + $62 bit 0 (story flag $310)
; and sets wScriptStartRequest = $80. Scripts start it with SCRIPT_SET_TILES_FLAG_310:
; Script_HeroCheckedTheCrate (after '0 checked the crate. There was...'). (C1, E-0376)
; runs one frame of script command type 34 (entry 51 of ScriptCommandHandlers) (E-0038)
ScriptCommand34::
    farcall SetTilesFlag310
    ret

SECTION "Bank 10 ScriptCommand35", ROMX

; Script command $35 (entry 52 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $35): calls SceneKamehaEscape in bank $73 and
; returns. SceneKamehaEscape runs stage wScriptStep of its 22 stages (SceneKamehaEscape_PlayMusic
; first, SceneKamehaEscape_SetScriptStartRequestTo80 last). Scripts start it with
; SCRIPT_SCENE_KAMEHA_ESCAPE: Script_SceneKamehaEscape. (C1, E-0376)
; runs one frame of script command type 35 (entry 52 of ScriptCommandHandlers) (E-0038)
ScriptCommand35::
    farcall SceneKamehaEscape
    ret

SECTION "Bank 10 ScriptCommand36", ROMX

; Script command $36 (entry 53 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $36): calls SceneKamehaCaught in bank $0F and
; returns. SceneKamehaCaught has 2 stages: SceneKamehaCaught_StartMoving sets bit 2 of the flags of
; objects 0-2 and clears wScriptParam0; SceneKamehaCaught_MoveOff moves objects 0-2 up two pixels a
; frame (skipping any at Y $E0) and, once object 2 is at $E0, sets wSpriteSlotCount = 0 and
; wScriptStartRequest = $80. Scripts start it with SCRIPT_SCENE_KAMEHA_CAUGHT:
; Script_KamehaWahahahahThanksFor (after 'Kameha: Wahahahah! Thanks for guiding me...'). (C2,
; E-0376)
; runs one frame of script command type 36 (entry 53 of ScriptCommandHandlers) (E-0038)
ScriptCommand36::
    farcall SceneKamehaCaught
    ret

SECTION "Bank 10 ScriptCommand37", ROMX

; Script command $37 (entry 54 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $37): calls SceneCrewFollows in bank $0F and
; returns. SceneCrewFollows runs stage wScriptStep of its 4 stages (SceneCrewFollows_MoveRight
; first, SceneCrewFollows_TurnObjects last). Scripts start it with SCRIPT_SCENE_CREW_FOLLOWS:
; Script_KamehaUrkHowYou. (C1, E-0376)
; runs one frame of script command type 37 (entry 54 of ScriptCommandHandlers) (E-0038)
ScriptCommand37::
    farcall SceneCrewFollows
    ret

SECTION "Bank 10 ScriptCommand38", ROMX

; Script command $38 (entry 55 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $38): calls SceneKamehaFlees in bank $0F and
; returns. SceneKamehaFlees runs stage wScriptStep of its 13 stages (SceneKamehaFlees_Gather first,
; SceneKamehaFlees_BobObjectOff last). Scripts start it with SCRIPT_SCENE_KAMEHA_FLEES:
; Script_KamehaArrrrhClearThe. (C1, E-0376)
; runs one frame of script command type 38 (entry 55 of ScriptCommandHandlers) (E-0038)
ScriptCommand38::
    farcall SceneKamehaFlees
    ret

SECTION "Bank 10 ScriptCommand39", ROMX

; Script command $39 (entry 56 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $39): calls SceneMermaidKingdom in bank $0F and
; returns. SceneMermaidKingdom runs stage wScriptStep of its 50 stages
; (SceneMermaidKingdom_WalkPlayerLeftAndFaceDown first, SceneMermaidKingdom_GiveKey last); command
; $3B runs the same routine. Scripts start it with SCRIPT_SCENE_MERMAID_KINGDOM:
; Script_SceneMermaidKingdom. (C1, E-0376)
; runs one frame of script command type 39 (entry 56 of ScriptCommandHandlers) (E-0038)
ScriptCommand39::
    farcall SceneMermaidKingdom
    ret

SECTION "Bank 10 ScriptCommand3A", ROMX

; Script command $3A (entry 57 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $3A): calls SceneMasterThanks in bank $73 and
; returns. SceneMasterThanks runs stage wScriptStep of its 12 stages (SceneMasterThanks_FindMaster
; first, SceneMasterThanks_Hop last). Scripts start it with SCRIPT_SCENE_MASTER_THANKS:
; Script_RReallyWowThank. (C1, E-0376)
; runs one frame of script command type 3A (entry 57 of ScriptCommandHandlers) (E-0038)
ScriptCommand3A::
    farcall SceneMasterThanks
    ret

SECTION "Bank 10 ScriptCommand3B", ROMX

; Script command $3B (entry 58 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $3B): calls SceneMermaidKingdom in bank $0F and
; returns. This is the same work as command $39 (ScriptCommand39): SceneMermaidKingdom runs stage
; wScriptStep of its 50 stages. No script command constant in macros.inc has the value $3B, so no
; script_command in src names it. (C1, E-0376)
; runs one frame of script command type 3B (entry 58 of ScriptCommandHandlers) (E-0038)
ScriptCommand3B::
    farcall SceneMermaidKingdom
    ret

SECTION "Bank 10 ScriptCommand3C", ROMX

; Script command $3C (entry 59 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $3C): calls RewardItemOrKey in bank $73 and
; returns. RewardItemOrKey runs stage wScriptStep of its 20 stages (RewardItemOrKey_FindDigger
; first, RewardItemOrKey_GiveReward last). Scripts start it with SCRIPT_REWARD_ITEM_OR_KEY:
; Script_GreatHeroThanksA, Script_GreatHeroThanksA_2 and Script_GreatHeroThanksA_3 (between 'Great,
; 0! Thanks a lot!' and 'Here, 0! You need this!'). (C1, E-0376)
; runs one frame of script command type 3C (entry 59 of ScriptCommandHandlers) (E-0038)
ScriptCommand3C::
    farcall RewardItemOrKey
    ret

SECTION "Bank 10 ScriptCommand3D", ROMX

; Script command $3D (entry 60 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $3D): calls RewardItemOrKey2 in bank $73 and
; returns. RewardItemOrKey2 runs stage wScriptStep of its 10 stages (RewardItemOrKey2_FindDigger
; first, RewardItemOrKey2_GiveReward last). Scripts start it with SCRIPT_REWARD_ITEM_OR_KEY_2:
; Script_FantasticICanOpen, Script_FantasticICanOpen_2 and Script_FantasticICanOpen_3 (between
; 'Fantastic! I can open my...' and 'I like you to have...'). (C1, E-0376)
; runs one frame of script command type 3D (entry 60 of ScriptCommandHandlers) (E-0038)
ScriptCommand3D::
    farcall RewardItemOrKey2
    ret

SECTION "Bank 10 ScriptCommand3E", ROMX

; Script command $3E (entry 61 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $3E): calls SceneStrongestMaster in bank $73 and
; returns. SceneStrongestMaster runs stage wScriptStep of its 4 stages
; (SceneStrongestMaster_SetUpSprite first, SceneStrongestMaster_DrawBlock last). Scripts start it
; with SCRIPT_SCENE_STRONGEST_MASTER: Script_SceneStrongestMaster. (C1, E-0376)
; runs one frame of script command type 3E (entry 61 of ScriptCommandHandlers) (E-0038)
ScriptCommand3E::
    farcall SceneStrongestMaster
    ret

SECTION "Bank 10 ScriptCommand3F", ROMX

; Script command $3F (entry 62 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $3F): calls BlinkSprites in bank $73 and returns.
; BlinkSprites sets wSpriteSlotCount to 1 while wFrameCounterLo bit 2 is set and to 2 otherwise, and
; moves object 1 down one pixel; at Y $70 it leaves wSpriteSlotCount = 2 and sets
; wScriptStartRequest = $80. Scripts start it with SCRIPT_BLINK_SPRITES: Script_YouWillNoWords
; (after 'You will? No words of...'). (C2, E-0376)
; runs one frame of script command type 3F (entry 62 of ScriptCommandHandlers) (E-0038)
ScriptCommand3F::
    farcall BlinkSprites
    ret

SECTION "Bank 10 ScriptCommand40", ROMX

; Script command $40 (entry 63 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $40): calls SceneSpiritEnvoy in bank $0F and
; returns. SceneSpiritEnvoy runs stage wScriptStep of its 11 stages (SceneReportToKing_WalkUp first,
; SceneSpiritEnvoy_ResumeScript last). Scripts start it with SCRIPT_SCENE_SPIRIT_ENVOY:
; Script_AhYouAreThe. (C1, E-0376)
; runs one frame of script command type 40 (entry 63 of ScriptCommandHandlers) (E-0038)
ScriptCommand40::
    farcall SceneSpiritEnvoy
    ret

SECTION "Bank 10 ScriptCommand41", ROMX

; Script command $41 (entry 64 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $41): calls SceneExplosion in bank $0F and
; returns. SceneExplosion runs stage wScriptStep of its 10 stages (SceneExplosion_Start first,
; SceneExplosion_DropObject last). Scripts start it with SCRIPT_SCENE_EXPLOSION:
; Script_WhatWhatWasThat and Script_WhatWhatWasThat_2 (before 'What? What was that explosion?').
; (C1, E-0376)
; runs one frame of script command type 41 (entry 64 of ScriptCommandHandlers) (E-0038)
ScriptCommand41::
    farcall SceneExplosion
    ret

SECTION "Bank 10 ScriptCommand42", ROMX

; Script command $42 (entry 65 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $42): calls SceneReportToKing in bank $0F and
; returns. SceneReportToKing runs stage wScriptStep of its 18 stages (SceneReportToKing_WalkUp
; first, SceneReportToKing_WalkDown last). Scripts start it with SCRIPT_SCENE_REPORT_TO_KING:
; Script_WeReportedToThe (after 'We reported to the King...'). (C1, E-0376)
; runs one frame of script command type 42 (entry 65 of ScriptCommandHandlers) (E-0038)
ScriptCommand42::
    farcall SceneReportToKing
    ret

SECTION "Bank 10 ScriptCommand43", ROMX

; Script command $43 (entry 66 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $43): calls SceneWallExit in bank $0F and returns.
; SceneWallExit runs stage wScriptStep of its 13 stages (SceneWallExit_Start first,
; SceneWallExit_WalkObject1Down last). Scripts start it with SCRIPT_SCENE_WALL_EXIT:
; Script_HeroTappedOnThe and Script_HeroTappedOnThe_2 (after '0 tapped on the wall. The...'). (C1,
; E-0376)
; runs one frame of script command type 43 (entry 66 of ScriptCommandHandlers) (E-0038)
ScriptCommand43::
    farcall SceneWallExit
    ret

SECTION "Bank 10 ScriptCommand44", ROMX

; Script command $44 (entry 67 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $44): calls SceneRealKing in bank $73 and returns.
; SceneRealKing runs stage wScriptStep of its 3 stages (SceneRealKing_Separate first,
; SceneRealKing_Restore last). Scripts start it with SCRIPT_SCENE_REAL_KING: Script_I_14. (C1,
; E-0376)
; runs one frame of script command type 44 (entry 67 of ScriptCommandHandlers) (E-0038)
ScriptCommand44::
    farcall SceneRealKing
    ret

SECTION "Bank 10 ScriptCommand45", ROMX

; Script command $45 (entry 68 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $45): calls ScenePlanRuined in bank $0F and
; returns. ScenePlanRuined runs stage wScriptStep of its 4 stages (ScenePlanRuined_Start first,
; ScenePlanRuined_BlinkOut last). Scripts start it with SCRIPT_SCENE_PLAN_RUINED: Script_ArrghYou
; and Script_ItAlmostWorkedTo (after 'It almost worked to perfection!'). (C1, E-0376)
; runs one frame of script command type 45 (entry 68 of ScriptCommandHandlers) (E-0038)
ScriptCommand45::
    farcall ScenePlanRuined
    ret

SECTION "Bank 10 ScriptCommand46", ROMX

; Script command $46 (entry 69 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $46): calls SceneCheerYuna in bank $0F and
; returns. SceneCheerYuna runs stage wScriptStep of its 17 stages (SceneCheerYuna_Dance first,
; SceneCheerYuna_FaceUp last). Scripts start it with SCRIPT_SCENE_CHEER_YUNA:
; Script_KingMagnificentDon. (C1, E-0376)
; runs one frame of script command type 46 (entry 69 of ScriptCommandHandlers) (E-0038)
ScriptCommand46::
    farcall SceneCheerYuna
    ret

SECTION "Bank 10 ScriptCommand47", ROMX

; Script command $47 (entry 70 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $47): calls SceneSpiritEnvoy2 in bank $73 and
; returns. SceneSpiritEnvoy2 has 2 stages: SceneSpiritEnvoy2_Float sets bit 1 of the flags of object
; 0 for 30 frames, then clears its byte 7 and sets EVENT_SCENE_SPIRIT_ENVOY2 (or
; EVENT_SCENE_SPIRIT_ENVOY2_099 when that is already set); SceneSpiritEnvoy2_BlinkAway lowers object
; 0 on odd counts and blinks the sprites out (ScriptStepBlinkSpritesThenEnd). Scripts start it with
; SCRIPT_SCENE_SPIRIT_ENVOY_2: Script_SceneSpiritEnvoy2. (C2, E-0376)
; runs one frame of script command type 47 (entry 70 of ScriptCommandHandlers) (E-0038)
ScriptCommand47::
    farcall SceneSpiritEnvoy2
    ret

SECTION "Bank 10 ScriptCommand48", ROMX

; Script command $48 (entry 71 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $48): calls ScenePrincessMedicine in bank $0F and
; returns. ScenePrincessMedicine runs stage wScriptStep of its 13 stages
; (ScenePrincessMedicine_Start first, PersonalityMessage_WaitForMessage last). Scripts start it with
; SCRIPT_SCENE_PRINCESS_MEDICINE: Script_Message and Script_Message_2 (after 'FOOLHARDY. BRAVE BUT
; FOOLISH.'). (C1, E-0376)
; runs one frame of script command type 48 (entry 71 of ScriptCommandHandlers) (E-0038)
ScriptCommand48::
    farcall ScenePrincessMedicine
    ret

SECTION "Bank 10 ScriptCommand49", ROMX

; Script command $49 (entry 72 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $49): calls SceneMedicineGiven in bank $0F and
; returns. SceneMedicineGiven runs stage wScriptStep of its 4 stages (SceneMedicineGiven_WalkUp
; first, SceneMedicineGiven_WalkObject1Back last). Scripts start it with
; SCRIPT_SCENE_MEDICINE_GIVEN: Script_PardonMeYouHave (after 'Pardon me? You have medicine?'). (C1,
; E-0376)
; runs one frame of script command type 49 (entry 72 of ScriptCommandHandlers) (E-0038)
ScriptCommand49::
    farcall SceneMedicineGiven
    ret

SECTION "Bank 10 ScriptCommand4A", ROMX

; Script command $4A (entry 73 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $4A): calls SceneShield in bank $0F and returns.
; SceneShield runs stage wScriptStep of its 12 stages (SceneShield_ShowTchObstinateAndFoolish first,
; PersonalityMessage_WaitForMessage last). Scripts start it with SCRIPT_SCENE_SHIELD:
; Script_HeroCheckedTheShield_2 and Script_SceneShield (after '0 checked the shield.'). (C1, E-0376)
; runs one frame of script command type 4A (entry 73 of ScriptCommandHandlers) (E-0038)
ScriptCommand4A::
    farcall SceneShield
    ret

SECTION "Bank 10 ScriptCommand4B", ROMX

; Script command $4B (entry 74 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $4B): calls SceneShield2 in bank $0F and returns.
; SceneShield2 runs stage wScriptStep of its 23 stages (SceneShield2_ShowObject first,
; SceneShield2_GiveKey last). Scripts start it with SCRIPT_SCENE_SHIELD_2: Script_SceneShield2. (C1,
; E-0376)
; runs one frame of script command type 4B (entry 74 of ScriptCommandHandlers) (E-0038)
ScriptCommand4B::
    farcall SceneShield2
    ret

SECTION "Bank 10 ScriptCommand4C", ROMX

; Script command $4C (entry 75 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $4C): calls ScriptCommand4C_Run in bank $73 and
; returns. ScriptCommand4C_Run runs stage wScriptStep of its 2 stages
; (ScriptCommand4C_Run_PlaceObject, ScriptCommand4C_Run_RaiseObject). No script_command in src names
; type $4C. (C1, E-0376)
; runs one frame of script command type 4C (entry 75 of ScriptCommandHandlers) (E-0038)
ScriptCommand4C::
    farcall ScriptCommand4C_Run
    ret

SECTION "Bank 10 ScriptCommand4D", ROMX

; Script command $4D (entry 76 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $4D): calls SceneWaterReward in bank $85 and
; returns. SceneWaterReward runs stage wScriptStep of its 19 stages
; (SceneWaterReward_ShowCoohIHeardFrom first, SceneWatchOut_BackToStep14 last). Scripts start it
; with SCRIPT_SCENE_WATER_REWARD: Script_SceneWaterReward. (C1, E-0376)
; runs one frame of script command type 4D (entry 76 of ScriptCommandHandlers) (E-0038)
ScriptCommand4D::
    farcall SceneWaterReward
    ret

SECTION "Bank 10 ScriptCommand4E", ROMX

; Script command $4E (entry 77 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $4E): calls SceneGrave in bank $0F and returns.
; SceneGrave runs stage wScriptStep of its 5 stages (SceneGrave_Flicker first, SceneGrave_BlinkOut
; last). Scripts start it with SCRIPT_SCENE_GRAVE: Script_HeroCheckedTheGrave and
; Script_HeroCheckedTheGrave_2 (after '0 checked the grave. There was...'). (C1, E-0376)
; runs one frame of script command type 4E (entry 77 of ScriptCommandHandlers) (E-0038)
ScriptCommand4E::
    farcall SceneGrave
    ret

SECTION "Bank 10 ScriptCommand4F", ROMX

; Script command $4F (entry 78 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $4F): calls SetTilesD2 in bank $73 and returns.
; SetTilesD2 writes tiles $68-$6B into wScreenTileBuffer + $D2, $D3, $E6 and $E7, redraws the screen
; (DrawFullScreenBufferAtScroll) and sets wScriptStartRequest = $80. Scripts start it with
; SCRIPT_SET_TILES_D2: Script_FineYou. (C1, E-0376)
; runs one frame of script command type 4F (entry 78 of ScriptCommandHandlers) (E-0038)
ScriptCommand4F::
    farcall SetTilesD2
    ret

SECTION "Bank 10 ScriptCommand50", ROMX

; Script command $50 (entry 79 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $50): calls SceneMadcondor in bank $73 and
; returns. SceneMadcondor runs stage wScriptStep of its 3 stages; stage 0 (SceneMadcondor_Start)
; waits 60 frames, then sets bit 2 of the flags of object 0 and wMessageIndex/wMessageGroup = $03C0
; and moves on. Scripts start it with SCRIPT_SCENE_MADCONDOR: Script_Kweeeeh (after 'Look! A
; MadCondor! It has something!'). (C2, E-0376)
; runs one frame of script command type 50 (entry 79 of ScriptCommandHandlers) (E-0038)
ScriptCommand50::
    farcall SceneMadcondor
    ret

SECTION "Bank 10 ScriptCommand51", ROMX

; Script command $51 (entry 80 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $51): calls SceneMadcondorCry in bank $73 and
; returns. SceneMadcondorCry runs stage wScriptStep of its 6 stages (SceneMadcondorCry_Start first,
; SceneWizstone_WaitMessage last). Scripts start it with SCRIPT_SCENE_MADCONDOR_CRY: Script_Kweeeeeh
; (after 'Kweeeeeh!'). (C1, E-0376)
; runs one frame of script command type 51 (entry 80 of ScriptCommandHandlers) (E-0038)
ScriptCommand51::
    farcall SceneMadcondorCry
    ret

SECTION "Bank 10 ScriptCommand52", ROMX

; Script command $52 (entry 81 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $52): calls SceneSmallHole in bank $73 and
; returns. SceneSmallHole: at stage 0 it sets a warp to map $82, screen (1, 2), position ($40, $80),
; transition kind 3 and starts it (ScriptStartFadeAndAdvanceStep); a later call sets
; wScriptStartRequest = $80. Scripts start it with SCRIPT_SCENE_SMALL_HOLE:
; Script_HeroCheckedTheSmall (after '0 checked the small hole. It...'). (C1, E-0376)
; runs one frame of script command type 52 (entry 81 of ScriptCommandHandlers) (E-0038)
ScriptCommand52::
    farcall SceneSmallHole
    ret

SECTION "Bank 10 ScriptCommand53", ROMX

; Script command $53 (entry 82 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $53): calls SceneJustice in bank $73 and returns.
; SceneJustice moves tile blocks of wScreenTileBuffer chosen by the position of the player
; (SceneJustice_AnimateTileBlock); once the blocks at + $52, $60, $F2 and $100 all read $10 it plays
; sound $66, writes tiles $46-$4B at + $30 and + $44, and sets wStoryFlags + $64 bit 0 and
; EVENT_SCENE_JUSTICE. Every call redraws the screen and sets wScriptStartRequest = $80. Scripts
; start it with SCRIPT_SCENE_JUSTICE: Script_SceneJustice. (C1, E-0376)
; runs one frame of script command type 53 (entry 82 of ScriptCommandHandlers) (E-0038)
ScriptCommand53::
    farcall SceneJustice
    ret

SECTION "Bank 10 ScriptCommand54", ROMX

; Script command $54 (entry 83 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $54): calls SceneGravestone in bank $73 and
; returns. SceneGravestone runs stage wScriptStep of its 5 stages (SceneGravestone_StartPush first,
; SceneGravestone_Open last). Scripts start it with SCRIPT_SCENE_GRAVESTONE: Script_SceneGravestone.
; (C1, E-0376)
; runs one frame of script command type 54 (entry 83 of ScriptCommandHandlers) (E-0038)
ScriptCommand54::
    farcall SceneGravestone
    ret

SECTION "Bank 10 ScriptCommand55", ROMX

; Script command $55 (entry 84 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $55): calls SetFlag322 in bank $73 and returns.
; SetFlag322 sets wStoryFlags + $64 bit 2 (story flag $322) and wScriptStartRequest = $80. Scripts
; start it with SCRIPT_SET_FLAG_322: Script_ADoorOpenedSomewhere. (C2, E-0376)
; runs one frame of script command type 55 (entry 84 of ScriptCommandHandlers) (E-0038)
ScriptCommand55::
    farcall SetFlag322
    ret

SECTION "Bank 10 ScriptCommand56", ROMX

; Script command $56 (entry 85 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $56): calls SceneBeatenFairly in bank $73 and
; returns. SceneBeatenFairly: it blinks object 0 at Y $30 for 120 frames
; (ScriptStepBlinkObjectTemp0: hidden at Y $E0 in the off phases), then sets wSpriteSlotCount = 0
; and wScriptStartRequest = $80. Scripts start it with SCRIPT_SCENE_BEATEN_FAIRLY:
; Script_YouOvercameTheTraps and Script_WahahahahHereAgainAre. (C2, E-0376)
; runs one frame of script command type 56 (entry 85 of ScriptCommandHandlers) (E-0038)
ScriptCommand56::
    farcall SceneBeatenFairly
    ret

SECTION "Bank 10 ScriptCommand57", ROMX

; Script command $57 (entry 86 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $57): calls SceneThreeItemsBattle in bank $73 and
; returns. SceneThreeItemsBattle runs stage wScriptStep of its 4 stages
; (SceneThreeItemsBattle_StartBattle first, SceneThreeItemsBattle_BlinkOut last). Scripts start it
; with SCRIPT_SCENE_THREE_ITEMS_BATTLE: Script_AhSoGoodOf and Script_FwahahahaDon (after 'Good. You
; have brought the...'). (C1, E-0376)
; runs one frame of script command type 57 (entry 86 of ScriptCommandHandlers) (E-0038)
ScriptCommand57::
    farcall SceneThreeItemsBattle
    ret

SECTION "Bank 10 ScriptCommand58", ROMX

; Script command $58 (entry 87 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $58): calls SceneThreeItems in bank $0F and
; returns. SceneThreeItems runs stage wScriptStep of its 44 stages
; (SceneThreeItems_RedrawSideColumns first, SceneThreeItems_GiveKeys last). Scripts start it with
; SCRIPT_SCENE_THREE_ITEMS: Script_KamehaSoItWas (after 'Kameha: If the three items that...'). (C1,
; E-0376)
; runs one frame of script command type 58 (entry 87 of ScriptCommandHandlers) (E-0038)
ScriptCommand58::
    farcall SceneThreeItems
    ret

SECTION "Bank 10 ScriptCommand59", ROMX

; Script command $59 (entry 88 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $59): calls SceneSawKameha in bank $73 and
; returns. SceneSawKameha runs stage wScriptStep of its 3 stages (SceneSawKameha_WalkUp first,
; SceneSawKameha_AddKey last). Scripts start it with SCRIPT_SCENE_SAW_KAMEHA: Script_What and
; Script_What_2 (before 'Sire, this child claims to...'). (C1, E-0376)
; runs one frame of script command type 59 (entry 88 of ScriptCommandHandlers) (E-0038)
ScriptCommand59::
    farcall SceneSawKameha
    ret

SECTION "Bank 10 ScriptCommand5A", ROMX

; Script command $5A (entry 89 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $5A): calls SceneSawKameha in bank $73 and
; returns. SceneSawKameha runs stage wScriptStep of its 3 stages (SceneSawKameha_WalkUp first,
; SceneSawKameha_AddKey last). Scripts start it with SCRIPT_SCENE_KAMEHA_BACK:
; Script_IfTheIslandSink and Script_PeopleHaveBeenSaying (before 'Prince Kameha came back!
; What...'). (C1, E-0376)
; runs one frame of script command type 5A (entry 89 of ScriptCommandHandlers) (E-0038)
ScriptCommand5A::
    farcall SceneSawKameha
    ret

SECTION "Bank 10 ScriptCommand5B", ROMX

; Script command $5B (entry 90 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $5B): calls SceneLimbo in bank $85 and returns.
; SceneLimbo runs stage wScriptStep of its 16 stages (SceneLimbo_PlaceItem first,
; SceneLimbo_AddItems last). Scripts start it with SCRIPT_SCENE_LIMBO: Script_WarubouWaHeyTake_2
; (after 'Warubou: Wa-hey! Take the treasures that...'). (C1, E-0376)
; runs one frame of script command type 5B (entry 90 of ScriptCommandHandlers) (E-0038)
ScriptCommand5B::
    farcall SceneLimbo
    ret

SECTION "Bank 10 ScriptCommand5C", ROMX

; Script command $5C (entry 91 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $5C): calls TakeItem in bank $73 and returns.
; TakeItem blinks object 1 between Y $20 and $E0 for 120 frames, counting in wScriptParam0; then it
; removes items $36, $37 and $38 from the inventory (FindTemp0InInventoryList,
; RemoveInventorySlotShiftDown) and sets wScriptStartRequest = $80. A missing item is not checked:
; RemoveInventorySlotShiftDown then gets slot $FF. Scripts start it with SCRIPT_TAKE_ITEM:
; Script_SurprisinglyObedientAreYou (between '0 handed over the TidalBell. 0...' and 'Take these to
; Lord Darck...'). (C2, E-0376)
; runs one frame of script command type 5C (entry 91 of ScriptCommandHandlers) (E-0038)
ScriptCommand5C::
    farcall TakeItem
    ret

SECTION "Bank 10 ScriptCommand5D", ROMX

; Script command $5D (entry 92 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $5D): calls SceneDarckTaunt in bank $73 and
; returns. SceneDarckTaunt (the same code as SceneBeatenFairly): it blinks object 0 at Y $30 for 120
; frames (ScriptStepBlinkObjectTemp0: hidden at Y $E0 in the off phases), then sets wSpriteSlotCount
; = 0 and wScriptStartRequest = $80. Scripts start it with SCRIPT_SCENE_DARCK_TAUNT:
; Script_SurprisinglyObedientAreYou and Script_YouSeemToStill. (C2, E-0376)
; runs one frame of script command type 5D (entry 92 of ScriptCommandHandlers) (E-0038)
ScriptCommand5D::
    farcall SceneDarckTaunt
    ret

SECTION "Bank 10 ScriptCommand5E", ROMX

; Script command $5E (entry 93 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $5E): calls SceneDarckDefeated in bank $0F and
; returns. SceneDarckDefeated runs stage wScriptStep of its 149 stages (SceneDarckDefeated_BlinkOut
; first, PersonalityMessage_WaitForMessage last). Scripts start it with SCRIPT_SCENE_DARCK_DEFEATED:
; Script_DarckFawahahahYouChased and Script_DarckFwahahahahBravoSplendid. (C1, E-0376)
; runs one frame of script command type 5E (entry 93 of ScriptCommandHandlers) (E-0038)
ScriptCommand5E::
    farcall SceneDarckDefeated
    ret

SECTION "Bank 10 ScriptCommand5F", ROMX

; Script command $5F (entry 94 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $5F): calls SceneHomecoming in bank $0F and
; returns. SceneHomecoming runs stage wScriptStep of its 45 stages (SceneHomecoming_PlaceObject
; first, SceneHomecoming_SetScriptStartRequestTo80 last). Scripts start it with
; SCRIPT_SCENE_HOMECOMING: Script_CobiHeroCongratulationsI and Script_TaraHeroCongratulationsI
; (after 'Hehehe, no need to worry...'). (C1, E-0376)
; runs one frame of script command type 5F (entry 94 of ScriptCommandHandlers) (E-0038)
ScriptCommand5F::
    farcall SceneHomecoming
    ret

SECTION "Bank 10 ScriptCommand60", ROMX

; Script command $60 (entry 95 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $60): calls ScriptCommand60_Run in bank $73 and
; returns. ScriptCommand60_Run runs stage wScriptStep of its 5 stages
; (ScriptCommand60_Run_ShowObject first, ScriptCommand60_Run_TakeMedal last). No script_command in
; src names type $60. (C1, E-0376)
; runs one frame of script command type 60 (entry 95 of ScriptCommandHandlers) (E-0038)
ScriptCommand60::
    farcall ScriptCommand60_Run
    ret

SECTION "Bank 10 ScriptCommand61", ROMX

; Script command $61 (entry 96 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $61): calls SceneKamehaStole in bank $73 and
; returns. SceneKamehaStole runs stage wScriptStep of its 7 stages (SceneKamehaStole_GatherFollowers
; first, SceneKamehaStole_DrawBlocks last). Scripts start it with SCRIPT_SCENE_KAMEHA_STOLE:
; Script_SceneKamehaStole. (C1, E-0376)
; runs one frame of script command type 61 (entry 96 of ScriptCommandHandlers) (E-0038)
ScriptCommand61::
    farcall SceneKamehaStole
    ret

SECTION "Bank 10 ScriptCommand62", ROMX

; Script command $62 (entry 97 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $62): calls PersonalityMessage in bank $0F and
; returns. PersonalityMessage runs stage wScriptStep of its 2 stages (PersonalityMessage_PickMessage
; first, PersonalityMessage_WaitForMessage last). Scripts start it with SCRIPT_PERSONALITY_MESSAGE:
; Script_PersonalityMessage. (C1, E-0376)
; runs one frame of script command type 62 (entry 97 of ScriptCommandHandlers) (E-0038)
ScriptCommand62::
    farcall PersonalityMessage
    ret

SECTION "Bank 10 ScriptCommand63", ROMX

; Script command $63 (entry 98 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $63): calls SceneRivalFade in bank $73 and
; returns. SceneRivalFade: at stage 0 it sets a warp to map $28, screen (0, 1), position ($40, $80),
; transition kind 3, starts it (ScriptStartFadeAndAdvanceStep) and starts palette fade 4; a later
; call sets wScriptStartRequest = $80. Scripts start it with SCRIPT_SCENE_RIVAL_FADE:
; Script_SceneRivalFade. (C1, E-0376)
; runs one frame of script command type 63 (entry 98 of ScriptCommandHandlers) (E-0038)
ScriptCommand63::
    farcall SceneRivalFade
    ret

SECTION "Bank 10 ScriptCommand64", ROMX

; Script command $64 (entry 99 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $64): calls GatherFollowers in bank $73 and
; returns. GatherFollowers has 4 stages: stages 0-2 set wMapSpriteKind = $10 and run
; ScriptStepMoveFollowersToLeader (which sets the follower targets, steps the followers for 16
; frames and moves to the next stage); stage 3 sets wScriptStartRequest = $80. Scripts start it with
; SCRIPT_GATHER_FOLLOWERS: Script_HeroReadTheSign. (C2, E-0376)
; runs one frame of script command type 64 (entry 99 of ScriptCommandHandlers) (E-0038)
ScriptCommand64::
    farcall GatherFollowers
    ret

SECTION "Bank 10 ScriptCommand65", ROMX

; Script command $65 (entry 100 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $65): calls GrowthLimitInfo in bank $85 and
; returns. GrowthLimitInfo runs stage wScriptStep of its 3 stages (GrowthLimitInfo_ShowGrowthLimit
; first, GrowthLimitInfo_NextMember last). Scripts start it with SCRIPT_GROWTH_LIMIT_INFO:
; Script_OnceAMonsterReaches (before 'Once a monster reaches its growth...'). (C1, E-0376)
; runs one frame of script command type 65 (entry 100 of ScriptCommandHandlers) (E-0038)
ScriptCommand65::
    farcall GrowthLimitInfo
    ret

SECTION "Bank 10 ScriptCommand66", ROMX

; Script command $66 (entry 101 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $66): calls SceneShieldGuardian in bank $0F and
; returns. SceneShieldGuardian runs stage wScriptStep of its 16 stages
; (SceneShieldGuardian_ShowIWishYouWouldnt first, PersonalityMessage_WaitForMessage last). Scripts
; start it with SCRIPT_SCENE_SHIELD_GUARDIAN: Script_SceneShieldGuardian and
; Script_SceneShieldGuardian_2. (C1, E-0376)
; runs one frame of script command type 66 (entry 101 of ScriptCommandHandlers) (E-0038)
ScriptCommand66::
    farcall SceneShieldGuardian
    ret

SECTION "Bank 10 ScriptCommand67", ROMX

; Script command $67 (entry 102 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $67): calls SceneJustice2 in bank $73 and returns.
; SceneJustice2: it blinks object 0 at Y $20 ($50 when hMapId is not $8C and hMapScreenX is 1) for
; 120 frames (ScriptStepBlinkObjectTemp0: hidden at Y $E0 in the off phases), then sets
; wSpriteSlotCount = 0, wScriptStartRequest = $80 and story flag $C5 on map $8C, else $C6 on screen
; column 0, else $C7. Scripts start it with SCRIPT_SCENE_JUSTICE_2: Script_LetThePowerOf (after 'Let
; the power of justice...'). (C2, E-0376)
; runs one frame of script command type 67 (entry 102 of ScriptCommandHandlers) (E-0038)
ScriptCommand67::
    farcall SceneJustice2
    ret

SECTION "Bank 10 ScriptCommand68", ROMX

; Script command $68 (entry 103 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $68): calls SceneFoundMe in bank $73 and returns.
; SceneFoundMe walks object 0 one pixel a frame (StepObjectTowardCoord): right to X = $60 when
; hPlayerX is $40 or a follower record is at ($40, $40); left to X = $40 when hPlayerX is $60, a
; record is at ($60, $40) or none matches. On arrival it sets wScriptStartRequest = $80. Scripts
; start it with SCRIPT_SCENE_FOUND_ME: Script_I_17. (C2, E-0376)
; runs one frame of script command type 68 (entry 103 of ScriptCommandHandlers) (E-0038)
ScriptCommand68::
    farcall SceneFoundMe
    ret

SECTION "Bank 10 ScriptCommand69", ROMX

; Script command $69 (entry 104 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $69): calls SceneFoundMeBattle in bank $85 and
; returns. SceneFoundMeBattle runs stage wScriptStep of its 6 stages (SceneFoundMeBattle_ShowMessage
; first, SceneFoundMeBattle_SetGuardFlag last). Scripts start it with SCRIPT_SCENE_FOUND_ME_BATTLE:
; Script_SceneFoundMeBattle. (C1, E-0376)
; runs one frame of script command type 69 (entry 104 of ScriptCommandHandlers) (E-0038)
ScriptCommand69::
    farcall SceneFoundMeBattle
    ret

SECTION "Bank 10 ScriptCommand6A", ROMX

; Script command $6A (entry 105 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $6A): calls SceneHorsingAround in bank $0F and
; returns. SceneHorsingAround runs stage wScriptStep of its 4 stages, each moving the player two
; pixels a frame round a six-leg loop (SceneHorsingAround_StepPlayerAlongLoop); the last,
; SceneHorsingAround_HopObject0, also hops object 0 for 16 frames, then clears hPlayerStateFlags bit
; 2 and sets wScriptStartRequest = $80. Scripts start it with SCRIPT_SCENE_HORSING_AROUND:
; Script_ListenYouTwoQuit (before 'Listen you two! Quit your...'). (C2, E-0376)
; runs one frame of script command type 6A (entry 105 of ScriptCommandHandlers) (E-0038)
ScriptCommand6A::
    farcall SceneHorsingAround
    ret

SECTION "Bank 10 ScriptCommand6B", ROMX

; Script command $6B (entry 106 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $6B): calls SceneVaultSettled in bank $0F and
; returns. SceneVaultSettled runs stage wScriptStep of its 3 stages (SceneVaultSettled_HopFollower
; first, PersonalityMessage_WaitForMessage last). Scripts start it with SCRIPT_SCENE_VAULT_SETTLED:
; Script_You_3. (C1, E-0376)
; runs one frame of script command type 6B (entry 106 of ScriptCommandHandlers) (E-0038)
ScriptCommand6B::
    farcall SceneVaultSettled
    ret

SECTION "Bank 10 ScriptCommand6C", ROMX

; Script command $6C (entry 107 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $6C): calls GiveMonster in bank $85 and returns.
; GiveMonster creates a monster record (CreateMonsterRecordOfKindTemp1 with hTemp1 = 1, hTemp2 =
; wArg5, hTemp3 = 1) and sets wScriptStartRequest = $80. Scripts start it with SCRIPT_GIVE_MONSTER:
; Script_You_8. (C2, E-0376; probed E-0377)
; runs one frame of script command type 6C (entry 107 of ScriptCommandHandlers) (E-0038)
ScriptCommand6C::
    farcall GiveMonster
    ret

SECTION "Bank 10 ScriptCommand6D", ROMX

; Script command $6D (entry 108 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $6D): calls SceneLimboMonster in bank $85 and
; returns. SceneLimboMonster runs stage wScriptStep of its 15 stages
; (SceneLimboMonster_ShowWarubouWaheyIHave first, SceneWatchOut_Resume last). Scripts start it with
; SCRIPT_SCENE_LIMBO_MONSTER: Script_SceneLimboMonster. (C1, E-0376)
; runs one frame of script command type 6D (entry 108 of ScriptCommandHandlers) (E-0038)
ScriptCommand6D::
    farcall SceneLimboMonster
    ret

SECTION "Bank 10 ScriptCommand6E", ROMX

; Script command $6E (entry 109 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $6E): calls SceneLimboMonster2 in bank $85 and
; returns. SceneLimboMonster2 runs stage wScriptStep of its 16 stages
; (SceneLimboMonster2_ShowWarubouWaheyIWas first, SceneLimboMonster2_WalkOffAndCreate last). Scripts
; start it with SCRIPT_SCENE_LIMBO_MONSTER_2: Script_SceneLimboMonster2. (C1, E-0376)
; runs one frame of script command type 6E (entry 109 of ScriptCommandHandlers) (E-0038)
ScriptCommand6E::
    farcall SceneLimboMonster2
    ret

SECTION "Bank 10 ScriptCommand6F", ROMX

; Script command $6F (entry 110 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $6F): calls DeskKey in bank $85 and returns.
; DeskKey: at stage 0 it moves object 1 down on a 16-frame hop, then sets wSpriteSlotCount = 1 and
; moves on; a later call sets wScriptStartRequest = $80. Scripts start it with SCRIPT_DESK_KEY:
; Script_HeroCheckedTheDesk, Script_HeroCheckedTheDesk_2, Script_HeroCheckedTheDesk_3 and
; Script_HeroCheckedTheDesk_4 (between '0 checked the desk.' and '0 obtained the Brawn Key.'). (C2,
; E-0376)
; runs one frame of script command type 6F (entry 110 of ScriptCommandHandlers) (E-0038)
ScriptCommand6F::
    farcall DeskKey
    ret

SECTION "Bank 10 ScriptCommand70", ROMX

; Script command $70 (entry 111 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $70): calls SceneTerry in bank $85 and returns.
; SceneTerry: at stage 0 it sets a warp to screen (0, 0), Y $80, transition kind 3: map $0F at X $20
; when hPlayerX is $20; otherwise X $70 and map $0F with EVENT_THANKS_FOR_COMING_BY_025 set, else
; map $10. It starts it (ScriptStartFadeAndAdvanceStep) with palette fade 4; a later call sets
; wScriptStartRequest = $80. Scripts start it with SCRIPT_SCENE_TERRY: Script_SceneTerry. (C1,
; E-0376)
; runs one frame of script command type 70 (entry 111 of ScriptCommandHandlers) (E-0038)
ScriptCommand70::
    farcall SceneTerry
    ret

SECTION "Bank 10 ScriptCommand71", ROMX

; Script command $71 (entry 112 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $71): calls SceneKamehaKeyBattle in bank $85 and
; returns. SceneKamehaKeyBattle runs stage wScriptStep of its 5 stages
; (SceneKamehaKeyBattle_StartBattle first, SceneWatchOut_Resume last). Scripts start it with
; SCRIPT_SCENE_KAMEHA_KEY_BATTLE: Script_KamehaSoYou. (C1, E-0376)
; runs one frame of script command type 71 (entry 112 of ScriptCommandHandlers) (E-0038)
ScriptCommand71::
    farcall SceneKamehaKeyBattle
    ret

SECTION "Bank 10 ScriptCommand72", ROMX

; Script command $72 (entry 113 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $72): calls SceneKamehaKeyBattle2 in bank $85 and
; returns. SceneKamehaKeyBattle2 runs stage wScriptStep of its 5 stages
; (SceneKamehaKeyBattle2_StartBattle first, SceneWatchOut_Resume last). Scripts start it with
; SCRIPT_SCENE_KAMEHA_KEY_BATTLE_2: Script_KamehaSoYou_2. (C1, E-0376)
; runs one frame of script command type 72 (entry 113 of ScriptCommandHandlers) (E-0038)
ScriptCommand72::
    farcall SceneKamehaKeyBattle2
    ret

SECTION "Bank 10 ScriptCommand73", ROMX

; Script command $73 (entry 114 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $73): calls FollowerFacePlayer in bank $85 and
; returns. FollowerFacePlayer copies hPlayerFacing to the first byte of wFollowerRecords and sets
; wScriptStartRequest = $80. Scripts start it with SCRIPT_FOLLOWER_FACE_PLAYER: Script_I_5 (after
; 'Monster masters are those people...'). (C2, E-0376)
; runs one frame of script command type 73 (entry 114 of ScriptCommandHandlers) (E-0038)
ScriptCommand73::
    farcall FollowerFacePlayer
    ret

SECTION "Bank 10 ScriptCommand74", ROMX

; Script command $74 (entry 115 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $74): calls SetFlagRedraw in bank $85 and returns.
; SetFlagRedraw looks up the X of the tile in front of the player (hPlayerX, + $10 when facing 1, -
; $10 when facing 3) in SetFlagRedraw_Data ($20, $40, $50, $80; no end check) and sets story flag
; $1CF + its index; then ApplyMapScreenFlagEvents, a redraw (DrawFullScreenBufferAtScroll) and
; wScriptStartRequest = $80. Scripts start it with SCRIPT_SET_FLAG_REDRAW:
; Script_HeroCheckedTheTreasure_3 (after '0 checked the treasure chest. The...'). (C1, E-0376)
; runs one frame of script command type 74 (entry 115 of ScriptCommandHandlers) (E-0038)
ScriptCommand74::
    farcall SetFlagRedraw
    ret

SECTION "Bank 10 ScriptCommand75", ROMX

; Script command $75 (entry 116 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $75): calls SceneAtSea in bank $0F and returns.
; SceneAtSea runs stage wScriptStep of its 4 stages (SceneAtSea_Warp first, SceneAtSea_MoveObject3
; last). Scripts start it with SCRIPT_SCENE_AT_SEA: Script_InTheMiddleOf and Script_InTheMiddleOf_2
; (between 'In the middle of the sea...' and 'Tara: There you are, big brother!'). (C1, E-0376)
; runs one frame of script command type 75 (entry 116 of ScriptCommandHandlers) (E-0038)
ScriptCommand75::
    farcall SceneAtSea
    ret

SECTION "Bank 10 ScriptCommand76", ROMX

; Script command $76 (entry 117 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $76): calls SceneIslandSinking in bank $0F and
; returns. SceneIslandSinking runs stage wScriptStep of its 4 stages
; (SceneIslandSinking_ShowTheIslandIsSinking twice, SceneHomecoming_WaitMessage,
; ScriptCommand76_Run_PlaceFollower). No script_command in src names type $76. (C1, E-0376)
; runs one frame of script command type 76 (entry 117 of ScriptCommandHandlers) (E-0038)
ScriptCommand76::
    farcall SceneIslandSinking
    ret

SECTION "Bank 10 ScriptCommand77", ROMX

; Script command $77 (entry 118 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $77): calls SceneLandHo in bank $0F and returns.
; SceneLandHo runs stage wScriptStep of its 15 stages (SceneLandHo_Warp first, SceneLandHo_StartTalk
; last). Scripts start it with SCRIPT_SCENE_LAND_HO: Script_TaraBigBrotherGreatLog and
; Script_CobiHeroTheySaid. (C1, E-0376)
; runs one frame of script command type 77 (entry 118 of ScriptCommandHandlers) (E-0038)
ScriptCommand77::
    farcall SceneLandHo
    ret

SECTION "Bank 10 ScriptCommand78", ROMX

; Script command $78 (entry 119 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $78): calls SaveScreen in bank $85 and returns.
; SaveScreen runs stage wScriptStep of its 2 stages (SaveScreen_OpenGiftMenu first,
; SaveScreen_SetScriptStartRequestTo80 last). Scripts start it with SCRIPT_SAVE_SCREEN:
; Script_WhatWillYouGive and Script_YHasBeenGiven (after 'What will you give to the...'). (C1,
; E-0376)
; runs one frame of script command type 78 (entry 119 of ScriptCommandHandlers) (E-0038)
ScriptCommand78::
    farcall SaveScreen
    ret

SECTION "Bank 10 ScriptCommand79", ROMX

; Script command $79 (entry 120 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $79): calls ScenePoorChurch in bank $85 and
; returns. ScenePoorChurch runs stage wScriptStep of its 4 stages (ScenePoorChurch_WalkUp first,
; ScenePoorChurch_TurnRandomly last). Scripts start it with SCRIPT_SCENE_POOR_CHURCH:
; Script_ScenePoorChurch. (C1, E-0376)
; runs one frame of script command type 79 (entry 120 of ScriptCommandHandlers) (E-0038)
ScriptCommand79::
    farcall ScenePoorChurch
    ret

SECTION "Bank 10 ScriptCommand7A", ROMX

; Script command $7A (entry 121 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $7A): calls SceneKamehaMissing in bank $85 and
; returns. SceneKamehaMissing: at stage 0 it runs field command 5 (RunFieldCommandTemp0), puts
; wObject5 at ($50, $10) and moves on; then after 40 frames it hides wObject5 and sets
; wScriptStartRequest = $80. Scripts start it with SCRIPT_SCENE_KAMEHA_MISSING:
; Script_PrinceKamehaHasBeen_2 (before 'Prince Kameha has been missing...'). (C1, E-0376)
; runs one frame of script command type 7A (entry 121 of ScriptCommandHandlers) (E-0038)
ScriptCommand7A::
    farcall SceneKamehaMissing
    ret

SECTION "Bank 10 ScriptCommand7B", ROMX

; Script command $7B (entry 122 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $7B): calls SceneArenaChallenge in bank $85 and
; returns. SceneArenaChallenge runs stage wScriptStep of its 3 stages
; (SceneArenaChallenge_StartBattle first, SceneWatchOut_Resume last). Scripts start it with
; SCRIPT_SCENE_ARENA_CHALLENGE: Script_ReallyLet. (C1, E-0376)
; runs one frame of script command type 7B (entry 122 of ScriptCommandHandlers) (E-0038)
ScriptCommand7B::
    farcall SceneArenaChallenge
    ret

SECTION "Bank 10 ScriptCommand7C", ROMX

; Script command $7C (entry 123 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $7C): calls SceneTerryBattle in bank $85 and
; returns. SceneTerryBattle runs stage wScriptStep of its 3 stages (SceneTerryBattle_Start first,
; SceneWatchOut_Resume last). Scripts start it with SCRIPT_SCENE_TERRY_BATTLE:
; Script_TerryHumphConfidentHuh. (C1, E-0376)
; runs one frame of script command type 7C (entry 123 of ScriptCommandHandlers) (E-0038)
ScriptCommand7C::
    farcall SceneTerryBattle
    ret

SECTION "Bank 10 ScriptCommand7D", ROMX

; Script command $7D (entry 124 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $7D): calls SceneThisWay in bank $85 and returns.
; SceneThisWay sets wScriptStartRequest = $80 at once; unless hMapScreenY is 2, it copies the
; $FF-ended list at SceneThisWay_Data1 (screen row 0) or SceneThisWay_Data2 (other rows) + 4 *
; hMapScreenX into byte 7 of objects 0, 1, ... (wSpriteSlots + 7, every 16 bytes). Scripts start it
; with SCRIPT_SCENE_THIS_WAY: Script_ThisWayHereHere. (C2, E-0376)
; runs one frame of script command type 7D (entry 124 of ScriptCommandHandlers) (E-0038)
ScriptCommand7D::
    farcall SceneThisWay
    ret

SECTION "Bank 10 ScriptCommand7E", ROMX

; Script command $7E (entry 125 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $7E): calls SceneGotTo in bank $85 and returns.
; SceneGotTo blinks wObject5 (byte 0 = $80 shown, 0 hidden) for 120 frames, counting in
; wScriptParam0, then hides it and sets wScriptStartRequest = $80. Scripts start it with
; SCRIPT_SCENE_GOT_TO: Script_WhatWhatWasThat and Script_WhatWhatWasThat_2. (C2, E-0376)
; runs one frame of script command type 7E (entry 125 of ScriptCommandHandlers) (E-0038)
ScriptCommand7E::
    farcall SceneGotTo
    ret

SECTION "Bank 10 ScriptCommand7F", ROMX

; Script command $7F (entry 126 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $7F): calls SceneChestServant in bank $85 and
; returns. SceneChestServant runs stage wScriptStep of its 6 stages (SceneChestServant_HidePlayer
; first, SceneChestServant_SetScriptStartRequestTo80 last). Scripts start it with
; SCRIPT_SCENE_CHEST_SERVANT: Script_SceneChestServant. (C1, E-0376)
; runs one frame of script command type 7F (entry 126 of ScriptCommandHandlers) (E-0038)
ScriptCommand7F::
    farcall SceneChestServant
    ret

SECTION "Bank 10 ScriptCommandC0", ROMX

; Script command $C0 (entry 191 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $C0): calls SceneRoltElder in bank $73 and
; returns. SceneRoltElder runs stage wScriptStep of its 4 stages: stage 0 walks objects 1 and 2 up
; until object 1 reaches Y $60, then sets its state (byte 7) to 1; the last,
; SceneRoltElder_WalkUpTogether, walks both up until object 1 reaches Y $50, clears bit 2 of their
; flags and sets wScriptStartRequest = $80. Scripts start it with SCRIPT_SCENE_ROLT_ELDER:
; Script_WellWellAHuman and Script_I_18 (between 'Well, well, a human here...' and 'Rolt: That was
; fast, 0. I...'). (C2, E-0376)
; runs one frame of script command type C0 (entry 191 of ScriptCommandHandlers) (E-0038)
ScriptCommandC0::
    farcall SceneRoltElder
    ret

SECTION "Bank 10 ScriptCommandC1", ROMX

; Script command $C1 (entry 192 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $C1): calls SceneTooStrong in bank $73 and
; returns. SceneTooStrong runs stage wScriptStep of its 4 stages (SceneTooStrong_BlinkOut first,
; SceneTooStrong_JumpOff last). Scripts start it with SCRIPT_SCENE_TOO_STRONG: Script_That_3 and
; Script_You_11. (C1, E-0376)
; runs one frame of script command type C1 (entry 192 of ScriptCommandHandlers) (E-0038)
ScriptCommandC1::
    farcall SceneTooStrong
    ret

SECTION "Bank 10 ScriptCommandC2", ROMX

; Script command $C2 (entry 193 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $C2): calls SceneGiveBackCyal in bank $85 and
; returns. SceneGiveBackCyal runs stage wScriptStep of its 11 stages (SceneGiveBackCyal_DropObject
; first, SceneGiveBackCyal_SetScriptStartRequestTo80 last). Scripts start it with
; SCRIPT_SCENE_GIVE_BACK_CYAL: Script_RoltI (after 'Rolt: Shut up! Give back Cyal!'). (C1, E-0376)
; runs one frame of script command type C2 (entry 193 of ScriptCommandHandlers) (E-0038)
ScriptCommandC2::
    farcall SceneGiveBackCyal
    ret

SECTION "Bank 10 ScriptCommandC3", ROMX

; Script command $C3 (entry 194 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $C3): calls KeyBossBeaten in bank $73 and returns.
; KeyBossBeaten: it blinks object 0 at Y $30 for 120 frames (ScriptStepBlinkObjectTemp0: hidden at Y
; $E0 in the off phases), then marks key entry kind 7 (MarkKeyEntryKindTemp0Bit6) and sets
; wScriptStartRequest = $80. Scripts start it with SCRIPT_KEY_BOSS_BEATEN: Script_TheHumanInThe and
; Script_WhatYouAgainRude. (C2, E-0376)
; runs one frame of script command type C3 (entry 194 of ScriptCommandHandlers) (E-0038)
ScriptCommandC3::
    farcall KeyBossBeaten
    ret

SECTION "Bank 10 ScriptCommandC6", ROMX

; Script command $C6 (entry 197 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $C6): calls SceneCyalRolt in bank $73 and returns.
; SceneCyalRolt: at stage 0 it sets a warp to map $A9, screen (1, 0), position ($60, $10),
; transition kind 2 and starts it (ScriptStartFadeAndAdvanceStep); a later call sets
; wScriptStartRequest = $80. Scripts start it with SCRIPT_SCENE_CYAL_ROLT: Script_TheHumanInThe and
; Script_WhatYouAgainRude. (C1, E-0376)
; runs one frame of script command type C6 (entry 197 of ScriptCommandHandlers) (E-0038)
ScriptCommandC6::
    farcall SceneCyalRolt
    ret

SECTION "Bank 10 ScriptCommandC4", ROMX

; Script command $C4 (entry 195 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $C4): calls SceneBarrel in bank $85 and returns.
; SceneBarrel runs stage wScriptStep of its 10 stages (SceneBarrel_CountBarrel first,
; SceneWatchOut_Resume last). Scripts start it with SCRIPT_SCENE_BARREL: Script_HeroPeeredIntoThe_4
; (after '0 peered into the barrel. There...'). (C1, E-0376)
; runs one frame of script command type C4 (entry 195 of ScriptCommandHandlers) (E-0038)
ScriptCommandC4::
    farcall SceneBarrel
    ret

SECTION "Bank 10 ScriptCommandC5", ROMX

; Script command $C5 (entry 196 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $C5): calls SceneWizstone in bank $73 and returns.
; SceneWizstone runs stage wScriptStep of its 10 stages (SceneWizstone_Start first,
; SceneWizstone_WaitMessage last). Scripts start it with SCRIPT_SCENE_WIZSTONE: Script_KiralAhBackIs
; (after 'Kiral: This stone, the WizStone, it...'). (C1, E-0376)
; runs one frame of script command type C5 (entry 196 of ScriptCommandHandlers) (E-0038)
ScriptCommandC5::
    farcall SceneWizstone
    ret

SECTION "Bank 10 ScriptCommandC7", ROMX

; Script command $C7 (entry 198 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $C7): calls ScenePendantSeller in bank $0F and
; returns. ScenePendantSeller runs stage wScriptStep of its 4 stages; stage 0
; (ScenePendantSeller_RaiseObject) raises object 1 one pixel every other frame to Y $30, then sets
; bit 2 of its flags and moves on. Scripts start it with SCRIPT_SCENE_PENDANT_SELLER:
; Script_ThisPendantIsYours and Script_WhatWhereIGet (after 'This pendant is yours for...'). (C2,
; E-0376)
; runs one frame of script command type C7 (entry 198 of ScriptCommandHandlers) (E-0038)
ScriptCommandC7::
    farcall ScenePendantSeller
    ret

SECTION "Bank 10 ScriptCommandC8", ROMX

; Script command $C8 (entry 199 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $C8): calls SceneMercy in bank $73 and returns.
; SceneMercy puts object 2 at Y $10, clears byte 7 of objects 0 and 1, sets bit 2 of their flags and
; moves object 0 down two pixels a frame with object 1 at the same Y; at Y $B0 it sets
; wScriptStartRequest = $80. Scripts start it with SCRIPT_SCENE_MERCY: Script_You_12 and Script_We
; (after 'Please! Mercy! Spare us! Take...'). (C2, E-0376)
; runs one frame of script command type C8 (entry 199 of ScriptCommandHandlers) (E-0038)
ScriptCommandC8::
    farcall SceneMercy
    ret

SECTION "Bank 10 ScriptCommandC9", ROMX

; Script command $C9 (entry 200 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $C9): calls SceneMilayouForest in bank $73 and
; returns. SceneMilayouForest has 2 stages: SceneChestBattle_StartSprite, then
; SceneMilayouForest_MoveSprite, which adds wScriptParam1 to the X of object 0 for 16 frames, then
; clears its byte 7 and flag bit 2 and sets wScriptStartRequest = $80. Scripts start it with
; SCRIPT_SCENE_MILAYOU_FOREST: Script_MilayouIThoughtThis (after 'Milayou: I thought this forest
; looked...'). (C2, E-0376)
; runs one frame of script command type C9 (entry 200 of ScriptCommandHandlers) (E-0038)
ScriptCommandC9::
    farcall SceneMilayouForest
    ret

SECTION "Bank 10 ScriptCommandCA", ROMX

; Script command $CA (entry 201 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $CA): calls KeyBossBeaten2 in bank $73 and
; returns. KeyBossBeaten2: it blinks object 0 at Y $20 for 120 frames (ScriptStepBlinkObjectTemp0:
; hidden at Y $E0 in the off phases), then marks key entry kind 9 (MarkKeyEntryKindTemp0Bit6), sets
; wStoryFlags + $68 bit 1, puts object 1 at ($50, $70) and sets wScriptStartRequest = $80. Scripts
; start it with SCRIPT_KEY_BOSS_BEATEN_2: Script_WhatIsItYou and Script_WhatIsItYou_2 (before
; 'Milayou: You are really special. I...'). (C2, E-0376)
; runs one frame of script command type CA (entry 201 of ScriptCommandHandlers) (E-0038)
ScriptCommandCA::
    farcall KeyBossBeaten2
    ret

SECTION "Bank 10 ScriptCommandCB", ROMX

; Script command $CB (entry 202 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $CB): calls SceneChestBattle in bank $73 and
; returns. SceneChestBattle runs stage wScriptStep of its 11 stages
; (SceneChestBattle_ShowPreBattleMessage first, SceneChestBattle_SetChestFlag last). Scripts start
; it with SCRIPT_SCENE_CHEST_BATTLE: Script_SceneChestBattle. (C1, E-0376)
; runs one frame of script command type CB (entry 202 of ScriptCommandHandlers) (E-0038)
ScriptCommandCB::
    farcall SceneChestBattle
    ret

SECTION "Bank 10 ScriptCommandCC", ROMX

; Script command $CC (entry 203 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $CC): calls SceneCyalShine in bank $73 and
; returns. SceneCyalShine runs stage wScriptStep of its 2 stages (SceneCyalShine_LoadObject5 first,
; SceneCyalShine_Wait last). Scripts start it with SCRIPT_SCENE_CYAL_SHINE: Script_SceneCyalShine.
; (C1, E-0376)
; runs one frame of script command type CC (entry 203 of ScriptCommandHandlers) (E-0038)
ScriptCommandCC::
    farcall SceneCyalShine
    ret

SECTION "Bank 10 ScriptCommandCD", ROMX

; Script command $CD (entry 204 of ScriptCommandHandlers, run once per script frame by
; ExecuteScriptCommand while wScriptCommandType = $CD): calls SceneYouDidIt in bank $85 and returns.
; SceneYouDidIt runs stage wScriptStep of its 2 stages (SceneYouDidIt_ShowMessage first,
; SceneWatchOut_Resume last). Scripts start it with SCRIPT_SCENE_YOU_DID_IT:
; Script_HeroCheckedTheTreasure_4 (after '0 checked the treasure chest. It...'). (C1, E-0376)
; runs one frame of script command type CD (entry 204 of ScriptCommandHandlers) (E-0038)
ScriptCommandCD::
    farcall SceneYouDidIt
    ret

SECTION "Bank 10 ScriptCommandCE", ROMX

; Script command type CE (SCRIPT_HIDE_SPRITES), entry 205 of ScriptCommandHandlers, which
; ExecuteScriptCommand jumps through with wScriptCommandType - 1: far-calls HideSprites in bank $85,
; which sets wSpriteSlotCount = 0 and wScriptStartRequest = $80 so the next script command is
; fetched. (C2, E-0376)
; runs one frame of script command type CE (entry 205 of ScriptCommandHandlers) (E-0038)
ScriptCommandCE::
    farcall HideSprites
    ret

SECTION "Bank 10 ScriptCommandCF", ROMX

; Script command type CF (SCRIPT_SCENE_KEY_SHOP), entry 206 of ScriptCommandHandlers: far-calls
; SceneKeyShop in bank $85 once per frame. That scene steps by wScriptStep: step 0 advances to step
; 1 and, unless object 0 (wSpriteSlots + $B) is at X $50, requests the next script command at once
; (wScriptStartRequest = $80); step 1 walks object 0 to X $60 (StepObjectTowardCoord), then clears
; wSpriteSlots + $7 and requests the next command. (C2, E-0376)
; runs one frame of script command type CF (entry 206 of ScriptCommandHandlers) (E-0038)
ScriptCommandCF::
    farcall SceneKeyShop
    ret

SECTION "Bank 10 Script_HehSoTheseAre", ROMX

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_HehSoTheseAre::
    script_sound $28
    script_message $0030 ; '*: Heh, so these are the'
    script_face $81, 1
    script_message $0031 ; '*: C'mon, Warubou!'
    script_command SCRIPT_SCENE_WARUBOU_LEAVES
    script_sound $ff
    script_set_flag EVENT_SCENE_WARUBOU_LEAVES
    script_end
Script_HaveYouHeardAbout::
    script_message $404c ; '*: Have you heard about Magic'
    script_skip_if_no Script_WowYouKidsSure
    script_message $804e ; '*: You need Magic Keys to'
    script_end
Script_WowYouKidsSure::
    script_message $804d ; '*: Wow, you kids sure learn'
    script_end
Script_OhIt::
    script_sound $28
    script_command SCRIPT_SCENE_LEARN_QUICK
    script_message $0033 ; '*: Oh… It's… all spinning around…'
    script_sound $ff
    script_end
Script_SceneSpinning::
    script_sound $28
    script_wait 100
    script_command SCRIPT_SCENE_SPINNING
    script_wait 30
    script_sound $ff
    script_end
Script_YouMustBeThe::
    script_message $0045 ; '*: You must be the farm'
    script_command SCRIPT_SCENE_FARM_KIDS
    script_end
Script_WarubouWhaISmell::
    script_slide_y $82
    script_message $0050 ; 'Warubou: Wha…? I smell something! I'
    script_command SCRIPT_SCENE_WARUBOU_SMELLS
    script_message $0051 ; 'Warubou: What is this? Food? Perfect!'
    script_set_flag EVENT_SCENE_WARUBOU_SMELLS
    script_command SCRIPT_SCENE_WARUBOU_FOOD
    script_sound $ff
    script_end
Script_WarubouCalmDownAnd::
    script_sound $28
    script_command SCRIPT_SCENE_WARUBOU_FOOD_2
    script_message $005d ; 'Warubou: Calm down and listen! What'
    script_end
Script_You_3::
    script_message $001e ; '*: You've come at the right'
    script_command SCRIPT_SCENE_VAULT_SETTLED
    script_message $0020 ; '*: Good, that's settled then. The'
    script_set_flag EVENT_SCENE_VAULT_SETTLED
    script_end
Script_DidYouGetThe::
    script_message $006a ; '*: Did you get the package'
    script_command SCRIPT_SCENE_PACKAGE
    script_message $006b ; '*: Oh goodness, you're filthy! What'
    script_end
Script_I_5::
    script_message $4028 ; '*: I've heard that there are'
    script_skip_if_no Script_OhWellThat
    script_message $802a ; '*: Monster masters are those people'
    script_command SCRIPT_FOLLOWER_FACE_PLAYER
    script_slide_y $01
    script_message $002d ; 'Tara: Big brother can't do it'
    script_message $002c ; '*: I aspired to be one'
    script_set_flag EVENT_FOLLOWER_FACE_PLAYER
    script_end
Script_OhWellThat::
    script_message $8029 ; '*: Oh? Well, that's fine then.'
    script_end
Script_I_6::
    script_message $4028 ; '*: I've heard that there are'
    script_skip_if_no Script_OhWellThat_2
    script_message $802a ; '*: Monster masters are those people'
    script_slide_y $01
    script_message $002b ; 'Cobi: Hahah! 0 won't last a'
    script_message $002c ; '*: I aspired to be one'
    script_set_flag EVENT_FOLLOWER_FACE_PLAYER
    script_end
Script_OhWellThat_2::
    script_message $8029 ; '*: Oh? Well, that's fine then.'
    script_end
Script_HahTheIsland::
    script_message $0060 ; '*: Hah? The island's going to'
    script_slide_y $01
    script_message $0063 ; 'Tara: Why aren't you listening? Papa,'
    script_message $0062 ; '*: Look, an island just doesn't'
    script_set_flag EVENT_LOOK_AN_ISLAND_JUST_DOESN
    script_end
Script_HahTheIsland_2::
    script_message $0060 ; '*: Hah? The island's going to'
    script_slide_y $01
    script_message $0061 ; 'Cobi: Why won't you believe us?'
    script_message $0062 ; '*: Look, an island just doesn't'
    script_set_flag EVENT_LOOK_AN_ISLAND_JUST_DOESN
    script_end
Script_WarubouWaHeyGood::
    script_message $007a ; 'Warubou: Wa-hey! Good, you're back. You'
    script_slide_y $01
    script_message $407b ; 'Warubou: No time to waste, warooh!'
    script_skip_if_no Script_WarubouWaHeyGood_2
    script_message $807c ; 'Warubou: No? Then find someone!'
    script_set_flag EVENT_WARUBOU_NO_THEN_FIND_SOMEONE
    script_end
Script_WarubouWaHeyGood_2::
    script_message $807f ; 'Warubou: Wa-hey! Good, good, good! In'
    script_command SCRIPT_SCENE_WARUBOU_MAGIC_KEY
    script_message $0080 ; 'Warubou: This here is a Magic'
    script_command SCRIPT_SCENE_OASIS_KEY
    script_message $0081 ; '0 received the Oasis Key.'
    script_message $0082 ; 'Warubou: Wa-hey! I trust you! Go!'
    script_set_flag EVENT_SCENE_OASIS_KEY
    script_end
Script_WarubouWaHeyNo::
    script_message $407d ; 'Warubou: Wa-hey? No one believed! You'
    script_skip_if_no Script_ToWarubouWaHeyGood_2
Script_WarubouWaHeyNo_2::
    script_message $c07e ; 'Warubou: Wa-hey! No more dawdling! GreatLog'
    script_skip_if_no Script_ToWarubouWaHeyGood_2
    script_jump Script_WarubouWaHeyNo_2
Script_ToWarubouWaHeyGood_2::
    script_jump Script_WarubouWaHeyGood_2
Script_HeroReceivedTheGreatLog::
    script_set_flag EVENT_HERO_RECEIVED_THE_GREAT_LOG
    script_set_flag EVENT_HERO_RECEIVED_THE_GREAT_LOG_017
    script_command SCRIPT_SCENE_GREATLOG_KEY
    script_message $0085 ; '0 received the GreatLog Key.'
    script_message $0086 ; 'Warubou: Dangerous are other worlds! So'
    script_command SCRIPT_SCENE_WARUBOU_WARNING
    script_walk 0, 2, 3
    script_walk 0, 1, 2
    script_face $80, 2
    script_face $00, 0
    script_face $01, 0
    script_message $008c ; 'Slash: Hey, why the long faces?'
    script_face $00, 1
    script_face $01, 3
    script_command SCRIPT_SCENE_LONG_FACES
    script_end
Script_InTheMiddleOf::
    script_wait 30
    script_message $0000 ; 'In the middle of the sea'
    script_command SCRIPT_SCENE_AT_SEA
    script_wait 60
    script_walk 3, 0, 1
    script_face $81, 2
    script_wait 90
    script_face $81, 0
    script_walk 3, 3, 3
    script_wait 60
    script_walk 2, 1, 6
    script_walk 2, 2, 1
    script_face $82, 1
    script_face $00, 3
    script_slide_y $82
    script_message $0002 ; 'Tara: There you are, big brother!'
    script_walk 2, 3, 1
    script_face $82, 1
    script_set_flag EVENT_SCENE_AT_SEA
    script_end
Script_InTheMiddleOf_2::
    script_wait 30
    script_message $0000 ; 'In the middle of the sea'
    script_command SCRIPT_SCENE_AT_SEA
    script_wait 60
    script_walk 3, 0, 1
    script_face $81, 2
    script_wait 90
    script_face $81, 0
    script_walk 3, 3, 3
    script_wait 60
    script_walk 2, 1, 6
    script_walk 2, 2, 1
    script_face $82, 1
    script_face $00, 3
    script_slide_y $82
    script_message $0001 ; 'Cobi: 0! Papa's calling. He's at'
    script_walk 2, 3, 1
    script_face $82, 1
    script_set_flag EVENT_SCENE_AT_SEA
    script_end
Script_TaraBigBrotherGreatLog::
    script_message $0013 ; 'Tara: Big brother! GreatLog will be'
    script_face $80, 1
    script_slide_y $80
    script_message $0012 ; '*: Land ho! There's GreatLog!'
    script_face $81, 1
    script_face $82, 1
    script_face $00, 1
    script_slide_y $82
    script_wait 120
    script_command SCRIPT_SCENE_LAND_HO
    script_end
Script_CobiHeroTheySaid::
    script_message $0011 ; 'Cobi: 0! They said GreatLog will'
    script_face $80, 1
    script_slide_y $80
    script_message $0012 ; '*: Land ho! There's GreatLog!'
    script_face $81, 1
    script_face $82, 1
    script_face $00, 1
    script_slide_y $82
    script_wait 120
    script_command SCRIPT_SCENE_LAND_HO
    script_end
Script_ListenYouTwoQuit::
    script_command SCRIPT_SCENE_HORSING_AROUND
    script_message $0015 ; '*: Listen you two! Quit your'
    script_walk 0, 2, 5
    script_face $80, 1
    script_face $81, 3
    script_end
Script_SailingIsSureExhilarating::
    script_message $4007 ; '*: Sailing is sure exhilarating. Right?'
    script_skip_if_no Script_GoodThat
    script_message $8009 ; '*: Is that so? Too bad!'
    script_end
Script_GoodThat::
    script_message $8008 ; '*: Good. That's good to hear!'
    script_end
Script_TravelerEvent::
    script_command SCRIPT_TRAVELER_EVENT
    script_end
Script_FieldScene01::
    script_command SCRIPT_FIELD_SCENE_01
    script_end
Script_RandomGoldOrItem::
    script_command SCRIPT_RANDOM_GOLD_OR_ITEM
    script_end
Script_KeyWorldBossBattle::
    script_command SCRIPT_KEY_WORLD_BOSS_BATTLE
    script_end
Script_KeyWorldFloorBattle::
    script_command SCRIPT_KEY_WORLD_FLOOR_BATTLE
    script_end
Script_PartyDefeatedReturn::
    script_command SCRIPT_PARTY_DEFEATED_RETURN
    script_end
Script_ReturnMessage::
    script_command SCRIPT_RETURN_MESSAGE
    script_end
Script_ReturnWarp::
    script_command SCRIPT_RETURN_WARP
    script_end
Script_MapExitWarp::
    script_command SCRIPT_MAP_EXIT_WARP
    script_end
Script_MapLinkWarp::
    script_command SCRIPT_MAP_LINK_WARP
    script_end
Script_PlayerSpriteFlash::
    script_command SCRIPT_PLAYER_SPRITE_FLASH
    script_end
Script_PlayerSpriteMessage::
    script_command SCRIPT_PLAYER_SPRITE_MESSAGE
    script_end
Script_KeyWorldDoorItem::
    script_command SCRIPT_KEY_WORLD_DOOR_ITEM
    script_end
Script_AreaItem::
    script_command SCRIPT_AREA_ITEM
    script_end
Script_StepTriggerReward::
    script_command SCRIPT_STEP_TRIGGER_REWARD
    script_end
Script_FollowersStep10::
    script_command SCRIPT_FOLLOWERS_STEP_10
    script_end
Script_FollowersStep11::
    script_command SCRIPT_FOLLOWERS_STEP_11
    script_end
Script_PlayerAndFollowersStep::
    script_command SCRIPT_PLAYER_AND_FOLLOWERS_STEP
    script_end
Script_WarpWithFollowers::
    script_command SCRIPT_WARP_WITH_FOLLOWERS
    script_end
Script_FollowersStep14::
    script_command SCRIPT_FOLLOWERS_STEP_14
    script_end
Script_BreedFade::
    script_command SCRIPT_BREED_FADE
    script_end
Script_BreedChildSprite::
    script_command SCRIPT_BREED_CHILD_SPRITE
    script_end
Script_BreedChildScene::
    script_command SCRIPT_BREED_CHILD_SCENE
    script_end
Script_NpcBreedWarp::
    script_command SCRIPT_NPC_BREED_WARP
    script_end
Script_LinkMessage::
    script_command SCRIPT_LINK_MESSAGE
    script_end
Script_ArenaGridBattle::
    script_hold_dpad $00, 5
    script_command SCRIPT_ARENA_GRID_BATTLE
    script_end
Script_ArenaRounds::
    script_hold_dpad $00, 5
    script_command SCRIPT_ARENA_ROUNDS
    script_end
Script_RandomBattle::
    script_command SCRIPT_RANDOM_BATTLE
    script_end
Script_HealParty::
    script_command SCRIPT_HEAL_PARTY
    script_end
Script_ObjectPath1b::
    script_command SCRIPT_OBJECT_PATH_1B
    script_end
Script_ObjectPath1c::
    script_command SCRIPT_OBJECT_PATH_1C
    script_end
Script_EncounterMessage::
    script_command SCRIPT_ENCOUNTER_MESSAGE
    script_end
Script_CountdownMessage::
    script_command SCRIPT_COUNTDOWN_MESSAGE
    script_end
Script_AreYouGoingOut::
    script_message $0100 ; '*: Are you going out to'
    script_message $0101 ; '0 received an Herb.'
    script_set_flag EVENT_HERO_RECEIVED_AN_HERB
    script_end
Script_You_4::
    script_message $0200 ; '*: You've been going out a'
    script_message $0201 ; 'Mom handed over 200G.'
    script_add_gold 200
    script_end
Script_OhYou::
    script_message $48a1 ; '*: Oh? You'll run another errand?'
    script_skip_if_no Script_MyWhatHasGotten
    script_message $88a4 ; '*: No miracles today! Oh, well.'
    script_end
Script_MyWhatHasGotten::
    script_message $88a2 ; '*: My, what has gotten into'
    script_message $08a3 ; 'Mama handed over 400G.'
    script_add_gold 400
    script_set_flag EVENT_MAMA_HANDED_OVER_400_G
    script_end
Script_OhYou_2::
    script_message $08a6 ; '*: Oh… You've found what I'
    script_message $08a7 ; '0 handed over the Potion.'
    script_set_flag EVENT_HERO_HANDED_OVER_THE_POTION
    script_end
Script_OhYou_3::
    script_message $48a1 ; '*: Oh? You'll run another errand?'
    script_skip_if_no Script_WellCouldYouGo
    script_message $88a4 ; '*: No miracles today! Oh, well.'
    script_end
Script_WellCouldYouGo::
    script_message $88a8 ; '*: Well, could you go buy'
    script_message $08a9 ; 'Mama handed over 600G.'
    script_add_gold 600
    script_set_flag EVENT_MAMA_HANDED_OVER_600_G
    script_end
Script_OhYou_4::
    script_message $08a6 ; '*: Oh… You've found what I'
    script_message $08ac ; '0 handed over the Rib.'
    script_set_flag EVENT_HERO_HANDED_OVER_THE_RIB
    script_end
    db $00, $01, $43, $06, $04, $00, $04, $83, $ff, $00, $02, $83, $00, $03, $03, $0e
    db $b0, $04, $0a, $87, $01, $ff, $00, $01, $43, $06, $04, $00, $04, $83, $ff, $00
    db $07, $83, $00, $08, $03, $0e, $b0, $04, $0a, $89, $01, $ff

Script_IWasGoingTo::
    script_message $4a25 ; '*: I was going to ask'
    script_skip_if_no Script_TheFarmThatYour
    script_message $8a26 ; '*: Oh… Then I'll ask Tara.'
    script_end
Script_TheFarmThatYour::
    script_message $8a22 ; '*: The farm that your father'
    script_message $0a23 ; '*: Mama handed over 1,200G.'
    script_add_gold 1200
    script_set_flag EVENT_MAMA_HANDED_OVER_1_200
    script_end
Script_IWasGoingTo_2::
    script_message $4a21 ; '*: I was going to ask'
    script_skip_if_no Script_TheFarmThatYour_2
    script_message $8a24 ; '*: Oh… Then I'll ask Cobi.'
    script_end
Script_TheFarmThatYour_2::
    script_message $8a22 ; '*: The farm that your father'
    script_message $0a23 ; '*: Mama handed over 1,200G.'
    script_add_gold 1200
    script_set_flag EVENT_MAMA_HANDED_OVER_1_200
    script_end
Script_TheyDidn::
    script_message $0a28 ; '*: They didn't have any around'
    script_message $0a29 ; '0 handed over the Sirloin.'
    script_set_flag EVENT_HERO_HANDED_OVER_THE_SIRLOIN
    script_end
Script_OhYouBoughtThe::
    script_message $0212 ; '*: Oh? You bought the LoveWater!'
    script_message $0213 ; '0 handed over the LoveWater.'
    script_walk 0, 3, 1
    script_walk 0, 2, 2
    script_face $80, 3
    script_wait 60
    script_face $81, 0
    script_slide_y $81
    script_slide_y $81
    script_wait 30
    script_walk_fast 1, 0, 2
    script_walk_fast 1, 1, 2
    script_walk_fast 1, 0, 6
    script_end
Script_CobiHiI::
    script_set_flag EVENT_COBI_HI_I
    script_message $410d ; 'Cobi: Hi, I'm helping Papa to'
    script_jump_data_bank Script_SwapMonsters
    db $ff

Script_CobiHiHeroWhat::
    script_message $410e ; 'Cobi: Hi, 0! What's up today?'
    script_jump_data_bank Script_SwapMonsters
    db $ff

Script_CobiHeroWhatWas::
    script_set_flag EVENT_COBI_HERO_WHAT_WAS
    script_message $4207 ; 'Cobi: 0, what was it like'
    script_jump_data_bank Script_SwapMonsters
    db $ff

Script_CobiHeroWhatWas_2::
    script_set_flag EVENT_COBI_HERO_WHAT_WAS_109
    script_message $48bc ; 'Cobi: 0, what was it like'
    script_jump_data_bank Script_SwapMonsters
    db $ff

Script_CobiHeroWhatWas_3::
    script_set_flag EVENT_COBI_HERO_WHAT_WAS_115
    script_message $4a30 ; 'Cobi: 0, what was it like'
    script_jump_data_bank Script_SwapMonsters
    db $ff

Script_CobiHeroTellMe::
    script_set_flag EVENT_COBI_HERO_TELL_ME
    script_message $4502 ; 'Cobi: 0, tell me about what'
    script_jump_data_bank Script_SwapMonsters
    db $ff

Script_CobiHeroIEnvied::
    script_set_flag EVENT_COBI_HERO_IENVIED
    script_message $4b02 ; 'Cobi: 0, I envied you for'
    script_jump_data_bank Script_SwapMonsters
    db $ff

Script_TaraI::
    script_set_flag EVENT_COBI_HI_I
    script_message $410f ; 'Tara: I'm helping Papa take care'
    script_jump_data_bank Script_SwapMonsters
    db $ff

Script_TaraHiHowAre::
    script_message $4110 ; 'Tara: Hi! How are you? Do'
    script_jump_data_bank Script_SwapMonsters
    db $ff

Script_TaraBigBrotherHave::
    script_set_flag EVENT_COBI_HERO_WHAT_WAS
    script_message $4208 ; 'Tara: Big brother, have you found'
    script_jump_data_bank Script_SwapMonsters
    db $ff

Script_TaraBigBrotherTell::
    script_set_flag EVENT_COBI_HERO_WHAT_WAS_109
    script_message $48bd ; 'Tara: Big brother, tell me about'
    script_jump_data_bank Script_SwapMonsters
    db $ff

Script_TaraBigBrotherTell_2::
    script_set_flag EVENT_COBI_HERO_WHAT_WAS_115
    script_message $4a31 ; 'Tara: Big brother, tell me about'
    script_jump_data_bank Script_SwapMonsters
    db $ff

Script_TaraBigBrotherTell_3::
    script_set_flag EVENT_COBI_HERO_TELL_ME
    script_message $4503 ; 'Tara: Big brother, tell me about'
    script_jump_data_bank Script_SwapMonsters
    db $ff

Script_TaraHeroIWas::
    script_set_flag EVENT_COBI_HERO_IENVIED
    script_message $4b03 ; 'Tara: 0, I was a little'
    script_jump_data_bank Script_SwapMonsters
    db $ff

Script_WhyDoYouHave::
    script_message $0105 ; '*: Why do you have a'
    script_message $0106 ; '0 received a PorkChop.'
    script_end
Script_BeavernHelpedPutUp::
    script_set_flag EVENT_BEAVERN_HELPED_PUT_UP
    script_message $48af ; '*: Beavern helped put up the'
    script_skip_if_no Script_ILikeToGet
    script_message $88b1 ; '*: If one joins you, could'
    script_end
Script_ILikeToGet::
    script_message $88b0 ; '*: I like to get help'
    script_end
Script_AMadGopherJoinedYou::
    script_message $48b3 ; '*: A MadGopher joined you? Could'
    script_skip_if_no Script_GreatHeroThanksA
    script_message $88b5 ; '*: 0, I need your help.'
    script_end
Script_GreatHeroThanksA::
    script_message $88b4 ; '*: Great, 0! Thanks a lot!'
    script_command SCRIPT_REWARD_ITEM_OR_KEY
    script_message $0d17 ; '*: Here, 0! You need this!'
    script_message $0d18 ; '0 received the Ice Key.'
    script_message $0d19 ; '*: Be careful when you're traveling'
    script_set_flag EVENT_REWARD_ITEM_OR_KEY
    script_end
Script_AMadGopherJoinedYou_2::
    script_message $48b3 ; '*: A MadGopher joined you? Could'
    script_skip_if_no Script_GreatHeroThanksA_2
    script_message $88b5 ; '*: 0, I need your help.'
    script_end
Script_GreatHeroThanksA_2::
    script_message $88b4 ; '*: Great, 0! Thanks a lot!'
    script_command SCRIPT_REWARD_ITEM_OR_KEY
    script_message $0d48 ; '*: Here, 0! You hold onto'
    script_set_flag EVENT_REWARD_ITEM_OR_KEY_1A3
    script_set_flag EVENT_REWARD_ITEM_OR_KEY
    script_end
Script_AMadGopherJoinedYou_3::
    script_message $48b3 ; '*: A MadGopher joined you? Could'
    script_skip_if_no Script_GreatHeroThanksA_3
    script_message $88b5 ; '*: 0, I need your help.'
    script_end
Script_GreatHeroThanksA_3::
    script_message $88b4 ; '*: Great, 0! Thanks a lot!'
    script_command SCRIPT_REWARD_ITEM_OR_KEY
    script_message $0d47 ; '*: Here, 0! You hold onto'
    script_message $0d41 ; '0 received a TinyMedal!'
    script_message $0d19 ; '*: Be careful when you're traveling'
    script_set_flag EVENT_REWARD_ITEM_OR_KEY
    script_end
Script_You_5::
    script_message $420d ; '*: You're too young to be'
    script_jump_data_bank Script_Shop
    db $ff

Script_WelcomeHowMayI::
    script_message $420e ; '*: Welcome! How may I serve'
    script_jump_data_bank Script_Shop
    db $ff

Script_WellWellIfIt::
    script_message $4d89 ; '*: Well, well! If it isn't'
    script_jump_data_bank Script_Shop
    db $ff

Script_OhHiGoodTo::
    script_set_flag EVENT_OH_HI_GOOD_TO
    script_message $411c ; '*: Oh, hi! Good to see'
    script_jump_data_bank Script_Vault
    db $ff

Script_HowMayTheVault::
    script_message $411d ; '*: How may the Vault serve'
    script_jump_data_bank Script_Vault
    db $ff

Script_HelloGreatLog::
    script_set_flag EVENT_HELLO_GREAT_LOG
    script_message $4b1c ; '*: Hello, GreatLog's hero! Do you'
    script_jump_data_bank Script_Vault
    db $ff

Script_WarubouWaHeyYou::
    script_message $411f ; 'Warubou: Wa-hey! You remember the promise'
    script_skip_if_no Script_WarubouQuitDawdlingWarooh
    script_message $8121 ; 'Warubou: Use a Magic Key and'
    script_end
Script_WarubouQuitDawdlingWarooh::
    script_message $8120 ; 'Warubou: Quit dawdling, warooh!'
    script_end
Script_WarubouWaHeyThis::
    script_message $429e ; 'Warubou: Wa-hey! This time, you'll have'
    script_skip_if_no Script_WarubouWaHeyHurry
    script_message $82a2 ; 'Warubou: Wa-hey. I need you to'
    script_end
Script_WarubouWaHeyHurry::
    script_message $829f ; 'Warubou: Wa-hey, hurry. You need to'
    script_end
    db $00, $9e, $42, $06, $04, $00, $a2, $82, $ff, $00, $a0, $82, $ff, $00, $a3, $02
    db $3b, $0a, $2f, $01, $ff, $00, $a3, $02, $3b, $0a, $35, $01, $ff, $00, $a3, $02
    db $3b, $0a, $39, $01, $ff

Script_WarubouWaHeyAre::
    script_message $452a ; 'Warubou: Wa-hey! Are you ready? Ready'
    script_skip_if_no Script_WarubouWaHeyTake
    script_message $8531 ; 'Warubou: Wa-hey, well, hurry it up!'
    script_end
Script_WarubouWaHeyTake::
    script_message $8530 ; 'Warubou: Wa-hey! Take the treasures that'
    script_end
Script_WarubouWaHeyAre_2::
    script_message $452a ; 'Warubou: Wa-hey! Are you ready? Ready'
    script_skip_if_no Script_WarubouWaHeyTake_2
    script_message $8531 ; 'Warubou: Wa-hey, well, hurry it up!'
    script_end
Script_WarubouWaHeyTake_2::
    script_message $852b ; 'Warubou: Wa-hey! Take the treasures that'
    script_command SCRIPT_SCENE_LIMBO
    script_message $052f ; 'Warubou: Limbo is the King's domain!'
    script_set_flag EVENT_SCENE_LIMBO
    script_end
Script_SceneLimboMonster::
    script_command SCRIPT_SCENE_LIMBO_MONSTER
    script_end
Script_SceneLimboMonster2::
    script_command SCRIPT_SCENE_LIMBO_MONSTER_2
    script_end
Script_PrinceKamehaHasBeen::
    script_message $4a36 ; '*: Prince Kameha has been missing'
    script_skip_if_no Script_What
    script_message $8a38 ; '*: You better be telling the'
    script_end
Script_What::
    script_message $8a37 ; '*: What's that? You saw Prince'
    script_set_flag EVENT_WHAT
    script_command SCRIPT_SCENE_SAW_KAMEHA
    script_message $0a3a ; '*: Sire, this child claims to'
    script_message $0a3b ; 'King: What's that? Is that so?'
    script_walk 0, 0, 1
    script_message $0d28 ; '0 obtained the Sky Key.'
    script_walk 0, 2, 1
    script_face $80, 0
    script_message $0d29 ; 'King: Kameha made off with the'
    script_end
Script_IfTheIslandSink::
    script_set_flag EVENT_WHAT
    script_message $4504 ; '*: If the island sink, is'
    script_skip_if_no Script_PeopleHaveBeenSaying
    script_message $8506 ; '*: Hey! You're the kid who'
    script_command SCRIPT_SCENE_KAMEHA_BACK
    script_message $0507 ; '*: Prince Kameha came back! What'
    script_set_flag EVENT_SCENE_KAMEHA_BACK
    script_end
Script_PeopleHaveBeenSaying::
    script_message $8505 ; '*: People have been saying that'
    script_command SCRIPT_SCENE_KAMEHA_BACK
    script_message $0507 ; '*: Prince Kameha came back! What'
    script_set_flag EVENT_SCENE_KAMEHA_BACK
    script_end
Script_TakeThisSlideAs::
    script_message $021d ; '*: Take this slide as a'
    script_sound $65
    script_walk 1, 0, 3
    script_end
Script_OhYou_5::
    script_message $4264 ; '*: Oh… You're so lucky to'
    script_skip_if_no Script_RReallyWowThank
    script_message $8266 ; '*: Oh… Sorry… It's your friend…'
    script_end
Script_RReallyWowThank::
    script_message $8265 ; '*: R… Really? Wow! Thank you!'
    script_command SCRIPT_SCENE_MASTER_THANKS
    script_set_flag EVENT_SCENE_MASTER_THANKS
    script_end
Script_IBecameAMaster::
    script_message $4b47 ; '*: I became a master because'
    script_skip_if_no Script_ReallyLet
    script_message $8d81 ; '*: Aww… How boring… Visit us'
    script_end
Script_ReallyLet::
    script_message $8d80 ; '*: Really? Let's go to the'
    script_command SCRIPT_SCENE_ARENA_CHALLENGE
    script_end
Script_HeroCheckedThePedestal::
    script_message $4227 ; '0 checked the pedestal. It's the'
    script_skip_if_no Script_YouMayCheckYour
    script_message $8229 ; '0 put back the Library Guide.'
    script_end
Script_YouMayCheckYour::
    script_message $8228 ; ''You may check your Catalog of'
    script_end
Script_WelcomeToTheLibrary::
    script_set_flag EVENT_WELCOME_TO_THE_LIBRARY
    script_message $422a ; '*: Welcome to the Library. You'
    script_jump_data_bank Script_Library
    db $ff

Script_WelcomeToTheLibrary_2::
    script_message $422b ; '*: Welcome to the Library. Which'
    script_jump_data_bank Script_Library
    db $ff

Script_HelloOurYoungSavior::
    script_set_flag EVENT_HELLO_OUR_YOUNG_SAVIOR
    script_message $4b49 ; '*: Hello, our young savior! Have'
    script_jump_data_bank Script_Library
    db $ff

Script_WelcomeToTheLibrary_3::
    script_set_flag EVENT_WELCOME_TO_THE_LIBRARY_19E
    script_message $4df0 ; '*: Welcome to the Library! Your'
    script_message $cdf1 ; '*: We need fanfare right about'
    script_jump_data_bank Script_Library
    db $ff

Script_DoYouHaveAny::
    script_message $4230 ; '*: Do you have any idea'
    script_skip_if_no Script_OhYou_6
    script_message $8232 ; '*: Monsters can be categorized in'
    script_end
Script_OhYou_6::
    script_message $8231 ; '*: Oh… You've read this book'
    script_end
Script_HeyLetMeAsk::
    script_message $4246 ; '*: Hey, let me ask you'
    script_skip_if_no Script_DidSheSayAnything
    script_message $8248 ; '*: Good, you're lucky! Stay away,'
    script_end
Script_DidSheSayAnything::
    script_message $8247 ; '*: Did she say anything to'
    script_end
Script_DidYouKnowThat::
    script_message $4257 ; '*: Did you know that there's'
    script_skip_if_no Script_MonstersShouldHaveCute
    script_message $8259 ; '*: Go visit the Christener. She's'
    script_end
Script_MonstersShouldHaveCute::
    script_message $8258 ; '*: Monsters should have cute names.'
    script_end
Script_WelcomeI::
    script_message $44c3 ; '*: Welcome. I'm the Christener. I'
    script_jump_data_bank Script_Rename
    db $ff

Script_WelcomeI_2::
    script_message $44c4 ; '*: Welcome. I'm the Christener. Do'
    script_jump_data_bank Script_Rename
    db $ff

Script_HelloHeroWelcomeThis::
    script_message $4a4e ; '*: Hello, 0, welcome! This is'
    script_jump_data_bank Script_Hibernate
    db $ff

Script_HelloHeroWelcomeWant::
    script_message $4a4f ; '*: Hello, 0, welcome! Want to'
    script_jump_data_bank Script_Hibernate
    db $ff

Script_HeroCheckedTheCasket::
    script_message $4a5a ; '0 checked the casket.'
    script_message $8a5b ; '*: Zzz… Use the plan 'Charge''
    script_end
Script_HeroCheckedTheCasket_2::
    script_message $4a5a ; '0 checked the casket.'
    script_message $8a5c ; '*: Zzz… Hnnnnnrgh… Huh? Being 'Cautious''
    script_end
Script_HeroPeeredIntoThe::
    script_message $4a5e ; '0 peered into the hole.'
    script_message $8a5f ; '*: Zzz… Zzz… Some skills are'
    script_end
Script_OhACuteLittle::
    script_message $4281 ; '*: Oh, a cute little master!'
    script_skip_if_no Script_InTheKidsClass
    script_message $8283 ; '*: Oh. Well, I'll be here'
    script_end
Script_InTheKidsClass::
    script_message $8282 ; '*: In the Kids Class final,'
    script_end
Script_OhYou_7::
    script_message $4a60 ; '*: Oh, you're the Kids Class'
    script_skip_if_no Script_InTheCClass
    script_message $8283 ; '*: Oh. Well, I'll be here'
    script_end
Script_InTheCClass::
    script_message $8a61 ; '*: In the C Class final,'
    script_end
Script_OhYou_8::
    script_message $4a62 ; '*: Oh, you're the C Class'
    script_skip_if_no Script_InTheBClass
    script_message $8283 ; '*: Oh. Well, I'll be here'
    script_end
Script_InTheBClass::
    script_message $8a63 ; '*: In the B Class final,'
    script_end
Script_OhYou_9::
    script_message $4a64 ; '*: Oh, you're the B Class'
    script_skip_if_no Script_InTheAClass
    script_message $8283 ; '*: Oh. Well, I'll be here'
    script_end
Script_InTheAClass::
    script_message $8a65 ; '*: In the A Class final,'
    script_end
Script_OhYou_10::
    script_message $4a66 ; '*: Oh, you're the A Class'
    script_skip_if_no Script_InTheSClass
    script_message $8283 ; '*: Oh. Well, I'll be here'
    script_end
Script_InTheSClass::
    script_message $8a67 ; '*: In the S Class final,'
    script_end
Script_OhACuteLittle_2::
    script_message $4281 ; '*: Oh, a cute little master!'
    script_skip_if_no Script_PlayItSafeAgainst
    script_message $8283 ; '*: Oh. Well, I'll be here'
    script_end
Script_PlayItSafeAgainst::
    script_message $8216 ; '*: Play it safe against Skullroo.'
    script_end
Script_OhYou_11::
    script_message $4a60 ; '*: Oh, you're the Kids Class'
    script_skip_if_no Script_InTheCClass_2
    script_message $8283 ; '*: Oh. Well, I'll be here'
    script_end
Script_InTheCClass_2::
    script_message $8a7f ; '*: In the C Class final,'
    script_end
Script_OhYou_12::
    script_message $4a62 ; '*: Oh, you're the C Class'
    script_skip_if_no Script_InTheBClass_2
    script_message $8283 ; '*: Oh. Well, I'll be here'
    script_end
Script_InTheBClass_2::
    script_message $8a80 ; '*: In the B Class final,'
    script_end
Script_OhYou_13::
    script_message $4a64 ; '*: Oh, you're the B Class'
    script_skip_if_no Script_InTheAClass_2
    script_message $8283 ; '*: Oh. Well, I'll be here'
    script_end
Script_InTheAClass_2::
    script_message $8a81 ; '*: In the A Class final,'
    script_end
Script_OhYou_14::
    script_message $4a66 ; '*: Oh, you're the A Class'
    script_skip_if_no Script_InTheSClass_2
    script_message $8283 ; '*: Oh. Well, I'll be here'
    script_end
Script_InTheSClass_2::
    script_message $8a82 ; '*: In the S Class final,'
    script_end
Script_WelcomeToTheArena::
    script_message $426b ; '*: Welcome to the Arena! Masters'
    script_skip_if_no Script_You_6
    script_message $826d ; '*: Oh, then you must be'
    script_end
Script_You_6::
    script_message $c26c ; '*: You're young, so you have'
    script_jump_data_bank Script_Arena
    db $ff

Script_WelcomeToTheArena_2::
    script_set_flag EVENT_WELCOME_TO_THE_ARENA
    script_message $4270 ; '*: Welcome to the Arena! The'
    script_jump_data_bank Script_Arena
    db $ff

Script_HelloWhichClassWill::
    script_message $4271 ; '*: Hello, which Class will it'
    script_jump_data_bank Script_Arena
    db $ff

Script_WelcomeDoYouWish::
    script_message $4d86 ; '*: Welcome! Do you wish to'
    script_jump_data_bank Script_Arena
    db $ff

Script_Here::
    script_message $4275 ; '*: Here's the Magic Key you'
    script_message $8274 ; '*: Oh? But your key ring'
    script_end
Script_Here_2::
    script_message $0275 ; '*: Here's the Magic Key you'
    script_message $0273 ; '0 received a Magic Key.'
    script_end
Script_ILostAgainI::
    script_message $04b0 ; '*: I lost again. I need'
    script_end
    db $ff

Script_ILostAgainI_2::
    script_message $44b3 ; '*: I lost again. I need'
    script_skip_if_no Script_GoodLet
    script_message $84b2 ; '*: I'll be here for a'
    script_end
Script_GoodLet::
    script_message $c4b1 ; '*: Good! Let's get started!'
    script_end
Script_UmI::
    script_message $48cf ; '*: Um… I'm the Egg Evaluator.'
    script_set_flag EVENT_UM_I
    script_jump_data_bank Script_EggService
    db $ff

Script_I_7::
    script_message $48d0 ; '*: I'm the Egg Evaluator. May'
    script_jump_data_bank Script_EggService
    db $ff

Script_OhTheSaviorOf::
    script_set_flag EVENT_OH_THE_SAVIOR_OF
    script_message $4b20 ; '*: Oh, the savior of GreatLog.'
    script_jump_data_bank Script_EggService
    db $ff

Script_WelcomeToTheStarry::
    script_message $48d3 ; '*: Welcome to the Starry Shrine.'
    script_set_flag EVENT_WELCOME_TO_THE_STARRY_SHRINE
    script_jump_data_bank Script_Breed
    db $ff

Script_WelcomeToTheStarry_2::
    script_message $48d4 ; '*: Welcome to the Starry Shrine.'
    script_jump_data_bank Script_Breed
    db $ff

Script_Aren::
    script_set_flag EVENT_AREN
    script_message $4b2e ; '*: Aren't you GreatLog's savior? Well,'
    script_jump_data_bank Script_Breed
    db $ff

Script_I_8::
    script_message $48d5 ; '*: I'm the Prof's assistant. Do'
    script_skip_if_no Script_YouCanBreedMonsters
    script_message $88d7 ; '*: Talk to the Prof if'
    script_end
Script_YouCanBreedMonsters::
    script_message $88d6 ; '*: You can breed monsters and'
    script_end
Script_YouCanCallMe::
    script_set_flag EVENT_YOU_CAN_CALL_ME
    script_message $4a6d ; '*: You can call me the'
    script_jump_data_bank Script_MedalPrizes
    db $ff

Script_YouCanCallMe_2::
    script_message $4a6e ; '*: You can call me the'
    script_jump_data_bank Script_MedalPrizes
    db $ff

Script_WellWhoWouldHave::
    script_set_flag EVENT_WELL_WHO_WOULD_HAVE
    script_message $4b50 ; '*: Well, who would have thought'
    script_jump_data_bank Script_MedalPrizes
    db $ff

Script_I_9::
    script_message $025f ; '*: I've never seen my granddaughter'
    script_message $0260 ; '0 received a LifeAcorn.'
    script_set_flag EVENT_HERO_RECEIVED_A_LIFE_ACORN
    script_end
Script_WaitCouldIGet::
    script_message $48c8 ; '*: Wait! Could I get you'
    script_skip_if_no Script_FantasticICanOpen
    script_message $88ca ; '*: Oh… That's very disappointing. I'
    script_end
Script_FantasticICanOpen::
    script_message $88c9 ; '*: Fantastic! I can open my'
    script_command SCRIPT_REWARD_ITEM_OR_KEY_2
    script_message $0d40 ; '*: I like you to have'
    script_message $0d18 ; '0 received the Ice Key.'
    script_message $0d42 ; '*: I'll pray for your safety.'
    script_set_flag EVENT_REWARD_ITEM_OR_KEY_2
    script_end
Script_WaitCouldIGet_2::
    script_message $48c8 ; '*: Wait! Could I get you'
    script_skip_if_no Script_FantasticICanOpen_2
    script_message $88ca ; '*: Oh… That's very disappointing. I'
    script_end
Script_FantasticICanOpen_2::
    script_message $88c9 ; '*: Fantastic! I can open my'
    script_command SCRIPT_REWARD_ITEM_OR_KEY_2
    script_message $0d43 ; '*: I like you to have'
    script_set_flag EVENT_REWARD_ITEM_OR_KEY_2_1A5
    script_set_flag EVENT_REWARD_ITEM_OR_KEY_2
    script_end
Script_WaitCouldIGet_3::
    script_message $48c8 ; '*: Wait! Could I get you'
    script_skip_if_no Script_FantasticICanOpen_3
    script_message $88ca ; '*: Oh… That's very disappointing. I'
    script_end
Script_FantasticICanOpen_3::
    script_message $88c9 ; '*: Fantastic! I can open my'
    script_command SCRIPT_REWARD_ITEM_OR_KEY_2
    script_message $0d40 ; '*: I like you to have'
    script_message $0d41 ; '0 received a TinyMedal!'
    script_message $0d42 ; '*: I'll pray for your safety.'
    script_set_flag EVENT_REWARD_ITEM_OR_KEY_2
    script_end
Script_ArmyAntHelpedMeGet::
    script_message $48cb ; '*: ArmyAnt helped me get my'
    script_jump_data_bank Script_Shop
    db $ff

Script_WelcomeHowMayI_2::
    script_message $48cc ; '*: Welcome! How may I serve'
    script_jump_data_bank Script_Shop
    db $ff, $00, $8a, $4d, $e7, $59, $66, $ff

Script_I_10::
    script_message $4a46 ; '*: I'm a traveling merchant. I'm'
    script_skip_if_no Script_ThenLet
    script_message $8a48 ; '*: Oh, too bad. Another time.'
    script_end
Script_ThenLet::
    script_message $ca47 ; '*: Then let's breed them!'
    script_jump_data_bank Script_ItsAccessoryIsIn
    db $ff

Script_I_11::
    script_message $4513 ; '*: I'm a scientist. I've been'
    script_skip_if_no Script_WellLet
    script_message $8515 ; '*: Oh… Perhaps on another occasion.'
    script_end
Script_WellLet::
    script_message $c514 ; '*: Well, let's see about breeding!'
    script_jump_data_bank Script_ItsAccessoryIsIn
    db $ff

Script_HmLittleOneAre::
    script_message $44b7 ; '*: Hm? Little one, are you'
    script_skip_if_no Script_GoodLet_2
    script_message $84b9 ; '*: Oh, too bad. Another time.'
    script_end
Script_GoodLet_2::
    script_message $c4b8 ; '*: Good! Let's get this started!'
    script_jump_data_bank Script_ItsAccessoryIsIn
    db $ff

Script_IWasOnceA::
    script_message $44c8 ; '*: I was once a great'
    script_skip_if_no Script_HaveYouShownThem
    script_message $84ca ; '*: You've not found any yet?'
    script_set_flag EVENT_YOU_11D
    script_end
Script_HaveYouShownThem::
    script_message $84c9 ; '*: Have you shown them to'
    script_end
Script_OhGoodnessI::
    script_message $0b4c ; '*: Oh! Goodness! I'm surprised! I've'
    script_command SCRIPT_SCENE_KEY_SHOP
    script_set_flag EVENT_SCENE_KEY_SHOP
    script_end
Script_HowGoodOfYou::
    script_message $0bbf ; '*: How good of you to'
    script_command SCRIPT_SCENE_KEY_SHOP
    script_end
Script_WelcomeToMyKey::
    script_set_flag EVENT_WELCOME_TO_MY_KEY
    script_message $4297 ; '*: Welcome to my Key Shop!'
    script_jump_data_bank Script_KeyAppraisal
    db $ff

Script_WelcomeToMyKey_2::
    script_message $4298 ; '*: Welcome to my Key Shop!'
    script_jump_data_bank Script_KeyAppraisal
    db $ff

Script_You_7::
    script_set_flag EVENT_YOU
    script_message $4b1e ; '*: You're GreatLog's savior! Do you'
    script_jump_data_bank Script_KeyAppraisal
    db $ff

Script_YoUpCloseYou::
    script_message $44bd ; '*: Yo! Up close, you look'
    script_skip_if_no Script_ILikeYourStyle
    script_message $84bf ; '*: What? Are you sure about'
    script_end
Script_ILikeYourStyle::
    script_message $c4be ; '*: I like your style! Let's'
    script_jump_data_bank Script_ItsAccessoryIsIn
    db $ff

Script_WelcomeToTheArena_3::
    script_message $4277 ; '*: Welcome to the Arena! Would'
    script_skip_if_no Script_YourPartyMayEnter
    script_message $8279 ; '*: Oops, it's not your first'
    script_end
Script_YourPartyMayEnter::
    script_message $8278 ; '*: Your party may enter in'
    script_end
Script_WelcomeToTheArena_4::
    script_message $4277 ; '*: Welcome to the Arena! Would'
    script_skip_if_no Script_AsAProMaster
    script_message $8b66 ; '*: Oops, it's not your first'
    script_end
Script_AsAProMaster::
    script_message $8b65 ; '*: As a pro master, you'
    script_end
Script_Encounter::
    script_encounter $1a ; encounter words: Slime, Slime, Slime
    script_end
Script_CobiHeroCongratulationsI::
    script_walk 2, 3, 2
    script_face $00, 1
    script_message $0546 ; 'Cobi: 0, congratulations! I thought we'
    script_wait 60
    script_sound $28
    script_message $0547 ; '*: Hehehe, no need to worry'
    script_command SCRIPT_SCENE_HOMECOMING
    script_end
Script_TaraHeroCongratulationsI::
    script_walk 2, 3, 2
    script_face $00, 1
    script_message $054a ; 'Tara: 0, congratulations! I was sad'
    script_wait 60
    script_sound $28
    script_message $0547 ; '*: Hehehe, no need to worry'
    script_command SCRIPT_SCENE_HOMECOMING
    script_end
Script_WantToKnowHow::
    script_message $4111 ; '*: Want to know how the'
    script_skip_if_no Script_IncludingTheMonstersWith
    script_message $8113 ; '*: Aww… You know already? Boring!'
    script_end
Script_IncludingTheMonstersWith::
    script_message $8112 ; '*: Including the monsters with you,'
    script_end
Script_WantToKnowHow_2::
    script_message $4111 ; '*: Want to know how the'
    script_skip_if_no Script_TheFarmGrewA
    script_message $8113 ; '*: Aww… You know already? Boring!'
    script_end
Script_TheFarmGrewA::
    script_message $8255 ; '*: The farm grew a lot'
    script_end
Script_WantToKnowHow_3::
    script_message $4111 ; '*: Want to know how the'
    script_skip_if_no Script_IncludingTheMonstersWith_2
    script_message $8113 ; '*: Aww… You know already? Boring!'
    script_end
Script_IncludingTheMonstersWith_2::
    script_message $88be ; '*: Including the monsters with you,'
    script_end
Script_DoYouWantTo::
    script_message $4a54 ; '*: Do you want to know'
    script_skip_if_no Script_OnceAMonsterReaches
    script_message $8a58 ; '*: Everyone has a growth limit.'
    script_end
Script_OnceAMonsterReaches::
    script_command SCRIPT_GROWTH_LIMIT_INFO
    script_message $8a57 ; 'Once a monster reaches its growth'
    script_end
Script_HelloThereDoYou::
    script_message $4289 ; '*: Hello there. Do you know'
    script_skip_if_no Script_TheStrongestMasterI
    script_message $828b ; '*: You don't know? Sorry about'
    script_end
Script_TheStrongestMasterI::
    script_message $828a ; '*: The strongest master I've ever'
    script_end
Script_SceneStrongestMaster::
    script_command SCRIPT_SCENE_STRONGEST_MASTER
    script_set_flag EVENT_SCENE_STRONGEST_MASTER
    script_end
    db $00, $70, $4a, $06, $04, $00, $73, $8a, $ff, $00, $72, $8a, $ff, $00, $70, $4a
    db $06, $04, $00, $73, $8a, $ff, $00, $71, $8a, $02, $02, $02, $03, $02, $02, $03
    db $01, $02, $02, $02, $01, $05, $80, $03, $05, $82, $01, $03, $3c, $00, $60, $03
    db $3c, $00, $0f, $48, $4c, $03, $1e, $00, $0f, $ff, $0a, $37, $01, $ff

Script_PrinceKamehaHasBeen_2::
    script_set_flag EVENT_PRINCE_KAMEHA_HAS_BEEN
    script_wait 30
    script_command SCRIPT_SCENE_KAMEHA_MISSING
    script_walk_fast 0, 0, 5
    script_message $4a36 ; '*: Prince Kameha has been missing'
    script_skip_if_no Script_What_2
    script_message $8a38 ; '*: You better be telling the'
    script_walk_fast 0, 2, 5
    script_face $80, 0
    script_end
Script_What_2::
    script_message $8a37 ; '*: What's that? You saw Prince'
    script_set_flag EVENT_WHAT
    script_command SCRIPT_SCENE_SAW_KAMEHA
    script_message $0a3a ; '*: Sire, this child claims to'
    script_message $0a3b ; 'King: What's that? Is that so?'
    script_walk 0, 0, 1
    script_message $0d28 ; '0 obtained the Sky Key.'
    script_walk 0, 2, 1
    script_face $80, 0
    script_message $0d29 ; 'King: Kameha made off with the'
    script_end
Script_SceneKamehaStole::
    script_face $00, 3
    script_command SCRIPT_SCENE_KAMEHA_STOLE
    script_end
Script_PersonalityMessage::
    script_command SCRIPT_PERSONALITY_MESSAGE
    script_end
Script_WhatWillYouGive::
    script_message $0d60 ; 'What will you give to the'
    script_command SCRIPT_SAVE_SCREEN
    script_end
Script_YHasBeenGiven::
    script_message $0d61 ; 'Y has been given to the'
    script_command SCRIPT_SAVE_SCREEN
    script_end
Script_I_12::
    script_set_flag EVENT_THAT_WEIRD_APE_THING_IS_12C
    script_message $4b16 ; '*: I'm sorry. I was wrong'
    script_jump_data_bank Script_Shop_5
    db $ff

Script_HelloHowMayI::
    script_message $4b17 ; '*: Hello! How may I serve'
    script_jump_data_bank Script_Shop_5
    db $ff

Script_HelloHeroLetMe::
    script_message $4b21 ; '*: Hello, hero! Let me help'
    script_skip_if_no Script_OhButThere
    script_message $8b24 ; '*: Oh… Well, that's too bad,'
    script_end
Script_OhButThere::
    script_message $8b23 ; '*: Oh? But there's no room'
    script_end
Script_HelloHeroLetMe_2::
    script_message $4b21 ; '*: Hello, hero! Let me help'
    script_skip_if_no Script_You_8
    script_message $8b24 ; '*: Oh… Well, that's too bad,'
    script_end
Script_You_8::
    script_message $8b22 ; '*: You'll take it? Excellent! I'll'
    script_command SCRIPT_GIVE_MONSTER
    script_set_flag EVENT_GIVE_MONSTER
    script_end
Script_Didn::
    script_message $4b53 ; '*: Didn't you save GreatLog? That'
    script_skip_if_no Script_GreatLet
    script_message $8b55 ; '*: Oh. Too bad. Maybe next'
    script_end
Script_GreatLet::
    script_message $cb54 ; '*: Great! Let's give it a'
    script_jump_data_bank Script_ItsAccessoryIsIn
    db $ff

Script_AhYouMustBe::
    script_message $4b57 ; '*: Ah, you must be the'
    script_skip_if_no Script_MayGoodFortuneArrive
    script_message $8b59 ; '*: May misfortune shun you. I'll'
    script_end
Script_MayGoodFortuneArrive::
    script_message $cb58 ; '*: May good fortune arrive quickly.'
    script_jump_data_bank Script_ItsAccessoryIsIn
    db $ff

Script_IDidn::
    script_message $4b5b ; '*: I didn't think GreatLog's hero'
    script_skip_if_no Script_WellNoTimeTo
    script_message $8b5d ; '*: Oh… That's so disappointing. Well,'
    script_end
Script_WellNoTimeTo::
    script_message $cb5c ; '*: Well, no time to lose!'
    script_jump_data_bank Script_ItsAccessoryIsIn
    db $ff

Script_AreYouPerhapsGreatLog::
    script_message $4b6a ; '*: Are you perhaps GreatLog's savior?'
    script_skip_if_no Script_OKLetTheBreeding
    script_message $8b6c ; '*: No? Well, if we meet'
    script_end
Script_OKLetTheBreeding::
    script_message $cb6b ; '*: OK! Let the breeding happen!'
    script_jump_data_bank Script_ItsAccessoryIsIn
    db $ff

Script_HeyYou::
    script_message $4b70 ; '*: Hey! You're still at it,'
    script_skip_if_no Script_GreatGoodAnswer
    script_message $8b72 ; '*: That's too bad. It's a'
    script_end
Script_GreatGoodAnswer::
    script_message $cb71 ; '*: Great! Good answer!'
    script_jump_data_bank Script_ItsAccessoryIsIn
    db $ff

Script_HeroCheckedTheDesk::
    script_message $0bc3 ; '0 checked the desk.'
    script_command SCRIPT_DESK_KEY
    script_message $0b4e ; '0 obtained the Brawn Key.'
    script_set_flag EVENT_DESK_KEY
    script_end
Script_HeroCheckedTheDesk_2::
    script_message $0bc3 ; '0 checked the desk.'
    script_command SCRIPT_DESK_KEY
    script_message $0bb5 ; '0 obtained the Baffle Key.'
    script_set_flag EVENT_DESK_KEY
    script_end
Script_HeroCheckedTheDesk_3::
    script_message $0bc3 ; '0 checked the desk.'
    script_command SCRIPT_DESK_KEY
    script_message $0bb7 ; '0 obtained the Soul Key.'
    script_set_flag EVENT_DESK_KEY_0C8
    script_end
Script_HeroCheckedTheDesk_4::
    script_message $0bc3 ; '0 checked the desk.'
    script_command SCRIPT_DESK_KEY
    script_message $0bc0 ; '0 obtained the Magic Key.'
    script_end
Script_SceneTerry::
    script_sound $60
    script_command SCRIPT_SCENE_TERRY
    script_end
Script_HumphI::
    script_message $4bad ; '*: Humph… I'm Terry. I'm a'
    script_skip_if_no Script_TerryHumphConfidentHuh
    script_message $8baf ; 'Terry: Oh, it was someone else?'
    script_end
Script_TerryHumphConfidentHuh::
    script_message $8bae ; 'Terry: Humph… Confident, huh? I'll tell'
    script_command SCRIPT_SCENE_TERRY_BATTLE
    script_end
    db $00, $b0, $4b, $06, $04, $00, $af, $8b, $ff, $00, $ae, $8b, $7c, $ff

Script_KamehaI::
    script_message $4b8f ; 'Kameha: I've gone to other worlds'
    script_skip_if_no Script_KamehaSoYou
    script_message $8b91 ; 'Kameha: What? Scared, 0?'
    script_end
Script_KamehaSoYou::
    script_message $8b90 ; 'Kameha: So you're confident, huh? Let's'
    script_command SCRIPT_SCENE_KAMEHA_KEY_BATTLE
    script_end
Script_KamehaWhatOhIt::
    script_message $0b95 ; 'Kameha: What? Oh, it's 0. Did'
    script_message $0b93 ; '0 received the Elf Key.'
    script_set_flag EVENT_HERO_RECEIVED_THE_ELF_KEY
    script_end
Script_KamehaWhatOhIt_2::
    script_message $0b95 ; 'Kameha: What? Oh, it's 0. Did'
    script_message $0bc2 ; '0 received the Magic Key.'
    script_set_flag EVENT_HERO_RECEIVED_THE_ELF_KEY
    script_end
    db $00, $95, $0b, $00, $9a, $0b, $0a, $3a, $00, $ff

Script_KamehaI_2::
    script_message $4b8f ; 'Kameha: I've gone to other worlds'
    script_skip_if_no Script_KamehaSoYou_2
    script_message $8b91 ; 'Kameha: What? Scared, 0?'
    script_end
Script_KamehaSoYou_2::
    script_message $8b90 ; 'Kameha: So you're confident, huh? Let's'
    script_command SCRIPT_SCENE_KAMEHA_KEY_BATTLE_2
    script_end
Script_KamehaWhatOhIt_3::
    script_message $0b95 ; 'Kameha: What? Oh, it's 0. Did'
    script_message $0b9d ; '0 received the Traveler Key.'
    script_set_flag EVENT_HERO_RECEIVED_THE_TRAVELER_KEY
    script_end
Script_KamehaWhatOhIt_4::
    script_message $0b95 ; 'Kameha: What? Oh, it's 0. Did'
    script_message $0bc2 ; '0 received the Magic Key.'
    script_set_flag EVENT_HERO_RECEIVED_THE_TRAVELER_KEY
    script_end
Script_KingOhIt::
    script_message $4b7c ; 'King: Oh? It's our savior 0!'
    script_skip_if_no Script_KingYouWillI
    script_message $8b7e ; 'King: You refuse my request? After'
    script_end
Script_KingYouWillI::
    script_message $8b7d ; 'King: You will? I knew I'
    script_set_flag EVENT_KING_YOU_WILL_I_KNEW
    script_end
Script_KingAhYou::
    script_message $0b80 ; 'King: Ah, you've finally caught the'
    script_message $0b81 ; '0 received 10,000G.'
    script_set_flag EVENT_HERO_RECEIVED_10_000_G
    script_end
Script_KingOhIt_2::
    script_message $4b83 ; 'King: Oh? It's our savior 0!'
    script_skip_if_no Script_KingYouWillI_2
    script_message $8b7e ; 'King: You refuse my request? After'
    script_end
Script_KingYouWillI_2::
    script_message $8b84 ; 'King: You will? I knew I'
    script_set_flag EVENT_KING_YOU_WILL_I_KNEW_195
    script_end
Script_KingAhYou_2::
    script_message $0b80 ; 'King: Ah, you've finally caught the'
    script_message $0b86 ; '0 received 20,000G.'
    script_set_flag EVENT_HERO_RECEIVED_20_000_G
    script_end
Script_KingOhIt_3::
    script_message $4b83 ; 'King: Oh? It's our savior 0!'
    script_skip_if_no Script_KingYouWillI_3
    script_message $8b7e ; 'King: You refuse my request? After'
    script_end
Script_KingYouWillI_3::
    script_message $8b87 ; 'King: You will? I knew I'
    script_set_flag EVENT_KING_YOU_WILL_I_KNEW_198
    script_end
Script_KingAhYou_3::
    script_message $0b80 ; 'King: Ah, you've finally caught the'
    script_message $0b89 ; '0 received 30,000G.'
    script_set_flag EVENT_HERO_RECEIVED_30_000_G
    script_end
Script_KingOhIt_4::
    script_message $4b83 ; 'King: Oh? It's our savior 0!'
    script_skip_if_no Script_KingYouWillI_4
    script_message $8b7e ; 'King: You refuse my request? After'
    script_end
Script_KingYouWillI_4::
    script_message $8b8a ; 'King: You will? I knew I'
    script_set_flag EVENT_KING_YOU_WILL_I_KNEW_19B
    script_end
Script_KingAhYou_4::
    script_message $0b80 ; 'King: Ah, you've finally caught the'
    script_message $0b8c ; '0 received 40,000G.'
    script_set_flag EVENT_HERO_RECEIVED_40_000_G
    script_end
Script_ThisIsAGreat::
    script_set_flag EVENT_THIS_IS_AGREAT
    script_message $41d0 ; '*: This is a great spot'
    script_skip_if_no Script_PutTheDreamEgg
    script_message $81d2 ; '*: This talk is too early'
    script_end
Script_PutTheDreamEgg::
    script_message $81d1 ; '*: Put the Dream Egg on'
    script_end
Script_HaveYouEverFound::
    script_message $41d3 ; '*: Have you ever found a'
    script_skip_if_no Script_PutTheDreamEgg_2
    script_message $81d2 ; '*: This talk is too early'
    script_end
Script_PutTheDreamEgg_2::
    script_message $81d1 ; '*: Put the Dream Egg on'
    script_end
Script_You_9::
    script_walk 2, 1, 6
    script_face $00, 3
    script_message $01d4 ; '*: You're the child of the'
    script_slide_y $82
    script_message $0dde ; '*: What? You don't know about'
    script_walk 2, 3, 6
    script_set_flag EVENT_WHAT_YOU_DON
    script_end
Script_Here_3::
    script_message $0d49 ; '*: Here's that TinyMedal.'
    script_message $0d41 ; '0 received a TinyMedal!'
    script_set_flag EVENT_HERO_RECEIVED_A_TINY_MEDAL
    script_end
Script_HereItIsThe::
    script_message $0d44 ; '*: Here it is-the TinyMedal. My'
    script_message $0d41 ; '0 received a TinyMedal!'
    script_set_flag EVENT_HERO_RECEIVED_A_TINY_MEDAL_1A6
    script_end
Script_HelloWhatCanI::
    script_message $40fa ; '*: Hello! What can I do'
    script_jump_data_bank Script_Shop
    db $ff

Script_WelcomeToOurInn::
    script_message $41bb ; '*: Welcome to our inn!'
    script_jump_data_bank Script_It_3
    db $ff

Script_WelcomeToMyItem::
    script_message $4144 ; '*: Welcome to my item shop!'
    script_jump_data_bank Script_Shop_5
    db $ff

Script_HelloHowMayI_2::
    script_message $4145 ; '*: Hello! How may I serve'
    script_jump_data_bank Script_Shop_5
    db $ff

Script_TheChurchWelcomesYou::
    script_message $4146 ; '*: The church welcomes you. We'
    script_jump_data_bank Script_Priest
    db $ff

Script_IAmAServant::
    script_message $4147 ; '*: I am a servant to'
    script_jump_data_bank Script_Priest
    db $ff

Script_IAmTheLeader::
    script_message $4148 ; '*: I am the leader of'
    script_skip_if_no Script_DidYouSayYes
    script_message $814c ; '*: You close the door to'
    script_end
Script_DidYouSayYes::
    script_message $8149 ; '*: Did you say yes? Yes,'
    script_set_flag EVENT_DID_YOU_SAY_YES_YES
    script_command SCRIPT_SCENE_MONSTER_INSPECTION
    script_face $83, 2
    script_message $0153 ; '*: Very good show! That was'
    script_set_flag EVENT_SCENE_MONSTER_INSPECTION
    script_end
Script_IAmTheLeader_2::
    script_message $4148 ; '*: I am the leader of'
    script_skip_if_no Script_DidYouSayYes_2
    script_message $814c ; '*: You close the door to'
    script_end
Script_DidYouSayYes_2::
    script_message $814b ; '*: Did you say yes? Yes,'
    script_set_flag EVENT_DID_YOU_SAY_YES_YES
    script_end
Script_IAmTheLeader_3::
    script_message $4148 ; '*: I am the leader of'
    script_skip_if_no Script_DidYouSayYes_3
    script_message $814c ; '*: You close the door to'
    script_end
Script_DidYouSayYes_3::
    script_message $814a ; '*: Did you say yes? Yes,'
    script_set_flag EVENT_DID_YOU_SAY_YES_YES
    script_end
Script_AhThreeHealthyMonsters::
    script_message $014d ; '*: Ah, three healthy monsters! Very'
    script_command SCRIPT_SCENE_MONSTER_INSPECTION
    script_face $83, 2
    script_message $0153 ; '*: Very good show! That was'
    script_set_flag EVENT_SCENE_MONSTER_INSPECTION
    script_end
Script_WelcomeToOurInn_2::
    script_message $41bb ; '*: Welcome to our inn!'
    script_jump_data_bank Script_It_3
    db $ff

Script_KingAhYou_5::
    script_message $4160 ; 'King: Ah, you're the monster tamer'
    script_skip_if_no Script_KingYouWishTo
    script_message $8d01 ; 'King: Then, you are excused. I'm'
    script_end
Script_KingYouWishTo::
    script_set_flag EVENT_KING_YOU_WISH_TO
    script_message $8d02 ; 'King: You wish to see our'
    script_command SCRIPT_SCENE_KING_AUDIENCE
    script_message $4161 ; 'King: I see. This is what'
    script_skip_if_no Script_KingThenMakeWay
    script_message $8163 ; 'King: Oh… You won't? Then, I'
    script_end
Script_KingThenMakeWay::
    script_message $8162 ; 'King: Then make way to the'
    script_set_flag EVENT_KING_THEN_MAKE_WAY_TO
    script_end
Script_KingSoHaveYou::
    script_message $4165 ; 'King: So? Have you decided to'
    script_skip_if_no Script_KingThenMakeWay_2
    script_message $8163 ; 'King: Oh… You won't? Then, I'
    script_end
Script_KingThenMakeWay_2::
    script_message $8162 ; 'King: Then make way to the'
    script_set_flag EVENT_KING_THEN_MAKE_WAY_TO
    script_end
Script_SoHaveYouDiscovered::
    script_message $016c ; '*: So, have you discovered what'
    script_walk_fast 0, 2, 4
    script_walk 1, 1, 1
    script_walk 1, 0, 4
    script_message $016d ; 'King: The canal is managed by'
    script_slide_y $80
    script_message $016e ; '*: Your Majesty, I must remind'
    script_walk_fast 1, 3, 1
    script_walk_fast 1, 1, 2
    script_walk_fast 1, 3, 2
    script_walk_fast 1, 1, 1
    script_face $81, 0
    script_message $016f ; 'King: What? Never mind, then! I'll'
    script_walk_fast 1, 3, 1
    script_walk_fast 1, 0, 5
    script_set_flag EVENT_KING_WHAT_NEVER_MIND_THEN
    script_end
Script_WhatOpenTheCanal::
    script_message $0171 ; '*: What? Open the Canal Gate'
    script_command SCRIPT_SCENE_CANAL_GATE
    script_wait 30
    script_walk_fast 0, 2, 2
    script_walk_fast 0, 3, 1
    script_walk_fast 0, 2, 1
    script_hide_object $00
    script_end
Script_I_13::
    script_message $0175 ; '*: I'm making a new home'
    script_encounter $16 ; encounter words: Beavern, Slime, Slime
    script_message $0176 ; '*: Gaah! You're too strong! You'
    script_face $80, 2
    script_slide_y $80
    script_message $0177 ; 'King: What? So that's the truth?'
    script_face $81, 0
    script_message $0178 ; '*: You will? So we can'
    script_hide_object $01
    script_set_flag EVENT_YOU_WILL_SO_WE_CAN
    script_command SCRIPT_SCENE_WATER_SOLVED
    script_set_flag EVENT_SCENE_WATER_SOLVED
    script_message $0179 ; 'King: This should solve the water'
    script_walk 0, 0, 3
    script_end
Script_SceneWaterReward::
    script_command SCRIPT_SCENE_WATER_REWARD
    script_end
    db $4d, $ff

Script_KingTheTown::
    script_message $0181 ; 'King: The town's water shortage seems'
    script_set_flag EVENT_KING_THE_TOWN
    script_walk 1, 0, 8
    script_command SCRIPT_SCENE_WATER_SHORTAGE
    script_walk_fast 0, 1, 3
    script_face $80, 2
    script_message $0182 ; 'King: Wha-what? What happened?'
    script_face $81, 0
    script_message $0183 ; '*: …We… We were jumped by'
    script_slide_y $80
    script_message $0184 ; 'King: What? Arrrrgh! Round up all'
    script_command SCRIPT_SCENE_TREASURE_THEFT
    script_walk 0, 0, 1
    script_walk 0, 1, 1
    script_face $00, 3
    script_message $0187 ; 'King: I apologize, but my treasures'
    script_walk 0, 0, 8
    script_set_flag EVENT_SCENE_TREASURE_THEFT
    script_end
Script_WhWhereIsEverybody::
    script_message $4188 ; '*: Wh-where is everybody? I haven't'
    script_skip_if_no Script_HeroHadNoFood
    script_message $818d ; '*: Tch, what good are you?'
    script_end
Script_HeroHadNoFood::
    script_message $818c ; '0 had no food to give…'
    script_message $018d ; '*: Tch, what good are you?'
    script_end
Script_WhWhereIsEverybody_2::
    script_message $4188 ; '*: Wh-where is everybody? I haven't'
    script_skip_if_no Script_HeroHandedOverSome
    script_message $818d ; '*: Tch, what good are you?'
    script_end
Script_HeroHandedOverSome::
    script_message $8189 ; '0 handed over some food.'
    script_message $018a ; '*: Munch, munch… Chew, gulp… Fwoaar,'
    script_message $018b ; '0 received a WaterCall.'
    script_message $0d03 ; '*: That will help you for'
    script_command SCRIPT_CHECK_ITEM
    script_set_flag EVENT_CHECK_ITEM
    script_end
Script_SceneMonstersInTow::
    script_set_flag EVENT_SCENE_MONSTERS_IN_TOW
    script_command SCRIPT_SCENE_MONSTERS_IN_TOW
    script_end
Script_HehYouHaveMonsters::
    script_message $0196 ; '*: Heh, you have monsters in'
    script_set_flag EVENT_HEH_YOU_HAVE_MONSTERS_IN
    script_encounter $00 ; encounter words: CurseLamp, Slime, Slime
    script_message $0198 ; '*: You defeated my monster? Urggh…'
    script_command SCRIPT_SCENE_RIVAL_DEFEATED
    script_end
Script_YouAgainYou::
    script_message $0197 ; '*: You again! You're determined! But'
    script_encounter $00 ; encounter words: CurseLamp, Slime, Slime
    script_message $0198 ; '*: You defeated my monster? Urggh…'
    script_command SCRIPT_SCENE_RIVAL_DEFEATED
    script_end
Script_SceneRivalFade::
    script_sound $60
    script_command SCRIPT_SCENE_RIVAL_FADE
    script_end
Script_WhyAreYouSnooping::
    script_message $415c ; '*: Why are you snooping around?'
    script_skip_if_no Script_ANewPlugFor
    script_message $815e ; '*: Oh, it looked like you'
    script_end
Script_ANewPlugFor::
    script_message $815d ; '*: A new plug for the'
    script_end
Script_HelloHaveYouFound::
    script_message $4d04 ; '*: Hello, have you found a'
    script_skip_if_no Script_OhThat
    script_message $8d06 ; '*: I can show you my'
    script_end
Script_OhThat::
    script_message $8d05 ; '*: Oh. That's nice. Good for'
    script_end
Script_ScenePoorChurch::
    script_wait 20
    script_command SCRIPT_SCENE_POOR_CHURCH
    script_end
Script_OurChurchIsImpoverished::
    script_message $4da0 ; '*: Our church is impoverished, so'
    script_jump_data_bank Script_Priest
    db $ff

Script_IAmAServant_2::
    script_message $4147 ; '*: I am a servant to'
    script_jump_data_bank Script_Priest
    db $ff

Script_TheBirdsAreNoisy::
    script_message $0806 ; '*: …The birds are noisy… It's'
    script_command SCRIPT_SHAKE_SCREEN
    script_message $0807 ; '*: …See? What did I just'
    script_end
Script_IDon::
    script_message $4809 ; '*: I don't have much but…'
    script_jump_data_bank Script_Shop_5
    db $ff, $ff

Script_WelcomeToOurInn_3::
    script_message $41bb ; '*: Welcome to our inn!'
    script_jump_data_bank Script_It_3
    db $ff

Script_HaveYouHeardThe::
    script_message $4818 ; '*: Have you heard the legend'
    script_skip_if_no Script_AhYou
    script_message $881a ; '*: Long ago, a deft craftsman'
    script_end
Script_AhYou::
    script_message $8819 ; '*: Ah, you've heard already. It's'
    script_end
Script_HowMayOurChurch::
    script_message $4820 ; '*: How may our church serve'
    script_jump_data_bank Script_Priest
    db $ff

Script_IOfferQualityMerchandise::
    script_message $4823 ; '*: I offer quality merchandise. Would'
    script_jump_data_bank Script_Shop_5
    db $ff

Script_HeroTriedToCheck::
    script_message $082c ; '0 tried to check the chest.'
    script_message $082d ; '*: Whoa! Hands off my merchandise!'
    script_end
Script_WelcomeToOurInn_4::
    script_message $41bb ; '*: Welcome to our inn!'
    script_jump_data_bank Script_It_3
    db $ff

Script_SceneWhoAreYou::
    script_sound $28
    script_wait 140
    script_command SCRIPT_SCENE_WHO_ARE_YOU
    script_walk 0, 1, 1
    script_walk 0, 0, 3
    script_walk_fast 1, 1, 1
    script_walk_fast 1, 0, 7
    script_walk_fast 2, 3, 1
    script_walk_fast 2, 0, 7
    script_wait 30
    script_sound $ff
    script_end
Script_WhoAreYouThis::
    script_message $0838 ; '*: Who are you? This is'
    script_encounter $01 ; encounter words: HoodSquid, Slime, Slime
    script_command SCRIPT_SCENE_WATCH_OUT
    script_set_flag EVENT_SCENE_WATCH_OUT
    script_end
Script_YouCanKeepTrying::
    script_message $0839 ; '*: You can keep trying, but'
    script_encounter $01 ; encounter words: HoodSquid, Slime, Slime
    script_command SCRIPT_SCENE_WATCH_OUT
    script_set_flag EVENT_SCENE_WATCH_OUT
    script_end
Script_SceneWatchOut::
    script_command SCRIPT_SCENE_WATCH_OUT
    script_end
Script_ZzzZzzHuhWatch::
    script_message $083a ; '*: Zzz… Zzz… Huh! Watch out!'
    script_slide_y $83
    script_message $483b ; '*: What! Why are you with'
    script_skip_if_no Script_ItWasInMy
    script_message $883e ; '*: It's a tale of high'
    script_end
Script_ItWasInMy::
    script_message $883c ; '*: It was in my callow'
    script_wait 120
    script_message $083d ; '*: The pirates' loot is probably'
    script_set_flag EVENT_THE_PIRATES
    script_end
Script_WhatAreYouHere::
    script_message $483f ; '*: What? Are you here for'
    script_skip_if_no Script_ThePiratesStoleThe
    script_message $8841 ; '*: It's a chance to hear'
    script_end
Script_ThePiratesStoleThe::
    script_message $8840 ; '*: The pirates stole the MoonRock'
    script_end
Script_ZzzZzzHuhWatch_2::
    script_message $083a ; '*: Zzz… Zzz… Huh! Watch out!'
    script_slide_y $83
    script_message $0dc4 ; '*: What is it? Ah, it's'
    script_end
Script_InThePastMermaids::
    script_message $4810 ; '*: In the past, mermaids are'
    script_skip_if_no Script_ThenI
    script_message $8817 ; '*: Ah… Shame… Please come again.'
    script_end
Script_ThenI::
    script_message $8811 ; '*: Then I'll sing! Lalala~ lala'
    script_command SCRIPT_SCENE_DANCING
    script_message $0816 ; '*: Erm… The sense of rhythm'
    script_end
Script_InThePastMermaids_2::
    script_message $4810 ; '*: In the past, mermaids are'
    script_skip_if_no Script_ThenI_2
    script_message $8817 ; '*: Ah… Shame… Please come again.'
    script_end
Script_ThenI_2::
    script_message $8811 ; '*: Then I'll sing! Lalala~ lala'
    script_command SCRIPT_SCENE_MERMAID_SONG
    script_end
Script_InThePastMermaids_3::
    script_message $4810 ; '*: In the past, mermaids are'
    script_skip_if_no Script_ThenI_3
    script_message $8817 ; '*: Ah… Shame… Please come again.'
    script_end
Script_ThenI_3::
    script_message $8811 ; '*: Then I'll sing! Lalala~ lala'
    script_command SCRIPT_SCENE_MERMAID_SONG_2
    script_end
Script_InThePastMermaids_4::
    script_message $4810 ; '*: In the past, mermaids are'
    script_skip_if_no Script_YourMonstersAppearDispirited
    script_message $8817 ; '*: Ah… Shame… Please come again.'
    script_end
Script_YourMonstersAppearDispirited::
    script_message $8892 ; '*: …Your monsters appear dispirited… It's'
    script_end
Script_DoYouWantTo_2::
    script_message $484b ; '*: Do you want to go'
    script_skip_if_no Script_CloseYourEyesA
    script_message $884d ; '*: Come back for a visit'
    script_end
Script_CloseYourEyesA::
    script_message $884c ; '*: Close your eyes a little'
    script_command SCRIPT_WARP_MAP41
    script_end
Script_WelcomeYoungHumanI::
    script_message $0855 ; '*: Welcome, young human. I heard'
    script_set_flag EVENT_WELCOME_YOUNG_HUMAN_I_HEARD
    script_end
Script_WelcomeMyYoungHero::
    script_message $0dc5 ; '*: Welcome, my young hero! No'
    script_message $0dc6 ; '0 received the Sailor Ring.'
    script_set_flag EVENT_HERO_RECEIVED_THE_SAILOR_RING
    script_end
Script_SceneSailorRing::
    script_command SCRIPT_SCENE_SAILOR_RING
    script_end
Script_HowCouldWeDie::
    script_message $0859 ; '*: How could we die before'
    script_encounter $17 ; encounter words: BoneSlave, Slime, Slime
    script_set_flag EVENT_HOW_COULD_WE_DIE_BEFORE
    script_command SCRIPT_SCENE_PIRATE_GHOSTS
    script_end
Script_TheTreasuresAreOurs::
    script_message $085a ; '*: The treasures are ours… No'
    script_encounter $17 ; encounter words: BoneSlave, Slime, Slime
    script_set_flag EVENT_THE_TREASURES_ARE_OURS_NO
    script_command SCRIPT_SCENE_PIRATE_GHOSTS
    script_end
Script_ItNagsAndNags::
    script_message $085c ; '*: It nags and nags that'
    script_encounter $17 ; encounter words: BoneSlave, Slime, Slime
    script_set_flag EVENT_IT_NAGS_AND_NAGS_THAT
    script_command SCRIPT_SCENE_PIRATE_GHOSTS
    script_end
Script_WhoDisturbsUsIn::
    script_message $085e ; '*: Who disturbs us in our'
    script_encounter $02 ; encounter words: BoneSlave, CaptDead, BoneSlave
    script_message $0860 ; '*: Child… We have lost… Finally,'
    script_command SCRIPT_GIVE_ITEM_BLINK
    script_set_flag EVENT_GIVE_ITEM_BLINK
    script_end
Script_YouSeemToNot::
    script_message $085f ; '*: …You seem to not understand…'
    script_encounter $02 ; encounter words: BoneSlave, CaptDead, BoneSlave
    script_message $0860 ; '*: Child… We have lost… Finally,'
    script_command SCRIPT_GIVE_ITEM_BLINK
    script_set_flag EVENT_GIVE_ITEM_BLINK
    script_end
Script_HeroCheckedTheTreasure::
    script_message $0887 ; '0 checked the treasure chest. 0'
    script_command SCRIPT_SCENE_CRATE
    script_set_flag EVENT_SCENE_CRATE
    script_end
Script_HeroCheckedTheCrate::
    script_message $0863 ; '0 checked the crate. There was'
    script_command SCRIPT_SET_TILES_FLAG_310
    script_end
Script_SceneKamehaEscape::
    script_command SCRIPT_SCENE_KAMEHA_ESCAPE
    script_end
Script_KamehaWahahahahThanksFor::
    script_sound $28
    script_message $0868 ; 'Kameha: Wahahahah! Thanks for guiding me'
    script_command SCRIPT_SCENE_KAMEHA_CAUGHT
    script_wait 30
    script_sound $ff
    script_end
Script_KamehaUrkHowYou::
    script_sound $28
    script_slide_y $80
    script_message $0869 ; 'Kameha: Urk! How you catch up?'
    script_face $80, 1
    script_walk_fast 1, 3, 3
    script_walk_fast 1, 2, 1
    script_face $81, 1
    script_walk_fast 2, 3, 3
    script_walk_fast 2, 0, 3
    script_face $82, 1
    script_message $086a ; '*: …Aye, aye, sir! Right behind'
    script_command SCRIPT_SCENE_CREW_FOLLOWS
    script_sound $65
    script_hide_object $00
    script_wait 15
    script_sound $65
    script_hide_object $01
    script_wait 15
    script_sound $65
    script_hide_object $02
    script_set_flag EVENT_SCENE_CREW_FOLLOWS
    script_wait 90
    script_sound $ff
    script_end
Script_KamehaArrrrhClearThe::
    script_sound $28
    script_message $086b ; 'Kameha: Arrrrh, clear the way! I'm'
    script_command SCRIPT_SCENE_KAMEHA_FLEES
    script_sound $00
    script_message $0891 ; 'Kameha: Aiyeeeeeh…'
    script_sound $65
    script_wait 90
    script_sound $ff
    script_end
Script_SceneMermaidKingdom::
    script_wait 140
    script_command SCRIPT_SCENE_MERMAID_KINGDOM
    script_sound $ff
    script_end
Script_ThisIsTheMermaid::
    script_message $488e ; '*: This is the mermaid kingdom.'
    script_skip_if_no Script_CloseYourEyesFor
    script_message $8890 ; '*: Oh. Tell me if you'
    script_end
Script_CloseYourEyesFor::
    script_message $888f ; '*: Close your eyes for a'
    script_command SCRIPT_SCENE_TENTACLES
    script_end
Script_ThickSuctionCuppedTentacles::
    script_message $0893 ; 'Thick, suction- cupped tentacles snaked out'
    script_encounter $1e ; encounter words: KingSquid, Slime, Slime
    script_set_flag EVENT_THICK_SUCTION_CUPPED_TENTACLES_SNAKED
    script_end
Script_OurChurchIsImpoverished_2::
    script_message $4da1 ; '*: Our church is impoverished, so'
    script_jump_data_bank Script_Priest
    db $ff

Script_IAmAServant_3::
    script_message $4147 ; '*: I am a servant to'
    script_jump_data_bank Script_Priest
    db $ff

Script_HaveYouHeardAbout_2::
    script_message $4308 ; '*: Have you heard about the'
    script_skip_if_no Script_ALongTimeAgo
    script_message $830a ; '*: Many years ago, our ancestors'
    script_end
Script_ALongTimeAgo::
    script_message $8309 ; '*: A long time ago the'
    script_end
Script_WelcomeHowMayI_3::
    script_message $4310 ; '*: Welcome! How may I serve'
    script_jump_data_bank Script_Shop_5
    db $ff

Script_WelcomeToOurInn_5::
    script_message $41bb ; '*: Welcome to our inn!'
    script_jump_data_bank Script_It_3
    db $ff

Script_HeroCheckedTheShield::
    script_message $0316 ; '0 checked the shield. A beautiful'
    script_message $4317 ; '*: I am surprised that you'
    script_skip_if_no Script_YouWillNoWords
    script_message $831a ; '*: You may think terrible of'
    script_end
Script_YouWillNoWords::
    script_message $8318 ; '*: You will? No words of'
    script_command SCRIPT_BLINK_SPRITES
    script_set_flag EVENT_BLINK_SPRITES
    script_end
Script_WhatIsThatDirty::
    script_message $031c ; '*: What is that dirty medal?'
    script_walk 0, 2, 1
    script_hide_object $00
    script_set_flag EVENT_WHAT_IS_THAT_DIRTY_MEDAL
    script_end
Script_AhYouAreThe::
    script_message $0321 ; '*: Ah, you are the spirit's'
    script_set_flag EVENT_AH_YOU_ARE_THE_SPIRIT
    script_command SCRIPT_SCENE_SPIRIT_ENVOY
    script_walk 1, 0, 2
    script_set_flag EVENT_SCENE_SPIRIT_ENVOY
    script_end
Script_WeReportedToThe::
    script_message $0359 ; '*: We reported to the King'
    script_command SCRIPT_SCENE_REPORT_TO_KING
    script_sound $28
    script_set_flag EVENT_SCENE_REPORT_TO_KING
    script_end
Script_WelcomeWhatCanI::
    script_message $4331 ; '*: Welcome! What can I do'
    script_jump_data_bank Script_Shop
    db $ff

Script_GreetingsHowShallI::
    script_message $4332 ; '*: Greetings! How shall I serve'
    script_jump_data_bank Script_Shop_5
    db $ff

Script_HelloHaveALook::
    script_message $4333 ; '*: Hello! Have a look at'
    script_jump_data_bank Script_Shop_5
    db $ff

Script_WelcomeToOurInn_6::
    script_message $41bb ; '*: Welcome to our inn!'
    script_jump_data_bank Script_It_3
    db $ff

Script_HowMayOurChurch_2::
    script_message $4820 ; '*: How may our church serve'
    script_jump_data_bank Script_Priest
    db $ff

Script_WhatWhatWasThat::
    script_sound $65
    script_command SCRIPT_SCENE_EXPLOSION
    script_walk_fast 1, 3, 4
    script_walk_fast 2, 1, 3
    script_slide_y $81
    script_message $0349 ; '*: What? What was that explosion?'
    script_slide_y $82
    script_message $034a ; '*: That dust there… Is that'
    script_slide_y $81
    script_message $034b ; '*: What? That's all that there'
    script_slide_y $82
    script_message $034c ; '*: We better get word to'
    script_walk_fast 2, 3, 3
    script_message $034d ; '*: That's true… I've got to…'
    script_walk_fast 1, 1, 4
    script_command SCRIPT_SCENE_GOT_TO
    script_set_flag EVENT_SCENE_GOT_TO
    script_end
Script_WhatWhatWasThat_2::
    script_command SCRIPT_SCENE_EXPLOSION
    script_walk_fast 1, 3, 4
    script_walk_fast 2, 1, 3
    script_slide_y $81
    script_message $0349 ; '*: What? What was that explosion?'
    script_slide_y $82
    script_message $034a ; '*: That dust there… Is that'
    script_slide_y $81
    script_message $034b ; '*: What? That's all that there'
    script_slide_y $82
    script_message $034c ; '*: We better get word to'
    script_walk_fast 2, 3, 3
    script_message $034d ; '*: That's true… I've got to…'
    script_walk_fast 1, 1, 4
    script_command SCRIPT_SCENE_GOT_TO
    script_set_flag EVENT_SCENE_GOT_TO
    script_end
Script_HeroTappedOnThe::
    script_message $0360 ; '0 tapped on the wall. The'
    script_face $81, 2
    script_command SCRIPT_SCENE_WALL_EXIT
    script_end
Script_HeroTappedOnThe_2::
    script_message $0363 ; '0 tapped on the wall. Sound'
    script_face $81, 2
    script_command SCRIPT_SCENE_WALL_EXIT
    script_message $0364 ; 'Kameha: That's it! That's the exit!'
    script_walk_fast 1, 2, 3
    script_hide_object $01
    script_wait 30
    script_set_flag EVENT_SCENE_WALL_EXIT
    script_sound $ff
    script_walk_fast 0, 3, 4
    script_walk_fast 0, 2, 5
    script_hide_object $00
    script_end
Script_I_14::
    script_command SCRIPT_SCENE_REAL_KING
    script_message $0365 ; '*: I'm the real King, you'
    script_slide_y $81
    script_message $0366 ; '*: What? How dare you, impostor!'
    script_set_flag EVENT_SCENE_REAL_KING
    script_end
Script_ArrghYou::
    script_message $0370 ; '*: Arrgh, you've ruined my plan'
    script_command SCRIPT_SCENE_PLAN_RUINED
    script_face $81, 2
    script_slide_y $81
    script_message $0374 ; '*: Bravo! We're saved! Thank you'
    script_set_flag EVENT_SCENE_PLAN_RUINED_094
    script_end
Script_ItAlmostWorkedTo::
    script_message $0372 ; '*: It almost worked to perfection!'
    script_command SCRIPT_SCENE_PLAN_RUINED
    script_face $81, 2
    script_slide_y $81
    script_message $0374 ; '*: Bravo! We're saved! Thank you'
    script_set_flag EVENT_SCENE_PLAN_RUINED_094
    script_end
Script_WelcomeToOurInn_7::
    script_message $41bb ; '*: Welcome to our inn!'
    script_jump_data_bank Script_It_3
    db $ff

Script_HelloHowMayI_3::
    script_message $438b ; '*: Hello! How may I serve'
    script_jump_data_bank Script_Shop_5
    db $ff

Script_HeroReadTheSign::
    script_message $0394 ; '0 read the sign. 'Come all'
    script_sound $28
    script_command SCRIPT_GATHER_FOLLOWERS
    script_wait 90
    script_walk_fast 3, 2, 4
    script_face $83, 1
    script_message $0395 ; 'Kameha: Well, if it isn't 0!'
    script_walk 3, 0, 1
    script_face $83, 2
    script_wait 30
    script_walk_fast 3, 2, 1
    script_sound $63
    script_walk_fast 1, 2, 1
    script_hide_object $01
    script_walk 3, 0, 1
    script_face $83, 2
    script_wait 30
    script_walk_fast 3, 2, 1
    script_sound $63
    script_walk_fast 2, 2, 2
    script_hide_object $02
    script_wait 30
    script_walk_fast 3, 2, 3
    script_hide_object $03
    script_wait 30
    script_sound $ff
    script_set_flag EVENT_GATHER_FOLLOWERS
    script_end
Script_You_10::
    script_message $039d ; '*: You're here to cheer Lady'
    script_walk 0, 2, 1
    script_walk 0, 1, 1
    script_face $80, 0
    script_end
Script_KingMagnificentDon::
    script_sound $28
    script_command SCRIPT_SCENE_CHEER_YUNA
    script_message $03a2 ; 'King: Magnificent! Don't you agree?'
    script_face $80, 1
    script_message $03a3 ; '*: …………'
    script_face $80, 0
    script_message $03a4 ; 'King: …Sigh… Not even this… You'
    script_set_flag EVENT_SCENE_CHEER_YUNA
    script_end
Script_HelloWhatMayI::
    script_message $43b3 ; '*: Hello! What may I do'
    script_jump_data_bank Script_Shop_5
    db $ff

Script_IRetiredAsA::
    script_message $43b5 ; '*: I retired as a teacher'
    script_skip_if_no Script_LadyYunaWasA
    script_message $83b7 ; '*: Oh, you're rushed for time…'
    script_end
Script_LadyYunaWasA::
    script_message $83b6 ; '*: Lady Yuna was a rambunctious'
    script_end
Script_WelcomeToOurInn_8::
    script_message $41bb ; '*: Welcome to our inn!'
    script_jump_data_bank Script_It_3
    db $ff

Script_ThisIsNoPlace::
    script_message $03b0 ; '*: This is no place for'
    script_slide_y $80
    script_message $03b1 ; '*: Oh? An envoy from the'
    script_walk 0, 2, 1
    script_hide_object $00
    script_set_flag EVENT_OH_AN_ENVOY_FROM_THE
    script_end
Script_ThisIsNoPlace_2::
    script_message $03b0 ; '*: This is no place for'
    script_slide_y $81
    script_message $03b1 ; '*: Oh? An envoy from the'
    script_walk 1, 2, 1
    script_hide_object $01
    script_set_flag EVENT_OH_AN_ENVOY_FROM_THE
    script_end
Script_SceneSpiritEnvoy2::
    script_command SCRIPT_SCENE_SPIRIT_ENVOY_2
    script_end
Script_YouStartledMeI::
    script_message $0d4c ; '*: …………? You startled me… I'
    script_command SCRIPT_GIVE_ITEM_BLINK
    script_set_flag EVENT_GIVE_ITEM_BLINK_09A
    script_end
Script_YouStartledMeI_2::
    script_message $4ab5 ; '*: …………? You startled me… I'
    script_set_flag EVENT_GIVE_ITEM_BLINK_09A
    script_skip_if_no Script_YouWillThankYou
    script_message $8ac9 ; '*: Oh… How terribly disappointing. I'll'
    script_command SCRIPT_GIVE_ITEM_BLINK
    script_end
Script_YouWillThankYou::
    script_message $8ab6 ; '*: You will? Thank you! Let'
    script_set_flag EVENT_YOU_WILL_THANK_YOU_LET
    script_command SCRIPT_GIVE_ITEM_BLINK
    script_message $0ab7 ; '0 obtained YunaSoul.'
    script_end
Script_YouStartledMeI_3::
    script_message $4ab5 ; '*: …………? You startled me… I'
    script_set_flag EVENT_GIVE_ITEM_BLINK_09A
    script_skip_if_no Script_YouWillThankYou_2
    script_message $8ac9 ; '*: Oh… How terribly disappointing. I'll'
    script_command SCRIPT_GIVE_ITEM_BLINK
    script_end
Script_YouWillThankYou_2::
    script_message $8ac8 ; '*: You will? Thank you! Let'
    script_end
Script_IDon_2::
    script_message $0d4d ; '*: I don't remember who I'
    script_command SCRIPT_GIVE_ITEM_BLINK
    script_end
Script_IDon_3::
    script_message $4aca ; '*: I don't remember who I'
    script_skip_if_no Script_YouWillThankYou_3
    script_message $8ac9 ; '*: Oh… How terribly disappointing. I'll'
    script_command SCRIPT_GIVE_ITEM_BLINK
    script_end
Script_YouWillThankYou_3::
    script_message $8ab6 ; '*: You will? Thank you! Let'
    script_set_flag EVENT_YOU_WILL_THANK_YOU_LET
    script_command SCRIPT_GIVE_ITEM_BLINK
    script_message $0ab7 ; '0 obtained YunaSoul.'
    script_end
Script_IDon_4::
    script_message $4aca ; '*: I don't remember who I'
    script_skip_if_no Script_YouWillThankYou_4
    script_message $8ac9 ; '*: Oh… How terribly disappointing. I'll'
    script_command SCRIPT_GIVE_ITEM_BLINK
    script_end
Script_YouWillThankYou_4::
    script_message $8ac8 ; '*: You will? Thank you! Let'
    script_end
Script_Message::
    script_message $0d3c ; '*: …………!'
    script_message $0ad1 ; '*: …… STOP… DON'T MEDDLE…'
    script_command SCRIPT_SCENE_PRINCESS_MEDICINE
    script_end
Script_Message_2::
    script_message $03a3 ; '*: …………'
    script_message $0dd2 ; 'The princess did not reply. But'
    script_message $0ad3 ; '*: FOOLHARDY. BRAVE BUT FOOLISH.'
    script_command SCRIPT_SCENE_PRINCESS_MEDICINE
    script_end
Script_PardonMeYouHave::
    script_message $0aea ; '*: Pardon me? You have medicine?'
    script_walk 2, 1, 2
    script_hide_object $02
    script_hold_dpad $01, 3
    script_command SCRIPT_SCENE_MEDICINE_GIVEN
    script_set_flag EVENT_SCENE_MEDICINE_GIVEN
    script_end
Script_SceneShieldGuardian::
    script_command SCRIPT_SCENE_SHIELD_GUARDIAN
    script_end
Script_SceneShieldGuardian_2::
    script_command SCRIPT_SCENE_SHIELD_GUARDIAN
    script_end
Script_HeroCheckedTheShield_2::
    script_message $0a01 ; '0 checked the shield.'
    script_command SCRIPT_SCENE_SHIELD
    script_end
Script_SceneShield::
    script_command SCRIPT_SCENE_SHIELD
    script_end
Script_SceneShield2::
    script_command SCRIPT_SCENE_SHIELD_2
    script_end
Script_HowMayOurChurch_3::
    script_message $4820 ; '*: How may our church serve'
    script_jump_data_bank Script_Priest
    db $ff

Script_HeroCheckedTheTreasure_2::
    script_message $0319 ; '0 checked the treasure chest. 0'
    script_hide_object $01
    script_set_flag EVENT_HERO_CHECKED_THE_TREASURE_CHEST
    script_end
Script_SceneChestServant::
    script_command SCRIPT_SCENE_CHEST_SERVANT
    script_end
Script_HowMayWeServe::
    script_message $442e ; '*: How may we serve your'
    script_jump_data_bank Script_Priest
    db $ff

Script_HeroCheckedTheGrave::
    script_message $040b ; '0 checked the grave. There was'
    script_command SCRIPT_SCENE_GRAVE
    script_set_flag EVENT_SCENE_GRAVE
    script_end
Script_HeroCheckedTheGrave_2::
    script_message $040b ; '0 checked the grave. There was'
    script_command SCRIPT_SCENE_GRAVE
    script_end
Script_FineYou::
    script_message $0411 ; '*: …Fine! You've done well to'
    script_sound $66
    script_command SCRIPT_SET_TILES_D2
    script_end
Script_WelcomeToOurInn_9::
    script_message $41bb ; '*: Welcome to our inn!'
    script_jump_data_bank Script_It_3
    db $ff

Script_Kweeeeh::
    script_message $0412 ; '*: Kweeeeh!'
    script_message $0de6 ; 'Look! A MadCondor! It has something!'
    script_command SCRIPT_SCENE_MADCONDOR
    script_set_flag EVENT_SCENE_MADCONDOR
    script_end
Script_HmYou::
    script_message $041d ; '*: Hm? You're from the village!'
    script_walk 0, 1, 1
    script_face $80, 3
    script_end
Script_YouAreYouA::
    script_message $4426 ; '*: You… Are you a monster?'
    script_skip_if_no Script_UhHuhYouDon
    script_message $8428 ; '*: Uh-huh… You look uh… delicious.'
    script_end
Script_UhHuhYouDon::
    script_message $8427 ; '*: Uh-huh… You don't look very'
    script_end
Script_YouAreYouA_2::
    script_message $4426 ; '*: You… Are you a monster?'
    script_skip_if_no Script_AnyWayYouWant
    script_message $8428 ; '*: Uh-huh… You look uh… delicious.'
    script_end
Script_AnyWayYouWant::
    script_message $8429 ; '*: Any way you want to'
    script_end
Script_HowMayWeServe_2::
    script_message $442e ; '*: How may we serve your'
    script_jump_data_bank Script_Priest
    db $ff

Script_GoodDayHowMay::
    script_message $442d ; '*: Good day. How may I'
    script_jump_data_bank Script_Shop_5
    db $ff

Script_WelcomeToTheTraveler::
    script_message $4432 ; '*: Welcome to the traveler's inn.'
    script_jump_data_bank Script_It_3
    db $ff

Script_Kweeeeeh::
    script_message $0433 ; '*: Kweeeeeh!'
    script_command SCRIPT_SCENE_MADCONDOR_CRY
    script_encounter $05 ; encounter words: MadCondor, Slime, Slime
    script_set_flag EVENT_SCENE_MADCONDOR_CRY
    script_end
Script_Kweeeeeh_2::
    script_message $0433 ; '*: Kweeeeeh!'
    script_encounter $05 ; encounter words: MadCondor, Slime, Slime
    script_set_flag EVENT_SCENE_MADCONDOR_CRY
    script_end
Script_I_15::
    script_message $4439 ; '*: I've lived here for 200'
    script_skip_if_no Script_ThisAreaHadBeen
    script_message $843b ; '*: Oh… You won't humor an'
    script_end
Script_ThisAreaHadBeen::
    script_message $843a ; '*: This area had been prosperous,'
    script_end
Script_WantToKnowThe::
    script_message $4447 ; '*: Want to know the most'
    script_skip_if_no Script_WalkLearnToWalk
    script_message $8449 ; '*: I see. You wish to'
    script_end
Script_WalkLearnToWalk::
    script_message $8448 ; '*: Walk. Learn to walk everywhere.'
    script_end
Script_WelcomeHowMayI_4::
    script_message $444b ; '*: Welcome! How may I serve'
    script_jump_data_bank Script_Shop_5
    db $ff

Script_HowMayOurChurch_4::
    script_message $444c ; '*: How may our church help'
    script_jump_data_bank Script_Priest
    db $ff, $00, $51, $44, $e7, $0b, $69, $ff

Script_HeroCheckedTheSmall::
    script_message $045a ; '0 checked the small hole. It'
    script_command SCRIPT_SCENE_SMALL_HOLE
    script_end
Script_YouCanTakeThis::
    script_message $045d ; '*: You can take this treasure,'
    script_set_flag EVENT_YOU_CAN_TAKE_THIS_TREASURE
    script_encounter $06 ; encounter words: Metabble, Slime, Slime
    script_message $045f ; '*: Heh, you're not half bad!'
    script_walk 0, 0, 2
    script_walk 0, 3, 2
    script_hide_object $00
    script_set_flag EVENT_HEH_YOU
    script_command SCRIPT_HIDE_SPRITES
    script_end
Script_I_16::
    script_message $045e ; '*: I'm up for your challenge'
    script_encounter $06 ; encounter words: Metabble, Slime, Slime
    script_message $045f ; '*: Heh, you're not half bad!'
    script_walk 0, 0, 2
    script_walk 0, 3, 2
    script_hide_object $00
    script_set_flag EVENT_HEH_YOU
    script_command SCRIPT_HIDE_SPRITES
    script_end
Script_LetThePowerOf::
    script_message $0460 ; '*: Let the power of justice'
    script_encounter $07 ; encounter words: Skeletor, Slime, Slime
    script_command SCRIPT_SCENE_JUSTICE_2
    script_end
Script_SceneJustice::
    script_command SCRIPT_SCENE_JUSTICE
    script_end
Script_SceneGravestone::
    script_sound $9b
    script_command SCRIPT_SCENE_GRAVESTONE
    script_end
Script_HeroCheckedTheGravestone::
    script_message $4464 ; '0 checked the gravestone. There was'
    script_skip_if_no Script_ADoorOpenedSomewhere
    script_message $849f ; '0 released the grave's button.'
    script_end
Script_ADoorOpenedSomewhere::
    script_sound $66
    script_wait 60
    script_message $8465 ; 'A door opened somewhere…'
    script_command SCRIPT_SET_FLAG_322
    script_set_flag EVENT_SET_FLAG_322
    script_end
Script_YouOvercameTheTraps::
    script_message $0466 ; '*: You overcame the traps I'
    script_set_flag EVENT_YOU_OVERCAME_THE_TRAPS_I
    script_encounter $08 ; encounter words: Niterich, Slime, Slime
    script_message $0468 ; '*: You've beaten me fairly… Take'
    script_command SCRIPT_SCENE_BEATEN_FAIRLY
    script_set_flag EVENT_SCENE_BEATEN_FAIRLY
    script_set_flag EVENT_SCENE_BEATEN_FAIRLY_0C5
    script_set_flag EVENT_SCENE_BEATEN_FAIRLY_0C6
    script_set_flag EVENT_SCENE_BEATEN_FAIRLY_0C7
    script_end
Script_WahahahahHereAgainAre::
    script_message $0467 ; '*: Wahahahah! Here again, are you?'
    script_encounter $08 ; encounter words: Niterich, Slime, Slime
    script_message $0468 ; '*: You've beaten me fairly… Take'
    script_command SCRIPT_SCENE_BEATEN_FAIRLY
    script_set_flag EVENT_SCENE_BEATEN_FAIRLY
    script_set_flag EVENT_SCENE_BEATEN_FAIRLY_0C5
    script_set_flag EVENT_SCENE_BEATEN_FAIRLY_0C6
    script_set_flag EVENT_SCENE_BEATEN_FAIRLY_0C7
    script_end
Script_WhatYouHaveThe::
    script_message $0469 ; '*: What? You have the three'
    script_walk 0, 2, 1
    script_hide_object $00
    script_set_flag EVENT_WHAT_YOU_HAVE_THE_THREE
    script_end
Script_I_17::
    script_message $0471 ; '*: I'm surprised anyone managed to'
    script_command SCRIPT_SCENE_FOUND_ME
    script_face $80, 0
    script_set_flag EVENT_SCENE_FOUND_ME
    script_end
Script_SceneFoundMeBattle::
    script_command SCRIPT_SCENE_FOUND_ME_BATTLE
    script_end
Script_AhSoGoodOf::
    script_message $047a ; '*: Ah, so good of you'
    script_message $447b ; '0 handed over the Heaven Helmet.'
    script_message $c47c ; '0 handed over the Heaven Armor.'
    script_message $847d ; '0 handed over the Heaven Sword.'
    script_message $047e ; '*: Good. You have brought the'
    script_set_flag EVENT_GOOD_YOU_HAVE_BROUGHT_THE
    script_command SCRIPT_SCENE_THREE_ITEMS_BATTLE
    script_set_flag EVENT_SCENE_THREE_ITEMS_BATTLE
    script_end
Script_FwahahahaDon::
    script_message $047f ; '*: Fwahahaha! Don't you ever give'
    script_command SCRIPT_SCENE_THREE_ITEMS_BATTLE
    script_set_flag EVENT_SCENE_THREE_ITEMS_BATTLE
    script_end
Script_KamehaSoItWas::
    script_sound $28
    script_hold_dpad $02, 4
    script_slide_y $80
    script_walk 0, 0, 1
    script_message $0481 ; 'Kameha: So it was you who'
    script_walk 0, 3, 1
    script_wait 20
    script_walk 0, 1, 1
    script_wait 20
    script_walk 0, 1, 1
    script_wait 20
    script_walk 0, 1, 1
    script_wait 20
    script_walk 0, 3, 1
    script_wait 20
    script_face $80, 0
    script_message $0482 ; 'Kameha: If the three items that'
    script_command SCRIPT_SCENE_THREE_ITEMS
    script_end
Script_Sound::
    script_sound $65
    script_walk 1, 0, 4
    script_wait 10
    script_set_flag EVENT_MAP_7A_OBJECT_ADDED
    script_end
Script_ThisWayHereHere::
    script_message $04a7 ; '*: ……This way… …Here… …Here…'
    script_command SCRIPT_SCENE_THIS_WAY
    script_end
Script_IHeardFromLord::
    script_message $4550 ; '*: I heard from Lord Darck,'
    script_skip_if_no Script_HowDareYouCome
    script_message $855d ; '*: You didn't bring the treasures?'
    script_end
Script_HowDareYouCome::
    script_message $855c ; '*: How dare you come without'
    script_end
Script_IHeardFromLord_2::
    script_message $4550 ; '*: I heard from Lord Darck,'
    script_skip_if_no Script_SurprisinglyObedientAreYou
    script_message $855d ; '*: You didn't bring the treasures?'
    script_end
Script_SurprisinglyObedientAreYou::
    script_message $8551 ; '*: Surprisingly obedient, are you? Hand'
    script_message $0552 ; '0 handed over the TidalBell. 0'
    script_face $80, 2
    script_command SCRIPT_TAKE_ITEM
    script_message $0553 ; '*: Take these to Lord Darck'
    script_walk 1, 2, 5
    script_wait 30
    script_hide_object $01
    script_face $80, 0
    script_message $0554 ; '*: My work is done… I'
    script_set_flag EVENT_TAKE_ITEM
    script_encounter $1d ; encounter words: Centasaur, GigaDraco, Garudian
    script_message $0556 ; '*: N… No… How could my'
    script_command SCRIPT_SCENE_DARCK_TAUNT
    script_set_flag EVENT_SCENE_DARCK_TAUNT
    script_end
Script_YouSeemToStill::
    script_message $0555 ; '*: You seem to still not'
    script_encounter $1d ; encounter words: Centasaur, GigaDraco, Garudian
    script_message $0556 ; '*: N… No… How could my'
    script_command SCRIPT_SCENE_DARCK_TAUNT
    script_set_flag EVENT_SCENE_DARCK_TAUNT
    script_end
Script_DarckFawahahahYouChased::
    script_message $0557 ; 'Darck: Fawahahah! You chased your treasures'
    script_set_flag EVENT_DARCK_FAWAHAHAH_YOU_CHASED_YOUR
    script_encounter $0a ; encounter words: Darck, Slime, Slime
    script_message $0559 ; 'Darck: …Wha… What? How could I…'
    script_command SCRIPT_SCENE_DARCK_DEFEATED
    script_end
Script_DarckFwahahahahBravoSplendid::
    script_message $0558 ; 'Darck: Fwahahahah! Bravo! Splendid! You've come'
    script_encounter $0a ; encounter words: Darck, Slime, Slime
    script_message $0559 ; 'Darck: …Wha… What? How could I…'
    script_command SCRIPT_SCENE_DARCK_DEFEATED
    script_end
Script_SceneCyalShine::
    script_face $80, 0
    script_command SCRIPT_SCENE_CYAL_SHINE
    script_walk 0, 2, 5
    script_set_flag EVENT_SCENE_CYAL_SHINE
    script_end
Script_SoCyalTookA::
    script_message $0704 ; '*: So Cyal took a shine'
    script_slide_y $81
    script_message $0705 ; 'Cyal: Yay, you'll be my friend?'
    script_set_flag EVENT_CYAL_YAY_YOU
    script_end
Script_WellWellAHuman::
    script_message $0710 ; '*: Well, well, a human here'
    script_command SCRIPT_SCENE_ROLT_ELDER
    script_message $0711 ; 'Rolt: That was fast, 0. I'
    script_slide_y $82
    script_message $0712 ; 'Cyal: 0, let's play! I want'
    script_walk 2, 0, 2
    script_set_flag EVENT_SCENE_ROLT_ELDER
    script_end
Script_I_18::
    script_message $0713 ; '*: I'm the village's elder. What's'
    script_command SCRIPT_SCENE_ROLT_ELDER
    script_message $0711 ; 'Rolt: That was fast, 0. I'
    script_slide_y $82
    script_message $0712 ; 'Cyal: 0, let's play! I want'
    script_walk 2, 0, 2
    script_set_flag EVENT_SCENE_ROLT_ELDER
    script_end
Script_CyalListenHeroWe::
    script_message $0716 ; 'Cyal: Listen, 0. We should go'
    script_walk_fast 2, 0, 4
    script_set_flag EVENT_CYAL_LISTEN_HERO_WE_SHOULD
    script_end
Script_CyalOhHeroI::
    script_face $80, 0
    script_slide_y $80
    script_message $071d ; 'Cyal: Oh! 0! I'm over here!'
    script_walk_fast 0, 2, 5
    script_wait 30
    script_face $00, 0
    script_message $071e ; '0 counted off…'
    script_wait 30
    script_message $071f ; 'Cyal: Eeek, 0! Help me!'
    script_set_flag EVENT_CYAL_EEEK_HERO_HELP_ME
    script_end
Script_MasterAgDevilAHuman::
    script_slide_y $82
    script_message $0720 ; '*: Master AgDevil, a human, ruff!'
    script_slide_y $83
    script_message $0721 ; '*: What shall we do, ruff?'
    script_walk 1, 0, 1
    script_face $82, 2
    script_face $83, 1
    script_message $0722 ; '*: Human? They taste horrible… You'
    script_walk 1, 2, 1
    script_walk 1, 1, 1
    script_face $81, 2
    script_set_flag EVENT_ROLT_IVE_FOUND_YOU_AT
    script_end
Script_That_3::
    script_message $0724 ; '*: That's what we'll do, kid.'
    script_set_flag EVENT_THAT
    script_encounter $09 ; encounter words: ArrowDog, ArrowDog, Slime
    script_message $0754 ; '*: …Too strong… Arroooh!'
    script_command SCRIPT_SCENE_TOO_STRONG
    script_set_flag EVENT_SCENE_TOO_STRONG
    script_end
Script_You_11::
    script_message $0727 ; '*: You've come back again, ruff?'
    script_encounter $09 ; encounter words: ArrowDog, ArrowDog, Slime
    script_message $0754 ; '*: …Too strong… Arroooh!'
    script_command SCRIPT_SCENE_TOO_STRONG
    script_set_flag EVENT_SCENE_TOO_STRONG
    script_end
Script_RoltWhatCyalWas::
    script_message $0728 ; 'Rolt: What? Cyal was abducted? Who'
    script_walk_fast 1, 0, 7
    script_slide_y $80
    script_message $0729 ; '*: Rolt, wait! …Gone already…'
    script_set_flag EVENT_ROLT_WAIT_GONE_ALREADY
    script_end
Script_TheHumanInThe::
    script_message $4739 ; '*: The human in the forest'
    script_encounter $0b ; encounter words: AgDevil, Slime, Slime
    script_message $073b ; '*: Wh-what? I… Lost to a'
    script_command SCRIPT_KEY_BOSS_BEATEN
    script_message $073c ; 'Rolt: Wow… 0, you're tough. Oh!'
    script_walk_fast 2, 3, 1
    script_walk_fast 2, 2, 1
    script_walk_fast 2, 3, 1
    script_face $82, 2
    script_wait 30
    script_face $81, 1
    script_wait 30
    script_face $81, 3
    script_wait 30
    script_face $81, 1
    script_wait 30
    script_face $81, 3
    script_message $073d ; 'Rolt: Cyal! Are you OK? Cyal!'
    script_wait 30
    script_face $81, 0
    script_message $073e ; 'Cyal: Big brother! I was so'
    script_message $073f ; 'Rolt: You're safe now. 0 did'
    script_face $82, 0
    script_message $0740 ; 'Rolt: 0, I'm sorry we put'
    script_set_flag EVENT_KEY_BOSS_BEATEN
    script_set_flag EVENT_KEY_BOSS_BEATEN_203
    script_command SCRIPT_SCENE_CYAL_ROLT
    script_face $80, 3
    script_message $0741 ; '*: I'm glad that Cyal and'
    script_end
Script_WhatYouAgainRude::
    script_message $073a ; '*: What, you again? Rude, rude,'
    script_encounter $0b ; encounter words: AgDevil, Slime, Slime
    script_message $073b ; '*: Wh-what? I… Lost to a'
    script_command SCRIPT_KEY_BOSS_BEATEN
    script_message $073c ; 'Rolt: Wow… 0, you're tough. Oh!'
    script_walk_fast 2, 3, 1
    script_walk_fast 2, 2, 1
    script_walk_fast 2, 3, 1
    script_face $82, 2
    script_wait 30
    script_face $81, 1
    script_wait 30
    script_face $81, 3
    script_wait 30
    script_face $81, 1
    script_wait 30
    script_face $81, 3
    script_message $073d ; 'Rolt: Cyal! Are you OK? Cyal!'
    script_wait 30
    script_face $81, 0
    script_message $073e ; 'Cyal: Big brother! I was so'
    script_message $073f ; 'Rolt: You're safe now. 0 did'
    script_face $82, 0
    script_message $0740 ; 'Rolt: 0, I'm sorry we put'
    script_set_flag EVENT_KEY_BOSS_BEATEN
    script_set_flag EVENT_KEY_BOSS_BEATEN_203
    script_command SCRIPT_SCENE_CYAL_ROLT
    script_face $80, 3
    script_message $0741 ; '*: I'm glad that Cyal and'
    script_end
Script_RoltI::
    script_message $0734 ; 'Rolt: I've found you at last!'
    script_message $0735 ; '*: Kikiki, what just you? That's'
    script_message $0736 ; 'Rolt: Shut up! Give back Cyal!'
    script_walk_fast 2, 2, 2
    script_command SCRIPT_SCENE_GIVE_BACK_CYAL
    script_set_flag EVENT_SCENE_GIVE_BACK_CYAL
    script_end
Script_WelcomeHowMayI_5::
    script_message $470e ; '*: Welcome! How may I help'
    script_jump_data_bank Script_Shop_5
    db $ff

Script_AreYouMaybeA::
    script_set_flag EVENT_ARE_YOU_MAYBE_A
    script_message $4703 ; '*: Are you maybe a human?'
Script_OhDon::
    script_skip_if_no Script_ReallyWowYou
    script_slide_y $81
    script_message $cc57 ; '*: Oh, don't lie! You don't'
    script_jump Script_OhDon
Script_ReallyWowYou::
    script_slide_y $81
    script_message $8c56 ; '*: Really! Wow! You're the first'
    script_end
Script_HohAhExcuseMy::
    script_slide_y $80
    script_message $4759 ; '*: Hoh? Ah, excuse my incivility.'
    script_skip_if_no Script_KiralHohohGrandGrand
    script_message $875d ; 'Kiral: No? How disappointing. Your efforts'
    script_set_flag EVENT_KIRAL_NO_HOW_DISAPPOINTING_YOUR
    script_end
Script_KiralHohohGrandGrand::
    script_message $875b ; 'Kiral: Hohoh! Grand, grand! Go fetch'
    script_walk 0, 3, 2
    script_face $80, 1
    script_wait 30
    script_slide_y $80
    script_message $075c ; 'Kiral: Oh! Foolish of me, I'
    script_set_flag EVENT_KIRAL_OH_FOOLISH_OF_ME
    script_end
Script_KiralINeedHelp::
    script_message $475e ; 'Kiral: I need help with my'
    script_skip_if_no Script_KiralHohohGrandGrand_2
    script_message $875d ; 'Kiral: No? How disappointing. Your efforts'
    script_end
Script_KiralHohohGrandGrand_2::
    script_message $875b ; 'Kiral: Hohoh! Grand, grand! Go fetch'
    script_walk 0, 3, 2
    script_face $80, 1
    script_wait 30
    script_slide_y $80
    script_message $075c ; 'Kiral: Oh! Foolish of me, I'
    script_set_flag EVENT_KIRAL_OH_FOOLISH_OF_ME
    script_end
Script_HeroPeeredIntoThe_2::
    script_message $0767 ; '0 peered into the barrel. A'
    script_encounter $1f ; encounter words: Shadow, Slime, Slime
    script_set_flag EVENT_HERO_PEERED_INTO_THE_BARREL
    script_end
Script_HeroPeeredIntoThe_3::
    script_message $0767 ; '0 peered into the barrel. A'
    script_encounter $1f ; encounter words: Shadow, Slime, Slime
    script_set_flag EVENT_HERO_PEERED_INTO_THE_BARREL_15E
    script_end
Script_PROFESSORSAYGUARDTREASURE::
    script_message $0769 ; '*: PROFESSOR… SAY GUARD… TREASURE… NEVER…'
    script_message $076a ; 'Roboster is acting strangely. It appears'
    script_end
Script_PROSORAYGGGGUARD::
    script_message $076d ; '*: PRO… SOR… AY… GGGGUARD… TREZZZT…'
    script_message $076e ; 'Its damage appears to have worsened.'
    script_end
Script_PIPIPIGGGGGGAGAGAGA::
    script_message $0770 ; '*: PIPIPI… GGGGGGAGAGAGA…'
    script_message $0771 ; 'Roboster is acting bizarrely. It appears'
    script_end
Script_PIPI::
    script_message $0773 ; '*: PI… PI…'
    script_message $0774 ; 'Roboster is acting as if demented.'
    script_end
Script_KiralAhBackThe::
    script_message $0776 ; 'Kiral: Ah! Back! The treasure? What?'
    script_wait 30
    script_message $0777 ; 'Kiral: Please… Go stop him. He'
    script_set_flag EVENT_KIRAL_PLEASE_GO_STOP_HIM
    script_end
Script_HeroPeeredIntoThe_4::
    script_message $076b ; '0 peered into the barrel. There'
    script_command SCRIPT_SCENE_BARREL
    script_end
Script_KiralAhBackIs::
    script_message $077d ; 'Kiral: Ah! Back! Is… Rob-N… Did'
    script_message $077e ; '0 handed over the blue stone.'
    script_message $077f ; 'Kiral: This stone, the WizStone, it'
    script_walk_fast 0, 1, 3
    script_command SCRIPT_SCENE_WIZSTONE
    script_set_flag EVENT_SCENE_WIZSTONE
    script_set_flag EVENT_SCENE_WIZSTONE_204
    script_end
Script_Sigh::
    script_message $0795 ; '*: Sigh…'
    script_message $0796 ; 'The old man's sigh sounded sad…'
    script_end
Script_Sigh_2::
    script_message $0797 ; '*: Sigh…'
    script_message $0798 ; 'The old woman's sigh was desolate…'
    script_end
Script_HelloWhatMayI_2::
    script_message $479d ; '*: Hello! What may I do'
    script_jump_data_bank Script_Shop_5
    db $ff

Script_WelcomeToOurTraveler::
    script_message $479e ; '*: Welcome to our traveler's inn.'
    script_jump_data_bank Script_It_3
    db $ff

Script_ExcuseMeAreYou::
    script_slide_y $81
    script_message $47a0 ; '*: Excuse me, are you a'
    script_skip_if_no Script_ThankYouIKnew
    script_message $87a2 ; '*: I can't count on your'
    script_set_flag EVENT_I_CAN
    script_end
Script_ThankYouIKnew::
    script_message $87a1 ; '*: Thank you! I knew you'
    script_walk 1, 3, 2
    script_walk 1, 0, 6
    script_set_flag EVENT_THANK_YOU_I_KNEW_YOU
    script_end
Script_HaveYouChangedYour::
    script_message $47a3 ; '*: Have you changed your mind?'
    script_skip_if_no Script_ThankYouIKnew_2
    script_message $87a2 ; '*: I can't count on your'
    script_end
Script_ThankYouIKnew_2::
    script_message $87a1 ; '*: Thank you! I knew you'
    script_walk 1, 3, 2
    script_walk 1, 0, 6
    script_set_flag EVENT_THANK_YOU_I_KNEW_YOU
    script_end
Script_LatelyTheTownOf::
    script_message $47ab ; '*: Lately, the town of Miagen'
    script_skip_if_no Script_It_2
    script_message $87ad ; '*: You didn't know? Well, listen'
    script_end
Script_It_2::
    script_message $87ac ; '*: It's rumored that monsters raid'
    script_end
Script_ThisPendantIsYours::
    script_message $07b6 ; '*: This pendant is yours for'
    script_command SCRIPT_SCENE_PENDANT_SELLER
    script_set_flag EVENT_SCENE_PENDANT_SELLER
    script_end
Script_You_12::
    script_set_flag EVENT_YOU_1BA
    script_message $07b9 ; '*: You're going to regret seeing'
    script_encounter $11 ; encounter words: Pixy, Pixy, Slime
    script_message $07bc ; '*: Please! Mercy! Spare us! Take'
    script_command SCRIPT_SCENE_MERCY
    script_set_flag EVENT_SCENE_MERCY
    script_end
Script_We::
    script_message $07bb ; '*: We'll smash you as often'
    script_encounter $11 ; encounter words: Pixy, Pixy, Slime
    script_message $07bc ; '*: Please! Mercy! Spare us! Take'
    script_command SCRIPT_SCENE_MERCY
    script_set_flag EVENT_SCENE_MERCY
    script_end
Script_HeroOpenedTheTreasure::
    script_message $07bd ; '0 opened the treasure chest. 0'
    script_hide_object $00
    script_hide_object $02
    script_set_flag EVENT_HERO_OPENED_THE_TREASURE_CHEST
    script_end
Script_For47HeroHero::
    script_message $07c3 ; '*: For 47,000G this earring… What?'
    script_slide_y $81
    script_message $07c4 ; '*: You defeated the monsters? You're'
    script_set_flag EVENT_YOU_DEFEATED_THE_MONSTERS_YOU
    script_end
Script_HeroShowedThePretty::
    script_message $07ca ; '0 showed the Pretty Ring.'
    script_slide_y $80
    script_message $07cb ; '*: Ah… That ring… Is… Is'
    script_message $07cc ; '0 handed over the Pretty Ring.'
    script_message $07cd ; '*: Thank you for getting the'
    script_set_flag EVENT_THANK_YOU_FOR_GETTING_THE
    script_end
Script_ThankYouForRecovering::
    script_message $07cf ; '*: Thank you for recovering our'
    script_message $07d1 ; '0 received a SageRock. But there'
    script_end
Script_ThankYouForRecovering_2::
    script_message $07cf ; '*: Thank you for recovering our'
    script_message $07d0 ; '0 received a SageRock.'
    script_set_flag EVENT_HERO_RECEIVED_A_SAGE_ROCK
    script_end
Script_WhatWhereIGet::
    script_message $07da ; '*: What? Where I get my'
    script_command SCRIPT_SCENE_PENDANT_SELLER
    script_walk_fast 1, 0, 2
    script_walk_fast 1, 1, 1
    script_walk_fast 1, 0, 4
    script_set_flag EVENT_SCENE_PENDANT_SELLER_1C0
    script_end
Script_MilayouIThoughtThis::
    script_message $07dc ; 'Milayou: I thought this forest looked'
    script_command SCRIPT_SCENE_MILAYOU_FOREST
    script_set_flag EVENT_SCENE_MILAYOU_FOREST
    script_end
Script_WhatIsItYou::
    script_set_flag EVENT_WHAT_IS_IT_YOU
    script_message $0cde ; '*: What is it, you little'
    script_encounter $12 ; encounter words: Copycat, StoneMan, WhipBird
    script_message $0ce0 ; '*: But… No! I lost to'
    script_command SCRIPT_KEY_BOSS_BEATEN_2
    script_walk 1, 2, 2
    script_face $00, 0
    script_message $0ce1 ; 'Milayou: You are really special. I'
    script_walk 1, 0, 2
    script_hide_object $01
    script_set_flag EVENT_KEY_BOSS_BEATEN_2
    script_set_flag EVENT_KEY_BOSS_BEATEN_2_205
    script_end
Script_WhatIsItYou_2::
    script_message $0cdf ; '*: What is it, you little'
    script_encounter $12 ; encounter words: Copycat, StoneMan, WhipBird
    script_message $0ce0 ; '*: But… No! I lost to'
    script_command SCRIPT_KEY_BOSS_BEATEN_2
    script_walk 1, 2, 2
    script_face $00, 0
    script_message $0ce1 ; 'Milayou: You are really special. I'
    script_walk 1, 0, 2
    script_hide_object $01
    script_set_flag EVENT_KEY_BOSS_BEATEN_2
    script_set_flag EVENT_KEY_BOSS_BEATEN_2_205
    script_end
Script_MilayouIAskedFor::
    script_message $0cef ; 'Milayou: I asked for your support'
    script_slide_y $00
    script_message $0cf0 ; 'Milayou: How do I know about'
    script_set_flag EVENT_MILAYOU_HOW_DO_I_KNOW
    script_end
Script_MilayouIKnewYou::
    script_set_flag EVENT_MILAYOU_IKNEW_YOU
    script_message $4cf5 ; 'Milayou: I knew you come back!'
    script_skip_if_no Script_MilayouGreatNoHolding
    script_message $8cf7 ; 'Milayou: Oh… I'm disappointed… Come again'
    script_end
Script_MilayouGreatNoHolding::
    script_message $8cf6 ; 'Milayou: Great! No holding back!'
    script_encounter $13 ; encounter words: MetalKing, RainHawk, Coatol
    script_message $0cf9 ; 'Milayou: I lost… But, good battle!'
    script_walk 1, 3, 2
    script_walk 1, 0, 6
    script_set_flag EVENT_MILAYOU_I_LOST_BUT_GOOD
    script_end
Script_MilayouWantToSpar::
    script_message $4cf8 ; 'Milayou: Want to spar with me?'
    script_skip_if_no Script_MilayouGreatNoHolding_2
    script_message $8cf7 ; 'Milayou: Oh… I'm disappointed… Come again'
    script_end
Script_MilayouGreatNoHolding_2::
    script_message $8cf6 ; 'Milayou: Great! No holding back!'
    script_encounter $13 ; encounter words: MetalKing, RainHawk, Coatol
    script_message $0cf9 ; 'Milayou: I lost… But, good battle!'
    script_walk 1, 3, 2
    script_walk 1, 0, 6
    script_set_flag EVENT_MILAYOU_I_LOST_BUT_GOOD
    script_end
Script_HeroCheckedTheTreasure_3::
    script_message $0c48 ; '0 checked the treasure chest. The'
    script_encounter $32 ; encounter words: Mimic, Slime, Slime
    script_command SCRIPT_SET_FLAG_REDRAW
    script_end
Script_SceneChestBattle::
    script_command SCRIPT_SCENE_CHEST_BATTLE
    script_end
Script_HeroCheckedTheTreasure_4::
    script_message $0c49 ; '0 checked the treasure chest. It'
    script_command SCRIPT_SCENE_YOU_DID_IT
    script_end
Script_WarubouWaHeyYou_2::
    script_message $4123 ; 'Warubou: Wa-hey! You did it, 0!'
    script_jump_data_bank Script_Shop_5
    db $ff

Script_WarubouWaHeyYou_3::
    script_message $4124 ; 'Warubou: Wa-hey! You did it, 0!'
    script_jump_data_bank Script_It_3
    db $ff

Script_WarubouWaHeyThat::
    script_message $4128 ; 'Warubou: Wa-hey! That's it! GreatLog is'
    script_jump_data_bank Script_It_3
    db $ff

Script_WarubouWaHeySo::
    script_message $4127 ; 'Warubou: Wa-hey! So, this is it?'
    script_jump_data_bank Script_Priest
    db $ff

; Script command type E0 (SCRIPT_INN), entry 223 of ScriptCommandHandlers, which
; ExecuteScriptCommand jumps through with wScriptCommandType - 1: far-calls InnMenu in bank $1C, the
; inn, once per frame while this command is current, and returns. (C1, E-0376)
; runs one frame of script command type E0 (entry 223 of ScriptCommandHandlers) (E-0038)
ScriptCommandE0::
    farcall InnMenu
    ret

SECTION "Bank 10 ScriptCommandE1", ROMX

; Script command type E1 (SCRIPT_INN_CLOSE), entry 224 of ScriptCommandHandlers, which
; ExecuteScriptCommand jumps through with wScriptCommandType - 1: far-calls CloseInnMenu in bank
; $1C, which ends the inn session and clears wMessageMode, once per frame while this command is
; current, and returns. (C1, E-0376)
; runs one frame of script command type E1 (entry 224 of ScriptCommandHandlers) (E-0038)
ScriptCommandE1::
    farcall CloseInnMenu
    ret

SECTION "Bank 10 ScriptCommandE2", ROMX

; Script command type E2 (SCRIPT_SHOP), entry 225 of ScriptCommandHandlers, which
; ExecuteScriptCommand jumps through with wScriptCommandType - 1: far-calls ShopMenu in bank $1C,
; the shop, once per frame while this command is current, and returns. (C1, E-0376)
; runs one frame of script command type E2 (entry 225 of ScriptCommandHandlers) (E-0038)
ScriptCommandE2::
    farcall ShopMenu
    ret

SECTION "Bank 10 ScriptCommandE3", ROMX

; Script command type E3 (SCRIPT_SHOP_CLOSE), entry 226 of ScriptCommandHandlers, which
; ExecuteScriptCommand jumps through with wScriptCommandType - 1: far-calls CloseShopMenu in bank
; $1C, which ends the shop session and clears wMessageMode, once per frame while this command is
; current, and returns. (C1, E-0376)
; runs one frame of script command type E3 (entry 226 of ScriptCommandHandlers) (E-0038)
ScriptCommandE3::
    farcall CloseShopMenu
    ret

SECTION "Bank 10 ScriptCommandE5", ROMX

; Script command type E5 (SCRIPT_VAULT), entry 228 of ScriptCommandHandlers, which
; ExecuteScriptCommand jumps through with wScriptCommandType - 1: far-calls VaultMenu in bank $1C,
; the item Vault, once per frame while this command is current, and returns. (C1, E-0376)
; runs one frame of script command type E5 (entry 228 of ScriptCommandHandlers) (E-0038)
ScriptCommandE5::
    farcall VaultMenu
    ret

SECTION "Bank 10 ScriptCommandE6", ROMX

; Script command type E6 (SCRIPT_VAULT_CLOSE), entry 229 of ScriptCommandHandlers, which
; ExecuteScriptCommand jumps through with wScriptCommandType - 1: far-calls CloseVaultMenu in bank
; $1C, which ends the Vault session (it runs the code of CloseShopMenu), once per frame while this
; command is current, and returns. (C1, E-0376)
; runs one frame of script command type E6 (entry 229 of ScriptCommandHandlers) (E-0038)
ScriptCommandE6::
    farcall CloseVaultMenu
    ret

SECTION "Bank 10 ScriptCommandE8", ROMX

; Script command type E8 (SCRIPT_SWAP_MONSTERS), entry 231 of ScriptCommandHandlers, which
; ExecuteScriptCommand jumps through with wScriptCommandType - 1: far-calls SwapMonstersMenu in bank
; $1E, the swap of party and farm monsters, once per frame while this command is current, and
; returns. (C1, E-0376)
; runs one frame of script command type E8 (entry 231 of ScriptCommandHandlers) (E-0038)
ScriptCommandE8::
    farcall SwapMonstersMenu
    ret

SECTION "Bank 10 ScriptCommandE9", ROMX

; Script command type E9 (SCRIPT_MENU_CLOSE), entry 232 of ScriptCommandHandlers, which
; ExecuteScriptCommand jumps through with wScriptCommandType - 1: far-calls CloseMenuE9 in bank $1E,
; which ends a menu session (it runs the code of CloseBreedMenu), once per frame while this command
; is current, and returns. (C1, E-0376)
; runs one frame of script command type E9 (entry 232 of ScriptCommandHandlers) (E-0038)
ScriptCommandE9::
    farcall CloseMenuE9
    ret

SECTION "Bank 10 ScriptCommandEB", ROMX

; Script command type EB (SCRIPT_HIBERNATE), entry 234 of ScriptCommandHandlers, which
; ExecuteScriptCommand jumps through with wScriptCommandType - 1: far-calls HibernateMenu in bank
; $14, monster hibernation, once per frame while this command is current, and returns. (C1, E-0376)
; runs one frame of script command type EB (entry 234 of ScriptCommandHandlers) (E-0038)
ScriptCommandEB::
    farcall HibernateMenu
    ret

SECTION "Bank 10 ScriptCommandEC", ROMX

; Script command type EC (SCRIPT_HIBERNATE_CLOSE), entry 235 of ScriptCommandHandlers, which
; ExecuteScriptCommand jumps through with wScriptCommandType - 1: far-calls CloseHibernateMenu in
; bank $14, which ends the hibernation session and clears wMessageMode, once per frame while this
; command is current, and returns. (C1, E-0376)
; runs one frame of script command type EC (entry 235 of ScriptCommandHandlers) (E-0038)
ScriptCommandEC::
    farcall CloseHibernateMenu
    ret

SECTION "Bank 10 ScriptCommandED", ROMX

; Script command type ED (SCRIPT_BREED), entry 236 of ScriptCommandHandlers, which
; ExecuteScriptCommand jumps through with wScriptCommandType - 1: far-calls BreedMenu in bank $15,
; breeding, once per frame while this command is current, and returns. (C1, E-0376)
; runs one frame of script command type ED (entry 236 of ScriptCommandHandlers) (E-0038)
ScriptCommandED::
    farcall BreedMenu
    ret

SECTION "Bank 10 ScriptCommandEE", ROMX

; Script command type EE (SCRIPT_BREED_CLOSE), entry 237 of ScriptCommandHandlers, which
; ExecuteScriptCommand jumps through with wScriptCommandType - 1: far-calls CloseBreedMenu in bank
; $15, which ends the breeding session and clears wMessageMode, once per frame while this command is
; current, and returns. (C1, E-0376)
; runs one frame of script command type EE (entry 237 of ScriptCommandHandlers) (E-0038)
ScriptCommandEE::
    farcall CloseBreedMenu
    ret

SECTION "Bank 10 ScriptCommandEF", ROMX

; Script command type EF (SCRIPT_EGG_SERVICE), entry 238 of ScriptCommandHandlers, which
; ExecuteScriptCommand jumps through with wScriptCommandType - 1: far-calls EggServiceMenu in bank
; $0D, egg appraisal and blessing, once per frame while this command is current, and returns. (C1,
; E-0376)
; runs one frame of script command type EF (entry 238 of ScriptCommandHandlers) (E-0038)
ScriptCommandEF::
    farcall EggServiceMenu
    ret

SECTION "Bank 10 ScriptCommandF0", ROMX

; Script command type F0 (SCRIPT_RENAME), entry 239 of ScriptCommandHandlers, which
; ExecuteScriptCommand jumps through with wScriptCommandType - 1: far-calls RenameMenu in bank $0D,
; the renaming of a monster, once per frame while this command is current, and returns. (C1, E-0376)
; runs one frame of script command type F0 (entry 239 of ScriptCommandHandlers) (E-0038)
ScriptCommandF0::
    farcall RenameMenu
    ret

SECTION "Bank 10 ScriptCommandF1", ROMX

; Script command type F1 (SCRIPT_RENAME_CLOSE), entry 240 of ScriptCommandHandlers, which
; ExecuteScriptCommand jumps through with wScriptCommandType - 1: far-calls CloseRenameMenu in bank
; $0D, which ends the renaming session (it runs the code of CloseBreedMenu), once per frame while
; this command is current, and returns. (C1, E-0376)
; runs one frame of script command type F1 (entry 240 of ScriptCommandHandlers) (E-0038)
ScriptCommandF1::
    farcall CloseRenameMenu
    ret

SECTION "Bank 10 ScriptCommandF2", ROMX

; Script command type F2 (SCRIPT_KEY_APPRAISAL), entry 241 of ScriptCommandHandlers, which
; ExecuteScriptCommand jumps through with wScriptCommandType - 1: far-calls KeyAppraisalMenu in bank
; $0D, Magic Key appraisal, once per frame while this command is current, and returns. (C1, E-0376)
; runs one frame of script command type F2 (entry 241 of ScriptCommandHandlers) (E-0038)
ScriptCommandF2::
    farcall KeyAppraisalMenu
    ret

SECTION "Bank 10 ScriptCommandF3", ROMX

; Script command type F3 (SCRIPT_MEDAL_PRIZES), entry 242 of ScriptCommandHandlers, which
; ExecuteScriptCommand jumps through with wScriptCommandType - 1: far-calls MedalPrizeMenu in bank
; $0D, the TinyMedal prize exchange, once per frame while this command is current, and returns. (C1,
; E-0376)
; runs one frame of script command type F3 (entry 242 of ScriptCommandHandlers) (E-0038)
ScriptCommandF3::
    farcall MedalPrizeMenu
    ret

SECTION "Bank 10 ScriptCommandF4", ROMX

; Script command type F4 (SCRIPT_NPC_BREED), entry 243 of ScriptCommandHandlers, which
; ExecuteScriptCommand jumps through with wScriptCommandType - 1: far-calls NpcBreedMenu in bank
; $0D, breeding with the monster of a townsperson picked by wScreenTableIndex, once per frame while
; this command is current, and returns. (C1, E-0376)
; runs one frame of script command type F4 (entry 243 of ScriptCommandHandlers) (E-0038)
ScriptCommandF4::
    farcall NpcBreedMenu
    ret

SECTION "Bank 10 CallScriptCommandE9Far", ROMX

; Far-calls ScriptCommandE9_RunFar in bank $0D, which far-calls CloseMenuE9 in bank $1E (the
; SCRIPT_MENU_CLOSE handler), and returns. Nothing in src/ refers to it: it sits where a type F5
; handler would be, between ScriptCommandF4 and ScriptCommandF6, but entry 244 (type F5) of
; ScriptCommandHandlers points to ScriptCommand01. (C1, E-0376)
; far-calls ScriptCommandE9_RunFar (E-0126)
CallScriptCommandE9Far:: ; configured code entry (E-0395 (traced before by a guess alone; listed so new entries cannot drop it)); C0
    farcall ScriptCommandE9_RunFar
    ret

SECTION "Bank 10 ScriptCommandF6", ROMX

; Script command type F6 (SCRIPT_LIBRARY), entry 245 of ScriptCommandHandlers, which
; ExecuteScriptCommand jumps through with wScriptCommandType - 1: far-calls LibraryMenu in bank $0C,
; the monster library, once per frame while this command is current, and returns. (C1, E-0376)
; runs one frame of script command type F6 (entry 245 of ScriptCommandHandlers) (E-0038)
ScriptCommandF6::
    farcall LibraryMenu
    ret

SECTION "Bank 10 ScriptCommandF7", ROMX

; Script command type F7 (SCRIPT_ARENA), entry 246 of ScriptCommandHandlers, which
; ExecuteScriptCommand jumps through with wScriptCommandType - 1: far-calls ArenaMenu in bank $0C,
; the arena, once per frame while this command is current, and returns. (C1, E-0376)
; runs one frame of script command type F7 (entry 246 of ScriptCommandHandlers) (E-0038)
ScriptCommandF7::
    farcall ArenaMenu
    ret

SECTION "Bank 10 ScriptCommandF8", ROMX

; Script command type F8 (SCRIPT_PRIEST), entry 247 of ScriptCommandHandlers, which
; ExecuteScriptCommand jumps through with wScriptCommandType - 1: far-calls PriestMenu in bank $24,
; the priest, once per frame while this command is current, and returns. (C1, E-0376)
; runs one frame of script command type F8 (entry 247 of ScriptCommandHandlers) (E-0038)
ScriptCommandF8::
    farcall PriestMenu
    ret

SECTION "Bank 10 Script_Shop", ROMX

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_Shop::
    script_command SCRIPT_SHOP
    script_command SCRIPT_SHOP
Script_Shop_2::
    script_command SCRIPT_SHOP
    script_choice_jump Script_WhatWouldYouLike, Script_ToWhatWouldYouLike_2, Script_ThankYouPleaseCome, Script_YouHaveNoMore_4, Script_YouHaveNoItems
Script_YouHaveNoMore_4::
    script_message $c007 ; '*: You have no more room'
    script_message $c008 ; '*: Is there anything else?'
    script_jump Script_Shop_2
Script_YouHaveNoItems::
    script_message $c00f ; '*: You have no items to'
    script_message $c008 ; '*: Is there anything else?'
    script_jump Script_Shop_2
Script_ThankYouPleaseCome::
    script_command SCRIPT_SHOP_CLOSE
    script_message $8012 ; '*: Thank you! Please come again.'
    script_command SCRIPT_SHOP_CLOSE
    script_end
Script_ToWhatWouldYouLike_2::
    script_jump Script_WhatWouldYouLike_2
Script_WhatWouldYouLike::
    script_message $c006 ; '*: What would you like to'
    script_command SCRIPT_SHOP
    script_choice_jump Script_HowManyWouldYou, Script_IsThereAnythingElse_5, Script_YouCan_4
Script_YouCan_4::
    script_message $c013 ; '*: You can't carry any more'
Script_IsThereAnythingElse_5::
    script_command SCRIPT_SHOP
    script_message $c008 ; '*: Is there anything else?'
    script_jump Script_Shop_2
Script_HowManyWouldYou::
    script_message $c009 ; '*: How many would you like'
    script_command SCRIPT_SHOP
    script_choice_jump Script_ThatComesToHero, Script_ToWhatWouldYouLike
Script_ToWhatWouldYouLike::
    script_jump Script_WhatWouldYouLike
Script_ThatComesToHero::
    script_command SCRIPT_SHOP
    script_message $c014 ; '*: That comes to 0G. OK?'
    script_command SCRIPT_SHOP
    script_choice_jump Script_OhYou_15, Script_YouCan_5, Script_ThankYou, Script_ToHowManyWouldYou
Script_ToHowManyWouldYou::
    script_jump Script_HowManyWouldYou
Script_OhYou_15::
    script_message $c00c ; '*: Oh? You're short some gold.'
    script_command SCRIPT_SHOP
    script_jump Script_WhatWouldYouLike
Script_YouCan_5::
    script_message $c00d ; '*: You can't carry any more'
    script_command SCRIPT_SHOP
    script_jump Script_WhatWouldYouLike
Script_ThankYou::
    script_message $c00b ; '*: Thank you!'
    script_command SCRIPT_SHOP
    script_choice_jump Script_YouCan_6, Script_Shop_3
Script_Shop_3::
    script_command SCRIPT_SHOP
    script_jump Script_WhatWouldYouLike
Script_YouCan_6::
    script_message $c013 ; '*: You can't carry any more'
    script_message $c008 ; '*: Is there anything else?'
    script_command SCRIPT_SHOP
    script_jump Script_Shop_2
Script_WhatWouldYouLike_2::
    script_message $c00e ; '*: What would you like to'
    script_command SCRIPT_SHOP
    script_choice_jump Script_HowManyWillYou, Script_SorryButICan, Script_IsThereAnythingElse_6
Script_SorryButICan::
    script_message $c010 ; '*: Sorry, but I can't price'
    script_jump Script_WhatWouldYouLike_2
Script_IsThereAnythingElse_6::
    script_command SCRIPT_SHOP
    script_message $c008 ; '*: Is there anything else?'
    script_jump Script_Shop_2
Script_HowManyWillYou::
    script_message $c011 ; '*: How many will you sell?'
    script_command SCRIPT_SHOP
    script_choice_jump Script_ThatComesToHero_2, Script_ToWhatWouldYouLike_2_2
Script_ToWhatWouldYouLike_2_2::
    script_jump Script_WhatWouldYouLike_2
Script_ThatComesToHero_2::
    script_message $c014 ; '*: That comes to 0G. OK?'
    script_command SCRIPT_SHOP
    script_choice_jump Script_ThankYou_2, Script_ToHowManyWillYou
Script_ToHowManyWillYou::
    script_jump Script_HowManyWillYou
Script_ThankYou_2::
    script_message $c00b ; '*: Thank you!'
    script_command SCRIPT_SHOP
    script_choice_jump Script_YouHaveNoItems_2, Script_Shop_4
Script_Shop_4::
    script_command SCRIPT_SHOP
    script_jump Script_WhatWouldYouLike_2
Script_YouHaveNoItems_2::
    script_message $c00f ; '*: You have no items to'
    script_message $c008 ; '*: Is there anything else?'
    script_command SCRIPT_SHOP
    script_jump Script_Shop_2
Script_Shop_5::
    script_command SCRIPT_SHOP
    script_command SCRIPT_SHOP
Script_Shop_6::
    script_command SCRIPT_SHOP
    script_choice_jump Script_WhatWouldYouLike_3, Script_ToWhatWouldYouLike_4, Script_ThankYouPleaseCome_2, Script_YouCan_7, Script_YouHaveNothingTo
Script_YouCan_7::
    script_message $c033 ; '*: You can't carry any more'
    script_message $c034 ; '*: Is there anything else?'
    script_jump Script_Shop_6
Script_YouHaveNothingTo::
    script_message $c03b ; '*: You have nothing to sell'
    script_message $c034 ; '*: Is there anything else?'
    script_jump Script_Shop_6
Script_ThankYouPleaseCome_2::
    script_command SCRIPT_SHOP_CLOSE
    script_message $803e ; '*: Thank you! Please come again!'
    script_command SCRIPT_SHOP_CLOSE
    script_end
Script_ToWhatWouldYouLike_4::
    script_jump Script_WhatWouldYouLike_4
Script_WhatWouldYouLike_3::
    script_message $c032 ; '*: What would you like to'
    script_command SCRIPT_SHOP
    script_choice_jump Script_HowManyWouldYou_2, Script_IsThereAnythingElse_7, Script_YouCan_8
Script_YouCan_8::
    script_message $c03f ; '*: You can't carry any more'
Script_IsThereAnythingElse_7::
    script_command SCRIPT_SHOP
    script_message $c034 ; '*: Is there anything else?'
    script_jump Script_Shop_6
Script_HowManyWouldYou_2::
    script_message $c035 ; '*: How many would you like?'
    script_command SCRIPT_SHOP
    script_choice_jump Script_ThatWillBeHero, Script_ToWhatWouldYouLike_3
Script_ToWhatWouldYouLike_3::
    script_jump Script_WhatWouldYouLike_3
Script_ThatWillBeHero::
    script_command SCRIPT_SHOP
    script_message $c040 ; '*: That will be 0G. OK?'
    script_command SCRIPT_SHOP
    script_choice_jump Script_YouDon_4, Script_YouCan_9, Script_ThankYou_3, Script_ToHowManyWouldYou_2
Script_ToHowManyWouldYou_2::
    script_jump Script_HowManyWouldYou_2
Script_YouDon_4::
    script_message $c038 ; '*: You don't have enough gold.'
    script_command SCRIPT_SHOP
    script_jump Script_WhatWouldYouLike_3
Script_YouCan_9::
    script_message $c039 ; '*: You can't hold that many'
    script_command SCRIPT_SHOP
    script_jump Script_WhatWouldYouLike_3
Script_ThankYou_3::
    script_message $c037 ; '*: Thank you!'
    script_command SCRIPT_SHOP
    script_choice_jump Script_YouCan_10, Script_Shop_7
Script_Shop_7::
    script_command SCRIPT_SHOP
    script_jump Script_WhatWouldYouLike_3
Script_YouCan_10::
    script_message $c03f ; '*: You can't carry any more'
    script_message $c034 ; '*: Is there anything else?'
    script_command SCRIPT_SHOP
    script_jump Script_Shop_6
Script_WhatWouldYouLike_4::
    script_message $c03a ; '*: What would you like to'
    script_command SCRIPT_SHOP
    script_choice_jump Script_HowManyWillYou_2, Script_ICan, Script_IsThereAnythingElse_8
Script_ICan::
    script_message $c03c ; '*: I can't put a price'
    script_jump Script_WhatWouldYouLike_4
Script_IsThereAnythingElse_8::
    script_command SCRIPT_SHOP
    script_message $c034 ; '*: Is there anything else?'
    script_jump Script_Shop_6
Script_HowManyWillYou_2::
    script_message $c03d ; '*: How many will you sell?'
    script_command SCRIPT_SHOP
    script_choice_jump Script_ThatWillBeHero_2, Script_ToWhatWouldYouLike_4_2
Script_ToWhatWouldYouLike_4_2::
    script_jump Script_WhatWouldYouLike_4
Script_ThatWillBeHero_2::
    script_message $c040 ; '*: That will be 0G. OK?'
    script_command SCRIPT_SHOP
    script_choice_jump Script_ThankYou_4, Script_ToHowManyWillYou_2
Script_ToHowManyWillYou_2::
    script_jump Script_HowManyWillYou_2
Script_ThankYou_4::
    script_message $c037 ; '*: Thank you!'
    script_command SCRIPT_SHOP
    script_choice_jump Script_YouHaveNothingTo_2, Script_Shop_8
Script_Shop_8::
    script_command SCRIPT_SHOP
    script_jump Script_WhatWouldYouLike_4
Script_YouHaveNothingTo_2::
    script_message $c03b ; '*: You have nothing to sell'
    script_message $c034 ; '*: Is there anything else?'
    script_command SCRIPT_SHOP
    script_jump Script_Shop_6
Script_Vault::
    script_command SCRIPT_VAULT
    script_command SCRIPT_VAULT
Script_Vault_2::
    script_command SCRIPT_VAULT
    script_choice_jump Script_ToWhatShouldWeStore, Script_ToWhatWillYouBe, Script_ToComeAgainAnytime
Script_ToWhatShouldWeStore::
    script_jump Script_WhatShouldWeStore
Script_ToWhatWillYouBe::
    script_jump Script_WhatWillYouBe
Script_ToComeAgainAnytime::
    script_jump Script_ComeAgainAnytime
Script_WhatShouldWeStore::
    script_command SCRIPT_VAULT
    script_message $c016 ; '*: What should we store for'
Script_Vault_3::
    script_command SCRIPT_VAULT
    script_choice_jump Script_YouDon_5, Script_SorryButYouFilled, Script_YouDon_6, Script_SorryButYouFilled_2, Script_ToWhatItemShouldI, Script_ToVault_5, Script_IsThereAnythingElse_10
Script_YouDon_5::
    script_message $c017 ; '*: You don't have any items.'
    script_command SCRIPT_VAULT
    script_jump Script_IsThereAnythingElse_9
Script_SorryButYouFilled::
    script_message $c019 ; '*: Sorry, but you filled the'
    script_command SCRIPT_VAULT
Script_IsThereAnythingElse_9::
    script_message $c018 ; '*: Is there anything else?'
    script_jump Script_Vault_4
Script_YouDon_6::
    script_message $c01e ; '*: You don't have enough to'
    script_command SCRIPT_VAULT
    script_jump Script_IsThereAnythingElse_9
Script_SorryButYouFilled_2::
    script_message $c019 ; '*: Sorry, but you filled the'
    script_command SCRIPT_VAULT
    script_jump Script_IsThereAnythingElse_9
Script_ToWhatItemShouldI::
    script_jump Script_WhatItemShouldI
Script_ToVault_5::
    script_jump Script_Vault_5
Script_IsThereAnythingElse_10::
    script_message $c018 ; '*: Is there anything else?'
    script_command SCRIPT_VAULT
Script_Vault_4::
    script_command SCRIPT_VAULT
    script_jump Script_Vault_2
Script_WhatItemShouldI::
    script_message $c01a ; '*: What item should I store'
    script_command SCRIPT_VAULT
    script_choice_jump Script_HowManyShouldI, Script_SorryButICan_2, Script_WhatShouldWeStore_2, Script_ICan_2
Script_WhatShouldWeStore_2::
    script_command SCRIPT_VAULT
    script_message $c016 ; '*: What should we store for'
    script_jump Script_Vault_3
Script_SorryButICan_2::
    script_message $c02c ; '*: Sorry, but I can't take'
    script_jump Script_WhatItemShouldI
Script_ICan_2::
    script_message $c030 ; '*: I can't take any more'
    script_jump Script_WhatItemShouldI
Script_HowManyShouldI::
    script_message $c01b ; '*: How many should I store?'
    script_command SCRIPT_VAULT
    script_choice_jump Script_OKI, Script_ICan_3, Script_ToWhatItemShouldI_2
Script_ToWhatItemShouldI_2::
    script_jump Script_WhatItemShouldI
Script_ICan_3::
    script_message $c02f ; '*: I can't store that many.'
    script_jump Script_HowManyShouldI
Script_OKI::
    script_message $c01c ; '*: OK, I'll put that away'
    script_command SCRIPT_VAULT
    script_choice_jump Script_YouDon_7, Script_SorryButYouFilled_3, Script_ToWhatItemShouldI_3
Script_YouDon_7::
    script_message $c017 ; '*: You don't have any items.'
Script_IsThereAnythingElse_11::
    script_message $c018 ; '*: Is there anything else?'
    script_command SCRIPT_VAULT
    script_command SCRIPT_VAULT
    script_jump Script_Vault_2
Script_SorryButYouFilled_3::
    script_message $c019 ; '*: Sorry, but you filled the'
    script_jump Script_IsThereAnythingElse_11
Script_ToWhatItemShouldI_3::
    script_jump Script_WhatItemShouldI
Script_Vault_5::
    script_command SCRIPT_VAULT
Script_HowMuchDoYou::
    script_message $c01f ; '*: How much do you want'
    script_command SCRIPT_VAULT
    script_choice_jump Script_OKI_2, Script_ICan_4, Script_WhatShouldWeStore_3
Script_ICan_4::
    script_message $c01d ; '*: I can't store that much.'
    script_jump Script_HowMuchDoYou
Script_WhatShouldWeStore_3::
    script_message $c016 ; '*: What should we store for'
    script_jump Script_Vault_3
Script_OKI_2::
    script_command SCRIPT_VAULT
    script_message $c01c ; '*: OK, I'll put that away'
    script_message $c018 ; '*: Is there anything else?'
    script_command SCRIPT_VAULT
    script_command SCRIPT_VAULT
    script_jump Script_Vault_2
Script_WhatWillYouBe::
    script_command SCRIPT_VAULT
    script_message $c020 ; '*: What will you be taking'
Script_Vault_6::
    script_command SCRIPT_VAULT
    script_choice_jump Script_IDon_5, Script_YouCan_11, Script_YouCan_12, Script_IDon_6, Script_ToWhatDoYouWant, Script_ToVault_7, Script_IsThereAnythingElse_13
Script_IDon_5::
    script_message $c021 ; '*: I don't have any of'
    script_command SCRIPT_VAULT
    script_jump Script_IsThereAnythingElse_12
Script_YouCan_11::
    script_message $c022 ; '*: You can't carry any more'
    script_command SCRIPT_VAULT
Script_IsThereAnythingElse_12::
    script_message $c018 ; '*: Is there anything else?'
    script_jump Script_Vault_4
Script_YouCan_12::
    script_message $c026 ; '*: You can't carry that much.'
    script_command SCRIPT_VAULT
    script_jump Script_IsThereAnythingElse_12
Script_IDon_6::
    script_message $c027 ; '*: I don't have any of'
    script_command SCRIPT_VAULT
    script_jump Script_IsThereAnythingElse_12
Script_ToWhatDoYouWant::
    script_jump Script_WhatDoYouWant
Script_ToVault_7::
    script_jump Script_Vault_7
Script_IsThereAnythingElse_13::
    script_message $c018 ; '*: Is there anything else?'
    script_command SCRIPT_VAULT
    script_jump Script_Vault_4
Script_WhatDoYouWant::
    script_message $c023 ; '*: What do you want back?'
    script_command SCRIPT_VAULT
    script_choice_jump Script_HowManyDoYou, Script_SorryButICan_3, Script_WhatWillYouBe_2
Script_WhatWillYouBe_2::
    script_command SCRIPT_VAULT
    script_message $c020 ; '*: What will you be taking'
    script_jump Script_Vault_6
Script_SorryButICan_3::
    script_message $c02c ; '*: Sorry, but I can't take'
    script_jump Script_WhatDoYouWant
Script_HowManyDoYou::
    script_message $c024 ; '*: How many do you want'
    script_command SCRIPT_VAULT
    script_choice_jump Script_HereYouGo, Script_YouCan_13, Script_ToWhatDoYouWant_2
Script_ToWhatDoYouWant_2::
    script_jump Script_WhatDoYouWant
Script_YouCan_13::
    script_message $c026 ; '*: You can't carry that much.'
    script_jump Script_HowManyDoYou
Script_HereYouGo::
    script_message $c025 ; '*: Here you go.'
    script_command SCRIPT_VAULT
    script_choice_jump Script_YouCan_14, Script_IDon_7, Script_ToWhatDoYouWant_3
Script_YouCan_14::
    script_message $c022 ; '*: You can't carry any more'
Script_IsThereAnythingElse_14::
    script_message $c018 ; '*: Is there anything else?'
    script_command SCRIPT_VAULT
    script_command SCRIPT_VAULT
    script_jump Script_Vault_2
Script_IDon_7::
    script_message $c02e ; '*: I don't have any more'
    script_jump Script_IsThereAnythingElse_14
Script_ToWhatDoYouWant_3::
    script_jump Script_WhatDoYouWant
Script_Vault_7::
    script_command SCRIPT_VAULT
Script_HowMuchGoldWill::
    script_message $c028 ; '*: How much gold will you'
    script_command SCRIPT_VAULT
    script_choice_jump Script_HereYouGo_2, Script_YouCan_15, Script_WhatWillYouBe_3
Script_YouCan_15::
    script_message $c026 ; '*: You can't carry that much.'
    script_jump Script_HowMuchGoldWill
Script_WhatWillYouBe_3::
    script_message $c020 ; '*: What will you be taking'
    script_jump Script_Vault_6
Script_HereYouGo_2::
    script_command SCRIPT_VAULT
    script_message $c025 ; '*: Here you go.'
    script_message $c018 ; '*: Is there anything else?'
    script_command SCRIPT_VAULT
    script_command SCRIPT_VAULT
    script_jump Script_Vault_2
Script_ComeAgainAnytime::
    script_command SCRIPT_VAULT_CLOSE
    script_message $802d ; '*: Come again anytime!'
    script_command SCRIPT_VAULT_CLOSE
    script_end
Script_It_3::
    script_command SCRIPT_INN
    script_command SCRIPT_INN
    script_message $c000 ; '*: It's 0G a night. Will'
    script_skip_if_no Script_SorryButYouLack
    script_message $8002 ; '*: Please come stay another time.'
    script_command SCRIPT_INN_CLOSE
    script_end
Script_SorryButYouLack::
    script_command SCRIPT_INN
    script_skip_if_no Script_WellThenHaveA
    script_message $8003 ; '*: Sorry, but you lack the'
    script_command SCRIPT_INN_CLOSE
    script_end
Script_WellThenHaveA::
    script_message $c001 ; '*: Well then, have a good'
    script_command SCRIPT_INN
    script_message $8004 ; '*: Good morning and farewell!'
    script_command SCRIPT_INN_CLOSE
    script_end
    ds $16d8, $00
