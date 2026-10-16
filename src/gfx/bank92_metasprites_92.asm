; ROM bank $92: meta-sprite frames
; The annotated listing of this bank is build/listing/bank92.asm.

SECTION "Bank 92", ROMX[$4000], BANK[$92]
    db $92

; Draws a battle effect sprite from the meta-sprite table of this bank: hSpriteOriginX =
; wEffectSpriteX and hSpriteOriginY = $68 (both high bytes 0), hSpriteSetIndex = wEffectTileOffset
; (the meta-sprite set number), hSpriteSubIndex = wEffectSpriteAttrXor (the frame number),
; hSpriteTileOffset and hSpriteAttrXor = 0; then BuildOamFromSpriteTable_Bank92 with DE =
; MetaSprites92Table. Its only caller is DrawEffectSpriteForEffectTileOffsetRange (for
; wEffectTileOffset $33 and above). (C2, E-0385)
; sets the sprite origin X = wEffectSpriteX, Y = $68, tile offset = wEffectTileOffset, attribute XOR
; = wEffectSpriteAttrXor, then builds OAM from the local sprite table (E-0121)
DrawEffectSpriteAtEffectSpriteX_Bank92::
    ld hl, hSpriteOriginX
    ld a, [wEffectSpriteX]
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $68
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, [wEffectTileOffset]
    ld [hli], a
    ld a, [wEffectSpriteAttrXor]
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld [hli], a
    ld de, MetaSprites92Table
    call BuildOamFromSpriteTable_Bank92
    ret

; the caller of BuildOamFromSpriteTable_Bank92 passes DE = $MetaSprites92Table; the builder takes
; the word at DE + 2 * hSpriteSetIndex as the set and the word at set + 2 * hSpriteSubIndex as the
; frame; 60 words, up to the next code or data (E-0147, C1)
; record: meta-sprite set
MetaSprites92Table::
    dw MetaSprites92Set00 ; id 0
    dw MetaSprites92Set00 ; id 1
    dw MetaSprites92Set00 ; id 2
    dw MetaSprites92Set00 ; id 3
    dw MetaSprites92Set00 ; id 4
    dw MetaSprites92Set00 ; id 5
    dw MetaSprites92Set00 ; id 6
    dw MetaSprites92Set00 ; id 7
    dw MetaSprites92Set00 ; id 8
    dw MetaSprites92Set00 ; id 9
    dw MetaSprites92Set00 ; id 10
    dw MetaSprites92Set00 ; id 11
    dw MetaSprites92Set00 ; id 12
    dw MetaSprites92Set00 ; id 13
    dw MetaSprites92Set00 ; id 14
    dw MetaSprites92Set00 ; id 15
    dw MetaSprites92Set00 ; id 16
    dw MetaSprites92Set00 ; id 17
    dw MetaSprites92Set00 ; id 18
    dw MetaSprites92Set00 ; id 19
    dw MetaSprites92Set00 ; id 20
    dw MetaSprites92Set00 ; id 21
    dw MetaSprites92Set00 ; id 22
    dw MetaSprites92Set00 ; id 23
    dw MetaSprites92Set00 ; id 24
    dw MetaSprites92Set00 ; id 25
    dw MetaSprites92Set00 ; id 26
    dw MetaSprites92Set00 ; id 27
    dw MetaSprites92Set00 ; id 28
    dw MetaSprites92Set00 ; id 29
    dw MetaSprites92Set00 ; id 30
    dw MetaSprites92Set00 ; id 31
    dw MetaSprites92Set00 ; id 32
    dw MetaSprites92Set00 ; id 33
    dw MetaSprites92Set00 ; id 34
    dw MetaSprites92Set00 ; id 35
    dw MetaSprites92Set00 ; id 36
    dw MetaSprites92Set00 ; id 37
    dw MetaSprites92Set00 ; id 38
    dw MetaSprites92Set00 ; id 39
    dw MetaSprites92Set00 ; id 40
    dw MetaSprites92Set00 ; id 41
    dw MetaSprites92Set00 ; id 42
    dw MetaSprites92Set00 ; id 43
    dw MetaSprites92Set00 ; id 44
    dw MetaSprites92Set00 ; id 45
    dw MetaSprites92Set00 ; id 46
    dw MetaSprites92Set00 ; id 47
    dw MetaSprites92Set00 ; id 48
    dw MetaSprites92Set00 ; id 49
    dw MetaSprites92Set00 ; id 50
    dw MetaSprites92Set00 ; id 51
    dw MetaSprites92Set34 ; id 52
    dw MetaSprites92Set35 ; id 53
    dw MetaSprites92Set36 ; id 54
    dw MetaSprites92Set37 ; id 55
    dw MetaSprites92Set38 ; id 56
    dw MetaSprites92Set39 ; id 57
    dw MetaSprites92Set3A ; id 58
    dw MetaSprites92Set3B ; id 59

; DE = table of set pointers: the word at DE + 2 * hSpriteSetIndex is the set, the word at set + 2 *
; hSpriteSubIndex is the frame, a list of 4-byte entries (Y, X, tile, attribute) ended by a byte
; $80. Each entry becomes an OAM entry at $C000 + 4 * hOamNextEntry: Y = hSpriteOriginY + Y + $10
; and X = hSpriteOriginX + X + 8 (8-bit sums), tile = tile + hSpriteTileOffset, attribute =
; attribute XOR hSpriteAttrXor, and hOamNextEntry grows by one. It stops at the $80 byte or when
; hOamNextEntry reaches $28 (40 entries), and writes nothing when hOamNextEntry is already $28. Its
; only caller is DrawEffectSpriteAtEffectSpriteX_Bank92; the same 81 bytes appear in 5 banks. (C2,
; E-0385)
; DE = two-level table; entries are chosen by hSpriteSetIndex and hSpriteSubIndex; writes 4-byte OAM
; entries at $C000 + 4 * hOamNextEntry (Y = hSpriteOriginY + b + $10, X = hSpriteOriginX + b + 8,
; tile += hSpriteTileOffset, flags ^= hSpriteAttrXor) until a $80 byte or hOamNextEntry reaches $28
; (40 entries) (the same 81 bytes appear in 5 banks)
BuildOamFromSpriteTable_Bank92::
    ldh a, [hOamNextEntry]
    cp $28
    jr nc, .return
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
    ld h, $c0

.loop:
    ld a, [de]
    inc de
    cp $80
    jr z, .return
    ld b, a
    ldh a, [hSpriteOriginY]
    add b
    add $10
    ld [hli], a
    ld a, [de]
    inc de
    ld b, a
    ldh a, [hSpriteOriginX]
    add b
    add $08
    ld [hli], a
    ldh a, [hSpriteTileOffset]
    ld b, a
    ld a, [de]
    inc de
    add b
    ld [hli], a
    ld a, [de]
    inc de
    ld b, a
    ldh a, [hSpriteAttrXor]
    xor b
    ld [hli], a
    ldh a, [hOamNextEntry]
    inc a
    ldh [hOamNextEntry], a
    cp $28
    jr c, .loop

.return:
    ret

; meta-sprite set 0 of MetaSprites92Table: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites92Set00::
    dw MetaSprites92Set00Frame0 ; entry 0
    dw MetaSprites92Set00Frame1 ; entry 1
    dw MetaSprites92Set00Frame2 ; entry 2
    dw MetaSprites92Set00Frame3 ; entry 3
    dw MetaSprites92Set00Frame4 ; entry 4
    dw MetaSprites92Set00Frame5 ; entry 5
    dw MetaSprites92Set00Frame6 ; entry 6
    dw MetaSprites92Set00Frame7 ; entry 7
    dw MetaSprites92Set00Frame8 ; entry 8
    dw MetaSprites92Set00Frame9 ; entry 9
    dw MetaSprites92Set00Frame10 ; entry 10
    dw MetaSprites92Set00Frame11 ; entry 11
    dw MetaSprites92Set00Frame12 ; entry 12
    dw MetaSprites92Set00Frame13 ; entry 13
    dw MetaSprites92Set00Frame14 ; entry 14
    dw MetaSprites92Set00Frame15 ; entry 15
    dw MetaSprites92Set00Frame16 ; entry 16
    dw MetaSprites92Set00Frame17 ; entry 17
    dw MetaSprites92Set00Frame18 ; entry 18
    dw MetaSprites92Set00Frame19 ; entry 19
    dw MetaSprites92Set00Frame20 ; entry 20
    dw MetaSprites92Set00Frame21 ; entry 21
    dw MetaSprites92Set00Frame22 ; entry 22
    dw MetaSprites92Set00Frame22 ; entry 23
    dw MetaSprites92Set00Frame22 ; entry 24
    dw MetaSprites92Set00Frame22 ; entry 25
    dw MetaSprites92Set00Frame22 ; entry 26
    dw MetaSprites92Set00Frame22 ; entry 27
    dw MetaSprites92Set00Frame22 ; entry 28
    dw MetaSprites92Set00Frame22 ; entry 29
    dw MetaSprites92Set00Frame22 ; entry 30
    dw MetaSprites92Set00Frame22 ; entry 31

; frame 0 of MetaSprites92Set00; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set00Frame0::
    db $d0, $bc, $00, $10 ; entry 0
    db $d0, $3c, $00, $10 ; entry 1
    db $80 ; end

; frame 1 of MetaSprites92Set00; ends with $80 (E-0147)
MetaSprites92Set00Frame1::
    db $d0, $b8, $01, $10 ; entry 0
    db $d0, $c0, $01, $30 ; entry 1
    db $d0, $38, $01, $10 ; entry 2
    db $d0, $40, $01, $30 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites92Set00; ends with $80 (E-0147)
MetaSprites92Set00Frame2::
    db $e8, $b8, $05, $10 ; entry 0
    db $e8, $c0, $06, $10 ; entry 1
    db $f0, $b8, $07, $10 ; entry 2
    db $f0, $c0, $08, $10 ; entry 3
    db $e0, $be, $04, $10 ; entry 4
    db $d0, $bb, $02, $10 ; entry 5
    db $d8, $bb, $03, $10 ; entry 6
    db $f8, $b8, $09, $10 ; entry 7
    db $f8, $c0, $0a, $10 ; entry 8
    db $d0, $bc, $00, $10 ; entry 9
    db $d0, $cc, $00, $10 ; entry 10
    db $f0, $40, $05, $70 ; entry 11
    db $f0, $38, $06, $70 ; entry 12
    db $e8, $40, $07, $70 ; entry 13
    db $e8, $38, $08, $70 ; entry 14
    db $d8, $3a, $04, $70 ; entry 15
    db $e0, $3d, $03, $70 ; entry 16
    db $f8, $40, $09, $70 ; entry 17
    db $f8, $38, $0a, $70 ; entry 18
    db $d0, $2c, $00, $30 ; entry 19
    db $d0, $3b, $02, $30 ; entry 20
    db $d0, $3c, $00, $30 ; entry 21
    db $80 ; end

; frame 3 of MetaSprites92Set00; ends with $80 (E-0147)
MetaSprites92Set00Frame3::
    db $d0, $bc, $0b, $10 ; entry 0
    db $f0, $bc, $0f, $10 ; entry 1
    db $e8, $bc, $0e, $10 ; entry 2
    db $e0, $b7, $07, $10 ; entry 3
    db $e0, $bf, $08, $10 ; entry 4
    db $d8, $bb, $0f, $50 ; entry 5
    db $d0, $c8, $01, $10 ; entry 6
    db $d0, $d0, $01, $30 ; entry 7
    db $f8, $ba, $10, $10 ; entry 8
    db $d0, $30, $01, $30 ; entry 9
    db $d0, $28, $01, $10 ; entry 10
    db $d0, $3b, $0b, $30 ; entry 11
    db $f0, $3b, $0f, $30 ; entry 12
    db $e8, $3b, $0e, $30 ; entry 13
    db $d8, $3c, $0f, $70 ; entry 14
    db $e0, $3c, $0c, $10 ; entry 15
    db $e0, $40, $0e, $10 ; entry 16
    db $f8, $3c, $10, $10 ; entry 17
    db $80 ; end

; frame 4 of MetaSprites92Set00; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set00Frame4::
    db $e8, $bc, $0c, $10 ; entry 0
    db $f0, $bc, $0d, $10 ; entry 1
    db $d0, $dc, $00, $10 ; entry 2
    db $f0, $d0, $05, $70 ; entry 3
    db $f0, $c8, $06, $70 ; entry 4
    db $e8, $d0, $07, $70 ; entry 5
    db $e8, $c8, $08, $70 ; entry 6
    db $d8, $ca, $04, $70 ; entry 7
    db $e0, $cd, $03, $70 ; entry 8
    db $f8, $d0, $09, $70 ; entry 9
    db $f8, $c8, $0a, $70 ; entry 10
    db $d0, $cb, $02, $30 ; entry 11
    db $d0, $cc, $00, $30 ; entry 12
    db $f0, $3b, $0d, $30 ; entry 13
    db $e8, $28, $05, $10 ; entry 14
    db $e8, $30, $06, $10 ; entry 15
    db $f0, $28, $07, $10 ; entry 16
    db $f0, $30, $08, $10 ; entry 17
    db $e0, $2e, $04, $10 ; entry 18
    db $d8, $2b, $03, $10 ; entry 19
    db $f8, $28, $09, $10 ; entry 20
    db $f8, $30, $0a, $10 ; entry 21
    db $d0, $1c, $00, $30 ; entry 22
    db $d0, $2b, $02, $50 ; entry 23
    db $d0, $2c, $00, $10 ; entry 24
    db $d0, $bb, $0d, $50 ; entry 25
    db $d8, $bb, $0c, $50 ; entry 26
    db $e0, $bc, $0b, $50 ; entry 27
    db $d0, $3b, $0c, $50 ; entry 28
    db $e0, $3b, $0c, $30 ; entry 29
    db $d8, $3a, $0b, $30 ; entry 30
    db $e8, $3c, $0d, $70 ; entry 31
    db $f8, $bb, $29, $10 ; entry 32
    db $f8, $c3, $2a, $10 ; entry 33
    db $f8, $b4, $2a, $30 ; entry 34
    db $f8, $3b, $29, $10 ; entry 35
    db $f8, $43, $2a, $10 ; entry 36
    db $f8, $34, $2a, $30 ; entry 37
    db $80 ; end

; frame 5 of MetaSprites92Set00; ends with $80 (E-0147)
MetaSprites92Set00Frame5::
    db $d0, $cc, $0b, $30 ; entry 0
    db $f0, $cc, $0f, $30 ; entry 1
    db $e8, $cc, $0e, $30 ; entry 2
    db $d8, $cd, $0f, $70 ; entry 3
    db $e0, $cd, $0c, $10 ; entry 4
    db $e0, $d1, $0e, $10 ; entry 5
    db $d0, $d8, $01, $10 ; entry 6
    db $d0, $e0, $01, $30 ; entry 7
    db $f8, $cd, $10, $10 ; entry 8
    db $f0, $2c, $0b, $70 ; entry 9
    db $d0, $2c, $0f, $70 ; entry 10
    db $d8, $2c, $0e, $70 ; entry 11
    db $e8, $2d, $0f, $30 ; entry 12
    db $d0, $20, $01, $30 ; entry 13
    db $d0, $18, $01, $10 ; entry 14
    db $f8, $2d, $10, $10 ; entry 15
    db $f0, $3b, $0c, $70 ; entry 16
    db $e8, $3c, $08, $30 ; entry 17
    db $e0, $2b, $08, $30 ; entry 18
    db $e0, $31, $07, $70 ; entry 19
    db $e8, $bc, $0c, $70 ; entry 20
    db $f0, $bd, $0b, $50 ; entry 21
    db $f8, $b9, $2b, $30 ; entry 22
    db $f8, $b1, $2c, $30 ; entry 23
    db $f8, $c0, $2b, $10 ; entry 24
    db $f8, $c8, $2c, $10 ; entry 25
    db $f8, $38, $2b, $30 ; entry 26
    db $f8, $30, $2c, $30 ; entry 27
    db $f8, $3f, $2b, $10 ; entry 28
    db $f8, $47, $2c, $10 ; entry 29
    db $80 ; end

; frame 6 of MetaSprites92Set00; ends with $80 (E-0147)
MetaSprites92Set00Frame6::
    db $e8, $cc, $0c, $30 ; entry 0
    db $f0, $cc, $0d, $30 ; entry 1
    db $e8, $d8, $05, $10 ; entry 2
    db $e8, $e0, $06, $10 ; entry 3
    db $f0, $d8, $07, $10 ; entry 4
    db $f0, $e0, $08, $10 ; entry 5
    db $e0, $de, $04, $10 ; entry 6
    db $d8, $db, $03, $10 ; entry 7
    db $f8, $d8, $09, $10 ; entry 8
    db $f8, $e0, $0a, $10 ; entry 9
    db $d0, $ec, $00, $10 ; entry 10
    db $d0, $0c, $00, $30 ; entry 11
    db $f0, $20, $05, $70 ; entry 12
    db $f0, $18, $06, $70 ; entry 13
    db $e8, $20, $07, $70 ; entry 14
    db $e8, $18, $08, $70 ; entry 15
    db $d8, $1a, $04, $70 ; entry 16
    db $e0, $1d, $03, $70 ; entry 17
    db $f8, $20, $09, $70 ; entry 18
    db $f8, $18, $0a, $70 ; entry 19
    db $d0, $1c, $02, $30 ; entry 20
    db $d0, $1d, $00, $10 ; entry 21
    db $d0, $da, $02, $70 ; entry 22
    db $d0, $dc, $00, $10 ; entry 23
    db $f0, $2e, $0c, $10 ; entry 24
    db $d0, $2d, $0c, $50 ; entry 25
    db $d0, $cd, $0d, $70 ; entry 26
    db $d8, $2d, $0d, $50 ; entry 27
    db $d8, $cd, $0c, $70 ; entry 28
    db $e0, $2d, $0c, $50 ; entry 29
    db $e8, $2e, $0b, $50 ; entry 30
    db $e0, $cc, $0b, $70 ; entry 31
    db $f8, $cc, $29, $10 ; entry 32
    db $f8, $d4, $2a, $10 ; entry 33
    db $f8, $c5, $2a, $30 ; entry 34
    db $f8, $2c, $29, $10 ; entry 35
    db $f8, $33, $2a, $10 ; entry 36
    db $f8, $25, $2a, $30 ; entry 37
    db $80 ; end

; frame 7 of MetaSprites92Set00; ends with $80 (E-0147)
MetaSprites92Set00Frame7::
    db $d0, $dc, $0b, $10 ; entry 0
    db $f0, $dc, $0f, $10 ; entry 1
    db $e8, $dc, $0e, $10 ; entry 2
    db $e0, $d7, $07, $10 ; entry 3
    db $e0, $df, $08, $10 ; entry 4
    db $d8, $db, $0f, $50 ; entry 5
    db $d0, $e8, $01, $10 ; entry 6
    db $d0, $f0, $01, $30 ; entry 7
    db $f8, $db, $10, $30 ; entry 8
    db $f0, $cd, $0c, $50 ; entry 9
    db $e8, $cc, $08, $10 ; entry 10
    db $d0, $10, $01, $30 ; entry 11
    db $d0, $08, $01, $10 ; entry 12
    db $f8, $1b, $10, $30 ; entry 13
    db $e8, $2b, $0d, $30 ; entry 14
    db $f0, $19, $0b, $70 ; entry 15
    db $d8, $19, $0e, $70 ; entry 16
    db $e8, $1a, $0f, $30 ; entry 17
    db $e0, $1a, $0c, $50 ; entry 18
    db $e0, $1e, $0e, $10 ; entry 19
    db $d0, $1a, $0f, $70 ; entry 20
    db $f0, $2d, $0b, $50 ; entry 21
    db $f8, $c9, $2b, $30 ; entry 22
    db $f8, $c1, $2c, $30 ; entry 23
    db $f8, $d0, $2b, $10 ; entry 24
    db $f8, $d8, $2c, $10 ; entry 25
    db $f8, $28, $2b, $30 ; entry 26
    db $f8, $20, $2c, $30 ; entry 27
    db $f8, $2f, $2b, $10 ; entry 28
    db $f8, $37, $2c, $10 ; entry 29
    db $80 ; end

; frame 8 of MetaSprites92Set00; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set00Frame8::
    db $e8, $dc, $0c, $10 ; entry 0
    db $f0, $dc, $0d, $10 ; entry 1
    db $d0, $fc, $00, $10 ; entry 2
    db $f0, $f0, $05, $70 ; entry 3
    db $f0, $e8, $06, $70 ; entry 4
    db $e8, $f0, $07, $70 ; entry 5
    db $e8, $e8, $08, $70 ; entry 6
    db $d8, $ea, $04, $70 ; entry 7
    db $e0, $ed, $03, $70 ; entry 8
    db $f8, $f0, $09, $70 ; entry 9
    db $f8, $e8, $0a, $70 ; entry 10
    db $d0, $eb, $02, $30 ; entry 11
    db $d0, $ec, $00, $30 ; entry 12
    db $e8, $10, $05, $30 ; entry 13
    db $e8, $08, $06, $30 ; entry 14
    db $f0, $10, $07, $30 ; entry 15
    db $f0, $08, $08, $30 ; entry 16
    db $e0, $0a, $04, $30 ; entry 17
    db $d0, $0d, $02, $30 ; entry 18
    db $d8, $0d, $03, $30 ; entry 19
    db $f8, $10, $09, $30 ; entry 20
    db $f8, $08, $0a, $30 ; entry 21
    db $d0, $0c, $00, $30 ; entry 22
    db $d0, $1c, $0c, $30 ; entry 23
    db $d8, $1c, $0d, $30 ; entry 24
    db $d0, $db, $0d, $50 ; entry 25
    db $e0, $1d, $0d, $70 ; entry 26
    db $d8, $db, $0c, $50 ; entry 27
    db $e8, $1d, $0c, $70 ; entry 28
    db $e0, $dc, $0b, $50 ; entry 29
    db $f0, $1e, $0b, $50 ; entry 30
    db $f8, $db, $29, $10 ; entry 31
    db $f8, $e3, $2a, $10 ; entry 32
    db $f8, $d4, $2a, $30 ; entry 33
    db $f8, $1c, $29, $10 ; entry 34
    db $f8, $24, $2a, $10 ; entry 35
    db $f8, $15, $2a, $30 ; entry 36
    db $80 ; end

; frame 9 of MetaSprites92Set00; ends with $80 (E-0147)
MetaSprites92Set00Frame9::
    db $d0, $ec, $0b, $30 ; entry 0
    db $f0, $ec, $0f, $30 ; entry 1
    db $e8, $ec, $0e, $30 ; entry 2
    db $d8, $ed, $0f, $70 ; entry 3
    db $e0, $ed, $0c, $10 ; entry 4
    db $e0, $f1, $0e, $10 ; entry 5
    db $d0, $f8, $01, $10 ; entry 6
    db $d0, $00, $01, $30 ; entry 7
    db $f8, $ed, $10, $10 ; entry 8
    db $e8, $dd, $0d, $10 ; entry 9
    db $f8, $0d, $10, $30 ; entry 10
    db $f0, $0e, $0e, $50 ; entry 11
    db $d8, $0d, $0b, $50 ; entry 12
    db $d0, $0d, $0f, $30 ; entry 13
    db $e8, $0d, $0f, $50 ; entry 14
    db $e0, $0f, $08, $10 ; entry 15
    db $e0, $09, $07, $10 ; entry 16
    db $f0, $db, $0b, $70 ; entry 17
    db $f0, $1c, $0b, $10 ; entry 18
    db $e8, $1b, $0c, $70 ; entry 19
    db $f8, $d9, $2b, $30 ; entry 20
    db $f8, $d1, $2c, $30 ; entry 21
    db $f8, $e0, $2b, $10 ; entry 22
    db $f8, $e8, $2c, $10 ; entry 23
    db $f8, $18, $2b, $30 ; entry 24
    db $f8, $10, $2c, $30 ; entry 25
    db $f8, $1f, $2b, $10 ; entry 26
    db $f8, $27, $2c, $10 ; entry 27
    db $80 ; end

; frame 10 of MetaSprites92Set00; ends with $80 (E-0147)
MetaSprites92Set00Frame10::
    db $e8, $eb, $0c, $30 ; entry 0
    db $f0, $eb, $0d, $30 ; entry 1
    db $f0, $0d, $0c, $10 ; entry 2
    db $d0, $0c, $0d, $30 ; entry 3
    db $d0, $ec, $0d, $70 ; entry 4
    db $e0, $0c, $0c, $50 ; entry 5
    db $d8, $ec, $0c, $70 ; entry 6
    db $d8, $0c, $0d, $50 ; entry 7
    db $e0, $eb, $0b, $70 ; entry 8
    db $e8, $0d, $0b, $50 ; entry 9
    db $d8, $fc, $0c, $10 ; entry 10
    db $f8, $eb, $29, $10 ; entry 11
    db $f8, $f3, $2a, $10 ; entry 12
    db $f8, $e4, $2a, $30 ; entry 13
    db $f8, $0c, $29, $10 ; entry 14
    db $f8, $13, $2a, $10 ; entry 15
    db $f8, $05, $2a, $30 ; entry 16
    db $d0, $fc, $29, $50 ; entry 17
    db $d0, $04, $2a, $50 ; entry 18
    db $d0, $f5, $2a, $70 ; entry 19
    db $80 ; end

; frame 11 of MetaSprites92Set00; ends with $80 (E-0147)
MetaSprites92Set00Frame11::
    db $f0, $ed, $0b, $10 ; entry 0
    db $e8, $ec, $0c, $50 ; entry 1
    db $f0, $0b, $0c, $70 ; entry 2
    db $e8, $0c, $08, $70 ; entry 3
    db $d8, $fb, $0d, $70 ; entry 4
    db $f8, $e9, $2b, $30 ; entry 5
    db $f8, $e1, $2c, $30 ; entry 6
    db $f8, $f0, $2b, $10 ; entry 7
    db $f8, $f8, $2c, $10 ; entry 8
    db $f8, $08, $2b, $30 ; entry 9
    db $f8, $00, $2c, $30 ; entry 10
    db $f8, $0f, $2b, $10 ; entry 11
    db $f8, $17, $2c, $10 ; entry 12
    db $d0, $f8, $2b, $70 ; entry 13
    db $d0, $f0, $2c, $70 ; entry 14
    db $d0, $00, $2b, $50 ; entry 15
    db $d0, $08, $2c, $50 ; entry 16
    db $80 ; end

; frame 12 of MetaSprites92Set00; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set00Frame12::
    db $f0, $00, $05, $70 ; entry 0
    db $f0, $f8, $06, $70 ; entry 1
    db $e8, $00, $07, $70 ; entry 2
    db $e8, $f8, $08, $70 ; entry 3
    db $d8, $fa, $04, $70 ; entry 4
    db $e0, $fd, $03, $70 ; entry 5
    db $f8, $00, $09, $70 ; entry 6
    db $f8, $f8, $0a, $70 ; entry 7
    db $d0, $fb, $02, $30 ; entry 8
    db $d0, $fc, $00, $30 ; entry 9
    db $80 ; end

; frame 13 of MetaSprites92Set00; ends with $80 (E-0147)
MetaSprites92Set00Frame13::
    db $f8, $fc, $05, $30 ; entry 0
    db $f8, $f4, $06, $30 ; entry 1
    db $f0, $f6, $04, $30 ; entry 2
    db $e0, $f6, $1e, $50 ; entry 3
    db $e0, $fe, $1f, $50 ; entry 4
    db $e8, $f6, $1c, $70 ; entry 5
    db $e8, $ee, $1d, $70 ; entry 6
    db $d8, $fd, $1a, $70 ; entry 7
    db $d8, $f5, $1b, $70 ; entry 8
    db $d0, $fe, $04, $50 ; entry 9
    db $80 ; end

; frame 14 of MetaSprites92Set00; ends with $80 (E-0147)
MetaSprites92Set00Frame14::
    db $d8, $00, $1c, $50 ; entry 0
    db $d8, $08, $1d, $50 ; entry 1
    db $e0, $00, $1a, $50 ; entry 2
    db $e0, $08, $1b, $50 ; entry 3
    db $e8, $00, $18, $50 ; entry 4
    db $e8, $08, $19, $50 ; entry 5
    db $f0, $f0, $14, $50 ; entry 6
    db $f0, $f8, $15, $50 ; entry 7
    db $f0, $00, $16, $50 ; entry 8
    db $f0, $08, $17, $50 ; entry 9
    db $f8, $f0, $12, $50 ; entry 10
    db $f8, $f8, $13, $50 ; entry 11
    db $d0, $00, $1e, $70 ; entry 12
    db $d0, $f8, $1f, $70 ; entry 13
    db $80 ; end

; frame 15 of MetaSprites92Set00; ends with $80 (E-0147)
MetaSprites92Set00Frame15::
    db $f0, $00, $1c, $10 ; entry 0
    db $e8, $00, $1a, $10 ; entry 1
    db $e0, $00, $18, $10 ; entry 2
    db $d8, $f0, $14, $10 ; entry 3
    db $d8, $f8, $15, $10 ; entry 4
    db $d8, $00, $16, $10 ; entry 5
    db $d0, $f0, $12, $10 ; entry 6
    db $f8, $f8, $1f, $30 ; entry 7
    db $f0, $10, $1d, $10 ; entry 8
    db $e8, $10, $1b, $10 ; entry 9
    db $e0, $10, $19, $10 ; entry 10
    db $d8, $10, $17, $30 ; entry 11
    db $f8, $08, $1e, $30 ; entry 12
    db $f8, $00, $11, $10 ; entry 13
    db $e0, $08, $11, $10 ; entry 14
    db $e8, $08, $15, $10 ; entry 15
    db $d8, $08, $17, $10 ; entry 16
    db $f0, $08, $15, $50 ; entry 17
    db $d0, $fd, $19, $10 ; entry 18
    db $d0, $f8, $11, $10 ; entry 19
    db $80 ; end

; frame 16 of MetaSprites92Set00; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set00Frame16::
    db $d8, $fc, $1c, $50 ; entry 0
    db $e0, $fc, $1a, $50 ; entry 1
    db $e8, $fc, $18, $50 ; entry 2
    db $f0, $ec, $14, $50 ; entry 3
    db $f0, $f4, $15, $50 ; entry 4
    db $f8, $ec, $12, $50 ; entry 5
    db $d0, $f4, $1f, $70 ; entry 6
    db $e0, $0c, $1b, $50 ; entry 7
    db $e8, $0c, $19, $50 ; entry 8
    db $d0, $fc, $11, $50 ; entry 9
    db $e8, $04, $11, $50 ; entry 10
    db $e0, $04, $15, $50 ; entry 11
    db $f8, $f4, $11, $50 ; entry 12
    db $f0, $04, $16, $50 ; entry 13
    db $f0, $0c, $17, $50 ; entry 14
    db $f8, $01, $19, $50 ; entry 15
    db $f0, $fc, $11, $50 ; entry 16
    db $f8, $fb, $11, $50 ; entry 17
    db $d8, $14, $1d, $50 ; entry 18
    db $d0, $0c, $1e, $70 ; entry 19
    db $d8, $0c, $15, $10 ; entry 20
    db $d0, $04, $11, $10 ; entry 21
    db $d8, $04, $16, $50 ; entry 22
    db $80 ; end

