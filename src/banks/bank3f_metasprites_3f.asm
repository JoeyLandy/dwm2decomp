; ROM bank $3F: meta-sprite frames
; The annotated listing of this bank is build/listing/bank3f.asm.

SECTION "Bank 3F", ROMX[$4000], BANK[$3F]
    db $3f

; called from DrawEffectSpriteForEffectTileOffsetRange: may continue in
; DrawEffectSpriteAtEffectSpriteX_Bank3F; copies wBattlePartyCount to wLoadSlot; copies
; wBattleTarget & $04 to wBattleArg0; calls CarryUnlessBattleSlotOutSlotEmpty; calls
; SetEffectSpriteXForTargets; calls DrawEffectSpriteAtEffectSpriteX_Bank3F; decrements wLoadSlot;
; ...
DrawEffectSpriteForEffectTileOffsetRange_CarryUnlessBattleSlotOutSlotEmpty_SetLoadSlot::
    ld a, [wEffectTileOffset]
    cp $15
    jr nz, DrawEffectSpriteAtEffectSpriteX_Bank3F
    ld a, [wEffectFlags]
    bit 3, a
    jr z, DrawEffectSpriteAtEffectSpriteX_Bank3F
    ld a, [wBattlePartyCount]
    ld [wLoadSlot], a
    ld a, [wBattleTarget]
    and $04
    ld [wBattleArg0], a
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .skip
    farcall SetEffectSpriteXForTargets
    call DrawEffectSpriteAtEffectSpriteX_Bank3F

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
    call DrawEffectSpriteAtEffectSpriteX_Bank3F

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
DrawEffectSpriteAtEffectSpriteX_Bank3F::
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
    ld de, MetaSprites3FTable
    call BuildOamFromSpriteTable_Bank3F
    ret

; the caller of BuildOamFromSpriteTable_Bank3F passes DE = $MetaSprites3FTable; the builder takes
; the word at DE + 2 * hSpriteSetIndex as the set and the word at set + 2 * hSpriteSubIndex as the
; frame; 32 words, up to the next code or data (E-0147, C1)
; record: meta-sprite set
MetaSprites3FTable::
    dw MetaSprites3FSet00 ; id 0
    dw MetaSprites3FSet00 ; id 1
    dw MetaSprites3FSet00 ; id 2
    dw MetaSprites3FSet00 ; id 3
    dw MetaSprites3FSet00 ; id 4
    dw MetaSprites3FSet00 ; id 5
    dw MetaSprites3FSet00 ; id 6
    dw MetaSprites3FSet00 ; id 7
    dw MetaSprites3FSet00 ; id 8
    dw MetaSprites3FSet00 ; id 9
    dw MetaSprites3FSet00 ; id 10
    dw MetaSprites3FSet00 ; id 11
    dw MetaSprites3FSet00 ; id 12
    dw MetaSprites3FSet00 ; id 13
    dw MetaSprites3FSet00 ; id 14
    dw MetaSprites3FSet0F ; id 15
    dw MetaSprites3FSet10 ; id 16
    dw MetaSprites3FSet11 ; id 17
    dw MetaSprites3FSet12 ; id 18
    dw MetaSprites3FSet13 ; id 19
    dw MetaSprites3FSet14 ; id 20
    dw MetaSprites3FSet15 ; id 21
    dw MetaSprites3FSet16 ; id 22
    dw MetaSprites3FSet17 ; id 23
    dw MetaSprites3FSet18 ; id 24
    dw MetaSprites3FSet19 ; id 25
    dw MetaSprites3FSet1A ; id 26
    dw MetaSprites3FSet1B ; id 27
    dw MetaSprites3FSet1C ; id 28
    dw MetaSprites3FSet1D ; id 29
    dw MetaSprites3FSet1E ; id 30
    dw MetaSprites3FSet1F ; id 31

; DE = two-level table; entries are chosen by hSpriteSetIndex and hSpriteSubIndex; writes 4-byte OAM
; entries at $C000 + 4 * hOamNextEntry (Y = hSpriteOriginY + b + $10, X = hSpriteOriginX + b + 8,
; tile += hSpriteTileOffset, flags ^= hSpriteAttrXor) until a $80 byte or hOamNextEntry reaches $28
; (40 entries) (the same 81 bytes appear in 5 banks)
BuildOamFromSpriteTable_Bank3F::
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

; meta-sprite set 0 of MetaSprites3FTable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3FSet00::
    dw MetaSprites3FSet00Frame0 ; entry 0
    dw MetaSprites3FSet00Frame1 ; entry 1
    dw MetaSprites3FSet00Frame2 ; entry 2
    dw MetaSprites3FSet00Frame3 ; entry 3
    dw MetaSprites3FSet00Frame4 ; entry 4
    dw MetaSprites3FSet00Frame5 ; entry 5
    dw MetaSprites3FSet00Frame6 ; entry 6
    dw MetaSprites3FSet00Frame7 ; entry 7
    dw MetaSprites3FSet00Frame8 ; entry 8
    dw MetaSprites3FSet00Frame9 ; entry 9
    dw MetaSprites3FSet00Frame10 ; entry 10
    dw MetaSprites3FSet00Frame11 ; entry 11
    dw MetaSprites3FSet00Frame12 ; entry 12
    dw MetaSprites3FSet00Frame13 ; entry 13
    dw MetaSprites3FSet00Frame13 ; entry 14
    dw MetaSprites3FSet00Frame13 ; entry 15
    dw MetaSprites3FSet00Frame13 ; entry 16
    dw MetaSprites3FSet00Frame13 ; entry 17
    dw MetaSprites3FSet00Frame13 ; entry 18
    dw MetaSprites3FSet00Frame13 ; entry 19
    dw MetaSprites3FSet00Frame13 ; entry 20
    dw MetaSprites3FSet00Frame13 ; entry 21
    dw MetaSprites3FSet00Frame13 ; entry 22
    dw MetaSprites3FSet00Frame13 ; entry 23
    dw MetaSprites3FSet00Frame13 ; entry 24
    dw MetaSprites3FSet00Frame13 ; entry 25
    dw MetaSprites3FSet00Frame13 ; entry 26
    dw MetaSprites3FSet00Frame13 ; entry 27
    dw MetaSprites3FSet00Frame13 ; entry 28
    dw MetaSprites3FSet00Frame13 ; entry 29
    dw MetaSprites3FSet00Frame13 ; entry 30
    dw MetaSprites3FSet00Frame13 ; entry 31

; frame 0 of MetaSprites3FSet00; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet00Frame0::
    db $d0, $d0, $03, $00 ; entry 0
    db $d8, $b8, $0f, $00 ; entry 1
    db $e3, $c1, $0f, $00 ; entry 2
    db $e8, $b9, $03, $00 ; entry 3
    db $d8, $d9, $03, $00 ; entry 4
    db $d4, $c8, $03, $00 ; entry 5
    db $f4, $d4, $03, $40 ; entry 6
    db $f5, $c2, $03, $40 ; entry 7
    db $d0, $b0, $12, $00 ; entry 8
    db $d0, $c0, $12, $00 ; entry 9
    db $e0, $b4, $12, $00 ; entry 10
    db $e8, $f8, $05, $20 ; entry 11
    db $f0, $e8, $05, $20 ; entry 12
    db $d8, $e8, $04, $00 ; entry 13
    db $e0, $d0, $05, $00 ; entry 14
    db $e8, $c9, $05, $00 ; entry 15
    db $e8, $d8, $07, $20 ; entry 16
    db $e0, $f0, $07, $20 ; entry 17
    db $f5, $28, $03, $60 ; entry 18
    db $ed, $40, $0f, $60 ; entry 19
    db $e2, $37, $0f, $60 ; entry 20
    db $dd, $3f, $03, $60 ; entry 21
    db $ed, $1f, $03, $60 ; entry 22
    db $f1, $30, $03, $60 ; entry 23
    db $d1, $24, $03, $20 ; entry 24
    db $d0, $36, $03, $20 ; entry 25
    db $f5, $48, $12, $60 ; entry 26
    db $f5, $38, $12, $60 ; entry 27
    db $e5, $44, $12, $60 ; entry 28
    db $dd, $00, $05, $40 ; entry 29
    db $d5, $10, $05, $40 ; entry 30
    db $ed, $10, $04, $60 ; entry 31
    db $e5, $28, $05, $60 ; entry 32
    db $dd, $2f, $05, $60 ; entry 33
    db $dd, $20, $07, $40 ; entry 34
    db $e5, $08, $07, $40 ; entry 35
    db $80 ; end

; frame 1 of MetaSprites3FSet00; ends with $80 (E-0147)
MetaSprites3FSet00Frame1::
    db $e0, $bc, $0f, $00 ; entry 0
    db $d8, $c4, $12, $00 ; entry 1
    db $e0, $cc, $03, $00 ; entry 2
    db $d3, $d4, $03, $00 ; entry 3
    db $f8, $c6, $03, $40 ; entry 4
    db $f8, $f2, $05, $20 ; entry 5
    db $e8, $fc, $08, $60 ; entry 6
    db $e4, $f4, $09, $20 ; entry 7
    db $f0, $e9, $05, $40 ; entry 8
    db $dc, $b0, $13, $00 ; entry 9
    db $e8, $b8, $13, $00 ; entry 10
    db $f8, $e0, $02, $00 ; entry 11
    db $eb, $c8, $10, $00 ; entry 12
    db $f0, $bd, $01, $00 ; entry 13
    db $e0, $e9, $07, $00 ; entry 14
    db $dd, $dc, $00, $00 ; entry 15
    db $e7, $d5, $03, $00 ; entry 16
    db $f0, $d8, $01, $00 ; entry 17
    db $e8, $3c, $0f, $60 ; entry 18
    db $f0, $34, $12, $60 ; entry 19
    db $e8, $2c, $03, $60 ; entry 20
    db $f5, $24, $03, $60 ; entry 21
    db $d0, $32, $03, $20 ; entry 22
    db $d0, $06, $05, $40 ; entry 23
    db $e0, $fc, $08, $00 ; entry 24
    db $e4, $04, $09, $40 ; entry 25
    db $d8, $0f, $05, $20 ; entry 26
    db $ec, $48, $13, $60 ; entry 27
    db $e0, $40, $13, $60 ; entry 28
    db $d0, $18, $02, $60 ; entry 29
    db $dd, $30, $10, $60 ; entry 30
    db $d8, $3b, $01, $60 ; entry 31
    db $e8, $0f, $07, $60 ; entry 32
    db $eb, $1c, $00, $60 ; entry 33
    db $e1, $23, $03, $60 ; entry 34
    db $d8, $20, $01, $60 ; entry 35
    db $80 ; end

; frame 2 of MetaSprites3FSet00; ends with $80 (E-0147)
MetaSprites3FSet00Frame2::
    db $f3, $cd, $10, $00 ; entry 0
    db $f8, $c4, $01, $00 ; entry 1
    db $e8, $d1, $03, $00 ; entry 2
    db $f0, $da, $03, $00 ; entry 3
    db $e8, $fc, $06, $60 ; entry 4
    db $f0, $f8, $08, $00 ; entry 5
    db $f8, $f4, $07, $00 ; entry 6
    db $e4, $f4, $07, $00 ; entry 7
    db $f8, $e6, $03, $40 ; entry 8
    db $ec, $f0, $05, $40 ; entry 9
    db $e8, $e0, $02, $00 ; entry 10
    db $e4, $e8, $07, $00 ; entry 11
    db $f0, $b7, $10, $00 ; entry 12
    db $d0, $b0, $12, $00 ; entry 13
    db $d8, $e0, $0f, $00 ; entry 14
    db $e8, $c1, $10, $00 ; entry 15
    db $e0, $ce, $01, $00 ; entry 16
    db $f8, $d5, $11, $00 ; entry 17
    db $d5, $2b, $10, $60 ; entry 18
    db $d0, $34, $01, $60 ; entry 19
    db $e0, $27, $03, $60 ; entry 20
    db $d8, $1e, $03, $60 ; entry 21
    db $e0, $fc, $06, $00 ; entry 22
    db $d8, $00, $08, $60 ; entry 23
    db $d0, $04, $07, $60 ; entry 24
    db $e4, $04, $07, $60 ; entry 25
    db $d0, $12, $03, $20 ; entry 26
    db $dc, $08, $05, $20 ; entry 27
    db $e0, $18, $02, $60 ; entry 28
    db $e4, $10, $07, $60 ; entry 29
    db $d8, $41, $10, $60 ; entry 30
    db $f8, $48, $12, $60 ; entry 31
    db $f0, $18, $0f, $60 ; entry 32
    db $e0, $37, $10, $60 ; entry 33
    db $e8, $2a, $01, $60 ; entry 34
    db $d0, $23, $11, $60 ; entry 35
    db $80 ; end

; frame 3 of MetaSprites3FSet00; ends with $80 (E-0147)
MetaSprites3FSet00Frame3::
    db $e8, $f5, $07, $00 ; entry 0
    db $f8, $da, $01, $00 ; entry 1
    db $f8, $cb, $10, $00 ; entry 2
    db $e8, $fd, $0a, $60 ; entry 3
    db $f0, $05, $08, $40 ; entry 4
    db $f0, $fd, $06, $20 ; entry 5
    db $e8, $ed, $09, $00 ; entry 6
    db $e8, $d9, $02, $00 ; entry 7
    db $f8, $f8, $05, $40 ; entry 8
    db $f8, $02, $05, $40 ; entry 9
    db $f0, $f0, $06, $20 ; entry 10
    db $f8, $eb, $03, $40 ; entry 11
    db $f3, $e3, $0f, $00 ; entry 12
    db $e8, $e1, $07, $00 ; entry 13
    db $e0, $e7, $00, $00 ; entry 14
    db $e0, $d6, $03, $00 ; entry 15
    db $f0, $d5, $03, $00 ; entry 16
    db $e0, $c9, $0f, $00 ; entry 17
    db $e0, $03, $07, $60 ; entry 18
    db $d0, $1e, $01, $60 ; entry 19
    db $d0, $2d, $10, $60 ; entry 20
    db $e0, $fb, $0a, $00 ; entry 21
    db $d8, $f3, $08, $20 ; entry 22
    db $d8, $fb, $06, $40 ; entry 23
    db $e0, $0b, $09, $60 ; entry 24
    db $e0, $1f, $02, $60 ; entry 25
    db $d0, $00, $05, $20 ; entry 26
    db $d0, $f6, $05, $20 ; entry 27
    db $d8, $08, $06, $40 ; entry 28
    db $d0, $0d, $03, $20 ; entry 29
    db $d5, $15, $0f, $60 ; entry 30
    db $e0, $17, $07, $60 ; entry 31
    db $d8, $23, $03, $60 ; entry 32
    db $e8, $11, $00, $60 ; entry 33
    db $e8, $22, $03, $60 ; entry 34
    db $e8, $2f, $0f, $60 ; entry 35
    db $f0, $1a, $06, $00 ; entry 36
    db $f0, $38, $12, $00 ; entry 37
    db $d8, $de, $06, $60 ; entry 38
    db $d8, $c0, $12, $60 ; entry 39
    db $80 ; end

; frame 4 of MetaSprites3FSet00; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet00Frame4::
    db $d8, $b8, $0f, $00 ; entry 0
    db $e3, $c1, $0f, $00 ; entry 1
    db $d4, $c8, $03, $00 ; entry 2
    db $d0, $b0, $12, $00 ; entry 3
    db $d0, $c0, $12, $00 ; entry 4
    db $e0, $b4, $12, $00 ; entry 5
    db $f0, $40, $0f, $60 ; entry 6
    db $e5, $37, $0f, $60 ; entry 7
    db $f4, $30, $03, $60 ; entry 8
    db $f8, $48, $12, $60 ; entry 9
    db $f8, $38, $12, $60 ; entry 10
    db $e8, $44, $12, $60 ; entry 11
    db $f8, $fb, $03, $40 ; entry 12
    db $f8, $f3, $0f, $00 ; entry 13
    db $f0, $f3, $07, $00 ; entry 14
    db $e8, $03, $05, $00 ; entry 15
    db $e8, $fb, $08, $40 ; entry 16
    db $f8, $05, $06, $20 ; entry 17
    db $f0, $fb, $09, $00 ; entry 18
    db $e8, $eb, $02, $00 ; entry 19
    db $e8, $0b, $00, $60 ; entry 20
    db $e8, $f3, $09, $20 ; entry 21
    db $f0, $03, $05, $20 ; entry 22
    db $f0, $0b, $08, $20 ; entry 23
    db $e0, $ed, $00, $00 ; entry 24
    db $d0, $fd, $03, $20 ; entry 25
    db $d0, $05, $0f, $60 ; entry 26
    db $d8, $05, $07, $60 ; entry 27
    db $e0, $f5, $05, $60 ; entry 28
    db $e0, $fd, $08, $20 ; entry 29
    db $d0, $f3, $06, $40 ; entry 30
    db $d8, $fd, $09, $60 ; entry 31
    db $e0, $05, $09, $40 ; entry 32
    db $d8, $f5, $05, $40 ; entry 33
    db $d8, $ed, $08, $40 ; entry 34
    db $e0, $0d, $02, $60 ; entry 35
    db $d0, $e8, $0a, $00 ; entry 36
    db $f8, $10, $0a, $60 ; entry 37
    db $f8, $1a, $06, $60 ; entry 38
    db $d0, $de, $06, $00 ; entry 39
    db $80 ; end

; frame 5 of MetaSprites3FSet00; ends with $80 (E-0147)
MetaSprites3FSet00Frame5::
    db $df, $fd, $08, $00 ; entry 0
    db $df, $06, $07, $60 ; entry 1
    db $df, $f4, $05, $00 ; entry 2
    db $df, $eb, $03, $00 ; entry 3
    db $df, $0f, $02, $00 ; entry 4
    db $d6, $f4, $05, $20 ; entry 5
    db $d6, $fd, $07, $00 ; entry 6
    db $d6, $06, $09, $40 ; entry 7
    db $f2, $04, $05, $40 ; entry 8
    db $e9, $fb, $08, $60 ; entry 9
    db $e9, $f2, $07, $00 ; entry 10
    db $e9, $04, $05, $60 ; entry 11
    db $e9, $0d, $03, $60 ; entry 12
    db $f2, $fb, $07, $60 ; entry 13
    db $f2, $f2, $09, $20 ; entry 14
    db $e9, $e9, $02, $60 ; entry 15
    db $80 ; end

; frame 6 of MetaSprites3FSet00; ends with $80 (E-0147)
MetaSprites3FSet00Frame6::
    db $d0, $d0, $0b, $20 ; entry 0
    db $d8, $ce, $0c, $20 ; entry 1
    db $e0, $cc, $0b, $20 ; entry 2
    db $e8, $cc, $0c, $20 ; entry 3
    db $f0, $ce, $0b, $20 ; entry 4
    db $f8, $d0, $0c, $20 ; entry 5
    db $d0, $b0, $0b, $20 ; entry 6
    db $d8, $b0, $0c, $20 ; entry 7
    db $e0, $b0, $0b, $20 ; entry 8
    db $e8, $b0, $0c, $20 ; entry 9
    db $f0, $b0, $0b, $20 ; entry 10
    db $f8, $b0, $0c, $20 ; entry 11
    db $d0, $c0, $0c, $20 ; entry 12
    db $d8, $be, $0b, $20 ; entry 13
    db $e0, $bc, $0c, $20 ; entry 14
    db $e8, $bc, $0b, $20 ; entry 15
    db $f0, $be, $0c, $20 ; entry 16
    db $f8, $c0, $0b, $20 ; entry 17
    db $d0, $28, $0b, $00 ; entry 18
    db $d8, $2a, $0c, $00 ; entry 19
    db $e0, $2c, $0b, $00 ; entry 20
    db $e8, $2c, $0c, $00 ; entry 21
    db $f0, $2a, $0b, $00 ; entry 22
    db $f8, $28, $0c, $00 ; entry 23
    db $d0, $48, $0b, $00 ; entry 24
    db $d8, $48, $0c, $00 ; entry 25
    db $e0, $48, $0b, $00 ; entry 26
    db $e8, $48, $0c, $00 ; entry 27
    db $f0, $48, $0b, $00 ; entry 28
    db $f8, $48, $0c, $00 ; entry 29
    db $d0, $38, $0c, $00 ; entry 30
    db $d8, $3a, $0b, $00 ; entry 31
    db $e0, $3c, $0c, $00 ; entry 32
    db $e8, $3c, $0b, $00 ; entry 33
    db $f0, $3a, $0c, $00 ; entry 34
    db $f8, $38, $0b, $00 ; entry 35
    db $80 ; end

; frame 7 of MetaSprites3FSet00; ends with $80 (E-0147)
MetaSprites3FSet00Frame7::
    db $d0, $d8, $0c, $20 ; entry 0
    db $d8, $d6, $0b, $20 ; entry 1
    db $e0, $d4, $0c, $20 ; entry 2
    db $e8, $d4, $0b, $20 ; entry 3
    db $f0, $d6, $0c, $20 ; entry 4
    db $f8, $d8, $0b, $20 ; entry 5
    db $d0, $c8, $0b, $20 ; entry 6
    db $d8, $c6, $0c, $20 ; entry 7
    db $e0, $c4, $0b, $20 ; entry 8
    db $e8, $c4, $0c, $20 ; entry 9
    db $f0, $c6, $0b, $20 ; entry 10
    db $f8, $c8, $0c, $20 ; entry 11
    db $d0, $b8, $0c, $20 ; entry 12
    db $d8, $b6, $0b, $20 ; entry 13
    db $e0, $b4, $0c, $20 ; entry 14
    db $e8, $b4, $0b, $20 ; entry 15
    db $f0, $b6, $0c, $20 ; entry 16
    db $f8, $b8, $0b, $20 ; entry 17
    db $d0, $20, $0c, $00 ; entry 18
    db $d8, $22, $0b, $00 ; entry 19
    db $e0, $24, $0c, $00 ; entry 20
    db $e8, $24, $0b, $00 ; entry 21
    db $f0, $22, $0c, $00 ; entry 22
    db $f8, $20, $0b, $00 ; entry 23
    db $d0, $30, $0b, $00 ; entry 24
    db $d8, $32, $0c, $00 ; entry 25
    db $e0, $34, $0b, $00 ; entry 26
    db $e8, $34, $0c, $00 ; entry 27
    db $f0, $32, $0b, $00 ; entry 28
    db $f8, $30, $0c, $00 ; entry 29
    db $d0, $40, $0c, $00 ; entry 30
    db $d8, $42, $0b, $00 ; entry 31
    db $e0, $44, $0c, $00 ; entry 32
    db $e8, $44, $0b, $00 ; entry 33
    db $f0, $42, $0c, $00 ; entry 34
    db $f8, $40, $0b, $00 ; entry 35
    db $80 ; end

; frame 8 of MetaSprites3FSet00; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet00Frame8::
    db $d0, $e0, $0b, $20 ; entry 0
    db $d8, $de, $0c, $20 ; entry 1
    db $e0, $dc, $0b, $20 ; entry 2
    db $e8, $dc, $0c, $20 ; entry 3
    db $f0, $de, $0b, $20 ; entry 4
    db $f8, $e0, $0c, $20 ; entry 5
    db $d0, $d0, $0c, $20 ; entry 6
    db $d8, $ce, $0b, $20 ; entry 7
    db $e0, $cc, $0c, $20 ; entry 8
    db $e8, $cc, $0b, $20 ; entry 9
    db $f0, $ce, $0c, $20 ; entry 10
    db $f8, $d0, $0b, $20 ; entry 11
    db $d0, $c0, $0b, $20 ; entry 12
    db $d8, $be, $0c, $20 ; entry 13
    db $e0, $bc, $0b, $20 ; entry 14
    db $e8, $bc, $0c, $20 ; entry 15
    db $f0, $be, $0b, $20 ; entry 16
    db $f8, $c0, $0c, $20 ; entry 17
    db $d0, $38, $0b, $00 ; entry 18
    db $d8, $3a, $0c, $00 ; entry 19
    db $e0, $3c, $0b, $00 ; entry 20
    db $e8, $3c, $0c, $00 ; entry 21
    db $f0, $3a, $0b, $00 ; entry 22
    db $f8, $38, $0c, $00 ; entry 23
    db $d0, $18, $0b, $00 ; entry 24
    db $d8, $1a, $0c, $00 ; entry 25
    db $e0, $1c, $0b, $00 ; entry 26
    db $e8, $1c, $0c, $00 ; entry 27
    db $f0, $1a, $0b, $00 ; entry 28
    db $f8, $18, $0c, $00 ; entry 29
    db $d0, $28, $0c, $00 ; entry 30
    db $d8, $2a, $0b, $00 ; entry 31
    db $e0, $2c, $0c, $00 ; entry 32
    db $e8, $2c, $0b, $00 ; entry 33
    db $f0, $2a, $0c, $00 ; entry 34
    db $f8, $28, $0b, $00 ; entry 35
    db $80 ; end

; frame 9 of MetaSprites3FSet00; ends with $80 (E-0147)
MetaSprites3FSet00Frame9::
    db $d0, $e8, $0c, $20 ; entry 0
    db $d8, $e6, $0b, $20 ; entry 1
    db $e0, $e4, $0c, $20 ; entry 2
    db $e8, $e4, $0b, $20 ; entry 3
    db $f0, $e6, $0c, $20 ; entry 4
    db $f8, $e8, $0b, $20 ; entry 5
    db $d0, $d8, $0b, $20 ; entry 6
    db $d8, $d6, $0c, $20 ; entry 7
    db $e0, $d4, $0b, $20 ; entry 8
    db $e8, $d4, $0c, $20 ; entry 9
    db $f0, $d6, $0b, $20 ; entry 10
    db $f8, $d8, $0c, $20 ; entry 11
    db $d0, $c8, $0c, $20 ; entry 12
    db $d8, $c6, $0b, $20 ; entry 13
    db $e0, $c4, $0c, $20 ; entry 14
    db $e8, $c4, $0b, $20 ; entry 15
    db $f0, $c6, $0c, $20 ; entry 16
    db $f8, $c8, $0b, $20 ; entry 17
    db $d0, $30, $0c, $00 ; entry 18
    db $d8, $32, $0b, $00 ; entry 19
    db $e0, $34, $0c, $00 ; entry 20
    db $e8, $34, $0b, $00 ; entry 21
    db $f0, $32, $0c, $00 ; entry 22
    db $f8, $30, $0b, $00 ; entry 23
    db $d0, $20, $0b, $00 ; entry 24
    db $d8, $22, $0c, $00 ; entry 25
    db $e0, $24, $0b, $00 ; entry 26
    db $e8, $24, $0c, $00 ; entry 27
    db $f0, $22, $0b, $00 ; entry 28
    db $f8, $20, $0c, $00 ; entry 29
    db $d0, $10, $0c, $00 ; entry 30
    db $d8, $12, $0b, $00 ; entry 31
    db $e0, $14, $0c, $00 ; entry 32
    db $e8, $14, $0b, $00 ; entry 33
    db $f0, $12, $0c, $00 ; entry 34
    db $f8, $10, $0b, $00 ; entry 35
    db $80 ; end

; frame 10 of MetaSprites3FSet00; ends with $80 (E-0147)
MetaSprites3FSet00Frame10::
    db $d0, $f0, $0b, $20 ; entry 0
    db $d8, $ec, $0c, $20 ; entry 1
    db $e0, $e8, $0b, $20 ; entry 2
    db $e8, $e8, $0c, $20 ; entry 3
    db $f0, $ec, $0b, $20 ; entry 4
    db $f8, $f0, $0c, $20 ; entry 5
    db $d0, $e0, $0c, $20 ; entry 6
    db $d8, $dc, $0b, $20 ; entry 7
    db $e0, $d8, $0c, $20 ; entry 8
    db $e8, $d8, $0b, $20 ; entry 9
    db $f0, $dc, $0c, $20 ; entry 10
    db $f8, $e0, $0b, $20 ; entry 11
    db $d0, $d0, $0b, $20 ; entry 12
    db $d8, $cc, $0c, $20 ; entry 13
    db $e0, $c8, $0b, $20 ; entry 14
    db $e8, $c8, $0c, $20 ; entry 15
    db $f0, $cc, $0b, $20 ; entry 16
    db $f8, $d0, $0c, $20 ; entry 17
    db $d0, $28, $0b, $00 ; entry 18
    db $d8, $2c, $0c, $00 ; entry 19
    db $e0, $30, $0b, $00 ; entry 20
    db $e8, $30, $0c, $00 ; entry 21
    db $f0, $2c, $0b, $00 ; entry 22
    db $f8, $28, $0c, $00 ; entry 23
    db $d0, $18, $0c, $00 ; entry 24
    db $d8, $1c, $0b, $00 ; entry 25
    db $e0, $20, $0c, $00 ; entry 26
    db $e8, $20, $0b, $00 ; entry 27
    db $f0, $1c, $0c, $00 ; entry 28
    db $f8, $18, $0b, $00 ; entry 29
    db $d0, $08, $0b, $00 ; entry 30
    db $d8, $0c, $0c, $00 ; entry 31
    db $e0, $10, $0b, $00 ; entry 32
    db $e8, $10, $0c, $00 ; entry 33
    db $f0, $0c, $0b, $00 ; entry 34
    db $f8, $08, $0c, $00 ; entry 35
    db $80 ; end

; frame 11 of MetaSprites3FSet00; ends with $80 (E-0147)
MetaSprites3FSet00Frame11::
    db $d0, $f8, $0c, $20 ; entry 0
    db $d8, $f8, $0b, $20 ; entry 1
    db $e0, $f8, $0c, $20 ; entry 2
    db $e8, $f8, $0b, $20 ; entry 3
    db $f0, $f8, $0c, $20 ; entry 4
    db $f8, $f8, $0b, $20 ; entry 5
    db $d0, $e8, $0b, $20 ; entry 6
    db $d8, $e4, $0c, $20 ; entry 7
    db $e0, $e0, $0b, $20 ; entry 8
    db $e8, $e0, $0c, $20 ; entry 9
    db $f0, $e4, $0b, $20 ; entry 10
    db $f8, $e8, $0c, $20 ; entry 11
    db $d0, $d8, $0c, $20 ; entry 12
    db $d8, $d4, $0b, $20 ; entry 13
    db $e0, $d0, $0c, $20 ; entry 14
    db $e8, $d0, $0b, $20 ; entry 15
    db $f0, $d4, $0c, $20 ; entry 16
    db $f8, $d8, $0b, $20 ; entry 17
    db $d0, $20, $0c, $00 ; entry 18
    db $d8, $24, $0b, $00 ; entry 19
    db $e0, $28, $0c, $00 ; entry 20
    db $e8, $28, $0b, $00 ; entry 21
    db $f0, $24, $0c, $00 ; entry 22
    db $f8, $20, $0b, $00 ; entry 23
    db $d0, $10, $0b, $00 ; entry 24
    db $d8, $14, $0c, $00 ; entry 25
    db $e0, $18, $0b, $00 ; entry 26
    db $e8, $18, $0c, $00 ; entry 27
    db $f0, $14, $0b, $00 ; entry 28
    db $f8, $10, $0c, $00 ; entry 29
    db $d0, $00, $0c, $00 ; entry 30
    db $d8, $00, $0b, $00 ; entry 31
    db $e0, $00, $0c, $00 ; entry 32
    db $e8, $00, $0b, $00 ; entry 33
    db $f0, $00, $0c, $00 ; entry 34
    db $f8, $00, $0b, $00 ; entry 35
    db $80 ; end

