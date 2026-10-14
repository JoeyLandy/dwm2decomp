; ROM bank $3D: meta-sprite frames
; The annotated listing of this bank is build/listing/bank3d.asm.

SECTION "Bank 3D", ROMX[$4000], BANK[$3D]
    db $3d

; called from DrawEffectSpriteForEffectTileOffsetRange: may continue in
; DrawEffectSpriteAtEffectSpriteX_Bank3D; copies wBattleFoeCount to wLoadSlot; copies wBattleTarget
; & $04 to wBattleArg0; calls CarryUnlessBattleSlotOutSlotEmpty; calls SetEffectSpriteXForTargets;
; calls DrawEffectSpriteAtEffectSpriteX_Bank3D; decrements wLoadSlot; returns if the byte at
; wLoadSlot is 0; increments wBattleArg0; calls CarryUnlessBattleSlotOutSlotEmpty; calls
; SetEffectSpriteXForTargets; calls DrawEffectSpriteAtEffectSpriteX_Bank3D; then 6 more steps (see
; the code) (E-0347)
; why: a helper of DrawEffectSpriteForEffectTileOffsetRange;
; DrawEffectSpriteForEffectTileOffsetRange: draws the effect sprite from bank $3E, $3F, $3D, $3B or
; $92 by wEffectTileOffset (< $0E, $20, $2D, $33, or more) (E-0352, E-0124)
DrawEffectSpriteForEffectTileOffsetRange_CarryUnlessBattleSlotOutSlotEmpty::
    ld a, [wEffectTileOffset]
    cp $2c
    jr nz, DrawEffectSpriteAtEffectSpriteX_Bank3D
    ld a, [wBattleFoeCount]
    ld [wLoadSlot], a
    ld a, [wBattleTarget]
    and $04
    ld [wBattleArg0], a
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .skip
    farcall SetEffectSpriteXForTargets
    call DrawEffectSpriteAtEffectSpriteX_Bank3D

.skip:
    ld hl, wLoadSlot
    dec [hl]
    ld a, [hl]
    or a
    ret z
    ld hl, wBattleArg0
    inc [hl]
    ld a, [hl]
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .skip2
    farcall SetEffectSpriteXForTargets
    call DrawEffectSpriteAtEffectSpriteX_Bank3D

.skip2:
    ld hl, wLoadSlot
    dec [hl]
    ld a, [hl]
    or a
    ret z
    ld hl, wBattleArg0
    inc [hl]
    ld a, [hl]
    call CarryUnlessBattleSlotOutSlotEmpty
    ret c
    farcall SetEffectSpriteXForTargets

; sets the sprite origin X = wEffectSpriteX, Y = $68, tile offset = wEffectTileOffset, attribute XOR
; = wEffectSpriteAttrXor, then builds OAM from the local sprite table (E-0121)
DrawEffectSpriteAtEffectSpriteX_Bank3D::
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
    ld de, MetaSprites3DTable
    call BuildOamFromSpriteTable_Bank3D
    ret

; the caller of BuildOamFromSpriteTable_Bank3D passes DE = $MetaSprites3DTable; the builder takes
; the word at DE + 2 * hSpriteSetIndex as the set and the word at set + 2 * hSpriteSubIndex as the
; frame; 45 words, up to the next code or data (E-0147, C1)
; record: meta-sprite set
MetaSprites3DTable::
    dw MetaSprites3DSet00 ; id 0
    dw MetaSprites3DSet00 ; id 1
    dw MetaSprites3DSet00 ; id 2
    dw MetaSprites3DSet00 ; id 3
    dw MetaSprites3DSet00 ; id 4
    dw MetaSprites3DSet00 ; id 5
    dw MetaSprites3DSet00 ; id 6
    dw MetaSprites3DSet00 ; id 7
    dw MetaSprites3DSet00 ; id 8
    dw MetaSprites3DSet00 ; id 9
    dw MetaSprites3DSet00 ; id 10
    dw MetaSprites3DSet00 ; id 11
    dw MetaSprites3DSet00 ; id 12
    dw MetaSprites3DSet00 ; id 13
    dw MetaSprites3DSet00 ; id 14
    dw MetaSprites3DSet00 ; id 15
    dw MetaSprites3DSet00 ; id 16
    dw MetaSprites3DSet00 ; id 17
    dw MetaSprites3DSet00 ; id 18
    dw MetaSprites3DSet00 ; id 19
    dw MetaSprites3DSet00 ; id 20
    dw MetaSprites3DSet00 ; id 21
    dw MetaSprites3DSet00 ; id 22
    dw MetaSprites3DSet00 ; id 23
    dw MetaSprites3DSet00 ; id 24
    dw MetaSprites3DSet00 ; id 25
    dw MetaSprites3DSet00 ; id 26
    dw MetaSprites3DSet00 ; id 27
    dw MetaSprites3DSet00 ; id 28
    dw MetaSprites3DSet00 ; id 29
    dw MetaSprites3DSet00 ; id 30
    dw MetaSprites3DSet00 ; id 31
    dw MetaSprites3DSet00 ; id 32
    dw MetaSprites3DSet21 ; id 33
    dw MetaSprites3DSet22 ; id 34
    dw MetaSprites3DSet23 ; id 35
    dw MetaSprites3DSet24 ; id 36
    dw MetaSprites3DSet25 ; id 37
    dw MetaSprites3DSet26 ; id 38
    dw MetaSprites3DSet27 ; id 39
    dw MetaSprites3DSet28 ; id 40
    dw MetaSprites3DSet29 ; id 41
    dw MetaSprites3DSet2A ; id 42
    dw MetaSprites3DSet2B ; id 43
    dw MetaSprites3DSet2C ; id 44

; DE = two-level table; entries are chosen by hSpriteSetIndex and hSpriteSubIndex; writes 4-byte OAM
; entries at $C000 + 4 * hOamNextEntry (Y = hSpriteOriginY + b + $10, X = hSpriteOriginX + b + 8,
; tile += hSpriteTileOffset, flags ^= hSpriteAttrXor) until a $80 byte or hOamNextEntry reaches $28
; (40 entries) (the same 81 bytes appear in 5 banks) (E-0351)
BuildOamFromSpriteTable_Bank3D::
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

; meta-sprite set 0 of MetaSprites3DTable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3DSet00::
    dw MetaSprites3DSet00Frame0 ; entry 0
    dw MetaSprites3DSet00Frame1 ; entry 1
    dw MetaSprites3DSet00Frame2 ; entry 2
    dw MetaSprites3DSet00Frame3 ; entry 3
    dw MetaSprites3DSet00Frame4 ; entry 4
    dw MetaSprites3DSet00Frame5 ; entry 5
    dw MetaSprites3DSet00Frame6 ; entry 6
    dw MetaSprites3DSet00Frame7 ; entry 7
    dw MetaSprites3DSet00Frame8 ; entry 8
    dw MetaSprites3DSet00Frame9 ; entry 9
    dw MetaSprites3DSet00Frame10 ; entry 10
    dw MetaSprites3DSet00Frame11 ; entry 11
    dw MetaSprites3DSet00Frame12 ; entry 12
    dw MetaSprites3DSet00Frame13 ; entry 13
    dw MetaSprites3DSet00Frame14 ; entry 14
    dw MetaSprites3DSet00Frame15 ; entry 15
    dw MetaSprites3DSet00Frame16 ; entry 16
    dw MetaSprites3DSet00Frame17 ; entry 17
    dw MetaSprites3DSet00Frame18 ; entry 18
    dw MetaSprites3DSet00Frame19 ; entry 19
    dw MetaSprites3DSet00Frame20 ; entry 20
    dw MetaSprites3DSet00Frame21 ; entry 21
    dw MetaSprites3DSet00Frame22 ; entry 22
    dw MetaSprites3DSet00Frame23 ; entry 23
    dw MetaSprites3DSet00Frame24 ; entry 24
    dw MetaSprites3DSet00Frame25 ; entry 25
    dw MetaSprites3DSet00Frame26 ; entry 26
    dw MetaSprites3DSet00Frame26 ; entry 27
    dw MetaSprites3DSet00Frame26 ; entry 28
    dw MetaSprites3DSet00Frame26 ; entry 29
    dw MetaSprites3DSet00Frame26 ; entry 30
    dw MetaSprites3DSet00Frame26 ; entry 31

; frame 0 of MetaSprites3DSet00; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet00Frame0::
    db $d8, $03, $20, $00 ; entry 0
    db $d8, $0b, $21, $00 ; entry 1
    db $d0, $03, $22, $00 ; entry 2
    db $d0, $0b, $23, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites3DSet00; ends with $80 (E-0147)
MetaSprites3DSet00Frame1::
    db $dc, $00, $20, $00 ; entry 0
    db $dc, $08, $21, $00 ; entry 1
    db $e4, $f8, $20, $60 ; entry 2
    db $e4, $f0, $21, $60 ; entry 3
    db $d0, $03, $2f, $00 ; entry 4
    db $d4, $00, $22, $00 ; entry 5
    db $d4, $08, $23, $00 ; entry 6
    db $f0, $f5, $2f, $60 ; entry 7
    db $ec, $f8, $22, $60 ; entry 8
    db $ec, $f0, $23, $60 ; entry 9
    db $80 ; end

; frame 2 of MetaSprites3DSet00; ends with $80 (E-0147)
MetaSprites3DSet00Frame2::
    db $d8, $fc, $26, $00 ; entry 0
    db $d8, $04, $27, $00 ; entry 1
    db $d8, $0c, $28, $00 ; entry 2
    db $f0, $f4, $2e, $00 ; entry 3
    db $f8, $ef, $2f, $00 ; entry 4
    db $d0, $00, $24, $00 ; entry 5
    db $d0, $08, $25, $00 ; entry 6
    db $e0, $f8, $29, $00 ; entry 7
    db $e0, $00, $2a, $00 ; entry 8
    db $e0, $08, $2b, $00 ; entry 9
    db $e8, $f8, $2c, $00 ; entry 10
    db $e8, $00, $2d, $00 ; entry 11
    db $80 ; end

; frame 3 of MetaSprites3DSet00; ends with $80 (E-0147)
MetaSprites3DSet00Frame3::
    db $e0, $f7, $26, $00 ; entry 0
    db $e0, $ff, $27, $00 ; entry 1
    db $e0, $07, $28, $00 ; entry 2
    db $f8, $ef, $2e, $00 ; entry 3
    db $d8, $fb, $24, $00 ; entry 4
    db $d8, $03, $25, $00 ; entry 5
    db $e8, $f3, $29, $00 ; entry 6
    db $e8, $fb, $2a, $00 ; entry 7
    db $e8, $03, $2b, $00 ; entry 8
    db $f0, $f3, $2c, $00 ; entry 9
    db $f0, $fb, $2d, $00 ; entry 10
    db $d0, $09, $2f, $00 ; entry 11
    db $80 ; end

; frame 4 of MetaSprites3DSet00; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet00Frame4::
    db $d0, $09, $2e, $00 ; entry 0
    db $d8, $04, $2e, $00 ; entry 1
    db $e0, $ff, $2e, $00 ; entry 2
    db $e8, $f9, $2e, $00 ; entry 3
    db $f8, $f5, $29, $60 ; entry 4
    db $f8, $ed, $2a, $60 ; entry 5
    db $f8, $e5, $2b, $60 ; entry 6
    db $f0, $f5, $2c, $60 ; entry 7
    db $f0, $ed, $2d, $60 ; entry 8
    db $80 ; end

; frame 5 of MetaSprites3DSet00; ends with $80 (E-0147)
MetaSprites3DSet00Frame5::
    db $f8, $ef, $2e, $00 ; entry 0
    db $f0, $f4, $2e, $00 ; entry 1
    db $e8, $f9, $2e, $00 ; entry 2
    db $e0, $ff, $2f, $00 ; entry 3
    db $d8, $04, $2f, $00 ; entry 4
    db $80 ; end

; frame 6 of MetaSprites3DSet00; ends with $80 (E-0147)
MetaSprites3DSet00Frame6::
    db $f8, $ef, $2f, $00 ; entry 0
    db $f0, $f4, $2f, $00 ; entry 1
    db $e8, $f9, $2f, $00 ; entry 2
    db $80 ; end

; frame 7 of MetaSprites3DSet00; ends with $80 (E-0147)
MetaSprites3DSet00Frame7::
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

; frame 8 of MetaSprites3DSet00; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet00Frame8::
    db $de, $f4, $00, $00 ; entry 0
    db $de, $fc, $01, $00 ; entry 1
    db $f0, $f0, $0c, $00 ; entry 2
    db $f0, $f8, $0d, $00 ; entry 3
    db $f0, $00, $0e, $00 ; entry 4
    db $e2, $f6, $09, $00 ; entry 5
    db $e2, $fe, $0a, $00 ; entry 6
    db $e2, $06, $0b, $00 ; entry 7
    db $80 ; end

; frame 9 of MetaSprites3DSet00; ends with $80 (E-0147)
MetaSprites3DSet00Frame9::
    db $dd, $f0, $0c, $00 ; entry 0
    db $dd, $f8, $0d, $00 ; entry 1
    db $dd, $00, $0e, $00 ; entry 2
    db $f0, $f0, $04, $00 ; entry 3
    db $f0, $f8, $05, $00 ; entry 4
    db $f0, $00, $06, $00 ; entry 5
    db $f8, $f0, $08, $00 ; entry 6
    db $f7, $e8, $07, $00 ; entry 7
    db $ea, $f8, $1c, $00 ; entry 8
    db $ea, $00, $1d, $00 ; entry 9
    db $e2, $f8, $1b, $00 ; entry 10
    db $e6, $08, $1e, $00 ; entry 11
    db $e6, $10, $1f, $00 ; entry 12
    db $80 ; end

; frame 10 of MetaSprites3DSet00; ends with $80 (E-0147)
MetaSprites3DSet00Frame10::
    db $da, $f1, $04, $00 ; entry 0
    db $da, $f9, $05, $00 ; entry 1
    db $da, $01, $06, $00 ; entry 2
    db $e2, $f1, $08, $00 ; entry 3
    db $e1, $e9, $07, $00 ; entry 4
    db $f2, $ee, $0c, $00 ; entry 5
    db $f2, $f6, $0d, $00 ; entry 6
    db $f2, $fe, $0e, $00 ; entry 7
    db $e2, $f8, $0f, $00 ; entry 8
    db $e2, $00, $10, $00 ; entry 9
    db $e2, $08, $11, $00 ; entry 10
    db $e2, $10, $12, $00 ; entry 11
    db $ea, $f8, $13, $00 ; entry 12
    db $ea, $00, $14, $00 ; entry 13
    db $ea, $0c, $15, $00 ; entry 14
    db $80 ; end

; frame 11 of MetaSprites3DSet00; ends with $80 (E-0147)
MetaSprites3DSet00Frame11::
    db $e2, $00, $16, $00 ; entry 0
    db $ea, $00, $19, $00 ; entry 1
    db $e9, $0e, $15, $00 ; entry 2
    db $e2, $10, $18, $00 ; entry 3
    db $e2, $08, $17, $00 ; entry 4
    db $ea, $08, $1a, $00 ; entry 5
    db $e0, $e8, $1c, $00 ; entry 6
    db $e0, $f0, $1d, $00 ; entry 7
    db $d8, $e8, $1b, $00 ; entry 8
    db $da, $f3, $09, $00 ; entry 9
    db $da, $fb, $0a, $00 ; entry 10
    db $da, $03, $0b, $00 ; entry 11
    db $dc, $f8, $1e, $00 ; entry 12
    db $dc, $00, $1f, $00 ; entry 13
    db $80 ; end

; frame 12 of MetaSprites3DSet00; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet00Frame12::
    db $d8, $f0, $10, $00 ; entry 0
    db $d8, $f8, $11, $00 ; entry 1
    db $d8, $00, $12, $00 ; entry 2
    db $d8, $e8, $0f, $00 ; entry 3
    db $e0, $e8, $13, $00 ; entry 4
    db $e0, $f0, $14, $00 ; entry 5
    db $e0, $fc, $15, $00 ; entry 6
    db $e9, $f6, $0c, $00 ; entry 7
    db $e9, $fe, $0d, $00 ; entry 8
    db $e9, $06, $0e, $00 ; entry 9
    db $d0, $00, $00, $00 ; entry 10
    db $d0, $08, $01, $00 ; entry 11
    db $80 ; end

; frame 13 of MetaSprites3DSet00; ends with $80 (E-0147)
MetaSprites3DSet00Frame13::
    db $e8, $fc, $00, $00 ; entry 0
    db $e8, $04, $01, $00 ; entry 1
    db $f0, $f4, $04, $00 ; entry 2
    db $f0, $fc, $05, $00 ; entry 3
    db $f0, $04, $06, $00 ; entry 4
    db $f8, $f4, $08, $00 ; entry 5
    db $f7, $ec, $07, $00 ; entry 6
    db $d8, $f0, $16, $00 ; entry 7
    db $e0, $f0, $19, $00 ; entry 8
    db $df, $fe, $15, $00 ; entry 9
    db $e0, $f8, $1a, $00 ; entry 10
    db $d8, $f8, $17, $00 ; entry 11
    db $d8, $00, $18, $00 ; entry 12
    db $d0, $fe, $09, $00 ; entry 13
    db $d0, $06, $0a, $00 ; entry 14
    db $d0, $0e, $0b, $00 ; entry 15
    db $80 ; end

; frame 14 of MetaSprites3DSet00; ends with $80 (E-0147)
MetaSprites3DSet00Frame14::
    db $ee, $f3, $0c, $00 ; entry 0
    db $e5, $fc, $05, $00 ; entry 1
    db $e5, $04, $06, $00 ; entry 2
    db $d8, $f8, $1c, $00 ; entry 3
    db $d8, $00, $1d, $00 ; entry 4
    db $d4, $08, $1e, $00 ; entry 5
    db $d4, $10, $1f, $00 ; entry 6
    db $d0, $f8, $1b, $00 ; entry 7
    db $e5, $f4, $04, $00 ; entry 8
    db $ed, $f4, $08, $00 ; entry 9
    db $ec, $ec, $07, $00 ; entry 10
    db $f0, $10, $0b, $00 ; entry 11
    db $ee, $fb, $0d, $00 ; entry 12
    db $ee, $03, $0e, $00 ; entry 13
    db $f0, $00, $09, $00 ; entry 14
    db $f0, $08, $0a, $00 ; entry 15
    db $80 ; end

; frame 15 of MetaSprites3DSet00; ends with $80 (E-0147)
MetaSprites3DSet00Frame15::
    db $e4, $f5, $09, $00 ; entry 0
    db $e4, $fd, $0a, $00 ; entry 1
    db $e4, $05, $0b, $00 ; entry 2
    db $d0, $00, $10, $00 ; entry 3
    db $d0, $08, $11, $00 ; entry 4
    db $d0, $10, $12, $00 ; entry 5
    db $d0, $f8, $0f, $00 ; entry 6
    db $d8, $f8, $13, $00 ; entry 7
    db $d8, $00, $14, $00 ; entry 8
    db $d8, $0c, $15, $00 ; entry 9
    db $f8, $ee, $1c, $00 ; entry 10
    db $f8, $f6, $1d, $00 ; entry 11
    db $f4, $fe, $1e, $00 ; entry 12
    db $f4, $06, $1f, $00 ; entry 13
    db $f0, $ee, $1b, $00 ; entry 14
    db $80 ; end

; frame 16 of MetaSprites3DSet00; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet00Frame16::
    db $e6, $f3, $0c, $00 ; entry 0
    db $e6, $fb, $0d, $00 ; entry 1
    db $e6, $03, $0e, $00 ; entry 2
    db $d0, $00, $16, $00 ; entry 3
    db $d8, $00, $19, $00 ; entry 4
    db $d7, $0e, $15, $00 ; entry 5
    db $d0, $08, $17, $00 ; entry 6
    db $d8, $08, $1a, $00 ; entry 7
    db $d0, $10, $18, $00 ; entry 8
    db $f0, $f6, $10, $00 ; entry 9
    db $f0, $fe, $11, $00 ; entry 10
    db $f0, $06, $12, $00 ; entry 11
    db $f0, $ee, $0f, $00 ; entry 12
    db $f8, $ee, $13, $00 ; entry 13
    db $f8, $f6, $14, $00 ; entry 14
    db $f8, $02, $15, $00 ; entry 15
    db $80 ; end

; frame 17 of MetaSprites3DSet00; ends with $80 (E-0147)
MetaSprites3DSet00Frame17::
    db $f0, $f6, $16, $00 ; entry 0
    db $f8, $f6, $19, $00 ; entry 1
    db $f7, $04, $15, $00 ; entry 2
    db $f0, $fe, $17, $00 ; entry 3
    db $f8, $fe, $1a, $00 ; entry 4
    db $f0, $06, $18, $00 ; entry 5
    db $e8, $f0, $09, $00 ; entry 6
    db $e8, $f8, $0a, $00 ; entry 7
    db $e8, $00, $0b, $00 ; entry 8
    db $d8, $f0, $0c, $00 ; entry 9
    db $d8, $f8, $0d, $00 ; entry 10
    db $d8, $00, $0e, $00 ; entry 11
    db $dc, $04, $02, $00 ; entry 12
    db $dc, $0c, $03, $00 ; entry 13
    db $80 ; end

; frame 18 of MetaSprites3DSet00; ends with $80 (E-0147)
MetaSprites3DSet00Frame18::
    db $f0, $e8, $1c, $00 ; entry 0
    db $f0, $f0, $1d, $00 ; entry 1
    db $e8, $e8, $1b, $00 ; entry 2
    db $ec, $f8, $1e, $00 ; entry 3
    db $ec, $00, $1f, $00 ; entry 4
    db $f8, $f0, $0c, $00 ; entry 5
    db $f8, $f8, $0d, $00 ; entry 6
    db $f8, $00, $0e, $00 ; entry 7
    db $dc, $00, $09, $00 ; entry 8
    db $dc, $08, $0a, $00 ; entry 9
    db $dc, $10, $0b, $00 ; entry 10
    db $80 ; end

; frame 19 of MetaSprites3DSet00; ends with $80 (E-0147)
MetaSprites3DSet00Frame19::
    db $e8, $f0, $10, $00 ; entry 0
    db $e8, $f8, $11, $00 ; entry 1
    db $e8, $00, $12, $00 ; entry 2
    db $e8, $e8, $0f, $00 ; entry 3
    db $f0, $e8, $13, $00 ; entry 4
    db $f0, $f0, $14, $00 ; entry 5
    db $f0, $fc, $15, $00 ; entry 6
    db $f2, $ff, $0c, $00 ; entry 7
    db $f2, $07, $0d, $00 ; entry 8
    db $f2, $0f, $0e, $00 ; entry 9
    db $e0, $f8, $1c, $00 ; entry 10
    db $e0, $00, $1d, $00 ; entry 11
    db $dc, $08, $1e, $00 ; entry 12
    db $dc, $10, $1f, $00 ; entry 13
    db $d8, $f8, $1b, $00 ; entry 14
    db $d6, $eb, $02, $00 ; entry 15
    db $d6, $f3, $03, $00 ; entry 16
    db $80 ; end

; frame 20 of MetaSprites3DSet00; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet00Frame20::
    db $e8, $f0, $16, $00 ; entry 0
    db $f0, $f0, $19, $00 ; entry 1
    db $ef, $fe, $15, $00 ; entry 2
    db $f0, $f8, $1a, $00 ; entry 3
    db $e8, $f8, $17, $00 ; entry 4
    db $e8, $00, $18, $00 ; entry 5
    db $f0, $00, $04, $00 ; entry 6
    db $f0, $08, $05, $00 ; entry 7
    db $f0, $10, $06, $00 ; entry 8
    db $f8, $00, $08, $00 ; entry 9
    db $f7, $f8, $07, $00 ; entry 10
    db $d0, $f4, $09, $00 ; entry 11
    db $d0, $fc, $0a, $00 ; entry 12
    db $d0, $04, $0b, $00 ; entry 13
    db $d8, $00, $10, $00 ; entry 14
    db $d8, $08, $11, $00 ; entry 15
    db $d8, $10, $12, $00 ; entry 16
    db $d8, $f8, $0f, $00 ; entry 17
    db $e0, $f8, $13, $00 ; entry 18
    db $e0, $00, $14, $00 ; entry 19
    db $e0, $0c, $15, $00 ; entry 20
    db $80 ; end

; frame 21 of MetaSprites3DSet00; ends with $80 (E-0147)
MetaSprites3DSet00Frame21::
    db $f0, $10, $0b, $00 ; entry 0
    db $f0, $00, $09, $00 ; entry 1
    db $f0, $08, $0a, $00 ; entry 2
    db $d8, $e8, $1c, $00 ; entry 3
    db $d8, $f0, $1d, $00 ; entry 4
    db $d4, $f8, $1e, $00 ; entry 5
    db $d4, $00, $1f, $00 ; entry 6
    db $d0, $e8, $1b, $00 ; entry 7
    db $d8, $00, $16, $00 ; entry 8
    db $e0, $00, $19, $00 ; entry 9
    db $df, $0e, $15, $00 ; entry 10
    db $d8, $08, $17, $00 ; entry 11
    db $e0, $08, $1a, $00 ; entry 12
    db $d8, $10, $18, $00 ; entry 13
    db $f0, $e8, $0c, $00 ; entry 14
    db $f0, $f0, $0d, $00 ; entry 15
    db $f0, $f8, $0e, $00 ; entry 16
    db $e8, $f8, $02, $00 ; entry 17
    db $e8, $00, $03, $00 ; entry 18
    db $80 ; end

; frame 22 of MetaSprites3DSet00; ends with $80 (E-0147)
MetaSprites3DSet00Frame22::
    db $e0, $f5, $09, $00 ; entry 0
    db $e0, $fd, $0a, $00 ; entry 1
    db $e0, $05, $0b, $00 ; entry 2
    db $d0, $00, $10, $00 ; entry 3
    db $d0, $08, $11, $00 ; entry 4
    db $d0, $10, $12, $00 ; entry 5
    db $d0, $f8, $0f, $00 ; entry 6
    db $d8, $f8, $13, $00 ; entry 7
    db $d8, $00, $14, $00 ; entry 8
    db $d8, $0c, $15, $00 ; entry 9
    db $f4, $ee, $1c, $00 ; entry 10
    db $f4, $f6, $1d, $00 ; entry 11
    db $f0, $fe, $1e, $00 ; entry 12
    db $f0, $06, $1f, $00 ; entry 13
    db $ec, $ee, $1b, $00 ; entry 14
    db $80 ; end

; frame 23 of MetaSprites3DSet00; ends with $80 (E-0147)
MetaSprites3DSet00Frame23::
    db $e2, $f3, $0c, $00 ; entry 0
    db $e2, $fb, $0d, $00 ; entry 1
    db $e2, $03, $0e, $00 ; entry 2
    db $d0, $00, $16, $00 ; entry 3
    db $d8, $00, $19, $00 ; entry 4
    db $d7, $0e, $15, $00 ; entry 5
    db $d0, $08, $17, $00 ; entry 6
    db $d8, $08, $1a, $00 ; entry 7
    db $d0, $10, $18, $00 ; entry 8
    db $ec, $f6, $10, $00 ; entry 9
    db $ec, $fe, $11, $00 ; entry 10
    db $ec, $06, $12, $00 ; entry 11
    db $ec, $ee, $0f, $00 ; entry 12
    db $f4, $ee, $13, $00 ; entry 13
    db $f4, $f6, $14, $00 ; entry 14
    db $f4, $02, $15, $00 ; entry 15
    db $80 ; end

; frame 24 of MetaSprites3DSet00; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet00Frame24::
    db $ec, $ee, $16, $00 ; entry 0
    db $f4, $ee, $19, $00 ; entry 1
    db $f3, $fc, $15, $00 ; entry 2
    db $ec, $f6, $17, $00 ; entry 3
    db $f4, $f6, $1a, $00 ; entry 4
    db $ec, $fe, $18, $00 ; entry 5
    db $e0, $fd, $00, $00 ; entry 6
    db $e0, $05, $01, $00 ; entry 7
    db $d8, $f0, $0c, $00 ; entry 8
    db $d8, $f8, $0d, $00 ; entry 9
    db $d8, $00, $0e, $00 ; entry 10
    db $80 ; end