; frame 17 of MetaSprites92Set00; ends with $80 (E-0147)
MetaSprites92Set00Frame17::
    db $f0, $e4, $1d, $30 ; entry 0
    db $e0, $e4, $19, $30 ; entry 1
    db $f8, $ec, $1e, $10 ; entry 2
    db $e0, $ec, $11, $30 ; entry 3
    db $d8, $ec, $16, $30 ; entry 4
    db $d8, $e4, $17, $30 ; entry 5
    db $d8, $fc, $1c, $70 ; entry 6
    db $f0, $0c, $14, $70 ; entry 7
    db $f0, $04, $15, $70 ; entry 8
    db $f8, $0c, $12, $70 ; entry 9
    db $f8, $04, $11, $70 ; entry 10
    db $f0, $fc, $11, $70 ; entry 11
    db $d0, $04, $16, $50 ; entry 12
    db $d0, $0c, $17, $50 ; entry 13
    db $e0, $02, $1f, $50 ; entry 14
    db $f8, $fc, $11, $70 ; entry 15
    db $d0, $ef, $19, $30 ; entry 16
    db $f8, $f4, $11, $10 ; entry 17
    db $f0, $f4, $11, $70 ; entry 18
    db $e8, $f4, $11, $70 ; entry 19
    db $e8, $ec, $11, $70 ; entry 20
    db $e0, $fa, $11, $70 ; entry 21
    db $e0, $f4, $11, $70 ; entry 22
    db $d8, $f4, $11, $70 ; entry 23
    db $d0, $fc, $11, $70 ; entry 24
    db $d0, $f4, $11, $70 ; entry 25
    db $f0, $ec, $11, $10 ; entry 26
    db $e8, $e4, $0a, $70 ; entry 27
    db $e8, $fc, $1c, $30 ; entry 28
    db $80 ; end

; frame 18 of MetaSprites92Set00; ends with $80 (E-0147)
MetaSprites92Set00Frame18::
    db $d8, $0c, $1d, $50 ; entry 0
    db $f0, $f4, $1c, $10 ; entry 1
    db $d8, $e4, $14, $10 ; entry 2
    db $d8, $ec, $15, $10 ; entry 3
    db $d0, $e4, $12, $10 ; entry 4
    db $d0, $ec, $11, $10 ; entry 5
    db $f8, $ec, $16, $30 ; entry 6
    db $f8, $e4, $17, $30 ; entry 7
    db $e0, $fc, $11, $10 ; entry 8
    db $e0, $04, $11, $10 ; entry 9
    db $f0, $fc, $11, $10 ; entry 10
    db $f8, $f4, $11, $10 ; entry 11
    db $d8, $04, $11, $70 ; entry 12
    db $e0, $0c, $0a, $10 ; entry 13
    db $d0, $f4, $19, $10 ; entry 14
    db $d0, $0c, $1e, $70 ; entry 15
    db $d8, $f4, $13, $10 ; entry 16
    db $d8, $fc, $1f, $30 ; entry 17
    db $d0, $04, $1e, $10 ; entry 18
    db $f0, $0c, $16, $50 ; entry 19
    db $f0, $14, $17, $50 ; entry 20
    db $f8, $09, $19, $50 ; entry 21
    db $e8, $05, $11, $50 ; entry 22
    db $e8, $fd, $11, $10 ; entry 23
    db $e0, $f4, $19, $70 ; entry 24
    db $f8, $f9, $19, $10 ; entry 25
    db $f8, $01, $1c, $10 ; entry 26
    db $f0, $04, $11, $10 ; entry 27
    db $e8, $f5, $1e, $50 ; entry 28
    db $e8, $15, $05, $70 ; entry 29
    db $e8, $0d, $15, $70 ; entry 30
    db $e0, $15, $0b, $10 ; entry 31
    db $d8, $16, $0e, $10 ; entry 32
    db $e5, $ed, $22, $30 ; entry 33
    db $e5, $dd, $21, $10 ; entry 34
    db $e5, $e5, $20, $10 ; entry 35
    db $80 ; end

; frame 19 of MetaSprites92Set00; ends with $80 (E-0147)
MetaSprites92Set00Frame19::
    db $d0, $d0, $03, $10 ; entry 0
    db $d8, $d0, $07, $10 ; entry 1
    db $e0, $d4, $23, $10 ; entry 2
    db $e2, $dc, $28, $10 ; entry 3
    db $e4, $e4, $23, $70 ; entry 4
    db $ec, $e9, $05, $30 ; entry 5
    db $ec, $e1, $06, $30 ; entry 6
    db $f8, $e8, $03, $30 ; entry 7
    db $f4, $ea, $04, $10 ; entry 8
    db $d0, $20, $03, $10 ; entry 9
    db $d8, $21, $04, $10 ; entry 10
    db $e0, $19, $05, $10 ; entry 11
    db $e0, $21, $06, $10 ; entry 12
    db $e8, $19, $07, $10 ; entry 13
    db $f0, $1c, $0b, $50 ; entry 14
    db $f8, $1b, $0e, $10 ; entry 15
    db $f0, $c8, $0b, $70 ; entry 16
    db $e8, $c7, $03, $10 ; entry 17
    db $f8, $cb, $0c, $10 ; entry 18
    db $e0, $c8, $0e, $10 ; entry 19
    db $d8, $c8, $0f, $10 ; entry 20
    db $d0, $c5, $0b, $30 ; entry 21
    db $f8, $38, $05, $30 ; entry 22
    db $f8, $30, $06, $30 ; entry 23
    db $f0, $32, $24, $10 ; entry 24
    db $e8, $22, $24, $70 ; entry 25
    db $ec, $2a, $28, $10 ; entry 26
    db $80 ; end

; frame 20 of MetaSprites92Set00; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set00Frame20::
    db $d0, $28, $03, $30 ; entry 0
    db $d8, $28, $07, $30 ; entry 1
    db $e0, $24, $23, $30 ; entry 2
    db $e2, $1c, $28, $30 ; entry 3
    db $e4, $14, $23, $50 ; entry 4
    db $ec, $0f, $05, $10 ; entry 5
    db $ec, $17, $06, $10 ; entry 6
    db $f8, $10, $03, $10 ; entry 7
    db $f4, $0e, $04, $30 ; entry 8
    db $d0, $d8, $03, $30 ; entry 9
    db $d8, $d7, $04, $30 ; entry 10
    db $e0, $df, $05, $30 ; entry 11
    db $e0, $d7, $06, $30 ; entry 12
    db $e8, $df, $07, $30 ; entry 13
    db $f0, $dc, $0b, $70 ; entry 14
    db $f8, $dd, $0e, $30 ; entry 15
    db $f0, $30, $0b, $50 ; entry 16
    db $e8, $31, $03, $30 ; entry 17
    db $f8, $2d, $0c, $30 ; entry 18
    db $e0, $30, $0e, $30 ; entry 19
    db $d8, $30, $0f, $30 ; entry 20
    db $d0, $33, $0b, $10 ; entry 21
    db $f8, $c0, $05, $10 ; entry 22
    db $f8, $c8, $06, $10 ; entry 23
    db $f0, $c6, $24, $30 ; entry 24
    db $e8, $d6, $24, $50 ; entry 25
    db $ec, $ce, $28, $30 ; entry 26
    db $80 ; end

; frame 21 of MetaSprites92Set00; ends with $80 (E-0147)
MetaSprites92Set00Frame21::
    db $f8, $48, $03, $70 ; entry 0
    db $f0, $48, $07, $70 ; entry 1
    db $e8, $42, $24, $10 ; entry 2
    db $e3, $3a, $26, $10 ; entry 3
    db $e0, $2a, $23, $10 ; entry 4
    db $d8, $25, $05, $50 ; entry 5
    db $d8, $2d, $06, $50 ; entry 6
    db $d0, $24, $04, $70 ; entry 7
    db $e1, $32, $25, $10 ; entry 8
    db $f8, $b0, $03, $50 ; entry 9
    db $f0, $b0, $07, $50 ; entry 10
    db $e8, $b6, $24, $30 ; entry 11
    db $e3, $be, $26, $30 ; entry 12
    db $e0, $ce, $23, $30 ; entry 13
    db $d8, $d3, $05, $70 ; entry 14
    db $d8, $cb, $06, $70 ; entry 15
    db $d0, $d4, $04, $50 ; entry 16
    db $e1, $c6, $25, $30 ; entry 17
    db $f0, $e9, $0b, $50 ; entry 18
    db $e8, $ea, $03, $30 ; entry 19
    db $f8, $e6, $0c, $30 ; entry 20
    db $e0, $e9, $0e, $30 ; entry 21
    db $d8, $e9, $0f, $30 ; entry 22
    db $d0, $ec, $0b, $10 ; entry 23
    db $f0, $0f, $0b, $70 ; entry 24
    db $e8, $0e, $03, $10 ; entry 25
    db $f8, $12, $0c, $10 ; entry 26
    db $e0, $0f, $0e, $10 ; entry 27
    db $d8, $0f, $0f, $10 ; entry 28
    db $d0, $0c, $0b, $30 ; entry 29
    db $80 ; end

; frame 22 of MetaSprites92Set00; ends with $80 (E-0147)
MetaSprites92Set00Frame22::
    db $80 ; end

; meta-sprite set 52 of MetaSprites92Table: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites92Set34::
    dw MetaSprites92Set34Frame0 ; entry 0
    dw MetaSprites92Set34Frame1 ; entry 1
    dw MetaSprites92Set34Frame2 ; entry 2
    dw MetaSprites92Set34Frame3 ; entry 3
    dw MetaSprites92Set34Frame4 ; entry 4
    dw MetaSprites92Set34Frame5 ; entry 5
    dw MetaSprites92Set34Frame6 ; entry 6
    dw MetaSprites92Set34Frame7 ; entry 7
    dw MetaSprites92Set34Frame8 ; entry 8
    dw MetaSprites92Set34Frame9 ; entry 9
    dw MetaSprites92Set34Frame10 ; entry 10
    dw MetaSprites92Set34Frame11 ; entry 11
    dw MetaSprites92Set34Frame12 ; entry 12
    dw MetaSprites92Set34Frame13 ; entry 13
    dw MetaSprites92Set34Frame14 ; entry 14
    dw MetaSprites92Set34Frame15 ; entry 15
    dw MetaSprites92Set34Frame16 ; entry 16
    dw MetaSprites92Set34Frame17 ; entry 17
    dw MetaSprites92Set34Frame18 ; entry 18
    dw MetaSprites92Set34Frame19 ; entry 19
    dw MetaSprites92Set34Frame20 ; entry 20
    dw MetaSprites92Set34Frame21 ; entry 21
    dw MetaSprites92Set34Frame21 ; entry 22
    dw MetaSprites92Set34Frame21 ; entry 23
    dw MetaSprites92Set34Frame21 ; entry 24
    dw MetaSprites92Set34Frame21 ; entry 25
    dw MetaSprites92Set34Frame21 ; entry 26
    dw MetaSprites92Set34Frame21 ; entry 27
    dw MetaSprites92Set34Frame21 ; entry 28
    dw MetaSprites92Set34Frame21 ; entry 29
    dw MetaSprites92Set34Frame21 ; entry 30
    dw MetaSprites92Set34Frame21 ; entry 31

; frame 0 of MetaSprites92Set34; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set34Frame0::
    db $f7, $f5, $05, $00 ; entry 0
    db $f8, $05, $0b, $00 ; entry 1
    db $80 ; end

; frame 1 of MetaSprites92Set34; ends with $80 (E-0147)
MetaSprites92Set34Frame1::
    db $f0, $05, $0a, $00 ; entry 0
    db $e8, $05, $0c, $00 ; entry 1
    db $ef, $f2, $04, $00 ; entry 2
    db $e7, $f5, $23, $00 ; entry 3
    db $f8, $05, $0c, $00 ; entry 4
    db $f7, $f5, $23, $20 ; entry 5
    db $80 ; end

; frame 2 of MetaSprites92Set34; ends with $80 (E-0147)
MetaSprites92Set34Frame2::
    db $e0, $05, $0c, $00 ; entry 0
    db $df, $f1, $23, $20 ; entry 1
    db $e7, $f5, $05, $00 ; entry 2
    db $e8, $05, $0b, $00 ; entry 3
    db $f0, $05, $0c, $00 ; entry 4
    db $ef, $f2, $23, $20 ; entry 5
    db $80 ; end

; frame 3 of MetaSprites92Set34; ends with $80 (E-0147)
MetaSprites92Set34Frame3::
    db $f8, $f0, $00, $00 ; entry 0
    db $f8, $f8, $01, $00 ; entry 1
    db $f8, $00, $06, $00 ; entry 2
    db $f8, $08, $07, $00 ; entry 3
    db $e0, $05, $0a, $00 ; entry 4
    db $df, $f5, $04, $20 ; entry 5
    db $d8, $05, $0b, $00 ; entry 6
    db $d7, $f1, $05, $00 ; entry 7
    db $80 ; end

; frame 4 of MetaSprites92Set34; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set34Frame4::
    db $f8, $e8, $00, $40 ; entry 0
    db $f8, $f0, $01, $40 ; entry 1
    db $f0, $e8, $02, $40 ; entry 2
    db $f0, $f0, $03, $40 ; entry 3
    db $f0, $10, $06, $20 ; entry 4
    db $f0, $08, $07, $20 ; entry 5
    db $f8, $10, $08, $20 ; entry 6
    db $f8, $08, $09, $20 ; entry 7
    db $d0, $05, $0c, $00 ; entry 8
    db $d0, $f5, $05, $00 ; entry 9
    db $80 ; end

; frame 5 of MetaSprites92Set34; ends with $80 (E-0147)
MetaSprites92Set34Frame5::
    db $f0, $f0, $00, $60 ; entry 0
    db $f0, $e8, $01, $60 ; entry 1
    db $e8, $f0, $02, $60 ; entry 2
    db $e8, $e8, $03, $60 ; entry 3
    db $e8, $08, $06, $00 ; entry 4
    db $e8, $10, $07, $00 ; entry 5
    db $f0, $08, $08, $00 ; entry 6
    db $f0, $10, $09, $00 ; entry 7
    db $f8, $ee, $04, $00 ; entry 8
    db $f8, $0a, $0a, $00 ; entry 9
    db $80 ; end

; frame 6 of MetaSprites92Set34; ends with $80 (E-0147)
MetaSprites92Set34Frame6::
    db $e8, $f8, $00, $60 ; entry 0
    db $e8, $f0, $01, $60 ; entry 1
    db $e0, $f8, $02, $60 ; entry 2
    db $e0, $f0, $03, $60 ; entry 3
    db $e0, $00, $06, $00 ; entry 4
    db $e0, $08, $07, $00 ; entry 5
    db $e8, $00, $08, $00 ; entry 6
    db $e8, $08, $09, $00 ; entry 7
    db $ec, $10, $0b, $00 ; entry 8
    db $f4, $0e, $0c, $00 ; entry 9
    db $ec, $e8, $05, $00 ; entry 10
    db $f4, $ea, $23, $20 ; entry 11
    db $80 ; end

; frame 7 of MetaSprites92Set34; ends with $80 (E-0147)
MetaSprites92Set34Frame7::
    db $e0, $f8, $06, $00 ; entry 0
    db $e0, $00, $07, $00 ; entry 1
    db $e8, $f8, $08, $00 ; entry 2
    db $e8, $00, $09, $00 ; entry 3
    db $e0, $f8, $00, $00 ; entry 4
    db $e0, $00, $01, $00 ; entry 5
    db $e8, $f8, $02, $00 ; entry 6
    db $e8, $00, $03, $00 ; entry 7
    db $e8, $08, $0a, $00 ; entry 8
    db $ea, $0e, $0c, $00 ; entry 9
    db $f0, $10, $0b, $00 ; entry 10
    db $e8, $f0, $04, $00 ; entry 11
    db $f0, $e8, $05, $00 ; entry 12
    db $ea, $ea, $23, $00 ; entry 13
    db $80 ; end

; frame 8 of MetaSprites92Set34; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set34Frame8::
    db $e0, $f0, $06, $00 ; entry 0
    db $e0, $f8, $07, $00 ; entry 1
    db $e8, $f0, $08, $00 ; entry 2
    db $e8, $f8, $09, $00 ; entry 3
    db $e8, $00, $00, $40 ; entry 4
    db $e8, $08, $01, $40 ; entry 5
    db $e0, $00, $02, $40 ; entry 6
    db $e0, $08, $03, $40 ; entry 7
    db $e4, $10, $0c, $00 ; entry 8
    db $e4, $e8, $23, $00 ; entry 9
    db $80 ; end

; frame 9 of MetaSprites92Set34; ends with $80 (E-0147)
MetaSprites92Set34Frame9::
    db $e8, $f0, $06, $20 ; entry 0
    db $e8, $e8, $07, $20 ; entry 1
    db $f0, $f0, $08, $20 ; entry 2
    db $f0, $e8, $09, $20 ; entry 3
    db $e8, $08, $00, $00 ; entry 4
    db $e8, $10, $01, $00 ; entry 5
    db $f0, $08, $02, $00 ; entry 6
    db $f0, $10, $03, $00 ; entry 7
    db $e0, $00, $05, $00 ; entry 8
    db $e0, $f8, $0b, $00 ; entry 9
    db $e2, $08, $04, $00 ; entry 10
    db $e2, $f0, $0a, $00 ; entry 11
    db $80 ; end

; frame 10 of MetaSprites92Set34; ends with $80 (E-0147)
MetaSprites92Set34Frame10::
    db $f0, $e8, $06, $00 ; entry 0
    db $f0, $f0, $07, $00 ; entry 1
    db $f8, $e8, $08, $00 ; entry 2
    db $f8, $f0, $09, $00 ; entry 3
    db $f0, $10, $00, $20 ; entry 4
    db $f0, $08, $01, $20 ; entry 5
    db $f8, $10, $02, $20 ; entry 6
    db $f8, $08, $03, $20 ; entry 7
    db $ea, $0c, $05, $20 ; entry 8
    db $e4, $0a, $23, $20 ; entry 9
    db $ea, $ec, $0b, $00 ; entry 10
    db $e4, $ee, $0c, $00 ; entry 11
    db $80 ; end

; frame 11 of MetaSprites92Set34; ends with $80 (E-0147)
MetaSprites92Set34Frame11::
    db $f8, $08, $02, $60 ; entry 0
    db $f8, $00, $03, $60 ; entry 1
    db $f8, $f8, $06, $20 ; entry 2
    db $f8, $f0, $07, $20 ; entry 3
    db $f2, $ee, $0c, $00 ; entry 4
    db $ee, $ec, $0c, $00 ; entry 5
    db $e8, $ec, $0c, $00 ; entry 6
    db $f2, $0a, $23, $00 ; entry 7
    db $ee, $0c, $23, $20 ; entry 8
    db $e8, $0c, $23, $00 ; entry 9
    db $80 ; end

; frame 12 of MetaSprites92Set34; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set34Frame12::
    db $e8, $f0, $28, $00 ; entry 0
    db $e8, $f8, $29, $00 ; entry 1
    db $e8, $08, $28, $20 ; entry 2
    db $e8, $00, $29, $20 ; entry 3
    db $f0, $e8, $2a, $00 ; entry 4
    db $f8, $e8, $2b, $00 ; entry 5
    db $f0, $f0, $2f, $00 ; entry 6
    db $f8, $f0, $2f, $00 ; entry 7
    db $f8, $f8, $2f, $00 ; entry 8
    db $f0, $f8, $2f, $00 ; entry 9
    db $f0, $00, $2f, $00 ; entry 10
    db $f8, $00, $2f, $00 ; entry 11
    db $f8, $08, $2f, $00 ; entry 12
    db $f0, $08, $2f, $00 ; entry 13
    db $f0, $10, $2a, $20 ; entry 14
    db $f8, $10, $2b, $20 ; entry 15
    db $80 ; end

; frame 13 of MetaSprites92Set34; ends with $80 (E-0147)
MetaSprites92Set34Frame13::
    db $f0, $f4, $25, $00 ; entry 0
    db $f0, $04, $25, $20 ; entry 1
    db $f0, $fc, $26, $00 ; entry 2
    db $f8, $f4, $27, $00 ; entry 3
    db $f8, $04, $27, $20 ; entry 4
    db $f8, $fc, $2f, $00 ; entry 5
    db $80 ; end

; frame 14 of MetaSprites92Set34; ends with $80 (E-0147)
MetaSprites92Set34Frame14::
    db $f0, $f4, $0d, $00 ; entry 0
    db $f0, $fc, $0e, $00 ; entry 1
    db $f8, $f4, $0f, $00 ; entry 2
    db $f8, $fc, $10, $00 ; entry 3
    db $f8, $04, $17, $00 ; entry 4
    db $80 ; end

; frame 15 of MetaSprites92Set34; ends with $80 (E-0147)
MetaSprites92Set34Frame15::
    db $f8, $f3, $15, $00 ; entry 0
    db $f8, $fb, $16, $00 ; entry 1
    db $f8, $03, $17, $00 ; entry 2
    db $e8, $f2, $11, $00 ; entry 3
    db $e8, $fa, $12, $00 ; entry 4
    db $f0, $f2, $13, $00 ; entry 5
    db $f0, $fa, $14, $00 ; entry 6
    db $80 ; end

; frame 16 of MetaSprites92Set34; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set34Frame16::
    db $f8, $f3, $20, $00 ; entry 0
    db $f8, $fb, $21, $00 ; entry 1
    db $f8, $03, $22, $00 ; entry 2
    db $f0, $f3, $1e, $00 ; entry 3
    db $f0, $fb, $1f, $00 ; entry 4
    db $e8, $f3, $1b, $00 ; entry 5
    db $e8, $fb, $1c, $00 ; entry 6
    db $e8, $03, $1d, $00 ; entry 7
    db $e0, $f3, $18, $00 ; entry 8
    db $e0, $fb, $19, $00 ; entry 9
    db $e0, $03, $1a, $00 ; entry 10
    db $80 ; end

; frame 17 of MetaSprites92Set34; ends with $80 (E-0147)
MetaSprites92Set34Frame17::
    db $e0, $f8, $24, $00 ; entry 0
    db $e0, $00, $24, $20 ; entry 1
    db $e8, $f8, $24, $40 ; entry 2
    db $e8, $00, $24, $60 ; entry 3
    db $80 ; end

; frame 18 of MetaSprites92Set34; ends with $80 (E-0147)
MetaSprites92Set34Frame18::
    db $dc, $f4, $25, $00 ; entry 0
    db $dc, $fc, $26, $00 ; entry 1
    db $e4, $f4, $27, $00 ; entry 2
    db $ec, $04, $25, $60 ; entry 3
    db $ec, $fc, $26, $60 ; entry 4
    db $e4, $04, $27, $60 ; entry 5
    db $e4, $fc, $2f, $00 ; entry 6
    db $dc, $04, $25, $20 ; entry 7
    db $ec, $f4, $25, $40 ; entry 8
    db $80 ; end

; frame 19 of MetaSprites92Set34; ends with $80 (E-0147)
MetaSprites92Set34Frame19::
    db $d0, $f0, $28, $00 ; entry 0
    db $d0, $f8, $29, $00 ; entry 1
    db $d0, $08, $28, $20 ; entry 2
    db $d0, $00, $29, $20 ; entry 3
    db $d8, $e8, $2a, $00 ; entry 4
    db $e0, $e8, $2b, $00 ; entry 5
    db $d8, $f0, $2f, $00 ; entry 6
    db $e0, $f0, $2f, $00 ; entry 7
    db $e0, $f8, $2f, $00 ; entry 8
    db $d8, $f8, $2f, $00 ; entry 9
    db $f0, $e8, $2a, $40 ; entry 10
    db $e8, $e8, $2b, $40 ; entry 11
    db $e8, $f0, $2f, $00 ; entry 12
    db $f0, $f0, $2f, $00 ; entry 13
    db $f0, $f8, $2f, $00 ; entry 14
    db $e8, $f8, $2f, $00 ; entry 15
    db $d8, $00, $2f, $00 ; entry 16
    db $e0, $00, $2f, $00 ; entry 17
    db $e0, $08, $2f, $00 ; entry 18
    db $d8, $08, $2f, $00 ; entry 19
    db $e8, $00, $2f, $00 ; entry 20
    db $f0, $00, $2f, $00 ; entry 21
    db $f0, $08, $2f, $00 ; entry 22
    db $e8, $08, $2f, $00 ; entry 23
    db $f8, $f0, $28, $40 ; entry 24
    db $f8, $f8, $29, $40 ; entry 25
    db $f8, $08, $28, $60 ; entry 26
    db $f8, $00, $29, $60 ; entry 27
    db $d8, $10, $2a, $20 ; entry 28
    db $e0, $10, $2b, $20 ; entry 29
    db $f0, $10, $2a, $60 ; entry 30
    db $e8, $10, $2b, $60 ; entry 31
    db $80 ; end

; frame 20 of MetaSprites92Set34; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set34Frame20::
    db $d8, $f0, $2c, $00 ; entry 0
    db $d8, $f8, $2d, $00 ; entry 1
    db $d8, $08, $2c, $20 ; entry 2
    db $d8, $00, $2d, $20 ; entry 3
    db $e0, $f0, $2e, $00 ; entry 4
    db $e0, $f8, $2f, $00 ; entry 5
    db $e0, $00, $2f, $20 ; entry 6
    db $e0, $08, $2e, $20 ; entry 7
    db $f0, $f0, $2c, $40 ; entry 8
    db $f0, $f8, $2d, $40 ; entry 9
    db $e8, $f0, $2e, $40 ; entry 10
    db $e8, $f8, $2f, $40 ; entry 11
    db $f0, $08, $2c, $60 ; entry 12
    db $f0, $00, $2d, $60 ; entry 13
    db $e8, $08, $2e, $60 ; entry 14
    db $e8, $00, $2f, $60 ; entry 15
    db $80 ; end

; frame 21 of MetaSprites92Set34; ends with $80 (E-0147)
MetaSprites92Set34Frame21::
    db $80 ; end

; meta-sprite set 53 of MetaSprites92Table: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites92Set35::
    dw MetaSprites92Set35Frame0 ; entry 0
    dw MetaSprites92Set35Frame1 ; entry 1
    dw MetaSprites92Set35Frame2 ; entry 2
    dw MetaSprites92Set35Frame3 ; entry 3
    dw MetaSprites92Set35Frame4 ; entry 4
    dw MetaSprites92Set35Frame5 ; entry 5
    dw MetaSprites92Set35Frame6 ; entry 6
    dw MetaSprites92Set35Frame7 ; entry 7
    dw MetaSprites92Set35Frame8 ; entry 8
    dw MetaSprites92Set35Frame9 ; entry 9
    dw MetaSprites92Set35Frame10 ; entry 10
    dw MetaSprites92Set35Frame11 ; entry 11
    dw MetaSprites92Set35Frame12 ; entry 12
    dw MetaSprites92Set35Frame13 ; entry 13
    dw MetaSprites92Set35Frame14 ; entry 14
    dw MetaSprites92Set35Frame15 ; entry 15
    dw MetaSprites92Set35Frame16 ; entry 16
    dw MetaSprites92Set35Frame17 ; entry 17
    dw MetaSprites92Set35Frame18 ; entry 18
    dw MetaSprites92Set35Frame19 ; entry 19
    dw MetaSprites92Set35Frame20 ; entry 20
    dw MetaSprites92Set35Frame21 ; entry 21
    dw MetaSprites92Set35Frame22 ; entry 22
    dw MetaSprites92Set35Frame23 ; entry 23
    dw MetaSprites92Set35Frame24 ; entry 24
    dw MetaSprites92Set35Frame24 ; entry 25
    dw MetaSprites92Set35Frame24 ; entry 26
    dw MetaSprites92Set35Frame24 ; entry 27
    dw MetaSprites92Set35Frame24 ; entry 28
    dw MetaSprites92Set35Frame24 ; entry 29
    dw MetaSprites92Set35Frame24 ; entry 30
    dw MetaSprites92Set35Frame24 ; entry 31

; frame 0 of MetaSprites92Set35; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set35Frame0::
    db $f8, $b8, $21, $00 ; entry 0
    db $f8, $c0, $22, $00 ; entry 1
    db $f8, $c8, $23, $00 ; entry 2
    db $f8, $d8, $21, $20 ; entry 3
    db $f8, $d0, $22, $20 ; entry 4
    db $f8, $40, $21, $20 ; entry 5
    db $f8, $38, $22, $20 ; entry 6
    db $f8, $30, $23, $20 ; entry 7
    db $f8, $20, $21, $00 ; entry 8
    db $f8, $28, $22, $00 ; entry 9
    db $80 ; end

; frame 1 of MetaSprites92Set35; ends with $80 (E-0147)
MetaSprites92Set35Frame1::
    db $f8, $bc, $14, $00 ; entry 0
    db $f8, $c4, $15, $00 ; entry 1
    db $f8, $d4, $14, $20 ; entry 2
    db $f8, $cc, $15, $20 ; entry 3
    db $f8, $24, $14, $00 ; entry 4
    db $f8, $2c, $15, $00 ; entry 5
    db $f8, $3c, $14, $20 ; entry 6
    db $f8, $34, $15, $20 ; entry 7
    db $f0, $bc, $10, $00 ; entry 8
    db $f0, $c4, $11, $00 ; entry 9
    db $f0, $d4, $10, $20 ; entry 10
    db $f0, $cc, $11, $20 ; entry 11
    db $f0, $24, $10, $00 ; entry 12
    db $f0, $2c, $11, $00 ; entry 13
    db $f0, $3c, $10, $20 ; entry 14
    db $f0, $34, $11, $20 ; entry 15
    db $80 ; end

