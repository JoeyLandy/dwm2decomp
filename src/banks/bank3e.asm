SECTION "Bank 3E", ROMX[$4000], BANK[$3E]
    db $3E

; sets the sprite origin X = wD804, Y = $68, tile offset = wD801, attribute XOR = wDAB7, then builds OAM from the local sprite table (E-0121)
; 1 call site from 1 routine (e.g. DrawEffectSpriteForEffectTileOffsetRange)
; reads: wEffectSpriteX, wEffectTileOffset, wEffectSpriteAttrXor
; points at: hSpriteOriginX
DrawEffectSpriteAtEffectSpriteX_Bank3E::
Func_03E_4001:: ; address name
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
    ld de, Data_03E_4024
    call BuildOamFromSpriteTable_Bank3E
    ret

; E-0147 (C1: the caller of BuildOamFromSpriteTable_Bank3E passes DE = $3E:4024; the builder takes the word at DE + 2 * hSpriteSetIndex as the set and the word at set + 2 * hSpriteSubIndex as the frame; 14 words, up to the next code or data).
; record: meta-sprite set
MetaSprites3E_4024Table::
Data_03E_4024:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw MetaSprites3E_4024Set00 ; id 0
    dw MetaSprites3E_4024Set01 ; id 1
    dw MetaSprites3E_4024Set02 ; id 2
    dw MetaSprites3E_4024Set03 ; id 3
    dw MetaSprites3E_4024Set04 ; id 4
    dw MetaSprites3E_4024Set05 ; id 5
    dw MetaSprites3E_4024Set06 ; id 6
    dw MetaSprites3E_4024Set07 ; id 7
    dw MetaSprites3E_4024Set08 ; id 8
    dw MetaSprites3E_4024Set09 ; id 9
    dw MetaSprites3E_4024Set0A ; id 10
    dw MetaSprites3E_4024Set0B ; id 11
    dw MetaSprites3E_4024Set0C ; id 12
    dw MetaSprites3E_4024Set0D ; id 13

; DE = two-level table; entries are chosen by hSpriteSetIndex and hSpriteSubIndex; writes 4-byte OAM entries at $C000 + 4 * hOamNextEntry (Y = hSpriteOriginY + b + $10, X = hSpriteOriginX + b + 8, tile += hSpriteTileOffset, flags ^= hSpriteAttrXor) until a $80 byte or hOamNextEntry reaches $28 (40 entries) (the same 81 bytes appear in 5 banks)
; 1 call site from 1 routine (e.g. DrawEffectSpriteAtEffectSpriteX_Bank3E)
; reads: hOamNextEntry, hSpriteSetIndex, hSpriteSubIndex, hSpriteOriginY, hSpriteOriginX, hSpriteTileOffset, hSpriteAttrXor
; writes: hOamNextEntry
BuildOamFromSpriteTable_Bank3E::
Func_03E_4040:: ; address name
    ldh a, [hOamNextEntry]
    cp a, $28
    jr nc, Jump_03E_4090
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

Jump_03E_4063::
    ld a, [de]
    inc de
    cp a, $80
    jr z, Jump_03E_4090
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
    jr c, Jump_03E_4063

Jump_03E_4090::
    ret