; frame 25 of MetaSprites3DSet00; ends with $80 (E-0147)
MetaSprites3DSet00Frame25::
    db $e0, $fd, $02, $00 ; entry 0
    db $e0, $05, $03, $00 ; entry 1
    db $d4, $fb, $00, $00 ; entry 2
    db $d4, $03, $01, $00 ; entry 3
    db $f4, $e8, $0c, $00 ; entry 4
    db $f4, $f0, $0d, $00 ; entry 5
    db $f4, $f8, $0e, $00 ; entry 6
    db $80 ; end

; frame 26 of MetaSprites3DSet00; ends with $80 (E-0147)
MetaSprites3DSet00Frame26::
    db $80 ; end

; meta-sprite set 33 of MetaSprites3DTable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3DSet21::
    dw MetaSprites3DSet21Frame0 ; entry 0
    dw MetaSprites3DSet21Frame1 ; entry 1
    dw MetaSprites3DSet21Frame2 ; entry 2
    dw MetaSprites3DSet21Frame3 ; entry 3
    dw MetaSprites3DSet21Frame4 ; entry 4
    dw MetaSprites3DSet21Frame5 ; entry 5
    dw MetaSprites3DSet21Frame6 ; entry 6
    dw MetaSprites3DSet21Frame7 ; entry 7
    dw MetaSprites3DSet21Frame8 ; entry 8
    dw MetaSprites3DSet21Frame9 ; entry 9
    dw MetaSprites3DSet21Frame10 ; entry 10
    dw MetaSprites3DSet21Frame11 ; entry 11
    dw MetaSprites3DSet21Frame12 ; entry 12
    dw MetaSprites3DSet21Frame12 ; entry 13
    dw MetaSprites3DSet21Frame12 ; entry 14
    dw MetaSprites3DSet21Frame12 ; entry 15
    dw MetaSprites3DSet21Frame12 ; entry 16
    dw MetaSprites3DSet21Frame12 ; entry 17
    dw MetaSprites3DSet21Frame12 ; entry 18
    dw MetaSprites3DSet21Frame12 ; entry 19
    dw MetaSprites3DSet21Frame12 ; entry 20
    dw MetaSprites3DSet21Frame12 ; entry 21
    dw MetaSprites3DSet21Frame12 ; entry 22
    dw MetaSprites3DSet21Frame12 ; entry 23
    dw MetaSprites3DSet21Frame12 ; entry 24
    dw MetaSprites3DSet21Frame12 ; entry 25
    dw MetaSprites3DSet21Frame12 ; entry 26
    dw MetaSprites3DSet21Frame12 ; entry 27
    dw MetaSprites3DSet21Frame12 ; entry 28
    dw MetaSprites3DSet21Frame12 ; entry 29
    dw MetaSprites3DSet21Frame12 ; entry 30
    dw MetaSprites3DSet21Frame12 ; entry 31

; frame 0 of MetaSprites3DSet21; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet21Frame0::
    db $d8, $03, $20, $00 ; entry 0
    db $d8, $0b, $21, $00 ; entry 1
    db $d0, $03, $22, $00 ; entry 2
    db $d0, $0b, $23, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites3DSet21; ends with $80 (E-0147)
MetaSprites3DSet21Frame1::
    db $dc, $00, $20, $00 ; entry 0
    db $dc, $08, $21, $00 ; entry 1
    db $d4, $00, $22, $00 ; entry 2
    db $d4, $08, $23, $00 ; entry 3
    db $e4, $f8, $20, $60 ; entry 4
    db $e4, $f0, $21, $60 ; entry 5
    db $ec, $f8, $22, $60 ; entry 6
    db $ec, $f0, $23, $60 ; entry 7
    db $80 ; end

; frame 2 of MetaSprites3DSet21; ends with $80 (E-0147)
MetaSprites3DSet21Frame2::
    db $f0, $f4, $2c, $00 ; entry 0
    db $f8, $f0, $2d, $00 ; entry 1
    db $e8, $f8, $2a, $00 ; entry 2
    db $e8, $00, $2b, $00 ; entry 3
    db $d0, $04, $24, $00 ; entry 4
    db $d0, $0c, $25, $00 ; entry 5
    db $d8, $00, $26, $00 ; entry 6
    db $d8, $08, $27, $00 ; entry 7
    db $e0, $fb, $28, $00 ; entry 8
    db $e0, $03, $29, $00 ; entry 9
    db $80 ; end

; frame 3 of MetaSprites3DSet21; ends with $80 (E-0147)
MetaSprites3DSet21Frame3::
    db $f8, $f0, $2c, $00 ; entry 0
    db $f0, $ec, $2e, $00 ; entry 1
    db $d8, $08, $25, $00 ; entry 2
    db $d0, $0c, $2e, $00 ; entry 3
    db $d0, $04, $24, $00 ; entry 4
    db $d8, $00, $28, $40 ; entry 5
    db $e0, $fc, $26, $00 ; entry 6
    db $e0, $04, $27, $00 ; entry 7
    db $e8, $f7, $28, $00 ; entry 8
    db $e8, $ff, $29, $00 ; entry 9
    db $f0, $f4, $2a, $00 ; entry 10
    db $f0, $fc, $2b, $00 ; entry 11
    db $80 ; end

; frame 4 of MetaSprites3DSet21; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet21Frame4::
    db $f8, $ee, $2e, $00 ; entry 0
    db $f0, $f3, $2e, $00 ; entry 1
    db $e8, $f8, $2e, $00 ; entry 2
    db $e0, $fe, $2e, $00 ; entry 3
    db $d8, $03, $2e, $00 ; entry 4
    db $d0, $08, $2e, $00 ; entry 5
    db $e0, $f6, $24, $00 ; entry 6
    db $80 ; end

; frame 5 of MetaSprites3DSet21; ends with $80 (E-0147)
MetaSprites3DSet21Frame5::
    db $f8, $ee, $2e, $00 ; entry 0
    db $f0, $f3, $2e, $00 ; entry 1
    db $e8, $f8, $2e, $00 ; entry 2
    db $e0, $fe, $2f, $00 ; entry 3
    db $d8, $03, $2f, $00 ; entry 4
    db $f8, $e6, $24, $00 ; entry 5
    db $80 ; end

; frame 6 of MetaSprites3DSet21; ends with $80 (E-0147)
MetaSprites3DSet21Frame6::
    db $f8, $f0, $2f, $00 ; entry 0
    db $f0, $f5, $2f, $00 ; entry 1
    db $e8, $fa, $2f, $00 ; entry 2
    db $80 ; end

; frame 7 of MetaSprites3DSet21; ends with $80 (E-0147)
MetaSprites3DSet21Frame7::
    db $f8, $f8, $1c, $00 ; entry 0
    db $f8, $00, $1e, $00 ; entry 1
    db $f0, $fd, $1f, $00 ; entry 2
    db $80 ; end

; frame 8 of MetaSprites3DSet21; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet21Frame8::
    db $f8, $fc, $1d, $00 ; entry 0
    db $f8, $04, $1e, $00 ; entry 1
    db $f0, $fc, $1a, $00 ; entry 2
    db $f0, $04, $1b, $00 ; entry 3
    db $f8, $f4, $1c, $00 ; entry 4
    db $f0, $f4, $19, $00 ; entry 5
    db $ea, $fa, $00, $20 ; entry 6
    db $80 ; end

; frame 9 of MetaSprites3DSet21; ends with $80 (E-0147)
MetaSprites3DSet21Frame9::
    db $f8, $fc, $0e, $00 ; entry 0
    db $e8, $fc, $1a, $20 ; entry 1
    db $e8, $f4, $1b, $20 ; entry 2
    db $f0, $fc, $1d, $20 ; entry 3
    db $f8, $f4, $14, $00 ; entry 4
    db $f8, $04, $16, $00 ; entry 5
    db $f0, $0c, $19, $20 ; entry 6
    db $f8, $0c, $1c, $20 ; entry 7
    db $f0, $ec, $1b, $20 ; entry 8
    db $f8, $ec, $1e, $20 ; entry 9
    db $e2, $fe, $00, $00 ; entry 10
    db $e8, $04, $0c, $00 ; entry 11
    db $f0, $04, $1e, $00 ; entry 12
    db $f0, $f4, $0e, $00 ; entry 13
    db $80 ; end

; frame 10 of MetaSprites3DSet21; ends with $80 (E-0147)
MetaSprites3DSet21Frame10::
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

; frame 11 of MetaSprites3DSet21; ends with $80 (E-0147)
MetaSprites3DSet21Frame11::
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

; frame 12 of MetaSprites3DSet21; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet21Frame12::
    db $80 ; end

; meta-sprite set 34 of MetaSprites3DTable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3DSet22::
    dw MetaSprites3DSet22Frame0 ; entry 0
    dw MetaSprites3DSet22Frame1 ; entry 1
    dw MetaSprites3DSet22Frame2 ; entry 2
    dw MetaSprites3DSet22Frame3 ; entry 3
    dw MetaSprites3DSet22Frame4 ; entry 4
    dw MetaSprites3DSet22Frame5 ; entry 5
    dw MetaSprites3DSet22Frame6 ; entry 6
    dw MetaSprites3DSet22Frame6 ; entry 7
    dw MetaSprites3DSet22Frame6 ; entry 8
    dw MetaSprites3DSet22Frame6 ; entry 9
    dw MetaSprites3DSet22Frame6 ; entry 10
    dw MetaSprites3DSet22Frame6 ; entry 11
    dw MetaSprites3DSet22Frame6 ; entry 12
    dw MetaSprites3DSet22Frame6 ; entry 13
    dw MetaSprites3DSet22Frame6 ; entry 14
    dw MetaSprites3DSet22Frame6 ; entry 15
    dw MetaSprites3DSet22Frame6 ; entry 16
    dw MetaSprites3DSet22Frame6 ; entry 17
    dw MetaSprites3DSet22Frame6 ; entry 18
    dw MetaSprites3DSet22Frame6 ; entry 19
    dw MetaSprites3DSet22Frame6 ; entry 20
    dw MetaSprites3DSet22Frame6 ; entry 21
    dw MetaSprites3DSet22Frame6 ; entry 22
    dw MetaSprites3DSet22Frame6 ; entry 23
    dw MetaSprites3DSet22Frame6 ; entry 24
    dw MetaSprites3DSet22Frame6 ; entry 25
    dw MetaSprites3DSet22Frame6 ; entry 26
    dw MetaSprites3DSet22Frame6 ; entry 27
    dw MetaSprites3DSet22Frame6 ; entry 28
    dw MetaSprites3DSet22Frame6 ; entry 29
    dw MetaSprites3DSet22Frame6 ; entry 30
    dw MetaSprites3DSet22Frame6 ; entry 31

; frame 0 of MetaSprites3DSet22; ends with $80 (E-0147)
MetaSprites3DSet22Frame0::
    db $d0, $f8, $04, $00 ; entry 0
    db $d0, $00, $05, $00 ; entry 1
    db $80 ; end

; frame 1 of MetaSprites3DSet22; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet22Frame1::
    db $e0, $f8, $04, $00 ; entry 0
    db $e0, $00, $05, $00 ; entry 1
    db $d8, $f8, $02, $00 ; entry 2
    db $d8, $00, $03, $00 ; entry 3
    db $d0, $f8, $00, $00 ; entry 4
    db $d0, $00, $01, $00 ; entry 5
    db $80 ; end

; frame 2 of MetaSprites3DSet22; ends with $80 (E-0147)
MetaSprites3DSet22Frame2::
    db $dc, $f8, $17, $00 ; entry 0
    db $dc, $00, $17, $20 ; entry 1
    db $e4, $f0, $15, $00 ; entry 2
    db $e4, $f8, $16, $00 ; entry 3
    db $e4, $08, $15, $20 ; entry 4
    db $e4, $00, $16, $20 ; entry 5
    db $80 ; end

; frame 3 of MetaSprites3DSet22; ends with $80 (E-0147)
MetaSprites3DSet22Frame3::
    db $e4, $00, $07, $00 ; entry 0
    db $e4, $08, $08, $00 ; entry 1
    db $e4, $f8, $07, $20 ; entry 2
    db $e4, $f0, $08, $20 ; entry 3
    db $dc, $f8, $00, $00 ; entry 4
    db $dc, $00, $01, $00 ; entry 5
    db $80 ; end

; frame 4 of MetaSprites3DSet22; ends with $80 (E-0147)
MetaSprites3DSet22Frame4::
    db $d4, $f8, $0d, $20 ; entry 0
    db $d4, $f0, $0e, $20 ; entry 1
    db $d4, $00, $0d, $00 ; entry 2
    db $d4, $08, $0e, $00 ; entry 3
    db $dc, $00, $0f, $00 ; entry 4
    db $dc, $08, $10, $00 ; entry 5
    db $dc, $10, $11, $00 ; entry 6
    db $dc, $f0, $10, $20 ; entry 7
    db $dc, $e8, $11, $20 ; entry 8
    db $dc, $f8, $0f, $20 ; entry 9
    db $e4, $f8, $12, $20 ; entry 10
    db $e4, $f0, $13, $20 ; entry 11
    db $e4, $e8, $14, $20 ; entry 12
    db $e4, $00, $12, $00 ; entry 13
    db $e4, $08, $13, $00 ; entry 14
    db $e4, $10, $14, $00 ; entry 15
    db $80 ; end

; frame 5 of MetaSprites3DSet22; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet22Frame5::
    db $dc, $f8, $09, $20 ; entry 0
    db $dc, $f0, $0a, $20 ; entry 1
    db $dc, $00, $09, $00 ; entry 2
    db $dc, $08, $0a, $00 ; entry 3
    db $e4, $f8, $0b, $20 ; entry 4
    db $e4, $f0, $0c, $20 ; entry 5
    db $e4, $00, $0b, $00 ; entry 6
    db $e4, $08, $0c, $00 ; entry 7
    db $80 ; end

; frame 6 of MetaSprites3DSet22; ends with $80 (E-0147)
MetaSprites3DSet22Frame6::
    db $80 ; end

; meta-sprite set 35 of MetaSprites3DTable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3DSet23::
    dw MetaSprites3DSet23Frame0 ; entry 0
    dw MetaSprites3DSet23Frame1 ; entry 1
    dw MetaSprites3DSet23Frame2 ; entry 2
    dw MetaSprites3DSet23Frame3 ; entry 3
    dw MetaSprites3DSet23Frame4 ; entry 4
    dw MetaSprites3DSet23Frame5 ; entry 5
    dw MetaSprites3DSet23Frame6 ; entry 6
    dw MetaSprites3DSet23Frame7 ; entry 7
    dw MetaSprites3DSet23Frame7 ; entry 8
    dw MetaSprites3DSet23Frame7 ; entry 9
    dw MetaSprites3DSet23Frame7 ; entry 10
    dw MetaSprites3DSet23Frame7 ; entry 11
    dw MetaSprites3DSet23Frame7 ; entry 12
    dw MetaSprites3DSet23Frame7 ; entry 13
    dw MetaSprites3DSet23Frame7 ; entry 14
    dw MetaSprites3DSet23Frame7 ; entry 15
    dw MetaSprites3DSet23Frame7 ; entry 16
    dw MetaSprites3DSet23Frame7 ; entry 17
    dw MetaSprites3DSet23Frame7 ; entry 18
    dw MetaSprites3DSet23Frame7 ; entry 19
    dw MetaSprites3DSet23Frame7 ; entry 20
    dw MetaSprites3DSet23Frame7 ; entry 21
    dw MetaSprites3DSet23Frame7 ; entry 22
    dw MetaSprites3DSet23Frame7 ; entry 23
    dw MetaSprites3DSet23Frame7 ; entry 24
    dw MetaSprites3DSet23Frame7 ; entry 25
    dw MetaSprites3DSet23Frame7 ; entry 26
    dw MetaSprites3DSet23Frame7 ; entry 27
    dw MetaSprites3DSet23Frame7 ; entry 28
    dw MetaSprites3DSet23Frame7 ; entry 29
    dw MetaSprites3DSet23Frame7 ; entry 30
    dw MetaSprites3DSet23Frame7 ; entry 31

; frame 0 of MetaSprites3DSet23; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet23Frame0::
    db $f8, $f0, $00, $60 ; entry 0
    db $f8, $e8, $01, $60 ; entry 1
    db $80 ; end

; frame 1 of MetaSprites3DSet23; ends with $80 (E-0147)
MetaSprites3DSet23Frame1::
    db $f7, $f5, $00, $60 ; entry 0
    db $f7, $ed, $01, $60 ; entry 1
    db $f1, $fd, $00, $00 ; entry 2
    db $f1, $05, $01, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites3DSet23; ends with $80 (E-0147)
MetaSprites3DSet23Frame2::
    db $f8, $f0, $0b, $00 ; entry 0
    db $f8, $f8, $0c, $00 ; entry 1
    db $f0, $fc, $09, $00 ; entry 2
    db $f0, $04, $0a, $00 ; entry 3
    db $e0, $08, $05, $00 ; entry 4
    db $e0, $10, $06, $00 ; entry 5
    db $e8, $04, $07, $00 ; entry 6
    db $e8, $0c, $08, $00 ; entry 7
    db $d8, $10, $04, $00 ; entry 8
    db $d0, $08, $02, $00 ; entry 9
    db $d0, $10, $03, $00 ; entry 10
    db $80 ; end

; frame 3 of MetaSprites3DSet23; ends with $80 (E-0147)
MetaSprites3DSet23Frame3::
    db $f8, $f0, $0b, $00 ; entry 0
    db $f8, $f8, $0c, $00 ; entry 1
    db $f0, $fc, $09, $00 ; entry 2
    db $f0, $04, $0a, $00 ; entry 3
    db $e8, $04, $07, $00 ; entry 4
    db $e8, $0c, $08, $00 ; entry 5
    db $e0, $08, $0d, $00 ; entry 6
    db $e0, $10, $0e, $00 ; entry 7
    db $d8, $08, $0f, $00 ; entry 8
    db $d8, $10, $10, $00 ; entry 9
    db $d0, $fc, $11, $00 ; entry 10
    db $d0, $04, $12, $00 ; entry 11
    db $d0, $0c, $13, $00 ; entry 12
    db $d8, $ee, $14, $00 ; entry 13
    db $d8, $f6, $15, $00 ; entry 14
    db $e0, $e8, $16, $00 ; entry 15
    db $80 ; end

; frame 4 of MetaSprites3DSet23; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet23Frame4::
    db $f8, $f0, $0b, $00 ; entry 0
    db $f8, $f8, $0c, $00 ; entry 1
    db $d0, $fc, $17, $00 ; entry 2
    db $d0, $04, $18, $00 ; entry 3
    db $d0, $0c, $19, $00 ; entry 4
    db $d8, $ec, $1a, $00 ; entry 5
    db $d8, $f4, $1b, $00 ; entry 6
    db $d8, $fc, $1c, $00 ; entry 7
    db $d8, $08, $1d, $00 ; entry 8
    db $d8, $10, $1e, $00 ; entry 9
    db $e0, $e8, $1f, $00 ; entry 10
    db $e0, $10, $20, $00 ; entry 11
    db $e8, $0c, $28, $00 ; entry 12
    db $f0, $fc, $29, $00 ; entry 13
    db $f0, $04, $2a, $00 ; entry 14
    db $80 ; end

; frame 5 of MetaSprites3DSet23; ends with $80 (E-0147)
MetaSprites3DSet23Frame5::
    db $e0, $e8, $1f, $00 ; entry 0
    db $e0, $10, $27, $00 ; entry 1
    db $d8, $10, $26, $00 ; entry 2
    db $d0, $fc, $21, $00 ; entry 3
    db $d0, $04, $22, $00 ; entry 4
    db $d0, $0c, $23, $00 ; entry 5
    db $d8, $ee, $24, $00 ; entry 6
    db $d8, $f6, $25, $00 ; entry 7
    db $80 ; end

; frame 6 of MetaSprites3DSet23; ends with $80 (E-0147)
MetaSprites3DSet23Frame6::
    db $e0, $e8, $1f, $00 ; entry 0
    db $d8, $ee, $24, $00 ; entry 1
    db $80 ; end

; frame 7 of MetaSprites3DSet23; ends with $80 (E-0147)
MetaSprites3DSet23Frame7::
    db $80 ; end

; meta-sprite set 36 of MetaSprites3DTable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3DSet24::
    dw MetaSprites3DSet24Frame0 ; entry 0
    dw MetaSprites3DSet24Frame1 ; entry 1
    dw MetaSprites3DSet24Frame2 ; entry 2
    dw MetaSprites3DSet24Frame3 ; entry 3
    dw MetaSprites3DSet24Frame4 ; entry 4
    dw MetaSprites3DSet24Frame5 ; entry 5
    dw MetaSprites3DSet24Frame6 ; entry 6
    dw MetaSprites3DSet24Frame7 ; entry 7
    dw MetaSprites3DSet24Frame7 ; entry 8
    dw MetaSprites3DSet24Frame7 ; entry 9
    dw MetaSprites3DSet24Frame7 ; entry 10
    dw MetaSprites3DSet24Frame7 ; entry 11
    dw MetaSprites3DSet24Frame7 ; entry 12
    dw MetaSprites3DSet24Frame7 ; entry 13
    dw MetaSprites3DSet24Frame7 ; entry 14
    dw MetaSprites3DSet24Frame7 ; entry 15
    dw MetaSprites3DSet24Frame7 ; entry 16
    dw MetaSprites3DSet24Frame7 ; entry 17
    dw MetaSprites3DSet24Frame7 ; entry 18
    dw MetaSprites3DSet24Frame7 ; entry 19
    dw MetaSprites3DSet24Frame7 ; entry 20
    dw MetaSprites3DSet24Frame7 ; entry 21
    dw MetaSprites3DSet24Frame7 ; entry 22
    dw MetaSprites3DSet24Frame7 ; entry 23
    dw MetaSprites3DSet24Frame7 ; entry 24
    dw MetaSprites3DSet24Frame7 ; entry 25
    dw MetaSprites3DSet24Frame7 ; entry 26
    dw MetaSprites3DSet24Frame7 ; entry 27
    dw MetaSprites3DSet24Frame7 ; entry 28
    dw MetaSprites3DSet24Frame7 ; entry 29
    dw MetaSprites3DSet24Frame7 ; entry 30
    dw MetaSprites3DSet24Frame7 ; entry 31

; frame 0 of MetaSprites3DSet24; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet24Frame0::
    db $d8, $fc, $00, $00 ; entry 0
    db $d0, $fc, $01, $00 ; entry 1
    db $80 ; end

; frame 1 of MetaSprites3DSet24; ends with $80 (E-0147)
MetaSprites3DSet24Frame1::
    db $d0, $f8, $05, $00 ; entry 0
    db $d8, $f8, $08, $00 ; entry 1
    db $e0, $fc, $01, $00 ; entry 2
    db $d0, $fc, $03, $00 ; entry 3
    db $d8, $fc, $02, $00 ; entry 4
    db $e8, $fc, $0b, $00 ; entry 5
    db $80 ; end

; frame 2 of MetaSprites3DSet24; ends with $80 (E-0147)
MetaSprites3DSet24Frame2::
    db $d0, $f8, $05, $00 ; entry 0
    db $d8, $f0, $07, $00 ; entry 1
    db $d8, $f8, $08, $00 ; entry 2
    db $d8, $e8, $06, $00 ; entry 3
    db $f8, $fc, $00, $00 ; entry 4
    db $f0, $fc, $01, $00 ; entry 5
    db $d8, $fc, $04, $00 ; entry 6
    db $d0, $fc, $04, $00 ; entry 7
    db $e8, $fc, $0f, $00 ; entry 8
    db $e0, $fc, $0d, $00 ; entry 9
    db $e0, $f4, $0c, $00 ; entry 10
    db $e8, $f4, $0e, $00 ; entry 11
    db $e0, $03, $0c, $20 ; entry 12
    db $e8, $03, $0e, $20 ; entry 13
    db $e0, $e8, $06, $40 ; entry 14
    db $e0, $f0, $07, $40 ; entry 15
    db $e0, $f8, $08, $40 ; entry 16
    db $80 ; end

; frame 3 of MetaSprites3DSet24; ends with $80 (E-0147)
MetaSprites3DSet24Frame3::
    db $d0, $f8, $05, $00 ; entry 0
    db $d8, $f0, $07, $00 ; entry 1
    db $d8, $f8, $08, $00 ; entry 2
    db $d8, $e8, $06, $00 ; entry 3
    db $e0, $e8, $06, $40 ; entry 4
    db $e0, $f0, $07, $40 ; entry 5
    db $e0, $f8, $08, $40 ; entry 6
    db $f0, $fc, $04, $00 ; entry 7
    db $e0, $fc, $04, $00 ; entry 8
    db $d8, $fc, $04, $00 ; entry 9
    db $d0, $fc, $04, $00 ; entry 10
    db $f8, $fc, $03, $00 ; entry 11
    db $f8, $00, $0a, $20 ; entry 12
    db $e8, $fc, $0b, $00 ; entry 13
    db $e8, $f8, $09, $00 ; entry 14
    db $f0, $f8, $09, $00 ; entry 15
    db $f8, $f8, $0a, $00 ; entry 16
    db $80 ; end

; frame 4 of MetaSprites3DSet24; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet24Frame4::
    db $d0, $f8, $05, $00 ; entry 0
    db $d8, $f0, $07, $00 ; entry 1
    db $d8, $f8, $08, $00 ; entry 2
    db $d8, $e8, $06, $00 ; entry 3
    db $e0, $e8, $06, $40 ; entry 4
    db $e0, $f0, $07, $40 ; entry 5
    db $f8, $fc, $04, $00 ; entry 6
    db $f0, $fc, $04, $00 ; entry 7
    db $e8, $fc, $04, $00 ; entry 8
    db $e0, $f8, $08, $40 ; entry 9
    db $e8, $f8, $09, $00 ; entry 10
    db $f0, $f8, $09, $00 ; entry 11
    db $f8, $f8, $0a, $00 ; entry 12
    db $e0, $00, $08, $60 ; entry 13
    db $e8, $00, $09, $20 ; entry 14
    db $f0, $00, $09, $20 ; entry 15
    db $f8, $00, $0a, $20 ; entry 16
    db $80 ; end

; frame 5 of MetaSprites3DSet24; ends with $80 (E-0147)
MetaSprites3DSet24Frame5::
    db $d0, $f8, $05, $00 ; entry 0
    db $d8, $f0, $07, $00 ; entry 1
    db $d8, $f8, $08, $00 ; entry 2
    db $d8, $e8, $06, $00 ; entry 3
    db $e0, $e8, $06, $40 ; entry 4
    db $e0, $f0, $07, $40 ; entry 5
    db $e0, $f8, $08, $40 ; entry 6
    db $e8, $f8, $09, $00 ; entry 7
    db $f0, $f8, $09, $00 ; entry 8
    db $f8, $f8, $0a, $00 ; entry 9
    db $e8, $00, $09, $20 ; entry 10
    db $f0, $00, $09, $20 ; entry 11
    db $f8, $00, $0a, $20 ; entry 12
    db $d8, $08, $07, $20 ; entry 13
    db $d8, $10, $06, $20 ; entry 14
    db $e0, $10, $06, $60 ; entry 15
    db $e0, $08, $07, $60 ; entry 16
    db $e0, $00, $08, $60 ; entry 17
    db $80 ; end

; frame 6 of MetaSprites3DSet24; ends with $80 (E-0147)
MetaSprites3DSet24Frame6::
    db $d0, $f8, $05, $00 ; entry 0
    db $d8, $f0, $07, $00 ; entry 1
    db $d8, $f8, $08, $00 ; entry 2
    db $d8, $e8, $06, $00 ; entry 3
    db $e0, $e8, $06, $40 ; entry 4
    db $e0, $f0, $07, $40 ; entry 5
    db $e0, $f8, $08, $40 ; entry 6
    db $e8, $f8, $09, $00 ; entry 7
    db $f0, $f8, $09, $00 ; entry 8
    db $f8, $f8, $0a, $00 ; entry 9
    db $e8, $00, $09, $20 ; entry 10
    db $f0, $00, $09, $20 ; entry 11
    db $f8, $00, $0a, $20 ; entry 12
    db $d0, $00, $05, $20 ; entry 13
    db $d8, $08, $07, $20 ; entry 14
    db $d8, $00, $08, $20 ; entry 15
    db $d8, $10, $06, $20 ; entry 16
    db $e0, $10, $06, $60 ; entry 17
    db $e0, $08, $07, $60 ; entry 18
    db $e0, $00, $08, $60 ; entry 19
    db $80 ; end

; frame 7 of MetaSprites3DSet24; ends with $80 (E-0147)
MetaSprites3DSet24Frame7::
    db $80 ; end

