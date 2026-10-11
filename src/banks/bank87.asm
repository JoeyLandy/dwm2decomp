SECTION "Bank 87", ROMX[$4000], BANK[$87]
    db $87

; only called from FieldModeStateDispatch_Case00 (E-0047)
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_Case00)
; reads: wTextWindowState, wFieldActionRequest, hPlayerStateFlags, wStepTriggerFlag, hMapId, hMapScreenX, hMapScreenY, wModeState, ...
; writes: wStepTriggerFlag, wTalkEventGroup, wTalkEventIndex, wJoypadHeld, wJoypadPressed
FieldModeStateDispatch_Case00_Sub02::
Func_087_4001:: ; address name
    ld a, [wTextWindowState]
    and a, $03
    ret nz
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ldh a, [hPlayerStateFlags]
    bit 0, a
    ret nz
    ld a, [wStepTriggerFlag]
    or a, a
    ret nz
    inc a
    ld [wStepTriggerFlag], a
    ldh a, [hMapId]
    ld l, a
    ld h, $00
    add hl, hl
    ld a, l
    add a, $A0
    ld l, a
    ld a, h
    adc a, $40
    ld h, a
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    or a, e
    ret z
    ld a, [hl]
    ld h, a
    ld l, e

Jump_087_4031::
    ld a, [hl]
    cp a, $FF
    ret z
    push hl
    or a, a
    jr nz, Jump_087_4096
    inc hl
    ld a, [hl+]
    ld c, a
    ldh a, [hMapId]
    cp a, c
    jr nz, Jump_087_4096
    ld a, [hl+]
    ld c, a
    ldh a, [hMapScreenX]
    cp a, c
    jr nz, Jump_087_4096
    ld a, [hl+]
    ld c, a
    ldh a, [hMapScreenY]
    cp a, c
    jr nz, Jump_087_4096
    ld a, [hl+]
    cp a, $FF
    jr nz, Jump_087_4057
    inc hl
    jr Jump_087_4064

Jump_087_4057::
    ld c, a
    ldh a, [hPlayerX]
    cp a, c
    jr nz, Jump_087_4096
    ld a, [hl+]
    ld c, a
    ldh a, [hPlayerY]
    cp a, c
    jr nz, Jump_087_4096

Jump_087_4064::
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    cp a, e
    jr nz, Jump_087_4071
    cp a, $FF
    jr nz, Jump_087_4071
    inc hl
    jr Jump_087_4078

Jump_087_4071::
    ld a, [hl+]
    ld d, a
    call TestFlagBit
    jr c, Jump_087_4096

Jump_087_4078::
    ld a, [hl+]
    ld [wTalkEventGroup], a
    ld a, [hl]
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    ld a, [wModeState]
    cp a, $01
    jr nz, Jump_087_4094
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a

Jump_087_4094::
    pop hl
    ret

Jump_087_4096::
    pop hl
    ld a, $0A
    add_a_to_hl
    jr Jump_087_4031
    db $33, $5D, $48, $5D, $71, $5D, $00, $00, $86, $5D, $9B, $5D, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $BA, $5D
    ds $18, $00
    db $D9, $5D, $E4, $5D, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $EF, $5D
    ds $12, $00
    db $FA, $5D, $00, $00, $00, $00, $00, $00, $00, $00, $05, $5E, $00, $00, $00, $00
    db $00, $00, $24, $5E, $00, $00, $00, $00, $00, $00, $00, $00, $2F, $5E, $44, $5E
    db $4F, $5E, $5A, $5E
    ds $20, $00
    db $65, $5E
    ds $1C, $00
    db $70, $5E, $00, $00, $7B, $5E
    ds $12, $00
    db $90, $5E
    ds $1C, $00
    db $A5, $5E, $00, $00, $00, $00, $00, $00, $B0, $5E, $00, $00, $00, $00, $00, $00
    db $00, $00, $BB, $5E
    ds $1A, $00
    db $C6, $5E, $00, $00, $00, $00, $00, $00, $00, $00, $EF, $5E
    ds $10, $00
    db $FA, $5E
    ds $1C, $00
    db $05, $5F, $00, $00, $1A, $5F
    ds $A6, $00

; only called from routines of FieldModeStateDispatch (E-0098)
; 2 call sites from 2 routines (e.g. FieldModeStateDispatch_Case00, FieldModeStateDispatch_Case05)
; reads: wTextWindowState, wFieldActionRequest, hPlayerStateFlags, wJoypadPressed, wSpriteSlotCount, hPlayerX, hPlayerY, hPlayerFacing, ...
; writes: wTalkEventGroup, wTalkEventIndex, wJoypadHeld, wJoypadPressed
FieldModeStateDispatch_Shared03::
Func_087_42A0:: ; address name
    ld a, [wTextWindowState]
    and a, $03
    ret nz
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ldh a, [hPlayerStateFlags]
    bit 0, a
    ret nz
    ld a, [wJoypadPressed]
    bit 0, a
    ret z
    ld a, [wSpriteSlotCount]
    or a, a
    jp z, Jump_087_43FC
    ldh a, [hPlayerX]
    ld b, a
    ldh a, [hPlayerY]
    ld c, a
    ldh a, [hPlayerFacing]
    or a, a
    jr z, Jump_087_42D2
    dec a
    jr z, Jump_087_42D8
    dec a
    jr z, Jump_087_42DE
    dec b
    jr Jump_087_42DF

Jump_087_42D2::
    ld a, c
    add a, $11
    ld c, a
    jr Jump_087_42DF

Jump_087_42D8::
    ld a, b
    add a, $11
    ld b, a
    jr Jump_087_42DF

Jump_087_42DE::
    dec c

Jump_087_42DF::
    call FieldModeStateDispatch_Shared03_Sub02
    or a, a
    jp z, Jump_087_43FC
    dec a
    ld c, $10
    call Multiply8
    ld a, l
    add a, $7F
    ld l, a
    ld a, h
    adc a, $CB
    ld h, a
    ld a, [hl]
    or a, a
    jr z, Jump_087_432B
    push hl
    ld a, [hl]
    cp a, $02
    jr nz, Jump_087_430E
    ld a, $0A
    add_a_to_hl
    ld a, [hl]
    bit 7, a
    jr z, Jump_087_430E
    pop hl
    jp Jump_087_43FC

Jump_087_430E::
    pop hl
    push hl
    ld a, $0B
    add_a_to_hl
    ld a, [hl]
    and a, $0F
    jr z, Jump_087_4320
    pop hl
    jp Jump_087_43FC

Jump_087_4320::
    inc hl
    ld a, [hl]
    and a, $0F
    jr z, Jump_087_432A
    pop hl
    jp Jump_087_43FC

Jump_087_432A::
    pop hl

Jump_087_432B::
    ld a, $09
    add_a_to_hl
    xor a, a
    ld [hl], a
    dec hl
    dec hl
    ldh a, [hPlayerFacing]
    add a, $02
    and a, $03
    ld [hl], a
    ld a, $08
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_087_4351
    ld a, $08
    ld [wTalkEventIndex], a
    jp Jump_087_43DC

Jump_087_4351::
    cp a, $FE
    jr nz, Jump_087_4360
    ld a, $09
    ld [wTalkEventIndex], a
    xor a, a
    ld [wTalkEventGroup], a
    jr Jump_087_43DC

Jump_087_4360::
    cp a, $FC
    jr nz, Jump_087_4370
    ld a, $09
    ld [wTalkEventIndex], a
    ld a, $02
    ld [wTalkEventGroup], a
    jr Jump_087_43DC

Jump_087_4370::
    cp a, $FB
    jr nz, Jump_087_4380
    ld a, $09
    ld [wTalkEventIndex], a
    ld a, $03
    ld [wTalkEventGroup], a
    jr Jump_087_43DC

Jump_087_4380::
    cp a, $FA
    jr nz, Jump_087_4390
    ld a, $09
    ld [wTalkEventIndex], a
    ld a, $08
    ld [wTalkEventGroup], a
    jr Jump_087_43DC

Jump_087_4390::
    ld [wTalkEventGroup], a
    ldh a, [hMapId]
    cp a, $20
    jr nc, Jump_087_43A0
    ld a, $01
    ld [wTalkEventIndex], a
    jr Jump_087_43DC

Jump_087_43A0::
    cp a, $30
    jr nc, Jump_087_43AB
    ld a, $02
    ld [wTalkEventIndex], a
    jr Jump_087_43DC

Jump_087_43AB::
    cp a, $48
    jr nc, Jump_087_43B6
    ld a, $03
    ld [wTalkEventIndex], a
    jr Jump_087_43DC

Jump_087_43B6::
    cp a, $70
    jr nc, Jump_087_43C1
    ld a, $04
    ld [wTalkEventIndex], a
    jr Jump_087_43DC

Jump_087_43C1::
    cp a, $A0
    jr nc, Jump_087_43CC
    ld a, $05
    ld [wTalkEventIndex], a
    jr Jump_087_43DC

Jump_087_43CC::
    cp a, $A8
    jr nc, Jump_087_43D7
    ld a, $06
    ld [wTalkEventIndex], a
    jr Jump_087_43DC

Jump_087_43D7::
    ld a, $07
    ld [wTalkEventIndex], a

Jump_087_43DC::
    farcall DispatchTalkEvent
    ld a, [wModeState]
    cp a, $01
    ret nz
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ld a, [wPartyWindowFlags]
    bit 7, a
    ret z
    farcall RedrawScreenBufferIfPartyWindowFlagsBit7
    ret

Jump_087_43FC::
    ld a, [wMapType]
    bit 7, a
    jr z, Jump_087_440A
    call FieldModeStateDispatch_Shared03_Sub01
    or a, a
    jr nz, Jump_087_4420
    ret

Jump_087_440A::
    ldh a, [hMapId]
    ld l, a
    ld h, $00
    add hl, hl
    ld a, l
    add a, $39
    ld l, a
    ld a, h
    adc a, $45
    ld h, a
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    or a, e
    ret z
    ld a, [hl]
    ld h, a
    ld l, e

Jump_087_4420::
    ld a, [hl]
    cp a, $FF
    ret z
    push hl
    or a, a
    jp z, Jump_087_44FC
    cp a, $05
    jr nz, Jump_087_4489
    inc hl
    ld a, [wMapType]
    bit 7, a
    jr nz, Jump_087_443D
    ld a, [hl]
    ld c, a
    ldh a, [hMapId]
    cp a, c
    jp nz, Jump_087_44FC

Jump_087_443D::
    inc hl
    ld a, [hl+]
    ld c, a
    ldh a, [hMapScreenX]
    cp a, c
    jp nz, Jump_087_44FC
    ld a, [hl+]
    ld c, a
    ldh a, [hMapScreenY]
    cp a, c
    jp nz, Jump_087_44FC
    ld a, [hl+]
    ld c, a
    ldh a, [hPlayerFacing]
    dec a
    jp nz, Jump_087_445D
    ld a, c
    sub a, $10
    ld c, a
    jp Jump_087_4466

Jump_087_445D::
    dec a
    dec a
    jp nz, Jump_087_4466
    ld a, c
    add a, $10
    ld c, a

Jump_087_4466::
    ldh a, [hPlayerX]
    cp a, c
    jp nz, Jump_087_44FC
    ld a, [hl+]
    ld c, a
    ldh a, [hPlayerFacing]
    or a, a
    jr nz, Jump_087_4479
    ld a, c
    sub a, $10
    ld c, a
    jr Jump_087_4481

Jump_087_4479::
    dec a
    dec a
    jr nz, Jump_087_4481
    ld a, c
    add a, $10
    ld c, a

Jump_087_4481::
    ldh a, [hPlayerY]
    cp a, c
    jp nz, Jump_087_44FC
    jr Jump_087_44BD

Jump_087_4489::
    dec a
    ld c, a
    ldh a, [hPlayerFacing]
    cp a, c
    jr nz, Jump_087_44FC
    inc hl
    ld a, [wMapType]
    bit 7, a
    jr nz, Jump_087_449F
    ld a, [hl]
    ld c, a
    ldh a, [hMapId]
    cp a, c
    jr nz, Jump_087_44FC

Jump_087_449F::
    inc hl
    ld a, [hl+]
    ld c, a
    ldh a, [hMapScreenX]
    cp a, c
    jp nz, Jump_087_44FC
    ld a, [hl+]
    ld c, a
    ldh a, [hMapScreenY]
    cp a, c
    jr nz, Jump_087_44FC
    ld a, [hl+]
    ld c, a
    ldh a, [hPlayerX]
    cp a, c
    jr nz, Jump_087_44FC
    ld a, [hl+]
    ld c, a
    ldh a, [hPlayerY]
    cp a, c
    jr nz, Jump_087_44FC

Jump_087_44BD::
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    cp a, e
    jr nz, Jump_087_44CA
    cp a, $FF
    jr nz, Jump_087_44CA
    inc hl
    jr Jump_087_44D1

Jump_087_44CA::
    ld a, [hl+]
    ld d, a
    call TestFlagBit
    jr c, Jump_087_44FC

