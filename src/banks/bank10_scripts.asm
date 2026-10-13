; ROM bank $10: event script engine: command fetch and handlers, scripts
; The annotated listing of this bank is build/listing/bank10.asm.

SECTION "Bank 10", ROMX[$4000], BANK[$10]
    db $10

; one frame of the event-script engine: FetchScriptCommand, then ExecuteScriptCommand
RunEventScriptFrame::
    call FetchScriptCommand
    call ExecuteScriptCommand
    ret

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

FetchScriptCommand_ReadScriptPointerLo::
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
    dw ScriptFetch00 ; entry 0
    dw ScriptFetch01 ; entry 1
    dw ScriptFetch02 ; entry 2
    dw ScriptFetch03 ; entry 3
    dw ScriptFetch04 ; entry 4
    dw ScriptFetch05 ; entry 5
    dw ScriptFetch06 ; entry 6
    dw ScriptFetch07 ; entry 7
    dw $0000 ; entry 8
    dw $0000 ; entry 9
    dw ScriptFetch0A ; entry 10
    dw ScriptFetch0B ; entry 11
    dw ScriptFetch0C ; entry 12
    dw ScriptFetch0D ; entry 13
    dw ScriptFetch0E ; entry 14
    dw ScriptFetch0F ; entry 15
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
    dw ScriptFetchE4 ; entry 228
    dw ScriptFetchE5 ; entry 229
    dw ScriptFetchE6 ; entry 230
    dw ScriptFetchE7 ; entry 231
    dw ScriptFetchE8 ; entry 232
    dw ScriptFetchE9 ; entry 233
    dw ScriptFetchEA ; entry 234
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
    dw ScriptFetchF5 ; entry 245
    dw ScriptFetchF6 ; entry 246
    dw ScriptFetchF7 ; entry 247
    dw ScriptFetchF8 ; entry 248

; the same five instructions as ScriptFetchGeneric, used by 30 opcodes
ScriptFetchGeneric2::
    pop hl
    dec hl
    ld a, [hli]
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode 81 (entry 129 of ScriptOpcodeHandlers)
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

; fetch handler for script opcode 83 (entry 131 of ScriptOpcodeHandlers)
ScriptFetch83::
    pop hl
    ld a, $83
    ld [wScriptCommandType], a
    call StartEventScript
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

; fetch handler for script opcode 86 (entry 134 of ScriptOpcodeHandlers)
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

; fetch handler for script opcode 00 (entry 0 of ScriptOpcodeHandlers)
ScriptFetch00::
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

; fetch handler for script opcode 01 (entry 1 of ScriptOpcodeHandlers)
ScriptFetch01::
    ld a, $02
    ld [wScriptCommandType], a
    jr ScriptFetch02_Restore

; fetch handler for script opcode 02 (entry 2 of ScriptOpcodeHandlers)
ScriptFetch02::
    ld a, $03
    ld [wScriptCommandType], a

ScriptFetch02_Restore::
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

; fetch handler for script opcode 03 (entry 3 of ScriptOpcodeHandlers)
ScriptFetch03::
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

; fetch handler for script opcode 04 (entry 4 of ScriptOpcodeHandlers)
ScriptFetch04::
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

; fetch handler for script opcode 05 (entry 5 of ScriptOpcodeHandlers)
ScriptFetch05::
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

; the same 13 bytes as CopyCBytesToVRAMWaitSTAT (CopyCBytesToVRAMWaitSTAT)
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

; fetch handler for script opcode 06 (entry 6 of ScriptOpcodeHandlers)
ScriptFetch06::
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
    jp FetchScriptCommand_ReadScriptPointerLo

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
    jp FetchScriptCommand_ReadScriptPointerLo

.set_script_pointer_lo2:
    inc hl
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    jp FetchScriptCommand_ReadScriptPointerLo

; fetch handler for script opcode 07 (entry 7 of ScriptOpcodeHandlers)
ScriptFetch07::
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
    jp FetchScriptCommand_ReadScriptPointerLo

.set_script_pointer_lo:
    ld a, [hli]
    ld [wScriptPointerLo], a
    ld a, [hl]
    ld [wScriptPointerHi], a
    jp FetchScriptCommand_ReadScriptPointerLo

; fetch handler for script opcode 0A (entry 10 of ScriptOpcodeHandlers)
ScriptFetch0A::
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
    jp FetchScriptCommand_ReadScriptPointerLo

; fetch handler for script opcode 0B (entry 11 of ScriptOpcodeHandlers)
ScriptFetch0B::
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

; fetch handler for script opcode 0C (entry 12 of ScriptOpcodeHandlers)
ScriptFetch0C::
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
    jp FetchScriptCommand_ReadScriptPointerLo

; fetch handler for script opcode 0D (entry 13 of ScriptOpcodeHandlers)
ScriptFetch0D::
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

; fetch handler for script opcode 0E (entry 14 of ScriptOpcodeHandlers)
ScriptFetch0E::
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
    jp FetchScriptCommand_ReadScriptPointerLo

; fetch handler for script opcode 0F (entry 15 of ScriptOpcodeHandlers)
ScriptFetch0F::
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
    jp FetchScriptCommand_ReadScriptPointerLo

.call_queue_music:
    call QueueMusic
    jp FetchScriptCommand_ReadScriptPointerLo

.call_restart_map_music:
    farcall RestartMapMusic
    jp FetchScriptCommand_ReadScriptPointerLo

; fetch handler shared by 123 opcodes: wScriptCommandType = the opcode byte, then StartEventScript
; with the pointer just after it; the command reads its own arguments from the script
ScriptFetchGeneric::
    pop hl
    dec hl
    ld a, [hli]
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode 1C (entry 28 of ScriptOpcodeHandlers)
ScriptFetch1C::
    pop hl
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and $03
    ld [wFollowerRecords], a
    ld a, $1c
    ld [wScriptCommandType], a
    call StartEventScript
    ld de, $0000
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

; fetch handler for script opcode 1D (entry 29 of ScriptOpcodeHandlers)
ScriptFetch1D::
    pop hl
    ld a, $1d
    ld [wScriptCommandType], a
    call StartEventScript
    ld de, $0000
    call TestFlagBit
    jr c, .set_message_index
    ld hl, $4097
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    xor a
    ld [wMessageState], a
    ret

.set_message_index:
    ld hl, $408d
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    xor a
    ld [wMessageState], a
    ret

; fetch handler for script opcode 23 (entry 35 of ScriptOpcodeHandlers)
ScriptFetch23::
    pop hl
    ld a, [wStoryFlags + $61]
    set 2, a
    ld [wStoryFlags + $61], a
    ld a, $23
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode 62 (entry 98 of ScriptOpcodeHandlers)
ScriptFetch62::
    pop hl
    dec hl
    ld a, [hli]
    ld [wScriptCommandType], a
    ld a, [wScriptParam1]
    push af
    call StartEventScript
    pop af
    ld [wScriptParam1], a
    ret

; fetch handler for script opcode E0 (entry 224 of ScriptOpcodeHandlers)
ScriptFetchE0::
    pop hl
    ld a, $e0
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode E1 (entry 225 of ScriptOpcodeHandlers)
ScriptFetchE1::
    pop hl
    ld a, $e1
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode E2 (entry 226 of ScriptOpcodeHandlers)
ScriptFetchE2::
    pop hl
    ld a, $e2
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode E3 (entry 227 of ScriptOpcodeHandlers)
ScriptFetchE3::
    pop hl
    ld a, $e3
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode E5 (entry 229 of ScriptOpcodeHandlers)
ScriptFetchE5::
    pop hl
    ld a, $e5
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode E6 (entry 230 of ScriptOpcodeHandlers)
ScriptFetchE6::
    pop hl
    ld a, $e6
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode E8 (entry 232 of ScriptOpcodeHandlers)
ScriptFetchE8::
    pop hl
    ld a, $e8
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode E9 (entry 233 of ScriptOpcodeHandlers)
ScriptFetchE9::
    pop hl
    ld a, $e9
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode EB (entry 235 of ScriptOpcodeHandlers)
ScriptFetchEB::
    pop hl
    ld a, $eb
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode EC (entry 236 of ScriptOpcodeHandlers)
ScriptFetchEC::
    pop hl
    ld a, $ec
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode ED (entry 237 of ScriptOpcodeHandlers)
ScriptFetchED::
    pop hl
    ld a, $ed
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode EE (entry 238 of ScriptOpcodeHandlers)
ScriptFetchEE::
    pop hl
    ld a, $ee
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode EF (entry 239 of ScriptOpcodeHandlers)
ScriptFetchEF::
    pop hl
    ld a, $ef
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode F0 (entry 240 of ScriptOpcodeHandlers)
ScriptFetchF0::
    pop hl
    ld a, $f0
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode F1 (entry 241 of ScriptOpcodeHandlers)
ScriptFetchF1::
    pop hl
    ld a, $f1
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode F2 (entry 242 of ScriptOpcodeHandlers)
ScriptFetchF2::
    pop hl
    ld a, $f2
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode F3 (entry 243 of ScriptOpcodeHandlers)
ScriptFetchF3::
    pop hl
    ld a, $f3
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode F4 (entry 244 of ScriptOpcodeHandlers)
ScriptFetchF4::
    pop hl
    ld a, $f4
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode F5 (entry 245 of ScriptOpcodeHandlers)
ScriptFetchF5::
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

; fetch handler for script opcode F6 (entry 246 of ScriptOpcodeHandlers)
ScriptFetchF6::
    pop hl
    ld a, $f6
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode F7 (entry 247 of ScriptOpcodeHandlers)
ScriptFetchF7::
    pop hl
    ld a, $f7
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode F8 (entry 248 of ScriptOpcodeHandlers)
ScriptFetchF8::
    pop hl
    ld a, $f8
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode EA (entry 234 of ScriptOpcodeHandlers)
ScriptFetchEA::
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
    ld de, $0000
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

; fetch handler for script opcode E7 (entry 231 of ScriptOpcodeHandlers)
ScriptFetchE7::
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
    jp FetchScriptCommand_ReadScriptPointerLo

; fetch handler for script opcode E4 (entry 228 of ScriptOpcodeHandlers)
ScriptFetchE4::
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
    jp FetchScriptCommand_ReadScriptPointerLo

.skip2:
    ld a, [hli]
    add_a_to_hl
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    jp FetchScriptCommand_ReadScriptPointerLo

; HL = script address: clears wScriptParam0-wMessageState (parameters and step) and stores HL in
; wScriptPointer; the script is run by RunEventScriptFrame (28 call sites)
StartEventScript::
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

; runs one frame of script command type 9E (entry 157 of ScriptCommandHandlers)
ScriptCommand9E::
    farcall KeyWorldFloorBattle
    ret

; runs one frame of script command type 9D (entry 156 of ScriptCommandHandlers)
ScriptCommand9D::
    farcall CountdownMessage
    ret

; runs one frame of script command type 9C (entry 155 of ScriptCommandHandlers)
ScriptCommand9C::
    farcall EncounterCounterMessage
    ret

; runs one frame of script command type 9B (entry 154 of ScriptCommandHandlers)
ScriptCommand9B::
    farcall HealPartyEvent
    ret

; runs one frame of script command type 9A (entry 153 of ScriptCommandHandlers)
ScriptCommand9A::
    farcall RandomBattleEvent
    ret

; runs one frame of script command type 99 (entry 152 of ScriptCommandHandlers)
ScriptCommand99::
    farcall ObjectPath1C
    ret

; runs one frame of script command type 98 (entry 151 of ScriptCommandHandlers)
ScriptCommand98::
    farcall ObjectPath1B
    ret

; runs one frame of script command type 95 (entry 148 of ScriptCommandHandlers)
ScriptCommand95::
    farcall ArenaGridBattle
    ret

; runs one frame of script command type 96 (entry 149 of ScriptCommandHandlers)
ScriptCommand96::
    farcall ArenaRounds
    ret

; runs one frame of script command type 90 (entry 143 of ScriptCommandHandlers)
ScriptCommand90::
    farcall FollowersStep10
    ret

; runs one frame of script command type 91 (entry 144 of ScriptCommandHandlers)
ScriptCommand91::
    farcall FollowersStep11
    ret

; runs one frame of script command type 92 (entry 145 of ScriptCommandHandlers)
ScriptCommand92::
    farcall PlayerAndFollowersStep
    ret

; runs one frame of script command type 93 (entry 146 of ScriptCommandHandlers)
ScriptCommand93::
    farcall WarpWithFollowers
    ret

; runs one frame of script command type 94 (entry 147 of ScriptCommandHandlers)
ScriptCommand94::
    farcall FollowersStep14
    ret

; runs one frame of script command type 8D (entry 140 of ScriptCommandHandlers)
ScriptCommand8D::
    farcall BreedChildScene
    ret

; runs one frame of script command type 8C (entry 139 of ScriptCommandHandlers)
ScriptCommand8C::
    farcall BreedChildSprite
    ret

; runs one frame of script command type 8B (entry 138 of ScriptCommandHandlers)
ScriptCommand8B::
    farcall BreedFade
    ret

; runs one frame of script command type 8F (entry 142 of ScriptCommandHandlers)
ScriptCommand8F::
    farcall NpcBreedWarp
    ret

; runs one frame of script command type 9F (entry 158 of ScriptCommandHandlers)
ScriptCommand9F::
    farcall LinkMessageEvent
    ret

; runs one frame of script command type A0 (entry 159 of ScriptCommandHandlers)
ScriptCommandA0::
    farcall PlayerSpriteFlash
    ret

; runs one frame of script command type A1 (entry 160 of ScriptCommandHandlers)
ScriptCommandA1::
    farcall PlayerSpriteMessage
    ret

; runs one frame of script command type 8E (entry 141 of ScriptCommandHandlers)
ScriptCommand8E::
    farcall MapLinkWarp
    ret

; runs one frame of script command type 8A (entry 137 of ScriptCommandHandlers)
ScriptCommand8A::
    farcall MapExitWarp
    ret

; runs one frame of script command type 80 (entry 127 of ScriptCommandHandlers)
ScriptCommand80::
    farcall StepTriggerReward
    ret

; runs one frame of script command type 81 (entry 128 of ScriptCommandHandlers)
ScriptCommand81::
    farcall AreaItemEvent
    ret

; runs one frame of script command type 86 (entry 133 of ScriptCommandHandlers)
ScriptCommand86::
    farcall KeyWorldDoorItem
    ret

; runs one frame of script command type 82 (entry 129 of ScriptCommandHandlers)
ScriptCommand82::
    farcall GreatLogFieldEvents
    ret

; runs one frame of script command type 83 (entry 130 of ScriptCommandHandlers)
ScriptCommand83::
    farcall FieldScene01
    ret

; runs one frame of script command type 84 (entry 131 of ScriptCommandHandlers)
ScriptCommand84::
    farcall RandomGoldOrItem
    ret

; runs one frame of script command type 85 (entry 132 of ScriptCommandHandlers)
ScriptCommand85::
    farcall KeyWorldBossBattle
    ret

; runs one frame of script command type 87 (entry 134 of ScriptCommandHandlers)
ScriptCommand87::
    farcall PartyDefeatedReturn
    ret

; runs one frame of script command type 88 (entry 135 of ScriptCommandHandlers)
ScriptCommand88::
    farcall ReturnMessage
    ret

; runs one frame of script command type 89 (entry 136 of ScriptCommandHandlers)
ScriptCommand89::
    farcall ReturnWarp
    ret

; runs one frame of script command type 06 (entry 5 of ScriptCommandHandlers)
ScriptCommand06::
    farcall ScriptSetDirection
    ret

; runs one frame of script command type 05 (entry 4 of ScriptCommandHandlers)
ScriptCommand05::
    farcall ScriptCommand05_Run
    ret

; runs one frame of script command type 04 (entry 3 of ScriptCommandHandlers)
ScriptCommand04::
    farcall ScriptWaitFrames
    ret

; runs one frame of script command type 03 (entry 2 of ScriptCommandHandlers)
ScriptCommand03::
    farcall ScriptStepObject

; runs one frame of script command type 02 (entry 1 of ScriptCommandHandlers)
ScriptCommand02::
    farcall ScriptStepObject
    ret

; runs one frame of script command type 0A (entry 9 of ScriptCommandHandlers)
ScriptCommand0A::
    farcall RunOneTimeTreasure
    ret

; runs one frame of script command type 09 (entry 8 of ScriptCommandHandlers)
ScriptCommand09::
    ld a, [wScriptStep]
    jumptable
    dw ScriptCommand09_SetBit1OfPlayerAndObjectFlags
    dw ScriptCommand09_ReadScriptParam1AndTextWindowStateEtc
    dw ScriptCommand09_QueueSoundEffect
    dw ScriptCommand09_ClearBit1OfPlayerAndObjectFlags

ScriptCommand09_ClearBit1OfPlayerAndObjectFlags::
    ld a, [wTextWindowState]
    and $03
    ret nz
    farcall ClearBit1OfPlayerAndObjectFlags
    xor a
    ld [wScriptCommandType], a
    xor a
    ld [wScriptRunning], a
    ld a, $00
    ld [wModeState], a
    ret

; runs one frame of script command type 01 (entry 0 of ScriptCommandHandlers)
ScriptCommand01::
    ld a, [wScriptStep]
    jumptable
    dw ScriptCommand09_SetBit1OfPlayerAndObjectFlags
    dw ScriptCommand09_ReadScriptParam1AndTextWindowStateEtc
    dw ScriptCommand09_QueueSoundEffect
    dw ScriptCommand01_ClearBit1OfPlayerAndObjectFlags

ScriptCommand09_SetBit1OfPlayerAndObjectFlags::
    ld a, [wScriptParam1]
    bit 7, a
    jr nz, .done
    farcall SetBit1OfPlayerAndObjectFlags
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

ScriptCommand09_ReadScriptParam1AndTextWindowStateEtc::
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
    call ScriptCommand09_Case01_WriteStringIndexAndStringCategory
    ld hl, wScriptStep
    inc [hl]
    ret

ScriptCommand09_QueueSoundEffect::
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

ScriptCommand01_ClearBit1OfPlayerAndObjectFlags::
    ld a, [wScriptParam1]
    bit 6, a
    jr nz, .clear_script_command_type
    ld a, [wTextWindowState]
    and $03
    ret nz
    farcall ClearBit1OfPlayerAndObjectFlags

.clear_script_command_type:
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

ScriptCommand09_Case01_WriteStringIndexAndStringCategory::
    ld a, h
    and $3f
    ld h, a
    push hl
    ld a, [wMessageMode]
    and a
    jr z, ScriptCommand09_Case01_WriteStringIndexAndStringCategory_Data_CheckMapType
    dec a
    ld c, a
    sla a
    add c
    ld de, ScriptCommand09_Case01_WriteStringIndexAndStringCategory_Data
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

ScriptCommand09_Case01_WriteStringIndexAndStringCategory_Data::
    db $01, $40, $f0, $01, $40, $f0, $0e, $52, $1f, $01, $40, $1d, $86, $4c, $1b, $d0
    db $43, $f2, $01, $40, $0d, $01, $40, $0e, $01, $40, $0b, $90, $64, $33, $10, $5d
    db $24

ScriptCommand09_Case01_WriteStringIndexAndStringCategory_Data_CheckMapType::
    pop hl
    ld a, [wMapType]
    cp $80
    jr z, .set_string_index
    bit 7, a
    jp nz, ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank89_Skip