; meta-sprite set 37 of MetaSprites3DTable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3DSet25::
    dw MetaSprites3DSet25Frame0 ; entry 0
    dw MetaSprites3DSet25Frame1 ; entry 1
    dw MetaSprites3DSet25Frame2 ; entry 2
    dw MetaSprites3DSet25Frame3 ; entry 3
    dw MetaSprites3DSet25Frame4 ; entry 4
    dw MetaSprites3DSet25Frame5 ; entry 5
    dw MetaSprites3DSet25Frame6 ; entry 6
    dw MetaSprites3DSet25Frame7 ; entry 7
    dw MetaSprites3DSet25Frame8 ; entry 8
    dw MetaSprites3DSet25Frame9 ; entry 9
    dw MetaSprites3DSet25Frame9 ; entry 10
    dw MetaSprites3DSet25Frame9 ; entry 11
    dw MetaSprites3DSet25Frame9 ; entry 12
    dw MetaSprites3DSet25Frame9 ; entry 13
    dw MetaSprites3DSet25Frame9 ; entry 14
    dw MetaSprites3DSet25Frame9 ; entry 15
    dw MetaSprites3DSet25Frame9 ; entry 16
    dw MetaSprites3DSet25Frame9 ; entry 17
    dw MetaSprites3DSet25Frame9 ; entry 18
    dw MetaSprites3DSet25Frame9 ; entry 19
    dw MetaSprites3DSet25Frame9 ; entry 20
    dw MetaSprites3DSet25Frame9 ; entry 21
    dw MetaSprites3DSet25Frame9 ; entry 22
    dw MetaSprites3DSet25Frame9 ; entry 23
    dw MetaSprites3DSet25Frame9 ; entry 24
    dw MetaSprites3DSet25Frame9 ; entry 25
    dw MetaSprites3DSet25Frame9 ; entry 26
    dw MetaSprites3DSet25Frame9 ; entry 27
    dw MetaSprites3DSet25Frame9 ; entry 28
    dw MetaSprites3DSet25Frame9 ; entry 29
    dw MetaSprites3DSet25Frame9 ; entry 30
    dw MetaSprites3DSet25Frame9 ; entry 31

; frame 0 of MetaSprites3DSet25; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet25Frame0::
    db $d8, $fc, $00, $00 ; entry 0
    db $d0, $fc, $01, $00 ; entry 1
    db $80 ; end

; frame 1 of MetaSprites3DSet25; ends with $80 (E-0147)
MetaSprites3DSet25Frame1::
    db $e8, $fc, $00, $00 ; entry 0
    db $e0, $fc, $01, $00 ; entry 1
    db $d0, $fc, $03, $00 ; entry 2
    db $d8, $fc, $02, $00 ; entry 3
    db $e4, $f4, $06, $20 ; entry 4
    db $e4, $03, $06, $00 ; entry 5
    db $80 ; end

; frame 2 of MetaSprites3DSet25; ends with $80 (E-0147)
MetaSprites3DSet25Frame2::
    db $f8, $fc, $00, $00 ; entry 0
    db $f0, $fc, $01, $00 ; entry 1
    db $e0, $fc, $03, $00 ; entry 2
    db $e8, $fc, $02, $00 ; entry 3
    db $d8, $fc, $04, $00 ; entry 4
    db $d0, $fc, $05, $00 ; entry 5
    db $dc, $03, $07, $00 ; entry 6
    db $dc, $0b, $08, $00 ; entry 7
    db $e4, $03, $09, $00 ; entry 8
    db $e4, $f4, $09, $20 ; entry 9
    db $dc, $f4, $07, $20 ; entry 10
    db $dc, $ec, $08, $20 ; entry 11
    db $80 ; end

; frame 3 of MetaSprites3DSet25; ends with $80 (E-0147)
MetaSprites3DSet25Frame3::
    db $d0, $fc, $05, $00 ; entry 0
    db $f8, $fc, $03, $00 ; entry 1
    db $f0, $fc, $04, $00 ; entry 2
    db $e8, $fc, $05, $00 ; entry 3
    db $e0, $fc, $05, $00 ; entry 4
    db $d8, $fc, $05, $00 ; entry 5
    db $d4, $03, $0a, $00 ; entry 6
    db $d4, $0b, $0b, $00 ; entry 7
    db $dc, $03, $0c, $00 ; entry 8
    db $dc, $0b, $0d, $00 ; entry 9
    db $e4, $03, $0e, $00 ; entry 10
    db $e4, $0b, $0f, $00 ; entry 11
    db $d4, $f4, $0a, $20 ; entry 12
    db $d4, $ec, $0b, $20 ; entry 13
    db $dc, $f4, $0c, $20 ; entry 14
    db $dc, $ec, $0d, $20 ; entry 15
    db $e4, $f4, $0e, $20 ; entry 16
    db $e4, $ec, $0f, $20 ; entry 17
    db $80 ; end

; frame 4 of MetaSprites3DSet25; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet25Frame4::
    db $d0, $fc, $10, $00 ; entry 0
    db $d8, $fc, $10, $00 ; entry 1
    db $e0, $fc, $10, $00 ; entry 2
    db $e8, $fc, $10, $00 ; entry 3
    db $f0, $fc, $10, $00 ; entry 4
    db $f8, $fc, $10, $00 ; entry 5
    db $e4, $f4, $09, $20 ; entry 6
    db $dc, $f4, $07, $20 ; entry 7
    db $dc, $ec, $08, $20 ; entry 8
    db $dc, $04, $07, $00 ; entry 9
    db $dc, $0c, $08, $00 ; entry 10
    db $e4, $03, $09, $00 ; entry 11
    db $80 ; end

; frame 5 of MetaSprites3DSet25; ends with $80 (E-0147)
MetaSprites3DSet25Frame5::
    db $d0, $fc, $10, $00 ; entry 0
    db $d8, $fc, $10, $00 ; entry 1
    db $e0, $fc, $10, $00 ; entry 2
    db $e8, $fc, $10, $00 ; entry 3
    db $f0, $fc, $10, $00 ; entry 4
    db $f8, $fc, $10, $00 ; entry 5
    db $d4, $f4, $0a, $20 ; entry 6
    db $d4, $ec, $0b, $20 ; entry 7
    db $dc, $f4, $0c, $20 ; entry 8
    db $dc, $ec, $0d, $20 ; entry 9
    db $e4, $f4, $0e, $20 ; entry 10
    db $e4, $ec, $0f, $20 ; entry 11
    db $d4, $03, $0a, $00 ; entry 12
    db $d4, $0b, $0b, $00 ; entry 13
    db $dc, $03, $0c, $00 ; entry 14
    db $dc, $0b, $0d, $00 ; entry 15
    db $e4, $03, $0e, $00 ; entry 16
    db $e4, $0b, $0f, $00 ; entry 17
    db $80 ; end

; frame 6 of MetaSprites3DSet25; ends with $80 (E-0147)
MetaSprites3DSet25Frame6::
    db $d0, $fb, $10, $20 ; entry 0
    db $d8, $fb, $10, $20 ; entry 1
    db $e0, $fb, $10, $20 ; entry 2
    db $e8, $fb, $10, $20 ; entry 3
    db $f0, $fb, $10, $20 ; entry 4
    db $f8, $fb, $10, $20 ; entry 5
    db $e4, $f4, $06, $20 ; entry 6
    db $e4, $03, $06, $00 ; entry 7
    db $80 ; end

; frame 7 of MetaSprites3DSet25; ends with $80 (E-0147)
MetaSprites3DSet25Frame7::
    db $d0, $fc, $11, $00 ; entry 0
    db $d8, $fc, $11, $00 ; entry 1
    db $e0, $fc, $11, $00 ; entry 2
    db $e8, $fc, $11, $00 ; entry 3
    db $f0, $fc, $11, $00 ; entry 4
    db $f8, $fc, $11, $00 ; entry 5
    db $80 ; end

; frame 8 of MetaSprites3DSet25; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet25Frame8::
    db $d0, $fb, $11, $20 ; entry 0
    db $d8, $fb, $11, $20 ; entry 1
    db $e0, $fb, $11, $20 ; entry 2
    db $e8, $fb, $11, $20 ; entry 3
    db $f0, $fb, $11, $20 ; entry 4
    db $f8, $fb, $11, $20 ; entry 5
    db $80 ; end

; frame 9 of MetaSprites3DSet25; ends with $80 (E-0147)
MetaSprites3DSet25Frame9::
    db $80 ; end

; meta-sprite set 38 of MetaSprites3DTable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3DSet26::
    dw MetaSprites3DSet26Frame0 ; entry 0
    dw MetaSprites3DSet26Frame1 ; entry 1
    dw MetaSprites3DSet26Frame2 ; entry 2
    dw MetaSprites3DSet26Frame3 ; entry 3
    dw MetaSprites3DSet26Frame4 ; entry 4
    dw MetaSprites3DSet26Frame5 ; entry 5
    dw MetaSprites3DSet26Frame6 ; entry 6
    dw MetaSprites3DSet26Frame7 ; entry 7
    dw MetaSprites3DSet26Frame8 ; entry 8
    dw MetaSprites3DSet26Frame9 ; entry 9
    dw MetaSprites3DSet26Frame10 ; entry 10
    dw MetaSprites3DSet26Frame11 ; entry 11
    dw MetaSprites3DSet26Frame12 ; entry 12
    dw MetaSprites3DSet26Frame12 ; entry 13
    dw MetaSprites3DSet26Frame12 ; entry 14
    dw MetaSprites3DSet26Frame12 ; entry 15
    dw MetaSprites3DSet26Frame12 ; entry 16
    dw MetaSprites3DSet26Frame12 ; entry 17
    dw MetaSprites3DSet26Frame12 ; entry 18
    dw MetaSprites3DSet26Frame12 ; entry 19
    dw MetaSprites3DSet26Frame12 ; entry 20
    dw MetaSprites3DSet26Frame12 ; entry 21
    dw MetaSprites3DSet26Frame12 ; entry 22
    dw MetaSprites3DSet26Frame12 ; entry 23
    dw MetaSprites3DSet26Frame12 ; entry 24
    dw MetaSprites3DSet26Frame12 ; entry 25
    dw MetaSprites3DSet26Frame12 ; entry 26
    dw MetaSprites3DSet26Frame12 ; entry 27
    dw MetaSprites3DSet26Frame12 ; entry 28
    dw MetaSprites3DSet26Frame12 ; entry 29
    dw MetaSprites3DSet26Frame12 ; entry 30
    dw MetaSprites3DSet26Frame12 ; entry 31

; frame 0 of MetaSprites3DSet26; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet26Frame0::
    db $d8, $03, $00, $00 ; entry 0
    db $d8, $0b, $01, $00 ; entry 1
    db $d0, $03, $02, $00 ; entry 2
    db $d0, $0b, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites3DSet26; ends with $80 (E-0147)
MetaSprites3DSet26Frame1::
    db $dc, $ff, $00, $00 ; entry 0
    db $dc, $07, $01, $00 ; entry 1
    db $d4, $ff, $02, $00 ; entry 2
    db $d4, $07, $03, $00 ; entry 3
    db $e4, $f9, $00, $60 ; entry 4
    db $e4, $f1, $01, $60 ; entry 5
    db $ec, $f9, $02, $60 ; entry 6
    db $ec, $f1, $03, $60 ; entry 7
    db $80 ; end

; frame 2 of MetaSprites3DSet26; ends with $80 (E-0147)
MetaSprites3DSet26Frame2::
    db $e0, $fe, $11, $00 ; entry 0
    db $e0, $06, $12, $00 ; entry 1
    db $d8, $0e, $10, $00 ; entry 2
    db $d8, $fe, $0e, $00 ; entry 3
    db $d8, $06, $0f, $00 ; entry 4
    db $d0, $02, $0b, $00 ; entry 5
    db $d0, $0a, $0c, $00 ; entry 6
    db $d0, $12, $0d, $00 ; entry 7
    db $80 ; end

; frame 3 of MetaSprites3DSet26; ends with $80 (E-0147)
MetaSprites3DSet26Frame3::
    db $f0, $f5, $11, $00 ; entry 0
    db $f0, $fd, $12, $00 ; entry 1
    db $d0, $02, $06, $00 ; entry 2
    db $d0, $0a, $07, $00 ; entry 3
    db $d8, $01, $09, $00 ; entry 4
    db $d8, $09, $0a, $00 ; entry 5
    db $e0, $09, $0d, $00 ; entry 6
    db $e8, $05, $10, $00 ; entry 7
    db $d8, $f9, $08, $00 ; entry 8
    db $d8, $f7, $19, $00 ; entry 9
    db $e8, $f0, $1d, $00 ; entry 10
    db $e8, $f8, $1e, $00 ; entry 11
    db $e8, $00, $1f, $00 ; entry 12
    db $e0, $f9, $1b, $00 ; entry 13
    db $e0, $01, $1c, $00 ; entry 14
    db $80 ; end

; frame 4 of MetaSprites3DSet26; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet26Frame4::
    db $e0, $f8, $22, $00 ; entry 0
    db $e0, $00, $23, $00 ; entry 1
    db $e0, $08, $24, $00 ; entry 2
    db $d8, $f3, $20, $00 ; entry 3
    db $e8, $02, $26, $00 ; entry 4
    db $f0, $0a, $29, $00 ; entry 5
    db $f8, $ea, $0b, $00 ; entry 6
    db $f8, $f2, $0c, $00 ; entry 7
    db $f8, $fa, $0d, $00 ; entry 8
    db $f0, $ea, $08, $00 ; entry 9
    db $f0, $f2, $09, $00 ; entry 10
    db $f0, $fa, $0a, $00 ; entry 11
    db $e8, $f4, $06, $00 ; entry 12
    db $e8, $fa, $25, $00 ; entry 13
    db $d0, $09, $13, $00 ; entry 14
    db $d8, $04, $13, $00 ; entry 15
    db $80 ; end

; frame 5 of MetaSprites3DSet26; ends with $80 (E-0147)
MetaSprites3DSet26Frame5::
    db $f0, $f4, $13, $00 ; entry 0
    db $f8, $ef, $13, $00 ; entry 1
    db $d8, $04, $14, $00 ; entry 2
    db $ec, $f0, $1d, $00 ; entry 3
    db $ec, $f8, $1e, $00 ; entry 4
    db $ec, $00, $1f, $00 ; entry 5
    db $dc, $09, $1a, $00 ; entry 6
    db $dc, $f8, $19, $00 ; entry 7
    db $e0, $ff, $14, $00 ; entry 8
    db $e4, $f9, $1b, $00 ; entry 9
    db $e4, $01, $1c, $00 ; entry 10
    db $80 ; end

; frame 6 of MetaSprites3DSet26; ends with $80 (E-0147)
MetaSprites3DSet26Frame6::
    db $dc, $f4, $2e, $00 ; entry 0
    db $e4, $f4, $2f, $40 ; entry 1
    db $dc, $fc, $2d, $20 ; entry 2
    db $dc, $04, $2e, $20 ; entry 3
    db $e4, $04, $2f, $60 ; entry 4
    db $e4, $fc, $04, $00 ; entry 5
    db $f8, $ef, $14, $00 ; entry 6
    db $f0, $f4, $14, $00 ; entry 7
    db $ec, $fc, $2d, $60 ; entry 8
    db $ec, $04, $2e, $60 ; entry 9
    db $ec, $f4, $2e, $40 ; entry 10
    db $80 ; end

; frame 7 of MetaSprites3DSet26; ends with $80 (E-0147)
MetaSprites3DSet26Frame7::
    db $d0, $e8, $2b, $00 ; entry 0
    db $d0, $f0, $2c, $00 ; entry 1
    db $d0, $f8, $2d, $00 ; entry 2
    db $e0, $e8, $2f, $00 ; entry 3
    db $e0, $f0, $2a, $00 ; entry 4
    db $d8, $f8, $2a, $00 ; entry 5
    db $d8, $e8, $2e, $00 ; entry 6
    db $d0, $10, $2b, $20 ; entry 7
    db $d0, $08, $2c, $20 ; entry 8
    db $d0, $00, $2d, $20 ; entry 9
    db $e0, $10, $2f, $20 ; entry 10
    db $e0, $08, $2a, $20 ; entry 11
    db $d8, $00, $2a, $20 ; entry 12
    db $d8, $10, $2e, $20 ; entry 13
    db $f8, $e8, $2b, $40 ; entry 14
    db $f8, $f0, $2c, $40 ; entry 15
    db $f8, $f8, $2d, $40 ; entry 16
    db $e8, $e8, $2f, $40 ; entry 17
    db $e8, $f0, $2a, $40 ; entry 18
    db $f0, $f8, $2a, $40 ; entry 19
    db $f0, $e8, $2e, $40 ; entry 20
    db $f8, $10, $2b, $60 ; entry 21
    db $f8, $08, $2c, $60 ; entry 22
    db $f8, $00, $2d, $60 ; entry 23
    db $e8, $10, $2f, $60 ; entry 24
    db $e8, $08, $2a, $60 ; entry 25
    db $f0, $00, $2a, $60 ; entry 26
    db $f0, $10, $2e, $60 ; entry 27
    db $e0, $00, $04, $60 ; entry 28
    db $e8, $00, $04, $20 ; entry 29
    db $e8, $f8, $04, $00 ; entry 30
    db $e0, $f8, $04, $40 ; entry 31
    db $d8, $08, $04, $00 ; entry 32
    db $d8, $f0, $04, $20 ; entry 33
    db $f0, $08, $04, $40 ; entry 34
    db $f0, $f0, $04, $60 ; entry 35
    db $80 ; end

; frame 8 of MetaSprites3DSet26; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet26Frame8::
    db $d0, $05, $15, $00 ; entry 0
    db $d0, $0d, $16, $00 ; entry 1
    db $d8, $00, $15, $00 ; entry 2
    db $d8, $08, $16, $00 ; entry 3
    db $e0, $fb, $15, $00 ; entry 4
    db $e0, $03, $16, $00 ; entry 5
    db $e8, $f5, $15, $00 ; entry 6
    db $e8, $fd, $16, $00 ; entry 7
    db $f0, $f0, $15, $00 ; entry 8
    db $f0, $f8, $16, $00 ; entry 9
    db $f8, $eb, $15, $00 ; entry 10
    db $f8, $f3, $16, $00 ; entry 11
    db $80 ; end

; frame 9 of MetaSprites3DSet26; ends with $80 (E-0147)
MetaSprites3DSet26Frame9::
    db $d0, $0d, $15, $60 ; entry 0
    db $d0, $05, $16, $60 ; entry 1
    db $d8, $08, $15, $60 ; entry 2
    db $d8, $00, $16, $60 ; entry 3
    db $e0, $03, $15, $60 ; entry 4
    db $e0, $fb, $16, $60 ; entry 5
    db $e8, $fd, $15, $60 ; entry 6
    db $e8, $f5, $16, $60 ; entry 7
    db $f0, $f8, $15, $60 ; entry 8
    db $f0, $f0, $16, $60 ; entry 9
    db $f8, $f3, $15, $60 ; entry 10
    db $f8, $eb, $16, $60 ; entry 11
    db $80 ; end

; frame 10 of MetaSprites3DSet26; ends with $80 (E-0147)
MetaSprites3DSet26Frame10::
    db $d0, $05, $17, $00 ; entry 0
    db $d0, $0d, $18, $00 ; entry 1
    db $d8, $00, $17, $00 ; entry 2
    db $d8, $08, $18, $00 ; entry 3
    db $e0, $fb, $17, $00 ; entry 4
    db $e0, $03, $18, $00 ; entry 5
    db $e8, $f5, $17, $00 ; entry 6
    db $e8, $fd, $18, $00 ; entry 7
    db $f0, $f0, $17, $00 ; entry 8
    db $f0, $f8, $18, $00 ; entry 9
    db $f8, $eb, $17, $00 ; entry 10
    db $f8, $f3, $18, $00 ; entry 11
    db $80 ; end

; frame 11 of MetaSprites3DSet26; ends with $80 (E-0147)
MetaSprites3DSet26Frame11::
    db $d0, $0d, $17, $60 ; entry 0
    db $d0, $05, $18, $60 ; entry 1
    db $d8, $08, $17, $60 ; entry 2
    db $d8, $00, $18, $60 ; entry 3
    db $e0, $03, $17, $60 ; entry 4
    db $e0, $fb, $18, $60 ; entry 5
    db $e8, $fd, $17, $60 ; entry 6
    db $e8, $f5, $18, $60 ; entry 7
    db $f0, $f8, $17, $60 ; entry 8
    db $f0, $f0, $18, $60 ; entry 9
    db $f8, $f3, $17, $60 ; entry 10
    db $f8, $eb, $18, $60 ; entry 11
    db $80 ; end

; frame 12 of MetaSprites3DSet26; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet26Frame12::
    db $80 ; end

; meta-sprite set 39 of MetaSprites3DTable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3DSet27::
    dw MetaSprites3DSet27Frame0 ; entry 0
    dw MetaSprites3DSet27Frame1 ; entry 1
    dw MetaSprites3DSet27Frame2 ; entry 2
    dw MetaSprites3DSet27Frame3 ; entry 3
    dw MetaSprites3DSet27Frame4 ; entry 4
    dw MetaSprites3DSet27Frame5 ; entry 5
    dw MetaSprites3DSet27Frame6 ; entry 6
    dw MetaSprites3DSet27Frame7 ; entry 7
    dw MetaSprites3DSet27Frame8 ; entry 8
    dw MetaSprites3DSet27Frame9 ; entry 9
    dw MetaSprites3DSet27Frame10 ; entry 10
    dw MetaSprites3DSet27Frame11 ; entry 11
    dw MetaSprites3DSet27Frame12 ; entry 12
    dw MetaSprites3DSet27Frame13 ; entry 13
    dw MetaSprites3DSet27Frame14 ; entry 14
    dw MetaSprites3DSet27Frame14 ; entry 15
    dw MetaSprites3DSet27Frame14 ; entry 16
    dw MetaSprites3DSet27Frame14 ; entry 17
    dw MetaSprites3DSet27Frame14 ; entry 18
    dw MetaSprites3DSet27Frame14 ; entry 19
    dw MetaSprites3DSet27Frame14 ; entry 20
    dw MetaSprites3DSet27Frame14 ; entry 21
    dw MetaSprites3DSet27Frame14 ; entry 22
    dw MetaSprites3DSet27Frame14 ; entry 23
    dw MetaSprites3DSet27Frame14 ; entry 24
    dw MetaSprites3DSet27Frame14 ; entry 25
    dw MetaSprites3DSet27Frame14 ; entry 26
    dw MetaSprites3DSet27Frame14 ; entry 27
    dw MetaSprites3DSet27Frame14 ; entry 28
    dw MetaSprites3DSet27Frame14 ; entry 29
    dw MetaSprites3DSet27Frame14 ; entry 30
    dw MetaSprites3DSet27Frame14 ; entry 31

; frame 0 of MetaSprites3DSet27; ends with $80 (E-0147)
MetaSprites3DSet27Frame0::
    db $e8, $b0, $1c, $10 ; entry 0
    db $e8, $c0, $1e, $10 ; entry 1
    db $e8, $c8, $1f, $10 ; entry 2
    db $e6, $b8, $1d, $10 ; entry 3
    db $e2, $bf, $22, $10 ; entry 4
    db $80 ; end

; frame 1 of MetaSprites3DSet27; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet27Frame1::
    db $e8, $b0, $1c, $10 ; entry 0
    db $e8, $b8, $1c, $10 ; entry 1
    db $e8, $c0, $1c, $10 ; entry 2
    db $e8, $d0, $1e, $10 ; entry 3
    db $e8, $d8, $1f, $10 ; entry 4
    db $e6, $c8, $1d, $10 ; entry 5
    db $dc, $ba, $22, $10 ; entry 6
    db $e2, $c2, $22, $10 ; entry 7
    db $80 ; end

; frame 2 of MetaSprites3DSet27; ends with $80 (E-0147)
MetaSprites3DSet27Frame2::
    db $e8, $b0, $1c, $10 ; entry 0
    db $e8, $b8, $1c, $10 ; entry 1
    db $e8, $c0, $1c, $10 ; entry 2
    db $e8, $c8, $1c, $10 ; entry 3
    db $e8, $d0, $1c, $10 ; entry 4
    db $e8, $e0, $1e, $10 ; entry 5
    db $e8, $e8, $1f, $10 ; entry 6
    db $d9, $f3, $12, $10 ; entry 7
    db $e6, $d8, $1d, $10 ; entry 8
    db $d0, $03, $22, $10 ; entry 9
    db $d1, $f2, $22, $10 ; entry 10
    db $dd, $c6, $22, $10 ; entry 11
    db $da, $bb, $22, $10 ; entry 12
    db $d0, $fa, $23, $10 ; entry 13
    db $d8, $fa, $24, $10 ; entry 14
    db $e0, $fa, $25, $10 ; entry 15
    db $80 ; end

; frame 3 of MetaSprites3DSet27; ends with $80 (E-0147)
MetaSprites3DSet27Frame3::
    db $e8, $d8, $1c, $10 ; entry 0
    db $e8, $e0, $1c, $10 ; entry 1
    db $dc, $df, $12, $10 ; entry 2
    db $d7, $f2, $12, $10 ; entry 3
    db $db, $03, $12, $30 ; entry 4
    db $d0, $fc, $1b, $10 ; entry 5
    db $e8, $f8, $1f, $10 ; entry 6
    db $d8, $c0, $22, $10 ; entry 7
    db $dd, $d0, $22, $10 ; entry 8
    db $d1, $f2, $22, $10 ; entry 9
    db $d0, $03, $22, $10 ; entry 10
    db $d8, $fa, $23, $10 ; entry 11
    db $e8, $b0, $20, $10 ; entry 12
    db $e8, $bb, $21, $10 ; entry 13
    db $e8, $c6, $1c, $10 ; entry 14
    db $e8, $cf, $1c, $10 ; entry 15
    db $e0, $fa, $24, $10 ; entry 16
    db $e8, $fa, $25, $10 ; entry 17
    db $e0, $e8, $29, $10 ; entry 18
    db $e0, $f0, $2a, $10 ; entry 19
    db $e8, $e8, $2b, $10 ; entry 20
    db $e8, $f0, $2c, $10 ; entry 21
    db $80 ; end

; frame 4 of MetaSprites3DSet27; ends with $80 (E-0147)
MetaSprites3DSet27Frame4::
    db $e8, $dd, $1c, $10 ; entry 0
    db $e8, $e5, $1c, $10 ; entry 1
    db $e8, $ed, $1c, $10 ; entry 2
    db $e8, $f5, $1c, $10 ; entry 3
    db $e8, $d3, $1c, $10 ; entry 4
    db $d0, $fc, $19, $10 ; entry 5
    db $e8, $fc, $1b, $10 ; entry 6
    db $dc, $d2, $12, $10 ; entry 7
    db $e8, $c8, $20, $10 ; entry 8
    db $f0, $fa, $24, $10 ; entry 9
    db $f8, $fa, $25, $10 ; entry 10
    db $d4, $f5, $22, $10 ; entry 11
    db $d8, $e0, $22, $10 ; entry 12
    db $d2, $03, $22, $30 ; entry 13
    db $db, $01, $26, $10 ; entry 14
    db $d9, $06, $27, $10 ; entry 15
    db $d9, $f8, $27, $10 ; entry 16
    db $e0, $02, $29, $10 ; entry 17
    db $e0, $0a, $2a, $10 ; entry 18
    db $e0, $f6, $28, $10 ; entry 19
    db $e8, $02, $2d, $10 ; entry 20
    db $e8, $0a, $2e, $10 ; entry 21
    db $e6, $12, $2f, $10 ; entry 22
    db $80 ; end

; frame 5 of MetaSprites3DSet27; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet27Frame5::
    db $e8, $ef, $1c, $10 ; entry 0
    db $e8, $f7, $1c, $10 ; entry 1
    db $e8, $ff, $1c, $10 ; entry 2
    db $e8, $07, $1c, $10 ; entry 3
    db $e8, $0f, $1c, $10 ; entry 4
    db $e8, $27, $1f, $10 ; entry 5
    db $da, $05, $12, $10 ; entry 6
    db $cf, $f2, $12, $10 ; entry 7
    db $f7, $03, $12, $30 ; entry 8
    db $f0, $fc, $19, $10 ; entry 9
    db $d0, $fc, $18, $10 ; entry 10
    db $d8, $fc, $22, $30 ; entry 11
    db $dc, $e8, $22, $10 ; entry 12
    db $d8, $11, $22, $10 ; entry 13
    db $f0, $f3, $22, $10 ; entry 14
    db $f8, $fa, $23, $10 ; entry 15
    db $de, $fc, $27, $10 ; entry 16
    db $e0, $08, $26, $10 ; entry 17
    db $e8, $df, $20, $10 ; entry 18
    db $e8, $e7, $21, $10 ; entry 19
    db $e0, $0f, $28, $10 ; entry 20
    db $e1, $16, $29, $10 ; entry 21
    db $e0, $1e, $2a, $10 ; entry 22
    db $e8, $17, $2b, $10 ; entry 23
    db $e8, $1f, $2c, $10 ; entry 24
    db $80 ; end

