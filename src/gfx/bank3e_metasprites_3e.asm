; ROM bank $3E: meta-sprite frames
; The annotated listing of this bank is build/listing/bank3e.asm.

SECTION "Bank 3E", ROMX[$4000], BANK[$3E]
    db $3e

; sets the sprite origin X = wEffectSpriteX, Y = $68, tile offset = wEffectTileOffset, attribute XOR
; = wEffectSpriteAttrXor, then builds OAM from the local sprite table (E-0121)
DrawEffectSpriteAtEffectSpriteX_Bank3E::
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
    ld de, MetaSprites3ETable
    call BuildOamFromSpriteTable_Bank3E
    ret

; the caller of BuildOamFromSpriteTable_Bank3E passes DE = $MetaSprites3ETable; the builder takes
; the word at DE + 2 * hSpriteSetIndex as the set and the word at set + 2 * hSpriteSubIndex as the
; frame; 14 words, up to the next code or data (E-0147, C1)
; record: meta-sprite set
MetaSprites3ETable::
    dw MetaSprites3ESet00 ; id 0
    dw MetaSprites3ESet01 ; id 1
    dw MetaSprites3ESet02 ; id 2
    dw MetaSprites3ESet03 ; id 3
    dw MetaSprites3ESet04 ; id 4
    dw MetaSprites3ESet05 ; id 5
    dw MetaSprites3ESet06 ; id 6
    dw MetaSprites3ESet07 ; id 7
    dw MetaSprites3ESet08 ; id 8
    dw MetaSprites3ESet09 ; id 9
    dw MetaSprites3ESet0A ; id 10
    dw MetaSprites3ESet0B ; id 11
    dw MetaSprites3ESet0C ; id 12
    dw MetaSprites3ESet0D ; id 13

; DE = two-level table; entries are chosen by hSpriteSetIndex and hSpriteSubIndex; writes 4-byte OAM
; entries at $C000 + 4 * hOamNextEntry (Y = hSpriteOriginY + b + $10, X = hSpriteOriginX + b + 8,
; tile += hSpriteTileOffset, flags ^= hSpriteAttrXor) until a $80 byte or hOamNextEntry reaches $28
; (40 entries) (the same 81 bytes appear in 5 banks)
BuildOamFromSpriteTable_Bank3E::
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

; meta-sprite set 0 of MetaSprites3ETable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3ESet00::
    dw MetaSprites3ESet00Frame0 ; entry 0
    dw MetaSprites3ESet00Frame1 ; entry 1
    dw MetaSprites3ESet00Frame2 ; entry 2
    dw MetaSprites3ESet00Frame3 ; entry 3
    dw MetaSprites3ESet00Frame4 ; entry 4
    dw MetaSprites3ESet00Frame5 ; entry 5
    dw MetaSprites3ESet00Frame6 ; entry 6
    dw MetaSprites3ESet00Frame7 ; entry 7
    dw MetaSprites3ESet00Frame8 ; entry 8
    dw MetaSprites3ESet00Frame8 ; entry 9
    dw MetaSprites3ESet00Frame8 ; entry 10
    dw MetaSprites3ESet00Frame8 ; entry 11
    dw MetaSprites3ESet00Frame8 ; entry 12
    dw MetaSprites3ESet00Frame8 ; entry 13
    dw MetaSprites3ESet00Frame8 ; entry 14
    dw MetaSprites3ESet00Frame8 ; entry 15
    dw MetaSprites3ESet00Frame8 ; entry 16
    dw MetaSprites3ESet00Frame8 ; entry 17
    dw MetaSprites3ESet00Frame8 ; entry 18
    dw MetaSprites3ESet00Frame8 ; entry 19
    dw MetaSprites3ESet00Frame8 ; entry 20
    dw MetaSprites3ESet00Frame8 ; entry 21
    dw MetaSprites3ESet00Frame8 ; entry 22
    dw MetaSprites3ESet00Frame8 ; entry 23
    dw MetaSprites3ESet00Frame8 ; entry 24
    dw MetaSprites3ESet00Frame8 ; entry 25
    dw MetaSprites3ESet00Frame8 ; entry 26
    dw MetaSprites3ESet00Frame8 ; entry 27
    dw MetaSprites3ESet00Frame8 ; entry 28
    dw MetaSprites3ESet00Frame8 ; entry 29
    dw MetaSprites3ESet00Frame8 ; entry 30
    dw MetaSprites3ESet00Frame8 ; entry 31

; frame 0 of MetaSprites3ESet00; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet00Frame0::
    db $f8, $f8, $00, $00 ; entry 0
    db $f8, $00, $01, $00 ; entry 1
    db $80 ; end

; frame 1 of MetaSprites3ESet00; ends with $80 (E-0147)
MetaSprites3ESet00Frame1::
    db $f0, $00, $00, $20 ; entry 0
    db $f0, $f8, $01, $20 ; entry 1
    db $f8, $08, $02, $20 ; entry 2
    db $f8, $00, $03, $20 ; entry 3
    db $f8, $f8, $04, $20 ; entry 4
    db $f8, $f0, $05, $20 ; entry 5
    db $80 ; end

; frame 2 of MetaSprites3ESet00; ends with $80 (E-0147)
MetaSprites3ESet00Frame2::
    db $f8, $fc, $06, $00 ; entry 0
    db $e8, $f8, $00, $00 ; entry 1
    db $e8, $00, $01, $00 ; entry 2
    db $f0, $f0, $02, $00 ; entry 3
    db $f0, $f8, $03, $00 ; entry 4
    db $f0, $00, $04, $00 ; entry 5
    db $f0, $08, $05, $00 ; entry 6
    db $80 ; end

; frame 3 of MetaSprites3ESet00; ends with $80 (E-0147)
MetaSprites3ESet00Frame3::
    db $de, $f8, $07, $00 ; entry 0
    db $e6, $f0, $08, $00 ; entry 1
    db $e6, $f8, $09, $00 ; entry 2
    db $e6, $00, $0a, $00 ; entry 3
    db $e6, $08, $0b, $00 ; entry 4
    db $ee, $f8, $0c, $00 ; entry 5
    db $ee, $00, $0d, $00 ; entry 6
    db $ee, $08, $0e, $00 ; entry 7
    db $f6, $00, $0f, $00 ; entry 8
    db $80 ; end

; frame 4 of MetaSprites3ESet00; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet00Frame4::
    db $f3, $01, $07, $60 ; entry 0
    db $eb, $09, $08, $60 ; entry 1
    db $eb, $01, $09, $60 ; entry 2
    db $eb, $f9, $0a, $60 ; entry 3
    db $eb, $f1, $0b, $60 ; entry 4
    db $e3, $01, $0c, $60 ; entry 5
    db $e3, $f9, $0d, $60 ; entry 6
    db $e3, $f1, $0e, $60 ; entry 7
    db $db, $f9, $0f, $60 ; entry 8
    db $80 ; end

; frame 5 of MetaSprites3ESet00; ends with $80 (E-0147)
MetaSprites3ESet00Frame5::
    db $ee, $f8, $14, $00 ; entry 0
    db $ee, $00, $15, $00 ; entry 1
    db $e6, $f8, $11, $00 ; entry 2
    db $e6, $00, $12, $00 ; entry 3
    db $e6, $08, $13, $00 ; entry 4
    db $de, $00, $10, $00 ; entry 5
    db $80 ; end

; frame 6 of MetaSprites3ESet00; ends with $80 (E-0147)
MetaSprites3ESet00Frame6::
    db $e7, $01, $14, $60 ; entry 0
    db $e7, $f9, $15, $60 ; entry 1
    db $ef, $01, $11, $60 ; entry 2
    db $ef, $f9, $12, $60 ; entry 3
    db $ef, $f1, $13, $60 ; entry 4
    db $f7, $f9, $10, $60 ; entry 5
    db $80 ; end

; frame 7 of MetaSprites3ESet00; ends with $80 (E-0147)
MetaSprites3ESet00Frame7::
    db $e8, $f7, $16, $00 ; entry 0
    db $e8, $ff, $17, $00 ; entry 1
    db $f0, $f7, $18, $00 ; entry 2
    db $f0, $ff, $19, $00 ; entry 3
    db $80 ; end

; frame 8 of MetaSprites3ESet00; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet00Frame8::
    db $80 ; end

; meta-sprite set 1 of MetaSprites3ETable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3ESet01::
    dw MetaSprites3ESet01Frame0 ; entry 0
    dw MetaSprites3ESet01Frame1 ; entry 1
    dw MetaSprites3ESet01Frame2 ; entry 2
    dw MetaSprites3ESet01Frame3 ; entry 3
    dw MetaSprites3ESet01Frame4 ; entry 4
    dw MetaSprites3ESet01Frame5 ; entry 5
    dw MetaSprites3ESet01Frame6 ; entry 6
    dw MetaSprites3ESet01Frame7 ; entry 7
    dw MetaSprites3ESet01Frame8 ; entry 8
    dw MetaSprites3ESet01Frame9 ; entry 9
    dw MetaSprites3ESet01Frame10 ; entry 10
    dw MetaSprites3ESet01Frame11 ; entry 11
    dw MetaSprites3ESet01Frame12 ; entry 12
    dw MetaSprites3ESet01Frame13 ; entry 13
    dw MetaSprites3ESet01Frame14 ; entry 14
    dw MetaSprites3ESet01Frame15 ; entry 15
    dw MetaSprites3ESet01Frame15 ; entry 16
    dw MetaSprites3ESet01Frame15 ; entry 17
    dw MetaSprites3ESet01Frame15 ; entry 18
    dw MetaSprites3ESet01Frame15 ; entry 19
    dw MetaSprites3ESet01Frame15 ; entry 20
    dw MetaSprites3ESet01Frame15 ; entry 21
    dw MetaSprites3ESet01Frame15 ; entry 22
    dw MetaSprites3ESet01Frame15 ; entry 23
    dw MetaSprites3ESet01Frame15 ; entry 24
    dw MetaSprites3ESet01Frame15 ; entry 25
    dw MetaSprites3ESet01Frame15 ; entry 26
    dw MetaSprites3ESet01Frame15 ; entry 27
    dw MetaSprites3ESet01Frame15 ; entry 28
    dw MetaSprites3ESet01Frame15 ; entry 29
    dw MetaSprites3ESet01Frame15 ; entry 30
    dw MetaSprites3ESet01Frame15 ; entry 31

; frame 0 of MetaSprites3ESet01; ends with $80 (E-0147)
MetaSprites3ESet01Frame0::
    db $f8, $f8, $00, $00 ; entry 0
    db $f8, $00, $01, $00 ; entry 1
    db $80 ; end

; frame 1 of MetaSprites3ESet01; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet01Frame1::
    db $f8, $fb, $03, $20 ; entry 0
    db $f0, $00, $00, $20 ; entry 1
    db $f8, $f3, $0d, $20 ; entry 2
    db $f8, $03, $05, $20 ; entry 3
    db $f0, $f8, $04, $20 ; entry 4
    db $80 ; end

; frame 2 of MetaSprites3ESet01; ends with $80 (E-0147)
MetaSprites3ESet01Frame2::
    db $f0, $f6, $02, $00 ; entry 0
    db $e8, $f9, $00, $00 ; entry 1
    db $f8, $f0, $05, $00 ; entry 2
    db $f8, $08, $05, $20 ; entry 3
    db $f0, $03, $02, $20 ; entry 4
    db $f0, $fe, $03, $00 ; entry 5
    db $e8, $ff, $04, $00 ; entry 6
    db $f8, $f8, $18, $00 ; entry 7
    db $f8, $00, $18, $20 ; entry 8
    db $80 ; end

; frame 3 of MetaSprites3ESet01; ends with $80 (E-0147)
MetaSprites3ESet01Frame3::
    db $f0, $f5, $06, $00 ; entry 0
    db $f0, $05, $08, $00 ; entry 1
    db $e8, $f3, $02, $00 ; entry 2
    db $e8, $03, $04, $00 ; entry 3
    db $e0, $fc, $04, $00 ; entry 4
    db $e0, $f9, $02, $00 ; entry 5
    db $e8, $fb, $07, $00 ; entry 6
    db $f0, $fd, $0b, $00 ; entry 7
    db $f0, $ef, $09, $00 ; entry 8
    db $f8, $00, $0f, $60 ; entry 9
    db $f8, $f8, $18, $40 ; entry 10
    db $f8, $08, $12, $00 ; entry 11
    db $f8, $f0, $17, $20 ; entry 12
    db $80 ; end

; frame 4 of MetaSprites3ESet01; ends with $80 (E-0147)
MetaSprites3ESet01Frame4::
    db $e8, $03, $06, $20 ; entry 0
    db $e8, $f3, $08, $20 ; entry 1
    db $e0, $05, $02, $20 ; entry 2
    db $e0, $f5, $04, $20 ; entry 3
    db $d8, $fc, $04, $20 ; entry 4
    db $d8, $ff, $02, $20 ; entry 5
    db $e0, $fd, $07, $20 ; entry 6
    db $e8, $fb, $0b, $20 ; entry 7
    db $e8, $09, $09, $20 ; entry 8
    db $f0, $f8, $0f, $40 ; entry 9
    db $f0, $f0, $12, $20 ; entry 10
    db $f0, $08, $17, $00 ; entry 11
    db $f0, $00, $18, $20 ; entry 12
    db $f8, $f8, $23, $00 ; entry 13
    db $f8, $00, $23, $20 ; entry 14
    db $80 ; end

; frame 5 of MetaSprites3ESet01; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet01Frame5::
    db $d4, $fc, $1b, $20 ; entry 0
    db $dc, $04, $1c, $20 ; entry 1
    db $dc, $fc, $1d, $20 ; entry 2
    db $dc, $f4, $1e, $20 ; entry 3
    db $e4, $04, $1f, $20 ; entry 4
    db $e4, $fc, $20, $20 ; entry 5
    db $e4, $f4, $21, $20 ; entry 6
    db $ec, $fc, $22, $20 ; entry 7
    db $80 ; end

; frame 6 of MetaSprites3ESet01; ends with $80 (E-0147)
MetaSprites3ESet01Frame6::
    db $d8, $fc, $1b, $00 ; entry 0
    db $e0, $f4, $1c, $00 ; entry 1
    db $e0, $fc, $1d, $00 ; entry 2
    db $e0, $04, $1e, $00 ; entry 3
    db $e8, $f4, $1f, $00 ; entry 4
    db $e8, $fc, $20, $00 ; entry 5
    db $e8, $04, $21, $00 ; entry 6
    db $f0, $fc, $22, $00 ; entry 7
    db $80 ; end

; frame 7 of MetaSprites3ESet01; ends with $80 (E-0147)
MetaSprites3ESet01Frame7::
    db $e8, $fc, $25, $20 ; entry 0
    db $e0, $fc, $24, $20 ; entry 1
    db $f0, $fc, $22, $20 ; entry 2
    db $80 ; end

; frame 8 of MetaSprites3ESet01; ends with $80 (E-0147)
MetaSprites3ESet01Frame8::
    db $f0, $f6, $02, $00 ; entry 0
    db $e8, $f9, $00, $00 ; entry 1
    db $f8, $f0, $05, $00 ; entry 2
    db $f8, $08, $05, $20 ; entry 3
    db $f0, $03, $02, $20 ; entry 4
    db $f0, $fe, $03, $00 ; entry 5
    db $e8, $ff, $04, $00 ; entry 6
    db $f8, $f8, $18, $00 ; entry 7
    db $f8, $00, $18, $20 ; entry 8
    db $80 ; end

; frame 9 of MetaSprites3ESet01; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet01Frame9::
    db $f8, $05, $11, $00 ; entry 0
    db $f8, $f5, $0f, $00 ; entry 1
    db $f0, $0b, $09, $20 ; entry 2
    db $f8, $ed, $17, $20 ; entry 3
    db $f8, $0d, $13, $20 ; entry 4
    db $f8, $fd, $20, $00 ; entry 5
    db $f0, $03, $0c, $00 ; entry 6
    db $f0, $fb, $18, $00 ; entry 7
    db $e8, $06, $02, $20 ; entry 8
    db $e8, $fe, $03, $20 ; entry 9
    db $e8, $f6, $04, $20 ; entry 10
    db $d8, $fd, $24, $20 ; entry 11
    db $e0, $fd, $25, $20 ; entry 12
    db $f0, $f3, $09, $00 ; entry 13
    db $f0, $ed, $05, $00 ; entry 14
    db $80 ; end

; frame 10 of MetaSprites3ESet01; ends with $80 (E-0147)
MetaSprites3ESet01Frame10::
    db $f8, $f3, $11, $20 ; entry 0
    db $f8, $03, $0f, $20 ; entry 1
    db $f0, $ed, $09, $00 ; entry 2
    db $f0, $f5, $0a, $00 ; entry 3
    db $f0, $fd, $0b, $00 ; entry 4
    db $f0, $05, $0c, $00 ; entry 5
    db $f0, $0d, $0d, $00 ; entry 6
    db $e8, $f9, $06, $00 ; entry 7
    db $e8, $01, $07, $00 ; entry 8
    db $e8, $09, $08, $00 ; entry 9
    db $e0, $f7, $02, $00 ; entry 10
    db $e0, $ff, $03, $00 ; entry 11
    db $e0, $07, $04, $00 ; entry 12
    db $d8, $fa, $00, $00 ; entry 13
    db $d8, $02, $01, $00 ; entry 14
    db $e8, $f1, $05, $00 ; entry 15
    db $f8, $0b, $17, $00 ; entry 16
    db $f8, $eb, $13, $00 ; entry 17
    db $f8, $fb, $15, $00 ; entry 18
    db $80 ; end

; frame 11 of MetaSprites3ESet01; ends with $80 (E-0147)
MetaSprites3ESet01Frame11::
    db $f0, $fd, $10, $00 ; entry 0
    db $f0, $05, $11, $00 ; entry 1
    db $f0, $ed, $0e, $00 ; entry 2
    db $e8, $eb, $09, $00 ; entry 3
    db $e8, $f3, $0a, $00 ; entry 4
    db $e8, $fb, $0b, $00 ; entry 5
    db $e8, $03, $0c, $00 ; entry 6
    db $e8, $0b, $0d, $00 ; entry 7
    db $e0, $f7, $06, $00 ; entry 8
    db $e0, $ff, $07, $00 ; entry 9
    db $e0, $07, $08, $00 ; entry 10
    db $d8, $f5, $02, $00 ; entry 11
    db $d8, $fd, $03, $00 ; entry 12
    db $d0, $f8, $00, $00 ; entry 13
    db $d0, $00, $01, $00 ; entry 14
    db $e0, $ef, $05, $00 ; entry 15
    db $f0, $f5, $18, $00 ; entry 16
    db $d8, $05, $1c, $20 ; entry 17
    db $f8, $e8, $1f, $00 ; entry 18
    db $f8, $08, $16, $00 ; entry 19
    db $f8, $f8, $15, $00 ; entry 20
    db $f8, $f0, $14, $00 ; entry 21
    db $f8, $00, $10, $20 ; entry 22
    db $f8, $10, $21, $00 ; entry 23
    db $f0, $0d, $1c, $20 ; entry 24
    db $80 ; end

; frame 12 of MetaSprites3ESet01; ends with $80 (E-0147)
MetaSprites3ESet01Frame12::
    db $f0, $fb, $10, $20 ; entry 0
    db $f0, $f3, $11, $20 ; entry 1
    db $f0, $eb, $12, $20 ; entry 2
    db $f0, $03, $0f, $20 ; entry 3
    db $e8, $f5, $0c, $20 ; entry 4
    db $e8, $ed, $0d, $20 ; entry 5
    db $f8, $e8, $17, $20 ; entry 6
    db $f8, $f0, $18, $00 ; entry 7
    db $f8, $00, $20, $20 ; entry 8
    db $f8, $08, $14, $20 ; entry 9
    db $e8, $fd, $18, $20 ; entry 10
    db $e0, $f1, $02, $00 ; entry 11
    db $e0, $f9, $03, $00 ; entry 12
    db $e0, $01, $04, $00 ; entry 13
    db $d8, $fb, $25, $00 ; entry 14
    db $cf, $03, $00, $20 ; entry 15
    db $d0, $fb, $24, $00 ; entry 16
    db $e8, $05, $09, $20 ; entry 17
    db $f0, $0b, $1e, $00 ; entry 18
    db $f8, $10, $0d, $00 ; entry 19
    db $f8, $f8, $20, $40 ; entry 20
    db $80 ; end

; frame 13 of MetaSprites3ESet01; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet01Frame13::
    db $e4, $03, $06, $20 ; entry 0
    db $e4, $f3, $08, $20 ; entry 1
    db $dc, $05, $02, $20 ; entry 2
    db $dc, $f5, $04, $20 ; entry 3
    db $d4, $fc, $04, $20 ; entry 4
    db $d4, $ff, $02, $00 ; entry 5
    db $dc, $fd, $07, $20 ; entry 6
    db $e4, $fb, $0b, $20 ; entry 7
    db $e4, $09, $09, $20 ; entry 8
    db $ec, $f8, $0f, $40 ; entry 9
    db $ec, $f0, $12, $20 ; entry 10
    db $ec, $08, $17, $00 ; entry 11
    db $ec, $00, $18, $20 ; entry 12
    db $f4, $f4, $1f, $40 ; entry 13
    db $f4, $fc, $20, $40 ; entry 14
    db $f4, $04, $1f, $60 ; entry 15
    db $fc, $f8, $23, $00 ; entry 16
    db $fc, $00, $23, $20 ; entry 17
    db $80 ; end

; frame 14 of MetaSprites3ESet01; ends with $80 (E-0147)
MetaSprites3ESet01Frame14::
    db $d0, $fc, $1b, $20 ; entry 0
    db $d8, $04, $1c, $20 ; entry 1
    db $d8, $fc, $1d, $20 ; entry 2
    db $d8, $f4, $1e, $20 ; entry 3
    db $e0, $04, $1f, $20 ; entry 4
    db $e0, $fc, $20, $20 ; entry 5
    db $e0, $f4, $21, $20 ; entry 6
    db $e8, $fc, $25, $00 ; entry 7
    db $f0, $fc, $22, $00 ; entry 8
    db $e8, $03, $21, $00 ; entry 9
    db $e8, $f5, $1f, $00 ; entry 10
    db $80 ; end

; frame 15 of MetaSprites3ESet01; ends with $80 (E-0147)
MetaSprites3ESet01Frame15::
    db $80 ; end

; meta-sprite set 2 of MetaSprites3ETable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3ESet02::
    dw MetaSprites3ESet02Frame0 ; entry 0
    dw MetaSprites3ESet02Frame1 ; entry 1
    dw MetaSprites3ESet02Frame2 ; entry 2
    dw MetaSprites3ESet02Frame3 ; entry 3
    dw MetaSprites3ESet02Frame4 ; entry 4
    dw MetaSprites3ESet02Frame5 ; entry 5
    dw MetaSprites3ESet02Frame6 ; entry 6
    dw MetaSprites3ESet02Frame7 ; entry 7
    dw MetaSprites3ESet02Frame8 ; entry 8
    dw MetaSprites3ESet02Frame9 ; entry 9
    dw MetaSprites3ESet02Frame10 ; entry 10
    dw MetaSprites3ESet02Frame11 ; entry 11
    dw MetaSprites3ESet02Frame12 ; entry 12
    dw MetaSprites3ESet02Frame13 ; entry 13
    dw MetaSprites3ESet02Frame14 ; entry 14
    dw MetaSprites3ESet02Frame15 ; entry 15
    dw MetaSprites3ESet02Frame16 ; entry 16
    dw MetaSprites3ESet02Frame16 ; entry 17
    dw MetaSprites3ESet02Frame16 ; entry 18
    dw MetaSprites3ESet02Frame16 ; entry 19
    dw MetaSprites3ESet02Frame16 ; entry 20
    dw MetaSprites3ESet02Frame16 ; entry 21
    dw MetaSprites3ESet02Frame16 ; entry 22
    dw MetaSprites3ESet02Frame16 ; entry 23
    dw MetaSprites3ESet02Frame16 ; entry 24
    dw MetaSprites3ESet02Frame16 ; entry 25
    dw MetaSprites3ESet02Frame16 ; entry 26
    dw MetaSprites3ESet02Frame16 ; entry 27
    dw MetaSprites3ESet02Frame16 ; entry 28
    dw MetaSprites3ESet02Frame16 ; entry 29
    dw MetaSprites3ESet02Frame16 ; entry 30
    dw MetaSprites3ESet02Frame16 ; entry 31

; frame 0 of MetaSprites3ESet02; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet02Frame0::
    db $f0, $f0, $00, $00 ; entry 0
    db $f0, $f8, $01, $00 ; entry 1
    db $f0, $00, $02, $00 ; entry 2
    db $f0, $08, $03, $00 ; entry 3
    db $f8, $f0, $15, $00 ; entry 4
    db $f8, $f8, $16, $00 ; entry 5
    db $f8, $08, $15, $20 ; entry 6
    db $f8, $00, $16, $20 ; entry 7
    db $f8, $10, $19, $00 ; entry 8
    db $f8, $e8, $19, $20 ; entry 9
    db $80 ; end

; frame 1 of MetaSprites3ESet02; ends with $80 (E-0147)
MetaSprites3ESet02Frame1::
    db $e8, $08, $00, $20 ; entry 0
    db $e8, $00, $01, $20 ; entry 1
    db $e8, $f8, $02, $20 ; entry 2
    db $e8, $f0, $03, $20 ; entry 3
    db $f0, $08, $10, $20 ; entry 4
    db $f0, $00, $11, $20 ; entry 5
    db $f0, $f8, $12, $20 ; entry 6
    db $f0, $f0, $13, $20 ; entry 7
    db $f8, $f8, $17, $20 ; entry 8
    db $f8, $f0, $18, $20 ; entry 9
    db $f8, $00, $17, $00 ; entry 10
    db $f8, $08, $18, $00 ; entry 11
    db $f8, $10, $1a, $00 ; entry 12
    db $f8, $e8, $1a, $20 ; entry 13
    db $80 ; end

; frame 2 of MetaSprites3ESet02; ends with $80 (E-0147)
MetaSprites3ESet02Frame2::
    db $e0, $f0, $00, $00 ; entry 0
    db $e0, $f8, $01, $00 ; entry 1
    db $e0, $00, $02, $00 ; entry 2
    db $e0, $08, $03, $00 ; entry 3
    db $e8, $f0, $10, $00 ; entry 4
    db $e8, $f8, $11, $00 ; entry 5
    db $e8, $00, $12, $00 ; entry 6
    db $e8, $08, $13, $00 ; entry 7
    db $f0, $f0, $04, $00 ; entry 8
    db $f0, $f8, $05, $00 ; entry 9
    db $f0, $00, $06, $00 ; entry 10
    db $f0, $08, $07, $00 ; entry 11
    db $f8, $f0, $15, $00 ; entry 12
    db $f8, $f8, $16, $00 ; entry 13
    db $f8, $08, $15, $20 ; entry 14
    db $f8, $00, $16, $20 ; entry 15
    db $f8, $10, $19, $00 ; entry 16
    db $f8, $e8, $19, $20 ; entry 17
    db $80 ; end

; frame 3 of MetaSprites3ESet02; ends with $80 (E-0147)
MetaSprites3ESet02Frame3::
    db $d0, $f0, $00, $00 ; entry 0
    db $d0, $f8, $01, $00 ; entry 1
    db $d0, $00, $02, $00 ; entry 2
    db $d0, $08, $03, $00 ; entry 3
    db $d8, $f0, $10, $00 ; entry 4
    db $d8, $f8, $11, $00 ; entry 5
    db $d8, $00, $12, $00 ; entry 6
    db $d8, $08, $13, $00 ; entry 7
    db $e0, $f0, $04, $00 ; entry 8
    db $e0, $f8, $05, $00 ; entry 9
    db $e0, $00, $06, $00 ; entry 10
    db $e0, $08, $07, $00 ; entry 11
    db $e8, $f8, $06, $00 ; entry 12
    db $e8, $00, $09, $00 ; entry 13
    db $e8, $08, $0a, $00 ; entry 14
    db $e8, $f0, $08, $00 ; entry 15
    db $f0, $f8, $09, $00 ; entry 16
    db $f0, $f0, $0b, $00 ; entry 17
    db $f0, $00, $0c, $00 ; entry 18
    db $f0, $08, $0d, $00 ; entry 19
    db $f8, $f8, $17, $20 ; entry 20
    db $f8, $f0, $18, $20 ; entry 21
    db $f8, $00, $17, $00 ; entry 22
    db $f8, $08, $18, $00 ; entry 23
    db $f8, $10, $1a, $00 ; entry 24
    db $f8, $e8, $1a, $20 ; entry 25
    db $80 ; end

; frame 4 of MetaSprites3ESet02; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet02Frame4::
    db $d0, $f0, $04, $00 ; entry 0
    db $d0, $f8, $05, $00 ; entry 1
    db $d0, $00, $06, $00 ; entry 2
    db $d0, $08, $07, $00 ; entry 3
    db $d8, $f8, $06, $00 ; entry 4
    db $d8, $00, $09, $00 ; entry 5
    db $d8, $08, $0a, $00 ; entry 6
    db $d8, $f0, $08, $00 ; entry 7
    db $e0, $f8, $09, $00 ; entry 8
    db $e0, $f0, $0b, $00 ; entry 9
    db $e0, $00, $0c, $00 ; entry 10
    db $e0, $08, $0d, $00 ; entry 11
    db $e8, $f0, $0e, $00 ; entry 12
    db $e8, $f8, $0c, $00 ; entry 13
    db $e8, $00, $0f, $00 ; entry 14
    db $e8, $08, $14, $00 ; entry 15
    db $f0, $f0, $04, $00 ; entry 16
    db $f0, $f8, $05, $00 ; entry 17
    db $f0, $00, $06, $00 ; entry 18
    db $f0, $08, $07, $00 ; entry 19
    db $f8, $f0, $15, $00 ; entry 20
    db $f8, $f8, $16, $00 ; entry 21
    db $f8, $08, $15, $20 ; entry 22
    db $f8, $00, $16, $20 ; entry 23
    db $f8, $10, $19, $00 ; entry 24
    db $f8, $e8, $19, $20 ; entry 25
    db $80 ; end

; frame 5 of MetaSprites3ESet02; ends with $80 (E-0147)
MetaSprites3ESet02Frame5::
    db $d0, $f8, $06, $00 ; entry 0
    db $d0, $00, $09, $00 ; entry 1
    db $d0, $08, $0a, $00 ; entry 2
    db $d0, $f0, $08, $00 ; entry 3
    db $d8, $f8, $09, $00 ; entry 4
    db $d8, $f0, $0b, $00 ; entry 5
    db $d8, $00, $0c, $00 ; entry 6
    db $d8, $08, $0d, $00 ; entry 7
    db $e0, $f0, $0e, $00 ; entry 8
    db $e0, $f8, $0c, $00 ; entry 9
    db $e0, $00, $0f, $00 ; entry 10
    db $e0, $08, $14, $00 ; entry 11
    db $e8, $f0, $04, $00 ; entry 12
    db $e8, $f8, $05, $00 ; entry 13
    db $e8, $00, $06, $00 ; entry 14
    db $e8, $08, $07, $00 ; entry 15
    db $f0, $f8, $06, $00 ; entry 16
    db $f0, $00, $09, $00 ; entry 17
    db $f0, $08, $0a, $00 ; entry 18
    db $f0, $f0, $08, $00 ; entry 19
    db $f8, $f8, $17, $20 ; entry 20
    db $f8, $f0, $18, $20 ; entry 21
    db $f8, $00, $17, $00 ; entry 22
    db $f8, $08, $18, $00 ; entry 23
    db $f8, $10, $1a, $00 ; entry 24
    db $f8, $e8, $1a, $20 ; entry 25
    db $80 ; end

