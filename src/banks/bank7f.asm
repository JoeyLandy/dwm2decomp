SECTION "Bank 7F", ROMX[$4000], BANK[$7F]
    db $7F

; DrawMetaSpriteAt_40CC with DE = Data_07F_4008 (E-0116)
; 3 call sites from 3 routines (e.g. UpdateAndDrawSpriteSlots, DrawFollowerSpriteIfFlag1B, AdvancePlayerAnimCounterAndRunPlayerSpriteMode_IsFadingAtMap5AScreen00Y80)
DrawMetaSprite4008::
Func_07F_4001:: ; address name
    ld de, MetaSprites7F_4008Table
    call DrawMetaSpriteAt_40CC
    ret

; E-0147 (C1: the caller of DrawMetaSprite4008 passes DE = $7F:4008; the builder takes the word at DE + 2 * hSpriteSetIndex as the set and the word at set + 2 * hSpriteSubIndex as the frame; 98 words, up to the next code or data).
; record: meta-sprite set
MetaSprites7F_4008Table::
Data_07F_4008:: ; address name
    dw MetaSprites7F_4008Set00 ; id 0
    dw MetaSprites7F_4008Set01 ; id 1
    dw MetaSprites7F_4008Set02 ; id 2
    dw MetaSprites7F_4008Set03 ; id 3
    dw MetaSprites7F_4008Set04 ; id 4
    dw MetaSprites7F_4008Set05 ; id 5
    dw MetaSprites7F_4008Set06 ; id 6
    dw MetaSprites7F_4008Set07 ; id 7
    dw MetaSprites7F_4008Set08 ; id 8
    dw MetaSprites7F_4008Set09 ; id 9
    dw MetaSprites7F_4008Set0A ; id 10
    dw MetaSprites7F_4008Set0B ; id 11
    dw MetaSprites7F_4008Set0C ; id 12
    dw MetaSprites7F_4008Set0D ; id 13
    dw MetaSprites7F_4008Set0E ; id 14
    dw MetaSprites7F_4008Set0F ; id 15
    dw MetaSprites7F_4008Set10 ; id 16
    dw MetaSprites7F_4008Set11 ; id 17
    dw MetaSprites7F_4008Set12 ; id 18
    dw MetaSprites7F_4008Set13 ; id 19
    dw MetaSprites7F_4008Set14 ; id 20
    dw MetaSprites7F_4008Set15 ; id 21
    dw MetaSprites7F_4008Set16 ; id 22
    dw MetaSprites7F_4008Set17 ; id 23
    dw MetaSprites7F_4008Set18 ; id 24
    dw MetaSprites7F_4008Set19 ; id 25
    dw MetaSprites7F_4008Set1A ; id 26
    dw MetaSprites7F_4008Set1B ; id 27
    dw MetaSprites7F_4008Set1C ; id 28
    dw MetaSprites7F_4008Set1D ; id 29
    dw MetaSprites7F_4008Set1E ; id 30
    dw MetaSprites7F_4008Set1F ; id 31
    dw MetaSprites7F_4008Set20 ; id 32
    dw MetaSprites7F_4008Set21 ; id 33
    dw MetaSprites7F_4008Set22 ; id 34
    dw MetaSprites7F_4008Set23 ; id 35
    dw MetaSprites7F_4008Set24 ; id 36
    dw MetaSprites7F_4008Set25 ; id 37
    dw MetaSprites7F_4008Set26 ; id 38
    dw MetaSprites7F_4008Set27 ; id 39
    dw MetaSprites7F_4008Set28 ; id 40
    dw MetaSprites7F_4008Set29 ; id 41
    dw MetaSprites7F_4008Set2A ; id 42
    dw MetaSprites7F_4008Set2B ; id 43
    dw MetaSprites7F_4008Set2C ; id 44
    dw MetaSprites7F_4008Set2D ; id 45
    dw MetaSprites7F_4008Set2E ; id 46
    dw MetaSprites7F_4008Set2F ; id 47
    dw MetaSprites7F_4008Set30 ; id 48
    dw MetaSprites7F_4008Set31 ; id 49
    dw MetaSprites7F_4008Set32 ; id 50
    dw MetaSprites7F_4008Set33 ; id 51
    dw MetaSprites7F_4008Set34 ; id 52
    dw MetaSprites7F_4008Set35 ; id 53
    dw MetaSprites7F_4008Set36 ; id 54
    dw MetaSprites7F_4008Set37 ; id 55
    dw MetaSprites7F_4008Set38 ; id 56
    dw MetaSprites7F_4008Set39 ; id 57
    dw MetaSprites7F_4008Set3A ; id 58
    dw MetaSprites7F_4008Set3B ; id 59
    dw MetaSprites7F_4008Set3C ; id 60
    dw MetaSprites7F_4008Set3D ; id 61
    dw MetaSprites7F_4008Set3E ; id 62
    dw MetaSprites7F_4008Set3F ; id 63
    dw MetaSprites7F_4008Set40 ; id 64
    dw MetaSprites7F_4008Set41 ; id 65
    dw MetaSprites7F_4008Set42 ; id 66
    dw MetaSprites7F_4008Set43 ; id 67
    dw MetaSprites7F_4008Set44 ; id 68
    dw MetaSprites7F_4008Set45 ; id 69
    dw MetaSprites7F_4008Set46 ; id 70
    dw MetaSprites7F_4008Set47 ; id 71
    dw MetaSprites7F_4008Set48 ; id 72
    dw MetaSprites7F_4008Set49 ; id 73
    dw MetaSprites7F_4008Set4A ; id 74
    dw MetaSprites7F_4008Set4B ; id 75
    dw MetaSprites7F_4008Set4C ; id 76
    dw MetaSprites7F_4008Set4D ; id 77
    dw MetaSprites7F_4008Set4E ; id 78
    dw MetaSprites7F_4008Set4F ; id 79
    dw MetaSprites7F_4008Set50 ; id 80
    dw MetaSprites7F_4008Set51 ; id 81
    dw MetaSprites7F_4008Set52 ; id 82
    dw MetaSprites7F_4008Set53 ; id 83
    dw MetaSprites7F_4008Set54 ; id 84
    dw MetaSprites7F_4008Set55 ; id 85
    dw MetaSprites7F_4008Set56 ; id 86
    dw MetaSprites7F_4008Set57 ; id 87
    dw MetaSprites7F_4008Set58 ; id 88
    dw MetaSprites7F_4008Set59 ; id 89
    dw MetaSprites7F_4008Set5A ; id 90
    dw MetaSprites7F_4008Set5B ; id 91
    dw MetaSprites7F_4008Set5C ; id 92
    dw MetaSprites7F_4008Set46 ; id 93
    dw MetaSprites7F_4008Set46 ; id 94
    dw MetaSprites7F_4008Set5F ; id 95
    dw MetaSprites7F_4008Set46 ; id 96
    dw MetaSprites7F_4008Set61 ; id 97

; the same instruction sequence as DrawMetaSpriteAt (bank $7F) apart from label operands, which refer to this bank's own routines and tables; the twin's note describes the shape (E-0107)
; 1 call site from 1 routine (e.g. DrawMetaSprite4008)
; reads: hOamNextEntry, hSpriteScrollYLo, hSpriteScrollYHi, hSpriteOriginY, hSpriteOriginYHi, hSpriteScrollXLo, hSpriteScrollXHi, hSpriteOriginX, ...
; writes: hMetaSpriteYLo, hMetaSpriteYHi, hOamNextEntry
; points at: hMetaSpriteXLo
DrawMetaSpriteAt_40CC::
Func_07F_40CC:: ; address name
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
    jp nz, Jump_07F_4216
    ldh a, [hSpriteTileOffset]
    ld c, a
    ldh a, [hSpriteAttrXor]
    and a, $20
    jr nz, Jump_07F_419E

Jump_07F_4128::
    ld a, [hl+]
    cp a, $80
    ret z
    ld b, a
    jr nc, Jump_07F_4140
    ldh a, [hMetaSpriteYLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteYHi]
    adc a, $00
    jr nz, Jump_07F_414F
    ld a, b
    cp a, $A8
    jr c, Jump_07F_4154
    jr Jump_07F_414F

Jump_07F_4140::
    ldh a, [hMetaSpriteYLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteYHi]
    adc a, $FF
    jr nz, Jump_07F_414F
    ld a, b
    cp a, $A8
    jr c, Jump_07F_4154

Jump_07F_414F::
    inc hl
    inc hl
    inc hl
    jr Jump_07F_4128

Jump_07F_4154::
    ld a, b
    ld [de], a
    inc e
    ld a, [hl+]
    ld b, a
    rlca
    jr c, Jump_07F_416D
    ldh a, [hMetaSpriteXLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteXHi]
    adc a, $00
    jr nz, Jump_07F_417C
    ld a, b
    cp a, $B8
    jr c, Jump_07F_4183
    jr Jump_07F_417C

Jump_07F_416D::
    ldh a, [hMetaSpriteXLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteXHi]
    adc a, $FF
    jr nz, Jump_07F_417C
    ld a, b
    cp a, $B8
    jr c, Jump_07F_4183

Jump_07F_417C::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_07F_4128

Jump_07F_4183::
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
    jr nz, Jump_07F_4128
    ret

Jump_07F_419E::
    ld a, [hl+]
    cp a, $80
    ret z
    ld b, a
    jr nc, Jump_07F_41B6
    ldh a, [hMetaSpriteYLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteYHi]
    adc a, $00
    jr nz, Jump_07F_41C5
    ld a, b
    cp a, $A8
    jr c, Jump_07F_41CA
    jr Jump_07F_41C5

Jump_07F_41B6::
    ldh a, [hMetaSpriteYLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteYHi]
    adc a, $FF
    jr nz, Jump_07F_41C5
    ld a, b
    cp a, $A8
    jr c, Jump_07F_41CA

Jump_07F_41C5::
    inc hl
    inc hl
    inc hl
    jr Jump_07F_419E

Jump_07F_41CA::
    ld a, b
    ld [de], a
    inc e
    ld a, [hl+]
    ld b, a
    rlca
    jr c, Jump_07F_41E5
    ldh a, [hMetaSpriteXFlipLo]
    sub a, b
    ld b, a
    ldh a, [hMetaSpriteXFlipHi]
    sbc a, $00
    jr z, Jump_07F_41FB
    jr nz, Jump_07F_41F4
    ld a, b
    cp a, $B8
    jr c, Jump_07F_41FB
    jr Jump_07F_41F4

Jump_07F_41E5::
    ldh a, [hMetaSpriteXFlipLo]
    sub a, b
    ld b, a
    ldh a, [hMetaSpriteXFlipHi]
    sbc a, $FF
    jr nz, Jump_07F_41F4
    ld a, b
    cp a, $B8
    jr c, Jump_07F_41FB

Jump_07F_41F4::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_07F_419E

Jump_07F_41FB::
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
    jr nz, Jump_07F_419E
    ret

Jump_07F_4216::
    ldh a, [hSpriteAttrXor]
    and a, $20
    jr nz, Jump_07F_4297

Jump_07F_421C::
    ld a, [hl+]
    cp a, $80
    ret z
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_07F_4227
    dec b

Jump_07F_4227::
    ldh a, [hMetaSpriteYLo]
    add a, c
    ld c, a
    ldh a, [hMetaSpriteYHi]
    adc a, b
    jr nz, Jump_07F_4252
    ld a, c
    cp a, $B8
    jr nc, Jump_07F_4252
    ldh a, [hSpriteWindowClipMode]
    or a, a
    jr z, Jump_07F_4257
    cp a, $01
    jr nz, Jump_07F_4245
    ld a, c
    cp a, $34
    jr c, Jump_07F_4252
    jr Jump_07F_4257

Jump_07F_4245::
    cp a, $02
    jr nz, Jump_07F_4250
    ld a, c
    cp a, $71
    jr c, Jump_07F_4257
    jr Jump_07F_4252

Jump_07F_4250::
    jr Jump_07F_4257

Jump_07F_4252::
    inc hl
    inc hl
    inc hl
    jr Jump_07F_421C

Jump_07F_4257::
    ld a, c
    ld [de], a
    inc e
    ld a, [hl+]
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_07F_4262
    dec b

Jump_07F_4262::
    ldh a, [hMetaSpriteXLo]
    add a, c
    ld c, a
    ldh a, [hMetaSpriteXHi]
    adc a, b
    jr nz, Jump_07F_4270
    ld a, c
    cp a, $B8
    jr c, Jump_07F_4277

Jump_07F_4270::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_07F_421C

Jump_07F_4277::
    ld a, c
    ld [de], a
    call BGTileUnderPointIsSpriteHideTile_Bank7F_4312
    jr nc, Jump_07F_4270
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
    jr nz, Jump_07F_421C
    ret

Jump_07F_4297::
    ld a, [hl+]
    cp a, $80
    ret z
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_07F_42A2
    dec b

Jump_07F_42A2::
    ldh a, [hMetaSpriteYLo]
    add a, c
    ld c, a
    ldh a, [hMetaSpriteYHi]
    adc a, b
    jr nz, Jump_07F_42CD
    ld a, c
    cp a, $B8
    jr nc, Jump_07F_42CD
    ldh a, [hSpriteWindowClipMode]
    or a, a
    jr z, Jump_07F_42D2
    cp a, $01
    jr nz, Jump_07F_42C0
    ld a, c
    cp a, $34
    jr c, Jump_07F_42CD
    jr Jump_07F_42D2

Jump_07F_42C0::
    cp a, $02
    jr nz, Jump_07F_42CB
    ld a, c
    cp a, $71
    jr c, Jump_07F_42D2
    jr Jump_07F_42CD

Jump_07F_42CB::
    jr Jump_07F_42D2

Jump_07F_42CD::
    inc hl
    inc hl
    inc hl
    jr Jump_07F_4297

Jump_07F_42D2::
    ld a, c
    ld [de], a
    inc e
    ld a, [hl+]
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_07F_42DD
    dec b

Jump_07F_42DD::
    ldh a, [hMetaSpriteXFlipLo]
    sub a, c
    ld c, a
    ldh a, [hMetaSpriteXFlipHi]
    sbc a, b
    jr nz, Jump_07F_42EB
    ld a, c
    cp a, $B8
    jr c, Jump_07F_42F2

Jump_07F_42EB::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_07F_4297

Jump_07F_42F2::
    ld a, c
    ld [de], a
    call BGTileUnderPointIsSpriteHideTile_Bank7F_4312
    jr nc, Jump_07F_42EB
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
    jr nz, Jump_07F_4297
    ret

; DE = address of an X byte with its Y byte at DE - 1 (screen coordinates): HL = the $9800 BG map entry under (X + hScrollX - 4, Y + hScrollY - 12), rows wrapping inside the map; reads it after rSTAT bit 1 clears (interrupts off) and compares with hFFBA: Z set when equal, A = the tile; BC, HL kept (E-0065) (the same 54 bytes appear in 6 banks)
; 2 call sites from 1 routine (e.g. DrawMetaSpriteAt_40CC)
; reads: hScrollY, hScrollX, hSpriteHideTile, rSTAT
BGTileUnderPointIsSpriteHideTile_Bank7F_4312::
Func_07F_4312:: ; address name
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

Jump_07F_433C::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_07F_433C
    ld a, [hl]
    ei
    cp a, b
    pop bc
    pop hl
    ret