; frame 2 of MetaSprites92Set35; ends with $80 (E-0147)
MetaSprites92Set35Frame2::
    db $f0, $bc, $14, $00 ; entry 0
    db $f0, $c4, $15, $00 ; entry 1
    db $f0, $d4, $14, $20 ; entry 2
    db $f0, $cc, $15, $20 ; entry 3
    db $e8, $bc, $10, $00 ; entry 4
    db $e8, $c4, $11, $00 ; entry 5
    db $e8, $d4, $10, $20 ; entry 6
    db $e8, $cc, $11, $20 ; entry 7
    db $f8, $cc, $19, $20 ; entry 8
    db $f8, $c4, $19, $20 ; entry 9
    db $f0, $3c, $14, $20 ; entry 10
    db $f0, $34, $15, $20 ; entry 11
    db $f0, $24, $14, $00 ; entry 12
    db $f0, $2c, $15, $00 ; entry 13
    db $e8, $3c, $10, $20 ; entry 14
    db $e8, $34, $11, $20 ; entry 15
    db $e8, $24, $10, $00 ; entry 16
    db $e8, $2c, $11, $00 ; entry 17
    db $f8, $d4, $1a, $20 ; entry 18
    db $f8, $bc, $1a, $00 ; entry 19
    db $f8, $2c, $19, $00 ; entry 20
    db $f8, $34, $19, $00 ; entry 21
    db $f8, $24, $1a, $00 ; entry 22
    db $f8, $3c, $1a, $20 ; entry 23
    db $80 ; end

; frame 3 of MetaSprites92Set35; ends with $80 (E-0147)
MetaSprites92Set35Frame3::
    db $f8, $c8, $19, $00 ; entry 0
    db $f8, $c0, $1c, $00 ; entry 1
    db $f8, $d0, $1c, $20 ; entry 2
    db $f0, $b8, $24, $00 ; entry 3
    db $f0, $c0, $25, $00 ; entry 4
    db $f0, $c8, $27, $00 ; entry 5
    db $f0, $d8, $24, $20 ; entry 6
    db $f0, $d0, $25, $20 ; entry 7
    db $e8, $bd, $21, $00 ; entry 8
    db $e8, $c5, $22, $00 ; entry 9
    db $e8, $d3, $21, $20 ; entry 10
    db $e8, $cb, $22, $20 ; entry 11
    db $f8, $30, $19, $20 ; entry 12
    db $f8, $38, $1c, $20 ; entry 13
    db $f8, $28, $1c, $00 ; entry 14
    db $f0, $40, $24, $20 ; entry 15
    db $f0, $38, $25, $20 ; entry 16
    db $f0, $30, $27, $20 ; entry 17
    db $f0, $20, $24, $00 ; entry 18
    db $f0, $28, $25, $00 ; entry 19
    db $e8, $3b, $21, $20 ; entry 20
    db $e8, $33, $22, $20 ; entry 21
    db $e8, $25, $21, $00 ; entry 22
    db $e8, $2d, $22, $00 ; entry 23
    db $80 ; end

; frame 4 of MetaSprites92Set35; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set35Frame4::
    db $f8, $b8, $24, $00 ; entry 0
    db $f8, $c0, $25, $00 ; entry 1
    db $f8, $c8, $27, $00 ; entry 2
    db $f8, $d8, $24, $20 ; entry 3
    db $f8, $d0, $25, $20 ; entry 4
    db $f0, $bd, $21, $00 ; entry 5
    db $f0, $c5, $22, $00 ; entry 6
    db $f0, $d3, $21, $20 ; entry 7
    db $f0, $cb, $22, $20 ; entry 8
    db $f8, $40, $24, $20 ; entry 9
    db $f8, $38, $25, $20 ; entry 10
    db $f8, $30, $27, $20 ; entry 11
    db $f8, $20, $24, $00 ; entry 12
    db $f8, $28, $25, $00 ; entry 13
    db $f0, $3b, $21, $20 ; entry 14
    db $f0, $33, $22, $20 ; entry 15
    db $f0, $25, $21, $00 ; entry 16
    db $f0, $2d, $22, $00 ; entry 17
    db $80 ; end

; frame 5 of MetaSprites92Set35; ends with $80 (E-0147)
MetaSprites92Set35Frame5::
    db $f8, $d0, $21, $00 ; entry 0
    db $f8, $d8, $22, $00 ; entry 1
    db $f8, $e0, $23, $00 ; entry 2
    db $f8, $f0, $21, $20 ; entry 3
    db $f8, $e8, $22, $20 ; entry 4
    db $f8, $28, $21, $20 ; entry 5
    db $f8, $20, $22, $20 ; entry 6
    db $f8, $18, $23, $20 ; entry 7
    db $f8, $08, $21, $00 ; entry 8
    db $f8, $10, $22, $00 ; entry 9
    db $80 ; end

; frame 6 of MetaSprites92Set35; ends with $80 (E-0147)
MetaSprites92Set35Frame6::
    db $f8, $d4, $14, $00 ; entry 0
    db $f8, $dc, $15, $00 ; entry 1
    db $f8, $ec, $14, $20 ; entry 2
    db $f8, $e4, $15, $20 ; entry 3
    db $f8, $0c, $14, $00 ; entry 4
    db $f8, $14, $15, $00 ; entry 5
    db $f8, $24, $14, $20 ; entry 6
    db $f8, $1c, $15, $20 ; entry 7
    db $f0, $d4, $10, $00 ; entry 8
    db $f0, $dc, $11, $00 ; entry 9
    db $f0, $ec, $10, $20 ; entry 10
    db $f0, $e4, $11, $20 ; entry 11
    db $f0, $0c, $10, $00 ; entry 12
    db $f0, $14, $11, $00 ; entry 13
    db $f0, $24, $10, $20 ; entry 14
    db $f0, $1c, $11, $20 ; entry 15
    db $80 ; end

; frame 7 of MetaSprites92Set35; ends with $80 (E-0147)
MetaSprites92Set35Frame7::
    db $e8, $d4, $14, $00 ; entry 0
    db $e8, $dc, $15, $00 ; entry 1
    db $e8, $ec, $14, $20 ; entry 2
    db $e8, $e4, $15, $20 ; entry 3
    db $e0, $d4, $10, $00 ; entry 4
    db $e0, $dc, $11, $00 ; entry 5
    db $e0, $ec, $10, $20 ; entry 6
    db $e0, $e4, $11, $20 ; entry 7
    db $f8, $d4, $1a, $00 ; entry 8
    db $f8, $dc, $1c, $00 ; entry 9
    db $f0, $dc, $19, $00 ; entry 10
    db $f8, $e4, $1c, $20 ; entry 11
    db $f0, $e4, $19, $00 ; entry 12
    db $f8, $ec, $1a, $20 ; entry 13
    db $e8, $24, $14, $20 ; entry 14
    db $e8, $1c, $15, $20 ; entry 15
    db $e8, $0c, $14, $00 ; entry 16
    db $e8, $14, $15, $00 ; entry 17
    db $e0, $24, $10, $20 ; entry 18
    db $e0, $1c, $11, $20 ; entry 19
    db $e0, $0c, $10, $00 ; entry 20
    db $e0, $14, $11, $00 ; entry 21
    db $f8, $24, $1a, $20 ; entry 22
    db $f8, $1c, $1c, $20 ; entry 23
    db $f0, $1c, $19, $20 ; entry 24
    db $f8, $14, $1c, $00 ; entry 25
    db $f0, $14, $19, $20 ; entry 26
    db $f8, $0c, $1a, $00 ; entry 27
    db $80 ; end

; frame 8 of MetaSprites92Set35; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set35Frame8::
    db $f8, $d0, $1a, $00 ; entry 0
    db $f8, $f0, $1a, $20 ; entry 1
    db $f0, $e0, $19, $00 ; entry 2
    db $f8, $d8, $1f, $00 ; entry 3
    db $f8, $e8, $1f, $20 ; entry 4
    db $f0, $d8, $1c, $00 ; entry 5
    db $f0, $e8, $1c, $20 ; entry 6
    db $f8, $e0, $1c, $00 ; entry 7
    db $e8, $d0, $24, $00 ; entry 8
    db $e8, $d8, $25, $00 ; entry 9
    db $e8, $e0, $27, $00 ; entry 10
    db $e8, $f0, $24, $20 ; entry 11
    db $e8, $e8, $25, $20 ; entry 12
    db $e0, $d5, $21, $00 ; entry 13
    db $e0, $dd, $22, $00 ; entry 14
    db $e0, $eb, $21, $20 ; entry 15
    db $e0, $e3, $22, $20 ; entry 16
    db $f8, $28, $1a, $20 ; entry 17
    db $f8, $08, $1a, $00 ; entry 18
    db $f0, $18, $19, $20 ; entry 19
    db $f8, $20, $1f, $20 ; entry 20
    db $f8, $10, $1f, $00 ; entry 21
    db $f0, $20, $1c, $20 ; entry 22
    db $f0, $10, $1c, $00 ; entry 23
    db $f8, $18, $1c, $20 ; entry 24
    db $e8, $28, $24, $20 ; entry 25
    db $e8, $20, $25, $20 ; entry 26
    db $e8, $18, $27, $20 ; entry 27
    db $e8, $08, $24, $00 ; entry 28
    db $e8, $10, $25, $00 ; entry 29
    db $e0, $23, $21, $20 ; entry 30
    db $e0, $1b, $22, $20 ; entry 31
    db $e0, $0d, $21, $00 ; entry 32
    db $e0, $15, $22, $00 ; entry 33
    db $80 ; end

; frame 9 of MetaSprites92Set35; ends with $80 (E-0147)
MetaSprites92Set35Frame9::
    db $f8, $e0, $19, $00 ; entry 0
    db $f8, $d8, $1c, $00 ; entry 1
    db $f8, $e8, $1c, $20 ; entry 2
    db $f0, $d0, $24, $00 ; entry 3
    db $f0, $d8, $25, $00 ; entry 4
    db $f0, $e0, $27, $00 ; entry 5
    db $f0, $f0, $24, $20 ; entry 6
    db $f0, $e8, $25, $20 ; entry 7
    db $e8, $d5, $21, $00 ; entry 8
    db $e8, $dd, $22, $00 ; entry 9
    db $e8, $eb, $21, $20 ; entry 10
    db $e8, $e3, $22, $20 ; entry 11
    db $f8, $18, $19, $20 ; entry 12
    db $f8, $20, $1c, $20 ; entry 13
    db $f8, $10, $1c, $00 ; entry 14
    db $f0, $28, $24, $20 ; entry 15
    db $f0, $20, $25, $20 ; entry 16
    db $f0, $18, $27, $20 ; entry 17
    db $f0, $08, $24, $00 ; entry 18
    db $f0, $10, $25, $00 ; entry 19
    db $e8, $23, $21, $20 ; entry 20
    db $e8, $1b, $22, $20 ; entry 21
    db $e8, $0d, $21, $00 ; entry 22
    db $e8, $15, $22, $00 ; entry 23
    db $f8, $d0, $1a, $00 ; entry 24
    db $f8, $f0, $1a, $20 ; entry 25
    db $f8, $08, $1a, $00 ; entry 26
    db $f8, $28, $1a, $20 ; entry 27
    db $80 ; end

; frame 10 of MetaSprites92Set35; ends with $80 (E-0147)
MetaSprites92Set35Frame10::
    db $f0, $e0, $10, $00 ; entry 0
    db $f0, $e8, $11, $00 ; entry 1
    db $f0, $f0, $12, $00 ; entry 2
    db $f0, $f8, $13, $00 ; entry 3
    db $f0, $18, $10, $20 ; entry 4
    db $f0, $10, $11, $20 ; entry 5
    db $f0, $08, $12, $20 ; entry 6
    db $f0, $00, $13, $20 ; entry 7
    db $f8, $e0, $14, $00 ; entry 8
    db $f8, $e8, $15, $00 ; entry 9
    db $f8, $f0, $16, $00 ; entry 10
    db $f8, $f8, $17, $00 ; entry 11
    db $f8, $18, $14, $20 ; entry 12
    db $f8, $10, $15, $20 ; entry 13
    db $f8, $08, $16, $20 ; entry 14
    db $f8, $00, $17, $20 ; entry 15
    db $80 ; end

; frame 11 of MetaSprites92Set35; ends with $80 (E-0147)
MetaSprites92Set35Frame11::
    db $f0, $e8, $18, $00 ; entry 0
    db $f0, $f8, $18, $00 ; entry 1
    db $f8, $e0, $1a, $00 ; entry 2
    db $f8, $e8, $1b, $00 ; entry 3
    db $f8, $f0, $1c, $00 ; entry 4
    db $f0, $f0, $19, $00 ; entry 5
    db $f8, $f8, $19, $00 ; entry 6
    db $f0, $10, $18, $20 ; entry 7
    db $f0, $00, $18, $20 ; entry 8
    db $f8, $10, $1b, $20 ; entry 9
    db $f8, $08, $1c, $20 ; entry 10
    db $f0, $08, $19, $20 ; entry 11
    db $f8, $00, $19, $20 ; entry 12
    db $f8, $18, $1a, $20 ; entry 13
    db $e0, $e0, $10, $00 ; entry 14
    db $e0, $e8, $11, $00 ; entry 15
    db $e0, $f0, $12, $00 ; entry 16
    db $e0, $f8, $13, $00 ; entry 17
    db $e0, $18, $10, $20 ; entry 18
    db $e0, $10, $11, $20 ; entry 19
    db $e0, $08, $12, $20 ; entry 20
    db $e0, $00, $13, $20 ; entry 21
    db $e8, $e0, $14, $00 ; entry 22
    db $e8, $e8, $15, $00 ; entry 23
    db $e8, $f0, $16, $00 ; entry 24
    db $e8, $f8, $17, $00 ; entry 25
    db $e8, $18, $14, $20 ; entry 26
    db $e8, $10, $15, $20 ; entry 27
    db $e8, $08, $16, $20 ; entry 28
    db $e8, $00, $17, $20 ; entry 29
    db $80 ; end

; frame 12 of MetaSprites92Set35; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set35Frame12::
    db $e8, $e8, $18, $00 ; entry 0
    db $e8, $f8, $18, $00 ; entry 1
    db $f0, $e0, $1a, $00 ; entry 2
    db $f0, $e8, $1b, $00 ; entry 3
    db $f0, $f0, $1c, $00 ; entry 4
    db $e8, $f0, $19, $00 ; entry 5
    db $f0, $f8, $19, $00 ; entry 6
    db $e8, $10, $18, $20 ; entry 7
    db $e8, $00, $18, $20 ; entry 8
    db $f0, $10, $1b, $20 ; entry 9
    db $f0, $08, $1c, $20 ; entry 10
    db $e8, $08, $19, $20 ; entry 11
    db $f0, $00, $19, $20 ; entry 12
    db $f0, $18, $1a, $20 ; entry 13
    db $f8, $d8, $20, $00 ; entry 14
    db $f8, $20, $20, $20 ; entry 15
    db $f8, $e0, $1d, $00 ; entry 16
    db $f8, $e8, $1e, $00 ; entry 17
    db $f8, $f0, $1f, $00 ; entry 18
    db $f8, $18, $1d, $20 ; entry 19
    db $f8, $10, $1e, $20 ; entry 20
    db $f8, $08, $1f, $20 ; entry 21
    db $f8, $f8, $1c, $00 ; entry 22
    db $f8, $00, $1c, $20 ; entry 23
    db $d8, $e0, $10, $00 ; entry 24
    db $d8, $e8, $11, $00 ; entry 25
    db $d8, $f0, $12, $00 ; entry 26
    db $d8, $f8, $13, $00 ; entry 27
    db $d8, $18, $10, $20 ; entry 28
    db $d8, $10, $11, $20 ; entry 29
    db $d8, $08, $12, $20 ; entry 30
    db $d8, $00, $13, $20 ; entry 31
    db $e0, $e0, $14, $00 ; entry 32
    db $e0, $e8, $15, $00 ; entry 33
    db $e0, $f0, $16, $00 ; entry 34
    db $e0, $f8, $17, $00 ; entry 35
    db $e0, $18, $14, $20 ; entry 36
    db $e0, $10, $15, $20 ; entry 37
    db $e0, $08, $16, $20 ; entry 38
    db $e0, $00, $17, $20 ; entry 39
    db $80 ; end

; frame 13 of MetaSprites92Set35; ends with $80 (E-0147)
MetaSprites92Set35Frame13::
    db $d8, $e8, $21, $00 ; entry 0
    db $d8, $f0, $22, $00 ; entry 1
    db $d8, $f8, $23, $00 ; entry 2
    db $e0, $e0, $24, $00 ; entry 3
    db $e0, $e8, $25, $00 ; entry 4
    db $e0, $f0, $26, $00 ; entry 5
    db $e0, $f8, $27, $00 ; entry 6
    db $d8, $10, $21, $20 ; entry 7
    db $d8, $08, $22, $20 ; entry 8
    db $d8, $00, $23, $20 ; entry 9
    db $e0, $10, $25, $20 ; entry 10
    db $e0, $08, $26, $20 ; entry 11
    db $e0, $00, $27, $20 ; entry 12
    db $e0, $18, $24, $20 ; entry 13
    db $e8, $e8, $18, $00 ; entry 14
    db $f8, $e0, $1a, $00 ; entry 15
    db $e8, $10, $18, $20 ; entry 16
    db $f8, $10, $1b, $20 ; entry 17
    db $f8, $08, $1c, $20 ; entry 18
    db $f8, $00, $19, $20 ; entry 19
    db $f8, $18, $1a, $20 ; entry 20
    db $f0, $10, $18, $20 ; entry 21
    db $f0, $00, $18, $20 ; entry 22
    db $f0, $08, $19, $20 ; entry 23
    db $f8, $e8, $1b, $00 ; entry 24
    db $f8, $f0, $1c, $00 ; entry 25
    db $f8, $f8, $19, $00 ; entry 26
    db $f0, $e8, $18, $00 ; entry 27
    db $f0, $f8, $18, $00 ; entry 28
    db $f0, $f0, $19, $00 ; entry 29
    db $e8, $f0, $18, $00 ; entry 30
    db $e8, $f8, $18, $20 ; entry 31
    db $e8, $00, $18, $00 ; entry 32
    db $e8, $08, $18, $20 ; entry 33
    db $80 ; end

; frame 14 of MetaSprites92Set35; ends with $80 (E-0147)
MetaSprites92Set35Frame14::
    db $d8, $fc, $00, $00 ; entry 0
    db $d0, $fc, $01, $00 ; entry 1
    db $e0, $f0, $26, $00 ; entry 2
    db $e0, $08, $26, $20 ; entry 3
    db $f8, $e0, $1a, $00 ; entry 4
    db $f8, $10, $1b, $20 ; entry 5
    db $f8, $18, $1a, $20 ; entry 6
    db $f0, $10, $18, $20 ; entry 7
    db $f0, $08, $19, $00 ; entry 8
    db $f8, $e8, $1b, $00 ; entry 9
    db $f0, $e8, $18, $00 ; entry 10
    db $f0, $f0, $19, $20 ; entry 11
    db $d0, $f0, $28, $00 ; entry 12
    db $d8, $f0, $29, $00 ; entry 13
    db $d0, $08, $28, $20 ; entry 14
    db $d8, $08, $29, $20 ; entry 15
    db $f8, $00, $19, $20 ; entry 16
    db $f0, $00, $18, $20 ; entry 17
    db $f8, $f8, $19, $00 ; entry 18
    db $f0, $f8, $18, $00 ; entry 19
    db $e0, $00, $1a, $00 ; entry 20
    db $e8, $00, $1d, $00 ; entry 21
    db $e8, $08, $1e, $00 ; entry 22
    db $e0, $f8, $1a, $20 ; entry 23
    db $e8, $f8, $1d, $20 ; entry 24
    db $e8, $f0, $1e, $20 ; entry 25
    db $f8, $08, $1f, $00 ; entry 26
    db $f8, $f0, $1f, $20 ; entry 27
    db $d8, $e0, $10, $00 ; entry 28
    db $d8, $e8, $11, $00 ; entry 29
    db $e0, $e0, $14, $00 ; entry 30
    db $e0, $e8, $15, $00 ; entry 31
    db $d8, $18, $10, $20 ; entry 32
    db $d8, $10, $11, $20 ; entry 33
    db $e0, $18, $14, $20 ; entry 34
    db $e0, $10, $15, $20 ; entry 35
    db $e8, $e8, $27, $00 ; entry 36
    db $e8, $10, $27, $20 ; entry 37
    db $80 ; end

; frame 15 of MetaSprites92Set35; ends with $80 (E-0147)
MetaSprites92Set35Frame15::
    db $e8, $fc, $00, $00 ; entry 0
    db $e0, $fc, $01, $00 ; entry 1
    db $d0, $fc, $03, $00 ; entry 2
    db $d8, $fc, $02, $00 ; entry 3
    db $f8, $e0, $1a, $00 ; entry 4
    db $f8, $18, $1a, $20 ; entry 5
    db $f0, $08, $19, $00 ; entry 6
    db $f0, $f0, $19, $20 ; entry 7
    db $e8, $f0, $18, $00 ; entry 8
    db $e8, $08, $18, $20 ; entry 9
    db $f0, $00, $1a, $00 ; entry 10
    db $f8, $00, $1d, $00 ; entry 11
    db $f0, $f8, $1a, $20 ; entry 12
    db $f8, $f8, $1d, $20 ; entry 13
    db $f8, $08, $1e, $00 ; entry 14
    db $d0, $e8, $21, $00 ; entry 15
    db $d8, $e0, $24, $00 ; entry 16
    db $d8, $e8, $25, $00 ; entry 17
    db $d8, $f0, $26, $00 ; entry 18
    db $d0, $10, $21, $20 ; entry 19
    db $d8, $10, $25, $20 ; entry 20
    db $d8, $08, $26, $20 ; entry 21
    db $d8, $18, $24, $20 ; entry 22
    db $d0, $f0, $29, $00 ; entry 23
    db $d0, $08, $29, $20 ; entry 24
    db $e0, $f0, $1c, $20 ; entry 25
    db $e0, $08, $1c, $00 ; entry 26
    db $f0, $10, $1c, $00 ; entry 27
    db $e8, $10, $19, $00 ; entry 28
    db $e0, $10, $1b, $00 ; entry 29
    db $f0, $e8, $1c, $20 ; entry 30
    db $e8, $e8, $19, $20 ; entry 31
    db $e0, $e8, $1b, $20 ; entry 32
    db $f8, $f0, $1e, $20 ; entry 33
    db $f8, $e8, $1e, $20 ; entry 34
    db $f8, $10, $1e, $00 ; entry 35
    db $e0, $f8, $2e, $00 ; entry 36
    db $e0, $00, $2f, $00 ; entry 37
    db $e8, $00, $2e, $60 ; entry 38
    db $e8, $f8, $2f, $60 ; entry 39
    db $80 ; end

; frame 16 of MetaSprites92Set35; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set35Frame16::
    db $f0, $fc, $01, $00 ; entry 0
    db $e0, $fc, $03, $00 ; entry 1
    db $d8, $fc, $04, $00 ; entry 2
    db $d0, $fc, $05, $00 ; entry 3
    db $d8, $10, $21, $20 ; entry 4
    db $e0, $10, $25, $20 ; entry 5
    db $e0, $08, $26, $20 ; entry 6
    db $e0, $18, $24, $20 ; entry 7
    db $f8, $18, $1a, $20 ; entry 8
    db $d8, $e8, $21, $00 ; entry 9
    db $e0, $e0, $24, $00 ; entry 10
    db $e0, $e8, $25, $00 ; entry 11
    db $e0, $f0, $26, $00 ; entry 12
    db $f8, $e0, $1a, $00 ; entry 13
    db $d0, $f0, $28, $00 ; entry 14
    db $d8, $f0, $29, $00 ; entry 15
    db $d0, $08, $28, $20 ; entry 16
    db $d8, $08, $29, $20 ; entry 17
    db $f8, $08, $1b, $00 ; entry 18
    db $f8, $f0, $1b, $20 ; entry 19
    db $f0, $08, $1e, $00 ; entry 20
    db $e8, $08, $1b, $00 ; entry 21
    db $e8, $10, $1c, $00 ; entry 22
    db $f0, $f0, $1e, $20 ; entry 23
    db $e8, $f0, $1b, $20 ; entry 24
    db $e8, $e8, $1c, $20 ; entry 25
    db $e8, $fc, $02, $00 ; entry 26
    db $f8, $f8, $2c, $00 ; entry 27
    db $f8, $ff, $2c, $20 ; entry 28
    db $f8, $10, $1f, $00 ; entry 29
    db $f8, $e8, $1f, $20 ; entry 30
    db $f0, $10, $19, $00 ; entry 31
    db $f0, $e8, $19, $20 ; entry 32
    db $e0, $00, $2e, $20 ; entry 33
    db $e0, $f8, $2f, $20 ; entry 34
    db $e8, $f8, $2e, $40 ; entry 35
    db $e8, $00, $2f, $40 ; entry 36
    db $80 ; end

; frame 17 of MetaSprites92Set35; ends with $80 (E-0147)
MetaSprites92Set35Frame17::
    db $d0, $fc, $05, $00 ; entry 0
    db $d8, $fc, $05, $00 ; entry 1
    db $f0, $20, $10, $20 ; entry 2
    db $f0, $18, $11, $20 ; entry 3
    db $f0, $10, $12, $20 ; entry 4
    db $f0, $08, $13, $20 ; entry 5
    db $f8, $08, $27, $20 ; entry 6
    db $f8, $20, $14, $20 ; entry 7
    db $f8, $18, $1c, $20 ; entry 8
    db $f8, $10, $1c, $20 ; entry 9
    db $f0, $d8, $10, $00 ; entry 10
    db $f0, $e0, $11, $00 ; entry 11
    db $f0, $e8, $12, $00 ; entry 12
    db $f0, $f0, $13, $00 ; entry 13
    db $f8, $f0, $27, $00 ; entry 14
    db $f8, $d8, $14, $00 ; entry 15
    db $f8, $e0, $1c, $00 ; entry 16
    db $f8, $e8, $1c, $00 ; entry 17
    db $f8, $f8, $29, $00 ; entry 18
    db $f8, $00, $29, $20 ; entry 19
    db $f0, $f8, $28, $00 ; entry 20
    db $f0, $00, $28, $20 ; entry 21
    db $e8, $fc, $03, $00 ; entry 22
    db $e0, $fc, $04, $00 ; entry 23
    db $80 ; end

; frame 18 of MetaSprites92Set35; ends with $80 (E-0147)
MetaSprites92Set35Frame18::
    db $f8, $fb, $0c, $20 ; entry 0
    db $f0, $fb, $0c, $20 ; entry 1
    db $e8, $fb, $0c, $20 ; entry 2
    db $e0, $fb, $0c, $20 ; entry 3
    db $d8, $fb, $0c, $20 ; entry 4
    db $d0, $fb, $0c, $20 ; entry 5
    db $f8, $03, $1e, $20 ; entry 6
    db $e8, $03, $21, $00 ; entry 7
    db $e8, $0b, $22, $00 ; entry 8
    db $f0, $03, $0e, $20 ; entry 9
    db $e8, $13, $10, $20 ; entry 10
    db $f0, $13, $09, $40 ; entry 11
    db $f0, $0b, $12, $60 ; entry 12
    db $f8, $0a, $1d, $20 ; entry 13
    db $f8, $12, $20, $20 ; entry 14
    db $f8, $f4, $1e, $00 ; entry 15
    db $e8, $f4, $21, $20 ; entry 16
    db $e8, $ec, $22, $20 ; entry 17
    db $f0, $f4, $0e, $00 ; entry 18
    db $e8, $e4, $10, $00 ; entry 19
    db $f0, $e4, $09, $60 ; entry 20
    db $f0, $ec, $12, $40 ; entry 21
    db $f8, $ed, $1d, $00 ; entry 22
    db $f8, $e5, $20, $00 ; entry 23
    db $80 ; end

; frame 19 of MetaSprites92Set35; ends with $80 (E-0147)
MetaSprites92Set35Frame19::
    db $f8, $fc, $0c, $00 ; entry 0
    db $f0, $fc, $0c, $00 ; entry 1
    db $e8, $fc, $0c, $00 ; entry 2
    db $e0, $fc, $0c, $00 ; entry 3
    db $d8, $fc, $0c, $00 ; entry 4
    db $d0, $fc, $0c, $00 ; entry 5
    db $e0, $dc, $06, $00 ; entry 6
    db $e0, $e4, $07, $00 ; entry 7
    db $e0, $ec, $08, $00 ; entry 8
    db $e0, $f4, $09, $00 ; entry 9
    db $e8, $e4, $0a, $00 ; entry 10
    db $e8, $ec, $0b, $00 ; entry 11
    db $e8, $f4, $0e, $00 ; entry 12
    db $f0, $e4, $1a, $00 ; entry 13
    db $f0, $ec, $1b, $00 ; entry 14
    db $f0, $f4, $1c, $00 ; entry 15
    db $f8, $e4, $1d, $00 ; entry 16
    db $f8, $ec, $1e, $00 ; entry 17
    db $f8, $f4, $1f, $00 ; entry 18
    db $f8, $dc, $20, $00 ; entry 19
    db $e0, $1b, $06, $20 ; entry 20
    db $e0, $13, $07, $20 ; entry 21
    db $e0, $0b, $08, $20 ; entry 22
    db $e0, $03, $09, $20 ; entry 23
    db $e8, $13, $0a, $20 ; entry 24
    db $e8, $0b, $0b, $20 ; entry 25
    db $e8, $03, $0e, $20 ; entry 26
    db $f0, $13, $1a, $20 ; entry 27
    db $f0, $0b, $1b, $20 ; entry 28
    db $f0, $03, $1c, $20 ; entry 29
    db $f8, $13, $1d, $20 ; entry 30
    db $f8, $0b, $1e, $20 ; entry 31
    db $f8, $03, $1f, $20 ; entry 32
    db $f8, $1b, $20, $20 ; entry 33
    db $80 ; end

; frame 20 of MetaSprites92Set35; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set35Frame20::
    db $f8, $fc, $0c, $00 ; entry 0
    db $f0, $fc, $0c, $00 ; entry 1
    db $e8, $fc, $0c, $00 ; entry 2
    db $e0, $fc, $0c, $00 ; entry 3
    db $d8, $fc, $0c, $00 ; entry 4
    db $d0, $fc, $0c, $00 ; entry 5
    db $f8, $e4, $1e, $00 ; entry 6
    db $f8, $dc, $1a, $00 ; entry 7
    db $f8, $ec, $1f, $00 ; entry 8
    db $f0, $e4, $1e, $40 ; entry 9
    db $f0, $dc, $0f, $00 ; entry 10
    db $f8, $f4, $1a, $20 ; entry 11
    db $e8, $d4, $09, $20 ; entry 12
    db $e8, $ec, $09, $00 ; entry 13
    db $e8, $e4, $08, $00 ; entry 14
    db $e8, $dc, $07, $00 ; entry 15
    db $f8, $13, $1e, $20 ; entry 16
    db $f8, $1b, $1a, $20 ; entry 17
    db $f8, $0b, $1f, $20 ; entry 18
    db $f0, $13, $1e, $60 ; entry 19
    db $f0, $0b, $1c, $20 ; entry 20
    db $f0, $1b, $0f, $20 ; entry 21
    db $f8, $03, $1a, $00 ; entry 22
    db $e8, $23, $09, $00 ; entry 23
    db $e8, $0b, $09, $20 ; entry 24
    db $e8, $13, $08, $20 ; entry 25
    db $e8, $1b, $07, $20 ; entry 26
    db $f0, $ec, $1c, $00 ; entry 27
    db $80 ; end