; frame 6 of MetaSprites3ESet02; ends with $80 (E-0147)
MetaSprites3ESet02Frame6::
    db $d0, $f8, $09, $00 ; entry 0
    db $d0, $f0, $0b, $00 ; entry 1
    db $d0, $00, $0c, $00 ; entry 2
    db $d0, $08, $0d, $00 ; entry 3
    db $d8, $f0, $0e, $00 ; entry 4
    db $d8, $f8, $0c, $00 ; entry 5
    db $d8, $00, $0f, $00 ; entry 6
    db $d8, $08, $14, $00 ; entry 7
    db $e0, $f0, $04, $00 ; entry 8
    db $e0, $f8, $05, $00 ; entry 9
    db $e0, $00, $06, $00 ; entry 10
    db $e0, $08, $07, $00 ; entry 11
    db $e8, $f8, $06, $00 ; entry 12
    db $e8, $00, $09, $00 ; entry 13
    db $e8, $08, $0a, $00 ; entry 14
    db $e8, $f0, $08, $00 ; entry 15
    db $f0, $f8, $09, $00 ; entry 16
    db $f0, $f0, $0b, $00 ; entry 17
    db $f0, $00, $0c, $00 ; entry 18
    db $f0, $08, $0d, $00 ; entry 19
    db $f8, $f0, $15, $00 ; entry 20
    db $f8, $f8, $16, $00 ; entry 21
    db $f8, $08, $15, $20 ; entry 22
    db $f8, $00, $16, $20 ; entry 23
    db $f8, $10, $19, $00 ; entry 24
    db $f8, $e8, $19, $20 ; entry 25
    db $80 ; end

; frame 7 of MetaSprites3ESet02; ends with $80 (E-0147)
MetaSprites3ESet02Frame7::
    db $d0, $f0, $0e, $00 ; entry 0
    db $d0, $f8, $0c, $00 ; entry 1
    db $d0, $00, $0f, $00 ; entry 2
    db $d0, $08, $14, $00 ; entry 3
    db $d8, $f0, $04, $00 ; entry 4
    db $d8, $f8, $05, $00 ; entry 5
    db $d8, $00, $06, $00 ; entry 6
    db $d8, $08, $07, $00 ; entry 7
    db $e0, $f8, $06, $00 ; entry 8
    db $e0, $00, $09, $00 ; entry 9
    db $e0, $08, $0a, $00 ; entry 10
    db $e0, $f0, $08, $00 ; entry 11
    db $e8, $f8, $09, $00 ; entry 12
    db $e8, $f0, $0b, $00 ; entry 13
    db $e8, $00, $0c, $00 ; entry 14
    db $e8, $08, $0d, $00 ; entry 15
    db $f0, $f0, $0e, $00 ; entry 16
    db $f0, $f8, $0c, $00 ; entry 17
    db $f0, $00, $0f, $00 ; entry 18
    db $f0, $08, $14, $00 ; entry 19
    db $f8, $f8, $17, $20 ; entry 20
    db $f8, $f0, $18, $20 ; entry 21
    db $f8, $00, $17, $00 ; entry 22
    db $f8, $08, $18, $00 ; entry 23
    db $f8, $10, $1a, $00 ; entry 24
    db $f8, $e8, $1a, $20 ; entry 25
    db $80 ; end

; frame 8 of MetaSprites3ESet02; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet02Frame8::
    db $f8, $f8, $1b, $00 ; entry 0
    db $f8, $00, $1b, $20 ; entry 1
    db $80 ; end

; frame 9 of MetaSprites3ESet02; ends with $80 (E-0147)
MetaSprites3ESet02Frame9::
    db $f0, $f8, $1c, $00 ; entry 0
    db $f0, $00, $1d, $00 ; entry 1
    db $f8, $f8, $1e, $00 ; entry 2
    db $f8, $00, $1f, $00 ; entry 3
    db $f8, $07, $27, $00 ; entry 4
    db $f8, $f1, $26, $00 ; entry 5
    db $80 ; end

; frame 10 of MetaSprites3ESet02; ends with $80 (E-0147)
MetaSprites3ESet02Frame10::
    db $e8, $00, $1c, $20 ; entry 0
    db $e8, $f8, $1d, $20 ; entry 1
    db $f0, $00, $1e, $20 ; entry 2
    db $f0, $f8, $1f, $20 ; entry 3
    db $f7, $fc, $25, $00 ; entry 4
    db $f0, $07, $26, $20 ; entry 5
    db $f6, $03, $27, $00 ; entry 6
    db $f4, $f4, $26, $00 ; entry 7
    db $f0, $f1, $27, $20 ; entry 8
    db $80 ; end

; frame 11 of MetaSprites3ESet02; ends with $80 (E-0147)
MetaSprites3ESet02Frame11::
    db $e4, $f8, $1c, $00 ; entry 0
    db $e4, $00, $1d, $00 ; entry 1
    db $ec, $f8, $1e, $00 ; entry 2
    db $ec, $00, $1f, $00 ; entry 3
    db $f3, $fc, $25, $20 ; entry 4
    db $ec, $f1, $26, $00 ; entry 5
    db $f2, $f5, $27, $20 ; entry 6
    db $f0, $04, $26, $20 ; entry 7
    db $ec, $07, $27, $00 ; entry 8
    db $80 ; end

; frame 12 of MetaSprites3ESet02; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet02Frame12::
    db $e4, $f8, $20, $00 ; entry 0
    db $e4, $00, $21, $00 ; entry 1
    db $ec, $f8, $22, $00 ; entry 2
    db $ec, $00, $23, $00 ; entry 3
    db $80 ; end

; frame 13 of MetaSprites3ESet02; ends with $80 (E-0147)
MetaSprites3ESet02Frame13::
    db $e6, $00, $20, $20 ; entry 0
    db $e6, $f8, $21, $20 ; entry 1
    db $ee, $00, $22, $20 ; entry 2
    db $ee, $f8, $23, $20 ; entry 3
    db $80 ; end

; frame 14 of MetaSprites3ESet02; ends with $80 (E-0147)
MetaSprites3ESet02Frame14::
    db $e8, $f8, $20, $00 ; entry 0
    db $e8, $00, $21, $00 ; entry 1
    db $f0, $f8, $22, $00 ; entry 2
    db $f0, $00, $23, $00 ; entry 3
    db $80 ; end

; frame 15 of MetaSprites3ESet02; ends with $80 (E-0147)
MetaSprites3ESet02Frame15::
    db $ec, $fc, $24, $00 ; entry 0
    db $80 ; end

; frame 16 of MetaSprites3ESet02; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet02Frame16::
    db $80 ; end

; meta-sprite set 3 of MetaSprites3ETable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3ESet03::
    dw MetaSprites3ESet03Frame0 ; entry 0
    dw MetaSprites3ESet03Frame1 ; entry 1
    dw MetaSprites3ESet03Frame2 ; entry 2
    dw MetaSprites3ESet03Frame3 ; entry 3
    dw MetaSprites3ESet03Frame4 ; entry 4
    dw MetaSprites3ESet03Frame5 ; entry 5
    dw MetaSprites3ESet03Frame6 ; entry 6
    dw MetaSprites3ESet03Frame7 ; entry 7
    dw MetaSprites3ESet03Frame8 ; entry 8
    dw MetaSprites3ESet03Frame9 ; entry 9
    dw MetaSprites3ESet03Frame10 ; entry 10
    dw MetaSprites3ESet03Frame11 ; entry 11
    dw MetaSprites3ESet03Frame12 ; entry 12
    dw MetaSprites3ESet03Frame13 ; entry 13
    dw MetaSprites3ESet03Frame14 ; entry 14
    dw MetaSprites3ESet03Frame14 ; entry 15
    dw MetaSprites3ESet03Frame14 ; entry 16
    dw MetaSprites3ESet03Frame14 ; entry 17
    dw MetaSprites3ESet03Frame14 ; entry 18
    dw MetaSprites3ESet03Frame14 ; entry 19
    dw MetaSprites3ESet03Frame14 ; entry 20
    dw MetaSprites3ESet03Frame14 ; entry 21
    dw MetaSprites3ESet03Frame14 ; entry 22
    dw MetaSprites3ESet03Frame14 ; entry 23
    dw MetaSprites3ESet03Frame14 ; entry 24
    dw MetaSprites3ESet03Frame14 ; entry 25
    dw MetaSprites3ESet03Frame14 ; entry 26
    dw MetaSprites3ESet03Frame14 ; entry 27
    dw MetaSprites3ESet03Frame14 ; entry 28
    dw MetaSprites3ESet03Frame14 ; entry 29
    dw MetaSprites3ESet03Frame14 ; entry 30
    dw MetaSprites3ESet03Frame14 ; entry 31

; frame 0 of MetaSprites3ESet03; ends with $80 (E-0147)
MetaSprites3ESet03Frame0::
    db $f0, $b0, $05, $10 ; entry 0
    db $f8, $b0, $0e, $10 ; entry 1
    db $f8, $b8, $0f, $10 ; entry 2
    db $80 ; end

; frame 1 of MetaSprites3ESet03; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet03Frame1::
    db $f8, $b0, $1b, $10 ; entry 0
    db $f8, $b8, $1c, $10 ; entry 1
    db $f8, $c0, $1d, $10 ; entry 2
    db $f8, $c8, $1e, $10 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites3ESet03; ends with $80 (E-0147)
MetaSprites3ESet03Frame2::
    db $f0, $b0, $03, $10 ; entry 0
    db $f0, $d8, $03, $10 ; entry 1
    db $f0, $c8, $21, $10 ; entry 2
    db $f8, $b0, $26, $10 ; entry 3
    db $f8, $b8, $27, $10 ; entry 4
    db $f8, $c0, $28, $10 ; entry 5
    db $f8, $c8, $29, $10 ; entry 6
    db $f8, $d0, $2a, $10 ; entry 7
    db $f8, $d8, $2b, $10 ; entry 8
    db $80 ; end

; frame 3 of MetaSprites3ESet03; ends with $80 (E-0147)
MetaSprites3ESet03Frame3::
    db $f0, $b7, $02, $10 ; entry 0
    db $f0, $c8, $03, $10 ; entry 1
    db $f0, $d0, $04, $10 ; entry 2
    db $f0, $e0, $05, $10 ; entry 3
    db $f8, $b0, $08, $10 ; entry 4
    db $f8, $b8, $09, $10 ; entry 5
    db $f8, $c0, $0a, $10 ; entry 6
    db $f8, $c8, $0b, $10 ; entry 7
    db $f8, $d0, $0c, $10 ; entry 8
    db $f8, $d8, $0d, $10 ; entry 9
    db $f8, $e0, $0e, $10 ; entry 10
    db $f8, $e8, $0f, $10 ; entry 11
    db $80 ; end

; frame 4 of MetaSprites3ESet03; ends with $80 (E-0147)
MetaSprites3ESet03Frame4::
    db $f0, $c0, $00, $10 ; entry 0
    db $f0, $b0, $10, $10 ; entry 1
    db $f0, $b8, $11, $10 ; entry 2
    db $f0, $c8, $12, $10 ; entry 3
    db $f0, $d0, $13, $10 ; entry 4
    db $f0, $d8, $14, $10 ; entry 5
    db $f8, $b0, $15, $10 ; entry 6
    db $f8, $b8, $16, $10 ; entry 7
    db $f8, $c0, $17, $10 ; entry 8
    db $f8, $c8, $18, $10 ; entry 9
    db $f8, $d0, $19, $10 ; entry 10
    db $f8, $d8, $1a, $10 ; entry 11
    db $f8, $e0, $1b, $10 ; entry 12
    db $f8, $e8, $1c, $10 ; entry 13
    db $f8, $f0, $1d, $10 ; entry 14
    db $f8, $f8, $1e, $10 ; entry 15
    db $80 ; end

; frame 5 of MetaSprites3ESet03; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet03Frame5::
    db $f0, $e0, $03, $10 ; entry 0
    db $f0, $08, $03, $10 ; entry 1
    db $f0, $c8, $1f, $10 ; entry 2
    db $f0, $d0, $20, $10 ; entry 3
    db $f0, $f8, $21, $10 ; entry 4
    db $f8, $c0, $22, $10 ; entry 5
    db $f8, $c8, $23, $10 ; entry 6
    db $f8, $d0, $24, $10 ; entry 7
    db $f8, $d8, $25, $10 ; entry 8
    db $f8, $e0, $26, $10 ; entry 9
    db $f8, $e8, $27, $10 ; entry 10
    db $f8, $f0, $28, $10 ; entry 11
    db $f8, $f8, $29, $10 ; entry 12
    db $f8, $00, $2a, $10 ; entry 13
    db $f8, $08, $2b, $10 ; entry 14
    db $80 ; end

; frame 6 of MetaSprites3ESet03; ends with $80 (E-0147)
MetaSprites3ESet03Frame6::
    db $f0, $d0, $00, $10 ; entry 0
    db $f0, $d8, $01, $10 ; entry 1
    db $f0, $e7, $02, $10 ; entry 2
    db $f0, $f8, $03, $10 ; entry 3
    db $f0, $00, $04, $10 ; entry 4
    db $f0, $10, $05, $10 ; entry 5
    db $f8, $d0, $06, $10 ; entry 6
    db $f8, $d8, $07, $10 ; entry 7
    db $f8, $e0, $08, $10 ; entry 8
    db $f8, $e8, $09, $10 ; entry 9
    db $f8, $f0, $0a, $10 ; entry 10
    db $f8, $f8, $0b, $10 ; entry 11
    db $f8, $00, $0c, $10 ; entry 12
    db $f8, $08, $0d, $10 ; entry 13
    db $f8, $10, $0e, $10 ; entry 14
    db $f8, $18, $0f, $10 ; entry 15
    db $80 ; end

; frame 7 of MetaSprites3ESet03; ends with $80 (E-0147)
MetaSprites3ESet03Frame7::
    db $f0, $f0, $00, $10 ; entry 0
    db $f0, $e0, $10, $10 ; entry 1
    db $f0, $e8, $11, $10 ; entry 2
    db $f0, $f8, $12, $10 ; entry 3
    db $f0, $00, $13, $10 ; entry 4
    db $f0, $08, $14, $10 ; entry 5
    db $f8, $e0, $15, $10 ; entry 6
    db $f8, $e8, $16, $10 ; entry 7
    db $f8, $f0, $17, $10 ; entry 8
    db $f8, $f8, $18, $10 ; entry 9
    db $f8, $00, $19, $10 ; entry 10
    db $f8, $08, $1a, $10 ; entry 11
    db $f8, $10, $1b, $10 ; entry 12
    db $f8, $18, $1c, $10 ; entry 13
    db $f8, $20, $1d, $10 ; entry 14
    db $f8, $28, $1e, $10 ; entry 15
    db $80 ; end

; frame 8 of MetaSprites3ESet03; ends with $80 (E-0147)
MetaSprites3ESet03Frame8::
    db $f0, $10, $03, $10 ; entry 0
    db $f0, $38, $03, $10 ; entry 1
    db $f0, $f8, $1f, $10 ; entry 2
    db $f0, $00, $20, $10 ; entry 3
    db $f0, $28, $21, $10 ; entry 4
    db $f8, $f0, $22, $10 ; entry 5
    db $f8, $f8, $23, $10 ; entry 6
    db $f8, $00, $24, $10 ; entry 7
    db $f8, $08, $25, $10 ; entry 8
    db $f8, $10, $26, $10 ; entry 9
    db $f8, $18, $27, $10 ; entry 10
    db $f8, $20, $28, $10 ; entry 11
    db $f8, $28, $29, $10 ; entry 12
    db $f8, $30, $2a, $10 ; entry 13
    db $f8, $38, $2b, $10 ; entry 14
    db $80 ; end

; frame 9 of MetaSprites3ESet03; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet03Frame9::
    db $f0, $00, $00, $10 ; entry 0
    db $f0, $08, $01, $10 ; entry 1
    db $f0, $17, $02, $10 ; entry 2
    db $f0, $28, $03, $10 ; entry 3
    db $f0, $30, $04, $10 ; entry 4
    db $f0, $40, $05, $10 ; entry 5
    db $f8, $00, $06, $10 ; entry 6
    db $f8, $08, $07, $10 ; entry 7
    db $f8, $10, $08, $10 ; entry 8
    db $f8, $18, $09, $10 ; entry 9
    db $f8, $20, $0a, $10 ; entry 10
    db $f8, $28, $0b, $10 ; entry 11
    db $f8, $30, $0c, $10 ; entry 12
    db $f8, $38, $0d, $10 ; entry 13
    db $f8, $40, $0e, $10 ; entry 14
    db $f8, $48, $0f, $10 ; entry 15
    db $80 ; end

; frame 10 of MetaSprites3ESet03; ends with $80 (E-0147)
MetaSprites3ESet03Frame10::
    db $f0, $20, $00, $10 ; entry 0
    db $f0, $10, $10, $10 ; entry 1
    db $f0, $18, $11, $10 ; entry 2
    db $f0, $28, $12, $10 ; entry 3
    db $f0, $30, $13, $10 ; entry 4
    db $f0, $38, $14, $10 ; entry 5
    db $f8, $10, $15, $10 ; entry 6
    db $f8, $18, $16, $10 ; entry 7
    db $f8, $20, $17, $10 ; entry 8
    db $f8, $28, $18, $10 ; entry 9
    db $f8, $30, $19, $10 ; entry 10
    db $f8, $38, $1a, $10 ; entry 11
    db $f8, $40, $1b, $10 ; entry 12
    db $f8, $48, $1c, $10 ; entry 13
    db $80 ; end

; frame 11 of MetaSprites3ESet03; ends with $80 (E-0147)
MetaSprites3ESet03Frame11::
    db $f0, $40, $03, $10 ; entry 0
    db $f0, $28, $1f, $10 ; entry 1
    db $f0, $30, $20, $10 ; entry 2
    db $f8, $20, $22, $10 ; entry 3
    db $f8, $28, $23, $10 ; entry 4
    db $f8, $30, $24, $10 ; entry 5
    db $f8, $38, $25, $10 ; entry 6
    db $f8, $40, $26, $10 ; entry 7
    db $f8, $48, $27, $10 ; entry 8
    db $80 ; end

; frame 12 of MetaSprites3ESet03; ends with $80 (E-0147)
MetaSprites3ESet03Frame12::
    db $f0, $30, $00, $10 ; entry 0
    db $f0, $38, $01, $10 ; entry 1
    db $f0, $47, $02, $10 ; entry 2
    db $f8, $30, $06, $10 ; entry 3
    db $f8, $38, $07, $10 ; entry 4
    db $f8, $40, $08, $10 ; entry 5
    db $f8, $48, $09, $10 ; entry 6
    db $80 ; end

; frame 13 of MetaSprites3ESet03; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet03Frame13::
    db $f0, $40, $10, $10 ; entry 0
    db $f0, $48, $11, $10 ; entry 1
    db $f8, $40, $15, $10 ; entry 2
    db $f8, $48, $16, $10 ; entry 3
    db $80 ; end

; frame 14 of MetaSprites3ESet03; ends with $80 (E-0147)
MetaSprites3ESet03Frame14::
    db $80 ; end

; meta-sprite set 4 of MetaSprites3ETable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3ESet04::
    dw MetaSprites3ESet04Frame0 ; entry 0
    dw MetaSprites3ESet04Frame1 ; entry 1
    dw MetaSprites3ESet04Frame2 ; entry 2
    dw MetaSprites3ESet04Frame3 ; entry 3
    dw MetaSprites3ESet04Frame4 ; entry 4
    dw MetaSprites3ESet04Frame5 ; entry 5
    dw MetaSprites3ESet04Frame6 ; entry 6
    dw MetaSprites3ESet04Frame7 ; entry 7
    dw MetaSprites3ESet04Frame8 ; entry 8
    dw MetaSprites3ESet04Frame9 ; entry 9
    dw MetaSprites3ESet04Frame10 ; entry 10
    dw MetaSprites3ESet04Frame11 ; entry 11
    dw MetaSprites3ESet04Frame12 ; entry 12
    dw MetaSprites3ESet04Frame13 ; entry 13
    dw MetaSprites3ESet04Frame14 ; entry 14
    dw MetaSprites3ESet04Frame14 ; entry 15
    dw MetaSprites3ESet04Frame14 ; entry 16
    dw MetaSprites3ESet04Frame14 ; entry 17
    dw MetaSprites3ESet04Frame14 ; entry 18
    dw MetaSprites3ESet04Frame14 ; entry 19
    dw MetaSprites3ESet04Frame14 ; entry 20
    dw MetaSprites3ESet04Frame14 ; entry 21
    dw MetaSprites3ESet04Frame14 ; entry 22
    dw MetaSprites3ESet04Frame14 ; entry 23
    dw MetaSprites3ESet04Frame14 ; entry 24
    dw MetaSprites3ESet04Frame14 ; entry 25
    dw MetaSprites3ESet04Frame14 ; entry 26
    dw MetaSprites3ESet04Frame14 ; entry 27
    dw MetaSprites3ESet04Frame14 ; entry 28
    dw MetaSprites3ESet04Frame14 ; entry 29
    dw MetaSprites3ESet04Frame14 ; entry 30
    dw MetaSprites3ESet04Frame14 ; entry 31

; frame 0 of MetaSprites3ESet04; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet04Frame0::
    db $f0, $b1, $0c, $10 ; entry 0
    db $f8, $b1, $13, $10 ; entry 1
    db $f8, $b9, $14, $10 ; entry 2
    db $80 ; end

; frame 1 of MetaSprites3ESet04; ends with $80 (E-0147)
MetaSprites3ESet04Frame1::
    db $e0, $c0, $04, $10 ; entry 0
    db $f8, $b8, $10, $10 ; entry 1
    db $f8, $c0, $11, $10 ; entry 2
    db $f0, $b0, $19, $10 ; entry 3
    db $f0, $b8, $1a, $10 ; entry 4
    db $f0, $c0, $1b, $10 ; entry 5
    db $f8, $b0, $22, $10 ; entry 6
    db $f8, $c8, $23, $10 ; entry 7
    db $80 ; end

; frame 2 of MetaSprites3ESet04; ends with $80 (E-0147)
MetaSprites3ESet04Frame2::
    db $e8, $d8, $00, $10 ; entry 0
    db $f0, $b8, $05, $10 ; entry 1
    db $f0, $d0, $09, $10 ; entry 2
    db $f0, $c0, $19, $30 ; entry 3
    db $e0, $d0, $24, $10 ; entry 4
    db $e8, $c8, $25, $10 ; entry 5
    db $e8, $d0, $26, $10 ; entry 6
    db $f8, $c0, $20, $10 ; entry 7
    db $f8, $b0, $23, $30 ; entry 8
    db $f0, $c8, $28, $10 ; entry 9
    db $f0, $d8, $29, $10 ; entry 10
    db $f8, $c8, $2d, $10 ; entry 11
    db $f8, $b8, $1f, $10 ; entry 12
    db $f8, $d0, $0f, $10 ; entry 13
    db $f8, $d8, $2e, $10 ; entry 14
    db $80 ; end

; frame 3 of MetaSprites3ESet04; ends with $80 (E-0147)
MetaSprites3ESet04Frame3::
    db $e0, $b8, $00, $10 ; entry 0
    db $e8, $b8, $01, $10 ; entry 1
    db $e8, $c0, $02, $10 ; entry 2
    db $e8, $c8, $03, $10 ; entry 3
    db $e8, $d0, $04, $10 ; entry 4
    db $f0, $b0, $06, $10 ; entry 5
    db $f0, $b8, $07, $10 ; entry 6
    db $f0, $c0, $08, $10 ; entry 7
    db $f0, $c8, $09, $10 ; entry 8
    db $f0, $d0, $0a, $10 ; entry 9
    db $f0, $d8, $0b, $10 ; entry 10
    db $f0, $e0, $0c, $10 ; entry 11
    db $f8, $b0, $0d, $10 ; entry 12
    db $f8, $c8, $10, $10 ; entry 13
    db $f8, $d0, $11, $10 ; entry 14
    db $f8, $d8, $12, $10 ; entry 15
    db $f8, $e0, $13, $10 ; entry 16
    db $f8, $e8, $14, $10 ; entry 17
    db $e8, $b0, $27, $30 ; entry 18
    db $f8, $b8, $0e, $10 ; entry 19
    db $f8, $c0, $0f, $10 ; entry 20
    db $80 ; end

; frame 4 of MetaSprites3ESet04; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet04Frame4::
    db $e0, $f0, $04, $10 ; entry 0
    db $f0, $b8, $06, $10 ; entry 1
    db $f8, $e8, $10, $10 ; entry 2
    db $f8, $f0, $11, $10 ; entry 3
    db $f0, $b0, $15, $10 ; entry 4
    db $f0, $c0, $16, $10 ; entry 5
    db $f0, $c8, $17, $10 ; entry 6
    db $f0, $d0, $18, $10 ; entry 7
    db $f0, $e0, $19, $10 ; entry 8
    db $f0, $e8, $1a, $10 ; entry 9
    db $f0, $f0, $1b, $10 ; entry 10
    db $f8, $b0, $1c, $10 ; entry 11
    db $f8, $b8, $1d, $10 ; entry 12
    db $f8, $d0, $20, $10 ; entry 13
    db $f8, $d8, $21, $10 ; entry 14
    db $f8, $e0, $22, $10 ; entry 15
    db $f8, $f8, $23, $10 ; entry 16
    db $f8, $c0, $1e, $10 ; entry 17
    db $f8, $c8, $1f, $10 ; entry 18
    db $80 ; end

; frame 5 of MetaSprites3ESet04; ends with $80 (E-0147)
MetaSprites3ESet04Frame5::
    db $e8, $08, $00, $10 ; entry 0
    db $f0, $e8, $05, $10 ; entry 1
    db $f0, $c8, $0b, $10 ; entry 2
    db $f0, $d0, $0c, $10 ; entry 3
    db $f0, $00, $09, $10 ; entry 4
    db $f8, $c8, $12, $10 ; entry 5
    db $f0, $f0, $19, $30 ; entry 6
    db $e0, $00, $24, $10 ; entry 7
    db $e8, $f8, $25, $10 ; entry 8
    db $e8, $00, $26, $10 ; entry 9
    db $f8, $f0, $20, $10 ; entry 10
    db $f8, $e0, $23, $30 ; entry 11
    db $f0, $d8, $27, $10 ; entry 12
    db $f0, $f8, $28, $10 ; entry 13
    db $f0, $08, $29, $10 ; entry 14
    db $f8, $c0, $2a, $10 ; entry 15
    db $f8, $d0, $2b, $10 ; entry 16
    db $f8, $d8, $2c, $10 ; entry 17
    db $f8, $f8, $2d, $10 ; entry 18
    db $f8, $e8, $1f, $10 ; entry 19
    db $f8, $00, $0f, $10 ; entry 20
    db $f8, $08, $2e, $10 ; entry 21
    db $80 ; end

; frame 6 of MetaSprites3ESet04; ends with $80 (E-0147)
MetaSprites3ESet04Frame6::
    db $e0, $e8, $00, $10 ; entry 0
    db $e8, $e8, $01, $10 ; entry 1
    db $e8, $f0, $02, $10 ; entry 2
    db $e8, $f8, $03, $10 ; entry 3
    db $e8, $00, $04, $10 ; entry 4
    db $f0, $d8, $05, $10 ; entry 5
    db $f0, $e0, $06, $10 ; entry 6
    db $f0, $e8, $07, $10 ; entry 7
    db $f0, $f0, $08, $10 ; entry 8
    db $f0, $f8, $09, $10 ; entry 9
    db $f0, $00, $0a, $10 ; entry 10
    db $f0, $08, $0b, $10 ; entry 11
    db $f0, $10, $0c, $10 ; entry 12
    db $f8, $e0, $0d, $10 ; entry 13
    db $f8, $f8, $10, $10 ; entry 14
    db $f8, $00, $11, $10 ; entry 15
    db $f8, $08, $12, $10 ; entry 16
    db $f8, $10, $13, $10 ; entry 17
    db $f8, $18, $14, $10 ; entry 18
    db $f8, $d0, $23, $30 ; entry 19
    db $e8, $e0, $27, $30 ; entry 20
    db $f8, $e8, $0e, $10 ; entry 21
    db $f8, $f0, $0f, $10 ; entry 22
    db $f8, $d8, $1f, $10 ; entry 23
    db $80 ; end

; frame 7 of MetaSprites3ESet04; ends with $80 (E-0147)
MetaSprites3ESet04Frame7::
    db $e0, $20, $04, $10 ; entry 0
    db $f0, $e8, $06, $10 ; entry 1
    db $f8, $18, $10, $10 ; entry 2
    db $f8, $20, $11, $10 ; entry 3
    db $f0, $e0, $15, $10 ; entry 4
    db $f0, $f0, $16, $10 ; entry 5
    db $f0, $f8, $17, $10 ; entry 6
    db $f0, $00, $18, $10 ; entry 7
    db $f0, $10, $19, $10 ; entry 8
    db $f0, $18, $1a, $10 ; entry 9
    db $f0, $20, $1b, $10 ; entry 10
    db $f8, $e0, $1c, $10 ; entry 11
    db $f8, $e8, $1d, $10 ; entry 12
    db $f8, $00, $20, $10 ; entry 13
    db $f8, $08, $21, $10 ; entry 14
    db $f8, $10, $22, $10 ; entry 15
    db $f8, $28, $23, $10 ; entry 16
    db $f8, $f0, $1e, $10 ; entry 17
    db $f8, $f8, $1f, $10 ; entry 18
    db $80 ; end

; frame 8 of MetaSprites3ESet04; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet04Frame8::
    db $e8, $38, $00, $10 ; entry 0
    db $f0, $18, $05, $10 ; entry 1
    db $f0, $f8, $0b, $10 ; entry 2
    db $f0, $00, $0c, $10 ; entry 3
    db $f0, $30, $09, $10 ; entry 4
    db $f8, $f8, $12, $10 ; entry 5
    db $f0, $20, $19, $30 ; entry 6
    db $e0, $30, $24, $10 ; entry 7
    db $e8, $28, $25, $10 ; entry 8
    db $e8, $30, $26, $10 ; entry 9
    db $f8, $20, $20, $10 ; entry 10
    db $f8, $10, $23, $30 ; entry 11
    db $f0, $08, $27, $10 ; entry 12
    db $f0, $28, $28, $10 ; entry 13
    db $f0, $38, $29, $10 ; entry 14
    db $f8, $f0, $2a, $10 ; entry 15
    db $f8, $00, $2b, $10 ; entry 16
    db $f8, $08, $2c, $10 ; entry 17
    db $f8, $28, $2d, $10 ; entry 18
    db $f8, $18, $1f, $10 ; entry 19
    db $f8, $30, $0f, $10 ; entry 20
    db $f8, $38, $2e, $10 ; entry 21
    db $80 ; end