; E-0147 (derived: meta-sprite set 0 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set00::
Data_07F_4348:: ; address name
    dw MetaSprites7F_4008Set00Frame0 ; entry 0
    dw MetaSprites7F_4008Set00Frame1 ; entry 1
    dw MetaSprites7F_4008Set00Frame2 ; entry 2
    dw MetaSprites7F_4008Set00Frame3 ; entry 3
    dw MetaSprites7F_4008Set00Frame4 ; entry 4
    dw MetaSprites7F_4008Set00Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set00Frame0::
Data_07F_4354:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set00Frame1::
Data_07F_4365:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $FF, $02, $20 ; entry 2
    db $F9, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set00Frame2::
Data_07F_4376:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set00Frame3::
Data_07F_4387:: ; address name
    db $F1, $F8, $04, $00 ; entry 0
    db $F1, $00, $05, $00 ; entry 1
    db $F9, $F8, $08, $00 ; entry 2
    db $F9, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set00Frame4::
Data_07F_4398:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set00Frame5::
Data_07F_43A9:: ; address name
    db $F1, $F8, $0A, $00 ; entry 0
    db $F1, $00, $0B, $00 ; entry 1
    db $F9, $F8, $0E, $00 ; entry 2
    db $F9, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 1 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set01::
Data_07F_43BA:: ; address name
    dw MetaSprites7F_4008Set01Frame0 ; entry 0
    dw MetaSprites7F_4008Set01Frame1 ; entry 1
    dw MetaSprites7F_4008Set01Frame2 ; entry 2
    dw MetaSprites7F_4008Set01Frame3 ; entry 3
    dw MetaSprites7F_4008Set01Frame4 ; entry 4
    dw MetaSprites7F_4008Set01Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set01Frame0::
Data_07F_43C6:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set01Frame1::
Data_07F_43D7:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $00, $02, $20 ; entry 2
    db $F9, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set01Frame2::
Data_07F_43E8:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set01Frame3::
Data_07F_43F9:: ; address name
    db $F1, $F8, $04, $00 ; entry 0
    db $F1, $00, $05, $00 ; entry 1
    db $F9, $F8, $08, $00 ; entry 2
    db $F9, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set01Frame4::
Data_07F_440A:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set01Frame5::
Data_07F_441B:: ; address name
    db $F1, $F8, $0A, $00 ; entry 0
    db $F1, $00, $0B, $00 ; entry 1
    db $F9, $F8, $0E, $00 ; entry 2
    db $F9, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 2 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set02::
Data_07F_442C:: ; address name
    dw MetaSprites7F_4008Set02Frame0 ; entry 0
    dw MetaSprites7F_4008Set02Frame1 ; entry 1
    dw MetaSprites7F_4008Set02Frame2 ; entry 2
    dw MetaSprites7F_4008Set02Frame3 ; entry 3
    dw MetaSprites7F_4008Set02Frame4 ; entry 4
    dw MetaSprites7F_4008Set02Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set02Frame0::
Data_07F_4438:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set02Frame1::
Data_07F_4449:: ; address name
    db $F1, $00, $00, $20 ; entry 0
    db $F1, $F8, $01, $20 ; entry 1
    db $F9, $00, $02, $20 ; entry 2
    db $F9, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set02Frame2::
Data_07F_445A:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set02Frame3::
Data_07F_446B:: ; address name
    db $F1, $F8, $08, $00 ; entry 0
    db $F1, $00, $09, $00 ; entry 1
    db $F9, $F8, $0A, $00 ; entry 2
    db $F9, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set02Frame4::
Data_07F_447C:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set02Frame5::
Data_07F_448D:: ; address name
    db $F1, $00, $0C, $20 ; entry 0
    db $F1, $F8, $0D, $20 ; entry 1
    db $F9, $00, $0E, $20 ; entry 2
    db $F9, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 3 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set03::
Data_07F_449E:: ; address name
    dw MetaSprites7F_4008Set03Frame0 ; entry 0
    dw MetaSprites7F_4008Set03Frame1 ; entry 1
    dw MetaSprites7F_4008Set03Frame2 ; entry 2
    dw MetaSprites7F_4008Set03Frame3 ; entry 3
    dw MetaSprites7F_4008Set03Frame4 ; entry 4
    dw MetaSprites7F_4008Set03Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set03Frame0::
Data_07F_44AA:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set03Frame1::
Data_07F_44BB:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $FF, $02, $20 ; entry 2
    db $F9, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set03Frame2::
Data_07F_44CC:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set03Frame3::
Data_07F_44DD:: ; address name
    db $F1, $F8, $04, $00 ; entry 0
    db $F1, $00, $05, $00 ; entry 1
    db $F9, $F8, $08, $00 ; entry 2
    db $F9, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set03Frame4::
Data_07F_44EE:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set03Frame5::
Data_07F_44FF:: ; address name
    db $F1, $F8, $0A, $00 ; entry 0
    db $F1, $00, $0B, $00 ; entry 1
    db $F9, $FF, $0C, $20 ; entry 2
    db $F9, $F7, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 4 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set04::
Data_07F_4510:: ; address name
    dw MetaSprites7F_4008Set04Frame0 ; entry 0
    dw MetaSprites7F_4008Set04Frame1 ; entry 1
    dw MetaSprites7F_4008Set04Frame2 ; entry 2
    dw MetaSprites7F_4008Set04Frame3 ; entry 3
    dw MetaSprites7F_4008Set04Frame4 ; entry 4
    dw MetaSprites7F_4008Set04Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set04Frame0::
Data_07F_451C:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set04Frame1::
Data_07F_452D:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set04Frame2::
Data_07F_453E:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set04Frame3::
Data_07F_454F:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set04Frame4::
Data_07F_4560:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set04Frame5::
Data_07F_4571:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $FF, $0C, $20 ; entry 2
    db $F8, $F7, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 5 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set05::
Data_07F_4582:: ; address name
    dw MetaSprites7F_4008Set05Frame0 ; entry 0
    dw MetaSprites7F_4008Set05Frame1 ; entry 1
    dw MetaSprites7F_4008Set05Frame2 ; entry 2
    dw MetaSprites7F_4008Set05Frame3 ; entry 3
    dw MetaSprites7F_4008Set05Frame4 ; entry 4
    dw MetaSprites7F_4008Set05Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set05Frame0::
Data_07F_458E:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set05Frame1::
Data_07F_459F:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set05Frame2::
Data_07F_45B0:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set05Frame3::
Data_07F_45C1:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set05Frame4::
Data_07F_45D2:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set05Frame5::
Data_07F_45E3:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $FF, $0C, $20 ; entry 2
    db $F8, $F7, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 6 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set06::
Data_07F_45F4:: ; address name
    dw MetaSprites7F_4008Set06Frame0 ; entry 0
    dw MetaSprites7F_4008Set06Frame1 ; entry 1
    dw MetaSprites7F_4008Set06Frame2 ; entry 2
    dw MetaSprites7F_4008Set06Frame3 ; entry 3
    dw MetaSprites7F_4008Set06Frame4 ; entry 4
    dw MetaSprites7F_4008Set06Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set06; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set06Frame0::
Data_07F_4600:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set06; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set06Frame1::
Data_07F_4611:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set06; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set06Frame2::
Data_07F_4622:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set06; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set06Frame3::
Data_07F_4633:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set06; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set06Frame4::
Data_07F_4644:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set06; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set06Frame5::
Data_07F_4655:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $FF, $0C, $20 ; entry 2
    db $F8, $F7, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 7 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set07::
Data_07F_4666:: ; address name
    dw MetaSprites7F_4008Set07Frame0 ; entry 0
    dw MetaSprites7F_4008Set07Frame1 ; entry 1
    dw MetaSprites7F_4008Set07Frame2 ; entry 2
    dw MetaSprites7F_4008Set07Frame3 ; entry 3
    dw MetaSprites7F_4008Set07Frame4 ; entry 4
    dw MetaSprites7F_4008Set07Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set07; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set07Frame0::
Data_07F_4672:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set07; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set07Frame1::
Data_07F_4683:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set07; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set07Frame2::
Data_07F_4694:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set07; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set07Frame3::
Data_07F_46A5:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set07; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set07Frame4::
Data_07F_46B6:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set07; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set07Frame5::
Data_07F_46C7:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $FF, $0C, $20 ; entry 2
    db $F8, $F7, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 8 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set08::
Data_07F_46D8:: ; address name
    dw MetaSprites7F_4008Set08Frame0 ; entry 0
    dw MetaSprites7F_4008Set08Frame1 ; entry 1
    dw MetaSprites7F_4008Set08Frame2 ; entry 2
    dw MetaSprites7F_4008Set08Frame3 ; entry 3
    dw MetaSprites7F_4008Set08Frame4 ; entry 4
    dw MetaSprites7F_4008Set08Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set08; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set08Frame0::
Data_07F_46E4:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set08; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set08Frame1::
Data_07F_46F5:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set08; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set08Frame2::
Data_07F_4706:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set08; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set08Frame3::
Data_07F_4717:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set08; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set08Frame4::
Data_07F_4728:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set08; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set08Frame5::
Data_07F_4739:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $FF, $0C, $20 ; entry 2
    db $F8, $F7, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 9 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set09::
Data_07F_474A:: ; address name
    dw MetaSprites7F_4008Set09Frame0 ; entry 0
    dw MetaSprites7F_4008Set09Frame1 ; entry 1
    dw MetaSprites7F_4008Set09Frame2 ; entry 2
    dw MetaSprites7F_4008Set09Frame3 ; entry 3
    dw MetaSprites7F_4008Set09Frame4 ; entry 4
    dw MetaSprites7F_4008Set09Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set09; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set09Frame0::
Data_07F_4756:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set09; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set09Frame1::
Data_07F_4767:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set09; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set09Frame2::
Data_07F_4778:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set09; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set09Frame3::
Data_07F_4789:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set09; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set09Frame4::
Data_07F_479A:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set09; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set09Frame5::
Data_07F_47AB:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $FF, $0C, $20 ; entry 2
    db $F8, $F7, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 10 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set0A::
Data_07F_47BC:: ; address name
    dw MetaSprites7F_4008Set0AFrame0 ; entry 0
    dw MetaSprites7F_4008Set0AFrame1 ; entry 1
    dw MetaSprites7F_4008Set0AFrame2 ; entry 2
    dw MetaSprites7F_4008Set0AFrame3 ; entry 3
    dw MetaSprites7F_4008Set0AFrame4 ; entry 4
    dw MetaSprites7F_4008Set0AFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set0A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0AFrame0::
Data_07F_47C8:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set0A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0AFrame1::
Data_07F_47D9:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set0A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0AFrame2::
Data_07F_47EA:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set0A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0AFrame3::
Data_07F_47FB:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set0A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0AFrame4::
Data_07F_480C:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set0A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0AFrame5::
Data_07F_481D:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $FF, $0C, $20 ; entry 2
    db $F8, $F7, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 11 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set0B::
Data_07F_482E:: ; address name
    dw MetaSprites7F_4008Set0BFrame0 ; entry 0
    dw MetaSprites7F_4008Set0BFrame1 ; entry 1
    dw MetaSprites7F_4008Set0BFrame2 ; entry 2
    dw MetaSprites7F_4008Set0BFrame3 ; entry 3
    dw MetaSprites7F_4008Set0BFrame4 ; entry 4
    dw MetaSprites7F_4008Set0BFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0BFrame0::
Data_07F_483A:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0BFrame1::
Data_07F_484B:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0BFrame2::
Data_07F_485C:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0BFrame3::
Data_07F_486D:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0BFrame4::
Data_07F_487E:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0BFrame5::
Data_07F_488F:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $FF, $0C, $20 ; entry 2
    db $F8, $F7, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 12 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set0C::
Data_07F_48A0:: ; address name
    dw MetaSprites7F_4008Set0CFrame0 ; entry 0
    dw MetaSprites7F_4008Set0CFrame1 ; entry 1
    dw MetaSprites7F_4008Set0CFrame2 ; entry 2
    dw MetaSprites7F_4008Set0CFrame3 ; entry 3
    dw MetaSprites7F_4008Set0CFrame4 ; entry 4
    dw MetaSprites7F_4008Set0CFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set0C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0CFrame0::
Data_07F_48AC:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set0C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0CFrame1::
Data_07F_48BD:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $04, $00 ; entry 2
    db $F8, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set0C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0CFrame2::
Data_07F_48CE:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set0C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0CFrame3::
Data_07F_48DF:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set0C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0CFrame4::
Data_07F_48F0:: ; address name
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $00, $0C, $00 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0E, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set0C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0CFrame5::
Data_07F_4901:: ; address name
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $00, $0C, $00 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 13 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set0D::
Data_07F_4912:: ; address name
    dw MetaSprites7F_4008Set0DFrame0 ; entry 0
    dw MetaSprites7F_4008Set0DFrame1 ; entry 1
    dw MetaSprites7F_4008Set0DFrame2 ; entry 2
    dw MetaSprites7F_4008Set0DFrame3 ; entry 3
    dw MetaSprites7F_4008Set0DFrame4 ; entry 4
    dw MetaSprites7F_4008Set0DFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set0D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0DFrame0::
Data_07F_491E:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set0D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0DFrame1::
Data_07F_492F:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set0D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0DFrame2::
Data_07F_4940:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set0D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0DFrame3::
Data_07F_4951:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set0D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0DFrame4::
Data_07F_4962:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set0D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0DFrame5::
Data_07F_4973:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $FF, $0C, $20 ; entry 2
    db $F8, $F7, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 14 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set0E::
Data_07F_4984:: ; address name
    dw MetaSprites7F_4008Set0EFrame0 ; entry 0
    dw MetaSprites7F_4008Set0EFrame1 ; entry 1
    dw MetaSprites7F_4008Set0EFrame2 ; entry 2
    dw MetaSprites7F_4008Set0EFrame3 ; entry 3
    dw MetaSprites7F_4008Set0EFrame4 ; entry 4
    dw MetaSprites7F_4008Set0EFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set0E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0EFrame0::
Data_07F_4990:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set0E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0EFrame1::
Data_07F_49A1:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set0E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0EFrame2::
Data_07F_49B2:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set0E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0EFrame3::
Data_07F_49C3:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set0E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0EFrame4::
Data_07F_49D4:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set0E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0EFrame5::
Data_07F_49E5:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $00, $0C, $20 ; entry 2
    db $F8, $F8, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 15 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set0F::
Data_07F_49F6:: ; address name
    dw MetaSprites7F_4008Set0FFrame0 ; entry 0
    dw MetaSprites7F_4008Set0FFrame1 ; entry 1
    dw MetaSprites7F_4008Set0FFrame2 ; entry 2
    dw MetaSprites7F_4008Set0FFrame3 ; entry 3
    dw MetaSprites7F_4008Set0FFrame4 ; entry 4
    dw MetaSprites7F_4008Set0FFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set0F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0FFrame0::
Data_07F_4A02:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set0F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0FFrame1::
Data_07F_4A13:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $04, $00 ; entry 2
    db $F8, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set0F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0FFrame2::
Data_07F_4A24:: ; address name
    db $F8, $F8, $08, $00 ; entry 0
    db $F8, $00, $09, $00 ; entry 1
    db $F0, $F8, $06, $00 ; entry 2
    db $F0, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set0F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0FFrame3::
Data_07F_4A35:: ; address name
    db $F8, $F8, $0A, $00 ; entry 0
    db $F8, $00, $0B, $00 ; entry 1
    db $F0, $F8, $06, $00 ; entry 2
    db $F0, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set0F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0FFrame4::
Data_07F_4A46:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0C, $20 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set0F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set0FFrame5::
Data_07F_4A57:: ; address name
    db $F8, $F8, $0E, $00 ; entry 0
    db $F8, $00, $0E, $20 ; entry 1
    db $F0, $F8, $0C, $00 ; entry 2
    db $F0, $00, $0C, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 16 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set10::
Data_07F_4A68:: ; address name
    dw MetaSprites7F_4008Set10Frame0 ; entry 0
    dw MetaSprites7F_4008Set10Frame1 ; entry 1
    dw MetaSprites7F_4008Set10Frame2 ; entry 2
    dw MetaSprites7F_4008Set10Frame3 ; entry 3
    dw MetaSprites7F_4008Set10Frame4 ; entry 4
    dw MetaSprites7F_4008Set10Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set10Frame0::
Data_07F_4A74:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set10Frame1::
Data_07F_4A85:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set10Frame2::
Data_07F_4A96:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set10Frame3::
Data_07F_4AA7:: ; address name
    db $F8, $F8, $08, $00 ; entry 0
    db $F8, $00, $09, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set10Frame4::
Data_07F_4AB8:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set10Frame5::
Data_07F_4AC9:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $FF, $0C, $20 ; entry 2
    db $F8, $F7, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 17 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set11::
Data_07F_4ADA:: ; address name
    dw MetaSprites7F_4008Set11Frame0 ; entry 0
    dw MetaSprites7F_4008Set11Frame1 ; entry 1
    dw MetaSprites7F_4008Set11Frame2 ; entry 2
    dw MetaSprites7F_4008Set11Frame3 ; entry 3
    dw MetaSprites7F_4008Set11Frame4 ; entry 4
    dw MetaSprites7F_4008Set11Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set11Frame0::
Data_07F_4AE6:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set11Frame1::
Data_07F_4AF7:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set11Frame2::
Data_07F_4B08:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set11Frame3::
Data_07F_4B19:: ; address name
    db $F8, $F8, $08, $00 ; entry 0
    db $F8, $00, $09, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set11Frame4::
Data_07F_4B2A:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set11Frame5::
Data_07F_4B3B:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $FF, $0C, $20 ; entry 2
    db $F8, $F7, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 18 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set12::
Data_07F_4B4C:: ; address name
    dw MetaSprites7F_4008Set12Frame0 ; entry 0
    dw MetaSprites7F_4008Set12Frame1 ; entry 1
    dw MetaSprites7F_4008Set12Frame2 ; entry 2
    dw MetaSprites7F_4008Set12Frame3 ; entry 3
    dw MetaSprites7F_4008Set12Frame4 ; entry 4
    dw MetaSprites7F_4008Set12Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set12; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set12Frame0::
Data_07F_4B58:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set12; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set12Frame1::
Data_07F_4B69:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set12; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set12Frame2::
Data_07F_4B7A:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set12; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set12Frame3::
Data_07F_4B8B:: ; address name
    db $F8, $F8, $08, $00 ; entry 0
    db $F8, $00, $09, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set12; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set12Frame4::
Data_07F_4B9C:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set12; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set12Frame5::
Data_07F_4BAD:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $FF, $0C, $20 ; entry 2
    db $F8, $F7, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 19 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set13::
Data_07F_4BBE:: ; address name
    dw MetaSprites7F_4008Set13Frame0 ; entry 0
    dw MetaSprites7F_4008Set13Frame1 ; entry 1
    dw MetaSprites7F_4008Set13Frame2 ; entry 2
    dw MetaSprites7F_4008Set13Frame3 ; entry 3
    dw MetaSprites7F_4008Set13Frame4 ; entry 4
    dw MetaSprites7F_4008Set13Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set13; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set13Frame0::
Data_07F_4BCA:: ; address name
    db $F0, $FA, $00, $00 ; entry 0
    db $F0, $02, $01, $00 ; entry 1
    db $F8, $FA, $02, $00 ; entry 2
    db $F8, $02, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set13; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set13Frame1::
Data_07F_4BDB:: ; address name
    db $F0, $FA, $00, $00 ; entry 0
    db $F0, $02, $01, $00 ; entry 1
    db $F8, $02, $03, $00 ; entry 2
    db $F8, $FA, $04, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set13; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set13Frame2::
Data_07F_4BEC:: ; address name
    db $F0, $F6, $05, $00 ; entry 0
    db $F0, $FE, $06, $00 ; entry 1
    db $F8, $F6, $07, $00 ; entry 2
    db $F8, $FE, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set13; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set13Frame3::
Data_07F_4BFD:: ; address name
    db $F0, $F6, $05, $00 ; entry 0
    db $F0, $FE, $06, $00 ; entry 1
    db $F8, $F6, $07, $00 ; entry 2
    db $F8, $FE, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set13; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set13Frame4::
Data_07F_4C0E:: ; address name
    db $F0, $F6, $0A, $00 ; entry 0
    db $F0, $FE, $0B, $00 ; entry 1
    db $F8, $F6, $0C, $00 ; entry 2
    db $F8, $FE, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set13; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set13Frame5::
Data_07F_4C1F:: ; address name
    db $F0, $F6, $0A, $00 ; entry 0
    db $F0, $FE, $0B, $00 ; entry 1
    db $F8, $F6, $0C, $00 ; entry 2
    db $F8, $FE, $0E, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 20 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set14::
Data_07F_4C30:: ; address name
    dw MetaSprites7F_4008Set14Frame0 ; entry 0
    dw MetaSprites7F_4008Set14Frame1 ; entry 1
    dw MetaSprites7F_4008Set14Frame2 ; entry 2
    dw MetaSprites7F_4008Set14Frame3 ; entry 3
    dw MetaSprites7F_4008Set14Frame4 ; entry 4
    dw MetaSprites7F_4008Set14Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set14; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set14Frame0::
Data_07F_4C3C:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set14; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set14Frame1::
Data_07F_4C4D:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set14; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set14Frame2::
Data_07F_4C5E:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set14; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set14Frame3::
Data_07F_4C6F:: ; address name
    db $F8, $F8, $08, $00 ; entry 0
    db $F8, $00, $09, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set14; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set14Frame4::
Data_07F_4C80:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set14; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set14Frame5::
Data_07F_4C91:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $FF, $0C, $20 ; entry 2
    db $F8, $F7, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 21 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set15::
Data_07F_4CA2:: ; address name
    dw MetaSprites7F_4008Set15Frame0 ; entry 0
    dw MetaSprites7F_4008Set15Frame1 ; entry 1
    dw MetaSprites7F_4008Set15Frame2 ; entry 2
    dw MetaSprites7F_4008Set15Frame3 ; entry 3
    dw MetaSprites7F_4008Set15Frame4 ; entry 4
    dw MetaSprites7F_4008Set15Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set15; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set15Frame0::
Data_07F_4CAE:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set15; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set15Frame1::
Data_07F_4CBF:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set15; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set15Frame2::
Data_07F_4CD0:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set15; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set15Frame3::
Data_07F_4CE1:: ; address name
    db $F8, $F8, $08, $00 ; entry 0
    db $F8, $00, $09, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set15; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set15Frame4::
Data_07F_4CF2:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set15; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set15Frame5::
Data_07F_4D03:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $FF, $0C, $20 ; entry 2
    db $F8, $F7, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 22 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set16::
Data_07F_4D14:: ; address name
    dw MetaSprites7F_4008Set16Frame0 ; entry 0
    dw MetaSprites7F_4008Set16Frame1 ; entry 1
    dw MetaSprites7F_4008Set16Frame2 ; entry 2
    dw MetaSprites7F_4008Set16Frame3 ; entry 3
    dw MetaSprites7F_4008Set16Frame4 ; entry 4
    dw MetaSprites7F_4008Set16Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set16; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set16Frame0::
Data_07F_4D20:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set16; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set16Frame1::
Data_07F_4D31:: ; address name
    db $F0, $FF, $00, $20 ; entry 0
    db $F0, $F7, $01, $20 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set16; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set16Frame2::
Data_07F_4D42:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set16; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set16Frame3::
Data_07F_4D53:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set16; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set16Frame4::
Data_07F_4D64:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set16; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set16Frame5::
Data_07F_4D75:: ; address name
    db $F0, $FF, $0C, $20 ; entry 0
    db $F0, $F7, $0D, $20 ; entry 1
    db $F8, $FF, $0E, $20 ; entry 2
    db $F8, $F7, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 23 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set17::
Data_07F_4D86:: ; address name
    dw MetaSprites7F_4008Set17Frame0 ; entry 0
    dw MetaSprites7F_4008Set17Frame1 ; entry 1
    dw MetaSprites7F_4008Set17Frame2 ; entry 2
    dw MetaSprites7F_4008Set17Frame3 ; entry 3
    dw MetaSprites7F_4008Set17Frame4 ; entry 4
    dw MetaSprites7F_4008Set17Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set17; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set17Frame0::
Data_07F_4D92:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set17; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set17Frame1::
Data_07F_4DA3:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set17; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set17Frame2::
Data_07F_4DB4:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set17; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set17Frame3::
Data_07F_4DC5:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set17; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set17Frame4::
Data_07F_4DD6:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set17; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set17Frame5::
Data_07F_4DE7:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $FF, $0C, $20 ; entry 2
    db $F8, $F7, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 24 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set18::
Data_07F_4DF8:: ; address name
    dw MetaSprites7F_4008Set18Frame0 ; entry 0
    dw MetaSprites7F_4008Set18Frame1 ; entry 1
    dw MetaSprites7F_4008Set18Frame2 ; entry 2
    dw MetaSprites7F_4008Set18Frame3 ; entry 3
    dw MetaSprites7F_4008Set18Frame4 ; entry 4
    dw MetaSprites7F_4008Set18Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set18; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set18Frame0::
Data_07F_4E04:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set18; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set18Frame1::
Data_07F_4E15:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set18; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set18Frame2::
Data_07F_4E26:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set18; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set18Frame3::
Data_07F_4E37:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set18; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set18Frame4::
Data_07F_4E48:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set18; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set18Frame5::
Data_07F_4E59:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $FF, $0C, $20 ; entry 2
    db $F8, $F7, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 25 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set19::
Data_07F_4E6A:: ; address name
    dw MetaSprites7F_4008Set19Frame0 ; entry 0
    dw MetaSprites7F_4008Set19Frame1 ; entry 1
    dw MetaSprites7F_4008Set19Frame2 ; entry 2
    dw MetaSprites7F_4008Set19Frame3 ; entry 3
    dw MetaSprites7F_4008Set19Frame4 ; entry 4
    dw MetaSprites7F_4008Set19Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set19; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set19Frame0::
Data_07F_4E76:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set19; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set19Frame1::
Data_07F_4E87:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set19; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set19Frame2::
Data_07F_4E98:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set19; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set19Frame3::
Data_07F_4EA9:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set19; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set19Frame4::
Data_07F_4EBA:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set19; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set19Frame5::
Data_07F_4ECB:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $FF, $0C, $20 ; entry 2
    db $F8, $F7, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 26 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set1A::
Data_07F_4EDC:: ; address name
    dw MetaSprites7F_4008Set1AFrame0 ; entry 0
    dw MetaSprites7F_4008Set1AFrame1 ; entry 1
    dw MetaSprites7F_4008Set1AFrame2 ; entry 2
    dw MetaSprites7F_4008Set1AFrame3 ; entry 3
    dw MetaSprites7F_4008Set1AFrame4 ; entry 4
    dw MetaSprites7F_4008Set1AFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1AFrame0::
Data_07F_4EE8:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1AFrame1::
Data_07F_4EF9:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1AFrame2::
Data_07F_4F0A:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1AFrame3::
Data_07F_4F1B:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1AFrame4::
Data_07F_4F2C:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1AFrame5::
Data_07F_4F3D:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $FF, $0C, $20 ; entry 2
    db $F8, $F7, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 27 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set1B::
Data_07F_4F4E:: ; address name
    dw MetaSprites7F_4008Set1BFrame0 ; entry 0
    dw MetaSprites7F_4008Set1BFrame1 ; entry 1
    dw MetaSprites7F_4008Set1BFrame2 ; entry 2
    dw MetaSprites7F_4008Set1BFrame3 ; entry 3
    dw MetaSprites7F_4008Set1BFrame4 ; entry 4
    dw MetaSprites7F_4008Set1BFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1BFrame0::
Data_07F_4F5A:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1BFrame1::
Data_07F_4F6B:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1BFrame2::
Data_07F_4F7C:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1BFrame3::
Data_07F_4F8D:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1BFrame4::
Data_07F_4F9E:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1BFrame5::
Data_07F_4FAF:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $FF, $0C, $20 ; entry 2
    db $F8, $F7, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 28 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set1C::
Data_07F_4FC0:: ; address name
    dw MetaSprites7F_4008Set1CFrame0 ; entry 0
    dw MetaSprites7F_4008Set1CFrame1 ; entry 1
    dw MetaSprites7F_4008Set1CFrame2 ; entry 2
    dw MetaSprites7F_4008Set1CFrame3 ; entry 3
    dw MetaSprites7F_4008Set1CFrame4 ; entry 4
    dw MetaSprites7F_4008Set1CFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1CFrame0::
Data_07F_4FCC:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1CFrame1::
Data_07F_4FDD:: ; address name
    db $F0, $FF, $00, $20 ; entry 0
    db $F0, $F7, $01, $20 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1CFrame2::
Data_07F_4FEE:: ; address name
    db $F0, $F9, $04, $00 ; entry 0
    db $F0, $01, $05, $00 ; entry 1
    db $F8, $F9, $06, $00 ; entry 2
    db $F8, $01, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1CFrame3::
Data_07F_4FFF:: ; address name
    db $F8, $F9, $0A, $00 ; entry 0
    db $F8, $01, $0B, $00 ; entry 1
    db $F0, $F9, $08, $00 ; entry 2
    db $F0, $01, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1CFrame4::
Data_07F_5010:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1CFrame5::
Data_07F_5021:: ; address name
    db $F0, $FF, $0C, $20 ; entry 0
    db $F0, $F7, $0D, $20 ; entry 1
    db $F8, $FF, $0E, $20 ; entry 2
    db $F8, $F7, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 29 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set1D::
Data_07F_5032:: ; address name
    dw MetaSprites7F_4008Set1DFrame0 ; entry 0
    dw MetaSprites7F_4008Set1DFrame1 ; entry 1
    dw MetaSprites7F_4008Set1DFrame2 ; entry 2
    dw MetaSprites7F_4008Set1DFrame3 ; entry 3
    dw MetaSprites7F_4008Set1DFrame4 ; entry 4
    dw MetaSprites7F_4008Set1DFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set1D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1DFrame0::
Data_07F_503E:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set1D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1DFrame1::
Data_07F_504F:: ; address name
    db $F0, $00, $00, $20 ; entry 0
    db $F0, $F8, $01, $20 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set1D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1DFrame2::
Data_07F_5060:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set1D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1DFrame3::
Data_07F_5071:: ; address name
    db $F8, $F8, $08, $00 ; entry 0
    db $F8, $00, $09, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set1D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1DFrame4::
Data_07F_5082:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set1D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1DFrame5::
Data_07F_5093:: ; address name
    db $F0, $00, $0A, $20 ; entry 0
    db $F0, $F8, $0B, $20 ; entry 1
    db $F8, $00, $0C, $20 ; entry 2
    db $F8, $F8, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 30 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set1E::
Data_07F_50A4:: ; address name
    dw MetaSprites7F_4008Set1EFrame0 ; entry 0
    dw MetaSprites7F_4008Set1EFrame1 ; entry 1
    dw MetaSprites7F_4008Set1EFrame2 ; entry 2
    dw MetaSprites7F_4008Set1EFrame3 ; entry 3
    dw MetaSprites7F_4008Set1EFrame4 ; entry 4
    dw MetaSprites7F_4008Set1EFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1EFrame0::
Data_07F_50B0:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1EFrame1::
Data_07F_50C1:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $04, $00 ; entry 2
    db $F8, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1EFrame2::
Data_07F_50D2:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F8, $F8, $08, $00 ; entry 1
    db $F8, $00, $09, $00 ; entry 2
    db $F0, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1EFrame3::
Data_07F_50E3:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $00, $0A, $00 ; entry 2
    db $F8, $F8, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1EFrame4::
Data_07F_50F4:: ; address name
    db $F0, $F8, $0B, $00 ; entry 0
    db $F8, $F8, $0C, $00 ; entry 1
    db $F8, $00, $0D, $00 ; entry 2
    db $F0, $FF, $0B, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1EFrame5::
Data_07F_5105:: ; address name
    db $F0, $F8, $0B, $00 ; entry 0
    db $F8, $F8, $0E, $00 ; entry 1
    db $F8, $00, $0F, $00 ; entry 2
    db $F0, $FF, $0B, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 31 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set1F::
Data_07F_5116:: ; address name
    dw MetaSprites7F_4008Set1FFrame0 ; entry 0
    dw MetaSprites7F_4008Set1FFrame1 ; entry 1
    dw MetaSprites7F_4008Set1FFrame2 ; entry 2
    dw MetaSprites7F_4008Set1FFrame3 ; entry 3
    dw MetaSprites7F_4008Set1FFrame4 ; entry 4
    dw MetaSprites7F_4008Set1FFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1FFrame0::
Data_07F_5122:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1FFrame1::
Data_07F_5133:: ; address name
    db $F0, $F7, $00, $00 ; entry 0
    db $F0, $FF, $01, $00 ; entry 1
    db $F8, $FE, $02, $20 ; entry 2
    db $F8, $F6, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1FFrame2::
Data_07F_5144:: ; address name
    db $F0, $F7, $04, $00 ; entry 0
    db $F8, $F7, $06, $00 ; entry 1
    db $F8, $FF, $07, $00 ; entry 2
    db $F0, $FF, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1FFrame3::
Data_07F_5155:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1FFrame4::
Data_07F_5166:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F8, $F8, $0C, $00 ; entry 1
    db $F8, $00, $0D, $00 ; entry 2
    db $F0, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set1FFrame5::
Data_07F_5177:: ; address name
    db $F0, $F9, $0A, $00 ; entry 0
    db $F8, $00, $0C, $20 ; entry 1
    db $F8, $F8, $0D, $20 ; entry 2
    db $F0, $01, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 32 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set20::
Data_07F_5188:: ; address name
    dw MetaSprites7F_4008Set20Frame0 ; entry 0
    dw MetaSprites7F_4008Set20Frame1 ; entry 1
    dw MetaSprites7F_4008Set20Frame2 ; entry 2
    dw MetaSprites7F_4008Set20Frame3 ; entry 3
    dw MetaSprites7F_4008Set20Frame4 ; entry 4
    dw MetaSprites7F_4008Set20Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set20; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set20Frame0::
Data_07F_5194:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set20; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set20Frame1::
Data_07F_51A5:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $04, $00 ; entry 2
    db $F8, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set20; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set20Frame2::
Data_07F_51B6:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set20; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set20Frame3::
Data_07F_51C7:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set20; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set20Frame4::
Data_07F_51D8:: ; address name
    db $F0, $F8, $0B, $00 ; entry 0
    db $F8, $F8, $0C, $00 ; entry 1
    db $F8, $00, $0D, $00 ; entry 2
    db $F0, $FF, $0B, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set20; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set20Frame5::
Data_07F_51E9:: ; address name
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $FF, $0B, $20 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 33 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set21::
Data_07F_51FA:: ; address name
    dw MetaSprites7F_4008Set21Frame0 ; entry 0
    dw MetaSprites7F_4008Set21Frame1 ; entry 1
    dw MetaSprites7F_4008Set21Frame2 ; entry 2
    dw MetaSprites7F_4008Set21Frame3 ; entry 3
    dw MetaSprites7F_4008Set21Frame4 ; entry 4
    dw MetaSprites7F_4008Set21Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set21; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set21Frame0::
Data_07F_5206:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set21; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set21Frame1::
Data_07F_5217:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set21; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set21Frame2::
Data_07F_5228:: ; address name
    db $F0, $F7, $04, $00 ; entry 0
    db $F0, $FF, $05, $00 ; entry 1
    db $F8, $F7, $06, $00 ; entry 2
    db $F8, $FF, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set21; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set21Frame3::
Data_07F_5239:: ; address name
    db $F8, $F7, $08, $00 ; entry 0
    db $F8, $FF, $09, $00 ; entry 1
    db $F0, $F7, $04, $00 ; entry 2
    db $F0, $FF, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set21; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set21Frame4::
Data_07F_524A:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set21; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set21Frame5::
Data_07F_525B:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $FF, $0C, $20 ; entry 2
    db $F8, $F7, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 34 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set22::
Data_07F_526C:: ; address name
    dw MetaSprites7F_4008Set22Frame0 ; entry 0
    dw MetaSprites7F_4008Set22Frame1 ; entry 1
    dw MetaSprites7F_4008Set22Frame2 ; entry 2
    dw MetaSprites7F_4008Set22Frame3 ; entry 3
    dw MetaSprites7F_4008Set22Frame4 ; entry 4
    dw MetaSprites7F_4008Set22Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set22; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set22Frame0::
Data_07F_5278:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set22; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set22Frame1::
Data_07F_5289:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set22; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set22Frame2::
Data_07F_529A:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set22; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set22Frame3::
Data_07F_52AB:: ; address name
    db $F8, $F8, $08, $00 ; entry 0
    db $F8, $00, $09, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set22; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set22Frame4::
Data_07F_52BC:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set22; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set22Frame5::
Data_07F_52CD:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $00, $0C, $20 ; entry 2
    db $F8, $F8, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 35 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set23::
Data_07F_52DE:: ; address name
    dw MetaSprites7F_4008Set23Frame0 ; entry 0
    dw MetaSprites7F_4008Set23Frame1 ; entry 1
    dw MetaSprites7F_4008Set23Frame2 ; entry 2
    dw MetaSprites7F_4008Set23Frame3 ; entry 3
    dw MetaSprites7F_4008Set23Frame4 ; entry 4
    dw MetaSprites7F_4008Set23Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set23; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set23Frame0::
Data_07F_52EA:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set23; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set23Frame1::
Data_07F_52FB:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set23; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set23Frame2::
Data_07F_530C:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set23; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set23Frame3::
Data_07F_531D:: ; address name
    db $F8, $F8, $08, $00 ; entry 0
    db $F8, $00, $09, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set23; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set23Frame4::
Data_07F_532E:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set23; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set23Frame5::
Data_07F_533F:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $00, $0C, $20 ; entry 2
    db $F8, $F8, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 36 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set24::
Data_07F_5350:: ; address name
    dw MetaSprites7F_4008Set24Frame0 ; entry 0
    dw MetaSprites7F_4008Set24Frame1 ; entry 1
    dw MetaSprites7F_4008Set24Frame2 ; entry 2
    dw MetaSprites7F_4008Set24Frame3 ; entry 3
    dw MetaSprites7F_4008Set24Frame4 ; entry 4
    dw MetaSprites7F_4008Set24Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set24; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set24Frame0::
Data_07F_535C:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set24; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set24Frame1::
Data_07F_536D:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set24; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set24Frame2::
Data_07F_537E:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set24; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set24Frame3::
Data_07F_538F:: ; address name
    db $F8, $F8, $08, $00 ; entry 0
    db $F8, $00, $09, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set24; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set24Frame4::
Data_07F_53A0:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set24; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set24Frame5::
Data_07F_53B1:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $FF, $0C, $20 ; entry 2
    db $F8, $F7, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 37 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set25::
Data_07F_53C2:: ; address name
    dw MetaSprites7F_4008Set25Frame0 ; entry 0
    dw MetaSprites7F_4008Set25Frame1 ; entry 1
    dw MetaSprites7F_4008Set25Frame2 ; entry 2
    dw MetaSprites7F_4008Set25Frame3 ; entry 3
    dw MetaSprites7F_4008Set25Frame4 ; entry 4
    dw MetaSprites7F_4008Set25Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set25Frame0::
Data_07F_53CE:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set25Frame1::
Data_07F_53DF:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set25Frame2::
Data_07F_53F0:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set25Frame3::
Data_07F_5401:: ; address name
    db $F8, $F8, $08, $00 ; entry 0
    db $F8, $00, $09, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set25Frame4::
Data_07F_5412:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set25Frame5::
Data_07F_5423:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $FF, $0C, $20 ; entry 2
    db $F8, $F7, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 38 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set26::
Data_07F_5434:: ; address name
    dw MetaSprites7F_4008Set26Frame0 ; entry 0
    dw MetaSprites7F_4008Set26Frame1 ; entry 1
    dw MetaSprites7F_4008Set26Frame2 ; entry 2
    dw MetaSprites7F_4008Set26Frame3 ; entry 3
    dw MetaSprites7F_4008Set26Frame4 ; entry 4
    dw MetaSprites7F_4008Set26Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set26Frame0::
Data_07F_5440:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set26Frame1::
Data_07F_5451:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set26Frame2::
Data_07F_5462:: ; address name
    db $F0, $F7, $04, $00 ; entry 0
    db $F0, $FF, $05, $00 ; entry 1
    db $F8, $F7, $06, $00 ; entry 2
    db $F8, $FF, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set26Frame3::
Data_07F_5473:: ; address name
    db $F8, $F7, $08, $00 ; entry 0
    db $F8, $FF, $09, $00 ; entry 1
    db $F0, $F7, $04, $00 ; entry 2
    db $F0, $FF, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set26Frame4::
Data_07F_5484:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set26Frame5::
Data_07F_5495:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $FF, $0C, $20 ; entry 2
    db $F8, $F7, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 39 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set27::
Data_07F_54A6:: ; address name
    dw MetaSprites7F_4008Set27Frame0 ; entry 0
    dw MetaSprites7F_4008Set27Frame1 ; entry 1
    dw MetaSprites7F_4008Set27Frame2 ; entry 2
    dw MetaSprites7F_4008Set27Frame3 ; entry 3
    dw MetaSprites7F_4008Set27Frame4 ; entry 4
    dw MetaSprites7F_4008Set27Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set27Frame0::
Data_07F_54B2:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set27Frame1::
Data_07F_54C3:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set27Frame2::
Data_07F_54D4:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set27Frame3::
Data_07F_54E5:: ; address name
    db $F8, $F8, $08, $00 ; entry 0
    db $F8, $00, $09, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set27Frame4::
Data_07F_54F6:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set27Frame5::
Data_07F_5507:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $FF, $0C, $20 ; entry 2
    db $F8, $F7, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 40 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set28::
Data_07F_5518:: ; address name
    dw MetaSprites7F_4008Set28Frame0 ; entry 0
    dw MetaSprites7F_4008Set28Frame1 ; entry 1
    dw MetaSprites7F_4008Set28Frame2 ; entry 2
    dw MetaSprites7F_4008Set28Frame3 ; entry 3
    dw MetaSprites7F_4008Set28Frame4 ; entry 4
    dw MetaSprites7F_4008Set28Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set28; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set28Frame0::
Data_07F_5524:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set28; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set28Frame1::
Data_07F_5535:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set28; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set28Frame2::
Data_07F_5546:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set28; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set28Frame3::
Data_07F_5557:: ; address name
    db $F8, $F8, $08, $00 ; entry 0
    db $F8, $00, $09, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set28; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set28Frame4::
Data_07F_5568:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set28; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set28Frame5::
Data_07F_5579:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $FF, $0C, $20 ; entry 2
    db $F8, $F7, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 41 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set29::
Data_07F_558A:: ; address name
    dw MetaSprites7F_4008Set29Frame0 ; entry 0
    dw MetaSprites7F_4008Set29Frame1 ; entry 1
    dw MetaSprites7F_4008Set29Frame2 ; entry 2
    dw MetaSprites7F_4008Set29Frame3 ; entry 3
    dw MetaSprites7F_4008Set29Frame4 ; entry 4
    dw MetaSprites7F_4008Set29Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set29Frame0::
Data_07F_5596:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set29Frame1::
Data_07F_55A7:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set29Frame2::
Data_07F_55B8:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set29Frame3::
Data_07F_55C9:: ; address name
    db $F8, $F8, $08, $00 ; entry 0
    db $F8, $00, $09, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set29Frame4::
Data_07F_55DA:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set29Frame5::
Data_07F_55EB:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $FF, $0C, $20 ; entry 2
    db $F8, $F7, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 42 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set2A::
Data_07F_55FC:: ; address name
    dw MetaSprites7F_4008Set2AFrame0 ; entry 0
    dw MetaSprites7F_4008Set2AFrame1 ; entry 1
    dw MetaSprites7F_4008Set2AFrame2 ; entry 2
    dw MetaSprites7F_4008Set2AFrame3 ; entry 3
    dw MetaSprites7F_4008Set2AFrame4 ; entry 4
    dw MetaSprites7F_4008Set2AFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2AFrame0::
Data_07F_5608:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2AFrame1::
Data_07F_5619:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2AFrame2::
Data_07F_562A:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2AFrame3::
Data_07F_563B:: ; address name
    db $F8, $F8, $08, $00 ; entry 0
    db $F8, $00, $09, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2AFrame4::
Data_07F_564C:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2AFrame5::
Data_07F_565D:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $FF, $0C, $20 ; entry 2
    db $F8, $F7, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 43 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set2B::
Data_07F_566E:: ; address name
    dw MetaSprites7F_4008Set2BFrame0 ; entry 0
    dw MetaSprites7F_4008Set2BFrame1 ; entry 1
    dw MetaSprites7F_4008Set2BFrame2 ; entry 2
    dw MetaSprites7F_4008Set2BFrame3 ; entry 3
    dw MetaSprites7F_4008Set2BFrame4 ; entry 4
    dw MetaSprites7F_4008Set2BFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set2B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2BFrame0::
Data_07F_567A:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set2B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2BFrame1::
Data_07F_568B:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $F8, $02, $00 ; entry 2
    db $F9, $00, $04, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set2B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2BFrame2::
Data_07F_569C:: ; address name
    db $F0, $F8, $05, $00 ; entry 0
    db $F0, $00, $06, $00 ; entry 1
    db $F8, $F8, $07, $00 ; entry 2
    db $F8, $00, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set2B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2BFrame3::
Data_07F_56AD:: ; address name
    db $F1, $F8, $05, $00 ; entry 0
    db $F1, $00, $06, $00 ; entry 1
    db $F9, $00, $08, $00 ; entry 2
    db $F9, $F8, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set2B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2BFrame4::
Data_07F_56BE:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set2B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2BFrame5::
Data_07F_56CF:: ; address name
    db $F1, $F8, $0A, $00 ; entry 0
    db $F1, $00, $0B, $00 ; entry 1
    db $F9, $00, $0E, $00 ; entry 2
    db $F9, $F8, $0C, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 44 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set2C::
Data_07F_56E0:: ; address name
    dw MetaSprites7F_4008Set2CFrame0 ; entry 0
    dw MetaSprites7F_4008Set2CFrame1 ; entry 1
    dw MetaSprites7F_4008Set2CFrame2 ; entry 2
    dw MetaSprites7F_4008Set2CFrame3 ; entry 3
    dw MetaSprites7F_4008Set2CFrame4 ; entry 4
    dw MetaSprites7F_4008Set2CFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set2C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2CFrame0::
Data_07F_56EC:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set2C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2CFrame1::
Data_07F_56FD:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $F8, $02, $00 ; entry 2
    db $F9, $00, $04, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set2C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2CFrame2::
Data_07F_570E:: ; address name
    db $F0, $F8, $05, $00 ; entry 0
    db $F0, $00, $06, $00 ; entry 1
    db $F8, $F8, $07, $00 ; entry 2
    db $F8, $00, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set2C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2CFrame3::
Data_07F_571F:: ; address name
    db $F1, $F8, $05, $00 ; entry 0
    db $F1, $00, $06, $00 ; entry 1
    db $F9, $00, $08, $00 ; entry 2
    db $F9, $F8, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set2C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2CFrame4::
Data_07F_5730:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $FD, $0A, $20 ; entry 1
    db $F8, $F8, $0B, $00 ; entry 2
    db $F8, $00, $0C, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set2C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2CFrame5::
Data_07F_5741:: ; address name
    db $F9, $F8, $0E, $00 ; entry 0
    db $F9, $00, $0F, $00 ; entry 1
    db $F1, $F8, $0D, $00 ; entry 2
    db $F1, $FD, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 45 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set2D::
Data_07F_5752:: ; address name
    dw MetaSprites7F_4008Set2DFrame0 ; entry 0
    dw MetaSprites7F_4008Set2DFrame1 ; entry 1
    dw MetaSprites7F_4008Set2DFrame2 ; entry 2
    dw MetaSprites7F_4008Set2DFrame3 ; entry 3
    dw MetaSprites7F_4008Set2DFrame4 ; entry 4
    dw MetaSprites7F_4008Set2DFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set2D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2DFrame0::
Data_07F_575E:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set2D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2DFrame1::
Data_07F_576F:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set2D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2DFrame2::
Data_07F_5780:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set2D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2DFrame3::
Data_07F_5791:: ; address name
    db $F8, $F8, $08, $00 ; entry 0
    db $F8, $00, $09, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set2D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2DFrame4::
Data_07F_57A2:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set2D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2DFrame5::
Data_07F_57B3:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $FF, $0C, $20 ; entry 2
    db $F8, $F7, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 46 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set2E::
Data_07F_57C4:: ; address name
    dw MetaSprites7F_4008Set2EFrame0 ; entry 0
    dw MetaSprites7F_4008Set2EFrame1 ; entry 1
    dw MetaSprites7F_4008Set2EFrame2 ; entry 2
    dw MetaSprites7F_4008Set2EFrame3 ; entry 3
    dw MetaSprites7F_4008Set2EFrame4 ; entry 4
    dw MetaSprites7F_4008Set2EFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2EFrame0::
Data_07F_57D0:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2EFrame1::
Data_07F_57E1:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2EFrame2::
Data_07F_57F2:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2EFrame3::
Data_07F_5803:: ; address name
    db $F8, $F8, $08, $00 ; entry 0
    db $F8, $00, $09, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2EFrame4::
Data_07F_5814:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set2E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2EFrame5::
Data_07F_5825:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $FF, $0C, $20 ; entry 2
    db $F8, $F7, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 47 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set2F::
Data_07F_5836:: ; address name
    dw MetaSprites7F_4008Set2FFrame0 ; entry 0
    dw MetaSprites7F_4008Set2FFrame1 ; entry 1
    dw MetaSprites7F_4008Set2FFrame2 ; entry 2
    dw MetaSprites7F_4008Set2FFrame3 ; entry 3
    dw MetaSprites7F_4008Set2FFrame4 ; entry 4
    dw MetaSprites7F_4008Set2FFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set2F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2FFrame0::
Data_07F_5842:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set2F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2FFrame1::
Data_07F_5853:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set2F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2FFrame2::
Data_07F_5864:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set2F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2FFrame3::
Data_07F_5875:: ; address name
    db $F8, $F8, $08, $00 ; entry 0
    db $F8, $00, $09, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set2F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2FFrame4::
Data_07F_5886:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set2F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set2FFrame5::
Data_07F_5897:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $FF, $0C, $20 ; entry 2
    db $F8, $F7, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 48 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set30::
Data_07F_58A8:: ; address name
    dw MetaSprites7F_4008Set30Frame0 ; entry 0
    dw MetaSprites7F_4008Set30Frame1 ; entry 1
    dw MetaSprites7F_4008Set30Frame2 ; entry 2
    dw MetaSprites7F_4008Set30Frame3 ; entry 3
    dw MetaSprites7F_4008Set30Frame4 ; entry 4
    dw MetaSprites7F_4008Set30Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set30; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set30Frame0::
Data_07F_58B4:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set30; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set30Frame1::
Data_07F_58C5:: ; address name
    db $F8, $FF, $02, $20 ; entry 0
    db $F8, $F7, $03, $20 ; entry 1
    db $F0, $F6, $00, $00 ; entry 2
    db $F0, $FE, $01, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set30; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set30Frame2::
Data_07F_58D6:: ; address name
    db $F0, $F6, $04, $00 ; entry 0
    db $F0, $FE, $05, $00 ; entry 1
    db $F8, $F6, $06, $00 ; entry 2
    db $F8, $FE, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set30; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set30Frame3::
Data_07F_58E7:: ; address name
    db $F8, $F7, $08, $00 ; entry 0
    db $F8, $FF, $09, $00 ; entry 1
    db $F0, $F7, $04, $00 ; entry 2
    db $F0, $FF, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set30; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set30Frame4::
Data_07F_58F8:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set30; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set30Frame5::
Data_07F_5909:: ; address name
    db $F8, $FF, $0C, $20 ; entry 0
    db $F8, $F7, $0D, $20 ; entry 1
    db $F0, $F6, $0A, $00 ; entry 2
    db $F0, $FE, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 49 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set31::
Data_07F_591A:: ; address name
    dw MetaSprites7F_4008Set31Frame0 ; entry 0
    dw MetaSprites7F_4008Set31Frame1 ; entry 1
    dw MetaSprites7F_4008Set31Frame2 ; entry 2
    dw MetaSprites7F_4008Set31Frame3 ; entry 3
    dw MetaSprites7F_4008Set31Frame4 ; entry 4
    dw MetaSprites7F_4008Set31Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set31Frame0::
Data_07F_5926:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set31Frame1::
Data_07F_5937:: ; address name
    db $F8, $FF, $02, $20 ; entry 0
    db $F8, $F7, $03, $20 ; entry 1
    db $F0, $F8, $00, $00 ; entry 2
    db $F0, $00, $01, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set31Frame2::
Data_07F_5948:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set31Frame3::
Data_07F_5959:: ; address name
    db $F8, $F8, $08, $00 ; entry 0
    db $F8, $00, $09, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set31Frame4::
Data_07F_596A:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set31; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set31Frame5::
Data_07F_597B:: ; address name
    db $F8, $FF, $0C, $20 ; entry 0
    db $F8, $F7, $0D, $20 ; entry 1
    db $F0, $F8, $0A, $00 ; entry 2
    db $F0, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 50 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set32::
Data_07F_598C:: ; address name
    dw MetaSprites7F_4008Set32Frame0 ; entry 0
    dw MetaSprites7F_4008Set32Frame1 ; entry 1
    dw MetaSprites7F_4008Set32Frame2 ; entry 2
    dw MetaSprites7F_4008Set32Frame3 ; entry 3
    dw MetaSprites7F_4008Set32Frame4 ; entry 4
    dw MetaSprites7F_4008Set32Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set32; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set32Frame0::
Data_07F_5998:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set32; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set32Frame1::
Data_07F_59A9:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $FF, $01, $20 ; entry 2
    db $F8, $F7, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set32; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set32Frame2::
Data_07F_59BA:: ; address name
    db $F0, $F8, $03, $00 ; entry 0
    db $F0, $00, $04, $00 ; entry 1
    db $F8, $F8, $05, $00 ; entry 2
    db $F8, $00, $06, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set32; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set32Frame3::
Data_07F_59CB:: ; address name
    db $F0, $F8, $03, $00 ; entry 0
    db $F0, $00, $04, $00 ; entry 1
    db $F8, $F8, $07, $00 ; entry 2
    db $F8, $00, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set32; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set32Frame4::
Data_07F_59DC:: ; address name
    db $F0, $F8, $09, $00 ; entry 0
    db $F0, $FF, $09, $20 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set32; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set32Frame5::
Data_07F_59ED:: ; address name
    db $F0, $F8, $09, $00 ; entry 0
    db $F0, $FF, $09, $20 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 51 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set33::
Data_07F_59FE:: ; address name
    dw MetaSprites7F_4008Set33Frame0 ; entry 0
    dw MetaSprites7F_4008Set33Frame1 ; entry 1
    dw MetaSprites7F_4008Set33Frame2 ; entry 2
    dw MetaSprites7F_4008Set33Frame3 ; entry 3
    dw MetaSprites7F_4008Set33Frame4 ; entry 4
    dw MetaSprites7F_4008Set33Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set33; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set33Frame0::
Data_07F_5A0A:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set33; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set33Frame1::
Data_07F_5A1B:: ; address name
    db $F8, $FF, $02, $20 ; entry 0
    db $F8, $F7, $03, $20 ; entry 1
    db $F0, $F8, $00, $00 ; entry 2
    db $F0, $00, $01, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set33; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set33Frame2::
Data_07F_5A2C:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set33; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set33Frame3::
Data_07F_5A3D:: ; address name
    db $F8, $F8, $08, $00 ; entry 0
    db $F8, $00, $09, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set33; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set33Frame4::
Data_07F_5A4E:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set33; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set33Frame5::
Data_07F_5A5F:: ; address name
    db $F8, $FF, $0C, $20 ; entry 0
    db $F8, $F7, $0D, $20 ; entry 1
    db $F0, $F8, $0A, $00 ; entry 2
    db $F0, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 52 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set34::
Data_07F_5A70:: ; address name
    dw MetaSprites7F_4008Set34Frame0 ; entry 0
    dw MetaSprites7F_4008Set34Frame1 ; entry 1
    dw MetaSprites7F_4008Set34Frame2 ; entry 2
    dw MetaSprites7F_4008Set34Frame3 ; entry 3
    dw MetaSprites7F_4008Set34Frame4 ; entry 4
    dw MetaSprites7F_4008Set34Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set34Frame0::
Data_07F_5A7C:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set34Frame1::
Data_07F_5A8D:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $FF, $01, $20 ; entry 2
    db $F8, $F7, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set34Frame2::
Data_07F_5A9E:: ; address name
    db $F0, $F8, $03, $00 ; entry 0
    db $F0, $00, $04, $00 ; entry 1
    db $F8, $F8, $05, $00 ; entry 2
    db $F8, $00, $06, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set34Frame3::
Data_07F_5AAF:: ; address name
    db $F0, $F8, $03, $00 ; entry 0
    db $F0, $00, $04, $00 ; entry 1
    db $F8, $F8, $07, $00 ; entry 2
    db $F8, $00, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set34Frame4::
Data_07F_5AC0:: ; address name
    db $F0, $F8, $09, $00 ; entry 0
    db $F0, $FF, $09, $20 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set34Frame5::
Data_07F_5AD1:: ; address name
    db $F0, $F8, $09, $00 ; entry 0
    db $F0, $FF, $09, $20 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 53 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set35::
Data_07F_5AE2:: ; address name
    dw MetaSprites7F_4008Set35Frame0 ; entry 0
    dw MetaSprites7F_4008Set35Frame1 ; entry 1
    dw MetaSprites7F_4008Set35Frame2 ; entry 2
    dw MetaSprites7F_4008Set35Frame3 ; entry 3
    dw MetaSprites7F_4008Set35Frame4 ; entry 4
    dw MetaSprites7F_4008Set35Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set35Frame0::
Data_07F_5AEE:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set35Frame1::
Data_07F_5AFF:: ; address name
    db $F8, $FE, $02, $20 ; entry 0
    db $F8, $F6, $03, $20 ; entry 1
    db $F0, $F7, $00, $00 ; entry 2
    db $F0, $FF, $01, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set35Frame2::
Data_07F_5B10:: ; address name
    db $F0, $F9, $04, $00 ; entry 0
    db $F0, $01, $05, $00 ; entry 1
    db $F8, $F9, $06, $00 ; entry 2
    db $F8, $01, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set35Frame3::
Data_07F_5B21:: ; address name
    db $F8, $F8, $08, $00 ; entry 0
    db $F8, $00, $09, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set35Frame4::
Data_07F_5B32:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set35Frame5::
Data_07F_5B43:: ; address name
    db $F8, $00, $0C, $20 ; entry 0
    db $F8, $F8, $0D, $20 ; entry 1
    db $F0, $F9, $0A, $00 ; entry 2
    db $F0, $01, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 54 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set36::
Data_07F_5B54:: ; address name
    dw MetaSprites7F_4008Set36Frame0 ; entry 0
    dw MetaSprites7F_4008Set36Frame1 ; entry 1
    dw MetaSprites7F_4008Set36Frame2 ; entry 2
    dw MetaSprites7F_4008Set36Frame3 ; entry 3
    dw MetaSprites7F_4008Set36Frame4 ; entry 4
    dw MetaSprites7F_4008Set36Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set36Frame0::
Data_07F_5B60:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set36Frame1::
Data_07F_5B71:: ; address name
    db $F8, $FF, $02, $20 ; entry 0
    db $F8, $F7, $03, $20 ; entry 1
    db $F0, $F8, $00, $00 ; entry 2
    db $F0, $00, $01, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set36Frame2::
Data_07F_5B82:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set36Frame3::
Data_07F_5B93:: ; address name
    db $F8, $F8, $08, $00 ; entry 0
    db $F8, $00, $09, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set36Frame4::
Data_07F_5BA4:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set36Frame5::
Data_07F_5BB5:: ; address name
    db $F8, $FF, $0C, $20 ; entry 0
    db $F8, $F7, $0D, $20 ; entry 1
    db $F0, $F8, $0A, $00 ; entry 2
    db $F0, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 55 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set37::
Data_07F_5BC6:: ; address name
    dw MetaSprites7F_4008Set37Frame0 ; entry 0
    dw MetaSprites7F_4008Set37Frame1 ; entry 1
    dw MetaSprites7F_4008Set37Frame2 ; entry 2
    dw MetaSprites7F_4008Set37Frame3 ; entry 3
    dw MetaSprites7F_4008Set37Frame4 ; entry 4
    dw MetaSprites7F_4008Set37Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set37Frame0::
Data_07F_5BD2:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set37Frame1::
Data_07F_5BE3:: ; address name
    db $F8, $FF, $02, $20 ; entry 0
    db $F8, $F7, $03, $20 ; entry 1
    db $F0, $F8, $00, $00 ; entry 2
    db $F0, $00, $01, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set37Frame2::
Data_07F_5BF4:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set37Frame3::
Data_07F_5C05:: ; address name
    db $F8, $F8, $08, $00 ; entry 0
    db $F8, $00, $09, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set37Frame4::
Data_07F_5C16:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set37Frame5::
Data_07F_5C27:: ; address name
    db $F8, $FF, $0C, $20 ; entry 0
    db $F8, $F7, $0D, $20 ; entry 1
    db $F0, $F8, $0A, $00 ; entry 2
    db $F0, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 56 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set38::
Data_07F_5C38:: ; address name
    dw MetaSprites7F_4008Set38Frame0 ; entry 0
    dw MetaSprites7F_4008Set38Frame1 ; entry 1
    dw MetaSprites7F_4008Set38Frame2 ; entry 2
    dw MetaSprites7F_4008Set38Frame3 ; entry 3
    dw MetaSprites7F_4008Set38Frame4 ; entry 4
    dw MetaSprites7F_4008Set38Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set38Frame0::
Data_07F_5C44:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set38Frame1::
Data_07F_5C55:: ; address name
    db $F8, $FF, $02, $20 ; entry 0
    db $F8, $F7, $03, $20 ; entry 1
    db $F0, $F8, $00, $00 ; entry 2
    db $F0, $00, $01, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set38Frame2::
Data_07F_5C66:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set38Frame3::
Data_07F_5C77:: ; address name
    db $F8, $F8, $08, $00 ; entry 0
    db $F8, $00, $09, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set38Frame4::
Data_07F_5C88:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set38Frame5::
Data_07F_5C99:: ; address name
    db $F8, $FF, $0C, $20 ; entry 0
    db $F8, $F7, $0D, $20 ; entry 1
    db $F0, $F8, $0A, $00 ; entry 2
    db $F0, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 57 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set39::
Data_07F_5CAA:: ; address name
    dw MetaSprites7F_4008Set39Frame0 ; entry 0
    dw MetaSprites7F_4008Set39Frame1 ; entry 1
    dw MetaSprites7F_4008Set39Frame2 ; entry 2
    dw MetaSprites7F_4008Set39Frame3 ; entry 3
    dw MetaSprites7F_4008Set39Frame4 ; entry 4
    dw MetaSprites7F_4008Set39Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set39Frame0::
Data_07F_5CB6:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set39Frame1::
Data_07F_5CC7:: ; address name
    db $F8, $FF, $02, $20 ; entry 0
    db $F8, $F7, $03, $20 ; entry 1
    db $F0, $F8, $00, $00 ; entry 2
    db $F0, $00, $01, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set39Frame2::
Data_07F_5CD8:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set39Frame3::
Data_07F_5CE9:: ; address name
    db $F8, $F8, $08, $00 ; entry 0
    db $F8, $00, $09, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set39Frame4::
Data_07F_5CFA:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set39Frame5::
Data_07F_5D0B:: ; address name
    db $F8, $FF, $0C, $20 ; entry 0
    db $F8, $F7, $0D, $20 ; entry 1
    db $F0, $F8, $0A, $00 ; entry 2
    db $F0, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 58 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set3A::
Data_07F_5D1C:: ; address name
    dw MetaSprites7F_4008Set3AFrame0 ; entry 0
    dw MetaSprites7F_4008Set3AFrame1 ; entry 1
    dw MetaSprites7F_4008Set3AFrame2 ; entry 2
    dw MetaSprites7F_4008Set3AFrame3 ; entry 3
    dw MetaSprites7F_4008Set3AFrame4 ; entry 4
    dw MetaSprites7F_4008Set3AFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3AFrame0::
Data_07F_5D28:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3AFrame1::
Data_07F_5D39:: ; address name
    db $F8, $FF, $02, $20 ; entry 0
    db $F8, $F7, $03, $20 ; entry 1
    db $F0, $F8, $00, $00 ; entry 2
    db $F0, $00, $01, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3AFrame2::
Data_07F_5D4A:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3AFrame3::
Data_07F_5D5B:: ; address name
    db $F8, $F8, $08, $00 ; entry 0
    db $F8, $00, $09, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3AFrame4::
Data_07F_5D6C:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3AFrame5::
Data_07F_5D7D:: ; address name
    db $F8, $FF, $0C, $20 ; entry 0
    db $F8, $F7, $0D, $20 ; entry 1
    db $F0, $F8, $0A, $00 ; entry 2
    db $F0, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 59 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set3B::
Data_07F_5D8E:: ; address name
    dw MetaSprites7F_4008Set3BFrame0 ; entry 0
    dw MetaSprites7F_4008Set3BFrame1 ; entry 1
    dw MetaSprites7F_4008Set3BFrame2 ; entry 2
    dw MetaSprites7F_4008Set3BFrame3 ; entry 3
    dw MetaSprites7F_4008Set3BFrame4 ; entry 4
    dw MetaSprites7F_4008Set3BFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set3B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3BFrame0::
Data_07F_5D9A:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set3B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3BFrame1::
Data_07F_5DAB:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $00, $01, $20 ; entry 2
    db $F8, $F8, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set3B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3BFrame2::
Data_07F_5DBC:: ; address name
    db $F0, $F8, $03, $00 ; entry 0
    db $F0, $00, $04, $00 ; entry 1
    db $F8, $F8, $05, $00 ; entry 2
    db $F8, $00, $06, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set3B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3BFrame3::
Data_07F_5DCD:: ; address name
    db $F0, $F8, $03, $00 ; entry 0
    db $F0, $00, $04, $00 ; entry 1
    db $F8, $F8, $07, $00 ; entry 2
    db $F8, $00, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set3B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3BFrame4::
Data_07F_5DDE:: ; address name
    db $F0, $F8, $09, $00 ; entry 0
    db $F0, $00, $09, $20 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set3B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3BFrame5::
Data_07F_5DEF:: ; address name
    db $F0, $F8, $09, $00 ; entry 0
    db $F0, $00, $09, $20 ; entry 1
    db $F8, $00, $0A, $20 ; entry 2
    db $F8, $F8, $0B, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 60 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set3C::
Data_07F_5E00:: ; address name
    dw MetaSprites7F_4008Set3CFrame0 ; entry 0
    dw MetaSprites7F_4008Set3CFrame1 ; entry 1
    dw MetaSprites7F_4008Set3CFrame2 ; entry 2
    dw MetaSprites7F_4008Set3CFrame3 ; entry 3
    dw MetaSprites7F_4008Set3CFrame4 ; entry 4
    dw MetaSprites7F_4008Set3CFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set3C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3CFrame0::
Data_07F_5E0C:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set3C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3CFrame1::
Data_07F_5E1D:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $FF, $01, $20 ; entry 1
    db $F8, $F7, $02, $20 ; entry 2
    db $F0, $FF, $00, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set3C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3CFrame2::
Data_07F_5E2E:: ; address name
    db $F0, $F8, $03, $00 ; entry 0
    db $F0, $00, $04, $00 ; entry 1
    db $F8, $F8, $05, $00 ; entry 2
    db $F8, $00, $06, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set3C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3CFrame3::
Data_07F_5E3F:: ; address name
    db $F0, $F8, $03, $00 ; entry 0
    db $F0, $00, $04, $00 ; entry 1
    db $F8, $F8, $07, $00 ; entry 2
    db $F8, $00, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set3C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3CFrame4::
Data_07F_5E50:: ; address name
    db $F0, $F8, $09, $00 ; entry 0
    db $F8, $F8, $0A, $00 ; entry 1
    db $F8, $00, $0B, $00 ; entry 2
    db $F0, $FF, $09, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set3C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3CFrame5::
Data_07F_5E61:: ; address name
    db $F0, $F8, $09, $00 ; entry 0
    db $F8, $FF, $0A, $20 ; entry 1
    db $F8, $F7, $0B, $20 ; entry 2
    db $F0, $FF, $09, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 61 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set3D::
Data_07F_5E72:: ; address name
    dw MetaSprites7F_4008Set3DFrame0 ; entry 0
    dw MetaSprites7F_4008Set3DFrame1 ; entry 1
    dw MetaSprites7F_4008Set3DFrame2 ; entry 2
    dw MetaSprites7F_4008Set3DFrame3 ; entry 3
    dw MetaSprites7F_4008Set3DFrame4 ; entry 4
    dw MetaSprites7F_4008Set3DFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set3D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3DFrame0::
Data_07F_5E7E:: ; address name
    db $F8, $F8, $02, $00 ; entry 0
    db $F8, $00, $03, $00 ; entry 1
    db $F0, $F8, $00, $00 ; entry 2
    db $F0, $00, $01, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set3D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3DFrame1::
Data_07F_5E8F:: ; address name
    db $F0, $FF, $00, $20 ; entry 0
    db $F0, $F7, $01, $20 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set3D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3DFrame2::
Data_07F_5EA0:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set3D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3DFrame3::
Data_07F_5EB1:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set3D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3DFrame4::
Data_07F_5EC2:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set3D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3DFrame5::
Data_07F_5ED3:: ; address name
    db $F0, $FF, $0A, $20 ; entry 0
    db $F0, $F7, $0B, $20 ; entry 1
    db $F8, $FF, $0C, $20 ; entry 2
    db $F8, $F7, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 62 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set3E::
Data_07F_5EE4:: ; address name
    dw MetaSprites7F_4008Set3EFrame0 ; entry 0
    dw MetaSprites7F_4008Set3EFrame1 ; entry 1
    dw MetaSprites7F_4008Set3EFrame2 ; entry 2
    dw MetaSprites7F_4008Set3EFrame3 ; entry 3
    dw MetaSprites7F_4008Set3EFrame4 ; entry 4
    dw MetaSprites7F_4008Set3EFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set3E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3EFrame0::
Data_07F_5EF0:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set3E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3EFrame1::
Data_07F_5F01:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $FF, $01, $20 ; entry 1
    db $F8, $F7, $02, $20 ; entry 2
    db $F0, $FF, $00, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set3E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3EFrame2::
Data_07F_5F12:: ; address name
    db $F0, $F8, $03, $00 ; entry 0
    db $F0, $00, $04, $00 ; entry 1
    db $F8, $F8, $05, $00 ; entry 2
    db $F8, $00, $06, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set3E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3EFrame3::
Data_07F_5F23:: ; address name
    db $F0, $F8, $03, $00 ; entry 0
    db $F0, $00, $04, $00 ; entry 1
    db $F8, $F8, $07, $00 ; entry 2
    db $F8, $00, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set3E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3EFrame4::
Data_07F_5F34:: ; address name
    db $F0, $F8, $09, $00 ; entry 0
    db $F8, $F8, $0A, $00 ; entry 1
    db $F8, $00, $0B, $00 ; entry 2
    db $F0, $FF, $09, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set3E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3EFrame5::
Data_07F_5F45:: ; address name
    db $F0, $F8, $09, $00 ; entry 0
    db $F8, $FF, $0A, $20 ; entry 1
    db $F8, $F7, $0B, $20 ; entry 2
    db $F0, $FF, $09, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 63 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set3F::
Data_07F_5F56:: ; address name
    dw MetaSprites7F_4008Set3FFrame0 ; entry 0
    dw MetaSprites7F_4008Set3FFrame1 ; entry 1
    dw MetaSprites7F_4008Set3FFrame2 ; entry 2
    dw MetaSprites7F_4008Set3FFrame3 ; entry 3
    dw MetaSprites7F_4008Set3FFrame4 ; entry 4
    dw MetaSprites7F_4008Set3FFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set3F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3FFrame0::
Data_07F_5F62:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set3F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3FFrame1::
Data_07F_5F73:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $FF, $01, $20 ; entry 1
    db $F8, $F7, $02, $20 ; entry 2
    db $F0, $FF, $00, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set3F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3FFrame2::
Data_07F_5F84:: ; address name
    db $F0, $F5, $03, $00 ; entry 0
    db $F0, $FD, $04, $00 ; entry 1
    db $F8, $F5, $05, $00 ; entry 2
    db $F8, $FD, $06, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set3F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3FFrame3::
Data_07F_5F95:: ; address name
    db $F0, $FD, $04, $00 ; entry 0
    db $F0, $F5, $07, $00 ; entry 1
    db $F8, $F5, $08, $00 ; entry 2
    db $F8, $FD, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set3F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3FFrame4::
Data_07F_5FA6:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $FF, $0A, $20 ; entry 1
    db $F8, $F8, $0B, $00 ; entry 2
    db $F8, $00, $0C, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set3F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set3FFrame5::
Data_07F_5FB7:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $FF, $0A, $20 ; entry 1
    db $F8, $FF, $0B, $20 ; entry 2
    db $F8, $F7, $0C, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 64 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set40::
Data_07F_5FC8:: ; address name
    dw MetaSprites7F_4008Set40Frame0 ; entry 0
    dw MetaSprites7F_4008Set40Frame1 ; entry 1
    dw MetaSprites7F_4008Set40Frame2 ; entry 2
    dw MetaSprites7F_4008Set40Frame3 ; entry 3
    dw MetaSprites7F_4008Set40Frame4 ; entry 4
    dw MetaSprites7F_4008Set40Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set40; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set40Frame0::
Data_07F_5FD4:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set40; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set40Frame1::
Data_07F_5FE5:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $FF, $01, $20 ; entry 1
    db $F8, $F7, $02, $20 ; entry 2
    db $F0, $FF, $00, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set40; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set40Frame2::
Data_07F_5FF6:: ; address name
    db $F0, $F5, $03, $00 ; entry 0
    db $F0, $FD, $04, $00 ; entry 1
    db $F8, $F5, $05, $00 ; entry 2
    db $F8, $FD, $06, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set40; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set40Frame3::
Data_07F_6007:: ; address name
    db $F0, $FD, $04, $00 ; entry 0
    db $F0, $F5, $07, $00 ; entry 1
    db $F8, $F5, $08, $00 ; entry 2
    db $F8, $FD, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set40; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set40Frame4::
Data_07F_6018:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $FF, $0A, $20 ; entry 1
    db $F8, $F8, $0B, $00 ; entry 2
    db $F8, $00, $0C, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set40; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set40Frame5::
Data_07F_6029:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $FF, $0A, $20 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0E, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 65 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set41::
Data_07F_603A:: ; address name
    dw MetaSprites7F_4008Set41Frame0 ; entry 0
    dw MetaSprites7F_4008Set41Frame1 ; entry 1
    dw MetaSprites7F_4008Set41Frame2 ; entry 2
    dw MetaSprites7F_4008Set41Frame3 ; entry 3
    dw MetaSprites7F_4008Set41Frame4 ; entry 4
    dw MetaSprites7F_4008Set41Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set41; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set41Frame0::
Data_07F_6046:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $01, $00 ; entry 1
    db $F8, $00, $02, $00 ; entry 2
    db $F0, $00, $00, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set41; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set41Frame1::
Data_07F_6057:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $00, $01, $20 ; entry 2
    db $F8, $F8, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set41; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set41Frame2::
Data_07F_6068:: ; address name
    db $F0, $F7, $03, $00 ; entry 0
    db $F0, $FF, $04, $00 ; entry 1
    db $F8, $F7, $05, $00 ; entry 2
    db $F8, $FF, $06, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set41; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set41Frame3::
Data_07F_6079:: ; address name
    db $F0, $FF, $04, $00 ; entry 0
    db $F0, $F7, $07, $00 ; entry 1
    db $F8, $F7, $08, $00 ; entry 2
    db $F8, $FF, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set41; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set41Frame4::
Data_07F_608A:: ; address name
    db $F0, $F8, $0B, $00 ; entry 0
    db $F8, $F8, $0C, $00 ; entry 1
    db $F8, $00, $0D, $00 ; entry 2
    db $F0, $00, $0B, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set41; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set41Frame5::
Data_07F_609B:: ; address name
    db $F0, $00, $0B, $20 ; entry 0
    db $F8, $00, $0C, $20 ; entry 1
    db $F8, $F8, $0D, $20 ; entry 2
    db $F0, $F8, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 66 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set42::
Data_07F_60AC:: ; address name
    dw MetaSprites7F_4008Set42Frame0 ; entry 0
    dw MetaSprites7F_4008Set42Frame1 ; entry 1
    dw MetaSprites7F_4008Set42Frame2 ; entry 2
    dw MetaSprites7F_4008Set42Frame3 ; entry 3
    dw MetaSprites7F_4008Set42Frame4 ; entry 4
    dw MetaSprites7F_4008Set42Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set42; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set42Frame0::
Data_07F_60B8:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $02, $00 ; entry 1
    db $F8, $00, $03, $00 ; entry 2
    db $F0, $FF, $00, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set42; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set42Frame1::
Data_07F_60C9:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set42; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set42Frame2::
Data_07F_60DA:: ; address name
    db $F0, $F7, $04, $00 ; entry 0
    db $F0, $FF, $05, $00 ; entry 1
    db $F8, $F7, $06, $00 ; entry 2
    db $F8, $FF, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set42; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set42Frame3::
Data_07F_60EB:: ; address name
    db $F0, $FF, $05, $00 ; entry 0
    db $F0, $F7, $08, $00 ; entry 1
    db $F8, $F7, $09, $00 ; entry 2
    db $F8, $FF, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set42; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set42Frame4::
Data_07F_60FC:: ; address name
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $00, $0C, $00 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0E, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set42; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set42Frame5::
Data_07F_610D:: ; address name
    db $F0, $FF, $0B, $20 ; entry 0
    db $F0, $F7, $0C, $20 ; entry 1
    db $F8, $FF, $0D, $20 ; entry 2
    db $F8, $F7, $0E, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 67 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set43::
Data_07F_611E:: ; address name
    dw MetaSprites7F_4008Set43Frame0 ; entry 0
    dw MetaSprites7F_4008Set43Frame1 ; entry 1
    dw MetaSprites7F_4008Set43Frame2 ; entry 2
    dw MetaSprites7F_4008Set43Frame3 ; entry 3
    dw MetaSprites7F_4008Set43Frame4 ; entry 4
    dw MetaSprites7F_4008Set43Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set43; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set43Frame0::
Data_07F_612A:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set43; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set43Frame1::
Data_07F_613B:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $FF, $01, $20 ; entry 2
    db $F8, $F7, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set43; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set43Frame2::
Data_07F_614C:: ; address name
    db $F0, $F7, $03, $00 ; entry 0
    db $F0, $FF, $04, $00 ; entry 1
    db $F8, $F7, $05, $00 ; entry 2
    db $F8, $FF, $06, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set43; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set43Frame3::
Data_07F_615D:: ; address name
    db $F0, $F7, $03, $00 ; entry 0
    db $F0, $FF, $04, $00 ; entry 1
    db $F8, $F7, $07, $00 ; entry 2
    db $F8, $FF, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set43; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set43Frame4::
Data_07F_616E:: ; address name
    db $F0, $F8, $09, $00 ; entry 0
    db $F0, $FF, $09, $20 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set43; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set43Frame5::
Data_07F_617F:: ; address name
    db $F0, $F8, $09, $00 ; entry 0
    db $F0, $FF, $09, $20 ; entry 1
    db $F8, $FF, $0A, $20 ; entry 2
    db $F8, $F7, $0B, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 68 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set44::
Data_07F_6190:: ; address name
    dw MetaSprites7F_4008Set44Frame0 ; entry 0
    dw MetaSprites7F_4008Set44Frame1 ; entry 1
    dw MetaSprites7F_4008Set44Frame2 ; entry 2
    dw MetaSprites7F_4008Set44Frame3 ; entry 3
    dw MetaSprites7F_4008Set44Frame4 ; entry 4
    dw MetaSprites7F_4008Set44Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set44; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set44Frame0::
Data_07F_619C:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set44; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set44Frame1::
Data_07F_61AD:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $FF, $01, $20 ; entry 2
    db $F8, $F7, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set44; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set44Frame2::
Data_07F_61BE:: ; address name
    db $F0, $F8, $03, $00 ; entry 0
    db $F0, $00, $04, $00 ; entry 1
    db $F8, $F8, $05, $00 ; entry 2
    db $F8, $00, $06, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set44; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set44Frame3::
Data_07F_61CF:: ; address name
    db $F8, $F8, $07, $00 ; entry 0
    db $F8, $00, $08, $00 ; entry 1
    db $F0, $F7, $03, $00 ; entry 2
    db $F0, $FF, $04, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set44; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set44Frame4::
Data_07F_61E0:: ; address name
    db $F0, $F8, $09, $00 ; entry 0
    db $F0, $FF, $09, $20 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set44; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set44Frame5::
Data_07F_61F1:: ; address name
    db $F0, $F8, $09, $00 ; entry 0
    db $F0, $FF, $09, $20 ; entry 1
    db $F8, $FF, $0A, $20 ; entry 2
    db $F8, $F7, $0B, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 69 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set45::
Data_07F_6202:: ; address name
    dw MetaSprites7F_4008Set45Frame0 ; entry 0
    dw MetaSprites7F_4008Set45Frame1 ; entry 1
    dw MetaSprites7F_4008Set45Frame2 ; entry 2
    dw MetaSprites7F_4008Set45Frame3 ; entry 3
    dw MetaSprites7F_4008Set45Frame4 ; entry 4
    dw MetaSprites7F_4008Set45Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set45; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set45Frame0::
Data_07F_620E:: ; address name
    db $F8, $F8, $02, $00 ; entry 0
    db $F0, $F8, $00, $00 ; entry 1
    db $F0, $00, $01, $00 ; entry 2
    db $F8, $FF, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set45; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set45Frame1::
Data_07F_621F:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F9, $F8, $03, $00 ; entry 1
    db $F1, $00, $01, $00 ; entry 2
    db $F9, $FF, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set45; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set45Frame2::
Data_07F_6230:: ; address name
    db $F0, $F7, $04, $00 ; entry 0
    db $F0, $FF, $05, $00 ; entry 1
    db $F8, $F7, $06, $00 ; entry 2
    db $F8, $FF, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set45; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set45Frame3::
Data_07F_6241:: ; address name
    db $F9, $F7, $08, $00 ; entry 0
    db $F9, $FF, $09, $00 ; entry 1
    db $F1, $F8, $04, $00 ; entry 2
    db $F1, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set45; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set45Frame4::
Data_07F_6252:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F8, $F8, $0C, $00 ; entry 1
    db $F8, $FF, $0C, $20 ; entry 2
    db $F0, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set45; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set45Frame5::
Data_07F_6263:: ; address name
    db $F1, $F8, $0A, $00 ; entry 0
    db $F1, $00, $0B, $00 ; entry 1
    db $F9, $F8, $0D, $00 ; entry 2
    db $F9, $FF, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 70 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set46::
Data_07F_6274:: ; address name
    dw MetaSprites7F_4008Set46Frame0 ; entry 0
    dw MetaSprites7F_4008Set46Frame1 ; entry 1
    dw MetaSprites7F_4008Set46Frame2 ; entry 2
    dw MetaSprites7F_4008Set46Frame3 ; entry 3
    dw MetaSprites7F_4008Set46Frame4 ; entry 4
    dw MetaSprites7F_4008Set46Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set46; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set46Frame0::
Data_07F_6280:: ; address name
    db $EF, $FA, $00, $00 ; entry 0
    db $EF, $02, $01, $00 ; entry 1
    db $F7, $FA, $02, $00 ; entry 2
    db $F7, $02, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set46; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set46Frame1::
Data_07F_6291:: ; address name
    db $EF, $FA, $00, $00 ; entry 0
    db $EF, $02, $01, $00 ; entry 1
    db $F7, $FA, $02, $00 ; entry 2
    db $F7, $02, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set46; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set46Frame2::
Data_07F_62A2:: ; address name
    db $EF, $FA, $00, $00 ; entry 0
    db $EF, $02, $01, $00 ; entry 1
    db $F7, $FA, $02, $00 ; entry 2
    db $F7, $02, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set46; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set46Frame3::
Data_07F_62B3:: ; address name
    db $EF, $FA, $00, $00 ; entry 0
    db $EF, $02, $01, $00 ; entry 1
    db $F7, $FA, $02, $00 ; entry 2
    db $F7, $02, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set46; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set46Frame4::
Data_07F_62C4:: ; address name
    db $EF, $FA, $00, $00 ; entry 0
    db $EF, $02, $01, $00 ; entry 1
    db $F7, $FA, $02, $00 ; entry 2
    db $F7, $02, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set46; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set46Frame5::
Data_07F_62D5:: ; address name
    db $EF, $FA, $00, $00 ; entry 0
    db $EF, $02, $01, $00 ; entry 1
    db $F7, $FA, $02, $00 ; entry 2
    db $F7, $02, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 71 of MetaSprites7F_4008Table: 3 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set47::
Data_07F_62E6:: ; address name
    dw MetaSprites7F_4008Set47Frame0 ; entry 0
    dw MetaSprites7F_4008Set47Frame1 ; entry 1
    dw MetaSprites7F_4008Set47Frame2 ; entry 2

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set47; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set47Frame0::
Data_07F_62EC:: ; address name
    db $E0, $F0, $00, $00 ; entry 0
    db $E0, $F8, $01, $00 ; entry 1
    db $E0, $00, $02, $00 ; entry 2
    db $E0, $08, $03, $00 ; entry 3
    db $E8, $F0, $04, $00 ; entry 4
    db $E8, $F8, $05, $00 ; entry 5
    db $E8, $00, $06, $00 ; entry 6
    db $E8, $08, $07, $00 ; entry 7
    db $F0, $EE, $08, $00 ; entry 8
    db $F0, $F6, $09, $00 ; entry 9
    db $F0, $FE, $0A, $00 ; entry 10
    db $F0, $06, $0B, $00 ; entry 11
    db $F8, $EE, $0C, $00 ; entry 12
    db $F8, $F6, $0D, $00 ; entry 13
    db $F8, $FE, $0E, $00 ; entry 14
    db $F8, $06, $0F, $00 ; entry 15
    db $F1, $0E, $10, $00 ; entry 16
    db $F2, $E6, $10, $20 ; entry 17
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set47; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set47Frame1::
Data_07F_6335:: ; address name
    db $E0, $F0, $11, $00 ; entry 0
    db $E0, $F8, $12, $00 ; entry 1
    db $E0, $07, $11, $20 ; entry 2
    db $E0, $FF, $12, $20 ; entry 3
    db $E8, $F0, $13, $00 ; entry 4
    db $E8, $F8, $14, $00 ; entry 5
    db $E8, $07, $13, $20 ; entry 6
    db $E8, $FF, $14, $20 ; entry 7
    db $F0, $E8, $15, $00 ; entry 8
    db $F0, $F0, $16, $00 ; entry 9
    db $F0, $F8, $17, $00 ; entry 10
    db $F0, $0F, $15, $20 ; entry 11
    db $F0, $07, $16, $20 ; entry 12
    db $F0, $FF, $17, $20 ; entry 13
    db $F8, $E8, $18, $00 ; entry 14
    db $F8, $F0, $19, $00 ; entry 15
    db $F8, $F8, $1A, $00 ; entry 16
    db $F8, $0F, $18, $20 ; entry 17
    db $F8, $07, $19, $20 ; entry 18
    db $F8, $FF, $1A, $20 ; entry 19
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set47; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set47Frame2::
Data_07F_6386:: ; address name
    db $E0, $08, $00, $20 ; entry 0
    db $E0, $00, $01, $20 ; entry 1
    db $E0, $F8, $02, $20 ; entry 2
    db $E0, $F0, $03, $20 ; entry 3
    db $E8, $08, $04, $20 ; entry 4
    db $E8, $00, $05, $20 ; entry 5
    db $E8, $F8, $06, $20 ; entry 6
    db $E8, $F0, $07, $20 ; entry 7
    db $F0, $0A, $08, $20 ; entry 8
    db $F0, $02, $09, $20 ; entry 9
    db $F0, $FA, $0A, $20 ; entry 10
    db $F0, $F2, $0B, $20 ; entry 11
    db $F8, $0A, $0C, $20 ; entry 12
    db $F8, $02, $0D, $20 ; entry 13
    db $F8, $FA, $0E, $20 ; entry 14
    db $F8, $F2, $0F, $20 ; entry 15
    db $F1, $EA, $10, $20 ; entry 16
    db $F2, $12, $10, $00 ; entry 17
    db $80 ; end

; E-0147 (derived: meta-sprite set 72 of MetaSprites7F_4008Table: 3 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set48::
Data_07F_63CF:: ; address name
    dw MetaSprites7F_4008Set48Frame0 ; entry 0
    dw MetaSprites7F_4008Set48Frame1 ; entry 1
    dw MetaSprites7F_4008Set48Frame2 ; entry 2

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set48; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set48Frame0::
Data_07F_63D5:: ; address name
    db $F0, $F0, $08, $00 ; entry 0
    db $F0, $F8, $09, $00 ; entry 1
    db $F0, $00, $0A, $00 ; entry 2
    db $F0, $08, $0B, $00 ; entry 3
    db $F8, $F0, $0C, $00 ; entry 4
    db $F8, $F8, $0D, $00 ; entry 5
    db $F8, $00, $0E, $00 ; entry 6
    db $F8, $08, $0F, $00 ; entry 7
    db $E0, $F0, $00, $00 ; entry 8
    db $E0, $F8, $01, $00 ; entry 9
    db $E0, $00, $02, $00 ; entry 10
    db $E0, $08, $03, $00 ; entry 11
    db $E8, $F0, $04, $00 ; entry 12
    db $E8, $F8, $05, $00 ; entry 13
    db $E8, $00, $06, $00 ; entry 14
    db $E8, $08, $07, $00 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set48; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set48Frame1::
Data_07F_6416:: ; address name
    db $F0, $F8, $09, $00 ; entry 0
    db $F0, $00, $0A, $00 ; entry 1
    db $F8, $F0, $0C, $00 ; entry 2
    db $F8, $F8, $0D, $00 ; entry 3
    db $F8, $00, $0E, $00 ; entry 4
    db $F8, $08, $0F, $00 ; entry 5
    db $E0, $F8, $01, $00 ; entry 6
    db $E0, $00, $02, $00 ; entry 7
    db $E8, $00, $06, $00 ; entry 8
    db $E8, $F0, $10, $00 ; entry 9
    db $E8, $F8, $11, $00 ; entry 10
    db $F0, $F0, $12, $00 ; entry 11
    db $E0, $08, $13, $00 ; entry 12
    db $E8, $08, $14, $00 ; entry 13
    db $F0, $08, $15, $00 ; entry 14
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set48; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set48Frame2::
Data_07F_6453:: ; address name
    db $F0, $00, $0A, $00 ; entry 0
    db $F8, $F0, $0C, $00 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0E, $00 ; entry 3
    db $F8, $08, $0F, $00 ; entry 4
    db $E0, $F8, $01, $00 ; entry 5
    db $E0, $00, $02, $00 ; entry 6
    db $E8, $00, $06, $00 ; entry 7
    db $E8, $F0, $16, $00 ; entry 8
    db $E8, $F8, $17, $00 ; entry 9
    db $F0, $F0, $18, $00 ; entry 10
    db $F0, $F8, $19, $00 ; entry 11
    db $E0, $08, $1A, $00 ; entry 12
    db $E8, $08, $1B, $00 ; entry 13
    db $F0, $08, $1C, $00 ; entry 14
    db $80 ; end

; E-0147 (derived: meta-sprite set 73 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set49::
Data_07F_6490:: ; address name
    dw MetaSprites7F_4008Set49Frame0 ; entry 0
    dw MetaSprites7F_4008Set49Frame1 ; entry 1
    dw MetaSprites7F_4008Set49Frame2 ; entry 2
    dw MetaSprites7F_4008Set49Frame3 ; entry 3
    dw MetaSprites7F_4008Set49Frame4 ; entry 4
    dw MetaSprites7F_4008Set49Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set49; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set49Frame0::
Data_07F_649C:: ; address name
    db $EE, $F8, $00, $00 ; entry 0
    db $EE, $00, $01, $00 ; entry 1
    db $F6, $F8, $02, $00 ; entry 2
    db $F6, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set49; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set49Frame1::
Data_07F_64AD:: ; address name
    db $EE, $00, $00, $20 ; entry 0
    db $EE, $F8, $01, $20 ; entry 1
    db $F6, $00, $02, $20 ; entry 2
    db $F6, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set49; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set49Frame2::
Data_07F_64BE:: ; address name
    db $EE, $F8, $04, $00 ; entry 0
    db $EE, $00, $05, $00 ; entry 1
    db $F6, $F8, $06, $00 ; entry 2
    db $F6, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set49; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set49Frame3::
Data_07F_64CF:: ; address name
    db $EE, $F8, $08, $00 ; entry 0
    db $EE, $00, $09, $00 ; entry 1
    db $F6, $F8, $0A, $00 ; entry 2
    db $F6, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set49; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set49Frame4::
Data_07F_64E0:: ; address name
    db $EE, $F8, $0C, $00 ; entry 0
    db $EE, $00, $0D, $00 ; entry 1
    db $F6, $F8, $0E, $00 ; entry 2
    db $F6, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set49; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set49Frame5::
Data_07F_64F1:: ; address name
    db $EE, $00, $0C, $20 ; entry 0
    db $EE, $F8, $0D, $20 ; entry 1
    db $F6, $00, $0E, $20 ; entry 2
    db $F6, $F8, $0F, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 74 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set4A::
Data_07F_6502:: ; address name
    dw MetaSprites7F_4008Set4AFrame0 ; entry 0
    dw MetaSprites7F_4008Set4AFrame1 ; entry 1
    dw MetaSprites7F_4008Set4AFrame2 ; entry 2
    dw MetaSprites7F_4008Set4AFrame3 ; entry 3
    dw MetaSprites7F_4008Set4AFrame4 ; entry 4
    dw MetaSprites7F_4008Set4AFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set4A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4AFrame0::
Data_07F_650E:: ; address name
    db $EF, $F8, $00, $00 ; entry 0
    db $EF, $00, $01, $00 ; entry 1
    db $F7, $F8, $02, $00 ; entry 2
    db $F7, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set4A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4AFrame1::
Data_07F_651F:: ; address name
    db $EF, $F8, $00, $00 ; entry 0
    db $EF, $00, $01, $00 ; entry 1
    db $F7, $F8, $02, $00 ; entry 2
    db $F7, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set4A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4AFrame2::
Data_07F_6530:: ; address name
    db $EF, $F8, $00, $00 ; entry 0
    db $EF, $00, $01, $00 ; entry 1
    db $F7, $F8, $02, $00 ; entry 2
    db $F7, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set4A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4AFrame3::
Data_07F_6541:: ; address name
    db $EF, $F8, $00, $00 ; entry 0
    db $EF, $00, $01, $00 ; entry 1
    db $F7, $F8, $02, $00 ; entry 2
    db $F7, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set4A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4AFrame4::
Data_07F_6552:: ; address name
    db $EF, $F8, $00, $00 ; entry 0
    db $EF, $00, $01, $00 ; entry 1
    db $F7, $F8, $02, $00 ; entry 2
    db $F7, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set4A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4AFrame5::
Data_07F_6563:: ; address name
    db $EF, $F8, $00, $00 ; entry 0
    db $EF, $00, $01, $00 ; entry 1
    db $F7, $F8, $02, $00 ; entry 2
    db $F7, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 75 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set4B::
Data_07F_6574:: ; address name
    dw MetaSprites7F_4008Set4BFrame0 ; entry 0
    dw MetaSprites7F_4008Set4BFrame1 ; entry 1
    dw MetaSprites7F_4008Set4BFrame2 ; entry 2
    dw MetaSprites7F_4008Set4BFrame3 ; entry 3
    dw MetaSprites7F_4008Set4BFrame4 ; entry 4
    dw MetaSprites7F_4008Set4BFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set4B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4BFrame0::
Data_07F_6580:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $01, $00 ; entry 1
    db $F8, $00, $02, $00 ; entry 2
    db $F0, $FF, $00, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set4B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4BFrame1::
Data_07F_6591:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $FF, $01, $20 ; entry 2
    db $F8, $F7, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set4B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4BFrame2::
Data_07F_65A2:: ; address name
    db $F0, $F9, $03, $00 ; entry 0
    db $F0, $01, $04, $00 ; entry 1
    db $F8, $F9, $05, $00 ; entry 2
    db $F8, $01, $06, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set4B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4BFrame3::
Data_07F_65B3:: ; address name
    db $F0, $F9, $03, $00 ; entry 0
    db $F0, $01, $04, $00 ; entry 1
    db $F8, $F9, $07, $00 ; entry 2
    db $F8, $01, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set4B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4BFrame4::
Data_07F_65C4:: ; address name
    db $F0, $F8, $09, $00 ; entry 0
    db $F0, $FF, $09, $20 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set4B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4BFrame5::
Data_07F_65D5:: ; address name
    db $F0, $F8, $09, $00 ; entry 0
    db $F0, $FF, $09, $20 ; entry 1
    db $F8, $FF, $0A, $20 ; entry 2
    db $F8, $F7, $0B, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 76 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set4C::
Data_07F_65E6:: ; address name
    dw MetaSprites7F_4008Set4CFrame0 ; entry 0
    dw MetaSprites7F_4008Set4CFrame1 ; entry 1
    dw MetaSprites7F_4008Set4CFrame2 ; entry 2
    dw MetaSprites7F_4008Set4CFrame3 ; entry 3
    dw MetaSprites7F_4008Set4CFrame4 ; entry 4
    dw MetaSprites7F_4008Set4CFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set4C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4CFrame0::
Data_07F_65F2:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set4C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4CFrame1::
Data_07F_6603:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set4C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4CFrame2::
Data_07F_6614:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set4C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4CFrame3::
Data_07F_6625:: ; address name
    db $F0, $00, $05, $00 ; entry 0
    db $F0, $F8, $08, $00 ; entry 1
    db $F8, $F8, $09, $00 ; entry 2
    db $F8, $00, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set4C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4CFrame4::
Data_07F_6636:: ; address name
    db $F0, $F8, $0B, $00 ; entry 0
    db $F0, $00, $0C, $00 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0E, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set4C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4CFrame5::
Data_07F_6647:: ; address name
    db $F0, $00, $0C, $00 ; entry 0
    db $F0, $F8, $0F, $00 ; entry 1
    db $F8, $FF, $0D, $20 ; entry 2
    db $F8, $F7, $0E, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 77 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set4D::
Data_07F_6658:: ; address name
    dw MetaSprites7F_4008Set4DFrame0 ; entry 0
    dw MetaSprites7F_4008Set4DFrame1 ; entry 1
    dw MetaSprites7F_4008Set4DFrame2 ; entry 2
    dw MetaSprites7F_4008Set4DFrame3 ; entry 3
    dw MetaSprites7F_4008Set4DFrame4 ; entry 4
    dw MetaSprites7F_4008Set4DFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set4D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4DFrame0::
Data_07F_6664:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $01, $00 ; entry 1
    db $F8, $00, $02, $00 ; entry 2
    db $F0, $FF, $00, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set4D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4DFrame1::
Data_07F_6675:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $FF, $00, $20 ; entry 1
    db $F8, $FF, $01, $20 ; entry 2
    db $F8, $F7, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set4D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4DFrame2::
Data_07F_6686:: ; address name
    db $F0, $F9, $03, $00 ; entry 0
    db $F0, $01, $04, $00 ; entry 1
    db $F8, $F9, $05, $00 ; entry 2
    db $F8, $01, $06, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set4D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4DFrame3::
Data_07F_6697:: ; address name
    db $F0, $F9, $03, $00 ; entry 0
    db $F0, $01, $04, $00 ; entry 1
    db $F8, $F9, $07, $00 ; entry 2
    db $F8, $01, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set4D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4DFrame4::
Data_07F_66A8:: ; address name
    db $F0, $F8, $09, $00 ; entry 0
    db $F0, $FF, $09, $20 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set4D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4DFrame5::
Data_07F_66B9:: ; address name
    db $F0, $F8, $09, $00 ; entry 0
    db $F0, $FF, $09, $20 ; entry 1
    db $F8, $FF, $0A, $20 ; entry 2
    db $F8, $F7, $0B, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 78 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set4E::
Data_07F_66CA:: ; address name
    dw MetaSprites7F_4008Set4EFrame0 ; entry 0
    dw MetaSprites7F_4008Set4EFrame1 ; entry 1
    dw MetaSprites7F_4008Set4EFrame2 ; entry 2
    dw MetaSprites7F_4008Set4EFrame3 ; entry 3
    dw MetaSprites7F_4008Set4EFrame4 ; entry 4
    dw MetaSprites7F_4008Set4EFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set4E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4EFrame0::
Data_07F_66D6:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set4E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4EFrame1::
Data_07F_66E7:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $F8, $02, $00 ; entry 2
    db $F9, $00, $04, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set4E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4EFrame2::
Data_07F_66F8:: ; address name
    db $F0, $F8, $05, $00 ; entry 0
    db $F0, $00, $06, $00 ; entry 1
    db $F8, $F8, $07, $00 ; entry 2
    db $F8, $00, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set4E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4EFrame3::
Data_07F_6709:: ; address name
    db $F1, $F8, $05, $00 ; entry 0
    db $F1, $00, $06, $00 ; entry 1
    db $F9, $00, $08, $00 ; entry 2
    db $F9, $F8, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set4E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4EFrame4::
Data_07F_671A:: ; address name
    db $F1, $F8, $0A, $00 ; entry 0
    db $F1, $FD, $0A, $20 ; entry 1
    db $F9, $F8, $0D, $00 ; entry 2
    db $F9, $00, $0E, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set4E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4EFrame5::
Data_07F_672B:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $FD, $0A, $20 ; entry 1
    db $F8, $F8, $0B, $00 ; entry 2
    db $F8, $00, $0C, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 79 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set4F::
Data_07F_673C:: ; address name
    dw MetaSprites7F_4008Set4FFrame0 ; entry 0
    dw MetaSprites7F_4008Set4FFrame1 ; entry 1
    dw MetaSprites7F_4008Set4FFrame2 ; entry 2
    dw MetaSprites7F_4008Set4FFrame3 ; entry 3
    dw MetaSprites7F_4008Set4FFrame4 ; entry 4
    dw MetaSprites7F_4008Set4FFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set4F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4FFrame0::
Data_07F_6748:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set4F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4FFrame1::
Data_07F_6759:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $F8, $02, $00 ; entry 2
    db $F9, $00, $04, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set4F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4FFrame2::
Data_07F_676A:: ; address name
    db $F0, $F8, $05, $00 ; entry 0
    db $F0, $00, $06, $00 ; entry 1
    db $F8, $F8, $07, $00 ; entry 2
    db $F8, $00, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set4F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4FFrame3::
Data_07F_677B:: ; address name
    db $F1, $F8, $05, $00 ; entry 0
    db $F1, $00, $06, $00 ; entry 1
    db $F9, $00, $08, $00 ; entry 2
    db $F9, $F8, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set4F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4FFrame4::
Data_07F_678C:: ; address name
    db $F1, $F8, $0A, $00 ; entry 0
    db $F1, $FD, $0A, $20 ; entry 1
    db $F9, $F8, $0B, $00 ; entry 2
    db $F9, $00, $0C, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set4F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set4FFrame5::
Data_07F_679D:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $FD, $0A, $20 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0E, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 80 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set50::
Data_07F_67AE:: ; address name
    dw MetaSprites7F_4008Set50Frame0 ; entry 0
    dw MetaSprites7F_4008Set50Frame1 ; entry 1
    dw MetaSprites7F_4008Set50Frame2 ; entry 2
    dw MetaSprites7F_4008Set50Frame3 ; entry 3
    dw MetaSprites7F_4008Set50Frame4 ; entry 4
    dw MetaSprites7F_4008Set50Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set50; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set50Frame0::
Data_07F_67BA:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set50; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set50Frame1::
Data_07F_67CB:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set50; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set50Frame2::
Data_07F_67DC:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set50; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set50Frame3::
Data_07F_67ED:: ; address name
    db $F8, $F8, $08, $00 ; entry 0
    db $F8, $00, $09, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set50; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set50Frame4::
Data_07F_67FE:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set50; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set50Frame5::
Data_07F_680F:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $00, $0C, $20 ; entry 2
    db $F8, $F8, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 81 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set51::
Data_07F_6820:: ; address name
    dw MetaSprites7F_4008Set51Frame0 ; entry 0
    dw MetaSprites7F_4008Set51Frame1 ; entry 1
    dw MetaSprites7F_4008Set51Frame2 ; entry 2
    dw MetaSprites7F_4008Set51Frame3 ; entry 3
    dw MetaSprites7F_4008Set51Frame4 ; entry 4
    dw MetaSprites7F_4008Set51Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set51; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set51Frame0::
Data_07F_682C:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set51; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set51Frame1::
Data_07F_683D:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set51; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set51Frame2::
Data_07F_684E:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set51; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set51Frame3::
Data_07F_685F:: ; address name
    db $F8, $F8, $08, $00 ; entry 0
    db $F8, $00, $09, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set51; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set51Frame4::
Data_07F_6870:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set51; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set51Frame5::
Data_07F_6881:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $FF, $0C, $20 ; entry 2
    db $F8, $F7, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 82 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set52::
Data_07F_6892:: ; address name
    dw MetaSprites7F_4008Set52Frame0 ; entry 0
    dw MetaSprites7F_4008Set52Frame1 ; entry 1
    dw MetaSprites7F_4008Set52Frame2 ; entry 2
    dw MetaSprites7F_4008Set52Frame3 ; entry 3
    dw MetaSprites7F_4008Set52Frame4 ; entry 4
    dw MetaSprites7F_4008Set52Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set52; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set52Frame0::
Data_07F_689E:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set52; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set52Frame1::
Data_07F_68AF:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set52; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set52Frame2::
Data_07F_68C0:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set52; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set52Frame3::
Data_07F_68D1:: ; address name
    db $F8, $F8, $08, $00 ; entry 0
    db $F8, $00, $09, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set52; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set52Frame4::
Data_07F_68E2:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set52; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set52Frame5::
Data_07F_68F3:: ; address name
    db $F0, $FF, $0A, $20 ; entry 0
    db $F0, $F7, $0B, $20 ; entry 1
    db $F8, $FF, $0C, $20 ; entry 2
    db $F8, $F7, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 83 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set53::
Data_07F_6904:: ; address name
    dw MetaSprites7F_4008Set53Frame0 ; entry 0
    dw MetaSprites7F_4008Set53Frame1 ; entry 1
    dw MetaSprites7F_4008Set53Frame2 ; entry 2
    dw MetaSprites7F_4008Set53Frame3 ; entry 3
    dw MetaSprites7F_4008Set53Frame4 ; entry 4
    dw MetaSprites7F_4008Set53Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set53; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set53Frame0::
Data_07F_6910:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set53; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set53Frame1::
Data_07F_6921:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set53; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set53Frame2::
Data_07F_6932:: ; address name
    db $F0, $F6, $04, $00 ; entry 0
    db $F0, $FE, $05, $00 ; entry 1
    db $F8, $F6, $06, $00 ; entry 2
    db $F8, $FE, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set53; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set53Frame3::
Data_07F_6943:: ; address name
    db $F8, $F6, $08, $00 ; entry 0
    db $F8, $FE, $09, $00 ; entry 1
    db $F0, $F6, $04, $00 ; entry 2
    db $F0, $FE, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set53; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set53Frame4::
Data_07F_6954:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $FF, $0C, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set53; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set53Frame5::
Data_07F_6965:: ; address name
    db $F0, $F7, $0B, $20 ; entry 0
    db $F8, $FF, $0D, $20 ; entry 1
    db $F0, $FF, $0A, $20 ; entry 2
    db $F8, $F8, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 84 of MetaSprites7F_4008Table: 8 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set54::
Data_07F_6976:: ; address name
    dw MetaSprites7F_4008Set54Frame0 ; entry 0
    dw MetaSprites7F_4008Set54Frame1 ; entry 1
    dw MetaSprites7F_4008Set54Frame2 ; entry 2
    dw MetaSprites7F_4008Set54Frame3 ; entry 3
    dw MetaSprites7F_4008Set54Frame4 ; entry 4
    dw MetaSprites7F_4008Set54Frame5 ; entry 5
    dw MetaSprites7F_4008Set54Frame6 ; entry 6
    dw MetaSprites7F_4008Set54Frame7 ; entry 7

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set54; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set54Frame0::
Data_07F_6986:: ; address name
    db $E0, $F0, $00, $00 ; entry 0
    db $E0, $08, $03, $00 ; entry 1
    db $E8, $07, $04, $20 ; entry 2
    db $E8, $FF, $05, $20 ; entry 3
    db $F0, $07, $06, $20 ; entry 4
    db $F0, $FF, $07, $20 ; entry 5
    db $F8, $07, $08, $20 ; entry 6
    db $F8, $FF, $09, $20 ; entry 7
    db $E0, $F8, $01, $00 ; entry 8
    db $E0, $00, $02, $00 ; entry 9
    db $E8, $F0, $04, $00 ; entry 10
    db $E8, $F8, $05, $00 ; entry 11
    db $F0, $F0, $06, $00 ; entry 12
    db $F0, $F8, $07, $00 ; entry 13
    db $F8, $F0, $08, $00 ; entry 14
    db $F8, $F8, $09, $00 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set54; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set54Frame1::
Data_07F_69C7:: ; address name
    db $E0, $F0, $00, $00 ; entry 0
    db $E0, $08, $03, $00 ; entry 1
    db $E8, $07, $04, $20 ; entry 2
    db $F0, $07, $06, $20 ; entry 3
    db $F0, $FF, $07, $20 ; entry 4
    db $F8, $07, $08, $20 ; entry 5
    db $F8, $FF, $09, $20 ; entry 6
    db $E0, $F8, $01, $00 ; entry 7
    db $E0, $00, $02, $00 ; entry 8
    db $E8, $F0, $04, $00 ; entry 9
    db $F0, $F0, $06, $00 ; entry 10
    db $F0, $F8, $07, $00 ; entry 11
    db $F8, $F0, $08, $00 ; entry 12
    db $F8, $F8, $09, $00 ; entry 13
    db $E8, $F8, $0A, $00 ; entry 14
    db $E8, $FF, $19, $20 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set54; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set54Frame2::
Data_07F_6A08:: ; address name
    db $E0, $F0, $00, $00 ; entry 0
    db $E0, $08, $03, $00 ; entry 1
    db $E8, $07, $04, $20 ; entry 2
    db $F0, $07, $06, $20 ; entry 3
    db $F0, $FF, $07, $20 ; entry 4
    db $F8, $07, $08, $20 ; entry 5
    db $F8, $FF, $09, $20 ; entry 6
    db $E0, $F8, $01, $00 ; entry 7
    db $E0, $00, $02, $00 ; entry 8
    db $E8, $F0, $04, $00 ; entry 9
    db $F0, $F0, $06, $00 ; entry 10
    db $F0, $F8, $07, $00 ; entry 11
    db $F8, $F0, $08, $00 ; entry 12
    db $F8, $F8, $09, $00 ; entry 13
    db $E8, $FF, $0A, $20 ; entry 14
    db $E8, $F8, $19, $00 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set54; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set54Frame3::
Data_07F_6A49:: ; address name
    db $E0, $F0, $00, $00 ; entry 0
    db $E8, $FF, $05, $20 ; entry 1
    db $F0, $07, $06, $20 ; entry 2
    db $F0, $FF, $07, $20 ; entry 3
    db $F8, $07, $08, $20 ; entry 4
    db $F8, $FF, $09, $20 ; entry 5
    db $E0, $F8, $01, $00 ; entry 6
    db $E8, $F0, $04, $00 ; entry 7
    db $E8, $F8, $05, $00 ; entry 8
    db $F0, $F0, $06, $00 ; entry 9
    db $F0, $F8, $07, $00 ; entry 10
    db $F8, $F0, $08, $00 ; entry 11
    db $F8, $F8, $09, $00 ; entry 12
    db $E0, $FF, $01, $20 ; entry 13
    db $E0, $07, $0B, $00 ; entry 14
    db $E8, $07, $0C, $00 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set54; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set54Frame4::
Data_07F_6A8A:: ; address name
    db $E0, $F0, $00, $00 ; entry 0
    db $E8, $FF, $05, $20 ; entry 1
    db $F0, $07, $06, $20 ; entry 2
    db $F0, $FF, $07, $20 ; entry 3
    db $F8, $07, $08, $20 ; entry 4
    db $F8, $FF, $09, $20 ; entry 5
    db $E0, $F8, $01, $00 ; entry 6
    db $E8, $F0, $04, $00 ; entry 7
    db $E8, $F8, $05, $00 ; entry 8
    db $F0, $F0, $06, $00 ; entry 9
    db $F0, $F8, $07, $00 ; entry 10
    db $F8, $F0, $08, $00 ; entry 11
    db $F8, $F8, $09, $00 ; entry 12
    db $E0, $07, $00, $20 ; entry 13
    db $E0, $FF, $01, $20 ; entry 14
    db $E8, $07, $0D, $00 ; entry 15
    db $E8, $0F, $0E, $00 ; entry 16
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set54; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set54Frame5::
Data_07F_6ACF:: ; address name
    db $E0, $F0, $00, $00 ; entry 0
    db $E8, $FF, $05, $20 ; entry 1
    db $F0, $07, $06, $20 ; entry 2
    db $F0, $FF, $07, $20 ; entry 3
    db $F8, $07, $08, $20 ; entry 4
    db $F8, $FF, $09, $20 ; entry 5
    db $E0, $F8, $01, $00 ; entry 6
    db $E8, $F0, $04, $00 ; entry 7
    db $E8, $F8, $05, $00 ; entry 8
    db $F0, $F0, $06, $00 ; entry 9
    db $F0, $F8, $07, $00 ; entry 10
    db $F8, $F0, $08, $00 ; entry 11
    db $F8, $F8, $09, $00 ; entry 12
    db $E0, $FF, $01, $20 ; entry 13
    db $E0, $07, $0F, $00 ; entry 14
    db $E0, $0F, $10, $00 ; entry 15
    db $E8, $07, $11, $00 ; entry 16
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites7F_4008Set54; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set54Frame6::
Data_07F_6B14:: ; address name
    db $E0, $F0, $00, $00 ; entry 0
    db $E0, $08, $03, $00 ; entry 1
    db $E8, $07, $04, $20 ; entry 2
    db $F0, $07, $06, $20 ; entry 3
    db $F8, $07, $08, $20 ; entry 4
    db $F8, $FF, $09, $20 ; entry 5
    db $E8, $F0, $04, $00 ; entry 6
    db $F0, $F0, $06, $00 ; entry 7
    db $F8, $F0, $08, $00 ; entry 8
    db $F8, $F8, $09, $00 ; entry 9
    db $E8, $FF, $14, $20 ; entry 10
    db $E0, $F8, $12, $00 ; entry 11
    db $E0, $00, $13, $00 ; entry 12
    db $E8, $F8, $14, $00 ; entry 13
    db $F0, $F8, $07, $00 ; entry 14
    db $F0, $FF, $07, $20 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites7F_4008Set54; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set54Frame7::
Data_07F_6B55:: ; address name
    db $E0, $F0, $00, $00 ; entry 0
    db $E0, $08, $03, $00 ; entry 1
    db $E8, $07, $04, $20 ; entry 2
    db $F0, $07, $06, $20 ; entry 3
    db $F8, $07, $08, $20 ; entry 4
    db $F8, $FF, $09, $20 ; entry 5
    db $E8, $F0, $04, $00 ; entry 6
    db $F0, $F0, $06, $00 ; entry 7
    db $F8, $F0, $08, $00 ; entry 8
    db $F8, $F8, $09, $00 ; entry 9
    db $E0, $F8, $15, $00 ; entry 10
    db $E0, $00, $16, $00 ; entry 11
    db $E8, $F8, $17, $00 ; entry 12
    db $E8, $FF, $17, $20 ; entry 13
    db $F0, $F8, $18, $00 ; entry 14
    db $F0, $FF, $18, $20 ; entry 15
    db $80 ; end

; E-0147 (derived: meta-sprite set 85 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set55::
Data_07F_6B96:: ; address name
    dw MetaSprites7F_4008Set55Frame0 ; entry 0
    dw MetaSprites7F_4008Set55Frame1 ; entry 1
    dw MetaSprites7F_4008Set55Frame2 ; entry 2
    dw MetaSprites7F_4008Set55Frame3 ; entry 3
    dw MetaSprites7F_4008Set55Frame4 ; entry 4
    dw MetaSprites7F_4008Set55Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set55; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set55Frame0::
Data_07F_6BA2:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $F8, $02, $00 ; entry 2
    db $F9, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set55; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set55Frame1::
Data_07F_6BB3:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $04, $00 ; entry 2
    db $F8, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set55; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set55Frame2::
Data_07F_6BC4:: ; address name
    db $F1, $F8, $06, $00 ; entry 0
    db $F1, $00, $07, $00 ; entry 1
    db $F9, $F8, $08, $00 ; entry 2
    db $F9, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set55; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set55Frame3::
Data_07F_6BD5:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set55; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set55Frame4::
Data_07F_6BE6:: ; address name
    db $F1, $FF, $00, $20 ; entry 0
    db $F1, $F7, $01, $20 ; entry 1
    db $F9, $F8, $0C, $00 ; entry 2
    db $F9, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set55; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set55Frame5::
Data_07F_6BF7:: ; address name
    db $F0, $FF, $00, $20 ; entry 0
    db $F0, $F7, $01, $20 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 86 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set56::
Data_07F_6C08:: ; address name
    dw MetaSprites7F_4008Set56Frame0 ; entry 0
    dw MetaSprites7F_4008Set56Frame1 ; entry 1
    dw MetaSprites7F_4008Set56Frame2 ; entry 2
    dw MetaSprites7F_4008Set56Frame3 ; entry 3
    dw MetaSprites7F_4008Set56Frame4 ; entry 4
    dw MetaSprites7F_4008Set56Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set56; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set56Frame0::
Data_07F_6C14:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set56; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set56Frame1::
Data_07F_6C25:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set56; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set56Frame2::
Data_07F_6C36:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set56; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set56Frame3::
Data_07F_6C47:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set56; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set56Frame4::
Data_07F_6C58:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set56; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set56Frame5::
Data_07F_6C69:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 87 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set57::
Data_07F_6C7A:: ; address name
    dw MetaSprites7F_4008Set57Frame0 ; entry 0
    dw MetaSprites7F_4008Set57Frame1 ; entry 1
    dw MetaSprites7F_4008Set57Frame2 ; entry 2
    dw MetaSprites7F_4008Set57Frame3 ; entry 3
    dw MetaSprites7F_4008Set57Frame4 ; entry 4
    dw MetaSprites7F_4008Set57Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set57; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set57Frame0::
Data_07F_6C86:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $F8, $02, $00 ; entry 2
    db $F9, $FF, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set57; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set57Frame1::
Data_07F_6C97:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $03, $00 ; entry 2
    db $F8, $FF, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set57; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set57Frame2::
Data_07F_6CA8:: ; address name
    db $F9, $F8, $06, $00 ; entry 0
    db $F9, $00, $07, $00 ; entry 1
    db $F1, $F8, $04, $00 ; entry 2
    db $F1, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set57; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set57Frame3::
Data_07F_6CB9:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set57; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set57Frame4::
Data_07F_6CCA:: ; address name
    db $F1, $F8, $0A, $00 ; entry 0
    db $F1, $00, $0B, $00 ; entry 1
    db $F9, $F8, $0C, $00 ; entry 2
    db $F9, $FF, $0C, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set57; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set57Frame5::
Data_07F_6CDB:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $FF, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 88 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set58::
Data_07F_6CEC:: ; address name
    dw MetaSprites7F_4008Set58Frame0 ; entry 0
    dw MetaSprites7F_4008Set58Frame1 ; entry 1
    dw MetaSprites7F_4008Set58Frame2 ; entry 2
    dw MetaSprites7F_4008Set58Frame3 ; entry 3
    dw MetaSprites7F_4008Set58Frame4 ; entry 4
    dw MetaSprites7F_4008Set58Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set58; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set58Frame0::
Data_07F_6CF8:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set58; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set58Frame1::
Data_07F_6D09:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set58; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set58Frame2::
Data_07F_6D1A:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set58; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set58Frame3::
Data_07F_6D2B:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set58; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set58Frame4::
Data_07F_6D3C:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set58; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set58Frame5::
Data_07F_6D4D:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 89 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set59::
Data_07F_6D5E:: ; address name
    dw MetaSprites7F_4008Set59Frame0 ; entry 0
    dw MetaSprites7F_4008Set59Frame1 ; entry 1
    dw MetaSprites7F_4008Set59Frame2 ; entry 2
    dw MetaSprites7F_4008Set59Frame3 ; entry 3
    dw MetaSprites7F_4008Set59Frame4 ; entry 4
    dw MetaSprites7F_4008Set59Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set59; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set59Frame0::
Data_07F_6D6A:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $01, $00 ; entry 1
    db $F0, $FF, $00, $20 ; entry 2
    db $F8, $FF, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set59; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set59Frame1::
Data_07F_6D7B:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $01, $00 ; entry 1
    db $F0, $FF, $00, $20 ; entry 2
    db $F8, $FF, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set59; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set59Frame2::
Data_07F_6D8C:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $01, $00 ; entry 1
    db $F0, $FF, $00, $20 ; entry 2
    db $F8, $FF, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set59; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set59Frame3::
Data_07F_6D9D:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $01, $00 ; entry 1
    db $F0, $FF, $00, $20 ; entry 2
    db $F8, $FF, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set59; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set59Frame4::
Data_07F_6DAE:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $01, $00 ; entry 1
    db $F0, $FF, $00, $20 ; entry 2
    db $F8, $FF, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set59; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set59Frame5::
Data_07F_6DBF:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $01, $00 ; entry 1
    db $F0, $FF, $00, $20 ; entry 2
    db $F8, $FF, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 90 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set5A::
Data_07F_6DD0:: ; address name
    dw MetaSprites7F_4008Set5AFrame0 ; entry 0
    dw MetaSprites7F_4008Set5AFrame1 ; entry 1
    dw MetaSprites7F_4008Set5AFrame2 ; entry 2
    dw MetaSprites7F_4008Set5AFrame3 ; entry 3
    dw MetaSprites7F_4008Set5AFrame4 ; entry 4
    dw MetaSprites7F_4008Set5AFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set5A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set5AFrame0::
Data_07F_6DDC:: ; address name
    db $F0, $F8, $02, $00 ; entry 0
    db $F0, $00, $02, $20 ; entry 1
    db $F8, $F8, $03, $00 ; entry 2
    db $F8, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set5A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set5AFrame1::
Data_07F_6DED:: ; address name
    db $F0, $F8, $02, $00 ; entry 0
    db $F0, $00, $02, $20 ; entry 1
    db $F8, $F8, $03, $00 ; entry 2
    db $F8, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set5A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set5AFrame2::
Data_07F_6DFE:: ; address name
    db $F0, $F8, $02, $00 ; entry 0
    db $F0, $00, $02, $20 ; entry 1
    db $F8, $F8, $03, $00 ; entry 2
    db $F8, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set5A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set5AFrame3::
Data_07F_6E0F:: ; address name
    db $F0, $F8, $02, $00 ; entry 0
    db $F0, $00, $02, $20 ; entry 1
    db $F8, $F8, $03, $00 ; entry 2
    db $F8, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set5A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set5AFrame4::
Data_07F_6E20:: ; address name
    db $F0, $F8, $02, $00 ; entry 0
    db $F0, $00, $02, $20 ; entry 1
    db $F8, $F8, $03, $00 ; entry 2
    db $F8, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set5A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set5AFrame5::
Data_07F_6E31:: ; address name
    db $F0, $F8, $02, $00 ; entry 0
    db $F0, $00, $02, $20 ; entry 1
    db $F8, $F8, $03, $00 ; entry 2
    db $F8, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 91 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set5B::
Data_07F_6E42:: ; address name
    dw MetaSprites7F_4008Set5BFrame0 ; entry 0
    dw MetaSprites7F_4008Set5BFrame1 ; entry 1
    dw MetaSprites7F_4008Set5BFrame2 ; entry 2
    dw MetaSprites7F_4008Set5BFrame3 ; entry 3
    dw MetaSprites7F_4008Set5BFrame4 ; entry 4
    dw MetaSprites7F_4008Set5BFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set5B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set5BFrame0::
Data_07F_6E4E:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $F8, $02, $00 ; entry 2
    db $F9, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set5B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set5BFrame1::
Data_07F_6E5F:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $F8, $02, $00 ; entry 2
    db $F9, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set5B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set5BFrame2::
Data_07F_6E70:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $F8, $02, $00 ; entry 2
    db $F9, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set5B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set5BFrame3::
Data_07F_6E81:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $F8, $02, $00 ; entry 2
    db $F9, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set5B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set5BFrame4::
Data_07F_6E92:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $F8, $02, $00 ; entry 2
    db $F9, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set5B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set5BFrame5::
Data_07F_6EA3:: ; address name
    db $F1, $F8, $00, $00 ; entry 0
    db $F1, $00, $01, $00 ; entry 1
    db $F9, $F8, $02, $00 ; entry 2
    db $F9, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 92 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set5C::
Data_07F_6EB4:: ; address name
    dw MetaSprites7F_4008Set5CFrame0 ; entry 0
    dw MetaSprites7F_4008Set5CFrame1 ; entry 1
    dw MetaSprites7F_4008Set5CFrame2 ; entry 2
    dw MetaSprites7F_4008Set5CFrame3 ; entry 3
    dw MetaSprites7F_4008Set5CFrame4 ; entry 4
    dw MetaSprites7F_4008Set5CFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set5C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set5CFrame0::
Data_07F_6EC0:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set5C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set5CFrame1::
Data_07F_6ED1:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $FF, $02, $20 ; entry 2
    db $F8, $F7, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set5C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set5CFrame2::
Data_07F_6EE2:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set5C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set5CFrame3::
Data_07F_6EF3:: ; address name
    db $F8, $F8, $08, $00 ; entry 0
    db $F8, $00, $09, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set5C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set5CFrame4::
Data_07F_6F04:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $F8, $0C, $00 ; entry 2
    db $F8, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set5C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set5CFrame5::
Data_07F_6F15:: ; address name
    db $F0, $F8, $0A, $00 ; entry 0
    db $F0, $00, $0B, $00 ; entry 1
    db $F8, $FF, $0C, $20 ; entry 2
    db $F8, $F7, $0D, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 95 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set5F::
Data_07F_6F26:: ; address name
    dw MetaSprites7F_4008Set5FFrame0 ; entry 0
    dw MetaSprites7F_4008Set5FFrame1 ; entry 1
    dw MetaSprites7F_4008Set5FFrame2 ; entry 2
    dw MetaSprites7F_4008Set5FFrame3 ; entry 3
    dw MetaSprites7F_4008Set5FFrame4 ; entry 4
    dw MetaSprites7F_4008Set5FFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set5F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set5FFrame0::
Data_07F_6F32:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set5F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set5FFrame1::
Data_07F_6F43:: ; address name
    db $F9, $00, $01, $20 ; entry 0
    db $F9, $F8, $02, $20 ; entry 1
    db $F1, $F8, $03, $00 ; entry 2
    db $F1, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set5F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set5FFrame2::
Data_07F_6F54:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set5F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set5FFrame3::
Data_07F_6F65:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set5F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set5FFrame4::
Data_07F_6F76:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0C, $20 ; entry 1
    db $F8, $F8, $0D, $00 ; entry 2
    db $F8, $00, $0E, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set5F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set5FFrame5::
Data_07F_6F87:: ; address name
    db $F1, $F8, $0F, $00 ; entry 0
    db $F1, $00, $0F, $20 ; entry 1
    db $F9, $00, $0D, $20 ; entry 2
    db $F9, $F8, $0E, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 97 of MetaSprites7F_4008Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_4008Set61::
Data_07F_6F98:: ; address name
    dw MetaSprites7F_4008Set61Frame0 ; entry 0
    dw MetaSprites7F_4008Set61Frame1 ; entry 1
    dw MetaSprites7F_4008Set61Frame2 ; entry 2
    dw MetaSprites7F_4008Set61Frame3 ; entry 3
    dw MetaSprites7F_4008Set61Frame4 ; entry 4
    dw MetaSprites7F_4008Set61Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_4008Set61; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set61Frame0::
Data_07F_6FA4:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_4008Set61; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set61Frame1::
Data_07F_6FB5:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_4008Set61; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set61Frame2::
Data_07F_6FC6:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_4008Set61; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set61Frame3::
Data_07F_6FD7:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_4008Set61; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set61Frame4::
Data_07F_6FE8:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $02, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_4008Set61; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_4008Set61Frame5::
Data_07F_6FF9:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $02, $20 ; entry 3
    db $80 ; end

; DE = Data_07F_7011 (the table of meta-sprite sets), then DrawMetaSpriteAt
; 25 call sites from 20 routines (e.g. PauseMenu_State3_WriteRAMGAndRAMBEtc, DrawPlayerOverlaySprite21Or22, DrawPartyFollowerSprites, DrawMetaSprite0AtX50YWD09E, ...)
DrawMetaSprite::
Func_07F_700A:: ; address name
    ld de, MetaSprites7F_7011Table
    call DrawMetaSpriteAt
    ret

; E-0147 (C1: the caller of DrawMetaSprite passes DE = $7F:7011; the builder takes the word at DE + 2 * hSpriteSetIndex as the set and the word at set + 2 * hSpriteSubIndex as the frame; 42 words, up to the next code or data).
; record: meta-sprite set
MetaSprites7F_7011Table::
Data_07F_7011:: ; address name
    dw MetaSprites7F_7011Set00 ; id 0
    dw MetaSprites7F_7011Set01 ; id 1
    dw MetaSprites7F_7011Set02 ; id 2
    dw MetaSprites7F_7011Set03 ; id 3
    dw MetaSprites7F_7011Set04 ; id 4
    dw MetaSprites7F_7011Set05 ; id 5
    dw MetaSprites7F_7011Set06 ; id 6
    dw MetaSprites7F_7011Set07 ; id 7
    dw MetaSprites7F_7011Set08 ; id 8
    dw MetaSprites7F_7011Set09 ; id 9
    dw MetaSprites7F_7011Set0A ; id 10
    dw MetaSprites7F_7011Set0B ; id 11
    dw MetaSprites7F_7011Set0C ; id 12
    dw MetaSprites7F_7011Set0D ; id 13
    dw MetaSprites7F_7011Set0E ; id 14
    dw MetaSprites7F_7011Set0F ; id 15
    dw MetaSprites7F_7011Set10 ; id 16
    dw MetaSprites7F_7011Set11 ; id 17
    dw MetaSprites7F_7011Set12 ; id 18
    dw MetaSprites7F_7011Set13 ; id 19
    dw MetaSprites7F_7011Set14 ; id 20
    dw MetaSprites7F_7011Set15 ; id 21
    dw MetaSprites7F_7011Set16 ; id 22
    dw MetaSprites7F_7011Set17 ; id 23
    dw MetaSprites7F_7011Set18 ; id 24
    dw MetaSprites7F_7011Set19 ; id 25
    dw MetaSprites7F_7011Set1A ; id 26
    dw MetaSprites7F_7011Set1B ; id 27
    dw MetaSprites7F_7011Set1C ; id 28
    dw MetaSprites7F_7011Set1D ; id 29
    dw MetaSprites7F_7011Set1E ; id 30
    dw MetaSprites7F_7011Set1F ; id 31
    dw MetaSprites7F_7011Set20 ; id 32
    dw MetaSprites7F_7011Set21 ; id 33
    dw MetaSprites7F_7011Set22 ; id 34
    dw MetaSprites7F_7011Set23 ; id 35
    dw MetaSprites7F_7011Set24 ; id 36
    dw MetaSprites7F_7011Set25 ; id 37
    dw MetaSprites7F_7011Set26 ; id 38
    dw MetaSprites7F_7011Set27 ; id 39
    dw MetaSprites7F_7011Set28 ; id 40
    dw MetaSprites7F_7011Set29 ; id 41

; DE = table of set pointers: returns at once when hOamNextEntry is $27 or more; otherwise converts the 16-bit position (hSpriteOriginX with hFFAA, hSpriteOriginY with hFFAC) to screen coordinates by adding the scroll-offset words hSpriteScrollXLo/Hi and hSpriteScrollYLo/Hi, and writes OAM entries for the sprite chosen by hSpriteSetIndex and hSpriteSubIndex (tile += hSpriteTileOffset, attribute ^= hSpriteAttrXor)
; 1 call site from 1 routine (e.g. DrawMetaSprite)
; reads: hOamNextEntry, hSpriteScrollYLo, hSpriteScrollYHi, hSpriteOriginY, hSpriteOriginYHi, hSpriteScrollXLo, hSpriteScrollXHi, hSpriteOriginX, ...
; writes: hMetaSpriteYLo, hMetaSpriteYHi, hOamNextEntry
; points at: hMetaSpriteXLo
DrawMetaSpriteAt::
Func_07F_7065:: ; address name
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
    jp nz, Jump_07F_71AF
    ldh a, [hSpriteTileOffset]
    ld c, a
    ldh a, [hSpriteAttrXor]
    and a, $20
    jr nz, Jump_07F_7137

Jump_07F_70C1::
    ld a, [hl+]
    cp a, $80
    ret z
    ld b, a
    jr nc, Jump_07F_70D9
    ldh a, [hMetaSpriteYLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteYHi]
    adc a, $00
    jr nz, Jump_07F_70E8
    ld a, b
    cp a, $A8
    jr c, Jump_07F_70ED
    jr Jump_07F_70E8

Jump_07F_70D9::
    ldh a, [hMetaSpriteYLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteYHi]
    adc a, $FF
    jr nz, Jump_07F_70E8
    ld a, b
    cp a, $A8
    jr c, Jump_07F_70ED

Jump_07F_70E8::
    inc hl
    inc hl
    inc hl
    jr Jump_07F_70C1

Jump_07F_70ED::
    ld a, b
    ld [de], a
    inc e
    ld a, [hl+]
    ld b, a
    rlca
    jr c, Jump_07F_7106
    ldh a, [hMetaSpriteXLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteXHi]
    adc a, $00
    jr nz, Jump_07F_7115
    ld a, b
    cp a, $B8
    jr c, Jump_07F_711C
    jr Jump_07F_7115

Jump_07F_7106::
    ldh a, [hMetaSpriteXLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteXHi]
    adc a, $FF
    jr nz, Jump_07F_7115
    ld a, b
    cp a, $B8
    jr c, Jump_07F_711C

Jump_07F_7115::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_07F_70C1

Jump_07F_711C::
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
    jr nz, Jump_07F_70C1
    ret

Jump_07F_7137::
    ld a, [hl+]
    cp a, $80
    ret z
    ld b, a
    jr nc, Jump_07F_714F
    ldh a, [hMetaSpriteYLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteYHi]
    adc a, $00
    jr nz, Jump_07F_715E
    ld a, b
    cp a, $A8
    jr c, Jump_07F_7163
    jr Jump_07F_715E

Jump_07F_714F::
    ldh a, [hMetaSpriteYLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteYHi]
    adc a, $FF
    jr nz, Jump_07F_715E
    ld a, b
    cp a, $A8
    jr c, Jump_07F_7163

Jump_07F_715E::
    inc hl
    inc hl
    inc hl
    jr Jump_07F_7137

Jump_07F_7163::
    ld a, b
    ld [de], a
    inc e
    ld a, [hl+]
    ld b, a
    rlca
    jr c, Jump_07F_717E
    ldh a, [hMetaSpriteXFlipLo]
    sub a, b
    ld b, a
    ldh a, [hMetaSpriteXFlipHi]
    sbc a, $00
    jr z, Jump_07F_7194
    jr nz, Jump_07F_718D
    ld a, b
    cp a, $B8
    jr c, Jump_07F_7194
    jr Jump_07F_718D

Jump_07F_717E::
    ldh a, [hMetaSpriteXFlipLo]
    sub a, b
    ld b, a
    ldh a, [hMetaSpriteXFlipHi]
    sbc a, $FF
    jr nz, Jump_07F_718D
    ld a, b
    cp a, $B8
    jr c, Jump_07F_7194

Jump_07F_718D::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_07F_7137

Jump_07F_7194::
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
    jr nz, Jump_07F_7137
    ret

Jump_07F_71AF::
    ldh a, [hSpriteAttrXor]
    and a, $20
    jr nz, Jump_07F_7230

Jump_07F_71B5::
    ld a, [hl+]
    cp a, $80
    ret z
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_07F_71C0
    dec b

Jump_07F_71C0::
    ldh a, [hMetaSpriteYLo]
    add a, c
    ld c, a
    ldh a, [hMetaSpriteYHi]
    adc a, b
    jr nz, Jump_07F_71EB
    ld a, c
    cp a, $B8
    jr nc, Jump_07F_71EB
    ldh a, [hSpriteWindowClipMode]
    or a, a
    jr z, Jump_07F_71F0
    cp a, $01
    jr nz, Jump_07F_71DE
    ld a, c
    cp a, $34
    jr c, Jump_07F_71EB
    jr Jump_07F_71F0

Jump_07F_71DE::
    cp a, $02
    jr nz, Jump_07F_71E9
    ld a, c
    cp a, $71
    jr c, Jump_07F_71F0
    jr Jump_07F_71EB

Jump_07F_71E9::
    jr Jump_07F_71F0

Jump_07F_71EB::
    inc hl
    inc hl
    inc hl
    jr Jump_07F_71B5

Jump_07F_71F0::
    ld a, c
    ld [de], a
    inc e
    ld a, [hl+]
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_07F_71FB
    dec b

Jump_07F_71FB::
    ldh a, [hMetaSpriteXLo]
    add a, c
    ld c, a
    ldh a, [hMetaSpriteXHi]
    adc a, b
    jr nz, Jump_07F_7209
    ld a, c
    cp a, $B8
    jr c, Jump_07F_7210

Jump_07F_7209::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_07F_71B5

Jump_07F_7210::
    ld a, c
    ld [de], a
    call BGTileUnderPointIsSpriteHideTile_Bank7F
    jr nc, Jump_07F_7209
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
    jr nz, Jump_07F_71B5
    ret

Jump_07F_7230::
    ld a, [hl+]
    cp a, $80
    ret z
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_07F_723B
    dec b

Jump_07F_723B::
    ldh a, [hMetaSpriteYLo]
    add a, c
    ld c, a
    ldh a, [hMetaSpriteYHi]
    adc a, b
    jr nz, Jump_07F_7266
    ld a, c
    cp a, $B8
    jr nc, Jump_07F_7266
    ldh a, [hSpriteWindowClipMode]
    or a, a
    jr z, Jump_07F_726B
    cp a, $01
    jr nz, Jump_07F_7259
    ld a, c
    cp a, $34
    jr c, Jump_07F_7266
    jr Jump_07F_726B

Jump_07F_7259::
    cp a, $02
    jr nz, Jump_07F_7264
    ld a, c
    cp a, $71
    jr c, Jump_07F_726B
    jr Jump_07F_7266

Jump_07F_7264::
    jr Jump_07F_726B

Jump_07F_7266::
    inc hl
    inc hl
    inc hl
    jr Jump_07F_7230

Jump_07F_726B::
    ld a, c
    ld [de], a
    inc e
    ld a, [hl+]
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_07F_7276
    dec b

Jump_07F_7276::
    ldh a, [hMetaSpriteXFlipLo]
    sub a, c
    ld c, a
    ldh a, [hMetaSpriteXFlipHi]
    sbc a, b
    jr nz, Jump_07F_7284
    ld a, c
    cp a, $B8
    jr c, Jump_07F_728B

Jump_07F_7284::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_07F_7230

Jump_07F_728B::
    ld a, c
    ld [de], a
    call BGTileUnderPointIsSpriteHideTile_Bank7F
    jr nc, Jump_07F_7284
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
    jr nz, Jump_07F_7230
    ret

; DE = address of an X byte with its Y byte at DE - 1 (screen coordinates): HL = the $9800 BG map entry under (X + hScrollX - 4, Y + hScrollY - 12), rows wrapping inside the map; reads it after rSTAT bit 1 clears (interrupts off) and compares with hFFBA: Z set when equal, A = the tile; BC, HL kept (E-0065) (the same 54 bytes appear in 6 banks)
; 2 call sites from 1 routine (e.g. DrawMetaSpriteAt)
; reads: hScrollY, hScrollX, hSpriteHideTile, rSTAT
BGTileUnderPointIsSpriteHideTile_Bank7F::
Func_07F_72AB:: ; address name
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

Jump_07F_72D5::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_07F_72D5
    ld a, [hl]
    ei
    cp a, b
    pop bc
    pop hl
    ret

; E-0147 (derived: meta-sprite set 0 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set00::
Data_07F_72E1:: ; address name
    dw MetaSprites7F_7011Set00Frame0 ; entry 0

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set00Frame0::
Data_07F_72E3:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 1 of MetaSprites7F_7011Table: 2 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set01::
Data_07F_72F4:: ; address name
    dw MetaSprites7F_7011Set01Frame0 ; entry 0
    dw MetaSprites7F_7011Set01Frame1 ; entry 1

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set01Frame0::
Data_07F_72F8:: ; address name
    db $F0, $F8, $02, $00 ; entry 0
    db $F0, $00, $02, $20 ; entry 1
    db $F8, $F8, $03, $00 ; entry 2
    db $F8, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_7011Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set01Frame1::
Data_07F_7309:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F8, $01, $00 ; entry 2
    db $F8, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 2 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set02::
Data_07F_731A:: ; address name
    dw MetaSprites7F_7011Set02Frame0 ; entry 0

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set02Frame0::
Data_07F_731C:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 3 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set03::
Data_07F_732D:: ; address name
    dw MetaSprites7F_7011Set03Frame0 ; entry 0

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set03Frame0::
Data_07F_732F:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 4 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set04::
Data_07F_7340:: ; address name
    dw MetaSprites7F_7011Set04Frame0 ; entry 0

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set04Frame0::
Data_07F_7342:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 5 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set05::
Data_07F_7353:: ; address name
    dw MetaSprites7F_7011Set05Frame0 ; entry 0

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set05Frame0::
Data_07F_7355:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 6 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set06::
Data_07F_7366:: ; address name
    dw MetaSprites7F_7011Set06Frame0 ; entry 0

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set06; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set06Frame0::
Data_07F_7368:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 7 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set07::
Data_07F_7379:: ; address name
    dw MetaSprites7F_7011Set07Frame0 ; entry 0

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set07; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set07Frame0::
Data_07F_737B:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 8 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set08::
Data_07F_738C:: ; address name
    dw MetaSprites7F_7011Set08Frame0 ; entry 0

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set08; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set08Frame0::
Data_07F_738E:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 9 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set09::
Data_07F_739F:: ; address name
    dw MetaSprites7F_7011Set09Frame0 ; entry 0

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set09; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set09Frame0::
Data_07F_73A1:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 10 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set0A::
Data_07F_73B2:: ; address name
    dw MetaSprites7F_7011Set0AFrame0 ; entry 0

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set0A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set0AFrame0::
Data_07F_73B4:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 11 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set0B::
Data_07F_73C5:: ; address name
    dw MetaSprites7F_7011Set0BFrame0 ; entry 0

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set0BFrame0::
Data_07F_73C7:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 12 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set0C::
Data_07F_73D8:: ; address name
    dw MetaSprites7F_7011Set0CFrame0 ; entry 0

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set0C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set0CFrame0::
Data_07F_73DA:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 13 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set0D::
Data_07F_73EB:: ; address name
    dw MetaSprites7F_7011Set0DFrame0 ; entry 0

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set0D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set0DFrame0::
Data_07F_73ED:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 14 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set0E::
Data_07F_73FE:: ; address name
    dw MetaSprites7F_7011Set0EFrame0 ; entry 0

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set0E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set0EFrame0::
Data_07F_7400:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 15 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set0F::
Data_07F_7411:: ; address name
    dw MetaSprites7F_7011Set0FFrame0 ; entry 0

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set0F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set0FFrame0::
Data_07F_7413:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 16 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set10::
Data_07F_7424:: ; address name
    dw MetaSprites7F_7011Set10Frame0 ; entry 0

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set10Frame0::
Data_07F_7426:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 17 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set11::
Data_07F_7437:: ; address name
    dw MetaSprites7F_7011Set11Frame0 ; entry 0

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set11Frame0::
Data_07F_7439:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 18 of MetaSprites7F_7011Table: 4 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set12::
Data_07F_744A:: ; address name
    dw MetaSprites7F_7011Set12Frame0 ; entry 0
    dw MetaSprites7F_7011Set12Frame1 ; entry 1
    dw MetaSprites7F_7011Set12Frame2 ; entry 2
    dw MetaSprites7F_7011Set12Frame3 ; entry 3

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set12; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set12Frame0::
Data_07F_7452:: ; address name
    db $EC, $F8, $00, $00 ; entry 0
    db $F4, $F8, $01, $00 ; entry 1
    db $F4, $00, $01, $20 ; entry 2
    db $EC, $00, $00, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_7011Set12; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set12Frame1::
Data_07F_7463:: ; address name
    db $ED, $F8, $02, $00 ; entry 0
    db $F5, $F8, $03, $00 ; entry 1
    db $ED, $00, $02, $20 ; entry 2
    db $F5, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_7011Set12; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set12Frame2::
Data_07F_7474:: ; address name
    db $EC, $F8, $04, $00 ; entry 0
    db $F4, $F8, $05, $00 ; entry 1
    db $EC, $00, $04, $20 ; entry 2
    db $F4, $00, $05, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_7011Set12; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set12Frame3::
Data_07F_7485:: ; address name
    db $ED, $F8, $06, $00 ; entry 0
    db $F5, $F8, $07, $00 ; entry 1
    db $ED, $00, $06, $20 ; entry 2
    db $F5, $00, $07, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 19 of MetaSprites7F_7011Table: 4 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set13::
Data_07F_7496:: ; address name
    dw MetaSprites7F_7011Set13Frame0 ; entry 0
    dw MetaSprites7F_7011Set13Frame1 ; entry 1
    dw MetaSprites7F_7011Set13Frame2 ; entry 2
    dw MetaSprites7F_7011Set13Frame3 ; entry 3

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set13; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set13Frame0::
Data_07F_749E:: ; address name
    db $F8, $F8, $02, $00 ; entry 0
    db $F8, $00, $03, $00 ; entry 1
    db $F0, $F8, $00, $00 ; entry 2
    db $F0, $00, $01, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_7011Set13; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set13Frame1::
Data_07F_74AF:: ; address name
    db $F8, $F8, $06, $00 ; entry 0
    db $F8, $00, $07, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_7011Set13; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set13Frame2::
Data_07F_74C0:: ; address name
    db $F8, $F8, $0A, $00 ; entry 0
    db $F8, $00, $0B, $00 ; entry 1
    db $F0, $F8, $08, $00 ; entry 2
    db $F0, $00, $09, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_7011Set13; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set13Frame3::
Data_07F_74D1:: ; address name
    db $F8, $F8, $0E, $00 ; entry 0
    db $F8, $00, $0F, $00 ; entry 1
    db $F0, $F8, $0C, $00 ; entry 2
    db $F0, $00, $0D, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 20 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set14::
Data_07F_74E2:: ; address name
    dw MetaSprites7F_7011Set14Frame0 ; entry 0

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set14; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set14Frame0::
Data_07F_74E4:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 21 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set15::
Data_07F_74F5:: ; address name
    dw MetaSprites7F_7011Set15Frame0 ; entry 0

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set15; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set15Frame0::
Data_07F_74F7:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 22 of MetaSprites7F_7011Table: 2 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set16::
Data_07F_7508:: ; address name
    dw MetaSprites7F_7011Set16Frame0 ; entry 0
    dw MetaSprites7F_7011Set16Frame1 ; entry 1

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set16; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set16Frame0::
Data_07F_750C:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_7011Set16; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set16Frame1::
Data_07F_751D:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 23 of MetaSprites7F_7011Table: 3 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set17::
Data_07F_752E:: ; address name
    dw MetaSprites7F_7011Set17Frame0 ; entry 0
    dw MetaSprites7F_7011Set17Frame1 ; entry 1
    dw MetaSprites7F_7011Set17Frame2 ; entry 2

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set17; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set17Frame0::
Data_07F_7534:: ; address name
    db $EF, $F8, $00, $00 ; entry 0
    db $EF, $00, $01, $00 ; entry 1
    db $F7, $F8, $02, $00 ; entry 2
    db $F7, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_7011Set17; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set17Frame1::
Data_07F_7545:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_7011Set17; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set17Frame2::
Data_07F_7556:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 24 of MetaSprites7F_7011Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set18::
Data_07F_7567:: ; address name
    dw MetaSprites7F_7011Set18Frame0 ; entry 0
    dw MetaSprites7F_7011Set18Frame1 ; entry 1
    dw MetaSprites7F_7011Set18Frame2 ; entry 2
    dw MetaSprites7F_7011Set18Frame3 ; entry 3
    dw MetaSprites7F_7011Set18Frame4 ; entry 4
    dw MetaSprites7F_7011Set18Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set18; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set18Frame0::
Data_07F_7573:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_7011Set18; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set18Frame1::
Data_07F_7584:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $04, $00 ; entry 1
    db $F8, $F8, $04, $00 ; entry 2
    db $F8, $00, $04, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_7011Set18; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set18Frame2::
Data_07F_7595:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_7011Set18; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set18Frame3::
Data_07F_75A6:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_7011Set18; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set18Frame4::
Data_07F_75B7:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_7011Set18; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set18Frame5::
Data_07F_75C8:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 25 of MetaSprites7F_7011Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set19::
Data_07F_75D9:: ; address name
    dw MetaSprites7F_7011Set19Frame0 ; entry 0
    dw MetaSprites7F_7011Set19Frame1 ; entry 1
    dw MetaSprites7F_7011Set19Frame2 ; entry 2
    dw MetaSprites7F_7011Set19Frame3 ; entry 3
    dw MetaSprites7F_7011Set19Frame4 ; entry 4
    dw MetaSprites7F_7011Set19Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set19; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set19Frame0::
Data_07F_75E5:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_7011Set19; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set19Frame1::
Data_07F_75F6:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_7011Set19; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set19Frame2::
Data_07F_7607:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_7011Set19; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set19Frame3::
Data_07F_7618:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_7011Set19; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set19Frame4::
Data_07F_7629:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_7011Set19; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set19Frame5::
Data_07F_763A:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 26 of MetaSprites7F_7011Table: 2 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set1A::
Data_07F_764B:: ; address name
    dw MetaSprites7F_7011Set1AFrame0 ; entry 0
    dw MetaSprites7F_7011Set1AFrame1 ; entry 1

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set1AFrame0::
Data_07F_764F:: ; address name
    db $F8, $F8, $02, $00 ; entry 0
    db $F8, $00, $03, $00 ; entry 1
    db $F0, $F8, $00, $00 ; entry 2
    db $F0, $00, $01, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_7011Set1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set1AFrame1::
Data_07F_7660:: ; address name
    db $F8, $F8, $06, $00 ; entry 0
    db $F8, $00, $07, $00 ; entry 1
    db $F0, $F8, $04, $00 ; entry 2
    db $F0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 27 of MetaSprites7F_7011Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set1B::
Data_07F_7671:: ; address name
    dw MetaSprites7F_7011Set1BFrame0 ; entry 0
    dw MetaSprites7F_7011Set1BFrame1 ; entry 1
    dw MetaSprites7F_7011Set1BFrame2 ; entry 2
    dw MetaSprites7F_7011Set1BFrame3 ; entry 3
    dw MetaSprites7F_7011Set1BFrame4 ; entry 4
    dw MetaSprites7F_7011Set1BFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set1BFrame0::
Data_07F_767D:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_7011Set1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set1BFrame1::
Data_07F_768E:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_7011Set1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set1BFrame2::
Data_07F_769F:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_7011Set1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set1BFrame3::
Data_07F_76B0:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_7011Set1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set1BFrame4::
Data_07F_76C1:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_7011Set1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set1BFrame5::
Data_07F_76D2:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 28 of MetaSprites7F_7011Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set1C::
Data_07F_76E3:: ; address name
    dw MetaSprites7F_7011Set1CFrame0 ; entry 0
    dw MetaSprites7F_7011Set1CFrame1 ; entry 1
    dw MetaSprites7F_7011Set1CFrame2 ; entry 2
    dw MetaSprites7F_7011Set1CFrame3 ; entry 3
    dw MetaSprites7F_7011Set1CFrame4 ; entry 4
    dw MetaSprites7F_7011Set1CFrame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set1CFrame0::
Data_07F_76EF:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_7011Set1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set1CFrame1::
Data_07F_7700:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_7011Set1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set1CFrame2::
Data_07F_7711:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_7011Set1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set1CFrame3::
Data_07F_7722:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_7011Set1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set1CFrame4::
Data_07F_7733:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_7011Set1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set1CFrame5::
Data_07F_7744:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 29 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set1D::
Data_07F_7755:: ; address name
    dw MetaSprites7F_7011Set1DFrame0 ; entry 0

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set1D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set1DFrame0::
Data_07F_7757:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 30 of MetaSprites7F_7011Table: 4 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set1E::
Data_07F_7768:: ; address name
    dw MetaSprites7F_7011Set1EFrame0 ; entry 0
    dw MetaSprites7F_7011Set1EFrame1 ; entry 1
    dw MetaSprites7F_7011Set1EFrame2 ; entry 2
    dw MetaSprites7F_7011Set1EFrame3 ; entry 3

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set1EFrame0::
Data_07F_7770:: ; address name
    db $F4, $FC, $00, $00 ; entry 0
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_7011Set1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set1EFrame1::
Data_07F_7775:: ; address name
    db $F4, $FC, $01, $00 ; entry 0
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_7011Set1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set1EFrame2::
Data_07F_777A:: ; address name
    db $F0, $F8, $02, $00 ; entry 0
    db $F8, $F8, $03, $00 ; entry 1
    db $F0, $FF, $02, $20 ; entry 2
    db $F8, $FF, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_7011Set1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set1EFrame3::
Data_07F_778B:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $FF, $04, $20 ; entry 1
    db $F8, $F8, $05, $00 ; entry 2
    db $F8, $FF, $05, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 31 of MetaSprites7F_7011Table: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set1F::
Data_07F_779C:: ; address name
    dw MetaSprites7F_7011Set1FFrame0 ; entry 0
    dw MetaSprites7F_7011Set1FFrame1 ; entry 1
    dw MetaSprites7F_7011Set1FFrame2 ; entry 2
    dw MetaSprites7F_7011Set1FFrame3 ; entry 3
    dw MetaSprites7F_7011Set1FFrame4 ; entry 4
    dw MetaSprites7F_7011Set1FFrame5 ; entry 5
    dw MetaSprites7F_7011Set1FFrame6 ; entry 6
    dw MetaSprites7F_7011Set1FFrame7 ; entry 7
    dw MetaSprites7F_7011Set1FFrame7 ; entry 8
    dw MetaSprites7F_7011Set1FFrame7 ; entry 9
    dw MetaSprites7F_7011Set1FFrame7 ; entry 10
    dw MetaSprites7F_7011Set1FFrame7 ; entry 11
    dw MetaSprites7F_7011Set1FFrame7 ; entry 12
    dw MetaSprites7F_7011Set1FFrame7 ; entry 13
    dw MetaSprites7F_7011Set1FFrame7 ; entry 14
    dw MetaSprites7F_7011Set1FFrame7 ; entry 15
    dw MetaSprites7F_7011Set1FFrame7 ; entry 16
    dw MetaSprites7F_7011Set1FFrame7 ; entry 17
    dw MetaSprites7F_7011Set1FFrame7 ; entry 18
    dw MetaSprites7F_7011Set1FFrame7 ; entry 19
    dw MetaSprites7F_7011Set1FFrame7 ; entry 20
    dw MetaSprites7F_7011Set1FFrame7 ; entry 21
    dw MetaSprites7F_7011Set1FFrame7 ; entry 22
    dw MetaSprites7F_7011Set1FFrame7 ; entry 23
    dw MetaSprites7F_7011Set1FFrame7 ; entry 24
    dw MetaSprites7F_7011Set1FFrame7 ; entry 25
    dw MetaSprites7F_7011Set1FFrame7 ; entry 26
    dw MetaSprites7F_7011Set1FFrame7 ; entry 27
    dw MetaSprites7F_7011Set1FFrame7 ; entry 28
    dw MetaSprites7F_7011Set1FFrame7 ; entry 29
    dw MetaSprites7F_7011Set1FFrame7 ; entry 30
    dw MetaSprites7F_7011Set1FFrame7 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set1FFrame0::
Data_07F_77DC:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_7011Set1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set1FFrame1::
Data_07F_77ED:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_7011Set1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set1FFrame2::
Data_07F_77FE:: ; address name
    db $F0, $00, $04, $20 ; entry 0
    db $F0, $F8, $05, $20 ; entry 1
    db $F8, $00, $06, $20 ; entry 2
    db $F8, $F8, $07, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_7011Set1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set1FFrame3::
Data_07F_780F:: ; address name
    db $F0, $F8, $08, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F8, $F8, $0A, $00 ; entry 2
    db $F8, $00, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_7011Set1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set1FFrame4::
Data_07F_7820:: ; address name
    db $F0, $F8, $0C, $00 ; entry 0
    db $F0, $00, $0D, $00 ; entry 1
    db $F8, $F8, $0E, $00 ; entry 2
    db $F8, $00, $0F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_7011Set1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set1FFrame5::
Data_07F_7831:: ; address name
    db $F0, $F8, $10, $00 ; entry 0
    db $F0, $00, $11, $00 ; entry 1
    db $F8, $F8, $12, $00 ; entry 2
    db $F8, $00, $13, $00 ; entry 3
    db $F0, $F5, $18, $00 ; entry 4
    db $EE, $FC, $19, $00 ; entry 5
    db $EA, $04, $1A, $00 ; entry 6
    db $E8, $F5, $16, $00 ; entry 7
    db $E6, $FC, $17, $00 ; entry 8
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites7F_7011Set1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set1FFrame6::
Data_07F_7856:: ; address name
    db $F0, $F8, $10, $00 ; entry 0
    db $F0, $00, $11, $00 ; entry 1
    db $F8, $F8, $14, $00 ; entry 2
    db $F8, $00, $15, $00 ; entry 3
    db $F8, $08, $1A, $00 ; entry 4
    db $F9, $EF, $16, $00 ; entry 5
    db $F8, $0C, $17, $00 ; entry 6
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites7F_7011Set1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set1FFrame7::
Data_07F_7873:: ; address name
    db $08, $E0, $00, $00 ; entry 0
    db $08, $E8, $01, $00 ; entry 1
    db $08, $F0, $02, $00 ; entry 2
    db $08, $F8, $03, $00 ; entry 3
    db $08, $00, $04, $00 ; entry 4
    db $08, $08, $05, $00 ; entry 5
    db $08, $10, $06, $00 ; entry 6
    db $08, $18, $07, $00 ; entry 7
    db $10, $E0, $10, $00 ; entry 8
    db $10, $E8, $11, $00 ; entry 9
    db $10, $F0, $12, $00 ; entry 10
    db $10, $F8, $13, $00 ; entry 11
    db $10, $00, $14, $00 ; entry 12
    db $10, $08, $15, $00 ; entry 13
    db $10, $10, $16, $00 ; entry 14
    db $10, $18, $17, $00 ; entry 15
    db $18, $E0, $20, $00 ; entry 16
    db $18, $E8, $21, $00 ; entry 17
    db $18, $F0, $22, $00 ; entry 18
    db $18, $F8, $23, $00 ; entry 19
    db $18, $00, $24, $00 ; entry 20
    db $18, $08, $25, $00 ; entry 21
    db $18, $10, $26, $00 ; entry 22
    db $18, $18, $27, $00 ; entry 23
    db $20, $E0, $30, $00 ; entry 24
    db $20, $E8, $31, $00 ; entry 25
    db $20, $F0, $32, $00 ; entry 26
    db $20, $F8, $33, $00 ; entry 27
    db $20, $00, $34, $00 ; entry 28
    db $20, $08, $35, $00 ; entry 29
    db $20, $10, $36, $00 ; entry 30
    db $20, $18, $37, $00 ; entry 31
    db $28, $E0, $40, $00 ; entry 32
    db $28, $E8, $41, $00 ; entry 33
    db $28, $F0, $42, $00 ; entry 34
    db $28, $F8, $43, $00 ; entry 35
    db $28, $00, $44, $00 ; entry 36
    db $28, $08, $45, $00 ; entry 37
    db $28, $10, $46, $00 ; entry 38
    db $28, $18, $47, $00 ; entry 39
    db $30, $E0, $50, $00 ; entry 40
    db $30, $E8, $51, $00 ; entry 41
    db $30, $F0, $52, $00 ; entry 42
    db $30, $F8, $53, $00 ; entry 43
    db $30, $00, $54, $00 ; entry 44
    db $30, $08, $55, $00 ; entry 45
    db $30, $10, $56, $00 ; entry 46
    db $30, $18, $57, $00 ; entry 47
    db $38, $E0, $00, $00 ; entry 48
    db $38, $E8, $01, $00 ; entry 49
    db $38, $F0, $02, $00 ; entry 50
    db $38, $F8, $03, $00 ; entry 51
    db $38, $00, $04, $00 ; entry 52
    db $38, $08, $05, $00 ; entry 53
    db $38, $10, $06, $00 ; entry 54
    db $38, $18, $07, $00 ; entry 55
    db $40, $E0, $10, $00 ; entry 56
    db $40, $E8, $11, $00 ; entry 57
    db $40, $F0, $12, $00 ; entry 58
    db $40, $F8, $13, $00 ; entry 59
    db $40, $00, $14, $00 ; entry 60
    db $40, $08, $15, $00 ; entry 61
    db $40, $10, $16, $00 ; entry 62
    db $40, $18, $17, $00 ; entry 63
    db $80 ; end

; E-0147 (derived: meta-sprite set 32 of MetaSprites7F_7011Table: 7 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set20::
Data_07F_7974:: ; address name
    dw MetaSprites7F_7011Set20Frame0 ; entry 0
    dw MetaSprites7F_7011Set20Frame1 ; entry 1
    dw MetaSprites7F_7011Set20Frame2 ; entry 2
    dw MetaSprites7F_7011Set20Frame3 ; entry 3
    dw MetaSprites7F_7011Set20Frame4 ; entry 4
    dw MetaSprites7F_7011Set20Frame5 ; entry 5
    dw MetaSprites7F_7011Set20Frame6 ; entry 6

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set20; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set20Frame0::
Data_07F_7982:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $01, $00 ; entry 1
    db $F0, $00, $00, $20 ; entry 2
    db $F8, $00, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_7011Set20; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set20Frame1::
Data_07F_7993:: ; address name
    db $F0, $F8, $02, $00 ; entry 0
    db $F8, $F8, $03, $00 ; entry 1
    db $F0, $00, $02, $20 ; entry 2
    db $F8, $00, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_7011Set20; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set20Frame2::
Data_07F_79A4:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F8, $F8, $05, $00 ; entry 1
    db $F0, $00, $04, $20 ; entry 2
    db $F8, $00, $05, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_7011Set20; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set20Frame3::
Data_07F_79B5:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $F8, $08, $00 ; entry 2
    db $F8, $00, $08, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_7011Set20; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set20Frame4::
Data_07F_79C6:: ; address name
    db $F0, $F8, $09, $00 ; entry 0
    db $F0, $00, $0A, $00 ; entry 1
    db $F8, $F8, $0B, $00 ; entry 2
    db $F8, $00, $0B, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_7011Set20; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set20Frame5::
Data_07F_79D7:: ; address name
    db $F0, $00, $06, $20 ; entry 0
    db $F0, $F8, $07, $20 ; entry 1
    db $F8, $00, $08, $20 ; entry 2
    db $F8, $F8, $08, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites7F_7011Set20; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set20Frame6::
Data_07F_79E8:: ; address name
    db $F0, $00, $09, $20 ; entry 0
    db $F0, $F8, $0A, $20 ; entry 1
    db $F8, $00, $0B, $20 ; entry 2
    db $F8, $F8, $0B, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 33 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set21::
Data_07F_79F9:: ; address name
    dw MetaSprites7F_7011Set21Frame0 ; entry 0

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set21; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set21Frame0::
Data_07F_79FB:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 34 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set22::
Data_07F_7A0C:: ; address name
    dw MetaSprites7F_7011Set22Frame0 ; entry 0

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set22; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set22Frame0::
Data_07F_7A0E:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 35 of MetaSprites7F_7011Table: 5 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set23::
Data_07F_7A1F:: ; address name
    dw MetaSprites7F_7011Set23Frame0 ; entry 0
    dw MetaSprites7F_7011Set23Frame1 ; entry 1
    dw MetaSprites7F_7011Set23Frame2 ; entry 2
    dw MetaSprites7F_7011Set23Frame3 ; entry 3
    dw MetaSprites7F_7011Set23Frame4 ; entry 4

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set23; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set23Frame0::
Data_07F_7A29:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F8, $F8, $01, $00 ; entry 1
    db $F0, $FF, $00, $20 ; entry 2
    db $F8, $FF, $01, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_7011Set23; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set23Frame1::
Data_07F_7A3A:: ; address name
    db $F0, $F8, $02, $00 ; entry 0
    db $F0, $00, $03, $00 ; entry 1
    db $F8, $00, $02, $60 ; entry 2
    db $F8, $F8, $03, $60 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_7011Set23; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set23Frame2::
Data_07F_7A4B:: ; address name
    db $F0, $00, $02, $20 ; entry 0
    db $F0, $F8, $03, $20 ; entry 1
    db $F8, $F8, $02, $40 ; entry 2
    db $F8, $00, $03, $40 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_7011Set23; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set23Frame3::
Data_07F_7A5C:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $00, $04, $60 ; entry 2
    db $F8, $F8, $05, $60 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_7011Set23; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set23Frame4::
Data_07F_7A6D:: ; address name
    db $F0, $F8, $06, $00 ; entry 0
    db $F0, $00, $07, $00 ; entry 1
    db $F8, $00, $06, $60 ; entry 2
    db $F8, $F8, $07, $60 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 36 of MetaSprites7F_7011Table: 5 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set24::
Data_07F_7A7E:: ; address name
    dw MetaSprites7F_7011Set24Frame0 ; entry 0
    dw MetaSprites7F_7011Set24Frame1 ; entry 1
    dw MetaSprites7F_7011Set24Frame2 ; entry 2
    dw MetaSprites7F_7011Set24Frame3 ; entry 3
    dw MetaSprites7F_7011Set24Frame4 ; entry 4

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set24; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set24Frame0::
Data_07F_7A88:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_7011Set24; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set24Frame1::
Data_07F_7A99:: ; address name
    db $F0, $F9, $04, $00 ; entry 0
    db $F0, $01, $05, $00 ; entry 1
    db $F8, $F9, $06, $00 ; entry 2
    db $F8, $01, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_7011Set24; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set24Frame2::
Data_07F_7AAA:: ; address name
    db $F0, $00, $00, $20 ; entry 0
    db $F0, $F8, $01, $20 ; entry 1
    db $F8, $00, $02, $20 ; entry 2
    db $F8, $F8, $03, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_7011Set24; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set24Frame3::
Data_07F_7ABB:: ; address name
    db $F0, $01, $04, $20 ; entry 0
    db $F0, $F9, $05, $20 ; entry 1
    db $F8, $01, $06, $20 ; entry 2
    db $F8, $F9, $07, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_7011Set24; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set24Frame4::
Data_07F_7ACC:: ; address name
    db $F0, $F8, $04, $00 ; entry 0
    db $F0, $00, $05, $00 ; entry 1
    db $F8, $F8, $06, $00 ; entry 2
    db $F8, $00, $07, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: meta-sprite set 37 of MetaSprites7F_7011Table: 5 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set25::
Data_07F_7ADD:: ; address name
    dw MetaSprites7F_7011Set25Frame0 ; entry 0
    dw MetaSprites7F_7011Set25Frame1 ; entry 1
    dw MetaSprites7F_7011Set25Frame1 ; entry 2
    dw MetaSprites7F_7011Set25Frame2 ; entry 3
    dw MetaSprites7F_7011Set25Frame3 ; entry 4

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set25Frame0::
Data_07F_7AE7:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_7011Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set25Frame1::
Data_07F_7AEC:: ; address name
    db $F0, $F8, $01, $00 ; entry 0
    db $F0, $00, $02, $00 ; entry 1
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_7011Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set25Frame2::
Data_07F_7AF5:: ; address name
    db $F0, $F9, $03, $00 ; entry 0
    db $F0, $01, $04, $00 ; entry 1
    db $F8, $F9, $05, $00 ; entry 2
    db $F8, $01, $06, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_7011Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set25Frame3::
Data_07F_7B06:: ; address name
    db $F8, $00, $07, $00 ; entry 0
    db $F8, $F8, $05, $00 ; entry 1
    db $80 ; end

; E-0147 (derived: meta-sprite set 38 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set26::
Data_07F_7B0F:: ; address name
    dw MetaSprites7F_7011Set26Frame0 ; entry 0

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set26Frame0::
Data_07F_7B11:: ; address name
    db $00, $00, $00, $00 ; entry 0
    db $80 ; end

; E-0147 (derived: meta-sprite set 39 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set27::
Data_07F_7B16:: ; address name
    dw MetaSprites7F_7011Set27Frame0 ; entry 0

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set27Frame0::
Data_07F_7B18:: ; address name
    db $00, $00, $00, $00 ; entry 0
    db $80 ; end

; E-0147 (derived: meta-sprite set 40 of MetaSprites7F_7011Table: 1 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set28::
Data_07F_7B1D:: ; address name
    dw MetaSprites7F_7011Set28Frame0 ; entry 0

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set28; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set28Frame0::
Data_07F_7B1F:: ; address name
    db $00, $00, $00, $00 ; entry 0
    db $80 ; end

; E-0147 (derived: meta-sprite set 41 of MetaSprites7F_7011Table: 6 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites7F_7011Set29::
Data_07F_7B24:: ; address name
    dw MetaSprites7F_7011Set29Frame0 ; entry 0
    dw MetaSprites7F_7011Set29Frame1 ; entry 1
    dw MetaSprites7F_7011Set29Frame2 ; entry 2
    dw MetaSprites7F_7011Set29Frame3 ; entry 3
    dw MetaSprites7F_7011Set29Frame4 ; entry 4
    dw MetaSprites7F_7011Set29Frame5 ; entry 5

; E-0147 (derived: frame 0 of MetaSprites7F_7011Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set29Frame0::
Data_07F_7B30:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites7F_7011Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set29Frame1::
Data_07F_7B41:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites7F_7011Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set29Frame2::
Data_07F_7B52:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites7F_7011Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set29Frame3::
Data_07F_7B63:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites7F_7011Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set29Frame4::
Data_07F_7B74:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites7F_7011Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites7F_7011Set29Frame5::
Data_07F_7B85:: ; address name
    db $F0, $F8, $00, $00 ; entry 0
    db $F0, $00, $01, $00 ; entry 1
    db $F8, $F8, $02, $00 ; entry 2
    db $F8, $00, $03, $00 ; entry 3
    db $80 ; end
    ds $46A, $00