; frame 6 of MetaSprites3DSet27; ends with $80 (E-0147)
MetaSprites3DSet27Frame6::
    db $d0, $fc, $18, $10 ; entry 0
    db $e0, $fc, $18, $10 ; entry 1
    db $f8, $fc, $18, $10 ; entry 2
    db $f0, $fc, $19, $10 ; entry 3
    db $d8, $fc, $19, $10 ; entry 4
    db $d4, $06, $12, $10 ; entry 5
    db $da, $de, $12, $10 ; entry 6
    db $e8, $07, $1c, $10 ; entry 7
    db $e8, $0f, $1c, $10 ; entry 8
    db $e8, $17, $1c, $10 ; entry 9
    db $e8, $1f, $1c, $10 ; entry 10
    db $e8, $2f, $1e, $10 ; entry 11
    db $e8, $37, $1f, $10 ; entry 12
    db $e6, $27, $1d, $10 ; entry 13
    db $e0, $25, $26, $10 ; entry 14
    db $de, $04, $26, $10 ; entry 15
    db $dd, $0f, $22, $10 ; entry 16
    db $dd, $ee, $22, $10 ; entry 17
    db $e8, $eb, $20, $10 ; entry 18
    db $e8, $f5, $20, $10 ; entry 19
    db $e8, $ff, $21, $10 ; entry 20
    db $de, $19, $28, $10 ; entry 21
    db $80 ; end

; frame 7 of MetaSprites3DSet27; ends with $80 (E-0147)
MetaSprites3DSet27Frame7::
    db $e8, $1f, $1c, $10 ; entry 0
    db $e8, $27, $1c, $10 ; entry 1
    db $e8, $37, $1e, $10 ; entry 2
    db $e8, $3f, $1f, $10 ; entry 3
    db $db, $fa, $12, $10 ; entry 4
    db $e6, $2f, $1d, $10 ; entry 5
    db $de, $d6, $22, $10 ; entry 6
    db $db, $1d, $22, $10 ; entry 7
    db $e8, $f1, $20, $10 ; entry 8
    db $e8, $04, $20, $10 ; entry 9
    db $e8, $0d, $20, $10 ; entry 10
    db $e8, $15, $21, $10 ; entry 11
    db $e2, $27, $26, $10 ; entry 12
    db $80 ; end

; frame 8 of MetaSprites3DSet27; ends with $80 (E-0147)
MetaSprites3DSet27Frame8::
    db $e0, $3d, $12, $10 ; entry 0
    db $e8, $15, $20, $10 ; entry 1
    db $e8, $20, $20, $10 ; entry 2
    db $e8, $29, $20, $10 ; entry 3
    db $e8, $3a, $20, $10 ; entry 4
    db $e0, $2d, $22, $10 ; entry 5
    db $e8, $32, $21, $10 ; entry 6
    db $e8, $4a, $21, $10 ; entry 7
    db $e8, $b8, $20, $10 ; entry 8
    db $e8, $d4, $20, $10 ; entry 9
    db $e8, $f4, $22, $10 ; entry 10
    db $80 ; end

; frame 9 of MetaSprites3DSet27; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet27Frame9::
    db $e8, $4a, $20, $10 ; entry 0
    db $e8, $20, $20, $10 ; entry 1
    db $e8, $3e, $22, $10 ; entry 2
    db $e8, $2e, $21, $10 ; entry 3
    db $e8, $0d, $21, $10 ; entry 4
    db $e8, $02, $22, $10 ; entry 5
    db $e8, $dc, $22, $10 ; entry 6
    db $e8, $ea, $20, $10 ; entry 7
    db $e8, $bb, $22, $10 ; entry 8
    db $80 ; end

; frame 10 of MetaSprites3DSet27; ends with $80 (E-0147)
MetaSprites3DSet27Frame10::
    db $e8, $b1, $20, $10 ; entry 0
    db $e8, $d2, $20, $10 ; entry 1
    db $e8, $f8, $20, $10 ; entry 2
    db $e8, $e0, $21, $10 ; entry 3
    db $e8, $bf, $22, $10 ; entry 4
    db $e8, $0b, $22, $10 ; entry 5
    db $e8, $13, $20, $10 ; entry 6
    db $e8, $34, $20, $10 ; entry 7
    db $e8, $1c, $21, $10 ; entry 8
    db $e8, $40, $21, $10 ; entry 9
    db $80 ; end

; frame 11 of MetaSprites3DSet27; ends with $80 (E-0147)
MetaSprites3DSet27Frame11::
    db $e8, $03, $11, $30 ; entry 0
    db $e8, $0d, $11, $30 ; entry 1
    db $e8, $16, $03, $30 ; entry 2
    db $dd, $17, $03, $70 ; entry 3
    db $e8, $27, $07, $50 ; entry 4
    db $d5, $28, $02, $70 ; entry 5
    db $dd, $28, $07, $10 ; entry 6
    db $e8, $1e, $15, $30 ; entry 7
    db $d6, $20, $01, $10 ; entry 8
    db $dd, $1f, $15, $70 ; entry 9
    db $cd, $30, $17, $70 ; entry 10
    db $f8, $31, $17, $30 ; entry 11
    db $f0, $28, $02, $30 ; entry 12
    db $f0, $17, $02, $30 ; entry 13
    db $f0, $20, $01, $50 ; entry 14
    db $f0, $03, $11, $30 ; entry 15
    db $dd, $0d, $1a, $70 ; entry 16
    db $d0, $0c, $02, $10 ; entry 17
    db $d4, $14, $02, $10 ; entry 18
    db $e8, $f5, $11, $10 ; entry 19
    db $e8, $eb, $11, $10 ; entry 20
    db $e8, $e2, $03, $10 ; entry 21
    db $dd, $e1, $03, $50 ; entry 22
    db $e8, $d1, $07, $70 ; entry 23
    db $d5, $d0, $02, $50 ; entry 24
    db $dd, $d0, $07, $30 ; entry 25
    db $e8, $da, $15, $10 ; entry 26
    db $d6, $d8, $01, $30 ; entry 27
    db $dd, $d9, $15, $50 ; entry 28
    db $cd, $c8, $17, $50 ; entry 29
    db $f0, $e1, $02, $10 ; entry 30
    db $f0, $d8, $01, $70 ; entry 31
    db $f0, $f5, $11, $10 ; entry 32
    db $d0, $ec, $02, $30 ; entry 33
    db $d4, $e4, $02, $30 ; entry 34
    db $f1, $d0, $02, $10 ; entry 35
    db $f8, $c8, $17, $10 ; entry 36
    db $dd, $eb, $1a, $50 ; entry 37
    db $f8, $03, $11, $30 ; entry 38
    db $f8, $f5, $11, $10 ; entry 39
    db $d8, $f5, $11, $50 ; entry 40
    db $dd, $f5, $11, $50 ; entry 41
    db $d0, $f5, $11, $50 ; entry 42
    db $d0, $03, $11, $70 ; entry 43
    db $dd, $03, $11, $70 ; entry 44
    db $d8, $03, $11, $70 ; entry 45
    db $f8, $df, $02, $10 ; entry 46
    db $f8, $19, $02, $30 ; entry 47
    db $80 ; end

; frame 12 of MetaSprites3DSet27; ends with $80 (E-0147)
MetaSprites3DSet27Frame12::
    db $f8, $e8, $1a, $10 ; entry 0
    db $d0, $e8, $1a, $50 ; entry 1
    db $f0, $28, $14, $30 ; entry 2
    db $f8, $10, $1a, $30 ; entry 3
    db $d8, $28, $14, $70 ; entry 4
    db $d0, $10, $1a, $70 ; entry 5
    db $f0, $20, $13, $30 ; entry 6
    db $d8, $20, $13, $70 ; entry 7
    db $e8, $24, $13, $30 ; entry 8
    db $e0, $24, $13, $70 ; entry 9
    db $ea, $2c, $16, $50 ; entry 10
    db $de, $2c, $16, $10 ; entry 11
    db $d0, $19, $11, $10 ; entry 12
    db $f8, $19, $11, $30 ; entry 13
    db $e0, $1b, $06, $70 ; entry 14
    db $e8, $1b, $06, $30 ; entry 15
    db $f0, $40, $06, $30 ; entry 16
    db $f8, $34, $06, $30 ; entry 17
    db $d8, $40, $06, $70 ; entry 18
    db $d0, $34, $06, $70 ; entry 19
    db $ea, $f5, $11, $10 ; entry 20
    db $ea, $03, $11, $30 ; entry 21
    db $de, $f5, $11, $50 ; entry 22
    db $de, $03, $11, $70 ; entry 23
    db $f0, $d0, $14, $10 ; entry 24
    db $d8, $d0, $14, $50 ; entry 25
    db $f0, $d8, $13, $10 ; entry 26
    db $d8, $d8, $13, $50 ; entry 27
    db $e0, $d4, $13, $50 ; entry 28
    db $d0, $df, $11, $30 ; entry 29
    db $f8, $df, $11, $10 ; entry 30
    db $e0, $dd, $06, $50 ; entry 31
    db $e8, $dd, $06, $10 ; entry 32
    db $f8, $c4, $06, $10 ; entry 33
    db $d0, $c4, $06, $50 ; entry 34
    db $f0, $f5, $11, $10 ; entry 35
    db $e8, $d4, $13, $10 ; entry 36
    db $f8, $f5, $1a, $10 ; entry 37
    db $e8, $cc, $16, $70 ; entry 38
    db $e0, $cc, $16, $30 ; entry 39
    db $d8, $f5, $11, $50 ; entry 40
    db $d0, $f5, $1a, $50 ; entry 41
    db $de, $ed, $11, $50 ; entry 42
    db $ea, $ed, $11, $10 ; entry 43
    db $de, $0b, $11, $70 ; entry 44
    db $ea, $0b, $11, $30 ; entry 45
    db $d8, $03, $11, $70 ; entry 46
    db $d0, $03, $1a, $70 ; entry 47
    db $f0, $03, $11, $30 ; entry 48
    db $f8, $03, $1a, $30 ; entry 49
    db $f8, $48, $06, $30 ; entry 50
    db $d0, $48, $06, $70 ; entry 51
    db $80 ; end

; frame 13 of MetaSprites3DSet27; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet27Frame13::
    db $e8, $f8, $0d, $10 ; entry 0
    db $e0, $f8, $0d, $50 ; entry 1
    db $d0, $f0, $10, $50 ; entry 2
    db $f0, $f8, $0e, $10 ; entry 3
    db $f8, $f8, $0e, $10 ; entry 4
    db $d8, $f8, $0e, $50 ; entry 5
    db $d0, $f8, $0e, $50 ; entry 6
    db $d0, $b1, $06, $50 ; entry 7
    db $d8, $d2, $0a, $50 ; entry 8
    db $d8, $e7, $0b, $50 ; entry 9
    db $d0, $d9, $0c, $50 ; entry 10
    db $d0, $ca, $07, $50 ; entry 11
    db $f8, $f0, $10, $10 ; entry 12
    db $f8, $b1, $06, $10 ; entry 13
    db $f0, $d2, $0a, $10 ; entry 14
    db $f0, $e7, $0b, $10 ; entry 15
    db $f8, $d9, $0c, $10 ; entry 16
    db $f8, $ca, $07, $10 ; entry 17
    db $f0, $bd, $04, $70 ; entry 18
    db $e9, $b4, $00, $10 ; entry 19
    db $d8, $bc, $04, $30 ; entry 20
    db $df, $b4, $00, $50 ; entry 21
    db $e8, $00, $0d, $30 ; entry 22
    db $e0, $00, $0d, $70 ; entry 23
    db $d0, $08, $10, $70 ; entry 24
    db $f0, $00, $0e, $30 ; entry 25
    db $f8, $00, $0e, $30 ; entry 26
    db $d8, $00, $0e, $70 ; entry 27
    db $d0, $00, $0e, $70 ; entry 28
    db $d0, $47, $06, $70 ; entry 29
    db $d8, $26, $0a, $70 ; entry 30
    db $d8, $11, $0b, $70 ; entry 31
    db $d0, $1f, $0c, $70 ; entry 32
    db $d0, $2e, $07, $70 ; entry 33
    db $f8, $08, $10, $30 ; entry 34
    db $f8, $47, $06, $30 ; entry 35
    db $f0, $26, $0a, $30 ; entry 36
    db $f0, $11, $0b, $30 ; entry 37
    db $f8, $1f, $0c, $30 ; entry 38
    db $f8, $2e, $07, $30 ; entry 39
    db $f0, $3b, $04, $50 ; entry 40
    db $e9, $44, $00, $30 ; entry 41
    db $d8, $3c, $04, $10 ; entry 42
    db $df, $44, $00, $70 ; entry 43
    db $e0, $dc, $00, $50 ; entry 44
    db $e8, $dc, $00, $10 ; entry 45
    db $e0, $1c, $00, $70 ; entry 46
    db $e8, $1c, $00, $30 ; entry 47
    db $e0, $10, $08, $70 ; entry 48
    db $e8, $10, $08, $30 ; entry 49
    db $e0, $e8, $08, $50 ; entry 50
    db $e8, $e8, $08, $10 ; entry 51
    db $e8, $f0, $0f, $10 ; entry 52
    db $e8, $08, $0f, $10 ; entry 53
    db $e0, $08, $0f, $50 ; entry 54
    db $e0, $f0, $0f, $50 ; entry 55
    db $80 ; end

; frame 14 of MetaSprites3DSet27; ends with $80 (E-0147)
MetaSprites3DSet27Frame14::
    db $80 ; end

; meta-sprite set 40 of MetaSprites3DTable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3DSet28::
    dw MetaSprites3DSet28Frame0 ; entry 0
    dw MetaSprites3DSet28Frame1 ; entry 1
    dw MetaSprites3DSet28Frame2 ; entry 2
    dw MetaSprites3DSet28Frame3 ; entry 3
    dw MetaSprites3DSet28Frame4 ; entry 4
    dw MetaSprites3DSet28Frame5 ; entry 5
    dw MetaSprites3DSet28Frame6 ; entry 6
    dw MetaSprites3DSet28Frame6 ; entry 7
    dw MetaSprites3DSet28Frame6 ; entry 8
    dw MetaSprites3DSet28Frame6 ; entry 9
    dw MetaSprites3DSet28Frame6 ; entry 10
    dw MetaSprites3DSet28Frame6 ; entry 11
    dw MetaSprites3DSet28Frame6 ; entry 12
    dw MetaSprites3DSet28Frame6 ; entry 13
    dw MetaSprites3DSet28Frame6 ; entry 14
    dw MetaSprites3DSet28Frame6 ; entry 15
    dw MetaSprites3DSet28Frame6 ; entry 16
    dw MetaSprites3DSet28Frame6 ; entry 17
    dw MetaSprites3DSet28Frame6 ; entry 18
    dw MetaSprites3DSet28Frame6 ; entry 19
    dw MetaSprites3DSet28Frame6 ; entry 20
    dw MetaSprites3DSet28Frame6 ; entry 21
    dw MetaSprites3DSet28Frame6 ; entry 22
    dw MetaSprites3DSet28Frame6 ; entry 23
    dw MetaSprites3DSet28Frame6 ; entry 24
    dw MetaSprites3DSet28Frame6 ; entry 25
    dw MetaSprites3DSet28Frame6 ; entry 26
    dw MetaSprites3DSet28Frame6 ; entry 27
    dw MetaSprites3DSet28Frame6 ; entry 28
    dw MetaSprites3DSet28Frame6 ; entry 29
    dw MetaSprites3DSet28Frame6 ; entry 30
    dw MetaSprites3DSet28Frame6 ; entry 31

; frame 0 of MetaSprites3DSet28; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet28Frame0::
    db $e4, $02, $0f, $10 ; entry 0
    db $ec, $02, $1f, $10 ; entry 1
    db $f8, $f2, $2f, $10 ; entry 2
    db $f8, $ff, $21, $10 ; entry 3
    db $f8, $f7, $26, $10 ; entry 4
    db $f0, $ff, $29, $50 ; entry 5
    db $e5, $ef, $19, $10 ; entry 6
    db $e9, $f4, $2a, $70 ; entry 7
    db $f0, $f7, $20, $10 ; entry 8
    db $e9, $fc, $29, $50 ; entry 9
    db $e3, $fb, $17, $10 ; entry 10
    db $80 ; end

; frame 1 of MetaSprites3DSet28; ends with $80 (E-0147)
MetaSprites3DSet28Frame1::
    db $d5, $0d, $04, $10 ; entry 0
    db $d0, $05, $14, $10 ; entry 1
    db $da, $05, $12, $10 ; entry 2
    db $e8, $ee, $18, $30 ; entry 3
    db $f8, $fe, $1a, $50 ; entry 4
    db $f8, $06, $1a, $30 ; entry 5
    db $d0, $fa, $19, $30 ; entry 6
    db $e8, $fe, $21, $10 ; entry 7
    db $d8, $f2, $21, $30 ; entry 8
    db $f0, $06, $20, $70 ; entry 9
    db $e0, $f0, $20, $10 ; entry 10
    db $e0, $f8, $20, $70 ; entry 11
    db $e0, $fd, $18, $10 ; entry 12
    db $e8, $f6, $20, $10 ; entry 13
    db $f0, $fc, $21, $70 ; entry 14
    db $f0, $fe, $00, $10 ; entry 15
    db $f0, $ee, $1f, $10 ; entry 16
    db $f8, $ec, $0f, $70 ; entry 17
    db $d0, $f2, $29, $70 ; entry 18
    db $f8, $f3, $12, $50 ; entry 19
    db $80 ; end

; frame 2 of MetaSprites3DSet28; ends with $80 (E-0147)
MetaSprites3DSet28Frame2::
    db $e2, $f3, $17, $10 ; entry 0
    db $f8, $00, $03, $50 ; entry 1
    db $d0, $04, $0f, $10 ; entry 2
    db $d0, $fc, $1c, $10 ; entry 3
    db $d8, $f8, $19, $10 ; entry 4
    db $f8, $f0, $2f, $10 ; entry 5
    db $f8, $08, $20, $30 ; entry 6
    db $d8, $04, $1f, $10 ; entry 7
    db $e1, $00, $20, $10 ; entry 8
    db $f0, $ef, $0f, $70 ; entry 9
    db $e8, $ef, $0f, $30 ; entry 10
    db $f2, $f7, $12, $50 ; entry 11
    db $f8, $f8, $26, $10 ; entry 12
    db $f0, $00, $25, $10 ; entry 13
    db $f0, $08, $24, $10 ; entry 14
    db $e8, $08, $23, $10 ; entry 15
    db $e0, $08, $22, $10 ; entry 16
    db $d0, $f3, $2a, $10 ; entry 17
    db $d9, $ff, $15, $70 ; entry 18
    db $80 ; end

; frame 3 of MetaSprites3DSet28; ends with $80 (E-0147)
MetaSprites3DSet28Frame3::
    db $e8, $f8, $00, $10 ; entry 0
    db $f8, $00, $00, $10 ; entry 1
    db $ec, $e8, $13, $10 ; entry 2
    db $de, $f2, $12, $30 ; entry 3
    db $d3, $f2, $14, $30 ; entry 4
    db $d8, $ea, $04, $30 ; entry 5
    db $e8, $f0, $05, $10 ; entry 6
    db $f0, $f0, $15, $10 ; entry 7
    db $f0, $f8, $16, $10 ; entry 8
    db $e5, $06, $1c, $10 ; entry 9
    db $e5, $0e, $0f, $10 ; entry 10
    db $ed, $0e, $1f, $10 ; entry 11
    db $f8, $f8, $1a, $10 ; entry 12
    db $f8, $f1, $2f, $10 ; entry 13
    db $d0, $f8, $2f, $50 ; entry 14
    db $e8, $fd, $1a, $70 ; entry 15
    db $d8, $01, $1a, $10 ; entry 16
    db $f0, $00, $20, $70 ; entry 17
    db $f0, $07, $2e, $10 ; entry 18
    db $f8, $07, $1a, $70 ; entry 19
    db $d8, $08, $28, $10 ; entry 20
    db $d0, $00, $2a, $10 ; entry 21
    db $e2, $02, $20, $30 ; entry 22
    db $e0, $00, $00, $10 ; entry 23
    db $e0, $f8, $2b, $10 ; entry 24
    db $e0, $08, $29, $10 ; entry 25
    db $80 ; end

; frame 4 of MetaSprites3DSet28; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet28Frame4::
    db $d8, $fc, $00, $10 ; entry 0
    db $e8, $fc, $00, $10 ; entry 1
    db $f0, $fc, $00, $10 ; entry 2
    db $f8, $f4, $00, $10 ; entry 3
    db $d0, $fc, $00, $10 ; entry 4
    db $f8, $fc, $06, $10 ; entry 5
    db $f8, $00, $0b, $10 ; entry 6
    db $f8, $08, $0c, $10 ; entry 7
    db $e0, $f4, $01, $10 ; entry 8
    db $e0, $fc, $02, $10 ; entry 9
    db $e8, $f4, $11, $10 ; entry 10
    db $f0, $ee, $12, $70 ; entry 11
    db $ed, $10, $04, $10 ; entry 12
    db $e8, $ed, $04, $30 ; entry 13
    db $f8, $e8, $14, $30 ; entry 14
    db $f0, $08, $17, $10 ; entry 15
    db $d0, $e8, $0f, $30 ; entry 16
    db $d8, $e8, $1f, $30 ; entry 17
    db $d0, $f0, $1c, $30 ; entry 18
    db $f0, $f4, $1a, $10 ; entry 19
    db $f8, $f0, $1a, $10 ; entry 20
    db $d0, $0a, $20, $30 ; entry 21
    db $f0, $04, $21, $10 ; entry 22
    db $d8, $f4, $21, $30 ; entry 23
    db $e0, $ee, $20, $50 ; entry 24
    db $d0, $03, $00, $10 ; entry 25
    db $d8, $04, $00, $10 ; entry 26
    db $d8, $06, $21, $10 ; entry 27
    db $e0, $04, $20, $30 ; entry 28
    db $d0, $f7, $20, $50 ; entry 29
    db $e8, $03, $2c, $30 ; entry 30
    db $e8, $08, $14, $10 ; entry 31
    db $d0, $13, $2d, $10 ; entry 32
    db $d0, $0b, $17, $10 ; entry 33
    db $80 ; end

; frame 5 of MetaSprites3DSet28; ends with $80 (E-0147)
MetaSprites3DSet28Frame5::
    db $e0, $ff, $00, $10 ; entry 0
    db $e0, $07, $00, $10 ; entry 1
    db $e8, $08, $00, $10 ; entry 2
    db $f8, $f8, $00, $10 ; entry 3
    db $e8, $f8, $07, $10 ; entry 4
    db $e8, $00, $08, $10 ; entry 5
    db $d8, $ff, $1d, $10 ; entry 6
    db $d8, $07, $1e, $10 ; entry 7
    db $d0, $00, $0d, $10 ; entry 8
    db $d0, $07, $0e, $10 ; entry 9
    db $e0, $f3, $1b, $10 ; entry 10
    db $f8, $00, $00, $10 ; entry 11
    db $f0, $00, $09, $10 ; entry 12
    db $f0, $08, $0a, $10 ; entry 13
    db $f8, $08, $10, $10 ; entry 14
    db $f7, $10, $18, $70 ; entry 15
    db $d8, $f7, $03, $30 ; entry 16
    db $e9, $eb, $0f, $30 ; entry 17
    db $f1, $eb, $1f, $30 ; entry 18
    db $e9, $f3, $1c, $30 ; entry 19
    db $e0, $fb, $1a, $50 ; entry 20
    db $d0, $f0, $20, $10 ; entry 21
    db $d0, $f8, $1d, $10 ; entry 22
    db $e8, $0f, $1a, $70 ; entry 23
    db $d8, $ef, $19, $10 ; entry 24
    db $f0, $f8, $20, $50 ; entry 25
    db $f0, $f1, $2e, $30 ; entry 26
    db $e0, $0f, $24, $10 ; entry 27
    db $da, $10, $2e, $10 ; entry 28
    db $f0, $10, $29, $10 ; entry 29
    db $f8, $f0, $2b, $50 ; entry 30
    db $80 ; end

; frame 6 of MetaSprites3DSet28; ends with $80 (E-0147)
MetaSprites3DSet28Frame6::
    db $80 ; end

; meta-sprite set 41 of MetaSprites3DTable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3DSet29::
    dw MetaSprites3DSet29Frame0 ; entry 0
    dw MetaSprites3DSet29Frame1 ; entry 1
    dw MetaSprites3DSet29Frame2 ; entry 2
    dw MetaSprites3DSet29Frame3 ; entry 3
    dw MetaSprites3DSet29Frame4 ; entry 4
    dw MetaSprites3DSet29Frame5 ; entry 5
    dw MetaSprites3DSet29Frame6 ; entry 6
    dw MetaSprites3DSet29Frame7 ; entry 7
    dw MetaSprites3DSet29Frame8 ; entry 8
    dw MetaSprites3DSet29Frame9 ; entry 9
    dw MetaSprites3DSet29Frame10 ; entry 10
    dw MetaSprites3DSet29Frame11 ; entry 11
    dw MetaSprites3DSet29Frame12 ; entry 12
    dw MetaSprites3DSet29Frame13 ; entry 13
    dw MetaSprites3DSet29Frame14 ; entry 14
    dw MetaSprites3DSet29Frame15 ; entry 15
    dw MetaSprites3DSet29Frame16 ; entry 16
    dw MetaSprites3DSet29Frame17 ; entry 17
    dw MetaSprites3DSet29Frame18 ; entry 18
    dw MetaSprites3DSet29Frame19 ; entry 19
    dw MetaSprites3DSet29Frame20 ; entry 20
    dw MetaSprites3DSet29Frame20 ; entry 21
    dw MetaSprites3DSet29Frame20 ; entry 22
    dw MetaSprites3DSet29Frame20 ; entry 23
    dw MetaSprites3DSet29Frame20 ; entry 24
    dw MetaSprites3DSet29Frame20 ; entry 25
    dw MetaSprites3DSet29Frame20 ; entry 26
    dw MetaSprites3DSet29Frame20 ; entry 27
    dw MetaSprites3DSet29Frame20 ; entry 28
    dw MetaSprites3DSet29Frame20 ; entry 29
    dw MetaSprites3DSet29Frame20 ; entry 30
    dw MetaSprites3DSet29Frame20 ; entry 31

; frame 0 of MetaSprites3DSet29; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet29Frame0::
    db $f8, $f8, $1b, $00 ; entry 0
    db $f8, $00, $1b, $20 ; entry 1
    db $80 ; end

; frame 1 of MetaSprites3DSet29; ends with $80 (E-0147)
MetaSprites3DSet29Frame1::
    db $f0, $f0, $1c, $00 ; entry 0
    db $f0, $f8, $1d, $00 ; entry 1
    db $f0, $08, $1c, $20 ; entry 2
    db $f0, $00, $1d, $20 ; entry 3
    db $f8, $f0, $1e, $00 ; entry 4
    db $f8, $f8, $1f, $00 ; entry 5
    db $f8, $08, $1e, $20 ; entry 6
    db $f8, $00, $1f, $20 ; entry 7
    db $80 ; end