; frame 9 of MetaSprites3ESet04; ends with $80 (E-0147)
MetaSprites3ESet04Frame9::
    db $e0, $18, $00, $10 ; entry 0
    db $e8, $18, $01, $10 ; entry 1
    db $e8, $20, $02, $10 ; entry 2
    db $e8, $28, $03, $10 ; entry 3
    db $e8, $30, $04, $10 ; entry 4
    db $f0, $08, $05, $10 ; entry 5
    db $f0, $10, $06, $10 ; entry 6
    db $f0, $18, $07, $10 ; entry 7
    db $f0, $20, $08, $10 ; entry 8
    db $f0, $28, $09, $10 ; entry 9
    db $f0, $30, $0a, $10 ; entry 10
    db $f0, $38, $0b, $10 ; entry 11
    db $f0, $40, $0c, $10 ; entry 12
    db $f8, $10, $0d, $10 ; entry 13
    db $f8, $28, $10, $10 ; entry 14
    db $f8, $30, $11, $10 ; entry 15
    db $f8, $38, $12, $10 ; entry 16
    db $f8, $40, $13, $10 ; entry 17
    db $f8, $48, $14, $10 ; entry 18
    db $f8, $00, $23, $30 ; entry 19
    db $e8, $10, $27, $30 ; entry 20
    db $f8, $18, $0e, $10 ; entry 21
    db $f8, $20, $0f, $10 ; entry 22
    db $f8, $08, $1f, $10 ; entry 23
    db $80 ; end

; frame 10 of MetaSprites3ESet04; ends with $80 (E-0147)
MetaSprites3ESet04Frame10::
    db $f0, $18, $06, $10 ; entry 0
    db $f8, $48, $10, $10 ; entry 1
    db $f0, $10, $15, $10 ; entry 2
    db $f0, $20, $16, $10 ; entry 3
    db $f0, $28, $17, $10 ; entry 4
    db $f0, $30, $18, $10 ; entry 5
    db $f0, $40, $19, $10 ; entry 6
    db $f0, $48, $1a, $10 ; entry 7
    db $f8, $10, $1c, $10 ; entry 8
    db $f8, $18, $1d, $10 ; entry 9
    db $f8, $30, $20, $10 ; entry 10
    db $f8, $38, $21, $10 ; entry 11
    db $f8, $40, $22, $10 ; entry 12
    db $f8, $20, $1e, $10 ; entry 13
    db $f8, $28, $1f, $10 ; entry 14
    db $80 ; end

; frame 11 of MetaSprites3ESet04; ends with $80 (E-0147)
MetaSprites3ESet04Frame11::
    db $f0, $48, $05, $10 ; entry 0
    db $f0, $28, $0b, $10 ; entry 1
    db $f0, $30, $0c, $10 ; entry 2
    db $f8, $28, $12, $10 ; entry 3
    db $f8, $40, $23, $30 ; entry 4
    db $f0, $38, $27, $10 ; entry 5
    db $f8, $20, $2a, $10 ; entry 6
    db $f8, $30, $2b, $10 ; entry 7
    db $f8, $38, $2c, $10 ; entry 8
    db $f8, $48, $1f, $10 ; entry 9
    db $80 ; end

; frame 12 of MetaSprites3ESet04; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet04Frame12::
    db $e0, $48, $00, $10 ; entry 0
    db $e8, $48, $01, $10 ; entry 1
    db $f0, $38, $05, $10 ; entry 2
    db $f0, $40, $06, $10 ; entry 3
    db $f0, $48, $07, $10 ; entry 4
    db $f8, $40, $0d, $10 ; entry 5
    db $f8, $30, $23, $30 ; entry 6
    db $e8, $40, $27, $30 ; entry 7
    db $f8, $48, $0e, $10 ; entry 8
    db $f8, $38, $1f, $10 ; entry 9
    db $80 ; end

; frame 13 of MetaSprites3ESet04; ends with $80 (E-0147)
MetaSprites3ESet04Frame13::
    db $f0, $48, $06, $10 ; entry 0
    db $f0, $40, $15, $10 ; entry 1
    db $f8, $40, $1c, $10 ; entry 2
    db $f8, $48, $1d, $10 ; entry 3
    db $80 ; end

; frame 14 of MetaSprites3ESet04; ends with $80 (E-0147)
MetaSprites3ESet04Frame14::
    db $80 ; end

; meta-sprite set 5 of MetaSprites3ETable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3ESet05::
    dw MetaSprites3ESet05Frame0 ; entry 0
    dw MetaSprites3ESet05Frame1 ; entry 1
    dw MetaSprites3ESet05Frame2 ; entry 2
    dw MetaSprites3ESet05Frame3 ; entry 3
    dw MetaSprites3ESet05Frame4 ; entry 4
    dw MetaSprites3ESet05Frame5 ; entry 5
    dw MetaSprites3ESet05Frame6 ; entry 6
    dw MetaSprites3ESet05Frame7 ; entry 7
    dw MetaSprites3ESet05Frame8 ; entry 8
    dw MetaSprites3ESet05Frame9 ; entry 9
    dw MetaSprites3ESet05Frame10 ; entry 10
    dw MetaSprites3ESet05Frame11 ; entry 11
    dw MetaSprites3ESet05Frame11 ; entry 12
    dw MetaSprites3ESet05Frame11 ; entry 13
    dw MetaSprites3ESet05Frame11 ; entry 14
    dw MetaSprites3ESet05Frame11 ; entry 15
    dw MetaSprites3ESet05Frame11 ; entry 16
    dw MetaSprites3ESet05Frame11 ; entry 17
    dw MetaSprites3ESet05Frame11 ; entry 18
    dw MetaSprites3ESet05Frame11 ; entry 19
    dw MetaSprites3ESet05Frame11 ; entry 20
    dw MetaSprites3ESet05Frame11 ; entry 21
    dw MetaSprites3ESet05Frame11 ; entry 22
    dw MetaSprites3ESet05Frame11 ; entry 23
    dw MetaSprites3ESet05Frame11 ; entry 24
    dw MetaSprites3ESet05Frame11 ; entry 25
    dw MetaSprites3ESet05Frame11 ; entry 26
    dw MetaSprites3ESet05Frame11 ; entry 27
    dw MetaSprites3ESet05Frame11 ; entry 28
    dw MetaSprites3ESet05Frame11 ; entry 29
    dw MetaSprites3ESet05Frame11 ; entry 30
    dw MetaSprites3ESet05Frame11 ; entry 31

; frame 0 of MetaSprites3ESet05; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet05Frame0::
    db $f8, $b0, $04, $10 ; entry 0
    db $f8, $48, $04, $30 ; entry 1
    db $80 ; end

; frame 1 of MetaSprites3ESet05; ends with $80 (E-0147)
MetaSprites3ESet05Frame1::
    db $f0, $be, $00, $10 ; entry 0
    db $f8, $b6, $01, $10 ; entry 1
    db $f8, $be, $02, $10 ; entry 2
    db $f8, $c6, $03, $10 ; entry 3
    db $f8, $ce, $09, $10 ; entry 4
    db $f0, $3a, $00, $30 ; entry 5
    db $f8, $42, $01, $30 ; entry 6
    db $f8, $3a, $02, $30 ; entry 7
    db $f8, $32, $03, $30 ; entry 8
    db $f8, $2a, $09, $30 ; entry 9
    db $80 ; end

; frame 2 of MetaSprites3ESet05; ends with $80 (E-0147)
MetaSprites3ESet05Frame2::
    db $f8, $2c, $01, $30 ; entry 0
    db $f8, $cc, $01, $10 ; entry 1
    db $f0, $e4, $05, $10 ; entry 2
    db $f8, $d4, $06, $10 ; entry 3
    db $f8, $dc, $07, $10 ; entry 4
    db $f8, $e4, $08, $10 ; entry 5
    db $f8, $ec, $09, $10 ; entry 6
    db $f8, $24, $06, $30 ; entry 7
    db $f8, $1c, $07, $30 ; entry 8
    db $f8, $14, $08, $30 ; entry 9
    db $f8, $0c, $09, $30 ; entry 10
    db $f0, $14, $05, $30 ; entry 11
    db $80 ; end

; frame 3 of MetaSprites3ESet05; ends with $80 (E-0147)
MetaSprites3ESet05Frame3::
    db $ef, $0e, $00, $30 ; entry 0
    db $d8, $f9, $10, $10 ; entry 1
    db $e0, $f8, $11, $10 ; entry 2
    db $e0, $00, $12, $10 ; entry 3
    db $e8, $f8, $21, $10 ; entry 4
    db $e8, $00, $22, $10 ; entry 5
    db $f0, $f0, $13, $10 ; entry 6
    db $f8, $f0, $23, $10 ; entry 7
    db $f8, $f8, $24, $10 ; entry 8
    db $f8, $00, $25, $10 ; entry 9
    db $f8, $08, $26, $10 ; entry 10
    db $f8, $e8, $20, $10 ; entry 11
    db $f8, $10, $20, $30 ; entry 12
    db $f0, $00, $15, $10 ; entry 13
    db $f0, $08, $16, $10 ; entry 14
    db $f0, $f8, $1e, $10 ; entry 15
    db $80 ; end

; frame 4 of MetaSprites3ESet05; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet05Frame4::
    db $d0, $00, $0a, $10 ; entry 0
    db $d8, $00, $0b, $10 ; entry 1
    db $d8, $07, $0c, $10 ; entry 2
    db $e0, $04, $0e, $10 ; entry 3
    db $e8, $08, $19, $10 ; entry 4
    db $f0, $00, $19, $10 ; entry 5
    db $f0, $08, $29, $10 ; entry 6
    db $f0, $18, $17, $10 ; entry 7
    db $f8, $17, $27, $10 ; entry 8
    db $f0, $e0, $14, $10 ; entry 9
    db $f0, $e8, $25, $10 ; entry 10
    db $e0, $0c, $22, $10 ; entry 11
    db $d8, $f8, $12, $30 ; entry 12
    db $d8, $ee, $10, $30 ; entry 13
    db $e0, $fc, $21, $10 ; entry 14
    db $e8, $f8, $13, $10 ; entry 15
    db $e8, $00, $15, $30 ; entry 16
    db $f0, $f8, $28, $10 ; entry 17
    db $f0, $f0, $28, $30 ; entry 18
    db $f8, $0f, $23, $30 ; entry 19
    db $e8, $10, $28, $30 ; entry 20
    db $f8, $e0, $1a, $10 ; entry 21
    db $f8, $e8, $1b, $10 ; entry 22
    db $f8, $ff, $1b, $10 ; entry 23
    db $f8, $07, $1c, $10 ; entry 24
    db $f0, $10, $1e, $30 ; entry 25
    db $f8, $f0, $2a, $10 ; entry 26
    db $f8, $f7, $0b, $10 ; entry 27
    db $e0, $ef, $1a, $30 ; entry 28
    db $e0, $e7, $0c, $30 ; entry 29
    db $e8, $e1, $22, $30 ; entry 30
    db $e8, $e9, $18, $30 ; entry 31
    db $80 ; end

; frame 5 of MetaSprites3ESet05; ends with $80 (E-0147)
MetaSprites3ESet05Frame5::
    db $e8, $ec, $14, $10 ; entry 0
    db $e0, $eb, $21, $10 ; entry 1
    db $e0, $f3, $19, $10 ; entry 2
    db $d8, $1c, $17, $10 ; entry 3
    db $e0, $1b, $27, $10 ; entry 4
    db $d0, $e0, $22, $70 ; entry 5
    db $e0, $e3, $1d, $10 ; entry 6
    db $f8, $f6, $2c, $10 ; entry 7
    db $d0, $f0, $1c, $10 ; entry 8
    db $d8, $e4, $18, $10 ; entry 9
    db $d8, $ec, $19, $10 ; entry 10
    db $d0, $e8, $29, $10 ; entry 11
    db $d0, $f8, $29, $30 ; entry 12
    db $d0, $00, $19, $70 ; entry 13
    db $d8, $f4, $19, $70 ; entry 14
    db $e8, $f4, $29, $10 ; entry 15
    db $f0, $f8, $29, $50 ; entry 16
    db $f8, $fe, $0e, $50 ; entry 17
    db $f0, $00, $0e, $70 ; entry 18
    db $d8, $0c, $19, $30 ; entry 19
    db $d8, $fc, $19, $70 ; entry 20
    db $e0, $fb, $1c, $50 ; entry 21
    db $d0, $08, $0e, $10 ; entry 22
    db $d8, $04, $29, $10 ; entry 23
    db $e0, $03, $29, $30 ; entry 24
    db $e8, $fc, $1b, $10 ; entry 25
    db $d0, $10, $1c, $10 ; entry 26
    db $e8, $04, $1c, $10 ; entry 27
    db $d0, $18, $0f, $10 ; entry 28
    db $d8, $14, $14, $30 ; entry 29
    db $e8, $0c, $0f, $10 ; entry 30
    db $e0, $0b, $2a, $50 ; entry 31
    db $e0, $13, $10, $70 ; entry 32
    db $f0, $08, $28, $70 ; entry 33
    db $f0, $f0, $0b, $50 ; entry 34
    db $f8, $e6, $05, $10 ; entry 35
    db $f8, $0e, $20, $30 ; entry 36
    db $f8, $16, $16, $10 ; entry 37
    db $f8, $ee, $2b, $10 ; entry 38
    db $f8, $06, $0d, $10 ; entry 39
    db $80 ; end

; frame 6 of MetaSprites3ESet05; ends with $80 (E-0147)
MetaSprites3ESet05Frame6::
    db $f8, $0a, $26, $10 ; entry 0
    db $e8, $19, $10, $10 ; entry 1
    db $f0, $18, $11, $10 ; entry 2
    db $f0, $20, $12, $10 ; entry 3
    db $f8, $18, $21, $10 ; entry 4
    db $f8, $20, $22, $10 ; entry 5
    db $e0, $e8, $17, $10 ; entry 6
    db $e8, $e8, $27, $10 ; entry 7
    db $d8, $f0, $18, $10 ; entry 8
    db $e8, $f4, $18, $10 ; entry 9
    db $e0, $00, $18, $30 ; entry 10
    db $f0, $00, $18, $30 ; entry 11
    db $d0, $00, $19, $10 ; entry 12
    db $d8, $f8, $19, $10 ; entry 13
    db $d0, $f8, $29, $10 ; entry 14
    db $e8, $fc, $0e, $10 ; entry 15
    db $e8, $04, $22, $10 ; entry 16
    db $d0, $f0, $21, $10 ; entry 17
    db $d8, $10, $17, $30 ; entry 18
    db $e0, $10, $27, $30 ; entry 19
    db $d0, $20, $17, $10 ; entry 20
    db $f0, $f0, $28, $10 ; entry 21
    db $e8, $df, $10, $30 ; entry 22
    db $f0, $e0, $11, $30 ; entry 23
    db $f0, $d8, $12, $30 ; entry 24
    db $f8, $e0, $21, $30 ; entry 25
    db $f8, $d8, $0c, $30 ; entry 26
    db $d8, $d8, $1d, $10 ; entry 27
    db $e0, $28, $1d, $10 ; entry 28
    db $d0, $08, $0f, $10 ; entry 29
    db $f0, $f8, $1f, $10 ; entry 30
    db $e0, $f8, $1f, $10 ; entry 31
    db $f8, $f2, $2c, $10 ; entry 32
    db $f8, $fa, $2d, $10 ; entry 33
    db $e0, $f0, $1e, $10 ; entry 34
    db $d8, $08, $1e, $30 ; entry 35
    db $d8, $00, $29, $70 ; entry 36
    db $f8, $02, $0d, $10 ; entry 37
    db $f8, $28, $17, $30 ; entry 38
    db $f8, $d0, $17, $10 ; entry 39
    db $80 ; end

; frame 7 of MetaSprites3ESet05; ends with $80 (E-0147)
MetaSprites3ESet05Frame7::
    db $f0, $f0, $18, $10 ; entry 0
    db $f0, $f8, $19, $10 ; entry 1
    db $e4, $d4, $10, $10 ; entry 2
    db $ec, $24, $11, $30 ; entry 3
    db $f4, $1c, $27, $10 ; entry 4
    db $ec, $1c, $28, $10 ; entry 5
    db $e4, $24, $10, $30 ; entry 6
    db $f8, $10, $0c, $10 ; entry 7
    db $d8, $10, $17, $10 ; entry 8
    db $e0, $10, $27, $10 ; entry 9
    db $dc, $e8, $17, $30 ; entry 10
    db $e4, $e8, $27, $30 ; entry 11
    db $d0, $f8, $0a, $10 ; entry 12
    db $d8, $f8, $0b, $10 ; entry 13
    db $d8, $00, $0c, $10 ; entry 14
    db $e0, $fc, $0e, $10 ; entry 15
    db $e0, $04, $22, $10 ; entry 16
    db $e8, $f0, $28, $10 ; entry 17
    db $e8, $f8, $29, $10 ; entry 18
    db $e8, $00, $19, $10 ; entry 19
    db $f0, $08, $28, $30 ; entry 20
    db $d8, $f0, $16, $30 ; entry 21
    db $e8, $08, $0f, $10 ; entry 22
    db $f8, $e8, $1a, $10 ; entry 23
    db $f8, $f0, $1b, $10 ; entry 24
    db $f8, $08, $1c, $70 ; entry 25
    db $f8, $f8, $0e, $10 ; entry 26
    db $f8, $00, $2d, $10 ; entry 27
    db $f4, $24, $1e, $30 ; entry 28
    db $f0, $00, $29, $10 ; entry 29
    db $ec, $d4, $11, $10 ; entry 30
    db $f4, $dc, $27, $30 ; entry 31
    db $ec, $dc, $28, $30 ; entry 32
    db $f4, $d4, $1e, $10 ; entry 33
    db $e0, $f4, $18, $10 ; entry 34
    db $80 ; end

; frame 8 of MetaSprites3ESet05; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet05Frame8::
    db $ef, $0e, $00, $30 ; entry 0
    db $d8, $f9, $10, $10 ; entry 1
    db $e0, $f8, $11, $10 ; entry 2
    db $e0, $00, $12, $10 ; entry 3
    db $e8, $f8, $21, $10 ; entry 4
    db $e8, $00, $22, $10 ; entry 5
    db $f0, $f0, $13, $10 ; entry 6
    db $f0, $f8, $14, $10 ; entry 7
    db $f0, $00, $15, $10 ; entry 8
    db $f0, $08, $16, $10 ; entry 9
    db $f8, $f0, $23, $10 ; entry 10
    db $f8, $f8, $24, $10 ; entry 11
    db $f8, $00, $25, $10 ; entry 12
    db $f8, $08, $26, $10 ; entry 13
    db $f8, $e8, $20, $10 ; entry 14
    db $f8, $10, $20, $30 ; entry 15
    db $f0, $d4, $11, $10 ; entry 16
    db $f0, $dc, $12, $10 ; entry 17
    db $e8, $d8, $0a, $30 ; entry 18
    db $f0, $24, $11, $30 ; entry 19
    db $f0, $1c, $12, $30 ; entry 20
    db $e8, $20, $0a, $10 ; entry 21
    db $f8, $24, $0b, $30 ; entry 22
    db $f8, $1c, $0c, $30 ; entry 23
    db $f8, $d4, $0b, $10 ; entry 24
    db $f8, $dc, $0c, $10 ; entry 25
    db $80 ; end

; frame 9 of MetaSprites3ESet05; ends with $80 (E-0147)
MetaSprites3ESet05Frame9::
    db $f7, $ea, $00, $10 ; entry 0
    db $f0, $1c, $17, $10 ; entry 1
    db $f8, $1c, $27, $10 ; entry 2
    db $f0, $dc, $17, $30 ; entry 3
    db $f8, $dc, $27, $30 ; entry 4
    db $e0, $ff, $10, $30 ; entry 5
    db $e8, $00, $11, $30 ; entry 6
    db $e8, $f8, $12, $30 ; entry 7
    db $f0, $00, $21, $30 ; entry 8
    db $f0, $f8, $22, $30 ; entry 9
    db $f8, $08, $13, $30 ; entry 10
    db $f8, $00, $14, $30 ; entry 11
    db $f8, $f8, $15, $30 ; entry 12
    db $f8, $f0, $16, $30 ; entry 13
    db $f8, $d4, $1d, $10 ; entry 14
    db $f8, $24, $1d, $30 ; entry 15
    db $80 ; end

; frame 10 of MetaSprites3ESet05; ends with $80 (E-0147)
MetaSprites3ESet05Frame10::
    db $e8, $f8, $17, $10 ; entry 0
    db $f8, $f8, $24, $10 ; entry 1
    db $f8, $e8, $16, $10 ; entry 2
    db $f8, $f0, $22, $30 ; entry 3
    db $f8, $00, $22, $10 ; entry 4
    db $f8, $08, $1d, $10 ; entry 5
    db $f0, $f8, $11, $10 ; entry 6
    db $f0, $fe, $1e, $70 ; entry 7
    db $80 ; end

; frame 11 of MetaSprites3ESet05; ends with $80 (E-0147)
MetaSprites3ESet05Frame11::
    db $80 ; end

; meta-sprite set 6 of MetaSprites3ETable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3ESet06::
    dw MetaSprites3ESet06Frame0 ; entry 0
    dw MetaSprites3ESet06Frame1 ; entry 1
    dw MetaSprites3ESet06Frame2 ; entry 2
    dw MetaSprites3ESet06Frame3 ; entry 3
    dw MetaSprites3ESet06Frame4 ; entry 4
    dw MetaSprites3ESet06Frame5 ; entry 5
    dw MetaSprites3ESet06Frame5 ; entry 6
    dw MetaSprites3ESet06Frame5 ; entry 7
    dw MetaSprites3ESet06Frame5 ; entry 8
    dw MetaSprites3ESet06Frame5 ; entry 9
    dw MetaSprites3ESet06Frame5 ; entry 10
    dw MetaSprites3ESet06Frame5 ; entry 11
    dw MetaSprites3ESet06Frame5 ; entry 12
    dw MetaSprites3ESet06Frame5 ; entry 13
    dw MetaSprites3ESet06Frame5 ; entry 14
    dw MetaSprites3ESet06Frame5 ; entry 15
    dw MetaSprites3ESet06Frame5 ; entry 16
    dw MetaSprites3ESet06Frame5 ; entry 17
    dw MetaSprites3ESet06Frame5 ; entry 18
    dw MetaSprites3ESet06Frame5 ; entry 19
    dw MetaSprites3ESet06Frame5 ; entry 20
    dw MetaSprites3ESet06Frame5 ; entry 21
    dw MetaSprites3ESet06Frame5 ; entry 22
    dw MetaSprites3ESet06Frame5 ; entry 23
    dw MetaSprites3ESet06Frame5 ; entry 24
    dw MetaSprites3ESet06Frame5 ; entry 25
    dw MetaSprites3ESet06Frame5 ; entry 26
    dw MetaSprites3ESet06Frame5 ; entry 27
    dw MetaSprites3ESet06Frame5 ; entry 28
    dw MetaSprites3ESet06Frame5 ; entry 29
    dw MetaSprites3ESet06Frame5 ; entry 30
    dw MetaSprites3ESet06Frame5 ; entry 31

; frame 0 of MetaSprites3ESet06; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet06Frame0::
    db $e2, $f8, $00, $00 ; entry 0
    db $e2, $00, $01, $00 ; entry 1
    db $ea, $f8, $02, $00 ; entry 2
    db $ea, $00, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites3ESet06; ends with $80 (E-0147)
MetaSprites3ESet06Frame1::
    db $e4, $f8, $07, $00 ; entry 0
    db $e4, $00, $08, $00 ; entry 1
    db $ec, $f8, $09, $00 ; entry 2
    db $ec, $00, $0a, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites3ESet06; ends with $80 (E-0147)
MetaSprites3ESet06Frame2::
    db $e8, $08, $00, $20 ; entry 0
    db $e8, $00, $01, $20 ; entry 1
    db $f0, $08, $02, $20 ; entry 2
    db $f0, $00, $03, $20 ; entry 3
    db $df, $f1, $00, $00 ; entry 4
    db $df, $f9, $01, $00 ; entry 5
    db $e7, $f1, $02, $00 ; entry 6
    db $e7, $f9, $03, $00 ; entry 7
    db $80 ; end

; frame 3 of MetaSprites3ESet06; ends with $80 (E-0147)
MetaSprites3ESet06Frame3::
    db $e2, $00, $0f, $00 ; entry 0
    db $e2, $08, $10, $00 ; entry 1
    db $da, $00, $0c, $00 ; entry 2
    db $da, $f8, $0b, $00 ; entry 3
    db $ea, $ff, $0e, $60 ; entry 4
    db $ea, $f7, $0f, $60 ; entry 5
    db $ea, $ef, $10, $60 ; entry 6
    db $ea, $07, $0d, $60 ; entry 7
    db $f2, $f7, $0c, $60 ; entry 8
    db $f2, $ff, $0b, $60 ; entry 9
    db $e2, $f8, $0e, $00 ; entry 10
    db $e2, $f0, $0d, $00 ; entry 11
    db $80 ; end

; frame 4 of MetaSprites3ESet06; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet06Frame4::
    db $df, $06, $01, $00 ; entry 0
    db $e7, $fe, $02, $00 ; entry 1
    db $e7, $06, $03, $00 ; entry 2
    db $df, $fe, $00, $00 ; entry 3
    db $e6, $ef, $01, $20 ; entry 4
    db $ee, $ef, $03, $20 ; entry 5
    db $ee, $ff, $02, $20 ; entry 6
    db $e6, $f7, $04, $00 ; entry 7
    db $ee, $f7, $05, $00 ; entry 8
    db $80 ; end

; frame 5 of MetaSprites3ESet06; ends with $80 (E-0147)
MetaSprites3ESet06Frame5::
    db $80 ; end

; meta-sprite set 7 of MetaSprites3ETable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3ESet07::
    dw MetaSprites3ESet07Frame0 ; entry 0
    dw MetaSprites3ESet07Frame1 ; entry 1
    dw MetaSprites3ESet07Frame2 ; entry 2
    dw MetaSprites3ESet07Frame3 ; entry 3
    dw MetaSprites3ESet07Frame4 ; entry 4
    dw MetaSprites3ESet07Frame5 ; entry 5
    dw MetaSprites3ESet07Frame6 ; entry 6
    dw MetaSprites3ESet07Frame7 ; entry 7
    dw MetaSprites3ESet07Frame8 ; entry 8
    dw MetaSprites3ESet07Frame9 ; entry 9
    dw MetaSprites3ESet07Frame9 ; entry 10
    dw MetaSprites3ESet07Frame9 ; entry 11
    dw MetaSprites3ESet07Frame9 ; entry 12
    dw MetaSprites3ESet07Frame9 ; entry 13
    dw MetaSprites3ESet07Frame9 ; entry 14
    dw MetaSprites3ESet07Frame9 ; entry 15
    dw MetaSprites3ESet07Frame9 ; entry 16
    dw MetaSprites3ESet07Frame9 ; entry 17
    dw MetaSprites3ESet07Frame9 ; entry 18
    dw MetaSprites3ESet07Frame9 ; entry 19
    dw MetaSprites3ESet07Frame9 ; entry 20
    dw MetaSprites3ESet07Frame9 ; entry 21
    dw MetaSprites3ESet07Frame9 ; entry 22
    dw MetaSprites3ESet07Frame9 ; entry 23
    dw MetaSprites3ESet07Frame9 ; entry 24
    dw MetaSprites3ESet07Frame9 ; entry 25
    dw MetaSprites3ESet07Frame9 ; entry 26
    dw MetaSprites3ESet07Frame9 ; entry 27
    dw MetaSprites3ESet07Frame9 ; entry 28
    dw MetaSprites3ESet07Frame9 ; entry 29
    dw MetaSprites3ESet07Frame9 ; entry 30
    dw MetaSprites3ESet07Frame9 ; entry 31

; frame 0 of MetaSprites3ESet07; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet07Frame0::
    db $d0, $e8, $19, $00 ; entry 0
    db $d0, $f0, $1a, $00 ; entry 1
    db $d0, $f8, $1b, $00 ; entry 2
    db $d0, $10, $19, $20 ; entry 3
    db $d0, $08, $1a, $20 ; entry 4
    db $d0, $00, $1b, $20 ; entry 5
    db $f8, $e8, $19, $40 ; entry 6
    db $f8, $f0, $1a, $40 ; entry 7
    db $f8, $f8, $1b, $40 ; entry 8
    db $f8, $10, $19, $60 ; entry 9
    db $f8, $08, $1a, $60 ; entry 10
    db $f8, $00, $1b, $60 ; entry 11
    db $d8, $e8, $1c, $00 ; entry 12
    db $d8, $f0, $1d, $00 ; entry 13
    db $d8, $10, $1c, $20 ; entry 14
    db $d8, $08, $1d, $20 ; entry 15
    db $f0, $10, $1c, $60 ; entry 16
    db $f0, $08, $1d, $60 ; entry 17
    db $f0, $e8, $1c, $40 ; entry 18
    db $f0, $f0, $1d, $40 ; entry 19
    db $e0, $e8, $1e, $00 ; entry 20
    db $e8, $e8, $1e, $40 ; entry 21
    db $e0, $10, $1e, $20 ; entry 22
    db $e8, $10, $1e, $60 ; entry 23
    db $80 ; end

; frame 1 of MetaSprites3ESet07; ends with $80 (E-0147)
MetaSprites3ESet07Frame1::
    db $dc, $f0, $19, $00 ; entry 0
    db $dc, $f8, $1a, $00 ; entry 1
    db $e4, $f0, $1c, $00 ; entry 2
    db $e4, $f8, $1d, $00 ; entry 3
    db $dc, $08, $19, $20 ; entry 4
    db $dc, $00, $1a, $20 ; entry 5
    db $e4, $08, $1c, $20 ; entry 6
    db $e4, $00, $1d, $20 ; entry 7
    db $f4, $08, $19, $60 ; entry 8
    db $f4, $00, $1a, $60 ; entry 9
    db $ec, $08, $1c, $60 ; entry 10
    db $ec, $00, $1d, $60 ; entry 11
    db $f4, $f0, $19, $40 ; entry 12
    db $f4, $f8, $1a, $40 ; entry 13
    db $ec, $f0, $1c, $40 ; entry 14
    db $ec, $f8, $1d, $40 ; entry 15
    db $80 ; end

; frame 2 of MetaSprites3ESet07; ends with $80 (E-0147)
MetaSprites3ESet07Frame2::
    db $ec, $f8, $19, $40 ; entry 0
    db $ec, $00, $19, $60 ; entry 1
    db $e4, $00, $19, $20 ; entry 2
    db $e4, $f8, $19, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites3ESet07; ends with $80 (E-0147)
MetaSprites3ESet07Frame3::
    db $df, $06, $01, $00 ; entry 0
    db $e7, $fe, $02, $00 ; entry 1
    db $e7, $06, $03, $00 ; entry 2
    db $df, $fe, $00, $00 ; entry 3
    db $e6, $ef, $01, $20 ; entry 4
    db $ee, $ef, $03, $20 ; entry 5
    db $ee, $ff, $02, $20 ; entry 6
    db $e6, $f7, $04, $00 ; entry 7
    db $ee, $f7, $05, $00 ; entry 8
    db $80 ; end

; frame 4 of MetaSprites3ESet07; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet07Frame4::
    db $e2, $00, $0f, $00 ; entry 0
    db $e2, $08, $10, $00 ; entry 1
    db $da, $00, $0c, $00 ; entry 2
    db $da, $f8, $0b, $00 ; entry 3
    db $ea, $ff, $0e, $60 ; entry 4
    db $ea, $f7, $0f, $60 ; entry 5
    db $ea, $ef, $10, $60 ; entry 6
    db $ea, $07, $0d, $60 ; entry 7
    db $f2, $f7, $0c, $60 ; entry 8
    db $f2, $ff, $0b, $60 ; entry 9
    db $e2, $f8, $0e, $00 ; entry 10
    db $e2, $f0, $0d, $00 ; entry 11
    db $80 ; end

