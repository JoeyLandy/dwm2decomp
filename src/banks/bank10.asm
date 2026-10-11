SECTION "Bank 10", ROMX[$4000], BANK[$10]
    db $10

; one frame of the event-script engine: FetchScriptCommand, then ExecuteScriptCommand
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_Case01)
RunEventScriptFrame::
Func_010_4001:: ; address name
    call FetchScriptCommand
    call ExecuteScriptCommand
    ret

; does nothing during a fade or unless wScriptStartRequest bit 7 is set (then it clears that bit and sets wScriptRunning); reads the opcode at wScriptPointer (through ReadWordFromDataBank when wScriptInDataBank is set) and jumps through a 13-entry opcode table; $FF ends the script (wScriptRunning, wScriptCommandType and wScriptInDataBank cleared, wModeState = 0, or 5 when wCC44 bit 7 is set); the opcode handlers set wScriptCommandType and its parameters and advance wScriptPointer
; 5 call sites from 5 routines (e.g. RunEventScriptFrame, RunFieldReturnPhase_Case02, RunMenuStateMenuState_Case05, GameMode5_Update_Case02, ...)
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

Jump_010_401D::
    ld a, [wScriptPointerLo]
    ld l, a
    ld a, [wScriptPointerHi]
    ld h, a
    ld a, [wScriptInDataBank]
    and a, a
    jr z, Jump_010_4032
    call ReadWordFromDataBank
    ld a, b
    inc hl
    jr Jump_010_4033

Jump_010_4032::
    ld a, [hl+]

Jump_010_4033::
    cp a, $FF
    jr nz, Jump_010_4054
    xor a, a
    ld [wScriptRunning], a
    ld [wScriptCommandType], a
    ld [wScriptInDataBank], a
    ld a, [wMapType]
    bit 7, a
    jr nz, Jump_010_404E
    ld a, $00
    ld [wModeState], a
    ret

Jump_010_404E::
    ld a, $05
    ld [wModeState], a
    ret

Jump_010_4054::
    push hl
    rst $00