.set_string_index:
    ld a, l
    ld [wStringIndex], a
    xor a
    ld [wStringCategory], a
    ld a, h
    jumptable
    dw ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank28
    dw ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank29
    dw ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank2A
    dw ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank2B
    dw ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank2C
    dw ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank2D
    dw ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank2E
    dw ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank2E
    dw ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank7C
    dw ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank80
    dw ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank80
    dw ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank82
    dw ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank86
    dw ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank89

ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank28::
    farcall BeginStringDisplay_Bank28
    ret

ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank29::
    farcall BeginStringDisplay_Bank29
    ret

ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank2A::
    farcall BeginStringDisplay_Bank2A
    ret

ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank2B::
    farcall BeginStringDisplay_Bank2B
    ret

ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank2C::
    farcall BeginStringDisplay_Bank2C
    ret

ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank2D::
    farcall BeginStringDisplay_Bank2D
    ret

ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank2E::
    farcall BeginStringDisplay_Bank2E
    ret

ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank7C::
    farcall BeginStringDisplay_Bank7C
    ret

ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank80::
    farcall BeginStringDisplay_Bank80
    ret

ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank82::
    farcall BeginStringDisplay_Bank82
    ret

ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank86::
    farcall BeginStringDisplay_Bank86
    ret

ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank89::
    farcall BeginStringDisplay_Bank89
    ret

ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank89_Skip::
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

; runs one frame of script command type 0C (entry 11 of ScriptCommandHandlers)
ScriptCommand0C::
    farcall ScriptSlideObjectY
    ret

; runs one frame of script command type 0E (entry 13 of ScriptCommandHandlers)
ScriptCommand0E::
    farcall ScriptCommand0E_Run
    ret

; runs one frame of script command type 11 (entry 16 of ScriptCommandHandlers)
ScriptCommand11::
    farcall SceneFarmKids
    ret

; runs one frame of script command type 12 (entry 17 of ScriptCommandHandlers)
ScriptCommand12::
    farcall SceneLearnQuick
    ret

; runs one frame of script command type 13 (entry 18 of ScriptCommandHandlers)
ScriptCommand13::
    farcall SceneSpinning
    ret

; runs one frame of script command type 14 (entry 19 of ScriptCommandHandlers)
ScriptCommand14::
    farcall SceneWarubouSmells
    ret

; runs one frame of script command type 15 (entry 20 of ScriptCommandHandlers)
ScriptCommand15::
    farcall SceneWarubouFood
    ret

; runs one frame of script command type 16 (entry 21 of ScriptCommandHandlers)
ScriptCommand16::
    farcall SceneWarubouFood2
    ret

; runs one frame of script command type 17 (entry 22 of ScriptCommandHandlers)
ScriptCommand17::
    farcall ScenePackage
    ret

; runs one frame of script command type 18 (entry 23 of ScriptCommandHandlers)
ScriptCommand18::
    farcall SceneGreatlogKey
    ret

; runs one frame of script command type 19 (entry 24 of ScriptCommandHandlers)
ScriptCommand19::
    farcall SceneWarubouMagicKey
    ret

; runs one frame of script command type 1A (entry 25 of ScriptCommandHandlers)
ScriptCommand1A::
    farcall SceneOasisKey
    ret

; runs one frame of script command type 1B (entry 26 of ScriptCommandHandlers)
ScriptCommand1B::
    farcall SceneWarubouLeaves
    ret

; runs one frame of script command type 1C (entry 27 of ScriptCommandHandlers)
ScriptCommand1C::
    farcall SceneWarubouWarning
    ret

; runs one frame of script command type 1D (entry 28 of ScriptCommandHandlers)
ScriptCommand1D::
    farcall SceneLongFaces
    ret

; runs one frame of script command type 1E (entry 29 of ScriptCommandHandlers)
ScriptCommand1E::
    farcall CheckItem
    ret

; runs one frame of script command type 1F (entry 30 of ScriptCommandHandlers)
ScriptCommand1F::
    farcall SceneMonsterInspection
    ret

; runs one frame of script command type 20 (entry 31 of ScriptCommandHandlers)
ScriptCommand20::
    farcall ScriptCommand20_Run
    ret

; runs one frame of script command type 21 (entry 32 of ScriptCommandHandlers)
ScriptCommand21::
    farcall SceneKingAudience
    ret

; runs one frame of script command type 22 (entry 33 of ScriptCommandHandlers)
ScriptCommand22::
    farcall SceneCanalGate
    ret

; runs one frame of script command type 23 (entry 34 of ScriptCommandHandlers)
ScriptCommand23::
    farcall SceneWaterShortage
    ret

; runs one frame of script command type 24 (entry 35 of ScriptCommandHandlers)
ScriptCommand24::
    farcall SceneTreasureTheft
    ret

; runs one frame of script command type 25 (entry 36 of ScriptCommandHandlers)
ScriptCommand25::
    farcall SceneWaterSolved
    ret

; runs one frame of script command type 26 (entry 37 of ScriptCommandHandlers)
ScriptCommand26::
    farcall SceneMonstersInTow
    ret

; runs one frame of script command type 27 (entry 38 of ScriptCommandHandlers)
ScriptCommand27::
    farcall SceneRivalDefeated
    ret

; runs one frame of script command type 28 (entry 39 of ScriptCommandHandlers)
ScriptCommand28::
    farcall ShakeScreen
    ret

; runs one frame of script command type 29 (entry 40 of ScriptCommandHandlers)
ScriptCommand29::
    farcall SceneWhoAreYou
    ret

; runs one frame of script command type 2A (entry 41 of ScriptCommandHandlers)
ScriptCommand2A::
    farcall SceneWatchOut
    ret

; runs one frame of script command type 2B (entry 42 of ScriptCommandHandlers)
ScriptCommand2B::
    farcall SceneMermaidSong
    ret

; runs one frame of script command type 2C (entry 43 of ScriptCommandHandlers)
ScriptCommand2C::
    farcall SceneDancing
    ret

; runs one frame of script command type 2D (entry 44 of ScriptCommandHandlers)
ScriptCommand2D::
    farcall SceneMermaidSong2
    ret

; runs one frame of script command type 2E (entry 45 of ScriptCommandHandlers)
ScriptCommand2E::
    farcall WarpMap41
    ret

; runs one frame of script command type 2F (entry 46 of ScriptCommandHandlers)
ScriptCommand2F::
    farcall SceneTentacles
    ret

; runs one frame of script command type 30 (entry 47 of ScriptCommandHandlers)
ScriptCommand30::
    farcall SceneSailorRing
    ret

; runs one frame of script command type 31 (entry 48 of ScriptCommandHandlers)
ScriptCommand31::
    farcall ScenePirateGhosts
    ret

; runs one frame of script command type 32 (entry 49 of ScriptCommandHandlers)
ScriptCommand32::
    farcall GiveItemBlink
    ret

; runs one frame of script command type 33 (entry 50 of ScriptCommandHandlers)
ScriptCommand33::
    farcall SceneCrate
    ret

; runs one frame of script command type 34 (entry 51 of ScriptCommandHandlers)
ScriptCommand34::
    farcall SetTilesFlag310
    ret

; runs one frame of script command type 35 (entry 52 of ScriptCommandHandlers)
ScriptCommand35::
    farcall SceneKamehaEscape
    ret

; runs one frame of script command type 36 (entry 53 of ScriptCommandHandlers)
ScriptCommand36::
    farcall SceneKamehaCaught
    ret

; runs one frame of script command type 37 (entry 54 of ScriptCommandHandlers)
ScriptCommand37::
    farcall SceneCrewFollows
    ret

; runs one frame of script command type 38 (entry 55 of ScriptCommandHandlers)
ScriptCommand38::
    farcall SceneKamehaFlees
    ret

; runs one frame of script command type 39 (entry 56 of ScriptCommandHandlers)
ScriptCommand39::
    farcall SceneMermaidKingdom
    ret

; runs one frame of script command type 3A (entry 57 of ScriptCommandHandlers)
ScriptCommand3A::
    farcall SceneMasterThanks
    ret

; runs one frame of script command type 3B (entry 58 of ScriptCommandHandlers)
ScriptCommand3B::
    farcall SceneMermaidKingdom
    ret

; runs one frame of script command type 3C (entry 59 of ScriptCommandHandlers)
ScriptCommand3C::
    farcall RewardItemOrKey
    ret

; runs one frame of script command type 3D (entry 60 of ScriptCommandHandlers)
ScriptCommand3D::
    farcall RewardItemOrKey2
    ret

; runs one frame of script command type 3E (entry 61 of ScriptCommandHandlers)
ScriptCommand3E::
    farcall SceneStrongestMaster
    ret

; runs one frame of script command type 3F (entry 62 of ScriptCommandHandlers)
ScriptCommand3F::
    farcall BlinkSprites
    ret

; runs one frame of script command type 40 (entry 63 of ScriptCommandHandlers)
ScriptCommand40::
    farcall SceneSpiritEnvoy
    ret

; runs one frame of script command type 41 (entry 64 of ScriptCommandHandlers)
ScriptCommand41::
    farcall SceneExplosion
    ret

; runs one frame of script command type 42 (entry 65 of ScriptCommandHandlers)
ScriptCommand42::
    farcall SceneReportToKing
    ret

; runs one frame of script command type 43 (entry 66 of ScriptCommandHandlers)
ScriptCommand43::
    farcall SceneWallExit
    ret

; runs one frame of script command type 44 (entry 67 of ScriptCommandHandlers)
ScriptCommand44::
    farcall SceneRealKing
    ret

; runs one frame of script command type 45 (entry 68 of ScriptCommandHandlers)
ScriptCommand45::
    farcall ScenePlanRuined
    ret

; runs one frame of script command type 46 (entry 69 of ScriptCommandHandlers)
ScriptCommand46::
    farcall SceneCheerYuna
    ret

; runs one frame of script command type 47 (entry 70 of ScriptCommandHandlers)
ScriptCommand47::
    farcall SceneSpiritEnvoy2
    ret

; runs one frame of script command type 48 (entry 71 of ScriptCommandHandlers)
ScriptCommand48::
    farcall ScenePrincessMedicine
    ret

; runs one frame of script command type 49 (entry 72 of ScriptCommandHandlers)
ScriptCommand49::
    farcall SceneMedicineGiven
    ret

; runs one frame of script command type 4A (entry 73 of ScriptCommandHandlers)
ScriptCommand4A::
    farcall SceneShield
    ret

; runs one frame of script command type 4B (entry 74 of ScriptCommandHandlers)
ScriptCommand4B::
    farcall SceneShield2
    ret

; runs one frame of script command type 4C (entry 75 of ScriptCommandHandlers)
ScriptCommand4C::
    farcall ScriptCommand4C_Run
    ret

; runs one frame of script command type 4D (entry 76 of ScriptCommandHandlers)
ScriptCommand4D::
    farcall SceneWaterReward
    ret

; runs one frame of script command type 4E (entry 77 of ScriptCommandHandlers)
ScriptCommand4E::
    farcall SceneGrave
    ret

; runs one frame of script command type 4F (entry 78 of ScriptCommandHandlers)
ScriptCommand4F::
    farcall SetTilesD2
    ret

; runs one frame of script command type 50 (entry 79 of ScriptCommandHandlers)
ScriptCommand50::
    farcall SceneMadcondor
    ret

; runs one frame of script command type 51 (entry 80 of ScriptCommandHandlers)
ScriptCommand51::
    farcall SceneMadcondorCry
    ret

; runs one frame of script command type 52 (entry 81 of ScriptCommandHandlers)
ScriptCommand52::
    farcall SceneSmallHole
    ret

; runs one frame of script command type 53 (entry 82 of ScriptCommandHandlers)
ScriptCommand53::
    farcall SceneJustice
    ret

; runs one frame of script command type 54 (entry 83 of ScriptCommandHandlers)
ScriptCommand54::
    farcall SceneGravestone
    ret

; runs one frame of script command type 55 (entry 84 of ScriptCommandHandlers)
ScriptCommand55::
    farcall SetFlag322
    ret

; runs one frame of script command type 56 (entry 85 of ScriptCommandHandlers)
ScriptCommand56::
    farcall SceneBeatenFairly
    ret

; runs one frame of script command type 57 (entry 86 of ScriptCommandHandlers)
ScriptCommand57::
    farcall SceneThreeItemsBattle
    ret

; runs one frame of script command type 58 (entry 87 of ScriptCommandHandlers)
ScriptCommand58::
    farcall SceneThreeItems
    ret

; runs one frame of script command type 59 (entry 88 of ScriptCommandHandlers)
ScriptCommand59::
    farcall SceneSawKameha
    ret

; runs one frame of script command type 5A (entry 89 of ScriptCommandHandlers)
ScriptCommand5A::
    farcall SceneSawKameha
    ret

; runs one frame of script command type 5B (entry 90 of ScriptCommandHandlers)
ScriptCommand5B::
    farcall SceneLimbo
    ret

; runs one frame of script command type 5C (entry 91 of ScriptCommandHandlers)
ScriptCommand5C::
    farcall TakeItem
    ret

; runs one frame of script command type 5D (entry 92 of ScriptCommandHandlers)
ScriptCommand5D::
    farcall SceneDarckTaunt
    ret

; runs one frame of script command type 5E (entry 93 of ScriptCommandHandlers)
ScriptCommand5E::
    farcall SceneDarckDefeated
    ret

; runs one frame of script command type 5F (entry 94 of ScriptCommandHandlers)
ScriptCommand5F::
    farcall SceneHomecoming
    ret

; runs one frame of script command type 60 (entry 95 of ScriptCommandHandlers)
ScriptCommand60::
    farcall ScriptCommand60_Run
    ret

; runs one frame of script command type 61 (entry 96 of ScriptCommandHandlers)
ScriptCommand61::
    farcall SceneKamehaStole
    ret

; runs one frame of script command type 62 (entry 97 of ScriptCommandHandlers)
ScriptCommand62::
    farcall PersonalityMessage
    ret

; runs one frame of script command type 63 (entry 98 of ScriptCommandHandlers)
ScriptCommand63::
    farcall SceneRivalFade
    ret

; runs one frame of script command type 64 (entry 99 of ScriptCommandHandlers)
ScriptCommand64::
    farcall GatherFollowers
    ret

; runs one frame of script command type 65 (entry 100 of ScriptCommandHandlers)
ScriptCommand65::
    farcall GrowthLimitInfo
    ret

; runs one frame of script command type 66 (entry 101 of ScriptCommandHandlers)
ScriptCommand66::
    farcall SceneShieldGuardian
    ret

; runs one frame of script command type 67 (entry 102 of ScriptCommandHandlers)
ScriptCommand67::
    farcall SceneJustice2
    ret

; runs one frame of script command type 68 (entry 103 of ScriptCommandHandlers)
ScriptCommand68::
    farcall SceneFoundMe
    ret

; runs one frame of script command type 69 (entry 104 of ScriptCommandHandlers)
ScriptCommand69::
    farcall SceneFoundMeBattle
    ret

; runs one frame of script command type 6A (entry 105 of ScriptCommandHandlers)
ScriptCommand6A::
    farcall SceneHorsingAround
    ret

; runs one frame of script command type 6B (entry 106 of ScriptCommandHandlers)
ScriptCommand6B::
    farcall SceneVaultSettled
    ret

; runs one frame of script command type 6C (entry 107 of ScriptCommandHandlers)
ScriptCommand6C::
    farcall GiveMonster
    ret

; runs one frame of script command type 6D (entry 108 of ScriptCommandHandlers)
ScriptCommand6D::
    farcall SceneLimboMonster
    ret

; runs one frame of script command type 6E (entry 109 of ScriptCommandHandlers)
ScriptCommand6E::
    farcall SceneLimboMonster2
    ret

; runs one frame of script command type 6F (entry 110 of ScriptCommandHandlers)
ScriptCommand6F::
    farcall DeskKey
    ret

; runs one frame of script command type 70 (entry 111 of ScriptCommandHandlers)
ScriptCommand70::
    farcall SceneTerry
    ret

; runs one frame of script command type 71 (entry 112 of ScriptCommandHandlers)
ScriptCommand71::
    farcall SceneKamehaKeyBattle
    ret

; runs one frame of script command type 72 (entry 113 of ScriptCommandHandlers)
ScriptCommand72::
    farcall SceneKamehaKeyBattle2
    ret

; runs one frame of script command type 73 (entry 114 of ScriptCommandHandlers)
ScriptCommand73::
    farcall FollowerFacePlayer
    ret

; runs one frame of script command type 74 (entry 115 of ScriptCommandHandlers)
ScriptCommand74::
    farcall SetFlagRedraw
    ret

; runs one frame of script command type 75 (entry 116 of ScriptCommandHandlers)
ScriptCommand75::
    farcall SceneAtSea
    ret

; runs one frame of script command type 76 (entry 117 of ScriptCommandHandlers)
ScriptCommand76::
    farcall ScriptCommand76_Run
    ret

; runs one frame of script command type 77 (entry 118 of ScriptCommandHandlers)
ScriptCommand77::
    farcall SceneLandHo
    ret

; runs one frame of script command type 78 (entry 119 of ScriptCommandHandlers)
ScriptCommand78::
    farcall SaveScreen
    ret

; runs one frame of script command type 79 (entry 120 of ScriptCommandHandlers)
ScriptCommand79::
    farcall ScenePoorChurch
    ret

; runs one frame of script command type 7A (entry 121 of ScriptCommandHandlers)
ScriptCommand7A::
    farcall SceneKamehaMissing
    ret

; runs one frame of script command type 7B (entry 122 of ScriptCommandHandlers)
ScriptCommand7B::
    farcall SceneArenaChallenge
    ret

; runs one frame of script command type 7C (entry 123 of ScriptCommandHandlers)
ScriptCommand7C::
    farcall SceneTerryBattle
    ret

; runs one frame of script command type 7D (entry 124 of ScriptCommandHandlers)
ScriptCommand7D::
    farcall SceneThisWay
    ret

; runs one frame of script command type 7E (entry 125 of ScriptCommandHandlers)
ScriptCommand7E::
    farcall SceneGotTo
    ret

; runs one frame of script command type 7F (entry 126 of ScriptCommandHandlers)
ScriptCommand7F::
    farcall SceneChestServant
    ret

; runs one frame of script command type C0 (entry 191 of ScriptCommandHandlers)
ScriptCommandC0::
    farcall SceneRoltElder
    ret

; runs one frame of script command type C1 (entry 192 of ScriptCommandHandlers)
ScriptCommandC1::
    farcall SceneTooStrong
    ret

; runs one frame of script command type C2 (entry 193 of ScriptCommandHandlers)
ScriptCommandC2::
    farcall SceneGiveBackCyal
    ret

; runs one frame of script command type C3 (entry 194 of ScriptCommandHandlers)
ScriptCommandC3::
    farcall KeyBossBeaten
    ret

; runs one frame of script command type C6 (entry 197 of ScriptCommandHandlers)
ScriptCommandC6::
    farcall SceneCyalRolt
    ret

; runs one frame of script command type C4 (entry 195 of ScriptCommandHandlers)
ScriptCommandC4::
    farcall SceneBarrel
    ret

; runs one frame of script command type C5 (entry 196 of ScriptCommandHandlers)
ScriptCommandC5::
    farcall SceneWizstone
    ret

; runs one frame of script command type C7 (entry 198 of ScriptCommandHandlers)
ScriptCommandC7::
    farcall ScenePendantSeller
    ret

; runs one frame of script command type C8 (entry 199 of ScriptCommandHandlers)
ScriptCommandC8::
    farcall SceneMercy
    ret

; runs one frame of script command type C9 (entry 200 of ScriptCommandHandlers)
ScriptCommandC9::
    farcall SceneMilayouForest
    ret