; frame 5 of MetaSprites3ESet07; ends with $80 (E-0147)
MetaSprites3ESet07Frame5::
    db $e8, $08, $00, $20 ; entry 0
    db $e8, $00, $01, $20 ; entry 1
    db $f0, $08, $02, $20 ; entry 2
    db $f0, $00, $03, $20 ; entry 3
    db $d5, $f9, $00, $00 ; entry 4
    db $d5, $01, $01, $00 ; entry 5
    db $dd, $f9, $02, $00 ; entry 6
    db $dd, $01, $03, $00 ; entry 7
    db $e4, $07, $02, $00 ; entry 8
    db $e4, $0f, $03, $00 ; entry 9
    db $dc, $11, $00, $20 ; entry 10
    db $dc, $09, $01, $20 ; entry 11
    db $df, $ee, $00, $00 ; entry 12
    db $df, $f6, $01, $00 ; entry 13
    db $e7, $ee, $02, $00 ; entry 14
    db $e7, $f6, $03, $00 ; entry 15
    db $ef, $fd, $00, $20 ; entry 16
    db $ef, $f5, $01, $20 ; entry 17
    db $f7, $fd, $02, $20 ; entry 18
    db $f7, $f5, $03, $20 ; entry 19
    db $80 ; end

; frame 6 of MetaSprites3ESet07; ends with $80 (E-0147)
MetaSprites3ESet07Frame6::
    db $f0, $fb, $07, $00 ; entry 0
    db $f0, $03, $08, $00 ; entry 1
    db $f8, $fb, $09, $00 ; entry 2
    db $f8, $03, $0a, $00 ; entry 3
    db $e3, $e8, $07, $00 ; entry 4
    db $e3, $f0, $08, $00 ; entry 5
    db $eb, $e8, $09, $00 ; entry 6
    db $eb, $f0, $0a, $00 ; entry 7
    db $ec, $10, $07, $20 ; entry 8
    db $ec, $08, $08, $20 ; entry 9
    db $f4, $10, $09, $20 ; entry 10
    db $f4, $08, $0a, $20 ; entry 11
    db $d8, $06, $07, $20 ; entry 12
    db $d8, $fe, $08, $20 ; entry 13
    db $e0, $06, $09, $20 ; entry 14
    db $e0, $fe, $0a, $20 ; entry 15
    db $80 ; end

; frame 7 of MetaSprites3ESet07; ends with $80 (E-0147)
MetaSprites3ESet07Frame7::
    db $da, $ef, $00, $00 ; entry 0
    db $da, $f7, $01, $00 ; entry 1
    db $e2, $ef, $02, $00 ; entry 2
    db $e2, $f7, $03, $00 ; entry 3
    db $e7, $05, $02, $00 ; entry 4
    db $e7, $0d, $03, $00 ; entry 5
    db $df, $0f, $00, $20 ; entry 6
    db $df, $07, $01, $20 ; entry 7
    db $f4, $fa, $03, $00 ; entry 8
    db $f4, $f2, $03, $20 ; entry 9
    db $ec, $fa, $06, $00 ; entry 10
    db $ec, $f2, $01, $20 ; entry 11
    db $ef, $01, $02, $20 ; entry 12
    db $80 ; end

; frame 8 of MetaSprites3ESet07; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet07Frame8::
    db $d8, $f9, $0f, $00 ; entry 0
    db $d8, $01, $10, $00 ; entry 1
    db $d0, $f9, $0c, $00 ; entry 2
    db $d0, $f1, $0b, $00 ; entry 3
    db $e0, $f8, $0e, $60 ; entry 4
    db $e0, $f0, $0f, $60 ; entry 5
    db $e0, $e8, $10, $60 ; entry 6
    db $e0, $00, $0d, $60 ; entry 7
    db $e8, $f0, $0c, $60 ; entry 8
    db $e8, $f8, $0b, $60 ; entry 9
    db $d8, $f1, $0e, $00 ; entry 10
    db $d8, $e9, $0d, $00 ; entry 11
    db $e8, $09, $0f, $00 ; entry 12
    db $e8, $11, $10, $00 ; entry 13
    db $e0, $09, $0c, $00 ; entry 14
    db $e0, $01, $0b, $00 ; entry 15
    db $f0, $08, $0e, $60 ; entry 16
    db $f0, $00, $0f, $60 ; entry 17
    db $f0, $f8, $10, $60 ; entry 18
    db $f0, $10, $0d, $60 ; entry 19
    db $f8, $00, $0c, $60 ; entry 20
    db $f8, $08, $0b, $60 ; entry 21
    db $e8, $01, $0e, $00 ; entry 22
    db $e8, $f9, $0d, $00 ; entry 23
    db $80 ; end

; frame 9 of MetaSprites3ESet07; ends with $80 (E-0147)
MetaSprites3ESet07Frame9::
    db $80 ; end

; meta-sprite set 8 of MetaSprites3ETable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3ESet08::
    dw MetaSprites3ESet08Frame0 ; entry 0
    dw MetaSprites3ESet08Frame1 ; entry 1
    dw MetaSprites3ESet08Frame2 ; entry 2
    dw MetaSprites3ESet08Frame3 ; entry 3
    dw MetaSprites3ESet08Frame4 ; entry 4
    dw MetaSprites3ESet08Frame5 ; entry 5
    dw MetaSprites3ESet08Frame6 ; entry 6
    dw MetaSprites3ESet08Frame7 ; entry 7
    dw MetaSprites3ESet08Frame8 ; entry 8
    dw MetaSprites3ESet08Frame9 ; entry 9
    dw MetaSprites3ESet08Frame10 ; entry 10
    dw MetaSprites3ESet08Frame11 ; entry 11
    dw MetaSprites3ESet08Frame12 ; entry 12
    dw MetaSprites3ESet08Frame13 ; entry 13
    dw MetaSprites3ESet08Frame14 ; entry 14
    dw MetaSprites3ESet08Frame15 ; entry 15
    dw MetaSprites3ESet08Frame16 ; entry 16
    dw MetaSprites3ESet08Frame17 ; entry 17
    dw MetaSprites3ESet08Frame18 ; entry 18
    dw MetaSprites3ESet08Frame19 ; entry 19
    dw MetaSprites3ESet08Frame20 ; entry 20
    dw MetaSprites3ESet08Frame20 ; entry 21
    dw MetaSprites3ESet08Frame20 ; entry 22
    dw MetaSprites3ESet08Frame20 ; entry 23
    dw MetaSprites3ESet08Frame20 ; entry 24
    dw MetaSprites3ESet08Frame20 ; entry 25
    dw MetaSprites3ESet08Frame20 ; entry 26
    dw MetaSprites3ESet08Frame20 ; entry 27
    dw MetaSprites3ESet08Frame20 ; entry 28
    dw MetaSprites3ESet08Frame20 ; entry 29
    dw MetaSprites3ESet08Frame20 ; entry 30
    dw MetaSprites3ESet08Frame20 ; entry 31

; frame 0 of MetaSprites3ESet08; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet08Frame0::
    db $f8, $48, $19, $60 ; entry 0
    db $d0, $48, $19, $20 ; entry 1
    db $e8, $44, $1b, $40 ; entry 2
    db $f0, $40, $1b, $40 ; entry 3
    db $e0, $44, $1b, $00 ; entry 4
    db $d8, $40, $1b, $00 ; entry 5
    db $f8, $b0, $19, $40 ; entry 6
    db $d0, $b0, $19, $00 ; entry 7
    db $d8, $b8, $1b, $20 ; entry 8
    db $e0, $b4, $1b, $20 ; entry 9
    db $f0, $b8, $1b, $60 ; entry 10
    db $e8, $b4, $1b, $60 ; entry 11
    db $d0, $e0, $1a, $00 ; entry 12
    db $d0, $d0, $1a, $00 ; entry 13
    db $d0, $c0, $1a, $00 ; entry 14
    db $f8, $e0, $1a, $40 ; entry 15
    db $f8, $d0, $1a, $40 ; entry 16
    db $f8, $c0, $1a, $40 ; entry 17
    db $d0, $28, $1a, $20 ; entry 18
    db $f8, $28, $1a, $60 ; entry 19
    db $d0, $18, $1a, $20 ; entry 20
    db $f8, $18, $1a, $60 ; entry 21
    db $d0, $38, $1a, $20 ; entry 22
    db $f8, $38, $1a, $60 ; entry 23
    db $d8, $30, $19, $20 ; entry 24
    db $f0, $30, $19, $60 ; entry 25
    db $d8, $c8, $19, $00 ; entry 26
    db $f0, $c8, $19, $40 ; entry 27
    db $dc, $c0, $1b, $20 ; entry 28
    db $ec, $c0, $1b, $60 ; entry 29
    db $dc, $38, $1b, $00 ; entry 30
    db $ec, $38, $1b, $40 ; entry 31
    db $e0, $cc, $1b, $20 ; entry 32
    db $e8, $cc, $1b, $60 ; entry 33
    db $e8, $2c, $1b, $40 ; entry 34
    db $e0, $2c, $1b, $00 ; entry 35
    db $d0, $f0, $1c, $00 ; entry 36
    db $d0, $08, $1c, $20 ; entry 37
    db $f8, $f0, $1c, $40 ; entry 38
    db $f8, $08, $1c, $60 ; entry 39
    db $80 ; end

; frame 1 of MetaSprites3ESet08; ends with $80 (E-0147)
MetaSprites3ESet08Frame1::
    db $d0, $10, $1a, $20 ; entry 0
    db $d0, $20, $1a, $20 ; entry 1
    db $f8, $10, $1a, $60 ; entry 2
    db $f8, $20, $1a, $60 ; entry 3
    db $d0, $e8, $1a, $00 ; entry 4
    db $d0, $d8, $1a, $00 ; entry 5
    db $f8, $e8, $1a, $40 ; entry 6
    db $f8, $d8, $1a, $40 ; entry 7
    db $d0, $d0, $19, $00 ; entry 8
    db $d8, $d0, $1b, $20 ; entry 9
    db $e0, $d4, $1b, $20 ; entry 10
    db $f0, $d0, $1b, $60 ; entry 11
    db $e8, $d4, $1b, $60 ; entry 12
    db $f8, $d0, $19, $40 ; entry 13
    db $f8, $28, $19, $60 ; entry 14
    db $d0, $28, $19, $20 ; entry 15
    db $e8, $24, $1b, $40 ; entry 16
    db $f0, $28, $1b, $40 ; entry 17
    db $e0, $24, $1b, $00 ; entry 18
    db $d8, $28, $1b, $00 ; entry 19
    db $d0, $f8, $1c, $00 ; entry 20
    db $f8, $00, $1c, $60 ; entry 21
    db $f8, $f8, $1c, $40 ; entry 22
    db $d0, $00, $1c, $20 ; entry 23
    db $d8, $dc, $19, $00 ; entry 24
    db $f0, $dc, $19, $40 ; entry 25
    db $e0, $e0, $1b, $20 ; entry 26
    db $e8, $e0, $1b, $60 ; entry 27
    db $f0, $1c, $19, $60 ; entry 28
    db $d8, $1c, $19, $20 ; entry 29
    db $e8, $18, $1b, $40 ; entry 30
    db $e0, $18, $1b, $00 ; entry 31
    db $80 ; end

; frame 2 of MetaSprites3ESet08; ends with $80 (E-0147)
MetaSprites3ESet08Frame2::
    db $f0, $e8, $19, $40 ; entry 0
    db $d8, $e8, $19, $00 ; entry 1
    db $e0, $e8, $1b, $20 ; entry 2
    db $e8, $e8, $1b, $60 ; entry 3
    db $d8, $00, $1c, $20 ; entry 4
    db $d8, $08, $1a, $20 ; entry 5
    db $d8, $f8, $1c, $00 ; entry 6
    db $d8, $f0, $1a, $00 ; entry 7
    db $f0, $00, $1c, $60 ; entry 8
    db $f0, $f8, $1c, $40 ; entry 9
    db $f0, $f0, $1a, $40 ; entry 10
    db $d8, $10, $19, $20 ; entry 11
    db $e0, $10, $1b, $00 ; entry 12
    db $f0, $10, $19, $60 ; entry 13
    db $e8, $10, $1b, $40 ; entry 14
    db $f8, $18, $19, $60 ; entry 15
    db $f8, $e0, $19, $40 ; entry 16
    db $d0, $e0, $19, $00 ; entry 17
    db $d0, $08, $1a, $20 ; entry 18
    db $d0, $f0, $1a, $00 ; entry 19
    db $f8, $f0, $1a, $40 ; entry 20
    db $f8, $08, $1a, $60 ; entry 21
    db $d0, $18, $19, $20 ; entry 22
    db $e0, $f0, $1a, $00 ; entry 23
    db $e8, $f0, $1a, $40 ; entry 24
    db $e0, $08, $1a, $20 ; entry 25
    db $f0, $08, $1a, $60 ; entry 26
    db $e8, $08, $1a, $60 ; entry 27
    db $dc, $e0, $1b, $20 ; entry 28
    db $ec, $e0, $1b, $60 ; entry 29
    db $dc, $18, $1b, $00 ; entry 30
    db $ec, $18, $1b, $40 ; entry 31
    db $d4, $d4, $19, $00 ; entry 32
    db $f4, $d4, $19, $40 ; entry 33
    db $d4, $24, $19, $20 ; entry 34
    db $f4, $24, $19, $60 ; entry 35
    db $80 ; end

; frame 3 of MetaSprites3ESet08; ends with $80 (E-0147)
MetaSprites3ESet08Frame3::
    db $e8, $f8, $19, $40 ; entry 0
    db $e8, $00, $19, $60 ; entry 1
    db $e0, $00, $19, $20 ; entry 2
    db $e0, $f8, $19, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites3ESet08; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet08Frame4::
    db $e8, $00, $02, $20 ; entry 0
    db $e8, $f8, $03, $20 ; entry 1
    db $e0, $f8, $02, $40 ; entry 2
    db $e0, $00, $03, $40 ; entry 3
    db $de, $08, $28, $00 ; entry 4
    db $de, $10, $29, $00 ; entry 5
    db $d9, $f3, $21, $00 ; entry 6
    db $ef, $fb, $20, $60 ; entry 7
    db $80 ; end

; frame 5 of MetaSprites3ESet08; ends with $80 (E-0147)
MetaSprites3ESet08Frame5::
    db $e8, $f0, $2d, $20 ; entry 0
    db $e8, $e8, $2e, $20 ; entry 1
    db $e8, $00, $2c, $00 ; entry 2
    db $e8, $08, $2d, $00 ; entry 3
    db $e8, $10, $2e, $00 ; entry 4
    db $e8, $f8, $2b, $00 ; entry 5
    db $e0, $e8, $22, $00 ; entry 6
    db $e0, $f0, $23, $00 ; entry 7
    db $e0, $f8, $24, $00 ; entry 8
    db $e0, $00, $25, $00 ; entry 9
    db $e0, $08, $26, $00 ; entry 10
    db $e0, $10, $27, $00 ; entry 11
    db $db, $18, $28, $00 ; entry 12
    db $db, $20, $29, $00 ; entry 13
    db $d8, $e8, $21, $00 ; entry 14
    db $d8, $f0, $2f, $00 ; entry 15
    db $d8, $f8, $1d, $00 ; entry 16
    db $d8, $00, $1e, $00 ; entry 17
    db $d8, $08, $1f, $00 ; entry 18
    db $f0, $10, $22, $60 ; entry 19
    db $f0, $08, $23, $60 ; entry 20
    db $f0, $00, $24, $60 ; entry 21
    db $f0, $f8, $25, $60 ; entry 22
    db $f0, $f0, $26, $60 ; entry 23
    db $f0, $e8, $27, $60 ; entry 24
    db $f8, $10, $21, $60 ; entry 25
    db $f8, $08, $2f, $60 ; entry 26
    db $f8, $00, $1d, $60 ; entry 27
    db $f8, $f0, $1f, $60 ; entry 28
    db $f5, $e0, $28, $60 ; entry 29
    db $f5, $d8, $29, $60 ; entry 30
    db $f8, $f8, $1e, $60 ; entry 31
    db $d0, $00, $20, $00 ; entry 32
    db $80 ; end

; frame 6 of MetaSprites3ESet08; ends with $80 (E-0147)
MetaSprites3ESet08Frame6::
    db $e0, $f0, $15, $00 ; entry 0
    db $e0, $f8, $16, $00 ; entry 1
    db $e0, $00, $17, $00 ; entry 2
    db $e0, $08, $18, $00 ; entry 3
    db $d8, $f5, $11, $00 ; entry 4
    db $d8, $fd, $12, $00 ; entry 5
    db $e8, $08, $15, $60 ; entry 6
    db $e8, $00, $16, $60 ; entry 7
    db $e8, $f8, $17, $60 ; entry 8
    db $e8, $f0, $18, $60 ; entry 9
    db $f0, $03, $11, $60 ; entry 10
    db $f0, $fb, $12, $60 ; entry 11
    db $e0, $e8, $0f, $40 ; entry 12
    db $d8, $e7, $0e, $20 ; entry 13
    db $d8, $df, $0f, $20 ; entry 14
    db $e0, $e0, $0e, $40 ; entry 15
    db $d0, $e7, $0b, $20 ; entry 16
    db $d0, $df, $0c, $20 ; entry 17
    db $d8, $d8, $10, $20 ; entry 18
    db $e0, $d8, $0d, $40 ; entry 19
    db $f0, $eb, $07, $00 ; entry 20
    db $f0, $f3, $08, $00 ; entry 21
    db $f8, $eb, $09, $00 ; entry 22
    db $f8, $f3, $0a, $00 ; entry 23
    db $e0, $21, $0f, $40 ; entry 24
    db $e0, $29, $10, $40 ; entry 25
    db $d8, $20, $0e, $20 ; entry 26
    db $d8, $18, $0f, $20 ; entry 27
    db $d8, $10, $10, $20 ; entry 28
    db $d8, $28, $0d, $20 ; entry 29
    db $d0, $18, $0c, $20 ; entry 30
    db $d0, $20, $0b, $20 ; entry 31
    db $e0, $19, $0e, $40 ; entry 32
    db $e0, $11, $0d, $40 ; entry 33
    db $f0, $20, $07, $60 ; entry 34
    db $f0, $18, $08, $60 ; entry 35
    db $e8, $20, $09, $60 ; entry 36
    db $e8, $18, $0a, $60 ; entry 37
    db $e8, $e0, $0b, $40 ; entry 38
    db $e8, $e8, $0c, $40 ; entry 39
    db $80 ; end

; frame 7 of MetaSprites3ESet08; ends with $80 (E-0147)
MetaSprites3ESet08Frame7::
    db $e8, $08, $2d, $00 ; entry 0
    db $e8, $10, $2e, $00 ; entry 1
    db $e8, $f8, $2c, $20 ; entry 2
    db $e8, $f0, $2d, $20 ; entry 3
    db $e8, $e8, $2e, $20 ; entry 4
    db $e8, $00, $2b, $20 ; entry 5
    db $e0, $10, $22, $20 ; entry 6
    db $e0, $08, $23, $20 ; entry 7
    db $e0, $00, $24, $20 ; entry 8
    db $e0, $f8, $25, $20 ; entry 9
    db $e0, $f0, $26, $20 ; entry 10
    db $e0, $e8, $27, $20 ; entry 11
    db $db, $e0, $28, $20 ; entry 12
    db $db, $d8, $29, $20 ; entry 13
    db $d8, $10, $21, $20 ; entry 14
    db $d8, $08, $2f, $20 ; entry 15
    db $d8, $00, $1d, $20 ; entry 16
    db $d8, $f8, $1e, $20 ; entry 17
    db $d8, $f0, $1f, $20 ; entry 18
    db $f0, $e8, $22, $40 ; entry 19
    db $f0, $f0, $23, $40 ; entry 20
    db $f0, $f8, $24, $40 ; entry 21
    db $f0, $00, $25, $40 ; entry 22
    db $f0, $08, $26, $40 ; entry 23
    db $f0, $10, $27, $40 ; entry 24
    db $f8, $e8, $21, $40 ; entry 25
    db $f8, $f0, $2f, $40 ; entry 26
    db $f8, $f8, $1d, $40 ; entry 27
    db $f8, $08, $1f, $40 ; entry 28
    db $f5, $18, $28, $40 ; entry 29
    db $f5, $20, $29, $40 ; entry 30
    db $f8, $00, $1e, $40 ; entry 31
    db $d0, $f8, $20, $20 ; entry 32
    db $80 ; end

; frame 8 of MetaSprites3ESet08; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet08Frame8::
    db $e0, $29, $0f, $00 ; entry 0
    db $e0, $31, $10, $00 ; entry 1
    db $e8, $28, $0e, $60 ; entry 2
    db $e8, $20, $0f, $60 ; entry 3
    db $e8, $18, $10, $60 ; entry 4
    db $e8, $30, $0d, $60 ; entry 5
    db $f0, $20, $0c, $60 ; entry 6
    db $e0, $21, $0e, $00 ; entry 7
    db $e0, $19, $0d, $00 ; entry 8
    db $e5, $fe, $08, $20 ; entry 9
    db $ed, $06, $09, $20 ; entry 10
    db $ed, $fe, $0a, $20 ; entry 11
    db $d0, $10, $07, $20 ; entry 12
    db $d0, $08, $08, $20 ; entry 13
    db $d8, $10, $09, $20 ; entry 14
    db $d8, $08, $0a, $20 ; entry 15
    db $f0, $28, $09, $20 ; entry 16
    db $e5, $06, $07, $20 ; entry 17
    db $e8, $ea, $0f, $20 ; entry 18
    db $e8, $e2, $10, $20 ; entry 19
    db $f0, $eb, $0e, $40 ; entry 20
    db $f0, $f3, $0f, $40 ; entry 21
    db $f0, $fb, $10, $40 ; entry 22
    db $f0, $e3, $0d, $40 ; entry 23
    db $e8, $f2, $0e, $20 ; entry 24
    db $e8, $fa, $0d, $20 ; entry 25
    db $f8, $eb, $0b, $40 ; entry 26
    db $f8, $f3, $0c, $40 ; entry 27
    db $e0, $f2, $0b, $20 ; entry 28
    db $e0, $ea, $0c, $20 ; entry 29
    db $d0, $30, $07, $20 ; entry 30
    db $d0, $28, $08, $20 ; entry 31
    db $d8, $30, $09, $20 ; entry 32
    db $d8, $28, $0a, $20 ; entry 33
    db $d8, $22, $0c, $20 ; entry 34
    db $80 ; end

; frame 9 of MetaSprites3ESet08; ends with $80 (E-0147)
MetaSprites3ESet08Frame9::
    db $d4, $2e, $01, $00 ; entry 0
    db $dc, $26, $02, $00 ; entry 1
    db $dc, $2e, $03, $00 ; entry 2
    db $d4, $26, $00, $00 ; entry 3
    db $e7, $15, $01, $20 ; entry 4
    db $ef, $15, $03, $20 ; entry 5
    db $ef, $25, $02, $20 ; entry 6
    db $e7, $1d, $04, $00 ; entry 7
    db $ef, $1d, $05, $00 ; entry 8
    db $e7, $25, $01, $00 ; entry 9
    db $db, $0d, $00, $20 ; entry 10
    db $db, $05, $01, $20 ; entry 11
    db $e3, $0d, $02, $20 ; entry 12
    db $e3, $05, $03, $20 ; entry 13
    db $f7, $2b, $02, $00 ; entry 14
    db $f7, $33, $03, $00 ; entry 15
    db $ef, $2b, $00, $00 ; entry 16
    db $ef, $33, $01, $00 ; entry 17
    db $f0, $ff, $00, $00 ; entry 18
    db $f0, $07, $01, $00 ; entry 19
    db $f8, $ff, $02, $00 ; entry 20
    db $f8, $07, $03, $00 ; entry 21
    db $e3, $40, $07, $20 ; entry 22
    db $e3, $38, $08, $20 ; entry 23
    db $eb, $40, $09, $20 ; entry 24
    db $eb, $38, $0a, $20 ; entry 25
    db $db, $1d, $07, $20 ; entry 26
    db $db, $15, $08, $20 ; entry 27
    db $e3, $1d, $09, $20 ; entry 28
    db $e3, $15, $0a, $20 ; entry 29
    db $80 ; end

; frame 10 of MetaSprites3ESet08; ends with $80 (E-0147)
MetaSprites3ESet08Frame10::
    db $ec, $38, $0e, $40 ; entry 0
    db $ec, $40, $0f, $40 ; entry 1
    db $ec, $48, $10, $40 ; entry 2
    db $ec, $30, $0d, $40 ; entry 3
    db $f4, $40, $0c, $40 ; entry 4
    db $f4, $38, $09, $00 ; entry 5
    db $f4, $1d, $07, $40 ; entry 6
    db $f4, $25, $08, $40 ; entry 7
    db $ec, $1d, $09, $40 ; entry 8
    db $ec, $25, $0a, $40 ; entry 9
    db $f0, $08, $07, $00 ; entry 10
    db $f0, $10, $08, $00 ; entry 11
    db $f8, $08, $09, $00 ; entry 12
    db $f8, $10, $0a, $00 ; entry 13
    db $ec, $17, $11, $60 ; entry 14
    db $ec, $0f, $12, $60 ; entry 15
    db $d4, $08, $11, $00 ; entry 16
    db $d4, $10, $12, $00 ; entry 17
    db $d4, $1c, $14, $00 ; entry 18
    db $dc, $04, $15, $00 ; entry 19
    db $dc, $0c, $16, $00 ; entry 20
    db $dc, $14, $17, $00 ; entry 21
    db $dc, $1c, $18, $00 ; entry 22
    db $e4, $1c, $15, $60 ; entry 23
    db $e4, $14, $16, $60 ; entry 24
    db $e4, $0c, $17, $60 ; entry 25
    db $e4, $04, $18, $60 ; entry 26
    db $dc, $2c, $07, $20 ; entry 27
    db $dc, $24, $08, $20 ; entry 28
    db $e4, $2c, $09, $20 ; entry 29
    db $e4, $24, $0a, $20 ; entry 30
    db $e4, $3f, $0e, $20 ; entry 31
    db $e4, $37, $0f, $20 ; entry 32
    db $e4, $47, $0d, $20 ; entry 33
    db $dc, $3f, $0b, $20 ; entry 34
    db $dc, $37, $0c, $20 ; entry 35
    db $80 ; end

; frame 11 of MetaSprites3ESet08; ends with $80 (E-0147)
MetaSprites3ESet08Frame11::
    db $d8, $0c, $02, $00 ; entry 0
    db $d8, $14, $03, $00 ; entry 1
    db $d0, $0c, $00, $00 ; entry 2
    db $e3, $25, $01, $00 ; entry 3
    db $eb, $25, $03, $00 ; entry 4
    db $eb, $15, $02, $00 ; entry 5
    db $e3, $1d, $04, $20 ; entry 6
    db $eb, $1d, $05, $20 ; entry 7
    db $e3, $15, $01, $20 ; entry 8
    db $f3, $0f, $02, $20 ; entry 9
    db $f3, $07, $03, $20 ; entry 10
    db $eb, $07, $01, $20 ; entry 11
    db $f0, $2a, $07, $20 ; entry 12
    db $f0, $22, $08, $20 ; entry 13
    db $f8, $2a, $09, $20 ; entry 14
    db $f8, $22, $0a, $20 ; entry 15
    db $d3, $31, $00, $00 ; entry 16
    db $d3, $39, $01, $00 ; entry 17
    db $db, $31, $02, $00 ; entry 18
    db $db, $39, $03, $00 ; entry 19
    db $d7, $24, $07, $20 ; entry 20
    db $d7, $1c, $08, $20 ; entry 21
    db $df, $24, $09, $20 ; entry 22
    db $df, $1c, $0a, $20 ; entry 23
    db $ea, $2d, $02, $00 ; entry 24
    db $e2, $2d, $2f, $00 ; entry 25
    db $e2, $35, $04, $00 ; entry 26
    db $ea, $35, $2d, $40 ; entry 27
    db $e8, $3d, $05, $00 ; entry 28
    db $e0, $3d, $04, $00 ; entry 29
    db $e8, $45, $2e, $40 ; entry 30
    db $eb, $0f, $0c, $00 ; entry 31
    db $d0, $14, $07, $20 ; entry 32
    db $e0, $45, $28, $00 ; entry 33
    db $80 ; end

; frame 12 of MetaSprites3ESet08; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet08Frame12::
    db $dc, $40, $0e, $00 ; entry 0
    db $dc, $48, $0f, $00 ; entry 1
    db $dc, $38, $0d, $00 ; entry 2
    db $d4, $48, $0c, $00 ; entry 3
    db $e4, $47, $0e, $60 ; entry 4
    db $e4, $3f, $0f, $60 ; entry 5
    db $ec, $47, $0b, $60 ; entry 6
    db $ec, $3f, $0c, $60 ; entry 7
    db $d4, $40, $0b, $00 ; entry 8
    db $e0, $30, $11, $20 ; entry 9
    db $e0, $28, $12, $20 ; entry 10
    db $f8, $21, $11, $40 ; entry 11
    db $f8, $29, $12, $40 ; entry 12
    db $f8, $35, $14, $40 ; entry 13
    db $f0, $1d, $15, $40 ; entry 14
    db $f0, $25, $16, $40 ; entry 15
    db $f0, $2d, $17, $40 ; entry 16
    db $f0, $35, $18, $40 ; entry 17
    db $e8, $35, $15, $20 ; entry 18
    db $e8, $2d, $16, $20 ; entry 19
    db $e8, $25, $17, $20 ; entry 20
    db $e8, $1d, $18, $20 ; entry 21
    db $d8, $24, $07, $40 ; entry 22
    db $d8, $2c, $08, $40 ; entry 23
    db $d0, $24, $09, $40 ; entry 24
    db $d0, $2c, $0a, $40 ; entry 25
    db $f0, $0d, $07, $40 ; entry 26
    db $f0, $15, $08, $40 ; entry 27
    db $e8, $0d, $09, $40 ; entry 28
    db $e8, $15, $0a, $40 ; entry 29
    db $f0, $47, $07, $20 ; entry 30
    db $f0, $3f, $08, $20 ; entry 31
    db $f8, $47, $09, $20 ; entry 32
    db $f8, $3f, $0a, $20 ; entry 33
    db $80 ; end

; frame 13 of MetaSprites3ESet08; ends with $80 (E-0147)
MetaSprites3ESet08Frame13::
    db $d0, $43, $11, $20 ; entry 0
    db $d0, $3b, $12, $20 ; entry 1
    db $e8, $34, $11, $40 ; entry 2
    db $e8, $3c, $12, $40 ; entry 3
    db $e8, $48, $14, $40 ; entry 4
    db $e0, $30, $15, $40 ; entry 5
    db $e0, $38, $16, $40 ; entry 6
    db $e0, $40, $17, $40 ; entry 7
    db $e0, $48, $18, $40 ; entry 8
    db $d8, $48, $15, $20 ; entry 9
    db $d8, $40, $16, $20 ; entry 10
    db $d8, $38, $17, $20 ; entry 11
    db $d8, $30, $18, $20 ; entry 12
    db $e1, $24, $0e, $00 ; entry 13
    db $e1, $2c, $0f, $00 ; entry 14
    db $e9, $2b, $0e, $60 ; entry 15
    db $e9, $23, $0f, $60 ; entry 16
    db $f1, $2b, $0b, $60 ; entry 17
    db $f1, $23, $0c, $60 ; entry 18
    db $d9, $24, $0b, $00 ; entry 19
    db $e0, $1c, $0d, $00 ; entry 20
    db $e0, $18, $07, $20 ; entry 21
    db $e0, $10, $08, $20 ; entry 22
    db $e8, $18, $09, $20 ; entry 23
    db $e8, $10, $0a, $20 ; entry 24
    db $d0, $28, $07, $40 ; entry 25
    db $d0, $30, $08, $40 ; entry 26
    db $f8, $2a, $09, $40 ; entry 27
    db $f8, $32, $0a, $40 ; entry 28
    db $80 ; end

