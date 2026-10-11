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
; 5 call sites from 5 routines (e.g. RunEventScriptFrame, RunWC8C7Phase_Case02, RunWC46BMenuState_Case05, GameMode5_Update_Case02, ...)
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
; reads: wScriptInDataBank, wD7FB, wScriptParam0
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
    ld a, [wD7FB]
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
; reads: wD7F0, wMapType
; writes: wStringIndex, wStringCategory
ScriptCommand09_Case01_Sub01::
Func_010_4AD0:: ; address name
    ld a, h
    and a, $3F
    ld h, a
    push hl
    ld a, [wD7F0]
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
    INCBIN "dwm2-cobi-us.gbc", $040F54, $3EA

Data_010_533E:: ; heuristic: bank from RAM variable $D7FE; C0
    db $00, $0D, $42, $E7, $59, $66, $FF

Data_010_5345:: ; heuristic: bank from RAM variable $D7FE; C0
    db $00, $0E, $42, $E7, $59, $66, $FF

Data_010_534C:: ; heuristic: bank from RAM variable $D7FE; C0
    db $00, $89, $4D, $E7, $59, $66, $FF

Data_010_5353:: ; heuristic: bank from RAM variable $D7FE; C0
    db $0A, $03, $01, $00, $1C, $41, $E7, $B5, $67, $FF, $00, $1D, $41, $E7, $B5, $67
    db $FF

Data_010_5364:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $041364, $2E7

Data_010_564B:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $04164B, $1A2

Data_010_57ED:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $0417ED, $1D4

Data_010_59C1:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $0419C1, $1CB

Data_010_5B8C:: ; heuristic: bank from RAM variable $D7FE; C0
    db $00, $09, $48, $E7, $07, $67, $FF, $FF, $00, $BB, $41, $E7, $0B, $69, $FF, $00
    db $18, $48, $06, $04, $00, $1A, $88, $FF, $00, $19, $88, $FF, $00, $20, $48, $E7
    db $D4, $77, $FF

Data_010_5BAF:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $041BAF, $1B9

Data_010_5D68:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $041D68, $48

Data_010_5DB0:: ; heuristic: bank from RAM variable $D7FE; C0
    db $00, $31, $43, $E7, $59, $66, $FF

Data_010_5DB7:: ; heuristic: bank from RAM variable $D7FE; C0
    db $00, $32, $43, $E7, $07, $67, $FF

Data_010_5DBE:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $041DBE, $D0

Data_010_5E8E:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $041E8E, $7D

Data_010_5F0B:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $041F0B, $F8

Data_010_6003:: ; heuristic: bank from RAM variable $D7FE; C0
    db $00, $BB, $41, $E7, $0B, $69, $FF, $00, $12, $04, $00, $E6, $0D, $50, $0A, $A4
    db $00, $FF, $00, $1D, $04, $01, $00, $01, $01, $05, $80, $03, $FF, $00, $26, $44
    db $06, $04, $00, $28, $84, $FF, $00, $27, $84, $FF, $00, $26, $44, $06, $04, $00
    db $28, $84, $FF, $00, $29, $84, $FF, $00, $2E, $44, $E7, $D4, $77, $FF

Data_010_6041:: ; heuristic: bank from RAM variable $D7FE; C0
    db $00, $2D, $44, $E7, $07, $67, $FF

Data_010_6048:: ; heuristic: bank from RAM variable $D7FE; C0
    db $00, $32, $44, $E7, $0B, $69, $FF, $00, $33, $04, $51, $0D, $05, $0A, $A8, $00
    db $FF, $00, $33, $04, $0D, $05, $0A, $A8, $00, $FF, $00, $39, $44, $06, $04, $00
    db $3B, $84, $FF, $00, $3A, $84, $FF, $00, $47, $44, $06, $04, $00, $49, $84, $FF
    db $00, $48, $84, $FF

Data_010_607C:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $04207C, $2FF

Data_010_637B:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $04237B, $C3

Data_010_643E:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $04243E, $16C

Data_010_65AA:: ; heuristic: bank from RAM variable $D7FE; C0
    db $00, $24, $41, $E7, $0B, $69, $FF, $00, $28, $41, $E7, $0B, $69, $FF, $00, $27
    db $41, $E7, $D4, $77, $FF

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
    INCBIN "dwm2-cobi-us.gbc", $042659, $2CF
    ds $16D8, $00