; runs one frame of script command type CA (entry 201 of ScriptCommandHandlers)
ScriptCommandCA::
    farcall KeyBossBeaten2
    ret

; runs one frame of script command type CB (entry 202 of ScriptCommandHandlers)
ScriptCommandCB::
    farcall SceneChestBattle
    ret

; runs one frame of script command type CC (entry 203 of ScriptCommandHandlers)
ScriptCommandCC::
    farcall SceneCyalShine
    ret

; runs one frame of script command type CD (entry 204 of ScriptCommandHandlers)
ScriptCommandCD::
    farcall SceneYouDidIt
    ret

; runs one frame of script command type CE (entry 205 of ScriptCommandHandlers)
ScriptCommandCE::
    farcall HideSprites
    ret

; runs one frame of script command type CF (entry 206 of ScriptCommandHandlers)
ScriptCommandCF::
    farcall SceneKeyShop
    ret

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_4F54::
    script_sound $28
    script_message $0030 ; '*: Heh, so these are the'
    script_face $81, 1
    script_message $0031 ; '*: C'mon, Warubou!'
    script_command SCRIPT_SCENE_WARUBOU_LEAVES
    script_sound $ff
    script_set_flag $0015
    script_end
Script_4F66::
    script_message $404c ; '*: Have you heard about Magic'
    script_skip_if_no Script_4F6F
    script_message $804e ; '*: You need Magic Keys to'
    script_end
Script_4F6F::
    script_message $804d ; '*: Wow, you kids sure learn'
    script_end
Script_4F73::
    script_sound $28
    script_command SCRIPT_SCENE_LEARN_QUICK
    script_message $0033 ; '*: Oh… It's… all spinning around…'
    script_sound $ff
    script_end
Script_4F7C::
    script_sound $28
    script_wait 100
    script_command SCRIPT_SCENE_SPINNING
    script_wait 30
    script_sound $ff
    script_end
Script_4F88::
    script_message $0045 ; '*: You must be the farm'
    script_command SCRIPT_SCENE_FARM_KIDS
    script_end
Script_4F8D::
    script_slide_y $82
    script_message $0050 ; 'Warubou: Wha…? I smell something! I'
    script_command SCRIPT_SCENE_WARUBOU_SMELLS
    script_message $0051 ; 'Warubou: What is this? Food? Perfect!'
    script_set_flag $000a
    script_command SCRIPT_SCENE_WARUBOU_FOOD
    script_sound $ff
    script_end
Script_4F9D::
    script_sound $28
    script_command SCRIPT_SCENE_WARUBOU_FOOD_2
    script_message $005d ; 'Warubou: Calm down and listen! What'
    script_end
Script_4FA4::
    script_message $001e ; '*: You've come at the right'
    script_command SCRIPT_SCENE_VAULT_SETTLED
    script_message $0020 ; '*: Good, that's settled then. The'
    script_set_flag $0003
    script_end
Script_4FAF::
    script_message $006a ; '*: Did you get the package'
    script_command SCRIPT_SCENE_PACKAGE
    script_message $006b ; '*: Oh goodness, you're filthy! What'
    script_end
Script_4FB7::
    script_message $4028 ; '*: I've heard that there are'
    script_skip_if_no Script_4FCC
    script_message $802a ; '*: Monster masters are those people'
    script_command SCRIPT_FOLLOWER_FACE_PLAYER
    script_slide_y $01
    script_message $002d ; 'Tara: Big brother can't do it'
    script_message $002c ; '*: I aspired to be one'
    script_set_flag $0014
    script_end
Script_4FCC::
    script_message $8029 ; '*: Oh? Well, that's fine then.'
    script_end
Script_4FD0::
    script_message $4028 ; '*: I've heard that there are'
    script_skip_if_no Script_4FE4
    script_message $802a ; '*: Monster masters are those people'
    script_slide_y $01
    script_message $002b ; 'Cobi: Hahah! 0 won't last a'
    script_message $002c ; '*: I aspired to be one'
    script_set_flag $0014
    script_end
Script_4FE4::
    script_message $8029 ; '*: Oh? Well, that's fine then.'
    script_end
Script_4FE8::
    script_message $0060 ; '*: Hah? The island's going to'
    script_slide_y $01
    script_message $0063 ; 'Tara: Why aren't you listening? Papa,'
    script_message $0062 ; '*: Look, an island just doesn't'
    script_set_flag $000e
    script_end
Script_4FF7::
    script_message $0060 ; '*: Hah? The island's going to'
    script_slide_y $01
    script_message $0061 ; 'Cobi: Why won't you believe us?'
    script_message $0062 ; '*: Look, an island just doesn't'
    script_set_flag $000e
    script_end
Script_5006::
    script_message $007a ; 'Warubou: Wa-hey! Good, you're back. You'
    script_slide_y $01
    script_message $407b ; 'Warubou: No time to waste, warooh!'
    script_skip_if_no Script_5017
    script_message $807c ; 'Warubou: No? Then find someone!'
    script_set_flag $0016
    script_end
Script_5017::
    script_message $807f ; 'Warubou: Wa-hey! Good, good, good! In'
    script_command SCRIPT_SCENE_WARUBOU_MAGIC_KEY
    script_message $0080 ; 'Warubou: This here is a Magic'
    script_command SCRIPT_SCENE_OASIS_KEY
    script_message $0081 ; '0 received the Oasis Key.'
    script_message $0082 ; 'Warubou: Wa-hey! I trust you! Go!'
    script_set_flag $001a
    script_end
Script_5029::
    script_message $407d ; 'Warubou: Wa-hey? No one believed! You'
    script_skip_if_no Script_5036
Script_502E::
    script_message $c07e ; 'Warubou: Wa-hey! No more dawdling! GreatLog'
    script_skip_if_no Script_5036
    script_jump Script_502E
Script_5036::
    script_jump Script_5017
Script_5039::
    script_set_flag $0011
    script_set_flag $0017
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
Script_5063::
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
    script_set_flag $0012
    script_end
Script_509F::
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
    script_set_flag $0012
    script_end
Script_50DB::
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
Script_50F6::
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
Script_5111::
    script_command SCRIPT_SCENE_HORSING_AROUND
    script_message $0015 ; '*: Listen you two! Quit your'
    script_walk 0, 2, 5
    script_face $80, 1
    script_face $81, 3
    script_end
Script_5120::
    script_message $4007 ; '*: Sailing is sure exhilarating. Right?'
    script_skip_if_no Script_5129
    script_message $8009 ; '*: Is that so? Too bad!'
    script_end
Script_5129::
    script_message $8008 ; '*: Good. That's good to hear!'
    script_end
Script_512D::
    script_command SCRIPT_GREATLOG_FIELD_EVENT
    script_end
Script_512F::
    script_command SCRIPT_FIELD_SCENE_01
    script_end
Script_5131::
    script_command SCRIPT_RANDOM_GOLD_OR_ITEM
    script_end
Script_5133::
    script_command SCRIPT_KEY_WORLD_BOSS_BATTLE
    script_end
Script_5135::
    script_command SCRIPT_KEY_WORLD_FLOOR_BATTLE
    script_end
Script_5137::
    script_command SCRIPT_PARTY_DEFEATED_RETURN
    script_end
Script_5139::
    script_command SCRIPT_RETURN_MESSAGE
    script_end
Script_513B::
    script_command SCRIPT_RETURN_WARP
    script_end
Script_513D::
    script_command SCRIPT_MAP_EXIT_WARP
    script_end
Script_513F::
    script_command SCRIPT_MAP_LINK_WARP
    script_end
Script_5141::
    script_command SCRIPT_PLAYER_SPRITE_FLASH
    script_end
Script_5143::
    script_command SCRIPT_PLAYER_SPRITE_MESSAGE
    script_end
Script_5145::
    script_command SCRIPT_KEY_WORLD_DOOR_ITEM
    script_end
Script_5147::
    script_command SCRIPT_AREA_ITEM
    script_end
Script_5149::
    script_command SCRIPT_STEP_TRIGGER_REWARD
    script_end
Script_514B::
    script_command SCRIPT_FOLLOWERS_STEP_10
    script_end
Script_514D::
    script_command SCRIPT_FOLLOWERS_STEP_11
    script_end
Script_514F::
    script_command SCRIPT_PLAYER_AND_FOLLOWERS_STEP
    script_end
Script_5151::
    script_command SCRIPT_WARP_WITH_FOLLOWERS
    script_end
Script_5153::
    script_command SCRIPT_FOLLOWERS_STEP_14
    script_end
Script_5155::
    script_command SCRIPT_BREED_FADE
    script_end
Script_5157::
    script_command SCRIPT_BREED_CHILD_SPRITE
    script_end
Script_5159::
    script_command SCRIPT_BREED_CHILD_SCENE
    script_end
Script_515B::
    script_command SCRIPT_NPC_BREED_WARP
    script_end
Script_515D::
    script_command SCRIPT_LINK_MESSAGE
    script_end
Script_515F::
    script_hold_dpad $00, 5
    script_command SCRIPT_ARENA_GRID_BATTLE
    script_end
Script_5164::
    script_hold_dpad $00, 5
    script_command SCRIPT_ARENA_ROUNDS
    script_end
Script_5169::
    script_command SCRIPT_RANDOM_BATTLE
    script_end
Script_516B::
    script_command SCRIPT_HEAL_PARTY
    script_end
Script_516D::
    script_command SCRIPT_OBJECT_PATH_1B
    script_end
Script_516F::
    script_command SCRIPT_OBJECT_PATH_1C
    script_end
Script_5171::
    script_command SCRIPT_ENCOUNTER_MESSAGE
    script_end
Script_5173::
    script_command SCRIPT_COUNTDOWN_MESSAGE
    script_end
Script_5175::
    script_message $0100 ; '*: Are you going out to'
    script_message $0101 ; '0 received an Herb.'
    script_set_flag $01a7
    script_end
Script_517F::
    script_message $0200 ; '*: You've been going out a'
    script_message $0201 ; 'Mom handed over 200G.'
    script_add_gold 200
    script_end
Script_5189::
    script_message $48a1 ; '*: Oh? You'll run another errand?'
    script_skip_if_no Script_5192
    script_message $88a4 ; '*: No miracles today! Oh, well.'
    script_end
Script_5192::
    script_message $88a2 ; '*: My, what has gotten into'
    script_message $08a3 ; 'Mama handed over 400G.'
    script_add_gold 400
    script_set_flag $0183
    script_end
Script_519F::
    script_message $08a6 ; '*: Oh… You've found what I'
    script_message $08a7 ; '0 handed over the Potion.'
    script_set_flag $0184
    script_end
Script_51A9::
    script_message $48a1 ; '*: Oh? You'll run another errand?'
    script_skip_if_no Script_51B2
    script_message $88a4 ; '*: No miracles today! Oh, well.'
    script_end
Script_51B2::
    script_message $88a8 ; '*: Well, could you go buy'
    script_message $08a9 ; 'Mama handed over 600G.'
    script_add_gold 600
    script_set_flag $0185
    script_end
Script_51BF::
    script_message $08a6 ; '*: Oh… You've found what I'
    script_message $08ac ; '0 handed over the Rib.'
    script_set_flag $0186
    script_end
    db $00, $01, $43, $06, $04, $00, $04, $83, $ff, $00, $02, $83, $00, $03, $03, $0e
    db $b0, $04, $0a, $87, $01, $ff, $00, $01, $43, $06, $04, $00, $04, $83, $ff, $00
    db $07, $83, $00, $08, $03, $0e, $b0, $04, $0a, $89, $01, $ff

Script_51F5::
    script_message $4a25 ; '*: I was going to ask'
    script_skip_if_no Script_51FE
    script_message $8a26 ; '*: Oh… Then I'll ask Tara.'
    script_end
Script_51FE::
    script_message $8a22 ; '*: The farm that your father'
    script_message $0a23 ; '*: Mama handed over 1,200G.'
    script_add_gold 1200
    script_set_flag $018b
    script_end
Script_520B::
    script_message $4a21 ; '*: I was going to ask'
    script_skip_if_no Script_5214
    script_message $8a24 ; '*: Oh… Then I'll ask Cobi.'
    script_end
Script_5214::
    script_message $8a22 ; '*: The farm that your father'
    script_message $0a23 ; '*: Mama handed over 1,200G.'
    script_add_gold 1200
    script_set_flag $018b
    script_end
Script_5221::
    script_message $0a28 ; '*: They didn't have any around'
    script_message $0a29 ; '0 handed over the Sirloin.'
    script_set_flag $018c
    script_end
Script_522B::
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
Script_5256::
    script_set_flag $0102
    script_message $410d ; 'Cobi: Hi, I'm helping Papa to'
    script_jump_data_bank Script_1F_5A3A
    db $ff

Script_5260::
    script_message $410e ; 'Cobi: Hi, 0! What's up today?'
    script_jump_data_bank Script_1F_5A3A
    db $ff

Script_5267::
    script_set_flag $0105
    script_message $4207 ; 'Cobi: 0, what was it like'
    script_jump_data_bank Script_1F_5A3A
    db $ff

Script_5271::
    script_set_flag $0109
    script_message $48bc ; 'Cobi: 0, what was it like'
    script_jump_data_bank Script_1F_5A3A
    db $ff

Script_527B::
    script_set_flag $0115
    script_message $4a30 ; 'Cobi: 0, what was it like'
    script_jump_data_bank Script_1F_5A3A
    db $ff

Script_5285::
    script_set_flag $0121
    script_message $4502 ; 'Cobi: 0, tell me about what'
    script_jump_data_bank Script_1F_5A3A
    db $ff

Script_528F::
    script_set_flag $0131
    script_message $4b02 ; 'Cobi: 0, I envied you for'
    script_jump_data_bank Script_1F_5A3A
    db $ff

Script_5299::
    script_set_flag $0102
    script_message $410f ; 'Tara: I'm helping Papa take care'
    script_jump_data_bank Script_1F_5A3A
    db $ff

Script_52A3::
    script_message $4110 ; 'Tara: Hi! How are you? Do'
    script_jump_data_bank Script_1F_5A3A
    db $ff

Script_52AA::
    script_set_flag $0105
    script_message $4208 ; 'Tara: Big brother, have you found'
    script_jump_data_bank Script_1F_5A3A
    db $ff

Script_52B4::
    script_set_flag $0109
    script_message $48bd ; 'Tara: Big brother, tell me about'
    script_jump_data_bank Script_1F_5A3A
    db $ff

Script_52BE::
    script_set_flag $0115
    script_message $4a31 ; 'Tara: Big brother, tell me about'
    script_jump_data_bank Script_1F_5A3A
    db $ff

Script_52C8::
    script_set_flag $0121
    script_message $4503 ; 'Tara: Big brother, tell me about'
    script_jump_data_bank Script_1F_5A3A
    db $ff

Script_52D2::
    script_set_flag $0131
    script_message $4b03 ; 'Tara: 0, I was a little'
    script_jump_data_bank Script_1F_5A3A
    db $ff

Script_52DC::
    script_message $0105 ; '*: Why do you have a'
    script_message $0106 ; '0 received a PorkChop.'
    script_end
Script_52E3::
    script_set_flag $0190
    script_message $48af ; '*: Beavern helped put up the'
    script_skip_if_no Script_52EF
    script_message $88b1 ; '*: If one joins you, could'
    script_end
Script_52EF::
    script_message $88b0 ; '*: I like to get help'
    script_end
Script_52F3::
    script_message $48b3 ; '*: A MadGopher joined you? Could'
    script_skip_if_no Script_52FC
    script_message $88b5 ; '*: 0, I need your help.'
    script_end
Script_52FC::
    script_message $88b4 ; '*: Great, 0! Thanks a lot!'
    script_command SCRIPT_REWARD_ITEM_OR_KEY
    script_message $0d17 ; '*: Here, 0! You need this!'
    script_message $0d18 ; '0 received the Ice Key.'
    script_message $0d19 ; '*: Be careful when you're traveling'
    script_set_flag $0191
    script_end
Script_530D::
    script_message $48b3 ; '*: A MadGopher joined you? Could'
    script_skip_if_no Script_5316
    script_message $88b5 ; '*: 0, I need your help.'
    script_end
Script_5316::
    script_message $88b4 ; '*: Great, 0! Thanks a lot!'
    script_command SCRIPT_REWARD_ITEM_OR_KEY
    script_message $0d48 ; '*: Here, 0! You hold onto'
    script_set_flag $01a3
    script_set_flag $0191
    script_end
Script_5324::
    script_message $48b3 ; '*: A MadGopher joined you? Could'
    script_skip_if_no Script_532D
    script_message $88b5 ; '*: 0, I need your help.'
    script_end
Script_532D::
    script_message $88b4 ; '*: Great, 0! Thanks a lot!'
    script_command SCRIPT_REWARD_ITEM_OR_KEY
    script_message $0d47 ; '*: Here, 0! You hold onto'
    script_message $0d41 ; '0 received a TinyMedal!'
    script_message $0d19 ; '*: Be careful when you're traveling'
    script_set_flag $0191
    script_end
Script_533E::
    script_message $420d ; '*: You're too young to be'
    script_jump_data_bank Script_6659
    db $ff

Script_5345::
    script_message $420e ; '*: Welcome! How may I serve'
    script_jump_data_bank Script_6659
    db $ff

Script_534C::
    script_message $4d89 ; '*: Well, well! If it isn't'
    script_jump_data_bank Script_6659
    db $ff

Script_5353::
    script_set_flag $0103
    script_message $411c ; '*: Oh, hi! Good to see'
    script_jump_data_bank Script_67B5
    db $ff

Script_535D::
    script_message $411d ; '*: How may the Vault serve'
    script_jump_data_bank Script_67B5
    db $ff

Script_5364::
    script_set_flag $0127
    script_message $4b1c ; '*: Hello, GreatLog's hero! Do you'
    script_jump_data_bank Script_67B5
    db $ff

Script_536E::
    script_message $411f ; 'Warubou: Wa-hey! You remember the promise'
    script_skip_if_no Script_5377
    script_message $8121 ; 'Warubou: Use a Magic Key and'
    script_end
Script_5377::
    script_message $8120 ; 'Warubou: Quit dawdling, warooh!'
    script_end
    db $00, $9e, $42, $06, $04, $00, $a2, $82, $ff, $00, $9f, $82, $ff, $00, $9e, $42
    db $06, $04, $00, $a2, $82, $ff, $00, $a0, $82, $ff, $00, $a3, $02, $3b, $0a, $2f
    db $01, $ff, $00, $a3, $02, $3b, $0a, $35, $01, $ff, $00, $a3, $02, $3b, $0a, $39
    db $01, $ff

Script_53AD::
    script_message $452a ; 'Warubou: Wa-hey! Are you ready? Ready'
    script_skip_if_no Script_53B6
    script_message $8531 ; 'Warubou: Wa-hey, well, hurry it up!'
    script_end
Script_53B6::
    script_message $8530 ; 'Warubou: Wa-hey! Take the treasures that'
    script_end
Script_53BA::
    script_message $452a ; 'Warubou: Wa-hey! Are you ready? Ready'
    script_skip_if_no Script_53C3
    script_message $8531 ; 'Warubou: Wa-hey, well, hurry it up!'
    script_end
Script_53C3::
    script_message $852b ; 'Warubou: Wa-hey! Take the treasures that'
    script_command SCRIPT_SCENE_LIMBO
    script_message $052f ; 'Warubou: Limbo is the King's domain!'
    script_set_flag $013b
    script_end
Script_53CE::
    script_command SCRIPT_SCENE_LIMBO_MONSTER
    script_end
Script_53D0::
    script_command SCRIPT_SCENE_LIMBO_MONSTER_2
    script_end