; frame 14 of MetaSprites3ESet08; ends with $80 (E-0147)
MetaSprites3ESet08Frame14::
    db $e0, $d0, $0f, $20 ; entry 0
    db $e0, $c8, $10, $20 ; entry 1
    db $e8, $d1, $0e, $40 ; entry 2
    db $e8, $d9, $0f, $40 ; entry 3
    db $e8, $e1, $10, $40 ; entry 4
    db $e8, $c9, $0d, $40 ; entry 5
    db $f0, $d9, $0c, $40 ; entry 6
    db $e0, $d8, $0e, $20 ; entry 7
    db $e0, $e0, $0d, $20 ; entry 8
    db $e5, $fb, $08, $00 ; entry 9
    db $ed, $f3, $09, $00 ; entry 10
    db $ed, $fb, $0a, $00 ; entry 11
    db $d0, $e9, $07, $00 ; entry 12
    db $d0, $f1, $08, $00 ; entry 13
    db $d8, $e9, $09, $00 ; entry 14
    db $d8, $f1, $0a, $00 ; entry 15
    db $f0, $d1, $09, $00 ; entry 16
    db $e5, $f3, $07, $00 ; entry 17
    db $e8, $0f, $0f, $00 ; entry 18
    db $e8, $17, $10, $00 ; entry 19
    db $f0, $0e, $0e, $60 ; entry 20
    db $f0, $06, $0f, $60 ; entry 21
    db $f0, $fe, $10, $60 ; entry 22
    db $f0, $16, $0d, $60 ; entry 23
    db $e8, $07, $0e, $00 ; entry 24
    db $e8, $ff, $0d, $00 ; entry 25
    db $f8, $0e, $0b, $60 ; entry 26
    db $f8, $06, $0c, $60 ; entry 27
    db $e0, $07, $0b, $00 ; entry 28
    db $e0, $0f, $0c, $00 ; entry 29
    db $d0, $c9, $07, $00 ; entry 30
    db $d0, $d1, $08, $00 ; entry 31
    db $d8, $c9, $09, $00 ; entry 32
    db $d8, $d1, $0a, $00 ; entry 33
    db $d8, $d7, $0c, $00 ; entry 34
    db $80 ; end

; frame 15 of MetaSprites3ESet08; ends with $80 (E-0147)
MetaSprites3ESet08Frame15::
    db $d4, $ca, $01, $20 ; entry 0
    db $dc, $d2, $02, $20 ; entry 1
    db $dc, $ca, $03, $20 ; entry 2
    db $d4, $d2, $00, $20 ; entry 3
    db $e7, $e3, $01, $00 ; entry 4
    db $ef, $e3, $03, $00 ; entry 5
    db $ef, $d3, $02, $00 ; entry 6
    db $e7, $db, $04, $20 ; entry 7
    db $ef, $db, $05, $20 ; entry 8
    db $e7, $d3, $01, $20 ; entry 9
    db $db, $eb, $00, $00 ; entry 10
    db $db, $f3, $01, $00 ; entry 11
    db $e3, $eb, $02, $00 ; entry 12
    db $e3, $f3, $03, $00 ; entry 13
    db $f7, $cd, $02, $20 ; entry 14
    db $f7, $c5, $03, $20 ; entry 15
    db $ef, $cd, $00, $20 ; entry 16
    db $ef, $c5, $01, $20 ; entry 17
    db $f0, $f9, $00, $20 ; entry 18
    db $f0, $f1, $01, $20 ; entry 19
    db $f8, $f9, $02, $20 ; entry 20
    db $f8, $f1, $03, $20 ; entry 21
    db $e3, $b8, $07, $00 ; entry 22
    db $e3, $c0, $08, $00 ; entry 23
    db $eb, $b8, $09, $00 ; entry 24
    db $eb, $c0, $0a, $00 ; entry 25
    db $db, $db, $07, $00 ; entry 26
    db $db, $e3, $08, $00 ; entry 27
    db $e3, $db, $09, $00 ; entry 28
    db $e3, $e3, $0a, $00 ; entry 29
    db $80 ; end

; frame 16 of MetaSprites3ESet08; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet08Frame16::
    db $ec, $c2, $0e, $60 ; entry 0
    db $ec, $ba, $0f, $60 ; entry 1
    db $ec, $b2, $10, $60 ; entry 2
    db $ec, $ca, $0d, $60 ; entry 3
    db $f4, $ba, $0c, $60 ; entry 4
    db $f4, $c2, $09, $20 ; entry 5
    db $f4, $dd, $07, $60 ; entry 6
    db $f4, $d5, $08, $60 ; entry 7
    db $ec, $dd, $09, $60 ; entry 8
    db $ec, $d5, $0a, $60 ; entry 9
    db $f0, $f2, $07, $20 ; entry 10
    db $f0, $ea, $08, $20 ; entry 11
    db $f8, $f2, $09, $20 ; entry 12
    db $f8, $ea, $0a, $20 ; entry 13
    db $ec, $e3, $11, $40 ; entry 14
    db $ec, $eb, $12, $40 ; entry 15
    db $d4, $f2, $11, $20 ; entry 16
    db $d4, $ea, $12, $20 ; entry 17
    db $d4, $de, $14, $20 ; entry 18
    db $dc, $f6, $15, $20 ; entry 19
    db $dc, $ee, $16, $20 ; entry 20
    db $dc, $e6, $17, $20 ; entry 21
    db $dc, $de, $18, $20 ; entry 22
    db $e4, $de, $15, $40 ; entry 23
    db $e4, $e6, $16, $40 ; entry 24
    db $e4, $ee, $17, $40 ; entry 25
    db $e4, $f6, $18, $40 ; entry 26
    db $dc, $ce, $07, $00 ; entry 27
    db $dc, $d6, $08, $00 ; entry 28
    db $e4, $ce, $09, $00 ; entry 29
    db $e4, $d6, $0a, $00 ; entry 30
    db $e4, $bb, $0e, $00 ; entry 31
    db $e4, $c3, $0f, $00 ; entry 32
    db $e4, $b3, $0d, $00 ; entry 33
    db $dc, $bb, $0b, $00 ; entry 34
    db $dc, $c3, $0c, $00 ; entry 35
    db $80 ; end

; frame 17 of MetaSprites3ESet08; ends with $80 (E-0147)
MetaSprites3ESet08Frame17::
    db $d8, $ec, $02, $20 ; entry 0
    db $d8, $e4, $03, $20 ; entry 1
    db $d0, $ec, $00, $20 ; entry 2
    db $e3, $d3, $01, $20 ; entry 3
    db $eb, $d3, $03, $20 ; entry 4
    db $eb, $e3, $02, $20 ; entry 5
    db $e3, $db, $04, $00 ; entry 6
    db $eb, $db, $05, $00 ; entry 7
    db $e3, $e3, $01, $00 ; entry 8
    db $f3, $e9, $02, $00 ; entry 9
    db $f3, $f1, $03, $00 ; entry 10
    db $eb, $f1, $01, $00 ; entry 11
    db $f0, $ce, $07, $00 ; entry 12
    db $f0, $d6, $08, $00 ; entry 13
    db $f8, $ce, $09, $00 ; entry 14
    db $f8, $d6, $0a, $00 ; entry 15
    db $d3, $c7, $00, $20 ; entry 16
    db $d3, $bf, $01, $20 ; entry 17
    db $db, $c7, $02, $20 ; entry 18
    db $db, $bf, $03, $20 ; entry 19
    db $d7, $d4, $07, $00 ; entry 20
    db $d7, $dc, $08, $00 ; entry 21
    db $df, $d4, $09, $00 ; entry 22
    db $df, $dc, $0a, $00 ; entry 23
    db $ea, $cb, $02, $20 ; entry 24
    db $e2, $cb, $2f, $20 ; entry 25
    db $e2, $c3, $04, $20 ; entry 26
    db $ea, $c3, $2d, $60 ; entry 27
    db $e8, $bb, $05, $20 ; entry 28
    db $e0, $bb, $04, $20 ; entry 29
    db $e8, $b3, $2e, $60 ; entry 30
    db $eb, $e9, $0c, $20 ; entry 31
    db $d0, $e4, $07, $00 ; entry 32
    db $e0, $b3, $28, $20 ; entry 33
    db $80 ; end

; frame 18 of MetaSprites3ESet08; ends with $80 (E-0147)
MetaSprites3ESet08Frame18::
    db $dc, $b8, $0e, $20 ; entry 0
    db $dc, $b0, $0f, $20 ; entry 1
    db $dc, $c0, $0d, $20 ; entry 2
    db $d4, $b0, $0c, $20 ; entry 3
    db $e4, $b1, $0e, $40 ; entry 4
    db $e4, $b9, $0f, $40 ; entry 5
    db $ec, $b1, $0b, $40 ; entry 6
    db $ec, $b9, $0c, $40 ; entry 7
    db $d4, $b8, $0b, $20 ; entry 8
    db $e0, $c8, $11, $00 ; entry 9
    db $e0, $d0, $12, $00 ; entry 10
    db $f8, $d7, $11, $60 ; entry 11
    db $f8, $cf, $12, $60 ; entry 12
    db $f8, $c3, $14, $60 ; entry 13
    db $f0, $db, $15, $60 ; entry 14
    db $f0, $d3, $16, $60 ; entry 15
    db $f0, $cb, $17, $60 ; entry 16
    db $f0, $c3, $18, $60 ; entry 17
    db $e8, $c3, $15, $00 ; entry 18
    db $e8, $cb, $16, $00 ; entry 19
    db $e8, $d3, $17, $00 ; entry 20
    db $e8, $db, $18, $00 ; entry 21
    db $d8, $d4, $07, $60 ; entry 22
    db $d8, $cc, $08, $60 ; entry 23
    db $d0, $d4, $09, $60 ; entry 24
    db $d0, $cc, $0a, $60 ; entry 25
    db $f0, $eb, $07, $60 ; entry 26
    db $f0, $e3, $08, $60 ; entry 27
    db $e8, $eb, $09, $60 ; entry 28
    db $e8, $e3, $0a, $60 ; entry 29
    db $f0, $b1, $07, $00 ; entry 30
    db $f0, $b9, $08, $00 ; entry 31
    db $f8, $b1, $09, $00 ; entry 32
    db $f8, $b9, $0a, $00 ; entry 33
    db $80 ; end

; frame 19 of MetaSprites3ESet08; ends with $80 (E-0147)
MetaSprites3ESet08Frame19::
    db $d0, $b5, $11, $00 ; entry 0
    db $d0, $bd, $12, $00 ; entry 1
    db $e8, $c4, $11, $60 ; entry 2
    db $e8, $bc, $12, $60 ; entry 3
    db $e8, $b0, $14, $60 ; entry 4
    db $e0, $c8, $15, $60 ; entry 5
    db $e0, $c0, $16, $60 ; entry 6
    db $e0, $b8, $17, $60 ; entry 7
    db $e0, $b0, $18, $60 ; entry 8
    db $d8, $b0, $15, $00 ; entry 9
    db $d8, $b8, $16, $00 ; entry 10
    db $d8, $c0, $17, $00 ; entry 11
    db $d8, $c8, $18, $00 ; entry 12
    db $e1, $d4, $0e, $20 ; entry 13
    db $e1, $cc, $0f, $20 ; entry 14
    db $e9, $cd, $0e, $40 ; entry 15
    db $e9, $d5, $0f, $40 ; entry 16
    db $f1, $cd, $0b, $40 ; entry 17
    db $f1, $d5, $0c, $40 ; entry 18
    db $d9, $d4, $0b, $20 ; entry 19
    db $e0, $dc, $0d, $20 ; entry 20
    db $e0, $e0, $07, $00 ; entry 21
    db $e0, $e8, $08, $00 ; entry 22
    db $e8, $e0, $09, $00 ; entry 23
    db $e8, $e8, $0a, $00 ; entry 24
    db $d0, $d0, $07, $60 ; entry 25
    db $d0, $c8, $08, $60 ; entry 26
    db $f8, $ce, $09, $60 ; entry 27
    db $f8, $c6, $0a, $60 ; entry 28
    db $80 ; end

; frame 20 of MetaSprites3ESet08; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet08Frame20::
    db $80 ; end

; meta-sprite set 9 of MetaSprites3ETable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3ESet09::
    dw MetaSprites3ESet09Frame0 ; entry 0
    dw MetaSprites3ESet09Frame1 ; entry 1
    dw MetaSprites3ESet09Frame2 ; entry 2
    dw MetaSprites3ESet09Frame3 ; entry 3
    dw MetaSprites3ESet09Frame4 ; entry 4
    dw MetaSprites3ESet09Frame5 ; entry 5
    dw MetaSprites3ESet09Frame6 ; entry 6
    dw MetaSprites3ESet09Frame7 ; entry 7
    dw MetaSprites3ESet09Frame8 ; entry 8
    dw MetaSprites3ESet09Frame9 ; entry 9
    dw MetaSprites3ESet09Frame10 ; entry 10
    dw MetaSprites3ESet09Frame11 ; entry 11
    dw MetaSprites3ESet09Frame12 ; entry 12
    dw MetaSprites3ESet09Frame13 ; entry 13
    dw MetaSprites3ESet09Frame13 ; entry 14
    dw MetaSprites3ESet09Frame13 ; entry 15
    dw MetaSprites3ESet09Frame13 ; entry 16
    dw MetaSprites3ESet09Frame13 ; entry 17
    dw MetaSprites3ESet09Frame13 ; entry 18
    dw MetaSprites3ESet09Frame13 ; entry 19
    dw MetaSprites3ESet09Frame13 ; entry 20
    dw MetaSprites3ESet09Frame13 ; entry 21
    dw MetaSprites3ESet09Frame13 ; entry 22
    dw MetaSprites3ESet09Frame13 ; entry 23
    dw MetaSprites3ESet09Frame13 ; entry 24
    dw MetaSprites3ESet09Frame13 ; entry 25
    dw MetaSprites3ESet09Frame13 ; entry 26
    dw MetaSprites3ESet09Frame13 ; entry 27
    dw MetaSprites3ESet09Frame13 ; entry 28
    dw MetaSprites3ESet09Frame13 ; entry 29
    dw MetaSprites3ESet09Frame13 ; entry 30
    dw MetaSprites3ESet09Frame13 ; entry 31

; frame 0 of MetaSprites3ESet09; ends with $80 (E-0147)
MetaSprites3ESet09Frame0::
    db $e6, $fc, $02, $00 ; entry 0
    db $e6, $04, $03, $00 ; entry 1
    db $80 ; end

; frame 1 of MetaSprites3ESet09; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet09Frame1::
    db $ee, $f4, $02, $00 ; entry 0
    db $ee, $fc, $03, $00 ; entry 1
    db $e8, $fc, $00, $00 ; entry 2
    db $e8, $04, $01, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites3ESet09; ends with $80 (E-0147)
MetaSprites3ESet09Frame2::
    db $f0, $f4, $00, $00 ; entry 0
    db $f0, $fc, $01, $00 ; entry 1
    db $de, $f4, $00, $00 ; entry 2
    db $de, $fc, $01, $00 ; entry 3
    db $e5, $f5, $0c, $00 ; entry 4
    db $e5, $fd, $0d, $00 ; entry 5
    db $e5, $05, $0e, $00 ; entry 6
    db $80 ; end

; frame 3 of MetaSprites3ESet09; ends with $80 (E-0147)
MetaSprites3ESet09Frame3::
    db $dc, $f4, $02, $00 ; entry 0
    db $dc, $fc, $03, $00 ; entry 1
    db $ee, $f4, $00, $00 ; entry 2
    db $ee, $fc, $01, $00 ; entry 3
    db $e3, $f5, $04, $00 ; entry 4
    db $e3, $fd, $05, $00 ; entry 5
    db $e3, $05, $06, $00 ; entry 6
    db $ea, $ed, $07, $00 ; entry 7
    db $eb, $f5, $08, $00 ; entry 8
    db $80 ; end

; frame 4 of MetaSprites3ESet09; ends with $80 (E-0147)
MetaSprites3ESet09Frame4::
    db $de, $f4, $00, $00 ; entry 0
    db $de, $fc, $01, $00 ; entry 1
    db $f0, $f0, $0c, $00 ; entry 2
    db $f0, $f8, $0d, $00 ; entry 3
    db $f0, $00, $0e, $00 ; entry 4
    db $e2, $f6, $09, $00 ; entry 5
    db $e2, $fe, $0a, $00 ; entry 6
    db $e2, $06, $0b, $00 ; entry 7
    db $80 ; end

; frame 5 of MetaSprites3ESet09; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet09Frame5::
    db $e8, $fc, $00, $00 ; entry 0
    db $e8, $04, $01, $00 ; entry 1
    db $dd, $f0, $0c, $00 ; entry 2
    db $dd, $f8, $0d, $00 ; entry 3
    db $dd, $00, $0e, $00 ; entry 4
    db $f0, $f0, $04, $00 ; entry 5
    db $f0, $f8, $05, $00 ; entry 6
    db $f0, $00, $06, $00 ; entry 7
    db $f8, $f0, $08, $00 ; entry 8
    db $f7, $e8, $07, $00 ; entry 9
    db $80 ; end

; frame 6 of MetaSprites3ESet09; ends with $80 (E-0147)
MetaSprites3ESet09Frame6::
    db $da, $f1, $04, $00 ; entry 0
    db $da, $f9, $05, $00 ; entry 1
    db $da, $01, $06, $00 ; entry 2
    db $e2, $f1, $08, $00 ; entry 3
    db $e1, $e9, $07, $00 ; entry 4
    db $f2, $ee, $0c, $00 ; entry 5
    db $f2, $f6, $0d, $00 ; entry 6
    db $f2, $fe, $0e, $00 ; entry 7
    db $e6, $f8, $09, $00 ; entry 8
    db $e6, $00, $0a, $00 ; entry 9
    db $e6, $08, $0b, $00 ; entry 10
    db $80 ; end

; frame 7 of MetaSprites3ESet09; ends with $80 (E-0147)
MetaSprites3ESet09Frame7::
    db $db, $f2, $09, $00 ; entry 0
    db $db, $fa, $0a, $00 ; entry 1
    db $db, $02, $0b, $00 ; entry 2
    db $e6, $f8, $04, $00 ; entry 3
    db $e6, $00, $05, $00 ; entry 4
    db $e6, $08, $06, $00 ; entry 5
    db $ee, $f8, $08, $00 ; entry 6
    db $ed, $f0, $07, $00 ; entry 7
    db $80 ; end

; frame 8 of MetaSprites3ESet09; ends with $80 (E-0147)
MetaSprites3ESet09Frame8::
    db $e9, $f6, $0c, $00 ; entry 0
    db $e9, $fe, $0d, $00 ; entry 1
    db $e9, $06, $0e, $00 ; entry 2
    db $e0, $f8, $00, $00 ; entry 3
    db $e0, $00, $01, $00 ; entry 4
    db $80 ; end

; frame 9 of MetaSprites3ESet09; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet09Frame9::
    db $e8, $fc, $00, $00 ; entry 0
    db $e8, $04, $01, $00 ; entry 1
    db $e4, $f3, $0c, $00 ; entry 2
    db $e4, $fb, $0d, $00 ; entry 3
    db $e4, $03, $0e, $00 ; entry 4
    db $f0, $f4, $04, $00 ; entry 5
    db $f0, $fc, $05, $00 ; entry 6
    db $f0, $04, $06, $00 ; entry 7
    db $f8, $f4, $08, $00 ; entry 8
    db $f7, $ec, $07, $00 ; entry 9
    db $80 ; end

; frame 10 of MetaSprites3ESet09; ends with $80 (E-0147)
MetaSprites3ESet09Frame10::
    db $ee, $f3, $0c, $00 ; entry 0
    db $ee, $fb, $0d, $00 ; entry 1
    db $ee, $03, $0e, $00 ; entry 2
    db $f5, $f2, $09, $00 ; entry 3
    db $f5, $fa, $0a, $00 ; entry 4
    db $f5, $02, $0b, $00 ; entry 5
    db $e5, $f4, $04, $00 ; entry 6
    db $e5, $fc, $05, $00 ; entry 7
    db $e5, $04, $06, $00 ; entry 8
    db $ed, $f4, $08, $00 ; entry 9
    db $ec, $ec, $07, $00 ; entry 10
    db $80 ; end

; frame 11 of MetaSprites3ESet09; ends with $80 (E-0147)
MetaSprites3ESet09Frame11::
    db $e4, $f5, $09, $00 ; entry 0
    db $e4, $fd, $0a, $00 ; entry 1
    db $e4, $05, $0b, $00 ; entry 2
    db $ec, $f6, $04, $00 ; entry 3
    db $ec, $fe, $05, $00 ; entry 4
    db $ec, $06, $06, $00 ; entry 5
    db $f4, $f6, $08, $00 ; entry 6
    db $f3, $ee, $07, $00 ; entry 7
    db $80 ; end

; frame 12 of MetaSprites3ESet09; ends with $80 (E-0147)
MetaSprites3ESet09Frame12::
    db $e6, $f3, $0c, $00 ; entry 0
    db $e6, $fb, $0d, $00 ; entry 1
    db $e6, $03, $0e, $00 ; entry 2
    db $f1, $01, $03, $00 ; entry 3
    db $f1, $f9, $02, $00 ; entry 4
    db $80 ; end

; frame 13 of MetaSprites3ESet09; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet09Frame13::
    db $80 ; end

; meta-sprite set 10 of MetaSprites3ETable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3ESet0A::
    dw MetaSprites3ESet0AFrame0 ; entry 0
    dw MetaSprites3ESet0AFrame1 ; entry 1
    dw MetaSprites3ESet0AFrame2 ; entry 2
    dw MetaSprites3ESet0AFrame3 ; entry 3
    dw MetaSprites3ESet0AFrame4 ; entry 4
    dw MetaSprites3ESet0AFrame5 ; entry 5
    dw MetaSprites3ESet0AFrame6 ; entry 6
    dw MetaSprites3ESet0AFrame7 ; entry 7
    dw MetaSprites3ESet0AFrame8 ; entry 8
    dw MetaSprites3ESet0AFrame9 ; entry 9
    dw MetaSprites3ESet0AFrame10 ; entry 10
    dw MetaSprites3ESet0AFrame11 ; entry 11
    dw MetaSprites3ESet0AFrame12 ; entry 12
    dw MetaSprites3ESet0AFrame13 ; entry 13
    dw MetaSprites3ESet0AFrame13 ; entry 14
    dw MetaSprites3ESet0AFrame13 ; entry 15
    dw MetaSprites3ESet0AFrame13 ; entry 16
    dw MetaSprites3ESet0AFrame13 ; entry 17
    dw MetaSprites3ESet0AFrame13 ; entry 18
    dw MetaSprites3ESet0AFrame13 ; entry 19
    dw MetaSprites3ESet0AFrame13 ; entry 20
    dw MetaSprites3ESet0AFrame13 ; entry 21
    dw MetaSprites3ESet0AFrame13 ; entry 22
    dw MetaSprites3ESet0AFrame13 ; entry 23
    dw MetaSprites3ESet0AFrame13 ; entry 24
    dw MetaSprites3ESet0AFrame13 ; entry 25
    dw MetaSprites3ESet0AFrame13 ; entry 26
    dw MetaSprites3ESet0AFrame13 ; entry 27
    dw MetaSprites3ESet0AFrame13 ; entry 28
    dw MetaSprites3ESet0AFrame13 ; entry 29
    dw MetaSprites3ESet0AFrame13 ; entry 30
    dw MetaSprites3ESet0AFrame13 ; entry 31

; frame 0 of MetaSprites3ESet0A; ends with $80 (E-0147)
MetaSprites3ESet0AFrame0::
    db $f8, $b0, $1b, $00 ; entry 0
    db $f8, $b8, $1c, $00 ; entry 1
    db $e0, $b0, $0d, $00 ; entry 2
    db $e8, $b0, $11, $00 ; entry 3
    db $f0, $b0, $16, $00 ; entry 4
    db $f8, $bd, $1d, $00 ; entry 5
    db $f0, $b8, $1e, $00 ; entry 6
    db $f8, $c5, $1f, $00 ; entry 7
    db $80 ; end

; frame 1 of MetaSprites3ESet0A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet0AFrame1::
    db $f8, $b0, $1a, $00 ; entry 0
    db $f8, $b8, $1b, $00 ; entry 1
    db $f0, $b0, $15, $00 ; entry 2
    db $f0, $b8, $16, $00 ; entry 3
    db $e0, $ae, $0d, $00 ; entry 4
    db $d8, $ad, $05, $20 ; entry 5
    db $e8, $b0, $0e, $20 ; entry 6
    db $f8, $c0, $1c, $00 ; entry 7
    db $f8, $cc, $1e, $00 ; entry 8
    db $80 ; end

; frame 2 of MetaSprites3ESet0A; ends with $80 (E-0147)
MetaSprites3ESet0AFrame2::
    db $f8, $b0, $07, $00 ; entry 0
    db $f8, $b8, $08, $00 ; entry 1
    db $f8, $c0, $09, $00 ; entry 2
    db $e8, $b0, $19, $00 ; entry 3
    db $e8, $b8, $1a, $00 ; entry 4
    db $f0, $b0, $02, $00 ; entry 5
    db $f0, $b8, $03, $00 ; entry 6
    db $f0, $c0, $04, $00 ; entry 7
    db $d0, $b0, $0c, $00 ; entry 8
    db $d0, $b8, $0d, $00 ; entry 9
    db $d8, $b0, $10, $00 ; entry 10
    db $d8, $b8, $11, $00 ; entry 11
    db $e0, $b0, $15, $00 ; entry 12
    db $e0, $b8, $16, $00 ; entry 13
    db $e8, $c8, $05, $20 ; entry 14
    db $e8, $c0, $06, $20 ; entry 15
    db $f8, $c8, $1f, $00 ; entry 16
    db $80 ; end

; frame 3 of MetaSprites3ESet0A; ends with $80 (E-0147)
MetaSprites3ESet0AFrame3::
    db $f0, $b4, $00, $00 ; entry 0
    db $f0, $bc, $01, $00 ; entry 1
    db $f0, $c4, $02, $00 ; entry 2
    db $f0, $cc, $03, $00 ; entry 3
    db $f0, $d4, $04, $00 ; entry 4
    db $e8, $b1, $17, $00 ; entry 5
    db $e8, $b9, $18, $00 ; entry 6
    db $e8, $c1, $19, $00 ; entry 7
    db $e8, $c9, $1a, $00 ; entry 8
    db $e8, $d1, $1b, $00 ; entry 9
    db $e8, $d9, $1c, $00 ; entry 10
    db $e0, $b1, $12, $00 ; entry 11
    db $e0, $b9, $13, $00 ; entry 12
    db $e0, $c1, $14, $00 ; entry 13
    db $e0, $c9, $15, $00 ; entry 14
    db $e0, $d1, $16, $00 ; entry 15
    db $f8, $cf, $06, $20 ; entry 16
    db $f8, $c7, $07, $20 ; entry 17
    db $f8, $bf, $08, $20 ; entry 18
    db $f8, $b7, $09, $20 ; entry 19
    db $d8, $cc, $0e, $20 ; entry 20
    db $d8, $c4, $0f, $20 ; entry 21
    db $d8, $bc, $10, $20 ; entry 22
    db $d8, $b4, $11, $20 ; entry 23
    db $d0, $b0, $0a, $00 ; entry 24
    db $d0, $b8, $0b, $00 ; entry 25
    db $d0, $c0, $0c, $00 ; entry 26
    db $d0, $c8, $0d, $00 ; entry 27
    db $f8, $d8, $1e, $00 ; entry 28
    db $f8, $d7, $05, $20 ; entry 29
    db $f8, $b0, $1d, $20 ; entry 30
    db $80 ; end

; frame 4 of MetaSprites3ESet0A; ends with $80 (E-0147)
MetaSprites3ESet0AFrame4::
    db $d8, $c4, $00, $00 ; entry 0
    db $d8, $cc, $01, $00 ; entry 1
    db $d8, $d4, $02, $00 ; entry 2
    db $d8, $dc, $03, $00 ; entry 3
    db $d8, $e4, $04, $00 ; entry 4
    db $e0, $c1, $05, $00 ; entry 5
    db $e0, $c9, $06, $00 ; entry 6
    db $e0, $d1, $07, $00 ; entry 7
    db $e0, $d9, $08, $00 ; entry 8
    db $e0, $e1, $09, $00 ; entry 9
    db $e8, $c9, $0a, $00 ; entry 10
    db $e8, $d1, $0b, $00 ; entry 11
    db $e8, $d9, $0c, $00 ; entry 12
    db $e8, $e1, $0d, $00 ; entry 13
    db $f0, $c9, $0e, $00 ; entry 14
    db $f0, $d1, $0f, $00 ; entry 15
    db $f0, $d9, $10, $00 ; entry 16
    db $f0, $e1, $11, $00 ; entry 17
    db $d0, $e8, $17, $20 ; entry 18
    db $d0, $e0, $18, $20 ; entry 19
    db $d0, $d8, $19, $20 ; entry 20
    db $d0, $d0, $1a, $20 ; entry 21
    db $d0, $c8, $1b, $20 ; entry 22
    db $d0, $c0, $1c, $20 ; entry 23
    db $f8, $c2, $12, $00 ; entry 24
    db $f8, $ca, $13, $00 ; entry 25
    db $f8, $d2, $14, $00 ; entry 26
    db $f8, $da, $15, $00 ; entry 27
    db $f8, $e2, $16, $00 ; entry 28
    db $f8, $e9, $1e, $00 ; entry 29
    db $80 ; end

; frame 5 of MetaSprites3ESet0A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet0AFrame5::
    db $e8, $f1, $0e, $20 ; entry 0
    db $e8, $e9, $0f, $20 ; entry 1
    db $e8, $e1, $10, $20 ; entry 2
    db $e8, $d9, $11, $20 ; entry 3
    db $f8, $e0, $18, $00 ; entry 4
    db $f8, $e8, $19, $00 ; entry 5
    db $f8, $f0, $1a, $00 ; entry 6
    db $f8, $f8, $1b, $00 ; entry 7
    db $f8, $d8, $17, $00 ; entry 8
    db $f0, $e0, $13, $00 ; entry 9
    db $f0, $e8, $14, $00 ; entry 10
    db $f0, $f0, $15, $00 ; entry 11
    db $f0, $f8, $16, $00 ; entry 12
    db $f0, $d8, $12, $00 ; entry 13
    db $e0, $d6, $0a, $00 ; entry 14
    db $e0, $de, $0b, $00 ; entry 15
    db $e0, $e6, $0c, $00 ; entry 16
    db $e0, $ee, $0d, $00 ; entry 17
    db $d8, $ed, $05, $20 ; entry 18
    db $d8, $e5, $06, $20 ; entry 19
    db $d8, $dd, $07, $20 ; entry 20
    db $d8, $d5, $08, $20 ; entry 21
    db $d8, $cd, $05, $40 ; entry 22
    db $d0, $e8, $00, $20 ; entry 23
    db $d0, $e0, $01, $20 ; entry 24
    db $d0, $d8, $02, $20 ; entry 25
    db $d0, $d0, $03, $20 ; entry 26
    db $f8, $d0, $1f, $20 ; entry 27
    db $80 ; end