; frame 12 of MetaSprites3FSet00; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet00Frame12::
    db $d0, $ee, $0b, $20 ; entry 0
    db $d8, $ea, $0c, $20 ; entry 1
    db $e0, $e6, $0b, $20 ; entry 2
    db $e8, $e6, $0c, $20 ; entry 3
    db $f0, $ea, $0b, $20 ; entry 4
    db $f8, $ee, $0c, $20 ; entry 5
    db $d0, $0a, $0b, $00 ; entry 6
    db $d8, $0e, $0c, $00 ; entry 7
    db $e0, $12, $0b, $00 ; entry 8
    db $e8, $12, $0c, $00 ; entry 9
    db $f0, $0e, $0b, $00 ; entry 10
    db $f8, $0a, $0c, $00 ; entry 11
    db $d0, $fc, $0d, $00 ; entry 12
    db $d8, $fc, $0e, $00 ; entry 13
    db $e0, $fc, $0d, $00 ; entry 14
    db $e8, $fc, $0e, $00 ; entry 15
    db $f0, $fc, $0d, $00 ; entry 16
    db $f8, $fc, $0e, $00 ; entry 17
    db $80 ; end

; frame 13 of MetaSprites3FSet00; ends with $80 (E-0147)
MetaSprites3FSet00Frame13::
    db $80 ; end

; meta-sprite set 15 of MetaSprites3FTable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3FSet0F::
    dw MetaSprites3FSet0FFrame0 ; entry 0
    dw MetaSprites3FSet0FFrame1 ; entry 1
    dw MetaSprites3FSet0FFrame2 ; entry 2
    dw MetaSprites3FSet0FFrame3 ; entry 3
    dw MetaSprites3FSet0FFrame4 ; entry 4
    dw MetaSprites3FSet0FFrame5 ; entry 5
    dw MetaSprites3FSet0FFrame6 ; entry 6
    dw MetaSprites3FSet0FFrame7 ; entry 7
    dw MetaSprites3FSet0FFrame8 ; entry 8
    dw MetaSprites3FSet0FFrame8 ; entry 9
    dw MetaSprites3FSet0FFrame8 ; entry 10
    dw MetaSprites3FSet0FFrame8 ; entry 11
    dw MetaSprites3FSet0FFrame8 ; entry 12
    dw MetaSprites3FSet0FFrame8 ; entry 13
    dw MetaSprites3FSet0FFrame8 ; entry 14
    dw MetaSprites3FSet0FFrame8 ; entry 15
    dw MetaSprites3FSet0FFrame8 ; entry 16
    dw MetaSprites3FSet0FFrame8 ; entry 17
    dw MetaSprites3FSet0FFrame8 ; entry 18
    dw MetaSprites3FSet0FFrame8 ; entry 19
    dw MetaSprites3FSet0FFrame8 ; entry 20
    dw MetaSprites3FSet0FFrame8 ; entry 21
    dw MetaSprites3FSet0FFrame8 ; entry 22
    dw MetaSprites3FSet0FFrame8 ; entry 23
    dw MetaSprites3FSet0FFrame8 ; entry 24
    dw MetaSprites3FSet0FFrame8 ; entry 25
    dw MetaSprites3FSet0FFrame8 ; entry 26
    dw MetaSprites3FSet0FFrame8 ; entry 27
    dw MetaSprites3FSet0FFrame8 ; entry 28
    dw MetaSprites3FSet0FFrame8 ; entry 29
    dw MetaSprites3FSet0FFrame8 ; entry 30
    dw MetaSprites3FSet0FFrame8 ; entry 31

; frame 0 of MetaSprites3FSet0F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet0FFrame0::
    db $d0, $fc, $00, $00 ; entry 0
    db $80 ; end

; frame 1 of MetaSprites3FSet0F; ends with $80 (E-0147)
MetaSprites3FSet0FFrame1::
    db $d0, $fc, $03, $00 ; entry 0
    db $d8, $fc, $02, $00 ; entry 1
    db $80 ; end

; frame 2 of MetaSprites3FSet0F; ends with $80 (E-0147)
MetaSprites3FSet0FFrame2::
    db $d0, $f8, $0c, $00 ; entry 0
    db $d0, $00, $0d, $00 ; entry 1
    db $d7, $01, $05, $00 ; entry 2
    db $80 ; end

; frame 3 of MetaSprites3FSet0F; ends with $80 (E-0147)
MetaSprites3FSet0FFrame3::
    db $d0, $00, $16, $20 ; entry 0
    db $d0, $f8, $17, $20 ; entry 1
    db $d8, $00, $1c, $00 ; entry 2
    db $d8, $08, $1d, $00 ; entry 3
    db $e0, $fa, $18, $20 ; entry 4
    db $e0, $f2, $19, $20 ; entry 5
    db $e8, $f6, $05, $00 ; entry 6
    db $80 ; end

; frame 4 of MetaSprites3FSet0F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet0FFrame4::
    db $d0, $f8, $06, $00 ; entry 0
    db $d0, $00, $07, $00 ; entry 1
    db $d8, $f6, $08, $00 ; entry 2
    db $d8, $fe, $09, $00 ; entry 3
    db $e0, $f9, $0a, $00 ; entry 4
    db $e0, $01, $0b, $00 ; entry 5
    db $e8, $f4, $0c, $00 ; entry 6
    db $e8, $fc, $0d, $00 ; entry 7
    db $f0, $f4, $0e, $00 ; entry 8
    db $f0, $fc, $0f, $00 ; entry 9
    db $f8, $f9, $10, $00 ; entry 10
    db $f8, $01, $11, $00 ; entry 11
    db $f8, $04, $1e, $00 ; entry 12
    db $f8, $f8, $1e, $20 ; entry 13
    db $80 ; end

; frame 5 of MetaSprites3FSet0F; ends with $80 (E-0147)
MetaSprites3FSet0FFrame5::
    db $d0, $fa, $12, $00 ; entry 0
    db $d0, $02, $13, $00 ; entry 1
    db $d8, $fd, $14, $00 ; entry 2
    db $d8, $05, $15, $00 ; entry 3
    db $e0, $fd, $16, $00 ; entry 4
    db $e0, $05, $17, $00 ; entry 5
    db $e8, $fd, $18, $00 ; entry 6
    db $e8, $05, $19, $00 ; entry 7
    db $f0, $fd, $1a, $00 ; entry 8
    db $f0, $05, $1b, $00 ; entry 9
    db $f8, $fd, $1c, $00 ; entry 10
    db $f8, $05, $1d, $00 ; entry 11
    db $f8, $06, $1e, $00 ; entry 12
    db $f8, $f5, $1e, $20 ; entry 13
    db $80 ; end

; frame 6 of MetaSprites3FSet0F; ends with $80 (E-0147)
MetaSprites3FSet0FFrame6::
    db $d8, $0b, $08, $20 ; entry 0
    db $d8, $03, $09, $20 ; entry 1
    db $d0, $01, $18, $00 ; entry 2
    db $d0, $09, $19, $00 ; entry 3
    db $e0, $05, $14, $00 ; entry 4
    db $e0, $0d, $15, $00 ; entry 5
    db $e8, $06, $0c, $00 ; entry 6
    db $e8, $0e, $0d, $00 ; entry 7
    db $f0, $05, $0e, $00 ; entry 8
    db $f0, $0d, $0f, $00 ; entry 9
    db $f8, $04, $16, $00 ; entry 10
    db $f8, $0c, $17, $00 ; entry 11
    db $e8, $03, $0d, $20 ; entry 12
    db $f0, $fe, $0c, $00 ; entry 13
    db $f8, $11, $1e, $00 ; entry 14
    db $f8, $fd, $1e, $20 ; entry 15
    db $80 ; end

; frame 7 of MetaSprites3FSet0F; ends with $80 (E-0147)
MetaSprites3FSet0FFrame7::
    db $d0, $02, $0c, $20 ; entry 0
    db $d0, $fa, $0d, $20 ; entry 1
    db $d8, $f1, $16, $00 ; entry 2
    db $d8, $f9, $17, $00 ; entry 3
    db $e0, $f7, $16, $20 ; entry 4
    db $e0, $ef, $17, $20 ; entry 5
    db $e8, $f7, $18, $20 ; entry 6
    db $e8, $ef, $19, $20 ; entry 7
    db $f0, $f7, $1a, $20 ; entry 8
    db $f0, $ef, $1b, $20 ; entry 9
    db $f8, $f4, $14, $00 ; entry 10
    db $f8, $fc, $15, $00 ; entry 11
    db $e5, $fe, $06, $20 ; entry 12
    db $ed, $01, $05, $20 ; entry 13
    db $f8, $01, $1e, $00 ; entry 14
    db $f8, $ed, $1e, $20 ; entry 15
    db $80 ; end

; frame 8 of MetaSprites3FSet0F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet0FFrame8::
    db $80 ; end

; meta-sprite set 16 of MetaSprites3FTable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3FSet10::
    dw MetaSprites3FSet10Frame0 ; entry 0
    dw MetaSprites3FSet10Frame1 ; entry 1
    dw MetaSprites3FSet10Frame2 ; entry 2
    dw MetaSprites3FSet10Frame3 ; entry 3
    dw MetaSprites3FSet10Frame4 ; entry 4
    dw MetaSprites3FSet10Frame5 ; entry 5
    dw MetaSprites3FSet10Frame6 ; entry 6
    dw MetaSprites3FSet10Frame7 ; entry 7
    dw MetaSprites3FSet10Frame8 ; entry 8
    dw MetaSprites3FSet10Frame9 ; entry 9
    dw MetaSprites3FSet10Frame10 ; entry 10
    dw MetaSprites3FSet10Frame10 ; entry 11
    dw MetaSprites3FSet10Frame10 ; entry 12
    dw MetaSprites3FSet10Frame10 ; entry 13
    dw MetaSprites3FSet10Frame10 ; entry 14
    dw MetaSprites3FSet10Frame10 ; entry 15
    dw MetaSprites3FSet10Frame10 ; entry 16
    dw MetaSprites3FSet10Frame10 ; entry 17
    dw MetaSprites3FSet10Frame10 ; entry 18
    dw MetaSprites3FSet10Frame10 ; entry 19
    dw MetaSprites3FSet10Frame10 ; entry 20
    dw MetaSprites3FSet10Frame10 ; entry 21
    dw MetaSprites3FSet10Frame10 ; entry 22
    dw MetaSprites3FSet10Frame10 ; entry 23
    dw MetaSprites3FSet10Frame10 ; entry 24
    dw MetaSprites3FSet10Frame10 ; entry 25
    dw MetaSprites3FSet10Frame10 ; entry 26
    dw MetaSprites3FSet10Frame10 ; entry 27
    dw MetaSprites3FSet10Frame10 ; entry 28
    dw MetaSprites3FSet10Frame10 ; entry 29
    dw MetaSprites3FSet10Frame10 ; entry 30
    dw MetaSprites3FSet10Frame10 ; entry 31

; frame 0 of MetaSprites3FSet10; ends with $80 (E-0147)
MetaSprites3FSet10Frame0::
    db $d0, $fc, $00, $00 ; entry 0
    db $d0, $fd, $00, $20 ; entry 1
    db $80 ; end

; frame 1 of MetaSprites3FSet10; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet10Frame1::
    db $d0, $f8, $01, $00 ; entry 0
    db $d0, $00, $01, $20 ; entry 1
    db $80 ; end

; frame 2 of MetaSprites3FSet10; ends with $80 (E-0147)
MetaSprites3FSet10Frame2::
    db $d0, $fc, $00, $00 ; entry 0
    db $d0, $fd, $00, $20 ; entry 1
    db $d3, $fd, $03, $00 ; entry 2
    db $db, $fd, $02, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites3FSet10; ends with $80 (E-0147)
MetaSprites3FSet10Frame3::
    db $d0, $f8, $0c, $00 ; entry 0
    db $d0, $00, $0d, $00 ; entry 1
    db $d7, $01, $05, $00 ; entry 2
    db $80 ; end

; frame 4 of MetaSprites3FSet10; ends with $80 (E-0147)
MetaSprites3FSet10Frame4::
    db $d0, $00, $16, $20 ; entry 0
    db $d0, $f8, $17, $20 ; entry 1
    db $d8, $00, $18, $20 ; entry 2
    db $d8, $f8, $19, $20 ; entry 3
    db $e0, $fc, $18, $20 ; entry 4
    db $e0, $f4, $19, $20 ; entry 5
    db $e8, $f8, $05, $00 ; entry 6
    db $80 ; end

; frame 5 of MetaSprites3FSet10; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet10Frame5::
    db $d0, $01, $06, $20 ; entry 0
    db $d0, $f9, $07, $20 ; entry 1
    db $d8, $03, $08, $20 ; entry 2
    db $d8, $fb, $09, $20 ; entry 3
    db $e0, $00, $0a, $20 ; entry 4
    db $e0, $f8, $0b, $20 ; entry 5
    db $e8, $05, $0c, $20 ; entry 6
    db $e8, $fd, $0d, $20 ; entry 7
    db $f0, $05, $0e, $20 ; entry 8
    db $f0, $fd, $0f, $20 ; entry 9
    db $f8, $00, $10, $20 ; entry 10
    db $f8, $f8, $11, $20 ; entry 11
    db $f8, $f4, $21, $20 ; entry 12
    db $f8, $02, $21, $00 ; entry 13
    db $d0, $10, $22, $00 ; entry 14
    db $d0, $08, $22, $00 ; entry 15
    db $d8, $0b, $22, $00 ; entry 16
    db $d8, $10, $22, $00 ; entry 17
    db $e0, $10, $22, $00 ; entry 18
    db $e0, $08, $22, $00 ; entry 19
    db $e8, $10, $22, $00 ; entry 20
    db $f0, $10, $22, $00 ; entry 21
    db $f8, $10, $22, $00 ; entry 22
    db $f8, $0a, $22, $00 ; entry 23
    db $d0, $f0, $22, $20 ; entry 24
    db $d8, $f0, $22, $20 ; entry 25
    db $e0, $f0, $22, $20 ; entry 26
    db $e8, $f0, $22, $20 ; entry 27
    db $f0, $f0, $22, $20 ; entry 28
    db $f8, $f0, $22, $20 ; entry 29
    db $d0, $e8, $22, $20 ; entry 30
    db $d8, $e8, $22, $20 ; entry 31
    db $e0, $e8, $22, $20 ; entry 32
    db $e8, $e8, $22, $20 ; entry 33
    db $f0, $e8, $22, $20 ; entry 34
    db $f8, $e8, $22, $20 ; entry 35
    db $e8, $f5, $22, $20 ; entry 36
    db $f0, $f5, $22, $20 ; entry 37
    db $80 ; end

; frame 6 of MetaSprites3FSet10; ends with $80 (E-0147)
MetaSprites3FSet10Frame6::
    db $d0, $02, $0c, $20 ; entry 0
    db $d0, $fa, $0d, $20 ; entry 1
    db $d8, $f1, $16, $00 ; entry 2
    db $d8, $f9, $17, $00 ; entry 3
    db $e0, $f7, $16, $20 ; entry 4
    db $e0, $ef, $17, $20 ; entry 5
    db $e8, $f7, $18, $20 ; entry 6
    db $e8, $ef, $19, $20 ; entry 7
    db $f0, $f7, $1a, $20 ; entry 8
    db $f0, $ef, $1b, $20 ; entry 9
    db $e5, $fe, $06, $20 ; entry 10
    db $ed, $01, $05, $20 ; entry 11
    db $f8, $fc, $1e, $00 ; entry 12
    db $f8, $04, $1f, $00 ; entry 13
    db $f8, $f4, $1e, $20 ; entry 14
    db $f8, $ec, $1f, $20 ; entry 15
    db $80 ; end

; frame 7 of MetaSprites3FSet10; ends with $80 (E-0147)
MetaSprites3FSet10Frame7::
    db $d8, $0b, $08, $20 ; entry 0
    db $d8, $03, $09, $20 ; entry 1
    db $d0, $01, $18, $00 ; entry 2
    db $d0, $09, $19, $00 ; entry 3
    db $e0, $05, $14, $00 ; entry 4
    db $e0, $0d, $15, $00 ; entry 5
    db $e8, $06, $0c, $00 ; entry 6
    db $e8, $0e, $0d, $00 ; entry 7
    db $f0, $05, $0e, $00 ; entry 8
    db $f0, $0d, $0f, $00 ; entry 9
    db $e8, $03, $0d, $20 ; entry 10
    db $f0, $fe, $0c, $00 ; entry 11
    db $f8, $0c, $20, $00 ; entry 12
    db $f8, $04, $20, $20 ; entry 13
    db $f8, $fc, $21, $20 ; entry 14
    db $d0, $e8, $22, $00 ; entry 15
    db $d8, $e8, $22, $00 ; entry 16
    db $e0, $e8, $22, $00 ; entry 17
    db $e8, $e8, $22, $00 ; entry 18
    db $f0, $e9, $22, $00 ; entry 19
    db $f8, $e9, $22, $00 ; entry 20
    db $d0, $f0, $22, $00 ; entry 21
    db $d8, $f1, $22, $00 ; entry 22
    db $e0, $f2, $22, $00 ; entry 23
    db $e8, $f1, $22, $00 ; entry 24
    db $f0, $f3, $22, $00 ; entry 25
    db $f8, $f3, $22, $00 ; entry 26
    db $d0, $f8, $22, $00 ; entry 27
    db $d8, $fa, $22, $00 ; entry 28
    db $e8, $fa, $22, $00 ; entry 29
    db $e0, $fc, $22, $00 ; entry 30
    db $d0, $10, $22, $20 ; entry 31
    db $f8, $14, $1f, $00 ; entry 32
    db $80 ; end

; frame 8 of MetaSprites3FSet10; ends with $80 (E-0147)
MetaSprites3FSet10Frame8::
    db $f8, $00, $1f, $00 ; entry 0
    db $d0, $03, $14, $20 ; entry 1
    db $d0, $fb, $15, $20 ; entry 2
    db $d8, $09, $0a, $20 ; entry 3
    db $d8, $01, $0b, $20 ; entry 4
    db $f8, $0f, $1e, $00 ; entry 5
    db $f8, $17, $1f, $00 ; entry 6
    db $f8, $07, $1e, $20 ; entry 7
    db $e0, $08, $16, $40 ; entry 8
    db $e0, $10, $17, $40 ; entry 9
    db $e8, $11, $0c, $20 ; entry 10
    db $e8, $09, $0d, $20 ; entry 11
    db $f0, $10, $0e, $20 ; entry 12
    db $f0, $08, $0f, $20 ; entry 13
    db $e8, $fa, $14, $60 ; entry 14
    db $e8, $f2, $15, $60 ; entry 15
    db $f0, $fa, $10, $20 ; entry 16
    db $f0, $f2, $11, $20 ; entry 17
    db $f8, $f0, $20, $20 ; entry 18
    db $f8, $f8, $20, $00 ; entry 19
    db $f8, $00, $21, $00 ; entry 20
    db $d8, $fa, $09, $00 ; entry 21
    db $e0, $fb, $0a, $60 ; entry 22
    db $e0, $f3, $0b, $60 ; entry 23
    db $db, $f2, $1d, $60 ; entry 24
    db $f8, $e8, $21, $20 ; entry 25
    db $80 ; end

; frame 9 of MetaSprites3FSet10; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet10Frame9::
    db $d0, $fe, $10, $20 ; entry 0
    db $d0, $f6, $11, $20 ; entry 1
    db $d8, $f4, $12, $40 ; entry 2
    db $d8, $fc, $13, $40 ; entry 3
    db $e0, $ed, $1d, $60 ; entry 4
    db $e8, $f6, $10, $20 ; entry 5
    db $e8, $ee, $11, $20 ; entry 6
    db $f0, $f0, $18, $20 ; entry 7
    db $d8, $06, $14, $00 ; entry 8
    db $d8, $0e, $15, $00 ; entry 9
    db $e0, $0f, $10, $20 ; entry 10
    db $e0, $07, $11, $20 ; entry 11
    db $e8, $04, $06, $00 ; entry 12
    db $e8, $0c, $07, $00 ; entry 13
    db $f0, $01, $14, $00 ; entry 14
    db $f0, $09, $15, $00 ; entry 15
    db $f8, $10, $1f, $00 ; entry 16
    db $f8, $01, $1e, $20 ; entry 17
    db $f8, $09, $1e, $00 ; entry 18
    db $f0, $0c, $04, $00 ; entry 19
    db $f8, $10, $05, $20 ; entry 20
    db $e0, $fa, $05, $20 ; entry 21
    db $e0, $f5, $1c, $60 ; entry 22
    db $d0, $02, $12, $00 ; entry 23
    db $d0, $0a, $13, $00 ; entry 24
    db $f8, $f9, $1f, $20 ; entry 25
    db $f8, $f4, $20, $00 ; entry 26
    db $f8, $fc, $21, $00 ; entry 27
    db $f8, $ec, $20, $20 ; entry 28
    db $f0, $f8, $22, $00 ; entry 29
    db $f8, $e4, $1f, $20 ; entry 30
    db $d0, $e8, $22, $20 ; entry 31
    db $d8, $e8, $22, $20 ; entry 32
    db $e0, $e8, $22, $20 ; entry 33
    db $d0, $10, $22, $00 ; entry 34
    db $e8, $fd, $22, $00 ; entry 35
    db $f0, $e8, $0e, $00 ; entry 36
    db $80 ; end

; frame 10 of MetaSprites3FSet10; ends with $80 (E-0147)
MetaSprites3FSet10Frame10::
    db $80 ; end

; meta-sprite set 17 of MetaSprites3FTable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3FSet11::
    dw MetaSprites3FSet11Frame0 ; entry 0
    dw MetaSprites3FSet11Frame1 ; entry 1
    dw MetaSprites3FSet11Frame2 ; entry 2
    dw MetaSprites3FSet11Frame3 ; entry 3
    dw MetaSprites3FSet11Frame4 ; entry 4
    dw MetaSprites3FSet11Frame5 ; entry 5
    dw MetaSprites3FSet11Frame6 ; entry 6
    dw MetaSprites3FSet11Frame7 ; entry 7
    dw MetaSprites3FSet11Frame8 ; entry 8
    dw MetaSprites3FSet11Frame9 ; entry 9
    dw MetaSprites3FSet11Frame10 ; entry 10
    dw MetaSprites3FSet11Frame11 ; entry 11
    dw MetaSprites3FSet11Frame12 ; entry 12
    dw MetaSprites3FSet11Frame13 ; entry 13
    dw MetaSprites3FSet11Frame14 ; entry 14
    dw MetaSprites3FSet11Frame15 ; entry 15
    dw MetaSprites3FSet11Frame16 ; entry 16
    dw MetaSprites3FSet11Frame16 ; entry 17
    dw MetaSprites3FSet11Frame16 ; entry 18
    dw MetaSprites3FSet11Frame16 ; entry 19
    dw MetaSprites3FSet11Frame16 ; entry 20
    dw MetaSprites3FSet11Frame16 ; entry 21
    dw MetaSprites3FSet11Frame16 ; entry 22
    dw MetaSprites3FSet11Frame16 ; entry 23
    dw MetaSprites3FSet11Frame16 ; entry 24
    dw MetaSprites3FSet11Frame16 ; entry 25
    dw MetaSprites3FSet11Frame16 ; entry 26
    dw MetaSprites3FSet11Frame16 ; entry 27
    dw MetaSprites3FSet11Frame16 ; entry 28
    dw MetaSprites3FSet11Frame16 ; entry 29
    dw MetaSprites3FSet11Frame16 ; entry 30
    dw MetaSprites3FSet11Frame16 ; entry 31

; frame 0 of MetaSprites3FSet11; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet11Frame0::
    db $f8, $f8, $01, $40 ; entry 0
    db $f8, $00, $01, $60 ; entry 1
    db $d0, $f8, $01, $00 ; entry 2
    db $d0, $00, $01, $20 ; entry 3
    db $f0, $fe, $05, $60 ; entry 4
    db $d8, $fa, $05, $00 ; entry 5
    db $80 ; end

; frame 1 of MetaSprites3FSet11; ends with $80 (E-0147)
MetaSprites3FSet11Frame1::
    db $d0, $fc, $00, $00 ; entry 0
    db $d4, $fc, $2b, $00 ; entry 1
    db $f8, $fc, $00, $40 ; entry 2
    db $f4, $fc, $2b, $40 ; entry 3
    db $e7, $fc, $00, $00 ; entry 4
    db $e2, $fc, $00, $40 ; entry 5
    db $dc, $fc, $2f, $00 ; entry 6
    db $ed, $fc, $2f, $00 ; entry 7
    db $80 ; end

; frame 2 of MetaSprites3FSet11; ends with $80 (E-0147)
MetaSprites3FSet11Frame2::
    db $db, $0d, $1d, $00 ; entry 0
    db $ea, $07, $14, $20 ; entry 1
    db $f2, $06, $05, $00 ; entry 2
    db $db, $f4, $23, $40 ; entry 3
    db $e8, $f8, $01, $00 ; entry 4
    db $e0, $f8, $01, $40 ; entry 5
    db $e0, $00, $01, $60 ; entry 6
    db $e8, $00, $01, $20 ; entry 7
    db $ed, $f5, $24, $40 ; entry 8
    db $db, $05, $1c, $00 ; entry 9
    db $ee, $ed, $1d, $60 ; entry 10
    db $80 ; end

; frame 3 of MetaSprites3FSet11; ends with $80 (E-0147)
MetaSprites3FSet11Frame3::
    db $e8, $08, $06, $20 ; entry 0
    db $e8, $00, $02, $60 ; entry 1
    db $e0, $00, $03, $00 ; entry 2
    db $e8, $f8, $2c, $00 ; entry 3
    db $e8, $f0, $27, $00 ; entry 4
    db $dc, $08, $27, $60 ; entry 5
    db $f8, $fc, $2e, $00 ; entry 6
    db $f0, $fd, $2d, $00 ; entry 7
    db $e0, $f8, $2c, $40 ; entry 8
    db $e0, $f0, $0b, $20 ; entry 9
    db $d0, $fc, $2e, $60 ; entry 10
    db $d8, $fb, $2d, $60 ; entry 11
    db $80 ; end

; frame 4 of MetaSprites3FSet11; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet11Frame4::
    db $e0, $fb, $17, $60 ; entry 0
    db $e0, $03, $14, $60 ; entry 1
    db $d8, $03, $10, $60 ; entry 2
    db $e8, $fd, $17, $00 ; entry 3
    db $e8, $f5, $14, $00 ; entry 4
    db $f0, $f5, $10, $00 ; entry 5
    db $80 ; end

; frame 5 of MetaSprites3FSet11; ends with $80 (E-0147)
MetaSprites3FSet11Frame5::
    db $e4, $f8, $1e, $00 ; entry 0
    db $ec, $f8, $1f, $00 ; entry 1
    db $e4, $f0, $1c, $00 ; entry 2
    db $ec, $f0, $1d, $00 ; entry 3
    db $e4, $e8, $1f, $40 ; entry 4
    db $ec, $e6, $24, $20 ; entry 5
    db $f1, $e2, $0d, $20 ; entry 6
    db $e4, $00, $1e, $60 ; entry 7
    db $dc, $00, $1f, $60 ; entry 8
    db $e4, $08, $1c, $60 ; entry 9
    db $dc, $08, $1d, $60 ; entry 10
    db $e4, $10, $1f, $20 ; entry 11
    db $dc, $12, $24, $40 ; entry 12
    db $d7, $16, $0d, $40 ; entry 13
    db $80 ; end

; frame 6 of MetaSprites3FSet11; ends with $80 (E-0147)
MetaSprites3FSet11Frame6::
    db $e2, $f8, $18, $60 ; entry 0
    db $da, $f8, $19, $60 ; entry 1
    db $e1, $f0, $1a, $60 ; entry 2
    db $d9, $f0, $1b, $60 ; entry 3
    db $e6, $00, $18, $00 ; entry 4
    db $ee, $00, $19, $00 ; entry 5
    db $e7, $08, $1a, $00 ; entry 6
    db $ef, $08, $1b, $00 ; entry 7
    db $e8, $10, $1c, $00 ; entry 8
    db $f0, $10, $1d, $00 ; entry 9
    db $e9, $18, $1e, $00 ; entry 10
    db $f1, $18, $16, $40 ; entry 11
    db $e9, $20, $20, $00 ; entry 12
    db $e8, $28, $09, $00 ; entry 13
    db $f1, $20, $21, $00 ; entry 14
    db $f8, $28, $1c, $00 ; entry 15
    db $f8, $30, $15, $00 ; entry 16
    db $f0, $2a, $08, $00 ; entry 17
    db $df, $e0, $1e, $60 ; entry 18
    db $d7, $e0, $1e, $00 ; entry 19
    db $df, $d8, $20, $60 ; entry 20
    db $e0, $d0, $09, $60 ; entry 21
    db $e0, $e8, $1c, $60 ; entry 22
    db $d8, $e8, $1d, $60 ; entry 23
    db $d8, $ce, $08, $60 ; entry 24
    db $d7, $d8, $21, $60 ; entry 25
    db $d0, $d0, $1c, $60 ; entry 26
    db $d0, $c8, $15, $60 ; entry 27
    db $f8, $20, $1e, $60 ; entry 28
    db $d0, $d8, $1e, $00 ; entry 29
    db $80 ; end