Jump_087_44D1::
    ld a, [hl+]
    ld [wTalkEventGroup], a
    ld a, [hl]
    ld [wTalkEventIndex], a
    farcall DispatchTalkEvent
    ld a, [wModeState]
    cp a, $01
    jr nz, Jump_087_44FC
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ld a, [wPartyWindowFlags]
    bit 7, a
    jr z, Jump_087_44FA
    farcall RedrawScreenBufferIfPartyWindowFlagsBit7

Jump_087_44FA::
    pop hl
    ret

Jump_087_44FC::
    pop hl
    ld a, $0A
    add_a_to_hl
    jp Jump_087_4420

; only called from FieldModeStateDispatch_Shared03 (E-0047)
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_Shared03)
; reads: wKeyWorldFloor
FieldModeStateDispatch_Shared03_Sub01::
Func_087_4507:: ; address name
    cp a, $84
    jr nz, Jump_087_4511
    ld hl, SpecialMapInteractions_5D28
    ld a, $01
    ret

Jump_087_4511::
    cp a, $83
    jr nz, Jump_087_4537
    ld a, [wKeyWorldFloor]
    add a, a
    add a, a
    ld hl, wKeyWorldFloorInfo + $1
    add_a_to_hl
    ld a, [hl]
    cp a, $02
    jr nz, Jump_087_452D
    ld hl, SpecialMapInteractions_5CA4
    ld a, $01
    ret

Jump_087_452D::
    cp a, $03
    jr nz, Jump_087_4537
    ld hl, SpecialMapInteractions_5CFF
    ld a, $01
    ret

Jump_087_4537::
    xor a, a
    ret

; E-0157 (C1: FieldModeStateDispatch_Shared03 reads the word $4539 + 2 * hMapId when A is pressed (232 words, up to FieldModeStateDispatch_Shared03_Sub02 at $4709); its list of 10-byte entries ends with $FF; an entry matches on kind (0 skips; 1-4 need hPlayerFacing = kind - 1; 5 matches the tile in front), map, screen and player position; unless its story flag is set it runs DispatchTalkEvent with the group and index).
; record: list of interaction spots for this map ($0000 = none)
MapInteractionTable::
Data_087_4539:: ; address name
    dw MapInteractions00 ; id 0
    dw MapInteractions01 ; id 1
    dw MapInteractions02 ; id 2
    dw $0000 ; id 3
    dw MapInteractions04 ; id 4
    dw MapInteractions05 ; id 5
    dw MapInteractions06 ; id 6
    dw MapInteractions07 ; id 7
    dw MapInteractions08 ; id 8
    dw MapInteractions09 ; id 9
    dw $0000 ; id 10
    dw $0000 ; id 11
    dw MapInteractions0C ; id 12
    dw MapInteractions0D ; id 13
    dw MapInteractions0E ; id 14
    dw MapInteractions0F ; id 15
    dw MapInteractions10 ; id 16
    dw MapInteractions11 ; id 17
    dw MapInteractions12 ; id 18
    dw MapInteractions13 ; id 19
    dw $0000 ; id 20
    dw MapInteractions15 ; id 21
    dw MapInteractions16 ; id 22
    dw MapInteractions17 ; id 23
    dw MapInteractions18 ; id 24
    dw MapInteractions19 ; id 25
    dw MapInteractions1A ; id 26
    dw MapInteractions1B ; id 27
    dw $0000 ; id 28
    dw MapInteractions1D ; id 29
    dw $0000 ; id 30
    dw $0000 ; id 31
    dw $0000 ; id 32
    dw MapInteractions21 ; id 33
    dw MapInteractions22 ; id 34
    dw MapInteractions23 ; id 35
    dw MapInteractions24 ; id 36
    dw MapInteractions25 ; id 37
    dw $0000 ; id 38
    dw $0000 ; id 39
    dw MapInteractions28 ; id 40
    dw $0000 ; id 41
    dw MapInteractions2A ; id 42
    dw MapInteractions2B ; id 43
    dw $0000 ; id 44
    dw MapInteractions2D ; id 45
    dw MapInteractions2E ; id 46
    dw $0000 ; id 47
    dw $0000 ; id 48
    dw MapInteractions31 ; id 49
    dw MapInteractions32 ; id 50
    dw MapInteractions33 ; id 51
    dw MapInteractions34 ; id 52
    dw MapInteractions35 ; id 53
    dw $0000 ; id 54
    dw MapInteractions37 ; id 55
    dw $0000 ; id 56
    dw MapInteractions39 ; id 57
    dw MapInteractions3A ; id 58
    dw MapInteractions3B ; id 59
    dw MapInteractions3C ; id 60
    dw MapInteractions3D ; id 61
    dw MapInteractions3E ; id 62
    dw $0000 ; id 63
    dw MapInteractions40 ; id 64
    dw $0000 ; id 65
    dw MapInteractions42 ; id 66
    dw MapInteractions43 ; id 67
    dw MapInteractions44 ; id 68
    dw $0000 ; id 69
    dw $0000 ; id 70
    dw $0000 ; id 71
    dw $0000 ; id 72
    dw $0000 ; id 73
    dw MapInteractions4A ; id 74
    dw MapInteractions4B ; id 75
    dw MapInteractions4C ; id 76
    dw MapInteractions4D ; id 77
    dw $0000 ; id 78
    dw MapInteractions4F ; id 79
    dw MapInteractions50 ; id 80
    dw MapInteractions51 ; id 81
    dw $0000 ; id 82
    dw $0000 ; id 83
    dw $0000 ; id 84
    dw MapInteractions55 ; id 85
    dw $0000 ; id 86
    dw MapInteractions57 ; id 87
    dw MapInteractions58 ; id 88
    dw MapInteractions59 ; id 89
    dw MapInteractions5A ; id 90
    dw MapInteractions5B ; id 91
    dw $0000 ; id 92
    dw $0000 ; id 93
    dw MapInteractions5E ; id 94
    dw MapInteractions5F ; id 95
    dw MapInteractions60 ; id 96
    dw $0000 ; id 97
    dw MapInteractions62 ; id 98
    dw MapInteractions63 ; id 99
    dw MapInteractions64 ; id 100
    dw $0000 ; id 101
    dw MapInteractions66 ; id 102
    dw MapInteractions67 ; id 103
    dw $0000 ; id 104
    dw $0000 ; id 105
    dw $0000 ; id 106
    dw $0000 ; id 107
    dw $0000 ; id 108
    dw $0000 ; id 109
    dw $0000 ; id 110
    dw $0000 ; id 111
    dw $0000 ; id 112
    dw MapInteractions71 ; id 113
    dw MapInteractions72 ; id 114
    dw MapInteractions73 ; id 115
    dw $0000 ; id 116
    dw $0000 ; id 117
    dw MapInteractions76 ; id 118
    dw $0000 ; id 119
    dw MapInteractions78 ; id 120
    dw MapInteractions79 ; id 121
    dw MapInteractions7A ; id 122
    dw $0000 ; id 123
    dw MapInteractions7C ; id 124
    dw MapInteractions7D ; id 125
    dw MapInteractions7E ; id 126
    dw MapInteractions7F ; id 127
    dw $0000 ; id 128
    dw MapInteractions81 ; id 129
    dw MapInteractions82 ; id 130
    dw $0000 ; id 131
    dw MapInteractions84 ; id 132
    dw MapInteractions85 ; id 133
    dw $0000 ; id 134
    dw $0000 ; id 135
    dw $0000 ; id 136
    dw MapInteractions89 ; id 137
    dw $0000 ; id 138
    dw $0000 ; id 139
    dw $0000 ; id 140
    dw MapInteractions8D ; id 141
    dw MapInteractions8E ; id 142
    dw MapInteractions8F ; id 143
    dw $0000 ; id 144
    dw MapInteractions91 ; id 145
    dw $0000 ; id 146
    dw $0000 ; id 147
    dw MapInteractions94 ; id 148
    dw $0000 ; id 149
    dw MapInteractions96 ; id 150
    dw $0000 ; id 151
    dw MapInteractions98 ; id 152
    dw $0000 ; id 153
    dw MapInteractions9A ; id 154
    dw MapInteractions9B ; id 155
    dw $0000 ; id 156
    dw $0000 ; id 157
    dw $0000 ; id 158
    dw $0000 ; id 159
    dw $0000 ; id 160
    dw $0000 ; id 161
    dw $0000 ; id 162
    dw MapInteractionsA3 ; id 163
    dw $0000 ; id 164
    dw $0000 ; id 165
    dw $0000 ; id 166
    dw $0000 ; id 167
    dw $0000 ; id 168
    dw MapInteractionsA9 ; id 169
    dw $0000 ; id 170
    dw MapInteractionsAB ; id 171
    dw $0000 ; id 172
    dw MapInteractionsAD ; id 173
    dw MapInteractionsAE ; id 174
    dw $0000 ; id 175
    dw $0000 ; id 176
    dw MapInteractionsB1 ; id 177
    dw $0000 ; id 178
    dw $0000 ; id 179
    dw $0000 ; id 180
    dw $0000 ; id 181
    dw MapInteractionsB6 ; id 182
    dw $0000 ; id 183
    dw $0000 ; id 184
    dw MapInteractionsB9 ; id 185
    dw MapInteractionsBA ; id 186
    dw MapInteractionsBB ; id 187
    dw MapInteractionsBC ; id 188
    dw $0000 ; id 189
    dw MapInteractionsBE ; id 190
    dw MapInteractionsBF ; id 191
    dw MapInteractionsC0 ; id 192
    dw $0000 ; id 193
    dw MapInteractionsC2 ; id 194
    dw $0000 ; id 195
    dw MapInteractionsC4 ; id 196
    dw $0000 ; id 197
    dw $0000 ; id 198
    dw $0000 ; id 199
    dw $0000 ; id 200
    dw $0000 ; id 201
    dw MapInteractionsCA ; id 202
    dw MapInteractionsCB ; id 203
    dw MapInteractionsCC ; id 204
    dw MapInteractionsCD ; id 205
    dw MapInteractionsCE ; id 206
    dw $0000 ; id 207
    dw $0000 ; id 208
    dw $0000 ; id 209
    dw $0000 ; id 210
    dw MapInteractionsD3 ; id 211
    dw MapInteractionsD4 ; id 212
    dw MapInteractionsD5 ; id 213
    dw MapInteractionsD6 ; id 214
    dw MapInteractionsD7 ; id 215
    dw $0000 ; id 216
    dw $0000 ; id 217
    dw $0000 ; id 218
    dw $0000 ; id 219
    dw MapInteractionsDC ; id 220
    dw MapInteractionsDD ; id 221
    dw MapInteractionsDE ; id 222
    dw MapInteractionsDF ; id 223
    dw MapInteractionsE0 ; id 224
    dw $0000 ; id 225
    dw $0000 ; id 226
    dw $0000 ; id 227
    dw $0000 ; id 228
    dw $0000 ; id 229
    dw $0000 ; id 230
    dw $0000 ; id 231

; only called from FieldModeStateDispatch_Shared03 (E-0047)
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_Shared03)
; reads: wSpriteSlotCount, hTemp1, hTemp0
; writes: hTemp0, hTemp1
FieldModeStateDispatch_Shared03_Sub02::
Func_087_4709:: ; address name
    ld a, [wSpriteSlotCount]
    or a, a
    ret z
    ld a, c
    swap a
    and a, $0F
    ldh [hTemp0], a
    ld a, b
    swap a
    and a, $0F
    ldh [hTemp1], a
    ld a, [wSpriteSlotCount]
    ld b, a
    ld c, $01
    ld hl, wSpriteSlots + $B

Jump_087_4725::
    push hl
    push bc
    ld a, [hl]
    swap a
    and a, $0F
    ld c, a
    ldh a, [hTemp1]
    cp a, c
    jr nz, Jump_087_473E
    inc hl
    ld a, [hl]
    swap a
    and a, $0F
    ld c, a
    ldh a, [hTemp0]
    cp a, c
    jr z, Jump_087_474D

Jump_087_473E::
    pop bc
    inc c
    pop hl
    ld a, $10
    add_a_to_hl
    dec b
    jr nz, Jump_087_4725
    xor a, a
    ret

Jump_087_474D::
    pop bc
    pop hl
    ld a, c
    ret

