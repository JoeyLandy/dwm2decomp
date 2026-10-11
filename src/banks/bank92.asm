SECTION "Bank 92", ROMX[$4000], BANK[$92]
    db $92

; sets the sprite origin X = wD804, Y = $68, tile offset = wD801, attribute XOR = wDAB7, then builds OAM from the local sprite table (E-0121)
; 1 call site from 1 routine (e.g. DrawEffectSpriteForEffectTileOffsetRange)
; reads: wEffectSpriteX, wEffectTileOffset, wEffectSpriteAttrXor
; points at: hSpriteOriginX
DrawEffectSpriteAtEffectSpriteX_Bank92::
Func_092_4001:: ; address name
    ld hl, hSpriteOriginX
    ld a, [wEffectSpriteX]
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $68
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, [wEffectTileOffset]
    ld [hl+], a
    ld a, [wEffectSpriteAttrXor]
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld [hl+], a
    ld de, MetaSprites92_4024Table
    call BuildOamFromSpriteTable_Bank92
    ret

; E-0147 (C1: the caller of BuildOamFromSpriteTable_Bank92 passes DE = $92:4024; the builder takes the word at DE + 2 * hSpriteSetIndex as the set and the word at set + 2 * hSpriteSubIndex as the frame; 60 words, up to the next code or data).
; record: meta-sprite set
MetaSprites92_4024Table::
Data_092_4024:: ; address name
    dw MetaSprites92_4024Set00 ; id 0
    dw MetaSprites92_4024Set00 ; id 1
    dw MetaSprites92_4024Set00 ; id 2
    dw MetaSprites92_4024Set00 ; id 3
    dw MetaSprites92_4024Set00 ; id 4
    dw MetaSprites92_4024Set00 ; id 5
    dw MetaSprites92_4024Set00 ; id 6
    dw MetaSprites92_4024Set00 ; id 7
    dw MetaSprites92_4024Set00 ; id 8
    dw MetaSprites92_4024Set00 ; id 9
    dw MetaSprites92_4024Set00 ; id 10
    dw MetaSprites92_4024Set00 ; id 11
    dw MetaSprites92_4024Set00 ; id 12
    dw MetaSprites92_4024Set00 ; id 13
    dw MetaSprites92_4024Set00 ; id 14
    dw MetaSprites92_4024Set00 ; id 15
    dw MetaSprites92_4024Set00 ; id 16
    dw MetaSprites92_4024Set00 ; id 17
    dw MetaSprites92_4024Set00 ; id 18
    dw MetaSprites92_4024Set00 ; id 19
    dw MetaSprites92_4024Set00 ; id 20
    dw MetaSprites92_4024Set00 ; id 21
    dw MetaSprites92_4024Set00 ; id 22
    dw MetaSprites92_4024Set00 ; id 23
    dw MetaSprites92_4024Set00 ; id 24
    dw MetaSprites92_4024Set00 ; id 25
    dw MetaSprites92_4024Set00 ; id 26
    dw MetaSprites92_4024Set00 ; id 27
    dw MetaSprites92_4024Set00 ; id 28
    dw MetaSprites92_4024Set00 ; id 29
    dw MetaSprites92_4024Set00 ; id 30
    dw MetaSprites92_4024Set00 ; id 31
    dw MetaSprites92_4024Set00 ; id 32
    dw MetaSprites92_4024Set00 ; id 33
    dw MetaSprites92_4024Set00 ; id 34
    dw MetaSprites92_4024Set00 ; id 35
    dw MetaSprites92_4024Set00 ; id 36
    dw MetaSprites92_4024Set00 ; id 37
    dw MetaSprites92_4024Set00 ; id 38
    dw MetaSprites92_4024Set00 ; id 39
    dw MetaSprites92_4024Set00 ; id 40
    dw MetaSprites92_4024Set00 ; id 41
    dw MetaSprites92_4024Set00 ; id 42
    dw MetaSprites92_4024Set00 ; id 43
    dw MetaSprites92_4024Set00 ; id 44
    dw MetaSprites92_4024Set00 ; id 45
    dw MetaSprites92_4024Set00 ; id 46
    dw MetaSprites92_4024Set00 ; id 47
    dw MetaSprites92_4024Set00 ; id 48
    dw MetaSprites92_4024Set00 ; id 49
    dw MetaSprites92_4024Set00 ; id 50
    dw MetaSprites92_4024Set00 ; id 51
    dw MetaSprites92_4024Set34 ; id 52
    dw MetaSprites92_4024Set35 ; id 53
    dw MetaSprites92_4024Set36 ; id 54
    dw MetaSprites92_4024Set37 ; id 55
    dw MetaSprites92_4024Set38 ; id 56
    dw MetaSprites92_4024Set39 ; id 57
    dw MetaSprites92_4024Set3A ; id 58
    dw MetaSprites92_4024Set3B ; id 59

; DE = two-level table; entries are chosen by hSpriteSetIndex and hSpriteSubIndex; writes 4-byte OAM entries at $C000 + 4 * hOamNextEntry (Y = hSpriteOriginY + b + $10, X = hSpriteOriginX + b + 8, tile += hSpriteTileOffset, flags ^= hSpriteAttrXor) until a $80 byte or hOamNextEntry reaches $28 (40 entries) (the same 81 bytes appear in 5 banks)
; 1 call site from 1 routine (e.g. DrawEffectSpriteAtEffectSpriteX_Bank92)
; reads: hOamNextEntry, hSpriteSetIndex, hSpriteSubIndex, hSpriteOriginY, hSpriteOriginX, hSpriteTileOffset, hSpriteAttrXor
; writes: hOamNextEntry
BuildOamFromSpriteTable_Bank92::
Func_092_409C:: ; address name
    ldh a, [hOamNextEntry]
    cp a, $28
    jr nc, Jump_092_40EC
    ldh a, [hSpriteSetIndex]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, de
    ld e, [hl]
    inc hl
    ld d, [hl]
    ldh a, [hSpriteSubIndex]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, de
    ld e, [hl]
    inc hl
    ld d, [hl]
    ldh a, [hOamNextEntry]
    sla a
    sla a
    ld l, a
    ld h, $C0

Jump_092_40BF::
    ld a, [de]
    inc de
    cp a, $80
    jr z, Jump_092_40EC
    ld b, a
    ldh a, [hSpriteOriginY]
    add a, b
    add a, $10
    ld [hl+], a
    ld a, [de]
    inc de
    ld b, a
    ldh a, [hSpriteOriginX]
    add a, b
    add a, $08
    ld [hl+], a
    ldh a, [hSpriteTileOffset]
    ld b, a
    ld a, [de]
    inc de
    add a, b
    ld [hl+], a
    ld a, [de]
    inc de
    ld b, a
    ldh a, [hSpriteAttrXor]
    xor a, b
    ld [hl+], a
    ldh a, [hOamNextEntry]
    inc a
    ldh [hOamNextEntry], a
    cp a, $28
    jr c, Jump_092_40BF

Jump_092_40EC::
    ret