; frame 6 of MetaSprites3ESet0A; ends with $80 (E-0147)
MetaSprites3ESet0AFrame6::
    db $f0, $e3, $17, $00 ; entry 0
    db $f0, $eb, $18, $00 ; entry 1
    db $f0, $f3, $19, $00 ; entry 2
    db $f0, $fb, $1a, $00 ; entry 3
    db $f0, $03, $1b, $00 ; entry 4
    db $f0, $0b, $1c, $00 ; entry 5
    db $e8, $e3, $12, $00 ; entry 6
    db $e8, $eb, $13, $00 ; entry 7
    db $e8, $f3, $14, $00 ; entry 8
    db $e8, $fb, $15, $00 ; entry 9
    db $e8, $03, $16, $00 ; entry 10
    db $d0, $08, $05, $20 ; entry 11
    db $e0, $fe, $0e, $20 ; entry 12
    db $e0, $f6, $0f, $20 ; entry 13
    db $e0, $ee, $10, $20 ; entry 14
    db $e0, $e6, $11, $20 ; entry 15
    db $d8, $fe, $0a, $20 ; entry 16
    db $d8, $f6, $0b, $20 ; entry 17
    db $d8, $ee, $0c, $20 ; entry 18
    db $d8, $e6, $0d, $20 ; entry 19
    db $d0, $00, $06, $20 ; entry 20
    db $d0, $f8, $07, $20 ; entry 21
    db $d0, $f0, $08, $20 ; entry 22
    db $d0, $e8, $09, $20 ; entry 23
    db $f8, $08, $1f, $00 ; entry 24
    db $f8, $e0, $1d, $00 ; entry 25
    db $f8, $04, $00, $20 ; entry 26
    db $f8, $fc, $01, $20 ; entry 27
    db $f8, $f4, $02, $20 ; entry 28
    db $f8, $ec, $03, $20 ; entry 29
    db $f8, $e4, $04, $20 ; entry 30
    db $80 ; end

; frame 7 of MetaSprites3ESet0A; ends with $80 (E-0147)
MetaSprites3ESet0AFrame7::
    db $f0, $f4, $00, $00 ; entry 0
    db $f0, $fc, $01, $00 ; entry 1
    db $f0, $04, $02, $00 ; entry 2
    db $f0, $0c, $03, $00 ; entry 3
    db $f0, $14, $04, $00 ; entry 4
    db $e8, $f1, $17, $00 ; entry 5
    db $e8, $f9, $18, $00 ; entry 6
    db $e8, $01, $19, $00 ; entry 7
    db $e8, $09, $1a, $00 ; entry 8
    db $e8, $11, $1b, $00 ; entry 9
    db $e8, $19, $1c, $00 ; entry 10
    db $e0, $f1, $12, $00 ; entry 11
    db $e0, $f9, $13, $00 ; entry 12
    db $e0, $01, $14, $00 ; entry 13
    db $e0, $09, $15, $00 ; entry 14
    db $e0, $11, $16, $00 ; entry 15
    db $f8, $0f, $06, $20 ; entry 16
    db $f8, $07, $07, $20 ; entry 17
    db $f8, $ff, $08, $20 ; entry 18
    db $f8, $f7, $09, $20 ; entry 19
    db $d8, $0c, $0e, $20 ; entry 20
    db $d8, $04, $0f, $20 ; entry 21
    db $d8, $fc, $10, $20 ; entry 22
    db $d8, $f4, $11, $20 ; entry 23
    db $d0, $f0, $0a, $00 ; entry 24
    db $d0, $f8, $0b, $00 ; entry 25
    db $d0, $00, $0c, $00 ; entry 26
    db $d0, $08, $0d, $00 ; entry 27
    db $f8, $18, $1e, $00 ; entry 28
    db $f8, $17, $05, $20 ; entry 29
    db $f8, $f0, $1d, $20 ; entry 30
    db $80 ; end

; frame 8 of MetaSprites3ESet0A; ends with $80 (E-0147)
MetaSprites3ESet0AFrame8::
    db $d8, $ff, $12, $00 ; entry 0
    db $d8, $07, $13, $00 ; entry 1
    db $d8, $0f, $14, $00 ; entry 2
    db $d8, $17, $15, $00 ; entry 3
    db $d8, $1f, $16, $00 ; entry 4
    db $f8, $10, $0a, $00 ; entry 5
    db $f8, $18, $0b, $00 ; entry 6
    db $f8, $20, $0c, $00 ; entry 7
    db $f8, $28, $0d, $00 ; entry 8
    db $f0, $23, $05, $20 ; entry 9
    db $f0, $1b, $06, $20 ; entry 10
    db $f0, $13, $07, $20 ; entry 11
    db $f0, $0b, $08, $20 ; entry 12
    db $f0, $03, $09, $20 ; entry 13
    db $e8, $01, $00, $00 ; entry 14
    db $e8, $09, $01, $00 ; entry 15
    db $e8, $11, $02, $00 ; entry 16
    db $e8, $19, $03, $00 ; entry 17
    db $e8, $21, $04, $00 ; entry 18
    db $e0, $fe, $17, $00 ; entry 19
    db $e0, $06, $18, $00 ; entry 20
    db $e0, $0e, $19, $00 ; entry 21
    db $e0, $16, $1a, $00 ; entry 22
    db $e0, $1e, $1b, $00 ; entry 23
    db $e0, $26, $1c, $00 ; entry 24
    db $d0, $0a, $0e, $00 ; entry 25
    db $d0, $12, $0f, $00 ; entry 26
    db $d0, $1a, $10, $00 ; entry 27
    db $d0, $22, $11, $00 ; entry 28
    db $f8, $08, $1e, $20 ; entry 29
    db $80 ; end

; frame 9 of MetaSprites3ESet0A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet0AFrame9::
    db $f0, $1c, $0a, $00 ; entry 0
    db $f0, $24, $0b, $00 ; entry 1
    db $f0, $2c, $0c, $00 ; entry 2
    db $f0, $34, $0d, $00 ; entry 3
    db $e8, $34, $05, $20 ; entry 4
    db $e8, $2c, $06, $20 ; entry 5
    db $e8, $24, $07, $20 ; entry 6
    db $e8, $1c, $08, $20 ; entry 7
    db $e8, $14, $09, $20 ; entry 8
    db $e0, $12, $00, $00 ; entry 9
    db $e0, $1a, $01, $00 ; entry 10
    db $e0, $22, $02, $00 ; entry 11
    db $e0, $2a, $03, $00 ; entry 12
    db $e0, $32, $04, $00 ; entry 13
    db $d8, $0f, $17, $00 ; entry 14
    db $d8, $17, $18, $00 ; entry 15
    db $d8, $1f, $19, $00 ; entry 16
    db $d8, $27, $1a, $00 ; entry 17
    db $d8, $2f, $1b, $00 ; entry 18
    db $d8, $37, $1c, $00 ; entry 19
    db $d0, $0f, $12, $00 ; entry 20
    db $d0, $17, $13, $00 ; entry 21
    db $d0, $1f, $14, $00 ; entry 22
    db $d0, $27, $15, $00 ; entry 23
    db $d0, $2f, $16, $00 ; entry 24
    db $f8, $38, $0e, $20 ; entry 25
    db $f8, $30, $0f, $20 ; entry 26
    db $f8, $28, $10, $20 ; entry 27
    db $f8, $20, $11, $20 ; entry 28
    db $f8, $18, $1f, $20 ; entry 29
    db $80 ; end

; frame 10 of MetaSprites3ESet0A; ends with $80 (E-0147)
MetaSprites3ESet0AFrame10::
    db $f8, $48, $12, $20 ; entry 0
    db $f8, $40, $13, $20 ; entry 1
    db $f8, $38, $14, $20 ; entry 2
    db $f8, $30, $15, $20 ; entry 3
    db $f8, $28, $16, $20 ; entry 4
    db $e8, $40, $0a, $20 ; entry 5
    db $e8, $38, $0b, $20 ; entry 6
    db $e8, $30, $0c, $20 ; entry 7
    db $e8, $28, $0d, $20 ; entry 8
    db $f0, $40, $0e, $20 ; entry 9
    db $f0, $38, $0f, $20 ; entry 10
    db $f0, $30, $10, $20 ; entry 11
    db $f0, $28, $11, $20 ; entry 12
    db $e0, $4a, $05, $20 ; entry 13
    db $e0, $42, $06, $20 ; entry 14
    db $e0, $3a, $07, $20 ; entry 15
    db $e0, $32, $08, $20 ; entry 16
    db $e0, $2a, $09, $20 ; entry 17
    db $d8, $28, $00, $00 ; entry 18
    db $d8, $30, $01, $00 ; entry 19
    db $d8, $38, $02, $00 ; entry 20
    db $d8, $40, $03, $00 ; entry 21
    db $d8, $48, $04, $00 ; entry 22
    db $d0, $4a, $17, $20 ; entry 23
    db $d0, $42, $18, $20 ; entry 24
    db $d0, $3a, $19, $20 ; entry 25
    db $d0, $32, $1a, $20 ; entry 26
    db $d0, $2a, $1b, $20 ; entry 27
    db $d0, $22, $1c, $20 ; entry 28
    db $f8, $20, $1d, $20 ; entry 29
    db $80 ; end

; frame 11 of MetaSprites3ESet0A; ends with $80 (E-0147)
MetaSprites3ESet0AFrame11::
    db $f0, $38, $17, $00 ; entry 0
    db $f0, $40, $18, $00 ; entry 1
    db $f0, $48, $19, $00 ; entry 2
    db $e8, $38, $12, $00 ; entry 3
    db $e8, $40, $13, $00 ; entry 4
    db $e8, $48, $14, $00 ; entry 5
    db $f8, $48, $02, $20 ; entry 6
    db $f8, $40, $03, $20 ; entry 7
    db $f8, $38, $04, $20 ; entry 8
    db $e0, $48, $0f, $20 ; entry 9
    db $e0, $40, $10, $20 ; entry 10
    db $e0, $38, $11, $20 ; entry 11
    db $d8, $32, $0a, $00 ; entry 12
    db $d8, $3a, $0b, $00 ; entry 13
    db $d8, $42, $0c, $00 ; entry 14
    db $d8, $4a, $0d, $00 ; entry 15
    db $d0, $45, $05, $20 ; entry 16
    db $d0, $3d, $06, $20 ; entry 17
    db $d0, $35, $07, $20 ; entry 18
    db $d0, $2d, $08, $20 ; entry 19
    db $d0, $25, $09, $20 ; entry 20
    db $f8, $28, $1f, $20 ; entry 21
    db $f8, $30, $1d, $20 ; entry 22
    db $80 ; end

; frame 12 of MetaSprites3ESet0A; ends with $80 (E-0147)
MetaSprites3ESet0AFrame12::
    db $e8, $48, $1b, $20 ; entry 0
    db $e0, $48, $16, $20 ; entry 1
    db $f0, $48, $00, $00 ; entry 2
    db $f8, $48, $05, $00 ; entry 3
    db $d0, $40, $0a, $00 ; entry 4
    db $d0, $48, $0b, $00 ; entry 5
    db $e7, $40, $1c, $20 ; entry 6
    db $d8, $48, $11, $20 ; entry 7
    db $f8, $38, $1f, $20 ; entry 8
    db $f8, $40, $1d, $20 ; entry 9
    db $80 ; end

; frame 13 of MetaSprites3ESet0A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet0AFrame13::
    db $80 ; end

; meta-sprite set 11 of MetaSprites3ETable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3ESet0B::
    dw MetaSprites3ESet0BFrame0 ; entry 0
    dw MetaSprites3ESet0BFrame1 ; entry 1
    dw MetaSprites3ESet0BFrame2 ; entry 2
    dw MetaSprites3ESet0BFrame3 ; entry 3
    dw MetaSprites3ESet0BFrame4 ; entry 4
    dw MetaSprites3ESet0BFrame5 ; entry 5
    dw MetaSprites3ESet0BFrame6 ; entry 6
    dw MetaSprites3ESet0BFrame7 ; entry 7
    dw MetaSprites3ESet0BFrame8 ; entry 8
    dw MetaSprites3ESet0BFrame9 ; entry 9
    dw MetaSprites3ESet0BFrame10 ; entry 10
    dw MetaSprites3ESet0BFrame11 ; entry 11
    dw MetaSprites3ESet0BFrame12 ; entry 12
    dw MetaSprites3ESet0BFrame13 ; entry 13
    dw MetaSprites3ESet0BFrame14 ; entry 14
    dw MetaSprites3ESet0BFrame15 ; entry 15
    dw MetaSprites3ESet0BFrame16 ; entry 16
    dw MetaSprites3ESet0BFrame17 ; entry 17
    dw MetaSprites3ESet0BFrame18 ; entry 18
    dw MetaSprites3ESet0BFrame19 ; entry 19
    dw MetaSprites3ESet0BFrame20 ; entry 20
    dw MetaSprites3ESet0BFrame21 ; entry 21
    dw MetaSprites3ESet0BFrame22 ; entry 22
    dw MetaSprites3ESet0BFrame23 ; entry 23
    dw MetaSprites3ESet0BFrame24 ; entry 24
    dw MetaSprites3ESet0BFrame25 ; entry 25
    dw MetaSprites3ESet0BFrame26 ; entry 26
    dw MetaSprites3ESet0BFrame27 ; entry 27
    dw MetaSprites3ESet0BFrame27 ; entry 28
    dw MetaSprites3ESet0BFrame27 ; entry 29
    dw MetaSprites3ESet0BFrame27 ; entry 30
    dw MetaSprites3ESet0BFrame27 ; entry 31

; frame 0 of MetaSprites3ESet0B; ends with $80 (E-0147)
MetaSprites3ESet0BFrame0::
    db $f8, $b0, $04, $00 ; entry 0
    db $f8, $b8, $05, $00 ; entry 1
    db $f8, $c0, $06, $00 ; entry 2
    db $f8, $c8, $07, $00 ; entry 3
    db $f8, $d0, $08, $00 ; entry 4
    db $f8, $d8, $09, $00 ; entry 5
    db $f2, $d0, $05, $00 ; entry 6
    db $f2, $d8, $06, $00 ; entry 7
    db $f2, $c9, $04, $00 ; entry 8
    db $f0, $b0, $08, $00 ; entry 9
    db $f0, $b8, $09, $00 ; entry 10
    db $f8, $e0, $20, $00 ; entry 11
    db $f8, $e8, $1c, $40 ; entry 12
    db $80 ; end

; frame 1 of MetaSprites3ESet0B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet0BFrame1::
    db $f8, $c0, $0a, $00 ; entry 0
    db $f8, $c8, $0b, $00 ; entry 1
    db $f8, $d0, $0c, $00 ; entry 2
    db $f8, $d8, $0d, $00 ; entry 3
    db $f0, $b8, $04, $00 ; entry 4
    db $f0, $c0, $05, $00 ; entry 5
    db $f0, $c8, $06, $00 ; entry 6
    db $f0, $d0, $07, $00 ; entry 7
    db $f0, $d8, $08, $00 ; entry 8
    db $f0, $e0, $09, $00 ; entry 9
    db $f8, $b0, $20, $20 ; entry 10
    db $f8, $e8, $21, $00 ; entry 11
    db $f0, $f0, $1d, $00 ; entry 12
    db $e8, $b0, $1c, $00 ; entry 13
    db $80 ; end

; frame 2 of MetaSprites3ESet0B; ends with $80 (E-0147)
MetaSprites3ESet0BFrame2::
    db $d8, $e0, $04, $00 ; entry 0
    db $d8, $c0, $05, $00 ; entry 1
    db $d8, $c8, $06, $00 ; entry 2
    db $d8, $d0, $07, $00 ; entry 3
    db $d8, $d8, $08, $00 ; entry 4
    db $d8, $e0, $09, $00 ; entry 5
    db $e0, $c0, $0a, $00 ; entry 6
    db $e0, $c8, $0b, $00 ; entry 7
    db $e0, $d0, $0c, $00 ; entry 8
    db $e0, $d8, $0d, $00 ; entry 9
    db $f0, $d0, $0a, $00 ; entry 10
    db $f0, $d8, $0b, $00 ; entry 11
    db $f0, $e0, $0c, $00 ; entry 12
    db $e8, $c8, $04, $00 ; entry 13
    db $e8, $d0, $05, $00 ; entry 14
    db $e8, $d8, $06, $00 ; entry 15
    db $e8, $e0, $07, $00 ; entry 16
    db $f8, $d0, $10, $00 ; entry 17
    db $f8, $d8, $11, $00 ; entry 18
    db $f8, $e0, $12, $00 ; entry 19
    db $f8, $c0, $0e, $00 ; entry 20
    db $f8, $c8, $0f, $00 ; entry 21
    db $f0, $e8, $0d, $00 ; entry 22
    db $e8, $e8, $08, $00 ; entry 23
    db $e8, $f0, $09, $00 ; entry 24
    db $f8, $e8, $17, $00 ; entry 25
    db $f8, $b0, $21, $20 ; entry 26
    db $f8, $f8, $21, $00 ; entry 27
    db $f0, $c0, $1d, $20 ; entry 28
    db $e8, $00, $1c, $20 ; entry 29
    db $f0, $10, $1f, $00 ; entry 30
    db $f8, $f0, $13, $00 ; entry 31
    db $f8, $b8, $13, $20 ; entry 32
    db $e0, $b8, $1e, $00 ; entry 33
    db $80 ; end

; frame 3 of MetaSprites3ESet0B; ends with $80 (E-0147)
MetaSprites3ESet0BFrame3::
    db $f0, $e4, $0a, $00 ; entry 0
    db $f0, $ec, $0b, $00 ; entry 1
    db $f0, $f4, $0c, $00 ; entry 2
    db $f0, $fc, $0d, $00 ; entry 3
    db $f8, $b8, $04, $00 ; entry 4
    db $f8, $c0, $05, $00 ; entry 5
    db $f8, $c8, $06, $00 ; entry 6
    db $f8, $d0, $07, $00 ; entry 7
    db $f8, $d8, $08, $00 ; entry 8
    db $f8, $e0, $05, $00 ; entry 9
    db $f8, $e8, $06, $00 ; entry 10
    db $f8, $f0, $07, $00 ; entry 11
    db $f8, $f8, $08, $00 ; entry 12
    db $f8, $00, $09, $00 ; entry 13
    db $d0, $20, $1e, $00 ; entry 14
    db $e8, $20, $1f, $00 ; entry 15
    db $e0, $10, $1d, $00 ; entry 16
    db $f0, $d8, $1c, $00 ; entry 17
    db $80 ; end

; frame 4 of MetaSprites3ESet0B; ends with $80 (E-0147)
MetaSprites3ESet0BFrame4::
    db $f8, $e0, $0e, $00 ; entry 0
    db $e0, $08, $0b, $00 ; entry 1
    db $e0, $10, $0c, $00 ; entry 2
    db $e0, $18, $0d, $00 ; entry 3
    db $d8, $08, $05, $00 ; entry 4
    db $d8, $10, $06, $00 ; entry 5
    db $d8, $18, $08, $00 ; entry 6
    db $da, $20, $11, $00 ; entry 7
    db $da, $28, $12, $00 ; entry 8
    db $e8, $f8, $0a, $00 ; entry 9
    db $e8, $00, $0b, $00 ; entry 10
    db $e8, $08, $0c, $00 ; entry 11
    db $e8, $10, $0d, $00 ; entry 12
    db $d0, $f0, $10, $00 ; entry 13
    db $d0, $f8, $11, $00 ; entry 14
    db $d0, $00, $12, $00 ; entry 15
    db $d0, $e0, $0e, $00 ; entry 16
    db $d0, $e8, $0f, $00 ; entry 17
    db $d8, $e8, $19, $00 ; entry 18
    db $d8, $f0, $1a, $00 ; entry 19
    db $d8, $f8, $1b, $00 ; entry 20
    db $e0, $f0, $15, $00 ; entry 21
    db $d8, $00, $14, $00 ; entry 22
    db $e0, $f8, $1a, $00 ; entry 23
    db $e0, $00, $1b, $00 ; entry 24
    db $f0, $e0, $19, $00 ; entry 25
    db $f0, $e8, $1a, $00 ; entry 26
    db $f0, $f8, $0f, $00 ; entry 27
    db $f0, $f0, $1b, $00 ; entry 28
    db $d0, $08, $09, $00 ; entry 29
    db $f8, $d0, $19, $00 ; entry 30
    db $f8, $d8, $1a, $00 ; entry 31
    db $f8, $e8, $1a, $60 ; entry 32
    db $f8, $f0, $08, $00 ; entry 33
    db $f8, $f8, $09, $00 ; entry 34
    db $f0, $00, $10, $00 ; entry 35
    db $f0, $08, $11, $00 ; entry 36
    db $f8, $c0, $21, $20 ; entry 37
    db $f8, $08, $20, $00 ; entry 38
    db $d0, $20, $1c, $00 ; entry 39
    db $80 ; end

; frame 5 of MetaSprites3ESet0B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet0BFrame5::
    db $e8, $f8, $0b, $00 ; entry 0
    db $e8, $00, $0c, $00 ; entry 1
    db $e8, $08, $0d, $00 ; entry 2
    db $e0, $d8, $04, $00 ; entry 3
    db $d8, $f0, $11, $00 ; entry 4
    db $d8, $f8, $12, $00 ; entry 5
    db $e0, $e0, $0c, $00 ; entry 6
    db $e0, $e8, $14, $00 ; entry 7
    db $e8, $f0, $14, $00 ; entry 8
    db $d8, $d8, $15, $00 ; entry 9
    db $d8, $e0, $16, $00 ; entry 10
    db $d8, $e8, $17, $00 ; entry 11
    db $f8, $e8, $0c, $00 ; entry 12
    db $f8, $f0, $0d, $00 ; entry 13
    db $f0, $d8, $05, $00 ; entry 14
    db $f0, $e0, $06, $00 ; entry 15
    db $f0, $e8, $07, $00 ; entry 16
    db $f0, $f0, $14, $00 ; entry 17
    db $f0, $f8, $0f, $00 ; entry 18
    db $f8, $f8, $17, $00 ; entry 19
    db $f0, $00, $17, $00 ; entry 20
    db $e0, $f0, $06, $00 ; entry 21
    db $e0, $f8, $07, $00 ; entry 22
    db $e0, $00, $08, $00 ; entry 23
    db $e0, $08, $09, $00 ; entry 24
    db $e8, $e0, $15, $00 ; entry 25
    db $e8, $e8, $16, $00 ; entry 26
    db $f0, $c8, $15, $00 ; entry 27
    db $f0, $d0, $16, $00 ; entry 28
    db $d8, $00, $09, $00 ; entry 29
    db $f8, $d8, $1a, $00 ; entry 30
    db $f8, $e0, $1b, $00 ; entry 31
    db $f8, $10, $20, $00 ; entry 32
    db $f8, $08, $21, $00 ; entry 33
    db $f8, $c8, $21, $20 ; entry 34
    db $f0, $18, $1d, $00 ; entry 35
    db $f8, $c0, $13, $00 ; entry 36
    db $f8, $d0, $1c, $00 ; entry 37
    db $e8, $c0, $1c, $00 ; entry 38
    db $80 ; end

; frame 6 of MetaSprites3ESet0B; ends with $80 (E-0147)
MetaSprites3ESet0BFrame6::
    db $d0, $e8, $05, $00 ; entry 0
    db $e0, $dc, $0b, $00 ; entry 1
    db $e0, $e4, $0c, $00 ; entry 2
    db $e0, $ec, $0d, $00 ; entry 3
    db $d0, $f0, $06, $00 ; entry 4
    db $d0, $f8, $08, $00 ; entry 5
    db $d0, $e0, $14, $00 ; entry 6
    db $d0, $c0, $15, $00 ; entry 7
    db $d0, $c8, $16, $00 ; entry 8
    db $d0, $d0, $17, $00 ; entry 9
    db $d0, $d8, $0e, $00 ; entry 10
    db $d8, $c8, $19, $00 ; entry 11
    db $d8, $d0, $1a, $00 ; entry 12
    db $d8, $d8, $14, $00 ; entry 13
    db $e0, $c4, $19, $00 ; entry 14
    db $e0, $cc, $1a, $00 ; entry 15
    db $e0, $d4, $0d, $00 ; entry 16
    db $d8, $e8, $07, $00 ; entry 17
    db $d8, $f0, $08, $00 ; entry 18
    db $d8, $f8, $09, $00 ; entry 19
    db $d8, $e0, $16, $00 ; entry 20
    db $d0, $00, $09, $00 ; entry 21
    db $e8, $d4, $15, $00 ; entry 22
    db $e8, $dc, $16, $00 ; entry 23
    db $e8, $e4, $17, $00 ; entry 24
    db $e8, $ec, $12, $00 ; entry 25
    db $f0, $e8, $15, $00 ; entry 26
    db $f0, $f0, $16, $00 ; entry 27
    db $f0, $f8, $17, $00 ; entry 28
    db $f8, $f0, $05, $00 ; entry 29
    db $e8, $f4, $09, $00 ; entry 30
    db $f8, $d8, $15, $00 ; entry 31
    db $f8, $e0, $16, $00 ; entry 32
    db $f8, $e8, $17, $00 ; entry 33
    db $f8, $f8, $10, $00 ; entry 34
    db $f8, $00, $11, $00 ; entry 35
    db $f8, $08, $12, $00 ; entry 36
    db $f8, $c8, $20, $20 ; entry 37
    db $e0, $28, $1c, $00 ; entry 38
    db $f8, $18, $20, $00 ; entry 39
    db $80 ; end

; frame 7 of MetaSprites3ESet0B; ends with $80 (E-0147)
MetaSprites3ESet0BFrame7::
    db $f8, $f8, $0e, $00 ; entry 0
    db $e0, $20, $0b, $00 ; entry 1
    db $e0, $28, $0c, $00 ; entry 2
    db $e0, $30, $0d, $00 ; entry 3
    db $d8, $20, $05, $00 ; entry 4
    db $d8, $28, $06, $00 ; entry 5
    db $d8, $30, $08, $00 ; entry 6
    db $da, $38, $11, $00 ; entry 7
    db $da, $40, $12, $00 ; entry 8
    db $e8, $10, $0a, $00 ; entry 9
    db $e8, $18, $0b, $00 ; entry 10
    db $e8, $20, $0c, $00 ; entry 11
    db $e8, $28, $0d, $00 ; entry 12
    db $d0, $08, $10, $00 ; entry 13
    db $d0, $10, $11, $00 ; entry 14
    db $d0, $18, $12, $00 ; entry 15
    db $d0, $f8, $0e, $00 ; entry 16
    db $d0, $00, $0f, $00 ; entry 17
    db $d8, $00, $19, $00 ; entry 18
    db $d8, $08, $1a, $00 ; entry 19
    db $d8, $10, $1b, $00 ; entry 20
    db $e0, $08, $15, $00 ; entry 21
    db $d8, $18, $14, $00 ; entry 22
    db $e0, $10, $1a, $00 ; entry 23
    db $e0, $18, $1b, $00 ; entry 24
    db $f0, $f8, $19, $00 ; entry 25
    db $f0, $00, $1a, $00 ; entry 26
    db $f0, $18, $10, $00 ; entry 27
    db $f0, $20, $11, $00 ; entry 28
    db $f0, $10, $0f, $00 ; entry 29
    db $f0, $08, $1b, $00 ; entry 30
    db $d0, $20, $09, $00 ; entry 31
    db $f8, $e8, $19, $00 ; entry 32
    db $f8, $f0, $1a, $00 ; entry 33
    db $f8, $00, $1a, $60 ; entry 34
    db $f8, $08, $08, $00 ; entry 35
    db $f8, $10, $09, $00 ; entry 36
    db $f8, $20, $21, $00 ; entry 37
    db $f8, $d8, $21, $20 ; entry 38
    db $e8, $d0, $1f, $00 ; entry 39
    db $80 ; end

; frame 8 of MetaSprites3ESet0B; ends with $80 (E-0147)
MetaSprites3ESet0BFrame8::
    db $e8, $10, $0b, $00 ; entry 0
    db $e8, $18, $0c, $00 ; entry 1
    db $e8, $20, $0d, $00 ; entry 2
    db $e0, $f0, $04, $00 ; entry 3
    db $d8, $08, $11, $00 ; entry 4
    db $d8, $10, $12, $00 ; entry 5
    db $e0, $f8, $0c, $00 ; entry 6
    db $e0, $00, $14, $00 ; entry 7
    db $e8, $08, $14, $00 ; entry 8
    db $d8, $f0, $15, $00 ; entry 9
    db $d8, $f8, $16, $00 ; entry 10
    db $d8, $00, $17, $00 ; entry 11
    db $f8, $00, $0c, $00 ; entry 12
    db $f8, $08, $0d, $00 ; entry 13
    db $f0, $f0, $05, $00 ; entry 14
    db $f0, $f8, $06, $00 ; entry 15
    db $f0, $00, $07, $00 ; entry 16
    db $f0, $08, $14, $00 ; entry 17
    db $f0, $10, $0f, $00 ; entry 18
    db $f8, $10, $17, $00 ; entry 19
    db $f0, $18, $17, $00 ; entry 20
    db $e0, $08, $06, $00 ; entry 21
    db $e0, $10, $07, $00 ; entry 22
    db $e0, $18, $08, $00 ; entry 23
    db $e0, $20, $09, $00 ; entry 24
    db $e8, $f8, $15, $00 ; entry 25
    db $e8, $00, $16, $00 ; entry 26
    db $f0, $e0, $15, $00 ; entry 27
    db $f0, $e8, $16, $00 ; entry 28
    db $d8, $18, $09, $00 ; entry 29
    db $f8, $f0, $1a, $00 ; entry 30
    db $f8, $f8, $1b, $00 ; entry 31
    db $f8, $28, $20, $00 ; entry 32
    db $f8, $d8, $20, $20 ; entry 33
    db $f8, $e0, $13, $00 ; entry 34
    db $f8, $20, $13, $20 ; entry 35
    db $d0, $38, $1d, $00 ; entry 36
    db $f8, $d0, $1f, $00 ; entry 37
    db $f0, $30, $1e, $20 ; entry 38
    db $d8, $c8, $1e, $00 ; entry 39
    db $80 ; end

; frame 9 of MetaSprites3ESet0B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet0BFrame9::
    db $d0, $f8, $05, $00 ; entry 0
    db $e0, $ec, $0b, $00 ; entry 1
    db $e0, $f4, $0c, $00 ; entry 2
    db $e0, $fc, $0d, $00 ; entry 3
    db $d0, $00, $06, $00 ; entry 4
    db $d0, $08, $08, $00 ; entry 5
    db $d0, $f0, $14, $00 ; entry 6
    db $d0, $d0, $15, $00 ; entry 7
    db $d0, $d8, $16, $00 ; entry 8
    db $d0, $e0, $17, $00 ; entry 9
    db $d0, $e8, $0e, $00 ; entry 10
    db $d8, $d8, $19, $00 ; entry 11
    db $d8, $e0, $1a, $00 ; entry 12
    db $d8, $e8, $14, $00 ; entry 13
    db $e0, $d4, $19, $00 ; entry 14
    db $e0, $dc, $1a, $00 ; entry 15
    db $e0, $e4, $0d, $00 ; entry 16
    db $d8, $f8, $07, $00 ; entry 17
    db $d8, $00, $08, $00 ; entry 18
    db $d8, $08, $09, $00 ; entry 19
    db $d8, $f0, $16, $00 ; entry 20
    db $d0, $10, $09, $00 ; entry 21
    db $e8, $e4, $15, $00 ; entry 22
    db $e8, $ec, $16, $00 ; entry 23
    db $e8, $f4, $17, $00 ; entry 24
    db $e8, $fc, $12, $00 ; entry 25
    db $f0, $f8, $15, $00 ; entry 26
    db $f0, $00, $16, $00 ; entry 27
    db $f0, $08, $17, $00 ; entry 28
    db $f8, $00, $05, $00 ; entry 29
    db $e8, $04, $09, $00 ; entry 30
    db $f8, $e8, $15, $00 ; entry 31
    db $f8, $f0, $16, $00 ; entry 32
    db $f8, $f8, $17, $00 ; entry 33
    db $f8, $08, $10, $00 ; entry 34
    db $f8, $10, $11, $00 ; entry 35
    db $f8, $18, $12, $00 ; entry 36
    db $f8, $28, $21, $00 ; entry 37
    db $f8, $d8, $21, $20 ; entry 38
    db $e8, $d0, $1f, $00 ; entry 39
    db $80 ; end