Script_53D2::
    script_message $4a36 ; '*: Prince Kameha has been missing'
    script_skip_if_no Script_53DB
    script_message $8a38 ; '*: You better be telling the'
    script_end
Script_53DB::
    script_message $8a37 ; '*: What's that? You saw Prince'
    script_set_flag $0117
    script_command SCRIPT_SCENE_SAW_KAMEHA
    script_message $0a3a ; '*: Sire, this child claims to'
    script_message $0a3b ; 'King: What's that? Is that so?'
    script_walk 0, 0, 1
    script_message $0d28 ; '0 obtained the Sky Key.'
    script_walk 0, 2, 1
    script_face $80, 0
    script_message $0d29 ; 'King: Kameha made off with the'
    script_end
Script_53FA::
    script_set_flag $0117
    script_message $4504 ; '*: If the island sink, is'
    script_skip_if_no Script_540D
    script_message $8506 ; '*: Hey! You're the kid who'
    script_command SCRIPT_SCENE_KAMEHA_BACK
    script_message $0507 ; '*: Prince Kameha came back! What'
    script_set_flag $0122
    script_end
Script_540D::
    script_message $8505 ; '*: People have been saying that'
    script_command SCRIPT_SCENE_KAMEHA_BACK
    script_message $0507 ; '*: Prince Kameha came back! What'
    script_set_flag $0122
    script_end
Script_5418::
    script_message $021d ; '*: Take this slide as a'
    script_sound $65
    script_walk 1, 0, 3
    script_end
Script_5422::
    script_message $4264 ; '*: Oh… You're so lucky to'
    script_skip_if_no Script_542B
    script_message $8266 ; '*: Oh… Sorry… It's your friend…'
    script_end
Script_542B::
    script_message $8265 ; '*: R… Really? Wow! Thank you!'
    script_command SCRIPT_SCENE_MASTER_THANKS
    script_set_flag $012d
    script_end
Script_5433::
    script_message $4b47 ; '*: I became a master because'
    script_skip_if_no Script_543C
    script_message $8d81 ; '*: Aww… How boring… Visit us'
    script_end
Script_543C::
    script_message $8d80 ; '*: Really? Let's go to the'
    script_command SCRIPT_SCENE_ARENA_CHALLENGE
    script_end
Script_5441::
    script_message $4227 ; '0 checked the pedestal. It's the'
    script_skip_if_no Script_544A
    script_message $8229 ; '0 put back the Library Guide.'
    script_end
Script_544A::
    script_message $8228 ; ''You may check your Catalog of'
    script_end
Script_544E::
    script_set_flag $0108
    script_message $422a ; '*: Welcome to the Library. You'
    script_jump_data_bank Script_1F_787B
    db $ff

Script_5458::
    script_message $422b ; '*: Welcome to the Library. Which'
    script_jump_data_bank Script_1F_787B
    db $ff

Script_545F::
    script_set_flag $002d
    script_message $4b49 ; '*: Hello, our young savior! Have'
    script_jump_data_bank Script_1F_787B
    db $ff

Script_5469::
    script_set_flag $019e
    script_message $4df0 ; '*: Welcome to the Library! Your'
    script_message $cdf1 ; '*: We need fanfare right about'
    script_jump_data_bank Script_1F_787B
    db $ff

Script_5476::
    script_message $4230 ; '*: Do you have any idea'
    script_skip_if_no Script_547F
    script_message $8232 ; '*: Monsters can be categorized in'
    script_end
Script_547F::
    script_message $8231 ; '*: Oh… You've read this book'
    script_end
Script_5483::
    script_message $4246 ; '*: Hey, let me ask you'
    script_skip_if_no Script_548C
    script_message $8248 ; '*: Good, you're lucky! Stay away,'
    script_end
Script_548C::
    script_message $8247 ; '*: Did she say anything to'
    script_end
Script_5490::
    script_message $4257 ; '*: Did you know that there's'
    script_skip_if_no Script_5499
    script_message $8259 ; '*: Go visit the Christener. She's'
    script_end
Script_5499::
    script_message $8258 ; '*: Monsters should have cute names.'
    script_end
Script_549D::
    script_message $44c3 ; '*: Welcome. I'm the Christener. I'
    script_jump_data_bank Script_96_6FF8
    db $ff

Script_54A4::
    script_message $44c4 ; '*: Welcome. I'm the Christener. Do'
    script_jump_data_bank Script_96_6FF8
    db $ff

Script_54AB::
    script_message $4a4e ; '*: Hello, 0, welcome! This is'
    script_jump_data_bank Script_1D_4335
    db $ff

Script_54B2::
    script_message $4a4f ; '*: Hello, 0, welcome! Want to'
    script_jump_data_bank Script_1D_4335
    db $ff

Script_54B9::
    script_message $4a5a ; '0 checked the casket.'
    script_message $8a5b ; '*: Zzz… Use the plan 'Charge''
    script_end
Script_54C0::
    script_message $4a5a ; '0 checked the casket.'
    script_message $8a5c ; '*: Zzz… Hnnnnnrgh… Huh? Being 'Cautious''
    script_end
Script_54C7::
    script_message $4a5e ; '0 peered into the hole.'
    script_message $8a5f ; '*: Zzz… Zzz… Some skills are'
    script_end
Script_54CE::
    script_message $4281 ; '*: Oh, a cute little master!'
    script_skip_if_no Script_54D7
    script_message $8283 ; '*: Oh. Well, I'll be here'
    script_end
Script_54D7::
    script_message $8282 ; '*: In the Kids Class final,'
    script_end
Script_54DB::
    script_message $4a60 ; '*: Oh, you're the Kids Class'
    script_skip_if_no Script_54E4
    script_message $8283 ; '*: Oh. Well, I'll be here'
    script_end
Script_54E4::
    script_message $8a61 ; '*: In the C Class final,'
    script_end
Script_54E8::
    script_message $4a62 ; '*: Oh, you're the C Class'
    script_skip_if_no Script_54F1
    script_message $8283 ; '*: Oh. Well, I'll be here'
    script_end
Script_54F1::
    script_message $8a63 ; '*: In the B Class final,'
    script_end
Script_54F5::
    script_message $4a64 ; '*: Oh, you're the B Class'
    script_skip_if_no Script_54FE
    script_message $8283 ; '*: Oh. Well, I'll be here'
    script_end
Script_54FE::
    script_message $8a65 ; '*: In the A Class final,'
    script_end
Script_5502::
    script_message $4a66 ; '*: Oh, you're the A Class'
    script_skip_if_no Script_550B
    script_message $8283 ; '*: Oh. Well, I'll be here'
    script_end
Script_550B::
    script_message $8a67 ; '*: In the S Class final,'
    script_end
Script_550F::
    script_message $4281 ; '*: Oh, a cute little master!'
    script_skip_if_no Script_5518
    script_message $8283 ; '*: Oh. Well, I'll be here'
    script_end
Script_5518::
    script_message $8216 ; '*: Play it safe against Skullroo.'
    script_end
Script_551C::
    script_message $4a60 ; '*: Oh, you're the Kids Class'
    script_skip_if_no Script_5525
    script_message $8283 ; '*: Oh. Well, I'll be here'
    script_end
Script_5525::
    script_message $8a7f ; '*: In the C Class final,'
    script_end
Script_5529::
    script_message $4a62 ; '*: Oh, you're the C Class'
    script_skip_if_no Script_5532
    script_message $8283 ; '*: Oh. Well, I'll be here'
    script_end
Script_5532::
    script_message $8a80 ; '*: In the B Class final,'
    script_end
Script_5536::
    script_message $4a64 ; '*: Oh, you're the B Class'
    script_skip_if_no Script_553F
    script_message $8283 ; '*: Oh. Well, I'll be here'
    script_end
Script_553F::
    script_message $8a81 ; '*: In the A Class final,'
    script_end
Script_5543::
    script_message $4a66 ; '*: Oh, you're the A Class'
    script_skip_if_no Script_554C
    script_message $8283 ; '*: Oh. Well, I'll be here'
    script_end
Script_554C::
    script_message $8a82 ; '*: In the S Class final,'
    script_end
Script_5550::
    script_message $426b ; '*: Welcome to the Arena! Masters'
    script_skip_if_no Script_5559
    script_message $826d ; '*: Oh, then you must be'
    script_end
Script_5559::
    script_message $c26c ; '*: You're young, so you have'
    script_jump_data_bank Script_0C_7A51
    db $ff

Script_5560::
    script_set_flag $0189
    script_message $4270 ; '*: Welcome to the Arena! The'
    script_jump_data_bank Script_0C_7A51
    db $ff

Script_556A::
    script_message $4271 ; '*: Hello, which Class will it'
    script_jump_data_bank Script_0C_7A51
    db $ff

Script_5571::
    script_message $4d86 ; '*: Welcome! Do you wish to'
    script_jump_data_bank Script_0C_7A51
    db $ff

Script_5578::
    script_message $4275 ; '*: Here's the Magic Key you'
    script_message $8274 ; '*: Oh? But your key ring'
    script_end
Script_557F::
    script_message $0275 ; '*: Here's the Magic Key you'
    script_message $0273 ; '0 received a Magic Key.'
    script_end
Script_5586::
    script_message $04b0 ; '*: I lost again. I need'
    script_end
    db $ff

Script_558B::
    script_message $44b3 ; '*: I lost again. I need'
    script_skip_if_no Script_5594
    script_message $84b2 ; '*: I'll be here for a'
    script_end
Script_5594::
    script_message $c4b1 ; '*: Good! Let's get started!'
    script_end
Script_5598::
    script_message $48cf ; '*: Um… I'm the Egg Evaluator.'
    script_set_flag $010f
    script_jump_data_bank Script_96_6EF7
    db $ff

Script_55A2::
    script_message $48d0 ; '*: I'm the Egg Evaluator. May'
    script_jump_data_bank Script_96_6EF7
    db $ff

Script_55A9::
    script_set_flag $0028
    script_message $4b20 ; '*: Oh, the savior of GreatLog.'
    script_jump_data_bank Script_96_6EF7
    db $ff

Script_55B3::
    script_message $48d3 ; '*: Welcome to the Starry Shrine.'
    script_set_flag $0110
    script_jump_data_bank Script_15_764B
    db $ff

Script_55BD::
    script_message $48d4 ; '*: Welcome to the Starry Shrine.'
    script_jump_data_bank Script_15_764B
    db $ff

Script_55C4::
    script_set_flag $002c
    script_message $4b2e ; '*: Aren't you GreatLog's savior? Well,'
    script_jump_data_bank Script_15_764B
    db $ff

Script_55CE::
    script_message $48d5 ; '*: I'm the Prof's assistant. Do'
    script_skip_if_no Script_55D7
    script_message $88d7 ; '*: Talk to the Prof if'
    script_end
Script_55D7::
    script_message $88d6 ; '*: You can breed monsters and'
    script_end
Script_55DB::
    script_set_flag $0112
    script_message $4a6d ; '*: You can call me the'
    script_jump_data_bank Script_0C_7BA9
    db $ff

Script_55E5::
    script_message $4a6e ; '*: You can call me the'
    script_jump_data_bank Script_0C_7BA9
    db $ff

Script_55EC::
    script_set_flag $0031
    script_message $4b50 ; '*: Well, who would have thought'
    script_jump_data_bank Script_0C_7BA9
    db $ff

Script_55F6::
    script_message $025f ; '*: I've never seen my granddaughter'
    script_message $0260 ; '0 received a LifeAcorn.'
    script_set_flag $012e
    script_end
Script_5600::
    script_message $48c8 ; '*: Wait! Could I get you'
    script_skip_if_no Script_5609
    script_message $88ca ; '*: Oh… That's very disappointing. I'
    script_end
Script_5609::
    script_message $88c9 ; '*: Fantastic! I can open my'
    script_command SCRIPT_REWARD_ITEM_OR_KEY_2
    script_message $0d40 ; '*: I like you to have'
    script_message $0d18 ; '0 received the Ice Key.'
    script_message $0d42 ; '*: I'll pray for your safety.'
    script_set_flag $0134
    script_end
Script_561A::
    script_message $48c8 ; '*: Wait! Could I get you'
    script_skip_if_no Script_5623
    script_message $88ca ; '*: Oh… That's very disappointing. I'
    script_end
Script_5623::
    script_message $88c9 ; '*: Fantastic! I can open my'
    script_command SCRIPT_REWARD_ITEM_OR_KEY_2
    script_message $0d43 ; '*: I like you to have'
    script_set_flag $01a5
    script_set_flag $0134
    script_end
Script_5631::
    script_message $48c8 ; '*: Wait! Could I get you'
    script_skip_if_no Script_563A
    script_message $88ca ; '*: Oh… That's very disappointing. I'
    script_end
Script_563A::
    script_message $88c9 ; '*: Fantastic! I can open my'
    script_command SCRIPT_REWARD_ITEM_OR_KEY_2
    script_message $0d40 ; '*: I like you to have'
    script_message $0d41 ; '0 received a TinyMedal!'
    script_message $0d42 ; '*: I'll pray for your safety.'
    script_set_flag $0134
    script_end
Script_564B::
    script_message $48cb ; '*: ArmyAnt helped me get my'
    script_jump_data_bank Script_6659
    db $ff

Script_5652::
    script_message $48cc ; '*: Welcome! How may I serve'
    script_jump_data_bank Script_6659
    db $ff, $00, $8a, $4d, $e7, $59, $66, $ff

Script_5660::
    script_message $4a46 ; '*: I'm a traveling merchant. I'm'
    script_skip_if_no Script_5669
    script_message $8a48 ; '*: Oh, too bad. Another time.'
    script_end
Script_5669::
    script_message $ca47 ; '*: Then let's breed them!'
    script_jump_data_bank Script_0E_7F8B
    db $ff

Script_5670::
    script_message $4513 ; '*: I'm a scientist. I've been'
    script_skip_if_no Script_5679
    script_message $8515 ; '*: Oh… Perhaps on another occasion.'
    script_end
Script_5679::
    script_message $c514 ; '*: Well, let's see about breeding!'
    script_jump_data_bank Script_0E_7F8B
    db $ff

Script_5680::
    script_message $44b7 ; '*: Hm? Little one, are you'
    script_skip_if_no Script_5689
    script_message $84b9 ; '*: Oh, too bad. Another time.'
    script_end
Script_5689::
    script_message $c4b8 ; '*: Good! Let's get this started!'
    script_jump_data_bank Script_0E_7F8B
    db $ff

Script_5690::
    script_message $44c8 ; '*: I was once a great'
    script_skip_if_no Script_569C
    script_message $84ca ; '*: You've not found any yet?'
    script_set_flag $011d
    script_end
Script_569C::
    script_message $84c9 ; '*: Have you shown them to'
    script_end
Script_56A0::
    script_message $0b4c ; '*: Oh! Goodness! I'm surprised! I've'
    script_command SCRIPT_SCENE_KEY_SHOP
    script_set_flag $002f
    script_end
Script_56A8::
    script_message $0bbf ; '*: How good of you to'
    script_command SCRIPT_SCENE_KEY_SHOP
    script_end
Script_56AD::
    script_set_flag $011f
    script_message $4297 ; '*: Welcome to my Key Shop!'
    script_jump_data_bank Script_0D_62B8
    db $ff

Script_56B7::
    script_message $4298 ; '*: Welcome to my Key Shop!'
    script_jump_data_bank Script_0D_62B8
    db $ff

Script_56BE::
    script_set_flag $0113
    script_message $4b1e ; '*: You're GreatLog's savior! Do you'
    script_jump_data_bank Script_0D_62B8
    db $ff

Script_56C8::
    script_message $44bd ; '*: Yo! Up close, you look'
    script_skip_if_no Script_56D1
    script_message $84bf ; '*: What? Are you sure about'
    script_end
Script_56D1::
    script_message $c4be ; '*: I like your style! Let's'
    script_jump_data_bank Script_0E_7F8B
    db $ff

Script_56D8::
    script_message $4277 ; '*: Welcome to the Arena! Would'
    script_skip_if_no Script_56E1
    script_message $8279 ; '*: Oops, it's not your first'
    script_end
Script_56E1::
    script_message $8278 ; '*: Your party may enter in'
    script_end
Script_56E5::
    script_message $4277 ; '*: Welcome to the Arena! Would'
    script_skip_if_no Script_56EE
    script_message $8b66 ; '*: Oops, it's not your first'
    script_end
Script_56EE::
    script_message $8b65 ; '*: As a pro master, you'
    script_end
Script_56F2::
    script_encounter $1a ; encounter words: Slime, Slime, Slime
    script_end
Script_56F5::
    script_walk 2, 3, 2
    script_face $00, 1
    script_message $0546 ; 'Cobi: 0, congratulations! I thought we'
    script_wait 60
    script_sound $28
    script_message $0547 ; '*: Hehehe, no need to worry'
    script_command SCRIPT_SCENE_HOMECOMING
    script_end
Script_5709::
    script_walk 2, 3, 2
    script_face $00, 1
    script_message $054a ; 'Tara: 0, congratulations! I was sad'
    script_wait 60
    script_sound $28
    script_message $0547 ; '*: Hehehe, no need to worry'
    script_command SCRIPT_SCENE_HOMECOMING
    script_end
Script_571D::
    script_message $4111 ; '*: Want to know how the'
    script_skip_if_no Script_5726
    script_message $8113 ; '*: Aww… You know already? Boring!'
    script_end
Script_5726::
    script_message $8112 ; '*: Including the monsters with you,'
    script_end
Script_572A::
    script_message $4111 ; '*: Want to know how the'
    script_skip_if_no Script_5733
    script_message $8113 ; '*: Aww… You know already? Boring!'
    script_end
Script_5733::
    script_message $8255 ; '*: The farm grew a lot'
    script_end
Script_5737::
    script_message $4111 ; '*: Want to know how the'
    script_skip_if_no Script_5740
    script_message $8113 ; '*: Aww… You know already? Boring!'
    script_end
Script_5740::
    script_message $88be ; '*: Including the monsters with you,'
    script_end
Script_5744::
    script_message $4a54 ; '*: Do you want to know'
    script_skip_if_no Script_574D
    script_message $8a58 ; '*: Everyone has a growth limit.'
    script_end
Script_574D::
    script_command SCRIPT_GROWTH_LIMIT_INFO
    script_message $8a57 ; 'Once a monster reaches its growth'
    script_end
Script_5752::
    script_message $4289 ; '*: Hello there. Do you know'
    script_skip_if_no Script_575B
    script_message $828b ; '*: You don't know? Sorry about'
    script_end
Script_575B::
    script_message $828a ; '*: The strongest master I've ever'
    script_end
Script_575F::
    script_command SCRIPT_SCENE_STRONGEST_MASTER
    script_set_flag $012b
    script_end
    db $00, $70, $4a, $06, $04, $00, $73, $8a, $ff, $00, $72, $8a, $ff, $00, $70, $4a
    db $06, $04, $00, $73, $8a, $ff, $00, $71, $8a, $02, $02, $02, $03, $02, $02, $03
    db $01, $02, $02, $02, $01, $05, $80, $03, $05, $82, $01, $03, $3c, $00, $60, $03
    db $3c, $00, $0f, $48, $4c, $03, $1e, $00, $0f, $ff, $0a, $37, $01, $ff

Script_57A2::
    script_set_flag $0138
    script_wait 30
    script_command SCRIPT_SCENE_KAMEHA_MISSING
    script_walk_fast 0, 0, 5
    script_message $4a36 ; '*: Prince Kameha has been missing'
    script_skip_if_no Script_57BD
    script_message $8a38 ; '*: You better be telling the'
    script_walk_fast 0, 2, 5
    script_face $80, 0
    script_end