; E-0147 (derived: meta-sprite set 0 of MetaSprites3E_4024Table: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3E_4024Set00::
Data_03E_4091:: ; heuristic: meta-sprite set; C0
    dw MetaSprites3E_4024Set00Frame0 ; entry 0
    dw MetaSprites3E_4024Set00Frame1 ; entry 1
    dw MetaSprites3E_4024Set00Frame2 ; entry 2
    dw MetaSprites3E_4024Set00Frame3 ; entry 3
    dw MetaSprites3E_4024Set00Frame4 ; entry 4
    dw MetaSprites3E_4024Set00Frame5 ; entry 5
    dw MetaSprites3E_4024Set00Frame6 ; entry 6
    dw MetaSprites3E_4024Set00Frame7 ; entry 7
    dw MetaSprites3E_4024Set00Frame8 ; entry 8
    dw MetaSprites3E_4024Set00Frame8 ; entry 9
    dw MetaSprites3E_4024Set00Frame8 ; entry 10
    dw MetaSprites3E_4024Set00Frame8 ; entry 11
    dw MetaSprites3E_4024Set00Frame8 ; entry 12
    dw MetaSprites3E_4024Set00Frame8 ; entry 13
    dw MetaSprites3E_4024Set00Frame8 ; entry 14
    dw MetaSprites3E_4024Set00Frame8 ; entry 15
    dw MetaSprites3E_4024Set00Frame8 ; entry 16
    dw MetaSprites3E_4024Set00Frame8 ; entry 17
    dw MetaSprites3E_4024Set00Frame8 ; entry 18
    dw MetaSprites3E_4024Set00Frame8 ; entry 19
    dw MetaSprites3E_4024Set00Frame8 ; entry 20
    dw MetaSprites3E_4024Set00Frame8 ; entry 21
    dw MetaSprites3E_4024Set00Frame8 ; entry 22
    dw MetaSprites3E_4024Set00Frame8 ; entry 23
    dw MetaSprites3E_4024Set00Frame8 ; entry 24
    dw MetaSprites3E_4024Set00Frame8 ; entry 25
    dw MetaSprites3E_4024Set00Frame8 ; entry 26
    dw MetaSprites3E_4024Set00Frame8 ; entry 27
    dw MetaSprites3E_4024Set00Frame8 ; entry 28
    dw MetaSprites3E_4024Set00Frame8 ; entry 29
    dw MetaSprites3E_4024Set00Frame8 ; entry 30
    dw MetaSprites3E_4024Set00Frame8 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3E_4024Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set00Frame0::
Data_03E_40D1:: ; heuristic: meta-sprite frame; C0
    db $F8, $F8, $00, $00 ; entry 0
    db $F8, $00, $01, $00 ; entry 1
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3E_4024Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set00Frame1::
Data_03E_40DA:: ; heuristic: meta-sprite frame; C0
    db $F0, $00, $00, $20 ; entry 0
    db $F0, $F8, $01, $20 ; entry 1
    db $F8, $08, $02, $20 ; entry 2
    db $F8, $00, $03, $20 ; entry 3
    db $F8, $F8, $04, $20 ; entry 4
    db $F8, $F0, $05, $20 ; entry 5
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3E_4024Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set00Frame2::
Data_03E_40F3:: ; heuristic: meta-sprite frame; C0
    db $F8, $FC, $06, $00 ; entry 0
    db $E8, $F8, $00, $00 ; entry 1
    db $E8, $00, $01, $00 ; entry 2
    db $F0, $F0, $02, $00 ; entry 3
    db $F0, $F8, $03, $00 ; entry 4
    db $F0, $00, $04, $00 ; entry 5
    db $F0, $08, $05, $00 ; entry 6
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3E_4024Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set00Frame3::
Data_03E_4110:: ; heuristic: meta-sprite frame; C0
    db $DE, $F8, $07, $00 ; entry 0
    db $E6, $F0, $08, $00 ; entry 1
    db $E6, $F8, $09, $00 ; entry 2
    db $E6, $00, $0A, $00 ; entry 3
    db $E6, $08, $0B, $00 ; entry 4
    db $EE, $F8, $0C, $00 ; entry 5
    db $EE, $00, $0D, $00 ; entry 6
    db $EE, $08, $0E, $00 ; entry 7
    db $F6, $00, $0F, $00 ; entry 8
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3E_4024Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set00Frame4::
Data_03E_4135:: ; heuristic: meta-sprite frame; C0
    db $F3, $01, $07, $60 ; entry 0
    db $EB, $09, $08, $60 ; entry 1
    db $EB, $01, $09, $60 ; entry 2
    db $EB, $F9, $0A, $60 ; entry 3
    db $EB, $F1, $0B, $60 ; entry 4
    db $E3, $01, $0C, $60 ; entry 5
    db $E3, $F9, $0D, $60 ; entry 6
    db $E3, $F1, $0E, $60 ; entry 7
    db $DB, $F9, $0F, $60 ; entry 8
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3E_4024Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set00Frame5::
Data_03E_415A:: ; heuristic: meta-sprite frame; C0
    db $EE, $F8, $14, $00 ; entry 0
    db $EE, $00, $15, $00 ; entry 1
    db $E6, $F8, $11, $00 ; entry 2
    db $E6, $00, $12, $00 ; entry 3
    db $E6, $08, $13, $00 ; entry 4
    db $DE, $00, $10, $00 ; entry 5
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3E_4024Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set00Frame6::
Data_03E_4173:: ; heuristic: meta-sprite frame; C0
    db $E7, $01, $14, $60 ; entry 0
    db $E7, $F9, $15, $60 ; entry 1
    db $EF, $01, $11, $60 ; entry 2
    db $EF, $F9, $12, $60 ; entry 3
    db $EF, $F1, $13, $60 ; entry 4
    db $F7, $F9, $10, $60 ; entry 5
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3E_4024Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set00Frame7::
Data_03E_418C:: ; heuristic: meta-sprite frame; C0
    db $E8, $F7, $16, $00 ; entry 0
    db $E8, $FF, $17, $00 ; entry 1
    db $F0, $F7, $18, $00 ; entry 2
    db $F0, $FF, $19, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites3E_4024Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set00Frame8::
    db $80 ; end

; E-0147 (derived: meta-sprite set 1 of MetaSprites3E_4024Table: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3E_4024Set01::
Data_03E_419E:: ; heuristic: meta-sprite set; C0
    dw MetaSprites3E_4024Set01Frame0 ; entry 0
    dw MetaSprites3E_4024Set01Frame1 ; entry 1
    dw MetaSprites3E_4024Set01Frame2 ; entry 2
    dw MetaSprites3E_4024Set01Frame3 ; entry 3
    dw MetaSprites3E_4024Set01Frame4 ; entry 4
    dw MetaSprites3E_4024Set01Frame5 ; entry 5
    dw MetaSprites3E_4024Set01Frame6 ; entry 6
    dw MetaSprites3E_4024Set01Frame7 ; entry 7
    dw MetaSprites3E_4024Set01Frame8 ; entry 8
    dw MetaSprites3E_4024Set01Frame9 ; entry 9
    dw MetaSprites3E_4024Set01Frame10 ; entry 10
    dw MetaSprites3E_4024Set01Frame11 ; entry 11
    dw MetaSprites3E_4024Set01Frame12 ; entry 12
    dw MetaSprites3E_4024Set01Frame13 ; entry 13
    dw MetaSprites3E_4024Set01Frame14 ; entry 14
    dw MetaSprites3E_4024Set01Frame15 ; entry 15
    dw MetaSprites3E_4024Set01Frame15 ; entry 16
    dw MetaSprites3E_4024Set01Frame15 ; entry 17
    dw MetaSprites3E_4024Set01Frame15 ; entry 18
    dw MetaSprites3E_4024Set01Frame15 ; entry 19
    dw MetaSprites3E_4024Set01Frame15 ; entry 20
    dw MetaSprites3E_4024Set01Frame15 ; entry 21
    dw MetaSprites3E_4024Set01Frame15 ; entry 22
    dw MetaSprites3E_4024Set01Frame15 ; entry 23
    dw MetaSprites3E_4024Set01Frame15 ; entry 24
    dw MetaSprites3E_4024Set01Frame15 ; entry 25
    dw MetaSprites3E_4024Set01Frame15 ; entry 26
    dw MetaSprites3E_4024Set01Frame15 ; entry 27
    dw MetaSprites3E_4024Set01Frame15 ; entry 28
    dw MetaSprites3E_4024Set01Frame15 ; entry 29
    dw MetaSprites3E_4024Set01Frame15 ; entry 30
    dw MetaSprites3E_4024Set01Frame15 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3E_4024Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set01Frame0::
Data_03E_41DE:: ; heuristic: meta-sprite frame; C0
    db $F8, $F8, $00, $00 ; entry 0
    db $F8, $00, $01, $00 ; entry 1
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3E_4024Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set01Frame1::
Data_03E_41E7:: ; heuristic: meta-sprite frame; C0
    db $F8, $FB, $03, $20 ; entry 0
    db $F0, $00, $00, $20 ; entry 1
    db $F8, $F3, $0D, $20 ; entry 2
    db $F8, $03, $05, $20 ; entry 3
    db $F0, $F8, $04, $20 ; entry 4
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3E_4024Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set01Frame2::
Data_03E_41FC:: ; heuristic: meta-sprite frame; C0
    db $F0, $F6, $02, $00 ; entry 0
    db $E8, $F9, $00, $00 ; entry 1
    db $F8, $F0, $05, $00 ; entry 2
    db $F8, $08, $05, $20 ; entry 3
    db $F0, $03, $02, $20 ; entry 4
    db $F0, $FE, $03, $00 ; entry 5
    db $E8, $FF, $04, $00 ; entry 6
    db $F8, $F8, $18, $00 ; entry 7
    db $F8, $00, $18, $20 ; entry 8
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3E_4024Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set01Frame3::
Data_03E_4221:: ; heuristic: meta-sprite frame; C0
    db $F0, $F5, $06, $00 ; entry 0
    db $F0, $05, $08, $00 ; entry 1
    db $E8, $F3, $02, $00 ; entry 2
    db $E8, $03, $04, $00 ; entry 3
    db $E0, $FC, $04, $00 ; entry 4
    db $E0, $F9, $02, $00 ; entry 5
    db $E8, $FB, $07, $00 ; entry 6
    db $F0, $FD, $0B, $00 ; entry 7
    db $F0, $EF, $09, $00 ; entry 8
    db $F8, $00, $0F, $60 ; entry 9
    db $F8, $F8, $18, $40 ; entry 10
    db $F8, $08, $12, $00 ; entry 11
    db $F8, $F0, $17, $20 ; entry 12
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3E_4024Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set01Frame4::
Data_03E_4256:: ; heuristic: meta-sprite frame; C0
    db $E8, $03, $06, $20 ; entry 0
    db $E8, $F3, $08, $20 ; entry 1
    db $E0, $05, $02, $20 ; entry 2
    db $E0, $F5, $04, $20 ; entry 3
    db $D8, $FC, $04, $20 ; entry 4
    db $D8, $FF, $02, $20 ; entry 5
    db $E0, $FD, $07, $20 ; entry 6
    db $E8, $FB, $0B, $20 ; entry 7
    db $E8, $09, $09, $20 ; entry 8
    db $F0, $F8, $0F, $40 ; entry 9
    db $F0, $F0, $12, $20 ; entry 10
    db $F0, $08, $17, $00 ; entry 11
    db $F0, $00, $18, $20 ; entry 12
    db $F8, $F8, $23, $00 ; entry 13
    db $F8, $00, $23, $20 ; entry 14
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3E_4024Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set01Frame5::
Data_03E_4293:: ; heuristic: meta-sprite frame; C0
    db $D4, $FC, $1B, $20 ; entry 0
    db $DC, $04, $1C, $20 ; entry 1
    db $DC, $FC, $1D, $20 ; entry 2
    db $DC, $F4, $1E, $20 ; entry 3
    db $E4, $04, $1F, $20 ; entry 4
    db $E4, $FC, $20, $20 ; entry 5
    db $E4, $F4, $21, $20 ; entry 6
    db $EC, $FC, $22, $20 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3E_4024Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set01Frame6::
Data_03E_42B4:: ; heuristic: meta-sprite frame; C0
    db $D8, $FC, $1B, $00 ; entry 0
    db $E0, $F4, $1C, $00 ; entry 1
    db $E0, $FC, $1D, $00 ; entry 2
    db $E0, $04, $1E, $00 ; entry 3
    db $E8, $F4, $1F, $00 ; entry 4
    db $E8, $FC, $20, $00 ; entry 5
    db $E8, $04, $21, $00 ; entry 6
    db $F0, $FC, $22, $00 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3E_4024Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set01Frame7::
Data_03E_42D5:: ; heuristic: meta-sprite frame; C0
    db $E8, $FC, $25, $20 ; entry 0
    db $E0, $FC, $24, $20 ; entry 1
    db $F0, $FC, $22, $20 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites3E_4024Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set01Frame8::
Data_03E_42E2:: ; heuristic: meta-sprite frame; C0
    db $F0, $F6, $02, $00 ; entry 0
    db $E8, $F9, $00, $00 ; entry 1
    db $F8, $F0, $05, $00 ; entry 2
    db $F8, $08, $05, $20 ; entry 3
    db $F0, $03, $02, $20 ; entry 4
    db $F0, $FE, $03, $00 ; entry 5
    db $E8, $FF, $04, $00 ; entry 6
    db $F8, $F8, $18, $00 ; entry 7
    db $F8, $00, $18, $20 ; entry 8
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites3E_4024Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set01Frame9::
Data_03E_4307:: ; heuristic: meta-sprite frame; C0
    db $F8, $05, $11, $00 ; entry 0
    db $F8, $F5, $0F, $00 ; entry 1
    db $F0, $0B, $09, $20 ; entry 2
    db $F8, $ED, $17, $20 ; entry 3
    db $F8, $0D, $13, $20 ; entry 4
    db $F8, $FD, $20, $00 ; entry 5
    db $F0, $03, $0C, $00 ; entry 6
    db $F0, $FB, $18, $00 ; entry 7
    db $E8, $06, $02, $20 ; entry 8
    db $E8, $FE, $03, $20 ; entry 9
    db $E8, $F6, $04, $20 ; entry 10
    db $D8, $FD, $24, $20 ; entry 11
    db $E0, $FD, $25, $20 ; entry 12
    db $F0, $F3, $09, $00 ; entry 13
    db $F0, $ED, $05, $00 ; entry 14
    db $80 ; end

; E-0147 (derived: frame 10 of MetaSprites3E_4024Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set01Frame10::
Data_03E_4344:: ; heuristic: meta-sprite frame; C0
    db $F8, $F3, $11, $20 ; entry 0
    db $F8, $03, $0F, $20 ; entry 1
    db $F0, $ED, $09, $00 ; entry 2
    db $F0, $F5, $0A, $00 ; entry 3
    db $F0, $FD, $0B, $00 ; entry 4
    db $F0, $05, $0C, $00 ; entry 5
    db $F0, $0D, $0D, $00 ; entry 6
    db $E8, $F9, $06, $00 ; entry 7
    db $E8, $01, $07, $00 ; entry 8
    db $E8, $09, $08, $00 ; entry 9
    db $E0, $F7, $02, $00 ; entry 10
    db $E0, $FF, $03, $00 ; entry 11
    db $E0, $07, $04, $00 ; entry 12
    db $D8, $FA, $00, $00 ; entry 13
    db $D8, $02, $01, $00 ; entry 14
    db $E8, $F1, $05, $00 ; entry 15
    db $F8, $0B, $17, $00 ; entry 16
    db $F8, $EB, $13, $00 ; entry 17
    db $F8, $FB, $15, $00 ; entry 18
    db $80 ; end

; E-0147 (derived: frame 11 of MetaSprites3E_4024Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set01Frame11::
Data_03E_4391:: ; heuristic: meta-sprite frame; C0
    db $F0, $FD, $10, $00 ; entry 0
    db $F0, $05, $11, $00 ; entry 1
    db $F0, $ED, $0E, $00 ; entry 2
    db $E8, $EB, $09, $00 ; entry 3
    db $E8, $F3, $0A, $00 ; entry 4
    db $E8, $FB, $0B, $00 ; entry 5
    db $E8, $03, $0C, $00 ; entry 6
    db $E8, $0B, $0D, $00 ; entry 7
    db $E0, $F7, $06, $00 ; entry 8
    db $E0, $FF, $07, $00 ; entry 9
    db $E0, $07, $08, $00 ; entry 10
    db $D8, $F5, $02, $00 ; entry 11
    db $D8, $FD, $03, $00 ; entry 12
    db $D0, $F8, $00, $00 ; entry 13
    db $D0, $00, $01, $00 ; entry 14
    db $E0, $EF, $05, $00 ; entry 15
    db $F0, $F5, $18, $00 ; entry 16
    db $D8, $05, $1C, $20 ; entry 17
    db $F8, $E8, $1F, $00 ; entry 18
    db $F8, $08, $16, $00 ; entry 19
    db $F8, $F8, $15, $00 ; entry 20
    db $F8, $F0, $14, $00 ; entry 21
    db $F8, $00, $10, $20 ; entry 22
    db $F8, $10, $21, $00 ; entry 23
    db $F0, $0D, $1C, $20 ; entry 24
    db $80 ; end

; E-0147 (derived: frame 12 of MetaSprites3E_4024Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set01Frame12::
Data_03E_43F6:: ; heuristic: meta-sprite frame; C0
    db $F0, $FB, $10, $20 ; entry 0
    db $F0, $F3, $11, $20 ; entry 1
    db $F0, $EB, $12, $20 ; entry 2
    db $F0, $03, $0F, $20 ; entry 3
    db $E8, $F5, $0C, $20 ; entry 4
    db $E8, $ED, $0D, $20 ; entry 5
    db $F8, $E8, $17, $20 ; entry 6
    db $F8, $F0, $18, $00 ; entry 7
    db $F8, $00, $20, $20 ; entry 8
    db $F8, $08, $14, $20 ; entry 9
    db $E8, $FD, $18, $20 ; entry 10
    db $E0, $F1, $02, $00 ; entry 11
    db $E0, $F9, $03, $00 ; entry 12
    db $E0, $01, $04, $00 ; entry 13
    db $D8, $FB, $25, $00 ; entry 14
    db $CF, $03, $00, $20 ; entry 15
    db $D0, $FB, $24, $00 ; entry 16
    db $E8, $05, $09, $20 ; entry 17
    db $F0, $0B, $1E, $00 ; entry 18
    db $F8, $10, $0D, $00 ; entry 19
    db $F8, $F8, $20, $40 ; entry 20
    db $80 ; end

; E-0147 (derived: frame 13 of MetaSprites3E_4024Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set01Frame13::
Data_03E_444B:: ; heuristic: meta-sprite frame; C0
    db $E4, $03, $06, $20 ; entry 0
    db $E4, $F3, $08, $20 ; entry 1
    db $DC, $05, $02, $20 ; entry 2
    db $DC, $F5, $04, $20 ; entry 3
    db $D4, $FC, $04, $20 ; entry 4
    db $D4, $FF, $02, $00 ; entry 5
    db $DC, $FD, $07, $20 ; entry 6
    db $E4, $FB, $0B, $20 ; entry 7
    db $E4, $09, $09, $20 ; entry 8
    db $EC, $F8, $0F, $40 ; entry 9
    db $EC, $F0, $12, $20 ; entry 10
    db $EC, $08, $17, $00 ; entry 11
    db $EC, $00, $18, $20 ; entry 12
    db $F4, $F4, $1F, $40 ; entry 13
    db $F4, $FC, $20, $40 ; entry 14
    db $F4, $04, $1F, $60 ; entry 15
    db $FC, $F8, $23, $00 ; entry 16
    db $FC, $00, $23, $20 ; entry 17
    db $80 ; end

; E-0147 (derived: frame 14 of MetaSprites3E_4024Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set01Frame14::
Data_03E_4494:: ; heuristic: meta-sprite frame; C0
    db $D0, $FC, $1B, $20 ; entry 0
    db $D8, $04, $1C, $20 ; entry 1
    db $D8, $FC, $1D, $20 ; entry 2
    db $D8, $F4, $1E, $20 ; entry 3
    db $E0, $04, $1F, $20 ; entry 4
    db $E0, $FC, $20, $20 ; entry 5
    db $E0, $F4, $21, $20 ; entry 6
    db $E8, $FC, $25, $00 ; entry 7
    db $F0, $FC, $22, $00 ; entry 8
    db $E8, $03, $21, $00 ; entry 9
    db $E8, $F5, $1F, $00 ; entry 10
    db $80 ; end

; E-0147 (derived: frame 15 of MetaSprites3E_4024Set01; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set01Frame15::
    db $80 ; end

; E-0147 (derived: meta-sprite set 2 of MetaSprites3E_4024Table: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3E_4024Set02::
Data_03E_44C2:: ; heuristic: meta-sprite set; C0
    dw MetaSprites3E_4024Set02Frame0 ; entry 0
    dw MetaSprites3E_4024Set02Frame1 ; entry 1
    dw MetaSprites3E_4024Set02Frame2 ; entry 2
    dw MetaSprites3E_4024Set02Frame3 ; entry 3
    dw MetaSprites3E_4024Set02Frame4 ; entry 4
    dw MetaSprites3E_4024Set02Frame5 ; entry 5
    dw MetaSprites3E_4024Set02Frame6 ; entry 6
    dw MetaSprites3E_4024Set02Frame7 ; entry 7
    dw MetaSprites3E_4024Set02Frame8 ; entry 8
    dw MetaSprites3E_4024Set02Frame9 ; entry 9
    dw MetaSprites3E_4024Set02Frame10 ; entry 10
    dw MetaSprites3E_4024Set02Frame11 ; entry 11
    dw MetaSprites3E_4024Set02Frame12 ; entry 12
    dw MetaSprites3E_4024Set02Frame13 ; entry 13
    dw MetaSprites3E_4024Set02Frame14 ; entry 14
    dw MetaSprites3E_4024Set02Frame15 ; entry 15
    dw MetaSprites3E_4024Set02Frame16 ; entry 16
    dw MetaSprites3E_4024Set02Frame16 ; entry 17
    dw MetaSprites3E_4024Set02Frame16 ; entry 18
    dw MetaSprites3E_4024Set02Frame16 ; entry 19
    dw MetaSprites3E_4024Set02Frame16 ; entry 20
    dw MetaSprites3E_4024Set02Frame16 ; entry 21
    dw MetaSprites3E_4024Set02Frame16 ; entry 22
    dw MetaSprites3E_4024Set02Frame16 ; entry 23
    dw MetaSprites3E_4024Set02Frame16 ; entry 24
    dw MetaSprites3E_4024Set02Frame16 ; entry 25
    dw MetaSprites3E_4024Set02Frame16 ; entry 26
    dw MetaSprites3E_4024Set02Frame16 ; entry 27
    dw MetaSprites3E_4024Set02Frame16 ; entry 28
    dw MetaSprites3E_4024Set02Frame16 ; entry 29
    dw MetaSprites3E_4024Set02Frame16 ; entry 30
    dw MetaSprites3E_4024Set02Frame16 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3E_4024Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set02Frame0::
Data_03E_4502:: ; heuristic: meta-sprite frame; C0
    db $F0, $F0, $00, $00 ; entry 0
    db $F0, $F8, $01, $00 ; entry 1
    db $F0, $00, $02, $00 ; entry 2
    db $F0, $08, $03, $00 ; entry 3
    db $F8, $F0, $15, $00 ; entry 4
    db $F8, $F8, $16, $00 ; entry 5
    db $F8, $08, $15, $20 ; entry 6
    db $F8, $00, $16, $20 ; entry 7
    db $F8, $10, $19, $00 ; entry 8
    db $F8, $E8, $19, $20 ; entry 9
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3E_4024Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set02Frame1::
Data_03E_452B:: ; heuristic: meta-sprite frame; C0
    db $E8, $08, $00, $20 ; entry 0
    db $E8, $00, $01, $20 ; entry 1
    db $E8, $F8, $02, $20 ; entry 2
    db $E8, $F0, $03, $20 ; entry 3
    db $F0, $08, $10, $20 ; entry 4
    db $F0, $00, $11, $20 ; entry 5
    db $F0, $F8, $12, $20 ; entry 6
    db $F0, $F0, $13, $20 ; entry 7
    db $F8, $F8, $17, $20 ; entry 8
    db $F8, $F0, $18, $20 ; entry 9
    db $F8, $00, $17, $00 ; entry 10
    db $F8, $08, $18, $00 ; entry 11
    db $F8, $10, $1A, $00 ; entry 12
    db $F8, $E8, $1A, $20 ; entry 13
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3E_4024Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set02Frame2::
Data_03E_4564:: ; heuristic: meta-sprite frame; C0
    db $E0, $F0, $00, $00 ; entry 0
    db $E0, $F8, $01, $00 ; entry 1
    db $E0, $00, $02, $00 ; entry 2
    db $E0, $08, $03, $00 ; entry 3
    db $E8, $F0, $10, $00 ; entry 4
    db $E8, $F8, $11, $00 ; entry 5
    db $E8, $00, $12, $00 ; entry 6
    db $E8, $08, $13, $00 ; entry 7
    db $F0, $F0, $04, $00 ; entry 8
    db $F0, $F8, $05, $00 ; entry 9
    db $F0, $00, $06, $00 ; entry 10
    db $F0, $08, $07, $00 ; entry 11
    db $F8, $F0, $15, $00 ; entry 12
    db $F8, $F8, $16, $00 ; entry 13
    db $F8, $08, $15, $20 ; entry 14
    db $F8, $00, $16, $20 ; entry 15
    db $F8, $10, $19, $00 ; entry 16
    db $F8, $E8, $19, $20 ; entry 17
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3E_4024Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set02Frame3::
Data_03E_45AD:: ; heuristic: meta-sprite frame; C0
    db $D0, $F0, $00, $00 ; entry 0
    db $D0, $F8, $01, $00 ; entry 1
    db $D0, $00, $02, $00 ; entry 2
    db $D0, $08, $03, $00 ; entry 3
    db $D8, $F0, $10, $00 ; entry 4
    db $D8, $F8, $11, $00 ; entry 5
    db $D8, $00, $12, $00 ; entry 6
    db $D8, $08, $13, $00 ; entry 7
    db $E0, $F0, $04, $00 ; entry 8
    db $E0, $F8, $05, $00 ; entry 9
    db $E0, $00, $06, $00 ; entry 10
    db $E0, $08, $07, $00 ; entry 11
    db $E8, $F8, $06, $00 ; entry 12
    db $E8, $00, $09, $00 ; entry 13
    db $E8, $08, $0A, $00 ; entry 14
    db $E8, $F0, $08, $00 ; entry 15
    db $F0, $F8, $09, $00 ; entry 16
    db $F0, $F0, $0B, $00 ; entry 17
    db $F0, $00, $0C, $00 ; entry 18
    db $F0, $08, $0D, $00 ; entry 19
    db $F8, $F8, $17, $20 ; entry 20
    db $F8, $F0, $18, $20 ; entry 21
    db $F8, $00, $17, $00 ; entry 22
    db $F8, $08, $18, $00 ; entry 23
    db $F8, $10, $1A, $00 ; entry 24
    db $F8, $E8, $1A, $20 ; entry 25
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3E_4024Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set02Frame4::
Data_03E_4616:: ; heuristic: meta-sprite frame; C0
    db $D0, $F0, $04, $00 ; entry 0
    db $D0, $F8, $05, $00 ; entry 1
    db $D0, $00, $06, $00 ; entry 2
    db $D0, $08, $07, $00 ; entry 3
    db $D8, $F8, $06, $00 ; entry 4
    db $D8, $00, $09, $00 ; entry 5
    db $D8, $08, $0A, $00 ; entry 6
    db $D8, $F0, $08, $00 ; entry 7
    db $E0, $F8, $09, $00 ; entry 8
    db $E0, $F0, $0B, $00 ; entry 9
    db $E0, $00, $0C, $00 ; entry 10
    db $E0, $08, $0D, $00 ; entry 11
    db $E8, $F0, $0E, $00 ; entry 12
    db $E8, $F8, $0C, $00 ; entry 13
    db $E8, $00, $0F, $00 ; entry 14
    db $E8, $08, $14, $00 ; entry 15
    db $F0, $F0, $04, $00 ; entry 16
    db $F0, $F8, $05, $00 ; entry 17
    db $F0, $00, $06, $00 ; entry 18
    db $F0, $08, $07, $00 ; entry 19
    db $F8, $F0, $15, $00 ; entry 20
    db $F8, $F8, $16, $00 ; entry 21
    db $F8, $08, $15, $20 ; entry 22
    db $F8, $00, $16, $20 ; entry 23
    db $F8, $10, $19, $00 ; entry 24
    db $F8, $E8, $19, $20 ; entry 25
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3E_4024Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set02Frame5::
Data_03E_467F:: ; heuristic: meta-sprite frame; C0
    db $D0, $F8, $06, $00 ; entry 0
    db $D0, $00, $09, $00 ; entry 1
    db $D0, $08, $0A, $00 ; entry 2
    db $D0, $F0, $08, $00 ; entry 3
    db $D8, $F8, $09, $00 ; entry 4
    db $D8, $F0, $0B, $00 ; entry 5
    db $D8, $00, $0C, $00 ; entry 6
    db $D8, $08, $0D, $00 ; entry 7
    db $E0, $F0, $0E, $00 ; entry 8
    db $E0, $F8, $0C, $00 ; entry 9
    db $E0, $00, $0F, $00 ; entry 10
    db $E0, $08, $14, $00 ; entry 11
    db $E8, $F0, $04, $00 ; entry 12
    db $E8, $F8, $05, $00 ; entry 13
    db $E8, $00, $06, $00 ; entry 14
    db $E8, $08, $07, $00 ; entry 15
    db $F0, $F8, $06, $00 ; entry 16
    db $F0, $00, $09, $00 ; entry 17
    db $F0, $08, $0A, $00 ; entry 18
    db $F0, $F0, $08, $00 ; entry 19
    db $F8, $F8, $17, $20 ; entry 20
    db $F8, $F0, $18, $20 ; entry 21
    db $F8, $00, $17, $00 ; entry 22
    db $F8, $08, $18, $00 ; entry 23
    db $F8, $10, $1A, $00 ; entry 24
    db $F8, $E8, $1A, $20 ; entry 25
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3E_4024Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set02Frame6::
Data_03E_46E8:: ; heuristic: meta-sprite frame; C0
    db $D0, $F8, $09, $00 ; entry 0
    db $D0, $F0, $0B, $00 ; entry 1
    db $D0, $00, $0C, $00 ; entry 2
    db $D0, $08, $0D, $00 ; entry 3
    db $D8, $F0, $0E, $00 ; entry 4
    db $D8, $F8, $0C, $00 ; entry 5
    db $D8, $00, $0F, $00 ; entry 6
    db $D8, $08, $14, $00 ; entry 7
    db $E0, $F0, $04, $00 ; entry 8
    db $E0, $F8, $05, $00 ; entry 9
    db $E0, $00, $06, $00 ; entry 10
    db $E0, $08, $07, $00 ; entry 11
    db $E8, $F8, $06, $00 ; entry 12
    db $E8, $00, $09, $00 ; entry 13
    db $E8, $08, $0A, $00 ; entry 14
    db $E8, $F0, $08, $00 ; entry 15
    db $F0, $F8, $09, $00 ; entry 16
    db $F0, $F0, $0B, $00 ; entry 17
    db $F0, $00, $0C, $00 ; entry 18
    db $F0, $08, $0D, $00 ; entry 19
    db $F8, $F0, $15, $00 ; entry 20
    db $F8, $F8, $16, $00 ; entry 21
    db $F8, $08, $15, $20 ; entry 22
    db $F8, $00, $16, $20 ; entry 23
    db $F8, $10, $19, $00 ; entry 24
    db $F8, $E8, $19, $20 ; entry 25
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3E_4024Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set02Frame7::
Data_03E_4751:: ; heuristic: meta-sprite frame; C0
    db $D0, $F0, $0E, $00 ; entry 0
    db $D0, $F8, $0C, $00 ; entry 1
    db $D0, $00, $0F, $00 ; entry 2
    db $D0, $08, $14, $00 ; entry 3
    db $D8, $F0, $04, $00 ; entry 4
    db $D8, $F8, $05, $00 ; entry 5
    db $D8, $00, $06, $00 ; entry 6
    db $D8, $08, $07, $00 ; entry 7
    db $E0, $F8, $06, $00 ; entry 8
    db $E0, $00, $09, $00 ; entry 9
    db $E0, $08, $0A, $00 ; entry 10
    db $E0, $F0, $08, $00 ; entry 11
    db $E8, $F8, $09, $00 ; entry 12
    db $E8, $F0, $0B, $00 ; entry 13
    db $E8, $00, $0C, $00 ; entry 14
    db $E8, $08, $0D, $00 ; entry 15
    db $F0, $F0, $0E, $00 ; entry 16
    db $F0, $F8, $0C, $00 ; entry 17
    db $F0, $00, $0F, $00 ; entry 18
    db $F0, $08, $14, $00 ; entry 19
    db $F8, $F8, $17, $20 ; entry 20
    db $F8, $F0, $18, $20 ; entry 21
    db $F8, $00, $17, $00 ; entry 22
    db $F8, $08, $18, $00 ; entry 23
    db $F8, $10, $1A, $00 ; entry 24
    db $F8, $E8, $1A, $20 ; entry 25
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites3E_4024Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set02Frame8::
Data_03E_47BA:: ; heuristic: meta-sprite frame; C0
    db $F8, $F8, $1B, $00 ; entry 0
    db $F8, $00, $1B, $20 ; entry 1
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites3E_4024Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set02Frame9::
Data_03E_47C3:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $1C, $00 ; entry 0
    db $F0, $00, $1D, $00 ; entry 1
    db $F8, $F8, $1E, $00 ; entry 2
    db $F8, $00, $1F, $00 ; entry 3
    db $F8, $07, $27, $00 ; entry 4
    db $F8, $F1, $26, $00 ; entry 5
    db $80 ; end

; E-0147 (derived: frame 10 of MetaSprites3E_4024Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set02Frame10::
Data_03E_47DC:: ; heuristic: meta-sprite frame; C0
    db $E8, $00, $1C, $20 ; entry 0
    db $E8, $F8, $1D, $20 ; entry 1
    db $F0, $00, $1E, $20 ; entry 2
    db $F0, $F8, $1F, $20 ; entry 3
    db $F7, $FC, $25, $00 ; entry 4
    db $F0, $07, $26, $20 ; entry 5
    db $F6, $03, $27, $00 ; entry 6
    db $F4, $F4, $26, $00 ; entry 7
    db $F0, $F1, $27, $20 ; entry 8
    db $80 ; end

; E-0147 (derived: frame 11 of MetaSprites3E_4024Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set02Frame11::
Data_03E_4801:: ; heuristic: meta-sprite frame; C0
    db $E4, $F8, $1C, $00 ; entry 0
    db $E4, $00, $1D, $00 ; entry 1
    db $EC, $F8, $1E, $00 ; entry 2
    db $EC, $00, $1F, $00 ; entry 3
    db $F3, $FC, $25, $20 ; entry 4
    db $EC, $F1, $26, $00 ; entry 5
    db $F2, $F5, $27, $20 ; entry 6
    db $F0, $04, $26, $20 ; entry 7
    db $EC, $07, $27, $00 ; entry 8
    db $80 ; end

; E-0147 (derived: frame 12 of MetaSprites3E_4024Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set02Frame12::
Data_03E_4826:: ; heuristic: meta-sprite frame; C0
    db $E4, $F8, $20, $00 ; entry 0
    db $E4, $00, $21, $00 ; entry 1
    db $EC, $F8, $22, $00 ; entry 2
    db $EC, $00, $23, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 13 of MetaSprites3E_4024Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set02Frame13::
Data_03E_4837:: ; heuristic: meta-sprite frame; C0
    db $E6, $00, $20, $20 ; entry 0
    db $E6, $F8, $21, $20 ; entry 1
    db $EE, $00, $22, $20 ; entry 2
    db $EE, $F8, $23, $20 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 14 of MetaSprites3E_4024Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set02Frame14::
Data_03E_4848:: ; heuristic: meta-sprite frame; C0
    db $E8, $F8, $20, $00 ; entry 0
    db $E8, $00, $21, $00 ; entry 1
    db $F0, $F8, $22, $00 ; entry 2
    db $F0, $00, $23, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 15 of MetaSprites3E_4024Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set02Frame15::
Data_03E_4859:: ; heuristic: meta-sprite frame; C0
    db $EC, $FC, $24, $00 ; entry 0
    db $80 ; end

; E-0147 (derived: frame 16 of MetaSprites3E_4024Set02; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set02Frame16::
    db $80 ; end

; E-0147 (derived: meta-sprite set 3 of MetaSprites3E_4024Table: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3E_4024Set03::
Data_03E_485F:: ; heuristic: meta-sprite set; C0
    dw MetaSprites3E_4024Set03Frame0 ; entry 0
    dw MetaSprites3E_4024Set03Frame1 ; entry 1
    dw MetaSprites3E_4024Set03Frame2 ; entry 2
    dw MetaSprites3E_4024Set03Frame3 ; entry 3
    dw MetaSprites3E_4024Set03Frame4 ; entry 4
    dw MetaSprites3E_4024Set03Frame5 ; entry 5
    dw MetaSprites3E_4024Set03Frame6 ; entry 6
    dw MetaSprites3E_4024Set03Frame7 ; entry 7
    dw MetaSprites3E_4024Set03Frame8 ; entry 8
    dw MetaSprites3E_4024Set03Frame9 ; entry 9
    dw MetaSprites3E_4024Set03Frame10 ; entry 10
    dw MetaSprites3E_4024Set03Frame11 ; entry 11
    dw MetaSprites3E_4024Set03Frame12 ; entry 12
    dw MetaSprites3E_4024Set03Frame13 ; entry 13
    dw MetaSprites3E_4024Set03Frame14 ; entry 14
    dw MetaSprites3E_4024Set03Frame14 ; entry 15
    dw MetaSprites3E_4024Set03Frame14 ; entry 16
    dw MetaSprites3E_4024Set03Frame14 ; entry 17
    dw MetaSprites3E_4024Set03Frame14 ; entry 18
    dw MetaSprites3E_4024Set03Frame14 ; entry 19
    dw MetaSprites3E_4024Set03Frame14 ; entry 20
    dw MetaSprites3E_4024Set03Frame14 ; entry 21
    dw MetaSprites3E_4024Set03Frame14 ; entry 22
    dw MetaSprites3E_4024Set03Frame14 ; entry 23
    dw MetaSprites3E_4024Set03Frame14 ; entry 24
    dw MetaSprites3E_4024Set03Frame14 ; entry 25
    dw MetaSprites3E_4024Set03Frame14 ; entry 26
    dw MetaSprites3E_4024Set03Frame14 ; entry 27
    dw MetaSprites3E_4024Set03Frame14 ; entry 28
    dw MetaSprites3E_4024Set03Frame14 ; entry 29
    dw MetaSprites3E_4024Set03Frame14 ; entry 30
    dw MetaSprites3E_4024Set03Frame14 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3E_4024Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set03Frame0::
Data_03E_489F:: ; heuristic: meta-sprite frame; C0
    db $F0, $B0, $05, $10 ; entry 0
    db $F8, $B0, $0E, $10 ; entry 1
    db $F8, $B8, $0F, $10 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3E_4024Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set03Frame1::
Data_03E_48AC:: ; heuristic: meta-sprite frame; C0
    db $F8, $B0, $1B, $10 ; entry 0
    db $F8, $B8, $1C, $10 ; entry 1
    db $F8, $C0, $1D, $10 ; entry 2
    db $F8, $C8, $1E, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3E_4024Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set03Frame2::
Data_03E_48BD:: ; heuristic: meta-sprite frame; C0
    db $F0, $B0, $03, $10 ; entry 0
    db $F0, $D8, $03, $10 ; entry 1
    db $F0, $C8, $21, $10 ; entry 2
    db $F8, $B0, $26, $10 ; entry 3
    db $F8, $B8, $27, $10 ; entry 4
    db $F8, $C0, $28, $10 ; entry 5
    db $F8, $C8, $29, $10 ; entry 6
    db $F8, $D0, $2A, $10 ; entry 7
    db $F8, $D8, $2B, $10 ; entry 8
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3E_4024Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set03Frame3::
Data_03E_48E2:: ; heuristic: meta-sprite frame; C0
    db $F0, $B7, $02, $10 ; entry 0
    db $F0, $C8, $03, $10 ; entry 1
    db $F0, $D0, $04, $10 ; entry 2
    db $F0, $E0, $05, $10 ; entry 3
    db $F8, $B0, $08, $10 ; entry 4
    db $F8, $B8, $09, $10 ; entry 5
    db $F8, $C0, $0A, $10 ; entry 6
    db $F8, $C8, $0B, $10 ; entry 7
    db $F8, $D0, $0C, $10 ; entry 8
    db $F8, $D8, $0D, $10 ; entry 9
    db $F8, $E0, $0E, $10 ; entry 10
    db $F8, $E8, $0F, $10 ; entry 11
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3E_4024Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set03Frame4::
Data_03E_4913:: ; heuristic: meta-sprite frame; C0
    db $F0, $C0, $00, $10 ; entry 0
    db $F0, $B0, $10, $10 ; entry 1
    db $F0, $B8, $11, $10 ; entry 2
    db $F0, $C8, $12, $10 ; entry 3
    db $F0, $D0, $13, $10 ; entry 4
    db $F0, $D8, $14, $10 ; entry 5
    db $F8, $B0, $15, $10 ; entry 6
    db $F8, $B8, $16, $10 ; entry 7
    db $F8, $C0, $17, $10 ; entry 8
    db $F8, $C8, $18, $10 ; entry 9
    db $F8, $D0, $19, $10 ; entry 10
    db $F8, $D8, $1A, $10 ; entry 11
    db $F8, $E0, $1B, $10 ; entry 12
    db $F8, $E8, $1C, $10 ; entry 13
    db $F8, $F0, $1D, $10 ; entry 14
    db $F8, $F8, $1E, $10 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3E_4024Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set03Frame5::
Data_03E_4954:: ; heuristic: meta-sprite frame; C0
    db $F0, $E0, $03, $10 ; entry 0
    db $F0, $08, $03, $10 ; entry 1
    db $F0, $C8, $1F, $10 ; entry 2
    db $F0, $D0, $20, $10 ; entry 3
    db $F0, $F8, $21, $10 ; entry 4
    db $F8, $C0, $22, $10 ; entry 5
    db $F8, $C8, $23, $10 ; entry 6
    db $F8, $D0, $24, $10 ; entry 7
    db $F8, $D8, $25, $10 ; entry 8
    db $F8, $E0, $26, $10 ; entry 9
    db $F8, $E8, $27, $10 ; entry 10
    db $F8, $F0, $28, $10 ; entry 11
    db $F8, $F8, $29, $10 ; entry 12
    db $F8, $00, $2A, $10 ; entry 13
    db $F8, $08, $2B, $10 ; entry 14
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3E_4024Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set03Frame6::
Data_03E_4991:: ; heuristic: meta-sprite frame; C0
    db $F0, $D0, $00, $10 ; entry 0
    db $F0, $D8, $01, $10 ; entry 1
    db $F0, $E7, $02, $10 ; entry 2
    db $F0, $F8, $03, $10 ; entry 3
    db $F0, $00, $04, $10 ; entry 4
    db $F0, $10, $05, $10 ; entry 5
    db $F8, $D0, $06, $10 ; entry 6
    db $F8, $D8, $07, $10 ; entry 7
    db $F8, $E0, $08, $10 ; entry 8
    db $F8, $E8, $09, $10 ; entry 9
    db $F8, $F0, $0A, $10 ; entry 10
    db $F8, $F8, $0B, $10 ; entry 11
    db $F8, $00, $0C, $10 ; entry 12
    db $F8, $08, $0D, $10 ; entry 13
    db $F8, $10, $0E, $10 ; entry 14
    db $F8, $18, $0F, $10 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3E_4024Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set03Frame7::
Data_03E_49D2:: ; heuristic: meta-sprite frame; C0
    db $F0, $F0, $00, $10 ; entry 0
    db $F0, $E0, $10, $10 ; entry 1
    db $F0, $E8, $11, $10 ; entry 2
    db $F0, $F8, $12, $10 ; entry 3
    db $F0, $00, $13, $10 ; entry 4
    db $F0, $08, $14, $10 ; entry 5
    db $F8, $E0, $15, $10 ; entry 6
    db $F8, $E8, $16, $10 ; entry 7
    db $F8, $F0, $17, $10 ; entry 8
    db $F8, $F8, $18, $10 ; entry 9
    db $F8, $00, $19, $10 ; entry 10
    db $F8, $08, $1A, $10 ; entry 11
    db $F8, $10, $1B, $10 ; entry 12
    db $F8, $18, $1C, $10 ; entry 13
    db $F8, $20, $1D, $10 ; entry 14
    db $F8, $28, $1E, $10 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites3E_4024Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set03Frame8::
Data_03E_4A13:: ; heuristic: meta-sprite frame; C0
    db $F0, $10, $03, $10 ; entry 0
    db $F0, $38, $03, $10 ; entry 1
    db $F0, $F8, $1F, $10 ; entry 2
    db $F0, $00, $20, $10 ; entry 3
    db $F0, $28, $21, $10 ; entry 4
    db $F8, $F0, $22, $10 ; entry 5
    db $F8, $F8, $23, $10 ; entry 6
    db $F8, $00, $24, $10 ; entry 7
    db $F8, $08, $25, $10 ; entry 8
    db $F8, $10, $26, $10 ; entry 9
    db $F8, $18, $27, $10 ; entry 10
    db $F8, $20, $28, $10 ; entry 11
    db $F8, $28, $29, $10 ; entry 12
    db $F8, $30, $2A, $10 ; entry 13
    db $F8, $38, $2B, $10 ; entry 14
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites3E_4024Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set03Frame9::
Data_03E_4A50:: ; heuristic: meta-sprite frame; C0
    db $F0, $00, $00, $10 ; entry 0
    db $F0, $08, $01, $10 ; entry 1
    db $F0, $17, $02, $10 ; entry 2
    db $F0, $28, $03, $10 ; entry 3
    db $F0, $30, $04, $10 ; entry 4
    db $F0, $40, $05, $10 ; entry 5
    db $F8, $00, $06, $10 ; entry 6
    db $F8, $08, $07, $10 ; entry 7
    db $F8, $10, $08, $10 ; entry 8
    db $F8, $18, $09, $10 ; entry 9
    db $F8, $20, $0A, $10 ; entry 10
    db $F8, $28, $0B, $10 ; entry 11
    db $F8, $30, $0C, $10 ; entry 12
    db $F8, $38, $0D, $10 ; entry 13
    db $F8, $40, $0E, $10 ; entry 14
    db $F8, $48, $0F, $10 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 10 of MetaSprites3E_4024Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set03Frame10::
Data_03E_4A91:: ; heuristic: meta-sprite frame; C0
    db $F0, $20, $00, $10 ; entry 0
    db $F0, $10, $10, $10 ; entry 1
    db $F0, $18, $11, $10 ; entry 2
    db $F0, $28, $12, $10 ; entry 3
    db $F0, $30, $13, $10 ; entry 4
    db $F0, $38, $14, $10 ; entry 5
    db $F8, $10, $15, $10 ; entry 6
    db $F8, $18, $16, $10 ; entry 7
    db $F8, $20, $17, $10 ; entry 8
    db $F8, $28, $18, $10 ; entry 9
    db $F8, $30, $19, $10 ; entry 10
    db $F8, $38, $1A, $10 ; entry 11
    db $F8, $40, $1B, $10 ; entry 12
    db $F8, $48, $1C, $10 ; entry 13
    db $80 ; end

; E-0147 (derived: frame 11 of MetaSprites3E_4024Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set03Frame11::
Data_03E_4ACA:: ; heuristic: meta-sprite frame; C0
    db $F0, $40, $03, $10 ; entry 0
    db $F0, $28, $1F, $10 ; entry 1
    db $F0, $30, $20, $10 ; entry 2
    db $F8, $20, $22, $10 ; entry 3
    db $F8, $28, $23, $10 ; entry 4
    db $F8, $30, $24, $10 ; entry 5
    db $F8, $38, $25, $10 ; entry 6
    db $F8, $40, $26, $10 ; entry 7
    db $F8, $48, $27, $10 ; entry 8
    db $80 ; end

; E-0147 (derived: frame 12 of MetaSprites3E_4024Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set03Frame12::
Data_03E_4AEF:: ; heuristic: meta-sprite frame; C0
    db $F0, $30, $00, $10 ; entry 0
    db $F0, $38, $01, $10 ; entry 1
    db $F0, $47, $02, $10 ; entry 2
    db $F8, $30, $06, $10 ; entry 3
    db $F8, $38, $07, $10 ; entry 4
    db $F8, $40, $08, $10 ; entry 5
    db $F8, $48, $09, $10 ; entry 6
    db $80 ; end

; E-0147 (derived: frame 13 of MetaSprites3E_4024Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set03Frame13::
Data_03E_4B0C:: ; heuristic: meta-sprite frame; C0
    db $F0, $40, $10, $10 ; entry 0
    db $F0, $48, $11, $10 ; entry 1
    db $F8, $40, $15, $10 ; entry 2
    db $F8, $48, $16, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 14 of MetaSprites3E_4024Set03; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set03Frame14::
    db $80 ; end

; E-0147 (derived: meta-sprite set 4 of MetaSprites3E_4024Table: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3E_4024Set04::
Data_03E_4B1E:: ; heuristic: meta-sprite set; C0
    dw MetaSprites3E_4024Set04Frame0 ; entry 0
    dw MetaSprites3E_4024Set04Frame1 ; entry 1
    dw MetaSprites3E_4024Set04Frame2 ; entry 2
    dw MetaSprites3E_4024Set04Frame3 ; entry 3
    dw MetaSprites3E_4024Set04Frame4 ; entry 4
    dw MetaSprites3E_4024Set04Frame5 ; entry 5
    dw MetaSprites3E_4024Set04Frame6 ; entry 6
    dw MetaSprites3E_4024Set04Frame7 ; entry 7
    dw MetaSprites3E_4024Set04Frame8 ; entry 8
    dw MetaSprites3E_4024Set04Frame9 ; entry 9
    dw MetaSprites3E_4024Set04Frame10 ; entry 10
    dw MetaSprites3E_4024Set04Frame11 ; entry 11
    dw MetaSprites3E_4024Set04Frame12 ; entry 12
    dw MetaSprites3E_4024Set04Frame13 ; entry 13
    dw MetaSprites3E_4024Set04Frame14 ; entry 14
    dw MetaSprites3E_4024Set04Frame14 ; entry 15
    dw MetaSprites3E_4024Set04Frame14 ; entry 16
    dw MetaSprites3E_4024Set04Frame14 ; entry 17
    dw MetaSprites3E_4024Set04Frame14 ; entry 18
    dw MetaSprites3E_4024Set04Frame14 ; entry 19
    dw MetaSprites3E_4024Set04Frame14 ; entry 20
    dw MetaSprites3E_4024Set04Frame14 ; entry 21
    dw MetaSprites3E_4024Set04Frame14 ; entry 22
    dw MetaSprites3E_4024Set04Frame14 ; entry 23
    dw MetaSprites3E_4024Set04Frame14 ; entry 24
    dw MetaSprites3E_4024Set04Frame14 ; entry 25
    dw MetaSprites3E_4024Set04Frame14 ; entry 26
    dw MetaSprites3E_4024Set04Frame14 ; entry 27
    dw MetaSprites3E_4024Set04Frame14 ; entry 28
    dw MetaSprites3E_4024Set04Frame14 ; entry 29
    dw MetaSprites3E_4024Set04Frame14 ; entry 30
    dw MetaSprites3E_4024Set04Frame14 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3E_4024Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set04Frame0::
Data_03E_4B5E:: ; heuristic: meta-sprite frame; C0
    db $F0, $B1, $0C, $10 ; entry 0
    db $F8, $B1, $13, $10 ; entry 1
    db $F8, $B9, $14, $10 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3E_4024Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set04Frame1::
Data_03E_4B6B:: ; heuristic: meta-sprite frame; C0
    db $E0, $C0, $04, $10 ; entry 0
    db $F8, $B8, $10, $10 ; entry 1
    db $F8, $C0, $11, $10 ; entry 2
    db $F0, $B0, $19, $10 ; entry 3
    db $F0, $B8, $1A, $10 ; entry 4
    db $F0, $C0, $1B, $10 ; entry 5
    db $F8, $B0, $22, $10 ; entry 6
    db $F8, $C8, $23, $10 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3E_4024Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set04Frame2::
Data_03E_4B8C:: ; heuristic: meta-sprite frame; C0
    db $E8, $D8, $00, $10 ; entry 0
    db $F0, $B8, $05, $10 ; entry 1
    db $F0, $D0, $09, $10 ; entry 2
    db $F0, $C0, $19, $30 ; entry 3
    db $E0, $D0, $24, $10 ; entry 4
    db $E8, $C8, $25, $10 ; entry 5
    db $E8, $D0, $26, $10 ; entry 6
    db $F8, $C0, $20, $10 ; entry 7
    db $F8, $B0, $23, $30 ; entry 8
    db $F0, $C8, $28, $10 ; entry 9
    db $F0, $D8, $29, $10 ; entry 10
    db $F8, $C8, $2D, $10 ; entry 11
    db $F8, $B8, $1F, $10 ; entry 12
    db $F8, $D0, $0F, $10 ; entry 13
    db $F8, $D8, $2E, $10 ; entry 14
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3E_4024Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set04Frame3::
Data_03E_4BC9:: ; heuristic: meta-sprite frame; C0
    db $E0, $B8, $00, $10 ; entry 0
    db $E8, $B8, $01, $10 ; entry 1
    db $E8, $C0, $02, $10 ; entry 2
    db $E8, $C8, $03, $10 ; entry 3
    db $E8, $D0, $04, $10 ; entry 4
    db $F0, $B0, $06, $10 ; entry 5
    db $F0, $B8, $07, $10 ; entry 6
    db $F0, $C0, $08, $10 ; entry 7
    db $F0, $C8, $09, $10 ; entry 8
    db $F0, $D0, $0A, $10 ; entry 9
    db $F0, $D8, $0B, $10 ; entry 10
    db $F0, $E0, $0C, $10 ; entry 11
    db $F8, $B0, $0D, $10 ; entry 12
    db $F8, $C8, $10, $10 ; entry 13
    db $F8, $D0, $11, $10 ; entry 14
    db $F8, $D8, $12, $10 ; entry 15
    db $F8, $E0, $13, $10 ; entry 16
    db $F8, $E8, $14, $10 ; entry 17
    db $E8, $B0, $27, $30 ; entry 18
    db $F8, $B8, $0E, $10 ; entry 19
    db $F8, $C0, $0F, $10 ; entry 20
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3E_4024Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set04Frame4::
Data_03E_4C1E:: ; heuristic: meta-sprite frame; C0
    db $E0, $F0, $04, $10 ; entry 0
    db $F0, $B8, $06, $10 ; entry 1
    db $F8, $E8, $10, $10 ; entry 2
    db $F8, $F0, $11, $10 ; entry 3
    db $F0, $B0, $15, $10 ; entry 4
    db $F0, $C0, $16, $10 ; entry 5
    db $F0, $C8, $17, $10 ; entry 6
    db $F0, $D0, $18, $10 ; entry 7
    db $F0, $E0, $19, $10 ; entry 8
    db $F0, $E8, $1A, $10 ; entry 9
    db $F0, $F0, $1B, $10 ; entry 10
    db $F8, $B0, $1C, $10 ; entry 11
    db $F8, $B8, $1D, $10 ; entry 12
    db $F8, $D0, $20, $10 ; entry 13
    db $F8, $D8, $21, $10 ; entry 14
    db $F8, $E0, $22, $10 ; entry 15
    db $F8, $F8, $23, $10 ; entry 16
    db $F8, $C0, $1E, $10 ; entry 17
    db $F8, $C8, $1F, $10 ; entry 18
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3E_4024Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set04Frame5::
Data_03E_4C6B:: ; heuristic: meta-sprite frame; C0
    db $E8, $08, $00, $10 ; entry 0
    db $F0, $E8, $05, $10 ; entry 1
    db $F0, $C8, $0B, $10 ; entry 2
    db $F0, $D0, $0C, $10 ; entry 3
    db $F0, $00, $09, $10 ; entry 4
    db $F8, $C8, $12, $10 ; entry 5
    db $F0, $F0, $19, $30 ; entry 6
    db $E0, $00, $24, $10 ; entry 7
    db $E8, $F8, $25, $10 ; entry 8
    db $E8, $00, $26, $10 ; entry 9
    db $F8, $F0, $20, $10 ; entry 10
    db $F8, $E0, $23, $30 ; entry 11
    db $F0, $D8, $27, $10 ; entry 12
    db $F0, $F8, $28, $10 ; entry 13
    db $F0, $08, $29, $10 ; entry 14
    db $F8, $C0, $2A, $10 ; entry 15
    db $F8, $D0, $2B, $10 ; entry 16
    db $F8, $D8, $2C, $10 ; entry 17
    db $F8, $F8, $2D, $10 ; entry 18
    db $F8, $E8, $1F, $10 ; entry 19
    db $F8, $00, $0F, $10 ; entry 20
    db $F8, $08, $2E, $10 ; entry 21
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3E_4024Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set04Frame6::
Data_03E_4CC4:: ; heuristic: meta-sprite frame; C0
    db $E0, $E8, $00, $10 ; entry 0
    db $E8, $E8, $01, $10 ; entry 1
    db $E8, $F0, $02, $10 ; entry 2
    db $E8, $F8, $03, $10 ; entry 3
    db $E8, $00, $04, $10 ; entry 4
    db $F0, $D8, $05, $10 ; entry 5
    db $F0, $E0, $06, $10 ; entry 6
    db $F0, $E8, $07, $10 ; entry 7
    db $F0, $F0, $08, $10 ; entry 8
    db $F0, $F8, $09, $10 ; entry 9
    db $F0, $00, $0A, $10 ; entry 10
    db $F0, $08, $0B, $10 ; entry 11
    db $F0, $10, $0C, $10 ; entry 12
    db $F8, $E0, $0D, $10 ; entry 13
    db $F8, $F8, $10, $10 ; entry 14
    db $F8, $00, $11, $10 ; entry 15
    db $F8, $08, $12, $10 ; entry 16
    db $F8, $10, $13, $10 ; entry 17
    db $F8, $18, $14, $10 ; entry 18
    db $F8, $D0, $23, $30 ; entry 19
    db $E8, $E0, $27, $30 ; entry 20
    db $F8, $E8, $0E, $10 ; entry 21
    db $F8, $F0, $0F, $10 ; entry 22
    db $F8, $D8, $1F, $10 ; entry 23
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3E_4024Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set04Frame7::
Data_03E_4D25:: ; heuristic: meta-sprite frame; C0
    db $E0, $20, $04, $10 ; entry 0
    db $F0, $E8, $06, $10 ; entry 1
    db $F8, $18, $10, $10 ; entry 2
    db $F8, $20, $11, $10 ; entry 3
    db $F0, $E0, $15, $10 ; entry 4
    db $F0, $F0, $16, $10 ; entry 5
    db $F0, $F8, $17, $10 ; entry 6
    db $F0, $00, $18, $10 ; entry 7
    db $F0, $10, $19, $10 ; entry 8
    db $F0, $18, $1A, $10 ; entry 9
    db $F0, $20, $1B, $10 ; entry 10
    db $F8, $E0, $1C, $10 ; entry 11
    db $F8, $E8, $1D, $10 ; entry 12
    db $F8, $00, $20, $10 ; entry 13
    db $F8, $08, $21, $10 ; entry 14
    db $F8, $10, $22, $10 ; entry 15
    db $F8, $28, $23, $10 ; entry 16
    db $F8, $F0, $1E, $10 ; entry 17
    db $F8, $F8, $1F, $10 ; entry 18
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites3E_4024Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set04Frame8::
Data_03E_4D72:: ; heuristic: meta-sprite frame; C0
    db $E8, $38, $00, $10 ; entry 0
    db $F0, $18, $05, $10 ; entry 1
    db $F0, $F8, $0B, $10 ; entry 2
    db $F0, $00, $0C, $10 ; entry 3
    db $F0, $30, $09, $10 ; entry 4
    db $F8, $F8, $12, $10 ; entry 5
    db $F0, $20, $19, $30 ; entry 6
    db $E0, $30, $24, $10 ; entry 7
    db $E8, $28, $25, $10 ; entry 8
    db $E8, $30, $26, $10 ; entry 9
    db $F8, $20, $20, $10 ; entry 10
    db $F8, $10, $23, $30 ; entry 11
    db $F0, $08, $27, $10 ; entry 12
    db $F0, $28, $28, $10 ; entry 13
    db $F0, $38, $29, $10 ; entry 14
    db $F8, $F0, $2A, $10 ; entry 15
    db $F8, $00, $2B, $10 ; entry 16
    db $F8, $08, $2C, $10 ; entry 17
    db $F8, $28, $2D, $10 ; entry 18
    db $F8, $18, $1F, $10 ; entry 19
    db $F8, $30, $0F, $10 ; entry 20
    db $F8, $38, $2E, $10 ; entry 21
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites3E_4024Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set04Frame9::
Data_03E_4DCB:: ; heuristic: meta-sprite frame; C0
    db $E0, $18, $00, $10 ; entry 0
    db $E8, $18, $01, $10 ; entry 1
    db $E8, $20, $02, $10 ; entry 2
    db $E8, $28, $03, $10 ; entry 3
    db $E8, $30, $04, $10 ; entry 4
    db $F0, $08, $05, $10 ; entry 5
    db $F0, $10, $06, $10 ; entry 6
    db $F0, $18, $07, $10 ; entry 7
    db $F0, $20, $08, $10 ; entry 8
    db $F0, $28, $09, $10 ; entry 9
    db $F0, $30, $0A, $10 ; entry 10
    db $F0, $38, $0B, $10 ; entry 11
    db $F0, $40, $0C, $10 ; entry 12
    db $F8, $10, $0D, $10 ; entry 13
    db $F8, $28, $10, $10 ; entry 14
    db $F8, $30, $11, $10 ; entry 15
    db $F8, $38, $12, $10 ; entry 16
    db $F8, $40, $13, $10 ; entry 17
    db $F8, $48, $14, $10 ; entry 18
    db $F8, $00, $23, $30 ; entry 19
    db $E8, $10, $27, $30 ; entry 20
    db $F8, $18, $0E, $10 ; entry 21
    db $F8, $20, $0F, $10 ; entry 22
    db $F8, $08, $1F, $10 ; entry 23
    db $80 ; end

; E-0147 (derived: frame 10 of MetaSprites3E_4024Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set04Frame10::
Data_03E_4E2C:: ; heuristic: meta-sprite frame; C0
    db $F0, $18, $06, $10 ; entry 0
    db $F8, $48, $10, $10 ; entry 1
    db $F0, $10, $15, $10 ; entry 2
    db $F0, $20, $16, $10 ; entry 3
    db $F0, $28, $17, $10 ; entry 4
    db $F0, $30, $18, $10 ; entry 5
    db $F0, $40, $19, $10 ; entry 6
    db $F0, $48, $1A, $10 ; entry 7
    db $F8, $10, $1C, $10 ; entry 8
    db $F8, $18, $1D, $10 ; entry 9
    db $F8, $30, $20, $10 ; entry 10
    db $F8, $38, $21, $10 ; entry 11
    db $F8, $40, $22, $10 ; entry 12
    db $F8, $20, $1E, $10 ; entry 13
    db $F8, $28, $1F, $10 ; entry 14
    db $80 ; end

; E-0147 (derived: frame 11 of MetaSprites3E_4024Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set04Frame11::
Data_03E_4E69:: ; heuristic: meta-sprite frame; C0
    db $F0, $48, $05, $10 ; entry 0
    db $F0, $28, $0B, $10 ; entry 1
    db $F0, $30, $0C, $10 ; entry 2
    db $F8, $28, $12, $10 ; entry 3
    db $F8, $40, $23, $30 ; entry 4
    db $F0, $38, $27, $10 ; entry 5
    db $F8, $20, $2A, $10 ; entry 6
    db $F8, $30, $2B, $10 ; entry 7
    db $F8, $38, $2C, $10 ; entry 8
    db $F8, $48, $1F, $10 ; entry 9
    db $80 ; end

; E-0147 (derived: frame 12 of MetaSprites3E_4024Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set04Frame12::
Data_03E_4E92:: ; heuristic: meta-sprite frame; C0
    db $E0, $48, $00, $10 ; entry 0
    db $E8, $48, $01, $10 ; entry 1
    db $F0, $38, $05, $10 ; entry 2
    db $F0, $40, $06, $10 ; entry 3
    db $F0, $48, $07, $10 ; entry 4
    db $F8, $40, $0D, $10 ; entry 5
    db $F8, $30, $23, $30 ; entry 6
    db $E8, $40, $27, $30 ; entry 7
    db $F8, $48, $0E, $10 ; entry 8
    db $F8, $38, $1F, $10 ; entry 9
    db $80 ; end

; E-0147 (derived: frame 13 of MetaSprites3E_4024Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set04Frame13::
Data_03E_4EBB:: ; heuristic: meta-sprite frame; C0
    db $F0, $48, $06, $10 ; entry 0
    db $F0, $40, $15, $10 ; entry 1
    db $F8, $40, $1C, $10 ; entry 2
    db $F8, $48, $1D, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 14 of MetaSprites3E_4024Set04; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set04Frame14::
    db $80 ; end

; E-0147 (derived: meta-sprite set 5 of MetaSprites3E_4024Table: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3E_4024Set05::
Data_03E_4ECD:: ; heuristic: meta-sprite set; C0
    dw MetaSprites3E_4024Set05Frame0 ; entry 0
    dw MetaSprites3E_4024Set05Frame1 ; entry 1
    dw MetaSprites3E_4024Set05Frame2 ; entry 2
    dw MetaSprites3E_4024Set05Frame3 ; entry 3
    dw MetaSprites3E_4024Set05Frame4 ; entry 4
    dw MetaSprites3E_4024Set05Frame5 ; entry 5
    dw MetaSprites3E_4024Set05Frame6 ; entry 6
    dw MetaSprites3E_4024Set05Frame7 ; entry 7
    dw MetaSprites3E_4024Set05Frame8 ; entry 8
    dw MetaSprites3E_4024Set05Frame9 ; entry 9
    dw MetaSprites3E_4024Set05Frame10 ; entry 10
    dw MetaSprites3E_4024Set05Frame11 ; entry 11
    dw MetaSprites3E_4024Set05Frame11 ; entry 12
    dw MetaSprites3E_4024Set05Frame11 ; entry 13
    dw MetaSprites3E_4024Set05Frame11 ; entry 14
    dw MetaSprites3E_4024Set05Frame11 ; entry 15
    dw MetaSprites3E_4024Set05Frame11 ; entry 16
    dw MetaSprites3E_4024Set05Frame11 ; entry 17
    dw MetaSprites3E_4024Set05Frame11 ; entry 18
    dw MetaSprites3E_4024Set05Frame11 ; entry 19
    dw MetaSprites3E_4024Set05Frame11 ; entry 20
    dw MetaSprites3E_4024Set05Frame11 ; entry 21
    dw MetaSprites3E_4024Set05Frame11 ; entry 22
    dw MetaSprites3E_4024Set05Frame11 ; entry 23
    dw MetaSprites3E_4024Set05Frame11 ; entry 24
    dw MetaSprites3E_4024Set05Frame11 ; entry 25
    dw MetaSprites3E_4024Set05Frame11 ; entry 26
    dw MetaSprites3E_4024Set05Frame11 ; entry 27
    dw MetaSprites3E_4024Set05Frame11 ; entry 28
    dw MetaSprites3E_4024Set05Frame11 ; entry 29
    dw MetaSprites3E_4024Set05Frame11 ; entry 30
    dw MetaSprites3E_4024Set05Frame11 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3E_4024Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set05Frame0::
Data_03E_4F0D:: ; heuristic: meta-sprite frame; C0
    db $F8, $B0, $04, $10 ; entry 0
    db $F8, $48, $04, $30 ; entry 1
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3E_4024Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set05Frame1::
Data_03E_4F16:: ; heuristic: meta-sprite frame; C0
    db $F0, $BE, $00, $10 ; entry 0
    db $F8, $B6, $01, $10 ; entry 1
    db $F8, $BE, $02, $10 ; entry 2
    db $F8, $C6, $03, $10 ; entry 3
    db $F8, $CE, $09, $10 ; entry 4
    db $F0, $3A, $00, $30 ; entry 5
    db $F8, $42, $01, $30 ; entry 6
    db $F8, $3A, $02, $30 ; entry 7
    db $F8, $32, $03, $30 ; entry 8
    db $F8, $2A, $09, $30 ; entry 9
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3E_4024Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set05Frame2::
Data_03E_4F3F:: ; heuristic: meta-sprite frame; C0
    db $F8, $2C, $01, $30 ; entry 0
    db $F8, $CC, $01, $10 ; entry 1
    db $F0, $E4, $05, $10 ; entry 2
    db $F8, $D4, $06, $10 ; entry 3
    db $F8, $DC, $07, $10 ; entry 4
    db $F8, $E4, $08, $10 ; entry 5
    db $F8, $EC, $09, $10 ; entry 6
    db $F8, $24, $06, $30 ; entry 7
    db $F8, $1C, $07, $30 ; entry 8
    db $F8, $14, $08, $30 ; entry 9
    db $F8, $0C, $09, $30 ; entry 10
    db $F0, $14, $05, $30 ; entry 11
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3E_4024Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set05Frame3::
Data_03E_4F70:: ; heuristic: meta-sprite frame; C0
    db $EF, $0E, $00, $30 ; entry 0
    db $D8, $F9, $10, $10 ; entry 1
    db $E0, $F8, $11, $10 ; entry 2
    db $E0, $00, $12, $10 ; entry 3
    db $E8, $F8, $21, $10 ; entry 4
    db $E8, $00, $22, $10 ; entry 5
    db $F0, $F0, $13, $10 ; entry 6
    db $F8, $F0, $23, $10 ; entry 7
    db $F8, $F8, $24, $10 ; entry 8
    db $F8, $00, $25, $10 ; entry 9
    db $F8, $08, $26, $10 ; entry 10
    db $F8, $E8, $20, $10 ; entry 11
    db $F8, $10, $20, $30 ; entry 12
    db $F0, $00, $15, $10 ; entry 13
    db $F0, $08, $16, $10 ; entry 14
    db $F0, $F8, $1E, $10 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3E_4024Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set05Frame4::
Data_03E_4FB1:: ; heuristic: meta-sprite frame; C0
    db $D0, $00, $0A, $10 ; entry 0
    db $D8, $00, $0B, $10 ; entry 1
    db $D8, $07, $0C, $10 ; entry 2
    db $E0, $04, $0E, $10 ; entry 3
    db $E8, $08, $19, $10 ; entry 4
    db $F0, $00, $19, $10 ; entry 5
    db $F0, $08, $29, $10 ; entry 6
    db $F0, $18, $17, $10 ; entry 7
    db $F8, $17, $27, $10 ; entry 8
    db $F0, $E0, $14, $10 ; entry 9
    db $F0, $E8, $25, $10 ; entry 10
    db $E0, $0C, $22, $10 ; entry 11
    db $D8, $F8, $12, $30 ; entry 12
    db $D8, $EE, $10, $30 ; entry 13
    db $E0, $FC, $21, $10 ; entry 14
    db $E8, $F8, $13, $10 ; entry 15
    db $E8, $00, $15, $30 ; entry 16
    db $F0, $F8, $28, $10 ; entry 17
    db $F0, $F0, $28, $30 ; entry 18
    db $F8, $0F, $23, $30 ; entry 19
    db $E8, $10, $28, $30 ; entry 20
    db $F8, $E0, $1A, $10 ; entry 21
    db $F8, $E8, $1B, $10 ; entry 22
    db $F8, $FF, $1B, $10 ; entry 23
    db $F8, $07, $1C, $10 ; entry 24
    db $F0, $10, $1E, $30 ; entry 25
    db $F8, $F0, $2A, $10 ; entry 26
    db $F8, $F7, $0B, $10 ; entry 27
    db $E0, $EF, $1A, $30 ; entry 28
    db $E0, $E7, $0C, $30 ; entry 29
    db $E8, $E1, $22, $30 ; entry 30
    db $E8, $E9, $18, $30 ; entry 31
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3E_4024Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set05Frame5::
Data_03E_5032:: ; heuristic: meta-sprite frame; C0
    db $E8, $EC, $14, $10 ; entry 0
    db $E0, $EB, $21, $10 ; entry 1
    db $E0, $F3, $19, $10 ; entry 2
    db $D8, $1C, $17, $10 ; entry 3
    db $E0, $1B, $27, $10 ; entry 4
    db $D0, $E0, $22, $70 ; entry 5
    db $E0, $E3, $1D, $10 ; entry 6
    db $F8, $F6, $2C, $10 ; entry 7
    db $D0, $F0, $1C, $10 ; entry 8
    db $D8, $E4, $18, $10 ; entry 9
    db $D8, $EC, $19, $10 ; entry 10
    db $D0, $E8, $29, $10 ; entry 11
    db $D0, $F8, $29, $30 ; entry 12
    db $D0, $00, $19, $70 ; entry 13
    db $D8, $F4, $19, $70 ; entry 14
    db $E8, $F4, $29, $10 ; entry 15
    db $F0, $F8, $29, $50 ; entry 16
    db $F8, $FE, $0E, $50 ; entry 17
    db $F0, $00, $0E, $70 ; entry 18
    db $D8, $0C, $19, $30 ; entry 19
    db $D8, $FC, $19, $70 ; entry 20
    db $E0, $FB, $1C, $50 ; entry 21
    db $D0, $08, $0E, $10 ; entry 22
    db $D8, $04, $29, $10 ; entry 23
    db $E0, $03, $29, $30 ; entry 24
    db $E8, $FC, $1B, $10 ; entry 25
    db $D0, $10, $1C, $10 ; entry 26
    db $E8, $04, $1C, $10 ; entry 27
    db $D0, $18, $0F, $10 ; entry 28
    db $D8, $14, $14, $30 ; entry 29
    db $E8, $0C, $0F, $10 ; entry 30
    db $E0, $0B, $2A, $50 ; entry 31
    db $E0, $13, $10, $70 ; entry 32
    db $F0, $08, $28, $70 ; entry 33
    db $F0, $F0, $0B, $50 ; entry 34
    db $F8, $E6, $05, $10 ; entry 35
    db $F8, $0E, $20, $30 ; entry 36
    db $F8, $16, $16, $10 ; entry 37
    db $F8, $EE, $2B, $10 ; entry 38
    db $F8, $06, $0D, $10 ; entry 39
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3E_4024Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set05Frame6::
Data_03E_50D3:: ; heuristic: meta-sprite frame; C0
    db $F8, $0A, $26, $10 ; entry 0
    db $E8, $19, $10, $10 ; entry 1
    db $F0, $18, $11, $10 ; entry 2
    db $F0, $20, $12, $10 ; entry 3
    db $F8, $18, $21, $10 ; entry 4
    db $F8, $20, $22, $10 ; entry 5
    db $E0, $E8, $17, $10 ; entry 6
    db $E8, $E8, $27, $10 ; entry 7
    db $D8, $F0, $18, $10 ; entry 8
    db $E8, $F4, $18, $10 ; entry 9
    db $E0, $00, $18, $30 ; entry 10
    db $F0, $00, $18, $30 ; entry 11
    db $D0, $00, $19, $10 ; entry 12
    db $D8, $F8, $19, $10 ; entry 13
    db $D0, $F8, $29, $10 ; entry 14
    db $E8, $FC, $0E, $10 ; entry 15
    db $E8, $04, $22, $10 ; entry 16
    db $D0, $F0, $21, $10 ; entry 17
    db $D8, $10, $17, $30 ; entry 18
    db $E0, $10, $27, $30 ; entry 19
    db $D0, $20, $17, $10 ; entry 20
    db $F0, $F0, $28, $10 ; entry 21
    db $E8, $DF, $10, $30 ; entry 22
    db $F0, $E0, $11, $30 ; entry 23
    db $F0, $D8, $12, $30 ; entry 24
    db $F8, $E0, $21, $30 ; entry 25
    db $F8, $D8, $0C, $30 ; entry 26
    db $D8, $D8, $1D, $10 ; entry 27
    db $E0, $28, $1D, $10 ; entry 28
    db $D0, $08, $0F, $10 ; entry 29
    db $F0, $F8, $1F, $10 ; entry 30
    db $E0, $F8, $1F, $10 ; entry 31
    db $F8, $F2, $2C, $10 ; entry 32
    db $F8, $FA, $2D, $10 ; entry 33
    db $E0, $F0, $1E, $10 ; entry 34
    db $D8, $08, $1E, $30 ; entry 35
    db $D8, $00, $29, $70 ; entry 36
    db $F8, $02, $0D, $10 ; entry 37
    db $F8, $28, $17, $30 ; entry 38
    db $F8, $D0, $17, $10 ; entry 39
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3E_4024Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set05Frame7::
Data_03E_5174:: ; heuristic: meta-sprite frame; C0
    db $F0, $F0, $18, $10 ; entry 0
    db $F0, $F8, $19, $10 ; entry 1
    db $E4, $D4, $10, $10 ; entry 2
    db $EC, $24, $11, $30 ; entry 3
    db $F4, $1C, $27, $10 ; entry 4
    db $EC, $1C, $28, $10 ; entry 5
    db $E4, $24, $10, $30 ; entry 6
    db $F8, $10, $0C, $10 ; entry 7
    db $D8, $10, $17, $10 ; entry 8
    db $E0, $10, $27, $10 ; entry 9
    db $DC, $E8, $17, $30 ; entry 10
    db $E4, $E8, $27, $30 ; entry 11
    db $D0, $F8, $0A, $10 ; entry 12
    db $D8, $F8, $0B, $10 ; entry 13
    db $D8, $00, $0C, $10 ; entry 14
    db $E0, $FC, $0E, $10 ; entry 15
    db $E0, $04, $22, $10 ; entry 16
    db $E8, $F0, $28, $10 ; entry 17
    db $E8, $F8, $29, $10 ; entry 18
    db $E8, $00, $19, $10 ; entry 19
    db $F0, $08, $28, $30 ; entry 20
    db $D8, $F0, $16, $30 ; entry 21
    db $E8, $08, $0F, $10 ; entry 22
    db $F8, $E8, $1A, $10 ; entry 23
    db $F8, $F0, $1B, $10 ; entry 24
    db $F8, $08, $1C, $70 ; entry 25
    db $F8, $F8, $0E, $10 ; entry 26
    db $F8, $00, $2D, $10 ; entry 27
    db $F4, $24, $1E, $30 ; entry 28
    db $F0, $00, $29, $10 ; entry 29
    db $EC, $D4, $11, $10 ; entry 30
    db $F4, $DC, $27, $30 ; entry 31
    db $EC, $DC, $28, $30 ; entry 32
    db $F4, $D4, $1E, $10 ; entry 33
    db $E0, $F4, $18, $10 ; entry 34
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites3E_4024Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set05Frame8::
Data_03E_5201:: ; heuristic: meta-sprite frame; C0
    db $EF, $0E, $00, $30 ; entry 0
    db $D8, $F9, $10, $10 ; entry 1
    db $E0, $F8, $11, $10 ; entry 2
    db $E0, $00, $12, $10 ; entry 3
    db $E8, $F8, $21, $10 ; entry 4
    db $E8, $00, $22, $10 ; entry 5
    db $F0, $F0, $13, $10 ; entry 6
    db $F0, $F8, $14, $10 ; entry 7
    db $F0, $00, $15, $10 ; entry 8
    db $F0, $08, $16, $10 ; entry 9
    db $F8, $F0, $23, $10 ; entry 10
    db $F8, $F8, $24, $10 ; entry 11
    db $F8, $00, $25, $10 ; entry 12
    db $F8, $08, $26, $10 ; entry 13
    db $F8, $E8, $20, $10 ; entry 14
    db $F8, $10, $20, $30 ; entry 15
    db $F0, $D4, $11, $10 ; entry 16
    db $F0, $DC, $12, $10 ; entry 17
    db $E8, $D8, $0A, $30 ; entry 18
    db $F0, $24, $11, $30 ; entry 19
    db $F0, $1C, $12, $30 ; entry 20
    db $E8, $20, $0A, $10 ; entry 21
    db $F8, $24, $0B, $30 ; entry 22
    db $F8, $1C, $0C, $30 ; entry 23
    db $F8, $D4, $0B, $10 ; entry 24
    db $F8, $DC, $0C, $10 ; entry 25
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites3E_4024Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set05Frame9::
Data_03E_526A:: ; heuristic: meta-sprite frame; C0
    db $F7, $EA, $00, $10 ; entry 0
    db $F0, $1C, $17, $10 ; entry 1
    db $F8, $1C, $27, $10 ; entry 2
    db $F0, $DC, $17, $30 ; entry 3
    db $F8, $DC, $27, $30 ; entry 4
    db $E0, $FF, $10, $30 ; entry 5
    db $E8, $00, $11, $30 ; entry 6
    db $E8, $F8, $12, $30 ; entry 7
    db $F0, $00, $21, $30 ; entry 8
    db $F0, $F8, $22, $30 ; entry 9
    db $F8, $08, $13, $30 ; entry 10
    db $F8, $00, $14, $30 ; entry 11
    db $F8, $F8, $15, $30 ; entry 12
    db $F8, $F0, $16, $30 ; entry 13
    db $F8, $D4, $1D, $10 ; entry 14
    db $F8, $24, $1D, $30 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 10 of MetaSprites3E_4024Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set05Frame10::
Data_03E_52AB:: ; heuristic: meta-sprite frame; C0
    db $E8, $F8, $17, $10 ; entry 0
    db $F8, $F8, $24, $10 ; entry 1
    db $F8, $E8, $16, $10 ; entry 2
    db $F8, $F0, $22, $30 ; entry 3
    db $F8, $00, $22, $10 ; entry 4
    db $F8, $08, $1D, $10 ; entry 5
    db $F0, $F8, $11, $10 ; entry 6
    db $F0, $FE, $1E, $70 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 11 of MetaSprites3E_4024Set05; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set05Frame11::
    db $80 ; end

; E-0147 (derived: meta-sprite set 6 of MetaSprites3E_4024Table: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3E_4024Set06::
Data_03E_52CD:: ; heuristic: meta-sprite set; C0
    dw MetaSprites3E_4024Set06Frame0 ; entry 0
    dw MetaSprites3E_4024Set06Frame1 ; entry 1
    dw MetaSprites3E_4024Set06Frame2 ; entry 2
    dw MetaSprites3E_4024Set06Frame3 ; entry 3
    dw MetaSprites3E_4024Set06Frame4 ; entry 4
    dw MetaSprites3E_4024Set06Frame5 ; entry 5
    dw MetaSprites3E_4024Set06Frame5 ; entry 6
    dw MetaSprites3E_4024Set06Frame5 ; entry 7
    dw MetaSprites3E_4024Set06Frame5 ; entry 8
    dw MetaSprites3E_4024Set06Frame5 ; entry 9
    dw MetaSprites3E_4024Set06Frame5 ; entry 10
    dw MetaSprites3E_4024Set06Frame5 ; entry 11
    dw MetaSprites3E_4024Set06Frame5 ; entry 12
    dw MetaSprites3E_4024Set06Frame5 ; entry 13
    dw MetaSprites3E_4024Set06Frame5 ; entry 14
    dw MetaSprites3E_4024Set06Frame5 ; entry 15
    dw MetaSprites3E_4024Set06Frame5 ; entry 16
    dw MetaSprites3E_4024Set06Frame5 ; entry 17
    dw MetaSprites3E_4024Set06Frame5 ; entry 18
    dw MetaSprites3E_4024Set06Frame5 ; entry 19
    dw MetaSprites3E_4024Set06Frame5 ; entry 20
    dw MetaSprites3E_4024Set06Frame5 ; entry 21
    dw MetaSprites3E_4024Set06Frame5 ; entry 22
    dw MetaSprites3E_4024Set06Frame5 ; entry 23
    dw MetaSprites3E_4024Set06Frame5 ; entry 24
    dw MetaSprites3E_4024Set06Frame5 ; entry 25
    dw MetaSprites3E_4024Set06Frame5 ; entry 26
    dw MetaSprites3E_4024Set06Frame5 ; entry 27
    dw MetaSprites3E_4024Set06Frame5 ; entry 28
    dw MetaSprites3E_4024Set06Frame5 ; entry 29
    dw MetaSprites3E_4024Set06Frame5 ; entry 30
    dw MetaSprites3E_4024Set06Frame5 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3E_4024Set06; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set06Frame0::
Data_03E_530D:: ; heuristic: meta-sprite frame; C0
    db $E2, $F8, $00, $00 ; entry 0
    db $E2, $00, $01, $00 ; entry 1
    db $EA, $F8, $02, $00 ; entry 2
    db $EA, $00, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3E_4024Set06; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set06Frame1::
Data_03E_531E:: ; heuristic: meta-sprite frame; C0
    db $E4, $F8, $07, $00 ; entry 0
    db $E4, $00, $08, $00 ; entry 1
    db $EC, $F8, $09, $00 ; entry 2
    db $EC, $00, $0A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3E_4024Set06; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set06Frame2::
Data_03E_532F:: ; heuristic: meta-sprite frame; C0
    db $E8, $08, $00, $20 ; entry 0
    db $E8, $00, $01, $20 ; entry 1
    db $F0, $08, $02, $20 ; entry 2
    db $F0, $00, $03, $20 ; entry 3
    db $DF, $F1, $00, $00 ; entry 4
    db $DF, $F9, $01, $00 ; entry 5
    db $E7, $F1, $02, $00 ; entry 6
    db $E7, $F9, $03, $00 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3E_4024Set06; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set06Frame3::
Data_03E_5350:: ; heuristic: meta-sprite frame; C0
    db $E2, $00, $0F, $00 ; entry 0
    db $E2, $08, $10, $00 ; entry 1
    db $DA, $00, $0C, $00 ; entry 2
    db $DA, $F8, $0B, $00 ; entry 3
    db $EA, $FF, $0E, $60 ; entry 4
    db $EA, $F7, $0F, $60 ; entry 5
    db $EA, $EF, $10, $60 ; entry 6
    db $EA, $07, $0D, $60 ; entry 7
    db $F2, $F7, $0C, $60 ; entry 8
    db $F2, $FF, $0B, $60 ; entry 9
    db $E2, $F8, $0E, $00 ; entry 10
    db $E2, $F0, $0D, $00 ; entry 11
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3E_4024Set06; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set06Frame4::
Data_03E_5381:: ; heuristic: meta-sprite frame; C0
    db $DF, $06, $01, $00 ; entry 0
    db $E7, $FE, $02, $00 ; entry 1
    db $E7, $06, $03, $00 ; entry 2
    db $DF, $FE, $00, $00 ; entry 3
    db $E6, $EF, $01, $20 ; entry 4
    db $EE, $EF, $03, $20 ; entry 5
    db $EE, $FF, $02, $20 ; entry 6
    db $E6, $F7, $04, $00 ; entry 7
    db $EE, $F7, $05, $00 ; entry 8
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3E_4024Set06; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set06Frame5::
    db $80 ; end

; E-0147 (derived: meta-sprite set 7 of MetaSprites3E_4024Table: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3E_4024Set07::
Data_03E_53A7:: ; heuristic: meta-sprite set; C0
    dw MetaSprites3E_4024Set07Frame0 ; entry 0
    dw MetaSprites3E_4024Set07Frame1 ; entry 1
    dw MetaSprites3E_4024Set07Frame2 ; entry 2
    dw MetaSprites3E_4024Set07Frame3 ; entry 3
    dw MetaSprites3E_4024Set07Frame4 ; entry 4
    dw MetaSprites3E_4024Set07Frame5 ; entry 5
    dw MetaSprites3E_4024Set07Frame6 ; entry 6
    dw MetaSprites3E_4024Set07Frame7 ; entry 7
    dw MetaSprites3E_4024Set07Frame8 ; entry 8
    dw MetaSprites3E_4024Set07Frame9 ; entry 9
    dw MetaSprites3E_4024Set07Frame9 ; entry 10
    dw MetaSprites3E_4024Set07Frame9 ; entry 11
    dw MetaSprites3E_4024Set07Frame9 ; entry 12
    dw MetaSprites3E_4024Set07Frame9 ; entry 13
    dw MetaSprites3E_4024Set07Frame9 ; entry 14
    dw MetaSprites3E_4024Set07Frame9 ; entry 15
    dw MetaSprites3E_4024Set07Frame9 ; entry 16
    dw MetaSprites3E_4024Set07Frame9 ; entry 17
    dw MetaSprites3E_4024Set07Frame9 ; entry 18
    dw MetaSprites3E_4024Set07Frame9 ; entry 19
    dw MetaSprites3E_4024Set07Frame9 ; entry 20
    dw MetaSprites3E_4024Set07Frame9 ; entry 21
    dw MetaSprites3E_4024Set07Frame9 ; entry 22
    dw MetaSprites3E_4024Set07Frame9 ; entry 23
    dw MetaSprites3E_4024Set07Frame9 ; entry 24
    dw MetaSprites3E_4024Set07Frame9 ; entry 25
    dw MetaSprites3E_4024Set07Frame9 ; entry 26
    dw MetaSprites3E_4024Set07Frame9 ; entry 27
    dw MetaSprites3E_4024Set07Frame9 ; entry 28
    dw MetaSprites3E_4024Set07Frame9 ; entry 29
    dw MetaSprites3E_4024Set07Frame9 ; entry 30
    dw MetaSprites3E_4024Set07Frame9 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3E_4024Set07; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set07Frame0::
Data_03E_53E7:: ; heuristic: meta-sprite frame; C0
    db $D0, $E8, $19, $00 ; entry 0
    db $D0, $F0, $1A, $00 ; entry 1
    db $D0, $F8, $1B, $00 ; entry 2
    db $D0, $10, $19, $20 ; entry 3
    db $D0, $08, $1A, $20 ; entry 4
    db $D0, $00, $1B, $20 ; entry 5
    db $F8, $E8, $19, $40 ; entry 6
    db $F8, $F0, $1A, $40 ; entry 7
    db $F8, $F8, $1B, $40 ; entry 8
    db $F8, $10, $19, $60 ; entry 9
    db $F8, $08, $1A, $60 ; entry 10
    db $F8, $00, $1B, $60 ; entry 11
    db $D8, $E8, $1C, $00 ; entry 12
    db $D8, $F0, $1D, $00 ; entry 13
    db $D8, $10, $1C, $20 ; entry 14
    db $D8, $08, $1D, $20 ; entry 15
    db $F0, $10, $1C, $60 ; entry 16
    db $F0, $08, $1D, $60 ; entry 17
    db $F0, $E8, $1C, $40 ; entry 18
    db $F0, $F0, $1D, $40 ; entry 19
    db $E0, $E8, $1E, $00 ; entry 20
    db $E8, $E8, $1E, $40 ; entry 21
    db $E0, $10, $1E, $20 ; entry 22
    db $E8, $10, $1E, $60 ; entry 23
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3E_4024Set07; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set07Frame1::
Data_03E_5448:: ; heuristic: meta-sprite frame; C0
    db $DC, $F0, $19, $00 ; entry 0
    db $DC, $F8, $1A, $00 ; entry 1
    db $E4, $F0, $1C, $00 ; entry 2
    db $E4, $F8, $1D, $00 ; entry 3
    db $DC, $08, $19, $20 ; entry 4
    db $DC, $00, $1A, $20 ; entry 5
    db $E4, $08, $1C, $20 ; entry 6
    db $E4, $00, $1D, $20 ; entry 7
    db $F4, $08, $19, $60 ; entry 8
    db $F4, $00, $1A, $60 ; entry 9
    db $EC, $08, $1C, $60 ; entry 10
    db $EC, $00, $1D, $60 ; entry 11
    db $F4, $F0, $19, $40 ; entry 12
    db $F4, $F8, $1A, $40 ; entry 13
    db $EC, $F0, $1C, $40 ; entry 14
    db $EC, $F8, $1D, $40 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3E_4024Set07; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set07Frame2::
Data_03E_5489:: ; heuristic: meta-sprite frame; C0
    db $EC, $F8, $19, $40 ; entry 0
    db $EC, $00, $19, $60 ; entry 1
    db $E4, $00, $19, $20 ; entry 2
    db $E4, $F8, $19, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3E_4024Set07; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set07Frame3::
Data_03E_549A:: ; heuristic: meta-sprite frame; C0
    db $DF, $06, $01, $00 ; entry 0
    db $E7, $FE, $02, $00 ; entry 1
    db $E7, $06, $03, $00 ; entry 2
    db $DF, $FE, $00, $00 ; entry 3
    db $E6, $EF, $01, $20 ; entry 4
    db $EE, $EF, $03, $20 ; entry 5
    db $EE, $FF, $02, $20 ; entry 6
    db $E6, $F7, $04, $00 ; entry 7
    db $EE, $F7, $05, $00 ; entry 8
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3E_4024Set07; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set07Frame4::
Data_03E_54BF:: ; heuristic: meta-sprite frame; C0
    db $E2, $00, $0F, $00 ; entry 0
    db $E2, $08, $10, $00 ; entry 1
    db $DA, $00, $0C, $00 ; entry 2
    db $DA, $F8, $0B, $00 ; entry 3
    db $EA, $FF, $0E, $60 ; entry 4
    db $EA, $F7, $0F, $60 ; entry 5
    db $EA, $EF, $10, $60 ; entry 6
    db $EA, $07, $0D, $60 ; entry 7
    db $F2, $F7, $0C, $60 ; entry 8
    db $F2, $FF, $0B, $60 ; entry 9
    db $E2, $F8, $0E, $00 ; entry 10
    db $E2, $F0, $0D, $00 ; entry 11
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3E_4024Set07; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set07Frame5::
Data_03E_54F0:: ; heuristic: meta-sprite frame; C0
    db $E8, $08, $00, $20 ; entry 0
    db $E8, $00, $01, $20 ; entry 1
    db $F0, $08, $02, $20 ; entry 2
    db $F0, $00, $03, $20 ; entry 3
    db $D5, $F9, $00, $00 ; entry 4
    db $D5, $01, $01, $00 ; entry 5
    db $DD, $F9, $02, $00 ; entry 6
    db $DD, $01, $03, $00 ; entry 7
    db $E4, $07, $02, $00 ; entry 8
    db $E4, $0F, $03, $00 ; entry 9
    db $DC, $11, $00, $20 ; entry 10
    db $DC, $09, $01, $20 ; entry 11
    db $DF, $EE, $00, $00 ; entry 12
    db $DF, $F6, $01, $00 ; entry 13
    db $E7, $EE, $02, $00 ; entry 14
    db $E7, $F6, $03, $00 ; entry 15
    db $EF, $FD, $00, $20 ; entry 16
    db $EF, $F5, $01, $20 ; entry 17
    db $F7, $FD, $02, $20 ; entry 18
    db $F7, $F5, $03, $20 ; entry 19
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3E_4024Set07; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set07Frame6::
Data_03E_5541:: ; heuristic: meta-sprite frame; C0
    db $F0, $FB, $07, $00 ; entry 0
    db $F0, $03, $08, $00 ; entry 1
    db $F8, $FB, $09, $00 ; entry 2
    db $F8, $03, $0A, $00 ; entry 3
    db $E3, $E8, $07, $00 ; entry 4
    db $E3, $F0, $08, $00 ; entry 5
    db $EB, $E8, $09, $00 ; entry 6
    db $EB, $F0, $0A, $00 ; entry 7
    db $EC, $10, $07, $20 ; entry 8
    db $EC, $08, $08, $20 ; entry 9
    db $F4, $10, $09, $20 ; entry 10
    db $F4, $08, $0A, $20 ; entry 11
    db $D8, $06, $07, $20 ; entry 12
    db $D8, $FE, $08, $20 ; entry 13
    db $E0, $06, $09, $20 ; entry 14
    db $E0, $FE, $0A, $20 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3E_4024Set07; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set07Frame7::
Data_03E_5582:: ; heuristic: meta-sprite frame; C0
    db $DA, $EF, $00, $00 ; entry 0
    db $DA, $F7, $01, $00 ; entry 1
    db $E2, $EF, $02, $00 ; entry 2
    db $E2, $F7, $03, $00 ; entry 3
    db $E7, $05, $02, $00 ; entry 4
    db $E7, $0D, $03, $00 ; entry 5
    db $DF, $0F, $00, $20 ; entry 6
    db $DF, $07, $01, $20 ; entry 7
    db $F4, $FA, $03, $00 ; entry 8
    db $F4, $F2, $03, $20 ; entry 9
    db $EC, $FA, $06, $00 ; entry 10
    db $EC, $F2, $01, $20 ; entry 11
    db $EF, $01, $02, $20 ; entry 12
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites3E_4024Set07; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set07Frame8::
Data_03E_55B7:: ; heuristic: meta-sprite frame; C0
    db $D8, $F9, $0F, $00 ; entry 0
    db $D8, $01, $10, $00 ; entry 1
    db $D0, $F9, $0C, $00 ; entry 2
    db $D0, $F1, $0B, $00 ; entry 3
    db $E0, $F8, $0E, $60 ; entry 4
    db $E0, $F0, $0F, $60 ; entry 5
    db $E0, $E8, $10, $60 ; entry 6
    db $E0, $00, $0D, $60 ; entry 7
    db $E8, $F0, $0C, $60 ; entry 8
    db $E8, $F8, $0B, $60 ; entry 9
    db $D8, $F1, $0E, $00 ; entry 10
    db $D8, $E9, $0D, $00 ; entry 11
    db $E8, $09, $0F, $00 ; entry 12
    db $E8, $11, $10, $00 ; entry 13
    db $E0, $09, $0C, $00 ; entry 14
    db $E0, $01, $0B, $00 ; entry 15
    db $F0, $08, $0E, $60 ; entry 16
    db $F0, $00, $0F, $60 ; entry 17
    db $F0, $F8, $10, $60 ; entry 18
    db $F0, $10, $0D, $60 ; entry 19
    db $F8, $00, $0C, $60 ; entry 20
    db $F8, $08, $0B, $60 ; entry 21
    db $E8, $01, $0E, $00 ; entry 22
    db $E8, $F9, $0D, $00 ; entry 23
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites3E_4024Set07; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set07Frame9::
    db $80 ; end

; E-0147 (derived: meta-sprite set 8 of MetaSprites3E_4024Table: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3E_4024Set08::
Data_03E_5619:: ; heuristic: meta-sprite set; C0
    dw MetaSprites3E_4024Set08Frame0 ; entry 0
    dw MetaSprites3E_4024Set08Frame1 ; entry 1
    dw MetaSprites3E_4024Set08Frame2 ; entry 2
    dw MetaSprites3E_4024Set08Frame3 ; entry 3
    dw MetaSprites3E_4024Set08Frame4 ; entry 4
    dw MetaSprites3E_4024Set08Frame5 ; entry 5
    dw MetaSprites3E_4024Set08Frame6 ; entry 6
    dw MetaSprites3E_4024Set08Frame7 ; entry 7
    dw MetaSprites3E_4024Set08Frame8 ; entry 8
    dw MetaSprites3E_4024Set08Frame9 ; entry 9
    dw MetaSprites3E_4024Set08Frame10 ; entry 10
    dw MetaSprites3E_4024Set08Frame11 ; entry 11
    dw MetaSprites3E_4024Set08Frame12 ; entry 12
    dw MetaSprites3E_4024Set08Frame13 ; entry 13
    dw MetaSprites3E_4024Set08Frame14 ; entry 14
    dw MetaSprites3E_4024Set08Frame15 ; entry 15
    dw MetaSprites3E_4024Set08Frame16 ; entry 16
    dw MetaSprites3E_4024Set08Frame17 ; entry 17
    dw MetaSprites3E_4024Set08Frame18 ; entry 18
    dw MetaSprites3E_4024Set08Frame19 ; entry 19
    dw MetaSprites3E_4024Set08Frame20 ; entry 20
    dw MetaSprites3E_4024Set08Frame20 ; entry 21
    dw MetaSprites3E_4024Set08Frame20 ; entry 22
    dw MetaSprites3E_4024Set08Frame20 ; entry 23
    dw MetaSprites3E_4024Set08Frame20 ; entry 24
    dw MetaSprites3E_4024Set08Frame20 ; entry 25
    dw MetaSprites3E_4024Set08Frame20 ; entry 26
    dw MetaSprites3E_4024Set08Frame20 ; entry 27
    dw MetaSprites3E_4024Set08Frame20 ; entry 28
    dw MetaSprites3E_4024Set08Frame20 ; entry 29
    dw MetaSprites3E_4024Set08Frame20 ; entry 30
    dw MetaSprites3E_4024Set08Frame20 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3E_4024Set08; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set08Frame0::
Data_03E_5659:: ; heuristic: meta-sprite frame; C0
    db $F8, $48, $19, $60 ; entry 0
    db $D0, $48, $19, $20 ; entry 1
    db $E8, $44, $1B, $40 ; entry 2
    db $F0, $40, $1B, $40 ; entry 3
    db $E0, $44, $1B, $00 ; entry 4
    db $D8, $40, $1B, $00 ; entry 5
    db $F8, $B0, $19, $40 ; entry 6
    db $D0, $B0, $19, $00 ; entry 7
    db $D8, $B8, $1B, $20 ; entry 8
    db $E0, $B4, $1B, $20 ; entry 9
    db $F0, $B8, $1B, $60 ; entry 10
    db $E8, $B4, $1B, $60 ; entry 11
    db $D0, $E0, $1A, $00 ; entry 12
    db $D0, $D0, $1A, $00 ; entry 13
    db $D0, $C0, $1A, $00 ; entry 14
    db $F8, $E0, $1A, $40 ; entry 15
    db $F8, $D0, $1A, $40 ; entry 16
    db $F8, $C0, $1A, $40 ; entry 17
    db $D0, $28, $1A, $20 ; entry 18
    db $F8, $28, $1A, $60 ; entry 19
    db $D0, $18, $1A, $20 ; entry 20
    db $F8, $18, $1A, $60 ; entry 21
    db $D0, $38, $1A, $20 ; entry 22
    db $F8, $38, $1A, $60 ; entry 23
    db $D8, $30, $19, $20 ; entry 24
    db $F0, $30, $19, $60 ; entry 25
    db $D8, $C8, $19, $00 ; entry 26
    db $F0, $C8, $19, $40 ; entry 27
    db $DC, $C0, $1B, $20 ; entry 28
    db $EC, $C0, $1B, $60 ; entry 29
    db $DC, $38, $1B, $00 ; entry 30
    db $EC, $38, $1B, $40 ; entry 31
    db $E0, $CC, $1B, $20 ; entry 32
    db $E8, $CC, $1B, $60 ; entry 33
    db $E8, $2C, $1B, $40 ; entry 34
    db $E0, $2C, $1B, $00 ; entry 35
    db $D0, $F0, $1C, $00 ; entry 36
    db $D0, $08, $1C, $20 ; entry 37
    db $F8, $F0, $1C, $40 ; entry 38
    db $F8, $08, $1C, $60 ; entry 39
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3E_4024Set08; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set08Frame1::
Data_03E_56FA:: ; heuristic: meta-sprite frame; C0
    db $D0, $10, $1A, $20 ; entry 0
    db $D0, $20, $1A, $20 ; entry 1
    db $F8, $10, $1A, $60 ; entry 2
    db $F8, $20, $1A, $60 ; entry 3
    db $D0, $E8, $1A, $00 ; entry 4
    db $D0, $D8, $1A, $00 ; entry 5
    db $F8, $E8, $1A, $40 ; entry 6
    db $F8, $D8, $1A, $40 ; entry 7
    db $D0, $D0, $19, $00 ; entry 8
    db $D8, $D0, $1B, $20 ; entry 9
    db $E0, $D4, $1B, $20 ; entry 10
    db $F0, $D0, $1B, $60 ; entry 11
    db $E8, $D4, $1B, $60 ; entry 12
    db $F8, $D0, $19, $40 ; entry 13
    db $F8, $28, $19, $60 ; entry 14
    db $D0, $28, $19, $20 ; entry 15
    db $E8, $24, $1B, $40 ; entry 16
    db $F0, $28, $1B, $40 ; entry 17
    db $E0, $24, $1B, $00 ; entry 18
    db $D8, $28, $1B, $00 ; entry 19
    db $D0, $F8, $1C, $00 ; entry 20
    db $F8, $00, $1C, $60 ; entry 21
    db $F8, $F8, $1C, $40 ; entry 22
    db $D0, $00, $1C, $20 ; entry 23
    db $D8, $DC, $19, $00 ; entry 24
    db $F0, $DC, $19, $40 ; entry 25
    db $E0, $E0, $1B, $20 ; entry 26
    db $E8, $E0, $1B, $60 ; entry 27
    db $F0, $1C, $19, $60 ; entry 28
    db $D8, $1C, $19, $20 ; entry 29
    db $E8, $18, $1B, $40 ; entry 30
    db $E0, $18, $1B, $00 ; entry 31
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3E_4024Set08; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set08Frame2::
Data_03E_577B:: ; heuristic: meta-sprite frame; C0
    db $F0, $E8, $19, $40 ; entry 0
    db $D8, $E8, $19, $00 ; entry 1
    db $E0, $E8, $1B, $20 ; entry 2
    db $E8, $E8, $1B, $60 ; entry 3
    db $D8, $00, $1C, $20 ; entry 4
    db $D8, $08, $1A, $20 ; entry 5
    db $D8, $F8, $1C, $00 ; entry 6
    db $D8, $F0, $1A, $00 ; entry 7
    db $F0, $00, $1C, $60 ; entry 8
    db $F0, $F8, $1C, $40 ; entry 9
    db $F0, $F0, $1A, $40 ; entry 10
    db $D8, $10, $19, $20 ; entry 11
    db $E0, $10, $1B, $00 ; entry 12
    db $F0, $10, $19, $60 ; entry 13
    db $E8, $10, $1B, $40 ; entry 14
    db $F8, $18, $19, $60 ; entry 15
    db $F8, $E0, $19, $40 ; entry 16
    db $D0, $E0, $19, $00 ; entry 17
    db $D0, $08, $1A, $20 ; entry 18
    db $D0, $F0, $1A, $00 ; entry 19
    db $F8, $F0, $1A, $40 ; entry 20
    db $F8, $08, $1A, $60 ; entry 21
    db $D0, $18, $19, $20 ; entry 22
    db $E0, $F0, $1A, $00 ; entry 23
    db $E8, $F0, $1A, $40 ; entry 24
    db $E0, $08, $1A, $20 ; entry 25
    db $F0, $08, $1A, $60 ; entry 26
    db $E8, $08, $1A, $60 ; entry 27
    db $DC, $E0, $1B, $20 ; entry 28
    db $EC, $E0, $1B, $60 ; entry 29
    db $DC, $18, $1B, $00 ; entry 30
    db $EC, $18, $1B, $40 ; entry 31
    db $D4, $D4, $19, $00 ; entry 32
    db $F4, $D4, $19, $40 ; entry 33
    db $D4, $24, $19, $20 ; entry 34
    db $F4, $24, $19, $60 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3E_4024Set08; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set08Frame3::
Data_03E_580C:: ; heuristic: meta-sprite frame; C0
    db $E8, $F8, $19, $40 ; entry 0
    db $E8, $00, $19, $60 ; entry 1
    db $E0, $00, $19, $20 ; entry 2
    db $E0, $F8, $19, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3E_4024Set08; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set08Frame4::
Data_03E_581D:: ; heuristic: meta-sprite frame; C0
    db $E8, $00, $02, $20 ; entry 0
    db $E8, $F8, $03, $20 ; entry 1
    db $E0, $F8, $02, $40 ; entry 2
    db $E0, $00, $03, $40 ; entry 3
    db $DE, $08, $28, $00 ; entry 4
    db $DE, $10, $29, $00 ; entry 5
    db $D9, $F3, $21, $00 ; entry 6
    db $EF, $FB, $20, $60 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3E_4024Set08; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set08Frame5::
Data_03E_583E:: ; heuristic: meta-sprite frame; C0
    db $E8, $F0, $2D, $20 ; entry 0
    db $E8, $E8, $2E, $20 ; entry 1
    db $E8, $00, $2C, $00 ; entry 2
    db $E8, $08, $2D, $00 ; entry 3
    db $E8, $10, $2E, $00 ; entry 4
    db $E8, $F8, $2B, $00 ; entry 5
    db $E0, $E8, $22, $00 ; entry 6
    db $E0, $F0, $23, $00 ; entry 7
    db $E0, $F8, $24, $00 ; entry 8
    db $E0, $00, $25, $00 ; entry 9
    db $E0, $08, $26, $00 ; entry 10
    db $E0, $10, $27, $00 ; entry 11
    db $DB, $18, $28, $00 ; entry 12
    db $DB, $20, $29, $00 ; entry 13
    db $D8, $E8, $21, $00 ; entry 14
    db $D8, $F0, $2F, $00 ; entry 15
    db $D8, $F8, $1D, $00 ; entry 16
    db $D8, $00, $1E, $00 ; entry 17
    db $D8, $08, $1F, $00 ; entry 18
    db $F0, $10, $22, $60 ; entry 19
    db $F0, $08, $23, $60 ; entry 20
    db $F0, $00, $24, $60 ; entry 21
    db $F0, $F8, $25, $60 ; entry 22
    db $F0, $F0, $26, $60 ; entry 23
    db $F0, $E8, $27, $60 ; entry 24
    db $F8, $10, $21, $60 ; entry 25
    db $F8, $08, $2F, $60 ; entry 26
    db $F8, $00, $1D, $60 ; entry 27
    db $F8, $F0, $1F, $60 ; entry 28
    db $F5, $E0, $28, $60 ; entry 29
    db $F5, $D8, $29, $60 ; entry 30
    db $F8, $F8, $1E, $60 ; entry 31
    db $D0, $00, $20, $00 ; entry 32
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3E_4024Set08; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set08Frame6::
Data_03E_58C3:: ; heuristic: meta-sprite frame; C0
    db $E0, $F0, $15, $00 ; entry 0
    db $E0, $F8, $16, $00 ; entry 1
    db $E0, $00, $17, $00 ; entry 2
    db $E0, $08, $18, $00 ; entry 3
    db $D8, $F5, $11, $00 ; entry 4
    db $D8, $FD, $12, $00 ; entry 5
    db $E8, $08, $15, $60 ; entry 6
    db $E8, $00, $16, $60 ; entry 7
    db $E8, $F8, $17, $60 ; entry 8
    db $E8, $F0, $18, $60 ; entry 9
    db $F0, $03, $11, $60 ; entry 10
    db $F0, $FB, $12, $60 ; entry 11
    db $E0, $E8, $0F, $40 ; entry 12
    db $D8, $E7, $0E, $20 ; entry 13
    db $D8, $DF, $0F, $20 ; entry 14
    db $E0, $E0, $0E, $40 ; entry 15
    db $D0, $E7, $0B, $20 ; entry 16
    db $D0, $DF, $0C, $20 ; entry 17
    db $D8, $D8, $10, $20 ; entry 18
    db $E0, $D8, $0D, $40 ; entry 19
    db $F0, $EB, $07, $00 ; entry 20
    db $F0, $F3, $08, $00 ; entry 21
    db $F8, $EB, $09, $00 ; entry 22
    db $F8, $F3, $0A, $00 ; entry 23
    db $E0, $21, $0F, $40 ; entry 24
    db $E0, $29, $10, $40 ; entry 25
    db $D8, $20, $0E, $20 ; entry 26
    db $D8, $18, $0F, $20 ; entry 27
    db $D8, $10, $10, $20 ; entry 28
    db $D8, $28, $0D, $20 ; entry 29
    db $D0, $18, $0C, $20 ; entry 30
    db $D0, $20, $0B, $20 ; entry 31
    db $E0, $19, $0E, $40 ; entry 32
    db $E0, $11, $0D, $40 ; entry 33
    db $F0, $20, $07, $60 ; entry 34
    db $F0, $18, $08, $60 ; entry 35
    db $E8, $20, $09, $60 ; entry 36
    db $E8, $18, $0A, $60 ; entry 37
    db $E8, $E0, $0B, $40 ; entry 38
    db $E8, $E8, $0C, $40 ; entry 39
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3E_4024Set08; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set08Frame7::
Data_03E_5964:: ; heuristic: meta-sprite frame; C0
    db $E8, $08, $2D, $00 ; entry 0
    db $E8, $10, $2E, $00 ; entry 1
    db $E8, $F8, $2C, $20 ; entry 2
    db $E8, $F0, $2D, $20 ; entry 3
    db $E8, $E8, $2E, $20 ; entry 4
    db $E8, $00, $2B, $20 ; entry 5
    db $E0, $10, $22, $20 ; entry 6
    db $E0, $08, $23, $20 ; entry 7
    db $E0, $00, $24, $20 ; entry 8
    db $E0, $F8, $25, $20 ; entry 9
    db $E0, $F0, $26, $20 ; entry 10
    db $E0, $E8, $27, $20 ; entry 11
    db $DB, $E0, $28, $20 ; entry 12
    db $DB, $D8, $29, $20 ; entry 13
    db $D8, $10, $21, $20 ; entry 14
    db $D8, $08, $2F, $20 ; entry 15
    db $D8, $00, $1D, $20 ; entry 16
    db $D8, $F8, $1E, $20 ; entry 17
    db $D8, $F0, $1F, $20 ; entry 18
    db $F0, $E8, $22, $40 ; entry 19
    db $F0, $F0, $23, $40 ; entry 20
    db $F0, $F8, $24, $40 ; entry 21
    db $F0, $00, $25, $40 ; entry 22
    db $F0, $08, $26, $40 ; entry 23
    db $F0, $10, $27, $40 ; entry 24
    db $F8, $E8, $21, $40 ; entry 25
    db $F8, $F0, $2F, $40 ; entry 26
    db $F8, $F8, $1D, $40 ; entry 27
    db $F8, $08, $1F, $40 ; entry 28
    db $F5, $18, $28, $40 ; entry 29
    db $F5, $20, $29, $40 ; entry 30
    db $F8, $00, $1E, $40 ; entry 31
    db $D0, $F8, $20, $20 ; entry 32
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites3E_4024Set08; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set08Frame8::
Data_03E_59E9:: ; heuristic: meta-sprite frame; C0
    db $E0, $29, $0F, $00 ; entry 0
    db $E0, $31, $10, $00 ; entry 1
    db $E8, $28, $0E, $60 ; entry 2
    db $E8, $20, $0F, $60 ; entry 3
    db $E8, $18, $10, $60 ; entry 4
    db $E8, $30, $0D, $60 ; entry 5
    db $F0, $20, $0C, $60 ; entry 6
    db $E0, $21, $0E, $00 ; entry 7
    db $E0, $19, $0D, $00 ; entry 8
    db $E5, $FE, $08, $20 ; entry 9
    db $ED, $06, $09, $20 ; entry 10
    db $ED, $FE, $0A, $20 ; entry 11
    db $D0, $10, $07, $20 ; entry 12
    db $D0, $08, $08, $20 ; entry 13
    db $D8, $10, $09, $20 ; entry 14
    db $D8, $08, $0A, $20 ; entry 15
    db $F0, $28, $09, $20 ; entry 16
    db $E5, $06, $07, $20 ; entry 17
    db $E8, $EA, $0F, $20 ; entry 18
    db $E8, $E2, $10, $20 ; entry 19
    db $F0, $EB, $0E, $40 ; entry 20
    db $F0, $F3, $0F, $40 ; entry 21
    db $F0, $FB, $10, $40 ; entry 22
    db $F0, $E3, $0D, $40 ; entry 23
    db $E8, $F2, $0E, $20 ; entry 24
    db $E8, $FA, $0D, $20 ; entry 25
    db $F8, $EB, $0B, $40 ; entry 26
    db $F8, $F3, $0C, $40 ; entry 27
    db $E0, $F2, $0B, $20 ; entry 28
    db $E0, $EA, $0C, $20 ; entry 29
    db $D0, $30, $07, $20 ; entry 30
    db $D0, $28, $08, $20 ; entry 31
    db $D8, $30, $09, $20 ; entry 32
    db $D8, $28, $0A, $20 ; entry 33
    db $D8, $22, $0C, $20 ; entry 34
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites3E_4024Set08; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set08Frame9::
Data_03E_5A76:: ; heuristic: meta-sprite frame; C0
    db $D4, $2E, $01, $00 ; entry 0
    db $DC, $26, $02, $00 ; entry 1
    db $DC, $2E, $03, $00 ; entry 2
    db $D4, $26, $00, $00 ; entry 3
    db $E7, $15, $01, $20 ; entry 4
    db $EF, $15, $03, $20 ; entry 5
    db $EF, $25, $02, $20 ; entry 6
    db $E7, $1D, $04, $00 ; entry 7
    db $EF, $1D, $05, $00 ; entry 8
    db $E7, $25, $01, $00 ; entry 9
    db $DB, $0D, $00, $20 ; entry 10
    db $DB, $05, $01, $20 ; entry 11
    db $E3, $0D, $02, $20 ; entry 12
    db $E3, $05, $03, $20 ; entry 13
    db $F7, $2B, $02, $00 ; entry 14
    db $F7, $33, $03, $00 ; entry 15
    db $EF, $2B, $00, $00 ; entry 16
    db $EF, $33, $01, $00 ; entry 17
    db $F0, $FF, $00, $00 ; entry 18
    db $F0, $07, $01, $00 ; entry 19
    db $F8, $FF, $02, $00 ; entry 20
    db $F8, $07, $03, $00 ; entry 21
    db $E3, $40, $07, $20 ; entry 22
    db $E3, $38, $08, $20 ; entry 23
    db $EB, $40, $09, $20 ; entry 24
    db $EB, $38, $0A, $20 ; entry 25
    db $DB, $1D, $07, $20 ; entry 26
    db $DB, $15, $08, $20 ; entry 27
    db $E3, $1D, $09, $20 ; entry 28
    db $E3, $15, $0A, $20 ; entry 29
    db $80 ; end

; E-0147 (derived: frame 10 of MetaSprites3E_4024Set08; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set08Frame10::
Data_03E_5AEF:: ; heuristic: meta-sprite frame; C0
    db $EC, $38, $0E, $40 ; entry 0
    db $EC, $40, $0F, $40 ; entry 1
    db $EC, $48, $10, $40 ; entry 2
    db $EC, $30, $0D, $40 ; entry 3
    db $F4, $40, $0C, $40 ; entry 4
    db $F4, $38, $09, $00 ; entry 5
    db $F4, $1D, $07, $40 ; entry 6
    db $F4, $25, $08, $40 ; entry 7
    db $EC, $1D, $09, $40 ; entry 8
    db $EC, $25, $0A, $40 ; entry 9
    db $F0, $08, $07, $00 ; entry 10
    db $F0, $10, $08, $00 ; entry 11
    db $F8, $08, $09, $00 ; entry 12
    db $F8, $10, $0A, $00 ; entry 13
    db $EC, $17, $11, $60 ; entry 14
    db $EC, $0F, $12, $60 ; entry 15
    db $D4, $08, $11, $00 ; entry 16
    db $D4, $10, $12, $00 ; entry 17
    db $D4, $1C, $14, $00 ; entry 18
    db $DC, $04, $15, $00 ; entry 19
    db $DC, $0C, $16, $00 ; entry 20
    db $DC, $14, $17, $00 ; entry 21
    db $DC, $1C, $18, $00 ; entry 22
    db $E4, $1C, $15, $60 ; entry 23
    db $E4, $14, $16, $60 ; entry 24
    db $E4, $0C, $17, $60 ; entry 25
    db $E4, $04, $18, $60 ; entry 26
    db $DC, $2C, $07, $20 ; entry 27
    db $DC, $24, $08, $20 ; entry 28
    db $E4, $2C, $09, $20 ; entry 29
    db $E4, $24, $0A, $20 ; entry 30
    db $E4, $3F, $0E, $20 ; entry 31
    db $E4, $37, $0F, $20 ; entry 32
    db $E4, $47, $0D, $20 ; entry 33
    db $DC, $3F, $0B, $20 ; entry 34
    db $DC, $37, $0C, $20 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 11 of MetaSprites3E_4024Set08; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set08Frame11::
Data_03E_5B80:: ; heuristic: meta-sprite frame; C0
    db $D8, $0C, $02, $00 ; entry 0
    db $D8, $14, $03, $00 ; entry 1
    db $D0, $0C, $00, $00 ; entry 2
    db $E3, $25, $01, $00 ; entry 3
    db $EB, $25, $03, $00 ; entry 4
    db $EB, $15, $02, $00 ; entry 5
    db $E3, $1D, $04, $20 ; entry 6
    db $EB, $1D, $05, $20 ; entry 7
    db $E3, $15, $01, $20 ; entry 8
    db $F3, $0F, $02, $20 ; entry 9
    db $F3, $07, $03, $20 ; entry 10
    db $EB, $07, $01, $20 ; entry 11
    db $F0, $2A, $07, $20 ; entry 12
    db $F0, $22, $08, $20 ; entry 13
    db $F8, $2A, $09, $20 ; entry 14
    db $F8, $22, $0A, $20 ; entry 15
    db $D3, $31, $00, $00 ; entry 16
    db $D3, $39, $01, $00 ; entry 17
    db $DB, $31, $02, $00 ; entry 18
    db $DB, $39, $03, $00 ; entry 19
    db $D7, $24, $07, $20 ; entry 20
    db $D7, $1C, $08, $20 ; entry 21
    db $DF, $24, $09, $20 ; entry 22
    db $DF, $1C, $0A, $20 ; entry 23
    db $EA, $2D, $02, $00 ; entry 24
    db $E2, $2D, $2F, $00 ; entry 25
    db $E2, $35, $04, $00 ; entry 26
    db $EA, $35, $2D, $40 ; entry 27
    db $E8, $3D, $05, $00 ; entry 28
    db $E0, $3D, $04, $00 ; entry 29
    db $E8, $45, $2E, $40 ; entry 30
    db $EB, $0F, $0C, $00 ; entry 31
    db $D0, $14, $07, $20 ; entry 32
    db $E0, $45, $28, $00 ; entry 33
    db $80 ; end

; E-0147 (derived: frame 12 of MetaSprites3E_4024Set08; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set08Frame12::
Data_03E_5C09:: ; heuristic: meta-sprite frame; C0
    db $DC, $40, $0E, $00 ; entry 0
    db $DC, $48, $0F, $00 ; entry 1
    db $DC, $38, $0D, $00 ; entry 2
    db $D4, $48, $0C, $00 ; entry 3
    db $E4, $47, $0E, $60 ; entry 4
    db $E4, $3F, $0F, $60 ; entry 5
    db $EC, $47, $0B, $60 ; entry 6
    db $EC, $3F, $0C, $60 ; entry 7
    db $D4, $40, $0B, $00 ; entry 8
    db $E0, $30, $11, $20 ; entry 9
    db $E0, $28, $12, $20 ; entry 10
    db $F8, $21, $11, $40 ; entry 11
    db $F8, $29, $12, $40 ; entry 12
    db $F8, $35, $14, $40 ; entry 13
    db $F0, $1D, $15, $40 ; entry 14
    db $F0, $25, $16, $40 ; entry 15
    db $F0, $2D, $17, $40 ; entry 16
    db $F0, $35, $18, $40 ; entry 17
    db $E8, $35, $15, $20 ; entry 18
    db $E8, $2D, $16, $20 ; entry 19
    db $E8, $25, $17, $20 ; entry 20
    db $E8, $1D, $18, $20 ; entry 21
    db $D8, $24, $07, $40 ; entry 22
    db $D8, $2C, $08, $40 ; entry 23
    db $D0, $24, $09, $40 ; entry 24
    db $D0, $2C, $0A, $40 ; entry 25
    db $F0, $0D, $07, $40 ; entry 26
    db $F0, $15, $08, $40 ; entry 27
    db $E8, $0D, $09, $40 ; entry 28
    db $E8, $15, $0A, $40 ; entry 29
    db $F0, $47, $07, $20 ; entry 30
    db $F0, $3F, $08, $20 ; entry 31
    db $F8, $47, $09, $20 ; entry 32
    db $F8, $3F, $0A, $20 ; entry 33
    db $80 ; end

; E-0147 (derived: frame 13 of MetaSprites3E_4024Set08; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set08Frame13::
Data_03E_5C92:: ; heuristic: meta-sprite frame; C0
    db $D0, $43, $11, $20 ; entry 0
    db $D0, $3B, $12, $20 ; entry 1
    db $E8, $34, $11, $40 ; entry 2
    db $E8, $3C, $12, $40 ; entry 3
    db $E8, $48, $14, $40 ; entry 4
    db $E0, $30, $15, $40 ; entry 5
    db $E0, $38, $16, $40 ; entry 6
    db $E0, $40, $17, $40 ; entry 7
    db $E0, $48, $18, $40 ; entry 8
    db $D8, $48, $15, $20 ; entry 9
    db $D8, $40, $16, $20 ; entry 10
    db $D8, $38, $17, $20 ; entry 11
    db $D8, $30, $18, $20 ; entry 12
    db $E1, $24, $0E, $00 ; entry 13
    db $E1, $2C, $0F, $00 ; entry 14
    db $E9, $2B, $0E, $60 ; entry 15
    db $E9, $23, $0F, $60 ; entry 16
    db $F1, $2B, $0B, $60 ; entry 17
    db $F1, $23, $0C, $60 ; entry 18
    db $D9, $24, $0B, $00 ; entry 19
    db $E0, $1C, $0D, $00 ; entry 20
    db $E0, $18, $07, $20 ; entry 21
    db $E0, $10, $08, $20 ; entry 22
    db $E8, $18, $09, $20 ; entry 23
    db $E8, $10, $0A, $20 ; entry 24
    db $D0, $28, $07, $40 ; entry 25
    db $D0, $30, $08, $40 ; entry 26
    db $F8, $2A, $09, $40 ; entry 27
    db $F8, $32, $0A, $40 ; entry 28
    db $80 ; end

; E-0147 (derived: frame 14 of MetaSprites3E_4024Set08; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set08Frame14::
Data_03E_5D07:: ; heuristic: meta-sprite frame; C0
    db $E0, $D0, $0F, $20 ; entry 0
    db $E0, $C8, $10, $20 ; entry 1
    db $E8, $D1, $0E, $40 ; entry 2
    db $E8, $D9, $0F, $40 ; entry 3
    db $E8, $E1, $10, $40 ; entry 4
    db $E8, $C9, $0D, $40 ; entry 5
    db $F0, $D9, $0C, $40 ; entry 6
    db $E0, $D8, $0E, $20 ; entry 7
    db $E0, $E0, $0D, $20 ; entry 8
    db $E5, $FB, $08, $00 ; entry 9
    db $ED, $F3, $09, $00 ; entry 10
    db $ED, $FB, $0A, $00 ; entry 11
    db $D0, $E9, $07, $00 ; entry 12
    db $D0, $F1, $08, $00 ; entry 13
    db $D8, $E9, $09, $00 ; entry 14
    db $D8, $F1, $0A, $00 ; entry 15
    db $F0, $D1, $09, $00 ; entry 16
    db $E5, $F3, $07, $00 ; entry 17
    db $E8, $0F, $0F, $00 ; entry 18
    db $E8, $17, $10, $00 ; entry 19
    db $F0, $0E, $0E, $60 ; entry 20
    db $F0, $06, $0F, $60 ; entry 21
    db $F0, $FE, $10, $60 ; entry 22
    db $F0, $16, $0D, $60 ; entry 23
    db $E8, $07, $0E, $00 ; entry 24
    db $E8, $FF, $0D, $00 ; entry 25
    db $F8, $0E, $0B, $60 ; entry 26
    db $F8, $06, $0C, $60 ; entry 27
    db $E0, $07, $0B, $00 ; entry 28
    db $E0, $0F, $0C, $00 ; entry 29
    db $D0, $C9, $07, $00 ; entry 30
    db $D0, $D1, $08, $00 ; entry 31
    db $D8, $C9, $09, $00 ; entry 32
    db $D8, $D1, $0A, $00 ; entry 33
    db $D8, $D7, $0C, $00 ; entry 34
    db $80 ; end

; E-0147 (derived: frame 15 of MetaSprites3E_4024Set08; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set08Frame15::
Data_03E_5D94:: ; heuristic: meta-sprite frame; C0
    db $D4, $CA, $01, $20 ; entry 0
    db $DC, $D2, $02, $20 ; entry 1
    db $DC, $CA, $03, $20 ; entry 2
    db $D4, $D2, $00, $20 ; entry 3
    db $E7, $E3, $01, $00 ; entry 4
    db $EF, $E3, $03, $00 ; entry 5
    db $EF, $D3, $02, $00 ; entry 6
    db $E7, $DB, $04, $20 ; entry 7
    db $EF, $DB, $05, $20 ; entry 8
    db $E7, $D3, $01, $20 ; entry 9
    db $DB, $EB, $00, $00 ; entry 10
    db $DB, $F3, $01, $00 ; entry 11
    db $E3, $EB, $02, $00 ; entry 12
    db $E3, $F3, $03, $00 ; entry 13
    db $F7, $CD, $02, $20 ; entry 14
    db $F7, $C5, $03, $20 ; entry 15
    db $EF, $CD, $00, $20 ; entry 16
    db $EF, $C5, $01, $20 ; entry 17
    db $F0, $F9, $00, $20 ; entry 18
    db $F0, $F1, $01, $20 ; entry 19
    db $F8, $F9, $02, $20 ; entry 20
    db $F8, $F1, $03, $20 ; entry 21
    db $E3, $B8, $07, $00 ; entry 22
    db $E3, $C0, $08, $00 ; entry 23
    db $EB, $B8, $09, $00 ; entry 24
    db $EB, $C0, $0A, $00 ; entry 25
    db $DB, $DB, $07, $00 ; entry 26
    db $DB, $E3, $08, $00 ; entry 27
    db $E3, $DB, $09, $00 ; entry 28
    db $E3, $E3, $0A, $00 ; entry 29
    db $80 ; end

; E-0147 (derived: frame 16 of MetaSprites3E_4024Set08; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set08Frame16::
Data_03E_5E0D:: ; heuristic: meta-sprite frame; C0
    db $EC, $C2, $0E, $60 ; entry 0
    db $EC, $BA, $0F, $60 ; entry 1
    db $EC, $B2, $10, $60 ; entry 2
    db $EC, $CA, $0D, $60 ; entry 3
    db $F4, $BA, $0C, $60 ; entry 4
    db $F4, $C2, $09, $20 ; entry 5
    db $F4, $DD, $07, $60 ; entry 6
    db $F4, $D5, $08, $60 ; entry 7
    db $EC, $DD, $09, $60 ; entry 8
    db $EC, $D5, $0A, $60 ; entry 9
    db $F0, $F2, $07, $20 ; entry 10
    db $F0, $EA, $08, $20 ; entry 11
    db $F8, $F2, $09, $20 ; entry 12
    db $F8, $EA, $0A, $20 ; entry 13
    db $EC, $E3, $11, $40 ; entry 14
    db $EC, $EB, $12, $40 ; entry 15
    db $D4, $F2, $11, $20 ; entry 16
    db $D4, $EA, $12, $20 ; entry 17
    db $D4, $DE, $14, $20 ; entry 18
    db $DC, $F6, $15, $20 ; entry 19
    db $DC, $EE, $16, $20 ; entry 20
    db $DC, $E6, $17, $20 ; entry 21
    db $DC, $DE, $18, $20 ; entry 22
    db $E4, $DE, $15, $40 ; entry 23
    db $E4, $E6, $16, $40 ; entry 24
    db $E4, $EE, $17, $40 ; entry 25
    db $E4, $F6, $18, $40 ; entry 26
    db $DC, $CE, $07, $00 ; entry 27
    db $DC, $D6, $08, $00 ; entry 28
    db $E4, $CE, $09, $00 ; entry 29
    db $E4, $D6, $0A, $00 ; entry 30
    db $E4, $BB, $0E, $00 ; entry 31
    db $E4, $C3, $0F, $00 ; entry 32
    db $E4, $B3, $0D, $00 ; entry 33
    db $DC, $BB, $0B, $00 ; entry 34
    db $DC, $C3, $0C, $00 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 17 of MetaSprites3E_4024Set08; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set08Frame17::
Data_03E_5E9E:: ; heuristic: meta-sprite frame; C0
    db $D8, $EC, $02, $20 ; entry 0
    db $D8, $E4, $03, $20 ; entry 1
    db $D0, $EC, $00, $20 ; entry 2
    db $E3, $D3, $01, $20 ; entry 3
    db $EB, $D3, $03, $20 ; entry 4
    db $EB, $E3, $02, $20 ; entry 5
    db $E3, $DB, $04, $00 ; entry 6
    db $EB, $DB, $05, $00 ; entry 7
    db $E3, $E3, $01, $00 ; entry 8
    db $F3, $E9, $02, $00 ; entry 9
    db $F3, $F1, $03, $00 ; entry 10
    db $EB, $F1, $01, $00 ; entry 11
    db $F0, $CE, $07, $00 ; entry 12
    db $F0, $D6, $08, $00 ; entry 13
    db $F8, $CE, $09, $00 ; entry 14
    db $F8, $D6, $0A, $00 ; entry 15
    db $D3, $C7, $00, $20 ; entry 16
    db $D3, $BF, $01, $20 ; entry 17
    db $DB, $C7, $02, $20 ; entry 18
    db $DB, $BF, $03, $20 ; entry 19
    db $D7, $D4, $07, $00 ; entry 20
    db $D7, $DC, $08, $00 ; entry 21
    db $DF, $D4, $09, $00 ; entry 22
    db $DF, $DC, $0A, $00 ; entry 23
    db $EA, $CB, $02, $20 ; entry 24
    db $E2, $CB, $2F, $20 ; entry 25
    db $E2, $C3, $04, $20 ; entry 26
    db $EA, $C3, $2D, $60 ; entry 27
    db $E8, $BB, $05, $20 ; entry 28
    db $E0, $BB, $04, $20 ; entry 29
    db $E8, $B3, $2E, $60 ; entry 30
    db $EB, $E9, $0C, $20 ; entry 31
    db $D0, $E4, $07, $00 ; entry 32
    db $E0, $B3, $28, $20 ; entry 33
    db $80 ; end

; E-0147 (derived: frame 18 of MetaSprites3E_4024Set08; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set08Frame18::
Data_03E_5F27:: ; heuristic: meta-sprite frame; C0
    db $DC, $B8, $0E, $20 ; entry 0
    db $DC, $B0, $0F, $20 ; entry 1
    db $DC, $C0, $0D, $20 ; entry 2
    db $D4, $B0, $0C, $20 ; entry 3
    db $E4, $B1, $0E, $40 ; entry 4
    db $E4, $B9, $0F, $40 ; entry 5
    db $EC, $B1, $0B, $40 ; entry 6
    db $EC, $B9, $0C, $40 ; entry 7
    db $D4, $B8, $0B, $20 ; entry 8
    db $E0, $C8, $11, $00 ; entry 9
    db $E0, $D0, $12, $00 ; entry 10
    db $F8, $D7, $11, $60 ; entry 11
    db $F8, $CF, $12, $60 ; entry 12
    db $F8, $C3, $14, $60 ; entry 13
    db $F0, $DB, $15, $60 ; entry 14
    db $F0, $D3, $16, $60 ; entry 15
    db $F0, $CB, $17, $60 ; entry 16
    db $F0, $C3, $18, $60 ; entry 17
    db $E8, $C3, $15, $00 ; entry 18
    db $E8, $CB, $16, $00 ; entry 19
    db $E8, $D3, $17, $00 ; entry 20
    db $E8, $DB, $18, $00 ; entry 21
    db $D8, $D4, $07, $60 ; entry 22
    db $D8, $CC, $08, $60 ; entry 23
    db $D0, $D4, $09, $60 ; entry 24
    db $D0, $CC, $0A, $60 ; entry 25
    db $F0, $EB, $07, $60 ; entry 26
    db $F0, $E3, $08, $60 ; entry 27
    db $E8, $EB, $09, $60 ; entry 28
    db $E8, $E3, $0A, $60 ; entry 29
    db $F0, $B1, $07, $00 ; entry 30
    db $F0, $B9, $08, $00 ; entry 31
    db $F8, $B1, $09, $00 ; entry 32
    db $F8, $B9, $0A, $00 ; entry 33
    db $80 ; end

; E-0147 (derived: frame 19 of MetaSprites3E_4024Set08; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set08Frame19::
Data_03E_5FB0:: ; heuristic: meta-sprite frame; C0
    db $D0, $B5, $11, $00 ; entry 0
    db $D0, $BD, $12, $00 ; entry 1
    db $E8, $C4, $11, $60 ; entry 2
    db $E8, $BC, $12, $60 ; entry 3
    db $E8, $B0, $14, $60 ; entry 4
    db $E0, $C8, $15, $60 ; entry 5
    db $E0, $C0, $16, $60 ; entry 6
    db $E0, $B8, $17, $60 ; entry 7
    db $E0, $B0, $18, $60 ; entry 8
    db $D8, $B0, $15, $00 ; entry 9
    db $D8, $B8, $16, $00 ; entry 10
    db $D8, $C0, $17, $00 ; entry 11
    db $D8, $C8, $18, $00 ; entry 12
    db $E1, $D4, $0E, $20 ; entry 13
    db $E1, $CC, $0F, $20 ; entry 14
    db $E9, $CD, $0E, $40 ; entry 15
    db $E9, $D5, $0F, $40 ; entry 16
    db $F1, $CD, $0B, $40 ; entry 17
    db $F1, $D5, $0C, $40 ; entry 18
    db $D9, $D4, $0B, $20 ; entry 19
    db $E0, $DC, $0D, $20 ; entry 20
    db $E0, $E0, $07, $00 ; entry 21
Data_03E_6008:: ; heuristic: label inside a table; C0
    db $E0, $E8, $08, $00 ; entry 22
Data_03E_600C:: ; heuristic: label inside a table; C0
    db $E8, $E0, $09, $00 ; entry 23
    db $E8, $E8, $0A, $00 ; entry 24
    db $D0, $D0, $07, $60 ; entry 25
    db $D0, $C8, $08, $60 ; entry 26
    db $F8, $CE, $09, $60 ; entry 27
    db $F8, $C6, $0A, $60 ; entry 28
    db $80 ; end

; E-0147 (derived: frame 20 of MetaSprites3E_4024Set08; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set08Frame20::
    db $80 ; end

; E-0147 (derived: meta-sprite set 9 of MetaSprites3E_4024Table: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3E_4024Set09::
Data_03E_6026:: ; heuristic: meta-sprite set; C0
    dw MetaSprites3E_4024Set09Frame0 ; entry 0
    dw MetaSprites3E_4024Set09Frame1 ; entry 1
    dw MetaSprites3E_4024Set09Frame2 ; entry 2
    dw MetaSprites3E_4024Set09Frame3 ; entry 3
    dw MetaSprites3E_4024Set09Frame4 ; entry 4
    dw MetaSprites3E_4024Set09Frame5 ; entry 5
    dw MetaSprites3E_4024Set09Frame6 ; entry 6
    dw MetaSprites3E_4024Set09Frame7 ; entry 7
    dw MetaSprites3E_4024Set09Frame8 ; entry 8
    dw MetaSprites3E_4024Set09Frame9 ; entry 9
    dw MetaSprites3E_4024Set09Frame10 ; entry 10
    dw MetaSprites3E_4024Set09Frame11 ; entry 11
    dw MetaSprites3E_4024Set09Frame12 ; entry 12
    dw MetaSprites3E_4024Set09Frame13 ; entry 13
    dw MetaSprites3E_4024Set09Frame13 ; entry 14
    dw MetaSprites3E_4024Set09Frame13 ; entry 15
    dw MetaSprites3E_4024Set09Frame13 ; entry 16
    dw MetaSprites3E_4024Set09Frame13 ; entry 17
    dw MetaSprites3E_4024Set09Frame13 ; entry 18
    dw MetaSprites3E_4024Set09Frame13 ; entry 19
    dw MetaSprites3E_4024Set09Frame13 ; entry 20
    dw MetaSprites3E_4024Set09Frame13 ; entry 21
    dw MetaSprites3E_4024Set09Frame13 ; entry 22
    dw MetaSprites3E_4024Set09Frame13 ; entry 23
    dw MetaSprites3E_4024Set09Frame13 ; entry 24
    dw MetaSprites3E_4024Set09Frame13 ; entry 25
    dw MetaSprites3E_4024Set09Frame13 ; entry 26
    dw MetaSprites3E_4024Set09Frame13 ; entry 27
    dw MetaSprites3E_4024Set09Frame13 ; entry 28
    dw MetaSprites3E_4024Set09Frame13 ; entry 29
    dw MetaSprites3E_4024Set09Frame13 ; entry 30
    dw MetaSprites3E_4024Set09Frame13 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3E_4024Set09; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set09Frame0::
Data_03E_6066:: ; heuristic: meta-sprite frame; C0
    db $E6, $FC, $02, $00 ; entry 0
    db $E6, $04, $03, $00 ; entry 1
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3E_4024Set09; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set09Frame1::
Data_03E_606F:: ; heuristic: meta-sprite frame; C0
    db $EE, $F4, $02, $00 ; entry 0
    db $EE, $FC, $03, $00 ; entry 1
    db $E8, $FC, $00, $00 ; entry 2
    db $E8, $04, $01, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3E_4024Set09; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set09Frame2::
Data_03E_6080:: ; heuristic: meta-sprite frame; C0
    db $F0, $F4, $00, $00 ; entry 0
    db $F0, $FC, $01, $00 ; entry 1
    db $DE, $F4, $00, $00 ; entry 2
    db $DE, $FC, $01, $00 ; entry 3
    db $E5, $F5, $0C, $00 ; entry 4
    db $E5, $FD, $0D, $00 ; entry 5
    db $E5, $05, $0E, $00 ; entry 6
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3E_4024Set09; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set09Frame3::
Data_03E_609D:: ; heuristic: meta-sprite frame; C0
    db $DC, $F4, $02, $00 ; entry 0
    db $DC, $FC, $03, $00 ; entry 1
    db $EE, $F4, $00, $00 ; entry 2
    db $EE, $FC, $01, $00 ; entry 3
    db $E3, $F5, $04, $00 ; entry 4
    db $E3, $FD, $05, $00 ; entry 5
    db $E3, $05, $06, $00 ; entry 6
    db $EA, $ED, $07, $00 ; entry 7
    db $EB, $F5, $08, $00 ; entry 8
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3E_4024Set09; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set09Frame4::
Data_03E_60C2:: ; heuristic: meta-sprite frame; C0
    db $DE, $F4, $00, $00 ; entry 0
    db $DE, $FC, $01, $00 ; entry 1
    db $F0, $F0, $0C, $00 ; entry 2
    db $F0, $F8, $0D, $00 ; entry 3
    db $F0, $00, $0E, $00 ; entry 4
    db $E2, $F6, $09, $00 ; entry 5
    db $E2, $FE, $0A, $00 ; entry 6
    db $E2, $06, $0B, $00 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3E_4024Set09; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set09Frame5::
Data_03E_60E3:: ; heuristic: meta-sprite frame; C0
    db $E8, $FC, $00, $00 ; entry 0
    db $E8, $04, $01, $00 ; entry 1
    db $DD, $F0, $0C, $00 ; entry 2
    db $DD, $F8, $0D, $00 ; entry 3
    db $DD, $00, $0E, $00 ; entry 4
    db $F0, $F0, $04, $00 ; entry 5
    db $F0, $F8, $05, $00 ; entry 6
    db $F0, $00, $06, $00 ; entry 7
    db $F8, $F0, $08, $00 ; entry 8
    db $F7, $E8, $07, $00 ; entry 9
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3E_4024Set09; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set09Frame6::
Data_03E_610C:: ; heuristic: meta-sprite frame; C0
    db $DA, $F1, $04, $00 ; entry 0
    db $DA, $F9, $05, $00 ; entry 1
    db $DA, $01, $06, $00 ; entry 2
    db $E2, $F1, $08, $00 ; entry 3
    db $E1, $E9, $07, $00 ; entry 4
    db $F2, $EE, $0C, $00 ; entry 5
    db $F2, $F6, $0D, $00 ; entry 6
    db $F2, $FE, $0E, $00 ; entry 7
    db $E6, $F8, $09, $00 ; entry 8
    db $E6, $00, $0A, $00 ; entry 9
    db $E6, $08, $0B, $00 ; entry 10
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3E_4024Set09; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set09Frame7::
Data_03E_6139:: ; heuristic: meta-sprite frame; C0
    db $DB, $F2, $09, $00 ; entry 0
    db $DB, $FA, $0A, $00 ; entry 1
    db $DB, $02, $0B, $00 ; entry 2
    db $E6, $F8, $04, $00 ; entry 3
    db $E6, $00, $05, $00 ; entry 4
    db $E6, $08, $06, $00 ; entry 5
    db $EE, $F8, $08, $00 ; entry 6
    db $ED, $F0, $07, $00 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites3E_4024Set09; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set09Frame8::
Data_03E_615A:: ; heuristic: meta-sprite frame; C0
    db $E9, $F6, $0C, $00 ; entry 0
    db $E9, $FE, $0D, $00 ; entry 1
    db $E9, $06, $0E, $00 ; entry 2
    db $E0, $F8, $00, $00 ; entry 3
    db $E0, $00, $01, $00 ; entry 4
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites3E_4024Set09; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set09Frame9::
Data_03E_616F:: ; heuristic: meta-sprite frame; C0
    db $E8, $FC, $00, $00 ; entry 0
    db $E8, $04, $01, $00 ; entry 1
    db $E4, $F3, $0C, $00 ; entry 2
    db $E4, $FB, $0D, $00 ; entry 3
    db $E4, $03, $0E, $00 ; entry 4
    db $F0, $F4, $04, $00 ; entry 5
    db $F0, $FC, $05, $00 ; entry 6
    db $F0, $04, $06, $00 ; entry 7
    db $F8, $F4, $08, $00 ; entry 8
    db $F7, $EC, $07, $00 ; entry 9
    db $80 ; end

; E-0147 (derived: frame 10 of MetaSprites3E_4024Set09; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set09Frame10::
Data_03E_6198:: ; heuristic: meta-sprite frame; C0
    db $EE, $F3, $0C, $00 ; entry 0
    db $EE, $FB, $0D, $00 ; entry 1
    db $EE, $03, $0E, $00 ; entry 2
    db $F5, $F2, $09, $00 ; entry 3
    db $F5, $FA, $0A, $00 ; entry 4
    db $F5, $02, $0B, $00 ; entry 5
    db $E5, $F4, $04, $00 ; entry 6
    db $E5, $FC, $05, $00 ; entry 7
    db $E5, $04, $06, $00 ; entry 8
    db $ED, $F4, $08, $00 ; entry 9
    db $EC, $EC, $07, $00 ; entry 10
    db $80 ; end

; E-0147 (derived: frame 11 of MetaSprites3E_4024Set09; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set09Frame11::
Data_03E_61C5:: ; heuristic: meta-sprite frame; C0
    db $E4, $F5, $09, $00 ; entry 0
    db $E4, $FD, $0A, $00 ; entry 1
    db $E4, $05, $0B, $00 ; entry 2
    db $EC, $F6, $04, $00 ; entry 3
    db $EC, $FE, $05, $00 ; entry 4
    db $EC, $06, $06, $00 ; entry 5
    db $F4, $F6, $08, $00 ; entry 6
    db $F3, $EE, $07, $00 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 12 of MetaSprites3E_4024Set09; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set09Frame12::
Data_03E_61E6:: ; heuristic: meta-sprite frame; C0
    db $E6, $F3, $0C, $00 ; entry 0
    db $E6, $FB, $0D, $00 ; entry 1
    db $E6, $03, $0E, $00 ; entry 2
    db $F1, $01, $03, $00 ; entry 3
    db $F1, $F9, $02, $00 ; entry 4
    db $80 ; end

; E-0147 (derived: frame 13 of MetaSprites3E_4024Set09; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set09Frame13::
    db $80 ; end

; E-0147 (derived: meta-sprite set 10 of MetaSprites3E_4024Table: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3E_4024Set0A::
Data_03E_61FC:: ; heuristic: meta-sprite set; C0
    dw MetaSprites3E_4024Set0AFrame0 ; entry 0
    dw MetaSprites3E_4024Set0AFrame1 ; entry 1
    dw MetaSprites3E_4024Set0AFrame2 ; entry 2
    dw MetaSprites3E_4024Set0AFrame3 ; entry 3
    dw MetaSprites3E_4024Set0AFrame4 ; entry 4
    dw MetaSprites3E_4024Set0AFrame5 ; entry 5
    dw MetaSprites3E_4024Set0AFrame6 ; entry 6
    dw MetaSprites3E_4024Set0AFrame7 ; entry 7
    dw MetaSprites3E_4024Set0AFrame8 ; entry 8
    dw MetaSprites3E_4024Set0AFrame9 ; entry 9
    dw MetaSprites3E_4024Set0AFrame10 ; entry 10
    dw MetaSprites3E_4024Set0AFrame11 ; entry 11
    dw MetaSprites3E_4024Set0AFrame12 ; entry 12
    dw MetaSprites3E_4024Set0AFrame13 ; entry 13
    dw MetaSprites3E_4024Set0AFrame13 ; entry 14
    dw MetaSprites3E_4024Set0AFrame13 ; entry 15
    dw MetaSprites3E_4024Set0AFrame13 ; entry 16
    dw MetaSprites3E_4024Set0AFrame13 ; entry 17
    dw MetaSprites3E_4024Set0AFrame13 ; entry 18
    dw MetaSprites3E_4024Set0AFrame13 ; entry 19
    dw MetaSprites3E_4024Set0AFrame13 ; entry 20
    dw MetaSprites3E_4024Set0AFrame13 ; entry 21
    dw MetaSprites3E_4024Set0AFrame13 ; entry 22
    dw MetaSprites3E_4024Set0AFrame13 ; entry 23
    dw MetaSprites3E_4024Set0AFrame13 ; entry 24
    dw MetaSprites3E_4024Set0AFrame13 ; entry 25
    dw MetaSprites3E_4024Set0AFrame13 ; entry 26
    dw MetaSprites3E_4024Set0AFrame13 ; entry 27
    dw MetaSprites3E_4024Set0AFrame13 ; entry 28
    dw MetaSprites3E_4024Set0AFrame13 ; entry 29
    dw MetaSprites3E_4024Set0AFrame13 ; entry 30
    dw MetaSprites3E_4024Set0AFrame13 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3E_4024Set0A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0AFrame0::
Data_03E_623C:: ; heuristic: meta-sprite frame; C0
    db $F8, $B0, $1B, $00 ; entry 0
    db $F8, $B8, $1C, $00 ; entry 1
    db $E0, $B0, $0D, $00 ; entry 2
    db $E8, $B0, $11, $00 ; entry 3
    db $F0, $B0, $16, $00 ; entry 4
    db $F8, $BD, $1D, $00 ; entry 5
    db $F0, $B8, $1E, $00 ; entry 6
    db $F8, $C5, $1F, $00 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3E_4024Set0A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0AFrame1::
Data_03E_625D:: ; heuristic: meta-sprite frame; C0
    db $F8, $B0, $1A, $00 ; entry 0
    db $F8, $B8, $1B, $00 ; entry 1
    db $F0, $B0, $15, $00 ; entry 2
    db $F0, $B8, $16, $00 ; entry 3
    db $E0, $AE, $0D, $00 ; entry 4
    db $D8, $AD, $05, $20 ; entry 5
    db $E8, $B0, $0E, $20 ; entry 6
    db $F8, $C0, $1C, $00 ; entry 7
    db $F8, $CC, $1E, $00 ; entry 8
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3E_4024Set0A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0AFrame2::
Data_03E_6282:: ; heuristic: meta-sprite frame; C0
    db $F8, $B0, $07, $00 ; entry 0
    db $F8, $B8, $08, $00 ; entry 1
    db $F8, $C0, $09, $00 ; entry 2
    db $E8, $B0, $19, $00 ; entry 3
    db $E8, $B8, $1A, $00 ; entry 4
    db $F0, $B0, $02, $00 ; entry 5
    db $F0, $B8, $03, $00 ; entry 6
    db $F0, $C0, $04, $00 ; entry 7
    db $D0, $B0, $0C, $00 ; entry 8
    db $D0, $B8, $0D, $00 ; entry 9
    db $D8, $B0, $10, $00 ; entry 10
    db $D8, $B8, $11, $00 ; entry 11
    db $E0, $B0, $15, $00 ; entry 12
    db $E0, $B8, $16, $00 ; entry 13
    db $E8, $C8, $05, $20 ; entry 14
    db $E8, $C0, $06, $20 ; entry 15
    db $F8, $C8, $1F, $00 ; entry 16
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3E_4024Set0A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0AFrame3::
Data_03E_62C7:: ; heuristic: meta-sprite frame; C0
    db $F0, $B4, $00, $00 ; entry 0
    db $F0, $BC, $01, $00 ; entry 1
    db $F0, $C4, $02, $00 ; entry 2
    db $F0, $CC, $03, $00 ; entry 3
    db $F0, $D4, $04, $00 ; entry 4
    db $E8, $B1, $17, $00 ; entry 5
    db $E8, $B9, $18, $00 ; entry 6
    db $E8, $C1, $19, $00 ; entry 7
    db $E8, $C9, $1A, $00 ; entry 8
    db $E8, $D1, $1B, $00 ; entry 9
    db $E8, $D9, $1C, $00 ; entry 10
    db $E0, $B1, $12, $00 ; entry 11
    db $E0, $B9, $13, $00 ; entry 12
    db $E0, $C1, $14, $00 ; entry 13
    db $E0, $C9, $15, $00 ; entry 14
    db $E0, $D1, $16, $00 ; entry 15
    db $F8, $CF, $06, $20 ; entry 16
    db $F8, $C7, $07, $20 ; entry 17
    db $F8, $BF, $08, $20 ; entry 18
    db $F8, $B7, $09, $20 ; entry 19
    db $D8, $CC, $0E, $20 ; entry 20
    db $D8, $C4, $0F, $20 ; entry 21
    db $D8, $BC, $10, $20 ; entry 22
    db $D8, $B4, $11, $20 ; entry 23
    db $D0, $B0, $0A, $00 ; entry 24
    db $D0, $B8, $0B, $00 ; entry 25
    db $D0, $C0, $0C, $00 ; entry 26
    db $D0, $C8, $0D, $00 ; entry 27
    db $F8, $D8, $1E, $00 ; entry 28
    db $F8, $D7, $05, $20 ; entry 29
    db $F8, $B0, $1D, $20 ; entry 30
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3E_4024Set0A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0AFrame4::
Data_03E_6344:: ; heuristic: meta-sprite frame; C0
    db $D8, $C4, $00, $00 ; entry 0
    db $D8, $CC, $01, $00 ; entry 1
    db $D8, $D4, $02, $00 ; entry 2
    db $D8, $DC, $03, $00 ; entry 3
    db $D8, $E4, $04, $00 ; entry 4
    db $E0, $C1, $05, $00 ; entry 5
    db $E0, $C9, $06, $00 ; entry 6
    db $E0, $D1, $07, $00 ; entry 7
    db $E0, $D9, $08, $00 ; entry 8
    db $E0, $E1, $09, $00 ; entry 9
    db $E8, $C9, $0A, $00 ; entry 10
    db $E8, $D1, $0B, $00 ; entry 11
    db $E8, $D9, $0C, $00 ; entry 12
    db $E8, $E1, $0D, $00 ; entry 13
    db $F0, $C9, $0E, $00 ; entry 14
    db $F0, $D1, $0F, $00 ; entry 15
    db $F0, $D9, $10, $00 ; entry 16
    db $F0, $E1, $11, $00 ; entry 17
    db $D0, $E8, $17, $20 ; entry 18
    db $D0, $E0, $18, $20 ; entry 19
    db $D0, $D8, $19, $20 ; entry 20
    db $D0, $D0, $1A, $20 ; entry 21
    db $D0, $C8, $1B, $20 ; entry 22
    db $D0, $C0, $1C, $20 ; entry 23
    db $F8, $C2, $12, $00 ; entry 24
    db $F8, $CA, $13, $00 ; entry 25
    db $F8, $D2, $14, $00 ; entry 26
    db $F8, $DA, $15, $00 ; entry 27
    db $F8, $E2, $16, $00 ; entry 28
    db $F8, $E9, $1E, $00 ; entry 29
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3E_4024Set0A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0AFrame5::
Data_03E_63BD:: ; heuristic: meta-sprite frame; C0
    db $E8, $F1, $0E, $20 ; entry 0
    db $E8, $E9, $0F, $20 ; entry 1
    db $E8, $E1, $10, $20 ; entry 2
    db $E8, $D9, $11, $20 ; entry 3
    db $F8, $E0, $18, $00 ; entry 4
    db $F8, $E8, $19, $00 ; entry 5
    db $F8, $F0, $1A, $00 ; entry 6
    db $F8, $F8, $1B, $00 ; entry 7
    db $F8, $D8, $17, $00 ; entry 8
    db $F0, $E0, $13, $00 ; entry 9
    db $F0, $E8, $14, $00 ; entry 10
    db $F0, $F0, $15, $00 ; entry 11
    db $F0, $F8, $16, $00 ; entry 12
    db $F0, $D8, $12, $00 ; entry 13
    db $E0, $D6, $0A, $00 ; entry 14
    db $E0, $DE, $0B, $00 ; entry 15
    db $E0, $E6, $0C, $00 ; entry 16
    db $E0, $EE, $0D, $00 ; entry 17
    db $D8, $ED, $05, $20 ; entry 18
    db $D8, $E5, $06, $20 ; entry 19
    db $D8, $DD, $07, $20 ; entry 20
    db $D8, $D5, $08, $20 ; entry 21
    db $D8, $CD, $05, $40 ; entry 22
    db $D0, $E8, $00, $20 ; entry 23
    db $D0, $E0, $01, $20 ; entry 24
    db $D0, $D8, $02, $20 ; entry 25
    db $D0, $D0, $03, $20 ; entry 26
    db $F8, $D0, $1F, $20 ; entry 27
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3E_4024Set0A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0AFrame6::
Data_03E_642E:: ; heuristic: meta-sprite frame; C0
    db $F0, $E3, $17, $00 ; entry 0
    db $F0, $EB, $18, $00 ; entry 1
    db $F0, $F3, $19, $00 ; entry 2
    db $F0, $FB, $1A, $00 ; entry 3
    db $F0, $03, $1B, $00 ; entry 4
    db $F0, $0B, $1C, $00 ; entry 5
    db $E8, $E3, $12, $00 ; entry 6
    db $E8, $EB, $13, $00 ; entry 7
    db $E8, $F3, $14, $00 ; entry 8
    db $E8, $FB, $15, $00 ; entry 9
    db $E8, $03, $16, $00 ; entry 10
    db $D0, $08, $05, $20 ; entry 11
    db $E0, $FE, $0E, $20 ; entry 12
    db $E0, $F6, $0F, $20 ; entry 13
    db $E0, $EE, $10, $20 ; entry 14
    db $E0, $E6, $11, $20 ; entry 15
    db $D8, $FE, $0A, $20 ; entry 16
    db $D8, $F6, $0B, $20 ; entry 17
    db $D8, $EE, $0C, $20 ; entry 18
    db $D8, $E6, $0D, $20 ; entry 19
    db $D0, $00, $06, $20 ; entry 20
    db $D0, $F8, $07, $20 ; entry 21
    db $D0, $F0, $08, $20 ; entry 22
    db $D0, $E8, $09, $20 ; entry 23
    db $F8, $08, $1F, $00 ; entry 24
    db $F8, $E0, $1D, $00 ; entry 25
    db $F8, $04, $00, $20 ; entry 26
    db $F8, $FC, $01, $20 ; entry 27
    db $F8, $F4, $02, $20 ; entry 28
    db $F8, $EC, $03, $20 ; entry 29
    db $F8, $E4, $04, $20 ; entry 30
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3E_4024Set0A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0AFrame7::
Data_03E_64AB:: ; heuristic: meta-sprite frame; C0
    db $F0, $F4, $00, $00 ; entry 0
    db $F0, $FC, $01, $00 ; entry 1
    db $F0, $04, $02, $00 ; entry 2
    db $F0, $0C, $03, $00 ; entry 3
    db $F0, $14, $04, $00 ; entry 4
    db $E8, $F1, $17, $00 ; entry 5
    db $E8, $F9, $18, $00 ; entry 6
    db $E8, $01, $19, $00 ; entry 7
    db $E8, $09, $1A, $00 ; entry 8
    db $E8, $11, $1B, $00 ; entry 9
    db $E8, $19, $1C, $00 ; entry 10
    db $E0, $F1, $12, $00 ; entry 11
    db $E0, $F9, $13, $00 ; entry 12
    db $E0, $01, $14, $00 ; entry 13
    db $E0, $09, $15, $00 ; entry 14
    db $E0, $11, $16, $00 ; entry 15
    db $F8, $0F, $06, $20 ; entry 16
    db $F8, $07, $07, $20 ; entry 17
    db $F8, $FF, $08, $20 ; entry 18
    db $F8, $F7, $09, $20 ; entry 19
    db $D8, $0C, $0E, $20 ; entry 20
    db $D8, $04, $0F, $20 ; entry 21
    db $D8, $FC, $10, $20 ; entry 22
    db $D8, $F4, $11, $20 ; entry 23
    db $D0, $F0, $0A, $00 ; entry 24
    db $D0, $F8, $0B, $00 ; entry 25
    db $D0, $00, $0C, $00 ; entry 26
    db $D0, $08, $0D, $00 ; entry 27
    db $F8, $18, $1E, $00 ; entry 28
    db $F8, $17, $05, $20 ; entry 29
    db $F8, $F0, $1D, $20 ; entry 30
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites3E_4024Set0A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0AFrame8::
Data_03E_6528:: ; heuristic: meta-sprite frame; C0
    db $D8, $FF, $12, $00 ; entry 0
    db $D8, $07, $13, $00 ; entry 1
    db $D8, $0F, $14, $00 ; entry 2
    db $D8, $17, $15, $00 ; entry 3
    db $D8, $1F, $16, $00 ; entry 4
    db $F8, $10, $0A, $00 ; entry 5
    db $F8, $18, $0B, $00 ; entry 6
    db $F8, $20, $0C, $00 ; entry 7
    db $F8, $28, $0D, $00 ; entry 8
    db $F0, $23, $05, $20 ; entry 9
    db $F0, $1B, $06, $20 ; entry 10
    db $F0, $13, $07, $20 ; entry 11
    db $F0, $0B, $08, $20 ; entry 12
    db $F0, $03, $09, $20 ; entry 13
    db $E8, $01, $00, $00 ; entry 14
    db $E8, $09, $01, $00 ; entry 15
    db $E8, $11, $02, $00 ; entry 16
    db $E8, $19, $03, $00 ; entry 17
    db $E8, $21, $04, $00 ; entry 18
    db $E0, $FE, $17, $00 ; entry 19
    db $E0, $06, $18, $00 ; entry 20
    db $E0, $0E, $19, $00 ; entry 21
    db $E0, $16, $1A, $00 ; entry 22
    db $E0, $1E, $1B, $00 ; entry 23
    db $E0, $26, $1C, $00 ; entry 24
    db $D0, $0A, $0E, $00 ; entry 25
    db $D0, $12, $0F, $00 ; entry 26
    db $D0, $1A, $10, $00 ; entry 27
    db $D0, $22, $11, $00 ; entry 28
    db $F8, $08, $1E, $20 ; entry 29
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites3E_4024Set0A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0AFrame9::
Data_03E_65A1:: ; heuristic: meta-sprite frame; C0
    db $F0, $1C, $0A, $00 ; entry 0
    db $F0, $24, $0B, $00 ; entry 1
    db $F0, $2C, $0C, $00 ; entry 2
    db $F0, $34, $0D, $00 ; entry 3
    db $E8, $34, $05, $20 ; entry 4
    db $E8, $2C, $06, $20 ; entry 5
    db $E8, $24, $07, $20 ; entry 6
    db $E8, $1C, $08, $20 ; entry 7
    db $E8, $14, $09, $20 ; entry 8
    db $E0, $12, $00, $00 ; entry 9
    db $E0, $1A, $01, $00 ; entry 10
    db $E0, $22, $02, $00 ; entry 11
    db $E0, $2A, $03, $00 ; entry 12
    db $E0, $32, $04, $00 ; entry 13
    db $D8, $0F, $17, $00 ; entry 14
    db $D8, $17, $18, $00 ; entry 15
    db $D8, $1F, $19, $00 ; entry 16
    db $D8, $27, $1A, $00 ; entry 17
    db $D8, $2F, $1B, $00 ; entry 18
    db $D8, $37, $1C, $00 ; entry 19
    db $D0, $0F, $12, $00 ; entry 20
    db $D0, $17, $13, $00 ; entry 21
    db $D0, $1F, $14, $00 ; entry 22
    db $D0, $27, $15, $00 ; entry 23
    db $D0, $2F, $16, $00 ; entry 24
    db $F8, $38, $0E, $20 ; entry 25
    db $F8, $30, $0F, $20 ; entry 26
    db $F8, $28, $10, $20 ; entry 27
    db $F8, $20, $11, $20 ; entry 28
    db $F8, $18, $1F, $20 ; entry 29
    db $80 ; end

; E-0147 (derived: frame 10 of MetaSprites3E_4024Set0A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0AFrame10::
Data_03E_661A:: ; heuristic: meta-sprite frame; C0
    db $F8, $48, $12, $20 ; entry 0
    db $F8, $40, $13, $20 ; entry 1
    db $F8, $38, $14, $20 ; entry 2
    db $F8, $30, $15, $20 ; entry 3
    db $F8, $28, $16, $20 ; entry 4
    db $E8, $40, $0A, $20 ; entry 5
    db $E8, $38, $0B, $20 ; entry 6
    db $E8, $30, $0C, $20 ; entry 7
    db $E8, $28, $0D, $20 ; entry 8
    db $F0, $40, $0E, $20 ; entry 9
    db $F0, $38, $0F, $20 ; entry 10
    db $F0, $30, $10, $20 ; entry 11
    db $F0, $28, $11, $20 ; entry 12
    db $E0, $4A, $05, $20 ; entry 13
    db $E0, $42, $06, $20 ; entry 14
    db $E0, $3A, $07, $20 ; entry 15
    db $E0, $32, $08, $20 ; entry 16
    db $E0, $2A, $09, $20 ; entry 17
    db $D8, $28, $00, $00 ; entry 18
    db $D8, $30, $01, $00 ; entry 19
    db $D8, $38, $02, $00 ; entry 20
    db $D8, $40, $03, $00 ; entry 21
    db $D8, $48, $04, $00 ; entry 22
    db $D0, $4A, $17, $20 ; entry 23
    db $D0, $42, $18, $20 ; entry 24
    db $D0, $3A, $19, $20 ; entry 25
    db $D0, $32, $1A, $20 ; entry 26
    db $D0, $2A, $1B, $20 ; entry 27
    db $D0, $22, $1C, $20 ; entry 28
    db $F8, $20, $1D, $20 ; entry 29
    db $80 ; end

; E-0147 (derived: frame 11 of MetaSprites3E_4024Set0A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0AFrame11::
Data_03E_6693:: ; heuristic: meta-sprite frame; C0
    db $F0, $38, $17, $00 ; entry 0
    db $F0, $40, $18, $00 ; entry 1
    db $F0, $48, $19, $00 ; entry 2
    db $E8, $38, $12, $00 ; entry 3
    db $E8, $40, $13, $00 ; entry 4
    db $E8, $48, $14, $00 ; entry 5
    db $F8, $48, $02, $20 ; entry 6
    db $F8, $40, $03, $20 ; entry 7
    db $F8, $38, $04, $20 ; entry 8
    db $E0, $48, $0F, $20 ; entry 9
    db $E0, $40, $10, $20 ; entry 10
    db $E0, $38, $11, $20 ; entry 11
    db $D8, $32, $0A, $00 ; entry 12
    db $D8, $3A, $0B, $00 ; entry 13
    db $D8, $42, $0C, $00 ; entry 14
    db $D8, $4A, $0D, $00 ; entry 15
    db $D0, $45, $05, $20 ; entry 16
    db $D0, $3D, $06, $20 ; entry 17
    db $D0, $35, $07, $20 ; entry 18
    db $D0, $2D, $08, $20 ; entry 19
    db $D0, $25, $09, $20 ; entry 20
    db $F8, $28, $1F, $20 ; entry 21
    db $F8, $30, $1D, $20 ; entry 22
    db $80 ; end

; E-0147 (derived: frame 12 of MetaSprites3E_4024Set0A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0AFrame12::
Data_03E_66F0:: ; heuristic: meta-sprite frame; C0
    db $E8, $48, $1B, $20 ; entry 0
    db $E0, $48, $16, $20 ; entry 1
    db $F0, $48, $00, $00 ; entry 2
    db $F8, $48, $05, $00 ; entry 3
    db $D0, $40, $0A, $00 ; entry 4
    db $D0, $48, $0B, $00 ; entry 5
    db $E7, $40, $1C, $20 ; entry 6
    db $D8, $48, $11, $20 ; entry 7
    db $F8, $38, $1F, $20 ; entry 8
    db $F8, $40, $1D, $20 ; entry 9
    db $80 ; end

; E-0147 (derived: frame 13 of MetaSprites3E_4024Set0A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0AFrame13::
    db $80 ; end

; E-0147 (derived: meta-sprite set 11 of MetaSprites3E_4024Table: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3E_4024Set0B::
Data_03E_671A:: ; heuristic: meta-sprite set; C0
    dw MetaSprites3E_4024Set0BFrame0 ; entry 0
    dw MetaSprites3E_4024Set0BFrame1 ; entry 1
    dw MetaSprites3E_4024Set0BFrame2 ; entry 2
    dw MetaSprites3E_4024Set0BFrame3 ; entry 3
    dw MetaSprites3E_4024Set0BFrame4 ; entry 4
    dw MetaSprites3E_4024Set0BFrame5 ; entry 5
    dw MetaSprites3E_4024Set0BFrame6 ; entry 6
    dw MetaSprites3E_4024Set0BFrame7 ; entry 7
    dw MetaSprites3E_4024Set0BFrame8 ; entry 8
    dw MetaSprites3E_4024Set0BFrame9 ; entry 9
    dw MetaSprites3E_4024Set0BFrame10 ; entry 10
    dw MetaSprites3E_4024Set0BFrame11 ; entry 11
    dw MetaSprites3E_4024Set0BFrame12 ; entry 12
    dw MetaSprites3E_4024Set0BFrame13 ; entry 13
    dw MetaSprites3E_4024Set0BFrame14 ; entry 14
    dw MetaSprites3E_4024Set0BFrame15 ; entry 15
    dw MetaSprites3E_4024Set0BFrame16 ; entry 16
    dw MetaSprites3E_4024Set0BFrame17 ; entry 17
    dw MetaSprites3E_4024Set0BFrame18 ; entry 18
    dw MetaSprites3E_4024Set0BFrame19 ; entry 19
    dw MetaSprites3E_4024Set0BFrame20 ; entry 20
    dw MetaSprites3E_4024Set0BFrame21 ; entry 21
    dw MetaSprites3E_4024Set0BFrame22 ; entry 22
    dw MetaSprites3E_4024Set0BFrame23 ; entry 23
    dw MetaSprites3E_4024Set0BFrame24 ; entry 24
    dw MetaSprites3E_4024Set0BFrame25 ; entry 25
    dw MetaSprites3E_4024Set0BFrame26 ; entry 26
    dw MetaSprites3E_4024Set0BFrame27 ; entry 27
    dw MetaSprites3E_4024Set0BFrame27 ; entry 28
    dw MetaSprites3E_4024Set0BFrame27 ; entry 29
    dw MetaSprites3E_4024Set0BFrame27 ; entry 30
    dw MetaSprites3E_4024Set0BFrame27 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3E_4024Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0BFrame0::
Data_03E_675A:: ; heuristic: meta-sprite frame; C0
    db $F8, $B0, $04, $00 ; entry 0
    db $F8, $B8, $05, $00 ; entry 1
    db $F8, $C0, $06, $00 ; entry 2
    db $F8, $C8, $07, $00 ; entry 3
    db $F8, $D0, $08, $00 ; entry 4
    db $F8, $D8, $09, $00 ; entry 5
    db $F2, $D0, $05, $00 ; entry 6
    db $F2, $D8, $06, $00 ; entry 7
    db $F2, $C9, $04, $00 ; entry 8
    db $F0, $B0, $08, $00 ; entry 9
    db $F0, $B8, $09, $00 ; entry 10
    db $F8, $E0, $20, $00 ; entry 11
    db $F8, $E8, $1C, $40 ; entry 12
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3E_4024Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0BFrame1::
Data_03E_678F:: ; heuristic: meta-sprite frame; C0
    db $F8, $C0, $0A, $00 ; entry 0
    db $F8, $C8, $0B, $00 ; entry 1
    db $F8, $D0, $0C, $00 ; entry 2
    db $F8, $D8, $0D, $00 ; entry 3
    db $F0, $B8, $04, $00 ; entry 4
    db $F0, $C0, $05, $00 ; entry 5
    db $F0, $C8, $06, $00 ; entry 6
    db $F0, $D0, $07, $00 ; entry 7
    db $F0, $D8, $08, $00 ; entry 8
    db $F0, $E0, $09, $00 ; entry 9
    db $F8, $B0, $20, $20 ; entry 10
    db $F8, $E8, $21, $00 ; entry 11
    db $F0, $F0, $1D, $00 ; entry 12
    db $E8, $B0, $1C, $00 ; entry 13
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3E_4024Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0BFrame2::
Data_03E_67C8:: ; heuristic: meta-sprite frame; C0
    db $D8, $E0, $04, $00 ; entry 0
    db $D8, $C0, $05, $00 ; entry 1
    db $D8, $C8, $06, $00 ; entry 2
    db $D8, $D0, $07, $00 ; entry 3
    db $D8, $D8, $08, $00 ; entry 4
    db $D8, $E0, $09, $00 ; entry 5
    db $E0, $C0, $0A, $00 ; entry 6
    db $E0, $C8, $0B, $00 ; entry 7
    db $E0, $D0, $0C, $00 ; entry 8
    db $E0, $D8, $0D, $00 ; entry 9
    db $F0, $D0, $0A, $00 ; entry 10
    db $F0, $D8, $0B, $00 ; entry 11
    db $F0, $E0, $0C, $00 ; entry 12
    db $E8, $C8, $04, $00 ; entry 13
    db $E8, $D0, $05, $00 ; entry 14
    db $E8, $D8, $06, $00 ; entry 15
    db $E8, $E0, $07, $00 ; entry 16
    db $F8, $D0, $10, $00 ; entry 17
    db $F8, $D8, $11, $00 ; entry 18
    db $F8, $E0, $12, $00 ; entry 19
    db $F8, $C0, $0E, $00 ; entry 20
    db $F8, $C8, $0F, $00 ; entry 21
    db $F0, $E8, $0D, $00 ; entry 22
    db $E8, $E8, $08, $00 ; entry 23
    db $E8, $F0, $09, $00 ; entry 24
    db $F8, $E8, $17, $00 ; entry 25
    db $F8, $B0, $21, $20 ; entry 26
    db $F8, $F8, $21, $00 ; entry 27
    db $F0, $C0, $1D, $20 ; entry 28
    db $E8, $00, $1C, $20 ; entry 29
    db $F0, $10, $1F, $00 ; entry 30
    db $F8, $F0, $13, $00 ; entry 31
    db $F8, $B8, $13, $20 ; entry 32
    db $E0, $B8, $1E, $00 ; entry 33
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3E_4024Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0BFrame3::
Data_03E_6851:: ; heuristic: meta-sprite frame; C0
    db $F0, $E4, $0A, $00 ; entry 0
    db $F0, $EC, $0B, $00 ; entry 1
    db $F0, $F4, $0C, $00 ; entry 2
    db $F0, $FC, $0D, $00 ; entry 3
    db $F8, $B8, $04, $00 ; entry 4
    db $F8, $C0, $05, $00 ; entry 5
    db $F8, $C8, $06, $00 ; entry 6
    db $F8, $D0, $07, $00 ; entry 7
    db $F8, $D8, $08, $00 ; entry 8
    db $F8, $E0, $05, $00 ; entry 9
    db $F8, $E8, $06, $00 ; entry 10
    db $F8, $F0, $07, $00 ; entry 11
    db $F8, $F8, $08, $00 ; entry 12
    db $F8, $00, $09, $00 ; entry 13
    db $D0, $20, $1E, $00 ; entry 14
    db $E8, $20, $1F, $00 ; entry 15
    db $E0, $10, $1D, $00 ; entry 16
    db $F0, $D8, $1C, $00 ; entry 17
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3E_4024Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0BFrame4::
Data_03E_689A:: ; heuristic: meta-sprite frame; C0
    db $F8, $E0, $0E, $00 ; entry 0
    db $E0, $08, $0B, $00 ; entry 1
    db $E0, $10, $0C, $00 ; entry 2
    db $E0, $18, $0D, $00 ; entry 3
    db $D8, $08, $05, $00 ; entry 4
    db $D8, $10, $06, $00 ; entry 5
    db $D8, $18, $08, $00 ; entry 6
    db $DA, $20, $11, $00 ; entry 7
    db $DA, $28, $12, $00 ; entry 8
    db $E8, $F8, $0A, $00 ; entry 9
    db $E8, $00, $0B, $00 ; entry 10
    db $E8, $08, $0C, $00 ; entry 11
    db $E8, $10, $0D, $00 ; entry 12
    db $D0, $F0, $10, $00 ; entry 13
    db $D0, $F8, $11, $00 ; entry 14
    db $D0, $00, $12, $00 ; entry 15
    db $D0, $E0, $0E, $00 ; entry 16
    db $D0, $E8, $0F, $00 ; entry 17
    db $D8, $E8, $19, $00 ; entry 18
    db $D8, $F0, $1A, $00 ; entry 19
    db $D8, $F8, $1B, $00 ; entry 20
    db $E0, $F0, $15, $00 ; entry 21
    db $D8, $00, $14, $00 ; entry 22
    db $E0, $F8, $1A, $00 ; entry 23
    db $E0, $00, $1B, $00 ; entry 24
    db $F0, $E0, $19, $00 ; entry 25
    db $F0, $E8, $1A, $00 ; entry 26
    db $F0, $F8, $0F, $00 ; entry 27
    db $F0, $F0, $1B, $00 ; entry 28
    db $D0, $08, $09, $00 ; entry 29
    db $F8, $D0, $19, $00 ; entry 30
    db $F8, $D8, $1A, $00 ; entry 31
    db $F8, $E8, $1A, $60 ; entry 32
    db $F8, $F0, $08, $00 ; entry 33
    db $F8, $F8, $09, $00 ; entry 34
    db $F0, $00, $10, $00 ; entry 35
    db $F0, $08, $11, $00 ; entry 36
    db $F8, $C0, $21, $20 ; entry 37
    db $F8, $08, $20, $00 ; entry 38
    db $D0, $20, $1C, $00 ; entry 39
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3E_4024Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0BFrame5::
Data_03E_693B:: ; heuristic: meta-sprite frame; C0
    db $E8, $F8, $0B, $00 ; entry 0
    db $E8, $00, $0C, $00 ; entry 1
    db $E8, $08, $0D, $00 ; entry 2
    db $E0, $D8, $04, $00 ; entry 3
    db $D8, $F0, $11, $00 ; entry 4
    db $D8, $F8, $12, $00 ; entry 5
    db $E0, $E0, $0C, $00 ; entry 6
    db $E0, $E8, $14, $00 ; entry 7
    db $E8, $F0, $14, $00 ; entry 8
    db $D8, $D8, $15, $00 ; entry 9
    db $D8, $E0, $16, $00 ; entry 10
    db $D8, $E8, $17, $00 ; entry 11
    db $F8, $E8, $0C, $00 ; entry 12
    db $F8, $F0, $0D, $00 ; entry 13
    db $F0, $D8, $05, $00 ; entry 14
    db $F0, $E0, $06, $00 ; entry 15
    db $F0, $E8, $07, $00 ; entry 16
    db $F0, $F0, $14, $00 ; entry 17
    db $F0, $F8, $0F, $00 ; entry 18
    db $F8, $F8, $17, $00 ; entry 19
    db $F0, $00, $17, $00 ; entry 20
    db $E0, $F0, $06, $00 ; entry 21
    db $E0, $F8, $07, $00 ; entry 22
    db $E0, $00, $08, $00 ; entry 23
    db $E0, $08, $09, $00 ; entry 24
    db $E8, $E0, $15, $00 ; entry 25
    db $E8, $E8, $16, $00 ; entry 26
    db $F0, $C8, $15, $00 ; entry 27
    db $F0, $D0, $16, $00 ; entry 28
    db $D8, $00, $09, $00 ; entry 29
    db $F8, $D8, $1A, $00 ; entry 30
    db $F8, $E0, $1B, $00 ; entry 31
    db $F8, $10, $20, $00 ; entry 32
    db $F8, $08, $21, $00 ; entry 33
    db $F8, $C8, $21, $20 ; entry 34
    db $F0, $18, $1D, $00 ; entry 35
    db $F8, $C0, $13, $00 ; entry 36
    db $F8, $D0, $1C, $00 ; entry 37
    db $E8, $C0, $1C, $00 ; entry 38
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3E_4024Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0BFrame6::
Data_03E_69D8:: ; heuristic: meta-sprite frame; C0
    db $D0, $E8, $05, $00 ; entry 0
    db $E0, $DC, $0B, $00 ; entry 1
    db $E0, $E4, $0C, $00 ; entry 2
    db $E0, $EC, $0D, $00 ; entry 3
    db $D0, $F0, $06, $00 ; entry 4
    db $D0, $F8, $08, $00 ; entry 5
    db $D0, $E0, $14, $00 ; entry 6
    db $D0, $C0, $15, $00 ; entry 7
    db $D0, $C8, $16, $00 ; entry 8
    db $D0, $D0, $17, $00 ; entry 9
    db $D0, $D8, $0E, $00 ; entry 10
    db $D8, $C8, $19, $00 ; entry 11
    db $D8, $D0, $1A, $00 ; entry 12
    db $D8, $D8, $14, $00 ; entry 13
    db $E0, $C4, $19, $00 ; entry 14
    db $E0, $CC, $1A, $00 ; entry 15
    db $E0, $D4, $0D, $00 ; entry 16
    db $D8, $E8, $07, $00 ; entry 17
    db $D8, $F0, $08, $00 ; entry 18
    db $D8, $F8, $09, $00 ; entry 19
    db $D8, $E0, $16, $00 ; entry 20
    db $D0, $00, $09, $00 ; entry 21
    db $E8, $D4, $15, $00 ; entry 22
    db $E8, $DC, $16, $00 ; entry 23
    db $E8, $E4, $17, $00 ; entry 24
    db $E8, $EC, $12, $00 ; entry 25
    db $F0, $E8, $15, $00 ; entry 26
    db $F0, $F0, $16, $00 ; entry 27
    db $F0, $F8, $17, $00 ; entry 28
    db $F8, $F0, $05, $00 ; entry 29
    db $E8, $F4, $09, $00 ; entry 30
    db $F8, $D8, $15, $00 ; entry 31
    db $F8, $E0, $16, $00 ; entry 32
    db $F8, $E8, $17, $00 ; entry 33
    db $F8, $F8, $10, $00 ; entry 34
    db $F8, $00, $11, $00 ; entry 35
    db $F8, $08, $12, $00 ; entry 36
    db $F8, $C8, $20, $20 ; entry 37
    db $E0, $28, $1C, $00 ; entry 38
    db $F8, $18, $20, $00 ; entry 39
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3E_4024Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0BFrame7::
Data_03E_6A79:: ; heuristic: meta-sprite frame; C0
    db $F8, $F8, $0E, $00 ; entry 0
    db $E0, $20, $0B, $00 ; entry 1
    db $E0, $28, $0C, $00 ; entry 2
    db $E0, $30, $0D, $00 ; entry 3
    db $D8, $20, $05, $00 ; entry 4
    db $D8, $28, $06, $00 ; entry 5
    db $D8, $30, $08, $00 ; entry 6
    db $DA, $38, $11, $00 ; entry 7
    db $DA, $40, $12, $00 ; entry 8
    db $E8, $10, $0A, $00 ; entry 9
    db $E8, $18, $0B, $00 ; entry 10
    db $E8, $20, $0C, $00 ; entry 11
    db $E8, $28, $0D, $00 ; entry 12
    db $D0, $08, $10, $00 ; entry 13
    db $D0, $10, $11, $00 ; entry 14
    db $D0, $18, $12, $00 ; entry 15
    db $D0, $F8, $0E, $00 ; entry 16
    db $D0, $00, $0F, $00 ; entry 17
    db $D8, $00, $19, $00 ; entry 18
    db $D8, $08, $1A, $00 ; entry 19
    db $D8, $10, $1B, $00 ; entry 20
    db $E0, $08, $15, $00 ; entry 21
    db $D8, $18, $14, $00 ; entry 22
    db $E0, $10, $1A, $00 ; entry 23
    db $E0, $18, $1B, $00 ; entry 24
    db $F0, $F8, $19, $00 ; entry 25
    db $F0, $00, $1A, $00 ; entry 26
    db $F0, $18, $10, $00 ; entry 27
    db $F0, $20, $11, $00 ; entry 28
    db $F0, $10, $0F, $00 ; entry 29
    db $F0, $08, $1B, $00 ; entry 30
    db $D0, $20, $09, $00 ; entry 31
    db $F8, $E8, $19, $00 ; entry 32
    db $F8, $F0, $1A, $00 ; entry 33
    db $F8, $00, $1A, $60 ; entry 34
    db $F8, $08, $08, $00 ; entry 35
    db $F8, $10, $09, $00 ; entry 36
    db $F8, $20, $21, $00 ; entry 37
    db $F8, $D8, $21, $20 ; entry 38
    db $E8, $D0, $1F, $00 ; entry 39
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites3E_4024Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0BFrame8::
Data_03E_6B1A:: ; heuristic: meta-sprite frame; C0
    db $E8, $10, $0B, $00 ; entry 0
    db $E8, $18, $0C, $00 ; entry 1
    db $E8, $20, $0D, $00 ; entry 2
    db $E0, $F0, $04, $00 ; entry 3
    db $D8, $08, $11, $00 ; entry 4
    db $D8, $10, $12, $00 ; entry 5
    db $E0, $F8, $0C, $00 ; entry 6
    db $E0, $00, $14, $00 ; entry 7
    db $E8, $08, $14, $00 ; entry 8
    db $D8, $F0, $15, $00 ; entry 9
    db $D8, $F8, $16, $00 ; entry 10
    db $D8, $00, $17, $00 ; entry 11
    db $F8, $00, $0C, $00 ; entry 12
    db $F8, $08, $0D, $00 ; entry 13
    db $F0, $F0, $05, $00 ; entry 14
    db $F0, $F8, $06, $00 ; entry 15
    db $F0, $00, $07, $00 ; entry 16
    db $F0, $08, $14, $00 ; entry 17
    db $F0, $10, $0F, $00 ; entry 18
    db $F8, $10, $17, $00 ; entry 19
    db $F0, $18, $17, $00 ; entry 20
    db $E0, $08, $06, $00 ; entry 21
    db $E0, $10, $07, $00 ; entry 22
    db $E0, $18, $08, $00 ; entry 23
    db $E0, $20, $09, $00 ; entry 24
    db $E8, $F8, $15, $00 ; entry 25
    db $E8, $00, $16, $00 ; entry 26
    db $F0, $E0, $15, $00 ; entry 27
    db $F0, $E8, $16, $00 ; entry 28
    db $D8, $18, $09, $00 ; entry 29
    db $F8, $F0, $1A, $00 ; entry 30
    db $F8, $F8, $1B, $00 ; entry 31
    db $F8, $28, $20, $00 ; entry 32
    db $F8, $D8, $20, $20 ; entry 33
    db $F8, $E0, $13, $00 ; entry 34
    db $F8, $20, $13, $20 ; entry 35
    db $D0, $38, $1D, $00 ; entry 36
    db $F8, $D0, $1F, $00 ; entry 37
    db $F0, $30, $1E, $20 ; entry 38
    db $D8, $C8, $1E, $00 ; entry 39
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites3E_4024Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0BFrame9::
Data_03E_6BBB:: ; heuristic: meta-sprite frame; C0
    db $D0, $F8, $05, $00 ; entry 0
    db $E0, $EC, $0B, $00 ; entry 1
    db $E0, $F4, $0C, $00 ; entry 2
    db $E0, $FC, $0D, $00 ; entry 3
    db $D0, $00, $06, $00 ; entry 4
    db $D0, $08, $08, $00 ; entry 5
    db $D0, $F0, $14, $00 ; entry 6
    db $D0, $D0, $15, $00 ; entry 7
    db $D0, $D8, $16, $00 ; entry 8
    db $D0, $E0, $17, $00 ; entry 9
    db $D0, $E8, $0E, $00 ; entry 10
    db $D8, $D8, $19, $00 ; entry 11
    db $D8, $E0, $1A, $00 ; entry 12
    db $D8, $E8, $14, $00 ; entry 13
    db $E0, $D4, $19, $00 ; entry 14
    db $E0, $DC, $1A, $00 ; entry 15
    db $E0, $E4, $0D, $00 ; entry 16
    db $D8, $F8, $07, $00 ; entry 17
    db $D8, $00, $08, $00 ; entry 18
    db $D8, $08, $09, $00 ; entry 19
    db $D8, $F0, $16, $00 ; entry 20
    db $D0, $10, $09, $00 ; entry 21
    db $E8, $E4, $15, $00 ; entry 22
    db $E8, $EC, $16, $00 ; entry 23
    db $E8, $F4, $17, $00 ; entry 24
    db $E8, $FC, $12, $00 ; entry 25
    db $F0, $F8, $15, $00 ; entry 26
    db $F0, $00, $16, $00 ; entry 27
    db $F0, $08, $17, $00 ; entry 28
    db $F8, $00, $05, $00 ; entry 29
    db $E8, $04, $09, $00 ; entry 30
    db $F8, $E8, $15, $00 ; entry 31
    db $F8, $F0, $16, $00 ; entry 32
    db $F8, $F8, $17, $00 ; entry 33
    db $F8, $08, $10, $00 ; entry 34
    db $F8, $10, $11, $00 ; entry 35
    db $F8, $18, $12, $00 ; entry 36
    db $F8, $28, $21, $00 ; entry 37
    db $F8, $D8, $21, $20 ; entry 38
    db $E8, $D0, $1F, $00 ; entry 39
    db $80 ; end

; E-0147 (derived: frame 10 of MetaSprites3E_4024Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0BFrame10::
Data_03E_6C5C:: ; heuristic: meta-sprite frame; C0
    db $F8, $00, $0E, $00 ; entry 0
    db $E0, $28, $0B, $00 ; entry 1
    db $E0, $30, $0C, $00 ; entry 2
    db $E0, $38, $0D, $00 ; entry 3
    db $D8, $28, $05, $00 ; entry 4
    db $D8, $30, $06, $00 ; entry 5
    db $D8, $38, $08, $00 ; entry 6
    db $DA, $40, $11, $00 ; entry 7
    db $DA, $48, $12, $00 ; entry 8
    db $E8, $18, $0A, $00 ; entry 9
    db $E8, $20, $0B, $00 ; entry 10
    db $E8, $28, $0C, $00 ; entry 11
    db $E8, $30, $0D, $00 ; entry 12
    db $D0, $10, $10, $00 ; entry 13
    db $D0, $18, $11, $00 ; entry 14
    db $D0, $20, $12, $00 ; entry 15
    db $D0, $00, $0E, $00 ; entry 16
    db $D0, $08, $0F, $00 ; entry 17
    db $D8, $08, $19, $00 ; entry 18
    db $D8, $10, $1A, $00 ; entry 19
    db $D8, $18, $1B, $00 ; entry 20
    db $E0, $10, $15, $00 ; entry 21
    db $D8, $20, $14, $00 ; entry 22
    db $E0, $18, $1A, $00 ; entry 23
    db $E0, $20, $1B, $00 ; entry 24
    db $F0, $00, $19, $00 ; entry 25
    db $F0, $08, $1A, $00 ; entry 26
    db $F0, $20, $10, $00 ; entry 27
    db $F0, $28, $11, $00 ; entry 28
    db $F0, $18, $0F, $00 ; entry 29
    db $F0, $10, $1B, $00 ; entry 30
    db $D0, $28, $09, $00 ; entry 31
    db $F8, $F0, $19, $00 ; entry 32
    db $F8, $F8, $1A, $00 ; entry 33
    db $F8, $08, $1A, $60 ; entry 34
    db $F8, $10, $08, $00 ; entry 35
    db $F8, $18, $09, $00 ; entry 36
    db $F8, $28, $20, $00 ; entry 37
    db $F8, $E0, $20, $20 ; entry 38
    db $E2, $40, $1C, $00 ; entry 39
    db $80 ; end

; E-0147 (derived: frame 11 of MetaSprites3E_4024Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0BFrame11::
Data_03E_6CFD:: ; heuristic: meta-sprite frame; C0
    db $E8, $10, $0B, $00 ; entry 0
    db $E8, $18, $0C, $00 ; entry 1
    db $E8, $20, $0D, $00 ; entry 2
    db $E0, $F0, $04, $00 ; entry 3
    db $D8, $08, $11, $00 ; entry 4
    db $D8, $10, $12, $00 ; entry 5
    db $E0, $F8, $0C, $00 ; entry 6
    db $E0, $00, $14, $00 ; entry 7
    db $E8, $08, $14, $00 ; entry 8
    db $D8, $F0, $15, $00 ; entry 9
    db $D8, $F8, $16, $00 ; entry 10
    db $D8, $00, $17, $00 ; entry 11
    db $F8, $00, $0C, $00 ; entry 12
    db $F8, $08, $0D, $00 ; entry 13
    db $F0, $F0, $05, $00 ; entry 14
    db $F0, $F8, $06, $00 ; entry 15
    db $F0, $00, $07, $00 ; entry 16
    db $F0, $08, $14, $00 ; entry 17
    db $F0, $10, $0F, $00 ; entry 18
    db $F8, $10, $17, $00 ; entry 19
    db $F0, $18, $17, $00 ; entry 20
    db $E0, $08, $06, $00 ; entry 21
    db $E0, $10, $07, $00 ; entry 22
    db $E0, $18, $08, $00 ; entry 23
    db $E0, $20, $09, $00 ; entry 24
    db $E8, $F8, $15, $00 ; entry 25
    db $E8, $00, $16, $00 ; entry 26
    db $F0, $E0, $15, $00 ; entry 27
    db $F0, $E8, $16, $00 ; entry 28
    db $D8, $18, $09, $00 ; entry 29
    db $F8, $F0, $1A, $00 ; entry 30
    db $F8, $F8, $1B, $00 ; entry 31
    db $F8, $20, $21, $00 ; entry 32
    db $F8, $D8, $21, $20 ; entry 33
    db $F8, $28, $13, $00 ; entry 34
    db $F8, $D0, $13, $20 ; entry 35
    db $F0, $30, $1D, $00 ; entry 36
    db $F8, $C8, $1C, $00 ; entry 37
    db $E0, $E8, $1E, $00 ; entry 38
    db $E0, $28, $1F, $00 ; entry 39
    db $80 ; end

; E-0147 (derived: frame 12 of MetaSprites3E_4024Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0BFrame12::
Data_03E_6D9E:: ; heuristic: meta-sprite frame; C0
    db $D0, $F8, $05, $00 ; entry 0
    db $E0, $EC, $0B, $00 ; entry 1
    db $E0, $F4, $0C, $00 ; entry 2
    db $E0, $FC, $0D, $00 ; entry 3
    db $D0, $00, $06, $00 ; entry 4
    db $D0, $08, $08, $00 ; entry 5
    db $D0, $F0, $14, $00 ; entry 6
    db $D0, $D0, $15, $00 ; entry 7
    db $D0, $D8, $16, $00 ; entry 8
    db $D0, $E0, $17, $00 ; entry 9
    db $D0, $E8, $0E, $00 ; entry 10
    db $D8, $D8, $19, $00 ; entry 11
    db $D8, $E0, $1A, $00 ; entry 12
    db $D8, $E8, $14, $00 ; entry 13
    db $E0, $D4, $19, $00 ; entry 14
    db $E0, $DC, $1A, $00 ; entry 15
    db $E0, $E4, $0D, $00 ; entry 16
    db $D8, $F8, $07, $00 ; entry 17
    db $D8, $00, $08, $00 ; entry 18
    db $D8, $08, $09, $00 ; entry 19
    db $D8, $F0, $16, $00 ; entry 20
    db $D0, $10, $09, $00 ; entry 21
    db $E8, $E4, $15, $00 ; entry 22
    db $E8, $EC, $16, $00 ; entry 23
    db $E8, $F4, $17, $00 ; entry 24
    db $E8, $FC, $12, $00 ; entry 25
    db $F0, $F8, $15, $00 ; entry 26
    db $F0, $00, $16, $00 ; entry 27
    db $F0, $08, $17, $00 ; entry 28
    db $F8, $00, $05, $00 ; entry 29
    db $E8, $04, $09, $00 ; entry 30
    db $F8, $E8, $15, $00 ; entry 31
    db $F8, $F0, $16, $00 ; entry 32
    db $F8, $F8, $17, $00 ; entry 33
    db $F8, $08, $10, $00 ; entry 34
    db $F8, $10, $11, $00 ; entry 35
    db $F8, $18, $12, $00 ; entry 36
    db $F8, $28, $20, $00 ; entry 37
    db $F8, $D8, $20, $20 ; entry 38
    db $E8, $40, $1D, $00 ; entry 39
    db $80 ; end

; E-0147 (derived: frame 13 of MetaSprites3E_4024Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0BFrame13::
Data_03E_6E3F:: ; heuristic: meta-sprite frame; C0
    db $F8, $F8, $0E, $00 ; entry 0
    db $E0, $20, $0B, $00 ; entry 1
    db $E0, $28, $0C, $00 ; entry 2
    db $E0, $30, $0D, $00 ; entry 3
    db $D8, $20, $05, $00 ; entry 4
    db $D8, $28, $06, $00 ; entry 5
    db $D8, $30, $08, $00 ; entry 6
    db $DA, $38, $11, $00 ; entry 7
    db $DA, $40, $12, $00 ; entry 8
    db $E8, $10, $0A, $00 ; entry 9
    db $E8, $18, $0B, $00 ; entry 10
    db $E8, $20, $0C, $00 ; entry 11
    db $E8, $28, $0D, $00 ; entry 12
    db $D0, $08, $10, $00 ; entry 13
    db $D0, $10, $11, $00 ; entry 14
    db $D0, $18, $12, $00 ; entry 15
    db $D0, $F8, $0E, $00 ; entry 16
    db $D0, $00, $0F, $00 ; entry 17
    db $D8, $00, $19, $00 ; entry 18
    db $D8, $08, $1A, $00 ; entry 19
    db $D8, $10, $1B, $00 ; entry 20
    db $E0, $08, $15, $00 ; entry 21
    db $D8, $18, $14, $00 ; entry 22
    db $E0, $10, $1A, $00 ; entry 23
    db $E0, $18, $1B, $00 ; entry 24
    db $F0, $F8, $19, $00 ; entry 25
    db $F0, $00, $1A, $00 ; entry 26
    db $F0, $18, $10, $00 ; entry 27
    db $F0, $20, $11, $00 ; entry 28
    db $F0, $10, $0F, $00 ; entry 29
    db $F0, $08, $1B, $00 ; entry 30
    db $D0, $20, $09, $00 ; entry 31
    db $F8, $E8, $19, $00 ; entry 32
    db $F8, $F0, $1A, $00 ; entry 33
    db $F8, $00, $1A, $60 ; entry 34
    db $F8, $08, $08, $00 ; entry 35
    db $F8, $10, $09, $00 ; entry 36
    db $F8, $D8, $13, $00 ; entry 37
    db $F8, $20, $13, $20 ; entry 38
    db $D0, $E0, $1F, $00 ; entry 39
    db $80 ; end

; E-0147 (derived: frame 14 of MetaSprites3E_4024Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0BFrame14::
Data_03E_6EE0:: ; heuristic: meta-sprite frame; C0
    db $E8, $00, $0B, $00 ; entry 0
    db $E8, $08, $0C, $00 ; entry 1
    db $E8, $10, $0D, $00 ; entry 2
    db $E0, $E0, $04, $00 ; entry 3
    db $D8, $F8, $11, $00 ; entry 4
    db $D8, $00, $12, $00 ; entry 5
    db $E0, $E8, $0C, $00 ; entry 6
    db $E0, $F0, $14, $00 ; entry 7
    db $E8, $F8, $14, $00 ; entry 8
    db $D8, $E0, $15, $00 ; entry 9
    db $D8, $E8, $16, $00 ; entry 10
    db $D8, $F0, $17, $00 ; entry 11
    db $F8, $F0, $0C, $00 ; entry 12
    db $F8, $F8, $0D, $00 ; entry 13
    db $F0, $E0, $05, $00 ; entry 14
    db $F0, $E8, $06, $00 ; entry 15
    db $F0, $F0, $07, $00 ; entry 16
    db $F0, $F8, $14, $00 ; entry 17
    db $F0, $00, $0F, $00 ; entry 18
    db $F8, $00, $17, $00 ; entry 19
    db $F0, $08, $17, $00 ; entry 20
    db $E0, $F8, $06, $00 ; entry 21
    db $E0, $00, $07, $00 ; entry 22
    db $E0, $08, $08, $00 ; entry 23
    db $E0, $10, $09, $00 ; entry 24
    db $E8, $E8, $15, $00 ; entry 25
    db $E8, $F0, $16, $00 ; entry 26
    db $F0, $D0, $15, $00 ; entry 27
    db $F0, $D8, $16, $00 ; entry 28
    db $D8, $08, $09, $00 ; entry 29
    db $F8, $E0, $1A, $00 ; entry 30
    db $F8, $E8, $1B, $00 ; entry 31
    db $F8, $10, $20, $00 ; entry 32
    db $F8, $18, $21, $00 ; entry 33
    db $F8, $C8, $20, $20 ; entry 34
    db $F8, $C0, $21, $20 ; entry 35
    db $F8, $38, $1C, $20 ; entry 36
    db $E8, $D8, $1D, $20 ; entry 37
    db $F0, $18, $1E, $20 ; entry 38
    db $D8, $D0, $1F, $20 ; entry 39
    db $80 ; end

; E-0147 (derived: frame 15 of MetaSprites3E_4024Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0BFrame15::
Data_03E_6F81:: ; heuristic: meta-sprite frame; C0
    db $D0, $E8, $05, $00 ; entry 0
    db $E0, $DC, $0B, $00 ; entry 1
    db $E0, $E4, $0C, $00 ; entry 2
    db $E0, $EC, $0D, $00 ; entry 3
    db $D0, $F0, $06, $00 ; entry 4
    db $D0, $F8, $08, $00 ; entry 5
    db $D0, $E0, $14, $00 ; entry 6
    db $D0, $C0, $15, $00 ; entry 7
    db $D0, $C8, $16, $00 ; entry 8
    db $D0, $D0, $17, $00 ; entry 9
    db $D0, $D8, $0E, $00 ; entry 10
    db $D8, $C8, $19, $00 ; entry 11
    db $D8, $D0, $1A, $00 ; entry 12
    db $D8, $D8, $14, $00 ; entry 13
    db $E0, $C4, $19, $00 ; entry 14
    db $E0, $CC, $1A, $00 ; entry 15
    db $E0, $D4, $0D, $00 ; entry 16
    db $D8, $E8, $07, $00 ; entry 17
    db $D8, $F0, $08, $00 ; entry 18
    db $D8, $F8, $09, $00 ; entry 19
    db $D8, $E0, $16, $00 ; entry 20
    db $D0, $00, $09, $00 ; entry 21
    db $E8, $D4, $15, $00 ; entry 22
    db $E8, $DC, $16, $00 ; entry 23
    db $E8, $E4, $17, $00 ; entry 24
    db $E8, $EC, $12, $00 ; entry 25
    db $F0, $E8, $15, $00 ; entry 26
    db $F0, $F0, $16, $00 ; entry 27
    db $F0, $F8, $17, $00 ; entry 28
    db $F8, $F0, $05, $00 ; entry 29
    db $E8, $F4, $09, $00 ; entry 30
    db $F8, $D8, $15, $00 ; entry 31
    db $F8, $E0, $16, $00 ; entry 32
    db $F8, $E8, $17, $00 ; entry 33
    db $F8, $F8, $10, $00 ; entry 34
    db $F8, $00, $11, $00 ; entry 35
    db $F8, $08, $12, $00 ; entry 36
    db $F8, $C8, $13, $00 ; entry 37
    db $F8, $18, $13, $20 ; entry 38
    db $E8, $30, $1C, $40 ; entry 39
    db $80 ; end

; E-0147 (derived: frame 16 of MetaSprites3E_4024Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0BFrame16::
Data_03E_7022:: ; heuristic: meta-sprite frame; C0
    db $F8, $E8, $0E, $00 ; entry 0
    db $E0, $10, $0B, $00 ; entry 1
    db $E0, $18, $0C, $00 ; entry 2
    db $E0, $20, $0D, $00 ; entry 3
    db $D8, $10, $05, $00 ; entry 4
    db $D8, $18, $06, $00 ; entry 5
    db $D8, $20, $08, $00 ; entry 6
    db $DA, $28, $11, $00 ; entry 7
    db $DA, $30, $12, $00 ; entry 8
    db $E8, $00, $0A, $00 ; entry 9
    db $E8, $08, $0B, $00 ; entry 10
    db $E8, $10, $0C, $00 ; entry 11
    db $E8, $18, $0D, $00 ; entry 12
    db $D0, $F8, $10, $00 ; entry 13
    db $D0, $00, $11, $00 ; entry 14
    db $D0, $08, $12, $00 ; entry 15
    db $D0, $E8, $0E, $00 ; entry 16
    db $D0, $F0, $0F, $00 ; entry 17
    db $D8, $F0, $19, $00 ; entry 18
    db $D8, $F8, $1A, $00 ; entry 19
    db $D8, $00, $1B, $00 ; entry 20
    db $E0, $F8, $15, $00 ; entry 21
    db $D8, $08, $14, $00 ; entry 22
    db $E0, $00, $1A, $00 ; entry 23
    db $E0, $08, $1B, $00 ; entry 24
    db $F0, $E8, $19, $00 ; entry 25
    db $F0, $F0, $1A, $00 ; entry 26
    db $F0, $08, $10, $00 ; entry 27
    db $F0, $10, $11, $00 ; entry 28
    db $F0, $00, $0F, $00 ; entry 29
    db $F0, $F8, $1B, $00 ; entry 30
    db $D0, $10, $09, $00 ; entry 31
    db $F8, $D8, $19, $00 ; entry 32
    db $F8, $E0, $1A, $00 ; entry 33
    db $F8, $F0, $1A, $60 ; entry 34
    db $F8, $F8, $08, $00 ; entry 35
    db $F8, $00, $09, $00 ; entry 36
    db $F8, $10, $21, $00 ; entry 37
    db $F8, $C8, $21, $20 ; entry 38
    db $E8, $48, $1D, $00 ; entry 39
    db $80 ; end

; E-0147 (derived: frame 17 of MetaSprites3E_4024Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0BFrame17::
Data_03E_70C3:: ; heuristic: meta-sprite frame; C0
    db $E8, $F8, $0B, $00 ; entry 0
    db $E8, $00, $0C, $00 ; entry 1
    db $E8, $08, $0D, $00 ; entry 2
    db $E0, $D8, $04, $00 ; entry 3
    db $D8, $F0, $11, $00 ; entry 4
    db $D8, $F8, $12, $00 ; entry 5
    db $E0, $E0, $0C, $00 ; entry 6
    db $E0, $E8, $14, $00 ; entry 7
    db $E8, $F0, $14, $00 ; entry 8
    db $D8, $D8, $15, $00 ; entry 9
    db $D8, $E0, $16, $00 ; entry 10
    db $D8, $E8, $17, $00 ; entry 11
    db $F8, $E8, $0C, $00 ; entry 12
    db $F8, $F0, $0D, $00 ; entry 13
    db $F0, $D8, $05, $00 ; entry 14
    db $F0, $E0, $06, $00 ; entry 15
    db $F0, $E8, $07, $00 ; entry 16
    db $F0, $F0, $14, $00 ; entry 17
    db $F0, $F8, $0F, $00 ; entry 18
    db $F8, $F8, $17, $00 ; entry 19
    db $F0, $00, $17, $00 ; entry 20
    db $E0, $F0, $06, $00 ; entry 21
    db $E0, $F8, $07, $00 ; entry 22
    db $E0, $00, $08, $00 ; entry 23
    db $E0, $08, $09, $00 ; entry 24
    db $E8, $E0, $15, $00 ; entry 25
    db $E8, $E8, $16, $00 ; entry 26
    db $F0, $C8, $15, $00 ; entry 27
    db $F0, $D0, $16, $00 ; entry 28
    db $D8, $00, $09, $00 ; entry 29
    db $F8, $D8, $1A, $00 ; entry 30
    db $F8, $E0, $1B, $00 ; entry 31
    db $F8, $10, $20, $00 ; entry 32
    db $F8, $C0, $20, $20 ; entry 33
    db $F8, $C8, $13, $20 ; entry 34
    db $F8, $08, $13, $00 ; entry 35
    db $E8, $10, $1C, $20 ; entry 36
    db $E8, $D8, $1D, $20 ; entry 37
    db $D0, $E0, $1F, $20 ; entry 38
    db $D0, $38, $1E, $20 ; entry 39
    db $80 ; end

; E-0147 (derived: frame 18 of MetaSprites3E_4024Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0BFrame18::
Data_03E_7164:: ; heuristic: meta-sprite frame; C0
    db $D0, $D8, $05, $00 ; entry 0
    db $E0, $CC, $0B, $00 ; entry 1
    db $E0, $D4, $0C, $00 ; entry 2
    db $E0, $DC, $0D, $00 ; entry 3
    db $D0, $E0, $06, $00 ; entry 4
    db $D0, $E8, $08, $00 ; entry 5
    db $D0, $D0, $14, $00 ; entry 6
    db $D0, $B0, $15, $00 ; entry 7
    db $D0, $B8, $16, $00 ; entry 8
    db $D0, $C0, $17, $00 ; entry 9
    db $D0, $C8, $0E, $00 ; entry 10
    db $D8, $B8, $19, $00 ; entry 11
    db $D8, $C0, $1A, $00 ; entry 12
    db $D8, $C8, $14, $00 ; entry 13
    db $E0, $B4, $19, $00 ; entry 14
    db $E0, $BC, $1A, $00 ; entry 15
    db $E0, $C4, $0D, $00 ; entry 16
    db $D8, $D8, $07, $00 ; entry 17
    db $D8, $E0, $08, $00 ; entry 18
    db $D8, $E8, $09, $00 ; entry 19
    db $D8, $D0, $16, $00 ; entry 20
    db $D0, $F0, $09, $00 ; entry 21
    db $E8, $C4, $15, $00 ; entry 22
    db $E8, $CC, $16, $00 ; entry 23
    db $E8, $D4, $17, $00 ; entry 24
    db $E8, $DC, $12, $00 ; entry 25
    db $F0, $D8, $15, $00 ; entry 26
    db $F0, $E0, $16, $00 ; entry 27
    db $F0, $E8, $17, $00 ; entry 28
    db $F8, $E0, $05, $00 ; entry 29
    db $E8, $E4, $09, $00 ; entry 30
    db $F8, $C8, $15, $00 ; entry 31
    db $F8, $D0, $16, $00 ; entry 32
    db $F8, $D8, $17, $00 ; entry 33
    db $F8, $E8, $10, $00 ; entry 34
    db $F8, $F0, $11, $00 ; entry 35
    db $F8, $F8, $12, $00 ; entry 36
    db $F8, $08, $21, $00 ; entry 37
    db $F8, $B8, $21, $20 ; entry 38
    db $D0, $00, $1F, $00 ; entry 39
    db $80 ; end

; E-0147 (derived: frame 19 of MetaSprites3E_4024Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0BFrame19::
Data_03E_7205:: ; heuristic: meta-sprite frame; C0
    db $F8, $E8, $0E, $00 ; entry 0
    db $E0, $10, $0B, $00 ; entry 1
    db $E0, $18, $0C, $00 ; entry 2
    db $E0, $20, $0D, $00 ; entry 3
    db $D8, $10, $05, $00 ; entry 4
    db $D8, $18, $06, $00 ; entry 5
    db $D8, $20, $08, $00 ; entry 6
    db $DA, $28, $11, $00 ; entry 7
    db $DA, $30, $12, $00 ; entry 8
    db $E8, $00, $0A, $00 ; entry 9
    db $E8, $08, $0B, $00 ; entry 10
    db $E8, $10, $0C, $00 ; entry 11
    db $E8, $18, $0D, $00 ; entry 12
    db $D0, $F8, $10, $00 ; entry 13
    db $D0, $00, $11, $00 ; entry 14
    db $D0, $08, $12, $00 ; entry 15
    db $D0, $E8, $0E, $00 ; entry 16
    db $D0, $F0, $0F, $00 ; entry 17
    db $D8, $F0, $19, $00 ; entry 18
    db $D8, $F8, $1A, $00 ; entry 19
    db $D8, $00, $1B, $00 ; entry 20
    db $E0, $F8, $15, $00 ; entry 21
    db $D8, $08, $14, $00 ; entry 22
    db $E0, $00, $1A, $00 ; entry 23
    db $E0, $08, $1B, $00 ; entry 24
    db $F0, $E8, $19, $00 ; entry 25
    db $F0, $F0, $1A, $00 ; entry 26
    db $F0, $08, $10, $00 ; entry 27
    db $F0, $10, $11, $00 ; entry 28
    db $F0, $00, $0F, $00 ; entry 29
    db $F0, $F8, $1B, $00 ; entry 30
    db $D0, $10, $09, $00 ; entry 31
    db $F8, $D8, $19, $00 ; entry 32
    db $F8, $E0, $1A, $00 ; entry 33
    db $F8, $F0, $1A, $60 ; entry 34
    db $F8, $F8, $08, $00 ; entry 35
    db $F8, $00, $09, $00 ; entry 36
    db $F8, $C8, $13, $00 ; entry 37
    db $F8, $10, $13, $20 ; entry 38
    db $F0, $E0, $1E, $40 ; entry 39
    db $80 ; end

; E-0147 (derived: frame 20 of MetaSprites3E_4024Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0BFrame20::
Data_03E_72A6:: ; heuristic: meta-sprite frame; C0
    db $E8, $00, $0B, $00 ; entry 0
    db $E8, $08, $0C, $00 ; entry 1
    db $E8, $10, $0D, $00 ; entry 2
    db $E0, $E0, $04, $00 ; entry 3
    db $D8, $F8, $11, $00 ; entry 4
    db $D8, $00, $12, $00 ; entry 5
    db $E0, $E8, $0C, $00 ; entry 6
    db $E0, $F0, $14, $00 ; entry 7
    db $E8, $F8, $14, $00 ; entry 8
    db $D8, $E0, $15, $00 ; entry 9
    db $D8, $E8, $16, $00 ; entry 10
    db $D8, $F0, $17, $00 ; entry 11
    db $F8, $F0, $0C, $00 ; entry 12
    db $F8, $F8, $0D, $00 ; entry 13
    db $F0, $E0, $05, $00 ; entry 14
    db $F0, $E8, $06, $00 ; entry 15
    db $F0, $F0, $07, $00 ; entry 16
    db $F0, $F8, $14, $00 ; entry 17
    db $F0, $00, $0F, $00 ; entry 18
    db $F8, $00, $17, $00 ; entry 19
    db $F0, $08, $17, $00 ; entry 20
    db $E0, $F8, $06, $00 ; entry 21
    db $E0, $00, $07, $00 ; entry 22
    db $E0, $08, $08, $00 ; entry 23
    db $E0, $10, $09, $00 ; entry 24
    db $E8, $E8, $15, $00 ; entry 25
    db $E8, $F0, $16, $00 ; entry 26
    db $F0, $D0, $15, $00 ; entry 27
    db $F0, $D8, $16, $00 ; entry 28
    db $D8, $08, $09, $00 ; entry 29
    db $F8, $E0, $1A, $00 ; entry 30
    db $F8, $E8, $1B, $00 ; entry 31
    db $F8, $10, $21, $00 ; entry 32
    db $F8, $18, $20, $00 ; entry 33
    db $F8, $C8, $20, $20 ; entry 34
    db $F8, $D0, $21, $20 ; entry 35
    db $F0, $18, $1D, $00 ; entry 36
    db $D0, $F0, $1C, $00 ; entry 37
    db $D8, $10, $1D, $00 ; entry 38
    db $D8, $30, $1C, $00 ; entry 39
    db $80 ; end

; E-0147 (derived: frame 21 of MetaSprites3E_4024Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0BFrame21::
Data_03E_7347:: ; heuristic: meta-sprite frame; C0
    db $D0, $F0, $05, $00 ; entry 0
    db $E0, $E4, $0B, $00 ; entry 1
    db $E0, $EC, $0C, $00 ; entry 2
    db $E0, $F4, $0D, $00 ; entry 3
    db $D0, $F8, $06, $00 ; entry 4
    db $D0, $00, $08, $00 ; entry 5
    db $D0, $E8, $14, $00 ; entry 6
    db $D0, $C8, $15, $00 ; entry 7
    db $D0, $D0, $16, $00 ; entry 8
    db $D0, $D8, $17, $00 ; entry 9
    db $D0, $E0, $0E, $00 ; entry 10
    db $D8, $D0, $19, $00 ; entry 11
    db $D8, $D8, $1A, $00 ; entry 12
    db $D8, $E0, $14, $00 ; entry 13
    db $E0, $CC, $19, $00 ; entry 14
    db $E0, $D4, $1A, $00 ; entry 15
    db $E0, $DC, $0D, $00 ; entry 16
    db $D8, $F0, $07, $00 ; entry 17
    db $D8, $F8, $08, $00 ; entry 18
    db $D8, $00, $09, $00 ; entry 19
    db $D8, $E8, $16, $00 ; entry 20
    db $D0, $08, $09, $00 ; entry 21
    db $E8, $DC, $15, $00 ; entry 22
    db $E8, $E4, $16, $00 ; entry 23
    db $E8, $EC, $17, $00 ; entry 24
    db $E8, $F4, $12, $00 ; entry 25
    db $F0, $F0, $15, $00 ; entry 26
    db $F0, $F8, $16, $00 ; entry 27
    db $F0, $00, $17, $00 ; entry 28
    db $F8, $F8, $05, $00 ; entry 29
    db $E8, $FC, $09, $00 ; entry 30
    db $F8, $E0, $15, $00 ; entry 31
    db $F8, $E8, $16, $00 ; entry 32
    db $F8, $F0, $17, $00 ; entry 33
    db $F8, $00, $10, $00 ; entry 34
    db $F8, $08, $11, $00 ; entry 35
    db $F8, $10, $12, $00 ; entry 36
    db $F8, $D0, $21, $00 ; entry 37
    db $F8, $20, $21, $20 ; entry 38
    db $F8, $B0, $1E, $20 ; entry 39
    db $80 ; end

; E-0147 (derived: frame 22 of MetaSprites3E_4024Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0BFrame22::
Data_03E_73E8:: ; heuristic: meta-sprite frame; C0
    db $F8, $08, $0E, $00 ; entry 0
    db $E0, $30, $0B, $00 ; entry 1
    db $E0, $38, $0C, $00 ; entry 2
    db $D8, $30, $05, $00 ; entry 3
    db $D8, $38, $06, $00 ; entry 4
    db $E8, $20, $0A, $00 ; entry 5
    db $E8, $28, $0B, $00 ; entry 6
    db $E8, $30, $0C, $00 ; entry 7
    db $E8, $38, $0D, $00 ; entry 8
    db $D0, $18, $10, $00 ; entry 9
    db $D0, $20, $11, $00 ; entry 10
    db $D0, $28, $12, $00 ; entry 11
    db $D0, $08, $0E, $00 ; entry 12
    db $D0, $10, $0F, $00 ; entry 13
    db $D8, $10, $19, $00 ; entry 14
    db $D8, $18, $1A, $00 ; entry 15
    db $D8, $20, $1B, $00 ; entry 16
    db $E0, $18, $15, $00 ; entry 17
    db $D8, $28, $14, $00 ; entry 18
    db $E0, $20, $1A, $00 ; entry 19
    db $E0, $28, $1B, $00 ; entry 20
    db $F0, $08, $19, $00 ; entry 21
    db $F0, $10, $1A, $00 ; entry 22
    db $F0, $28, $10, $00 ; entry 23
    db $F0, $30, $11, $00 ; entry 24
    db $F0, $20, $0F, $00 ; entry 25
    db $F0, $18, $1B, $00 ; entry 26
    db $D0, $30, $09, $00 ; entry 27
    db $F8, $F8, $19, $00 ; entry 28
    db $F8, $00, $1A, $00 ; entry 29
    db $F8, $10, $1A, $60 ; entry 30
    db $F8, $18, $08, $00 ; entry 31
    db $F8, $20, $09, $00 ; entry 32
    db $E0, $40, $0D, $00 ; entry 33
    db $D8, $40, $08, $00 ; entry 34
    db $DA, $48, $11, $00 ; entry 35
    db $F8, $30, $13, $00 ; entry 36
    db $F8, $E8, $13, $20 ; entry 37
    db $E8, $D8, $1F, $00 ; entry 38
    db $D0, $F0, $1D, $00 ; entry 39
    db $80 ; end

; E-0147 (derived: frame 23 of MetaSprites3E_4024Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0BFrame23::
Data_03E_7489:: ; heuristic: meta-sprite frame; C0
    db $E8, $28, $0B, $00 ; entry 0
    db $E8, $30, $0C, $00 ; entry 1
    db $E8, $38, $0D, $00 ; entry 2
    db $E0, $08, $04, $00 ; entry 3
    db $D8, $20, $11, $00 ; entry 4
    db $D8, $28, $12, $00 ; entry 5
    db $E0, $10, $0C, $00 ; entry 6
    db $E0, $18, $14, $00 ; entry 7
    db $E8, $20, $14, $00 ; entry 8
    db $D8, $08, $15, $00 ; entry 9
    db $D8, $10, $16, $00 ; entry 10
    db $D8, $18, $17, $00 ; entry 11
    db $F8, $18, $0C, $00 ; entry 12
    db $F8, $20, $0D, $00 ; entry 13
    db $F0, $08, $05, $00 ; entry 14
    db $F0, $10, $06, $00 ; entry 15
    db $F0, $18, $07, $00 ; entry 16
    db $F0, $20, $14, $00 ; entry 17
    db $F0, $28, $0F, $00 ; entry 18
    db $F8, $28, $17, $00 ; entry 19
    db $F0, $30, $17, $00 ; entry 20
    db $E0, $20, $06, $00 ; entry 21
    db $E0, $28, $07, $00 ; entry 22
    db $E0, $30, $08, $00 ; entry 23
    db $E0, $38, $09, $00 ; entry 24
    db $E8, $10, $15, $00 ; entry 25
    db $E8, $18, $16, $00 ; entry 26
    db $F0, $F8, $15, $00 ; entry 27
    db $F0, $00, $16, $00 ; entry 28
    db $D8, $30, $09, $00 ; entry 29
    db $F8, $08, $1A, $00 ; entry 30
    db $F8, $10, $1B, $00 ; entry 31
    db $F8, $38, $20, $00 ; entry 32
    db $F8, $40, $21, $00 ; entry 33
    db $F8, $F8, $20, $20 ; entry 34
    db $F8, $F0, $21, $20 ; entry 35
    db $E0, $00, $1F, $00 ; entry 36
    db $F8, $D8, $1D, $00 ; entry 37
    db $D0, $20, $1F, $00 ; entry 38
    db $E0, $48, $1C, $00 ; entry 39
    db $80 ; end

; E-0147 (derived: frame 24 of MetaSprites3E_4024Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0BFrame24::
Data_03E_752A:: ; heuristic: meta-sprite frame; C0
    db $D0, $20, $05, $00 ; entry 0
    db $E0, $14, $0B, $00 ; entry 1
    db $E0, $1C, $0C, $00 ; entry 2
    db $E0, $24, $0D, $00 ; entry 3
    db $D0, $28, $06, $00 ; entry 4
    db $D0, $30, $08, $00 ; entry 5
    db $D0, $18, $14, $00 ; entry 6
    db $D0, $F8, $15, $00 ; entry 7
    db $D0, $00, $16, $00 ; entry 8
    db $D0, $08, $17, $00 ; entry 9
    db $D0, $10, $0E, $00 ; entry 10
    db $D8, $00, $19, $00 ; entry 11
    db $D8, $08, $1A, $00 ; entry 12
    db $D8, $10, $14, $00 ; entry 13
    db $E0, $FC, $19, $00 ; entry 14
    db $E0, $04, $1A, $00 ; entry 15
    db $E0, $0C, $0D, $00 ; entry 16
    db $D8, $20, $07, $00 ; entry 17
    db $D8, $28, $08, $00 ; entry 18
    db $D8, $30, $09, $00 ; entry 19
    db $D8, $18, $16, $00 ; entry 20
    db $D0, $38, $09, $00 ; entry 21
    db $E8, $0C, $15, $00 ; entry 22
    db $E8, $14, $16, $00 ; entry 23
    db $E8, $1C, $17, $00 ; entry 24
    db $E8, $24, $12, $00 ; entry 25
    db $F0, $20, $15, $00 ; entry 26
    db $F0, $28, $16, $00 ; entry 27
    db $F0, $30, $17, $00 ; entry 28
    db $F8, $28, $05, $00 ; entry 29
    db $E8, $2C, $09, $00 ; entry 30
    db $F8, $10, $15, $00 ; entry 31
    db $F8, $18, $16, $00 ; entry 32
    db $F8, $20, $17, $00 ; entry 33
    db $F8, $30, $10, $00 ; entry 34
    db $F8, $38, $11, $00 ; entry 35
    db $F8, $00, $20, $00 ; entry 36
    db $F8, $48, $20, $20 ; entry 37
    db $F8, $F0, $1C, $00 ; entry 38
    db $E8, $34, $1D, $00 ; entry 39
    db $80 ; end

; E-0147 (derived: frame 25 of MetaSprites3E_4024Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0BFrame25::
Data_03E_75CB:: ; heuristic: meta-sprite frame; C0
    db $F8, $40, $0E, $00 ; entry 0
    db $D0, $40, $0E, $00 ; entry 1
    db $D0, $48, $0F, $00 ; entry 2
    db $D8, $48, $19, $00 ; entry 3
    db $F0, $40, $19, $00 ; entry 4
    db $F0, $48, $1A, $00 ; entry 5
    db $F8, $30, $19, $00 ; entry 6
    db $F8, $38, $1A, $00 ; entry 7
    db $F8, $48, $1A, $60 ; entry 8
    db $F8, $20, $20, $20 ; entry 9
    db $F8, $18, $21, $20 ; entry 10
    db $E8, $00, $1C, $20 ; entry 11
    db $E8, $28, $1F, $00 ; entry 12
    db $F8, $10, $1E, $20 ; entry 13
    db $80 ; end

; E-0147 (derived: frame 26 of MetaSprites3E_4024Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0BFrame26::
Data_03E_7604:: ; heuristic: meta-sprite frame; C0
    db $D0, $20, $1D, $00 ; entry 0
    db $D8, $38, $1F, $00 ; entry 1
    db $F8, $48, $1C, $00 ; entry 2
    db $D0, $48, $1E, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 27 of MetaSprites3E_4024Set0B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0BFrame27::
    db $80 ; end

; E-0147 (derived: meta-sprite set 12 of MetaSprites3E_4024Table: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3E_4024Set0C::
Data_03E_7616:: ; heuristic: meta-sprite set; C0
    dw MetaSprites3E_4024Set0CFrame0 ; entry 0
    dw MetaSprites3E_4024Set0CFrame1 ; entry 1
    dw MetaSprites3E_4024Set0CFrame2 ; entry 2
    dw MetaSprites3E_4024Set0CFrame3 ; entry 3
    dw MetaSprites3E_4024Set0CFrame4 ; entry 4
    dw MetaSprites3E_4024Set0CFrame5 ; entry 5
    dw MetaSprites3E_4024Set0CFrame6 ; entry 6
    dw MetaSprites3E_4024Set0CFrame7 ; entry 7
    dw MetaSprites3E_4024Set0CFrame8 ; entry 8
    dw MetaSprites3E_4024Set0CFrame9 ; entry 9
    dw MetaSprites3E_4024Set0CFrame10 ; entry 10
    dw MetaSprites3E_4024Set0CFrame11 ; entry 11
    dw MetaSprites3E_4024Set0CFrame12 ; entry 12
    dw MetaSprites3E_4024Set0CFrame13 ; entry 13
    dw MetaSprites3E_4024Set0CFrame14 ; entry 14
    dw MetaSprites3E_4024Set0CFrame15 ; entry 15
    dw MetaSprites3E_4024Set0CFrame16 ; entry 16
    dw MetaSprites3E_4024Set0CFrame17 ; entry 17
    dw MetaSprites3E_4024Set0CFrame18 ; entry 18
    dw MetaSprites3E_4024Set0CFrame19 ; entry 19
    dw MetaSprites3E_4024Set0CFrame19 ; entry 20
    dw MetaSprites3E_4024Set0CFrame19 ; entry 21
    dw MetaSprites3E_4024Set0CFrame19 ; entry 22
    dw MetaSprites3E_4024Set0CFrame19 ; entry 23
    dw MetaSprites3E_4024Set0CFrame19 ; entry 24
    dw MetaSprites3E_4024Set0CFrame19 ; entry 25
    dw MetaSprites3E_4024Set0CFrame19 ; entry 26
    dw MetaSprites3E_4024Set0CFrame19 ; entry 27
    dw MetaSprites3E_4024Set0CFrame19 ; entry 28
    dw MetaSprites3E_4024Set0CFrame19 ; entry 29
    dw MetaSprites3E_4024Set0CFrame19 ; entry 30
    dw MetaSprites3E_4024Set0CFrame19 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3E_4024Set0C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0CFrame0::
Data_03E_7656:: ; heuristic: meta-sprite frame; C0
    db $F8, $B0, $04, $00 ; entry 0
    db $F8, $B8, $05, $00 ; entry 1
    db $F0, $B0, $01, $00 ; entry 2
    db $F0, $B8, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3E_4024Set0C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0CFrame1::
Data_03E_7667:: ; heuristic: meta-sprite frame; C0
    db $F8, $C4, $13, $20 ; entry 0
    db $F8, $BC, $14, $20 ; entry 1
    db $F8, $B4, $15, $20 ; entry 2
    db $F0, $C4, $10, $20 ; entry 3
    db $F0, $BC, $11, $20 ; entry 4
    db $F0, $B4, $12, $20 ; entry 5
    db $E8, $C4, $0E, $20 ; entry 6
    db $E8, $BC, $0F, $20 ; entry 7
    db $F0, $AC, $1C, $00 ; entry 8
    db $F8, $AC, $1D, $00 ; entry 9
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3E_4024Set0C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0CFrame2::
Data_03E_7690:: ; heuristic: meta-sprite frame; C0
    db $F8, $C0, $14, $00 ; entry 0
    db $F8, $C8, $15, $00 ; entry 1
    db $F0, $B8, $10, $00 ; entry 2
    db $F0, $C0, $11, $00 ; entry 3
    db $F0, $C8, $12, $00 ; entry 4
    db $E8, $B8, $0E, $00 ; entry 5
    db $E8, $C0, $0F, $00 ; entry 6
    db $F0, $B0, $01, $20 ; entry 7
    db $F8, $B0, $04, $20 ; entry 8
    db $F8, $D0, $18, $00 ; entry 9
    db $F8, $B8, $16, $20 ; entry 10
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3E_4024Set0C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0CFrame3::
Data_03E_76BD:: ; heuristic: meta-sprite frame; C0
    db $F8, $C4, $14, $20 ; entry 0
    db $F8, $BC, $15, $20 ; entry 1
    db $F0, $CC, $10, $20 ; entry 2
    db $F0, $C4, $11, $20 ; entry 3
    db $F0, $BC, $12, $20 ; entry 4
    db $E8, $CC, $0E, $20 ; entry 5
    db $E8, $C4, $0F, $00 ; entry 6
    db $F0, $B4, $01, $20 ; entry 7
    db $F8, $B4, $04, $20 ; entry 8
    db $F8, $D4, $08, $00 ; entry 9
    db $F0, $D4, $06, $00 ; entry 10
    db $F0, $DC, $07, $00 ; entry 11
    db $F8, $CC, $17, $20 ; entry 12
    db $F8, $DC, $19, $00 ; entry 13
    db $F0, $AC, $1E, $00 ; entry 14
    db $F8, $AC, $1F, $00 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3E_4024Set0C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0CFrame4::
Data_03E_76FE:: ; heuristic: meta-sprite frame; C0
    db $F8, $B8, $08, $20 ; entry 0
    db $F8, $B0, $09, $20 ; entry 1
    db $F0, $B8, $06, $20 ; entry 2
    db $F0, $B0, $07, $20 ; entry 3
    db $F8, $C0, $03, $00 ; entry 4
    db $F8, $C8, $04, $00 ; entry 5
    db $F8, $D0, $05, $00 ; entry 6
    db $F0, $C0, $00, $00 ; entry 7
    db $F0, $C8, $01, $00 ; entry 8
    db $F0, $D0, $02, $00 ; entry 9
    db $F8, $E0, $04, $20 ; entry 10
    db $F8, $D8, $05, $20 ; entry 11
    db $F0, $E8, $00, $20 ; entry 12
    db $F0, $E0, $01, $20 ; entry 13
    db $F0, $D8, $02, $20 ; entry 14
    db $F8, $E8, $1A, $00 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3E_4024Set0C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0CFrame5::
Data_03E_773F:: ; heuristic: meta-sprite frame; C0
    db $F8, $DC, $03, $20 ; entry 0
    db $F0, $DC, $00, $20 ; entry 1
    db $F8, $F4, $13, $20 ; entry 2
    db $F8, $EC, $14, $20 ; entry 3
    db $F8, $E4, $15, $20 ; entry 4
    db $F0, $F4, $10, $20 ; entry 5
    db $F0, $EC, $11, $20 ; entry 6
    db $F0, $E4, $12, $20 ; entry 7
    db $E8, $F4, $0E, $20 ; entry 8
    db $E8, $EC, $0F, $20 ; entry 9
    db $F8, $D4, $08, $20 ; entry 10
    db $F8, $CC, $09, $20 ; entry 11
    db $F0, $D4, $06, $20 ; entry 12
    db $F0, $CC, $07, $20 ; entry 13
    db $F8, $C4, $0B, $20 ; entry 14
    db $F8, $BC, $0C, $20 ; entry 15
    db $F8, $B4, $0D, $20 ; entry 16
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3E_4024Set0C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0CFrame6::
Data_03E_7784:: ; heuristic: meta-sprite frame; C0
    db $F8, $F0, $14, $00 ; entry 0
    db $F8, $F8, $15, $00 ; entry 1
    db $F0, $E8, $10, $00 ; entry 2
    db $F0, $F0, $11, $00 ; entry 3
    db $F0, $F8, $12, $00 ; entry 4
    db $E8, $E8, $0E, $00 ; entry 5
    db $E8, $F0, $0F, $00 ; entry 6
    db $F0, $E0, $01, $20 ; entry 7
    db $F0, $D8, $02, $20 ; entry 8
    db $F8, $E0, $04, $20 ; entry 9
    db $F8, $D8, $05, $20 ; entry 10
    db $F8, $00, $18, $00 ; entry 11
    db $F8, $E8, $16, $20 ; entry 12
    db $F8, $C8, $0B, $00 ; entry 13
    db $F8, $D0, $0C, $00 ; entry 14
    db $F8, $B8, $0D, $20 ; entry 15
    db $F8, $C0, $0C, $00 ; entry 16
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3E_4024Set0C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0CFrame7::
Data_03E_77C9:: ; heuristic: meta-sprite frame; C0
    db $F8, $F4, $14, $20 ; entry 0
    db $F8, $EC, $15, $20 ; entry 1
    db $F0, $FC, $10, $20 ; entry 2
    db $F0, $F4, $11, $20 ; entry 3
    db $F0, $EC, $12, $20 ; entry 4
    db $E8, $FC, $0E, $20 ; entry 5
    db $E8, $F4, $0F, $00 ; entry 6
    db $F0, $E4, $01, $20 ; entry 7
    db $F0, $DC, $02, $20 ; entry 8
    db $F8, $E4, $04, $20 ; entry 9
    db $F8, $DC, $05, $20 ; entry 10
    db $F8, $04, $08, $00 ; entry 11
    db $F0, $04, $06, $00 ; entry 12
    db $F0, $0C, $07, $00 ; entry 13
    db $F8, $FC, $17, $20 ; entry 14
    db $F8, $D4, $0C, $20 ; entry 15
    db $F8, $0C, $19, $00 ; entry 16
    db $F8, $C4, $1B, $20 ; entry 17
    db $F8, $CC, $0B, $20 ; entry 18
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites3E_4024Set0C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0CFrame8::
Data_03E_7816:: ; heuristic: meta-sprite frame; C0
    db $F8, $D8, $0C, $20 ; entry 0
    db $F8, $D0, $0D, $20 ; entry 1
    db $F8, $E8, $08, $20 ; entry 2
    db $F8, $E0, $09, $20 ; entry 3
    db $F0, $E8, $06, $20 ; entry 4
    db $F0, $E0, $07, $20 ; entry 5
    db $F8, $F0, $03, $00 ; entry 6
    db $F8, $F8, $04, $00 ; entry 7
    db $F8, $00, $05, $00 ; entry 8
    db $F0, $F0, $00, $00 ; entry 9
    db $F0, $F8, $01, $00 ; entry 10
    db $F0, $00, $02, $00 ; entry 11
    db $F8, $10, $04, $20 ; entry 12
    db $F8, $08, $05, $20 ; entry 13
    db $F0, $18, $00, $20 ; entry 14
    db $F0, $10, $01, $20 ; entry 15
    db $F0, $08, $02, $20 ; entry 16
    db $F8, $18, $1A, $00 ; entry 17
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites3E_4024Set0C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0CFrame9::
Data_03E_785F:: ; heuristic: meta-sprite frame; C0
    db $F8, $0C, $03, $20 ; entry 0
    db $F0, $0C, $00, $20 ; entry 1
    db $F8, $24, $13, $20 ; entry 2
    db $F8, $1C, $14, $20 ; entry 3
    db $F8, $14, $15, $20 ; entry 4
    db $F0, $24, $10, $20 ; entry 5
    db $F0, $1C, $11, $20 ; entry 6
    db $F0, $14, $12, $20 ; entry 7
    db $E8, $24, $0E, $20 ; entry 8
    db $E8, $1C, $0F, $20 ; entry 9
    db $F8, $04, $08, $20 ; entry 10
    db $F8, $FC, $09, $20 ; entry 11
    db $F0, $04, $06, $20 ; entry 12
    db $F0, $FC, $07, $20 ; entry 13
    db $F8, $F4, $0B, $20 ; entry 14
    db $F8, $EC, $0C, $20 ; entry 15
    db $F8, $E4, $0D, $20 ; entry 16
    db $F8, $DC, $0E, $20 ; entry 17
    db $80 ; end

; E-0147 (derived: frame 10 of MetaSprites3E_4024Set0C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0CFrame10::
Data_03E_78A8:: ; heuristic: meta-sprite frame; C0
    db $F8, $20, $14, $00 ; entry 0
    db $F8, $28, $15, $00 ; entry 1
    db $F0, $18, $10, $00 ; entry 2
    db $F0, $20, $11, $00 ; entry 3
    db $F0, $28, $12, $00 ; entry 4
    db $E8, $18, $0E, $00 ; entry 5
    db $E8, $20, $0F, $00 ; entry 6
    db $F0, $10, $01, $20 ; entry 7
    db $F0, $08, $02, $20 ; entry 8
    db $F8, $10, $04, $20 ; entry 9
    db $F8, $08, $05, $20 ; entry 10
    db $F8, $30, $18, $00 ; entry 11
    db $F8, $18, $16, $20 ; entry 12
    db $F8, $F8, $0B, $00 ; entry 13
    db $F8, $00, $0C, $00 ; entry 14
    db $F8, $E8, $0D, $20 ; entry 15
    db $F8, $F0, $0C, $00 ; entry 16
    db $80 ; end

; E-0147 (derived: frame 11 of MetaSprites3E_4024Set0C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0CFrame11::
Data_03E_78ED:: ; heuristic: meta-sprite frame; C0
    db $F8, $24, $14, $20 ; entry 0
    db $F8, $1C, $15, $20 ; entry 1
    db $F0, $2C, $10, $20 ; entry 2
    db $F0, $24, $11, $20 ; entry 3
    db $F0, $1C, $12, $20 ; entry 4
    db $E8, $2C, $0E, $20 ; entry 5
    db $E8, $24, $0F, $00 ; entry 6
    db $F0, $14, $01, $20 ; entry 7
    db $F0, $0C, $02, $20 ; entry 8
    db $F8, $14, $04, $20 ; entry 9
    db $F8, $0C, $05, $20 ; entry 10
    db $F8, $34, $08, $00 ; entry 11
    db $F0, $34, $06, $00 ; entry 12
    db $F0, $3C, $07, $00 ; entry 13
    db $F8, $2C, $17, $20 ; entry 14
    db $F8, $04, $0C, $20 ; entry 15
    db $F8, $3C, $19, $00 ; entry 16
    db $F8, $F4, $1B, $20 ; entry 17
    db $F8, $FC, $0B, $20 ; entry 18
    db $80 ; end

; E-0147 (derived: frame 12 of MetaSprites3E_4024Set0C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0CFrame12::
Data_03E_793A:: ; heuristic: meta-sprite frame; C0
    db $F8, $08, $0C, $20 ; entry 0
    db $F8, $00, $0D, $20 ; entry 1
    db $F8, $18, $08, $20 ; entry 2
    db $F8, $10, $09, $20 ; entry 3
    db $F0, $18, $06, $20 ; entry 4
    db $F0, $10, $07, $20 ; entry 5
    db $F8, $20, $03, $00 ; entry 6
    db $F8, $28, $04, $00 ; entry 7
    db $F8, $30, $05, $00 ; entry 8
    db $F0, $20, $00, $00 ; entry 9
    db $F0, $28, $01, $00 ; entry 10
    db $F0, $30, $02, $00 ; entry 11
    db $F8, $40, $04, $20 ; entry 12
    db $F8, $38, $05, $20 ; entry 13
    db $F0, $48, $00, $20 ; entry 14
    db $F0, $40, $01, $20 ; entry 15
    db $F0, $38, $02, $20 ; entry 16
    db $F8, $48, $1A, $00 ; entry 17
    db $80 ; end

; E-0147 (derived: frame 13 of MetaSprites3E_4024Set0C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0CFrame13::
Data_03E_7983:: ; heuristic: meta-sprite frame; C0
    db $F8, $3C, $03, $20 ; entry 0
    db $F0, $3C, $00, $20 ; entry 1
    db $F8, $44, $15, $20 ; entry 2
    db $F0, $44, $12, $20 ; entry 3
    db $F8, $34, $08, $20 ; entry 4
    db $F8, $2C, $09, $20 ; entry 5
    db $F0, $34, $06, $20 ; entry 6
    db $F0, $2C, $07, $20 ; entry 7
    db $F8, $24, $0B, $20 ; entry 8
    db $F8, $1C, $0C, $20 ; entry 9
    db $F8, $14, $0D, $20 ; entry 10
    db $F8, $0C, $0E, $20 ; entry 11
    db $E8, $4C, $20, $00 ; entry 12
    db $F0, $4C, $21, $00 ; entry 13
    db $F8, $4C, $22, $00 ; entry 14
    db $80 ; end

; E-0147 (derived: frame 14 of MetaSprites3E_4024Set0C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0CFrame14::
Data_03E_79C0:: ; heuristic: meta-sprite frame; C0
    db $F0, $48, $10, $00 ; entry 0
    db $E8, $48, $0E, $00 ; entry 1
    db $F0, $40, $01, $20 ; entry 2
    db $F0, $38, $02, $20 ; entry 3
    db $F8, $40, $04, $20 ; entry 4
    db $F8, $38, $05, $20 ; entry 5
    db $F8, $48, $16, $20 ; entry 6
    db $F8, $28, $0B, $00 ; entry 7
    db $F8, $30, $0C, $00 ; entry 8
    db $F8, $18, $0D, $20 ; entry 9
    db $F8, $20, $0C, $00 ; entry 10
    db $80 ; end

; E-0147 (derived: frame 15 of MetaSprites3E_4024Set0C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0CFrame15::
Data_03E_79ED:: ; heuristic: meta-sprite frame; C0
    db $F0, $44, $01, $20 ; entry 0
    db $F0, $3C, $02, $20 ; entry 1
    db $F8, $44, $04, $20 ; entry 2
    db $F8, $3C, $05, $20 ; entry 3
    db $F8, $34, $0C, $20 ; entry 4
    db $F8, $24, $1B, $20 ; entry 5
    db $F8, $2C, $0B, $20 ; entry 6
    db $F0, $4C, $23, $00 ; entry 7
    db $F8, $4C, $24, $00 ; entry 8
    db $80 ; end

; E-0147 (derived: frame 16 of MetaSprites3E_4024Set0C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0CFrame16::
Data_03E_7A12:: ; heuristic: meta-sprite frame; C0
    db $F0, $48, $02, $20 ; entry 0
    db $F8, $48, $05, $20 ; entry 1
    db $F8, $40, $0C, $20 ; entry 2
    db $F8, $30, $1B, $20 ; entry 3
    db $F8, $38, $0B, $20 ; entry 4
    db $80 ; end

; E-0147 (derived: frame 17 of MetaSprites3E_4024Set0C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0CFrame17::
Data_03E_7A27:: ; heuristic: meta-sprite frame; C0
    db $F8, $44, $0C, $20 ; entry 0
    db $F8, $3C, $0D, $20 ; entry 1
    db $F8, $4C, $25, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 18 of MetaSprites3E_4024Set0C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0CFrame18::
Data_03E_7A34:: ; heuristic: meta-sprite frame; C0
    db $F8, $48, $0E, $20 ; entry 0
    db $80 ; end

; E-0147 (derived: frame 19 of MetaSprites3E_4024Set0C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0CFrame19::
    db $80 ; end

; E-0147 (derived: meta-sprite set 13 of MetaSprites3E_4024Table: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3E_4024Set0D::
Data_03E_7A3A:: ; heuristic: meta-sprite set; C0
    dw MetaSprites3E_4024Set0DFrame0 ; entry 0
    dw MetaSprites3E_4024Set0DFrame1 ; entry 1
    dw MetaSprites3E_4024Set0DFrame2 ; entry 2
    dw MetaSprites3E_4024Set0DFrame3 ; entry 3
    dw MetaSprites3E_4024Set0DFrame4 ; entry 4
    dw MetaSprites3E_4024Set0DFrame5 ; entry 5
    dw MetaSprites3E_4024Set0DFrame5 ; entry 6
    dw MetaSprites3E_4024Set0DFrame5 ; entry 7
    dw MetaSprites3E_4024Set0DFrame5 ; entry 8
    dw MetaSprites3E_4024Set0DFrame5 ; entry 9
    dw MetaSprites3E_4024Set0DFrame5 ; entry 10
    dw MetaSprites3E_4024Set0DFrame5 ; entry 11
    dw MetaSprites3E_4024Set0DFrame5 ; entry 12
    dw MetaSprites3E_4024Set0DFrame5 ; entry 13
    dw MetaSprites3E_4024Set0DFrame5 ; entry 14
    dw MetaSprites3E_4024Set0DFrame5 ; entry 15
    dw MetaSprites3E_4024Set0DFrame5 ; entry 16
    dw MetaSprites3E_4024Set0DFrame5 ; entry 17
    dw MetaSprites3E_4024Set0DFrame5 ; entry 18
    dw MetaSprites3E_4024Set0DFrame5 ; entry 19
    dw MetaSprites3E_4024Set0DFrame5 ; entry 20
    dw MetaSprites3E_4024Set0DFrame5 ; entry 21
    dw MetaSprites3E_4024Set0DFrame5 ; entry 22
    dw MetaSprites3E_4024Set0DFrame5 ; entry 23
    dw MetaSprites3E_4024Set0DFrame5 ; entry 24
    dw MetaSprites3E_4024Set0DFrame5 ; entry 25
    dw MetaSprites3E_4024Set0DFrame5 ; entry 26
    dw MetaSprites3E_4024Set0DFrame5 ; entry 27
    dw MetaSprites3E_4024Set0DFrame5 ; entry 28
    dw MetaSprites3E_4024Set0DFrame5 ; entry 29
    dw MetaSprites3E_4024Set0DFrame5 ; entry 30
    dw MetaSprites3E_4024Set0DFrame5 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3E_4024Set0D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0DFrame0::
Data_03E_7A7A:: ; heuristic: meta-sprite frame; C0
    db $F8, $F8, $22, $00 ; entry 0
    db $F8, $00, $23, $00 ; entry 1
    db $F0, $F8, $20, $00 ; entry 2
    db $F0, $00, $21, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3E_4024Set0D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0DFrame1::
Data_03E_7A8B:: ; heuristic: meta-sprite frame; C0
    db $F8, $F4, $1D, $00 ; entry 0
    db $F8, $FC, $1E, $00 ; entry 1
    db $F8, $04, $1F, $00 ; entry 2
    db $F0, $F4, $1A, $00 ; entry 3
    db $F0, $FC, $1B, $00 ; entry 4
    db $F0, $04, $1C, $00 ; entry 5
    db $E8, $FC, $19, $00 ; entry 6
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3E_4024Set0D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0DFrame2::
Data_03E_7AA8:: ; heuristic: meta-sprite frame; C0
    db $F0, $F4, $1D, $00 ; entry 0
    db $F0, $FC, $1E, $00 ; entry 1
    db $F0, $04, $1F, $00 ; entry 2
    db $E8, $F4, $1A, $00 ; entry 3
    db $E8, $FC, $1B, $00 ; entry 4
    db $E8, $04, $1C, $00 ; entry 5
    db $E0, $FC, $19, $00 ; entry 6
    db $F8, $F4, $22, $00 ; entry 7
    db $F8, $04, $23, $00 ; entry 8
    db $F8, $FC, $0E, $00 ; entry 9
    db $F8, $EC, $1F, $20 ; entry 10
    db $F0, $EC, $1C, $20 ; entry 11
    db $F8, $0C, $1D, $20 ; entry 12
    db $F0, $0C, $1A, $20 ; entry 13
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3E_4024Set0D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0DFrame3::
Data_03E_7AE1:: ; heuristic: meta-sprite frame; C0
    db $D0, $F8, $00, $20 ; entry 0
    db $D8, $00, $01, $20 ; entry 1
    db $D8, $F8, $02, $20 ; entry 2
    db $E0, $00, $04, $20 ; entry 3
    db $E0, $F8, $05, $20 ; entry 4
    db $E0, $F0, $06, $20 ; entry 5
    db $E8, $10, $07, $20 ; entry 6
    db $E8, $08, $08, $20 ; entry 7
    db $E8, $00, $09, $20 ; entry 8
    db $E8, $F8, $0A, $20 ; entry 9
    db $E8, $F0, $0B, $20 ; entry 10
    db $E8, $E8, $0C, $20 ; entry 11
    db $F0, $10, $0D, $20 ; entry 12
    db $F0, $08, $0E, $20 ; entry 13
    db $F0, $00, $0F, $20 ; entry 14
    db $F0, $F8, $10, $20 ; entry 15
    db $F0, $F0, $11, $20 ; entry 16
    db $F0, $E8, $12, $20 ; entry 17
    db $F8, $10, $13, $20 ; entry 18
    db $F8, $08, $14, $20 ; entry 19
    db $F8, $00, $15, $20 ; entry 20
    db $F8, $F8, $16, $20 ; entry 21
    db $F8, $F0, $17, $20 ; entry 22
    db $F8, $E8, $18, $20 ; entry 23
    db $E0, $0C, $03, $20 ; entry 24
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3E_4024Set0D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0DFrame4::
Data_03E_7B46:: ; heuristic: meta-sprite frame; C0
    db $D0, $00, $00, $00 ; entry 0
    db $D8, $F8, $01, $00 ; entry 1
    db $D8, $00, $02, $00 ; entry 2
    db $E0, $F8, $04, $00 ; entry 3
    db $E0, $00, $05, $00 ; entry 4
    db $E0, $08, $06, $00 ; entry 5
    db $E8, $E8, $07, $00 ; entry 6
    db $E8, $F0, $08, $00 ; entry 7
    db $E8, $F8, $09, $00 ; entry 8
    db $E8, $00, $0A, $00 ; entry 9
    db $E8, $08, $0B, $00 ; entry 10
    db $E8, $10, $0C, $00 ; entry 11
    db $F0, $E8, $0D, $00 ; entry 12
    db $F0, $F0, $0E, $00 ; entry 13
    db $F0, $F8, $0F, $00 ; entry 14
    db $F0, $00, $10, $00 ; entry 15
    db $F0, $08, $11, $00 ; entry 16
    db $F0, $10, $12, $00 ; entry 17
    db $F8, $E8, $13, $00 ; entry 18
    db $F8, $F0, $14, $00 ; entry 19
    db $F8, $F8, $15, $00 ; entry 20
    db $F8, $00, $16, $00 ; entry 21
    db $F8, $08, $17, $00 ; entry 22
    db $F8, $10, $18, $00 ; entry 23
    db $E0, $EC, $03, $00 ; entry 24
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3E_4024Set0D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3E_4024Set0DFrame5::
    db $80 ; end
    ds $454, $00