; E-0147 (derived: meta-sprite set 0 of MetaSprites92_4024Table: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites92_4024Set00::
Data_092_40ED:: ; address name
    dw MetaSprites92_4024Set00Frame0 ; entry 0
    dw MetaSprites92_4024Set00Frame1 ; entry 1
    dw MetaSprites92_4024Set00Frame2 ; entry 2
    dw MetaSprites92_4024Set00Frame3 ; entry 3
    dw MetaSprites92_4024Set00Frame4 ; entry 4
    dw MetaSprites92_4024Set00Frame5 ; entry 5
    dw MetaSprites92_4024Set00Frame6 ; entry 6
    dw MetaSprites92_4024Set00Frame7 ; entry 7
    dw MetaSprites92_4024Set00Frame8 ; entry 8
    dw MetaSprites92_4024Set00Frame9 ; entry 9
    dw MetaSprites92_4024Set00Frame10 ; entry 10
    dw MetaSprites92_4024Set00Frame11 ; entry 11
    dw MetaSprites92_4024Set00Frame12 ; entry 12
    dw MetaSprites92_4024Set00Frame13 ; entry 13
    dw MetaSprites92_4024Set00Frame14 ; entry 14
    dw MetaSprites92_4024Set00Frame15 ; entry 15
    dw MetaSprites92_4024Set00Frame16 ; entry 16
    dw MetaSprites92_4024Set00Frame17 ; entry 17
    dw MetaSprites92_4024Set00Frame18 ; entry 18
    dw MetaSprites92_4024Set00Frame19 ; entry 19
    dw MetaSprites92_4024Set00Frame20 ; entry 20
    dw MetaSprites92_4024Set00Frame21 ; entry 21
    dw MetaSprites92_4024Set00Frame22 ; entry 22
    dw MetaSprites92_4024Set00Frame22 ; entry 23
    dw MetaSprites92_4024Set00Frame22 ; entry 24
    dw MetaSprites92_4024Set00Frame22 ; entry 25
    dw MetaSprites92_4024Set00Frame22 ; entry 26
    dw MetaSprites92_4024Set00Frame22 ; entry 27
    dw MetaSprites92_4024Set00Frame22 ; entry 28
    dw MetaSprites92_4024Set00Frame22 ; entry 29
    dw MetaSprites92_4024Set00Frame22 ; entry 30
    dw MetaSprites92_4024Set00Frame22 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites92_4024Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set00Frame0::
Data_092_412D:: ; address name
    db $D0, $BC, $00, $10 ; entry 0
    db $D0, $3C, $00, $10 ; entry 1
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites92_4024Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set00Frame1::
Data_092_4136:: ; address name
    db $D0, $B8, $01, $10 ; entry 0
    db $D0, $C0, $01, $30 ; entry 1
    db $D0, $38, $01, $10 ; entry 2
    db $D0, $40, $01, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites92_4024Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set00Frame2::
Data_092_4147:: ; address name
    db $E8, $B8, $05, $10 ; entry 0
    db $E8, $C0, $06, $10 ; entry 1
    db $F0, $B8, $07, $10 ; entry 2
    db $F0, $C0, $08, $10 ; entry 3
    db $E0, $BE, $04, $10 ; entry 4
    db $D0, $BB, $02, $10 ; entry 5
    db $D8, $BB, $03, $10 ; entry 6
    db $F8, $B8, $09, $10 ; entry 7
    db $F8, $C0, $0A, $10 ; entry 8
    db $D0, $BC, $00, $10 ; entry 9
    db $D0, $CC, $00, $10 ; entry 10
    db $F0, $40, $05, $70 ; entry 11
    db $F0, $38, $06, $70 ; entry 12
    db $E8, $40, $07, $70 ; entry 13
    db $E8, $38, $08, $70 ; entry 14
    db $D8, $3A, $04, $70 ; entry 15
    db $E0, $3D, $03, $70 ; entry 16
    db $F8, $40, $09, $70 ; entry 17
    db $F8, $38, $0A, $70 ; entry 18
    db $D0, $2C, $00, $30 ; entry 19
    db $D0, $3B, $02, $30 ; entry 20
    db $D0, $3C, $00, $30 ; entry 21
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites92_4024Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set00Frame3::
Data_092_41A0:: ; address name
    db $D0, $BC, $0B, $10 ; entry 0
    db $F0, $BC, $0F, $10 ; entry 1
    db $E8, $BC, $0E, $10 ; entry 2
    db $E0, $B7, $07, $10 ; entry 3
    db $E0, $BF, $08, $10 ; entry 4
    db $D8, $BB, $0F, $50 ; entry 5
    db $D0, $C8, $01, $10 ; entry 6
    db $D0, $D0, $01, $30 ; entry 7
    db $F8, $BA, $10, $10 ; entry 8
    db $D0, $30, $01, $30 ; entry 9
    db $D0, $28, $01, $10 ; entry 10
    db $D0, $3B, $0B, $30 ; entry 11
    db $F0, $3B, $0F, $30 ; entry 12
    db $E8, $3B, $0E, $30 ; entry 13
    db $D8, $3C, $0F, $70 ; entry 14
    db $E0, $3C, $0C, $10 ; entry 15
    db $E0, $40, $0E, $10 ; entry 16
    db $F8, $3C, $10, $10 ; entry 17
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites92_4024Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set00Frame4::
Data_092_41E9:: ; address name
    db $E8, $BC, $0C, $10 ; entry 0
    db $F0, $BC, $0D, $10 ; entry 1
    db $D0, $DC, $00, $10 ; entry 2
    db $F0, $D0, $05, $70 ; entry 3
    db $F0, $C8, $06, $70 ; entry 4
    db $E8, $D0, $07, $70 ; entry 5
    db $E8, $C8, $08, $70 ; entry 6
    db $D8, $CA, $04, $70 ; entry 7
    db $E0, $CD, $03, $70 ; entry 8
    db $F8, $D0, $09, $70 ; entry 9
    db $F8, $C8, $0A, $70 ; entry 10
    db $D0, $CB, $02, $30 ; entry 11
    db $D0, $CC, $00, $30 ; entry 12
    db $F0, $3B, $0D, $30 ; entry 13
    db $E8, $28, $05, $10 ; entry 14
    db $E8, $30, $06, $10 ; entry 15
    db $F0, $28, $07, $10 ; entry 16
    db $F0, $30, $08, $10 ; entry 17
    db $E0, $2E, $04, $10 ; entry 18
    db $D8, $2B, $03, $10 ; entry 19
    db $F8, $28, $09, $10 ; entry 20
    db $F8, $30, $0A, $10 ; entry 21
    db $D0, $1C, $00, $30 ; entry 22
    db $D0, $2B, $02, $50 ; entry 23
    db $D0, $2C, $00, $10 ; entry 24
    db $D0, $BB, $0D, $50 ; entry 25
    db $D8, $BB, $0C, $50 ; entry 26
    db $E0, $BC, $0B, $50 ; entry 27
    db $D0, $3B, $0C, $50 ; entry 28
    db $E0, $3B, $0C, $30 ; entry 29
    db $D8, $3A, $0B, $30 ; entry 30
    db $E8, $3C, $0D, $70 ; entry 31
    db $F8, $BB, $29, $10 ; entry 32
    db $F8, $C3, $2A, $10 ; entry 33
    db $F8, $B4, $2A, $30 ; entry 34
    db $F8, $3B, $29, $10 ; entry 35
    db $F8, $43, $2A, $10 ; entry 36
    db $F8, $34, $2A, $30 ; entry 37
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites92_4024Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set00Frame5::
Data_092_4282:: ; address name
    db $D0, $CC, $0B, $30 ; entry 0
    db $F0, $CC, $0F, $30 ; entry 1
    db $E8, $CC, $0E, $30 ; entry 2
    db $D8, $CD, $0F, $70 ; entry 3
    db $E0, $CD, $0C, $10 ; entry 4
    db $E0, $D1, $0E, $10 ; entry 5
    db $D0, $D8, $01, $10 ; entry 6
    db $D0, $E0, $01, $30 ; entry 7
    db $F8, $CD, $10, $10 ; entry 8
    db $F0, $2C, $0B, $70 ; entry 9
    db $D0, $2C, $0F, $70 ; entry 10
    db $D8, $2C, $0E, $70 ; entry 11
    db $E8, $2D, $0F, $30 ; entry 12
    db $D0, $20, $01, $30 ; entry 13
    db $D0, $18, $01, $10 ; entry 14
    db $F8, $2D, $10, $10 ; entry 15
    db $F0, $3B, $0C, $70 ; entry 16
    db $E8, $3C, $08, $30 ; entry 17
    db $E0, $2B, $08, $30 ; entry 18
    db $E0, $31, $07, $70 ; entry 19
    db $E8, $BC, $0C, $70 ; entry 20
    db $F0, $BD, $0B, $50 ; entry 21
    db $F8, $B9, $2B, $30 ; entry 22
    db $F8, $B1, $2C, $30 ; entry 23
    db $F8, $C0, $2B, $10 ; entry 24
    db $F8, $C8, $2C, $10 ; entry 25
    db $F8, $38, $2B, $30 ; entry 26
    db $F8, $30, $2C, $30 ; entry 27
    db $F8, $3F, $2B, $10 ; entry 28
    db $F8, $47, $2C, $10 ; entry 29
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites92_4024Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set00Frame6::
Data_092_42FB:: ; address name
    db $E8, $CC, $0C, $30 ; entry 0
    db $F0, $CC, $0D, $30 ; entry 1
    db $E8, $D8, $05, $10 ; entry 2
    db $E8, $E0, $06, $10 ; entry 3
    db $F0, $D8, $07, $10 ; entry 4
    db $F0, $E0, $08, $10 ; entry 5
    db $E0, $DE, $04, $10 ; entry 6
    db $D8, $DB, $03, $10 ; entry 7
    db $F8, $D8, $09, $10 ; entry 8
    db $F8, $E0, $0A, $10 ; entry 9
    db $D0, $EC, $00, $10 ; entry 10
    db $D0, $0C, $00, $30 ; entry 11
    db $F0, $20, $05, $70 ; entry 12
    db $F0, $18, $06, $70 ; entry 13
    db $E8, $20, $07, $70 ; entry 14
    db $E8, $18, $08, $70 ; entry 15
    db $D8, $1A, $04, $70 ; entry 16
    db $E0, $1D, $03, $70 ; entry 17
    db $F8, $20, $09, $70 ; entry 18
    db $F8, $18, $0A, $70 ; entry 19
    db $D0, $1C, $02, $30 ; entry 20
    db $D0, $1D, $00, $10 ; entry 21
    db $D0, $DA, $02, $70 ; entry 22
    db $D0, $DC, $00, $10 ; entry 23
    db $F0, $2E, $0C, $10 ; entry 24
    db $D0, $2D, $0C, $50 ; entry 25
    db $D0, $CD, $0D, $70 ; entry 26
    db $D8, $2D, $0D, $50 ; entry 27
    db $D8, $CD, $0C, $70 ; entry 28
    db $E0, $2D, $0C, $50 ; entry 29
    db $E8, $2E, $0B, $50 ; entry 30
    db $E0, $CC, $0B, $70 ; entry 31
    db $F8, $CC, $29, $10 ; entry 32
    db $F8, $D4, $2A, $10 ; entry 33
    db $F8, $C5, $2A, $30 ; entry 34
    db $F8, $2C, $29, $10 ; entry 35
    db $F8, $33, $2A, $10 ; entry 36
    db $F8, $25, $2A, $30 ; entry 37
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites92_4024Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set00Frame7::
Data_092_4394:: ; address name
    db $D0, $DC, $0B, $10 ; entry 0
    db $F0, $DC, $0F, $10 ; entry 1
    db $E8, $DC, $0E, $10 ; entry 2
    db $E0, $D7, $07, $10 ; entry 3
    db $E0, $DF, $08, $10 ; entry 4
    db $D8, $DB, $0F, $50 ; entry 5
    db $D0, $E8, $01, $10 ; entry 6
    db $D0, $F0, $01, $30 ; entry 7
    db $F8, $DB, $10, $30 ; entry 8
    db $F0, $CD, $0C, $50 ; entry 9
    db $E8, $CC, $08, $10 ; entry 10
    db $D0, $10, $01, $30 ; entry 11
    db $D0, $08, $01, $10 ; entry 12
    db $F8, $1B, $10, $30 ; entry 13
    db $E8, $2B, $0D, $30 ; entry 14
    db $F0, $19, $0B, $70 ; entry 15
    db $D8, $19, $0E, $70 ; entry 16
    db $E8, $1A, $0F, $30 ; entry 17
    db $E0, $1A, $0C, $50 ; entry 18
    db $E0, $1E, $0E, $10 ; entry 19
    db $D0, $1A, $0F, $70 ; entry 20
    db $F0, $2D, $0B, $50 ; entry 21
    db $F8, $C9, $2B, $30 ; entry 22
    db $F8, $C1, $2C, $30 ; entry 23
    db $F8, $D0, $2B, $10 ; entry 24
    db $F8, $D8, $2C, $10 ; entry 25
    db $F8, $28, $2B, $30 ; entry 26
    db $F8, $20, $2C, $30 ; entry 27
    db $F8, $2F, $2B, $10 ; entry 28
    db $F8, $37, $2C, $10 ; entry 29
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites92_4024Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set00Frame8::
Data_092_440D:: ; address name
    db $E8, $DC, $0C, $10 ; entry 0
    db $F0, $DC, $0D, $10 ; entry 1
    db $D0, $FC, $00, $10 ; entry 2
    db $F0, $F0, $05, $70 ; entry 3
    db $F0, $E8, $06, $70 ; entry 4
    db $E8, $F0, $07, $70 ; entry 5
    db $E8, $E8, $08, $70 ; entry 6
    db $D8, $EA, $04, $70 ; entry 7
    db $E0, $ED, $03, $70 ; entry 8
    db $F8, $F0, $09, $70 ; entry 9
    db $F8, $E8, $0A, $70 ; entry 10
    db $D0, $EB, $02, $30 ; entry 11
    db $D0, $EC, $00, $30 ; entry 12
    db $E8, $10, $05, $30 ; entry 13
    db $E8, $08, $06, $30 ; entry 14
    db $F0, $10, $07, $30 ; entry 15
    db $F0, $08, $08, $30 ; entry 16
    db $E0, $0A, $04, $30 ; entry 17
    db $D0, $0D, $02, $30 ; entry 18
    db $D8, $0D, $03, $30 ; entry 19
    db $F8, $10, $09, $30 ; entry 20
    db $F8, $08, $0A, $30 ; entry 21
    db $D0, $0C, $00, $30 ; entry 22
    db $D0, $1C, $0C, $30 ; entry 23
    db $D8, $1C, $0D, $30 ; entry 24
    db $D0, $DB, $0D, $50 ; entry 25
    db $E0, $1D, $0D, $70 ; entry 26
    db $D8, $DB, $0C, $50 ; entry 27
    db $E8, $1D, $0C, $70 ; entry 28
    db $E0, $DC, $0B, $50 ; entry 29
    db $F0, $1E, $0B, $50 ; entry 30
    db $F8, $DB, $29, $10 ; entry 31
    db $F8, $E3, $2A, $10 ; entry 32
    db $F8, $D4, $2A, $30 ; entry 33
    db $F8, $1C, $29, $10 ; entry 34
    db $F8, $24, $2A, $10 ; entry 35
    db $F8, $15, $2A, $30 ; entry 36
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites92_4024Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set00Frame9::
Data_092_44A2:: ; address name
    db $D0, $EC, $0B, $30 ; entry 0
    db $F0, $EC, $0F, $30 ; entry 1
    db $E8, $EC, $0E, $30 ; entry 2
    db $D8, $ED, $0F, $70 ; entry 3
    db $E0, $ED, $0C, $10 ; entry 4
    db $E0, $F1, $0E, $10 ; entry 5
    db $D0, $F8, $01, $10 ; entry 6
    db $D0, $00, $01, $30 ; entry 7
    db $F8, $ED, $10, $10 ; entry 8
    db $E8, $DD, $0D, $10 ; entry 9
    db $F8, $0D, $10, $30 ; entry 10
    db $F0, $0E, $0E, $50 ; entry 11
    db $D8, $0D, $0B, $50 ; entry 12
    db $D0, $0D, $0F, $30 ; entry 13
    db $E8, $0D, $0F, $50 ; entry 14
    db $E0, $0F, $08, $10 ; entry 15
    db $E0, $09, $07, $10 ; entry 16
    db $F0, $DB, $0B, $70 ; entry 17
    db $F0, $1C, $0B, $10 ; entry 18
    db $E8, $1B, $0C, $70 ; entry 19
    db $F8, $D9, $2B, $30 ; entry 20
    db $F8, $D1, $2C, $30 ; entry 21
    db $F8, $E0, $2B, $10 ; entry 22
    db $F8, $E8, $2C, $10 ; entry 23
    db $F8, $18, $2B, $30 ; entry 24
    db $F8, $10, $2C, $30 ; entry 25
    db $F8, $1F, $2B, $10 ; entry 26
    db $F8, $27, $2C, $10 ; entry 27
    db $80 ; end

; E-0147 (derived: frame 10 of MetaSprites92_4024Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set00Frame10::
Data_092_4513:: ; address name
    db $E8, $EB, $0C, $30 ; entry 0
    db $F0, $EB, $0D, $30 ; entry 1
    db $F0, $0D, $0C, $10 ; entry 2
    db $D0, $0C, $0D, $30 ; entry 3
    db $D0, $EC, $0D, $70 ; entry 4
    db $E0, $0C, $0C, $50 ; entry 5
    db $D8, $EC, $0C, $70 ; entry 6
    db $D8, $0C, $0D, $50 ; entry 7
    db $E0, $EB, $0B, $70 ; entry 8
    db $E8, $0D, $0B, $50 ; entry 9
    db $D8, $FC, $0C, $10 ; entry 10
    db $F8, $EB, $29, $10 ; entry 11
    db $F8, $F3, $2A, $10 ; entry 12
    db $F8, $E4, $2A, $30 ; entry 13
    db $F8, $0C, $29, $10 ; entry 14
    db $F8, $13, $2A, $10 ; entry 15
    db $F8, $05, $2A, $30 ; entry 16
    db $D0, $FC, $29, $50 ; entry 17
    db $D0, $04, $2A, $50 ; entry 18
    db $D0, $F5, $2A, $70 ; entry 19
    db $80 ; end

; E-0147 (derived: frame 11 of MetaSprites92_4024Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set00Frame11::
Data_092_4564:: ; address name
    db $F0, $ED, $0B, $10 ; entry 0
    db $E8, $EC, $0C, $50 ; entry 1
    db $F0, $0B, $0C, $70 ; entry 2
    db $E8, $0C, $08, $70 ; entry 3
    db $D8, $FB, $0D, $70 ; entry 4
    db $F8, $E9, $2B, $30 ; entry 5
    db $F8, $E1, $2C, $30 ; entry 6
    db $F8, $F0, $2B, $10 ; entry 7
    db $F8, $F8, $2C, $10 ; entry 8
    db $F8, $08, $2B, $30 ; entry 9
    db $F8, $00, $2C, $30 ; entry 10
    db $F8, $0F, $2B, $10 ; entry 11
    db $F8, $17, $2C, $10 ; entry 12
    db $D0, $F8, $2B, $70 ; entry 13
    db $D0, $F0, $2C, $70 ; entry 14
    db $D0, $00, $2B, $50 ; entry 15
    db $D0, $08, $2C, $50 ; entry 16
    db $80 ; end

; E-0147 (derived: frame 12 of MetaSprites92_4024Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set00Frame12::
Data_092_45A9:: ; address name
    db $F0, $00, $05, $70 ; entry 0
    db $F0, $F8, $06, $70 ; entry 1
    db $E8, $00, $07, $70 ; entry 2
    db $E8, $F8, $08, $70 ; entry 3
    db $D8, $FA, $04, $70 ; entry 4
    db $E0, $FD, $03, $70 ; entry 5
    db $F8, $00, $09, $70 ; entry 6
    db $F8, $F8, $0A, $70 ; entry 7
    db $D0, $FB, $02, $30 ; entry 8
    db $D0, $FC, $00, $30 ; entry 9
    db $80 ; end

; E-0147 (derived: frame 13 of MetaSprites92_4024Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set00Frame13::
Data_092_45D2:: ; address name
    db $F8, $FC, $05, $30 ; entry 0
    db $F8, $F4, $06, $30 ; entry 1
    db $F0, $F6, $04, $30 ; entry 2
    db $E0, $F6, $1E, $50 ; entry 3
    db $E0, $FE, $1F, $50 ; entry 4
    db $E8, $F6, $1C, $70 ; entry 5
    db $E8, $EE, $1D, $70 ; entry 6
    db $D8, $FD, $1A, $70 ; entry 7
    db $D8, $F5, $1B, $70 ; entry 8
    db $D0, $FE, $04, $50 ; entry 9
    db $80 ; end

; E-0147 (derived: frame 14 of MetaSprites92_4024Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set00Frame14::
Data_092_45FB:: ; address name
    db $D8, $00, $1C, $50 ; entry 0
    db $D8, $08, $1D, $50 ; entry 1
    db $E0, $00, $1A, $50 ; entry 2
    db $E0, $08, $1B, $50 ; entry 3
    db $E8, $00, $18, $50 ; entry 4
    db $E8, $08, $19, $50 ; entry 5
    db $F0, $F0, $14, $50 ; entry 6
    db $F0, $F8, $15, $50 ; entry 7
    db $F0, $00, $16, $50 ; entry 8
    db $F0, $08, $17, $50 ; entry 9
    db $F8, $F0, $12, $50 ; entry 10
    db $F8, $F8, $13, $50 ; entry 11
    db $D0, $00, $1E, $70 ; entry 12
    db $D0, $F8, $1F, $70 ; entry 13
    db $80 ; end

; E-0147 (derived: frame 15 of MetaSprites92_4024Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set00Frame15::
Data_092_4634:: ; address name
    db $F0, $00, $1C, $10 ; entry 0
    db $E8, $00, $1A, $10 ; entry 1
    db $E0, $00, $18, $10 ; entry 2
    db $D8, $F0, $14, $10 ; entry 3
    db $D8, $F8, $15, $10 ; entry 4
    db $D8, $00, $16, $10 ; entry 5
    db $D0, $F0, $12, $10 ; entry 6
    db $F8, $F8, $1F, $30 ; entry 7
    db $F0, $10, $1D, $10 ; entry 8
    db $E8, $10, $1B, $10 ; entry 9
    db $E0, $10, $19, $10 ; entry 10
    db $D8, $10, $17, $30 ; entry 11
    db $F8, $08, $1E, $30 ; entry 12
    db $F8, $00, $11, $10 ; entry 13
    db $E0, $08, $11, $10 ; entry 14
    db $E8, $08, $15, $10 ; entry 15
    db $D8, $08, $17, $10 ; entry 16
    db $F0, $08, $15, $50 ; entry 17
    db $D0, $FD, $19, $10 ; entry 18
    db $D0, $F8, $11, $10 ; entry 19
    db $80 ; end

; E-0147 (derived: frame 16 of MetaSprites92_4024Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set00Frame16::
Data_092_4685:: ; address name
    db $D8, $FC, $1C, $50 ; entry 0
    db $E0, $FC, $1A, $50 ; entry 1
    db $E8, $FC, $18, $50 ; entry 2
    db $F0, $EC, $14, $50 ; entry 3
    db $F0, $F4, $15, $50 ; entry 4
    db $F8, $EC, $12, $50 ; entry 5
    db $D0, $F4, $1F, $70 ; entry 6
    db $E0, $0C, $1B, $50 ; entry 7
    db $E8, $0C, $19, $50 ; entry 8
    db $D0, $FC, $11, $50 ; entry 9
    db $E8, $04, $11, $50 ; entry 10
    db $E0, $04, $15, $50 ; entry 11
    db $F8, $F4, $11, $50 ; entry 12
    db $F0, $04, $16, $50 ; entry 13
    db $F0, $0C, $17, $50 ; entry 14
    db $F8, $01, $19, $50 ; entry 15
    db $F0, $FC, $11, $50 ; entry 16
    db $F8, $FB, $11, $50 ; entry 17
    db $D8, $14, $1D, $50 ; entry 18
    db $D0, $0C, $1E, $70 ; entry 19
    db $D8, $0C, $15, $10 ; entry 20
    db $D0, $04, $11, $10 ; entry 21
    db $D8, $04, $16, $50 ; entry 22
    db $80 ; end

; E-0147 (derived: frame 17 of MetaSprites92_4024Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set00Frame17::
Data_092_46E2:: ; address name
    db $F0, $E4, $1D, $30 ; entry 0
    db $E0, $E4, $19, $30 ; entry 1
    db $F8, $EC, $1E, $10 ; entry 2
    db $E0, $EC, $11, $30 ; entry 3
    db $D8, $EC, $16, $30 ; entry 4
    db $D8, $E4, $17, $30 ; entry 5
    db $D8, $FC, $1C, $70 ; entry 6
    db $F0, $0C, $14, $70 ; entry 7
    db $F0, $04, $15, $70 ; entry 8
    db $F8, $0C, $12, $70 ; entry 9
    db $F8, $04, $11, $70 ; entry 10
    db $F0, $FC, $11, $70 ; entry 11
    db $D0, $04, $16, $50 ; entry 12
    db $D0, $0C, $17, $50 ; entry 13
    db $E0, $02, $1F, $50 ; entry 14
    db $F8, $FC, $11, $70 ; entry 15
    db $D0, $EF, $19, $30 ; entry 16
    db $F8, $F4, $11, $10 ; entry 17
    db $F0, $F4, $11, $70 ; entry 18
    db $E8, $F4, $11, $70 ; entry 19
    db $E8, $EC, $11, $70 ; entry 20
    db $E0, $FA, $11, $70 ; entry 21
    db $E0, $F4, $11, $70 ; entry 22
    db $D8, $F4, $11, $70 ; entry 23
    db $D0, $FC, $11, $70 ; entry 24
    db $D0, $F4, $11, $70 ; entry 25
    db $F0, $EC, $11, $10 ; entry 26
    db $E8, $E4, $0A, $70 ; entry 27
    db $E8, $FC, $1C, $30 ; entry 28
    db $80 ; end

; E-0147 (derived: frame 18 of MetaSprites92_4024Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set00Frame18::
Data_092_4757:: ; address name
    db $D8, $0C, $1D, $50 ; entry 0
    db $F0, $F4, $1C, $10 ; entry 1
    db $D8, $E4, $14, $10 ; entry 2
    db $D8, $EC, $15, $10 ; entry 3
    db $D0, $E4, $12, $10 ; entry 4
    db $D0, $EC, $11, $10 ; entry 5
    db $F8, $EC, $16, $30 ; entry 6
    db $F8, $E4, $17, $30 ; entry 7
    db $E0, $FC, $11, $10 ; entry 8
    db $E0, $04, $11, $10 ; entry 9
    db $F0, $FC, $11, $10 ; entry 10
    db $F8, $F4, $11, $10 ; entry 11
    db $D8, $04, $11, $70 ; entry 12
    db $E0, $0C, $0A, $10 ; entry 13
    db $D0, $F4, $19, $10 ; entry 14
    db $D0, $0C, $1E, $70 ; entry 15
    db $D8, $F4, $13, $10 ; entry 16
    db $D8, $FC, $1F, $30 ; entry 17
    db $D0, $04, $1E, $10 ; entry 18
    db $F0, $0C, $16, $50 ; entry 19
    db $F0, $14, $17, $50 ; entry 20
    db $F8, $09, $19, $50 ; entry 21
    db $E8, $05, $11, $50 ; entry 22
    db $E8, $FD, $11, $10 ; entry 23
    db $E0, $F4, $19, $70 ; entry 24
    db $F8, $F9, $19, $10 ; entry 25
    db $F8, $01, $1C, $10 ; entry 26
    db $F0, $04, $11, $10 ; entry 27
    db $E8, $F5, $1E, $50 ; entry 28
    db $E8, $15, $05, $70 ; entry 29
    db $E8, $0D, $15, $70 ; entry 30
    db $E0, $15, $0B, $10 ; entry 31
    db $D8, $16, $0E, $10 ; entry 32
    db $E5, $ED, $22, $30 ; entry 33
    db $E5, $DD, $21, $10 ; entry 34
    db $E5, $E5, $20, $10 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 19 of MetaSprites92_4024Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set00Frame19::
Data_092_47E8:: ; address name
    db $D0, $D0, $03, $10 ; entry 0
    db $D8, $D0, $07, $10 ; entry 1
    db $E0, $D4, $23, $10 ; entry 2
    db $E2, $DC, $28, $10 ; entry 3
    db $E4, $E4, $23, $70 ; entry 4
    db $EC, $E9, $05, $30 ; entry 5
    db $EC, $E1, $06, $30 ; entry 6
    db $F8, $E8, $03, $30 ; entry 7
    db $F4, $EA, $04, $10 ; entry 8
    db $D0, $20, $03, $10 ; entry 9
    db $D8, $21, $04, $10 ; entry 10
    db $E0, $19, $05, $10 ; entry 11
    db $E0, $21, $06, $10 ; entry 12
    db $E8, $19, $07, $10 ; entry 13
    db $F0, $1C, $0B, $50 ; entry 14
    db $F8, $1B, $0E, $10 ; entry 15
    db $F0, $C8, $0B, $70 ; entry 16
    db $E8, $C7, $03, $10 ; entry 17
    db $F8, $CB, $0C, $10 ; entry 18
    db $E0, $C8, $0E, $10 ; entry 19
    db $D8, $C8, $0F, $10 ; entry 20
    db $D0, $C5, $0B, $30 ; entry 21
    db $F8, $38, $05, $30 ; entry 22
    db $F8, $30, $06, $30 ; entry 23
    db $F0, $32, $24, $10 ; entry 24
    db $E8, $22, $24, $70 ; entry 25
    db $EC, $2A, $28, $10 ; entry 26
    db $80 ; end

; E-0147 (derived: frame 20 of MetaSprites92_4024Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set00Frame20::
Data_092_4855:: ; address name
    db $D0, $28, $03, $30 ; entry 0
    db $D8, $28, $07, $30 ; entry 1
    db $E0, $24, $23, $30 ; entry 2
    db $E2, $1C, $28, $30 ; entry 3
    db $E4, $14, $23, $50 ; entry 4
    db $EC, $0F, $05, $10 ; entry 5
    db $EC, $17, $06, $10 ; entry 6
    db $F8, $10, $03, $10 ; entry 7
    db $F4, $0E, $04, $30 ; entry 8
    db $D0, $D8, $03, $30 ; entry 9
    db $D8, $D7, $04, $30 ; entry 10
    db $E0, $DF, $05, $30 ; entry 11
    db $E0, $D7, $06, $30 ; entry 12
    db $E8, $DF, $07, $30 ; entry 13
    db $F0, $DC, $0B, $70 ; entry 14
    db $F8, $DD, $0E, $30 ; entry 15
    db $F0, $30, $0B, $50 ; entry 16
    db $E8, $31, $03, $30 ; entry 17
    db $F8, $2D, $0C, $30 ; entry 18
    db $E0, $30, $0E, $30 ; entry 19
    db $D8, $30, $0F, $30 ; entry 20
    db $D0, $33, $0B, $10 ; entry 21
    db $F8, $C0, $05, $10 ; entry 22
    db $F8, $C8, $06, $10 ; entry 23
    db $F0, $C6, $24, $30 ; entry 24
    db $E8, $D6, $24, $50 ; entry 25
    db $EC, $CE, $28, $30 ; entry 26
    db $80 ; end

; E-0147 (derived: frame 21 of MetaSprites92_4024Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set00Frame21::
Data_092_48C2:: ; address name
    db $F8, $48, $03, $70 ; entry 0
    db $F0, $48, $07, $70 ; entry 1
    db $E8, $42, $24, $10 ; entry 2
    db $E3, $3A, $26, $10 ; entry 3
    db $E0, $2A, $23, $10 ; entry 4
    db $D8, $25, $05, $50 ; entry 5
    db $D8, $2D, $06, $50 ; entry 6
    db $D0, $24, $04, $70 ; entry 7
    db $E1, $32, $25, $10 ; entry 8
    db $F8, $B0, $03, $50 ; entry 9
    db $F0, $B0, $07, $50 ; entry 10
    db $E8, $B6, $24, $30 ; entry 11
    db $E3, $BE, $26, $30 ; entry 12
    db $E0, $CE, $23, $30 ; entry 13
    db $D8, $D3, $05, $70 ; entry 14
    db $D8, $CB, $06, $70 ; entry 15
    db $D0, $D4, $04, $50 ; entry 16
    db $E1, $C6, $25, $30 ; entry 17
    db $F0, $E9, $0B, $50 ; entry 18
    db $E8, $EA, $03, $30 ; entry 19
    db $F8, $E6, $0C, $30 ; entry 20
    db $E0, $E9, $0E, $30 ; entry 21
    db $D8, $E9, $0F, $30 ; entry 22
    db $D0, $EC, $0B, $10 ; entry 23
    db $F0, $0F, $0B, $70 ; entry 24
    db $E8, $0E, $03, $10 ; entry 25
    db $F8, $12, $0C, $10 ; entry 26
    db $E0, $0F, $0E, $10 ; entry 27
    db $D8, $0F, $0F, $10 ; entry 28
    db $D0, $0C, $0B, $30 ; entry 29
    db $80 ; end

; E-0147 (derived: frame 22 of MetaSprites92_4024Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set00Frame22::
    db $80 ; end

; E-0147 (derived: meta-sprite set 52 of MetaSprites92_4024Table: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites92_4024Set34::
Data_092_493C:: ; address name
    dw MetaSprites92_4024Set34Frame0 ; entry 0
    dw MetaSprites92_4024Set34Frame1 ; entry 1
    dw MetaSprites92_4024Set34Frame2 ; entry 2
    dw MetaSprites92_4024Set34Frame3 ; entry 3
    dw MetaSprites92_4024Set34Frame4 ; entry 4
    dw MetaSprites92_4024Set34Frame5 ; entry 5
    dw MetaSprites92_4024Set34Frame6 ; entry 6
    dw MetaSprites92_4024Set34Frame7 ; entry 7
    dw MetaSprites92_4024Set34Frame8 ; entry 8
    dw MetaSprites92_4024Set34Frame9 ; entry 9
    dw MetaSprites92_4024Set34Frame10 ; entry 10
    dw MetaSprites92_4024Set34Frame11 ; entry 11
    dw MetaSprites92_4024Set34Frame12 ; entry 12
    dw MetaSprites92_4024Set34Frame13 ; entry 13
    dw MetaSprites92_4024Set34Frame14 ; entry 14
    dw MetaSprites92_4024Set34Frame15 ; entry 15
    dw MetaSprites92_4024Set34Frame16 ; entry 16
    dw MetaSprites92_4024Set34Frame17 ; entry 17
    dw MetaSprites92_4024Set34Frame18 ; entry 18
    dw MetaSprites92_4024Set34Frame19 ; entry 19
    dw MetaSprites92_4024Set34Frame20 ; entry 20
    dw MetaSprites92_4024Set34Frame21 ; entry 21
    dw MetaSprites92_4024Set34Frame21 ; entry 22
    dw MetaSprites92_4024Set34Frame21 ; entry 23
    dw MetaSprites92_4024Set34Frame21 ; entry 24
    dw MetaSprites92_4024Set34Frame21 ; entry 25
    dw MetaSprites92_4024Set34Frame21 ; entry 26
    dw MetaSprites92_4024Set34Frame21 ; entry 27
    dw MetaSprites92_4024Set34Frame21 ; entry 28
    dw MetaSprites92_4024Set34Frame21 ; entry 29
    dw MetaSprites92_4024Set34Frame21 ; entry 30
    dw MetaSprites92_4024Set34Frame21 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites92_4024Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set34Frame0::
Data_092_497C:: ; address name
    db $F7, $F5, $05, $00 ; entry 0
    db $F8, $05, $0B, $00 ; entry 1
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites92_4024Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set34Frame1::
Data_092_4985:: ; address name
    db $F0, $05, $0A, $00 ; entry 0
    db $E8, $05, $0C, $00 ; entry 1
    db $EF, $F2, $04, $00 ; entry 2
    db $E7, $F5, $23, $00 ; entry 3
    db $F8, $05, $0C, $00 ; entry 4
    db $F7, $F5, $23, $20 ; entry 5
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites92_4024Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set34Frame2::
Data_092_499E:: ; address name
    db $E0, $05, $0C, $00 ; entry 0
    db $DF, $F1, $23, $20 ; entry 1
    db $E7, $F5, $05, $00 ; entry 2
    db $E8, $05, $0B, $00 ; entry 3
    db $F0, $05, $0C, $00 ; entry 4
    db $EF, $F2, $23, $20 ; entry 5
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites92_4024Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set34Frame3::
Data_092_49B7:: ; address name
    db $F8, $F0, $00, $00 ; entry 0
    db $F8, $F8, $01, $00 ; entry 1
    db $F8, $00, $06, $00 ; entry 2
    db $F8, $08, $07, $00 ; entry 3
    db $E0, $05, $0A, $00 ; entry 4
    db $DF, $F5, $04, $20 ; entry 5
    db $D8, $05, $0B, $00 ; entry 6
    db $D7, $F1, $05, $00 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites92_4024Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set34Frame4::
Data_092_49D8:: ; address name
    db $F8, $E8, $00, $40 ; entry 0
    db $F8, $F0, $01, $40 ; entry 1
    db $F0, $E8, $02, $40 ; entry 2
    db $F0, $F0, $03, $40 ; entry 3
    db $F0, $10, $06, $20 ; entry 4
    db $F0, $08, $07, $20 ; entry 5
    db $F8, $10, $08, $20 ; entry 6
    db $F8, $08, $09, $20 ; entry 7
    db $D0, $05, $0C, $00 ; entry 8
    db $D0, $F5, $05, $00 ; entry 9
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites92_4024Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set34Frame5::
Data_092_4A01:: ; address name
    db $F0, $F0, $00, $60 ; entry 0
    db $F0, $E8, $01, $60 ; entry 1
    db $E8, $F0, $02, $60 ; entry 2
    db $E8, $E8, $03, $60 ; entry 3
    db $E8, $08, $06, $00 ; entry 4
    db $E8, $10, $07, $00 ; entry 5
    db $F0, $08, $08, $00 ; entry 6
    db $F0, $10, $09, $00 ; entry 7
    db $F8, $EE, $04, $00 ; entry 8
    db $F8, $0A, $0A, $00 ; entry 9
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites92_4024Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set34Frame6::
Data_092_4A2A:: ; address name
    db $E8, $F8, $00, $60 ; entry 0
    db $E8, $F0, $01, $60 ; entry 1
    db $E0, $F8, $02, $60 ; entry 2
    db $E0, $F0, $03, $60 ; entry 3
    db $E0, $00, $06, $00 ; entry 4
    db $E0, $08, $07, $00 ; entry 5
    db $E8, $00, $08, $00 ; entry 6
    db $E8, $08, $09, $00 ; entry 7
    db $EC, $10, $0B, $00 ; entry 8
    db $F4, $0E, $0C, $00 ; entry 9
    db $EC, $E8, $05, $00 ; entry 10
    db $F4, $EA, $23, $20 ; entry 11
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites92_4024Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set34Frame7::
Data_092_4A5B:: ; address name
    db $E0, $F8, $06, $00 ; entry 0
    db $E0, $00, $07, $00 ; entry 1
    db $E8, $F8, $08, $00 ; entry 2
    db $E8, $00, $09, $00 ; entry 3
    db $E0, $F8, $00, $00 ; entry 4
    db $E0, $00, $01, $00 ; entry 5
    db $E8, $F8, $02, $00 ; entry 6
    db $E8, $00, $03, $00 ; entry 7
    db $E8, $08, $0A, $00 ; entry 8
    db $EA, $0E, $0C, $00 ; entry 9
    db $F0, $10, $0B, $00 ; entry 10
    db $E8, $F0, $04, $00 ; entry 11
    db $F0, $E8, $05, $00 ; entry 12
    db $EA, $EA, $23, $00 ; entry 13
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites92_4024Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set34Frame8::
Data_092_4A94:: ; address name
    db $E0, $F0, $06, $00 ; entry 0
    db $E0, $F8, $07, $00 ; entry 1
    db $E8, $F0, $08, $00 ; entry 2
    db $E8, $F8, $09, $00 ; entry 3
    db $E8, $00, $00, $40 ; entry 4
    db $E8, $08, $01, $40 ; entry 5
    db $E0, $00, $02, $40 ; entry 6
    db $E0, $08, $03, $40 ; entry 7
    db $E4, $10, $0C, $00 ; entry 8
    db $E4, $E8, $23, $00 ; entry 9
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites92_4024Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set34Frame9::
Data_092_4ABD:: ; address name
    db $E8, $F0, $06, $20 ; entry 0
    db $E8, $E8, $07, $20 ; entry 1
    db $F0, $F0, $08, $20 ; entry 2
    db $F0, $E8, $09, $20 ; entry 3
    db $E8, $08, $00, $00 ; entry 4
    db $E8, $10, $01, $00 ; entry 5
    db $F0, $08, $02, $00 ; entry 6
    db $F0, $10, $03, $00 ; entry 7
    db $E0, $00, $05, $00 ; entry 8
    db $E0, $F8, $0B, $00 ; entry 9
    db $E2, $08, $04, $00 ; entry 10
    db $E2, $F0, $0A, $00 ; entry 11
    db $80 ; end

; E-0147 (derived: frame 10 of MetaSprites92_4024Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set34Frame10::
Data_092_4AEE:: ; address name
    db $F0, $E8, $06, $00 ; entry 0
    db $F0, $F0, $07, $00 ; entry 1
    db $F8, $E8, $08, $00 ; entry 2
    db $F8, $F0, $09, $00 ; entry 3
    db $F0, $10, $00, $20 ; entry 4
    db $F0, $08, $01, $20 ; entry 5
    db $F8, $10, $02, $20 ; entry 6
    db $F8, $08, $03, $20 ; entry 7
    db $EA, $0C, $05, $20 ; entry 8
    db $E4, $0A, $23, $20 ; entry 9
    db $EA, $EC, $0B, $00 ; entry 10
    db $E4, $EE, $0C, $00 ; entry 11
    db $80 ; end

; E-0147 (derived: frame 11 of MetaSprites92_4024Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set34Frame11::
Data_092_4B1F:: ; address name
    db $F8, $08, $02, $60 ; entry 0
    db $F8, $00, $03, $60 ; entry 1
    db $F8, $F8, $06, $20 ; entry 2
    db $F8, $F0, $07, $20 ; entry 3
    db $F2, $EE, $0C, $00 ; entry 4
    db $EE, $EC, $0C, $00 ; entry 5
    db $E8, $EC, $0C, $00 ; entry 6
    db $F2, $0A, $23, $00 ; entry 7
    db $EE, $0C, $23, $20 ; entry 8
    db $E8, $0C, $23, $00 ; entry 9
    db $80 ; end

; E-0147 (derived: frame 12 of MetaSprites92_4024Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set34Frame12::
Data_092_4B48:: ; address name
    db $E8, $F0, $28, $00 ; entry 0
    db $E8, $F8, $29, $00 ; entry 1
    db $E8, $08, $28, $20 ; entry 2
    db $E8, $00, $29, $20 ; entry 3
    db $F0, $E8, $2A, $00 ; entry 4
    db $F8, $E8, $2B, $00 ; entry 5
    db $F0, $F0, $2F, $00 ; entry 6
    db $F8, $F0, $2F, $00 ; entry 7
    db $F8, $F8, $2F, $00 ; entry 8
    db $F0, $F8, $2F, $00 ; entry 9
    db $F0, $00, $2F, $00 ; entry 10
    db $F8, $00, $2F, $00 ; entry 11
    db $F8, $08, $2F, $00 ; entry 12
    db $F0, $08, $2F, $00 ; entry 13
    db $F0, $10, $2A, $20 ; entry 14
    db $F8, $10, $2B, $20 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 13 of MetaSprites92_4024Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set34Frame13::
Data_092_4B89:: ; address name
    db $F0, $F4, $25, $00 ; entry 0
    db $F0, $04, $25, $20 ; entry 1
    db $F0, $FC, $26, $00 ; entry 2
    db $F8, $F4, $27, $00 ; entry 3
    db $F8, $04, $27, $20 ; entry 4
    db $F8, $FC, $2F, $00 ; entry 5
    db $80 ; end

; E-0147 (derived: frame 14 of MetaSprites92_4024Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set34Frame14::
Data_092_4BA2:: ; address name
    db $F0, $F4, $0D, $00 ; entry 0
    db $F0, $FC, $0E, $00 ; entry 1
    db $F8, $F4, $0F, $00 ; entry 2
    db $F8, $FC, $10, $00 ; entry 3
    db $F8, $04, $17, $00 ; entry 4
    db $80 ; end

; E-0147 (derived: frame 15 of MetaSprites92_4024Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set34Frame15::
Data_092_4BB7:: ; address name
    db $F8, $F3, $15, $00 ; entry 0
    db $F8, $FB, $16, $00 ; entry 1
    db $F8, $03, $17, $00 ; entry 2
    db $E8, $F2, $11, $00 ; entry 3
    db $E8, $FA, $12, $00 ; entry 4
    db $F0, $F2, $13, $00 ; entry 5
    db $F0, $FA, $14, $00 ; entry 6
    db $80 ; end

; E-0147 (derived: frame 16 of MetaSprites92_4024Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set34Frame16::
Data_092_4BD4:: ; address name
    db $F8, $F3, $20, $00 ; entry 0
    db $F8, $FB, $21, $00 ; entry 1
    db $F8, $03, $22, $00 ; entry 2
    db $F0, $F3, $1E, $00 ; entry 3
    db $F0, $FB, $1F, $00 ; entry 4
    db $E8, $F3, $1B, $00 ; entry 5
    db $E8, $FB, $1C, $00 ; entry 6
    db $E8, $03, $1D, $00 ; entry 7
    db $E0, $F3, $18, $00 ; entry 8
    db $E0, $FB, $19, $00 ; entry 9
    db $E0, $03, $1A, $00 ; entry 10
    db $80 ; end

; E-0147 (derived: frame 17 of MetaSprites92_4024Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set34Frame17::
Data_092_4C01:: ; address name
    db $E0, $F8, $24, $00 ; entry 0
    db $E0, $00, $24, $20 ; entry 1
    db $E8, $F8, $24, $40 ; entry 2
    db $E8, $00, $24, $60 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 18 of MetaSprites92_4024Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set34Frame18::
Data_092_4C12:: ; address name
    db $DC, $F4, $25, $00 ; entry 0
    db $DC, $FC, $26, $00 ; entry 1
    db $E4, $F4, $27, $00 ; entry 2
    db $EC, $04, $25, $60 ; entry 3
    db $EC, $FC, $26, $60 ; entry 4
    db $E4, $04, $27, $60 ; entry 5
    db $E4, $FC, $2F, $00 ; entry 6
    db $DC, $04, $25, $20 ; entry 7
    db $EC, $F4, $25, $40 ; entry 8
    db $80 ; end

; E-0147 (derived: frame 19 of MetaSprites92_4024Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set34Frame19::
Data_092_4C37:: ; address name
    db $D0, $F0, $28, $00 ; entry 0
    db $D0, $F8, $29, $00 ; entry 1
    db $D0, $08, $28, $20 ; entry 2
    db $D0, $00, $29, $20 ; entry 3
    db $D8, $E8, $2A, $00 ; entry 4
    db $E0, $E8, $2B, $00 ; entry 5
    db $D8, $F0, $2F, $00 ; entry 6
    db $E0, $F0, $2F, $00 ; entry 7
    db $E0, $F8, $2F, $00 ; entry 8
    db $D8, $F8, $2F, $00 ; entry 9
    db $F0, $E8, $2A, $40 ; entry 10
    db $E8, $E8, $2B, $40 ; entry 11
    db $E8, $F0, $2F, $00 ; entry 12
    db $F0, $F0, $2F, $00 ; entry 13
    db $F0, $F8, $2F, $00 ; entry 14
    db $E8, $F8, $2F, $00 ; entry 15
    db $D8, $00, $2F, $00 ; entry 16
    db $E0, $00, $2F, $00 ; entry 17
    db $E0, $08, $2F, $00 ; entry 18
    db $D8, $08, $2F, $00 ; entry 19
    db $E8, $00, $2F, $00 ; entry 20
    db $F0, $00, $2F, $00 ; entry 21
    db $F0, $08, $2F, $00 ; entry 22
    db $E8, $08, $2F, $00 ; entry 23
    db $F8, $F0, $28, $40 ; entry 24
    db $F8, $F8, $29, $40 ; entry 25
    db $F8, $08, $28, $60 ; entry 26
    db $F8, $00, $29, $60 ; entry 27
    db $D8, $10, $2A, $20 ; entry 28
    db $E0, $10, $2B, $20 ; entry 29
    db $F0, $10, $2A, $60 ; entry 30
    db $E8, $10, $2B, $60 ; entry 31
    db $80 ; end

; E-0147 (derived: frame 20 of MetaSprites92_4024Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set34Frame20::
Data_092_4CB8:: ; address name
    db $D8, $F0, $2C, $00 ; entry 0
    db $D8, $F8, $2D, $00 ; entry 1
    db $D8, $08, $2C, $20 ; entry 2
    db $D8, $00, $2D, $20 ; entry 3
    db $E0, $F0, $2E, $00 ; entry 4
    db $E0, $F8, $2F, $00 ; entry 5
    db $E0, $00, $2F, $20 ; entry 6
    db $E0, $08, $2E, $20 ; entry 7
    db $F0, $F0, $2C, $40 ; entry 8
    db $F0, $F8, $2D, $40 ; entry 9
    db $E8, $F0, $2E, $40 ; entry 10
    db $E8, $F8, $2F, $40 ; entry 11
    db $F0, $08, $2C, $60 ; entry 12
    db $F0, $00, $2D, $60 ; entry 13
    db $E8, $08, $2E, $60 ; entry 14
    db $E8, $00, $2F, $60 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 21 of MetaSprites92_4024Set34; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set34Frame21::
    db $80 ; end

; E-0147 (derived: meta-sprite set 53 of MetaSprites92_4024Table: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites92_4024Set35::
Data_092_4CFA:: ; address name
    dw MetaSprites92_4024Set35Frame0 ; entry 0
    dw MetaSprites92_4024Set35Frame1 ; entry 1
    dw MetaSprites92_4024Set35Frame2 ; entry 2
    dw MetaSprites92_4024Set35Frame3 ; entry 3
    dw MetaSprites92_4024Set35Frame4 ; entry 4
    dw MetaSprites92_4024Set35Frame5 ; entry 5
    dw MetaSprites92_4024Set35Frame6 ; entry 6
    dw MetaSprites92_4024Set35Frame7 ; entry 7
    dw MetaSprites92_4024Set35Frame8 ; entry 8
    dw MetaSprites92_4024Set35Frame9 ; entry 9
    dw MetaSprites92_4024Set35Frame10 ; entry 10
    dw MetaSprites92_4024Set35Frame11 ; entry 11
    dw MetaSprites92_4024Set35Frame12 ; entry 12
    dw MetaSprites92_4024Set35Frame13 ; entry 13
    dw MetaSprites92_4024Set35Frame14 ; entry 14
    dw MetaSprites92_4024Set35Frame15 ; entry 15
    dw MetaSprites92_4024Set35Frame16 ; entry 16
    dw MetaSprites92_4024Set35Frame17 ; entry 17
    dw MetaSprites92_4024Set35Frame18 ; entry 18
    dw MetaSprites92_4024Set35Frame19 ; entry 19
    dw MetaSprites92_4024Set35Frame20 ; entry 20
    dw MetaSprites92_4024Set35Frame21 ; entry 21
    dw MetaSprites92_4024Set35Frame22 ; entry 22
    dw MetaSprites92_4024Set35Frame23 ; entry 23
    dw MetaSprites92_4024Set35Frame24 ; entry 24
    dw MetaSprites92_4024Set35Frame24 ; entry 25
    dw MetaSprites92_4024Set35Frame24 ; entry 26
    dw MetaSprites92_4024Set35Frame24 ; entry 27
    dw MetaSprites92_4024Set35Frame24 ; entry 28
    dw MetaSprites92_4024Set35Frame24 ; entry 29
    dw MetaSprites92_4024Set35Frame24 ; entry 30
    dw MetaSprites92_4024Set35Frame24 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites92_4024Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set35Frame0::
Data_092_4D3A:: ; address name
    db $F8, $B8, $21, $00 ; entry 0
    db $F8, $C0, $22, $00 ; entry 1
    db $F8, $C8, $23, $00 ; entry 2
    db $F8, $D8, $21, $20 ; entry 3
    db $F8, $D0, $22, $20 ; entry 4
    db $F8, $40, $21, $20 ; entry 5
    db $F8, $38, $22, $20 ; entry 6
    db $F8, $30, $23, $20 ; entry 7
    db $F8, $20, $21, $00 ; entry 8
    db $F8, $28, $22, $00 ; entry 9
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites92_4024Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set35Frame1::
Data_092_4D63:: ; address name
    db $F8, $BC, $14, $00 ; entry 0
    db $F8, $C4, $15, $00 ; entry 1
    db $F8, $D4, $14, $20 ; entry 2
    db $F8, $CC, $15, $20 ; entry 3
    db $F8, $24, $14, $00 ; entry 4
    db $F8, $2C, $15, $00 ; entry 5
    db $F8, $3C, $14, $20 ; entry 6
    db $F8, $34, $15, $20 ; entry 7
    db $F0, $BC, $10, $00 ; entry 8
    db $F0, $C4, $11, $00 ; entry 9
    db $F0, $D4, $10, $20 ; entry 10
    db $F0, $CC, $11, $20 ; entry 11
    db $F0, $24, $10, $00 ; entry 12
    db $F0, $2C, $11, $00 ; entry 13
    db $F0, $3C, $10, $20 ; entry 14
    db $F0, $34, $11, $20 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites92_4024Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set35Frame2::
Data_092_4DA4:: ; address name
    db $F0, $BC, $14, $00 ; entry 0
    db $F0, $C4, $15, $00 ; entry 1
    db $F0, $D4, $14, $20 ; entry 2
    db $F0, $CC, $15, $20 ; entry 3
    db $E8, $BC, $10, $00 ; entry 4
    db $E8, $C4, $11, $00 ; entry 5
    db $E8, $D4, $10, $20 ; entry 6
    db $E8, $CC, $11, $20 ; entry 7
    db $F8, $CC, $19, $20 ; entry 8
    db $F8, $C4, $19, $20 ; entry 9
    db $F0, $3C, $14, $20 ; entry 10
    db $F0, $34, $15, $20 ; entry 11
    db $F0, $24, $14, $00 ; entry 12
    db $F0, $2C, $15, $00 ; entry 13
    db $E8, $3C, $10, $20 ; entry 14
    db $E8, $34, $11, $20 ; entry 15
    db $E8, $24, $10, $00 ; entry 16
    db $E8, $2C, $11, $00 ; entry 17
    db $F8, $D4, $1A, $20 ; entry 18
    db $F8, $BC, $1A, $00 ; entry 19
    db $F8, $2C, $19, $00 ; entry 20
    db $F8, $34, $19, $00 ; entry 21
    db $F8, $24, $1A, $00 ; entry 22
    db $F8, $3C, $1A, $20 ; entry 23
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites92_4024Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set35Frame3::
Data_092_4E05:: ; address name
    db $F8, $C8, $19, $00 ; entry 0
    db $F8, $C0, $1C, $00 ; entry 1
    db $F8, $D0, $1C, $20 ; entry 2
    db $F0, $B8, $24, $00 ; entry 3
    db $F0, $C0, $25, $00 ; entry 4
    db $F0, $C8, $27, $00 ; entry 5
    db $F0, $D8, $24, $20 ; entry 6
    db $F0, $D0, $25, $20 ; entry 7
    db $E8, $BD, $21, $00 ; entry 8
    db $E8, $C5, $22, $00 ; entry 9
    db $E8, $D3, $21, $20 ; entry 10
    db $E8, $CB, $22, $20 ; entry 11
    db $F8, $30, $19, $20 ; entry 12
    db $F8, $38, $1C, $20 ; entry 13
    db $F8, $28, $1C, $00 ; entry 14
    db $F0, $40, $24, $20 ; entry 15
    db $F0, $38, $25, $20 ; entry 16
    db $F0, $30, $27, $20 ; entry 17
    db $F0, $20, $24, $00 ; entry 18
    db $F0, $28, $25, $00 ; entry 19
    db $E8, $3B, $21, $20 ; entry 20
    db $E8, $33, $22, $20 ; entry 21
    db $E8, $25, $21, $00 ; entry 22
    db $E8, $2D, $22, $00 ; entry 23
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites92_4024Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set35Frame4::
Data_092_4E66:: ; address name
    db $F8, $B8, $24, $00 ; entry 0
    db $F8, $C0, $25, $00 ; entry 1
    db $F8, $C8, $27, $00 ; entry 2
    db $F8, $D8, $24, $20 ; entry 3
    db $F8, $D0, $25, $20 ; entry 4
    db $F0, $BD, $21, $00 ; entry 5
    db $F0, $C5, $22, $00 ; entry 6
    db $F0, $D3, $21, $20 ; entry 7
    db $F0, $CB, $22, $20 ; entry 8
    db $F8, $40, $24, $20 ; entry 9
    db $F8, $38, $25, $20 ; entry 10
    db $F8, $30, $27, $20 ; entry 11
    db $F8, $20, $24, $00 ; entry 12
    db $F8, $28, $25, $00 ; entry 13
    db $F0, $3B, $21, $20 ; entry 14
    db $F0, $33, $22, $20 ; entry 15
    db $F0, $25, $21, $00 ; entry 16
    db $F0, $2D, $22, $00 ; entry 17
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites92_4024Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set35Frame5::
Data_092_4EAF:: ; address name
    db $F8, $D0, $21, $00 ; entry 0
    db $F8, $D8, $22, $00 ; entry 1
    db $F8, $E0, $23, $00 ; entry 2
    db $F8, $F0, $21, $20 ; entry 3
    db $F8, $E8, $22, $20 ; entry 4
    db $F8, $28, $21, $20 ; entry 5
    db $F8, $20, $22, $20 ; entry 6
    db $F8, $18, $23, $20 ; entry 7
    db $F8, $08, $21, $00 ; entry 8
    db $F8, $10, $22, $00 ; entry 9
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites92_4024Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set35Frame6::
Data_092_4ED8:: ; address name
    db $F8, $D4, $14, $00 ; entry 0
    db $F8, $DC, $15, $00 ; entry 1
    db $F8, $EC, $14, $20 ; entry 2
    db $F8, $E4, $15, $20 ; entry 3
    db $F8, $0C, $14, $00 ; entry 4
    db $F8, $14, $15, $00 ; entry 5
    db $F8, $24, $14, $20 ; entry 6
    db $F8, $1C, $15, $20 ; entry 7
    db $F0, $D4, $10, $00 ; entry 8
    db $F0, $DC, $11, $00 ; entry 9
    db $F0, $EC, $10, $20 ; entry 10
    db $F0, $E4, $11, $20 ; entry 11
    db $F0, $0C, $10, $00 ; entry 12
    db $F0, $14, $11, $00 ; entry 13
    db $F0, $24, $10, $20 ; entry 14
    db $F0, $1C, $11, $20 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites92_4024Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set35Frame7::
Data_092_4F19:: ; address name
    db $E8, $D4, $14, $00 ; entry 0
    db $E8, $DC, $15, $00 ; entry 1
    db $E8, $EC, $14, $20 ; entry 2
    db $E8, $E4, $15, $20 ; entry 3
    db $E0, $D4, $10, $00 ; entry 4
    db $E0, $DC, $11, $00 ; entry 5
    db $E0, $EC, $10, $20 ; entry 6
    db $E0, $E4, $11, $20 ; entry 7
    db $F8, $D4, $1A, $00 ; entry 8
    db $F8, $DC, $1C, $00 ; entry 9
    db $F0, $DC, $19, $00 ; entry 10
    db $F8, $E4, $1C, $20 ; entry 11
    db $F0, $E4, $19, $00 ; entry 12
    db $F8, $EC, $1A, $20 ; entry 13
    db $E8, $24, $14, $20 ; entry 14
    db $E8, $1C, $15, $20 ; entry 15
    db $E8, $0C, $14, $00 ; entry 16
    db $E8, $14, $15, $00 ; entry 17
    db $E0, $24, $10, $20 ; entry 18
    db $E0, $1C, $11, $20 ; entry 19
    db $E0, $0C, $10, $00 ; entry 20
    db $E0, $14, $11, $00 ; entry 21
    db $F8, $24, $1A, $20 ; entry 22
    db $F8, $1C, $1C, $20 ; entry 23
    db $F0, $1C, $19, $20 ; entry 24
    db $F8, $14, $1C, $00 ; entry 25
    db $F0, $14, $19, $20 ; entry 26
    db $F8, $0C, $1A, $00 ; entry 27
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites92_4024Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set35Frame8::
Data_092_4F8A:: ; address name
    db $F8, $D0, $1A, $00 ; entry 0
    db $F8, $F0, $1A, $20 ; entry 1
    db $F0, $E0, $19, $00 ; entry 2
    db $F8, $D8, $1F, $00 ; entry 3
    db $F8, $E8, $1F, $20 ; entry 4
    db $F0, $D8, $1C, $00 ; entry 5
    db $F0, $E8, $1C, $20 ; entry 6
    db $F8, $E0, $1C, $00 ; entry 7
    db $E8, $D0, $24, $00 ; entry 8
    db $E8, $D8, $25, $00 ; entry 9
    db $E8, $E0, $27, $00 ; entry 10
    db $E8, $F0, $24, $20 ; entry 11
    db $E8, $E8, $25, $20 ; entry 12
    db $E0, $D5, $21, $00 ; entry 13
    db $E0, $DD, $22, $00 ; entry 14
    db $E0, $EB, $21, $20 ; entry 15
    db $E0, $E3, $22, $20 ; entry 16
    db $F8, $28, $1A, $20 ; entry 17
    db $F8, $08, $1A, $00 ; entry 18
    db $F0, $18, $19, $20 ; entry 19
    db $F8, $20, $1F, $20 ; entry 20
    db $F8, $10, $1F, $00 ; entry 21
    db $F0, $20, $1C, $20 ; entry 22
    db $F0, $10, $1C, $00 ; entry 23
    db $F8, $18, $1C, $20 ; entry 24
    db $E8, $28, $24, $20 ; entry 25
    db $E8, $20, $25, $20 ; entry 26
    db $E8, $18, $27, $20 ; entry 27
    db $E8, $08, $24, $00 ; entry 28
    db $E8, $10, $25, $00 ; entry 29
    db $E0, $23, $21, $20 ; entry 30
    db $E0, $1B, $22, $20 ; entry 31
    db $E0, $0D, $21, $00 ; entry 32
    db $E0, $15, $22, $00 ; entry 33
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites92_4024Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set35Frame9::
Data_092_5013:: ; address name
    db $F8, $E0, $19, $00 ; entry 0
    db $F8, $D8, $1C, $00 ; entry 1
    db $F8, $E8, $1C, $20 ; entry 2
    db $F0, $D0, $24, $00 ; entry 3
    db $F0, $D8, $25, $00 ; entry 4
    db $F0, $E0, $27, $00 ; entry 5
    db $F0, $F0, $24, $20 ; entry 6
    db $F0, $E8, $25, $20 ; entry 7
    db $E8, $D5, $21, $00 ; entry 8
    db $E8, $DD, $22, $00 ; entry 9
    db $E8, $EB, $21, $20 ; entry 10
    db $E8, $E3, $22, $20 ; entry 11
    db $F8, $18, $19, $20 ; entry 12
    db $F8, $20, $1C, $20 ; entry 13
    db $F8, $10, $1C, $00 ; entry 14
    db $F0, $28, $24, $20 ; entry 15
    db $F0, $20, $25, $20 ; entry 16
    db $F0, $18, $27, $20 ; entry 17
    db $F0, $08, $24, $00 ; entry 18
    db $F0, $10, $25, $00 ; entry 19
    db $E8, $23, $21, $20 ; entry 20
    db $E8, $1B, $22, $20 ; entry 21
    db $E8, $0D, $21, $00 ; entry 22
    db $E8, $15, $22, $00 ; entry 23
    db $F8, $D0, $1A, $00 ; entry 24
    db $F8, $F0, $1A, $20 ; entry 25
    db $F8, $08, $1A, $00 ; entry 26
    db $F8, $28, $1A, $20 ; entry 27
    db $80 ; end

; E-0147 (derived: frame 10 of MetaSprites92_4024Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set35Frame10::
Data_092_5084:: ; address name
    db $F0, $E0, $10, $00 ; entry 0
    db $F0, $E8, $11, $00 ; entry 1
    db $F0, $F0, $12, $00 ; entry 2
    db $F0, $F8, $13, $00 ; entry 3
    db $F0, $18, $10, $20 ; entry 4
    db $F0, $10, $11, $20 ; entry 5
    db $F0, $08, $12, $20 ; entry 6
    db $F0, $00, $13, $20 ; entry 7
    db $F8, $E0, $14, $00 ; entry 8
    db $F8, $E8, $15, $00 ; entry 9
    db $F8, $F0, $16, $00 ; entry 10
    db $F8, $F8, $17, $00 ; entry 11
    db $F8, $18, $14, $20 ; entry 12
    db $F8, $10, $15, $20 ; entry 13
    db $F8, $08, $16, $20 ; entry 14
    db $F8, $00, $17, $20 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 11 of MetaSprites92_4024Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set35Frame11::
Data_092_50C5:: ; address name
    db $F0, $E8, $18, $00 ; entry 0
    db $F0, $F8, $18, $00 ; entry 1
    db $F8, $E0, $1A, $00 ; entry 2
    db $F8, $E8, $1B, $00 ; entry 3
    db $F8, $F0, $1C, $00 ; entry 4
    db $F0, $F0, $19, $00 ; entry 5
    db $F8, $F8, $19, $00 ; entry 6
    db $F0, $10, $18, $20 ; entry 7
    db $F0, $00, $18, $20 ; entry 8
    db $F8, $10, $1B, $20 ; entry 9
    db $F8, $08, $1C, $20 ; entry 10
    db $F0, $08, $19, $20 ; entry 11
    db $F8, $00, $19, $20 ; entry 12
    db $F8, $18, $1A, $20 ; entry 13
    db $E0, $E0, $10, $00 ; entry 14
    db $E0, $E8, $11, $00 ; entry 15
    db $E0, $F0, $12, $00 ; entry 16
    db $E0, $F8, $13, $00 ; entry 17
    db $E0, $18, $10, $20 ; entry 18
    db $E0, $10, $11, $20 ; entry 19
    db $E0, $08, $12, $20 ; entry 20
    db $E0, $00, $13, $20 ; entry 21
    db $E8, $E0, $14, $00 ; entry 22
    db $E8, $E8, $15, $00 ; entry 23
    db $E8, $F0, $16, $00 ; entry 24
    db $E8, $F8, $17, $00 ; entry 25
    db $E8, $18, $14, $20 ; entry 26
    db $E8, $10, $15, $20 ; entry 27
    db $E8, $08, $16, $20 ; entry 28
    db $E8, $00, $17, $20 ; entry 29
    db $80 ; end

; E-0147 (derived: frame 12 of MetaSprites92_4024Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set35Frame12::
Data_092_513E:: ; address name
    db $E8, $E8, $18, $00 ; entry 0
    db $E8, $F8, $18, $00 ; entry 1
    db $F0, $E0, $1A, $00 ; entry 2
    db $F0, $E8, $1B, $00 ; entry 3
    db $F0, $F0, $1C, $00 ; entry 4
    db $E8, $F0, $19, $00 ; entry 5
    db $F0, $F8, $19, $00 ; entry 6
    db $E8, $10, $18, $20 ; entry 7
    db $E8, $00, $18, $20 ; entry 8
    db $F0, $10, $1B, $20 ; entry 9
    db $F0, $08, $1C, $20 ; entry 10
    db $E8, $08, $19, $20 ; entry 11
    db $F0, $00, $19, $20 ; entry 12
    db $F0, $18, $1A, $20 ; entry 13
    db $F8, $D8, $20, $00 ; entry 14
    db $F8, $20, $20, $20 ; entry 15
    db $F8, $E0, $1D, $00 ; entry 16
    db $F8, $E8, $1E, $00 ; entry 17
    db $F8, $F0, $1F, $00 ; entry 18
    db $F8, $18, $1D, $20 ; entry 19
    db $F8, $10, $1E, $20 ; entry 20
    db $F8, $08, $1F, $20 ; entry 21
    db $F8, $F8, $1C, $00 ; entry 22
    db $F8, $00, $1C, $20 ; entry 23
    db $D8, $E0, $10, $00 ; entry 24
    db $D8, $E8, $11, $00 ; entry 25
    db $D8, $F0, $12, $00 ; entry 26
    db $D8, $F8, $13, $00 ; entry 27
    db $D8, $18, $10, $20 ; entry 28
    db $D8, $10, $11, $20 ; entry 29
    db $D8, $08, $12, $20 ; entry 30
    db $D8, $00, $13, $20 ; entry 31
    db $E0, $E0, $14, $00 ; entry 32
    db $E0, $E8, $15, $00 ; entry 33
    db $E0, $F0, $16, $00 ; entry 34
    db $E0, $F8, $17, $00 ; entry 35
    db $E0, $18, $14, $20 ; entry 36
    db $E0, $10, $15, $20 ; entry 37
    db $E0, $08, $16, $20 ; entry 38
    db $E0, $00, $17, $20 ; entry 39
    db $80 ; end

; E-0147 (derived: frame 13 of MetaSprites92_4024Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set35Frame13::
Data_092_51DF:: ; address name
    db $D8, $E8, $21, $00 ; entry 0
    db $D8, $F0, $22, $00 ; entry 1
    db $D8, $F8, $23, $00 ; entry 2
    db $E0, $E0, $24, $00 ; entry 3
    db $E0, $E8, $25, $00 ; entry 4
    db $E0, $F0, $26, $00 ; entry 5
    db $E0, $F8, $27, $00 ; entry 6
    db $D8, $10, $21, $20 ; entry 7
    db $D8, $08, $22, $20 ; entry 8
    db $D8, $00, $23, $20 ; entry 9
    db $E0, $10, $25, $20 ; entry 10
    db $E0, $08, $26, $20 ; entry 11
    db $E0, $00, $27, $20 ; entry 12
    db $E0, $18, $24, $20 ; entry 13
    db $E8, $E8, $18, $00 ; entry 14
    db $F8, $E0, $1A, $00 ; entry 15
    db $E8, $10, $18, $20 ; entry 16
    db $F8, $10, $1B, $20 ; entry 17
    db $F8, $08, $1C, $20 ; entry 18
    db $F8, $00, $19, $20 ; entry 19
    db $F8, $18, $1A, $20 ; entry 20
    db $F0, $10, $18, $20 ; entry 21
    db $F0, $00, $18, $20 ; entry 22
    db $F0, $08, $19, $20 ; entry 23
    db $F8, $E8, $1B, $00 ; entry 24
    db $F8, $F0, $1C, $00 ; entry 25
    db $F8, $F8, $19, $00 ; entry 26
    db $F0, $E8, $18, $00 ; entry 27
    db $F0, $F8, $18, $00 ; entry 28
    db $F0, $F0, $19, $00 ; entry 29
    db $E8, $F0, $18, $00 ; entry 30
    db $E8, $F8, $18, $20 ; entry 31
    db $E8, $00, $18, $00 ; entry 32
    db $E8, $08, $18, $20 ; entry 33
    db $80 ; end

; E-0147 (derived: frame 14 of MetaSprites92_4024Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set35Frame14::
Data_092_5268:: ; address name
    db $D8, $FC, $00, $00 ; entry 0
    db $D0, $FC, $01, $00 ; entry 1
    db $E0, $F0, $26, $00 ; entry 2
    db $E0, $08, $26, $20 ; entry 3
    db $F8, $E0, $1A, $00 ; entry 4
    db $F8, $10, $1B, $20 ; entry 5
    db $F8, $18, $1A, $20 ; entry 6
    db $F0, $10, $18, $20 ; entry 7
    db $F0, $08, $19, $00 ; entry 8
    db $F8, $E8, $1B, $00 ; entry 9
    db $F0, $E8, $18, $00 ; entry 10
    db $F0, $F0, $19, $20 ; entry 11
    db $D0, $F0, $28, $00 ; entry 12
    db $D8, $F0, $29, $00 ; entry 13
    db $D0, $08, $28, $20 ; entry 14
    db $D8, $08, $29, $20 ; entry 15
    db $F8, $00, $19, $20 ; entry 16
    db $F0, $00, $18, $20 ; entry 17
    db $F8, $F8, $19, $00 ; entry 18
    db $F0, $F8, $18, $00 ; entry 19
    db $E0, $00, $1A, $00 ; entry 20
    db $E8, $00, $1D, $00 ; entry 21
    db $E8, $08, $1E, $00 ; entry 22
    db $E0, $F8, $1A, $20 ; entry 23
    db $E8, $F8, $1D, $20 ; entry 24
    db $E8, $F0, $1E, $20 ; entry 25
    db $F8, $08, $1F, $00 ; entry 26
    db $F8, $F0, $1F, $20 ; entry 27
    db $D8, $E0, $10, $00 ; entry 28
    db $D8, $E8, $11, $00 ; entry 29
    db $E0, $E0, $14, $00 ; entry 30
    db $E0, $E8, $15, $00 ; entry 31
    db $D8, $18, $10, $20 ; entry 32
    db $D8, $10, $11, $20 ; entry 33
    db $E0, $18, $14, $20 ; entry 34
    db $E0, $10, $15, $20 ; entry 35
    db $E8, $E8, $27, $00 ; entry 36
    db $E8, $10, $27, $20 ; entry 37
    db $80 ; end

; E-0147 (derived: frame 15 of MetaSprites92_4024Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set35Frame15::
Data_092_5301:: ; address name
    db $E8, $FC, $00, $00 ; entry 0
    db $E0, $FC, $01, $00 ; entry 1
    db $D0, $FC, $03, $00 ; entry 2
    db $D8, $FC, $02, $00 ; entry 3
    db $F8, $E0, $1A, $00 ; entry 4
    db $F8, $18, $1A, $20 ; entry 5
    db $F0, $08, $19, $00 ; entry 6
    db $F0, $F0, $19, $20 ; entry 7
    db $E8, $F0, $18, $00 ; entry 8
    db $E8, $08, $18, $20 ; entry 9
    db $F0, $00, $1A, $00 ; entry 10
    db $F8, $00, $1D, $00 ; entry 11
    db $F0, $F8, $1A, $20 ; entry 12
    db $F8, $F8, $1D, $20 ; entry 13
    db $F8, $08, $1E, $00 ; entry 14
    db $D0, $E8, $21, $00 ; entry 15
    db $D8, $E0, $24, $00 ; entry 16
    db $D8, $E8, $25, $00 ; entry 17
    db $D8, $F0, $26, $00 ; entry 18
    db $D0, $10, $21, $20 ; entry 19
    db $D8, $10, $25, $20 ; entry 20
    db $D8, $08, $26, $20 ; entry 21
    db $D8, $18, $24, $20 ; entry 22
    db $D0, $F0, $29, $00 ; entry 23
    db $D0, $08, $29, $20 ; entry 24
    db $E0, $F0, $1C, $20 ; entry 25
    db $E0, $08, $1C, $00 ; entry 26
    db $F0, $10, $1C, $00 ; entry 27
    db $E8, $10, $19, $00 ; entry 28
    db $E0, $10, $1B, $00 ; entry 29
    db $F0, $E8, $1C, $20 ; entry 30
    db $E8, $E8, $19, $20 ; entry 31
    db $E0, $E8, $1B, $20 ; entry 32
    db $F8, $F0, $1E, $20 ; entry 33
    db $F8, $E8, $1E, $20 ; entry 34
    db $F8, $10, $1E, $00 ; entry 35
    db $E0, $F8, $2E, $00 ; entry 36
    db $E0, $00, $2F, $00 ; entry 37
    db $E8, $00, $2E, $60 ; entry 38
    db $E8, $F8, $2F, $60 ; entry 39
    db $80 ; end

; E-0147 (derived: frame 16 of MetaSprites92_4024Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set35Frame16::
Data_092_53A2:: ; address name
    db $F0, $FC, $01, $00 ; entry 0
    db $E0, $FC, $03, $00 ; entry 1
    db $D8, $FC, $04, $00 ; entry 2
    db $D0, $FC, $05, $00 ; entry 3
    db $D8, $10, $21, $20 ; entry 4
    db $E0, $10, $25, $20 ; entry 5
    db $E0, $08, $26, $20 ; entry 6
    db $E0, $18, $24, $20 ; entry 7
    db $F8, $18, $1A, $20 ; entry 8
    db $D8, $E8, $21, $00 ; entry 9
    db $E0, $E0, $24, $00 ; entry 10
    db $E0, $E8, $25, $00 ; entry 11
    db $E0, $F0, $26, $00 ; entry 12
    db $F8, $E0, $1A, $00 ; entry 13
    db $D0, $F0, $28, $00 ; entry 14
    db $D8, $F0, $29, $00 ; entry 15
    db $D0, $08, $28, $20 ; entry 16
    db $D8, $08, $29, $20 ; entry 17
    db $F8, $08, $1B, $00 ; entry 18
    db $F8, $F0, $1B, $20 ; entry 19
    db $F0, $08, $1E, $00 ; entry 20
    db $E8, $08, $1B, $00 ; entry 21
    db $E8, $10, $1C, $00 ; entry 22
    db $F0, $F0, $1E, $20 ; entry 23
    db $E8, $F0, $1B, $20 ; entry 24
    db $E8, $E8, $1C, $20 ; entry 25
    db $E8, $FC, $02, $00 ; entry 26
    db $F8, $F8, $2C, $00 ; entry 27
    db $F8, $FF, $2C, $20 ; entry 28
    db $F8, $10, $1F, $00 ; entry 29
    db $F8, $E8, $1F, $20 ; entry 30
    db $F0, $10, $19, $00 ; entry 31
    db $F0, $E8, $19, $20 ; entry 32
    db $E0, $00, $2E, $20 ; entry 33
    db $E0, $F8, $2F, $20 ; entry 34
    db $E8, $F8, $2E, $40 ; entry 35
    db $E8, $00, $2F, $40 ; entry 36
    db $80 ; end

; E-0147 (derived: frame 17 of MetaSprites92_4024Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set35Frame17::
Data_092_5437:: ; address name
    db $D0, $FC, $05, $00 ; entry 0
    db $D8, $FC, $05, $00 ; entry 1
    db $F0, $20, $10, $20 ; entry 2
    db $F0, $18, $11, $20 ; entry 3
    db $F0, $10, $12, $20 ; entry 4
    db $F0, $08, $13, $20 ; entry 5
    db $F8, $08, $27, $20 ; entry 6
    db $F8, $20, $14, $20 ; entry 7
    db $F8, $18, $1C, $20 ; entry 8
    db $F8, $10, $1C, $20 ; entry 9
    db $F0, $D8, $10, $00 ; entry 10
    db $F0, $E0, $11, $00 ; entry 11
    db $F0, $E8, $12, $00 ; entry 12
    db $F0, $F0, $13, $00 ; entry 13
    db $F8, $F0, $27, $00 ; entry 14
    db $F8, $D8, $14, $00 ; entry 15
    db $F8, $E0, $1C, $00 ; entry 16
    db $F8, $E8, $1C, $00 ; entry 17
    db $F8, $F8, $29, $00 ; entry 18
    db $F8, $00, $29, $20 ; entry 19
    db $F0, $F8, $28, $00 ; entry 20
    db $F0, $00, $28, $20 ; entry 21
    db $E8, $FC, $03, $00 ; entry 22
    db $E0, $FC, $04, $00 ; entry 23
    db $80 ; end

; E-0147 (derived: frame 18 of MetaSprites92_4024Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set35Frame18::
Data_092_5498:: ; address name
    db $F8, $FB, $0C, $20 ; entry 0
    db $F0, $FB, $0C, $20 ; entry 1
    db $E8, $FB, $0C, $20 ; entry 2
    db $E0, $FB, $0C, $20 ; entry 3
    db $D8, $FB, $0C, $20 ; entry 4
    db $D0, $FB, $0C, $20 ; entry 5
    db $F8, $03, $1E, $20 ; entry 6
    db $E8, $03, $21, $00 ; entry 7
    db $E8, $0B, $22, $00 ; entry 8
    db $F0, $03, $0E, $20 ; entry 9
    db $E8, $13, $10, $20 ; entry 10
    db $F0, $13, $09, $40 ; entry 11
    db $F0, $0B, $12, $60 ; entry 12
    db $F8, $0A, $1D, $20 ; entry 13
    db $F8, $12, $20, $20 ; entry 14
    db $F8, $F4, $1E, $00 ; entry 15
    db $E8, $F4, $21, $20 ; entry 16
    db $E8, $EC, $22, $20 ; entry 17
    db $F0, $F4, $0E, $00 ; entry 18
    db $E8, $E4, $10, $00 ; entry 19
    db $F0, $E4, $09, $60 ; entry 20
    db $F0, $EC, $12, $40 ; entry 21
    db $F8, $ED, $1D, $00 ; entry 22
    db $F8, $E5, $20, $00 ; entry 23
    db $80 ; end

; E-0147 (derived: frame 19 of MetaSprites92_4024Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set35Frame19::
Data_092_54F9:: ; address name
    db $F8, $FC, $0C, $00 ; entry 0
    db $F0, $FC, $0C, $00 ; entry 1
    db $E8, $FC, $0C, $00 ; entry 2
    db $E0, $FC, $0C, $00 ; entry 3
    db $D8, $FC, $0C, $00 ; entry 4
    db $D0, $FC, $0C, $00 ; entry 5
    db $E0, $DC, $06, $00 ; entry 6
    db $E0, $E4, $07, $00 ; entry 7
    db $E0, $EC, $08, $00 ; entry 8
    db $E0, $F4, $09, $00 ; entry 9
    db $E8, $E4, $0A, $00 ; entry 10
    db $E8, $EC, $0B, $00 ; entry 11
    db $E8, $F4, $0E, $00 ; entry 12
    db $F0, $E4, $1A, $00 ; entry 13
    db $F0, $EC, $1B, $00 ; entry 14
    db $F0, $F4, $1C, $00 ; entry 15
    db $F8, $E4, $1D, $00 ; entry 16
    db $F8, $EC, $1E, $00 ; entry 17
    db $F8, $F4, $1F, $00 ; entry 18
    db $F8, $DC, $20, $00 ; entry 19
    db $E0, $1B, $06, $20 ; entry 20
    db $E0, $13, $07, $20 ; entry 21
    db $E0, $0B, $08, $20 ; entry 22
    db $E0, $03, $09, $20 ; entry 23
    db $E8, $13, $0A, $20 ; entry 24
    db $E8, $0B, $0B, $20 ; entry 25
    db $E8, $03, $0E, $20 ; entry 26
    db $F0, $13, $1A, $20 ; entry 27
    db $F0, $0B, $1B, $20 ; entry 28
    db $F0, $03, $1C, $20 ; entry 29
    db $F8, $13, $1D, $20 ; entry 30
    db $F8, $0B, $1E, $20 ; entry 31
    db $F8, $03, $1F, $20 ; entry 32
    db $F8, $1B, $20, $20 ; entry 33
    db $80 ; end

; E-0147 (derived: frame 20 of MetaSprites92_4024Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set35Frame20::
Data_092_5582:: ; address name
    db $F8, $FC, $0C, $00 ; entry 0
    db $F0, $FC, $0C, $00 ; entry 1
    db $E8, $FC, $0C, $00 ; entry 2
    db $E0, $FC, $0C, $00 ; entry 3
    db $D8, $FC, $0C, $00 ; entry 4
    db $D0, $FC, $0C, $00 ; entry 5
    db $F8, $E4, $1E, $00 ; entry 6
    db $F8, $DC, $1A, $00 ; entry 7
    db $F8, $EC, $1F, $00 ; entry 8
    db $F0, $E4, $1E, $40 ; entry 9
    db $F0, $DC, $0F, $00 ; entry 10
    db $F8, $F4, $1A, $20 ; entry 11
    db $E8, $D4, $09, $20 ; entry 12
    db $E8, $EC, $09, $00 ; entry 13
    db $E8, $E4, $08, $00 ; entry 14
    db $E8, $DC, $07, $00 ; entry 15
    db $F8, $13, $1E, $20 ; entry 16
    db $F8, $1B, $1A, $20 ; entry 17
    db $F8, $0B, $1F, $20 ; entry 18
    db $F0, $13, $1E, $60 ; entry 19
    db $F0, $0B, $1C, $20 ; entry 20
    db $F0, $1B, $0F, $20 ; entry 21
    db $F8, $03, $1A, $00 ; entry 22
    db $E8, $23, $09, $00 ; entry 23
    db $E8, $0B, $09, $20 ; entry 24
    db $E8, $13, $08, $20 ; entry 25
    db $E8, $1B, $07, $20 ; entry 26
    db $F0, $EC, $1C, $00 ; entry 27
    db $80 ; end

; E-0147 (derived: frame 21 of MetaSprites92_4024Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set35Frame21::
Data_092_55F3:: ; address name
    db $F8, $FB, $0C, $20 ; entry 0
    db $F0, $FB, $0C, $20 ; entry 1
    db $E8, $FB, $0C, $20 ; entry 2
    db $E0, $FB, $0C, $20 ; entry 3
    db $D8, $FB, $0C, $20 ; entry 4
    db $D0, $FB, $0C, $20 ; entry 5
    db $F8, $DB, $1E, $40 ; entry 6
    db $F8, $D3, $0F, $00 ; entry 7
    db $F8, $E3, $1D, $20 ; entry 8
    db $F8, $EB, $20, $20 ; entry 9
    db $F0, $D3, $07, $00 ; entry 10
    db $F0, $DB, $08, $00 ; entry 11
    db $F0, $E3, $09, $00 ; entry 12
    db $F0, $CB, $09, $20 ; entry 13
    db $F8, $1B, $1E, $60 ; entry 14
    db $F8, $23, $0F, $20 ; entry 15
    db $F8, $13, $1D, $00 ; entry 16
    db $F8, $0B, $20, $00 ; entry 17
    db $F0, $23, $07, $20 ; entry 18
    db $F0, $1B, $08, $20 ; entry 19
    db $F0, $13, $09, $20 ; entry 20
    db $F0, $2B, $09, $00 ; entry 21
    db $80 ; end

; E-0147 (derived: frame 22 of MetaSprites92_4024Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set35Frame22::
Data_092_564C:: ; address name
    db $F0, $FC, $0D, $00 ; entry 0
    db $E8, $FC, $0D, $00 ; entry 1
    db $E0, $FC, $0D, $00 ; entry 2
    db $D8, $FC, $0D, $00 ; entry 3
    db $D0, $FC, $0D, $00 ; entry 4
    db $F8, $FC, $0D, $00 ; entry 5
    db $F8, $DF, $06, $20 ; entry 6
    db $F8, $D7, $07, $20 ; entry 7
    db $F0, $C7, $2A, $00 ; entry 8
    db $F0, $CF, $2B, $00 ; entry 9
    db $F8, $C7, $2C, $00 ; entry 10
    db $F8, $CF, $2D, $00 ; entry 11
    db $F8, $17, $06, $00 ; entry 12
    db $F8, $1F, $07, $00 ; entry 13
    db $F0, $2F, $2A, $20 ; entry 14
    db $F0, $27, $2B, $20 ; entry 15
    db $F8, $2F, $2C, $20 ; entry 16
    db $F8, $27, $2D, $20 ; entry 17
    db $80 ; end

; E-0147 (derived: frame 23 of MetaSprites92_4024Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set35Frame23::
Data_092_5695:: ; address name
    db $F0, $FB, $0D, $20 ; entry 0
    db $E8, $FB, $0D, $20 ; entry 1
    db $E0, $FB, $0D, $20 ; entry 2
    db $F8, $FB, $0D, $20 ; entry 3
    db $F8, $C4, $08, $20 ; entry 4
    db $F8, $BC, $09, $20 ; entry 5
    db $F8, $CC, $11, $20 ; entry 6
    db $F8, $33, $08, $00 ; entry 7
    db $F8, $3B, $09, $00 ; entry 8
    db $F8, $2B, $11, $00 ; entry 9
    db $80 ; end

; E-0147 (derived: frame 24 of MetaSprites92_4024Set35; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set35Frame24::
    db $80 ; end

; E-0147 (derived: meta-sprite set 54 of MetaSprites92_4024Table: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites92_4024Set36::
Data_092_56BF:: ; address name
    dw MetaSprites92_4024Set36Frame0 ; entry 0
    dw MetaSprites92_4024Set36Frame1 ; entry 1
    dw MetaSprites92_4024Set36Frame2 ; entry 2
    dw MetaSprites92_4024Set36Frame3 ; entry 3
    dw MetaSprites92_4024Set36Frame4 ; entry 4
    dw MetaSprites92_4024Set36Frame5 ; entry 5
    dw MetaSprites92_4024Set36Frame6 ; entry 6
    dw MetaSprites92_4024Set36Frame7 ; entry 7
    dw MetaSprites92_4024Set36Frame8 ; entry 8
    dw MetaSprites92_4024Set36Frame9 ; entry 9
    dw MetaSprites92_4024Set36Frame10 ; entry 10
    dw MetaSprites92_4024Set36Frame11 ; entry 11
    dw MetaSprites92_4024Set36Frame12 ; entry 12
    dw MetaSprites92_4024Set36Frame13 ; entry 13
    dw MetaSprites92_4024Set36Frame14 ; entry 14
    dw MetaSprites92_4024Set36Frame15 ; entry 15
    dw MetaSprites92_4024Set36Frame16 ; entry 16
    dw MetaSprites92_4024Set36Frame17 ; entry 17
    dw MetaSprites92_4024Set36Frame18 ; entry 18
    dw MetaSprites92_4024Set36Frame19 ; entry 19
    dw MetaSprites92_4024Set36Frame20 ; entry 20
    dw MetaSprites92_4024Set36Frame20 ; entry 21
    dw MetaSprites92_4024Set36Frame20 ; entry 22
    dw MetaSprites92_4024Set36Frame20 ; entry 23
    dw MetaSprites92_4024Set36Frame20 ; entry 24
    dw MetaSprites92_4024Set36Frame20 ; entry 25
    dw MetaSprites92_4024Set36Frame20 ; entry 26
    dw MetaSprites92_4024Set36Frame20 ; entry 27
    dw MetaSprites92_4024Set36Frame20 ; entry 28
    dw MetaSprites92_4024Set36Frame20 ; entry 29
    dw MetaSprites92_4024Set36Frame20 ; entry 30
    dw MetaSprites92_4024Set36Frame20 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites92_4024Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set36Frame0::
Data_092_56FF:: ; address name
    db $F8, $10, $00, $00 ; entry 0
    db $F8, $18, $01, $00 ; entry 1
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites92_4024Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set36Frame1::
Data_092_5708:: ; address name
    db $F8, $08, $02, $00 ; entry 0
    db $F8, $10, $03, $00 ; entry 1
    db $F0, $08, $00, $00 ; entry 2
    db $F0, $10, $01, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites92_4024Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set36Frame2::
Data_092_5719:: ; address name
    db $F0, $00, $02, $00 ; entry 0
    db $F0, $08, $03, $00 ; entry 1
    db $E8, $00, $00, $00 ; entry 2
    db $E8, $08, $01, $00 ; entry 3
    db $E0, $F0, $11, $00 ; entry 4
    db $E0, $F8, $12, $00 ; entry 5
    db $E0, $00, $13, $00 ; entry 6
    db $D8, $F8, $0F, $00 ; entry 7
    db $D8, $00, $10, $00 ; entry 8
    db $E8, $F0, $14, $00 ; entry 9
    db $E8, $F8, $15, $00 ; entry 10
    db $F8, $10, $18, $00 ; entry 11
    db $F8, $18, $19, $00 ; entry 12
    db $F0, $10, $19, $00 ; entry 13
    db $F8, $08, $19, $60 ; entry 14
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites92_4024Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set36Frame3::
Data_092_5756:: ; address name
    db $F0, $08, $18, $00 ; entry 0
    db $F0, $10, $19, $00 ; entry 1
    db $F0, $00, $19, $60 ; entry 2
    db $D0, $E8, $04, $00 ; entry 3
    db $D0, $F0, $05, $00 ; entry 4
    db $D0, $F8, $06, $00 ; entry 5
    db $D0, $00, $07, $00 ; entry 6
    db $D8, $E8, $08, $00 ; entry 7
    db $D8, $F0, $09, $00 ; entry 8
    db $D8, $F8, $0A, $00 ; entry 9
    db $E0, $E8, $0B, $00 ; entry 10
    db $E0, $F0, $0C, $00 ; entry 11
    db $E8, $E8, $0E, $00 ; entry 12
    db $E8, $08, $19, $00 ; entry 13
    db $E0, $F8, $16, $00 ; entry 14
    db $E8, $00, $0D, $00 ; entry 15
    db $E0, $00, $17, $00 ; entry 16
    db $E8, $F8, $17, $60 ; entry 17
    db $F8, $10, $18, $00 ; entry 18
    db $F8, $18, $19, $00 ; entry 19
    db $F8, $08, $19, $60 ; entry 20
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites92_4024Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set36Frame4::
Data_092_57AB:: ; address name
    db $E8, $F8, $19, $60 ; entry 0
    db $D0, $E0, $08, $00 ; entry 1
    db $D0, $E8, $09, $00 ; entry 2
    db $D0, $F0, $0A, $00 ; entry 3
    db $D8, $E0, $0B, $00 ; entry 4
    db $D8, $E8, $0C, $00 ; entry 5
    db $E0, $E0, $0E, $00 ; entry 6
    db $E0, $F8, $18, $00 ; entry 7
    db $E0, $00, $19, $00 ; entry 8
    db $E0, $F0, $19, $60 ; entry 9
    db $D8, $F8, $19, $00 ; entry 10
    db $D8, $F0, $0D, $00 ; entry 11
    db $E8, $00, $1A, $00 ; entry 12
    db $F0, $08, $1A, $00 ; entry 13
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites92_4024Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set36Frame5::
Data_092_57E4:: ; address name
    db $D0, $D8, $0B, $00 ; entry 0
    db $D0, $E0, $0C, $00 ; entry 1
    db $D8, $D8, $0E, $00 ; entry 2
    db $D0, $E8, $18, $00 ; entry 3
    db $D0, $F0, $19, $00 ; entry 4
    db $D8, $E8, $19, $60 ; entry 5
    db $D8, $F0, $1A, $00 ; entry 6
    db $E0, $F8, $1A, $00 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites92_4024Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set36Frame6::
Data_092_5805:: ; address name
    db $D0, $E8, $1A, $00 ; entry 0
    db $D8, $F0, $1A, $00 ; entry 1
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites92_4024Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set36Frame7::
Data_092_580E:: ; address name
    db $E0, $F9, $1E, $00 ; entry 0
    db $E7, $F9, $1E, $40 ; entry 1
    db $E0, $00, $1E, $20 ; entry 2
    db $E7, $00, $1E, $60 ; entry 3
    db $E9, $02, $1A, $00 ; entry 4
    db $DE, $F7, $1A, $00 ; entry 5
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites92_4024Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set36Frame8::
Data_092_5827:: ; address name
    db $E0, $F0, $11, $00 ; entry 0
    db $E0, $F8, $12, $00 ; entry 1
    db $D8, $F8, $0F, $00 ; entry 2
    db $D8, $00, $10, $00 ; entry 3
    db $E8, $F0, $14, $00 ; entry 4
    db $E8, $08, $11, $60 ; entry 5
    db $E8, $00, $12, $60 ; entry 6
    db $E8, $F8, $13, $60 ; entry 7
    db $F0, $00, $0F, $60 ; entry 8
    db $F0, $F8, $10, $60 ; entry 9
    db $E0, $08, $14, $60 ; entry 10
    db $E0, $00, $15, $60 ; entry 11
    db $F0, $08, $1A, $00 ; entry 12
    db $D8, $F0, $1A, $00 ; entry 13
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites92_4024Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set36Frame9::
Data_092_5860:: ; address name
    db $E0, $F9, $1E, $00 ; entry 0
    db $E7, $F9, $1E, $40 ; entry 1
    db $E0, $00, $1E, $20 ; entry 2
    db $E7, $00, $1E, $60 ; entry 3
    db $F0, $09, $18, $00 ; entry 4
    db $E8, $01, $16, $00 ; entry 5
    db $E8, $09, $17, $00 ; entry 6
    db $F0, $01, $17, $60 ; entry 7
    db $F0, $11, $19, $00 ; entry 8
    db $F8, $09, $19, $60 ; entry 9
    db $F8, $11, $1A, $00 ; entry 10
    db $D7, $F0, $18, $60 ; entry 11
    db $DF, $F8, $16, $60 ; entry 12
    db $DF, $F0, $17, $60 ; entry 13
    db $D7, $F8, $17, $00 ; entry 14
    db $D7, $E8, $19, $60 ; entry 15
    db $CF, $F0, $19, $00 ; entry 16
    db $D0, $E9, $1A, $60 ; entry 17
    db $80 ; end

; E-0147 (derived: frame 10 of MetaSprites92_4024Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set36Frame10::
Data_092_58A9:: ; address name
    db $F0, $08, $1A, $00 ; entry 0
    db $F8, $10, $1A, $00 ; entry 1
    db $E8, $00, $1A, $00 ; entry 2
    db $E0, $F8, $1A, $00 ; entry 3
    db $D8, $F0, $1A, $00 ; entry 4
    db $D0, $E8, $1A, $60 ; entry 5
    db $80 ; end

; E-0147 (derived: frame 11 of MetaSprites92_4024Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set36Frame11::
Data_092_58C2:: ; address name
    db $D0, $E8, $21, $00 ; entry 0
    db $F0, $08, $21, $00 ; entry 1
    db $F8, $10, $21, $00 ; entry 2
    db $D0, $F0, $19, $00 ; entry 3
    db $F0, $10, $19, $00 ; entry 4
    db $F8, $08, $19, $60 ; entry 5
    db $F0, $00, $19, $60 ; entry 6
    db $E8, $00, $21, $00 ; entry 7
    db $E8, $08, $19, $00 ; entry 8
    db $E8, $F8, $19, $60 ; entry 9
    db $E0, $F8, $21, $00 ; entry 10
    db $E0, $00, $19, $00 ; entry 11
    db $E0, $F0, $19, $60 ; entry 12
    db $D8, $F0, $21, $00 ; entry 13
    db $D8, $F8, $19, $00 ; entry 14
    db $D8, $E8, $19, $60 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 12 of MetaSprites92_4024Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set36Frame12::
Data_092_5903:: ; address name
    db $D0, $E8, $1F, $00 ; entry 0
    db $D8, $F0, $1F, $00 ; entry 1
    db $D0, $F0, $20, $00 ; entry 2
    db $D8, $F8, $20, $00 ; entry 3
    db $D8, $E8, $20, $60 ; entry 4
    db $E0, $F8, $1F, $00 ; entry 5
    db $E0, $00, $20, $00 ; entry 6
    db $E0, $F0, $20, $60 ; entry 7
    db $E8, $00, $1F, $00 ; entry 8
    db $E8, $08, $20, $00 ; entry 9
    db $E8, $F8, $20, $60 ; entry 10
    db $F0, $08, $1F, $00 ; entry 11
    db $F0, $10, $20, $00 ; entry 12
    db $F0, $00, $20, $60 ; entry 13
    db $F8, $10, $1F, $00 ; entry 14
    db $F8, $08, $20, $60 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 13 of MetaSprites92_4024Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set36Frame13::
Data_092_5944:: ; address name
    db $F8, $0C, $1B, $60 ; entry 0
    db $F8, $14, $1B, $00 ; entry 1
    db $D0, $E4, $1B, $60 ; entry 2
    db $D0, $EC, $1B, $00 ; entry 3
    db $D8, $EC, $1B, $60 ; entry 4
    db $D8, $F4, $1B, $00 ; entry 5
    db $E0, $F4, $1B, $60 ; entry 6
    db $E0, $FC, $1B, $00 ; entry 7
    db $E8, $FC, $1B, $60 ; entry 8
    db $E8, $04, $1B, $00 ; entry 9
    db $F0, $04, $1B, $60 ; entry 10
    db $F0, $0C, $1B, $00 ; entry 11
    db $80 ; end

; E-0147 (derived: frame 14 of MetaSprites92_4024Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set36Frame14::
Data_092_5975:: ; address name
    db $D0, $EC, $1C, $00 ; entry 0
    db $D0, $E4, $1C, $60 ; entry 1
    db $D8, $F4, $1C, $00 ; entry 2
    db $D8, $EC, $1C, $60 ; entry 3
    db $E0, $FC, $1C, $00 ; entry 4
    db $E0, $F4, $1C, $60 ; entry 5
    db $E8, $04, $1C, $00 ; entry 6
    db $E8, $FC, $1C, $60 ; entry 7
    db $F0, $0C, $1C, $00 ; entry 8
    db $F0, $04, $1C, $60 ; entry 9
    db $F8, $14, $1C, $00 ; entry 10
    db $F8, $0C, $1C, $60 ; entry 11
    db $80 ; end

; E-0147 (derived: frame 15 of MetaSprites92_4024Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set36Frame15::
Data_092_59A6:: ; address name
    db $F8, $08, $1B, $60 ; entry 0
    db $D0, $E0, $1B, $60 ; entry 1
    db $D8, $E8, $1B, $60 ; entry 2
    db $E0, $F0, $1B, $60 ; entry 3
    db $E8, $F8, $1B, $60 ; entry 4
    db $F0, $00, $1B, $60 ; entry 5
    db $E0, $00, $1B, $00 ; entry 6
    db $F8, $18, $1B, $00 ; entry 7
    db $F0, $10, $1B, $00 ; entry 8
    db $E8, $08, $1B, $00 ; entry 9
    db $D8, $F8, $1B, $00 ; entry 10
    db $D0, $F0, $1B, $00 ; entry 11
    db $D0, $E8, $1D, $00 ; entry 12
    db $D8, $F0, $1D, $00 ; entry 13
    db $E0, $F8, $1D, $00 ; entry 14
    db $E8, $00, $1D, $00 ; entry 15
    db $F0, $08, $1D, $00 ; entry 16
    db $F8, $10, $1D, $00 ; entry 17
    db $80 ; end

; E-0147 (derived: frame 16 of MetaSprites92_4024Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set36Frame16::
Data_092_59EF:: ; address name
    db $F0, $0C, $1D, $00 ; entry 0
    db $D0, $F4, $1C, $00 ; entry 1
    db $D8, $FC, $1C, $00 ; entry 2
    db $E0, $04, $1C, $00 ; entry 3
    db $E8, $0C, $1C, $00 ; entry 4
    db $F0, $14, $1C, $00 ; entry 5
    db $F8, $1C, $1C, $00 ; entry 6
    db $F8, $14, $1D, $00 ; entry 7
    db $F8, $04, $1C, $60 ; entry 8
    db $F8, $0C, $1D, $00 ; entry 9
    db $F0, $FC, $1C, $60 ; entry 10
    db $F0, $04, $1D, $00 ; entry 11
    db $E8, $04, $1D, $00 ; entry 12
    db $E8, $FC, $1D, $00 ; entry 13
    db $E8, $F4, $1C, $60 ; entry 14
    db $E0, $FC, $1D, $00 ; entry 15
    db $E0, $EC, $1C, $60 ; entry 16
    db $E0, $F4, $1D, $00 ; entry 17
    db $D8, $F4, $1D, $00 ; entry 18
    db $D8, $E4, $1C, $60 ; entry 19
    db $D8, $EC, $1D, $00 ; entry 20
    db $D0, $EC, $1D, $00 ; entry 21
    db $D0, $DC, $1C, $60 ; entry 22
    db $D0, $E4, $1D, $00 ; entry 23
    db $80 ; end

; E-0147 (derived: frame 17 of MetaSprites92_4024Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set36Frame17::
Data_092_5A50:: ; address name
    db $D0, $F0, $1D, $00 ; entry 0
    db $D0, $F8, $1B, $00 ; entry 1
    db $D0, $E0, $1D, $00 ; entry 2
    db $D0, $D8, $1B, $60 ; entry 3
    db $D0, $E8, $1D, $00 ; entry 4
    db $D8, $F8, $1D, $00 ; entry 5
    db $D8, $00, $1B, $00 ; entry 6
    db $D8, $E8, $1D, $00 ; entry 7
    db $D8, $E0, $1B, $60 ; entry 8
    db $D8, $F0, $1D, $00 ; entry 9
    db $E0, $00, $1D, $00 ; entry 10
    db $E0, $08, $1B, $00 ; entry 11
    db $E0, $F0, $1D, $00 ; entry 12
    db $E0, $E8, $1B, $60 ; entry 13
    db $E0, $F8, $1D, $00 ; entry 14
    db $E8, $08, $1D, $00 ; entry 15
    db $E8, $10, $1B, $00 ; entry 16
    db $E8, $F8, $1D, $00 ; entry 17
    db $E8, $F0, $1B, $60 ; entry 18
    db $E8, $00, $1D, $00 ; entry 19
    db $F0, $10, $1D, $00 ; entry 20
    db $F0, $18, $1B, $00 ; entry 21
    db $F0, $00, $1D, $00 ; entry 22
    db $F0, $F8, $1B, $60 ; entry 23
    db $F0, $08, $1D, $00 ; entry 24
    db $F8, $18, $1D, $00 ; entry 25
    db $F8, $20, $1B, $00 ; entry 26
    db $F8, $08, $1D, $00 ; entry 27
    db $F8, $00, $1B, $60 ; entry 28
    db $F8, $10, $1D, $00 ; entry 29
    db $80 ; end

; E-0147 (derived: frame 18 of MetaSprites92_4024Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set36Frame18::
Data_092_5AC9:: ; address name
    db $D0, $F4, $1D, $00 ; entry 0
    db $D0, $E4, $1D, $00 ; entry 1
    db $D0, $EC, $1D, $00 ; entry 2
    db $D0, $FC, $1C, $00 ; entry 3
    db $D0, $D4, $1C, $60 ; entry 4
    db $D0, $DC, $1D, $00 ; entry 5
    db $D8, $FC, $1D, $00 ; entry 6
    db $D8, $EC, $1D, $00 ; entry 7
    db $D8, $F4, $1D, $00 ; entry 8
    db $D8, $04, $1C, $00 ; entry 9
    db $D8, $DC, $1C, $60 ; entry 10
    db $D8, $E4, $1D, $00 ; entry 11
    db $E0, $04, $1D, $00 ; entry 12
    db $E0, $F4, $1D, $00 ; entry 13
    db $E0, $FC, $1D, $00 ; entry 14
    db $E0, $0C, $1C, $00 ; entry 15
    db $E0, $E4, $1C, $60 ; entry 16
    db $E0, $EC, $1D, $00 ; entry 17
    db $E8, $0C, $1D, $00 ; entry 18
    db $E8, $FC, $1D, $00 ; entry 19
    db $E8, $04, $1D, $00 ; entry 20
    db $E8, $14, $1C, $00 ; entry 21
    db $E8, $EC, $1C, $60 ; entry 22
    db $E8, $F4, $1D, $00 ; entry 23
    db $F0, $14, $1D, $00 ; entry 24
    db $F0, $04, $1D, $00 ; entry 25
    db $F0, $0C, $1D, $00 ; entry 26
    db $F0, $1C, $1C, $00 ; entry 27
    db $F0, $F4, $1C, $60 ; entry 28
    db $F0, $FC, $1D, $00 ; entry 29
    db $F8, $1C, $1D, $00 ; entry 30
    db $F8, $0C, $1D, $00 ; entry 31
    db $F8, $14, $1D, $00 ; entry 32
    db $F8, $24, $1C, $00 ; entry 33
    db $F8, $FC, $1C, $60 ; entry 34
    db $F8, $04, $1D, $00 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 19 of MetaSprites92_4024Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set36Frame19::
Data_092_5B5A:: ; address name
    db $D0, $F4, $1D, $00 ; entry 0
    db $D0, $E4, $1D, $00 ; entry 1
    db $D0, $EC, $1D, $00 ; entry 2
    db $D0, $DC, $1D, $00 ; entry 3
    db $D8, $FC, $1D, $00 ; entry 4
    db $D8, $EC, $1D, $00 ; entry 5
    db $D8, $F4, $1D, $00 ; entry 6
    db $D8, $E4, $1D, $00 ; entry 7
    db $E0, $04, $1D, $00 ; entry 8
    db $E0, $F4, $1D, $00 ; entry 9
    db $E0, $FC, $1D, $00 ; entry 10
    db $E0, $EC, $1D, $00 ; entry 11
    db $E8, $0C, $1D, $00 ; entry 12
    db $E8, $FC, $1D, $00 ; entry 13
    db $E8, $04, $1D, $00 ; entry 14
    db $E8, $F4, $1D, $00 ; entry 15
    db $F0, $14, $1D, $00 ; entry 16
    db $F0, $04, $1D, $00 ; entry 17
    db $F0, $0C, $1D, $00 ; entry 18
    db $F0, $FC, $1D, $00 ; entry 19
    db $F8, $1C, $1D, $00 ; entry 20
    db $F8, $0C, $1D, $00 ; entry 21
    db $F8, $14, $1D, $00 ; entry 22
    db $F8, $04, $1D, $00 ; entry 23
    db $D0, $FC, $1B, $00 ; entry 24
    db $D8, $04, $1B, $00 ; entry 25
    db $E0, $0C, $1B, $00 ; entry 26
    db $E8, $14, $1B, $00 ; entry 27
    db $F0, $1C, $1B, $00 ; entry 28
    db $F8, $24, $1B, $00 ; entry 29
    db $F8, $FC, $1B, $60 ; entry 30
    db $F0, $F4, $1B, $60 ; entry 31
    db $D0, $D4, $1B, $60 ; entry 32
    db $D8, $DC, $1B, $60 ; entry 33
    db $E0, $E4, $1B, $60 ; entry 34
    db $E8, $EC, $1B, $60 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 20 of MetaSprites92_4024Set36; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set36Frame20::
    db $80 ; end

; E-0147 (derived: meta-sprite set 55 of MetaSprites92_4024Table: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites92_4024Set37::
Data_092_5BEC:: ; address name
    dw MetaSprites92_4024Set37Frame0 ; entry 0
    dw MetaSprites92_4024Set37Frame1 ; entry 1
    dw MetaSprites92_4024Set37Frame2 ; entry 2
    dw MetaSprites92_4024Set37Frame3 ; entry 3
    dw MetaSprites92_4024Set37Frame4 ; entry 4
    dw MetaSprites92_4024Set37Frame5 ; entry 5
    dw MetaSprites92_4024Set37Frame6 ; entry 6
    dw MetaSprites92_4024Set37Frame7 ; entry 7
    dw MetaSprites92_4024Set37Frame8 ; entry 8
    dw MetaSprites92_4024Set37Frame9 ; entry 9
    dw MetaSprites92_4024Set37Frame10 ; entry 10
    dw MetaSprites92_4024Set37Frame11 ; entry 11
    dw MetaSprites92_4024Set37Frame12 ; entry 12
    dw MetaSprites92_4024Set37Frame13 ; entry 13
    dw MetaSprites92_4024Set37Frame14 ; entry 14
    dw MetaSprites92_4024Set37Frame15 ; entry 15
    dw MetaSprites92_4024Set37Frame16 ; entry 16
    dw MetaSprites92_4024Set37Frame16 ; entry 17
    dw MetaSprites92_4024Set37Frame16 ; entry 18
    dw MetaSprites92_4024Set37Frame16 ; entry 19
    dw MetaSprites92_4024Set37Frame16 ; entry 20
    dw MetaSprites92_4024Set37Frame16 ; entry 21
    dw MetaSprites92_4024Set37Frame16 ; entry 22
    dw MetaSprites92_4024Set37Frame16 ; entry 23
    dw MetaSprites92_4024Set37Frame16 ; entry 24
    dw MetaSprites92_4024Set37Frame16 ; entry 25
    dw MetaSprites92_4024Set37Frame16 ; entry 26
    dw MetaSprites92_4024Set37Frame16 ; entry 27
    dw MetaSprites92_4024Set37Frame16 ; entry 28
    dw MetaSprites92_4024Set37Frame16 ; entry 29
    dw MetaSprites92_4024Set37Frame16 ; entry 30
    dw MetaSprites92_4024Set37Frame16 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites92_4024Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set37Frame0::
Data_092_5C2C:: ; address name
    db $D8, $FC, $00, $10 ; entry 0
    db $D0, $FC, $01, $10 ; entry 1
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites92_4024Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set37Frame1::
Data_092_5C35:: ; address name
    db $E8, $FC, $00, $10 ; entry 0
    db $E0, $FC, $01, $10 ; entry 1
    db $D0, $FC, $03, $10 ; entry 2
    db $D8, $FC, $02, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites92_4024Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set37Frame2::
Data_092_5C46:: ; address name
    db $F8, $FC, $00, $10 ; entry 0
    db $F0, $FC, $01, $10 ; entry 1
    db $E0, $FC, $03, $10 ; entry 2
    db $E8, $FC, $02, $10 ; entry 3
    db $D8, $FC, $04, $10 ; entry 4
    db $D0, $FC, $05, $10 ; entry 5
    db $F8, $00, $08, $10 ; entry 6
    db $F8, $F7, $08, $30 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites92_4024Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set37Frame3::
Data_092_5C67:: ; address name
    db $D0, $FC, $05, $10 ; entry 0
    db $F8, $FC, $03, $10 ; entry 1
    db $F0, $FC, $04, $10 ; entry 2
    db $E8, $FC, $05, $10 ; entry 3
    db $E0, $FC, $05, $10 ; entry 4
    db $D8, $FC, $05, $10 ; entry 5
    db $F8, $03, $06, $10 ; entry 6
    db $F8, $0B, $07, $10 ; entry 7
    db $F8, $F4, $06, $30 ; entry 8
    db $F8, $EC, $07, $30 ; entry 9
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites92_4024Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set37Frame4::
Data_092_5C90:: ; address name
    db $F8, $FC, $0C, $10 ; entry 0
    db $F0, $FC, $0C, $10 ; entry 1
    db $E8, $FC, $0C, $10 ; entry 2
    db $E0, $FC, $0C, $10 ; entry 3
    db $D8, $FC, $0C, $10 ; entry 4
    db $D0, $FC, $0C, $10 ; entry 5
    db $E8, $03, $2A, $10 ; entry 6
    db $E8, $0B, $2B, $10 ; entry 7
    db $F0, $03, $2C, $10 ; entry 8
    db $F0, $0B, $2D, $10 ; entry 9
    db $F8, $03, $2E, $10 ; entry 10
    db $F8, $0B, $2F, $10 ; entry 11
    db $E8, $F4, $2A, $30 ; entry 12
    db $E8, $EC, $2B, $30 ; entry 13
    db $F0, $F4, $2C, $30 ; entry 14
    db $F0, $EC, $2D, $30 ; entry 15
    db $F8, $F4, $2E, $30 ; entry 16
    db $F8, $EC, $2F, $30 ; entry 17
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites92_4024Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set37Frame5::
Data_092_5CD9:: ; address name
    db $F0, $03, $08, $10 ; entry 0
    db $F0, $0B, $09, $10 ; entry 1
    db $F0, $F4, $08, $30 ; entry 2
    db $F0, $EC, $09, $30 ; entry 3
    db $F8, $03, $0A, $10 ; entry 4
    db $F8, $0B, $0B, $10 ; entry 5
    db $F8, $F4, $0A, $30 ; entry 6
    db $F8, $EC, $0B, $30 ; entry 7
    db $F8, $FC, $0C, $10 ; entry 8
    db $F0, $FC, $0C, $10 ; entry 9
    db $E8, $FC, $0C, $10 ; entry 10
    db $E0, $FC, $0C, $10 ; entry 11
    db $D8, $FC, $0C, $10 ; entry 12
    db $D0, $FC, $0C, $10 ; entry 13
    db $E8, $0B, $17, $10 ; entry 14
    db $F8, $13, $18, $10 ; entry 15
    db $F8, $E4, $18, $30 ; entry 16
    db $E8, $EC, $17, $30 ; entry 17
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites92_4024Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set37Frame6::
Data_092_5D22:: ; address name
    db $F8, $FB, $0C, $30 ; entry 0
    db $F0, $FB, $0C, $30 ; entry 1
    db $E8, $FB, $0C, $30 ; entry 2
    db $E0, $FB, $0C, $30 ; entry 3
    db $D8, $FB, $0C, $30 ; entry 4
    db $D0, $FB, $0C, $30 ; entry 5
    db $F8, $03, $06, $10 ; entry 6
    db $F8, $0B, $07, $10 ; entry 7
    db $F8, $F4, $06, $30 ; entry 8
    db $F8, $EC, $07, $30 ; entry 9
    db $F0, $18, $19, $10 ; entry 10
    db $F0, $08, $18, $10 ; entry 11
    db $E8, $10, $17, $10 ; entry 12
    db $F0, $F0, $18, $30 ; entry 13
    db $F0, $E0, $19, $30 ; entry 14
    db $E8, $E8, $17, $30 ; entry 15
    db $EB, $00, $18, $10 ; entry 16
    db $E8, $F4, $19, $10 ; entry 17
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites92_4024Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set37Frame7::
Data_092_5D6B:: ; address name
    db $F8, $20, $18, $30 ; entry 0
    db $E8, $1A, $17, $30 ; entry 1
    db $EC, $10, $19, $10 ; entry 2
    db $F8, $D8, $18, $10 ; entry 3
    db $E8, $DE, $17, $10 ; entry 4
    db $EC, $E8, $19, $30 ; entry 5
    db $E0, $F4, $18, $10 ; entry 6
    db $F0, $FC, $0D, $10 ; entry 7
    db $E8, $FC, $0D, $10 ; entry 8
    db $E0, $FC, $0D, $10 ; entry 9
    db $D8, $FC, $0D, $10 ; entry 10
    db $D0, $FC, $0D, $10 ; entry 11
    db $E3, $00, $19, $10 ; entry 12
    db $F8, $FC, $0D, $10 ; entry 13
    db $F8, $ED, $0E, $10 ; entry 14
    db $F8, $F5, $0F, $10 ; entry 15
    db $F8, $0A, $0E, $30 ; entry 16
    db $F8, $02, $0F, $30 ; entry 17
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites92_4024Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set37Frame8::
Data_092_5DB4:: ; address name
    db $F0, $FB, $0D, $30 ; entry 0
    db $E8, $FB, $0D, $30 ; entry 1
    db $E0, $FB, $0D, $30 ; entry 2
    db $F8, $FB, $0D, $30 ; entry 3
    db $F8, $ED, $14, $10 ; entry 4
    db $F8, $F5, $15, $10 ; entry 5
    db $F0, $E5, $10, $10 ; entry 6
    db $F0, $ED, $11, $10 ; entry 7
    db $F0, $F5, $12, $10 ; entry 8
    db $E8, $E7, $0E, $10 ; entry 9
    db $E8, $EF, $0F, $10 ; entry 10
    db $F8, $0A, $14, $30 ; entry 11
    db $F8, $02, $15, $30 ; entry 12
    db $F0, $12, $10, $30 ; entry 13
    db $F0, $0A, $11, $30 ; entry 14
    db $F0, $02, $12, $30 ; entry 15
    db $E8, $10, $0E, $30 ; entry 16
    db $E8, $08, $0F, $30 ; entry 17
    db $F8, $12, $13, $30 ; entry 18
    db $F8, $E5, $13, $10 ; entry 19
    db $F8, $19, $18, $30 ; entry 20
    db $F0, $24, $17, $30 ; entry 21
    db $DB, $02, $18, $30 ; entry 22
    db $D8, $F3, $19, $30 ; entry 23
    db $F0, $D4, $17, $10 ; entry 24
    db $F8, $DF, $18, $10 ; entry 25
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites92_4024Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set37Frame9::
Data_092_5E1D:: ; address name
    db $E8, $E1, $10, $10 ; entry 0
    db $E8, $E9, $11, $10 ; entry 1
    db $E8, $F1, $12, $10 ; entry 2
    db $E0, $E3, $0E, $10 ; entry 3
    db $E0, $EB, $0F, $10 ; entry 4
    db $F0, $E1, $13, $10 ; entry 5
    db $F0, $E9, $14, $10 ; entry 6
    db $F0, $F1, $15, $10 ; entry 7
    db $F8, $F3, $15, $10 ; entry 8
    db $F8, $EB, $16, $10 ; entry 9
    db $F8, $DE, $10, $10 ; entry 10
    db $E8, $17, $10, $30 ; entry 11
    db $E8, $0F, $11, $30 ; entry 12
    db $E8, $07, $12, $30 ; entry 13
    db $E0, $15, $0E, $30 ; entry 14
    db $E0, $0D, $0F, $30 ; entry 15
    db $F0, $17, $13, $30 ; entry 16
    db $F0, $0F, $14, $30 ; entry 17
    db $F0, $07, $15, $30 ; entry 18
    db $F8, $05, $15, $30 ; entry 19
    db $F8, $0D, $16, $30 ; entry 20
    db $F8, $1A, $10, $30 ; entry 21
    db $F8, $15, $26, $10 ; entry 22
    db $F8, $E3, $26, $30 ; entry 23
    db $F8, $28, $17, $30 ; entry 24
    db $F8, $D1, $17, $10 ; entry 25
    db $D2, $EE, $18, $30 ; entry 26
    db $D5, $06, $19, $30 ; entry 27
    db $80 ; end

; E-0147 (derived: frame 10 of MetaSprites92_4024Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set37Frame10::
Data_092_5E8E:: ; address name
    db $E8, $DE, $10, $10 ; entry 0
    db $E8, $E6, $11, $10 ; entry 1
    db $E8, $EE, $12, $10 ; entry 2
    db $E0, $E0, $0E, $10 ; entry 3
    db $E0, $E8, $0F, $10 ; entry 4
    db $F0, $DE, $13, $10 ; entry 5
    db $F0, $E6, $14, $10 ; entry 6
    db $F0, $EE, $15, $10 ; entry 7
    db $F8, $F0, $15, $10 ; entry 8
    db $F8, $E8, $16, $10 ; entry 9
    db $F8, $DB, $10, $10 ; entry 10
    db $E8, $1A, $10, $30 ; entry 11
    db $E8, $12, $11, $30 ; entry 12
    db $E8, $0A, $12, $30 ; entry 13
    db $E0, $18, $0E, $30 ; entry 14
    db $E0, $10, $0F, $30 ; entry 15
    db $F0, $1A, $13, $30 ; entry 16
    db $F0, $12, $14, $30 ; entry 17
    db $F0, $0A, $15, $30 ; entry 18
    db $F8, $08, $15, $30 ; entry 19
    db $F8, $10, $16, $30 ; entry 20
    db $F8, $1D, $10, $30 ; entry 21
    db $F8, $18, $26, $10 ; entry 22
    db $F8, $E0, $26, $30 ; entry 23
    db $DD, $08, $18, $50 ; entry 24
    db $D8, $EC, $19, $30 ; entry 25
    db $80 ; end

; E-0147 (derived: frame 11 of MetaSprites92_4024Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set37Frame11::
Data_092_5EF7:: ; address name
    db $F0, $D6, $10, $10 ; entry 0
    db $F0, $DE, $11, $10 ; entry 1
    db $F0, $E6, $12, $10 ; entry 2
    db $E8, $D8, $0E, $10 ; entry 3
    db $E8, $E0, $0F, $10 ; entry 4
    db $F8, $D6, $13, $10 ; entry 5
    db $F8, $DE, $14, $10 ; entry 6
    db $F8, $E6, $15, $10 ; entry 7
    db $F0, $22, $10, $30 ; entry 8
    db $F0, $1A, $11, $30 ; entry 9
    db $F0, $12, $12, $30 ; entry 10
    db $E8, $20, $0E, $30 ; entry 11
    db $E8, $18, $0F, $30 ; entry 12
    db $F8, $22, $13, $30 ; entry 13
    db $F8, $1A, $14, $30 ; entry 14
    db $F8, $12, $15, $30 ; entry 15
    db $E8, $EC, $18, $10 ; entry 16
    db $ED, $08, $19, $30 ; entry 17
    db $F8, $2A, $1F, $70 ; entry 18
    db $F8, $32, $1E, $10 ; entry 19
    db $F8, $CE, $1F, $50 ; entry 20
    db $F8, $C6, $1E, $30 ; entry 21
    db $80 ; end

; E-0147 (derived: frame 12 of MetaSprites92_4024Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set37Frame12::
Data_092_5F50:: ; address name
    db $F8, $26, $0E, $30 ; entry 0
    db $F8, $1E, $0F, $30 ; entry 1
    db $F8, $D2, $0E, $10 ; entry 2
    db $F8, $DA, $0F, $10 ; entry 3
    db $F8, $2E, $22, $10 ; entry 4
    db $F8, $36, $23, $10 ; entry 5
    db $F8, $3E, $24, $10 ; entry 6
    db $F0, $2E, $20, $10 ; entry 7
    db $F0, $36, $21, $10 ; entry 8
    db $F8, $CA, $22, $30 ; entry 9
    db $F8, $C2, $23, $30 ; entry 10
    db $F8, $BA, $24, $30 ; entry 11
    db $F0, $CA, $20, $30 ; entry 12
    db $F0, $C2, $21, $30 ; entry 13
    db $EE, $26, $17, $30 ; entry 14
    db $F0, $D8, $17, $10 ; entry 15
    db $EE, $38, $17, $10 ; entry 16
    db $EF, $C3, $17, $50 ; entry 17
    db $80 ; end

; E-0147 (derived: frame 13 of MetaSprites92_4024Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set37Frame13::
Data_092_5F99:: ; address name
    db $F0, $40, $22, $30 ; entry 0
    db $F0, $38, $23, $30 ; entry 1
    db $F0, $30, $24, $30 ; entry 2
    db $E8, $40, $20, $30 ; entry 3
    db $E8, $38, $21, $30 ; entry 4
    db $F8, $40, $25, $30 ; entry 5
    db $F8, $38, $26, $30 ; entry 6
    db $F8, $30, $27, $30 ; entry 7
    db $F0, $B8, $22, $10 ; entry 8
    db $F0, $C0, $23, $10 ; entry 9
    db $F0, $C8, $24, $10 ; entry 10
    db $E8, $B8, $20, $10 ; entry 11
    db $E8, $C0, $21, $10 ; entry 12
    db $F8, $B8, $25, $10 ; entry 13
    db $F8, $C0, $26, $10 ; entry 14
    db $F8, $C8, $27, $10 ; entry 15
    db $F8, $10, $1F, $70 ; entry 16
    db $F8, $E8, $1F, $50 ; entry 17
    db $80 ; end

; E-0147 (derived: frame 14 of MetaSprites92_4024Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set37Frame14::
Data_092_5FE2:: ; address name
    db $F8, $48, $22, $30 ; entry 0
    db $F8, $40, $23, $30 ; entry 1
    db $F8, $38, $24, $30 ; entry 2
    db $F0, $48, $20, $30 ; entry 3
    db $F0, $40, $21, $30 ; entry 4
    db $F8, $B0, $22, $10 ; entry 5
    db $F8, $B8, $23, $10 ; entry 6
    db $F8, $C0, $24, $10 ; entry 7
    db $F0, $B0, $20, $10 ; entry 8
    db $F0, $B8, $21, $10 ; entry 9
    db $F8, $13, $12, $30 ; entry 10
    db $F8, $1B, $10, $30 ; entry 11
    db $F0, $18, $1F, $70 ; entry 12
    db $F8, $E5, $12, $10 ; entry 13
    db $F8, $DD, $10, $10 ; entry 14
    db $F0, $E0, $1F, $50 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 15 of MetaSprites92_4024Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set37Frame15::
Data_092_6023:: ; address name
    db $F8, $48, $21, $30 ; entry 0
    db $F8, $B0, $21, $10 ; entry 1
    db $F8, $20, $1F, $70 ; entry 2
    db $F8, $D8, $1F, $50 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 16 of MetaSprites92_4024Set37; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set37Frame16::
    db $80 ; end

; E-0147 (derived: meta-sprite set 56 of MetaSprites92_4024Table: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites92_4024Set38::
Data_092_6035:: ; address name
    dw MetaSprites92_4024Set38Frame0 ; entry 0
    dw MetaSprites92_4024Set38Frame1 ; entry 1
    dw MetaSprites92_4024Set38Frame2 ; entry 2
    dw MetaSprites92_4024Set38Frame3 ; entry 3
    dw MetaSprites92_4024Set38Frame4 ; entry 4
    dw MetaSprites92_4024Set38Frame5 ; entry 5
    dw MetaSprites92_4024Set38Frame6 ; entry 6
    dw MetaSprites92_4024Set38Frame7 ; entry 7
    dw MetaSprites92_4024Set38Frame8 ; entry 8
    dw MetaSprites92_4024Set38Frame9 ; entry 9
    dw MetaSprites92_4024Set38Frame10 ; entry 10
    dw MetaSprites92_4024Set38Frame11 ; entry 11
    dw MetaSprites92_4024Set38Frame12 ; entry 12
    dw MetaSprites92_4024Set38Frame13 ; entry 13
    dw MetaSprites92_4024Set38Frame14 ; entry 14
    dw MetaSprites92_4024Set38Frame15 ; entry 15
    dw MetaSprites92_4024Set38Frame16 ; entry 16
    dw MetaSprites92_4024Set38Frame17 ; entry 17
    dw MetaSprites92_4024Set38Frame18 ; entry 18
    dw MetaSprites92_4024Set38Frame19 ; entry 19
    dw MetaSprites92_4024Set38Frame20 ; entry 20
    dw MetaSprites92_4024Set38Frame21 ; entry 21
    dw MetaSprites92_4024Set38Frame22 ; entry 22
    dw MetaSprites92_4024Set38Frame22 ; entry 23
    dw MetaSprites92_4024Set38Frame22 ; entry 24
    dw MetaSprites92_4024Set38Frame22 ; entry 25
    dw MetaSprites92_4024Set38Frame22 ; entry 26
    dw MetaSprites92_4024Set38Frame22 ; entry 27
    dw MetaSprites92_4024Set38Frame22 ; entry 28
    dw MetaSprites92_4024Set38Frame22 ; entry 29
    dw MetaSprites92_4024Set38Frame22 ; entry 30
    dw MetaSprites92_4024Set38Frame22 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites92_4024Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set38Frame0::
Data_092_6075:: ; address name
    db $F0, $10, $00, $10 ; entry 0
    db $F0, $18, $01, $10 ; entry 1
    db $F0, $20, $02, $10 ; entry 2
    db $F0, $28, $03, $10 ; entry 3
    db $F8, $18, $04, $10 ; entry 4
    db $F8, $20, $05, $10 ; entry 5
    db $F8, $28, $06, $10 ; entry 6
    db $F8, $30, $07, $10 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites92_4024Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set38Frame1::
Data_092_6096:: ; address name
    db $E8, $00, $00, $10 ; entry 0
    db $E8, $08, $01, $10 ; entry 1
    db $E8, $10, $02, $10 ; entry 2
    db $E8, $18, $03, $10 ; entry 3
    db $F0, $08, $04, $10 ; entry 4
    db $F0, $10, $05, $10 ; entry 5
    db $F0, $18, $06, $10 ; entry 6
    db $F0, $20, $07, $10 ; entry 7
    db $F8, $10, $08, $10 ; entry 8
    db $F8, $18, $09, $10 ; entry 9
    db $F8, $20, $0A, $10 ; entry 10
    db $F8, $28, $0B, $10 ; entry 11
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites92_4024Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set38Frame2::
Data_092_60C7:: ; address name
    db $E0, $08, $03, $10 ; entry 0
    db $E8, $08, $06, $10 ; entry 1
    db $E8, $10, $07, $10 ; entry 2
    db $F0, $00, $08, $10 ; entry 3
    db $F0, $08, $09, $10 ; entry 4
    db $F0, $10, $0A, $10 ; entry 5
    db $E0, $F0, $06, $70 ; entry 6
    db $E0, $E8, $07, $70 ; entry 7
    db $D8, $F8, $08, $70 ; entry 8
    db $D8, $F0, $09, $70 ; entry 9
    db $F0, $F8, $0C, $70 ; entry 10
    db $D8, $00, $0C, $10 ; entry 11
    db $E0, $F8, $0D, $10 ; entry 12
    db $E0, $00, $0E, $10 ; entry 13
    db $E8, $00, $0D, $70 ; entry 14
    db $E8, $F8, $0E, $70 ; entry 15
    db $F0, $E8, $00, $30 ; entry 16
    db $F0, $E0, $01, $30 ; entry 17
    db $F0, $D8, $02, $30 ; entry 18
    db $F0, $D0, $03, $30 ; entry 19
    db $F8, $E0, $04, $30 ; entry 20
    db $F8, $D8, $05, $30 ; entry 21
    db $F8, $D0, $06, $30 ; entry 22
    db $F8, $C8, $07, $30 ; entry 23
    db $F8, $1C, $17, $10 ; entry 24
    db $F8, $24, $18, $10 ; entry 25
    db $F8, $2C, $17, $70 ; entry 26
    db $F0, $14, $18, $10 ; entry 27
    db $F0, $1C, $17, $70 ; entry 28
    db $D8, $E8, $0B, $10 ; entry 29
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites92_4024Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set38Frame3::
Data_092_6140:: ; address name
    db $E0, $F0, $03, $30 ; entry 0
    db $E8, $F0, $06, $30 ; entry 1
    db $F0, $F8, $08, $30 ; entry 2
    db $E0, $08, $06, $50 ; entry 3
    db $E0, $10, $07, $50 ; entry 4
    db $D8, $00, $08, $50 ; entry 5
    db $D8, $08, $09, $50 ; entry 6
    db $F0, $00, $0C, $50 ; entry 7
    db $D8, $F8, $0C, $30 ; entry 8
    db $E0, $00, $0D, $30 ; entry 9
    db $E0, $F8, $0E, $30 ; entry 10
    db $E8, $F8, $0D, $50 ; entry 11
    db $F0, $08, $2A, $70 ; entry 12
    db $F8, $E8, $08, $30 ; entry 13
    db $F0, $E8, $05, $30 ; entry 14
    db $F0, $E0, $06, $30 ; entry 15
    db $F0, $D8, $07, $30 ; entry 16
    db $E8, $E8, $02, $30 ; entry 17
    db $E8, $E0, $03, $30 ; entry 18
    db $F0, $F0, $04, $30 ; entry 19
    db $D8, $10, $0B, $30 ; entry 20
    db $F8, $1C, $17, $10 ; entry 21
    db $F8, $24, $18, $10 ; entry 22
    db $F8, $2C, $17, $70 ; entry 23
    db $F0, $0C, $17, $10 ; entry 24
    db $F0, $14, $18, $10 ; entry 25
    db $F0, $1C, $17, $70 ; entry 26
    db $E8, $04, $18, $10 ; entry 27
    db $E8, $0C, $17, $70 ; entry 28
    db $E8, $00, $0E, $50 ; entry 29
    db $F8, $D4, $18, $30 ; entry 30
    db $F8, $CC, $17, $50 ; entry 31
    db $F8, $DC, $17, $30 ; entry 32
    db $F8, $E0, $09, $30 ; entry 33
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites92_4024Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set38Frame4::
Data_092_61C9:: ; address name
    db $D0, $D0, $00, $10 ; entry 0
    db $D0, $D8, $01, $10 ; entry 1
    db $D0, $E0, $02, $10 ; entry 2
    db $D0, $E8, $03, $10 ; entry 3
    db $D8, $D8, $04, $10 ; entry 4
    db $D8, $E0, $05, $10 ; entry 5
    db $D8, $E8, $06, $10 ; entry 6
    db $E0, $E0, $08, $10 ; entry 7
    db $E0, $E8, $09, $10 ; entry 8
    db $E8, $08, $06, $10 ; entry 9
    db $E8, $10, $07, $10 ; entry 10
    db $F0, $00, $08, $10 ; entry 11
    db $F0, $F8, $0C, $70 ; entry 12
    db $E8, $00, $0D, $70 ; entry 13
    db $E0, $08, $03, $10 ; entry 14
    db $E0, $F0, $06, $70 ; entry 15
    db $D8, $F8, $08, $70 ; entry 16
    db $D8, $F0, $09, $70 ; entry 17
    db $D8, $00, $0C, $10 ; entry 18
    db $E0, $F8, $0D, $10 ; entry 19
    db $E0, $00, $0E, $10 ; entry 20
    db $F8, $1C, $17, $10 ; entry 21
    db $F8, $24, $18, $10 ; entry 22
    db $F8, $2C, $17, $70 ; entry 23
    db $F0, $14, $18, $10 ; entry 24
    db $F0, $1C, $17, $70 ; entry 25
    db $F0, $0C, $17, $10 ; entry 26
    db $F0, $08, $09, $10 ; entry 27
    db $F8, $DC, $17, $30 ; entry 28
    db $F8, $D4, $18, $30 ; entry 29
    db $F8, $CC, $17, $50 ; entry 30
    db $F0, $E4, $18, $30 ; entry 31
    db $F0, $DC, $17, $50 ; entry 32
    db $F0, $EC, $17, $30 ; entry 33
    db $E8, $EC, $17, $50 ; entry 34
    db $E8, $F4, $18, $50 ; entry 35
    db $E8, $F8, $0E, $70 ; entry 36
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites92_4024Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set38Frame5::
Data_092_625E:: ; address name
    db $D0, $C0, $08, $10 ; entry 0
    db $D0, $C8, $09, $10 ; entry 1
    db $D0, $28, $00, $30 ; entry 2
    db $D0, $20, $01, $30 ; entry 3
    db $D0, $18, $02, $30 ; entry 4
    db $D0, $10, $03, $30 ; entry 5
    db $D8, $20, $04, $30 ; entry 6
    db $D8, $18, $05, $30 ; entry 7
    db $D8, $10, $06, $30 ; entry 8
    db $D8, $08, $07, $30 ; entry 9
    db $E0, $18, $08, $30 ; entry 10
    db $E0, $10, $09, $30 ; entry 11
    db $E0, $08, $0A, $30 ; entry 12
    db $F0, $0C, $17, $10 ; entry 13
    db $F0, $14, $18, $10 ; entry 14
    db $F0, $1C, $17, $70 ; entry 15
    db $E8, $FC, $17, $10 ; entry 16
    db $E8, $04, $18, $10 ; entry 17
    db $E8, $0C, $17, $70 ; entry 18
    db $E0, $EC, $17, $10 ; entry 19
    db $E0, $F4, $18, $10 ; entry 20
    db $E0, $FC, $17, $70 ; entry 21
    db $D8, $DC, $17, $10 ; entry 22
    db $D8, $E4, $18, $10 ; entry 23
    db $D8, $EC, $17, $70 ; entry 24
    db $D0, $D4, $18, $10 ; entry 25
    db $D0, $DC, $17, $70 ; entry 26
    db $D0, $D0, $0A, $10 ; entry 27
    db $F8, $DC, $17, $30 ; entry 28
    db $F8, $D4, $18, $30 ; entry 29
    db $F8, $CC, $17, $50 ; entry 30
    db $F0, $EC, $17, $30 ; entry 31
    db $F0, $E4, $18, $30 ; entry 32
    db $F0, $DC, $17, $50 ; entry 33
    db $E8, $F4, $18, $30 ; entry 34
    db $E8, $EC, $17, $50 ; entry 35
    db $E0, $04, $18, $30 ; entry 36
    db $F8, $1C, $17, $10 ; entry 37
    db $F8, $24, $18, $10 ; entry 38
    db $F8, $2C, $17, $70 ; entry 39
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites92_4024Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set38Frame6::
Data_092_62FF:: ; address name
    db $F0, $F0, $1B, $50 ; entry 0
    db $F0, $F8, $1C, $50 ; entry 1
    db $E8, $F0, $1E, $50 ; entry 2
    db $E8, $F8, $1A, $50 ; entry 3
    db $F0, $08, $1B, $70 ; entry 4
    db $F0, $00, $1C, $70 ; entry 5
    db $E8, $08, $1E, $70 ; entry 6
    db $E8, $00, $1A, $70 ; entry 7
    db $D8, $F0, $1B, $10 ; entry 8
    db $D8, $F8, $1C, $10 ; entry 9
    db $E0, $F0, $1E, $10 ; entry 10
    db $E0, $F8, $1A, $10 ; entry 11
    db $D8, $08, $1B, $30 ; entry 12
    db $D8, $00, $1C, $30 ; entry 13
    db $E0, $08, $1E, $30 ; entry 14
    db $E0, $00, $1A, $30 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites92_4024Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set38Frame7::
Data_092_6340:: ; address name
    db $D0, $E8, $1B, $10 ; entry 0
    db $D0, $F0, $1C, $10 ; entry 1
    db $D0, $F8, $1D, $10 ; entry 2
    db $D8, $E8, $1E, $10 ; entry 3
    db $E0, $E8, $1F, $10 ; entry 4
    db $E0, $F0, $1A, $10 ; entry 5
    db $D8, $F8, $1A, $10 ; entry 6
    db $D0, $10, $1B, $30 ; entry 7
    db $D0, $08, $1C, $30 ; entry 8
    db $D0, $00, $1D, $30 ; entry 9
    db $D8, $10, $1E, $30 ; entry 10
    db $E0, $10, $1F, $30 ; entry 11
    db $E0, $08, $1A, $30 ; entry 12
    db $D8, $00, $1A, $30 ; entry 13
    db $F8, $E8, $1B, $50 ; entry 14
    db $F8, $F0, $1C, $50 ; entry 15
    db $F8, $F8, $1D, $50 ; entry 16
    db $F0, $E8, $1E, $50 ; entry 17
    db $E8, $E8, $1F, $50 ; entry 18
    db $E8, $F0, $1A, $50 ; entry 19
    db $F0, $F8, $1A, $50 ; entry 20
    db $F8, $10, $1B, $70 ; entry 21
    db $F8, $08, $1C, $70 ; entry 22
    db $F8, $00, $1D, $70 ; entry 23
    db $F0, $10, $1E, $70 ; entry 24
    db $E8, $10, $1F, $70 ; entry 25
    db $E8, $08, $1A, $70 ; entry 26
    db $F0, $00, $1A, $70 ; entry 27
    db $E0, $00, $19, $10 ; entry 28
    db $E0, $F8, $19, $30 ; entry 29
    db $E8, $F8, $19, $70 ; entry 30
    db $E8, $00, $19, $50 ; entry 31
    db $D8, $08, $19, $10 ; entry 32
    db $F0, $08, $19, $50 ; entry 33
    db $F0, $F0, $19, $70 ; entry 34
    db $D8, $F0, $19, $30 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites92_4024Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set38Frame8::
Data_092_63D1:: ; address name
    db $D0, $28, $1B, $30 ; entry 0
    db $D0, $20, $1C, $30 ; entry 1
    db $D8, $28, $1E, $30 ; entry 2
    db $E0, $28, $1F, $30 ; entry 3
    db $F8, $28, $1B, $70 ; entry 4
    db $F8, $20, $1C, $70 ; entry 5
    db $F0, $28, $1E, $70 ; entry 6
    db $E8, $28, $1F, $70 ; entry 7
    db $D8, $20, $19, $10 ; entry 8
    db $F0, $20, $19, $50 ; entry 9
    db $F0, $18, $1C, $10 ; entry 10
    db $D8, $18, $1C, $50 ; entry 11
    db $D0, $10, $1C, $50 ; entry 12
    db $F8, $10, $1C, $10 ; entry 13
    db $E0, $20, $1F, $10 ; entry 14
    db $E8, $20, $1F, $50 ; entry 15
    db $D0, $D0, $1B, $10 ; entry 16
    db $D0, $D8, $1C, $10 ; entry 17
    db $D8, $D0, $1E, $10 ; entry 18
    db $E0, $D0, $1F, $10 ; entry 19
    db $F8, $D0, $1B, $50 ; entry 20
    db $F8, $D8, $1C, $50 ; entry 21
    db $F0, $D0, $1E, $50 ; entry 22
    db $E8, $D0, $1F, $50 ; entry 23
    db $D8, $D8, $19, $30 ; entry 24
    db $F0, $D8, $19, $70 ; entry 25
    db $F0, $E0, $1C, $30 ; entry 26
    db $D8, $E0, $1C, $70 ; entry 27
    db $D0, $E8, $1C, $70 ; entry 28
    db $F8, $E8, $1C, $30 ; entry 29
    db $E0, $D8, $1F, $30 ; entry 30
    db $E8, $D8, $1F, $70 ; entry 31
    db $D0, $E0, $15, $10 ; entry 32
    db $F8, $E0, $15, $50 ; entry 33
    db $D0, $18, $15, $30 ; entry 34
    db $F8, $18, $15, $70 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites92_4024Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set38Frame9::
Data_092_6462:: ; address name
    db $D0, $40, $1B, $30 ; entry 0
    db $D0, $38, $1C, $30 ; entry 1
    db $D8, $40, $1E, $30 ; entry 2
    db $E0, $40, $1F, $30 ; entry 3
    db $F8, $40, $1B, $70 ; entry 4
    db $F8, $38, $1C, $70 ; entry 5
    db $F0, $40, $1E, $70 ; entry 6
    db $E8, $40, $1F, $70 ; entry 7
    db $D8, $38, $19, $10 ; entry 8
    db $F0, $38, $19, $50 ; entry 9
    db $F0, $30, $1C, $10 ; entry 10
    db $D8, $30, $1C, $50 ; entry 11
    db $D0, $28, $1C, $50 ; entry 12
    db $F8, $28, $1C, $10 ; entry 13
    db $E0, $38, $1F, $10 ; entry 14
    db $E8, $38, $1F, $50 ; entry 15
    db $D0, $B8, $1B, $10 ; entry 16
    db $D0, $C0, $1C, $10 ; entry 17
    db $D8, $B8, $1E, $10 ; entry 18
    db $E0, $B8, $1F, $10 ; entry 19
    db $F8, $B8, $1B, $50 ; entry 20
    db $F8, $C0, $1C, $50 ; entry 21
    db $F0, $B8, $1E, $50 ; entry 22
    db $E8, $B8, $1F, $50 ; entry 23
    db $D8, $C0, $19, $30 ; entry 24
    db $F0, $C0, $19, $70 ; entry 25
    db $F0, $C8, $1C, $30 ; entry 26
    db $D8, $C8, $1C, $70 ; entry 27
    db $D0, $D0, $1C, $70 ; entry 28
    db $F8, $D0, $1C, $30 ; entry 29
    db $E0, $C0, $1F, $30 ; entry 30
    db $E8, $C0, $1F, $70 ; entry 31
    db $D0, $20, $1B, $50 ; entry 32
    db $F8, $20, $1B, $10 ; entry 33
    db $F8, $D8, $1B, $30 ; entry 34
    db $D0, $D8, $1B, $70 ; entry 35
    db $D0, $C8, $15, $10 ; entry 36
    db $F8, $C8, $15, $50 ; entry 37
    db $D0, $30, $15, $30 ; entry 38
    db $F8, $30, $15, $70 ; entry 39
    db $80 ; end

; E-0147 (derived: frame 10 of MetaSprites92_4024Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set38Frame10::
Data_092_6503:: ; address name
    db $D0, $D8, $20, $10 ; entry 0
    db $D0, $E0, $21, $10 ; entry 1
    db $D0, $E8, $22, $10 ; entry 2
    db $D8, $E8, $23, $10 ; entry 3
    db $D8, $F0, $24, $10 ; entry 4
    db $E0, $F0, $20, $10 ; entry 5
    db $E0, $F8, $21, $10 ; entry 6
    db $E0, $00, $22, $10 ; entry 7
    db $E8, $00, $23, $10 ; entry 8
    db $E8, $08, $24, $10 ; entry 9
    db $F0, $08, $20, $10 ; entry 10
    db $F0, $10, $21, $10 ; entry 11
    db $F0, $18, $22, $10 ; entry 12
    db $F8, $18, $23, $10 ; entry 13
    db $F8, $20, $24, $10 ; entry 14
    db $80 ; end

; E-0147 (derived: frame 11 of MetaSprites92_4024Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set38Frame11::
Data_092_6540:: ; address name
    db $D0, $20, $20, $30 ; entry 0
    db $D0, $18, $21, $30 ; entry 1
    db $D0, $10, $22, $30 ; entry 2
    db $D8, $10, $23, $30 ; entry 3
    db $D8, $08, $24, $30 ; entry 4
    db $E0, $08, $20, $30 ; entry 5
    db $E0, $00, $21, $30 ; entry 6
    db $E0, $F8, $22, $30 ; entry 7
    db $E8, $F8, $23, $30 ; entry 8
    db $E8, $F0, $24, $30 ; entry 9
    db $F0, $F0, $20, $30 ; entry 10
    db $F0, $E8, $21, $30 ; entry 11
    db $F0, $E0, $22, $30 ; entry 12
    db $F8, $E0, $23, $30 ; entry 13
    db $F8, $D8, $24, $30 ; entry 14
    db $80 ; end

; E-0147 (derived: frame 12 of MetaSprites92_4024Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set38Frame12::
Data_092_657D:: ; address name
    db $D0, $C4, $25, $10 ; entry 0
    db $D0, $CC, $26, $10 ; entry 1
    db $D0, $D4, $27, $10 ; entry 2
    db $D0, $DC, $28, $10 ; entry 3
    db $D8, $D4, $2B, $10 ; entry 4
    db $D8, $DC, $2C, $10 ; entry 5
    db $D8, $E4, $2D, $10 ; entry 6
    db $D8, $EC, $2E, $10 ; entry 7
    db $D8, $F4, $2F, $10 ; entry 8
    db $E0, $E4, $25, $10 ; entry 9
    db $E0, $EC, $26, $10 ; entry 10
    db $E0, $F4, $27, $10 ; entry 11
    db $E0, $FC, $28, $10 ; entry 12
    db $E8, $F4, $2B, $10 ; entry 13
    db $E8, $FC, $2C, $10 ; entry 14
    db $E8, $04, $2D, $10 ; entry 15
    db $E8, $0C, $2E, $10 ; entry 16
    db $E8, $14, $2F, $10 ; entry 17
    db $F0, $04, $25, $10 ; entry 18
    db $F0, $0C, $26, $10 ; entry 19
    db $F0, $14, $27, $10 ; entry 20
    db $F0, $1C, $28, $10 ; entry 21
    db $F8, $14, $2B, $10 ; entry 22
    db $F8, $1C, $2C, $10 ; entry 23
    db $F8, $24, $2D, $10 ; entry 24
    db $F8, $2C, $2E, $10 ; entry 25
    db $F8, $34, $2F, $10 ; entry 26
    db $80 ; end

; E-0147 (derived: frame 13 of MetaSprites92_4024Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set38Frame13::
Data_092_65EA:: ; address name
    db $D0, $34, $25, $30 ; entry 0
    db $D0, $2C, $26, $30 ; entry 1
    db $D0, $24, $27, $30 ; entry 2
    db $D0, $1C, $28, $30 ; entry 3
    db $D8, $24, $2B, $30 ; entry 4
    db $D8, $1C, $2C, $30 ; entry 5
    db $D8, $14, $2D, $30 ; entry 6
    db $D8, $0C, $2E, $30 ; entry 7
    db $D8, $04, $2F, $30 ; entry 8
    db $E0, $14, $25, $30 ; entry 9
    db $E0, $0C, $26, $30 ; entry 10
    db $E0, $04, $27, $30 ; entry 11
    db $E0, $FC, $28, $30 ; entry 12
    db $E8, $04, $2B, $30 ; entry 13
    db $E8, $FC, $2C, $30 ; entry 14
    db $E8, $F4, $2D, $30 ; entry 15
    db $E8, $EC, $2E, $30 ; entry 16
    db $E8, $E4, $2F, $30 ; entry 17
    db $F0, $F4, $25, $30 ; entry 18
    db $F0, $EC, $26, $30 ; entry 19
    db $F0, $E4, $27, $30 ; entry 20
    db $F0, $DC, $28, $30 ; entry 21
    db $F8, $E4, $2B, $30 ; entry 22
    db $F8, $DC, $2C, $30 ; entry 23
    db $F8, $D4, $2D, $30 ; entry 24
    db $F8, $CC, $2E, $30 ; entry 25
    db $F8, $C4, $2F, $30 ; entry 26
    db $80 ; end

; E-0147 (derived: frame 14 of MetaSprites92_4024Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set38Frame14::
Data_092_6657:: ; address name
    db $D0, $D8, $23, $10 ; entry 0
    db $D0, $E0, $24, $10 ; entry 1
    db $D8, $E0, $20, $10 ; entry 2
    db $D8, $E8, $21, $10 ; entry 3
    db $D8, $F0, $22, $10 ; entry 4
    db $E0, $F0, $23, $10 ; entry 5
    db $E0, $F8, $24, $10 ; entry 6
    db $E8, $F8, $20, $10 ; entry 7
    db $E8, $00, $21, $10 ; entry 8
    db $E8, $08, $22, $10 ; entry 9
    db $F0, $08, $23, $10 ; entry 10
    db $F0, $10, $24, $10 ; entry 11
    db $F8, $10, $20, $10 ; entry 12
    db $F8, $18, $21, $10 ; entry 13
    db $F8, $20, $22, $10 ; entry 14
    db $80 ; end

; E-0147 (derived: frame 15 of MetaSprites92_4024Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set38Frame15::
Data_092_6694:: ; address name
    db $D0, $20, $23, $30 ; entry 0
    db $D0, $18, $24, $30 ; entry 1
    db $D8, $18, $20, $30 ; entry 2
    db $D8, $10, $21, $30 ; entry 3
    db $D8, $08, $22, $30 ; entry 4
    db $E0, $08, $23, $30 ; entry 5
    db $E0, $00, $24, $30 ; entry 6
    db $E8, $00, $20, $30 ; entry 7
    db $E8, $F8, $21, $30 ; entry 8
    db $E8, $F0, $22, $30 ; entry 9
    db $F0, $F0, $23, $30 ; entry 10
    db $F0, $E8, $24, $30 ; entry 11
    db $F8, $E8, $20, $30 ; entry 12
    db $F8, $E0, $21, $30 ; entry 13
    db $F8, $D8, $22, $30 ; entry 14
    db $80 ; end

; E-0147 (derived: frame 16 of MetaSprites92_4024Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set38Frame16::
Data_092_66D1:: ; address name
    db $D0, $C0, $2B, $10 ; entry 0
    db $D0, $C8, $2C, $10 ; entry 1
    db $D0, $F0, $2F, $10 ; entry 2
    db $D8, $D0, $25, $10 ; entry 3
    db $D8, $F0, $27, $30 ; entry 4
    db $E0, $E0, $2B, $10 ; entry 5
    db $E0, $E8, $2C, $10 ; entry 6
    db $E0, $10, $2F, $10 ; entry 7
    db $E8, $F0, $25, $10 ; entry 8
    db $E8, $F8, $26, $10 ; entry 9
    db $E8, $10, $27, $10 ; entry 10
    db $E8, $18, $28, $10 ; entry 11
    db $F0, $00, $2B, $10 ; entry 12
    db $F0, $20, $2E, $10 ; entry 13
    db $F0, $28, $2F, $10 ; entry 14
    db $F8, $38, $28, $10 ; entry 15
    db $E0, $00, $2D, $10 ; entry 16
    db $E0, $08, $2E, $10 ; entry 17
    db $D0, $D8, $2D, $10 ; entry 18
    db $D0, $E8, $2E, $10 ; entry 19
    db $D8, $D8, $26, $10 ; entry 20
    db $D0, $D0, $27, $10 ; entry 21
    db $E0, $F8, $27, $10 ; entry 22
    db $F0, $08, $27, $10 ; entry 23
    db $D8, $E8, $27, $10 ; entry 24
    db $F0, $10, $29, $30 ; entry 25
    db $E8, $00, $29, $10 ; entry 26
    db $F8, $30, $27, $10 ; entry 27
    db $F8, $28, $29, $70 ; entry 28
    db $F8, $10, $25, $10 ; entry 29
    db $F8, $18, $26, $10 ; entry 30
    db $F8, $20, $27, $10 ; entry 31
    db $F0, $18, $16, $10 ; entry 32
    db $E0, $F0, $16, $10 ; entry 33
    db $D8, $E0, $16, $30 ; entry 34
    db $D0, $E0, $16, $70 ; entry 35
    db $D8, $F8, $2B, $70 ; entry 36
    db $E8, $08, $16, $10 ; entry 37
    db $80 ; end

; E-0147 (derived: frame 17 of MetaSprites92_4024Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set38Frame17::
Data_092_676A:: ; address name
    db $D0, $38, $2B, $30 ; entry 0
    db $D0, $30, $2C, $30 ; entry 1
    db $D0, $08, $2F, $30 ; entry 2
    db $D8, $28, $25, $30 ; entry 3
    db $D8, $08, $27, $10 ; entry 4
    db $E0, $18, $2B, $30 ; entry 5
    db $E0, $10, $2C, $30 ; entry 6
    db $E0, $E8, $2F, $30 ; entry 7
    db $E8, $08, $25, $30 ; entry 8
    db $E8, $00, $26, $30 ; entry 9
    db $E8, $E8, $27, $30 ; entry 10
    db $E8, $E0, $28, $30 ; entry 11
    db $F0, $F8, $2B, $30 ; entry 12
    db $F0, $D8, $2E, $30 ; entry 13
    db $F0, $D0, $2F, $30 ; entry 14
    db $F8, $C0, $28, $30 ; entry 15
    db $E0, $F8, $2D, $30 ; entry 16
    db $E0, $F0, $2E, $30 ; entry 17
    db $D0, $20, $2D, $30 ; entry 18
    db $D0, $10, $2E, $30 ; entry 19
    db $D8, $20, $26, $30 ; entry 20
    db $D0, $28, $27, $30 ; entry 21
    db $E0, $00, $27, $30 ; entry 22
    db $F0, $F0, $27, $30 ; entry 23
    db $D8, $10, $27, $30 ; entry 24
    db $F0, $E8, $29, $10 ; entry 25
    db $E8, $F8, $29, $30 ; entry 26
    db $F8, $C8, $27, $30 ; entry 27
    db $F8, $D0, $29, $50 ; entry 28
    db $F8, $E8, $25, $30 ; entry 29
    db $F8, $E0, $26, $30 ; entry 30
    db $F8, $D8, $27, $30 ; entry 31
    db $F0, $E0, $16, $30 ; entry 32
    db $E0, $08, $16, $30 ; entry 33
    db $D8, $18, $16, $10 ; entry 34
    db $D0, $18, $16, $50 ; entry 35
    db $D8, $00, $2B, $50 ; entry 36
    db $E8, $F0, $16, $30 ; entry 37
    db $80 ; end

; E-0147 (derived: frame 18 of MetaSprites92_4024Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set38Frame18::
Data_092_6803:: ; address name
    db $F0, $0C, $0F, $10 ; entry 0
    db $F0, $14, $10, $10 ; entry 1
    db $F0, $1C, $11, $10 ; entry 2
    db $F8, $1C, $12, $10 ; entry 3
    db $F8, $24, $13, $10 ; entry 4
    db $F8, $2C, $14, $10 ; entry 5
    db $E0, $EC, $0F, $10 ; entry 6
    db $E0, $F4, $10, $10 ; entry 7
    db $E0, $FC, $11, $10 ; entry 8
    db $E8, $FC, $12, $10 ; entry 9
    db $E8, $04, $13, $10 ; entry 10
    db $E8, $0C, $14, $10 ; entry 11
    db $D0, $CC, $0F, $10 ; entry 12
    db $D0, $D4, $10, $10 ; entry 13
    db $D0, $DC, $11, $10 ; entry 14
    db $D8, $DC, $12, $10 ; entry 15
    db $D8, $E4, $13, $10 ; entry 16
    db $D8, $EC, $14, $10 ; entry 17
    db $80 ; end

; E-0147 (derived: frame 19 of MetaSprites92_4024Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set38Frame19::
Data_092_684C:: ; address name
    db $F0, $EC, $0F, $30 ; entry 0
    db $F0, $E4, $10, $30 ; entry 1
    db $F0, $DC, $11, $30 ; entry 2
    db $F8, $DC, $12, $30 ; entry 3
    db $F8, $D4, $13, $30 ; entry 4
    db $F8, $CC, $14, $30 ; entry 5
    db $E0, $0C, $0F, $30 ; entry 6
    db $E0, $04, $10, $30 ; entry 7
    db $E0, $FC, $11, $30 ; entry 8
    db $E8, $FC, $12, $30 ; entry 9
    db $E8, $F4, $13, $30 ; entry 10
    db $E8, $EC, $14, $30 ; entry 11
    db $D0, $2C, $0F, $30 ; entry 12
    db $D0, $24, $10, $30 ; entry 13
    db $D0, $1C, $11, $30 ; entry 14
    db $D8, $1C, $12, $30 ; entry 15
    db $D8, $14, $13, $30 ; entry 16
    db $D8, $0C, $14, $30 ; entry 17
    db $80 ; end

; E-0147 (derived: frame 20 of MetaSprites92_4024Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set38Frame20::
Data_092_6895:: ; address name
    db $E8, $FC, $0F, $10 ; entry 0
    db $E8, $04, $10, $10 ; entry 1
    db $E8, $0C, $11, $10 ; entry 2
    db $F0, $0C, $12, $10 ; entry 3
    db $F0, $14, $13, $10 ; entry 4
    db $F0, $1C, $14, $10 ; entry 5
    db $F8, $1C, $0F, $10 ; entry 6
    db $F8, $24, $10, $10 ; entry 7
    db $F8, $2C, $11, $10 ; entry 8
    db $D8, $DC, $0F, $10 ; entry 9
    db $D8, $E4, $10, $10 ; entry 10
    db $D8, $EC, $11, $10 ; entry 11
    db $E0, $EC, $12, $10 ; entry 12
    db $E0, $F4, $13, $10 ; entry 13
    db $E0, $FC, $14, $10 ; entry 14
    db $D0, $CC, $12, $10 ; entry 15
    db $D0, $D4, $13, $10 ; entry 16
    db $D0, $DC, $14, $10 ; entry 17
    db $80 ; end

; E-0147 (derived: frame 21 of MetaSprites92_4024Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set38Frame21::
Data_092_68DE:: ; address name
    db $E8, $FC, $0F, $30 ; entry 0
    db $E8, $F4, $10, $30 ; entry 1
    db $E8, $EC, $11, $30 ; entry 2
    db $F0, $EC, $12, $30 ; entry 3
    db $F0, $E4, $13, $30 ; entry 4
    db $F0, $DC, $14, $30 ; entry 5
    db $F8, $DC, $0F, $30 ; entry 6
    db $F8, $D4, $10, $30 ; entry 7
    db $F8, $CC, $11, $30 ; entry 8
    db $D8, $1C, $0F, $30 ; entry 9
    db $D8, $14, $10, $30 ; entry 10
    db $D8, $0C, $11, $30 ; entry 11
    db $E0, $0C, $12, $30 ; entry 12
    db $E0, $04, $13, $30 ; entry 13
    db $E0, $FC, $14, $30 ; entry 14
    db $D0, $2C, $12, $30 ; entry 15
    db $D0, $24, $13, $30 ; entry 16
    db $D0, $1C, $14, $30 ; entry 17
    db $80 ; end

; E-0147 (derived: frame 22 of MetaSprites92_4024Set38; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set38Frame22::
    db $80 ; end

; E-0147 (derived: meta-sprite set 57 of MetaSprites92_4024Table: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites92_4024Set39::
Data_092_6928:: ; address name
    dw MetaSprites92_4024Set39Frame0 ; entry 0
    dw MetaSprites92_4024Set39Frame1 ; entry 1
    dw MetaSprites92_4024Set39Frame2 ; entry 2
    dw MetaSprites92_4024Set39Frame3 ; entry 3
    dw MetaSprites92_4024Set39Frame4 ; entry 4
    dw MetaSprites92_4024Set39Frame5 ; entry 5
    dw MetaSprites92_4024Set39Frame6 ; entry 6
    dw MetaSprites92_4024Set39Frame7 ; entry 7
    dw MetaSprites92_4024Set39Frame8 ; entry 8
    dw MetaSprites92_4024Set39Frame9 ; entry 9
    dw MetaSprites92_4024Set39Frame10 ; entry 10
    dw MetaSprites92_4024Set39Frame11 ; entry 11
    dw MetaSprites92_4024Set39Frame12 ; entry 12
    dw MetaSprites92_4024Set39Frame13 ; entry 13
    dw MetaSprites92_4024Set39Frame14 ; entry 14
    dw MetaSprites92_4024Set39Frame15 ; entry 15
    dw MetaSprites92_4024Set39Frame15 ; entry 16
    dw MetaSprites92_4024Set39Frame15 ; entry 17
    dw MetaSprites92_4024Set39Frame15 ; entry 18
    dw MetaSprites92_4024Set39Frame15 ; entry 19
    dw MetaSprites92_4024Set39Frame15 ; entry 20
    dw MetaSprites92_4024Set39Frame15 ; entry 21
    dw MetaSprites92_4024Set39Frame15 ; entry 22
    dw MetaSprites92_4024Set39Frame15 ; entry 23
    dw MetaSprites92_4024Set39Frame15 ; entry 24
    dw MetaSprites92_4024Set39Frame15 ; entry 25
    dw MetaSprites92_4024Set39Frame15 ; entry 26
    dw MetaSprites92_4024Set39Frame15 ; entry 27
    dw MetaSprites92_4024Set39Frame15 ; entry 28
    dw MetaSprites92_4024Set39Frame15 ; entry 29
    dw MetaSprites92_4024Set39Frame15 ; entry 30
    dw MetaSprites92_4024Set39Frame15 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites92_4024Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set39Frame0::
Data_092_6968:: ; address name
    db $F8, $C0, $00, $10 ; entry 0
    db $F0, $C0, $00, $10 ; entry 1
    db $E8, $C0, $00, $10 ; entry 2
    db $F8, $E0, $00, $10 ; entry 3
    db $F0, $E0, $00, $10 ; entry 4
    db $F8, $F0, $00, $10 ; entry 5
    db $F0, $F0, $00, $10 ; entry 6
    db $E8, $F0, $00, $10 ; entry 7
    db $E0, $F0, $00, $10 ; entry 8
    db $D8, $F0, $00, $10 ; entry 9
    db $F8, $00, $00, $10 ; entry 10
    db $F0, $00, $00, $10 ; entry 11
    db $E8, $00, $00, $10 ; entry 12
    db $F8, $20, $00, $10 ; entry 13
    db $F0, $20, $00, $10 ; entry 14
    db $E8, $20, $00, $10 ; entry 15
    db $E0, $20, $00, $10 ; entry 16
    db $D8, $20, $00, $10 ; entry 17
    db $F8, $30, $00, $10 ; entry 18
    db $F0, $30, $00, $10 ; entry 19
    db $E0, $00, $00, $10 ; entry 20
    db $D8, $00, $00, $10 ; entry 21
    db $D0, $00, $00, $10 ; entry 22
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites92_4024Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set39Frame1::
Data_092_69C5:: ; address name
    db $E8, $C0, $01, $10 ; entry 0
    db $E0, $C0, $01, $10 ; entry 1
    db $D0, $C0, $01, $10 ; entry 2
    db $D8, $C0, $01, $10 ; entry 3
    db $F8, $E0, $01, $10 ; entry 4
    db $F0, $E0, $01, $10 ; entry 5
    db $E8, $E0, $01, $10 ; entry 6
    db $E0, $E0, $01, $10 ; entry 7
    db $D0, $E0, $01, $10 ; entry 8
    db $D8, $E0, $01, $10 ; entry 9
    db $F8, $F0, $01, $10 ; entry 10
    db $F0, $F0, $01, $10 ; entry 11
    db $E8, $F0, $01, $10 ; entry 12
    db $E0, $F0, $01, $10 ; entry 13
    db $D0, $F0, $01, $10 ; entry 14
    db $D8, $F0, $01, $10 ; entry 15
    db $F8, $00, $01, $10 ; entry 16
    db $F0, $00, $01, $10 ; entry 17
    db $E8, $00, $01, $10 ; entry 18
    db $E0, $00, $01, $10 ; entry 19
    db $D0, $00, $01, $10 ; entry 20
    db $D8, $00, $01, $10 ; entry 21
    db $F8, $20, $01, $10 ; entry 22
    db $F0, $20, $01, $10 ; entry 23
    db $E8, $20, $01, $10 ; entry 24
    db $E0, $20, $01, $10 ; entry 25
    db $D0, $20, $01, $10 ; entry 26
    db $D8, $20, $01, $10 ; entry 27
    db $F8, $30, $01, $10 ; entry 28
    db $F0, $30, $01, $10 ; entry 29
    db $E8, $30, $01, $10 ; entry 30
    db $E0, $30, $01, $10 ; entry 31
    db $D0, $30, $01, $10 ; entry 32
    db $D8, $30, $01, $10 ; entry 33
    db $F8, $C0, $01, $10 ; entry 34
    db $F0, $C0, $01, $10 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites92_4024Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set39Frame2::
Data_092_6A56:: ; address name
    db $F0, $C8, $02, $10 ; entry 0
    db $E8, $C8, $02, $10 ; entry 1
    db $E0, $C8, $02, $10 ; entry 2
    db $D8, $C8, $02, $10 ; entry 3
    db $D0, $C8, $02, $10 ; entry 4
    db $F8, $D8, $02, $10 ; entry 5
    db $F0, $D8, $02, $10 ; entry 6
    db $E8, $D8, $02, $10 ; entry 7
    db $E0, $D8, $02, $10 ; entry 8
    db $D8, $D8, $02, $10 ; entry 9
    db $D0, $D8, $02, $10 ; entry 10
    db $F8, $F8, $02, $10 ; entry 11
    db $F0, $F8, $02, $10 ; entry 12
    db $E8, $F8, $02, $10 ; entry 13
    db $E0, $F8, $02, $10 ; entry 14
    db $D8, $F8, $02, $10 ; entry 15
    db $D0, $F8, $02, $10 ; entry 16
    db $F8, $08, $02, $10 ; entry 17
    db $F0, $08, $02, $10 ; entry 18
    db $E8, $08, $02, $10 ; entry 19
    db $E0, $08, $02, $10 ; entry 20
    db $D8, $08, $02, $10 ; entry 21
    db $D0, $08, $02, $10 ; entry 22
    db $F8, $18, $02, $10 ; entry 23
    db $F0, $18, $02, $10 ; entry 24
    db $E8, $18, $02, $10 ; entry 25
    db $E0, $18, $02, $10 ; entry 26
    db $D8, $18, $02, $10 ; entry 27
    db $D0, $18, $02, $10 ; entry 28
    db $F8, $38, $02, $10 ; entry 29
    db $F0, $38, $02, $10 ; entry 30
    db $E8, $38, $02, $10 ; entry 31
    db $E0, $38, $02, $10 ; entry 32
    db $D8, $38, $02, $10 ; entry 33
    db $D0, $38, $02, $10 ; entry 34
    db $F8, $C8, $02, $10 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites92_4024Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set39Frame3::
Data_092_6AE7:: ; address name
    db $F8, $BC, $02, $10 ; entry 0
    db $F0, $BC, $02, $10 ; entry 1
    db $E8, $BC, $02, $10 ; entry 2
    db $E0, $BC, $02, $10 ; entry 3
    db $D8, $BC, $02, $10 ; entry 4
    db $D0, $BC, $02, $10 ; entry 5
    db $F8, $DA, $02, $10 ; entry 6
    db $F0, $DA, $02, $10 ; entry 7
    db $E8, $DA, $02, $10 ; entry 8
    db $E0, $DA, $02, $10 ; entry 9
    db $D8, $DA, $02, $10 ; entry 10
    db $D0, $DA, $02, $10 ; entry 11
    db $F8, $F0, $02, $10 ; entry 12
    db $F0, $F0, $02, $10 ; entry 13
    db $E8, $F0, $02, $10 ; entry 14
    db $E0, $F0, $02, $10 ; entry 15
    db $D8, $F0, $02, $10 ; entry 16
    db $D0, $F0, $02, $10 ; entry 17
    db $F8, $FC, $02, $10 ; entry 18
    db $F0, $FC, $02, $10 ; entry 19
    db $E8, $FC, $02, $10 ; entry 20
    db $E0, $FC, $02, $10 ; entry 21
    db $D8, $FC, $02, $10 ; entry 22
    db $D0, $FC, $02, $10 ; entry 23
    db $F8, $20, $02, $10 ; entry 24
    db $F0, $20, $02, $10 ; entry 25
    db $E8, $20, $02, $10 ; entry 26
    db $E0, $20, $02, $10 ; entry 27
    db $D8, $20, $02, $10 ; entry 28
    db $D0, $20, $02, $10 ; entry 29
    db $F8, $40, $02, $10 ; entry 30
    db $F0, $40, $02, $10 ; entry 31
    db $E8, $40, $02, $10 ; entry 32
    db $E0, $40, $02, $10 ; entry 33
    db $D8, $40, $02, $10 ; entry 34
    db $D0, $40, $02, $10 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites92_4024Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set39Frame4::
Data_092_6B78:: ; address name
    db $F8, $26, $03, $10 ; entry 0
    db $F0, $26, $03, $10 ; entry 1
    db $E8, $26, $03, $10 ; entry 2
    db $E0, $26, $03, $10 ; entry 3
    db $D8, $26, $03, $10 ; entry 4
    db $D0, $26, $03, $10 ; entry 5
    db $F8, $F8, $03, $10 ; entry 6
    db $F0, $F8, $03, $10 ; entry 7
    db $E8, $F8, $03, $10 ; entry 8
    db $E0, $F8, $03, $10 ; entry 9
    db $D8, $F8, $03, $10 ; entry 10
    db $D0, $F8, $03, $10 ; entry 11
    db $F8, $B8, $03, $10 ; entry 12
    db $F0, $B8, $03, $10 ; entry 13
    db $E8, $B8, $03, $10 ; entry 14
    db $E0, $B8, $03, $10 ; entry 15
    db $D8, $B8, $03, $10 ; entry 16
    db $D0, $B8, $03, $10 ; entry 17
    db $F8, $C0, $03, $30 ; entry 18
    db $F0, $C0, $03, $30 ; entry 19
    db $E8, $C0, $03, $30 ; entry 20
    db $E0, $C0, $03, $30 ; entry 21
    db $D8, $C0, $03, $30 ; entry 22
    db $D0, $C0, $03, $30 ; entry 23
    db $F8, $00, $03, $30 ; entry 24
    db $F0, $00, $03, $30 ; entry 25
    db $E8, $00, $03, $30 ; entry 26
    db $E0, $00, $03, $30 ; entry 27
    db $D8, $00, $03, $30 ; entry 28
    db $D0, $00, $03, $30 ; entry 29
    db $F8, $2E, $03, $30 ; entry 30
    db $F0, $2E, $03, $30 ; entry 31
    db $E8, $2E, $03, $30 ; entry 32
    db $E0, $2E, $03, $30 ; entry 33
    db $D8, $2E, $03, $30 ; entry 34
    db $D0, $2E, $03, $30 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites92_4024Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set39Frame5::
Data_092_6C09:: ; address name
    db $F8, $D0, $03, $10 ; entry 0
    db $F0, $D0, $03, $10 ; entry 1
    db $E8, $D0, $03, $10 ; entry 2
    db $E0, $D0, $03, $10 ; entry 3
    db $D8, $D0, $03, $10 ; entry 4
    db $D0, $D0, $03, $10 ; entry 5
    db $F8, $D8, $03, $30 ; entry 6
    db $F0, $D8, $03, $30 ; entry 7
    db $E8, $D8, $03, $30 ; entry 8
    db $E0, $D8, $03, $30 ; entry 9
    db $D8, $D8, $03, $30 ; entry 10
    db $D0, $D8, $03, $30 ; entry 11
    db $F8, $3C, $03, $10 ; entry 12
    db $F0, $3C, $03, $10 ; entry 13
    db $E8, $3C, $03, $10 ; entry 14
    db $E0, $3C, $03, $10 ; entry 15
    db $D8, $3C, $03, $10 ; entry 16
    db $D0, $3C, $03, $10 ; entry 17
    db $F8, $44, $03, $30 ; entry 18
    db $F0, $44, $03, $30 ; entry 19
    db $E8, $44, $03, $30 ; entry 20
    db $E0, $44, $03, $30 ; entry 21
    db $D8, $44, $03, $30 ; entry 22
    db $D0, $44, $03, $30 ; entry 23
    db $F8, $10, $03, $10 ; entry 24
    db $F0, $10, $03, $10 ; entry 25
    db $E8, $10, $03, $10 ; entry 26
    db $E0, $10, $03, $10 ; entry 27
    db $D8, $10, $03, $10 ; entry 28
    db $D0, $10, $03, $10 ; entry 29
    db $F8, $18, $03, $30 ; entry 30
    db $F0, $18, $03, $30 ; entry 31
    db $E8, $18, $03, $30 ; entry 32
    db $E0, $18, $03, $30 ; entry 33
    db $D8, $18, $03, $30 ; entry 34
    db $D0, $18, $03, $30 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites92_4024Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set39Frame6::
Data_092_6C9A:: ; address name
    db $F8, $3C, $03, $30 ; entry 0
    db $F0, $3C, $03, $30 ; entry 1
    db $E8, $3C, $03, $30 ; entry 2
    db $E0, $3C, $03, $30 ; entry 3
    db $D8, $3C, $03, $30 ; entry 4
    db $D0, $3C, $03, $30 ; entry 5
    db $F8, $2C, $03, $10 ; entry 6
    db $F0, $2C, $03, $10 ; entry 7
    db $E8, $2C, $03, $10 ; entry 8
    db $E0, $2C, $03, $10 ; entry 9
    db $D8, $2C, $03, $10 ; entry 10
    db $D0, $2C, $03, $10 ; entry 11
    db $F8, $34, $04, $10 ; entry 12
    db $F0, $34, $04, $10 ; entry 13
    db $E8, $34, $04, $10 ; entry 14
    db $E0, $34, $04, $10 ; entry 15
    db $D8, $34, $04, $10 ; entry 16
    db $D0, $34, $04, $10 ; entry 17
    db $F8, $D0, $03, $30 ; entry 18
    db $F0, $D0, $03, $30 ; entry 19
    db $E8, $D0, $03, $30 ; entry 20
    db $E0, $D0, $03, $30 ; entry 21
    db $D8, $D0, $03, $30 ; entry 22
    db $D0, $D0, $03, $30 ; entry 23
    db $F8, $C0, $03, $10 ; entry 24
    db $F0, $C0, $03, $10 ; entry 25
    db $E8, $C0, $03, $10 ; entry 26
    db $E0, $C0, $03, $10 ; entry 27
    db $D8, $C0, $03, $10 ; entry 28
    db $D0, $C0, $03, $10 ; entry 29
    db $F8, $C8, $04, $10 ; entry 30
    db $F0, $C8, $04, $10 ; entry 31
    db $E8, $C8, $04, $10 ; entry 32
    db $E0, $C8, $04, $10 ; entry 33
    db $D8, $C8, $04, $10 ; entry 34
    db $D0, $C8, $04, $10 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites92_4024Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set39Frame7::
Data_092_6D2B:: ; address name
    db $F8, $20, $03, $30 ; entry 0
    db $F0, $20, $03, $30 ; entry 1
    db $E8, $20, $03, $30 ; entry 2
    db $E0, $20, $03, $30 ; entry 3
    db $D8, $20, $03, $30 ; entry 4
    db $D0, $20, $03, $30 ; entry 5
    db $F8, $10, $03, $10 ; entry 6
    db $F0, $10, $03, $10 ; entry 7
    db $E8, $10, $03, $10 ; entry 8
    db $E0, $10, $03, $10 ; entry 9
    db $D8, $10, $03, $10 ; entry 10
    db $D0, $10, $03, $10 ; entry 11
    db $F8, $18, $04, $10 ; entry 12
    db $F0, $18, $04, $10 ; entry 13
    db $E8, $18, $04, $10 ; entry 14
    db $E0, $18, $04, $10 ; entry 15
    db $D8, $18, $04, $10 ; entry 16
    db $D0, $18, $04, $10 ; entry 17
    db $F8, $F0, $03, $30 ; entry 18
    db $F0, $F0, $03, $30 ; entry 19
    db $E8, $F0, $03, $30 ; entry 20
    db $E0, $F0, $03, $30 ; entry 21
    db $D8, $F0, $03, $30 ; entry 22
    db $D0, $F0, $03, $30 ; entry 23
    db $F8, $E0, $03, $10 ; entry 24
    db $F0, $E0, $03, $10 ; entry 25
    db $E8, $E0, $03, $10 ; entry 26
    db $E0, $E0, $03, $10 ; entry 27
    db $D8, $E0, $03, $10 ; entry 28
    db $D0, $E0, $03, $10 ; entry 29
    db $F8, $E8, $04, $10 ; entry 30
    db $F0, $E8, $04, $10 ; entry 31
    db $E8, $E8, $04, $10 ; entry 32
    db $E0, $E8, $04, $10 ; entry 33
    db $D8, $E8, $04, $10 ; entry 34
    db $D0, $E8, $04, $10 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites92_4024Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set39Frame8::
Data_092_6DBC:: ; address name
    db $F8, $E8, $03, $10 ; entry 0
    db $F0, $E8, $03, $10 ; entry 1
    db $E8, $E8, $03, $10 ; entry 2
    db $E0, $E8, $03, $10 ; entry 3
    db $D8, $E8, $03, $10 ; entry 4
    db $D0, $E8, $03, $10 ; entry 5
    db $F8, $F0, $04, $10 ; entry 6
    db $F0, $F0, $04, $10 ; entry 7
    db $E8, $F0, $04, $10 ; entry 8
    db $E0, $F0, $04, $10 ; entry 9
    db $D8, $F0, $04, $10 ; entry 10
    db $D0, $F0, $04, $10 ; entry 11
    db $F8, $10, $03, $30 ; entry 12
    db $F0, $10, $03, $30 ; entry 13
    db $E8, $10, $03, $30 ; entry 14
    db $E0, $10, $03, $30 ; entry 15
    db $D8, $10, $03, $30 ; entry 16
    db $D0, $10, $03, $30 ; entry 17
    db $F8, $08, $04, $10 ; entry 18
    db $F0, $08, $04, $10 ; entry 19
    db $E8, $08, $04, $10 ; entry 20
    db $E0, $08, $04, $10 ; entry 21
    db $D8, $08, $04, $10 ; entry 22
    db $D0, $08, $04, $10 ; entry 23
    db $F8, $00, $04, $10 ; entry 24
    db $F0, $00, $04, $10 ; entry 25
    db $E8, $00, $04, $10 ; entry 26
    db $E0, $00, $04, $10 ; entry 27
    db $D8, $00, $04, $10 ; entry 28
    db $D0, $00, $04, $10 ; entry 29
    db $F8, $F8, $04, $10 ; entry 30
    db $F0, $F8, $04, $10 ; entry 31
    db $E8, $F8, $04, $10 ; entry 32
    db $E0, $F8, $04, $10 ; entry 33
    db $D8, $F8, $04, $10 ; entry 34
    db $D0, $F8, $04, $10 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites92_4024Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set39Frame9::
Data_092_6E4D:: ; address name
    db $E6, $04, $05, $10 ; entry 0
    db $E2, $F4, $05, $10 ; entry 1
    db $80 ; end

; E-0147 (derived: frame 10 of MetaSprites92_4024Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set39Frame10::
Data_092_6E56:: ; address name
    db $E2, $01, $08, $10 ; entry 0
    db $EA, $01, $09, $10 ; entry 1
    db $E2, $08, $08, $30 ; entry 2
    db $EA, $08, $09, $30 ; entry 3
    db $DE, $F0, $08, $10 ; entry 4
    db $E6, $F0, $09, $10 ; entry 5
    db $DE, $F7, $08, $30 ; entry 6
    db $E6, $F7, $09, $30 ; entry 7
    db $E0, $14, $05, $10 ; entry 8
    db $E8, $E4, $05, $10 ; entry 9
    db $80 ; end

; E-0147 (derived: frame 11 of MetaSprites92_4024Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set39Frame11::
Data_092_6E7F:: ; address name
    db $EA, $24, $05, $10 ; entry 0
    db $DE, $D4, $05, $10 ; entry 1
    db $DC, $11, $0A, $10 ; entry 2
    db $E4, $11, $0B, $10 ; entry 3
    db $DC, $18, $0A, $30 ; entry 4
    db $E4, $18, $0B, $30 ; entry 5
    db $E4, $E0, $0A, $10 ; entry 6
    db $EC, $E0, $0B, $10 ; entry 7
    db $E4, $E7, $0A, $30 ; entry 8
    db $EC, $E7, $0B, $30 ; entry 9
    db $80 ; end

; E-0147 (derived: frame 12 of MetaSprites92_4024Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set39Frame12::
Data_092_6EA8:: ; address name
    db $EE, $21, $08, $50 ; entry 0
    db $E6, $21, $09, $50 ; entry 1
    db $EE, $28, $08, $70 ; entry 2
    db $E6, $28, $09, $70 ; entry 3
    db $DA, $D7, $08, $30 ; entry 4
    db $E2, $D7, $09, $30 ; entry 5
    db $DA, $D0, $08, $10 ; entry 6
    db $E2, $D0, $09, $10 ; entry 7
    db $DC, $34, $05, $10 ; entry 8
    db $EC, $C4, $05, $10 ; entry 9
    db $80 ; end

; E-0147 (derived: frame 13 of MetaSprites92_4024Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set39Frame13::
Data_092_6ED1:: ; address name
    db $EE, $44, $05, $10 ; entry 0
    db $DA, $B4, $05, $10 ; entry 1
    db $D8, $31, $0A, $10 ; entry 2
    db $E0, $31, $0B, $10 ; entry 3
    db $D8, $38, $0A, $30 ; entry 4
    db $E0, $38, $0B, $30 ; entry 5
    db $E8, $C0, $0A, $10 ; entry 6
    db $F0, $C0, $0B, $10 ; entry 7
    db $E8, $C7, $0A, $30 ; entry 8
    db $F0, $C7, $0B, $30 ; entry 9
    db $80 ; end

; E-0147 (derived: frame 14 of MetaSprites92_4024Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set39Frame14::
Data_092_6EFA:: ; address name
    db $F2, $41, $08, $50 ; entry 0
    db $EA, $41, $09, $50 ; entry 1
    db $F2, $48, $08, $70 ; entry 2
    db $EA, $48, $09, $70 ; entry 3
    db $D6, $B7, $08, $30 ; entry 4
    db $DE, $B7, $09, $30 ; entry 5
    db $D6, $B0, $08, $10 ; entry 6
    db $DE, $B0, $09, $10 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 15 of MetaSprites92_4024Set39; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set39Frame15::
    db $80 ; end

; E-0147 (derived: meta-sprite set 58 of MetaSprites92_4024Table: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites92_4024Set3A::
Data_092_6F1C:: ; address name
    dw MetaSprites92_4024Set3AFrame0 ; entry 0
    dw MetaSprites92_4024Set3AFrame1 ; entry 1
    dw MetaSprites92_4024Set3AFrame2 ; entry 2
    dw MetaSprites92_4024Set3AFrame3 ; entry 3
    dw MetaSprites92_4024Set3AFrame4 ; entry 4
    dw MetaSprites92_4024Set3AFrame5 ; entry 5
    dw MetaSprites92_4024Set3AFrame6 ; entry 6
    dw MetaSprites92_4024Set3AFrame7 ; entry 7
    dw MetaSprites92_4024Set3AFrame8 ; entry 8
    dw MetaSprites92_4024Set3AFrame9 ; entry 9
    dw MetaSprites92_4024Set3AFrame10 ; entry 10
    dw MetaSprites92_4024Set3AFrame11 ; entry 11
    dw MetaSprites92_4024Set3AFrame12 ; entry 12
    dw MetaSprites92_4024Set3AFrame13 ; entry 13
    dw MetaSprites92_4024Set3AFrame14 ; entry 14
    dw MetaSprites92_4024Set3AFrame15 ; entry 15
    dw MetaSprites92_4024Set3AFrame16 ; entry 16
    dw MetaSprites92_4024Set3AFrame17 ; entry 17
    dw MetaSprites92_4024Set3AFrame18 ; entry 18
    dw MetaSprites92_4024Set3AFrame19 ; entry 19
    dw MetaSprites92_4024Set3AFrame20 ; entry 20
    dw MetaSprites92_4024Set3AFrame21 ; entry 21
    dw MetaSprites92_4024Set3AFrame22 ; entry 22
    dw MetaSprites92_4024Set3AFrame23 ; entry 23
    dw MetaSprites92_4024Set3AFrame24 ; entry 24
    dw MetaSprites92_4024Set3AFrame25 ; entry 25
    dw MetaSprites92_4024Set3AFrame26 ; entry 26
    dw MetaSprites92_4024Set3AFrame27 ; entry 27
    dw MetaSprites92_4024Set3AFrame27 ; entry 28
    dw MetaSprites92_4024Set3AFrame27 ; entry 29
    dw MetaSprites92_4024Set3AFrame27 ; entry 30
    dw MetaSprites92_4024Set3AFrame27 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites92_4024Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set3AFrame0::
Data_092_6F5C:: ; address name
    db $E4, $FC, $05, $10 ; entry 0
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites92_4024Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set3AFrame1::
Data_092_6F61:: ; address name
    db $E0, $F8, $06, $10 ; entry 0
    db $E0, $00, $06, $30 ; entry 1
    db $E8, $F8, $06, $50 ; entry 2
    db $E8, $00, $06, $70 ; entry 3
    db $EC, $EC, $05, $10 ; entry 4
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites92_4024Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set3AFrame2::
Data_092_6F76:: ; address name
    db $E0, $F8, $07, $10 ; entry 0
    db $E0, $00, $07, $30 ; entry 1
    db $E8, $F8, $07, $50 ; entry 2
    db $E8, $00, $07, $70 ; entry 3
    db $E8, $E8, $06, $10 ; entry 4
    db $E8, $F0, $06, $30 ; entry 5
    db $F0, $E8, $06, $50 ; entry 6
    db $F0, $F0, $06, $70 ; entry 7
    db $DC, $0C, $05, $10 ; entry 8
    db $D8, $EC, $05, $10 ; entry 9
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites92_4024Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set3AFrame3::
Data_092_6F9F:: ; address name
    db $E4, $F4, $0E, $10 ; entry 0
    db $E4, $FC, $0F, $10 ; entry 1
    db $DC, $F4, $0C, $10 ; entry 2
    db $DC, $FC, $0D, $10 ; entry 3
    db $E4, $04, $0E, $30 ; entry 4
    db $DC, $04, $0C, $30 ; entry 5
    db $EC, $F4, $0C, $50 ; entry 6
    db $EC, $FC, $0D, $50 ; entry 7
    db $EC, $04, $0C, $70 ; entry 8
    db $E8, $E8, $07, $10 ; entry 9
    db $E8, $F0, $07, $30 ; entry 10
    db $F0, $E8, $07, $50 ; entry 11
    db $F0, $F0, $07, $70 ; entry 12
    db $D8, $08, $06, $10 ; entry 13
    db $D8, $10, $06, $30 ; entry 14
    db $E0, $08, $06, $50 ; entry 15
    db $E0, $10, $06, $70 ; entry 16
    db $D4, $E8, $08, $10 ; entry 17
    db $DC, $E8, $09, $10 ; entry 18
    db $D4, $EF, $08, $30 ; entry 19
    db $DC, $EF, $09, $30 ; entry 20
    db $F0, $0C, $05, $10 ; entry 21
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites92_4024Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set3AFrame4::
Data_092_6FF8:: ; address name
    db $E0, $F0, $11, $10 ; entry 0
    db $E0, $F8, $12, $10 ; entry 1
    db $E0, $00, $13, $10 ; entry 2
    db $E0, $08, $14, $10 ; entry 3
    db $D8, $FA, $10, $10 ; entry 4
    db $E8, $08, $11, $70 ; entry 5
    db $E8, $00, $12, $70 ; entry 6
    db $E8, $F8, $13, $70 ; entry 7
    db $E8, $F0, $14, $70 ; entry 8
    db $F0, $FE, $10, $70 ; entry 9
    db $EC, $E4, $0E, $10 ; entry 10
    db $EC, $EC, $0F, $10 ; entry 11
    db $E4, $E4, $0C, $10 ; entry 12
    db $E4, $EC, $0D, $10 ; entry 13
    db $EC, $F4, $0E, $30 ; entry 14
    db $E4, $F4, $0C, $30 ; entry 15
    db $F4, $E4, $0C, $50 ; entry 16
    db $F4, $EC, $0D, $50 ; entry 17
    db $F4, $F4, $0C, $70 ; entry 18
    db $D8, $08, $07, $10 ; entry 19
    db $D8, $10, $07, $30 ; entry 20
    db $E0, $08, $07, $50 ; entry 21
    db $E0, $10, $07, $70 ; entry 22
    db $D4, $E0, $05, $10 ; entry 23
    db $D4, $E8, $0A, $10 ; entry 24
    db $DC, $E8, $0B, $10 ; entry 25
    db $D4, $EF, $0A, $30 ; entry 26
    db $DC, $EF, $0B, $30 ; entry 27
    db $EC, $08, $08, $10 ; entry 28
    db $F4, $08, $09, $10 ; entry 29
    db $EC, $0F, $08, $30 ; entry 30
    db $F4, $0F, $09, $30 ; entry 31
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites92_4024Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set3AFrame5::
Data_092_7079:: ; address name
    db $E8, $E0, $11, $10 ; entry 0
    db $E8, $E8, $12, $10 ; entry 1
    db $E8, $F0, $13, $10 ; entry 2
    db $E8, $F8, $14, $10 ; entry 3
    db $E0, $EA, $10, $10 ; entry 4
    db $F0, $F8, $11, $70 ; entry 5
    db $F0, $F0, $12, $70 ; entry 6
    db $F0, $E8, $13, $70 ; entry 7
    db $F0, $E0, $14, $70 ; entry 8
    db $F8, $EE, $10, $70 ; entry 9
    db $DC, $04, $0E, $10 ; entry 10
    db $DC, $0C, $0F, $10 ; entry 11
    db $D4, $04, $0C, $10 ; entry 12
    db $D4, $0C, $0D, $10 ; entry 13
    db $DC, $14, $0E, $30 ; entry 14
    db $D4, $14, $0C, $30 ; entry 15
    db $E4, $04, $0C, $50 ; entry 16
    db $E4, $0C, $0D, $50 ; entry 17
    db $E4, $14, $0C, $70 ; entry 18
    db $D0, $DC, $06, $10 ; entry 19
    db $D0, $E4, $06, $30 ; entry 20
    db $D8, $DC, $06, $50 ; entry 21
    db $D8, $E4, $06, $70 ; entry 22
    db $F4, $18, $05, $10 ; entry 23
    db $F4, $DC, $05, $10 ; entry 24
    db $EC, $08, $0A, $10 ; entry 25
    db $F4, $08, $0B, $10 ; entry 26
    db $EC, $0F, $0A, $30 ; entry 27
    db $F4, $0F, $0B, $30 ; entry 28
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites92_4024Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set3AFrame6::
Data_092_70EE:: ; address name
    db $E0, $00, $11, $50 ; entry 0
    db $E0, $08, $12, $50 ; entry 1
    db $E0, $10, $13, $50 ; entry 2
    db $E0, $18, $14, $50 ; entry 3
    db $E8, $0A, $10, $50 ; entry 4
    db $D8, $18, $11, $30 ; entry 5
    db $D8, $10, $12, $30 ; entry 6
    db $D8, $08, $13, $30 ; entry 7
    db $D8, $00, $14, $30 ; entry 8
    db $D0, $0E, $10, $30 ; entry 9
    db $D0, $DC, $07, $10 ; entry 10
    db $D0, $E4, $07, $30 ; entry 11
    db $D8, $DC, $07, $50 ; entry 12
    db $D8, $E4, $07, $70 ; entry 13
    db $EC, $D4, $05, $10 ; entry 14
    db $F0, $14, $06, $10 ; entry 15
    db $F0, $1C, $06, $30 ; entry 16
    db $F8, $14, $06, $50 ; entry 17
    db $F8, $1C, $06, $70 ; entry 18
    db $F0, $D8, $08, $10 ; entry 19
    db $F8, $D8, $09, $10 ; entry 20
    db $F0, $DF, $08, $30 ; entry 21
    db $F8, $DF, $09, $30 ; entry 22
    db $D4, $1C, $05, $10 ; entry 23
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites92_4024Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set3AFrame7::
Data_092_714F:: ; address name
    db $D4, $D8, $0E, $10 ; entry 0
    db $D4, $E0, $0F, $10 ; entry 1
    db $D4, $E8, $0E, $30 ; entry 2
    db $DC, $D8, $0C, $50 ; entry 3
    db $DC, $E0, $0D, $50 ; entry 4
    db $DC, $E8, $0C, $70 ; entry 5
    db $CC, $D8, $15, $10 ; entry 6
    db $CC, $E0, $16, $10 ; entry 7
    db $CC, $E8, $15, $30 ; entry 8
    db $E8, $D0, $06, $10 ; entry 9
    db $E8, $D8, $06, $30 ; entry 10
    db $F0, $D0, $06, $50 ; entry 11
    db $F0, $D8, $06, $70 ; entry 12
    db $F0, $14, $07, $10 ; entry 13
    db $F0, $1C, $07, $30 ; entry 14
    db $F8, $14, $07, $50 ; entry 15
    db $F8, $1C, $07, $70 ; entry 16
    db $DC, $24, $05, $10 ; entry 17
    db $F0, $D8, $0A, $10 ; entry 18
    db $F8, $D8, $0B, $10 ; entry 19
    db $F0, $DF, $0A, $30 ; entry 20
    db $F8, $DF, $0B, $30 ; entry 21
    db $D0, $18, $08, $10 ; entry 22
    db $D8, $18, $09, $10 ; entry 23
    db $D0, $1F, $08, $30 ; entry 24
    db $D8, $1F, $09, $30 ; entry 25
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites92_4024Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set3AFrame8::
Data_092_71B8:: ; address name
    db $D0, $EC, $11, $30 ; entry 0
    db $D0, $E4, $12, $30 ; entry 1
    db $D0, $DC, $13, $30 ; entry 2
    db $D0, $D4, $14, $30 ; entry 3
    db $D8, $D4, $11, $50 ; entry 4
    db $D8, $DC, $12, $50 ; entry 5
    db $D8, $E4, $13, $50 ; entry 6
    db $D8, $EC, $14, $50 ; entry 7
    db $E0, $DE, $10, $50 ; entry 8
    db $E8, $D0, $07, $10 ; entry 9
    db $E8, $D8, $07, $30 ; entry 10
    db $F0, $D0, $07, $50 ; entry 11
    db $F0, $D8, $07, $70 ; entry 12
    db $DC, $C0, $05, $10 ; entry 13
    db $F4, $10, $0E, $50 ; entry 14
    db $F4, $18, $0F, $50 ; entry 15
    db $F4, $20, $0E, $70 ; entry 16
    db $EC, $10, $0C, $10 ; entry 17
    db $EC, $18, $0D, $10 ; entry 18
    db $EC, $20, $0C, $30 ; entry 19
    db $FC, $10, $15, $50 ; entry 20
    db $FC, $18, $16, $50 ; entry 21
    db $FC, $20, $15, $70 ; entry 22
    db $D8, $20, $06, $10 ; entry 23
    db $D8, $28, $06, $30 ; entry 24
    db $E0, $20, $06, $50 ; entry 25
    db $E0, $28, $06, $70 ; entry 26
    db $D4, $CC, $05, $10 ; entry 27
    db $D0, $18, $0A, $10 ; entry 28
    db $D8, $18, $0B, $10 ; entry 29
    db $D0, $1F, $0A, $30 ; entry 30
    db $D8, $1F, $0B, $30 ; entry 31
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites92_4024Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set3AFrame9::
Data_092_7239:: ; address name
    db $EC, $CC, $0E, $10 ; entry 0
    db $EC, $D4, $0F, $10 ; entry 1
    db $E4, $CC, $0C, $10 ; entry 2
    db $E4, $D4, $0D, $10 ; entry 3
    db $EC, $DC, $0E, $30 ; entry 4
    db $E4, $DC, $0C, $30 ; entry 5
    db $F4, $CC, $0C, $50 ; entry 6
    db $F4, $D4, $0D, $50 ; entry 7
    db $F4, $DC, $0C, $70 ; entry 8
    db $D8, $BC, $06, $10 ; entry 9
    db $D8, $C4, $06, $30 ; entry 10
    db $E0, $BC, $06, $50 ; entry 11
    db $E0, $C4, $06, $70 ; entry 12
    db $F8, $0C, $11, $50 ; entry 13
    db $F8, $14, $12, $50 ; entry 14
    db $F8, $1C, $13, $50 ; entry 15
    db $F8, $24, $14, $50 ; entry 16
    db $F0, $24, $11, $30 ; entry 17
    db $F0, $1C, $12, $30 ; entry 18
    db $F0, $14, $13, $30 ; entry 19
    db $F0, $0C, $14, $30 ; entry 20
    db $E8, $1A, $10, $30 ; entry 21
    db $D8, $20, $07, $10 ; entry 22
    db $D8, $28, $07, $30 ; entry 23
    db $E0, $20, $07, $50 ; entry 24
    db $E0, $28, $07, $70 ; entry 25
    db $EC, $38, $05, $10 ; entry 26
    db $D0, $C8, $08, $10 ; entry 27
    db $D8, $C8, $09, $10 ; entry 28
    db $D0, $CF, $08, $30 ; entry 29
    db $D8, $CF, $09, $30 ; entry 30
    db $F4, $2C, $05, $10 ; entry 31
    db $80 ; end

; E-0147 (derived: frame 10 of MetaSprites92_4024Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set3AFrame10::
Data_092_72BA:: ; address name
    db $E8, $C8, $11, $10 ; entry 0
    db $E8, $D0, $12, $10 ; entry 1
    db $E8, $D8, $13, $10 ; entry 2
    db $E8, $E0, $14, $10 ; entry 3
    db $E0, $D2, $10, $10 ; entry 4
    db $F0, $E0, $11, $70 ; entry 5
    db $F0, $D8, $12, $70 ; entry 6
    db $F0, $D0, $13, $70 ; entry 7
    db $F0, $C8, $14, $70 ; entry 8
    db $F8, $D6, $10, $70 ; entry 9
    db $D8, $BC, $07, $10 ; entry 10
    db $D8, $C4, $07, $30 ; entry 11
    db $E0, $BC, $07, $50 ; entry 12
    db $E0, $C4, $07, $70 ; entry 13
    db $F0, $AC, $05, $10 ; entry 14
    db $DC, $1C, $0E, $10 ; entry 15
    db $DC, $24, $0F, $10 ; entry 16
    db $D4, $1C, $0C, $10 ; entry 17
    db $D4, $24, $0D, $10 ; entry 18
    db $DC, $2C, $0E, $30 ; entry 19
    db $D4, $2C, $0C, $30 ; entry 20
    db $E4, $1C, $0C, $50 ; entry 21
    db $E4, $24, $0D, $50 ; entry 22
    db $E4, $2C, $0C, $70 ; entry 23
    db $E8, $34, $06, $10 ; entry 24
    db $E8, $3C, $06, $30 ; entry 25
    db $F0, $34, $06, $50 ; entry 26
    db $F0, $3C, $06, $70 ; entry 27
    db $D0, $C8, $0A, $10 ; entry 28
    db $D8, $C8, $0B, $10 ; entry 29
    db $D0, $CF, $0A, $30 ; entry 30
    db $D8, $CF, $0B, $30 ; entry 31
    db $F0, $28, $08, $10 ; entry 32
    db $F8, $28, $09, $10 ; entry 33
    db $F0, $2F, $08, $30 ; entry 34
    db $F8, $2F, $09, $30 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 11 of MetaSprites92_4024Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set3AFrame11::
Data_092_734B:: ; address name
    db $DC, $B8, $0E, $10 ; entry 0
    db $DC, $C0, $0F, $10 ; entry 1
    db $D4, $B8, $0C, $10 ; entry 2
    db $D4, $C0, $0D, $10 ; entry 3
    db $DC, $C8, $0E, $30 ; entry 4
    db $D4, $C8, $0C, $30 ; entry 5
    db $E4, $B8, $0C, $50 ; entry 6
    db $E4, $C0, $0D, $50 ; entry 7
    db $E4, $C8, $0C, $70 ; entry 8
    db $EC, $B0, $06, $30 ; entry 9
    db $F4, $B0, $06, $70 ; entry 10
    db $E0, $18, $11, $50 ; entry 11
    db $E0, $20, $12, $50 ; entry 12
    db $E0, $28, $13, $50 ; entry 13
    db $E0, $30, $14, $50 ; entry 14
    db $E8, $22, $10, $50 ; entry 15
    db $D8, $30, $11, $30 ; entry 16
    db $D8, $28, $12, $30 ; entry 17
    db $D8, $20, $13, $30 ; entry 18
    db $D8, $18, $14, $30 ; entry 19
    db $D0, $26, $10, $30 ; entry 20
    db $E8, $34, $07, $10 ; entry 21
    db $E8, $3C, $07, $30 ; entry 22
    db $F0, $34, $07, $50 ; entry 23
    db $F0, $3C, $07, $70 ; entry 24
    db $D8, $4C, $05, $10 ; entry 25
    db $F4, $BC, $05, $10 ; entry 26
    db $F0, $28, $0A, $10 ; entry 27
    db $F8, $28, $0B, $10 ; entry 28
    db $F0, $2F, $0A, $30 ; entry 29
    db $F8, $2F, $0B, $30 ; entry 30
    db $80 ; end

; E-0147 (derived: frame 12 of MetaSprites92_4024Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set3AFrame12::
Data_092_73C8:: ; address name
    db $D8, $CC, $11, $30 ; entry 0
    db $D8, $C4, $12, $30 ; entry 1
    db $D8, $BC, $13, $30 ; entry 2
    db $D8, $B4, $14, $30 ; entry 3
    db $D0, $C2, $10, $30 ; entry 4
    db $E0, $B4, $11, $50 ; entry 5
    db $E0, $BC, $12, $50 ; entry 6
    db $E0, $C4, $13, $50 ; entry 7
    db $E0, $CC, $14, $50 ; entry 8
    db $E8, $BE, $10, $50 ; entry 9
    db $EC, $B0, $07, $30 ; entry 10
    db $F4, $B0, $07, $70 ; entry 11
    db $EC, $30, $0E, $10 ; entry 12
    db $EC, $38, $0F, $10 ; entry 13
    db $E4, $30, $0C, $10 ; entry 14
    db $E4, $38, $0D, $10 ; entry 15
    db $EC, $40, $0E, $30 ; entry 16
    db $E4, $40, $0C, $30 ; entry 17
    db $F4, $30, $0C, $50 ; entry 18
    db $F4, $38, $0D, $50 ; entry 19
    db $F4, $40, $0C, $70 ; entry 20
    db $D4, $48, $06, $10 ; entry 21
    db $DC, $48, $06, $50 ; entry 22
    db $F0, $B8, $08, $10 ; entry 23
    db $F8, $B8, $09, $10 ; entry 24
    db $F0, $BF, $08, $30 ; entry 25
    db $F8, $BF, $09, $30 ; entry 26
    db $D4, $3C, $05, $10 ; entry 27
    db $80 ; end

; E-0147 (derived: frame 13 of MetaSprites92_4024Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set3AFrame13::
Data_092_7439:: ; address name
    db $F0, $AC, $0F, $10 ; entry 0
    db $E8, $AC, $0D, $10 ; entry 1
    db $F0, $B4, $0E, $30 ; entry 2
    db $E8, $B4, $0C, $30 ; entry 3
    db $F8, $AC, $0D, $50 ; entry 4
    db $F8, $B4, $0C, $70 ; entry 5
    db $F0, $2C, $11, $50 ; entry 6
    db $F0, $34, $12, $50 ; entry 7
    db $F0, $3C, $13, $50 ; entry 8
    db $F0, $44, $14, $50 ; entry 9
    db $F8, $36, $10, $50 ; entry 10
    db $E8, $44, $11, $30 ; entry 11
    db $E8, $3C, $12, $30 ; entry 12
    db $E8, $34, $13, $30 ; entry 13
    db $E8, $2C, $14, $30 ; entry 14
    db $E0, $3A, $10, $30 ; entry 15
    db $F0, $B8, $0A, $10 ; entry 16
    db $F8, $B8, $0B, $10 ; entry 17
    db $F0, $BF, $0A, $30 ; entry 18
    db $F8, $BF, $0B, $30 ; entry 19
    db $D4, $48, $07, $10 ; entry 20
    db $DC, $48, $07, $50 ; entry 21
    db $D0, $38, $08, $10 ; entry 22
    db $D8, $38, $09, $10 ; entry 23
    db $D0, $3F, $08, $30 ; entry 24
    db $D8, $3F, $09, $30 ; entry 25
    db $80 ; end

; E-0147 (derived: frame 14 of MetaSprites92_4024Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set3AFrame14::
Data_092_74A2:: ; address name
    db $EC, $B0, $13, $10 ; entry 0
    db $EC, $B8, $14, $10 ; entry 1
    db $F4, $B8, $11, $70 ; entry 2
    db $F4, $B0, $12, $70 ; entry 3
    db $FC, $AE, $10, $70 ; entry 4
    db $D8, $4C, $0F, $30 ; entry 5
    db $D0, $4C, $0D, $30 ; entry 6
    db $D8, $44, $0E, $10 ; entry 7
    db $D0, $44, $0C, $10 ; entry 8
    db $E0, $4C, $0D, $70 ; entry 9
    db $E0, $44, $0C, $50 ; entry 10
    db $D0, $38, $0A, $10 ; entry 11
    db $D8, $38, $0B, $10 ; entry 12
    db $D0, $3F, $0A, $30 ; entry 13
    db $D8, $3F, $0B, $30 ; entry 14
    db $80 ; end

; E-0147 (derived: frame 15 of MetaSprites92_4024Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set3AFrame15::
Data_092_74DF:: ; address name
    db $DC, $48, $13, $70 ; entry 0
    db $DC, $40, $14, $70 ; entry 1
    db $D4, $40, $11, $10 ; entry 2
    db $D4, $48, $12, $10 ; entry 3
    db $CC, $4A, $10, $10 ; entry 4
    db $80 ; end

; E-0147 (derived: frame 16 of MetaSprites92_4024Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set3AFrame16::
Data_092_74F4:: ; address name
    db $DC, $0C, $05, $10 ; entry 0
    db $80 ; end

; E-0147 (derived: frame 17 of MetaSprites92_4024Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set3AFrame17::
Data_092_74F9:: ; address name
    db $E0, $10, $07, $70 ; entry 0
    db $E0, $08, $07, $50 ; entry 1
    db $D8, $08, $07, $10 ; entry 2
    db $D8, $10, $07, $30 ; entry 3
    db $F8, $E4, $22, $50 ; entry 4
    db $80 ; end

; E-0147 (derived: frame 18 of MetaSprites92_4024Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set3AFrame18::
Data_092_750E:: ; address name
    db $E8, $00, $17, $50 ; entry 0
    db $E8, $08, $18, $50 ; entry 1
    db $E8, $18, $17, $70 ; entry 2
    db $E8, $10, $18, $70 ; entry 3
    db $E0, $00, $19, $50 ; entry 4
    db $E0, $08, $1A, $50 ; entry 5
    db $E0, $18, $19, $70 ; entry 6
    db $E0, $10, $1A, $70 ; entry 7
    db $D0, $00, $17, $10 ; entry 8
    db $D0, $08, $18, $10 ; entry 9
    db $D0, $18, $17, $30 ; entry 10
    db $D0, $10, $18, $30 ; entry 11
    db $D8, $00, $19, $10 ; entry 12
    db $D8, $08, $1A, $10 ; entry 13
    db $D8, $18, $19, $30 ; entry 14
    db $D8, $10, $1A, $30 ; entry 15
    db $F8, $E0, $07, $10 ; entry 16
    db $F8, $E8, $07, $30 ; entry 17
    db $80 ; end

; E-0147 (derived: frame 19 of MetaSprites92_4024Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set3AFrame19::
Data_092_7557:: ; address name
    db $F0, $00, $1B, $50 ; entry 0
    db $F0, $08, $1C, $50 ; entry 1
    db $E8, $F8, $1D, $50 ; entry 2
    db $E8, $00, $1E, $50 ; entry 3
    db $E8, $08, $1F, $50 ; entry 4
    db $E0, $F8, $20, $50 ; entry 5
    db $E0, $00, $21, $50 ; entry 6
    db $E0, $08, $1A, $70 ; entry 7
    db $F0, $18, $1B, $70 ; entry 8
    db $F0, $10, $1C, $70 ; entry 9
    db $E8, $20, $1D, $70 ; entry 10
    db $E8, $18, $1E, $70 ; entry 11
    db $E8, $10, $1F, $70 ; entry 12
    db $E0, $20, $20, $70 ; entry 13
    db $E0, $18, $21, $70 ; entry 14
    db $E0, $10, $1A, $50 ; entry 15
    db $D0, $F8, $1D, $10 ; entry 16
    db $D0, $00, $1E, $10 ; entry 17
    db $D0, $08, $1F, $10 ; entry 18
    db $D8, $F8, $20, $10 ; entry 19
    db $D8, $00, $21, $10 ; entry 20
    db $D8, $08, $1A, $30 ; entry 21
    db $D0, $20, $1D, $30 ; entry 22
    db $D0, $18, $1E, $30 ; entry 23
    db $D0, $10, $1F, $30 ; entry 24
    db $D8, $20, $20, $30 ; entry 25
    db $D8, $18, $21, $30 ; entry 26
    db $D8, $10, $1A, $10 ; entry 27
    db $F0, $D8, $17, $10 ; entry 28
    db $F0, $E0, $18, $10 ; entry 29
    db $F0, $F0, $17, $30 ; entry 30
    db $F0, $E8, $18, $30 ; entry 31
    db $F8, $D8, $19, $10 ; entry 32
    db $F8, $E0, $1A, $10 ; entry 33
    db $F8, $F0, $19, $30 ; entry 34
    db $F8, $E8, $1A, $30 ; entry 35
    db $F4, $24, $05, $50 ; entry 36
    db $80 ; end

; E-0147 (derived: frame 20 of MetaSprites92_4024Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set3AFrame20::
Data_092_75EC:: ; address name
    db $E8, $D8, $1B, $10 ; entry 0
    db $E8, $E0, $1C, $10 ; entry 1
    db $F0, $D0, $1D, $10 ; entry 2
    db $F0, $D8, $1E, $10 ; entry 3
    db $F0, $E0, $1F, $10 ; entry 4
    db $F8, $D0, $20, $10 ; entry 5
    db $F8, $D8, $21, $10 ; entry 6
    db $F8, $E0, $1A, $30 ; entry 7
    db $E8, $F0, $1B, $30 ; entry 8
    db $E8, $E8, $1C, $30 ; entry 9
    db $F0, $F8, $1D, $30 ; entry 10
    db $F0, $F0, $1E, $30 ; entry 11
    db $F0, $E8, $1F, $30 ; entry 12
    db $F8, $F8, $20, $30 ; entry 13
    db $F8, $F0, $21, $30 ; entry 14
    db $F8, $E8, $1A, $10 ; entry 15
    db $F8, $20, $07, $50 ; entry 16
    db $F8, $28, $07, $70 ; entry 17
    db $F0, $20, $07, $10 ; entry 18
    db $F0, $28, $07, $30 ; entry 19
    db $DC, $D4, $05, $50 ; entry 20
    db $80 ; end

; E-0147 (derived: frame 21 of MetaSprites92_4024Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set3AFrame21::
Data_092_7641:: ; address name
    db $E8, $18, $17, $10 ; entry 0
    db $E8, $20, $18, $10 ; entry 1
    db $F0, $18, $19, $10 ; entry 2
    db $F0, $20, $1A, $10 ; entry 3
    db $E8, $30, $17, $30 ; entry 4
    db $E8, $28, $18, $30 ; entry 5
    db $F0, $30, $19, $30 ; entry 6
    db $F0, $28, $1A, $30 ; entry 7
    db $F8, $18, $19, $50 ; entry 8
    db $F8, $20, $1A, $50 ; entry 9
    db $F8, $30, $19, $70 ; entry 10
    db $F8, $28, $1A, $70 ; entry 11
    db $E0, $D0, $07, $50 ; entry 12
    db $E0, $D8, $07, $70 ; entry 13
    db $D8, $D0, $07, $10 ; entry 14
    db $D8, $D8, $07, $30 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 22 of MetaSprites92_4024Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set3AFrame22::
Data_092_7682:: ; address name
    db $E0, $18, $1B, $10 ; entry 0
    db $E0, $20, $1C, $10 ; entry 1
    db $E8, $10, $1D, $10 ; entry 2
    db $E8, $18, $1E, $10 ; entry 3
    db $E8, $20, $1F, $10 ; entry 4
    db $F0, $10, $20, $10 ; entry 5
    db $F0, $18, $21, $10 ; entry 6
    db $F0, $20, $04, $10 ; entry 7
    db $F8, $10, $20, $50 ; entry 8
    db $F8, $18, $21, $50 ; entry 9
    db $F8, $20, $04, $50 ; entry 10
    db $E8, $38, $1D, $30 ; entry 11
    db $E8, $30, $1E, $30 ; entry 12
    db $E8, $28, $1F, $30 ; entry 13
    db $F0, $38, $20, $30 ; entry 14
    db $F0, $30, $21, $30 ; entry 15
    db $F0, $28, $04, $30 ; entry 16
    db $F8, $38, $20, $70 ; entry 17
    db $F8, $30, $21, $70 ; entry 18
    db $F8, $28, $04, $70 ; entry 19
    db $E0, $30, $1B, $30 ; entry 20
    db $E0, $28, $1C, $30 ; entry 21
    db $E8, $C8, $17, $50 ; entry 22
    db $E8, $D0, $18, $50 ; entry 23
    db $E0, $C8, $19, $50 ; entry 24
    db $E0, $D0, $1A, $50 ; entry 25
    db $E8, $E0, $17, $70 ; entry 26
    db $E8, $D8, $18, $70 ; entry 27
    db $E0, $E0, $19, $70 ; entry 28
    db $E0, $D8, $1A, $70 ; entry 29
    db $D8, $C8, $19, $10 ; entry 30
    db $D8, $D0, $1A, $10 ; entry 31
    db $D8, $E0, $19, $30 ; entry 32
    db $D8, $D8, $1A, $30 ; entry 33
    db $D0, $C8, $17, $10 ; entry 34
    db $D0, $D0, $18, $10 ; entry 35
    db $D0, $E0, $17, $30 ; entry 36
    db $D0, $D8, $18, $30 ; entry 37
    db $D4, $3C, $05, $10 ; entry 38
    db $80 ; end

; E-0147 (derived: frame 23 of MetaSprites92_4024Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set3AFrame23::
Data_092_771F:: ; address name
    db $F0, $C8, $1B, $50 ; entry 0
    db $F0, $D0, $1C, $50 ; entry 1
    db $E8, $C0, $1D, $50 ; entry 2
    db $E8, $C8, $1E, $50 ; entry 3
    db $E8, $D0, $1F, $50 ; entry 4
    db $E0, $C0, $20, $50 ; entry 5
    db $E0, $C8, $21, $50 ; entry 6
    db $E0, $D0, $04, $50 ; entry 7
    db $D8, $C0, $20, $10 ; entry 8
    db $D8, $C8, $21, $10 ; entry 9
    db $D8, $D0, $04, $10 ; entry 10
    db $E8, $E8, $1D, $70 ; entry 11
    db $E8, $E0, $1E, $70 ; entry 12
    db $E8, $D8, $1F, $70 ; entry 13
    db $E0, $E8, $20, $70 ; entry 14
    db $E0, $E0, $21, $70 ; entry 15
    db $E0, $D8, $04, $70 ; entry 16
    db $D8, $E8, $20, $30 ; entry 17
    db $D8, $E0, $21, $30 ; entry 18
    db $D8, $D8, $04, $30 ; entry 19
    db $F0, $E0, $1B, $70 ; entry 20
    db $F0, $D8, $1C, $70 ; entry 21
    db $D0, $C0, $1D, $10 ; entry 22
    db $D0, $C8, $1E, $10 ; entry 23
    db $D0, $D0, $1F, $10 ; entry 24
    db $D0, $E8, $1D, $30 ; entry 25
    db $D0, $E0, $1E, $30 ; entry 26
    db $D0, $D8, $1F, $30 ; entry 27
    db $D0, $38, $07, $10 ; entry 28
    db $D0, $40, $07, $30 ; entry 29
    db $D8, $38, $07, $50 ; entry 30
    db $D8, $40, $07, $70 ; entry 31
    db $EC, $BC, $05, $10 ; entry 32
    db $80 ; end

; E-0147 (derived: frame 24 of MetaSprites92_4024Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set3AFrame24::
Data_092_77A4:: ; address name
    db $E0, $30, $17, $50 ; entry 0
    db $E0, $38, $18, $50 ; entry 1
    db $D8, $30, $19, $50 ; entry 2
    db $D8, $38, $1A, $50 ; entry 3
    db $D0, $30, $19, $10 ; entry 4
    db $D0, $38, $1A, $10 ; entry 5
    db $E0, $48, $17, $70 ; entry 6
    db $E0, $40, $18, $70 ; entry 7
    db $D8, $48, $19, $70 ; entry 8
    db $D8, $40, $1A, $70 ; entry 9
    db $D0, $48, $19, $30 ; entry 10
    db $D0, $40, $1A, $30 ; entry 11
    db $F0, $B8, $07, $50 ; entry 12
    db $F0, $C0, $07, $70 ; entry 13
    db $E8, $B8, $07, $10 ; entry 14
    db $E8, $C0, $07, $30 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 25 of MetaSprites92_4024Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set3AFrame25::
Data_092_77E5:: ; address name
    db $D8, $38, $1A, $10 ; entry 0
    db $D0, $38, $1A, $10 ; entry 1
    db $E8, $30, $1B, $50 ; entry 2
    db $E8, $38, $1C, $50 ; entry 3
    db $E8, $48, $1B, $70 ; entry 4
    db $E8, $40, $1C, $70 ; entry 5
    db $E0, $28, $1D, $50 ; entry 6
    db $E0, $30, $1E, $50 ; entry 7
    db $E0, $38, $1F, $50 ; entry 8
    db $D8, $28, $20, $50 ; entry 9
    db $D8, $30, $21, $50 ; entry 10
    db $D0, $28, $20, $10 ; entry 11
    db $D0, $30, $21, $10 ; entry 12
    db $D8, $40, $1A, $30 ; entry 13
    db $D0, $40, $1A, $30 ; entry 14
    db $E0, $48, $1E, $70 ; entry 15
    db $E0, $40, $1F, $70 ; entry 16
    db $D8, $48, $21, $70 ; entry 17
    db $D0, $48, $21, $30 ; entry 18
    db $F8, $C8, $17, $70 ; entry 19
    db $F8, $C0, $18, $70 ; entry 20
    db $F0, $C8, $19, $70 ; entry 21
    db $F0, $C0, $1A, $70 ; entry 22
    db $F8, $B0, $17, $50 ; entry 23
    db $F8, $B8, $18, $50 ; entry 24
    db $F0, $B0, $19, $50 ; entry 25
    db $F0, $B8, $1A, $50 ; entry 26
    db $E0, $C8, $17, $30 ; entry 27
    db $E0, $C0, $18, $30 ; entry 28
    db $E8, $C8, $19, $30 ; entry 29
    db $E8, $C0, $1A, $30 ; entry 30
    db $E0, $B0, $17, $10 ; entry 31
    db $E0, $B8, $18, $10 ; entry 32
    db $E8, $B0, $19, $10 ; entry 33
    db $E8, $B8, $1A, $10 ; entry 34
    db $80 ; end

; E-0147 (derived: frame 26 of MetaSprites92_4024Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set3AFrame26::
Data_092_7872:: ; address name
    db $E8, $C0, $1A, $70 ; entry 0
    db $D8, $C8, $1B, $30 ; entry 1
    db $D8, $C0, $1C, $30 ; entry 2
    db $D8, $B0, $1B, $10 ; entry 3
    db $D8, $B8, $1C, $10 ; entry 4
    db $E0, $D0, $1D, $30 ; entry 5
    db $E0, $C8, $1E, $30 ; entry 6
    db $E0, $C0, $1F, $30 ; entry 7
    db $E8, $D0, $20, $30 ; entry 8
    db $E8, $C8, $21, $30 ; entry 9
    db $E8, $B8, $1A, $50 ; entry 10
    db $E0, $B0, $1E, $10 ; entry 11
    db $E0, $B8, $1F, $10 ; entry 12
    db $E8, $B0, $21, $10 ; entry 13
    db $F0, $C0, $1A, $30 ; entry 14
    db $F0, $D0, $20, $70 ; entry 15
    db $F0, $C8, $21, $70 ; entry 16
    db $F0, $B8, $1A, $10 ; entry 17
    db $F0, $B0, $21, $50 ; entry 18
    db $F8, $D0, $1D, $70 ; entry 19
    db $F8, $C8, $1E, $70 ; entry 20
    db $F8, $C0, $1F, $70 ; entry 21
    db $F8, $B0, $1E, $50 ; entry 22
    db $F8, $B8, $1F, $50 ; entry 23
    db $80 ; end

; E-0147 (derived: frame 27 of MetaSprites92_4024Set3A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set3AFrame27::
    db $80 ; end

; E-0147 (derived: meta-sprite set 59 of MetaSprites92_4024Table: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites92_4024Set3B::
Data_092_78D4:: ; address name
    dw MetaSprites92_4024Set3BFrame0 ; entry 0
    dw MetaSprites92_4024Set3BFrame1 ; entry 1
    dw MetaSprites92_4024Set3BFrame2 ; entry 2
    dw MetaSprites92_4024Set3BFrame3 ; entry 3
    dw MetaSprites92_4024Set3BFrame4 ; entry 4
    dw MetaSprites92_4024Set3BFrame5 ; entry 5
    dw MetaSprites92_4024Set3BFrame6 ; entry 6
    dw MetaSprites92_4024Set3BFrame7 ; entry 7
    dw MetaSprites92_4024Set3BFrame8 ; entry 8
    dw MetaSprites92_4024Set3BFrame9 ; entry 9
    dw MetaSprites92_4024Set3BFrame10 ; entry 10
    dw MetaSprites92_4024Set3BFrame11 ; entry 11
    dw MetaSprites92_4024Set3BFrame12 ; entry 12
    dw MetaSprites92_4024Set3BFrame12 ; entry 13
    dw MetaSprites92_4024Set3BFrame12 ; entry 14
    dw MetaSprites92_4024Set3BFrame12 ; entry 15
    dw MetaSprites92_4024Set3BFrame12 ; entry 16
    dw MetaSprites92_4024Set3BFrame12 ; entry 17
    dw MetaSprites92_4024Set3BFrame12 ; entry 18
    dw MetaSprites92_4024Set3BFrame12 ; entry 19
    dw MetaSprites92_4024Set3BFrame12 ; entry 20
    dw MetaSprites92_4024Set3BFrame12 ; entry 21
    dw MetaSprites92_4024Set3BFrame12 ; entry 22
    dw MetaSprites92_4024Set3BFrame12 ; entry 23
    dw MetaSprites92_4024Set3BFrame12 ; entry 24
    dw MetaSprites92_4024Set3BFrame12 ; entry 25
    dw MetaSprites92_4024Set3BFrame12 ; entry 26
    dw MetaSprites92_4024Set3BFrame12 ; entry 27
    dw MetaSprites92_4024Set3BFrame12 ; entry 28
    dw MetaSprites92_4024Set3BFrame12 ; entry 29
    dw MetaSprites92_4024Set3BFrame12 ; entry 30
    dw MetaSprites92_4024Set3BFrame12 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites92_4024Set3B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set3BFrame0::
Data_092_7914:: ; address name
    db $E2, $B8, $00, $20 ; entry 0
    db $E0, $B0, $01, $20 ; entry 1
    db $E8, $B0, $02, $20 ; entry 2
    db $E3, $C0, $10, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites92_4024Set3B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set3BFrame1::
Data_092_7925:: ; address name
    db $E0, $B8, $02, $60 ; entry 0
    db $E0, $B0, $03, $60 ; entry 1
    db $E8, $D4, $08, $40 ; entry 2
    db $E8, $CC, $07, $40 ; entry 3
    db $E8, $BC, $02, $00 ; entry 4
    db $E9, $C4, $07, $60 ; entry 5
    db $E0, $D4, $09, $40 ; entry 6
    db $E2, $DC, $20, $40 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites92_4024Set3B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set3BFrame2::
Data_092_7946:: ; address name
    db $E0, $B0, $14, $00 ; entry 0
    db $E0, $B8, $15, $00 ; entry 1
    db $E0, $C0, $16, $00 ; entry 2
    db $E8, $B8, $17, $00 ; entry 3
    db $E8, $C0, $18, $00 ; entry 4
    db $F0, $B8, $19, $00 ; entry 5
    db $F0, $C0, $1A, $00 ; entry 6
    db $F0, $C8, $1B, $00 ; entry 7
    db $F0, $D0, $1C, $00 ; entry 8
    db $F8, $B8, $1D, $00 ; entry 9
    db $F8, $C0, $1E, $00 ; entry 10
    db $F8, $C8, $1F, $00 ; entry 11
    db $EF, $D8, $07, $40 ; entry 12
    db $E7, $E0, $09, $40 ; entry 13
    db $EF, $E0, $08, $40 ; entry 14
    db $E9, $E8, $05, $00 ; entry 15
    db $E5, $F0, $20, $00 ; entry 16
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites92_4024Set3B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set3BFrame3::
Data_092_798B:: ; address name
    db $E4, $F0, $04, $60 ; entry 0
    db $E2, $F8, $03, $60 ; entry 1
    db $E2, $00, $02, $60 ; entry 2
    db $E7, $08, $20, $40 ; entry 3
    db $E1, $E8, $00, $20 ; entry 4
    db $E3, $E0, $01, $60 ; entry 5
    db $DB, $E0, $02, $60 ; entry 6
    db $DE, $D8, $1B, $00 ; entry 7
    db $E6, $D0, $1E, $00 ; entry 8
    db $E6, $D8, $1F, $00 ; entry 9
    db $E3, $C8, $07, $00 ; entry 10
    db $E4, $C0, $20, $60 ; entry 11
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites92_4024Set3B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set3BFrame4::
Data_092_79BC:: ; address name
    db $E2, $F2, $00, $00 ; entry 0
    db $E0, $FA, $01, $00 ; entry 1
    db $E8, $FA, $02, $00 ; entry 2
    db $E7, $02, $15, $40 ; entry 3
    db $E7, $0A, $16, $40 ; entry 4
    db $DF, $08, $1D, $40 ; entry 5
    db $DF, $10, $1E, $40 ; entry 6
    db $DF, $18, $1F, $40 ; entry 7
    db $E7, $17, $1D, $00 ; entry 8
    db $E8, $1F, $20, $40 ; entry 9
    db $E1, $EB, $13, $40 ; entry 10
    db $E1, $E3, $20, $60 ; entry 11
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites92_4024Set3B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set3BFrame5::
Data_092_79ED:: ; address name
    db $E3, $28, $19, $20 ; entry 0
    db $E3, $18, $1B, $20 ; entry 1
    db $EB, $18, $1F, $20 ; entry 2
    db $EB, $28, $1D, $20 ; entry 3
    db $EB, $20, $1E, $20 ; entry 4
    db $DB, $29, $09, $40 ; entry 5
    db $DE, $31, $20, $40 ; entry 6
    db $E7, $09, $13, $00 ; entry 7
    db $E3, $10, $1C, $20 ; entry 8
    db $E6, $01, $11, $00 ; entry 9
    db $E6, $F9, $20, $20 ; entry 10
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites92_4024Set3B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set3BFrame6::
Data_092_7A1A:: ; address name
    db $DA, $31, $01, $00 ; entry 0
    db $E2, $31, $02, $00 ; entry 1
    db $DE, $29, $16, $20 ; entry 2
    db $E6, $29, $09, $20 ; entry 3
    db $E4, $21, $07, $20 ; entry 4
    db $E8, $19, $12, $40 ; entry 5
    db $E3, $0B, $10, $40 ; entry 6
    db $E5, $11, $13, $20 ; entry 7
    db $E0, $41, $0D, $20 ; entry 8
    db $E0, $39, $0E, $20 ; entry 9
    db $E3, $49, $1E, $00 ; entry 10
    db $E4, $FC, $0F, $00 ; entry 11
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites92_4024Set3B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set3BFrame7::
Data_092_7A4B:: ; address name
    db $E2, $48, $0C, $00 ; entry 0
    db $E4, $40, $04, $40 ; entry 1
    db $E4, $38, $02, $00 ; entry 2
    db $DC, $38, $08, $00 ; entry 3
    db $DC, $30, $07, $00 ; entry 4
    db $DD, $28, $1B, $00 ; entry 5
    db $E5, $22, $17, $00 ; entry 6
    db $E5, $2A, $18, $00 ; entry 7
    db $EB, $1C, $00, $40 ; entry 8
    db $ED, $24, $01, $40 ; entry 9
    db $E7, $14, $20, $20 ; entry 10
    db $E0, $F8, $21, $00 ; entry 11
    db $E7, $F8, $21, $40 ; entry 12
    db $E0, $FF, $21, $20 ; entry 13
    db $E7, $FF, $21, $60 ; entry 14
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites92_4024Set3B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set3BFrame8::
Data_092_7A88:: ; address name
    db $E4, $48, $05, $40 ; entry 0
    db $E7, $40, $0C, $60 ; entry 1
    db $E6, $38, $02, $40 ; entry 2
    db $EE, $34, $09, $20 ; entry 3
    db $EC, $2C, $13, $20 ; entry 4
    db $E5, $27, $1A, $40 ; entry 5
    db $D8, $F8, $22, $00 ; entry 6
    db $D8, $FF, $22, $20 ; entry 7
    db $E0, $F0, $23, $00 ; entry 8
    db $E0, $F8, $24, $00 ; entry 9
    db $E0, $07, $23, $20 ; entry 10
    db $E0, $FF, $24, $20 ; entry 11
    db $E8, $F0, $25, $00 ; entry 12
    db $E8, $F8, $26, $00 ; entry 13
    db $E8, $07, $25, $20 ; entry 14
    db $E8, $FF, $26, $20 ; entry 15
    db $F0, $F8, $27, $00 ; entry 16
    db $F0, $FF, $27, $20 ; entry 17
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites92_4024Set3B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set3BFrame9::
Data_092_7AD1:: ; address name
    db $E1, $48, $12, $00 ; entry 0
    db $E5, $40, $20, $60 ; entry 1
    db $D8, $F0, $28, $00 ; entry 2
    db $D8, $F8, $29, $00 ; entry 3
    db $D8, $07, $28, $20 ; entry 4
    db $D8, $FF, $29, $20 ; entry 5
    db $E0, $F0, $2A, $00 ; entry 6
    db $E0, $F8, $2B, $00 ; entry 7
    db $E0, $07, $2A, $20 ; entry 8
    db $E0, $FF, $2B, $20 ; entry 9
    db $E8, $F0, $2C, $00 ; entry 10
    db $E8, $F8, $2D, $00 ; entry 11
    db $E8, $07, $2C, $20 ; entry 12
    db $E8, $FF, $2D, $20 ; entry 13
    db $F0, $F0, $2E, $00 ; entry 14
    db $F0, $F8, $2F, $00 ; entry 15
    db $F0, $07, $2E, $20 ; entry 16
    db $F0, $FF, $2F, $20 ; entry 17
    db $80 ; end

; E-0147 (derived: frame 10 of MetaSprites92_4024Set3B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set3BFrame10::
Data_092_7B1A:: ; address name
    db $E0, $F8, $21, $00 ; entry 0
    db $E7, $F8, $21, $40 ; entry 1
    db $E0, $FF, $21, $20 ; entry 2
    db $E7, $FF, $21, $60 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 11 of MetaSprites92_4024Set3B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set3BFrame11::
Data_092_7B2B:: ; address name
    db $E4, $FC, $0F, $00 ; entry 0
    db $80 ; end

; E-0147 (derived: frame 12 of MetaSprites92_4024Set3B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92_4024Set3BFrame12::
    db $80 ; end
    ds $4CF, $00