Script_57BD::
    script_message $8a37 ; '*: What's that? You saw Prince'
    script_set_flag $0117
    script_command SCRIPT_SCENE_SAW_KAMEHA
    script_message $0a3a ; '*: Sire, this child claims to'
    script_message $0a3b ; 'King: What's that? Is that so?'
    script_walk 0, 0, 1
    script_message $0d28 ; '0 obtained the Sky Key.'
    script_walk 0, 2, 1
    script_face $80, 0
    script_message $0d29 ; 'King: Kameha made off with the'
    script_end
Script_57DC::
    script_face $00, 3
    script_command SCRIPT_SCENE_KAMEHA_STOLE
    script_end
Script_57E1::
    script_command SCRIPT_PERSONALITY_MESSAGE
    script_end
Script_57E3::
    script_message $0d60 ; 'What will you give to the'
    script_command SCRIPT_SAVE_SCREEN
    script_end
Script_57E8::
    script_message $0d61 ; 'Y has been given to the'
    script_command SCRIPT_SAVE_SCREEN
    script_end
Script_57ED::
    script_set_flag $012c
    script_message $4b16 ; '*: I'm sorry. I was wrong'
    script_jump_data_bank Script_6707
    db $ff

Script_57F7::
    script_message $4b17 ; '*: Hello! How may I serve'
    script_jump_data_bank Script_6707
    db $ff

Script_57FE::
    script_message $4b21 ; '*: Hello, hero! Let me help'
    script_skip_if_no Script_5807
    script_message $8b24 ; '*: Oh… Well, that's too bad,'
    script_end
Script_5807::
    script_message $8b23 ; '*: Oh? But there's no room'
    script_end
Script_580B::
    script_message $4b21 ; '*: Hello, hero! Let me help'
    script_skip_if_no Script_5814
    script_message $8b24 ; '*: Oh… Well, that's too bad,'
    script_end
Script_5814::
    script_message $8b22 ; '*: You'll take it? Excellent! I'll'
    script_command SCRIPT_GIVE_MONSTER
    script_set_flag $0029
    script_end
Script_581C::
    script_message $4b53 ; '*: Didn't you save GreatLog? That'
    script_skip_if_no Script_5825
    script_message $8b55 ; '*: Oh. Too bad. Maybe next'
    script_end
Script_5825::
    script_message $cb54 ; '*: Great! Let's give it a'
    script_jump_data_bank Script_0E_7F8B
    db $ff

Script_582C::
    script_message $4b57 ; '*: Ah, you must be the'
    script_skip_if_no Script_5835
    script_message $8b59 ; '*: May misfortune shun you. I'll'
    script_end
Script_5835::
    script_message $cb58 ; '*: May good fortune arrive quickly.'
    script_jump_data_bank Script_0E_7F8B
    db $ff

Script_583C::
    script_message $4b5b ; '*: I didn't think GreatLog's hero'
    script_skip_if_no Script_5845
    script_message $8b5d ; '*: Oh… That's so disappointing. Well,'
    script_end
Script_5845::
    script_message $cb5c ; '*: Well, no time to lose!'
    script_jump_data_bank Script_0E_7F8B
    db $ff

Script_584C::
    script_message $4b6a ; '*: Are you perhaps GreatLog's savior?'
    script_skip_if_no Script_5855
    script_message $8b6c ; '*: No? Well, if we meet'
    script_end
Script_5855::
    script_message $cb6b ; '*: OK! Let the breeding happen!'
    script_jump_data_bank Script_0E_7F8B
    db $ff

Script_585C::
    script_message $4b70 ; '*: Hey! You're still at it,'
    script_skip_if_no Script_5865
    script_message $8b72 ; '*: That's too bad. It's a'
    script_end
Script_5865::
    script_message $cb71 ; '*: Great! Good answer!'
    script_jump_data_bank Script_0E_7F8B
    db $ff

Script_586C::
    script_message $0bc3 ; '0 checked the desk.'
    script_command SCRIPT_DESK_KEY
    script_message $0b4e ; '0 obtained the Brawn Key.'
    script_set_flag $003d
    script_end
Script_5877::
    script_message $0bc3 ; '0 checked the desk.'
    script_command SCRIPT_DESK_KEY
    script_message $0bb5 ; '0 obtained the Baffle Key.'
    script_set_flag $003d
    script_end
Script_5882::
    script_message $0bc3 ; '0 checked the desk.'
    script_command SCRIPT_DESK_KEY
    script_message $0bb7 ; '0 obtained the Soul Key.'
    script_set_flag $00c8
    script_end
Script_588D::
    script_message $0bc3 ; '0 checked the desk.'
    script_command SCRIPT_DESK_KEY
    script_message $0bc0 ; '0 obtained the Magic Key.'
    script_end
Script_5895::
    script_sound $60
    script_command SCRIPT_SCENE_TERRY
    script_end
Script_5899::
    script_message $4bad ; '*: Humph… I'm Terry. I'm a'
    script_skip_if_no Script_58A2
    script_message $8baf ; 'Terry: Oh, it was someone else?'
    script_end
Script_58A2::
    script_message $8bae ; 'Terry: Humph… Confident, huh? I'll tell'
    script_command SCRIPT_SCENE_TERRY_BATTLE
    script_end
    db $00, $b0, $4b, $06, $04, $00, $af, $8b, $ff, $00, $ae, $8b, $7c, $ff

Script_58B5::
    script_message $4b8f ; 'Kameha: I've gone to other worlds'
    script_skip_if_no Script_58BE
    script_message $8b91 ; 'Kameha: What? Scared, 0?'
    script_end
Script_58BE::
    script_message $8b90 ; 'Kameha: So you're confident, huh? Let's'
    script_command SCRIPT_SCENE_KAMEHA_KEY_BATTLE
    script_end
Script_58C3::
    script_message $0b95 ; 'Kameha: What? Oh, it's 0. Did'
    script_message $0b93 ; '0 received the Elf Key.'
    script_set_flag $003a
    script_end
Script_58CD::
    script_message $0b95 ; 'Kameha: What? Oh, it's 0. Did'
    script_message $0bc2 ; '0 received the Magic Key.'
    script_set_flag $003a
    script_end
    db $00, $95, $0b, $00, $9a, $0b, $0a, $3a, $00, $ff

Script_58E1::
    script_message $4b8f ; 'Kameha: I've gone to other worlds'
    script_skip_if_no Script_58EA
    script_message $8b91 ; 'Kameha: What? Scared, 0?'
    script_end
Script_58EA::
    script_message $8b90 ; 'Kameha: So you're confident, huh? Let's'
    script_command SCRIPT_SCENE_KAMEHA_KEY_BATTLE_2
    script_end
Script_58EF::
    script_message $0b95 ; 'Kameha: What? Oh, it's 0. Did'
    script_message $0b9d ; '0 received the Traveler Key.'
    script_set_flag $003c
    script_end
Script_58F9::
    script_message $0b95 ; 'Kameha: What? Oh, it's 0. Did'
    script_message $0bc2 ; '0 received the Magic Key.'
    script_set_flag $003c
    script_end
Script_5903::
    script_message $4b7c ; 'King: Oh? It's our savior 0!'
    script_skip_if_no Script_590C
    script_message $8b7e ; 'King: You refuse my request? After'
    script_end
Script_590C::
    script_message $8b7d ; 'King: You will? I knew I'
    script_set_flag $0192
    script_end
Script_5913::
    script_message $0b80 ; 'King: Ah, you've finally caught the'
    script_message $0b81 ; '0 received 10,000G.'
    script_set_flag $0194
    script_end
Script_591D::
    script_message $4b83 ; 'King: Oh? It's our savior 0!'
    script_skip_if_no Script_5926
    script_message $8b7e ; 'King: You refuse my request? After'
    script_end
Script_5926::
    script_message $8b84 ; 'King: You will? I knew I'
    script_set_flag $0195
    script_end
Script_592D::
    script_message $0b80 ; 'King: Ah, you've finally caught the'
    script_message $0b86 ; '0 received 20,000G.'
    script_set_flag $0197
    script_end
Script_5937::
    script_message $4b83 ; 'King: Oh? It's our savior 0!'
    script_skip_if_no Script_5940
    script_message $8b7e ; 'King: You refuse my request? After'
    script_end
Script_5940::
    script_message $8b87 ; 'King: You will? I knew I'
    script_set_flag $0198
    script_end
Script_5947::
    script_message $0b80 ; 'King: Ah, you've finally caught the'
    script_message $0b89 ; '0 received 30,000G.'
    script_set_flag $019a
    script_end
Script_5951::
    script_message $4b83 ; 'King: Oh? It's our savior 0!'
    script_skip_if_no Script_595A
    script_message $8b7e ; 'King: You refuse my request? After'
    script_end
Script_595A::
    script_message $8b8a ; 'King: You will? I knew I'
    script_set_flag $019b
    script_end
Script_5961::
    script_message $0b80 ; 'King: Ah, you've finally caught the'
    script_message $0b8c ; '0 received 40,000G.'
    script_set_flag $019d
    script_end
Script_596B::
    script_set_flag $012a
    script_message $41d0 ; '*: This is a great spot'
    script_skip_if_no Script_5977
    script_message $81d2 ; '*: This talk is too early'
    script_end
Script_5977::
    script_message $81d1 ; '*: Put the Dream Egg on'
    script_end
Script_597B::
    script_message $41d3 ; '*: Have you ever found a'
    script_skip_if_no Script_5984
    script_message $81d2 ; '*: This talk is too early'
    script_end
Script_5984::
    script_message $81d1 ; '*: Put the Dream Egg on'
    script_end
Script_5988::
    script_walk 2, 1, 6
    script_face $00, 3
    script_message $01d4 ; '*: You're the child of the'
    script_slide_y $82
    script_message $0dde ; '*: What? You don't know about'
    script_walk 2, 3, 6
    script_set_flag $0187
    script_end
Script_599F::
    script_message $0d49 ; '*: Here's that TinyMedal.'
    script_message $0d41 ; '0 received a TinyMedal!'
    script_set_flag $01a4
    script_end
Script_59A9::
    script_message $0d44 ; '*: Here it is-the TinyMedal. My'
    script_message $0d41 ; '0 received a TinyMedal!'
    script_set_flag $01a6
    script_end
Script_59B3::
    script_message $40fa ; '*: Hello! What can I do'
    script_jump_data_bank Script_6659
    db $ff

Script_59BA::
    script_message $41bb ; '*: Welcome to our inn!'
    script_jump_data_bank Script_690B
    db $ff

Script_59C1::
    script_message $4144 ; '*: Welcome to my item shop!'
    script_jump_data_bank Script_6707
    db $ff

Script_59C8::
    script_message $4145 ; '*: Hello! How may I serve'
    script_jump_data_bank Script_6707
    db $ff

Script_59CF::
    script_message $4146 ; '*: The church welcomes you. We'
    script_jump_data_bank Script_1F_77D4
    db $ff

Script_59D6::
    script_message $4147 ; '*: I am a servant to'
    script_jump_data_bank Script_1F_77D4
    db $ff

Script_59DD::
    script_message $4148 ; '*: I am the leader of'
    script_skip_if_no Script_59E6
    script_message $814c ; '*: You close the door to'
    script_end
Script_59E6::
    script_message $8149 ; '*: Did you say yes? Yes,'
    script_set_flag $0042
    script_command SCRIPT_SCENE_MONSTER_INSPECTION
    script_face $83, 2
    script_message $0153 ; '*: Very good show! That was'
    script_set_flag $0043
    script_end
Script_59F7::
    script_message $4148 ; '*: I am the leader of'
    script_skip_if_no Script_5A00
    script_message $814c ; '*: You close the door to'
    script_end
Script_5A00::
    script_message $814b ; '*: Did you say yes? Yes,'
    script_set_flag $0042
    script_end
Script_5A07::
    script_message $4148 ; '*: I am the leader of'
    script_skip_if_no Script_5A10
    script_message $814c ; '*: You close the door to'
    script_end
Script_5A10::
    script_message $814a ; '*: Did you say yes? Yes,'
    script_set_flag $0042
    script_end
Script_5A17::
    script_message $014d ; '*: Ah, three healthy monsters! Very'
    script_command SCRIPT_SCENE_MONSTER_INSPECTION
    script_face $83, 2
    script_message $0153 ; '*: Very good show! That was'
    script_set_flag $0043
    script_end
Script_5A25::
    script_message $41bb ; '*: Welcome to our inn!'
    script_jump_data_bank Script_690B
    db $ff

Script_5A2C::
    script_message $4160 ; 'King: Ah, you're the monster tamer'
    script_skip_if_no Script_5A35
    script_message $8d01 ; 'King: Then, you are excused. I'm'
    script_end
Script_5A35::
    script_set_flag $0044
    script_message $8d02 ; 'King: You wish to see our'
    script_command SCRIPT_SCENE_KING_AUDIENCE
    script_message $4161 ; 'King: I see. This is what'
    script_skip_if_no Script_5A45
    script_message $8163 ; 'King: Oh… You won't? Then, I'
    script_end
Script_5A45::
    script_message $8162 ; 'King: Then make way to the'
    script_set_flag $0045
    script_end
Script_5A4C::
    script_message $4165 ; 'King: So? Have you decided to'
    script_skip_if_no Script_5A55
    script_message $8163 ; 'King: Oh… You won't? Then, I'
    script_end
Script_5A55::
    script_message $8162 ; 'King: Then make way to the'
    script_set_flag $0045
    script_end
Script_5A5C::
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
    script_set_flag $0049
    script_end
Script_5A95::
    script_message $0171 ; '*: What? Open the Canal Gate'
    script_command SCRIPT_SCENE_CANAL_GATE
    script_wait 30
    script_walk_fast 0, 2, 2
    script_walk_fast 0, 3, 1
    script_walk_fast 0, 2, 1
    script_hide_object $00
    script_end
Script_5AAB::
    script_message $0175 ; '*: I'm making a new home'
    script_encounter $16 ; encounter words: Beavern, Slime, Slime
    script_message $0176 ; '*: Gaah! You're too strong! You'
    script_face $80, 2
    script_slide_y $80
    script_message $0177 ; 'King: What? So that's the truth?'
    script_face $81, 0
    script_message $0178 ; '*: You will? So we can'
    script_hide_object $01
    script_set_flag $0053
    script_command SCRIPT_SCENE_WATER_SOLVED
    script_set_flag $0054
    script_message $0179 ; 'King: This should solve the water'
    script_walk 0, 0, 3
    script_end
Script_5AD2::
    script_command SCRIPT_SCENE_WATER_REWARD
    script_end
    db $4d, $ff

Script_5AD6::
    script_message $0181 ; 'King: The town's water shortage seems'
    script_set_flag $0055
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
    script_set_flag $0056
    script_end
Script_5B0D::
    script_message $4188 ; '*: Wh-where is everybody? I haven't'
    script_skip_if_no Script_5B16
    script_message $818d ; '*: Tch, what good are you?'
    script_end
Script_5B16::
    script_message $818c ; '0 had no food to give…'
    script_message $018d ; '*: Tch, what good are you?'
    script_end
Script_5B1D::
    script_message $4188 ; '*: Wh-where is everybody? I haven't'
    script_skip_if_no Script_5B26
    script_message $818d ; '*: Tch, what good are you?'
    script_end
Script_5B26::
    script_message $8189 ; '0 handed over some food.'
    script_message $018a ; '*: Munch, munch… Chew, gulp… Fwoaar,'
    script_message $018b ; '0 received a WaterCall.'
    script_message $0d03 ; '*: That will help you for'
    script_command SCRIPT_CHECK_ITEM
    script_set_flag $0057
    script_end
Script_5B37::
    script_set_flag $0058
    script_command SCRIPT_SCENE_MONSTERS_IN_TOW
    script_end
Script_5B3C::
    script_message $0196 ; '*: Heh, you have monsters in'
    script_set_flag $0059
    script_encounter $00 ; encounter words: CurseLamp, Slime, Slime
    script_message $0198 ; '*: You defeated my monster? Urggh…'
    script_command SCRIPT_SCENE_RIVAL_DEFEATED
    script_end
Script_5B49::
    script_message $0197 ; '*: You again! You're determined! But'
    script_encounter $00 ; encounter words: CurseLamp, Slime, Slime
    script_message $0198 ; '*: You defeated my monster? Urggh…'
    script_command SCRIPT_SCENE_RIVAL_DEFEATED
    script_end
Script_5B53::
    script_sound $60
    script_command SCRIPT_SCENE_RIVAL_FADE
    script_end
Script_5B57::
    script_message $415c ; '*: Why are you snooping around?'
    script_skip_if_no Script_5B60
    script_message $815e ; '*: Oh, it looked like you'
    script_end
Script_5B60::
    script_message $815d ; '*: A new plug for the'
    script_end
Script_5B64::
    script_message $4d04 ; '*: Hello, have you found a'
    script_skip_if_no Script_5B6D
    script_message $8d06 ; '*: I can show you my'
    script_end
Script_5B6D::
    script_message $8d05 ; '*: Oh. That's nice. Good for'
    script_end
Script_5B71::
    script_wait 20
    script_command SCRIPT_SCENE_POOR_CHURCH
    script_end
Script_5B76::
    script_message $4da0 ; '*: Our church is impoverished, so'
    script_jump_data_bank Script_1F_77D4
    db $ff

Script_5B7D::
    script_message $4147 ; '*: I am a servant to'
    script_jump_data_bank Script_1F_77D4
    db $ff

Script_5B84::
    script_message $0806 ; '*: …The birds are noisy… It's'
    script_command SCRIPT_SHAKE_SCREEN
    script_message $0807 ; '*: …See? What did I just'
    script_end
Script_5B8C::
    script_message $4809 ; '*: I don't have much but…'
    script_jump_data_bank Script_6707
    db $ff, $ff

Script_5B94::
    script_message $41bb ; '*: Welcome to our inn!'
    script_jump_data_bank Script_690B
    db $ff

Script_5B9B::
    script_message $4818 ; '*: Have you heard the legend'
    script_skip_if_no Script_5BA4
    script_message $881a ; '*: Long ago, a deft craftsman'
    script_end
Script_5BA4::
    script_message $8819 ; '*: Ah, you've heard already. It's'
    script_end
Script_5BA8::
    script_message $4820 ; '*: How may our church serve'
    script_jump_data_bank Script_1F_77D4
    db $ff

Script_5BAF::
    script_message $4823 ; '*: I offer quality merchandise. Would'
    script_jump_data_bank Script_6707
    db $ff

Script_5BB6::
    script_message $082c ; '0 tried to check the chest.'
    script_message $082d ; '*: Whoa! Hands off my merchandise!'
    script_end
Script_5BBD::
    script_message $41bb ; '*: Welcome to our inn!'
    script_jump_data_bank Script_690B
    db $ff

Script_5BC4::
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
Script_5BE8::
    script_message $0838 ; '*: Who are you? This is'
    script_encounter $01 ; encounter words: HoodSquid, Slime, Slime
    script_command SCRIPT_SCENE_WATCH_OUT
    script_set_flag $0066
    script_end
Script_5BF2::
    script_message $0839 ; '*: You can keep trying, but'
    script_encounter $01 ; encounter words: HoodSquid, Slime, Slime
    script_command SCRIPT_SCENE_WATCH_OUT
    script_set_flag $0066
    script_end
Script_5BFC::
    script_command SCRIPT_SCENE_WATCH_OUT
    script_end
Script_5BFE::
    script_message $083a ; '*: Zzz… Zzz… Huh! Watch out!'
    script_slide_y $83
    script_message $483b ; '*: What! Why are you with'
    script_skip_if_no Script_5C0C
    script_message $883e ; '*: It's a tale of high'
    script_end
