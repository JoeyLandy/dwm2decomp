SECTION "Bank 10", ROMX[$4000], BANK[$10]
    db $10

; one frame of the event-script engine: FetchScriptCommand, then ExecuteScriptCommand
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_RunEventScriptFrame)
RunEventScriptFrame::
Func_010_4001:: ; address name
    call FetchScriptCommand
    call ExecuteScriptCommand
    ret

; does nothing during a fade or unless wScriptStartRequest bit 7 is set (then it clears that bit and sets wScriptRunning); reads the opcode at wScriptPointer (through ReadWordFromDataBank when wScriptInDataBank is set) and jumps through a 13-entry opcode table; $FF ends the script (wScriptRunning, wScriptCommandType and wScriptInDataBank cleared, wModeState = 0, or 5 when wCC44 bit 7 is set); the opcode handlers set wScriptCommandType and its parameters and advance wScriptPointer
; 5 call sites from 5 routines (e.g. RunEventScriptFrame, RunFieldReturnPhase_ResetLeadRecordFields55And5B, RunMenuStateMenuState_InitSoundHardware, GameMode5_Update_LinkExchangeJoypadPerFrame, ...)
; reads: wFadeState, wScriptStartRequest, wScriptPointerLo, wScriptPointerHi, wScriptInDataBank, wMapType
; writes: wScriptStartRequest, wScriptRunning, wScriptCommandType, wScriptInDataBank, wModeState
FetchScriptCommand::
Func_010_4008:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, [wScriptStartRequest]
    bit 7, a
    ret z
    and a, $7F
    ld [wScriptStartRequest], a
    ld a, $01
    ld [wScriptRunning], a

FetchScriptCommand_ReadScriptPointerLo::
Jump_010_401D:: ; address name
    ld a, [wScriptPointerLo]
    ld l, a
    ld a, [wScriptPointerHi]
    ld h, a
    ld a, [wScriptInDataBank]
    and a, a
    jr z, .skip
    call ReadWordFromDataBank
    ld a, b
    inc hl
    jr .cp_FF

.skip:
    ld a, [hl+]

.cp_FF:
    cp a, $FF
    jr nz, .skip2
    xor a, a
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
    rst $00