; frame 21 of MetaSprites92Set35; ends with $80 (E-0147)
MetaSprites92Set35Frame21::
    db $f8, $fb, $0c, $20 ; entry 0
    db $f0, $fb, $0c, $20 ; entry 1
    db $e8, $fb, $0c, $20 ; entry 2
    db $e0, $fb, $0c, $20 ; entry 3
    db $d8, $fb, $0c, $20 ; entry 4
    db $d0, $fb, $0c, $20 ; entry 5
    db $f8, $db, $1e, $40 ; entry 6
    db $f8, $d3, $0f, $00 ; entry 7
    db $f8, $e3, $1d, $20 ; entry 8
    db $f8, $eb, $20, $20 ; entry 9
    db $f0, $d3, $07, $00 ; entry 10
    db $f0, $db, $08, $00 ; entry 11
    db $f0, $e3, $09, $00 ; entry 12
    db $f0, $cb, $09, $20 ; entry 13
    db $f8, $1b, $1e, $60 ; entry 14
    db $f8, $23, $0f, $20 ; entry 15
    db $f8, $13, $1d, $00 ; entry 16
    db $f8, $0b, $20, $00 ; entry 17
    db $f0, $23, $07, $20 ; entry 18
    db $f0, $1b, $08, $20 ; entry 19
    db $f0, $13, $09, $20 ; entry 20
    db $f0, $2b, $09, $00 ; entry 21
    db $80 ; end

; frame 22 of MetaSprites92Set35; ends with $80 (E-0147)
MetaSprites92Set35Frame22::
    db $f0, $fc, $0d, $00 ; entry 0
    db $e8, $fc, $0d, $00 ; entry 1
    db $e0, $fc, $0d, $00 ; entry 2
    db $d8, $fc, $0d, $00 ; entry 3
    db $d0, $fc, $0d, $00 ; entry 4
    db $f8, $fc, $0d, $00 ; entry 5
    db $f8, $df, $06, $20 ; entry 6
    db $f8, $d7, $07, $20 ; entry 7
    db $f0, $c7, $2a, $00 ; entry 8
    db $f0, $cf, $2b, $00 ; entry 9
    db $f8, $c7, $2c, $00 ; entry 10
    db $f8, $cf, $2d, $00 ; entry 11
    db $f8, $17, $06, $00 ; entry 12
    db $f8, $1f, $07, $00 ; entry 13
    db $f0, $2f, $2a, $20 ; entry 14
    db $f0, $27, $2b, $20 ; entry 15
    db $f8, $2f, $2c, $20 ; entry 16
    db $f8, $27, $2d, $20 ; entry 17
    db $80 ; end

; frame 23 of MetaSprites92Set35; ends with $80 (E-0147)
MetaSprites92Set35Frame23::
    db $f0, $fb, $0d, $20 ; entry 0
    db $e8, $fb, $0d, $20 ; entry 1
    db $e0, $fb, $0d, $20 ; entry 2
    db $f8, $fb, $0d, $20 ; entry 3
    db $f8, $c4, $08, $20 ; entry 4
    db $f8, $bc, $09, $20 ; entry 5
    db $f8, $cc, $11, $20 ; entry 6
    db $f8, $33, $08, $00 ; entry 7
    db $f8, $3b, $09, $00 ; entry 8
    db $f8, $2b, $11, $00 ; entry 9
    db $80 ; end

; frame 24 of MetaSprites92Set35; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set35Frame24::
    db $80 ; end

; meta-sprite set 54 of MetaSprites92Table: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites92Set36::
    dw MetaSprites92Set36Frame0 ; entry 0
    dw MetaSprites92Set36Frame1 ; entry 1
    dw MetaSprites92Set36Frame2 ; entry 2
    dw MetaSprites92Set36Frame3 ; entry 3
    dw MetaSprites92Set36Frame4 ; entry 4
    dw MetaSprites92Set36Frame5 ; entry 5
    dw MetaSprites92Set36Frame6 ; entry 6
    dw MetaSprites92Set36Frame7 ; entry 7
    dw MetaSprites92Set36Frame8 ; entry 8
    dw MetaSprites92Set36Frame9 ; entry 9
    dw MetaSprites92Set36Frame10 ; entry 10
    dw MetaSprites92Set36Frame11 ; entry 11
    dw MetaSprites92Set36Frame12 ; entry 12
    dw MetaSprites92Set36Frame13 ; entry 13
    dw MetaSprites92Set36Frame14 ; entry 14
    dw MetaSprites92Set36Frame15 ; entry 15
    dw MetaSprites92Set36Frame16 ; entry 16
    dw MetaSprites92Set36Frame17 ; entry 17
    dw MetaSprites92Set36Frame18 ; entry 18
    dw MetaSprites92Set36Frame19 ; entry 19
    dw MetaSprites92Set36Frame20 ; entry 20
    dw MetaSprites92Set36Frame20 ; entry 21
    dw MetaSprites92Set36Frame20 ; entry 22
    dw MetaSprites92Set36Frame20 ; entry 23
    dw MetaSprites92Set36Frame20 ; entry 24
    dw MetaSprites92Set36Frame20 ; entry 25
    dw MetaSprites92Set36Frame20 ; entry 26
    dw MetaSprites92Set36Frame20 ; entry 27
    dw MetaSprites92Set36Frame20 ; entry 28
    dw MetaSprites92Set36Frame20 ; entry 29
    dw MetaSprites92Set36Frame20 ; entry 30
    dw MetaSprites92Set36Frame20 ; entry 31

; frame 0 of MetaSprites92Set36; ends with $80 (E-0147)
MetaSprites92Set36Frame0::
    db $f8, $10, $00, $00 ; entry 0
    db $f8, $18, $01, $00 ; entry 1
    db $80 ; end

; frame 1 of MetaSprites92Set36; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set36Frame1::
    db $f8, $08, $02, $00 ; entry 0
    db $f8, $10, $03, $00 ; entry 1
    db $f0, $08, $00, $00 ; entry 2
    db $f0, $10, $01, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites92Set36; ends with $80 (E-0147)
MetaSprites92Set36Frame2::
    db $f0, $00, $02, $00 ; entry 0
    db $f0, $08, $03, $00 ; entry 1
    db $e8, $00, $00, $00 ; entry 2
    db $e8, $08, $01, $00 ; entry 3
    db $e0, $f0, $11, $00 ; entry 4
    db $e0, $f8, $12, $00 ; entry 5
    db $e0, $00, $13, $00 ; entry 6
    db $d8, $f8, $0f, $00 ; entry 7
    db $d8, $00, $10, $00 ; entry 8
    db $e8, $f0, $14, $00 ; entry 9
    db $e8, $f8, $15, $00 ; entry 10
    db $f8, $10, $18, $00 ; entry 11
    db $f8, $18, $19, $00 ; entry 12
    db $f0, $10, $19, $00 ; entry 13
    db $f8, $08, $19, $60 ; entry 14
    db $80 ; end

; frame 3 of MetaSprites92Set36; ends with $80 (E-0147)
MetaSprites92Set36Frame3::
    db $f0, $08, $18, $00 ; entry 0
    db $f0, $10, $19, $00 ; entry 1
    db $f0, $00, $19, $60 ; entry 2
    db $d0, $e8, $04, $00 ; entry 3
    db $d0, $f0, $05, $00 ; entry 4
    db $d0, $f8, $06, $00 ; entry 5
    db $d0, $00, $07, $00 ; entry 6
    db $d8, $e8, $08, $00 ; entry 7
    db $d8, $f0, $09, $00 ; entry 8
    db $d8, $f8, $0a, $00 ; entry 9
    db $e0, $e8, $0b, $00 ; entry 10
    db $e0, $f0, $0c, $00 ; entry 11
    db $e8, $e8, $0e, $00 ; entry 12
    db $e8, $08, $19, $00 ; entry 13
    db $e0, $f8, $16, $00 ; entry 14
    db $e8, $00, $0d, $00 ; entry 15
    db $e0, $00, $17, $00 ; entry 16
    db $e8, $f8, $17, $60 ; entry 17
    db $f8, $10, $18, $00 ; entry 18
    db $f8, $18, $19, $00 ; entry 19
    db $f8, $08, $19, $60 ; entry 20
    db $80 ; end

; frame 4 of MetaSprites92Set36; ends with $80 (E-0147)
MetaSprites92Set36Frame4::
    db $e8, $f8, $19, $60 ; entry 0
    db $d0, $e0, $08, $00 ; entry 1
    db $d0, $e8, $09, $00 ; entry 2
    db $d0, $f0, $0a, $00 ; entry 3
    db $d8, $e0, $0b, $00 ; entry 4
    db $d8, $e8, $0c, $00 ; entry 5
    db $e0, $e0, $0e, $00 ; entry 6
    db $e0, $f8, $18, $00 ; entry 7
    db $e0, $00, $19, $00 ; entry 8
    db $e0, $f0, $19, $60 ; entry 9
    db $d8, $f8, $19, $00 ; entry 10
    db $d8, $f0, $0d, $00 ; entry 11
    db $e8, $00, $1a, $00 ; entry 12
    db $f0, $08, $1a, $00 ; entry 13
    db $80 ; end

; frame 5 of MetaSprites92Set36; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set36Frame5::
    db $d0, $d8, $0b, $00 ; entry 0
    db $d0, $e0, $0c, $00 ; entry 1
    db $d8, $d8, $0e, $00 ; entry 2
    db $d0, $e8, $18, $00 ; entry 3
    db $d0, $f0, $19, $00 ; entry 4
    db $d8, $e8, $19, $60 ; entry 5
    db $d8, $f0, $1a, $00 ; entry 6
    db $e0, $f8, $1a, $00 ; entry 7
    db $80 ; end

; frame 6 of MetaSprites92Set36; ends with $80 (E-0147)
MetaSprites92Set36Frame6::
    db $d0, $e8, $1a, $00 ; entry 0
    db $d8, $f0, $1a, $00 ; entry 1
    db $80 ; end

; frame 7 of MetaSprites92Set36; ends with $80 (E-0147)
MetaSprites92Set36Frame7::
    db $e0, $f9, $1e, $00 ; entry 0
    db $e7, $f9, $1e, $40 ; entry 1
    db $e0, $00, $1e, $20 ; entry 2
    db $e7, $00, $1e, $60 ; entry 3
    db $e9, $02, $1a, $00 ; entry 4
    db $de, $f7, $1a, $00 ; entry 5
    db $80 ; end

; frame 8 of MetaSprites92Set36; ends with $80 (E-0147)
MetaSprites92Set36Frame8::
    db $e0, $f0, $11, $00 ; entry 0
    db $e0, $f8, $12, $00 ; entry 1
    db $d8, $f8, $0f, $00 ; entry 2
    db $d8, $00, $10, $00 ; entry 3
    db $e8, $f0, $14, $00 ; entry 4
    db $e8, $08, $11, $60 ; entry 5
    db $e8, $00, $12, $60 ; entry 6
    db $e8, $f8, $13, $60 ; entry 7
    db $f0, $00, $0f, $60 ; entry 8
    db $f0, $f8, $10, $60 ; entry 9
    db $e0, $08, $14, $60 ; entry 10
    db $e0, $00, $15, $60 ; entry 11
    db $f0, $08, $1a, $00 ; entry 12
    db $d8, $f0, $1a, $00 ; entry 13
    db $80 ; end

; frame 9 of MetaSprites92Set36; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set36Frame9::
    db $e0, $f9, $1e, $00 ; entry 0
    db $e7, $f9, $1e, $40 ; entry 1
    db $e0, $00, $1e, $20 ; entry 2
    db $e7, $00, $1e, $60 ; entry 3
    db $f0, $09, $18, $00 ; entry 4
    db $e8, $01, $16, $00 ; entry 5
    db $e8, $09, $17, $00 ; entry 6
    db $f0, $01, $17, $60 ; entry 7
    db $f0, $11, $19, $00 ; entry 8
    db $f8, $09, $19, $60 ; entry 9
    db $f8, $11, $1a, $00 ; entry 10
    db $d7, $f0, $18, $60 ; entry 11
    db $df, $f8, $16, $60 ; entry 12
    db $df, $f0, $17, $60 ; entry 13
    db $d7, $f8, $17, $00 ; entry 14
    db $d7, $e8, $19, $60 ; entry 15
    db $cf, $f0, $19, $00 ; entry 16
    db $d0, $e9, $1a, $60 ; entry 17
    db $80 ; end

; frame 10 of MetaSprites92Set36; ends with $80 (E-0147)
MetaSprites92Set36Frame10::
    db $f0, $08, $1a, $00 ; entry 0
    db $f8, $10, $1a, $00 ; entry 1
    db $e8, $00, $1a, $00 ; entry 2
    db $e0, $f8, $1a, $00 ; entry 3
    db $d8, $f0, $1a, $00 ; entry 4
    db $d0, $e8, $1a, $60 ; entry 5
    db $80 ; end

; frame 11 of MetaSprites92Set36; ends with $80 (E-0147)
MetaSprites92Set36Frame11::
    db $d0, $e8, $21, $00 ; entry 0
    db $f0, $08, $21, $00 ; entry 1
    db $f8, $10, $21, $00 ; entry 2
    db $d0, $f0, $19, $00 ; entry 3
    db $f0, $10, $19, $00 ; entry 4
    db $f8, $08, $19, $60 ; entry 5
    db $f0, $00, $19, $60 ; entry 6
    db $e8, $00, $21, $00 ; entry 7
    db $e8, $08, $19, $00 ; entry 8
    db $e8, $f8, $19, $60 ; entry 9
    db $e0, $f8, $21, $00 ; entry 10
    db $e0, $00, $19, $00 ; entry 11
    db $e0, $f0, $19, $60 ; entry 12
    db $d8, $f0, $21, $00 ; entry 13
    db $d8, $f8, $19, $00 ; entry 14
    db $d8, $e8, $19, $60 ; entry 15
    db $80 ; end

; frame 12 of MetaSprites92Set36; ends with $80 (E-0147)
MetaSprites92Set36Frame12::
    db $d0, $e8, $1f, $00 ; entry 0
    db $d8, $f0, $1f, $00 ; entry 1
    db $d0, $f0, $20, $00 ; entry 2
    db $d8, $f8, $20, $00 ; entry 3
    db $d8, $e8, $20, $60 ; entry 4
    db $e0, $f8, $1f, $00 ; entry 5
    db $e0, $00, $20, $00 ; entry 6
    db $e0, $f0, $20, $60 ; entry 7
    db $e8, $00, $1f, $00 ; entry 8
    db $e8, $08, $20, $00 ; entry 9
    db $e8, $f8, $20, $60 ; entry 10
    db $f0, $08, $1f, $00 ; entry 11
    db $f0, $10, $20, $00 ; entry 12
    db $f0, $00, $20, $60 ; entry 13
    db $f8, $10, $1f, $00 ; entry 14
    db $f8, $08, $20, $60 ; entry 15
    db $80 ; end

; frame 13 of MetaSprites92Set36; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set36Frame13::
    db $f8, $0c, $1b, $60 ; entry 0
    db $f8, $14, $1b, $00 ; entry 1
    db $d0, $e4, $1b, $60 ; entry 2
    db $d0, $ec, $1b, $00 ; entry 3
    db $d8, $ec, $1b, $60 ; entry 4
    db $d8, $f4, $1b, $00 ; entry 5
    db $e0, $f4, $1b, $60 ; entry 6
    db $e0, $fc, $1b, $00 ; entry 7
    db $e8, $fc, $1b, $60 ; entry 8
    db $e8, $04, $1b, $00 ; entry 9
    db $f0, $04, $1b, $60 ; entry 10
    db $f0, $0c, $1b, $00 ; entry 11
    db $80 ; end

; frame 14 of MetaSprites92Set36; ends with $80 (E-0147)
MetaSprites92Set36Frame14::
    db $d0, $ec, $1c, $00 ; entry 0
    db $d0, $e4, $1c, $60 ; entry 1
    db $d8, $f4, $1c, $00 ; entry 2
    db $d8, $ec, $1c, $60 ; entry 3
    db $e0, $fc, $1c, $00 ; entry 4
    db $e0, $f4, $1c, $60 ; entry 5
    db $e8, $04, $1c, $00 ; entry 6
    db $e8, $fc, $1c, $60 ; entry 7
    db $f0, $0c, $1c, $00 ; entry 8
    db $f0, $04, $1c, $60 ; entry 9
    db $f8, $14, $1c, $00 ; entry 10
    db $f8, $0c, $1c, $60 ; entry 11
    db $80 ; end

; frame 15 of MetaSprites92Set36; ends with $80 (E-0147)
MetaSprites92Set36Frame15::
    db $f8, $08, $1b, $60 ; entry 0
    db $d0, $e0, $1b, $60 ; entry 1
    db $d8, $e8, $1b, $60 ; entry 2
    db $e0, $f0, $1b, $60 ; entry 3
    db $e8, $f8, $1b, $60 ; entry 4
    db $f0, $00, $1b, $60 ; entry 5
    db $e0, $00, $1b, $00 ; entry 6
    db $f8, $18, $1b, $00 ; entry 7
    db $f0, $10, $1b, $00 ; entry 8
    db $e8, $08, $1b, $00 ; entry 9
    db $d8, $f8, $1b, $00 ; entry 10
    db $d0, $f0, $1b, $00 ; entry 11
    db $d0, $e8, $1d, $00 ; entry 12
    db $d8, $f0, $1d, $00 ; entry 13
    db $e0, $f8, $1d, $00 ; entry 14
    db $e8, $00, $1d, $00 ; entry 15
    db $f0, $08, $1d, $00 ; entry 16
    db $f8, $10, $1d, $00 ; entry 17
    db $80 ; end

; frame 16 of MetaSprites92Set36; ends with $80 (E-0147)
MetaSprites92Set36Frame16::
    db $f0, $0c, $1d, $00 ; entry 0
    db $d0, $f4, $1c, $00 ; entry 1
    db $d8, $fc, $1c, $00 ; entry 2
    db $e0, $04, $1c, $00 ; entry 3
    db $e8, $0c, $1c, $00 ; entry 4
    db $f0, $14, $1c, $00 ; entry 5
    db $f8, $1c, $1c, $00 ; entry 6
    db $f8, $14, $1d, $00 ; entry 7
    db $f8, $04, $1c, $60 ; entry 8
    db $f8, $0c, $1d, $00 ; entry 9
    db $f0, $fc, $1c, $60 ; entry 10
    db $f0, $04, $1d, $00 ; entry 11
    db $e8, $04, $1d, $00 ; entry 12
    db $e8, $fc, $1d, $00 ; entry 13
    db $e8, $f4, $1c, $60 ; entry 14
    db $e0, $fc, $1d, $00 ; entry 15
    db $e0, $ec, $1c, $60 ; entry 16
    db $e0, $f4, $1d, $00 ; entry 17
    db $d8, $f4, $1d, $00 ; entry 18
    db $d8, $e4, $1c, $60 ; entry 19
    db $d8, $ec, $1d, $00 ; entry 20
    db $d0, $ec, $1d, $00 ; entry 21
    db $d0, $dc, $1c, $60 ; entry 22
    db $d0, $e4, $1d, $00 ; entry 23
    db $80 ; end

; frame 17 of MetaSprites92Set36; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set36Frame17::
    db $d0, $f0, $1d, $00 ; entry 0
    db $d0, $f8, $1b, $00 ; entry 1
    db $d0, $e0, $1d, $00 ; entry 2
    db $d0, $d8, $1b, $60 ; entry 3
    db $d0, $e8, $1d, $00 ; entry 4
    db $d8, $f8, $1d, $00 ; entry 5
    db $d8, $00, $1b, $00 ; entry 6
    db $d8, $e8, $1d, $00 ; entry 7
    db $d8, $e0, $1b, $60 ; entry 8
    db $d8, $f0, $1d, $00 ; entry 9
    db $e0, $00, $1d, $00 ; entry 10
    db $e0, $08, $1b, $00 ; entry 11
    db $e0, $f0, $1d, $00 ; entry 12
    db $e0, $e8, $1b, $60 ; entry 13
    db $e0, $f8, $1d, $00 ; entry 14
    db $e8, $08, $1d, $00 ; entry 15
    db $e8, $10, $1b, $00 ; entry 16
    db $e8, $f8, $1d, $00 ; entry 17
    db $e8, $f0, $1b, $60 ; entry 18
    db $e8, $00, $1d, $00 ; entry 19
    db $f0, $10, $1d, $00 ; entry 20
    db $f0, $18, $1b, $00 ; entry 21
    db $f0, $00, $1d, $00 ; entry 22
    db $f0, $f8, $1b, $60 ; entry 23
    db $f0, $08, $1d, $00 ; entry 24
    db $f8, $18, $1d, $00 ; entry 25
    db $f8, $20, $1b, $00 ; entry 26
    db $f8, $08, $1d, $00 ; entry 27
    db $f8, $00, $1b, $60 ; entry 28
    db $f8, $10, $1d, $00 ; entry 29
    db $80 ; end

; frame 18 of MetaSprites92Set36; ends with $80 (E-0147)
MetaSprites92Set36Frame18::
    db $d0, $f4, $1d, $00 ; entry 0
    db $d0, $e4, $1d, $00 ; entry 1
    db $d0, $ec, $1d, $00 ; entry 2
    db $d0, $fc, $1c, $00 ; entry 3
    db $d0, $d4, $1c, $60 ; entry 4
    db $d0, $dc, $1d, $00 ; entry 5
    db $d8, $fc, $1d, $00 ; entry 6
    db $d8, $ec, $1d, $00 ; entry 7
    db $d8, $f4, $1d, $00 ; entry 8
    db $d8, $04, $1c, $00 ; entry 9
    db $d8, $dc, $1c, $60 ; entry 10
    db $d8, $e4, $1d, $00 ; entry 11
    db $e0, $04, $1d, $00 ; entry 12
    db $e0, $f4, $1d, $00 ; entry 13
    db $e0, $fc, $1d, $00 ; entry 14
    db $e0, $0c, $1c, $00 ; entry 15
    db $e0, $e4, $1c, $60 ; entry 16
    db $e0, $ec, $1d, $00 ; entry 17
    db $e8, $0c, $1d, $00 ; entry 18
    db $e8, $fc, $1d, $00 ; entry 19
    db $e8, $04, $1d, $00 ; entry 20
    db $e8, $14, $1c, $00 ; entry 21
    db $e8, $ec, $1c, $60 ; entry 22
    db $e8, $f4, $1d, $00 ; entry 23
    db $f0, $14, $1d, $00 ; entry 24
    db $f0, $04, $1d, $00 ; entry 25
    db $f0, $0c, $1d, $00 ; entry 26
    db $f0, $1c, $1c, $00 ; entry 27
    db $f0, $f4, $1c, $60 ; entry 28
    db $f0, $fc, $1d, $00 ; entry 29
    db $f8, $1c, $1d, $00 ; entry 30
    db $f8, $0c, $1d, $00 ; entry 31
    db $f8, $14, $1d, $00 ; entry 32
    db $f8, $24, $1c, $00 ; entry 33
    db $f8, $fc, $1c, $60 ; entry 34
    db $f8, $04, $1d, $00 ; entry 35
    db $80 ; end

; frame 19 of MetaSprites92Set36; ends with $80 (E-0147)
MetaSprites92Set36Frame19::
    db $d0, $f4, $1d, $00 ; entry 0
    db $d0, $e4, $1d, $00 ; entry 1
    db $d0, $ec, $1d, $00 ; entry 2
    db $d0, $dc, $1d, $00 ; entry 3
    db $d8, $fc, $1d, $00 ; entry 4
    db $d8, $ec, $1d, $00 ; entry 5
    db $d8, $f4, $1d, $00 ; entry 6
    db $d8, $e4, $1d, $00 ; entry 7
    db $e0, $04, $1d, $00 ; entry 8
    db $e0, $f4, $1d, $00 ; entry 9
    db $e0, $fc, $1d, $00 ; entry 10
    db $e0, $ec, $1d, $00 ; entry 11
    db $e8, $0c, $1d, $00 ; entry 12
    db $e8, $fc, $1d, $00 ; entry 13
    db $e8, $04, $1d, $00 ; entry 14
    db $e8, $f4, $1d, $00 ; entry 15
    db $f0, $14, $1d, $00 ; entry 16
    db $f0, $04, $1d, $00 ; entry 17
    db $f0, $0c, $1d, $00 ; entry 18
    db $f0, $fc, $1d, $00 ; entry 19
    db $f8, $1c, $1d, $00 ; entry 20
    db $f8, $0c, $1d, $00 ; entry 21
    db $f8, $14, $1d, $00 ; entry 22
    db $f8, $04, $1d, $00 ; entry 23
    db $d0, $fc, $1b, $00 ; entry 24
    db $d8, $04, $1b, $00 ; entry 25
    db $e0, $0c, $1b, $00 ; entry 26
    db $e8, $14, $1b, $00 ; entry 27
    db $f0, $1c, $1b, $00 ; entry 28
    db $f8, $24, $1b, $00 ; entry 29
    db $f8, $fc, $1b, $60 ; entry 30
    db $f0, $f4, $1b, $60 ; entry 31
    db $d0, $d4, $1b, $60 ; entry 32
    db $d8, $dc, $1b, $60 ; entry 33
    db $e0, $e4, $1b, $60 ; entry 34
    db $e8, $ec, $1b, $60 ; entry 35
    db $80 ; end

; frame 20 of MetaSprites92Set36; ends with $80 (E-0147)
MetaSprites92Set36Frame20::
    db $80 ; end

; meta-sprite set 55 of MetaSprites92Table: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites92Set37::
    dw MetaSprites92Set37Frame0 ; entry 0
    dw MetaSprites92Set37Frame1 ; entry 1
    dw MetaSprites92Set37Frame2 ; entry 2
    dw MetaSprites92Set37Frame3 ; entry 3
    dw MetaSprites92Set37Frame4 ; entry 4
    dw MetaSprites92Set37Frame5 ; entry 5
    dw MetaSprites92Set37Frame6 ; entry 6
    dw MetaSprites92Set37Frame7 ; entry 7
    dw MetaSprites92Set37Frame8 ; entry 8
    dw MetaSprites92Set37Frame9 ; entry 9
    dw MetaSprites92Set37Frame10 ; entry 10
    dw MetaSprites92Set37Frame11 ; entry 11
    dw MetaSprites92Set37Frame12 ; entry 12
    dw MetaSprites92Set37Frame13 ; entry 13
    dw MetaSprites92Set37Frame14 ; entry 14
    dw MetaSprites92Set37Frame15 ; entry 15
    dw MetaSprites92Set37Frame16 ; entry 16
    dw MetaSprites92Set37Frame16 ; entry 17
    dw MetaSprites92Set37Frame16 ; entry 18
    dw MetaSprites92Set37Frame16 ; entry 19
    dw MetaSprites92Set37Frame16 ; entry 20
    dw MetaSprites92Set37Frame16 ; entry 21
    dw MetaSprites92Set37Frame16 ; entry 22
    dw MetaSprites92Set37Frame16 ; entry 23
    dw MetaSprites92Set37Frame16 ; entry 24
    dw MetaSprites92Set37Frame16 ; entry 25
    dw MetaSprites92Set37Frame16 ; entry 26
    dw MetaSprites92Set37Frame16 ; entry 27
    dw MetaSprites92Set37Frame16 ; entry 28
    dw MetaSprites92Set37Frame16 ; entry 29
    dw MetaSprites92Set37Frame16 ; entry 30
    dw MetaSprites92Set37Frame16 ; entry 31

; frame 0 of MetaSprites92Set37; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set37Frame0::
    db $d8, $fc, $00, $10 ; entry 0
    db $d0, $fc, $01, $10 ; entry 1
    db $80 ; end

; frame 1 of MetaSprites92Set37; ends with $80 (E-0147)
MetaSprites92Set37Frame1::
    db $e8, $fc, $00, $10 ; entry 0
    db $e0, $fc, $01, $10 ; entry 1
    db $d0, $fc, $03, $10 ; entry 2
    db $d8, $fc, $02, $10 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites92Set37; ends with $80 (E-0147)
MetaSprites92Set37Frame2::
    db $f8, $fc, $00, $10 ; entry 0
    db $f0, $fc, $01, $10 ; entry 1
    db $e0, $fc, $03, $10 ; entry 2
    db $e8, $fc, $02, $10 ; entry 3
    db $d8, $fc, $04, $10 ; entry 4
    db $d0, $fc, $05, $10 ; entry 5
    db $f8, $00, $08, $10 ; entry 6
    db $f8, $f7, $08, $30 ; entry 7
    db $80 ; end

; frame 3 of MetaSprites92Set37; ends with $80 (E-0147)
MetaSprites92Set37Frame3::
    db $d0, $fc, $05, $10 ; entry 0
    db $f8, $fc, $03, $10 ; entry 1
    db $f0, $fc, $04, $10 ; entry 2
    db $e8, $fc, $05, $10 ; entry 3
    db $e0, $fc, $05, $10 ; entry 4
    db $d8, $fc, $05, $10 ; entry 5
    db $f8, $03, $06, $10 ; entry 6
    db $f8, $0b, $07, $10 ; entry 7
    db $f8, $f4, $06, $30 ; entry 8
    db $f8, $ec, $07, $30 ; entry 9
    db $80 ; end

; frame 4 of MetaSprites92Set37; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set37Frame4::
    db $f8, $fc, $0c, $10 ; entry 0
    db $f0, $fc, $0c, $10 ; entry 1
    db $e8, $fc, $0c, $10 ; entry 2
    db $e0, $fc, $0c, $10 ; entry 3
    db $d8, $fc, $0c, $10 ; entry 4
    db $d0, $fc, $0c, $10 ; entry 5
    db $e8, $03, $2a, $10 ; entry 6
    db $e8, $0b, $2b, $10 ; entry 7
    db $f0, $03, $2c, $10 ; entry 8
    db $f0, $0b, $2d, $10 ; entry 9
    db $f8, $03, $2e, $10 ; entry 10
    db $f8, $0b, $2f, $10 ; entry 11
    db $e8, $f4, $2a, $30 ; entry 12
    db $e8, $ec, $2b, $30 ; entry 13
    db $f0, $f4, $2c, $30 ; entry 14
    db $f0, $ec, $2d, $30 ; entry 15
    db $f8, $f4, $2e, $30 ; entry 16
    db $f8, $ec, $2f, $30 ; entry 17
    db $80 ; end