; frame 7 of MetaSprites3FSet11; ends with $80 (E-0147)
MetaSprites3FSet11Frame7::
    db $d8, $02, $08, $20 ; entry 0
    db $d8, $fa, $09, $20 ; entry 1
    db $e0, $fc, $14, $00 ; entry 2
    db $e0, $04, $15, $00 ; entry 3
    db $e8, $fd, $0c, $00 ; entry 4
    db $e8, $05, $0d, $00 ; entry 5
    db $e8, $fa, $0d, $20 ; entry 6
    db $f0, $12, $0e, $20 ; entry 7
    db $f0, $0a, $0f, $20 ; entry 8
    db $f8, $0a, $09, $00 ; entry 9
    db $f8, $1a, $0b, $40 ; entry 10
    db $f8, $12, $0f, $20 ; entry 11
    db $f8, $02, $20, $00 ; entry 12
    db $f0, $f4, $11, $60 ; entry 13
    db $d0, $02, $0b, $40 ; entry 14
    db $d8, $f3, $16, $40 ; entry 15
    db $d0, $e7, $1c, $60 ; entry 16
    db $d0, $f7, $08, $20 ; entry 17
    db $d0, $ef, $09, $20 ; entry 18
    db $d0, $df, $2a, $20 ; entry 19
    db $d8, $df, $05, $00 ; entry 20
    db $f0, $1a, $0c, $60 ; entry 21
    db $80 ; end

; frame 8 of MetaSprites3FSet11; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet11Frame8::
    db $f0, $03, $08, $60 ; entry 0
    db $f0, $fb, $09, $60 ; entry 1
    db $e8, $fd, $14, $40 ; entry 2
    db $e8, $05, $15, $40 ; entry 3
    db $e0, $fe, $0c, $40 ; entry 4
    db $e0, $06, $0d, $40 ; entry 5
    db $e0, $fb, $0d, $60 ; entry 6
    db $d8, $13, $0e, $60 ; entry 7
    db $d8, $0b, $0f, $60 ; entry 8
    db $d8, $1a, $0c, $60 ; entry 9
    db $d0, $0b, $09, $40 ; entry 10
    db $d0, $1b, $0b, $00 ; entry 11
    db $d0, $13, $0f, $60 ; entry 12
    db $d0, $03, $20, $40 ; entry 13
    db $d8, $f5, $11, $20 ; entry 14
    db $f8, $03, $0b, $00 ; entry 15
    db $f0, $f4, $16, $00 ; entry 16
    db $f8, $e8, $1c, $20 ; entry 17
    db $f8, $f8, $08, $60 ; entry 18
    db $f8, $f0, $09, $60 ; entry 19
    db $f8, $e0, $2a, $60 ; entry 20
    db $f0, $e0, $05, $40 ; entry 21
    db $80 ; end

; frame 9 of MetaSprites3FSet11; ends with $80 (E-0147)
MetaSprites3FSet11Frame9::
    db $d0, $30, $18, $20 ; entry 0
    db $d8, $30, $19, $20 ; entry 1
    db $d0, $28, $1a, $20 ; entry 2
    db $d8, $28, $1b, $20 ; entry 3
    db $d0, $20, $1c, $20 ; entry 4
    db $d8, $20, $1d, $20 ; entry 5
    db $d0, $18, $1e, $20 ; entry 6
    db $d8, $18, $1e, $40 ; entry 7
    db $d8, $10, $20, $60 ; entry 8
    db $d9, $08, $09, $60 ; entry 9
    db $d1, $06, $08, $60 ; entry 10
    db $d0, $10, $21, $60 ; entry 11
    db $e1, $07, $15, $40 ; entry 12
    db $e4, $ff, $11, $60 ; entry 13
    db $e4, $f9, $11, $00 ; entry 14
    db $e7, $f1, $15, $20 ; entry 15
    db $f7, $f2, $08, $00 ; entry 16
    db $ef, $f0, $09, $00 ; entry 17
    db $f8, $c8, $18, $40 ; entry 18
    db $f0, $c8, $19, $40 ; entry 19
    db $f8, $d0, $1a, $40 ; entry 20
    db $f0, $d0, $1b, $40 ; entry 21
    db $f8, $d8, $1c, $40 ; entry 22
    db $f0, $d8, $1d, $40 ; entry 23
    db $f8, $e0, $1e, $40 ; entry 24
    db $f0, $e0, $1e, $20 ; entry 25
    db $f0, $e8, $20, $00 ; entry 26
    db $f8, $e8, $21, $00 ; entry 27
    db $df, $13, $08, $00 ; entry 28
    db $e0, $1b, $24, $60 ; entry 29
    db $e8, $1b, $05, $00 ; entry 30
    db $e9, $e5, $08, $60 ; entry 31
    db $e8, $dd, $24, $00 ; entry 32
    db $e0, $dd, $05, $60 ; entry 33
    db $e9, $07, $08, $60 ; entry 34
    db $f8, $0b, $26, $20 ; entry 35
    db $f1, $09, $0d, $60 ; entry 36
    db $df, $f1, $08, $00 ; entry 37
    db $d0, $ed, $26, $40 ; entry 38
    db $d7, $ef, $0d, $00 ; entry 39
    db $80 ; end

; frame 10 of MetaSprites3FSet11; ends with $80 (E-0147)
MetaSprites3FSet11Frame10::
    db $e2, $00, $18, $40 ; entry 0
    db $da, $00, $19, $40 ; entry 1
    db $e2, $08, $1a, $40 ; entry 2
    db $da, $08, $1b, $40 ; entry 3
    db $e2, $10, $1c, $40 ; entry 4
    db $da, $10, $1d, $40 ; entry 5
    db $e2, $18, $1e, $40 ; entry 6
    db $da, $18, $1f, $40 ; entry 7
    db $da, $20, $20, $00 ; entry 8
    db $e2, $20, $21, $00 ; entry 9
    db $e8, $40, $09, $40 ; entry 10
    db $df, $30, $1e, $00 ; entry 11
    db $e7, $30, $1e, $60 ; entry 12
    db $e7, $38, $20, $40 ; entry 13
    db $df, $38, $21, $40 ; entry 14
    db $de, $28, $18, $00 ; entry 15
    db $e6, $28, $19, $00 ; entry 16
    db $e0, $40, $08, $60 ; entry 17
    db $f0, $40, $15, $60 ; entry 18
    db $f0, $48, $1c, $20 ; entry 19
    db $f8, $48, $09, $00 ; entry 20
    db $f8, $40, $2a, $40 ; entry 21
    db $d8, $28, $09, $00 ; entry 22
    db $d0, $2c, $0f, $60 ; entry 23
    db $d0, $34, $08, $20 ; entry 24
    db $ea, $1e, $0c, $60 ; entry 25
    db $ea, $16, $0d, $60 ; entry 26
    db $f2, $1e, $0e, $60 ; entry 27
    db $f2, $16, $0f, $60 ; entry 28
    db $f8, $1a, $10, $60 ; entry 29
    db $f8, $12, $11, $60 ; entry 30
    db $80 ; end

; frame 11 of MetaSprites3FSet11; ends with $80 (E-0147)
MetaSprites3FSet11Frame11::
    db $e6, $f8, $18, $20 ; entry 0
    db $ee, $f8, $19, $20 ; entry 1
    db $e6, $f0, $1a, $20 ; entry 2
    db $ee, $f0, $1b, $20 ; entry 3
    db $e6, $e8, $1c, $20 ; entry 4
    db $ee, $e8, $1d, $20 ; entry 5
    db $e6, $e0, $1e, $20 ; entry 6
    db $ee, $e0, $1f, $20 ; entry 7
    db $ee, $d8, $20, $60 ; entry 8
    db $e6, $d8, $21, $60 ; entry 9
    db $e0, $b8, $09, $20 ; entry 10
    db $e9, $c8, $1e, $60 ; entry 11
    db $e1, $c8, $1e, $00 ; entry 12
    db $e1, $c0, $20, $20 ; entry 13
    db $e9, $c0, $21, $20 ; entry 14
    db $ea, $d0, $18, $60 ; entry 15
    db $e2, $d0, $19, $60 ; entry 16
    db $e8, $b8, $08, $00 ; entry 17
    db $d8, $b8, $15, $00 ; entry 18
    db $d8, $b0, $1c, $40 ; entry 19
    db $d0, $b0, $09, $60 ; entry 20
    db $d0, $b8, $2a, $20 ; entry 21
    db $f0, $d0, $09, $60 ; entry 22
    db $f8, $cc, $0f, $00 ; entry 23
    db $f8, $c4, $08, $40 ; entry 24
    db $de, $da, $0c, $00 ; entry 25
    db $de, $e2, $0d, $00 ; entry 26
    db $d6, $da, $0e, $00 ; entry 27
    db $d6, $e2, $0f, $00 ; entry 28
    db $d0, $de, $10, $00 ; entry 29
    db $d0, $e6, $11, $00 ; entry 30
    db $80 ; end

; frame 12 of MetaSprites3FSet11; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet11Frame12::
    db $e4, $00, $09, $20 ; entry 0
    db $ed, $10, $1e, $60 ; entry 1
    db $e5, $10, $1e, $00 ; entry 2
    db $e5, $08, $20, $20 ; entry 3
    db $ed, $08, $21, $20 ; entry 4
    db $ee, $18, $18, $60 ; entry 5
    db $ec, $00, $08, $00 ; entry 6
    db $dc, $00, $15, $00 ; entry 7
    db $f8, $40, $18, $60 ; entry 8
    db $f0, $40, $19, $60 ; entry 9
    db $f8, $38, $1a, $60 ; entry 10
    db $f0, $38, $1b, $60 ; entry 11
    db $f8, $30, $1c, $60 ; entry 12
    db $f0, $30, $1d, $60 ; entry 13
    db $f8, $28, $1e, $60 ; entry 14
    db $f0, $28, $1f, $60 ; entry 15
    db $f0, $20, $20, $20 ; entry 16
    db $f8, $20, $21, $20 ; entry 17
    db $e8, $f8, $28, $60 ; entry 18
    db $e8, $f0, $29, $60 ; entry 19
    db $e6, $18, $28, $60 ; entry 20
    db $de, $25, $1a, $60 ; entry 21
    db $de, $1d, $24, $40 ; entry 22
    db $dc, $2d, $1c, $60 ; entry 23
    db $d4, $2d, $1d, $60 ; entry 24
    db $dc, $35, $22, $40 ; entry 25
    db $d4, $35, $24, $40 ; entry 26
    db $d0, $3d, $1e, $40 ; entry 27
    db $f8, $48, $10, $60 ; entry 28
    db $f0, $f7, $26, $60 ; entry 29
    db $f8, $f4, $26, $00 ; entry 30
    db $db, $3d, $27, $20 ; entry 31
    db $80 ; end

; frame 13 of MetaSprites3FSet11; ends with $80 (E-0147)
MetaSprites3FSet11Frame13::
    db $f4, $cb, $1d, $00 ; entry 0
    db $f4, $c3, $24, $20 ; entry 1
    db $f8, $bb, $1e, $20 ; entry 2
    db $e4, $f8, $09, $40 ; entry 3
    db $db, $e8, $1e, $00 ; entry 4
    db $e3, $e8, $1e, $60 ; entry 5
    db $e3, $f0, $20, $40 ; entry 6
    db $db, $f0, $21, $40 ; entry 7
    db $da, $e0, $18, $00 ; entry 8
    db $dc, $f8, $08, $60 ; entry 9
    db $ec, $f8, $15, $60 ; entry 10
    db $d0, $b8, $18, $00 ; entry 11
    db $d8, $b8, $19, $00 ; entry 12
    db $d0, $c0, $1a, $00 ; entry 13
    db $d8, $c0, $1b, $00 ; entry 14
    db $d0, $c8, $1c, $00 ; entry 15
    db $d8, $c8, $1d, $00 ; entry 16
    db $d0, $d0, $1e, $00 ; entry 17
    db $d8, $d0, $1f, $00 ; entry 18
    db $d8, $d8, $20, $40 ; entry 19
    db $d0, $d8, $21, $40 ; entry 20
    db $e0, $00, $28, $00 ; entry 21
    db $e0, $08, $29, $00 ; entry 22
    db $e2, $e0, $28, $00 ; entry 23
    db $ea, $d3, $1a, $00 ; entry 24
    db $ea, $db, $24, $20 ; entry 25
    db $ec, $cb, $1c, $00 ; entry 26
    db $ec, $c3, $22, $20 ; entry 27
    db $d0, $b0, $10, $00 ; entry 28
    db $d8, $01, $26, $00 ; entry 29
    db $d0, $04, $26, $60 ; entry 30
    db $ed, $bb, $27, $40 ; entry 31
    db $80 ; end

; frame 14 of MetaSprites3FSet11; ends with $80 (E-0147)
MetaSprites3FSet11Frame14::
    db $e8, $00, $1e, $60 ; entry 0
    db $e0, $00, $1f, $60 ; entry 1
    db $ea, $08, $1c, $20 ; entry 2
    db $e0, $f8, $1e, $00 ; entry 3
    db $e8, $f8, $1f, $00 ; entry 4
    db $de, $f0, $1c, $40 ; entry 5
    db $dd, $e8, $1f, $00 ; entry 6
    db $d5, $e6, $24, $60 ; entry 7
    db $d0, $e2, $0d, $60 ; entry 8
    db $eb, $10, $1f, $60 ; entry 9
    db $f3, $12, $24, $00 ; entry 10
    db $f8, $16, $0d, $00 ; entry 11
    db $d6, $f0, $05, $60 ; entry 12
    db $f2, $08, $05, $00 ; entry 13
    db $80 ; end

; frame 15 of MetaSprites3FSet11; ends with $80 (E-0147)
MetaSprites3FSet11Frame15::
    db $e0, $fc, $14, $00 ; entry 0
    db $e0, $04, $15, $00 ; entry 1
    db $e8, $fd, $0c, $00 ; entry 2
    db $e8, $05, $0d, $00 ; entry 3
    db $e8, $fa, $0d, $20 ; entry 4
    db $f0, $12, $0e, $20 ; entry 5
    db $f0, $0a, $0f, $20 ; entry 6
    db $f0, $19, $0c, $60 ; entry 7
    db $f8, $0a, $09, $00 ; entry 8
    db $f8, $1a, $0b, $40 ; entry 9
    db $f8, $12, $0f, $20 ; entry 10
    db $f8, $02, $20, $00 ; entry 11
    db $d8, $f8, $08, $00 ; entry 12
    db $d8, $00, $09, $00 ; entry 13
    db $d8, $07, $16, $60 ; entry 14
    db $d0, $13, $1c, $40 ; entry 15
    db $d0, $03, $08, $00 ; entry 16
    db $d0, $0b, $09, $00 ; entry 17
    db $d0, $1b, $2a, $00 ; entry 18
    db $d8, $1b, $05, $20 ; entry 19
    db $d8, $e8, $0e, $40 ; entry 20
    db $d8, $f0, $0f, $40 ; entry 21
    db $d8, $e1, $0c, $00 ; entry 22
    db $d0, $f0, $09, $60 ; entry 23
    db $d0, $e0, $0b, $20 ; entry 24
    db $d0, $e8, $0f, $40 ; entry 25
    db $d0, $f8, $20, $60 ; entry 26
    db $f8, $e6, $1c, $20 ; entry 27
    db $f8, $f5, $08, $60 ; entry 28
    db $f8, $ee, $09, $60 ; entry 29
    db $f8, $de, $2a, $60 ; entry 30
    db $f0, $de, $05, $40 ; entry 31
    db $ef, $f7, $09, $00 ; entry 32
    db $f1, $ef, $21, $60 ; entry 33
    db $80 ; end

; frame 16 of MetaSprites3FSet11; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet11Frame16::
    db $80 ; end

; meta-sprite set 18 of MetaSprites3FTable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3FSet12::
    dw MetaSprites3FSet12Frame0 ; entry 0
    dw MetaSprites3FSet12Frame1 ; entry 1
    dw MetaSprites3FSet12Frame2 ; entry 2
    dw MetaSprites3FSet12Frame3 ; entry 3
    dw MetaSprites3FSet12Frame4 ; entry 4
    dw MetaSprites3FSet12Frame5 ; entry 5
    dw MetaSprites3FSet12Frame6 ; entry 6
    dw MetaSprites3FSet12Frame7 ; entry 7
    dw MetaSprites3FSet12Frame8 ; entry 8
    dw MetaSprites3FSet12Frame9 ; entry 9
    dw MetaSprites3FSet12Frame10 ; entry 10
    dw MetaSprites3FSet12Frame11 ; entry 11
    dw MetaSprites3FSet12Frame11 ; entry 12
    dw MetaSprites3FSet12Frame11 ; entry 13
    dw MetaSprites3FSet12Frame11 ; entry 14
    dw MetaSprites3FSet12Frame11 ; entry 15
    dw MetaSprites3FSet12Frame11 ; entry 16
    dw MetaSprites3FSet12Frame11 ; entry 17
    dw MetaSprites3FSet12Frame11 ; entry 18
    dw MetaSprites3FSet12Frame11 ; entry 19
    dw MetaSprites3FSet12Frame11 ; entry 20
    dw MetaSprites3FSet12Frame11 ; entry 21
    dw MetaSprites3FSet12Frame11 ; entry 22
    dw MetaSprites3FSet12Frame11 ; entry 23
    dw MetaSprites3FSet12Frame11 ; entry 24
    dw MetaSprites3FSet12Frame11 ; entry 25
    dw MetaSprites3FSet12Frame11 ; entry 26
    dw MetaSprites3FSet12Frame11 ; entry 27
    dw MetaSprites3FSet12Frame11 ; entry 28
    dw MetaSprites3FSet12Frame11 ; entry 29
    dw MetaSprites3FSet12Frame11 ; entry 30
    dw MetaSprites3FSet12Frame11 ; entry 31

; frame 0 of MetaSprites3FSet12; ends with $80 (E-0147)
MetaSprites3FSet12Frame0::
    db $d0, $10, $00, $10 ; entry 0
    db $d8, $10, $01, $10 ; entry 1
    db $80 ; end

; frame 1 of MetaSprites3FSet12; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet12Frame1::
    db $d8, $08, $01, $10 ; entry 0
    db $d0, $08, $00, $10 ; entry 1
    db $d2, $10, $02, $10 ; entry 2
    db $da, $10, $03, $10 ; entry 3
    db $e2, $10, $04, $10 ; entry 4
    db $80 ; end

; frame 2 of MetaSprites3FSet12; ends with $80 (E-0147)
MetaSprites3FSet12Frame2::
    db $d0, $00, $00, $10 ; entry 0
    db $d8, $00, $01, $10 ; entry 1
    db $d2, $08, $02, $10 ; entry 2
    db $da, $08, $03, $10 ; entry 3
    db $e2, $08, $04, $10 ; entry 4
    db $d4, $10, $05, $10 ; entry 5
    db $dc, $10, $06, $10 ; entry 6
    db $e4, $10, $07, $10 ; entry 7
    db $ec, $10, $08, $10 ; entry 8
    db $80 ; end

; frame 3 of MetaSprites3FSet12; ends with $80 (E-0147)
MetaSprites3FSet12Frame3::
    db $d0, $f8, $00, $10 ; entry 0
    db $d8, $f8, $01, $10 ; entry 1
    db $d2, $00, $02, $10 ; entry 2
    db $da, $00, $03, $10 ; entry 3
    db $e2, $00, $04, $10 ; entry 4
    db $d4, $08, $05, $10 ; entry 5
    db $dc, $08, $06, $10 ; entry 6
    db $e4, $08, $07, $10 ; entry 7
    db $ec, $08, $08, $10 ; entry 8
    db $d6, $10, $09, $10 ; entry 9
    db $de, $10, $0a, $10 ; entry 10
    db $e6, $10, $0b, $10 ; entry 11
    db $ee, $10, $0c, $10 ; entry 12
    db $80 ; end

; frame 4 of MetaSprites3FSet12; ends with $80 (E-0147)
MetaSprites3FSet12Frame4::
    db $d0, $f0, $00, $10 ; entry 0
    db $d8, $f0, $01, $10 ; entry 1
    db $d2, $f8, $02, $10 ; entry 2
    db $da, $f8, $03, $10 ; entry 3
    db $e2, $f8, $04, $10 ; entry 4
    db $d4, $00, $05, $10 ; entry 5
    db $dc, $00, $06, $10 ; entry 6
    db $e4, $00, $07, $10 ; entry 7
    db $ec, $00, $08, $10 ; entry 8
    db $d6, $08, $09, $10 ; entry 9
    db $de, $08, $0a, $10 ; entry 10
    db $e6, $08, $0b, $10 ; entry 11
    db $ee, $08, $0c, $10 ; entry 12
    db $e0, $10, $0d, $10 ; entry 13
    db $e8, $10, $0e, $10 ; entry 14
    db $f0, $10, $0f, $10 ; entry 15
    db $80 ; end

; frame 5 of MetaSprites3FSet12; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet12Frame5::
    db $d0, $e8, $00, $10 ; entry 0
    db $d8, $e8, $01, $10 ; entry 1
    db $d2, $f0, $02, $10 ; entry 2
    db $da, $f0, $03, $10 ; entry 3
    db $e2, $f0, $04, $10 ; entry 4
    db $d4, $f8, $05, $10 ; entry 5
    db $dc, $f8, $06, $10 ; entry 6
    db $e4, $f8, $07, $10 ; entry 7
    db $ec, $f8, $08, $10 ; entry 8
    db $d6, $00, $09, $10 ; entry 9
    db $de, $00, $0a, $10 ; entry 10
    db $e6, $00, $0b, $10 ; entry 11
    db $ee, $00, $0c, $10 ; entry 12
    db $e0, $08, $0d, $10 ; entry 13
    db $e8, $08, $0e, $10 ; entry 14
    db $f0, $08, $0f, $10 ; entry 15
    db $ea, $10, $10, $10 ; entry 16
    db $f2, $10, $11, $10 ; entry 17
    db $80 ; end

; frame 6 of MetaSprites3FSet12; ends with $80 (E-0147)
MetaSprites3FSet12Frame6::
    db $ea, $08, $10, $10 ; entry 0
    db $f2, $08, $11, $10 ; entry 1
    db $e0, $00, $0d, $10 ; entry 2
    db $e8, $00, $0e, $10 ; entry 3
    db $f0, $00, $0f, $10 ; entry 4
    db $d2, $e8, $02, $10 ; entry 5
    db $da, $e8, $03, $10 ; entry 6
    db $e2, $e8, $04, $10 ; entry 7
    db $d4, $f0, $05, $10 ; entry 8
    db $dc, $f0, $06, $10 ; entry 9
    db $e4, $f0, $07, $10 ; entry 10
    db $ec, $f0, $08, $10 ; entry 11
    db $d6, $f8, $09, $10 ; entry 12
    db $de, $f8, $0a, $10 ; entry 13
    db $e6, $f8, $0b, $10 ; entry 14
    db $ee, $f8, $0c, $10 ; entry 15
    db $80 ; end

; frame 7 of MetaSprites3FSet12; ends with $80 (E-0147)
MetaSprites3FSet12Frame7::
    db $d4, $e8, $05, $10 ; entry 0
    db $dc, $e8, $06, $10 ; entry 1
    db $e4, $e8, $07, $10 ; entry 2
    db $ec, $e8, $08, $10 ; entry 3
    db $d6, $f0, $09, $10 ; entry 4
    db $de, $f0, $0a, $10 ; entry 5
    db $e6, $f0, $0b, $10 ; entry 6
    db $ee, $f0, $0c, $10 ; entry 7
    db $e0, $f8, $0d, $10 ; entry 8
    db $e8, $f8, $0e, $10 ; entry 9
    db $f0, $f8, $0f, $10 ; entry 10
    db $ea, $00, $10, $10 ; entry 11
    db $f2, $00, $11, $10 ; entry 12
    db $80 ; end

; frame 8 of MetaSprites3FSet12; ends with $80 (E-0147)
MetaSprites3FSet12Frame8::
    db $d6, $e8, $09, $10 ; entry 0
    db $de, $e8, $0a, $10 ; entry 1
    db $e6, $e8, $0b, $10 ; entry 2
    db $ee, $e8, $0c, $10 ; entry 3
    db $e0, $f0, $0d, $10 ; entry 4
    db $e8, $f0, $0e, $10 ; entry 5
    db $f0, $f0, $0f, $10 ; entry 6
    db $ea, $f8, $10, $10 ; entry 7
    db $f2, $f8, $11, $10 ; entry 8
    db $80 ; end

; frame 9 of MetaSprites3FSet12; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet12Frame9::
    db $e0, $e8, $0d, $10 ; entry 0
    db $e8, $e8, $0e, $10 ; entry 1
    db $f0, $e8, $0f, $10 ; entry 2
    db $ea, $f0, $10, $10 ; entry 3
    db $f2, $f0, $11, $10 ; entry 4
    db $80 ; end

; frame 10 of MetaSprites3FSet12; ends with $80 (E-0147)
MetaSprites3FSet12Frame10::
    db $ea, $e8, $10, $10 ; entry 0
    db $f2, $e8, $11, $10 ; entry 1
    db $80 ; end

; frame 11 of MetaSprites3FSet12; ends with $80 (E-0147)
MetaSprites3FSet12Frame11::
    db $80 ; end

; meta-sprite set 19 of MetaSprites3FTable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3FSet13::
    dw MetaSprites3FSet13Frame0 ; entry 0
    dw MetaSprites3FSet13Frame1 ; entry 1
    dw MetaSprites3FSet13Frame2 ; entry 2
    dw MetaSprites3FSet13Frame3 ; entry 3
    dw MetaSprites3FSet13Frame4 ; entry 4
    dw MetaSprites3FSet13Frame5 ; entry 5
    dw MetaSprites3FSet13Frame6 ; entry 6
    dw MetaSprites3FSet13Frame7 ; entry 7
    dw MetaSprites3FSet13Frame8 ; entry 8
    dw MetaSprites3FSet13Frame8 ; entry 9
    dw MetaSprites3FSet13Frame8 ; entry 10
    dw MetaSprites3FSet13Frame8 ; entry 11
    dw MetaSprites3FSet13Frame8 ; entry 12
    dw MetaSprites3FSet13Frame8 ; entry 13
    dw MetaSprites3FSet13Frame8 ; entry 14
    dw MetaSprites3FSet13Frame8 ; entry 15
    dw MetaSprites3FSet13Frame8 ; entry 16
    dw MetaSprites3FSet13Frame8 ; entry 17
    dw MetaSprites3FSet13Frame8 ; entry 18
    dw MetaSprites3FSet13Frame8 ; entry 19
    dw MetaSprites3FSet13Frame8 ; entry 20
    dw MetaSprites3FSet13Frame8 ; entry 21
    dw MetaSprites3FSet13Frame8 ; entry 22
    dw MetaSprites3FSet13Frame8 ; entry 23
    dw MetaSprites3FSet13Frame8 ; entry 24
    dw MetaSprites3FSet13Frame8 ; entry 25
    dw MetaSprites3FSet13Frame8 ; entry 26
    dw MetaSprites3FSet13Frame8 ; entry 27
    dw MetaSprites3FSet13Frame8 ; entry 28
    dw MetaSprites3FSet13Frame8 ; entry 29
    dw MetaSprites3FSet13Frame8 ; entry 30
    dw MetaSprites3FSet13Frame8 ; entry 31

; frame 0 of MetaSprites3FSet13; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet13Frame0::
    db $e8, $f0, $00, $10 ; entry 0
    db $e8, $f8, $01, $10 ; entry 1
    db $e8, $00, $00, $10 ; entry 2
    db $e8, $08, $01, $10 ; entry 3
    db $f0, $f0, $02, $10 ; entry 4
    db $f0, $f8, $03, $10 ; entry 5
    db $f0, $00, $02, $10 ; entry 6
    db $f0, $08, $03, $10 ; entry 7
    db $f8, $f0, $04, $10 ; entry 8
    db $f8, $f8, $05, $10 ; entry 9
    db $f8, $00, $04, $10 ; entry 10
    db $f8, $08, $05, $10 ; entry 11
    db $80 ; end

; frame 1 of MetaSprites3FSet13; ends with $80 (E-0147)
MetaSprites3FSet13Frame1::
    db $e0, $f0, $06, $10 ; entry 0
    db $e0, $f8, $07, $10 ; entry 1
    db $e0, $00, $06, $10 ; entry 2
    db $e0, $08, $07, $10 ; entry 3
    db $e8, $f0, $08, $10 ; entry 4
    db $e8, $f8, $09, $10 ; entry 5
    db $e8, $00, $08, $10 ; entry 6
    db $e8, $08, $09, $10 ; entry 7
    db $f0, $f0, $0a, $10 ; entry 8
    db $f0, $f8, $0b, $10 ; entry 9
    db $f0, $00, $0a, $10 ; entry 10
    db $f0, $08, $0b, $10 ; entry 11
    db $f8, $00, $0c, $10 ; entry 12
    db $f8, $08, $0d, $10 ; entry 13
    db $f8, $f0, $0c, $10 ; entry 14
    db $f8, $f8, $0d, $10 ; entry 15
    db $80 ; end

; frame 2 of MetaSprites3FSet13; ends with $80 (E-0147)
MetaSprites3FSet13Frame2::
    db $d8, $f0, $00, $10 ; entry 0
    db $d8, $f8, $01, $10 ; entry 1
    db $d8, $00, $00, $10 ; entry 2
    db $d8, $08, $01, $10 ; entry 3
    db $e0, $00, $02, $10 ; entry 4
    db $e0, $08, $03, $10 ; entry 5
    db $e0, $f0, $02, $10 ; entry 6
    db $e0, $f8, $03, $10 ; entry 7
    db $e8, $00, $04, $10 ; entry 8
    db $e8, $08, $05, $10 ; entry 9
    db $e8, $f0, $04, $10 ; entry 10
    db $e8, $f8, $05, $10 ; entry 11
    db $80 ; end

; frame 3 of MetaSprites3FSet13; ends with $80 (E-0147)
MetaSprites3FSet13Frame3::
    db $d0, $00, $06, $10 ; entry 0
    db $d0, $08, $07, $10 ; entry 1
    db $d0, $f0, $06, $10 ; entry 2
    db $d0, $f8, $07, $10 ; entry 3
    db $d8, $00, $08, $10 ; entry 4
    db $d8, $08, $09, $10 ; entry 5
    db $d8, $f0, $08, $10 ; entry 6
    db $d8, $f8, $09, $10 ; entry 7
    db $e0, $00, $0a, $10 ; entry 8
    db $e0, $08, $0b, $10 ; entry 9
    db $e0, $f0, $0a, $10 ; entry 10
    db $e0, $f8, $0b, $10 ; entry 11
    db $e8, $00, $0c, $10 ; entry 12
    db $e8, $08, $0d, $10 ; entry 13
    db $e8, $f0, $0c, $10 ; entry 14
    db $e8, $f8, $0d, $10 ; entry 15
    db $80 ; end