; frame 2 of MetaSprites3DSet29; ends with $80 (E-0147)
MetaSprites3DSet29Frame2::
    db $e0, $e8, $20, $00 ; entry 0
    db $e0, $f0, $21, $00 ; entry 1
    db $e0, $f8, $22, $00 ; entry 2
    db $e8, $e0, $23, $00 ; entry 3
    db $e8, $e8, $24, $00 ; entry 4
    db $f0, $e0, $25, $00 ; entry 5
    db $f8, $e0, $26, $00 ; entry 6
    db $e8, $18, $23, $20 ; entry 7
    db $e8, $10, $24, $20 ; entry 8
    db $f0, $18, $25, $20 ; entry 9
    db $f8, $18, $26, $20 ; entry 10
    db $e0, $10, $20, $20 ; entry 11
    db $e0, $08, $21, $20 ; entry 12
    db $e0, $00, $22, $20 ; entry 13
    db $e8, $f0, $1f, $20 ; entry 14
    db $e8, $f8, $1f, $20 ; entry 15
    db $e8, $00, $1f, $20 ; entry 16
    db $e8, $08, $1f, $20 ; entry 17
    db $f0, $10, $1f, $20 ; entry 18
    db $f8, $10, $1f, $20 ; entry 19
    db $f8, $e8, $1f, $20 ; entry 20
    db $f0, $e8, $1f, $20 ; entry 21
    db $f0, $f0, $1f, $20 ; entry 22
    db $f8, $f0, $1f, $20 ; entry 23
    db $f8, $f8, $1f, $20 ; entry 24
    db $f0, $f8, $1f, $20 ; entry 25
    db $f0, $00, $1f, $20 ; entry 26
    db $f8, $00, $1f, $20 ; entry 27
    db $f8, $08, $1f, $20 ; entry 28
    db $f0, $08, $1f, $20 ; entry 29
    db $80 ; end

; frame 3 of MetaSprites3DSet29; ends with $80 (E-0147)
MetaSprites3DSet29Frame3::
    db $d6, $dc, $20, $00 ; entry 0
    db $e0, $d2, $23, $00 ; entry 1
    db $d5, $e8, $29, $00 ; entry 2
    db $d4, $f4, $2a, $00 ; entry 3
    db $ec, $d1, $2d, $00 ; entry 4
    db $f8, $d0, $2e, $00 ; entry 5
    db $f8, $ed, $27, $00 ; entry 6
    db $f8, $f8, $27, $00 ; entry 7
    db $f0, $f8, $27, $00 ; entry 8
    db $ef, $ee, $27, $00 ; entry 9
    db $f5, $da, $28, $00 ; entry 10
    db $f0, $e4, $28, $00 ; entry 11
    db $e7, $e5, $28, $00 ; entry 12
    db $e9, $db, $28, $00 ; entry 13
    db $df, $dc, $28, $00 ; entry 14
    db $de, $e6, $28, $00 ; entry 15
    db $dd, $f2, $28, $00 ; entry 16
    db $e6, $ee, $28, $00 ; entry 17
    db $dd, $fc, $28, $00 ; entry 18
    db $e6, $f7, $27, $00 ; entry 19
    db $d6, $1c, $20, $20 ; entry 20
    db $e0, $26, $23, $20 ; entry 21
    db $d5, $10, $29, $20 ; entry 22
    db $d4, $04, $2a, $20 ; entry 23
    db $ec, $27, $2d, $20 ; entry 24
    db $f8, $28, $2e, $20 ; entry 25
    db $f8, $0b, $27, $20 ; entry 26
    db $f8, $00, $27, $20 ; entry 27
    db $f0, $00, $27, $20 ; entry 28
    db $ef, $0a, $27, $20 ; entry 29
    db $f5, $1e, $28, $20 ; entry 30
    db $f0, $14, $28, $20 ; entry 31
    db $e7, $13, $28, $20 ; entry 32
    db $e9, $1d, $28, $20 ; entry 33
    db $df, $1c, $28, $20 ; entry 34
    db $de, $12, $28, $20 ; entry 35
    db $dd, $06, $28, $20 ; entry 36
    db $e6, $0a, $28, $20 ; entry 37
    db $e6, $01, $27, $20 ; entry 38
    db $80 ; end

; frame 4 of MetaSprites3DSet29; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet29Frame4::
    db $d8, $33, $23, $20 ; entry 0
    db $d8, $0c, $27, $20 ; entry 1
    db $d8, $ec, $27, $00 ; entry 2
    db $d8, $c5, $23, $00 ; entry 3
    db $e8, $be, $2b, $00 ; entry 4
    db $e8, $3a, $2b, $20 ; entry 5
    db $f0, $f0, $1c, $00 ; entry 6
    db $f0, $f8, $1d, $00 ; entry 7
    db $f0, $08, $1c, $20 ; entry 8
    db $f0, $00, $1d, $20 ; entry 9
    db $f8, $f0, $1e, $00 ; entry 10
    db $f8, $08, $1e, $20 ; entry 11
    db $f8, $f8, $1f, $00 ; entry 12
    db $f8, $00, $1f, $00 ; entry 13
    db $f8, $b8, $2d, $00 ; entry 14
    db $f8, $40, $2d, $20 ; entry 15
    db $e0, $c6, $28, $00 ; entry 16
    db $d8, $cd, $28, $00 ; entry 17
    db $f0, $bd, $28, $00 ; entry 18
    db $d8, $2b, $28, $20 ; entry 19
    db $e0, $32, $28, $20 ; entry 20
    db $f0, $3b, $28, $20 ; entry 21
    db $e8, $32, $28, $20 ; entry 22
    db $f8, $38, $28, $20 ; entry 23
    db $f8, $c0, $28, $00 ; entry 24
    db $e8, $c6, $28, $00 ; entry 25
    db $f0, $c5, $28, $00 ; entry 26
    db $f0, $33, $28, $20 ; entry 27
    db $e0, $ce, $28, $00 ; entry 28
    db $e0, $2a, $28, $20 ; entry 29
    db $d8, $23, $28, $20 ; entry 30
    db $d8, $d5, $28, $00 ; entry 31
    db $ec, $d6, $27, $00 ; entry 32
    db $ec, $22, $27, $20 ; entry 33
    db $e2, $e1, $27, $00 ; entry 34
    db $f8, $d0, $27, $00 ; entry 35
    db $e2, $17, $27, $20 ; entry 36
    db $f8, $28, $27, $20 ; entry 37
    db $80 ; end

; frame 5 of MetaSprites3DSet29; ends with $80 (E-0147)
MetaSprites3DSet29Frame5::
    db $e0, $e8, $20, $00 ; entry 0
    db $e8, $e0, $23, $00 ; entry 1
    db $e0, $10, $20, $20 ; entry 2
    db $e8, $18, $23, $20 ; entry 3
    db $e0, $f0, $29, $00 ; entry 4
    db $f8, $e0, $2e, $00 ; entry 5
    db $f0, $e0, $2d, $00 ; entry 6
    db $e8, $e8, $2c, $00 ; entry 7
    db $e0, $f8, $2a, $00 ; entry 8
    db $e0, $08, $29, $20 ; entry 9
    db $e0, $00, $2a, $20 ; entry 10
    db $e8, $10, $2c, $20 ; entry 11
    db $f0, $18, $2d, $20 ; entry 12
    db $f8, $18, $2e, $20 ; entry 13
    db $e8, $f0, $28, $60 ; entry 14
    db $f0, $08, $28, $40 ; entry 15
    db $e8, $08, $28, $40 ; entry 16
    db $ec, $24, $28, $20 ; entry 17
    db $f4, $34, $28, $20 ; entry 18
    db $e0, $20, $28, $20 ; entry 19
    db $d2, $14, $28, $20 ; entry 20
    db $e0, $d8, $28, $00 ; entry 21
    db $d2, $e4, $28, $00 ; entry 22
    db $d0, $f4, $28, $00 ; entry 23
    db $d0, $04, $28, $20 ; entry 24
    db $f8, $e8, $28, $20 ; entry 25
    db $f8, $10, $28, $00 ; entry 26
    db $f0, $f0, $28, $60 ; entry 27
    db $e8, $00, $28, $40 ; entry 28
    db $f8, $08, $28, $40 ; entry 29
    db $f8, $00, $28, $40 ; entry 30
    db $e8, $f8, $28, $60 ; entry 31
    db $f8, $f0, $28, $60 ; entry 32
    db $f8, $f8, $28, $60 ; entry 33
    db $ec, $d4, $28, $00 ; entry 34
    db $f4, $c4, $28, $00 ; entry 35
    db $f0, $00, $28, $40 ; entry 36
    db $f0, $f8, $28, $60 ; entry 37
    db $f0, $e8, $28, $60 ; entry 38
    db $f0, $10, $28, $00 ; entry 39
    db $80 ; end

; frame 6 of MetaSprites3DSet29; ends with $80 (E-0147)
MetaSprites3DSet29Frame6::
    db $d7, $dc, $20, $00 ; entry 0
    db $e0, $d1, $23, $00 ; entry 1
    db $e0, $27, $23, $20 ; entry 2
    db $d7, $1c, $20, $20 ; entry 3
    db $f8, $dc, $27, $00 ; entry 4
    db $ec, $dc, $27, $00 ; entry 5
    db $e0, $e8, $27, $00 ; entry 6
    db $e0, $f4, $27, $00 ; entry 7
    db $eb, $e7, $27, $00 ; entry 8
    db $ec, $1c, $27, $20 ; entry 9
    db $eb, $11, $27, $20 ; entry 10
    db $f8, $1c, $27, $20 ; entry 11
    db $e0, $10, $27, $20 ; entry 12
    db $e0, $04, $27, $20 ; entry 13
    db $f5, $f1, $28, $00 ; entry 14
    db $e0, $dc, $27, $00 ; entry 15
    db $e0, $1c, $27, $20 ; entry 16
    db $d6, $e8, $29, $00 ; entry 17
    db $d5, $f4, $2a, $00 ; entry 18
    db $d6, $10, $29, $20 ; entry 19
    db $d5, $04, $2a, $20 ; entry 20
    db $ec, $d0, $2d, $00 ; entry 21
    db $f8, $cf, $2e, $00 ; entry 22
    db $f8, $29, $2e, $20 ; entry 23
    db $ec, $28, $2d, $20 ; entry 24
    db $f5, $07, $28, $20 ; entry 25
    db $eb, $07, $28, $20 ; entry 26
    db $f5, $11, $28, $20 ; entry 27
    db $eb, $f1, $28, $00 ; entry 28
    db $f5, $e7, $28, $00 ; entry 29
    db $f0, $b8, $2d, $00 ; entry 30
    db $e0, $c1, $2b, $00 ; entry 31
    db $d0, $d4, $2c, $00 ; entry 32
    db $d0, $28, $2c, $20 ; entry 33
    db $e0, $37, $2b, $20 ; entry 34
    db $f0, $40, $2d, $20 ; entry 35
    db $f0, $c4, $28, $00 ; entry 36
    db $f0, $34, $28, $20 ; entry 37
    db $ea, $fc, $28, $00 ; entry 38
    db $f4, $fc, $28, $20 ; entry 39
    db $80 ; end

; frame 7 of MetaSprites3DSet29; ends with $80 (E-0147)
MetaSprites3DSet29Frame7::
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

; frame 8 of MetaSprites3DSet29; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet29Frame8::
    db $e0, $25, $0f, $00 ; entry 0
    db $e0, $2d, $10, $00 ; entry 1
    db $e8, $24, $0e, $60 ; entry 2
    db $e8, $1c, $0f, $60 ; entry 3
    db $e8, $14, $10, $60 ; entry 4
    db $e8, $2c, $0d, $60 ; entry 5
    db $f0, $1c, $0c, $60 ; entry 6
    db $e0, $1d, $0e, $00 ; entry 7
    db $e0, $15, $0d, $00 ; entry 8
    db $e5, $fa, $08, $20 ; entry 9
    db $ed, $02, $09, $20 ; entry 10
    db $ed, $fa, $0a, $20 ; entry 11
    db $d0, $0c, $07, $20 ; entry 12
    db $d0, $04, $08, $20 ; entry 13
    db $d8, $0c, $09, $20 ; entry 14
    db $d8, $04, $0a, $20 ; entry 15
    db $f0, $24, $09, $20 ; entry 16
    db $e5, $02, $07, $20 ; entry 17
    db $e8, $e6, $0f, $20 ; entry 18
    db $e8, $de, $10, $20 ; entry 19
    db $f0, $e7, $0e, $40 ; entry 20
    db $f0, $ef, $0f, $40 ; entry 21
    db $f0, $f7, $10, $40 ; entry 22
    db $f0, $df, $0d, $40 ; entry 23
    db $e8, $ee, $0e, $20 ; entry 24
    db $e8, $f6, $0d, $20 ; entry 25
    db $f8, $e7, $0b, $40 ; entry 26
    db $f8, $ef, $0c, $40 ; entry 27
    db $e0, $ee, $0b, $20 ; entry 28
    db $e0, $e6, $0c, $20 ; entry 29
    db $d0, $2c, $07, $20 ; entry 30
    db $d0, $24, $08, $20 ; entry 31
    db $d8, $2c, $09, $20 ; entry 32
    db $d8, $24, $0a, $20 ; entry 33
    db $d8, $1e, $0c, $20 ; entry 34
    db $80 ; end

; frame 9 of MetaSprites3DSet29; ends with $80 (E-0147)
MetaSprites3DSet29Frame9::
    db $d4, $2a, $01, $00 ; entry 0
    db $dc, $22, $02, $00 ; entry 1
    db $dc, $2a, $03, $00 ; entry 2
    db $d4, $22, $00, $00 ; entry 3
    db $e7, $11, $01, $20 ; entry 4
    db $ef, $11, $03, $20 ; entry 5
    db $ef, $21, $02, $20 ; entry 6
    db $e7, $19, $04, $00 ; entry 7
    db $ef, $19, $05, $00 ; entry 8
    db $e7, $21, $01, $00 ; entry 9
    db $db, $09, $00, $20 ; entry 10
    db $db, $01, $01, $20 ; entry 11
    db $e3, $09, $02, $20 ; entry 12
    db $e3, $01, $03, $20 ; entry 13
    db $f7, $27, $02, $00 ; entry 14
    db $f7, $2f, $03, $00 ; entry 15
    db $ef, $27, $00, $00 ; entry 16
    db $ef, $2f, $01, $00 ; entry 17
    db $f0, $fb, $00, $00 ; entry 18
    db $f0, $03, $01, $00 ; entry 19
    db $f8, $fb, $02, $00 ; entry 20
    db $f8, $03, $03, $00 ; entry 21
    db $e3, $3c, $07, $20 ; entry 22
    db $e3, $34, $08, $20 ; entry 23
    db $eb, $3c, $09, $20 ; entry 24
    db $eb, $34, $0a, $20 ; entry 25
    db $db, $19, $07, $20 ; entry 26
    db $db, $11, $08, $20 ; entry 27
    db $e3, $19, $09, $20 ; entry 28
    db $e3, $11, $0a, $20 ; entry 29
    db $80 ; end

; frame 10 of MetaSprites3DSet29; ends with $80 (E-0147)
MetaSprites3DSet29Frame10::
    db $ec, $34, $0e, $40 ; entry 0
    db $ec, $3c, $0f, $40 ; entry 1
    db $ec, $44, $10, $40 ; entry 2
    db $ec, $2c, $0d, $40 ; entry 3
    db $f4, $3c, $0c, $40 ; entry 4
    db $f4, $34, $09, $00 ; entry 5
    db $f4, $19, $07, $40 ; entry 6
    db $f4, $21, $08, $40 ; entry 7
    db $ec, $19, $09, $40 ; entry 8
    db $ec, $21, $0a, $40 ; entry 9
    db $f0, $04, $07, $00 ; entry 10
    db $f0, $0c, $08, $00 ; entry 11
    db $f8, $04, $09, $00 ; entry 12
    db $f8, $0c, $0a, $00 ; entry 13
    db $ec, $13, $11, $60 ; entry 14
    db $ec, $0b, $12, $60 ; entry 15
    db $d4, $04, $11, $00 ; entry 16
    db $d4, $0c, $12, $00 ; entry 17
    db $d4, $18, $14, $00 ; entry 18
    db $dc, $00, $15, $00 ; entry 19
    db $dc, $08, $16, $00 ; entry 20
    db $dc, $10, $17, $00 ; entry 21
    db $dc, $18, $18, $00 ; entry 22
    db $e4, $18, $15, $60 ; entry 23
    db $e4, $10, $16, $60 ; entry 24
    db $e4, $08, $17, $60 ; entry 25
    db $e4, $00, $18, $60 ; entry 26
    db $dc, $28, $07, $20 ; entry 27
    db $dc, $20, $08, $20 ; entry 28
    db $e4, $28, $09, $20 ; entry 29
    db $e4, $20, $0a, $20 ; entry 30
    db $e4, $3b, $0e, $20 ; entry 31
    db $e4, $33, $0f, $20 ; entry 32
    db $e4, $43, $0d, $20 ; entry 33
    db $dc, $3b, $0b, $20 ; entry 34
    db $dc, $33, $0c, $20 ; entry 35
    db $80 ; end

; frame 11 of MetaSprites3DSet29; ends with $80 (E-0147)
MetaSprites3DSet29Frame11::
    db $d8, $08, $02, $00 ; entry 0
    db $d8, $10, $03, $00 ; entry 1
    db $d0, $08, $00, $00 ; entry 2
    db $e3, $21, $01, $00 ; entry 3
    db $eb, $21, $03, $00 ; entry 4
    db $eb, $11, $02, $00 ; entry 5
    db $e3, $19, $04, $20 ; entry 6
    db $eb, $19, $05, $20 ; entry 7
    db $e3, $11, $01, $20 ; entry 8
    db $f3, $0b, $02, $20 ; entry 9
    db $f3, $03, $03, $20 ; entry 10
    db $eb, $03, $01, $20 ; entry 11
    db $f0, $26, $07, $20 ; entry 12
    db $f0, $1e, $08, $20 ; entry 13
    db $f8, $26, $09, $20 ; entry 14
    db $f8, $1e, $0a, $20 ; entry 15
    db $d3, $2d, $00, $00 ; entry 16
    db $d3, $35, $01, $00 ; entry 17
    db $db, $2d, $02, $00 ; entry 18
    db $db, $35, $03, $00 ; entry 19
    db $d7, $20, $07, $20 ; entry 20
    db $d7, $18, $08, $20 ; entry 21
    db $df, $20, $09, $20 ; entry 22
    db $df, $18, $0a, $20 ; entry 23
    db $ea, $29, $02, $00 ; entry 24
    db $e2, $31, $04, $00 ; entry 25
    db $e8, $39, $05, $00 ; entry 26
    db $e0, $39, $04, $00 ; entry 27
    db $eb, $0b, $0c, $00 ; entry 28
    db $d0, $10, $07, $20 ; entry 29
    db $e2, $29, $00, $00 ; entry 30
    db $e0, $41, $01, $00 ; entry 31
    db $ea, $31, $05, $00 ; entry 32
    db $e8, $41, $03, $00 ; entry 33
    db $80 ; end

; frame 12 of MetaSprites3DSet29; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet29Frame12::
    db $dc, $3c, $0e, $00 ; entry 0
    db $dc, $44, $0f, $00 ; entry 1
    db $dc, $34, $0d, $00 ; entry 2
    db $d4, $44, $0c, $00 ; entry 3
    db $e4, $43, $0e, $60 ; entry 4
    db $e4, $3b, $0f, $60 ; entry 5
    db $ec, $43, $0b, $60 ; entry 6
    db $ec, $3b, $0c, $60 ; entry 7
    db $d4, $3c, $0b, $00 ; entry 8
    db $e0, $2c, $11, $20 ; entry 9
    db $e0, $24, $12, $20 ; entry 10
    db $f8, $1d, $11, $40 ; entry 11
    db $f8, $25, $12, $40 ; entry 12
    db $f8, $31, $14, $40 ; entry 13
    db $f0, $19, $15, $40 ; entry 14
    db $f0, $21, $16, $40 ; entry 15
    db $f0, $29, $17, $40 ; entry 16
    db $f0, $31, $18, $40 ; entry 17
    db $e8, $31, $15, $20 ; entry 18
    db $e8, $29, $16, $20 ; entry 19
    db $e8, $21, $17, $20 ; entry 20
    db $e8, $19, $18, $20 ; entry 21
    db $d8, $20, $07, $40 ; entry 22
    db $d8, $28, $08, $40 ; entry 23
    db $d0, $20, $09, $40 ; entry 24
    db $d0, $28, $0a, $40 ; entry 25
    db $f0, $09, $07, $40 ; entry 26
    db $f0, $11, $08, $40 ; entry 27
    db $e8, $09, $09, $40 ; entry 28
    db $e8, $11, $0a, $40 ; entry 29
    db $f0, $43, $07, $20 ; entry 30
    db $f0, $3b, $08, $20 ; entry 31
    db $f8, $43, $09, $20 ; entry 32
    db $f8, $3b, $0a, $20 ; entry 33
    db $80 ; end

; frame 13 of MetaSprites3DSet29; ends with $80 (E-0147)
MetaSprites3DSet29Frame13::
    db $d0, $3f, $11, $20 ; entry 0
    db $d0, $37, $12, $20 ; entry 1
    db $e8, $30, $11, $40 ; entry 2
    db $e8, $38, $12, $40 ; entry 3
    db $e8, $44, $14, $40 ; entry 4
    db $e0, $2c, $15, $40 ; entry 5
    db $e0, $34, $16, $40 ; entry 6
    db $e0, $3c, $17, $40 ; entry 7
    db $e0, $44, $18, $40 ; entry 8
    db $d8, $44, $15, $20 ; entry 9
    db $d8, $3c, $16, $20 ; entry 10
    db $d8, $34, $17, $20 ; entry 11
    db $d8, $2c, $18, $20 ; entry 12
    db $e1, $20, $0e, $00 ; entry 13
    db $e1, $28, $0f, $00 ; entry 14
    db $e9, $27, $0e, $60 ; entry 15
    db $e9, $1f, $0f, $60 ; entry 16
    db $f1, $27, $0b, $60 ; entry 17
    db $f1, $1f, $0c, $60 ; entry 18
    db $d9, $20, $0b, $00 ; entry 19
    db $e0, $18, $0d, $00 ; entry 20
    db $e0, $14, $07, $20 ; entry 21
    db $e0, $0c, $08, $20 ; entry 22
    db $e8, $14, $09, $20 ; entry 23
    db $e8, $0c, $0a, $20 ; entry 24
    db $d0, $24, $07, $40 ; entry 25
    db $d0, $2c, $08, $40 ; entry 26
    db $f8, $26, $09, $40 ; entry 27
    db $f8, $2e, $0a, $40 ; entry 28
    db $d8, $08, $0e, $40 ; entry 29
    db $d8, $10, $0f, $40 ; entry 30
    db $d0, $0f, $0e, $20 ; entry 31
    db $d0, $07, $0f, $20 ; entry 32
    db $80 ; end

; frame 14 of MetaSprites3DSet29; ends with $80 (E-0147)
MetaSprites3DSet29Frame14::
    db $e0, $d4, $0f, $20 ; entry 0
    db $e0, $cc, $10, $20 ; entry 1
    db $e8, $d5, $0e, $40 ; entry 2
    db $e8, $dd, $0f, $40 ; entry 3
    db $e8, $e5, $10, $40 ; entry 4
    db $e8, $cd, $0d, $40 ; entry 5
    db $f0, $dd, $0c, $40 ; entry 6
    db $e0, $dc, $0e, $20 ; entry 7
    db $e0, $e4, $0d, $20 ; entry 8
    db $e5, $ff, $08, $00 ; entry 9
    db $ed, $f7, $09, $00 ; entry 10
    db $ed, $ff, $0a, $00 ; entry 11
    db $d0, $ed, $07, $00 ; entry 12
    db $d0, $f5, $08, $00 ; entry 13
    db $d8, $ed, $09, $00 ; entry 14
    db $d8, $f5, $0a, $00 ; entry 15
    db $f0, $d5, $09, $00 ; entry 16
    db $e5, $f7, $07, $00 ; entry 17
    db $e8, $13, $0f, $00 ; entry 18
    db $e8, $1b, $10, $00 ; entry 19
    db $f0, $12, $0e, $60 ; entry 20
    db $f0, $0a, $0f, $60 ; entry 21
    db $f0, $02, $10, $60 ; entry 22
    db $f0, $1a, $0d, $60 ; entry 23
    db $e8, $0b, $0e, $00 ; entry 24
    db $e8, $03, $0d, $00 ; entry 25
    db $f8, $12, $0b, $60 ; entry 26
    db $f8, $0a, $0c, $60 ; entry 27
    db $e0, $0b, $0b, $00 ; entry 28
    db $e0, $13, $0c, $00 ; entry 29
    db $d0, $cd, $07, $00 ; entry 30
    db $d0, $d5, $08, $00 ; entry 31
    db $d8, $cd, $09, $00 ; entry 32
    db $d8, $d5, $0a, $00 ; entry 33
    db $d8, $db, $0c, $00 ; entry 34
    db $80 ; end

; frame 15 of MetaSprites3DSet29; ends with $80 (E-0147)
MetaSprites3DSet29Frame15::
    db $d4, $ce, $01, $20 ; entry 0
    db $dc, $d6, $02, $20 ; entry 1
    db $dc, $ce, $03, $20 ; entry 2
    db $d4, $d6, $00, $20 ; entry 3
    db $e7, $e7, $01, $00 ; entry 4
    db $ef, $e7, $03, $00 ; entry 5
    db $ef, $d7, $02, $00 ; entry 6
    db $e7, $df, $04, $20 ; entry 7
    db $ef, $df, $05, $20 ; entry 8
    db $e7, $d7, $01, $20 ; entry 9
    db $db, $ef, $00, $00 ; entry 10
    db $db, $f7, $01, $00 ; entry 11
    db $e3, $ef, $02, $00 ; entry 12
    db $e3, $f7, $03, $00 ; entry 13
    db $f7, $d1, $02, $20 ; entry 14
    db $f7, $c9, $03, $20 ; entry 15
    db $ef, $d1, $00, $20 ; entry 16
    db $ef, $c9, $01, $20 ; entry 17
    db $f0, $fd, $00, $20 ; entry 18
    db $f0, $f5, $01, $20 ; entry 19
    db $f8, $fd, $02, $20 ; entry 20
    db $f8, $f5, $03, $20 ; entry 21
    db $e3, $bc, $07, $00 ; entry 22
    db $e3, $c4, $08, $00 ; entry 23
    db $eb, $bc, $09, $00 ; entry 24
    db $eb, $c4, $0a, $00 ; entry 25
    db $db, $df, $07, $00 ; entry 26
    db $db, $e7, $08, $00 ; entry 27
    db $e3, $df, $09, $00 ; entry 28
    db $e3, $e7, $0a, $00 ; entry 29
    db $80 ; end

; frame 16 of MetaSprites3DSet29; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet29Frame16::
    db $ec, $c6, $0e, $60 ; entry 0
    db $ec, $be, $0f, $60 ; entry 1
    db $ec, $b6, $10, $60 ; entry 2
    db $ec, $ce, $0d, $60 ; entry 3
    db $f4, $be, $0c, $60 ; entry 4
    db $f4, $c6, $09, $20 ; entry 5
    db $f4, $e1, $07, $60 ; entry 6
    db $f4, $d9, $08, $60 ; entry 7
    db $ec, $e1, $09, $60 ; entry 8
    db $ec, $d9, $0a, $60 ; entry 9
    db $f0, $f6, $07, $20 ; entry 10
    db $f0, $ee, $08, $20 ; entry 11
    db $f8, $f6, $09, $20 ; entry 12
    db $f8, $ee, $0a, $20 ; entry 13
    db $ec, $e7, $11, $40 ; entry 14
    db $ec, $ef, $12, $40 ; entry 15
    db $d4, $f6, $11, $20 ; entry 16
    db $d4, $ee, $12, $20 ; entry 17
    db $d4, $e2, $14, $20 ; entry 18
    db $dc, $fa, $15, $20 ; entry 19
    db $dc, $f2, $16, $20 ; entry 20
    db $dc, $ea, $17, $20 ; entry 21
    db $dc, $e2, $18, $20 ; entry 22
    db $e4, $e2, $15, $40 ; entry 23
    db $e4, $ea, $16, $40 ; entry 24
    db $e4, $f2, $17, $40 ; entry 25
    db $e4, $fa, $18, $40 ; entry 26
    db $dc, $d2, $07, $00 ; entry 27
    db $dc, $da, $08, $00 ; entry 28
    db $e4, $d2, $09, $00 ; entry 29
    db $e4, $da, $0a, $00 ; entry 30
    db $e4, $bf, $0e, $00 ; entry 31
    db $e4, $c7, $0f, $00 ; entry 32
    db $e4, $b7, $0d, $00 ; entry 33
    db $dc, $bf, $0b, $00 ; entry 34
    db $dc, $c7, $0c, $00 ; entry 35
    db $80 ; end