; frame 5 of MetaSprites92Set37; ends with $80 (E-0147)
MetaSprites92Set37Frame5::
    db $f0, $03, $08, $10 ; entry 0
    db $f0, $0b, $09, $10 ; entry 1
    db $f0, $f4, $08, $30 ; entry 2
    db $f0, $ec, $09, $30 ; entry 3
    db $f8, $03, $0a, $10 ; entry 4
    db $f8, $0b, $0b, $10 ; entry 5
    db $f8, $f4, $0a, $30 ; entry 6
    db $f8, $ec, $0b, $30 ; entry 7
    db $f8, $fc, $0c, $10 ; entry 8
    db $f0, $fc, $0c, $10 ; entry 9
    db $e8, $fc, $0c, $10 ; entry 10
    db $e0, $fc, $0c, $10 ; entry 11
    db $d8, $fc, $0c, $10 ; entry 12
    db $d0, $fc, $0c, $10 ; entry 13
    db $e8, $0b, $17, $10 ; entry 14
    db $f8, $13, $18, $10 ; entry 15
    db $f8, $e4, $18, $30 ; entry 16
    db $e8, $ec, $17, $30 ; entry 17
    db $80 ; end

; frame 6 of MetaSprites92Set37; ends with $80 (E-0147)
MetaSprites92Set37Frame6::
    db $f8, $fb, $0c, $30 ; entry 0
    db $f0, $fb, $0c, $30 ; entry 1
    db $e8, $fb, $0c, $30 ; entry 2
    db $e0, $fb, $0c, $30 ; entry 3
    db $d8, $fb, $0c, $30 ; entry 4
    db $d0, $fb, $0c, $30 ; entry 5
    db $f8, $03, $06, $10 ; entry 6
    db $f8, $0b, $07, $10 ; entry 7
    db $f8, $f4, $06, $30 ; entry 8
    db $f8, $ec, $07, $30 ; entry 9
    db $f0, $18, $19, $10 ; entry 10
    db $f0, $08, $18, $10 ; entry 11
    db $e8, $10, $17, $10 ; entry 12
    db $f0, $f0, $18, $30 ; entry 13
    db $f0, $e0, $19, $30 ; entry 14
    db $e8, $e8, $17, $30 ; entry 15
    db $eb, $00, $18, $10 ; entry 16
    db $e8, $f4, $19, $10 ; entry 17
    db $80 ; end

; frame 7 of MetaSprites92Set37; ends with $80 (E-0147)
MetaSprites92Set37Frame7::
    db $f8, $20, $18, $30 ; entry 0
    db $e8, $1a, $17, $30 ; entry 1
    db $ec, $10, $19, $10 ; entry 2
    db $f8, $d8, $18, $10 ; entry 3
    db $e8, $de, $17, $10 ; entry 4
    db $ec, $e8, $19, $30 ; entry 5
    db $e0, $f4, $18, $10 ; entry 6
    db $f0, $fc, $0d, $10 ; entry 7
    db $e8, $fc, $0d, $10 ; entry 8
    db $e0, $fc, $0d, $10 ; entry 9
    db $d8, $fc, $0d, $10 ; entry 10
    db $d0, $fc, $0d, $10 ; entry 11
    db $e3, $00, $19, $10 ; entry 12
    db $f8, $fc, $0d, $10 ; entry 13
    db $f8, $ed, $0e, $10 ; entry 14
    db $f8, $f5, $0f, $10 ; entry 15
    db $f8, $0a, $0e, $30 ; entry 16
    db $f8, $02, $0f, $30 ; entry 17
    db $80 ; end

; frame 8 of MetaSprites92Set37; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set37Frame8::
    db $f0, $fb, $0d, $30 ; entry 0
    db $e8, $fb, $0d, $30 ; entry 1
    db $e0, $fb, $0d, $30 ; entry 2
    db $f8, $fb, $0d, $30 ; entry 3
    db $f8, $ed, $14, $10 ; entry 4
    db $f8, $f5, $15, $10 ; entry 5
    db $f0, $e5, $10, $10 ; entry 6
    db $f0, $ed, $11, $10 ; entry 7
    db $f0, $f5, $12, $10 ; entry 8
    db $e8, $e7, $0e, $10 ; entry 9
    db $e8, $ef, $0f, $10 ; entry 10
    db $f8, $0a, $14, $30 ; entry 11
    db $f8, $02, $15, $30 ; entry 12
    db $f0, $12, $10, $30 ; entry 13
    db $f0, $0a, $11, $30 ; entry 14
    db $f0, $02, $12, $30 ; entry 15
    db $e8, $10, $0e, $30 ; entry 16
    db $e8, $08, $0f, $30 ; entry 17
    db $f8, $12, $13, $30 ; entry 18
    db $f8, $e5, $13, $10 ; entry 19
    db $f8, $19, $18, $30 ; entry 20
    db $f0, $24, $17, $30 ; entry 21
    db $db, $02, $18, $30 ; entry 22
    db $d8, $f3, $19, $30 ; entry 23
    db $f0, $d4, $17, $10 ; entry 24
    db $f8, $df, $18, $10 ; entry 25
    db $80 ; end

; frame 9 of MetaSprites92Set37; ends with $80 (E-0147)
MetaSprites92Set37Frame9::
    db $e8, $e1, $10, $10 ; entry 0
    db $e8, $e9, $11, $10 ; entry 1
    db $e8, $f1, $12, $10 ; entry 2
    db $e0, $e3, $0e, $10 ; entry 3
    db $e0, $eb, $0f, $10 ; entry 4
    db $f0, $e1, $13, $10 ; entry 5
    db $f0, $e9, $14, $10 ; entry 6
    db $f0, $f1, $15, $10 ; entry 7
    db $f8, $f3, $15, $10 ; entry 8
    db $f8, $eb, $16, $10 ; entry 9
    db $f8, $de, $10, $10 ; entry 10
    db $e8, $17, $10, $30 ; entry 11
    db $e8, $0f, $11, $30 ; entry 12
    db $e8, $07, $12, $30 ; entry 13
    db $e0, $15, $0e, $30 ; entry 14
    db $e0, $0d, $0f, $30 ; entry 15
    db $f0, $17, $13, $30 ; entry 16
    db $f0, $0f, $14, $30 ; entry 17
    db $f0, $07, $15, $30 ; entry 18
    db $f8, $05, $15, $30 ; entry 19
    db $f8, $0d, $16, $30 ; entry 20
    db $f8, $1a, $10, $30 ; entry 21
    db $f8, $15, $26, $10 ; entry 22
    db $f8, $e3, $26, $30 ; entry 23
    db $f8, $28, $17, $30 ; entry 24
    db $f8, $d1, $17, $10 ; entry 25
    db $d2, $ee, $18, $30 ; entry 26
    db $d5, $06, $19, $30 ; entry 27
    db $80 ; end

; frame 10 of MetaSprites92Set37; ends with $80 (E-0147)
MetaSprites92Set37Frame10::
    db $e8, $de, $10, $10 ; entry 0
    db $e8, $e6, $11, $10 ; entry 1
    db $e8, $ee, $12, $10 ; entry 2
    db $e0, $e0, $0e, $10 ; entry 3
    db $e0, $e8, $0f, $10 ; entry 4
    db $f0, $de, $13, $10 ; entry 5
    db $f0, $e6, $14, $10 ; entry 6
    db $f0, $ee, $15, $10 ; entry 7
    db $f8, $f0, $15, $10 ; entry 8
    db $f8, $e8, $16, $10 ; entry 9
    db $f8, $db, $10, $10 ; entry 10
    db $e8, $1a, $10, $30 ; entry 11
    db $e8, $12, $11, $30 ; entry 12
    db $e8, $0a, $12, $30 ; entry 13
    db $e0, $18, $0e, $30 ; entry 14
    db $e0, $10, $0f, $30 ; entry 15
    db $f0, $1a, $13, $30 ; entry 16
    db $f0, $12, $14, $30 ; entry 17
    db $f0, $0a, $15, $30 ; entry 18
    db $f8, $08, $15, $30 ; entry 19
    db $f8, $10, $16, $30 ; entry 20
    db $f8, $1d, $10, $30 ; entry 21
    db $f8, $18, $26, $10 ; entry 22
    db $f8, $e0, $26, $30 ; entry 23
    db $dd, $08, $18, $50 ; entry 24
    db $d8, $ec, $19, $30 ; entry 25
    db $80 ; end

; frame 11 of MetaSprites92Set37; ends with $80 (E-0147)
MetaSprites92Set37Frame11::
    db $f0, $d6, $10, $10 ; entry 0
    db $f0, $de, $11, $10 ; entry 1
    db $f0, $e6, $12, $10 ; entry 2
    db $e8, $d8, $0e, $10 ; entry 3
    db $e8, $e0, $0f, $10 ; entry 4
    db $f8, $d6, $13, $10 ; entry 5
    db $f8, $de, $14, $10 ; entry 6
    db $f8, $e6, $15, $10 ; entry 7
    db $f0, $22, $10, $30 ; entry 8
    db $f0, $1a, $11, $30 ; entry 9
    db $f0, $12, $12, $30 ; entry 10
    db $e8, $20, $0e, $30 ; entry 11
    db $e8, $18, $0f, $30 ; entry 12
    db $f8, $22, $13, $30 ; entry 13
    db $f8, $1a, $14, $30 ; entry 14
    db $f8, $12, $15, $30 ; entry 15
    db $e8, $ec, $18, $10 ; entry 16
    db $ed, $08, $19, $30 ; entry 17
    db $f8, $2a, $1f, $70 ; entry 18
    db $f8, $32, $1e, $10 ; entry 19
    db $f8, $ce, $1f, $50 ; entry 20
    db $f8, $c6, $1e, $30 ; entry 21
    db $80 ; end

; frame 12 of MetaSprites92Set37; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set37Frame12::
    db $f8, $26, $0e, $30 ; entry 0
    db $f8, $1e, $0f, $30 ; entry 1
    db $f8, $d2, $0e, $10 ; entry 2
    db $f8, $da, $0f, $10 ; entry 3
    db $f8, $2e, $22, $10 ; entry 4
    db $f8, $36, $23, $10 ; entry 5
    db $f8, $3e, $24, $10 ; entry 6
    db $f0, $2e, $20, $10 ; entry 7
    db $f0, $36, $21, $10 ; entry 8
    db $f8, $ca, $22, $30 ; entry 9
    db $f8, $c2, $23, $30 ; entry 10
    db $f8, $ba, $24, $30 ; entry 11
    db $f0, $ca, $20, $30 ; entry 12
    db $f0, $c2, $21, $30 ; entry 13
    db $ee, $26, $17, $30 ; entry 14
    db $f0, $d8, $17, $10 ; entry 15
    db $ee, $38, $17, $10 ; entry 16
    db $ef, $c3, $17, $50 ; entry 17
    db $80 ; end

; frame 13 of MetaSprites92Set37; ends with $80 (E-0147)
MetaSprites92Set37Frame13::
    db $f0, $40, $22, $30 ; entry 0
    db $f0, $38, $23, $30 ; entry 1
    db $f0, $30, $24, $30 ; entry 2
    db $e8, $40, $20, $30 ; entry 3
    db $e8, $38, $21, $30 ; entry 4
    db $f8, $40, $25, $30 ; entry 5
    db $f8, $38, $26, $30 ; entry 6
    db $f8, $30, $27, $30 ; entry 7
    db $f0, $b8, $22, $10 ; entry 8
    db $f0, $c0, $23, $10 ; entry 9
    db $f0, $c8, $24, $10 ; entry 10
    db $e8, $b8, $20, $10 ; entry 11
    db $e8, $c0, $21, $10 ; entry 12
    db $f8, $b8, $25, $10 ; entry 13
    db $f8, $c0, $26, $10 ; entry 14
    db $f8, $c8, $27, $10 ; entry 15
    db $f8, $10, $1f, $70 ; entry 16
    db $f8, $e8, $1f, $50 ; entry 17
    db $80 ; end

; frame 14 of MetaSprites92Set37; ends with $80 (E-0147)
MetaSprites92Set37Frame14::
    db $f8, $48, $22, $30 ; entry 0
    db $f8, $40, $23, $30 ; entry 1
    db $f8, $38, $24, $30 ; entry 2
    db $f0, $48, $20, $30 ; entry 3
    db $f0, $40, $21, $30 ; entry 4
    db $f8, $b0, $22, $10 ; entry 5
    db $f8, $b8, $23, $10 ; entry 6
    db $f8, $c0, $24, $10 ; entry 7
    db $f0, $b0, $20, $10 ; entry 8
    db $f0, $b8, $21, $10 ; entry 9
    db $f8, $13, $12, $30 ; entry 10
    db $f8, $1b, $10, $30 ; entry 11
    db $f0, $18, $1f, $70 ; entry 12
    db $f8, $e5, $12, $10 ; entry 13
    db $f8, $dd, $10, $10 ; entry 14
    db $f0, $e0, $1f, $50 ; entry 15
    db $80 ; end

; frame 15 of MetaSprites92Set37; ends with $80 (E-0147)
MetaSprites92Set37Frame15::
    db $f8, $48, $21, $30 ; entry 0
    db $f8, $b0, $21, $10 ; entry 1
    db $f8, $20, $1f, $70 ; entry 2
    db $f8, $d8, $1f, $50 ; entry 3
    db $80 ; end

; frame 16 of MetaSprites92Set37; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set37Frame16::
    db $80 ; end

; meta-sprite set 56 of MetaSprites92Table: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites92Set38::
    dw MetaSprites92Set38Frame0 ; entry 0
    dw MetaSprites92Set38Frame1 ; entry 1
    dw MetaSprites92Set38Frame2 ; entry 2
    dw MetaSprites92Set38Frame3 ; entry 3
    dw MetaSprites92Set38Frame4 ; entry 4
    dw MetaSprites92Set38Frame5 ; entry 5
    dw MetaSprites92Set38Frame6 ; entry 6
    dw MetaSprites92Set38Frame7 ; entry 7
    dw MetaSprites92Set38Frame8 ; entry 8
    dw MetaSprites92Set38Frame9 ; entry 9
    dw MetaSprites92Set38Frame10 ; entry 10
    dw MetaSprites92Set38Frame11 ; entry 11
    dw MetaSprites92Set38Frame12 ; entry 12
    dw MetaSprites92Set38Frame13 ; entry 13
    dw MetaSprites92Set38Frame14 ; entry 14
    dw MetaSprites92Set38Frame15 ; entry 15
    dw MetaSprites92Set38Frame16 ; entry 16
    dw MetaSprites92Set38Frame17 ; entry 17
    dw MetaSprites92Set38Frame18 ; entry 18
    dw MetaSprites92Set38Frame19 ; entry 19
    dw MetaSprites92Set38Frame20 ; entry 20
    dw MetaSprites92Set38Frame21 ; entry 21
    dw MetaSprites92Set38Frame22 ; entry 22
    dw MetaSprites92Set38Frame22 ; entry 23
    dw MetaSprites92Set38Frame22 ; entry 24
    dw MetaSprites92Set38Frame22 ; entry 25
    dw MetaSprites92Set38Frame22 ; entry 26
    dw MetaSprites92Set38Frame22 ; entry 27
    dw MetaSprites92Set38Frame22 ; entry 28
    dw MetaSprites92Set38Frame22 ; entry 29
    dw MetaSprites92Set38Frame22 ; entry 30
    dw MetaSprites92Set38Frame22 ; entry 31

; frame 0 of MetaSprites92Set38; ends with $80 (E-0147)
MetaSprites92Set38Frame0::
    db $f0, $10, $00, $10 ; entry 0
    db $f0, $18, $01, $10 ; entry 1
    db $f0, $20, $02, $10 ; entry 2
    db $f0, $28, $03, $10 ; entry 3
    db $f8, $18, $04, $10 ; entry 4
    db $f8, $20, $05, $10 ; entry 5
    db $f8, $28, $06, $10 ; entry 6
    db $f8, $30, $07, $10 ; entry 7
    db $80 ; end

; frame 1 of MetaSprites92Set38; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set38Frame1::
    db $e8, $00, $00, $10 ; entry 0
    db $e8, $08, $01, $10 ; entry 1
    db $e8, $10, $02, $10 ; entry 2
    db $e8, $18, $03, $10 ; entry 3
    db $f0, $08, $04, $10 ; entry 4
    db $f0, $10, $05, $10 ; entry 5
    db $f0, $18, $06, $10 ; entry 6
    db $f0, $20, $07, $10 ; entry 7
    db $f8, $10, $08, $10 ; entry 8
    db $f8, $18, $09, $10 ; entry 9
    db $f8, $20, $0a, $10 ; entry 10
    db $f8, $28, $0b, $10 ; entry 11
    db $80 ; end

; frame 2 of MetaSprites92Set38; ends with $80 (E-0147)
MetaSprites92Set38Frame2::
    db $e0, $08, $03, $10 ; entry 0
    db $e8, $08, $06, $10 ; entry 1
    db $e8, $10, $07, $10 ; entry 2
    db $f0, $00, $08, $10 ; entry 3
    db $f0, $08, $09, $10 ; entry 4
    db $f0, $10, $0a, $10 ; entry 5
    db $e0, $f0, $06, $70 ; entry 6
    db $e0, $e8, $07, $70 ; entry 7
    db $d8, $f8, $08, $70 ; entry 8
    db $d8, $f0, $09, $70 ; entry 9
    db $f0, $f8, $0c, $70 ; entry 10
    db $d8, $00, $0c, $10 ; entry 11
    db $e0, $f8, $0d, $10 ; entry 12
    db $e0, $00, $0e, $10 ; entry 13
    db $e8, $00, $0d, $70 ; entry 14
    db $e8, $f8, $0e, $70 ; entry 15
    db $f0, $e8, $00, $30 ; entry 16
    db $f0, $e0, $01, $30 ; entry 17
    db $f0, $d8, $02, $30 ; entry 18
    db $f0, $d0, $03, $30 ; entry 19
    db $f8, $e0, $04, $30 ; entry 20
    db $f8, $d8, $05, $30 ; entry 21
    db $f8, $d0, $06, $30 ; entry 22
    db $f8, $c8, $07, $30 ; entry 23
    db $f8, $1c, $17, $10 ; entry 24
    db $f8, $24, $18, $10 ; entry 25
    db $f8, $2c, $17, $70 ; entry 26
    db $f0, $14, $18, $10 ; entry 27
    db $f0, $1c, $17, $70 ; entry 28
    db $d8, $e8, $0b, $10 ; entry 29
    db $80 ; end

; frame 3 of MetaSprites92Set38; ends with $80 (E-0147)
MetaSprites92Set38Frame3::
    db $e0, $f0, $03, $30 ; entry 0
    db $e8, $f0, $06, $30 ; entry 1
    db $f0, $f8, $08, $30 ; entry 2
    db $e0, $08, $06, $50 ; entry 3
    db $e0, $10, $07, $50 ; entry 4
    db $d8, $00, $08, $50 ; entry 5
    db $d8, $08, $09, $50 ; entry 6
    db $f0, $00, $0c, $50 ; entry 7
    db $d8, $f8, $0c, $30 ; entry 8
    db $e0, $00, $0d, $30 ; entry 9
    db $e0, $f8, $0e, $30 ; entry 10
    db $e8, $f8, $0d, $50 ; entry 11
    db $f0, $08, $2a, $70 ; entry 12
    db $f8, $e8, $08, $30 ; entry 13
    db $f0, $e8, $05, $30 ; entry 14
    db $f0, $e0, $06, $30 ; entry 15
    db $f0, $d8, $07, $30 ; entry 16
    db $e8, $e8, $02, $30 ; entry 17
    db $e8, $e0, $03, $30 ; entry 18
    db $f0, $f0, $04, $30 ; entry 19
    db $d8, $10, $0b, $30 ; entry 20
    db $f8, $1c, $17, $10 ; entry 21
    db $f8, $24, $18, $10 ; entry 22
    db $f8, $2c, $17, $70 ; entry 23
    db $f0, $0c, $17, $10 ; entry 24
    db $f0, $14, $18, $10 ; entry 25
    db $f0, $1c, $17, $70 ; entry 26
    db $e8, $04, $18, $10 ; entry 27
    db $e8, $0c, $17, $70 ; entry 28
    db $e8, $00, $0e, $50 ; entry 29
    db $f8, $d4, $18, $30 ; entry 30
    db $f8, $cc, $17, $50 ; entry 31
    db $f8, $dc, $17, $30 ; entry 32
    db $f8, $e0, $09, $30 ; entry 33
    db $80 ; end

; frame 4 of MetaSprites92Set38; ends with $80 (E-0147)
MetaSprites92Set38Frame4::
    db $d0, $d0, $00, $10 ; entry 0
    db $d0, $d8, $01, $10 ; entry 1
    db $d0, $e0, $02, $10 ; entry 2
    db $d0, $e8, $03, $10 ; entry 3
    db $d8, $d8, $04, $10 ; entry 4
    db $d8, $e0, $05, $10 ; entry 5
    db $d8, $e8, $06, $10 ; entry 6
    db $e0, $e0, $08, $10 ; entry 7
    db $e0, $e8, $09, $10 ; entry 8
    db $e8, $08, $06, $10 ; entry 9
    db $e8, $10, $07, $10 ; entry 10
    db $f0, $00, $08, $10 ; entry 11
    db $f0, $f8, $0c, $70 ; entry 12
    db $e8, $00, $0d, $70 ; entry 13
    db $e0, $08, $03, $10 ; entry 14
    db $e0, $f0, $06, $70 ; entry 15
    db $d8, $f8, $08, $70 ; entry 16
    db $d8, $f0, $09, $70 ; entry 17
    db $d8, $00, $0c, $10 ; entry 18
    db $e0, $f8, $0d, $10 ; entry 19
    db $e0, $00, $0e, $10 ; entry 20
    db $f8, $1c, $17, $10 ; entry 21
    db $f8, $24, $18, $10 ; entry 22
    db $f8, $2c, $17, $70 ; entry 23
    db $f0, $14, $18, $10 ; entry 24
    db $f0, $1c, $17, $70 ; entry 25
    db $f0, $0c, $17, $10 ; entry 26
    db $f0, $08, $09, $10 ; entry 27
    db $f8, $dc, $17, $30 ; entry 28
    db $f8, $d4, $18, $30 ; entry 29
    db $f8, $cc, $17, $50 ; entry 30
    db $f0, $e4, $18, $30 ; entry 31
    db $f0, $dc, $17, $50 ; entry 32
    db $f0, $ec, $17, $30 ; entry 33
    db $e8, $ec, $17, $50 ; entry 34
    db $e8, $f4, $18, $50 ; entry 35
    db $e8, $f8, $0e, $70 ; entry 36
    db $80 ; end

; frame 5 of MetaSprites92Set38; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set38Frame5::
    db $d0, $c0, $08, $10 ; entry 0
    db $d0, $c8, $09, $10 ; entry 1
    db $d0, $28, $00, $30 ; entry 2
    db $d0, $20, $01, $30 ; entry 3
    db $d0, $18, $02, $30 ; entry 4
    db $d0, $10, $03, $30 ; entry 5
    db $d8, $20, $04, $30 ; entry 6
    db $d8, $18, $05, $30 ; entry 7
    db $d8, $10, $06, $30 ; entry 8
    db $d8, $08, $07, $30 ; entry 9
    db $e0, $18, $08, $30 ; entry 10
    db $e0, $10, $09, $30 ; entry 11
    db $e0, $08, $0a, $30 ; entry 12
    db $f0, $0c, $17, $10 ; entry 13
    db $f0, $14, $18, $10 ; entry 14
    db $f0, $1c, $17, $70 ; entry 15
    db $e8, $fc, $17, $10 ; entry 16
    db $e8, $04, $18, $10 ; entry 17
    db $e8, $0c, $17, $70 ; entry 18
    db $e0, $ec, $17, $10 ; entry 19
    db $e0, $f4, $18, $10 ; entry 20
    db $e0, $fc, $17, $70 ; entry 21
    db $d8, $dc, $17, $10 ; entry 22
    db $d8, $e4, $18, $10 ; entry 23
    db $d8, $ec, $17, $70 ; entry 24
    db $d0, $d4, $18, $10 ; entry 25
    db $d0, $dc, $17, $70 ; entry 26
    db $d0, $d0, $0a, $10 ; entry 27
    db $f8, $dc, $17, $30 ; entry 28
    db $f8, $d4, $18, $30 ; entry 29
    db $f8, $cc, $17, $50 ; entry 30
    db $f0, $ec, $17, $30 ; entry 31
    db $f0, $e4, $18, $30 ; entry 32
    db $f0, $dc, $17, $50 ; entry 33
    db $e8, $f4, $18, $30 ; entry 34
    db $e8, $ec, $17, $50 ; entry 35
    db $e0, $04, $18, $30 ; entry 36
    db $f8, $1c, $17, $10 ; entry 37
    db $f8, $24, $18, $10 ; entry 38
    db $f8, $2c, $17, $70 ; entry 39
    db $80 ; end

; frame 6 of MetaSprites92Set38; ends with $80 (E-0147)
MetaSprites92Set38Frame6::
    db $f0, $f0, $1b, $50 ; entry 0
    db $f0, $f8, $1c, $50 ; entry 1
    db $e8, $f0, $1e, $50 ; entry 2
    db $e8, $f8, $1a, $50 ; entry 3
    db $f0, $08, $1b, $70 ; entry 4
    db $f0, $00, $1c, $70 ; entry 5
    db $e8, $08, $1e, $70 ; entry 6
    db $e8, $00, $1a, $70 ; entry 7
    db $d8, $f0, $1b, $10 ; entry 8
    db $d8, $f8, $1c, $10 ; entry 9
    db $e0, $f0, $1e, $10 ; entry 10
    db $e0, $f8, $1a, $10 ; entry 11
    db $d8, $08, $1b, $30 ; entry 12
    db $d8, $00, $1c, $30 ; entry 13
    db $e0, $08, $1e, $30 ; entry 14
    db $e0, $00, $1a, $30 ; entry 15
    db $80 ; end

; frame 7 of MetaSprites92Set38; ends with $80 (E-0147)
MetaSprites92Set38Frame7::
    db $d0, $e8, $1b, $10 ; entry 0
    db $d0, $f0, $1c, $10 ; entry 1
    db $d0, $f8, $1d, $10 ; entry 2
    db $d8, $e8, $1e, $10 ; entry 3
    db $e0, $e8, $1f, $10 ; entry 4
    db $e0, $f0, $1a, $10 ; entry 5
    db $d8, $f8, $1a, $10 ; entry 6
    db $d0, $10, $1b, $30 ; entry 7
    db $d0, $08, $1c, $30 ; entry 8
    db $d0, $00, $1d, $30 ; entry 9
    db $d8, $10, $1e, $30 ; entry 10
    db $e0, $10, $1f, $30 ; entry 11
    db $e0, $08, $1a, $30 ; entry 12
    db $d8, $00, $1a, $30 ; entry 13
    db $f8, $e8, $1b, $50 ; entry 14
    db $f8, $f0, $1c, $50 ; entry 15
    db $f8, $f8, $1d, $50 ; entry 16
    db $f0, $e8, $1e, $50 ; entry 17
    db $e8, $e8, $1f, $50 ; entry 18
    db $e8, $f0, $1a, $50 ; entry 19
    db $f0, $f8, $1a, $50 ; entry 20
    db $f8, $10, $1b, $70 ; entry 21
    db $f8, $08, $1c, $70 ; entry 22
    db $f8, $00, $1d, $70 ; entry 23
    db $f0, $10, $1e, $70 ; entry 24
    db $e8, $10, $1f, $70 ; entry 25
    db $e8, $08, $1a, $70 ; entry 26
    db $f0, $00, $1a, $70 ; entry 27
    db $e0, $00, $19, $10 ; entry 28
    db $e0, $f8, $19, $30 ; entry 29
    db $e8, $f8, $19, $70 ; entry 30
    db $e8, $00, $19, $50 ; entry 31
    db $d8, $08, $19, $10 ; entry 32
    db $f0, $08, $19, $50 ; entry 33
    db $f0, $f0, $19, $70 ; entry 34
    db $d8, $f0, $19, $30 ; entry 35
    db $80 ; end

; frame 8 of MetaSprites92Set38; ends with $80 (E-0147)
MetaSprites92Set38Frame8::
    db $d0, $28, $1b, $30 ; entry 0
    db $d0, $20, $1c, $30 ; entry 1
    db $d8, $28, $1e, $30 ; entry 2
    db $e0, $28, $1f, $30 ; entry 3
    db $f8, $28, $1b, $70 ; entry 4
    db $f8, $20, $1c, $70 ; entry 5
    db $f0, $28, $1e, $70 ; entry 6
    db $e8, $28, $1f, $70 ; entry 7
    db $d8, $20, $19, $10 ; entry 8
    db $f0, $20, $19, $50 ; entry 9
    db $f0, $18, $1c, $10 ; entry 10
    db $d8, $18, $1c, $50 ; entry 11
    db $d0, $10, $1c, $50 ; entry 12
    db $f8, $10, $1c, $10 ; entry 13
    db $e0, $20, $1f, $10 ; entry 14
    db $e8, $20, $1f, $50 ; entry 15
    db $d0, $d0, $1b, $10 ; entry 16
    db $d0, $d8, $1c, $10 ; entry 17
    db $d8, $d0, $1e, $10 ; entry 18
    db $e0, $d0, $1f, $10 ; entry 19
    db $f8, $d0, $1b, $50 ; entry 20
    db $f8, $d8, $1c, $50 ; entry 21
    db $f0, $d0, $1e, $50 ; entry 22
    db $e8, $d0, $1f, $50 ; entry 23
    db $d8, $d8, $19, $30 ; entry 24
    db $f0, $d8, $19, $70 ; entry 25
    db $f0, $e0, $1c, $30 ; entry 26
    db $d8, $e0, $1c, $70 ; entry 27
    db $d0, $e8, $1c, $70 ; entry 28
    db $f8, $e8, $1c, $30 ; entry 29
    db $e0, $d8, $1f, $30 ; entry 30
    db $e8, $d8, $1f, $70 ; entry 31
    db $d0, $e0, $15, $10 ; entry 32
    db $f8, $e0, $15, $50 ; entry 33
    db $d0, $18, $15, $30 ; entry 34
    db $f8, $18, $15, $70 ; entry 35
    db $80 ; end