Script_5C0C::
    script_message $883c ; '*: It was in my callow'
    script_wait 120
    script_message $083d ; '*: The pirates' loot is probably'
    script_set_flag $006d
    script_end
Script_5C19::
    script_message $483f ; '*: What? Are you here for'
    script_skip_if_no Script_5C22
    script_message $8841 ; '*: It's a chance to hear'
    script_end
Script_5C22::
    script_message $8840 ; '*: The pirates stole the MoonRock'
    script_end
Script_5C26::
    script_message $083a ; '*: Zzz… Zzz… Huh! Watch out!'
    script_slide_y $83
    script_message $0dc4 ; '*: What is it? Ah, it's'
    script_end
Script_5C2F::
    script_message $4810 ; '*: In the past, mermaids are'
    script_skip_if_no Script_5C38
    script_message $8817 ; '*: Ah… Shame… Please come again.'
    script_end
Script_5C38::
    script_message $8811 ; '*: Then I'll sing! Lalala~ lala'
    script_command SCRIPT_SCENE_DANCING
    script_message $0816 ; '*: Erm… The sense of rhythm'
    script_end
Script_5C40::
    script_message $4810 ; '*: In the past, mermaids are'
    script_skip_if_no Script_5C49
    script_message $8817 ; '*: Ah… Shame… Please come again.'
    script_end
Script_5C49::
    script_message $8811 ; '*: Then I'll sing! Lalala~ lala'
    script_command SCRIPT_SCENE_MERMAID_SONG
    script_end
Script_5C4E::
    script_message $4810 ; '*: In the past, mermaids are'
    script_skip_if_no Script_5C57
    script_message $8817 ; '*: Ah… Shame… Please come again.'
    script_end
Script_5C57::
    script_message $8811 ; '*: Then I'll sing! Lalala~ lala'
    script_command SCRIPT_SCENE_MERMAID_SONG_2
    script_end
Script_5C5C::
    script_message $4810 ; '*: In the past, mermaids are'
    script_skip_if_no Script_5C65
    script_message $8817 ; '*: Ah… Shame… Please come again.'
    script_end
Script_5C65::
    script_message $8892 ; '*: …Your monsters appear dispirited… It's'
    script_end
Script_5C69::
    script_message $484b ; '*: Do you want to go'
    script_skip_if_no Script_5C72
    script_message $884d ; '*: Come back for a visit'
    script_end
Script_5C72::
    script_message $884c ; '*: Close your eyes a little'
    script_command SCRIPT_WARP_MAP41
    script_end
Script_5C77::
    script_message $0855 ; '*: Welcome, young human. I heard'
    script_set_flag $0070
    script_end
Script_5C7E::
    script_message $0dc5 ; '*: Welcome, my young hero! No'
    script_message $0dc6 ; '0 received the Sailor Ring.'
    script_set_flag $005e
    script_end
Script_5C88::
    script_command SCRIPT_SCENE_SAILOR_RING
    script_end
Script_5C8A::
    script_message $0859 ; '*: How could we die before'
    script_encounter $17 ; encounter words: BoneSlave, Slime, Slime
    script_set_flag $0071
    script_command SCRIPT_SCENE_PIRATE_GHOSTS
    script_end
Script_5C94::
    script_message $085a ; '*: The treasures are ours… No'
    script_encounter $17 ; encounter words: BoneSlave, Slime, Slime
    script_set_flag $0072
    script_command SCRIPT_SCENE_PIRATE_GHOSTS
    script_end
Script_5C9E::
    script_message $085c ; '*: It nags and nags that'
    script_encounter $17 ; encounter words: BoneSlave, Slime, Slime
    script_set_flag $0073
    script_command SCRIPT_SCENE_PIRATE_GHOSTS
    script_end
Script_5CA8::
    script_message $085e ; '*: Who disturbs us in our'
    script_encounter $02 ; encounter words: BoneSlave, CaptDead, BoneSlave
    script_message $0860 ; '*: Child… We have lost… Finally,'
    script_command SCRIPT_GIVE_ITEM_BLINK
    script_set_flag $0075
    script_end
Script_5CB5::
    script_message $085f ; '*: …You seem to not understand…'
    script_encounter $02 ; encounter words: BoneSlave, CaptDead, BoneSlave
    script_message $0860 ; '*: Child… We have lost… Finally,'
    script_command SCRIPT_GIVE_ITEM_BLINK
    script_set_flag $0075
    script_end
Script_5CC2::
    script_message $0887 ; '0 checked the treasure chest. 0'
    script_command SCRIPT_SCENE_CRATE
    script_set_flag $0076
    script_end
Script_5CCA::
    script_message $0863 ; '0 checked the crate. There was'
    script_command SCRIPT_SET_TILES_FLAG_310
    script_end
Script_5CCF::
    script_command SCRIPT_SCENE_KAMEHA_ESCAPE
    script_end
Script_5CD1::
    script_sound $28
    script_message $0868 ; 'Kameha: Wahahahah! Thanks for guiding me'
    script_command SCRIPT_SCENE_KAMEHA_CAUGHT
    script_wait 30
    script_sound $ff
    script_end
Script_5CDD::
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
    script_set_flag $007c
    script_wait 90
    script_sound $ff
    script_end
Script_5D1C::
    script_sound $28
    script_message $086b ; 'Kameha: Arrrrh, clear the way! I'm'
    script_command SCRIPT_SCENE_KAMEHA_FLEES
    script_sound $00
    script_message $0891 ; 'Kameha: Aiyeeeeeh…'
    script_sound $65
    script_wait 90
    script_sound $ff
    script_end
Script_5D2F::
    script_wait 140
    script_command SCRIPT_SCENE_MERMAID_KINGDOM
    script_sound $ff
    script_end
Script_5D36::
    script_message $488e ; '*: This is the mermaid kingdom.'
    script_skip_if_no Script_5D3F
    script_message $8890 ; '*: Oh. Tell me if you'
    script_end
Script_5D3F::
    script_message $888f ; '*: Close your eyes for a'
    script_command SCRIPT_SCENE_TENTACLES
    script_end
Script_5D44::
    script_message $0893 ; 'Thick, suction- cupped tentacles snaked out'
    script_encounter $1e ; encounter words: KingSquid, Slime, Slime
    script_set_flag $00f4
    script_end
Script_5D4D::
    script_message $4da1 ; '*: Our church is impoverished, so'
    script_jump_data_bank Script_1F_77D4
    db $ff

Script_5D54::
    script_message $4147 ; '*: I am a servant to'
    script_jump_data_bank Script_1F_77D4
    db $ff

Script_5D5B::
    script_message $4308 ; '*: Have you heard about the'
    script_skip_if_no Script_5D64
    script_message $830a ; '*: Many years ago, our ancestors'
    script_end
Script_5D64::
    script_message $8309 ; '*: A long time ago the'
    script_end
Script_5D68::
    script_message $4310 ; '*: Welcome! How may I serve'
    script_jump_data_bank Script_6707
    db $ff

Script_5D6F::
    script_message $41bb ; '*: Welcome to our inn!'
    script_jump_data_bank Script_690B
    db $ff

Script_5D76::
    script_message $0316 ; '0 checked the shield. A beautiful'
    script_message $4317 ; '*: I am surprised that you'
    script_skip_if_no Script_5D82
    script_message $831a ; '*: You may think terrible of'
    script_end
Script_5D82::
    script_message $8318 ; '*: You will? No words of'
    script_command SCRIPT_BLINK_SPRITES
    script_set_flag $01e8
    script_end
Script_5D8A::
    script_message $031c ; '*: What is that dirty medal?'
    script_walk 0, 2, 1
    script_hide_object $00
    script_set_flag $0081
    script_end
Script_5D97::
    script_message $0321 ; '*: Ah, you are the spirit's'
    script_set_flag $0083
    script_command SCRIPT_SCENE_SPIRIT_ENVOY
    script_walk 1, 0, 2
    script_set_flag $0082
    script_end
Script_5DA6::
    script_message $0359 ; '*: We reported to the King'
    script_command SCRIPT_SCENE_REPORT_TO_KING
    script_sound $28
    script_set_flag $0087
    script_end
Script_5DB0::
    script_message $4331 ; '*: Welcome! What can I do'
    script_jump_data_bank Script_6659
    db $ff

Script_5DB7::
    script_message $4332 ; '*: Greetings! How shall I serve'
    script_jump_data_bank Script_6707
    db $ff

Script_5DBE::
    script_message $4333 ; '*: Hello! Have a look at'
    script_jump_data_bank Script_6707
    db $ff

Script_5DC5::
    script_message $41bb ; '*: Welcome to our inn!'
    script_jump_data_bank Script_690B
    db $ff

Script_5DCC::
    script_message $4820 ; '*: How may our church serve'
    script_jump_data_bank Script_1F_77D4
    db $ff

Script_5DD3::
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
    script_set_flag $0086
    script_end
Script_5E02::
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
    script_set_flag $0086
    script_end
Script_5E2F::
    script_message $0360 ; '0 tapped on the wall. The'
    script_face $81, 2
    script_command SCRIPT_SCENE_WALL_EXIT
    script_end
Script_5E37::
    script_message $0363 ; '0 tapped on the wall. Sound'
    script_face $81, 2
    script_command SCRIPT_SCENE_WALL_EXIT
    script_message $0364 ; 'Kameha: That's it! That's the exit!'
    script_walk_fast 1, 2, 3
    script_hide_object $01
    script_wait 30
    script_set_flag $008a
    script_sound $ff
    script_walk_fast 0, 3, 4
    script_walk_fast 0, 2, 5
    script_hide_object $00
    script_end
Script_5E5A::
    script_command SCRIPT_SCENE_REAL_KING
    script_message $0365 ; '*: I'm the real King, you'
    script_slide_y $81
    script_message $0366 ; '*: What? How dare you, impostor!'
    script_set_flag $008b
    script_end
Script_5E67::
    script_message $0370 ; '*: Arrgh, you've ruined my plan'
    script_command SCRIPT_SCENE_PLAN_RUINED
    script_face $81, 2
    script_slide_y $81
    script_message $0374 ; '*: Bravo! We're saved! Thank you'
    script_set_flag $0094
    script_end
Script_5E77::
    script_message $0372 ; '*: It almost worked to perfection!'
    script_command SCRIPT_SCENE_PLAN_RUINED
    script_face $81, 2
    script_slide_y $81
    script_message $0374 ; '*: Bravo! We're saved! Thank you'
    script_set_flag $0094
    script_end
Script_5E87::
    script_message $41bb ; '*: Welcome to our inn!'
    script_jump_data_bank Script_690B
    db $ff

Script_5E8E::
    script_message $438b ; '*: Hello! How may I serve'
    script_jump_data_bank Script_6707
    db $ff

Script_5E95::
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
    script_set_flag $0095
    script_end
Script_5EE6::
    script_message $039d ; '*: You're here to cheer Lady'
    script_walk 0, 2, 1
    script_walk 0, 1, 1
    script_face $80, 0
    script_end
Script_5EF5::
    script_sound $28
    script_command SCRIPT_SCENE_CHEER_YUNA
    script_message $03a2 ; 'King: Magnificent! Don't you agree?'
    script_face $80, 1
    script_message $03a3 ; '*: …………'
    script_face $80, 0
    script_message $03a4 ; 'King: …Sigh… Not even this… You'
    script_set_flag $0096
    script_end
Script_5F0B::
    script_message $43b3 ; '*: Hello! What may I do'
    script_jump_data_bank Script_6707
    db $ff

Script_5F12::
    script_message $43b5 ; '*: I retired as a teacher'
    script_skip_if_no Script_5F1B
    script_message $83b7 ; '*: Oh, you're rushed for time…'
    script_end
Script_5F1B::
    script_message $83b6 ; '*: Lady Yuna was a rambunctious'
    script_end
Script_5F1F::
    script_message $41bb ; '*: Welcome to our inn!'
    script_jump_data_bank Script_690B
    db $ff

Script_5F26::
    script_message $03b0 ; '*: This is no place for'
    script_slide_y $80
    script_message $03b1 ; '*: Oh? An envoy from the'
    script_walk 0, 2, 1
    script_hide_object $00
    script_set_flag $0097
    script_end
Script_5F38::
    script_message $03b0 ; '*: This is no place for'
    script_slide_y $81
    script_message $03b1 ; '*: Oh? An envoy from the'
    script_walk 1, 2, 1
    script_hide_object $01
    script_set_flag $0097
    script_end
Script_5F4A::
    script_command SCRIPT_SCENE_SPIRIT_ENVOY_2
    script_end
Script_5F4C::
    script_message $0d4c ; '*: …………? You startled me… I'
    script_command SCRIPT_GIVE_ITEM_BLINK
    script_set_flag $009a
    script_end
Script_5F54::
    script_message $4ab5 ; '*: …………? You startled me… I'
    script_set_flag $009a
    script_skip_if_no Script_5F61
    script_message $8ac9 ; '*: Oh… How terribly disappointing. I'll'
    script_command SCRIPT_GIVE_ITEM_BLINK
    script_end
Script_5F61::
    script_message $8ab6 ; '*: You will? Thank you! Let'
    script_set_flag $009b
    script_command SCRIPT_GIVE_ITEM_BLINK
    script_message $0ab7 ; '0 obtained YunaSoul.'
    script_end
Script_5F6C::
    script_message $4ab5 ; '*: …………? You startled me… I'
    script_set_flag $009a
    script_skip_if_no Script_5F79
    script_message $8ac9 ; '*: Oh… How terribly disappointing. I'll'
    script_command SCRIPT_GIVE_ITEM_BLINK
    script_end
Script_5F79::
    script_message $8ac8 ; '*: You will? Thank you! Let'
    script_end
Script_5F7D::
    script_message $0d4d ; '*: I don't remember who I'
    script_command SCRIPT_GIVE_ITEM_BLINK
    script_end
Script_5F82::
    script_message $4aca ; '*: I don't remember who I'
    script_skip_if_no Script_5F8C
    script_message $8ac9 ; '*: Oh… How terribly disappointing. I'll'
    script_command SCRIPT_GIVE_ITEM_BLINK
    script_end
Script_5F8C::
    script_message $8ab6 ; '*: You will? Thank you! Let'
    script_set_flag $009b
    script_command SCRIPT_GIVE_ITEM_BLINK
    script_message $0ab7 ; '0 obtained YunaSoul.'
    script_end
Script_5F97::
    script_message $4aca ; '*: I don't remember who I'
    script_skip_if_no Script_5FA1
    script_message $8ac9 ; '*: Oh… How terribly disappointing. I'll'
    script_command SCRIPT_GIVE_ITEM_BLINK
    script_end
Script_5FA1::
    script_message $8ac8 ; '*: You will? Thank you! Let'
    script_end
Script_5FA5::
    script_message $0d3c ; '*: …………!'
    script_message $0ad1 ; '*: …… STOP… DON'T MEDDLE…'
    script_command SCRIPT_SCENE_PRINCESS_MEDICINE
    script_end
Script_5FAD::
    script_message $03a3 ; '*: …………'
    script_message $0dd2 ; 'The princess did not reply. But'
    script_message $0ad3 ; '*: FOOLHARDY. BRAVE BUT FOOLISH.'
    script_command SCRIPT_SCENE_PRINCESS_MEDICINE
    script_end
Script_5FB8::
    script_message $0aea ; '*: Pardon me? You have medicine?'
    script_walk 2, 1, 2
    script_hide_object $02
    script_hold_dpad $01, 3
    script_command SCRIPT_SCENE_MEDICINE_GIVEN
    script_set_flag $01f1
    script_end
Script_5FC9::
    script_command SCRIPT_SCENE_SHIELD_GUARDIAN
    script_end
Script_5FCB::
    script_command SCRIPT_SCENE_SHIELD_GUARDIAN
    script_end
Script_5FCD::
    script_message $0a01 ; '0 checked the shield.'
    script_command SCRIPT_SCENE_SHIELD
    script_end
Script_5FD2::
    script_command SCRIPT_SCENE_SHIELD
    script_end
Script_5FD4::
    script_command SCRIPT_SCENE_SHIELD_2
    script_end
Script_5FD6::
    script_message $4820 ; '*: How may our church serve'
    script_jump_data_bank Script_1F_77D4
    db $ff

Script_5FDD::
    script_message $0319 ; '0 checked the treasure chest. 0'
    script_hide_object $01
    script_set_flag $0080
    script_end
Script_5FE6::
    script_command SCRIPT_SCENE_CHEST_SERVANT
    script_end
Script_5FE8::
    script_message $442e ; '*: How may we serve your'
    script_jump_data_bank Script_1F_77D4
    db $ff

Script_5FEF::
    script_message $040b ; '0 checked the grave. There was'
    script_command SCRIPT_SCENE_GRAVE
    script_set_flag $00a0
    script_end
Script_5FF7::
    script_message $040b ; '0 checked the grave. There was'
    script_command SCRIPT_SCENE_GRAVE
    script_end
Script_5FFC::
    script_message $0411 ; '*: …Fine! You've done well to'
    script_sound $66
    script_command SCRIPT_SET_TILES_D2
    script_end
Script_6003::
    script_message $41bb ; '*: Welcome to our inn!'
    script_jump_data_bank Script_690B
    db $ff

Script_600A::
    script_message $0412 ; '*: Kweeeeh!'
    script_message $0de6 ; 'Look! A MadCondor! It has something!'
    script_command SCRIPT_SCENE_MADCONDOR
    script_set_flag $00a4
    script_end
Script_6015::
    script_message $041d ; '*: Hm? You're from the village!'
    script_walk 0, 1, 1
    script_face $80, 3
    script_end
Script_6020::
    script_message $4426 ; '*: You… Are you a monster?'
    script_skip_if_no Script_6029
    script_message $8428 ; '*: Uh-huh… You look uh… delicious.'
    script_end
Script_6029::
    script_message $8427 ; '*: Uh-huh… You don't look very'
    script_end
Script_602D::
    script_message $4426 ; '*: You… Are you a monster?'
    script_skip_if_no Script_6036
    script_message $8428 ; '*: Uh-huh… You look uh… delicious.'
    script_end
Script_6036::
    script_message $8429 ; '*: Any way you want to'
    script_end
Script_603A::
    script_message $442e ; '*: How may we serve your'
    script_jump_data_bank Script_1F_77D4
    db $ff

Script_6041::
    script_message $442d ; '*: Good day. How may I'
    script_jump_data_bank Script_6707
    db $ff

Script_6048::
    script_message $4432 ; '*: Welcome to the traveler's inn.'
    script_jump_data_bank Script_690B
    db $ff

Script_604F::
    script_message $0433 ; '*: Kweeeeeh!'
    script_command SCRIPT_SCENE_MADCONDOR_CRY
    script_encounter $05 ; encounter words: MadCondor, Slime, Slime
    script_set_flag $00a8
    script_end
Script_6059::
    script_message $0433 ; '*: Kweeeeeh!'
    script_encounter $05 ; encounter words: MadCondor, Slime, Slime
    script_set_flag $00a8
    script_end
Script_6062::
    script_message $4439 ; '*: I've lived here for 200'
    script_skip_if_no Script_606B
    script_message $843b ; '*: Oh… You won't humor an'
    script_end
Script_606B::
    script_message $843a ; '*: This area had been prosperous,'
    script_end
Script_606F::
    script_message $4447 ; '*: Want to know the most'
    script_skip_if_no Script_6078
    script_message $8449 ; '*: I see. You wish to'
    script_end
Script_6078::
    script_message $8448 ; '*: Walk. Learn to walk everywhere.'
    script_end
Script_607C::
    script_message $444b ; '*: Welcome! How may I serve'
    script_jump_data_bank Script_6707
    db $ff