; frame 17 of MetaSprites3DSet29; ends with $80 (E-0147)
MetaSprites3DSet29Frame17::
    db $d8, $f0, $02, $20 ; entry 0
    db $d8, $e8, $03, $20 ; entry 1
    db $d0, $f0, $00, $20 ; entry 2
    db $e3, $d7, $01, $20 ; entry 3
    db $eb, $d7, $03, $20 ; entry 4
    db $eb, $e7, $02, $20 ; entry 5
    db $e3, $df, $04, $00 ; entry 6
    db $eb, $df, $05, $00 ; entry 7
    db $e3, $e7, $01, $00 ; entry 8
    db $f3, $ed, $02, $00 ; entry 9
    db $f3, $f5, $03, $00 ; entry 10
    db $eb, $f5, $01, $00 ; entry 11
    db $f0, $d2, $07, $00 ; entry 12
    db $f0, $da, $08, $00 ; entry 13
    db $f8, $d2, $09, $00 ; entry 14
    db $f8, $da, $0a, $00 ; entry 15
    db $d3, $cb, $00, $20 ; entry 16
    db $d3, $c3, $01, $20 ; entry 17
    db $db, $cb, $02, $20 ; entry 18
    db $db, $c3, $03, $20 ; entry 19
    db $d7, $d8, $07, $00 ; entry 20
    db $d7, $e0, $08, $00 ; entry 21
    db $df, $d8, $09, $00 ; entry 22
    db $df, $e0, $0a, $00 ; entry 23
    db $ea, $cf, $02, $20 ; entry 24
    db $e2, $c7, $04, $20 ; entry 25
    db $e8, $bf, $05, $20 ; entry 26
    db $e0, $bf, $04, $20 ; entry 27
    db $eb, $ed, $0c, $20 ; entry 28
    db $d0, $e8, $07, $00 ; entry 29
    db $e8, $b7, $03, $20 ; entry 30
    db $e0, $b7, $00, $00 ; entry 31
    db $ea, $c7, $05, $00 ; entry 32
    db $e2, $cf, $01, $00 ; entry 33
    db $80 ; end

; frame 18 of MetaSprites3DSet29; ends with $80 (E-0147)
MetaSprites3DSet29Frame18::
    db $dc, $bc, $0e, $20 ; entry 0
    db $dc, $b4, $0f, $20 ; entry 1
    db $dc, $c4, $0d, $20 ; entry 2
    db $d4, $b4, $0c, $20 ; entry 3
    db $e4, $b5, $0e, $40 ; entry 4
    db $e4, $bd, $0f, $40 ; entry 5
    db $ec, $b5, $0b, $40 ; entry 6
    db $ec, $bd, $0c, $40 ; entry 7
    db $d4, $bc, $0b, $20 ; entry 8
    db $e0, $cc, $11, $00 ; entry 9
    db $e0, $d4, $12, $00 ; entry 10
    db $f8, $db, $11, $60 ; entry 11
    db $f8, $d3, $12, $60 ; entry 12
    db $f8, $c7, $14, $60 ; entry 13
    db $f0, $df, $15, $60 ; entry 14
    db $f0, $d7, $16, $60 ; entry 15
    db $f0, $cf, $17, $60 ; entry 16
    db $f0, $c7, $18, $60 ; entry 17
    db $e8, $c7, $15, $00 ; entry 18
    db $e8, $cf, $16, $00 ; entry 19
    db $e8, $d7, $17, $00 ; entry 20
    db $e8, $df, $18, $00 ; entry 21
    db $d8, $d8, $07, $60 ; entry 22
    db $d8, $d0, $08, $60 ; entry 23
    db $d0, $d8, $09, $60 ; entry 24
    db $d0, $d0, $0a, $60 ; entry 25
    db $f0, $ef, $07, $60 ; entry 26
    db $f0, $e7, $08, $60 ; entry 27
    db $e8, $ef, $09, $60 ; entry 28
    db $e8, $e7, $0a, $60 ; entry 29
    db $f0, $b5, $07, $00 ; entry 30
    db $f0, $bd, $08, $00 ; entry 31
    db $f8, $b5, $09, $00 ; entry 32
    db $f8, $bd, $0a, $00 ; entry 33
    db $80 ; end

; frame 19 of MetaSprites3DSet29; ends with $80 (E-0147)
MetaSprites3DSet29Frame19::
    db $dc, $bc, $0e, $20 ; entry 0
    db $dc, $b4, $0f, $20 ; entry 1
    db $dc, $c4, $0d, $20 ; entry 2
    db $d4, $b4, $0c, $20 ; entry 3
    db $e4, $b5, $0e, $40 ; entry 4
    db $e4, $bd, $0f, $40 ; entry 5
    db $ec, $b5, $0b, $40 ; entry 6
    db $ec, $bd, $0c, $40 ; entry 7
    db $d4, $bc, $0b, $20 ; entry 8
    db $e0, $cc, $11, $00 ; entry 9
    db $e0, $d4, $12, $00 ; entry 10
    db $f8, $db, $11, $60 ; entry 11
    db $f8, $d3, $12, $60 ; entry 12
    db $f8, $c7, $14, $60 ; entry 13
    db $f0, $df, $15, $60 ; entry 14
    db $f0, $d7, $16, $60 ; entry 15
    db $f0, $cf, $17, $60 ; entry 16
    db $f0, $c7, $18, $60 ; entry 17
    db $e8, $c7, $15, $00 ; entry 18
    db $e8, $cf, $16, $00 ; entry 19
    db $e8, $d7, $17, $00 ; entry 20
    db $e8, $df, $18, $00 ; entry 21
    db $d8, $d8, $07, $60 ; entry 22
    db $d8, $d0, $08, $60 ; entry 23
    db $d0, $d8, $09, $60 ; entry 24
    db $d0, $d0, $0a, $60 ; entry 25
    db $f0, $ef, $07, $60 ; entry 26
    db $f0, $e7, $08, $60 ; entry 27
    db $e8, $ef, $09, $60 ; entry 28
    db $e8, $e7, $0a, $60 ; entry 29
    db $f0, $b5, $07, $00 ; entry 30
    db $f0, $bd, $08, $00 ; entry 31
    db $f8, $b5, $09, $00 ; entry 32
    db $f8, $bd, $0a, $00 ; entry 33
    db $80 ; end

; frame 20 of MetaSprites3DSet29; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet29Frame20::
    db $80 ; end

; meta-sprite set 42 of MetaSprites3DTable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3DSet2A::
    dw MetaSprites3DSet2AFrame0 ; entry 0
    dw MetaSprites3DSet2AFrame1 ; entry 1
    dw MetaSprites3DSet2AFrame2 ; entry 2
    dw MetaSprites3DSet2AFrame3 ; entry 3
    dw MetaSprites3DSet2AFrame4 ; entry 4
    dw MetaSprites3DSet2AFrame5 ; entry 5
    dw MetaSprites3DSet2AFrame6 ; entry 6
    dw MetaSprites3DSet2AFrame7 ; entry 7
    dw MetaSprites3DSet2AFrame8 ; entry 8
    dw MetaSprites3DSet2AFrame9 ; entry 9
    dw MetaSprites3DSet2AFrame10 ; entry 10
    dw MetaSprites3DSet2AFrame11 ; entry 11
    dw MetaSprites3DSet2AFrame12 ; entry 12
    dw MetaSprites3DSet2AFrame13 ; entry 13
    dw MetaSprites3DSet2AFrame14 ; entry 14
    dw MetaSprites3DSet2AFrame15 ; entry 15
    dw MetaSprites3DSet2AFrame16 ; entry 16
    dw MetaSprites3DSet2AFrame17 ; entry 17
    dw MetaSprites3DSet2AFrame18 ; entry 18
    dw MetaSprites3DSet2AFrame19 ; entry 19
    dw MetaSprites3DSet2AFrame20 ; entry 20
    dw MetaSprites3DSet2AFrame21 ; entry 21
    dw MetaSprites3DSet2AFrame22 ; entry 22
    dw MetaSprites3DSet2AFrame23 ; entry 23
    dw MetaSprites3DSet2AFrame24 ; entry 24
    dw MetaSprites3DSet2AFrame24 ; entry 25
    dw MetaSprites3DSet2AFrame24 ; entry 26
    dw MetaSprites3DSet2AFrame24 ; entry 27
    dw MetaSprites3DSet2AFrame24 ; entry 28
    dw MetaSprites3DSet2AFrame24 ; entry 29
    dw MetaSprites3DSet2AFrame24 ; entry 30
    dw MetaSprites3DSet2AFrame24 ; entry 31

; frame 0 of MetaSprites3DSet2A; ends with $80 (E-0147)
MetaSprites3DSet2AFrame0::
    db $f8, $c0, $00, $00 ; entry 0
    db $f0, $c0, $00, $00 ; entry 1
    db $e8, $c0, $00, $00 ; entry 2
    db $f8, $e0, $00, $00 ; entry 3
    db $f0, $e0, $00, $00 ; entry 4
    db $f8, $f0, $00, $00 ; entry 5
    db $f0, $f0, $00, $00 ; entry 6
    db $e8, $f0, $00, $00 ; entry 7
    db $e0, $f0, $00, $00 ; entry 8
    db $d8, $f0, $00, $00 ; entry 9
    db $f8, $00, $00, $00 ; entry 10
    db $f0, $00, $00, $00 ; entry 11
    db $e8, $00, $00, $00 ; entry 12
    db $f8, $20, $00, $00 ; entry 13
    db $f0, $20, $00, $00 ; entry 14
    db $e8, $20, $00, $00 ; entry 15
    db $e0, $20, $00, $00 ; entry 16
    db $d8, $20, $00, $00 ; entry 17
    db $f8, $30, $00, $00 ; entry 18
    db $f0, $30, $00, $00 ; entry 19
    db $e0, $00, $00, $00 ; entry 20
    db $d8, $00, $00, $00 ; entry 21
    db $d0, $00, $00, $00 ; entry 22
    db $80 ; end

; frame 1 of MetaSprites3DSet2A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet2AFrame1::
    db $e8, $c0, $01, $00 ; entry 0
    db $e0, $c0, $01, $00 ; entry 1
    db $d0, $c0, $01, $00 ; entry 2
    db $d8, $c0, $01, $00 ; entry 3
    db $f8, $e0, $01, $00 ; entry 4
    db $f0, $e0, $01, $00 ; entry 5
    db $e8, $e0, $01, $00 ; entry 6
    db $e0, $e0, $01, $00 ; entry 7
    db $d0, $e0, $01, $00 ; entry 8
    db $d8, $e0, $01, $00 ; entry 9
    db $f8, $f0, $01, $00 ; entry 10
    db $f0, $f0, $01, $00 ; entry 11
    db $e8, $f0, $01, $00 ; entry 12
    db $e0, $f0, $01, $00 ; entry 13
    db $d0, $f0, $01, $00 ; entry 14
    db $d8, $f0, $01, $00 ; entry 15
    db $f8, $00, $01, $00 ; entry 16
    db $f0, $00, $01, $00 ; entry 17
    db $e8, $00, $01, $00 ; entry 18
    db $e0, $00, $01, $00 ; entry 19
    db $d0, $00, $01, $00 ; entry 20
    db $d8, $00, $01, $00 ; entry 21
    db $f8, $20, $01, $00 ; entry 22
    db $f0, $20, $01, $00 ; entry 23
    db $e8, $20, $01, $00 ; entry 24
    db $e0, $20, $01, $00 ; entry 25
    db $d0, $20, $01, $00 ; entry 26
    db $d8, $20, $01, $00 ; entry 27
    db $f8, $30, $01, $00 ; entry 28
    db $f0, $30, $01, $00 ; entry 29
    db $e8, $30, $01, $00 ; entry 30
    db $e0, $30, $01, $00 ; entry 31
    db $d0, $30, $01, $00 ; entry 32
    db $d8, $30, $01, $00 ; entry 33
    db $f8, $c0, $01, $00 ; entry 34
    db $f0, $c0, $01, $00 ; entry 35
    db $80 ; end

; frame 2 of MetaSprites3DSet2A; ends with $80 (E-0147)
MetaSprites3DSet2AFrame2::
    db $f0, $c8, $02, $00 ; entry 0
    db $e8, $c8, $02, $00 ; entry 1
    db $e0, $c8, $02, $00 ; entry 2
    db $d8, $c8, $02, $00 ; entry 3
    db $d0, $c8, $02, $00 ; entry 4
    db $f8, $d8, $02, $00 ; entry 5
    db $f0, $d8, $02, $00 ; entry 6
    db $e8, $d8, $02, $00 ; entry 7
    db $e0, $d8, $02, $00 ; entry 8
    db $d8, $d8, $02, $00 ; entry 9
    db $d0, $d8, $02, $00 ; entry 10
    db $f8, $f8, $02, $00 ; entry 11
    db $f0, $f8, $02, $00 ; entry 12
    db $e8, $f8, $02, $00 ; entry 13
    db $e0, $f8, $02, $00 ; entry 14
    db $d8, $f8, $02, $00 ; entry 15
    db $d0, $f8, $02, $00 ; entry 16
    db $f8, $08, $02, $00 ; entry 17
    db $f0, $08, $02, $00 ; entry 18
    db $e8, $08, $02, $00 ; entry 19
    db $e0, $08, $02, $00 ; entry 20
    db $d8, $08, $02, $00 ; entry 21
    db $d0, $08, $02, $00 ; entry 22
    db $f8, $18, $02, $00 ; entry 23
    db $f0, $18, $02, $00 ; entry 24
    db $e8, $18, $02, $00 ; entry 25
    db $e0, $18, $02, $00 ; entry 26
    db $d8, $18, $02, $00 ; entry 27
    db $d0, $18, $02, $00 ; entry 28
    db $f8, $38, $02, $00 ; entry 29
    db $f0, $38, $02, $00 ; entry 30
    db $e8, $38, $02, $00 ; entry 31
    db $e0, $38, $02, $00 ; entry 32
    db $d8, $38, $02, $00 ; entry 33
    db $d0, $38, $02, $00 ; entry 34
    db $f8, $c8, $02, $00 ; entry 35
    db $80 ; end

; frame 3 of MetaSprites3DSet2A; ends with $80 (E-0147)
MetaSprites3DSet2AFrame3::
    db $f8, $bc, $02, $00 ; entry 0
    db $f0, $bc, $02, $00 ; entry 1
    db $e8, $bc, $02, $00 ; entry 2
    db $e0, $bc, $02, $00 ; entry 3
    db $d8, $bc, $02, $00 ; entry 4
    db $d0, $bc, $02, $00 ; entry 5
    db $f8, $da, $02, $00 ; entry 6
    db $f0, $da, $02, $00 ; entry 7
    db $e8, $da, $02, $00 ; entry 8
    db $e0, $da, $02, $00 ; entry 9
    db $d8, $da, $02, $00 ; entry 10
    db $d0, $da, $02, $00 ; entry 11
    db $f8, $f0, $02, $00 ; entry 12
    db $f0, $f0, $02, $00 ; entry 13
    db $e8, $f0, $02, $00 ; entry 14
    db $e0, $f0, $02, $00 ; entry 15
    db $d8, $f0, $02, $00 ; entry 16
    db $d0, $f0, $02, $00 ; entry 17
    db $f8, $fc, $02, $00 ; entry 18
    db $f0, $fc, $02, $00 ; entry 19
    db $e8, $fc, $02, $00 ; entry 20
    db $e0, $fc, $02, $00 ; entry 21
    db $d8, $fc, $02, $00 ; entry 22
    db $d0, $fc, $02, $00 ; entry 23
    db $f8, $20, $02, $00 ; entry 24
    db $f0, $20, $02, $00 ; entry 25
    db $e8, $20, $02, $00 ; entry 26
    db $e0, $20, $02, $00 ; entry 27
    db $d8, $20, $02, $00 ; entry 28
    db $d0, $20, $02, $00 ; entry 29
    db $f8, $40, $02, $00 ; entry 30
    db $f0, $40, $02, $00 ; entry 31
    db $e8, $40, $02, $00 ; entry 32
    db $e0, $40, $02, $00 ; entry 33
    db $d8, $40, $02, $00 ; entry 34
    db $d0, $40, $02, $00 ; entry 35
    db $80 ; end

; frame 4 of MetaSprites3DSet2A; ends with $80 (E-0147)
MetaSprites3DSet2AFrame4::
    db $f8, $26, $03, $00 ; entry 0
    db $f0, $26, $03, $00 ; entry 1
    db $e8, $26, $03, $00 ; entry 2
    db $e0, $26, $03, $00 ; entry 3
    db $d8, $26, $03, $00 ; entry 4
    db $d0, $26, $03, $00 ; entry 5
    db $f8, $f8, $03, $00 ; entry 6
    db $f0, $f8, $03, $00 ; entry 7
    db $e8, $f8, $03, $00 ; entry 8
    db $e0, $f8, $03, $00 ; entry 9
    db $d8, $f8, $03, $00 ; entry 10
    db $d0, $f8, $03, $00 ; entry 11
    db $f8, $b8, $03, $00 ; entry 12
    db $f0, $b8, $03, $00 ; entry 13
    db $e8, $b8, $03, $00 ; entry 14
    db $e0, $b8, $03, $00 ; entry 15
    db $d8, $b8, $03, $00 ; entry 16
    db $d0, $b8, $03, $00 ; entry 17
    db $f8, $c0, $03, $20 ; entry 18
    db $f0, $c0, $03, $20 ; entry 19
    db $e8, $c0, $03, $20 ; entry 20
    db $e0, $c0, $03, $20 ; entry 21
    db $d8, $c0, $03, $20 ; entry 22
    db $d0, $c0, $03, $20 ; entry 23
    db $f8, $00, $03, $20 ; entry 24
    db $f0, $00, $03, $20 ; entry 25
    db $e8, $00, $03, $20 ; entry 26
    db $e0, $00, $03, $20 ; entry 27
    db $d8, $00, $03, $20 ; entry 28
    db $d0, $00, $03, $20 ; entry 29
    db $f8, $2e, $03, $20 ; entry 30
    db $f0, $2e, $03, $20 ; entry 31
    db $e8, $2e, $03, $20 ; entry 32
    db $e0, $2e, $03, $20 ; entry 33
    db $d8, $2e, $03, $20 ; entry 34
    db $d0, $2e, $03, $20 ; entry 35
    db $80 ; end

; frame 5 of MetaSprites3DSet2A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet2AFrame5::
    db $f8, $d0, $03, $00 ; entry 0
    db $f0, $d0, $03, $00 ; entry 1
    db $e8, $d0, $03, $00 ; entry 2
    db $e0, $d0, $03, $00 ; entry 3
    db $d8, $d0, $03, $00 ; entry 4
    db $d0, $d0, $03, $00 ; entry 5
    db $f8, $d8, $03, $20 ; entry 6
    db $f0, $d8, $03, $20 ; entry 7
    db $e8, $d8, $03, $20 ; entry 8
    db $e0, $d8, $03, $20 ; entry 9
    db $d8, $d8, $03, $20 ; entry 10
    db $d0, $d8, $03, $20 ; entry 11
    db $f8, $3c, $03, $00 ; entry 12
    db $f0, $3c, $03, $00 ; entry 13
    db $e8, $3c, $03, $00 ; entry 14
    db $e0, $3c, $03, $00 ; entry 15
    db $d8, $3c, $03, $00 ; entry 16
    db $d0, $3c, $03, $00 ; entry 17
    db $f8, $44, $03, $20 ; entry 18
    db $f0, $44, $03, $20 ; entry 19
    db $e8, $44, $03, $20 ; entry 20
    db $e0, $44, $03, $20 ; entry 21
    db $d8, $44, $03, $20 ; entry 22
    db $d0, $44, $03, $20 ; entry 23
    db $f8, $10, $03, $00 ; entry 24
    db $f0, $10, $03, $00 ; entry 25
    db $e8, $10, $03, $00 ; entry 26
    db $e0, $10, $03, $00 ; entry 27
    db $d8, $10, $03, $00 ; entry 28
    db $d0, $10, $03, $00 ; entry 29
    db $f8, $18, $03, $20 ; entry 30
    db $f0, $18, $03, $20 ; entry 31
    db $e8, $18, $03, $20 ; entry 32
    db $e0, $18, $03, $20 ; entry 33
    db $d8, $18, $03, $20 ; entry 34
    db $d0, $18, $03, $20 ; entry 35
    db $80 ; end

; frame 6 of MetaSprites3DSet2A; ends with $80 (E-0147)
MetaSprites3DSet2AFrame6::
    db $f8, $3c, $03, $20 ; entry 0
    db $f0, $3c, $03, $20 ; entry 1
    db $e8, $3c, $03, $20 ; entry 2
    db $e0, $3c, $03, $20 ; entry 3
    db $d8, $3c, $03, $20 ; entry 4
    db $d0, $3c, $03, $20 ; entry 5
    db $f8, $2c, $03, $00 ; entry 6
    db $f0, $2c, $03, $00 ; entry 7
    db $e8, $2c, $03, $00 ; entry 8
    db $e0, $2c, $03, $00 ; entry 9
    db $d8, $2c, $03, $00 ; entry 10
    db $d0, $2c, $03, $00 ; entry 11
    db $f8, $34, $04, $00 ; entry 12
    db $f0, $34, $04, $00 ; entry 13
    db $e8, $34, $04, $00 ; entry 14
    db $e0, $34, $04, $00 ; entry 15
    db $d8, $34, $04, $00 ; entry 16
    db $d0, $34, $04, $00 ; entry 17
    db $f8, $d0, $03, $20 ; entry 18
    db $f0, $d0, $03, $20 ; entry 19
    db $e8, $d0, $03, $20 ; entry 20
    db $e0, $d0, $03, $20 ; entry 21
    db $d8, $d0, $03, $20 ; entry 22
    db $d0, $d0, $03, $20 ; entry 23
    db $f8, $c0, $03, $00 ; entry 24
    db $f0, $c0, $03, $00 ; entry 25
    db $e8, $c0, $03, $00 ; entry 26
    db $e0, $c0, $03, $00 ; entry 27
    db $d8, $c0, $03, $00 ; entry 28
    db $d0, $c0, $03, $00 ; entry 29
    db $f8, $c8, $04, $00 ; entry 30
    db $f0, $c8, $04, $00 ; entry 31
    db $e8, $c8, $04, $00 ; entry 32
    db $e0, $c8, $04, $00 ; entry 33
    db $d8, $c8, $04, $00 ; entry 34
    db $d0, $c8, $04, $00 ; entry 35
    db $80 ; end

; frame 7 of MetaSprites3DSet2A; ends with $80 (E-0147)
MetaSprites3DSet2AFrame7::
    db $f8, $20, $03, $20 ; entry 0
    db $f0, $20, $03, $20 ; entry 1
    db $e8, $20, $03, $20 ; entry 2
    db $e0, $20, $03, $20 ; entry 3
    db $d8, $20, $03, $20 ; entry 4
    db $d0, $20, $03, $20 ; entry 5
    db $f8, $10, $03, $00 ; entry 6
    db $f0, $10, $03, $00 ; entry 7
    db $e8, $10, $03, $00 ; entry 8
    db $e0, $10, $03, $00 ; entry 9
    db $d8, $10, $03, $00 ; entry 10
    db $d0, $10, $03, $00 ; entry 11
    db $f8, $18, $04, $00 ; entry 12
    db $f0, $18, $04, $00 ; entry 13
    db $e8, $18, $04, $00 ; entry 14
    db $e0, $18, $04, $00 ; entry 15
    db $d8, $18, $04, $00 ; entry 16
    db $d0, $18, $04, $00 ; entry 17
    db $f8, $f0, $03, $20 ; entry 18
    db $f0, $f0, $03, $20 ; entry 19
    db $e8, $f0, $03, $20 ; entry 20
    db $e0, $f0, $03, $20 ; entry 21
    db $d8, $f0, $03, $20 ; entry 22
    db $d0, $f0, $03, $20 ; entry 23
    db $f8, $e0, $03, $00 ; entry 24
    db $f0, $e0, $03, $00 ; entry 25
    db $e8, $e0, $03, $00 ; entry 26
    db $e0, $e0, $03, $00 ; entry 27
    db $d8, $e0, $03, $00 ; entry 28
    db $d0, $e0, $03, $00 ; entry 29
    db $f8, $e8, $04, $00 ; entry 30
    db $f0, $e8, $04, $00 ; entry 31
    db $e8, $e8, $04, $00 ; entry 32
    db $e0, $e8, $04, $00 ; entry 33
    db $d8, $e8, $04, $00 ; entry 34
    db $d0, $e8, $04, $00 ; entry 35
    db $80 ; end

; frame 8 of MetaSprites3DSet2A; ends with $80 (E-0147)
MetaSprites3DSet2AFrame8::
    db $f8, $e8, $03, $00 ; entry 0
    db $f0, $e8, $03, $00 ; entry 1
    db $e8, $e8, $03, $00 ; entry 2
    db $e0, $e8, $03, $00 ; entry 3
    db $d8, $e8, $03, $00 ; entry 4
    db $d0, $e8, $03, $00 ; entry 5
    db $f8, $f0, $04, $00 ; entry 6
    db $f0, $f0, $04, $00 ; entry 7
    db $e8, $f0, $04, $00 ; entry 8
    db $e0, $f0, $04, $00 ; entry 9
    db $d8, $f0, $04, $00 ; entry 10
    db $d0, $f0, $04, $00 ; entry 11
    db $f8, $10, $03, $20 ; entry 12
    db $f0, $10, $03, $20 ; entry 13
    db $e8, $10, $03, $20 ; entry 14
    db $e0, $10, $03, $20 ; entry 15
    db $d8, $10, $03, $20 ; entry 16
    db $d0, $10, $03, $20 ; entry 17
    db $f8, $08, $04, $00 ; entry 18
    db $f0, $08, $04, $00 ; entry 19
    db $e8, $08, $04, $00 ; entry 20
    db $e0, $08, $04, $00 ; entry 21
    db $d8, $08, $04, $00 ; entry 22
    db $d0, $08, $04, $00 ; entry 23
    db $f8, $00, $04, $00 ; entry 24
    db $f0, $00, $04, $00 ; entry 25
    db $e8, $00, $04, $00 ; entry 26
    db $e0, $00, $04, $00 ; entry 27
    db $d8, $00, $04, $00 ; entry 28
    db $d0, $00, $04, $00 ; entry 29
    db $f8, $f8, $04, $00 ; entry 30
    db $f0, $f8, $04, $00 ; entry 31
    db $e8, $f8, $04, $00 ; entry 32
    db $e0, $f8, $04, $00 ; entry 33
    db $d8, $f8, $04, $00 ; entry 34
    db $d0, $f8, $04, $00 ; entry 35
    db $80 ; end

; frame 9 of MetaSprites3DSet2A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet2AFrame9::
    db $d8, $18, $07, $00 ; entry 0
    db $e4, $f8, $12, $00 ; entry 1
    db $e4, $00, $13, $00 ; entry 2
    db $f8, $40, $0c, $00 ; entry 3
    db $f8, $48, $0d, $00 ; entry 4
    db $f0, $30, $05, $00 ; entry 5
    db $f8, $e8, $05, $00 ; entry 6
    db $f0, $10, $07, $00 ; entry 7
    db $80 ; end

; frame 10 of MetaSprites3DSet2A; ends with $80 (E-0147)
MetaSprites3DSet2AFrame10::
    db $d0, $fc, $10, $40 ; entry 0
    db $f8, $08, $1f, $20 ; entry 1
    db $f8, $00, $20, $20 ; entry 2
    db $f8, $f8, $21, $20 ; entry 3
    db $f0, $f8, $05, $40 ; entry 4
    db $e8, $40, $0c, $00 ; entry 5
    db $e8, $48, $0d, $00 ; entry 6
    db $f0, $40, $0e, $00 ; entry 7
    db $f0, $48, $0f, $00 ; entry 8
    db $e0, $30, $05, $40 ; entry 9
    db $f0, $28, $05, $00 ; entry 10
    db $f4, $1c, $12, $20 ; entry 11
    db $f4, $14, $13, $20 ; entry 12
    db $e8, $e8, $05, $40 ; entry 13
    db $f0, $b0, $06, $00 ; entry 14
    db $d8, $10, $06, $40 ; entry 15
    db $80 ; end