; frame 9 of MetaSprites92Set38; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set38Frame9::
    db $d0, $40, $1b, $30 ; entry 0
    db $d0, $38, $1c, $30 ; entry 1
    db $d8, $40, $1e, $30 ; entry 2
    db $e0, $40, $1f, $30 ; entry 3
    db $f8, $40, $1b, $70 ; entry 4
    db $f8, $38, $1c, $70 ; entry 5
    db $f0, $40, $1e, $70 ; entry 6
    db $e8, $40, $1f, $70 ; entry 7
    db $d8, $38, $19, $10 ; entry 8
    db $f0, $38, $19, $50 ; entry 9
    db $f0, $30, $1c, $10 ; entry 10
    db $d8, $30, $1c, $50 ; entry 11
    db $d0, $28, $1c, $50 ; entry 12
    db $f8, $28, $1c, $10 ; entry 13
    db $e0, $38, $1f, $10 ; entry 14
    db $e8, $38, $1f, $50 ; entry 15
    db $d0, $b8, $1b, $10 ; entry 16
    db $d0, $c0, $1c, $10 ; entry 17
    db $d8, $b8, $1e, $10 ; entry 18
    db $e0, $b8, $1f, $10 ; entry 19
    db $f8, $b8, $1b, $50 ; entry 20
    db $f8, $c0, $1c, $50 ; entry 21
    db $f0, $b8, $1e, $50 ; entry 22
    db $e8, $b8, $1f, $50 ; entry 23
    db $d8, $c0, $19, $30 ; entry 24
    db $f0, $c0, $19, $70 ; entry 25
    db $f0, $c8, $1c, $30 ; entry 26
    db $d8, $c8, $1c, $70 ; entry 27
    db $d0, $d0, $1c, $70 ; entry 28
    db $f8, $d0, $1c, $30 ; entry 29
    db $e0, $c0, $1f, $30 ; entry 30
    db $e8, $c0, $1f, $70 ; entry 31
    db $d0, $20, $1b, $50 ; entry 32
    db $f8, $20, $1b, $10 ; entry 33
    db $f8, $d8, $1b, $30 ; entry 34
    db $d0, $d8, $1b, $70 ; entry 35
    db $d0, $c8, $15, $10 ; entry 36
    db $f8, $c8, $15, $50 ; entry 37
    db $d0, $30, $15, $30 ; entry 38
    db $f8, $30, $15, $70 ; entry 39
    db $80 ; end

; frame 10 of MetaSprites92Set38; ends with $80 (E-0147)
MetaSprites92Set38Frame10::
    db $d0, $d8, $20, $10 ; entry 0
    db $d0, $e0, $21, $10 ; entry 1
    db $d0, $e8, $22, $10 ; entry 2
    db $d8, $e8, $23, $10 ; entry 3
    db $d8, $f0, $24, $10 ; entry 4
    db $e0, $f0, $20, $10 ; entry 5
    db $e0, $f8, $21, $10 ; entry 6
    db $e0, $00, $22, $10 ; entry 7
    db $e8, $00, $23, $10 ; entry 8
    db $e8, $08, $24, $10 ; entry 9
    db $f0, $08, $20, $10 ; entry 10
    db $f0, $10, $21, $10 ; entry 11
    db $f0, $18, $22, $10 ; entry 12
    db $f8, $18, $23, $10 ; entry 13
    db $f8, $20, $24, $10 ; entry 14
    db $80 ; end

; frame 11 of MetaSprites92Set38; ends with $80 (E-0147)
MetaSprites92Set38Frame11::
    db $d0, $20, $20, $30 ; entry 0
    db $d0, $18, $21, $30 ; entry 1
    db $d0, $10, $22, $30 ; entry 2
    db $d8, $10, $23, $30 ; entry 3
    db $d8, $08, $24, $30 ; entry 4
    db $e0, $08, $20, $30 ; entry 5
    db $e0, $00, $21, $30 ; entry 6
    db $e0, $f8, $22, $30 ; entry 7
    db $e8, $f8, $23, $30 ; entry 8
    db $e8, $f0, $24, $30 ; entry 9
    db $f0, $f0, $20, $30 ; entry 10
    db $f0, $e8, $21, $30 ; entry 11
    db $f0, $e0, $22, $30 ; entry 12
    db $f8, $e0, $23, $30 ; entry 13
    db $f8, $d8, $24, $30 ; entry 14
    db $80 ; end

; frame 12 of MetaSprites92Set38; ends with $80 (E-0147)
MetaSprites92Set38Frame12::
    db $d0, $c4, $25, $10 ; entry 0
    db $d0, $cc, $26, $10 ; entry 1
    db $d0, $d4, $27, $10 ; entry 2
    db $d0, $dc, $28, $10 ; entry 3
    db $d8, $d4, $2b, $10 ; entry 4
    db $d8, $dc, $2c, $10 ; entry 5
    db $d8, $e4, $2d, $10 ; entry 6
    db $d8, $ec, $2e, $10 ; entry 7
    db $d8, $f4, $2f, $10 ; entry 8
    db $e0, $e4, $25, $10 ; entry 9
    db $e0, $ec, $26, $10 ; entry 10
    db $e0, $f4, $27, $10 ; entry 11
    db $e0, $fc, $28, $10 ; entry 12
    db $e8, $f4, $2b, $10 ; entry 13
    db $e8, $fc, $2c, $10 ; entry 14
    db $e8, $04, $2d, $10 ; entry 15
    db $e8, $0c, $2e, $10 ; entry 16
    db $e8, $14, $2f, $10 ; entry 17
    db $f0, $04, $25, $10 ; entry 18
    db $f0, $0c, $26, $10 ; entry 19
    db $f0, $14, $27, $10 ; entry 20
    db $f0, $1c, $28, $10 ; entry 21
    db $f8, $14, $2b, $10 ; entry 22
    db $f8, $1c, $2c, $10 ; entry 23
    db $f8, $24, $2d, $10 ; entry 24
    db $f8, $2c, $2e, $10 ; entry 25
    db $f8, $34, $2f, $10 ; entry 26
    db $80 ; end

; frame 13 of MetaSprites92Set38; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set38Frame13::
    db $d0, $34, $25, $30 ; entry 0
    db $d0, $2c, $26, $30 ; entry 1
    db $d0, $24, $27, $30 ; entry 2
    db $d0, $1c, $28, $30 ; entry 3
    db $d8, $24, $2b, $30 ; entry 4
    db $d8, $1c, $2c, $30 ; entry 5
    db $d8, $14, $2d, $30 ; entry 6
    db $d8, $0c, $2e, $30 ; entry 7
    db $d8, $04, $2f, $30 ; entry 8
    db $e0, $14, $25, $30 ; entry 9
    db $e0, $0c, $26, $30 ; entry 10
    db $e0, $04, $27, $30 ; entry 11
    db $e0, $fc, $28, $30 ; entry 12
    db $e8, $04, $2b, $30 ; entry 13
    db $e8, $fc, $2c, $30 ; entry 14
    db $e8, $f4, $2d, $30 ; entry 15
    db $e8, $ec, $2e, $30 ; entry 16
    db $e8, $e4, $2f, $30 ; entry 17
    db $f0, $f4, $25, $30 ; entry 18
    db $f0, $ec, $26, $30 ; entry 19
    db $f0, $e4, $27, $30 ; entry 20
    db $f0, $dc, $28, $30 ; entry 21
    db $f8, $e4, $2b, $30 ; entry 22
    db $f8, $dc, $2c, $30 ; entry 23
    db $f8, $d4, $2d, $30 ; entry 24
    db $f8, $cc, $2e, $30 ; entry 25
    db $f8, $c4, $2f, $30 ; entry 26
    db $80 ; end

; frame 14 of MetaSprites92Set38; ends with $80 (E-0147)
MetaSprites92Set38Frame14::
    db $d0, $d8, $23, $10 ; entry 0
    db $d0, $e0, $24, $10 ; entry 1
    db $d8, $e0, $20, $10 ; entry 2
    db $d8, $e8, $21, $10 ; entry 3
    db $d8, $f0, $22, $10 ; entry 4
    db $e0, $f0, $23, $10 ; entry 5
    db $e0, $f8, $24, $10 ; entry 6
    db $e8, $f8, $20, $10 ; entry 7
    db $e8, $00, $21, $10 ; entry 8
    db $e8, $08, $22, $10 ; entry 9
    db $f0, $08, $23, $10 ; entry 10
    db $f0, $10, $24, $10 ; entry 11
    db $f8, $10, $20, $10 ; entry 12
    db $f8, $18, $21, $10 ; entry 13
    db $f8, $20, $22, $10 ; entry 14
    db $80 ; end

; frame 15 of MetaSprites92Set38; ends with $80 (E-0147)
MetaSprites92Set38Frame15::
    db $d0, $20, $23, $30 ; entry 0
    db $d0, $18, $24, $30 ; entry 1
    db $d8, $18, $20, $30 ; entry 2
    db $d8, $10, $21, $30 ; entry 3
    db $d8, $08, $22, $30 ; entry 4
    db $e0, $08, $23, $30 ; entry 5
    db $e0, $00, $24, $30 ; entry 6
    db $e8, $00, $20, $30 ; entry 7
    db $e8, $f8, $21, $30 ; entry 8
    db $e8, $f0, $22, $30 ; entry 9
    db $f0, $f0, $23, $30 ; entry 10
    db $f0, $e8, $24, $30 ; entry 11
    db $f8, $e8, $20, $30 ; entry 12
    db $f8, $e0, $21, $30 ; entry 13
    db $f8, $d8, $22, $30 ; entry 14
    db $80 ; end

; frame 16 of MetaSprites92Set38; ends with $80 (E-0147)
MetaSprites92Set38Frame16::
    db $d0, $c0, $2b, $10 ; entry 0
    db $d0, $c8, $2c, $10 ; entry 1
    db $d0, $f0, $2f, $10 ; entry 2
    db $d8, $d0, $25, $10 ; entry 3
    db $d8, $f0, $27, $30 ; entry 4
    db $e0, $e0, $2b, $10 ; entry 5
    db $e0, $e8, $2c, $10 ; entry 6
    db $e0, $10, $2f, $10 ; entry 7
    db $e8, $f0, $25, $10 ; entry 8
    db $e8, $f8, $26, $10 ; entry 9
    db $e8, $10, $27, $10 ; entry 10
    db $e8, $18, $28, $10 ; entry 11
    db $f0, $00, $2b, $10 ; entry 12
    db $f0, $20, $2e, $10 ; entry 13
    db $f0, $28, $2f, $10 ; entry 14
    db $f8, $38, $28, $10 ; entry 15
    db $e0, $00, $2d, $10 ; entry 16
    db $e0, $08, $2e, $10 ; entry 17
    db $d0, $d8, $2d, $10 ; entry 18
    db $d0, $e8, $2e, $10 ; entry 19
    db $d8, $d8, $26, $10 ; entry 20
    db $d0, $d0, $27, $10 ; entry 21
    db $e0, $f8, $27, $10 ; entry 22
    db $f0, $08, $27, $10 ; entry 23
    db $d8, $e8, $27, $10 ; entry 24
    db $f0, $10, $29, $30 ; entry 25
    db $e8, $00, $29, $10 ; entry 26
    db $f8, $30, $27, $10 ; entry 27
    db $f8, $28, $29, $70 ; entry 28
    db $f8, $10, $25, $10 ; entry 29
    db $f8, $18, $26, $10 ; entry 30
    db $f8, $20, $27, $10 ; entry 31
    db $f0, $18, $16, $10 ; entry 32
    db $e0, $f0, $16, $10 ; entry 33
    db $d8, $e0, $16, $30 ; entry 34
    db $d0, $e0, $16, $70 ; entry 35
    db $d8, $f8, $2b, $70 ; entry 36
    db $e8, $08, $16, $10 ; entry 37
    db $80 ; end

; frame 17 of MetaSprites92Set38; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set38Frame17::
    db $d0, $38, $2b, $30 ; entry 0
    db $d0, $30, $2c, $30 ; entry 1
    db $d0, $08, $2f, $30 ; entry 2
    db $d8, $28, $25, $30 ; entry 3
    db $d8, $08, $27, $10 ; entry 4
    db $e0, $18, $2b, $30 ; entry 5
    db $e0, $10, $2c, $30 ; entry 6
    db $e0, $e8, $2f, $30 ; entry 7
    db $e8, $08, $25, $30 ; entry 8
    db $e8, $00, $26, $30 ; entry 9
    db $e8, $e8, $27, $30 ; entry 10
    db $e8, $e0, $28, $30 ; entry 11
    db $f0, $f8, $2b, $30 ; entry 12
    db $f0, $d8, $2e, $30 ; entry 13
    db $f0, $d0, $2f, $30 ; entry 14
    db $f8, $c0, $28, $30 ; entry 15
    db $e0, $f8, $2d, $30 ; entry 16
    db $e0, $f0, $2e, $30 ; entry 17
    db $d0, $20, $2d, $30 ; entry 18
    db $d0, $10, $2e, $30 ; entry 19
    db $d8, $20, $26, $30 ; entry 20
    db $d0, $28, $27, $30 ; entry 21
    db $e0, $00, $27, $30 ; entry 22
    db $f0, $f0, $27, $30 ; entry 23
    db $d8, $10, $27, $30 ; entry 24
    db $f0, $e8, $29, $10 ; entry 25
    db $e8, $f8, $29, $30 ; entry 26
    db $f8, $c8, $27, $30 ; entry 27
    db $f8, $d0, $29, $50 ; entry 28
    db $f8, $e8, $25, $30 ; entry 29
    db $f8, $e0, $26, $30 ; entry 30
    db $f8, $d8, $27, $30 ; entry 31
    db $f0, $e0, $16, $30 ; entry 32
    db $e0, $08, $16, $30 ; entry 33
    db $d8, $18, $16, $10 ; entry 34
    db $d0, $18, $16, $50 ; entry 35
    db $d8, $00, $2b, $50 ; entry 36
    db $e8, $f0, $16, $30 ; entry 37
    db $80 ; end

; frame 18 of MetaSprites92Set38; ends with $80 (E-0147)
MetaSprites92Set38Frame18::
    db $f0, $0c, $0f, $10 ; entry 0
    db $f0, $14, $10, $10 ; entry 1
    db $f0, $1c, $11, $10 ; entry 2
    db $f8, $1c, $12, $10 ; entry 3
    db $f8, $24, $13, $10 ; entry 4
    db $f8, $2c, $14, $10 ; entry 5
    db $e0, $ec, $0f, $10 ; entry 6
    db $e0, $f4, $10, $10 ; entry 7
    db $e0, $fc, $11, $10 ; entry 8
    db $e8, $fc, $12, $10 ; entry 9
    db $e8, $04, $13, $10 ; entry 10
    db $e8, $0c, $14, $10 ; entry 11
    db $d0, $cc, $0f, $10 ; entry 12
    db $d0, $d4, $10, $10 ; entry 13
    db $d0, $dc, $11, $10 ; entry 14
    db $d8, $dc, $12, $10 ; entry 15
    db $d8, $e4, $13, $10 ; entry 16
    db $d8, $ec, $14, $10 ; entry 17
    db $80 ; end

; frame 19 of MetaSprites92Set38; ends with $80 (E-0147)
MetaSprites92Set38Frame19::
    db $f0, $ec, $0f, $30 ; entry 0
    db $f0, $e4, $10, $30 ; entry 1
    db $f0, $dc, $11, $30 ; entry 2
    db $f8, $dc, $12, $30 ; entry 3
    db $f8, $d4, $13, $30 ; entry 4
    db $f8, $cc, $14, $30 ; entry 5
    db $e0, $0c, $0f, $30 ; entry 6
    db $e0, $04, $10, $30 ; entry 7
    db $e0, $fc, $11, $30 ; entry 8
    db $e8, $fc, $12, $30 ; entry 9
    db $e8, $f4, $13, $30 ; entry 10
    db $e8, $ec, $14, $30 ; entry 11
    db $d0, $2c, $0f, $30 ; entry 12
    db $d0, $24, $10, $30 ; entry 13
    db $d0, $1c, $11, $30 ; entry 14
    db $d8, $1c, $12, $30 ; entry 15
    db $d8, $14, $13, $30 ; entry 16
    db $d8, $0c, $14, $30 ; entry 17
    db $80 ; end

; frame 20 of MetaSprites92Set38; ends with $80 (E-0147)
MetaSprites92Set38Frame20::
    db $e8, $fc, $0f, $10 ; entry 0
    db $e8, $04, $10, $10 ; entry 1
    db $e8, $0c, $11, $10 ; entry 2
    db $f0, $0c, $12, $10 ; entry 3
    db $f0, $14, $13, $10 ; entry 4
    db $f0, $1c, $14, $10 ; entry 5
    db $f8, $1c, $0f, $10 ; entry 6
    db $f8, $24, $10, $10 ; entry 7
    db $f8, $2c, $11, $10 ; entry 8
    db $d8, $dc, $0f, $10 ; entry 9
    db $d8, $e4, $10, $10 ; entry 10
    db $d8, $ec, $11, $10 ; entry 11
    db $e0, $ec, $12, $10 ; entry 12
    db $e0, $f4, $13, $10 ; entry 13
    db $e0, $fc, $14, $10 ; entry 14
    db $d0, $cc, $12, $10 ; entry 15
    db $d0, $d4, $13, $10 ; entry 16
    db $d0, $dc, $14, $10 ; entry 17
    db $80 ; end

; frame 21 of MetaSprites92Set38; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set38Frame21::
    db $e8, $fc, $0f, $30 ; entry 0
    db $e8, $f4, $10, $30 ; entry 1
    db $e8, $ec, $11, $30 ; entry 2
    db $f0, $ec, $12, $30 ; entry 3
    db $f0, $e4, $13, $30 ; entry 4
    db $f0, $dc, $14, $30 ; entry 5
    db $f8, $dc, $0f, $30 ; entry 6
    db $f8, $d4, $10, $30 ; entry 7
    db $f8, $cc, $11, $30 ; entry 8
    db $d8, $1c, $0f, $30 ; entry 9
    db $d8, $14, $10, $30 ; entry 10
    db $d8, $0c, $11, $30 ; entry 11
    db $e0, $0c, $12, $30 ; entry 12
    db $e0, $04, $13, $30 ; entry 13
    db $e0, $fc, $14, $30 ; entry 14
    db $d0, $2c, $12, $30 ; entry 15
    db $d0, $24, $13, $30 ; entry 16
    db $d0, $1c, $14, $30 ; entry 17
    db $80 ; end

; frame 22 of MetaSprites92Set38; ends with $80 (E-0147)
MetaSprites92Set38Frame22::
    db $80 ; end

; meta-sprite set 57 of MetaSprites92Table: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites92Set39::
    dw MetaSprites92Set39Frame0 ; entry 0
    dw MetaSprites92Set39Frame1 ; entry 1
    dw MetaSprites92Set39Frame2 ; entry 2
    dw MetaSprites92Set39Frame3 ; entry 3
    dw MetaSprites92Set39Frame4 ; entry 4
    dw MetaSprites92Set39Frame5 ; entry 5
    dw MetaSprites92Set39Frame6 ; entry 6
    dw MetaSprites92Set39Frame7 ; entry 7
    dw MetaSprites92Set39Frame8 ; entry 8
    dw MetaSprites92Set39Frame9 ; entry 9
    dw MetaSprites92Set39Frame10 ; entry 10
    dw MetaSprites92Set39Frame11 ; entry 11
    dw MetaSprites92Set39Frame12 ; entry 12
    dw MetaSprites92Set39Frame13 ; entry 13
    dw MetaSprites92Set39Frame14 ; entry 14
    dw MetaSprites92Set39Frame15 ; entry 15
    dw MetaSprites92Set39Frame15 ; entry 16
    dw MetaSprites92Set39Frame15 ; entry 17
    dw MetaSprites92Set39Frame15 ; entry 18
    dw MetaSprites92Set39Frame15 ; entry 19
    dw MetaSprites92Set39Frame15 ; entry 20
    dw MetaSprites92Set39Frame15 ; entry 21
    dw MetaSprites92Set39Frame15 ; entry 22
    dw MetaSprites92Set39Frame15 ; entry 23
    dw MetaSprites92Set39Frame15 ; entry 24
    dw MetaSprites92Set39Frame15 ; entry 25
    dw MetaSprites92Set39Frame15 ; entry 26
    dw MetaSprites92Set39Frame15 ; entry 27
    dw MetaSprites92Set39Frame15 ; entry 28
    dw MetaSprites92Set39Frame15 ; entry 29
    dw MetaSprites92Set39Frame15 ; entry 30
    dw MetaSprites92Set39Frame15 ; entry 31

; frame 0 of MetaSprites92Set39; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set39Frame0::
    db $f8, $c0, $00, $10 ; entry 0
    db $f0, $c0, $00, $10 ; entry 1
    db $e8, $c0, $00, $10 ; entry 2
    db $f8, $e0, $00, $10 ; entry 3
    db $f0, $e0, $00, $10 ; entry 4
    db $f8, $f0, $00, $10 ; entry 5
    db $f0, $f0, $00, $10 ; entry 6
    db $e8, $f0, $00, $10 ; entry 7
    db $e0, $f0, $00, $10 ; entry 8
    db $d8, $f0, $00, $10 ; entry 9
    db $f8, $00, $00, $10 ; entry 10
    db $f0, $00, $00, $10 ; entry 11
    db $e8, $00, $00, $10 ; entry 12
    db $f8, $20, $00, $10 ; entry 13
    db $f0, $20, $00, $10 ; entry 14
    db $e8, $20, $00, $10 ; entry 15
    db $e0, $20, $00, $10 ; entry 16
    db $d8, $20, $00, $10 ; entry 17
    db $f8, $30, $00, $10 ; entry 18
    db $f0, $30, $00, $10 ; entry 19
    db $e0, $00, $00, $10 ; entry 20
    db $d8, $00, $00, $10 ; entry 21
    db $d0, $00, $00, $10 ; entry 22
    db $80 ; end

; frame 1 of MetaSprites92Set39; ends with $80 (E-0147)
MetaSprites92Set39Frame1::
    db $e8, $c0, $01, $10 ; entry 0
    db $e0, $c0, $01, $10 ; entry 1
    db $d0, $c0, $01, $10 ; entry 2
    db $d8, $c0, $01, $10 ; entry 3
    db $f8, $e0, $01, $10 ; entry 4
    db $f0, $e0, $01, $10 ; entry 5
    db $e8, $e0, $01, $10 ; entry 6
    db $e0, $e0, $01, $10 ; entry 7
    db $d0, $e0, $01, $10 ; entry 8
    db $d8, $e0, $01, $10 ; entry 9
    db $f8, $f0, $01, $10 ; entry 10
    db $f0, $f0, $01, $10 ; entry 11
    db $e8, $f0, $01, $10 ; entry 12
    db $e0, $f0, $01, $10 ; entry 13
    db $d0, $f0, $01, $10 ; entry 14
    db $d8, $f0, $01, $10 ; entry 15
    db $f8, $00, $01, $10 ; entry 16
    db $f0, $00, $01, $10 ; entry 17
    db $e8, $00, $01, $10 ; entry 18
    db $e0, $00, $01, $10 ; entry 19
    db $d0, $00, $01, $10 ; entry 20
    db $d8, $00, $01, $10 ; entry 21
    db $f8, $20, $01, $10 ; entry 22
    db $f0, $20, $01, $10 ; entry 23
    db $e8, $20, $01, $10 ; entry 24
    db $e0, $20, $01, $10 ; entry 25
    db $d0, $20, $01, $10 ; entry 26
    db $d8, $20, $01, $10 ; entry 27
    db $f8, $30, $01, $10 ; entry 28
    db $f0, $30, $01, $10 ; entry 29
    db $e8, $30, $01, $10 ; entry 30
    db $e0, $30, $01, $10 ; entry 31
    db $d0, $30, $01, $10 ; entry 32
    db $d8, $30, $01, $10 ; entry 33
    db $f8, $c0, $01, $10 ; entry 34
    db $f0, $c0, $01, $10 ; entry 35
    db $80 ; end

; frame 2 of MetaSprites92Set39; ends with $80 (E-0147)
MetaSprites92Set39Frame2::
    db $f0, $c8, $02, $10 ; entry 0
    db $e8, $c8, $02, $10 ; entry 1
    db $e0, $c8, $02, $10 ; entry 2
    db $d8, $c8, $02, $10 ; entry 3
    db $d0, $c8, $02, $10 ; entry 4
    db $f8, $d8, $02, $10 ; entry 5
    db $f0, $d8, $02, $10 ; entry 6
    db $e8, $d8, $02, $10 ; entry 7
    db $e0, $d8, $02, $10 ; entry 8
    db $d8, $d8, $02, $10 ; entry 9
    db $d0, $d8, $02, $10 ; entry 10
    db $f8, $f8, $02, $10 ; entry 11
    db $f0, $f8, $02, $10 ; entry 12
    db $e8, $f8, $02, $10 ; entry 13
    db $e0, $f8, $02, $10 ; entry 14
    db $d8, $f8, $02, $10 ; entry 15
    db $d0, $f8, $02, $10 ; entry 16
    db $f8, $08, $02, $10 ; entry 17
    db $f0, $08, $02, $10 ; entry 18
    db $e8, $08, $02, $10 ; entry 19
    db $e0, $08, $02, $10 ; entry 20
    db $d8, $08, $02, $10 ; entry 21
    db $d0, $08, $02, $10 ; entry 22
    db $f8, $18, $02, $10 ; entry 23
    db $f0, $18, $02, $10 ; entry 24
    db $e8, $18, $02, $10 ; entry 25
    db $e0, $18, $02, $10 ; entry 26
    db $d8, $18, $02, $10 ; entry 27
    db $d0, $18, $02, $10 ; entry 28
    db $f8, $38, $02, $10 ; entry 29
    db $f0, $38, $02, $10 ; entry 30
    db $e8, $38, $02, $10 ; entry 31
    db $e0, $38, $02, $10 ; entry 32
    db $d8, $38, $02, $10 ; entry 33
    db $d0, $38, $02, $10 ; entry 34
    db $f8, $c8, $02, $10 ; entry 35
    db $80 ; end

; frame 3 of MetaSprites92Set39; ends with $80 (E-0147)
MetaSprites92Set39Frame3::
    db $f8, $bc, $02, $10 ; entry 0
    db $f0, $bc, $02, $10 ; entry 1
    db $e8, $bc, $02, $10 ; entry 2
    db $e0, $bc, $02, $10 ; entry 3
    db $d8, $bc, $02, $10 ; entry 4
    db $d0, $bc, $02, $10 ; entry 5
    db $f8, $da, $02, $10 ; entry 6
    db $f0, $da, $02, $10 ; entry 7
    db $e8, $da, $02, $10 ; entry 8
    db $e0, $da, $02, $10 ; entry 9
    db $d8, $da, $02, $10 ; entry 10
    db $d0, $da, $02, $10 ; entry 11
    db $f8, $f0, $02, $10 ; entry 12
    db $f0, $f0, $02, $10 ; entry 13
    db $e8, $f0, $02, $10 ; entry 14
    db $e0, $f0, $02, $10 ; entry 15
    db $d8, $f0, $02, $10 ; entry 16
    db $d0, $f0, $02, $10 ; entry 17
    db $f8, $fc, $02, $10 ; entry 18
    db $f0, $fc, $02, $10 ; entry 19
    db $e8, $fc, $02, $10 ; entry 20
    db $e0, $fc, $02, $10 ; entry 21
    db $d8, $fc, $02, $10 ; entry 22
    db $d0, $fc, $02, $10 ; entry 23
    db $f8, $20, $02, $10 ; entry 24
    db $f0, $20, $02, $10 ; entry 25
    db $e8, $20, $02, $10 ; entry 26
    db $e0, $20, $02, $10 ; entry 27
    db $d8, $20, $02, $10 ; entry 28
    db $d0, $20, $02, $10 ; entry 29
    db $f8, $40, $02, $10 ; entry 30
    db $f0, $40, $02, $10 ; entry 31
    db $e8, $40, $02, $10 ; entry 32
    db $e0, $40, $02, $10 ; entry 33
    db $d8, $40, $02, $10 ; entry 34
    db $d0, $40, $02, $10 ; entry 35
    db $80 ; end

; frame 4 of MetaSprites92Set39; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set39Frame4::
    db $f8, $26, $03, $10 ; entry 0
    db $f0, $26, $03, $10 ; entry 1
    db $e8, $26, $03, $10 ; entry 2
    db $e0, $26, $03, $10 ; entry 3
    db $d8, $26, $03, $10 ; entry 4
    db $d0, $26, $03, $10 ; entry 5
    db $f8, $f8, $03, $10 ; entry 6
    db $f0, $f8, $03, $10 ; entry 7
    db $e8, $f8, $03, $10 ; entry 8
    db $e0, $f8, $03, $10 ; entry 9
    db $d8, $f8, $03, $10 ; entry 10
    db $d0, $f8, $03, $10 ; entry 11
    db $f8, $b8, $03, $10 ; entry 12
    db $f0, $b8, $03, $10 ; entry 13
    db $e8, $b8, $03, $10 ; entry 14
    db $e0, $b8, $03, $10 ; entry 15
    db $d8, $b8, $03, $10 ; entry 16
    db $d0, $b8, $03, $10 ; entry 17
    db $f8, $c0, $03, $30 ; entry 18
    db $f0, $c0, $03, $30 ; entry 19
    db $e8, $c0, $03, $30 ; entry 20
    db $e0, $c0, $03, $30 ; entry 21
    db $d8, $c0, $03, $30 ; entry 22
    db $d0, $c0, $03, $30 ; entry 23
    db $f8, $00, $03, $30 ; entry 24
    db $f0, $00, $03, $30 ; entry 25
    db $e8, $00, $03, $30 ; entry 26
    db $e0, $00, $03, $30 ; entry 27
    db $d8, $00, $03, $30 ; entry 28
    db $d0, $00, $03, $30 ; entry 29
    db $f8, $2e, $03, $30 ; entry 30
    db $f0, $2e, $03, $30 ; entry 31
    db $e8, $2e, $03, $30 ; entry 32
    db $e0, $2e, $03, $30 ; entry 33
    db $d8, $2e, $03, $30 ; entry 34
    db $d0, $2e, $03, $30 ; entry 35
    db $80 ; end