; E-0039 (C1: the inline table after FetchScriptCommand's `rst $00`, indexed by the script byte; 249 words, 49 distinct handlers: opcodes 0-12 each have their own, and most others share ScriptFetchGeneric, which makes the opcode byte the command type and starts the command (the command then reads its own arguments from the script pointer); a zero word is an unused opcode).
; record: fetch handler for this script byte (opcode)
ScriptOpcodeHandlers::
Data_010_4056:: ; address name
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
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
ScriptFetchGeneric2:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_4248:: ; address name
    pop hl
    dec hl
    ld a, [hl+]
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode 81 (entry 129 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType, wScriptStep, wMessageIndex, wMessageGroup, wMessageState, wScriptPointerLo, wScriptPointerHi
ScriptFetch81:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_4252:: ; address name
    pop hl
    ld a, $81
    ld [wScriptCommandType], a
    xor a, a
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
; no direct call (reached through a table, a jump or a vector)
; reads: wMapSpriteKind, hPlayerStateFlags
; writes: wScriptCommandType, wScriptParam1
ScriptFetch83:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_426E:: ; address name
    pop hl
    ld a, $83
    ld [wScriptCommandType], a
    call StartEventScript
    ld a, [wMapSpriteKind]
    and a, $03
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
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType, wScriptStep, wMessageIndex, wMessageGroup, wMessageState, wScriptPointerLo, wScriptPointerHi
ScriptFetch86:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_4297:: ; address name
    pop hl
    ld a, $86
    ld [wScriptCommandType], a
    xor a, a
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
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptInDataBank
; writes: wScriptCommandType, wScriptParam0, wScriptParam1, wScriptStep, wScriptPointerLo, wScriptPointerHi
ScriptFetch00:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_42B3:: ; address name
    pop hl
    ld a, [wScriptInDataBank]
    and a, a
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
    ld a, [hl+]
    ld [wScriptParam0], a
    ld a, [hl+]
    ld [wScriptParam1], a

.clear_script_step:
    xor a, a
    ld [wScriptStep], a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    ret

; fetch handler for script opcode 01 (entry 1 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType, wScriptParam0, wScriptParam1, wScriptStep, wScriptPointerLo, wScriptPointerHi
ScriptFetch01:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_42E8:: ; address name
    ld a, $02
    ld [wScriptCommandType], a
    jr ScriptFetch02_Restore

; fetch handler for script opcode 02 (entry 2 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType, wScriptParam0, wScriptParam1, wScriptStep, wScriptPointerLo, wScriptPointerHi
ScriptFetch02:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_42EF:: ; address name
    ld a, $03
    ld [wScriptCommandType], a

ScriptFetch02_Restore::
Jump_010_42F4:: ; address name
    pop hl
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    swap a
    or a, c
    ld [wScriptParam0], a
    ld a, [hl+]
    ld [wScriptParam1], a
    xor a, a
    ld [wScriptStep], a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    ret

; fetch handler for script opcode 03 (entry 3 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType, wScriptParam0, wScriptParam1, wScriptPointerLo, wScriptPointerHi
ScriptFetch03:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_430F:: ; address name
    pop hl
    ld a, $04
    ld [wScriptCommandType], a
    ld a, [hl+]
    ld [wScriptParam0], a
    ld a, [hl+]
    ld [wScriptParam1], a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    ret

; fetch handler for script opcode 04 (entry 4 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType, wScriptParam0, wScriptParam1, wScriptStep, hPlayerTurnDelay, wScriptPointerLo, wScriptPointerHi
ScriptFetch04:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_4326:: ; address name
    pop hl
    ld a, $05
    ld [wScriptCommandType], a
    ld a, [hl+]
    ld [wScriptParam0], a
    ld a, [hl+]
    ld [wScriptParam1], a
    xor a, a
    ld [wScriptStep], a
    ldh [hPlayerTurnDelay], a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    ret

; fetch handler for script opcode 05 (entry 5 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType, wScriptParam0, wScriptParam1, wScriptPointerLo, wScriptPointerHi
ScriptFetch05:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_4343:: ; address name
    pop hl
    ld a, $06
    ld [wScriptCommandType], a
    ld a, [hl+]
    ld [wScriptParam0], a
    ld a, [hl+]
    ld [wScriptParam1], a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    ret

; the same 13 bytes as CopyCBytesToVRAMWaitSTAT (00:2DED)
; 2 call sites from 1 routine (e.g. ScriptFetch06)
; reads: rSTAT
CopyCBytesToVRAMWaitSTAT_Bank10::
Func_010_435A:: ; address name
    ldh a, [rSTAT]
    bit 1, a
    jr nz, CopyCBytesToVRAMWaitSTAT_Bank10
    ld a, [hl+]
    ld [de], a
    inc de
    dec c
    jr nz, CopyCBytesToVRAMWaitSTAT_Bank10
    ret

; fetch handler for script opcode 06 (entry 6 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptInDataBank, wTextYesNoResult, wScriptPointerLo, wScriptPointerHi, wMapType
; writes: wScriptPointerLo, wScriptPointerHi, wScriptRunning, wScriptCommandType, wScriptInDataBank, wModeState
; points at: wScriptTileBuf0, wScriptTileBuf1
ScriptFetch06:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_4367:: ; address name
    push bc
    push de
    ld hl, wScriptTileBuf0
    ld de, vTiles1 + $6E0
    ld c, $10
    call CopyCBytesToVRAMWaitSTAT_Bank10
    ld hl, wScriptTileBuf1
    ld de, vTiles1 + $6F0
    ld c, $10
    call CopyCBytesToVRAMWaitSTAT_Bank10
    pop de
    pop bc
    pop hl
    ld a, [wScriptInDataBank]
    and a, a
    jr z, .check_text_yes_no_result
    ld a, [wTextYesNoResult]
    or a, a
    jr nz, .next
    call ReadWordFromDataBank
    inc hl
    ld a, b
    add a, l
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
    or a, a
    jr nz, .set_script_pointer_lo2
    ld a, [hl+]
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
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptInDataBank, wScriptPointerLo, wScriptPointerHi, wMapType
; writes: wScriptPointerLo, wScriptPointerHi, wScriptRunning, wScriptCommandType, wScriptInDataBank, wModeState
ScriptFetch07:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_43C9:: ; address name
    pop hl
    ld a, [wScriptInDataBank]
    and a, a
    jr z, .set_script_pointer_lo
    call ReadWordFromDataBank
    ld a, b
    ld [wScriptPointerLo], a
    ld a, c
    ld [wScriptPointerHi], a
    inc hl
    jp FetchScriptCommand_ReadScriptPointerLo

.set_script_pointer_lo:
    ld a, [hl+]
    ld [wScriptPointerLo], a
    ld a, [hl]
    ld [wScriptPointerHi], a
    jp FetchScriptCommand_ReadScriptPointerLo

; fetch handler for script opcode 0A (entry 10 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptPointerLo, wScriptPointerHi, wScriptInDataBank, wMapType
; writes: wScriptPointerLo, wScriptPointerHi, wScriptRunning, wScriptCommandType, wScriptInDataBank, wModeState
ScriptFetch0A:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_43EA:: ; address name
    pop hl
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    call SetFlagBit
    jp FetchScriptCommand_ReadScriptPointerLo

; fetch handler for script opcode 0B (entry 11 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType, wScriptParam1, wScriptParam0, wScriptPointerLo, wScriptPointerHi
ScriptFetch0B:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_43FD:: ; address name
    pop hl
    ld a, $0C
    ld [wScriptCommandType], a
    ld a, [hl+]
    ld [wScriptParam1], a
    xor a, a
    ld [wScriptParam0], a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    ret

; fetch handler for script opcode 0C (entry 12 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptPointerLo, wScriptPointerHi, wScriptInDataBank, wMapType
; writes: wScriptPointerLo, wScriptPointerHi, wScriptRunning, wScriptCommandType, wScriptInDataBank, wModeState
ScriptFetch0C:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_4414:: ; address name
    pop hl
    ld a, [hl+]
    swap a
    ld de, wSpriteSlots + $C
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, $E0
    ld [de], a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    jp FetchScriptCommand_ReadScriptPointerLo

; fetch handler for script opcode 0D (entry 13 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType, wScriptParam0, wScriptStep, wScriptPointerLo, wScriptPointerHi
ScriptFetch0D:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_442E:: ; address name
    pop hl
    ld a, $0E
    ld [wScriptCommandType], a
    ld a, [hl+]
    ld [wScriptParam0], a
    xor a, a
    ld [wScriptStep], a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    ret

; fetch handler for script opcode 0E (entry 14 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptPointerLo, wScriptPointerHi, wScriptInDataBank, wMapType
; writes: hTemp0, hTemp1, wScriptPointerLo, wScriptPointerHi, wScriptRunning, wScriptCommandType, wScriptInDataBank, wModeState
ScriptFetch0E:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_4445:: ; address name
    pop hl
    ld a, [hl+]
    ldh [hTemp0], a
    ld a, [hl+]
    ldh [hTemp1], a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    farcall AddGoldCapped
    jp FetchScriptCommand_ReadScriptPointerLo

; fetch handler for script opcode 0F (entry 15 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptPointerLo, wScriptPointerHi, wScriptInDataBank, wMapType
; writes: wScriptPointerLo, wScriptPointerHi, wScriptRunning, wScriptCommandType, wScriptInDataBank, wModeState
ScriptFetch0F:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_445D:: ; address name
    pop hl
    ld a, [hl+]
    push af
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    pop af
    cp a, $FF
    jr z, .call_restart_map_music
    cp a, $60
    jr c, .call_queue_music
    call QueueSoundEffect
    jp FetchScriptCommand_ReadScriptPointerLo

.call_queue_music:
    call QueueMusic
    jp FetchScriptCommand_ReadScriptPointerLo

.call_restart_map_music:
    farcall RestartMapMusic
    jp FetchScriptCommand_ReadScriptPointerLo

; fetch handler shared by 123 opcodes: wScriptCommandType = the opcode byte, then StartEventScript with the pointer just after it; the command reads its own arguments from the script
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
ScriptFetchGeneric:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_4486:: ; address name
    pop hl
    dec hl
    ld a, [hl+]
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode 1C (entry 28 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerFacing
; writes: wFollowerRecords, wScriptCommandType, wMessageIndex, wMessageGroup, wMessageState
ScriptFetch1C:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_4490:: ; address name
    pop hl
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and a, $03
    ld [wFollowerRecords], a
    ld a, $1C
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
    xor a, a
    ld [wMessageState], a
    ret

.set_message_index:
    ld hl, $0087
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    xor a, a
    ld [wMessageState], a
    ret

; fetch handler for script opcode 1D (entry 29 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType, wMessageIndex, wMessageGroup, wMessageState
ScriptFetch1D:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_44CA:: ; address name
    pop hl
    ld a, $1D
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
    xor a, a
    ld [wMessageState], a
    ret

.set_message_index:
    ld hl, $408D
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    xor a, a
    ld [wMessageState], a
    ret

; fetch handler for script opcode 23 (entry 35 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; reads: wStoryFlags
; writes: wStoryFlags, wScriptCommandType
ScriptFetch23:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_44FB:: ; address name
    pop hl
    ld a, [wStoryFlags + $61]
    set 2, a
    ld [wStoryFlags + $61], a
    ld a, $23
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode 62 (entry 98 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1
; writes: wScriptCommandType, wScriptParam1
ScriptFetch62:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_450D:: ; address name
    pop hl
    dec hl
    ld a, [hl+]
    ld [wScriptCommandType], a
    ld a, [wScriptParam1]
    push af
    call StartEventScript
    pop af
    ld [wScriptParam1], a
    ret

; fetch handler for script opcode E0 (entry 224 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
ScriptFetchE0:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_451F:: ; address name
    pop hl
    ld a, $E0
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode E1 (entry 225 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
ScriptFetchE1:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_4529:: ; address name
    pop hl
    ld a, $E1
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode E2 (entry 226 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
ScriptFetchE2:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_4533:: ; address name
    pop hl
    ld a, $E2
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode E3 (entry 227 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
ScriptFetchE3:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_453D:: ; address name
    pop hl
    ld a, $E3
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode E5 (entry 229 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
ScriptFetchE5:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_4547:: ; address name
    pop hl
    ld a, $E5
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode E6 (entry 230 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
ScriptFetchE6:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_4551:: ; address name
    pop hl
    ld a, $E6
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode E8 (entry 232 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
ScriptFetchE8:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_455B:: ; address name
    pop hl
    ld a, $E8
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode E9 (entry 233 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
ScriptFetchE9:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_4565:: ; address name
    pop hl
    ld a, $E9
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode EB (entry 235 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
ScriptFetchEB:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_456F:: ; address name
    pop hl
    ld a, $EB
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode EC (entry 236 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
ScriptFetchEC:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_4579:: ; address name
    pop hl
    ld a, $EC
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode ED (entry 237 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
ScriptFetchED:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_4583:: ; address name
    pop hl
    ld a, $ED
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode EE (entry 238 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
ScriptFetchEE:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_458D:: ; address name
    pop hl
    ld a, $EE
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode EF (entry 239 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
ScriptFetchEF:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_4597:: ; address name
    pop hl
    ld a, $EF
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode F0 (entry 240 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
ScriptFetchF0:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_45A1:: ; address name
    pop hl
    ld a, $F0
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode F1 (entry 241 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
ScriptFetchF1:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_45AB:: ; address name
    pop hl
    ld a, $F1
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode F2 (entry 242 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
ScriptFetchF2:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_45B5:: ; address name
    pop hl
    ld a, $F2
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode F3 (entry 243 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
ScriptFetchF3:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_45BF:: ; address name
    pop hl
    ld a, $F3
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode F4 (entry 244 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
ScriptFetchF4:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_45C9:: ; address name
    pop hl
    ld a, $F4
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode F5 (entry 245 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptInDataBank, wScreenTableIndex, wScriptParam0
; writes: wScriptCommandType, wScriptParam0, wScriptParam1, wScriptStep, wScriptPointerLo, wScriptPointerHi
ScriptFetchF5:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_45D3:: ; address name
    pop hl
    ld a, [wScriptInDataBank]
    and a, a
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
    ld a, [hl+]
    ld [wScriptParam0], a
    ld a, [hl+]
    ld [wScriptParam1], a

.read_screen_table_index:
    push hl
    ld a, [wScreenTableIndex]
    add a, a
    add a, a
    add a, a
    add a, a
    ld b, a
    ld a, [wScriptParam0]
    add a, b
    ld [wScriptParam0], a
    pop hl
    xor a, a
    ld [wScriptStep], a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    ret

; fetch handler for script opcode F6 (entry 246 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
ScriptFetchF6:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_4619:: ; address name
    pop hl
    ld a, $F6
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode F7 (entry 247 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
ScriptFetchF7:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_4623:: ; address name
    pop hl
    ld a, $F7
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode F8 (entry 248 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType
ScriptFetchF8:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_462D:: ; address name
    pop hl
    ld a, $F8
    ld [wScriptCommandType], a
    call StartEventScript
    ret

; fetch handler for script opcode EA (entry 234 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptInDataBank, wScriptParam0
; writes: wScriptCommandType, wScriptParam0, wScriptParam1, wScriptStep, wScriptPointerLo, wScriptPointerHi
ScriptFetchEA:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_4637:: ; address name
    pop hl
    ld a, [wScriptInDataBank]
    and a, a
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
    ld a, [hl+]
    ld [wScriptParam0], a
    ld a, [hl+]
    ld [wScriptParam1], a

.call_test_flag_bit:
    push hl
    ld de, $0000
    call TestFlagBit
    jr c, .clear_script_step
    ld a, [wScriptParam0]
    add a, $20
    ld [wScriptParam0], a

.clear_script_step:
    pop hl
    xor a, a
    ld [wScriptStep], a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    ret

; fetch handler for script opcode E7 (entry 231 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptPointerLo, wScriptPointerHi, wScriptInDataBank, wMapType
; writes: wScriptInDataBank, wScriptPointerLo, wScriptPointerHi, wScriptRunning, wScriptCommandType, wModeState
ScriptFetchE7:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_467E:: ; address name
    pop hl
    ld a, $01
    ld [wScriptInDataBank], a
    ld a, [hl+]
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
; no direct call (reached through a table, a jump or a vector)
; reads: wTwoChoiceCursor, wScriptInDataBank, wScriptPointerLo, wScriptPointerHi, wMapType
; writes: wScriptPointerLo, wScriptPointerHi, wScriptRunning, wScriptCommandType, wScriptInDataBank, wModeState
ScriptFetchE4:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_4694:: ; address name
    pop hl
    ld a, [wTwoChoiceCursor]
    ld c, a

.skip:
    ld a, c
    and a, a
    jr z, .check_script_in_data_bank
    inc hl
    dec c
    jr .skip

.check_script_in_data_bank:
    ld a, [wScriptInDataBank]
    and a, a
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
    ld a, [hl+]
    add_a_to_hl
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    jp FetchScriptCommand_ReadScriptPointerLo

; HL = script address: clears wC921-wC926 (parameters and step) and stores HL in wScriptPointer; the script is run by RunEventScriptFrame (28 call sites)
; 28 call sites from 28 routines (e.g. ScriptFetchF8, ScriptFetchF7, ScriptFetchF6, ScriptFetchF4, ...)
; writes: wScriptParam0, wScriptParam1, wScriptStep, wMessageIndex, wMessageGroup, wMessageState, wScriptPointerLo, wScriptPointerHi
StartEventScript::
Func_010_46CD:: ; address name
    xor a, a
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

; does nothing during a fade or while wScriptCommandType is 0; otherwise jumps through ScriptCommandHandlers[wScriptCommandType - 1] to run one frame of the current command
; 1 call site from 1 routine (e.g. RunEventScriptFrame)
; reads: wFadeState, wScriptCommandType
ExecuteScriptCommand::
Func_010_46E9:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, [wScriptCommandType]
    or a, a
    ret z
    dec a
    rst $00

; E-0038 (C1: ExecuteScriptCommand indexes it with wScriptCommandType - 1; command types are set by the fetch handlers of FetchScriptCommand; a zero word is an unused type; all 248 words are code pointers inside the bank and the table ends where the next bytes stop being pointers).
; record: handler that runs one frame of script command type (index + 1)
ScriptCommandHandlers::
Data_010_46F5:: ; address name
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
; no direct call (reached through a table, a jump or a vector)
ScriptCommand9E:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_48E5:: ; address name
    farcall KeyWorldFloorBattle
    ret

; runs one frame of script command type 9D (entry 156 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand9D:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_48EC:: ; address name
    farcall CountdownMessage
    ret

; runs one frame of script command type 9C (entry 155 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand9C:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_48F3:: ; address name
    farcall EncounterCounterMessage
    ret

; runs one frame of script command type 9B (entry 154 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand9B:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_48FA:: ; address name
    farcall HealPartyEvent
    ret

; runs one frame of script command type 9A (entry 153 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand9A:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4901:: ; address name
    farcall RandomBattleEvent
    ret

; runs one frame of script command type 99 (entry 152 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand99:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4908:: ; address name
    farcall ObjectPath1C
    ret

; runs one frame of script command type 98 (entry 151 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand98:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_490F:: ; address name
    farcall ObjectPath1B
    ret

; runs one frame of script command type 95 (entry 148 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand95:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4916:: ; address name
    farcall ArenaGridBattle
    ret

; runs one frame of script command type 96 (entry 149 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand96:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_491D:: ; address name
    farcall ArenaRounds
    ret

; runs one frame of script command type 90 (entry 143 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand90:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4924:: ; address name
    farcall FollowersStep10
    ret

; runs one frame of script command type 91 (entry 144 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand91:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_492B:: ; address name
    farcall FollowersStep11
    ret

; runs one frame of script command type 92 (entry 145 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand92:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4932:: ; address name
    farcall PlayerAndFollowersStep
    ret

; runs one frame of script command type 93 (entry 146 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand93:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4939:: ; address name
    farcall WarpWithFollowers
    ret

; runs one frame of script command type 94 (entry 147 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand94:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4940:: ; address name
    farcall FollowersStep14
    ret

; runs one frame of script command type 8D (entry 140 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand8D:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4947:: ; address name
    farcall BreedChildScene
    ret

; runs one frame of script command type 8C (entry 139 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand8C:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_494E:: ; address name
    farcall BreedChildSprite
    ret

; runs one frame of script command type 8B (entry 138 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand8B:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4955:: ; address name
    farcall BreedFade
    ret

; runs one frame of script command type 8F (entry 142 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand8F:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_495C:: ; address name
    farcall NpcBreedWarp
    ret

; runs one frame of script command type 9F (entry 158 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand9F:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4963:: ; address name
    farcall LinkMessageEvent
    ret

; runs one frame of script command type A0 (entry 159 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandA0:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_496A:: ; address name
    farcall PlayerSpriteFlash
    ret

; runs one frame of script command type A1 (entry 160 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandA1:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4971:: ; address name
    farcall PlayerSpriteMessage
    ret

; runs one frame of script command type 8E (entry 141 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand8E:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4978:: ; address name
    farcall MapLinkWarp
    ret

; runs one frame of script command type 8A (entry 137 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand8A:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_497F:: ; address name
    farcall MapExitWarp
    ret

; runs one frame of script command type 80 (entry 127 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand80:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4986:: ; address name
    farcall StepTriggerReward
    ret

; runs one frame of script command type 81 (entry 128 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand81:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_498D:: ; address name
    farcall AreaItemEvent
    ret

; runs one frame of script command type 86 (entry 133 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand86:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4994:: ; address name
    farcall KeyWorldDoorItem
    ret

; runs one frame of script command type 82 (entry 129 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand82:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_499B:: ; address name
    farcall GreatLogFieldEvents
    ret

; runs one frame of script command type 83 (entry 130 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand83:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_49A2:: ; address name
    farcall FieldScene01
    ret

; runs one frame of script command type 84 (entry 131 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand84:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_49A9:: ; address name
    farcall RandomGoldOrItem
    ret

; runs one frame of script command type 85 (entry 132 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand85:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_49B0:: ; address name
    farcall KeyWorldBossBattle
    ret

; runs one frame of script command type 87 (entry 134 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand87:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_49B7:: ; address name
    farcall PartyDefeatedReturn
    ret

; runs one frame of script command type 88 (entry 135 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand88:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_49BE:: ; address name
    farcall ReturnMessage
    ret

; runs one frame of script command type 89 (entry 136 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand89:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_49C5:: ; address name
    farcall ReturnWarp
    ret

; runs one frame of script command type 06 (entry 5 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand06:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_49CC:: ; address name
    farcall ScriptSetDirection
    ret

; runs one frame of script command type 05 (entry 4 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand05:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_49D3:: ; address name
    farcall ScriptCommand05_Run
    ret

; runs one frame of script command type 04 (entry 3 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand04:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_49DA:: ; address name
    farcall ScriptWaitFrames
    ret

; runs one frame of script command type 03 (entry 2 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand03:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_49E1:: ; address name
    farcall ScriptStepObject

; runs one frame of script command type 02 (entry 1 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand02:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_49E7:: ; address name
    farcall ScriptStepObject
    ret

; runs one frame of script command type 0A (entry 9 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand0A:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_49EE:: ; address name
    farcall RunOneTimeTreasure
    ret

; runs one frame of script command type 09 (entry 8 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptStep
ScriptCommand09:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_49F5:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand09_SetBit1OfPlayerAndObjectFlags
    dw ScriptCommand09_ReadScriptParam1AndTextWindowStateEtc
    dw ScriptCommand09_QueueSoundEffect
    dw ScriptCommand09_ClearBit1OfPlayerAndObjectFlags

; entry 3 of the `rst $00` table in ScriptCommand09
; no direct call (reached through a table, a jump or a vector)
; reads: wTextWindowState
; writes: wScriptCommandType, wScriptRunning, wModeState
ScriptCommand09_ClearBit1OfPlayerAndObjectFlags::
Jump_010_4A01:: ; address name
    ld a, [wTextWindowState]
    and a, $03
    ret nz
    farcall ClearBit1OfPlayerAndObjectFlags
    xor a, a
    ld [wScriptCommandType], a
    xor a, a
    ld [wScriptRunning], a
    ld a, $00
    ld [wModeState], a
    ret

; runs one frame of script command type 01 (entry 0 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptStep
ScriptCommand01:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4A1B:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand09_SetBit1OfPlayerAndObjectFlags
    dw ScriptCommand09_ReadScriptParam1AndTextWindowStateEtc
    dw ScriptCommand09_QueueSoundEffect
    dw ScriptCommand01_ClearBit1OfPlayerAndObjectFlags

; entry 0 of the `rst $00` table in ScriptCommand09
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1, hPlayerY
; writes: wTextWindowState, wTextWindowStep, hSpriteWindowClipMode
; points at: wScriptStep
ScriptCommand09_SetBit1OfPlayerAndObjectFlags::
Jump_010_4A27:: ; address name
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
    cp a, $48
    jr c, .done
    ld a, $81
    ld [wTextWindowState], a
    ld a, $01
    ldh [hSpriteWindowClipMode], a

.done:
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand09
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1, wTextWindowState, wScriptParam0
; points at: wScriptStep
ScriptCommand09_ReadScriptParam1AndTextWindowStateEtc::
Jump_010_4A67:: ; address name
    ld a, [wScriptParam1]
    bit 7, a
    jr nz, .read_script_param0
    ld a, [wTextWindowState]
    and a, $03
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

; entry 2 of the `rst $00` table in ScriptCommand09
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScriptParam1, hPlayerY
; writes: hSpriteWindowClipMode, wTextWindowState, wTextWindowStep
; points at: wScriptStep
ScriptCommand09_QueueSoundEffect::
Jump_010_4A84:: ; address name
    ld a, [wTextFlags]
    bit 0, a
    ret nz
    ld a, [wScriptParam1]
    bit 6, a
    jr nz, .done
    ld a, $69
    call QueueSoundEffect
    xor a, a
    ldh [hSpriteWindowClipMode], a
    ld a, $02
    ld [wTextWindowState], a
    ld a, $00
    ld [wTextWindowStep], a
    ldh a, [hPlayerY]
    cp a, $48
    jr c, .done
    ld a, $82
    ld [wTextWindowState], a

.done:
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in ScriptCommand01
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1, wTextWindowState
; writes: wScriptCommandType, wScriptStartRequest
ScriptCommand01_ClearBit1OfPlayerAndObjectFlags::
Jump_010_4AB3:: ; address name
    ld a, [wScriptParam1]
    bit 6, a
    jr nz, .clear_script_command_type
    ld a, [wTextWindowState]
    and a, $03
    ret nz
    farcall ClearBit1OfPlayerAndObjectFlags

.clear_script_command_type:
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; only called from ScriptCommand09_Case01 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommand09_ReadScriptParam1AndTextWindowStateEtc)
; reads: wMessageMode, wMapType
; writes: wStringIndex, wStringCategory
ScriptCommand09_Case01_WriteStringIndexAndStringCategory::
Func_010_4AD0:: ; address name
    ld a, h
    and a, $3F
    ld h, a
    push hl
    ld a, [wMessageMode]
    and a, a
    jr z, ScriptCommand09_Case01_WriteStringIndexAndStringCategory_Data_CheckMapType
    dec a
    ld c, a
    sla a
    add a, c
    ld de, ScriptCommand09_Case01_WriteStringIndexAndStringCategory_Data
    add a, e
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

; address loaded by ScriptCommand09_Case01_WriteStringIndexAndStringCategory
ScriptCommand09_Case01_WriteStringIndexAndStringCategory_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_010_4AFF:: ; address name
    db $01, $40, $F0, $01, $40, $F0, $0E, $52, $1F, $01, $40, $1D, $86, $4C, $1B, $D0
    db $43, $F2, $01, $40, $0D, $01, $40, $0E, $01, $40, $0B, $90, $64, $33, $10, $5D
    db $24

ScriptCommand09_Case01_WriteStringIndexAndStringCategory_Data_CheckMapType::
Jump_010_4B20:: ; address name
    pop hl
    ld a, [wMapType]
    cp a, $80
    jr z, .set_string_index
    bit 7, a
    jp nz, ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank89_Skip

.set_string_index:
    ld a, l
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    ld a, h
    rst $00
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

; entry 0 of the `rst $00` table in Func_010_4AD0
; no direct call (reached through a table, a jump or a vector)
ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank28::
Jump_010_4B53:: ; address name
    farcall BeginStringDisplay_Bank28
    ret

; entry 1 of the `rst $00` table in Func_010_4AD0
; no direct call (reached through a table, a jump or a vector)
ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank29::
Jump_010_4B5A:: ; address name
    farcall BeginStringDisplay_Bank29
    ret

; entry 2 of the `rst $00` table in Func_010_4AD0
; no direct call (reached through a table, a jump or a vector)
ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank2A::
Jump_010_4B61:: ; address name
    farcall BeginStringDisplay_Bank2A
    ret

; entry 3 of the `rst $00` table in Func_010_4AD0
; no direct call (reached through a table, a jump or a vector)
ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank2B::
Jump_010_4B68:: ; address name
    farcall BeginStringDisplay_Bank2B
    ret

; entry 4 of the `rst $00` table in Func_010_4AD0
; no direct call (reached through a table, a jump or a vector)
ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank2C::
Jump_010_4B6F:: ; address name
    farcall BeginStringDisplay_Bank2C
    ret

; entry 5 of the `rst $00` table in Func_010_4AD0
; no direct call (reached through a table, a jump or a vector)
ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank2D::
Jump_010_4B76:: ; address name
    farcall BeginStringDisplay_Bank2D
    ret

; entry 6 of the `rst $00` table in Func_010_4AD0
; no direct call (reached through a table, a jump or a vector)
ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank2E::
Jump_010_4B7D:: ; address name
    farcall BeginStringDisplay_Bank2E
    ret

; entry 8 of the `rst $00` table in Func_010_4AD0
; no direct call (reached through a table, a jump or a vector)
ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank7C::
Jump_010_4B84:: ; address name
    farcall BeginStringDisplay_Bank7C
    ret

; entry 9 of the `rst $00` table in Func_010_4AD0
; no direct call (reached through a table, a jump or a vector)
ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank80::
Jump_010_4B8B:: ; address name
    farcall BeginStringDisplay_Bank80
    ret

; entry 11 of the `rst $00` table in Func_010_4AD0
; no direct call (reached through a table, a jump or a vector)
ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank82::
Jump_010_4B92:: ; address name
    farcall BeginStringDisplay_Bank82
    ret

; entry 12 of the `rst $00` table in Func_010_4AD0
; no direct call (reached through a table, a jump or a vector)
ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank86::
Jump_010_4B99:: ; address name
    farcall BeginStringDisplay_Bank86
    ret

; entry 13 of the `rst $00` table in Func_010_4AD0
; no direct call (reached through a table, a jump or a vector)
ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank89::
Jump_010_4BA0:: ; address name
    farcall BeginStringDisplay_Bank89
    ret

ScriptCommand09_Case01_Sub01_ToBeginStringDisplay_Bank89_Skip::
Jump_010_4BA7:: ; address name
    ld a, h
    or a, a
    jr nz, .set_string_index
    ld a, l
    cp a, $20
    jr c, .set_string_index
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank83
    ret

.set_string_index:
    ld a, l
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank8A
    ret

; runs one frame of script command type 0C (entry 11 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand0C:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4BCD:: ; address name
    farcall ScriptSlideObjectY
    ret

; runs one frame of script command type 0E (entry 13 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand0E:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4BD4:: ; address name
    farcall ScriptCommand0E_Run
    ret

; runs one frame of script command type 11 (entry 16 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand11:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4BDB:: ; address name
    farcall SceneFarmKids
    ret

; runs one frame of script command type 12 (entry 17 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand12:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4BE2:: ; address name
    farcall SceneLearnQuick
    ret

; runs one frame of script command type 13 (entry 18 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand13:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4BE9:: ; address name
    farcall SceneSpinning
    ret

; runs one frame of script command type 14 (entry 19 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand14:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4BF0:: ; address name
    farcall SceneWarubouSmells
    ret

; runs one frame of script command type 15 (entry 20 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand15:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4BF7:: ; address name
    farcall SceneWarubouFood
    ret

; runs one frame of script command type 16 (entry 21 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand16:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4BFE:: ; address name
    farcall SceneWarubouFood2
    ret

; runs one frame of script command type 17 (entry 22 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand17:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C05:: ; address name
    farcall ScenePackage
    ret

; runs one frame of script command type 18 (entry 23 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand18:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C0C:: ; address name
    farcall SceneGreatlogKey
    ret

; runs one frame of script command type 19 (entry 24 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand19:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C13:: ; address name
    farcall SceneWarubouMagicKey
    ret

; runs one frame of script command type 1A (entry 25 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand1A:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C1A:: ; address name
    farcall SceneOasisKey
    ret

; runs one frame of script command type 1B (entry 26 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand1B:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C21:: ; address name
    farcall SceneWarubouLeaves
    ret

; runs one frame of script command type 1C (entry 27 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand1C:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C28:: ; address name
    farcall SceneWarubouWarning
    ret

; runs one frame of script command type 1D (entry 28 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand1D:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C2F:: ; address name
    farcall SceneLongFaces
    ret

; runs one frame of script command type 1E (entry 29 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand1E:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C36:: ; address name
    farcall CheckItem
    ret

; runs one frame of script command type 1F (entry 30 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand1F:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C3D:: ; address name
    farcall SceneMonsterInspection
    ret

; runs one frame of script command type 20 (entry 31 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand20:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C44:: ; address name
    farcall ScriptCommand20_Run
    ret

; runs one frame of script command type 21 (entry 32 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand21:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C4B:: ; address name
    farcall SceneKingAudience
    ret

; runs one frame of script command type 22 (entry 33 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand22:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C52:: ; address name
    farcall SceneCanalGate
    ret

; runs one frame of script command type 23 (entry 34 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand23:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C59:: ; address name
    farcall SceneWaterShortage
    ret

; runs one frame of script command type 24 (entry 35 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand24:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C60:: ; address name
    farcall SceneTreasureTheft
    ret

; runs one frame of script command type 25 (entry 36 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand25:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C67:: ; address name
    farcall SceneWaterSolved
    ret

; runs one frame of script command type 26 (entry 37 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand26:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C6E:: ; address name
    farcall SceneMonstersInTow
    ret

; runs one frame of script command type 27 (entry 38 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand27:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C75:: ; address name
    farcall SceneRivalDefeated
    ret

; runs one frame of script command type 28 (entry 39 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand28:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C7C:: ; address name
    farcall ShakeScreen
    ret

; runs one frame of script command type 29 (entry 40 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand29:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C83:: ; address name
    farcall SceneWhoAreYou
    ret

; runs one frame of script command type 2A (entry 41 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand2A:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C8A:: ; address name
    farcall SceneWatchOut
    ret

; runs one frame of script command type 2B (entry 42 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand2B:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C91:: ; address name
    farcall SceneMermaidSong
    ret

; runs one frame of script command type 2C (entry 43 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand2C:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C98:: ; address name
    farcall SceneDancing
    ret

; runs one frame of script command type 2D (entry 44 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand2D:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C9F:: ; address name
    farcall SceneMermaidSong2
    ret

; runs one frame of script command type 2E (entry 45 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand2E:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4CA6:: ; address name
    farcall WarpMap41
    ret

; runs one frame of script command type 2F (entry 46 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand2F:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4CAD:: ; address name
    farcall SceneTentacles
    ret

; runs one frame of script command type 30 (entry 47 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand30:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4CB4:: ; address name
    farcall SceneSailorRing
    ret

; runs one frame of script command type 31 (entry 48 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand31:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4CBB:: ; address name
    farcall ScenePirateGhosts
    ret

; runs one frame of script command type 32 (entry 49 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand32:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4CC2:: ; address name
    farcall GiveItemBlink
    ret

; runs one frame of script command type 33 (entry 50 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand33:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4CC9:: ; address name
    farcall SceneCrate
    ret

; runs one frame of script command type 34 (entry 51 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand34:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4CD0:: ; address name
    farcall SetTilesFlag310
    ret

; runs one frame of script command type 35 (entry 52 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand35:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4CD7:: ; address name
    farcall SceneKamehaEscape
    ret

; runs one frame of script command type 36 (entry 53 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand36:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4CDE:: ; address name
    farcall SceneKamehaCaught
    ret

; runs one frame of script command type 37 (entry 54 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand37:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4CE5:: ; address name
    farcall SceneCrewFollows
    ret

; runs one frame of script command type 38 (entry 55 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand38:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4CEC:: ; address name
    farcall SceneKamehaFlees
    ret

; runs one frame of script command type 39 (entry 56 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand39:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4CF3:: ; address name
    farcall SceneMermaidKingdom
    ret

; runs one frame of script command type 3A (entry 57 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand3A:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4CFA:: ; address name
    farcall SceneMasterThanks
    ret

; runs one frame of script command type 3B (entry 58 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand3B:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D01:: ; address name
    farcall SceneMermaidKingdom
    ret

; runs one frame of script command type 3C (entry 59 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand3C:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D08:: ; address name
    farcall RewardItemOrKey
    ret

; runs one frame of script command type 3D (entry 60 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand3D:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D0F:: ; address name
    farcall RewardItemOrKey2
    ret

; runs one frame of script command type 3E (entry 61 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand3E:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D16:: ; address name
    farcall SceneStrongestMaster
    ret

; runs one frame of script command type 3F (entry 62 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand3F:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D1D:: ; address name
    farcall BlinkSprites
    ret

; runs one frame of script command type 40 (entry 63 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand40:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D24:: ; address name
    farcall SceneSpiritEnvoy
    ret

; runs one frame of script command type 41 (entry 64 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand41:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D2B:: ; address name
    farcall SceneExplosion
    ret

; runs one frame of script command type 42 (entry 65 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand42:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D32:: ; address name
    farcall SceneReportToKing
    ret

; runs one frame of script command type 43 (entry 66 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand43:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D39:: ; address name
    farcall SceneWallExit
    ret

; runs one frame of script command type 44 (entry 67 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand44:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D40:: ; address name
    farcall SceneRealKing
    ret

; runs one frame of script command type 45 (entry 68 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand45:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D47:: ; address name
    farcall ScenePlanRuined
    ret

; runs one frame of script command type 46 (entry 69 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand46:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D4E:: ; address name
    farcall SceneCheerYuna
    ret

; runs one frame of script command type 47 (entry 70 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand47:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D55:: ; address name
    farcall SceneSpiritEnvoy2
    ret

; runs one frame of script command type 48 (entry 71 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand48:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D5C:: ; address name
    farcall ScenePrincessMedicine
    ret

; runs one frame of script command type 49 (entry 72 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand49:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D63:: ; address name
    farcall SceneMedicineGiven
    ret

; runs one frame of script command type 4A (entry 73 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand4A:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D6A:: ; address name
    farcall SceneShield
    ret

; runs one frame of script command type 4B (entry 74 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand4B:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D71:: ; address name
    farcall SceneShield2
    ret

; runs one frame of script command type 4C (entry 75 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand4C:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D78:: ; address name
    farcall ScriptCommand4C_Run
    ret

; runs one frame of script command type 4D (entry 76 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand4D:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D7F:: ; address name
    farcall SceneWaterReward
    ret

; runs one frame of script command type 4E (entry 77 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand4E:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D86:: ; address name
    farcall SceneGrave
    ret

; runs one frame of script command type 4F (entry 78 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand4F:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D8D:: ; address name
    farcall SetTilesD2
    ret

; runs one frame of script command type 50 (entry 79 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand50:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D94:: ; address name
    farcall SceneMadcondor
    ret

; runs one frame of script command type 51 (entry 80 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand51:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D9B:: ; address name
    farcall SceneMadcondorCry
    ret

; runs one frame of script command type 52 (entry 81 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand52:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4DA2:: ; address name
    farcall SceneSmallHole
    ret

; runs one frame of script command type 53 (entry 82 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand53:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4DA9:: ; address name
    farcall SceneJustice
    ret

; runs one frame of script command type 54 (entry 83 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand54:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4DB0:: ; address name
    farcall SceneGravestone
    ret

; runs one frame of script command type 55 (entry 84 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand55:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4DB7:: ; address name
    farcall SetFlag322
    ret

; runs one frame of script command type 56 (entry 85 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand56:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4DBE:: ; address name
    farcall SceneBeatenFairly
    ret

; runs one frame of script command type 57 (entry 86 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand57:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4DC5:: ; address name
    farcall SceneThreeItemsBattle
    ret

; runs one frame of script command type 58 (entry 87 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand58:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4DCC:: ; address name
    farcall SceneThreeItems
    ret

; runs one frame of script command type 59 (entry 88 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand59:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4DD3:: ; address name
    farcall SceneSawKameha
    ret

; runs one frame of script command type 5A (entry 89 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand5A:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4DDA:: ; address name
    farcall SceneSawKameha
    ret

; runs one frame of script command type 5B (entry 90 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand5B:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4DE1:: ; address name
    farcall SceneLimbo
    ret

; runs one frame of script command type 5C (entry 91 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand5C:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4DE8:: ; address name
    farcall TakeItem
    ret

; runs one frame of script command type 5D (entry 92 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand5D:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4DEF:: ; address name
    farcall SceneDarckTaunt
    ret

; runs one frame of script command type 5E (entry 93 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand5E:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4DF6:: ; address name
    farcall SceneDarckDefeated
    ret

; runs one frame of script command type 5F (entry 94 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand5F:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4DFD:: ; address name
    farcall SceneHomecoming
    ret

; runs one frame of script command type 60 (entry 95 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand60:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E04:: ; address name
    farcall ScriptCommand60_Run
    ret

; runs one frame of script command type 61 (entry 96 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand61:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E0B:: ; address name
    farcall SceneKamehaStole
    ret

; runs one frame of script command type 62 (entry 97 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand62:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E12:: ; address name
    farcall PersonalityMessage
    ret

; runs one frame of script command type 63 (entry 98 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand63:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E19:: ; address name
    farcall SceneRivalFade
    ret

; runs one frame of script command type 64 (entry 99 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand64:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E20:: ; address name
    farcall GatherFollowers
    ret

; runs one frame of script command type 65 (entry 100 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand65:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E27:: ; address name
    farcall GrowthLimitInfo
    ret

; runs one frame of script command type 66 (entry 101 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand66:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E2E:: ; address name
    farcall SceneShieldGuardian
    ret

; runs one frame of script command type 67 (entry 102 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand67:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E35:: ; address name
    farcall SceneJustice2
    ret

; runs one frame of script command type 68 (entry 103 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand68:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E3C:: ; address name
    farcall SceneFoundMe
    ret

; runs one frame of script command type 69 (entry 104 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand69:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E43:: ; address name
    farcall SceneFoundMeBattle
    ret

; runs one frame of script command type 6A (entry 105 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand6A:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E4A:: ; address name
    farcall SceneHorsingAround
    ret

; runs one frame of script command type 6B (entry 106 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand6B:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E51:: ; address name
    farcall SceneVaultSettled
    ret

; runs one frame of script command type 6C (entry 107 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand6C:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E58:: ; address name
    farcall GiveMonster
    ret

; runs one frame of script command type 6D (entry 108 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand6D:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E5F:: ; address name
    farcall SceneLimboMonster
    ret

; runs one frame of script command type 6E (entry 109 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand6E:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E66:: ; address name
    farcall SceneLimboMonster2
    ret

; runs one frame of script command type 6F (entry 110 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand6F:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E6D:: ; address name
    farcall DeskKey
    ret

; runs one frame of script command type 70 (entry 111 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand70:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E74:: ; address name
    farcall SceneTerry
    ret

; runs one frame of script command type 71 (entry 112 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand71:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E7B:: ; address name
    farcall SceneKamehaKeyBattle
    ret

; runs one frame of script command type 72 (entry 113 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand72:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E82:: ; address name
    farcall SceneKamehaKeyBattle2
    ret

; runs one frame of script command type 73 (entry 114 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand73:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E89:: ; address name
    farcall FollowerFacePlayer
    ret

; runs one frame of script command type 74 (entry 115 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand74:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E90:: ; address name
    farcall SetFlagRedraw
    ret

; runs one frame of script command type 75 (entry 116 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand75:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E97:: ; address name
    farcall SceneAtSea
    ret

; runs one frame of script command type 76 (entry 117 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand76:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E9E:: ; address name
    farcall ScriptCommand76_Run
    ret

; runs one frame of script command type 77 (entry 118 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand77:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4EA5:: ; address name
    farcall SceneLandHo
    ret

; runs one frame of script command type 78 (entry 119 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand78:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4EAC:: ; address name
    farcall SaveScreen
    ret

; runs one frame of script command type 79 (entry 120 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand79:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4EB3:: ; address name
    farcall ScenePoorChurch
    ret

; runs one frame of script command type 7A (entry 121 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand7A:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4EBA:: ; address name
    farcall SceneKamehaMissing
    ret

; runs one frame of script command type 7B (entry 122 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand7B:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4EC1:: ; address name
    farcall SceneArenaChallenge
    ret

; runs one frame of script command type 7C (entry 123 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand7C:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4EC8:: ; address name
    farcall SceneTerryBattle
    ret

; runs one frame of script command type 7D (entry 124 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand7D:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4ECF:: ; address name
    farcall SceneThisWay
    ret

; runs one frame of script command type 7E (entry 125 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand7E:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4ED6:: ; address name
    farcall SceneGotTo
    ret

; runs one frame of script command type 7F (entry 126 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand7F:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4EDD:: ; address name
    farcall SceneChestServant
    ret

; runs one frame of script command type C0 (entry 191 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandC0:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4EE4:: ; address name
    farcall SceneRoltElder
    ret

; runs one frame of script command type C1 (entry 192 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandC1:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4EEB:: ; address name
    farcall SceneTooStrong
    ret

; runs one frame of script command type C2 (entry 193 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandC2:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4EF2:: ; address name
    farcall SceneGiveBackCyal
    ret

; runs one frame of script command type C3 (entry 194 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandC3:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4EF9:: ; address name
    farcall KeyBossBeaten
    ret

; runs one frame of script command type C6 (entry 197 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandC6:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4F00:: ; address name
    farcall SceneCyalRolt
    ret

; runs one frame of script command type C4 (entry 195 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandC4:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4F07:: ; address name
    farcall SceneBarrel
    ret

; runs one frame of script command type C5 (entry 196 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandC5:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4F0E:: ; address name
    farcall SceneWizstone
    ret

; runs one frame of script command type C7 (entry 198 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandC7:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4F15:: ; address name
    farcall ScenePendantSeller
    ret

; runs one frame of script command type C8 (entry 199 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandC8:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4F1C:: ; address name
    farcall SceneMercy
    ret

; runs one frame of script command type C9 (entry 200 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandC9:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4F23:: ; address name
    farcall SceneMilayouForest
    ret

; runs one frame of script command type CA (entry 201 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandCA:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4F2A:: ; address name
    farcall KeyBossBeaten2
    ret

; runs one frame of script command type CB (entry 202 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandCB:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4F31:: ; address name
    farcall SceneChestBattle
    ret

; runs one frame of script command type CC (entry 203 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandCC:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4F38:: ; address name
    farcall SceneCyalShine
    ret

; runs one frame of script command type CD (entry 204 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandCD:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4F3F:: ; address name
    farcall SceneYouDidIt
    ret

; runs one frame of script command type CE (entry 205 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandCE:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4F46:: ; address name
    farcall HideSprites
    ret

; runs one frame of script command type CF (entry 206 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandCF:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4F4D:: ; address name
    farcall SceneKeyShop
    ret

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_4F54:: ; heuristic: event script entry or jump target; C0
    script_sound $28
    script_message $0030 ; 'Heh, so these are the newcomers?'
    script_face $81, 1
    script_message $0031 ; 'C'mon, Warubou!'
    script_command SCRIPT_SCENE_WARUBOU_LEAVES
    script_sound $FF
    script_set_flag $0015
    script_end
Script_4F66:: ; heuristic: event script entry or jump target; C0
    script_message $404C ; 'Have you heard about Magic Keys?'
    script_skip_if_no Script_4F6F
    script_message $804E ; 'You need Magic Keys to open'
    script_end
Script_4F6F:: ; heuristic: event script entry or jump target; C0
    script_message $804D ; 'Wow, you kids sure learn quick!'
    script_end
Script_4F73:: ; heuristic: event script entry or jump target; C0
    script_sound $28
    script_command SCRIPT_SCENE_LEARN_QUICK
    script_message $0033 ; 'Oh It's all spinning around That'
    script_sound $FF
    script_end
Script_4F7C:: ; heuristic: event script entry or jump target; C0
    script_sound $28
    script_wait 100
    script_command SCRIPT_SCENE_SPINNING
    script_wait 30
    script_sound $FF
    script_end
Script_4F88:: ; heuristic: event script entry or jump target; C0
    script_message $0045 ; 'You must be the farm kids.'
    script_command SCRIPT_SCENE_FARM_KIDS
    script_end
Script_4F8D:: ; heuristic: event script entry or jump target; C0
    script_slide_y $82
    script_message $0050 ; 'Warubou Wha ? I smell something!'
    script_command SCRIPT_SCENE_WARUBOU_SMELLS
    script_message $0051 ; 'Warubou What is this? Food? Perfect!'
    script_set_flag $000A
    script_command SCRIPT_SCENE_WARUBOU_FOOD
    script_sound $FF
    script_end
Script_4F9D:: ; heuristic: event script entry or jump target; C0
    script_sound $28
    script_command SCRIPT_SCENE_WARUBOU_FOOD_2
    script_message $005D ; 'Warubou Calm down and listen! What'
    script_end
Script_4FA4:: ; heuristic: event script entry or jump target; C0
    script_message $001E ; 'You e come at the right'
    script_command SCRIPT_SCENE_VAULT_SETTLED
    script_message $0020 ; 'Good, that's settled then. The Vault'
    script_set_flag $0003
    script_end
Script_4FAF:: ; heuristic: event script entry or jump target; C0
    script_message $006A ; 'Did you get the package from'
    script_command SCRIPT_SCENE_PACKAGE
    script_message $006B ; 'Oh goodness, you're filthy! What happened'
    script_end
Script_4FB7:: ; heuristic: event script entry or jump target; C0
    script_message $4028 ; 'I e heard that there are'
    script_skip_if_no Script_4FCC
    script_message $802A ; 'Monster masters are those people who'
    script_command SCRIPT_FOLLOWER_FACE_PLAYER
    script_slide_y $01
    script_message $002D ; 'Tara Big brother can't do it'
    script_message $002C ; 'I aspired to be one long'
    script_set_flag $0014
    script_end
Script_4FCC:: ; heuristic: event script entry or jump target; C0
    script_message $8029 ; 'Oh? Well, that's fine then. Go'
    script_end
Script_4FD0:: ; heuristic: event script entry or jump target; C0
    script_message $4028 ; 'I e heard that there are'
    script_skip_if_no Script_4FE4
    script_message $802A ; 'Monster masters are those people who'
    script_slide_y $01
    script_message $002B ; 'Cobi Hahah! 0 won't last a'
    script_message $002C ; 'I aspired to be one long'
    script_set_flag $0014
    script_end
Script_4FE4:: ; heuristic: event script entry or jump target; C0
    script_message $8029 ; 'Oh? Well, that's fine then. Go'
    script_end
Script_4FE8:: ; heuristic: event script entry or jump target; C0
    script_message $0060 ; 'Hah? The island's going to sink?'
    script_slide_y $01
    script_message $0063 ; 'Tara Why aren't you listening? Papa,'
    script_message $0062 ; 'Look, an island just doesn't sink.'
    script_set_flag $000E
    script_end
Script_4FF7:: ; heuristic: event script entry or jump target; C0
    script_message $0060 ; 'Hah? The island's going to sink?'
    script_slide_y $01
    script_message $0061 ; 'Cobi Why won't you believe us?'
    script_message $0062 ; 'Look, an island just doesn't sink.'
    script_set_flag $000E
    script_end
Script_5006:: ; heuristic: event script entry or jump target; C0
    script_message $007A ; 'Warubou Wa-hey! Good, you're back. You'
    script_slide_y $01
    script_message $407B ; 'Warubou No time to waste, warooh!'
    script_skip_if_no Script_5017
    script_message $807C ; 'Warubou No? Then find someone!'
    script_set_flag $0016
    script_end
Script_5017:: ; heuristic: event script entry or jump target; C0
    script_message $807F ; 'Warubou Wa-hey! Good, good, good! In'
    script_command SCRIPT_SCENE_WARUBOU_MAGIC_KEY
    script_message $0080 ; 'Warubou This here is a Magic'
    script_command SCRIPT_SCENE_OASIS_KEY
    script_message $0081 ; '0 received the Oasis Key.'
    script_message $0082 ; 'Warubou Wa-hey! I trust you! Go!'
    script_set_flag $001A
    script_end
Script_5029:: ; heuristic: event script entry or jump target; C0
    script_message $407D ; 'Warubou Wa-hey? No one believed! You'
    script_skip_if_no Script_5036
Script_502E:: ; heuristic: event script entry or jump target; C0
    script_message $C07E ; 'Warubou Wa-hey! No more dawdling! GreatLog'
    script_skip_if_no Script_5036
    script_jump Script_502E
Script_5036:: ; heuristic: event script entry or jump target; C0
    script_jump Script_5017
Script_5039:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0011
    script_set_flag $0017
    script_command SCRIPT_SCENE_GREATLOG_KEY
    script_message $0085 ; '0 received the GreatLog Key.'
    script_message $0086 ; 'Warubou Dangerous are other worlds! So'
    script_command SCRIPT_SCENE_WARUBOU_WARNING
    script_walk 0, 2, 3
    script_walk 0, 1, 2
    script_face $80, 2
    script_face $00, 0
    script_face $01, 0
    script_message $008C ; 'Slash Hey, why the long faces?'
    script_face $00, 1
    script_face $01, 3
    script_command SCRIPT_SCENE_LONG_FACES
    script_end
Script_5063:: ; heuristic: event script entry or jump target; C0
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
    script_message $0002 ; 'Tara There you are, big brother!'
    script_walk 2, 3, 1
    script_face $82, 1
    script_set_flag $0012
    script_end
Script_509F:: ; heuristic: event script entry or jump target; C0
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
    script_message $0001 ; 'Cobi 0! Papa's calling. He's at'
    script_walk 2, 3, 1
    script_face $82, 1
    script_set_flag $0012
    script_end
Script_50DB:: ; heuristic: event script entry or jump target; C0
    script_message $0013 ; 'Tara Big brother! GreatLog will be'
    script_face $80, 1
    script_slide_y $80
    script_message $0012 ; 'Land ho! There's GreatLog!'
    script_face $81, 1
    script_face $82, 1
    script_face $00, 1
    script_slide_y $82
    script_wait 120
    script_command SCRIPT_SCENE_LAND_HO
    script_end
Script_50F6:: ; heuristic: event script entry or jump target; C0
    script_message $0011 ; 'Cobi 0! They said GreatLog will'
    script_face $80, 1
    script_slide_y $80
    script_message $0012 ; 'Land ho! There's GreatLog!'
    script_face $81, 1
    script_face $82, 1
    script_face $00, 1
    script_slide_y $82
    script_wait 120
    script_command SCRIPT_SCENE_LAND_HO
    script_end
Script_5111:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_SCENE_HORSING_AROUND
    script_message $0015 ; 'Listen you two! Quit your horsing'
    script_walk 0, 2, 5
    script_face $80, 1
    script_face $81, 3
    script_end
Script_5120:: ; heuristic: event script entry or jump target; C0
    script_message $4007 ; 'Sailing is sure exhilarating. Right?'
    script_skip_if_no Script_5129
    script_message $8009 ; 'Is that so? Too bad! You'll'
    script_end
Script_5129:: ; heuristic: event script entry or jump target; C0
    script_message $8008 ; 'Good. That's good to hear! You'
    script_end
Script_512D:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_GREATLOG_FIELD_EVENT
    script_end
Script_512F:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_FIELD_SCENE_01
    script_end
Script_5131:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_RANDOM_GOLD_OR_ITEM
    script_end
Script_5133:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_KEY_WORLD_BOSS_BATTLE
    script_end
Script_5135:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_KEY_WORLD_FLOOR_BATTLE
    script_end
Script_5137:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_PARTY_DEFEATED_RETURN
    script_end
Script_5139:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_RETURN_MESSAGE
    script_end
Script_513B:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_RETURN_WARP
    script_end
Script_513D:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_MAP_EXIT_WARP
    script_end
Script_513F:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_MAP_LINK_WARP
    script_end
Script_5141:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_PLAYER_SPRITE_FLASH
    script_end
Script_5143:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_PLAYER_SPRITE_MESSAGE
    script_end
Script_5145:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_KEY_WORLD_DOOR_ITEM
    script_end
Script_5147:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_AREA_ITEM
    script_end
Script_5149:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_STEP_TRIGGER_REWARD
    script_end
Script_514B:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_FOLLOWERS_STEP_10
    script_end
Script_514D:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_FOLLOWERS_STEP_11
    script_end
Script_514F:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_PLAYER_AND_FOLLOWERS_STEP
    script_end
Script_5151:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_WARP_WITH_FOLLOWERS
    script_end
Script_5153:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_FOLLOWERS_STEP_14
    script_end
Script_5155:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED_FADE
    script_end
Script_5157:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED_CHILD_SPRITE
    script_end
Script_5159:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_BREED_CHILD_SCENE
    script_end
Script_515B:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_NPC_BREED_WARP
    script_end
Script_515D:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_LINK_MESSAGE
    script_end
Script_515F:: ; heuristic: event script entry or jump target; C0
    script_hold_dpad $00, 5
    script_command SCRIPT_ARENA_GRID_BATTLE
    script_end
Script_5164:: ; heuristic: event script entry or jump target; C0
    script_hold_dpad $00, 5
    script_command SCRIPT_ARENA_ROUNDS
    script_end
Script_5169:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_RANDOM_BATTLE
    script_end
Script_516B:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_HEAL_PARTY
    script_end
Script_516D:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_OBJECT_PATH_1B
    script_end
Script_516F:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_OBJECT_PATH_1C
    script_end
Script_5171:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_ENCOUNTER_MESSAGE
    script_end
Script_5173:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_COUNTDOWN_MESSAGE
    script_end
Script_5175:: ; heuristic: event script entry or jump target; C0
    script_message $0100 ; 'Are you going out to play?'
    script_message $0101 ; '0 received an Herb.'
    script_set_flag $01A7
    script_end
Script_517F:: ; heuristic: event script entry or jump target; C0
    script_message $0200 ; 'You e been going out a'
    script_message $0201 ; 'Mom handed over 200G.'
    script_add_gold 200
    script_end
Script_5189:: ; heuristic: event script entry or jump target; C0
    script_message $48A1 ; 'Oh? You'll run another errand?'
    script_skip_if_no Script_5192
    script_message $88A4 ; 'No miracles today! Oh, well. Of'
    script_end
Script_5192:: ; heuristic: event script entry or jump target; C0
    script_message $88A2 ; 'My, what has gotten into you?'
    script_message $08A3 ; 'Mama handed over 400G.'
    script_add_gold 400
    script_set_flag $0183
    script_end
Script_519F:: ; heuristic: event script entry or jump target; C0
    script_message $08A6 ; 'Oh You e found what I'
    script_message $08A7 ; '0 handed over the Potion.'
    script_set_flag $0184
    script_end
Script_51A9:: ; heuristic: event script entry or jump target; C0
    script_message $48A1 ; 'Oh? You'll run another errand?'
    script_skip_if_no Script_51B2
    script_message $88A4 ; 'No miracles today! Oh, well. Of'
    script_end
Script_51B2:: ; heuristic: event script entry or jump target; C0
    script_message $88A8 ; 'Well, could you go buy a'
    script_message $08A9 ; 'Mama handed over 600G.'
    script_add_gold 600
    script_set_flag $0185
    script_end
Script_51BF:: ; heuristic: event script entry or jump target; C0
    script_message $08A6 ; 'Oh You e found what I'
    script_message $08AC ; '0 handed over the Rib.'
    script_set_flag $0186
    script_end
    db $00, $01, $43, $06, $04, $00, $04, $83, $FF, $00, $02, $83, $00, $03, $03, $0E
    db $B0, $04, $0A, $87, $01, $FF, $00, $01, $43, $06, $04, $00, $04, $83, $FF, $00
    db $07, $83, $00, $08, $03, $0E, $B0, $04, $0A, $89, $01, $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_51F5:: ; heuristic: event script entry or jump target; C0
    script_message $4A25 ; 'I was going to ask Tara,'
    script_skip_if_no Script_51FE
    script_message $8A26 ; 'Oh Then I'll ask Tara.'
    script_end
Script_51FE:: ; heuristic: event script entry or jump target; C0
    script_message $8A22 ; 'The farm that your father always'
    script_message $0A23 ; 'Mama handed over 1,200G.'
    script_add_gold 1200
    script_set_flag $018B
    script_end
Script_520B:: ; heuristic: event script entry or jump target; C0
    script_message $4A21 ; 'I was going to ask Cobi,'
    script_skip_if_no Script_5214
    script_message $8A24 ; 'Oh Then I'll ask Cobi.'
    script_end
Script_5214:: ; heuristic: event script entry or jump target; C0
    script_message $8A22 ; 'The farm that your father always'
    script_message $0A23 ; 'Mama handed over 1,200G.'
    script_add_gold 1200
    script_set_flag $018B
    script_end
Script_5221:: ; heuristic: event script entry or jump target; C0
    script_message $0A28 ; 'They didn't have any around here.'
    script_message $0A29 ; '0 handed over the Sirloin.'
    script_set_flag $018C
    script_end
Script_522B:: ; heuristic: event script entry or jump target; C0
    script_message $0212 ; 'Oh? You bought the LoveWater! This'
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
Script_5256:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0102
    script_message $410D ; 'Cobi Hi, I'm helping Papa to'
    script_jump_data_bank String_1F_00_3E
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5260:: ; heuristic: event script entry or jump target; C0
    script_message $410E ; 'Cobi Hi, 0! What's up today?'
    script_jump_data_bank String_1F_00_3E
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5267:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0105
    script_message $4207 ; 'Cobi 0, what was it like'
    script_jump_data_bank String_1F_00_3E
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5271:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0109
    script_message $48BC ; 'Cobi 0, what was it like'
    script_jump_data_bank String_1F_00_3E
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_527B:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0115
    script_message $4A30 ; 'Cobi 0, what was it like'
    script_jump_data_bank String_1F_00_3E
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5285:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0121
    script_message $4502 ; 'Cobi 0, tell me about what'
    script_jump_data_bank String_1F_00_3E
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_528F:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0131
    script_message $4B02 ; 'Cobi 0, I envied you for'
    script_jump_data_bank String_1F_00_3E
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5299:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0102
    script_message $410F ; 'Tara I'm helping Papa take care'
    script_jump_data_bank String_1F_00_3E
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_52A3:: ; heuristic: event script entry or jump target; C0
    script_message $4110 ; 'Tara Hi! How are you? Do'
    script_jump_data_bank String_1F_00_3E
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_52AA:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0105
    script_message $4208 ; 'Tara Big brother, have you found'
    script_jump_data_bank String_1F_00_3E
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_52B4:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0109
    script_message $48BD ; 'Tara Big brother, tell me about'
    script_jump_data_bank String_1F_00_3E
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_52BE:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0115
    script_message $4A31 ; 'Tara Big brother, tell me about'
    script_jump_data_bank String_1F_00_3E
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_52C8:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0121
    script_message $4503 ; 'Tara Big brother, tell me about'
    script_jump_data_bank String_1F_00_3E
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_52D2:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0131
    script_message $4B03 ; 'Tara 0, I was a little'
    script_jump_data_bank String_1F_00_3E
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_52DC:: ; heuristic: event script entry or jump target; C0
    script_message $0105 ; 'Why do you have a monster'
    script_message $0106 ; '0 received a PorkChop.'
    script_end
Script_52E3:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0190
    script_message $48AF ; 'Beavern helped put up the bridge.'
    script_skip_if_no Script_52EF
    script_message $88B1 ; 'If one joins you, could you'
    script_end
Script_52EF:: ; heuristic: event script entry or jump target; C0
    script_message $88B0 ; 'I like to get help for'
    script_end
Script_52F3:: ; heuristic: event script entry or jump target; C0
    script_message $48B3 ; 'A MadGopher joined you? Could you'
    script_skip_if_no Script_52FC
    script_message $88B5 ; '0, I need your help. Please'
    script_end
Script_52FC:: ; heuristic: event script entry or jump target; C0
    script_message $88B4 ; 'Great, 0! Thanks a lot! This'
    script_command SCRIPT_REWARD_ITEM_OR_KEY
    script_message $0D17 ; 'Here, 0! You need this!'
    script_message $0D18 ; '0 received the Ice Key.'
    script_message $0D19 ; 'Be careful when you're traveling in'
    script_set_flag $0191
    script_end
Script_530D:: ; heuristic: event script entry or jump target; C0
    script_message $48B3 ; 'A MadGopher joined you? Could you'
    script_skip_if_no Script_5316
    script_message $88B5 ; '0, I need your help. Please'
    script_end
Script_5316:: ; heuristic: event script entry or jump target; C0
    script_message $88B4 ; 'Great, 0! Thanks a lot! This'
    script_command SCRIPT_REWARD_ITEM_OR_KEY
    script_message $0D48 ; 'Here, 0! You hold onto it.'
    script_set_flag $01A3
    script_set_flag $0191
    script_end
Script_5324:: ; heuristic: event script entry or jump target; C0
    script_message $48B3 ; 'A MadGopher joined you? Could you'
    script_skip_if_no Script_532D
    script_message $88B5 ; '0, I need your help. Please'
    script_end
Script_532D:: ; heuristic: event script entry or jump target; C0
    script_message $88B4 ; 'Great, 0! Thanks a lot! This'
    script_command SCRIPT_REWARD_ITEM_OR_KEY
    script_message $0D47 ; 'Here, 0! You hold onto it.'
    script_message $0D41 ; '0 received a TinyMedal!'
    script_message $0D19 ; 'Be careful when you're traveling in'
    script_set_flag $0191
    script_end
Script_533E:: ; heuristic: event script entry or jump target; C0
Data_010_533E:: ; address name
    script_message $420D ; 'You're too young to be shopping.'
    script_jump_data_bank Script_6659
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5345:: ; heuristic: event script entry or jump target; C0
Data_010_5345:: ; address name
    script_message $420E ; 'Welcome! How may I serve you'
    script_jump_data_bank Script_6659
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_534C:: ; heuristic: event script entry or jump target; C0
Data_010_534C:: ; address name
    script_message $4D89 ; 'Well, well! If it isn't the'
    script_jump_data_bank Script_6659
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5353:: ; heuristic: event script entry or jump target; C0
Data_010_5353:: ; address name
    script_set_flag $0103
    script_message $411C ; 'Oh, hi! Good to see you'
    script_jump_data_bank Script_67B5
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_535D:: ; heuristic: event script entry or jump target; C0
    script_message $411D ; 'How may the Vault serve you?'
    script_jump_data_bank Script_67B5
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5364:: ; heuristic: event script entry or jump target; C0
Data_010_5364:: ; address name
    script_set_flag $0127
    script_message $4B1C ; 'Hello, GreatLog's hero! Do you still'
    script_jump_data_bank Script_67B5
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_536E:: ; heuristic: event script entry or jump target; C0
    script_message $411F ; 'Warubou Wa-hey! You remember the promise'
    script_skip_if_no Script_5377
    script_message $8121 ; 'Warubou Use a Magic Key and'
    script_end
Script_5377:: ; heuristic: event script entry or jump target; C0
    script_message $8120 ; 'Warubou Quit dawdling, warooh!'
    script_end
    db $00, $9E, $42, $06, $04, $00, $A2, $82, $FF, $00, $9F, $82, $FF, $00, $9E, $42
    db $06, $04, $00, $A2, $82, $FF, $00, $A0, $82, $FF, $00, $A3, $02, $3B, $0A, $2F
    db $01, $FF, $00, $A3, $02, $3B, $0A, $35, $01, $FF, $00, $A3, $02, $3B, $0A, $39
    db $01, $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_53AD:: ; heuristic: event script entry or jump target; C0
    script_message $452A ; 'Warubou Wa-hey! Are you ready? Ready'
    script_skip_if_no Script_53B6
    script_message $8531 ; 'Warubou Wa-hey, well, hurry it up!'
    script_end
Script_53B6:: ; heuristic: event script entry or jump target; C0
    script_message $8530 ; 'Warubou Wa-hey! Take the treasures that'
    script_end
Script_53BA:: ; heuristic: event script entry or jump target; C0
    script_message $452A ; 'Warubou Wa-hey! Are you ready? Ready'
    script_skip_if_no Script_53C3
    script_message $8531 ; 'Warubou Wa-hey, well, hurry it up!'
    script_end
Script_53C3:: ; heuristic: event script entry or jump target; C0
    script_message $852B ; 'Warubou Wa-hey! Take the treasures that'
    script_command SCRIPT_SCENE_LIMBO
    script_message $052F ; 'Warubou Limbo is the King's domain!'
    script_set_flag $013B
    script_end
Script_53CE:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_SCENE_LIMBO_MONSTER
    script_end
Script_53D0:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_SCENE_LIMBO_MONSTER_2
    script_end
Script_53D2:: ; heuristic: event script entry or jump target; C0
    script_message $4A36 ; 'Prince Kameha has been missing from'
    script_skip_if_no Script_53DB
    script_message $8A38 ; 'You better be telling the truth.'
    script_end
Script_53DB:: ; heuristic: event script entry or jump target; C0
    script_message $8A37 ; 'What's that? You saw Prince Kameha'
    script_set_flag $0117
    script_command SCRIPT_SCENE_SAW_KAMEHA
    script_message $0A3A ; 'Sire, this child claims to know'
    script_message $0A3B ; 'King What's that? Is that so?'
    script_walk 0, 0, 1
    script_message $0D28 ; '0 obtained the Sky Key.'
    script_walk 0, 2, 1
    script_face $80, 0
    script_message $0D29 ; 'King Kameha made off with the'
    script_end
Script_53FA:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0117
    script_message $4504 ; 'If the island sink, is no'
    script_skip_if_no Script_540D
    script_message $8506 ; 'Hey! You're the kid who said'
    script_command SCRIPT_SCENE_KAMEHA_BACK
    script_message $0507 ; 'Prince Kameha came back! What with'
    script_set_flag $0122
    script_end
Script_540D:: ; heuristic: event script entry or jump target; C0
    script_message $8505 ; 'People have been saying that they'
    script_command SCRIPT_SCENE_KAMEHA_BACK
    script_message $0507 ; 'Prince Kameha came back! What with'
    script_set_flag $0122
    script_end
Script_5418:: ; heuristic: event script entry or jump target; C0
    script_message $021D ; 'Take this slide as a shortcut!'
    script_sound $65
    script_walk 1, 0, 3
    script_end
Script_5422:: ; heuristic: event script entry or jump target; C0
    script_message $4264 ; 'Oh You're so lucky to have'
    script_skip_if_no Script_542B
    script_message $8266 ; 'Oh Sorry It's your friend'
    script_end
Script_542B:: ; heuristic: event script entry or jump target; C0
    script_message $8265 ; 'R Really? Wow! Thank you! I'
    script_command SCRIPT_SCENE_MASTER_THANKS
    script_set_flag $012D
    script_end
Script_5433:: ; heuristic: event script entry or jump target; C0
    script_message $4B47 ; 'I became a master because I'
    script_skip_if_no Script_543C
    script_message $8D81 ; 'Aww How boring Visit us again!'
    script_end
Script_543C:: ; heuristic: event script entry or jump target; C0
    script_message $8D80 ; 'Really? Let's go to the Arena!'
    script_command SCRIPT_SCENE_ARENA_CHALLENGE
    script_end
Script_5441:: ; heuristic: event script entry or jump target; C0
    script_message $4227 ; '0 checked the pedestal. It's the'
    script_skip_if_no Script_544A
    script_message $8229 ; '0 put back the Library Guide.'
    script_end
Script_544A:: ; heuristic: event script entry or jump target; C0
    script_message $8228 ; 'You may check your Catalog of'
    script_end
Script_544E:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0108
    script_message $422A ; 'Welcome to the Library. You may'
    script_jump_data_bank Script_1F_787B
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5458:: ; heuristic: event script entry or jump target; C0
    script_message $422B ; 'Welcome to the Library. Which family'
    script_jump_data_bank Script_1F_787B
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_545F:: ; heuristic: event script entry or jump target; C0
    script_set_flag $002D
    script_message $4B49 ; 'Hello, our young savior! Have you'
    script_jump_data_bank Script_1F_787B
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5469:: ; heuristic: event script entry or jump target; C0
    script_set_flag $019E
    script_message $4DF0 ; 'Welcome to the Library! Your monster'
    script_message $CDF1 ; 'We need fanfare right about now'
    script_jump_data_bank Script_1F_787B
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5476:: ; heuristic: event script entry or jump target; C0
    script_message $4230 ; 'Do you have any idea about'
    script_skip_if_no Script_547F
    script_message $8232 ; 'Monsters can be categorized in ten'
    script_end
Script_547F:: ; heuristic: event script entry or jump target; C0
    script_message $8231 ; 'Oh You e read this book'
    script_end
Script_5483:: ; heuristic: event script entry or jump target; C0
    script_message $4246 ; 'Hey, let me ask you something.'
    script_skip_if_no Script_548C
    script_message $8248 ; 'Good, you're lucky! Stay away, that's'
    script_end
Script_548C:: ; heuristic: event script entry or jump target; C0
    script_message $8247 ; 'Did she say anything to you?'
    script_end
Script_5490:: ; heuristic: event script entry or jump target; C0
    script_message $4257 ; 'Did you know that there's a'
    script_skip_if_no Script_5499
    script_message $8259 ; 'Go visit the Christener. She's a'
    script_end
Script_5499:: ; heuristic: event script entry or jump target; C0
    script_message $8258 ; 'Monsters should have cute names.'
    script_end
Script_549D:: ; heuristic: event script entry or jump target; C0
    script_message $44C3 ; 'Welcome. I'm the Christener. I can'
    script_jump_data_bank Script_96_6FF8
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_54A4:: ; heuristic: event script entry or jump target; C0
    script_message $44C4 ; 'Welcome. I'm the Christener. Do you'
    script_jump_data_bank Script_96_6FF8
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_54AB:: ; heuristic: event script entry or jump target; C0
    script_message $4A4E ; 'Hello, 0, welcome! This is the'
    script_jump_data_bank Script_1D_4335
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_54B2:: ; heuristic: event script entry or jump target; C0
    script_message $4A4F ; 'Hello, 0, welcome! Want to use'
    script_jump_data_bank Script_1D_4335
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_54B9:: ; heuristic: event script entry or jump target; C0
    script_message $4A5A ; '0 checked the casket.'
    script_message $8A5B ; 'Zzz Use the plan Charge in'
    script_end
Script_54C0:: ; heuristic: event script entry or jump target; C0
    script_message $4A5A ; '0 checked the casket.'
    script_message $8A5C ; 'Zzz Hnnnnnrgh Huh? Being Cautious in'
    script_end
Script_54C7:: ; heuristic: event script entry or jump target; C0
    script_message $4A5E ; '0 peered into the hole.'
    script_message $8A5F ; 'Zzz Zzz Some skills are developed'
    script_end
Script_54CE:: ; heuristic: event script entry or jump target; C0
    script_message $4281 ; 'Oh, a cute little master! Are'
    script_skip_if_no Script_54D7
    script_message $8283 ; 'Oh. Well, I'll be here for'
    script_end
Script_54D7:: ; heuristic: event script entry or jump target; C0
    script_message $8282 ; 'In the Kids Class final, watch'
    script_end
Script_54DB:: ; heuristic: event script entry or jump target; C0
    script_message $4A60 ; 'Oh, you're the Kids Class Champ!'
    script_skip_if_no Script_54E4
    script_message $8283 ; 'Oh. Well, I'll be here for'
    script_end
Script_54E4:: ; heuristic: event script entry or jump target; C0
    script_message $8A61 ; 'In the C Class final, you'll'
    script_end
Script_54E8:: ; heuristic: event script entry or jump target; C0
    script_message $4A62 ; 'Oh, you're the C Class Champ!'
    script_skip_if_no Script_54F1
    script_message $8283 ; 'Oh. Well, I'll be here for'
    script_end
Script_54F1:: ; heuristic: event script entry or jump target; C0
    script_message $8A63 ; 'In the B Class final, you'll'
    script_end
Script_54F5:: ; heuristic: event script entry or jump target; C0
    script_message $4A64 ; 'Oh, you're the B Class Champ!'
    script_skip_if_no Script_54FE
    script_message $8283 ; 'Oh. Well, I'll be here for'
    script_end
Script_54FE:: ; heuristic: event script entry or jump target; C0
    script_message $8A65 ; 'In the A Class final, you'll'
    script_end
Script_5502:: ; heuristic: event script entry or jump target; C0
    script_message $4A66 ; 'Oh, you're the A Class Champ!'
    script_skip_if_no Script_550B
    script_message $8283 ; 'Oh. Well, I'll be here for'
    script_end
Script_550B:: ; heuristic: event script entry or jump target; C0
    script_message $8A67 ; 'In the S Class final, you'll'
    script_end
Script_550F:: ; heuristic: event script entry or jump target; C0
    script_message $4281 ; 'Oh, a cute little master! Are'
    script_skip_if_no Script_5518
    script_message $8283 ; 'Oh. Well, I'll be here for'
    script_end
Script_5518:: ; heuristic: event script entry or jump target; C0
    script_message $8216 ; 'Play it safe against Skullroo. It's'
    script_end
Script_551C:: ; heuristic: event script entry or jump target; C0
    script_message $4A60 ; 'Oh, you're the Kids Class Champ!'
    script_skip_if_no Script_5525
    script_message $8283 ; 'Oh. Well, I'll be here for'
    script_end
Script_5525:: ; heuristic: event script entry or jump target; C0
    script_message $8A7F ; 'In the C Class final, you'll'
    script_end
Script_5529:: ; heuristic: event script entry or jump target; C0
    script_message $4A62 ; 'Oh, you're the C Class Champ!'
    script_skip_if_no Script_5532
    script_message $8283 ; 'Oh. Well, I'll be here for'
    script_end
Script_5532:: ; heuristic: event script entry or jump target; C0
    script_message $8A80 ; 'In the B Class final, you'll'
    script_end
Script_5536:: ; heuristic: event script entry or jump target; C0
    script_message $4A64 ; 'Oh, you're the B Class Champ!'
    script_skip_if_no Script_553F
    script_message $8283 ; 'Oh. Well, I'll be here for'
    script_end
Script_553F:: ; heuristic: event script entry or jump target; C0
    script_message $8A81 ; 'In the A Class final, you'll'
    script_end
Script_5543:: ; heuristic: event script entry or jump target; C0
    script_message $4A66 ; 'Oh, you're the A Class Champ!'
    script_skip_if_no Script_554C
    script_message $8283 ; 'Oh. Well, I'll be here for'
    script_end
Script_554C:: ; heuristic: event script entry or jump target; C0
    script_message $8A82 ; 'In the S Class final, you'll'
    script_end
Script_5550:: ; heuristic: event script entry or jump target; C0
    script_message $426B ; 'Welcome to the Arena! Masters pit'
    script_skip_if_no Script_5559
    script_message $826D ; 'Oh, then you must be here'
    script_end
Script_5559:: ; heuristic: event script entry or jump target; C0
    script_message $C26C ; 'You're young, so you have to'
    script_jump_data_bank Script_0C_7A51
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5560:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0189
    script_message $4270 ; 'Welcome to the Arena! The rules'
    script_jump_data_bank Script_0C_7A51
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_556A:: ; heuristic: event script entry or jump target; C0
    script_message $4271 ; 'Hello, which Class will it be?'
    script_jump_data_bank Script_0C_7A51
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5571:: ; heuristic: event script entry or jump target; C0
    script_message $4D86 ; 'Welcome! Do you wish to battle?'
    script_jump_data_bank Script_0C_7A51
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5578:: ; heuristic: event script entry or jump target; C0
    script_message $4275 ; 'Here's the Magic Key you won!'
    script_message $8274 ; 'Oh? But your key ring is'
    script_end
Script_557F:: ; heuristic: event script entry or jump target; C0
    script_message $0275 ; 'Here's the Magic Key you won!'
    script_message $0273 ; '0 received a Magic Key.'
    script_end
Script_5586:: ; heuristic: event script entry or jump target; C0
    script_message $04B0 ; 'I lost again. I need to'
    script_end
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_558B:: ; heuristic: event script entry or jump target; C0
    script_message $44B3 ; 'I lost again. I need to'
    script_skip_if_no Script_5594
    script_message $84B2 ; 'I'll be here for a while'
    script_end
Script_5594:: ; heuristic: event script entry or jump target; C0
    script_message $C4B1 ; 'Good! Let's get started!'
    script_end
Script_5598:: ; heuristic: event script entry or jump target; C0
    script_message $48CF ; 'Um I'm the Egg Evaluator. You'
    script_set_flag $010F
    script_jump_data_bank Script_96_6EF7
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_55A2:: ; heuristic: event script entry or jump target; C0
    script_message $48D0 ; 'I'm the Egg Evaluator. May I'
    script_jump_data_bank Script_96_6EF7
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_55A9:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0028
    script_message $4B20 ; 'Oh, the savior of GreatLog. I'm'
    script_jump_data_bank Script_96_6EF7
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_55B3:: ; heuristic: event script entry or jump target; C0
    script_message $48D3 ; 'Welcome to the Starry Shrine. I'm'
    script_set_flag $0110
    script_jump_data_bank Script_15_764B
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_55BD:: ; heuristic: event script entry or jump target; C0
    script_message $48D4 ; 'Welcome to the Starry Shrine. What'
    script_jump_data_bank Script_15_764B
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_55C4:: ; heuristic: event script entry or jump target; C0
    script_set_flag $002C
    script_message $4B2E ; 'Aren't you GreatLog's savior? Well, has'
    script_jump_data_bank Script_15_764B
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_55CE:: ; heuristic: event script entry or jump target; C0
    script_message $48D5 ; 'I'm the Prof's assistant. Do you'
    script_skip_if_no Script_55D7
    script_message $88D7 ; 'Talk to the Prof if you'
    script_end
Script_55D7:: ; heuristic: event script entry or jump target; C0
    script_message $88D6 ; 'You can breed monsters and hatch'
    script_end
Script_55DB:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0112
    script_message $4A6D ; 'You can call me the Medal'
    script_jump_data_bank Script_0C_7BA9
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_55E5:: ; heuristic: event script entry or jump target; C0
    script_message $4A6E ; 'You can call me the Medal'
    script_jump_data_bank Script_0C_7BA9
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_55EC:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0031
    script_message $4B50 ; 'Well, who would have thought such'
    script_jump_data_bank Script_0C_7BA9
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_55F6:: ; heuristic: event script entry or jump target; C0
    script_message $025F ; 'I e never seen my granddaughter'
    script_message $0260 ; '0 received a LifeAcorn.'
    script_set_flag $012E
    script_end
Script_5600:: ; heuristic: event script entry or jump target; C0
    script_message $48C8 ; 'Wait! Could I get you to'
    script_skip_if_no Script_5609
    script_message $88CA ; 'Oh That's very disappointing. I could'
    script_end
Script_5609:: ; heuristic: event script entry or jump target; C0
    script_message $88C9 ; 'Fantastic! I can open my shop'
    script_command SCRIPT_REWARD_ITEM_OR_KEY_2
    script_message $0D40 ; 'I like you to have this.'
    script_message $0D18 ; '0 received the Ice Key.'
    script_message $0D42 ; 'I'll pray for your safety. Take'
    script_set_flag $0134
    script_end
Script_561A:: ; heuristic: event script entry or jump target; C0
    script_message $48C8 ; 'Wait! Could I get you to'
    script_skip_if_no Script_5623
    script_message $88CA ; 'Oh That's very disappointing. I could'
    script_end
Script_5623:: ; heuristic: event script entry or jump target; C0
    script_message $88C9 ; 'Fantastic! I can open my shop'
    script_command SCRIPT_REWARD_ITEM_OR_KEY_2
    script_message $0D43 ; 'I like you to have this.'
    script_set_flag $01A5
    script_set_flag $0134
    script_end
Script_5631:: ; heuristic: event script entry or jump target; C0
    script_message $48C8 ; 'Wait! Could I get you to'
    script_skip_if_no Script_563A
    script_message $88CA ; 'Oh That's very disappointing. I could'
    script_end
Script_563A:: ; heuristic: event script entry or jump target; C0
    script_message $88C9 ; 'Fantastic! I can open my shop'
    script_command SCRIPT_REWARD_ITEM_OR_KEY_2
    script_message $0D40 ; 'I like you to have this.'
    script_message $0D41 ; '0 received a TinyMedal!'
    script_message $0D42 ; 'I'll pray for your safety. Take'
    script_set_flag $0134
    script_end
Script_564B:: ; heuristic: event script entry or jump target; C0
Data_010_564B:: ; address name
    script_message $48CB ; 'ArmyAnt helped me get my shop'
    script_jump_data_bank Script_6659
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5652:: ; heuristic: event script entry or jump target; C0
    script_message $48CC ; 'Welcome! How may I serve you?'
    script_jump_data_bank Script_6659
    db $FF, $00, $8A, $4D, $E7, $59, $66, $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5660:: ; heuristic: event script entry or jump target; C0
    script_message $4A46 ; 'I'm a traveling merchant. I'm also'
    script_skip_if_no Script_5669
    script_message $8A48 ; 'Oh, too bad. Another time.'
    script_end
Script_5669:: ; heuristic: event script entry or jump target; C0
    script_message $CA47 ; 'Then let's breed them!'
    script_jump_data_bank Script_0E_7F8B
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5670:: ; heuristic: event script entry or jump target; C0
    script_message $4513 ; 'I'm a scientist. I e been'
    script_skip_if_no Script_5679
    script_message $8515 ; 'Oh Perhaps on another occasion.'
    script_end
Script_5679:: ; heuristic: event script entry or jump target; C0
    script_message $C514 ; 'Well, let's see about breeding!'
    script_jump_data_bank Script_0E_7F8B
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5680:: ; heuristic: event script entry or jump target; C0
    script_message $44B7 ; 'Hm? Little one, are you a'
    script_skip_if_no Script_5689
    script_message $84B9 ; 'Oh, too bad. Another time. Tell'
    script_end
Script_5689:: ; heuristic: event script entry or jump target; C0
    script_message $C4B8 ; 'Good! Let's get this started!'
    script_jump_data_bank Script_0E_7F8B
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5690:: ; heuristic: event script entry or jump target; C0
    script_message $44C8 ; 'I was once a great master'
    script_skip_if_no Script_569C
    script_message $84CA ; 'You e not found any yet?'
    script_set_flag $011D
    script_end
Script_569C:: ; heuristic: event script entry or jump target; C0
    script_message $84C9 ; 'Have you shown them to the'
    script_end
Script_56A0:: ; heuristic: event script entry or jump target; C0
    script_message $0B4C ; 'Oh! Goodness! I'm surprised! I e'
    script_command SCRIPT_SCENE_KEY_SHOP
    script_set_flag $002F
    script_end
Script_56A8:: ; heuristic: event script entry or jump target; C0
    script_message $0BBF ; 'How good of you to overcome'
    script_command SCRIPT_SCENE_KEY_SHOP
    script_end
Script_56AD:: ; heuristic: event script entry or jump target; C0
    script_set_flag $011F
    script_message $4297 ; 'Welcome to my Key Shop! I'
    script_jump_data_bank Script_0D_62B8
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_56B7:: ; heuristic: event script entry or jump target; C0
    script_message $4298 ; 'Welcome to my Key Shop! Should'
    script_jump_data_bank Script_0D_62B8
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_56BE:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0113
    script_message $4B1E ; 'You're GreatLog's savior! Do you need'
    script_jump_data_bank Script_0D_62B8
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_56C8:: ; heuristic: event script entry or jump target; C0
    script_message $44BD ; 'Yo! Up close, you look tougher'
    script_skip_if_no Script_56D1
    script_message $84BF ; 'What? Are you sure about that?'
    script_end
Script_56D1:: ; heuristic: event script entry or jump target; C0
    script_message $C4BE ; 'I like your style! Let's get'
    script_jump_data_bank Script_0E_7F8B
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_56D8:: ; heuristic: event script entry or jump target; C0
    script_message $4277 ; 'Welcome to the Arena! Would you'
    script_skip_if_no Script_56E1
    script_message $8279 ; 'Oops, it's not your first time!'
    script_end
Script_56E1:: ; heuristic: event script entry or jump target; C0
    script_message $8278 ; 'Your party may enter in battles'
    script_end
Script_56E5:: ; heuristic: event script entry or jump target; C0
    script_message $4277 ; 'Welcome to the Arena! Would you'
    script_skip_if_no Script_56EE
    script_message $8B66 ; 'Oops, it's not your first time!'
    script_end
Script_56EE:: ; heuristic: event script entry or jump target; C0
    script_message $8B65 ; 'As a pro master, you can'
    script_end
Script_56F2:: ; heuristic: event script entry or jump target; C0
    script_encounter $1A ; encounter words: Slime, Slime, Slime
    script_end
Script_56F5:: ; heuristic: event script entry or jump target; C0
    script_walk 2, 3, 2
    script_face $00, 1
    script_message $0546 ; 'Cobi 0, congratulations! I thought we'
    script_wait 60
    script_sound $28
    script_message $0547 ; 'Hehehe, no need to worry there!'
    script_command SCRIPT_SCENE_HOMECOMING
    script_end
Script_5709:: ; heuristic: event script entry or jump target; C0
    script_walk 2, 3, 2
    script_face $00, 1
    script_message $054A ; 'Tara 0, congratulations! I was sad'
    script_wait 60
    script_sound $28
    script_message $0547 ; 'Hehehe, no need to worry there!'
    script_command SCRIPT_SCENE_HOMECOMING
    script_end
Script_571D:: ; heuristic: event script entry or jump target; C0
    script_message $4111 ; 'Want to know how the farm'
    script_skip_if_no Script_5726
    script_message $8113 ; 'Aww You know already? Boring!'
    script_end
Script_5726:: ; heuristic: event script entry or jump target; C0
    script_message $8112 ; 'Including the monsters with you, the'
    script_end
Script_572A:: ; heuristic: event script entry or jump target; C0
    script_message $4111 ; 'Want to know how the farm'
    script_skip_if_no Script_5733
    script_message $8113 ; 'Aww You know already? Boring!'
    script_end
Script_5733:: ; heuristic: event script entry or jump target; C0
    script_message $8255 ; 'The farm grew a lot bigger.'
    script_end
Script_5737:: ; heuristic: event script entry or jump target; C0
    script_message $4111 ; 'Want to know how the farm'
    script_skip_if_no Script_5740
    script_message $8113 ; 'Aww You know already? Boring!'
    script_end
Script_5740:: ; heuristic: event script entry or jump target; C0
    script_message $88BE ; 'Including the monsters with you, the'
    script_end
Script_5744:: ; heuristic: event script entry or jump target; C0
    script_message $4A54 ; 'Do you want to know how'
    script_skip_if_no Script_574D
    script_message $8A58 ; 'Everyone has a growth limit. Whether'
    script_end
Script_574D:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_GROWTH_LIMIT_INFO
    script_message $8A57 ; 'Once a monster reaches its growth'
    script_end
Script_5752:: ; heuristic: event script entry or jump target; C0
    script_message $4289 ; 'Hello there. Do you know about'
    script_skip_if_no Script_575B
    script_message $828B ; 'You don't know? Sorry about that.'
    script_end
Script_575B:: ; heuristic: event script entry or jump target; C0
    script_message $828A ; 'The strongest master I e ever'
    script_end
Script_575F:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_SCENE_STRONGEST_MASTER
    script_set_flag $012B
    script_end
    db $00, $70, $4A, $06, $04, $00, $73, $8A, $FF, $00, $72, $8A, $FF, $00, $70, $4A
    db $06, $04, $00, $73, $8A, $FF, $00, $71, $8A, $02, $02, $02, $03, $02, $02, $03
    db $01, $02, $02, $02, $01, $05, $80, $03, $05, $82, $01, $03, $3C, $00, $60, $03
    db $3C, $00, $0F, $48, $4C, $03, $1E, $00, $0F, $FF, $0A, $37, $01, $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_57A2:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0138
    script_wait 30
    script_command SCRIPT_SCENE_KAMEHA_MISSING
    script_walk_fast 0, 0, 5
    script_message $4A36 ; 'Prince Kameha has been missing from'
    script_skip_if_no Script_57BD
    script_message $8A38 ; 'You better be telling the truth.'
    script_walk_fast 0, 2, 5
    script_face $80, 0
    script_end
Script_57BD:: ; heuristic: event script entry or jump target; C0
    script_message $8A37 ; 'What's that? You saw Prince Kameha'
    script_set_flag $0117
    script_command SCRIPT_SCENE_SAW_KAMEHA
    script_message $0A3A ; 'Sire, this child claims to know'
    script_message $0A3B ; 'King What's that? Is that so?'
    script_walk 0, 0, 1
    script_message $0D28 ; '0 obtained the Sky Key.'
    script_walk 0, 2, 1
    script_face $80, 0
    script_message $0D29 ; 'King Kameha made off with the'
    script_end
Script_57DC:: ; heuristic: event script entry or jump target; C0
    script_face $00, 3
    script_command SCRIPT_SCENE_KAMEHA_STOLE
    script_end
Script_57E1:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_PERSONALITY_MESSAGE
    script_end
Script_57E3:: ; heuristic: event script entry or jump target; C0
    script_message $0D60 ; 'What will you give to the'
    script_command SCRIPT_SAVE_SCREEN
    script_end
Script_57E8:: ; heuristic: event script entry or jump target; C0
    script_message $0D61 ; 'Y has been given to the'
    script_command SCRIPT_SAVE_SCREEN
    script_end
Script_57ED:: ; heuristic: event script entry or jump target; C0
Data_010_57ED:: ; address name
    script_set_flag $012C
    script_message $4B16 ; 'I'm sorry. I was wrong about'
    script_jump_data_bank Script_6707
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_57F7:: ; heuristic: event script entry or jump target; C0
    script_message $4B17 ; 'Hello! How may I serve you'
    script_jump_data_bank Script_6707
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_57FE:: ; heuristic: event script entry or jump target; C0
    script_message $4B21 ; 'Hello, hero! Let me help you!'
    script_skip_if_no Script_5807
    script_message $8B24 ; 'Oh Well, that's too bad, then.'
    script_end
Script_5807:: ; heuristic: event script entry or jump target; C0
    script_message $8B23 ; 'Oh? But there's no room for'
    script_end
Script_580B:: ; heuristic: event script entry or jump target; C0
    script_message $4B21 ; 'Hello, hero! Let me help you!'
    script_skip_if_no Script_5814
    script_message $8B24 ; 'Oh Well, that's too bad, then.'
    script_end
Script_5814:: ; heuristic: event script entry or jump target; C0
    script_message $8B22 ; 'You'll take it? Excellent! I'll send'
    script_command SCRIPT_GIVE_MONSTER
    script_set_flag $0029
    script_end
Script_581C:: ; heuristic: event script entry or jump target; C0
    script_message $4B53 ; 'Didn't you save GreatLog? That is'
    script_skip_if_no Script_5825
    script_message $8B55 ; 'Oh. Too bad. Maybe next time.'
    script_end
Script_5825:: ; heuristic: event script entry or jump target; C0
    script_message $CB54 ; 'Great! Let's give it a try!'
    script_jump_data_bank Script_0E_7F8B
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_582C:: ; heuristic: event script entry or jump target; C0
    script_message $4B57 ; 'Ah, you must be the little'
    script_skip_if_no Script_5835
    script_message $8B59 ; 'May misfortune shun you. I'll await'
    script_end
Script_5835:: ; heuristic: event script entry or jump target; C0
    script_message $CB58 ; 'May good fortune arrive quickly. Please,'
    script_jump_data_bank Script_0E_7F8B
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_583C:: ; heuristic: event script entry or jump target; C0
    script_message $4B5B ; 'I didn't think GreatLog's hero could'
    script_skip_if_no Script_5845
    script_message $8B5D ; 'Oh That's so disappointing. Well, come'
    script_end
Script_5845:: ; heuristic: event script entry or jump target; C0
    script_message $CB5C ; 'Well, no time to lose! Quick!'
    script_jump_data_bank Script_0E_7F8B
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_584C:: ; heuristic: event script entry or jump target; C0
    script_message $4B6A ; 'Are you perhaps GreatLog's savior? Hey,'
    script_skip_if_no Script_5855
    script_message $8B6C ; 'No? Well, if we meet again'
    script_end
Script_5855:: ; heuristic: event script entry or jump target; C0
    script_message $CB6B ; 'OK! Let the breeding happen!'
    script_jump_data_bank Script_0E_7F8B
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_585C:: ; heuristic: event script entry or jump target; C0
    script_message $4B70 ; 'Hey! You're still at it, youngster?'
    script_skip_if_no Script_5865
    script_message $8B72 ; 'That's too bad. It's a waste'
    script_end
Script_5865:: ; heuristic: event script entry or jump target; C0
    script_message $CB71 ; 'Great! Good answer!'
    script_jump_data_bank Script_0E_7F8B
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_586C:: ; heuristic: event script entry or jump target; C0
    script_message $0BC3 ; '0 checked the desk.'
    script_command SCRIPT_DESK_KEY
    script_message $0B4E ; '0 obtained the Brawn Key.'
    script_set_flag $003D
    script_end
Script_5877:: ; heuristic: event script entry or jump target; C0
    script_message $0BC3 ; '0 checked the desk.'
    script_command SCRIPT_DESK_KEY
    script_message $0BB5 ; '0 obtained the Baffle Key.'
    script_set_flag $003D
    script_end
Script_5882:: ; heuristic: event script entry or jump target; C0
    script_message $0BC3 ; '0 checked the desk.'
    script_command SCRIPT_DESK_KEY
    script_message $0BB7 ; '0 obtained the Soul Key.'
    script_set_flag $00C8
    script_end
Script_588D:: ; heuristic: event script entry or jump target; C0
    script_message $0BC3 ; '0 checked the desk.'
    script_command SCRIPT_DESK_KEY
    script_message $0BC0 ; '0 obtained the Magic Key.'
    script_end
Script_5895:: ; heuristic: event script entry or jump target; C0
    script_sound $60
    script_command SCRIPT_SCENE_TERRY
    script_end
Script_5899:: ; heuristic: event script entry or jump target; C0
    script_message $4BAD ; 'Humph I'm Terry. I'm a master'
    script_skip_if_no Script_58A2
    script_message $8BAF ; 'Terry Oh, it was someone else?'
    script_end
Script_58A2:: ; heuristic: event script entry or jump target; C0
    script_message $8BAE ; 'Terry Humph Confident, huh? I'll tell'
    script_command SCRIPT_SCENE_TERRY_BATTLE
    script_end
    db $00, $B0, $4B, $06, $04, $00, $AF, $8B, $FF, $00, $AE, $8B, $7C, $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_58B5:: ; heuristic: event script entry or jump target; C0
    script_message $4B8F ; 'Kameha I e gone to other'
    script_skip_if_no Script_58BE
    script_message $8B91 ; 'Kameha What? Scared, 0?'
    script_end
Script_58BE:: ; heuristic: event script entry or jump target; C0
    script_message $8B90 ; 'Kameha So you're confident, huh? Let's'
    script_command SCRIPT_SCENE_KAMEHA_KEY_BATTLE
    script_end
Script_58C3:: ; heuristic: event script entry or jump target; C0
    script_message $0B95 ; 'Kameha What? Oh, it's 0. Did'
    script_message $0B93 ; '0 received the Elf Key.'
    script_set_flag $003A
    script_end
Script_58CD:: ; heuristic: event script entry or jump target; C0
    script_message $0B95 ; 'Kameha What? Oh, it's 0. Did'
    script_message $0BC2 ; '0 received the Magic Key.'
    script_set_flag $003A
    script_end
    db $00, $95, $0B, $00, $9A, $0B, $0A, $3A, $00, $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_58E1:: ; heuristic: event script entry or jump target; C0
    script_message $4B8F ; 'Kameha I e gone to other'
    script_skip_if_no Script_58EA
    script_message $8B91 ; 'Kameha What? Scared, 0?'
    script_end
Script_58EA:: ; heuristic: event script entry or jump target; C0
    script_message $8B90 ; 'Kameha So you're confident, huh? Let's'
    script_command SCRIPT_SCENE_KAMEHA_KEY_BATTLE_2
    script_end
Script_58EF:: ; heuristic: event script entry or jump target; C0
    script_message $0B95 ; 'Kameha What? Oh, it's 0. Did'
    script_message $0B9D ; '0 received the Traveler Key.'
    script_set_flag $003C
    script_end
Script_58F9:: ; heuristic: event script entry or jump target; C0
    script_message $0B95 ; 'Kameha What? Oh, it's 0. Did'
    script_message $0BC2 ; '0 received the Magic Key.'
    script_set_flag $003C
    script_end
Script_5903:: ; heuristic: event script entry or jump target; C0
    script_message $4B7C ; 'King Oh? It's our savior 0!'
    script_skip_if_no Script_590C
    script_message $8B7E ; 'King You refuse my request? After'
    script_end
Script_590C:: ; heuristic: event script entry or jump target; C0
    script_message $8B7D ; 'King You will? I knew I'
    script_set_flag $0192
    script_end
Script_5913:: ; heuristic: event script entry or jump target; C0
    script_message $0B80 ; 'King Ah, you e finally caught'
    script_message $0B81 ; '0 received 10,000G.'
    script_set_flag $0194
    script_end
Script_591D:: ; heuristic: event script entry or jump target; C0
    script_message $4B83 ; 'King Oh? It's our savior 0!'
    script_skip_if_no Script_5926
    script_message $8B7E ; 'King You refuse my request? After'
    script_end
Script_5926:: ; heuristic: event script entry or jump target; C0
    script_message $8B84 ; 'King You will? I knew I'
    script_set_flag $0195
    script_end
Script_592D:: ; heuristic: event script entry or jump target; C0
    script_message $0B80 ; 'King Ah, you e finally caught'
    script_message $0B86 ; '0 received 20,000G.'
    script_set_flag $0197
    script_end
Script_5937:: ; heuristic: event script entry or jump target; C0
    script_message $4B83 ; 'King Oh? It's our savior 0!'
    script_skip_if_no Script_5940
    script_message $8B7E ; 'King You refuse my request? After'
    script_end
Script_5940:: ; heuristic: event script entry or jump target; C0
    script_message $8B87 ; 'King You will? I knew I'
    script_set_flag $0198
    script_end
Script_5947:: ; heuristic: event script entry or jump target; C0
    script_message $0B80 ; 'King Ah, you e finally caught'
    script_message $0B89 ; '0 received 30,000G.'
    script_set_flag $019A
    script_end
Script_5951:: ; heuristic: event script entry or jump target; C0
    script_message $4B83 ; 'King Oh? It's our savior 0!'
    script_skip_if_no Script_595A
    script_message $8B7E ; 'King You refuse my request? After'
    script_end
Script_595A:: ; heuristic: event script entry or jump target; C0
    script_message $8B8A ; 'King You will? I knew I'
    script_set_flag $019B
    script_end
Script_5961:: ; heuristic: event script entry or jump target; C0
    script_message $0B80 ; 'King Ah, you e finally caught'
    script_message $0B8C ; '0 received 40,000G.'
    script_set_flag $019D
    script_end
Script_596B:: ; heuristic: event script entry or jump target; C0
    script_set_flag $012A
    script_message $41D0 ; 'This is a great spot to'
    script_skip_if_no Script_5977
    script_message $81D2 ; 'This talk is too early for'
    script_end
Script_5977:: ; heuristic: event script entry or jump target; C0
    script_message $81D1 ; 'Put the Dream Egg on the'
    script_end
Script_597B:: ; heuristic: event script entry or jump target; C0
    script_message $41D3 ; 'Have you ever found a Dream'
    script_skip_if_no Script_5984
    script_message $81D2 ; 'This talk is too early for'
    script_end
Script_5984:: ; heuristic: event script entry or jump target; C0
    script_message $81D1 ; 'Put the Dream Egg on the'
    script_end
Script_5988:: ; heuristic: event script entry or jump target; C0
    script_walk 2, 1, 6
    script_face $00, 3
    script_message $01D4 ; 'You're the child of the farmer?'
    script_slide_y $82
    script_message $0DDE ; 'What? You don't know about the'
    script_walk 2, 3, 6
    script_set_flag $0187
    script_end
Script_599F:: ; heuristic: event script entry or jump target; C0
    script_message $0D49 ; 'Here's that TinyMedal.'
    script_message $0D41 ; '0 received a TinyMedal!'
    script_set_flag $01A4
    script_end
Script_59A9:: ; heuristic: event script entry or jump target; C0
    script_message $0D44 ; 'Here it is-the TinyMedal. My master'
    script_message $0D41 ; '0 received a TinyMedal!'
    script_set_flag $01A6
    script_end
Script_59B3:: ; heuristic: event script entry or jump target; C0
Data_010_59B3:: ; address name
    script_message $40FA ; 'Hello! What can I do for'
    script_jump_data_bank Script_6659
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_59BA:: ; heuristic: event script entry or jump target; C0
    script_message $41BB ; 'Welcome to our inn!'
    script_jump_data_bank Script_690B
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_59C1:: ; heuristic: event script entry or jump target; C0
Data_010_59C1:: ; address name
    script_message $4144 ; 'Welcome to my item shop! You'
    script_jump_data_bank Script_6707
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_59C8:: ; heuristic: event script entry or jump target; C0
    script_message $4145 ; 'Hello! How may I serve you'
    script_jump_data_bank Script_6707
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_59CF:: ; heuristic: event script entry or jump target; C0
    script_message $4146 ; 'The church welcomes you. We can'
    script_jump_data_bank Script_1F_77D4
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_59D6:: ; heuristic: event script entry or jump target; C0
    script_message $4147 ; 'I am a servant to the'
    script_jump_data_bank Script_1F_77D4
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_59DD:: ; heuristic: event script entry or jump target; C0
    script_message $4148 ; 'I am the leader of a'
    script_skip_if_no Script_59E6
    script_message $814C ; 'You close the door to stardom?'
    script_end
Script_59E6:: ; heuristic: event script entry or jump target; C0
    script_message $8149 ; 'Did you say yes? Yes, yes,'
    script_set_flag $0042
    script_command SCRIPT_SCENE_MONSTER_INSPECTION
    script_face $83, 2
    script_message $0153 ; 'Very good show! That was splendid'
    script_set_flag $0043
    script_end
Script_59F7:: ; heuristic: event script entry or jump target; C0
    script_message $4148 ; 'I am the leader of a'
    script_skip_if_no Script_5A00
    script_message $814C ; 'You close the door to stardom?'
    script_end
Script_5A00:: ; heuristic: event script entry or jump target; C0
    script_message $814B ; 'Did you say yes? Yes, yes,'
    script_set_flag $0042
    script_end
Script_5A07:: ; heuristic: event script entry or jump target; C0
    script_message $4148 ; 'I am the leader of a'
    script_skip_if_no Script_5A10
    script_message $814C ; 'You close the door to stardom?'
    script_end
Script_5A10:: ; heuristic: event script entry or jump target; C0
    script_message $814A ; 'Did you say yes? Yes, yes,'
    script_set_flag $0042
    script_end
Script_5A17:: ; heuristic: event script entry or jump target; C0
    script_message $014D ; 'Ah, three healthy monsters! Very well'
    script_command SCRIPT_SCENE_MONSTER_INSPECTION
    script_face $83, 2
    script_message $0153 ; 'Very good show! That was splendid'
    script_set_flag $0043
    script_end
Script_5A25:: ; heuristic: event script entry or jump target; C0
    script_message $41BB ; 'Welcome to our inn!'
    script_jump_data_bank Script_690B
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5A2C:: ; heuristic: event script entry or jump target; C0
    script_message $4160 ; 'King Ah, you're the monster tamer'
    script_skip_if_no Script_5A35
    script_message $8D01 ; 'King Then, you are excused. I'm'
    script_end
Script_5A35:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0044
    script_message $8D02 ; 'King You wish to see our'
    script_command SCRIPT_SCENE_KING_AUDIENCE
    script_message $4161 ; 'King I see. This is what'
    script_skip_if_no Script_5A45
    script_message $8163 ; 'King Oh You won't? Then, I'
    script_end
Script_5A45:: ; heuristic: event script entry or jump target; C0
    script_message $8162 ; 'King Then make way to the'
    script_set_flag $0045
    script_end
Script_5A4C:: ; heuristic: event script entry or jump target; C0
    script_message $4165 ; 'King So? Have you decided to'
    script_skip_if_no Script_5A55
    script_message $8163 ; 'King Oh You won't? Then, I'
    script_end
Script_5A55:: ; heuristic: event script entry or jump target; C0
    script_message $8162 ; 'King Then make way to the'
    script_set_flag $0045
    script_end
Script_5A5C:: ; heuristic: event script entry or jump target; C0
    script_message $016C ; 'So, have you discovered what concerns'
    script_walk_fast 0, 2, 4
    script_walk 1, 1, 1
    script_walk 1, 0, 4
    script_message $016D ; 'King The canal is managed by'
    script_slide_y $80
    script_message $016E ; 'Your Majesty, I must remind you'
    script_walk_fast 1, 3, 1
    script_walk_fast 1, 1, 2
    script_walk_fast 1, 3, 2
    script_walk_fast 1, 1, 1
    script_face $81, 0
    script_message $016F ; 'King What? Never mind, then! I'll'
    script_walk_fast 1, 3, 1
    script_walk_fast 1, 0, 5
    script_set_flag $0049
    script_end
Script_5A95:: ; heuristic: event script entry or jump target; C0
    script_message $0171 ; 'What? Open the Canal Gate more?'
    script_command SCRIPT_SCENE_CANAL_GATE
    script_wait 30
    script_walk_fast 0, 2, 2
    script_walk_fast 0, 3, 1
    script_walk_fast 0, 2, 1
    script_hide_object $00
    script_end
Script_5AAB:: ; heuristic: event script entry or jump target; C0
    script_message $0175 ; 'I'm making a new home for'
    script_encounter $16 ; encounter words: Beavern, Slime, Slime
    script_message $0176 ; 'Gaah! You're too strong! You win!'
    script_face $80, 2
    script_slide_y $80
    script_message $0177 ; 'King What? So that's the truth?'
    script_face $81, 0
    script_message $0178 ; 'You will? So we can go'
    script_hide_object $01
    script_set_flag $0053
    script_command SCRIPT_SCENE_WATER_SOLVED
    script_set_flag $0054
    script_message $0179 ; 'King This should solve the water'
    script_walk 0, 0, 3
    script_end
Script_5AD2:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_SCENE_WATER_REWARD
    script_end
    db $4D, $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5AD6:: ; heuristic: event script entry or jump target; C0
    script_message $0181 ; 'King The town's water shortage seems'
    script_set_flag $0055
    script_walk 1, 0, 8
    script_command SCRIPT_SCENE_WATER_SHORTAGE
    script_walk_fast 0, 1, 3
    script_face $80, 2
    script_message $0182 ; 'King Wha-what? What happened?'
    script_face $81, 0
    script_message $0183 ; 'We We were jumped by thieves'
    script_slide_y $80
    script_message $0184 ; 'King What? Arrrrgh! Round up all'
    script_command SCRIPT_SCENE_TREASURE_THEFT
    script_walk 0, 0, 1
    script_walk 0, 1, 1
    script_face $00, 3
    script_message $0187 ; 'King I apologize, but my treasures'
    script_walk 0, 0, 8
    script_set_flag $0056
    script_end
Script_5B0D:: ; heuristic: event script entry or jump target; C0
    script_message $4188 ; 'Wh-where is everybody? I haven't been'
    script_skip_if_no Script_5B16
    script_message $818D ; 'Tch, what good are you? I'm'
    script_end
Script_5B16:: ; heuristic: event script entry or jump target; C0
    script_message $818C ; '0 had no food to give'
    script_message $018D ; 'Tch, what good are you? I'm'
    script_end
Script_5B1D:: ; heuristic: event script entry or jump target; C0
    script_message $4188 ; 'Wh-where is everybody? I haven't been'
    script_skip_if_no Script_5B26
    script_message $818D ; 'Tch, what good are you? I'm'
    script_end
Script_5B26:: ; heuristic: event script entry or jump target; C0
    script_message $8189 ; '0 handed over some food.'
    script_message $018A ; 'Munch, munch Chew, gulp Fwoaar, that'
    script_message $018B ; '0 received a WaterCall.'
    script_message $0D03 ; 'That will help you for certain.'
    script_command SCRIPT_CHECK_ITEM
    script_set_flag $0057
    script_end
Script_5B37:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0058
    script_command SCRIPT_SCENE_MONSTERS_IN_TOW
    script_end
Script_5B3C:: ; heuristic: event script entry or jump target; C0
    script_message $0196 ; 'Heh, you have monsters in tow?'
    script_set_flag $0059
    script_encounter $00 ; encounter words: CurseLamp, Slime, Slime
    script_message $0198 ; 'You defeated my monster? Urggh Time'
    script_command SCRIPT_SCENE_RIVAL_DEFEATED
    script_end
Script_5B49:: ; heuristic: event script entry or jump target; C0
    script_message $0197 ; 'You again! You're determined! But it'
    script_encounter $00 ; encounter words: CurseLamp, Slime, Slime
    script_message $0198 ; 'You defeated my monster? Urggh Time'
    script_command SCRIPT_SCENE_RIVAL_DEFEATED
    script_end
Script_5B53:: ; heuristic: event script entry or jump target; C0
    script_sound $60
    script_command SCRIPT_SCENE_RIVAL_FADE
    script_end
Script_5B57:: ; heuristic: event script entry or jump target; C0
    script_message $415C ; 'Why are you snooping around? Are'
    script_skip_if_no Script_5B60
    script_message $815E ; 'Oh, it looked like you were'
    script_end
Script_5B60:: ; heuristic: event script entry or jump target; C0
    script_message $815D ; 'A new plug for the Log's'
    script_end
Script_5B64:: ; heuristic: event script entry or jump target; C0
    script_message $4D04 ; 'Hello, have you found a plug'
    script_skip_if_no Script_5B6D
    script_message $8D06 ; 'I can show you my navel'
    script_end
Script_5B6D:: ; heuristic: event script entry or jump target; C0
    script_message $8D05 ; 'Oh. That's nice. Good for you.'
    script_end
Script_5B71:: ; heuristic: event script entry or jump target; C0
    script_wait 20
    script_command SCRIPT_SCENE_POOR_CHURCH
    script_end
Script_5B76:: ; heuristic: event script entry or jump target; C0
    script_message $4DA0 ; 'Our church is impoverished, so I'
    script_jump_data_bank Script_1F_77D4
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5B7D:: ; heuristic: event script entry or jump target; C0
    script_message $4147 ; 'I am a servant to the'
    script_jump_data_bank Script_1F_77D4
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5B84:: ; heuristic: event script entry or jump target; C0
    script_message $0806 ; 'The birds are noisy It's a'
    script_command SCRIPT_SHAKE_SCREEN
    script_message $0807 ; 'See? What did I just say?'
    script_end
Script_5B8C:: ; heuristic: event script entry or jump target; C0
Data_010_5B8C:: ; address name
    script_message $4809 ; 'I don't have much but Would'
    script_jump_data_bank Script_6707
    db $FF, $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5B94:: ; heuristic: event script entry or jump target; C0
    script_message $41BB ; 'Welcome to our inn!'
    script_jump_data_bank Script_690B
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5B9B:: ; heuristic: event script entry or jump target; C0
    script_message $4818 ; 'Have you heard the legend about'
    script_skip_if_no Script_5BA4
    script_message $881A ; 'Long ago, a deft craftsman made'
    script_end
Script_5BA4:: ; heuristic: event script entry or jump target; C0
    script_message $8819 ; 'Ah, you e heard already. It's'
    script_end
Script_5BA8:: ; heuristic: event script entry or jump target; C0
    script_message $4820 ; 'How may our church serve you?'
    script_jump_data_bank Script_1F_77D4
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5BAF:: ; heuristic: event script entry or jump target; C0
Data_010_5BAF:: ; address name
    script_message $4823 ; 'I offer quality merchandise. Would you'
    script_jump_data_bank Script_6707
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5BB6:: ; heuristic: event script entry or jump target; C0
    script_message $082C ; '0 tried to check the chest.'
    script_message $082D ; 'Whoa! Hands off my merchandise!'
    script_end
Script_5BBD:: ; heuristic: event script entry or jump target; C0
    script_message $41BB ; 'Welcome to our inn!'
    script_jump_data_bank Script_690B
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5BC4:: ; heuristic: event script entry or jump target; C0
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
    script_sound $FF
    script_end
Script_5BE8:: ; heuristic: event script entry or jump target; C0
    script_message $0838 ; 'Who are you? This is our'
    script_encounter $01 ; encounter words: HoodSquid, Slime, Slime
    script_command SCRIPT_SCENE_WATCH_OUT
    script_set_flag $0066
    script_end
Script_5BF2:: ; heuristic: event script entry or jump target; C0
    script_message $0839 ; 'You can keep trying, but you're'
    script_encounter $01 ; encounter words: HoodSquid, Slime, Slime
    script_command SCRIPT_SCENE_WATCH_OUT
    script_set_flag $0066
    script_end
Script_5BFC:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_SCENE_WATCH_OUT
    script_end
Script_5BFE:: ; heuristic: event script entry or jump target; C0
    script_message $083A ; 'Zzz Zzz Huh! Watch out!'
    script_slide_y $83
    script_message $483B ; 'What! Why are you with monsters?'
    script_skip_if_no Script_5C0C
    script_message $883E ; 'It's a tale of high adventure'
    script_end
Script_5C0C:: ; heuristic: event script entry or jump target; C0
    script_message $883C ; 'It was in my callow youth'
    script_wait 120
    script_message $083D ; 'The pirates loot is probably still'
    script_set_flag $006D
    script_end
Script_5C19:: ; heuristic: event script entry or jump target; C0
    script_message $483F ; 'What? Are you here for my'
    script_skip_if_no Script_5C22
    script_message $8841 ; 'It's a chance to hear an'
    script_end
Script_5C22:: ; heuristic: event script entry or jump target; C0
    script_message $8840 ; 'The pirates stole the MoonRock from'
    script_end
Script_5C26:: ; heuristic: event script entry or jump target; C0
    script_message $083A ; 'Zzz Zzz Huh! Watch out!'
    script_slide_y $83
    script_message $0DC4 ; 'What is it? Ah, it's you.'
    script_end
Script_5C2F:: ; heuristic: event script entry or jump target; C0
    script_message $4810 ; 'In the past, mermaids are said'
    script_skip_if_no Script_5C38
    script_message $8817 ; 'Ah Shame Please come again.'
    script_end
Script_5C38:: ; heuristic: event script entry or jump target; C0
    script_message $8811 ; 'Then I'll sing! Lalala lala la'
    script_command SCRIPT_SCENE_DANCING
    script_message $0816 ; 'Erm The sense of rhythm just'
    script_end
Script_5C40:: ; heuristic: event script entry or jump target; C0
    script_message $4810 ; 'In the past, mermaids are said'
    script_skip_if_no Script_5C49
    script_message $8817 ; 'Ah Shame Please come again.'
    script_end
Script_5C49:: ; heuristic: event script entry or jump target; C0
    script_message $8811 ; 'Then I'll sing! Lalala lala la'
    script_command SCRIPT_SCENE_MERMAID_SONG
    script_end
Script_5C4E:: ; heuristic: event script entry or jump target; C0
    script_message $4810 ; 'In the past, mermaids are said'
    script_skip_if_no Script_5C57
    script_message $8817 ; 'Ah Shame Please come again.'
    script_end
Script_5C57:: ; heuristic: event script entry or jump target; C0
    script_message $8811 ; 'Then I'll sing! Lalala lala la'
    script_command SCRIPT_SCENE_MERMAID_SONG_2
    script_end
Script_5C5C:: ; heuristic: event script entry or jump target; C0
    script_message $4810 ; 'In the past, mermaids are said'
    script_skip_if_no Script_5C65
    script_message $8817 ; 'Ah Shame Please come again.'
    script_end
Script_5C65:: ; heuristic: event script entry or jump target; C0
    script_message $8892 ; 'Your monsters appear dispirited It's unfortunate,'
    script_end
Script_5C69:: ; heuristic: event script entry or jump target; C0
    script_message $484B ; 'Do you want to go to'
    script_skip_if_no Script_5C72
    script_message $884D ; 'Come back for a visit anytime!'
    script_end
Script_5C72:: ; heuristic: event script entry or jump target; C0
    script_message $884C ; 'Close your eyes a little while.'
    script_command SCRIPT_WARP_MAP41
    script_end
Script_5C77:: ; heuristic: event script entry or jump target; C0
    script_message $0855 ; 'Welcome, young human. I heard that'
    script_set_flag $0070
    script_end
Script_5C7E:: ; heuristic: event script entry or jump target; C0
    script_message $0DC5 ; 'Welcome, my young hero! No words'
    script_message $0DC6 ; '0 received the Sailor Ring.'
    script_set_flag $005E
    script_end
Script_5C88:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_SCENE_SAILOR_RING
    script_end
Script_5C8A:: ; heuristic: event script entry or jump target; C0
    script_message $0859 ; 'How could we die before enjoying'
    script_encounter $17 ; encounter words: BoneSlave, Slime, Slime
    script_set_flag $0071
    script_command SCRIPT_SCENE_PIRATE_GHOSTS
    script_end
Script_5C94:: ; heuristic: event script entry or jump target; C0
    script_message $085A ; 'The treasures are ours No one'
    script_encounter $17 ; encounter words: BoneSlave, Slime, Slime
    script_set_flag $0072
    script_command SCRIPT_SCENE_PIRATE_GHOSTS
    script_end
Script_5C9E:: ; heuristic: event script entry or jump target; C0
    script_message $085C ; 'It nags and nags that we'
    script_encounter $17 ; encounter words: BoneSlave, Slime, Slime
    script_set_flag $0073
    script_command SCRIPT_SCENE_PIRATE_GHOSTS
    script_end
Script_5CA8:: ; heuristic: event script entry or jump target; C0
    script_message $085E ; 'Who disturbs us in our sleep'
    script_encounter $02 ; encounter words: BoneSlave, CaptDead, BoneSlave
    script_message $0860 ; 'Child We have lost Finally, we'
    script_command SCRIPT_GIVE_ITEM_BLINK
    script_set_flag $0075
    script_end
Script_5CB5:: ; heuristic: event script entry or jump target; C0
    script_message $085F ; 'You seem to not understand The'
    script_encounter $02 ; encounter words: BoneSlave, CaptDead, BoneSlave
    script_message $0860 ; 'Child We have lost Finally, we'
    script_command SCRIPT_GIVE_ITEM_BLINK
    script_set_flag $0075
    script_end
Script_5CC2:: ; heuristic: event script entry or jump target; C0
    script_message $0887 ; '0 checked the treasure chest. 0'
    script_command SCRIPT_SCENE_CRATE
    script_set_flag $0076
    script_end
Script_5CCA:: ; heuristic: event script entry or jump target; C0
    script_message $0863 ; '0 checked the crate. There was'
    script_command SCRIPT_SET_TILES_FLAG_310
    script_end
Script_5CCF:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_SCENE_KAMEHA_ESCAPE
    script_end
Script_5CD1:: ; heuristic: event script entry or jump target; C0
    script_sound $28
    script_message $0868 ; 'Kameha Wahahahah! Thanks for guiding me'
    script_command SCRIPT_SCENE_KAMEHA_CAUGHT
    script_wait 30
    script_sound $FF
    script_end
Script_5CDD:: ; heuristic: event script entry or jump target; C0
    script_sound $28
    script_slide_y $80
    script_message $0869 ; 'Kameha Urk! How you catch up?'
    script_face $80, 1
    script_walk_fast 1, 3, 3
    script_walk_fast 1, 2, 1
    script_face $81, 1
    script_walk_fast 2, 3, 3
    script_walk_fast 2, 0, 3
    script_face $82, 1
    script_message $086A ; 'Aye, aye, sir! Right behind you!'
    script_command SCRIPT_SCENE_CREW_FOLLOWS
    script_sound $65
    script_hide_object $00
    script_wait 15
    script_sound $65
    script_hide_object $01
    script_wait 15
    script_sound $65
    script_hide_object $02
    script_set_flag $007C
    script_wait 90
    script_sound $FF
    script_end
Script_5D1C:: ; heuristic: event script entry or jump target; C0
    script_sound $28
    script_message $086B ; 'Kameha Arrrrh, clear the way! I'm'
    script_command SCRIPT_SCENE_KAMEHA_FLEES
    script_sound $00
    script_message $0891 ; 'Kameha Aiyeeeeeh'
    script_sound $65
    script_wait 90
    script_sound $FF
    script_end
Script_5D2F:: ; heuristic: event script entry or jump target; C0
    script_wait 140
    script_command SCRIPT_SCENE_MERMAID_KINGDOM
    script_sound $FF
    script_end
Script_5D36:: ; heuristic: event script entry or jump target; C0
    script_message $488E ; 'This is the mermaid kingdom. Did'
    script_skip_if_no Script_5D3F
    script_message $8890 ; 'Oh. Tell me if you want'
    script_end
Script_5D3F:: ; heuristic: event script entry or jump target; C0
    script_message $888F ; 'Close your eyes for a little'
    script_command SCRIPT_SCENE_TENTACLES
    script_end
Script_5D44:: ; heuristic: event script entry or jump target; C0
    script_message $0893 ; 'Thick, suction- cupped tentacles snaked out'
    script_encounter $1E ; encounter words: KingSquid, Slime, Slime
    script_set_flag $00F4
    script_end
Script_5D4D:: ; heuristic: event script entry or jump target; C0
    script_message $4DA1 ; 'Our church is impoverished, so I'
    script_jump_data_bank Script_1F_77D4
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5D54:: ; heuristic: event script entry or jump target; C0
    script_message $4147 ; 'I am a servant to the'
    script_jump_data_bank Script_1F_77D4
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5D5B:: ; heuristic: event script entry or jump target; C0
    script_message $4308 ; 'Have you heard about the spirit'
    script_skip_if_no Script_5D64
    script_message $830A ; 'Many years ago, our ancestors came'
    script_end
Script_5D64:: ; heuristic: event script entry or jump target; C0
    script_message $8309 ; 'A long time ago the spirit'
    script_end
Script_5D68:: ; heuristic: event script entry or jump target; C0
Data_010_5D68:: ; address name
    script_message $4310 ; 'Welcome! How may I serve you'
    script_jump_data_bank Script_6707
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5D6F:: ; heuristic: event script entry or jump target; C0
    script_message $41BB ; 'Welcome to our inn!'
    script_jump_data_bank Script_690B
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5D76:: ; heuristic: event script entry or jump target; C0
    script_message $0316 ; '0 checked the shield. A beautiful'
    script_message $4317 ; 'I am surprised that you hear'
    script_skip_if_no Script_5D82
    script_message $831A ; 'You may think terrible of me'
    script_end
Script_5D82:: ; heuristic: event script entry or jump target; C0
    script_message $8318 ; 'You will? No words of thanks'
    script_command SCRIPT_BLINK_SPRITES
    script_set_flag $01E8
    script_end
Script_5D8A:: ; heuristic: event script entry or jump target; C0
    script_message $031C ; 'What is that dirty medal? The'
    script_walk 0, 2, 1
    script_hide_object $00
    script_set_flag $0081
    script_end
Script_5D97:: ; heuristic: event script entry or jump target; C0
    script_message $0321 ; 'Ah, you are the spirit's envoy.'
    script_set_flag $0083
    script_command SCRIPT_SCENE_SPIRIT_ENVOY
    script_walk 1, 0, 2
    script_set_flag $0082
    script_end
Script_5DA6:: ; heuristic: event script entry or jump target; C0
    script_message $0359 ; 'We reported to the King that'
    script_command SCRIPT_SCENE_REPORT_TO_KING
    script_sound $28
    script_set_flag $0087
    script_end
Script_5DB0:: ; heuristic: event script entry or jump target; C0
Data_010_5DB0:: ; address name
    script_message $4331 ; 'Welcome! What can I do for'
    script_jump_data_bank Script_6659
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5DB7:: ; heuristic: event script entry or jump target; C0
Data_010_5DB7:: ; address name
    script_message $4332 ; 'Greetings! How shall I serve you?'
    script_jump_data_bank Script_6707
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5DBE:: ; heuristic: event script entry or jump target; C0
Data_010_5DBE:: ; address name
    script_message $4333 ; 'Hello! Have a look at my'
    script_jump_data_bank Script_6707
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5DC5:: ; heuristic: event script entry or jump target; C0
    script_message $41BB ; 'Welcome to our inn!'
    script_jump_data_bank Script_690B
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5DCC:: ; heuristic: event script entry or jump target; C0
    script_message $4820 ; 'How may our church serve you?'
    script_jump_data_bank Script_1F_77D4
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5DD3:: ; heuristic: event script entry or jump target; C0
    script_sound $65
    script_command SCRIPT_SCENE_EXPLOSION
    script_walk_fast 1, 3, 4
    script_walk_fast 2, 1, 3
    script_slide_y $81
    script_message $0349 ; 'What? What was that explosion?'
    script_slide_y $82
    script_message $034A ; 'That dust there Is that the'
    script_slide_y $81
    script_message $034B ; 'What? That's all that there was?'
    script_slide_y $82
    script_message $034C ; 'We better get word to the'
    script_walk_fast 2, 3, 3
    script_message $034D ; 'That's true I e got to'
    script_walk_fast 1, 1, 4
    script_command SCRIPT_SCENE_GOT_TO
    script_set_flag $0086
    script_end
Script_5E02:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_SCENE_EXPLOSION
    script_walk_fast 1, 3, 4
    script_walk_fast 2, 1, 3
    script_slide_y $81
    script_message $0349 ; 'What? What was that explosion?'
    script_slide_y $82
    script_message $034A ; 'That dust there Is that the'
    script_slide_y $81
    script_message $034B ; 'What? That's all that there was?'
    script_slide_y $82
    script_message $034C ; 'We better get word to the'
    script_walk_fast 2, 3, 3
    script_message $034D ; 'That's true I e got to'
    script_walk_fast 1, 1, 4
    script_command SCRIPT_SCENE_GOT_TO
    script_set_flag $0086
    script_end
Script_5E2F:: ; heuristic: event script entry or jump target; C0
    script_message $0360 ; '0 tapped on the wall. The'
    script_face $81, 2
    script_command SCRIPT_SCENE_WALL_EXIT
    script_end
Script_5E37:: ; heuristic: event script entry or jump target; C0
    script_message $0363 ; '0 tapped on the wall. Sound'
    script_face $81, 2
    script_command SCRIPT_SCENE_WALL_EXIT
    script_message $0364 ; 'Kameha That's it! That's the exit!'
    script_walk_fast 1, 2, 3
    script_hide_object $01
    script_wait 30
    script_set_flag $008A
    script_sound $FF
    script_walk_fast 0, 3, 4
    script_walk_fast 0, 2, 5
    script_hide_object $00
    script_end
Script_5E5A:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_SCENE_REAL_KING
    script_message $0365 ; 'I'm the real King, you fake!'
    script_slide_y $81
    script_message $0366 ; 'What? How dare you, impostor! I'm'
    script_set_flag $008B
    script_end
Script_5E67:: ; heuristic: event script entry or jump target; C0
    script_message $0370 ; 'Arrgh, you e ruined my plan'
    script_command SCRIPT_SCENE_PLAN_RUINED
    script_face $81, 2
    script_slide_y $81
    script_message $0374 ; 'Bravo! We're saved! Thank you for'
    script_set_flag $0094
    script_end
Script_5E77:: ; heuristic: event script entry or jump target; C0
    script_message $0372 ; 'It almost worked to perfection! It's'
    script_command SCRIPT_SCENE_PLAN_RUINED
    script_face $81, 2
    script_slide_y $81
    script_message $0374 ; 'Bravo! We're saved! Thank you for'
    script_set_flag $0094
    script_end
Script_5E87:: ; heuristic: event script entry or jump target; C0
    script_message $41BB ; 'Welcome to our inn!'
    script_jump_data_bank Script_690B
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5E8E:: ; heuristic: event script entry or jump target; C0
Data_010_5E8E:: ; address name
    script_message $438B ; 'Hello! How may I serve you?'
    script_jump_data_bank Script_6707
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5E95:: ; heuristic: event script entry or jump target; C0
    script_message $0394 ; '0 read the sign. Come all'
    script_sound $28
    script_command SCRIPT_GATHER_FOLLOWERS
    script_wait 90
    script_walk_fast 3, 2, 4
    script_face $83, 1
    script_message $0395 ; 'Kameha Well, if it isn't 0!'
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
    script_sound $FF
    script_set_flag $0095
    script_end
Script_5EE6:: ; heuristic: event script entry or jump target; C0
    script_message $039D ; 'You're here to cheer Lady Yuna.'
    script_walk 0, 2, 1
    script_walk 0, 1, 1
    script_face $80, 0
    script_end
Script_5EF5:: ; heuristic: event script entry or jump target; C0
    script_sound $28
    script_command SCRIPT_SCENE_CHEER_YUNA
    script_message $03A2 ; 'King Magnificent! Don't you agree?'
    script_face $80, 1
    script_message $03A3
    script_face $80, 0
    script_message $03A4 ; 'King Sigh Not even this You'
    script_set_flag $0096
    script_end
Script_5F0B:: ; heuristic: event script entry or jump target; C0
Data_010_5F0B:: ; address name
    script_message $43B3 ; 'Hello! What may I do for'
    script_jump_data_bank Script_6707
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5F12:: ; heuristic: event script entry or jump target; C0
    script_message $43B5 ; 'I retired as a teacher and'
    script_skip_if_no Script_5F1B
    script_message $83B7 ; 'Oh, you're rushed for time Sorry'
    script_end
Script_5F1B:: ; heuristic: event script entry or jump target; C0
    script_message $83B6 ; 'Lady Yuna was a rambunctious soul.'
    script_end
Script_5F1F:: ; heuristic: event script entry or jump target; C0
    script_message $41BB ; 'Welcome to our inn!'
    script_jump_data_bank Script_690B
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5F26:: ; heuristic: event script entry or jump target; C0
    script_message $03B0 ; 'This is no place for a'
    script_slide_y $80
    script_message $03B1 ; 'Oh? An envoy from the spirit!'
    script_walk 0, 2, 1
    script_hide_object $00
    script_set_flag $0097
    script_end
Script_5F38:: ; heuristic: event script entry or jump target; C0
    script_message $03B0 ; 'This is no place for a'
    script_slide_y $81
    script_message $03B1 ; 'Oh? An envoy from the spirit!'
    script_walk 1, 2, 1
    script_hide_object $01
    script_set_flag $0097
    script_end
Script_5F4A:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_SCENE_SPIRIT_ENVOY_2
    script_end
Script_5F4C:: ; heuristic: event script entry or jump target; C0
    script_message $0D4C ; '? You startled me I don't'
    script_command SCRIPT_GIVE_ITEM_BLINK
    script_set_flag $009A
    script_end
Script_5F54:: ; heuristic: event script entry or jump target; C0
    script_message $4AB5 ; '? You startled me I don't'
    script_set_flag $009A
    script_skip_if_no Script_5F61
    script_message $8AC9 ; 'Oh How terribly disappointing. I'll have'
    script_command SCRIPT_GIVE_ITEM_BLINK
    script_end
Script_5F61:: ; heuristic: event script entry or jump target; C0
    script_message $8AB6 ; 'You will? Thank you! Let me'
    script_set_flag $009B
    script_command SCRIPT_GIVE_ITEM_BLINK
    script_message $0AB7 ; '0 obtained YunaSoul.'
    script_end
Script_5F6C:: ; heuristic: event script entry or jump target; C0
    script_message $4AB5 ; '? You startled me I don't'
    script_set_flag $009A
    script_skip_if_no Script_5F79
    script_message $8AC9 ; 'Oh How terribly disappointing. I'll have'
    script_command SCRIPT_GIVE_ITEM_BLINK
    script_end
Script_5F79:: ; heuristic: event script entry or jump target; C0
    script_message $8AC8 ; 'You will? Thank you! Let me'
    script_end
Script_5F7D:: ; heuristic: event script entry or jump target; C0
    script_message $0D4D ; 'I don't remember who I am,'
    script_command SCRIPT_GIVE_ITEM_BLINK
    script_end
Script_5F82:: ; heuristic: event script entry or jump target; C0
    script_message $4ACA ; 'I don't remember who I am,'
    script_skip_if_no Script_5F8C
    script_message $8AC9 ; 'Oh How terribly disappointing. I'll have'
    script_command SCRIPT_GIVE_ITEM_BLINK
    script_end
Script_5F8C:: ; heuristic: event script entry or jump target; C0
    script_message $8AB6 ; 'You will? Thank you! Let me'
    script_set_flag $009B
    script_command SCRIPT_GIVE_ITEM_BLINK
    script_message $0AB7 ; '0 obtained YunaSoul.'
    script_end
Script_5F97:: ; heuristic: event script entry or jump target; C0
    script_message $4ACA ; 'I don't remember who I am,'
    script_skip_if_no Script_5FA1
    script_message $8AC9 ; 'Oh How terribly disappointing. I'll have'
    script_command SCRIPT_GIVE_ITEM_BLINK
    script_end
Script_5FA1:: ; heuristic: event script entry or jump target; C0
    script_message $8AC8 ; 'You will? Thank you! Let me'
    script_end
Script_5FA5:: ; heuristic: event script entry or jump target; C0
    script_message $0D3C ; '!'
    script_message $0AD1 ; 'STOP DON T MEDDLE'
    script_command SCRIPT_SCENE_PRINCESS_MEDICINE
    script_end
Script_5FAD:: ; heuristic: event script entry or jump target; C0
    script_message $03A3
    script_message $0DD2 ; 'The princess did not reply. But'
    script_message $0AD3 ; 'FOOLHARDY. BRAVE BUT FOOLISH.'
    script_command SCRIPT_SCENE_PRINCESS_MEDICINE
    script_end
Script_5FB8:: ; heuristic: event script entry or jump target; C0
    script_message $0AEA ; 'Pardon me? You have medicine? This'
    script_walk 2, 1, 2
    script_hide_object $02
    script_hold_dpad $01, 3
    script_command SCRIPT_SCENE_MEDICINE_GIVEN
    script_set_flag $01F1
    script_end
Script_5FC9:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_SCENE_SHIELD_GUARDIAN
    script_end
Script_5FCB:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_SCENE_SHIELD_GUARDIAN
    script_end
Script_5FCD:: ; heuristic: event script entry or jump target; C0
    script_message $0A01 ; '0 checked the shield.'
    script_command SCRIPT_SCENE_SHIELD
    script_end
Script_5FD2:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_SCENE_SHIELD
    script_end
Script_5FD4:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_SCENE_SHIELD_2
    script_end
Script_5FD6:: ; heuristic: event script entry or jump target; C0
    script_message $4820 ; 'How may our church serve you?'
    script_jump_data_bank Script_1F_77D4
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5FDD:: ; heuristic: event script entry or jump target; C0
    script_message $0319 ; '0 checked the treasure chest. 0'
    script_hide_object $01
    script_set_flag $0080
    script_end
Script_5FE6:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_SCENE_CHEST_SERVANT
    script_end
Script_5FE8:: ; heuristic: event script entry or jump target; C0
    script_message $442E ; 'How may we serve your mortal'
    script_jump_data_bank Script_1F_77D4
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5FEF:: ; heuristic: event script entry or jump target; C0
    script_message $040B ; '0 checked the grave. There was'
    script_command SCRIPT_SCENE_GRAVE
    script_set_flag $00A0
    script_end
Script_5FF7:: ; heuristic: event script entry or jump target; C0
    script_message $040B ; '0 checked the grave. There was'
    script_command SCRIPT_SCENE_GRAVE
    script_end
Script_5FFC:: ; heuristic: event script entry or jump target; C0
    script_message $0411 ; 'Fine! You e done well to'
    script_sound $66
    script_command SCRIPT_SET_TILES_D2
    script_end
Script_6003:: ; heuristic: event script entry or jump target; C0
Data_010_6003:: ; address name
    script_message $41BB ; 'Welcome to our inn!'
    script_jump_data_bank Script_690B
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_600A:: ; heuristic: event script entry or jump target; C0
    script_message $0412 ; 'Kweeeeh!'
    script_message $0DE6 ; 'Look! A MadCondor! It has something!'
    script_command SCRIPT_SCENE_MADCONDOR
    script_set_flag $00A4
    script_end
Script_6015:: ; heuristic: event script entry or jump target; C0
    script_message $041D ; 'Hm? You're from the village! Hurry'
    script_walk 0, 1, 1
    script_face $80, 3
    script_end
Script_6020:: ; heuristic: event script entry or jump target; C0
    script_message $4426 ; 'You Are you a monster?'
    script_skip_if_no Script_6029
    script_message $8428 ; 'Uh-huh You look uh delicious.'
    script_end
Script_6029:: ; heuristic: event script entry or jump target; C0
    script_message $8427 ; 'Uh-huh You don't look very strong.'
    script_end
Script_602D:: ; heuristic: event script entry or jump target; C0
    script_message $4426 ; 'You Are you a monster?'
    script_skip_if_no Script_6036
    script_message $8428 ; 'Uh-huh You look uh delicious.'
    script_end
Script_6036:: ; heuristic: event script entry or jump target; C0
    script_message $8429 ; 'Any way you want to look'
    script_end
Script_603A:: ; heuristic: event script entry or jump target; C0
    script_message $442E ; 'How may we serve your mortal'
    script_jump_data_bank Script_1F_77D4
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_6041:: ; heuristic: event script entry or jump target; C0
Data_010_6041:: ; address name
    script_message $442D ; 'Good day. How may I help'
    script_jump_data_bank Script_6707
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_6048:: ; heuristic: event script entry or jump target; C0
Data_010_6048:: ; address name
    script_message $4432 ; 'Welcome to the traveler's inn.'
    script_jump_data_bank Script_690B
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_604F:: ; heuristic: event script entry or jump target; C0
    script_message $0433 ; 'Kweeeeeh!'
    script_command SCRIPT_SCENE_MADCONDOR_CRY
    script_encounter $05 ; encounter words: MadCondor, Slime, Slime
    script_set_flag $00A8
    script_end
Script_6059:: ; heuristic: event script entry or jump target; C0
    script_message $0433 ; 'Kweeeeeh!'
    script_encounter $05 ; encounter words: MadCondor, Slime, Slime
    script_set_flag $00A8
    script_end
Script_6062:: ; heuristic: event script entry or jump target; C0
    script_message $4439 ; 'I e lived here for 200'
    script_skip_if_no Script_606B
    script_message $843B ; 'Oh You won't humor an old'
    script_end
Script_606B:: ; heuristic: event script entry or jump target; C0
    script_message $843A ; 'This area had been prosperous, but'
    script_end
Script_606F:: ; heuristic: event script entry or jump target; C0
    script_message $4447 ; 'Want to know the most fundamental'
    script_skip_if_no Script_6078
    script_message $8449 ; 'I see. You wish to chart'
    script_end
Script_6078:: ; heuristic: event script entry or jump target; C0
    script_message $8448 ; 'Walk. Learn to walk everywhere. Be'
    script_end
Script_607C:: ; heuristic: event script entry or jump target; C0
Data_010_607C:: ; address name
    script_message $444B ; 'Welcome! How may I serve you?'
    script_jump_data_bank Script_6707
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_6083:: ; heuristic: event script entry or jump target; C0
    script_message $444C ; 'How may our church help you?'
    script_jump_data_bank Script_1F_77D4
    db $FF, $00, $51, $44, $E7, $0B, $69, $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_6091:: ; heuristic: event script entry or jump target; C0
    script_message $045A ; '0 checked the small hole. It'
    script_command SCRIPT_SCENE_SMALL_HOLE
    script_end
Script_6096:: ; heuristic: event script entry or jump target; C0
    script_message $045D ; 'You can take this treasure, but'
    script_set_flag $00AD
    script_encounter $06 ; encounter words: Metabble, Slime, Slime
    script_message $045F ; 'Heh, you're not half bad! As'
    script_walk 0, 0, 2
    script_walk 0, 3, 2
    script_hide_object $00
    script_set_flag $00AE
    script_command SCRIPT_HIDE_SPRITES
    script_end
Script_60B0:: ; heuristic: event script entry or jump target; C0
    script_message $045E ; 'I'm up for your challenge anytime!'
    script_encounter $06 ; encounter words: Metabble, Slime, Slime
    script_message $045F ; 'Heh, you're not half bad! As'
    script_walk 0, 0, 2
    script_walk 0, 3, 2
    script_hide_object $00
    script_set_flag $00AE
    script_command SCRIPT_HIDE_SPRITES
    script_end
Script_60C7:: ; heuristic: event script entry or jump target; C0
    script_message $0460 ; 'Let the power of justice smite'
    script_encounter $07 ; encounter words: Skeletor, Slime, Slime
    script_command SCRIPT_SCENE_JUSTICE_2
    script_end
Script_60CE:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_SCENE_JUSTICE
    script_end
Script_60D0:: ; heuristic: event script entry or jump target; C0
    script_sound $9B
    script_command SCRIPT_SCENE_GRAVESTONE
    script_end
Script_60D4:: ; heuristic: event script entry or jump target; C0
    script_message $4464 ; '0 checked the gravestone. There was'
    script_skip_if_no Script_60DD
    script_message $849F ; '0 released the grave's button.'
    script_end
Script_60DD:: ; heuristic: event script entry or jump target; C0
    script_sound $66
    script_wait 60
    script_message $8465 ; 'A door opened somewhere'
    script_command SCRIPT_SET_FLAG_322
    script_set_flag $00B2
    script_end
Script_60EA:: ; heuristic: event script entry or jump target; C0
    script_message $0466 ; 'You overcame the traps I laid'
    script_set_flag $00B3
    script_encounter $08 ; encounter words: Niterich, Slime, Slime
    script_message $0468 ; 'You e beaten me fairly Take'
    script_command SCRIPT_SCENE_BEATEN_FAIRLY
    script_set_flag $00B4
    script_set_flag $00C5
    script_set_flag $00C6
    script_set_flag $00C7
    script_end
Script_6103:: ; heuristic: event script entry or jump target; C0
    script_message $0467 ; 'Wahahahah! Here again, are you? I'
    script_encounter $08 ; encounter words: Niterich, Slime, Slime
    script_message $0468 ; 'You e beaten me fairly Take'
    script_command SCRIPT_SCENE_BEATEN_FAIRLY
    script_set_flag $00B4
    script_set_flag $00C5
    script_set_flag $00C6
    script_set_flag $00C7
    script_end
Script_6119:: ; heuristic: event script entry or jump target; C0
    script_message $0469 ; 'What? You have the three items?'
    script_walk 0, 2, 1
    script_hide_object $00
    script_set_flag $00B6
    script_end
Script_6126:: ; heuristic: event script entry or jump target; C0
    script_message $0471 ; 'I'm surprised anyone managed to find'
    script_command SCRIPT_SCENE_FOUND_ME
    script_face $80, 0
    script_set_flag $00B8
    script_end
Script_6131:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_SCENE_FOUND_ME_BATTLE
    script_end
Script_6133:: ; heuristic: event script entry or jump target; C0
    script_message $047A ; 'Ah, so good of you to'
    script_message $447B ; '0 handed over the Heaven Helmet.'
    script_message $C47C ; '0 handed over the Heaven Armor.'
    script_message $847D ; '0 handed over the Heaven Sword.'
    script_message $047E ; 'Good. You have brought the three'
    script_set_flag $00C0
    script_command SCRIPT_SCENE_THREE_ITEMS_BATTLE
    script_set_flag $00C1
    script_end
Script_614A:: ; heuristic: event script entry or jump target; C0
    script_message $047F ; 'Fwahahaha! Don't you ever give up?'
    script_command SCRIPT_SCENE_THREE_ITEMS_BATTLE
    script_set_flag $00C1
    script_end
Script_6152:: ; heuristic: event script entry or jump target; C0
    script_sound $28
    script_hold_dpad $02, 4
    script_slide_y $80
    script_walk 0, 0, 1
    script_message $0481 ; 'Kameha So it was you who'
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
    script_message $0482 ; 'Kameha If the three items that'
    script_command SCRIPT_SCENE_THREE_ITEMS
    script_end
Script_618B:: ; heuristic: event script entry or jump target; C0
    script_sound $65
    script_walk 1, 0, 4
    script_wait 10
    script_set_flag $00C4
    script_end
Script_6198:: ; heuristic: event script entry or jump target; C0
    script_message $04A7 ; 'This way Here Here'
    script_command SCRIPT_SCENE_THIS_WAY
    script_end
Script_619D:: ; heuristic: event script entry or jump target; C0
    script_message $4550 ; 'I heard from Lord Darck, but'
    script_skip_if_no Script_61A6
    script_message $855D ; 'You didn't bring the treasures? Well,'
    script_end
Script_61A6:: ; heuristic: event script entry or jump target; C0
    script_message $855C ; 'How dare you come without the'
    script_end
Script_61AA:: ; heuristic: event script entry or jump target; C0
    script_message $4550 ; 'I heard from Lord Darck, but'
    script_skip_if_no Script_61B3
    script_message $855D ; 'You didn't bring the treasures? Well,'
    script_end
Script_61B3:: ; heuristic: event script entry or jump target; C0
    script_message $8551 ; 'Surprisingly obedient, are you? Hand over'
    script_message $0552 ; '0 handed over the TidalBell. 0'
    script_face $80, 2
    script_command SCRIPT_TAKE_ITEM
    script_message $0553 ; 'Take these to Lord Darck now.'
    script_walk 1, 2, 5
    script_wait 30
    script_hide_object $01
    script_face $80, 0
    script_message $0554 ; 'My work is done I am'
    script_set_flag $00D2
    script_encounter $1D ; encounter words: Centasaur, GigaDraco, Garudian
    script_message $0556 ; 'N No How could my monsters'
    script_command SCRIPT_SCENE_DARCK_TAUNT
    script_set_flag $00D3
    script_end
Script_61DC:: ; heuristic: event script entry or jump target; C0
    script_message $0555 ; 'You seem to still not realize'
    script_encounter $1D ; encounter words: Centasaur, GigaDraco, Garudian
    script_message $0556 ; 'N No How could my monsters'
    script_command SCRIPT_SCENE_DARCK_TAUNT
    script_set_flag $00D3
    script_end
Script_61E9:: ; heuristic: event script entry or jump target; C0
    script_message $0557 ; 'Darck Fawahahah! You chased your treasures'
    script_set_flag $00D0
    script_encounter $0A ; encounter words: Darck, Slime, Slime
    script_message $0559 ; 'Darck Wha What? How could I'
    script_command SCRIPT_SCENE_DARCK_DEFEATED
    script_end
Script_61F6:: ; heuristic: event script entry or jump target; C0
    script_message $0558 ; 'Darck Fwahahahah! Bravo! Splendid! You e'
    script_encounter $0A ; encounter words: Darck, Slime, Slime
    script_message $0559 ; 'Darck Wha What? How could I'
    script_command SCRIPT_SCENE_DARCK_DEFEATED
    script_end
Script_6200:: ; heuristic: event script entry or jump target; C0
    script_face $80, 0
    script_command SCRIPT_SCENE_CYAL_SHINE
    script_walk 0, 2, 5
    script_set_flag $0140
    script_end
Script_620C:: ; heuristic: event script entry or jump target; C0
    script_message $0704 ; 'So Cyal took a shine to'
    script_slide_y $81
    script_message $0705 ; 'Cyal Yay, you'll be my friend?'
    script_set_flag $0143
    script_end
Script_6218:: ; heuristic: event script entry or jump target; C0
    script_message $0710 ; 'Well, well, a human here is'
    script_command SCRIPT_SCENE_ROLT_ELDER
    script_message $0711 ; 'Rolt That was fast, 0. I'
    script_slide_y $82
    script_message $0712 ; 'Cyal 0, let's play! I want'
    script_walk 2, 0, 2
    script_set_flag $0146
    script_end
Script_622C:: ; heuristic: event script entry or jump target; C0
    script_message $0713 ; 'I'm the village's elder. What's that?'
    script_command SCRIPT_SCENE_ROLT_ELDER
    script_message $0711 ; 'Rolt That was fast, 0. I'
    script_slide_y $82
    script_message $0712 ; 'Cyal 0, let's play! I want'
    script_walk 2, 0, 2
    script_set_flag $0146
    script_end
Script_6240:: ; heuristic: event script entry or jump target; C0
    script_message $0716 ; 'Cyal Listen, 0. We should go'
    script_walk_fast 2, 0, 4
    script_set_flag $0147
    script_end
Script_624B:: ; heuristic: event script entry or jump target; C0
    script_face $80, 0
    script_slide_y $80
    script_message $071D ; 'Cyal Oh! 0! I'm over here!'
    script_walk_fast 0, 2, 5
    script_wait 30
    script_face $00, 0
    script_message $071E ; '0 counted off'
    script_wait 30
    script_message $071F ; 'Cyal Eeek, 0! Help me!'
    script_set_flag $0148
    script_end
Script_626A:: ; heuristic: event script entry or jump target; C0
    script_slide_y $82
    script_message $0720 ; 'Master AgDevil, a human, ruff!'
    script_slide_y $83
    script_message $0721 ; 'What shall we do, ruff?'
    script_walk 1, 0, 1
    script_face $82, 2
    script_face $83, 1
    script_message $0722 ; 'Human? They taste horrible You lot'
    script_walk 1, 2, 1
    script_walk 1, 1, 1
    script_face $81, 2
    script_set_flag $0149
    script_end
Script_6290:: ; heuristic: event script entry or jump target; C0
    script_message $0724 ; 'That's what we'll do, kid. You're'
    script_set_flag $014A
    script_encounter $09 ; encounter words: ArrowDog, ArrowDog, Slime
    script_message $0754 ; 'Too strong Arroooh!'
    script_command SCRIPT_SCENE_TOO_STRONG
    script_set_flag $014B
    script_end
Script_62A0:: ; heuristic: event script entry or jump target; C0
    script_message $0727 ; 'You e come back again, ruff?'
    script_encounter $09 ; encounter words: ArrowDog, ArrowDog, Slime
    script_message $0754 ; 'Too strong Arroooh!'
    script_command SCRIPT_SCENE_TOO_STRONG
    script_set_flag $014B
    script_end
Script_62AD:: ; heuristic: event script entry or jump target; C0
    script_message $0728 ; 'Rolt What? Cyal was abducted? Who'
    script_walk_fast 1, 0, 7
    script_slide_y $80
    script_message $0729 ; 'Rolt, wait! Gone already'
    script_set_flag $014C
    script_end
Script_62BD:: ; heuristic: event script entry or jump target; C0
    script_message $4739 ; 'The human in the forest again?'
    script_encounter $0B ; encounter words: AgDevil, Slime, Slime
    script_message $073B ; 'Wh-what? I Lost to a child?'
    script_command SCRIPT_KEY_BOSS_BEATEN
    script_message $073C ; 'Rolt Wow 0, you're tough. Oh!'
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
    script_message $073D ; 'Rolt Cyal! Are you OK? Cyal!'
    script_wait 30
    script_face $81, 0
    script_message $073E ; 'Cyal Big brother! I was so'
    script_message $073F ; 'Rolt You're safe now. 0 did'
    script_face $82, 0
    script_message $0740 ; 'Rolt 0, I'm sorry we put'
    script_set_flag $0151
    script_set_flag $0203
    script_command SCRIPT_SCENE_CYAL_ROLT
    script_face $80, 3
    script_message $0741 ; 'I'm glad that Cyal and Rolt'
    script_end
Script_6313:: ; heuristic: event script entry or jump target; C0
    script_message $073A ; 'What, you again? Rude, rude, rude!'
    script_encounter $0B ; encounter words: AgDevil, Slime, Slime
    script_message $073B ; 'Wh-what? I Lost to a child?'
    script_command SCRIPT_KEY_BOSS_BEATEN
    script_message $073C ; 'Rolt Wow 0, you're tough. Oh!'
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
    script_message $073D ; 'Rolt Cyal! Are you OK? Cyal!'
    script_wait 30
    script_face $81, 0
    script_message $073E ; 'Cyal Big brother! I was so'
    script_message $073F ; 'Rolt You're safe now. 0 did'
    script_face $82, 0
    script_message $0740 ; 'Rolt 0, I'm sorry we put'
    script_set_flag $0151
    script_set_flag $0203
    script_command SCRIPT_SCENE_CYAL_ROLT
    script_face $80, 3
    script_message $0741 ; 'I'm glad that Cyal and Rolt'
    script_end
Script_6369:: ; heuristic: event script entry or jump target; C0
    script_message $0734 ; 'Rolt I e found you at'
    script_message $0735 ; 'Kikiki, what just you? That's utterly'
    script_message $0736 ; 'Rolt Shut up! Give back Cyal!'
    script_walk_fast 2, 2, 2
    script_command SCRIPT_SCENE_GIVE_BACK_CYAL
    script_set_flag $014F
    script_end
Script_637B:: ; heuristic: event script entry or jump target; C0
Data_010_637B:: ; address name
    script_message $470E ; 'Welcome! How may I help you'
    script_jump_data_bank Script_6707
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_6382:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0142
    script_message $4703 ; 'Are you maybe a human?'
Script_6388:: ; heuristic: event script entry or jump target; C0
    script_skip_if_no Script_6392
    script_slide_y $81
    script_message $CC57 ; 'Oh, don't lie! You don't look'
    script_jump Script_6388
Script_6392:: ; heuristic: event script entry or jump target; C0
    script_slide_y $81
    script_message $8C56 ; 'Really! Wow! You're the first human'
    script_end
Script_6398:: ; heuristic: event script entry or jump target; C0
    script_slide_y $80
    script_message $4759 ; 'Hoh? Ah, excuse my incivility. It's'
    script_skip_if_no Script_63A6
    script_message $875D ; 'Kiral No? How disappointing. Your efforts'
    script_set_flag $0159
    script_end
Script_63A6:: ; heuristic: event script entry or jump target; C0
    script_message $875B ; 'Kiral Hohoh! Grand, grand! Go fetch'
    script_walk 0, 3, 2
    script_face $80, 1
    script_wait 30
    script_slide_y $80
    script_message $075C ; 'Kiral Oh! Foolish of me, I'
    script_set_flag $015A
    script_end
Script_63BC:: ; heuristic: event script entry or jump target; C0
    script_message $475E ; 'Kiral I need help with my'
    script_skip_if_no Script_63C5
    script_message $875D ; 'Kiral No? How disappointing. Your efforts'
    script_end
Script_63C5:: ; heuristic: event script entry or jump target; C0
    script_message $875B ; 'Kiral Hohoh! Grand, grand! Go fetch'
    script_walk 0, 3, 2
    script_face $80, 1
    script_wait 30
    script_slide_y $80
    script_message $075C ; 'Kiral Oh! Foolish of me, I'
    script_set_flag $015A
    script_end
Script_63DB:: ; heuristic: event script entry or jump target; C0
    script_message $0767 ; '0 peered into the barrel. A'
    script_encounter $1F ; encounter words: Shadow, Slime, Slime
    script_set_flag $015D
    script_end
Script_63E4:: ; heuristic: event script entry or jump target; C0
    script_message $0767 ; '0 peered into the barrel. A'
    script_encounter $1F ; encounter words: Shadow, Slime, Slime
    script_set_flag $015E
    script_end
Script_63ED:: ; heuristic: event script entry or jump target; C0
    script_message $0769 ; 'PROFESSOR SAY GUARD TREASURE NEVER SURRENDER'
    script_message $076A ; 'Roboster is acting strangely. It appears'
    script_end
Script_63F4:: ; heuristic: event script entry or jump target; C0
    script_message $076D ; 'PRO SOR AY GGGGUARD TREZZZT'
    script_message $076E ; 'Its damage appears to have worsened.'
    script_end
Script_63FB:: ; heuristic: event script entry or jump target; C0
    script_message $0770 ; 'PIPIPI GGGGGGAGAGAGA'
    script_message $0771 ; 'Roboster is acting bizarrely. It appears'
    script_end
Script_6402:: ; heuristic: event script entry or jump target; C0
    script_message $0773 ; 'PI PI'
    script_message $0774 ; 'Roboster is acting as if demented.'
    script_end
Script_6409:: ; heuristic: event script entry or jump target; C0
    script_message $0776 ; 'Kiral Ah! Back! The treasure? What?'
    script_wait 30
    script_message $0777 ; 'Kiral Please Go stop him. He'
    script_set_flag $0162
    script_end
Script_6416:: ; heuristic: event script entry or jump target; C0
    script_message $076B ; '0 peered into the barrel. There'
    script_command SCRIPT_SCENE_BARREL
    script_end
Script_641B:: ; heuristic: event script entry or jump target; C0
    script_message $077D ; 'Kiral Ah! Back! Is Rob-N Did'
    script_message $077E ; '0 handed over the blue stone.'
    script_message $077F ; 'Kiral This stone, the WizStone, it'
    script_walk_fast 0, 1, 3
    script_command SCRIPT_SCENE_WIZSTONE
    script_set_flag $0165
    script_set_flag $0204
    script_end
Script_6430:: ; heuristic: event script entry or jump target; C0
    script_message $0795 ; 'Sigh'
    script_message $0796 ; 'The old man's sigh sounded sad'
    script_end
Script_6437:: ; heuristic: event script entry or jump target; C0
    script_message $0797 ; 'Sigh'
    script_message $0798 ; 'The old woman's sigh was desolate'
    script_end
Script_643E:: ; heuristic: event script entry or jump target; C0
Data_010_643E:: ; address name
    script_message $479D ; 'Hello! What may I do for'
    script_jump_data_bank Script_6707
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_6445:: ; heuristic: event script entry or jump target; C0
    script_message $479E ; 'Welcome to our traveler's inn.'
    script_jump_data_bank Script_690B
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_644C:: ; heuristic: event script entry or jump target; C0
    script_slide_y $81
    script_message $47A0 ; 'Excuse me, are you a master?'
    script_skip_if_no Script_645A
    script_message $87A2 ; 'I can't count on your support?'
    script_set_flag $01B0
    script_end
Script_645A:: ; heuristic: event script entry or jump target; C0
    script_message $87A1 ; 'Thank you! I knew you agree!'
    script_walk 1, 3, 2
    script_walk 1, 0, 6
    script_set_flag $01B1
    script_end
Script_6469:: ; heuristic: event script entry or jump target; C0
    script_message $47A3 ; 'Have you changed your mind? You'
    script_skip_if_no Script_6472
    script_message $87A2 ; 'I can't count on your support?'
    script_end
Script_6472:: ; heuristic: event script entry or jump target; C0
    script_message $87A1 ; 'Thank you! I knew you agree!'
    script_walk 1, 3, 2
    script_walk 1, 0, 6
    script_set_flag $01B1
    script_end
Script_6481:: ; heuristic: event script entry or jump target; C0
    script_message $47AB ; 'Lately, the town of Miagen has'
    script_skip_if_no Script_648A
    script_message $87AD ; 'You didn't know? Well, listen up.'
    script_end
Script_648A:: ; heuristic: event script entry or jump target; C0
    script_message $87AC ; 'It's rumored that monsters raid the'
    script_end
Script_648E:: ; heuristic: event script entry or jump target; C0
    script_message $07B6 ; 'This pendant is yours for 38,000G'
    script_command SCRIPT_SCENE_PENDANT_SELLER
    script_set_flag $01B9
    script_end
Script_6496:: ; heuristic: event script entry or jump target; C0
    script_set_flag $01BA
    script_message $07B9 ; 'You're going to regret seeing us.'
    script_encounter $11 ; encounter words: Pixy, Pixy, Slime
    script_message $07BC ; 'Please! Mercy! Spare us! Take back'
    script_command SCRIPT_SCENE_MERCY
    script_set_flag $01BB
    script_end
Script_64A6:: ; heuristic: event script entry or jump target; C0
    script_message $07BB ; 'We'll smash you as often as'
    script_encounter $11 ; encounter words: Pixy, Pixy, Slime
    script_message $07BC ; 'Please! Mercy! Spare us! Take back'
    script_command SCRIPT_SCENE_MERCY
    script_set_flag $01BB
    script_end
Script_64B3:: ; heuristic: event script entry or jump target; C0
    script_message $07BD ; '0 opened the treasure chest. 0'
    script_hide_object $00
    script_hide_object $02
    script_set_flag $01BC
    script_end
Script_64BE:: ; heuristic: event script entry or jump target; C0
    script_message $07C3 ; 'For 47,000G this earring What? You'
    script_slide_y $81
    script_message $07C4 ; 'You defeated the monsters? You're not'
    script_set_flag $01BD
    script_end
Script_64CA:: ; heuristic: event script entry or jump target; C0
    script_message $07CA ; '0 showed the Pretty Ring.'
    script_slide_y $80
    script_message $07CB ; 'Ah That ring Is Is it'
    script_message $07CC ; '0 handed over the Pretty Ring.'
    script_message $07CD ; 'Thank you for getting the ring'
    script_set_flag $01BE
    script_end
Script_64DC:: ; heuristic: event script entry or jump target; C0
    script_message $07CF ; 'Thank you for recovering our daughter's'
    script_message $07D1 ; '0 received a SageRock. But there'
    script_end
Script_64E3:: ; heuristic: event script entry or jump target; C0
    script_message $07CF ; 'Thank you for recovering our daughter's'
    script_message $07D0 ; '0 received a SageRock.'
    script_set_flag $01BF
    script_end
Script_64ED:: ; heuristic: event script entry or jump target; C0
    script_message $07DA ; 'What? Where I get my wares?'
    script_command SCRIPT_SCENE_PENDANT_SELLER
    script_walk_fast 1, 0, 2
    script_walk_fast 1, 1, 1
    script_walk_fast 1, 0, 4
    script_set_flag $01C0
    script_end
Script_6501:: ; heuristic: event script entry or jump target; C0
    script_message $07DC ; 'Milayou I thought this forest looked'
    script_command SCRIPT_SCENE_MILAYOU_FOREST
    script_set_flag $01C1
    script_end
Script_6509:: ; heuristic: event script entry or jump target; C0
    script_set_flag $01C2
    script_message $0CDE ; 'What is it, you little brat?'
    script_encounter $12 ; encounter words: Copycat, StoneMan, WhipBird
    script_message $0CE0 ; 'But No! I lost to this'
    script_command SCRIPT_KEY_BOSS_BEATEN_2
    script_walk 1, 2, 2
    script_face $00, 0
    script_message $0CE1 ; 'Milayou You are really special. I'
    script_walk 1, 0, 2
    script_hide_object $01
    script_set_flag $01C3
    script_set_flag $0205
    script_end
Script_652C:: ; heuristic: event script entry or jump target; C0
    script_message $0CDF ; 'What is it, you little brat?'
    script_encounter $12 ; encounter words: Copycat, StoneMan, WhipBird
    script_message $0CE0 ; 'But No! I lost to this'
    script_command SCRIPT_KEY_BOSS_BEATEN_2
    script_walk 1, 2, 2
    script_face $00, 0
    script_message $0CE1 ; 'Milayou You are really special. I'
    script_walk 1, 0, 2
    script_hide_object $01
    script_set_flag $01C3
    script_set_flag $0205
    script_end
Script_654C:: ; heuristic: event script entry or jump target; C0
    script_message $0CEF ; 'Milayou I asked for your support'
    script_slide_y $00
    script_message $0CF0 ; 'Milayou How do I know about'
    script_set_flag $01C4
    script_end
Script_6558:: ; heuristic: event script entry or jump target; C0
    script_set_flag $01C6
    script_message $4CF5 ; 'Milayou I knew you come back!'
    script_skip_if_no Script_6564
    script_message $8CF7 ; 'Milayou Oh I'm disappointed Come again'
    script_end
Script_6564:: ; heuristic: event script entry or jump target; C0
    script_message $8CF6 ; 'Milayou Great! No holding back!'
    script_encounter $13 ; encounter words: MetalKing, RainHawk, Coatol
    script_message $0CF9 ; 'Milayou I lost But, good battle!'
    script_walk 1, 3, 2
    script_walk 1, 0, 6
    script_set_flag $01C7
    script_end
Script_6578:: ; heuristic: event script entry or jump target; C0
    script_message $4CF8 ; 'Milayou Want to spar with me?'
    script_skip_if_no Script_6581
    script_message $8CF7 ; 'Milayou Oh I'm disappointed Come again'
    script_end
Script_6581:: ; heuristic: event script entry or jump target; C0
    script_message $8CF6 ; 'Milayou Great! No holding back!'
    script_encounter $13 ; encounter words: MetalKing, RainHawk, Coatol
    script_message $0CF9 ; 'Milayou I lost But, good battle!'
    script_walk 1, 3, 2
    script_walk 1, 0, 6
    script_set_flag $01C7
    script_end
Script_6595:: ; heuristic: event script entry or jump target; C0
    script_message $0C48 ; '0 checked the treasure chest. The'
    script_encounter $32 ; encounter words: Mimic, Slime, Slime
    script_command SCRIPT_SET_FLAG_REDRAW
    script_end
Script_659C:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_SCENE_CHEST_BATTLE
    script_end
Script_659E:: ; heuristic: event script entry or jump target; C0
    script_message $0C49 ; '0 checked the treasure chest. It'
    script_command SCRIPT_SCENE_YOU_DID_IT
    script_end
Script_65A3:: ; heuristic: event script entry or jump target; C0
    script_message $4123 ; 'Warubou Wa-hey! You did it, 0!'
    script_jump_data_bank Script_6707
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_65AA:: ; heuristic: event script entry or jump target; C0
Data_010_65AA:: ; address name
    script_message $4124 ; 'Warubou Wa-hey! You did it, 0!'
    script_jump_data_bank Script_690B
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_65B1:: ; heuristic: event script entry or jump target; C0
    script_message $4128 ; 'Warubou Wa-hey! That's it! GreatLog is'
    script_jump_data_bank Script_690B
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_65B8:: ; heuristic: event script entry or jump target; C0
    script_message $4127 ; 'Warubou Wa-hey! So, this is it?'
    script_jump_data_bank Script_1F_77D4
    db $FF

; runs one frame of script command type E0 (entry 223 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandE0:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_65BF:: ; address name
    farcall InnMenu
    ret

; runs one frame of script command type E1 (entry 224 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandE1:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_65C6:: ; address name
    farcall CloseInnMenu
    ret

; runs one frame of script command type E2 (entry 225 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandE2:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_65CD:: ; address name
    farcall ShopMenu
    ret

; runs one frame of script command type E3 (entry 226 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandE3:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_65D4:: ; address name
    farcall CloseShopMenu
    ret

; runs one frame of script command type E5 (entry 228 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandE5:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_65DB:: ; address name
    farcall VaultMenu
    ret

; runs one frame of script command type E6 (entry 229 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandE6:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_65E2:: ; address name
    farcall CloseVaultMenu
    ret

; runs one frame of script command type E8 (entry 231 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandE8:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_65E9:: ; address name
    farcall SwapMonstersMenu
    ret

; runs one frame of script command type E9 (entry 232 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandE9:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_65F0:: ; address name
    farcall CloseMenuE9
    ret

; runs one frame of script command type EB (entry 234 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandEB:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_65F7:: ; address name
    farcall HibernateMenu
    ret

; runs one frame of script command type EC (entry 235 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandEC:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_65FE:: ; address name
    farcall CloseHibernateMenu
    ret

; runs one frame of script command type ED (entry 236 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandED:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_6605:: ; address name
    farcall BreedMenu
    ret

; runs one frame of script command type EE (entry 237 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandEE:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_660C:: ; address name
    farcall CloseBreedMenu
    ret

; runs one frame of script command type EF (entry 238 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandEF:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_6613:: ; address name
    farcall EggServiceMenu
    ret

; runs one frame of script command type F0 (entry 239 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandF0:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_661A:: ; address name
    farcall RenameMenu
    ret

; runs one frame of script command type F1 (entry 240 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandF1:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_6621:: ; address name
    farcall CloseRenameMenu
    ret

; runs one frame of script command type F2 (entry 241 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandF2:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_6628:: ; address name
    farcall KeyAppraisalMenu
    ret

; runs one frame of script command type F3 (entry 242 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandF3:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_662F:: ; address name
    farcall MedalPrizeMenu
    ret

; runs one frame of script command type F4 (entry 243 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandF4:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_6636:: ; address name
    farcall NpcBreedMenu
    ret

; far-calls ScriptCommandE9_RunFar (E-0126)
; no direct call (reached through a table, a jump or a vector)
CallScriptCommandE9Far:: ; heuristic: follows a terminator; C0
Func_010_663D:: ; address name
    farcall ScriptCommandE9_RunFar
    ret

; runs one frame of script command type F6 (entry 245 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandF6:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_6644:: ; address name
    farcall LibraryMenu
    ret

; runs one frame of script command type F7 (entry 246 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandF7:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_664B:: ; address name
    farcall ArenaMenu
    ret

; runs one frame of script command type F8 (entry 247 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandF8:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_6652:: ; address name
    farcall PriestMenu
    ret

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_6659:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_SHOP
    script_command SCRIPT_SHOP
Script_665B:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_SHOP
    script_choice_jump Script_667D, Script_667A, Script_6674, Script_6662, Script_666B
Script_6662:: ; heuristic: event script entry or jump target; C0
    script_message $C007 ; 'You have no more room for'
    script_message $C008 ; 'Is there anything else?'
    script_jump Script_665B
Script_666B:: ; heuristic: event script entry or jump target; C0
    script_message $C00F ; 'You have no items to sell.'
    script_message $C008 ; 'Is there anything else?'
    script_jump Script_665B
Script_6674:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_SHOP_CLOSE
    script_message $8012 ; 'Thank you! Please come again.'
    script_command SCRIPT_SHOP_CLOSE
    script_end
Script_667A:: ; heuristic: event script entry or jump target; C0
    script_jump Script_66C9
Script_667D:: ; heuristic: event script entry or jump target; C0
    script_message $C006 ; 'What would you like to buy?'
    script_command SCRIPT_SHOP
    script_choice_jump Script_668F, Script_6688, Script_6685
Script_6685:: ; heuristic: event script entry or jump target; C0
    script_message $C013 ; 'You can't carry any more items.'
Script_6688:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_SHOP
    script_message $C008 ; 'Is there anything else?'
    script_jump Script_665B
Script_668F:: ; heuristic: event script entry or jump target; C0
    script_message $C009 ; 'How many would you like to'
    script_command SCRIPT_SHOP
    script_choice_jump Script_6699, Script_6696
Script_6696:: ; heuristic: event script entry or jump target; C0
    script_jump Script_667D
Script_6699:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_SHOP
    script_message $C014 ; 'That comes to 0G. OK?'
    script_command SCRIPT_SHOP
    script_choice_jump Script_66A6, Script_66AD, Script_66B4, Script_66A3
Script_66A3:: ; heuristic: event script entry or jump target; C0
    script_jump Script_668F
Script_66A6:: ; heuristic: event script entry or jump target; C0
    script_message $C00C ; 'Oh? You're short some gold.'
    script_command SCRIPT_SHOP
    script_jump Script_667D
Script_66AD:: ; heuristic: event script entry or jump target; C0
    script_message $C00D ; 'You can't carry any more items.'
    script_command SCRIPT_SHOP
    script_jump Script_667D
Script_66B4:: ; heuristic: event script entry or jump target; C0
    script_message $C00B ; 'Thank you!'
    script_command SCRIPT_SHOP
    script_choice_jump Script_66BF, Script_66BB
Script_66BB:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_SHOP
    script_jump Script_667D
Script_66BF:: ; heuristic: event script entry or jump target; C0
    script_message $C013 ; 'You can't carry any more items.'
    script_message $C008 ; 'Is there anything else?'
    script_command SCRIPT_SHOP
    script_jump Script_665B
Script_66C9:: ; heuristic: event script entry or jump target; C0
    script_message $C00E ; 'What would you like to sell?'
    script_command SCRIPT_SHOP
    script_choice_jump Script_66DE, Script_66D1, Script_66D7
Script_66D1:: ; heuristic: event script entry or jump target; C0
    script_message $C010 ; 'Sorry, but I can't price that.'
    script_jump Script_66C9
Script_66D7:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_SHOP
    script_message $C008 ; 'Is there anything else?'
    script_jump Script_665B
Script_66DE:: ; heuristic: event script entry or jump target; C0
    script_message $C011 ; 'How many will you sell?'
    script_command SCRIPT_SHOP
    script_choice_jump Script_66E8, Script_66E5
Script_66E5:: ; heuristic: event script entry or jump target; C0
    script_jump Script_66C9
Script_66E8:: ; heuristic: event script entry or jump target; C0
    script_message $C014 ; 'That comes to 0G. OK?'
    script_command SCRIPT_SHOP
    script_choice_jump Script_66F2, Script_66EF
Script_66EF:: ; heuristic: event script entry or jump target; C0
    script_jump Script_66DE
Script_66F2:: ; heuristic: event script entry or jump target; C0
    script_message $C00B ; 'Thank you!'
    script_command SCRIPT_SHOP
    script_choice_jump Script_66FD, Script_66F9
Script_66F9:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_SHOP
    script_jump Script_66C9
Script_66FD:: ; heuristic: event script entry or jump target; C0
    script_message $C00F ; 'You have no items to sell.'
    script_message $C008 ; 'Is there anything else?'
    script_command SCRIPT_SHOP
    script_jump Script_665B
Script_6707:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_SHOP
    script_command SCRIPT_SHOP
Script_6709:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_SHOP
    script_choice_jump Script_672B, Script_6728, Script_6722, Script_6710, Script_6719
Script_6710:: ; heuristic: event script entry or jump target; C0
    script_message $C033 ; 'You can't carry any more items.'
    script_message $C034 ; 'Is there anything else?'
    script_jump Script_6709
Script_6719:: ; heuristic: event script entry or jump target; C0
    script_message $C03B ; 'You have nothing to sell me.'
    script_message $C034 ; 'Is there anything else?'
    script_jump Script_6709
Script_6722:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_SHOP_CLOSE
    script_message $803E ; 'Thank you! Please come again!'
    script_command SCRIPT_SHOP_CLOSE
    script_end
Script_6728:: ; heuristic: event script entry or jump target; C0
    script_jump Script_6777
Script_672B:: ; heuristic: event script entry or jump target; C0
    script_message $C032 ; 'What would you like to buy?'
    script_command SCRIPT_SHOP
    script_choice_jump Script_673D, Script_6736, Script_6733
Script_6733:: ; heuristic: event script entry or jump target; C0
    script_message $C03F ; 'You can't carry any more items.'
Script_6736:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_SHOP
    script_message $C034 ; 'Is there anything else?'
    script_jump Script_6709
Script_673D:: ; heuristic: event script entry or jump target; C0
    script_message $C035 ; 'How many would you like?'
    script_command SCRIPT_SHOP
    script_choice_jump Script_6747, Script_6744
Script_6744:: ; heuristic: event script entry or jump target; C0
    script_jump Script_672B
Script_6747:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_SHOP
    script_message $C040 ; 'That will be 0G. OK?'
    script_command SCRIPT_SHOP
    script_choice_jump Script_6754, Script_675B, Script_6762, Script_6751
Script_6751:: ; heuristic: event script entry or jump target; C0
    script_jump Script_673D
Script_6754:: ; heuristic: event script entry or jump target; C0
    script_message $C038 ; 'You don't have enough gold.'
    script_command SCRIPT_SHOP
    script_jump Script_672B
Script_675B:: ; heuristic: event script entry or jump target; C0
    script_message $C039 ; 'You can't hold that many items.'
    script_command SCRIPT_SHOP
    script_jump Script_672B
Script_6762:: ; heuristic: event script entry or jump target; C0
    script_message $C037 ; 'Thank you!'
    script_command SCRIPT_SHOP
    script_choice_jump Script_676D, Script_6769
Script_6769:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_SHOP
    script_jump Script_672B
Script_676D:: ; heuristic: event script entry or jump target; C0
    script_message $C03F ; 'You can't carry any more items.'
    script_message $C034 ; 'Is there anything else?'
    script_command SCRIPT_SHOP
    script_jump Script_6709
Script_6777:: ; heuristic: event script entry or jump target; C0
    script_message $C03A ; 'What would you like to sell?'
    script_command SCRIPT_SHOP
    script_choice_jump Script_678C, Script_677F, Script_6785
Script_677F:: ; heuristic: event script entry or jump target; C0
    script_message $C03C ; 'I can't put a price on'
    script_jump Script_6777
Script_6785:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_SHOP
    script_message $C034 ; 'Is there anything else?'
    script_jump Script_6709
Script_678C:: ; heuristic: event script entry or jump target; C0
    script_message $C03D ; 'How many will you sell?'
    script_command SCRIPT_SHOP
    script_choice_jump Script_6796, Script_6793
Script_6793:: ; heuristic: event script entry or jump target; C0
    script_jump Script_6777
Script_6796:: ; heuristic: event script entry or jump target; C0
    script_message $C040 ; 'That will be 0G. OK?'
    script_command SCRIPT_SHOP
    script_choice_jump Script_67A0, Script_679D
Script_679D:: ; heuristic: event script entry or jump target; C0
    script_jump Script_678C
Script_67A0:: ; heuristic: event script entry or jump target; C0
    script_message $C037 ; 'Thank you!'
    script_command SCRIPT_SHOP
    script_choice_jump Script_67AB, Script_67A7
Script_67A7:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_SHOP
    script_jump Script_6777
Script_67AB:: ; heuristic: event script entry or jump target; C0
    script_message $C03B ; 'You have nothing to sell me.'
    script_message $C034 ; 'Is there anything else?'
    script_command SCRIPT_SHOP
    script_jump Script_6709
Script_67B5:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_VAULT
    script_command SCRIPT_VAULT
Script_67B7:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_VAULT
    script_choice_jump Script_67BC, Script_67BF, Script_67C2
Script_67BC:: ; heuristic: event script entry or jump target; C0
    script_jump Script_67C5
Script_67BF:: ; heuristic: event script entry or jump target; C0
    script_jump Script_6869
Script_67C2:: ; heuristic: event script entry or jump target; C0
    script_jump Script_6905
Script_67C5:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_VAULT
    script_message $C016 ; 'What should we store for you?'
Script_67C9:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_VAULT
    script_choice_jump Script_67D2, Script_67D9, Script_67E3, Script_67EA, Script_67F1, Script_67F4, Script_67F7
Script_67D2:: ; heuristic: event script entry or jump target; C0
    script_message $C017 ; 'You don't have any items.'
    script_command SCRIPT_VAULT
    script_jump Script_67DD
Script_67D9:: ; heuristic: event script entry or jump target; C0
    script_message $C019 ; 'Sorry, but you filled the Vault.'
    script_command SCRIPT_VAULT
Script_67DD:: ; heuristic: event script entry or jump target; C0
    script_message $C018 ; 'Is there anything else?'
    script_jump Script_67FB
Script_67E3:: ; heuristic: event script entry or jump target; C0
    script_message $C01E ; 'You don't have enough to store.'
    script_command SCRIPT_VAULT
    script_jump Script_67DD
Script_67EA:: ; heuristic: event script entry or jump target; C0
    script_message $C019 ; 'Sorry, but you filled the Vault.'
    script_command SCRIPT_VAULT
    script_jump Script_67DD
Script_67F1:: ; heuristic: event script entry or jump target; C0
    script_jump Script_67FF
Script_67F4:: ; heuristic: event script entry or jump target; C0
    script_jump Script_6848
Script_67F7:: ; heuristic: event script entry or jump target; C0
    script_message $C018 ; 'Is there anything else?'
    script_command SCRIPT_VAULT
Script_67FB:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_VAULT
    script_jump Script_67B7
Script_67FF:: ; heuristic: event script entry or jump target; C0
    script_message $C01A ; 'What item should I store for'
    script_command SCRIPT_VAULT
    script_choice_jump Script_681B, Script_680F, Script_6808, Script_6815
Script_6808:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_VAULT
    script_message $C016 ; 'What should we store for you?'
    script_jump Script_67C9
Script_680F:: ; heuristic: event script entry or jump target; C0
    script_message $C02C ; 'Sorry, but I can't take another'
    script_jump Script_67FF
Script_6815:: ; heuristic: event script entry or jump target; C0
    script_message $C030 ; 'I can't take any more of'
    script_jump Script_67FF
Script_681B:: ; heuristic: event script entry or jump target; C0
    script_message $C01B ; 'How many should I store?'
    script_command SCRIPT_VAULT
    script_choice_jump Script_682C, Script_6826, Script_6823
Script_6823:: ; heuristic: event script entry or jump target; C0
    script_jump Script_67FF
Script_6826:: ; heuristic: event script entry or jump target; C0
    script_message $C02F ; 'I can't store that many.'
    script_jump Script_681B
Script_682C:: ; heuristic: event script entry or jump target; C0
    script_message $C01C ; 'OK, I'll put that away for'
    script_command SCRIPT_VAULT
    script_choice_jump Script_6834, Script_683F, Script_6845
Script_6834:: ; heuristic: event script entry or jump target; C0
    script_message $C017 ; 'You don't have any items.'
Script_6837:: ; heuristic: event script entry or jump target; C0
    script_message $C018 ; 'Is there anything else?'
    script_command SCRIPT_VAULT
    script_command SCRIPT_VAULT
    script_jump Script_67B7
Script_683F:: ; heuristic: event script entry or jump target; C0
    script_message $C019 ; 'Sorry, but you filled the Vault.'
    script_jump Script_6837
Script_6845:: ; heuristic: event script entry or jump target; C0
    script_jump Script_67FF
Script_6848:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_VAULT
Script_6849:: ; heuristic: event script entry or jump target; C0
    script_message $C01F ; 'How much do you want to'
    script_command SCRIPT_VAULT
    script_choice_jump Script_685D, Script_6851, Script_6857
Script_6851:: ; heuristic: event script entry or jump target; C0
    script_message $C01D ; 'I can't store that much.'
    script_jump Script_6849
Script_6857:: ; heuristic: event script entry or jump target; C0
    script_message $C016 ; 'What should we store for you?'
    script_jump Script_67C9
Script_685D:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_VAULT
    script_message $C01C ; 'OK, I'll put that away for'
    script_message $C018 ; 'Is there anything else?'
    script_command SCRIPT_VAULT
    script_command SCRIPT_VAULT
    script_jump Script_67B7
Script_6869:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_VAULT
    script_message $C020 ; 'What will you be taking out?'
Script_686D:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_VAULT
    script_choice_jump Script_6876, Script_687D, Script_6887, Script_688E, Script_6895, Script_6898, Script_689B
Script_6876:: ; heuristic: event script entry or jump target; C0
    script_message $C021 ; 'I don't have any of your'
    script_command SCRIPT_VAULT
    script_jump Script_6881
Script_687D:: ; heuristic: event script entry or jump target; C0
    script_message $C022 ; 'You can't carry any more items.'
    script_command SCRIPT_VAULT
Script_6881:: ; heuristic: event script entry or jump target; C0
    script_message $C018 ; 'Is there anything else?'
    script_jump Script_67FB
Script_6887:: ; heuristic: event script entry or jump target; C0
    script_message $C026 ; 'You can't carry that much.'
    script_command SCRIPT_VAULT
    script_jump Script_6881
Script_688E:: ; heuristic: event script entry or jump target; C0
    script_message $C027 ; 'I don't have any of your'
    script_command SCRIPT_VAULT
    script_jump Script_6881
Script_6895:: ; heuristic: event script entry or jump target; C0
    script_jump Script_68A2
Script_6898:: ; heuristic: event script entry or jump target; C0
    script_jump Script_68E4
Script_689B:: ; heuristic: event script entry or jump target; C0
    script_message $C018 ; 'Is there anything else?'
    script_command SCRIPT_VAULT
    script_jump Script_67FB
Script_68A2:: ; heuristic: event script entry or jump target; C0
    script_message $C023 ; 'What do you want back?'
    script_command SCRIPT_VAULT
    script_choice_jump Script_68B7, Script_68B1, Script_68AA
Script_68AA:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_VAULT
    script_message $C020 ; 'What will you be taking out?'
    script_jump Script_686D
Script_68B1:: ; heuristic: event script entry or jump target; C0
    script_message $C02C ; 'Sorry, but I can't take another'
    script_jump Script_68A2
Script_68B7:: ; heuristic: event script entry or jump target; C0
    script_message $C024 ; 'How many do you want back?'
    script_command SCRIPT_VAULT
    script_choice_jump Script_68C8, Script_68C2, Script_68BF
Script_68BF:: ; heuristic: event script entry or jump target; C0
    script_jump Script_68A2
Script_68C2:: ; heuristic: event script entry or jump target; C0
    script_message $C026 ; 'You can't carry that much.'
    script_jump Script_68B7
Script_68C8:: ; heuristic: event script entry or jump target; C0
    script_message $C025 ; 'Here you go.'
    script_command SCRIPT_VAULT
    script_choice_jump Script_68D0, Script_68DB, Script_68E1
Script_68D0:: ; heuristic: event script entry or jump target; C0
    script_message $C022 ; 'You can't carry any more items.'
Script_68D3:: ; heuristic: event script entry or jump target; C0
    script_message $C018 ; 'Is there anything else?'
    script_command SCRIPT_VAULT
    script_command SCRIPT_VAULT
    script_jump Script_67B7
Script_68DB:: ; heuristic: event script entry or jump target; C0
    script_message $C02E ; 'I don't have any more items.'
    script_jump Script_68D3
Script_68E1:: ; heuristic: event script entry or jump target; C0
    script_jump Script_68A2
Script_68E4:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_VAULT
Script_68E5:: ; heuristic: event script entry or jump target; C0
    script_message $C028 ; 'How much gold will you withdraw?'
    script_command SCRIPT_VAULT
    script_choice_jump Script_68F9, Script_68ED, Script_68F3
Script_68ED:: ; heuristic: event script entry or jump target; C0
    script_message $C026 ; 'You can't carry that much.'
    script_jump Script_68E5
Script_68F3:: ; heuristic: event script entry or jump target; C0
    script_message $C020 ; 'What will you be taking out?'
    script_jump Script_686D
Script_68F9:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_VAULT
    script_message $C025 ; 'Here you go.'
    script_message $C018 ; 'Is there anything else?'
    script_command SCRIPT_VAULT
    script_command SCRIPT_VAULT
    script_jump Script_67B7
Script_6905:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_VAULT_CLOSE
    script_message $802D ; 'Come again anytime!'
    script_command SCRIPT_VAULT_CLOSE
    script_end
Script_690B:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_INN
    script_command SCRIPT_INN
    script_message $C000 ; 'It's 0G a night. Will you'
    script_skip_if_no Script_6917
    script_message $8002 ; 'Please come stay another time.'
    script_command SCRIPT_INN_CLOSE
    script_end
Script_6917:: ; heuristic: event script entry or jump target; C0
    script_command SCRIPT_INN
    script_skip_if_no Script_691F
    script_message $8003 ; 'Sorry, but you lack the money.'
    script_command SCRIPT_INN_CLOSE
    script_end
Script_691F:: ; heuristic: event script entry or jump target; C0
    script_message $C001 ; 'Well then, have a good rest.'
    script_command SCRIPT_INN
    script_message $8004 ; 'Good morning and farewell!'
    script_command SCRIPT_INN_CLOSE
    script_end
    ds $16D8, $00