; frame 11 of MetaSprites3DSet2A; ends with $80 (E-0147)
MetaSprites3DSet2AFrame11::
    db $e8, $f8, $1f, $00 ; entry 0
    db $e8, $00, $20, $00 ; entry 1
    db $e8, $08, $21, $00 ; entry 2
    db $f0, $f8, $22, $00 ; entry 3
    db $f0, $00, $23, $00 ; entry 4
    db $f0, $08, $24, $00 ; entry 5
    db $f8, $f8, $25, $00 ; entry 6
    db $f8, $00, $26, $00 ; entry 7
    db $f8, $08, $27, $00 ; entry 8
    db $e0, $c0, $1b, $00 ; entry 9
    db $e0, $c8, $1c, $00 ; entry 10
    db $e0, $d0, $1d, $00 ; entry 11
    db $e0, $d8, $1e, $00 ; entry 12
    db $d8, $c0, $17, $00 ; entry 13
    db $d8, $c8, $18, $00 ; entry 14
    db $d8, $d0, $19, $00 ; entry 15
    db $d8, $d8, $1a, $00 ; entry 16
    db $d0, $c1, $14, $00 ; entry 17
    db $d0, $c9, $15, $00 ; entry 18
    db $d0, $d1, $16, $00 ; entry 19
    db $d8, $40, $08, $00 ; entry 20
    db $d8, $48, $09, $00 ; entry 21
    db $e0, $40, $0a, $00 ; entry 22
    db $e0, $48, $0b, $00 ; entry 23
    db $f0, $28, $07, $00 ; entry 24
    db $e0, $b0, $06, $00 ; entry 25
    db $e0, $f8, $05, $20 ; entry 26
    db $f0, $d8, $06, $20 ; entry 27
    db $d0, $30, $05, $00 ; entry 28
    db $f8, $c8, $07, $20 ; entry 29
    db $e8, $18, $11, $00 ; entry 30
    db $e0, $18, $10, $00 ; entry 31
    db $f8, $b8, $11, $00 ; entry 32
    db $f0, $b8, $10, $00 ; entry 33
    db $f0, $30, $0c, $00 ; entry 34
    db $f0, $38, $0d, $00 ; entry 35
    db $f8, $30, $0e, $00 ; entry 36
    db $f8, $38, $0f, $00 ; entry 37
    db $d8, $e8, $05, $00 ; entry 38
    db $e0, $28, $05, $40 ; entry 39
    db $80 ; end

; frame 12 of MetaSprites3DSet2A; ends with $80 (E-0147)
MetaSprites3DSet2AFrame12::
    db $d8, $f8, $1f, $00 ; entry 0
    db $d8, $00, $20, $00 ; entry 1
    db $d8, $08, $21, $00 ; entry 2
    db $e0, $f8, $22, $00 ; entry 3
    db $e0, $00, $23, $00 ; entry 4
    db $e0, $08, $24, $00 ; entry 5
    db $e8, $f8, $25, $00 ; entry 6
    db $e8, $00, $26, $00 ; entry 7
    db $e8, $08, $27, $00 ; entry 8
    db $d0, $d8, $1b, $20 ; entry 9
    db $d0, $d0, $1c, $20 ; entry 10
    db $d0, $c8, $1d, $20 ; entry 11
    db $d0, $c0, $1e, $20 ; entry 12
    db $d0, $48, $0a, $20 ; entry 13
    db $d0, $40, $0b, $20 ; entry 14
    db $e0, $28, $07, $20 ; entry 15
    db $d0, $b0, $06, $20 ; entry 16
    db $d0, $f8, $05, $20 ; entry 17
    db $e0, $d8, $06, $00 ; entry 18
    db $e8, $c8, $07, $00 ; entry 19
    db $d8, $14, $11, $20 ; entry 20
    db $d0, $14, $10, $20 ; entry 21
    db $e8, $b4, $11, $20 ; entry 22
    db $e0, $b4, $10, $20 ; entry 23
    db $e0, $38, $0c, $20 ; entry 24
    db $e0, $30, $0d, $20 ; entry 25
    db $e8, $38, $0e, $20 ; entry 26
    db $e8, $30, $0f, $20 ; entry 27
    db $d0, $28, $05, $20 ; entry 28
    db $f0, $fa, $28, $00 ; entry 29
    db $f0, $02, $29, $00 ; entry 30
    db $f8, $2f, $14, $00 ; entry 31
    db $f8, $37, $15, $00 ; entry 32
    db $f8, $3f, $16, $00 ; entry 33
    db $f0, $48, $05, $00 ; entry 34
    db $f8, $18, $07, $00 ; entry 35
    db $f0, $e8, $06, $00 ; entry 36
    db $f8, $d8, $05, $00 ; entry 37
    db $f8, $b8, $12, $00 ; entry 38
    db $f8, $c0, $13, $00 ; entry 39
    db $80 ; end

; frame 13 of MetaSprites3DSet2A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet2AFrame13::
    db $d0, $08, $22, $20 ; entry 0
    db $d0, $00, $23, $20 ; entry 1
    db $d0, $f8, $24, $20 ; entry 2
    db $d8, $08, $25, $20 ; entry 3
    db $d8, $00, $26, $20 ; entry 4
    db $d8, $f8, $27, $20 ; entry 5
    db $d0, $28, $07, $00 ; entry 6
    db $d0, $d8, $06, $40 ; entry 7
    db $d8, $c8, $07, $40 ; entry 8
    db $d0, $b4, $11, $60 ; entry 9
    db $d8, $b4, $10, $60 ; entry 10
    db $d8, $30, $0c, $40 ; entry 11
    db $d8, $38, $0d, $40 ; entry 12
    db $d0, $30, $0e, $40 ; entry 13
    db $d0, $38, $0f, $40 ; entry 14
    db $e0, $06, $28, $20 ; entry 15
    db $e0, $fe, $29, $20 ; entry 16
    db $e0, $48, $05, $40 ; entry 17
    db $e8, $18, $07, $40 ; entry 18
    db $e0, $e8, $06, $00 ; entry 19
    db $e8, $d8, $05, $40 ; entry 20
    db $f0, $bc, $11, $00 ; entry 21
    db $e8, $bc, $10, $00 ; entry 22
    db $e8, $2f, $14, $00 ; entry 23
    db $e8, $37, $15, $00 ; entry 24
    db $e8, $3f, $16, $00 ; entry 25
    db $f0, $2e, $17, $00 ; entry 26
    db $f0, $36, $18, $00 ; entry 27
    db $f0, $3e, $19, $00 ; entry 28
    db $f0, $46, $1a, $00 ; entry 29
    db $f8, $2e, $1b, $00 ; entry 30
    db $f8, $36, $1c, $00 ; entry 31
    db $f8, $3e, $1d, $00 ; entry 32
    db $f8, $46, $1e, $00 ; entry 33
    db $f0, $f8, $10, $00 ; entry 34
    db $f8, $f8, $11, $00 ; entry 35
    db $f0, $d0, $08, $00 ; entry 36
    db $f0, $d8, $09, $00 ; entry 37
    db $f8, $d0, $0a, $00 ; entry 38
    db $f8, $d8, $0b, $00 ; entry 39
    db $80 ; end

; frame 14 of MetaSprites3DSet2A; ends with $80 (E-0147)
MetaSprites3DSet2AFrame14::
    db $d0, $fa, $28, $00 ; entry 0
    db $d0, $02, $29, $00 ; entry 1
    db $d0, $48, $05, $60 ; entry 2
    db $d8, $18, $07, $00 ; entry 3
    db $d0, $e8, $06, $00 ; entry 4
    db $d8, $d8, $05, $00 ; entry 5
    db $e8, $45, $14, $60 ; entry 6
    db $e8, $3d, $15, $60 ; entry 7
    db $e8, $35, $16, $60 ; entry 8
    db $e0, $46, $17, $60 ; entry 9
    db $e0, $3e, $18, $60 ; entry 10
    db $e0, $36, $19, $60 ; entry 11
    db $e0, $2e, $1a, $60 ; entry 12
    db $d8, $46, $1b, $60 ; entry 13
    db $d8, $3e, $1c, $60 ; entry 14
    db $d8, $36, $1d, $60 ; entry 15
    db $d8, $2e, $1e, $60 ; entry 16
    db $e8, $d0, $08, $40 ; entry 17
    db $e8, $d8, $09, $40 ; entry 18
    db $e0, $d0, $0a, $40 ; entry 19
    db $e0, $d8, $0b, $40 ; entry 20
    db $e4, $f8, $12, $00 ; entry 21
    db $e4, $00, $13, $00 ; entry 22
    db $dc, $b8, $12, $40 ; entry 23
    db $dc, $c0, $13, $40 ; entry 24
    db $f0, $d7, $14, $20 ; entry 25
    db $f0, $cf, $15, $20 ; entry 26
    db $f0, $c7, $16, $20 ; entry 27
    db $f8, $d8, $17, $20 ; entry 28
    db $f8, $d0, $18, $20 ; entry 29
    db $f8, $c8, $19, $20 ; entry 30
    db $f8, $c0, $1a, $20 ; entry 31
    db $f8, $40, $0c, $00 ; entry 32
    db $f8, $48, $0d, $00 ; entry 33
    db $f0, $30, $05, $00 ; entry 34
    db $f8, $e8, $05, $00 ; entry 35
    db $f0, $10, $07, $00 ; entry 36
    db $80 ; end

; frame 15 of MetaSprites3DSet2A; ends with $80 (E-0147)
MetaSprites3DSet2AFrame15::
    db $d8, $2f, $14, $40 ; entry 0
    db $d8, $37, $15, $40 ; entry 1
    db $d8, $3f, $16, $40 ; entry 2
    db $d0, $2e, $17, $40 ; entry 3
    db $d0, $36, $18, $40 ; entry 4
    db $d0, $3e, $19, $40 ; entry 5
    db $d0, $46, $1a, $40 ; entry 6
    db $d8, $d0, $08, $40 ; entry 7
    db $d8, $d8, $09, $40 ; entry 8
    db $d0, $d0, $0a, $40 ; entry 9
    db $d0, $d8, $0b, $40 ; entry 10
    db $f0, $d7, $14, $60 ; entry 11
    db $f0, $cf, $15, $60 ; entry 12
    db $f0, $c7, $16, $60 ; entry 13
    db $e8, $d8, $17, $60 ; entry 14
    db $e8, $d0, $18, $60 ; entry 15
    db $e8, $c8, $19, $60 ; entry 16
    db $e8, $c0, $1a, $60 ; entry 17
    db $e0, $d8, $1b, $60 ; entry 18
    db $e0, $d0, $1c, $60 ; entry 19
    db $e0, $c8, $1d, $60 ; entry 20
    db $e0, $c0, $1e, $60 ; entry 21
    db $d0, $fc, $10, $40 ; entry 22
    db $f8, $08, $1f, $20 ; entry 23
    db $f8, $00, $20, $20 ; entry 24
    db $f8, $f8, $21, $20 ; entry 25
    db $f0, $f8, $05, $40 ; entry 26
    db $e8, $40, $0c, $00 ; entry 27
    db $e8, $48, $0d, $00 ; entry 28
    db $f0, $40, $0e, $00 ; entry 29
    db $f0, $48, $0f, $00 ; entry 30
    db $e0, $30, $05, $40 ; entry 31
    db $f0, $28, $05, $00 ; entry 32
    db $f4, $1c, $12, $20 ; entry 33
    db $f4, $14, $13, $20 ; entry 34
    db $e8, $e8, $05, $40 ; entry 35
    db $f0, $b0, $06, $00 ; entry 36
    db $d8, $10, $06, $40 ; entry 37
    db $80 ; end

; frame 16 of MetaSprites3DSet2A; ends with $80 (E-0147)
MetaSprites3DSet2AFrame16::
    db $f0, $38, $07, $00 ; entry 0
    db $e0, $08, $05, $20 ; entry 1
    db $f0, $e8, $06, $20 ; entry 2
    db $d0, $40, $05, $00 ; entry 3
    db $e8, $28, $11, $00 ; entry 4
    db $e0, $28, $10, $00 ; entry 5
    db $e0, $38, $05, $40 ; entry 6
    db $e8, $10, $1b, $60 ; entry 7
    db $e8, $08, $1c, $60 ; entry 8
    db $e8, $00, $1d, $60 ; entry 9
    db $e8, $f8, $1e, $60 ; entry 10
    db $f0, $10, $17, $60 ; entry 11
    db $f0, $08, $18, $60 ; entry 12
    db $f0, $00, $19, $60 ; entry 13
    db $f0, $f8, $1a, $60 ; entry 14
    db $f8, $0f, $14, $60 ; entry 15
    db $f8, $07, $15, $60 ; entry 16
    db $f8, $ff, $16, $60 ; entry 17
    db $e0, $b0, $06, $00 ; entry 18
    db $e0, $40, $0c, $40 ; entry 19
    db $e0, $48, $0d, $40 ; entry 20
    db $d8, $40, $0e, $40 ; entry 21
    db $d8, $48, $0f, $40 ; entry 22
    db $d8, $e8, $05, $00 ; entry 23
    db $e0, $c0, $1b, $00 ; entry 24
    db $e0, $c8, $1c, $00 ; entry 25
    db $e0, $d0, $1d, $00 ; entry 26
    db $e0, $d8, $1e, $00 ; entry 27
    db $d8, $c0, $17, $00 ; entry 28
    db $d8, $c8, $18, $00 ; entry 29
    db $d8, $d0, $19, $00 ; entry 30
    db $d8, $d8, $1a, $00 ; entry 31
    db $d0, $c1, $14, $00 ; entry 32
    db $d0, $c9, $15, $00 ; entry 33
    db $d0, $d1, $16, $00 ; entry 34
    db $f8, $20, $05, $00 ; entry 35
    db $f0, $c0, $08, $00 ; entry 36
    db $f0, $c8, $09, $00 ; entry 37
    db $f8, $c0, $0a, $00 ; entry 38
    db $f8, $c8, $0b, $00 ; entry 39
    db $80 ; end

; frame 17 of MetaSprites3DSet2A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet2AFrame17::
    db $e0, $38, $07, $20 ; entry 0
    db $d0, $08, $05, $00 ; entry 1
    db $e0, $e8, $06, $00 ; entry 2
    db $d8, $28, $11, $20 ; entry 3
    db $d0, $28, $10, $20 ; entry 4
    db $d0, $38, $05, $60 ; entry 5
    db $e8, $10, $1b, $20 ; entry 6
    db $e8, $08, $1c, $20 ; entry 7
    db $e8, $00, $1d, $20 ; entry 8
    db $e8, $f8, $1e, $20 ; entry 9
    db $e0, $10, $17, $20 ; entry 10
    db $e0, $08, $18, $20 ; entry 11
    db $e0, $00, $19, $20 ; entry 12
    db $e0, $f8, $1a, $20 ; entry 13
    db $d8, $0f, $14, $20 ; entry 14
    db $d8, $07, $15, $20 ; entry 15
    db $d8, $ff, $16, $20 ; entry 16
    db $d0, $b0, $06, $00 ; entry 17
    db $d0, $48, $0c, $60 ; entry 18
    db $d0, $40, $0d, $60 ; entry 19
    db $d0, $d8, $1b, $20 ; entry 20
    db $d0, $d0, $1c, $20 ; entry 21
    db $d0, $c8, $1d, $20 ; entry 22
    db $d0, $c0, $1e, $20 ; entry 23
    db $e8, $20, $05, $20 ; entry 24
    db $e8, $c0, $08, $40 ; entry 25
    db $e8, $c8, $09, $40 ; entry 26
    db $e0, $c0, $0a, $40 ; entry 27
    db $e0, $c8, $0b, $40 ; entry 28
    db $f8, $20, $1f, $00 ; entry 29
    db $f8, $28, $20, $00 ; entry 30
    db $f8, $30, $21, $00 ; entry 31
    db $f8, $f0, $06, $00 ; entry 32
    db $f8, $b8, $07, $00 ; entry 33
    db $f4, $3c, $12, $00 ; entry 34
    db $f4, $44, $13, $00 ; entry 35
    db $80 ; end

; frame 18 of MetaSprites3DSet2A; ends with $80 (E-0147)
MetaSprites3DSet2AFrame18::
    db $d0, $38, $07, $20 ; entry 0
    db $d0, $e8, $06, $00 ; entry 1
    db $d8, $10, $1b, $20 ; entry 2
    db $d8, $08, $1c, $20 ; entry 3
    db $d8, $00, $1d, $20 ; entry 4
    db $d8, $f8, $1e, $20 ; entry 5
    db $d0, $10, $17, $20 ; entry 6
    db $d0, $08, $18, $20 ; entry 7
    db $d0, $00, $19, $20 ; entry 8
    db $d0, $f8, $1a, $20 ; entry 9
    db $d8, $20, $05, $20 ; entry 10
    db $d8, $c0, $08, $40 ; entry 11
    db $d8, $c8, $09, $40 ; entry 12
    db $d0, $c0, $0a, $40 ; entry 13
    db $d0, $c8, $0b, $40 ; entry 14
    db $e8, $30, $1f, $20 ; entry 15
    db $e8, $28, $20, $20 ; entry 16
    db $e8, $20, $21, $20 ; entry 17
    db $e8, $f0, $06, $00 ; entry 18
    db $e8, $b8, $07, $00 ; entry 19
    db $e4, $3c, $12, $00 ; entry 20
    db $e4, $44, $13, $00 ; entry 21
    db $f0, $30, $22, $20 ; entry 22
    db $f0, $28, $23, $20 ; entry 23
    db $f0, $20, $24, $20 ; entry 24
    db $f8, $30, $25, $20 ; entry 25
    db $f8, $28, $26, $20 ; entry 26
    db $f8, $20, $27, $20 ; entry 27
    db $f0, $d0, $08, $00 ; entry 28
    db $f0, $d8, $09, $00 ; entry 29
    db $f8, $d0, $0a, $00 ; entry 30
    db $f8, $d8, $0b, $00 ; entry 31
    db $f0, $f8, $10, $00 ; entry 32
    db $f8, $f8, $11, $00 ; entry 33
    db $f8, $bc, $10, $00 ; entry 34
    db $80 ; end

; frame 19 of MetaSprites3DSet2A; ends with $80 (E-0147)
MetaSprites3DSet2AFrame19::
    db $d8, $20, $1f, $00 ; entry 0
    db $d8, $28, $20, $00 ; entry 1
    db $d8, $30, $21, $00 ; entry 2
    db $d8, $f0, $06, $00 ; entry 3
    db $d8, $b8, $07, $00 ; entry 4
    db $d4, $3c, $12, $00 ; entry 5
    db $d4, $44, $13, $00 ; entry 6
    db $e0, $20, $22, $00 ; entry 7
    db $e0, $28, $23, $00 ; entry 8
    db $e0, $30, $24, $00 ; entry 9
    db $e8, $20, $25, $00 ; entry 10
    db $e8, $28, $26, $00 ; entry 11
    db $e8, $30, $27, $00 ; entry 12
    db $e0, $d0, $08, $00 ; entry 13
    db $e0, $d8, $09, $00 ; entry 14
    db $e8, $d0, $0a, $00 ; entry 15
    db $e8, $d8, $0b, $00 ; entry 16
    db $e8, $bc, $10, $00 ; entry 17
    db $f0, $22, $28, $00 ; entry 18
    db $f0, $2a, $29, $00 ; entry 19
    db $f0, $d7, $14, $20 ; entry 20
    db $f0, $cf, $15, $20 ; entry 21
    db $f0, $c7, $16, $20 ; entry 22
    db $f8, $d8, $17, $20 ; entry 23
    db $f8, $d0, $18, $20 ; entry 24
    db $f8, $c8, $19, $20 ; entry 25
    db $f8, $c0, $1a, $20 ; entry 26
    db $f8, $40, $0c, $00 ; entry 27
    db $f8, $48, $0d, $00 ; entry 28
    db $f0, $10, $07, $00 ; entry 29
    db $e4, $f4, $12, $00 ; entry 30
    db $e4, $fc, $13, $00 ; entry 31
    db $f8, $e8, $05, $00 ; entry 32
    db $80 ; end

; frame 20 of MetaSprites3DSet2A; ends with $80 (E-0147)
MetaSprites3DSet2AFrame20::
    db $d0, $20, $22, $00 ; entry 0
    db $d0, $28, $23, $00 ; entry 1
    db $d0, $30, $24, $00 ; entry 2
    db $d8, $20, $25, $00 ; entry 3
    db $d8, $28, $26, $00 ; entry 4
    db $d8, $30, $27, $00 ; entry 5
    db $d0, $d0, $08, $00 ; entry 6
    db $d0, $d8, $09, $00 ; entry 7
    db $d8, $d0, $0a, $00 ; entry 8
    db $d8, $d8, $0b, $00 ; entry 9
    db $d8, $bc, $10, $00 ; entry 10
    db $e0, $22, $28, $00 ; entry 11
    db $e0, $2a, $29, $00 ; entry 12
    db $e8, $40, $0c, $00 ; entry 13
    db $e8, $48, $0d, $00 ; entry 14
    db $e0, $10, $07, $00 ; entry 15
    db $d4, $f4, $12, $00 ; entry 16
    db $d4, $fc, $13, $00 ; entry 17
    db $e8, $e8, $05, $00 ; entry 18
    db $f8, $08, $1f, $20 ; entry 19
    db $f8, $00, $20, $20 ; entry 20
    db $f8, $f8, $21, $20 ; entry 21
    db $f0, $f8, $05, $40 ; entry 22
    db $f0, $40, $0e, $00 ; entry 23
    db $f0, $48, $0f, $00 ; entry 24
    db $f0, $28, $05, $00 ; entry 25
    db $f4, $1d, $12, $20 ; entry 26
    db $f4, $15, $13, $20 ; entry 27
    db $f0, $b0, $06, $00 ; entry 28
    db $f0, $d7, $14, $60 ; entry 29
    db $f0, $cf, $15, $60 ; entry 30
    db $f0, $c7, $16, $60 ; entry 31
    db $e8, $d8, $17, $60 ; entry 32
    db $e8, $d0, $18, $60 ; entry 33
    db $e8, $c8, $19, $60 ; entry 34
    db $e8, $c0, $1a, $60 ; entry 35
    db $e0, $d8, $1b, $60 ; entry 36
    db $e0, $d0, $1c, $60 ; entry 37
    db $e0, $c8, $1d, $60 ; entry 38
    db $e0, $c0, $1e, $60 ; entry 39
    db $80 ; end

; frame 21 of MetaSprites3DSet2A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet2AFrame21::
    db $e8, $f8, $1f, $00 ; entry 0
    db $e8, $00, $20, $00 ; entry 1
    db $e8, $08, $21, $00 ; entry 2
    db $f0, $f8, $22, $00 ; entry 3
    db $f0, $00, $23, $00 ; entry 4
    db $f0, $08, $24, $00 ; entry 5
    db $f8, $f8, $25, $00 ; entry 6
    db $f8, $00, $26, $00 ; entry 7
    db $f8, $08, $27, $00 ; entry 8
    db $e0, $c0, $1b, $00 ; entry 9
    db $e0, $c8, $1c, $00 ; entry 10
    db $e0, $d0, $1d, $00 ; entry 11
    db $e0, $d8, $1e, $00 ; entry 12
    db $d8, $c0, $17, $00 ; entry 13
    db $d8, $c8, $18, $00 ; entry 14
    db $d8, $d0, $19, $00 ; entry 15
    db $d8, $d8, $1a, $00 ; entry 16
    db $d0, $c1, $14, $00 ; entry 17
    db $d0, $c9, $15, $00 ; entry 18
    db $d0, $d1, $16, $00 ; entry 19
    db $d8, $40, $08, $00 ; entry 20
    db $d8, $48, $09, $00 ; entry 21
    db $e0, $40, $0a, $00 ; entry 22
    db $e0, $48, $0b, $00 ; entry 23
    db $e0, $b0, $06, $00 ; entry 24
    db $e0, $f8, $05, $20 ; entry 25
    db $d0, $30, $05, $00 ; entry 26
    db $e8, $18, $11, $00 ; entry 27
    db $e0, $18, $10, $00 ; entry 28
    db $d8, $e8, $05, $00 ; entry 29
    db $e0, $28, $05, $40 ; entry 30
    db $80 ; end

; frame 22 of MetaSprites3DSet2A; ends with $80 (E-0147)
MetaSprites3DSet2AFrame22::
    db $d8, $f8, $1f, $00 ; entry 0
    db $d8, $00, $20, $00 ; entry 1
    db $d8, $08, $21, $00 ; entry 2
    db $e0, $f8, $22, $00 ; entry 3
    db $e0, $00, $23, $00 ; entry 4
    db $e0, $08, $24, $00 ; entry 5
    db $e8, $f8, $25, $00 ; entry 6
    db $e8, $00, $26, $00 ; entry 7
    db $e8, $08, $27, $00 ; entry 8
    db $d0, $d8, $1b, $20 ; entry 9
    db $d0, $d0, $1c, $20 ; entry 10
    db $d0, $c8, $1d, $20 ; entry 11
    db $d0, $c0, $1e, $20 ; entry 12
    db $d0, $48, $0a, $20 ; entry 13
    db $d0, $40, $0b, $20 ; entry 14
    db $d0, $b0, $06, $20 ; entry 15
    db $d0, $f8, $05, $20 ; entry 16
    db $d8, $14, $11, $20 ; entry 17
    db $d0, $14, $10, $20 ; entry 18
    db $d0, $28, $05, $20 ; entry 19
    db $f0, $fa, $28, $00 ; entry 20
    db $f0, $02, $29, $00 ; entry 21
    db $80 ; end

; frame 23 of MetaSprites3DSet2A; ends with $80 (E-0147)
MetaSprites3DSet2AFrame23::
    db $d0, $08, $25, $20 ; entry 0
    db $d0, $00, $26, $20 ; entry 1
    db $d0, $f8, $27, $20 ; entry 2
    db $d8, $06, $28, $20 ; entry 3
    db $d8, $fe, $29, $20 ; entry 4
    db $80 ; end

; frame 24 of MetaSprites3DSet2A; ends with $80 (E-0147)
MetaSprites3DSet2AFrame24::
    db $80 ; end

; meta-sprite set 43 of MetaSprites3DTable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3DSet2B::
    dw MetaSprites3DSet2BFrame0 ; entry 0
    dw MetaSprites3DSet2BFrame1 ; entry 1
    dw MetaSprites3DSet2BFrame2 ; entry 2
    dw MetaSprites3DSet2BFrame3 ; entry 3
    dw MetaSprites3DSet2BFrame4 ; entry 4
    dw MetaSprites3DSet2BFrame5 ; entry 5
    dw MetaSprites3DSet2BFrame6 ; entry 6
    dw MetaSprites3DSet2BFrame7 ; entry 7
    dw MetaSprites3DSet2BFrame8 ; entry 8
    dw MetaSprites3DSet2BFrame9 ; entry 9
    dw MetaSprites3DSet2BFrame9 ; entry 10
    dw MetaSprites3DSet2BFrame9 ; entry 11
    dw MetaSprites3DSet2BFrame9 ; entry 12
    dw MetaSprites3DSet2BFrame9 ; entry 13
    dw MetaSprites3DSet2BFrame9 ; entry 14
    dw MetaSprites3DSet2BFrame9 ; entry 15
    dw MetaSprites3DSet2BFrame9 ; entry 16
    dw MetaSprites3DSet2BFrame9 ; entry 17
    dw MetaSprites3DSet2BFrame9 ; entry 18
    dw MetaSprites3DSet2BFrame9 ; entry 19
    dw MetaSprites3DSet2BFrame9 ; entry 20
    dw MetaSprites3DSet2BFrame9 ; entry 21
    dw MetaSprites3DSet2BFrame9 ; entry 22
    dw MetaSprites3DSet2BFrame9 ; entry 23
    dw MetaSprites3DSet2BFrame9 ; entry 24
    dw MetaSprites3DSet2BFrame9 ; entry 25
    dw MetaSprites3DSet2BFrame9 ; entry 26
    dw MetaSprites3DSet2BFrame9 ; entry 27
    dw MetaSprites3DSet2BFrame9 ; entry 28
    dw MetaSprites3DSet2BFrame9 ; entry 29
    dw MetaSprites3DSet2BFrame9 ; entry 30
    dw MetaSprites3DSet2BFrame9 ; entry 31