; frame 4 of MetaSprites3FSet13; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet13Frame4::
    db $d0, $f0, $02, $10 ; entry 0
    db $d0, $f8, $03, $10 ; entry 1
    db $d0, $00, $02, $10 ; entry 2
    db $d0, $08, $03, $10 ; entry 3
    db $d8, $00, $04, $10 ; entry 4
    db $d8, $08, $05, $10 ; entry 5
    db $d8, $f0, $04, $10 ; entry 6
    db $d8, $f8, $05, $10 ; entry 7
    db $80 ; end

; frame 5 of MetaSprites3FSet13; ends with $80 (E-0147)
MetaSprites3FSet13Frame5::
    db $d0, $f0, $0a, $10 ; entry 0
    db $d0, $f8, $0b, $10 ; entry 1
    db $d0, $00, $0a, $10 ; entry 2
    db $d0, $08, $0b, $10 ; entry 3
    db $d8, $f0, $0c, $10 ; entry 4
    db $d8, $f8, $0d, $10 ; entry 5
    db $d8, $00, $0c, $10 ; entry 6
    db $d8, $08, $0d, $10 ; entry 7
    db $80 ; end

; frame 6 of MetaSprites3FSet13; ends with $80 (E-0147)
MetaSprites3FSet13Frame6::
    db $d0, $f0, $04, $10 ; entry 0
    db $d0, $f8, $05, $10 ; entry 1
    db $d0, $00, $04, $10 ; entry 2
    db $d0, $08, $05, $10 ; entry 3
    db $80 ; end

; frame 7 of MetaSprites3FSet13; ends with $80 (E-0147)
MetaSprites3FSet13Frame7::
    db $d0, $f0, $0c, $10 ; entry 0
    db $d0, $f8, $0d, $10 ; entry 1
    db $d0, $00, $0c, $10 ; entry 2
    db $d0, $08, $0d, $10 ; entry 3
    db $80 ; end

; frame 8 of MetaSprites3FSet13; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet13Frame8::
    db $80 ; end

; meta-sprite set 20 of MetaSprites3FTable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3FSet14::
    dw MetaSprites3FSet14Frame0 ; entry 0
    dw MetaSprites3FSet14Frame1 ; entry 1
    dw MetaSprites3FSet14Frame2 ; entry 2
    dw MetaSprites3FSet14Frame3 ; entry 3
    dw MetaSprites3FSet14Frame4 ; entry 4
    dw MetaSprites3FSet14Frame5 ; entry 5
    dw MetaSprites3FSet14Frame6 ; entry 6
    dw MetaSprites3FSet14Frame7 ; entry 7
    dw MetaSprites3FSet14Frame8 ; entry 8
    dw MetaSprites3FSet14Frame9 ; entry 9
    dw MetaSprites3FSet14Frame10 ; entry 10
    dw MetaSprites3FSet14Frame11 ; entry 11
    dw MetaSprites3FSet14Frame11 ; entry 12
    dw MetaSprites3FSet14Frame11 ; entry 13
    dw MetaSprites3FSet14Frame11 ; entry 14
    dw MetaSprites3FSet14Frame11 ; entry 15
    dw MetaSprites3FSet14Frame11 ; entry 16
    dw MetaSprites3FSet14Frame11 ; entry 17
    dw MetaSprites3FSet14Frame11 ; entry 18
    dw MetaSprites3FSet14Frame11 ; entry 19
    dw MetaSprites3FSet14Frame11 ; entry 20
    dw MetaSprites3FSet14Frame11 ; entry 21
    dw MetaSprites3FSet14Frame11 ; entry 22
    dw MetaSprites3FSet14Frame11 ; entry 23
    dw MetaSprites3FSet14Frame11 ; entry 24
    dw MetaSprites3FSet14Frame11 ; entry 25
    dw MetaSprites3FSet14Frame11 ; entry 26
    dw MetaSprites3FSet14Frame11 ; entry 27
    dw MetaSprites3FSet14Frame11 ; entry 28
    dw MetaSprites3FSet14Frame11 ; entry 29
    dw MetaSprites3FSet14Frame11 ; entry 30
    dw MetaSprites3FSet14Frame11 ; entry 31

; frame 0 of MetaSprites3FSet14; ends with $80 (E-0147)
MetaSprites3FSet14Frame0::
    db $e5, $f5, $00, $10 ; entry 0
    db $80 ; end

; frame 1 of MetaSprites3FSet14; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet14Frame1::
    db $e0, $f0, $00, $10 ; entry 0
    db $e8, $f0, $02, $10 ; entry 1
    db $e8, $f8, $03, $10 ; entry 2
    db $e0, $f8, $05, $10 ; entry 3
    db $dd, $05, $00, $10 ; entry 4
    db $80 ; end

; frame 2 of MetaSprites3FSet14; ends with $80 (E-0147)
MetaSprites3FSet14Frame2::
    db $d8, $00, $00, $10 ; entry 0
    db $e0, $00, $02, $10 ; entry 1
    db $e0, $08, $03, $10 ; entry 2
    db $d8, $08, $01, $10 ; entry 3
    db $ed, $05, $00, $10 ; entry 4
    db $e0, $f0, $01, $10 ; entry 5
    db $e4, $f8, $04, $10 ; entry 6
    db $e8, $f8, $01, $10 ; entry 7
    db $e7, $f2, $04, $10 ; entry 8
    db $80 ; end

; frame 3 of MetaSprites3FSet14; ends with $80 (E-0147)
MetaSprites3FSet14Frame3::
    db $d8, $00, $01, $10 ; entry 0
    db $dc, $08, $04, $10 ; entry 1
    db $e0, $08, $01, $10 ; entry 2
    db $df, $02, $04, $10 ; entry 3
    db $e6, $f2, $05, $10 ; entry 4
    db $e0, $f8, $05, $10 ; entry 5
    db $e4, $f4, $04, $10 ; entry 6
    db $e8, $00, $00, $10 ; entry 7
    db $f0, $00, $02, $10 ; entry 8
    db $f0, $08, $03, $10 ; entry 9
    db $e8, $08, $01, $10 ; entry 10
    db $80 ; end

; frame 4 of MetaSprites3FSet14; ends with $80 (E-0147)
MetaSprites3FSet14Frame4::
    db $e0, $f0, $01, $10 ; entry 0
    db $d8, $08, $01, $10 ; entry 1
    db $de, $02, $01, $10 ; entry 2
    db $dc, $04, $04, $10 ; entry 3
    db $e8, $00, $01, $10 ; entry 4
    db $f0, $08, $01, $10 ; entry 5
    db $ef, $02, $04, $10 ; entry 6
    db $ec, $08, $04, $10 ; entry 7
    db $e6, $f7, $01, $50 ; entry 8
    db $80 ; end

; frame 5 of MetaSprites3FSet14; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet14Frame5::
    db $d8, $00, $01, $10 ; entry 0
    db $e8, $08, $01, $10 ; entry 1
    db $ee, $02, $01, $10 ; entry 2
    db $ec, $04, $04, $10 ; entry 3
    db $de, $07, $05, $50 ; entry 4
    db $80 ; end

; frame 6 of MetaSprites3FSet14; ends with $80 (E-0147)
MetaSprites3FSet14Frame6::
    db $e8, $00, $01, $10 ; entry 0
    db $ee, $07, $01, $50 ; entry 1
    db $80 ; end

; frame 7 of MetaSprites3FSet14; ends with $80 (E-0147)
MetaSprites3FSet14Frame7::
    db $e6, $f2, $01, $10 ; entry 0
    db $e0, $f8, $01, $10 ; entry 1
    db $e4, $f4, $04, $10 ; entry 2
    db $e8, $00, $00, $10 ; entry 3
    db $e8, $08, $01, $10 ; entry 4
    db $f0, $00, $02, $10 ; entry 5
    db $f0, $08, $03, $10 ; entry 6
    db $80 ; end

; frame 8 of MetaSprites3FSet14; ends with $80 (E-0147)
MetaSprites3FSet14Frame8::
    db $e0, $f0, $01, $10 ; entry 0
    db $e8, $00, $01, $10 ; entry 1
    db $f0, $08, $01, $10 ; entry 2
    db $e6, $f7, $01, $50 ; entry 3
    db $ec, $08, $04, $10 ; entry 4
    db $ef, $02, $04, $10 ; entry 5
    db $80 ; end

; frame 9 of MetaSprites3FSet14; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet14Frame9::
    db $ee, $02, $01, $10 ; entry 0
    db $e8, $08, $01, $10 ; entry 1
    db $ec, $04, $04, $10 ; entry 2
    db $80 ; end

; frame 10 of MetaSprites3FSet14; ends with $80 (E-0147)
MetaSprites3FSet14Frame10::
    db $e8, $00, $01, $10 ; entry 0
    db $ee, $07, $01, $50 ; entry 1
    db $80 ; end

; frame 11 of MetaSprites3FSet14; ends with $80 (E-0147)
MetaSprites3FSet14Frame11::
    db $80 ; end

; meta-sprite set 21 of MetaSprites3FTable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3FSet15::
    dw MetaSprites3FSet15Frame0 ; entry 0
    dw MetaSprites3FSet15Frame1 ; entry 1
    dw MetaSprites3FSet15Frame2 ; entry 2
    dw MetaSprites3FSet15Frame3 ; entry 3
    dw MetaSprites3FSet15Frame4 ; entry 4
    dw MetaSprites3FSet15Frame5 ; entry 5
    dw MetaSprites3FSet15Frame6 ; entry 6
    dw MetaSprites3FSet15Frame7 ; entry 7
    dw MetaSprites3FSet15Frame8 ; entry 8
    dw MetaSprites3FSet15Frame9 ; entry 9
    dw MetaSprites3FSet15Frame10 ; entry 10
    dw MetaSprites3FSet15Frame10 ; entry 11
    dw MetaSprites3FSet15Frame10 ; entry 12
    dw MetaSprites3FSet15Frame10 ; entry 13
    dw MetaSprites3FSet15Frame10 ; entry 14
    dw MetaSprites3FSet15Frame10 ; entry 15
    dw MetaSprites3FSet15Frame10 ; entry 16
    dw MetaSprites3FSet15Frame10 ; entry 17
    dw MetaSprites3FSet15Frame10 ; entry 18
    dw MetaSprites3FSet15Frame10 ; entry 19
    dw MetaSprites3FSet15Frame10 ; entry 20
    dw MetaSprites3FSet15Frame10 ; entry 21
    dw MetaSprites3FSet15Frame10 ; entry 22
    dw MetaSprites3FSet15Frame10 ; entry 23
    dw MetaSprites3FSet15Frame10 ; entry 24
    dw MetaSprites3FSet15Frame10 ; entry 25
    dw MetaSprites3FSet15Frame10 ; entry 26
    dw MetaSprites3FSet15Frame10 ; entry 27
    dw MetaSprites3FSet15Frame10 ; entry 28
    dw MetaSprites3FSet15Frame10 ; entry 29
    dw MetaSprites3FSet15Frame10 ; entry 30
    dw MetaSprites3FSet15Frame10 ; entry 31

; frame 0 of MetaSprites3FSet15; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet15Frame0::
    db $ea, $02, $01, $00 ; entry 0
    db $e0, $f8, $02, $00 ; entry 1
    db $80 ; end

; frame 1 of MetaSprites3FSet15; ends with $80 (E-0147)
MetaSprites3FSet15Frame1::
    db $e0, $0b, $01, $00 ; entry 0
    db $eb, $ee, $01, $00 ; entry 1
    db $ea, $02, $02, $00 ; entry 2
    db $e0, $f8, $03, $00 ; entry 3
    db $80 ; end

; frame 2 of MetaSprites3FSet15; ends with $80 (E-0147)
MetaSprites3FSet15Frame2::
    db $f0, $10, $01, $00 ; entry 0
    db $db, $ef, $01, $00 ; entry 1
    db $e0, $0b, $02, $00 ; entry 2
    db $eb, $ec, $02, $00 ; entry 3
    db $ea, $02, $03, $00 ; entry 4
    db $e0, $f8, $04, $00 ; entry 5
    db $80 ; end

; frame 3 of MetaSprites3FSet15; ends with $80 (E-0147)
MetaSprites3FSet15Frame3::
    db $da, $fe, $01, $00 ; entry 0
    db $dd, $f8, $00, $00 ; entry 1
    db $db, $ef, $02, $00 ; entry 2
    db $f0, $10, $02, $00 ; entry 3
    db $e0, $0b, $03, $00 ; entry 4
    db $eb, $ec, $03, $00 ; entry 5
    db $ea, $02, $04, $00 ; entry 6
    db $80 ; end

; frame 4 of MetaSprites3FSet15; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet15Frame4::
    db $d6, $fa, $00, $00 ; entry 0
    db $e7, $01, $00, $00 ; entry 1
    db $e2, $e8, $01, $00 ; entry 2
    db $eb, $ff, $01, $00 ; entry 3
    db $e0, $0b, $04, $00 ; entry 4
    db $eb, $ec, $04, $00 ; entry 5
    db $f0, $10, $03, $00 ; entry 6
    db $db, $ef, $03, $00 ; entry 7
    db $80 ; end

; frame 5 of MetaSprites3FSet15; ends with $80 (E-0147)
MetaSprites3FSet15Frame5::
    db $e2, $00, $00, $00 ; entry 0
    db $dd, $0c, $00, $00 ; entry 1
    db $e8, $ea, $00, $00 ; entry 2
    db $e2, $13, $01, $00 ; entry 3
    db $ef, $e7, $01, $00 ; entry 4
    db $e2, $e6, $02, $00 ; entry 5
    db $f0, $10, $04, $00 ; entry 6
    db $db, $ef, $04, $00 ; entry 7
    db $80 ; end

; frame 6 of MetaSprites3FSet15; ends with $80 (E-0147)
MetaSprites3FSet15Frame6::
    db $d9, $ee, $00, $00 ; entry 0
    db $e5, $e7, $00, $00 ; entry 1
    db $ec, $0f, $00, $00 ; entry 2
    db $ed, $0c, $01, $00 ; entry 3
    db $d8, $e9, $01, $00 ; entry 4
    db $e2, $e7, $03, $00 ; entry 5
    db $80 ; end

; frame 7 of MetaSprites3FSet15; ends with $80 (E-0147)
MetaSprites3FSet15Frame7::
    db $d4, $ec, $00, $00 ; entry 0
    db $e9, $13, $01, $00 ; entry 1
    db $e1, $e8, $04, $00 ; entry 2
    db $80 ; end

; frame 8 of MetaSprites3FSet15; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet15Frame8::
    db $d8, $ef, $00, $00 ; entry 0
    db $de, $e8, $01, $00 ; entry 1
    db $e0, $f7, $01, $00 ; entry 2
    db $80 ; end

; frame 9 of MetaSprites3FSet15; ends with $80 (E-0147)
MetaSprites3FSet15Frame9::
    db $d8, $ea, $01, $00 ; entry 0
    db $80 ; end

; frame 10 of MetaSprites3FSet15; ends with $80 (E-0147)
MetaSprites3FSet15Frame10::
    db $80 ; end

; meta-sprite set 22 of MetaSprites3FTable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3FSet16::
    dw MetaSprites3FSet16Frame0 ; entry 0
    dw MetaSprites3FSet16Frame1 ; entry 1
    dw MetaSprites3FSet16Frame2 ; entry 2
    dw MetaSprites3FSet16Frame3 ; entry 3
    dw MetaSprites3FSet16Frame4 ; entry 4
    dw MetaSprites3FSet16Frame5 ; entry 5
    dw MetaSprites3FSet16Frame6 ; entry 6
    dw MetaSprites3FSet16Frame7 ; entry 7
    dw MetaSprites3FSet16Frame8 ; entry 8
    dw MetaSprites3FSet16Frame9 ; entry 9
    dw MetaSprites3FSet16Frame9 ; entry 10
    dw MetaSprites3FSet16Frame9 ; entry 11
    dw MetaSprites3FSet16Frame9 ; entry 12
    dw MetaSprites3FSet16Frame9 ; entry 13
    dw MetaSprites3FSet16Frame9 ; entry 14
    dw MetaSprites3FSet16Frame9 ; entry 15
    dw MetaSprites3FSet16Frame9 ; entry 16
    dw MetaSprites3FSet16Frame9 ; entry 17
    dw MetaSprites3FSet16Frame9 ; entry 18
    dw MetaSprites3FSet16Frame9 ; entry 19
    dw MetaSprites3FSet16Frame9 ; entry 20
    dw MetaSprites3FSet16Frame9 ; entry 21
    dw MetaSprites3FSet16Frame9 ; entry 22
    dw MetaSprites3FSet16Frame9 ; entry 23
    dw MetaSprites3FSet16Frame9 ; entry 24
    dw MetaSprites3FSet16Frame9 ; entry 25
    dw MetaSprites3FSet16Frame9 ; entry 26
    dw MetaSprites3FSet16Frame9 ; entry 27
    dw MetaSprites3FSet16Frame9 ; entry 28
    dw MetaSprites3FSet16Frame9 ; entry 29
    dw MetaSprites3FSet16Frame9 ; entry 30
    dw MetaSprites3FSet16Frame9 ; entry 31

; frame 0 of MetaSprites3FSet16; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet16Frame0::
    db $e8, $fc, $00, $00 ; entry 0
    db $80 ; end

; frame 1 of MetaSprites3FSet16; ends with $80 (E-0147)
MetaSprites3FSet16Frame1::
    db $e7, $fd, $00, $00 ; entry 0
    db $80 ; end

; frame 2 of MetaSprites3FSet16; ends with $80 (E-0147)
MetaSprites3FSet16Frame2::
    db $e4, $fa, $00, $00 ; entry 0
    db $80 ; end

; frame 3 of MetaSprites3FSet16; ends with $80 (E-0147)
MetaSprites3FSet16Frame3::
    db $e1, $ff, $01, $00 ; entry 0
    db $80 ; end

; frame 4 of MetaSprites3FSet16; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet16Frame4::
    db $dd, $f6, $01, $00 ; entry 0
    db $80 ; end

; frame 5 of MetaSprites3FSet16; ends with $80 (E-0147)
MetaSprites3FSet16Frame5::
    db $d8, $f8, $02, $00 ; entry 0
    db $d8, $00, $03, $00 ; entry 1
    db $e0, $f8, $04, $00 ; entry 2
    db $e0, $00, $05, $00 ; entry 3
    db $80 ; end

; frame 6 of MetaSprites3FSet16; ends with $80 (E-0147)
MetaSprites3FSet16Frame6::
    db $d9, $f6, $06, $00 ; entry 0
    db $d9, $02, $06, $20 ; entry 1
    db $e1, $f6, $07, $00 ; entry 2
    db $e1, $fe, $08, $00 ; entry 3
    db $d6, $f8, $02, $00 ; entry 4
    db $d6, $00, $03, $00 ; entry 5
    db $de, $f8, $04, $00 ; entry 6
    db $de, $00, $05, $00 ; entry 7
    db $e1, $02, $07, $20 ; entry 8
    db $e1, $fa, $08, $20 ; entry 9
    db $80 ; end

; frame 7 of MetaSprites3FSet16; ends with $80 (E-0147)
MetaSprites3FSet16Frame7::
    db $d8, $f4, $06, $00 ; entry 0
    db $d8, $04, $06, $20 ; entry 1
    db $e0, $f4, $07, $00 ; entry 2
    db $e0, $fc, $08, $00 ; entry 3
    db $e0, $04, $07, $20 ; entry 4
    db $e0, $fc, $08, $20 ; entry 5
    db $80 ; end

; frame 8 of MetaSprites3FSet16; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet16Frame8::
    db $d2, $fc, $00, $00 ; entry 0
    db $d8, $e8, $06, $00 ; entry 1
    db $d8, $f2, $06, $00 ; entry 2
    db $e0, $e8, $07, $00 ; entry 3
    db $e0, $f0, $08, $00 ; entry 4
    db $e0, $f2, $07, $00 ; entry 5
    db $e0, $fa, $08, $00 ; entry 6
    db $e0, $10, $07, $20 ; entry 7
    db $e0, $08, $08, $20 ; entry 8
    db $d8, $10, $06, $20 ; entry 9
    db $e0, $fe, $08, $20 ; entry 10
    db $d8, $06, $06, $20 ; entry 11
    db $e0, $06, $07, $20 ; entry 12
    db $80 ; end

; frame 9 of MetaSprites3FSet16; ends with $80 (E-0147)
MetaSprites3FSet16Frame9::
    db $80 ; end

; meta-sprite set 23 of MetaSprites3FTable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3FSet17::
    dw MetaSprites3FSet17Frame0 ; entry 0
    dw MetaSprites3FSet17Frame1 ; entry 1
    dw MetaSprites3FSet17Frame2 ; entry 2
    dw MetaSprites3FSet17Frame3 ; entry 3
    dw MetaSprites3FSet17Frame4 ; entry 4
    dw MetaSprites3FSet17Frame5 ; entry 5
    dw MetaSprites3FSet17Frame6 ; entry 6
    dw MetaSprites3FSet17Frame6 ; entry 7
    dw MetaSprites3FSet17Frame6 ; entry 8
    dw MetaSprites3FSet17Frame6 ; entry 9
    dw MetaSprites3FSet17Frame6 ; entry 10
    dw MetaSprites3FSet17Frame6 ; entry 11
    dw MetaSprites3FSet17Frame6 ; entry 12
    dw MetaSprites3FSet17Frame6 ; entry 13
    dw MetaSprites3FSet17Frame6 ; entry 14
    dw MetaSprites3FSet17Frame6 ; entry 15
    dw MetaSprites3FSet17Frame6 ; entry 16
    dw MetaSprites3FSet17Frame6 ; entry 17
    dw MetaSprites3FSet17Frame6 ; entry 18
    dw MetaSprites3FSet17Frame6 ; entry 19
    dw MetaSprites3FSet17Frame6 ; entry 20
    dw MetaSprites3FSet17Frame6 ; entry 21
    dw MetaSprites3FSet17Frame6 ; entry 22
    dw MetaSprites3FSet17Frame6 ; entry 23
    dw MetaSprites3FSet17Frame6 ; entry 24
    dw MetaSprites3FSet17Frame6 ; entry 25
    dw MetaSprites3FSet17Frame6 ; entry 26
    dw MetaSprites3FSet17Frame6 ; entry 27
    dw MetaSprites3FSet17Frame6 ; entry 28
    dw MetaSprites3FSet17Frame6 ; entry 29
    dw MetaSprites3FSet17Frame6 ; entry 30
    dw MetaSprites3FSet17Frame6 ; entry 31

; frame 0 of MetaSprites3FSet17; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet17Frame0::
    db $f0, $e8, $0a, $60 ; entry 0
    db $d8, $f0, $0a, $00 ; entry 1
    db $d8, $f8, $10, $40 ; entry 2
    db $d8, $e8, $05, $20 ; entry 3
    db $d8, $e0, $0a, $60 ; entry 4
    db $d8, $00, $11, $40 ; entry 5
    db $d8, $d8, $0e, $00 ; entry 6
    db $f0, $f0, $01, $00 ; entry 7
    db $e8, $e8, $17, $60 ; entry 8
    db $e8, $f0, $16, $00 ; entry 9
    db $e0, $00, $16, $00 ; entry 10
    db $e0, $08, $16, $60 ; entry 11
    db $e0, $10, $0c, $40 ; entry 12
    db $e0, $18, $0f, $00 ; entry 13
    db $f8, $00, $17, $00 ; entry 14
    db $f8, $f8, $0c, $20 ; entry 15
    db $f0, $e0, $11, $20 ; entry 16
    db $f8, $f0, $10, $40 ; entry 17
    db $f8, $e8, $0f, $60 ; entry 18
    db $e0, $f0, $00, $00 ; entry 19
    db $e0, $f8, $00, $00 ; entry 20
    db $d0, $f0, $10, $40 ; entry 21
    db $d0, $e8, $0f, $60 ; entry 22
    db $d0, $f8, $11, $40 ; entry 23
    db $f0, $08, $05, $40 ; entry 24
    db $f0, $10, $06, $40 ; entry 25
    db $f0, $18, $07, $40 ; entry 26
    db $e8, $00, $0c, $40 ; entry 27
    db $f0, $00, $16, $60 ; entry 28
    db $e8, $08, $0f, $00 ; entry 29
    db $f0, $f8, $00, $00 ; entry 30
    db $e8, $f8, $00, $00 ; entry 31
    db $e0, $e0, $0a, $60 ; entry 32
    db $e0, $e8, $00, $00 ; entry 33
    db $80 ; end

; frame 1 of MetaSprites3FSet17; ends with $80 (E-0147)
MetaSprites3FSet17Frame1::
    db $f8, $00, $17, $00 ; entry 0
    db $f8, $f0, $19, $20 ; entry 1
    db $f8, $f8, $16, $00 ; entry 2
    db $f0, $f0, $0a, $60 ; entry 3
    db $f0, $f8, $01, $00 ; entry 4
    db $f0, $e8, $0e, $00 ; entry 5
    db $f0, $08, $16, $60 ; entry 6
    db $f0, $00, $00, $00 ; entry 7
    db $f0, $10, $0c, $40 ; entry 8
    db $f0, $18, $0d, $40 ; entry 9
    db $e8, $08, $07, $40 ; entry 10
    db $e8, $e8, $19, $20 ; entry 11
    db $e8, $f0, $15, $20 ; entry 12
    db $e8, $00, $17, $00 ; entry 13
    db $e8, $f8, $00, $00 ; entry 14
    db $d8, $08, $11, $40 ; entry 15
    db $e0, $08, $16, $60 ; entry 16
    db $d8, $00, $0a, $00 ; entry 17
    db $e0, $00, $00, $00 ; entry 18
    db $d8, $f8, $16, $00 ; entry 19
    db $e0, $f8, $09, $20 ; entry 20
    db $d8, $f0, $18, $60 ; entry 21
    db $e0, $10, $17, $00 ; entry 22
    db $d8, $e4, $03, $00 ; entry 23
    db $d8, $dc, $07, $20 ; entry 24
    db $e0, $e8, $0f, $00 ; entry 25
    db $d0, $f0, $0a, $00 ; entry 26
    db $d0, $00, $07, $40 ; entry 27
    db $d0, $f8, $18, $00 ; entry 28
    db $d0, $e8, $17, $60 ; entry 29
    db $e0, $18, $03, $00 ; entry 30
    db $f0, $d8, $11, $20 ; entry 31
    db $f0, $e0, $0e, $00 ; entry 32
    db $80 ; end

; frame 2 of MetaSprites3FSet17; ends with $80 (E-0147)
MetaSprites3FSet17Frame2::
    db $e8, $e8, $0a, $60 ; entry 0
    db $e8, $00, $05, $40 ; entry 1
    db $e8, $08, $06, $40 ; entry 2
    db $e8, $10, $07, $40 ; entry 3
    db $d0, $00, $11, $40 ; entry 4
    db $e8, $f0, $01, $00 ; entry 5
    db $e8, $f8, $16, $60 ; entry 6
    db $e0, $e8, $17, $60 ; entry 7
    db $f0, $00, $17, $00 ; entry 8
    db $f0, $f8, $0c, $20 ; entry 9
    db $f8, $f8, $00, $00 ; entry 10
    db $f8, $00, $01, $00 ; entry 11
    db $f8, $f0, $13, $20 ; entry 12
    db $f0, $f0, $0f, $60 ; entry 13
    db $f8, $08, $14, $00 ; entry 14
    db $d8, $00, $16, $60 ; entry 15
    db $d8, $08, $0c, $40 ; entry 16
    db $d8, $10, $0f, $00 ; entry 17
    db $d0, $f8, $0a, $00 ; entry 18
    db $d0, $e8, $0a, $60 ; entry 19
    db $d0, $e0, $0e, $00 ; entry 20
    db $d8, $f8, $00, $00 ; entry 21
    db $d8, $e8, $07, $20 ; entry 22
    db $e8, $d8, $11, $20 ; entry 23
    db $e8, $e0, $0e, $00 ; entry 24
    db $d8, $f0, $17, $60 ; entry 25
    db $e0, $f0, $00, $00 ; entry 26
    db $e0, $f8, $08, $00 ; entry 27
    db $d0, $f0, $16, $00 ; entry 28
    db $80 ; end

; frame 3 of MetaSprites3FSet17; ends with $80 (E-0147)
MetaSprites3FSet17Frame3::
    db $e8, $f8, $16, $60 ; entry 0
    db $f8, $f8, $00, $00 ; entry 1
    db $f8, $f0, $17, $60 ; entry 2
    db $f0, $f8, $19, $20 ; entry 3
    db $f0, $f0, $03, $60 ; entry 4
    db $f7, $e9, $0e, $00 ; entry 5
    db $e8, $f0, $18, $60 ; entry 6
    db $e0, $f8, $0a, $00 ; entry 7
    db $e0, $f0, $06, $20 ; entry 8
    db $e0, $e8, $07, $20 ; entry 9
    db $e0, $00, $03, $40 ; entry 10
    db $d8, $00, $01, $00 ; entry 11
    db $d8, $f0, $03, $60 ; entry 12
    db $d8, $f8, $02, $60 ; entry 13
    db $d0, $00, $06, $40 ; entry 14
    db $d0, $08, $07, $40 ; entry 15
    db $d8, $08, $17, $00 ; entry 16
    db $d0, $f8, $19, $20 ; entry 17
    db $d0, $f0, $03, $60 ; entry 18
    db $d0, $ec, $07, $00 ; entry 19
    db $d0, $e4, $03, $20 ; entry 20
    db $e8, $00, $14, $00 ; entry 21
    db $f0, $00, $15, $40 ; entry 22
    db $f8, $00, $06, $40 ; entry 23
    db $e8, $e8, $07, $20 ; entry 24
    db $e8, $e0, $07, $00 ; entry 25
    db $e8, $d8, $03, $20 ; entry 26
    db $e8, $08, $07, $60 ; entry 27
    db $80 ; end

; frame 4 of MetaSprites3FSet17; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet17Frame4::
    db $f0, $08, $0a, $40 ; entry 0
    db $f0, $00, $01, $20 ; entry 1
    db $f0, $10, $11, $00 ; entry 2
    db $e0, $00, $0a, $40 ; entry 3
    db $e0, $08, $10, $00 ; entry 4
    db $e8, $00, $17, $40 ; entry 5
    db $d0, $00, $10, $60 ; entry 6
    db $d0, $08, $19, $00 ; entry 7
    db $f0, $f8, $06, $60 ; entry 8
    db $f0, $f0, $07, $60 ; entry 9
    db $e0, $f8, $16, $20 ; entry 10
    db $f8, $f8, $17, $20 ; entry 11
    db $f8, $00, $0c, $00 ; entry 12
    db $f8, $08, $11, $40 ; entry 13
    db $f8, $e8, $10, $40 ; entry 14
    db $d8, $f8, $19, $20 ; entry 15
    db $d8, $00, $15, $20 ; entry 16
    db $d8, $08, $00, $00 ; entry 17
    db $d8, $10, $12, $00 ; entry 18
    db $e0, $f0, $0c, $60 ; entry 19
    db $e0, $e8, $0f, $20 ; entry 20
    db $e8, $f8, $19, $60 ; entry 21
    db $f8, $e0, $03, $60 ; entry 22
    db $f8, $f0, $07, $40 ; entry 23
    db $f0, $e0, $07, $60 ; entry 24
    db $f0, $e8, $03, $40 ; entry 25
    db $80 ; end

