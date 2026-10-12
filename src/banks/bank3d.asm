SECTION "Bank 3D", ROMX[$4000], BANK[$3D]
    db $3D

; only called from DrawEffectSpriteForEffectTileOffsetRange (E-0047)
; 1 call site from 1 routine (e.g. DrawEffectSpriteForEffectTileOffsetRange)
; reads: wEffectTileOffset, wBattleFoeCount, wBattleTarget, wEffectSpriteX, wEffectSpriteAttrXor
; writes: wLoadSlot, wBattleArg0
; points at: wLoadSlot, wBattleArg0, hSpriteOriginX
DrawEffectSpriteForEffectTileOffsetRange_CarryUnlessBattleSlotOutSlotEmpty::
Func_03D_4001:: ; address name
    ld a, [wEffectTileOffset]
    cp a, $2C
    jr nz, DrawEffectSpriteAtEffectSpriteX_Bank3D
    ld a, [wBattleFoeCount]
    ld [wLoadSlot], a
    ld a, [wBattleTarget]
    and a, $04
    ld [wBattleArg0], a
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .skip
    farcall SetEffectSpriteXForTargets
    call DrawEffectSpriteAtEffectSpriteX_Bank3D

.skip:
    ld hl, wLoadSlot
    dec [hl]
    ld a, [hl]
    or a, a
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
    or a, a
    ret z
    ld hl, wBattleArg0
    inc [hl]
    ld a, [hl]
    call CarryUnlessBattleSlotOutSlotEmpty
    ret c
    farcall SetEffectSpriteXForTargets

; sets the sprite origin X = wD804, Y = $68, tile offset = wD801, attribute XOR = wDAB7, then builds OAM from the local sprite table (E-0121)
; 2 call sites from 1 routine (e.g. DrawEffectSpriteForEffectTileOffsetRange_CarryUnlessBattleSlotOutSlotEmpty)
; reads: wEffectSpriteX, wEffectTileOffset, wEffectSpriteAttrXor
; points at: hSpriteOriginX
DrawEffectSpriteAtEffectSpriteX_Bank3D::
Func_03D_4054:: ; address name
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
    ld de, MetaSprites3D_4077Table
    call BuildOamFromSpriteTable_Bank3D
    ret

; E-0147 (C1: the caller of BuildOamFromSpriteTable_Bank3D passes DE = $3D:4077; the builder takes the word at DE + 2 * hSpriteSetIndex as the set and the word at set + 2 * hSpriteSubIndex as the frame; 45 words, up to the next code or data).
; record: meta-sprite set
MetaSprites3D_4077Table::
Data_03D_4077:: ; address name
    dw MetaSprites3D_4077Set00 ; id 0
    dw MetaSprites3D_4077Set00 ; id 1
    dw MetaSprites3D_4077Set00 ; id 2
    dw MetaSprites3D_4077Set00 ; id 3
    dw MetaSprites3D_4077Set00 ; id 4
    dw MetaSprites3D_4077Set00 ; id 5
    dw MetaSprites3D_4077Set00 ; id 6
    dw MetaSprites3D_4077Set00 ; id 7
    dw MetaSprites3D_4077Set00 ; id 8
    dw MetaSprites3D_4077Set00 ; id 9
    dw MetaSprites3D_4077Set00 ; id 10
    dw MetaSprites3D_4077Set00 ; id 11
    dw MetaSprites3D_4077Set00 ; id 12
    dw MetaSprites3D_4077Set00 ; id 13
    dw MetaSprites3D_4077Set00 ; id 14
    dw MetaSprites3D_4077Set00 ; id 15
    dw MetaSprites3D_4077Set00 ; id 16
    dw MetaSprites3D_4077Set00 ; id 17
    dw MetaSprites3D_4077Set00 ; id 18
    dw MetaSprites3D_4077Set00 ; id 19
    dw MetaSprites3D_4077Set00 ; id 20
    dw MetaSprites3D_4077Set00 ; id 21
    dw MetaSprites3D_4077Set00 ; id 22
    dw MetaSprites3D_4077Set00 ; id 23
    dw MetaSprites3D_4077Set00 ; id 24
    dw MetaSprites3D_4077Set00 ; id 25
    dw MetaSprites3D_4077Set00 ; id 26
    dw MetaSprites3D_4077Set00 ; id 27
    dw MetaSprites3D_4077Set00 ; id 28
    dw MetaSprites3D_4077Set00 ; id 29
    dw MetaSprites3D_4077Set00 ; id 30
    dw MetaSprites3D_4077Set00 ; id 31
    dw MetaSprites3D_4077Set00 ; id 32
    dw MetaSprites3D_4077Set21 ; id 33
    dw MetaSprites3D_4077Set22 ; id 34
    dw MetaSprites3D_4077Set23 ; id 35
    dw MetaSprites3D_4077Set24 ; id 36
    dw MetaSprites3D_4077Set25 ; id 37
    dw MetaSprites3D_4077Set26 ; id 38
    dw MetaSprites3D_4077Set27 ; id 39
    dw MetaSprites3D_4077Set28 ; id 40
    dw MetaSprites3D_4077Set29 ; id 41
    dw MetaSprites3D_4077Set2A ; id 42
    dw MetaSprites3D_4077Set2B ; id 43
    dw MetaSprites3D_4077Set2C ; id 44

; DE = two-level table; entries are chosen by hSpriteSetIndex and hSpriteSubIndex; writes 4-byte OAM entries at $C000 + 4 * hOamNextEntry (Y = hSpriteOriginY + b + $10, X = hSpriteOriginX + b + 8, tile += hSpriteTileOffset, flags ^= hSpriteAttrXor) until a $80 byte or hOamNextEntry reaches $28 (40 entries) (the same 81 bytes appear in 5 banks)
; 1 call site from 1 routine (e.g. DrawEffectSpriteAtEffectSpriteX_Bank3D)
; reads: hOamNextEntry, hSpriteSetIndex, hSpriteSubIndex, hSpriteOriginY, hSpriteOriginX, hSpriteTileOffset, hSpriteAttrXor
; writes: hOamNextEntry
BuildOamFromSpriteTable_Bank3D::
Func_03D_40D1:: ; address name
    ldh a, [hOamNextEntry]
    cp a, $28
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
    ld h, $C0

.loop:
    ld a, [de]
    inc de
    cp a, $80
    jr z, .return
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
    jr c, .loop

.return:
    ret