Script_6083::
    script_message $444c ; '*: How may our church help'
    script_jump_data_bank Script_1F_77D4
    db $ff, $00, $51, $44, $e7, $0b, $69, $ff

Script_6091::
    script_message $045a ; '0 checked the small hole. It'
    script_command SCRIPT_SCENE_SMALL_HOLE
    script_end
Script_6096::
    script_message $045d ; '*: You can take this treasure,'
    script_set_flag $00ad
    script_encounter $06 ; encounter words: Metabble, Slime, Slime
    script_message $045f ; '*: Heh, you're not half bad!'
    script_walk 0, 0, 2
    script_walk 0, 3, 2
    script_hide_object $00
    script_set_flag $00ae
    script_command SCRIPT_HIDE_SPRITES
    script_end
Script_60B0::
    script_message $045e ; '*: I'm up for your challenge'
    script_encounter $06 ; encounter words: Metabble, Slime, Slime
    script_message $045f ; '*: Heh, you're not half bad!'
    script_walk 0, 0, 2
    script_walk 0, 3, 2
    script_hide_object $00
    script_set_flag $00ae
    script_command SCRIPT_HIDE_SPRITES
    script_end
Script_60C7::
    script_message $0460 ; '*: Let the power of justice'
    script_encounter $07 ; encounter words: Skeletor, Slime, Slime
    script_command SCRIPT_SCENE_JUSTICE_2
    script_end
Script_60CE::
    script_command SCRIPT_SCENE_JUSTICE
    script_end
Script_60D0::
    script_sound $9b
    script_command SCRIPT_SCENE_GRAVESTONE
    script_end
Script_60D4::
    script_message $4464 ; '0 checked the gravestone. There was'
    script_skip_if_no Script_60DD
    script_message $849f ; '0 released the grave's button.'
    script_end
Script_60DD::
    script_sound $66
    script_wait 60
    script_message $8465 ; 'A door opened somewhere…'
    script_command SCRIPT_SET_FLAG_322
    script_set_flag $00b2
    script_end
Script_60EA::
    script_message $0466 ; '*: You overcame the traps I'
    script_set_flag $00b3
    script_encounter $08 ; encounter words: Niterich, Slime, Slime
    script_message $0468 ; '*: You've beaten me fairly… Take'
    script_command SCRIPT_SCENE_BEATEN_FAIRLY
    script_set_flag $00b4
    script_set_flag $00c5
    script_set_flag $00c6
    script_set_flag $00c7
    script_end
Script_6103::
    script_message $0467 ; '*: Wahahahah! Here again, are you?'
    script_encounter $08 ; encounter words: Niterich, Slime, Slime
    script_message $0468 ; '*: You've beaten me fairly… Take'
    script_command SCRIPT_SCENE_BEATEN_FAIRLY
    script_set_flag $00b4
    script_set_flag $00c5
    script_set_flag $00c6
    script_set_flag $00c7
    script_end
Script_6119::
    script_message $0469 ; '*: What? You have the three'
    script_walk 0, 2, 1
    script_hide_object $00
    script_set_flag $00b6
    script_end
Script_6126::
    script_message $0471 ; '*: I'm surprised anyone managed to'
    script_command SCRIPT_SCENE_FOUND_ME
    script_face $80, 0
    script_set_flag $00b8
    script_end
Script_6131::
    script_command SCRIPT_SCENE_FOUND_ME_BATTLE
    script_end
Script_6133::
    script_message $047a ; '*: Ah, so good of you'
    script_message $447b ; '0 handed over the Heaven Helmet.'
    script_message $c47c ; '0 handed over the Heaven Armor.'
    script_message $847d ; '0 handed over the Heaven Sword.'
    script_message $047e ; '*: Good. You have brought the'
    script_set_flag $00c0
    script_command SCRIPT_SCENE_THREE_ITEMS_BATTLE
    script_set_flag $00c1
    script_end
Script_614A::
    script_message $047f ; '*: Fwahahaha! Don't you ever give'
    script_command SCRIPT_SCENE_THREE_ITEMS_BATTLE
    script_set_flag $00c1
    script_end
Script_6152::
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
Script_618B::
    script_sound $65
    script_walk 1, 0, 4
    script_wait 10
    script_set_flag $00c4
    script_end
Script_6198::
    script_message $04a7 ; '*: ……This way… …Here… …Here…'
    script_command SCRIPT_SCENE_THIS_WAY
    script_end
Script_619D::
    script_message $4550 ; '*: I heard from Lord Darck,'
    script_skip_if_no Script_61A6
    script_message $855d ; '*: You didn't bring the treasures?'
    script_end
Script_61A6::
    script_message $855c ; '*: How dare you come without'
    script_end
Script_61AA::
    script_message $4550 ; '*: I heard from Lord Darck,'
    script_skip_if_no Script_61B3
    script_message $855d ; '*: You didn't bring the treasures?'
    script_end
Script_61B3::
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
    script_set_flag $00d2
    script_encounter $1d ; encounter words: Centasaur, GigaDraco, Garudian
    script_message $0556 ; '*: N… No… How could my'
    script_command SCRIPT_SCENE_DARCK_TAUNT
    script_set_flag $00d3
    script_end
Script_61DC::
    script_message $0555 ; '*: You seem to still not'
    script_encounter $1d ; encounter words: Centasaur, GigaDraco, Garudian
    script_message $0556 ; '*: N… No… How could my'
    script_command SCRIPT_SCENE_DARCK_TAUNT
    script_set_flag $00d3
    script_end
Script_61E9::
    script_message $0557 ; 'Darck: Fawahahah! You chased your treasures'
    script_set_flag $00d0
    script_encounter $0a ; encounter words: Darck, Slime, Slime
    script_message $0559 ; 'Darck: …Wha… What? How could I…'
    script_command SCRIPT_SCENE_DARCK_DEFEATED
    script_end
Script_61F6::
    script_message $0558 ; 'Darck: Fwahahahah! Bravo! Splendid! You've come'
    script_encounter $0a ; encounter words: Darck, Slime, Slime
    script_message $0559 ; 'Darck: …Wha… What? How could I…'
    script_command SCRIPT_SCENE_DARCK_DEFEATED
    script_end
Script_6200::
    script_face $80, 0
    script_command SCRIPT_SCENE_CYAL_SHINE
    script_walk 0, 2, 5
    script_set_flag $0140
    script_end
Script_620C::
    script_message $0704 ; '*: So Cyal took a shine'
    script_slide_y $81
    script_message $0705 ; 'Cyal: Yay, you'll be my friend?'
    script_set_flag $0143
    script_end
Script_6218::
    script_message $0710 ; '*: Well, well, a human here'
    script_command SCRIPT_SCENE_ROLT_ELDER
    script_message $0711 ; 'Rolt: That was fast, 0. I'
    script_slide_y $82
    script_message $0712 ; 'Cyal: 0, let's play! I want'
    script_walk 2, 0, 2
    script_set_flag $0146
    script_end
Script_622C::
    script_message $0713 ; '*: I'm the village's elder. What's'
    script_command SCRIPT_SCENE_ROLT_ELDER
    script_message $0711 ; 'Rolt: That was fast, 0. I'
    script_slide_y $82
    script_message $0712 ; 'Cyal: 0, let's play! I want'
    script_walk 2, 0, 2
    script_set_flag $0146
    script_end
Script_6240::
    script_message $0716 ; 'Cyal: Listen, 0. We should go'
    script_walk_fast 2, 0, 4
    script_set_flag $0147
    script_end
Script_624B::
    script_face $80, 0
    script_slide_y $80
    script_message $071d ; 'Cyal: Oh! 0! I'm over here!'
    script_walk_fast 0, 2, 5
    script_wait 30
    script_face $00, 0
    script_message $071e ; '0 counted off…'
    script_wait 30
    script_message $071f ; 'Cyal: Eeek, 0! Help me!'
    script_set_flag $0148
    script_end
Script_626A::
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
    script_set_flag $0149
    script_end
Script_6290::
    script_message $0724 ; '*: That's what we'll do, kid.'
    script_set_flag $014a
    script_encounter $09 ; encounter words: ArrowDog, ArrowDog, Slime
    script_message $0754 ; '*: …Too strong… Arroooh!'
    script_command SCRIPT_SCENE_TOO_STRONG
    script_set_flag $014b
    script_end
Script_62A0::
    script_message $0727 ; '*: You've come back again, ruff?'
    script_encounter $09 ; encounter words: ArrowDog, ArrowDog, Slime
    script_message $0754 ; '*: …Too strong… Arroooh!'
    script_command SCRIPT_SCENE_TOO_STRONG
    script_set_flag $014b
    script_end
Script_62AD::
    script_message $0728 ; 'Rolt: What? Cyal was abducted? Who'
    script_walk_fast 1, 0, 7
    script_slide_y $80
    script_message $0729 ; '*: Rolt, wait! …Gone already…'
    script_set_flag $014c
    script_end
Script_62BD::
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
    script_set_flag $0151
    script_set_flag $0203
    script_command SCRIPT_SCENE_CYAL_ROLT
    script_face $80, 3
    script_message $0741 ; '*: I'm glad that Cyal and'
    script_end
Script_6313::
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
    script_set_flag $0151
    script_set_flag $0203
    script_command SCRIPT_SCENE_CYAL_ROLT
    script_face $80, 3
    script_message $0741 ; '*: I'm glad that Cyal and'
    script_end
Script_6369::
    script_message $0734 ; 'Rolt: I've found you at last!'
    script_message $0735 ; '*: Kikiki, what just you? That's'
    script_message $0736 ; 'Rolt: Shut up! Give back Cyal!'
    script_walk_fast 2, 2, 2
    script_command SCRIPT_SCENE_GIVE_BACK_CYAL
    script_set_flag $014f
    script_end
Script_637B::
    script_message $470e ; '*: Welcome! How may I help'
    script_jump_data_bank Script_6707
    db $ff

Script_6382::
    script_set_flag $0142
    script_message $4703 ; '*: Are you maybe a human?'
Script_6388::
    script_skip_if_no Script_6392
    script_slide_y $81
    script_message $cc57 ; '*: Oh, don't lie! You don't'
    script_jump Script_6388
Script_6392::
    script_slide_y $81
    script_message $8c56 ; '*: Really! Wow! You're the first'
    script_end
Script_6398::
    script_slide_y $80
    script_message $4759 ; '*: Hoh? Ah, excuse my incivility.'
    script_skip_if_no Script_63A6
    script_message $875d ; 'Kiral: No? How disappointing. Your efforts'
    script_set_flag $0159
    script_end
Script_63A6::
    script_message $875b ; 'Kiral: Hohoh! Grand, grand! Go fetch'
    script_walk 0, 3, 2
    script_face $80, 1
    script_wait 30
    script_slide_y $80
    script_message $075c ; 'Kiral: Oh! Foolish of me, I'
    script_set_flag $015a
    script_end
Script_63BC::
    script_message $475e ; 'Kiral: I need help with my'
    script_skip_if_no Script_63C5
    script_message $875d ; 'Kiral: No? How disappointing. Your efforts'
    script_end
Script_63C5::
    script_message $875b ; 'Kiral: Hohoh! Grand, grand! Go fetch'
    script_walk 0, 3, 2
    script_face $80, 1
    script_wait 30
    script_slide_y $80
    script_message $075c ; 'Kiral: Oh! Foolish of me, I'
    script_set_flag $015a
    script_end
Script_63DB::
    script_message $0767 ; '0 peered into the barrel. A'
    script_encounter $1f ; encounter words: Shadow, Slime, Slime
    script_set_flag $015d
    script_end
Script_63E4::
    script_message $0767 ; '0 peered into the barrel. A'
    script_encounter $1f ; encounter words: Shadow, Slime, Slime
    script_set_flag $015e
    script_end
Script_63ED::
    script_message $0769 ; '*: PROFESSOR… SAY GUARD… TREASURE… NEVER…'
    script_message $076a ; 'Roboster is acting strangely. It appears'
    script_end
Script_63F4::
    script_message $076d ; '*: PRO… SOR… AY… GGGGUARD… TREZZZT…'
    script_message $076e ; 'Its damage appears to have worsened.'
    script_end
Script_63FB::
    script_message $0770 ; '*: PIPIPI… GGGGGGAGAGAGA…'
    script_message $0771 ; 'Roboster is acting bizarrely. It appears'
    script_end
Script_6402::
    script_message $0773 ; '*: PI… PI…'
    script_message $0774 ; 'Roboster is acting as if demented.'
    script_end
Script_6409::
    script_message $0776 ; 'Kiral: Ah! Back! The treasure? What?'
    script_wait 30
    script_message $0777 ; 'Kiral: Please… Go stop him. He'
    script_set_flag $0162
    script_end
Script_6416::
    script_message $076b ; '0 peered into the barrel. There'
    script_command SCRIPT_SCENE_BARREL
    script_end
Script_641B::
    script_message $077d ; 'Kiral: Ah! Back! Is… Rob-N… Did'
    script_message $077e ; '0 handed over the blue stone.'
    script_message $077f ; 'Kiral: This stone, the WizStone, it'
    script_walk_fast 0, 1, 3
    script_command SCRIPT_SCENE_WIZSTONE
    script_set_flag $0165
    script_set_flag $0204
    script_end
Script_6430::
    script_message $0795 ; '*: Sigh…'
    script_message $0796 ; 'The old man's sigh sounded sad…'
    script_end
Script_6437::
    script_message $0797 ; '*: Sigh…'
    script_message $0798 ; 'The old woman's sigh was desolate…'
    script_end
Script_643E::
    script_message $479d ; '*: Hello! What may I do'
    script_jump_data_bank Script_6707
    db $ff

Script_6445::
    script_message $479e ; '*: Welcome to our traveler's inn.'
    script_jump_data_bank Script_690B
    db $ff

Script_644C::
    script_slide_y $81
    script_message $47a0 ; '*: Excuse me, are you a'
    script_skip_if_no Script_645A
    script_message $87a2 ; '*: I can't count on your'
    script_set_flag $01b0
    script_end
Script_645A::
    script_message $87a1 ; '*: Thank you! I knew you'
    script_walk 1, 3, 2
    script_walk 1, 0, 6
    script_set_flag $01b1
    script_end
Script_6469::
    script_message $47a3 ; '*: Have you changed your mind?'
    script_skip_if_no Script_6472
    script_message $87a2 ; '*: I can't count on your'
    script_end
Script_6472::
    script_message $87a1 ; '*: Thank you! I knew you'
    script_walk 1, 3, 2
    script_walk 1, 0, 6
    script_set_flag $01b1
    script_end
Script_6481::
    script_message $47ab ; '*: Lately, the town of Miagen'
    script_skip_if_no Script_648A
    script_message $87ad ; '*: You didn't know? Well, listen'
    script_end
Script_648A::
    script_message $87ac ; '*: It's rumored that monsters raid'
    script_end
Script_648E::
    script_message $07b6 ; '*: This pendant is yours for'
    script_command SCRIPT_SCENE_PENDANT_SELLER
    script_set_flag $01b9
    script_end
Script_6496::
    script_set_flag $01ba
    script_message $07b9 ; '*: You're going to regret seeing'
    script_encounter $11 ; encounter words: Pixy, Pixy, Slime
    script_message $07bc ; '*: Please! Mercy! Spare us! Take'
    script_command SCRIPT_SCENE_MERCY
    script_set_flag $01bb
    script_end
Script_64A6::
    script_message $07bb ; '*: We'll smash you as often'
    script_encounter $11 ; encounter words: Pixy, Pixy, Slime
    script_message $07bc ; '*: Please! Mercy! Spare us! Take'
    script_command SCRIPT_SCENE_MERCY
    script_set_flag $01bb
    script_end
Script_64B3::
    script_message $07bd ; '0 opened the treasure chest. 0'
    script_hide_object $00
    script_hide_object $02
    script_set_flag $01bc
    script_end
Script_64BE::
    script_message $07c3 ; '*: For 47,000G this earring… What?'
    script_slide_y $81
    script_message $07c4 ; '*: You defeated the monsters? You're'
    script_set_flag $01bd
    script_end
Script_64CA::
    script_message $07ca ; '0 showed the Pretty Ring.'
    script_slide_y $80
    script_message $07cb ; '*: Ah… That ring… Is… Is'
    script_message $07cc ; '0 handed over the Pretty Ring.'
    script_message $07cd ; '*: Thank you for getting the'
    script_set_flag $01be
    script_end
Script_64DC::
    script_message $07cf ; '*: Thank you for recovering our'
    script_message $07d1 ; '0 received a SageRock. But there'
    script_end
Script_64E3::
    script_message $07cf ; '*: Thank you for recovering our'
    script_message $07d0 ; '0 received a SageRock.'
    script_set_flag $01bf
    script_end
Script_64ED::
    script_message $07da ; '*: What? Where I get my'
    script_command SCRIPT_SCENE_PENDANT_SELLER
    script_walk_fast 1, 0, 2
    script_walk_fast 1, 1, 1
    script_walk_fast 1, 0, 4
    script_set_flag $01c0
    script_end
Script_6501::
    script_message $07dc ; 'Milayou: I thought this forest looked'
    script_command SCRIPT_SCENE_MILAYOU_FOREST
    script_set_flag $01c1
    script_end
Script_6509::
    script_set_flag $01c2
    script_message $0cde ; '*: What is it, you little'
    script_encounter $12 ; encounter words: Copycat, StoneMan, WhipBird
    script_message $0ce0 ; '*: But… No! I lost to'
    script_command SCRIPT_KEY_BOSS_BEATEN_2
    script_walk 1, 2, 2
    script_face $00, 0
    script_message $0ce1 ; 'Milayou: You are really special. I'
    script_walk 1, 0, 2
    script_hide_object $01
    script_set_flag $01c3
    script_set_flag $0205
    script_end
Script_652C::
    script_message $0cdf ; '*: What is it, you little'
    script_encounter $12 ; encounter words: Copycat, StoneMan, WhipBird
    script_message $0ce0 ; '*: But… No! I lost to'
    script_command SCRIPT_KEY_BOSS_BEATEN_2
    script_walk 1, 2, 2
    script_face $00, 0
    script_message $0ce1 ; 'Milayou: You are really special. I'
    script_walk 1, 0, 2
    script_hide_object $01
    script_set_flag $01c3
    script_set_flag $0205
    script_end
Script_654C::
    script_message $0cef ; 'Milayou: I asked for your support'
    script_slide_y $00
    script_message $0cf0 ; 'Milayou: How do I know about'
    script_set_flag $01c4
    script_end
Script_6558::
    script_set_flag $01c6
    script_message $4cf5 ; 'Milayou: I knew you come back!'
    script_skip_if_no Script_6564
    script_message $8cf7 ; 'Milayou: Oh… I'm disappointed… Come again'
    script_end
Script_6564::
    script_message $8cf6 ; 'Milayou: Great! No holding back!'
    script_encounter $13 ; encounter words: MetalKing, RainHawk, Coatol
    script_message $0cf9 ; 'Milayou: I lost… But, good battle!'
    script_walk 1, 3, 2
    script_walk 1, 0, 6
    script_set_flag $01c7
    script_end
Script_6578::
    script_message $4cf8 ; 'Milayou: Want to spar with me?'
    script_skip_if_no Script_6581
    script_message $8cf7 ; 'Milayou: Oh… I'm disappointed… Come again'
    script_end
Script_6581::
    script_message $8cf6 ; 'Milayou: Great! No holding back!'
    script_encounter $13 ; encounter words: MetalKing, RainHawk, Coatol
    script_message $0cf9 ; 'Milayou: I lost… But, good battle!'
    script_walk 1, 3, 2
    script_walk 1, 0, 6
    script_set_flag $01c7
    script_end