; frame 5 of MetaSprites3FSet17; ends with $80 (E-0147)
MetaSprites3FSet17Frame5::
    db $e0, $f8, $16, $00 ; entry 0
    db $f8, $00, $08, $00 ; entry 1
    db $f8, $f0, $0e, $60 ; entry 2
    db $f8, $f8, $02, $60 ; entry 3
    db $f8, $e8, $03, $60 ; entry 4
    db $f0, $08, $17, $40 ; entry 5
    db $f0, $00, $16, $40 ; entry 6
    db $e8, $f8, $02, $00 ; entry 7
    db $e8, $00, $03, $00 ; entry 8
    db $f0, $f8, $00, $00 ; entry 9
    db $f0, $f0, $06, $20 ; entry 10
    db $f0, $e8, $07, $20 ; entry 11
    db $e8, $f0, $09, $20 ; entry 12
    db $e0, $00, $05, $40 ; entry 13
    db $e0, $10, $03, $00 ; entry 14
    db $e0, $08, $02, $00 ; entry 15
    db $e0, $e8, $10, $20 ; entry 16
    db $e0, $f0, $06, $20 ; entry 17
    db $e0, $e0, $07, $20 ; entry 18
    db $d8, $f8, $00, $00 ; entry 19
    db $d8, $00, $17, $00 ; entry 20
    db $d8, $08, $03, $00 ; entry 21
    db $d8, $e8, $06, $20 ; entry 22
    db $d8, $e0, $07, $20 ; entry 23
    db $d8, $f0, $16, $00 ; entry 24
    db $d0, $08, $07, $40 ; entry 25
    db $d0, $f8, $10, $60 ; entry 26
    db $d0, $00, $10, $60 ; entry 27
    db $d0, $f0, $03, $60 ; entry 28
    db $80 ; end

; frame 6 of MetaSprites3FSet17; ends with $80 (E-0147)
MetaSprites3FSet17Frame6::
    db $80 ; end

; meta-sprite set 24 of MetaSprites3FTable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3FSet18::
    dw MetaSprites3FSet18Frame0 ; entry 0
    dw MetaSprites3FSet18Frame1 ; entry 1
    dw MetaSprites3FSet18Frame2 ; entry 2
    dw MetaSprites3FSet18Frame3 ; entry 3
    dw MetaSprites3FSet18Frame4 ; entry 4
    dw MetaSprites3FSet18Frame5 ; entry 5
    dw MetaSprites3FSet18Frame6 ; entry 6
    dw MetaSprites3FSet18Frame7 ; entry 7
    dw MetaSprites3FSet18Frame8 ; entry 8
    dw MetaSprites3FSet18Frame8 ; entry 9
    dw MetaSprites3FSet18Frame8 ; entry 10
    dw MetaSprites3FSet18Frame8 ; entry 11
    dw MetaSprites3FSet18Frame8 ; entry 12
    dw MetaSprites3FSet18Frame8 ; entry 13
    dw MetaSprites3FSet18Frame8 ; entry 14
    dw MetaSprites3FSet18Frame8 ; entry 15
    dw MetaSprites3FSet18Frame8 ; entry 16
    dw MetaSprites3FSet18Frame8 ; entry 17
    dw MetaSprites3FSet18Frame8 ; entry 18
    dw MetaSprites3FSet18Frame8 ; entry 19
    dw MetaSprites3FSet18Frame8 ; entry 20
    dw MetaSprites3FSet18Frame8 ; entry 21
    dw MetaSprites3FSet18Frame8 ; entry 22
    dw MetaSprites3FSet18Frame8 ; entry 23
    dw MetaSprites3FSet18Frame8 ; entry 24
    dw MetaSprites3FSet18Frame8 ; entry 25
    dw MetaSprites3FSet18Frame8 ; entry 26
    dw MetaSprites3FSet18Frame8 ; entry 27
    dw MetaSprites3FSet18Frame8 ; entry 28
    dw MetaSprites3FSet18Frame8 ; entry 29
    dw MetaSprites3FSet18Frame8 ; entry 30
    dw MetaSprites3FSet18Frame8 ; entry 31

; frame 0 of MetaSprites3FSet18; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet18Frame0::
    db $e8, $f8, $00, $10 ; entry 0
    db $e8, $00, $01, $10 ; entry 1
    db $f0, $f8, $02, $10 ; entry 2
    db $f0, $00, $03, $10 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites3FSet18; ends with $80 (E-0147)
MetaSprites3FSet18Frame1::
    db $e2, $f3, $00, $10 ; entry 0
    db $e2, $fb, $04, $10 ; entry 1
    db $e2, $03, $01, $10 ; entry 2
    db $ea, $f3, $06, $10 ; entry 3
    db $ea, $fb, $07, $10 ; entry 4
    db $ea, $03, $14, $10 ; entry 5
    db $f2, $f3, $0a, $10 ; entry 6
    db $f2, $fb, $0b, $10 ; entry 7
    db $f2, $03, $0c, $10 ; entry 8
    db $80 ; end

; frame 2 of MetaSprites3FSet18; ends with $80 (E-0147)
MetaSprites3FSet18Frame2::
    db $e2, $f0, $0d, $10 ; entry 0
    db $e2, $f8, $0e, $10 ; entry 1
    db $e2, $00, $0f, $10 ; entry 2
    db $e2, $08, $10, $10 ; entry 3
    db $ea, $f0, $11, $10 ; entry 4
    db $ea, $f8, $12, $10 ; entry 5
    db $ea, $00, $13, $10 ; entry 6
    db $ea, $08, $14, $10 ; entry 7
    db $f2, $f0, $15, $10 ; entry 8
    db $f2, $f8, $16, $10 ; entry 9
    db $f2, $00, $17, $10 ; entry 10
    db $f2, $08, $18, $10 ; entry 11
    db $80 ; end

; frame 3 of MetaSprites3FSet18; ends with $80 (E-0147)
MetaSprites3FSet18Frame3::
    db $d4, $ec, $0d, $10 ; entry 0
    db $d4, $f4, $0e, $10 ; entry 1
    db $d4, $fc, $0f, $10 ; entry 2
    db $d4, $04, $0e, $10 ; entry 3
    db $d4, $0c, $10, $10 ; entry 4
    db $dc, $ec, $11, $10 ; entry 5
    db $dc, $f4, $12, $10 ; entry 6
    db $dc, $fc, $13, $10 ; entry 7
    db $dc, $04, $12, $10 ; entry 8
    db $dc, $0c, $1a, $10 ; entry 9
    db $e4, $ec, $1b, $10 ; entry 10
    db $e4, $f4, $1c, $10 ; entry 11
    db $e4, $fc, $1d, $10 ; entry 12
    db $e4, $04, $1d, $10 ; entry 13
    db $e4, $0c, $1e, $10 ; entry 14
    db $e2, $14, $09, $10 ; entry 15
    db $ec, $ec, $1f, $10 ; entry 16
    db $ec, $f4, $20, $10 ; entry 17
    db $ec, $fc, $13, $10 ; entry 18
    db $ec, $04, $12, $10 ; entry 19
    db $ec, $0c, $21, $10 ; entry 20
    db $f4, $ec, $15, $10 ; entry 21
    db $f4, $f4, $16, $10 ; entry 22
    db $f4, $fc, $17, $10 ; entry 23
    db $f4, $04, $22, $10 ; entry 24
    db $f4, $0c, $23, $10 ; entry 25
    db $80 ; end

; frame 4 of MetaSprites3FSet18; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet18Frame4::
    db $d0, $e8, $0d, $10 ; entry 0
    db $d0, $f0, $0e, $10 ; entry 1
    db $d0, $f8, $01, $10 ; entry 2
    db $d0, $10, $01, $10 ; entry 3
    db $e8, $10, $01, $10 ; entry 4
    db $d0, $00, $00, $10 ; entry 5
    db $e8, $08, $00, $10 ; entry 6
    db $f0, $08, $02, $10 ; entry 7
    db $f0, $10, $03, $10 ; entry 8
    db $d8, $f8, $23, $10 ; entry 9
    db $d0, $08, $04, $10 ; entry 10
    db $d8, $00, $06, $10 ; entry 11
    db $d8, $08, $07, $10 ; entry 12
    db $d8, $f0, $07, $10 ; entry 13
    db $d8, $e8, $11, $10 ; entry 14
    db $f0, $e8, $11, $10 ; entry 15
    db $f0, $f0, $12, $10 ; entry 16
    db $f0, $f8, $13, $10 ; entry 17
    db $f0, $00, $14, $10 ; entry 18
    db $f8, $e8, $15, $10 ; entry 19
    db $f8, $f0, $16, $10 ; entry 20
    db $f8, $f8, $17, $10 ; entry 21
    db $f8, $00, $18, $10 ; entry 22
    db $e8, $e8, $0d, $10 ; entry 23
    db $e8, $f0, $0e, $10 ; entry 24
    db $e8, $f8, $0f, $10 ; entry 25
    db $e8, $00, $10, $10 ; entry 26
    db $d8, $10, $14, $10 ; entry 27
    db $e0, $00, $0a, $10 ; entry 28
    db $e0, $08, $0b, $10 ; entry 29
    db $e0, $10, $0c, $10 ; entry 30
    db $e0, $e8, $15, $10 ; entry 31
    db $e0, $f0, $18, $10 ; entry 32
    db $80 ; end

; frame 5 of MetaSprites3FSet18; ends with $80 (E-0147)
MetaSprites3FSet18Frame5::
    db $d0, $e8, $00, $10 ; entry 0
    db $d0, $f0, $01, $10 ; entry 1
    db $f0, $08, $00, $10 ; entry 2
    db $f0, $10, $01, $10 ; entry 3
    db $ea, $e8, $00, $10 ; entry 4
    db $ea, $f8, $01, $10 ; entry 5
    db $f8, $08, $02, $10 ; entry 6
    db $f8, $10, $03, $10 ; entry 7
    db $d8, $f0, $03, $10 ; entry 8
    db $ea, $f0, $04, $10 ; entry 9
    db $d0, $08, $04, $10 ; entry 10
    db $d0, $10, $01, $10 ; entry 11
    db $d8, $00, $0a, $10 ; entry 12
    db $fa, $e8, $0a, $10 ; entry 13
    db $d8, $08, $0b, $10 ; entry 14
    db $d8, $10, $0c, $10 ; entry 15
    db $fa, $f0, $0b, $10 ; entry 16
    db $fa, $f8, $0c, $10 ; entry 17
    db $d8, $e8, $11, $10 ; entry 18
    db $e0, $e8, $0a, $10 ; entry 19
    db $e0, $f0, $0a, $30 ; entry 20
    db $d0, $00, $0a, $50 ; entry 21
    db $f2, $e8, $06, $10 ; entry 22
    db $f2, $f0, $07, $10 ; entry 23
    db $f2, $f8, $14, $10 ; entry 24
    db $80 ; end

; frame 6 of MetaSprites3FSet18; ends with $80 (E-0147)
MetaSprites3FSet18Frame6::
    db $e8, $f8, $00, $10 ; entry 0
    db $e8, $00, $01, $10 ; entry 1
    db $cc, $07, $00, $10 ; entry 2
    db $cc, $0f, $01, $10 ; entry 3
    db $cd, $e7, $00, $10 ; entry 4
    db $cd, $ef, $01, $10 ; entry 5
    db $f0, $e8, $00, $10 ; entry 6
    db $f0, $f0, $00, $30 ; entry 7
    db $fb, $11, $00, $70 ; entry 8
    db $e0, $10, $00, $30 ; entry 9
    db $d4, $07, $02, $10 ; entry 10
    db $d4, $0f, $03, $10 ; entry 11
    db $f0, $f8, $02, $10 ; entry 12
    db $f0, $00, $03, $10 ; entry 13
    db $f8, $e8, $03, $30 ; entry 14
    db $f3, $11, $01, $10 ; entry 15
    db $e7, $0f, $0c, $10 ; entry 16
    db $d5, $e7, $0c, $30 ; entry 17
    db $d5, $ef, $00, $70 ; entry 18
    db $fb, $09, $0a, $10 ; entry 19
    db $e8, $08, $0a, $10 ; entry 20
    db $f4, $09, $0a, $50 ; entry 21
    db $e0, $08, $0a, $50 ; entry 22
    db $f8, $f0, $11, $30 ; entry 23
    db $80 ; end

; frame 7 of MetaSprites3FSet18; ends with $80 (E-0147)
MetaSprites3FSet18Frame7::
    db $eb, $fb, $00, $10 ; entry 0
    db $eb, $03, $01, $10 ; entry 1
    db $f3, $03, $00, $70 ; entry 2
    db $f3, $fb, $0c, $30 ; entry 3
    db $80 ; end

; frame 8 of MetaSprites3FSet18; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet18Frame8::
    db $80 ; end

; meta-sprite set 25 of MetaSprites3FTable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3FSet19::
    dw MetaSprites3FSet19Frame0 ; entry 0
    dw MetaSprites3FSet19Frame1 ; entry 1
    dw MetaSprites3FSet19Frame1 ; entry 2
    dw MetaSprites3FSet19Frame1 ; entry 3
    dw MetaSprites3FSet19Frame1 ; entry 4
    dw MetaSprites3FSet19Frame1 ; entry 5
    dw MetaSprites3FSet19Frame1 ; entry 6
    dw MetaSprites3FSet19Frame2 ; entry 7
    dw MetaSprites3FSet19Frame3 ; entry 8
    dw MetaSprites3FSet19Frame3 ; entry 9
    dw MetaSprites3FSet19Frame3 ; entry 10
    dw MetaSprites3FSet19Frame3 ; entry 11
    dw MetaSprites3FSet19Frame3 ; entry 12
    dw MetaSprites3FSet19Frame3 ; entry 13
    dw MetaSprites3FSet19Frame3 ; entry 14
    dw MetaSprites3FSet19Frame3 ; entry 15
    dw MetaSprites3FSet19Frame3 ; entry 16
    dw MetaSprites3FSet19Frame3 ; entry 17
    dw MetaSprites3FSet19Frame3 ; entry 18
    dw MetaSprites3FSet19Frame3 ; entry 19
    dw MetaSprites3FSet19Frame3 ; entry 20
    dw MetaSprites3FSet19Frame3 ; entry 21
    dw MetaSprites3FSet19Frame3 ; entry 22
    dw MetaSprites3FSet19Frame3 ; entry 23
    dw MetaSprites3FSet19Frame3 ; entry 24
    dw MetaSprites3FSet19Frame3 ; entry 25
    dw MetaSprites3FSet19Frame3 ; entry 26
    dw MetaSprites3FSet19Frame3 ; entry 27
    dw MetaSprites3FSet19Frame3 ; entry 28
    dw MetaSprites3FSet19Frame3 ; entry 29
    dw MetaSprites3FSet19Frame3 ; entry 30
    dw MetaSprites3FSet19Frame3 ; entry 31

; frame 0 of MetaSprites3FSet19; ends with $80 (E-0147)
MetaSprites3FSet19Frame0::
    db $d0, $e8, $00, $10 ; entry 0
    db $d0, $f0, $01, $10 ; entry 1
    db $d0, $f8, $02, $10 ; entry 2
    db $d0, $00, $03, $10 ; entry 3
    db $d0, $08, $04, $10 ; entry 4
    db $d0, $10, $05, $10 ; entry 5
    db $d8, $e8, $06, $10 ; entry 6
    db $d8, $f0, $07, $10 ; entry 7
    db $d8, $f8, $08, $10 ; entry 8
    db $d8, $00, $09, $10 ; entry 9
    db $d8, $08, $0a, $10 ; entry 10
    db $d8, $10, $0b, $10 ; entry 11
    db $e0, $e8, $01, $10 ; entry 12
    db $e0, $f0, $02, $10 ; entry 13
    db $e0, $f8, $03, $10 ; entry 14
    db $e0, $00, $0c, $10 ; entry 15
    db $e0, $08, $05, $10 ; entry 16
    db $e0, $10, $00, $10 ; entry 17
    db $e8, $10, $00, $10 ; entry 18
    db $f0, $10, $00, $10 ; entry 19
    db $f8, $10, $00, $10 ; entry 20
    db $f8, $08, $00, $10 ; entry 21
    db $f0, $08, $00, $10 ; entry 22
    db $f8, $f8, $00, $10 ; entry 23
    db $e8, $e8, $07, $10 ; entry 24
    db $e8, $f0, $08, $10 ; entry 25
    db $e8, $f8, $0d, $10 ; entry 26
    db $e8, $00, $00, $10 ; entry 27
    db $e8, $08, $0b, $10 ; entry 28
    db $f0, $e8, $02, $10 ; entry 29
    db $f0, $f0, $0e, $10 ; entry 30
    db $f0, $f8, $0f, $10 ; entry 31
    db $f0, $00, $10, $10 ; entry 32
    db $f8, $f0, $11, $10 ; entry 33
    db $f8, $e8, $0b, $10 ; entry 34
    db $f8, $00, $0b, $10 ; entry 35
    db $80 ; end

; frame 1 of MetaSprites3FSet19; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet19Frame1::
    db $d0, $e8, $50, $10 ; entry 0
    db $d0, $f0, $51, $10 ; entry 1
    db $d0, $f8, $52, $10 ; entry 2
    db $d0, $00, $53, $10 ; entry 3
    db $d0, $08, $54, $10 ; entry 4
    db $d0, $10, $55, $10 ; entry 5
    db $d8, $e8, $60, $10 ; entry 6
    db $d8, $f0, $61, $10 ; entry 7
    db $d8, $f8, $62, $10 ; entry 8
    db $d8, $00, $63, $10 ; entry 9
    db $d8, $08, $64, $10 ; entry 10
    db $d8, $10, $65, $10 ; entry 11
    db $e0, $e8, $70, $10 ; entry 12
    db $e0, $f0, $71, $10 ; entry 13
    db $e0, $f8, $72, $10 ; entry 14
    db $e0, $00, $73, $10 ; entry 15
    db $e0, $08, $74, $10 ; entry 16
    db $e0, $10, $75, $10 ; entry 17
    db $e8, $e8, $80, $10 ; entry 18
    db $e8, $f0, $81, $10 ; entry 19
    db $e8, $f8, $82, $10 ; entry 20
    db $e8, $00, $83, $10 ; entry 21
    db $e8, $08, $84, $10 ; entry 22
    db $e8, $10, $85, $10 ; entry 23
    db $f0, $e8, $90, $10 ; entry 24
    db $f0, $f0, $91, $10 ; entry 25
    db $f0, $f8, $92, $10 ; entry 26
    db $f0, $00, $93, $10 ; entry 27
    db $f0, $08, $94, $10 ; entry 28
    db $f0, $10, $95, $10 ; entry 29
    db $f8, $e8, $a0, $10 ; entry 30
    db $f8, $f0, $a1, $10 ; entry 31
    db $f8, $f8, $a2, $10 ; entry 32
    db $f8, $00, $a3, $10 ; entry 33
    db $f8, $08, $a4, $10 ; entry 34
    db $f8, $10, $a5, $10 ; entry 35
    db $80 ; end

; frame 2 of MetaSprites3FSet19; ends with $80 (E-0147)
MetaSprites3FSet19Frame2::
    db $d8, $e8, $50, $10 ; entry 0
    db $d8, $f0, $51, $10 ; entry 1
    db $d8, $f8, $52, $10 ; entry 2
    db $d8, $00, $53, $10 ; entry 3
    db $d8, $08, $54, $10 ; entry 4
    db $d8, $10, $55, $10 ; entry 5
    db $e0, $e8, $60, $10 ; entry 6
    db $e0, $f0, $61, $10 ; entry 7
    db $e0, $f8, $62, $10 ; entry 8
    db $e0, $00, $63, $10 ; entry 9
    db $e0, $08, $64, $10 ; entry 10
    db $e0, $10, $65, $10 ; entry 11
    db $e8, $e8, $70, $10 ; entry 12
    db $e8, $f0, $71, $10 ; entry 13
    db $e8, $f8, $72, $10 ; entry 14
    db $e8, $00, $73, $10 ; entry 15
    db $e8, $08, $74, $10 ; entry 16
    db $e8, $10, $75, $10 ; entry 17
    db $f0, $e8, $80, $10 ; entry 18
    db $f0, $f0, $81, $10 ; entry 19
    db $f0, $f8, $82, $10 ; entry 20
    db $f0, $00, $83, $10 ; entry 21
    db $f0, $08, $84, $10 ; entry 22
    db $f0, $10, $85, $10 ; entry 23
    db $f8, $e8, $90, $10 ; entry 24
    db $f8, $f0, $91, $10 ; entry 25
    db $f8, $f8, $92, $10 ; entry 26
    db $f8, $00, $93, $10 ; entry 27
    db $f8, $08, $94, $10 ; entry 28
    db $f8, $10, $95, $10 ; entry 29
    db $d0, $e8, $88, $10 ; entry 30
    db $d0, $f0, $88, $10 ; entry 31
    db $d0, $f8, $88, $10 ; entry 32
    db $d0, $00, $88, $10 ; entry 33
    db $d0, $08, $88, $10 ; entry 34
    db $d0, $10, $88, $10 ; entry 35
    db $80 ; end

; frame 3 of MetaSprites3FSet19; ends with $80 (E-0147)
MetaSprites3FSet19Frame3::
    db $80 ; end

; meta-sprite set 26 of MetaSprites3FTable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3FSet1A::
    dw MetaSprites3FSet1AFrame0 ; entry 0
    dw MetaSprites3FSet1AFrame1 ; entry 1
    dw MetaSprites3FSet1AFrame2 ; entry 2
    dw MetaSprites3FSet1AFrame3 ; entry 3
    dw MetaSprites3FSet1AFrame4 ; entry 4
    dw MetaSprites3FSet1AFrame5 ; entry 5
    dw MetaSprites3FSet1AFrame6 ; entry 6
    dw MetaSprites3FSet1AFrame7 ; entry 7
    dw MetaSprites3FSet1AFrame8 ; entry 8
    dw MetaSprites3FSet1AFrame9 ; entry 9
    dw MetaSprites3FSet1AFrame10 ; entry 10
    dw MetaSprites3FSet1AFrame11 ; entry 11
    dw MetaSprites3FSet1AFrame12 ; entry 12
    dw MetaSprites3FSet1AFrame13 ; entry 13
    dw MetaSprites3FSet1AFrame14 ; entry 14
    dw MetaSprites3FSet1AFrame15 ; entry 15
    dw MetaSprites3FSet1AFrame16 ; entry 16
    dw MetaSprites3FSet1AFrame17 ; entry 17
    dw MetaSprites3FSet1AFrame18 ; entry 18
    dw MetaSprites3FSet1AFrame19 ; entry 19
    dw MetaSprites3FSet1AFrame19 ; entry 20
    dw MetaSprites3FSet1AFrame19 ; entry 21
    dw MetaSprites3FSet1AFrame19 ; entry 22
    dw MetaSprites3FSet1AFrame19 ; entry 23
    dw MetaSprites3FSet1AFrame19 ; entry 24
    dw MetaSprites3FSet1AFrame19 ; entry 25
    dw MetaSprites3FSet1AFrame19 ; entry 26
    dw MetaSprites3FSet1AFrame19 ; entry 27
    dw MetaSprites3FSet1AFrame19 ; entry 28
    dw MetaSprites3FSet1AFrame19 ; entry 29
    dw MetaSprites3FSet1AFrame19 ; entry 30
    dw MetaSprites3FSet1AFrame19 ; entry 31

; frame 0 of MetaSprites3FSet1A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet1AFrame0::
    db $d0, $01, $2e, $00 ; entry 0
    db $d8, $01, $2e, $60 ; entry 1
    db $80 ; end

; frame 1 of MetaSprites3FSet1A; ends with $80 (E-0147)
MetaSprites3FSet1AFrame1::
    db $e0, $fc, $2e, $00 ; entry 0
    db $e8, $fc, $2e, $60 ; entry 1
    db $f0, $f7, $2e, $00 ; entry 2
    db $f8, $f7, $2e, $60 ; entry 3
    db $d0, $01, $2e, $00 ; entry 4
    db $d8, $01, $2e, $60 ; entry 5
    db $80 ; end

; frame 2 of MetaSprites3FSet1A; ends with $80 (E-0147)
MetaSprites3FSet1AFrame2::
    db $f0, $f7, $2e, $00 ; entry 0
    db $f8, $f7, $2e, $60 ; entry 1
    db $e8, $fc, $2f, $60 ; entry 2
    db $e0, $fc, $2f, $00 ; entry 3
    db $80 ; end

; frame 3 of MetaSprites3FSet1A; ends with $80 (E-0147)
MetaSprites3FSet1AFrame3::
    db $d0, $d8, $00, $00 ; entry 0
    db $d4, $ec, $02, $00 ; entry 1
    db $d0, $f8, $04, $00 ; entry 2
    db $e0, $d8, $02, $00 ; entry 3
    db $d0, $08, $00, $00 ; entry 4
    db $d4, $1c, $02, $60 ; entry 5
    db $d0, $28, $04, $40 ; entry 6
    db $d0, $b8, $00, $00 ; entry 7
    db $d0, $38, $02, $00 ; entry 8
    db $dc, $f4, $01, $00 ; entry 9
    db $e0, $32, $00, $00 ; entry 10
    db $d4, $c9, $02, $60 ; entry 11
    db $d8, $07, $02, $00 ; entry 12
    db $e0, $06, $00, $00 ; entry 13
    db $dc, $c8, $01, $00 ; entry 14
    db $d8, $27, $00, $00 ; entry 15
    db $d0, $14, $03, $00 ; entry 16
    db $80 ; end

; frame 4 of MetaSprites3FSet1A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet1AFrame4::
    db $e0, $d8, $02, $00 ; entry 0
    db $e4, $e9, $02, $00 ; entry 1
    db $ec, $f1, $01, $00 ; entry 2
    db $f0, $04, $02, $00 ; entry 3
    db $e0, $06, $01, $00 ; entry 4
    db $e8, $05, $01, $00 ; entry 5
    db $e4, $c7, $02, $60 ; entry 6
    db $ec, $c6, $01, $00 ; entry 7
    db $e0, $b6, $00, $00 ; entry 8
    db $d8, $d7, $00, $00 ; entry 9
    db $e0, $36, $02, $00 ; entry 10
    db $f0, $30, $00, $20 ; entry 11
    db $e0, $12, $03, $40 ; entry 12
    db $e0, $26, $03, $00 ; entry 13
    db $e8, $25, $02, $00 ; entry 14
    db $e4, $1a, $01, $60 ; entry 15
    db $e0, $f5, $04, $20 ; entry 16
    db $d0, $e8, $0c, $00 ; entry 17
    db $d8, $24, $11, $00 ; entry 18
    db $d0, $28, $10, $00 ; entry 19
    db $d0, $20, $0f, $00 ; entry 20
    db $80 ; end

; frame 5 of MetaSprites3FSet1A; ends with $80 (E-0147)
MetaSprites3FSet1AFrame5::
    db $e8, $1c, $02, $60 ; entry 0
    db $e4, $0b, $02, $60 ; entry 1
    db $dc, $03, $01, $60 ; entry 2
    db $d8, $f0, $02, $60 ; entry 3
    db $e8, $ee, $01, $60 ; entry 4
    db $e0, $ef, $01, $60 ; entry 5
    db $e4, $2d, $02, $00 ; entry 6
    db $dc, $2e, $01, $60 ; entry 7
    db $f0, $1d, $00, $60 ; entry 8
    db $e8, $be, $02, $60 ; entry 9
    db $d8, $c4, $00, $40 ; entry 10
    db $e8, $e2, $03, $20 ; entry 11
    db $e8, $ce, $03, $60 ; entry 12
    db $e0, $cf, $02, $60 ; entry 13
    db $e4, $da, $01, $00 ; entry 14
    db $e8, $ff, $04, $40 ; entry 15
    db $d0, $d0, $09, $00 ; entry 16
    db $d0, $d8, $0a, $00 ; entry 17
    db $d0, $00, $1a, $00 ; entry 18
    db $d0, $08, $1b, $00 ; entry 19
    db $80 ; end

; frame 6 of MetaSprites3FSet1A; ends with $80 (E-0147)
MetaSprites3FSet1AFrame6::
    db $f0, $d6, $02, $00 ; entry 0
    db $f4, $e7, $02, $00 ; entry 1
    db $f8, $03, $01, $00 ; entry 2
    db $e8, $d5, $00, $20 ; entry 3
    db $f0, $34, $02, $00 ; entry 4
    db $f8, $23, $02, $00 ; entry 5
    db $f4, $18, $01, $60 ; entry 6
    db $f0, $f3, $04, $20 ; entry 7
    db $f0, $24, $04, $00 ; entry 8
    db $f0, $10, $03, $00 ; entry 9
    db $f0, $04, $02, $00 ; entry 10
    db $f0, $b4, $02, $00 ; entry 11
    db $f4, $c5, $01, $00 ; entry 12
    db $e8, $1c, $11, $00 ; entry 13
    db $e0, $20, $10, $00 ; entry 14
    db $e0, $18, $0f, $00 ; entry 15
    db $d8, $18, $0d, $00 ; entry 16
    db $d8, $20, $0e, $00 ; entry 17
    db $e0, $e0, $0c, $00 ; entry 18
    db $d8, $e0, $0b, $00 ; entry 19
    db $d8, $c4, $11, $00 ; entry 20
    db $d0, $c8, $10, $00 ; entry 21
    db $d0, $c0, $0f, $00 ; entry 22
    db $d0, $48, $0c, $00 ; entry 23
    db $d0, $d8, $03, $00 ; entry 24
    db $d8, $f0, $01, $60 ; entry 25
    db $d8, $40, $02, $00 ; entry 26
    db $e0, $30, $04, $00 ; entry 27
    db $d0, $10, $02, $00 ; entry 28
    db $80 ; end