; E-0157 (derived: list for entry $00 of MapInteractionTable; 4 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions00::
Data_087_4751:: ; address name
    db $05, $00, $01, $02, $70, $70 ; id 0
    dw $FFFF
    db $A3, $01
    db $04, $00, $00, $02, $30, $50 ; id 1
    dw $FFFF
    db $A2, $01
    db $03, $00, $00, $02, $70, $30 ; id 2
    dw $FFFF
    db $1B, $00
    db $01, $00, $00, $03, $40, $30 ; id 3
    dw $FFFF
    db $E5, $01
    db $FF ; end

; E-0157 (derived: list for entry $01 of MapInteractionTable; 1 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions01::
Data_087_477A:: ; address name
    db $03, $01, $02, $02, $60, $70 ; id 0
    dw $FFFF
    db $17, $0A
    db $FF ; end

; E-0157 (derived: list for entry $02 of MapInteractionTable; 6 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions02::
Data_087_4785:: ; address name
    db $03, $02, $01, $00, $30, $20 ; id 0
    dw $FFFF
    db $13, $01
    db $05, $02, $01, $00, $20, $40 ; id 1
    dw $FFFF
    db $13, $01
    db $03, $02, $01, $00, $50, $20 ; id 2
    dw $FFFF
    db $A5, $01
    db $03, $02, $00, $00, $10, $40 ; id 3
    dw $FFFF
    db $45, $01
    db $01, $02, $00, $00, $50, $40 ; id 4
    dw $FFFF
    db $AB, $01
    db $01, $02, $00, $00, $70, $40 ; id 5
    dw $FFFF
    db $AB, $01
    db $FF ; end
    db $03, $03, $00, $00, $50, $40, $02, $00, $03, $0A, $FF

; E-0157 (derived: list for entry $04 of MapInteractionTable; 5 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions04::
Data_087_47CD:: ; address name
    db $03, $04, $01, $00, $40, $30 ; id 0
    dw $FFFF
    db $65, $01
    db $03, $04, $01, $00, $50, $30 ; id 1
    dw $FFFF
    db $9D, $01
    db $05, $04, $00, $00, $40, $40 ; id 2
    dw $FFFF
    db $22, $00
    db $05, $04, $00, $00, $30, $50 ; id 3
    dw $FFFF
    db $23, $00
    db $05, $04, $00, $00, $40, $60 ; id 4
    dw $FFFF
    db $24, $00
    db $FF ; end

; E-0157 (derived: list for entry $05 of MapInteractionTable; 1 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions05::
Data_087_4800:: ; address name
    db $05, $05, $01, $00, $40, $30 ; id 0
    dw $FFFF
    db $A9, $01
    db $FF ; end

; E-0157 (derived: list for entry $06 of MapInteractionTable; 10 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions06::
Data_087_480B:: ; address name
    db $03, $06, $00, $00, $40, $10 ; id 0
    dw $FFFF
    db $03, $01
    db $03, $06, $00, $00, $30, $10 ; id 1
    dw $FFFF
    db $A0, $01
    db $03, $06, $00, $00, $60, $10 ; id 2
    dw $FFFF
    db $A1, $01
    db $05, $06, $00, $00, $20, $50 ; id 3
    dw $FFFF
    db $05, $01
    db $01, $06, $00, $00, $10, $40 ; id 4
    dw $FFFF
    db $06, $01
    db $04, $06, $00, $00, $20, $60 ; id 5
    dw $FFFF
    db $06, $01
    db $05, $06, $00, $00, $20, $70 ; id 6
    dw $FFFF
    db $06, $01
    db $03, $06, $01, $00, $40, $10 ; id 7
    dw $FFFF
    db $E6, $01
    db $03, $06, $01, $00, $30, $10 ; id 8
    dw $FFFF
    db $E6, $01
    db $03, $06, $01, $00, $60, $10 ; id 9
    dw $FFFF
    db $E6, $01
    db $FF ; end

; E-0157 (derived: list for entry $07 of MapInteractionTable; 7 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions07::
Data_087_4870:: ; address name
    db $03, $07, $00, $00, $60, $60 ; id 0
    dw $FFFF
    db $50, $01
    db $05, $07, $00, $00, $70, $10 ; id 1
    dw $FFFF
    db $D2, $01
    db $03, $07, $00, $00, $80, $20 ; id 2
    dw $FFFF
    db $D3, $01
    db $03, $07, $00, $01, $10, $30 ; id 3
    dw $FFFF
    db $51, $01
    db $05, $07, $00, $01, $20, $20 ; id 4
    dw $FFFF
    db $52, $01
    db $03, $07, $00, $01, $70, $20 ; id 5
    dw $FFFF
    db $53, $01
    db $03, $07, $00, $01, $80, $20 ; id 6
    dw $FFFF
    db $54, $01
    db $FF ; end

; E-0157 (derived: list for entry $08 of MapInteractionTable; 2 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions08::
Data_087_48B7:: ; address name
    db $03, $08, $00, $00, $40, $40 ; id 0
    dw $FFFF
    db $07, $0A
    db $03, $08, $00, $00, $60, $40 ; id 1
    dw $FFFF
    db $08, $0A
    db $FF ; end

; E-0157 (derived: list for entry $09 of MapInteractionTable; 3 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions09::
Data_087_48CC:: ; address name
    db $03, $09, $00, $00, $20, $30 ; id 0
    dw $FFFF
    db $C5, $01
    db $05, $09, $00, $00, $60, $20 ; id 1
    dw $FFFF
    db $C6, $01
    db $03, $09, $00, $00, $70, $30 ; id 2
    dw $FFFF
    db $C7, $01
    db $FF ; end

; E-0157 (derived: list for entry $0C of MapInteractionTable; 3 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions0C::
Data_087_48EB:: ; address name
    db $04, $0C, $00, $00, $20, $50 ; id 0
    dw $FFFF
    db $C9, $01
    db $04, $0C, $00, $00, $20, $60 ; id 1
    dw $FFFF
    db $CA, $01
    db $03, $0C, $01, $00, $30, $70 ; id 2
    dw $FFFF
    db $1F, $01
    db $FF ; end

; E-0157 (derived: list for entry $0D of MapInteractionTable; 4 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions0D::
Data_087_490A:: ; address name
    db $03, $0D, $01, $01, $10, $10 ; id 0
    dw $FFFF
    db $6C, $01
    db $03, $0D, $01, $01, $80, $10 ; id 1
    dw $FFFF
    db $6D, $01
    db $03, $0D, $01, $00, $50, $10 ; id 2
    dw $FFFF
    db $6E, $01
    db $01, $0D, $00, $01, $50, $70 ; id 3
    dw $012B
    db $CC, $01
    db $FF ; end

; E-0157 (derived: list for entry $0E of MapInteractionTable; 5 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions0E::
Data_087_4933:: ; address name
    db $03, $0E, $00, $00, $10, $10 ; id 0
    dw $FFFF
    db $3B, $01
    db $03, $0E, $00, $00, $20, $10 ; id 1
    dw $FFFF
    db $3C, $01
    db $03, $0E, $00, $00, $50, $20 ; id 2
    dw $FFFF
    db $3D, $01
    db $03, $0E, $00, $00, $60, $20 ; id 3
    dw $FFFF
    db $3D, $01
    db $03, $0E, $00, $00, $70, $20 ; id 4
    dw $FFFF
    db $B1, $01
    db $FF ; end

; E-0157 (derived: list for entry $0F of MapInteractionTable; 6 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions0F::
Data_087_4966:: ; address name
    db $03, $0F, $00, $00, $10, $10 ; id 0
    dw $FFFF
    db $40, $01
    db $03, $0F, $00, $00, $20, $10 ; id 1
    dw $FFFF
    db $3F, $01
    db $05, $0F, $00, $00, $10, $60 ; id 2
    dw $FFFF
    db $41, $01
    db $03, $0F, $00, $00, $60, $10 ; id 3
    dw $FFFF
    db $43, $01
    db $03, $0F, $00, $00, $70, $10 ; id 4
    dw $FFFF
    db $44, $01
    db $05, $0F, $00, $00, $80, $30 ; id 5
    dw $FFFF
    db $CB, $01
    db $FF ; end

; E-0157 (derived: list for entry $10 of MapInteractionTable; 3 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions10::
Data_087_49A3:: ; address name
    db $03, $10, $00, $00, $60, $10 ; id 0
    dw $FFFF
    db $43, $01
    db $03, $10, $00, $00, $70, $10 ; id 1
    dw $FFFF
    db $44, $01
    db $05, $10, $00, $00, $80, $30 ; id 2
    dw $FFFF
    db $CB, $01
    db $FF ; end

; E-0157 (derived: list for entry $11 of MapInteractionTable; 16 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions11::
Data_087_49C2:: ; address name
    db $05, $11, $00, $01, $70, $50 ; id 0
    dw $FFFF
    db $09, $0A
    db $02, $11, $00, $01, $20, $20 ; id 1
    dw $FFFF
    db $0A, $0A
    db $03, $11, $00, $01, $40, $40 ; id 2
    dw $FFFF
    db $0A, $0A
    db $03, $11, $00, $00, $10, $30 ; id 3
    dw $FFFF
    db $0B, $0A
    db $03, $11, $00, $00, $20, $30 ; id 4
    dw $FFFF
    db $0C, $0A
    db $03, $11, $00, $00, $30, $30 ; id 5
    dw $FFFF
    db $0D, $0A
    db $03, $11, $00, $00, $70, $30 ; id 6
    dw $FFFF
    db $0E, $0A
    db $03, $11, $00, $00, $80, $30 ; id 7
    dw $FFFF
    db $0F, $0A
    db $03, $11, $00, $00, $10, $70 ; id 8
    dw $FFFF
    db $10, $0A
    db $03, $11, $00, $00, $20, $70 ; id 9
    dw $FFFF
    db $11, $0A
    db $03, $11, $00, $00, $40, $70 ; id 10
    dw $FFFF
    db $12, $0A
    db $03, $11, $00, $00, $50, $70 ; id 11
    dw $FFFF
    db $13, $0A
    db $03, $11, $00, $00, $70, $70 ; id 12
    dw $FFFF
    db $14, $0A
    db $03, $11, $00, $00, $80, $70 ; id 13
    dw $FFFF
    db $15, $0A
    db $03, $11, $00, $00, $40, $30 ; id 14
    dw $FFFF
    db $16, $0A
    db $03, $11, $00, $00, $60, $30 ; id 15
    dw $FFFF
    db $16, $0A
    db $FF ; end

; E-0157 (derived: list for entry $12 of MapInteractionTable; 4 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions12::
Data_087_4A63:: ; address name
    db $03, $12, $00, $00, $80, $20 ; id 0
    dw $FFFF
    db $C8, $01
    db $03, $12, $00, $00, $30, $10 ; id 1
    dw $FFFF
    db $78, $01
    db $05, $12, $00, $00, $70, $10 ; id 2
    dw $FFFF
    db $79, $01
    db $05, $12, $00, $00, $50, $40 ; id 3
    dw $FFFF
    db $7A, $01
    db $FF ; end

; E-0157 (derived: list for entry $13 of MapInteractionTable; 3 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions13::
Data_087_4A8C:: ; address name
    db $03, $13, $00, $00, $10, $30 ; id 0
    dw $FFFF
    db $47, $01
    db $03, $13, $00, $00, $20, $30 ; id 1
    dw $FFFF
    db $48, $01
    db $03, $13, $00, $00, $70, $30 ; id 2
    dw $FFFF
    db $49, $01
    db $FF ; end

; E-0157 (derived: list for entry $15 of MapInteractionTable; 10 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions15::
Data_087_4AAB:: ; address name
    db $03, $15, $00, $00, $10, $10 ; id 0
    dw $FFFF
    db $90, $01
    db $03, $15, $00, $00, $20, $10 ; id 1
    dw $FFFF
    db $90, $01
    db $03, $15, $00, $00, $30, $10 ; id 2
    dw $FFFF
    db $90, $01
    db $03, $15, $00, $00, $60, $50 ; id 3
    dw $FFFF
    db $90, $01
    db $03, $15, $00, $00, $70, $50 ; id 4
    dw $FFFF
    db $90, $01
    db $03, $15, $00, $00, $80, $50 ; id 5
    dw $FFFF
    db $90, $01
    db $02, $15, $00, $00, $30, $10 ; id 6
    dw $FFFF
    db $91, $01
    db $05, $15, $00, $00, $40, $20 ; id 7
    dw $FFFF
    db $91, $01
    db $05, $15, $00, $00, $10, $60 ; id 8
    dw $FFFF
    db $91, $01
    db $03, $15, $00, $00, $60, $20 ; id 9
    dw $0030
    db $DB, $01
    db $FF ; end

; E-0157 (derived: list for entry $16 of MapInteractionTable; 5 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions16::
Data_087_4B10:: ; address name
    db $03, $16, $00, $00, $20, $20 ; id 0
    dw $FFFF
    db $74, $01
    db $03, $16, $00, $00, $30, $20 ; id 1
    dw $FFFF
    db $75, $01
    db $03, $16, $00, $00, $70, $30 ; id 2
    dw $FFFF
    db $76, $01
    db $05, $16, $00, $00, $50, $20 ; id 3
    dw $FFFF
    db $CE, $01
    db $03, $16, $00, $00, $60, $30 ; id 4
    dw $FFFF
    db $CE, $01
    db $FF ; end

; E-0157 (derived: list for entry $17 of MapInteractionTable; 1 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions17::
Data_087_4B43:: ; address name
    db $02, $17, $00, $00, $50, $40 ; id 0
    dw $FFFF
    db $86, $01
    db $FF ; end

; E-0157 (derived: list for entry $18 of MapInteractionTable; 6 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions18::
Data_087_4B4E:: ; address name
    db $04, $18, $00, $01, $30, $30 ; id 0
    dw $FFFF
    db $62, $01
    db $05, $18, $00, $01, $30, $40 ; id 1
    dw $FFFF
    db $62, $01
    db $01, $18, $00, $00, $50, $40 ; id 2
    dw $FFFF
    db $62, $01
    db $05, $18, $00, $00, $20, $60 ; id 3
    dw $FFFF
    db $63, $01
    db $05, $18, $02, $01, $70, $40 ; id 4
    dw $FFFF
    db $62, $01
    db $01, $18, $02, $01, $60, $40 ; id 5
    dw $FFFF
    db $62, $01
    db $FF ; end

; E-0157 (derived: list for entry $19 of MapInteractionTable; 14 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions19::
Data_087_4B8B:: ; address name
    db $04, $19, $00, $01, $40, $20 ; id 0
    dw $FFFF
    db $D8, $01
    db $02, $19, $00, $01, $50, $20 ; id 1
    dw $FFFF
    db $D8, $01
    db $03, $19, $00, $02, $60, $20 ; id 2
    dw $FFFF
    db $E2, $01
    db $03, $19, $00, $02, $70, $20 ; id 3
    dw $FFFF
    db $EE, $01
    db $05, $19, $00, $02, $80, $30 ; id 4
    dw $FFFF
    db $9A, $01
    db $05, $19, $00, $02, $80, $60 ; id 5
    dw $FFFF
    db $9B, $01
    db $04, $19, $00, $00, $30, $30 ; id 6
    dw $0025
    db $1B, $0A
    db $04, $19, $00, $00, $30, $50 ; id 7
    dw $0025
    db $1C, $0A
    db $04, $19, $00, $00, $30, $60 ; id 8
    dw $0025
    db $1D, $0A
    db $04, $19, $00, $00, $30, $70 ; id 9
    dw $0025
    db $1E, $0A
    db $02, $19, $00, $00, $60, $30 ; id 10
    dw $0025
    db $1F, $0A
    db $02, $19, $00, $00, $60, $40 ; id 11
    dw $0025
    db $20, $0A
    db $02, $19, $00, $00, $60, $50 ; id 12
    dw $0025
    db $21, $0A
    db $02, $19, $00, $00, $60, $70 ; id 13
    dw $0025
    db $22, $0A
    db $FF ; end

; E-0157 (derived: list for entry $1A of MapInteractionTable; 2 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions1A::
Data_087_4C18:: ; address name
    db $05, $1A, $00, $00, $30, $40 ; id 0
    dw $FFFF
    db $8B, $01
    db $02, $1A, $02, $00, $50, $50 ; id 1
    dw $FFFF
    db $1C, $00
    db $FF ; end

; E-0157 (derived: list for entry $1B of MapInteractionTable; 2 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions1B::
Data_087_4C2D:: ; address name
    db $05, $1B, $00, $02, $30, $40 ; id 0
    dw $FFFF
    db $EC, $01
    db $05, $1B, $00, $02, $60, $40 ; id 1
    dw $FFFF
    db $ED, $01
    db $FF ; end

; E-0157 (derived: list for entry $1D of MapInteractionTable; 8 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions1D::
Data_087_4C42:: ; address name
    db $04, $1D, $00, $00, $90, $30 ; id 0
    dw $FFFF
    db $18, $0A
    db $05, $1D, $00, $00, $80, $60 ; id 1
    dw $FFFF
    db $19, $0A
    db $01, $1D, $00, $00, $90, $50 ; id 2
    dw $FFFF
    db $19, $0A
    db $05, $1D, $01, $00, $10, $30 ; id 3
    dw $FFFF
    db $19, $0A
    db $03, $1D, $01, $00, $40, $30 ; id 4
    dw $FFFF
    db $19, $0A
    db $01, $1D, $01, $00, $00, $50 ; id 5
    dw $FFFF
    db $19, $0A
    db $01, $1D, $01, $00, $20, $50 ; id 6
    dw $FFFF
    db $18, $0A
    db $01, $1D, $01, $00, $30, $50 ; id 7
    dw $FFFF
    db $18, $0A
    db $FF ; end

; E-0157 (derived: list for entry $21 of MapInteractionTable; 2 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions21::
Data_087_4C93:: ; address name
    db $05, $21, $00, $00, $10, $40 ; id 0
    dw $FFFF
    db $07, $02
    db $05, $21, $01, $00, $30, $30 ; id 1
    dw $FFFF
    db $08, $02
    db $FF ; end

; E-0157 (derived: list for entry $22 of MapInteractionTable; 2 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions22::
Data_087_4CA8:: ; address name
    db $04, $22, $00, $00, $50, $40 ; id 0
    dw $FFFF
    db $0A, $02
    db $01, $22, $00, $00, $30, $20 ; id 1
    dw $FFFF
    db $0A, $02
    db $FF ; end

; E-0157 (derived: list for entry $23 of MapInteractionTable; 1 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions23::
Data_087_4CBD:: ; address name
    db $01, $23, $00, $00, $10, $40 ; id 0
    dw $FFFF
    db $1F, $02
    db $FF ; end

; E-0157 (derived: list for entry $24 of MapInteractionTable; 5 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions24::
Data_087_4CC8:: ; address name
    db $05, $24, $00, $00, $20, $70 ; id 0
    dw $FFFF
    db $19, $02
    db $03, $24, $00, $00, $80, $60 ; id 1
    dw $FFFF
    db $1D, $02
    db $03, $24, $00, $01, $70, $30 ; id 2
    dw $FFFF
    db $1E, $02
    db $02, $24, $01, $01, $60, $60 ; id 3
    dw $FFFF
    db $1A, $02
    db $04, $24, $01, $01, $60, $60 ; id 4
    dw $FFFF
    db $1B, $02
    db $FF ; end

; E-0157 (derived: list for entry $25 of MapInteractionTable; 1 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions25::
Data_087_4CFB:: ; address name
    db $03, $25, $01, $00, $50, $10 ; id 0
    dw $FFFF
    db $2A, $02
    db $FF ; end

; E-0157 (derived: list for entry $28 of MapInteractionTable; 3 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions28::
Data_087_4D06:: ; address name
    db $05, $28, $00, $00, $30, $10 ; id 0
    dw $FFFF
    db $40, $02
    db $05, $28, $00, $00, $20, $30 ; id 1
    dw $FFFF
    db $40, $02
    db $05, $28, $00, $00, $60, $40 ; id 2
    dw $FFFF
    db $40, $02
    db $FF ; end

; E-0157 (derived: list for entry $2A of MapInteractionTable; 2 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions2A::
Data_087_4D25:: ; address name
    db $02, $2A, $00, $00, $70, $60 ; id 0
    dw $FFFF
    db $42, $02
    db $02, $2A, $00, $00, $70, $70 ; id 1
    dw $FFFF
    db $3F, $02
    db $FF ; end

; E-0157 (derived: list for entry $2B of MapInteractionTable; 8 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions2B::
Data_087_4D3A:: ; address name
    db $05, $2B, $00, $01, $10, $60 ; id 0
    dw $FFFF
    db $2F, $02
    db $05, $2B, $00, $01, $20, $70 ; id 1
    dw $FFFF
    db $30, $02
    db $05, $2B, $01, $00, $80, $30 ; id 2
    dw $FFFF
    db $31, $02
    db $05, $2B, $02, $01, $60, $30 ; id 3
    dw $FFFF
    db $32, $02
    db $05, $2B, $01, $02, $20, $20 ; id 4
    dw $FFFF
    db $33, $02
    db $05, $2B, $02, $02, $60, $30 ; id 5
    dw $FFFF
    db $34, $02
    db $05, $2B, $00, $03, $30, $70 ; id 6
    dw $FFFF
    db $35, $02
    db $05, $2B, $00, $03, $50, $70 ; id 7
    dw $FFFF
    db $36, $02
    db $FF ; end

; E-0157 (derived: list for entry $2D of MapInteractionTable; 3 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions2D::
Data_087_4D8B:: ; address name
    db $03, $2D, $00, $00, $20, $40 ; id 0
    dw $005A
    db $38, $02
    db $01, $2D, $00, $00, $20, $40 ; id 1
    dw $005A
    db $1C, $02
    db $03, $2D, $00, $00, $60, $30 ; id 2
    dw $FFFF
    db $41, $02
    db $FF ; end

; E-0157 (derived: list for entry $2E of MapInteractionTable; 4 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions2E::
Data_087_4DAA:: ; address name
    db $04, $2E, $00, $00, $40, $20 ; id 0
    dw $FFFF
    db $3E, $02
    db $03, $2E, $00, $00, $40, $20 ; id 1
    dw $FFFF
    db $3E, $02
    db $02, $2E, $00, $00, $50, $20 ; id 2
    dw $FFFF
    db $3E, $02
    db $03, $2E, $00, $00, $50, $20 ; id 3
    dw $FFFF
    db $3E, $02
    db $FF ; end

; E-0157 (derived: list for entry $31 of MapInteractionTable; 8 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions31::
Data_087_4DD3:: ; address name
    db $03, $31, $00, $00, $20, $70 ; id 0
    dw $FFFF
    db $08, $03
    db $04, $31, $00, $00, $20, $70 ; id 1
    dw $FFFF
    db $09, $03
    db $05, $31, $00, $00, $80, $60 ; id 2
    dw $FFFF
    db $08, $03
    db $02, $31, $00, $00, $70, $50 ; id 3
    dw $FFFF
    db $0A, $03
    db $02, $31, $00, $01, $70, $10 ; id 4
    dw $FFFF
    db $0B, $03
    db $05, $31, $00, $01, $10, $20 ; id 5
    dw $FFFF
    db $0C, $03
    db $03, $31, $00, $01, $70, $40 ; id 6
    dw $FFFF
    db $0D, $03
    db $05, $31, $00, $01, $10, $40 ; id 7
    dw $FFFF
    db $0E, $03
    db $FF ; end

; E-0157 (derived: list for entry $32 of MapInteractionTable; 6 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions32::
Data_087_4E24:: ; address name
    db $05, $32, $01, $00, $10, $20 ; id 0
    dw $FFFF
    db $2A, $03
    db $05, $32, $01, $01, $20, $10 ; id 1
    dw $FFFF
    db $2A, $03
    db $05, $32, $01, $00, $20, $70 ; id 2
    dw $FFFF
    db $2B, $03
    db $03, $32, $00, $00, $10, $30 ; id 3
    dw $FFFF
    db $28, $03
    db $05, $32, $01, $00, $60, $20 ; id 4
    dw $FFFF
    db $29, $03
    db $05, $32, $01, $00, $80, $20 ; id 5
    dw $FFFF
    db $29, $03
    db $FF ; end

; E-0157 (derived: list for entry $33 of MapInteractionTable; 1 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions33::
Data_087_4E61:: ; address name
    db $03, $33, $00, $00, $50, $50 ; id 0
    dw $FFFF
    db $30, $03
    db $FF ; end

; E-0157 (derived: list for entry $34 of MapInteractionTable; 1 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions34::
Data_087_4E6C:: ; address name
    db $03, $34, $00, $00, $30, $30 ; id 0
    dw $FFFF
    db $2C, $03
    db $FF ; end

; E-0157 (derived: list for entry $35 of MapInteractionTable; 6 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions35::
Data_087_4E77:: ; address name
    db $05, $35, $00, $00, $50, $50 ; id 0
    dw $FFFF
    db $35, $03
    db $05, $35, $01, $00, $40, $40 ; id 1
    dw $FFFF
    db $36, $03
    db $05, $35, $03, $00, $70, $30 ; id 2
    dw $FFFF
    db $37, $03
    db $05, $35, $03, $00, $70, $50 ; id 3
    dw $FFFF
    db $38, $03
    db $05, $35, $03, $00, $70, $70 ; id 4
    dw $FFFF
    db $39, $03
    db $05, $35, $02, $03, $30, $20 ; id 5
    dw $FFFF
    db $3A, $03
    db $FF ; end

; E-0157 (derived: list for entry $37 of MapInteractionTable; 8 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions37::
Data_087_4EB4:: ; address name
    db $03, $37, $00, $00, $60, $50 ; id 0
    dw $FFFF
    db $5C, $03
    db $03, $37, $00, $00, $70, $50 ; id 1
    dw $FFFF
    db $5D, $03
    db $01, $37, $01, $00, $20, $60 ; id 2
    dw $FFFF
    db $5E, $03
    db $05, $37, $01, $00, $50, $40 ; id 3
    dw $FFFF
    db $60, $03
    db $05, $37, $01, $00, $60, $40 ; id 4
    dw $FFFF
    db $5F, $03
    db $05, $37, $01, $00, $80, $40 ; id 5
    dw $FFFF
    db $5F, $03
    db $03, $37, $02, $00, $70, $20 ; id 6
    dw $FFFF
    db $5F, $03
    db $03, $37, $02, $00, $80, $20 ; id 7
    dw $FFFF
    db $61, $03
    db $FF ; end

; E-0157 (derived: list for entry $39 of MapInteractionTable; 5 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions39::
Data_087_4F05:: ; address name
    db $05, $39, $03, $00, $20, $40 ; id 0
    dw $FFFF
    db $54, $03
    db $05, $39, $03, $00, $70, $40 ; id 1
    dw $FFFF
    db $55, $03
    db $05, $39, $03, $02, $30, $60 ; id 2
    dw $FFFF
    db $56, $03
    db $05, $39, $03, $02, $50, $60 ; id 3
    dw $FFFF
    db $57, $03
    db $05, $39, $03, $02, $70, $60 ; id 4
    dw $FFFF
    db $58, $03
    db $FF ; end

; E-0157 (derived: list for entry $3A of MapInteractionTable; 2 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions3A::
Data_087_4F38:: ; address name
    db $05, $3A, $00, $00, $40, $50 ; id 0
    dw $FFFF
    db $5A, $03
    db $05, $3A, $00, $00, $50, $50 ; id 1
    dw $FFFF
    db $5B, $03
    db $FF ; end

; E-0157 (derived: list for entry $3B of MapInteractionTable; 1 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions3B::
Data_087_4F4D:: ; address name
    db $05, $3B, $00, $00, $70, $70 ; id 0
    dw $FFFF
    db $6B, $03
    db $FF ; end

; E-0157 (derived: list for entry $3C of MapInteractionTable; 3 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions3C::
Data_087_4F58:: ; address name
    db $04, $3C, $00, $00, $50, $40 ; id 0
    dw $FFFF
    db $3D, $03
    db $03, $3C, $01, $00, $40, $50 ; id 1
    dw $FFFF
    db $18, $03
    db $03, $3C, $02, $00, $70, $60 ; id 2
    dw $FFFF
    db $19, $03
    db $FF ; end

; E-0157 (derived: list for entry $3D of MapInteractionTable; 4 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions3D::
Data_087_4F77:: ; address name
    db $03, $3D, $00, $00, $70, $30 ; id 0
    dw $FFFF
    db $14, $03
    db $01, $3D, $00, $00, $30, $60 ; id 1
    dw $FFFF
    db $59, $03
    db $01, $3D, $00, $00, $40, $60 ; id 2
    dw $FFFF
    db $59, $03
    db $01, $3D, $00, $00, $50, $60 ; id 3
    dw $FFFF
    db $59, $03
    db $FF ; end

; E-0157 (derived: list for entry $3E of MapInteractionTable; 1 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions3E::
Data_087_4FA0:: ; address name
    db $05, $3E, $01, $01, $60, $30 ; id 0
    dw $FFFF
    db $4E, $03
    db $FF ; end

; E-0157 (derived: list for entry $40 of MapInteractionTable; 2 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions40::
Data_087_4FAB:: ; address name
    db $03, $40, $00, $00, $40, $40 ; id 0
    dw $FFFF
    db $4F, $03
    db $03, $40, $00, $00, $50, $40 ; id 1
    dw $FFFF
    db $4F, $03
    db $FF ; end

; E-0157 (derived: list for entry $42 of MapInteractionTable; 5 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions42::
Data_087_4FC0:: ; address name
    db $03, $42, $00, $00, $40, $20 ; id 0
    dw $FFFF
    db $62, $03
    db $03, $42, $00, $00, $50, $20 ; id 1
    dw $FFFF
    db $63, $03
    db $03, $42, $00, $00, $60, $20 ; id 2
    dw $FFFF
    db $64, $03
    db $05, $42, $01, $00, $50, $40 ; id 3
    dw $FFFF
    db $65, $03
    db $05, $42, $02, $00, $80, $20 ; id 4
    dw $FFFF
    db $5F, $03
    db $FF ; end

; E-0157 (derived: list for entry $43 of MapInteractionTable; 10 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions43::
Data_087_4FF3:: ; address name
    db $05, $43, $00, $00, $50, $40 ; id 0
    dw $0077
    db $4C, $03
    db $04, $43, $00, $00, $30, $40 ; id 1
    dw $FFFF
    db $5F, $03
    db $05, $43, $00, $00, $60, $20 ; id 2
    dw $FFFF
    db $5F, $03
    db $05, $43, $00, $00, $90, $30 ; id 3
    dw $FFFF
    db $5F, $03
    db $02, $43, $01, $00, $10, $20 ; id 4
    dw $FFFF
    db $66, $03
    db $01, $43, $01, $00, $10, $20 ; id 5
    dw $FFFF
    db $5F, $03
    db $03, $43, $01, $00, $00, $50 ; id 6
    dw $FFFF
    db $5F, $03
    db $02, $43, $01, $00, $20, $40 ; id 7
    dw $FFFF
    db $5F, $03
    db $04, $43, $01, $00, $70, $30 ; id 8
    dw $FFFF
    db $5F, $03
    db $02, $43, $01, $00, $80, $20 ; id 9
    dw $FFFF
    db $67, $03
    db $FF ; end

; E-0157 (derived: list for entry $44 of MapInteractionTable; 8 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions44::
Data_087_5058:: ; address name
    db $03, $44, $00, $00, $60, $20 ; id 0
    dw $0076
    db $4B, $03
    db $01, $44, $00, $00, $10, $60 ; id 1
    dw $FFFF
    db $68, $03
    db $05, $44, $00, $00, $20, $70 ; id 2
    dw $FFFF
    db $68, $03
    db $05, $44, $00, $00, $60, $70 ; id 3
    dw $FFFF
    db $68, $03
    db $01, $44, $00, $00, $70, $60 ; id 4
    dw $FFFF
    db $68, $03
    db $03, $44, $00, $00, $10, $10 ; id 5
    dw $FFFF
    db $69, $03
    db $03, $44, $00, $00, $70, $10 ; id 6
    dw $FFFF
    db $69, $03
    db $03, $44, $00, $00, $80, $10 ; id 7
    dw $FFFF
    db $69, $03
    db $FF ; end

; E-0157 (derived: list for entry $4A of MapInteractionTable; 6 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions4A::
Data_087_50A9:: ; address name
    db $04, $4A, $00, $00, $40, $80 ; id 0
    dw $FFFF
    db $0E, $04
    db $04, $4A, $00, $01, $30, $70 ; id 1
    dw $FFFF
    db $0F, $04
    db $02, $4A, $00, $00, $70, $60 ; id 2
    dw $FFFF
    db $10, $04
    db $03, $4A, $00, $01, $10, $20 ; id 3
    dw $FFFF
    db $10, $04
    db $03, $4A, $01, $01, $60, $30 ; id 4
    dw $FFFF
    db $11, $04
    db $03, $4A, $01, $01, $80, $30 ; id 5
    dw $FFFF
    db $11, $04
    db $FF ; end

; E-0157 (derived: list for entry $4B of MapInteractionTable; 1 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions4B::
Data_087_50E6:: ; address name
    db $04, $4B, $00, $00, $80, $20 ; id 0
    dw $FFFF
    db $12, $04
    db $FF ; end

; E-0157 (derived: list for entry $4C of MapInteractionTable; 4 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions4C::
Data_087_50F1:: ; address name
    db $03, $4C, $01, $00, $20, $10 ; id 0
    dw $FFFF
    db $19, $04
    db $03, $4C, $01, $00, $70, $10 ; id 1
    dw $FFFF
    db $1A, $04
    db $03, $4C, $01, $01, $60, $20 ; id 2
    dw $FFFF
    db $1B, $04
    db $03, $4C, $01, $01, $70, $20 ; id 3
    dw $FFFF
    db $1B, $04
    db $FF ; end

; E-0157 (derived: list for entry $4D of MapInteractionTable; 4 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions4D::
Data_087_511A:: ; address name
    db $03, $4D, $00, $01, $60, $10 ; id 0
    dw $008A
    db $4A, $04
    db $03, $4D, $00, $01, $50, $10 ; id 1
    dw $008A
    db $4A, $04
    db $03, $4D, $00, $01, $40, $10 ; id 2
    dw $008A
    db $4A, $04
    db $03, $4D, $00, $01, $30, $10 ; id 3
    dw $008A
    db $4B, $04
    db $FF ; end

; E-0157 (derived: list for entry $4F of MapInteractionTable; 5 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions4F::
Data_087_5143:: ; address name
    db $05, $4F, $00, $00, $10, $50 ; id 0
    dw $FFFF
    db $2D, $04
    db $04, $4F, $01, $01, $20, $10 ; id 1
    dw $FFFF
    db $2D, $04
    db $04, $4F, $01, $00, $20, $20 ; id 2
    dw $FFFF
    db $2F, $04
    db $02, $4F, $01, $00, $70, $50 ; id 3
    dw $FFFF
    db $2F, $04
    db $02, $4F, $01, $01, $70, $10 ; id 4
    dw $FFFF
    db $30, $04
    db $FF ; end

; E-0157 (derived: list for entry $50 of MapInteractionTable; 3 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions50::
Data_087_5176:: ; address name
    db $04, $50, $00, $00, $40, $20 ; id 0
    dw $FFFF
    db $31, $04
    db $05, $50, $00, $00, $40, $70 ; id 1
    dw $FFFF
    db $35, $04
    db $01, $50, $00, $00, $50, $60 ; id 2
    dw $FFFF
    db $35, $04
    db $FF ; end

; E-0157 (derived: list for entry $51 of MapInteractionTable; 1 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions51::
Data_087_5195:: ; address name
    db $04, $51, $00, $00, $30, $10 ; id 0
    dw $FFFF
    db $36, $04
    db $FF ; end

; E-0157 (derived: list for entry $55 of MapInteractionTable; 1 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions55::
Data_087_51A0:: ; address name
    db $05, $55, $00, $00, $30, $40 ; id 0
    dw $FFFF
    db $47, $04
    db $FF ; end

; E-0157 (derived: list for entry $57 of MapInteractionTable; 1 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions57::
Data_087_51AB:: ; address name
    db $03, $57, $01, $00, $40, $20 ; id 0
    dw $0085
    db $45, $04
    db $FF ; end

; E-0157 (derived: list for entry $58 of MapInteractionTable; 7 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions58::
Data_087_51B6:: ; address name
    db $01, $58, $01, $00, $10, $60 ; id 0
    dw $FFFF
    db $5B, $04
    db $05, $58, $01, $00, $20, $70 ; id 1
    dw $FFFF
    db $5B, $04
    db $05, $58, $00, $01, $90, $50 ; id 2
    dw $FFFF
    db $5C, $04
    db $05, $58, $00, $00, $20, $10 ; id 3
    dw $FFFF
    db $5D, $04
    db $03, $58, $01, $00, $30, $30 ; id 4
    dw $FFFF
    db $5D, $04
    db $02, $58, $01, $00, $20, $20 ; id 5
    dw $FFFF
    db $5D, $04
    db $03, $58, $00, $01, $20, $20 ; id 6
    dw $FFFF
    db $5D, $04
    db $FF ; end

; E-0157 (derived: list for entry $59 of MapInteractionTable; 2 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions59::
Data_087_51FD:: ; address name
    db $03, $59, $00, $00, $80, $30 ; id 0
    dw $FFFF
    db $5E, $04
    db $03, $59, $00, $00, $60, $30 ; id 1
    dw $FFFF
    db $5F, $04
    db $FF ; end

; E-0157 (derived: list for entry $5A of MapInteractionTable; 1 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions5A::
Data_087_5212:: ; address name
    db $03, $5A, $01, $00, $60, $60 ; id 0
    dw $FFFF
    db $68, $04
    db $FF ; end

; E-0157 (derived: list for entry $5B of MapInteractionTable; 5 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions5B::
Data_087_521D:: ; address name
    db $03, $5B, $00, $00, $20, $10 ; id 0
    dw $FFFF
    db $94, $04
    db $03, $5B, $00, $00, $30, $10 ; id 1
    dw $FFFF
    db $95, $04
    db $03, $5B, $00, $00, $40, $10 ; id 2
    dw $FFFF
    db $96, $04
    db $03, $5B, $00, $01, $10, $20 ; id 3
    dw $FFFF
    db $97, $04
    db $03, $5B, $00, $01, $20, $20 ; id 4
    dw $FFFF
    db $97, $04
    db $FF ; end

; E-0157 (derived: list for entry $5E of MapInteractionTable; 2 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions5E::
Data_087_5250:: ; address name
    db $02, $5E, $00, $01, $80, $00 ; id 0
    dw $FFFF
    db $85, $04
    db $02, $5E, $00, $01, $70, $60 ; id 1
    dw $FFFF
    db $84, $04
    db $FF ; end

; E-0157 (derived: list for entry $5F of MapInteractionTable; 1 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions5F::
Data_087_5265:: ; address name
    db $01, $5F, $00, $00, $40, $40 ; id 0
    dw $FFFF
    db $86, $04
    db $FF ; end

; E-0157 (derived: list for entry $60 of MapInteractionTable; 1 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions60::
Data_087_5270:: ; address name
    db $03, $60, $00, $01, $20, $50 ; id 0
    dw $FFFF
    db $91, $04
    db $FF ; end

; E-0157 (derived: list for entry $62 of MapInteractionTable; 4 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions62::
Data_087_527B:: ; address name
    db $02, $62, $01, $00, $10, $20 ; id 0
    dw $FFFF
    db $9C, $04
    db $03, $62, $01, $00, $20, $30 ; id 1
    dw $FFFF
    db $9C, $04
    db $02, $62, $01, $00, $20, $30 ; id 2
    dw $FFFF
    db $9C, $04
    db $02, $62, $01, $01, $60, $20 ; id 3
    dw $FFFF
    db $9D, $04
    db $FF ; end

; E-0157 (derived: list for entry $63 of MapInteractionTable; 2 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions63::
Data_087_52A4:: ; address name
    db $05, $63, $01, $00, $10, $70 ; id 0
    dw $FFFF
    db $A2, $04
    db $05, $63, $00, $01, $80, $10 ; id 1
    dw $FFFF
    db $A3, $04
    db $FF ; end

; E-0157 (derived: list for entry $64 of MapInteractionTable; 2 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions64::
Data_087_52B9:: ; address name
    db $05, $64, $00, $00, $10, $40 ; id 0
    dw $FFFF
    db $A4, $04
    db $05, $64, $00, $00, $40, $50 ; id 1
    dw $FFFF
    db $A5, $04
    db $FF ; end

; E-0157 (derived: list for entry $66 of MapInteractionTable; 2 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions66::
Data_087_52CE:: ; address name
    db $05, $66, $00, $00, $10, $40 ; id 0
    dw $FFFF
    db $A6, $04
    db $05, $66, $00, $00, $30, $40 ; id 1
    dw $FFFF
    db $A7, $04
    db $FF ; end

; E-0157 (derived: list for entry $67 of MapInteractionTable; 2 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions67::
Data_087_52E3:: ; address name
    db $05, $67, $00, $00, $30, $70 ; id 0
    dw $FFFF
    db $A8, $04
    db $05, $67, $00, $00, $60, $70 ; id 1
    dw $FFFF
    db $A9, $04
    db $FF ; end

; E-0157 (derived: list for entry $71 of MapInteractionTable; 8 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions71::
Data_087_52F8:: ; address name
    db $03, $71, $00, $00, $10, $30 ; id 0
    dw $FFFF
    db $0C, $05
    db $03, $71, $00, $00, $30, $30 ; id 1
    dw $FFFF
    db $0C, $05
    db $03, $71, $00, $00, $10, $50 ; id 2
    dw $FFFF
    db $0C, $05
    db $03, $71, $00, $00, $20, $30 ; id 3
    dw $FFFF
    db $0C, $05
    db $03, $71, $00, $00, $10, $70 ; id 4
    dw $FFFF
    db $0C, $05
    db $03, $71, $00, $00, $20, $70 ; id 5
    dw $FFFF
    db $0C, $05
    db $03, $71, $00, $00, $20, $50 ; id 6
    dw $FFFF
    db $0D, $05
    db $01, $71, $00, $00, $20, $30 ; id 7
    dw $FFFF
    db $15, $05
    db $FF ; end

; E-0157 (derived: list for entry $72 of MapInteractionTable; 1 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions72::
Data_087_5349:: ; address name
    db $03, $72, $00, $00, $30, $30 ; id 0
    dw $FFFF
    db $0E, $05
    db $FF ; end

; E-0157 (derived: list for entry $89 of MapInteractionTable; 1 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions89::
Data_087_5354:: ; address name
    db $03, $89, $00, $01, $50, $60 ; id 0
    dw $FFFF
    db $0F, $05
    db $FF ; end

; E-0157 (derived: list for entry $73 of MapInteractionTable; 1 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions73::
Data_087_535F:: ; address name
    db $02, $73, $00, $01, $70, $20 ; id 0
    dw $FFFF
    db $10, $05
    db $FF ; end

; E-0157 (derived: list for entry $76 of MapInteractionTable; 4 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions76::
Data_087_536A:: ; address name
    db $03, $76, $00, $00, $40, $40 ; id 0
    dw $FFFF
    db $11, $05
    db $05, $76, $00, $00, $60, $50 ; id 1
    dw $FFFF
    db $11, $05
    db $05, $76, $00, $00, $30, $50 ; id 2
    dw $FFFF
    db $12, $05
    db $05, $76, $00, $00, $80, $60 ; id 3
    dw $FFFF
    db $13, $05
    db $FF ; end

; E-0157 (derived: list for entry $78 of MapInteractionTable; 6 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions78::
Data_087_5393:: ; address name
    db $04, $78, $00, $00, $20, $60 ; id 0
    dw $FFFF
    db $25, $05
    db $03, $78, $01, $00, $50, $40 ; id 1
    dw $FFFF
    db $26, $05
    db $05, $78, $00, $01, $10, $20 ; id 2
    dw $FFFF
    db $25, $05
    db $05, $78, $00, $01, $10, $40 ; id 3
    dw $FFFF
    db $25, $05
    db $01, $78, $01, $01, $50, $60 ; id 4
    dw $FFFF
    db $25, $05
    db $03, $78, $01, $01, $60, $30 ; id 5
    dw $FFFF
    db $27, $05
    db $FF ; end

; E-0157 (derived: list for entry $79 of MapInteractionTable; 1 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions79::
Data_087_53D0:: ; address name
    db $03, $79, $00, $01, $70, $30 ; id 0
    dw $FFFF
    db $28, $05
    db $FF ; end

; E-0157 (derived: list for entry $7A of MapInteractionTable; 3 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions7A::
Data_087_53DB:: ; address name
    db $04, $7A, $00, $00, $30, $30 ; id 0
    dw $FFFF
    db $2B, $05
    db $02, $7A, $00, $00, $60, $40 ; id 1
    dw $FFFF
    db $2B, $05
    db $03, $7A, $00, $00, $40, $20 ; id 2
    dw $FFFF
    db $2C, $05
    db $FF ; end

; E-0157 (derived: list for entry $7C of MapInteractionTable; 6 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions7C::
Data_087_53FA:: ; address name
    db $03, $7C, $00, $00, $30, $70 ; id 0
    dw $FFFF
    db $3C, $05
    db $02, $7C, $01, $00, $70, $30 ; id 1
    dw $FFFF
    db $3E, $05
    db $05, $7C, $01, $00, $80, $50 ; id 2
    dw $FFFF
    db $3E, $05
    db $05, $7C, $00, $01, $90, $40 ; id 3
    dw $FFFF
    db $3D, $05
    db $05, $7C, $01, $01, $00, $40 ; id 4
    dw $FFFF
    db $3D, $05
    db $02, $7C, $01, $01, $70, $50 ; id 5
    dw $FFFF
    db $3D, $05
    db $FF ; end

; E-0157 (derived: list for entry $7D of MapInteractionTable; 1 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions7D::
Data_087_5437:: ; address name
    db $04, $7D, $00, $00, $30, $10 ; id 0
    dw $FFFF
    db $3F, $05
    db $FF ; end

; E-0157 (derived: list for entry $7E of MapInteractionTable; 1 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions7E::
Data_087_5442:: ; address name
    db $03, $7E, $00, $00, $30, $30 ; id 0
    dw $FFFF
    db $43, $05
    db $FF ; end

; E-0157 (derived: list for entry $7F of MapInteractionTable; 1 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions7F::
Data_087_544D:: ; address name
    db $05, $7F, $00, $01, $70, $30 ; id 0
    dw $FFFF
    db $5B, $05
    db $FF ; end

; E-0157 (derived: list for entry $81 of MapInteractionTable; 1 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions81::
Data_087_5458:: ; address name
    db $03, $81, $00, $00, $40, $30 ; id 0
    dw $FFFF
    db $47, $05
    db $FF ; end

; E-0157 (derived: list for entry $82 of MapInteractionTable; 1 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions82::
Data_087_5463:: ; address name
    db $05, $82, $02, $02, $50, $40 ; id 0
    dw $FFFF
    db $48, $05
    db $FF ; end

; E-0157 (derived: list for entry $84 of MapInteractionTable; 1 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions84::
Data_087_546E:: ; address name
    db $02, $84, $00, $00, $50, $10 ; id 0
    dw $FFFF
    db $49, $05
    db $FF ; end

; E-0157 (derived: list for entry $85 of MapInteractionTable; 1 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions85::
Data_087_5479:: ; address name
    db $05, $85, $01, $00, $50, $20 ; id 0
    dw $FFFF
    db $4B, $05
    db $FF ; end

; E-0157 (derived: list for entry $8D of MapInteractionTable; 2 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions8D::
Data_087_5484:: ; address name
    db $03, $8D, $00, $00, $40, $20 ; id 0
    dw $00B0
    db $4D, $05
    db $03, $8D, $00, $00, $50, $20 ; id 1
    dw $00B0
    db $4D, $05
    db $FF ; end

; E-0157 (derived: list for entry $8E of MapInteractionTable; 75 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions8E::
Data_087_5499:: ; address name
    db $03, $8E, $01, $00, $40, $20 ; id 0
    dw $00B2
    db $52, $05
    db $03, $8E, $01, $00, $50, $20 ; id 1
    dw $00B2
    db $52, $05
    db $03, $8E, $00, $00, $70, $30 ; id 2
    dw $FFFF
    db $53, $05
    db $03, $8E, $00, $00, $10, $50 ; id 3
    dw $FFFF
    db $53, $05
    db $03, $8E, $00, $00, $50, $50 ; id 4
    dw $FFFF
    db $53, $05
    db $03, $8E, $00, $00, $70, $50 ; id 5
    dw $FFFF
    db $53, $05
    db $03, $8E, $00, $00, $50, $70 ; id 6
    dw $FFFF
    db $53, $05
    db $03, $8E, $00, $00, $10, $80 ; id 7
    dw $FFFF
    db $53, $05
    db $03, $8E, $01, $00, $20, $30 ; id 8
    dw $FFFF
    db $53, $05
    db $03, $8E, $01, $00, $20, $50 ; id 9
    dw $FFFF
    db $53, $05
    db $03, $8E, $01, $00, $70, $50 ; id 10
    dw $FFFF
    db $53, $05
    db $03, $8E, $01, $00, $20, $70 ; id 11
    dw $FFFF
    db $53, $05
    db $03, $8E, $01, $00, $70, $70 ; id 12
    dw $FFFF
    db $53, $05
    db $03, $8E, $02, $00, $20, $30 ; id 13
    dw $FFFF
    db $53, $05
    db $03, $8E, $02, $00, $40, $30 ; id 14
    dw $FFFF
    db $53, $05
    db $03, $8E, $02, $00, $40, $50 ; id 15
    dw $FFFF
    db $53, $05
    db $03, $8E, $02, $00, $20, $70 ; id 16
    dw $FFFF
    db $53, $05
    db $03, $8E, $02, $00, $40, $70 ; id 17
    dw $FFFF
    db $53, $05
    db $03, $8E, $00, $01, $50, $30 ; id 18
    dw $FFFF
    db $53, $05
    db $03, $8E, $00, $01, $70, $30 ; id 19
    dw $FFFF
    db $53, $05
    db $03, $8E, $00, $01, $10, $50 ; id 20
    dw $FFFF
    db $53, $05
    db $03, $8E, $00, $01, $70, $50 ; id 21
    dw $FFFF
    db $53, $05
    db $03, $8E, $00, $01, $70, $70 ; id 22
    dw $FFFF
    db $53, $05
    db $03, $8E, $00, $01, $10, $80 ; id 23
    dw $FFFF
    db $53, $05
    db $03, $8E, $01, $01, $20, $30 ; id 24
    dw $FFFF
    db $53, $05
    db $03, $8E, $01, $01, $70, $30 ; id 25
    dw $FFFF
    db $53, $05
    db $03, $8E, $01, $01, $70, $50 ; id 26
    dw $FFFF
    db $53, $05
    db $03, $8E, $01, $01, $20, $70 ; id 27
    dw $FFFF
    db $53, $05
    db $03, $8E, $02, $01, $20, $30 ; id 28
    dw $FFFF
    db $53, $05
    db $03, $8E, $02, $01, $20, $50 ; id 29
    dw $FFFF
    db $53, $05
    db $03, $8E, $02, $01, $40, $30 ; id 30
    dw $FFFF
    db $53, $05
    db $03, $8E, $02, $01, $40, $50 ; id 31
    dw $FFFF
    db $53, $05
    db $03, $8E, $02, $01, $20, $70 ; id 32
    dw $FFFF
    db $53, $05
    db $03, $8E, $02, $01, $80, $80 ; id 33
    dw $FFFF
    db $53, $05
    db $03, $8E, $00, $02, $10, $20 ; id 34
    dw $FFFF
    db $53, $05
    db $03, $8E, $00, $02, $30, $50 ; id 35
    dw $FFFF
    db $53, $05
    db $03, $8E, $02, $02, $80, $20 ; id 36
    dw $FFFF
    db $53, $05
    db $03, $8E, $02, $02, $80, $50 ; id 37
    dw $FFFF
    db $53, $05
    db $01, $8E, $02, $01, $20, $50 ; id 38
    dw $FFFF
    db $54, $05
    db $01, $8E, $00, $00, $10, $30 ; id 39
    dw $FFFF
    db $5E, $05
    db $01, $8E, $00, $00, $50, $30 ; id 40
    dw $FFFF
    db $5E, $05
    db $01, $8E, $00, $00, $70, $30 ; id 41
    dw $FFFF
    db $5E, $05
    db $01, $8E, $00, $00, $50, $50 ; id 42
    dw $FFFF
    db $5E, $05
    db $01, $8E, $00, $00, $10, $60 ; id 43
    dw $FFFF
    db $5E, $05
    db $01, $8E, $01, $00, $20, $30 ; id 44
    dw $FFFF
    db $5E, $05
    db $01, $8E, $01, $00, $70, $30 ; id 45
    dw $FFFF
    db $5E, $05
    db $01, $8E, $01, $00, $20, $50 ; id 46
    dw $FFFF
    db $5E, $05
    db $01, $8E, $01, $00, $70, $50 ; id 47
    dw $FFFF
    db $5E, $05
    db $01, $8E, $00, $01, $50, $10 ; id 48
    dw $FFFF
    db $5E, $05
    db $01, $8E, $00, $01, $70, $10 ; id 49
    dw $FFFF
    db $5E, $05
    db $01, $8E, $00, $01, $10, $30 ; id 50
    dw $FFFF
    db $5E, $05
    db $01, $8E, $00, $01, $70, $30 ; id 51
    dw $FFFF
    db $5E, $05
    db $01, $8E, $00, $01, $70, $50 ; id 52
    dw $FFFF
    db $5E, $05
    db $01, $8E, $00, $01, $10, $60 ; id 53
    dw $FFFF
    db $5E, $05
    db $01, $8E, $01, $01, $20, $10 ; id 54
    dw $FFFF
    db $5E, $05
    db $01, $8E, $01, $01, $70, $10 ; id 55
    dw $FFFF
    db $5E, $05
    db $01, $8E, $01, $01, $70, $30 ; id 56
    dw $FFFF
    db $5E, $05
    db $01, $8E, $01, $01, $20, $50 ; id 57
    dw $FFFF
    db $5E, $05
    db $01, $8E, $02, $01, $20, $10 ; id 58
    dw $FFFF
    db $5E, $05
    db $01, $8E, $02, $01, $40, $10 ; id 59
    dw $FFFF
    db $5E, $05
    db $01, $8E, $02, $01, $20, $30 ; id 60
    dw $FFFF
    db $5E, $05
    db $01, $8E, $02, $01, $40, $30 ; id 61
    dw $FFFF
    db $5E, $05
    db $01, $8E, $02, $01, $80, $60 ; id 62
    dw $FFFF
    db $5E, $05
    db $01, $8E, $00, $02, $10, $00 ; id 63
    dw $FFFF
    db $5E, $05
    db $01, $8E, $00, $02, $20, $30 ; id 64
    dw $FFFF
    db $5E, $05
    db $01, $8E, $00, $02, $30, $30 ; id 65
    dw $FFFF
    db $5E, $05
    db $01, $8E, $00, $02, $30, $60 ; id 66
    dw $FFFF
    db $5E, $05
    db $01, $8E, $00, $02, $60, $60 ; id 67
    dw $FFFF
    db $5E, $05
    db $01, $8E, $00, $02, $80, $60 ; id 68
    dw $FFFF
    db $5E, $05
    db $01, $8E, $01, $02, $10, $60 ; id 69
    dw $FFFF
    db $5E, $05
    db $01, $8E, $01, $02, $30, $60 ; id 70
    dw $FFFF
    db $5E, $05
    db $01, $8E, $01, $02, $80, $60 ; id 71
    dw $FFFF
    db $5E, $05
    db $01, $8E, $02, $02, $80, $00 ; id 72
    dw $FFFF
    db $5E, $05
    db $01, $8E, $02, $02, $80, $30 ; id 73
    dw $FFFF
    db $5E, $05
    db $01, $8E, $02, $02, $10, $60 ; id 74
    dw $FFFF
    db $5E, $05
    db $FF ; end

; E-0157 (derived: list for entry $8F of MapInteractionTable; 6 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions8F::
Data_087_5788:: ; address name
    db $03, $8F, $00, $00, $10, $10 ; id 0
    dw $00B1
    db $50, $05
    db $03, $8F, $00, $00, $20, $10 ; id 1
    dw $00B1
    db $50, $05
    db $03, $8F, $00, $00, $50, $70 ; id 2
    dw $00B1
    db $51, $05
    db $03, $8F, $00, $00, $60, $70 ; id 3
    dw $00B1
    db $51, $05
    db $03, $8F, $00, $00, $70, $70 ; id 4
    dw $00B1
    db $51, $05
    db $03, $8F, $00, $00, $80, $70 ; id 5
    dw $00B1
    db $51, $05
    db $FF ; end

; E-0157 (derived: list for entry $91 of MapInteractionTable; 1 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions91::
Data_087_57C5:: ; address name
    db $03, $91, $00, $00, $40, $30 ; id 0
    dw $FFFF
    db $56, $05
    db $FF ; end

; E-0157 (derived: list for entry $94 of MapInteractionTable; 3 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions94::
Data_087_57D0:: ; address name
    db $05, $94, $02, $00, $40, $40 ; id 0
    dw $FFFF
    db $62, $05
    db $05, $94, $01, $02, $20, $30 ; id 1
    dw $FFFF
    db $63, $05
    db $05, $94, $02, $02, $70, $30 ; id 2
    dw $FFFF
    db $63, $05
    db $FF ; end

; E-0157 (derived: list for entry $96 of MapInteractionTable; 1 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions96::
Data_087_57EF:: ; address name
    db $05, $96, $00, $00, $40, $40 ; id 0
    dw $FFFF
    db $64, $05
    db $FF ; end

; E-0157 (derived: list for entry $98 of MapInteractionTable; 1 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions98::
Data_087_57FA:: ; address name
    db $05, $98, $00, $00, $10, $60 ; id 0
    dw $FFFF
    db $65, $05
    db $FF ; end

; E-0157 (derived: list for entry $9A of MapInteractionTable; 1 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions9A::
Data_087_5805:: ; address name
    db $05, $9A, $00, $00, $80, $70 ; id 0
    dw $FFFF
    db $66, $05
    db $FF ; end

; E-0157 (derived: list for entry $9B of MapInteractionTable; 8 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractions9B::
Data_087_5810:: ; address name
    db $03, $9B, $00, $01, $40, $30 ; id 0
    dw $00C1
    db $67, $05
    db $03, $9B, $00, $01, $50, $30 ; id 1
    dw $00C1
    db $67, $05
    db $05, $9B, $00, $00, $20, $20 ; id 2
    dw $FFFF
    db $70, $05
    db $03, $9B, $00, $00, $30, $20 ; id 3
    dw $FFFF
    db $70, $05
    db $03, $9B, $00, $00, $40, $20 ; id 4
    dw $FFFF
    db $70, $05
    db $03, $9B, $00, $00, $50, $20 ; id 5
    dw $FFFF
    db $70, $05
    db $03, $9B, $00, $00, $60, $20 ; id 6
    dw $FFFF
    db $70, $05
    db $05, $9B, $00, $00, $70, $20 ; id 7
    dw $FFFF
    db $70, $05
    db $FF ; end

; E-0157 (derived: list for entry $A3 of MapInteractionTable; 2 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractionsA3::
Data_087_5861:: ; address name
    db $03, $A3, $00, $00, $40, $40 ; id 0
    dw $00D1
    db $01, $06
    db $03, $A3, $00, $00, $50, $40 ; id 1
    dw $00D1
    db $01, $06
    db $FF ; end

; E-0157 (derived: list for entry $A9 of MapInteractionTable; 7 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractionsA9::
Data_087_5876:: ; address name
    db $03, $A9, $00, $00, $20, $70 ; id 0
    dw $FFFF
    db $13, $07
    db $05, $A9, $00, $00, $30, $60 ; id 1
    dw $FFFF
    db $14, $07
    db $03, $A9, $01, $00, $10, $20 ; id 2
    dw $FFFF
    db $15, $07
    db $04, $A9, $00, $01, $40, $20 ; id 3
    dw $FFFF
    db $16, $07
    db $05, $A9, $00, $01, $30, $30 ; id 4
    dw $FFFF
    db $16, $07
    db $03, $A9, $00, $01, $10, $40 ; id 5
    dw $FFFF
    db $16, $07
    db $05, $A9, $01, $01, $80, $30 ; id 6
    dw $FFFF
    db $1B, $07
    db $FF ; end

; E-0157 (derived: list for entry $AB of MapInteractionTable; 1 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractionsAB::
Data_087_58BD:: ; address name
    db $05, $AB, $00, $00, $70, $20 ; id 0
    dw $FFFF
    db $17, $07
    db $FF ; end

; E-0157 (derived: list for entry $AD of MapInteractionTable; 1 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractionsAD::
Data_087_58C8:: ; address name
    db $05, $AD, $00, $00, $60, $40 ; id 0
    dw $FFFF
    db $18, $07
    db $FF ; end

; E-0157 (derived: list for entry $AE of MapInteractionTable; 2 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractionsAE::
Data_087_58D3:: ; address name
    db $05, $AE, $00, $02, $60, $40 ; id 0
    dw $FFFF
    db $19, $07
    db $05, $AE, $02, $03, $80, $20 ; id 1
    dw $FFFF
    db $1A, $07
    db $FF ; end

; E-0157 (derived: list for entry $B1 of MapInteractionTable; 4 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractionsB1::
Data_087_58E8:: ; address name
    db $03, $B1, $00, $00, $60, $10 ; id 0
    dw $FFFF
    db $22, $07
    db $03, $B1, $00, $00, $70, $10 ; id 1
    dw $FFFF
    db $23, $07
    db $05, $B1, $00, $00, $10, $50 ; id 2
    dw $FFFF
    db $24, $07
    db $05, $B1, $00, $00, $20, $50 ; id 3
    dw $FFFF
    db $25, $07
    db $FF ; end

; E-0157 (derived: list for entry $B6 of MapInteractionTable; 8 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractionsB6::
Data_087_5911:: ; address name
    db $05, $B6, $00, $00, $50, $20 ; id 0
    dw $FFFF
    db $2E, $07
    db $05, $B6, $00, $00, $20, $30 ; id 1
    dw $FFFF
    db $29, $07
    db $05, $B6, $00, $00, $60, $30 ; id 2
    dw $FFFF
    db $2A, $07
    db $05, $B6, $00, $00, $30, $40 ; id 3
    dw $FFFF
    db $28, $07
    db $05, $B6, $00, $00, $70, $40 ; id 4
    dw $FFFF
    db $2C, $07
    db $05, $B6, $00, $00, $10, $50 ; id 5
    dw $FFFF
    db $27, $07
    db $05, $B6, $00, $00, $60, $60 ; id 6
    dw $FFFF
    db $26, $07
    db $05, $B6, $00, $00, $20, $70 ; id 7
    dw $FFFF
    db $2B, $07
    db $FF ; end

; E-0157 (derived: list for entry $B9 of MapInteractionTable; 5 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractionsB9::
Data_087_5962:: ; address name
    db $04, $B9, $00, $00, $40, $10 ; id 0
    dw $FFFF
    db $49, $07
    db $05, $B9, $01, $01, $80, $70 ; id 1
    dw $FFFF
    db $4A, $07
    db $03, $B9, $01, $00, $30, $30 ; id 2
    dw $FFFF
    db $4B, $07
    db $03, $B9, $01, $00, $50, $30 ; id 3
    dw $FFFF
    db $4B, $07
    db $04, $B9, $00, $01, $30, $30 ; id 4
    dw $FFFF
    db $4C, $07
    db $FF ; end

; E-0157 (derived: list for entry $BA of MapInteractionTable; 4 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractionsBA::
Data_087_5995:: ; address name
    db $03, $BA, $00, $00, $70, $50 ; id 0
    dw $FFFF
    db $4D, $07
    db $05, $BA, $00, $01, $70, $50 ; id 1
    dw $FFFF
    db $4D, $07
    db $02, $BA, $00, $01, $60, $60 ; id 2
    dw $FFFF
    db $4E, $07
    db $05, $BA, $00, $01, $70, $10 ; id 3
    dw $FFFF
    db $4F, $07
    db $FF ; end

; E-0157 (derived: list for entry $BB of MapInteractionTable; 1 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractionsBB::
Data_087_59BE:: ; address name
    db $03, $BB, $00, $00, $40, $10 ; id 0
    dw $01C0
    db $2F, $07
    db $FF ; end

; E-0157 (derived: list for entry $BC of MapInteractionTable; 2 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractionsBC::
Data_087_59C9:: ; address name
    db $03, $BC, $00, $00, $30, $40 ; id 0
    dw $FFFF
    db $3D, $07
    db $04, $BC, $00, $00, $50, $20 ; id 1
    dw $FFFF
    db $3D, $07
    db $FF ; end

; E-0157 (derived: list for entry $BE of MapInteractionTable; 1 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractionsBE::
Data_087_59DE:: ; address name
    db $05, $BE, $00, $00, $50, $30 ; id 0
    dw $FFFF
    db $50, $07
    db $FF ; end

; E-0157 (derived: list for entry $BF of MapInteractionTable; 1 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractionsBF::
Data_087_59E9:: ; address name
    db $05, $BF, $01, $00, $70, $20 ; id 0
    dw $FFFF
    db $51, $07
    db $FF ; end

; E-0157 (derived: list for entry $C0 of MapInteractionTable; 1 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractionsC0::
Data_087_59F4:: ; address name
    db $05, $C0, $00, $01, $10, $70 ; id 0
    dw $FFFF
    db $52, $07
    db $FF ; end

; E-0157 (derived: list for entry $C2 of MapInteractionTable; 1 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractionsC2::
Data_087_59FF:: ; address name
    db $05, $C2, $01, $01, $40, $30 ; id 0
    dw $FFFF
    db $53, $07
    db $FF ; end

; E-0157 (derived: list for entry $C4 of MapInteractionTable; 5 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractionsC4::
Data_087_5A0A:: ; address name
    db $05, $C4, $00, $00, $30, $60 ; id 0
    dw $FFFF
    db $54, $07
    db $05, $C4, $00, $00, $20, $30 ; id 1
    dw $01CF
    db $55, $07
    db $05, $C4, $00, $00, $40, $40 ; id 2
    dw $01D0
    db $55, $07
    db $05, $C4, $00, $00, $50, $20 ; id 3
    dw $01D1
    db $55, $07
    db $05, $C4, $00, $00, $80, $50 ; id 4
    dw $01D2
    db $55, $07
    db $FF ; end

; E-0157 (derived: list for entry $CA of MapInteractionTable; 4 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractionsCA::
Data_087_5A3D:: ; address name
    db $05, $CA, $00, $00, $10, $20 ; id 0
    dw $FFFF
    db $68, $07
    db $05, $CA, $00, $00, $30, $10 ; id 1
    dw $FFFF
    db $69, $07
    db $05, $CA, $00, $00, $60, $10 ; id 2
    dw $FFFF
    db $78, $07
    db $05, $CA, $00, $00, $80, $20 ; id 3
    dw $FFFF
    db $6A, $07
    db $FF ; end

; E-0157 (derived: list for entry $CB of MapInteractionTable; 4 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractionsCB::
Data_087_5A66:: ; address name
    db $05, $CB, $00, $00, $10, $20 ; id 0
    dw $FFFF
    db $6B, $07
    db $05, $CB, $00, $00, $30, $10 ; id 1
    dw $FFFF
    db $6C, $07
    db $05, $CB, $00, $00, $60, $10 ; id 2
    dw $FFFF
    db $6D, $07
    db $05, $CB, $00, $00, $80, $20 ; id 3
    dw $FFFF
    db $78, $07
    db $FF ; end

; E-0157 (derived: list for entry $CC of MapInteractionTable; 4 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractionsCC::
Data_087_5A8F:: ; address name
    db $05, $CC, $00, $00, $10, $20 ; id 0
    dw $FFFF
    db $78, $07
    db $05, $CC, $00, $00, $30, $10 ; id 1
    dw $FFFF
    db $6E, $07
    db $05, $CC, $00, $00, $60, $10 ; id 2
    dw $FFFF
    db $6F, $07
    db $05, $CC, $00, $00, $80, $20 ; id 3
    dw $FFFF
    db $70, $07
    db $FF ; end

; E-0157 (derived: list for entry $CD of MapInteractionTable; 4 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractionsCD::
Data_087_5AB8:: ; address name
    db $05, $CD, $00, $00, $10, $20 ; id 0
    dw $FFFF
    db $71, $07
    db $05, $CD, $00, $00, $30, $10 ; id 1
    dw $FFFF
    db $72, $07
    db $05, $CD, $00, $00, $60, $10 ; id 2
    dw $FFFF
    db $73, $07
    db $05, $CD, $00, $00, $80, $20 ; id 3
    dw $FFFF
    db $78, $07
    db $FF ; end

; E-0157 (derived: list for entry $CE of MapInteractionTable; 4 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractionsCE::
Data_087_5AE1:: ; address name
    db $05, $CE, $00, $00, $20, $40 ; id 0
    dw $FFFF
    db $74, $07
    db $05, $CE, $00, $00, $30, $30 ; id 1
    dw $FFFF
    db $75, $07
    db $05, $CE, $00, $00, $60, $30 ; id 2
    dw $FFFF
    db $76, $07
    db $05, $CE, $00, $00, $70, $40 ; id 3
    dw $FFFF
    db $77, $07
    db $FF ; end

; E-0157 (derived: list for entry $D3 of MapInteractionTable; 4 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractionsD3::
Data_087_5B0A:: ; address name
    db $05, $D3, $00, $00, $10, $20 ; id 0
    dw $FFFF
    db $88, $07
    db $05, $D3, $00, $00, $30, $10 ; id 1
    dw $FFFF
    db $89, $07
    db $05, $D3, $00, $00, $60, $10 ; id 2
    dw $FFFF
    db $8A, $07
    db $05, $D3, $00, $00, $80, $20 ; id 3
    dw $FFFF
    db $78, $07
    db $FF ; end

; E-0157 (derived: list for entry $D4 of MapInteractionTable; 4 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractionsD4::
Data_087_5B33:: ; address name
    db $05, $D4, $00, $00, $10, $20 ; id 0
    dw $FFFF
    db $78, $07
    db $05, $D4, $00, $00, $30, $10 ; id 1
    dw $FFFF
    db $8B, $07
    db $05, $D4, $00, $00, $60, $10 ; id 2
    dw $FFFF
    db $8C, $07
    db $05, $D4, $00, $00, $80, $20 ; id 3
    dw $FFFF
    db $8D, $07
    db $FF ; end

; E-0157 (derived: list for entry $D5 of MapInteractionTable; 4 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractionsD5::
Data_087_5B5C:: ; address name
    db $05, $D5, $00, $00, $10, $20 ; id 0
    dw $FFFF
    db $78, $07
    db $05, $D5, $00, $00, $30, $10 ; id 1
    dw $FFFF
    db $8E, $07
    db $05, $D5, $00, $00, $60, $10 ; id 2
    dw $FFFF
    db $8F, $07
    db $05, $D5, $00, $00, $80, $20 ; id 3
    dw $FFFF
    db $90, $07
    db $FF ; end

; E-0157 (derived: list for entry $D6 of MapInteractionTable; 4 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractionsD6::
Data_087_5B85:: ; address name
    db $05, $D6, $00, $00, $10, $20 ; id 0
    dw $FFFF
    db $78, $07
    db $05, $D6, $00, $00, $30, $10 ; id 1
    dw $FFFF
    db $91, $07
    db $05, $D6, $00, $00, $60, $10 ; id 2
    dw $FFFF
    db $92, $07
    db $05, $D6, $00, $00, $80, $20 ; id 3
    dw $FFFF
    db $93, $07
    db $FF ; end

; E-0157 (derived: list for entry $D7 of MapInteractionTable; 4 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractionsD7::
Data_087_5BAE:: ; address name
    db $05, $D7, $00, $00, $20, $40 ; id 0
    dw $FFFF
    db $94, $07
    db $05, $D7, $00, $00, $30, $30 ; id 1
    dw $FFFF
    db $95, $07
    db $05, $D7, $00, $00, $60, $30 ; id 2
    dw $FFFF
    db $96, $07
    db $05, $D7, $00, $00, $70, $40 ; id 3
    dw $FFFF
    db $97, $07
    db $FF ; end

; E-0157 (derived: list for entry $DC of MapInteractionTable; 4 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractionsDC::
Data_087_5BD7:: ; address name
    db $05, $DC, $00, $00, $10, $20 ; id 0
    dw $FFFF
    db $78, $07
    db $05, $DC, $00, $00, $30, $10 ; id 1
    dw $FFFF
    db $A8, $07
    db $05, $DC, $00, $00, $60, $10 ; id 2
    dw $FFFF
    db $A9, $07
    db $05, $DC, $00, $00, $80, $20 ; id 3
    dw $FFFF
    db $AA, $07
    db $FF ; end

; E-0157 (derived: list for entry $DD of MapInteractionTable; 4 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractionsDD::
Data_087_5C00:: ; address name
    db $05, $DD, $00, $00, $10, $20 ; id 0
    dw $FFFF
    db $AB, $07
    db $05, $DD, $00, $00, $30, $10 ; id 1
    dw $FFFF
    db $AC, $07
    db $05, $DD, $00, $00, $60, $10 ; id 2
    dw $FFFF
    db $AD, $07
    db $05, $DD, $00, $00, $80, $20 ; id 3
    dw $FFFF
    db $78, $07
    db $FF ; end

; E-0157 (derived: list for entry $DE of MapInteractionTable; 4 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractionsDE::
Data_087_5C29:: ; address name
    db $05, $DE, $00, $00, $10, $20 ; id 0
    dw $FFFF
    db $78, $07
    db $05, $DE, $00, $00, $30, $10 ; id 1
    dw $FFFF
    db $AE, $07
    db $05, $DE, $00, $00, $60, $10 ; id 2
    dw $FFFF
    db $AF, $07
    db $05, $DE, $00, $00, $80, $20 ; id 3
    dw $FFFF
    db $B0, $07
    db $FF ; end

; E-0157 (derived: list for entry $DF of MapInteractionTable; 4 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractionsDF::
Data_087_5C52:: ; address name
    db $05, $DF, $00, $00, $10, $20 ; id 0
    dw $FFFF
    db $78, $07
    db $05, $DF, $00, $00, $30, $10 ; id 1
    dw $FFFF
    db $B1, $07
    db $05, $DF, $00, $00, $60, $10 ; id 2
    dw $FFFF
    db $B2, $07
    db $05, $DF, $00, $00, $80, $20 ; id 3
    dw $FFFF
    db $B3, $07
    db $FF ; end

; E-0157 (derived: list for entry $E0 of MapInteractionTable; 4 record(s), then $FF)
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
MapInteractionsE0::
Data_087_5C7B:: ; address name
    db $05, $E0, $00, $00, $20, $40 ; id 0
    dw $FFFF
    db $B4, $07
    db $05, $E0, $00, $00, $30, $30 ; id 1
    dw $FFFF
    db $B5, $07
    db $05, $E0, $00, $00, $60, $30 ; id 2
    dw $FFFF
    db $B6, $07
    db $05, $E0, $00, $00, $70, $40 ; id 3
    dw $FFFF
    db $B7, $07
    db $FF ; end

; E-0170 (C1: FieldModeStateDispatch_Shared03_Sub01 returns this list for map type $83 when the floor info byte is 2; the same 10-byte entries as MapInteractionTable's lists, ending with $FF).
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
SpecialMapInteractions_5CA4::
Data_087_5CA4:: ; address name
    db $05, $00, $00, $00, $50, $40 ; id 0
    dw $FFFF
    db $06, $09
    db $05, $00, $00, $00, $30, $70 ; id 1
    dw $FFFF
    db $04, $09
    db $05, $00, $01, $00, $70, $40 ; id 2
    dw $FFFF
    db $06, $09
    db $05, $00, $01, $01, $80, $50 ; id 3
    dw $FFFF
    db $04, $09
    db $04, $00, $00, $00, $40, $20 ; id 4
    dw $FFFF
    db $02, $09
    db $03, $00, $00, $00, $20, $40 ; id 5
    dw $FFFF
    db $02, $09
    db $02, $00, $00, $00, $10, $20 ; id 6
    dw $FFFF
    db $02, $09
    db $03, $00, $00, $00, $30, $40 ; id 7
    dw $FFFF
    db $02, $09
    db $02, $00, $01, $00, $50, $10 ; id 8
    dw $FFFF
    db $02, $09
    db $FF ; end

; E-0170 (C1: FieldModeStateDispatch_Shared03_Sub01 returns this list for map type $83 when that byte is 3; the same 10-byte entries as MapInteractionTable's lists, ending with $FF).
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
SpecialMapInteractions_5CFF::
Data_087_5CFF:: ; address name
    db $05, $00, $00, $00, $40, $30 ; id 0
    dw $FFFF
    db $04, $09
    db $05, $00, $00, $00, $60, $30 ; id 1
    dw $FFFF
    db $05, $09
    db $05, $00, $00, $00, $80, $30 ; id 2
    dw $FFFF
    db $04, $09
    db $05, $00, $01, $00, $10, $20 ; id 3
    dw $FFFF
    db $04, $09
    db $FF ; end

; E-0170 (C1: FieldModeStateDispatch_Shared03_Sub01 returns this list for map type $84; the same 10-byte entries as MapInteractionTable's lists, ending with $FF).
; record: kind (0 skip, 1-4 facing + 1, 5 any facing), map number, screen X, screen Y, player X, player Y; story flag ($FFFF = none; set = skip); talk event group, index
SpecialMapInteractions_5D28::
Data_087_5D28:: ; address name
    db $03, $00, $00, $00, $30, $40 ; id 0
    dw $FFFF
    db $07, $09
    db $FF ; end
    INCBIN "dwm2-cobi-us.gbc", $21DD33, $1F2
    ds $20DB, $00
