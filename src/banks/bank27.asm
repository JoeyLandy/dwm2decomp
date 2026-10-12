SECTION "Bank 27", ROMX[$4000], BANK[$27]
    db $27

; ORs the attribute bits from Data_027_411C[hSpriteSetIndex] (when its bit 0 is set) into hSpriteAttrXor, then builds the sprite from Data_027_401E (E-0124)
; 6 call sites from 6 routines (e.g. DebugMonsterPictureViewer_Update, UpdateAndDrawSpriteSlots, AdvancePlayerAnimCounterAndRunPlayerSpriteMode_IsFadingAtMap5AScreen00Y80, DrawPartyFollowerSprites, ...)
; reads: hSpriteSetIndex, hSpriteAttrXor
; writes: hSpriteAttrXor
DrawMetaSpriteSet_Bank27::
Func_027_4001:: ; address name
    ldh a, [hSpriteSetIndex]
    ld e, a
    ld d, $00
    ld hl, MetaSprites27Attrs
    add hl, de
    bit 0, [hl]
    jr z, Jump_027_4017
    ld a, [hl]
    and a, $F0
    ld e, a
    ldh a, [hSpriteAttrXor]
    or a, e
    ldh [hSpriteAttrXor], a

Jump_027_4017::
    ld de, MetaSprites27Table
    call DrawMetaSpriteSet_Bank27_WaitOamNextEntry
    ret

; E-0147 (C1: DrawMetaSpriteSet_Bank27 passes DE = $27:401E to the builder, which takes the word at DE + 2 * hSpriteSetIndex as the set and the word at set + 2 * hSpriteSubIndex as the frame; 127 words up to the attribute table at $411C).
; record: meta-sprite set
MetaSprites27Table::
Data_027_401E:: ; address name
    dw MetaSprites27Set00 ; id 0
    dw MetaSprites27Set01 ; id 1
    dw MetaSprites27Set02 ; id 2
    dw MetaSprites27Set03 ; id 3
    dw MetaSprites27Set04 ; id 4
    dw MetaSprites27Set05 ; id 5
    dw MetaSprites27Set06 ; id 6
    dw MetaSprites27Set07 ; id 7
    dw MetaSprites27Set08 ; id 8
    dw MetaSprites27Set09 ; id 9
    dw MetaSprites27Set0A ; id 10
    dw MetaSprites27Set0B ; id 11
    dw MetaSprites27Set0C ; id 12
    dw MetaSprites27Set0D ; id 13
    dw MetaSprites27Set0E ; id 14
    dw MetaSprites27Set0F ; id 15
    dw MetaSprites27Set10 ; id 16
    dw MetaSprites27Set11 ; id 17
    dw MetaSprites27Set11 ; id 18
    dw MetaSprites27Set11 ; id 19
    dw MetaSprites27Set11 ; id 20
    dw MetaSprites27Set11 ; id 21
    dw MetaSprites27Set11 ; id 22
    dw MetaSprites27Set11 ; id 23
    dw MetaSprites27Set11 ; id 24
    dw MetaSprites27Set11 ; id 25
    dw MetaSprites27Set1A ; id 26
    dw MetaSprites27Set1B ; id 27
    dw MetaSprites27Set1C ; id 28
    dw MetaSprites27Set1D ; id 29
    dw MetaSprites27Set1E ; id 30
    dw MetaSprites27Set1F ; id 31
    dw MetaSprites27Set20 ; id 32
    dw MetaSprites27Set21 ; id 33
    dw MetaSprites27Set22 ; id 34
    dw MetaSprites27Set23 ; id 35
    dw MetaSprites27Set24 ; id 36
    dw MetaSprites27Set25 ; id 37
    dw MetaSprites27Set26 ; id 38
    dw MetaSprites27Set27 ; id 39
    dw MetaSprites27Set28 ; id 40
    dw MetaSprites27Set29 ; id 41
    dw MetaSprites27Set2A ; id 42
    dw MetaSprites27Set2B ; id 43
    dw MetaSprites27Set2C ; id 44
    dw MetaSprites27Set2D ; id 45
    dw MetaSprites27Set2E ; id 46
    dw MetaSprites27Set2F ; id 47
    dw MetaSprites27Set30 ; id 48
    dw MetaSprites27Set31 ; id 49
    dw MetaSprites27Set32 ; id 50
    dw MetaSprites27Set33 ; id 51
    dw MetaSprites27Set34 ; id 52
    dw MetaSprites27Set35 ; id 53
    dw MetaSprites27Set36 ; id 54
    dw MetaSprites27Set37 ; id 55
    dw MetaSprites27Set38 ; id 56
    dw MetaSprites27Set39 ; id 57
    dw MetaSprites27Set39 ; id 58
    dw MetaSprites27Set39 ; id 59
    dw MetaSprites27Set39 ; id 60
    dw MetaSprites27Set3D ; id 61
    dw MetaSprites27Set3E ; id 62
    dw MetaSprites27Set3F ; id 63
    dw MetaSprites27Set40 ; id 64
    dw MetaSprites27Set41 ; id 65
    dw MetaSprites27Set42 ; id 66
    dw MetaSprites27Set43 ; id 67
    dw MetaSprites27Set44 ; id 68
    dw MetaSprites27Set45 ; id 69
    dw MetaSprites27Set46 ; id 70
    dw MetaSprites27Set47 ; id 71
    dw MetaSprites27Set48 ; id 72
    dw MetaSprites27Set49 ; id 73
    dw MetaSprites27Set4A ; id 74
    dw MetaSprites27Set4B ; id 75
    dw MetaSprites27Set4C ; id 76
    dw MetaSprites27Set4D ; id 77
    dw MetaSprites27Set4E ; id 78
    dw MetaSprites27Set4F ; id 79
    dw MetaSprites27Set50 ; id 80
    dw MetaSprites27Set51 ; id 81
    dw MetaSprites27Set52 ; id 82
    dw MetaSprites27Set53 ; id 83
    dw MetaSprites27Set54 ; id 84
    dw MetaSprites27Set55 ; id 85
    dw MetaSprites27Set56 ; id 86
    dw MetaSprites27Set57 ; id 87
    dw MetaSprites27Set58 ; id 88
    dw MetaSprites27Set59 ; id 89
    dw MetaSprites27Set5A ; id 90
    dw MetaSprites27Set5B ; id 91
    dw MetaSprites27Set5C ; id 92
    dw MetaSprites27Set5C ; id 93
    dw MetaSprites27Set5C ; id 94
    dw MetaSprites27Set5C ; id 95
    dw MetaSprites27Set60 ; id 96
    dw MetaSprites27Set61 ; id 97
    dw MetaSprites27Set62 ; id 98
    dw MetaSprites27Set63 ; id 99
    dw MetaSprites27Set64 ; id 100
    dw MetaSprites27Set65 ; id 101
    dw MetaSprites27Set66 ; id 102
    dw MetaSprites27Set67 ; id 103
    dw MetaSprites27Set68 ; id 104
    dw MetaSprites27Set69 ; id 105
    dw MetaSprites27Set6A ; id 106
    dw MetaSprites27Set6B ; id 107
    dw MetaSprites27Set6C ; id 108
    dw MetaSprites27Set6D ; id 109
    dw MetaSprites27Set6E ; id 110
    dw MetaSprites27Set6F ; id 111
    dw MetaSprites27Set70 ; id 112
    dw MetaSprites27Set71 ; id 113
    dw MetaSprites27Set72 ; id 114
    dw MetaSprites27Set73 ; id 115
    dw MetaSprites27Set74 ; id 116
    dw $0000 ; id 117
    dw $0000 ; id 118
    dw $0000 ; id 119
    dw $0000 ; id 120
    dw $0000 ; id 121
    dw $0000 ; id 122
    dw $0000 ; id 123
    dw MetaSprites27Set7C ; id 124
    dw MetaSprites27Set7D ; id 125
    dw MetaSprites27Set7E ; id 126

; E-0147 (C1: DrawMetaSpriteSet_Bank27 reads the byte $411C + hSpriteSetIndex; when bit 0 is set it ORs its high nibble into hSpriteAttrXor before drawing).
; record: bit 0 set: OR the high nibble into hSpriteAttrXor
MetaSprites27Attrs::
Data_027_411C:: ; address name
    db $00 ; id 0
    db $00 ; id 1
    db $00 ; id 2
    db $10 ; id 3
    db $11 ; id 4
    db $01 ; id 5
    db $01 ; id 6
    db $10 ; id 7
    db $00 ; id 8
    db $00 ; id 9
    db $00 ; id 10
    db $10 ; id 11
    db $01 ; id 12
    db $00 ; id 13
    db $00 ; id 14
    db $01 ; id 15
    db $11 ; id 16
    db $00 ; id 17
    db $00 ; id 18
    db $00 ; id 19
    db $00 ; id 20
    db $00 ; id 21
    db $00 ; id 22
    db $00 ; id 23
    db $00 ; id 24
    db $00 ; id 25
    db $00 ; id 26
    db $00 ; id 27
    db $00 ; id 28
    db $10 ; id 29
    db $00 ; id 30
    db $10 ; id 31
    db $00 ; id 32
    db $01 ; id 33
    db $00 ; id 34
    db $10 ; id 35
    db $00 ; id 36
    db $10 ; id 37
    db $00 ; id 38
    db $00 ; id 39
    db $01 ; id 40
    db $00 ; id 41
    db $11 ; id 42
    db $10 ; id 43
    db $10 ; id 44
    db $10 ; id 45
    db $00 ; id 46
    db $10 ; id 47
    db $01 ; id 48
    db $00 ; id 49
    db $10 ; id 50
    db $00 ; id 51
    db $10 ; id 52
    db $00 ; id 53
    db $01 ; id 54
    db $01 ; id 55
    db $01 ; id 56
    db $00 ; id 57
    db $00 ; id 58
    db $00 ; id 59
    db $01 ; id 60
    db $01 ; id 61
    db $01 ; id 62
    db $11 ; id 63
    db $11 ; id 64
    db $11 ; id 65
    db $01 ; id 66
    db $01 ; id 67
    db $01 ; id 68
    db $01 ; id 69
    db $11 ; id 70
    db $01 ; id 71
    db $11 ; id 72
    db $01 ; id 73
    db $01 ; id 74
    db $01 ; id 75
    db $11 ; id 76
    db $01 ; id 77
    db $11 ; id 78
    db $01 ; id 79
    db $11 ; id 80
    db $11 ; id 81
    db $11 ; id 82
    db $01 ; id 83
    db $11 ; id 84
    db $01 ; id 85
    db $01 ; id 86
    db $11 ; id 87
    db $01 ; id 88
    db $11 ; id 89
    db $01 ; id 90
    db $11 ; id 91
    db $00 ; id 92
    db $00 ; id 93
    db $00 ; id 94
    db $00 ; id 95
    db $00 ; id 96
    db $11 ; id 97
    db $00 ; id 98
    db $10 ; id 99
    db $11 ; id 100
    db $10 ; id 101
    db $00 ; id 102
    db $01 ; id 103
    db $10 ; id 104
    db $11 ; id 105
    db $00 ; id 106
    db $00 ; id 107
    db $10 ; id 108
    db $10 ; id 109
    db $00 ; id 110
    db $11 ; id 111
    db $11 ; id 112
    db $00 ; id 113
    db $11 ; id 114
    db $01 ; id 115
    db $11 ; id 116
    db $00 ; id 117
    db $00 ; id 118
    db $00 ; id 119
    db $00 ; id 120
    db $00 ; id 121
    db $00 ; id 122
    db $01 ; id 123
    db $01 ; id 124
    db $11 ; id 125
    db $01 ; id 126
    db $00

; only called from DrawMetaSpriteSet_Bank27 (E-0047)
; 1 call site from 1 routine (e.g. DrawMetaSpriteSet_Bank27)
; reads: hOamNextEntry, hSpriteScrollYLo, hSpriteScrollYHi, hSpriteOriginY, hSpriteOriginYHi, hSpriteScrollXLo, hSpriteScrollXHi, hSpriteOriginX, ...
; writes: hMetaSpriteYLo, hMetaSpriteYHi, hOamNextEntry
; points at: hMetaSpriteXLo
DrawMetaSpriteSet_Bank27_WaitOamNextEntry::
Func_027_419C:: ; address name
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
    jp nz, Jump_027_42E6
    ldh a, [hSpriteTileOffset]
    ld c, a
    ldh a, [hSpriteAttrXor]
    and a, $20
    jr nz, Jump_027_426E

Jump_027_41F8::
    ld a, [hl+]
    cp a, $80
    ret z
    ld b, a
    jr nc, Jump_027_4210
    ldh a, [hMetaSpriteYLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteYHi]
    adc a, $00
    jr nz, Jump_027_421F
    ld a, b
    cp a, $A8
    jr c, Jump_027_4224
    jr Jump_027_421F

Jump_027_4210::
    ldh a, [hMetaSpriteYLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteYHi]
    adc a, $FF
    jr nz, Jump_027_421F
    ld a, b
    cp a, $A8
    jr c, Jump_027_4224

Jump_027_421F::
    inc hl
    inc hl
    inc hl
    jr Jump_027_41F8

Jump_027_4224::
    ld a, b
    ld [de], a
    inc e
    ld a, [hl+]
    ld b, a
    rlca
    jr c, Jump_027_423D
    ldh a, [hMetaSpriteXLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteXHi]
    adc a, $00
    jr nz, Jump_027_424C
    ld a, b
    cp a, $B8
    jr c, Jump_027_4253
    jr Jump_027_424C

Jump_027_423D::
    ldh a, [hMetaSpriteXLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteXHi]
    adc a, $FF
    jr nz, Jump_027_424C
    ld a, b
    cp a, $B8
    jr c, Jump_027_4253

Jump_027_424C::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_027_41F8

Jump_027_4253::
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
    jr nz, Jump_027_41F8
    ret

Jump_027_426E::
    ld a, [hl+]
    cp a, $80
    ret z
    ld b, a
    jr nc, Jump_027_4286
    ldh a, [hMetaSpriteYLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteYHi]
    adc a, $00
    jr nz, Jump_027_4295
    ld a, b
    cp a, $A8
    jr c, Jump_027_429A
    jr Jump_027_4295

Jump_027_4286::
    ldh a, [hMetaSpriteYLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteYHi]
    adc a, $FF
    jr nz, Jump_027_4295
    ld a, b
    cp a, $A8
    jr c, Jump_027_429A

Jump_027_4295::
    inc hl
    inc hl
    inc hl
    jr Jump_027_426E

Jump_027_429A::
    ld a, b
    ld [de], a
    inc e
    ld a, [hl+]
    ld b, a
    rlca
    jr c, Jump_027_42B5
    ldh a, [hMetaSpriteXFlipLo]
    sub a, b
    ld b, a
    ldh a, [hMetaSpriteXFlipHi]
    sbc a, $00
    jr z, Jump_027_42CB
    jr nz, Jump_027_42C4
    ld a, b
    cp a, $B8
    jr c, Jump_027_42CB
    jr Jump_027_42C4

Jump_027_42B5::
    ldh a, [hMetaSpriteXFlipLo]
    sub a, b
    ld b, a
    ldh a, [hMetaSpriteXFlipHi]
    sbc a, $FF
    jr nz, Jump_027_42C4
    ld a, b
    cp a, $B8
    jr c, Jump_027_42CB

Jump_027_42C4::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_027_426E

Jump_027_42CB::
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
    jr nz, Jump_027_426E
    ret

Jump_027_42E6::
    ldh a, [hSpriteAttrXor]
    and a, $20
    jr nz, Jump_027_4367

Jump_027_42EC::
    ld a, [hl+]
    cp a, $80
    ret z
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_027_42F7
    dec b

Jump_027_42F7::
    ldh a, [hMetaSpriteYLo]
    add a, c
    ld c, a
    ldh a, [hMetaSpriteYHi]
    adc a, b
    jr nz, Jump_027_4322
    ld a, c
    cp a, $B8
    jr nc, Jump_027_4322
    ldh a, [hSpriteWindowClipMode]
    or a, a
    jr z, Jump_027_4327
    cp a, $01
    jr nz, Jump_027_4315
    ld a, c
    cp a, $34
    jr c, Jump_027_4322
    jr Jump_027_4327

Jump_027_4315::
    cp a, $02
    jr nz, Jump_027_4320
    ld a, c
    cp a, $71
    jr c, Jump_027_4327
    jr Jump_027_4322

Jump_027_4320::
    jr Jump_027_4327

Jump_027_4322::
    inc hl
    inc hl
    inc hl
    jr Jump_027_42EC

Jump_027_4327::
    ld a, c
    ld [de], a
    inc e
    ld a, [hl+]
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_027_4332
    dec b

Jump_027_4332::
    ldh a, [hMetaSpriteXLo]
    add a, c
    ld c, a
    ldh a, [hMetaSpriteXHi]
    adc a, b
    jr nz, Jump_027_4340
    ld a, c
    cp a, $B8
    jr c, Jump_027_4347

Jump_027_4340::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_027_42EC

Jump_027_4347::
    ld a, c
    ld [de], a
    call BGTileUnderPointIsSpriteHideTile_Bank27
    jr nc, Jump_027_4340
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
    jr nz, Jump_027_42EC
    ret

Jump_027_4367::
    ld a, [hl+]
    cp a, $80
    ret z
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_027_4372
    dec b

Jump_027_4372::
    ldh a, [hMetaSpriteYLo]
    add a, c
    ld c, a
    ldh a, [hMetaSpriteYHi]
    adc a, b
    jr nz, Jump_027_439D
    ld a, c
    cp a, $B8
    jr nc, Jump_027_439D
    ldh a, [hSpriteWindowClipMode]
    or a, a
    jr z, Jump_027_43A2
    cp a, $01
    jr nz, Jump_027_4390
    ld a, c
    cp a, $34
    jr c, Jump_027_439D
    jr Jump_027_43A2

Jump_027_4390::
    cp a, $02
    jr nz, Jump_027_439B
    ld a, c
    cp a, $71
    jr c, Jump_027_43A2
    jr Jump_027_439D

Jump_027_439B::
    jr Jump_027_43A2

Jump_027_439D::
    inc hl
    inc hl
    inc hl
    jr Jump_027_4367

Jump_027_43A2::
    ld a, c
    ld [de], a
    inc e
    ld a, [hl+]
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_027_43AD
    dec b

Jump_027_43AD::
    ldh a, [hMetaSpriteXFlipLo]
    sub a, c
    ld c, a
    ldh a, [hMetaSpriteXFlipHi]
    sbc a, b
    jr nz, Jump_027_43BB
    ld a, c
    cp a, $B8
    jr c, Jump_027_43C2

Jump_027_43BB::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_027_4367

Jump_027_43C2::
    ld a, c
    ld [de], a
    call BGTileUnderPointIsSpriteHideTile_Bank27
    jr nc, Jump_027_43BB
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
    jr nz, Jump_027_4367
    ret

; DE = address of an X byte with its Y byte at DE - 1 (screen coordinates): HL = the $9800 BG map entry under (X + hScrollX - 4, Y + hScrollY - 12), rows wrapping inside the map; reads it after rSTAT bit 1 clears (interrupts off) and compares with hFFBA: Z set when equal, A = the tile; BC, HL kept (E-0065) (the same 54 bytes appear in 6 banks)
; 2 call sites from 1 routine (e.g. DrawMetaSpriteSet_Bank27_WaitOamNextEntry)
; reads: hScrollY, hScrollX, hSpriteHideTile, rSTAT
BGTileUnderPointIsSpriteHideTile_Bank27::
Func_027_43E2:: ; address name
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

Jump_027_440C::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_027_440C
    ld a, [hl]
    ei
    cp a, b
    pop bc
    pop hl
    ret