; frame 5 of MetaSprites92Set39; ends with $80 (E-0147)
MetaSprites92Set39Frame5::
    db $f8, $d0, $03, $10 ; entry 0
    db $f0, $d0, $03, $10 ; entry 1
    db $e8, $d0, $03, $10 ; entry 2
    db $e0, $d0, $03, $10 ; entry 3
    db $d8, $d0, $03, $10 ; entry 4
    db $d0, $d0, $03, $10 ; entry 5
    db $f8, $d8, $03, $30 ; entry 6
    db $f0, $d8, $03, $30 ; entry 7
    db $e8, $d8, $03, $30 ; entry 8
    db $e0, $d8, $03, $30 ; entry 9
    db $d8, $d8, $03, $30 ; entry 10
    db $d0, $d8, $03, $30 ; entry 11
    db $f8, $3c, $03, $10 ; entry 12
    db $f0, $3c, $03, $10 ; entry 13
    db $e8, $3c, $03, $10 ; entry 14
    db $e0, $3c, $03, $10 ; entry 15
    db $d8, $3c, $03, $10 ; entry 16
    db $d0, $3c, $03, $10 ; entry 17
    db $f8, $44, $03, $30 ; entry 18
    db $f0, $44, $03, $30 ; entry 19
    db $e8, $44, $03, $30 ; entry 20
    db $e0, $44, $03, $30 ; entry 21
    db $d8, $44, $03, $30 ; entry 22
    db $d0, $44, $03, $30 ; entry 23
    db $f8, $10, $03, $10 ; entry 24
    db $f0, $10, $03, $10 ; entry 25
    db $e8, $10, $03, $10 ; entry 26
    db $e0, $10, $03, $10 ; entry 27
    db $d8, $10, $03, $10 ; entry 28
    db $d0, $10, $03, $10 ; entry 29
    db $f8, $18, $03, $30 ; entry 30
    db $f0, $18, $03, $30 ; entry 31
    db $e8, $18, $03, $30 ; entry 32
    db $e0, $18, $03, $30 ; entry 33
    db $d8, $18, $03, $30 ; entry 34
    db $d0, $18, $03, $30 ; entry 35
    db $80 ; end

; frame 6 of MetaSprites92Set39; ends with $80 (E-0147)
MetaSprites92Set39Frame6::
    db $f8, $3c, $03, $30 ; entry 0
    db $f0, $3c, $03, $30 ; entry 1
    db $e8, $3c, $03, $30 ; entry 2
    db $e0, $3c, $03, $30 ; entry 3
    db $d8, $3c, $03, $30 ; entry 4
    db $d0, $3c, $03, $30 ; entry 5
    db $f8, $2c, $03, $10 ; entry 6
    db $f0, $2c, $03, $10 ; entry 7
    db $e8, $2c, $03, $10 ; entry 8
    db $e0, $2c, $03, $10 ; entry 9
    db $d8, $2c, $03, $10 ; entry 10
    db $d0, $2c, $03, $10 ; entry 11
    db $f8, $34, $04, $10 ; entry 12
    db $f0, $34, $04, $10 ; entry 13
    db $e8, $34, $04, $10 ; entry 14
    db $e0, $34, $04, $10 ; entry 15
    db $d8, $34, $04, $10 ; entry 16
    db $d0, $34, $04, $10 ; entry 17
    db $f8, $d0, $03, $30 ; entry 18
    db $f0, $d0, $03, $30 ; entry 19
    db $e8, $d0, $03, $30 ; entry 20
    db $e0, $d0, $03, $30 ; entry 21
    db $d8, $d0, $03, $30 ; entry 22
    db $d0, $d0, $03, $30 ; entry 23
    db $f8, $c0, $03, $10 ; entry 24
    db $f0, $c0, $03, $10 ; entry 25
    db $e8, $c0, $03, $10 ; entry 26
    db $e0, $c0, $03, $10 ; entry 27
    db $d8, $c0, $03, $10 ; entry 28
    db $d0, $c0, $03, $10 ; entry 29
    db $f8, $c8, $04, $10 ; entry 30
    db $f0, $c8, $04, $10 ; entry 31
    db $e8, $c8, $04, $10 ; entry 32
    db $e0, $c8, $04, $10 ; entry 33
    db $d8, $c8, $04, $10 ; entry 34
    db $d0, $c8, $04, $10 ; entry 35
    db $80 ; end

; frame 7 of MetaSprites92Set39; ends with $80 (E-0147)
MetaSprites92Set39Frame7::
    db $f8, $20, $03, $30 ; entry 0
    db $f0, $20, $03, $30 ; entry 1
    db $e8, $20, $03, $30 ; entry 2
    db $e0, $20, $03, $30 ; entry 3
    db $d8, $20, $03, $30 ; entry 4
    db $d0, $20, $03, $30 ; entry 5
    db $f8, $10, $03, $10 ; entry 6
    db $f0, $10, $03, $10 ; entry 7
    db $e8, $10, $03, $10 ; entry 8
    db $e0, $10, $03, $10 ; entry 9
    db $d8, $10, $03, $10 ; entry 10
    db $d0, $10, $03, $10 ; entry 11
    db $f8, $18, $04, $10 ; entry 12
    db $f0, $18, $04, $10 ; entry 13
    db $e8, $18, $04, $10 ; entry 14
    db $e0, $18, $04, $10 ; entry 15
    db $d8, $18, $04, $10 ; entry 16
    db $d0, $18, $04, $10 ; entry 17
    db $f8, $f0, $03, $30 ; entry 18
    db $f0, $f0, $03, $30 ; entry 19
    db $e8, $f0, $03, $30 ; entry 20
    db $e0, $f0, $03, $30 ; entry 21
    db $d8, $f0, $03, $30 ; entry 22
    db $d0, $f0, $03, $30 ; entry 23
    db $f8, $e0, $03, $10 ; entry 24
    db $f0, $e0, $03, $10 ; entry 25
    db $e8, $e0, $03, $10 ; entry 26
    db $e0, $e0, $03, $10 ; entry 27
    db $d8, $e0, $03, $10 ; entry 28
    db $d0, $e0, $03, $10 ; entry 29
    db $f8, $e8, $04, $10 ; entry 30
    db $f0, $e8, $04, $10 ; entry 31
    db $e8, $e8, $04, $10 ; entry 32
    db $e0, $e8, $04, $10 ; entry 33
    db $d8, $e8, $04, $10 ; entry 34
    db $d0, $e8, $04, $10 ; entry 35
    db $80 ; end

; frame 8 of MetaSprites92Set39; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set39Frame8::
    db $f8, $e8, $03, $10 ; entry 0
    db $f0, $e8, $03, $10 ; entry 1
    db $e8, $e8, $03, $10 ; entry 2
    db $e0, $e8, $03, $10 ; entry 3
    db $d8, $e8, $03, $10 ; entry 4
    db $d0, $e8, $03, $10 ; entry 5
    db $f8, $f0, $04, $10 ; entry 6
    db $f0, $f0, $04, $10 ; entry 7
    db $e8, $f0, $04, $10 ; entry 8
    db $e0, $f0, $04, $10 ; entry 9
    db $d8, $f0, $04, $10 ; entry 10
    db $d0, $f0, $04, $10 ; entry 11
    db $f8, $10, $03, $30 ; entry 12
    db $f0, $10, $03, $30 ; entry 13
    db $e8, $10, $03, $30 ; entry 14
    db $e0, $10, $03, $30 ; entry 15
    db $d8, $10, $03, $30 ; entry 16
    db $d0, $10, $03, $30 ; entry 17
    db $f8, $08, $04, $10 ; entry 18
    db $f0, $08, $04, $10 ; entry 19
    db $e8, $08, $04, $10 ; entry 20
    db $e0, $08, $04, $10 ; entry 21
    db $d8, $08, $04, $10 ; entry 22
    db $d0, $08, $04, $10 ; entry 23
    db $f8, $00, $04, $10 ; entry 24
    db $f0, $00, $04, $10 ; entry 25
    db $e8, $00, $04, $10 ; entry 26
    db $e0, $00, $04, $10 ; entry 27
    db $d8, $00, $04, $10 ; entry 28
    db $d0, $00, $04, $10 ; entry 29
    db $f8, $f8, $04, $10 ; entry 30
    db $f0, $f8, $04, $10 ; entry 31
    db $e8, $f8, $04, $10 ; entry 32
    db $e0, $f8, $04, $10 ; entry 33
    db $d8, $f8, $04, $10 ; entry 34
    db $d0, $f8, $04, $10 ; entry 35
    db $80 ; end

; frame 9 of MetaSprites92Set39; ends with $80 (E-0147)
MetaSprites92Set39Frame9::
    db $e6, $04, $05, $10 ; entry 0
    db $e2, $f4, $05, $10 ; entry 1
    db $80 ; end

; frame 10 of MetaSprites92Set39; ends with $80 (E-0147)
MetaSprites92Set39Frame10::
    db $e2, $01, $08, $10 ; entry 0
    db $ea, $01, $09, $10 ; entry 1
    db $e2, $08, $08, $30 ; entry 2
    db $ea, $08, $09, $30 ; entry 3
    db $de, $f0, $08, $10 ; entry 4
    db $e6, $f0, $09, $10 ; entry 5
    db $de, $f7, $08, $30 ; entry 6
    db $e6, $f7, $09, $30 ; entry 7
    db $e0, $14, $05, $10 ; entry 8
    db $e8, $e4, $05, $10 ; entry 9
    db $80 ; end

; frame 11 of MetaSprites92Set39; ends with $80 (E-0147)
MetaSprites92Set39Frame11::
    db $ea, $24, $05, $10 ; entry 0
    db $de, $d4, $05, $10 ; entry 1
    db $dc, $11, $0a, $10 ; entry 2
    db $e4, $11, $0b, $10 ; entry 3
    db $dc, $18, $0a, $30 ; entry 4
    db $e4, $18, $0b, $30 ; entry 5
    db $e4, $e0, $0a, $10 ; entry 6
    db $ec, $e0, $0b, $10 ; entry 7
    db $e4, $e7, $0a, $30 ; entry 8
    db $ec, $e7, $0b, $30 ; entry 9
    db $80 ; end

; frame 12 of MetaSprites92Set39; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set39Frame12::
    db $ee, $21, $08, $50 ; entry 0
    db $e6, $21, $09, $50 ; entry 1
    db $ee, $28, $08, $70 ; entry 2
    db $e6, $28, $09, $70 ; entry 3
    db $da, $d7, $08, $30 ; entry 4
    db $e2, $d7, $09, $30 ; entry 5
    db $da, $d0, $08, $10 ; entry 6
    db $e2, $d0, $09, $10 ; entry 7
    db $dc, $34, $05, $10 ; entry 8
    db $ec, $c4, $05, $10 ; entry 9
    db $80 ; end

; frame 13 of MetaSprites92Set39; ends with $80 (E-0147)
MetaSprites92Set39Frame13::
    db $ee, $44, $05, $10 ; entry 0
    db $da, $b4, $05, $10 ; entry 1
    db $d8, $31, $0a, $10 ; entry 2
    db $e0, $31, $0b, $10 ; entry 3
    db $d8, $38, $0a, $30 ; entry 4
    db $e0, $38, $0b, $30 ; entry 5
    db $e8, $c0, $0a, $10 ; entry 6
    db $f0, $c0, $0b, $10 ; entry 7
    db $e8, $c7, $0a, $30 ; entry 8
    db $f0, $c7, $0b, $30 ; entry 9
    db $80 ; end

; frame 14 of MetaSprites92Set39; ends with $80 (E-0147)
MetaSprites92Set39Frame14::
    db $f2, $41, $08, $50 ; entry 0
    db $ea, $41, $09, $50 ; entry 1
    db $f2, $48, $08, $70 ; entry 2
    db $ea, $48, $09, $70 ; entry 3
    db $d6, $b7, $08, $30 ; entry 4
    db $de, $b7, $09, $30 ; entry 5
    db $d6, $b0, $08, $10 ; entry 6
    db $de, $b0, $09, $10 ; entry 7
    db $80 ; end

; frame 15 of MetaSprites92Set39; ends with $80 (E-0147)
MetaSprites92Set39Frame15::
    db $80 ; end

; meta-sprite set 58 of MetaSprites92Table: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites92Set3A::
    dw MetaSprites92Set3AFrame0 ; entry 0
    dw MetaSprites92Set3AFrame1 ; entry 1
    dw MetaSprites92Set3AFrame2 ; entry 2
    dw MetaSprites92Set3AFrame3 ; entry 3
    dw MetaSprites92Set3AFrame4 ; entry 4
    dw MetaSprites92Set3AFrame5 ; entry 5
    dw MetaSprites92Set3AFrame6 ; entry 6
    dw MetaSprites92Set3AFrame7 ; entry 7
    dw MetaSprites92Set3AFrame8 ; entry 8
    dw MetaSprites92Set3AFrame9 ; entry 9
    dw MetaSprites92Set3AFrame10 ; entry 10
    dw MetaSprites92Set3AFrame11 ; entry 11
    dw MetaSprites92Set3AFrame12 ; entry 12
    dw MetaSprites92Set3AFrame13 ; entry 13
    dw MetaSprites92Set3AFrame14 ; entry 14
    dw MetaSprites92Set3AFrame15 ; entry 15
    dw MetaSprites92Set3AFrame16 ; entry 16
    dw MetaSprites92Set3AFrame17 ; entry 17
    dw MetaSprites92Set3AFrame18 ; entry 18
    dw MetaSprites92Set3AFrame19 ; entry 19
    dw MetaSprites92Set3AFrame20 ; entry 20
    dw MetaSprites92Set3AFrame21 ; entry 21
    dw MetaSprites92Set3AFrame22 ; entry 22
    dw MetaSprites92Set3AFrame23 ; entry 23
    dw MetaSprites92Set3AFrame24 ; entry 24
    dw MetaSprites92Set3AFrame25 ; entry 25
    dw MetaSprites92Set3AFrame26 ; entry 26
    dw MetaSprites92Set3AFrame27 ; entry 27
    dw MetaSprites92Set3AFrame27 ; entry 28
    dw MetaSprites92Set3AFrame27 ; entry 29
    dw MetaSprites92Set3AFrame27 ; entry 30
    dw MetaSprites92Set3AFrame27 ; entry 31

; frame 0 of MetaSprites92Set3A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set3AFrame0::
    db $e4, $fc, $05, $10 ; entry 0
    db $80 ; end

; frame 1 of MetaSprites92Set3A; ends with $80 (E-0147)
MetaSprites92Set3AFrame1::
    db $e0, $f8, $06, $10 ; entry 0
    db $e0, $00, $06, $30 ; entry 1
    db $e8, $f8, $06, $50 ; entry 2
    db $e8, $00, $06, $70 ; entry 3
    db $ec, $ec, $05, $10 ; entry 4
    db $80 ; end

; frame 2 of MetaSprites92Set3A; ends with $80 (E-0147)
MetaSprites92Set3AFrame2::
    db $e0, $f8, $07, $10 ; entry 0
    db $e0, $00, $07, $30 ; entry 1
    db $e8, $f8, $07, $50 ; entry 2
    db $e8, $00, $07, $70 ; entry 3
    db $e8, $e8, $06, $10 ; entry 4
    db $e8, $f0, $06, $30 ; entry 5
    db $f0, $e8, $06, $50 ; entry 6
    db $f0, $f0, $06, $70 ; entry 7
    db $dc, $0c, $05, $10 ; entry 8
    db $d8, $ec, $05, $10 ; entry 9
    db $80 ; end

; frame 3 of MetaSprites92Set3A; ends with $80 (E-0147)
MetaSprites92Set3AFrame3::
    db $e4, $f4, $0e, $10 ; entry 0
    db $e4, $fc, $0f, $10 ; entry 1
    db $dc, $f4, $0c, $10 ; entry 2
    db $dc, $fc, $0d, $10 ; entry 3
    db $e4, $04, $0e, $30 ; entry 4
    db $dc, $04, $0c, $30 ; entry 5
    db $ec, $f4, $0c, $50 ; entry 6
    db $ec, $fc, $0d, $50 ; entry 7
    db $ec, $04, $0c, $70 ; entry 8
    db $e8, $e8, $07, $10 ; entry 9
    db $e8, $f0, $07, $30 ; entry 10
    db $f0, $e8, $07, $50 ; entry 11
    db $f0, $f0, $07, $70 ; entry 12
    db $d8, $08, $06, $10 ; entry 13
    db $d8, $10, $06, $30 ; entry 14
    db $e0, $08, $06, $50 ; entry 15
    db $e0, $10, $06, $70 ; entry 16
    db $d4, $e8, $08, $10 ; entry 17
    db $dc, $e8, $09, $10 ; entry 18
    db $d4, $ef, $08, $30 ; entry 19
    db $dc, $ef, $09, $30 ; entry 20
    db $f0, $0c, $05, $10 ; entry 21
    db $80 ; end

; frame 4 of MetaSprites92Set3A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set3AFrame4::
    db $e0, $f0, $11, $10 ; entry 0
    db $e0, $f8, $12, $10 ; entry 1
    db $e0, $00, $13, $10 ; entry 2
    db $e0, $08, $14, $10 ; entry 3
    db $d8, $fa, $10, $10 ; entry 4
    db $e8, $08, $11, $70 ; entry 5
    db $e8, $00, $12, $70 ; entry 6
    db $e8, $f8, $13, $70 ; entry 7
    db $e8, $f0, $14, $70 ; entry 8
    db $f0, $fe, $10, $70 ; entry 9
    db $ec, $e4, $0e, $10 ; entry 10
    db $ec, $ec, $0f, $10 ; entry 11
    db $e4, $e4, $0c, $10 ; entry 12
    db $e4, $ec, $0d, $10 ; entry 13
    db $ec, $f4, $0e, $30 ; entry 14
    db $e4, $f4, $0c, $30 ; entry 15
    db $f4, $e4, $0c, $50 ; entry 16
    db $f4, $ec, $0d, $50 ; entry 17
    db $f4, $f4, $0c, $70 ; entry 18
    db $d8, $08, $07, $10 ; entry 19
    db $d8, $10, $07, $30 ; entry 20
    db $e0, $08, $07, $50 ; entry 21
    db $e0, $10, $07, $70 ; entry 22
    db $d4, $e0, $05, $10 ; entry 23
    db $d4, $e8, $0a, $10 ; entry 24
    db $dc, $e8, $0b, $10 ; entry 25
    db $d4, $ef, $0a, $30 ; entry 26
    db $dc, $ef, $0b, $30 ; entry 27
    db $ec, $08, $08, $10 ; entry 28
    db $f4, $08, $09, $10 ; entry 29
    db $ec, $0f, $08, $30 ; entry 30
    db $f4, $0f, $09, $30 ; entry 31
    db $80 ; end

; frame 5 of MetaSprites92Set3A; ends with $80 (E-0147)
MetaSprites92Set3AFrame5::
    db $e8, $e0, $11, $10 ; entry 0
    db $e8, $e8, $12, $10 ; entry 1
    db $e8, $f0, $13, $10 ; entry 2
    db $e8, $f8, $14, $10 ; entry 3
    db $e0, $ea, $10, $10 ; entry 4
    db $f0, $f8, $11, $70 ; entry 5
    db $f0, $f0, $12, $70 ; entry 6
    db $f0, $e8, $13, $70 ; entry 7
    db $f0, $e0, $14, $70 ; entry 8
    db $f8, $ee, $10, $70 ; entry 9
    db $dc, $04, $0e, $10 ; entry 10
    db $dc, $0c, $0f, $10 ; entry 11
    db $d4, $04, $0c, $10 ; entry 12
    db $d4, $0c, $0d, $10 ; entry 13
    db $dc, $14, $0e, $30 ; entry 14
    db $d4, $14, $0c, $30 ; entry 15
    db $e4, $04, $0c, $50 ; entry 16
    db $e4, $0c, $0d, $50 ; entry 17
    db $e4, $14, $0c, $70 ; entry 18
    db $d0, $dc, $06, $10 ; entry 19
    db $d0, $e4, $06, $30 ; entry 20
    db $d8, $dc, $06, $50 ; entry 21
    db $d8, $e4, $06, $70 ; entry 22
    db $f4, $18, $05, $10 ; entry 23
    db $f4, $dc, $05, $10 ; entry 24
    db $ec, $08, $0a, $10 ; entry 25
    db $f4, $08, $0b, $10 ; entry 26
    db $ec, $0f, $0a, $30 ; entry 27
    db $f4, $0f, $0b, $30 ; entry 28
    db $80 ; end

; frame 6 of MetaSprites92Set3A; ends with $80 (E-0147)
MetaSprites92Set3AFrame6::
    db $e0, $00, $11, $50 ; entry 0
    db $e0, $08, $12, $50 ; entry 1
    db $e0, $10, $13, $50 ; entry 2
    db $e0, $18, $14, $50 ; entry 3
    db $e8, $0a, $10, $50 ; entry 4
    db $d8, $18, $11, $30 ; entry 5
    db $d8, $10, $12, $30 ; entry 6
    db $d8, $08, $13, $30 ; entry 7
    db $d8, $00, $14, $30 ; entry 8
    db $d0, $0e, $10, $30 ; entry 9
    db $d0, $dc, $07, $10 ; entry 10
    db $d0, $e4, $07, $30 ; entry 11
    db $d8, $dc, $07, $50 ; entry 12
    db $d8, $e4, $07, $70 ; entry 13
    db $ec, $d4, $05, $10 ; entry 14
    db $f0, $14, $06, $10 ; entry 15
    db $f0, $1c, $06, $30 ; entry 16
    db $f8, $14, $06, $50 ; entry 17
    db $f8, $1c, $06, $70 ; entry 18
    db $f0, $d8, $08, $10 ; entry 19
    db $f8, $d8, $09, $10 ; entry 20
    db $f0, $df, $08, $30 ; entry 21
    db $f8, $df, $09, $30 ; entry 22
    db $d4, $1c, $05, $10 ; entry 23
    db $80 ; end

; frame 7 of MetaSprites92Set3A; ends with $80 (E-0147)
MetaSprites92Set3AFrame7::
    db $d4, $d8, $0e, $10 ; entry 0
    db $d4, $e0, $0f, $10 ; entry 1
    db $d4, $e8, $0e, $30 ; entry 2
    db $dc, $d8, $0c, $50 ; entry 3
    db $dc, $e0, $0d, $50 ; entry 4
    db $dc, $e8, $0c, $70 ; entry 5
    db $cc, $d8, $15, $10 ; entry 6
    db $cc, $e0, $16, $10 ; entry 7
    db $cc, $e8, $15, $30 ; entry 8
    db $e8, $d0, $06, $10 ; entry 9
    db $e8, $d8, $06, $30 ; entry 10
    db $f0, $d0, $06, $50 ; entry 11
    db $f0, $d8, $06, $70 ; entry 12
    db $f0, $14, $07, $10 ; entry 13
    db $f0, $1c, $07, $30 ; entry 14
    db $f8, $14, $07, $50 ; entry 15
    db $f8, $1c, $07, $70 ; entry 16
    db $dc, $24, $05, $10 ; entry 17
    db $f0, $d8, $0a, $10 ; entry 18
    db $f8, $d8, $0b, $10 ; entry 19
    db $f0, $df, $0a, $30 ; entry 20
    db $f8, $df, $0b, $30 ; entry 21
    db $d0, $18, $08, $10 ; entry 22
    db $d8, $18, $09, $10 ; entry 23
    db $d0, $1f, $08, $30 ; entry 24
    db $d8, $1f, $09, $30 ; entry 25
    db $80 ; end

; frame 8 of MetaSprites92Set3A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set3AFrame8::
    db $d0, $ec, $11, $30 ; entry 0
    db $d0, $e4, $12, $30 ; entry 1
    db $d0, $dc, $13, $30 ; entry 2
    db $d0, $d4, $14, $30 ; entry 3
    db $d8, $d4, $11, $50 ; entry 4
    db $d8, $dc, $12, $50 ; entry 5
    db $d8, $e4, $13, $50 ; entry 6
    db $d8, $ec, $14, $50 ; entry 7
    db $e0, $de, $10, $50 ; entry 8
    db $e8, $d0, $07, $10 ; entry 9
    db $e8, $d8, $07, $30 ; entry 10
    db $f0, $d0, $07, $50 ; entry 11
    db $f0, $d8, $07, $70 ; entry 12
    db $dc, $c0, $05, $10 ; entry 13
    db $f4, $10, $0e, $50 ; entry 14
    db $f4, $18, $0f, $50 ; entry 15
    db $f4, $20, $0e, $70 ; entry 16
    db $ec, $10, $0c, $10 ; entry 17
    db $ec, $18, $0d, $10 ; entry 18
    db $ec, $20, $0c, $30 ; entry 19
    db $fc, $10, $15, $50 ; entry 20
    db $fc, $18, $16, $50 ; entry 21
    db $fc, $20, $15, $70 ; entry 22
    db $d8, $20, $06, $10 ; entry 23
    db $d8, $28, $06, $30 ; entry 24
    db $e0, $20, $06, $50 ; entry 25
    db $e0, $28, $06, $70 ; entry 26
    db $d4, $cc, $05, $10 ; entry 27
    db $d0, $18, $0a, $10 ; entry 28
    db $d8, $18, $0b, $10 ; entry 29
    db $d0, $1f, $0a, $30 ; entry 30
    db $d8, $1f, $0b, $30 ; entry 31
    db $80 ; end

; frame 9 of MetaSprites92Set3A; ends with $80 (E-0147)
MetaSprites92Set3AFrame9::
    db $ec, $cc, $0e, $10 ; entry 0
    db $ec, $d4, $0f, $10 ; entry 1
    db $e4, $cc, $0c, $10 ; entry 2
    db $e4, $d4, $0d, $10 ; entry 3
    db $ec, $dc, $0e, $30 ; entry 4
    db $e4, $dc, $0c, $30 ; entry 5
    db $f4, $cc, $0c, $50 ; entry 6
    db $f4, $d4, $0d, $50 ; entry 7
    db $f4, $dc, $0c, $70 ; entry 8
    db $d8, $bc, $06, $10 ; entry 9
    db $d8, $c4, $06, $30 ; entry 10
    db $e0, $bc, $06, $50 ; entry 11
    db $e0, $c4, $06, $70 ; entry 12
    db $f8, $0c, $11, $50 ; entry 13
    db $f8, $14, $12, $50 ; entry 14
    db $f8, $1c, $13, $50 ; entry 15
    db $f8, $24, $14, $50 ; entry 16
    db $f0, $24, $11, $30 ; entry 17
    db $f0, $1c, $12, $30 ; entry 18
    db $f0, $14, $13, $30 ; entry 19
    db $f0, $0c, $14, $30 ; entry 20
    db $e8, $1a, $10, $30 ; entry 21
    db $d8, $20, $07, $10 ; entry 22
    db $d8, $28, $07, $30 ; entry 23
    db $e0, $20, $07, $50 ; entry 24
    db $e0, $28, $07, $70 ; entry 25
    db $ec, $38, $05, $10 ; entry 26
    db $d0, $c8, $08, $10 ; entry 27
    db $d8, $c8, $09, $10 ; entry 28
    db $d0, $cf, $08, $30 ; entry 29
    db $d8, $cf, $09, $30 ; entry 30
    db $f4, $2c, $05, $10 ; entry 31
    db $80 ; end

; frame 10 of MetaSprites92Set3A; ends with $80 (E-0147)
MetaSprites92Set3AFrame10::
    db $e8, $c8, $11, $10 ; entry 0
    db $e8, $d0, $12, $10 ; entry 1
    db $e8, $d8, $13, $10 ; entry 2
    db $e8, $e0, $14, $10 ; entry 3
    db $e0, $d2, $10, $10 ; entry 4
    db $f0, $e0, $11, $70 ; entry 5
    db $f0, $d8, $12, $70 ; entry 6
    db $f0, $d0, $13, $70 ; entry 7
    db $f0, $c8, $14, $70 ; entry 8
    db $f8, $d6, $10, $70 ; entry 9
    db $d8, $bc, $07, $10 ; entry 10
    db $d8, $c4, $07, $30 ; entry 11
    db $e0, $bc, $07, $50 ; entry 12
    db $e0, $c4, $07, $70 ; entry 13
    db $f0, $ac, $05, $10 ; entry 14
    db $dc, $1c, $0e, $10 ; entry 15
    db $dc, $24, $0f, $10 ; entry 16
    db $d4, $1c, $0c, $10 ; entry 17
    db $d4, $24, $0d, $10 ; entry 18
    db $dc, $2c, $0e, $30 ; entry 19
    db $d4, $2c, $0c, $30 ; entry 20
    db $e4, $1c, $0c, $50 ; entry 21
    db $e4, $24, $0d, $50 ; entry 22
    db $e4, $2c, $0c, $70 ; entry 23
    db $e8, $34, $06, $10 ; entry 24
    db $e8, $3c, $06, $30 ; entry 25
    db $f0, $34, $06, $50 ; entry 26
    db $f0, $3c, $06, $70 ; entry 27
    db $d0, $c8, $0a, $10 ; entry 28
    db $d8, $c8, $0b, $10 ; entry 29
    db $d0, $cf, $0a, $30 ; entry 30
    db $d8, $cf, $0b, $30 ; entry 31
    db $f0, $28, $08, $10 ; entry 32
    db $f8, $28, $09, $10 ; entry 33
    db $f0, $2f, $08, $30 ; entry 34
    db $f8, $2f, $09, $30 ; entry 35
    db $80 ; end

; frame 11 of MetaSprites92Set3A; ends with $80 (E-0147)
MetaSprites92Set3AFrame11::
    db $dc, $b8, $0e, $10 ; entry 0
    db $dc, $c0, $0f, $10 ; entry 1
    db $d4, $b8, $0c, $10 ; entry 2
    db $d4, $c0, $0d, $10 ; entry 3
    db $dc, $c8, $0e, $30 ; entry 4
    db $d4, $c8, $0c, $30 ; entry 5
    db $e4, $b8, $0c, $50 ; entry 6
    db $e4, $c0, $0d, $50 ; entry 7
    db $e4, $c8, $0c, $70 ; entry 8
    db $ec, $b0, $06, $30 ; entry 9
    db $f4, $b0, $06, $70 ; entry 10
    db $e0, $18, $11, $50 ; entry 11
    db $e0, $20, $12, $50 ; entry 12
    db $e0, $28, $13, $50 ; entry 13
    db $e0, $30, $14, $50 ; entry 14
    db $e8, $22, $10, $50 ; entry 15
    db $d8, $30, $11, $30 ; entry 16
    db $d8, $28, $12, $30 ; entry 17
    db $d8, $20, $13, $30 ; entry 18
    db $d8, $18, $14, $30 ; entry 19
    db $d0, $26, $10, $30 ; entry 20
    db $e8, $34, $07, $10 ; entry 21
    db $e8, $3c, $07, $30 ; entry 22
    db $f0, $34, $07, $50 ; entry 23
    db $f0, $3c, $07, $70 ; entry 24
    db $d8, $4c, $05, $10 ; entry 25
    db $f4, $bc, $05, $10 ; entry 26
    db $f0, $28, $0a, $10 ; entry 27
    db $f8, $28, $0b, $10 ; entry 28
    db $f0, $2f, $0a, $30 ; entry 29
    db $f8, $2f, $0b, $30 ; entry 30
    db $80 ; end