; frame 7 of MetaSprites3FSet1A; ends with $80 (E-0147)
MetaSprites3FSet1AFrame7::
    db $f0, $1b, $02, $60 ; entry 0
    db $ec, $0a, $02, $60 ; entry 1
    db $e8, $ee, $01, $60 ; entry 2
    db $f8, $1c, $00, $40 ; entry 3
    db $f0, $bd, $02, $60 ; entry 4
    db $ec, $d9, $01, $00 ; entry 5
    db $f0, $fe, $04, $40 ; entry 6
    db $f0, $cd, $04, $60 ; entry 7
    db $f0, $e1, $03, $60 ; entry 8
    db $f0, $ed, $02, $60 ; entry 9
    db $ec, $2c, $01, $60 ; entry 10
    db $e0, $f8, $1a, $00 ; entry 11
    db $e0, $00, $1b, $00 ; entry 12
    db $d8, $f8, $17, $00 ; entry 13
    db $d8, $00, $18, $00 ; entry 14
    db $d8, $08, $19, $00 ; entry 15
    db $d0, $f8, $14, $00 ; entry 16
    db $d0, $00, $15, $00 ; entry 17
    db $d0, $08, $16, $00 ; entry 18
    db $e8, $c8, $09, $00 ; entry 19
    db $e8, $d0, $0a, $00 ; entry 20
    db $e0, $c8, $07, $40 ; entry 21
    db $e0, $d0, $08, $40 ; entry 22
    db $d0, $30, $23, $00 ; entry 23
    db $d0, $38, $24, $00 ; entry 24
    db $d8, $30, $25, $00 ; entry 25
    db $d8, $e0, $07, $00 ; entry 26
    db $d8, $e8, $08, $00 ; entry 27
    db $d0, $e0, $05, $00 ; entry 28
    db $d0, $e8, $06, $00 ; entry 29
    db $d8, $18, $00, $40 ; entry 30
    db $d0, $28, $01, $60 ; entry 31
    db $d0, $d8, $02, $60 ; entry 32
    db $d8, $c0, $02, $60 ; entry 33
    db $e0, $b0, $04, $40 ; entry 34
    db $80 ; end

; frame 8 of MetaSprites3FSet1A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet1AFrame8::
    db $f8, $14, $11, $00 ; entry 0
    db $f0, $18, $10, $00 ; entry 1
    db $f0, $10, $0f, $00 ; entry 2
    db $e8, $10, $0d, $00 ; entry 3
    db $e8, $18, $0e, $00 ; entry 4
    db $f0, $d8, $0c, $00 ; entry 5
    db $e8, $d8, $0b, $00 ; entry 6
    db $e8, $bc, $11, $00 ; entry 7
    db $e0, $c0, $10, $00 ; entry 8
    db $e0, $b8, $0f, $00 ; entry 9
    db $d8, $b8, $0d, $00 ; entry 10
    db $d8, $c0, $0e, $00 ; entry 11
    db $e8, $3c, $0c, $00 ; entry 12
    db $e0, $3c, $0b, $00 ; entry 13
    db $d0, $10, $2b, $00 ; entry 14
    db $d0, $18, $2c, $00 ; entry 15
    db $d0, $20, $2d, $00 ; entry 16
    db $d8, $d0, $1a, $00 ; entry 17
    db $d8, $d8, $1b, $00 ; entry 18
    db $d0, $d0, $17, $00 ; entry 19
    db $d0, $d8, $18, $00 ; entry 20
    db $d0, $e0, $19, $00 ; entry 21
    db $e0, $e0, $01, $00 ; entry 22
    db $e0, $10, $03, $00 ; entry 23
    db $e8, $f0, $04, $00 ; entry 24
    db $d0, $3c, $02, $00 ; entry 25
    db $f0, $b0, $00, $00 ; entry 26
    db $f0, $28, $01, $00 ; entry 27
    db $d0, $00, $02, $00 ; entry 28
    db $80 ; end

; frame 9 of MetaSprites3FSet1A; ends with $80 (E-0147)
MetaSprites3FSet1AFrame9::
    db $f0, $f0, $1a, $00 ; entry 0
    db $f0, $f8, $1b, $00 ; entry 1
    db $e8, $f0, $17, $00 ; entry 2
    db $e8, $f8, $18, $00 ; entry 3
    db $e8, $00, $19, $00 ; entry 4
    db $e0, $f0, $14, $00 ; entry 5
    db $e0, $f8, $15, $00 ; entry 6
    db $e0, $00, $16, $00 ; entry 7
    db $d8, $f4, $12, $00 ; entry 8
    db $d8, $fc, $13, $00 ; entry 9
    db $f8, $bc, $07, $40 ; entry 10
    db $f8, $c4, $08, $40 ; entry 11
    db $f0, $24, $25, $00 ; entry 12
    db $e8, $24, $23, $00 ; entry 13
    db $e8, $2c, $24, $00 ; entry 14
    db $e0, $28, $21, $00 ; entry 15
    db $e0, $30, $22, $00 ; entry 16
    db $d8, $30, $20, $00 ; entry 17
    db $d8, $28, $1f, $00 ; entry 18
    db $d0, $2a, $1d, $00 ; entry 19
    db $d0, $32, $1e, $00 ; entry 20
    db $e8, $d8, $07, $00 ; entry 21
    db $e8, $e0, $08, $00 ; entry 22
    db $e0, $d8, $05, $00 ; entry 23
    db $e0, $e0, $06, $00 ; entry 24
    db $d0, $c0, $03, $00 ; entry 25
    db $e8, $c8, $01, $00 ; entry 26
    db $e0, $1c, $03, $00 ; entry 27
    db $d8, $48, $02, $00 ; entry 28
    db $f8, $48, $01, $00 ; entry 29
    db $f8, $08, $00, $00 ; entry 30
    db $f8, $e0, $03, $00 ; entry 31
    db $d0, $08, $02, $00 ; entry 32
    db $80 ; end

; frame 10 of MetaSprites3FSet1A; ends with $80 (E-0147)
MetaSprites3FSet1AFrame10::
    db $f8, $08, $0d, $00 ; entry 0
    db $f8, $10, $0e, $00 ; entry 1
    db $f8, $d4, $0c, $00 ; entry 2
    db $f0, $d4, $0b, $00 ; entry 3
    db $f8, $b4, $11, $00 ; entry 4
    db $f0, $b8, $10, $00 ; entry 5
    db $f0, $b0, $0f, $00 ; entry 6
    db $e8, $b0, $0d, $00 ; entry 7
    db $e8, $b8, $0e, $00 ; entry 8
    db $f8, $30, $0b, $00 ; entry 9
    db $e0, $08, $2b, $00 ; entry 10
    db $e0, $10, $2c, $00 ; entry 11
    db $e0, $18, $2d, $00 ; entry 12
    db $d8, $08, $28, $00 ; entry 13
    db $d8, $10, $29, $00 ; entry 14
    db $d8, $18, $2a, $00 ; entry 15
    db $d0, $10, $26, $00 ; entry 16
    db $d0, $18, $27, $00 ; entry 17
    db $e8, $c8, $1a, $00 ; entry 18
    db $e8, $d0, $1b, $00 ; entry 19
    db $e0, $c8, $17, $00 ; entry 20
    db $e0, $d0, $18, $00 ; entry 21
    db $e0, $d8, $19, $00 ; entry 22
    db $d8, $c8, $14, $00 ; entry 23
    db $d8, $d0, $15, $00 ; entry 24
    db $d8, $d8, $16, $00 ; entry 25
    db $d0, $cc, $12, $00 ; entry 26
    db $d0, $d4, $13, $00 ; entry 27
    db $f0, $08, $03, $00 ; entry 28
    db $f8, $f0, $04, $00 ; entry 29
    db $e8, $dc, $01, $00 ; entry 30
    db $e8, $30, $02, $00 ; entry 31
    db $e0, $f8, $03, $00 ; entry 32
    db $d8, $b0, $01, $00 ; entry 33
    db $e0, $40, $00, $00 ; entry 34
    db $80 ; end

; frame 11 of MetaSprites3FSet1A; ends with $80 (E-0147)
MetaSprites3FSet1AFrame11::
    db $f8, $e4, $12, $00 ; entry 0
    db $f8, $ec, $13, $00 ; entry 1
    db $f8, $18, $21, $00 ; entry 2
    db $f8, $20, $22, $00 ; entry 3
    db $f0, $20, $20, $00 ; entry 4
    db $f0, $18, $1f, $00 ; entry 5
    db $e8, $1a, $1d, $00 ; entry 6
    db $e8, $22, $1e, $00 ; entry 7
    db $e0, $22, $1c, $00 ; entry 8
    db $f8, $d0, $07, $00 ; entry 9
    db $f8, $d8, $08, $00 ; entry 10
    db $f0, $d0, $05, $00 ; entry 11
    db $f0, $d8, $06, $00 ; entry 12
    db $d8, $e0, $2b, $00 ; entry 13
    db $d8, $e8, $2c, $00 ; entry 14
    db $d8, $f0, $2d, $00 ; entry 15
    db $d0, $e0, $28, $00 ; entry 16
    db $d0, $e8, $29, $00 ; entry 17
    db $d0, $f0, $2a, $00 ; entry 18
    db $d0, $40, $09, $00 ; entry 19
    db $d0, $48, $0a, $00 ; entry 20
    db $f8, $c0, $01, $00 ; entry 21
    db $f8, $0c, $03, $00 ; entry 22
    db $f0, $38, $02, $00 ; entry 23
    db $d0, $30, $03, $00 ; entry 24
    db $d8, $b8, $03, $00 ; entry 25
    db $d8, $08, $04, $00 ; entry 26
    db $e0, $d8, $00, $00 ; entry 27
    db $e8, $b0, $01, $00 ; entry 28
    db $f0, $48, $01, $00 ; entry 29
    db $e8, $f0, $00, $00 ; entry 30
    db $e0, $40, $02, $00 ; entry 31
    db $80 ; end

; frame 12 of MetaSprites3FSet1A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet1AFrame12::
    db $f8, $b0, $0e, $00 ; entry 0
    db $f8, $c0, $1a, $00 ; entry 1
    db $f8, $c8, $1b, $00 ; entry 2
    db $f0, $c0, $17, $00 ; entry 3
    db $f0, $c8, $18, $00 ; entry 4
    db $f0, $d0, $19, $00 ; entry 5
    db $e8, $c0, $14, $00 ; entry 6
    db $e8, $c8, $15, $00 ; entry 7
    db $e8, $d0, $16, $00 ; entry 8
    db $e0, $c4, $12, $00 ; entry 9
    db $e0, $cc, $13, $00 ; entry 10
    db $f0, $00, $2b, $00 ; entry 11
    db $f0, $08, $2c, $00 ; entry 12
    db $f0, $10, $2d, $00 ; entry 13
    db $e8, $00, $28, $00 ; entry 14
    db $e8, $08, $29, $00 ; entry 15
    db $e8, $10, $2a, $00 ; entry 16
    db $e0, $08, $26, $00 ; entry 17
    db $e0, $10, $27, $00 ; entry 18
    db $d0, $e8, $0c, $00 ; entry 19
    db $d8, $24, $11, $00 ; entry 20
    db $d0, $28, $10, $00 ; entry 21
    db $d0, $20, $0f, $00 ; entry 22
    db $f0, $f0, $03, $00 ; entry 23
    db $f8, $28, $02, $00 ; entry 24
    db $f0, $38, $00, $00 ; entry 25
    db $e0, $b8, $04, $00 ; entry 26
    db $d0, $b8, $00, $00 ; entry 27
    db $d8, $d0, $02, $00 ; entry 28
    db $e8, $e0, $03, $00 ; entry 29
    db $d0, $08, $01, $00 ; entry 30
    db $e0, $30, $00, $00 ; entry 31
    db $80 ; end

; frame 13 of MetaSprites3FSet1A; ends with $80 (E-0147)
MetaSprites3FSet1AFrame13::
    db $f8, $06, $1c, $00 ; entry 0
    db $e8, $d8, $2b, $00 ; entry 1
    db $e8, $e0, $2c, $00 ; entry 2
    db $e8, $e8, $2d, $00 ; entry 3
    db $e0, $d8, $28, $00 ; entry 4
    db $e0, $e0, $29, $00 ; entry 5
    db $e0, $e8, $2a, $00 ; entry 6
    db $d8, $e0, $26, $00 ; entry 7
    db $d8, $e8, $27, $00 ; entry 8
    db $e0, $38, $09, $00 ; entry 9
    db $e0, $40, $0a, $00 ; entry 10
    db $d8, $38, $05, $00 ; entry 11
    db $d8, $40, $06, $00 ; entry 12
    db $e8, $b0, $03, $00 ; entry 13
    db $e0, $28, $03, $00 ; entry 14
    db $d0, $10, $02, $00 ; entry 15
    db $f0, $c8, $01, $00 ; entry 16
    db $d0, $f8, $00, $00 ; entry 17
    db $d0, $d0, $00, $00 ; entry 18
    db $f8, $20, $03, $00 ; entry 19
    db $f0, $e8, $04, $00 ; entry 20
    db $e8, $10, $02, $00 ; entry 21
    db $f0, $40, $01, $00 ; entry 22
    db $80 ; end

; frame 14 of MetaSprites3FSet1A; ends with $80 (E-0147)
MetaSprites3FSet1AFrame14::
    db $e8, $1c, $11, $00 ; entry 0
    db $e0, $20, $10, $00 ; entry 1
    db $e0, $18, $0f, $00 ; entry 2
    db $d8, $18, $0d, $00 ; entry 3
    db $d8, $20, $0e, $00 ; entry 4
    db $e0, $e0, $0c, $00 ; entry 5
    db $d8, $e0, $0b, $00 ; entry 6
    db $d0, $48, $0c, $00 ; entry 7
    db $d8, $c4, $11, $00 ; entry 8
    db $d0, $c8, $10, $00 ; entry 9
    db $d0, $c0, $0f, $00 ; entry 10
    db $f8, $f8, $28, $00 ; entry 11
    db $f8, $00, $29, $00 ; entry 12
    db $f8, $08, $2a, $00 ; entry 13
    db $f0, $00, $26, $00 ; entry 14
    db $f0, $08, $27, $00 ; entry 15
    db $f8, $b8, $14, $00 ; entry 16
    db $f8, $c0, $15, $00 ; entry 17
    db $f8, $c8, $16, $00 ; entry 18
    db $f0, $bc, $12, $00 ; entry 19
    db $f0, $c4, $13, $00 ; entry 20
    db $e0, $08, $02, $00 ; entry 21
    db $e0, $f0, $00, $00 ; entry 22
    db $f0, $24, $03, $00 ; entry 23
    db $f8, $b0, $03, $00 ; entry 24
    db $e8, $48, $02, $00 ; entry 25
    db $f8, $38, $01, $00 ; entry 26
    db $d0, $00, $00, $00 ; entry 27
    db $e8, $d0, $02, $00 ; entry 28
    db $80 ; end

; frame 15 of MetaSprites3FSet1A; ends with $80 (E-0147)
MetaSprites3FSet1AFrame15::
    db $e0, $f8, $1a, $00 ; entry 0
    db $e0, $00, $1b, $00 ; entry 1
    db $d8, $f8, $17, $00 ; entry 2
    db $d8, $00, $18, $00 ; entry 3
    db $d8, $08, $19, $00 ; entry 4
    db $d0, $f8, $14, $00 ; entry 5
    db $d0, $00, $15, $00 ; entry 6
    db $d0, $08, $16, $00 ; entry 7
    db $d0, $30, $23, $00 ; entry 8
    db $d0, $38, $24, $00 ; entry 9
    db $d8, $30, $25, $00 ; entry 10
    db $d8, $e0, $07, $00 ; entry 11
    db $d8, $e8, $08, $00 ; entry 12
    db $d0, $e0, $05, $00 ; entry 13
    db $d0, $e8, $06, $00 ; entry 14
    db $f8, $d0, $2b, $00 ; entry 15
    db $f8, $d8, $2c, $00 ; entry 16
    db $f8, $e0, $2d, $00 ; entry 17
    db $f0, $d0, $28, $00 ; entry 18
    db $f0, $d8, $29, $00 ; entry 19
    db $f0, $e0, $2a, $00 ; entry 20
    db $e8, $d8, $26, $00 ; entry 21
    db $e8, $e0, $27, $00 ; entry 22
    db $f0, $30, $09, $00 ; entry 23
    db $f0, $38, $0a, $00 ; entry 24
    db $e8, $30, $05, $00 ; entry 25
    db $e8, $38, $06, $00 ; entry 26
    db $f0, $18, $04, $00 ; entry 27
    db $e0, $20, $03, $00 ; entry 28
    db $f0, $b8, $02, $00 ; entry 29
    db $f8, $f8, $01, $00 ; entry 30
    db $d9, $b8, $00, $00 ; entry 31
    db $d1, $d0, $00, $00 ; entry 32
    db $d8, $40, $01, $00 ; entry 33
    db $f8, $40, $00, $00 ; entry 34
    db $80 ; end

; frame 16 of MetaSprites3FSet1A; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet1AFrame16::
    db $f8, $14, $11, $00 ; entry 0
    db $f0, $18, $10, $00 ; entry 1
    db $f0, $10, $0f, $00 ; entry 2
    db $e8, $10, $0d, $00 ; entry 3
    db $e8, $18, $0e, $00 ; entry 4
    db $f0, $d8, $0c, $00 ; entry 5
    db $e8, $d8, $0b, $00 ; entry 6
    db $e0, $48, $0c, $00 ; entry 7
    db $d8, $48, $0b, $00 ; entry 8
    db $f0, $b8, $11, $00 ; entry 9
    db $e8, $bc, $10, $00 ; entry 10
    db $e8, $b4, $0f, $00 ; entry 11
    db $e0, $b4, $0d, $00 ; entry 12
    db $e0, $bc, $0e, $00 ; entry 13
    db $d0, $10, $2b, $00 ; entry 14
    db $d0, $18, $2c, $00 ; entry 15
    db $d0, $20, $2d, $00 ; entry 16
    db $d8, $d0, $1a, $00 ; entry 17
    db $d8, $d8, $1b, $00 ; entry 18
    db $d0, $d0, $17, $00 ; entry 19
    db $d0, $d8, $18, $00 ; entry 20
    db $d0, $e0, $19, $00 ; entry 21
    db $f8, $00, $04, $00 ; entry 22
    db $e0, $f8, $01, $00 ; entry 23
    db $f8, $c0, $00, $00 ; entry 24
    db $e8, $30, $02, $00 ; entry 25
    db $f8, $e8, $03, $00 ; entry 26
    db $d0, $f0, $01, $00 ; entry 27
    db $80 ; end

; frame 17 of MetaSprites3FSet1A; ends with $80 (E-0147)
MetaSprites3FSet1AFrame17::
    db $f8, $d0, $26, $00 ; entry 0
    db $f8, $d8, $27, $00 ; entry 1
    db $f8, $28, $05, $00 ; entry 2
    db $f8, $30, $06, $00 ; entry 3
    db $f0, $f0, $1a, $00 ; entry 4
    db $f0, $f8, $1b, $00 ; entry 5
    db $e8, $f0, $17, $00 ; entry 6
    db $e8, $f8, $18, $00 ; entry 7
    db $e8, $00, $19, $00 ; entry 8
    db $e0, $f0, $14, $00 ; entry 9
    db $e0, $f8, $15, $00 ; entry 10
    db $e0, $00, $16, $00 ; entry 11
    db $d8, $f4, $12, $00 ; entry 12
    db $d8, $fc, $13, $00 ; entry 13
    db $f0, $24, $25, $00 ; entry 14
    db $e8, $24, $23, $00 ; entry 15
    db $e8, $2c, $24, $00 ; entry 16
    db $e0, $28, $21, $00 ; entry 17
    db $e0, $30, $22, $00 ; entry 18
    db $e8, $d8, $07, $00 ; entry 19
    db $e8, $e0, $08, $00 ; entry 20
    db $e0, $d8, $05, $00 ; entry 21
    db $e0, $e0, $06, $00 ; entry 22
    db $d8, $32, $20, $00 ; entry 23
    db $d8, $2a, $1f, $00 ; entry 24
    db $d0, $2c, $1d, $00 ; entry 25
    db $d0, $34, $1e, $00 ; entry 26
    db $f0, $b8, $00, $00 ; entry 27
    db $f0, $40, $04, $00 ; entry 28
    db $e0, $c8, $03, $00 ; entry 29
    db $f8, $08, $02, $00 ; entry 30
    db $e0, $18, $01, $00 ; entry 31
    db $d0, $04, $02, $00 ; entry 32
    db $80 ; end

; frame 18 of MetaSprites3FSet1A; ends with $80 (E-0147)
MetaSprites3FSet1AFrame18::
    db $f8, $e4, $12, $00 ; entry 0
    db $f8, $ec, $13, $00 ; entry 1
    db $f8, $18, $21, $00 ; entry 2
    db $f8, $20, $22, $00 ; entry 3
    db $f8, $d0, $07, $00 ; entry 4
    db $f8, $d8, $08, $00 ; entry 5
    db $f0, $d0, $05, $00 ; entry 6
    db $f0, $d8, $06, $00 ; entry 7
    db $f0, $22, $20, $00 ; entry 8
    db $f0, $1a, $1f, $00 ; entry 9
    db $e8, $1c, $1d, $00 ; entry 10
    db $e8, $24, $1e, $00 ; entry 11
    db $e0, $24, $1c, $00 ; entry 12
    db $f0, $08, $01, $00 ; entry 13
    db $f0, $b8, $03, $00 ; entry 14
    db $f0, $f4, $02, $00 ; entry 15
    db $80 ; end

; frame 19 of MetaSprites3FSet1A; ends with $80 (E-0147)
MetaSprites3FSet1AFrame19::
    db $80 ; end

; meta-sprite set 27 of MetaSprites3FTable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3FSet1B::
    dw MetaSprites3FSet1BFrame0 ; entry 0
    dw MetaSprites3FSet1BFrame1 ; entry 1
    dw MetaSprites3FSet1BFrame2 ; entry 2
    dw MetaSprites3FSet1BFrame3 ; entry 3
    dw MetaSprites3FSet1BFrame4 ; entry 4
    dw MetaSprites3FSet1BFrame5 ; entry 5
    dw MetaSprites3FSet1BFrame6 ; entry 6
    dw MetaSprites3FSet1BFrame7 ; entry 7
    dw MetaSprites3FSet1BFrame8 ; entry 8
    dw MetaSprites3FSet1BFrame8 ; entry 9
    dw MetaSprites3FSet1BFrame8 ; entry 10
    dw MetaSprites3FSet1BFrame8 ; entry 11
    dw MetaSprites3FSet1BFrame8 ; entry 12
    dw MetaSprites3FSet1BFrame8 ; entry 13
    dw MetaSprites3FSet1BFrame8 ; entry 14
    dw MetaSprites3FSet1BFrame8 ; entry 15
    dw MetaSprites3FSet1BFrame8 ; entry 16
    dw MetaSprites3FSet1BFrame8 ; entry 17
    dw MetaSprites3FSet1BFrame8 ; entry 18
    dw MetaSprites3FSet1BFrame8 ; entry 19
    dw MetaSprites3FSet1BFrame8 ; entry 20
    dw MetaSprites3FSet1BFrame8 ; entry 21
    dw MetaSprites3FSet1BFrame8 ; entry 22
    dw MetaSprites3FSet1BFrame8 ; entry 23
    dw MetaSprites3FSet1BFrame8 ; entry 24
    dw MetaSprites3FSet1BFrame8 ; entry 25
    dw MetaSprites3FSet1BFrame8 ; entry 26
    dw MetaSprites3FSet1BFrame8 ; entry 27
    dw MetaSprites3FSet1BFrame8 ; entry 28
    dw MetaSprites3FSet1BFrame8 ; entry 29
    dw MetaSprites3FSet1BFrame8 ; entry 30
    dw MetaSprites3FSet1BFrame8 ; entry 31

; frame 0 of MetaSprites3FSet1B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet1BFrame0::
    db $d0, $f2, $17, $00 ; entry 0
    db $d0, $fa, $18, $00 ; entry 1
    db $d0, $02, $19, $00 ; entry 2
    db $d0, $0a, $1a, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites3FSet1B; ends with $80 (E-0147)
MetaSprites3FSet1BFrame1::
    db $d0, $f2, $13, $00 ; entry 0
    db $d0, $fa, $14, $00 ; entry 1
    db $d0, $02, $15, $00 ; entry 2
    db $d8, $f2, $17, $00 ; entry 3
    db $d8, $fa, $18, $00 ; entry 4
    db $d8, $02, $19, $00 ; entry 5
    db $d0, $0a, $16, $00 ; entry 6
    db $d8, $0a, $1a, $00 ; entry 7
    db $80 ; end

; frame 2 of MetaSprites3FSet1B; ends with $80 (E-0147)
MetaSprites3FSet1BFrame2::
    db $d8, $f2, $10, $00 ; entry 0
    db $d8, $fa, $11, $00 ; entry 1
    db $d8, $02, $12, $00 ; entry 2
    db $e0, $f2, $13, $00 ; entry 3
    db $e0, $fa, $14, $00 ; entry 4
    db $e0, $02, $15, $00 ; entry 5
    db $e0, $0a, $16, $00 ; entry 6
    db $e8, $f2, $17, $00 ; entry 7
    db $e8, $fa, $18, $00 ; entry 8
    db $e8, $02, $19, $00 ; entry 9
    db $e8, $0a, $1a, $00 ; entry 10
    db $80 ; end

; frame 3 of MetaSprites3FSet1B; ends with $80 (E-0147)
MetaSprites3FSet1BFrame3::
    db $e9, $f8, $06, $00 ; entry 0
    db $e9, $00, $07, $00 ; entry 1
    db $e8, $f2, $0d, $20 ; entry 2
    db $e0, $ea, $00, $20 ; entry 3
    db $e1, $f8, $04, $00 ; entry 4
    db $e1, $00, $05, $00 ; entry 5
    db $e0, $f2, $0c, $20 ; entry 6
    db $dd, $fa, $03, $00 ; entry 7
    db $dc, $02, $02, $00 ; entry 8
    db $e4, $06, $0c, $00 ; entry 9
    db $ec, $06, $0d, $00 ; entry 10
    db $db, $0a, $01, $00 ; entry 11
    db $80 ; end

; frame 4 of MetaSprites3FSet1B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet1BFrame4::
    db $d8, $f2, $03, $00 ; entry 0
    db $eb, $eb, $0e, $40 ; entry 1
    db $eb, $f3, $0f, $40 ; entry 2
    db $de, $e8, $00, $20 ; entry 3
    db $d4, $06, $02, $00 ; entry 4
    db $e4, $10, $0e, $60 ; entry 5
    db $e4, $08, $0f, $60 ; entry 6
    db $da, $10, $01, $00 ; entry 7
    db $de, $f8, $04, $00 ; entry 8
    db $de, $00, $05, $00 ; entry 9
    db $e6, $f8, $06, $00 ; entry 10
    db $e6, $00, $07, $00 ; entry 11
    db $80 ; end

; frame 5 of MetaSprites3FSet1B; ends with $80 (E-0147)
MetaSprites3FSet1BFrame5::
    db $e2, $10, $01, $20 ; entry 0
    db $f2, $10, $0c, $60 ; entry 1
    db $ea, $10, $0d, $60 ; entry 2
    db $dc, $0a, $02, $40 ; entry 3
    db $e0, $ed, $03, $40 ; entry 4
    db $e6, $e8, $01, $00 ; entry 5
    db $f8, $eb, $0c, $40 ; entry 6
    db $f0, $eb, $0d, $40 ; entry 7
    db $e6, $fa, $08, $00 ; entry 8
    db $e6, $02, $09, $00 ; entry 9
    db $ee, $fa, $0a, $00 ; entry 10
    db $ee, $02, $0b, $00 ; entry 11
    db $80 ; end

; frame 6 of MetaSprites3FSet1B; ends with $80 (E-0147)
MetaSprites3FSet1BFrame6::
    db $f8, $eb, $0d, $60 ; entry 0
    db $f8, $10, $0c, $40 ; entry 1
    db $f0, $10, $0d, $40 ; entry 2
    db $ec, $e8, $02, $00 ; entry 3
    db $e2, $10, $00, $20 ; entry 4
    db $ee, $fc, $04, $00 ; entry 5
    db $ee, $04, $05, $00 ; entry 6
    db $f6, $fc, $06, $00 ; entry 7
    db $f6, $04, $07, $00 ; entry 8
    db $80 ; end

; frame 7 of MetaSprites3FSet1B; ends with $80 (E-0147)
MetaSprites3FSet1BFrame7::
    db $f8, $10, $0d, $60 ; entry 0
    db $f8, $fd, $04, $00 ; entry 1
    db $f8, $05, $05, $00 ; entry 2
    db $80 ; end

; frame 8 of MetaSprites3FSet1B; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet1BFrame8::
    db $80 ; end

; meta-sprite set 28 of MetaSprites3FTable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3FSet1C::
    dw MetaSprites3FSet1CFrame0 ; entry 0
    dw MetaSprites3FSet1CFrame1 ; entry 1
    dw MetaSprites3FSet1CFrame2 ; entry 2
    dw MetaSprites3FSet1CFrame3 ; entry 3
    dw MetaSprites3FSet1CFrame4 ; entry 4
    dw MetaSprites3FSet1CFrame5 ; entry 5
    dw MetaSprites3FSet1CFrame6 ; entry 6
    dw MetaSprites3FSet1CFrame7 ; entry 7
    dw MetaSprites3FSet1CFrame8 ; entry 8
    dw MetaSprites3FSet1CFrame9 ; entry 9
    dw MetaSprites3FSet1CFrame10 ; entry 10
    dw MetaSprites3FSet1CFrame11 ; entry 11
    dw MetaSprites3FSet1CFrame12 ; entry 12
    dw MetaSprites3FSet1CFrame13 ; entry 13
    dw MetaSprites3FSet1CFrame14 ; entry 14
    dw MetaSprites3FSet1CFrame15 ; entry 15
    dw MetaSprites3FSet1CFrame16 ; entry 16
    dw MetaSprites3FSet1CFrame17 ; entry 17
    dw MetaSprites3FSet1CFrame18 ; entry 18
    dw MetaSprites3FSet1CFrame19 ; entry 19
    dw MetaSprites3FSet1CFrame20 ; entry 20
    dw MetaSprites3FSet1CFrame20 ; entry 21
    dw MetaSprites3FSet1CFrame20 ; entry 22
    dw MetaSprites3FSet1CFrame20 ; entry 23
    dw MetaSprites3FSet1CFrame20 ; entry 24
    dw MetaSprites3FSet1CFrame20 ; entry 25
    dw MetaSprites3FSet1CFrame20 ; entry 26
    dw MetaSprites3FSet1CFrame20 ; entry 27
    dw MetaSprites3FSet1CFrame20 ; entry 28
    dw MetaSprites3FSet1CFrame20 ; entry 29
    dw MetaSprites3FSet1CFrame20 ; entry 30
    dw MetaSprites3FSet1CFrame20 ; entry 31