; frame 10 of MetaSprites3ESet0B; ends with $80 (E-0147)
MetaSprites3ESet0BFrame10::
    db $f8, $00, $0e, $00 ; entry 0
    db $e0, $28, $0b, $00 ; entry 1
    db $e0, $30, $0c, $00 ; entry 2
    db $e0, $38, $0d, $00 ; entry 3
    db $d8, $28, $05, $00 ; entry 4
    db $d8, $30, $06, $00 ; entry 5
    db $d8, $38, $08, $00 ; entry 6
    db $da, $40, $11, $00 ; entry 7
    db $da, $48, $12, $00 ; entry 8
    db $e8, $18, $0a, $00 ; entry 9
    db $e8, $20, $0b, $00 ; entry 10
    db $e8, $28, $0c, $00 ; entry 11
    db $e8, $30, $0d, $00 ; entry 12
    db $d0, $10, $10, $00 ; entry 13
    db $d0, $18, $11, $00 ; entry 14
    db $d0, $20, $12, $00 ; entry 15
    db $d0, $00, $0e, $00 ; entry 16
    db $d0, $08, $0f, $00 ; entry 17
    db $d8, $08, $19, $00 ; entry 18
    db $d8, $10, $1a, $00 ; entry 19
    db $d8, $18, $1b, $00 ; entry 20
    db $e0, $10, $15, $00 ; entry 21
    db $d8, $20, $14, $00 ; entry 22
    db $e0, $18, $1a, $00 ; entry 23
    db $e0, $20, $1b, $00 ; entry 24
    db $f0, $00, $19, $00 ; entry 25
    db $f0, $08, $1a, $00 ; entry 26
    db $f0, $20, $10, $00 ; entry 27
    db $f0, $28, $11, $00 ; entry 28
    db $f0, $18, $0f, $00 ; entry 29
    db $f0, $10, $1b, $00 ; entry 30
    db $d0, $28, $09, $00 ; entry 31
    db $f8, $f0, $19, $00 ; entry 32
    db $f8, $f8, $1a, $00 ; entry 33
    db $f8, $08, $1a, $60 ; entry 34
    db $f8, $10, $08, $00 ; entry 35
    db $f8, $18, $09, $00 ; entry 36
    db $f8, $28, $20, $00 ; entry 37
    db $f8, $e0, $20, $20 ; entry 38
    db $e2, $40, $1c, $00 ; entry 39
    db $80 ; end

; frame 11 of MetaSprites3ESet0B; ends with $80 (E-0147)
MetaSprites3ESet0BFrame11::
    db $e8, $10, $0b, $00 ; entry 0
    db $e8, $18, $0c, $00 ; entry 1
    db $e8, $20, $0d, $00 ; entry 2
    db $e0, $f0, $04, $00 ; entry 3
    db $d8, $08, $11, $00 ; entry 4
    db $d8, $10, $12, $00 ; entry 5
    db $e0, $f8, $0c, $00 ; entry 6
    db $e0, $00, $14, $00 ; entry 7
    db $e8, $08, $14, $00 ; entry 8
    db $d8, $f0, $15, $00 ; entry 9
    db $d8, $f8, $16, $00 ; entry 10
    db $d8, $00, $17, $00 ; entry 11
    db $f8, $00, $0c, $00 ; entry 12
    db $f8, $08, $0d, $00 ; entry 13
    db $f0, $f0, $05, $00 ; entry 14
    db $f0, $f8, $06, $00 ; entry 15
    db $f0, $00, $07, $00 ; entry 16
    db $f0, $08, $14, $00 ; entry 17
    db $f0, $10, $0f, $00 ; entry 18
    db $f8, $10, $17, $00 ; entry 19
    db $f0, $18, $17, $00 ; entry 20
    db $e0, $08, $06, $00 ; entry 21
    db $e0, $10, $07, $00 ; entry 22
    db $e0, $18, $08, $00 ; entry 23
    db $e0, $20, $09, $00 ; entry 24
    db $e8, $f8, $15, $00 ; entry 25
    db $e8, $00, $16, $00 ; entry 26
    db $f0, $e0, $15, $00 ; entry 27
    db $f0, $e8, $16, $00 ; entry 28
    db $d8, $18, $09, $00 ; entry 29
    db $f8, $f0, $1a, $00 ; entry 30
    db $f8, $f8, $1b, $00 ; entry 31
    db $f8, $20, $21, $00 ; entry 32
    db $f8, $d8, $21, $20 ; entry 33
    db $f8, $28, $13, $00 ; entry 34
    db $f8, $d0, $13, $20 ; entry 35
    db $f0, $30, $1d, $00 ; entry 36
    db $f8, $c8, $1c, $00 ; entry 37
    db $e0, $e8, $1e, $00 ; entry 38
    db $e0, $28, $1f, $00 ; entry 39
    db $80 ; end

; frame 12 of MetaSprites3ESet0B; ends with $80 (E-0147)
MetaSprites3ESet0BFrame12::
    db $d0, $f8, $05, $00 ; entry 0
    db $e0, $ec, $0b, $00 ; entry 1
    db $e0, $f4, $0c, $00 ; entry 2
    db $e0, $fc, $0d, $00 ; entry 3
    db $d0, $00, $06, $00 ; entry 4
    db $d0, $08, $08, $00 ; entry 5
    db $d0, $f0, $14, $00 ; entry 6
    db $d0, $d0, $15, $00 ; entry 7
    db $d0, $d8, $16, $00 ; entry 8
    db $d0, $e0, $17, $00 ; entry 9
    db $d0, $e8, $0e, $00 ; entry 10
    db $d8, $d8, $19, $00 ; entry 11
    db $d8, $e0, $1a, $00 ; entry 12
    db $d8, $e8, $14, $00 ; entry 13
    db $e0, $d4, $19, $00 ; entry 14
    db $e0, $dc, $1a, $00 ; entry 15
    db $e0, $e4, $0d, $00 ; entry 16
    db $d8, $f8, $07, $00 ; entry 17
    db $d8, $00, $08, $00 ; entry 18
    db $d8, $08, $09, $00 ; entry 19
    db $d8, $f0, $16, $00 ; entry 20
    db $d0, $10, $09, $00 ; entry 21
    db $e8, $e4, $15, $00 ; entry 22
    db $e8, $ec, $16, $00 ; entry 23
    db $e8, $f4, $17, $00 ; entry 24
    db $e8, $fc, $12, $00 ; entry 25
    db $f0, $f8, $15, $00 ; entry 26
    db $f0, $00, $16, $00 ; entry 27
    db $f0, $08, $17, $00 ; entry 28
    db $f8, $00, $05, $00 ; entry 29
    db $e8, $04, $09, $00 ; entry 30
    db $f8, $e8, $15, $00 ; entry 31
    db $f8, $f0, $16, $00 ; entry 32
    db $f8, $f8, $17, $00 ; entry 33
    db $f8, $08, $10, $00 ; entry 34
    db $f8, $10, $11, $00 ; entry 35
    db $f8, $18, $12, $00 ; entry 36
    db $f8, $28, $20, $00 ; entry 37
    db $f8, $d8, $20, $20 ; entry 38
    db $e8, $40, $1d, $00 ; entry 39
    db $80 ; end

; frame 13 of MetaSprites3ESet0B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet0BFrame13::
    db $f8, $f8, $0e, $00 ; entry 0
    db $e0, $20, $0b, $00 ; entry 1
    db $e0, $28, $0c, $00 ; entry 2
    db $e0, $30, $0d, $00 ; entry 3
    db $d8, $20, $05, $00 ; entry 4
    db $d8, $28, $06, $00 ; entry 5
    db $d8, $30, $08, $00 ; entry 6
    db $da, $38, $11, $00 ; entry 7
    db $da, $40, $12, $00 ; entry 8
    db $e8, $10, $0a, $00 ; entry 9
    db $e8, $18, $0b, $00 ; entry 10
    db $e8, $20, $0c, $00 ; entry 11
    db $e8, $28, $0d, $00 ; entry 12
    db $d0, $08, $10, $00 ; entry 13
    db $d0, $10, $11, $00 ; entry 14
    db $d0, $18, $12, $00 ; entry 15
    db $d0, $f8, $0e, $00 ; entry 16
    db $d0, $00, $0f, $00 ; entry 17
    db $d8, $00, $19, $00 ; entry 18
    db $d8, $08, $1a, $00 ; entry 19
    db $d8, $10, $1b, $00 ; entry 20
    db $e0, $08, $15, $00 ; entry 21
    db $d8, $18, $14, $00 ; entry 22
    db $e0, $10, $1a, $00 ; entry 23
    db $e0, $18, $1b, $00 ; entry 24
    db $f0, $f8, $19, $00 ; entry 25
    db $f0, $00, $1a, $00 ; entry 26
    db $f0, $18, $10, $00 ; entry 27
    db $f0, $20, $11, $00 ; entry 28
    db $f0, $10, $0f, $00 ; entry 29
    db $f0, $08, $1b, $00 ; entry 30
    db $d0, $20, $09, $00 ; entry 31
    db $f8, $e8, $19, $00 ; entry 32
    db $f8, $f0, $1a, $00 ; entry 33
    db $f8, $00, $1a, $60 ; entry 34
    db $f8, $08, $08, $00 ; entry 35
    db $f8, $10, $09, $00 ; entry 36
    db $f8, $d8, $13, $00 ; entry 37
    db $f8, $20, $13, $20 ; entry 38
    db $d0, $e0, $1f, $00 ; entry 39
    db $80 ; end

; frame 14 of MetaSprites3ESet0B; ends with $80 (E-0147)
MetaSprites3ESet0BFrame14::
    db $e8, $00, $0b, $00 ; entry 0
    db $e8, $08, $0c, $00 ; entry 1
    db $e8, $10, $0d, $00 ; entry 2
    db $e0, $e0, $04, $00 ; entry 3
    db $d8, $f8, $11, $00 ; entry 4
    db $d8, $00, $12, $00 ; entry 5
    db $e0, $e8, $0c, $00 ; entry 6
    db $e0, $f0, $14, $00 ; entry 7
    db $e8, $f8, $14, $00 ; entry 8
    db $d8, $e0, $15, $00 ; entry 9
    db $d8, $e8, $16, $00 ; entry 10
    db $d8, $f0, $17, $00 ; entry 11
    db $f8, $f0, $0c, $00 ; entry 12
    db $f8, $f8, $0d, $00 ; entry 13
    db $f0, $e0, $05, $00 ; entry 14
    db $f0, $e8, $06, $00 ; entry 15
    db $f0, $f0, $07, $00 ; entry 16
    db $f0, $f8, $14, $00 ; entry 17
    db $f0, $00, $0f, $00 ; entry 18
    db $f8, $00, $17, $00 ; entry 19
    db $f0, $08, $17, $00 ; entry 20
    db $e0, $f8, $06, $00 ; entry 21
    db $e0, $00, $07, $00 ; entry 22
    db $e0, $08, $08, $00 ; entry 23
    db $e0, $10, $09, $00 ; entry 24
    db $e8, $e8, $15, $00 ; entry 25
    db $e8, $f0, $16, $00 ; entry 26
    db $f0, $d0, $15, $00 ; entry 27
    db $f0, $d8, $16, $00 ; entry 28
    db $d8, $08, $09, $00 ; entry 29
    db $f8, $e0, $1a, $00 ; entry 30
    db $f8, $e8, $1b, $00 ; entry 31
    db $f8, $10, $20, $00 ; entry 32
    db $f8, $18, $21, $00 ; entry 33
    db $f8, $c8, $20, $20 ; entry 34
    db $f8, $c0, $21, $20 ; entry 35
    db $f8, $38, $1c, $20 ; entry 36
    db $e8, $d8, $1d, $20 ; entry 37
    db $f0, $18, $1e, $20 ; entry 38
    db $d8, $d0, $1f, $20 ; entry 39
    db $80 ; end

; frame 15 of MetaSprites3ESet0B; ends with $80 (E-0147)
MetaSprites3ESet0BFrame15::
    db $d0, $e8, $05, $00 ; entry 0
    db $e0, $dc, $0b, $00 ; entry 1
    db $e0, $e4, $0c, $00 ; entry 2
    db $e0, $ec, $0d, $00 ; entry 3
    db $d0, $f0, $06, $00 ; entry 4
    db $d0, $f8, $08, $00 ; entry 5
    db $d0, $e0, $14, $00 ; entry 6
    db $d0, $c0, $15, $00 ; entry 7
    db $d0, $c8, $16, $00 ; entry 8
    db $d0, $d0, $17, $00 ; entry 9
    db $d0, $d8, $0e, $00 ; entry 10
    db $d8, $c8, $19, $00 ; entry 11
    db $d8, $d0, $1a, $00 ; entry 12
    db $d8, $d8, $14, $00 ; entry 13
    db $e0, $c4, $19, $00 ; entry 14
    db $e0, $cc, $1a, $00 ; entry 15
    db $e0, $d4, $0d, $00 ; entry 16
    db $d8, $e8, $07, $00 ; entry 17
    db $d8, $f0, $08, $00 ; entry 18
    db $d8, $f8, $09, $00 ; entry 19
    db $d8, $e0, $16, $00 ; entry 20
    db $d0, $00, $09, $00 ; entry 21
    db $e8, $d4, $15, $00 ; entry 22
    db $e8, $dc, $16, $00 ; entry 23
    db $e8, $e4, $17, $00 ; entry 24
    db $e8, $ec, $12, $00 ; entry 25
    db $f0, $e8, $15, $00 ; entry 26
    db $f0, $f0, $16, $00 ; entry 27
    db $f0, $f8, $17, $00 ; entry 28
    db $f8, $f0, $05, $00 ; entry 29
    db $e8, $f4, $09, $00 ; entry 30
    db $f8, $d8, $15, $00 ; entry 31
    db $f8, $e0, $16, $00 ; entry 32
    db $f8, $e8, $17, $00 ; entry 33
    db $f8, $f8, $10, $00 ; entry 34
    db $f8, $00, $11, $00 ; entry 35
    db $f8, $08, $12, $00 ; entry 36
    db $f8, $c8, $13, $00 ; entry 37
    db $f8, $18, $13, $20 ; entry 38
    db $e8, $30, $1c, $40 ; entry 39
    db $80 ; end

; frame 16 of MetaSprites3ESet0B; ends with $80 (E-0147)
MetaSprites3ESet0BFrame16::
    db $f8, $e8, $0e, $00 ; entry 0
    db $e0, $10, $0b, $00 ; entry 1
    db $e0, $18, $0c, $00 ; entry 2
    db $e0, $20, $0d, $00 ; entry 3
    db $d8, $10, $05, $00 ; entry 4
    db $d8, $18, $06, $00 ; entry 5
    db $d8, $20, $08, $00 ; entry 6
    db $da, $28, $11, $00 ; entry 7
    db $da, $30, $12, $00 ; entry 8
    db $e8, $00, $0a, $00 ; entry 9
    db $e8, $08, $0b, $00 ; entry 10
    db $e8, $10, $0c, $00 ; entry 11
    db $e8, $18, $0d, $00 ; entry 12
    db $d0, $f8, $10, $00 ; entry 13
    db $d0, $00, $11, $00 ; entry 14
    db $d0, $08, $12, $00 ; entry 15
    db $d0, $e8, $0e, $00 ; entry 16
    db $d0, $f0, $0f, $00 ; entry 17
    db $d8, $f0, $19, $00 ; entry 18
    db $d8, $f8, $1a, $00 ; entry 19
    db $d8, $00, $1b, $00 ; entry 20
    db $e0, $f8, $15, $00 ; entry 21
    db $d8, $08, $14, $00 ; entry 22
    db $e0, $00, $1a, $00 ; entry 23
    db $e0, $08, $1b, $00 ; entry 24
    db $f0, $e8, $19, $00 ; entry 25
    db $f0, $f0, $1a, $00 ; entry 26
    db $f0, $08, $10, $00 ; entry 27
    db $f0, $10, $11, $00 ; entry 28
    db $f0, $00, $0f, $00 ; entry 29
    db $f0, $f8, $1b, $00 ; entry 30
    db $d0, $10, $09, $00 ; entry 31
    db $f8, $d8, $19, $00 ; entry 32
    db $f8, $e0, $1a, $00 ; entry 33
    db $f8, $f0, $1a, $60 ; entry 34
    db $f8, $f8, $08, $00 ; entry 35
    db $f8, $00, $09, $00 ; entry 36
    db $f8, $10, $21, $00 ; entry 37
    db $f8, $c8, $21, $20 ; entry 38
    db $e8, $48, $1d, $00 ; entry 39
    db $80 ; end

; frame 17 of MetaSprites3ESet0B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet0BFrame17::
    db $e8, $f8, $0b, $00 ; entry 0
    db $e8, $00, $0c, $00 ; entry 1
    db $e8, $08, $0d, $00 ; entry 2
    db $e0, $d8, $04, $00 ; entry 3
    db $d8, $f0, $11, $00 ; entry 4
    db $d8, $f8, $12, $00 ; entry 5
    db $e0, $e0, $0c, $00 ; entry 6
    db $e0, $e8, $14, $00 ; entry 7
    db $e8, $f0, $14, $00 ; entry 8
    db $d8, $d8, $15, $00 ; entry 9
    db $d8, $e0, $16, $00 ; entry 10
    db $d8, $e8, $17, $00 ; entry 11
    db $f8, $e8, $0c, $00 ; entry 12
    db $f8, $f0, $0d, $00 ; entry 13
    db $f0, $d8, $05, $00 ; entry 14
    db $f0, $e0, $06, $00 ; entry 15
    db $f0, $e8, $07, $00 ; entry 16
    db $f0, $f0, $14, $00 ; entry 17
    db $f0, $f8, $0f, $00 ; entry 18
    db $f8, $f8, $17, $00 ; entry 19
    db $f0, $00, $17, $00 ; entry 20
    db $e0, $f0, $06, $00 ; entry 21
    db $e0, $f8, $07, $00 ; entry 22
    db $e0, $00, $08, $00 ; entry 23
    db $e0, $08, $09, $00 ; entry 24
    db $e8, $e0, $15, $00 ; entry 25
    db $e8, $e8, $16, $00 ; entry 26
    db $f0, $c8, $15, $00 ; entry 27
    db $f0, $d0, $16, $00 ; entry 28
    db $d8, $00, $09, $00 ; entry 29
    db $f8, $d8, $1a, $00 ; entry 30
    db $f8, $e0, $1b, $00 ; entry 31
    db $f8, $10, $20, $00 ; entry 32
    db $f8, $c0, $20, $20 ; entry 33
    db $f8, $c8, $13, $20 ; entry 34
    db $f8, $08, $13, $00 ; entry 35
    db $e8, $10, $1c, $20 ; entry 36
    db $e8, $d8, $1d, $20 ; entry 37
    db $d0, $e0, $1f, $20 ; entry 38
    db $d0, $38, $1e, $20 ; entry 39
    db $80 ; end

; frame 18 of MetaSprites3ESet0B; ends with $80 (E-0147)
MetaSprites3ESet0BFrame18::
    db $d0, $d8, $05, $00 ; entry 0
    db $e0, $cc, $0b, $00 ; entry 1
    db $e0, $d4, $0c, $00 ; entry 2
    db $e0, $dc, $0d, $00 ; entry 3
    db $d0, $e0, $06, $00 ; entry 4
    db $d0, $e8, $08, $00 ; entry 5
    db $d0, $d0, $14, $00 ; entry 6
    db $d0, $b0, $15, $00 ; entry 7
    db $d0, $b8, $16, $00 ; entry 8
    db $d0, $c0, $17, $00 ; entry 9
    db $d0, $c8, $0e, $00 ; entry 10
    db $d8, $b8, $19, $00 ; entry 11
    db $d8, $c0, $1a, $00 ; entry 12
    db $d8, $c8, $14, $00 ; entry 13
    db $e0, $b4, $19, $00 ; entry 14
    db $e0, $bc, $1a, $00 ; entry 15
    db $e0, $c4, $0d, $00 ; entry 16
    db $d8, $d8, $07, $00 ; entry 17
    db $d8, $e0, $08, $00 ; entry 18
    db $d8, $e8, $09, $00 ; entry 19
    db $d8, $d0, $16, $00 ; entry 20
    db $d0, $f0, $09, $00 ; entry 21
    db $e8, $c4, $15, $00 ; entry 22
    db $e8, $cc, $16, $00 ; entry 23
    db $e8, $d4, $17, $00 ; entry 24
    db $e8, $dc, $12, $00 ; entry 25
    db $f0, $d8, $15, $00 ; entry 26
    db $f0, $e0, $16, $00 ; entry 27
    db $f0, $e8, $17, $00 ; entry 28
    db $f8, $e0, $05, $00 ; entry 29
    db $e8, $e4, $09, $00 ; entry 30
    db $f8, $c8, $15, $00 ; entry 31
    db $f8, $d0, $16, $00 ; entry 32
    db $f8, $d8, $17, $00 ; entry 33
    db $f8, $e8, $10, $00 ; entry 34
    db $f8, $f0, $11, $00 ; entry 35
    db $f8, $f8, $12, $00 ; entry 36
    db $f8, $08, $21, $00 ; entry 37
    db $f8, $b8, $21, $20 ; entry 38
    db $d0, $00, $1f, $00 ; entry 39
    db $80 ; end

; frame 19 of MetaSprites3ESet0B; ends with $80 (E-0147)
MetaSprites3ESet0BFrame19::
    db $f8, $e8, $0e, $00 ; entry 0
    db $e0, $10, $0b, $00 ; entry 1
    db $e0, $18, $0c, $00 ; entry 2
    db $e0, $20, $0d, $00 ; entry 3
    db $d8, $10, $05, $00 ; entry 4
    db $d8, $18, $06, $00 ; entry 5
    db $d8, $20, $08, $00 ; entry 6
    db $da, $28, $11, $00 ; entry 7
    db $da, $30, $12, $00 ; entry 8
    db $e8, $00, $0a, $00 ; entry 9
    db $e8, $08, $0b, $00 ; entry 10
    db $e8, $10, $0c, $00 ; entry 11
    db $e8, $18, $0d, $00 ; entry 12
    db $d0, $f8, $10, $00 ; entry 13
    db $d0, $00, $11, $00 ; entry 14
    db $d0, $08, $12, $00 ; entry 15
    db $d0, $e8, $0e, $00 ; entry 16
    db $d0, $f0, $0f, $00 ; entry 17
    db $d8, $f0, $19, $00 ; entry 18
    db $d8, $f8, $1a, $00 ; entry 19
    db $d8, $00, $1b, $00 ; entry 20
    db $e0, $f8, $15, $00 ; entry 21
    db $d8, $08, $14, $00 ; entry 22
    db $e0, $00, $1a, $00 ; entry 23
    db $e0, $08, $1b, $00 ; entry 24
    db $f0, $e8, $19, $00 ; entry 25
    db $f0, $f0, $1a, $00 ; entry 26
    db $f0, $08, $10, $00 ; entry 27
    db $f0, $10, $11, $00 ; entry 28
    db $f0, $00, $0f, $00 ; entry 29
    db $f0, $f8, $1b, $00 ; entry 30
    db $d0, $10, $09, $00 ; entry 31
    db $f8, $d8, $19, $00 ; entry 32
    db $f8, $e0, $1a, $00 ; entry 33
    db $f8, $f0, $1a, $60 ; entry 34
    db $f8, $f8, $08, $00 ; entry 35
    db $f8, $00, $09, $00 ; entry 36
    db $f8, $c8, $13, $00 ; entry 37
    db $f8, $10, $13, $20 ; entry 38
    db $f0, $e0, $1e, $40 ; entry 39
    db $80 ; end

; frame 20 of MetaSprites3ESet0B; ends with $80 (E-0147)
MetaSprites3ESet0BFrame20::
    db $e8, $00, $0b, $00 ; entry 0
    db $e8, $08, $0c, $00 ; entry 1
    db $e8, $10, $0d, $00 ; entry 2
    db $e0, $e0, $04, $00 ; entry 3
    db $d8, $f8, $11, $00 ; entry 4
    db $d8, $00, $12, $00 ; entry 5
    db $e0, $e8, $0c, $00 ; entry 6
    db $e0, $f0, $14, $00 ; entry 7
    db $e8, $f8, $14, $00 ; entry 8
    db $d8, $e0, $15, $00 ; entry 9
    db $d8, $e8, $16, $00 ; entry 10
    db $d8, $f0, $17, $00 ; entry 11
    db $f8, $f0, $0c, $00 ; entry 12
    db $f8, $f8, $0d, $00 ; entry 13
    db $f0, $e0, $05, $00 ; entry 14
    db $f0, $e8, $06, $00 ; entry 15
    db $f0, $f0, $07, $00 ; entry 16
    db $f0, $f8, $14, $00 ; entry 17
    db $f0, $00, $0f, $00 ; entry 18
    db $f8, $00, $17, $00 ; entry 19
    db $f0, $08, $17, $00 ; entry 20
    db $e0, $f8, $06, $00 ; entry 21
    db $e0, $00, $07, $00 ; entry 22
    db $e0, $08, $08, $00 ; entry 23
    db $e0, $10, $09, $00 ; entry 24
    db $e8, $e8, $15, $00 ; entry 25
    db $e8, $f0, $16, $00 ; entry 26
    db $f0, $d0, $15, $00 ; entry 27
    db $f0, $d8, $16, $00 ; entry 28
    db $d8, $08, $09, $00 ; entry 29
    db $f8, $e0, $1a, $00 ; entry 30
    db $f8, $e8, $1b, $00 ; entry 31
    db $f8, $10, $21, $00 ; entry 32
    db $f8, $18, $20, $00 ; entry 33
    db $f8, $c8, $20, $20 ; entry 34
    db $f8, $d0, $21, $20 ; entry 35
    db $f0, $18, $1d, $00 ; entry 36
    db $d0, $f0, $1c, $00 ; entry 37
    db $d8, $10, $1d, $00 ; entry 38
    db $d8, $30, $1c, $00 ; entry 39
    db $80 ; end

; frame 21 of MetaSprites3ESet0B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet0BFrame21::
    db $d0, $f0, $05, $00 ; entry 0
    db $e0, $e4, $0b, $00 ; entry 1
    db $e0, $ec, $0c, $00 ; entry 2
    db $e0, $f4, $0d, $00 ; entry 3
    db $d0, $f8, $06, $00 ; entry 4
    db $d0, $00, $08, $00 ; entry 5
    db $d0, $e8, $14, $00 ; entry 6
    db $d0, $c8, $15, $00 ; entry 7
    db $d0, $d0, $16, $00 ; entry 8
    db $d0, $d8, $17, $00 ; entry 9
    db $d0, $e0, $0e, $00 ; entry 10
    db $d8, $d0, $19, $00 ; entry 11
    db $d8, $d8, $1a, $00 ; entry 12
    db $d8, $e0, $14, $00 ; entry 13
    db $e0, $cc, $19, $00 ; entry 14
    db $e0, $d4, $1a, $00 ; entry 15
    db $e0, $dc, $0d, $00 ; entry 16
    db $d8, $f0, $07, $00 ; entry 17
    db $d8, $f8, $08, $00 ; entry 18
    db $d8, $00, $09, $00 ; entry 19
    db $d8, $e8, $16, $00 ; entry 20
    db $d0, $08, $09, $00 ; entry 21
    db $e8, $dc, $15, $00 ; entry 22
    db $e8, $e4, $16, $00 ; entry 23
    db $e8, $ec, $17, $00 ; entry 24
    db $e8, $f4, $12, $00 ; entry 25
    db $f0, $f0, $15, $00 ; entry 26
    db $f0, $f8, $16, $00 ; entry 27
    db $f0, $00, $17, $00 ; entry 28
    db $f8, $f8, $05, $00 ; entry 29
    db $e8, $fc, $09, $00 ; entry 30
    db $f8, $e0, $15, $00 ; entry 31
    db $f8, $e8, $16, $00 ; entry 32
    db $f8, $f0, $17, $00 ; entry 33
    db $f8, $00, $10, $00 ; entry 34
    db $f8, $08, $11, $00 ; entry 35
    db $f8, $10, $12, $00 ; entry 36
    db $f8, $d0, $21, $00 ; entry 37
    db $f8, $20, $21, $20 ; entry 38
    db $f8, $b0, $1e, $20 ; entry 39
    db $80 ; end

; frame 22 of MetaSprites3ESet0B; ends with $80 (E-0147)
MetaSprites3ESet0BFrame22::
    db $f8, $08, $0e, $00 ; entry 0
    db $e0, $30, $0b, $00 ; entry 1
    db $e0, $38, $0c, $00 ; entry 2
    db $d8, $30, $05, $00 ; entry 3
    db $d8, $38, $06, $00 ; entry 4
    db $e8, $20, $0a, $00 ; entry 5
    db $e8, $28, $0b, $00 ; entry 6
    db $e8, $30, $0c, $00 ; entry 7
    db $e8, $38, $0d, $00 ; entry 8
    db $d0, $18, $10, $00 ; entry 9
    db $d0, $20, $11, $00 ; entry 10
    db $d0, $28, $12, $00 ; entry 11
    db $d0, $08, $0e, $00 ; entry 12
    db $d0, $10, $0f, $00 ; entry 13
    db $d8, $10, $19, $00 ; entry 14
    db $d8, $18, $1a, $00 ; entry 15
    db $d8, $20, $1b, $00 ; entry 16
    db $e0, $18, $15, $00 ; entry 17
    db $d8, $28, $14, $00 ; entry 18
    db $e0, $20, $1a, $00 ; entry 19
    db $e0, $28, $1b, $00 ; entry 20
    db $f0, $08, $19, $00 ; entry 21
    db $f0, $10, $1a, $00 ; entry 22
    db $f0, $28, $10, $00 ; entry 23
    db $f0, $30, $11, $00 ; entry 24
    db $f0, $20, $0f, $00 ; entry 25
    db $f0, $18, $1b, $00 ; entry 26
    db $d0, $30, $09, $00 ; entry 27
    db $f8, $f8, $19, $00 ; entry 28
    db $f8, $00, $1a, $00 ; entry 29
    db $f8, $10, $1a, $60 ; entry 30
    db $f8, $18, $08, $00 ; entry 31
    db $f8, $20, $09, $00 ; entry 32
    db $e0, $40, $0d, $00 ; entry 33
    db $d8, $40, $08, $00 ; entry 34
    db $da, $48, $11, $00 ; entry 35
    db $f8, $30, $13, $00 ; entry 36
    db $f8, $e8, $13, $20 ; entry 37
    db $e8, $d8, $1f, $00 ; entry 38
    db $d0, $f0, $1d, $00 ; entry 39
    db $80 ; end