; frame 0 of MetaSprites3DSet2B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet2BFrame0::
    db $f0, $f0, $1f, $10 ; entry 0
    db $f8, $f8, $21, $10 ; entry 1
    db $f5, $eb, $1f, $10 ; entry 2
    db $e8, $ec, $1e, $10 ; entry 3
    db $ec, $f8, $13, $10 ; entry 4
    db $d8, $f0, $1f, $50 ; entry 5
    db $d0, $f8, $21, $50 ; entry 6
    db $d3, $eb, $1f, $50 ; entry 7
    db $e0, $ec, $1e, $50 ; entry 8
    db $e0, $f5, $13, $50 ; entry 9
    db $d8, $f9, $0f, $30 ; entry 10
    db $dc, $f8, $13, $50 ; entry 11
    db $f0, $09, $1f, $30 ; entry 12
    db $f8, $01, $21, $30 ; entry 13
    db $f5, $0e, $1f, $30 ; entry 14
    db $e8, $0d, $1e, $30 ; entry 15
    db $e8, $04, $13, $30 ; entry 16
    db $f0, $00, $0f, $50 ; entry 17
    db $ec, $01, $13, $30 ; entry 18
    db $d8, $09, $1f, $70 ; entry 19
    db $d0, $01, $21, $70 ; entry 20
    db $d3, $0e, $1f, $70 ; entry 21
    db $e0, $0d, $1e, $70 ; entry 22
    db $e0, $04, $13, $70 ; entry 23
    db $dc, $01, $13, $70 ; entry 24
    db $e8, $f5, $13, $10 ; entry 25
    db $f0, $f9, $0f, $70 ; entry 26
    db $d8, $00, $0f, $10 ; entry 27
    db $80 ; end

; frame 1 of MetaSprites3DSet2B; ends with $80 (E-0147)
MetaSprites3DSet2BFrame1::
    db $ee, $e8, $18, $10 ; entry 0
    db $f6, $f8, $1b, $10 ; entry 1
    db $e6, $e4, $14, $10 ; entry 2
    db $f6, $f0, $18, $10 ; entry 3
    db $da, $e8, $18, $50 ; entry 4
    db $d2, $f8, $1b, $50 ; entry 5
    db $e2, $e4, $14, $50 ; entry 6
    db $d2, $f0, $18, $50 ; entry 7
    db $ee, $10, $18, $30 ; entry 8
    db $f6, $00, $1b, $30 ; entry 9
    db $e6, $14, $14, $30 ; entry 10
    db $f6, $08, $18, $30 ; entry 11
    db $da, $10, $18, $70 ; entry 12
    db $d2, $00, $1b, $70 ; entry 13
    db $e2, $14, $14, $70 ; entry 14
    db $d2, $08, $18, $70 ; entry 15
    db $e2, $0c, $13, $10 ; entry 16
    db $da, $08, $13, $10 ; entry 17
    db $da, $f0, $13, $30 ; entry 18
    db $da, $f8, $13, $30 ; entry 19
    db $e6, $ec, $13, $70 ; entry 20
    db $ee, $f0, $13, $70 ; entry 21
    db $ee, $08, $13, $50 ; entry 22
    db $ee, $00, $13, $50 ; entry 23
    db $da, $00, $13, $10 ; entry 24
    db $ee, $f8, $13, $70 ; entry 25
    db $e2, $ec, $13, $30 ; entry 26
    db $ea, $0c, $13, $10 ; entry 27
    db $e4, $f4, $0a, $10 ; entry 28
    db $e4, $04, $0a, $30 ; entry 29
    db $f3, $e3, $09, $10 ; entry 30
    db $f3, $15, $09, $30 ; entry 31
    db $d5, $15, $09, $70 ; entry 32
    db $d5, $e3, $09, $50 ; entry 33
    db $80 ; end

; frame 2 of MetaSprites3DSet2B; ends with $80 (E-0147)
MetaSprites3DSet2BFrame2::
    db $f0, $f0, $19, $10 ; entry 0
    db $f8, $f0, $1b, $10 ; entry 1
    db $f0, $e0, $14, $10 ; entry 2
    db $f8, $e0, $17, $10 ; entry 3
    db $d8, $f0, $19, $50 ; entry 4
    db $d0, $f0, $1b, $50 ; entry 5
    db $d8, $e0, $14, $50 ; entry 6
    db $d0, $e0, $17, $50 ; entry 7
    db $f8, $08, $1b, $30 ; entry 8
    db $f0, $18, $14, $30 ; entry 9
    db $f8, $18, $17, $30 ; entry 10
    db $d0, $08, $1b, $70 ; entry 11
    db $d8, $18, $14, $70 ; entry 12
    db $d0, $18, $17, $70 ; entry 13
    db $f0, $08, $86, $30 ; entry 14
    db $d8, $08, $86, $70 ; entry 15
    db $d8, $00, $0d, $70 ; entry 16
    db $d0, $f8, $0e, $50 ; entry 17
    db $d0, $00, $0e, $50 ; entry 18
    db $f0, $f8, $0d, $10 ; entry 19
    db $f0, $00, $0d, $30 ; entry 20
    db $f8, $f8, $0e, $10 ; entry 21
    db $f8, $00, $0e, $10 ; entry 22
    db $d8, $10, $04, $10 ; entry 23
    db $d8, $e8, $04, $30 ; entry 24
    db $f0, $10, $04, $30 ; entry 25
    db $f0, $e8, $04, $10 ; entry 26
    db $f8, $e8, $1f, $10 ; entry 27
    db $f8, $10, $1f, $30 ; entry 28
    db $d0, $10, $1f, $10 ; entry 29
    db $d0, $e8, $1f, $30 ; entry 30
    db $ea, $f6, $08, $10 ; entry 31
    db $de, $f6, $08, $50 ; entry 32
    db $de, $02, $08, $70 ; entry 33
    db $ea, $02, $08, $30 ; entry 34
    db $e0, $e7, $00, $50 ; entry 35
    db $e8, $e2, $01, $10 ; entry 36
    db $e4, $e0, $0b, $10 ; entry 37
    db $e8, $11, $00, $30 ; entry 38
    db $e0, $11, $00, $70 ; entry 39
    db $e8, $16, $01, $30 ; entry 40
    db $e0, $16, $01, $70 ; entry 41
    db $e4, $18, $0b, $30 ; entry 42
    db $d8, $f8, $0d, $50 ; entry 43
    db $e8, $e7, $00, $10 ; entry 44
    db $e0, $e2, $01, $50 ; entry 45
    db $80 ; end

; frame 3 of MetaSprites3DSet2B; ends with $80 (E-0147)
MetaSprites3DSet2BFrame3::
    db $f0, $dc, $14, $10 ; entry 0
    db $f0, $e4, $15, $10 ; entry 1
    db $f8, $dc, $17, $10 ; entry 2
    db $f8, $ec, $1a, $10 ; entry 3
    db $f3, $f1, $19, $10 ; entry 4
    db $f8, $f8, $10, $10 ; entry 5
    db $d8, $dc, $14, $50 ; entry 6
    db $d8, $e4, $15, $50 ; entry 7
    db $d0, $dc, $17, $50 ; entry 8
    db $d0, $ec, $1a, $50 ; entry 9
    db $d5, $f1, $19, $50 ; entry 10
    db $d0, $f8, $10, $50 ; entry 11
    db $f0, $1c, $14, $30 ; entry 12
    db $f0, $14, $15, $30 ; entry 13
    db $f8, $1c, $17, $30 ; entry 14
    db $f8, $0c, $1a, $30 ; entry 15
    db $f3, $07, $19, $30 ; entry 16
    db $f8, $00, $10, $30 ; entry 17
    db $d8, $1c, $14, $70 ; entry 18
    db $d8, $14, $15, $70 ; entry 19
    db $d0, $1c, $17, $70 ; entry 20
    db $d0, $0c, $1a, $70 ; entry 21
    db $d5, $07, $19, $70 ; entry 22
    db $d0, $00, $10, $70 ; entry 23
    db $f8, $e4, $1f, $10 ; entry 24
    db $d0, $e4, $1f, $30 ; entry 25
    db $d0, $14, $1f, $10 ; entry 26
    db $f8, $14, $1f, $30 ; entry 27
    db $ef, $fc, $0d, $10 ; entry 28
    db $d9, $fc, $0d, $50 ; entry 29
    db $e0, $db, $01, $50 ; entry 30
    db $e8, $db, $01, $10 ; entry 31
    db $e8, $e3, $11, $10 ; entry 32
    db $e0, $e3, $11, $50 ; entry 33
    db $e9, $ed, $02, $10 ; entry 34
    db $df, $ed, $02, $50 ; entry 35
    db $e0, $1d, $01, $70 ; entry 36
    db $e8, $1d, $01, $30 ; entry 37
    db $e8, $15, $11, $30 ; entry 38
    db $e0, $15, $11, $70 ; entry 39
    db $e9, $0b, $02, $30 ; entry 40
    db $df, $0b, $02, $70 ; entry 41
    db $80 ; end

; frame 4 of MetaSprites3DSet2B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet2BFrame4::
    db $f8, $f4, $20, $10 ; entry 0
    db $f0, $d8, $15, $10 ; entry 1
    db $f8, $d0, $17, $10 ; entry 2
    db $ee, $eb, $1f, $10 ; entry 3
    db $f8, $e8, $1a, $10 ; entry 4
    db $d0, $f4, $20, $50 ; entry 5
    db $d8, $d8, $15, $50 ; entry 6
    db $d0, $d0, $17, $50 ; entry 7
    db $da, $eb, $1f, $50 ; entry 8
    db $d0, $e8, $1a, $50 ; entry 9
    db $f8, $df, $1f, $10 ; entry 10
    db $d0, $df, $1f, $50 ; entry 11
    db $ea, $f6, $1f, $10 ; entry 12
    db $de, $f6, $1f, $50 ; entry 13
    db $f0, $d0, $02, $10 ; entry 14
    db $d8, $d0, $02, $50 ; entry 15
    db $e8, $d7, $03, $10 ; entry 16
    db $e0, $d7, $03, $50 ; entry 17
    db $e8, $de, $01, $70 ; entry 18
    db $e0, $de, $01, $30 ; entry 19
    db $f0, $e1, $02, $10 ; entry 20
    db $d8, $e1, $02, $30 ; entry 21
    db $f8, $04, $20, $30 ; entry 22
    db $f0, $20, $15, $30 ; entry 23
    db $f8, $28, $17, $30 ; entry 24
    db $ee, $0d, $1f, $30 ; entry 25
    db $f8, $10, $1a, $30 ; entry 26
    db $d0, $04, $20, $70 ; entry 27
    db $d8, $20, $15, $70 ; entry 28
    db $d0, $28, $17, $70 ; entry 29
    db $da, $0d, $1f, $70 ; entry 30
    db $d0, $10, $1a, $70 ; entry 31
    db $f8, $19, $1f, $30 ; entry 32
    db $d0, $19, $1f, $70 ; entry 33
    db $ea, $02, $1f, $30 ; entry 34
    db $de, $02, $1f, $70 ; entry 35
    db $f0, $28, $02, $30 ; entry 36
    db $d8, $28, $02, $70 ; entry 37
    db $e8, $21, $03, $30 ; entry 38
    db $e0, $21, $03, $70 ; entry 39
    db $e8, $1a, $01, $50 ; entry 40
    db $e0, $1a, $01, $10 ; entry 41
    db $f0, $17, $02, $30 ; entry 42
    db $d8, $17, $02, $10 ; entry 43
    db $e0, $28, $07, $10 ; entry 44
    db $e8, $28, $07, $50 ; entry 45
    db $e0, $d0, $07, $30 ; entry 46
    db $e8, $d0, $07, $70 ; entry 47
    db $80 ; end

; frame 5 of MetaSprites3DSet2B; ends with $80 (E-0147)
MetaSprites3DSet2BFrame5::
    db $f0, $f8, $1b, $10 ; entry 0
    db $e8, $f0, $14, $10 ; entry 1
    db $f0, $dd, $1c, $10 ; entry 2
    db $f0, $f0, $1d, $10 ; entry 3
    db $f8, $e1, $18, $10 ; entry 4
    db $f8, $c2, $17, $10 ; entry 5
    db $f8, $d3, $17, $10 ; entry 6
    db $d8, $f8, $1b, $50 ; entry 7
    db $e0, $f0, $14, $50 ; entry 8
    db $d8, $dd, $1c, $50 ; entry 9
    db $d8, $f0, $1d, $50 ; entry 10
    db $d0, $e1, $18, $50 ; entry 11
    db $d0, $c2, $17, $50 ; entry 12
    db $d0, $d3, $17, $50 ; entry 13
    db $f8, $ef, $20, $10 ; entry 14
    db $e8, $f8, $12, $10 ; entry 15
    db $e0, $f8, $12, $50 ; entry 16
    db $f8, $fc, $0d, $10 ; entry 17
    db $d0, $ef, $20, $50 ; entry 18
    db $d0, $fc, $0d, $70 ; entry 19
    db $e0, $d7, $00, $30 ; entry 20
    db $e8, $d7, $00, $70 ; entry 21
    db $d8, $c8, $02, $30 ; entry 22
    db $f0, $c8, $02, $70 ; entry 23
    db $e8, $c8, $06, $10 ; entry 24
    db $e0, $c8, $06, $50 ; entry 25
    db $f0, $d0, $00, $70 ; entry 26
    db $d8, $d0, $00, $30 ; entry 27
    db $e8, $cf, $03, $10 ; entry 28
    db $e0, $cf, $03, $50 ; entry 29
    db $f0, $00, $1b, $30 ; entry 30
    db $e8, $08, $14, $30 ; entry 31
    db $f0, $1b, $1c, $30 ; entry 32
    db $f0, $08, $1d, $30 ; entry 33
    db $f8, $17, $18, $30 ; entry 34
    db $f8, $36, $17, $30 ; entry 35
    db $f8, $25, $17, $30 ; entry 36
    db $d8, $00, $1b, $70 ; entry 37
    db $e0, $08, $14, $70 ; entry 38
    db $d8, $1b, $1c, $70 ; entry 39
    db $d8, $08, $1d, $70 ; entry 40
    db $d0, $17, $18, $70 ; entry 41
    db $d0, $36, $17, $70 ; entry 42
    db $d0, $25, $17, $70 ; entry 43
    db $f8, $09, $20, $30 ; entry 44
    db $e8, $00, $12, $30 ; entry 45
    db $e0, $00, $12, $70 ; entry 46
    db $d0, $09, $20, $70 ; entry 47
    db $e0, $21, $00, $10 ; entry 48
    db $e8, $21, $00, $50 ; entry 49
    db $d8, $30, $02, $10 ; entry 50
    db $f0, $30, $02, $50 ; entry 51
    db $e8, $30, $06, $30 ; entry 52
    db $e0, $30, $06, $70 ; entry 53
    db $f0, $28, $00, $50 ; entry 54
    db $d8, $28, $00, $10 ; entry 55
    db $e8, $29, $03, $30 ; entry 56
    db $e0, $29, $03, $70 ; entry 57
    db $80 ; end

; frame 6 of MetaSprites3DSet2B; ends with $80 (E-0147)
MetaSprites3DSet2BFrame6::
    db $f8, $d6, $18, $10 ; entry 0
    db $f0, $f4, $11, $10 ; entry 1
    db $f0, $ec, $18, $10 ; entry 2
    db $e8, $e5, $14, $10 ; entry 3
    db $e8, $ed, $13, $10 ; entry 4
    db $f8, $f7, $1b, $10 ; entry 5
    db $d0, $d6, $18, $50 ; entry 6
    db $d8, $f4, $11, $50 ; entry 7
    db $d8, $ec, $18, $50 ; entry 8
    db $e0, $e5, $14, $50 ; entry 9
    db $e0, $ed, $13, $50 ; entry 10
    db $d0, $f7, $1b, $50 ; entry 11
    db $f8, $c8, $1c, $10 ; entry 12
    db $d0, $c8, $1c, $50 ; entry 13
    db $f8, $b8, $17, $10 ; entry 14
    db $d0, $b8, $17, $50 ; entry 15
    db $f8, $ed, $1f, $10 ; entry 16
    db $d0, $e6, $1f, $30 ; entry 17
    db $f0, $e4, $1c, $10 ; entry 18
    db $d8, $df, $1c, $50 ; entry 19
    db $ea, $bc, $14, $10 ; entry 20
    db $de, $bc, $14, $50 ; entry 21
    db $f0, $cd, $05, $10 ; entry 22
    db $d8, $cb, $05, $50 ; entry 23
    db $f8, $22, $18, $30 ; entry 24
    db $f0, $04, $11, $30 ; entry 25
    db $f0, $0c, $18, $30 ; entry 26
    db $e8, $13, $14, $30 ; entry 27
    db $e8, $0b, $13, $30 ; entry 28
    db $f8, $01, $1b, $30 ; entry 29
    db $d0, $22, $18, $70 ; entry 30
    db $d8, $04, $11, $70 ; entry 31
    db $d8, $0c, $18, $70 ; entry 32
    db $e0, $13, $14, $70 ; entry 33
    db $e0, $0b, $13, $70 ; entry 34
    db $d0, $01, $1b, $70 ; entry 35
    db $f8, $30, $1c, $30 ; entry 36
    db $d0, $30, $1c, $70 ; entry 37
    db $f8, $40, $17, $30 ; entry 38
    db $d0, $40, $17, $70 ; entry 39
    db $f8, $0b, $1f, $30 ; entry 40
    db $d0, $12, $1f, $10 ; entry 41
    db $f0, $14, $1c, $30 ; entry 42
    db $d8, $19, $1c, $70 ; entry 43
    db $ea, $3c, $14, $30 ; entry 44
    db $de, $3c, $14, $70 ; entry 45
    db $f0, $2b, $05, $30 ; entry 46
    db $d8, $2d, $05, $70 ; entry 47
    db $e0, $35, $00, $70 ; entry 48
    db $e8, $35, $00, $30 ; entry 49
    db $e0, $c3, $00, $50 ; entry 50
    db $e8, $c3, $00, $10 ; entry 51
    db $e8, $cb, $04, $10 ; entry 52
    db $e0, $cb, $04, $50 ; entry 53
    db $e0, $2d, $04, $70 ; entry 54
    db $e8, $2d, $04, $30 ; entry 55
    db $80 ; end

; frame 7 of MetaSprites3DSet2B; ends with $80 (E-0147)
MetaSprites3DSet2BFrame7::
    db $f0, $cb, $15, $10 ; entry 0
    db $f8, $ec, $1a, $10 ; entry 1
    db $f3, $f1, $19, $10 ; entry 2
    db $f0, $e6, $04, $10 ; entry 3
    db $e8, $e3, $15, $10 ; entry 4
    db $f0, $b8, $14, $10 ; entry 5
    db $f8, $c5, $09, $10 ; entry 6
    db $f8, $f8, $0d, $10 ; entry 7
    db $ed, $c1, $16, $70 ; entry 8
    db $e4, $da, $0c, $70 ; entry 9
    db $f0, $2e, $15, $30 ; entry 10
    db $f8, $0d, $1a, $30 ; entry 11
    db $f3, $08, $19, $30 ; entry 12
    db $f0, $13, $04, $30 ; entry 13
    db $e8, $16, $15, $30 ; entry 14
    db $f0, $41, $14, $30 ; entry 15
    db $f8, $34, $09, $30 ; entry 16
    db $f8, $01, $0d, $30 ; entry 17
    db $ed, $38, $16, $50 ; entry 18
    db $e4, $1f, $0c, $50 ; entry 19
    db $d8, $cb, $15, $50 ; entry 20
    db $d0, $ec, $1a, $50 ; entry 21
    db $d5, $f1, $19, $50 ; entry 22
    db $d8, $e6, $04, $50 ; entry 23
    db $e0, $e3, $15, $50 ; entry 24
    db $d8, $b8, $14, $50 ; entry 25
    db $d0, $c5, $09, $50 ; entry 26
    db $d0, $f8, $0d, $50 ; entry 27
    db $db, $c1, $16, $30 ; entry 28
    db $d8, $2e, $15, $70 ; entry 29
    db $d0, $0d, $1a, $70 ; entry 30
    db $d5, $08, $19, $70 ; entry 31
    db $d8, $13, $04, $70 ; entry 32
    db $e0, $16, $15, $70 ; entry 33
    db $d8, $41, $14, $70 ; entry 34
    db $d0, $34, $09, $70 ; entry 35
    db $d0, $01, $0d, $70 ; entry 36
    db $db, $38, $16, $10 ; entry 37
    db $f8, $e4, $06, $10 ; entry 38
    db $d0, $e4, $06, $50 ; entry 39
    db $d0, $15, $06, $10 ; entry 40
    db $f8, $15, $06, $50 ; entry 41
    db $80 ; end

; frame 8 of MetaSprites3DSet2B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet2BFrame8::
    db $f8, $f4, $20, $10 ; entry 0
    db $f0, $d0, $14, $10 ; entry 1
    db $f8, $e8, $1a, $10 ; entry 2
    db $d0, $f4, $20, $50 ; entry 3
    db $d8, $d0, $14, $50 ; entry 4
    db $d0, $e8, $1a, $50 ; entry 5
    db $f0, $e5, $1f, $10 ; entry 6
    db $d8, $e5, $1f, $50 ; entry 7
    db $f0, $d8, $13, $10 ; entry 8
    db $d8, $d8, $13, $50 ; entry 9
    db $e8, $d4, $13, $10 ; entry 10
    db $e0, $d4, $13, $50 ; entry 11
    db $ea, $cc, $16, $70 ; entry 12
    db $de, $cc, $16, $30 ; entry 13
    db $d0, $df, $11, $30 ; entry 14
    db $f8, $df, $11, $10 ; entry 15
    db $e0, $dd, $06, $50 ; entry 16
    db $e8, $dd, $06, $10 ; entry 17
    db $f8, $b0, $09, $10 ; entry 18
    db $f0, $b8, $06, $10 ; entry 19
    db $f8, $c4, $06, $10 ; entry 20
    db $f8, $04, $20, $30 ; entry 21
    db $f0, $28, $14, $30 ; entry 22
    db $f8, $10, $1a, $30 ; entry 23
    db $d0, $04, $20, $70 ; entry 24
    db $d8, $28, $14, $70 ; entry 25
    db $d0, $10, $1a, $70 ; entry 26
    db $f0, $13, $1f, $30 ; entry 27
    db $d8, $13, $1f, $70 ; entry 28
    db $f0, $20, $13, $30 ; entry 29
    db $d8, $20, $13, $70 ; entry 30
    db $e8, $24, $13, $30 ; entry 31
    db $e0, $24, $13, $70 ; entry 32
    db $ea, $2c, $16, $50 ; entry 33
    db $de, $2c, $16, $10 ; entry 34
    db $d0, $19, $11, $10 ; entry 35
    db $f8, $19, $11, $30 ; entry 36
    db $e0, $1b, $06, $70 ; entry 37
    db $e8, $1b, $06, $30 ; entry 38
    db $f8, $48, $09, $30 ; entry 39
    db $f0, $40, $06, $30 ; entry 40
    db $f8, $34, $06, $30 ; entry 41
    db $d0, $48, $09, $70 ; entry 42
    db $d8, $40, $06, $70 ; entry 43
    db $d0, $34, $06, $70 ; entry 44
    db $d0, $b0, $09, $50 ; entry 45
    db $d8, $b8, $06, $50 ; entry 46
    db $d0, $c4, $06, $50 ; entry 47
    db $80 ; end

; frame 9 of MetaSprites3DSet2B; ends with $80 (E-0147)
MetaSprites3DSet2BFrame9::
    db $80 ; end

; meta-sprite set 44 of MetaSprites3DTable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3DSet2C::
    dw MetaSprites3DSet2CFrame0 ; entry 0
    dw MetaSprites3DSet2CFrame1 ; entry 1
    dw MetaSprites3DSet2CFrame2 ; entry 2
    dw MetaSprites3DSet2CFrame3 ; entry 3
    dw MetaSprites3DSet2CFrame4 ; entry 4
    dw MetaSprites3DSet2CFrame5 ; entry 5
    dw MetaSprites3DSet2CFrame6 ; entry 6
    dw MetaSprites3DSet2CFrame7 ; entry 7
    dw MetaSprites3DSet2CFrame8 ; entry 8
    dw MetaSprites3DSet2CFrame9 ; entry 9
    dw MetaSprites3DSet2CFrame10 ; entry 10
    dw MetaSprites3DSet2CFrame10 ; entry 11
    dw MetaSprites3DSet2CFrame10 ; entry 12
    dw MetaSprites3DSet2CFrame10 ; entry 13
    dw MetaSprites3DSet2CFrame10 ; entry 14
    dw MetaSprites3DSet2CFrame10 ; entry 15
    dw MetaSprites3DSet2CFrame10 ; entry 16
    dw MetaSprites3DSet2CFrame10 ; entry 17
    dw MetaSprites3DSet2CFrame10 ; entry 18
    dw MetaSprites3DSet2CFrame10 ; entry 19
    dw MetaSprites3DSet2CFrame10 ; entry 20
    dw MetaSprites3DSet2CFrame10 ; entry 21
    dw MetaSprites3DSet2CFrame10 ; entry 22
    dw MetaSprites3DSet2CFrame10 ; entry 23
    dw MetaSprites3DSet2CFrame10 ; entry 24
    dw MetaSprites3DSet2CFrame10 ; entry 25
    dw MetaSprites3DSet2CFrame10 ; entry 26
    dw MetaSprites3DSet2CFrame10 ; entry 27
    dw MetaSprites3DSet2CFrame10 ; entry 28
    dw MetaSprites3DSet2CFrame10 ; entry 29
    dw MetaSprites3DSet2CFrame10 ; entry 30
    dw MetaSprites3DSet2CFrame10 ; entry 31

; frame 0 of MetaSprites3DSet2C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet2CFrame0::
    db $df, $01, $00, $00 ; entry 0
    db $df, $09, $01, $00 ; entry 1
    db $e7, $01, $02, $00 ; entry 2
    db $e7, $09, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites3DSet2C; ends with $80 (E-0147)
MetaSprites3DSet2CFrame1::
    db $dc, $05, $00, $00 ; entry 0
    db $dc, $0d, $01, $00 ; entry 1
    db $e4, $05, $02, $00 ; entry 2
    db $e4, $0d, $03, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites3DSet2C; ends with $80 (E-0147)
MetaSprites3DSet2CFrame2::
    db $da, $fe, $00, $00 ; entry 0
    db $da, $06, $01, $00 ; entry 1
    db $e2, $fe, $02, $00 ; entry 2
    db $e2, $06, $03, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites3DSet2C; ends with $80 (E-0147)
MetaSprites3DSet2CFrame3::
    db $d6, $02, $00, $00 ; entry 0
    db $d6, $0a, $01, $00 ; entry 1
    db $de, $02, $02, $00 ; entry 2
    db $de, $0a, $03, $00 ; entry 3
    db $80 ; end

; frame 4 of MetaSprites3DSet2C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet2CFrame4::
    db $d5, $07, $00, $00 ; entry 0
    db $d5, $0f, $01, $00 ; entry 1
    db $dd, $07, $02, $00 ; entry 2
    db $dd, $0f, $03, $00 ; entry 3
    db $80 ; end

; frame 5 of MetaSprites3DSet2C; ends with $80 (E-0147)
MetaSprites3DSet2CFrame5::
    db $d4, $0b, $00, $00 ; entry 0
    db $d4, $13, $01, $00 ; entry 1
    db $dc, $0b, $02, $00 ; entry 2
    db $dc, $13, $03, $00 ; entry 3
    db $80 ; end

; frame 6 of MetaSprites3DSet2C; ends with $80 (E-0147)
MetaSprites3DSet2CFrame6::
    db $d2, $0a, $00, $00 ; entry 0
    db $d2, $12, $01, $00 ; entry 1
    db $da, $0a, $02, $00 ; entry 2
    db $da, $12, $03, $00 ; entry 3
    db $80 ; end

; frame 7 of MetaSprites3DSet2C; ends with $80 (E-0147)
MetaSprites3DSet2CFrame7::
    db $d1, $08, $00, $00 ; entry 0
    db $d1, $10, $01, $00 ; entry 1
    db $d9, $08, $02, $00 ; entry 2
    db $d9, $10, $03, $00 ; entry 3
    db $80 ; end

; frame 8 of MetaSprites3DSet2C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3DSet2CFrame8::
    db $d0, $0a, $00, $00 ; entry 0
    db $d0, $12, $01, $00 ; entry 1
    db $d8, $0a, $02, $00 ; entry 2
    db $d8, $12, $03, $00 ; entry 3
    db $80 ; end

; frame 9 of MetaSprites3DSet2C; ends with $80 (E-0147)
MetaSprites3DSet2CFrame9::
    db $d0, $0c, $00, $00 ; entry 0
    db $d0, $14, $01, $00 ; entry 1
    db $d8, $0c, $02, $00 ; entry 2
    db $d8, $14, $03, $00 ; entry 3
    db $80 ; end

; frame 10 of MetaSprites3DSet2C; ends with $80 (E-0147)
MetaSprites3DSet2CFrame10::
    db $80 ; end
    ds $8db, $00