; E-0147 (derived: meta-sprite set 0 of MetaSprites3D_4077Table: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3D_4077Set00::
Data_03D_4122:: ; address name
    dw MetaSprites3D_4077Set00Frame0 ; entry 0
    dw MetaSprites3D_4077Set00Frame1 ; entry 1
    dw MetaSprites3D_4077Set00Frame2 ; entry 2
    dw MetaSprites3D_4077Set00Frame3 ; entry 3
    dw MetaSprites3D_4077Set00Frame4 ; entry 4
    dw MetaSprites3D_4077Set00Frame5 ; entry 5
    dw MetaSprites3D_4077Set00Frame6 ; entry 6
    dw MetaSprites3D_4077Set00Frame7 ; entry 7
    dw MetaSprites3D_4077Set00Frame8 ; entry 8
    dw MetaSprites3D_4077Set00Frame9 ; entry 9
    dw MetaSprites3D_4077Set00Frame10 ; entry 10
    dw MetaSprites3D_4077Set00Frame11 ; entry 11
    dw MetaSprites3D_4077Set00Frame12 ; entry 12
    dw MetaSprites3D_4077Set00Frame13 ; entry 13
    dw MetaSprites3D_4077Set00Frame14 ; entry 14
    dw MetaSprites3D_4077Set00Frame15 ; entry 15
    dw MetaSprites3D_4077Set00Frame16 ; entry 16
    dw MetaSprites3D_4077Set00Frame17 ; entry 17
    dw MetaSprites3D_4077Set00Frame18 ; entry 18
    dw MetaSprites3D_4077Set00Frame19 ; entry 19
    dw MetaSprites3D_4077Set00Frame20 ; entry 20
    dw MetaSprites3D_4077Set00Frame21 ; entry 21
    dw MetaSprites3D_4077Set00Frame22 ; entry 22
    dw MetaSprites3D_4077Set00Frame23 ; entry 23
    dw MetaSprites3D_4077Set00Frame24 ; entry 24
    dw MetaSprites3D_4077Set00Frame25 ; entry 25
    dw MetaSprites3D_4077Set00Frame26 ; entry 26
    dw MetaSprites3D_4077Set00Frame26 ; entry 27
    dw MetaSprites3D_4077Set00Frame26 ; entry 28
    dw MetaSprites3D_4077Set00Frame26 ; entry 29
    dw MetaSprites3D_4077Set00Frame26 ; entry 30
    dw MetaSprites3D_4077Set00Frame26 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3D_4077Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set00Frame0::
Data_03D_4162:: ; address name
    db $D8, $03, $20, $00 ; entry 0
    db $D8, $0B, $21, $00 ; entry 1
    db $D0, $03, $22, $00 ; entry 2
    db $D0, $0B, $23, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3D_4077Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set00Frame1::
Data_03D_4173:: ; address name
    db $DC, $00, $20, $00 ; entry 0
    db $DC, $08, $21, $00 ; entry 1
    db $E4, $F8, $20, $60 ; entry 2
    db $E4, $F0, $21, $60 ; entry 3
    db $D0, $03, $2F, $00 ; entry 4
    db $D4, $00, $22, $00 ; entry 5
    db $D4, $08, $23, $00 ; entry 6
    db $F0, $F5, $2F, $60 ; entry 7
    db $EC, $F8, $22, $60 ; entry 8
    db $EC, $F0, $23, $60 ; entry 9
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3D_4077Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set00Frame2::
Data_03D_419C:: ; address name
    db $D8, $FC, $26, $00 ; entry 0
    db $D8, $04, $27, $00 ; entry 1
    db $D8, $0C, $28, $00 ; entry 2
    db $F0, $F4, $2E, $00 ; entry 3
    db $F8, $EF, $2F, $00 ; entry 4
    db $D0, $00, $24, $00 ; entry 5
    db $D0, $08, $25, $00 ; entry 6
    db $E0, $F8, $29, $00 ; entry 7
    db $E0, $00, $2A, $00 ; entry 8
    db $E0, $08, $2B, $00 ; entry 9
    db $E8, $F8, $2C, $00 ; entry 10
    db $E8, $00, $2D, $00 ; entry 11
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3D_4077Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set00Frame3::
Data_03D_41CD:: ; address name
    db $E0, $F7, $26, $00 ; entry 0
    db $E0, $FF, $27, $00 ; entry 1
    db $E0, $07, $28, $00 ; entry 2
    db $F8, $EF, $2E, $00 ; entry 3
    db $D8, $FB, $24, $00 ; entry 4
    db $D8, $03, $25, $00 ; entry 5
    db $E8, $F3, $29, $00 ; entry 6
    db $E8, $FB, $2A, $00 ; entry 7
    db $E8, $03, $2B, $00 ; entry 8
    db $F0, $F3, $2C, $00 ; entry 9
    db $F0, $FB, $2D, $00 ; entry 10
    db $D0, $09, $2F, $00 ; entry 11
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3D_4077Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set00Frame4::
Data_03D_41FE:: ; address name
    db $D0, $09, $2E, $00 ; entry 0
    db $D8, $04, $2E, $00 ; entry 1
    db $E0, $FF, $2E, $00 ; entry 2
    db $E8, $F9, $2E, $00 ; entry 3
    db $F8, $F5, $29, $60 ; entry 4
    db $F8, $ED, $2A, $60 ; entry 5
    db $F8, $E5, $2B, $60 ; entry 6
    db $F0, $F5, $2C, $60 ; entry 7
    db $F0, $ED, $2D, $60 ; entry 8
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3D_4077Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set00Frame5::
Data_03D_4223:: ; address name
    db $F8, $EF, $2E, $00 ; entry 0
    db $F0, $F4, $2E, $00 ; entry 1
    db $E8, $F9, $2E, $00 ; entry 2
    db $E0, $FF, $2F, $00 ; entry 3
    db $D8, $04, $2F, $00 ; entry 4
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3D_4077Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set00Frame6::
Data_03D_4238:: ; address name
    db $F8, $EF, $2F, $00 ; entry 0
    db $F0, $F4, $2F, $00 ; entry 1
    db $E8, $F9, $2F, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3D_4077Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set00Frame7::
Data_03D_4245:: ; address name
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

; E-0147 (derived: frame 8 of MetaSprites3D_4077Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set00Frame8::
Data_03D_426A:: ; address name
    db $DE, $F4, $00, $00 ; entry 0
    db $DE, $FC, $01, $00 ; entry 1
    db $F0, $F0, $0C, $00 ; entry 2
    db $F0, $F8, $0D, $00 ; entry 3
    db $F0, $00, $0E, $00 ; entry 4
    db $E2, $F6, $09, $00 ; entry 5
    db $E2, $FE, $0A, $00 ; entry 6
    db $E2, $06, $0B, $00 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites3D_4077Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set00Frame9::
Data_03D_428B:: ; address name
    db $DD, $F0, $0C, $00 ; entry 0
    db $DD, $F8, $0D, $00 ; entry 1
    db $DD, $00, $0E, $00 ; entry 2
    db $F0, $F0, $04, $00 ; entry 3
    db $F0, $F8, $05, $00 ; entry 4
    db $F0, $00, $06, $00 ; entry 5
    db $F8, $F0, $08, $00 ; entry 6
    db $F7, $E8, $07, $00 ; entry 7
    db $EA, $F8, $1C, $00 ; entry 8
    db $EA, $00, $1D, $00 ; entry 9
    db $E2, $F8, $1B, $00 ; entry 10
    db $E6, $08, $1E, $00 ; entry 11
    db $E6, $10, $1F, $00 ; entry 12
    db $80 ; end

; E-0147 (derived: frame 10 of MetaSprites3D_4077Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set00Frame10::
Data_03D_42C0:: ; address name
    db $DA, $F1, $04, $00 ; entry 0
    db $DA, $F9, $05, $00 ; entry 1
    db $DA, $01, $06, $00 ; entry 2
    db $E2, $F1, $08, $00 ; entry 3
    db $E1, $E9, $07, $00 ; entry 4
    db $F2, $EE, $0C, $00 ; entry 5
    db $F2, $F6, $0D, $00 ; entry 6
    db $F2, $FE, $0E, $00 ; entry 7
    db $E2, $F8, $0F, $00 ; entry 8
    db $E2, $00, $10, $00 ; entry 9
    db $E2, $08, $11, $00 ; entry 10
    db $E2, $10, $12, $00 ; entry 11
    db $EA, $F8, $13, $00 ; entry 12
    db $EA, $00, $14, $00 ; entry 13
    db $EA, $0C, $15, $00 ; entry 14
    db $80 ; end

; E-0147 (derived: frame 11 of MetaSprites3D_4077Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set00Frame11::
Data_03D_42FD:: ; address name
    db $E2, $00, $16, $00 ; entry 0
    db $EA, $00, $19, $00 ; entry 1
    db $E9, $0E, $15, $00 ; entry 2
    db $E2, $10, $18, $00 ; entry 3
    db $E2, $08, $17, $00 ; entry 4
    db $EA, $08, $1A, $00 ; entry 5
    db $E0, $E8, $1C, $00 ; entry 6
    db $E0, $F0, $1D, $00 ; entry 7
    db $D8, $E8, $1B, $00 ; entry 8
    db $DA, $F3, $09, $00 ; entry 9
    db $DA, $FB, $0A, $00 ; entry 10
    db $DA, $03, $0B, $00 ; entry 11
    db $DC, $F8, $1E, $00 ; entry 12
    db $DC, $00, $1F, $00 ; entry 13
    db $80 ; end

; E-0147 (derived: frame 12 of MetaSprites3D_4077Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set00Frame12::
Data_03D_4336:: ; address name
    db $D8, $F0, $10, $00 ; entry 0
    db $D8, $F8, $11, $00 ; entry 1
    db $D8, $00, $12, $00 ; entry 2
    db $D8, $E8, $0F, $00 ; entry 3
    db $E0, $E8, $13, $00 ; entry 4
    db $E0, $F0, $14, $00 ; entry 5
    db $E0, $FC, $15, $00 ; entry 6
    db $E9, $F6, $0C, $00 ; entry 7
    db $E9, $FE, $0D, $00 ; entry 8
    db $E9, $06, $0E, $00 ; entry 9
    db $D0, $00, $00, $00 ; entry 10
    db $D0, $08, $01, $00 ; entry 11
    db $80 ; end

; E-0147 (derived: frame 13 of MetaSprites3D_4077Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set00Frame13::
Data_03D_4367:: ; address name
    db $E8, $FC, $00, $00 ; entry 0
    db $E8, $04, $01, $00 ; entry 1
    db $F0, $F4, $04, $00 ; entry 2
    db $F0, $FC, $05, $00 ; entry 3
    db $F0, $04, $06, $00 ; entry 4
    db $F8, $F4, $08, $00 ; entry 5
    db $F7, $EC, $07, $00 ; entry 6
    db $D8, $F0, $16, $00 ; entry 7
    db $E0, $F0, $19, $00 ; entry 8
    db $DF, $FE, $15, $00 ; entry 9
    db $E0, $F8, $1A, $00 ; entry 10
    db $D8, $F8, $17, $00 ; entry 11
    db $D8, $00, $18, $00 ; entry 12
    db $D0, $FE, $09, $00 ; entry 13
    db $D0, $06, $0A, $00 ; entry 14
    db $D0, $0E, $0B, $00 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 14 of MetaSprites3D_4077Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set00Frame14::
Data_03D_43A8:: ; address name
    db $EE, $F3, $0C, $00 ; entry 0
    db $E5, $FC, $05, $00 ; entry 1
    db $E5, $04, $06, $00 ; entry 2
    db $D8, $F8, $1C, $00 ; entry 3
    db $D8, $00, $1D, $00 ; entry 4
    db $D4, $08, $1E, $00 ; entry 5
    db $D4, $10, $1F, $00 ; entry 6
    db $D0, $F8, $1B, $00 ; entry 7
    db $E5, $F4, $04, $00 ; entry 8
    db $ED, $F4, $08, $00 ; entry 9
    db $EC, $EC, $07, $00 ; entry 10
    db $F0, $10, $0B, $00 ; entry 11
    db $EE, $FB, $0D, $00 ; entry 12
    db $EE, $03, $0E, $00 ; entry 13
    db $F0, $00, $09, $00 ; entry 14
    db $F0, $08, $0A, $00 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 15 of MetaSprites3D_4077Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set00Frame15::
Data_03D_43E9:: ; address name
    db $E4, $F5, $09, $00 ; entry 0
    db $E4, $FD, $0A, $00 ; entry 1
    db $E4, $05, $0B, $00 ; entry 2
    db $D0, $00, $10, $00 ; entry 3
    db $D0, $08, $11, $00 ; entry 4
    db $D0, $10, $12, $00 ; entry 5
    db $D0, $F8, $0F, $00 ; entry 6
    db $D8, $F8, $13, $00 ; entry 7
    db $D8, $00, $14, $00 ; entry 8
    db $D8, $0C, $15, $00 ; entry 9
    db $F8, $EE, $1C, $00 ; entry 10
    db $F8, $F6, $1D, $00 ; entry 11
    db $F4, $FE, $1E, $00 ; entry 12
    db $F4, $06, $1F, $00 ; entry 13
    db $F0, $EE, $1B, $00 ; entry 14
    db $80 ; end

; E-0147 (derived: frame 16 of MetaSprites3D_4077Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set00Frame16::
Data_03D_4426:: ; address name
    db $E6, $F3, $0C, $00 ; entry 0
    db $E6, $FB, $0D, $00 ; entry 1
    db $E6, $03, $0E, $00 ; entry 2
    db $D0, $00, $16, $00 ; entry 3
    db $D8, $00, $19, $00 ; entry 4
    db $D7, $0E, $15, $00 ; entry 5
    db $D0, $08, $17, $00 ; entry 6
    db $D8, $08, $1A, $00 ; entry 7
    db $D0, $10, $18, $00 ; entry 8
    db $F0, $F6, $10, $00 ; entry 9
    db $F0, $FE, $11, $00 ; entry 10
    db $F0, $06, $12, $00 ; entry 11
    db $F0, $EE, $0F, $00 ; entry 12
    db $F8, $EE, $13, $00 ; entry 13
    db $F8, $F6, $14, $00 ; entry 14
    db $F8, $02, $15, $00 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 17 of MetaSprites3D_4077Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set00Frame17::
Data_03D_4467:: ; address name
    db $F0, $F6, $16, $00 ; entry 0
    db $F8, $F6, $19, $00 ; entry 1
    db $F7, $04, $15, $00 ; entry 2
    db $F0, $FE, $17, $00 ; entry 3
    db $F8, $FE, $1A, $00 ; entry 4
    db $F0, $06, $18, $00 ; entry 5
    db $E8, $F0, $09, $00 ; entry 6
    db $E8, $F8, $0A, $00 ; entry 7
    db $E8, $00, $0B, $00 ; entry 8
    db $D8, $F0, $0C, $00 ; entry 9
    db $D8, $F8, $0D, $00 ; entry 10
    db $D8, $00, $0E, $00 ; entry 11
    db $DC, $04, $02, $00 ; entry 12
    db $DC, $0C, $03, $00 ; entry 13
    db $80 ; end

; E-0147 (derived: frame 18 of MetaSprites3D_4077Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set00Frame18::
Data_03D_44A0:: ; address name
    db $F0, $E8, $1C, $00 ; entry 0
    db $F0, $F0, $1D, $00 ; entry 1
    db $E8, $E8, $1B, $00 ; entry 2
    db $EC, $F8, $1E, $00 ; entry 3
    db $EC, $00, $1F, $00 ; entry 4
    db $F8, $F0, $0C, $00 ; entry 5
    db $F8, $F8, $0D, $00 ; entry 6
    db $F8, $00, $0E, $00 ; entry 7
    db $DC, $00, $09, $00 ; entry 8
    db $DC, $08, $0A, $00 ; entry 9
    db $DC, $10, $0B, $00 ; entry 10
    db $80 ; end

; E-0147 (derived: frame 19 of MetaSprites3D_4077Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set00Frame19::
Data_03D_44CD:: ; address name
    db $E8, $F0, $10, $00 ; entry 0
    db $E8, $F8, $11, $00 ; entry 1
    db $E8, $00, $12, $00 ; entry 2
    db $E8, $E8, $0F, $00 ; entry 3
    db $F0, $E8, $13, $00 ; entry 4
    db $F0, $F0, $14, $00 ; entry 5
    db $F0, $FC, $15, $00 ; entry 6
    db $F2, $FF, $0C, $00 ; entry 7
    db $F2, $07, $0D, $00 ; entry 8
    db $F2, $0F, $0E, $00 ; entry 9
    db $E0, $F8, $1C, $00 ; entry 10
    db $E0, $00, $1D, $00 ; entry 11
    db $DC, $08, $1E, $00 ; entry 12
    db $DC, $10, $1F, $00 ; entry 13
    db $D8, $F8, $1B, $00 ; entry 14
    db $D6, $EB, $02, $00 ; entry 15
    db $D6, $F3, $03, $00 ; entry 16
    db $80 ; end

; E-0147 (derived: frame 20 of MetaSprites3D_4077Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set00Frame20::
Data_03D_4512:: ; address name
    db $E8, $F0, $16, $00 ; entry 0
    db $F0, $F0, $19, $00 ; entry 1
    db $EF, $FE, $15, $00 ; entry 2
    db $F0, $F8, $1A, $00 ; entry 3
    db $E8, $F8, $17, $00 ; entry 4
    db $E8, $00, $18, $00 ; entry 5
    db $F0, $00, $04, $00 ; entry 6
    db $F0, $08, $05, $00 ; entry 7
    db $F0, $10, $06, $00 ; entry 8
    db $F8, $00, $08, $00 ; entry 9
    db $F7, $F8, $07, $00 ; entry 10
    db $D0, $F4, $09, $00 ; entry 11
    db $D0, $FC, $0A, $00 ; entry 12
    db $D0, $04, $0B, $00 ; entry 13
    db $D8, $00, $10, $00 ; entry 14
    db $D8, $08, $11, $00 ; entry 15
    db $D8, $10, $12, $00 ; entry 16
    db $D8, $F8, $0F, $00 ; entry 17
    db $E0, $F8, $13, $00 ; entry 18
    db $E0, $00, $14, $00 ; entry 19
    db $E0, $0C, $15, $00 ; entry 20
    db $80 ; end

; E-0147 (derived: frame 21 of MetaSprites3D_4077Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set00Frame21::
Data_03D_4567:: ; address name
    db $F0, $10, $0B, $00 ; entry 0
    db $F0, $00, $09, $00 ; entry 1
    db $F0, $08, $0A, $00 ; entry 2
    db $D8, $E8, $1C, $00 ; entry 3
    db $D8, $F0, $1D, $00 ; entry 4
    db $D4, $F8, $1E, $00 ; entry 5
    db $D4, $00, $1F, $00 ; entry 6
    db $D0, $E8, $1B, $00 ; entry 7
    db $D8, $00, $16, $00 ; entry 8
    db $E0, $00, $19, $00 ; entry 9
    db $DF, $0E, $15, $00 ; entry 10
    db $D8, $08, $17, $00 ; entry 11
    db $E0, $08, $1A, $00 ; entry 12
    db $D8, $10, $18, $00 ; entry 13
    db $F0, $E8, $0C, $00 ; entry 14
    db $F0, $F0, $0D, $00 ; entry 15
    db $F0, $F8, $0E, $00 ; entry 16
    db $E8, $F8, $02, $00 ; entry 17
    db $E8, $00, $03, $00 ; entry 18
    db $80 ; end

; E-0147 (derived: frame 22 of MetaSprites3D_4077Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set00Frame22::
Data_03D_45B4:: ; address name
    db $E0, $F5, $09, $00 ; entry 0
    db $E0, $FD, $0A, $00 ; entry 1
    db $E0, $05, $0B, $00 ; entry 2
    db $D0, $00, $10, $00 ; entry 3
    db $D0, $08, $11, $00 ; entry 4
    db $D0, $10, $12, $00 ; entry 5
    db $D0, $F8, $0F, $00 ; entry 6
    db $D8, $F8, $13, $00 ; entry 7
    db $D8, $00, $14, $00 ; entry 8
    db $D8, $0C, $15, $00 ; entry 9
    db $F4, $EE, $1C, $00 ; entry 10
    db $F4, $F6, $1D, $00 ; entry 11
    db $F0, $FE, $1E, $00 ; entry 12
    db $F0, $06, $1F, $00 ; entry 13
    db $EC, $EE, $1B, $00 ; entry 14
    db $80 ; end

; E-0147 (derived: frame 23 of MetaSprites3D_4077Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set00Frame23::
Data_03D_45F1:: ; address name
    db $E2, $F3, $0C, $00 ; entry 0
    db $E2, $FB, $0D, $00 ; entry 1
    db $E2, $03, $0E, $00 ; entry 2
    db $D0, $00, $16, $00 ; entry 3
    db $D8, $00, $19, $00 ; entry 4
    db $D7, $0E, $15, $00 ; entry 5
    db $D0, $08, $17, $00 ; entry 6
    db $D8, $08, $1A, $00 ; entry 7
    db $D0, $10, $18, $00 ; entry 8
    db $EC, $F6, $10, $00 ; entry 9
    db $EC, $FE, $11, $00 ; entry 10
    db $EC, $06, $12, $00 ; entry 11
    db $EC, $EE, $0F, $00 ; entry 12
    db $F4, $EE, $13, $00 ; entry 13
    db $F4, $F6, $14, $00 ; entry 14
    db $F4, $02, $15, $00 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 24 of MetaSprites3D_4077Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set00Frame24::
Data_03D_4632:: ; address name
    db $EC, $EE, $16, $00 ; entry 0
    db $F4, $EE, $19, $00 ; entry 1
    db $F3, $FC, $15, $00 ; entry 2
    db $EC, $F6, $17, $00 ; entry 3
    db $F4, $F6, $1A, $00 ; entry 4
    db $EC, $FE, $18, $00 ; entry 5
    db $E0, $FD, $00, $00 ; entry 6
    db $E0, $05, $01, $00 ; entry 7
    db $D8, $F0, $0C, $00 ; entry 8
    db $D8, $F8, $0D, $00 ; entry 9
    db $D8, $00, $0E, $00 ; entry 10
    db $80 ; end

; E-0147 (derived: frame 25 of MetaSprites3D_4077Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set00Frame25::
Data_03D_465F:: ; address name
    db $E0, $FD, $02, $00 ; entry 0
    db $E0, $05, $03, $00 ; entry 1
    db $D4, $FB, $00, $00 ; entry 2
    db $D4, $03, $01, $00 ; entry 3
    db $F4, $E8, $0C, $00 ; entry 4
    db $F4, $F0, $0D, $00 ; entry 5
    db $F4, $F8, $0E, $00 ; entry 6
    db $80 ; end

; E-0147 (derived: frame 26 of MetaSprites3D_4077Set00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set00Frame26::
    db $80 ; end

; E-0147 (derived: meta-sprite set 33 of MetaSprites3D_4077Table: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3D_4077Set21::
Data_03D_467D:: ; address name
    dw MetaSprites3D_4077Set21Frame0 ; entry 0
    dw MetaSprites3D_4077Set21Frame1 ; entry 1
    dw MetaSprites3D_4077Set21Frame2 ; entry 2
    dw MetaSprites3D_4077Set21Frame3 ; entry 3
    dw MetaSprites3D_4077Set21Frame4 ; entry 4
    dw MetaSprites3D_4077Set21Frame5 ; entry 5
    dw MetaSprites3D_4077Set21Frame6 ; entry 6
    dw MetaSprites3D_4077Set21Frame7 ; entry 7
    dw MetaSprites3D_4077Set21Frame8 ; entry 8
    dw MetaSprites3D_4077Set21Frame9 ; entry 9
    dw MetaSprites3D_4077Set21Frame10 ; entry 10
    dw MetaSprites3D_4077Set21Frame11 ; entry 11
    dw MetaSprites3D_4077Set21Frame12 ; entry 12
    dw MetaSprites3D_4077Set21Frame12 ; entry 13
    dw MetaSprites3D_4077Set21Frame12 ; entry 14
    dw MetaSprites3D_4077Set21Frame12 ; entry 15
    dw MetaSprites3D_4077Set21Frame12 ; entry 16
    dw MetaSprites3D_4077Set21Frame12 ; entry 17
    dw MetaSprites3D_4077Set21Frame12 ; entry 18
    dw MetaSprites3D_4077Set21Frame12 ; entry 19
    dw MetaSprites3D_4077Set21Frame12 ; entry 20
    dw MetaSprites3D_4077Set21Frame12 ; entry 21
    dw MetaSprites3D_4077Set21Frame12 ; entry 22
    dw MetaSprites3D_4077Set21Frame12 ; entry 23
    dw MetaSprites3D_4077Set21Frame12 ; entry 24
    dw MetaSprites3D_4077Set21Frame12 ; entry 25
    dw MetaSprites3D_4077Set21Frame12 ; entry 26
    dw MetaSprites3D_4077Set21Frame12 ; entry 27
    dw MetaSprites3D_4077Set21Frame12 ; entry 28
    dw MetaSprites3D_4077Set21Frame12 ; entry 29
    dw MetaSprites3D_4077Set21Frame12 ; entry 30
    dw MetaSprites3D_4077Set21Frame12 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3D_4077Set21; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set21Frame0::
Data_03D_46BD:: ; address name
    db $D8, $03, $20, $00 ; entry 0
    db $D8, $0B, $21, $00 ; entry 1
    db $D0, $03, $22, $00 ; entry 2
    db $D0, $0B, $23, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3D_4077Set21; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set21Frame1::
Data_03D_46CE:: ; address name
    db $DC, $00, $20, $00 ; entry 0
    db $DC, $08, $21, $00 ; entry 1
    db $D4, $00, $22, $00 ; entry 2
    db $D4, $08, $23, $00 ; entry 3
    db $E4, $F8, $20, $60 ; entry 4
    db $E4, $F0, $21, $60 ; entry 5
    db $EC, $F8, $22, $60 ; entry 6
    db $EC, $F0, $23, $60 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3D_4077Set21; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set21Frame2::
Data_03D_46EF:: ; address name
    db $F0, $F4, $2C, $00 ; entry 0
    db $F8, $F0, $2D, $00 ; entry 1
    db $E8, $F8, $2A, $00 ; entry 2
    db $E8, $00, $2B, $00 ; entry 3
    db $D0, $04, $24, $00 ; entry 4
    db $D0, $0C, $25, $00 ; entry 5
    db $D8, $00, $26, $00 ; entry 6
    db $D8, $08, $27, $00 ; entry 7
    db $E0, $FB, $28, $00 ; entry 8
    db $E0, $03, $29, $00 ; entry 9
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3D_4077Set21; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set21Frame3::
Data_03D_4718:: ; address name
    db $F8, $F0, $2C, $00 ; entry 0
    db $F0, $EC, $2E, $00 ; entry 1
    db $D8, $08, $25, $00 ; entry 2
    db $D0, $0C, $2E, $00 ; entry 3
    db $D0, $04, $24, $00 ; entry 4
    db $D8, $00, $28, $40 ; entry 5
    db $E0, $FC, $26, $00 ; entry 6
    db $E0, $04, $27, $00 ; entry 7
    db $E8, $F7, $28, $00 ; entry 8
    db $E8, $FF, $29, $00 ; entry 9
    db $F0, $F4, $2A, $00 ; entry 10
    db $F0, $FC, $2B, $00 ; entry 11
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3D_4077Set21; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set21Frame4::
Data_03D_4749:: ; address name
    db $F8, $EE, $2E, $00 ; entry 0
    db $F0, $F3, $2E, $00 ; entry 1
    db $E8, $F8, $2E, $00 ; entry 2
    db $E0, $FE, $2E, $00 ; entry 3
    db $D8, $03, $2E, $00 ; entry 4
    db $D0, $08, $2E, $00 ; entry 5
    db $E0, $F6, $24, $00 ; entry 6
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3D_4077Set21; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set21Frame5::
Data_03D_4766:: ; address name
    db $F8, $EE, $2E, $00 ; entry 0
    db $F0, $F3, $2E, $00 ; entry 1
    db $E8, $F8, $2E, $00 ; entry 2
    db $E0, $FE, $2F, $00 ; entry 3
    db $D8, $03, $2F, $00 ; entry 4
    db $F8, $E6, $24, $00 ; entry 5
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3D_4077Set21; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set21Frame6::
Data_03D_477F:: ; address name
    db $F8, $F0, $2F, $00 ; entry 0
    db $F0, $F5, $2F, $00 ; entry 1
    db $E8, $FA, $2F, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3D_4077Set21; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set21Frame7::
Data_03D_478C:: ; address name
    db $F8, $F8, $1C, $00 ; entry 0
    db $F8, $00, $1E, $00 ; entry 1
    db $F0, $FD, $1F, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites3D_4077Set21; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set21Frame8::
Data_03D_4799:: ; address name
    db $F8, $FC, $1D, $00 ; entry 0
    db $F8, $04, $1E, $00 ; entry 1
    db $F0, $FC, $1A, $00 ; entry 2
    db $F0, $04, $1B, $00 ; entry 3
    db $F8, $F4, $1C, $00 ; entry 4
    db $F0, $F4, $19, $00 ; entry 5
    db $EA, $FA, $00, $20 ; entry 6
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites3D_4077Set21; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set21Frame9::
Data_03D_47B6:: ; address name
    db $F8, $FC, $0E, $00 ; entry 0
    db $E8, $FC, $1A, $20 ; entry 1
    db $E8, $F4, $1B, $20 ; entry 2
    db $F0, $FC, $1D, $20 ; entry 3
    db $F8, $F4, $14, $00 ; entry 4
    db $F8, $04, $16, $00 ; entry 5
    db $F0, $0C, $19, $20 ; entry 6
    db $F8, $0C, $1C, $20 ; entry 7
    db $F0, $EC, $1B, $20 ; entry 8
    db $F8, $EC, $1E, $20 ; entry 9
    db $E2, $FE, $00, $00 ; entry 10
    db $E8, $04, $0C, $00 ; entry 11
    db $F0, $04, $1E, $00 ; entry 12
    db $F0, $F4, $0E, $00 ; entry 13
    db $80 ; end

; E-0147 (derived: frame 10 of MetaSprites3D_4077Set21; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set21Frame10::
Data_03D_47EF:: ; address name
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

; E-0147 (derived: frame 11 of MetaSprites3D_4077Set21; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set21Frame11::
Data_03D_4854:: ; address name
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

; E-0147 (derived: frame 12 of MetaSprites3D_4077Set21; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set21Frame12::
    db $80 ; end

; E-0147 (derived: meta-sprite set 34 of MetaSprites3D_4077Table: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3D_4077Set22::
Data_03D_48BA:: ; address name
    dw MetaSprites3D_4077Set22Frame0 ; entry 0
    dw MetaSprites3D_4077Set22Frame1 ; entry 1
    dw MetaSprites3D_4077Set22Frame2 ; entry 2
    dw MetaSprites3D_4077Set22Frame3 ; entry 3
    dw MetaSprites3D_4077Set22Frame4 ; entry 4
    dw MetaSprites3D_4077Set22Frame5 ; entry 5
    dw MetaSprites3D_4077Set22Frame6 ; entry 6
    dw MetaSprites3D_4077Set22Frame6 ; entry 7
    dw MetaSprites3D_4077Set22Frame6 ; entry 8
    dw MetaSprites3D_4077Set22Frame6 ; entry 9
    dw MetaSprites3D_4077Set22Frame6 ; entry 10
    dw MetaSprites3D_4077Set22Frame6 ; entry 11
    dw MetaSprites3D_4077Set22Frame6 ; entry 12
    dw MetaSprites3D_4077Set22Frame6 ; entry 13
    dw MetaSprites3D_4077Set22Frame6 ; entry 14
    dw MetaSprites3D_4077Set22Frame6 ; entry 15
    dw MetaSprites3D_4077Set22Frame6 ; entry 16
    dw MetaSprites3D_4077Set22Frame6 ; entry 17
    dw MetaSprites3D_4077Set22Frame6 ; entry 18
    dw MetaSprites3D_4077Set22Frame6 ; entry 19
    dw MetaSprites3D_4077Set22Frame6 ; entry 20
    dw MetaSprites3D_4077Set22Frame6 ; entry 21
    dw MetaSprites3D_4077Set22Frame6 ; entry 22
    dw MetaSprites3D_4077Set22Frame6 ; entry 23
    dw MetaSprites3D_4077Set22Frame6 ; entry 24
    dw MetaSprites3D_4077Set22Frame6 ; entry 25
    dw MetaSprites3D_4077Set22Frame6 ; entry 26
    dw MetaSprites3D_4077Set22Frame6 ; entry 27
    dw MetaSprites3D_4077Set22Frame6 ; entry 28
    dw MetaSprites3D_4077Set22Frame6 ; entry 29
    dw MetaSprites3D_4077Set22Frame6 ; entry 30
    dw MetaSprites3D_4077Set22Frame6 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3D_4077Set22; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set22Frame0::
Data_03D_48FA:: ; address name
    db $D0, $F8, $04, $00 ; entry 0
    db $D0, $00, $05, $00 ; entry 1
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3D_4077Set22; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set22Frame1::
Data_03D_4903:: ; address name
    db $E0, $F8, $04, $00 ; entry 0
    db $E0, $00, $05, $00 ; entry 1
    db $D8, $F8, $02, $00 ; entry 2
    db $D8, $00, $03, $00 ; entry 3
    db $D0, $F8, $00, $00 ; entry 4
    db $D0, $00, $01, $00 ; entry 5
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3D_4077Set22; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set22Frame2::
Data_03D_491C:: ; address name
    db $DC, $F8, $17, $00 ; entry 0
    db $DC, $00, $17, $20 ; entry 1
    db $E4, $F0, $15, $00 ; entry 2
    db $E4, $F8, $16, $00 ; entry 3
    db $E4, $08, $15, $20 ; entry 4
    db $E4, $00, $16, $20 ; entry 5
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3D_4077Set22; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set22Frame3::
Data_03D_4935:: ; address name
    db $E4, $00, $07, $00 ; entry 0
    db $E4, $08, $08, $00 ; entry 1
    db $E4, $F8, $07, $20 ; entry 2
    db $E4, $F0, $08, $20 ; entry 3
    db $DC, $F8, $00, $00 ; entry 4
    db $DC, $00, $01, $00 ; entry 5
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3D_4077Set22; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set22Frame4::
Data_03D_494E:: ; address name
    db $D4, $F8, $0D, $20 ; entry 0
    db $D4, $F0, $0E, $20 ; entry 1
    db $D4, $00, $0D, $00 ; entry 2
    db $D4, $08, $0E, $00 ; entry 3
    db $DC, $00, $0F, $00 ; entry 4
    db $DC, $08, $10, $00 ; entry 5
    db $DC, $10, $11, $00 ; entry 6
    db $DC, $F0, $10, $20 ; entry 7
    db $DC, $E8, $11, $20 ; entry 8
    db $DC, $F8, $0F, $20 ; entry 9
    db $E4, $F8, $12, $20 ; entry 10
    db $E4, $F0, $13, $20 ; entry 11
    db $E4, $E8, $14, $20 ; entry 12
    db $E4, $00, $12, $00 ; entry 13
    db $E4, $08, $13, $00 ; entry 14
    db $E4, $10, $14, $00 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3D_4077Set22; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set22Frame5::
Data_03D_498F:: ; address name
    db $DC, $F8, $09, $20 ; entry 0
    db $DC, $F0, $0A, $20 ; entry 1
    db $DC, $00, $09, $00 ; entry 2
    db $DC, $08, $0A, $00 ; entry 3
    db $E4, $F8, $0B, $20 ; entry 4
    db $E4, $F0, $0C, $20 ; entry 5
    db $E4, $00, $0B, $00 ; entry 6
    db $E4, $08, $0C, $00 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3D_4077Set22; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set22Frame6::
    db $80 ; end

; E-0147 (derived: meta-sprite set 35 of MetaSprites3D_4077Table: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3D_4077Set23::
Data_03D_49B1:: ; address name
    dw MetaSprites3D_4077Set23Frame0 ; entry 0
    dw MetaSprites3D_4077Set23Frame1 ; entry 1
    dw MetaSprites3D_4077Set23Frame2 ; entry 2
    dw MetaSprites3D_4077Set23Frame3 ; entry 3
    dw MetaSprites3D_4077Set23Frame4 ; entry 4
    dw MetaSprites3D_4077Set23Frame5 ; entry 5
    dw MetaSprites3D_4077Set23Frame6 ; entry 6
    dw MetaSprites3D_4077Set23Frame7 ; entry 7
    dw MetaSprites3D_4077Set23Frame7 ; entry 8
    dw MetaSprites3D_4077Set23Frame7 ; entry 9
    dw MetaSprites3D_4077Set23Frame7 ; entry 10
    dw MetaSprites3D_4077Set23Frame7 ; entry 11
    dw MetaSprites3D_4077Set23Frame7 ; entry 12
    dw MetaSprites3D_4077Set23Frame7 ; entry 13
    dw MetaSprites3D_4077Set23Frame7 ; entry 14
    dw MetaSprites3D_4077Set23Frame7 ; entry 15
    dw MetaSprites3D_4077Set23Frame7 ; entry 16
    dw MetaSprites3D_4077Set23Frame7 ; entry 17
    dw MetaSprites3D_4077Set23Frame7 ; entry 18
    dw MetaSprites3D_4077Set23Frame7 ; entry 19
    dw MetaSprites3D_4077Set23Frame7 ; entry 20
    dw MetaSprites3D_4077Set23Frame7 ; entry 21
    dw MetaSprites3D_4077Set23Frame7 ; entry 22
    dw MetaSprites3D_4077Set23Frame7 ; entry 23
    dw MetaSprites3D_4077Set23Frame7 ; entry 24
    dw MetaSprites3D_4077Set23Frame7 ; entry 25
    dw MetaSprites3D_4077Set23Frame7 ; entry 26
    dw MetaSprites3D_4077Set23Frame7 ; entry 27
    dw MetaSprites3D_4077Set23Frame7 ; entry 28
    dw MetaSprites3D_4077Set23Frame7 ; entry 29
    dw MetaSprites3D_4077Set23Frame7 ; entry 30
    dw MetaSprites3D_4077Set23Frame7 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3D_4077Set23; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set23Frame0::
Data_03D_49F1:: ; address name
    db $F8, $F0, $00, $60 ; entry 0
    db $F8, $E8, $01, $60 ; entry 1
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3D_4077Set23; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set23Frame1::
Data_03D_49FA:: ; address name
    db $F7, $F5, $00, $60 ; entry 0
    db $F7, $ED, $01, $60 ; entry 1
    db $F1, $FD, $00, $00 ; entry 2
    db $F1, $05, $01, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3D_4077Set23; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set23Frame2::
Data_03D_4A0B:: ; address name
    db $F8, $F0, $0B, $00 ; entry 0
    db $F8, $F8, $0C, $00 ; entry 1
    db $F0, $FC, $09, $00 ; entry 2
    db $F0, $04, $0A, $00 ; entry 3
    db $E0, $08, $05, $00 ; entry 4
    db $E0, $10, $06, $00 ; entry 5
    db $E8, $04, $07, $00 ; entry 6
    db $E8, $0C, $08, $00 ; entry 7
    db $D8, $10, $04, $00 ; entry 8
    db $D0, $08, $02, $00 ; entry 9
    db $D0, $10, $03, $00 ; entry 10
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3D_4077Set23; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set23Frame3::
Data_03D_4A38:: ; address name
    db $F8, $F0, $0B, $00 ; entry 0
    db $F8, $F8, $0C, $00 ; entry 1
    db $F0, $FC, $09, $00 ; entry 2
    db $F0, $04, $0A, $00 ; entry 3
    db $E8, $04, $07, $00 ; entry 4
    db $E8, $0C, $08, $00 ; entry 5
    db $E0, $08, $0D, $00 ; entry 6
    db $E0, $10, $0E, $00 ; entry 7
    db $D8, $08, $0F, $00 ; entry 8
    db $D8, $10, $10, $00 ; entry 9
    db $D0, $FC, $11, $00 ; entry 10
    db $D0, $04, $12, $00 ; entry 11
    db $D0, $0C, $13, $00 ; entry 12
    db $D8, $EE, $14, $00 ; entry 13
    db $D8, $F6, $15, $00 ; entry 14
    db $E0, $E8, $16, $00 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3D_4077Set23; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set23Frame4::
Data_03D_4A79:: ; address name
    db $F8, $F0, $0B, $00 ; entry 0
    db $F8, $F8, $0C, $00 ; entry 1
    db $D0, $FC, $17, $00 ; entry 2
    db $D0, $04, $18, $00 ; entry 3
    db $D0, $0C, $19, $00 ; entry 4
    db $D8, $EC, $1A, $00 ; entry 5
    db $D8, $F4, $1B, $00 ; entry 6
    db $D8, $FC, $1C, $00 ; entry 7
    db $D8, $08, $1D, $00 ; entry 8
    db $D8, $10, $1E, $00 ; entry 9
    db $E0, $E8, $1F, $00 ; entry 10
    db $E0, $10, $20, $00 ; entry 11
    db $E8, $0C, $28, $00 ; entry 12
    db $F0, $FC, $29, $00 ; entry 13
    db $F0, $04, $2A, $00 ; entry 14
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3D_4077Set23; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set23Frame5::
Data_03D_4AB6:: ; address name
    db $E0, $E8, $1F, $00 ; entry 0
    db $E0, $10, $27, $00 ; entry 1
    db $D8, $10, $26, $00 ; entry 2
    db $D0, $FC, $21, $00 ; entry 3
    db $D0, $04, $22, $00 ; entry 4
    db $D0, $0C, $23, $00 ; entry 5
    db $D8, $EE, $24, $00 ; entry 6
    db $D8, $F6, $25, $00 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3D_4077Set23; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set23Frame6::
Data_03D_4AD7:: ; address name
    db $E0, $E8, $1F, $00 ; entry 0
    db $D8, $EE, $24, $00 ; entry 1
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3D_4077Set23; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set23Frame7::
    db $80 ; end

; E-0147 (derived: meta-sprite set 36 of MetaSprites3D_4077Table: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3D_4077Set24::
Data_03D_4AE1:: ; address name
    dw MetaSprites3D_4077Set24Frame0 ; entry 0
    dw MetaSprites3D_4077Set24Frame1 ; entry 1
    dw MetaSprites3D_4077Set24Frame2 ; entry 2
    dw MetaSprites3D_4077Set24Frame3 ; entry 3
    dw MetaSprites3D_4077Set24Frame4 ; entry 4
    dw MetaSprites3D_4077Set24Frame5 ; entry 5
    dw MetaSprites3D_4077Set24Frame6 ; entry 6
    dw MetaSprites3D_4077Set24Frame7 ; entry 7
    dw MetaSprites3D_4077Set24Frame7 ; entry 8
    dw MetaSprites3D_4077Set24Frame7 ; entry 9
    dw MetaSprites3D_4077Set24Frame7 ; entry 10
    dw MetaSprites3D_4077Set24Frame7 ; entry 11
    dw MetaSprites3D_4077Set24Frame7 ; entry 12
    dw MetaSprites3D_4077Set24Frame7 ; entry 13
    dw MetaSprites3D_4077Set24Frame7 ; entry 14
    dw MetaSprites3D_4077Set24Frame7 ; entry 15
    dw MetaSprites3D_4077Set24Frame7 ; entry 16
    dw MetaSprites3D_4077Set24Frame7 ; entry 17
    dw MetaSprites3D_4077Set24Frame7 ; entry 18
    dw MetaSprites3D_4077Set24Frame7 ; entry 19
    dw MetaSprites3D_4077Set24Frame7 ; entry 20
    dw MetaSprites3D_4077Set24Frame7 ; entry 21
    dw MetaSprites3D_4077Set24Frame7 ; entry 22
    dw MetaSprites3D_4077Set24Frame7 ; entry 23
    dw MetaSprites3D_4077Set24Frame7 ; entry 24
    dw MetaSprites3D_4077Set24Frame7 ; entry 25
    dw MetaSprites3D_4077Set24Frame7 ; entry 26
    dw MetaSprites3D_4077Set24Frame7 ; entry 27
    dw MetaSprites3D_4077Set24Frame7 ; entry 28
    dw MetaSprites3D_4077Set24Frame7 ; entry 29
    dw MetaSprites3D_4077Set24Frame7 ; entry 30
    dw MetaSprites3D_4077Set24Frame7 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3D_4077Set24; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set24Frame0::
Data_03D_4B21:: ; address name
    db $D8, $FC, $00, $00 ; entry 0
    db $D0, $FC, $01, $00 ; entry 1
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3D_4077Set24; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set24Frame1::
Data_03D_4B2A:: ; address name
    db $D0, $F8, $05, $00 ; entry 0
    db $D8, $F8, $08, $00 ; entry 1
    db $E0, $FC, $01, $00 ; entry 2
    db $D0, $FC, $03, $00 ; entry 3
    db $D8, $FC, $02, $00 ; entry 4
    db $E8, $FC, $0B, $00 ; entry 5
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3D_4077Set24; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set24Frame2::
Data_03D_4B43:: ; address name
    db $D0, $F8, $05, $00 ; entry 0
    db $D8, $F0, $07, $00 ; entry 1
    db $D8, $F8, $08, $00 ; entry 2
    db $D8, $E8, $06, $00 ; entry 3
    db $F8, $FC, $00, $00 ; entry 4
    db $F0, $FC, $01, $00 ; entry 5
    db $D8, $FC, $04, $00 ; entry 6
    db $D0, $FC, $04, $00 ; entry 7
    db $E8, $FC, $0F, $00 ; entry 8
    db $E0, $FC, $0D, $00 ; entry 9
    db $E0, $F4, $0C, $00 ; entry 10
    db $E8, $F4, $0E, $00 ; entry 11
    db $E0, $03, $0C, $20 ; entry 12
    db $E8, $03, $0E, $20 ; entry 13
    db $E0, $E8, $06, $40 ; entry 14
    db $E0, $F0, $07, $40 ; entry 15
    db $E0, $F8, $08, $40 ; entry 16
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3D_4077Set24; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set24Frame3::
Data_03D_4B88:: ; address name
    db $D0, $F8, $05, $00 ; entry 0
    db $D8, $F0, $07, $00 ; entry 1
    db $D8, $F8, $08, $00 ; entry 2
    db $D8, $E8, $06, $00 ; entry 3
    db $E0, $E8, $06, $40 ; entry 4
    db $E0, $F0, $07, $40 ; entry 5
    db $E0, $F8, $08, $40 ; entry 6
    db $F0, $FC, $04, $00 ; entry 7
    db $E0, $FC, $04, $00 ; entry 8
    db $D8, $FC, $04, $00 ; entry 9
    db $D0, $FC, $04, $00 ; entry 10
    db $F8, $FC, $03, $00 ; entry 11
    db $F8, $00, $0A, $20 ; entry 12
    db $E8, $FC, $0B, $00 ; entry 13
    db $E8, $F8, $09, $00 ; entry 14
    db $F0, $F8, $09, $00 ; entry 15
    db $F8, $F8, $0A, $00 ; entry 16
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3D_4077Set24; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set24Frame4::
Data_03D_4BCD:: ; address name
    db $D0, $F8, $05, $00 ; entry 0
    db $D8, $F0, $07, $00 ; entry 1
    db $D8, $F8, $08, $00 ; entry 2
    db $D8, $E8, $06, $00 ; entry 3
    db $E0, $E8, $06, $40 ; entry 4
    db $E0, $F0, $07, $40 ; entry 5
    db $F8, $FC, $04, $00 ; entry 6
    db $F0, $FC, $04, $00 ; entry 7
    db $E8, $FC, $04, $00 ; entry 8
    db $E0, $F8, $08, $40 ; entry 9
    db $E8, $F8, $09, $00 ; entry 10
    db $F0, $F8, $09, $00 ; entry 11
    db $F8, $F8, $0A, $00 ; entry 12
    db $E0, $00, $08, $60 ; entry 13
    db $E8, $00, $09, $20 ; entry 14
    db $F0, $00, $09, $20 ; entry 15
    db $F8, $00, $0A, $20 ; entry 16
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3D_4077Set24; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set24Frame5::
Data_03D_4C12:: ; address name
    db $D0, $F8, $05, $00 ; entry 0
    db $D8, $F0, $07, $00 ; entry 1
    db $D8, $F8, $08, $00 ; entry 2
    db $D8, $E8, $06, $00 ; entry 3
    db $E0, $E8, $06, $40 ; entry 4
    db $E0, $F0, $07, $40 ; entry 5
    db $E0, $F8, $08, $40 ; entry 6
    db $E8, $F8, $09, $00 ; entry 7
    db $F0, $F8, $09, $00 ; entry 8
    db $F8, $F8, $0A, $00 ; entry 9
    db $E8, $00, $09, $20 ; entry 10
    db $F0, $00, $09, $20 ; entry 11
    db $F8, $00, $0A, $20 ; entry 12
    db $D8, $08, $07, $20 ; entry 13
    db $D8, $10, $06, $20 ; entry 14
    db $E0, $10, $06, $60 ; entry 15
    db $E0, $08, $07, $60 ; entry 16
    db $E0, $00, $08, $60 ; entry 17
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3D_4077Set24; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set24Frame6::
Data_03D_4C5B:: ; address name
    db $D0, $F8, $05, $00 ; entry 0
    db $D8, $F0, $07, $00 ; entry 1
    db $D8, $F8, $08, $00 ; entry 2
    db $D8, $E8, $06, $00 ; entry 3
    db $E0, $E8, $06, $40 ; entry 4
    db $E0, $F0, $07, $40 ; entry 5
    db $E0, $F8, $08, $40 ; entry 6
    db $E8, $F8, $09, $00 ; entry 7
    db $F0, $F8, $09, $00 ; entry 8
    db $F8, $F8, $0A, $00 ; entry 9
    db $E8, $00, $09, $20 ; entry 10
    db $F0, $00, $09, $20 ; entry 11
    db $F8, $00, $0A, $20 ; entry 12
    db $D0, $00, $05, $20 ; entry 13
    db $D8, $08, $07, $20 ; entry 14
    db $D8, $00, $08, $20 ; entry 15
    db $D8, $10, $06, $20 ; entry 16
    db $E0, $10, $06, $60 ; entry 17
    db $E0, $08, $07, $60 ; entry 18
    db $E0, $00, $08, $60 ; entry 19
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3D_4077Set24; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set24Frame7::
    db $80 ; end

; E-0147 (derived: meta-sprite set 37 of MetaSprites3D_4077Table: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3D_4077Set25::
Data_03D_4CAD:: ; address name
    dw MetaSprites3D_4077Set25Frame0 ; entry 0
    dw MetaSprites3D_4077Set25Frame1 ; entry 1
    dw MetaSprites3D_4077Set25Frame2 ; entry 2
    dw MetaSprites3D_4077Set25Frame3 ; entry 3
    dw MetaSprites3D_4077Set25Frame4 ; entry 4
    dw MetaSprites3D_4077Set25Frame5 ; entry 5
    dw MetaSprites3D_4077Set25Frame6 ; entry 6
    dw MetaSprites3D_4077Set25Frame7 ; entry 7
    dw MetaSprites3D_4077Set25Frame8 ; entry 8
    dw MetaSprites3D_4077Set25Frame9 ; entry 9
    dw MetaSprites3D_4077Set25Frame9 ; entry 10
    dw MetaSprites3D_4077Set25Frame9 ; entry 11
    dw MetaSprites3D_4077Set25Frame9 ; entry 12
    dw MetaSprites3D_4077Set25Frame9 ; entry 13
    dw MetaSprites3D_4077Set25Frame9 ; entry 14
    dw MetaSprites3D_4077Set25Frame9 ; entry 15
    dw MetaSprites3D_4077Set25Frame9 ; entry 16
    dw MetaSprites3D_4077Set25Frame9 ; entry 17
    dw MetaSprites3D_4077Set25Frame9 ; entry 18
    dw MetaSprites3D_4077Set25Frame9 ; entry 19
    dw MetaSprites3D_4077Set25Frame9 ; entry 20
    dw MetaSprites3D_4077Set25Frame9 ; entry 21
    dw MetaSprites3D_4077Set25Frame9 ; entry 22
    dw MetaSprites3D_4077Set25Frame9 ; entry 23
    dw MetaSprites3D_4077Set25Frame9 ; entry 24
    dw MetaSprites3D_4077Set25Frame9 ; entry 25
    dw MetaSprites3D_4077Set25Frame9 ; entry 26
    dw MetaSprites3D_4077Set25Frame9 ; entry 27
    dw MetaSprites3D_4077Set25Frame9 ; entry 28
    dw MetaSprites3D_4077Set25Frame9 ; entry 29
    dw MetaSprites3D_4077Set25Frame9 ; entry 30
    dw MetaSprites3D_4077Set25Frame9 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3D_4077Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set25Frame0::
Data_03D_4CED:: ; address name
    db $D8, $FC, $00, $00 ; entry 0
    db $D0, $FC, $01, $00 ; entry 1
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3D_4077Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set25Frame1::
Data_03D_4CF6:: ; address name
    db $E8, $FC, $00, $00 ; entry 0
    db $E0, $FC, $01, $00 ; entry 1
    db $D0, $FC, $03, $00 ; entry 2
    db $D8, $FC, $02, $00 ; entry 3
    db $E4, $F4, $06, $20 ; entry 4
    db $E4, $03, $06, $00 ; entry 5
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3D_4077Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set25Frame2::
Data_03D_4D0F:: ; address name
    db $F8, $FC, $00, $00 ; entry 0
    db $F0, $FC, $01, $00 ; entry 1
    db $E0, $FC, $03, $00 ; entry 2
    db $E8, $FC, $02, $00 ; entry 3
    db $D8, $FC, $04, $00 ; entry 4
    db $D0, $FC, $05, $00 ; entry 5
    db $DC, $03, $07, $00 ; entry 6
    db $DC, $0B, $08, $00 ; entry 7
    db $E4, $03, $09, $00 ; entry 8
    db $E4, $F4, $09, $20 ; entry 9
    db $DC, $F4, $07, $20 ; entry 10
    db $DC, $EC, $08, $20 ; entry 11
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3D_4077Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set25Frame3::
Data_03D_4D40:: ; address name
    db $D0, $FC, $05, $00 ; entry 0
    db $F8, $FC, $03, $00 ; entry 1
    db $F0, $FC, $04, $00 ; entry 2
    db $E8, $FC, $05, $00 ; entry 3
    db $E0, $FC, $05, $00 ; entry 4
    db $D8, $FC, $05, $00 ; entry 5
    db $D4, $03, $0A, $00 ; entry 6
    db $D4, $0B, $0B, $00 ; entry 7
    db $DC, $03, $0C, $00 ; entry 8
    db $DC, $0B, $0D, $00 ; entry 9
    db $E4, $03, $0E, $00 ; entry 10
    db $E4, $0B, $0F, $00 ; entry 11
    db $D4, $F4, $0A, $20 ; entry 12
    db $D4, $EC, $0B, $20 ; entry 13
    db $DC, $F4, $0C, $20 ; entry 14
    db $DC, $EC, $0D, $20 ; entry 15
    db $E4, $F4, $0E, $20 ; entry 16
    db $E4, $EC, $0F, $20 ; entry 17
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3D_4077Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set25Frame4::
Data_03D_4D89:: ; address name
    db $D0, $FC, $10, $00 ; entry 0
    db $D8, $FC, $10, $00 ; entry 1
    db $E0, $FC, $10, $00 ; entry 2
    db $E8, $FC, $10, $00 ; entry 3
    db $F0, $FC, $10, $00 ; entry 4
    db $F8, $FC, $10, $00 ; entry 5
    db $E4, $F4, $09, $20 ; entry 6
    db $DC, $F4, $07, $20 ; entry 7
    db $DC, $EC, $08, $20 ; entry 8
    db $DC, $04, $07, $00 ; entry 9
    db $DC, $0C, $08, $00 ; entry 10
    db $E4, $03, $09, $00 ; entry 11
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3D_4077Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set25Frame5::
Data_03D_4DBA:: ; address name
    db $D0, $FC, $10, $00 ; entry 0
    db $D8, $FC, $10, $00 ; entry 1
    db $E0, $FC, $10, $00 ; entry 2
    db $E8, $FC, $10, $00 ; entry 3
    db $F0, $FC, $10, $00 ; entry 4
    db $F8, $FC, $10, $00 ; entry 5
    db $D4, $F4, $0A, $20 ; entry 6
    db $D4, $EC, $0B, $20 ; entry 7
    db $DC, $F4, $0C, $20 ; entry 8
    db $DC, $EC, $0D, $20 ; entry 9
    db $E4, $F4, $0E, $20 ; entry 10
    db $E4, $EC, $0F, $20 ; entry 11
    db $D4, $03, $0A, $00 ; entry 12
    db $D4, $0B, $0B, $00 ; entry 13
    db $DC, $03, $0C, $00 ; entry 14
    db $DC, $0B, $0D, $00 ; entry 15
    db $E4, $03, $0E, $00 ; entry 16
    db $E4, $0B, $0F, $00 ; entry 17
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3D_4077Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set25Frame6::
Data_03D_4E03:: ; address name
    db $D0, $FB, $10, $20 ; entry 0
    db $D8, $FB, $10, $20 ; entry 1
    db $E0, $FB, $10, $20 ; entry 2
    db $E8, $FB, $10, $20 ; entry 3
    db $F0, $FB, $10, $20 ; entry 4
    db $F8, $FB, $10, $20 ; entry 5
    db $E4, $F4, $06, $20 ; entry 6
    db $E4, $03, $06, $00 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3D_4077Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set25Frame7::
Data_03D_4E24:: ; address name
    db $D0, $FC, $11, $00 ; entry 0
    db $D8, $FC, $11, $00 ; entry 1
    db $E0, $FC, $11, $00 ; entry 2
    db $E8, $FC, $11, $00 ; entry 3
    db $F0, $FC, $11, $00 ; entry 4
    db $F8, $FC, $11, $00 ; entry 5
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites3D_4077Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set25Frame8::
Data_03D_4E3D:: ; address name
    db $D0, $FB, $11, $20 ; entry 0
    db $D8, $FB, $11, $20 ; entry 1
    db $E0, $FB, $11, $20 ; entry 2
    db $E8, $FB, $11, $20 ; entry 3
    db $F0, $FB, $11, $20 ; entry 4
    db $F8, $FB, $11, $20 ; entry 5
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites3D_4077Set25; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set25Frame9::
    db $80 ; end

; E-0147 (derived: meta-sprite set 38 of MetaSprites3D_4077Table: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3D_4077Set26::
Data_03D_4E57:: ; address name
    dw MetaSprites3D_4077Set26Frame0 ; entry 0
    dw MetaSprites3D_4077Set26Frame1 ; entry 1
    dw MetaSprites3D_4077Set26Frame2 ; entry 2
    dw MetaSprites3D_4077Set26Frame3 ; entry 3
    dw MetaSprites3D_4077Set26Frame4 ; entry 4
    dw MetaSprites3D_4077Set26Frame5 ; entry 5
    dw MetaSprites3D_4077Set26Frame6 ; entry 6
    dw MetaSprites3D_4077Set26Frame7 ; entry 7
    dw MetaSprites3D_4077Set26Frame8 ; entry 8
    dw MetaSprites3D_4077Set26Frame9 ; entry 9
    dw MetaSprites3D_4077Set26Frame10 ; entry 10
    dw MetaSprites3D_4077Set26Frame11 ; entry 11
    dw MetaSprites3D_4077Set26Frame12 ; entry 12
    dw MetaSprites3D_4077Set26Frame12 ; entry 13
    dw MetaSprites3D_4077Set26Frame12 ; entry 14
    dw MetaSprites3D_4077Set26Frame12 ; entry 15
    dw MetaSprites3D_4077Set26Frame12 ; entry 16
    dw MetaSprites3D_4077Set26Frame12 ; entry 17
    dw MetaSprites3D_4077Set26Frame12 ; entry 18
    dw MetaSprites3D_4077Set26Frame12 ; entry 19
    dw MetaSprites3D_4077Set26Frame12 ; entry 20
    dw MetaSprites3D_4077Set26Frame12 ; entry 21
    dw MetaSprites3D_4077Set26Frame12 ; entry 22
    dw MetaSprites3D_4077Set26Frame12 ; entry 23
    dw MetaSprites3D_4077Set26Frame12 ; entry 24
    dw MetaSprites3D_4077Set26Frame12 ; entry 25
    dw MetaSprites3D_4077Set26Frame12 ; entry 26
    dw MetaSprites3D_4077Set26Frame12 ; entry 27
    dw MetaSprites3D_4077Set26Frame12 ; entry 28
    dw MetaSprites3D_4077Set26Frame12 ; entry 29
    dw MetaSprites3D_4077Set26Frame12 ; entry 30
    dw MetaSprites3D_4077Set26Frame12 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3D_4077Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set26Frame0::
Data_03D_4E97:: ; address name
    db $D8, $03, $00, $00 ; entry 0
    db $D8, $0B, $01, $00 ; entry 1
    db $D0, $03, $02, $00 ; entry 2
    db $D0, $0B, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3D_4077Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set26Frame1::
Data_03D_4EA8:: ; address name
    db $DC, $FF, $00, $00 ; entry 0
    db $DC, $07, $01, $00 ; entry 1
    db $D4, $FF, $02, $00 ; entry 2
    db $D4, $07, $03, $00 ; entry 3
    db $E4, $F9, $00, $60 ; entry 4
    db $E4, $F1, $01, $60 ; entry 5
    db $EC, $F9, $02, $60 ; entry 6
    db $EC, $F1, $03, $60 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3D_4077Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set26Frame2::
Data_03D_4EC9:: ; address name
    db $E0, $FE, $11, $00 ; entry 0
    db $E0, $06, $12, $00 ; entry 1
    db $D8, $0E, $10, $00 ; entry 2
    db $D8, $FE, $0E, $00 ; entry 3
    db $D8, $06, $0F, $00 ; entry 4
    db $D0, $02, $0B, $00 ; entry 5
    db $D0, $0A, $0C, $00 ; entry 6
    db $D0, $12, $0D, $00 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3D_4077Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set26Frame3::
Data_03D_4EEA:: ; address name
    db $F0, $F5, $11, $00 ; entry 0
    db $F0, $FD, $12, $00 ; entry 1
    db $D0, $02, $06, $00 ; entry 2
    db $D0, $0A, $07, $00 ; entry 3
    db $D8, $01, $09, $00 ; entry 4
    db $D8, $09, $0A, $00 ; entry 5
    db $E0, $09, $0D, $00 ; entry 6
    db $E8, $05, $10, $00 ; entry 7
    db $D8, $F9, $08, $00 ; entry 8
    db $D8, $F7, $19, $00 ; entry 9
    db $E8, $F0, $1D, $00 ; entry 10
    db $E8, $F8, $1E, $00 ; entry 11
    db $E8, $00, $1F, $00 ; entry 12
    db $E0, $F9, $1B, $00 ; entry 13
    db $E0, $01, $1C, $00 ; entry 14
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3D_4077Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set26Frame4::
Data_03D_4F27:: ; address name
    db $E0, $F8, $22, $00 ; entry 0
    db $E0, $00, $23, $00 ; entry 1
    db $E0, $08, $24, $00 ; entry 2
    db $D8, $F3, $20, $00 ; entry 3
    db $E8, $02, $26, $00 ; entry 4
    db $F0, $0A, $29, $00 ; entry 5
    db $F8, $EA, $0B, $00 ; entry 6
    db $F8, $F2, $0C, $00 ; entry 7
    db $F8, $FA, $0D, $00 ; entry 8
    db $F0, $EA, $08, $00 ; entry 9
    db $F0, $F2, $09, $00 ; entry 10
    db $F0, $FA, $0A, $00 ; entry 11
    db $E8, $F4, $06, $00 ; entry 12
    db $E8, $FA, $25, $00 ; entry 13
    db $D0, $09, $13, $00 ; entry 14
    db $D8, $04, $13, $00 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3D_4077Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set26Frame5::
Data_03D_4F68:: ; address name
    db $F0, $F4, $13, $00 ; entry 0
    db $F8, $EF, $13, $00 ; entry 1
    db $D8, $04, $14, $00 ; entry 2
    db $EC, $F0, $1D, $00 ; entry 3
    db $EC, $F8, $1E, $00 ; entry 4
    db $EC, $00, $1F, $00 ; entry 5
    db $DC, $09, $1A, $00 ; entry 6
    db $DC, $F8, $19, $00 ; entry 7
    db $E0, $FF, $14, $00 ; entry 8
    db $E4, $F9, $1B, $00 ; entry 9
    db $E4, $01, $1C, $00 ; entry 10
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3D_4077Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set26Frame6::
Data_03D_4F95:: ; address name
    db $DC, $F4, $2E, $00 ; entry 0
    db $E4, $F4, $2F, $40 ; entry 1
    db $DC, $FC, $2D, $20 ; entry 2
    db $DC, $04, $2E, $20 ; entry 3
    db $E4, $04, $2F, $60 ; entry 4
    db $E4, $FC, $04, $00 ; entry 5
    db $F8, $EF, $14, $00 ; entry 6
    db $F0, $F4, $14, $00 ; entry 7
    db $EC, $FC, $2D, $60 ; entry 8
    db $EC, $04, $2E, $60 ; entry 9
    db $EC, $F4, $2E, $40 ; entry 10
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3D_4077Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set26Frame7::
Data_03D_4FC2:: ; address name
    db $D0, $E8, $2B, $00 ; entry 0
    db $D0, $F0, $2C, $00 ; entry 1
    db $D0, $F8, $2D, $00 ; entry 2
    db $E0, $E8, $2F, $00 ; entry 3
    db $E0, $F0, $2A, $00 ; entry 4
    db $D8, $F8, $2A, $00 ; entry 5
    db $D8, $E8, $2E, $00 ; entry 6
    db $D0, $10, $2B, $20 ; entry 7
    db $D0, $08, $2C, $20 ; entry 8
    db $D0, $00, $2D, $20 ; entry 9
    db $E0, $10, $2F, $20 ; entry 10
    db $E0, $08, $2A, $20 ; entry 11
    db $D8, $00, $2A, $20 ; entry 12
    db $D8, $10, $2E, $20 ; entry 13
    db $F8, $E8, $2B, $40 ; entry 14
    db $F8, $F0, $2C, $40 ; entry 15
    db $F8, $F8, $2D, $40 ; entry 16
    db $E8, $E8, $2F, $40 ; entry 17
    db $E8, $F0, $2A, $40 ; entry 18
    db $F0, $F8, $2A, $40 ; entry 19
    db $F0, $E8, $2E, $40 ; entry 20
    db $F8, $10, $2B, $60 ; entry 21
    db $F8, $08, $2C, $60 ; entry 22
    db $F8, $00, $2D, $60 ; entry 23
    db $E8, $10, $2F, $60 ; entry 24
    db $E8, $08, $2A, $60 ; entry 25
    db $F0, $00, $2A, $60 ; entry 26
    db $F0, $10, $2E, $60 ; entry 27
    db $E0, $00, $04, $60 ; entry 28
    db $E8, $00, $04, $20 ; entry 29
    db $E8, $F8, $04, $00 ; entry 30
    db $E0, $F8, $04, $40 ; entry 31
    db $D8, $08, $04, $00 ; entry 32
    db $D8, $F0, $04, $20 ; entry 33
    db $F0, $08, $04, $40 ; entry 34
    db $F0, $F0, $04, $60 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites3D_4077Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set26Frame8::
Data_03D_5053:: ; address name
    db $D0, $05, $15, $00 ; entry 0
    db $D0, $0D, $16, $00 ; entry 1
    db $D8, $00, $15, $00 ; entry 2
    db $D8, $08, $16, $00 ; entry 3
    db $E0, $FB, $15, $00 ; entry 4
    db $E0, $03, $16, $00 ; entry 5
    db $E8, $F5, $15, $00 ; entry 6
    db $E8, $FD, $16, $00 ; entry 7
    db $F0, $F0, $15, $00 ; entry 8
    db $F0, $F8, $16, $00 ; entry 9
    db $F8, $EB, $15, $00 ; entry 10
    db $F8, $F3, $16, $00 ; entry 11
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites3D_4077Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set26Frame9::
Data_03D_5084:: ; address name
    db $D0, $0D, $15, $60 ; entry 0
    db $D0, $05, $16, $60 ; entry 1
    db $D8, $08, $15, $60 ; entry 2
    db $D8, $00, $16, $60 ; entry 3
    db $E0, $03, $15, $60 ; entry 4
    db $E0, $FB, $16, $60 ; entry 5
    db $E8, $FD, $15, $60 ; entry 6
    db $E8, $F5, $16, $60 ; entry 7
    db $F0, $F8, $15, $60 ; entry 8
    db $F0, $F0, $16, $60 ; entry 9
    db $F8, $F3, $15, $60 ; entry 10
    db $F8, $EB, $16, $60 ; entry 11
    db $80 ; end

; E-0147 (derived: frame 10 of MetaSprites3D_4077Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set26Frame10::
Data_03D_50B5:: ; address name
    db $D0, $05, $17, $00 ; entry 0
    db $D0, $0D, $18, $00 ; entry 1
    db $D8, $00, $17, $00 ; entry 2
    db $D8, $08, $18, $00 ; entry 3
    db $E0, $FB, $17, $00 ; entry 4
    db $E0, $03, $18, $00 ; entry 5
    db $E8, $F5, $17, $00 ; entry 6
    db $E8, $FD, $18, $00 ; entry 7
    db $F0, $F0, $17, $00 ; entry 8
    db $F0, $F8, $18, $00 ; entry 9
    db $F8, $EB, $17, $00 ; entry 10
    db $F8, $F3, $18, $00 ; entry 11
    db $80 ; end

; E-0147 (derived: frame 11 of MetaSprites3D_4077Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set26Frame11::
Data_03D_50E6:: ; address name
    db $D0, $0D, $17, $60 ; entry 0
    db $D0, $05, $18, $60 ; entry 1
    db $D8, $08, $17, $60 ; entry 2
    db $D8, $00, $18, $60 ; entry 3
    db $E0, $03, $17, $60 ; entry 4
    db $E0, $FB, $18, $60 ; entry 5
    db $E8, $FD, $17, $60 ; entry 6
    db $E8, $F5, $18, $60 ; entry 7
    db $F0, $F8, $17, $60 ; entry 8
    db $F0, $F0, $18, $60 ; entry 9
    db $F8, $F3, $17, $60 ; entry 10
    db $F8, $EB, $18, $60 ; entry 11
    db $80 ; end

; E-0147 (derived: frame 12 of MetaSprites3D_4077Set26; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set26Frame12::
    db $80 ; end

; E-0147 (derived: meta-sprite set 39 of MetaSprites3D_4077Table: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3D_4077Set27::
Data_03D_5118:: ; address name
    dw MetaSprites3D_4077Set27Frame0 ; entry 0
    dw MetaSprites3D_4077Set27Frame1 ; entry 1
    dw MetaSprites3D_4077Set27Frame2 ; entry 2
    dw MetaSprites3D_4077Set27Frame3 ; entry 3
    dw MetaSprites3D_4077Set27Frame4 ; entry 4
    dw MetaSprites3D_4077Set27Frame5 ; entry 5
    dw MetaSprites3D_4077Set27Frame6 ; entry 6
    dw MetaSprites3D_4077Set27Frame7 ; entry 7
    dw MetaSprites3D_4077Set27Frame8 ; entry 8
    dw MetaSprites3D_4077Set27Frame9 ; entry 9
    dw MetaSprites3D_4077Set27Frame10 ; entry 10
    dw MetaSprites3D_4077Set27Frame11 ; entry 11
    dw MetaSprites3D_4077Set27Frame12 ; entry 12
    dw MetaSprites3D_4077Set27Frame13 ; entry 13
    dw MetaSprites3D_4077Set27Frame14 ; entry 14
    dw MetaSprites3D_4077Set27Frame14 ; entry 15
    dw MetaSprites3D_4077Set27Frame14 ; entry 16
    dw MetaSprites3D_4077Set27Frame14 ; entry 17
    dw MetaSprites3D_4077Set27Frame14 ; entry 18
    dw MetaSprites3D_4077Set27Frame14 ; entry 19
    dw MetaSprites3D_4077Set27Frame14 ; entry 20
    dw MetaSprites3D_4077Set27Frame14 ; entry 21
    dw MetaSprites3D_4077Set27Frame14 ; entry 22
    dw MetaSprites3D_4077Set27Frame14 ; entry 23
    dw MetaSprites3D_4077Set27Frame14 ; entry 24
    dw MetaSprites3D_4077Set27Frame14 ; entry 25
    dw MetaSprites3D_4077Set27Frame14 ; entry 26
    dw MetaSprites3D_4077Set27Frame14 ; entry 27
    dw MetaSprites3D_4077Set27Frame14 ; entry 28
    dw MetaSprites3D_4077Set27Frame14 ; entry 29
    dw MetaSprites3D_4077Set27Frame14 ; entry 30
    dw MetaSprites3D_4077Set27Frame14 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3D_4077Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set27Frame0::
Data_03D_5158:: ; address name
    db $E8, $B0, $1C, $10 ; entry 0
    db $E8, $C0, $1E, $10 ; entry 1
    db $E8, $C8, $1F, $10 ; entry 2
    db $E6, $B8, $1D, $10 ; entry 3
    db $E2, $BF, $22, $10 ; entry 4
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3D_4077Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set27Frame1::
Data_03D_516D:: ; address name
    db $E8, $B0, $1C, $10 ; entry 0
    db $E8, $B8, $1C, $10 ; entry 1
    db $E8, $C0, $1C, $10 ; entry 2
    db $E8, $D0, $1E, $10 ; entry 3
    db $E8, $D8, $1F, $10 ; entry 4
    db $E6, $C8, $1D, $10 ; entry 5
    db $DC, $BA, $22, $10 ; entry 6
    db $E2, $C2, $22, $10 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3D_4077Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set27Frame2::
Data_03D_518E:: ; address name
    db $E8, $B0, $1C, $10 ; entry 0
    db $E8, $B8, $1C, $10 ; entry 1
    db $E8, $C0, $1C, $10 ; entry 2
    db $E8, $C8, $1C, $10 ; entry 3
    db $E8, $D0, $1C, $10 ; entry 4
    db $E8, $E0, $1E, $10 ; entry 5
    db $E8, $E8, $1F, $10 ; entry 6
    db $D9, $F3, $12, $10 ; entry 7
    db $E6, $D8, $1D, $10 ; entry 8
    db $D0, $03, $22, $10 ; entry 9
    db $D1, $F2, $22, $10 ; entry 10
    db $DD, $C6, $22, $10 ; entry 11
    db $DA, $BB, $22, $10 ; entry 12
    db $D0, $FA, $23, $10 ; entry 13
    db $D8, $FA, $24, $10 ; entry 14
    db $E0, $FA, $25, $10 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3D_4077Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set27Frame3::
Data_03D_51CF:: ; address name
    db $E8, $D8, $1C, $10 ; entry 0
    db $E8, $E0, $1C, $10 ; entry 1
    db $DC, $DF, $12, $10 ; entry 2
    db $D7, $F2, $12, $10 ; entry 3
    db $DB, $03, $12, $30 ; entry 4
    db $D0, $FC, $1B, $10 ; entry 5
    db $E8, $F8, $1F, $10 ; entry 6
    db $D8, $C0, $22, $10 ; entry 7
    db $DD, $D0, $22, $10 ; entry 8
    db $D1, $F2, $22, $10 ; entry 9
    db $D0, $03, $22, $10 ; entry 10
    db $D8, $FA, $23, $10 ; entry 11
    db $E8, $B0, $20, $10 ; entry 12
    db $E8, $BB, $21, $10 ; entry 13
    db $E8, $C6, $1C, $10 ; entry 14
    db $E8, $CF, $1C, $10 ; entry 15
    db $E0, $FA, $24, $10 ; entry 16
    db $E8, $FA, $25, $10 ; entry 17
    db $E0, $E8, $29, $10 ; entry 18
    db $E0, $F0, $2A, $10 ; entry 19
    db $E8, $E8, $2B, $10 ; entry 20
    db $E8, $F0, $2C, $10 ; entry 21
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3D_4077Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set27Frame4::
Data_03D_5228:: ; address name
    db $E8, $DD, $1C, $10 ; entry 0
    db $E8, $E5, $1C, $10 ; entry 1
    db $E8, $ED, $1C, $10 ; entry 2
    db $E8, $F5, $1C, $10 ; entry 3
    db $E8, $D3, $1C, $10 ; entry 4
    db $D0, $FC, $19, $10 ; entry 5
    db $E8, $FC, $1B, $10 ; entry 6
    db $DC, $D2, $12, $10 ; entry 7
    db $E8, $C8, $20, $10 ; entry 8
    db $F0, $FA, $24, $10 ; entry 9
    db $F8, $FA, $25, $10 ; entry 10
    db $D4, $F5, $22, $10 ; entry 11
    db $D8, $E0, $22, $10 ; entry 12
    db $D2, $03, $22, $30 ; entry 13
    db $DB, $01, $26, $10 ; entry 14
    db $D9, $06, $27, $10 ; entry 15
    db $D9, $F8, $27, $10 ; entry 16
    db $E0, $02, $29, $10 ; entry 17
    db $E0, $0A, $2A, $10 ; entry 18
    db $E0, $F6, $28, $10 ; entry 19
    db $E8, $02, $2D, $10 ; entry 20
    db $E8, $0A, $2E, $10 ; entry 21
    db $E6, $12, $2F, $10 ; entry 22
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3D_4077Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set27Frame5::
Data_03D_5285:: ; address name
    db $E8, $EF, $1C, $10 ; entry 0
    db $E8, $F7, $1C, $10 ; entry 1
    db $E8, $FF, $1C, $10 ; entry 2
    db $E8, $07, $1C, $10 ; entry 3
    db $E8, $0F, $1C, $10 ; entry 4
    db $E8, $27, $1F, $10 ; entry 5
    db $DA, $05, $12, $10 ; entry 6
    db $CF, $F2, $12, $10 ; entry 7
    db $F7, $03, $12, $30 ; entry 8
    db $F0, $FC, $19, $10 ; entry 9
    db $D0, $FC, $18, $10 ; entry 10
    db $D8, $FC, $22, $30 ; entry 11
    db $DC, $E8, $22, $10 ; entry 12
    db $D8, $11, $22, $10 ; entry 13
    db $F0, $F3, $22, $10 ; entry 14
    db $F8, $FA, $23, $10 ; entry 15
    db $DE, $FC, $27, $10 ; entry 16
    db $E0, $08, $26, $10 ; entry 17
    db $E8, $DF, $20, $10 ; entry 18
    db $E8, $E7, $21, $10 ; entry 19
    db $E0, $0F, $28, $10 ; entry 20
    db $E1, $16, $29, $10 ; entry 21
    db $E0, $1E, $2A, $10 ; entry 22
    db $E8, $17, $2B, $10 ; entry 23
    db $E8, $1F, $2C, $10 ; entry 24
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3D_4077Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set27Frame6::
Data_03D_52EA:: ; address name
    db $D0, $FC, $18, $10 ; entry 0
    db $E0, $FC, $18, $10 ; entry 1
    db $F8, $FC, $18, $10 ; entry 2
    db $F0, $FC, $19, $10 ; entry 3
    db $D8, $FC, $19, $10 ; entry 4
    db $D4, $06, $12, $10 ; entry 5
    db $DA, $DE, $12, $10 ; entry 6
    db $E8, $07, $1C, $10 ; entry 7
    db $E8, $0F, $1C, $10 ; entry 8
    db $E8, $17, $1C, $10 ; entry 9
    db $E8, $1F, $1C, $10 ; entry 10
    db $E8, $2F, $1E, $10 ; entry 11
    db $E8, $37, $1F, $10 ; entry 12
    db $E6, $27, $1D, $10 ; entry 13
    db $E0, $25, $26, $10 ; entry 14
    db $DE, $04, $26, $10 ; entry 15
    db $DD, $0F, $22, $10 ; entry 16
    db $DD, $EE, $22, $10 ; entry 17
    db $E8, $EB, $20, $10 ; entry 18
    db $E8, $F5, $20, $10 ; entry 19
    db $E8, $FF, $21, $10 ; entry 20
    db $DE, $19, $28, $10 ; entry 21
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3D_4077Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set27Frame7::
Data_03D_5343:: ; address name
    db $E8, $1F, $1C, $10 ; entry 0
    db $E8, $27, $1C, $10 ; entry 1
    db $E8, $37, $1E, $10 ; entry 2
    db $E8, $3F, $1F, $10 ; entry 3
    db $DB, $FA, $12, $10 ; entry 4
    db $E6, $2F, $1D, $10 ; entry 5
    db $DE, $D6, $22, $10 ; entry 6
    db $DB, $1D, $22, $10 ; entry 7
    db $E8, $F1, $20, $10 ; entry 8
    db $E8, $04, $20, $10 ; entry 9
    db $E8, $0D, $20, $10 ; entry 10
    db $E8, $15, $21, $10 ; entry 11
    db $E2, $27, $26, $10 ; entry 12
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites3D_4077Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set27Frame8::
Data_03D_5378:: ; address name
    db $E0, $3D, $12, $10 ; entry 0
    db $E8, $15, $20, $10 ; entry 1
    db $E8, $20, $20, $10 ; entry 2
    db $E8, $29, $20, $10 ; entry 3
    db $E8, $3A, $20, $10 ; entry 4
    db $E0, $2D, $22, $10 ; entry 5
    db $E8, $32, $21, $10 ; entry 6
    db $E8, $4A, $21, $10 ; entry 7
    db $E8, $B8, $20, $10 ; entry 8
    db $E8, $D4, $20, $10 ; entry 9
    db $E8, $F4, $22, $10 ; entry 10
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites3D_4077Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set27Frame9::
Data_03D_53A5:: ; address name
    db $E8, $4A, $20, $10 ; entry 0
    db $E8, $20, $20, $10 ; entry 1
    db $E8, $3E, $22, $10 ; entry 2
    db $E8, $2E, $21, $10 ; entry 3
    db $E8, $0D, $21, $10 ; entry 4
    db $E8, $02, $22, $10 ; entry 5
    db $E8, $DC, $22, $10 ; entry 6
    db $E8, $EA, $20, $10 ; entry 7
    db $E8, $BB, $22, $10 ; entry 8
    db $80 ; end

; E-0147 (derived: frame 10 of MetaSprites3D_4077Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set27Frame10::
Data_03D_53CA:: ; address name
    db $E8, $B1, $20, $10 ; entry 0
    db $E8, $D2, $20, $10 ; entry 1
    db $E8, $F8, $20, $10 ; entry 2
    db $E8, $E0, $21, $10 ; entry 3
    db $E8, $BF, $22, $10 ; entry 4
    db $E8, $0B, $22, $10 ; entry 5
    db $E8, $13, $20, $10 ; entry 6
    db $E8, $34, $20, $10 ; entry 7
    db $E8, $1C, $21, $10 ; entry 8
    db $E8, $40, $21, $10 ; entry 9
    db $80 ; end

; E-0147 (derived: frame 11 of MetaSprites3D_4077Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set27Frame11::
Data_03D_53F3:: ; address name
    db $E8, $03, $11, $30 ; entry 0
    db $E8, $0D, $11, $30 ; entry 1
    db $E8, $16, $03, $30 ; entry 2
    db $DD, $17, $03, $70 ; entry 3
    db $E8, $27, $07, $50 ; entry 4
    db $D5, $28, $02, $70 ; entry 5
    db $DD, $28, $07, $10 ; entry 6
    db $E8, $1E, $15, $30 ; entry 7
    db $D6, $20, $01, $10 ; entry 8
    db $DD, $1F, $15, $70 ; entry 9
    db $CD, $30, $17, $70 ; entry 10
    db $F8, $31, $17, $30 ; entry 11
    db $F0, $28, $02, $30 ; entry 12
    db $F0, $17, $02, $30 ; entry 13
    db $F0, $20, $01, $50 ; entry 14
    db $F0, $03, $11, $30 ; entry 15
    db $DD, $0D, $1A, $70 ; entry 16
    db $D0, $0C, $02, $10 ; entry 17
    db $D4, $14, $02, $10 ; entry 18
    db $E8, $F5, $11, $10 ; entry 19
    db $E8, $EB, $11, $10 ; entry 20
    db $E8, $E2, $03, $10 ; entry 21
    db $DD, $E1, $03, $50 ; entry 22
    db $E8, $D1, $07, $70 ; entry 23
    db $D5, $D0, $02, $50 ; entry 24
    db $DD, $D0, $07, $30 ; entry 25
    db $E8, $DA, $15, $10 ; entry 26
    db $D6, $D8, $01, $30 ; entry 27
    db $DD, $D9, $15, $50 ; entry 28
    db $CD, $C8, $17, $50 ; entry 29
    db $F0, $E1, $02, $10 ; entry 30
    db $F0, $D8, $01, $70 ; entry 31
    db $F0, $F5, $11, $10 ; entry 32
    db $D0, $EC, $02, $30 ; entry 33
    db $D4, $E4, $02, $30 ; entry 34
    db $F1, $D0, $02, $10 ; entry 35
    db $F8, $C8, $17, $10 ; entry 36
    db $DD, $EB, $1A, $50 ; entry 37
    db $F8, $03, $11, $30 ; entry 38
    db $F8, $F5, $11, $10 ; entry 39
    db $D8, $F5, $11, $50 ; entry 40
    db $DD, $F5, $11, $50 ; entry 41
    db $D0, $F5, $11, $50 ; entry 42
    db $D0, $03, $11, $70 ; entry 43
    db $DD, $03, $11, $70 ; entry 44
    db $D8, $03, $11, $70 ; entry 45
    db $F8, $DF, $02, $10 ; entry 46
    db $F8, $19, $02, $30 ; entry 47
    db $80 ; end

; E-0147 (derived: frame 12 of MetaSprites3D_4077Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set27Frame12::
Data_03D_54B4:: ; address name
    db $F8, $E8, $1A, $10 ; entry 0
    db $D0, $E8, $1A, $50 ; entry 1
    db $F0, $28, $14, $30 ; entry 2
    db $F8, $10, $1A, $30 ; entry 3
    db $D8, $28, $14, $70 ; entry 4
    db $D0, $10, $1A, $70 ; entry 5
    db $F0, $20, $13, $30 ; entry 6
    db $D8, $20, $13, $70 ; entry 7
    db $E8, $24, $13, $30 ; entry 8
    db $E0, $24, $13, $70 ; entry 9
    db $EA, $2C, $16, $50 ; entry 10
    db $DE, $2C, $16, $10 ; entry 11
    db $D0, $19, $11, $10 ; entry 12
    db $F8, $19, $11, $30 ; entry 13
    db $E0, $1B, $06, $70 ; entry 14
    db $E8, $1B, $06, $30 ; entry 15
    db $F0, $40, $06, $30 ; entry 16
    db $F8, $34, $06, $30 ; entry 17
    db $D8, $40, $06, $70 ; entry 18
    db $D0, $34, $06, $70 ; entry 19
    db $EA, $F5, $11, $10 ; entry 20
    db $EA, $03, $11, $30 ; entry 21
    db $DE, $F5, $11, $50 ; entry 22
    db $DE, $03, $11, $70 ; entry 23
    db $F0, $D0, $14, $10 ; entry 24
    db $D8, $D0, $14, $50 ; entry 25
    db $F0, $D8, $13, $10 ; entry 26
    db $D8, $D8, $13, $50 ; entry 27
    db $E0, $D4, $13, $50 ; entry 28
    db $D0, $DF, $11, $30 ; entry 29
    db $F8, $DF, $11, $10 ; entry 30
    db $E0, $DD, $06, $50 ; entry 31
    db $E8, $DD, $06, $10 ; entry 32
    db $F8, $C4, $06, $10 ; entry 33
    db $D0, $C4, $06, $50 ; entry 34
    db $F0, $F5, $11, $10 ; entry 35
    db $E8, $D4, $13, $10 ; entry 36
    db $F8, $F5, $1A, $10 ; entry 37
    db $E8, $CC, $16, $70 ; entry 38
    db $E0, $CC, $16, $30 ; entry 39
    db $D8, $F5, $11, $50 ; entry 40
    db $D0, $F5, $1A, $50 ; entry 41
    db $DE, $ED, $11, $50 ; entry 42
    db $EA, $ED, $11, $10 ; entry 43
    db $DE, $0B, $11, $70 ; entry 44
    db $EA, $0B, $11, $30 ; entry 45
    db $D8, $03, $11, $70 ; entry 46
    db $D0, $03, $1A, $70 ; entry 47
    db $F0, $03, $11, $30 ; entry 48
    db $F8, $03, $1A, $30 ; entry 49
    db $F8, $48, $06, $30 ; entry 50
    db $D0, $48, $06, $70 ; entry 51
    db $80 ; end

; E-0147 (derived: frame 13 of MetaSprites3D_4077Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set27Frame13::
Data_03D_5585:: ; address name
    db $E8, $F8, $0D, $10 ; entry 0
    db $E0, $F8, $0D, $50 ; entry 1
    db $D0, $F0, $10, $50 ; entry 2
    db $F0, $F8, $0E, $10 ; entry 3
    db $F8, $F8, $0E, $10 ; entry 4
    db $D8, $F8, $0E, $50 ; entry 5
    db $D0, $F8, $0E, $50 ; entry 6
    db $D0, $B1, $06, $50 ; entry 7
    db $D8, $D2, $0A, $50 ; entry 8
    db $D8, $E7, $0B, $50 ; entry 9
    db $D0, $D9, $0C, $50 ; entry 10
    db $D0, $CA, $07, $50 ; entry 11
    db $F8, $F0, $10, $10 ; entry 12
    db $F8, $B1, $06, $10 ; entry 13
    db $F0, $D2, $0A, $10 ; entry 14
    db $F0, $E7, $0B, $10 ; entry 15
    db $F8, $D9, $0C, $10 ; entry 16
    db $F8, $CA, $07, $10 ; entry 17
    db $F0, $BD, $04, $70 ; entry 18
    db $E9, $B4, $00, $10 ; entry 19
    db $D8, $BC, $04, $30 ; entry 20
    db $DF, $B4, $00, $50 ; entry 21
    db $E8, $00, $0D, $30 ; entry 22
    db $E0, $00, $0D, $70 ; entry 23
    db $D0, $08, $10, $70 ; entry 24
    db $F0, $00, $0E, $30 ; entry 25
    db $F8, $00, $0E, $30 ; entry 26
    db $D8, $00, $0E, $70 ; entry 27
    db $D0, $00, $0E, $70 ; entry 28
    db $D0, $47, $06, $70 ; entry 29
    db $D8, $26, $0A, $70 ; entry 30
    db $D8, $11, $0B, $70 ; entry 31
    db $D0, $1F, $0C, $70 ; entry 32
    db $D0, $2E, $07, $70 ; entry 33
    db $F8, $08, $10, $30 ; entry 34
    db $F8, $47, $06, $30 ; entry 35
    db $F0, $26, $0A, $30 ; entry 36
    db $F0, $11, $0B, $30 ; entry 37
    db $F8, $1F, $0C, $30 ; entry 38
    db $F8, $2E, $07, $30 ; entry 39
    db $F0, $3B, $04, $50 ; entry 40
    db $E9, $44, $00, $30 ; entry 41
    db $D8, $3C, $04, $10 ; entry 42
    db $DF, $44, $00, $70 ; entry 43
    db $E0, $DC, $00, $50 ; entry 44
    db $E8, $DC, $00, $10 ; entry 45
    db $E0, $1C, $00, $70 ; entry 46
    db $E8, $1C, $00, $30 ; entry 47
    db $E0, $10, $08, $70 ; entry 48
    db $E8, $10, $08, $30 ; entry 49
    db $E0, $E8, $08, $50 ; entry 50
    db $E8, $E8, $08, $10 ; entry 51
    db $E8, $F0, $0F, $10 ; entry 52
    db $E8, $08, $0F, $10 ; entry 53
    db $E0, $08, $0F, $50 ; entry 54
    db $E0, $F0, $0F, $50 ; entry 55
    db $80 ; end

; E-0147 (derived: frame 14 of MetaSprites3D_4077Set27; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set27Frame14::
    db $80 ; end

; E-0147 (derived: meta-sprite set 40 of MetaSprites3D_4077Table: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3D_4077Set28::
Data_03D_5667:: ; address name
    dw MetaSprites3D_4077Set28Frame0 ; entry 0
    dw MetaSprites3D_4077Set28Frame1 ; entry 1
    dw MetaSprites3D_4077Set28Frame2 ; entry 2
    dw MetaSprites3D_4077Set28Frame3 ; entry 3
    dw MetaSprites3D_4077Set28Frame4 ; entry 4
    dw MetaSprites3D_4077Set28Frame5 ; entry 5
    dw MetaSprites3D_4077Set28Frame6 ; entry 6
    dw MetaSprites3D_4077Set28Frame6 ; entry 7
    dw MetaSprites3D_4077Set28Frame6 ; entry 8
    dw MetaSprites3D_4077Set28Frame6 ; entry 9
    dw MetaSprites3D_4077Set28Frame6 ; entry 10
    dw MetaSprites3D_4077Set28Frame6 ; entry 11
    dw MetaSprites3D_4077Set28Frame6 ; entry 12
    dw MetaSprites3D_4077Set28Frame6 ; entry 13
    dw MetaSprites3D_4077Set28Frame6 ; entry 14
    dw MetaSprites3D_4077Set28Frame6 ; entry 15
    dw MetaSprites3D_4077Set28Frame6 ; entry 16
    dw MetaSprites3D_4077Set28Frame6 ; entry 17
    dw MetaSprites3D_4077Set28Frame6 ; entry 18
    dw MetaSprites3D_4077Set28Frame6 ; entry 19
    dw MetaSprites3D_4077Set28Frame6 ; entry 20
    dw MetaSprites3D_4077Set28Frame6 ; entry 21
    dw MetaSprites3D_4077Set28Frame6 ; entry 22
    dw MetaSprites3D_4077Set28Frame6 ; entry 23
    dw MetaSprites3D_4077Set28Frame6 ; entry 24
    dw MetaSprites3D_4077Set28Frame6 ; entry 25
    dw MetaSprites3D_4077Set28Frame6 ; entry 26
    dw MetaSprites3D_4077Set28Frame6 ; entry 27
    dw MetaSprites3D_4077Set28Frame6 ; entry 28
    dw MetaSprites3D_4077Set28Frame6 ; entry 29
    dw MetaSprites3D_4077Set28Frame6 ; entry 30
    dw MetaSprites3D_4077Set28Frame6 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3D_4077Set28; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set28Frame0::
Data_03D_56A7:: ; address name
    db $E4, $02, $0F, $10 ; entry 0
    db $EC, $02, $1F, $10 ; entry 1
    db $F8, $F2, $2F, $10 ; entry 2
    db $F8, $FF, $21, $10 ; entry 3
    db $F8, $F7, $26, $10 ; entry 4
    db $F0, $FF, $29, $50 ; entry 5
    db $E5, $EF, $19, $10 ; entry 6
    db $E9, $F4, $2A, $70 ; entry 7
    db $F0, $F7, $20, $10 ; entry 8
    db $E9, $FC, $29, $50 ; entry 9
    db $E3, $FB, $17, $10 ; entry 10
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3D_4077Set28; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set28Frame1::
Data_03D_56D4:: ; address name
    db $D5, $0D, $04, $10 ; entry 0
    db $D0, $05, $14, $10 ; entry 1
    db $DA, $05, $12, $10 ; entry 2
    db $E8, $EE, $18, $30 ; entry 3
    db $F8, $FE, $1A, $50 ; entry 4
    db $F8, $06, $1A, $30 ; entry 5
    db $D0, $FA, $19, $30 ; entry 6
    db $E8, $FE, $21, $10 ; entry 7
    db $D8, $F2, $21, $30 ; entry 8
    db $F0, $06, $20, $70 ; entry 9
    db $E0, $F0, $20, $10 ; entry 10
    db $E0, $F8, $20, $70 ; entry 11
    db $E0, $FD, $18, $10 ; entry 12
    db $E8, $F6, $20, $10 ; entry 13
    db $F0, $FC, $21, $70 ; entry 14
    db $F0, $FE, $00, $10 ; entry 15
    db $F0, $EE, $1F, $10 ; entry 16
    db $F8, $EC, $0F, $70 ; entry 17
    db $D0, $F2, $29, $70 ; entry 18
    db $F8, $F3, $12, $50 ; entry 19
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3D_4077Set28; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set28Frame2::
Data_03D_5725:: ; address name
    db $E2, $F3, $17, $10 ; entry 0
    db $F8, $00, $03, $50 ; entry 1
    db $D0, $04, $0F, $10 ; entry 2
    db $D0, $FC, $1C, $10 ; entry 3
    db $D8, $F8, $19, $10 ; entry 4
    db $F8, $F0, $2F, $10 ; entry 5
    db $F8, $08, $20, $30 ; entry 6
    db $D8, $04, $1F, $10 ; entry 7
    db $E1, $00, $20, $10 ; entry 8
    db $F0, $EF, $0F, $70 ; entry 9
    db $E8, $EF, $0F, $30 ; entry 10
    db $F2, $F7, $12, $50 ; entry 11
    db $F8, $F8, $26, $10 ; entry 12
    db $F0, $00, $25, $10 ; entry 13
    db $F0, $08, $24, $10 ; entry 14
    db $E8, $08, $23, $10 ; entry 15
    db $E0, $08, $22, $10 ; entry 16
    db $D0, $F3, $2A, $10 ; entry 17
    db $D9, $FF, $15, $70 ; entry 18
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3D_4077Set28; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set28Frame3::
Data_03D_5772:: ; address name
    db $E8, $F8, $00, $10 ; entry 0
    db $F8, $00, $00, $10 ; entry 1
    db $EC, $E8, $13, $10 ; entry 2
    db $DE, $F2, $12, $30 ; entry 3
    db $D3, $F2, $14, $30 ; entry 4
    db $D8, $EA, $04, $30 ; entry 5
    db $E8, $F0, $05, $10 ; entry 6
    db $F0, $F0, $15, $10 ; entry 7
    db $F0, $F8, $16, $10 ; entry 8
    db $E5, $06, $1C, $10 ; entry 9
    db $E5, $0E, $0F, $10 ; entry 10
    db $ED, $0E, $1F, $10 ; entry 11
    db $F8, $F8, $1A, $10 ; entry 12
    db $F8, $F1, $2F, $10 ; entry 13
    db $D0, $F8, $2F, $50 ; entry 14
    db $E8, $FD, $1A, $70 ; entry 15
    db $D8, $01, $1A, $10 ; entry 16
    db $F0, $00, $20, $70 ; entry 17
    db $F0, $07, $2E, $10 ; entry 18
    db $F8, $07, $1A, $70 ; entry 19
    db $D8, $08, $28, $10 ; entry 20
    db $D0, $00, $2A, $10 ; entry 21
    db $E2, $02, $20, $30 ; entry 22
    db $E0, $00, $00, $10 ; entry 23
    db $E0, $F8, $2B, $10 ; entry 24
    db $E0, $08, $29, $10 ; entry 25
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3D_4077Set28; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set28Frame4::
Data_03D_57DB:: ; address name
    db $D8, $FC, $00, $10 ; entry 0
    db $E8, $FC, $00, $10 ; entry 1
    db $F0, $FC, $00, $10 ; entry 2
    db $F8, $F4, $00, $10 ; entry 3
    db $D0, $FC, $00, $10 ; entry 4
    db $F8, $FC, $06, $10 ; entry 5
    db $F8, $00, $0B, $10 ; entry 6
    db $F8, $08, $0C, $10 ; entry 7
    db $E0, $F4, $01, $10 ; entry 8
    db $E0, $FC, $02, $10 ; entry 9
    db $E8, $F4, $11, $10 ; entry 10
    db $F0, $EE, $12, $70 ; entry 11
    db $ED, $10, $04, $10 ; entry 12
    db $E8, $ED, $04, $30 ; entry 13
    db $F8, $E8, $14, $30 ; entry 14
    db $F0, $08, $17, $10 ; entry 15
    db $D0, $E8, $0F, $30 ; entry 16
    db $D8, $E8, $1F, $30 ; entry 17
    db $D0, $F0, $1C, $30 ; entry 18
    db $F0, $F4, $1A, $10 ; entry 19
    db $F8, $F0, $1A, $10 ; entry 20
    db $D0, $0A, $20, $30 ; entry 21
    db $F0, $04, $21, $10 ; entry 22
    db $D8, $F4, $21, $30 ; entry 23
    db $E0, $EE, $20, $50 ; entry 24
    db $D0, $03, $00, $10 ; entry 25
    db $D8, $04, $00, $10 ; entry 26
    db $D8, $06, $21, $10 ; entry 27
    db $E0, $04, $20, $30 ; entry 28
    db $D0, $F7, $20, $50 ; entry 29
    db $E8, $03, $2C, $30 ; entry 30
    db $E8, $08, $14, $10 ; entry 31
    db $D0, $13, $2D, $10 ; entry 32
    db $D0, $0B, $17, $10 ; entry 33
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3D_4077Set28; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set28Frame5::
Data_03D_5864:: ; address name
    db $E0, $FF, $00, $10 ; entry 0
    db $E0, $07, $00, $10 ; entry 1
    db $E8, $08, $00, $10 ; entry 2
    db $F8, $F8, $00, $10 ; entry 3
    db $E8, $F8, $07, $10 ; entry 4
    db $E8, $00, $08, $10 ; entry 5
    db $D8, $FF, $1D, $10 ; entry 6
    db $D8, $07, $1E, $10 ; entry 7
    db $D0, $00, $0D, $10 ; entry 8
    db $D0, $07, $0E, $10 ; entry 9
    db $E0, $F3, $1B, $10 ; entry 10
    db $F8, $00, $00, $10 ; entry 11
    db $F0, $00, $09, $10 ; entry 12
    db $F0, $08, $0A, $10 ; entry 13
    db $F8, $08, $10, $10 ; entry 14
    db $F7, $10, $18, $70 ; entry 15
    db $D8, $F7, $03, $30 ; entry 16
    db $E9, $EB, $0F, $30 ; entry 17
    db $F1, $EB, $1F, $30 ; entry 18
    db $E9, $F3, $1C, $30 ; entry 19
    db $E0, $FB, $1A, $50 ; entry 20
    db $D0, $F0, $20, $10 ; entry 21
    db $D0, $F8, $1D, $10 ; entry 22
    db $E8, $0F, $1A, $70 ; entry 23
    db $D8, $EF, $19, $10 ; entry 24
    db $F0, $F8, $20, $50 ; entry 25
    db $F0, $F1, $2E, $30 ; entry 26
    db $E0, $0F, $24, $10 ; entry 27
    db $DA, $10, $2E, $10 ; entry 28
    db $F0, $10, $29, $10 ; entry 29
    db $F8, $F0, $2B, $50 ; entry 30
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3D_4077Set28; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set28Frame6::
    db $80 ; end

; E-0147 (derived: meta-sprite set 41 of MetaSprites3D_4077Table: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3D_4077Set29::
Data_03D_58E2:: ; address name
    dw MetaSprites3D_4077Set29Frame0 ; entry 0
    dw MetaSprites3D_4077Set29Frame1 ; entry 1
    dw MetaSprites3D_4077Set29Frame2 ; entry 2
    dw MetaSprites3D_4077Set29Frame3 ; entry 3
    dw MetaSprites3D_4077Set29Frame4 ; entry 4
    dw MetaSprites3D_4077Set29Frame5 ; entry 5
    dw MetaSprites3D_4077Set29Frame6 ; entry 6
    dw MetaSprites3D_4077Set29Frame7 ; entry 7
    dw MetaSprites3D_4077Set29Frame8 ; entry 8
    dw MetaSprites3D_4077Set29Frame9 ; entry 9
    dw MetaSprites3D_4077Set29Frame10 ; entry 10
    dw MetaSprites3D_4077Set29Frame11 ; entry 11
    dw MetaSprites3D_4077Set29Frame12 ; entry 12
    dw MetaSprites3D_4077Set29Frame13 ; entry 13
    dw MetaSprites3D_4077Set29Frame14 ; entry 14
    dw MetaSprites3D_4077Set29Frame15 ; entry 15
    dw MetaSprites3D_4077Set29Frame16 ; entry 16
    dw MetaSprites3D_4077Set29Frame17 ; entry 17
    dw MetaSprites3D_4077Set29Frame18 ; entry 18
    dw MetaSprites3D_4077Set29Frame19 ; entry 19
    dw MetaSprites3D_4077Set29Frame20 ; entry 20
    dw MetaSprites3D_4077Set29Frame20 ; entry 21
    dw MetaSprites3D_4077Set29Frame20 ; entry 22
    dw MetaSprites3D_4077Set29Frame20 ; entry 23
    dw MetaSprites3D_4077Set29Frame20 ; entry 24
    dw MetaSprites3D_4077Set29Frame20 ; entry 25
    dw MetaSprites3D_4077Set29Frame20 ; entry 26
    dw MetaSprites3D_4077Set29Frame20 ; entry 27
    dw MetaSprites3D_4077Set29Frame20 ; entry 28
    dw MetaSprites3D_4077Set29Frame20 ; entry 29
    dw MetaSprites3D_4077Set29Frame20 ; entry 30
    dw MetaSprites3D_4077Set29Frame20 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3D_4077Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set29Frame0::
Data_03D_5922:: ; address name
    db $F8, $F8, $1B, $00 ; entry 0
    db $F8, $00, $1B, $20 ; entry 1
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3D_4077Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set29Frame1::
Data_03D_592B:: ; address name
    db $F0, $F0, $1C, $00 ; entry 0
    db $F0, $F8, $1D, $00 ; entry 1
    db $F0, $08, $1C, $20 ; entry 2
    db $F0, $00, $1D, $20 ; entry 3
    db $F8, $F0, $1E, $00 ; entry 4
    db $F8, $F8, $1F, $00 ; entry 5
    db $F8, $08, $1E, $20 ; entry 6
    db $F8, $00, $1F, $20 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3D_4077Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set29Frame2::
Data_03D_594C:: ; address name
    db $E0, $E8, $20, $00 ; entry 0
    db $E0, $F0, $21, $00 ; entry 1
    db $E0, $F8, $22, $00 ; entry 2
    db $E8, $E0, $23, $00 ; entry 3
    db $E8, $E8, $24, $00 ; entry 4
    db $F0, $E0, $25, $00 ; entry 5
    db $F8, $E0, $26, $00 ; entry 6
    db $E8, $18, $23, $20 ; entry 7
    db $E8, $10, $24, $20 ; entry 8
    db $F0, $18, $25, $20 ; entry 9
    db $F8, $18, $26, $20 ; entry 10
    db $E0, $10, $20, $20 ; entry 11
    db $E0, $08, $21, $20 ; entry 12
    db $E0, $00, $22, $20 ; entry 13
    db $E8, $F0, $1F, $20 ; entry 14
    db $E8, $F8, $1F, $20 ; entry 15
    db $E8, $00, $1F, $20 ; entry 16
    db $E8, $08, $1F, $20 ; entry 17
    db $F0, $10, $1F, $20 ; entry 18
    db $F8, $10, $1F, $20 ; entry 19
    db $F8, $E8, $1F, $20 ; entry 20
    db $F0, $E8, $1F, $20 ; entry 21
    db $F0, $F0, $1F, $20 ; entry 22
    db $F8, $F0, $1F, $20 ; entry 23
    db $F8, $F8, $1F, $20 ; entry 24
    db $F0, $F8, $1F, $20 ; entry 25
    db $F0, $00, $1F, $20 ; entry 26
    db $F8, $00, $1F, $20 ; entry 27
    db $F8, $08, $1F, $20 ; entry 28
    db $F0, $08, $1F, $20 ; entry 29
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3D_4077Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set29Frame3::
Data_03D_59C5:: ; address name
    db $D6, $DC, $20, $00 ; entry 0
    db $E0, $D2, $23, $00 ; entry 1
    db $D5, $E8, $29, $00 ; entry 2
    db $D4, $F4, $2A, $00 ; entry 3
    db $EC, $D1, $2D, $00 ; entry 4
    db $F8, $D0, $2E, $00 ; entry 5
    db $F8, $ED, $27, $00 ; entry 6
    db $F8, $F8, $27, $00 ; entry 7
    db $F0, $F8, $27, $00 ; entry 8
    db $EF, $EE, $27, $00 ; entry 9
    db $F5, $DA, $28, $00 ; entry 10
    db $F0, $E4, $28, $00 ; entry 11
    db $E7, $E5, $28, $00 ; entry 12
    db $E9, $DB, $28, $00 ; entry 13
    db $DF, $DC, $28, $00 ; entry 14
    db $DE, $E6, $28, $00 ; entry 15
    db $DD, $F2, $28, $00 ; entry 16
    db $E6, $EE, $28, $00 ; entry 17
    db $DD, $FC, $28, $00 ; entry 18
    db $E6, $F7, $27, $00 ; entry 19
    db $D6, $1C, $20, $20 ; entry 20
    db $E0, $26, $23, $20 ; entry 21
    db $D5, $10, $29, $20 ; entry 22
    db $D4, $04, $2A, $20 ; entry 23
    db $EC, $27, $2D, $20 ; entry 24
    db $F8, $28, $2E, $20 ; entry 25
    db $F8, $0B, $27, $20 ; entry 26
    db $F8, $00, $27, $20 ; entry 27
    db $F0, $00, $27, $20 ; entry 28
    db $EF, $0A, $27, $20 ; entry 29
    db $F5, $1E, $28, $20 ; entry 30
    db $F0, $14, $28, $20 ; entry 31
    db $E7, $13, $28, $20 ; entry 32
    db $E9, $1D, $28, $20 ; entry 33
    db $DF, $1C, $28, $20 ; entry 34
    db $DE, $12, $28, $20 ; entry 35
    db $DD, $06, $28, $20 ; entry 36
    db $E6, $0A, $28, $20 ; entry 37
    db $E6, $01, $27, $20 ; entry 38
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3D_4077Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set29Frame4::
Data_03D_5A62:: ; address name
    db $D8, $33, $23, $20 ; entry 0
    db $D8, $0C, $27, $20 ; entry 1
    db $D8, $EC, $27, $00 ; entry 2
    db $D8, $C5, $23, $00 ; entry 3
    db $E8, $BE, $2B, $00 ; entry 4
    db $E8, $3A, $2B, $20 ; entry 5
    db $F0, $F0, $1C, $00 ; entry 6
    db $F0, $F8, $1D, $00 ; entry 7
    db $F0, $08, $1C, $20 ; entry 8
    db $F0, $00, $1D, $20 ; entry 9
    db $F8, $F0, $1E, $00 ; entry 10
    db $F8, $08, $1E, $20 ; entry 11
    db $F8, $F8, $1F, $00 ; entry 12
    db $F8, $00, $1F, $00 ; entry 13
    db $F8, $B8, $2D, $00 ; entry 14
    db $F8, $40, $2D, $20 ; entry 15
    db $E0, $C6, $28, $00 ; entry 16
    db $D8, $CD, $28, $00 ; entry 17
    db $F0, $BD, $28, $00 ; entry 18
    db $D8, $2B, $28, $20 ; entry 19
    db $E0, $32, $28, $20 ; entry 20
    db $F0, $3B, $28, $20 ; entry 21
    db $E8, $32, $28, $20 ; entry 22
    db $F8, $38, $28, $20 ; entry 23
    db $F8, $C0, $28, $00 ; entry 24
    db $E8, $C6, $28, $00 ; entry 25
    db $F0, $C5, $28, $00 ; entry 26
    db $F0, $33, $28, $20 ; entry 27
    db $E0, $CE, $28, $00 ; entry 28
    db $E0, $2A, $28, $20 ; entry 29
    db $D8, $23, $28, $20 ; entry 30
    db $D8, $D5, $28, $00 ; entry 31
    db $EC, $D6, $27, $00 ; entry 32
    db $EC, $22, $27, $20 ; entry 33
    db $E2, $E1, $27, $00 ; entry 34
    db $F8, $D0, $27, $00 ; entry 35
    db $E2, $17, $27, $20 ; entry 36
    db $F8, $28, $27, $20 ; entry 37
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3D_4077Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set29Frame5::
Data_03D_5AFB:: ; address name
    db $E0, $E8, $20, $00 ; entry 0
    db $E8, $E0, $23, $00 ; entry 1
    db $E0, $10, $20, $20 ; entry 2
    db $E8, $18, $23, $20 ; entry 3
    db $E0, $F0, $29, $00 ; entry 4
    db $F8, $E0, $2E, $00 ; entry 5
    db $F0, $E0, $2D, $00 ; entry 6
    db $E8, $E8, $2C, $00 ; entry 7
    db $E0, $F8, $2A, $00 ; entry 8
    db $E0, $08, $29, $20 ; entry 9
    db $E0, $00, $2A, $20 ; entry 10
    db $E8, $10, $2C, $20 ; entry 11
    db $F0, $18, $2D, $20 ; entry 12
    db $F8, $18, $2E, $20 ; entry 13
    db $E8, $F0, $28, $60 ; entry 14
    db $F0, $08, $28, $40 ; entry 15
    db $E8, $08, $28, $40 ; entry 16
    db $EC, $24, $28, $20 ; entry 17
    db $F4, $34, $28, $20 ; entry 18
    db $E0, $20, $28, $20 ; entry 19
    db $D2, $14, $28, $20 ; entry 20
    db $E0, $D8, $28, $00 ; entry 21
    db $D2, $E4, $28, $00 ; entry 22
    db $D0, $F4, $28, $00 ; entry 23
    db $D0, $04, $28, $20 ; entry 24
    db $F8, $E8, $28, $20 ; entry 25
    db $F8, $10, $28, $00 ; entry 26
    db $F0, $F0, $28, $60 ; entry 27
    db $E8, $00, $28, $40 ; entry 28
    db $F8, $08, $28, $40 ; entry 29
    db $F8, $00, $28, $40 ; entry 30
    db $E8, $F8, $28, $60 ; entry 31
    db $F8, $F0, $28, $60 ; entry 32
    db $F8, $F8, $28, $60 ; entry 33
    db $EC, $D4, $28, $00 ; entry 34
    db $F4, $C4, $28, $00 ; entry 35
    db $F0, $00, $28, $40 ; entry 36
    db $F0, $F8, $28, $60 ; entry 37
    db $F0, $E8, $28, $60 ; entry 38
    db $F0, $10, $28, $00 ; entry 39
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3D_4077Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set29Frame6::
Data_03D_5B9C:: ; address name
    db $D7, $DC, $20, $00 ; entry 0
    db $E0, $D1, $23, $00 ; entry 1
    db $E0, $27, $23, $20 ; entry 2
    db $D7, $1C, $20, $20 ; entry 3
    db $F8, $DC, $27, $00 ; entry 4
    db $EC, $DC, $27, $00 ; entry 5
    db $E0, $E8, $27, $00 ; entry 6
    db $E0, $F4, $27, $00 ; entry 7
    db $EB, $E7, $27, $00 ; entry 8
    db $EC, $1C, $27, $20 ; entry 9
    db $EB, $11, $27, $20 ; entry 10
    db $F8, $1C, $27, $20 ; entry 11
    db $E0, $10, $27, $20 ; entry 12
    db $E0, $04, $27, $20 ; entry 13
    db $F5, $F1, $28, $00 ; entry 14
    db $E0, $DC, $27, $00 ; entry 15
    db $E0, $1C, $27, $20 ; entry 16
    db $D6, $E8, $29, $00 ; entry 17
    db $D5, $F4, $2A, $00 ; entry 18
    db $D6, $10, $29, $20 ; entry 19
    db $D5, $04, $2A, $20 ; entry 20
    db $EC, $D0, $2D, $00 ; entry 21
    db $F8, $CF, $2E, $00 ; entry 22
    db $F8, $29, $2E, $20 ; entry 23
    db $EC, $28, $2D, $20 ; entry 24
    db $F5, $07, $28, $20 ; entry 25
    db $EB, $07, $28, $20 ; entry 26
    db $F5, $11, $28, $20 ; entry 27
    db $EB, $F1, $28, $00 ; entry 28
    db $F5, $E7, $28, $00 ; entry 29
    db $F0, $B8, $2D, $00 ; entry 30
    db $E0, $C1, $2B, $00 ; entry 31
    db $D0, $D4, $2C, $00 ; entry 32
    db $D0, $28, $2C, $20 ; entry 33
    db $E0, $37, $2B, $20 ; entry 34
    db $F0, $40, $2D, $20 ; entry 35
    db $F0, $C4, $28, $00 ; entry 36
    db $F0, $34, $28, $20 ; entry 37
    db $EA, $FC, $28, $00 ; entry 38
    db $F4, $FC, $28, $20 ; entry 39
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3D_4077Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set29Frame7::
Data_03D_5C3D:: ; address name
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

; E-0147 (derived: frame 8 of MetaSprites3D_4077Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set29Frame8::
Data_03D_5CDE:: ; address name
    db $E0, $25, $0F, $00 ; entry 0
    db $E0, $2D, $10, $00 ; entry 1
    db $E8, $24, $0E, $60 ; entry 2
    db $E8, $1C, $0F, $60 ; entry 3
    db $E8, $14, $10, $60 ; entry 4
    db $E8, $2C, $0D, $60 ; entry 5
    db $F0, $1C, $0C, $60 ; entry 6
    db $E0, $1D, $0E, $00 ; entry 7
    db $E0, $15, $0D, $00 ; entry 8
    db $E5, $FA, $08, $20 ; entry 9
    db $ED, $02, $09, $20 ; entry 10
    db $ED, $FA, $0A, $20 ; entry 11
    db $D0, $0C, $07, $20 ; entry 12
    db $D0, $04, $08, $20 ; entry 13
    db $D8, $0C, $09, $20 ; entry 14
    db $D8, $04, $0A, $20 ; entry 15
    db $F0, $24, $09, $20 ; entry 16
    db $E5, $02, $07, $20 ; entry 17
    db $E8, $E6, $0F, $20 ; entry 18
    db $E8, $DE, $10, $20 ; entry 19
    db $F0, $E7, $0E, $40 ; entry 20
    db $F0, $EF, $0F, $40 ; entry 21
    db $F0, $F7, $10, $40 ; entry 22
    db $F0, $DF, $0D, $40 ; entry 23
    db $E8, $EE, $0E, $20 ; entry 24
    db $E8, $F6, $0D, $20 ; entry 25
    db $F8, $E7, $0B, $40 ; entry 26
    db $F8, $EF, $0C, $40 ; entry 27
    db $E0, $EE, $0B, $20 ; entry 28
    db $E0, $E6, $0C, $20 ; entry 29
    db $D0, $2C, $07, $20 ; entry 30
    db $D0, $24, $08, $20 ; entry 31
    db $D8, $2C, $09, $20 ; entry 32
    db $D8, $24, $0A, $20 ; entry 33
    db $D8, $1E, $0C, $20 ; entry 34
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites3D_4077Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set29Frame9::
Data_03D_5D6B:: ; address name
    db $D4, $2A, $01, $00 ; entry 0
    db $DC, $22, $02, $00 ; entry 1
    db $DC, $2A, $03, $00 ; entry 2
    db $D4, $22, $00, $00 ; entry 3
    db $E7, $11, $01, $20 ; entry 4
    db $EF, $11, $03, $20 ; entry 5
    db $EF, $21, $02, $20 ; entry 6
    db $E7, $19, $04, $00 ; entry 7
    db $EF, $19, $05, $00 ; entry 8
    db $E7, $21, $01, $00 ; entry 9
    db $DB, $09, $00, $20 ; entry 10
    db $DB, $01, $01, $20 ; entry 11
    db $E3, $09, $02, $20 ; entry 12
    db $E3, $01, $03, $20 ; entry 13
    db $F7, $27, $02, $00 ; entry 14
    db $F7, $2F, $03, $00 ; entry 15
    db $EF, $27, $00, $00 ; entry 16
    db $EF, $2F, $01, $00 ; entry 17
    db $F0, $FB, $00, $00 ; entry 18
    db $F0, $03, $01, $00 ; entry 19
    db $F8, $FB, $02, $00 ; entry 20
    db $F8, $03, $03, $00 ; entry 21
    db $E3, $3C, $07, $20 ; entry 22
    db $E3, $34, $08, $20 ; entry 23
    db $EB, $3C, $09, $20 ; entry 24
    db $EB, $34, $0A, $20 ; entry 25
    db $DB, $19, $07, $20 ; entry 26
    db $DB, $11, $08, $20 ; entry 27
    db $E3, $19, $09, $20 ; entry 28
    db $E3, $11, $0A, $20 ; entry 29
    db $80 ; end

; E-0147 (derived: frame 10 of MetaSprites3D_4077Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set29Frame10::
Data_03D_5DE4:: ; address name
    db $EC, $34, $0E, $40 ; entry 0
    db $EC, $3C, $0F, $40 ; entry 1
    db $EC, $44, $10, $40 ; entry 2
    db $EC, $2C, $0D, $40 ; entry 3
    db $F4, $3C, $0C, $40 ; entry 4
    db $F4, $34, $09, $00 ; entry 5
    db $F4, $19, $07, $40 ; entry 6
    db $F4, $21, $08, $40 ; entry 7
    db $EC, $19, $09, $40 ; entry 8
    db $EC, $21, $0A, $40 ; entry 9
    db $F0, $04, $07, $00 ; entry 10
    db $F0, $0C, $08, $00 ; entry 11
    db $F8, $04, $09, $00 ; entry 12
    db $F8, $0C, $0A, $00 ; entry 13
    db $EC, $13, $11, $60 ; entry 14
    db $EC, $0B, $12, $60 ; entry 15
    db $D4, $04, $11, $00 ; entry 16
    db $D4, $0C, $12, $00 ; entry 17
    db $D4, $18, $14, $00 ; entry 18
    db $DC, $00, $15, $00 ; entry 19
    db $DC, $08, $16, $00 ; entry 20
    db $DC, $10, $17, $00 ; entry 21
    db $DC, $18, $18, $00 ; entry 22
    db $E4, $18, $15, $60 ; entry 23
    db $E4, $10, $16, $60 ; entry 24
    db $E4, $08, $17, $60 ; entry 25
    db $E4, $00, $18, $60 ; entry 26
    db $DC, $28, $07, $20 ; entry 27
    db $DC, $20, $08, $20 ; entry 28
    db $E4, $28, $09, $20 ; entry 29
    db $E4, $20, $0A, $20 ; entry 30
    db $E4, $3B, $0E, $20 ; entry 31
    db $E4, $33, $0F, $20 ; entry 32
    db $E4, $43, $0D, $20 ; entry 33
    db $DC, $3B, $0B, $20 ; entry 34
    db $DC, $33, $0C, $20 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 11 of MetaSprites3D_4077Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set29Frame11::
Data_03D_5E75:: ; address name
    db $D8, $08, $02, $00 ; entry 0
    db $D8, $10, $03, $00 ; entry 1
    db $D0, $08, $00, $00 ; entry 2
    db $E3, $21, $01, $00 ; entry 3
    db $EB, $21, $03, $00 ; entry 4
    db $EB, $11, $02, $00 ; entry 5
    db $E3, $19, $04, $20 ; entry 6
    db $EB, $19, $05, $20 ; entry 7
    db $E3, $11, $01, $20 ; entry 8
    db $F3, $0B, $02, $20 ; entry 9
    db $F3, $03, $03, $20 ; entry 10
    db $EB, $03, $01, $20 ; entry 11
    db $F0, $26, $07, $20 ; entry 12
    db $F0, $1E, $08, $20 ; entry 13
    db $F8, $26, $09, $20 ; entry 14
    db $F8, $1E, $0A, $20 ; entry 15
    db $D3, $2D, $00, $00 ; entry 16
    db $D3, $35, $01, $00 ; entry 17
    db $DB, $2D, $02, $00 ; entry 18
    db $DB, $35, $03, $00 ; entry 19
    db $D7, $20, $07, $20 ; entry 20
    db $D7, $18, $08, $20 ; entry 21
    db $DF, $20, $09, $20 ; entry 22
    db $DF, $18, $0A, $20 ; entry 23
    db $EA, $29, $02, $00 ; entry 24
    db $E2, $31, $04, $00 ; entry 25
    db $E8, $39, $05, $00 ; entry 26
    db $E0, $39, $04, $00 ; entry 27
    db $EB, $0B, $0C, $00 ; entry 28
    db $D0, $10, $07, $20 ; entry 29
    db $E2, $29, $00, $00 ; entry 30
    db $E0, $41, $01, $00 ; entry 31
    db $EA, $31, $05, $00 ; entry 32
    db $E8, $41, $03, $00 ; entry 33
    db $80 ; end

; E-0147 (derived: frame 12 of MetaSprites3D_4077Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set29Frame12::
Data_03D_5EFE:: ; address name
    db $DC, $3C, $0E, $00 ; entry 0
    db $DC, $44, $0F, $00 ; entry 1
    db $DC, $34, $0D, $00 ; entry 2
    db $D4, $44, $0C, $00 ; entry 3
    db $E4, $43, $0E, $60 ; entry 4
    db $E4, $3B, $0F, $60 ; entry 5
    db $EC, $43, $0B, $60 ; entry 6
    db $EC, $3B, $0C, $60 ; entry 7
    db $D4, $3C, $0B, $00 ; entry 8
    db $E0, $2C, $11, $20 ; entry 9
    db $E0, $24, $12, $20 ; entry 10
    db $F8, $1D, $11, $40 ; entry 11
    db $F8, $25, $12, $40 ; entry 12
    db $F8, $31, $14, $40 ; entry 13
    db $F0, $19, $15, $40 ; entry 14
    db $F0, $21, $16, $40 ; entry 15
    db $F0, $29, $17, $40 ; entry 16
    db $F0, $31, $18, $40 ; entry 17
    db $E8, $31, $15, $20 ; entry 18
    db $E8, $29, $16, $20 ; entry 19
    db $E8, $21, $17, $20 ; entry 20
    db $E8, $19, $18, $20 ; entry 21
    db $D8, $20, $07, $40 ; entry 22
    db $D8, $28, $08, $40 ; entry 23
    db $D0, $20, $09, $40 ; entry 24
    db $D0, $28, $0A, $40 ; entry 25
    db $F0, $09, $07, $40 ; entry 26
    db $F0, $11, $08, $40 ; entry 27
    db $E8, $09, $09, $40 ; entry 28
    db $E8, $11, $0A, $40 ; entry 29
    db $F0, $43, $07, $20 ; entry 30
    db $F0, $3B, $08, $20 ; entry 31
    db $F8, $43, $09, $20 ; entry 32
    db $F8, $3B, $0A, $20 ; entry 33
    db $80 ; end

; E-0147 (derived: frame 13 of MetaSprites3D_4077Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set29Frame13::
Data_03D_5F87:: ; address name
    db $D0, $3F, $11, $20 ; entry 0
    db $D0, $37, $12, $20 ; entry 1
    db $E8, $30, $11, $40 ; entry 2
    db $E8, $38, $12, $40 ; entry 3
    db $E8, $44, $14, $40 ; entry 4
    db $E0, $2C, $15, $40 ; entry 5
    db $E0, $34, $16, $40 ; entry 6
    db $E0, $3C, $17, $40 ; entry 7
    db $E0, $44, $18, $40 ; entry 8
    db $D8, $44, $15, $20 ; entry 9
    db $D8, $3C, $16, $20 ; entry 10
    db $D8, $34, $17, $20 ; entry 11
    db $D8, $2C, $18, $20 ; entry 12
    db $E1, $20, $0E, $00 ; entry 13
    db $E1, $28, $0F, $00 ; entry 14
    db $E9, $27, $0E, $60 ; entry 15
    db $E9, $1F, $0F, $60 ; entry 16
    db $F1, $27, $0B, $60 ; entry 17
    db $F1, $1F, $0C, $60 ; entry 18
    db $D9, $20, $0B, $00 ; entry 19
    db $E0, $18, $0D, $00 ; entry 20
    db $E0, $14, $07, $20 ; entry 21
    db $E0, $0C, $08, $20 ; entry 22
    db $E8, $14, $09, $20 ; entry 23
    db $E8, $0C, $0A, $20 ; entry 24
    db $D0, $24, $07, $40 ; entry 25
    db $D0, $2C, $08, $40 ; entry 26
    db $F8, $26, $09, $40 ; entry 27
    db $F8, $2E, $0A, $40 ; entry 28
    db $D8, $08, $0E, $40 ; entry 29
    db $D8, $10, $0F, $40 ; entry 30
    db $D0, $0F, $0E, $20 ; entry 31
    db $D0, $07, $0F, $20 ; entry 32
    db $80 ; end

; E-0147 (derived: frame 14 of MetaSprites3D_4077Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set29Frame14::
Data_03D_600C:: ; address name
    db $E0, $D4, $0F, $20 ; entry 0
    db $E0, $CC, $10, $20 ; entry 1
    db $E8, $D5, $0E, $40 ; entry 2
    db $E8, $DD, $0F, $40 ; entry 3
    db $E8, $E5, $10, $40 ; entry 4
    db $E8, $CD, $0D, $40 ; entry 5
    db $F0, $DD, $0C, $40 ; entry 6
    db $E0, $DC, $0E, $20 ; entry 7
    db $E0, $E4, $0D, $20 ; entry 8
    db $E5, $FF, $08, $00 ; entry 9
    db $ED, $F7, $09, $00 ; entry 10
    db $ED, $FF, $0A, $00 ; entry 11
    db $D0, $ED, $07, $00 ; entry 12
    db $D0, $F5, $08, $00 ; entry 13
    db $D8, $ED, $09, $00 ; entry 14
    db $D8, $F5, $0A, $00 ; entry 15
    db $F0, $D5, $09, $00 ; entry 16
    db $E5, $F7, $07, $00 ; entry 17
    db $E8, $13, $0F, $00 ; entry 18
    db $E8, $1B, $10, $00 ; entry 19
    db $F0, $12, $0E, $60 ; entry 20
    db $F0, $0A, $0F, $60 ; entry 21
    db $F0, $02, $10, $60 ; entry 22
    db $F0, $1A, $0D, $60 ; entry 23
    db $E8, $0B, $0E, $00 ; entry 24
    db $E8, $03, $0D, $00 ; entry 25
    db $F8, $12, $0B, $60 ; entry 26
    db $F8, $0A, $0C, $60 ; entry 27
    db $E0, $0B, $0B, $00 ; entry 28
    db $E0, $13, $0C, $00 ; entry 29
    db $D0, $CD, $07, $00 ; entry 30
    db $D0, $D5, $08, $00 ; entry 31
    db $D8, $CD, $09, $00 ; entry 32
    db $D8, $D5, $0A, $00 ; entry 33
    db $D8, $DB, $0C, $00 ; entry 34
    db $80 ; end

; E-0147 (derived: frame 15 of MetaSprites3D_4077Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set29Frame15::
Data_03D_6099:: ; address name
    db $D4, $CE, $01, $20 ; entry 0
    db $DC, $D6, $02, $20 ; entry 1
    db $DC, $CE, $03, $20 ; entry 2
    db $D4, $D6, $00, $20 ; entry 3
    db $E7, $E7, $01, $00 ; entry 4
    db $EF, $E7, $03, $00 ; entry 5
    db $EF, $D7, $02, $00 ; entry 6
    db $E7, $DF, $04, $20 ; entry 7
    db $EF, $DF, $05, $20 ; entry 8
    db $E7, $D7, $01, $20 ; entry 9
    db $DB, $EF, $00, $00 ; entry 10
    db $DB, $F7, $01, $00 ; entry 11
    db $E3, $EF, $02, $00 ; entry 12
    db $E3, $F7, $03, $00 ; entry 13
    db $F7, $D1, $02, $20 ; entry 14
    db $F7, $C9, $03, $20 ; entry 15
    db $EF, $D1, $00, $20 ; entry 16
    db $EF, $C9, $01, $20 ; entry 17
    db $F0, $FD, $00, $20 ; entry 18
    db $F0, $F5, $01, $20 ; entry 19
    db $F8, $FD, $02, $20 ; entry 20
    db $F8, $F5, $03, $20 ; entry 21
    db $E3, $BC, $07, $00 ; entry 22
    db $E3, $C4, $08, $00 ; entry 23
    db $EB, $BC, $09, $00 ; entry 24
    db $EB, $C4, $0A, $00 ; entry 25
    db $DB, $DF, $07, $00 ; entry 26
    db $DB, $E7, $08, $00 ; entry 27
    db $E3, $DF, $09, $00 ; entry 28
    db $E3, $E7, $0A, $00 ; entry 29
    db $80 ; end

; E-0147 (derived: frame 16 of MetaSprites3D_4077Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set29Frame16::
Data_03D_6112:: ; address name
    db $EC, $C6, $0E, $60 ; entry 0
    db $EC, $BE, $0F, $60 ; entry 1
    db $EC, $B6, $10, $60 ; entry 2
    db $EC, $CE, $0D, $60 ; entry 3
    db $F4, $BE, $0C, $60 ; entry 4
    db $F4, $C6, $09, $20 ; entry 5
    db $F4, $E1, $07, $60 ; entry 6
    db $F4, $D9, $08, $60 ; entry 7
    db $EC, $E1, $09, $60 ; entry 8
    db $EC, $D9, $0A, $60 ; entry 9
    db $F0, $F6, $07, $20 ; entry 10
    db $F0, $EE, $08, $20 ; entry 11
    db $F8, $F6, $09, $20 ; entry 12
    db $F8, $EE, $0A, $20 ; entry 13
    db $EC, $E7, $11, $40 ; entry 14
    db $EC, $EF, $12, $40 ; entry 15
    db $D4, $F6, $11, $20 ; entry 16
    db $D4, $EE, $12, $20 ; entry 17
    db $D4, $E2, $14, $20 ; entry 18
    db $DC, $FA, $15, $20 ; entry 19
    db $DC, $F2, $16, $20 ; entry 20
    db $DC, $EA, $17, $20 ; entry 21
    db $DC, $E2, $18, $20 ; entry 22
    db $E4, $E2, $15, $40 ; entry 23
    db $E4, $EA, $16, $40 ; entry 24
    db $E4, $F2, $17, $40 ; entry 25
    db $E4, $FA, $18, $40 ; entry 26
    db $DC, $D2, $07, $00 ; entry 27
    db $DC, $DA, $08, $00 ; entry 28
    db $E4, $D2, $09, $00 ; entry 29
    db $E4, $DA, $0A, $00 ; entry 30
    db $E4, $BF, $0E, $00 ; entry 31
    db $E4, $C7, $0F, $00 ; entry 32
    db $E4, $B7, $0D, $00 ; entry 33
    db $DC, $BF, $0B, $00 ; entry 34
    db $DC, $C7, $0C, $00 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 17 of MetaSprites3D_4077Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set29Frame17::
Data_03D_61A3:: ; address name
    db $D8, $F0, $02, $20 ; entry 0
    db $D8, $E8, $03, $20 ; entry 1
    db $D0, $F0, $00, $20 ; entry 2
    db $E3, $D7, $01, $20 ; entry 3
    db $EB, $D7, $03, $20 ; entry 4
    db $EB, $E7, $02, $20 ; entry 5
    db $E3, $DF, $04, $00 ; entry 6
    db $EB, $DF, $05, $00 ; entry 7
    db $E3, $E7, $01, $00 ; entry 8
    db $F3, $ED, $02, $00 ; entry 9
    db $F3, $F5, $03, $00 ; entry 10
    db $EB, $F5, $01, $00 ; entry 11
    db $F0, $D2, $07, $00 ; entry 12
    db $F0, $DA, $08, $00 ; entry 13
    db $F8, $D2, $09, $00 ; entry 14
    db $F8, $DA, $0A, $00 ; entry 15
    db $D3, $CB, $00, $20 ; entry 16
    db $D3, $C3, $01, $20 ; entry 17
    db $DB, $CB, $02, $20 ; entry 18
    db $DB, $C3, $03, $20 ; entry 19
    db $D7, $D8, $07, $00 ; entry 20
    db $D7, $E0, $08, $00 ; entry 21
    db $DF, $D8, $09, $00 ; entry 22
    db $DF, $E0, $0A, $00 ; entry 23
    db $EA, $CF, $02, $20 ; entry 24
    db $E2, $C7, $04, $20 ; entry 25
    db $E8, $BF, $05, $20 ; entry 26
    db $E0, $BF, $04, $20 ; entry 27
    db $EB, $ED, $0C, $20 ; entry 28
    db $D0, $E8, $07, $00 ; entry 29
    db $E8, $B7, $03, $20 ; entry 30
    db $E0, $B7, $00, $00 ; entry 31
    db $EA, $C7, $05, $00 ; entry 32
    db $E2, $CF, $01, $00 ; entry 33
    db $80 ; end

; E-0147 (derived: frame 18 of MetaSprites3D_4077Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set29Frame18::
Data_03D_622C:: ; address name
    db $DC, $BC, $0E, $20 ; entry 0
    db $DC, $B4, $0F, $20 ; entry 1
    db $DC, $C4, $0D, $20 ; entry 2
    db $D4, $B4, $0C, $20 ; entry 3
    db $E4, $B5, $0E, $40 ; entry 4
    db $E4, $BD, $0F, $40 ; entry 5
    db $EC, $B5, $0B, $40 ; entry 6
    db $EC, $BD, $0C, $40 ; entry 7
    db $D4, $BC, $0B, $20 ; entry 8
    db $E0, $CC, $11, $00 ; entry 9
    db $E0, $D4, $12, $00 ; entry 10
    db $F8, $DB, $11, $60 ; entry 11
    db $F8, $D3, $12, $60 ; entry 12
    db $F8, $C7, $14, $60 ; entry 13
    db $F0, $DF, $15, $60 ; entry 14
    db $F0, $D7, $16, $60 ; entry 15
    db $F0, $CF, $17, $60 ; entry 16
    db $F0, $C7, $18, $60 ; entry 17
    db $E8, $C7, $15, $00 ; entry 18
    db $E8, $CF, $16, $00 ; entry 19
    db $E8, $D7, $17, $00 ; entry 20
    db $E8, $DF, $18, $00 ; entry 21
    db $D8, $D8, $07, $60 ; entry 22
    db $D8, $D0, $08, $60 ; entry 23
    db $D0, $D8, $09, $60 ; entry 24
    db $D0, $D0, $0A, $60 ; entry 25
    db $F0, $EF, $07, $60 ; entry 26
    db $F0, $E7, $08, $60 ; entry 27
    db $E8, $EF, $09, $60 ; entry 28
    db $E8, $E7, $0A, $60 ; entry 29
    db $F0, $B5, $07, $00 ; entry 30
    db $F0, $BD, $08, $00 ; entry 31
    db $F8, $B5, $09, $00 ; entry 32
    db $F8, $BD, $0A, $00 ; entry 33
    db $80 ; end

; E-0147 (derived: frame 19 of MetaSprites3D_4077Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set29Frame19::
Data_03D_62B5:: ; address name
    db $DC, $BC, $0E, $20 ; entry 0
    db $DC, $B4, $0F, $20 ; entry 1
    db $DC, $C4, $0D, $20 ; entry 2
    db $D4, $B4, $0C, $20 ; entry 3
    db $E4, $B5, $0E, $40 ; entry 4
    db $E4, $BD, $0F, $40 ; entry 5
    db $EC, $B5, $0B, $40 ; entry 6
    db $EC, $BD, $0C, $40 ; entry 7
    db $D4, $BC, $0B, $20 ; entry 8
    db $E0, $CC, $11, $00 ; entry 9
    db $E0, $D4, $12, $00 ; entry 10
    db $F8, $DB, $11, $60 ; entry 11
    db $F8, $D3, $12, $60 ; entry 12
    db $F8, $C7, $14, $60 ; entry 13
    db $F0, $DF, $15, $60 ; entry 14
    db $F0, $D7, $16, $60 ; entry 15
    db $F0, $CF, $17, $60 ; entry 16
    db $F0, $C7, $18, $60 ; entry 17
    db $E8, $C7, $15, $00 ; entry 18
    db $E8, $CF, $16, $00 ; entry 19
    db $E8, $D7, $17, $00 ; entry 20
    db $E8, $DF, $18, $00 ; entry 21
    db $D8, $D8, $07, $60 ; entry 22
    db $D8, $D0, $08, $60 ; entry 23
    db $D0, $D8, $09, $60 ; entry 24
    db $D0, $D0, $0A, $60 ; entry 25
    db $F0, $EF, $07, $60 ; entry 26
    db $F0, $E7, $08, $60 ; entry 27
    db $E8, $EF, $09, $60 ; entry 28
    db $E8, $E7, $0A, $60 ; entry 29
    db $F0, $B5, $07, $00 ; entry 30
    db $F0, $BD, $08, $00 ; entry 31
    db $F8, $B5, $09, $00 ; entry 32
    db $F8, $BD, $0A, $00 ; entry 33
    db $80 ; end

; E-0147 (derived: frame 20 of MetaSprites3D_4077Set29; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set29Frame20::
    db $80 ; end

; E-0147 (derived: meta-sprite set 42 of MetaSprites3D_4077Table: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3D_4077Set2A::
Data_03D_633F:: ; address name
    dw MetaSprites3D_4077Set2AFrame0 ; entry 0
    dw MetaSprites3D_4077Set2AFrame1 ; entry 1
    dw MetaSprites3D_4077Set2AFrame2 ; entry 2
    dw MetaSprites3D_4077Set2AFrame3 ; entry 3
    dw MetaSprites3D_4077Set2AFrame4 ; entry 4
    dw MetaSprites3D_4077Set2AFrame5 ; entry 5
    dw MetaSprites3D_4077Set2AFrame6 ; entry 6
    dw MetaSprites3D_4077Set2AFrame7 ; entry 7
    dw MetaSprites3D_4077Set2AFrame8 ; entry 8
    dw MetaSprites3D_4077Set2AFrame9 ; entry 9
    dw MetaSprites3D_4077Set2AFrame10 ; entry 10
    dw MetaSprites3D_4077Set2AFrame11 ; entry 11
    dw MetaSprites3D_4077Set2AFrame12 ; entry 12
    dw MetaSprites3D_4077Set2AFrame13 ; entry 13
    dw MetaSprites3D_4077Set2AFrame14 ; entry 14
    dw MetaSprites3D_4077Set2AFrame15 ; entry 15
    dw MetaSprites3D_4077Set2AFrame16 ; entry 16
    dw MetaSprites3D_4077Set2AFrame17 ; entry 17
    dw MetaSprites3D_4077Set2AFrame18 ; entry 18
    dw MetaSprites3D_4077Set2AFrame19 ; entry 19
    dw MetaSprites3D_4077Set2AFrame20 ; entry 20
    dw MetaSprites3D_4077Set2AFrame21 ; entry 21
    dw MetaSprites3D_4077Set2AFrame22 ; entry 22
    dw MetaSprites3D_4077Set2AFrame23 ; entry 23
    dw MetaSprites3D_4077Set2AFrame24 ; entry 24
    dw MetaSprites3D_4077Set2AFrame24 ; entry 25
    dw MetaSprites3D_4077Set2AFrame24 ; entry 26
    dw MetaSprites3D_4077Set2AFrame24 ; entry 27
    dw MetaSprites3D_4077Set2AFrame24 ; entry 28
    dw MetaSprites3D_4077Set2AFrame24 ; entry 29
    dw MetaSprites3D_4077Set2AFrame24 ; entry 30
    dw MetaSprites3D_4077Set2AFrame24 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3D_4077Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2AFrame0::
Data_03D_637F:: ; address name
    db $F8, $C0, $00, $00 ; entry 0
    db $F0, $C0, $00, $00 ; entry 1
    db $E8, $C0, $00, $00 ; entry 2
    db $F8, $E0, $00, $00 ; entry 3
    db $F0, $E0, $00, $00 ; entry 4
    db $F8, $F0, $00, $00 ; entry 5
    db $F0, $F0, $00, $00 ; entry 6
    db $E8, $F0, $00, $00 ; entry 7
    db $E0, $F0, $00, $00 ; entry 8
    db $D8, $F0, $00, $00 ; entry 9
    db $F8, $00, $00, $00 ; entry 10
    db $F0, $00, $00, $00 ; entry 11
    db $E8, $00, $00, $00 ; entry 12
    db $F8, $20, $00, $00 ; entry 13
    db $F0, $20, $00, $00 ; entry 14
    db $E8, $20, $00, $00 ; entry 15
    db $E0, $20, $00, $00 ; entry 16
    db $D8, $20, $00, $00 ; entry 17
    db $F8, $30, $00, $00 ; entry 18
    db $F0, $30, $00, $00 ; entry 19
    db $E0, $00, $00, $00 ; entry 20
    db $D8, $00, $00, $00 ; entry 21
    db $D0, $00, $00, $00 ; entry 22
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3D_4077Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2AFrame1::
Data_03D_63DC:: ; address name
    db $E8, $C0, $01, $00 ; entry 0
    db $E0, $C0, $01, $00 ; entry 1
    db $D0, $C0, $01, $00 ; entry 2
    db $D8, $C0, $01, $00 ; entry 3
    db $F8, $E0, $01, $00 ; entry 4
    db $F0, $E0, $01, $00 ; entry 5
    db $E8, $E0, $01, $00 ; entry 6
    db $E0, $E0, $01, $00 ; entry 7
    db $D0, $E0, $01, $00 ; entry 8
    db $D8, $E0, $01, $00 ; entry 9
    db $F8, $F0, $01, $00 ; entry 10
    db $F0, $F0, $01, $00 ; entry 11
    db $E8, $F0, $01, $00 ; entry 12
    db $E0, $F0, $01, $00 ; entry 13
    db $D0, $F0, $01, $00 ; entry 14
    db $D8, $F0, $01, $00 ; entry 15
    db $F8, $00, $01, $00 ; entry 16
    db $F0, $00, $01, $00 ; entry 17
    db $E8, $00, $01, $00 ; entry 18
    db $E0, $00, $01, $00 ; entry 19
    db $D0, $00, $01, $00 ; entry 20
    db $D8, $00, $01, $00 ; entry 21
    db $F8, $20, $01, $00 ; entry 22
    db $F0, $20, $01, $00 ; entry 23
    db $E8, $20, $01, $00 ; entry 24
    db $E0, $20, $01, $00 ; entry 25
    db $D0, $20, $01, $00 ; entry 26
    db $D8, $20, $01, $00 ; entry 27
    db $F8, $30, $01, $00 ; entry 28
    db $F0, $30, $01, $00 ; entry 29
    db $E8, $30, $01, $00 ; entry 30
    db $E0, $30, $01, $00 ; entry 31
    db $D0, $30, $01, $00 ; entry 32
    db $D8, $30, $01, $00 ; entry 33
    db $F8, $C0, $01, $00 ; entry 34
    db $F0, $C0, $01, $00 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3D_4077Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2AFrame2::
Data_03D_646D:: ; address name
    db $F0, $C8, $02, $00 ; entry 0
    db $E8, $C8, $02, $00 ; entry 1
    db $E0, $C8, $02, $00 ; entry 2
    db $D8, $C8, $02, $00 ; entry 3
    db $D0, $C8, $02, $00 ; entry 4
    db $F8, $D8, $02, $00 ; entry 5
    db $F0, $D8, $02, $00 ; entry 6
    db $E8, $D8, $02, $00 ; entry 7
    db $E0, $D8, $02, $00 ; entry 8
    db $D8, $D8, $02, $00 ; entry 9
    db $D0, $D8, $02, $00 ; entry 10
    db $F8, $F8, $02, $00 ; entry 11
    db $F0, $F8, $02, $00 ; entry 12
    db $E8, $F8, $02, $00 ; entry 13
    db $E0, $F8, $02, $00 ; entry 14
    db $D8, $F8, $02, $00 ; entry 15
    db $D0, $F8, $02, $00 ; entry 16
    db $F8, $08, $02, $00 ; entry 17
    db $F0, $08, $02, $00 ; entry 18
    db $E8, $08, $02, $00 ; entry 19
    db $E0, $08, $02, $00 ; entry 20
    db $D8, $08, $02, $00 ; entry 21
    db $D0, $08, $02, $00 ; entry 22
    db $F8, $18, $02, $00 ; entry 23
    db $F0, $18, $02, $00 ; entry 24
    db $E8, $18, $02, $00 ; entry 25
    db $E0, $18, $02, $00 ; entry 26
    db $D8, $18, $02, $00 ; entry 27
    db $D0, $18, $02, $00 ; entry 28
    db $F8, $38, $02, $00 ; entry 29
    db $F0, $38, $02, $00 ; entry 30
    db $E8, $38, $02, $00 ; entry 31
    db $E0, $38, $02, $00 ; entry 32
    db $D8, $38, $02, $00 ; entry 33
    db $D0, $38, $02, $00 ; entry 34
    db $F8, $C8, $02, $00 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3D_4077Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2AFrame3::
Data_03D_64FE:: ; address name
    db $F8, $BC, $02, $00 ; entry 0
    db $F0, $BC, $02, $00 ; entry 1
    db $E8, $BC, $02, $00 ; entry 2
    db $E0, $BC, $02, $00 ; entry 3
    db $D8, $BC, $02, $00 ; entry 4
    db $D0, $BC, $02, $00 ; entry 5
    db $F8, $DA, $02, $00 ; entry 6
    db $F0, $DA, $02, $00 ; entry 7
    db $E8, $DA, $02, $00 ; entry 8
    db $E0, $DA, $02, $00 ; entry 9
    db $D8, $DA, $02, $00 ; entry 10
    db $D0, $DA, $02, $00 ; entry 11
    db $F8, $F0, $02, $00 ; entry 12
    db $F0, $F0, $02, $00 ; entry 13
    db $E8, $F0, $02, $00 ; entry 14
    db $E0, $F0, $02, $00 ; entry 15
    db $D8, $F0, $02, $00 ; entry 16
    db $D0, $F0, $02, $00 ; entry 17
    db $F8, $FC, $02, $00 ; entry 18
    db $F0, $FC, $02, $00 ; entry 19
    db $E8, $FC, $02, $00 ; entry 20
    db $E0, $FC, $02, $00 ; entry 21
    db $D8, $FC, $02, $00 ; entry 22
    db $D0, $FC, $02, $00 ; entry 23
    db $F8, $20, $02, $00 ; entry 24
    db $F0, $20, $02, $00 ; entry 25
    db $E8, $20, $02, $00 ; entry 26
    db $E0, $20, $02, $00 ; entry 27
    db $D8, $20, $02, $00 ; entry 28
    db $D0, $20, $02, $00 ; entry 29
    db $F8, $40, $02, $00 ; entry 30
    db $F0, $40, $02, $00 ; entry 31
    db $E8, $40, $02, $00 ; entry 32
    db $E0, $40, $02, $00 ; entry 33
    db $D8, $40, $02, $00 ; entry 34
    db $D0, $40, $02, $00 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3D_4077Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2AFrame4::
Data_03D_658F:: ; address name
    db $F8, $26, $03, $00 ; entry 0
    db $F0, $26, $03, $00 ; entry 1
    db $E8, $26, $03, $00 ; entry 2
    db $E0, $26, $03, $00 ; entry 3
    db $D8, $26, $03, $00 ; entry 4
    db $D0, $26, $03, $00 ; entry 5
    db $F8, $F8, $03, $00 ; entry 6
    db $F0, $F8, $03, $00 ; entry 7
    db $E8, $F8, $03, $00 ; entry 8
    db $E0, $F8, $03, $00 ; entry 9
    db $D8, $F8, $03, $00 ; entry 10
    db $D0, $F8, $03, $00 ; entry 11
    db $F8, $B8, $03, $00 ; entry 12
    db $F0, $B8, $03, $00 ; entry 13
    db $E8, $B8, $03, $00 ; entry 14
    db $E0, $B8, $03, $00 ; entry 15
    db $D8, $B8, $03, $00 ; entry 16
    db $D0, $B8, $03, $00 ; entry 17
    db $F8, $C0, $03, $20 ; entry 18
    db $F0, $C0, $03, $20 ; entry 19
    db $E8, $C0, $03, $20 ; entry 20
    db $E0, $C0, $03, $20 ; entry 21
    db $D8, $C0, $03, $20 ; entry 22
    db $D0, $C0, $03, $20 ; entry 23
    db $F8, $00, $03, $20 ; entry 24
    db $F0, $00, $03, $20 ; entry 25
    db $E8, $00, $03, $20 ; entry 26
    db $E0, $00, $03, $20 ; entry 27
    db $D8, $00, $03, $20 ; entry 28
    db $D0, $00, $03, $20 ; entry 29
    db $F8, $2E, $03, $20 ; entry 30
    db $F0, $2E, $03, $20 ; entry 31
    db $E8, $2E, $03, $20 ; entry 32
    db $E0, $2E, $03, $20 ; entry 33
    db $D8, $2E, $03, $20 ; entry 34
    db $D0, $2E, $03, $20 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3D_4077Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2AFrame5::
Data_03D_6620:: ; address name
    db $F8, $D0, $03, $00 ; entry 0
    db $F0, $D0, $03, $00 ; entry 1
    db $E8, $D0, $03, $00 ; entry 2
    db $E0, $D0, $03, $00 ; entry 3
    db $D8, $D0, $03, $00 ; entry 4
    db $D0, $D0, $03, $00 ; entry 5
    db $F8, $D8, $03, $20 ; entry 6
    db $F0, $D8, $03, $20 ; entry 7
    db $E8, $D8, $03, $20 ; entry 8
    db $E0, $D8, $03, $20 ; entry 9
    db $D8, $D8, $03, $20 ; entry 10
    db $D0, $D8, $03, $20 ; entry 11
    db $F8, $3C, $03, $00 ; entry 12
    db $F0, $3C, $03, $00 ; entry 13
    db $E8, $3C, $03, $00 ; entry 14
    db $E0, $3C, $03, $00 ; entry 15
    db $D8, $3C, $03, $00 ; entry 16
    db $D0, $3C, $03, $00 ; entry 17
    db $F8, $44, $03, $20 ; entry 18
    db $F0, $44, $03, $20 ; entry 19
    db $E8, $44, $03, $20 ; entry 20
    db $E0, $44, $03, $20 ; entry 21
    db $D8, $44, $03, $20 ; entry 22
    db $D0, $44, $03, $20 ; entry 23
    db $F8, $10, $03, $00 ; entry 24
    db $F0, $10, $03, $00 ; entry 25
    db $E8, $10, $03, $00 ; entry 26
    db $E0, $10, $03, $00 ; entry 27
    db $D8, $10, $03, $00 ; entry 28
    db $D0, $10, $03, $00 ; entry 29
    db $F8, $18, $03, $20 ; entry 30
    db $F0, $18, $03, $20 ; entry 31
    db $E8, $18, $03, $20 ; entry 32
    db $E0, $18, $03, $20 ; entry 33
    db $D8, $18, $03, $20 ; entry 34
    db $D0, $18, $03, $20 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3D_4077Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2AFrame6::
Data_03D_66B1:: ; address name
    db $F8, $3C, $03, $20 ; entry 0
    db $F0, $3C, $03, $20 ; entry 1
    db $E8, $3C, $03, $20 ; entry 2
    db $E0, $3C, $03, $20 ; entry 3
    db $D8, $3C, $03, $20 ; entry 4
    db $D0, $3C, $03, $20 ; entry 5
    db $F8, $2C, $03, $00 ; entry 6
    db $F0, $2C, $03, $00 ; entry 7
    db $E8, $2C, $03, $00 ; entry 8
    db $E0, $2C, $03, $00 ; entry 9
    db $D8, $2C, $03, $00 ; entry 10
    db $D0, $2C, $03, $00 ; entry 11
    db $F8, $34, $04, $00 ; entry 12
    db $F0, $34, $04, $00 ; entry 13
    db $E8, $34, $04, $00 ; entry 14
    db $E0, $34, $04, $00 ; entry 15
    db $D8, $34, $04, $00 ; entry 16
    db $D0, $34, $04, $00 ; entry 17
    db $F8, $D0, $03, $20 ; entry 18
    db $F0, $D0, $03, $20 ; entry 19
    db $E8, $D0, $03, $20 ; entry 20
    db $E0, $D0, $03, $20 ; entry 21
    db $D8, $D0, $03, $20 ; entry 22
    db $D0, $D0, $03, $20 ; entry 23
    db $F8, $C0, $03, $00 ; entry 24
    db $F0, $C0, $03, $00 ; entry 25
    db $E8, $C0, $03, $00 ; entry 26
    db $E0, $C0, $03, $00 ; entry 27
    db $D8, $C0, $03, $00 ; entry 28
    db $D0, $C0, $03, $00 ; entry 29
    db $F8, $C8, $04, $00 ; entry 30
    db $F0, $C8, $04, $00 ; entry 31
    db $E8, $C8, $04, $00 ; entry 32
    db $E0, $C8, $04, $00 ; entry 33
    db $D8, $C8, $04, $00 ; entry 34
    db $D0, $C8, $04, $00 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3D_4077Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2AFrame7::
Data_03D_6742:: ; address name
    db $F8, $20, $03, $20 ; entry 0
    db $F0, $20, $03, $20 ; entry 1
    db $E8, $20, $03, $20 ; entry 2
    db $E0, $20, $03, $20 ; entry 3
    db $D8, $20, $03, $20 ; entry 4
    db $D0, $20, $03, $20 ; entry 5
    db $F8, $10, $03, $00 ; entry 6
    db $F0, $10, $03, $00 ; entry 7
    db $E8, $10, $03, $00 ; entry 8
    db $E0, $10, $03, $00 ; entry 9
    db $D8, $10, $03, $00 ; entry 10
    db $D0, $10, $03, $00 ; entry 11
    db $F8, $18, $04, $00 ; entry 12
    db $F0, $18, $04, $00 ; entry 13
    db $E8, $18, $04, $00 ; entry 14
    db $E0, $18, $04, $00 ; entry 15
    db $D8, $18, $04, $00 ; entry 16
    db $D0, $18, $04, $00 ; entry 17
    db $F8, $F0, $03, $20 ; entry 18
    db $F0, $F0, $03, $20 ; entry 19
    db $E8, $F0, $03, $20 ; entry 20
    db $E0, $F0, $03, $20 ; entry 21
    db $D8, $F0, $03, $20 ; entry 22
    db $D0, $F0, $03, $20 ; entry 23
    db $F8, $E0, $03, $00 ; entry 24
    db $F0, $E0, $03, $00 ; entry 25
    db $E8, $E0, $03, $00 ; entry 26
    db $E0, $E0, $03, $00 ; entry 27
    db $D8, $E0, $03, $00 ; entry 28
    db $D0, $E0, $03, $00 ; entry 29
    db $F8, $E8, $04, $00 ; entry 30
    db $F0, $E8, $04, $00 ; entry 31
    db $E8, $E8, $04, $00 ; entry 32
    db $E0, $E8, $04, $00 ; entry 33
    db $D8, $E8, $04, $00 ; entry 34
    db $D0, $E8, $04, $00 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites3D_4077Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2AFrame8::
Data_03D_67D3:: ; address name
    db $F8, $E8, $03, $00 ; entry 0
    db $F0, $E8, $03, $00 ; entry 1
    db $E8, $E8, $03, $00 ; entry 2
    db $E0, $E8, $03, $00 ; entry 3
    db $D8, $E8, $03, $00 ; entry 4
    db $D0, $E8, $03, $00 ; entry 5
    db $F8, $F0, $04, $00 ; entry 6
    db $F0, $F0, $04, $00 ; entry 7
    db $E8, $F0, $04, $00 ; entry 8
    db $E0, $F0, $04, $00 ; entry 9
    db $D8, $F0, $04, $00 ; entry 10
    db $D0, $F0, $04, $00 ; entry 11
    db $F8, $10, $03, $20 ; entry 12
    db $F0, $10, $03, $20 ; entry 13
    db $E8, $10, $03, $20 ; entry 14
    db $E0, $10, $03, $20 ; entry 15
    db $D8, $10, $03, $20 ; entry 16
    db $D0, $10, $03, $20 ; entry 17
    db $F8, $08, $04, $00 ; entry 18
    db $F0, $08, $04, $00 ; entry 19
    db $E8, $08, $04, $00 ; entry 20
    db $E0, $08, $04, $00 ; entry 21
    db $D8, $08, $04, $00 ; entry 22
    db $D0, $08, $04, $00 ; entry 23
    db $F8, $00, $04, $00 ; entry 24
    db $F0, $00, $04, $00 ; entry 25
    db $E8, $00, $04, $00 ; entry 26
    db $E0, $00, $04, $00 ; entry 27
    db $D8, $00, $04, $00 ; entry 28
    db $D0, $00, $04, $00 ; entry 29
    db $F8, $F8, $04, $00 ; entry 30
    db $F0, $F8, $04, $00 ; entry 31
    db $E8, $F8, $04, $00 ; entry 32
    db $E0, $F8, $04, $00 ; entry 33
    db $D8, $F8, $04, $00 ; entry 34
    db $D0, $F8, $04, $00 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites3D_4077Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2AFrame9::
Data_03D_6864:: ; address name
    db $D8, $18, $07, $00 ; entry 0
    db $E4, $F8, $12, $00 ; entry 1
    db $E4, $00, $13, $00 ; entry 2
    db $F8, $40, $0C, $00 ; entry 3
    db $F8, $48, $0D, $00 ; entry 4
    db $F0, $30, $05, $00 ; entry 5
    db $F8, $E8, $05, $00 ; entry 6
    db $F0, $10, $07, $00 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 10 of MetaSprites3D_4077Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2AFrame10::
Data_03D_6885:: ; address name
    db $D0, $FC, $10, $40 ; entry 0
    db $F8, $08, $1F, $20 ; entry 1
    db $F8, $00, $20, $20 ; entry 2
    db $F8, $F8, $21, $20 ; entry 3
    db $F0, $F8, $05, $40 ; entry 4
    db $E8, $40, $0C, $00 ; entry 5
    db $E8, $48, $0D, $00 ; entry 6
    db $F0, $40, $0E, $00 ; entry 7
    db $F0, $48, $0F, $00 ; entry 8
    db $E0, $30, $05, $40 ; entry 9
    db $F0, $28, $05, $00 ; entry 10
    db $F4, $1C, $12, $20 ; entry 11
    db $F4, $14, $13, $20 ; entry 12
    db $E8, $E8, $05, $40 ; entry 13
    db $F0, $B0, $06, $00 ; entry 14
    db $D8, $10, $06, $40 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 11 of MetaSprites3D_4077Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2AFrame11::
Data_03D_68C6:: ; address name
    db $E8, $F8, $1F, $00 ; entry 0
    db $E8, $00, $20, $00 ; entry 1
    db $E8, $08, $21, $00 ; entry 2
    db $F0, $F8, $22, $00 ; entry 3
    db $F0, $00, $23, $00 ; entry 4
    db $F0, $08, $24, $00 ; entry 5
    db $F8, $F8, $25, $00 ; entry 6
    db $F8, $00, $26, $00 ; entry 7
    db $F8, $08, $27, $00 ; entry 8
    db $E0, $C0, $1B, $00 ; entry 9
    db $E0, $C8, $1C, $00 ; entry 10
    db $E0, $D0, $1D, $00 ; entry 11
    db $E0, $D8, $1E, $00 ; entry 12
    db $D8, $C0, $17, $00 ; entry 13
    db $D8, $C8, $18, $00 ; entry 14
    db $D8, $D0, $19, $00 ; entry 15
    db $D8, $D8, $1A, $00 ; entry 16
    db $D0, $C1, $14, $00 ; entry 17
    db $D0, $C9, $15, $00 ; entry 18
    db $D0, $D1, $16, $00 ; entry 19
    db $D8, $40, $08, $00 ; entry 20
    db $D8, $48, $09, $00 ; entry 21
    db $E0, $40, $0A, $00 ; entry 22
    db $E0, $48, $0B, $00 ; entry 23
    db $F0, $28, $07, $00 ; entry 24
    db $E0, $B0, $06, $00 ; entry 25
    db $E0, $F8, $05, $20 ; entry 26
    db $F0, $D8, $06, $20 ; entry 27
    db $D0, $30, $05, $00 ; entry 28
    db $F8, $C8, $07, $20 ; entry 29
    db $E8, $18, $11, $00 ; entry 30
    db $E0, $18, $10, $00 ; entry 31
    db $F8, $B8, $11, $00 ; entry 32
    db $F0, $B8, $10, $00 ; entry 33
    db $F0, $30, $0C, $00 ; entry 34
    db $F0, $38, $0D, $00 ; entry 35
    db $F8, $30, $0E, $00 ; entry 36
    db $F8, $38, $0F, $00 ; entry 37
    db $D8, $E8, $05, $00 ; entry 38
    db $E0, $28, $05, $40 ; entry 39
    db $80 ; end

; E-0147 (derived: frame 12 of MetaSprites3D_4077Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2AFrame12::
Data_03D_6967:: ; address name
    db $D8, $F8, $1F, $00 ; entry 0
    db $D8, $00, $20, $00 ; entry 1
    db $D8, $08, $21, $00 ; entry 2
    db $E0, $F8, $22, $00 ; entry 3
    db $E0, $00, $23, $00 ; entry 4
    db $E0, $08, $24, $00 ; entry 5
    db $E8, $F8, $25, $00 ; entry 6
    db $E8, $00, $26, $00 ; entry 7
    db $E8, $08, $27, $00 ; entry 8
    db $D0, $D8, $1B, $20 ; entry 9
    db $D0, $D0, $1C, $20 ; entry 10
    db $D0, $C8, $1D, $20 ; entry 11
    db $D0, $C0, $1E, $20 ; entry 12
    db $D0, $48, $0A, $20 ; entry 13
    db $D0, $40, $0B, $20 ; entry 14
    db $E0, $28, $07, $20 ; entry 15
    db $D0, $B0, $06, $20 ; entry 16
    db $D0, $F8, $05, $20 ; entry 17
    db $E0, $D8, $06, $00 ; entry 18
    db $E8, $C8, $07, $00 ; entry 19
    db $D8, $14, $11, $20 ; entry 20
    db $D0, $14, $10, $20 ; entry 21
    db $E8, $B4, $11, $20 ; entry 22
    db $E0, $B4, $10, $20 ; entry 23
    db $E0, $38, $0C, $20 ; entry 24
    db $E0, $30, $0D, $20 ; entry 25
    db $E8, $38, $0E, $20 ; entry 26
    db $E8, $30, $0F, $20 ; entry 27
    db $D0, $28, $05, $20 ; entry 28
    db $F0, $FA, $28, $00 ; entry 29
    db $F0, $02, $29, $00 ; entry 30
    db $F8, $2F, $14, $00 ; entry 31
    db $F8, $37, $15, $00 ; entry 32
    db $F8, $3F, $16, $00 ; entry 33
    db $F0, $48, $05, $00 ; entry 34
    db $F8, $18, $07, $00 ; entry 35
    db $F0, $E8, $06, $00 ; entry 36
    db $F8, $D8, $05, $00 ; entry 37
    db $F8, $B8, $12, $00 ; entry 38
    db $F8, $C0, $13, $00 ; entry 39
    db $80 ; end

; E-0147 (derived: frame 13 of MetaSprites3D_4077Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2AFrame13::
Data_03D_6A08:: ; address name
    db $D0, $08, $22, $20 ; entry 0
    db $D0, $00, $23, $20 ; entry 1
    db $D0, $F8, $24, $20 ; entry 2
    db $D8, $08, $25, $20 ; entry 3
    db $D8, $00, $26, $20 ; entry 4
    db $D8, $F8, $27, $20 ; entry 5
    db $D0, $28, $07, $00 ; entry 6
    db $D0, $D8, $06, $40 ; entry 7
    db $D8, $C8, $07, $40 ; entry 8
    db $D0, $B4, $11, $60 ; entry 9
    db $D8, $B4, $10, $60 ; entry 10
    db $D8, $30, $0C, $40 ; entry 11
    db $D8, $38, $0D, $40 ; entry 12
    db $D0, $30, $0E, $40 ; entry 13
    db $D0, $38, $0F, $40 ; entry 14
    db $E0, $06, $28, $20 ; entry 15
    db $E0, $FE, $29, $20 ; entry 16
    db $E0, $48, $05, $40 ; entry 17
    db $E8, $18, $07, $40 ; entry 18
    db $E0, $E8, $06, $00 ; entry 19
    db $E8, $D8, $05, $40 ; entry 20
    db $F0, $BC, $11, $00 ; entry 21
    db $E8, $BC, $10, $00 ; entry 22
    db $E8, $2F, $14, $00 ; entry 23
    db $E8, $37, $15, $00 ; entry 24
    db $E8, $3F, $16, $00 ; entry 25
    db $F0, $2E, $17, $00 ; entry 26
    db $F0, $36, $18, $00 ; entry 27
    db $F0, $3E, $19, $00 ; entry 28
    db $F0, $46, $1A, $00 ; entry 29
    db $F8, $2E, $1B, $00 ; entry 30
    db $F8, $36, $1C, $00 ; entry 31
    db $F8, $3E, $1D, $00 ; entry 32
    db $F8, $46, $1E, $00 ; entry 33
    db $F0, $F8, $10, $00 ; entry 34
    db $F8, $F8, $11, $00 ; entry 35
    db $F0, $D0, $08, $00 ; entry 36
    db $F0, $D8, $09, $00 ; entry 37
    db $F8, $D0, $0A, $00 ; entry 38
    db $F8, $D8, $0B, $00 ; entry 39
    db $80 ; end

; E-0147 (derived: frame 14 of MetaSprites3D_4077Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2AFrame14::
Data_03D_6AA9:: ; address name
    db $D0, $FA, $28, $00 ; entry 0
    db $D0, $02, $29, $00 ; entry 1
    db $D0, $48, $05, $60 ; entry 2
    db $D8, $18, $07, $00 ; entry 3
    db $D0, $E8, $06, $00 ; entry 4
    db $D8, $D8, $05, $00 ; entry 5
    db $E8, $45, $14, $60 ; entry 6
    db $E8, $3D, $15, $60 ; entry 7
    db $E8, $35, $16, $60 ; entry 8
    db $E0, $46, $17, $60 ; entry 9
    db $E0, $3E, $18, $60 ; entry 10
    db $E0, $36, $19, $60 ; entry 11
    db $E0, $2E, $1A, $60 ; entry 12
    db $D8, $46, $1B, $60 ; entry 13
    db $D8, $3E, $1C, $60 ; entry 14
    db $D8, $36, $1D, $60 ; entry 15
    db $D8, $2E, $1E, $60 ; entry 16
    db $E8, $D0, $08, $40 ; entry 17
    db $E8, $D8, $09, $40 ; entry 18
    db $E0, $D0, $0A, $40 ; entry 19
    db $E0, $D8, $0B, $40 ; entry 20
    db $E4, $F8, $12, $00 ; entry 21
    db $E4, $00, $13, $00 ; entry 22
    db $DC, $B8, $12, $40 ; entry 23
    db $DC, $C0, $13, $40 ; entry 24
    db $F0, $D7, $14, $20 ; entry 25
    db $F0, $CF, $15, $20 ; entry 26
    db $F0, $C7, $16, $20 ; entry 27
    db $F8, $D8, $17, $20 ; entry 28
    db $F8, $D0, $18, $20 ; entry 29
    db $F8, $C8, $19, $20 ; entry 30
    db $F8, $C0, $1A, $20 ; entry 31
    db $F8, $40, $0C, $00 ; entry 32
    db $F8, $48, $0D, $00 ; entry 33
    db $F0, $30, $05, $00 ; entry 34
    db $F8, $E8, $05, $00 ; entry 35
    db $F0, $10, $07, $00 ; entry 36
    db $80 ; end

; E-0147 (derived: frame 15 of MetaSprites3D_4077Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2AFrame15::
Data_03D_6B3E:: ; address name
    db $D8, $2F, $14, $40 ; entry 0
    db $D8, $37, $15, $40 ; entry 1
    db $D8, $3F, $16, $40 ; entry 2
    db $D0, $2E, $17, $40 ; entry 3
    db $D0, $36, $18, $40 ; entry 4
    db $D0, $3E, $19, $40 ; entry 5
    db $D0, $46, $1A, $40 ; entry 6
    db $D8, $D0, $08, $40 ; entry 7
    db $D8, $D8, $09, $40 ; entry 8
    db $D0, $D0, $0A, $40 ; entry 9
    db $D0, $D8, $0B, $40 ; entry 10
    db $F0, $D7, $14, $60 ; entry 11
    db $F0, $CF, $15, $60 ; entry 12
    db $F0, $C7, $16, $60 ; entry 13
    db $E8, $D8, $17, $60 ; entry 14
    db $E8, $D0, $18, $60 ; entry 15
    db $E8, $C8, $19, $60 ; entry 16
    db $E8, $C0, $1A, $60 ; entry 17
    db $E0, $D8, $1B, $60 ; entry 18
    db $E0, $D0, $1C, $60 ; entry 19
    db $E0, $C8, $1D, $60 ; entry 20
    db $E0, $C0, $1E, $60 ; entry 21
    db $D0, $FC, $10, $40 ; entry 22
    db $F8, $08, $1F, $20 ; entry 23
    db $F8, $00, $20, $20 ; entry 24
    db $F8, $F8, $21, $20 ; entry 25
    db $F0, $F8, $05, $40 ; entry 26
    db $E8, $40, $0C, $00 ; entry 27
    db $E8, $48, $0D, $00 ; entry 28
    db $F0, $40, $0E, $00 ; entry 29
    db $F0, $48, $0F, $00 ; entry 30
    db $E0, $30, $05, $40 ; entry 31
    db $F0, $28, $05, $00 ; entry 32
    db $F4, $1C, $12, $20 ; entry 33
    db $F4, $14, $13, $20 ; entry 34
    db $E8, $E8, $05, $40 ; entry 35
    db $F0, $B0, $06, $00 ; entry 36
    db $D8, $10, $06, $40 ; entry 37
    db $80 ; end

; E-0147 (derived: frame 16 of MetaSprites3D_4077Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2AFrame16::
Data_03D_6BD7:: ; address name
    db $F0, $38, $07, $00 ; entry 0
    db $E0, $08, $05, $20 ; entry 1
    db $F0, $E8, $06, $20 ; entry 2
    db $D0, $40, $05, $00 ; entry 3
    db $E8, $28, $11, $00 ; entry 4
    db $E0, $28, $10, $00 ; entry 5
    db $E0, $38, $05, $40 ; entry 6
    db $E8, $10, $1B, $60 ; entry 7
    db $E8, $08, $1C, $60 ; entry 8
    db $E8, $00, $1D, $60 ; entry 9
    db $E8, $F8, $1E, $60 ; entry 10
    db $F0, $10, $17, $60 ; entry 11
    db $F0, $08, $18, $60 ; entry 12
    db $F0, $00, $19, $60 ; entry 13
    db $F0, $F8, $1A, $60 ; entry 14
    db $F8, $0F, $14, $60 ; entry 15
    db $F8, $07, $15, $60 ; entry 16
    db $F8, $FF, $16, $60 ; entry 17
    db $E0, $B0, $06, $00 ; entry 18
    db $E0, $40, $0C, $40 ; entry 19
    db $E0, $48, $0D, $40 ; entry 20
    db $D8, $40, $0E, $40 ; entry 21
    db $D8, $48, $0F, $40 ; entry 22
    db $D8, $E8, $05, $00 ; entry 23
    db $E0, $C0, $1B, $00 ; entry 24
    db $E0, $C8, $1C, $00 ; entry 25
    db $E0, $D0, $1D, $00 ; entry 26
    db $E0, $D8, $1E, $00 ; entry 27
    db $D8, $C0, $17, $00 ; entry 28
    db $D8, $C8, $18, $00 ; entry 29
    db $D8, $D0, $19, $00 ; entry 30
    db $D8, $D8, $1A, $00 ; entry 31
    db $D0, $C1, $14, $00 ; entry 32
    db $D0, $C9, $15, $00 ; entry 33
    db $D0, $D1, $16, $00 ; entry 34
    db $F8, $20, $05, $00 ; entry 35
    db $F0, $C0, $08, $00 ; entry 36
    db $F0, $C8, $09, $00 ; entry 37
    db $F8, $C0, $0A, $00 ; entry 38
    db $F8, $C8, $0B, $00 ; entry 39
    db $80 ; end

; E-0147 (derived: frame 17 of MetaSprites3D_4077Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2AFrame17::
Data_03D_6C78:: ; address name
    db $E0, $38, $07, $20 ; entry 0
    db $D0, $08, $05, $00 ; entry 1
    db $E0, $E8, $06, $00 ; entry 2
    db $D8, $28, $11, $20 ; entry 3
    db $D0, $28, $10, $20 ; entry 4
    db $D0, $38, $05, $60 ; entry 5
    db $E8, $10, $1B, $20 ; entry 6
    db $E8, $08, $1C, $20 ; entry 7
    db $E8, $00, $1D, $20 ; entry 8
    db $E8, $F8, $1E, $20 ; entry 9
    db $E0, $10, $17, $20 ; entry 10
    db $E0, $08, $18, $20 ; entry 11
    db $E0, $00, $19, $20 ; entry 12
    db $E0, $F8, $1A, $20 ; entry 13
    db $D8, $0F, $14, $20 ; entry 14
    db $D8, $07, $15, $20 ; entry 15
    db $D8, $FF, $16, $20 ; entry 16
    db $D0, $B0, $06, $00 ; entry 17
    db $D0, $48, $0C, $60 ; entry 18
    db $D0, $40, $0D, $60 ; entry 19
    db $D0, $D8, $1B, $20 ; entry 20
    db $D0, $D0, $1C, $20 ; entry 21
    db $D0, $C8, $1D, $20 ; entry 22
    db $D0, $C0, $1E, $20 ; entry 23
    db $E8, $20, $05, $20 ; entry 24
    db $E8, $C0, $08, $40 ; entry 25
    db $E8, $C8, $09, $40 ; entry 26
    db $E0, $C0, $0A, $40 ; entry 27
    db $E0, $C8, $0B, $40 ; entry 28
    db $F8, $20, $1F, $00 ; entry 29
    db $F8, $28, $20, $00 ; entry 30
    db $F8, $30, $21, $00 ; entry 31
    db $F8, $F0, $06, $00 ; entry 32
    db $F8, $B8, $07, $00 ; entry 33
    db $F4, $3C, $12, $00 ; entry 34
    db $F4, $44, $13, $00 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 18 of MetaSprites3D_4077Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2AFrame18::
Data_03D_6D09:: ; address name
    db $D0, $38, $07, $20 ; entry 0
    db $D0, $E8, $06, $00 ; entry 1
    db $D8, $10, $1B, $20 ; entry 2
    db $D8, $08, $1C, $20 ; entry 3
    db $D8, $00, $1D, $20 ; entry 4
    db $D8, $F8, $1E, $20 ; entry 5
    db $D0, $10, $17, $20 ; entry 6
    db $D0, $08, $18, $20 ; entry 7
    db $D0, $00, $19, $20 ; entry 8
    db $D0, $F8, $1A, $20 ; entry 9
    db $D8, $20, $05, $20 ; entry 10
    db $D8, $C0, $08, $40 ; entry 11
    db $D8, $C8, $09, $40 ; entry 12
    db $D0, $C0, $0A, $40 ; entry 13
    db $D0, $C8, $0B, $40 ; entry 14
    db $E8, $30, $1F, $20 ; entry 15
    db $E8, $28, $20, $20 ; entry 16
    db $E8, $20, $21, $20 ; entry 17
    db $E8, $F0, $06, $00 ; entry 18
    db $E8, $B8, $07, $00 ; entry 19
    db $E4, $3C, $12, $00 ; entry 20
    db $E4, $44, $13, $00 ; entry 21
    db $F0, $30, $22, $20 ; entry 22
    db $F0, $28, $23, $20 ; entry 23
    db $F0, $20, $24, $20 ; entry 24
    db $F8, $30, $25, $20 ; entry 25
    db $F8, $28, $26, $20 ; entry 26
    db $F8, $20, $27, $20 ; entry 27
    db $F0, $D0, $08, $00 ; entry 28
    db $F0, $D8, $09, $00 ; entry 29
    db $F8, $D0, $0A, $00 ; entry 30
    db $F8, $D8, $0B, $00 ; entry 31
    db $F0, $F8, $10, $00 ; entry 32
    db $F8, $F8, $11, $00 ; entry 33
    db $F8, $BC, $10, $00 ; entry 34
    db $80 ; end

; E-0147 (derived: frame 19 of MetaSprites3D_4077Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2AFrame19::
Data_03D_6D96:: ; address name
    db $D8, $20, $1F, $00 ; entry 0
    db $D8, $28, $20, $00 ; entry 1
    db $D8, $30, $21, $00 ; entry 2
    db $D8, $F0, $06, $00 ; entry 3
    db $D8, $B8, $07, $00 ; entry 4
    db $D4, $3C, $12, $00 ; entry 5
    db $D4, $44, $13, $00 ; entry 6
    db $E0, $20, $22, $00 ; entry 7
    db $E0, $28, $23, $00 ; entry 8
    db $E0, $30, $24, $00 ; entry 9
    db $E8, $20, $25, $00 ; entry 10
    db $E8, $28, $26, $00 ; entry 11
    db $E8, $30, $27, $00 ; entry 12
    db $E0, $D0, $08, $00 ; entry 13
    db $E0, $D8, $09, $00 ; entry 14
    db $E8, $D0, $0A, $00 ; entry 15
    db $E8, $D8, $0B, $00 ; entry 16
    db $E8, $BC, $10, $00 ; entry 17
    db $F0, $22, $28, $00 ; entry 18
    db $F0, $2A, $29, $00 ; entry 19
    db $F0, $D7, $14, $20 ; entry 20
    db $F0, $CF, $15, $20 ; entry 21
    db $F0, $C7, $16, $20 ; entry 22
    db $F8, $D8, $17, $20 ; entry 23
    db $F8, $D0, $18, $20 ; entry 24
    db $F8, $C8, $19, $20 ; entry 25
    db $F8, $C0, $1A, $20 ; entry 26
    db $F8, $40, $0C, $00 ; entry 27
    db $F8, $48, $0D, $00 ; entry 28
    db $F0, $10, $07, $00 ; entry 29
    db $E4, $F4, $12, $00 ; entry 30
    db $E4, $FC, $13, $00 ; entry 31
    db $F8, $E8, $05, $00 ; entry 32
    db $80 ; end

; E-0147 (derived: frame 20 of MetaSprites3D_4077Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2AFrame20::
Data_03D_6E1B:: ; address name
    db $D0, $20, $22, $00 ; entry 0
    db $D0, $28, $23, $00 ; entry 1
    db $D0, $30, $24, $00 ; entry 2
    db $D8, $20, $25, $00 ; entry 3
    db $D8, $28, $26, $00 ; entry 4
    db $D8, $30, $27, $00 ; entry 5
    db $D0, $D0, $08, $00 ; entry 6
    db $D0, $D8, $09, $00 ; entry 7
    db $D8, $D0, $0A, $00 ; entry 8
    db $D8, $D8, $0B, $00 ; entry 9
    db $D8, $BC, $10, $00 ; entry 10
    db $E0, $22, $28, $00 ; entry 11
    db $E0, $2A, $29, $00 ; entry 12
    db $E8, $40, $0C, $00 ; entry 13
    db $E8, $48, $0D, $00 ; entry 14
    db $E0, $10, $07, $00 ; entry 15
    db $D4, $F4, $12, $00 ; entry 16
    db $D4, $FC, $13, $00 ; entry 17
    db $E8, $E8, $05, $00 ; entry 18
    db $F8, $08, $1F, $20 ; entry 19
    db $F8, $00, $20, $20 ; entry 20
    db $F8, $F8, $21, $20 ; entry 21
    db $F0, $F8, $05, $40 ; entry 22
    db $F0, $40, $0E, $00 ; entry 23
    db $F0, $48, $0F, $00 ; entry 24
    db $F0, $28, $05, $00 ; entry 25
    db $F4, $1D, $12, $20 ; entry 26
    db $F4, $15, $13, $20 ; entry 27
    db $F0, $B0, $06, $00 ; entry 28
    db $F0, $D7, $14, $60 ; entry 29
    db $F0, $CF, $15, $60 ; entry 30
    db $F0, $C7, $16, $60 ; entry 31
    db $E8, $D8, $17, $60 ; entry 32
    db $E8, $D0, $18, $60 ; entry 33
    db $E8, $C8, $19, $60 ; entry 34
    db $E8, $C0, $1A, $60 ; entry 35
    db $E0, $D8, $1B, $60 ; entry 36
    db $E0, $D0, $1C, $60 ; entry 37
    db $E0, $C8, $1D, $60 ; entry 38
    db $E0, $C0, $1E, $60 ; entry 39
    db $80 ; end

; E-0147 (derived: frame 21 of MetaSprites3D_4077Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2AFrame21::
Data_03D_6EBC:: ; address name
    db $E8, $F8, $1F, $00 ; entry 0
    db $E8, $00, $20, $00 ; entry 1
    db $E8, $08, $21, $00 ; entry 2
    db $F0, $F8, $22, $00 ; entry 3
    db $F0, $00, $23, $00 ; entry 4
    db $F0, $08, $24, $00 ; entry 5
    db $F8, $F8, $25, $00 ; entry 6
    db $F8, $00, $26, $00 ; entry 7
    db $F8, $08, $27, $00 ; entry 8
    db $E0, $C0, $1B, $00 ; entry 9
    db $E0, $C8, $1C, $00 ; entry 10
    db $E0, $D0, $1D, $00 ; entry 11
    db $E0, $D8, $1E, $00 ; entry 12
    db $D8, $C0, $17, $00 ; entry 13
    db $D8, $C8, $18, $00 ; entry 14
    db $D8, $D0, $19, $00 ; entry 15
    db $D8, $D8, $1A, $00 ; entry 16
    db $D0, $C1, $14, $00 ; entry 17
    db $D0, $C9, $15, $00 ; entry 18
    db $D0, $D1, $16, $00 ; entry 19
    db $D8, $40, $08, $00 ; entry 20
    db $D8, $48, $09, $00 ; entry 21
    db $E0, $40, $0A, $00 ; entry 22
    db $E0, $48, $0B, $00 ; entry 23
    db $E0, $B0, $06, $00 ; entry 24
    db $E0, $F8, $05, $20 ; entry 25
    db $D0, $30, $05, $00 ; entry 26
    db $E8, $18, $11, $00 ; entry 27
    db $E0, $18, $10, $00 ; entry 28
    db $D8, $E8, $05, $00 ; entry 29
    db $E0, $28, $05, $40 ; entry 30
    db $80 ; end

; E-0147 (derived: frame 22 of MetaSprites3D_4077Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2AFrame22::
Data_03D_6F39:: ; address name
    db $D8, $F8, $1F, $00 ; entry 0
    db $D8, $00, $20, $00 ; entry 1
    db $D8, $08, $21, $00 ; entry 2
    db $E0, $F8, $22, $00 ; entry 3
    db $E0, $00, $23, $00 ; entry 4
    db $E0, $08, $24, $00 ; entry 5
    db $E8, $F8, $25, $00 ; entry 6
    db $E8, $00, $26, $00 ; entry 7
    db $E8, $08, $27, $00 ; entry 8
    db $D0, $D8, $1B, $20 ; entry 9
    db $D0, $D0, $1C, $20 ; entry 10
    db $D0, $C8, $1D, $20 ; entry 11
    db $D0, $C0, $1E, $20 ; entry 12
    db $D0, $48, $0A, $20 ; entry 13
    db $D0, $40, $0B, $20 ; entry 14
    db $D0, $B0, $06, $20 ; entry 15
    db $D0, $F8, $05, $20 ; entry 16
    db $D8, $14, $11, $20 ; entry 17
    db $D0, $14, $10, $20 ; entry 18
    db $D0, $28, $05, $20 ; entry 19
    db $F0, $FA, $28, $00 ; entry 20
    db $F0, $02, $29, $00 ; entry 21
    db $80 ; end

; E-0147 (derived: frame 23 of MetaSprites3D_4077Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2AFrame23::
Data_03D_6F92:: ; address name
    db $D0, $08, $25, $20 ; entry 0
    db $D0, $00, $26, $20 ; entry 1
    db $D0, $F8, $27, $20 ; entry 2
    db $D8, $06, $28, $20 ; entry 3
    db $D8, $FE, $29, $20 ; entry 4
    db $80 ; end

; E-0147 (derived: frame 24 of MetaSprites3D_4077Set2A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2AFrame24::
    db $80 ; end

; E-0147 (derived: meta-sprite set 43 of MetaSprites3D_4077Table: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3D_4077Set2B::
Data_03D_6FA8:: ; address name
    dw MetaSprites3D_4077Set2BFrame0 ; entry 0
    dw MetaSprites3D_4077Set2BFrame1 ; entry 1
    dw MetaSprites3D_4077Set2BFrame2 ; entry 2
    dw MetaSprites3D_4077Set2BFrame3 ; entry 3
    dw MetaSprites3D_4077Set2BFrame4 ; entry 4
    dw MetaSprites3D_4077Set2BFrame5 ; entry 5
    dw MetaSprites3D_4077Set2BFrame6 ; entry 6
    dw MetaSprites3D_4077Set2BFrame7 ; entry 7
    dw MetaSprites3D_4077Set2BFrame8 ; entry 8
    dw MetaSprites3D_4077Set2BFrame9 ; entry 9
    dw MetaSprites3D_4077Set2BFrame9 ; entry 10
    dw MetaSprites3D_4077Set2BFrame9 ; entry 11
    dw MetaSprites3D_4077Set2BFrame9 ; entry 12
    dw MetaSprites3D_4077Set2BFrame9 ; entry 13
    dw MetaSprites3D_4077Set2BFrame9 ; entry 14
    dw MetaSprites3D_4077Set2BFrame9 ; entry 15
    dw MetaSprites3D_4077Set2BFrame9 ; entry 16
    dw MetaSprites3D_4077Set2BFrame9 ; entry 17
    dw MetaSprites3D_4077Set2BFrame9 ; entry 18
    dw MetaSprites3D_4077Set2BFrame9 ; entry 19
    dw MetaSprites3D_4077Set2BFrame9 ; entry 20
    dw MetaSprites3D_4077Set2BFrame9 ; entry 21
    dw MetaSprites3D_4077Set2BFrame9 ; entry 22
    dw MetaSprites3D_4077Set2BFrame9 ; entry 23
    dw MetaSprites3D_4077Set2BFrame9 ; entry 24
    dw MetaSprites3D_4077Set2BFrame9 ; entry 25
    dw MetaSprites3D_4077Set2BFrame9 ; entry 26
    dw MetaSprites3D_4077Set2BFrame9 ; entry 27
    dw MetaSprites3D_4077Set2BFrame9 ; entry 28
    dw MetaSprites3D_4077Set2BFrame9 ; entry 29
    dw MetaSprites3D_4077Set2BFrame9 ; entry 30
    dw MetaSprites3D_4077Set2BFrame9 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3D_4077Set2B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2BFrame0::
Data_03D_6FE8:: ; address name
    db $F0, $F0, $1F, $10 ; entry 0
    db $F8, $F8, $21, $10 ; entry 1
    db $F5, $EB, $1F, $10 ; entry 2
    db $E8, $EC, $1E, $10 ; entry 3
    db $EC, $F8, $13, $10 ; entry 4
    db $D8, $F0, $1F, $50 ; entry 5
    db $D0, $F8, $21, $50 ; entry 6
    db $D3, $EB, $1F, $50 ; entry 7
    db $E0, $EC, $1E, $50 ; entry 8
    db $E0, $F5, $13, $50 ; entry 9
    db $D8, $F9, $0F, $30 ; entry 10
    db $DC, $F8, $13, $50 ; entry 11
    db $F0, $09, $1F, $30 ; entry 12
    db $F8, $01, $21, $30 ; entry 13
    db $F5, $0E, $1F, $30 ; entry 14
    db $E8, $0D, $1E, $30 ; entry 15
    db $E8, $04, $13, $30 ; entry 16
    db $F0, $00, $0F, $50 ; entry 17
    db $EC, $01, $13, $30 ; entry 18
    db $D8, $09, $1F, $70 ; entry 19
    db $D0, $01, $21, $70 ; entry 20
    db $D3, $0E, $1F, $70 ; entry 21
    db $E0, $0D, $1E, $70 ; entry 22
    db $E0, $04, $13, $70 ; entry 23
    db $DC, $01, $13, $70 ; entry 24
    db $E8, $F5, $13, $10 ; entry 25
    db $F0, $F9, $0F, $70 ; entry 26
    db $D8, $00, $0F, $10 ; entry 27
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3D_4077Set2B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2BFrame1::
Data_03D_7059:: ; address name
    db $EE, $E8, $18, $10 ; entry 0
    db $F6, $F8, $1B, $10 ; entry 1
    db $E6, $E4, $14, $10 ; entry 2
    db $F6, $F0, $18, $10 ; entry 3
    db $DA, $E8, $18, $50 ; entry 4
    db $D2, $F8, $1B, $50 ; entry 5
    db $E2, $E4, $14, $50 ; entry 6
    db $D2, $F0, $18, $50 ; entry 7
    db $EE, $10, $18, $30 ; entry 8
    db $F6, $00, $1B, $30 ; entry 9
    db $E6, $14, $14, $30 ; entry 10
    db $F6, $08, $18, $30 ; entry 11
    db $DA, $10, $18, $70 ; entry 12
    db $D2, $00, $1B, $70 ; entry 13
    db $E2, $14, $14, $70 ; entry 14
    db $D2, $08, $18, $70 ; entry 15
    db $E2, $0C, $13, $10 ; entry 16
    db $DA, $08, $13, $10 ; entry 17
    db $DA, $F0, $13, $30 ; entry 18
    db $DA, $F8, $13, $30 ; entry 19
    db $E6, $EC, $13, $70 ; entry 20
    db $EE, $F0, $13, $70 ; entry 21
    db $EE, $08, $13, $50 ; entry 22
    db $EE, $00, $13, $50 ; entry 23
    db $DA, $00, $13, $10 ; entry 24
    db $EE, $F8, $13, $70 ; entry 25
    db $E2, $EC, $13, $30 ; entry 26
    db $EA, $0C, $13, $10 ; entry 27
    db $E4, $F4, $0A, $10 ; entry 28
    db $E4, $04, $0A, $30 ; entry 29
    db $F3, $E3, $09, $10 ; entry 30
    db $F3, $15, $09, $30 ; entry 31
    db $D5, $15, $09, $70 ; entry 32
    db $D5, $E3, $09, $50 ; entry 33
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3D_4077Set2B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2BFrame2::
Data_03D_70E2:: ; address name
    db $F0, $F0, $19, $10 ; entry 0
    db $F8, $F0, $1B, $10 ; entry 1
    db $F0, $E0, $14, $10 ; entry 2
    db $F8, $E0, $17, $10 ; entry 3
    db $D8, $F0, $19, $50 ; entry 4
    db $D0, $F0, $1B, $50 ; entry 5
    db $D8, $E0, $14, $50 ; entry 6
    db $D0, $E0, $17, $50 ; entry 7
    db $F8, $08, $1B, $30 ; entry 8
    db $F0, $18, $14, $30 ; entry 9
    db $F8, $18, $17, $30 ; entry 10
    db $D0, $08, $1B, $70 ; entry 11
    db $D8, $18, $14, $70 ; entry 12
    db $D0, $18, $17, $70 ; entry 13
    db $F0, $08, $86, $30 ; entry 14
    db $D8, $08, $86, $70 ; entry 15
    db $D8, $00, $0D, $70 ; entry 16
    db $D0, $F8, $0E, $50 ; entry 17
    db $D0, $00, $0E, $50 ; entry 18
    db $F0, $F8, $0D, $10 ; entry 19
    db $F0, $00, $0D, $30 ; entry 20
    db $F8, $F8, $0E, $10 ; entry 21
    db $F8, $00, $0E, $10 ; entry 22
    db $D8, $10, $04, $10 ; entry 23
    db $D8, $E8, $04, $30 ; entry 24
    db $F0, $10, $04, $30 ; entry 25
    db $F0, $E8, $04, $10 ; entry 26
    db $F8, $E8, $1F, $10 ; entry 27
    db $F8, $10, $1F, $30 ; entry 28
    db $D0, $10, $1F, $10 ; entry 29
    db $D0, $E8, $1F, $30 ; entry 30
    db $EA, $F6, $08, $10 ; entry 31
    db $DE, $F6, $08, $50 ; entry 32
    db $DE, $02, $08, $70 ; entry 33
    db $EA, $02, $08, $30 ; entry 34
    db $E0, $E7, $00, $50 ; entry 35
    db $E8, $E2, $01, $10 ; entry 36
    db $E4, $E0, $0B, $10 ; entry 37
    db $E8, $11, $00, $30 ; entry 38
    db $E0, $11, $00, $70 ; entry 39
    db $E8, $16, $01, $30 ; entry 40
    db $E0, $16, $01, $70 ; entry 41
    db $E4, $18, $0B, $30 ; entry 42
    db $D8, $F8, $0D, $50 ; entry 43
    db $E8, $E7, $00, $10 ; entry 44
    db $E0, $E2, $01, $50 ; entry 45
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3D_4077Set2B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2BFrame3::
Data_03D_719B:: ; address name
    db $F0, $DC, $14, $10 ; entry 0
    db $F0, $E4, $15, $10 ; entry 1
    db $F8, $DC, $17, $10 ; entry 2
    db $F8, $EC, $1A, $10 ; entry 3
    db $F3, $F1, $19, $10 ; entry 4
    db $F8, $F8, $10, $10 ; entry 5
    db $D8, $DC, $14, $50 ; entry 6
    db $D8, $E4, $15, $50 ; entry 7
    db $D0, $DC, $17, $50 ; entry 8
    db $D0, $EC, $1A, $50 ; entry 9
    db $D5, $F1, $19, $50 ; entry 10
    db $D0, $F8, $10, $50 ; entry 11
    db $F0, $1C, $14, $30 ; entry 12
    db $F0, $14, $15, $30 ; entry 13
    db $F8, $1C, $17, $30 ; entry 14
    db $F8, $0C, $1A, $30 ; entry 15
    db $F3, $07, $19, $30 ; entry 16
    db $F8, $00, $10, $30 ; entry 17
    db $D8, $1C, $14, $70 ; entry 18
    db $D8, $14, $15, $70 ; entry 19
    db $D0, $1C, $17, $70 ; entry 20
    db $D0, $0C, $1A, $70 ; entry 21
    db $D5, $07, $19, $70 ; entry 22
    db $D0, $00, $10, $70 ; entry 23
    db $F8, $E4, $1F, $10 ; entry 24
    db $D0, $E4, $1F, $30 ; entry 25
    db $D0, $14, $1F, $10 ; entry 26
    db $F8, $14, $1F, $30 ; entry 27
    db $EF, $FC, $0D, $10 ; entry 28
    db $D9, $FC, $0D, $50 ; entry 29
    db $E0, $DB, $01, $50 ; entry 30
    db $E8, $DB, $01, $10 ; entry 31
    db $E8, $E3, $11, $10 ; entry 32
    db $E0, $E3, $11, $50 ; entry 33
    db $E9, $ED, $02, $10 ; entry 34
    db $DF, $ED, $02, $50 ; entry 35
    db $E0, $1D, $01, $70 ; entry 36
    db $E8, $1D, $01, $30 ; entry 37
    db $E8, $15, $11, $30 ; entry 38
    db $E0, $15, $11, $70 ; entry 39
    db $E9, $0B, $02, $30 ; entry 40
    db $DF, $0B, $02, $70 ; entry 41
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3D_4077Set2B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2BFrame4::
Data_03D_7244:: ; address name
    db $F8, $F4, $20, $10 ; entry 0
    db $F0, $D8, $15, $10 ; entry 1
    db $F8, $D0, $17, $10 ; entry 2
    db $EE, $EB, $1F, $10 ; entry 3
    db $F8, $E8, $1A, $10 ; entry 4
    db $D0, $F4, $20, $50 ; entry 5
    db $D8, $D8, $15, $50 ; entry 6
    db $D0, $D0, $17, $50 ; entry 7
    db $DA, $EB, $1F, $50 ; entry 8
    db $D0, $E8, $1A, $50 ; entry 9
    db $F8, $DF, $1F, $10 ; entry 10
    db $D0, $DF, $1F, $50 ; entry 11
    db $EA, $F6, $1F, $10 ; entry 12
    db $DE, $F6, $1F, $50 ; entry 13
    db $F0, $D0, $02, $10 ; entry 14
    db $D8, $D0, $02, $50 ; entry 15
    db $E8, $D7, $03, $10 ; entry 16
    db $E0, $D7, $03, $50 ; entry 17
    db $E8, $DE, $01, $70 ; entry 18
    db $E0, $DE, $01, $30 ; entry 19
    db $F0, $E1, $02, $10 ; entry 20
    db $D8, $E1, $02, $30 ; entry 21
    db $F8, $04, $20, $30 ; entry 22
    db $F0, $20, $15, $30 ; entry 23
    db $F8, $28, $17, $30 ; entry 24
    db $EE, $0D, $1F, $30 ; entry 25
    db $F8, $10, $1A, $30 ; entry 26
    db $D0, $04, $20, $70 ; entry 27
    db $D8, $20, $15, $70 ; entry 28
    db $D0, $28, $17, $70 ; entry 29
    db $DA, $0D, $1F, $70 ; entry 30
    db $D0, $10, $1A, $70 ; entry 31
    db $F8, $19, $1F, $30 ; entry 32
    db $D0, $19, $1F, $70 ; entry 33
    db $EA, $02, $1F, $30 ; entry 34
    db $DE, $02, $1F, $70 ; entry 35
    db $F0, $28, $02, $30 ; entry 36
    db $D8, $28, $02, $70 ; entry 37
    db $E8, $21, $03, $30 ; entry 38
    db $E0, $21, $03, $70 ; entry 39
    db $E8, $1A, $01, $50 ; entry 40
    db $E0, $1A, $01, $10 ; entry 41
    db $F0, $17, $02, $30 ; entry 42
    db $D8, $17, $02, $10 ; entry 43
    db $E0, $28, $07, $10 ; entry 44
    db $E8, $28, $07, $50 ; entry 45
    db $E0, $D0, $07, $30 ; entry 46
    db $E8, $D0, $07, $70 ; entry 47
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3D_4077Set2B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2BFrame5::
Data_03D_7305:: ; address name
    db $F0, $F8, $1B, $10 ; entry 0
    db $E8, $F0, $14, $10 ; entry 1
    db $F0, $DD, $1C, $10 ; entry 2
    db $F0, $F0, $1D, $10 ; entry 3
    db $F8, $E1, $18, $10 ; entry 4
    db $F8, $C2, $17, $10 ; entry 5
    db $F8, $D3, $17, $10 ; entry 6
    db $D8, $F8, $1B, $50 ; entry 7
    db $E0, $F0, $14, $50 ; entry 8
    db $D8, $DD, $1C, $50 ; entry 9
    db $D8, $F0, $1D, $50 ; entry 10
    db $D0, $E1, $18, $50 ; entry 11
    db $D0, $C2, $17, $50 ; entry 12
    db $D0, $D3, $17, $50 ; entry 13
    db $F8, $EF, $20, $10 ; entry 14
    db $E8, $F8, $12, $10 ; entry 15
    db $E0, $F8, $12, $50 ; entry 16
    db $F8, $FC, $0D, $10 ; entry 17
    db $D0, $EF, $20, $50 ; entry 18
    db $D0, $FC, $0D, $70 ; entry 19
    db $E0, $D7, $00, $30 ; entry 20
    db $E8, $D7, $00, $70 ; entry 21
    db $D8, $C8, $02, $30 ; entry 22
    db $F0, $C8, $02, $70 ; entry 23
    db $E8, $C8, $06, $10 ; entry 24
    db $E0, $C8, $06, $50 ; entry 25
    db $F0, $D0, $00, $70 ; entry 26
    db $D8, $D0, $00, $30 ; entry 27
    db $E8, $CF, $03, $10 ; entry 28
    db $E0, $CF, $03, $50 ; entry 29
    db $F0, $00, $1B, $30 ; entry 30
    db $E8, $08, $14, $30 ; entry 31
    db $F0, $1B, $1C, $30 ; entry 32
    db $F0, $08, $1D, $30 ; entry 33
    db $F8, $17, $18, $30 ; entry 34
    db $F8, $36, $17, $30 ; entry 35
    db $F8, $25, $17, $30 ; entry 36
    db $D8, $00, $1B, $70 ; entry 37
    db $E0, $08, $14, $70 ; entry 38
    db $D8, $1B, $1C, $70 ; entry 39
    db $D8, $08, $1D, $70 ; entry 40
    db $D0, $17, $18, $70 ; entry 41
    db $D0, $36, $17, $70 ; entry 42
    db $D0, $25, $17, $70 ; entry 43
    db $F8, $09, $20, $30 ; entry 44
    db $E8, $00, $12, $30 ; entry 45
    db $E0, $00, $12, $70 ; entry 46
    db $D0, $09, $20, $70 ; entry 47
    db $E0, $21, $00, $10 ; entry 48
    db $E8, $21, $00, $50 ; entry 49
    db $D8, $30, $02, $10 ; entry 50
    db $F0, $30, $02, $50 ; entry 51
    db $E8, $30, $06, $30 ; entry 52
    db $E0, $30, $06, $70 ; entry 53
    db $F0, $28, $00, $50 ; entry 54
    db $D8, $28, $00, $10 ; entry 55
    db $E8, $29, $03, $30 ; entry 56
    db $E0, $29, $03, $70 ; entry 57
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3D_4077Set2B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2BFrame6::
Data_03D_73EE:: ; address name
    db $F8, $D6, $18, $10 ; entry 0
    db $F0, $F4, $11, $10 ; entry 1
    db $F0, $EC, $18, $10 ; entry 2
    db $E8, $E5, $14, $10 ; entry 3
    db $E8, $ED, $13, $10 ; entry 4
    db $F8, $F7, $1B, $10 ; entry 5
    db $D0, $D6, $18, $50 ; entry 6
    db $D8, $F4, $11, $50 ; entry 7
    db $D8, $EC, $18, $50 ; entry 8
    db $E0, $E5, $14, $50 ; entry 9
    db $E0, $ED, $13, $50 ; entry 10
    db $D0, $F7, $1B, $50 ; entry 11
    db $F8, $C8, $1C, $10 ; entry 12
    db $D0, $C8, $1C, $50 ; entry 13
    db $F8, $B8, $17, $10 ; entry 14
    db $D0, $B8, $17, $50 ; entry 15
    db $F8, $ED, $1F, $10 ; entry 16
    db $D0, $E6, $1F, $30 ; entry 17
    db $F0, $E4, $1C, $10 ; entry 18
    db $D8, $DF, $1C, $50 ; entry 19
    db $EA, $BC, $14, $10 ; entry 20
    db $DE, $BC, $14, $50 ; entry 21
    db $F0, $CD, $05, $10 ; entry 22
    db $D8, $CB, $05, $50 ; entry 23
    db $F8, $22, $18, $30 ; entry 24
    db $F0, $04, $11, $30 ; entry 25
    db $F0, $0C, $18, $30 ; entry 26
    db $E8, $13, $14, $30 ; entry 27
    db $E8, $0B, $13, $30 ; entry 28
    db $F8, $01, $1B, $30 ; entry 29
    db $D0, $22, $18, $70 ; entry 30
    db $D8, $04, $11, $70 ; entry 31
    db $D8, $0C, $18, $70 ; entry 32
    db $E0, $13, $14, $70 ; entry 33
    db $E0, $0B, $13, $70 ; entry 34
    db $D0, $01, $1B, $70 ; entry 35
    db $F8, $30, $1C, $30 ; entry 36
    db $D0, $30, $1C, $70 ; entry 37
    db $F8, $40, $17, $30 ; entry 38
    db $D0, $40, $17, $70 ; entry 39
    db $F8, $0B, $1F, $30 ; entry 40
    db $D0, $12, $1F, $10 ; entry 41
    db $F0, $14, $1C, $30 ; entry 42
    db $D8, $19, $1C, $70 ; entry 43
    db $EA, $3C, $14, $30 ; entry 44
    db $DE, $3C, $14, $70 ; entry 45
    db $F0, $2B, $05, $30 ; entry 46
    db $D8, $2D, $05, $70 ; entry 47
    db $E0, $35, $00, $70 ; entry 48
    db $E8, $35, $00, $30 ; entry 49
    db $E0, $C3, $00, $50 ; entry 50
    db $E8, $C3, $00, $10 ; entry 51
    db $E8, $CB, $04, $10 ; entry 52
    db $E0, $CB, $04, $50 ; entry 53
    db $E0, $2D, $04, $70 ; entry 54
    db $E8, $2D, $04, $30 ; entry 55
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3D_4077Set2B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2BFrame7::
Data_03D_74CF:: ; address name
    db $F0, $CB, $15, $10 ; entry 0
    db $F8, $EC, $1A, $10 ; entry 1
    db $F3, $F1, $19, $10 ; entry 2
    db $F0, $E6, $04, $10 ; entry 3
    db $E8, $E3, $15, $10 ; entry 4
    db $F0, $B8, $14, $10 ; entry 5
    db $F8, $C5, $09, $10 ; entry 6
    db $F8, $F8, $0D, $10 ; entry 7
    db $ED, $C1, $16, $70 ; entry 8
    db $E4, $DA, $0C, $70 ; entry 9
    db $F0, $2E, $15, $30 ; entry 10
    db $F8, $0D, $1A, $30 ; entry 11
    db $F3, $08, $19, $30 ; entry 12
    db $F0, $13, $04, $30 ; entry 13
    db $E8, $16, $15, $30 ; entry 14
    db $F0, $41, $14, $30 ; entry 15
    db $F8, $34, $09, $30 ; entry 16
    db $F8, $01, $0D, $30 ; entry 17
    db $ED, $38, $16, $50 ; entry 18
    db $E4, $1F, $0C, $50 ; entry 19
    db $D8, $CB, $15, $50 ; entry 20
    db $D0, $EC, $1A, $50 ; entry 21
    db $D5, $F1, $19, $50 ; entry 22
    db $D8, $E6, $04, $50 ; entry 23
    db $E0, $E3, $15, $50 ; entry 24
    db $D8, $B8, $14, $50 ; entry 25
    db $D0, $C5, $09, $50 ; entry 26
    db $D0, $F8, $0D, $50 ; entry 27
    db $DB, $C1, $16, $30 ; entry 28
    db $D8, $2E, $15, $70 ; entry 29
    db $D0, $0D, $1A, $70 ; entry 30
    db $D5, $08, $19, $70 ; entry 31
    db $D8, $13, $04, $70 ; entry 32
    db $E0, $16, $15, $70 ; entry 33
    db $D8, $41, $14, $70 ; entry 34
    db $D0, $34, $09, $70 ; entry 35
    db $D0, $01, $0D, $70 ; entry 36
    db $DB, $38, $16, $10 ; entry 37
    db $F8, $E4, $06, $10 ; entry 38
    db $D0, $E4, $06, $50 ; entry 39
    db $D0, $15, $06, $10 ; entry 40
    db $F8, $15, $06, $50 ; entry 41
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites3D_4077Set2B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2BFrame8::
Data_03D_7578:: ; address name
    db $F8, $F4, $20, $10 ; entry 0
    db $F0, $D0, $14, $10 ; entry 1
    db $F8, $E8, $1A, $10 ; entry 2
    db $D0, $F4, $20, $50 ; entry 3
    db $D8, $D0, $14, $50 ; entry 4
    db $D0, $E8, $1A, $50 ; entry 5
    db $F0, $E5, $1F, $10 ; entry 6
    db $D8, $E5, $1F, $50 ; entry 7
    db $F0, $D8, $13, $10 ; entry 8
    db $D8, $D8, $13, $50 ; entry 9
    db $E8, $D4, $13, $10 ; entry 10
    db $E0, $D4, $13, $50 ; entry 11
    db $EA, $CC, $16, $70 ; entry 12
    db $DE, $CC, $16, $30 ; entry 13
    db $D0, $DF, $11, $30 ; entry 14
    db $F8, $DF, $11, $10 ; entry 15
    db $E0, $DD, $06, $50 ; entry 16
    db $E8, $DD, $06, $10 ; entry 17
    db $F8, $B0, $09, $10 ; entry 18
    db $F0, $B8, $06, $10 ; entry 19
    db $F8, $C4, $06, $10 ; entry 20
    db $F8, $04, $20, $30 ; entry 21
    db $F0, $28, $14, $30 ; entry 22
    db $F8, $10, $1A, $30 ; entry 23
    db $D0, $04, $20, $70 ; entry 24
    db $D8, $28, $14, $70 ; entry 25
    db $D0, $10, $1A, $70 ; entry 26
    db $F0, $13, $1F, $30 ; entry 27
    db $D8, $13, $1F, $70 ; entry 28
    db $F0, $20, $13, $30 ; entry 29
    db $D8, $20, $13, $70 ; entry 30
    db $E8, $24, $13, $30 ; entry 31
    db $E0, $24, $13, $70 ; entry 32
    db $EA, $2C, $16, $50 ; entry 33
    db $DE, $2C, $16, $10 ; entry 34
    db $D0, $19, $11, $10 ; entry 35
    db $F8, $19, $11, $30 ; entry 36
    db $E0, $1B, $06, $70 ; entry 37
    db $E8, $1B, $06, $30 ; entry 38
    db $F8, $48, $09, $30 ; entry 39
    db $F0, $40, $06, $30 ; entry 40
    db $F8, $34, $06, $30 ; entry 41
    db $D0, $48, $09, $70 ; entry 42
    db $D8, $40, $06, $70 ; entry 43
    db $D0, $34, $06, $70 ; entry 44
    db $D0, $B0, $09, $50 ; entry 45
    db $D8, $B8, $06, $50 ; entry 46
    db $D0, $C4, $06, $50 ; entry 47
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites3D_4077Set2B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2BFrame9::
    db $80 ; end

; E-0147 (derived: meta-sprite set 44 of MetaSprites3D_4077Table: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3D_4077Set2C::
Data_03D_763A:: ; address name
    dw MetaSprites3D_4077Set2CFrame0 ; entry 0
    dw MetaSprites3D_4077Set2CFrame1 ; entry 1
    dw MetaSprites3D_4077Set2CFrame2 ; entry 2
    dw MetaSprites3D_4077Set2CFrame3 ; entry 3
    dw MetaSprites3D_4077Set2CFrame4 ; entry 4
    dw MetaSprites3D_4077Set2CFrame5 ; entry 5
    dw MetaSprites3D_4077Set2CFrame6 ; entry 6
    dw MetaSprites3D_4077Set2CFrame7 ; entry 7
    dw MetaSprites3D_4077Set2CFrame8 ; entry 8
    dw MetaSprites3D_4077Set2CFrame9 ; entry 9
    dw MetaSprites3D_4077Set2CFrame10 ; entry 10
    dw MetaSprites3D_4077Set2CFrame10 ; entry 11
    dw MetaSprites3D_4077Set2CFrame10 ; entry 12
    dw MetaSprites3D_4077Set2CFrame10 ; entry 13
    dw MetaSprites3D_4077Set2CFrame10 ; entry 14
    dw MetaSprites3D_4077Set2CFrame10 ; entry 15
    dw MetaSprites3D_4077Set2CFrame10 ; entry 16
    dw MetaSprites3D_4077Set2CFrame10 ; entry 17
    dw MetaSprites3D_4077Set2CFrame10 ; entry 18
    dw MetaSprites3D_4077Set2CFrame10 ; entry 19
    dw MetaSprites3D_4077Set2CFrame10 ; entry 20
    dw MetaSprites3D_4077Set2CFrame10 ; entry 21
    dw MetaSprites3D_4077Set2CFrame10 ; entry 22
    dw MetaSprites3D_4077Set2CFrame10 ; entry 23
    dw MetaSprites3D_4077Set2CFrame10 ; entry 24
    dw MetaSprites3D_4077Set2CFrame10 ; entry 25
    dw MetaSprites3D_4077Set2CFrame10 ; entry 26
    dw MetaSprites3D_4077Set2CFrame10 ; entry 27
    dw MetaSprites3D_4077Set2CFrame10 ; entry 28
    dw MetaSprites3D_4077Set2CFrame10 ; entry 29
    dw MetaSprites3D_4077Set2CFrame10 ; entry 30
    dw MetaSprites3D_4077Set2CFrame10 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3D_4077Set2C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2CFrame0::
Data_03D_767A:: ; address name
    db $DF, $01, $00, $00 ; entry 0
    db $DF, $09, $01, $00 ; entry 1
    db $E7, $01, $02, $00 ; entry 2
    db $E7, $09, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3D_4077Set2C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2CFrame1::
Data_03D_768B:: ; address name
    db $DC, $05, $00, $00 ; entry 0
    db $DC, $0D, $01, $00 ; entry 1
    db $E4, $05, $02, $00 ; entry 2
    db $E4, $0D, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3D_4077Set2C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2CFrame2::
Data_03D_769C:: ; address name
    db $DA, $FE, $00, $00 ; entry 0
    db $DA, $06, $01, $00 ; entry 1
    db $E2, $FE, $02, $00 ; entry 2
    db $E2, $06, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3D_4077Set2C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2CFrame3::
Data_03D_76AD:: ; address name
    db $D6, $02, $00, $00 ; entry 0
    db $D6, $0A, $01, $00 ; entry 1
    db $DE, $02, $02, $00 ; entry 2
    db $DE, $0A, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3D_4077Set2C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2CFrame4::
Data_03D_76BE:: ; address name
    db $D5, $07, $00, $00 ; entry 0
    db $D5, $0F, $01, $00 ; entry 1
    db $DD, $07, $02, $00 ; entry 2
    db $DD, $0F, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3D_4077Set2C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2CFrame5::
Data_03D_76CF:: ; address name
    db $D4, $0B, $00, $00 ; entry 0
    db $D4, $13, $01, $00 ; entry 1
    db $DC, $0B, $02, $00 ; entry 2
    db $DC, $13, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3D_4077Set2C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2CFrame6::
Data_03D_76E0:: ; address name
    db $D2, $0A, $00, $00 ; entry 0
    db $D2, $12, $01, $00 ; entry 1
    db $DA, $0A, $02, $00 ; entry 2
    db $DA, $12, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3D_4077Set2C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2CFrame7::
Data_03D_76F1:: ; address name
    db $D1, $08, $00, $00 ; entry 0
    db $D1, $10, $01, $00 ; entry 1
    db $D9, $08, $02, $00 ; entry 2
    db $D9, $10, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites3D_4077Set2C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2CFrame8::
Data_03D_7702:: ; address name
    db $D0, $0A, $00, $00 ; entry 0
    db $D0, $12, $01, $00 ; entry 1
    db $D8, $0A, $02, $00 ; entry 2
    db $D8, $12, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites3D_4077Set2C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2CFrame9::
Data_03D_7713:: ; address name
    db $D0, $0C, $00, $00 ; entry 0
    db $D0, $14, $01, $00 ; entry 1
    db $D8, $0C, $02, $00 ; entry 2
    db $D8, $14, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 10 of MetaSprites3D_4077Set2C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3D_4077Set2CFrame10::
    db $80 ; end
    ds $8DB, $00
