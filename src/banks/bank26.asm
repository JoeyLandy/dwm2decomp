SECTION "Bank 26", ROMX[$4000], BANK[$26]
    db $26

; ORs the attribute bits from Data_026_411E[hSpriteSetIndex] (when its bit 0 is set) into hSpriteAttrXor, then builds the sprite from Data_026_401E (E-0124)
; 6 call sites from 6 routines (e.g. DebugMonsterPictureViewer_Update, UpdateAndDrawSpriteSlots, AdvanceHFF99AndRunHFF8BMode_Shared01, AdvanceHFF99AndRunHFF8BMode_Case00_Sub01, ...)
; reads: hSpriteSetIndex, hSpriteAttrXor
; writes: hSpriteAttrXor
DrawMetaSpriteSet_Bank26::
Func_026_4001:: ; address name
    ldh a, [hSpriteSetIndex]
    ld e, a
    ld d, $00
    ld hl, Data_026_411E
    add hl, de
    bit 0, [hl]
    jr z, Jump_026_4017
    ld a, [hl]
    and a, $F0
    ld e, a
    ldh a, [hSpriteAttrXor]
    or a, e
    ldh [hSpriteAttrXor], a

Jump_026_4017::
    ld de, Data_026_401E
    call DrawMetaSpriteSet_Bank26_Sub01
    ret

; E-0147 (C1: DrawMetaSpriteSet_Bank26 passes DE = $26:401E to the builder, which takes the word at DE + 2 * hSpriteSetIndex as the set and the word at set + 2 * hSpriteSubIndex as the frame; 128 words up to the attribute table at $411E).
; record: meta-sprite set
MetaSprites26Table::
Data_026_401E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw MetaSprites26Set00 ; id 0
    dw MetaSprites26Set01 ; id 1
    dw MetaSprites26Set02 ; id 2
    dw MetaSprites26Set03 ; id 3
    dw MetaSprites26Set04 ; id 4
    dw MetaSprites26Set05 ; id 5
    dw MetaSprites26Set05 ; id 6
    dw MetaSprites26Set05 ; id 7
    dw MetaSprites26Set05 ; id 8
    dw MetaSprites26Set05 ; id 9
    dw MetaSprites26Set05 ; id 10
    dw MetaSprites26Set05 ; id 11
    dw MetaSprites26Set05 ; id 12
    dw MetaSprites26Set05 ; id 13
    dw MetaSprites26Set0E ; id 14
    dw MetaSprites26Set0F ; id 15
    dw MetaSprites26Set10 ; id 16
    dw MetaSprites26Set11 ; id 17
    dw MetaSprites26Set12 ; id 18
    dw MetaSprites26Set13 ; id 19
    dw MetaSprites26Set14 ; id 20
    dw MetaSprites26Set15 ; id 21
    dw MetaSprites26Set16 ; id 22
    dw MetaSprites26Set17 ; id 23
    dw MetaSprites26Set18 ; id 24
    dw MetaSprites26Set19 ; id 25
    dw MetaSprites26Set1A ; id 26
    dw MetaSprites26Set1B ; id 27
    dw MetaSprites26Set1C ; id 28
    dw MetaSprites26Set1D ; id 29
    dw MetaSprites26Set1E ; id 30
    dw MetaSprites26Set1F ; id 31
    dw MetaSprites26Set20 ; id 32
    dw MetaSprites26Set21 ; id 33
    dw MetaSprites26Set22 ; id 34
    dw MetaSprites26Set23 ; id 35
    dw MetaSprites26Set24 ; id 36
    dw MetaSprites26Set25 ; id 37
    dw MetaSprites26Set26 ; id 38
    dw MetaSprites26Set27 ; id 39
    dw MetaSprites26Set28 ; id 40
    dw MetaSprites26Set28 ; id 41
    dw MetaSprites26Set28 ; id 42
    dw MetaSprites26Set28 ; id 43
    dw MetaSprites26Set28 ; id 44
    dw MetaSprites26Set28 ; id 45
    dw MetaSprites26Set28 ; id 46
    dw MetaSprites26Set28 ; id 47
    dw MetaSprites26Set28 ; id 48
    dw MetaSprites26Set31 ; id 49
    dw MetaSprites26Set32 ; id 50
    dw MetaSprites26Set33 ; id 51
    dw MetaSprites26Set34 ; id 52
    dw MetaSprites26Set35 ; id 53
    dw MetaSprites26Set36 ; id 54
    dw MetaSprites26Set37 ; id 55
    dw MetaSprites26Set38 ; id 56
    dw MetaSprites26Set39 ; id 57
    dw MetaSprites26Set3A ; id 58
    dw MetaSprites26Set3B ; id 59
    dw MetaSprites26Set3C ; id 60
    dw MetaSprites26Set3D ; id 61
    dw MetaSprites26Set3E ; id 62
    dw MetaSprites26Set3F ; id 63
    dw MetaSprites26Set40 ; id 64
    dw MetaSprites26Set41 ; id 65
    dw MetaSprites26Set42 ; id 66
    dw MetaSprites26Set43 ; id 67
    dw MetaSprites26Set44 ; id 68
    dw MetaSprites26Set45 ; id 69
    dw MetaSprites26Set46 ; id 70
    dw MetaSprites26Set47 ; id 71
    dw MetaSprites26Set48 ; id 72
    dw MetaSprites26Set49 ; id 73
    dw MetaSprites26Set4A ; id 74
    dw MetaSprites26Set4A ; id 75
    dw MetaSprites26Set4A ; id 76
    dw MetaSprites26Set4A ; id 77
    dw MetaSprites26Set4A ; id 78
    dw MetaSprites26Set4A ; id 79
    dw MetaSprites26Set4A ; id 80
    dw MetaSprites26Set4A ; id 81
    dw MetaSprites26Set4A ; id 82
    dw MetaSprites26Set4A ; id 83
    dw MetaSprites26Set54 ; id 84
    dw MetaSprites26Set55 ; id 85
    dw MetaSprites26Set56 ; id 86
    dw MetaSprites26Set57 ; id 87
    dw MetaSprites26Set58 ; id 88
    dw MetaSprites26Set59 ; id 89
    dw MetaSprites26Set5A ; id 90
    dw MetaSprites26Set5B ; id 91
    dw MetaSprites26Set5C ; id 92
    dw MetaSprites26Set5D ; id 93
    dw MetaSprites26Set5E ; id 94
    dw MetaSprites26Set5F ; id 95
    dw MetaSprites26Set60 ; id 96
    dw MetaSprites26Set61 ; id 97
    dw MetaSprites26Set62 ; id 98
    dw MetaSprites26Set63 ; id 99
    dw MetaSprites26Set64 ; id 100
    dw MetaSprites26Set65 ; id 101
    dw MetaSprites26Set66 ; id 102
    dw MetaSprites26Set67 ; id 103
    dw MetaSprites26Set68 ; id 104
    dw MetaSprites26Set69 ; id 105
    dw MetaSprites26Set6A ; id 106
    dw MetaSprites26Set6B ; id 107
    dw MetaSprites26Set6C ; id 108
    dw MetaSprites26Set6D ; id 109
    dw MetaSprites26Set6E ; id 110
    dw MetaSprites26Set6F ; id 111
    dw MetaSprites26Set70 ; id 112
    dw MetaSprites26Set71 ; id 113
    dw MetaSprites26Set71 ; id 114
    dw MetaSprites26Set71 ; id 115
    dw MetaSprites26Set71 ; id 116
    dw MetaSprites26Set71 ; id 117
    dw MetaSprites26Set71 ; id 118
    dw MetaSprites26Set77 ; id 119
    dw MetaSprites26Set78 ; id 120
    dw MetaSprites26Set79 ; id 121
    dw MetaSprites26Set7A ; id 122
    dw MetaSprites26Set7B ; id 123
    dw MetaSprites26Set7C ; id 124
    dw MetaSprites26Set7D ; id 125
    dw MetaSprites26Set7E ; id 126
    dw MetaSprites26Set7F ; id 127

; E-0147 (C1: DrawMetaSpriteSet_Bank26 reads the byte $411E + hSpriteSetIndex; when bit 0 is set it ORs its high nibble into hSpriteAttrXor before drawing).
; record: bit 0 set: OR the high nibble into hSpriteAttrXor
MetaSprites26Attrs::
Data_026_411E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00 ; id 0
    db $00 ; id 1
    db $01 ; id 2
    db $11 ; id 3
    db $01 ; id 4
    db $00 ; id 5
    db $00 ; id 6
    db $00 ; id 7
    db $00 ; id 8
    db $00 ; id 9
    db $00 ; id 10
    db $00 ; id 11
    db $00 ; id 12
    db $00 ; id 13
    db $11 ; id 14
    db $10 ; id 15
    db $10 ; id 16
    db $11 ; id 17
    db $00 ; id 18
    db $10 ; id 19
    db $10 ; id 20
    db $01 ; id 21
    db $10 ; id 22
    db $11 ; id 23
    db $10 ; id 24
    db $10 ; id 25
    db $11 ; id 26
    db $10 ; id 27
    db $00 ; id 28
    db $00 ; id 29
    db $10 ; id 30
    db $10 ; id 31
    db $11 ; id 32
    db $01 ; id 33
    db $00 ; id 34
    db $01 ; id 35
    db $01 ; id 36
    db $00 ; id 37
    db $01 ; id 38
    db $01 ; id 39
    db $00 ; id 40
    db $00 ; id 41
    db $00 ; id 42
    db $00 ; id 43
    db $00 ; id 44
    db $00 ; id 45
    db $00 ; id 46
    db $00 ; id 47
    db $00 ; id 48
    db $00 ; id 49
    db $00 ; id 50
    db $00 ; id 51
    db $00 ; id 52
    db $00 ; id 53
    db $00 ; id 54
    db $00 ; id 55
    db $01 ; id 56
    db $10 ; id 57
    db $00 ; id 58
    db $00 ; id 59
    db $11 ; id 60
    db $00 ; id 61
    db $00 ; id 62
    db $00 ; id 63
    db $00 ; id 64
    db $00 ; id 65
    db $01 ; id 66
    db $01 ; id 67
    db $10 ; id 68
    db $01 ; id 69
    db $10 ; id 70
    db $10 ; id 71
    db $11 ; id 72
    db $11 ; id 73
    db $00 ; id 74
    db $00 ; id 75
    db $00 ; id 76
    db $00 ; id 77
    db $00 ; id 78
    db $00 ; id 79
    db $00 ; id 80
    db $00 ; id 81
    db $00 ; id 82
    db $00 ; id 83
    db $10 ; id 84
    db $00 ; id 85
    db $00 ; id 86
    db $00 ; id 87
    db $10 ; id 88
    db $00 ; id 89
    db $00 ; id 90
    db $01 ; id 91
    db $00 ; id 92
    db $00 ; id 93
    db $00 ; id 94
    db $00 ; id 95
    db $00 ; id 96
    db $00 ; id 97
    db $00 ; id 98
    db $00 ; id 99
    db $00 ; id 100
    db $01 ; id 101
    db $00 ; id 102
    db $10 ; id 103
    db $00 ; id 104
    db $01 ; id 105
    db $00 ; id 106
    db $00 ; id 107
    db $00 ; id 108
    db $00 ; id 109
    db $00 ; id 110
    db $01 ; id 111
    db $01 ; id 112
    db $00 ; id 113
    db $00 ; id 114
    db $00 ; id 115
    db $00 ; id 116
    db $00 ; id 117
    db $00 ; id 118
    db $00 ; id 119
    db $00 ; id 120
    db $10 ; id 121
    db $10 ; id 122
    db $10 ; id 123
    db $10 ; id 124
    db $00 ; id 125
    db $01 ; id 126
    db $00 ; id 127

; only called from DrawMetaSpriteSet_Bank26 (E-0047)
; 1 call site from 1 routine (e.g. DrawMetaSpriteSet_Bank26)
; reads: hOamNextEntry, hSpriteScrollYLo, hSpriteScrollYHi, hSpriteOriginY, hSpriteOriginYHi, hSpriteScrollXLo, hSpriteScrollXHi, hSpriteOriginX, ...
; writes: hMetaSpriteYLo, hMetaSpriteYHi, hOamNextEntry
; points at: hMetaSpriteXLo
DrawMetaSpriteSet_Bank26_Sub01::
Func_026_419E:: ; address name
    ldh a, [hOamNextEntry]
    cp a, $27
    ret nc
    ldh a, [hSpriteScrollYLo]
    ld c, a
    ldh a, [hSpriteScrollYHi]
    ld b, a
    ldh a, [hSpriteOriginY]
    add a, c
    ldh [hMetaSpriteYLo], a
    ldh a, [hSpriteOriginYHi]
    adc a, b
    ldh [hMetaSpriteYHi], a
    ldh a, [hSpriteScrollXLo]
    ld c, a
    ldh a, [hSpriteScrollXHi]
    ld b, a
    ld hl, hMetaSpriteXLo
    ldh a, [hSpriteOriginX]
    add a, c
    ld c, a
    ld [hl+], a
    ldh a, [hSpriteOriginXHi]
    adc a, b
    ld b, a
    ld [hl+], a
    ld a, c
    sub a, $08
    ld [hl+], a
    ld a, b
    sbc a, $00
    ld [hl], a
    ldh a, [hSpriteSetIndex]
    add a, a
    add a, e
    ld l, a
    ld a, $00
    adc a, d
    ld h, a
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ldh a, [hSpriteSubIndex]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, de
    deref_hl
    ldh a, [hOamNextEntry]
    add a, a
    add a, a
    ld e, a
    ld d, $C0
    ldh a, [hSpriteWindowClipMode]
    or a, a
    jp nz, Jump_026_42E8
    ldh a, [hSpriteTileOffset]
    ld c, a
    ldh a, [hSpriteAttrXor]
    and a, $20
    jr nz, Jump_026_4270

Jump_026_41FA::
    ld a, [hl+]
    cp a, $80
    ret z
    ld b, a
    jr nc, Jump_026_4212
    ldh a, [hMetaSpriteYLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteYHi]
    adc a, $00
    jr nz, Jump_026_4221
    ld a, b
    cp a, $A8
    jr c, Jump_026_4226
    jr Jump_026_4221

Jump_026_4212::
    ldh a, [hMetaSpriteYLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteYHi]
    adc a, $FF
    jr nz, Jump_026_4221
    ld a, b
    cp a, $A8
    jr c, Jump_026_4226

Jump_026_4221::
    inc hl
    inc hl
    inc hl
    jr Jump_026_41FA

Jump_026_4226::
    ld a, b
    ld [de], a
    inc e
    ld a, [hl+]
    ld b, a
    rlca
    jr c, Jump_026_423F
    ldh a, [hMetaSpriteXLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteXHi]
    adc a, $00
    jr nz, Jump_026_424E
    ld a, b
    cp a, $B8
    jr c, Jump_026_4255
    jr Jump_026_424E

Jump_026_423F::
    ldh a, [hMetaSpriteXLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteXHi]
    adc a, $FF
    jr nz, Jump_026_424E
    ld a, b
    cp a, $B8
    jr c, Jump_026_4255

Jump_026_424E::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_026_41FA

Jump_026_4255::
    ld a, b
    ld [de], a
    inc e
    ldh a, [hSpriteTileOffset]
    ld c, a
    ld a, [hl+]
    add a, c
    ld [de], a
    inc e
    ldh a, [hSpriteAttrXor]
    ld c, a
    ld a, [hl+]
    xor a, c
    ld [de], a
    inc e
    ldh a, [hOamNextEntry]
    inc a
    ldh [hOamNextEntry], a
    cp a, $28
    jr nz, Jump_026_41FA
    ret

Jump_026_4270::
    ld a, [hl+]
    cp a, $80
    ret z
    ld b, a
    jr nc, Jump_026_4288
    ldh a, [hMetaSpriteYLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteYHi]
    adc a, $00
    jr nz, Jump_026_4297
    ld a, b
    cp a, $A8
    jr c, Jump_026_429C
    jr Jump_026_4297

Jump_026_4288::
    ldh a, [hMetaSpriteYLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteYHi]
    adc a, $FF
    jr nz, Jump_026_4297
    ld a, b
    cp a, $A8
    jr c, Jump_026_429C

Jump_026_4297::
    inc hl
    inc hl
    inc hl
    jr Jump_026_4270

Jump_026_429C::
    ld a, b
    ld [de], a
    inc e
    ld a, [hl+]
    ld b, a
    rlca
    jr c, Jump_026_42B7
    ldh a, [hMetaSpriteXFlipLo]
    sub a, b
    ld b, a
    ldh a, [hMetaSpriteXFlipHi]
    sbc a, $00
    jr z, Jump_026_42CD
    jr nz, Jump_026_42C6
    ld a, b
    cp a, $B8
    jr c, Jump_026_42CD
    jr Jump_026_42C6

Jump_026_42B7::
    ldh a, [hMetaSpriteXFlipLo]
    sub a, b
    ld b, a
    ldh a, [hMetaSpriteXFlipHi]
    sbc a, $FF
    jr nz, Jump_026_42C6
    ld a, b
    cp a, $B8
    jr c, Jump_026_42CD

Jump_026_42C6::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_026_4270

Jump_026_42CD::
    ld a, b
    ld [de], a
    inc e
    ldh a, [hSpriteTileOffset]
    ld c, a
    ld a, [hl+]
    add a, c
    ld [de], a
    inc e
    ldh a, [hSpriteAttrXor]
    ld c, a
    ld a, [hl+]
    xor a, c
    ld [de], a
    inc e
    ldh a, [hOamNextEntry]
    inc a
    ldh [hOamNextEntry], a
    cp a, $28
    jr nz, Jump_026_4270
    ret

Jump_026_42E8::
    ldh a, [hSpriteAttrXor]
    and a, $20
    jr nz, Jump_026_4369

Jump_026_42EE::
    ld a, [hl+]
    cp a, $80
    ret z
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_026_42F9
    dec b

Jump_026_42F9::
    ldh a, [hMetaSpriteYLo]
    add a, c
    ld c, a
    ldh a, [hMetaSpriteYHi]
    adc a, b
    jr nz, Jump_026_4324
    ld a, c
    cp a, $B8
    jr nc, Jump_026_4324
    ldh a, [hSpriteWindowClipMode]
    or a, a
    jr z, Jump_026_4329
    cp a, $01
    jr nz, Jump_026_4317
    ld a, c
    cp a, $34
    jr c, Jump_026_4324
    jr Jump_026_4329

Jump_026_4317::
    cp a, $02
    jr nz, Jump_026_4322
    ld a, c
    cp a, $71
    jr c, Jump_026_4329
    jr Jump_026_4324

Jump_026_4322::
    jr Jump_026_4329

Jump_026_4324::
    inc hl
    inc hl
    inc hl
    jr Jump_026_42EE

Jump_026_4329::
    ld a, c
    ld [de], a
    inc e
    ld a, [hl+]
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_026_4334
    dec b

Jump_026_4334::
    ldh a, [hMetaSpriteXLo]
    add a, c
    ld c, a
    ldh a, [hMetaSpriteXHi]
    adc a, b
    jr nz, Jump_026_4342
    ld a, c
    cp a, $B8
    jr c, Jump_026_4349

Jump_026_4342::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_026_42EE

Jump_026_4349::
    ld a, c
    ld [de], a
    call BGTileUnderPointIsHFFBA_Bank26
    jr nc, Jump_026_4342
    inc e
    ldh a, [hSpriteTileOffset]
    ld b, a
    ld a, [hl+]
    add a, b
    ld [de], a
    inc e
    ldh a, [hSpriteAttrXor]
    ld c, a
    ld a, [hl+]
    xor a, c
    ld [de], a
    inc e
    ldh a, [hOamNextEntry]
    inc a
    ldh [hOamNextEntry], a
    cp a, $28
    jr nz, Jump_026_42EE
    ret

Jump_026_4369::
    ld a, [hl+]
    cp a, $80
    ret z
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_026_4374
    dec b

Jump_026_4374::
    ldh a, [hMetaSpriteYLo]
    add a, c
    ld c, a
    ldh a, [hMetaSpriteYHi]
    adc a, b
    jr nz, Jump_026_439F
    ld a, c
    cp a, $B8
    jr nc, Jump_026_439F
    ldh a, [hSpriteWindowClipMode]
    or a, a
    jr z, Jump_026_43A4
    cp a, $01
    jr nz, Jump_026_4392
    ld a, c
    cp a, $34
    jr c, Jump_026_439F
    jr Jump_026_43A4

Jump_026_4392::
    cp a, $02
    jr nz, Jump_026_439D
    ld a, c
    cp a, $71
    jr c, Jump_026_43A4
    jr Jump_026_439F

Jump_026_439D::
    jr Jump_026_43A4

Jump_026_439F::
    inc hl
    inc hl
    inc hl
    jr Jump_026_4369

Jump_026_43A4::
    ld a, c
    ld [de], a
    inc e
    ld a, [hl+]
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_026_43AF
    dec b