Script_6595::
    script_message $0c48 ; '0 checked the treasure chest. The'
    script_encounter $32 ; encounter words: Mimic, Slime, Slime
    script_command SCRIPT_SET_FLAG_REDRAW
    script_end
Script_659C::
    script_command SCRIPT_SCENE_CHEST_BATTLE
    script_end
Script_659E::
    script_message $0c49 ; '0 checked the treasure chest. It'
    script_command SCRIPT_SCENE_YOU_DID_IT
    script_end
Script_65A3::
    script_message $4123 ; 'Warubou: Wa-hey! You did it, 0!'
    script_jump_data_bank Script_6707
    db $ff

Script_65AA::
    script_message $4124 ; 'Warubou: Wa-hey! You did it, 0!'
    script_jump_data_bank Script_690B
    db $ff

Script_65B1::
    script_message $4128 ; 'Warubou: Wa-hey! That's it! GreatLog is'
    script_jump_data_bank Script_690B
    db $ff

Script_65B8::
    script_message $4127 ; 'Warubou: Wa-hey! So, this is it?'
    script_jump_data_bank Script_1F_77D4
    db $ff

; runs one frame of script command type E0 (entry 223 of ScriptCommandHandlers)
ScriptCommandE0::
    farcall InnMenu
    ret

; runs one frame of script command type E1 (entry 224 of ScriptCommandHandlers)
ScriptCommandE1::
    farcall CloseInnMenu
    ret

; runs one frame of script command type E2 (entry 225 of ScriptCommandHandlers)
ScriptCommandE2::
    farcall ShopMenu
    ret

; runs one frame of script command type E3 (entry 226 of ScriptCommandHandlers)
ScriptCommandE3::
    farcall CloseShopMenu
    ret

; runs one frame of script command type E5 (entry 228 of ScriptCommandHandlers)
ScriptCommandE5::
    farcall VaultMenu
    ret

; runs one frame of script command type E6 (entry 229 of ScriptCommandHandlers)
ScriptCommandE6::
    farcall CloseVaultMenu
    ret

; runs one frame of script command type E8 (entry 231 of ScriptCommandHandlers)
ScriptCommandE8::
    farcall SwapMonstersMenu
    ret

; runs one frame of script command type E9 (entry 232 of ScriptCommandHandlers)
ScriptCommandE9::
    farcall CloseMenuE9
    ret

; runs one frame of script command type EB (entry 234 of ScriptCommandHandlers)
ScriptCommandEB::
    farcall HibernateMenu
    ret

; runs one frame of script command type EC (entry 235 of ScriptCommandHandlers)
ScriptCommandEC::
    farcall CloseHibernateMenu
    ret

; runs one frame of script command type ED (entry 236 of ScriptCommandHandlers)
ScriptCommandED::
    farcall BreedMenu
    ret

; runs one frame of script command type EE (entry 237 of ScriptCommandHandlers)
ScriptCommandEE::
    farcall CloseBreedMenu
    ret

; runs one frame of script command type EF (entry 238 of ScriptCommandHandlers)
ScriptCommandEF::
    farcall EggServiceMenu
    ret

; runs one frame of script command type F0 (entry 239 of ScriptCommandHandlers)
ScriptCommandF0::
    farcall RenameMenu
    ret

; runs one frame of script command type F1 (entry 240 of ScriptCommandHandlers)
ScriptCommandF1::
    farcall CloseRenameMenu
    ret

; runs one frame of script command type F2 (entry 241 of ScriptCommandHandlers)
ScriptCommandF2::
    farcall KeyAppraisalMenu
    ret

; runs one frame of script command type F3 (entry 242 of ScriptCommandHandlers)
ScriptCommandF3::
    farcall MedalPrizeMenu
    ret

; runs one frame of script command type F4 (entry 243 of ScriptCommandHandlers)
ScriptCommandF4::
    farcall NpcBreedMenu
    ret

; far-calls ScriptCommandE9_RunFar (E-0126)
CallScriptCommandE9Far::
    farcall ScriptCommandE9_RunFar
    ret

; runs one frame of script command type F6 (entry 245 of ScriptCommandHandlers)
ScriptCommandF6::
    farcall LibraryMenu
    ret

; runs one frame of script command type F7 (entry 246 of ScriptCommandHandlers)
ScriptCommandF7::
    farcall ArenaMenu
    ret

; runs one frame of script command type F8 (entry 247 of ScriptCommandHandlers)
ScriptCommandF8::
    farcall PriestMenu
    ret

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_6659::
    script_command SCRIPT_SHOP
    script_command SCRIPT_SHOP
Script_665B::
    script_command SCRIPT_SHOP
    script_choice_jump Script_667D, Script_667A, Script_6674, Script_6662, Script_666B
Script_6662::
    script_message $c007 ; '*: You have no more room'
    script_message $c008 ; '*: Is there anything else?'
    script_jump Script_665B
Script_666B::
    script_message $c00f ; '*: You have no items to'
    script_message $c008 ; '*: Is there anything else?'
    script_jump Script_665B
Script_6674::
    script_command SCRIPT_SHOP_CLOSE
    script_message $8012 ; '*: Thank you! Please come again.'
    script_command SCRIPT_SHOP_CLOSE
    script_end
Script_667A::
    script_jump Script_66C9
Script_667D::
    script_message $c006 ; '*: What would you like to'
    script_command SCRIPT_SHOP
    script_choice_jump Script_668F, Script_6688, Script_6685
Script_6685::
    script_message $c013 ; '*: You can't carry any more'
Script_6688::
    script_command SCRIPT_SHOP
    script_message $c008 ; '*: Is there anything else?'
    script_jump Script_665B
Script_668F::
    script_message $c009 ; '*: How many would you like'
    script_command SCRIPT_SHOP
    script_choice_jump Script_6699, Script_6696
Script_6696::
    script_jump Script_667D
Script_6699::
    script_command SCRIPT_SHOP
    script_message $c014 ; '*: That comes to 0G. OK?'
    script_command SCRIPT_SHOP
    script_choice_jump Script_66A6, Script_66AD, Script_66B4, Script_66A3
Script_66A3::
    script_jump Script_668F
Script_66A6::
    script_message $c00c ; '*: Oh? You're short some gold.'
    script_command SCRIPT_SHOP
    script_jump Script_667D
Script_66AD::
    script_message $c00d ; '*: You can't carry any more'
    script_command SCRIPT_SHOP
    script_jump Script_667D
Script_66B4::
    script_message $c00b ; '*: Thank you!'
    script_command SCRIPT_SHOP
    script_choice_jump Script_66BF, Script_66BB
Script_66BB::
    script_command SCRIPT_SHOP
    script_jump Script_667D
Script_66BF::
    script_message $c013 ; '*: You can't carry any more'
    script_message $c008 ; '*: Is there anything else?'
    script_command SCRIPT_SHOP
    script_jump Script_665B
Script_66C9::
    script_message $c00e ; '*: What would you like to'
    script_command SCRIPT_SHOP
    script_choice_jump Script_66DE, Script_66D1, Script_66D7
Script_66D1::
    script_message $c010 ; '*: Sorry, but I can't price'
    script_jump Script_66C9
Script_66D7::
    script_command SCRIPT_SHOP
    script_message $c008 ; '*: Is there anything else?'
    script_jump Script_665B
Script_66DE::
    script_message $c011 ; '*: How many will you sell?'
    script_command SCRIPT_SHOP
    script_choice_jump Script_66E8, Script_66E5
Script_66E5::
    script_jump Script_66C9
Script_66E8::
    script_message $c014 ; '*: That comes to 0G. OK?'
    script_command SCRIPT_SHOP
    script_choice_jump Script_66F2, Script_66EF
Script_66EF::
    script_jump Script_66DE
Script_66F2::
    script_message $c00b ; '*: Thank you!'
    script_command SCRIPT_SHOP
    script_choice_jump Script_66FD, Script_66F9
Script_66F9::
    script_command SCRIPT_SHOP
    script_jump Script_66C9
Script_66FD::
    script_message $c00f ; '*: You have no items to'
    script_message $c008 ; '*: Is there anything else?'
    script_command SCRIPT_SHOP
    script_jump Script_665B
Script_6707::
    script_command SCRIPT_SHOP
    script_command SCRIPT_SHOP
Script_6709::
    script_command SCRIPT_SHOP
    script_choice_jump Script_672B, Script_6728, Script_6722, Script_6710, Script_6719
Script_6710::
    script_message $c033 ; '*: You can't carry any more'
    script_message $c034 ; '*: Is there anything else?'
    script_jump Script_6709
Script_6719::
    script_message $c03b ; '*: You have nothing to sell'
    script_message $c034 ; '*: Is there anything else?'
    script_jump Script_6709
Script_6722::
    script_command SCRIPT_SHOP_CLOSE
    script_message $803e ; '*: Thank you! Please come again!'
    script_command SCRIPT_SHOP_CLOSE
    script_end
Script_6728::
    script_jump Script_6777
Script_672B::
    script_message $c032 ; '*: What would you like to'
    script_command SCRIPT_SHOP
    script_choice_jump Script_673D, Script_6736, Script_6733
Script_6733::
    script_message $c03f ; '*: You can't carry any more'
Script_6736::
    script_command SCRIPT_SHOP
    script_message $c034 ; '*: Is there anything else?'
    script_jump Script_6709
Script_673D::
    script_message $c035 ; '*: How many would you like?'
    script_command SCRIPT_SHOP
    script_choice_jump Script_6747, Script_6744
Script_6744::
    script_jump Script_672B
Script_6747::
    script_command SCRIPT_SHOP
    script_message $c040 ; '*: That will be 0G. OK?'
    script_command SCRIPT_SHOP
    script_choice_jump Script_6754, Script_675B, Script_6762, Script_6751
Script_6751::
    script_jump Script_673D
Script_6754::
    script_message $c038 ; '*: You don't have enough gold.'
    script_command SCRIPT_SHOP
    script_jump Script_672B
Script_675B::
    script_message $c039 ; '*: You can't hold that many'
    script_command SCRIPT_SHOP
    script_jump Script_672B
Script_6762::
    script_message $c037 ; '*: Thank you!'
    script_command SCRIPT_SHOP
    script_choice_jump Script_676D, Script_6769
Script_6769::
    script_command SCRIPT_SHOP
    script_jump Script_672B
Script_676D::
    script_message $c03f ; '*: You can't carry any more'
    script_message $c034 ; '*: Is there anything else?'
    script_command SCRIPT_SHOP
    script_jump Script_6709
Script_6777::
    script_message $c03a ; '*: What would you like to'
    script_command SCRIPT_SHOP
    script_choice_jump Script_678C, Script_677F, Script_6785
Script_677F::
    script_message $c03c ; '*: I can't put a price'
    script_jump Script_6777
Script_6785::
    script_command SCRIPT_SHOP
    script_message $c034 ; '*: Is there anything else?'
    script_jump Script_6709
Script_678C::
    script_message $c03d ; '*: How many will you sell?'
    script_command SCRIPT_SHOP
    script_choice_jump Script_6796, Script_6793
Script_6793::
    script_jump Script_6777
Script_6796::
    script_message $c040 ; '*: That will be 0G. OK?'
    script_command SCRIPT_SHOP
    script_choice_jump Script_67A0, Script_679D
Script_679D::
    script_jump Script_678C
Script_67A0::
    script_message $c037 ; '*: Thank you!'
    script_command SCRIPT_SHOP
    script_choice_jump Script_67AB, Script_67A7
Script_67A7::
    script_command SCRIPT_SHOP
    script_jump Script_6777
Script_67AB::
    script_message $c03b ; '*: You have nothing to sell'
    script_message $c034 ; '*: Is there anything else?'
    script_command SCRIPT_SHOP
    script_jump Script_6709
Script_67B5::
    script_command SCRIPT_VAULT
    script_command SCRIPT_VAULT
Script_67B7::
    script_command SCRIPT_VAULT
    script_choice_jump Script_67BC, Script_67BF, Script_67C2
Script_67BC::
    script_jump Script_67C5
Script_67BF::
    script_jump Script_6869
Script_67C2::
    script_jump Script_6905
Script_67C5::
    script_command SCRIPT_VAULT
    script_message $c016 ; '*: What should we store for'
Script_67C9::
    script_command SCRIPT_VAULT
    script_choice_jump Script_67D2, Script_67D9, Script_67E3, Script_67EA, Script_67F1, Script_67F4, Script_67F7
Script_67D2::
    script_message $c017 ; '*: You don't have any items.'
    script_command SCRIPT_VAULT
    script_jump Script_67DD
Script_67D9::
    script_message $c019 ; '*: Sorry, but you filled the'
    script_command SCRIPT_VAULT
Script_67DD::
    script_message $c018 ; '*: Is there anything else?'
    script_jump Script_67FB
Script_67E3::
    script_message $c01e ; '*: You don't have enough to'
    script_command SCRIPT_VAULT
    script_jump Script_67DD
Script_67EA::
    script_message $c019 ; '*: Sorry, but you filled the'
    script_command SCRIPT_VAULT
    script_jump Script_67DD
Script_67F1::
    script_jump Script_67FF
Script_67F4::
    script_jump Script_6848
Script_67F7::
    script_message $c018 ; '*: Is there anything else?'
    script_command SCRIPT_VAULT
Script_67FB::
    script_command SCRIPT_VAULT
    script_jump Script_67B7
Script_67FF::
    script_message $c01a ; '*: What item should I store'
    script_command SCRIPT_VAULT
    script_choice_jump Script_681B, Script_680F, Script_6808, Script_6815
Script_6808::
    script_command SCRIPT_VAULT
    script_message $c016 ; '*: What should we store for'
    script_jump Script_67C9
Script_680F::
    script_message $c02c ; '*: Sorry, but I can't take'
    script_jump Script_67FF
Script_6815::
    script_message $c030 ; '*: I can't take any more'
    script_jump Script_67FF
Script_681B::
    script_message $c01b ; '*: How many should I store?'
    script_command SCRIPT_VAULT
    script_choice_jump Script_682C, Script_6826, Script_6823
Script_6823::
    script_jump Script_67FF
Script_6826::
    script_message $c02f ; '*: I can't store that many.'
    script_jump Script_681B
Script_682C::
    script_message $c01c ; '*: OK, I'll put that away'
    script_command SCRIPT_VAULT
    script_choice_jump Script_6834, Script_683F, Script_6845
Script_6834::
    script_message $c017 ; '*: You don't have any items.'
Script_6837::
    script_message $c018 ; '*: Is there anything else?'
    script_command SCRIPT_VAULT
    script_command SCRIPT_VAULT
    script_jump Script_67B7
Script_683F::
    script_message $c019 ; '*: Sorry, but you filled the'
    script_jump Script_6837
Script_6845::
    script_jump Script_67FF
Script_6848::
    script_command SCRIPT_VAULT
Script_6849::
    script_message $c01f ; '*: How much do you want'
    script_command SCRIPT_VAULT
    script_choice_jump Script_685D, Script_6851, Script_6857
Script_6851::
    script_message $c01d ; '*: I can't store that much.'
    script_jump Script_6849
Script_6857::
    script_message $c016 ; '*: What should we store for'
    script_jump Script_67C9
Script_685D::
    script_command SCRIPT_VAULT
    script_message $c01c ; '*: OK, I'll put that away'
    script_message $c018 ; '*: Is there anything else?'
    script_command SCRIPT_VAULT
    script_command SCRIPT_VAULT
    script_jump Script_67B7
Script_6869::
    script_command SCRIPT_VAULT
    script_message $c020 ; '*: What will you be taking'
Script_686D::
    script_command SCRIPT_VAULT
    script_choice_jump Script_6876, Script_687D, Script_6887, Script_688E, Script_6895, Script_6898, Script_689B
Script_6876::
    script_message $c021 ; '*: I don't have any of'
    script_command SCRIPT_VAULT
    script_jump Script_6881
Script_687D::
    script_message $c022 ; '*: You can't carry any more'
    script_command SCRIPT_VAULT
Script_6881::
    script_message $c018 ; '*: Is there anything else?'
    script_jump Script_67FB
Script_6887::
    script_message $c026 ; '*: You can't carry that much.'
    script_command SCRIPT_VAULT
    script_jump Script_6881
Script_688E::
    script_message $c027 ; '*: I don't have any of'
    script_command SCRIPT_VAULT
    script_jump Script_6881
Script_6895::
    script_jump Script_68A2
Script_6898::
    script_jump Script_68E4
Script_689B::
    script_message $c018 ; '*: Is there anything else?'
    script_command SCRIPT_VAULT
    script_jump Script_67FB
Script_68A2::
    script_message $c023 ; '*: What do you want back?'
    script_command SCRIPT_VAULT
    script_choice_jump Script_68B7, Script_68B1, Script_68AA
Script_68AA::
    script_command SCRIPT_VAULT
    script_message $c020 ; '*: What will you be taking'
    script_jump Script_686D
Script_68B1::
    script_message $c02c ; '*: Sorry, but I can't take'
    script_jump Script_68A2
Script_68B7::
    script_message $c024 ; '*: How many do you want'
    script_command SCRIPT_VAULT
    script_choice_jump Script_68C8, Script_68C2, Script_68BF
Script_68BF::
    script_jump Script_68A2
Script_68C2::
    script_message $c026 ; '*: You can't carry that much.'
    script_jump Script_68B7
Script_68C8::
    script_message $c025 ; '*: Here you go.'
    script_command SCRIPT_VAULT
    script_choice_jump Script_68D0, Script_68DB, Script_68E1
Script_68D0::
    script_message $c022 ; '*: You can't carry any more'
Script_68D3::
    script_message $c018 ; '*: Is there anything else?'
    script_command SCRIPT_VAULT
    script_command SCRIPT_VAULT
    script_jump Script_67B7
Script_68DB::
    script_message $c02e ; '*: I don't have any more'
    script_jump Script_68D3
Script_68E1::
    script_jump Script_68A2
Script_68E4::
    script_command SCRIPT_VAULT
Script_68E5::
    script_message $c028 ; '*: How much gold will you'
    script_command SCRIPT_VAULT
    script_choice_jump Script_68F9, Script_68ED, Script_68F3
Script_68ED::
    script_message $c026 ; '*: You can't carry that much.'
    script_jump Script_68E5
Script_68F3::
    script_message $c020 ; '*: What will you be taking'
    script_jump Script_686D
Script_68F9::
    script_command SCRIPT_VAULT
    script_message $c025 ; '*: Here you go.'
    script_message $c018 ; '*: Is there anything else?'
    script_command SCRIPT_VAULT
    script_command SCRIPT_VAULT
    script_jump Script_67B7
Script_6905::
    script_command SCRIPT_VAULT_CLOSE
    script_message $802d ; '*: Come again anytime!'
    script_command SCRIPT_VAULT_CLOSE
    script_end
Script_690B::
    script_command SCRIPT_INN
    script_command SCRIPT_INN
    script_message $c000 ; '*: It's 0G a night. Will'
    script_skip_if_no Script_6917
    script_message $8002 ; '*: Please come stay another time.'
    script_command SCRIPT_INN_CLOSE
    script_end
Script_6917::
    script_command SCRIPT_INN
    script_skip_if_no Script_691F
    script_message $8003 ; '*: Sorry, but you lack the'
    script_command SCRIPT_INN_CLOSE
    script_end
Script_691F::
    script_message $c001 ; '*: Well then, have a good'
    script_command SCRIPT_INN
    script_message $8004 ; '*: Good morning and farewell!'
    script_command SCRIPT_INN_CLOSE
    script_end
    ds $16d8, $00