; frame 12 of MetaSprites92Set3A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set3AFrame12::
    db $d8, $cc, $11, $30 ; entry 0
    db $d8, $c4, $12, $30 ; entry 1
    db $d8, $bc, $13, $30 ; entry 2
    db $d8, $b4, $14, $30 ; entry 3
    db $d0, $c2, $10, $30 ; entry 4
    db $e0, $b4, $11, $50 ; entry 5
    db $e0, $bc, $12, $50 ; entry 6
    db $e0, $c4, $13, $50 ; entry 7
    db $e0, $cc, $14, $50 ; entry 8
    db $e8, $be, $10, $50 ; entry 9
    db $ec, $b0, $07, $30 ; entry 10
    db $f4, $b0, $07, $70 ; entry 11
    db $ec, $30, $0e, $10 ; entry 12
    db $ec, $38, $0f, $10 ; entry 13
    db $e4, $30, $0c, $10 ; entry 14
    db $e4, $38, $0d, $10 ; entry 15
    db $ec, $40, $0e, $30 ; entry 16
    db $e4, $40, $0c, $30 ; entry 17
    db $f4, $30, $0c, $50 ; entry 18
    db $f4, $38, $0d, $50 ; entry 19
    db $f4, $40, $0c, $70 ; entry 20
    db $d4, $48, $06, $10 ; entry 21
    db $dc, $48, $06, $50 ; entry 22
    db $f0, $b8, $08, $10 ; entry 23
    db $f8, $b8, $09, $10 ; entry 24
    db $f0, $bf, $08, $30 ; entry 25
    db $f8, $bf, $09, $30 ; entry 26
    db $d4, $3c, $05, $10 ; entry 27
    db $80 ; end

; frame 13 of MetaSprites92Set3A; ends with $80 (E-0147)
MetaSprites92Set3AFrame13::
    db $f0, $ac, $0f, $10 ; entry 0
    db $e8, $ac, $0d, $10 ; entry 1
    db $f0, $b4, $0e, $30 ; entry 2
    db $e8, $b4, $0c, $30 ; entry 3
    db $f8, $ac, $0d, $50 ; entry 4
    db $f8, $b4, $0c, $70 ; entry 5
    db $f0, $2c, $11, $50 ; entry 6
    db $f0, $34, $12, $50 ; entry 7
    db $f0, $3c, $13, $50 ; entry 8
    db $f0, $44, $14, $50 ; entry 9
    db $f8, $36, $10, $50 ; entry 10
    db $e8, $44, $11, $30 ; entry 11
    db $e8, $3c, $12, $30 ; entry 12
    db $e8, $34, $13, $30 ; entry 13
    db $e8, $2c, $14, $30 ; entry 14
    db $e0, $3a, $10, $30 ; entry 15
    db $f0, $b8, $0a, $10 ; entry 16
    db $f8, $b8, $0b, $10 ; entry 17
    db $f0, $bf, $0a, $30 ; entry 18
    db $f8, $bf, $0b, $30 ; entry 19
    db $d4, $48, $07, $10 ; entry 20
    db $dc, $48, $07, $50 ; entry 21
    db $d0, $38, $08, $10 ; entry 22
    db $d8, $38, $09, $10 ; entry 23
    db $d0, $3f, $08, $30 ; entry 24
    db $d8, $3f, $09, $30 ; entry 25
    db $80 ; end

; frame 14 of MetaSprites92Set3A; ends with $80 (E-0147)
MetaSprites92Set3AFrame14::
    db $ec, $b0, $13, $10 ; entry 0
    db $ec, $b8, $14, $10 ; entry 1
    db $f4, $b8, $11, $70 ; entry 2
    db $f4, $b0, $12, $70 ; entry 3
    db $fc, $ae, $10, $70 ; entry 4
    db $d8, $4c, $0f, $30 ; entry 5
    db $d0, $4c, $0d, $30 ; entry 6
    db $d8, $44, $0e, $10 ; entry 7
    db $d0, $44, $0c, $10 ; entry 8
    db $e0, $4c, $0d, $70 ; entry 9
    db $e0, $44, $0c, $50 ; entry 10
    db $d0, $38, $0a, $10 ; entry 11
    db $d8, $38, $0b, $10 ; entry 12
    db $d0, $3f, $0a, $30 ; entry 13
    db $d8, $3f, $0b, $30 ; entry 14
    db $80 ; end

; frame 15 of MetaSprites92Set3A; ends with $80 (E-0147)
MetaSprites92Set3AFrame15::
    db $dc, $48, $13, $70 ; entry 0
    db $dc, $40, $14, $70 ; entry 1
    db $d4, $40, $11, $10 ; entry 2
    db $d4, $48, $12, $10 ; entry 3
    db $cc, $4a, $10, $10 ; entry 4
    db $80 ; end

; frame 16 of MetaSprites92Set3A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set3AFrame16::
    db $dc, $0c, $05, $10 ; entry 0
    db $80 ; end

; frame 17 of MetaSprites92Set3A; ends with $80 (E-0147)
MetaSprites92Set3AFrame17::
    db $e0, $10, $07, $70 ; entry 0
    db $e0, $08, $07, $50 ; entry 1
    db $d8, $08, $07, $10 ; entry 2
    db $d8, $10, $07, $30 ; entry 3
    db $f8, $e4, $22, $50 ; entry 4
    db $80 ; end

; frame 18 of MetaSprites92Set3A; ends with $80 (E-0147)
MetaSprites92Set3AFrame18::
    db $e8, $00, $17, $50 ; entry 0
    db $e8, $08, $18, $50 ; entry 1
    db $e8, $18, $17, $70 ; entry 2
    db $e8, $10, $18, $70 ; entry 3
    db $e0, $00, $19, $50 ; entry 4
    db $e0, $08, $1a, $50 ; entry 5
    db $e0, $18, $19, $70 ; entry 6
    db $e0, $10, $1a, $70 ; entry 7
    db $d0, $00, $17, $10 ; entry 8
    db $d0, $08, $18, $10 ; entry 9
    db $d0, $18, $17, $30 ; entry 10
    db $d0, $10, $18, $30 ; entry 11
    db $d8, $00, $19, $10 ; entry 12
    db $d8, $08, $1a, $10 ; entry 13
    db $d8, $18, $19, $30 ; entry 14
    db $d8, $10, $1a, $30 ; entry 15
    db $f8, $e0, $07, $10 ; entry 16
    db $f8, $e8, $07, $30 ; entry 17
    db $80 ; end

; frame 19 of MetaSprites92Set3A; ends with $80 (E-0147)
MetaSprites92Set3AFrame19::
    db $f0, $00, $1b, $50 ; entry 0
    db $f0, $08, $1c, $50 ; entry 1
    db $e8, $f8, $1d, $50 ; entry 2
    db $e8, $00, $1e, $50 ; entry 3
    db $e8, $08, $1f, $50 ; entry 4
    db $e0, $f8, $20, $50 ; entry 5
    db $e0, $00, $21, $50 ; entry 6
    db $e0, $08, $1a, $70 ; entry 7
    db $f0, $18, $1b, $70 ; entry 8
    db $f0, $10, $1c, $70 ; entry 9
    db $e8, $20, $1d, $70 ; entry 10
    db $e8, $18, $1e, $70 ; entry 11
    db $e8, $10, $1f, $70 ; entry 12
    db $e0, $20, $20, $70 ; entry 13
    db $e0, $18, $21, $70 ; entry 14
    db $e0, $10, $1a, $50 ; entry 15
    db $d0, $f8, $1d, $10 ; entry 16
    db $d0, $00, $1e, $10 ; entry 17
    db $d0, $08, $1f, $10 ; entry 18
    db $d8, $f8, $20, $10 ; entry 19
    db $d8, $00, $21, $10 ; entry 20
    db $d8, $08, $1a, $30 ; entry 21
    db $d0, $20, $1d, $30 ; entry 22
    db $d0, $18, $1e, $30 ; entry 23
    db $d0, $10, $1f, $30 ; entry 24
    db $d8, $20, $20, $30 ; entry 25
    db $d8, $18, $21, $30 ; entry 26
    db $d8, $10, $1a, $10 ; entry 27
    db $f0, $d8, $17, $10 ; entry 28
    db $f0, $e0, $18, $10 ; entry 29
    db $f0, $f0, $17, $30 ; entry 30
    db $f0, $e8, $18, $30 ; entry 31
    db $f8, $d8, $19, $10 ; entry 32
    db $f8, $e0, $1a, $10 ; entry 33
    db $f8, $f0, $19, $30 ; entry 34
    db $f8, $e8, $1a, $30 ; entry 35
    db $f4, $24, $05, $50 ; entry 36
    db $80 ; end

; frame 20 of MetaSprites92Set3A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set3AFrame20::
    db $e8, $d8, $1b, $10 ; entry 0
    db $e8, $e0, $1c, $10 ; entry 1
    db $f0, $d0, $1d, $10 ; entry 2
    db $f0, $d8, $1e, $10 ; entry 3
    db $f0, $e0, $1f, $10 ; entry 4
    db $f8, $d0, $20, $10 ; entry 5
    db $f8, $d8, $21, $10 ; entry 6
    db $f8, $e0, $1a, $30 ; entry 7
    db $e8, $f0, $1b, $30 ; entry 8
    db $e8, $e8, $1c, $30 ; entry 9
    db $f0, $f8, $1d, $30 ; entry 10
    db $f0, $f0, $1e, $30 ; entry 11
    db $f0, $e8, $1f, $30 ; entry 12
    db $f8, $f8, $20, $30 ; entry 13
    db $f8, $f0, $21, $30 ; entry 14
    db $f8, $e8, $1a, $10 ; entry 15
    db $f8, $20, $07, $50 ; entry 16
    db $f8, $28, $07, $70 ; entry 17
    db $f0, $20, $07, $10 ; entry 18
    db $f0, $28, $07, $30 ; entry 19
    db $dc, $d4, $05, $50 ; entry 20
    db $80 ; end

; frame 21 of MetaSprites92Set3A; ends with $80 (E-0147)
MetaSprites92Set3AFrame21::
    db $e8, $18, $17, $10 ; entry 0
    db $e8, $20, $18, $10 ; entry 1
    db $f0, $18, $19, $10 ; entry 2
    db $f0, $20, $1a, $10 ; entry 3
    db $e8, $30, $17, $30 ; entry 4
    db $e8, $28, $18, $30 ; entry 5
    db $f0, $30, $19, $30 ; entry 6
    db $f0, $28, $1a, $30 ; entry 7
    db $f8, $18, $19, $50 ; entry 8
    db $f8, $20, $1a, $50 ; entry 9
    db $f8, $30, $19, $70 ; entry 10
    db $f8, $28, $1a, $70 ; entry 11
    db $e0, $d0, $07, $50 ; entry 12
    db $e0, $d8, $07, $70 ; entry 13
    db $d8, $d0, $07, $10 ; entry 14
    db $d8, $d8, $07, $30 ; entry 15
    db $80 ; end

; frame 22 of MetaSprites92Set3A; ends with $80 (E-0147)
MetaSprites92Set3AFrame22::
    db $e0, $18, $1b, $10 ; entry 0
    db $e0, $20, $1c, $10 ; entry 1
    db $e8, $10, $1d, $10 ; entry 2
    db $e8, $18, $1e, $10 ; entry 3
    db $e8, $20, $1f, $10 ; entry 4
    db $f0, $10, $20, $10 ; entry 5
    db $f0, $18, $21, $10 ; entry 6
    db $f0, $20, $04, $10 ; entry 7
    db $f8, $10, $20, $50 ; entry 8
    db $f8, $18, $21, $50 ; entry 9
    db $f8, $20, $04, $50 ; entry 10
    db $e8, $38, $1d, $30 ; entry 11
    db $e8, $30, $1e, $30 ; entry 12
    db $e8, $28, $1f, $30 ; entry 13
    db $f0, $38, $20, $30 ; entry 14
    db $f0, $30, $21, $30 ; entry 15
    db $f0, $28, $04, $30 ; entry 16
    db $f8, $38, $20, $70 ; entry 17
    db $f8, $30, $21, $70 ; entry 18
    db $f8, $28, $04, $70 ; entry 19
    db $e0, $30, $1b, $30 ; entry 20
    db $e0, $28, $1c, $30 ; entry 21
    db $e8, $c8, $17, $50 ; entry 22
    db $e8, $d0, $18, $50 ; entry 23
    db $e0, $c8, $19, $50 ; entry 24
    db $e0, $d0, $1a, $50 ; entry 25
    db $e8, $e0, $17, $70 ; entry 26
    db $e8, $d8, $18, $70 ; entry 27
    db $e0, $e0, $19, $70 ; entry 28
    db $e0, $d8, $1a, $70 ; entry 29
    db $d8, $c8, $19, $10 ; entry 30
    db $d8, $d0, $1a, $10 ; entry 31
    db $d8, $e0, $19, $30 ; entry 32
    db $d8, $d8, $1a, $30 ; entry 33
    db $d0, $c8, $17, $10 ; entry 34
    db $d0, $d0, $18, $10 ; entry 35
    db $d0, $e0, $17, $30 ; entry 36
    db $d0, $d8, $18, $30 ; entry 37
    db $d4, $3c, $05, $10 ; entry 38
    db $80 ; end

; frame 23 of MetaSprites92Set3A; ends with $80 (E-0147)
MetaSprites92Set3AFrame23::
    db $f0, $c8, $1b, $50 ; entry 0
    db $f0, $d0, $1c, $50 ; entry 1
    db $e8, $c0, $1d, $50 ; entry 2
    db $e8, $c8, $1e, $50 ; entry 3
    db $e8, $d0, $1f, $50 ; entry 4
    db $e0, $c0, $20, $50 ; entry 5
    db $e0, $c8, $21, $50 ; entry 6
    db $e0, $d0, $04, $50 ; entry 7
    db $d8, $c0, $20, $10 ; entry 8
    db $d8, $c8, $21, $10 ; entry 9
    db $d8, $d0, $04, $10 ; entry 10
    db $e8, $e8, $1d, $70 ; entry 11
    db $e8, $e0, $1e, $70 ; entry 12
    db $e8, $d8, $1f, $70 ; entry 13
    db $e0, $e8, $20, $70 ; entry 14
    db $e0, $e0, $21, $70 ; entry 15
    db $e0, $d8, $04, $70 ; entry 16
    db $d8, $e8, $20, $30 ; entry 17
    db $d8, $e0, $21, $30 ; entry 18
    db $d8, $d8, $04, $30 ; entry 19
    db $f0, $e0, $1b, $70 ; entry 20
    db $f0, $d8, $1c, $70 ; entry 21
    db $d0, $c0, $1d, $10 ; entry 22
    db $d0, $c8, $1e, $10 ; entry 23
    db $d0, $d0, $1f, $10 ; entry 24
    db $d0, $e8, $1d, $30 ; entry 25
    db $d0, $e0, $1e, $30 ; entry 26
    db $d0, $d8, $1f, $30 ; entry 27
    db $d0, $38, $07, $10 ; entry 28
    db $d0, $40, $07, $30 ; entry 29
    db $d8, $38, $07, $50 ; entry 30
    db $d8, $40, $07, $70 ; entry 31
    db $ec, $bc, $05, $10 ; entry 32
    db $80 ; end

; frame 24 of MetaSprites92Set3A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set3AFrame24::
    db $e0, $30, $17, $50 ; entry 0
    db $e0, $38, $18, $50 ; entry 1
    db $d8, $30, $19, $50 ; entry 2
    db $d8, $38, $1a, $50 ; entry 3
    db $d0, $30, $19, $10 ; entry 4
    db $d0, $38, $1a, $10 ; entry 5
    db $e0, $48, $17, $70 ; entry 6
    db $e0, $40, $18, $70 ; entry 7
    db $d8, $48, $19, $70 ; entry 8
    db $d8, $40, $1a, $70 ; entry 9
    db $d0, $48, $19, $30 ; entry 10
    db $d0, $40, $1a, $30 ; entry 11
    db $f0, $b8, $07, $50 ; entry 12
    db $f0, $c0, $07, $70 ; entry 13
    db $e8, $b8, $07, $10 ; entry 14
    db $e8, $c0, $07, $30 ; entry 15
    db $80 ; end

; frame 25 of MetaSprites92Set3A; ends with $80 (E-0147)
MetaSprites92Set3AFrame25::
    db $d8, $38, $1a, $10 ; entry 0
    db $d0, $38, $1a, $10 ; entry 1
    db $e8, $30, $1b, $50 ; entry 2
    db $e8, $38, $1c, $50 ; entry 3
    db $e8, $48, $1b, $70 ; entry 4
    db $e8, $40, $1c, $70 ; entry 5
    db $e0, $28, $1d, $50 ; entry 6
    db $e0, $30, $1e, $50 ; entry 7
    db $e0, $38, $1f, $50 ; entry 8
    db $d8, $28, $20, $50 ; entry 9
    db $d8, $30, $21, $50 ; entry 10
    db $d0, $28, $20, $10 ; entry 11
    db $d0, $30, $21, $10 ; entry 12
    db $d8, $40, $1a, $30 ; entry 13
    db $d0, $40, $1a, $30 ; entry 14
    db $e0, $48, $1e, $70 ; entry 15
    db $e0, $40, $1f, $70 ; entry 16
    db $d8, $48, $21, $70 ; entry 17
    db $d0, $48, $21, $30 ; entry 18
    db $f8, $c8, $17, $70 ; entry 19
    db $f8, $c0, $18, $70 ; entry 20
    db $f0, $c8, $19, $70 ; entry 21
    db $f0, $c0, $1a, $70 ; entry 22
    db $f8, $b0, $17, $50 ; entry 23
    db $f8, $b8, $18, $50 ; entry 24
    db $f0, $b0, $19, $50 ; entry 25
    db $f0, $b8, $1a, $50 ; entry 26
    db $e0, $c8, $17, $30 ; entry 27
    db $e0, $c0, $18, $30 ; entry 28
    db $e8, $c8, $19, $30 ; entry 29
    db $e8, $c0, $1a, $30 ; entry 30
    db $e0, $b0, $17, $10 ; entry 31
    db $e0, $b8, $18, $10 ; entry 32
    db $e8, $b0, $19, $10 ; entry 33
    db $e8, $b8, $1a, $10 ; entry 34
    db $80 ; end

; frame 26 of MetaSprites92Set3A; ends with $80 (E-0147)
MetaSprites92Set3AFrame26::
    db $e8, $c0, $1a, $70 ; entry 0
    db $d8, $c8, $1b, $30 ; entry 1
    db $d8, $c0, $1c, $30 ; entry 2
    db $d8, $b0, $1b, $10 ; entry 3
    db $d8, $b8, $1c, $10 ; entry 4
    db $e0, $d0, $1d, $30 ; entry 5
    db $e0, $c8, $1e, $30 ; entry 6
    db $e0, $c0, $1f, $30 ; entry 7
    db $e8, $d0, $20, $30 ; entry 8
    db $e8, $c8, $21, $30 ; entry 9
    db $e8, $b8, $1a, $50 ; entry 10
    db $e0, $b0, $1e, $10 ; entry 11
    db $e0, $b8, $1f, $10 ; entry 12
    db $e8, $b0, $21, $10 ; entry 13
    db $f0, $c0, $1a, $30 ; entry 14
    db $f0, $d0, $20, $70 ; entry 15
    db $f0, $c8, $21, $70 ; entry 16
    db $f0, $b8, $1a, $10 ; entry 17
    db $f0, $b0, $21, $50 ; entry 18
    db $f8, $d0, $1d, $70 ; entry 19
    db $f8, $c8, $1e, $70 ; entry 20
    db $f8, $c0, $1f, $70 ; entry 21
    db $f8, $b0, $1e, $50 ; entry 22
    db $f8, $b8, $1f, $50 ; entry 23
    db $80 ; end

; frame 27 of MetaSprites92Set3A; ends with $80 (E-0147)
MetaSprites92Set3AFrame27::
    db $80 ; end

; meta-sprite set 59 of MetaSprites92Table: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites92Set3B::
    dw MetaSprites92Set3BFrame0 ; entry 0
    dw MetaSprites92Set3BFrame1 ; entry 1
    dw MetaSprites92Set3BFrame2 ; entry 2
    dw MetaSprites92Set3BFrame3 ; entry 3
    dw MetaSprites92Set3BFrame4 ; entry 4
    dw MetaSprites92Set3BFrame5 ; entry 5
    dw MetaSprites92Set3BFrame6 ; entry 6
    dw MetaSprites92Set3BFrame7 ; entry 7
    dw MetaSprites92Set3BFrame8 ; entry 8
    dw MetaSprites92Set3BFrame9 ; entry 9
    dw MetaSprites92Set3BFrame10 ; entry 10
    dw MetaSprites92Set3BFrame11 ; entry 11
    dw MetaSprites92Set3BFrame12 ; entry 12
    dw MetaSprites92Set3BFrame12 ; entry 13
    dw MetaSprites92Set3BFrame12 ; entry 14
    dw MetaSprites92Set3BFrame12 ; entry 15
    dw MetaSprites92Set3BFrame12 ; entry 16
    dw MetaSprites92Set3BFrame12 ; entry 17
    dw MetaSprites92Set3BFrame12 ; entry 18
    dw MetaSprites92Set3BFrame12 ; entry 19
    dw MetaSprites92Set3BFrame12 ; entry 20
    dw MetaSprites92Set3BFrame12 ; entry 21
    dw MetaSprites92Set3BFrame12 ; entry 22
    dw MetaSprites92Set3BFrame12 ; entry 23
    dw MetaSprites92Set3BFrame12 ; entry 24
    dw MetaSprites92Set3BFrame12 ; entry 25
    dw MetaSprites92Set3BFrame12 ; entry 26
    dw MetaSprites92Set3BFrame12 ; entry 27
    dw MetaSprites92Set3BFrame12 ; entry 28
    dw MetaSprites92Set3BFrame12 ; entry 29
    dw MetaSprites92Set3BFrame12 ; entry 30
    dw MetaSprites92Set3BFrame12 ; entry 31

; frame 0 of MetaSprites92Set3B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set3BFrame0::
    db $e2, $b8, $00, $20 ; entry 0
    db $e0, $b0, $01, $20 ; entry 1
    db $e8, $b0, $02, $20 ; entry 2
    db $e3, $c0, $10, $20 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites92Set3B; ends with $80 (E-0147)
MetaSprites92Set3BFrame1::
    db $e0, $b8, $02, $60 ; entry 0
    db $e0, $b0, $03, $60 ; entry 1
    db $e8, $d4, $08, $40 ; entry 2
    db $e8, $cc, $07, $40 ; entry 3
    db $e8, $bc, $02, $00 ; entry 4
    db $e9, $c4, $07, $60 ; entry 5
    db $e0, $d4, $09, $40 ; entry 6
    db $e2, $dc, $20, $40 ; entry 7
    db $80 ; end

; frame 2 of MetaSprites92Set3B; ends with $80 (E-0147)
MetaSprites92Set3BFrame2::
    db $e0, $b0, $14, $00 ; entry 0
    db $e0, $b8, $15, $00 ; entry 1
    db $e0, $c0, $16, $00 ; entry 2
    db $e8, $b8, $17, $00 ; entry 3
    db $e8, $c0, $18, $00 ; entry 4
    db $f0, $b8, $19, $00 ; entry 5
    db $f0, $c0, $1a, $00 ; entry 6
    db $f0, $c8, $1b, $00 ; entry 7
    db $f0, $d0, $1c, $00 ; entry 8
    db $f8, $b8, $1d, $00 ; entry 9
    db $f8, $c0, $1e, $00 ; entry 10
    db $f8, $c8, $1f, $00 ; entry 11
    db $ef, $d8, $07, $40 ; entry 12
    db $e7, $e0, $09, $40 ; entry 13
    db $ef, $e0, $08, $40 ; entry 14
    db $e9, $e8, $05, $00 ; entry 15
    db $e5, $f0, $20, $00 ; entry 16
    db $80 ; end

; frame 3 of MetaSprites92Set3B; ends with $80 (E-0147)
MetaSprites92Set3BFrame3::
    db $e4, $f0, $04, $60 ; entry 0
    db $e2, $f8, $03, $60 ; entry 1
    db $e2, $00, $02, $60 ; entry 2
    db $e7, $08, $20, $40 ; entry 3
    db $e1, $e8, $00, $20 ; entry 4
    db $e3, $e0, $01, $60 ; entry 5
    db $db, $e0, $02, $60 ; entry 6
    db $de, $d8, $1b, $00 ; entry 7
    db $e6, $d0, $1e, $00 ; entry 8
    db $e6, $d8, $1f, $00 ; entry 9
    db $e3, $c8, $07, $00 ; entry 10
    db $e4, $c0, $20, $60 ; entry 11
    db $80 ; end

; frame 4 of MetaSprites92Set3B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set3BFrame4::
    db $e2, $f2, $00, $00 ; entry 0
    db $e0, $fa, $01, $00 ; entry 1
    db $e8, $fa, $02, $00 ; entry 2
    db $e7, $02, $15, $40 ; entry 3
    db $e7, $0a, $16, $40 ; entry 4
    db $df, $08, $1d, $40 ; entry 5
    db $df, $10, $1e, $40 ; entry 6
    db $df, $18, $1f, $40 ; entry 7
    db $e7, $17, $1d, $00 ; entry 8
    db $e8, $1f, $20, $40 ; entry 9
    db $e1, $eb, $13, $40 ; entry 10
    db $e1, $e3, $20, $60 ; entry 11
    db $80 ; end

; frame 5 of MetaSprites92Set3B; ends with $80 (E-0147)
MetaSprites92Set3BFrame5::
    db $e3, $28, $19, $20 ; entry 0
    db $e3, $18, $1b, $20 ; entry 1
    db $eb, $18, $1f, $20 ; entry 2
    db $eb, $28, $1d, $20 ; entry 3
    db $eb, $20, $1e, $20 ; entry 4
    db $db, $29, $09, $40 ; entry 5
    db $de, $31, $20, $40 ; entry 6
    db $e7, $09, $13, $00 ; entry 7
    db $e3, $10, $1c, $20 ; entry 8
    db $e6, $01, $11, $00 ; entry 9
    db $e6, $f9, $20, $20 ; entry 10
    db $80 ; end

; frame 6 of MetaSprites92Set3B; ends with $80 (E-0147)
MetaSprites92Set3BFrame6::
    db $da, $31, $01, $00 ; entry 0
    db $e2, $31, $02, $00 ; entry 1
    db $de, $29, $16, $20 ; entry 2
    db $e6, $29, $09, $20 ; entry 3
    db $e4, $21, $07, $20 ; entry 4
    db $e8, $19, $12, $40 ; entry 5
    db $e3, $0b, $10, $40 ; entry 6
    db $e5, $11, $13, $20 ; entry 7
    db $e0, $41, $0d, $20 ; entry 8
    db $e0, $39, $0e, $20 ; entry 9
    db $e3, $49, $1e, $00 ; entry 10
    db $e4, $fc, $0f, $00 ; entry 11
    db $80 ; end

; frame 7 of MetaSprites92Set3B; ends with $80 (E-0147)
MetaSprites92Set3BFrame7::
    db $e2, $48, $0c, $00 ; entry 0
    db $e4, $40, $04, $40 ; entry 1
    db $e4, $38, $02, $00 ; entry 2
    db $dc, $38, $08, $00 ; entry 3
    db $dc, $30, $07, $00 ; entry 4
    db $dd, $28, $1b, $00 ; entry 5
    db $e5, $22, $17, $00 ; entry 6
    db $e5, $2a, $18, $00 ; entry 7
    db $eb, $1c, $00, $40 ; entry 8
    db $ed, $24, $01, $40 ; entry 9
    db $e7, $14, $20, $20 ; entry 10
    db $e0, $f8, $21, $00 ; entry 11
    db $e7, $f8, $21, $40 ; entry 12
    db $e0, $ff, $21, $20 ; entry 13
    db $e7, $ff, $21, $60 ; entry 14
    db $80 ; end

; frame 8 of MetaSprites92Set3B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set3BFrame8::
    db $e4, $48, $05, $40 ; entry 0
    db $e7, $40, $0c, $60 ; entry 1
    db $e6, $38, $02, $40 ; entry 2
    db $ee, $34, $09, $20 ; entry 3
    db $ec, $2c, $13, $20 ; entry 4
    db $e5, $27, $1a, $40 ; entry 5
    db $d8, $f8, $22, $00 ; entry 6
    db $d8, $ff, $22, $20 ; entry 7
    db $e0, $f0, $23, $00 ; entry 8
    db $e0, $f8, $24, $00 ; entry 9
    db $e0, $07, $23, $20 ; entry 10
    db $e0, $ff, $24, $20 ; entry 11
    db $e8, $f0, $25, $00 ; entry 12
    db $e8, $f8, $26, $00 ; entry 13
    db $e8, $07, $25, $20 ; entry 14
    db $e8, $ff, $26, $20 ; entry 15
    db $f0, $f8, $27, $00 ; entry 16
    db $f0, $ff, $27, $20 ; entry 17
    db $80 ; end

; frame 9 of MetaSprites92Set3B; ends with $80 (E-0147)
MetaSprites92Set3BFrame9::
    db $e1, $48, $12, $00 ; entry 0
    db $e5, $40, $20, $60 ; entry 1
    db $d8, $f0, $28, $00 ; entry 2
    db $d8, $f8, $29, $00 ; entry 3
    db $d8, $07, $28, $20 ; entry 4
    db $d8, $ff, $29, $20 ; entry 5
    db $e0, $f0, $2a, $00 ; entry 6
    db $e0, $f8, $2b, $00 ; entry 7
    db $e0, $07, $2a, $20 ; entry 8
    db $e0, $ff, $2b, $20 ; entry 9
    db $e8, $f0, $2c, $00 ; entry 10
    db $e8, $f8, $2d, $00 ; entry 11
    db $e8, $07, $2c, $20 ; entry 12
    db $e8, $ff, $2d, $20 ; entry 13
    db $f0, $f0, $2e, $00 ; entry 14
    db $f0, $f8, $2f, $00 ; entry 15
    db $f0, $07, $2e, $20 ; entry 16
    db $f0, $ff, $2f, $20 ; entry 17
    db $80 ; end

; frame 10 of MetaSprites92Set3B; ends with $80 (E-0147)
MetaSprites92Set3BFrame10::
    db $e0, $f8, $21, $00 ; entry 0
    db $e7, $f8, $21, $40 ; entry 1
    db $e0, $ff, $21, $20 ; entry 2
    db $e7, $ff, $21, $60 ; entry 3
    db $80 ; end

; frame 11 of MetaSprites92Set3B; ends with $80 (E-0147)
MetaSprites92Set3BFrame11::
    db $e4, $fc, $0f, $00 ; entry 0
    db $80 ; end

; frame 12 of MetaSprites92Set3B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites92Set3BFrame12::
    db $80 ; end
    ds $4cf, $00