Jump_026_43AF::
    ldh a, [hMetaSpriteXFlipLo]
    sub a, c
    ld c, a
    ldh a, [hMetaSpriteXFlipHi]
    sbc a, b
    jr nz, Jump_026_43BD
    ld a, c
    cp a, $B8
    jr c, Jump_026_43C4

Jump_026_43BD::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_026_4369

Jump_026_43C4::
    ld a, c
    ld [de], a
    call BGTileUnderPointIsHFFBA_Bank26
    jr nc, Jump_026_43BD
    inc e
    ldh a, [hSpriteTileOffset]
    ld b, a
    ld a, [hl+]
    add a, b
    ld [de], a
    inc e
    ldh a, [hSpriteAttrXor]
    ld c, a
    ld a, [hl+]
    xor a, c
    ld [de], a
    inc e
    ldh a, [hOamNextEntry]
    inc a
    ldh [hOamNextEntry], a
    cp a, $28
    jr nz, Jump_026_4369
    ret

; DE = address of an X byte with its Y byte at DE - 1 (screen coordinates): HL = the $9800 BG map entry under (X + hScrollX - 4, Y + hScrollY - 12), rows wrapping inside the map; reads it after rSTAT bit 1 clears (interrupts off) and compares with hFFBA: Z set when equal, A = the tile; BC, HL kept (E-0065) (the same 54 bytes appear in 6 banks)
; 2 call sites from 1 routine (e.g. DrawMetaSpriteSet_Bank26_Sub01)
; reads: hScrollY, hScrollX, hSpriteHideTile, rSTAT
BGTileUnderPointIsHFFBA_Bank26::
Func_026_43E4:: ; address name
    push hl
    push bc
    ldh a, [hScrollY]
    ld b, a
    dec e
    ld a, [de]
    inc e
    add a, b
    sub a, $0C
    and a, $F8
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ldh a, [hScrollX]
    ld b, a
    ld a, [de]
    add a, b
    sub a, $04
    and a, $F8
    rrca
    rrca
    rrca
    add a, l
    ld l, a
    ld a, h
    and a, $03
    adc a, $98
    ld h, a
    ldh a, [hSpriteHideTile]
    ld b, a
    di

Jump_026_440E::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_026_440E
    ld a, [hl]
    ei
    cp a, b
    pop bc
    pop hl
    ret