; frame 0 of MetaSprites3FSet1C; ends with $80 (E-0147)
MetaSprites3FSet1CFrame0::
    db $f8, $b0, $22, $10 ; entry 0
    db $80 ; end

; frame 1 of MetaSprites3FSet1C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet1CFrame1::
    db $f8, $b0, $20, $10 ; entry 0
    db $f8, $b8, $21, $10 ; entry 1
    db $f8, $c0, $22, $10 ; entry 2
    db $80 ; end

; frame 2 of MetaSprites3FSet1C; ends with $80 (E-0147)
MetaSprites3FSet1CFrame2::
    db $f8, $c3, $20, $10 ; entry 0
    db $f8, $cb, $21, $10 ; entry 1
    db $f8, $d3, $22, $10 ; entry 2
    db $f8, $b3, $10, $10 ; entry 3
    db $f8, $bb, $11, $10 ; entry 4
    db $f8, $ab, $11, $10 ; entry 5
    db $80 ; end

; frame 3 of MetaSprites3FSet1C; ends with $80 (E-0147)
MetaSprites3FSet1CFrame3::
    db $f8, $d8, $20, $10 ; entry 0
    db $f8, $e0, $21, $10 ; entry 1
    db $f8, $e8, $22, $10 ; entry 2
    db $f8, $c8, $11, $10 ; entry 3
    db $f8, $d0, $11, $10 ; entry 4
    db $f8, $c0, $12, $10 ; entry 5
    db $f8, $b0, $02, $10 ; entry 6
    db $f8, $b8, $02, $10 ; entry 7
    db $80 ; end

; frame 4 of MetaSprites3FSet1C; ends with $80 (E-0147)
MetaSprites3FSet1CFrame4::
    db $f8, $b7, $00, $10 ; entry 0
    db $f8, $bf, $01, $10 ; entry 1
    db $f8, $c7, $02, $10 ; entry 2
    db $f8, $cf, $02, $10 ; entry 3
    db $f8, $df, $10, $10 ; entry 4
    db $f8, $e7, $11, $10 ; entry 5
    db $f8, $d7, $11, $10 ; entry 6
    db $f8, $ef, $20, $10 ; entry 7
    db $f8, $f7, $21, $10 ; entry 8
    db $f8, $ff, $22, $10 ; entry 9
    db $80 ; end

; frame 5 of MetaSprites3FSet1C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet1CFrame5::
    db $f8, $d0, $00, $10 ; entry 0
    db $f8, $d8, $01, $10 ; entry 1
    db $f8, $e0, $02, $10 ; entry 2
    db $f8, $e8, $02, $10 ; entry 3
    db $f8, $f0, $11, $10 ; entry 4
    db $f8, $f8, $12, $10 ; entry 5
    db $f8, $00, $11, $10 ; entry 6
    db $f8, $08, $20, $10 ; entry 7
    db $f8, $10, $21, $10 ; entry 8
    db $f8, $18, $22, $10 ; entry 9
    db $80 ; end

; frame 6 of MetaSprites3FSet1C; ends with $80 (E-0147)
MetaSprites3FSet1CFrame6::
    db $f8, $eb, $00, $10 ; entry 0
    db $f8, $f3, $01, $10 ; entry 1
    db $f8, $fb, $02, $10 ; entry 2
    db $f8, $03, $02, $10 ; entry 3
    db $f8, $0b, $10, $10 ; entry 4
    db $f8, $13, $11, $10 ; entry 5
    db $f8, $1b, $11, $10 ; entry 6
    db $f8, $23, $20, $10 ; entry 7
    db $f8, $2b, $21, $10 ; entry 8
    db $f8, $33, $22, $10 ; entry 9
    db $80 ; end

; frame 7 of MetaSprites3FSet1C; ends with $80 (E-0147)
MetaSprites3FSet1CFrame7::
    db $f8, $08, $00, $10 ; entry 0
    db $f8, $10, $01, $10 ; entry 1
    db $f8, $18, $02, $10 ; entry 2
    db $f8, $20, $02, $10 ; entry 3
    db $f8, $30, $11, $10 ; entry 4
    db $f8, $38, $11, $10 ; entry 5
    db $f8, $28, $12, $10 ; entry 6
    db $f8, $40, $20, $10 ; entry 7
    db $f8, $48, $21, $10 ; entry 8
    db $f0, $d0, $17, $10 ; entry 9
    db $f6, $d8, $0d, $10 ; entry 10
    db $80 ; end

; frame 8 of MetaSprites3FSet1C; ends with $80 (E-0147)
MetaSprites3FSet1CFrame8::
    db $f8, $19, $00, $10 ; entry 0
    db $f8, $21, $01, $10 ; entry 1
    db $f8, $29, $02, $10 ; entry 2
    db $f8, $31, $02, $10 ; entry 3
    db $f8, $39, $12, $10 ; entry 4
    db $f8, $41, $11, $10 ; entry 5
    db $f8, $49, $11, $10 ; entry 6
    db $f8, $c8, $13, $10 ; entry 7
    db $f5, $cb, $27, $10 ; entry 8
    db $ed, $c8, $0d, $10 ; entry 9
    db $80 ; end

; frame 9 of MetaSprites3FSet1C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet1CFrame9::
    db $f8, $2c, $00, $10 ; entry 0
    db $f8, $34, $01, $10 ; entry 1
    db $f8, $3c, $02, $10 ; entry 2
    db $f8, $44, $02, $10 ; entry 3
    db $f8, $4c, $12, $10 ; entry 4
    db $ef, $d0, $13, $10 ; entry 5
    db $f7, $d0, $23, $10 ; entry 6
    db $f3, $db, $24, $10 ; entry 7
    db $ed, $d3, $27, $10 ; entry 8
    db $e5, $d0, $0d, $10 ; entry 9
    db $80 ; end

; frame 10 of MetaSprites3FSet1C; ends with $80 (E-0147)
MetaSprites3FSet1CFrame10::
    db $f8, $41, $00, $10 ; entry 0
    db $f8, $49, $01, $10 ; entry 1
    db $f8, $c6, $03, $10 ; entry 2
    db $f8, $de, $08, $50 ; entry 3
    db $f0, $d6, $15, $10 ; entry 4
    db $f8, $d6, $26, $10 ; entry 5
    db $f8, $e6, $26, $10 ; entry 6
    db $f8, $ce, $25, $10 ; entry 7
    db $f8, $06, $17, $10 ; entry 8
    db $f0, $ee, $0d, $30 ; entry 9
    db $f8, $ee, $0e, $30 ; entry 10
    db $f0, $e6, $0b, $10 ; entry 11
    db $e8, $e8, $14, $10 ; entry 12
    db $f8, $f6, $14, $10 ; entry 13
    db $e8, $e0, $1d, $10 ; entry 14
    db $f0, $de, $1f, $70 ; entry 15
    db $80 ; end

; frame 11 of MetaSprites3FSet1C; ends with $80 (E-0147)
MetaSprites3FSet1CFrame11::
    db $d8, $06, $13, $10 ; entry 0
    db $f8, $ce, $03, $10 ; entry 1
    db $f8, $d6, $04, $10 ; entry 2
    db $f8, $de, $05, $10 ; entry 3
    db $f8, $ee, $06, $10 ; entry 4
    db $f8, $f6, $07, $10 ; entry 5
    db $f8, $fe, $08, $10 ; entry 6
    db $f0, $fe, $08, $70 ; entry 7
    db $f8, $e6, $26, $10 ; entry 8
    db $d8, $fe, $25, $30 ; entry 9
    db $d0, $f6, $0d, $10 ; entry 10
    db $d8, $f6, $0e, $10 ; entry 11
    db $e8, $f6, $0f, $30 ; entry 12
    db $f0, $d2, $0d, $10 ; entry 13
    db $e0, $06, $18, $70 ; entry 14
    db $e8, $06, $19, $30 ; entry 15
    db $f0, $0e, $1f, $10 ; entry 16
    db $f8, $0e, $2f, $10 ; entry 17
    db $e8, $0e, $1c, $10 ; entry 18
    db $e8, $fe, $1b, $10 ; entry 19
    db $e0, $fe, $1b, $30 ; entry 20
    db $f0, $06, $2d, $10 ; entry 21
    db $f8, $06, $2e, $50 ; entry 22
    db $f0, $f6, $1f, $30 ; entry 23
    db $f0, $e4, $1d, $30 ; entry 24
    db $80 ; end

; frame 12 of MetaSprites3FSet1C; ends with $80 (E-0147)
MetaSprites3FSet1CFrame12::
    db $f8, $28, $22, $10 ; entry 0
    db $f8, $b8, $13, $10 ; entry 1
    db $f0, $c2, $17, $10 ; entry 2
    db $f0, $c8, $25, $10 ; entry 3
    db $e8, $ef, $27, $50 ; entry 4
    db $f8, $30, $28, $50 ; entry 5
    db $d8, $f0, $18, $10 ; entry 6
    db $e0, $04, $0c, $10 ; entry 7
    db $d8, $08, $0a, $10 ; entry 8
    db $d8, $10, $0b, $10 ; entry 9
    db $d0, $0a, $09, $10 ; entry 10
    db $d0, $f2, $19, $50 ; entry 11
    db $e8, $d0, $0d, $30 ; entry 12
    db $f0, $d0, $0e, $30 ; entry 13
    db $f8, $c0, $18, $50 ; entry 14
    db $f8, $d0, $15, $10 ; entry 15
    db $d8, $e0, $14, $10 ; entry 16
    db $f8, $d8, $14, $10 ; entry 17
    db $f8, $c8, $1b, $10 ; entry 18
    db $d8, $00, $2d, $70 ; entry 19
    db $d8, $f8, $2e, $70 ; entry 20
    db $d0, $fa, $1b, $30 ; entry 21
    db $e8, $26, $1a, $10 ; entry 22
    db $f0, $20, $14, $10 ; entry 23
    db $f8, $18, $1d, $10 ; entry 24
    db $f8, $38, $1c, $10 ; entry 25
    db $f0, $26, $2a, $10 ; entry 26
    db $f8, $20, $2b, $10 ; entry 27
    db $d0, $02, $1f, $50 ; entry 28
    db $e0, $0b, $1a, $50 ; entry 29
    db $e0, $f4, $28, $10 ; entry 30
    db $80 ; end

; frame 13 of MetaSprites3FSet1C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet1CFrame13::
    db $ef, $18, $13, $10 ; entry 0
    db $f7, $18, $23, $10 ; entry 1
    db $f8, $b8, $13, $10 ; entry 2
    db $f3, $23, $24, $10 ; entry 3
    db $f8, $c8, $08, $10 ; entry 4
    db $d8, $c8, $16, $30 ; entry 5
    db $ed, $1b, $27, $10 ; entry 6
    db $e5, $18, $0d, $10 ; entry 7
    db $d0, $d8, $0d, $30 ; entry 8
    db $d8, $d8, $0e, $30 ; entry 9
    db $d8, $d0, $0f, $30 ; entry 10
    db $e0, $d7, $19, $30 ; entry 11
    db $e8, $d8, $29, $30 ; entry 12
    db $f8, $f0, $28, $50 ; entry 13
    db $f0, $c7, $0a, $10 ; entry 14
    db $e0, $c7, $2c, $10 ; entry 15
    db $e0, $cf, $1b, $10 ; entry 16
    db $f8, $e8, $2b, $30 ; entry 17
    db $f8, $e0, $2c, $30 ; entry 18
    db $f8, $d8, $2d, $30 ; entry 19
    db $f8, $d0, $2e, $30 ; entry 20
    db $f0, $c0, $1f, $30 ; entry 21
    db $f8, $c0, $2f, $30 ; entry 22
    db $e8, $bf, $1c, $30 ; entry 23
    db $f0, $df, $1d, $30 ; entry 24
    db $f0, $cf, $1e, $30 ; entry 25
    db $e8, $c8, $1b, $30 ; entry 26
    db $e8, $d0, $2e, $50 ; entry 27
    db $80 ; end

; frame 14 of MetaSprites3FSet1C; ends with $80 (E-0147)
MetaSprites3FSet1CFrame14::
    db $f0, $30, $13, $10 ; entry 0
    db $f8, $e4, $03, $10 ; entry 1
    db $f8, $c8, $13, $30 ; entry 2
    db $f8, $fc, $08, $50 ; entry 3
    db $f5, $d0, $27, $10 ; entry 4
    db $f8, $ec, $25, $10 ; entry 5
    db $f0, $28, $25, $30 ; entry 6
    db $f8, $f4, $26, $10 ; entry 7
    db $f8, $04, $26, $10 ; entry 8
    db $f0, $f4, $15, $10 ; entry 9
    db $f0, $0c, $16, $10 ; entry 10
    db $ed, $ca, $0d, $10 ; entry 11
    db $e8, $20, $0d, $10 ; entry 12
    db $f0, $04, $0b, $10 ; entry 13
    db $f0, $20, $0e, $10 ; entry 14
    db $f8, $0c, $0e, $30 ; entry 15
    db $f8, $30, $18, $70 ; entry 16
    db $f8, $20, $28, $50 ; entry 17
    db $e8, $06, $14, $10 ; entry 18
    db $e8, $fe, $1d, $10 ; entry 19
    db $f8, $28, $1b, $30 ; entry 20
    db $f0, $fc, $1f, $70 ; entry 21
    db $80 ; end

; frame 15 of MetaSprites3FSet1C; ends with $80 (E-0147)
MetaSprites3FSet1CFrame15::
    db $f8, $28, $08, $30 ; entry 0
    db $d8, $28, $16, $10 ; entry 1
    db $d0, $18, $0d, $10 ; entry 2
    db $d8, $18, $0e, $10 ; entry 3
    db $d8, $20, $0f, $10 ; entry 4
    db $e0, $19, $19, $10 ; entry 5
    db $e8, $18, $29, $10 ; entry 6
    db $f0, $29, $0a, $10 ; entry 7
    db $f8, $00, $28, $70 ; entry 8
    db $f8, $30, $2f, $10 ; entry 9
    db $f0, $31, $1f, $10 ; entry 10
    db $e8, $28, $1b, $10 ; entry 11
    db $e8, $30, $1c, $10 ; entry 12
    db $f0, $21, $1e, $10 ; entry 13
    db $f8, $08, $2b, $10 ; entry 14
    db $f8, $10, $2c, $10 ; entry 15
    db $f8, $18, $2d, $10 ; entry 16
    db $f8, $20, $2e, $10 ; entry 17
    db $e0, $29, $2c, $30 ; entry 18
    db $e0, $21, $1b, $30 ; entry 19
    db $f0, $12, $1d, $10 ; entry 20
    db $f8, $f8, $2a, $50 ; entry 21
    db $e8, $20, $2e, $50 ; entry 22
    db $80 ; end

; frame 16 of MetaSprites3FSet1C; ends with $80 (E-0147)
MetaSprites3FSet1CFrame16::
    db $f8, $0c, $22, $10 ; entry 0
    db $f0, $f7, $13, $10 ; entry 1
    db $f8, $04, $04, $30 ; entry 2
    db $f8, $fc, $07, $30 ; entry 3
    db $f8, $d0, $17, $10 ; entry 4
    db $e8, $f5, $14, $10 ; entry 5
    db $f0, $04, $14, $10 ; entry 6
    db $f8, $14, $14, $10 ; entry 7
    db $f8, $ec, $2b, $10 ; entry 8
    db $f8, $f4, $2c, $10 ; entry 9
    db $e8, $0a, $1a, $10 ; entry 10
    db $f0, $0a, $2a, $10 ; entry 11
    db $f0, $fc, $1d, $30 ; entry 12
    db $80 ; end

; frame 17 of MetaSprites3FSet1C; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet1CFrame17::
    db $ef, $00, $13, $10 ; entry 0
    db $f7, $00, $23, $10 ; entry 1
    db $f3, $0b, $24, $10 ; entry 2
    db $f0, $e5, $27, $10 ; entry 3
    db $ed, $03, $27, $10 ; entry 4
    db $e5, $00, $0d, $10 ; entry 5
    db $80 ; end

; frame 18 of MetaSprites3FSet1C; ends with $80 (E-0147)
MetaSprites3FSet1CFrame18::
    db $f0, $f8, $17, $10 ; entry 0
    db $f8, $f7, $27, $10 ; entry 1
    db $f8, $f0, $0d, $10 ; entry 2
    db $e8, $08, $0d, $30 ; entry 3
    db $f8, $08, $14, $10 ; entry 4
    db $80 ; end

; frame 19 of MetaSprites3FSet1C; ends with $80 (E-0147)
MetaSprites3FSet1CFrame19::
    db $f8, $c6, $03, $10 ; entry 0
    db $f8, $de, $08, $50 ; entry 1
    db $f0, $d6, $15, $10 ; entry 2
    db $f8, $d6, $26, $10 ; entry 3
    db $f8, $e6, $26, $10 ; entry 4
    db $f8, $ce, $25, $10 ; entry 5
    db $f8, $06, $17, $10 ; entry 6
    db $f0, $ee, $0d, $30 ; entry 7
    db $f8, $ee, $0e, $30 ; entry 8
    db $f0, $e6, $0b, $10 ; entry 9
    db $e8, $e8, $14, $10 ; entry 10
    db $f8, $f6, $14, $10 ; entry 11
    db $e8, $e0, $1d, $10 ; entry 12
    db $f0, $de, $1f, $70 ; entry 13
    db $80 ; end

; frame 20 of MetaSprites3FSet1C; ends with $80 (E-0147)
MetaSprites3FSet1CFrame20::
    db $80 ; end

; meta-sprite set 29 of MetaSprites3FTable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3FSet1D::
    dw MetaSprites3FSet1DFrame0 ; entry 0
    dw MetaSprites3FSet1DFrame1 ; entry 1
    dw MetaSprites3FSet1DFrame2 ; entry 2
    dw MetaSprites3FSet1DFrame3 ; entry 3
    dw MetaSprites3FSet1DFrame4 ; entry 4
    dw MetaSprites3FSet1DFrame5 ; entry 5
    dw MetaSprites3FSet1DFrame6 ; entry 6
    dw MetaSprites3FSet1DFrame6 ; entry 7
    dw MetaSprites3FSet1DFrame6 ; entry 8
    dw MetaSprites3FSet1DFrame6 ; entry 9
    dw MetaSprites3FSet1DFrame6 ; entry 10
    dw MetaSprites3FSet1DFrame6 ; entry 11
    dw MetaSprites3FSet1DFrame6 ; entry 12
    dw MetaSprites3FSet1DFrame6 ; entry 13
    dw MetaSprites3FSet1DFrame6 ; entry 14
    dw MetaSprites3FSet1DFrame6 ; entry 15
    dw MetaSprites3FSet1DFrame6 ; entry 16
    dw MetaSprites3FSet1DFrame6 ; entry 17
    dw MetaSprites3FSet1DFrame6 ; entry 18
    dw MetaSprites3FSet1DFrame6 ; entry 19
    dw MetaSprites3FSet1DFrame6 ; entry 20
    dw MetaSprites3FSet1DFrame6 ; entry 21
    dw MetaSprites3FSet1DFrame6 ; entry 22
    dw MetaSprites3FSet1DFrame6 ; entry 23
    dw MetaSprites3FSet1DFrame6 ; entry 24
    dw MetaSprites3FSet1DFrame6 ; entry 25
    dw MetaSprites3FSet1DFrame6 ; entry 26
    dw MetaSprites3FSet1DFrame6 ; entry 27
    dw MetaSprites3FSet1DFrame6 ; entry 28
    dw MetaSprites3FSet1DFrame6 ; entry 29
    dw MetaSprites3FSet1DFrame6 ; entry 30
    dw MetaSprites3FSet1DFrame6 ; entry 31

; frame 0 of MetaSprites3FSet1D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet1DFrame0::
    db $d8, $03, $00, $00 ; entry 0
    db $d8, $0b, $01, $00 ; entry 1
    db $d0, $03, $02, $00 ; entry 2
    db $d0, $0b, $03, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites3FSet1D; ends with $80 (E-0147)
MetaSprites3FSet1DFrame1::
    db $dc, $00, $00, $00 ; entry 0
    db $dc, $08, $01, $00 ; entry 1
    db $d4, $00, $02, $00 ; entry 2
    db $d4, $08, $03, $00 ; entry 3
    db $cc, $04, $04, $00 ; entry 4
    db $e4, $f8, $00, $60 ; entry 5
    db $e4, $f0, $01, $60 ; entry 6
    db $ec, $f8, $02, $60 ; entry 7
    db $ec, $f0, $03, $60 ; entry 8
    db $f4, $f4, $04, $60 ; entry 9
    db $80 ; end

; frame 2 of MetaSprites3FSet1D; ends with $80 (E-0147)
MetaSprites3FSet1DFrame2::
    db $f0, $fb, $05, $60 ; entry 0
    db $f0, $f3, $06, $60 ; entry 1
    db $e8, $03, $07, $60 ; entry 2
    db $e8, $fb, $08, $60 ; entry 3
    db $e8, $f3, $09, $60 ; entry 4
    db $e0, $03, $0a, $60 ; entry 5
    db $e0, $fb, $0b, $60 ; entry 6
    db $e0, $f3, $0c, $60 ; entry 7
    db $d8, $07, $0d, $60 ; entry 8
    db $d8, $ff, $0e, $60 ; entry 9
    db $d0, $08, $0f, $60 ; entry 10
    db $80 ; end

; frame 3 of MetaSprites3FSet1D; ends with $80 (E-0147)
MetaSprites3FSet1DFrame3::
    db $f0, $f3, $11, $00 ; entry 0
    db $e8, $f8, $11, $00 ; entry 1
    db $e0, $fe, $11, $00 ; entry 2
    db $d8, $03, $11, $00 ; entry 3
    db $d0, $08, $11, $00 ; entry 4
    db $f8, $ee, $11, $00 ; entry 5
    db $80 ; end

; frame 4 of MetaSprites3FSet1D; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet1DFrame4::
    db $f0, $f3, $11, $00 ; entry 0
    db $e8, $f8, $11, $00 ; entry 1
    db $f8, $ee, $11, $00 ; entry 2
    db $e0, $fe, $12, $00 ; entry 3
    db $d8, $03, $12, $00 ; entry 4
    db $80 ; end

; frame 5 of MetaSprites3FSet1D; ends with $80 (E-0147)
MetaSprites3FSet1DFrame5::
    db $f8, $ee, $12, $00 ; entry 0
    db $f0, $f3, $12, $00 ; entry 1
    db $e8, $f8, $12, $00 ; entry 2
    db $80 ; end

; frame 6 of MetaSprites3FSet1D; ends with $80 (E-0147)
MetaSprites3FSet1DFrame6::
    db $80 ; end

; meta-sprite set 30 of MetaSprites3FTable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3FSet1E::
    dw MetaSprites3FSet1EFrame0 ; entry 0
    dw MetaSprites3FSet1EFrame1 ; entry 1
    dw MetaSprites3FSet1EFrame2 ; entry 2
    dw MetaSprites3FSet1EFrame3 ; entry 3
    dw MetaSprites3FSet1EFrame4 ; entry 4
    dw MetaSprites3FSet1EFrame5 ; entry 5
    dw MetaSprites3FSet1EFrame6 ; entry 6
    dw MetaSprites3FSet1EFrame7 ; entry 7
    dw MetaSprites3FSet1EFrame8 ; entry 8
    dw MetaSprites3FSet1EFrame9 ; entry 9
    dw MetaSprites3FSet1EFrame10 ; entry 10
    dw MetaSprites3FSet1EFrame11 ; entry 11
    dw MetaSprites3FSet1EFrame12 ; entry 12
    dw MetaSprites3FSet1EFrame13 ; entry 13
    dw MetaSprites3FSet1EFrame14 ; entry 14
    dw MetaSprites3FSet1EFrame15 ; entry 15
    dw MetaSprites3FSet1EFrame16 ; entry 16
    dw MetaSprites3FSet1EFrame17 ; entry 17
    dw MetaSprites3FSet1EFrame18 ; entry 18
    dw MetaSprites3FSet1EFrame19 ; entry 19
    dw MetaSprites3FSet1EFrame20 ; entry 20
    dw MetaSprites3FSet1EFrame20 ; entry 21
    dw MetaSprites3FSet1EFrame20 ; entry 22
    dw MetaSprites3FSet1EFrame20 ; entry 23
    dw MetaSprites3FSet1EFrame20 ; entry 24
    dw MetaSprites3FSet1EFrame20 ; entry 25
    dw MetaSprites3FSet1EFrame20 ; entry 26
    dw MetaSprites3FSet1EFrame20 ; entry 27
    dw MetaSprites3FSet1EFrame20 ; entry 28
    dw MetaSprites3FSet1EFrame20 ; entry 29
    dw MetaSprites3FSet1EFrame20 ; entry 30
    dw MetaSprites3FSet1EFrame20 ; entry 31

; frame 0 of MetaSprites3FSet1E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet1EFrame0::
    db $d8, $03, $1c, $00 ; entry 0
    db $d8, $0b, $1d, $00 ; entry 1
    db $d0, $03, $1e, $00 ; entry 2
    db $d0, $0b, $1f, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites3FSet1E; ends with $80 (E-0147)
MetaSprites3FSet1EFrame1::
    db $dc, $00, $1c, $00 ; entry 0
    db $dc, $08, $1d, $00 ; entry 1
    db $cf, $01, $26, $00 ; entry 2
    db $d4, $00, $1e, $00 ; entry 3
    db $d4, $08, $1f, $00 ; entry 4
    db $e4, $f8, $1c, $60 ; entry 5
    db $e4, $f0, $1d, $60 ; entry 6
    db $f1, $f7, $26, $60 ; entry 7
    db $ec, $f8, $1e, $60 ; entry 8
    db $ec, $f0, $1f, $60 ; entry 9
    db $80 ; end

; frame 2 of MetaSprites3FSet1E; ends with $80 (E-0147)
MetaSprites3FSet1EFrame2::
    db $d0, $00, $20, $00 ; entry 0
    db $d0, $08, $21, $00 ; entry 1
    db $d8, $fc, $22, $00 ; entry 2
    db $d8, $04, $23, $00 ; entry 3
    db $e0, $f8, $24, $00 ; entry 4
    db $e0, $00, $25, $00 ; entry 5
    db $e8, $f0, $26, $00 ; entry 6
    db $e8, $f8, $27, $00 ; entry 7
    db $f0, $f4, $28, $00 ; entry 8
    db $f8, $f0, $29, $00 ; entry 9
    db $80 ; end

; frame 3 of MetaSprites3FSet1E; ends with $80 (E-0147)
MetaSprites3FSet1EFrame3::
    db $d8, $03, $21, $00 ; entry 0
    db $e0, $f7, $22, $00 ; entry 1
    db $e0, $ff, $23, $00 ; entry 2
    db $e8, $fb, $25, $00 ; entry 3
    db $f0, $eb, $26, $00 ; entry 4
    db $f0, $f3, $27, $00 ; entry 5
    db $f8, $ef, $28, $00 ; entry 6
    db $d0, $08, $2a, $00 ; entry 7
    db $d8, $fb, $2a, $00 ; entry 8
    db $e8, $f3, $2a, $00 ; entry 9
    db $e0, $eb, $2b, $00 ; entry 10
    db $d0, $00, $2b, $00 ; entry 11
    db $80 ; end

; frame 4 of MetaSprites3FSet1E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet1EFrame4::
    db $d0, $08, $2c, $00 ; entry 0
    db $d8, $03, $2c, $00 ; entry 1
    db $e0, $fe, $2c, $00 ; entry 2
    db $e8, $f8, $2c, $00 ; entry 3
    db $f0, $f3, $2c, $00 ; entry 4
    db $f8, $ee, $2c, $00 ; entry 5
    db $f0, $eb, $2a, $00 ; entry 6
    db $e0, $f6, $2b, $00 ; entry 7
    db $80 ; end

; frame 5 of MetaSprites3FSet1E; ends with $80 (E-0147)
MetaSprites3FSet1EFrame5::
    db $e8, $f8, $2c, $00 ; entry 0
    db $f0, $f3, $2c, $00 ; entry 1
    db $f8, $ee, $2c, $00 ; entry 2
    db $d8, $03, $2d, $00 ; entry 3
    db $e0, $fe, $2d, $00 ; entry 4
    db $e8, $f0, $20, $00 ; entry 5
    db $80 ; end

; frame 6 of MetaSprites3FSet1E; ends with $80 (E-0147)
MetaSprites3FSet1EFrame6::
    db $e8, $fa, $2d, $00 ; entry 0
    db $f0, $f5, $2d, $00 ; entry 1
    db $f8, $f0, $2d, $00 ; entry 2
    db $80 ; end

; frame 7 of MetaSprites3FSet1E; ends with $80 (E-0147)
MetaSprites3FSet1EFrame7::
    db $f0, $fc, $27, $00 ; entry 0
    db $f8, $fc, $28, $00 ; entry 1
    db $e8, $fc, $24, $20 ; entry 2
    db $80 ; end

; frame 8 of MetaSprites3FSet1E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet1EFrame8::
    db $e8, $fc, $02, $00 ; entry 0
    db $f0, $fc, $27, $20 ; entry 1
    db $f8, $fc, $27, $00 ; entry 2
    db $e0, $fc, $21, $20 ; entry 3
    db $f8, $f4, $21, $00 ; entry 4
    db $f0, $f0, $20, $00 ; entry 5
    db $f8, $04, $21, $20 ; entry 6
    db $f0, $08, $20, $20 ; entry 7
    db $80 ; end

; frame 9 of MetaSprites3FSet1E; ends with $80 (E-0147)
MetaSprites3FSet1EFrame9::
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

; frame 10 of MetaSprites3FSet1E; ends with $80 (E-0147)
MetaSprites3FSet1EFrame10::
    db $f8, $05, $11, $00 ; entry 0
    db $f8, $f5, $0f, $00 ; entry 1
    db $f0, $0b, $09, $20 ; entry 2
    db $f0, $03, $0a, $20 ; entry 3
    db $f0, $fb, $0b, $20 ; entry 4
    db $f0, $f3, $0c, $20 ; entry 5
    db $f0, $eb, $0d, $20 ; entry 6
    db $e8, $ff, $06, $20 ; entry 7
    db $e8, $f7, $07, $20 ; entry 8
    db $e8, $ef, $08, $20 ; entry 9
    db $e0, $01, $02, $20 ; entry 10
    db $e0, $f9, $03, $20 ; entry 11
    db $e0, $f1, $04, $20 ; entry 12
    db $d8, $fe, $00, $20 ; entry 13
    db $d8, $f6, $01, $20 ; entry 14
    db $e8, $07, $05, $20 ; entry 15
    db $f8, $ed, $17, $20 ; entry 16
    db $f8, $0d, $13, $20 ; entry 17
    db $f8, $fd, $19, $00 ; entry 18
    db $80 ; end