; frame 23 of MetaSprites3ESet0B; ends with $80 (E-0147)
MetaSprites3ESet0BFrame23::
    db $e8, $28, $0b, $00 ; entry 0
    db $e8, $30, $0c, $00 ; entry 1
    db $e8, $38, $0d, $00 ; entry 2
    db $e0, $08, $04, $00 ; entry 3
    db $d8, $20, $11, $00 ; entry 4
    db $d8, $28, $12, $00 ; entry 5
    db $e0, $10, $0c, $00 ; entry 6
    db $e0, $18, $14, $00 ; entry 7
    db $e8, $20, $14, $00 ; entry 8
    db $d8, $08, $15, $00 ; entry 9
    db $d8, $10, $16, $00 ; entry 10
    db $d8, $18, $17, $00 ; entry 11
    db $f8, $18, $0c, $00 ; entry 12
    db $f8, $20, $0d, $00 ; entry 13
    db $f0, $08, $05, $00 ; entry 14
    db $f0, $10, $06, $00 ; entry 15
    db $f0, $18, $07, $00 ; entry 16
    db $f0, $20, $14, $00 ; entry 17
    db $f0, $28, $0f, $00 ; entry 18
    db $f8, $28, $17, $00 ; entry 19
    db $f0, $30, $17, $00 ; entry 20
    db $e0, $20, $06, $00 ; entry 21
    db $e0, $28, $07, $00 ; entry 22
    db $e0, $30, $08, $00 ; entry 23
    db $e0, $38, $09, $00 ; entry 24
    db $e8, $10, $15, $00 ; entry 25
    db $e8, $18, $16, $00 ; entry 26
    db $f0, $f8, $15, $00 ; entry 27
    db $f0, $00, $16, $00 ; entry 28
    db $d8, $30, $09, $00 ; entry 29
    db $f8, $08, $1a, $00 ; entry 30
    db $f8, $10, $1b, $00 ; entry 31
    db $f8, $38, $20, $00 ; entry 32
    db $f8, $40, $21, $00 ; entry 33
    db $f8, $f8, $20, $20 ; entry 34
    db $f8, $f0, $21, $20 ; entry 35
    db $e0, $00, $1f, $00 ; entry 36
    db $f8, $d8, $1d, $00 ; entry 37
    db $d0, $20, $1f, $00 ; entry 38
    db $e0, $48, $1c, $00 ; entry 39
    db $80 ; end

; frame 24 of MetaSprites3ESet0B; ends with $80 (E-0147)
MetaSprites3ESet0BFrame24::
    db $d0, $20, $05, $00 ; entry 0
    db $e0, $14, $0b, $00 ; entry 1
    db $e0, $1c, $0c, $00 ; entry 2
    db $e0, $24, $0d, $00 ; entry 3
    db $d0, $28, $06, $00 ; entry 4
    db $d0, $30, $08, $00 ; entry 5
    db $d0, $18, $14, $00 ; entry 6
    db $d0, $f8, $15, $00 ; entry 7
    db $d0, $00, $16, $00 ; entry 8
    db $d0, $08, $17, $00 ; entry 9
    db $d0, $10, $0e, $00 ; entry 10
    db $d8, $00, $19, $00 ; entry 11
    db $d8, $08, $1a, $00 ; entry 12
    db $d8, $10, $14, $00 ; entry 13
    db $e0, $fc, $19, $00 ; entry 14
    db $e0, $04, $1a, $00 ; entry 15
    db $e0, $0c, $0d, $00 ; entry 16
    db $d8, $20, $07, $00 ; entry 17
    db $d8, $28, $08, $00 ; entry 18
    db $d8, $30, $09, $00 ; entry 19
    db $d8, $18, $16, $00 ; entry 20
    db $d0, $38, $09, $00 ; entry 21
    db $e8, $0c, $15, $00 ; entry 22
    db $e8, $14, $16, $00 ; entry 23
    db $e8, $1c, $17, $00 ; entry 24
    db $e8, $24, $12, $00 ; entry 25
    db $f0, $20, $15, $00 ; entry 26
    db $f0, $28, $16, $00 ; entry 27
    db $f0, $30, $17, $00 ; entry 28
    db $f8, $28, $05, $00 ; entry 29
    db $e8, $2c, $09, $00 ; entry 30
    db $f8, $10, $15, $00 ; entry 31
    db $f8, $18, $16, $00 ; entry 32
    db $f8, $20, $17, $00 ; entry 33
    db $f8, $30, $10, $00 ; entry 34
    db $f8, $38, $11, $00 ; entry 35
    db $f8, $00, $20, $00 ; entry 36
    db $f8, $48, $20, $20 ; entry 37
    db $f8, $f0, $1c, $00 ; entry 38
    db $e8, $34, $1d, $00 ; entry 39
    db $80 ; end

; frame 25 of MetaSprites3ESet0B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet0BFrame25::
    db $f8, $40, $0e, $00 ; entry 0
    db $d0, $40, $0e, $00 ; entry 1
    db $d0, $48, $0f, $00 ; entry 2
    db $d8, $48, $19, $00 ; entry 3
    db $f0, $40, $19, $00 ; entry 4
    db $f0, $48, $1a, $00 ; entry 5
    db $f8, $30, $19, $00 ; entry 6
    db $f8, $38, $1a, $00 ; entry 7
    db $f8, $48, $1a, $60 ; entry 8
    db $f8, $20, $20, $20 ; entry 9
    db $f8, $18, $21, $20 ; entry 10
    db $e8, $00, $1c, $20 ; entry 11
    db $e8, $28, $1f, $00 ; entry 12
    db $f8, $10, $1e, $20 ; entry 13
    db $80 ; end

; frame 26 of MetaSprites3ESet0B; ends with $80 (E-0147)
MetaSprites3ESet0BFrame26::
    db $d0, $20, $1d, $00 ; entry 0
    db $d8, $38, $1f, $00 ; entry 1
    db $f8, $48, $1c, $00 ; entry 2
    db $d0, $48, $1e, $00 ; entry 3
    db $80 ; end

; frame 27 of MetaSprites3ESet0B; ends with $80 (E-0147)
MetaSprites3ESet0BFrame27::
    db $80 ; end

; meta-sprite set 12 of MetaSprites3ETable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3ESet0C::
    dw MetaSprites3ESet0CFrame0 ; entry 0
    dw MetaSprites3ESet0CFrame1 ; entry 1
    dw MetaSprites3ESet0CFrame2 ; entry 2
    dw MetaSprites3ESet0CFrame3 ; entry 3
    dw MetaSprites3ESet0CFrame4 ; entry 4
    dw MetaSprites3ESet0CFrame5 ; entry 5
    dw MetaSprites3ESet0CFrame6 ; entry 6
    dw MetaSprites3ESet0CFrame7 ; entry 7
    dw MetaSprites3ESet0CFrame8 ; entry 8
    dw MetaSprites3ESet0CFrame9 ; entry 9
    dw MetaSprites3ESet0CFrame10 ; entry 10
    dw MetaSprites3ESet0CFrame11 ; entry 11
    dw MetaSprites3ESet0CFrame12 ; entry 12
    dw MetaSprites3ESet0CFrame13 ; entry 13
    dw MetaSprites3ESet0CFrame14 ; entry 14
    dw MetaSprites3ESet0CFrame15 ; entry 15
    dw MetaSprites3ESet0CFrame16 ; entry 16
    dw MetaSprites3ESet0CFrame17 ; entry 17
    dw MetaSprites3ESet0CFrame18 ; entry 18
    dw MetaSprites3ESet0CFrame19 ; entry 19
    dw MetaSprites3ESet0CFrame19 ; entry 20
    dw MetaSprites3ESet0CFrame19 ; entry 21
    dw MetaSprites3ESet0CFrame19 ; entry 22
    dw MetaSprites3ESet0CFrame19 ; entry 23
    dw MetaSprites3ESet0CFrame19 ; entry 24
    dw MetaSprites3ESet0CFrame19 ; entry 25
    dw MetaSprites3ESet0CFrame19 ; entry 26
    dw MetaSprites3ESet0CFrame19 ; entry 27
    dw MetaSprites3ESet0CFrame19 ; entry 28
    dw MetaSprites3ESet0CFrame19 ; entry 29
    dw MetaSprites3ESet0CFrame19 ; entry 30
    dw MetaSprites3ESet0CFrame19 ; entry 31

; frame 0 of MetaSprites3ESet0C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet0CFrame0::
    db $f8, $b0, $04, $00 ; entry 0
    db $f8, $b8, $05, $00 ; entry 1
    db $f0, $b0, $01, $00 ; entry 2
    db $f0, $b8, $02, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites3ESet0C; ends with $80 (E-0147)
MetaSprites3ESet0CFrame1::
    db $f8, $c4, $13, $20 ; entry 0
    db $f8, $bc, $14, $20 ; entry 1
    db $f8, $b4, $15, $20 ; entry 2
    db $f0, $c4, $10, $20 ; entry 3
    db $f0, $bc, $11, $20 ; entry 4
    db $f0, $b4, $12, $20 ; entry 5
    db $e8, $c4, $0e, $20 ; entry 6
    db $e8, $bc, $0f, $20 ; entry 7
    db $f0, $ac, $1c, $00 ; entry 8
    db $f8, $ac, $1d, $00 ; entry 9
    db $80 ; end

; frame 2 of MetaSprites3ESet0C; ends with $80 (E-0147)
MetaSprites3ESet0CFrame2::
    db $f8, $c0, $14, $00 ; entry 0
    db $f8, $c8, $15, $00 ; entry 1
    db $f0, $b8, $10, $00 ; entry 2
    db $f0, $c0, $11, $00 ; entry 3
    db $f0, $c8, $12, $00 ; entry 4
    db $e8, $b8, $0e, $00 ; entry 5
    db $e8, $c0, $0f, $00 ; entry 6
    db $f0, $b0, $01, $20 ; entry 7
    db $f8, $b0, $04, $20 ; entry 8
    db $f8, $d0, $18, $00 ; entry 9
    db $f8, $b8, $16, $20 ; entry 10
    db $80 ; end

; frame 3 of MetaSprites3ESet0C; ends with $80 (E-0147)
MetaSprites3ESet0CFrame3::
    db $f8, $c4, $14, $20 ; entry 0
    db $f8, $bc, $15, $20 ; entry 1
    db $f0, $cc, $10, $20 ; entry 2
    db $f0, $c4, $11, $20 ; entry 3
    db $f0, $bc, $12, $20 ; entry 4
    db $e8, $cc, $0e, $20 ; entry 5
    db $e8, $c4, $0f, $00 ; entry 6
    db $f0, $b4, $01, $20 ; entry 7
    db $f8, $b4, $04, $20 ; entry 8
    db $f8, $d4, $08, $00 ; entry 9
    db $f0, $d4, $06, $00 ; entry 10
    db $f0, $dc, $07, $00 ; entry 11
    db $f8, $cc, $17, $20 ; entry 12
    db $f8, $dc, $19, $00 ; entry 13
    db $f0, $ac, $1e, $00 ; entry 14
    db $f8, $ac, $1f, $00 ; entry 15
    db $80 ; end

; frame 4 of MetaSprites3ESet0C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet0CFrame4::
    db $f8, $b8, $08, $20 ; entry 0
    db $f8, $b0, $09, $20 ; entry 1
    db $f0, $b8, $06, $20 ; entry 2
    db $f0, $b0, $07, $20 ; entry 3
    db $f8, $c0, $03, $00 ; entry 4
    db $f8, $c8, $04, $00 ; entry 5
    db $f8, $d0, $05, $00 ; entry 6
    db $f0, $c0, $00, $00 ; entry 7
    db $f0, $c8, $01, $00 ; entry 8
    db $f0, $d0, $02, $00 ; entry 9
    db $f8, $e0, $04, $20 ; entry 10
    db $f8, $d8, $05, $20 ; entry 11
    db $f0, $e8, $00, $20 ; entry 12
    db $f0, $e0, $01, $20 ; entry 13
    db $f0, $d8, $02, $20 ; entry 14
    db $f8, $e8, $1a, $00 ; entry 15
    db $80 ; end

; frame 5 of MetaSprites3ESet0C; ends with $80 (E-0147)
MetaSprites3ESet0CFrame5::
    db $f8, $dc, $03, $20 ; entry 0
    db $f0, $dc, $00, $20 ; entry 1
    db $f8, $f4, $13, $20 ; entry 2
    db $f8, $ec, $14, $20 ; entry 3
    db $f8, $e4, $15, $20 ; entry 4
    db $f0, $f4, $10, $20 ; entry 5
    db $f0, $ec, $11, $20 ; entry 6
    db $f0, $e4, $12, $20 ; entry 7
    db $e8, $f4, $0e, $20 ; entry 8
    db $e8, $ec, $0f, $20 ; entry 9
    db $f8, $d4, $08, $20 ; entry 10
    db $f8, $cc, $09, $20 ; entry 11
    db $f0, $d4, $06, $20 ; entry 12
    db $f0, $cc, $07, $20 ; entry 13
    db $f8, $c4, $0b, $20 ; entry 14
    db $f8, $bc, $0c, $20 ; entry 15
    db $f8, $b4, $0d, $20 ; entry 16
    db $80 ; end

; frame 6 of MetaSprites3ESet0C; ends with $80 (E-0147)
MetaSprites3ESet0CFrame6::
    db $f8, $f0, $14, $00 ; entry 0
    db $f8, $f8, $15, $00 ; entry 1
    db $f0, $e8, $10, $00 ; entry 2
    db $f0, $f0, $11, $00 ; entry 3
    db $f0, $f8, $12, $00 ; entry 4
    db $e8, $e8, $0e, $00 ; entry 5
    db $e8, $f0, $0f, $00 ; entry 6
    db $f0, $e0, $01, $20 ; entry 7
    db $f0, $d8, $02, $20 ; entry 8
    db $f8, $e0, $04, $20 ; entry 9
    db $f8, $d8, $05, $20 ; entry 10
    db $f8, $00, $18, $00 ; entry 11
    db $f8, $e8, $16, $20 ; entry 12
    db $f8, $c8, $0b, $00 ; entry 13
    db $f8, $d0, $0c, $00 ; entry 14
    db $f8, $b8, $0d, $20 ; entry 15
    db $f8, $c0, $0c, $00 ; entry 16
    db $80 ; end

; frame 7 of MetaSprites3ESet0C; ends with $80 (E-0147)
MetaSprites3ESet0CFrame7::
    db $f8, $f4, $14, $20 ; entry 0
    db $f8, $ec, $15, $20 ; entry 1
    db $f0, $fc, $10, $20 ; entry 2
    db $f0, $f4, $11, $20 ; entry 3
    db $f0, $ec, $12, $20 ; entry 4
    db $e8, $fc, $0e, $20 ; entry 5
    db $e8, $f4, $0f, $00 ; entry 6
    db $f0, $e4, $01, $20 ; entry 7
    db $f0, $dc, $02, $20 ; entry 8
    db $f8, $e4, $04, $20 ; entry 9
    db $f8, $dc, $05, $20 ; entry 10
    db $f8, $04, $08, $00 ; entry 11
    db $f0, $04, $06, $00 ; entry 12
    db $f0, $0c, $07, $00 ; entry 13
    db $f8, $fc, $17, $20 ; entry 14
    db $f8, $d4, $0c, $20 ; entry 15
    db $f8, $0c, $19, $00 ; entry 16
    db $f8, $c4, $1b, $20 ; entry 17
    db $f8, $cc, $0b, $20 ; entry 18
    db $80 ; end

; frame 8 of MetaSprites3ESet0C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet0CFrame8::
    db $f8, $d8, $0c, $20 ; entry 0
    db $f8, $d0, $0d, $20 ; entry 1
    db $f8, $e8, $08, $20 ; entry 2
    db $f8, $e0, $09, $20 ; entry 3
    db $f0, $e8, $06, $20 ; entry 4
    db $f0, $e0, $07, $20 ; entry 5
    db $f8, $f0, $03, $00 ; entry 6
    db $f8, $f8, $04, $00 ; entry 7
    db $f8, $00, $05, $00 ; entry 8
    db $f0, $f0, $00, $00 ; entry 9
    db $f0, $f8, $01, $00 ; entry 10
    db $f0, $00, $02, $00 ; entry 11
    db $f8, $10, $04, $20 ; entry 12
    db $f8, $08, $05, $20 ; entry 13
    db $f0, $18, $00, $20 ; entry 14
    db $f0, $10, $01, $20 ; entry 15
    db $f0, $08, $02, $20 ; entry 16
    db $f8, $18, $1a, $00 ; entry 17
    db $80 ; end

; frame 9 of MetaSprites3ESet0C; ends with $80 (E-0147)
MetaSprites3ESet0CFrame9::
    db $f8, $0c, $03, $20 ; entry 0
    db $f0, $0c, $00, $20 ; entry 1
    db $f8, $24, $13, $20 ; entry 2
    db $f8, $1c, $14, $20 ; entry 3
    db $f8, $14, $15, $20 ; entry 4
    db $f0, $24, $10, $20 ; entry 5
    db $f0, $1c, $11, $20 ; entry 6
    db $f0, $14, $12, $20 ; entry 7
    db $e8, $24, $0e, $20 ; entry 8
    db $e8, $1c, $0f, $20 ; entry 9
    db $f8, $04, $08, $20 ; entry 10
    db $f8, $fc, $09, $20 ; entry 11
    db $f0, $04, $06, $20 ; entry 12
    db $f0, $fc, $07, $20 ; entry 13
    db $f8, $f4, $0b, $20 ; entry 14
    db $f8, $ec, $0c, $20 ; entry 15
    db $f8, $e4, $0d, $20 ; entry 16
    db $f8, $dc, $0e, $20 ; entry 17
    db $80 ; end

; frame 10 of MetaSprites3ESet0C; ends with $80 (E-0147)
MetaSprites3ESet0CFrame10::
    db $f8, $20, $14, $00 ; entry 0
    db $f8, $28, $15, $00 ; entry 1
    db $f0, $18, $10, $00 ; entry 2
    db $f0, $20, $11, $00 ; entry 3
    db $f0, $28, $12, $00 ; entry 4
    db $e8, $18, $0e, $00 ; entry 5
    db $e8, $20, $0f, $00 ; entry 6
    db $f0, $10, $01, $20 ; entry 7
    db $f0, $08, $02, $20 ; entry 8
    db $f8, $10, $04, $20 ; entry 9
    db $f8, $08, $05, $20 ; entry 10
    db $f8, $30, $18, $00 ; entry 11
    db $f8, $18, $16, $20 ; entry 12
    db $f8, $f8, $0b, $00 ; entry 13
    db $f8, $00, $0c, $00 ; entry 14
    db $f8, $e8, $0d, $20 ; entry 15
    db $f8, $f0, $0c, $00 ; entry 16
    db $80 ; end

; frame 11 of MetaSprites3ESet0C; ends with $80 (E-0147)
MetaSprites3ESet0CFrame11::
    db $f8, $24, $14, $20 ; entry 0
    db $f8, $1c, $15, $20 ; entry 1
    db $f0, $2c, $10, $20 ; entry 2
    db $f0, $24, $11, $20 ; entry 3
    db $f0, $1c, $12, $20 ; entry 4
    db $e8, $2c, $0e, $20 ; entry 5
    db $e8, $24, $0f, $00 ; entry 6
    db $f0, $14, $01, $20 ; entry 7
    db $f0, $0c, $02, $20 ; entry 8
    db $f8, $14, $04, $20 ; entry 9
    db $f8, $0c, $05, $20 ; entry 10
    db $f8, $34, $08, $00 ; entry 11
    db $f0, $34, $06, $00 ; entry 12
    db $f0, $3c, $07, $00 ; entry 13
    db $f8, $2c, $17, $20 ; entry 14
    db $f8, $04, $0c, $20 ; entry 15
    db $f8, $3c, $19, $00 ; entry 16
    db $f8, $f4, $1b, $20 ; entry 17
    db $f8, $fc, $0b, $20 ; entry 18
    db $80 ; end

; frame 12 of MetaSprites3ESet0C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet0CFrame12::
    db $f8, $08, $0c, $20 ; entry 0
    db $f8, $00, $0d, $20 ; entry 1
    db $f8, $18, $08, $20 ; entry 2
    db $f8, $10, $09, $20 ; entry 3
    db $f0, $18, $06, $20 ; entry 4
    db $f0, $10, $07, $20 ; entry 5
    db $f8, $20, $03, $00 ; entry 6
    db $f8, $28, $04, $00 ; entry 7
    db $f8, $30, $05, $00 ; entry 8
    db $f0, $20, $00, $00 ; entry 9
    db $f0, $28, $01, $00 ; entry 10
    db $f0, $30, $02, $00 ; entry 11
    db $f8, $40, $04, $20 ; entry 12
    db $f8, $38, $05, $20 ; entry 13
    db $f0, $48, $00, $20 ; entry 14
    db $f0, $40, $01, $20 ; entry 15
    db $f0, $38, $02, $20 ; entry 16
    db $f8, $48, $1a, $00 ; entry 17
    db $80 ; end

; frame 13 of MetaSprites3ESet0C; ends with $80 (E-0147)
MetaSprites3ESet0CFrame13::
    db $f8, $3c, $03, $20 ; entry 0
    db $f0, $3c, $00, $20 ; entry 1
    db $f8, $44, $15, $20 ; entry 2
    db $f0, $44, $12, $20 ; entry 3
    db $f8, $34, $08, $20 ; entry 4
    db $f8, $2c, $09, $20 ; entry 5
    db $f0, $34, $06, $20 ; entry 6
    db $f0, $2c, $07, $20 ; entry 7
    db $f8, $24, $0b, $20 ; entry 8
    db $f8, $1c, $0c, $20 ; entry 9
    db $f8, $14, $0d, $20 ; entry 10
    db $f8, $0c, $0e, $20 ; entry 11
    db $e8, $4c, $20, $00 ; entry 12
    db $f0, $4c, $21, $00 ; entry 13
    db $f8, $4c, $22, $00 ; entry 14
    db $80 ; end

; frame 14 of MetaSprites3ESet0C; ends with $80 (E-0147)
MetaSprites3ESet0CFrame14::
    db $f0, $48, $10, $00 ; entry 0
    db $e8, $48, $0e, $00 ; entry 1
    db $f0, $40, $01, $20 ; entry 2
    db $f0, $38, $02, $20 ; entry 3
    db $f8, $40, $04, $20 ; entry 4
    db $f8, $38, $05, $20 ; entry 5
    db $f8, $48, $16, $20 ; entry 6
    db $f8, $28, $0b, $00 ; entry 7
    db $f8, $30, $0c, $00 ; entry 8
    db $f8, $18, $0d, $20 ; entry 9
    db $f8, $20, $0c, $00 ; entry 10
    db $80 ; end

; frame 15 of MetaSprites3ESet0C; ends with $80 (E-0147)
MetaSprites3ESet0CFrame15::
    db $f0, $44, $01, $20 ; entry 0
    db $f0, $3c, $02, $20 ; entry 1
    db $f8, $44, $04, $20 ; entry 2
    db $f8, $3c, $05, $20 ; entry 3
    db $f8, $34, $0c, $20 ; entry 4
    db $f8, $24, $1b, $20 ; entry 5
    db $f8, $2c, $0b, $20 ; entry 6
    db $f0, $4c, $23, $00 ; entry 7
    db $f8, $4c, $24, $00 ; entry 8
    db $80 ; end

; frame 16 of MetaSprites3ESet0C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet0CFrame16::
    db $f0, $48, $02, $20 ; entry 0
    db $f8, $48, $05, $20 ; entry 1
    db $f8, $40, $0c, $20 ; entry 2
    db $f8, $30, $1b, $20 ; entry 3
    db $f8, $38, $0b, $20 ; entry 4
    db $80 ; end

; frame 17 of MetaSprites3ESet0C; ends with $80 (E-0147)
MetaSprites3ESet0CFrame17::
    db $f8, $44, $0c, $20 ; entry 0
    db $f8, $3c, $0d, $20 ; entry 1
    db $f8, $4c, $25, $00 ; entry 2
    db $80 ; end

; frame 18 of MetaSprites3ESet0C; ends with $80 (E-0147)
MetaSprites3ESet0CFrame18::
    db $f8, $48, $0e, $20 ; entry 0
    db $80 ; end

; frame 19 of MetaSprites3ESet0C; ends with $80 (E-0147)
MetaSprites3ESet0CFrame19::
    db $80 ; end

; meta-sprite set 13 of MetaSprites3ETable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3ESet0D::
    dw MetaSprites3ESet0DFrame0 ; entry 0
    dw MetaSprites3ESet0DFrame1 ; entry 1
    dw MetaSprites3ESet0DFrame2 ; entry 2
    dw MetaSprites3ESet0DFrame3 ; entry 3
    dw MetaSprites3ESet0DFrame4 ; entry 4
    dw MetaSprites3ESet0DFrame5 ; entry 5
    dw MetaSprites3ESet0DFrame5 ; entry 6
    dw MetaSprites3ESet0DFrame5 ; entry 7
    dw MetaSprites3ESet0DFrame5 ; entry 8
    dw MetaSprites3ESet0DFrame5 ; entry 9
    dw MetaSprites3ESet0DFrame5 ; entry 10
    dw MetaSprites3ESet0DFrame5 ; entry 11
    dw MetaSprites3ESet0DFrame5 ; entry 12
    dw MetaSprites3ESet0DFrame5 ; entry 13
    dw MetaSprites3ESet0DFrame5 ; entry 14
    dw MetaSprites3ESet0DFrame5 ; entry 15
    dw MetaSprites3ESet0DFrame5 ; entry 16
    dw MetaSprites3ESet0DFrame5 ; entry 17
    dw MetaSprites3ESet0DFrame5 ; entry 18
    dw MetaSprites3ESet0DFrame5 ; entry 19
    dw MetaSprites3ESet0DFrame5 ; entry 20
    dw MetaSprites3ESet0DFrame5 ; entry 21
    dw MetaSprites3ESet0DFrame5 ; entry 22
    dw MetaSprites3ESet0DFrame5 ; entry 23
    dw MetaSprites3ESet0DFrame5 ; entry 24
    dw MetaSprites3ESet0DFrame5 ; entry 25
    dw MetaSprites3ESet0DFrame5 ; entry 26
    dw MetaSprites3ESet0DFrame5 ; entry 27
    dw MetaSprites3ESet0DFrame5 ; entry 28
    dw MetaSprites3ESet0DFrame5 ; entry 29
    dw MetaSprites3ESet0DFrame5 ; entry 30
    dw MetaSprites3ESet0DFrame5 ; entry 31

; frame 0 of MetaSprites3ESet0D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet0DFrame0::
    db $f8, $f8, $22, $00 ; entry 0
    db $f8, $00, $23, $00 ; entry 1
    db $f0, $f8, $20, $00 ; entry 2
    db $f0, $00, $21, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites3ESet0D; ends with $80 (E-0147)
MetaSprites3ESet0DFrame1::
    db $f8, $f4, $1d, $00 ; entry 0
    db $f8, $fc, $1e, $00 ; entry 1
    db $f8, $04, $1f, $00 ; entry 2
    db $f0, $f4, $1a, $00 ; entry 3
    db $f0, $fc, $1b, $00 ; entry 4
    db $f0, $04, $1c, $00 ; entry 5
    db $e8, $fc, $19, $00 ; entry 6
    db $80 ; end

; frame 2 of MetaSprites3ESet0D; ends with $80 (E-0147)
MetaSprites3ESet0DFrame2::
    db $f0, $f4, $1d, $00 ; entry 0
    db $f0, $fc, $1e, $00 ; entry 1
    db $f0, $04, $1f, $00 ; entry 2
    db $e8, $f4, $1a, $00 ; entry 3
    db $e8, $fc, $1b, $00 ; entry 4
    db $e8, $04, $1c, $00 ; entry 5
    db $e0, $fc, $19, $00 ; entry 6
    db $f8, $f4, $22, $00 ; entry 7
    db $f8, $04, $23, $00 ; entry 8
    db $f8, $fc, $0e, $00 ; entry 9
    db $f8, $ec, $1f, $20 ; entry 10
    db $f0, $ec, $1c, $20 ; entry 11
    db $f8, $0c, $1d, $20 ; entry 12
    db $f0, $0c, $1a, $20 ; entry 13
    db $80 ; end

; frame 3 of MetaSprites3ESet0D; ends with $80 (E-0147)
MetaSprites3ESet0DFrame3::
    db $d0, $f8, $00, $20 ; entry 0
    db $d8, $00, $01, $20 ; entry 1
    db $d8, $f8, $02, $20 ; entry 2
    db $e0, $00, $04, $20 ; entry 3
    db $e0, $f8, $05, $20 ; entry 4
    db $e0, $f0, $06, $20 ; entry 5
    db $e8, $10, $07, $20 ; entry 6
    db $e8, $08, $08, $20 ; entry 7
    db $e8, $00, $09, $20 ; entry 8
    db $e8, $f8, $0a, $20 ; entry 9
    db $e8, $f0, $0b, $20 ; entry 10
    db $e8, $e8, $0c, $20 ; entry 11
    db $f0, $10, $0d, $20 ; entry 12
    db $f0, $08, $0e, $20 ; entry 13
    db $f0, $00, $0f, $20 ; entry 14
    db $f0, $f8, $10, $20 ; entry 15
    db $f0, $f0, $11, $20 ; entry 16
    db $f0, $e8, $12, $20 ; entry 17
    db $f8, $10, $13, $20 ; entry 18
    db $f8, $08, $14, $20 ; entry 19
    db $f8, $00, $15, $20 ; entry 20
    db $f8, $f8, $16, $20 ; entry 21
    db $f8, $f0, $17, $20 ; entry 22
    db $f8, $e8, $18, $20 ; entry 23
    db $e0, $0c, $03, $20 ; entry 24
    db $80 ; end

; frame 4 of MetaSprites3ESet0D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3ESet0DFrame4::
    db $d0, $00, $00, $00 ; entry 0
    db $d8, $f8, $01, $00 ; entry 1
    db $d8, $00, $02, $00 ; entry 2
    db $e0, $f8, $04, $00 ; entry 3
    db $e0, $00, $05, $00 ; entry 4
    db $e0, $08, $06, $00 ; entry 5
    db $e8, $e8, $07, $00 ; entry 6
    db $e8, $f0, $08, $00 ; entry 7
    db $e8, $f8, $09, $00 ; entry 8
    db $e8, $00, $0a, $00 ; entry 9
    db $e8, $08, $0b, $00 ; entry 10
    db $e8, $10, $0c, $00 ; entry 11
    db $f0, $e8, $0d, $00 ; entry 12
    db $f0, $f0, $0e, $00 ; entry 13
    db $f0, $f8, $0f, $00 ; entry 14
    db $f0, $00, $10, $00 ; entry 15
    db $f0, $08, $11, $00 ; entry 16
    db $f0, $10, $12, $00 ; entry 17
    db $f8, $e8, $13, $00 ; entry 18
    db $f8, $f0, $14, $00 ; entry 19
    db $f8, $f8, $15, $00 ; entry 20
    db $f8, $00, $16, $00 ; entry 21
    db $f8, $08, $17, $00 ; entry 22
    db $f8, $10, $18, $00 ; entry 23
    db $e0, $ec, $03, $00 ; entry 24
    db $80 ; end

; frame 5 of MetaSprites3ESet0D; ends with $80 (E-0147)
MetaSprites3ESet0DFrame5::
    db $80 ; end
    ds $454, $00