; E-0039 (C1: the inline table after FetchScriptCommand's `rst $00`, indexed by the script byte; 249 words, 49 distinct handlers: opcodes 0-12 each have their own, and most others share ScriptFetchGeneric, which makes the opcode byte the command type and starts the command (the command then reads its own arguments from the script pointer); a zero word is an unused opcode).
; record: fetch handler for this script byte (opcode)
ScriptOpcodeHandlers::
Data_010_4056:: ; heuristic: start of a structured table; C0
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
    jr nz, Jump_010_4291
    ldh a, [hPlayerStateFlags]
    bit 3, a
    jr nz, Jump_010_428B
    ld a, $01
    ld [wScriptParam1], a
    ret

Jump_010_428B::
    ld a, $03
    ld [wScriptParam1], a
    ret

Jump_010_4291::
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
    jr z, Jump_010_42CE
    ld a, $01
    ld [wScriptCommandType], a
    call ReadWordFromDataBank
    ld a, b
    ld [wScriptParam0], a
    ld a, c
    ld [wScriptParam1], a
    inc hl
    inc hl
    jr Jump_010_42DB

Jump_010_42CE::
    ld a, $01
    ld [wScriptCommandType], a
    ld a, [hl+]
    ld [wScriptParam0], a
    ld a, [hl+]
    ld [wScriptParam1], a

Jump_010_42DB::
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
    jr Jump_010_42F4

; fetch handler for script opcode 02 (entry 2 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType, wScriptParam0, wScriptParam1, wScriptStep, wScriptPointerLo, wScriptPointerHi
ScriptFetch02:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_42EF:: ; address name
    ld a, $03
    ld [wScriptCommandType], a

Jump_010_42F4::
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
    jr z, Jump_010_43A6
    ld a, [wTextYesNoResult]
    or a, a
    jr nz, Jump_010_43A3
    call ReadWordFromDataBank
    inc hl
    ld a, b
    add a, l
    ld l, a
    jr nc, Jump_010_4398
    inc h

Jump_010_4398::
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    jp Jump_010_401D

Jump_010_43A3::
    inc hl
    jr Jump_010_4398

Jump_010_43A6::
    ld a, [wTextYesNoResult]
    or a, a
    jr nz, Jump_010_43BD
    ld a, [hl+]
    add_a_to_hl
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    jp Jump_010_401D

Jump_010_43BD::
    inc hl
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    jp Jump_010_401D

; fetch handler for script opcode 07 (entry 7 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptInDataBank, wScriptPointerLo, wScriptPointerHi, wMapType
; writes: wScriptPointerLo, wScriptPointerHi, wScriptRunning, wScriptCommandType, wScriptInDataBank, wModeState
ScriptFetch07:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_43C9:: ; address name
    pop hl
    ld a, [wScriptInDataBank]
    and a, a
    jr z, Jump_010_43DF
    call ReadWordFromDataBank
    ld a, b
    ld [wScriptPointerLo], a
    ld a, c
    ld [wScriptPointerHi], a
    inc hl
    jp Jump_010_401D

Jump_010_43DF::
    ld a, [hl+]
    ld [wScriptPointerLo], a
    ld a, [hl]
    ld [wScriptPointerHi], a
    jp Jump_010_401D

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
    jp Jump_010_401D

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
    jr nc, Jump_010_4420
    inc d

Jump_010_4420::
    ld a, $E0
    ld [de], a
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    jp Jump_010_401D

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
    jp Jump_010_401D

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
    jr z, Jump_010_447D
    cp a, $60
    jr c, Jump_010_4477
    call QueueSoundEffect
    jp Jump_010_401D

Jump_010_4477::
    call QueueMusic
    jp Jump_010_401D

Jump_010_447D::
    farcall RestartMapMusic
    jp Jump_010_401D

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
    jr c, Jump_010_44BA
    ld hl, $0088
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    xor a, a
    ld [wMessageState], a
    ret

Jump_010_44BA::
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
    jr c, Jump_010_44EB
    ld hl, $4097
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    xor a, a
    ld [wMessageState], a
    ret

Jump_010_44EB::
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
    jr z, Jump_010_45EE
    ld a, $01
    ld [wScriptCommandType], a
    call ReadWordFromDataBank
    ld a, b
    ld [wScriptParam0], a
    ld a, c
    ld [wScriptParam1], a
    inc hl
    inc hl
    jr Jump_010_45FB

Jump_010_45EE::
    ld a, $01
    ld [wScriptCommandType], a
    ld a, [hl+]
    ld [wScriptParam0], a
    ld a, [hl+]
    ld [wScriptParam1], a

Jump_010_45FB::
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
    jr z, Jump_010_4652
    ld a, $01
    ld [wScriptCommandType], a
    call ReadWordFromDataBank
    ld a, b
    ld [wScriptParam0], a
    ld a, c
    ld [wScriptParam1], a
    inc hl
    inc hl
    jr Jump_010_465F

Jump_010_4652::
    ld a, $01
    ld [wScriptCommandType], a
    ld a, [hl+]
    ld [wScriptParam0], a
    ld a, [hl+]
    ld [wScriptParam1], a

Jump_010_465F::
    push hl
    ld de, $0000
    call TestFlagBit
    jr c, Jump_010_4670
    ld a, [wScriptParam0]
    add a, $20
    ld [wScriptParam0], a

Jump_010_4670::
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
    jp Jump_010_401D

; fetch handler for script opcode E4 (entry 228 of ScriptOpcodeHandlers)
; no direct call (reached through a table, a jump or a vector)
; reads: wTwoChoiceCursor, wScriptInDataBank, wScriptPointerLo, wScriptPointerHi, wMapType
; writes: wScriptPointerLo, wScriptPointerHi, wScriptRunning, wScriptCommandType, wScriptInDataBank, wModeState
ScriptFetchE4:: ; code pointer of the table ScriptOpcodeHandlers; C0
Func_010_4694:: ; address name
    pop hl
    ld a, [wTwoChoiceCursor]
    ld c, a

Jump_010_4699::
    ld a, c
    and a, a
    jr z, Jump_010_46A1
    inc hl
    dec c
    jr Jump_010_4699

Jump_010_46A1::
    ld a, [wScriptInDataBank]
    and a, a
    jr z, Jump_010_46BC
    call ReadWordFromDataBank
    inc hl
    ld a, b
    add_a_to_hl
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    jp Jump_010_401D

Jump_010_46BC::
    ld a, [hl+]
    add_a_to_hl
    ld a, l
    ld [wScriptPointerLo], a
    ld a, h
    ld [wScriptPointerHi], a
    jp Jump_010_401D

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
Data_010_46F5:: ; heuristic: start of a structured table; C0
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
    farcall ScriptCommand9E_Run
    ret

; runs one frame of script command type 9D (entry 156 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand9D:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_48EC:: ; address name
    farcall ScriptCommand9D_Run
    ret

; runs one frame of script command type 9C (entry 155 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand9C:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_48F3:: ; address name
    farcall ScriptCommand9C_Run
    ret

; runs one frame of script command type 9B (entry 154 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand9B:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_48FA:: ; address name
    farcall ScriptCommand9B_Run
    ret

; runs one frame of script command type 9A (entry 153 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand9A:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4901:: ; address name
    farcall ScriptCommand9A_Run
    ret

; runs one frame of script command type 99 (entry 152 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand99:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4908:: ; address name
    farcall ScriptCommand99_Run
    ret

; runs one frame of script command type 98 (entry 151 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand98:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_490F:: ; address name
    farcall ScriptCommand98_Run
    ret

; runs one frame of script command type 95 (entry 148 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand95:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4916:: ; address name
    farcall ScriptCommand95_Run
    ret

; runs one frame of script command type 96 (entry 149 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand96:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_491D:: ; address name
    farcall ScriptCommand96_Run
    ret

; runs one frame of script command type 90 (entry 143 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand90:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4924:: ; address name
    farcall ScriptCommand90_Run
    ret

; runs one frame of script command type 91 (entry 144 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand91:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_492B:: ; address name
    farcall ScriptCommand91_Run
    ret

; runs one frame of script command type 92 (entry 145 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand92:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4932:: ; address name
    farcall ScriptCommand92_Run
    ret

; runs one frame of script command type 93 (entry 146 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand93:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4939:: ; address name
    farcall ScriptCommand93_Run
    ret

; runs one frame of script command type 94 (entry 147 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand94:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4940:: ; address name
    farcall ScriptCommand94_Run
    ret

; runs one frame of script command type 8D (entry 140 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand8D:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4947:: ; address name
    farcall ScriptCommand8D_Run
    ret

; runs one frame of script command type 8C (entry 139 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand8C:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_494E:: ; address name
    farcall ScriptCommand8C_Run
    ret

; runs one frame of script command type 8B (entry 138 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand8B:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4955:: ; address name
    farcall ScriptCommand8B_Run
    ret

; runs one frame of script command type 8F (entry 142 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand8F:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_495C:: ; address name
    farcall ScriptCommand8F_Run
    ret

; runs one frame of script command type 9F (entry 158 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand9F:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4963:: ; address name
    farcall ScriptCommand9F_Run
    ret

; runs one frame of script command type A0 (entry 159 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandA0:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_496A:: ; address name
    farcall ScriptCommandA0_Run
    ret

; runs one frame of script command type A1 (entry 160 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandA1:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4971:: ; address name
    farcall ScriptCommandA1_Run
    ret

; runs one frame of script command type 8E (entry 141 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand8E:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4978:: ; address name
    farcall ScriptCommand8E_Run
    ret

; runs one frame of script command type 8A (entry 137 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand8A:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_497F:: ; address name
    farcall ScriptCommand8A_Run
    ret

; runs one frame of script command type 80 (entry 127 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand80:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4986:: ; address name
    farcall ScriptCommand80_Run
    ret

; runs one frame of script command type 81 (entry 128 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand81:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_498D:: ; address name
    farcall ScriptCommand81_Run
    ret

; runs one frame of script command type 86 (entry 133 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand86:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4994:: ; address name
    farcall ScriptCommand86_Run
    ret

; runs one frame of script command type 82 (entry 129 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand82:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_499B:: ; address name
    farcall ScriptCommand82_Run
    ret

; runs one frame of script command type 83 (entry 130 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand83:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_49A2:: ; address name
    farcall ScriptCommand83_Run
    ret

; runs one frame of script command type 84 (entry 131 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand84:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_49A9:: ; address name
    farcall ScriptCommand84_Run
    ret

; runs one frame of script command type 85 (entry 132 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand85:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_49B0:: ; address name
    farcall ScriptCommand85_Run
    ret

; runs one frame of script command type 87 (entry 134 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand87:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_49B7:: ; address name
    farcall ScriptCommand87_Run
    ret

; runs one frame of script command type 88 (entry 135 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand88:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_49BE:: ; address name
    farcall ScriptCommand88_Run
    ret

; runs one frame of script command type 89 (entry 136 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand89:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_49C5:: ; address name
    farcall ScriptCommand89_Run
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
    farcall ScriptCommand0A_Run
    ret

; runs one frame of script command type 09 (entry 8 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptStep
ScriptCommand09:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_49F5:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand09_Case00
    dw ScriptCommand09_Case01
    dw ScriptCommand09_Case02
    dw ScriptCommand09_Case03

; entry 3 of the `rst $00` table in ScriptCommand09
; no direct call (reached through a table, a jump or a vector)
; reads: wTextWindowState
; writes: wScriptCommandType, wScriptRunning, wModeState
ScriptCommand09_Case03::
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
    dw ScriptCommand09_Case00
    dw ScriptCommand09_Case01
    dw ScriptCommand09_Case02
    dw ScriptCommand01_Case03

; entry 0 of the `rst $00` table in ScriptCommand09
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1, hPlayerY
; writes: wTextWindowState, wTextWindowStep, hSpriteWindowClipMode
; points at: wScriptStep
ScriptCommand09_Case00::
Jump_010_4A27:: ; address name
    ld a, [wScriptParam1]
    bit 7, a
    jr nz, Jump_010_4A62
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
    jr c, Jump_010_4A62
    ld a, $81
    ld [wTextWindowState], a
    ld a, $01
    ldh [hSpriteWindowClipMode], a

Jump_010_4A62::
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand09
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1, wTextWindowState, wScriptParam0
; points at: wScriptStep
ScriptCommand09_Case01::
Jump_010_4A67:: ; address name
    ld a, [wScriptParam1]
    bit 7, a
    jr nz, Jump_010_4A74
    ld a, [wTextWindowState]
    and a, $03
    ret nz

Jump_010_4A74::
    ld a, [wScriptParam0]
    ld l, a
    ld a, [wScriptParam1]
    ld h, a
    call ScriptCommand09_Case01_Sub01
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in ScriptCommand09
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScriptParam1, hPlayerY
; writes: hSpriteWindowClipMode, wTextWindowState, wTextWindowStep
; points at: wScriptStep
ScriptCommand09_Case02::
Jump_010_4A84:: ; address name
    ld a, [wTextFlags]
    bit 0, a
    ret nz
    ld a, [wScriptParam1]
    bit 6, a
    jr nz, Jump_010_4AAE
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
    jr c, Jump_010_4AAE
    ld a, $82
    ld [wTextWindowState], a

Jump_010_4AAE::
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in ScriptCommand01
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1, wTextWindowState
; writes: wScriptCommandType, wScriptStartRequest
ScriptCommand01_Case03::
Jump_010_4AB3:: ; address name
    ld a, [wScriptParam1]
    bit 6, a
    jr nz, Jump_010_4AC6
    ld a, [wTextWindowState]
    and a, $03
    ret nz
    farcall ClearBit1OfPlayerAndObjectFlags

Jump_010_4AC6::
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; only called from ScriptCommand09_Case01 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommand09_Case01)
; reads: wMessageMode, wMapType
; writes: wStringIndex, wStringCategory
ScriptCommand09_Case01_Sub01::
Func_010_4AD0:: ; address name
    ld a, h
    and a, $3F
    ld h, a
    push hl
    ld a, [wMessageMode]
    and a, a
    jr z, Jump_010_4B20
    dec a
    ld c, a
    sla a
    add a, c
    ld de, Data_010_4AFF
    add a, e
    ld e, a
    jr nc, Jump_010_4AE8
    inc d

Jump_010_4AE8::
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

Data_010_4AFF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $40, $F0, $01, $40, $F0, $0E, $52, $1F, $01, $40, $1D, $86, $4C, $1B, $D0
    db $43, $F2, $01, $40, $0D, $01, $40, $0E, $01, $40, $0B, $90, $64, $33, $10, $5D
    db $24

Jump_010_4B20::
    pop hl
    ld a, [wMapType]
    cp a, $80
    jr z, Jump_010_4B2D
    bit 7, a
    jp nz, Jump_010_4BA7

Jump_010_4B2D::
    ld a, l
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    ld a, h
    rst $00
    dw Func_010_4AD0_Case00
    dw Func_010_4AD0_Case01
    dw Func_010_4AD0_Case02
    dw Func_010_4AD0_Case03
    dw Func_010_4AD0_Case04
    dw Func_010_4AD0_Case05
    dw Func_010_4AD0_Case06
    dw Func_010_4AD0_Case06
    dw Func_010_4AD0_Case08
    dw Func_010_4AD0_Case09
    dw Func_010_4AD0_Case09
    dw Func_010_4AD0_Case0B
    dw Func_010_4AD0_Case0C
    dw Func_010_4AD0_Case0D

; entry 0 of the `rst $00` table in Func_010_4AD0
; no direct call (reached through a table, a jump or a vector)
Func_010_4AD0_Case00::
Jump_010_4B53:: ; address name
    farcall BeginStringDisplay_Bank28
    ret

; entry 1 of the `rst $00` table in Func_010_4AD0
; no direct call (reached through a table, a jump or a vector)
Func_010_4AD0_Case01::
Jump_010_4B5A:: ; address name
    farcall BeginStringDisplay_Bank29
    ret

; entry 2 of the `rst $00` table in Func_010_4AD0
; no direct call (reached through a table, a jump or a vector)
Func_010_4AD0_Case02::
Jump_010_4B61:: ; address name
    farcall BeginStringDisplay_Bank2A
    ret

; entry 3 of the `rst $00` table in Func_010_4AD0
; no direct call (reached through a table, a jump or a vector)
Func_010_4AD0_Case03::
Jump_010_4B68:: ; address name
    farcall BeginStringDisplay_Bank2B
    ret

; entry 4 of the `rst $00` table in Func_010_4AD0
; no direct call (reached through a table, a jump or a vector)
Func_010_4AD0_Case04::
Jump_010_4B6F:: ; address name
    farcall BeginStringDisplay_Bank2C
    ret

; entry 5 of the `rst $00` table in Func_010_4AD0
; no direct call (reached through a table, a jump or a vector)
Func_010_4AD0_Case05::
Jump_010_4B76:: ; address name
    farcall BeginStringDisplay_Bank2D
    ret

; entry 6 of the `rst $00` table in Func_010_4AD0
; no direct call (reached through a table, a jump or a vector)
Func_010_4AD0_Case06::
Jump_010_4B7D:: ; address name
    farcall BeginStringDisplay_Bank2E
    ret

; entry 8 of the `rst $00` table in Func_010_4AD0
; no direct call (reached through a table, a jump or a vector)
Func_010_4AD0_Case08::
Jump_010_4B84:: ; address name
    farcall BeginStringDisplay_Bank7C
    ret

; entry 9 of the `rst $00` table in Func_010_4AD0
; no direct call (reached through a table, a jump or a vector)
Func_010_4AD0_Case09::
Jump_010_4B8B:: ; address name
    farcall BeginStringDisplay_Bank80
    ret

; entry 11 of the `rst $00` table in Func_010_4AD0
; no direct call (reached through a table, a jump or a vector)
Func_010_4AD0_Case0B::
Jump_010_4B92:: ; address name
    farcall BeginStringDisplay_Bank82
    ret

; entry 12 of the `rst $00` table in Func_010_4AD0
; no direct call (reached through a table, a jump or a vector)
Func_010_4AD0_Case0C::
Jump_010_4B99:: ; address name
    farcall BeginStringDisplay_Bank86
    ret

; entry 13 of the `rst $00` table in Func_010_4AD0
; no direct call (reached through a table, a jump or a vector)
Func_010_4AD0_Case0D::
Jump_010_4BA0:: ; address name
    farcall BeginStringDisplay_Bank89
    ret

Jump_010_4BA7::
    ld a, h
    or a, a
    jr nz, Jump_010_4BBE
    ld a, l
    cp a, $20
    jr c, Jump_010_4BBE
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank83
    ret

Jump_010_4BBE::
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
    farcall ScriptCommand11_Run
    ret

; runs one frame of script command type 12 (entry 17 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand12:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4BE2:: ; address name
    farcall ScriptCommand12_Run
    ret

; runs one frame of script command type 13 (entry 18 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand13:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4BE9:: ; address name
    farcall ScriptCommand13_Run
    ret

; runs one frame of script command type 14 (entry 19 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand14:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4BF0:: ; address name
    farcall ScriptCommand14_Run
    ret

; runs one frame of script command type 15 (entry 20 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand15:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4BF7:: ; address name
    farcall ScriptCommand15_Run
    ret

; runs one frame of script command type 16 (entry 21 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand16:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4BFE:: ; address name
    farcall ScriptCommand16_Run
    ret

; runs one frame of script command type 17 (entry 22 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand17:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C05:: ; address name
    farcall ScriptCommand17_Run
    ret

; runs one frame of script command type 18 (entry 23 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand18:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C0C:: ; address name
    farcall ScriptCommand18_Run
    ret

; runs one frame of script command type 19 (entry 24 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand19:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C13:: ; address name
    farcall ScriptCommand19_Run
    ret

; runs one frame of script command type 1A (entry 25 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand1A:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C1A:: ; address name
    farcall ScriptCommand1A_Run
    ret

; runs one frame of script command type 1B (entry 26 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand1B:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C21:: ; address name
    farcall ScriptCommand1B_Run
    ret

; runs one frame of script command type 1C (entry 27 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand1C:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C28:: ; address name
    farcall ScriptCommand1C_Run
    ret

; runs one frame of script command type 1D (entry 28 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand1D:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C2F:: ; address name
    farcall ScriptCommand1D_Run
    ret

; runs one frame of script command type 1E (entry 29 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand1E:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C36:: ; address name
    farcall ScriptCommand1E_Run
    ret

; runs one frame of script command type 1F (entry 30 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand1F:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C3D:: ; address name
    farcall ScriptCommand1F_Run
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
    farcall ScriptCommand21_Run
    ret

; runs one frame of script command type 22 (entry 33 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand22:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C52:: ; address name
    farcall ScriptCommand22_Run
    ret

; runs one frame of script command type 23 (entry 34 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand23:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C59:: ; address name
    farcall ScriptCommand23_Run
    ret

; runs one frame of script command type 24 (entry 35 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand24:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C60:: ; address name
    farcall ScriptCommand24_Run
    ret

; runs one frame of script command type 25 (entry 36 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand25:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C67:: ; address name
    farcall ScriptCommand25_Run
    ret

; runs one frame of script command type 26 (entry 37 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand26:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C6E:: ; address name
    farcall ScriptCommand26_Run
    ret

; runs one frame of script command type 27 (entry 38 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand27:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C75:: ; address name
    farcall ScriptCommand27_Run
    ret

; runs one frame of script command type 28 (entry 39 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand28:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C7C:: ; address name
    farcall ScriptCommand28_Run
    ret

; runs one frame of script command type 29 (entry 40 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand29:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C83:: ; address name
    farcall ScriptCommand29_Run
    ret

; runs one frame of script command type 2A (entry 41 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand2A:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C8A:: ; address name
    farcall ScriptCommand2A_Run
    ret

; runs one frame of script command type 2B (entry 42 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand2B:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C91:: ; address name
    farcall ScriptCommand2B_Run
    ret

; runs one frame of script command type 2C (entry 43 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand2C:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C98:: ; address name
    farcall ScriptCommand2C_Run
    ret

; runs one frame of script command type 2D (entry 44 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand2D:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4C9F:: ; address name
    farcall ScriptCommand2D_Run
    ret

; runs one frame of script command type 2E (entry 45 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand2E:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4CA6:: ; address name
    farcall ScriptCommand2E_Run
    ret

; runs one frame of script command type 2F (entry 46 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand2F:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4CAD:: ; address name
    farcall ScriptCommand2F_Run
    ret

; runs one frame of script command type 30 (entry 47 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand30:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4CB4:: ; address name
    farcall ScriptCommand30_Run
    ret

; runs one frame of script command type 31 (entry 48 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand31:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4CBB:: ; address name
    farcall ScriptCommand31_Run
    ret

; runs one frame of script command type 32 (entry 49 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand32:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4CC2:: ; address name
    farcall ScriptCommand32_Run
    ret

; runs one frame of script command type 33 (entry 50 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand33:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4CC9:: ; address name
    farcall ScriptCommand33_Run
    ret

; runs one frame of script command type 34 (entry 51 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand34:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4CD0:: ; address name
    farcall ScriptCommand34_Run
    ret

; runs one frame of script command type 35 (entry 52 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand35:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4CD7:: ; address name
    farcall ScriptCommand35_Run
    ret

; runs one frame of script command type 36 (entry 53 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand36:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4CDE:: ; address name
    farcall ScriptCommand36_Run
    ret

; runs one frame of script command type 37 (entry 54 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand37:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4CE5:: ; address name
    farcall ScriptCommand37_Run
    ret

; runs one frame of script command type 38 (entry 55 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand38:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4CEC:: ; address name
    farcall ScriptCommand38_Run
    ret

; runs one frame of script command type 39 (entry 56 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand39:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4CF3:: ; address name
    farcall ScriptCommand39_Run
    ret

; runs one frame of script command type 3A (entry 57 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand3A:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4CFA:: ; address name
    farcall ScriptCommand3A_Run
    ret

; runs one frame of script command type 3B (entry 58 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand3B:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D01:: ; address name
    farcall ScriptCommand39_Run
    ret

; runs one frame of script command type 3C (entry 59 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand3C:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D08:: ; address name
    farcall ScriptCommand3C_Run
    ret

; runs one frame of script command type 3D (entry 60 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand3D:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D0F:: ; address name
    farcall ScriptCommand3D_Run
    ret

; runs one frame of script command type 3E (entry 61 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand3E:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D16:: ; address name
    farcall ScriptCommand3E_Run
    ret

; runs one frame of script command type 3F (entry 62 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand3F:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D1D:: ; address name
    farcall ScriptCommand3F_Run
    ret

; runs one frame of script command type 40 (entry 63 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand40:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D24:: ; address name
    farcall ScriptCommand40_Run
    ret

; runs one frame of script command type 41 (entry 64 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand41:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D2B:: ; address name
    farcall ScriptCommand41_Run
    ret

; runs one frame of script command type 42 (entry 65 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand42:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D32:: ; address name
    farcall ScriptCommand42_Run
    ret

; runs one frame of script command type 43 (entry 66 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand43:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D39:: ; address name
    farcall ScriptCommand43_Run
    ret

; runs one frame of script command type 44 (entry 67 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand44:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D40:: ; address name
    farcall ScriptCommand44_Run
    ret

; runs one frame of script command type 45 (entry 68 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand45:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D47:: ; address name
    farcall ScriptCommand45_Run
    ret

; runs one frame of script command type 46 (entry 69 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand46:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D4E:: ; address name
    farcall ScriptCommand46_Run
    ret

; runs one frame of script command type 47 (entry 70 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand47:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D55:: ; address name
    farcall ScriptCommand47_Run
    ret

; runs one frame of script command type 48 (entry 71 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand48:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D5C:: ; address name
    farcall ScriptCommand48_Run
    ret

; runs one frame of script command type 49 (entry 72 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand49:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D63:: ; address name
    farcall ScriptCommand49_Run
    ret

; runs one frame of script command type 4A (entry 73 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand4A:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D6A:: ; address name
    farcall ScriptCommand4A_Run
    ret

; runs one frame of script command type 4B (entry 74 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand4B:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D71:: ; address name
    farcall ScriptCommand4B_Run
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
    farcall ScriptCommand4D_Run
    ret

; runs one frame of script command type 4E (entry 77 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand4E:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D86:: ; address name
    farcall ScriptCommand4E_Run
    ret

; runs one frame of script command type 4F (entry 78 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand4F:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D8D:: ; address name
    farcall ScriptCommand4F_Run
    ret

; runs one frame of script command type 50 (entry 79 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand50:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D94:: ; address name
    farcall ScriptCommand50_Run
    ret

; runs one frame of script command type 51 (entry 80 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand51:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4D9B:: ; address name
    farcall ScriptCommand51_Run
    ret

; runs one frame of script command type 52 (entry 81 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand52:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4DA2:: ; address name
    farcall ScriptCommand52_Run
    ret

; runs one frame of script command type 53 (entry 82 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand53:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4DA9:: ; address name
    farcall ScriptCommand53_Run
    ret

; runs one frame of script command type 54 (entry 83 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand54:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4DB0:: ; address name
    farcall ScriptCommand54_Run
    ret

; runs one frame of script command type 55 (entry 84 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand55:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4DB7:: ; address name
    farcall ScriptCommand55_Run
    ret

; runs one frame of script command type 56 (entry 85 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand56:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4DBE:: ; address name
    farcall ScriptCommand56_Run
    ret

; runs one frame of script command type 57 (entry 86 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand57:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4DC5:: ; address name
    farcall ScriptCommand57_Run
    ret

; runs one frame of script command type 58 (entry 87 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand58:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4DCC:: ; address name
    farcall ScriptCommand58_Run
    ret

; runs one frame of script command type 59 (entry 88 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand59:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4DD3:: ; address name
    farcall ScriptCommand59_Run
    ret

; runs one frame of script command type 5A (entry 89 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand5A:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4DDA:: ; address name
    farcall ScriptCommand59_Run
    ret

; runs one frame of script command type 5B (entry 90 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand5B:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4DE1:: ; address name
    farcall ScriptCommand5B_Run
    ret

; runs one frame of script command type 5C (entry 91 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand5C:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4DE8:: ; address name
    farcall ScriptCommand5C_Run
    ret

; runs one frame of script command type 5D (entry 92 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand5D:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4DEF:: ; address name
    farcall ScriptCommand5D_Run
    ret

; runs one frame of script command type 5E (entry 93 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand5E:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4DF6:: ; address name
    farcall ScriptCommand5E_Run
    ret

; runs one frame of script command type 5F (entry 94 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand5F:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4DFD:: ; address name
    farcall ScriptCommand5F_Run
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
    farcall ScriptCommand61_Run
    ret

; runs one frame of script command type 62 (entry 97 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand62:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E12:: ; address name
    farcall ScriptCommand62_Run
    ret

; runs one frame of script command type 63 (entry 98 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand63:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E19:: ; address name
    farcall ScriptCommand63_Run
    ret

; runs one frame of script command type 64 (entry 99 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand64:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E20:: ; address name
    farcall ScriptCommand64_Run
    ret

; runs one frame of script command type 65 (entry 100 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand65:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E27:: ; address name
    farcall ScriptCommand65_Run
    ret

; runs one frame of script command type 66 (entry 101 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand66:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E2E:: ; address name
    farcall ScriptCommand66_Run
    ret

; runs one frame of script command type 67 (entry 102 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand67:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E35:: ; address name
    farcall ScriptCommand67_Run
    ret

; runs one frame of script command type 68 (entry 103 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand68:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E3C:: ; address name
    farcall ScriptCommand68_Run
    ret

; runs one frame of script command type 69 (entry 104 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand69:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E43:: ; address name
    farcall ScriptCommand69_Run
    ret

; runs one frame of script command type 6A (entry 105 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand6A:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E4A:: ; address name
    farcall ScriptCommand6A_Run
    ret

; runs one frame of script command type 6B (entry 106 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand6B:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E51:: ; address name
    farcall ScriptCommand6B_Run
    ret

; runs one frame of script command type 6C (entry 107 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand6C:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E58:: ; address name
    farcall ScriptCommand6C_Run
    ret

; runs one frame of script command type 6D (entry 108 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand6D:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E5F:: ; address name
    farcall ScriptCommand6D_Run
    ret

; runs one frame of script command type 6E (entry 109 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand6E:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E66:: ; address name
    farcall ScriptCommand6E_Run
    ret

; runs one frame of script command type 6F (entry 110 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand6F:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E6D:: ; address name
    farcall ScriptCommand6F_Run
    ret

; runs one frame of script command type 70 (entry 111 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand70:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E74:: ; address name
    farcall ScriptCommand70_Run
    ret

; runs one frame of script command type 71 (entry 112 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand71:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E7B:: ; address name
    farcall ScriptCommand71_Run
    ret

; runs one frame of script command type 72 (entry 113 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand72:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E82:: ; address name
    farcall ScriptCommand72_Run
    ret

; runs one frame of script command type 73 (entry 114 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand73:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E89:: ; address name
    farcall ScriptCommand73_Run
    ret

; runs one frame of script command type 74 (entry 115 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand74:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E90:: ; address name
    farcall ScriptCommand74_Run
    ret

; runs one frame of script command type 75 (entry 116 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand75:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4E97:: ; address name
    farcall ScriptCommand75_Run
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
    farcall ScriptCommand77_Run
    ret

; runs one frame of script command type 78 (entry 119 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand78:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4EAC:: ; address name
    farcall ScriptCommand78_Run
    ret

; runs one frame of script command type 79 (entry 120 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand79:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4EB3:: ; address name
    farcall ScriptCommand79_Run
    ret

; runs one frame of script command type 7A (entry 121 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand7A:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4EBA:: ; address name
    farcall ScriptCommand7A_Run
    ret

; runs one frame of script command type 7B (entry 122 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand7B:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4EC1:: ; address name
    farcall ScriptCommand7B_Run
    ret

; runs one frame of script command type 7C (entry 123 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand7C:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4EC8:: ; address name
    farcall ScriptCommand7C_Run
    ret

; runs one frame of script command type 7D (entry 124 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand7D:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4ECF:: ; address name
    farcall ScriptCommand7D_Run
    ret

; runs one frame of script command type 7E (entry 125 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand7E:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4ED6:: ; address name
    farcall ScriptCommand7E_Run
    ret

; runs one frame of script command type 7F (entry 126 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommand7F:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4EDD:: ; address name
    farcall ScriptCommand7F_Run
    ret

; runs one frame of script command type C0 (entry 191 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandC0:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4EE4:: ; address name
    farcall ScriptCommandC0_Run
    ret

; runs one frame of script command type C1 (entry 192 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandC1:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4EEB:: ; address name
    farcall ScriptCommandC1_Run
    ret

; runs one frame of script command type C2 (entry 193 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandC2:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4EF2:: ; address name
    farcall ScriptCommandC2_Run
    ret

; runs one frame of script command type C3 (entry 194 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandC3:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4EF9:: ; address name
    farcall ScriptCommandC3_Run
    ret

; runs one frame of script command type C6 (entry 197 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandC6:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4F00:: ; address name
    farcall ScriptCommandC6_Run
    ret

; runs one frame of script command type C4 (entry 195 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandC4:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4F07:: ; address name
    farcall ScriptCommandC4_Run
    ret

; runs one frame of script command type C5 (entry 196 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandC5:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4F0E:: ; address name
    farcall ScriptCommandC5_Run
    ret

; runs one frame of script command type C7 (entry 198 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandC7:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4F15:: ; address name
    farcall ScriptCommandC7_Run
    ret

; runs one frame of script command type C8 (entry 199 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandC8:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4F1C:: ; address name
    farcall ScriptCommandC8_Run
    ret

; runs one frame of script command type C9 (entry 200 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandC9:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4F23:: ; address name
    farcall ScriptCommandC9_Run
    ret

; runs one frame of script command type CA (entry 201 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandCA:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4F2A:: ; address name
    farcall ScriptCommandCA_Run
    ret

; runs one frame of script command type CB (entry 202 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandCB:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4F31:: ; address name
    farcall ScriptCommandCB_Run
    ret

; runs one frame of script command type CC (entry 203 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandCC:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4F38:: ; address name
    farcall ScriptCommandCC_Run
    ret

; runs one frame of script command type CD (entry 204 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandCD:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4F3F:: ; address name
    farcall ScriptCommandCD_Run
    ret

; runs one frame of script command type CE (entry 205 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandCE:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4F46:: ; address name
    farcall ScriptCommandCE_Run
    ret

; runs one frame of script command type CF (entry 206 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandCF:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_4F4D:: ; address name
    farcall ScriptCommandCF_Run
    ret

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_4F54:: ; heuristic: event script entry or jump target; C0
    script_sound $28
    script_message $0030 ; 'If some monster masters keep their'
    script_op $05, $81, $01
    script_message $0031 ; 'Heh, so these are the newcomers?'
    script_command $1B
    script_sound $FF
    script_set_flag $0015
    script_end
Script_4F66:: ; heuristic: event script entry or jump target; C0
    script_message $404C ; 'Warubou It's a dead end, warooh!'
    script_skip_if_no Script_4F6F
    script_message $804E ; 'Wow, you kids sure learn quick!'
    script_end
Script_4F6F:: ; heuristic: event script entry or jump target; C0
    script_message $804D ; 'Have you heard about Magic Keys?'
    script_end
Script_4F73:: ; heuristic: event script entry or jump target; C0
    script_sound $28
    script_command $12
    script_message $0033 ; 'Hello, there! You must be the'
    script_sound $FF
    script_end
Script_4F7C:: ; heuristic: event script entry or jump target; C0
    script_sound $28
    script_op $03, $64, $00
    script_command $13
    script_op $03, $1E, $00
    script_sound $FF
    script_end
Script_4F88:: ; heuristic: event script entry or jump target; C0
    script_message $0045 ; '0 checked the peculiar door. It'
    script_command $11
    script_end
Script_4F8D:: ; heuristic: event script entry or jump target; C0
    script_op $0B, $82
    script_message $0050 ; 'Warubou Wa-hey! Give me something! Then,'
    script_command $14
    script_message $0051 ; 'Warubou Wha ? I smell something!'
    script_set_flag $000A
    script_command $15
    script_sound $FF
    script_end
Script_4F9D:: ; heuristic: event script entry or jump target; C0
    script_sound $28
    script_command $16
    script_message $005D ; 'Warubou Warooh! Will it hold? You'
    script_end
Script_4FA4:: ; heuristic: event script entry or jump target; C0
    script_message $001E ; '0 peered into the barrel. It'
    script_command $6B
    script_message $0020 ; 'Cobi Sure, Mama! We'll be fine.'
    script_set_flag $0003
    script_end
Script_4FAF:: ; heuristic: event script entry or jump target; C0
    script_message $006A ; 'Prince Kameha was saying the same'
    script_command $17
    script_message $006B ; 'Did you get the package from'
    script_end
Script_4FB7:: ; heuristic: event script entry or jump target; C0
    script_message $4028 ; '0 peered into the vase. It'
    script_skip_if_no Script_4FCC
    script_message $802A ; 'Oh? Well, that's fine then. Go'
    script_command $73
    script_op $0B, $01
    script_message $002D ; 'I aspired to be one long'
    script_message $002C ; 'Cobi Hahah! 0 won't last a'
    script_set_flag $0014
    script_end
Script_4FCC:: ; heuristic: event script entry or jump target; C0
    script_message $8029 ; 'I e heard that there are'
    script_end
Script_4FD0:: ; heuristic: event script entry or jump target; C0
    script_message $4028 ; '0 peered into the vase. It'
    script_skip_if_no Script_4FE4
    script_message $802A ; 'Oh? Well, that's fine then. Go'
    script_op $0B, $01
    script_message $002B ; 'Monster masters are those people who'
    script_message $002C ; 'Cobi Hahah! 0 won't last a'
    script_set_flag $0014
    script_end
Script_4FE4:: ; heuristic: event script entry or jump target; C0
    script_message $8029 ; 'I e heard that there are'
    script_end
Script_4FE8:: ; heuristic: event script entry or jump target; C0
    script_message $0060 ; 'Warubou A new plug for the'
    script_op $0B, $01
    script_message $0063 ; 'Look, an island just doesn't sink.'
    script_message $0062 ; 'Cobi Why won't you believe us?'
    script_set_flag $000E
    script_end
Script_4FF7:: ; heuristic: event script entry or jump target; C0
    script_message $0060 ; 'Warubou A new plug for the'
    script_op $0B, $01
    script_message $0061 ; 'Hah? The island's going to sink?'
    script_message $0062 ; 'Cobi Why won't you believe us?'
    script_set_flag $000E
    script_end
Script_5006:: ; heuristic: event script entry or jump target; C0
    script_message $007A ; 'You say the island will sink?'
    script_op $0B, $01
    script_message $407B ; 'Warubou Wa-hey! Good, you're back. You'
    script_skip_if_no Script_5017
    script_message $807C ; 'Warubou No time to waste, warooh!'
    script_set_flag $0016
    script_end
Script_5017:: ; heuristic: event script entry or jump target; C0
    script_message $807F ; 'Warubou Wa-hey! No more dawdling! GreatLog'
    script_command $19
    script_message $0080 ; 'Warubou Wa-hey! Good, good, good! In'
    script_command $1A
    script_message $0081 ; 'Warubou This here is a Magic'
    script_message $0082 ; '0 received the Oasis Key.'
    script_set_flag $001A
    script_end
Script_5029:: ; heuristic: event script entry or jump target; C0
    script_message $407D ; 'Warubou No? Then find someone!'
    script_skip_if_no Script_5036
Script_502E:: ; heuristic: event script entry or jump target; C0
    script_message $C07E ; 'Warubou Wa-hey? No one believed! You'
    script_skip_if_no Script_5036
    script_jump Script_502E
Script_5036:: ; heuristic: event script entry or jump target; C0
    script_jump Script_5017
Script_5039:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0011
    script_set_flag $0017
    script_command $18
    script_message $0085 ; 'Warubou This you use to come'
    script_message $0086 ; '0 received the GreatLog Key.'
    script_command $1C
    script_op $01, $00, $02, $03
    script_op $01, $00, $01, $02
    script_op $05, $80, $02
    script_op $05, $00, $00
    script_op $05, $01, $00
    script_message $008C ; 'Cobi That's true If we both'
    script_op $05, $00, $01
    script_op $05, $01, $03
    script_command $1D
    script_end
Script_5063:: ; heuristic: event script entry or jump target; C0
    script_op $03, $1E, $00
    script_message $0000 ; ''t 'l 'l 'l6 M 6'
    script_command $75
    script_op $03, $3C, $00
    script_op $01, $03, $00, $01
    script_op $05, $81, $02
    script_op $03, $5A, $00
    script_op $05, $81, $00
    script_op $01, $03, $03, $03
    script_op $03, $3C, $00
    script_op $01, $02, $01, $06
    script_op $01, $02, $02, $01
    script_op $05, $82, $01
    script_op $05, $00, $03
    script_op $0B, $82
    script_message $0002 ; 'Cobi 0! Papa's calling. He's at'
    script_op $01, $02, $03, $01
    script_op $05, $82, $01
    script_set_flag $0012
    script_end
Script_509F:: ; heuristic: event script entry or jump target; C0
    script_op $03, $1E, $00
    script_message $0000 ; ''t 'l 'l 'l6 M 6'
    script_command $75
    script_op $03, $3C, $00
    script_op $01, $03, $00, $01
    script_op $05, $81, $02
    script_op $03, $5A, $00
    script_op $05, $81, $00
    script_op $01, $03, $03, $03
    script_op $03, $3C, $00
    script_op $01, $02, $01, $06
    script_op $01, $02, $02, $01
    script_op $05, $82, $01
    script_op $05, $00, $03
    script_op $0B, $82
    script_message $0001 ; 'In the middle of the sea'
    script_op $01, $02, $03, $01
    script_op $05, $82, $01
    script_set_flag $0012
    script_end
Script_50DB:: ; heuristic: event script entry or jump target; C0
    script_message $0013 ; 'Land ho! There's GreatLog!'
    script_op $05, $80, $01
    script_op $0B, $80
    script_message $0012 ; 'Cobi 0! They said GreatLog will'
    script_op $05, $81, $01
    script_op $05, $82, $01
    script_op $05, $00, $01
    script_op $0B, $82
    script_op $03, $78, $00
    script_command $77
    script_end
Script_50F6:: ; heuristic: event script entry or jump target; C0
    script_message $0011 ; '0 peered into the vase. Freshly'
    script_op $05, $80, $01
    script_op $0B, $80
    script_message $0012 ; 'Cobi 0! They said GreatLog will'
    script_op $05, $81, $01
    script_op $05, $82, $01
    script_op $05, $00, $01
    script_op $0B, $82
    script_op $03, $78, $00
    script_command $77
    script_end
Script_5111:: ; heuristic: event script entry or jump target; C0
    script_command $6A
    script_message $0015 ; 'This is a tale of children'
    script_op $01, $00, $02, $05
    script_op $05, $80, $01
    script_op $05, $81, $03
    script_end
Script_5120:: ; heuristic: event script entry or jump target; C0
    script_message $4007 ; 'There's a spirit in GreatLog that's'
    script_skip_if_no Script_5129
    script_message $8009 ; 'Good. That's good to hear! You'
    script_end
Script_5129:: ; heuristic: event script entry or jump target; C0
    script_message $8008 ; 'Sailing is sure exhilarating. Right?'
    script_end
Script_512D:: ; heuristic: event script entry or jump target; C0
    script_command $82
    script_end
Script_512F:: ; heuristic: event script entry or jump target; C0
    script_command $83
    script_end
Script_5131:: ; heuristic: event script entry or jump target; C0
    script_command $84
    script_end
Script_5133:: ; heuristic: event script entry or jump target; C0
    script_command $85
    script_end
Script_5135:: ; heuristic: event script entry or jump target; C0
    script_command $9E
    script_end
Script_5137:: ; heuristic: event script entry or jump target; C0
    script_command $87
    script_end
Script_5139:: ; heuristic: event script entry or jump target; C0
    script_command $88
    script_end
Script_513B:: ; heuristic: event script entry or jump target; C0
    script_command $89
    script_end
Script_513D:: ; heuristic: event script entry or jump target; C0
    script_command $8A
    script_end
Script_513F:: ; heuristic: event script entry or jump target; C0
    script_command $8E
    script_end
Script_5141:: ; heuristic: event script entry or jump target; C0
    script_command $A0
    script_end
Script_5143:: ; heuristic: event script entry or jump target; C0
    script_command $A1
    script_end
Script_5145:: ; heuristic: event script entry or jump target; C0
    script_command $86
    script_end
Script_5147:: ; heuristic: event script entry or jump target; C0
    script_command $81
    script_end
Script_5149:: ; heuristic: event script entry or jump target; C0
    script_command $80
    script_end
Script_514B:: ; heuristic: event script entry or jump target; C0
    script_command $90
    script_end
Script_514D:: ; heuristic: event script entry or jump target; C0
    script_command $91
    script_end
Script_514F:: ; heuristic: event script entry or jump target; C0
    script_command $92
    script_end
Script_5151:: ; heuristic: event script entry or jump target; C0
    script_command $93
    script_end
Script_5153:: ; heuristic: event script entry or jump target; C0
    script_command $94
    script_end
Script_5155:: ; heuristic: event script entry or jump target; C0
    script_command $8B
    script_end
Script_5157:: ; heuristic: event script entry or jump target; C0
    script_command $8C
    script_end
Script_5159:: ; heuristic: event script entry or jump target; C0
    script_command $8D
    script_end
Script_515B:: ; heuristic: event script entry or jump target; C0
    script_command $8F
    script_end
Script_515D:: ; heuristic: event script entry or jump target; C0
    script_command $9F
    script_end
Script_515F:: ; heuristic: event script entry or jump target; C0
    script_op $04, $00, $05
    script_command $95
    script_end
Script_5164:: ; heuristic: event script entry or jump target; C0
    script_op $04, $00, $05
    script_command $96
    script_end
Script_5169:: ; heuristic: event script entry or jump target; C0
    script_command $9A
    script_end
Script_516B:: ; heuristic: event script entry or jump target; C0
    script_command $9B
    script_end
Script_516D:: ; heuristic: event script entry or jump target; C0
    script_command $98
    script_end
Script_516F:: ; heuristic: event script entry or jump target; C0
    script_command $99
    script_end
Script_5171:: ; heuristic: event script entry or jump target; C0
    script_command $9C
    script_end
Script_5173:: ; heuristic: event script entry or jump target; C0
    script_command $9D
    script_end
Script_5175:: ; heuristic: event script entry or jump target; C0
    script_message $0100 ; ''t 't 't0 3'l1 R 7'
    script_message $0101 ; 'Are you going out to play?'
    script_set_flag $01A7
    script_end
Script_517F:: ; heuristic: event script entry or jump target; C0
    script_message $0200 ; ''t 'l 'l S r N'
    script_message $0201 ; 'You e been going out a'
    script_add_gold 200
    script_end
Script_5189:: ; heuristic: event script entry or jump target; C0
    script_message $48A1 ; 'Father put up a bridge across'
    script_skip_if_no Script_5192
    script_message $88A4 ; 'Mama handed over 400G.'
    script_end
Script_5192:: ; heuristic: event script entry or jump target; C0
    script_message $88A2 ; 'Oh? You'll run another errand?'
    script_message $08A3 ; 'My, what has gotten into you?'
    script_add_gold 400
    script_set_flag $0183
    script_end
Script_519F:: ; heuristic: event script entry or jump target; C0
    script_message $08A6 ; 'I need you to get me'
    script_message $08A7 ; 'Oh You e found what I'
    script_set_flag $0184
    script_end
Script_51A9:: ; heuristic: event script entry or jump target; C0
    script_message $48A1 ; 'Father put up a bridge across'
    script_skip_if_no Script_51B2
    script_message $88A4 ; 'Mama handed over 400G.'
    script_end
Script_51B2:: ; heuristic: event script entry or jump target; C0
    script_message $88A8 ; '0 handed over the Potion.'
    script_message $08A9 ; 'Well, could you go buy a'
    script_add_gold 600
    script_set_flag $0185
    script_end
Script_51BF:: ; heuristic: event script entry or jump target; C0
    script_message $08A6 ; 'I need you to get me'
    script_message $08AC ; '0 handed over the Rib.'
    script_set_flag $0186
    script_end
    db $00, $01, $43, $06, $04, $00, $04, $83, $FF, $00, $02, $83, $00, $03, $03, $0E
    db $B0, $04, $0A, $87, $01, $FF, $00, $01, $43, $06, $04, $00, $04, $83, $FF, $00
    db $07, $83, $00, $08, $03, $0E, $B0, $04, $0A, $89, $01, $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_51F5:: ; heuristic: event script entry or jump target; C0
    script_message $4A25 ; 'Oh Then I'll ask Cobi.'
    script_skip_if_no Script_51FE
    script_message $8A26 ; 'I was going to ask Tara,'
    script_end
Script_51FE:: ; heuristic: event script entry or jump target; C0
    script_message $8A22 ; 'I was going to ask Cobi,'
    script_message $0A23 ; 'The farm that your father always'
    script_add_gold 1200
    script_set_flag $018B
    script_end
Script_520B:: ; heuristic: event script entry or jump target; C0
    script_message $4A21 ; 'Father dug under the island, and'
    script_skip_if_no Script_5214
    script_message $8A24 ; 'Mama handed over 1,200G.'
    script_end
Script_5214:: ; heuristic: event script entry or jump target; C0
    script_message $8A22 ; 'I was going to ask Cobi,'
    script_message $0A23 ; 'The farm that your father always'
    script_add_gold 1200
    script_set_flag $018B
    script_end
Script_5221:: ; heuristic: event script entry or jump target; C0
    script_message $0A28 ; 'Buy some Sirloin for our dinner.'
    script_message $0A29 ; 'They didn't have any around here.'
    script_set_flag $018C
    script_end
Script_522B:: ; heuristic: event script entry or jump target; C0
    script_message $0212 ; 'I hear rumors that Prince Kameha'
    script_message $0213 ; 'Oh? You bought the LoveWater! This'
    script_op $01, $00, $03, $01
    script_op $01, $00, $02, $02
    script_op $05, $80, $03
    script_op $03, $3C, $00
    script_op $05, $81, $00
    script_op $0B, $81
    script_op $0B, $81
    script_op $03, $1E, $00
    script_op $02, $01, $00, $02
    script_op $02, $01, $01, $02
    script_op $02, $01, $00, $06
    script_end
Script_5256:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0102
    script_message $410D ; 'Oh, that's cute! Hahahahaha! We have'
    script_jump_data_bank $5A3A ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5260:: ; heuristic: event script entry or jump target; C0
    script_message $410E ; 'Cobi Hi, I'm helping Papa to'
    script_jump_data_bank $5A3A ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5267:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0105
    script_message $4207 ; 'You're the child of the farmer?'
    script_jump_data_bank $5A3A ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5271:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0109
    script_message $48BC ; 'You have to tamp the ground'
    script_jump_data_bank $5A3A ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_527B:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0115
    script_message $4A30 ; 'Oh, don't be that way. I'm'
    script_jump_data_bank $5A3A ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5285:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0121
    script_message $4502 ; 'People have been whispering that GreatLog'
    script_jump_data_bank $5A3A ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_528F:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0131
    script_message $4B02 ; 'You and your monsters saved GreatLog'
    script_jump_data_bank $5A3A ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5299:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0102
    script_message $410F ; 'Cobi Hi, 0! What's up today?'
    script_jump_data_bank $5A3A ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_52A3:: ; heuristic: event script entry or jump target; C0
    script_message $4110 ; 'Tara I'm helping Papa take care'
    script_jump_data_bank $5A3A ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_52AA:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0105
    script_message $4208 ; 'Cobi 0, what was it like'
    script_jump_data_bank $5A3A ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_52B4:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0109
    script_message $48BD ; 'Cobi 0, what was it like'
    script_jump_data_bank $5A3A ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_52BE:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0115
    script_message $4A31 ; 'Cobi 0, what was it like'
    script_jump_data_bank $5A3A ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_52C8:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0121
    script_message $4503 ; 'Cobi 0, tell me about what'
    script_jump_data_bank $5A3A ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_52D2:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0131
    script_message $4B03 ; 'Cobi 0, I envied you for'
    script_jump_data_bank $5A3A ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_52DC:: ; heuristic: event script entry or jump target; C0
    script_message $0105 ; 'Tara Big brother, while you're in'
    script_message $0106 ; 'Why do you have a monster'
    script_end
Script_52E3:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0190
    script_message $48AF ; 'My father was a Slime and'
    script_skip_if_no Script_52EF
    script_message $88B1 ; 'I like to get help for'
    script_end
Script_52EF:: ; heuristic: event script entry or jump target; C0
    script_message $88B0 ; 'Beavern helped put up the bridge.'
    script_end
Script_52F3:: ; heuristic: event script entry or jump target; C0
    script_message $48B3 ; 'A MadGopher joined you? Could you'
    script_skip_if_no Script_52FC
    script_message $88B5 ; 'Great, 0! Thanks a lot! This'
    script_end
Script_52FC:: ; heuristic: event script entry or jump target; C0
    script_message $88B4 ; 'A MadGopher joined you? Could you'
    script_command $3C
    script_message $0D17 ; 'What's wrong, MadGopher? Did you find'
    script_message $0D18 ; 'Here, 0! You need this!'
    script_message $0D19 ; '0 received the Ice Key.'
    script_set_flag $0191
    script_end
Script_530D:: ; heuristic: event script entry or jump target; C0
    script_message $48B3 ; 'A MadGopher joined you? Could you'
    script_skip_if_no Script_5316
    script_message $88B5 ; 'Great, 0! Thanks a lot! This'
    script_end
Script_5316:: ; heuristic: event script entry or jump target; C0
    script_message $88B4 ; 'A MadGopher joined you? Could you'
    script_command $3C
    script_message $0D48 ; 'Here, 0! You hold onto it.'
    script_set_flag $01A3
    script_set_flag $0191
    script_end
Script_5324:: ; heuristic: event script entry or jump target; C0
    script_message $48B3 ; 'A MadGopher joined you? Could you'
    script_skip_if_no Script_532D
    script_message $88B5 ; 'Great, 0! Thanks a lot! This'
    script_end
Script_532D:: ; heuristic: event script entry or jump target; C0
    script_message $88B4 ; 'A MadGopher joined you? Could you'
    script_command $3C
    script_message $0D47 ; 'What's wrong, MadGopher? Did you dig'
    script_message $0D41 ; 'I like you to have this.'
    script_message $0D19 ; '0 received the Ice Key.'
    script_set_flag $0191
    script_end
Script_533E:: ; heuristic: event script entry or jump target; C0
Data_010_533E:: ; address name
    script_message $420D ; 'The castle is in an uproar'
    script_jump_data_bank Script_6659
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5345:: ; heuristic: event script entry or jump target; C0
Data_010_5345:: ; address name
    script_message $420E ; 'You're too young to be shopping.'
    script_jump_data_bank Script_6659
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_534C:: ; heuristic: event script entry or jump target; C0
Data_010_534C:: ; address name
    script_message $4D89 ; 'I teased you as a cute'
    script_jump_data_bank Script_6659
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5353:: ; heuristic: event script entry or jump target; C0
Data_010_5353:: ; address name
    script_set_flag $0103
    script_message $411C ; 'Hm? Are you a master hopeful?'
    script_jump_data_bank Script_67B5
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_535D:: ; heuristic: event script entry or jump target; C0
    script_message $411D ; 'Oh, hi! Good to see you'
    script_jump_data_bank Script_67B5
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5364:: ; heuristic: event script entry or jump target; C0
Data_010_5364:: ; address name
    script_set_flag $0127
    script_message $4B1C ; 'The woman next to me cries'
    script_jump_data_bank Script_67B5
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_536E:: ; heuristic: event script entry or jump target; C0
    script_message $411F ; 'If your party is wiped out,'
    script_skip_if_no Script_5377
    script_message $8121 ; 'Warubou Quit dawdling, warooh!'
    script_end
Script_5377:: ; heuristic: event script entry or jump target; C0
    script_message $8120 ; 'Warubou Wa-hey! You remember the promise'
    script_end
    db $00, $9E, $42, $06, $04, $00, $A2, $82, $FF, $00, $9F, $82, $FF, $00, $9E, $42
    db $06, $04, $00, $A2, $82, $FF, $00, $A0, $82, $FF, $00, $A3, $02, $3B, $0A, $2F
    db $01, $FF, $00, $A3, $02, $3B, $0A, $35, $01, $FF, $00, $A3, $02, $3B, $0A, $39
    db $01, $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_53AD:: ; heuristic: event script entry or jump target; C0
    script_message $452A ; 'Grandpa and the others are going'
    script_skip_if_no Script_53B6
    script_message $8531 ; 'Warubou Wa-hey! Take the treasures that'
    script_end
Script_53B6:: ; heuristic: event script entry or jump target; C0
    script_message $8530 ; 'Warubou Limbo is the King's domain!'
    script_end
Script_53BA:: ; heuristic: event script entry or jump target; C0
    script_message $452A ; 'Grandpa and the others are going'
    script_skip_if_no Script_53C3
    script_message $8531 ; 'Warubou Wa-hey! Take the treasures that'
    script_end
Script_53C3:: ; heuristic: event script entry or jump target; C0
    script_message $852B ; 'Warubou Wa-hey! Are you ready? Ready'
    script_command $5B
    script_message $052F ; '0 received the SkyShield.'
    script_set_flag $013B
    script_end
Script_53CE:: ; heuristic: event script entry or jump target; C0
    script_command $6D
    script_end
Script_53D0:: ; heuristic: event script entry or jump target; C0
    script_command $6E
    script_end
Script_53D2:: ; heuristic: event script entry or jump target; C0
    script_message $4A36 ; 'I'm a bug, so I'm not'
    script_skip_if_no Script_53DB
    script_message $8A38 ; 'What's that? You saw Prince Kameha'
    script_end
Script_53DB:: ; heuristic: event script entry or jump target; C0
    script_message $8A37 ; 'Prince Kameha has been missing from'
    script_set_flag $0117
    script_command $59
    script_message $0A3A ; 'The man here has rare keys.'
    script_message $0A3B ; 'Sire, this child claims to know'
    script_op $01, $00, $00, $01
    script_message $0D28 ; '0 checked the treasure chest. The'
    script_op $01, $00, $02, $01
    script_op $05, $80, $00
    script_message $0D29 ; '0 obtained the Sky Key.'
    script_end
Script_53FA:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0117
    script_message $4504 ; 'Tara Big brother, tell me about'
    script_skip_if_no Script_540D
    script_message $8506 ; 'People have been saying that they'
    script_command $5A
    script_message $0507 ; 'Hey! You're the kid who said'
    script_set_flag $0122
    script_end
Script_540D:: ; heuristic: event script entry or jump target; C0
    script_message $8505 ; 'If the island sink, is no'
    script_command $5A
    script_message $0507 ; 'Hey! You're the kid who said'
    script_set_flag $0122
    script_end
Script_5418:: ; heuristic: event script entry or jump target; C0
    script_message $021D ; 'Monsters hate being away from their'
    script_sound $65
    script_op $01, $01, $00, $03
    script_end
Script_5422:: ; heuristic: event script entry or jump target; C0
    script_message $4264 ; 'Oh You're so lucky to have'
    script_skip_if_no Script_542B
    script_message $8266 ; 'R Really? Wow! Thank you! I'
    script_end
Script_542B:: ; heuristic: event script entry or jump target; C0
    script_message $8265 ; 'Oh You're so lucky to have'
    script_command $3A
    script_set_flag $012D
    script_end
Script_5433:: ; heuristic: event script entry or jump target; C0
    script_message $4B47 ; 'My granddaughter became a master. She's'
    script_skip_if_no Script_543C
    script_message $8D81 ; 'Really? Let's go to the Arena!'
    script_end
Script_543C:: ; heuristic: event script entry or jump target; C0
    script_message $8D80 ; 'Really? Let's go to the Arena!'
    script_command $7B
    script_end
    db $00, $27, $42, $06, $04, $00, $29, $82, $FF, $00, $28, $82, $FF, $0A, $08, $01
    db $00, $2A, $42, $E7, $7B, $78, $FF, $00, $2B, $42, $E7, $7B, $78, $FF, $0A, $2D
    db $00, $00, $49, $4B, $E7, $7B, $78, $FF, $0A, $9E, $01, $00, $F0, $4D, $00, $F1
    db $CD, $E7, $7B, $78, $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5476:: ; heuristic: event script entry or jump target; C0
    script_message $4230 ; 'Even I can cast spells if'
    script_skip_if_no Script_547F
    script_message $8232 ; 'Oh You e read this book'
    script_end
Script_547F:: ; heuristic: event script entry or jump target; C0
    script_message $8231 ; 'Do you have any idea about'
    script_end
Script_5483:: ; heuristic: event script entry or jump target; C0
    script_message $4246 ; '0 peered into the vase. It'
    script_skip_if_no Script_548C
    script_message $8248 ; 'Did she say anything to you?'
    script_end
Script_548C:: ; heuristic: event script entry or jump target; C0
    script_message $8247 ; 'Hey, let me ask you something.'
    script_end
Script_5490:: ; heuristic: event script entry or jump target; C0
    script_message $4257 ; '0 checked the dresser. It was'
    script_skip_if_no Script_5499
    script_message $8259 ; 'Monsters should have cute names.'
    script_end
Script_5499:: ; heuristic: event script entry or jump target; C0
    script_message $8258 ; 'Did you know that there's a'
    script_end
Script_549D:: ; heuristic: event script entry or jump target; C0
    script_message $44C3 ; 'I strike with my eight tentacles.'
    script_jump_data_bank Script_96_6FF8
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_54A4:: ; heuristic: event script entry or jump target; C0
    script_message $44C4 ; 'Welcome. I'm the Christener. I can'
    script_jump_data_bank $6FF8 ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_54AB:: ; heuristic: event script entry or jump target; C0
    script_message $4A4E ; 'The island used to be lush'
    script_jump_data_bank $4335 ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_54B2:: ; heuristic: event script entry or jump target; C0
    script_message $4A4F ; 'Hello, 0, welcome! This is the'
    script_jump_data_bank Script_1D_4335
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_54B9:: ; heuristic: event script entry or jump target; C0
    script_message $4A5A ; '0 read the sign. Ssh Monsters'
    script_message $8A5B ; '0 checked the casket.'
    script_end
Script_54C0:: ; heuristic: event script entry or jump target; C0
    script_message $4A5A ; '0 read the sign. Ssh Monsters'
    script_message $8A5C ; 'Zzz Use the plan Charge in'
    script_end
Script_54C7:: ; heuristic: event script entry or jump target; C0
    script_message $4A5E ; '0 read the sign. Watch your'
    script_message $8A5F ; '0 peered into the hole.'
    script_end
Script_54CE:: ; heuristic: event script entry or jump target; C0
    script_message $4281 ; 'Mama is a big worrier But'
    script_skip_if_no Script_54D7
    script_message $8283 ; 'In the Kids Class final, watch'
    script_end
Script_54D7:: ; heuristic: event script entry or jump target; C0
    script_message $8282 ; 'Oh, a cute little master! Are'
    script_end
Script_54DB:: ; heuristic: event script entry or jump target; C0
    script_message $4A60 ; 'Zzz Zzz Some skills are developed'
    script_skip_if_no Script_54E4
    script_message $8283 ; 'In the Kids Class final, watch'
    script_end
Script_54E4:: ; heuristic: event script entry or jump target; C0
    script_message $8A61 ; 'Oh, you're the Kids Class Champ!'
    script_end
Script_54E8:: ; heuristic: event script entry or jump target; C0
    script_message $4A62 ; 'In the C Class final, you'll'
    script_skip_if_no Script_54F1
    script_message $8283 ; 'In the Kids Class final, watch'
    script_end
Script_54F1:: ; heuristic: event script entry or jump target; C0
    script_message $8A63 ; 'Oh, you're the C Class Champ!'
    script_end
Script_54F5:: ; heuristic: event script entry or jump target; C0
    script_message $4A64 ; 'In the B Class final, you'll'
    script_skip_if_no Script_54FE
    script_message $8283 ; 'In the Kids Class final, watch'
    script_end
Script_54FE:: ; heuristic: event script entry or jump target; C0
    script_message $8A65 ; 'Oh, you're the B Class Champ!'
    script_end
Script_5502:: ; heuristic: event script entry or jump target; C0
    script_message $4A66 ; 'In the A Class final, you'll'
    script_skip_if_no Script_550B
    script_message $8283 ; 'In the Kids Class final, watch'
    script_end
Script_550B:: ; heuristic: event script entry or jump target; C0
    script_message $8A67 ; 'Oh, you're the A Class Champ!'
    script_end
Script_550F:: ; heuristic: event script entry or jump target; C0
    script_message $4281 ; 'Mama is a big worrier But'
    script_skip_if_no Script_5518
    script_message $8283 ; 'In the Kids Class final, watch'
    script_end
Script_5518:: ; heuristic: event script entry or jump target; C0
    script_message $8216 ; 'Aooh, LoveWater soothes sunburn'
    script_end
Script_551C:: ; heuristic: event script entry or jump target; C0
    script_message $4A60 ; 'Zzz Zzz Some skills are developed'
    script_skip_if_no Script_5525
    script_message $8283 ; 'In the Kids Class final, watch'
    script_end
Script_5525:: ; heuristic: event script entry or jump target; C0
    script_message $8A7F ; 'Warubou Wa-hey, we don't have the'
    script_end
Script_5529:: ; heuristic: event script entry or jump target; C0
    script_message $4A62 ; 'In the C Class final, you'll'
    script_skip_if_no Script_5532
    script_message $8283 ; 'In the Kids Class final, watch'
    script_end
Script_5532:: ; heuristic: event script entry or jump target; C0
    script_message $8A80 ; 'In the C Class final, you'll'
    script_end
Script_5536:: ; heuristic: event script entry or jump target; C0
    script_message $4A64 ; 'In the B Class final, you'll'
    script_skip_if_no Script_553F
    script_message $8283 ; 'In the Kids Class final, watch'
    script_end
Script_553F:: ; heuristic: event script entry or jump target; C0
    script_message $8A81 ; 'In the B Class final, you'll'
    script_end
Script_5543:: ; heuristic: event script entry or jump target; C0
    script_message $4A66 ; 'In the A Class final, you'll'
    script_skip_if_no Script_554C
    script_message $8283 ; 'In the Kids Class final, watch'
    script_end
Script_554C:: ; heuristic: event script entry or jump target; C0
    script_message $8A82 ; 'In the A Class final, you'll'
    script_end
Script_5550:: ; heuristic: event script entry or jump target; C0
    script_message $426B ; '0 checked the plush doll. It'
    script_skip_if_no Script_5559
    script_message $826D ; 'You're young, so you have to'
    script_end
Script_5559:: ; heuristic: event script entry or jump target; C0
    script_message $C26C ; 'Welcome to the Arena! Masters pit'
    script_jump_data_bank $7A51 ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5560:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0189
    script_message $4270 ; 'Congratulations! You're the champ! For winning'
    script_jump_data_bank $7A51 ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_556A:: ; heuristic: event script entry or jump target; C0
    script_message $4271 ; 'Welcome to the Arena! The rules'
    script_jump_data_bank $7A51 ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5571:: ; heuristic: event script entry or jump target; C0
    script_message $4D86 ; 'A master who can satisfy me'
    script_jump_data_bank $7A51 ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5578:: ; heuristic: event script entry or jump target; C0
    script_message $4275 ; 'Oh? But your key ring is'
    script_message $8274 ; '0 received a Magic Key.'
    script_end
Script_557F:: ; heuristic: event script entry or jump target; C0
    script_message $0275 ; 'Oh? But your key ring is'
    script_message $0273 ; 'Congratulations! You're the champ! The D'
    script_end
Script_5586:: ; heuristic: event script entry or jump target; C0
    script_message $04B0 ; 'I lost again. I need to'
    script_end
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_558B:: ; heuristic: event script entry or jump target; C0
    script_message $44B3 ; 'I'll be here for a while'
    script_skip_if_no Script_5594
    script_message $84B2 ; 'Good! Let's get started!'
    script_end
Script_5594:: ; heuristic: event script entry or jump target; C0
    script_message $C4B1 ; 'I lost again. I need to'
    script_end
Script_5598:: ; heuristic: event script entry or jump target; C0
    script_message $48CF ; 'Many trees have submerged The island'
    script_set_flag $010F
    script_jump_data_bank Script_96_6EF7
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_55A2:: ; heuristic: event script entry or jump target; C0
    script_message $48D0 ; 'Um I'm the Egg Evaluator. You'
    script_jump_data_bank $6EF7 ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_55A9:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0028
    script_message $4B20 ; 'My grandpa gave me a key,'
    script_jump_data_bank $6EF7 ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_55B3:: ; heuristic: event script entry or jump target; C0
    script_message $48D3 ; 'Go down these stairs to the'
    script_set_flag $0110
    script_jump_data_bank Script_15_764B
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_55BD:: ; heuristic: event script entry or jump target; C0
    script_message $48D4 ; 'Welcome to the Starry Shrine. I'm'
    script_jump_data_bank $764B ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_55C4:: ; heuristic: event script entry or jump target; C0
    script_set_flag $002C
    script_message $4B2E ; 'Warubou Wa-hey, the bond between human'
    script_jump_data_bank $764B ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_55CE:: ; heuristic: event script entry or jump target; C0
    script_message $48D5 ; 'Welcome to the Starry Shrine. What'
    script_skip_if_no Script_55D7
    script_message $88D7 ; 'You can breed monsters and hatch'
    script_end
Script_55D7:: ; heuristic: event script entry or jump target; C0
    script_message $88D6 ; 'I'm the Prof's assistant. Do you'
    script_end
Script_55DB:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0112
    script_message $4A6D ; 'I should be more assertive. It's'
    script_jump_data_bank Script_0C_7BA9
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_55E5:: ; heuristic: event script entry or jump target; C0
    script_message $4A6E ; 'You can call me the Medal'
    script_jump_data_bank $7BA9 ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_55EC:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0031
    script_message $4B50 ; '0 found a Magic Key. But'
    script_jump_data_bank $7BA9 ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_55F6:: ; heuristic: event script entry or jump target; C0
    script_message $025F ; 'My granddaughter is painfully shy. She'
    script_message $0260 ; 'I e never seen my granddaughter'
    script_set_flag $012E
    script_end
Script_5600:: ; heuristic: event script entry or jump target; C0
    script_message $48C8 ; 'Wait! Could I get you to'
    script_skip_if_no Script_5609
    script_message $88CA ; 'Fantastic! I can open my shop'
    script_end
Script_5609:: ; heuristic: event script entry or jump target; C0
    script_message $88C9 ; 'Wait! Could I get you to'
    script_command $3D
    script_message $0D40 ; 'What's that? Hey, a TinyMedal! That'
    script_message $0D18 ; 'Here, 0! You need this!'
    script_message $0D42 ; '0 received a TinyMedal!'
    script_set_flag $0134
    script_end
Script_561A:: ; heuristic: event script entry or jump target; C0
    script_message $48C8 ; 'Wait! Could I get you to'
    script_skip_if_no Script_5623
    script_message $88CA ; 'Fantastic! I can open my shop'
    script_end
Script_5623:: ; heuristic: event script entry or jump target; C0
    script_message $88C9 ; 'Wait! Could I get you to'
    script_command $3D
    script_message $0D43 ; 'I'll pray for your safety. Take'
    script_set_flag $01A5
    script_set_flag $0134
    script_end
Script_5631:: ; heuristic: event script entry or jump target; C0
    script_message $48C8 ; 'Wait! Could I get you to'
    script_skip_if_no Script_563A
    script_message $88CA ; 'Fantastic! I can open my shop'
    script_end
Script_563A:: ; heuristic: event script entry or jump target; C0
    script_message $88C9 ; 'Wait! Could I get you to'
    script_command $3D
    script_message $0D40 ; 'What's that? Hey, a TinyMedal! That'
    script_message $0D41 ; 'I like you to have this.'
    script_message $0D42 ; '0 received a TinyMedal!'
    script_set_flag $0134
    script_end
Script_564B:: ; heuristic: event script entry or jump target; C0
Data_010_564B:: ; address name
    script_message $48CB ; 'Oh That's very disappointing. I could'
    script_jump_data_bank Script_6659
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5652:: ; heuristic: event script entry or jump target; C0
    script_message $48CC ; 'ArmyAnt helped me get my shop'
    script_jump_data_bank $6659 ; data bank not known here
    db $FF, $00, $8A, $4D, $E7, $59, $66, $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5660:: ; heuristic: event script entry or jump target; C0
    script_message $4A46 ; 'If you want to make a'
    script_skip_if_no Script_5669
    script_message $8A48 ; 'Then let's breed them!'
    script_end
Script_5669:: ; heuristic: event script entry or jump target; C0
    script_message $CA47 ; 'I'm a traveling merchant. I'm also'
    script_jump_data_bank $7F8B ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5670:: ; heuristic: event script entry or jump target; C0
    script_message $4513 ; 'Kameha Yo, 0. Thanks for coming.'
    script_skip_if_no Script_5679
    script_message $8515 ; 'Well, let's see about breeding!'
    script_end
Script_5679:: ; heuristic: event script entry or jump target; C0
    script_message $C514 ; 'I'm a scientist. I e been'
    script_jump_data_bank $7F8B ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5680:: ; heuristic: event script entry or jump target; C0
    script_message $44B7 ; 'If you eat any BadMeat like'
    script_skip_if_no Script_5689
    script_message $84B9 ; 'Good! Let's get this started!'
    script_end
Script_5689:: ; heuristic: event script entry or jump target; C0
    script_message $C4B8 ; 'Hm? Little one, are you a'
    script_jump_data_bank $7F8B ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5690:: ; heuristic: event script entry or jump target; C0
    script_message $44C8 ; '0 checked the bookshelf. Handbook on'
    script_skip_if_no Script_569C
    script_message $84CA ; 'Have you shown them to the'
    script_set_flag $011D
    script_end
Script_569C:: ; heuristic: event script entry or jump target; C0
    script_message $84C9 ; 'I was once a great master'
    script_end
Script_56A0:: ; heuristic: event script entry or jump target; C0
    script_message $0B4C ; 'Those monsters don't surprise me. Bring'
    script_command $CF
    script_set_flag $002F
    script_end
Script_56A8:: ; heuristic: event script entry or jump target; C0
    script_message $0BBF ; 'Hey, hey, hey! We have to'
    script_command $CF
    script_end
    db $0A, $1F, $01, $00, $97, $42, $E7, $B8, $62, $FF, $00, $98, $42, $E7, $B8, $62
    db $FF, $0A, $13, $01, $00, $1E, $4B, $E7, $B8, $62, $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_56C8:: ; heuristic: event script entry or jump target; C0
    script_message $44BD ; 'I learned how to Massacre! But'
    script_skip_if_no Script_56D1
    script_message $84BF ; 'I like your style! Let's get'
    script_end
Script_56D1:: ; heuristic: event script entry or jump target; C0
    script_message $C4BE ; 'Yo! Up close, you look tougher'
    script_jump_data_bank $7F8B ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_56D8:: ; heuristic: event script entry or jump target; C0
    script_message $4277 ; 'If you want to enter, please'
    script_skip_if_no Script_56E1
    script_message $8279 ; 'Your party may enter in battles'
    script_end
Script_56E1:: ; heuristic: event script entry or jump target; C0
    script_message $8278 ; 'Welcome to the Arena! Would you'
    script_end
Script_56E5:: ; heuristic: event script entry or jump target; C0
    script_message $4277 ; 'If you want to enter, please'
    script_skip_if_no Script_56EE
    script_message $8B66 ; 'As a pro master, you can'
    script_end
Script_56EE:: ; heuristic: event script entry or jump target; C0
    script_message $8B65 ; 'As a pro master, you can'
    script_end
    db $0D, $1A, $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_56F5:: ; heuristic: event script entry or jump target; C0
    script_op $01, $02, $03, $02
    script_op $05, $00, $01
    script_message $0546 ; 'You're today's guest of honor! You'
    script_op $03, $3C, $00
    script_sound $28
    script_message $0547 ; 'Cobi 0, congratulations! I thought we'
    script_command $5F
    script_end
Script_5709:: ; heuristic: event script entry or jump target; C0
    script_op $01, $02, $03, $02
    script_op $05, $00, $01
    script_message $054A ; 'Warubou No one knows how many'
    script_op $03, $3C, $00
    script_sound $28
    script_message $0547 ; 'Cobi 0, congratulations! I thought we'
    script_command $5F
    script_end
    INCBIN "dwm2-cobi-us.gbc", $04171D, $85

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_57A2:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0138
    script_op $03, $1E, $00
    script_command $7A
    script_op $02, $00, $00, $05
    script_message $4A36 ; 'I'm a bug, so I'm not'
    script_skip_if_no Script_57BD
    script_message $8A38 ; 'What's that? You saw Prince Kameha'
    script_op $02, $00, $02, $05
    script_op $05, $80, $00
    script_end
Script_57BD:: ; heuristic: event script entry or jump target; C0
    script_message $8A37 ; 'Prince Kameha has been missing from'
    script_set_flag $0117
    script_command $59
    script_message $0A3A ; 'The man here has rare keys.'
    script_message $0A3B ; 'Sire, this child claims to know'
    script_op $01, $00, $00, $01
    script_message $0D28 ; '0 checked the treasure chest. The'
    script_op $01, $00, $02, $01
    script_op $05, $80, $00
    script_message $0D29 ; '0 obtained the Sky Key.'
    script_end
Script_57DC:: ; heuristic: event script entry or jump target; C0
    script_op $05, $00, $03
    script_command $61
    script_end
Script_57E1:: ; heuristic: event script entry or jump target; C0
    script_command $62
    script_end
    db $00, $60, $0D, $78, $FF, $00, $61, $0D, $78, $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_57ED:: ; heuristic: event script entry or jump target; C0
Data_010_57ED:: ; address name
    script_set_flag $012C
    script_message $4B16 ; 'When master's shop starts making money,'
    script_jump_data_bank Script_6707
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_57F7:: ; heuristic: event script entry or jump target; C0
    script_message $4B17 ; 'I'm sorry. I was wrong about'
    script_jump_data_bank Script_6707
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_57FE:: ; heuristic: event script entry or jump target; C0
    script_message $4B21 ; 'Oh, the savior of GreatLog. I'm'
    script_skip_if_no Script_5807
    script_message $8B24 ; 'Oh? But there's no room for'
    script_end
Script_5807:: ; heuristic: event script entry or jump target; C0
    script_message $8B23 ; 'You'll take it? Excellent! I'll send'
    script_end
Script_580B:: ; heuristic: event script entry or jump target; C0
    script_message $4B21 ; 'Oh, the savior of GreatLog. I'm'
    script_skip_if_no Script_5814
    script_message $8B24 ; 'Oh? But there's no room for'
    script_end
Script_5814:: ; heuristic: event script entry or jump target; C0
    script_message $8B22 ; 'Hello, hero! Let me help you!'
    script_command $6C
    script_set_flag $0029
    script_end
Script_581C:: ; heuristic: event script entry or jump target; C0
    script_message $4B53 ; 'Ah, the savior of GreatLog! You're'
    script_skip_if_no Script_5825
    script_message $8B55 ; 'Great! Let's give it a try!'
    script_end
Script_5825:: ; heuristic: event script entry or jump target; C0
    script_message $CB54 ; 'Didn't you save GreatLog? That is'
    script_jump_data_bank $7F8B ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_582C:: ; heuristic: event script entry or jump target; C0
    script_message $4B57 ; 'When you breed monsters with another'
    script_skip_if_no Script_5835
    script_message $8B59 ; 'May good fortune arrive quickly. Please,'
    script_end
Script_5835:: ; heuristic: event script entry or jump target; C0
    script_message $CB58 ; 'Ah, you must be the little'
    script_jump_data_bank $7F8B ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_583C:: ; heuristic: event script entry or jump target; C0
    script_message $4B5B ; 'Generations of breeding passes on skills'
    script_skip_if_no Script_5845
    script_message $8B5D ; 'Well, no time to lose! Quick!'
    script_end
Script_5845:: ; heuristic: event script entry or jump target; C0
    script_message $CB5C ; 'I didn't think GreatLog's hero could'
    script_jump_data_bank $7F8B ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_584C:: ; heuristic: event script entry or jump target; C0
    script_message $4B6A ; 'When you're at the pro level,'
    script_skip_if_no Script_5855
    script_message $8B6C ; 'OK! Let the breeding happen!'
    script_end
Script_5855:: ; heuristic: event script entry or jump target; C0
    script_message $CB6B ; 'Are you perhaps GreatLog's savior? Hey,'
    script_jump_data_bank $7F8B ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_585C:: ; heuristic: event script entry or jump target; C0
    script_message $4B70 ; 'As I level up, my FrigidAir'
    script_skip_if_no Script_5865
    script_message $8B72 ; 'Great! Good answer!'
    script_end
Script_5865:: ; heuristic: event script entry or jump target; C0
    script_message $CB71 ; 'Hey! You're still at it, youngster?'
    script_jump_data_bank $7F8B ; data bank not known here
    db $FF, $00, $C3, $0B, $6F, $00, $4E, $0B, $0A, $3D, $00, $FF, $00, $C3, $0B, $6F
    db $00, $B5, $0B, $0A, $3D, $00, $FF, $00, $C3, $0B, $6F, $00, $B7, $0B, $0A, $C8
    db $00, $FF, $00, $C3, $0B, $6F, $00, $C0, $0B, $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5895:: ; heuristic: event script entry or jump target; C0
    script_sound $60
    script_command $70
    script_end
Script_5899:: ; heuristic: event script entry or jump target; C0
    script_message $4BAD ; 'You need to strike the right'
    script_skip_if_no Script_58A2
    script_message $8BAF ; 'Terry Humph Confident, huh? I'll tell'
    script_end
Script_58A2:: ; heuristic: event script entry or jump target; C0
    script_message $8BAE ; 'Humph I'm Terry. I'm a master'
    script_command $7C
    script_end
    db $00, $B0, $4B, $06, $04, $00, $AF, $8B, $FF, $00, $AE, $8B, $7C, $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_58B5:: ; heuristic: event script entry or jump target; C0
    script_message $4B8F ; 'It would be our Kingdom's shame'
    script_skip_if_no Script_58BE
    script_message $8B91 ; 'Kameha So you're confident, huh? Let's'
    script_end
Script_58BE:: ; heuristic: event script entry or jump target; C0
    script_message $8B90 ; 'i 't z ! S V'
    script_command $71
    script_end
Script_58C3:: ; heuristic: event script entry or jump target; C0
    script_message $0B95 ; 'Kameha Well, uh, luck and status'
    script_message $0B93 ; 'Kameha Well, uh, luck and status'
    script_set_flag $003A
    script_end
Script_58CD:: ; heuristic: event script entry or jump target; C0
    script_message $0B95 ; 'Kameha Well, uh, luck and status'
    script_message $0BC2 ; 'But there was nothing there.'
    script_set_flag $003A
    script_end
    db $00, $95, $0B, $00, $9A, $0B, $0A, $3A, $00, $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_58E1:: ; heuristic: event script entry or jump target; C0
    script_message $4B8F ; 'It would be our Kingdom's shame'
    script_skip_if_no Script_58EA
    script_message $8B91 ; 'Kameha So you're confident, huh? Let's'
    script_end
Script_58EA:: ; heuristic: event script entry or jump target; C0
    script_message $8B90 ; 'i 't z ! S V'
    script_command $72
    script_end
Script_58EF:: ; heuristic: event script entry or jump target; C0
    script_message $0B95 ; 'Kameha Well, uh, luck and status'
    script_message $0B9D ; 'Kameha That was a good warmup!'
    script_set_flag $003C
    script_end
Script_58F9:: ; heuristic: event script entry or jump target; C0
    script_message $0B95 ; 'Kameha Well, uh, luck and status'
    script_message $0BC2 ; 'But there was nothing there.'
    script_set_flag $003C
    script_end
Script_5903:: ; heuristic: event script entry or jump target; C0
    script_message $4B7C ; 'King Oh? It's our savior 0!'
    script_skip_if_no Script_590C
    script_message $8B7E ; 'King You will? I knew I'
    script_end
Script_590C:: ; heuristic: event script entry or jump target; C0
    script_message $8B7D ; 'King Oh? It's our savior 0!'
    script_set_flag $0192
    script_end
Script_5913:: ; heuristic: event script entry or jump target; C0
    script_message $0B80 ; 'King There is an evil master'
    script_message $0B81 ; 'King Ah, you e finally caught'
    script_set_flag $0194
    script_end
Script_591D:: ; heuristic: event script entry or jump target; C0
    script_message $4B83 ; 'King I was right to trust'
    script_skip_if_no Script_5926
    script_message $8B7E ; 'King You will? I knew I'
    script_end
Script_5926:: ; heuristic: event script entry or jump target; C0
    script_message $8B84 ; 'King Oh? It's our savior 0!'
    script_set_flag $0195
    script_end
Script_592D:: ; heuristic: event script entry or jump target; C0
    script_message $0B80 ; 'King There is an evil master'
    script_message $0B86 ; 'King There is an evil master'
    script_set_flag $0197
    script_end
Script_5937:: ; heuristic: event script entry or jump target; C0
    script_message $4B83 ; 'King I was right to trust'
    script_skip_if_no Script_5940
    script_message $8B7E ; 'King You will? I knew I'
    script_end
Script_5940:: ; heuristic: event script entry or jump target; C0
    script_message $8B87 ; '0 received 20,000G.'
    script_set_flag $0198
    script_end
Script_5947:: ; heuristic: event script entry or jump target; C0
    script_message $0B80 ; 'King There is an evil master'
    script_message $0B89 ; 'King There is an evil master'
    script_set_flag $019A
    script_end
Script_5951:: ; heuristic: event script entry or jump target; C0
    script_message $4B83 ; 'King I was right to trust'
    script_skip_if_no Script_595A
    script_message $8B7E ; 'King You will? I knew I'
    script_end
Script_595A:: ; heuristic: event script entry or jump target; C0
    script_message $8B8A ; '0 received 30,000G.'
    script_set_flag $019B
    script_end
Script_5961:: ; heuristic: event script entry or jump target; C0
    script_message $0B80 ; 'King There is an evil master'
    script_message $0B8C ; 'King There is an evil master'
    script_set_flag $019D
    script_end
Script_596B:: ; heuristic: event script entry or jump target; C0
    script_set_flag $012A
    script_message $41D0 ; 'This is a great spot to'
    script_skip_if_no Script_5977
    script_message $81D2 ; 'Put the Dream Egg on the'
    script_end
Script_5977:: ; heuristic: event script entry or jump target; C0
    script_message $81D1 ; 'This is a great spot to'
    script_end
Script_597B:: ; heuristic: event script entry or jump target; C0
    script_message $41D3 ; 'This talk is too early for'
    script_skip_if_no Script_5984
    script_message $81D2 ; 'Put the Dream Egg on the'
    script_end
Script_5984:: ; heuristic: event script entry or jump target; C0
    script_message $81D1 ; 'This is a great spot to'
    script_end
Script_5988:: ; heuristic: event script entry or jump target; C0
    script_op $01, $02, $01, $06
    script_op $05, $00, $03
    script_message $01D4 ; 'Have you ever found a Dream'
    script_op $0B, $82
    script_message $0DDE ; 'm d Z S B V'
    script_op $01, $02, $03, $06
    script_set_flag $0187
    script_end
Script_599F:: ; heuristic: event script entry or jump target; C0
    script_message $0D49 ; 'Here, 0! You hold onto it.'
    script_message $0D41 ; 'I like you to have this.'
    script_set_flag $01A4
    script_end
    db $00, $44, $0D, $00, $41, $0D, $0A, $A6, $01, $FF, $00, $FA, $40, $E7, $59, $66
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_59BA:: ; heuristic: event script entry or jump target; C0
    script_message $41BB ; 'Tch, I think I can help'
    script_jump_data_bank $690B ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_59C1:: ; heuristic: event script entry or jump target; C0
Data_010_59C1:: ; address name
    script_message $4144 ; 'When we get a hot spell,'
    script_jump_data_bank Script_6707
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_59C8:: ; heuristic: event script entry or jump target; C0
    script_message $4145 ; 'Welcome to my item shop! You'
    script_jump_data_bank $6707 ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_59CF:: ; heuristic: event script entry or jump target; C0
    script_message $4146 ; 'Hello! How may I serve you'
    script_jump_data_bank Script_1F_77D4
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_59D6:: ; heuristic: event script entry or jump target; C0
    script_message $4147 ; 'The church welcomes you. We can'
    script_jump_data_bank $77D4 ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_59DD:: ; heuristic: event script entry or jump target; C0
    script_message $4148 ; 'I am a servant to the'
    script_skip_if_no Script_59E6
    script_message $814C ; 'Did you say yes? Yes, yes,'
    script_end
Script_59E6:: ; heuristic: event script entry or jump target; C0
    script_message $8149 ; 'I am the leader of a'
    script_set_flag $0042
    script_command $1F
    script_op $05, $83, $02
    script_message $0153 ; 'Next, monsters will perform some amazing,'
    script_set_flag $0043
    script_end
Script_59F7:: ; heuristic: event script entry or jump target; C0
    script_message $4148 ; 'I am a servant to the'
    script_skip_if_no Script_5A00
    script_message $814C ; 'Did you say yes? Yes, yes,'
    script_end
Script_5A00:: ; heuristic: event script entry or jump target; C0
    script_message $814B ; 'Did you say yes? Yes, yes,'
    script_set_flag $0042
    script_end
Script_5A07:: ; heuristic: event script entry or jump target; C0
    script_message $4148 ; 'I am a servant to the'
    script_skip_if_no Script_5A10
    script_message $814C ; 'Did you say yes? Yes, yes,'
    script_end
Script_5A10:: ; heuristic: event script entry or jump target; C0
    script_message $814A ; 'Did you say yes? Yes, yes,'
    script_set_flag $0042
    script_end
Script_5A17:: ; heuristic: event script entry or jump target; C0
    script_message $014D ; 'You close the door to stardom?'
    script_command $1F
    script_op $05, $83, $02
    script_message $0153 ; 'Next, monsters will perform some amazing,'
    script_set_flag $0043
    script_end
Script_5A25:: ; heuristic: event script entry or jump target; C0
    script_message $41BB ; 'Tch, I think I can help'
    script_jump_data_bank $690B ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5A2C:: ; heuristic: event script entry or jump target; C0
    script_message $4160 ; '0 checked the dresser. There were'
    script_skip_if_no Script_5A35
    script_message $8D01 ; 'They say you use Magic Keys'
    script_end
Script_5A35:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0044
    script_message $8D02 ; 'King Then, you are excused. I'm'
    script_command $21
    script_message $4161 ; 'King Ah, you're the monster tamer'
    script_skip_if_no Script_5A45
    script_message $8163 ; 'King Then make way to the'
    script_end
Script_5A45:: ; heuristic: event script entry or jump target; C0
    script_message $8162 ; 'King I see. This is what'
    script_set_flag $0045
    script_end
Script_5A4C:: ; heuristic: event script entry or jump target; C0
    script_message $4165 ; 'King Investigate what concerns my people'
    script_skip_if_no Script_5A55
    script_message $8163 ; 'King Then make way to the'
    script_end
Script_5A55:: ; heuristic: event script entry or jump target; C0
    script_message $8162 ; 'King I see. This is what'
    script_set_flag $0045
    script_end
Script_5A5C:: ; heuristic: event script entry or jump target; C0
    script_message $016C ; 'The King is so frivolous. A'
    script_op $02, $00, $02, $04
    script_op $01, $01, $01, $01
    script_op $01, $01, $00, $04
    script_message $016D ; 'So, have you discovered what concerns'
    script_op $0B, $80
    script_message $016E ; 'King The canal is managed by'
    script_op $02, $01, $03, $01
    script_op $02, $01, $01, $02
    script_op $02, $01, $03, $02
    script_op $02, $01, $01, $01
    script_op $05, $81, $00
    script_message $016F ; 'Your Majesty, I must remind you'
    script_op $02, $01, $03, $01
    script_op $02, $01, $00, $05
    script_set_flag $0049
    script_end
Script_5A95:: ; heuristic: event script entry or jump target; C0
    script_message $0171 ; 'I feel badly for his Majesty,'
    script_command $22
    script_op $03, $1E, $00
    script_op $02, $00, $02, $02
    script_op $02, $00, $03, $01
    script_op $02, $00, $02, $01
    script_op $0C, $00
    script_end
Script_5AAB:: ; heuristic: event script entry or jump target; C0
    script_message $0175 ; 'I discovered why the water is'
    script_op $0D, $16
    script_message $0176 ; 'I'm making a new home for'
    script_op $05, $80, $02
    script_op $0B, $80
    script_message $0177 ; 'Gaah! You're too strong! You win!'
    script_op $05, $81, $00
    script_message $0178 ; 'King What? So that's the truth?'
    script_op $0C, $01
    script_set_flag $0053
    script_command $25
    script_set_flag $0054
    script_message $0179 ; 'You will? So we can go'
    script_op $01, $00, $00, $03
    script_end
Script_5AD2:: ; heuristic: event script entry or jump target; C0
    script_command $4D
    script_end
    db $4D, $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5AD6:: ; heuristic: event script entry or jump target; C0
    script_message $0181 ; 'The King appears to have turned'
    script_set_flag $0055
    script_op $01, $01, $00, $08
    script_command $23
    script_op $02, $00, $01, $03
    script_op $05, $80, $02
    script_message $0182 ; 'King The town's water shortage seems'
    script_op $05, $81, $00
    script_message $0183 ; 'King Wha-what? What happened?'
    script_op $0B, $80
    script_message $0184 ; 'We We were jumped by thieves'
    script_command $24
    script_op $01, $00, $00, $01
    script_op $01, $00, $01, $01
    script_op $05, $00, $03
    script_message $0187 ; 'King Good! Your valor be praised!'
    script_op $01, $00, $00, $08
    script_set_flag $0056
    script_end
Script_5B0D:: ; heuristic: event script entry or jump target; C0
    script_message $4188 ; 'King I apologize, but my treasures'
    script_skip_if_no Script_5B16
    script_message $818D ; '0 had no food to give'
    script_end
Script_5B16:: ; heuristic: event script entry or jump target; C0
    script_message $818C ; '0 received a WaterCall.'
    script_message $018D ; '0 had no food to give'
    script_end
Script_5B1D:: ; heuristic: event script entry or jump target; C0
    script_message $4188 ; 'King I apologize, but my treasures'
    script_skip_if_no Script_5B26
    script_message $818D ; '0 had no food to give'
    script_end
Script_5B26:: ; heuristic: event script entry or jump target; C0
    script_message $8189 ; 'Wh-where is everybody? I haven't been'
    script_message $018A ; '0 handed over some food.'
    script_message $018B ; 'Munch, munch Chew, gulp Fwoaar, that'
    script_message $0D03 ; 'King You wish to see our'
    script_command $1E
    script_set_flag $0057
    script_end
Script_5B37:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0058
    script_command $26
    script_end
Script_5B3C:: ; heuristic: event script entry or jump target; C0
    script_message $0196 ; 'The leader of the thieves is'
    script_set_flag $0059
    script_op $0D, $00
    script_message $0198 ; 'You again! You're determined! But it'
    script_command $27
    script_end
Script_5B49:: ; heuristic: event script entry or jump target; C0
    script_message $0197 ; 'Heh, you have monsters in tow?'
    script_op $0D, $00
    script_message $0198 ; 'You again! You're determined! But it'
    script_command $27
    script_end
Script_5B53:: ; heuristic: event script entry or jump target; C0
    script_sound $60
    script_command $63
    script_end
Script_5B57:: ; heuristic: event script entry or jump target; C0
    script_message $415C ; 'We frown upon strangers who wander'
    script_skip_if_no Script_5B60
    script_message $815E ; 'A new plug for the Log's'
    script_end
Script_5B60:: ; heuristic: event script entry or jump target; C0
    script_message $815D ; 'Why are you snooping around? Are'
    script_end
Script_5B64:: ; heuristic: event script entry or jump target; C0
    script_message $4D04 ; 'That will help you for certain.'
    script_skip_if_no Script_5B6D
    script_message $8D06 ; 'Oh. That's nice. Good for you.'
    script_end
Script_5B6D:: ; heuristic: event script entry or jump target; C0
    script_message $8D05 ; 'Hello, have you found a plug'
    script_end
Script_5B71:: ; heuristic: event script entry or jump target; C0
    script_op $03, $14, $00
    script_command $79
    script_end
Script_5B76:: ; heuristic: event script entry or jump target; C0
    script_message $4DA0 ; 'Our church is impoverished, so I'
    script_jump_data_bank Script_1F_77D4
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5B7D:: ; heuristic: event script entry or jump target; C0
    script_message $4147 ; 'The church welcomes you. We can'
    script_jump_data_bank $77D4 ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5B84:: ; heuristic: event script entry or jump target; C0
    script_message $0806 ; 'Mermaids lived in the sea in'
    script_command $28
    script_message $0807 ; 'The birds are noisy It's a'
    script_end
Script_5B8C:: ; heuristic: event script entry or jump target; C0
Data_010_5B8C:: ; address name
    script_message $4809 ; 'I hope the volcanic island off'
    script_jump_data_bank Script_6707
    db $FF, $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5B94:: ; heuristic: event script entry or jump target; C0
    script_message $41BB ; 'Tch, I think I can help'
    script_jump_data_bank $690B ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5B9B:: ; heuristic: event script entry or jump target; C0
    script_message $4818 ; 'Ah Shame Please come again.'
    script_skip_if_no Script_5BA4
    script_message $881A ; 'Ah, you e heard already. It's'
    script_end
Script_5BA4:: ; heuristic: event script entry or jump target; C0
    script_message $8819 ; 'Have you heard the legend about'
    script_end
Script_5BA8:: ; heuristic: event script entry or jump target; C0
    script_message $4820 ; 'There's this old sailor man in'
    script_jump_data_bank Script_1F_77D4
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5BAF:: ; heuristic: event script entry or jump target; C0
Data_010_5BAF:: ; address name
    script_message $4823 ; 'I went to Polona a while'
    script_jump_data_bank Script_6707
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5BB6:: ; heuristic: event script entry or jump target; C0
    script_message $082C ; 'Listen, did you know? Mermaids appear'
    script_message $082D ; '0 tried to check the chest.'
    script_end
Script_5BBD:: ; heuristic: event script entry or jump target; C0
    script_message $41BB ; 'Tch, I think I can help'
    script_jump_data_bank $690B ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5BC4:: ; heuristic: event script entry or jump target; C0
    script_sound $28
    script_op $03, $8C, $00
    script_command $29
    script_op $01, $00, $01, $01
    script_op $01, $00, $00, $03
    script_op $02, $01, $01, $01
    script_op $02, $01, $00, $07
    script_op $02, $02, $03, $01
    script_op $02, $02, $00, $07
    script_op $03, $1E, $00
    script_sound $FF
    script_end
Script_5BE8:: ; heuristic: event script entry or jump target; C0
    script_message $0838 ; 'Hnnnr Hic Gnn Zzz Gfffff'
    script_op $0D, $01
    script_command $2A
    script_set_flag $0066
    script_end
Script_5BF2:: ; heuristic: event script entry or jump target; C0
    script_message $0839 ; 'Who are you? This is our'
    script_op $0D, $01
    script_command $2A
    script_set_flag $0066
    script_end
Script_5BFC:: ; heuristic: event script entry or jump target; C0
    script_command $2A
    script_end
Script_5BFE:: ; heuristic: event script entry or jump target; C0
    script_message $083A ; 'You can keep trying, but you're'
    script_op $0B, $83
    script_message $483B ; 'Zzz Zzz Huh! Watch out!'
    script_skip_if_no Script_5C0C
    script_message $883E ; 'The pirates loot is probably still'
    script_end
Script_5C0C:: ; heuristic: event script entry or jump target; C0
    script_message $883C ; 'What! Why are you with monsters?'
    script_op $03, $78, $00
    script_message $083D ; 'It was in my callow youth'
    script_set_flag $006D
    script_end
Script_5C19:: ; heuristic: event script entry or jump target; C0
    script_message $483F ; 'It's a tale of high adventure'
    script_skip_if_no Script_5C22
    script_message $8841 ; 'The pirates stole the MoonRock from'
    script_end
Script_5C22:: ; heuristic: event script entry or jump target; C0
    script_message $8840 ; 'What? Are you here for my'
    script_end
Script_5C26:: ; heuristic: event script entry or jump target; C0
    script_message $083A ; 'You can keep trying, but you're'
    script_op $0B, $83
    script_message $0DC4 ; 'The shoals that ringed the volcano'
    script_end
Script_5C2F:: ; heuristic: event script entry or jump target; C0
    script_message $4810 ; 'You're not supposed to go near'
    script_skip_if_no Script_5C38
    script_message $8817 ; 'Erm The sense of rhythm just'
    script_end
Script_5C38:: ; heuristic: event script entry or jump target; C0
    script_message $8811 ; 'In the past, mermaids are said'
    script_command $2C
    script_message $0816 ; 'Bravo, bravo! You were fabulous! You'
    script_end
Script_5C40:: ; heuristic: event script entry or jump target; C0
    script_message $4810 ; 'You're not supposed to go near'
    script_skip_if_no Script_5C49
    script_message $8817 ; 'Erm The sense of rhythm just'
    script_end
Script_5C49:: ; heuristic: event script entry or jump target; C0
    script_message $8811 ; 'In the past, mermaids are said'
    script_command $2B
    script_end
Script_5C4E:: ; heuristic: event script entry or jump target; C0
    script_message $4810 ; 'You're not supposed to go near'
    script_skip_if_no Script_5C57
    script_message $8817 ; 'Erm The sense of rhythm just'
    script_end
Script_5C57:: ; heuristic: event script entry or jump target; C0
    script_message $8811 ; 'In the past, mermaids are said'
    script_command $2D
    script_end
Script_5C5C:: ; heuristic: event script entry or jump target; C0
    script_message $4810 ; 'You're not supposed to go near'
    script_skip_if_no Script_5C65
    script_message $8817 ; 'Erm The sense of rhythm just'
    script_end
Script_5C65:: ; heuristic: event script entry or jump target; C0
    script_message $8892 ; 'Kameha Aiyeeeeeh'
    script_end
Script_5C69:: ; heuristic: event script entry or jump target; C0
    script_message $484B ; 'I'm astonished. Mermaids exist.'
    script_skip_if_no Script_5C72
    script_message $884D ; 'Close your eyes a little while.'
    script_end
Script_5C72:: ; heuristic: event script entry or jump target; C0
    script_message $884C ; 'Do you want to go to'
    script_command $2E
    script_end
Script_5C77:: ; heuristic: event script entry or jump target; C0
    script_message $0855 ; 'We mermaids are peaceful beings. We'
    script_set_flag $0070
    script_end
Script_5C7E:: ; heuristic: event script entry or jump target; C0
    script_message $0DC5 ; 'What is it? Ah, it's you.'
    script_message $0DC6 ; 'Welcome, my young hero! No words'
    script_set_flag $005E
    script_end
Script_5C88:: ; heuristic: event script entry or jump target; C0
    script_command $30
    script_end
Script_5C8A:: ; heuristic: event script entry or jump target; C0
    script_message $0859 ; 'The MoonRock is on the ghost'
    script_op $0D, $17
    script_set_flag $0071
    script_command $31
    script_end
Script_5C94:: ; heuristic: event script entry or jump target; C0
    script_message $085A ; 'How could we die before enjoying'
    script_op $0D, $17
    script_set_flag $0072
    script_command $31
    script_end
Script_5C9E:: ; heuristic: event script entry or jump target; C0
    script_message $085C ; 'This is what became of us'
    script_op $0D, $17
    script_set_flag $0073
    script_command $31
    script_end
Script_5CA8:: ; heuristic: event script entry or jump target; C0
    script_message $085E ; 'Check the wooden crate'
    script_op $0D, $02
    script_message $0860 ; 'You seem to not understand The'
    script_command $32
    script_set_flag $0075
    script_end
Script_5CB5:: ; heuristic: event script entry or jump target; C0
    script_message $085F ; 'Who disturbs us in our sleep'
    script_op $0D, $02
    script_message $0860 ; 'You seem to not understand The'
    script_command $32
    script_set_flag $0075
    script_end
Script_5CC2:: ; heuristic: event script entry or jump target; C0
    script_message $0887 ; '? t I e . A'
    script_command $33
    script_set_flag $0076
    script_end
Script_5CCA:: ; heuristic: event script entry or jump target; C0
    script_message $0863 ; '0 peered into the barrel. There'
    script_command $34
    script_end
Script_5CCF:: ; heuristic: event script entry or jump target; C0
    script_command $35
    script_end
Script_5CD1:: ; heuristic: event script entry or jump target; C0
    script_sound $28
    script_message $0868 ; '0 checked the pedestal. The MoonRock'
    script_command $36
    script_op $03, $1E, $00
    script_sound $FF
    script_end
Script_5CDD:: ; heuristic: event script entry or jump target; C0
    script_sound $28
    script_op $0B, $80
    script_message $0869 ; 'Kameha Wahahahah! Thanks for guiding me'
    script_op $05, $80, $01
    script_op $02, $01, $03, $03
    script_op $02, $01, $02, $01
    script_op $05, $81, $01
    script_op $02, $02, $03, $03
    script_op $02, $02, $00, $03
    script_op $05, $82, $01
    script_message $086A ; 'Kameha Urk! How you catch up?'
    script_command $37
    script_sound $65
    script_op $0C, $00
    script_op $03, $0F, $00
    script_sound $65
    script_op $0C, $01
    script_op $03, $0F, $00
    script_sound $65
    script_op $0C, $02
    script_set_flag $007C
    script_op $03, $5A, $00
    script_sound $FF
    script_end
Script_5D1C:: ; heuristic: event script entry or jump target; C0
    script_sound $28
    script_message $086B ; 'Aye, aye, sir! Right behind you!'
    script_command $38
    script_sound $00
    script_message $0891 ; 'Oh. Tell me if you want'
    script_sound $65
    script_op $03, $5A, $00
    script_sound $FF
    script_end
Script_5D2F:: ; heuristic: event script entry or jump target; C0
    script_op $03, $8C, $00
    script_command $39
    script_sound $FF
    script_end
Script_5D36:: ; heuristic: event script entry or jump target; C0
    script_message $488E ; '0 peered into the oven. Two'
    script_skip_if_no Script_5D3F
    script_message $8890 ; 'Close your eyes for a little'
    script_end
Script_5D3F:: ; heuristic: event script entry or jump target; C0
    script_message $888F ; 'This is the mermaid kingdom. Did'
    script_command $2F
    script_end
Script_5D44:: ; heuristic: event script entry or jump target; C0
    script_message $0893 ; 'Your monsters appear dispirited It's unfortunate,'
    script_op $0D, $1E
    script_set_flag $00F4
    script_end
Script_5D4D:: ; heuristic: event script entry or jump target; C0
    script_message $4DA1 ; 'Our church is impoverished, so I'
    script_jump_data_bank Script_1F_77D4
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5D54:: ; heuristic: event script entry or jump target; C0
    script_message $4147 ; 'The church welcomes you. We can'
    script_jump_data_bank $77D4 ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5D5B:: ; heuristic: event script entry or jump target; C0
    script_message $4308 ; 'The spring in the north, where'
    script_skip_if_no Script_5D64
    script_message $830A ; 'A long time ago the spirit'
    script_end
Script_5D64:: ; heuristic: event script entry or jump target; C0
    script_message $8309 ; 'Have you heard about the spirit'
    script_end
Script_5D68:: ; heuristic: event script entry or jump target; C0
Data_010_5D68:: ; address name
    script_message $4310 ; 'The mine on the western border'
    script_jump_data_bank Script_6707
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5D6F:: ; heuristic: event script entry or jump target; C0
    script_message $41BB ; 'Tch, I think I can help'
    script_jump_data_bank $690B ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5D76:: ; heuristic: event script entry or jump target; C0
    script_message $0316 ; 'The border is closed, so I'
    script_message $4317 ; '0 checked the shield. A beautiful'
    script_skip_if_no Script_5D82
    script_message $831A ; '0 checked the treasure chest. 0'
    script_end
Script_5D82:: ; heuristic: event script entry or jump target; C0
    script_message $8318 ; 'I am surprised that you hear'
    script_command $3F
    script_set_flag $01E8
    script_end
Script_5D8A:: ; heuristic: event script entry or jump target; C0
    script_message $031C ; 'If you restore this world's peace,'
    script_op $01, $00, $02, $01
    script_op $0C, $00
    script_set_flag $0081
    script_end
Script_5D97:: ; heuristic: event script entry or jump target; C0
    script_message $0321 ; 'I remember the King to be'
    script_set_flag $0083
    script_command $40
    script_op $01, $01, $00, $02
    script_set_flag $0082
    script_end
Script_5DA6:: ; heuristic: event script entry or jump target; C0
    script_message $0359 ; 'I e heard from friends who'
    script_command $42
    script_sound $28
    script_set_flag $0087
    script_end
Script_5DB0:: ; heuristic: event script entry or jump target; C0
Data_010_5DB0:: ; address name
    script_message $4331 ; 'Don't you think it's too expensive?'
    script_jump_data_bank Script_6659
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5DB7:: ; heuristic: event script entry or jump target; C0
Data_010_5DB7:: ; address name
    script_message $4332 ; 'Welcome! What can I do for'
    script_jump_data_bank Script_6707
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5DBE:: ; heuristic: event script entry or jump target; C0
Data_010_5DBE:: ; address name
    script_message $4333 ; 'Greetings! How shall I serve you?'
    script_jump_data_bank Script_6707
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5DC5:: ; heuristic: event script entry or jump target; C0
    script_message $41BB ; 'Tch, I think I can help'
    script_jump_data_bank $690B ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5DCC:: ; heuristic: event script entry or jump target; C0
    script_message $4820 ; 'There's this old sailor man in'
    script_jump_data_bank Script_1F_77D4
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5DD3:: ; heuristic: event script entry or jump target; C0
    script_sound $65
    script_command $41
    script_op $02, $01, $03, $04
    script_op $02, $02, $01, $03
    script_op $0B, $81
    script_message $0349 ; 'Darn! Take this! SACRIFICE!'
    script_op $0B, $82
    script_message $034A ; 'What? What was that explosion?'
    script_op $0B, $81
    script_message $034B ; 'That dust there Is that the'
    script_op $0B, $82
    script_message $034C ; 'What? That's all that there was?'
    script_op $02, $02, $03, $03
    script_message $034D ; 'We better get word to the'
    script_op $02, $01, $01, $04
    script_command $7E
    script_set_flag $0086
    script_end
Script_5E02:: ; heuristic: event script entry or jump target; C0
    script_command $41
    script_op $02, $01, $03, $04
    script_op $02, $02, $01, $03
    script_op $0B, $81
    script_message $0349 ; 'Darn! Take this! SACRIFICE!'
    script_op $0B, $82
    script_message $034A ; 'What? What was that explosion?'
    script_op $0B, $81
    script_message $034B ; 'That dust there Is that the'
    script_op $0B, $82
    script_message $034C ; 'What? That's all that there was?'
    script_op $02, $02, $03, $03
    script_message $034D ; 'We better get word to the'
    script_op $02, $01, $01, $04
    script_command $7E
    script_set_flag $0086
    script_end
Script_5E2F:: ; heuristic: event script entry or jump target; C0
    script_message $0360 ; 'Kameha Where's the exit? We'll starve'
    script_op $05, $81, $02
    script_command $43
    script_end
Script_5E37:: ; heuristic: event script entry or jump target; C0
    script_message $0363 ; 'Kameha 0 That wasn't it'
    script_op $05, $81, $02
    script_command $43
    script_message $0364 ; '0 tapped on the wall. Sound'
    script_op $02, $01, $02, $03
    script_op $0C, $01
    script_op $03, $1E, $00
    script_set_flag $008A
    script_sound $FF
    script_op $02, $00, $03, $04
    script_op $02, $00, $02, $05
    script_op $0C, $00
    script_end
Script_5E5A:: ; heuristic: event script entry or jump target; C0
    script_command $44
    script_message $0365 ; 'Kameha That's it! That's the exit!'
    script_op $0B, $81
    script_message $0366 ; 'I'm the real King, you fake!'
    script_set_flag $008B
    script_end
Script_5E67:: ; heuristic: event script entry or jump target; C0
    script_message $0370 ; 'You suspect me still? Kiki! Gaaah!'
    script_command $45
    script_op $05, $81, $02
    script_op $0B, $81
    script_message $0374 ; 'Awaaargh! A m-m-monster! A monster was'
    script_set_flag $0094
    script_end
Script_5E77:: ; heuristic: event script entry or jump target; C0
    script_message $0372 ; 'The mirror shows a monster.'
    script_command $45
    script_op $05, $81, $02
    script_op $0B, $81
    script_message $0374 ; 'Awaaargh! A m-m-monster! A monster was'
    script_set_flag $0094
    script_end
Script_5E87:: ; heuristic: event script entry or jump target; C0
    script_message $41BB ; 'Tch, I think I can help'
    script_jump_data_bank $690B ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5E8E:: ; heuristic: event script entry or jump target; C0
Data_010_5E8E:: ; address name
    script_message $438B ; 'A woodsman came by a while'
    script_jump_data_bank Script_6707
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5E95:: ; heuristic: event script entry or jump target; C0
    script_message $0394 ; 'Oh Lady Yuna To think that'
    script_sound $28
    script_command $64
    script_op $03, $5A, $00
    script_op $02, $03, $02, $04
    script_op $05, $83, $01
    script_message $0395 ; '0 read the sign. Come all'
    script_op $01, $03, $00, $01
    script_op $05, $83, $02
    script_op $03, $1E, $00
    script_op $02, $03, $02, $01
    script_sound $63
    script_op $02, $01, $02, $01
    script_op $0C, $01
    script_op $01, $03, $00, $01
    script_op $05, $83, $02
    script_op $03, $1E, $00
    script_op $02, $03, $02, $01
    script_sound $63
    script_op $02, $02, $02, $02
    script_op $0C, $02
    script_op $03, $1E, $00
    script_op $02, $03, $02, $03
    script_op $0C, $03
    script_op $03, $1E, $00
    script_sound $FF
    script_set_flag $0095
    script_end
Script_5EE6:: ; heuristic: event script entry or jump target; C0
    script_message $039D ; 'This leads to Lady Yuna's room.'
    script_op $01, $00, $02, $01
    script_op $01, $00, $01, $01
    script_op $05, $80, $00
    script_end
Script_5EF5:: ; heuristic: event script entry or jump target; C0
    script_sound $28
    script_command $46
    script_message $03A2 ; 'I am the King. What is'
    script_op $05, $80, $01
    script_message $03A3 ; 'King Magnificent! Don't you agree?'
    script_op $05, $80, $00
    script_message $03A4
    script_set_flag $0096
    script_end
Script_5F0B:: ; heuristic: event script entry or jump target; C0
Data_010_5F0B:: ; address name
    script_message $43B3 ; 'I beg your pardon, please!'
    script_jump_data_bank Script_6707
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5F12:: ; heuristic: event script entry or jump target; C0
    script_message $43B5 ; 'A botanist does live here But'
    script_skip_if_no Script_5F1B
    script_message $83B7 ; 'Lady Yuna was a rambunctious soul.'
    script_end
Script_5F1B:: ; heuristic: event script entry or jump target; C0
    script_message $83B6 ; 'I retired as a teacher and'
    script_end
    db $00, $BB, $41, $E7, $0B, $69, $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5F26:: ; heuristic: event script entry or jump target; C0
    script_message $03B0 ; 'Around these parts, there are times'
    script_op $0B, $80
    script_message $03B1 ; 'This is no place for a'
    script_op $01, $00, $02, $01
    script_op $0C, $00
    script_set_flag $0097
    script_end
Script_5F38:: ; heuristic: event script entry or jump target; C0
    script_message $03B0 ; 'Around these parts, there are times'
    script_op $0B, $81
    script_message $03B1 ; 'This is no place for a'
    script_op $01, $01, $02, $01
    script_op $0C, $01
    script_set_flag $0097
    script_end
    INCBIN "dwm2-cobi-us.gbc", $041F4A, $5B

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5FA5:: ; heuristic: event script entry or jump target; C0
    script_message $0D3C ; 'Whinny!'
    script_message $0AD1 ; 'Yuna's soul filled her body.'
    script_command $48
    script_end
Script_5FAD:: ; heuristic: event script entry or jump target; C0
    script_message $03A3 ; 'King Magnificent! Don't you agree?'
    script_message $0DD2 ; 'Hm, fine, I'll ignore it. But'
    script_message $0AD3 ; 'NEVER DID I EXPECT YUNA S'
    script_command $48
    script_end
Script_5FB8:: ; heuristic: event script entry or jump target; C0
    script_message $0AEA ; '0 checked the blue flower. It'
    script_op $01, $02, $01, $02
    script_op $0C, $02
    script_op $04, $01, $03
    script_command $49
    script_set_flag $01F1
    script_end
    db $66, $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5FCB:: ; heuristic: event script entry or jump target; C0
    script_command $66
    script_end
Script_5FCD:: ; heuristic: event script entry or jump target; C0
    script_message $0A01 ; 'Queen Helen has become healthy.'
    script_command $4A
    script_end
Script_5FD2:: ; heuristic: event script entry or jump target; C0
    script_command $4A
    script_end
    db $4B, $FF, $00, $20, $48, $E7, $D4, $77, $FF, $00, $19, $03, $0C, $01, $0A, $80
    db $00, $FF, $7F, $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5FE8:: ; heuristic: event script entry or jump target; C0
    script_message $442E ; 'Good day. How may I help'
    script_jump_data_bank Script_1F_77D4
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_5FEF:: ; heuristic: event script entry or jump target; C0
    script_message $040B ; 'The top of the tower collapsed'
    script_command $4E
    script_set_flag $00A0
    script_end
Script_5FF7:: ; heuristic: event script entry or jump target; C0
    script_message $040B ; 'The top of the tower collapsed'
    script_command $4E
    script_end
Script_5FFC:: ; heuristic: event script entry or jump target; C0
    script_message $0411 ; 'Be gone! If your soul can't'
    script_sound $66
    script_command $4F
    script_end
Script_6003:: ; heuristic: event script entry or jump target; C0
Data_010_6003:: ; address name
    script_message $41BB ; 'Tch, I think I can help'
    script_jump_data_bank Script_690B
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_600A:: ; heuristic: event script entry or jump target; C0
    script_message $0412 ; 'Fine! You e done well to'
    script_message $0DE6 ; 'The water flowed right over the'
    script_command $50
    script_set_flag $00A4
    script_end
Script_6015:: ; heuristic: event script entry or jump target; C0
    script_message $041D ; 'Hm? You're a stranger! You make'
    script_op $01, $00, $01, $01
    script_op $05, $80, $03
    script_end
Script_6020:: ; heuristic: event script entry or jump target; C0
    script_message $4426 ; 'The new monster king makes others'
    script_skip_if_no Script_6029
    script_message $8428 ; 'Uh-huh You don't look very strong.'
    script_end
Script_6029:: ; heuristic: event script entry or jump target; C0
    script_message $8427 ; 'You Are you a monster?'
    script_end
Script_602D:: ; heuristic: event script entry or jump target; C0
    script_message $4426 ; 'The new monster king makes others'
    script_skip_if_no Script_6036
    script_message $8428 ; 'Uh-huh You don't look very strong.'
    script_end
Script_6036:: ; heuristic: event script entry or jump target; C0
    script_message $8429 ; 'Uh-huh You look uh delicious.'
    script_end
Script_603A:: ; heuristic: event script entry or jump target; C0
    script_message $442E ; 'Good day. How may I help'
    script_jump_data_bank Script_1F_77D4
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_6041:: ; heuristic: event script entry or jump target; C0
Data_010_6041:: ; address name
    script_message $442D ; 'Are you looking for something? Huh?'
    script_jump_data_bank Script_6707
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_6048:: ; heuristic: event script entry or jump target; C0
Data_010_6048:: ; address name
    script_message $4432 ; '0 tried to open the chest.'
    script_jump_data_bank Script_690B
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_604F:: ; heuristic: event script entry or jump target; C0
    script_message $0433 ; 'Welcome to the traveler's inn.'
    script_command $51
    script_op $0D, $05
    script_set_flag $00A8
    script_end
Script_6059:: ; heuristic: event script entry or jump target; C0
    script_message $0433 ; 'Welcome to the traveler's inn.'
    script_op $0D, $05
    script_set_flag $00A8
    script_end
Script_6062:: ; heuristic: event script entry or jump target; C0
    script_message $4439 ; 'A monster king has appeared to'
    script_skip_if_no Script_606B
    script_message $843B ; 'This area had been prosperous, but'
    script_end
Script_606B:: ; heuristic: event script entry or jump target; C0
    script_message $843A ; 'I e lived here for 200'
    script_end
Script_606F:: ; heuristic: event script entry or jump target; C0
    script_message $4447 ; 'If I had the LightOrb, even'
    script_skip_if_no Script_6078
    script_message $8449 ; 'Walk. Learn to walk everywhere. Be'
    script_end
Script_6078:: ; heuristic: event script entry or jump target; C0
    script_message $8448 ; 'Want to know the most fundamental'
    script_end
Script_607C:: ; heuristic: event script entry or jump target; C0
Data_010_607C:: ; address name
    script_message $444B ; 'Hear me out if you wish'
    script_jump_data_bank Script_6707
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_6083:: ; heuristic: event script entry or jump target; C0
    script_message $444C ; 'Welcome! How may I serve you?'
    script_jump_data_bank Script_1F_77D4
    db $FF, $00, $51, $44, $E7, $0B, $69, $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_6091:: ; heuristic: event script entry or jump target; C0
    script_message $045A ; 'Those inside the haunted castle speak'
    script_command $52
    script_end
Script_6096:: ; heuristic: event script entry or jump target; C0
    script_message $045D ; '0 checked the small hole. It's'
    script_set_flag $00AD
    script_op $0D, $06
    script_message $045F ; 'I'm up for your challenge anytime!'
    script_op $01, $00, $00, $02
    script_op $01, $00, $03, $02
    script_op $0C, $00
    script_set_flag $00AE
    script_command $CE
    script_end
Script_60B0:: ; heuristic: event script entry or jump target; C0
    script_message $045E ; 'You can take this treasure, but'
    script_op $0D, $06
    script_message $045F ; 'I'm up for your challenge anytime!'
    script_op $01, $00, $00, $02
    script_op $01, $00, $03, $02
    script_op $0C, $00
    script_set_flag $00AE
    script_command $CE
    script_end
Script_60C7:: ; heuristic: event script entry or jump target; C0
    script_message $0460 ; 'Heh, you're not half bad! As'
    script_op $0D, $07
    script_command $67
    script_end
Script_60CE:: ; heuristic: event script entry or jump target; C0
    script_command $53
    script_end
Script_60D0:: ; heuristic: event script entry or jump target; C0
    script_sound $9B
    script_command $54
    script_end
Script_60D4:: ; heuristic: event script entry or jump target; C0
    script_message $4464 ; '0 checked the notice. Follow the'
    script_skip_if_no Script_60DD
    script_message $849F ; 'I e become the Mayor, but'
    script_end
Script_60DD:: ; heuristic: event script entry or jump target; C0
    script_sound $66
    script_op $03, $3C, $00
    script_message $8465 ; '0 checked the gravestone. There was'
    script_command $55
    script_set_flag $00B2
    script_end
Script_60EA:: ; heuristic: event script entry or jump target; C0
    script_message $0466 ; 'A door opened somewhere'
    script_set_flag $00B3
    script_op $0D, $08
    script_message $0468 ; 'Wahahahah! Here again, are you? I'
    script_command $56
    script_set_flag $00B4
    script_set_flag $00C5
    script_set_flag $00C6
    script_set_flag $00C7
    script_end
Script_6103:: ; heuristic: event script entry or jump target; C0
    script_message $0467 ; 'You overcame the traps I laid'
    script_op $0D, $08
    script_message $0468 ; 'Wahahahah! Here again, are you? I'
    script_command $56
    script_set_flag $00B4
    script_set_flag $00C5
    script_set_flag $00C6
    script_set_flag $00C7
    script_end
Script_6119:: ; heuristic: event script entry or jump target; C0
    script_message $0469 ; 'You e beaten me fairly Take'
    script_op $01, $00, $02, $01
    script_op $0C, $00
    script_set_flag $00B6
    script_end
Script_6126:: ; heuristic: event script entry or jump target; C0
    script_message $0471 ; 'Hm? How did you get in'
    script_command $68
    script_op $05, $80, $00
    script_set_flag $00B8
    script_end
Script_6131:: ; heuristic: event script entry or jump target; C0
    script_command $69
    script_end
Script_6133:: ; heuristic: event script entry or jump target; C0
    script_message $047A ; 'Ah, so good of you to'
    script_message $447B ; 'Ah, so good of you to'
    script_message $C47C ; '0 handed over the Heaven Helmet.'
    script_message $847D ; '0 handed over the Heaven Armor.'
    script_message $047E ; '0 handed over the Heaven Sword.'
    script_set_flag $00C0
    script_command $57
    script_set_flag $00C1
    script_end
Script_614A:: ; heuristic: event script entry or jump target; C0
    script_message $047F ; 'Good. You have brought the three'
    script_command $57
    script_set_flag $00C1
    script_end
Script_6152:: ; heuristic: event script entry or jump target; C0
    script_sound $28
    script_op $04, $02, $04
    script_op $0B, $80
    script_op $01, $00, $00, $01
    script_message $0481 ; 'Gwaah! You e beaten me fairly!'
    script_op $01, $00, $03, $01
    script_op $03, $14, $00
    script_op $01, $00, $01, $01
    script_op $03, $14, $00
    script_op $01, $00, $01, $01
    script_op $03, $14, $00
    script_op $01, $00, $01, $01
    script_op $03, $14, $00
    script_op $01, $00, $03, $01
    script_op $03, $14, $00
    script_op $05, $80, $00
    script_message $0482 ; 'Kameha So it was you who'
    script_command $58
    script_end
Script_618B:: ; heuristic: event script entry or jump target; C0
    script_sound $65
    script_op $01, $01, $00, $04
    script_op $03, $0A, $00
    script_set_flag $00C4
    script_end
Script_6198:: ; heuristic: event script entry or jump target; C0
    script_message $04A7 ; 'I was taking a walk outside'
    script_command $7D
    script_end
Script_619D:: ; heuristic: event script entry or jump target; C0
    script_message $4550 ; 'I heard from Lord Darck, but'
    script_skip_if_no Script_61A6
    script_message $855D ; 'How dare you come without the'
    script_end
Script_61A6:: ; heuristic: event script entry or jump target; C0
    script_message $855C ; 'Wa-hey! can you hear me, 0?'
    script_end
Script_61AA:: ; heuristic: event script entry or jump target; C0
    script_message $4550 ; 'I heard from Lord Darck, but'
    script_skip_if_no Script_61B3
    script_message $855D ; 'How dare you come without the'
    script_end
Script_61B3:: ; heuristic: event script entry or jump target; C0
    script_message $8551 ; 'I heard from Lord Darck, but'
    script_message $0552 ; 'Surprisingly obedient, are you? Hand over'
    script_op $05, $80, $02
    script_command $5C
    script_message $0553 ; '0 handed over the TidalBell. 0'
    script_op $01, $01, $02, $05
    script_op $03, $1E, $00
    script_op $0C, $01
    script_op $05, $80, $00
    script_message $0554 ; 'Take these to Lord Darck now.'
    script_set_flag $00D2
    script_op $0D, $1D
    script_message $0556 ; 'You seem to still not realize'
    script_command $5D
    script_set_flag $00D3
    script_end
Script_61DC:: ; heuristic: event script entry or jump target; C0
    script_message $0555 ; 'My work is done I am'
    script_op $0D, $1D
    script_message $0556 ; 'You seem to still not realize'
    script_command $5D
    script_set_flag $00D3
    script_end
Script_61E9:: ; heuristic: event script entry or jump target; C0
    script_message $0557 ; 'N No How could my monsters'
    script_set_flag $00D0
    script_op $0D, $0A
    script_message $0559 ; 'Darck Fwahahahah! Bravo! Splendid! You e'
    script_command $5E
    script_end
Script_61F6:: ; heuristic: event script entry or jump target; C0
    script_message $0558 ; 'Darck Fawahahah! You chased your treasures'
    script_op $0D, $0A
    script_message $0559 ; 'Darck Fwahahahah! Bravo! Splendid! You e'
    script_command $5E
    script_end
Script_6200:: ; heuristic: event script entry or jump target; C0
    script_op $05, $80, $00
    script_command $CC
    script_op $01, $00, $02, $05
    script_set_flag $0140
    script_end
Script_620C:: ; heuristic: event script entry or jump target; C0
    script_message $0704 ; 'Are you maybe a human?'
    script_op $0B, $81
    script_message $0705 ; 'So Cyal took a shine to'
    script_set_flag $0143
    script_end
Script_6218:: ; heuristic: event script entry or jump target; C0
    script_message $0710 ; 'Well, well It is a rare'
    script_command $C0
    script_message $0711 ; 'Well, well, a human here is'
    script_op $0B, $82
    script_message $0712 ; 'Rolt That was fast, 0. I'
    script_op $01, $02, $00, $02
    script_set_flag $0146
    script_end
Script_622C:: ; heuristic: event script entry or jump target; C0
    script_message $0713 ; 'Cyal 0, let's play! I want'
    script_command $C0
    script_message $0711 ; 'Well, well, a human here is'
    script_op $0B, $82
    script_message $0712 ; 'Rolt That was fast, 0. I'
    script_op $01, $02, $00, $02
    script_set_flag $0146
    script_end
Script_6240:: ; heuristic: event script entry or jump target; C0
    script_message $0716 ; 'Rolt 0, I can see that'
    script_op $02, $02, $00, $04
    script_set_flag $0147
    script_end
Script_624B:: ; heuristic: event script entry or jump target; C0
    script_op $05, $80, $00
    script_op $0B, $80
    script_message $071D ; 'Humans can't be trusted, but Please'
    script_op $02, $00, $02, $05
    script_op $03, $1E, $00
    script_op $05, $00, $00
    script_message $071E ; 'Cyal Oh! 0! I'm over here!'
    script_op $03, $1E, $00
    script_message $071F ; '0 counted off'
    script_set_flag $0148
    script_end
Script_626A:: ; heuristic: event script entry or jump target; C0
    script_op $0B, $82
    script_message $0720 ; 'Cyal Eeek, 0! Help me!'
    script_op $0B, $83
    script_message $0721 ; 'Master AgDevil, a human, ruff!'
    script_op $01, $01, $00, $01
    script_op $05, $82, $02
    script_op $05, $83, $01
    script_message $0722 ; 'What shall we do, ruff?'
    script_op $01, $01, $02, $01
    script_op $01, $01, $01, $01
    script_op $05, $81, $02
    script_set_flag $0149
    script_end
Script_6290:: ; heuristic: event script entry or jump target; C0
    script_message $0724 ; 'Tch, we have to eat the'
    script_set_flag $014A
    script_op $0D, $09
    script_message $0754 ; 'I'm the Village Elder. By the'
    script_command $C1
    script_set_flag $014B
    script_end
Script_62A0:: ; heuristic: event script entry or jump target; C0
    script_message $0727 ; 'Huh? It's here again, ruff! It's'
    script_op $0D, $09
    script_message $0754 ; 'I'm the Village Elder. By the'
    script_command $C1
    script_set_flag $014B
    script_end
Script_62AD:: ; heuristic: event script entry or jump target; C0
    script_message $0728 ; 'You e come back again, ruff?'
    script_op $02, $01, $00, $07
    script_op $0B, $80
    script_message $0729 ; 'Rolt What? Cyal was abducted? Who'
    script_set_flag $014C
    script_end
Script_62BD:: ; heuristic: event script entry or jump target; C0
    script_message $4739 ; 'Rolt Urrrgh 0 Please Please save'
    script_op $0D, $0B
    script_message $073B ; 'What, you again? Rude, rude, rude!'
    script_command $C3
    script_message $073C ; 'Wh-what? I Lost to a child?'
    script_op $02, $02, $03, $01
    script_op $02, $02, $02, $01
    script_op $02, $02, $03, $01
    script_op $05, $82, $02
    script_op $03, $1E, $00
    script_op $05, $81, $01
    script_op $03, $1E, $00
    script_op $05, $81, $03
    script_op $03, $1E, $00
    script_op $05, $81, $01
    script_op $03, $1E, $00
    script_op $05, $81, $03
    script_message $073D ; 'Rolt Wow 0, you're tough. Oh!'
    script_op $03, $1E, $00
    script_op $05, $81, $00
    script_message $073E ; 'Rolt Cyal! Are you OK? Cyal!'
    script_message $073F ; 'Cyal Big brother! I was so'
    script_op $05, $82, $00
    script_message $0740 ; 'Rolt You're safe now. 0 did'
    script_set_flag $0151
    script_set_flag $0203
    script_command $C6
    script_op $05, $80, $03
    script_message $0741 ; 'Rolt 0, I'm sorry we put'
    script_end
Script_6313:: ; heuristic: event script entry or jump target; C0
    script_message $073A ; 'The human in the forest again?'
    script_op $0D, $0B
    script_message $073B ; 'What, you again? Rude, rude, rude!'
    script_command $C3
    script_message $073C ; 'Wh-what? I Lost to a child?'
    script_op $02, $02, $03, $01
    script_op $02, $02, $02, $01
    script_op $02, $02, $03, $01
    script_op $05, $82, $02
    script_op $03, $1E, $00
    script_op $05, $81, $01
    script_op $03, $1E, $00
    script_op $05, $81, $03
    script_op $03, $1E, $00
    script_op $05, $81, $01
    script_op $03, $1E, $00
    script_op $05, $81, $03
    script_message $073D ; 'Rolt Wow 0, you're tough. Oh!'
    script_op $03, $1E, $00
    script_op $05, $81, $00
    script_message $073E ; 'Rolt Cyal! Are you OK? Cyal!'
    script_message $073F ; 'Cyal Big brother! I was so'
    script_op $05, $82, $00
    script_message $0740 ; 'Rolt You're safe now. 0 did'
    script_set_flag $0151
    script_set_flag $0203
    script_command $C6
    script_op $05, $80, $03
    script_message $0741 ; 'Rolt 0, I'm sorry we put'
    script_end
Script_6369:: ; heuristic: event script entry or jump target; C0
    script_message $0734 ; 'You're not going to the northern'
    script_message $0735 ; 'Rolt I e found you at'
    script_message $0736 ; 'Kikiki, what just you? That's utterly'
    script_op $02, $02, $02, $02
    script_command $C2
    script_set_flag $014F
    script_end
Script_637B:: ; heuristic: event script entry or jump target; C0
Data_010_637B:: ; address name
    script_message $470E ; 'This is Elven village. You're a'
    script_jump_data_bank Script_6707
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_6382:: ; heuristic: event script entry or jump target; C0
    script_set_flag $0142
    script_message $4703 ; 'Even worse, you have monsters. Get'
Script_6388:: ; heuristic: event script entry or jump target; C0
    script_skip_if_no Script_6392
    script_op $0B, $81
    script_message $CC57 ; 'Really! Wow! You're the first human'
    script_jump Script_6388
Script_6392:: ; heuristic: event script entry or jump target; C0
    script_op $0B, $81
    script_message $8C56 ; 'Young master The final test'
    script_end
Script_6398:: ; heuristic: event script entry or jump target; C0
    script_op $0B, $80
    script_message $4759 ; '0 checked the oven. Stew simmered'
    script_skip_if_no Script_63A6
    script_message $875D ; 'Kiral Oh! Foolish of me, I'
    script_set_flag $0159
    script_end
Script_63A6:: ; heuristic: event script entry or jump target; C0
    script_message $875B ; 'Pii Ggzz Piiiiii'
    script_op $01, $00, $03, $02
    script_op $05, $80, $01
    script_op $03, $1E, $00
    script_op $0B, $80
    script_message $075C ; 'Kiral Hohoh! Grand, grand! Go fetch'
    script_set_flag $015A
    script_end
Script_63BC:: ; heuristic: event script entry or jump target; C0
    script_message $475E ; 'Kiral No? How disappointing. Your efforts'
    script_skip_if_no Script_63C5
    script_message $875D ; 'Kiral Oh! Foolish of me, I'
    script_end
Script_63C5:: ; heuristic: event script entry or jump target; C0
    script_message $875B ; 'Pii Ggzz Piiiiii'
    script_op $01, $00, $03, $02
    script_op $05, $80, $01
    script_op $03, $1E, $00
    script_op $0B, $80
    script_message $075C ; 'Kiral Hohoh! Grand, grand! Go fetch'
    script_set_flag $015A
    script_end
Script_63DB:: ; heuristic: event script entry or jump target; C0
    script_message $0767 ; '0 peered into the barrel. A'
    script_op $0D, $1F
    script_set_flag $015D
    script_end
Script_63E4:: ; heuristic: event script entry or jump target; C0
    script_message $0767 ; '0 peered into the barrel. A'
    script_op $0D, $1F
    script_set_flag $015E
    script_end
Script_63ED:: ; heuristic: event script entry or jump target; C0
    script_message $0769 ; '0 peered into the barrel. There'
    script_message $076A ; 'PROFESSOR SAY GUARD TREASURE NEVER SURRENDER'
    script_end
Script_63F4:: ; heuristic: event script entry or jump target; C0
    script_message $076D ; 'PROFESSOR SAY GUARD TREASURE'
    script_message $076E ; 'PRO SOR AY GGGGUARD TREZZZT'
    script_end
Script_63FB:: ; heuristic: event script entry or jump target; C0
    script_message $0770 ; 'PRO SOR AY GGGGUARD TREZZZT'
    script_message $0771 ; 'PIPIPI GGGGGGAGAGAGA'
    script_end
Script_6402:: ; heuristic: event script entry or jump target; C0
    script_message $0773 ; 'PIPIPI GGGGGGAGAGAGA'
    script_message $0774 ; 'PI PI'
    script_end
Script_6409:: ; heuristic: event script entry or jump target; C0
    script_message $0776 ; 'PI PI'
    script_op $03, $1E, $00
    script_message $0777 ; 'Kiral Ah! Back! The treasure? What?'
    script_set_flag $0162
    script_end
Script_6416:: ; heuristic: event script entry or jump target; C0
    script_message $076B ; 'Roboster is acting strangely. It appears'
    script_command $C4
    script_end
Script_641B:: ; heuristic: event script entry or jump target; C0
    script_message $077D ; '0 peered into the barrel. There'
    script_message $077E ; 'Kiral Ah! Back! Is Rob-N Did'
    script_message $077F ; '0 handed over the blue stone.'
    script_op $02, $00, $01, $03
    script_command $C5
    script_set_flag $0165
    script_set_flag $0204
    script_end
Script_6430:: ; heuristic: event script entry or jump target; C0
    script_message $0795 ; 'You appear to have the power'
    script_message $0796 ; 'Sigh'
    script_end
Script_6437:: ; heuristic: event script entry or jump target; C0
    script_message $0797 ; 'The old man's sigh sounded sad'
    script_message $0798 ; 'Sigh'
    script_end
Script_643E:: ; heuristic: event script entry or jump target; C0
Data_010_643E:: ; address name
    script_message $479D ; 'Grrrr! I'm so angry! Monsters stole'
    script_jump_data_bank Script_6707
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_6445:: ; heuristic: event script entry or jump target; C0
    script_message $479E ; 'Hello! What may I do for'
    script_jump_data_bank $690B ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_644C:: ; heuristic: event script entry or jump target; C0
    script_op $0B, $81
    script_message $47A0 ; 'If you travel west along the'
    script_skip_if_no Script_645A
    script_message $87A2 ; 'Thank you! I knew you agree!'
    script_set_flag $01B0
    script_end
Script_645A:: ; heuristic: event script entry or jump target; C0
    script_message $87A1 ; 'Excuse me, are you a master?'
    script_op $01, $01, $03, $02
    script_op $01, $01, $00, $06
    script_set_flag $01B1
    script_end
Script_6469:: ; heuristic: event script entry or jump target; C0
    script_message $47A3 ; 'I can't count on your support?'
    script_skip_if_no Script_6472
    script_message $87A2 ; 'Thank you! I knew you agree!'
    script_end
Script_6472:: ; heuristic: event script entry or jump target; C0
    script_message $87A1 ; 'Excuse me, are you a master?'
    script_op $01, $01, $03, $02
    script_op $01, $01, $00, $06
    script_set_flag $01B1
    script_end
Script_6481:: ; heuristic: event script entry or jump target; C0
    script_message $47AB ; 'That dealer, how expensive! Nobody can'
    script_skip_if_no Script_648A
    script_message $87AD ; 'It's rumored that monsters raid the'
    script_end
Script_648A:: ; heuristic: event script entry or jump target; C0
    script_message $87AC ; 'Lately, the town of Miagen has'
    script_end
Script_648E:: ; heuristic: event script entry or jump target; C0
    script_message $07B6 ; 'How does this grand vase look?'
    script_command $C7
    script_set_flag $01B9
    script_end
Script_6496:: ; heuristic: event script entry or jump target; C0
    script_set_flag $01BA
    script_message $07B9 ; 'Who are you? You shouldn't be'
    script_op $0D, $11
    script_message $07BC ; 'We'll smash you as often as'
    script_command $C8
    script_set_flag $01BB
    script_end
Script_64A6:: ; heuristic: event script entry or jump target; C0
    script_message $07BB ; 'What, not you again!'
    script_op $0D, $11
    script_message $07BC ; 'We'll smash you as often as'
    script_command $C8
    script_set_flag $01BB
    script_end
Script_64B3:: ; heuristic: event script entry or jump target; C0
    script_message $07BD ; 'Please! Mercy! Spare us! Take back'
    script_op $0C, $00
    script_op $0C, $02
    script_set_flag $01BC
    script_end
Script_64BE:: ; heuristic: event script entry or jump target; C0
    script_message $07C3 ; 'That dealer is a greedy hound!'
    script_op $0B, $81
    script_message $07C4 ; 'For 47,000G this earring What? You'
    script_set_flag $01BD
    script_end
Script_64CA:: ; heuristic: event script entry or jump target; C0
    script_message $07CA ; 'Arrrgh! This is so infuriating! The'
    script_op $0B, $80
    script_message $07CB ; '0 showed the Pretty Ring.'
    script_message $07CC ; 'Ah That ring Is Is it'
    script_message $07CD ; '0 handed over the Pretty Ring.'
    script_set_flag $01BE
    script_end
Script_64DC:: ; heuristic: event script entry or jump target; C0
    script_message $07CF ; 'Things haven't been good for us.'
    script_message $07D1 ; '0 received a SageRock.'
    script_end
Script_64E3:: ; heuristic: event script entry or jump target; C0
    script_message $07CF ; 'Things haven't been good for us.'
    script_message $07D0 ; 'Thank you for recovering our daughter's'
    script_set_flag $01BF
    script_end
Script_64ED:: ; heuristic: event script entry or jump target; C0
    script_message $07DA ; 'The thieving monsters had a boss,'
    script_command $C7
    script_op $02, $01, $00, $02
    script_op $02, $01, $01, $01
    script_op $02, $01, $00, $04
    script_set_flag $01C0
    script_end
Script_6501:: ; heuristic: event script entry or jump target; C0
    script_message $07DC ; 'That greedhound dealer scuttled off in'
    script_command $C9
    script_set_flag $01C1
    script_end
Script_6509:: ; heuristic: event script entry or jump target; C0
    script_set_flag $01C2
    script_message $0CDE ; 'What is it, you little brat?'
    script_op $0D, $12
    script_message $0CE0 ; 'What is it, you little brat?'
    script_command $CA
    script_op $01, $01, $02, $02
    script_op $05, $00, $00
    script_message $0CE1 ; 'But No! I lost to this'
    script_op $01, $01, $00, $02
    script_op $0C, $01
    script_set_flag $01C3
    script_set_flag $0205
    script_end
Script_652C:: ; heuristic: event script entry or jump target; C0
    script_message $0CDF ; 'What is it, you little brat?'
    script_op $0D, $12
    script_message $0CE0 ; 'What is it, you little brat?'
    script_command $CA
    script_op $01, $01, $02, $02
    script_op $05, $00, $00
    script_message $0CE1 ; 'But No! I lost to this'
    script_op $01, $01, $00, $02
    script_op $0C, $01
    script_set_flag $01C3
    script_set_flag $0205
    script_end
Script_654C:: ; heuristic: event script entry or jump target; C0
    script_message $0CEF ; 'It sure was a thrilling time'
    script_op $0B, $00
    script_message $0CF0 ; 'Milayou I asked for your support'
    script_set_flag $01C4
    script_end
Script_6558:: ; heuristic: event script entry or jump target; C0
    script_set_flag $01C6
    script_message $4CF5 ; 'That greedy hound of a dealer'
    script_skip_if_no Script_6564
    script_message $8CF7 ; 'Milayou Great! No holding back!'
    script_end
Script_6564:: ; heuristic: event script entry or jump target; C0
    script_message $8CF6 ; 'Milayou I knew you come back!'
    script_op $0D, $13
    script_message $0CF9 ; 'Milayou Want to spar with me?'
    script_op $01, $01, $03, $02
    script_op $01, $01, $00, $06
    script_set_flag $01C7
    script_end
Script_6578:: ; heuristic: event script entry or jump target; C0
    script_message $4CF8 ; 'Milayou Oh I'm disappointed Come again'
    script_skip_if_no Script_6581
    script_message $8CF7 ; 'Milayou Great! No holding back!'
    script_end
Script_6581:: ; heuristic: event script entry or jump target; C0
    script_message $8CF6 ; 'Milayou I knew you come back!'
    script_op $0D, $13
    script_message $0CF9 ; 'Milayou Want to spar with me?'
    script_op $01, $01, $03, $02
    script_op $01, $01, $00, $06
    script_set_flag $01C7
    script_end
    db $00, $48, $0C, $0D, $32, $74, $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_659C:: ; heuristic: event script entry or jump target; C0
    script_command $CB
    script_end
    db $00, $49, $0C, $CD, $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_65A3:: ; heuristic: event script entry or jump target; C0
    script_message $4123 ; 'Warubou Wa-hey! You did it, 0!'
    script_jump_data_bank $6707 ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_65AA:: ; heuristic: event script entry or jump target; C0
Data_010_65AA:: ; address name
    script_message $4124 ; 'Warubou Wa-hey! You did it, 0!'
    script_jump_data_bank $690B ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_65B1:: ; heuristic: event script entry or jump target; C0
    script_message $4128 ; 'Warubou Wa-hey! So, this is it?'
    script_jump_data_bank $690B ; data bank not known here
    db $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_65B8:: ; heuristic: event script entry or jump target; C0
    script_message $4127 ; 'Warubou There, your party's fine! So,'
    script_jump_data_bank Script_1F_77D4
    db $FF

; runs one frame of script command type E0 (entry 223 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandE0:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_65BF:: ; address name
    farcall ScriptCommandE0_Run
    ret

; runs one frame of script command type E1 (entry 224 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandE1:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_65C6:: ; address name
    farcall ScriptCommandE1_Run
    ret

; runs one frame of script command type E2 (entry 225 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandE2:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_65CD:: ; address name
    farcall ScriptCommandE2_Run
    ret

; runs one frame of script command type E3 (entry 226 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandE3:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_65D4:: ; address name
    farcall ScriptCommandE3_Run
    ret

; runs one frame of script command type E5 (entry 228 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandE5:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_65DB:: ; address name
    farcall ScriptCommandE5_Run
    ret

; runs one frame of script command type E6 (entry 229 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandE6:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_65E2:: ; address name
    farcall ScriptCommandE6_Run
    ret

; runs one frame of script command type E8 (entry 231 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandE8:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_65E9:: ; address name
    farcall ScriptCommandE8_Run
    ret

; runs one frame of script command type E9 (entry 232 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandE9:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_65F0:: ; address name
    farcall ScriptCommandE9_Run
    ret

; runs one frame of script command type EB (entry 234 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandEB:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_65F7:: ; address name
    farcall ScriptCommandEB_Run
    ret

; runs one frame of script command type EC (entry 235 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandEC:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_65FE:: ; address name
    farcall ScriptCommandEC_Run
    ret

; runs one frame of script command type ED (entry 236 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandED:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_6605:: ; address name
    farcall ScriptCommandED_Run
    ret

; runs one frame of script command type EE (entry 237 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandEE:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_660C:: ; address name
    farcall ScriptCommandEE_Run
    ret

; runs one frame of script command type EF (entry 238 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandEF:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_6613:: ; address name
    farcall ScriptCommandEF_Run
    ret

; runs one frame of script command type F0 (entry 239 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandF0:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_661A:: ; address name
    farcall ScriptCommandF0_Run
    ret

; runs one frame of script command type F1 (entry 240 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandF1:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_6621:: ; address name
    farcall ScriptCommandF1_Run
    ret

; runs one frame of script command type F2 (entry 241 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandF2:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_6628:: ; address name
    farcall ScriptCommandF2_Run
    ret

; runs one frame of script command type F3 (entry 242 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandF3:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_662F:: ; address name
    farcall ScriptCommandF3_Run
    ret

; runs one frame of script command type F4 (entry 243 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandF4:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_6636:: ; address name
    farcall ScriptCommandF4_Run
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
    farcall ScriptCommandF6_Run
    ret

; runs one frame of script command type F7 (entry 246 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandF7:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_664B:: ; address name
    farcall ScriptCommandF7_Run
    ret

; runs one frame of script command type F8 (entry 247 of ScriptCommandHandlers)
; no direct call (reached through a table, a jump or a vector)
ScriptCommandF8:: ; code pointer of the table ScriptCommandHandlers; C0
Func_010_6652:: ; address name
    farcall ScriptCommandF8_Run
    ret

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_6659:: ; heuristic: event script entry or jump target; C0
    script_command $E2
    script_command $E2
Script_665B:: ; heuristic: event script entry or jump target; C0
    script_command $E2
    script_choice_jump Script_667D, Script_667A
    db $14, $01, $09, $00, $07, $C0, $00, $08, $C0, $07, $5B, $66, $00, $0F, $C0, $00
    db $08, $C0, $07, $5B, $66, $E3, $00, $12, $80, $E3, $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_667A:: ; heuristic: event script entry or jump target; C0
    script_jump Script_66C9
Script_667D:: ; heuristic: event script entry or jump target; C0
    script_message $C006 ; 'You folks run a monster farm?'
    script_command $E2
    script_choice_jump Script_668F, Script_6688
    db $00, $00, $13, $C0

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_6688:: ; heuristic: event script entry or jump target; C0
    script_command $E2
    script_message $C008 ; 'Sailing is sure exhilarating. Right?'
    script_jump Script_665B
Script_668F:: ; heuristic: event script entry or jump target; C0
    script_message $C009 ; 'Good. That's good to hear! You'
    script_command $E2
    script_choice_jump Script_6699, Script_6696
Script_6696:: ; heuristic: event script entry or jump target; C0
    script_jump Script_667D
Script_6699:: ; heuristic: event script entry or jump target; C0
    script_command $E2
    script_message $C014 ; 'Tara Big brother! GreatLog will be'
    script_command $E2
    script_choice_jump Script_66A6, Script_66AD
    db $12, $00, $07, $8F, $66

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_66A6:: ; heuristic: event script entry or jump target; C0
    script_message $C00C ; 'GreatLog's King asked us to settle'
    script_command $E2
    script_jump Script_667D
Script_66AD:: ; heuristic: event script entry or jump target; C0
    script_message $C00D ; 'GreatLog's King asked us to settle'
    script_command $E2
    script_jump Script_667D
    db $00, $0B, $C0, $E2, $E4, $05, $00, $E2, $07, $7D, $66, $00, $13, $C0, $00, $08
    db $C0, $E2, $07, $5B, $66

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_66C9:: ; heuristic: event script entry or jump target; C0
    script_message $C00E ; 'When our farm gets established in'
    script_command $E2
    script_choice_jump Script_66DE, Script_66D1
    db $06

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_66D1:: ; heuristic: event script entry or jump target; C0
    script_message $C010 ; '0 peered into the barrel. It'
    script_jump Script_66C9
    db $E2, $00, $08, $C0, $07, $5B, $66

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_66DE:: ; heuristic: event script entry or jump target; C0
    script_message $C011 ; '0 peered into the vase. Freshly'
    script_command $E2
    script_choice_jump Script_66E8, Script_66E5
Script_66E5:: ; heuristic: event script entry or jump target; C0
    script_jump Script_66C9
Script_66E8:: ; heuristic: event script entry or jump target; C0
    script_message $C014 ; 'Tara Big brother! GreatLog will be'
    script_command $E2
    script_choice_jump Script_66F2, Script_66EF
Script_66EF:: ; heuristic: event script entry or jump target; C0
    script_jump Script_66DE
Script_66F2:: ; heuristic: event script entry or jump target; C0
    script_message $C00B ; 'We'll soon be reaching GreatLog. I'
    script_command $E2
    script_choice_jump Script_66FD, Script_66F9
Script_66F9:: ; heuristic: event script entry or jump target; C0
    script_command $E2
    script_jump Script_66C9
Script_66FD:: ; heuristic: event script entry or jump target; C0
    script_message $C00F ; 'Worried about your monsters? Don't be!'
    script_message $C008 ; 'Sailing is sure exhilarating. Right?'
    script_command $E2
    script_jump Script_665B
Script_6707:: ; heuristic: event script entry or jump target; C0
    script_command $E2
    script_command $E2
Script_6709:: ; heuristic: event script entry or jump target; C0
    script_command $E2
    script_choice_jump Script_672B, Script_6728
    db $14, $01, $09, $00, $33, $C0, $00, $34, $C0, $07, $09, $67, $00, $3B, $C0, $00
    db $34, $C0, $07, $09, $67, $E3, $00, $3E, $80, $E3, $FF

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_6728:: ; heuristic: event script entry or jump target; C0
    script_jump Script_6777
Script_672B:: ; heuristic: event script entry or jump target; C0
    script_message $C032 ; 'C'mon, Warubou!'
    script_command $E2
    script_choice_jump Script_673D, Script_6736
    db $00, $00, $3F, $C0

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_6736:: ; heuristic: event script entry or jump target; C0
    script_command $E2
    script_message $C034 ; 'Oh It's all spinning around That'
    script_jump Script_6709
Script_673D:: ; heuristic: event script entry or jump target; C0
    script_message $C035 ; 'The horrid Prince and that elemental'
    script_command $E2
    script_choice_jump Script_6747, Script_6744
Script_6744:: ; heuristic: event script entry or jump target; C0
    script_jump Script_672B
Script_6747:: ; heuristic: event script entry or jump target; C0
    script_command $E2
    script_message $C040 ; 'Inside the well is the Log's'
    script_command $E2
    script_choice_jump Script_6754, Script_675B
    db $12, $00, $07, $3D, $67

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_6754:: ; heuristic: event script entry or jump target; C0
    script_message $C038 ; '0 tried to open the chest.'
    script_command $E2
    script_jump Script_672B
Script_675B:: ; heuristic: event script entry or jump target; C0
    script_message $C039 ; '0 peered into the vase. A'
    script_command $E2
    script_jump Script_672B
    db $00, $37, $C0, $E2, $E4, $05, $00, $E2, $07, $2B, $67, $00, $3F, $C0, $00, $34
    db $C0, $E2, $07, $09, $67

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_6777:: ; heuristic: event script entry or jump target; C0
    script_message $C03A ; 'Hey! You brats! Scram! Hands off'
    script_command $E2
    script_choice_jump Script_678C, Script_677F
    db $06

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_677F:: ; heuristic: event script entry or jump target; C0
    script_message $C03C ; 'This palm tree is GreatLog. We'
    script_jump Script_6777
    db $E2, $00, $34, $C0, $07, $09, $67

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_678C:: ; heuristic: event script entry or jump target; C0
    script_message $C03D ; 'You're the kids from the new'
    script_command $E2
    script_choice_jump Script_6796, Script_6793
Script_6793:: ; heuristic: event script entry or jump target; C0
    script_jump Script_6777
Script_6796:: ; heuristic: event script entry or jump target; C0
    script_message $C040 ; 'Inside the well is the Log's'
    script_command $E2
    script_choice_jump Script_67A0, Script_679D
Script_679D:: ; heuristic: event script entry or jump target; C0
    script_jump Script_678C
Script_67A0:: ; heuristic: event script entry or jump target; C0
    script_message $C037 ; 'There were many wild monsters in'
    script_command $E2
    script_choice_jump Script_67AB, Script_67A7
Script_67A7:: ; heuristic: event script entry or jump target; C0
    script_command $E2
    script_jump Script_6777
Script_67AB:: ; heuristic: event script entry or jump target; C0
    script_message $C03B ; 'That weird ape thing is Warubou,'
    script_message $C034 ; 'Oh It's all spinning around That'
    script_command $E2
    script_jump Script_6709
Script_67B5:: ; heuristic: event script entry or jump target; C0
    script_command $E5
    script_command $E5
Script_67B7:: ; heuristic: event script entry or jump target; C0
    script_command $E5
    script_choice_jump Script_67BC, Script_67BF
    db $06

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_67BC:: ; heuristic: event script entry or jump target; C0
    script_jump Script_67C5
Script_67BF:: ; heuristic: event script entry or jump target; C0
    script_jump Script_6869
    db $07, $05, $69

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_67C5:: ; heuristic: event script entry or jump target; C0
    script_command $E5
    script_message $C016 ; 'Listen you two! Quit your horsing'
    script_command $E5
    script_choice_jump Script_67D2, Script_67D9
    db $15, $1B, $21, $23, $25

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_67D2:: ; heuristic: event script entry or jump target; C0
    script_message $C017 ; 'It seems to me that the'
    script_command $E5
    script_jump Script_67DD
Script_67D9:: ; heuristic: event script entry or jump target; C0
    script_message $C019 ; 'Slash If you're in need of'
    script_command $E5
Script_67DD:: ; heuristic: event script entry or jump target; C0
    script_message $C018 ; 'Yo, did you enjoy the voyage?'
    script_jump Script_67FB
    db $00, $1E, $C0, $E5, $07, $DD, $67, $00, $19, $C0, $E5, $07, $DD, $67, $07, $FF
    db $67, $07, $48, $68, $00, $18, $C0, $E5

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_67FB:: ; heuristic: event script entry or jump target; C0
    script_command $E5
    script_jump Script_67B7
    INCBIN "dwm2-cobi-us.gbc", $0427FF, $6A

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_6869:: ; heuristic: event script entry or jump target; C0
    script_command $E5
    script_message $C020 ; 'Cobi Sure, Mama! We'll be fine.'
    script_command $E5
    script_choice_jump Script_6876, Script_687D
    db $15, $1B, $21, $23, $25

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_6876:: ; heuristic: event script entry or jump target; C0
    script_message $C021 ; 'Good, that's settled then. The Vault'
    script_command $E5
    script_jump Script_6881
Script_687D:: ; heuristic: event script entry or jump target; C0
    script_message $C022 ; 'Tara We'll be OK! I'm going'
    script_command $E5
Script_6881:: ; heuristic: event script entry or jump target; C0
    script_message $C018 ; 'Yo, did you enjoy the voyage?'
    script_jump Script_67FB
    INCBIN "dwm2-cobi-us.gbc", $042887, $84

; event script (E-0152: opcodes and inline bytes C2 from the fetch handlers; command meanings C1)
Script_690B:: ; heuristic: event script entry or jump target; C0
    script_command $E0
    script_command $E0
    script_message $C000 ; ''t 'l 'l 'l6 M 6'
    script_skip_if_no Script_6917
    script_message $8002 ; 'Cobi 0! Papa's calling. He's at'
    script_command $E1
    script_end
Script_6917:: ; heuristic: event script entry or jump target; C0
    script_command $E0
    script_skip_if_no Script_691F
    script_message $8003 ; 'Tara There you are, big brother!'
    script_command $E1
    script_end
Script_691F:: ; heuristic: event script entry or jump target; C0
    script_message $C001 ; 'In the middle of the sea'
    script_command $E0
    script_message $8004 ; 'Cobi What's wrong, 0? Papa's calling'
    script_command $E1
    script_end
    ds $16D8, $00