; E-0147 (derived: meta-sprite set 0 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set00::
Data_026_441A:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set00Frame0 ; entry 0
    dw MetaSprites26Set00Frame1 ; entry 1
    dw MetaSprites26Set00Frame2 ; entry 2
    dw MetaSprites26Set00Frame3 ; entry 3
    dw MetaSprites26Set00Frame4 ; entry 4
    dw MetaSprites26Set00Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set00Frame0::
Data_026_4426:: ; heuristic: meta-sprite frame; C0
    db $EE, $F8, $00, $00 ; entry 0
    db $EE, $00, $01, $00 ; entry 1
    db $F6, $F8, $02, $00 ; entry 2
    db $F6, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set00Frame1::
Data_026_4437:: ; heuristic: meta-sprite frame; C0
    db $F0, $FF, $00, $20 ; entry 0
    db $F0, $F7, $01, $20 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set00Frame2::
Data_026_4448:: ; heuristic: meta-sprite frame; C0
    db $EE, $F8, $04, $00 ; entry 0
    db $EE, $00, $05, $00 ; entry 1
    db $F6, $F8, $06, $00 ; entry 2
    db $F6, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set00Frame3::
Data_026_4459:: ; heuristic: meta-sprite frame; C0
    db $F8, $F8, $09, $00 ; entry 0
    db $F8, $00, $0A, $00 ; entry 1
    db $F0, $F8, $08, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set00Frame4::
Data_026_446A:: ; heuristic: meta-sprite frame; C0
    db $EE, $F8, $0B, $00 ; entry 0
    db $EE, $00, $0C, $00 ; entry 1
    db $F6, $F8, $0D, $00 ; entry 2
    db $F6, $00, $0E, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set00Frame5::
Data_026_447B:: ; heuristic: meta-sprite frame; C0
    db $F0, $FF, $0B, $20 ; entry 0
    db $F0, $F7, $0C, $20 ; entry 1
    db $F8, $FF, $0D, $20 ; entry 2
    db $F8, $F7, $0E, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 1 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set01::
Data_026_448C:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set01Frame0 ; entry 0
    dw MetaSprites26Set01Frame1 ; entry 1
    dw MetaSprites26Set01Frame2 ; entry 2
    dw MetaSprites26Set01Frame3 ; entry 3
    dw MetaSprites26Set01Frame4 ; entry 4
    dw MetaSprites26Set01Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set01Frame0::
Data_026_4498:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set01Frame1::
Data_026_44A9:: ; heuristic: meta-sprite frame; C0
    db $EE, $F8, $02, $00 ; entry 0
    db $EE, $00, $02, $20 ; entry 1
    db $F6, $F8, $03, $00 ; entry 2
    db $F6, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set01Frame2::
Data_026_44BA:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $04, $00 ; entry 0
    db $F1, $00, $05, $00 ; entry 1
    db $F9, $F8, $06, $00 ; entry 2
    db $F9, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set01Frame3::
Data_026_44CB:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $08, $00 ; entry 0
    db $F8, $F8, $09, $00 ; entry 1
    db $F0, $00, $05, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set01Frame4::
Data_026_44DC:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $0A, $00 ; entry 0
    db $F1, $00, $0A, $20 ; entry 1
    db $F9, $F8, $0B, $00 ; entry 2
    db $F9, $00, $0B, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set01Frame5::
Data_026_44ED:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0C, $20 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 2 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set02::
Data_026_44FE:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set02Frame0 ; entry 0
    dw MetaSprites26Set02Frame1 ; entry 1
    dw MetaSprites26Set02Frame2 ; entry 2
    dw MetaSprites26Set02Frame3 ; entry 3
    dw MetaSprites26Set02Frame4 ; entry 4
    dw MetaSprites26Set02Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set02Frame0::
Data_026_450A:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set02Frame1::
Data_026_451B:: ; heuristic: meta-sprite frame; C0
    db $EF, $FF, $00, $20 ; entry 0
    db $EF, $F8, $00, $00 ; entry 1
    db $F7, $FF, $01, $20 ; entry 2
    db $F7, $F7, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set02Frame2::
Data_026_452C:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $03, $00 ; entry 0
    db $F0, $00, $04, $00 ; entry 1
    db $F8, $F8, $05, $00 ; entry 2
    db $F8, $00, $06, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set02Frame3::
Data_026_453D:: ; heuristic: meta-sprite frame; C0
    db $EF, $F8, $03, $00 ; entry 0
    db $EF, $00, $04, $00 ; entry 1
    db $F7, $F8, $07, $00 ; entry 2
    db $F7, $00, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set02Frame4::
Data_026_454E:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $09, $00 ; entry 0
    db $F0, $00, $0A, $00 ; entry 1
    db $F8, $F8, $0B, $00 ; entry 2
    db $F8, $00, $0C, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set02Frame5::
Data_026_455F:: ; heuristic: meta-sprite frame; C0
    db $EF, $01, $09, $20 ; entry 0
    db $EF, $F9, $0A, $20 ; entry 1
    db $F7, $01, $0B, $20 ; entry 2
    db $F7, $F9, $0C, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 3 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set03::
Data_026_4570:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set03Frame0 ; entry 0
    dw MetaSprites26Set03Frame1 ; entry 1
    dw MetaSprites26Set03Frame2 ; entry 2
    dw MetaSprites26Set03Frame3 ; entry 3
    dw MetaSprites26Set03Frame4 ; entry 4
    dw MetaSprites26Set03Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set03Frame0::
Data_026_457C:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set03Frame1::
Data_026_458D:: ; heuristic: meta-sprite frame; C0
    db $EF, $00, $00, $20 ; entry 0
    db $EF, $F8, $01, $20 ; entry 1
    db $F7, $00, $02, $20 ; entry 2
    db $F7, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set03Frame2::
Data_026_459E:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set03Frame3::
Data_026_45AF:: ; heuristic: meta-sprite frame; C0
    db $EF, $00, $05, $00 ; entry 0
    db $F7, $F8, $09, $00 ; entry 1
    db $F7, $00, $0A, $00 ; entry 2
    db $EF, $F8, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set03Frame4::
Data_026_45C0:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $00, $0B, $20 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set03Frame5::
Data_026_45D1:: ; heuristic: meta-sprite frame; C0
    db $EF, $00, $0B, $20 ; entry 0
    db $EF, $F8, $0B, $00 ; entry 1
    db $F7, $00, $0C, $20 ; entry 2
    db $F7, $F8, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 4 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set04::
Data_026_45E2:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set04Frame0 ; entry 0
    dw MetaSprites26Set04Frame1 ; entry 1
    dw MetaSprites26Set04Frame2 ; entry 2
    dw MetaSprites26Set04Frame3 ; entry 3
    dw MetaSprites26Set04Frame4 ; entry 4
    dw MetaSprites26Set04Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set04Frame0::
Data_026_45EE:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set04Frame1::
Data_026_45FF:: ; heuristic: meta-sprite frame; C0
    db $F1, $00, $00, $20 ; entry 0
    db $F1, $F8, $01, $20 ; entry 1
    db $F9, $00, $02, $20 ; entry 2
    db $F9, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set04Frame2::
Data_026_4610:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set04Frame3::
Data_026_4621:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $04, $00 ; entry 0
    db $F1, $00, $05, $00 ; entry 1
    db $F9, $F8, $08, $00 ; entry 2
    db $F9, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set04Frame4::
Data_026_4632:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set04Frame5::
Data_026_4643:: ; heuristic: meta-sprite frame; C0
    db $F1, $00, $0A, $20 ; entry 0
    db $F1, $F8, $0B, $20 ; entry 1
    db $F9, $00, $0C, $20 ; entry 2
    db $F9, $F8, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 5 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set05::
Data_026_4654:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set05Frame0 ; entry 0
    dw MetaSprites26Set05Frame1 ; entry 1
    dw MetaSprites26Set05Frame2 ; entry 2
    dw MetaSprites26Set05Frame3 ; entry 3
    dw MetaSprites26Set05Frame4 ; entry 4
    dw MetaSprites26Set05Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set05Frame0::
Data_026_4660:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set05Frame1::
Data_026_4671:: ; heuristic: meta-sprite frame; C0
    db $F1, $00, $00, $20 ; entry 0
    db $F1, $F8, $01, $20 ; entry 1
    db $F9, $00, $02, $20 ; entry 2
    db $F9, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set05Frame2::
Data_026_4682:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set05Frame3::
Data_026_4693:: ; heuristic: meta-sprite frame; C0
    db $F1, $00, $05, $00 ; entry 0
    db $F1, $F8, $08, $00 ; entry 1
    db $F9, $F8, $09, $00 ; entry 2
    db $F9, $00, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set05Frame4::
Data_026_46A4:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $00, $0C, $00 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0E, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set05Frame5::
Data_026_46B5:: ; heuristic: meta-sprite frame; C0
    db $F1, $00, $0B, $20 ; entry 0
    db $F1, $F8, $0C, $20 ; entry 1
    db $F9, $00, $0D, $20 ; entry 2
    db $F9, $F8, $0E, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 14 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set0E::
Data_026_46C6:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set0EFrame0 ; entry 0
    dw MetaSprites26Set0EFrame1 ; entry 1
    dw MetaSprites26Set0EFrame2 ; entry 2
    dw MetaSprites26Set0EFrame3 ; entry 3
    dw MetaSprites26Set0EFrame4 ; entry 4
    dw MetaSprites26Set0EFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set0E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set0EFrame0::
Data_026_46D2:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $00, $30 ; entry 1
    db $F8, $F8, $01, $10 ; entry 2
    db $F8, $00, $02, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set0E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set0EFrame1::
Data_026_46E3:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $03, $10 ; entry 0
    db $F1, $00, $04, $10 ; entry 1
    db $F9, $F8, $01, $10 ; entry 2
    db $F9, $00, $02, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set0E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set0EFrame2::
Data_026_46F4:: ; heuristic: meta-sprite frame; C0
    db $F8, $F8, $07, $10 ; entry 0
    db $F8, $00, $08, $10 ; entry 1
    db $F0, $F8, $09, $10 ; entry 2
    db $F0, $00, $0A, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set0E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set0EFrame3::
Data_026_4705:: ; heuristic: meta-sprite frame; C0
    db $F9, $F8, $07, $10 ; entry 0
    db $F9, $00, $08, $10 ; entry 1
    db $F1, $F8, $05, $10 ; entry 2
    db $F1, $00, $06, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set0E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set0EFrame4::
Data_026_4716:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0B, $10 ; entry 0
    db $F0, $00, $0B, $30 ; entry 1
    db $F8, $F8, $0E, $10 ; entry 2
    db $F8, $00, $0F, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set0E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set0EFrame5::
Data_026_4727:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $0C, $10 ; entry 0
    db $F1, $00, $0D, $10 ; entry 1
    db $F9, $F8, $0E, $10 ; entry 2
    db $F9, $00, $0F, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 15 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set0F::
Data_026_4738:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set0FFrame0 ; entry 0
    dw MetaSprites26Set0FFrame1 ; entry 1
    dw MetaSprites26Set0FFrame2 ; entry 2
    dw MetaSprites26Set0FFrame3 ; entry 3
    dw MetaSprites26Set0FFrame4 ; entry 4
    dw MetaSprites26Set0FFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set0F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set0FFrame0::
Data_026_4744:: ; heuristic: meta-sprite frame; C0
    db $F0, $00, $00, $30 ; entry 0
    db $F0, $F8, $00, $10 ; entry 1
    db $F8, $F8, $01, $10 ; entry 2
    db $F8, $00, $02, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set0F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set0FFrame1::
Data_026_4755:: ; heuristic: meta-sprite frame; C0
    db $EF, $F8, $00, $10 ; entry 0
    db $EF, $00, $00, $30 ; entry 1
    db $F7, $00, $01, $30 ; entry 2
    db $F7, $F8, $02, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set0F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set0FFrame2::
Data_026_4766:: ; heuristic: meta-sprite frame; C0
    db $EF, $F8, $03, $10 ; entry 0
    db $EF, $00, $04, $10 ; entry 1
    db $F7, $F8, $05, $10 ; entry 2
    db $F7, $00, $06, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set0F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set0FFrame3::
Data_026_4777:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $03, $10 ; entry 0
    db $F0, $00, $04, $10 ; entry 1
    db $F8, $F8, $07, $10 ; entry 2
    db $F8, $00, $08, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set0F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set0FFrame4::
Data_026_4788:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $09, $10 ; entry 0
    db $F0, $00, $09, $30 ; entry 1
    db $F8, $F8, $0A, $10 ; entry 2
    db $F8, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set0F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set0FFrame5::
Data_026_4799:: ; heuristic: meta-sprite frame; C0
    db $EF, $F8, $09, $10 ; entry 0
    db $EF, $00, $09, $30 ; entry 1
    db $F7, $00, $0A, $30 ; entry 2
    db $F7, $F8, $0B, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 16 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set10::
Data_026_47AA:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set10Frame0 ; entry 0
    dw MetaSprites26Set10Frame1 ; entry 1
    dw MetaSprites26Set10Frame2 ; entry 2
    dw MetaSprites26Set10Frame3 ; entry 3
    dw MetaSprites26Set10Frame4 ; entry 4
    dw MetaSprites26Set10Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set10Frame0::
Data_026_47B6:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set10Frame1::
Data_026_47C7:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $04, $10 ; entry 0
    db $F1, $00, $05, $10 ; entry 1
    db $F9, $F8, $02, $10 ; entry 2
    db $F9, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set10Frame2::
Data_026_47D8:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $06, $10 ; entry 0
    db $F0, $00, $07, $10 ; entry 1
    db $F8, $F8, $09, $10 ; entry 2
    db $F8, $00, $0A, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set10Frame3::
Data_026_47E9:: ; heuristic: meta-sprite frame; C0
    db $F9, $F8, $09, $10 ; entry 0
    db $F9, $00, $0A, $10 ; entry 1
    db $F1, $00, $07, $10 ; entry 2
    db $F1, $F8, $08, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set10Frame4::
Data_026_47FA:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0B, $10 ; entry 0
    db $F0, $00, $0C, $10 ; entry 1
    db $F8, $00, $02, $30 ; entry 2
    db $F8, $F8, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set10Frame5::
Data_026_480B:: ; heuristic: meta-sprite frame; C0
    db $F9, $00, $02, $30 ; entry 0
    db $F9, $F8, $03, $30 ; entry 1
    db $F1, $F8, $0D, $10 ; entry 2
    db $F1, $00, $0E, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 17 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set11::
Data_026_481C:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set11Frame0 ; entry 0
    dw MetaSprites26Set11Frame1 ; entry 1
    dw MetaSprites26Set11Frame2 ; entry 2
    dw MetaSprites26Set11Frame3 ; entry 3
    dw MetaSprites26Set11Frame4 ; entry 4
    dw MetaSprites26Set11Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set11Frame0::
Data_026_4828:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set11Frame1::
Data_026_4839:: ; heuristic: meta-sprite frame; C0
    db $F1, $00, $00, $30 ; entry 0
    db $F1, $F8, $01, $30 ; entry 1
    db $F9, $00, $02, $30 ; entry 2
    db $F9, $F8, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set11Frame2::
Data_026_484A:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set11Frame3::
Data_026_485B:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $08, $10 ; entry 0
    db $F1, $00, $09, $10 ; entry 1
    db $F9, $F8, $0A, $10 ; entry 2
    db $F9, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set11Frame4::
Data_026_486C:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $10 ; entry 0
    db $F0, $00, $0D, $10 ; entry 1
    db $F8, $F8, $0E, $10 ; entry 2
    db $F8, $00, $0F, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set11Frame5::
Data_026_487D:: ; heuristic: meta-sprite frame; C0
    db $F1, $00, $0C, $30 ; entry 0
    db $F1, $F8, $0D, $30 ; entry 1
    db $F9, $00, $0E, $30 ; entry 2
    db $F9, $F8, $0F, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 18 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set12::
Data_026_488E:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set12Frame0 ; entry 0
    dw MetaSprites26Set12Frame1 ; entry 1
    dw MetaSprites26Set12Frame2 ; entry 2
    dw MetaSprites26Set12Frame3 ; entry 3
    dw MetaSprites26Set12Frame4 ; entry 4
    dw MetaSprites26Set12Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set12; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set12Frame0::
Data_026_489A:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $04, $00 ; entry 2
    db $F8, $00, $04, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set12; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set12Frame1::
Data_026_48AB:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $02, $00 ; entry 0
    db $F1, $00, $03, $00 ; entry 1
    db $F9, $F8, $05, $00 ; entry 2
    db $F9, $00, $05, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set12; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set12Frame2::
Data_026_48BC:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set12; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set12Frame3::
Data_026_48CD:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $0A, $00 ; entry 0
    db $F1, $00, $03, $00 ; entry 1
    db $F9, $F8, $0B, $00 ; entry 2
    db $F9, $00, $0C, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set12; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set12Frame4::
Data_026_48DE:: ; heuristic: meta-sprite frame; C0
    db $F0, $00, $0D, $20 ; entry 0
    db $F0, $F8, $0E, $20 ; entry 1
    db $F8, $00, $0F, $20 ; entry 2
    db $F8, $F8, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set12; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set12Frame5::
Data_026_48EF:: ; heuristic: meta-sprite frame; C0
    db $F1, $00, $0D, $20 ; entry 0
    db $F1, $F8, $0E, $20 ; entry 1
    db $F9, $00, $0F, $20 ; entry 2
    db $F9, $F8, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 19 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set13::
Data_026_4900:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set13Frame0 ; entry 0
    dw MetaSprites26Set13Frame1 ; entry 1
    dw MetaSprites26Set13Frame2 ; entry 2
    dw MetaSprites26Set13Frame3 ; entry 3
    dw MetaSprites26Set13Frame4 ; entry 4
    dw MetaSprites26Set13Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set13; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set13Frame0::
Data_026_490C:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $FF, $00, $30 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set13; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set13Frame1::
Data_026_491D:: ; heuristic: meta-sprite frame; C0
    db $F0, $FF, $00, $30 ; entry 0
    db $F0, $F8, $00, $10 ; entry 1
    db $F8, $FF, $01, $20 ; entry 2
    db $F8, $F7, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set13; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set13Frame2::
Data_026_492E:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $06, $10 ; entry 0
    db $F1, $00, $07, $10 ; entry 1
    db $F9, $F8, $08, $00 ; entry 2
    db $F9, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set13; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set13Frame3::
Data_026_493F:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $06, $10 ; entry 0
    db $F1, $00, $07, $10 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set13; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set13Frame4::
Data_026_4950:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $03, $10 ; entry 0
    db $F0, $FF, $03, $30 ; entry 1
    db $F8, $F8, $04, $00 ; entry 2
    db $F8, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set13; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set13Frame5::
Data_026_4961:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $03, $10 ; entry 0
    db $F0, $FF, $03, $30 ; entry 1
    db $F8, $FF, $04, $20 ; entry 2
    db $F8, $F7, $05, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 20 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set14::
Data_026_4972:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set14Frame0 ; entry 0
    dw MetaSprites26Set14Frame1 ; entry 1
    dw MetaSprites26Set14Frame2 ; entry 2
    dw MetaSprites26Set14Frame3 ; entry 3
    dw MetaSprites26Set14Frame4 ; entry 4
    dw MetaSprites26Set14Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set14; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set14Frame0::
Data_026_497E:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set14; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set14Frame1::
Data_026_498F:: ; heuristic: meta-sprite frame; C0
    db $F9, $00, $02, $30 ; entry 0
    db $F9, $F8, $03, $30 ; entry 1
    db $F1, $00, $00, $30 ; entry 2
    db $F1, $F8, $01, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set14; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set14Frame2::
Data_026_49A0:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set14; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set14Frame3::
Data_026_49B1:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $08, $10 ; entry 0
    db $F1, $00, $09, $10 ; entry 1
    db $F9, $F8, $0A, $10 ; entry 2
    db $F9, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set14; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set14Frame4::
Data_026_49C2:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $10 ; entry 0
    db $F0, $00, $0D, $10 ; entry 1
    db $F8, $F8, $0E, $10 ; entry 2
    db $F8, $00, $0F, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set14; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set14Frame5::
Data_026_49D3:: ; heuristic: meta-sprite frame; C0
    db $F1, $00, $0C, $30 ; entry 0
    db $F1, $F8, $0D, $30 ; entry 1
    db $F9, $00, $0E, $30 ; entry 2
    db $F9, $F8, $0F, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 21 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set15::
Data_026_49E4:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set15Frame0 ; entry 0
    dw MetaSprites26Set15Frame1 ; entry 1
    dw MetaSprites26Set15Frame2 ; entry 2
    dw MetaSprites26Set15Frame3 ; entry 3
    dw MetaSprites26Set15Frame4 ; entry 4
    dw MetaSprites26Set15Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set15; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set15Frame0::
Data_026_49F0:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $F8, $02, $00 ; entry 2
    db $F9, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set15; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set15Frame1::
Data_026_4A01:: ; heuristic: meta-sprite frame; C0
    db $F0, $FF, $00, $20 ; entry 0
    db $F0, $F7, $01, $20 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set15; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set15Frame2::
Data_026_4A12:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set15; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set15Frame3::
Data_026_4A23:: ; heuristic: meta-sprite frame; C0
    db $EF, $F8, $08, $00 ; entry 0
    db $EF, $00, $09, $00 ; entry 1
    db $F7, $F8, $0A, $00 ; entry 2
    db $F7, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set15; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set15Frame4::
Data_026_4A34:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set15; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set15Frame5::
Data_026_4A45:: ; heuristic: meta-sprite frame; C0
    db $EF, $FF, $0C, $20 ; entry 0
    db $EF, $F7, $0D, $20 ; entry 1
    db $F7, $FF, $0E, $20 ; entry 2
    db $F7, $F7, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 22 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set16::
Data_026_4A56:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set16Frame0 ; entry 0
    dw MetaSprites26Set16Frame1 ; entry 1
    dw MetaSprites26Set16Frame2 ; entry 2
    dw MetaSprites26Set16Frame3 ; entry 3
    dw MetaSprites26Set16Frame4 ; entry 4
    dw MetaSprites26Set16Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set16; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set16Frame0::
Data_026_4A62:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $00, $30 ; entry 1
    db $F8, $F8, $01, $10 ; entry 2
    db $F8, $00, $02, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set16; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set16Frame1::
Data_026_4A73:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $00, $10 ; entry 0
    db $F1, $00, $00, $30 ; entry 1
    db $F9, $F8, $03, $10 ; entry 2
    db $F9, $00, $04, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set16; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set16Frame2::
Data_026_4A84:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $05, $10 ; entry 0
    db $F0, $00, $06, $10 ; entry 1
    db $F8, $F8, $07, $10 ; entry 2
    db $F8, $00, $08, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set16; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set16Frame3::
Data_026_4A95:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $05, $10 ; entry 0
    db $F1, $00, $06, $10 ; entry 1
    db $F9, $F8, $09, $10 ; entry 2
    db $F9, $00, $0A, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set16; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set16Frame4::
Data_026_4AA6:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0B, $10 ; entry 0
    db $F0, $00, $0B, $30 ; entry 1
    db $F8, $F8, $0C, $10 ; entry 2
    db $F8, $00, $0D, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set16; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set16Frame5::
Data_026_4AB7:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $0B, $10 ; entry 0
    db $F1, $00, $0B, $30 ; entry 1
    db $F9, $F8, $0E, $10 ; entry 2
    db $F9, $00, $0F, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 23 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set17::
Data_026_4AC8:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set17Frame0 ; entry 0
    dw MetaSprites26Set17Frame1 ; entry 1
    dw MetaSprites26Set17Frame2 ; entry 2
    dw MetaSprites26Set17Frame3 ; entry 3
    dw MetaSprites26Set17Frame4 ; entry 4
    dw MetaSprites26Set17Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set17; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set17Frame0::
Data_026_4AD4:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set17; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set17Frame1::
Data_026_4AE5:: ; heuristic: meta-sprite frame; C0
    db $F9, $00, $02, $30 ; entry 0
    db $F9, $F8, $03, $30 ; entry 1
    db $F1, $00, $00, $30 ; entry 2
    db $F1, $F8, $01, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set17; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set17Frame2::
Data_026_4AF6:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set17; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set17Frame3::
Data_026_4B07:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $08, $10 ; entry 0
    db $F1, $00, $09, $10 ; entry 1
    db $F9, $F8, $0A, $10 ; entry 2
    db $F9, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set17; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set17Frame4::
Data_026_4B18:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $10 ; entry 0
    db $F0, $00, $0D, $10 ; entry 1
    db $F8, $F8, $0E, $10 ; entry 2
    db $F8, $00, $0F, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set17; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set17Frame5::
Data_026_4B29:: ; heuristic: meta-sprite frame; C0
    db $F1, $00, $0C, $30 ; entry 0
    db $F1, $F8, $0D, $30 ; entry 1
    db $F9, $00, $0E, $30 ; entry 2
    db $F9, $F8, $0F, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 24 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set18::
Data_026_4B3A:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set18Frame0 ; entry 0
    dw MetaSprites26Set18Frame1 ; entry 1
    dw MetaSprites26Set18Frame2 ; entry 2
    dw MetaSprites26Set18Frame3 ; entry 3
    dw MetaSprites26Set18Frame4 ; entry 4
    dw MetaSprites26Set18Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set18; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set18Frame0::
Data_026_4B46:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set18; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set18Frame1::
Data_026_4B57:: ; heuristic: meta-sprite frame; C0
    db $F1, $00, $00, $30 ; entry 0
    db $F1, $F8, $01, $30 ; entry 1
    db $F9, $00, $02, $30 ; entry 2
    db $F9, $F8, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set18; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set18Frame2::
Data_026_4B68:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set18; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set18Frame3::
Data_026_4B79:: ; heuristic: meta-sprite frame; C0
    db $F1, $00, $05, $10 ; entry 0
    db $F1, $F8, $08, $10 ; entry 1
    db $F9, $F8, $0A, $10 ; entry 2
    db $F9, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set18; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set18Frame4::
Data_026_4B8A:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $10 ; entry 0
    db $F0, $00, $0D, $10 ; entry 1
    db $F8, $F8, $0E, $10 ; entry 2
    db $F8, $00, $0F, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set18; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set18Frame5::
Data_026_4B9B:: ; heuristic: meta-sprite frame; C0
    db $F1, $00, $0C, $30 ; entry 0
    db $F1, $F8, $0D, $30 ; entry 1
    db $F9, $00, $0E, $30 ; entry 2
    db $F9, $F8, $0F, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 25 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set19::
Data_026_4BAC:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set19Frame0 ; entry 0
    dw MetaSprites26Set19Frame1 ; entry 1
    dw MetaSprites26Set19Frame2 ; entry 2
    dw MetaSprites26Set19Frame3 ; entry 3
    dw MetaSprites26Set19Frame4 ; entry 4
    dw MetaSprites26Set19Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set19; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set19Frame0::
Data_026_4BB8:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $10 ; entry 0
    db $F8, $F8, $01, $10 ; entry 1
    db $F8, $00, $02, $10 ; entry 2
    db $F0, $00, $00, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set19; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set19Frame1::
Data_026_4BC9:: ; heuristic: meta-sprite frame; C0
    db $F1, $00, $00, $30 ; entry 0
    db $F9, $00, $01, $30 ; entry 1
    db $F9, $F8, $02, $30 ; entry 2
    db $F1, $F8, $00, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set19; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set19Frame2::
Data_026_4BDA:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $03, $10 ; entry 0
    db $F0, $00, $04, $10 ; entry 1
    db $F8, $F8, $05, $10 ; entry 2
    db $F8, $00, $06, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set19; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set19Frame3::
Data_026_4BEB:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $03, $10 ; entry 0
    db $F1, $00, $04, $10 ; entry 1
    db $F9, $F8, $07, $10 ; entry 2
    db $F9, $00, $08, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set19; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set19Frame4::
Data_026_4BFC:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $09, $10 ; entry 0
    db $F1, $00, $09, $30 ; entry 1
    db $F9, $F8, $0A, $10 ; entry 2
    db $F9, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set19; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set19Frame5::
Data_026_4C0D:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $09, $10 ; entry 0
    db $F0, $00, $09, $30 ; entry 1
    db $F8, $00, $0A, $30 ; entry 2
    db $F8, $F8, $0B, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 26 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set1A::
Data_026_4C1E:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set1AFrame0 ; entry 0
    dw MetaSprites26Set1AFrame1 ; entry 1
    dw MetaSprites26Set1AFrame2 ; entry 2
    dw MetaSprites26Set1AFrame3 ; entry 3
    dw MetaSprites26Set1AFrame4 ; entry 4
    dw MetaSprites26Set1AFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1AFrame0::
Data_026_4C2A:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $00, $20 ; entry 1
    db $F9, $F8, $01, $00 ; entry 2
    db $F9, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1AFrame1::
Data_026_4C3B:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $02, $00 ; entry 0
    db $F0, $00, $02, $20 ; entry 1
    db $F8, $F8, $03, $00 ; entry 2
    db $F8, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1AFrame2::
Data_026_4C4C:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1AFrame3::
Data_026_4C5D:: ; heuristic: meta-sprite frame; C0
    db $EF, $F8, $08, $00 ; entry 0
    db $EF, $00, $09, $00 ; entry 1
    db $F7, $F8, $0A, $00 ; entry 2
    db $F7, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1AFrame4::
Data_026_4C6E:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0C, $20 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1AFrame5::
Data_026_4C7F:: ; heuristic: meta-sprite frame; C0
    db $EF, $F8, $0E, $00 ; entry 0
    db $EF, $00, $0E, $20 ; entry 1
    db $F7, $F8, $0F, $00 ; entry 2
    db $F7, $00, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 27 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set1B::
Data_026_4C90:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set1BFrame0 ; entry 0
    dw MetaSprites26Set1BFrame1 ; entry 1
    dw MetaSprites26Set1BFrame2 ; entry 2
    dw MetaSprites26Set1BFrame3 ; entry 3
    dw MetaSprites26Set1BFrame4 ; entry 4
    dw MetaSprites26Set1BFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1BFrame0::
Data_026_4C9C:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1BFrame1::
Data_026_4CAD:: ; heuristic: meta-sprite frame; C0
    db $EF, $F8, $00, $10 ; entry 0
    db $EF, $00, $01, $10 ; entry 1
    db $F7, $F8, $02, $10 ; entry 2
    db $F7, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1BFrame2::
Data_026_4CBE:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1BFrame3::
Data_026_4CCF:: ; heuristic: meta-sprite frame; C0
    db $EF, $F8, $04, $10 ; entry 0
    db $EF, $00, $05, $10 ; entry 1
    db $F7, $F8, $06, $10 ; entry 2
    db $F7, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1BFrame4::
Data_026_4CE0:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $08, $10 ; entry 0
    db $F0, $00, $09, $10 ; entry 1
    db $F8, $F8, $0A, $10 ; entry 2
    db $F8, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1BFrame5::
Data_026_4CF1:: ; heuristic: meta-sprite frame; C0
    db $EF, $F8, $08, $10 ; entry 0
    db $EF, $00, $09, $10 ; entry 1
    db $F7, $F8, $0A, $10 ; entry 2
    db $F7, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 28 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set1C::
Data_026_4D02:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set1CFrame0 ; entry 0
    dw MetaSprites26Set1CFrame1 ; entry 1
    dw MetaSprites26Set1CFrame2 ; entry 2
    dw MetaSprites26Set1CFrame3 ; entry 3
    dw MetaSprites26Set1CFrame4 ; entry 4
    dw MetaSprites26Set1CFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1CFrame0::
Data_026_4D0E:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1CFrame1::
Data_026_4D1F:: ; heuristic: meta-sprite frame; C0
    db $F1, $00, $00, $20 ; entry 0
    db $F1, $F8, $01, $20 ; entry 1
    db $F9, $00, $02, $20 ; entry 2
    db $F9, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1CFrame2::
Data_026_4D30:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1CFrame3::
Data_026_4D41:: ; heuristic: meta-sprite frame; C0
    db $F9, $F8, $09, $00 ; entry 0
    db $F9, $00, $0A, $00 ; entry 1
    db $F1, $00, $05, $00 ; entry 2
    db $F1, $F8, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1CFrame4::
Data_026_4D52:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $0B, $00 ; entry 0
    db $F1, $00, $0C, $00 ; entry 1
    db $F9, $F8, $0D, $00 ; entry 2
    db $F9, $00, $0E, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1CFrame5::
Data_026_4D63:: ; heuristic: meta-sprite frame; C0
    db $F0, $00, $0B, $20 ; entry 0
    db $F0, $F8, $0C, $20 ; entry 1
    db $F8, $00, $0D, $20 ; entry 2
    db $F8, $F8, $0E, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 29 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set1D::
Data_026_4D74:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set1DFrame0 ; entry 0
    dw MetaSprites26Set1DFrame1 ; entry 1
    dw MetaSprites26Set1DFrame2 ; entry 2
    dw MetaSprites26Set1DFrame3 ; entry 3
    dw MetaSprites26Set1DFrame4 ; entry 4
    dw MetaSprites26Set1DFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set1D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1DFrame0::
Data_026_4D80:: ; heuristic: meta-sprite frame; C0
    db $F0, $F7, $00, $00 ; entry 0
    db $F0, $FF, $01, $00 ; entry 1
    db $F8, $F7, $02, $00 ; entry 2
    db $F8, $FF, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set1D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1DFrame1::
Data_026_4D91:: ; heuristic: meta-sprite frame; C0
    db $F0, $F7, $00, $00 ; entry 0
    db $F8, $F7, $05, $00 ; entry 1
    db $F8, $FF, $06, $00 ; entry 2
    db $F0, $FF, $04, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set1D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1DFrame2::
Data_026_4DA2:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $07, $00 ; entry 0
    db $F0, $00, $08, $00 ; entry 1
    db $F8, $F8, $09, $00 ; entry 2
    db $F8, $00, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set1D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1DFrame3::
Data_026_4DB3:: ; heuristic: meta-sprite frame; C0
    db $F0, $00, $08, $00 ; entry 0
    db $F0, $F8, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set1D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1DFrame4::
Data_026_4DC4:: ; heuristic: meta-sprite frame; C0
    db $F8, $00, $02, $20 ; entry 0
    db $F8, $F8, $03, $20 ; entry 1
    db $F0, $00, $00, $20 ; entry 2
    db $F0, $F8, $0E, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set1D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1DFrame5::
Data_026_4DD5:: ; heuristic: meta-sprite frame; C0
    db $F8, $00, $05, $20 ; entry 0
    db $F8, $F8, $06, $20 ; entry 1
    db $F0, $00, $00, $20 ; entry 2
    db $F0, $F8, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 30 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set1E::
Data_026_4DE6:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set1EFrame0 ; entry 0
    dw MetaSprites26Set1EFrame1 ; entry 1
    dw MetaSprites26Set1EFrame2 ; entry 2
    dw MetaSprites26Set1EFrame3 ; entry 3
    dw MetaSprites26Set1EFrame4 ; entry 4
    dw MetaSprites26Set1EFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1EFrame0::
Data_026_4DF2:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $00, $10 ; entry 0
    db $F1, $00, $01, $10 ; entry 1
    db $F9, $F8, $02, $10 ; entry 2
    db $F9, $00, $02, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1EFrame1::
Data_026_4E03:: ; heuristic: meta-sprite frame; C0
    db $F8, $00, $02, $30 ; entry 0
    db $F0, $00, $00, $30 ; entry 1
    db $F0, $F8, $01, $30 ; entry 2
    db $F8, $F8, $02, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1EFrame2::
Data_026_4E14:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $03, $10 ; entry 0
    db $F1, $00, $04, $10 ; entry 1
    db $F9, $F8, $05, $10 ; entry 2
    db $F9, $00, $06, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1EFrame3::
Data_026_4E25:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $07, $10 ; entry 0
    db $F0, $00, $08, $10 ; entry 1
    db $F8, $F8, $09, $10 ; entry 2
    db $F8, $00, $06, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1EFrame4::
Data_026_4E36:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0A, $10 ; entry 0
    db $F0, $00, $0B, $10 ; entry 1
    db $F8, $F8, $0C, $10 ; entry 2
    db $F8, $00, $0C, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1EFrame5::
Data_026_4E47:: ; heuristic: meta-sprite frame; C0
    db $F7, $00, $0C, $30 ; entry 0
    db $F7, $F8, $0C, $10 ; entry 1
    db $EF, $00, $0A, $30 ; entry 2
    db $EF, $F8, $0B, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 31 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set1F::
Data_026_4E58:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set1FFrame0 ; entry 0
    dw MetaSprites26Set1FFrame1 ; entry 1
    dw MetaSprites26Set1FFrame2 ; entry 2
    dw MetaSprites26Set1FFrame3 ; entry 3
    dw MetaSprites26Set1FFrame4 ; entry 4
    dw MetaSprites26Set1FFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1FFrame0::
Data_026_4E64:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1FFrame1::
Data_026_4E75:: ; heuristic: meta-sprite frame; C0
    db $F9, $00, $02, $30 ; entry 0
    db $F9, $F8, $03, $30 ; entry 1
    db $F1, $00, $00, $30 ; entry 2
    db $F1, $F8, $01, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1FFrame2::
Data_026_4E86:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1FFrame3::
Data_026_4E97:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $08, $10 ; entry 0
    db $F1, $00, $09, $10 ; entry 1
    db $F9, $F8, $0A, $10 ; entry 2
    db $F9, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1FFrame4::
Data_026_4EA8:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $10 ; entry 0
    db $F0, $00, $0D, $10 ; entry 1
    db $F8, $F8, $0E, $10 ; entry 2
    db $F8, $00, $0F, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set1FFrame5::
Data_026_4EB9:: ; heuristic: meta-sprite frame; C0
    db $F1, $00, $0C, $30 ; entry 0
    db $F1, $F8, $0D, $30 ; entry 1
    db $F9, $00, $0E, $30 ; entry 2
    db $F9, $F8, $0F, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 32 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set20::
Data_026_4ECA:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set20Frame0 ; entry 0
    dw MetaSprites26Set20Frame1 ; entry 1
    dw MetaSprites26Set20Frame2 ; entry 2
    dw MetaSprites26Set20Frame3 ; entry 3
    dw MetaSprites26Set20Frame4 ; entry 4
    dw MetaSprites26Set20Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set20; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set20Frame0::
Data_026_4ED6:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $10 ; entry 0
    db $F8, $F8, $01, $10 ; entry 1
    db $F0, $00, $00, $30 ; entry 2
    db $F8, $00, $01, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set20; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set20Frame1::
Data_026_4EE7:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $02, $10 ; entry 0
    db $F1, $00, $02, $30 ; entry 1
    db $F9, $F8, $03, $10 ; entry 2
    db $F9, $00, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set20; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set20Frame2::
Data_026_4EF8:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set20; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set20Frame3::
Data_026_4F09:: ; heuristic: meta-sprite frame; C0
    db $F9, $F8, $06, $10 ; entry 0
    db $F9, $00, $07, $10 ; entry 1
    db $F1, $F8, $08, $10 ; entry 2
    db $F1, $00, $09, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set20; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set20Frame4::
Data_026_4F1A:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0A, $10 ; entry 0
    db $F0, $00, $0A, $30 ; entry 1
    db $F8, $F8, $0B, $10 ; entry 2
    db $F8, $00, $0B, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set20; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set20Frame5::
Data_026_4F2B:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $0C, $10 ; entry 0
    db $F1, $00, $0C, $30 ; entry 1
    db $F9, $F8, $0D, $10 ; entry 2
    db $F9, $00, $0D, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 33 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set21::
Data_026_4F3C:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set21Frame0 ; entry 0
    dw MetaSprites26Set21Frame1 ; entry 1
    dw MetaSprites26Set21Frame2 ; entry 2
    dw MetaSprites26Set21Frame3 ; entry 3
    dw MetaSprites26Set21Frame4 ; entry 4
    dw MetaSprites26Set21Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set21; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set21Frame0::
Data_026_4F48:: ; heuristic: meta-sprite frame; C0
    db $F1, $F9, $00, $00 ; entry 0
    db $F1, $01, $01, $00 ; entry 1
    db $F9, $F9, $02, $00 ; entry 2
    db $F9, $01, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set21; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set21Frame1::
Data_026_4F59:: ; heuristic: meta-sprite frame; C0
    db $F0, $00, $00, $20 ; entry 0
    db $F0, $F8, $01, $20 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set21; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set21Frame2::
Data_026_4F6A:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set21; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set21Frame3::
Data_026_4F7B:: ; heuristic: meta-sprite frame; C0
    db $EF, $F7, $08, $00 ; entry 0
    db $EF, $FF, $09, $00 ; entry 1
    db $F7, $F7, $0A, $00 ; entry 2
    db $F7, $FF, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set21; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set21Frame4::
Data_026_4F8C:: ; heuristic: meta-sprite frame; C0
    db $F0, $F9, $0C, $00 ; entry 0
    db $F0, $01, $0D, $00 ; entry 1
    db $F8, $F9, $0E, $00 ; entry 2
    db $F8, $01, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set21; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set21Frame5::
Data_026_4F9D:: ; heuristic: meta-sprite frame; C0
    db $EF, $00, $0C, $20 ; entry 0
    db $EF, $F8, $0D, $20 ; entry 1
    db $F7, $00, $0E, $20 ; entry 2
    db $F7, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 34 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set22::
Data_026_4FAE:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set22Frame0 ; entry 0
    dw MetaSprites26Set22Frame1 ; entry 1
    dw MetaSprites26Set22Frame2 ; entry 2
    dw MetaSprites26Set22Frame3 ; entry 3
    dw MetaSprites26Set22Frame4 ; entry 4
    dw MetaSprites26Set22Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set22; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set22Frame0::
Data_026_4FBA:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $01, $00 ; entry 1
    db $F0, $00, $00, $20 ; entry 2
    db $F8, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set22; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set22Frame1::
Data_026_4FCB:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $02, $00 ; entry 0
    db $F8, $F8, $03, $00 ; entry 1
    db $F0, $00, $02, $20 ; entry 2
    db $F8, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set22; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set22Frame2::
Data_026_4FDC:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set22; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set22Frame3::
Data_026_4FED:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set22; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set22Frame4::
Data_026_4FFE:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $00 ; entry 0
    db $F8, $F8, $0D, $00 ; entry 1
    db $F0, $00, $0C, $20 ; entry 2
    db $F8, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set22; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set22Frame5::
Data_026_500F:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0E, $00 ; entry 0
    db $F8, $F8, $0F, $00 ; entry 1
    db $F0, $00, $0E, $20 ; entry 2
    db $F8, $00, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 35 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set23::
Data_026_5020:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set23Frame0 ; entry 0
    dw MetaSprites26Set23Frame1 ; entry 1
    dw MetaSprites26Set23Frame2 ; entry 2
    dw MetaSprites26Set23Frame3 ; entry 3
    dw MetaSprites26Set23Frame4 ; entry 4
    dw MetaSprites26Set23Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set23; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set23Frame0::
Data_026_502C:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $01, $00 ; entry 1
    db $F8, $00, $02, $00 ; entry 2
    db $F0, $FF, $00, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set23; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set23Frame1::
Data_026_503D:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $FF, $00, $20 ; entry 1
    db $F9, $F8, $03, $00 ; entry 2
    db $F9, $00, $04, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set23; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set23Frame2::
Data_026_504E:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $05, $00 ; entry 0
    db $F0, $00, $06, $00 ; entry 1
    db $F8, $F8, $07, $00 ; entry 2
    db $F8, $00, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set23; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set23Frame3::
Data_026_505F:: ; heuristic: meta-sprite frame; C0
    db $F1, $F9, $05, $00 ; entry 0
    db $F1, $01, $06, $00 ; entry 1
    db $F9, $F9, $09, $00 ; entry 2
    db $F9, $01, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set23; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set23Frame4::
Data_026_5070:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $00, $0C, $00 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0E, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set23; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set23Frame5::
Data_026_5081:: ; heuristic: meta-sprite frame; C0
    db $F1, $FF, $0B, $20 ; entry 0
    db $F1, $F7, $0C, $20 ; entry 1
    db $F9, $FF, $0D, $20 ; entry 2
    db $F9, $F7, $0E, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 36 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set24::
Data_026_5092:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set24Frame0 ; entry 0
    dw MetaSprites26Set24Frame1 ; entry 1
    dw MetaSprites26Set24Frame2 ; entry 2
    dw MetaSprites26Set24Frame3 ; entry 3
    dw MetaSprites26Set24Frame4 ; entry 4
    dw MetaSprites26Set24Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set24; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set24Frame0::
Data_026_509E:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set24; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set24Frame1::
Data_026_50AF:: ; heuristic: meta-sprite frame; C0
    db $F0, $00, $00, $20 ; entry 0
    db $F0, $F8, $01, $20 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set24; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set24Frame2::
Data_026_50C0:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set24; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set24Frame3::
Data_026_50D1:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set24; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set24Frame4::
Data_026_50E2:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set24; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set24Frame5::
Data_026_50F3:: ; heuristic: meta-sprite frame; C0
    db $F0, $00, $0C, $20 ; entry 0
    db $F0, $F8, $0D, $20 ; entry 1
    db $F8, $00, $0E, $20 ; entry 2
    db $F8, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 37 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set25::
Data_026_5104:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set25Frame0 ; entry 0
    dw MetaSprites26Set25Frame1 ; entry 1
    dw MetaSprites26Set25Frame2 ; entry 2
    dw MetaSprites26Set25Frame3 ; entry 3
    dw MetaSprites26Set25Frame4 ; entry 4
    dw MetaSprites26Set25Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set25Frame0::
Data_026_5110:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set25Frame1::
Data_026_5121:: ; heuristic: meta-sprite frame; C0
    db $F0, $00, $00, $20 ; entry 0
    db $F0, $F8, $01, $20 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set25Frame2::
Data_026_5132:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set25Frame3::
Data_026_5143:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set25Frame4::
Data_026_5154:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set25Frame5::
Data_026_5165:: ; heuristic: meta-sprite frame; C0
    db $F0, $00, $0C, $20 ; entry 0
    db $F0, $F8, $0D, $20 ; entry 1
    db $F8, $00, $0E, $20 ; entry 2
    db $F8, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 38 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set26::
Data_026_5176:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set26Frame0 ; entry 0
    dw MetaSprites26Set26Frame1 ; entry 1
    dw MetaSprites26Set26Frame2 ; entry 2
    dw MetaSprites26Set26Frame3 ; entry 3
    dw MetaSprites26Set26Frame4 ; entry 4
    dw MetaSprites26Set26Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set26Frame0::
Data_026_5182:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set26Frame1::
Data_026_5193:: ; heuristic: meta-sprite frame; C0
    db $F1, $00, $00, $20 ; entry 0
    db $F1, $F8, $01, $20 ; entry 1
    db $F9, $00, $02, $20 ; entry 2
    db $F9, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set26Frame2::
Data_026_51A4:: ; heuristic: meta-sprite frame; C0
    db $F0, $FC, $04, $00 ; entry 0
    db $F8, $F8, $06, $00 ; entry 1
    db $F8, $00, $07, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set26Frame3::
Data_026_51B1:: ; heuristic: meta-sprite frame; C0
    db $F1, $FC, $05, $00 ; entry 0
    db $F9, $F8, $08, $00 ; entry 1
    db $F9, $00, $09, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set26Frame4::
Data_026_51BE:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set26Frame5::
Data_026_51CF:: ; heuristic: meta-sprite frame; C0
    db $F1, $00, $0A, $20 ; entry 0
    db $F1, $F8, $0B, $20 ; entry 1
    db $F9, $00, $0C, $20 ; entry 2
    db $F9, $F8, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 39 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set27::
Data_026_51E0:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set27Frame0 ; entry 0
    dw MetaSprites26Set27Frame1 ; entry 1
    dw MetaSprites26Set27Frame2 ; entry 2
    dw MetaSprites26Set27Frame3 ; entry 3
    dw MetaSprites26Set27Frame4 ; entry 4
    dw MetaSprites26Set27Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set27Frame0::
Data_026_51EC:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set27Frame1::
Data_026_51FD:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $F8, $04, $00 ; entry 2
    db $F9, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set27Frame2::
Data_026_520E:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $05, $00 ; entry 0
    db $F0, $00, $06, $00 ; entry 1
    db $F8, $F8, $07, $00 ; entry 2
    db $F8, $00, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set27Frame3::
Data_026_521F:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $05, $00 ; entry 0
    db $F1, $00, $06, $00 ; entry 1
    db $F9, $F8, $07, $00 ; entry 2
    db $F9, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set27Frame4::
Data_026_5230:: ; heuristic: meta-sprite frame; C0
    db $F0, $F9, $0A, $00 ; entry 0
    db $F0, $01, $0B, $00 ; entry 1
    db $F8, $F9, $0C, $00 ; entry 2
    db $F8, $01, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set27Frame5::
Data_026_5241:: ; heuristic: meta-sprite frame; C0
    db $F1, $F9, $0A, $00 ; entry 0
    db $F1, $01, $0B, $00 ; entry 1
    db $F9, $F9, $0E, $00 ; entry 2
    db $F9, $01, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 40 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set28::
Data_026_5252:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set28Frame0 ; entry 0
    dw MetaSprites26Set28Frame1 ; entry 1
    dw MetaSprites26Set28Frame2 ; entry 2
    dw MetaSprites26Set28Frame3 ; entry 3
    dw MetaSprites26Set28Frame4 ; entry 4
    dw MetaSprites26Set28Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set28; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set28Frame0::
Data_026_525E:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set28; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set28Frame1::
Data_026_526F:: ; heuristic: meta-sprite frame; C0
    db $F2, $F8, $00, $00 ; entry 0
    db $F2, $00, $00, $20 ; entry 1
    db $FA, $F8, $03, $00 ; entry 2
    db $FA, $00, $04, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set28; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set28Frame2::
Data_026_5280:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $05, $00 ; entry 0
    db $F0, $00, $06, $00 ; entry 1
    db $F8, $F8, $07, $00 ; entry 2
    db $F8, $00, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set28; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set28Frame3::
Data_026_5291:: ; heuristic: meta-sprite frame; C0
    db $F1, $F6, $05, $00 ; entry 0
    db $F1, $FE, $06, $00 ; entry 1
    db $F9, $F7, $09, $00 ; entry 2
    db $F9, $FF, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set28; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set28Frame4::
Data_026_52A2:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $00, $0B, $20 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set28; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set28Frame5::
Data_026_52B3:: ; heuristic: meta-sprite frame; C0
    db $F2, $F8, $0B, $00 ; entry 0
    db $F2, $00, $0B, $20 ; entry 1
    db $FA, $F8, $0E, $00 ; entry 2
    db $FA, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 49 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set31::
Data_026_52C4:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set31Frame0 ; entry 0
    dw MetaSprites26Set31Frame1 ; entry 1
    dw MetaSprites26Set31Frame2 ; entry 2
    dw MetaSprites26Set31Frame3 ; entry 3
    dw MetaSprites26Set31Frame4 ; entry 4
    dw MetaSprites26Set31Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set31Frame0::
Data_026_52D0:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set31Frame1::
Data_026_52E1:: ; heuristic: meta-sprite frame; C0
    db $F0, $F7, $03, $00 ; entry 0
    db $F0, $FF, $04, $00 ; entry 1
    db $F8, $F7, $05, $00 ; entry 2
    db $F8, $FF, $06, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set31Frame2::
Data_026_52F2:: ; heuristic: meta-sprite frame; C0
    db $F8, $F8, $08, $00 ; entry 0
    db $F8, $00, $09, $00 ; entry 1
    db $F0, $00, $07, $00 ; entry 2
    db $F0, $F8, $0C, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set31Frame3::
Data_026_5303:: ; heuristic: meta-sprite frame; C0
    db $F8, $F8, $0A, $00 ; entry 0
    db $F8, $00, $0B, $00 ; entry 1
    db $F0, $F8, $03, $00 ; entry 2
    db $F0, $00, $04, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set31Frame4::
Data_026_5314:: ; heuristic: meta-sprite frame; C0
    db $F8, $F8, $0D, $00 ; entry 0
    db $F8, $00, $0E, $20 ; entry 1
    db $F0, $F9, $0C, $00 ; entry 2
    db $F0, $00, $0C, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set31Frame5::
Data_026_5325:: ; heuristic: meta-sprite frame; C0
    db $F8, $F9, $0E, $00 ; entry 0
    db $F8, $01, $0F, $00 ; entry 1
    db $F0, $01, $03, $20 ; entry 2
    db $F0, $F9, $04, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 50 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set32::
Data_026_5336:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set32Frame0 ; entry 0
    dw MetaSprites26Set32Frame1 ; entry 1
    dw MetaSprites26Set32Frame2 ; entry 2
    dw MetaSprites26Set32Frame3 ; entry 3
    dw MetaSprites26Set32Frame4 ; entry 4
    dw MetaSprites26Set32Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set32; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set32Frame0::
Data_026_5342:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $00, $00 ; entry 0
    db $F9, $F8, $01, $00 ; entry 1
    db $F9, $00, $01, $20 ; entry 2
    db $F1, $00, $00, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set32; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set32Frame1::
Data_026_5353:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $02, $00 ; entry 0
    db $F0, $00, $02, $20 ; entry 1
    db $F8, $F8, $03, $00 ; entry 2
    db $F8, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set32; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set32Frame2::
Data_026_5364:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $04, $00 ; entry 0
    db $F1, $00, $05, $00 ; entry 1
    db $F9, $F8, $06, $00 ; entry 2
    db $F9, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set32; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set32Frame3::
Data_026_5375:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set32; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set32Frame4::
Data_026_5386:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $0C, $00 ; entry 0
    db $F1, $00, $0C, $20 ; entry 1
    db $F9, $F8, $0D, $00 ; entry 2
    db $F9, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set32; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set32Frame5::
Data_026_5397:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0E, $00 ; entry 0
    db $F0, $00, $0E, $20 ; entry 1
    db $F8, $F8, $0F, $00 ; entry 2
    db $F8, $00, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 51 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set33::
Data_026_53A8:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set33Frame0 ; entry 0
    dw MetaSprites26Set33Frame1 ; entry 1
    dw MetaSprites26Set33Frame2 ; entry 2
    dw MetaSprites26Set33Frame3 ; entry 3
    dw MetaSprites26Set33Frame4 ; entry 4
    dw MetaSprites26Set33Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set33; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set33Frame0::
Data_026_53B4:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set33; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set33Frame1::
Data_026_53C5:: ; heuristic: meta-sprite frame; C0
    db $EF, $F8, $02, $00 ; entry 0
    db $EF, $00, $02, $20 ; entry 1
    db $F7, $F8, $03, $00 ; entry 2
    db $F7, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set33; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set33Frame2::
Data_026_53D6:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set33; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set33Frame3::
Data_026_53E7:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set33; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set33Frame4::
Data_026_53F8:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0C, $20 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set33; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set33Frame5::
Data_026_5409:: ; heuristic: meta-sprite frame; C0
    db $EF, $F8, $0E, $00 ; entry 0
    db $EF, $00, $0E, $20 ; entry 1
    db $F7, $F8, $0F, $00 ; entry 2
    db $F7, $00, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 52 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set34::
Data_026_541A:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set34Frame0 ; entry 0
    dw MetaSprites26Set34Frame1 ; entry 1
    dw MetaSprites26Set34Frame2 ; entry 2
    dw MetaSprites26Set34Frame3 ; entry 3
    dw MetaSprites26Set34Frame4 ; entry 4
    dw MetaSprites26Set34Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set34Frame0::
Data_026_5426:: ; heuristic: meta-sprite frame; C0
    db $F8, $F8, $01, $00 ; entry 0
    db $F8, $00, $02, $00 ; entry 1
    db $F0, $FD, $00, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set34Frame1::
Data_026_5433:: ; heuristic: meta-sprite frame; C0
    db $F8, $00, $01, $20 ; entry 0
    db $F8, $F8, $02, $20 ; entry 1
    db $F0, $FB, $00, $20 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set34Frame2::
Data_026_5440:: ; heuristic: meta-sprite frame; C0
    db $F8, $F8, $04, $00 ; entry 0
    db $F8, $00, $05, $00 ; entry 1
    db $F0, $FA, $06, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set34Frame3::
Data_026_544D:: ; heuristic: meta-sprite frame; C0
    db $F0, $FB, $06, $00 ; entry 0
    db $F8, $F8, $07, $00 ; entry 1
    db $F8, $00, $08, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set34Frame4::
Data_026_545A:: ; heuristic: meta-sprite frame; C0
    db $F0, $FD, $00, $00 ; entry 0
    db $F8, $F8, $09, $00 ; entry 1
    db $F8, $00, $0A, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set34Frame5::
Data_026_5467:: ; heuristic: meta-sprite frame; C0
    db $F8, $00, $09, $20 ; entry 0
    db $F8, $F8, $0A, $20 ; entry 1
    db $F0, $FB, $00, $20 ; entry 2
    db $80 ; end

; E-0147 (derived: meta-sprite set 53 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set35::
Data_026_5474:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set35Frame0 ; entry 0
    dw MetaSprites26Set35Frame1 ; entry 1
    dw MetaSprites26Set35Frame2 ; entry 2
    dw MetaSprites26Set35Frame3 ; entry 3
    dw MetaSprites26Set35Frame4 ; entry 4
    dw MetaSprites26Set35Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set35Frame0::
Data_026_5480:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set35Frame1::
Data_026_5491:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $04, $00 ; entry 0
    db $F1, $00, $05, $00 ; entry 1
    db $F9, $F8, $02, $00 ; entry 2
    db $F9, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set35Frame2::
Data_026_54A2:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set35Frame3::
Data_026_54B3:: ; heuristic: meta-sprite frame; C0
    db $F1, $F7, $0A, $00 ; entry 0
    db $F1, $FF, $0B, $00 ; entry 1
    db $F9, $F7, $08, $00 ; entry 2
    db $F9, $FF, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set35Frame4::
Data_026_54C4:: ; heuristic: meta-sprite frame; C0
    db $F0, $FB, $0C, $00 ; entry 0
    db $F8, $F8, $0E, $00 ; entry 1
    db $F8, $00, $0F, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set35Frame5::
Data_026_54D1:: ; heuristic: meta-sprite frame; C0
    db $F9, $F8, $0E, $00 ; entry 0
    db $F9, $00, $0F, $00 ; entry 1
    db $F1, $FB, $0D, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: meta-sprite set 54 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set36::
Data_026_54DE:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set36Frame0 ; entry 0
    dw MetaSprites26Set36Frame1 ; entry 1
    dw MetaSprites26Set36Frame2 ; entry 2
    dw MetaSprites26Set36Frame3 ; entry 3
    dw MetaSprites26Set36Frame4 ; entry 4
    dw MetaSprites26Set36Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set36Frame0::
Data_026_54EA:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set36Frame1::
Data_026_54FB:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $03, $00 ; entry 0
    db $F0, $FF, $03, $20 ; entry 1
    db $F8, $F8, $04, $00 ; entry 2
    db $F8, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set36Frame2::
Data_026_550C:: ; heuristic: meta-sprite frame; C0
    db $F0, $F7, $06, $00 ; entry 0
    db $F0, $FF, $07, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set36Frame3::
Data_026_551D:: ; heuristic: meta-sprite frame; C0
    db $F8, $F8, $0B, $00 ; entry 0
    db $F8, $00, $0C, $00 ; entry 1
    db $F0, $00, $0A, $00 ; entry 2
    db $F0, $F8, $06, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set36Frame4::
Data_026_552E:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0D, $00 ; entry 0
    db $F0, $FF, $0D, $20 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set36Frame5::
Data_026_553F:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0D, $00 ; entry 0
    db $F0, $FF, $0D, $20 ; entry 1
    db $F8, $FF, $0E, $20 ; entry 2
    db $F8, $F7, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 55 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set37::
Data_026_5550:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set37Frame0 ; entry 0
    dw MetaSprites26Set37Frame1 ; entry 1
    dw MetaSprites26Set37Frame2 ; entry 2
    dw MetaSprites26Set37Frame3 ; entry 3
    dw MetaSprites26Set37Frame4 ; entry 4
    dw MetaSprites26Set37Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set37Frame0::
Data_026_555C:: ; heuristic: meta-sprite frame; C0
    db $F2, $F8, $00, $00 ; entry 0
    db $F2, $00, $01, $00 ; entry 1
    db $FA, $F8, $02, $00 ; entry 2
    db $FA, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set37Frame1::
Data_026_556D:: ; heuristic: meta-sprite frame; C0
    db $FB, $00, $02, $20 ; entry 0
    db $FB, $F8, $03, $20 ; entry 1
    db $F3, $F8, $04, $00 ; entry 2
    db $F3, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set37Frame2::
Data_026_557E:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set37Frame3::
Data_026_558F:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $06, $00 ; entry 0
    db $F1, $00, $07, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set37Frame4::
Data_026_55A0:: ; heuristic: meta-sprite frame; C0
    db $FA, $F8, $0E, $00 ; entry 0
    db $FA, $00, $0F, $00 ; entry 1
    db $F2, $F8, $0D, $00 ; entry 2
    db $F2, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set37Frame5::
Data_026_55B1:: ; heuristic: meta-sprite frame; C0
    db $FB, $00, $0E, $20 ; entry 0
    db $FB, $F8, $0F, $20 ; entry 1
    db $F3, $F8, $0C, $00 ; entry 2
    db $F3, $00, $0C, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 56 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set38::
Data_026_55C2:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set38Frame0 ; entry 0
    dw MetaSprites26Set38Frame1 ; entry 1
    dw MetaSprites26Set38Frame2 ; entry 2
    dw MetaSprites26Set38Frame3 ; entry 3
    dw MetaSprites26Set38Frame4 ; entry 4
    dw MetaSprites26Set38Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set38Frame0::
Data_026_55CE:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $01, $00 ; entry 1
    db $F0, $FF, $00, $20 ; entry 2
    db $F8, $FF, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set38Frame1::
Data_026_55DF:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $02, $00 ; entry 0
    db $F9, $F8, $03, $00 ; entry 1
    db $F1, $FF, $02, $20 ; entry 2
    db $F9, $FF, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set38Frame2::
Data_026_55F0:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set38Frame3::
Data_026_5601:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set38Frame4::
Data_026_5612:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $00 ; entry 0
    db $F8, $F8, $0D, $00 ; entry 1
    db $F0, $FF, $0C, $20 ; entry 2
    db $F8, $FF, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set38Frame5::
Data_026_5623:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $0E, $00 ; entry 0
    db $F9, $F8, $0F, $00 ; entry 1
    db $F1, $FF, $0E, $20 ; entry 2
    db $F9, $FF, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 57 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set39::
Data_026_5634:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set39Frame0 ; entry 0
    dw MetaSprites26Set39Frame1 ; entry 1
    dw MetaSprites26Set39Frame2 ; entry 2
    dw MetaSprites26Set39Frame3 ; entry 3
    dw MetaSprites26Set39Frame4 ; entry 4
    dw MetaSprites26Set39Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set39Frame0::
Data_026_5640:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $00, $10 ; entry 0
    db $F1, $00, $01, $10 ; entry 1
    db $F9, $F8, $02, $10 ; entry 2
    db $F9, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set39Frame1::
Data_026_5651:: ; heuristic: meta-sprite frame; C0
    db $F1, $FF, $00, $30 ; entry 0
    db $F1, $F7, $01, $30 ; entry 1
    db $F9, $FF, $02, $30 ; entry 2
    db $F9, $F7, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set39Frame2::
Data_026_5662:: ; heuristic: meta-sprite frame; C0
    db $F9, $F8, $0A, $10 ; entry 0
    db $F9, $00, $0B, $10 ; entry 1
    db $F1, $F8, $08, $10 ; entry 2
    db $F1, $00, $09, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set39Frame3::
Data_026_5673:: ; heuristic: meta-sprite frame; C0
    db $F1, $F9, $08, $10 ; entry 0
    db $F1, $01, $0C, $10 ; entry 1
    db $F9, $F9, $0D, $10 ; entry 2
    db $F9, $01, $0E, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set39Frame4::
Data_026_5684:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $04, $10 ; entry 0
    db $F1, $00, $05, $10 ; entry 1
    db $F9, $F8, $06, $10 ; entry 2
    db $F9, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set39Frame5::
Data_026_5695:: ; heuristic: meta-sprite frame; C0
    db $F9, $FF, $06, $30 ; entry 0
    db $F9, $F7, $07, $30 ; entry 1
    db $F1, $FF, $04, $30 ; entry 2
    db $F1, $F7, $05, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 58 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set3A::
Data_026_56A6:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set3AFrame0 ; entry 0
    dw MetaSprites26Set3AFrame1 ; entry 1
    dw MetaSprites26Set3AFrame2 ; entry 2
    dw MetaSprites26Set3AFrame3 ; entry 3
    dw MetaSprites26Set3AFrame4 ; entry 4
    dw MetaSprites26Set3AFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3AFrame0::
Data_026_56B2:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $00, $20 ; entry 1
    db $F9, $F8, $01, $00 ; entry 2
    db $F9, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3AFrame1::
Data_026_56C3:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $02, $00 ; entry 0
    db $F0, $00, $02, $20 ; entry 1
    db $F8, $F8, $03, $00 ; entry 2
    db $F8, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3AFrame2::
Data_026_56D4:: ; heuristic: meta-sprite frame; C0
    db $F1, $FF, $04, $00 ; entry 0
    db $F9, $F7, $05, $00 ; entry 1
    db $F9, $FF, $06, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3AFrame3::
Data_026_56E1:: ; heuristic: meta-sprite frame; C0
    db $F0, $FF, $07, $00 ; entry 0
    db $F8, $F7, $08, $00 ; entry 1
    db $F8, $FF, $09, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3AFrame4::
Data_026_56EE:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $0A, $00 ; entry 0
    db $F1, $00, $0A, $20 ; entry 1
    db $F9, $F8, $0B, $00 ; entry 2
    db $F9, $00, $0B, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3AFrame5::
Data_026_56FF:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0C, $20 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 59 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set3B::
Data_026_5710:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set3BFrame0 ; entry 0
    dw MetaSprites26Set3BFrame1 ; entry 1
    dw MetaSprites26Set3BFrame2 ; entry 2
    dw MetaSprites26Set3BFrame3 ; entry 3
    dw MetaSprites26Set3BFrame4 ; entry 4
    dw MetaSprites26Set3BFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set3B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3BFrame0::
Data_026_571C:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $FF, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set3B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3BFrame1::
Data_026_572D:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $02, $00 ; entry 0
    db $F8, $F8, $03, $00 ; entry 1
    db $F0, $FF, $02, $20 ; entry 2
    db $F8, $FF, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set3B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3BFrame2::
Data_026_573E:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set3B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3BFrame3::
Data_026_574F:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set3B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3BFrame4::
Data_026_5760:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $FF, $0C, $20 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $FF, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set3B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3BFrame5::
Data_026_5771:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0E, $00 ; entry 0
    db $F8, $F8, $0F, $00 ; entry 1
    db $F0, $FF, $0E, $20 ; entry 2
    db $F8, $FF, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 60 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set3C::
Data_026_5782:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set3CFrame0 ; entry 0
    dw MetaSprites26Set3CFrame1 ; entry 1
    dw MetaSprites26Set3CFrame2 ; entry 2
    dw MetaSprites26Set3CFrame3 ; entry 3
    dw MetaSprites26Set3CFrame4 ; entry 4
    dw MetaSprites26Set3CFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set3C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3CFrame0::
Data_026_578E:: ; heuristic: meta-sprite frame; C0
    db $F8, $F8, $02, $00 ; entry 0
    db $F0, $F8, $00, $00 ; entry 1
    db $F0, $00, $01, $00 ; entry 2
    db $F8, $FF, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set3C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3CFrame1::
Data_026_579F:: ; heuristic: meta-sprite frame; C0
    db $F0, $00, $00, $20 ; entry 0
    db $F0, $F8, $01, $20 ; entry 1
    db $F8, $F9, $03, $00 ; entry 2
    db $F8, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set3C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3CFrame2::
Data_026_57B0:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set3C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3CFrame3::
Data_026_57C1:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set3C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3CFrame4::
Data_026_57D2:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $FF, $0E, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set3C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3CFrame5::
Data_026_57E3:: ; heuristic: meta-sprite frame; C0
    db $F0, $FF, $0C, $20 ; entry 0
    db $F0, $F7, $0D, $20 ; entry 1
    db $F8, $F8, $0F, $00 ; entry 2
    db $F8, $FF, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 61 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set3D::
Data_026_57F4:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set3DFrame0 ; entry 0
    dw MetaSprites26Set3DFrame1 ; entry 1
    dw MetaSprites26Set3DFrame2 ; entry 2
    dw MetaSprites26Set3DFrame3 ; entry 3
    dw MetaSprites26Set3DFrame4 ; entry 4
    dw MetaSprites26Set3DFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set3D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3DFrame0::
Data_026_5800:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set3D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3DFrame1::
Data_026_5811:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $02, $00 ; entry 0
    db $F0, $00, $02, $20 ; entry 1
    db $F8, $F8, $03, $00 ; entry 2
    db $F8, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set3D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3DFrame2::
Data_026_5822:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set3D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3DFrame3::
Data_026_5833:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set3D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3DFrame4::
Data_026_5844:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0C, $20 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set3D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3DFrame5::
Data_026_5855:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0E, $00 ; entry 0
    db $F0, $00, $0E, $20 ; entry 1
    db $F8, $F8, $0F, $00 ; entry 2
    db $F8, $00, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 62 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set3E::
Data_026_5866:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set3EFrame0 ; entry 0
    dw MetaSprites26Set3EFrame1 ; entry 1
    dw MetaSprites26Set3EFrame2 ; entry 2
    dw MetaSprites26Set3EFrame3 ; entry 3
    dw MetaSprites26Set3EFrame4 ; entry 4
    dw MetaSprites26Set3EFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set3E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3EFrame0::
Data_026_5872:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set3E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3EFrame1::
Data_026_5883:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $02, $00 ; entry 0
    db $F1, $00, $02, $20 ; entry 1
    db $F9, $F8, $03, $00 ; entry 2
    db $F9, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set3E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3EFrame2::
Data_026_5894:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set3E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3EFrame3::
Data_026_58A5:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set3E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3EFrame4::
Data_026_58B6:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0C, $20 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set3E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3EFrame5::
Data_026_58C7:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $0E, $00 ; entry 0
    db $F1, $00, $0E, $20 ; entry 1
    db $F9, $F8, $0F, $00 ; entry 2
    db $F9, $00, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 63 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set3F::
Data_026_58D8:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set3FFrame0 ; entry 0
    dw MetaSprites26Set3FFrame1 ; entry 1
    dw MetaSprites26Set3FFrame2 ; entry 2
    dw MetaSprites26Set3FFrame3 ; entry 3
    dw MetaSprites26Set3FFrame4 ; entry 4
    dw MetaSprites26Set3FFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set3F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3FFrame0::
Data_026_58E4:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set3F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3FFrame1::
Data_026_58F5:: ; heuristic: meta-sprite frame; C0
    db $F9, $00, $02, $20 ; entry 0
    db $F9, $F8, $03, $20 ; entry 1
    db $F1, $00, $00, $20 ; entry 2
    db $F1, $F8, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set3F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3FFrame2::
Data_026_5906:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set3F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3FFrame3::
Data_026_5917:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set3F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3FFrame4::
Data_026_5928:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set3F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set3FFrame5::
Data_026_5939:: ; heuristic: meta-sprite frame; C0
    db $F1, $00, $0C, $20 ; entry 0
    db $F1, $F8, $0D, $20 ; entry 1
    db $F9, $00, $0E, $20 ; entry 2
    db $F9, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 64 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set40::
Data_026_594A:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set40Frame0 ; entry 0
    dw MetaSprites26Set40Frame1 ; entry 1
    dw MetaSprites26Set40Frame2 ; entry 2
    dw MetaSprites26Set40Frame3 ; entry 3
    dw MetaSprites26Set40Frame4 ; entry 4
    dw MetaSprites26Set40Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set40; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set40Frame0::
Data_026_5956:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $01, $00 ; entry 1
    db $F8, $00, $01, $20 ; entry 2
    db $F0, $00, $00, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set40; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set40Frame1::
Data_026_5967:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $02, $00 ; entry 0
    db $F1, $00, $02, $20 ; entry 1
    db $F9, $F8, $03, $00 ; entry 2
    db $F9, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set40; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set40Frame2::
Data_026_5978:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set40; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set40Frame3::
Data_026_5989:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set40; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set40Frame4::
Data_026_599A:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0C, $20 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set40; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set40Frame5::
Data_026_59AB:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $0E, $00 ; entry 0
    db $F1, $00, $0E, $20 ; entry 1
    db $F9, $F8, $0F, $00 ; entry 2
    db $F9, $00, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 65 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set41::
Data_026_59BC:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set41Frame0 ; entry 0
    dw MetaSprites26Set41Frame1 ; entry 1
    dw MetaSprites26Set41Frame2 ; entry 2
    dw MetaSprites26Set41Frame3 ; entry 3
    dw MetaSprites26Set41Frame4 ; entry 4
    dw MetaSprites26Set41Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set41; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set41Frame0::
Data_026_59C8:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set41; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set41Frame1::
Data_026_59D9:: ; heuristic: meta-sprite frame; C0
    db $EF, $F8, $02, $00 ; entry 0
    db $EF, $00, $02, $20 ; entry 1
    db $F7, $F8, $03, $00 ; entry 2
    db $F7, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set41; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set41Frame2::
Data_026_59EA:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set41; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set41Frame3::
Data_026_59FB:: ; heuristic: meta-sprite frame; C0
    db $EF, $F8, $08, $00 ; entry 0
    db $EF, $00, $09, $00 ; entry 1
    db $F7, $F8, $0A, $00 ; entry 2
    db $F7, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set41; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set41Frame4::
Data_026_5A0C:: ; heuristic: meta-sprite frame; C0
    db $F1, $00, $0C, $20 ; entry 0
    db $F9, $00, $0D, $20 ; entry 1
    db $F1, $F8, $0C, $00 ; entry 2
    db $F9, $F8, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set41; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set41Frame5::
Data_026_5A1D:: ; heuristic: meta-sprite frame; C0
    db $EF, $F8, $0E, $00 ; entry 0
    db $EF, $00, $0E, $20 ; entry 1
    db $F7, $F8, $0F, $00 ; entry 2
    db $F7, $00, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 66 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set42::
Data_026_5A2E:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set42Frame0 ; entry 0
    dw MetaSprites26Set42Frame1 ; entry 1
    dw MetaSprites26Set42Frame2 ; entry 2
    dw MetaSprites26Set42Frame3 ; entry 3
    dw MetaSprites26Set42Frame4 ; entry 4
    dw MetaSprites26Set42Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set42; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set42Frame0::
Data_026_5A3A:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $01, $00 ; entry 1
    db $F0, $00, $00, $20 ; entry 2
    db $F8, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set42; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set42Frame1::
Data_026_5A4B:: ; heuristic: meta-sprite frame; C0
    db $EF, $F8, $02, $00 ; entry 0
    db $F7, $F8, $03, $00 ; entry 1
    db $EF, $00, $02, $20 ; entry 2
    db $F7, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set42; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set42Frame2::
Data_026_5A5C:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set42; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set42Frame3::
Data_026_5A6D:: ; heuristic: meta-sprite frame; C0
    db $EF, $F8, $08, $00 ; entry 0
    db $EF, $00, $09, $00 ; entry 1
    db $F7, $F8, $0A, $00 ; entry 2
    db $F7, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set42; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set42Frame4::
Data_026_5A7E:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $00 ; entry 0
    db $F8, $F8, $0D, $00 ; entry 1
    db $F0, $00, $0C, $20 ; entry 2
    db $F8, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set42; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set42Frame5::
Data_026_5A8F:: ; heuristic: meta-sprite frame; C0
    db $EF, $F8, $0E, $00 ; entry 0
    db $F7, $F8, $0F, $00 ; entry 1
    db $EF, $00, $0E, $20 ; entry 2
    db $F7, $00, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 67 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set43::
Data_026_5AA0:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set43Frame0 ; entry 0
    dw MetaSprites26Set43Frame1 ; entry 1
    dw MetaSprites26Set43Frame2 ; entry 2
    dw MetaSprites26Set43Frame3 ; entry 3
    dw MetaSprites26Set43Frame4 ; entry 4
    dw MetaSprites26Set43Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set43; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set43Frame0::
Data_026_5AAC:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $02, $00 ; entry 1
    db $F0, $00, $01, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set43; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set43Frame1::
Data_026_5ABD:: ; heuristic: meta-sprite frame; C0
    db $F1, $FF, $00, $20 ; entry 0
    db $F1, $F7, $01, $20 ; entry 1
    db $F9, $FF, $02, $20 ; entry 2
    db $F9, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set43; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set43Frame2::
Data_026_5ACE:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set43; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set43Frame3::
Data_026_5ADF:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set43; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set43Frame4::
Data_026_5AF0:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set43; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set43Frame5::
Data_026_5B01:: ; heuristic: meta-sprite frame; C0
    db $F1, $FF, $0C, $20 ; entry 0
    db $F1, $F7, $0D, $20 ; entry 1
    db $F9, $FF, $0E, $20 ; entry 2
    db $F9, $F7, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 68 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set44::
Data_026_5B12:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set44Frame0 ; entry 0
    dw MetaSprites26Set44Frame1 ; entry 1
    dw MetaSprites26Set44Frame2 ; entry 2
    dw MetaSprites26Set44Frame3 ; entry 3
    dw MetaSprites26Set44Frame4 ; entry 4
    dw MetaSprites26Set44Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set44; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set44Frame0::
Data_026_5B1E:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $FF, $00, $30 ; entry 1
    db $F8, $F8, $01, $10 ; entry 2
    db $F8, $00, $02, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set44; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set44Frame1::
Data_026_5B2F:: ; heuristic: meta-sprite frame; C0
    db $F1, $FF, $00, $30 ; entry 0
    db $F1, $F8, $00, $10 ; entry 1
    db $F9, $FF, $01, $30 ; entry 2
    db $F9, $F7, $02, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set44; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set44Frame2::
Data_026_5B40:: ; heuristic: meta-sprite frame; C0
    db $F0, $F9, $03, $10 ; entry 0
    db $F0, $01, $04, $10 ; entry 1
    db $F8, $F9, $05, $10 ; entry 2
    db $F8, $01, $06, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set44; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set44Frame3::
Data_026_5B51:: ; heuristic: meta-sprite frame; C0
    db $F1, $F9, $03, $10 ; entry 0
    db $F1, $01, $04, $10 ; entry 1
    db $F9, $F9, $07, $10 ; entry 2
    db $F9, $01, $08, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set44; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set44Frame4::
Data_026_5B62:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $09, $10 ; entry 0
    db $F0, $FF, $09, $30 ; entry 1
    db $F8, $F8, $0A, $10 ; entry 2
    db $F8, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set44; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set44Frame5::
Data_026_5B73:: ; heuristic: meta-sprite frame; C0
    db $F1, $FF, $09, $30 ; entry 0
    db $F1, $F8, $09, $10 ; entry 1
    db $F9, $FF, $0A, $30 ; entry 2
    db $F9, $F7, $0B, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 69 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set45::
Data_026_5B84:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set45Frame0 ; entry 0
    dw MetaSprites26Set45Frame1 ; entry 1
    dw MetaSprites26Set45Frame2 ; entry 2
    dw MetaSprites26Set45Frame3 ; entry 3
    dw MetaSprites26Set45Frame4 ; entry 4
    dw MetaSprites26Set45Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set45; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set45Frame0::
Data_026_5B90:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $02, $00 ; entry 1
    db $F0, $00, $01, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set45; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set45Frame1::
Data_026_5BA1:: ; heuristic: meta-sprite frame; C0
    db $F1, $00, $00, $20 ; entry 0
    db $F1, $F8, $01, $20 ; entry 1
    db $F9, $00, $02, $20 ; entry 2
    db $F9, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set45; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set45Frame2::
Data_026_5BB2:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set45; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set45Frame3::
Data_026_5BC3:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set45; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set45Frame4::
Data_026_5BD4:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set45; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set45Frame5::
Data_026_5BE5:: ; heuristic: meta-sprite frame; C0
    db $F1, $00, $0C, $20 ; entry 0
    db $F1, $F8, $0D, $20 ; entry 1
    db $F9, $00, $0E, $20 ; entry 2
    db $F9, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 70 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set46::
Data_026_5BF6:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set46Frame0 ; entry 0
    dw MetaSprites26Set46Frame1 ; entry 1
    dw MetaSprites26Set46Frame2 ; entry 2
    dw MetaSprites26Set46Frame3 ; entry 3
    dw MetaSprites26Set46Frame4 ; entry 4
    dw MetaSprites26Set46Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set46; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set46Frame0::
Data_026_5C02:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set46; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set46Frame1::
Data_026_5C13:: ; heuristic: meta-sprite frame; C0
    db $F0, $00, $00, $30 ; entry 0
    db $F0, $F8, $01, $30 ; entry 1
    db $F8, $00, $02, $30 ; entry 2
    db $F8, $F8, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set46; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set46Frame2::
Data_026_5C24:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set46; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set46Frame3::
Data_026_5C35:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $08, $10 ; entry 0
    db $F0, $00, $09, $10 ; entry 1
    db $F8, $F8, $0A, $10 ; entry 2
    db $F8, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set46; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set46Frame4::
Data_026_5C46:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $10 ; entry 0
    db $F0, $00, $0D, $10 ; entry 1
    db $F8, $F8, $0E, $10 ; entry 2
    db $F8, $00, $0F, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set46; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set46Frame5::
Data_026_5C57:: ; heuristic: meta-sprite frame; C0
    db $F0, $00, $0C, $30 ; entry 0
    db $F0, $F8, $0D, $30 ; entry 1
    db $F8, $00, $0E, $30 ; entry 2
    db $F8, $F8, $0F, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 71 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set47::
Data_026_5C68:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set47Frame0 ; entry 0
    dw MetaSprites26Set47Frame1 ; entry 1
    dw MetaSprites26Set47Frame2 ; entry 2
    dw MetaSprites26Set47Frame3 ; entry 3
    dw MetaSprites26Set47Frame4 ; entry 4
    dw MetaSprites26Set47Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set47; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set47Frame0::
Data_026_5C74:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $FF, $00, $30 ; entry 1
    db $F8, $F8, $01, $10 ; entry 2
    db $F8, $FF, $01, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set47; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set47Frame1::
Data_026_5C85:: ; heuristic: meta-sprite frame; C0
    db $EF, $F8, $02, $10 ; entry 0
    db $EF, $FF, $02, $30 ; entry 1
    db $F7, $F8, $03, $10 ; entry 2
    db $F7, $FF, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set47; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set47Frame2::
Data_026_5C96:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set47; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set47Frame3::
Data_026_5CA7:: ; heuristic: meta-sprite frame; C0
    db $EF, $F8, $08, $10 ; entry 0
    db $EF, $00, $09, $10 ; entry 1
    db $F7, $F8, $0A, $10 ; entry 2
    db $F7, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set47; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set47Frame4::
Data_026_5CB8:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $10 ; entry 0
    db $F8, $F8, $0D, $10 ; entry 1
    db $F0, $FF, $0C, $30 ; entry 2
    db $F8, $FF, $0D, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set47; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set47Frame5::
Data_026_5CC9:: ; heuristic: meta-sprite frame; C0
    db $EF, $F8, $0E, $10 ; entry 0
    db $F7, $F8, $0F, $10 ; entry 1
    db $EF, $FF, $0E, $30 ; entry 2
    db $F7, $FF, $0F, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 72 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set48::
Data_026_5CDA:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set48Frame0 ; entry 0
    dw MetaSprites26Set48Frame1 ; entry 1
    dw MetaSprites26Set48Frame2 ; entry 2
    dw MetaSprites26Set48Frame3 ; entry 3
    dw MetaSprites26Set48Frame4 ; entry 4
    dw MetaSprites26Set48Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set48; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set48Frame0::
Data_026_5CE6:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $02, $00 ; entry 1
    db $F0, $00, $01, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set48; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set48Frame1::
Data_026_5CF7:: ; heuristic: meta-sprite frame; C0
    db $F1, $00, $00, $20 ; entry 0
    db $F1, $F8, $01, $20 ; entry 1
    db $F9, $00, $02, $20 ; entry 2
    db $F9, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set48; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set48Frame2::
Data_026_5D08:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set48; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set48Frame3::
Data_026_5D19:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set48; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set48Frame4::
Data_026_5D2A:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set48; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set48Frame5::
Data_026_5D3B:: ; heuristic: meta-sprite frame; C0
    db $F1, $00, $0C, $20 ; entry 0
    db $F1, $F8, $0D, $20 ; entry 1
    db $F9, $00, $0E, $20 ; entry 2
    db $F9, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 73 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set49::
Data_026_5D4C:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set49Frame0 ; entry 0
    dw MetaSprites26Set49Frame1 ; entry 1
    dw MetaSprites26Set49Frame2 ; entry 2
    dw MetaSprites26Set49Frame3 ; entry 3
    dw MetaSprites26Set49Frame4 ; entry 4
    dw MetaSprites26Set49Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set49; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set49Frame0::
Data_026_5D58:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set49; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set49Frame1::
Data_026_5D69:: ; heuristic: meta-sprite frame; C0
    db $F0, $00, $00, $20 ; entry 0
    db $F0, $F8, $01, $20 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set49; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set49Frame2::
Data_026_5D7A:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set49; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set49Frame3::
Data_026_5D8B:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set49; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set49Frame4::
Data_026_5D9C:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set49; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set49Frame5::
Data_026_5DAD:: ; heuristic: meta-sprite frame; C0
    db $F0, $00, $0C, $20 ; entry 0
    db $F0, $F8, $0D, $20 ; entry 1
    db $F8, $00, $0E, $20 ; entry 2
    db $F8, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 74 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set4A::
Data_026_5DBE:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set4AFrame0 ; entry 0
    dw MetaSprites26Set4AFrame1 ; entry 1
    dw MetaSprites26Set4AFrame2 ; entry 2
    dw MetaSprites26Set4AFrame3 ; entry 3
    dw MetaSprites26Set4AFrame4 ; entry 4
    dw MetaSprites26Set4AFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set4A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set4AFrame0::
Data_026_5DCA:: ; heuristic: meta-sprite frame; C0
    db $F8, $F8, $01, $00 ; entry 0
    db $F0, $F8, $00, $00 ; entry 1
    db $F8, $FF, $01, $20 ; entry 2
    db $F0, $FF, $00, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set4A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set4AFrame1::
Data_026_5DDB:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $02, $00 ; entry 0
    db $F8, $F8, $03, $00 ; entry 1
    db $F0, $FF, $02, $20 ; entry 2
    db $F8, $FF, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set4A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set4AFrame2::
Data_026_5DEC:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set4A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set4AFrame3::
Data_026_5DFD:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set4A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set4AFrame4::
Data_026_5E0E:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $00 ; entry 0
    db $F8, $F8, $0D, $00 ; entry 1
    db $F0, $FF, $0C, $20 ; entry 2
    db $F8, $FF, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set4A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set4AFrame5::
Data_026_5E1F:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0E, $00 ; entry 0
    db $F8, $F8, $0F, $00 ; entry 1
    db $F0, $FF, $0E, $20 ; entry 2
    db $F8, $FF, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 84 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set54::
Data_026_5E30:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set54Frame0 ; entry 0
    dw MetaSprites26Set54Frame1 ; entry 1
    dw MetaSprites26Set54Frame2 ; entry 2
    dw MetaSprites26Set54Frame3 ; entry 3
    dw MetaSprites26Set54Frame4 ; entry 4
    dw MetaSprites26Set54Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set54; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set54Frame0::
Data_026_5E3C:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $00, $10 ; entry 0
    db $F1, $00, $00, $30 ; entry 1
    db $F9, $F8, $01, $10 ; entry 2
    db $F9, $00, $01, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set54; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set54Frame1::
Data_026_5E4D:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $02, $10 ; entry 0
    db $F0, $00, $02, $30 ; entry 1
    db $F8, $F8, $03, $10 ; entry 2
    db $F8, $00, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set54; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set54Frame2::
Data_026_5E5E:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $04, $10 ; entry 0
    db $F1, $00, $05, $10 ; entry 1
    db $F9, $F8, $06, $10 ; entry 2
    db $F9, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set54; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set54Frame3::
Data_026_5E6F:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $08, $10 ; entry 0
    db $F0, $00, $09, $10 ; entry 1
    db $F8, $F8, $0A, $10 ; entry 2
    db $F8, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set54; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set54Frame4::
Data_026_5E80:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $0C, $10 ; entry 0
    db $F1, $00, $0C, $30 ; entry 1
    db $F9, $F8, $0D, $10 ; entry 2
    db $F9, $00, $0D, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set54; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set54Frame5::
Data_026_5E91:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0E, $10 ; entry 0
    db $F0, $00, $0E, $30 ; entry 1
    db $F8, $F8, $0F, $10 ; entry 2
    db $F8, $00, $0F, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 85 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set55::
Data_026_5EA2:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set55Frame0 ; entry 0
    dw MetaSprites26Set55Frame1 ; entry 1
    dw MetaSprites26Set55Frame2 ; entry 2
    dw MetaSprites26Set55Frame3 ; entry 3
    dw MetaSprites26Set55Frame4 ; entry 4
    dw MetaSprites26Set55Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set55; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set55Frame0::
Data_026_5EAE:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set55; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set55Frame1::
Data_026_5EBF:: ; heuristic: meta-sprite frame; C0
    db $F1, $00, $00, $20 ; entry 0
    db $F1, $F8, $01, $20 ; entry 1
    db $F9, $00, $02, $20 ; entry 2
    db $F9, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set55; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set55Frame2::
Data_026_5ED0:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $04, $00 ; entry 0
    db $F1, $00, $05, $00 ; entry 1
    db $F9, $F8, $06, $00 ; entry 2
    db $F9, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set55; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set55Frame3::
Data_026_5EE1:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set55; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set55Frame4::
Data_026_5EF2:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set55; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set55Frame5::
Data_026_5F03:: ; heuristic: meta-sprite frame; C0
    db $F1, $00, $0C, $20 ; entry 0
    db $F1, $F8, $0D, $20 ; entry 1
    db $F9, $00, $0E, $20 ; entry 2
    db $F9, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 86 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set56::
Data_026_5F14:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set56Frame0 ; entry 0
    dw MetaSprites26Set56Frame1 ; entry 1
    dw MetaSprites26Set56Frame2 ; entry 2
    dw MetaSprites26Set56Frame3 ; entry 3
    dw MetaSprites26Set56Frame4 ; entry 4
    dw MetaSprites26Set56Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set56; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set56Frame0::
Data_026_5F20:: ; heuristic: meta-sprite frame; C0
    db $F3, $F9, $00, $00 ; entry 0
    db $F3, $01, $01, $00 ; entry 1
    db $FB, $F9, $02, $00 ; entry 2
    db $FB, $01, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set56; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set56Frame1::
Data_026_5F31:: ; heuristic: meta-sprite frame; C0
    db $F2, $F9, $00, $00 ; entry 0
    db $F2, $01, $01, $00 ; entry 1
    db $FA, $F9, $04, $00 ; entry 2
    db $FA, $01, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set56; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set56Frame2::
Data_026_5F42:: ; heuristic: meta-sprite frame; C0
    db $F0, $F6, $0A, $00 ; entry 0
    db $F0, $FE, $0B, $00 ; entry 1
    db $F8, $F6, $0C, $00 ; entry 2
    db $F8, $FE, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set56; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set56Frame3::
Data_026_5F53:: ; heuristic: meta-sprite frame; C0
    db $F1, $F6, $0A, $00 ; entry 0
    db $F1, $FE, $0B, $00 ; entry 1
    db $F9, $FE, $0E, $00 ; entry 2
    db $F9, $F6, $0C, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set56; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set56Frame4::
Data_026_5F64:: ; heuristic: meta-sprite frame; C0
    db $F3, $F6, $06, $00 ; entry 0
    db $F3, $FE, $07, $00 ; entry 1
    db $FB, $FE, $08, $00 ; entry 2
    db $FB, $F6, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set56; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set56Frame5::
Data_026_5F75:: ; heuristic: meta-sprite frame; C0
    db $F2, $F6, $06, $00 ; entry 0
    db $F2, $FE, $07, $00 ; entry 1
    db $FA, $FE, $09, $00 ; entry 2
    db $FA, $F6, $05, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 87 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set57::
Data_026_5F86:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set57Frame0 ; entry 0
    dw MetaSprites26Set57Frame1 ; entry 1
    dw MetaSprites26Set57Frame2 ; entry 2
    dw MetaSprites26Set57Frame3 ; entry 3
    dw MetaSprites26Set57Frame4 ; entry 4
    dw MetaSprites26Set57Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set57; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set57Frame0::
Data_026_5F92:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $FF, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set57; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set57Frame1::
Data_026_5FA3:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $FF, $00, $20 ; entry 1
    db $F9, $F8, $02, $00 ; entry 2
    db $F9, $FF, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set57; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set57Frame2::
Data_026_5FB4:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $03, $00 ; entry 0
    db $F0, $00, $04, $00 ; entry 1
    db $F8, $F8, $05, $00 ; entry 2
    db $F8, $00, $06, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set57; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set57Frame3::
Data_026_5FC5:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $03, $00 ; entry 0
    db $F1, $00, $04, $00 ; entry 1
    db $F9, $F8, $07, $00 ; entry 2
    db $F9, $00, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set57; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set57Frame4::
Data_026_5FD6:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $09, $00 ; entry 0
    db $F0, $FF, $09, $20 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set57; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set57Frame5::
Data_026_5FE7:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $09, $00 ; entry 0
    db $F1, $FF, $09, $20 ; entry 1
    db $F9, $F8, $0C, $00 ; entry 2
    db $F9, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 88 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set58::
Data_026_5FF8:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set58Frame0 ; entry 0
    dw MetaSprites26Set58Frame1 ; entry 1
    dw MetaSprites26Set58Frame2 ; entry 2
    dw MetaSprites26Set58Frame3 ; entry 3
    dw MetaSprites26Set58Frame4 ; entry 4
    dw MetaSprites26Set58Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set58; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set58Frame0::
Data_026_6004:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $00, $30 ; entry 1
    db $F8, $F8, $01, $10 ; entry 2
    db $F8, $00, $02, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set58; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set58Frame1::
Data_026_6015:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $00, $10 ; entry 0
    db $F1, $00, $00, $30 ; entry 1
    db $F9, $F8, $03, $10 ; entry 2
    db $F9, $00, $04, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set58; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set58Frame2::
Data_026_6026:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $05, $10 ; entry 0
    db $F8, $F8, $07, $10 ; entry 1
    db $F8, $00, $08, $10 ; entry 2
    db $F0, $00, $06, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set58; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set58Frame3::
Data_026_6037:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $05, $10 ; entry 0
    db $F1, $00, $06, $10 ; entry 1
    db $F9, $F8, $09, $10 ; entry 2
    db $F9, $00, $0A, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set58; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set58Frame4::
Data_026_6048:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0B, $10 ; entry 0
    db $F0, $00, $0B, $30 ; entry 1
    db $F8, $F8, $0C, $10 ; entry 2
    db $F8, $00, $0D, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set58; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set58Frame5::
Data_026_6059:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $0B, $10 ; entry 0
    db $F1, $00, $0B, $30 ; entry 1
    db $F9, $F8, $0E, $10 ; entry 2
    db $F9, $00, $0F, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 89 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set59::
Data_026_606A:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set59Frame0 ; entry 0
    dw MetaSprites26Set59Frame1 ; entry 1
    dw MetaSprites26Set59Frame2 ; entry 2
    dw MetaSprites26Set59Frame3 ; entry 3
    dw MetaSprites26Set59Frame4 ; entry 4
    dw MetaSprites26Set59Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set59; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set59Frame0::
Data_026_6076:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set59; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set59Frame1::
Data_026_6087:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $02, $00 ; entry 0
    db $F0, $00, $02, $20 ; entry 1
    db $F8, $F8, $03, $00 ; entry 2
    db $F8, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set59; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set59Frame2::
Data_026_6098:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set59; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set59Frame3::
Data_026_60A9:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set59; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set59Frame4::
Data_026_60BA:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0C, $20 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set59; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set59Frame5::
Data_026_60CB:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0E, $00 ; entry 0
    db $F0, $00, $0E, $20 ; entry 1
    db $F8, $F8, $0F, $00 ; entry 2
    db $F8, $00, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 90 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set5A::
Data_026_60DC:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set5AFrame0 ; entry 0
    dw MetaSprites26Set5AFrame1 ; entry 1
    dw MetaSprites26Set5AFrame2 ; entry 2
    dw MetaSprites26Set5AFrame3 ; entry 3
    dw MetaSprites26Set5AFrame4 ; entry 4
    dw MetaSprites26Set5AFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set5A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5AFrame0::
Data_026_60E8:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set5A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5AFrame1::
Data_026_60F9:: ; heuristic: meta-sprite frame; C0
    db $F8, $F8, $03, $00 ; entry 0
    db $F8, $00, $04, $00 ; entry 1
    db $F0, $F9, $00, $00 ; entry 2
    db $F0, $00, $00, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set5A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5AFrame2::
Data_026_610A:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $05, $00 ; entry 0
    db $F0, $00, $06, $00 ; entry 1
    db $F8, $F8, $07, $00 ; entry 2
    db $F8, $00, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set5A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5AFrame3::
Data_026_611B:: ; heuristic: meta-sprite frame; C0
    db $F0, $00, $06, $00 ; entry 0
    db $F0, $F8, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set5A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5AFrame4::
Data_026_612C:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $FF, $0C, $20 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0E, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set5A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5AFrame5::
Data_026_613D:: ; heuristic: meta-sprite frame; C0
    db $F8, $00, $0D, $20 ; entry 0
    db $F8, $F8, $0E, $20 ; entry 1
    db $F0, $F9, $0F, $00 ; entry 2
    db $F0, $00, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 91 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set5B::
Data_026_614E:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set5BFrame0 ; entry 0
    dw MetaSprites26Set5BFrame1 ; entry 1
    dw MetaSprites26Set5BFrame2 ; entry 2
    dw MetaSprites26Set5BFrame3 ; entry 3
    dw MetaSprites26Set5BFrame4 ; entry 4
    dw MetaSprites26Set5BFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set5B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5BFrame0::
Data_026_615A:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set5B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5BFrame1::
Data_026_616B:: ; heuristic: meta-sprite frame; C0
    db $F1, $00, $00, $20 ; entry 0
    db $F1, $F8, $01, $20 ; entry 1
    db $F9, $00, $02, $20 ; entry 2
    db $F9, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set5B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5BFrame2::
Data_026_617C:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set5B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5BFrame3::
Data_026_618D:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set5B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5BFrame4::
Data_026_619E:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set5B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5BFrame5::
Data_026_61AF:: ; heuristic: meta-sprite frame; C0
    db $F1, $00, $0C, $20 ; entry 0
    db $F1, $F8, $0D, $20 ; entry 1
    db $F9, $00, $0E, $20 ; entry 2
    db $F9, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 92 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set5C::
Data_026_61C0:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set5CFrame0 ; entry 0
    dw MetaSprites26Set5CFrame1 ; entry 1
    dw MetaSprites26Set5CFrame2 ; entry 2
    dw MetaSprites26Set5CFrame3 ; entry 3
    dw MetaSprites26Set5CFrame4 ; entry 4
    dw MetaSprites26Set5CFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set5C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5CFrame0::
Data_026_61CC:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set5C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5CFrame1::
Data_026_61DD:: ; heuristic: meta-sprite frame; C0
    db $EF, $F8, $00, $00 ; entry 0
    db $EF, $00, $01, $00 ; entry 1
    db $F7, $FF, $02, $20 ; entry 2
    db $F7, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set5C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5CFrame2::
Data_026_61EE:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set5C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5CFrame3::
Data_026_61FF:: ; heuristic: meta-sprite frame; C0
    db $EF, $F8, $04, $00 ; entry 0
    db $EF, $00, $05, $00 ; entry 1
    db $F7, $F8, $08, $00 ; entry 2
    db $F7, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set5C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5CFrame4::
Data_026_6210:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set5C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5CFrame5::
Data_026_6221:: ; heuristic: meta-sprite frame; C0
    db $EF, $F8, $0A, $00 ; entry 0
    db $EF, $00, $0B, $00 ; entry 1
    db $F7, $01, $0C, $20 ; entry 2
    db $F7, $F9, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 93 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set5D::
Data_026_6232:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set5DFrame0 ; entry 0
    dw MetaSprites26Set5DFrame1 ; entry 1
    dw MetaSprites26Set5DFrame2 ; entry 2
    dw MetaSprites26Set5DFrame3 ; entry 3
    dw MetaSprites26Set5DFrame4 ; entry 4
    dw MetaSprites26Set5DFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set5D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5DFrame0::
Data_026_623E:: ; heuristic: meta-sprite frame; C0
    db $F0, $F9, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F9, $01, $00 ; entry 2
    db $F8, $01, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set5D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5DFrame1::
Data_026_624F:: ; heuristic: meta-sprite frame; C0
    db $F8, $00, $01, $20 ; entry 0
    db $F8, $F8, $02, $20 ; entry 1
    db $F0, $F9, $03, $00 ; entry 2
    db $F0, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set5D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5DFrame2::
Data_026_6260:: ; heuristic: meta-sprite frame; C0
    db $F0, $F5, $04, $00 ; entry 0
    db $F0, $FD, $05, $00 ; entry 1
    db $F8, $F5, $06, $00 ; entry 2
    db $F8, $FD, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set5D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5DFrame3::
Data_026_6271:: ; heuristic: meta-sprite frame; C0
    db $F0, $FD, $05, $00 ; entry 0
    db $F8, $F5, $06, $40 ; entry 1
    db $F0, $F5, $08, $00 ; entry 2
    db $F8, $FD, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set5D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5DFrame4::
Data_026_6282:: ; heuristic: meta-sprite frame; C0
    db $F8, $F8, $0B, $00 ; entry 0
    db $F8, $00, $0C, $00 ; entry 1
    db $F0, $FF, $0A, $20 ; entry 2
    db $F0, $F8, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set5D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5DFrame5::
Data_026_6293:: ; heuristic: meta-sprite frame; C0
    db $F8, $FF, $0B, $20 ; entry 0
    db $F8, $F7, $0C, $20 ; entry 1
    db $F0, $F8, $0D, $00 ; entry 2
    db $F0, $FF, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 94 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set5E::
Data_026_62A4:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set5EFrame0 ; entry 0
    dw MetaSprites26Set5EFrame1 ; entry 1
    dw MetaSprites26Set5EFrame2 ; entry 2
    dw MetaSprites26Set5EFrame3 ; entry 3
    dw MetaSprites26Set5EFrame4 ; entry 4
    dw MetaSprites26Set5EFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set5E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5EFrame0::
Data_026_62B0:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set5E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5EFrame1::
Data_026_62C1:: ; heuristic: meta-sprite frame; C0
    db $F0, $00, $00, $20 ; entry 0
    db $F0, $F8, $01, $20 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set5E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5EFrame2::
Data_026_62D2:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set5E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5EFrame3::
Data_026_62E3:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set5E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5EFrame4::
Data_026_62F4:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set5E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5EFrame5::
Data_026_6305:: ; heuristic: meta-sprite frame; C0
    db $F0, $00, $0C, $20 ; entry 0
    db $F0, $F8, $0D, $20 ; entry 1
    db $F8, $00, $0E, $20 ; entry 2
    db $F8, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 95 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set5F::
Data_026_6316:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set5FFrame0 ; entry 0
    dw MetaSprites26Set5FFrame1 ; entry 1
    dw MetaSprites26Set5FFrame2 ; entry 2
    dw MetaSprites26Set5FFrame3 ; entry 3
    dw MetaSprites26Set5FFrame4 ; entry 4
    dw MetaSprites26Set5FFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set5F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5FFrame0::
Data_026_6322:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set5F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5FFrame1::
Data_026_6333:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $03, $00 ; entry 2
    db $F8, $00, $04, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set5F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5FFrame2::
Data_026_6344:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $05, $00 ; entry 0
    db $F0, $00, $06, $00 ; entry 1
    db $F8, $F8, $07, $00 ; entry 2
    db $F8, $00, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set5F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5FFrame3::
Data_026_6355:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $05, $00 ; entry 0
    db $F0, $00, $06, $00 ; entry 1
    db $F8, $F8, $09, $00 ; entry 2
    db $F8, $00, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set5F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5FFrame4::
Data_026_6366:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $FF, $0B, $20 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set5F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set5FFrame5::
Data_026_6377:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $FF, $0B, $20 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 96 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set60::
Data_026_6388:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set60Frame0 ; entry 0
    dw MetaSprites26Set60Frame1 ; entry 1
    dw MetaSprites26Set60Frame2 ; entry 2
    dw MetaSprites26Set60Frame3 ; entry 3
    dw MetaSprites26Set60Frame4 ; entry 4
    dw MetaSprites26Set60Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set60; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set60Frame0::
Data_026_6394:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set60; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set60Frame1::
Data_026_63A5:: ; heuristic: meta-sprite frame; C0
    db $EE, $00, $00, $20 ; entry 0
    db $EE, $F8, $01, $20 ; entry 1
    db $F6, $00, $02, $20 ; entry 2
    db $F6, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set60; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set60Frame2::
Data_026_63B6:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set60; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set60Frame3::
Data_026_63C7:: ; heuristic: meta-sprite frame; C0
    db $EF, $F8, $04, $00 ; entry 0
    db $EF, $00, $05, $00 ; entry 1
    db $F7, $F8, $06, $00 ; entry 2
    db $F7, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set60; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set60Frame4::
Data_026_63D8:: ; heuristic: meta-sprite frame; C0
    db $F1, $00, $0C, $20 ; entry 0
    db $F1, $F8, $0D, $20 ; entry 1
    db $F9, $00, $0E, $20 ; entry 2
    db $F9, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set60; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set60Frame5::
Data_026_63E9:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 97 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set61::
Data_026_63FA:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set61Frame0 ; entry 0
    dw MetaSprites26Set61Frame1 ; entry 1
    dw MetaSprites26Set61Frame2 ; entry 2
    dw MetaSprites26Set61Frame3 ; entry 3
    dw MetaSprites26Set61Frame4 ; entry 4
    dw MetaSprites26Set61Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set61; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set61Frame0::
Data_026_6406:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set61; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set61Frame1::
Data_026_6417:: ; heuristic: meta-sprite frame; C0
    db $F8, $F8, $04, $00 ; entry 0
    db $F8, $00, $05, $00 ; entry 1
    db $F0, $F7, $00, $00 ; entry 2
    db $F0, $FF, $01, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set61; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set61Frame2::
Data_026_6428:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set61; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set61Frame3::
Data_026_6439:: ; heuristic: meta-sprite frame; C0
    db $F0, $F9, $06, $00 ; entry 0
    db $F0, $01, $07, $00 ; entry 1
    db $F8, $F9, $0A, $00 ; entry 2
    db $F8, $01, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set61; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set61Frame4::
Data_026_644A:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set61; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set61Frame5::
Data_026_645B:: ; heuristic: meta-sprite frame; C0
    db $F8, $00, $0E, $20 ; entry 0
    db $F8, $F8, $0F, $20 ; entry 1
    db $F0, $F7, $0C, $00 ; entry 2
    db $F0, $FF, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 98 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set62::
Data_026_646C:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set62Frame0 ; entry 0
    dw MetaSprites26Set62Frame1 ; entry 1
    dw MetaSprites26Set62Frame2 ; entry 2
    dw MetaSprites26Set62Frame3 ; entry 3
    dw MetaSprites26Set62Frame4 ; entry 4
    dw MetaSprites26Set62Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set62; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set62Frame0::
Data_026_6478:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set62; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set62Frame1::
Data_026_6489:: ; heuristic: meta-sprite frame; C0
    db $EF, $00, $00, $20 ; entry 0
    db $EF, $F8, $01, $20 ; entry 1
    db $F7, $00, $02, $20 ; entry 2
    db $F7, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set62; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set62Frame2::
Data_026_649A:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set62; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set62Frame3::
Data_026_64AB:: ; heuristic: meta-sprite frame; C0
    db $EF, $F8, $08, $00 ; entry 0
    db $EF, $00, $09, $00 ; entry 1
    db $F7, $F8, $0A, $00 ; entry 2
    db $F7, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set62; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set62Frame4::
Data_026_64BC:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set62; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set62Frame5::
Data_026_64CD:: ; heuristic: meta-sprite frame; C0
    db $EF, $00, $0C, $20 ; entry 0
    db $EF, $F8, $0D, $20 ; entry 1
    db $F7, $00, $0E, $20 ; entry 2
    db $F7, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 99 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set63::
Data_026_64DE:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set63Frame0 ; entry 0
    dw MetaSprites26Set63Frame1 ; entry 1
    dw MetaSprites26Set63Frame2 ; entry 2
    dw MetaSprites26Set63Frame3 ; entry 3
    dw MetaSprites26Set63Frame4 ; entry 4
    dw MetaSprites26Set63Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set63; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set63Frame0::
Data_026_64EA:: ; heuristic: meta-sprite frame; C0
    db $F8, $F8, $01, $00 ; entry 0
    db $F8, $00, $02, $00 ; entry 1
    db $F0, $F9, $00, $00 ; entry 2
    db $F0, $00, $00, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set63; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set63Frame1::
Data_026_64FB:: ; heuristic: meta-sprite frame; C0
    db $F0, $FA, $00, $00 ; entry 0
    db $F0, $01, $00, $20 ; entry 1
    db $F8, $F9, $03, $00 ; entry 2
    db $F8, $01, $04, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set63; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set63Frame2::
Data_026_650C:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $05, $00 ; entry 0
    db $F0, $00, $06, $00 ; entry 1
    db $F8, $F8, $07, $00 ; entry 2
    db $F8, $00, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set63; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set63Frame3::
Data_026_651D:: ; heuristic: meta-sprite frame; C0
    db $F0, $F7, $05, $00 ; entry 0
    db $F0, $FF, $06, $00 ; entry 1
    db $F8, $F7, $09, $00 ; entry 2
    db $F8, $FF, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set63; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set63Frame4::
Data_026_652E:: ; heuristic: meta-sprite frame; C0
    db $F8, $F8, $0C, $00 ; entry 0
    db $F8, $00, $0E, $00 ; entry 1
    db $F0, $F9, $0B, $00 ; entry 2
    db $F0, $00, $0B, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set63; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set63Frame5::
Data_026_653F:: ; heuristic: meta-sprite frame; C0
    db $F8, $00, $0D, $20 ; entry 0
    db $F8, $F8, $0E, $20 ; entry 1
    db $F0, $F8, $0B, $00 ; entry 2
    db $F0, $FF, $0B, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 100 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set64::
Data_026_6550:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set64Frame0 ; entry 0
    dw MetaSprites26Set64Frame1 ; entry 1
    dw MetaSprites26Set64Frame2 ; entry 2
    dw MetaSprites26Set64Frame3 ; entry 3
    dw MetaSprites26Set64Frame4 ; entry 4
    dw MetaSprites26Set64Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set64; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set64Frame0::
Data_026_655C:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set64; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set64Frame1::
Data_026_656D:: ; heuristic: meta-sprite frame; C0
    db $F0, $00, $00, $20 ; entry 0
    db $F0, $F8, $01, $20 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set64; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set64Frame2::
Data_026_657E:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set64; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set64Frame3::
Data_026_658F:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set64; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set64Frame4::
Data_026_65A0:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set64; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set64Frame5::
Data_026_65B1:: ; heuristic: meta-sprite frame; C0
    db $F0, $00, $0C, $20 ; entry 0
    db $F0, $F8, $0D, $20 ; entry 1
    db $F8, $00, $0E, $20 ; entry 2
    db $F8, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 101 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set65::
Data_026_65C2:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set65Frame0 ; entry 0
    dw MetaSprites26Set65Frame1 ; entry 1
    dw MetaSprites26Set65Frame2 ; entry 2
    dw MetaSprites26Set65Frame3 ; entry 3
    dw MetaSprites26Set65Frame4 ; entry 4
    dw MetaSprites26Set65Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set65; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set65Frame0::
Data_026_65CE:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $F8, $02, $00 ; entry 2
    db $F9, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set65; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set65Frame1::
Data_026_65DF:: ; heuristic: meta-sprite frame; C0
    db $F2, $F8, $00, $00 ; entry 0
    db $F2, $00, $01, $00 ; entry 1
    db $FA, $F8, $04, $00 ; entry 2
    db $FA, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set65; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set65Frame2::
Data_026_65F0:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $06, $00 ; entry 0
    db $F1, $00, $07, $00 ; entry 1
    db $F9, $F8, $08, $00 ; entry 2
    db $F9, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set65; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set65Frame3::
Data_026_6601:: ; heuristic: meta-sprite frame; C0
    db $F2, $F8, $06, $00 ; entry 0
    db $F2, $00, $07, $00 ; entry 1
    db $FA, $F8, $0A, $00 ; entry 2
    db $FA, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set65; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set65Frame4::
Data_026_6612:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $0C, $00 ; entry 0
    db $F1, $00, $0D, $00 ; entry 1
    db $F9, $00, $0E, $00 ; entry 2
    db $F9, $F8, $05, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set65; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set65Frame5::
Data_026_6623:: ; heuristic: meta-sprite frame; C0
    db $F2, $F8, $0C, $00 ; entry 0
    db $F2, $00, $0D, $00 ; entry 1
    db $FA, $00, $0F, $00 ; entry 2
    db $FA, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 102 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set66::
Data_026_6634:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set66Frame0 ; entry 0
    dw MetaSprites26Set66Frame1 ; entry 1
    dw MetaSprites26Set66Frame2 ; entry 2
    dw MetaSprites26Set66Frame3 ; entry 3
    dw MetaSprites26Set66Frame4 ; entry 4
    dw MetaSprites26Set66Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set66; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set66Frame0::
Data_026_6640:: ; heuristic: meta-sprite frame; C0
    db $F8, $F8, $02, $00 ; entry 0
    db $F8, $00, $03, $00 ; entry 1
    db $F0, $F8, $00, $00 ; entry 2
    db $F0, $00, $01, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set66; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set66Frame1::
Data_026_6651:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $04, $00 ; entry 2
    db $F8, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set66; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set66Frame2::
Data_026_6662:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $00, $08, $00 ; entry 2
    db $F8, $F8, $04, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set66; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set66Frame3::
Data_026_6673:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set66; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set66Frame4::
Data_026_6684:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set66; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set66Frame5::
Data_026_6695:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 103 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set67::
Data_026_66A6:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set67Frame0 ; entry 0
    dw MetaSprites26Set67Frame1 ; entry 1
    dw MetaSprites26Set67Frame2 ; entry 2
    dw MetaSprites26Set67Frame3 ; entry 3
    dw MetaSprites26Set67Frame4 ; entry 4
    dw MetaSprites26Set67Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set67; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set67Frame0::
Data_026_66B2:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $FF, $00, $30 ; entry 1
    db $F8, $F8, $01, $10 ; entry 2
    db $F8, $00, $02, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set67; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set67Frame1::
Data_026_66C3:: ; heuristic: meta-sprite frame; C0
    db $F8, $FF, $01, $30 ; entry 0
    db $F8, $F7, $02, $30 ; entry 1
    db $F0, $F8, $03, $10 ; entry 2
    db $F0, $FF, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set67; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set67Frame2::
Data_026_66D4:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set67; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set67Frame3::
Data_026_66E5:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $08, $10 ; entry 0
    db $F0, $00, $09, $10 ; entry 1
    db $F8, $F8, $0A, $10 ; entry 2
    db $F8, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set67; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set67Frame4::
Data_026_66F6:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $10 ; entry 0
    db $F0, $FF, $0C, $30 ; entry 1
    db $F8, $F8, $0D, $10 ; entry 2
    db $F8, $00, $0E, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set67; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set67Frame5::
Data_026_6707:: ; heuristic: meta-sprite frame; C0
    db $F8, $FF, $0D, $30 ; entry 0
    db $F8, $F7, $0E, $30 ; entry 1
    db $F0, $F8, $0F, $10 ; entry 2
    db $F0, $FF, $0F, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 104 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set68::
Data_026_6718:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set68Frame0 ; entry 0
    dw MetaSprites26Set68Frame1 ; entry 1
    dw MetaSprites26Set68Frame2 ; entry 2
    dw MetaSprites26Set68Frame3 ; entry 3
    dw MetaSprites26Set68Frame4 ; entry 4
    dw MetaSprites26Set68Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set68; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set68Frame0::
Data_026_6724:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set68; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set68Frame1::
Data_026_6735:: ; heuristic: meta-sprite frame; C0
    db $F0, $00, $01, $00 ; entry 0
    db $F8, $00, $03, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F8, $F8, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set68; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set68Frame2::
Data_026_6746:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set68; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set68Frame3::
Data_026_6757:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $06, $00 ; entry 0
    db $F8, $F8, $03, $20 ; entry 1
    db $F0, $00, $08, $00 ; entry 2
    db $F8, $00, $05, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set68; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set68Frame4::
Data_026_6768:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $09, $00 ; entry 0
    db $F0, $00, $0A, $00 ; entry 1
    db $F8, $F8, $0B, $00 ; entry 2
    db $F8, $00, $0C, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set68; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set68Frame5::
Data_026_6779:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $09, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 105 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set69::
Data_026_678A:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set69Frame0 ; entry 0
    dw MetaSprites26Set69Frame1 ; entry 1
    dw MetaSprites26Set69Frame2 ; entry 2
    dw MetaSprites26Set69Frame3 ; entry 3
    dw MetaSprites26Set69Frame4 ; entry 4
    dw MetaSprites26Set69Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set69; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set69Frame0::
Data_026_6796:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set69; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set69Frame1::
Data_026_67A7:: ; heuristic: meta-sprite frame; C0
    db $F1, $00, $00, $20 ; entry 0
    db $F1, $F8, $01, $20 ; entry 1
    db $F9, $00, $02, $20 ; entry 2
    db $F9, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set69; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set69Frame2::
Data_026_67B8:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set69; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set69Frame3::
Data_026_67C9:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set69; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set69Frame4::
Data_026_67DA:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set69; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set69Frame5::
Data_026_67EB:: ; heuristic: meta-sprite frame; C0
    db $F1, $00, $0C, $20 ; entry 0
    db $F1, $F8, $0D, $20 ; entry 1
    db $F9, $00, $0E, $20 ; entry 2
    db $F9, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 106 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set6A::
Data_026_67FC:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set6AFrame0 ; entry 0
    dw MetaSprites26Set6AFrame1 ; entry 1
    dw MetaSprites26Set6AFrame2 ; entry 2
    dw MetaSprites26Set6AFrame3 ; entry 3
    dw MetaSprites26Set6AFrame4 ; entry 4
    dw MetaSprites26Set6AFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set6A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6AFrame0::
Data_026_6808:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set6A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6AFrame1::
Data_026_6819:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $04, $00 ; entry 2
    db $F8, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set6A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6AFrame2::
Data_026_682A:: ; heuristic: meta-sprite frame; C0
    db $F8, $F8, $08, $00 ; entry 0
    db $F0, $F9, $06, $00 ; entry 1
    db $F0, $01, $07, $00 ; entry 2
    db $F8, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set6A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6AFrame3::
Data_026_683B:: ; heuristic: meta-sprite frame; C0
    db $F8, $F8, $09, $00 ; entry 0
    db $F0, $F9, $06, $00 ; entry 1
    db $F0, $01, $07, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set6A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6AFrame4::
Data_026_684C:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set6A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6AFrame5::
Data_026_685D:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 107 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set6B::
Data_026_686E:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set6BFrame0 ; entry 0
    dw MetaSprites26Set6BFrame1 ; entry 1
    dw MetaSprites26Set6BFrame2 ; entry 2
    dw MetaSprites26Set6BFrame3 ; entry 3
    dw MetaSprites26Set6BFrame4 ; entry 4
    dw MetaSprites26Set6BFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set6B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6BFrame0::
Data_026_687A:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set6B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6BFrame1::
Data_026_688B:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $04, $00 ; entry 2
    db $F8, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set6B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6BFrame2::
Data_026_689C:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set6B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6BFrame3::
Data_026_68AD:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set6B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6BFrame4::
Data_026_68BE:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set6B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6BFrame5::
Data_026_68CF:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $01, $0E, $20 ; entry 2
    db $F8, $F9, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 108 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set6C::
Data_026_68E0:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set6CFrame0 ; entry 0
    dw MetaSprites26Set6CFrame1 ; entry 1
    dw MetaSprites26Set6CFrame2 ; entry 2
    dw MetaSprites26Set6CFrame3 ; entry 3
    dw MetaSprites26Set6CFrame4 ; entry 4
    dw MetaSprites26Set6CFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set6C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6CFrame0::
Data_026_68EC:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set6C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6CFrame1::
Data_026_68FD:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $04, $00 ; entry 1
    db $F8, $F8, $05, $00 ; entry 2
    db $F8, $00, $06, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set6C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6CFrame2::
Data_026_690E:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $00, $08, $00 ; entry 2
    db $F8, $F8, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set6C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6CFrame3::
Data_026_691F:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $02, $00 ; entry 1
    db $F0, $00, $09, $00 ; entry 2
    db $F8, $00, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set6C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6CFrame4::
Data_026_6930:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $00, $0C, $00 ; entry 1
    db $F8, $00, $0D, $00 ; entry 2
    db $F8, $F8, $08, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set6C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6CFrame5::
Data_026_6941:: ; heuristic: meta-sprite frame; C0
    db $F0, $00, $0C, $00 ; entry 0
    db $F0, $F8, $0E, $00 ; entry 1
    db $F8, $00, $0F, $00 ; entry 2
    db $F8, $F8, $0A, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 109 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set6D::
Data_026_6952:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set6DFrame0 ; entry 0
    dw MetaSprites26Set6DFrame1 ; entry 1
    dw MetaSprites26Set6DFrame2 ; entry 2
    dw MetaSprites26Set6DFrame3 ; entry 3
    dw MetaSprites26Set6DFrame4 ; entry 4
    dw MetaSprites26Set6DFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set6D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6DFrame0::
Data_026_695E:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set6D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6DFrame1::
Data_026_696F:: ; heuristic: meta-sprite frame; C0
    db $F0, $00, $00, $20 ; entry 0
    db $F0, $F9, $00, $00 ; entry 1
    db $F8, $00, $01, $20 ; entry 2
    db $F8, $F8, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set6D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6DFrame2::
Data_026_6980:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set6D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6DFrame3::
Data_026_6991:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set6D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6DFrame4::
Data_026_69A2:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $FF, $0C, $20 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0E, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set6D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6DFrame5::
Data_026_69B3:: ; heuristic: meta-sprite frame; C0
    db $F8, $00, $0D, $20 ; entry 0
    db $F8, $F8, $0E, $20 ; entry 1
    db $F0, $00, $0F, $20 ; entry 2
    db $F0, $F9, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 110 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set6E::
Data_026_69C4:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set6EFrame0 ; entry 0
    dw MetaSprites26Set6EFrame1 ; entry 1
    dw MetaSprites26Set6EFrame2 ; entry 2
    dw MetaSprites26Set6EFrame3 ; entry 3
    dw MetaSprites26Set6EFrame4 ; entry 4
    dw MetaSprites26Set6EFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set6E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6EFrame0::
Data_026_69D0:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set6E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6EFrame1::
Data_026_69E1:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $03, $00 ; entry 2
    db $F8, $00, $04, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set6E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6EFrame2::
Data_026_69F2:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $05, $00 ; entry 0
    db $F0, $00, $06, $00 ; entry 1
    db $F8, $F8, $07, $00 ; entry 2
    db $F8, $00, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set6E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6EFrame3::
Data_026_6A03:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $05, $00 ; entry 0
    db $F0, $00, $06, $00 ; entry 1
    db $F8, $F8, $09, $00 ; entry 2
    db $F8, $00, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set6E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6EFrame4::
Data_026_6A14:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $FF, $0B, $20 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set6E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6EFrame5::
Data_026_6A25:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $FF, $0B, $20 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 111 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set6F::
Data_026_6A36:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set6FFrame0 ; entry 0
    dw MetaSprites26Set6FFrame1 ; entry 1
    dw MetaSprites26Set6FFrame2 ; entry 2
    dw MetaSprites26Set6FFrame3 ; entry 3
    dw MetaSprites26Set6FFrame4 ; entry 4
    dw MetaSprites26Set6FFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set6F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6FFrame0::
Data_026_6A42:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set6F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6FFrame1::
Data_026_6A53:: ; heuristic: meta-sprite frame; C0
    db $F1, $FF, $00, $20 ; entry 0
    db $F1, $F7, $01, $20 ; entry 1
    db $F9, $FF, $02, $20 ; entry 2
    db $F9, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set6F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6FFrame2::
Data_026_6A64:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set6F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6FFrame3::
Data_026_6A75:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set6F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6FFrame4::
Data_026_6A86:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set6F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set6FFrame5::
Data_026_6A97:: ; heuristic: meta-sprite frame; C0
    db $F1, $FF, $0C, $20 ; entry 0
    db $F1, $F7, $0D, $20 ; entry 1
    db $F9, $FF, $0E, $20 ; entry 2
    db $F9, $F7, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 112 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set70::
Data_026_6AA8:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set70Frame0 ; entry 0
    dw MetaSprites26Set70Frame1 ; entry 1
    dw MetaSprites26Set70Frame2 ; entry 2
    dw MetaSprites26Set70Frame3 ; entry 3
    dw MetaSprites26Set70Frame4 ; entry 4
    dw MetaSprites26Set70Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set70; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set70Frame0::
Data_026_6AB4:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set70; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set70Frame1::
Data_026_6AC5:: ; heuristic: meta-sprite frame; C0
    db $EF, $F8, $00, $00 ; entry 0
    db $EF, $00, $01, $00 ; entry 1
    db $F7, $F8, $02, $00 ; entry 2
    db $F7, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set70; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set70Frame2::
Data_026_6AD6:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set70; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set70Frame3::
Data_026_6AE7:: ; heuristic: meta-sprite frame; C0
    db $EF, $F8, $04, $00 ; entry 0
    db $EF, $00, $05, $00 ; entry 1
    db $F7, $F8, $06, $00 ; entry 2
    db $F7, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set70; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set70Frame4::
Data_026_6AF8:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set70; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set70Frame5::
Data_026_6B09:: ; heuristic: meta-sprite frame; C0
    db $EF, $F8, $08, $00 ; entry 0
    db $EF, $00, $09, $00 ; entry 1
    db $F7, $F8, $0A, $00 ; entry 2
    db $F7, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 113 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set71::
Data_026_6B1A:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set71Frame0 ; entry 0
    dw MetaSprites26Set71Frame1 ; entry 1
    dw MetaSprites26Set71Frame2 ; entry 2
    dw MetaSprites26Set71Frame3 ; entry 3
    dw MetaSprites26Set71Frame4 ; entry 4
    dw MetaSprites26Set71Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set71; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set71Frame0::
Data_026_6B26:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set71; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set71Frame1::
Data_026_6B37:: ; heuristic: meta-sprite frame; C0
    db $F9, $F8, $04, $00 ; entry 0
    db $F9, $00, $05, $00 ; entry 1
    db $F1, $F8, $00, $00 ; entry 2
    db $F1, $00, $01, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set71; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set71Frame2::
Data_026_6B48:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set71; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set71Frame3::
Data_026_6B59:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $06, $00 ; entry 0
    db $F1, $00, $07, $00 ; entry 1
    db $F9, $00, $09, $00 ; entry 2
    db $F9, $F8, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set71; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set71Frame4::
Data_026_6B6A:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $00, $0C, $00 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0E, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set71; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set71Frame5::
Data_026_6B7B:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $0B, $00 ; entry 0
    db $F1, $00, $0C, $00 ; entry 1
    db $F9, $00, $0F, $00 ; entry 2
    db $F9, $F8, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 119 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set77::
Data_026_6B8C:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set77Frame0 ; entry 0
    dw MetaSprites26Set77Frame1 ; entry 1
    dw MetaSprites26Set77Frame2 ; entry 2
    dw MetaSprites26Set77Frame3 ; entry 3
    dw MetaSprites26Set77Frame4 ; entry 4
    dw MetaSprites26Set77Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set77; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set77Frame0::
Data_026_6B98:: ; heuristic: meta-sprite frame; C0
    db $F8, $F8, $02, $00 ; entry 0
    db $F8, $00, $03, $00 ; entry 1
    db $F0, $F8, $00, $00 ; entry 2
    db $F0, $00, $01, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set77; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set77Frame1::
Data_026_6BA9:: ; heuristic: meta-sprite frame; C0
    db $F8, $FF, $02, $20 ; entry 0
    db $F8, $F7, $03, $20 ; entry 1
    db $F0, $FF, $00, $20 ; entry 2
    db $F0, $F7, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set77; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set77Frame2::
Data_026_6BBA:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set77; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set77Frame3::
Data_026_6BCB:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set77; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set77Frame4::
Data_026_6BDC:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set77; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set77Frame5::
Data_026_6BED:: ; heuristic: meta-sprite frame; C0
    db $F0, $FF, $0C, $20 ; entry 0
    db $F0, $F7, $0D, $20 ; entry 1
    db $F8, $FF, $0E, $20 ; entry 2
    db $F8, $F7, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 120 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set78::
Data_026_6BFE:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set78Frame0 ; entry 0
    dw MetaSprites26Set78Frame1 ; entry 1
    dw MetaSprites26Set78Frame2 ; entry 2
    dw MetaSprites26Set78Frame3 ; entry 3
    dw MetaSprites26Set78Frame4 ; entry 4
    dw MetaSprites26Set78Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set78; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set78Frame0::
Data_026_6C0A:: ; heuristic: meta-sprite frame; C0
    db $F3, $F8, $00, $00 ; entry 0
    db $F3, $00, $01, $00 ; entry 1
    db $FB, $F8, $02, $00 ; entry 2
    db $FB, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set78; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set78Frame1::
Data_026_6C1B:: ; heuristic: meta-sprite frame; C0
    db $FB, $00, $02, $20 ; entry 0
    db $FB, $F8, $03, $20 ; entry 1
    db $F3, $F8, $04, $00 ; entry 2
    db $F3, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set78; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set78Frame2::
Data_026_6C2C:: ; heuristic: meta-sprite frame; C0
    db $F3, $F8, $06, $00 ; entry 0
    db $F3, $00, $07, $00 ; entry 1
    db $FB, $F8, $08, $00 ; entry 2
    db $FB, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set78; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set78Frame3::
Data_026_6C3D:: ; heuristic: meta-sprite frame; C0
    db $F3, $F9, $06, $00 ; entry 0
    db $FB, $F9, $09, $20 ; entry 1
    db $F2, $01, $07, $00 ; entry 2
    db $FA, $01, $08, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set78; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set78Frame4::
Data_026_6C4E:: ; heuristic: meta-sprite frame; C0
    db $F3, $F8, $0A, $00 ; entry 0
    db $F3, $00, $0B, $00 ; entry 1
    db $FB, $F8, $0C, $00 ; entry 2
    db $FB, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set78; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set78Frame5::
Data_026_6C5F:: ; heuristic: meta-sprite frame; C0
    db $F3, $F8, $0E, $00 ; entry 0
    db $F3, $00, $0F, $00 ; entry 1
    db $FB, $00, $0C, $20 ; entry 2
    db $FB, $F8, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 121 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set79::
Data_026_6C70:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set79Frame0 ; entry 0
    dw MetaSprites26Set79Frame1 ; entry 1
    dw MetaSprites26Set79Frame2 ; entry 2
    dw MetaSprites26Set79Frame3 ; entry 3
    dw MetaSprites26Set79Frame4 ; entry 4
    dw MetaSprites26Set79Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set79; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set79Frame0::
Data_026_6C7C:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $FE, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set79; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set79Frame1::
Data_026_6C8D:: ; heuristic: meta-sprite frame; C0
    db $F8, $F8, $04, $10 ; entry 0
    db $F8, $00, $05, $10 ; entry 1
    db $F0, $01, $01, $10 ; entry 2
    db $F0, $FA, $01, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set79; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set79Frame2::
Data_026_6C9E:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $06, $10 ; entry 0
    db $F0, $00, $07, $10 ; entry 1
    db $F8, $00, $09, $10 ; entry 2
    db $F8, $F8, $08, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set79; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set79Frame3::
Data_026_6CAF:: ; heuristic: meta-sprite frame; C0
    db $F8, $00, $0A, $10 ; entry 0
    db $F8, $F8, $03, $30 ; entry 1
    db $F0, $F9, $06, $10 ; entry 2
    db $F0, $01, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set79; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set79Frame4::
Data_026_6CC0:: ; heuristic: meta-sprite frame; C0
    db $F8, $00, $03, $10 ; entry 0
    db $F0, $F9, $0B, $10 ; entry 1
    db $F0, $FF, $0C, $10 ; entry 2
    db $F8, $F8, $0D, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set79; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set79Frame5::
Data_026_6CD1:: ; heuristic: meta-sprite frame; C0
    db $F0, $01, $0C, $10 ; entry 0
    db $F0, $FA, $0C, $30 ; entry 1
    db $F8, $F8, $0E, $10 ; entry 2
    db $F8, $00, $0F, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 122 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set7A::
Data_026_6CE2:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set7AFrame0 ; entry 0
    dw MetaSprites26Set7AFrame1 ; entry 1
    dw MetaSprites26Set7AFrame2 ; entry 2
    dw MetaSprites26Set7AFrame3 ; entry 3
    dw MetaSprites26Set7AFrame4 ; entry 4
    dw MetaSprites26Set7AFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set7A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7AFrame0::
Data_026_6CEE:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set7A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7AFrame1::
Data_026_6CFF:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set7A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7AFrame2::
Data_026_6D10:: ; heuristic: meta-sprite frame; C0
    db $F8, $F8, $08, $10 ; entry 0
    db $F8, $00, $09, $10 ; entry 1
    db $F0, $F8, $00, $10 ; entry 2
    db $F0, $00, $01, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set7A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7AFrame3::
Data_026_6D21:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $0A, $10 ; entry 2
    db $F8, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set7A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7AFrame4::
Data_026_6D32:: ; heuristic: meta-sprite frame; C0
    db $F8, $F8, $0D, $10 ; entry 0
    db $F8, $00, $0E, $10 ; entry 1
    db $F0, $00, $00, $30 ; entry 2
    db $F0, $F8, $0C, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set7A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7AFrame5::
Data_026_6D43:: ; heuristic: meta-sprite frame; C0
    db $F8, $00, $0D, $30 ; entry 0
    db $F8, $F8, $0E, $30 ; entry 1
    db $F0, $00, $04, $30 ; entry 2
    db $F0, $F8, $0F, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 123 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set7B::
Data_026_6D54:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set7BFrame0 ; entry 0
    dw MetaSprites26Set7BFrame1 ; entry 1
    dw MetaSprites26Set7BFrame2 ; entry 2
    dw MetaSprites26Set7BFrame3 ; entry 3
    dw MetaSprites26Set7BFrame4 ; entry 4
    dw MetaSprites26Set7BFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set7B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7BFrame0::
Data_026_6D60:: ; heuristic: meta-sprite frame; C0
    db $EF, $F8, $00, $10 ; entry 0
    db $EF, $00, $00, $30 ; entry 1
    db $F7, $F8, $01, $10 ; entry 2
    db $F7, $00, $01, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set7B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7BFrame1::
Data_026_6D71:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $02, $10 ; entry 0
    db $F0, $00, $02, $30 ; entry 1
    db $F8, $F8, $03, $10 ; entry 2
    db $F8, $00, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set7B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7BFrame2::
Data_026_6D82:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set7B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7BFrame3::
Data_026_6D93:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $08, $10 ; entry 0
    db $F1, $00, $09, $10 ; entry 1
    db $F9, $F8, $0A, $10 ; entry 2
    db $F9, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set7B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7BFrame4::
Data_026_6DA4:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $10 ; entry 0
    db $F0, $00, $0C, $30 ; entry 1
    db $F8, $F8, $0D, $10 ; entry 2
    db $F8, $00, $0D, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set7B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7BFrame5::
Data_026_6DB5:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $0E, $10 ; entry 0
    db $F1, $00, $0E, $30 ; entry 1
    db $F9, $F8, $0F, $10 ; entry 2
    db $F9, $00, $0F, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 124 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set7C::
Data_026_6DC6:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set7CFrame0 ; entry 0
    dw MetaSprites26Set7CFrame1 ; entry 1
    dw MetaSprites26Set7CFrame2 ; entry 2
    dw MetaSprites26Set7CFrame3 ; entry 3
    dw MetaSprites26Set7CFrame4 ; entry 4
    dw MetaSprites26Set7CFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set7C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7CFrame0::
Data_026_6DD2:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set7C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7CFrame1::
Data_026_6DE3:: ; heuristic: meta-sprite frame; C0
    db $EF, $F8, $00, $10 ; entry 0
    db $EF, $00, $01, $10 ; entry 1
    db $F7, $F8, $04, $10 ; entry 2
    db $F7, $00, $05, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set7C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7CFrame2::
Data_026_6DF4:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $06, $10 ; entry 0
    db $F0, $00, $07, $10 ; entry 1
    db $F8, $F8, $08, $10 ; entry 2
    db $F8, $00, $09, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set7C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7CFrame3::
Data_026_6E05:: ; heuristic: meta-sprite frame; C0
    db $EF, $F8, $06, $10 ; entry 0
    db $EF, $00, $07, $10 ; entry 1
    db $F7, $F8, $0A, $10 ; entry 2
    db $F7, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set7C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7CFrame4::
Data_026_6E16:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $10 ; entry 0
    db $F0, $00, $0D, $10 ; entry 1
    db $F8, $00, $02, $30 ; entry 2
    db $F8, $F8, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set7C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7CFrame5::
Data_026_6E27:: ; heuristic: meta-sprite frame; C0
    db $EF, $F8, $0C, $10 ; entry 0
    db $EF, $00, $0D, $10 ; entry 1
    db $F7, $00, $04, $30 ; entry 2
    db $F7, $F8, $05, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 125 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set7D::
Data_026_6E38:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set7DFrame0 ; entry 0
    dw MetaSprites26Set7DFrame1 ; entry 1
    dw MetaSprites26Set7DFrame2 ; entry 2
    dw MetaSprites26Set7DFrame3 ; entry 3
    dw MetaSprites26Set7DFrame4 ; entry 4
    dw MetaSprites26Set7DFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set7D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7DFrame0::
Data_026_6E44:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set7D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7DFrame1::
Data_026_6E55:: ; heuristic: meta-sprite frame; C0
    db $EE, $F8, $02, $00 ; entry 0
    db $EE, $00, $02, $20 ; entry 1
    db $F6, $F8, $03, $00 ; entry 2
    db $F6, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set7D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7DFrame2::
Data_026_6E66:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $04, $00 ; entry 0
    db $F1, $00, $05, $00 ; entry 1
    db $F9, $F8, $06, $00 ; entry 2
    db $F9, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set7D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7DFrame3::
Data_026_6E77:: ; heuristic: meta-sprite frame; C0
    db $EF, $F8, $08, $00 ; entry 0
    db $EF, $00, $09, $00 ; entry 1
    db $F7, $F8, $0A, $00 ; entry 2
    db $F7, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set7D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7DFrame4::
Data_026_6E88:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0C, $20 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set7D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7DFrame5::
Data_026_6E99:: ; heuristic: meta-sprite frame; C0
    db $EE, $F8, $0E, $00 ; entry 0
    db $EE, $00, $0E, $20 ; entry 1
    db $F6, $F8, $0F, $00 ; entry 2
    db $F6, $00, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 126 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set7E::
Data_026_6EAA:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set7EFrame0 ; entry 0
    dw MetaSprites26Set7EFrame1 ; entry 1
    dw MetaSprites26Set7EFrame2 ; entry 2
    dw MetaSprites26Set7EFrame3 ; entry 3
    dw MetaSprites26Set7EFrame4 ; entry 4
    dw MetaSprites26Set7EFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set7E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7EFrame0::
Data_026_6EB6:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set7E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7EFrame1::
Data_026_6EC7:: ; heuristic: meta-sprite frame; C0
    db $F1, $FF, $00, $20 ; entry 0
    db $F1, $F7, $01, $20 ; entry 1
    db $F9, $FF, $02, $20 ; entry 2
    db $F9, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set7E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7EFrame2::
Data_026_6ED8:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set7E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7EFrame3::
Data_026_6EE9:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set7E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7EFrame4::
Data_026_6EFA:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set7E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7EFrame5::
Data_026_6F0B:: ; heuristic: meta-sprite frame; C0
    db $F1, $01, $0C, $20 ; entry 0
    db $F1, $F9, $0D, $20 ; entry 1
    db $F9, $01, $0E, $20 ; entry 2
    db $F9, $F9, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 127 of MetaSprites26Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites26Set7F::
Data_026_6F1C:: ; heuristic: meta-sprite set; C0
    dw MetaSprites26Set7FFrame0 ; entry 0
    dw MetaSprites26Set7FFrame1 ; entry 1
    dw MetaSprites26Set7FFrame2 ; entry 2
    dw MetaSprites26Set7FFrame3 ; entry 3
    dw MetaSprites26Set7FFrame4 ; entry 4
    dw MetaSprites26Set7FFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites26Set7F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7FFrame0::
Data_026_6F28:: ; heuristic: meta-sprite frame; C0
    db $F9, $F8, $02, $00 ; entry 0
    db $F9, $00, $03, $00 ; entry 1
    db $F1, $F8, $00, $00 ; entry 2
    db $F1, $00, $01, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites26Set7F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7FFrame1::
Data_026_6F39:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $FF, $02, $20 ; entry 2
    db $F9, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites26Set7F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7FFrame2::
Data_026_6F4A:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites26Set7F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7FFrame3::
Data_026_6F5B:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0C, $00 ; entry 2
    db $F9, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites26Set7F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7FFrame4::
Data_026_6F6C:: ; heuristic: meta-sprite frame; C0
    db $F9, $F8, $06, $00 ; entry 0
    db $F9, $00, $07, $00 ; entry 1
    db $F1, $F8, $04, $00 ; entry 2
    db $F1, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites26Set7F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites26Set7FFrame5::
Data_026_6F7D:: ; heuristic: meta-sprite frame; C0
    db $F1, $F8, $04, $00 ; entry 0
    db $F1, $00, $05, $00 ; entry 1
    db $F9, $FF, $06, $20 ; entry 2
    db $F9, $F7, $07, $20 ; entry 3
    db $80 ; end
    ds $1072, $00