; E-0147 (derived: meta-sprite set 0 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set00::
Data_027_4418:: ; address name
    dw MetaSprites27Set00Frame0 ; entry 0
    dw MetaSprites27Set00Frame1 ; entry 1
    dw MetaSprites27Set00Frame2 ; entry 2
    dw MetaSprites27Set00Frame3 ; entry 3
    dw MetaSprites27Set00Frame4 ; entry 4
    dw MetaSprites27Set00Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set00Frame0::
Data_027_4424:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $FF, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set00Frame1::
Data_027_4435:: ; address name
    db $F0, $F8, $02, $00 ; entry 0
    db $F0, $FF, $02, $20 ; entry 1
    db $F8, $F8, $03, $00 ; entry 2
    db $F8, $FF, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set00Frame2::
Data_027_4446:: ; address name
    db $F8, $F8, $06, $00 ; entry 0
    db $F8, $00, $07, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set00Frame3::
Data_027_4457:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set00Frame4::
Data_027_4468:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $FF, $0C, $20 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $FF, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set00Frame5::
Data_027_4479:: ; address name
    db $F0, $F8, $0E, $00 ; entry 0
    db $F0, $FF, $0E, $20 ; entry 1
    db $F8, $F8, $0F, $00 ; entry 2
    db $F8, $FF, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 1 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set01::
Data_027_448A:: ; address name
    dw MetaSprites27Set01Frame0 ; entry 0
    dw MetaSprites27Set01Frame1 ; entry 1
    dw MetaSprites27Set01Frame2 ; entry 2
    dw MetaSprites27Set01Frame3 ; entry 3
    dw MetaSprites27Set01Frame4 ; entry 4
    dw MetaSprites27Set01Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set01Frame0::
Data_027_4496:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set01Frame1::
Data_027_44A7:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $F8, $04, $00 ; entry 2
    db $F9, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set01Frame2::
Data_027_44B8:: ; address name
    db $EF, $F8, $06, $00 ; entry 0
    db $EF, $00, $07, $00 ; entry 1
    db $F7, $F8, $08, $00 ; entry 2
    db $F7, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set01Frame3::
Data_027_44C9:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set01Frame4::
Data_027_44DA:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set01Frame5::
Data_027_44EB:: ; address name
    db $F1, $F8, $0C, $00 ; entry 0
    db $F1, $00, $0E, $00 ; entry 1
    db $F9, $00, $0F, $00 ; entry 2
    db $F9, $F8, $05, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 2 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set02::
Data_027_44FC:: ; address name
    dw MetaSprites27Set02Frame0 ; entry 0
    dw MetaSprites27Set02Frame1 ; entry 1
    dw MetaSprites27Set02Frame2 ; entry 2
    dw MetaSprites27Set02Frame3 ; entry 3
    dw MetaSprites27Set02Frame4 ; entry 4
    dw MetaSprites27Set02Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set02Frame0::
Data_027_4508:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set02Frame1::
Data_027_4519:: ; address name
    db $F1, $00, $00, $20 ; entry 0
    db $F1, $F8, $01, $20 ; entry 1
    db $F9, $00, $02, $20 ; entry 2
    db $F9, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set02Frame2::
Data_027_452A:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set02Frame3::
Data_027_453B:: ; address name
    db $F1, $F8, $04, $00 ; entry 0
    db $F1, $00, $05, $00 ; entry 1
    db $F9, $F8, $08, $00 ; entry 2
    db $F9, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set02Frame4::
Data_027_454C:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set02Frame5::
Data_027_455D:: ; address name
    db $F1, $00, $0A, $20 ; entry 0
    db $F1, $F8, $0B, $20 ; entry 1
    db $F9, $00, $0C, $20 ; entry 2
    db $F9, $F8, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 3 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set03::
Data_027_456E:: ; address name
    dw MetaSprites27Set03Frame0 ; entry 0
    dw MetaSprites27Set03Frame1 ; entry 1
    dw MetaSprites27Set03Frame2 ; entry 2
    dw MetaSprites27Set03Frame3 ; entry 3
    dw MetaSprites27Set03Frame4 ; entry 4
    dw MetaSprites27Set03Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set03Frame0::
Data_027_457A:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set03Frame1::
Data_027_458B:: ; address name
    db $F1, $F8, $00, $10 ; entry 0
    db $F1, $00, $01, $10 ; entry 1
    db $F9, $00, $03, $10 ; entry 2
    db $F9, $F8, $04, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set03Frame2::
Data_027_459C:: ; address name
    db $F0, $F8, $05, $10 ; entry 0
    db $F0, $00, $06, $10 ; entry 1
    db $F8, $F8, $07, $10 ; entry 2
    db $F8, $00, $08, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set03Frame3::
Data_027_45AD:: ; address name
    db $F1, $F8, $05, $10 ; entry 0
    db $F1, $00, $06, $10 ; entry 1
    db $F9, $00, $08, $10 ; entry 2
    db $F9, $F8, $09, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set03Frame4::
Data_027_45BE:: ; address name
    db $F0, $F8, $0A, $10 ; entry 0
    db $F0, $00, $0B, $10 ; entry 1
    db $F8, $F8, $0C, $10 ; entry 2
    db $F8, $00, $07, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set03Frame5::
Data_027_45CF:: ; address name
    db $F1, $F8, $0A, $10 ; entry 0
    db $F1, $00, $0B, $10 ; entry 1
    db $F9, $F8, $0C, $10 ; entry 2
    db $F9, $00, $09, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 4 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set04::
Data_027_45E0:: ; address name
    dw MetaSprites27Set04Frame0 ; entry 0
    dw MetaSprites27Set04Frame1 ; entry 1
    dw MetaSprites27Set04Frame2 ; entry 2
    dw MetaSprites27Set04Frame3 ; entry 3
    dw MetaSprites27Set04Frame4 ; entry 4
    dw MetaSprites27Set04Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set04Frame0::
Data_027_45EC:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set04Frame1::
Data_027_45FD:: ; address name
    db $F1, $F6, $00, $00 ; entry 0
    db $F1, $FE, $01, $00 ; entry 1
    db $F9, $F6, $04, $00 ; entry 2
    db $F9, $FE, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set04Frame2::
Data_027_460E:: ; address name
    db $EF, $F9, $06, $00 ; entry 0
    db $EF, $01, $07, $00 ; entry 1
    db $F7, $F9, $08, $00 ; entry 2
    db $F7, $01, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set04Frame3::
Data_027_461F:: ; address name
    db $F1, $F7, $06, $00 ; entry 0
    db $F1, $FF, $07, $00 ; entry 1
    db $F9, $F7, $0A, $00 ; entry 2
    db $F9, $FF, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set04Frame4::
Data_027_4630:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set04Frame5::
Data_027_4641:: ; address name
    db $F1, $FA, $0C, $00 ; entry 0
    db $F1, $02, $0D, $00 ; entry 1
    db $F9, $02, $04, $20 ; entry 2
    db $F9, $FA, $05, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 5 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set05::
Data_027_4652:: ; address name
    dw MetaSprites27Set05Frame0 ; entry 0
    dw MetaSprites27Set05Frame1 ; entry 1
    dw MetaSprites27Set05Frame2 ; entry 2
    dw MetaSprites27Set05Frame3 ; entry 3
    dw MetaSprites27Set05Frame4 ; entry 4
    dw MetaSprites27Set05Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set05Frame0::
Data_027_465E:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F9, $F8, $01, $00 ; entry 1
    db $F1, $FF, $00, $20 ; entry 2
    db $F9, $FF, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set05Frame1::
Data_027_466F:: ; address name
    db $F0, $F8, $02, $00 ; entry 0
    db $F8, $F8, $03, $00 ; entry 1
    db $F0, $FF, $02, $20 ; entry 2
    db $F8, $FF, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set05Frame2::
Data_027_4680:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set05Frame3::
Data_027_4691:: ; address name
    db $EF, $F8, $08, $00 ; entry 0
    db $EF, $00, $09, $00 ; entry 1
    db $F7, $F8, $0A, $00 ; entry 2
    db $F7, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set05Frame4::
Data_027_46A2:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F8, $F8, $0D, $00 ; entry 1
    db $F0, $FF, $0C, $20 ; entry 2
    db $F8, $FF, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set05Frame5::
Data_027_46B3:: ; address name
    db $EF, $F8, $0E, $00 ; entry 0
    db $F7, $F8, $0F, $00 ; entry 1
    db $EF, $FF, $0E, $20 ; entry 2
    db $F7, $FF, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 6 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set06::
Data_027_46C4:: ; address name
    dw MetaSprites27Set06Frame0 ; entry 0
    dw MetaSprites27Set06Frame1 ; entry 1
    dw MetaSprites27Set06Frame2 ; entry 2
    dw MetaSprites27Set06Frame3 ; entry 3
    dw MetaSprites27Set06Frame4 ; entry 4
    dw MetaSprites27Set06Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set06; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set06Frame0::
Data_027_46D0:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $F8, $02, $00 ; entry 2
    db $F9, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set06; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set06Frame1::
Data_027_46E1:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $04, $00 ; entry 2
    db $F8, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set06; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set06Frame2::
Data_027_46F2:: ; address name
    db $F1, $01, $06, $00 ; entry 0
    db $F1, $F9, $01, $20 ; entry 1
    db $F9, $F8, $07, $00 ; entry 2
    db $F9, $00, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set06; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set06Frame3::
Data_027_4703:: ; address name
    db $F0, $01, $06, $00 ; entry 0
    db $F0, $F9, $01, $20 ; entry 1
    db $F8, $F8, $09, $00 ; entry 2
    db $F8, $00, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set06; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set06Frame4::
Data_027_4714:: ; address name
    db $F0, $F9, $0B, $20 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set06; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set06Frame5::
Data_027_4725:: ; address name
    db $F1, $F9, $0B, $20 ; entry 0
    db $F1, $00, $0B, $00 ; entry 1
    db $F9, $F8, $0E, $00 ; entry 2
    db $F9, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 7 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set07::
Data_027_4736:: ; address name
    dw MetaSprites27Set07Frame0 ; entry 0
    dw MetaSprites27Set07Frame1 ; entry 1
    dw MetaSprites27Set07Frame2 ; entry 2
    dw MetaSprites27Set07Frame3 ; entry 3
    dw MetaSprites27Set07Frame4 ; entry 4
    dw MetaSprites27Set07Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set07; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set07Frame0::
Data_027_4742:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set07; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set07Frame1::
Data_027_4753:: ; address name
    db $EE, $F8, $00, $10 ; entry 0
    db $EE, $00, $01, $10 ; entry 1
    db $F6, $F8, $04, $10 ; entry 2
    db $F6, $00, $05, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set07; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set07Frame2::
Data_027_4764:: ; address name
    db $F1, $F8, $06, $10 ; entry 0
    db $F1, $00, $07, $10 ; entry 1
    db $F9, $00, $09, $10 ; entry 2
    db $F9, $F8, $0A, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set07; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set07Frame3::
Data_027_4775:: ; address name
    db $EF, $F8, $06, $10 ; entry 0
    db $EF, $00, $07, $10 ; entry 1
    db $F7, $F8, $08, $10 ; entry 2
    db $F7, $00, $09, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set07; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set07Frame4::
Data_027_4786:: ; address name
    db $F8, $F8, $0C, $10 ; entry 0
    db $F8, $00, $0D, $10 ; entry 1
    db $F0, $F8, $06, $10 ; entry 2
    db $F0, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set07; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set07Frame5::
Data_027_4797:: ; address name
    db $F9, $F8, $0E, $10 ; entry 0
    db $F9, $00, $0F, $10 ; entry 1
    db $F1, $F8, $06, $10 ; entry 2
    db $F1, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 8 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set08::
Data_027_47A8:: ; address name
    dw MetaSprites27Set08Frame0 ; entry 0
    dw MetaSprites27Set08Frame1 ; entry 1
    dw MetaSprites27Set08Frame2 ; entry 2
    dw MetaSprites27Set08Frame3 ; entry 3
    dw MetaSprites27Set08Frame4 ; entry 4
    dw MetaSprites27Set08Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set08; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set08Frame0::
Data_027_47B4:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set08; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set08Frame1::
Data_027_47C5:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $F8, $04, $00 ; entry 2
    db $F9, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set08; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set08Frame2::
Data_027_47D6:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set08; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set08Frame3::
Data_027_47E7:: ; address name
    db $F9, $F8, $0A, $00 ; entry 0
    db $F9, $00, $0B, $00 ; entry 1
    db $F1, $F8, $06, $00 ; entry 2
    db $F1, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set08; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set08Frame4::
Data_027_47F8:: ; address name
    db $F1, $F8, $0C, $00 ; entry 0
    db $F1, $00, $0D, $00 ; entry 1
    db $F9, $F8, $0E, $00 ; entry 2
    db $F9, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set08; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set08Frame5::
Data_027_4809:: ; address name
    db $F0, $00, $0C, $20 ; entry 0
    db $F0, $F8, $0D, $20 ; entry 1
    db $F8, $00, $0E, $20 ; entry 2
    db $F8, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 9 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set09::
Data_027_481A:: ; address name
    dw MetaSprites27Set09Frame0 ; entry 0
    dw MetaSprites27Set09Frame1 ; entry 1
    dw MetaSprites27Set09Frame2 ; entry 2
    dw MetaSprites27Set09Frame3 ; entry 3
    dw MetaSprites27Set09Frame4 ; entry 4
    dw MetaSprites27Set09Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set09; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set09Frame0::
Data_027_4826:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set09; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set09Frame1::
Data_027_4837:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $F8, $04, $00 ; entry 2
    db $F9, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set09; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set09Frame2::
Data_027_4848:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set09; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set09Frame3::
Data_027_4859:: ; address name
    db $F9, $F8, $0A, $00 ; entry 0
    db $F9, $00, $0B, $00 ; entry 1
    db $F1, $F8, $06, $00 ; entry 2
    db $F1, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set09; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set09Frame4::
Data_027_486A:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $00, $0E, $00 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set09; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set09Frame5::
Data_027_487B:: ; address name
    db $F1, $F8, $0C, $00 ; entry 0
    db $F1, $00, $0D, $00 ; entry 1
    db $F9, $00, $0F, $00 ; entry 2
    db $F9, $F8, $05, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 10 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set0A::
Data_027_488C:: ; address name
    dw MetaSprites27Set0AFrame0 ; entry 0
    dw MetaSprites27Set0AFrame1 ; entry 1
    dw MetaSprites27Set0AFrame2 ; entry 2
    dw MetaSprites27Set0AFrame3 ; entry 3
    dw MetaSprites27Set0AFrame4 ; entry 4
    dw MetaSprites27Set0AFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set0A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0AFrame0::
Data_027_4898:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set0A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0AFrame1::
Data_027_48A9:: ; address name
    db $EF, $00, $00, $20 ; entry 0
    db $EF, $F8, $01, $20 ; entry 1
    db $F7, $00, $02, $20 ; entry 2
    db $F7, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set0A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0AFrame2::
Data_027_48BA:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set0A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0AFrame3::
Data_027_48CB:: ; address name
    db $EF, $F8, $08, $00 ; entry 0
    db $EF, $00, $09, $00 ; entry 1
    db $F7, $F8, $0A, $00 ; entry 2
    db $F7, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set0A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0AFrame4::
Data_027_48DC:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set0A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0AFrame5::
Data_027_48ED:: ; address name
    db $EF, $00, $0C, $20 ; entry 0
    db $EF, $F8, $0D, $20 ; entry 1
    db $F7, $00, $0E, $20 ; entry 2
    db $F7, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 11 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set0B::
Data_027_48FE:: ; address name
    dw MetaSprites27Set0BFrame0 ; entry 0
    dw MetaSprites27Set0BFrame1 ; entry 1
    dw MetaSprites27Set0BFrame2 ; entry 2
    dw MetaSprites27Set0BFrame3 ; entry 3
    dw MetaSprites27Set0BFrame4 ; entry 4
    dw MetaSprites27Set0BFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0BFrame0::
Data_027_490A:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0BFrame1::
Data_027_491B:: ; address name
    db $F8, $FF, $02, $30 ; entry 0
    db $F8, $F7, $03, $30 ; entry 1
    db $F0, $F8, $04, $10 ; entry 2
    db $F0, $00, $05, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0BFrame2::
Data_027_492C:: ; address name
    db $F0, $F8, $06, $10 ; entry 0
    db $F8, $F8, $07, $10 ; entry 1
    db $F0, $00, $01, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0BFrame3::
Data_027_493D:: ; address name
    db $F0, $F8, $08, $10 ; entry 0
    db $F8, $F8, $09, $10 ; entry 1
    db $F0, $00, $05, $10 ; entry 2
    db $F8, $00, $02, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0BFrame4::
Data_027_494E:: ; address name
    db $F0, $F7, $0A, $10 ; entry 0
    db $F0, $FF, $0B, $10 ; entry 1
    db $F8, $F7, $0C, $10 ; entry 2
    db $F8, $FF, $0D, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0BFrame5::
Data_027_495F:: ; address name
    db $F8, $00, $0C, $30 ; entry 0
    db $F8, $F8, $0D, $30 ; entry 1
    db $F0, $F7, $0E, $10 ; entry 2
    db $F0, $FF, $0F, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 12 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set0C::
Data_027_4970:: ; address name
    dw MetaSprites27Set0CFrame0 ; entry 0
    dw MetaSprites27Set0CFrame1 ; entry 1
    dw MetaSprites27Set0CFrame2 ; entry 2
    dw MetaSprites27Set0CFrame3 ; entry 3
    dw MetaSprites27Set0CFrame4 ; entry 4
    dw MetaSprites27Set0CFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set0C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0CFrame0::
Data_027_497C:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set0C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0CFrame1::
Data_027_498D:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $00, $02, $20 ; entry 2
    db $F9, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set0C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0CFrame2::
Data_027_499E:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set0C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0CFrame3::
Data_027_49AF:: ; address name
    db $F1, $F8, $04, $00 ; entry 0
    db $F1, $00, $05, $00 ; entry 1
    db $F9, $F8, $08, $00 ; entry 2
    db $F9, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set0C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0CFrame4::
Data_027_49C0:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set0C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0CFrame5::
Data_027_49D1:: ; address name
    db $F1, $F8, $0A, $00 ; entry 0
    db $F1, $00, $0B, $00 ; entry 1
    db $F9, $00, $0C, $20 ; entry 2
    db $F9, $F8, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 13 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set0D::
Data_027_49E2:: ; address name
    dw MetaSprites27Set0DFrame0 ; entry 0
    dw MetaSprites27Set0DFrame1 ; entry 1
    dw MetaSprites27Set0DFrame2 ; entry 2
    dw MetaSprites27Set0DFrame3 ; entry 3
    dw MetaSprites27Set0DFrame4 ; entry 4
    dw MetaSprites27Set0DFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set0D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0DFrame0::
Data_027_49EE:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set0D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0DFrame1::
Data_027_49FF:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set0D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0DFrame2::
Data_027_4A10:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F8, $F8, $0E, $00 ; entry 1
    db $F0, $00, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set0D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0DFrame3::
Data_027_4A21:: ; address name
    db $F0, $F8, $0D, $20 ; entry 0
    db $F8, $F8, $0F, $20 ; entry 1
    db $F0, $00, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set0D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0DFrame4::
Data_027_4A32:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set0D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0DFrame5::
Data_027_4A43:: ; address name
    db $F0, $FF, $0C, $20 ; entry 0
    db $F0, $F7, $0D, $20 ; entry 1
    db $F8, $FF, $0E, $20 ; entry 2
    db $F8, $F7, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 14 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set0E::
Data_027_4A54:: ; address name
    dw MetaSprites27Set0EFrame0 ; entry 0
    dw MetaSprites27Set0EFrame1 ; entry 1
    dw MetaSprites27Set0EFrame2 ; entry 2
    dw MetaSprites27Set0EFrame3 ; entry 3
    dw MetaSprites27Set0EFrame4 ; entry 4
    dw MetaSprites27Set0EFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set0E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0EFrame0::
Data_027_4A60:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set0E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0EFrame1::
Data_027_4A71:: ; address name
    db $F1, $F8, $03, $00 ; entry 0
    db $F1, $00, $04, $00 ; entry 1
    db $F9, $F8, $05, $00 ; entry 2
    db $F9, $00, $05, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set0E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0EFrame2::
Data_027_4A82:: ; address name
    db $F1, $F8, $06, $00 ; entry 0
    db $F1, $00, $07, $00 ; entry 1
    db $F9, $F8, $08, $00 ; entry 2
    db $F9, $00, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set0E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0EFrame3::
Data_027_4A93:: ; address name
    db $F0, $F8, $09, $00 ; entry 0
    db $F0, $00, $0A, $00 ; entry 1
    db $F8, $F8, $0B, $00 ; entry 2
    db $F8, $00, $05, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set0E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0EFrame4::
Data_027_4AA4:: ; address name
    db $F8, $F8, $0E, $00 ; entry 0
    db $F8, $00, $0E, $20 ; entry 1
    db $F0, $F8, $0C, $00 ; entry 2
    db $F0, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set0E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0EFrame5::
Data_027_4AB5:: ; address name
    db $F9, $F8, $0F, $00 ; entry 0
    db $F9, $00, $0F, $20 ; entry 1
    db $F1, $F8, $0C, $00 ; entry 2
    db $F1, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 15 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set0F::
Data_027_4AC6:: ; address name
    dw MetaSprites27Set0FFrame0 ; entry 0
    dw MetaSprites27Set0FFrame1 ; entry 1
    dw MetaSprites27Set0FFrame2 ; entry 2
    dw MetaSprites27Set0FFrame3 ; entry 3
    dw MetaSprites27Set0FFrame4 ; entry 4
    dw MetaSprites27Set0FFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set0F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0FFrame0::
Data_027_4AD2:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set0F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0FFrame1::
Data_027_4AE3:: ; address name
    db $F1, $F8, $02, $00 ; entry 0
    db $F1, $00, $02, $20 ; entry 1
    db $F9, $F8, $03, $00 ; entry 2
    db $F9, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set0F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0FFrame2::
Data_027_4AF4:: ; address name
    db $F0, $F7, $04, $00 ; entry 0
    db $F0, $FF, $05, $00 ; entry 1
    db $F8, $F7, $06, $00 ; entry 2
    db $F8, $FF, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set0F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0FFrame3::
Data_027_4B05:: ; address name
    db $F9, $F7, $06, $00 ; entry 0
    db $F1, $F7, $04, $00 ; entry 1
    db $F1, $FF, $08, $00 ; entry 2
    db $F9, $FF, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set0F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0FFrame4::
Data_027_4B16:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0A, $20 ; entry 1
    db $F8, $F8, $0B, $00 ; entry 2
    db $F8, $00, $0C, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set0F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set0FFrame5::
Data_027_4B27:: ; address name
    db $F1, $F8, $0D, $00 ; entry 0
    db $F1, $00, $0D, $20 ; entry 1
    db $F9, $F8, $0E, $00 ; entry 2
    db $F9, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 16 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set10::
Data_027_4B38:: ; address name
    dw MetaSprites27Set10Frame0 ; entry 0
    dw MetaSprites27Set10Frame1 ; entry 1
    dw MetaSprites27Set10Frame2 ; entry 2
    dw MetaSprites27Set10Frame3 ; entry 3
    dw MetaSprites27Set10Frame4 ; entry 4
    dw MetaSprites27Set10Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set10Frame0::
Data_027_4B44:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set10Frame1::
Data_027_4B55:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $00, $03, $00 ; entry 2
    db $F9, $F8, $04, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set10Frame2::
Data_027_4B66:: ; address name
    db $F0, $F9, $05, $00 ; entry 0
    db $F0, $01, $06, $00 ; entry 1
    db $F8, $F9, $07, $00 ; entry 2
    db $F8, $01, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set10Frame3::
Data_027_4B77:: ; address name
    db $F9, $F9, $07, $00 ; entry 0
    db $F1, $F9, $05, $00 ; entry 1
    db $F1, $01, $06, $00 ; entry 2
    db $F9, $01, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set10Frame4::
Data_027_4B88:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set10Frame5::
Data_027_4B99:: ; address name
    db $F1, $F8, $0A, $00 ; entry 0
    db $F1, $00, $0B, $00 ; entry 1
    db $F9, $F8, $0E, $00 ; entry 2
    db $F9, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 17 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set11::
Data_027_4BAA:: ; address name
    dw MetaSprites27Set11Frame0 ; entry 0
    dw MetaSprites27Set11Frame1 ; entry 1
    dw MetaSprites27Set11Frame2 ; entry 2
    dw MetaSprites27Set11Frame3 ; entry 3
    dw MetaSprites27Set11Frame4 ; entry 4
    dw MetaSprites27Set11Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set11Frame0::
Data_027_4BB6:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set11Frame1::
Data_027_4BC7:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set11Frame2::
Data_027_4BD8:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F8, $09, $00 ; entry 2
    db $F8, $00, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set11Frame3::
Data_027_4BE9:: ; address name
    db $F0, $00, $0B, $00 ; entry 0
    db $F8, $F8, $0C, $00 ; entry 1
    db $F8, $00, $0D, $00 ; entry 2
    db $F0, $F8, $05, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set11Frame4::
Data_027_4BFA:: ; address name
    db $F0, $00, $00, $20 ; entry 0
    db $F0, $F8, $01, $20 ; entry 1
    db $F8, $00, $0E, $00 ; entry 2
    db $F8, $F8, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set11Frame5::
Data_027_4C0B:: ; address name
    db $F0, $00, $04, $20 ; entry 0
    db $F0, $F8, $05, $20 ; entry 1
    db $F8, $00, $0F, $00 ; entry 2
    db $F8, $F8, $0C, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 26 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set1A::
Data_027_4C1C:: ; address name
    dw MetaSprites27Set1AFrame0 ; entry 0
    dw MetaSprites27Set1AFrame1 ; entry 1
    dw MetaSprites27Set1AFrame2 ; entry 2
    dw MetaSprites27Set1AFrame3 ; entry 3
    dw MetaSprites27Set1AFrame4 ; entry 4
    dw MetaSprites27Set1AFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1AFrame0::
Data_027_4C28:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1AFrame1::
Data_027_4C39:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $00, $20 ; entry 1
    db $F9, $F8, $03, $00 ; entry 2
    db $F9, $00, $04, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1AFrame2::
Data_027_4C4A:: ; address name
    db $EF, $F8, $05, $00 ; entry 0
    db $EF, $00, $06, $00 ; entry 1
    db $F7, $F8, $07, $00 ; entry 2
    db $F7, $00, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1AFrame3::
Data_027_4C5B:: ; address name
    db $F0, $F8, $05, $00 ; entry 0
    db $F0, $00, $06, $00 ; entry 1
    db $F8, $F8, $09, $00 ; entry 2
    db $F8, $00, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1AFrame4::
Data_027_4C6C:: ; address name
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $00, $0B, $20 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1AFrame5::
Data_027_4C7D:: ; address name
    db $F1, $F8, $0B, $00 ; entry 0
    db $F1, $00, $0B, $20 ; entry 1
    db $F9, $F8, $0E, $00 ; entry 2
    db $F9, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 27 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set1B::
Data_027_4C8E:: ; address name
    dw MetaSprites27Set1BFrame0 ; entry 0
    dw MetaSprites27Set1BFrame1 ; entry 1
    dw MetaSprites27Set1BFrame2 ; entry 2
    dw MetaSprites27Set1BFrame3 ; entry 3
    dw MetaSprites27Set1BFrame4 ; entry 4
    dw MetaSprites27Set1BFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1BFrame0::
Data_027_4C9A:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1BFrame1::
Data_027_4CAB:: ; address name
    db $F9, $00, $02, $20 ; entry 0
    db $F9, $F8, $03, $20 ; entry 1
    db $F1, $00, $00, $20 ; entry 2
    db $F1, $F8, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1BFrame2::
Data_027_4CBC:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1BFrame3::
Data_027_4CCD:: ; address name
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1BFrame4::
Data_027_4CDE:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1BFrame5::
Data_027_4CEF:: ; address name
    db $F1, $00, $0C, $20 ; entry 0
    db $F1, $F8, $0D, $20 ; entry 1
    db $F9, $00, $0E, $20 ; entry 2
    db $F9, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 28 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set1C::
Data_027_4D00:: ; address name
    dw MetaSprites27Set1CFrame0 ; entry 0
    dw MetaSprites27Set1CFrame1 ; entry 1
    dw MetaSprites27Set1CFrame2 ; entry 2
    dw MetaSprites27Set1CFrame3 ; entry 3
    dw MetaSprites27Set1CFrame4 ; entry 4
    dw MetaSprites27Set1CFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1CFrame0::
Data_027_4D0C:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $01, $00 ; entry 1
    db $F0, $FF, $00, $20 ; entry 2
    db $F8, $FF, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1CFrame1::
Data_027_4D1D:: ; address name
    db $EF, $F8, $02, $00 ; entry 0
    db $F7, $F8, $03, $00 ; entry 1
    db $EF, $FF, $02, $20 ; entry 2
    db $F7, $FF, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1CFrame2::
Data_027_4D2E:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1CFrame3::
Data_027_4D3F:: ; address name
    db $EF, $F8, $08, $00 ; entry 0
    db $EF, $00, $09, $00 ; entry 1
    db $F7, $F8, $0A, $00 ; entry 2
    db $F7, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1CFrame4::
Data_027_4D50:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $FF, $0C, $20 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $FF, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1CFrame5::
Data_027_4D61:: ; address name
    db $EF, $F8, $0E, $00 ; entry 0
    db $F7, $F8, $0F, $00 ; entry 1
    db $EF, $FF, $0E, $20 ; entry 2
    db $F7, $FF, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 29 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set1D::
Data_027_4D72:: ; address name
    dw MetaSprites27Set1DFrame0 ; entry 0
    dw MetaSprites27Set1DFrame1 ; entry 1
    dw MetaSprites27Set1DFrame2 ; entry 2
    dw MetaSprites27Set1DFrame3 ; entry 3
    dw MetaSprites27Set1DFrame4 ; entry 4
    dw MetaSprites27Set1DFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set1D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1DFrame0::
Data_027_4D7E:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $FF, $00, $30 ; entry 1
    db $F8, $F8, $01, $10 ; entry 2
    db $F8, $FF, $01, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set1D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1DFrame1::
Data_027_4D8F:: ; address name
    db $F1, $F8, $02, $10 ; entry 0
    db $F1, $FF, $02, $30 ; entry 1
    db $F9, $F8, $03, $10 ; entry 2
    db $F9, $FF, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set1D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1DFrame2::
Data_027_4DA0:: ; address name
    db $EF, $F8, $04, $10 ; entry 0
    db $EF, $00, $05, $10 ; entry 1
    db $F7, $F8, $06, $10 ; entry 2
    db $F7, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set1D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1DFrame3::
Data_027_4DB1:: ; address name
    db $F8, $F8, $06, $10 ; entry 0
    db $F8, $00, $07, $10 ; entry 1
    db $F0, $F8, $08, $10 ; entry 2
    db $F0, $00, $05, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set1D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1DFrame4::
Data_027_4DC2:: ; address name
    db $F0, $F8, $09, $10 ; entry 0
    db $F0, $FF, $09, $30 ; entry 1
    db $F8, $F8, $0A, $10 ; entry 2
    db $F8, $FF, $0A, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set1D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1DFrame5::
Data_027_4DD3:: ; address name
    db $F1, $F8, $0B, $10 ; entry 0
    db $F1, $FF, $0B, $30 ; entry 1
    db $F9, $F8, $0C, $10 ; entry 2
    db $F9, $FF, $0C, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 30 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set1E::
Data_027_4DE4:: ; address name
    dw MetaSprites27Set1EFrame0 ; entry 0
    dw MetaSprites27Set1EFrame1 ; entry 1
    dw MetaSprites27Set1EFrame2 ; entry 2
    dw MetaSprites27Set1EFrame3 ; entry 3
    dw MetaSprites27Set1EFrame4 ; entry 4
    dw MetaSprites27Set1EFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1EFrame0::
Data_027_4DF0:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1EFrame1::
Data_027_4E01:: ; address name
    db $F9, $00, $02, $20 ; entry 0
    db $F9, $F8, $03, $20 ; entry 1
    db $F1, $00, $00, $20 ; entry 2
    db $F1, $F8, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1EFrame2::
Data_027_4E12:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1EFrame3::
Data_027_4E23:: ; address name
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1EFrame4::
Data_027_4E34:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1EFrame5::
Data_027_4E45:: ; address name
    db $F1, $00, $0C, $20 ; entry 0
    db $F1, $F8, $0D, $20 ; entry 1
    db $F9, $00, $0E, $20 ; entry 2
    db $F9, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 31 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set1F::
Data_027_4E56:: ; address name
    dw MetaSprites27Set1FFrame0 ; entry 0
    dw MetaSprites27Set1FFrame1 ; entry 1
    dw MetaSprites27Set1FFrame2 ; entry 2
    dw MetaSprites27Set1FFrame3 ; entry 3
    dw MetaSprites27Set1FFrame4 ; entry 4
    dw MetaSprites27Set1FFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1FFrame0::
Data_027_4E62:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $00, $30 ; entry 1
    db $F8, $F8, $01, $10 ; entry 2
    db $F8, $00, $02, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1FFrame1::
Data_027_4E73:: ; address name
    db $EF, $F8, $00, $10 ; entry 0
    db $EF, $00, $00, $30 ; entry 1
    db $F7, $00, $01, $30 ; entry 2
    db $F7, $F8, $02, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1FFrame2::
Data_027_4E84:: ; address name
    db $EF, $F8, $03, $10 ; entry 0
    db $EF, $00, $04, $10 ; entry 1
    db $F7, $F8, $05, $10 ; entry 2
    db $F7, $00, $06, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1FFrame3::
Data_027_4E95:: ; address name
    db $F0, $F8, $03, $10 ; entry 0
    db $F8, $F8, $08, $10 ; entry 1
    db $F8, $00, $09, $10 ; entry 2
    db $F0, $00, $04, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1FFrame4::
Data_027_4EA6:: ; address name
    db $F0, $F8, $0A, $10 ; entry 0
    db $F0, $00, $0A, $30 ; entry 1
    db $F8, $F8, $0B, $10 ; entry 2
    db $F8, $00, $0C, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set1FFrame5::
Data_027_4EB7:: ; address name
    db $EF, $F8, $0A, $10 ; entry 0
    db $EF, $00, $0A, $30 ; entry 1
    db $F7, $00, $0B, $30 ; entry 2
    db $F7, $F8, $0C, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 32 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set20::
Data_027_4EC8:: ; address name
    dw MetaSprites27Set20Frame0 ; entry 0
    dw MetaSprites27Set20Frame1 ; entry 1
    dw MetaSprites27Set20Frame2 ; entry 2
    dw MetaSprites27Set20Frame3 ; entry 3
    dw MetaSprites27Set20Frame4 ; entry 4
    dw MetaSprites27Set20Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set20; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set20Frame0::
Data_027_4ED4:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set20; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set20Frame1::
Data_027_4EE5:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $00, $03, $00 ; entry 1
    db $F0, $00, $04, $00 ; entry 2
    db $F8, $F8, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set20; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set20Frame2::
Data_027_4EF6:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set20; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set20Frame3::
Data_027_4F07:: ; address name
    db $F0, $00, $07, $00 ; entry 0
    db $F8, $F8, $03, $20 ; entry 1
    db $F0, $F8, $08, $00 ; entry 2
    db $F8, $00, $05, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set20; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set20Frame4::
Data_027_4F18:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set20; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set20Frame5::
Data_027_4F29:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0B, $00 ; entry 2
    db $F8, $00, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 33 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set21::
Data_027_4F3A:: ; address name
    dw MetaSprites27Set21Frame0 ; entry 0
    dw MetaSprites27Set21Frame1 ; entry 1
    dw MetaSprites27Set21Frame2 ; entry 2
    dw MetaSprites27Set21Frame3 ; entry 3
    dw MetaSprites27Set21Frame4 ; entry 4
    dw MetaSprites27Set21Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set21; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set21Frame0::
Data_027_4F46:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $01, $00 ; entry 1
    db $F8, $00, $02, $00 ; entry 2
    db $F0, $FF, $00, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set21; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set21Frame1::
Data_027_4F57:: ; address name
    db $F0, $FF, $00, $20 ; entry 0
    db $F0, $F8, $00, $00 ; entry 1
    db $F8, $FF, $01, $20 ; entry 2
    db $F8, $F7, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set21; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set21Frame2::
Data_027_4F68:: ; address name
    db $F0, $F8, $03, $00 ; entry 0
    db $F0, $00, $04, $00 ; entry 1
    db $F8, $F8, $05, $00 ; entry 2
    db $F8, $00, $06, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set21; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set21Frame3::
Data_027_4F79:: ; address name
    db $F8, $F8, $07, $00 ; entry 0
    db $F8, $00, $08, $00 ; entry 1
    db $F0, $F8, $03, $00 ; entry 2
    db $F0, $00, $04, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set21; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set21Frame4::
Data_027_4F8A:: ; address name
    db $F0, $F8, $09, $00 ; entry 0
    db $F0, $FF, $09, $20 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set21; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set21Frame5::
Data_027_4F9B:: ; address name
    db $F0, $FF, $09, $20 ; entry 0
    db $F0, $F8, $09, $00 ; entry 1
    db $F8, $FF, $0A, $20 ; entry 2
    db $F8, $F7, $0B, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 34 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set22::
Data_027_4FAC:: ; address name
    dw MetaSprites27Set22Frame0 ; entry 0
    dw MetaSprites27Set22Frame1 ; entry 1
    dw MetaSprites27Set22Frame2 ; entry 2
    dw MetaSprites27Set22Frame3 ; entry 3
    dw MetaSprites27Set22Frame4 ; entry 4
    dw MetaSprites27Set22Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set22; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set22Frame0::
Data_027_4FB8:: ; address name
    db $F8, $F8, $02, $00 ; entry 0
    db $F0, $F8, $00, $00 ; entry 1
    db $F0, $00, $01, $00 ; entry 2
    db $F8, $00, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set22; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set22Frame1::
Data_027_4FC9:: ; address name
    db $F1, $F8, $03, $00 ; entry 0
    db $F1, $00, $04, $00 ; entry 1
    db $F9, $F8, $05, $00 ; entry 2
    db $F9, $00, $05, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set22; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set22Frame2::
Data_027_4FDA:: ; address name
    db $F8, $F8, $08, $00 ; entry 0
    db $F8, $00, $08, $20 ; entry 1
    db $F0, $F8, $06, $00 ; entry 2
    db $F0, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set22; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set22Frame3::
Data_027_4FEB:: ; address name
    db $F1, $F8, $09, $00 ; entry 0
    db $F1, $00, $0A, $00 ; entry 1
    db $F9, $F8, $0B, $00 ; entry 2
    db $F9, $00, $0B, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set22; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set22Frame4::
Data_027_4FFC:: ; address name
    db $F8, $F8, $08, $00 ; entry 0
    db $F8, $00, $08, $20 ; entry 1
    db $F0, $F8, $0C, $00 ; entry 2
    db $F0, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set22; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set22Frame5::
Data_027_500D:: ; address name
    db $F1, $F8, $0E, $00 ; entry 0
    db $F1, $00, $0F, $00 ; entry 1
    db $F9, $F8, $0B, $00 ; entry 2
    db $F9, $00, $0B, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 35 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set23::
Data_027_501E:: ; address name
    dw MetaSprites27Set23Frame0 ; entry 0
    dw MetaSprites27Set23Frame1 ; entry 1
    dw MetaSprites27Set23Frame2 ; entry 2
    dw MetaSprites27Set23Frame3 ; entry 3
    dw MetaSprites27Set23Frame4 ; entry 4
    dw MetaSprites27Set23Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set23; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set23Frame0::
Data_027_502A:: ; address name
    db $F1, $F8, $00, $10 ; entry 0
    db $F1, $00, $00, $30 ; entry 1
    db $F9, $F8, $01, $10 ; entry 2
    db $F9, $00, $01, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set23; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set23Frame1::
Data_027_503B:: ; address name
    db $F8, $F8, $01, $10 ; entry 0
    db $F8, $00, $01, $30 ; entry 1
    db $F0, $F8, $02, $10 ; entry 2
    db $F0, $00, $02, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set23; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set23Frame2::
Data_027_504C:: ; address name
    db $F1, $F8, $03, $10 ; entry 0
    db $F1, $00, $04, $10 ; entry 1
    db $F9, $F8, $05, $10 ; entry 2
    db $F9, $00, $06, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set23; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set23Frame3::
Data_027_505D:: ; address name
    db $F8, $F8, $05, $10 ; entry 0
    db $F8, $00, $06, $10 ; entry 1
    db $F0, $00, $07, $10 ; entry 2
    db $F0, $F8, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set23; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set23Frame4::
Data_027_506E:: ; address name
    db $F1, $F8, $08, $10 ; entry 0
    db $F1, $00, $08, $30 ; entry 1
    db $F9, $F8, $09, $10 ; entry 2
    db $F9, $00, $09, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set23; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set23Frame5::
Data_027_507F:: ; address name
    db $F0, $F8, $08, $10 ; entry 0
    db $F0, $00, $08, $30 ; entry 1
    db $F8, $F8, $09, $10 ; entry 2
    db $F8, $00, $09, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 36 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set24::
Data_027_5090:: ; address name
    dw MetaSprites27Set24Frame0 ; entry 0
    dw MetaSprites27Set24Frame1 ; entry 1
    dw MetaSprites27Set24Frame2 ; entry 2
    dw MetaSprites27Set24Frame3 ; entry 3
    dw MetaSprites27Set24Frame4 ; entry 4
    dw MetaSprites27Set24Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set24; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set24Frame0::
Data_027_509C:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $01, $00 ; entry 1
    db $F8, $00, $02, $00 ; entry 2
    db $F0, $FF, $00, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set24; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set24Frame1::
Data_027_50AD:: ; address name
    db $F8, $00, $01, $20 ; entry 0
    db $F8, $F8, $02, $20 ; entry 1
    db $F0, $F9, $03, $00 ; entry 2
    db $F0, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set24; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set24Frame2::
Data_027_50BE:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set24; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set24Frame3::
Data_027_50CF:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set24; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set24Frame4::
Data_027_50E0:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $FF, $0C, $20 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0E, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set24; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set24Frame5::
Data_027_50F1:: ; address name
    db $F8, $00, $0D, $20 ; entry 0
    db $F8, $F8, $0E, $20 ; entry 1
    db $F0, $00, $0F, $20 ; entry 2
    db $F0, $F9, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 37 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set25::
Data_027_5102:: ; address name
    dw MetaSprites27Set25Frame0 ; entry 0
    dw MetaSprites27Set25Frame1 ; entry 1
    dw MetaSprites27Set25Frame2 ; entry 2
    dw MetaSprites27Set25Frame3 ; entry 3
    dw MetaSprites27Set25Frame4 ; entry 4
    dw MetaSprites27Set25Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set25Frame0::
Data_027_510E:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $FF, $00, $30 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set25Frame1::
Data_027_511F:: ; address name
    db $F0, $F9, $01, $10 ; entry 0
    db $F0, $00, $01, $30 ; entry 1
    db $F8, $F9, $04, $10 ; entry 2
    db $F8, $01, $05, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set25Frame2::
Data_027_5130:: ; address name
    db $F0, $F8, $06, $10 ; entry 0
    db $F0, $00, $07, $10 ; entry 1
    db $F8, $F8, $08, $10 ; entry 2
    db $F8, $00, $09, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set25Frame3::
Data_027_5141:: ; address name
    db $F0, $00, $07, $10 ; entry 0
    db $F0, $F8, $0A, $10 ; entry 1
    db $F8, $F8, $0B, $10 ; entry 2
    db $F8, $00, $0C, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set25Frame4::
Data_027_5152:: ; address name
    db $F0, $F8, $0D, $10 ; entry 0
    db $F0, $FF, $0D, $30 ; entry 1
    db $F8, $F8, $0E, $10 ; entry 2
    db $F8, $00, $0F, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set25Frame5::
Data_027_5163:: ; address name
    db $F8, $00, $0E, $30 ; entry 0
    db $F8, $F8, $0F, $30 ; entry 1
    db $F0, $F9, $0D, $10 ; entry 2
    db $F0, $00, $0D, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 38 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set26::
Data_027_5174:: ; address name
    dw MetaSprites27Set26Frame0 ; entry 0
    dw MetaSprites27Set26Frame1 ; entry 1
    dw MetaSprites27Set26Frame2 ; entry 2
    dw MetaSprites27Set26Frame3 ; entry 3
    dw MetaSprites27Set26Frame4 ; entry 4
    dw MetaSprites27Set26Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set26Frame0::
Data_027_5180:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set26Frame1::
Data_027_5191:: ; address name
    db $F1, $F8, $02, $00 ; entry 0
    db $F1, $00, $02, $20 ; entry 1
    db $F9, $F8, $03, $00 ; entry 2
    db $F9, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set26Frame2::
Data_027_51A2:: ; address name
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set26Frame3::
Data_027_51B3:: ; address name
    db $EF, $F9, $04, $00 ; entry 0
    db $EF, $01, $05, $00 ; entry 1
    db $F7, $F9, $06, $00 ; entry 2
    db $F7, $01, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set26Frame4::
Data_027_51C4:: ; address name
    db $F2, $F8, $0C, $00 ; entry 0
    db $F2, $00, $0C, $20 ; entry 1
    db $FA, $F8, $0D, $00 ; entry 2
    db $FA, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set26Frame5::
Data_027_51D5:: ; address name
    db $EF, $F8, $0E, $00 ; entry 0
    db $EF, $00, $0E, $20 ; entry 1
    db $F7, $F8, $0F, $00 ; entry 2
    db $F7, $00, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 39 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set27::
Data_027_51E6:: ; address name
    dw MetaSprites27Set27Frame0 ; entry 0
    dw MetaSprites27Set27Frame1 ; entry 1
    dw MetaSprites27Set27Frame2 ; entry 2
    dw MetaSprites27Set27Frame3 ; entry 3
    dw MetaSprites27Set27Frame4 ; entry 4
    dw MetaSprites27Set27Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set27Frame0::
Data_027_51F2:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $00, $20 ; entry 1
    db $F9, $F8, $01, $00 ; entry 2
    db $F9, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set27Frame1::
Data_027_5203:: ; address name
    db $F0, $F8, $02, $00 ; entry 0
    db $F0, $00, $02, $20 ; entry 1
    db $F8, $F8, $03, $00 ; entry 2
    db $F8, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set27Frame2::
Data_027_5214:: ; address name
    db $F1, $F8, $04, $00 ; entry 0
    db $F1, $00, $05, $00 ; entry 1
    db $F9, $F8, $06, $00 ; entry 2
    db $F9, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set27Frame3::
Data_027_5225:: ; address name
    db $F8, $F8, $0A, $00 ; entry 0
    db $F8, $00, $0B, $00 ; entry 1
    db $F0, $F8, $08, $00 ; entry 2
    db $F0, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set27Frame4::
Data_027_5236:: ; address name
    db $F1, $F8, $0C, $00 ; entry 0
    db $F1, $00, $0C, $20 ; entry 1
    db $F9, $F8, $0D, $00 ; entry 2
    db $F9, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set27Frame5::
Data_027_5247:: ; address name
    db $F0, $F8, $0E, $00 ; entry 0
    db $F0, $00, $0E, $20 ; entry 1
    db $F8, $F8, $0F, $00 ; entry 2
    db $F8, $00, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 40 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set28::
Data_027_5258:: ; address name
    dw MetaSprites27Set28Frame0 ; entry 0
    dw MetaSprites27Set28Frame1 ; entry 1
    dw MetaSprites27Set28Frame2 ; entry 2
    dw MetaSprites27Set28Frame3 ; entry 3
    dw MetaSprites27Set28Frame4 ; entry 4
    dw MetaSprites27Set28Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set28; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set28Frame0::
Data_027_5264:: ; address name
    db $F0, $F7, $00, $10 ; entry 0
    db $F0, $FF, $01, $10 ; entry 1
    db $F8, $F7, $03, $10 ; entry 2
    db $F8, $FF, $04, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set28; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set28Frame1::
Data_027_5275:: ; address name
    db $F0, $FF, $01, $10 ; entry 0
    db $F0, $F7, $02, $10 ; entry 1
    db $F8, $F7, $05, $10 ; entry 2
    db $F8, $FF, $06, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set28; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set28Frame2::
Data_027_5286:: ; address name
    db $F0, $F9, $07, $10 ; entry 0
    db $F0, $01, $08, $10 ; entry 1
    db $F8, $F9, $09, $10 ; entry 2
    db $F8, $01, $0A, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set28; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set28Frame3::
Data_027_5297:: ; address name
    db $F0, $F9, $07, $10 ; entry 0
    db $F0, $01, $08, $10 ; entry 1
    db $F8, $F9, $0B, $10 ; entry 2
    db $F8, $01, $0C, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set28; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set28Frame4::
Data_027_52A8:: ; address name
    db $F0, $FA, $0D, $10 ; entry 0
    db $F0, $02, $0E, $10 ; entry 1
    db $F8, $02, $05, $30 ; entry 2
    db $F8, $FA, $06, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set28; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set28Frame5::
Data_027_52B9:: ; address name
    db $F0, $FA, $0D, $10 ; entry 0
    db $F0, $02, $0F, $10 ; entry 1
    db $F8, $02, $03, $30 ; entry 2
    db $F8, $FA, $04, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 41 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set29::
Data_027_52CA:: ; address name
    dw MetaSprites27Set29Frame0 ; entry 0
    dw MetaSprites27Set29Frame1 ; entry 1
    dw MetaSprites27Set29Frame2 ; entry 2
    dw MetaSprites27Set29Frame3 ; entry 3
    dw MetaSprites27Set29Frame4 ; entry 4
    dw MetaSprites27Set29Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set29Frame0::
Data_027_52D6:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $F8, $02, $00 ; entry 2
    db $F9, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set29Frame1::
Data_027_52E7:: ; address name
    db $F8, $00, $02, $20 ; entry 0
    db $F8, $F8, $03, $20 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set29Frame2::
Data_027_52F8:: ; address name
    db $F1, $F8, $06, $00 ; entry 0
    db $F1, $00, $07, $00 ; entry 1
    db $F9, $F8, $08, $00 ; entry 2
    db $F9, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set29Frame3::
Data_027_5309:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set29Frame4::
Data_027_531A:: ; address name
    db $F0, $F8, $0E, $00 ; entry 0
    db $F0, $00, $0F, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set29Frame5::
Data_027_532B:: ; address name
    db $F1, $00, $0E, $20 ; entry 0
    db $F1, $F8, $0F, $20 ; entry 1
    db $F9, $00, $02, $20 ; entry 2
    db $F9, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 42 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set2A::
Data_027_533C:: ; address name
    dw MetaSprites27Set2AFrame0 ; entry 0
    dw MetaSprites27Set2AFrame1 ; entry 1
    dw MetaSprites27Set2AFrame2 ; entry 2
    dw MetaSprites27Set2AFrame3 ; entry 3
    dw MetaSprites27Set2AFrame4 ; entry 4
    dw MetaSprites27Set2AFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2AFrame0::
Data_027_5348:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2AFrame1::
Data_027_5359:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $F8, $02, $00 ; entry 2
    db $F9, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2AFrame2::
Data_027_536A:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2AFrame3::
Data_027_537B:: ; address name
    db $F1, $F8, $04, $00 ; entry 0
    db $F1, $00, $05, $00 ; entry 1
    db $F9, $F8, $06, $00 ; entry 2
    db $F9, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2AFrame4::
Data_027_538C:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2AFrame5::
Data_027_539D:: ; address name
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 43 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set2B::
Data_027_53AE:: ; address name
    dw MetaSprites27Set2BFrame0 ; entry 0
    dw MetaSprites27Set2BFrame1 ; entry 1
    dw MetaSprites27Set2BFrame2 ; entry 2
    dw MetaSprites27Set2BFrame3 ; entry 3
    dw MetaSprites27Set2BFrame4 ; entry 4
    dw MetaSprites27Set2BFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set2B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2BFrame0::
Data_027_53BA:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $00, $30 ; entry 1
    db $F8, $F8, $01, $10 ; entry 2
    db $F8, $00, $01, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set2B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2BFrame1::
Data_027_53CB:: ; address name
    db $F1, $F8, $02, $10 ; entry 0
    db $F1, $00, $02, $30 ; entry 1
    db $F9, $F8, $03, $10 ; entry 2
    db $F9, $00, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set2B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2BFrame2::
Data_027_53DC:: ; address name
    db $EF, $F8, $04, $10 ; entry 0
    db $EF, $00, $05, $10 ; entry 1
    db $F7, $F8, $06, $10 ; entry 2
    db $F7, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set2B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2BFrame3::
Data_027_53ED:: ; address name
    db $F0, $00, $04, $30 ; entry 0
    db $F0, $F8, $05, $30 ; entry 1
    db $F8, $00, $06, $30 ; entry 2
    db $F8, $F8, $07, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set2B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2BFrame4::
Data_027_53FE:: ; address name
    db $F0, $F8, $08, $10 ; entry 0
    db $F0, $00, $08, $30 ; entry 1
    db $F8, $F8, $09, $10 ; entry 2
    db $F8, $00, $09, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set2B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2BFrame5::
Data_027_540F:: ; address name
    db $F1, $F8, $0A, $10 ; entry 0
    db $F1, $00, $0A, $30 ; entry 1
    db $F9, $F8, $0B, $10 ; entry 2
    db $F9, $00, $0B, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 44 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set2C::
Data_027_5420:: ; address name
    dw MetaSprites27Set2CFrame0 ; entry 0
    dw MetaSprites27Set2CFrame1 ; entry 1
    dw MetaSprites27Set2CFrame2 ; entry 2
    dw MetaSprites27Set2CFrame3 ; entry 3
    dw MetaSprites27Set2CFrame4 ; entry 4
    dw MetaSprites27Set2CFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set2C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2CFrame0::
Data_027_542C:: ; address name
    db $F1, $F8, $00, $10 ; entry 0
    db $F1, $00, $01, $10 ; entry 1
    db $F9, $F8, $02, $10 ; entry 2
    db $F9, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set2C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2CFrame1::
Data_027_543D:: ; address name
    db $F0, $00, $00, $30 ; entry 0
    db $F0, $F8, $01, $30 ; entry 1
    db $F8, $00, $02, $30 ; entry 2
    db $F8, $F8, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set2C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2CFrame2::
Data_027_544E:: ; address name
    db $F1, $F8, $04, $10 ; entry 0
    db $F1, $00, $05, $10 ; entry 1
    db $F9, $F8, $06, $10 ; entry 2
    db $F9, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set2C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2CFrame3::
Data_027_545F:: ; address name
    db $F0, $F8, $08, $10 ; entry 0
    db $F0, $00, $09, $10 ; entry 1
    db $F8, $F8, $0A, $10 ; entry 2
    db $F8, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set2C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2CFrame4::
Data_027_5470:: ; address name
    db $F1, $F8, $0C, $10 ; entry 0
    db $F1, $00, $0D, $10 ; entry 1
    db $F9, $F8, $0E, $10 ; entry 2
    db $F9, $00, $0F, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set2C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2CFrame5::
Data_027_5481:: ; address name
    db $F8, $00, $0E, $30 ; entry 0
    db $F8, $F8, $0F, $30 ; entry 1
    db $F0, $00, $0C, $30 ; entry 2
    db $F0, $F8, $0D, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 45 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set2D::
Data_027_5492:: ; address name
    dw MetaSprites27Set2DFrame0 ; entry 0
    dw MetaSprites27Set2DFrame1 ; entry 1
    dw MetaSprites27Set2DFrame2 ; entry 2
    dw MetaSprites27Set2DFrame3 ; entry 3
    dw MetaSprites27Set2DFrame4 ; entry 4
    dw MetaSprites27Set2DFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set2D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2DFrame0::
Data_027_549E:: ; address name
    db $F2, $00, $01, $10 ; entry 0
    db $FA, $00, $02, $10 ; entry 1
    db $F5, $F8, $00, $10 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set2D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2DFrame1::
Data_027_54AB:: ; address name
    db $F0, $F8, $03, $10 ; entry 0
    db $F8, $F8, $04, $10 ; entry 1
    db $F9, $00, $05, $10 ; entry 2
    db $F1, $00, $01, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set2D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2DFrame2::
Data_027_54BC:: ; address name
    db $F8, $F8, $06, $10 ; entry 0
    db $F8, $00, $07, $10 ; entry 1
    db $F0, $F9, $08, $10 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set2D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2DFrame3::
Data_027_54C9:: ; address name
    db $F8, $F8, $0B, $10 ; entry 0
    db $F8, $00, $0C, $10 ; entry 1
    db $F0, $F8, $09, $10 ; entry 2
    db $F0, $00, $0A, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set2D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2DFrame4::
Data_027_54DA:: ; address name
    db $F0, $00, $03, $30 ; entry 0
    db $F0, $F8, $0D, $10 ; entry 1
    db $F8, $F8, $0E, $10 ; entry 2
    db $F8, $00, $0F, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set2D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2DFrame5::
Data_027_54EB:: ; address name
    db $F0, $F8, $03, $10 ; entry 0
    db $F0, $00, $0D, $30 ; entry 1
    db $F8, $00, $0E, $30 ; entry 2
    db $F8, $F8, $0F, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 46 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set2E::
Data_027_54FC:: ; address name
    dw MetaSprites27Set2EFrame0 ; entry 0
    dw MetaSprites27Set2EFrame1 ; entry 1
    dw MetaSprites27Set2EFrame2 ; entry 2
    dw MetaSprites27Set2EFrame3 ; entry 3
    dw MetaSprites27Set2EFrame4 ; entry 4
    dw MetaSprites27Set2EFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2EFrame0::
Data_027_5508:: ; address name
    db $F2, $00, $01, $10 ; entry 0
    db $FA, $00, $02, $10 ; entry 1
    db $F5, $F8, $00, $10 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2EFrame1::
Data_027_5515:: ; address name
    db $F0, $F8, $03, $10 ; entry 0
    db $F8, $F8, $04, $10 ; entry 1
    db $F9, $00, $05, $10 ; entry 2
    db $F1, $00, $01, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2EFrame2::
Data_027_5526:: ; address name
    db $F8, $F8, $06, $10 ; entry 0
    db $F8, $00, $07, $10 ; entry 1
    db $F0, $F9, $08, $10 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2EFrame3::
Data_027_5533:: ; address name
    db $F8, $F8, $0B, $10 ; entry 0
    db $F8, $00, $0C, $10 ; entry 1
    db $F0, $F8, $09, $10 ; entry 2
    db $F0, $00, $0A, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2EFrame4::
Data_027_5544:: ; address name
    db $F0, $00, $03, $30 ; entry 0
    db $F0, $F8, $0D, $10 ; entry 1
    db $F8, $F8, $0E, $10 ; entry 2
    db $F8, $00, $0F, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2EFrame5::
Data_027_5555:: ; address name
    db $F0, $F8, $03, $10 ; entry 0
    db $F0, $00, $0D, $30 ; entry 1
    db $F8, $00, $0E, $30 ; entry 2
    db $F8, $F8, $0F, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 47 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set2F::
Data_027_5566:: ; address name
    dw MetaSprites27Set2FFrame0 ; entry 0
    dw MetaSprites27Set2FFrame1 ; entry 1
    dw MetaSprites27Set2FFrame2 ; entry 2
    dw MetaSprites27Set2FFrame3 ; entry 3
    dw MetaSprites27Set2FFrame4 ; entry 4
    dw MetaSprites27Set2FFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set2F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2FFrame0::
Data_027_5572:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $00, $30 ; entry 1
    db $F8, $F8, $01, $10 ; entry 2
    db $F8, $00, $01, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set2F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2FFrame1::
Data_027_5583:: ; address name
    db $F0, $F8, $02, $10 ; entry 0
    db $F0, $00, $02, $30 ; entry 1
    db $F8, $F8, $03, $10 ; entry 2
    db $F8, $00, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set2F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2FFrame2::
Data_027_5594:: ; address name
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set2F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2FFrame3::
Data_027_55A5:: ; address name
    db $EF, $F8, $08, $10 ; entry 0
    db $EF, $00, $09, $10 ; entry 1
    db $F7, $00, $0A, $10 ; entry 2
    db $F7, $F8, $06, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set2F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2FFrame4::
Data_027_55B6:: ; address name
    db $F0, $00, $00, $30 ; entry 0
    db $F0, $F8, $0B, $10 ; entry 1
    db $F8, $F8, $0C, $10 ; entry 2
    db $F8, $00, $0C, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set2F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set2FFrame5::
Data_027_55C7:: ; address name
    db $F7, $F8, $0C, $10 ; entry 0
    db $F7, $00, $0C, $30 ; entry 1
    db $EF, $F8, $0D, $10 ; entry 2
    db $EF, $00, $0D, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 48 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set30::
Data_027_55D8:: ; address name
    dw MetaSprites27Set30Frame0 ; entry 0
    dw MetaSprites27Set30Frame1 ; entry 1
    dw MetaSprites27Set30Frame2 ; entry 2
    dw MetaSprites27Set30Frame3 ; entry 3
    dw MetaSprites27Set30Frame4 ; entry 4
    dw MetaSprites27Set30Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set30; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set30Frame0::
Data_027_55E4:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set30; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set30Frame1::
Data_027_55F5:: ; address name
    db $F0, $00, $00, $20 ; entry 0
    db $F0, $F8, $01, $20 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set30; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set30Frame2::
Data_027_5606:: ; address name
    db $EF, $F8, $04, $00 ; entry 0
    db $EF, $00, $05, $00 ; entry 1
    db $F7, $F8, $06, $00 ; entry 2
    db $F7, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set30; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set30Frame3::
Data_027_5617:: ; address name
    db $EF, $F8, $08, $00 ; entry 0
    db $EF, $00, $09, $00 ; entry 1
    db $F7, $F8, $0A, $00 ; entry 2
    db $F7, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set30; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set30Frame4::
Data_027_5628:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set30; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set30Frame5::
Data_027_5639:: ; address name
    db $F0, $00, $0C, $20 ; entry 0
    db $F0, $F8, $0D, $20 ; entry 1
    db $F8, $00, $0E, $20 ; entry 2
    db $F8, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 49 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set31::
Data_027_564A:: ; address name
    dw MetaSprites27Set31Frame0 ; entry 0
    dw MetaSprites27Set31Frame1 ; entry 1
    dw MetaSprites27Set31Frame2 ; entry 2
    dw MetaSprites27Set31Frame3 ; entry 3
    dw MetaSprites27Set31Frame4 ; entry 4
    dw MetaSprites27Set31Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set31Frame0::
Data_027_5656:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $F8, $02, $00 ; entry 2
    db $F9, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set31Frame1::
Data_027_5667:: ; address name
    db $F0, $00, $00, $20 ; entry 0
    db $F0, $F8, $01, $20 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set31Frame2::
Data_027_5678:: ; address name
    db $F1, $F8, $04, $00 ; entry 0
    db $F1, $00, $05, $00 ; entry 1
    db $F9, $F8, $06, $00 ; entry 2
    db $F9, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set31Frame3::
Data_027_5689:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set31Frame4::
Data_027_569A:: ; address name
    db $F1, $F8, $0C, $00 ; entry 0
    db $F1, $00, $0D, $00 ; entry 1
    db $F9, $F8, $0E, $00 ; entry 2
    db $F9, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set31Frame5::
Data_027_56AB:: ; address name
    db $F0, $00, $0C, $20 ; entry 0
    db $F0, $F8, $0D, $20 ; entry 1
    db $F8, $00, $0E, $20 ; entry 2
    db $F8, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 50 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set32::
Data_027_56BC:: ; address name
    dw MetaSprites27Set32Frame0 ; entry 0
    dw MetaSprites27Set32Frame1 ; entry 1
    dw MetaSprites27Set32Frame2 ; entry 2
    dw MetaSprites27Set32Frame3 ; entry 3
    dw MetaSprites27Set32Frame4 ; entry 4
    dw MetaSprites27Set32Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set32; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set32Frame0::
Data_027_56C8:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set32; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set32Frame1::
Data_027_56D9:: ; address name
    db $F0, $01, $00, $30 ; entry 0
    db $F0, $F9, $01, $30 ; entry 1
    db $F8, $01, $02, $30 ; entry 2
    db $F8, $F9, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set32; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set32Frame2::
Data_027_56EA:: ; address name
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set32; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set32Frame3::
Data_027_56FB:: ; address name
    db $F0, $F8, $08, $10 ; entry 0
    db $F0, $00, $09, $10 ; entry 1
    db $F8, $F8, $0A, $10 ; entry 2
    db $F8, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set32; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set32Frame4::
Data_027_570C:: ; address name
    db $F0, $F8, $0C, $10 ; entry 0
    db $F0, $00, $0D, $10 ; entry 1
    db $F8, $F8, $0E, $10 ; entry 2
    db $F8, $00, $0F, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set32; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set32Frame5::
Data_027_571D:: ; address name
    db $F0, $01, $0C, $30 ; entry 0
    db $F0, $F9, $0D, $30 ; entry 1
    db $F8, $01, $0E, $30 ; entry 2
    db $F8, $F9, $0F, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 51 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set33::
Data_027_572E:: ; address name
    dw MetaSprites27Set33Frame0 ; entry 0
    dw MetaSprites27Set33Frame1 ; entry 1
    dw MetaSprites27Set33Frame2 ; entry 2
    dw MetaSprites27Set33Frame3 ; entry 3
    dw MetaSprites27Set33Frame4 ; entry 4
    dw MetaSprites27Set33Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set33; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set33Frame0::
Data_027_573A:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set33; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set33Frame1::
Data_027_574B:: ; address name
    db $F0, $00, $00, $20 ; entry 0
    db $F0, $F8, $01, $20 ; entry 1
    db $F8, $F8, $04, $00 ; entry 2
    db $F8, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set33; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set33Frame2::
Data_027_575C:: ; address name
    db $F0, $F9, $06, $00 ; entry 0
    db $F0, $01, $07, $00 ; entry 1
    db $F8, $F8, $04, $00 ; entry 2
    db $F8, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set33; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set33Frame3::
Data_027_576D:: ; address name
    db $F8, $F8, $02, $00 ; entry 0
    db $F8, $00, $03, $00 ; entry 1
    db $F0, $F7, $08, $00 ; entry 2
    db $F0, $FF, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set33; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set33Frame4::
Data_027_577E:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set33; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set33Frame5::
Data_027_578F:: ; address name
    db $F0, $00, $0A, $20 ; entry 0
    db $F0, $F8, $0B, $20 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 52 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set34::
Data_027_57A0:: ; address name
    dw MetaSprites27Set34Frame0 ; entry 0
    dw MetaSprites27Set34Frame1 ; entry 1
    dw MetaSprites27Set34Frame2 ; entry 2
    dw MetaSprites27Set34Frame3 ; entry 3
    dw MetaSprites27Set34Frame4 ; entry 4
    dw MetaSprites27Set34Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set34Frame0::
Data_027_57AC:: ; address name
    db $F0, $F8, $00, $30 ; entry 0
    db $F0, $FF, $00, $10 ; entry 1
    db $F8, $FA, $01, $10 ; entry 2
    db $F8, $02, $02, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set34Frame1::
Data_027_57BD:: ; address name
    db $F0, $F9, $00, $30 ; entry 0
    db $F0, $00, $00, $10 ; entry 1
    db $F8, $FE, $01, $30 ; entry 2
    db $F8, $F6, $02, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set34Frame2::
Data_027_57CE:: ; address name
    db $F0, $F9, $00, $30 ; entry 0
    db $F0, $FF, $00, $10 ; entry 1
    db $F8, $FA, $05, $10 ; entry 2
    db $F8, $02, $06, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set34Frame3::
Data_027_57DF:: ; address name
    db $F0, $00, $00, $10 ; entry 0
    db $F0, $FA, $00, $30 ; entry 1
    db $F8, $FB, $07, $10 ; entry 2
    db $F8, $03, $08, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set34Frame4::
Data_027_57F0:: ; address name
    db $F0, $F8, $00, $30 ; entry 0
    db $F0, $FF, $00, $10 ; entry 1
    db $F8, $F8, $03, $10 ; entry 2
    db $F8, $00, $04, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set34Frame5::
Data_027_5801:: ; address name
    db $F0, $00, $00, $10 ; entry 0
    db $F0, $F9, $00, $30 ; entry 1
    db $F8, $00, $03, $30 ; entry 2
    db $F8, $F8, $04, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 53 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set35::
Data_027_5812:: ; address name
    dw MetaSprites27Set35Frame0 ; entry 0
    dw MetaSprites27Set35Frame1 ; entry 1
    dw MetaSprites27Set35Frame2 ; entry 2
    dw MetaSprites27Set35Frame3 ; entry 3
    dw MetaSprites27Set35Frame4 ; entry 4
    dw MetaSprites27Set35Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set35Frame0::
Data_027_581E:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set35Frame1::
Data_027_582F:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $04, $00 ; entry 2
    db $F8, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set35Frame2::
Data_027_5840:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set35Frame3::
Data_027_5851:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set35Frame4::
Data_027_5862:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set35Frame5::
Data_027_5873:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $FF, $0E, $20 ; entry 2
    db $F8, $F7, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 54 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set36::
Data_027_5884:: ; address name
    dw MetaSprites27Set36Frame0 ; entry 0
    dw MetaSprites27Set36Frame1 ; entry 1
    dw MetaSprites27Set36Frame2 ; entry 2
    dw MetaSprites27Set36Frame3 ; entry 3
    dw MetaSprites27Set36Frame4 ; entry 4
    dw MetaSprites27Set36Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set36Frame0::
Data_027_5890:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $00, $30 ; entry 1
    db $F8, $F8, $01, $10 ; entry 2
    db $F8, $00, $01, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set36Frame1::
Data_027_58A1:: ; address name
    db $F7, $F8, $00, $50 ; entry 0
    db $F7, $00, $00, $70 ; entry 1
    db $EF, $F8, $01, $50 ; entry 2
    db $EF, $00, $01, $70 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set36Frame2::
Data_027_58B2:: ; address name
    db $F0, $F8, $02, $10 ; entry 0
    db $F0, $00, $03, $10 ; entry 1
    db $F8, $F8, $04, $10 ; entry 2
    db $F8, $00, $05, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set36Frame3::
Data_027_58C3:: ; address name
    db $F7, $F8, $02, $50 ; entry 0
    db $F7, $00, $03, $50 ; entry 1
    db $EF, $F8, $04, $50 ; entry 2
    db $EF, $00, $05, $50 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set36Frame4::
Data_027_58D4:: ; address name
    db $F0, $F8, $06, $10 ; entry 0
    db $F0, $00, $06, $30 ; entry 1
    db $F8, $F8, $07, $10 ; entry 2
    db $F8, $00, $07, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set36Frame5::
Data_027_58E5:: ; address name
    db $F7, $F8, $06, $50 ; entry 0
    db $F7, $00, $06, $70 ; entry 1
    db $EF, $F8, $07, $50 ; entry 2
    db $EF, $00, $07, $70 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 55 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set37::
Data_027_58F6:: ; address name
    dw MetaSprites27Set37Frame0 ; entry 0
    dw MetaSprites27Set37Frame1 ; entry 1
    dw MetaSprites27Set37Frame2 ; entry 2
    dw MetaSprites27Set37Frame3 ; entry 3
    dw MetaSprites27Set37Frame4 ; entry 4
    dw MetaSprites27Set37Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set37Frame0::
Data_027_5902:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set37Frame1::
Data_027_5913:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $01, $02, $20 ; entry 2
    db $F9, $F9, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set37Frame2::
Data_027_5924:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set37Frame3::
Data_027_5935:: ; address name
    db $F9, $F8, $08, $00 ; entry 0
    db $F9, $00, $09, $00 ; entry 1
    db $F1, $F8, $04, $00 ; entry 2
    db $F1, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set37Frame4::
Data_027_5946:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set37Frame5::
Data_027_5957:: ; address name
    db $F1, $F8, $0A, $00 ; entry 0
    db $F1, $00, $0B, $00 ; entry 1
    db $F9, $FF, $0C, $20 ; entry 2
    db $F9, $F7, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 56 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set38::
Data_027_5968:: ; address name
    dw MetaSprites27Set38Frame0 ; entry 0
    dw MetaSprites27Set38Frame1 ; entry 1
    dw MetaSprites27Set38Frame2 ; entry 2
    dw MetaSprites27Set38Frame3 ; entry 3
    dw MetaSprites27Set38Frame4 ; entry 4
    dw MetaSprites27Set38Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set38Frame0::
Data_027_5974:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set38Frame1::
Data_027_5985:: ; address name
    db $F1, $FF, $00, $20 ; entry 0
    db $F1, $F7, $01, $20 ; entry 1
    db $F9, $FF, $02, $20 ; entry 2
    db $F9, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set38Frame2::
Data_027_5996:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set38Frame3::
Data_027_59A7:: ; address name
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set38Frame4::
Data_027_59B8:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set38Frame5::
Data_027_59C9:: ; address name
    db $F1, $FF, $0C, $20 ; entry 0
    db $F1, $F7, $0D, $20 ; entry 1
    db $F9, $FF, $0E, $20 ; entry 2
    db $F9, $F7, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 57 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set39::
Data_027_59DA:: ; address name
    dw MetaSprites27Set39Frame0 ; entry 0
    dw MetaSprites27Set39Frame1 ; entry 1
    dw MetaSprites27Set39Frame2 ; entry 2
    dw MetaSprites27Set39Frame3 ; entry 3
    dw MetaSprites27Set39Frame4 ; entry 4
    dw MetaSprites27Set39Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set39Frame0::
Data_027_59E6:: ; address name
    db $F7, $F8, $00, $00 ; entry 0
    db $F7, $00, $00, $20 ; entry 1
    db $EF, $F8, $02, $00 ; entry 2
    db $EF, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set39Frame1::
Data_027_59F7:: ; address name
    db $F9, $F8, $01, $00 ; entry 0
    db $F9, $00, $01, $20 ; entry 1
    db $F1, $F8, $02, $00 ; entry 2
    db $F1, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set39Frame2::
Data_027_5A08:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set39Frame3::
Data_027_5A19:: ; address name
    db $F2, $F8, $04, $00 ; entry 0
    db $F2, $00, $05, $00 ; entry 1
    db $FA, $F8, $08, $00 ; entry 2
    db $FA, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set39Frame4::
Data_027_5A2A:: ; address name
    db $EF, $F8, $0A, $00 ; entry 0
    db $EF, $00, $0A, $20 ; entry 1
    db $F7, $F8, $0C, $00 ; entry 2
    db $F7, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set39Frame5::
Data_027_5A3B:: ; address name
    db $F1, $F8, $0B, $00 ; entry 0
    db $F1, $00, $0B, $20 ; entry 1
    db $F9, $F8, $0E, $00 ; entry 2
    db $F9, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 61 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set3D::
Data_027_5A4C:: ; address name
    dw MetaSprites27Set3DFrame0 ; entry 0
    dw MetaSprites27Set3DFrame1 ; entry 1
    dw MetaSprites27Set3DFrame2 ; entry 2
    dw MetaSprites27Set3DFrame3 ; entry 3
    dw MetaSprites27Set3DFrame4 ; entry 4
    dw MetaSprites27Set3DFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set3D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set3DFrame0::
Data_027_5A58:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set3D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set3DFrame1::
Data_027_5A69:: ; address name
    db $F1, $00, $01, $00 ; entry 0
    db $F9, $00, $03, $00 ; entry 1
    db $F1, $F8, $04, $00 ; entry 2
    db $F9, $F8, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set3D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set3DFrame2::
Data_027_5A7A:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set3D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set3DFrame3::
Data_027_5A8B:: ; address name
    db $F1, $F8, $06, $00 ; entry 0
    db $F1, $00, $07, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set3D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set3DFrame4::
Data_027_5A9C:: ; address name
    db $F0, $00, $00, $20 ; entry 0
    db $F0, $F8, $01, $20 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set3D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set3DFrame5::
Data_027_5AAD:: ; address name
    db $F1, $00, $00, $20 ; entry 0
    db $F1, $F8, $01, $20 ; entry 1
    db $F9, $F8, $0E, $00 ; entry 2
    db $F9, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 62 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set3E::
Data_027_5ABE:: ; address name
    dw MetaSprites27Set3EFrame0 ; entry 0
    dw MetaSprites27Set3EFrame1 ; entry 1
    dw MetaSprites27Set3EFrame2 ; entry 2
    dw MetaSprites27Set3EFrame3 ; entry 3
    dw MetaSprites27Set3EFrame4 ; entry 4
    dw MetaSprites27Set3EFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set3E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set3EFrame0::
Data_027_5ACA:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set3E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set3EFrame1::
Data_027_5ADB:: ; address name
    db $F1, $00, $00, $20 ; entry 0
    db $F1, $F8, $01, $20 ; entry 1
    db $F9, $00, $02, $20 ; entry 2
    db $F9, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set3E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set3EFrame2::
Data_027_5AEC:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set3E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set3EFrame3::
Data_027_5AFD:: ; address name
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set3E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set3EFrame4::
Data_027_5B0E:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set3E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set3EFrame5::
Data_027_5B1F:: ; address name
    db $F1, $00, $0C, $20 ; entry 0
    db $F1, $F8, $0D, $20 ; entry 1
    db $F9, $00, $0E, $20 ; entry 2
    db $F9, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 63 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set3F::
Data_027_5B30:: ; address name
    dw MetaSprites27Set3FFrame0 ; entry 0
    dw MetaSprites27Set3FFrame1 ; entry 1
    dw MetaSprites27Set3FFrame2 ; entry 2
    dw MetaSprites27Set3FFrame3 ; entry 3
    dw MetaSprites27Set3FFrame4 ; entry 4
    dw MetaSprites27Set3FFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set3F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set3FFrame0::
Data_027_5B3C:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set3F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set3FFrame1::
Data_027_5B4D:: ; address name
    db $EF, $F8, $00, $00 ; entry 0
    db $EF, $00, $00, $20 ; entry 1
    db $F7, $F8, $03, $00 ; entry 2
    db $F7, $00, $04, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set3F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set3FFrame2::
Data_027_5B5E:: ; address name
    db $F0, $F9, $05, $00 ; entry 0
    db $F0, $01, $06, $00 ; entry 1
    db $F8, $F9, $07, $00 ; entry 2
    db $F8, $01, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set3F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set3FFrame3::
Data_027_5B6F:: ; address name
    db $EF, $01, $06, $00 ; entry 0
    db $F7, $01, $08, $00 ; entry 1
    db $EF, $F9, $09, $00 ; entry 2
    db $F7, $F9, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set3F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set3FFrame4::
Data_027_5B80:: ; address name
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $00, $0B, $20 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set3F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set3FFrame5::
Data_027_5B91:: ; address name
    db $EF, $F8, $0B, $00 ; entry 0
    db $EF, $00, $0B, $20 ; entry 1
    db $F7, $F8, $0E, $00 ; entry 2
    db $F7, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 64 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set40::
Data_027_5BA2:: ; address name
    dw MetaSprites27Set40Frame0 ; entry 0
    dw MetaSprites27Set40Frame1 ; entry 1
    dw MetaSprites27Set40Frame2 ; entry 2
    dw MetaSprites27Set40Frame3 ; entry 3
    dw MetaSprites27Set40Frame4 ; entry 4
    dw MetaSprites27Set40Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set40; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set40Frame0::
Data_027_5BAE:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $FF, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set40; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set40Frame1::
Data_027_5BBF:: ; address name
    db $F1, $F8, $02, $00 ; entry 0
    db $F1, $FF, $02, $20 ; entry 1
    db $F9, $F8, $03, $00 ; entry 2
    db $F9, $FF, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set40; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set40Frame2::
Data_027_5BD0:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set40; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set40Frame3::
Data_027_5BE1:: ; address name
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set40; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set40Frame4::
Data_027_5BF2:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $FF, $0C, $20 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $FF, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set40; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set40Frame5::
Data_027_5C03:: ; address name
    db $F1, $F8, $0E, $00 ; entry 0
    db $F1, $FF, $0E, $20 ; entry 1
    db $F9, $F8, $0F, $00 ; entry 2
    db $F9, $FF, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 65 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set41::
Data_027_5C14:: ; address name
    dw MetaSprites27Set41Frame0 ; entry 0
    dw MetaSprites27Set41Frame1 ; entry 1
    dw MetaSprites27Set41Frame2 ; entry 2
    dw MetaSprites27Set41Frame3 ; entry 3
    dw MetaSprites27Set41Frame4 ; entry 4
    dw MetaSprites27Set41Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set41; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set41Frame0::
Data_027_5C20:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $F8, $02, $00 ; entry 2
    db $F9, $FF, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set41; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set41Frame1::
Data_027_5C31:: ; address name
    db $F0, $F8, $03, $00 ; entry 0
    db $F0, $00, $04, $00 ; entry 1
    db $F8, $F8, $05, $00 ; entry 2
    db $F8, $FF, $05, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set41; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set41Frame2::
Data_027_5C42:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set41; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set41Frame3::
Data_027_5C53:: ; address name
    db $F0, $F8, $03, $00 ; entry 0
    db $F0, $00, $04, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set41; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set41Frame4::
Data_027_5C64:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $FF, $0A, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set41; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set41Frame5::
Data_027_5C75:: ; address name
    db $EF, $F8, $03, $00 ; entry 0
    db $EF, $00, $04, $00 ; entry 1
    db $F7, $F8, $0B, $00 ; entry 2
    db $F7, $FF, $0B, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 66 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set42::
Data_027_5C86:: ; address name
    dw MetaSprites27Set42Frame0 ; entry 0
    dw MetaSprites27Set42Frame1 ; entry 1
    dw MetaSprites27Set42Frame2 ; entry 2
    dw MetaSprites27Set42Frame3 ; entry 3
    dw MetaSprites27Set42Frame4 ; entry 4
    dw MetaSprites27Set42Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set42; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set42Frame0::
Data_027_5C92:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set42; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set42Frame1::
Data_027_5CA3:: ; address name
    db $F1, $FF, $00, $20 ; entry 0
    db $F1, $F7, $01, $20 ; entry 1
    db $F9, $FF, $02, $20 ; entry 2
    db $F9, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set42; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set42Frame2::
Data_027_5CB4:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set42; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set42Frame3::
Data_027_5CC5:: ; address name
    db $F2, $F8, $08, $00 ; entry 0
    db $F2, $00, $09, $00 ; entry 1
    db $FA, $F8, $0A, $00 ; entry 2
    db $FA, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set42; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set42Frame4::
Data_027_5CD6:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set42; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set42Frame5::
Data_027_5CE7:: ; address name
    db $F1, $01, $0C, $20 ; entry 0
    db $F1, $F9, $0D, $20 ; entry 1
    db $F9, $01, $0E, $20 ; entry 2
    db $F9, $F9, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 67 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set43::
Data_027_5CF8:: ; address name
    dw MetaSprites27Set43Frame0 ; entry 0
    dw MetaSprites27Set43Frame1 ; entry 1
    dw MetaSprites27Set43Frame2 ; entry 2
    dw MetaSprites27Set43Frame3 ; entry 3
    dw MetaSprites27Set43Frame4 ; entry 4
    dw MetaSprites27Set43Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set43; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set43Frame0::
Data_027_5D04:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set43; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set43Frame1::
Data_027_5D15:: ; address name
    db $F9, $F8, $02, $00 ; entry 0
    db $F9, $00, $03, $00 ; entry 1
    db $F1, $F8, $00, $00 ; entry 2
    db $F1, $00, $01, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set43; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set43Frame2::
Data_027_5D26:: ; address name
    db $F8, $F8, $02, $00 ; entry 0
    db $F8, $00, $03, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set43; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set43Frame3::
Data_027_5D37:: ; address name
    db $F9, $F8, $02, $00 ; entry 0
    db $F9, $00, $03, $00 ; entry 1
    db $F1, $F8, $04, $00 ; entry 2
    db $F1, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set43; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set43Frame4::
Data_027_5D48:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set43; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set43Frame5::
Data_027_5D59:: ; address name
    db $F1, $F8, $06, $00 ; entry 0
    db $F1, $00, $07, $00 ; entry 1
    db $F9, $F8, $08, $00 ; entry 2
    db $F9, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 68 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set44::
Data_027_5D6A:: ; address name
    dw MetaSprites27Set44Frame0 ; entry 0
    dw MetaSprites27Set44Frame1 ; entry 1
    dw MetaSprites27Set44Frame2 ; entry 2
    dw MetaSprites27Set44Frame3 ; entry 3
    dw MetaSprites27Set44Frame4 ; entry 4
    dw MetaSprites27Set44Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set44; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set44Frame0::
Data_027_5D76:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set44; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set44Frame1::
Data_027_5D87:: ; address name
    db $F1, $00, $00, $20 ; entry 0
    db $F1, $F8, $01, $20 ; entry 1
    db $F9, $00, $02, $20 ; entry 2
    db $F9, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set44; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set44Frame2::
Data_027_5D98:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set44; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set44Frame3::
Data_027_5DA9:: ; address name
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set44; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set44Frame4::
Data_027_5DBA:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set44; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set44Frame5::
Data_027_5DCB:: ; address name
    db $F1, $00, $0C, $20 ; entry 0
    db $F1, $F8, $0D, $20 ; entry 1
    db $F9, $00, $0E, $20 ; entry 2
    db $F9, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 69 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set45::
Data_027_5DDC:: ; address name
    dw MetaSprites27Set45Frame0 ; entry 0
    dw MetaSprites27Set45Frame1 ; entry 1
    dw MetaSprites27Set45Frame2 ; entry 2
    dw MetaSprites27Set45Frame3 ; entry 3
    dw MetaSprites27Set45Frame4 ; entry 4
    dw MetaSprites27Set45Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set45; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set45Frame0::
Data_027_5DE8:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $F8, $02, $00 ; entry 2
    db $F9, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set45; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set45Frame1::
Data_027_5DF9:: ; address name
    db $F1, $01, $00, $20 ; entry 0
    db $F1, $F9, $01, $20 ; entry 1
    db $F9, $01, $02, $20 ; entry 2
    db $F9, $F9, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set45; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set45Frame2::
Data_027_5E0A:: ; address name
    db $F1, $F8, $04, $00 ; entry 0
    db $F1, $00, $05, $00 ; entry 1
    db $F9, $F8, $06, $00 ; entry 2
    db $F9, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set45; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set45Frame3::
Data_027_5E1B:: ; address name
    db $F1, $F9, $04, $00 ; entry 0
    db $F1, $01, $05, $00 ; entry 1
    db $F9, $01, $02, $20 ; entry 2
    db $F9, $F9, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set45; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set45Frame4::
Data_027_5E2C:: ; address name
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $02, $00 ; entry 2
    db $F9, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set45; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set45Frame5::
Data_027_5E3D:: ; address name
    db $F1, $01, $08, $20 ; entry 0
    db $F1, $F9, $09, $20 ; entry 1
    db $F9, $01, $02, $20 ; entry 2
    db $F9, $F9, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 70 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set46::
Data_027_5E4E:: ; address name
    dw MetaSprites27Set46Frame0 ; entry 0
    dw MetaSprites27Set46Frame1 ; entry 1
    dw MetaSprites27Set46Frame2 ; entry 2
    dw MetaSprites27Set46Frame3 ; entry 3
    dw MetaSprites27Set46Frame4 ; entry 4
    dw MetaSprites27Set46Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set46; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set46Frame0::
Data_027_5E5A:: ; address name
    db $F7, $F8, $01, $00 ; entry 0
    db $F7, $00, $01, $20 ; entry 1
    db $EF, $FC, $00, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set46; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set46Frame1::
Data_027_5E67:: ; address name
    db $F8, $F8, $03, $00 ; entry 0
    db $F8, $00, $03, $20 ; entry 1
    db $F0, $FC, $02, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set46; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set46Frame2::
Data_027_5E74:: ; address name
    db $EF, $F8, $04, $00 ; entry 0
    db $EF, $00, $05, $00 ; entry 1
    db $F7, $F8, $06, $00 ; entry 2
    db $F7, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set46; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set46Frame3::
Data_027_5E85:: ; address name
    db $F0, $00, $08, $00 ; entry 0
    db $F8, $F8, $09, $00 ; entry 1
    db $F8, $00, $0A, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set46; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set46Frame4::
Data_027_5E92:: ; address name
    db $F7, $F8, $0B, $00 ; entry 0
    db $F7, $00, $0C, $00 ; entry 1
    db $EF, $FC, $00, $20 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set46; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set46Frame5::
Data_027_5E9F:: ; address name
    db $F8, $F8, $0D, $00 ; entry 0
    db $F8, $00, $0E, $00 ; entry 1
    db $F0, $FC, $02, $20 ; entry 2
    db $80 ; end

; E-0147 (derived: meta-sprite set 71 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set47::
Data_027_5EAC:: ; address name
    dw MetaSprites27Set47Frame0 ; entry 0
    dw MetaSprites27Set47Frame1 ; entry 1
    dw MetaSprites27Set47Frame2 ; entry 2
    dw MetaSprites27Set47Frame3 ; entry 3
    dw MetaSprites27Set47Frame4 ; entry 4
    dw MetaSprites27Set47Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set47; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set47Frame0::
Data_027_5EB8:: ; address name
    db $F9, $F8, $02, $00 ; entry 0
    db $F9, $00, $03, $00 ; entry 1
    db $F1, $F8, $00, $00 ; entry 2
    db $F1, $00, $01, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set47; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set47Frame1::
Data_027_5EC9:: ; address name
    db $F8, $F7, $04, $00 ; entry 0
    db $F8, $FF, $05, $00 ; entry 1
    db $F0, $F8, $00, $00 ; entry 2
    db $F0, $00, $01, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set47; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set47Frame2::
Data_027_5EDA:: ; address name
    db $F8, $F9, $08, $00 ; entry 0
    db $F8, $01, $09, $00 ; entry 1
    db $F0, $F9, $06, $00 ; entry 2
    db $F0, $01, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set47; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set47Frame3::
Data_027_5EEB:: ; address name
    db $F7, $F8, $0A, $00 ; entry 0
    db $F7, $00, $0B, $00 ; entry 1
    db $EF, $F8, $06, $00 ; entry 2
    db $EF, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set47; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set47Frame4::
Data_027_5EFC:: ; address name
    db $F8, $F8, $0E, $00 ; entry 0
    db $F8, $00, $0F, $00 ; entry 1
    db $F0, $F8, $0C, $00 ; entry 2
    db $F0, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set47; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set47Frame5::
Data_027_5F0D:: ; address name
    db $F7, $01, $0E, $20 ; entry 0
    db $F7, $F9, $0F, $20 ; entry 1
    db $EF, $01, $0C, $20 ; entry 2
    db $EF, $F9, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 72 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set48::
Data_027_5F1E:: ; address name
    dw MetaSprites27Set48Frame0 ; entry 0
    dw MetaSprites27Set48Frame1 ; entry 1
    dw MetaSprites27Set48Frame2 ; entry 2
    dw MetaSprites27Set48Frame3 ; entry 3
    dw MetaSprites27Set48Frame4 ; entry 4
    dw MetaSprites27Set48Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set48; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set48Frame0::
Data_027_5F2A:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set48; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set48Frame1::
Data_027_5F3B:: ; address name
    db $F9, $00, $02, $20 ; entry 0
    db $F9, $F8, $03, $20 ; entry 1
    db $F1, $F8, $04, $00 ; entry 2
    db $F1, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set48; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set48Frame2::
Data_027_5F4C:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set48; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set48Frame3::
Data_027_5F5D:: ; address name
    db $F1, $00, $07, $00 ; entry 0
    db $F9, $00, $09, $00 ; entry 1
    db $F1, $F8, $0A, $00 ; entry 2
    db $F9, $F8, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set48; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set48Frame4::
Data_027_5F6E:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set48; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set48Frame5::
Data_027_5F7F:: ; address name
    db $F1, $00, $0C, $20 ; entry 0
    db $F1, $F8, $0D, $20 ; entry 1
    db $F9, $00, $0E, $20 ; entry 2
    db $F9, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 73 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set49::
Data_027_5F90:: ; address name
    dw MetaSprites27Set49Frame0 ; entry 0
    dw MetaSprites27Set49Frame1 ; entry 1
    dw MetaSprites27Set49Frame2 ; entry 2
    dw MetaSprites27Set49Frame3 ; entry 3
    dw MetaSprites27Set49Frame4 ; entry 4
    dw MetaSprites27Set49Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set49; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set49Frame0::
Data_027_5F9C:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set49; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set49Frame1::
Data_027_5FAD:: ; address name
    db $F1, $FF, $00, $20 ; entry 0
    db $F1, $F7, $01, $20 ; entry 1
    db $F9, $FF, $02, $20 ; entry 2
    db $F9, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set49; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set49Frame2::
Data_027_5FBE:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set49; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set49Frame3::
Data_027_5FCF:: ; address name
    db $F1, $F8, $04, $00 ; entry 0
    db $F1, $00, $05, $00 ; entry 1
    db $F9, $F8, $08, $00 ; entry 2
    db $F9, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set49; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set49Frame4::
Data_027_5FE0:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set49; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set49Frame5::
Data_027_5FF1:: ; address name
    db $F1, $01, $0A, $20 ; entry 0
    db $F1, $F9, $0B, $20 ; entry 1
    db $F9, $01, $0C, $20 ; entry 2
    db $F9, $F9, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 74 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set4A::
Data_027_6002:: ; address name
    dw MetaSprites27Set4AFrame0 ; entry 0
    dw MetaSprites27Set4AFrame1 ; entry 1
    dw MetaSprites27Set4AFrame2 ; entry 2
    dw MetaSprites27Set4AFrame3 ; entry 3
    dw MetaSprites27Set4AFrame4 ; entry 4
    dw MetaSprites27Set4AFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set4A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4AFrame0::
Data_027_600E:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set4A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4AFrame1::
Data_027_601F:: ; address name
    db $EE, $00, $00, $20 ; entry 0
    db $EE, $F8, $01, $20 ; entry 1
    db $F6, $00, $02, $20 ; entry 2
    db $F6, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set4A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4AFrame2::
Data_027_6030:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set4A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4AFrame3::
Data_027_6041:: ; address name
    db $EE, $F8, $08, $00 ; entry 0
    db $EE, $00, $09, $00 ; entry 1
    db $F6, $F8, $0A, $00 ; entry 2
    db $F6, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set4A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4AFrame4::
Data_027_6052:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set4A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4AFrame5::
Data_027_6063:: ; address name
    db $EE, $00, $0C, $20 ; entry 0
    db $EE, $F8, $0D, $20 ; entry 1
    db $F6, $00, $0E, $20 ; entry 2
    db $F6, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 75 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set4B::
Data_027_6074:: ; address name
    dw MetaSprites27Set4BFrame0 ; entry 0
    dw MetaSprites27Set4BFrame1 ; entry 1
    dw MetaSprites27Set4BFrame2 ; entry 2
    dw MetaSprites27Set4BFrame3 ; entry 3
    dw MetaSprites27Set4BFrame4 ; entry 4
    dw MetaSprites27Set4BFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set4B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4BFrame0::
Data_027_6080:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set4B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4BFrame1::
Data_027_6091:: ; address name
    db $F0, $00, $00, $20 ; entry 0
    db $F0, $F8, $01, $20 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set4B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4BFrame2::
Data_027_60A2:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set4B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4BFrame3::
Data_027_60B3:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set4B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4BFrame4::
Data_027_60C4:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set4B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4BFrame5::
Data_027_60D5:: ; address name
    db $F0, $00, $0C, $20 ; entry 0
    db $F0, $F8, $0D, $20 ; entry 1
    db $F8, $00, $0E, $20 ; entry 2
    db $F8, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 76 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set4C::
Data_027_60E6:: ; address name
    dw MetaSprites27Set4CFrame0 ; entry 0
    dw MetaSprites27Set4CFrame1 ; entry 1
    dw MetaSprites27Set4CFrame2 ; entry 2
    dw MetaSprites27Set4CFrame3 ; entry 3
    dw MetaSprites27Set4CFrame4 ; entry 4
    dw MetaSprites27Set4CFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set4C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4CFrame0::
Data_027_60F2:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set4C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4CFrame1::
Data_027_6103:: ; address name
    db $EF, $F8, $04, $00 ; entry 0
    db $EF, $00, $05, $00 ; entry 1
    db $F7, $F8, $06, $00 ; entry 2
    db $F7, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set4C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4CFrame2::
Data_027_6114:: ; address name
    db $F8, $F8, $08, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F0, $F8, $01, $20 ; entry 2
    db $F8, $00, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set4C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4CFrame3::
Data_027_6125:: ; address name
    db $F7, $F8, $09, $00 ; entry 0
    db $EF, $00, $04, $20 ; entry 1
    db $EF, $F8, $05, $20 ; entry 2
    db $F7, $00, $06, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set4C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4CFrame4::
Data_027_6136:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $00, $0C, $00 ; entry 2
    db $F8, $F8, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set4C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4CFrame5::
Data_027_6147:: ; address name
    db $EF, $F8, $0D, $00 ; entry 0
    db $EF, $00, $0E, $00 ; entry 1
    db $F7, $00, $0F, $00 ; entry 2
    db $F7, $F8, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 77 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set4D::
Data_027_6158:: ; address name
    dw MetaSprites27Set4DFrame0 ; entry 0
    dw MetaSprites27Set4DFrame1 ; entry 1
    dw MetaSprites27Set4DFrame2 ; entry 2
    dw MetaSprites27Set4DFrame3 ; entry 3
    dw MetaSprites27Set4DFrame4 ; entry 4
    dw MetaSprites27Set4DFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set4D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4DFrame0::
Data_027_6164:: ; address name
    db $F3, $F8, $00, $00 ; entry 0
    db $F3, $00, $00, $20 ; entry 1
    db $FB, $F8, $01, $00 ; entry 2
    db $FB, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set4D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4DFrame1::
Data_027_6175:: ; address name
    db $F2, $F8, $03, $00 ; entry 0
    db $F2, $00, $03, $20 ; entry 1
    db $FA, $F8, $04, $00 ; entry 2
    db $FA, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set4D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4DFrame2::
Data_027_6186:: ; address name
    db $F3, $F8, $06, $00 ; entry 0
    db $F3, $00, $07, $00 ; entry 1
    db $FB, $F8, $08, $00 ; entry 2
    db $FB, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set4D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4DFrame3::
Data_027_6197:: ; address name
    db $FA, $F8, $08, $00 ; entry 0
    db $FA, $00, $09, $00 ; entry 1
    db $F2, $F8, $0A, $00 ; entry 2
    db $F2, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set4D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4DFrame4::
Data_027_61A8:: ; address name
    db $F1, $F8, $0C, $00 ; entry 0
    db $F1, $00, $0C, $20 ; entry 1
    db $F9, $F8, $0D, $00 ; entry 2
    db $F9, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set4D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4DFrame5::
Data_027_61B9:: ; address name
    db $F0, $F8, $0E, $00 ; entry 0
    db $F0, $00, $0E, $20 ; entry 1
    db $F8, $F8, $0F, $00 ; entry 2
    db $F8, $00, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 78 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set4E::
Data_027_61CA:: ; address name
    dw MetaSprites27Set4EFrame0 ; entry 0
    dw MetaSprites27Set4EFrame1 ; entry 1
    dw MetaSprites27Set4EFrame2 ; entry 2
    dw MetaSprites27Set4EFrame3 ; entry 3
    dw MetaSprites27Set4EFrame4 ; entry 4
    dw MetaSprites27Set4EFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set4E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4EFrame0::
Data_027_61D6:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $FF, $00, $20 ; entry 1
    db $F9, $F8, $01, $00 ; entry 2
    db $F9, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set4E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4EFrame1::
Data_027_61E7:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $03, $00 ; entry 2
    db $F8, $00, $04, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set4E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4EFrame2::
Data_027_61F8:: ; address name
    db $F0, $F8, $05, $00 ; entry 0
    db $F0, $00, $06, $00 ; entry 1
    db $F8, $F8, $07, $00 ; entry 2
    db $F8, $00, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set4E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4EFrame3::
Data_027_6209:: ; address name
    db $EF, $F8, $05, $00 ; entry 0
    db $F7, $F8, $07, $00 ; entry 1
    db $EF, $00, $09, $00 ; entry 2
    db $F7, $00, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set4E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4EFrame4::
Data_027_621A:: ; address name
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $FF, $0B, $20 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set4E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4EFrame5::
Data_027_622B:: ; address name
    db $EF, $F8, $0B, $00 ; entry 0
    db $EF, $FF, $0B, $20 ; entry 1
    db $F7, $F8, $0E, $00 ; entry 2
    db $F7, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 79 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set4F::
Data_027_623C:: ; address name
    dw MetaSprites27Set4FFrame0 ; entry 0
    dw MetaSprites27Set4FFrame1 ; entry 1
    dw MetaSprites27Set4FFrame2 ; entry 2
    dw MetaSprites27Set4FFrame3 ; entry 3
    dw MetaSprites27Set4FFrame4 ; entry 4
    dw MetaSprites27Set4FFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set4F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4FFrame0::
Data_027_6248:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set4F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4FFrame1::
Data_027_6259:: ; address name
    db $F1, $01, $00, $30 ; entry 0
    db $F1, $F9, $01, $30 ; entry 1
    db $F9, $01, $02, $30 ; entry 2
    db $F9, $F9, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set4F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4FFrame2::
Data_027_626A:: ; address name
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set4F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4FFrame3::
Data_027_627B:: ; address name
    db $F1, $F9, $08, $10 ; entry 0
    db $F1, $01, $09, $10 ; entry 1
    db $F9, $F9, $0A, $10 ; entry 2
    db $F9, $01, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set4F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4FFrame4::
Data_027_628C:: ; address name
    db $F0, $F8, $0C, $10 ; entry 0
    db $F0, $00, $0D, $10 ; entry 1
    db $F8, $F8, $0E, $10 ; entry 2
    db $F8, $00, $0F, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set4F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set4FFrame5::
Data_027_629D:: ; address name
    db $F1, $01, $0C, $30 ; entry 0
    db $F1, $F9, $0D, $30 ; entry 1
    db $F9, $01, $0E, $30 ; entry 2
    db $F9, $F9, $0F, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 80 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set50::
Data_027_62AE:: ; address name
    dw MetaSprites27Set50Frame0 ; entry 0
    dw MetaSprites27Set50Frame1 ; entry 1
    dw MetaSprites27Set50Frame2 ; entry 2
    dw MetaSprites27Set50Frame3 ; entry 3
    dw MetaSprites27Set50Frame4 ; entry 4
    dw MetaSprites27Set50Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set50; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set50Frame0::
Data_027_62BA:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $F8, $02, $00 ; entry 2
    db $F9, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set50; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set50Frame1::
Data_027_62CB:: ; address name
    db $F0, $00, $00, $20 ; entry 0
    db $F0, $F8, $01, $20 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set50; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set50Frame2::
Data_027_62DC:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set50; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set50Frame3::
Data_027_62ED:: ; address name
    db $EF, $F8, $08, $00 ; entry 0
    db $EF, $00, $09, $00 ; entry 1
    db $F7, $F8, $0A, $00 ; entry 2
    db $F7, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set50; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set50Frame4::
Data_027_62FE:: ; address name
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $00, $0C, $00 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0E, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set50; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set50Frame5::
Data_027_630F:: ; address name
    db $EF, $00, $0B, $20 ; entry 0
    db $EF, $F8, $0C, $20 ; entry 1
    db $F7, $00, $0D, $20 ; entry 2
    db $F7, $F8, $0E, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 81 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set51::
Data_027_6320:: ; address name
    dw MetaSprites27Set51Frame0 ; entry 0
    dw MetaSprites27Set51Frame1 ; entry 1
    dw MetaSprites27Set51Frame2 ; entry 2
    dw MetaSprites27Set51Frame3 ; entry 3
    dw MetaSprites27Set51Frame4 ; entry 4
    dw MetaSprites27Set51Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set51; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set51Frame0::
Data_027_632C:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $FF, $00, $20 ; entry 1
    db $F9, $F8, $01, $00 ; entry 2
    db $F9, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set51; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set51Frame1::
Data_027_633D:: ; address name
    db $F0, $F9, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $00, $01, $20 ; entry 2
    db $F8, $F8, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set51; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set51Frame2::
Data_027_634E:: ; address name
    db $F9, $F8, $05, $00 ; entry 0
    db $F9, $00, $06, $00 ; entry 1
    db $F1, $F8, $03, $00 ; entry 2
    db $F1, $00, $04, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set51; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set51Frame3::
Data_027_635F:: ; address name
    db $F8, $F8, $08, $00 ; entry 0
    db $F8, $00, $09, $00 ; entry 1
    db $F0, $F8, $07, $00 ; entry 2
    db $F0, $00, $04, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set51; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set51Frame4::
Data_027_6370:: ; address name
    db $F9, $F8, $0B, $00 ; entry 0
    db $F9, $00, $0C, $00 ; entry 1
    db $F1, $F8, $0A, $00 ; entry 2
    db $F1, $FF, $0A, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set51; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set51Frame5::
Data_027_6381:: ; address name
    db $F8, $00, $0B, $20 ; entry 0
    db $F8, $F8, $0C, $20 ; entry 1
    db $F0, $F9, $0A, $00 ; entry 2
    db $F0, $00, $0A, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 82 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set52::
Data_027_6392:: ; address name
    dw MetaSprites27Set52Frame0 ; entry 0
    dw MetaSprites27Set52Frame1 ; entry 1
    dw MetaSprites27Set52Frame2 ; entry 2
    dw MetaSprites27Set52Frame3 ; entry 3
    dw MetaSprites27Set52Frame4 ; entry 4
    dw MetaSprites27Set52Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set52; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set52Frame0::
Data_027_639E:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set52; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set52Frame1::
Data_027_63AF:: ; address name
    db $F1, $F8, $02, $00 ; entry 0
    db $F1, $00, $02, $20 ; entry 1
    db $F9, $F8, $03, $00 ; entry 2
    db $F9, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set52; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set52Frame2::
Data_027_63C0:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set52; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set52Frame3::
Data_027_63D1:: ; address name
    db $F1, $00, $05, $00 ; entry 0
    db $F1, $F8, $08, $00 ; entry 1
    db $F9, $F8, $09, $00 ; entry 2
    db $F9, $00, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set52; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set52Frame4::
Data_027_63E2:: ; address name
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $00, $0B, $20 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set52; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set52Frame5::
Data_027_63F3:: ; address name
    db $F1, $F8, $0E, $00 ; entry 0
    db $F1, $00, $0E, $20 ; entry 1
    db $F9, $F8, $0F, $00 ; entry 2
    db $F9, $00, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 83 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set53::
Data_027_6404:: ; address name
    dw MetaSprites27Set53Frame0 ; entry 0
    dw MetaSprites27Set53Frame1 ; entry 1
    dw MetaSprites27Set53Frame2 ; entry 2
    dw MetaSprites27Set53Frame3 ; entry 3
    dw MetaSprites27Set53Frame4 ; entry 4
    dw MetaSprites27Set53Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set53; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set53Frame0::
Data_027_6410:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set53; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set53Frame1::
Data_027_6421:: ; address name
    db $F1, $F8, $02, $00 ; entry 0
    db $F1, $00, $02, $20 ; entry 1
    db $F9, $F8, $03, $00 ; entry 2
    db $F9, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set53; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set53Frame2::
Data_027_6432:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set53; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set53Frame3::
Data_027_6443:: ; address name
    db $F1, $F8, $04, $00 ; entry 0
    db $F1, $00, $05, $00 ; entry 1
    db $F9, $F8, $08, $00 ; entry 2
    db $F9, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set53; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set53Frame4::
Data_027_6454:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0A, $20 ; entry 1
    db $F8, $F8, $0B, $00 ; entry 2
    db $F8, $00, $0C, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set53; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set53Frame5::
Data_027_6465:: ; address name
    db $F1, $F8, $0D, $00 ; entry 0
    db $F1, $00, $0D, $20 ; entry 1
    db $F9, $F8, $0E, $00 ; entry 2
    db $F9, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 84 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set54::
Data_027_6476:: ; address name
    dw MetaSprites27Set54Frame0 ; entry 0
    dw MetaSprites27Set54Frame1 ; entry 1
    dw MetaSprites27Set54Frame2 ; entry 2
    dw MetaSprites27Set54Frame3 ; entry 3
    dw MetaSprites27Set54Frame4 ; entry 4
    dw MetaSprites27Set54Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set54; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set54Frame0::
Data_027_6482:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set54; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set54Frame1::
Data_027_6493:: ; address name
    db $EF, $00, $00, $20 ; entry 0
    db $EF, $F8, $01, $20 ; entry 1
    db $F7, $F8, $03, $00 ; entry 2
    db $F7, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set54; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set54Frame2::
Data_027_64A4:: ; address name
    db $F0, $00, $05, $00 ; entry 0
    db $F8, $00, $07, $00 ; entry 1
    db $F0, $F8, $08, $00 ; entry 2
    db $F8, $F8, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set54; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set54Frame3::
Data_027_64B5:: ; address name
    db $EF, $F8, $04, $00 ; entry 0
    db $EF, $00, $05, $00 ; entry 1
    db $F7, $F8, $06, $00 ; entry 2
    db $F7, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set54; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set54Frame4::
Data_027_64C6:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set54; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set54Frame5::
Data_027_64D7:: ; address name
    db $EF, $00, $0A, $20 ; entry 0
    db $EF, $F8, $0B, $20 ; entry 1
    db $F7, $F8, $0E, $00 ; entry 2
    db $F7, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 85 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set55::
Data_027_64E8:: ; address name
    dw MetaSprites27Set55Frame0 ; entry 0
    dw MetaSprites27Set55Frame1 ; entry 1
    dw MetaSprites27Set55Frame2 ; entry 2
    dw MetaSprites27Set55Frame3 ; entry 3
    dw MetaSprites27Set55Frame4 ; entry 4
    dw MetaSprites27Set55Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set55; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set55Frame0::
Data_027_64F4:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $00, $20 ; entry 1
    db $F9, $F8, $01, $00 ; entry 2
    db $F9, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set55; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set55Frame1::
Data_027_6505:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $00, $01, $20 ; entry 2
    db $F8, $F8, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set55; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set55Frame2::
Data_027_6516:: ; address name
    db $F0, $F8, $03, $00 ; entry 0
    db $F0, $00, $04, $00 ; entry 1
    db $F8, $F8, $05, $00 ; entry 2
    db $F8, $00, $06, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set55; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set55Frame3::
Data_027_6527:: ; address name
    db $EF, $F8, $03, $00 ; entry 0
    db $EF, $00, $04, $00 ; entry 1
    db $F7, $F8, $07, $00 ; entry 2
    db $F7, $00, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set55; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set55Frame4::
Data_027_6538:: ; address name
    db $F0, $F8, $09, $00 ; entry 0
    db $F0, $00, $09, $20 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set55; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set55Frame5::
Data_027_6549:: ; address name
    db $EF, $F8, $09, $00 ; entry 0
    db $EF, $00, $09, $20 ; entry 1
    db $F7, $00, $0A, $20 ; entry 2
    db $F7, $F8, $0B, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 86 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set56::
Data_027_655A:: ; address name
    dw MetaSprites27Set56Frame0 ; entry 0
    dw MetaSprites27Set56Frame1 ; entry 1
    dw MetaSprites27Set56Frame2 ; entry 2
    dw MetaSprites27Set56Frame3 ; entry 3
    dw MetaSprites27Set56Frame4 ; entry 4
    dw MetaSprites27Set56Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set56; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set56Frame0::
Data_027_6566:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set56; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set56Frame1::
Data_027_6577:: ; address name
    db $F7, $00, $02, $20 ; entry 0
    db $F7, $F8, $03, $20 ; entry 1
    db $EF, $00, $00, $20 ; entry 2
    db $EF, $F8, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set56; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set56Frame2::
Data_027_6588:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set56; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set56Frame3::
Data_027_6599:: ; address name
    db $EF, $00, $05, $00 ; entry 0
    db $F7, $F8, $09, $00 ; entry 1
    db $F7, $00, $0A, $00 ; entry 2
    db $EF, $F8, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set56; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set56Frame4::
Data_027_65AA:: ; address name
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $00, $0C, $00 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0E, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set56; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set56Frame5::
Data_027_65BB:: ; address name
    db $EF, $00, $0B, $20 ; entry 0
    db $EF, $F8, $0C, $20 ; entry 1
    db $F7, $00, $0D, $20 ; entry 2
    db $F7, $F8, $0E, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 87 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set57::
Data_027_65CC:: ; address name
    dw MetaSprites27Set57Frame0 ; entry 0
    dw MetaSprites27Set57Frame1 ; entry 1
    dw MetaSprites27Set57Frame2 ; entry 2
    dw MetaSprites27Set57Frame3 ; entry 3
    dw MetaSprites27Set57Frame4 ; entry 4
    dw MetaSprites27Set57Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set57; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set57Frame0::
Data_027_65D8:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set57; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set57Frame1::
Data_027_65E9:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $F8, $04, $00 ; entry 2
    db $F9, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set57; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set57Frame2::
Data_027_65FA:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set57; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set57Frame3::
Data_027_660B:: ; address name
    db $F1, $F8, $06, $00 ; entry 0
    db $F1, $00, $07, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set57; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set57Frame4::
Data_027_661C:: ; address name
    db $F8, $00, $02, $20 ; entry 0
    db $F8, $F8, $03, $20 ; entry 1
    db $F0, $F8, $0C, $00 ; entry 2
    db $F0, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set57; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set57Frame5::
Data_027_662D:: ; address name
    db $F9, $00, $04, $20 ; entry 0
    db $F9, $F8, $05, $20 ; entry 1
    db $F1, $F8, $0C, $00 ; entry 2
    db $F1, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 88 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set58::
Data_027_663E:: ; address name
    dw MetaSprites27Set58Frame0 ; entry 0
    dw MetaSprites27Set58Frame1 ; entry 1
    dw MetaSprites27Set58Frame2 ; entry 2
    dw MetaSprites27Set58Frame3 ; entry 3
    dw MetaSprites27Set58Frame4 ; entry 4
    dw MetaSprites27Set58Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set58; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set58Frame0::
Data_027_664A:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set58; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set58Frame1::
Data_027_665B:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $00, $03, $00 ; entry 2
    db $F9, $F8, $04, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set58; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set58Frame2::
Data_027_666C:: ; address name
    db $F0, $F8, $05, $00 ; entry 0
    db $F0, $00, $06, $00 ; entry 1
    db $F8, $F8, $07, $00 ; entry 2
    db $F8, $00, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set58; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set58Frame3::
Data_027_667D:: ; address name
    db $F1, $F8, $05, $00 ; entry 0
    db $F1, $00, $06, $00 ; entry 1
    db $F9, $F8, $07, $00 ; entry 2
    db $F9, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set58; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set58Frame4::
Data_027_668E:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set58; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set58Frame5::
Data_027_669F:: ; address name
    db $F1, $F8, $0A, $00 ; entry 0
    db $F1, $00, $0B, $00 ; entry 1
    db $F9, $F8, $0C, $00 ; entry 2
    db $F9, $00, $0E, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 89 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set59::
Data_027_66B0:: ; address name
    dw MetaSprites27Set59Frame0 ; entry 0
    dw MetaSprites27Set59Frame1 ; entry 1
    dw MetaSprites27Set59Frame2 ; entry 2
    dw MetaSprites27Set59Frame3 ; entry 3
    dw MetaSprites27Set59Frame4 ; entry 4
    dw MetaSprites27Set59Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set59; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set59Frame0::
Data_027_66BC:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $FF, $00, $20 ; entry 1
    db $F9, $F8, $01, $00 ; entry 2
    db $F9, $FF, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set59; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set59Frame1::
Data_027_66CD:: ; address name
    db $F0, $F8, $02, $00 ; entry 0
    db $F0, $FF, $02, $20 ; entry 1
    db $F8, $F8, $03, $00 ; entry 2
    db $F8, $FF, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set59; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set59Frame2::
Data_027_66DE:: ; address name
    db $EF, $F8, $04, $00 ; entry 0
    db $EF, $00, $05, $00 ; entry 1
    db $F7, $F8, $06, $00 ; entry 2
    db $F7, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set59; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set59Frame3::
Data_027_66EF:: ; address name
    db $F0, $F9, $08, $00 ; entry 0
    db $F0, $01, $09, $00 ; entry 1
    db $F8, $F9, $0A, $00 ; entry 2
    db $F8, $01, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set59; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set59Frame4::
Data_027_6700:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F8, $F8, $0D, $00 ; entry 1
    db $F0, $FF, $0C, $20 ; entry 2
    db $F8, $FF, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set59; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set59Frame5::
Data_027_6711:: ; address name
    db $EF, $F8, $0E, $00 ; entry 0
    db $F7, $F8, $0F, $00 ; entry 1
    db $EF, $FF, $0E, $20 ; entry 2
    db $F7, $FF, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 90 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set5A::
Data_027_6722:: ; address name
    dw MetaSprites27Set5AFrame0 ; entry 0
    dw MetaSprites27Set5AFrame1 ; entry 1
    dw MetaSprites27Set5AFrame2 ; entry 2
    dw MetaSprites27Set5AFrame3 ; entry 3
    dw MetaSprites27Set5AFrame4 ; entry 4
    dw MetaSprites27Set5AFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set5A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set5AFrame0::
Data_027_672E:: ; address name
    db $F0, $F9, $00, $00 ; entry 0
    db $F8, $F9, $01, $00 ; entry 1
    db $F0, $00, $00, $20 ; entry 2
    db $F8, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set5A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set5AFrame1::
Data_027_673F:: ; address name
    db $F1, $F9, $02, $00 ; entry 0
    db $F9, $F9, $03, $00 ; entry 1
    db $F1, $00, $02, $20 ; entry 2
    db $F9, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set5A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set5AFrame2::
Data_027_6750:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set5A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set5AFrame3::
Data_027_6761:: ; address name
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set5A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set5AFrame4::
Data_027_6772:: ; address name
    db $F0, $F9, $0C, $00 ; entry 0
    db $F8, $F9, $0D, $00 ; entry 1
    db $F0, $00, $0C, $20 ; entry 2
    db $F8, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set5A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set5AFrame5::
Data_027_6783:: ; address name
    db $F1, $F9, $0E, $00 ; entry 0
    db $F9, $F9, $0F, $00 ; entry 1
    db $F1, $00, $0E, $20 ; entry 2
    db $F9, $00, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 91 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set5B::
Data_027_6794:: ; address name
    dw MetaSprites27Set5BFrame0 ; entry 0
    dw MetaSprites27Set5BFrame1 ; entry 1
    dw MetaSprites27Set5BFrame2 ; entry 2
    dw MetaSprites27Set5BFrame3 ; entry 3
    dw MetaSprites27Set5BFrame4 ; entry 4
    dw MetaSprites27Set5BFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set5B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set5BFrame0::
Data_027_67A0:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set5B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set5BFrame1::
Data_027_67B1:: ; address name
    db $F0, $00, $00, $20 ; entry 0
    db $F0, $F8, $01, $20 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set5B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set5BFrame2::
Data_027_67C2:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set5B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set5BFrame3::
Data_027_67D3:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set5B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set5BFrame4::
Data_027_67E4:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set5B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set5BFrame5::
Data_027_67F5:: ; address name
    db $F0, $00, $0C, $20 ; entry 0
    db $F0, $F8, $0D, $20 ; entry 1
    db $F8, $00, $0E, $20 ; entry 2
    db $F8, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 92 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set5C::
Data_027_6806:: ; address name
    dw MetaSprites27Set5CFrame0 ; entry 0
    dw MetaSprites27Set5CFrame1 ; entry 1
    dw MetaSprites27Set5CFrame2 ; entry 2
    dw MetaSprites27Set5CFrame3 ; entry 3
    dw MetaSprites27Set5CFrame4 ; entry 4
    dw MetaSprites27Set5CFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set5C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set5CFrame0::
Data_027_6812:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $F8, $02, $00 ; entry 2
    db $F9, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set5C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set5CFrame1::
Data_027_6823:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $04, $00 ; entry 2
    db $F8, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set5C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set5CFrame2::
Data_027_6834:: ; address name
    db $F1, $F8, $06, $00 ; entry 0
    db $F1, $00, $07, $00 ; entry 1
    db $F9, $F8, $08, $00 ; entry 2
    db $F9, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set5C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set5CFrame3::
Data_027_6845:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set5C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set5CFrame4::
Data_027_6856:: ; address name
    db $F1, $F8, $0C, $00 ; entry 0
    db $F1, $00, $0D, $00 ; entry 1
    db $F9, $F8, $0E, $00 ; entry 2
    db $F9, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set5C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set5CFrame5::
Data_027_6867:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $00, $0E, $20 ; entry 2
    db $F8, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 96 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set60::
Data_027_6878:: ; address name
    dw MetaSprites27Set60Frame0 ; entry 0
    dw MetaSprites27Set60Frame1 ; entry 1
    dw MetaSprites27Set60Frame2 ; entry 2
    dw MetaSprites27Set60Frame3 ; entry 3
    dw MetaSprites27Set60Frame4 ; entry 4
    dw MetaSprites27Set60Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set60; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set60Frame0::
Data_027_6884:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set60; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set60Frame1::
Data_027_6895:: ; address name
    db $F9, $00, $01, $20 ; entry 0
    db $F9, $F8, $02, $20 ; entry 1
    db $F1, $F8, $03, $00 ; entry 2
    db $F1, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set60; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set60Frame2::
Data_027_68A6:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set60; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set60Frame3::
Data_027_68B7:: ; address name
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set60; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set60Frame4::
Data_027_68C8:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0C, $20 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set60; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set60Frame5::
Data_027_68D9:: ; address name
    db $F1, $F8, $0C, $00 ; entry 0
    db $F1, $00, $0C, $20 ; entry 1
    db $F9, $00, $0E, $20 ; entry 2
    db $F9, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 97 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set61::
Data_027_68EA:: ; address name
    dw MetaSprites27Set61Frame0 ; entry 0
    dw MetaSprites27Set61Frame1 ; entry 1
    dw MetaSprites27Set61Frame2 ; entry 2
    dw MetaSprites27Set61Frame3 ; entry 3
    dw MetaSprites27Set61Frame4 ; entry 4
    dw MetaSprites27Set61Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set61; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set61Frame0::
Data_027_68F6:: ; address name
    db $F8, $F8, $02, $00 ; entry 0
    db $F8, $00, $03, $00 ; entry 1
    db $F0, $F8, $00, $00 ; entry 2
    db $F0, $00, $01, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set61; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set61Frame1::
Data_027_6907:: ; address name
    db $F1, $00, $00, $20 ; entry 0
    db $F1, $F8, $01, $20 ; entry 1
    db $F9, $00, $02, $20 ; entry 2
    db $F9, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set61; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set61Frame2::
Data_027_6918:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set61; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set61Frame3::
Data_027_6929:: ; address name
    db $F1, $00, $05, $00 ; entry 0
    db $F1, $F8, $08, $00 ; entry 1
    db $F9, $F8, $09, $00 ; entry 2
    db $F9, $00, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set61; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set61Frame4::
Data_027_693A:: ; address name
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $00, $0B, $20 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set61; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set61Frame5::
Data_027_694B:: ; address name
    db $F9, $00, $0C, $20 ; entry 0
    db $F9, $F8, $0D, $20 ; entry 1
    db $F1, $F8, $0B, $00 ; entry 2
    db $F1, $00, $0B, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 98 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set62::
Data_027_695C:: ; address name
    dw MetaSprites27Set62Frame0 ; entry 0
    dw MetaSprites27Set62Frame1 ; entry 1
    dw MetaSprites27Set62Frame2 ; entry 2
    dw MetaSprites27Set62Frame3 ; entry 3
    dw MetaSprites27Set62Frame4 ; entry 4
    dw MetaSprites27Set62Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set62; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set62Frame0::
Data_027_6968:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set62; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set62Frame1::
Data_027_6979:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $03, $00 ; entry 2
    db $F8, $00, $04, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set62; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set62Frame2::
Data_027_698A:: ; address name
    db $F0, $F8, $09, $00 ; entry 0
    db $F0, $00, $0A, $00 ; entry 1
    db $F8, $F8, $0B, $00 ; entry 2
    db $F8, $00, $0C, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set62; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set62Frame3::
Data_027_699B:: ; address name
    db $F0, $F8, $09, $00 ; entry 0
    db $F0, $00, $0A, $00 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0E, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set62; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set62Frame4::
Data_027_69AC:: ; address name
    db $F0, $F8, $05, $00 ; entry 0
    db $F0, $00, $05, $20 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $06, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set62; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set62Frame5::
Data_027_69BD:: ; address name
    db $F0, $F8, $07, $00 ; entry 0
    db $F8, $F8, $08, $00 ; entry 1
    db $F8, $00, $08, $20 ; entry 2
    db $F0, $00, $07, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 99 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set63::
Data_027_69CE:: ; address name
    dw MetaSprites27Set63Frame0 ; entry 0
    dw MetaSprites27Set63Frame1 ; entry 1
    dw MetaSprites27Set63Frame2 ; entry 2
    dw MetaSprites27Set63Frame3 ; entry 3
    dw MetaSprites27Set63Frame4 ; entry 4
    dw MetaSprites27Set63Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set63; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set63Frame0::
Data_027_69DA:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $00, $30 ; entry 1
    db $F8, $F8, $01, $10 ; entry 2
    db $F8, $00, $01, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set63; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set63Frame1::
Data_027_69EB:: ; address name
    db $F1, $F8, $02, $10 ; entry 0
    db $F1, $00, $02, $30 ; entry 1
    db $F9, $F8, $03, $10 ; entry 2
    db $F9, $00, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set63; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set63Frame2::
Data_027_69FC:: ; address name
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set63; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set63Frame3::
Data_027_6A0D:: ; address name
    db $F1, $F8, $08, $10 ; entry 0
    db $F1, $00, $09, $10 ; entry 1
    db $F9, $F8, $0A, $10 ; entry 2
    db $F9, $00, $0B, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set63; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set63Frame4::
Data_027_6A1E:: ; address name
    db $F0, $F8, $0C, $10 ; entry 0
    db $F0, $00, $0C, $30 ; entry 1
    db $F8, $F8, $0D, $10 ; entry 2
    db $F8, $00, $0D, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set63; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set63Frame5::
Data_027_6A2F:: ; address name
    db $F1, $F8, $0E, $10 ; entry 0
    db $F1, $00, $0E, $30 ; entry 1
    db $F9, $F8, $0F, $10 ; entry 2
    db $F9, $00, $0F, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 100 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set64::
Data_027_6A40:: ; address name
    dw MetaSprites27Set64Frame0 ; entry 0
    dw MetaSprites27Set64Frame1 ; entry 1
    dw MetaSprites27Set64Frame2 ; entry 2
    dw MetaSprites27Set64Frame3 ; entry 3
    dw MetaSprites27Set64Frame4 ; entry 4
    dw MetaSprites27Set64Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set64; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set64Frame0::
Data_027_6A4C:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set64; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set64Frame1::
Data_027_6A5D:: ; address name
    db $F1, $F8, $02, $00 ; entry 0
    db $F1, $00, $02, $20 ; entry 1
    db $F9, $F8, $03, $00 ; entry 2
    db $F9, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set64; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set64Frame2::
Data_027_6A6E:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set64; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set64Frame3::
Data_027_6A7F:: ; address name
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set64; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set64Frame4::
Data_027_6A90:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0C, $20 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set64; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set64Frame5::
Data_027_6AA1:: ; address name
    db $F1, $F8, $0E, $00 ; entry 0
    db $F1, $00, $0E, $20 ; entry 1
    db $F9, $F8, $0F, $00 ; entry 2
    db $F9, $00, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 101 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set65::
Data_027_6AB2:: ; address name
    dw MetaSprites27Set65Frame0 ; entry 0
    dw MetaSprites27Set65Frame1 ; entry 1
    dw MetaSprites27Set65Frame2 ; entry 2
    dw MetaSprites27Set65Frame3 ; entry 3
    dw MetaSprites27Set65Frame4 ; entry 4
    dw MetaSprites27Set65Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set65; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set65Frame0::
Data_027_6ABE:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set65; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set65Frame1::
Data_027_6ACF:: ; address name
    db $F1, $00, $00, $30 ; entry 0
    db $F1, $F8, $01, $30 ; entry 1
    db $F9, $00, $02, $30 ; entry 2
    db $F9, $F8, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set65; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set65Frame2::
Data_027_6AE0:: ; address name
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set65; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set65Frame3::
Data_027_6AF1:: ; address name
    db $F1, $F8, $04, $10 ; entry 0
    db $F1, $00, $05, $10 ; entry 1
    db $F9, $F8, $08, $10 ; entry 2
    db $F9, $00, $09, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set65; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set65Frame4::
Data_027_6B02:: ; address name
    db $F0, $F8, $0A, $10 ; entry 0
    db $F0, $00, $0B, $10 ; entry 1
    db $F8, $F8, $0C, $10 ; entry 2
    db $F8, $00, $0D, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set65; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set65Frame5::
Data_027_6B13:: ; address name
    db $F1, $00, $0A, $30 ; entry 0
    db $F1, $F8, $0B, $30 ; entry 1
    db $F9, $00, $0C, $30 ; entry 2
    db $F9, $F8, $0D, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 102 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set66::
Data_027_6B24:: ; address name
    dw MetaSprites27Set66Frame0 ; entry 0
    dw MetaSprites27Set66Frame1 ; entry 1
    dw MetaSprites27Set66Frame2 ; entry 2
    dw MetaSprites27Set66Frame3 ; entry 3
    dw MetaSprites27Set66Frame4 ; entry 4
    dw MetaSprites27Set66Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set66; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set66Frame0::
Data_027_6B30:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set66; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set66Frame1::
Data_027_6B41:: ; address name
    db $F1, $00, $00, $20 ; entry 0
    db $F1, $F8, $01, $20 ; entry 1
    db $F9, $00, $02, $20 ; entry 2
    db $F9, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set66; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set66Frame2::
Data_027_6B52:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set66; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set66Frame3::
Data_027_6B63:: ; address name
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set66; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set66Frame4::
Data_027_6B74:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set66; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set66Frame5::
Data_027_6B85:: ; address name
    db $F1, $00, $0C, $20 ; entry 0
    db $F1, $F8, $0D, $20 ; entry 1
    db $F9, $00, $0E, $20 ; entry 2
    db $F9, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 103 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set67::
Data_027_6B96:: ; address name
    dw MetaSprites27Set67Frame0 ; entry 0
    dw MetaSprites27Set67Frame1 ; entry 1
    dw MetaSprites27Set67Frame2 ; entry 2
    dw MetaSprites27Set67Frame3 ; entry 3
    dw MetaSprites27Set67Frame4 ; entry 4
    dw MetaSprites27Set67Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set67; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set67Frame0::
Data_027_6BA2:: ; address name
    db $F0, $00, $00, $20 ; entry 0
    db $F0, $F8, $00, $00 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set67; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set67Frame1::
Data_027_6BB3:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $00, $20 ; entry 1
    db $F9, $F8, $03, $00 ; entry 2
    db $F9, $00, $04, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set67; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set67Frame2::
Data_027_6BC4:: ; address name
    db $F0, $F8, $05, $00 ; entry 0
    db $F0, $00, $06, $00 ; entry 1
    db $F8, $F8, $07, $00 ; entry 2
    db $F8, $00, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set67; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set67Frame3::
Data_027_6BD5:: ; address name
    db $F1, $F8, $05, $00 ; entry 0
    db $F1, $00, $06, $00 ; entry 1
    db $F9, $F8, $09, $00 ; entry 2
    db $F9, $00, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set67; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set67Frame4::
Data_027_6BE6:: ; address name
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $00, $0B, $20 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set67; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set67Frame5::
Data_027_6BF7:: ; address name
    db $F9, $00, $0C, $20 ; entry 0
    db $F9, $F8, $0D, $20 ; entry 1
    db $F1, $F8, $0B, $00 ; entry 2
    db $F1, $00, $0B, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 104 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set68::
Data_027_6C08:: ; address name
    dw MetaSprites27Set68Frame0 ; entry 0
    dw MetaSprites27Set68Frame1 ; entry 1
    dw MetaSprites27Set68Frame2 ; entry 2
    dw MetaSprites27Set68Frame3 ; entry 3
    dw MetaSprites27Set68Frame4 ; entry 4
    dw MetaSprites27Set68Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set68; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set68Frame0::
Data_027_6C14:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set68; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set68Frame1::
Data_027_6C25:: ; address name
    db $F1, $00, $00, $30 ; entry 0
    db $F1, $F8, $01, $30 ; entry 1
    db $F9, $00, $02, $30 ; entry 2
    db $F9, $F8, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set68; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set68Frame2::
Data_027_6C36:: ; address name
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set68; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set68Frame3::
Data_027_6C47:: ; address name
    db $F1, $F8, $04, $10 ; entry 0
    db $F1, $00, $08, $10 ; entry 1
    db $F9, $F8, $09, $10 ; entry 2
    db $F9, $00, $0A, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set68; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set68Frame4::
Data_027_6C58:: ; address name
    db $F0, $F8, $0B, $10 ; entry 0
    db $F0, $00, $0C, $10 ; entry 1
    db $F8, $F8, $0D, $10 ; entry 2
    db $F8, $00, $0E, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set68; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set68Frame5::
Data_027_6C69:: ; address name
    db $F1, $00, $0B, $30 ; entry 0
    db $F1, $F8, $0C, $30 ; entry 1
    db $F9, $00, $0D, $30 ; entry 2
    db $F9, $F8, $0E, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 105 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set69::
Data_027_6C7A:: ; address name
    dw MetaSprites27Set69Frame0 ; entry 0
    dw MetaSprites27Set69Frame1 ; entry 1
    dw MetaSprites27Set69Frame2 ; entry 2
    dw MetaSprites27Set69Frame3 ; entry 3
    dw MetaSprites27Set69Frame4 ; entry 4
    dw MetaSprites27Set69Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set69; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set69Frame0::
Data_027_6C86:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set69; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set69Frame1::
Data_027_6C97:: ; address name
    db $F1, $00, $00, $30 ; entry 0
    db $F1, $F8, $01, $30 ; entry 1
    db $F9, $00, $02, $30 ; entry 2
    db $F9, $F8, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set69; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set69Frame2::
Data_027_6CA8:: ; address name
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set69; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set69Frame3::
Data_027_6CB9:: ; address name
    db $F1, $00, $05, $10 ; entry 0
    db $F1, $F8, $08, $10 ; entry 1
    db $F9, $F8, $09, $10 ; entry 2
    db $F9, $00, $0A, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set69; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set69Frame4::
Data_027_6CCA:: ; address name
    db $F0, $F8, $0B, $10 ; entry 0
    db $F0, $00, $0C, $10 ; entry 1
    db $F8, $F8, $0D, $10 ; entry 2
    db $F8, $00, $0E, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set69; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set69Frame5::
Data_027_6CDB:: ; address name
    db $F1, $00, $0B, $30 ; entry 0
    db $F1, $F8, $0C, $30 ; entry 1
    db $F9, $00, $0D, $30 ; entry 2
    db $F9, $F8, $0E, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 106 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set6A::
Data_027_6CEC:: ; address name
    dw MetaSprites27Set6AFrame0 ; entry 0
    dw MetaSprites27Set6AFrame1 ; entry 1
    dw MetaSprites27Set6AFrame2 ; entry 2
    dw MetaSprites27Set6AFrame3 ; entry 3
    dw MetaSprites27Set6AFrame4 ; entry 4
    dw MetaSprites27Set6AFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set6A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6AFrame0::
Data_027_6CF8:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set6A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6AFrame1::
Data_027_6D09:: ; address name
    db $F0, $00, $00, $20 ; entry 0
    db $F0, $F8, $01, $20 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set6A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6AFrame2::
Data_027_6D1A:: ; address name
    db $F8, $F8, $06, $00 ; entry 0
    db $F8, $00, $07, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set6A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6AFrame3::
Data_027_6D2B:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set6A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6AFrame4::
Data_027_6D3C:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set6A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6AFrame5::
Data_027_6D4D:: ; address name
    db $F0, $00, $0C, $20 ; entry 0
    db $F0, $F8, $0D, $20 ; entry 1
    db $F8, $00, $0E, $20 ; entry 2
    db $F8, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 107 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set6B::
Data_027_6D5E:: ; address name
    dw MetaSprites27Set6BFrame0 ; entry 0
    dw MetaSprites27Set6BFrame1 ; entry 1
    dw MetaSprites27Set6BFrame2 ; entry 2
    dw MetaSprites27Set6BFrame3 ; entry 3
    dw MetaSprites27Set6BFrame4 ; entry 4
    dw MetaSprites27Set6BFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set6B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6BFrame0::
Data_027_6D6A:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set6B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6BFrame1::
Data_027_6D7B:: ; address name
    db $F1, $00, $00, $20 ; entry 0
    db $F1, $F8, $01, $20 ; entry 1
    db $F9, $00, $02, $20 ; entry 2
    db $F9, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set6B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6BFrame2::
Data_027_6D8C:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set6B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6BFrame3::
Data_027_6D9D:: ; address name
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set6B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6BFrame4::
Data_027_6DAE:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set6B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6BFrame5::
Data_027_6DBF:: ; address name
    db $F1, $00, $0C, $20 ; entry 0
    db $F1, $F8, $0D, $20 ; entry 1
    db $F9, $00, $0E, $20 ; entry 2
    db $F9, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 108 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set6C::
Data_027_6DD0:: ; address name
    dw MetaSprites27Set6CFrame0 ; entry 0
    dw MetaSprites27Set6CFrame1 ; entry 1
    dw MetaSprites27Set6CFrame2 ; entry 2
    dw MetaSprites27Set6CFrame3 ; entry 3
    dw MetaSprites27Set6CFrame4 ; entry 4
    dw MetaSprites27Set6CFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set6C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6CFrame0::
Data_027_6DDC:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set6C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6CFrame1::
Data_027_6DED:: ; address name
    db $F1, $F8, $00, $10 ; entry 0
    db $F1, $00, $01, $10 ; entry 1
    db $F9, $00, $02, $30 ; entry 2
    db $F9, $F8, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set6C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6CFrame2::
Data_027_6DFE:: ; address name
    db $F0, $F8, $04, $10 ; entry 0
    db $F0, $00, $05, $10 ; entry 1
    db $F8, $F8, $06, $10 ; entry 2
    db $F8, $00, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set6C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6CFrame3::
Data_027_6E0F:: ; address name
    db $F1, $F8, $04, $10 ; entry 0
    db $F1, $00, $05, $10 ; entry 1
    db $F9, $F8, $08, $10 ; entry 2
    db $F9, $00, $09, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set6C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6CFrame4::
Data_027_6E20:: ; address name
    db $F0, $F8, $0A, $10 ; entry 0
    db $F0, $00, $0B, $10 ; entry 1
    db $F8, $F8, $0C, $10 ; entry 2
    db $F8, $00, $0D, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set6C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6CFrame5::
Data_027_6E31:: ; address name
    db $F1, $00, $0A, $30 ; entry 0
    db $F1, $F8, $0B, $30 ; entry 1
    db $F9, $00, $0C, $30 ; entry 2
    db $F9, $F8, $0D, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 109 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set6D::
Data_027_6E42:: ; address name
    dw MetaSprites27Set6DFrame0 ; entry 0
    dw MetaSprites27Set6DFrame1 ; entry 1
    dw MetaSprites27Set6DFrame2 ; entry 2
    dw MetaSprites27Set6DFrame3 ; entry 3
    dw MetaSprites27Set6DFrame4 ; entry 4
    dw MetaSprites27Set6DFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set6D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6DFrame0::
Data_027_6E4E:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $01, $10 ; entry 1
    db $F8, $F8, $02, $10 ; entry 2
    db $F8, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set6D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6DFrame1::
Data_027_6E5F:: ; address name
    db $F1, $F8, $00, $10 ; entry 0
    db $F1, $00, $01, $10 ; entry 1
    db $F9, $F8, $04, $10 ; entry 2
    db $F9, $00, $05, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set6D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6DFrame2::
Data_027_6E70:: ; address name
    db $F0, $F8, $06, $10 ; entry 0
    db $F0, $00, $07, $10 ; entry 1
    db $F8, $F8, $08, $10 ; entry 2
    db $F8, $00, $09, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set6D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6DFrame3::
Data_027_6E81:: ; address name
    db $F9, $F8, $0A, $10 ; entry 0
    db $F9, $00, $0B, $10 ; entry 1
    db $F1, $F7, $06, $10 ; entry 2
    db $F1, $FF, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set6D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6DFrame4::
Data_027_6E92:: ; address name
    db $F1, $F8, $0C, $10 ; entry 0
    db $F1, $00, $0D, $10 ; entry 1
    db $F9, $F8, $0E, $10 ; entry 2
    db $F9, $00, $0F, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set6D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6DFrame5::
Data_027_6EA3:: ; address name
    db $F0, $00, $0C, $30 ; entry 0
    db $F0, $F8, $0D, $30 ; entry 1
    db $F8, $00, $0E, $30 ; entry 2
    db $F8, $F8, $0F, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 110 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set6E::
Data_027_6EB4:: ; address name
    dw MetaSprites27Set6EFrame0 ; entry 0
    dw MetaSprites27Set6EFrame1 ; entry 1
    dw MetaSprites27Set6EFrame2 ; entry 2
    dw MetaSprites27Set6EFrame3 ; entry 3
    dw MetaSprites27Set6EFrame4 ; entry 4
    dw MetaSprites27Set6EFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set6E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6EFrame0::
Data_027_6EC0:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $FF, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set6E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6EFrame1::
Data_027_6ED1:: ; address name
    db $F7, $FF, $01, $20 ; entry 0
    db $EF, $F8, $02, $00 ; entry 1
    db $EF, $00, $03, $00 ; entry 2
    db $F7, $F8, $01, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set6E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6EFrame2::
Data_027_6EE2:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set6E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6EFrame3::
Data_027_6EF3:: ; address name
    db $F7, $00, $07, $00 ; entry 0
    db $EF, $F8, $08, $00 ; entry 1
    db $EF, $00, $09, $00 ; entry 2
    db $F7, $F8, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set6E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6EFrame4::
Data_027_6F04:: ; address name
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $FF, $0B, $20 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $FF, $0C, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set6E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6EFrame5::
Data_027_6F15:: ; address name
    db $EF, $F8, $0D, $00 ; entry 0
    db $EF, $00, $0E, $00 ; entry 1
    db $F7, $F8, $0F, $00 ; entry 2
    db $F7, $FF, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 111 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set6F::
Data_027_6F26:: ; address name
    dw MetaSprites27Set6FFrame0 ; entry 0
    dw MetaSprites27Set6FFrame1 ; entry 1
    dw MetaSprites27Set6FFrame2 ; entry 2
    dw MetaSprites27Set6FFrame3 ; entry 3
    dw MetaSprites27Set6FFrame4 ; entry 4
    dw MetaSprites27Set6FFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set6F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6FFrame0::
Data_027_6F32:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set6F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6FFrame1::
Data_027_6F43:: ; address name
    db $F0, $00, $00, $20 ; entry 0
    db $F0, $F8, $01, $20 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set6F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6FFrame2::
Data_027_6F54:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set6F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6FFrame3::
Data_027_6F65:: ; address name
    db $F8, $F8, $0A, $00 ; entry 0
    db $F8, $00, $0B, $00 ; entry 1
    db $F0, $F8, $08, $00 ; entry 2
    db $F0, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set6F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6FFrame4::
Data_027_6F76:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set6F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set6FFrame5::
Data_027_6F87:: ; address name
    db $F0, $00, $0C, $20 ; entry 0
    db $F0, $F8, $0D, $20 ; entry 1
    db $F8, $00, $0E, $20 ; entry 2
    db $F8, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 112 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set70::
Data_027_6F98:: ; address name
    dw MetaSprites27Set70Frame0 ; entry 0
    dw MetaSprites27Set70Frame1 ; entry 1
    dw MetaSprites27Set70Frame2 ; entry 2
    dw MetaSprites27Set70Frame3 ; entry 3
    dw MetaSprites27Set70Frame4 ; entry 4
    dw MetaSprites27Set70Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set70; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set70Frame0::
Data_027_6FA4:: ; address name
    db $F0, $FF, $00, $20 ; entry 0
    db $F8, $F8, $01, $00 ; entry 1
    db $F8, $FF, $01, $20 ; entry 2
    db $F0, $F8, $00, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set70; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set70Frame1::
Data_027_6FB5:: ; address name
    db $EF, $F8, $02, $00 ; entry 0
    db $EF, $FF, $02, $20 ; entry 1
    db $F7, $F8, $03, $00 ; entry 2
    db $F7, $FF, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set70; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set70Frame2::
Data_027_6FC6:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set70; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set70Frame3::
Data_027_6FD7:: ; address name
    db $EF, $F8, $04, $00 ; entry 0
    db $EF, $00, $05, $00 ; entry 1
    db $F7, $F8, $08, $00 ; entry 2
    db $F7, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set70; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set70Frame4::
Data_027_6FE8:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $FF, $0A, $20 ; entry 1
    db $F8, $F8, $0B, $00 ; entry 2
    db $F8, $FF, $0B, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set70; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set70Frame5::
Data_027_6FF9:: ; address name
    db $EF, $F8, $0C, $00 ; entry 0
    db $EF, $FF, $0C, $20 ; entry 1
    db $F7, $F8, $0D, $00 ; entry 2
    db $F7, $FF, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 113 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set71::
Data_027_700A:: ; address name
    dw MetaSprites27Set71Frame0 ; entry 0
    dw MetaSprites27Set71Frame1 ; entry 1
    dw MetaSprites27Set71Frame2 ; entry 2
    dw MetaSprites27Set71Frame3 ; entry 3
    dw MetaSprites27Set71Frame4 ; entry 4
    dw MetaSprites27Set71Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set71; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set71Frame0::
Data_027_7016:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set71; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set71Frame1::
Data_027_7027:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $03, $00 ; entry 2
    db $F8, $00, $04, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set71; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set71Frame2::
Data_027_7038:: ; address name
    db $F0, $F8, $05, $00 ; entry 0
    db $F0, $00, $06, $00 ; entry 1
    db $F8, $F8, $07, $00 ; entry 2
    db $F8, $00, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set71; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set71Frame3::
Data_027_7049:: ; address name
    db $F0, $F8, $05, $00 ; entry 0
    db $F0, $00, $06, $00 ; entry 1
    db $F8, $F8, $09, $00 ; entry 2
    db $F8, $00, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set71; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set71Frame4::
Data_027_705A:: ; address name
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $FF, $0B, $20 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set71; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set71Frame5::
Data_027_706B:: ; address name
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $FF, $0B, $20 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 114 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set72::
Data_027_707C:: ; address name
    dw MetaSprites27Set72Frame0 ; entry 0
    dw MetaSprites27Set72Frame1 ; entry 1
    dw MetaSprites27Set72Frame2 ; entry 2
    dw MetaSprites27Set72Frame3 ; entry 3
    dw MetaSprites27Set72Frame4 ; entry 4
    dw MetaSprites27Set72Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set72; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set72Frame0::
Data_027_7088:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set72; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set72Frame1::
Data_027_7099:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $FF, $02, $20 ; entry 2
    db $F9, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set72; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set72Frame2::
Data_027_70AA:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set72; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set72Frame3::
Data_027_70BB:: ; address name
    db $F1, $F8, $04, $00 ; entry 0
    db $F1, $00, $05, $00 ; entry 1
    db $F9, $F8, $08, $00 ; entry 2
    db $F9, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set72; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set72Frame4::
Data_027_70CC:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set72; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set72Frame5::
Data_027_70DD:: ; address name
    db $F1, $F8, $0A, $00 ; entry 0
    db $F1, $00, $0B, $00 ; entry 1
    db $F9, $FF, $0C, $20 ; entry 2
    db $F9, $F7, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 115 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set73::
Data_027_70EE:: ; address name
    dw MetaSprites27Set73Frame0 ; entry 0
    dw MetaSprites27Set73Frame1 ; entry 1
    dw MetaSprites27Set73Frame2 ; entry 2
    dw MetaSprites27Set73Frame3 ; entry 3
    dw MetaSprites27Set73Frame4 ; entry 4
    dw MetaSprites27Set73Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set73; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set73Frame0::
Data_027_70FA:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set73; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set73Frame1::
Data_027_710B:: ; address name
    db $F0, $00, $00, $20 ; entry 0
    db $F0, $F8, $01, $20 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set73; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set73Frame2::
Data_027_711C:: ; address name
    db $F0, $F9, $04, $00 ; entry 0
    db $F0, $01, $05, $00 ; entry 1
    db $F8, $F9, $06, $00 ; entry 2
    db $F8, $01, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set73; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set73Frame3::
Data_027_712D:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set73; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set73Frame4::
Data_027_713E:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set73; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set73Frame5::
Data_027_714F:: ; address name
    db $F0, $00, $0A, $20 ; entry 0
    db $F0, $F8, $0B, $20 ; entry 1
    db $F8, $00, $0C, $20 ; entry 2
    db $F8, $F8, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 116 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set74::
Data_027_7160:: ; address name
    dw MetaSprites27Set74Frame0 ; entry 0
    dw MetaSprites27Set74Frame1 ; entry 1
    dw MetaSprites27Set74Frame2 ; entry 2
    dw MetaSprites27Set74Frame3 ; entry 3
    dw MetaSprites27Set74Frame4 ; entry 4
    dw MetaSprites27Set74Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set74; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set74Frame0::
Data_027_716C:: ; address name
    db $F0, $F8, $00, $10 ; entry 0
    db $F0, $00, $00, $30 ; entry 1
    db $F8, $F8, $01, $10 ; entry 2
    db $F8, $00, $02, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set74; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set74Frame1::
Data_027_717D:: ; address name
    db $F9, $F8, $04, $10 ; entry 0
    db $F9, $00, $05, $10 ; entry 1
    db $F1, $F8, $03, $10 ; entry 2
    db $F1, $00, $03, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set74; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set74Frame2::
Data_027_718E:: ; address name
    db $F0, $F8, $06, $10 ; entry 0
    db $F0, $00, $07, $10 ; entry 1
    db $F8, $F8, $08, $10 ; entry 2
    db $F8, $00, $09, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set74; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set74Frame3::
Data_027_719F:: ; address name
    db $F9, $F8, $0A, $10 ; entry 0
    db $F9, $00, $0B, $10 ; entry 1
    db $F1, $F9, $06, $10 ; entry 2
    db $F1, $01, $07, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set74; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set74Frame4::
Data_027_71B0:: ; address name
    db $F0, $F8, $0C, $10 ; entry 0
    db $F8, $F8, $0E, $10 ; entry 1
    db $F8, $00, $0F, $10 ; entry 2
    db $F0, $00, $0C, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set74; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set74Frame5::
Data_027_71C1:: ; address name
    db $F9, $00, $0E, $30 ; entry 0
    db $F9, $F8, $0F, $30 ; entry 1
    db $F1, $F8, $0D, $10 ; entry 2
    db $F1, $00, $0D, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 124 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set7C::
Data_027_71D2:: ; address name
    dw MetaSprites27Set7CFrame0 ; entry 0
    dw MetaSprites27Set7CFrame1 ; entry 1
    dw MetaSprites27Set7CFrame2 ; entry 2
    dw MetaSprites27Set7CFrame3 ; entry 3
    dw MetaSprites27Set7CFrame4 ; entry 4
    dw MetaSprites27Set7CFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set7C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set7CFrame0::
Data_027_71DE:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $FF, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set7C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set7CFrame1::
Data_027_71EF:: ; address name
    db $F0, $F8, $02, $00 ; entry 0
    db $F0, $FF, $02, $20 ; entry 1
    db $F8, $F8, $03, $00 ; entry 2
    db $F8, $FF, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set7C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set7CFrame2::
Data_027_7200:: ; address name
    db $F8, $F8, $06, $00 ; entry 0
    db $F8, $00, $07, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set7C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set7CFrame3::
Data_027_7211:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set7C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set7CFrame4::
Data_027_7222:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $FF, $0C, $20 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $FF, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set7C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set7CFrame5::
Data_027_7233:: ; address name
    db $F0, $F8, $0E, $00 ; entry 0
    db $F0, $FF, $0E, $20 ; entry 1
    db $F8, $F8, $0F, $00 ; entry 2
    db $F8, $FF, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 125 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set7D::
Data_027_7244:: ; address name
    dw MetaSprites27Set7DFrame0 ; entry 0
    dw MetaSprites27Set7DFrame1 ; entry 1
    dw MetaSprites27Set7DFrame2 ; entry 2
    dw MetaSprites27Set7DFrame3 ; entry 3
    dw MetaSprites27Set7DFrame4 ; entry 4
    dw MetaSprites27Set7DFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set7D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set7DFrame0::
Data_027_7250:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $01, $00 ; entry 1
    db $F0, $FF, $00, $20 ; entry 2
    db $F8, $FF, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set7D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set7DFrame1::
Data_027_7261:: ; address name
    db $F0, $F8, $02, $00 ; entry 0
    db $F0, $FF, $02, $20 ; entry 1
    db $F8, $F8, $03, $00 ; entry 2
    db $F8, $FF, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set7D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set7DFrame2::
Data_027_7272:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set7D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set7DFrame3::
Data_027_7283:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set7D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set7DFrame4::
Data_027_7294:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F8, $F8, $0D, $00 ; entry 1
    db $F0, $FF, $0C, $20 ; entry 2
    db $F8, $FF, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set7D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set7DFrame5::
Data_027_72A5:: ; address name
    db $F0, $F8, $0E, $00 ; entry 0
    db $F0, $FF, $0E, $20 ; entry 1
    db $F8, $F8, $0F, $00 ; entry 2
    db $F8, $FF, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 126 of MetaSprites27Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites27Set7E::
Data_027_72B6:: ; address name
    dw MetaSprites27Set7EFrame0 ; entry 0
    dw MetaSprites27Set7EFrame1 ; entry 1
    dw MetaSprites27Set7EFrame2 ; entry 2
    dw MetaSprites27Set7EFrame3 ; entry 3
    dw MetaSprites27Set7EFrame4 ; entry 4
    dw MetaSprites27Set7EFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites27Set7E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set7EFrame0::
Data_027_72C2:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites27Set7E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set7EFrame1::
Data_027_72D3:: ; address name
    db $F0, $00, $00, $20 ; entry 0
    db $F0, $F8, $01, $20 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites27Set7E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set7EFrame2::
Data_027_72E4:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites27Set7E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set7EFrame3::
Data_027_72F5:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites27Set7E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set7EFrame4::
Data_027_7306:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites27Set7E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites27Set7EFrame5::
Data_027_7317:: ; address name
    db $F0, $00, $0C, $20 ; entry 0
    db $F0, $F8, $0D, $20 ; entry 1
    db $F8, $00, $0E, $20 ; entry 2
    db $F8, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0143 (C1: on CGB, with hFFC8 = 0, DecompressGraphicsTemp0ToTemp4 copies the 8 bytes at 27:$7328 + 8 * monster id to wOBJPaletteBuffer + 8 * hFFC9; the count matches MonsterSpriteTable).
; record: one CGB OBJ palette: 4 BGR555 colours
MonsterSpritePalettes::
Data_027_7328:: ; address name
    dw $0000, $6BFF, $027F, $0800 ; id 0
    dw $0000, $6BFF, $027F, $0800 ; id 1 DrakSlime
    dw $0000, $6BFF, $035F, $0800 ; id 2 SpotSlime
    dw $0000, $01BF, $4BA0, $0800 ; id 3 WingSlime
    dw $0000, $03E2, $78B4, $0800 ; id 4 TreeSlime
    dw $0000, $6BFF, $0F8A, $0800 ; id 5 Snaily
    dw $0000, $6BFF, $3E60, $0800 ; id 6 SlimeNite
    dw $0000, $6BFF, $0F8A, $0800 ; id 7 Babble
    dw $0000, $6BFF, $0C7F, $0800 ; id 8 BoxSlime
    dw $0000, $6BFF, $6F40, $0800 ; id 9 PearlGel
    dw $0000, $6BFF, $7EA0, $0800 ; id 10 Slime
    dw $0000, $035F, $7CE1, $0800 ; id 11 Healer
    dw $0000, $027F, $4A60, $0800 ; id 12 FangSlime
    dw $0000, $3AD9, $0112, $0800 ; id 13 RockSlime
    dw $0000, $6BFF, $31AC, $0800 ; id 14 SlimeBorg
    dw $0000, $6BFF, $391F, $0800 ; id 15 Slabbit
    dw $0000, $031F, $7E42, $0800 ; id 16 KingSlime
    dw $0000, $6BFF, $2549, $0800 ; id 17 Metaly
    dw $0000, $6BFF, $296A, $0800 ; id 18 Metabble
    dw $0000, $6BFF, $031F, $0800 ; id 19 SpotKing
    dw $0000, $6BFF, $022A, $0800 ; id 20 TropicGel
    dw $0000, $03DF, $4472, $0800 ; id 21 MimeSlime
    dw $0000, $7FE0, $391C, $0800 ; id 22 HaloSlime
    dw $0000, $2A1F, $2549, $0800 ; id 23 MetalKing
    dw $0000, $1BFF, $029F, $0800 ; id 24 GoldSlime
    dw $0000, $6BFF, $0240, $0800 ; id 25 GranSlime
    dw $0000, $6BFF, $22DE, $0800 ; id 26 WonderEgg
    dw $0000, $6BFF, $027F, $0800 ; id 27 Butch
    dw $0000, $6BFF, $027F, $0800 ; id 28 ?
    dw $0000, $6BFF, $027F, $0800 ; id 29 ?
    dw $0000, $6BFF, $027F, $0800 ; id 30 ?
    dw $0000, $6BFF, $027F, $0800 ; id 31 ?
    dw $0000, $6BFF, $027F, $0800 ; id 32 ?
    dw $0000, $6BFF, $027F, $0800 ; id 33 ?
    dw $0000, $6BFF, $027F, $0800 ; id 34 ?
    dw $0000, $6BFF, $027F, $0800 ; id 35 ?
    dw $0000, $6BFF, $01DE, $0800 ; id 36 DragonKid
    dw $0000, $029F, $7E80, $0800 ; id 37 Tortragon
    dw $0000, $6BFF, $7371, $0800 ; id 38 Pteranod
    dw $0000, $03BF, $1C37, $0800 ; id 39 Gasgon
    dw $0000, $209D, $37E0, $0800 ; id 40 FairyDrak
    dw $0000, $6BFF, $6D48, $0800 ; id 41 LizardMan
    dw $0000, $6BFF, $02D7, $0800 ; id 42 Poisongon
    dw $0000, $6BFF, $7E00, $0800 ; id 43 Swordgon
    dw $0000, $6DE7, $7F20, $0800 ; id 44 Drygon
    dw $0000, $33BF, $32A0, $0800 ; id 45 Dragon
    dw $0000, $6BFF, $02BF, $0800 ; id 46 MiniDrak
    dw $0000, $6BFF, $7E80, $0800 ; id 47 MadDragon
    dw $0000, $6BFF, $02FF, $0800 ; id 48 Rayburn
    dw $0000, $0F7F, $06A0, $0800 ; id 49 Chamelgon
    dw $0000, $6BFF, $03B6, $0800 ; id 50 LizardFly
    dw $0000, $6B5A, $1525, $0800 ; id 51 Andreal
    dw $0000, $075F, $1479, $0800 ; id 52 KingCobra
    dw $3800, $6BFF, $71ED, $0800 ; id 53 Vampirus
    dw $3800, $6BFF, $030B, $0800 ; id 54 SnakeBat
    dw $0000, $6BFF, $3E51, $0800 ; id 55 Spikerous
    dw $0000, $075C, $0A3D, $0800 ; id 56 GreatDrak
    dw $0000, $007F, $06C5, $0800 ; id 57 Crestpent
    dw $0000, $033F, $7E60, $0800 ; id 58 WingSnake
    dw $0000, $1F00, $015A, $0800 ; id 59 Coatol
    dw $0000, $6BFF, $0286, $0800 ; id 60 Orochi
    dw $0000, $037F, $076F, $0800 ; id 61 BattleRex
    dw $0000, $6BFF, $023D, $0800 ; id 62 SkyDragon
    dw $0000, $7F20, $001D, $0800 ; id 63 Serpentia
    dw $0000, $6BFF, $1BEC, $0800 ; id 64 Divinegon
    dw $0000, $6BFF, $01CF, $0800 ; id 65 Orligon
    dw $0000, $6BFF, $155E, $0800 ; id 66 GigaDraco
    dw $0000, $6BFF, $01DE, $0800 ; id 67 ?
    dw $0000, $6BFF, $01DE, $0800 ; id 68 ?
    dw $0000, $6BFF, $01DE, $0800 ; id 69 ?
    dw $0000, $6BFF, $01DE, $0800 ; id 70 ?
    dw $0000, $7F00, $021A, $0800 ; id 71 Tonguella
    dw $0000, $6BFF, $7CB8, $0800 ; id 72 Almiraj
    dw $0000, $6BFF, $01FF, $0800 ; id 73 CatFly
    dw $0000, $02D3, $15FF, $0800 ; id 74 PillowRat
    dw $0000, $6BFF, $0176, $0800 ; id 75 Saccer
    dw $0000, $6BFF, $0270, $0800 ; id 76 GulpBeast
    dw $0000, $6BFF, $033F, $0800 ; id 77 Skullroo
    dw $0000, $6BFF, $7F00, $0800 ; id 78 WindBeast
    dw $0000, $6BFF, $027D, $0800 ; id 79 Beavern
    dw $0000, $075F, $7DC7, $0800 ; id 80 Antbear
    dw $0000, $025F, $7C15, $0800 ; id 81 SuperTen
    dw $0000, $03E8, $00D6, $0800 ; id 82 IronTurt
    dw $0000, $035F, $4A53, $0800 ; id 83 Mommonja
    dw $0000, $01B6, $1B9F, $0800 ; id 84 HammerMan
    dw $0000, $6BFF, $422E, $0800 ; id 85 Grizzly
    dw $0000, $6BFF, $455F, $0800 ; id 86 Yeti
    dw $3800, $6BFF, $5293, $0800 ; id 87 ArrowDog
    dw $3800, $6BFF, $3416, $0800 ; id 88 NoctoKing
    dw $0000, $7FFF, $1CFF, $0800 ; id 89 BeastNite
    dw $0000, $6BFF, $7A87, $0800 ; id 90 MadGopher
    dw $0000, $1B9F, $753C, $0800 ; id 91 FairyRat
    dw $0000, $6BFF, $5A17, $0800 ; id 92 Unicorn
    dw $0000, $1B9F, $75A0, $0800 ; id 93 Goategon
    dw $0000, $075F, $6475, $0800 ; id 94 WildApe
    dw $0000, $7C1F, $76F0, $0800 ; id 95 Trumpeter
    dw $0000, $6BFF, $7EE4, $0800 ; id 96 KingLeo
    dw $0000, $02BF, $7EDC, $0800 ; id 97 DarkHorn
    dw $0000, $03BF, $01BF, $0800 ; id 98 MadCat
    dw $0000, $6BFF, $01D8, $0800 ; id 99 BigEye
    dw $0000, $7FFF, $027D, $0800 ; id 100 Gorago
    dw $0000, $4E52, $01D8, $0800 ; id 101 CatMage
    dw $0000, $025F, $451E, $0800 ; id 102 Dumbira
    dw $0000, $7F00, $021A, $0800 ; id 103 ?
    dw $0000, $7F00, $021A, $0800 ; id 104 ?
    dw $0000, $7F00, $021A, $0800 ; id 105 ?
    dw $0000, $201F, $02FE, $0800 ; id 106 Picky
    dw $0000, $5EF8, $011B, $0800 ; id 107 Wyvern
    dw $0000, $03DF, $2CC6, $0800 ; id 108 BullBird
    dw $0000, $7D10, $1857, $0800 ; id 109 Florajay
    dw $0000, $6BFF, $3C9F, $0800 ; id 110 DuckKite
    dw $0000, $7C1F, $01FF, $0800 ; id 111 MadPecker
    dw $0000, $7DD6, $02BB, $0800 ; id 112 MadRaven
    dw $0000, $077F, $00DF, $0800 ; id 113 MistyWing
    dw $0000, $7EE0, $02BF, $0800 ; id 114 AquaHawk
    dw $0000, $6BFF, $007B, $0800 ; id 115 Dracky
    dw $0000, $03E0, $540E, $0800 ; id 116 KiteHawk
    dw $0000, $37DF, $3037, $0800 ; id 117 BigRoost
    dw $0000, $0FBF, $7DE0, $0800 ; id 118 StubBird
    dw $0000, $6BFF, $483B, $0800 ; id 119 LandOwl
    dw $0000, $0218, $0FBF, $0800 ; id 120 MadGoose
    dw $0000, $51F8, $6BFF, $0800 ; id 121 MadCondor
    dw $0000, $009F, $7D40, $0800 ; id 122 Emyu
    dw $0000, $66D4, $6BFF, $0800 ; id 123 Blizzardy
    dw $0000, $179F, $00BB, $0800 ; id 124 Phoenix
    dw $0000, $03FD, $7D2F, $0800 ; id 125 ZapBird
    dw $0000, $037F, $6566, $0800 ; id 126 Garudian
    dw $0000, $179F, $0033, $0800 ; id 127 WhipBird
    dw $0000, $179F, $7F69, $0800 ; id 128 FunkyBird
    dw $0000, $179F, $3C1F, $0800 ; id 129 RainHawk
    dw $0000, $039F, $1FD3, $0800 ; id 130 Azurile
    dw $0000, $039F, $5CEF, $0800 ; id 131 Shantak
    dw $0000, $077F, $7EA0, $0800 ; id 132 CragDevil
    dw $0000, $201F, $02FE, $0800 ; id 133 ?
    dw $0000, $201F, $02FE, $0800 ; id 134 ?
    dw $0000, $201F, $02FE, $0800 ; id 135 ?
    dw $0000, $201F, $02FE, $0800 ; id 136 ?
    dw $0000, $201F, $02FE, $0800 ; id 137 ?
    dw $0000, $201F, $02FE, $0800 ; id 138 ?
    dw $0000, $201F, $02FE, $0800 ; id 139 ?
    dw $0000, $201F, $02FE, $0800 ; id 140 ?
    dw $0000, $031E, $038D, $0800 ; id 141 MadPlant
    dw $0000, $7D35, $2FEB, $0800 ; id 142 FireWeed
    dw $0000, $7F4F, $60B2, $0800 ; id 143 FloraMan
    dw $0000, $640E, $02F1, $0800 ; id 144 WingTree
    dw $0000, $6BFF, $032A, $0800 ; id 145 CactiBall
    dw $0000, $6BFF, $038D, $0800 ; id 146 Gulpple
    dw $0000, $6BFF, $6891, $0800 ; id 147 Toadstool
    dw $0000, $7E19, $01FF, $0800 ; id 148 AmberWeed
    dw $0000, $6BFF, $0320, $0800 ; id 149 Slurperon
    dw $0000, $6BFF, $0110, $0800 ; id 150 Stubsuck
    dw $0000, $02DF, $02ED, $0800 ; id 151 Oniono
    dw $0000, $0360, $025F, $0800 ; id 152 DanceVegi
    dw $0000, $6FF1, $012F, $0800 ; id 153 TreeBoy
    dw $0000, $6BFF, $0115, $0800 ; id 154 Devipine
    dw $0000, $001F, $0217, $0800 ; id 155 FaceTree
    dw $0000, $02C0, $0217, $0800 ; id 156 HerbMan
    dw $0000, $033F, $032C, $0800 ; id 157 BeanMan
    dw $0000, $6BFF, $021F, $0800 ; id 158 EvilSeed
    dw $0000, $03AA, $005B, $0800 ; id 159 ManEater
    dw $0000, $6BFF, $01C8, $0800 ; id 160 Snapper
    dw $0000, $6BFF, $2A16, $0800 ; id 161 GhosTree
    dw $0000, $001F, $036C, $0800 ; id 162 Rosevine
    dw $0000, $036C, $296D, $0800 ; id 163 Egdracil
    dw $0000, $6E5F, $6017, $0800 ; id 164 Warubou
OBJPaletteBufferPlus18Data_27_7850:: ; heuristic: argument of a bank-switching copy helper; C0
Data_027_7850:: ; address name
    dw $0000, $7FB5, $7EA6, $0800 ; id 165 Watabou
    dw $0000, $7FFF, $6CD6, $0800 ; id 166 Eggplaton
    dw $0000, $02FF, $024A, $0800 ; id 167 FooHero
    dw $0000, $031E, $038D, $0800 ; id 168 ?
    dw $0000, $031E, $038D, $0800 ; id 169 ?
    dw $0000, $031E, $038D, $0800 ; id 170 ?
    dw $0000, $031E, $038D, $0800 ; id 171 ?
    dw $0000, $031E, $038D, $0800 ; id 172 ?
    dw $0000, $031E, $038D, $0800 ; id 173 ?
    dw $0000, $031E, $038D, $0800 ; id 174 ?
    dw $0000, $031E, $038D, $0800 ; id 175 ?
    dw $0000, $475F, $0275, $0800 ; id 176 GiantSlug
    dw $0000, $7DDF, $034B, $0800 ; id 177 Catapila
    dw $0000, $371F, $01DC, $0800 ; id 178 Gophecada
    dw $0000, $7FFF, $7CB7, $0800 ; id 179 Butterfly
    dw $0000, $63F4, $36C0, $0800 ; id 180 WeedBug
    dw $0000, $729F, $3CFB, $0800 ; id 181 GiantWorm
    dw $0000, $4EFF, $034F, $0800 ; id 182 Lipsy
    dw $0000, $6980, $0258, $0800 ; id 183 StagBug
    dw $0000, $427F, $017F, $0800 ; id 184 Pyuro
    dw $0000, $7FFF, $3F01, $0800 ; id 185 ArmyAnt
    dw $0000, $7FFF, $029D, $0800 ; id 186 GoHopper
    dw $0000, $3EB8, $3538, $0800 ; id 187 TailEater
    dw $0000, $7FFF, $013F, $0800 ; id 188 ArmorPede
    dw $0000, $7FFF, $027F, $0800 ; id 189 Eyeder
    dw $0000, $1B5D, $0278, $0800 ; id 190 GiantMoth
    dw $0000, $627F, $3157, $0800 ; id 191 Droll
    dw $0000, $7FFF, $01BF, $0800 ; id 192 ArmyCrab
    dw $0000, $7FFF, $021D, $0800 ; id 193 MadHornet
    dw $0000, $037F, $601A, $0800 ; id 194 Belzebub
    dw $0000, $037F, $0208, $0800 ; id 195 WarMantis
    dw $0000, $0218, $00D0, $0800 ; id 196 HornBeet
    dw $0000, $6BFF, $2BE0, $0800 ; id 197 Sickler
    dw $0000, $6BFF, $017D, $0800 ; id 198 Armorpion
    dw $0000, $6BFF, $04BD, $0800 ; id 199 Digster
    dw $0000, $6BFF, $541F, $0800 ; id 200 Skularach
    dw $0000, $7FFF, $017D, $0800 ; id 201 MultiEyes
    dw $0000, $475F, $0275, $0800 ; id 202 ?
    dw $0000, $475F, $0275, $0800 ; id 203 ?
    dw $0000, $475F, $0275, $0800 ; id 204 ?
    dw $0000, $475F, $0275, $0800 ; id 205 ?
    dw $0000, $475F, $0275, $0800 ; id 206 ?
    dw $0000, $475F, $0275, $0800 ; id 207 ?
    dw $0000, $475F, $0275, $0800 ; id 208 ?
    dw $0000, $475F, $0275, $0800 ; id 209 ?
    dw $0000, $475F, $0275, $0800 ; id 210 ?
    dw $0000, $6BFF, $7DC0, $0800 ; id 211 Pixy
    dw $0000, $6BFF, $7A00, $0800 ; id 212 MedusaEye
    dw $0000, $6BFF, $7EE7, $0800 ; id 213 AgDevil
    dw $0000, $6BFF, $023F, $0800 ; id 214 Demonite
    dw $0000, $6BFF, $7D57, $0800 ; id 215 DarkEye
    dw $0000, $6BFF, $7EA4, $0800 ; id 216 EyeBall
    dw $0000, $6BFF, $029F, $0800 ; id 217 SkulRider
    dw $0000, $6BFF, $6A18, $0800 ; id 218 EvilBeast
    dw $0000, $6BFF, $170E, $0800 ; id 219 Bubblemon
    dw $0000, $179F, $009B, $0800 ; id 220 1EyeClown
    dw $0000, $71BC, $179F, $0800 ; id 221 Gremlin
    dw $0000, $179F, $64B9, $0800 ; id 222 ArcDemon
    dw $0000, $6BFF, $023C, $0800 ; id 223 Lionex
    dw $0000, $6BFF, $011C, $0800 ; id 224 GoatHorn
    dw $0000, $6BFF, $025D, $0800 ; id 225 Orc
    dw $0000, $6BFF, $0F68, $0800 ; id 226 Ogre
    dw $0000, $179F, $5917, $0800 ; id 227 GateGuard
    dw $0000, $6BFF, $7D8E, $0800 ; id 228 ChopClown
    dw $0000, $6BFF, $032B, $0800 ; id 229 BossTroll
    dw $0000, $6BFF, $7EA0, $0800 ; id 230 Grendal
    dw $0000, $6BFF, $029F, $0800 ; id 231 Akubar
    dw $0000, $6BFF, $3544, $0800 ; id 232 MadKnight
    dw $0000, $6BFF, $001B, $0800 ; id 233 EvilWell
    dw $0000, $6BE0, $6580, $0800 ; id 234 Gigantes
    dw $0000, $0F7F, $7720, $0800 ; id 235 Centasaur
    dw $0000, $6BFF, $001D, $0800 ; id 236 EvilArmor
    dw $0000, $179F, $5A53, $0800 ; id 237 Jamirus
    dw $0000, $6BFF, $01DF, $0800 ; id 238 Durran
    dw $0000, $6BFF, $3C73, $0800 ; id 239 Titanis
    dw $0000, $6BFF, $748F, $0800 ; id 240 LampGenie
    dw $0000, $6BFF, $7DC0, $0800 ; id 241 ?
    dw $0000, $6BFF, $7DC0, $0800 ; id 242 ?
    dw $0000, $6BFF, $7DC0, $0800 ; id 243 ?
    dw $0000, $6BFF, $7DC0, $0800 ; id 244 ?
    dw $0000, $6BFF, $7DC0, $0800 ; id 245 ?
    dw $0000, $029F, $011E, $0800 ; id 246 Spooky
    dw $0000, $42DC, $1992, $0800 ; id 247 Skullgon
    dw $0000, $7FFF, $7A20, $0800 ; id 248 PutrePup
    dw $0000, $531E, $4472, $0800 ; id 249 RotRaven
    dw $0000, $7E7F, $70F5, $0800 ; id 250 Mummy
    dw $0000, $7FFF, $5CCA, $0800 ; id 251 DarkCrab
    dw $0000, $7FFF, $0196, $0800 ; id 252 DeadNite
    dw $0000, $02BF, $420B, $0800 ; id 253 Shadow
    dw $0000, $6BFF, $601A, $0800 ; id 254 Skulpent
    dw $0000, $7FFF, $0196, $0800 ; id 255 Hork
    dw $0000, $03BF, $0219, $0800 ; id 256 Mudron
    dw $0000, $33FF, $027C, $0800 ; id 257 NiteWhip
    dw $0000, $03FF, $7F46, $0800 ; id 258 WindMerge
    dw $0000, $6ABF, $021D, $0800 ; id 259 Reaper
    dw $0000, $7F00, $2A16, $0800 ; id 260 Inverzon
    dw $0000, $7F00, $7D80, $0800 ; id 261 FoxFire
    dw $0000, $6BFF, $001D, $0800 ; id 262 CaptDead
    dw $0000, $7FFF, $7D88, $0800 ; id 263 DeadNoble
    dw $0000, $7E5F, $447B, $0800 ; id 264 WhiteKing
    dw $0000, $3F1C, $017E, $0800 ; id 265 BoneSlave
    dw $0000, $7FFF, $7571, $0800 ; id 266 Skeletor
    dw $0000, $7FFF, $28D0, $0800 ; id 267 Servant
    dw $0000, $007F, $7C15, $0800 ; id 268 Lazamanus
    dw $0000, $035F, $021C, $0800 ; id 269 Copycat
    dw $0000, $7FFF, $68F8, $0800 ; id 270 MadSpirit
    dw $0000, $02DD, $501F, $0800 ; id 271 PomPomBom
    dw $0000, $135F, $3C1D, $0800 ; id 272 Niterich
    dw $0000, $029F, $011E, $0800 ; id 273 ?
    dw $0000, $029F, $011E, $0800 ; id 274 ?
    dw $0000, $029F, $011E, $0800 ; id 275 ?
    dw $0000, $029F, $011E, $0800 ; id 276 ?
    dw $0000, $029F, $011E, $0800 ; id 277 ?
    dw $0000, $029F, $011E, $0800 ; id 278 ?
    dw $0000, $029F, $011E, $0800 ; id 279 ?
    dw $0000, $029F, $011E, $0800 ; id 280 ?
    dw $0000, $33FF, $023F, $0800 ; id 281 JewelBag
    dw $0000, $4B7F, $021A, $0800 ; id 282 EvilWand
    dw $0000, $6BFF, $021F, $0800 ; id 283 MadCandle
    dw $0000, $033F, $01FD, $0800 ; id 284 CoilBird
    dw $0000, $439F, $190F, $0800 ; id 285 Facer
    dw $0000, $6BFF, $036D, $0800 ; id 286 SpikyBoy
    dw $0000, $439F, $1417, $0800 ; id 287 MadMirror
    dw $0000, $7ED9, $0038, $0800 ; id 288 RogueNite
    dw $0000, $3B5E, $170E, $0800 ; id 289 Puppetor
    dw $0000, $3B5E, $025C, $0800 ; id 290 Goopi
    dw $0000, $03FF, $5815, $0800 ; id 291 Voodoll
    dw $0000, $6BFF, $7F54, $0800 ; id 292 MetalDrak
    dw $0000, $03FF, $38ED, $0800 ; id 293 Balzak
    dw $0000, $6BFF, $7F0B, $0800 ; id 294 SabreMan
    dw $0000, $6BFF, $02BF, $0800 ; id 295 CurseLamp
    dw $0000, $3B5E, $0160, $0800 ; id 296 Brushead
    dw $0000, $6BFF, $7EC5, $0800 ; id 297 Roboster
    dw $0000, $6BFF, $7DC0, $0800 ; id 298 Roboster2
    dw $0000, $7D9F, $025C, $0800 ; id 299 EvilPot
    dw $0000, $6BFF, $4DCD, $0800 ; id 300 Gismo
    dw $0000, $6BFF, $0018, $0800 ; id 301 LavaMan
    dw $0000, $6BFF, $7E09, $0800 ; id 302 IceMan
    dw $0000, $7F15, $59EC, $0800 ; id 303 Mimic
    dw $0000, $6BFF, $7EEC, $0800 ; id 304 Exaucers
    dw $0000, $1EBC, $01B7, $0800 ; id 305 MudDoll
    dw $0000, $6BFF, $025B, $0800 ; id 306 Golem
    dw $0000, $6BFF, $3A73, $0800 ; id 307 StoneMan
    dw $0000, $6BFF, $6186, $0800 ; id 308 BombCrag
    dw $0000, $6BFF, $02FF, $0800 ; id 309 GoldGolem
    dw $0000, $00DF, $7969, $0800 ; id 310 DarkMate
    dw $0000, $7FFF, $7D00, $0800 ; id 311 ProtoMech
    dw $0000, $7FFF, $7E87, $0800 ; id 312 CloudKing
    dw $0000, $33FF, $023F, $0800 ; id 313 ?
    dw $0000, $33FF, $023F, $0800 ; id 314 ?
    dw $0000, $33FF, $023F, $0800 ; id 315 ?
    dw $0000, $6BFF, $6C17, $0800 ; id 316 Petiteel
    dw $0000, $7D80, $023F, $0800 ; id 317 Moray
    dw $0000, $6BFF, $169F, $0800 ; id 318 WalrusMan
    dw $0000, $6BFF, $1C1C, $0800 ; id 319 RayGigas
    dw $0000, $6BFF, $0099, $0800 ; id 320 Anemon
    dw $0000, $6BFF, $5413, $0800 ; id 321 Aquarella
    dw $0000, $6BFF, $65AB, $0800 ; id 322 Merman
    dw $0000, $6BFF, $493F, $0800 ; id 323 Octokid
    dw $0000, $7FFF, $24D3, $0800 ; id 324 PutreFish
    dw $0000, $033F, $7230, $0800 ; id 325 Octoreach
    dw $0000, $6BFF, $2552, $0800 ; id 326 Angleron
    dw $0000, $6BFF, $7F00, $0800 ; id 327 FishRider
    dw $0000, $6BFF, $60A3, $0800 ; id 328 RushFish
    dw $0000, $6BFF, $007F, $0800 ; id 329 Gamanian
    dw $0000, $6BFF, $027B, $0800 ; id 330 Clawster
    dw $0000, $6BFF, $017F, $0800 ; id 331 CancerMan
    dw $0000, $6BFF, $5182, $0800 ; id 332 RogueWave
    dw $0000, $6BFF, $74DB, $0800 ; id 333 Scallopa
    dw $0000, $6BFF, $5413, $0800 ; id 334 SeaHorse
    dw $0000, $6BE8, $281B, $0800 ; id 335 HoodSquid
    dw $0000, $6BFF, $02FF, $0800 ; id 336 MerTiger
    dw $0000, $6BFF, $7E40, $0800 ; id 337 AxeShark
    dw $0000, $6BFF, $7DCD, $0800 ; id 338 Octogon
    dw $0000, $6BFF, $7D5A, $0800 ; id 339 KingSquid
    dw $0000, $6BFF, $021F, $0800 ; id 340 Digong
    dw $0000, $6BFF, $5413, $0800 ; id 341 WhaleMage
    dw $0000, $037F, $69EE, $0800 ; id 342 Aquadon
    dw $0000, $039F, $005B, $0800 ; id 343 Octoraid
    dw $0000, $03DF, $0AC3, $0800 ; id 344 Grakos
    dw $0000, $6BFF, $0320, $0800 ; id 345 Poseidon
    dw $0000, $7FFF, $0240, $0800 ; id 346 Pumpoise
    dw $0000, $56A0, $1859, $0800 ; id 347 Starfish
    dw $0000, $6BFF, $6C17, $0800 ; id 348 ?
    dw $0000, $6BFF, $6C17, $0800 ; id 349 ?
    dw $0000, $6BFF, $6C17, $0800 ; id 350 ?
    dw $0000, $6BFF, $4414, $0800 ; id 351 DracoLord
    dw $0000, $019F, $6C73, $0800 ; id 352 DracoLord
    dw $0000, $6BFF, $653B, $0800 ; id 353 LordDraco
    dw $0000, $6BFF, $6C1A, $0800 ; id 354 Hargon
    dw $0000, $019F, $7E20, $0800 ; id 355 Sidoh
    dw $0000, $02BF, $51D4, $0800 ; id 356 Genosidoh
    dw $0000, $03E9, $6939, $0800 ; id 357 Baramos
    dw $0000, $6BFF, $015C, $0800 ; id 358 Zoma
    dw $0000, $6BFF, $75A0, $0800 ; id 359 AsuraZoma
    dw $0000, $6BFF, $0E71, $0800 ; id 360 Pizzaro
    dw $0000, $03E9, $60DD, $0800 ; id 361 PsychoPiz
    dw $0000, $6BFF, $00BF, $0800 ; id 362 Esterk
    dw $0000, $6BFF, $0310, $0800 ; id 363 Mirudraas
    dw $0000, $6BFF, $493F, $0800 ; id 364 Mirudraas
    dw $0000, $325F, $02E0, $0800 ; id 365 Mudou
    dw $0000, $6BFF, $493F, $0800 ; id 366 DeathMore
    dw $0000, $6BFF, $493F, $0800 ; id 367 DeathMore
    dw $0000, $03FF, $493F, $0800 ; id 368 DeathMore
    dw $0000, $425A, $0553, $0800 ; id 369 Darkdrium
    dw $0000, $6F7B, $480D, $0800 ; id 370 Orgodemir
    dw $0000, $6F7B, $3EA8, $0800 ; id 371 Orgodemir
    dw $0000, $6BFF, $021F, $0800 ; id 372 Darck
    dw $0000, $6BFF, $4414, $0800 ; id 373 Tatsu
    dw $0000, $6BFF, $4414, $0800 ; id 374 Diago
    dw $0000, $6BFF, $4414, $0800 ; id 375 Samsi
    dw $0000, $6BFF, $4414, $0800 ; id 376 Bazoo
    dw $0000, $6BFF, $4414, $0800 ; id 377 ?
    dw $0000, $6BFF, $4414, $0800 ; id 378 ?
    dw $0000, $6BFF, $4414, $0800 ; id 379 ?
    dw $0000, $6BFF, $009F, $0800 ; id 380 Lamia
    dw $0000, $6BFF, $6F50, $0800 ; id 381 Dimensaur
    dw $0000, $331F, $021F, $0800 ; id 382 Kagebou
    dw $0000, $0000, $0000, $0000 ; id 383 ?
    ds $D8, $00