; frame 11 of MetaSprites3FSet1E; ends with $80 (E-0147)
MetaSprites3FSet1EFrame11::
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

; frame 12 of MetaSprites3FSet1E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet1EFrame12::
    db $f8, $f4, $14, $00 ; entry 0
    db $f8, $fc, $15, $00 ; entry 1
    db $f8, $04, $16, $00 ; entry 2
    db $f0, $fd, $10, $00 ; entry 3
    db $f0, $05, $11, $00 ; entry 4
    db $f0, $0d, $12, $00 ; entry 5
    db $f0, $ed, $0e, $00 ; entry 6
    db $e8, $eb, $09, $00 ; entry 7
    db $e8, $f3, $0a, $00 ; entry 8
    db $e8, $fb, $0b, $00 ; entry 9
    db $e8, $03, $0c, $00 ; entry 10
    db $e8, $0b, $0d, $00 ; entry 11
    db $e0, $f7, $06, $00 ; entry 12
    db $e0, $ff, $07, $00 ; entry 13
    db $e0, $07, $08, $00 ; entry 14
    db $d8, $f5, $02, $00 ; entry 15
    db $d8, $fd, $03, $00 ; entry 16
    db $d0, $f8, $00, $00 ; entry 17
    db $d0, $00, $01, $00 ; entry 18
    db $e0, $ef, $05, $00 ; entry 19
    db $f0, $f5, $18, $00 ; entry 20
    db $f8, $0c, $1a, $00 ; entry 21
    db $f8, $ec, $13, $00 ; entry 22
    db $d8, $05, $0d, $00 ; entry 23
    db $80 ; end

; frame 13 of MetaSprites3FSet1E; ends with $80 (E-0147)
MetaSprites3FSet1EFrame13::
    db $f8, $0c, $13, $20 ; entry 0
    db $f8, $04, $14, $20 ; entry 1
    db $f8, $ec, $17, $20 ; entry 2
    db $f0, $fb, $10, $20 ; entry 3
    db $f0, $f3, $11, $20 ; entry 4
    db $f0, $eb, $12, $20 ; entry 5
    db $f0, $0b, $0e, $20 ; entry 6
    db $f0, $03, $0f, $20 ; entry 7
    db $e8, $0d, $09, $20 ; entry 8
    db $e8, $05, $0a, $20 ; entry 9
    db $e8, $fd, $0b, $20 ; entry 10
    db $e8, $f5, $0c, $20 ; entry 11
    db $e8, $ed, $0d, $20 ; entry 12
    db $e0, $01, $06, $20 ; entry 13
    db $e0, $f9, $07, $20 ; entry 14
    db $e0, $f1, $08, $20 ; entry 15
    db $d8, $03, $02, $20 ; entry 16
    db $d8, $fb, $03, $20 ; entry 17
    db $d8, $f3, $04, $20 ; entry 18
    db $d0, $00, $00, $20 ; entry 19
    db $d0, $f8, $01, $20 ; entry 20
    db $e0, $09, $05, $20 ; entry 21
    db $f8, $f4, $18, $00 ; entry 22
    db $f8, $fc, $11, $00 ; entry 23
    db $80 ; end

; frame 14 of MetaSprites3FSet1E; ends with $80 (E-0147)
MetaSprites3FSet1EFrame14::
    db $f8, $f0, $11, $20 ; entry 0
    db $f8, $e8, $13, $00 ; entry 1
    db $f8, $f8, $15, $00 ; entry 2
    db $f8, $08, $0f, $20 ; entry 3
    db $f0, $e8, $09, $00 ; entry 4
    db $f0, $f0, $0a, $00 ; entry 5
    db $f0, $f8, $0b, $00 ; entry 6
    db $f0, $08, $0c, $00 ; entry 7
    db $f8, $10, $13, $20 ; entry 8
    db $f0, $10, $09, $20 ; entry 9
    db $f8, $00, $0b, $00 ; entry 10
    db $f0, $00, $07, $00 ; entry 11
    db $e8, $f4, $02, $00 ; entry 12
    db $e8, $fc, $03, $00 ; entry 13
    db $e8, $04, $04, $00 ; entry 14
    db $e0, $f7, $00, $00 ; entry 15
    db $e0, $ff, $01, $00 ; entry 16
    db $e8, $0b, $24, $00 ; entry 17
    db $e8, $ed, $04, $20 ; entry 18
    db $80 ; end

; frame 15 of MetaSprites3FSet1E; ends with $80 (E-0147)
MetaSprites3FSet1EFrame15::
    db $f8, $05, $11, $00 ; entry 0
    db $f8, $f5, $0f, $00 ; entry 1
    db $f8, $ed, $17, $20 ; entry 2
    db $f8, $0d, $13, $20 ; entry 3
    db $f8, $fd, $19, $00 ; entry 4
    db $f0, $f8, $0b, $20 ; entry 5
    db $f0, $f0, $0c, $20 ; entry 6
    db $f0, $e8, $0d, $20 ; entry 7
    db $f0, $08, $0a, $20 ; entry 8
    db $f0, $00, $19, $00 ; entry 9
    db $e8, $f0, $07, $20 ; entry 10
    db $e8, $e8, $08, $20 ; entry 11
    db $e0, $f2, $03, $20 ; entry 12
    db $e0, $ea, $04, $20 ; entry 13
    db $d8, $ef, $01, $20 ; entry 14
    db $e8, $08, $06, $20 ; entry 15
    db $e8, $00, $09, $00 ; entry 16
    db $e8, $f8, $09, $20 ; entry 17
    db $e8, $10, $0d, $00 ; entry 18
    db $e0, $04, $08, $20 ; entry 19
    db $e0, $0c, $05, $20 ; entry 20
    db $d8, $06, $04, $00 ; entry 21
    db $f0, $10, $1a, $00 ; entry 22
    db $80 ; end

; frame 16 of MetaSprites3FSet1E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet1EFrame16::
    db $f8, $e8, $17, $20 ; entry 0
    db $f8, $f0, $18, $00 ; entry 1
    db $f8, $f8, $11, $00 ; entry 2
    db $f8, $10, $13, $20 ; entry 3
    db $f8, $08, $14, $20 ; entry 4
    db $f8, $00, $19, $00 ; entry 5
    db $f0, $f0, $11, $20 ; entry 6
    db $f0, $10, $0e, $20 ; entry 7
    db $f0, $08, $0f, $20 ; entry 8
    db $e8, $10, $09, $20 ; entry 9
    db $f0, $e8, $0e, $00 ; entry 10
    db $e8, $e8, $09, $00 ; entry 11
    db $e8, $f0, $04, $00 ; entry 12
    db $f0, $00, $04, $20 ; entry 13
    db $e8, $08, $02, $00 ; entry 14
    db $f0, $f8, $02, $20 ; entry 15
    db $e0, $0c, $27, $20 ; entry 16
    db $d0, $07, $24, $20 ; entry 17
    db $d8, $0c, $22, $20 ; entry 18
    db $d8, $04, $23, $20 ; entry 19
    db $e0, $ec, $27, $00 ; entry 20
    db $d0, $f1, $24, $00 ; entry 21
    db $d8, $ec, $22, $00 ; entry 22
    db $d8, $f4, $23, $00 ; entry 23
    db $d0, $e8, $2b, $00 ; entry 24
    db $d0, $10, $2b, $20 ; entry 25
    db $80 ; end

; frame 17 of MetaSprites3FSet1E; ends with $80 (E-0147)
MetaSprites3FSet1EFrame17::
    db $d8, $0c, $22, $20 ; entry 0
    db $d8, $04, $23, $20 ; entry 1
    db $d8, $ec, $22, $00 ; entry 2
    db $d8, $f4, $23, $00 ; entry 3
    db $e8, $10, $0e, $20 ; entry 4
    db $f0, $10, $13, $20 ; entry 5
    db $f0, $e8, $13, $00 ; entry 6
    db $f0, $f0, $14, $00 ; entry 7
    db $f8, $f0, $1a, $20 ; entry 8
    db $f8, $f8, $0a, $00 ; entry 9
    db $f8, $00, $0c, $00 ; entry 10
    db $f8, $08, $12, $00 ; entry 11
    db $f0, $00, $09, $00 ; entry 12
    db $f0, $08, $0a, $00 ; entry 13
    db $e8, $08, $05, $00 ; entry 14
    db $e0, $08, $0d, $20 ; entry 15
    db $e0, $10, $09, $20 ; entry 16
    db $e8, $e8, $0e, $00 ; entry 17
    db $e8, $f0, $05, $20 ; entry 18
    db $e0, $f0, $0d, $00 ; entry 19
    db $e0, $e8, $09, $00 ; entry 20
    db $f0, $f8, $09, $20 ; entry 21
    db $e8, $00, $26, $00 ; entry 22
    db $e8, $f8, $20, $00 ; entry 23
    db $e0, $00, $21, $00 ; entry 24
    db $e0, $f8, $21, $20 ; entry 25
    db $d3, $00, $20, $00 ; entry 26
    db $d3, $f8, $20, $20 ; entry 27
    db $80 ; end

; frame 18 of MetaSprites3FSet1E; ends with $80 (E-0147)
MetaSprites3FSet1EFrame18::
    db $e4, $03, $06, $20 ; entry 0
    db $e4, $f3, $08, $20 ; entry 1
    db $dc, $05, $02, $20 ; entry 2
    db $dc, $f5, $04, $20 ; entry 3
    db $d4, $fc, $04, $20 ; entry 4
    db $d4, $ff, $02, $20 ; entry 5
    db $dc, $fd, $07, $20 ; entry 6
    db $e4, $fb, $0b, $20 ; entry 7
    db $e4, $09, $09, $20 ; entry 8
    db $ec, $f8, $0f, $40 ; entry 9
    db $ec, $f0, $12, $20 ; entry 10
    db $ec, $08, $17, $00 ; entry 11
    db $ec, $00, $18, $20 ; entry 12
    db $f4, $fb, $19, $00 ; entry 13
    db $f4, $03, $1a, $00 ; entry 14
    db $f4, $f3, $1a, $20 ; entry 15
    db $80 ; end

; frame 19 of MetaSprites3FSet1E; ends with $80 (E-0147)
MetaSprites3FSet1EFrame19::
    db $f8, $fc, $1b, $00 ; entry 0
    db $e0, $fc, $24, $00 ; entry 1
    db $e8, $fc, $03, $00 ; entry 2
    db $f0, $04, $12, $00 ; entry 3
    db $f0, $fc, $0c, $20 ; entry 4
    db $f0, $f4, $0d, $20 ; entry 5
    db $e8, $f4, $22, $00 ; entry 6
    db $e8, $04, $23, $00 ; entry 7
    db $80 ; end

; frame 20 of MetaSprites3FSet1E; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet1EFrame20::
    db $80 ; end

; meta-sprite set 31 of MetaSprites3FTable: 32 frame pointer(s), chosen by hSpriteSubIndex (E-0147)
; record: frame
MetaSprites3FSet1F::
    dw MetaSprites3FSet1FFrame0 ; entry 0
    dw MetaSprites3FSet1FFrame1 ; entry 1
    dw MetaSprites3FSet1FFrame2 ; entry 2
    dw MetaSprites3FSet1FFrame3 ; entry 3
    dw MetaSprites3FSet1FFrame4 ; entry 4
    dw MetaSprites3FSet1FFrame5 ; entry 5
    dw MetaSprites3FSet1FFrame6 ; entry 6
    dw MetaSprites3FSet1FFrame7 ; entry 7
    dw MetaSprites3FSet1FFrame8 ; entry 8
    dw MetaSprites3FSet1FFrame9 ; entry 9
    dw MetaSprites3FSet1FFrame10 ; entry 10
    dw MetaSprites3FSet1FFrame11 ; entry 11
    dw MetaSprites3FSet1FFrame12 ; entry 12
    dw MetaSprites3FSet1FFrame13 ; entry 13
    dw MetaSprites3FSet1FFrame14 ; entry 14
    dw MetaSprites3FSet1FFrame15 ; entry 15
    dw MetaSprites3FSet1FFrame16 ; entry 16
    dw MetaSprites3FSet1FFrame17 ; entry 17
    dw MetaSprites3FSet1FFrame17 ; entry 18
    dw MetaSprites3FSet1FFrame17 ; entry 19
    dw MetaSprites3FSet1FFrame17 ; entry 20
    dw MetaSprites3FSet1FFrame17 ; entry 21
    dw MetaSprites3FSet1FFrame17 ; entry 22
    dw MetaSprites3FSet1FFrame17 ; entry 23
    dw MetaSprites3FSet1FFrame17 ; entry 24
    dw MetaSprites3FSet1FFrame17 ; entry 25
    dw MetaSprites3FSet1FFrame17 ; entry 26
    dw MetaSprites3FSet1FFrame17 ; entry 27
    dw MetaSprites3FSet1FFrame17 ; entry 28
    dw MetaSprites3FSet1FFrame17 ; entry 29
    dw MetaSprites3FSet1FFrame17 ; entry 30
    dw MetaSprites3FSet1FFrame17 ; entry 31

; frame 0 of MetaSprites3FSet1F; ends with $80 (E-0147)
MetaSprites3FSet1FFrame0::
    db $d8, $03, $20, $00 ; entry 0
    db $d8, $0b, $21, $00 ; entry 1
    db $d0, $03, $22, $00 ; entry 2
    db $d0, $0b, $23, $00 ; entry 3
    db $80 ; end

; frame 1 of MetaSprites3FSet1F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet1FFrame1::
    db $dc, $00, $20, $00 ; entry 0
    db $dc, $08, $21, $00 ; entry 1
    db $d4, $00, $22, $00 ; entry 2
    db $d4, $08, $23, $00 ; entry 3
    db $e4, $f8, $20, $60 ; entry 4
    db $e4, $f0, $21, $60 ; entry 5
    db $ec, $f8, $22, $60 ; entry 6
    db $ec, $f0, $23, $60 ; entry 7
    db $80 ; end

; frame 2 of MetaSprites3FSet1F; ends with $80 (E-0147)
MetaSprites3FSet1FFrame2::
    db $d0, $00, $24, $00 ; entry 0
    db $d0, $08, $25, $00 ; entry 1
    db $d8, $fc, $26, $00 ; entry 2
    db $d8, $04, $27, $00 ; entry 3
    db $e0, $f8, $28, $00 ; entry 4
    db $e0, $00, $29, $00 ; entry 5
    db $e8, $f0, $2a, $00 ; entry 6
    db $e8, $f8, $2b, $00 ; entry 7
    db $f0, $f4, $2c, $00 ; entry 8
    db $f8, $f0, $2d, $00 ; entry 9
    db $80 ; end

; frame 3 of MetaSprites3FSet1F; ends with $80 (E-0147)
MetaSprites3FSet1FFrame3::
    db $d8, $fb, $24, $00 ; entry 0
    db $d8, $03, $25, $00 ; entry 1
    db $e0, $f7, $26, $00 ; entry 2
    db $e0, $ff, $27, $00 ; entry 3
    db $e8, $f3, $28, $00 ; entry 4
    db $e8, $fb, $29, $00 ; entry 5
    db $f0, $eb, $2a, $00 ; entry 6
    db $f0, $f3, $2b, $00 ; entry 7
    db $f8, $ef, $2c, $00 ; entry 8
    db $d0, $08, $05, $00 ; entry 9
    db $d0, $00, $24, $00 ; entry 10
    db $e8, $eb, $12, $00 ; entry 11
    db $80 ; end

; frame 4 of MetaSprites3FSet1F; ends with $80 (E-0147)
MetaSprites3FSet1FFrame4::
    db $f8, $ee, $2e, $00 ; entry 0
    db $f0, $f3, $2e, $00 ; entry 1
    db $e8, $f8, $2e, $00 ; entry 2
    db $e0, $fe, $2e, $00 ; entry 3
    db $d8, $03, $2e, $00 ; entry 4
    db $d0, $08, $2e, $00 ; entry 5
    db $f0, $eb, $11, $20 ; entry 6
    db $e0, $f6, $0b, $20 ; entry 7
    db $80 ; end

; frame 5 of MetaSprites3FSet1F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet1FFrame5::
    db $e8, $f0, $24, $00 ; entry 0
    db $f0, $f3, $2e, $00 ; entry 1
    db $e8, $f8, $2e, $00 ; entry 2
    db $e0, $fe, $2f, $00 ; entry 3
    db $d8, $03, $2f, $00 ; entry 4
    db $f8, $ee, $2e, $00 ; entry 5
    db $80 ; end

; frame 6 of MetaSprites3FSet1F; ends with $80 (E-0147)
MetaSprites3FSet1FFrame6::
    db $f8, $f0, $2f, $00 ; entry 0
    db $f0, $f5, $2f, $00 ; entry 1
    db $e8, $fa, $2f, $00 ; entry 2
    db $80 ; end

; frame 7 of MetaSprites3FSet1F; ends with $80 (E-0147)
MetaSprites3FSet1FFrame7::
    db $e8, $f8, $05, $00 ; entry 0
    db $e8, $00, $13, $00 ; entry 1
    db $e0, $00, $0c, $60 ; entry 2
    db $e0, $f8, $0b, $20 ; entry 3
    db $d8, $f3, $01, $20 ; entry 4
    db $ee, $f2, $00, $60 ; entry 5
    db $ed, $07, $01, $40 ; entry 6
    db $dd, $04, $00, $00 ; entry 7
    db $80 ; end

; frame 8 of MetaSprites3FSet1F; ends with $80 (E-0147)
MetaSprites3FSet1FFrame8::
    db $e8, $f8, $03, $00 ; entry 0
    db $e8, $f0, $02, $00 ; entry 1
    db $e0, $00, $03, $60 ; entry 2
    db $e0, $08, $02, $60 ; entry 3
    db $e0, $f8, $0d, $00 ; entry 4
    db $e8, $00, $0d, $00 ; entry 5
    db $f0, $00, $05, $00 ; entry 6
    db $d8, $f8, $05, $60 ; entry 7
    db $d6, $f0, $00, $20 ; entry 8
    db $d6, $08, $01, $00 ; entry 9
    db $f2, $f0, $01, $60 ; entry 10
    db $f2, $08, $00, $40 ; entry 11
    db $80 ; end

; frame 9 of MetaSprites3FSet1F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet1FFrame9::
    db $ec, $f0, $08, $00 ; entry 0
    db $ec, $f8, $09, $00 ; entry 1
    db $ec, $08, $0c, $60 ; entry 2
    db $ec, $00, $0d, $60 ; entry 3
    db $dc, $f0, $0e, $40 ; entry 4
    db $dc, $f8, $0f, $40 ; entry 5
    db $dc, $00, $18, $40 ; entry 6
    db $dc, $08, $19, $40 ; entry 7
    db $e4, $f8, $10, $00 ; entry 8
    db $e4, $00, $11, $00 ; entry 9
    db $d4, $03, $05, $60 ; entry 10
    db $f4, $0b, $02, $20 ; entry 11
    db $f4, $03, $03, $20 ; entry 12
    db $d4, $f5, $19, $00 ; entry 13
    db $f4, $f4, $05, $00 ; entry 14
    db $80 ; end

; frame 10 of MetaSprites3FSet1F; ends with $80 (E-0147)
MetaSprites3FSet1FFrame10::
    db $d0, $f8, $0c, $00 ; entry 0
    db $d0, $00, $0d, $00 ; entry 1
    db $d7, $01, $05, $00 ; entry 2
    db $f8, $f8, $08, $20 ; entry 3
    db $f8, $f0, $18, $00 ; entry 4
    db $f0, $ea, $05, $40 ; entry 5
    db $d8, $0c, $01, $00 ; entry 6
    db $f8, $e8, $01, $20 ; entry 7
    db $d5, $f0, $08, $60 ; entry 8
    db $d5, $e8, $09, $60 ; entry 9
    db $dd, $ea, $05, $20 ; entry 10
    db $f4, $04, $02, $40 ; entry 11
    db $f8, $0c, $03, $00 ; entry 12
    db $f4, $10, $02, $60 ; entry 13
    db $80 ; end

; frame 11 of MetaSprites3FSet1F; ends with $80 (E-0147)
MetaSprites3FSet1FFrame11::
    db $d0, $00, $16, $20 ; entry 0
    db $d0, $f8, $17, $20 ; entry 1
    db $d8, $00, $18, $20 ; entry 2
    db $d8, $f8, $19, $20 ; entry 3
    db $e0, $fc, $18, $20 ; entry 4
    db $e0, $f4, $19, $20 ; entry 5
    db $e8, $f8, $05, $00 ; entry 6
    db $de, $e3, $0b, $60 ; entry 7
    db $e8, $ec, $01, $00 ; entry 8
    db $f8, $10, $18, $00 ; entry 9
    db $f8, $00, $01, $00 ; entry 10
    db $f8, $f8, $01, $20 ; entry 11
    db $80 ; end

; frame 12 of MetaSprites3FSet1F; ends with $80 (E-0147)
MetaSprites3FSet1FFrame12::
    db $d0, $01, $06, $20 ; entry 0
    db $d0, $f9, $07, $20 ; entry 1
    db $d8, $03, $08, $20 ; entry 2
    db $d8, $fb, $09, $20 ; entry 3
    db $e0, $00, $0a, $20 ; entry 4
    db $e0, $f8, $0b, $20 ; entry 5
    db $e8, $05, $0c, $20 ; entry 6
    db $e8, $fd, $0d, $20 ; entry 7
    db $f0, $05, $0e, $20 ; entry 8
    db $f0, $fd, $0f, $20 ; entry 9
    db $f8, $00, $10, $20 ; entry 10
    db $f8, $f8, $11, $20 ; entry 11
    db $f8, $f4, $1d, $20 ; entry 12
    db $f8, $02, $1d, $00 ; entry 13
    db $d0, $10, $1b, $00 ; entry 14
    db $d0, $08, $1b, $00 ; entry 15
    db $d8, $0b, $1b, $00 ; entry 16
    db $d8, $10, $1b, $00 ; entry 17
    db $e0, $10, $1b, $00 ; entry 18
    db $e0, $08, $1b, $00 ; entry 19
    db $e8, $10, $1b, $00 ; entry 20
    db $f0, $10, $1b, $00 ; entry 21
    db $f8, $10, $1b, $00 ; entry 22
    db $f8, $0a, $1b, $00 ; entry 23
    db $d0, $f0, $1b, $20 ; entry 24
    db $d8, $f0, $1b, $20 ; entry 25
    db $e0, $f0, $1b, $20 ; entry 26
    db $e8, $f0, $1b, $20 ; entry 27
    db $f0, $f0, $1b, $20 ; entry 28
    db $f8, $f0, $1b, $20 ; entry 29
    db $d0, $e8, $1b, $20 ; entry 30
    db $d8, $e8, $1b, $20 ; entry 31
    db $e0, $e8, $1b, $20 ; entry 32
    db $e8, $e8, $1b, $20 ; entry 33
    db $f0, $e8, $1b, $20 ; entry 34
    db $f8, $e8, $1b, $20 ; entry 35
    db $e8, $f5, $1b, $20 ; entry 36
    db $f0, $f5, $1b, $20 ; entry 37
    db $80 ; end

; frame 13 of MetaSprites3FSet1F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet1FFrame13::
    db $d0, $02, $0c, $20 ; entry 0
    db $d0, $fa, $0d, $20 ; entry 1
    db $d8, $f1, $16, $00 ; entry 2
    db $d8, $f9, $17, $00 ; entry 3
    db $e0, $f7, $16, $20 ; entry 4
    db $e0, $ef, $17, $20 ; entry 5
    db $e8, $f7, $18, $20 ; entry 6
    db $e8, $ef, $19, $20 ; entry 7
    db $f0, $f7, $1a, $20 ; entry 8
    db $e5, $fe, $06, $20 ; entry 9
    db $ed, $01, $05, $20 ; entry 10
    db $f8, $fc, $1e, $00 ; entry 11
    db $f8, $04, $1f, $00 ; entry 12
    db $f8, $f4, $1e, $20 ; entry 13
    db $f8, $ec, $1f, $20 ; entry 14
    db $f0, $ef, $0c, $00 ; entry 15
    db $80 ; end

; frame 14 of MetaSprites3FSet1F; ends with $80 (E-0147)
MetaSprites3FSet1FFrame14::
    db $d8, $0b, $08, $20 ; entry 0
    db $d8, $03, $09, $20 ; entry 1
    db $d0, $01, $18, $00 ; entry 2
    db $d0, $09, $19, $00 ; entry 3
    db $e0, $05, $14, $00 ; entry 4
    db $e0, $0d, $15, $00 ; entry 5
    db $e8, $06, $0c, $00 ; entry 6
    db $e8, $0e, $0d, $00 ; entry 7
    db $f0, $05, $0e, $00 ; entry 8
    db $f0, $0d, $0f, $00 ; entry 9
    db $e8, $03, $0d, $20 ; entry 10
    db $f0, $fe, $0c, $00 ; entry 11
    db $f8, $0c, $1c, $00 ; entry 12
    db $f8, $04, $1c, $20 ; entry 13
    db $f8, $fc, $1d, $20 ; entry 14
    db $d0, $e8, $1b, $00 ; entry 15
    db $d8, $e8, $1b, $00 ; entry 16
    db $e0, $e8, $1b, $00 ; entry 17
    db $e8, $e8, $1b, $00 ; entry 18
    db $f0, $e9, $1b, $00 ; entry 19
    db $f8, $e9, $1b, $00 ; entry 20
    db $d0, $f0, $1b, $00 ; entry 21
    db $d8, $f1, $1b, $00 ; entry 22
    db $e0, $f2, $1b, $00 ; entry 23
    db $e8, $f1, $1b, $00 ; entry 24
    db $f0, $f3, $1b, $00 ; entry 25
    db $f8, $f3, $1b, $00 ; entry 26
    db $d0, $f8, $1b, $00 ; entry 27
    db $d8, $fa, $1b, $00 ; entry 28
    db $e8, $fa, $1b, $00 ; entry 29
    db $e0, $fc, $1b, $00 ; entry 30
    db $d0, $10, $1b, $20 ; entry 31
    db $f8, $14, $1f, $00 ; entry 32
    db $80 ; end

; frame 15 of MetaSprites3FSet1F; ends with $80 (E-0147)
MetaSprites3FSet1FFrame15::
    db $f8, $00, $1f, $00 ; entry 0
    db $d0, $03, $14, $20 ; entry 1
    db $d0, $fb, $15, $20 ; entry 2
    db $d8, $09, $0a, $20 ; entry 3
    db $d8, $01, $0b, $20 ; entry 4
    db $f8, $0f, $1e, $00 ; entry 5
    db $f8, $17, $1f, $00 ; entry 6
    db $f8, $07, $1e, $20 ; entry 7
    db $e0, $08, $16, $40 ; entry 8
    db $e0, $10, $17, $40 ; entry 9
    db $e8, $11, $0c, $20 ; entry 10
    db $e8, $09, $0d, $20 ; entry 11
    db $f0, $10, $0e, $20 ; entry 12
    db $f0, $08, $0f, $20 ; entry 13
    db $e8, $fa, $14, $60 ; entry 14
    db $e8, $f2, $15, $60 ; entry 15
    db $f0, $fa, $10, $20 ; entry 16
    db $f0, $f2, $11, $20 ; entry 17
    db $f8, $f0, $1c, $20 ; entry 18
    db $f8, $f8, $1c, $00 ; entry 19
    db $f8, $00, $1d, $00 ; entry 20
    db $e0, $f3, $0b, $60 ; entry 21
    db $f8, $e8, $1d, $20 ; entry 22
    db $dc, $f3, $0c, $00 ; entry 23
    db $d8, $fa, $09, $00 ; entry 24
    db $e0, $fb, $0a, $60 ; entry 25
    db $80 ; end

; frame 16 of MetaSprites3FSet1F; ends with $80 (E-0147)
MetaSprites3FSet1FFrame16::
    db $d0, $fe, $10, $20 ; entry 0
    db $d0, $f6, $11, $20 ; entry 1
    db $d8, $f4, $12, $40 ; entry 2
    db $d8, $fc, $13, $40 ; entry 3
    db $e8, $f6, $10, $20 ; entry 4
    db $e8, $ee, $11, $20 ; entry 5
    db $f0, $f0, $18, $20 ; entry 6
    db $d8, $06, $14, $00 ; entry 7
    db $d8, $0e, $15, $00 ; entry 8
    db $e0, $0f, $10, $20 ; entry 9
    db $e0, $07, $11, $20 ; entry 10
    db $e8, $04, $06, $00 ; entry 11
    db $e8, $0c, $07, $00 ; entry 12
    db $f0, $01, $14, $00 ; entry 13
    db $f0, $09, $15, $00 ; entry 14
    db $f8, $10, $1f, $00 ; entry 15
    db $f8, $01, $1e, $20 ; entry 16
    db $f8, $09, $1e, $00 ; entry 17
    db $f0, $0c, $04, $00 ; entry 18
    db $f8, $10, $05, $20 ; entry 19
    db $d0, $02, $12, $00 ; entry 20
    db $d0, $0a, $13, $00 ; entry 21
    db $f8, $f9, $1f, $20 ; entry 22
    db $f8, $f4, $1c, $00 ; entry 23
    db $f8, $fc, $1d, $00 ; entry 24
    db $f8, $ec, $1c, $20 ; entry 25
    db $f0, $f8, $1b, $00 ; entry 26
    db $f8, $e4, $1f, $20 ; entry 27
    db $d0, $e8, $1b, $20 ; entry 28
    db $d8, $e8, $1b, $20 ; entry 29
    db $e0, $e8, $1b, $20 ; entry 30
    db $d0, $10, $1b, $00 ; entry 31
    db $e8, $fd, $1b, $00 ; entry 32
    db $f0, $e8, $0e, $00 ; entry 33
    db $e0, $f6, $14, $00 ; entry 34
    db $e0, $fe, $15, $00 ; entry 35
    db $80 ; end

; frame 17 of MetaSprites3FSet1F; ends with $80 (E-0147)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3FSet1FFrame17::
    db $80 ; end
    ds $850, $00
