SECTION "Bank 3F", ROMX[$4000], BANK[$3F]
    db $3F

; only called from DrawEffectSpriteForEffectTileOffsetRange (E-0047)
; 1 call site from 1 routine (e.g. DrawEffectSpriteForEffectTileOffsetRange)
; reads: wEffectTileOffset, wEffectFlags, wBattlePartyCount, wBattleTarget, wEffectSpriteX, wEffectSpriteAttrXor
; writes: wLoadSlot, wBattleArg0
; points at: wLoadSlot, wBattleArg0, hSpriteOriginX
DrawEffectSpriteForEffectTileOffsetRange_Sub02::
Func_03F_4001:: ; address name
    ld a, [wEffectTileOffset]
    cp a, $15
    jr nz, DrawEffectSpriteAtEffectSpriteX_Bank3F
    ld a, [wEffectFlags]
    bit 3, a
    jr z, DrawEffectSpriteAtEffectSpriteX_Bank3F
    ld a, [wBattlePartyCount]
    ld [wLoadSlot], a
    ld a, [wBattleTarget]
    and a, $04
    ld [wBattleArg0], a
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, Jump_03F_402B
    farcall SetEffectSpriteXForTargets
    call DrawEffectSpriteAtEffectSpriteX_Bank3F

Jump_03F_402B::
    ld hl, wLoadSlot
    dec [hl]
    ld a, [hl]
    or a, a
    ret z
    ld hl, wBattleArg0
    inc [hl]
    ld a, [hl]
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, Jump_03F_4045
    farcall SetEffectSpriteXForTargets
    call DrawEffectSpriteAtEffectSpriteX_Bank3F

Jump_03F_4045::
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
; 2 call sites from 1 routine (e.g. DrawEffectSpriteForEffectTileOffsetRange_Sub02)
; reads: wEffectSpriteX, wEffectTileOffset, wEffectSpriteAttrXor
; points at: hSpriteOriginX
DrawEffectSpriteAtEffectSpriteX_Bank3F::
Func_03F_405B:: ; address name
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
    ld de, Data_03F_407E
    call BuildOamFromSpriteTable_Bank3F
    ret

; E-0147 (C1: the caller of BuildOamFromSpriteTable_Bank3F passes DE = $3F:407E; the builder takes the word at DE + 2 * hSpriteSetIndex as the set and the word at set + 2 * hSpriteSubIndex as the frame; 32 words, up to the next code or data).
; record: meta-sprite set
MetaSprites3F_407ETable::
Data_03F_407E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw MetaSprites3F_407ESet00 ; id 0
    dw MetaSprites3F_407ESet00 ; id 1
    dw MetaSprites3F_407ESet00 ; id 2
    dw MetaSprites3F_407ESet00 ; id 3
    dw MetaSprites3F_407ESet00 ; id 4
    dw MetaSprites3F_407ESet00 ; id 5
    dw MetaSprites3F_407ESet00 ; id 6
    dw MetaSprites3F_407ESet00 ; id 7
    dw MetaSprites3F_407ESet00 ; id 8
    dw MetaSprites3F_407ESet00 ; id 9
    dw MetaSprites3F_407ESet00 ; id 10
    dw MetaSprites3F_407ESet00 ; id 11
    dw MetaSprites3F_407ESet00 ; id 12
    dw MetaSprites3F_407ESet00 ; id 13
    dw MetaSprites3F_407ESet00 ; id 14
    dw MetaSprites3F_407ESet0F ; id 15
    dw MetaSprites3F_407ESet10 ; id 16
    dw MetaSprites3F_407ESet11 ; id 17
    dw MetaSprites3F_407ESet12 ; id 18
    dw MetaSprites3F_407ESet13 ; id 19
    dw MetaSprites3F_407ESet14 ; id 20
    dw MetaSprites3F_407ESet15 ; id 21
    dw MetaSprites3F_407ESet16 ; id 22
    dw MetaSprites3F_407ESet17 ; id 23
    dw MetaSprites3F_407ESet18 ; id 24
    dw MetaSprites3F_407ESet19 ; id 25
    dw MetaSprites3F_407ESet1A ; id 26
    dw MetaSprites3F_407ESet1B ; id 27
    dw MetaSprites3F_407ESet1C ; id 28
    dw MetaSprites3F_407ESet1D ; id 29
    dw MetaSprites3F_407ESet1E ; id 30
    dw MetaSprites3F_407ESet1F ; id 31

; DE = two-level table; entries are chosen by hSpriteSetIndex and hSpriteSubIndex; writes 4-byte OAM entries at $C000 + 4 * hOamNextEntry (Y = hSpriteOriginY + b + $10, X = hSpriteOriginX + b + 8, tile += hSpriteTileOffset, flags ^= hSpriteAttrXor) until a $80 byte or hOamNextEntry reaches $28 (40 entries) (the same 81 bytes appear in 5 banks)
; 1 call site from 1 routine (e.g. DrawEffectSpriteAtEffectSpriteX_Bank3F)
; reads: hOamNextEntry, hSpriteSetIndex, hSpriteSubIndex, hSpriteOriginY, hSpriteOriginX, hSpriteTileOffset, hSpriteAttrXor
; writes: hOamNextEntry
BuildOamFromSpriteTable_Bank3F::
Func_03F_40BE:: ; address name
    ldh a, [hOamNextEntry]
    cp a, $28
    jr nc, Jump_03F_410E
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

Jump_03F_40E1::
    ld a, [de]
    inc de
    cp a, $80
    jr z, Jump_03F_410E
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
    jr c, Jump_03F_40E1

Jump_03F_410E::
    ret

; E-0147 (derived: meta-sprite set 0 of MetaSprites3F_407ETable: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3F_407ESet00::
Data_03F_410F:: ; heuristic: meta-sprite set; C0
    dw MetaSprites3F_407ESet00Frame0 ; entry 0
    dw MetaSprites3F_407ESet00Frame1 ; entry 1
    dw MetaSprites3F_407ESet00Frame2 ; entry 2
    dw MetaSprites3F_407ESet00Frame3 ; entry 3
    dw MetaSprites3F_407ESet00Frame4 ; entry 4
    dw MetaSprites3F_407ESet00Frame5 ; entry 5
    dw MetaSprites3F_407ESet00Frame6 ; entry 6
    dw MetaSprites3F_407ESet00Frame7 ; entry 7
    dw MetaSprites3F_407ESet00Frame8 ; entry 8
    dw MetaSprites3F_407ESet00Frame9 ; entry 9
    dw MetaSprites3F_407ESet00Frame10 ; entry 10
    dw MetaSprites3F_407ESet00Frame11 ; entry 11
    dw MetaSprites3F_407ESet00Frame12 ; entry 12
    dw MetaSprites3F_407ESet00Frame13 ; entry 13
    dw MetaSprites3F_407ESet00Frame13 ; entry 14
    dw MetaSprites3F_407ESet00Frame13 ; entry 15
    dw MetaSprites3F_407ESet00Frame13 ; entry 16
    dw MetaSprites3F_407ESet00Frame13 ; entry 17
    dw MetaSprites3F_407ESet00Frame13 ; entry 18
    dw MetaSprites3F_407ESet00Frame13 ; entry 19
    dw MetaSprites3F_407ESet00Frame13 ; entry 20
    dw MetaSprites3F_407ESet00Frame13 ; entry 21
    dw MetaSprites3F_407ESet00Frame13 ; entry 22
    dw MetaSprites3F_407ESet00Frame13 ; entry 23
    dw MetaSprites3F_407ESet00Frame13 ; entry 24
    dw MetaSprites3F_407ESet00Frame13 ; entry 25
    dw MetaSprites3F_407ESet00Frame13 ; entry 26
    dw MetaSprites3F_407ESet00Frame13 ; entry 27
    dw MetaSprites3F_407ESet00Frame13 ; entry 28
    dw MetaSprites3F_407ESet00Frame13 ; entry 29
    dw MetaSprites3F_407ESet00Frame13 ; entry 30
    dw MetaSprites3F_407ESet00Frame13 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3F_407ESet00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet00Frame0::
Data_03F_414F:: ; heuristic: meta-sprite frame; C0
    db $D0, $D0, $03, $00 ; entry 0
    db $D8, $B8, $0F, $00 ; entry 1
    db $E3, $C1, $0F, $00 ; entry 2
    db $E8, $B9, $03, $00 ; entry 3
    db $D8, $D9, $03, $00 ; entry 4
    db $D4, $C8, $03, $00 ; entry 5
    db $F4, $D4, $03, $40 ; entry 6
    db $F5, $C2, $03, $40 ; entry 7
    db $D0, $B0, $12, $00 ; entry 8
    db $D0, $C0, $12, $00 ; entry 9
    db $E0, $B4, $12, $00 ; entry 10
    db $E8, $F8, $05, $20 ; entry 11
    db $F0, $E8, $05, $20 ; entry 12
    db $D8, $E8, $04, $00 ; entry 13
    db $E0, $D0, $05, $00 ; entry 14
    db $E8, $C9, $05, $00 ; entry 15
    db $E8, $D8, $07, $20 ; entry 16
    db $E0, $F0, $07, $20 ; entry 17
    db $F5, $28, $03, $60 ; entry 18
    db $ED, $40, $0F, $60 ; entry 19
    db $E2, $37, $0F, $60 ; entry 20
    db $DD, $3F, $03, $60 ; entry 21
    db $ED, $1F, $03, $60 ; entry 22
    db $F1, $30, $03, $60 ; entry 23
    db $D1, $24, $03, $20 ; entry 24
    db $D0, $36, $03, $20 ; entry 25
    db $F5, $48, $12, $60 ; entry 26
    db $F5, $38, $12, $60 ; entry 27
    db $E5, $44, $12, $60 ; entry 28
    db $DD, $00, $05, $40 ; entry 29
    db $D5, $10, $05, $40 ; entry 30
    db $ED, $10, $04, $60 ; entry 31
    db $E5, $28, $05, $60 ; entry 32
    db $DD, $2F, $05, $60 ; entry 33
    db $DD, $20, $07, $40 ; entry 34
    db $E5, $08, $07, $40 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3F_407ESet00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet00Frame1::
Data_03F_41E0:: ; heuristic: meta-sprite frame; C0
    db $E0, $BC, $0F, $00 ; entry 0
    db $D8, $C4, $12, $00 ; entry 1
    db $E0, $CC, $03, $00 ; entry 2
    db $D3, $D4, $03, $00 ; entry 3
    db $F8, $C6, $03, $40 ; entry 4
    db $F8, $F2, $05, $20 ; entry 5
    db $E8, $FC, $08, $60 ; entry 6
    db $E4, $F4, $09, $20 ; entry 7
    db $F0, $E9, $05, $40 ; entry 8
    db $DC, $B0, $13, $00 ; entry 9
    db $E8, $B8, $13, $00 ; entry 10
    db $F8, $E0, $02, $00 ; entry 11
    db $EB, $C8, $10, $00 ; entry 12
    db $F0, $BD, $01, $00 ; entry 13
    db $E0, $E9, $07, $00 ; entry 14
    db $DD, $DC, $00, $00 ; entry 15
    db $E7, $D5, $03, $00 ; entry 16
    db $F0, $D8, $01, $00 ; entry 17
    db $E8, $3C, $0F, $60 ; entry 18
    db $F0, $34, $12, $60 ; entry 19
    db $E8, $2C, $03, $60 ; entry 20
    db $F5, $24, $03, $60 ; entry 21
    db $D0, $32, $03, $20 ; entry 22
    db $D0, $06, $05, $40 ; entry 23
    db $E0, $FC, $08, $00 ; entry 24
    db $E4, $04, $09, $40 ; entry 25
    db $D8, $0F, $05, $20 ; entry 26
    db $EC, $48, $13, $60 ; entry 27
    db $E0, $40, $13, $60 ; entry 28
    db $D0, $18, $02, $60 ; entry 29
    db $DD, $30, $10, $60 ; entry 30
    db $D8, $3B, $01, $60 ; entry 31
    db $E8, $0F, $07, $60 ; entry 32
    db $EB, $1C, $00, $60 ; entry 33
    db $E1, $23, $03, $60 ; entry 34
    db $D8, $20, $01, $60 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3F_407ESet00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet00Frame2::
Data_03F_4271:: ; heuristic: meta-sprite frame; C0
    db $F3, $CD, $10, $00 ; entry 0
    db $F8, $C4, $01, $00 ; entry 1
    db $E8, $D1, $03, $00 ; entry 2
    db $F0, $DA, $03, $00 ; entry 3
    db $E8, $FC, $06, $60 ; entry 4
    db $F0, $F8, $08, $00 ; entry 5
    db $F8, $F4, $07, $00 ; entry 6
    db $E4, $F4, $07, $00 ; entry 7
    db $F8, $E6, $03, $40 ; entry 8
    db $EC, $F0, $05, $40 ; entry 9
    db $E8, $E0, $02, $00 ; entry 10
    db $E4, $E8, $07, $00 ; entry 11
    db $F0, $B7, $10, $00 ; entry 12
    db $D0, $B0, $12, $00 ; entry 13
    db $D8, $E0, $0F, $00 ; entry 14
    db $E8, $C1, $10, $00 ; entry 15
    db $E0, $CE, $01, $00 ; entry 16
    db $F8, $D5, $11, $00 ; entry 17
    db $D5, $2B, $10, $60 ; entry 18
    db $D0, $34, $01, $60 ; entry 19
    db $E0, $27, $03, $60 ; entry 20
    db $D8, $1E, $03, $60 ; entry 21
    db $E0, $FC, $06, $00 ; entry 22
    db $D8, $00, $08, $60 ; entry 23
    db $D0, $04, $07, $60 ; entry 24
    db $E4, $04, $07, $60 ; entry 25
    db $D0, $12, $03, $20 ; entry 26
    db $DC, $08, $05, $20 ; entry 27
    db $E0, $18, $02, $60 ; entry 28
    db $E4, $10, $07, $60 ; entry 29
    db $D8, $41, $10, $60 ; entry 30
    db $F8, $48, $12, $60 ; entry 31
    db $F0, $18, $0F, $60 ; entry 32
    db $E0, $37, $10, $60 ; entry 33
    db $E8, $2A, $01, $60 ; entry 34
    db $D0, $23, $11, $60 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3F_407ESet00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet00Frame3::
Data_03F_4302:: ; heuristic: meta-sprite frame; C0
    db $E8, $F5, $07, $00 ; entry 0
    db $F8, $DA, $01, $00 ; entry 1
    db $F8, $CB, $10, $00 ; entry 2
    db $E8, $FD, $0A, $60 ; entry 3
    db $F0, $05, $08, $40 ; entry 4
    db $F0, $FD, $06, $20 ; entry 5
    db $E8, $ED, $09, $00 ; entry 6
    db $E8, $D9, $02, $00 ; entry 7
    db $F8, $F8, $05, $40 ; entry 8
    db $F8, $02, $05, $40 ; entry 9
    db $F0, $F0, $06, $20 ; entry 10
    db $F8, $EB, $03, $40 ; entry 11
    db $F3, $E3, $0F, $00 ; entry 12
    db $E8, $E1, $07, $00 ; entry 13
    db $E0, $E7, $00, $00 ; entry 14
    db $E0, $D6, $03, $00 ; entry 15
    db $F0, $D5, $03, $00 ; entry 16
    db $E0, $C9, $0F, $00 ; entry 17
    db $E0, $03, $07, $60 ; entry 18
    db $D0, $1E, $01, $60 ; entry 19
    db $D0, $2D, $10, $60 ; entry 20
    db $E0, $FB, $0A, $00 ; entry 21
    db $D8, $F3, $08, $20 ; entry 22
    db $D8, $FB, $06, $40 ; entry 23
    db $E0, $0B, $09, $60 ; entry 24
    db $E0, $1F, $02, $60 ; entry 25
    db $D0, $00, $05, $20 ; entry 26
    db $D0, $F6, $05, $20 ; entry 27
    db $D8, $08, $06, $40 ; entry 28
    db $D0, $0D, $03, $20 ; entry 29
    db $D5, $15, $0F, $60 ; entry 30
    db $E0, $17, $07, $60 ; entry 31
    db $D8, $23, $03, $60 ; entry 32
    db $E8, $11, $00, $60 ; entry 33
    db $E8, $22, $03, $60 ; entry 34
    db $E8, $2F, $0F, $60 ; entry 35
    db $F0, $1A, $06, $00 ; entry 36
    db $F0, $38, $12, $00 ; entry 37
    db $D8, $DE, $06, $60 ; entry 38
    db $D8, $C0, $12, $60 ; entry 39
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3F_407ESet00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet00Frame4::
Data_03F_43A3:: ; heuristic: meta-sprite frame; C0
    db $D8, $B8, $0F, $00 ; entry 0
    db $E3, $C1, $0F, $00 ; entry 1
    db $D4, $C8, $03, $00 ; entry 2
    db $D0, $B0, $12, $00 ; entry 3
    db $D0, $C0, $12, $00 ; entry 4
    db $E0, $B4, $12, $00 ; entry 5
    db $F0, $40, $0F, $60 ; entry 6
    db $E5, $37, $0F, $60 ; entry 7
    db $F4, $30, $03, $60 ; entry 8
    db $F8, $48, $12, $60 ; entry 9
    db $F8, $38, $12, $60 ; entry 10
    db $E8, $44, $12, $60 ; entry 11
    db $F8, $FB, $03, $40 ; entry 12
    db $F8, $F3, $0F, $00 ; entry 13
    db $F0, $F3, $07, $00 ; entry 14
    db $E8, $03, $05, $00 ; entry 15
    db $E8, $FB, $08, $40 ; entry 16
    db $F8, $05, $06, $20 ; entry 17
    db $F0, $FB, $09, $00 ; entry 18
    db $E8, $EB, $02, $00 ; entry 19
    db $E8, $0B, $00, $60 ; entry 20
    db $E8, $F3, $09, $20 ; entry 21
    db $F0, $03, $05, $20 ; entry 22
    db $F0, $0B, $08, $20 ; entry 23
    db $E0, $ED, $00, $00 ; entry 24
    db $D0, $FD, $03, $20 ; entry 25
    db $D0, $05, $0F, $60 ; entry 26
    db $D8, $05, $07, $60 ; entry 27
    db $E0, $F5, $05, $60 ; entry 28
    db $E0, $FD, $08, $20 ; entry 29
    db $D0, $F3, $06, $40 ; entry 30
    db $D8, $FD, $09, $60 ; entry 31
    db $E0, $05, $09, $40 ; entry 32
    db $D8, $F5, $05, $40 ; entry 33
    db $D8, $ED, $08, $40 ; entry 34
    db $E0, $0D, $02, $60 ; entry 35
    db $D0, $E8, $0A, $00 ; entry 36
    db $F8, $10, $0A, $60 ; entry 37
    db $F8, $1A, $06, $60 ; entry 38
    db $D0, $DE, $06, $00 ; entry 39
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3F_407ESet00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet00Frame5::
Data_03F_4444:: ; heuristic: meta-sprite frame; C0
    db $DF, $FD, $08, $00 ; entry 0
    db $DF, $06, $07, $60 ; entry 1
    db $DF, $F4, $05, $00 ; entry 2
    db $DF, $EB, $03, $00 ; entry 3
    db $DF, $0F, $02, $00 ; entry 4
    db $D6, $F4, $05, $20 ; entry 5
    db $D6, $FD, $07, $00 ; entry 6
    db $D6, $06, $09, $40 ; entry 7
    db $F2, $04, $05, $40 ; entry 8
    db $E9, $FB, $08, $60 ; entry 9
    db $E9, $F2, $07, $00 ; entry 10
    db $E9, $04, $05, $60 ; entry 11
    db $E9, $0D, $03, $60 ; entry 12
    db $F2, $FB, $07, $60 ; entry 13
    db $F2, $F2, $09, $20 ; entry 14
    db $E9, $E9, $02, $60 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3F_407ESet00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet00Frame6::
Data_03F_4485:: ; heuristic: meta-sprite frame; C0
    db $D0, $D0, $0B, $20 ; entry 0
    db $D8, $CE, $0C, $20 ; entry 1
    db $E0, $CC, $0B, $20 ; entry 2
    db $E8, $CC, $0C, $20 ; entry 3
    db $F0, $CE, $0B, $20 ; entry 4
    db $F8, $D0, $0C, $20 ; entry 5
    db $D0, $B0, $0B, $20 ; entry 6
    db $D8, $B0, $0C, $20 ; entry 7
    db $E0, $B0, $0B, $20 ; entry 8
    db $E8, $B0, $0C, $20 ; entry 9
    db $F0, $B0, $0B, $20 ; entry 10
    db $F8, $B0, $0C, $20 ; entry 11
    db $D0, $C0, $0C, $20 ; entry 12
    db $D8, $BE, $0B, $20 ; entry 13
    db $E0, $BC, $0C, $20 ; entry 14
    db $E8, $BC, $0B, $20 ; entry 15
    db $F0, $BE, $0C, $20 ; entry 16
    db $F8, $C0, $0B, $20 ; entry 17
    db $D0, $28, $0B, $00 ; entry 18
    db $D8, $2A, $0C, $00 ; entry 19
    db $E0, $2C, $0B, $00 ; entry 20
    db $E8, $2C, $0C, $00 ; entry 21
    db $F0, $2A, $0B, $00 ; entry 22
    db $F8, $28, $0C, $00 ; entry 23
    db $D0, $48, $0B, $00 ; entry 24
    db $D8, $48, $0C, $00 ; entry 25
    db $E0, $48, $0B, $00 ; entry 26
    db $E8, $48, $0C, $00 ; entry 27
    db $F0, $48, $0B, $00 ; entry 28
    db $F8, $48, $0C, $00 ; entry 29
    db $D0, $38, $0C, $00 ; entry 30
    db $D8, $3A, $0B, $00 ; entry 31
    db $E0, $3C, $0C, $00 ; entry 32
    db $E8, $3C, $0B, $00 ; entry 33
    db $F0, $3A, $0C, $00 ; entry 34
    db $F8, $38, $0B, $00 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3F_407ESet00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet00Frame7::
Data_03F_4516:: ; heuristic: meta-sprite frame; C0
    db $D0, $D8, $0C, $20 ; entry 0
    db $D8, $D6, $0B, $20 ; entry 1
    db $E0, $D4, $0C, $20 ; entry 2
    db $E8, $D4, $0B, $20 ; entry 3
    db $F0, $D6, $0C, $20 ; entry 4
    db $F8, $D8, $0B, $20 ; entry 5
    db $D0, $C8, $0B, $20 ; entry 6
    db $D8, $C6, $0C, $20 ; entry 7
    db $E0, $C4, $0B, $20 ; entry 8
    db $E8, $C4, $0C, $20 ; entry 9
    db $F0, $C6, $0B, $20 ; entry 10
    db $F8, $C8, $0C, $20 ; entry 11
    db $D0, $B8, $0C, $20 ; entry 12
    db $D8, $B6, $0B, $20 ; entry 13
    db $E0, $B4, $0C, $20 ; entry 14
    db $E8, $B4, $0B, $20 ; entry 15
    db $F0, $B6, $0C, $20 ; entry 16
    db $F8, $B8, $0B, $20 ; entry 17
    db $D0, $20, $0C, $00 ; entry 18
    db $D8, $22, $0B, $00 ; entry 19
    db $E0, $24, $0C, $00 ; entry 20
    db $E8, $24, $0B, $00 ; entry 21
    db $F0, $22, $0C, $00 ; entry 22
    db $F8, $20, $0B, $00 ; entry 23
    db $D0, $30, $0B, $00 ; entry 24
    db $D8, $32, $0C, $00 ; entry 25
    db $E0, $34, $0B, $00 ; entry 26
    db $E8, $34, $0C, $00 ; entry 27
    db $F0, $32, $0B, $00 ; entry 28
    db $F8, $30, $0C, $00 ; entry 29
    db $D0, $40, $0C, $00 ; entry 30
    db $D8, $42, $0B, $00 ; entry 31
    db $E0, $44, $0C, $00 ; entry 32
    db $E8, $44, $0B, $00 ; entry 33
    db $F0, $42, $0C, $00 ; entry 34
    db $F8, $40, $0B, $00 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites3F_407ESet00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet00Frame8::
Data_03F_45A7:: ; heuristic: meta-sprite frame; C0
    db $D0, $E0, $0B, $20 ; entry 0
    db $D8, $DE, $0C, $20 ; entry 1
    db $E0, $DC, $0B, $20 ; entry 2
    db $E8, $DC, $0C, $20 ; entry 3
    db $F0, $DE, $0B, $20 ; entry 4
    db $F8, $E0, $0C, $20 ; entry 5
    db $D0, $D0, $0C, $20 ; entry 6
    db $D8, $CE, $0B, $20 ; entry 7
    db $E0, $CC, $0C, $20 ; entry 8
    db $E8, $CC, $0B, $20 ; entry 9
    db $F0, $CE, $0C, $20 ; entry 10
    db $F8, $D0, $0B, $20 ; entry 11
    db $D0, $C0, $0B, $20 ; entry 12
    db $D8, $BE, $0C, $20 ; entry 13
    db $E0, $BC, $0B, $20 ; entry 14
    db $E8, $BC, $0C, $20 ; entry 15
    db $F0, $BE, $0B, $20 ; entry 16
    db $F8, $C0, $0C, $20 ; entry 17
    db $D0, $38, $0B, $00 ; entry 18
    db $D8, $3A, $0C, $00 ; entry 19
    db $E0, $3C, $0B, $00 ; entry 20
    db $E8, $3C, $0C, $00 ; entry 21
    db $F0, $3A, $0B, $00 ; entry 22
    db $F8, $38, $0C, $00 ; entry 23
    db $D0, $18, $0B, $00 ; entry 24
    db $D8, $1A, $0C, $00 ; entry 25
    db $E0, $1C, $0B, $00 ; entry 26
    db $E8, $1C, $0C, $00 ; entry 27
    db $F0, $1A, $0B, $00 ; entry 28
    db $F8, $18, $0C, $00 ; entry 29
    db $D0, $28, $0C, $00 ; entry 30
    db $D8, $2A, $0B, $00 ; entry 31
    db $E0, $2C, $0C, $00 ; entry 32
    db $E8, $2C, $0B, $00 ; entry 33
    db $F0, $2A, $0C, $00 ; entry 34
    db $F8, $28, $0B, $00 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites3F_407ESet00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet00Frame9::
Data_03F_4638:: ; heuristic: meta-sprite frame; C0
    db $D0, $E8, $0C, $20 ; entry 0
    db $D8, $E6, $0B, $20 ; entry 1
    db $E0, $E4, $0C, $20 ; entry 2
    db $E8, $E4, $0B, $20 ; entry 3
    db $F0, $E6, $0C, $20 ; entry 4
    db $F8, $E8, $0B, $20 ; entry 5
    db $D0, $D8, $0B, $20 ; entry 6
    db $D8, $D6, $0C, $20 ; entry 7
    db $E0, $D4, $0B, $20 ; entry 8
    db $E8, $D4, $0C, $20 ; entry 9
    db $F0, $D6, $0B, $20 ; entry 10
    db $F8, $D8, $0C, $20 ; entry 11
    db $D0, $C8, $0C, $20 ; entry 12
    db $D8, $C6, $0B, $20 ; entry 13
    db $E0, $C4, $0C, $20 ; entry 14
    db $E8, $C4, $0B, $20 ; entry 15
    db $F0, $C6, $0C, $20 ; entry 16
    db $F8, $C8, $0B, $20 ; entry 17
    db $D0, $30, $0C, $00 ; entry 18
    db $D8, $32, $0B, $00 ; entry 19
    db $E0, $34, $0C, $00 ; entry 20
    db $E8, $34, $0B, $00 ; entry 21
    db $F0, $32, $0C, $00 ; entry 22
    db $F8, $30, $0B, $00 ; entry 23
    db $D0, $20, $0B, $00 ; entry 24
    db $D8, $22, $0C, $00 ; entry 25
    db $E0, $24, $0B, $00 ; entry 26
    db $E8, $24, $0C, $00 ; entry 27
    db $F0, $22, $0B, $00 ; entry 28
    db $F8, $20, $0C, $00 ; entry 29
    db $D0, $10, $0C, $00 ; entry 30
    db $D8, $12, $0B, $00 ; entry 31
    db $E0, $14, $0C, $00 ; entry 32
    db $E8, $14, $0B, $00 ; entry 33
    db $F0, $12, $0C, $00 ; entry 34
    db $F8, $10, $0B, $00 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 10 of MetaSprites3F_407ESet00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet00Frame10::
Data_03F_46C9:: ; heuristic: meta-sprite frame; C0
    db $D0, $F0, $0B, $20 ; entry 0
    db $D8, $EC, $0C, $20 ; entry 1
    db $E0, $E8, $0B, $20 ; entry 2
    db $E8, $E8, $0C, $20 ; entry 3
    db $F0, $EC, $0B, $20 ; entry 4
    db $F8, $F0, $0C, $20 ; entry 5
    db $D0, $E0, $0C, $20 ; entry 6
    db $D8, $DC, $0B, $20 ; entry 7
    db $E0, $D8, $0C, $20 ; entry 8
    db $E8, $D8, $0B, $20 ; entry 9
    db $F0, $DC, $0C, $20 ; entry 10
    db $F8, $E0, $0B, $20 ; entry 11
    db $D0, $D0, $0B, $20 ; entry 12
    db $D8, $CC, $0C, $20 ; entry 13
    db $E0, $C8, $0B, $20 ; entry 14
    db $E8, $C8, $0C, $20 ; entry 15
    db $F0, $CC, $0B, $20 ; entry 16
    db $F8, $D0, $0C, $20 ; entry 17
    db $D0, $28, $0B, $00 ; entry 18
    db $D8, $2C, $0C, $00 ; entry 19
    db $E0, $30, $0B, $00 ; entry 20
    db $E8, $30, $0C, $00 ; entry 21
    db $F0, $2C, $0B, $00 ; entry 22
    db $F8, $28, $0C, $00 ; entry 23
    db $D0, $18, $0C, $00 ; entry 24
    db $D8, $1C, $0B, $00 ; entry 25
    db $E0, $20, $0C, $00 ; entry 26
    db $E8, $20, $0B, $00 ; entry 27
    db $F0, $1C, $0C, $00 ; entry 28
    db $F8, $18, $0B, $00 ; entry 29
    db $D0, $08, $0B, $00 ; entry 30
    db $D8, $0C, $0C, $00 ; entry 31
    db $E0, $10, $0B, $00 ; entry 32
    db $E8, $10, $0C, $00 ; entry 33
    db $F0, $0C, $0B, $00 ; entry 34
    db $F8, $08, $0C, $00 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 11 of MetaSprites3F_407ESet00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet00Frame11::
Data_03F_475A:: ; heuristic: meta-sprite frame; C0
    db $D0, $F8, $0C, $20 ; entry 0
    db $D8, $F8, $0B, $20 ; entry 1
    db $E0, $F8, $0C, $20 ; entry 2
    db $E8, $F8, $0B, $20 ; entry 3
    db $F0, $F8, $0C, $20 ; entry 4
    db $F8, $F8, $0B, $20 ; entry 5
    db $D0, $E8, $0B, $20 ; entry 6
    db $D8, $E4, $0C, $20 ; entry 7
    db $E0, $E0, $0B, $20 ; entry 8
    db $E8, $E0, $0C, $20 ; entry 9
    db $F0, $E4, $0B, $20 ; entry 10
    db $F8, $E8, $0C, $20 ; entry 11
    db $D0, $D8, $0C, $20 ; entry 12
    db $D8, $D4, $0B, $20 ; entry 13
    db $E0, $D0, $0C, $20 ; entry 14
    db $E8, $D0, $0B, $20 ; entry 15
    db $F0, $D4, $0C, $20 ; entry 16
    db $F8, $D8, $0B, $20 ; entry 17
    db $D0, $20, $0C, $00 ; entry 18
    db $D8, $24, $0B, $00 ; entry 19
    db $E0, $28, $0C, $00 ; entry 20
    db $E8, $28, $0B, $00 ; entry 21
    db $F0, $24, $0C, $00 ; entry 22
    db $F8, $20, $0B, $00 ; entry 23
    db $D0, $10, $0B, $00 ; entry 24
    db $D8, $14, $0C, $00 ; entry 25
    db $E0, $18, $0B, $00 ; entry 26
    db $E8, $18, $0C, $00 ; entry 27
    db $F0, $14, $0B, $00 ; entry 28
    db $F8, $10, $0C, $00 ; entry 29
    db $D0, $00, $0C, $00 ; entry 30
    db $D8, $00, $0B, $00 ; entry 31
    db $E0, $00, $0C, $00 ; entry 32
    db $E8, $00, $0B, $00 ; entry 33
    db $F0, $00, $0C, $00 ; entry 34
    db $F8, $00, $0B, $00 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 12 of MetaSprites3F_407ESet00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet00Frame12::
Data_03F_47EB:: ; heuristic: meta-sprite frame; C0
    db $D0, $EE, $0B, $20 ; entry 0
    db $D8, $EA, $0C, $20 ; entry 1
    db $E0, $E6, $0B, $20 ; entry 2
    db $E8, $E6, $0C, $20 ; entry 3
    db $F0, $EA, $0B, $20 ; entry 4
    db $F8, $EE, $0C, $20 ; entry 5
    db $D0, $0A, $0B, $00 ; entry 6
    db $D8, $0E, $0C, $00 ; entry 7
    db $E0, $12, $0B, $00 ; entry 8
    db $E8, $12, $0C, $00 ; entry 9
    db $F0, $0E, $0B, $00 ; entry 10
    db $F8, $0A, $0C, $00 ; entry 11
    db $D0, $FC, $0D, $00 ; entry 12
    db $D8, $FC, $0E, $00 ; entry 13
    db $E0, $FC, $0D, $00 ; entry 14
    db $E8, $FC, $0E, $00 ; entry 15
    db $F0, $FC, $0D, $00 ; entry 16
    db $F8, $FC, $0E, $00 ; entry 17
    db $80 ; end

; E-0147 (derived: frame 13 of MetaSprites3F_407ESet00; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet00Frame13::
    db $80 ; end

; E-0147 (derived: meta-sprite set 15 of MetaSprites3F_407ETable: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3F_407ESet0F::
Data_03F_4835:: ; heuristic: meta-sprite set; C0
    dw MetaSprites3F_407ESet0FFrame0 ; entry 0
    dw MetaSprites3F_407ESet0FFrame1 ; entry 1
    dw MetaSprites3F_407ESet0FFrame2 ; entry 2
    dw MetaSprites3F_407ESet0FFrame3 ; entry 3
    dw MetaSprites3F_407ESet0FFrame4 ; entry 4
    dw MetaSprites3F_407ESet0FFrame5 ; entry 5
    dw MetaSprites3F_407ESet0FFrame6 ; entry 6
    dw MetaSprites3F_407ESet0FFrame7 ; entry 7
    dw MetaSprites3F_407ESet0FFrame8 ; entry 8
    dw MetaSprites3F_407ESet0FFrame8 ; entry 9
    dw MetaSprites3F_407ESet0FFrame8 ; entry 10
    dw MetaSprites3F_407ESet0FFrame8 ; entry 11
    dw MetaSprites3F_407ESet0FFrame8 ; entry 12
    dw MetaSprites3F_407ESet0FFrame8 ; entry 13
    dw MetaSprites3F_407ESet0FFrame8 ; entry 14
    dw MetaSprites3F_407ESet0FFrame8 ; entry 15
    dw MetaSprites3F_407ESet0FFrame8 ; entry 16
    dw MetaSprites3F_407ESet0FFrame8 ; entry 17
    dw MetaSprites3F_407ESet0FFrame8 ; entry 18
    dw MetaSprites3F_407ESet0FFrame8 ; entry 19
    dw MetaSprites3F_407ESet0FFrame8 ; entry 20
    dw MetaSprites3F_407ESet0FFrame8 ; entry 21
    dw MetaSprites3F_407ESet0FFrame8 ; entry 22
    dw MetaSprites3F_407ESet0FFrame8 ; entry 23
    dw MetaSprites3F_407ESet0FFrame8 ; entry 24
    dw MetaSprites3F_407ESet0FFrame8 ; entry 25
    dw MetaSprites3F_407ESet0FFrame8 ; entry 26
    dw MetaSprites3F_407ESet0FFrame8 ; entry 27
    dw MetaSprites3F_407ESet0FFrame8 ; entry 28
    dw MetaSprites3F_407ESet0FFrame8 ; entry 29
    dw MetaSprites3F_407ESet0FFrame8 ; entry 30
    dw MetaSprites3F_407ESet0FFrame8 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3F_407ESet0F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet0FFrame0::
Data_03F_4875:: ; heuristic: meta-sprite frame; C0
    db $D0, $FC, $00, $00 ; entry 0
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3F_407ESet0F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet0FFrame1::
Data_03F_487A:: ; heuristic: meta-sprite frame; C0
    db $D0, $FC, $03, $00 ; entry 0
    db $D8, $FC, $02, $00 ; entry 1
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3F_407ESet0F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet0FFrame2::
Data_03F_4883:: ; heuristic: meta-sprite frame; C0
    db $D0, $F8, $0C, $00 ; entry 0
    db $D0, $00, $0D, $00 ; entry 1
    db $D7, $01, $05, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3F_407ESet0F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet0FFrame3::
Data_03F_4890:: ; heuristic: meta-sprite frame; C0
    db $D0, $00, $16, $20 ; entry 0
    db $D0, $F8, $17, $20 ; entry 1
    db $D8, $00, $1C, $00 ; entry 2
    db $D8, $08, $1D, $00 ; entry 3
    db $E0, $FA, $18, $20 ; entry 4
    db $E0, $F2, $19, $20 ; entry 5
    db $E8, $F6, $05, $00 ; entry 6
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3F_407ESet0F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet0FFrame4::
Data_03F_48AD:: ; heuristic: meta-sprite frame; C0
    db $D0, $F8, $06, $00 ; entry 0
    db $D0, $00, $07, $00 ; entry 1
    db $D8, $F6, $08, $00 ; entry 2
    db $D8, $FE, $09, $00 ; entry 3
    db $E0, $F9, $0A, $00 ; entry 4
    db $E0, $01, $0B, $00 ; entry 5
    db $E8, $F4, $0C, $00 ; entry 6
    db $E8, $FC, $0D, $00 ; entry 7
    db $F0, $F4, $0E, $00 ; entry 8
    db $F0, $FC, $0F, $00 ; entry 9
    db $F8, $F9, $10, $00 ; entry 10
    db $F8, $01, $11, $00 ; entry 11
    db $F8, $04, $1E, $00 ; entry 12
    db $F8, $F8, $1E, $20 ; entry 13
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3F_407ESet0F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet0FFrame5::
Data_03F_48E6:: ; heuristic: meta-sprite frame; C0
    db $D0, $FA, $12, $00 ; entry 0
    db $D0, $02, $13, $00 ; entry 1
    db $D8, $FD, $14, $00 ; entry 2
    db $D8, $05, $15, $00 ; entry 3
    db $E0, $FD, $16, $00 ; entry 4
    db $E0, $05, $17, $00 ; entry 5
    db $E8, $FD, $18, $00 ; entry 6
    db $E8, $05, $19, $00 ; entry 7
    db $F0, $FD, $1A, $00 ; entry 8
    db $F0, $05, $1B, $00 ; entry 9
    db $F8, $FD, $1C, $00 ; entry 10
    db $F8, $05, $1D, $00 ; entry 11
    db $F8, $06, $1E, $00 ; entry 12
    db $F8, $F5, $1E, $20 ; entry 13
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3F_407ESet0F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet0FFrame6::
Data_03F_491F:: ; heuristic: meta-sprite frame; C0
    db $D8, $0B, $08, $20 ; entry 0
    db $D8, $03, $09, $20 ; entry 1
    db $D0, $01, $18, $00 ; entry 2
    db $D0, $09, $19, $00 ; entry 3
    db $E0, $05, $14, $00 ; entry 4
    db $E0, $0D, $15, $00 ; entry 5
    db $E8, $06, $0C, $00 ; entry 6
    db $E8, $0E, $0D, $00 ; entry 7
    db $F0, $05, $0E, $00 ; entry 8
    db $F0, $0D, $0F, $00 ; entry 9
    db $F8, $04, $16, $00 ; entry 10
    db $F8, $0C, $17, $00 ; entry 11
    db $E8, $03, $0D, $20 ; entry 12
    db $F0, $FE, $0C, $00 ; entry 13
    db $F8, $11, $1E, $00 ; entry 14
    db $F8, $FD, $1E, $20 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3F_407ESet0F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet0FFrame7::
Data_03F_4960:: ; heuristic: meta-sprite frame; C0
    db $D0, $02, $0C, $20 ; entry 0
    db $D0, $FA, $0D, $20 ; entry 1
    db $D8, $F1, $16, $00 ; entry 2
    db $D8, $F9, $17, $00 ; entry 3
    db $E0, $F7, $16, $20 ; entry 4
    db $E0, $EF, $17, $20 ; entry 5
    db $E8, $F7, $18, $20 ; entry 6
    db $E8, $EF, $19, $20 ; entry 7
    db $F0, $F7, $1A, $20 ; entry 8
    db $F0, $EF, $1B, $20 ; entry 9
    db $F8, $F4, $14, $00 ; entry 10
    db $F8, $FC, $15, $00 ; entry 11
    db $E5, $FE, $06, $20 ; entry 12
    db $ED, $01, $05, $20 ; entry 13
    db $F8, $01, $1E, $00 ; entry 14
    db $F8, $ED, $1E, $20 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites3F_407ESet0F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet0FFrame8::
    db $80 ; end

; E-0147 (derived: meta-sprite set 16 of MetaSprites3F_407ETable: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3F_407ESet10::
Data_03F_49A2:: ; heuristic: meta-sprite set; C0
    dw MetaSprites3F_407ESet10Frame0 ; entry 0
    dw MetaSprites3F_407ESet10Frame1 ; entry 1
    dw MetaSprites3F_407ESet10Frame2 ; entry 2
    dw MetaSprites3F_407ESet10Frame3 ; entry 3
    dw MetaSprites3F_407ESet10Frame4 ; entry 4
    dw MetaSprites3F_407ESet10Frame5 ; entry 5
    dw MetaSprites3F_407ESet10Frame6 ; entry 6
    dw MetaSprites3F_407ESet10Frame7 ; entry 7
    dw MetaSprites3F_407ESet10Frame8 ; entry 8
    dw MetaSprites3F_407ESet10Frame9 ; entry 9
    dw MetaSprites3F_407ESet10Frame10 ; entry 10
    dw MetaSprites3F_407ESet10Frame10 ; entry 11
    dw MetaSprites3F_407ESet10Frame10 ; entry 12
    dw MetaSprites3F_407ESet10Frame10 ; entry 13
    dw MetaSprites3F_407ESet10Frame10 ; entry 14
    dw MetaSprites3F_407ESet10Frame10 ; entry 15
    dw MetaSprites3F_407ESet10Frame10 ; entry 16
    dw MetaSprites3F_407ESet10Frame10 ; entry 17
    dw MetaSprites3F_407ESet10Frame10 ; entry 18
    dw MetaSprites3F_407ESet10Frame10 ; entry 19
    dw MetaSprites3F_407ESet10Frame10 ; entry 20
    dw MetaSprites3F_407ESet10Frame10 ; entry 21
    dw MetaSprites3F_407ESet10Frame10 ; entry 22
    dw MetaSprites3F_407ESet10Frame10 ; entry 23
    dw MetaSprites3F_407ESet10Frame10 ; entry 24
    dw MetaSprites3F_407ESet10Frame10 ; entry 25
    dw MetaSprites3F_407ESet10Frame10 ; entry 26
    dw MetaSprites3F_407ESet10Frame10 ; entry 27
    dw MetaSprites3F_407ESet10Frame10 ; entry 28
    dw MetaSprites3F_407ESet10Frame10 ; entry 29
    dw MetaSprites3F_407ESet10Frame10 ; entry 30
    dw MetaSprites3F_407ESet10Frame10 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3F_407ESet10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet10Frame0::
Data_03F_49E2:: ; heuristic: meta-sprite frame; C0
    db $D0, $FC, $00, $00 ; entry 0
    db $D0, $FD, $00, $20 ; entry 1
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3F_407ESet10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet10Frame1::
Data_03F_49EB:: ; heuristic: meta-sprite frame; C0
    db $D0, $F8, $01, $00 ; entry 0
    db $D0, $00, $01, $20 ; entry 1
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3F_407ESet10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet10Frame2::
Data_03F_49F4:: ; heuristic: meta-sprite frame; C0
    db $D0, $FC, $00, $00 ; entry 0
    db $D0, $FD, $00, $20 ; entry 1
    db $D3, $FD, $03, $00 ; entry 2
    db $DB, $FD, $02, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3F_407ESet10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet10Frame3::
Data_03F_4A05:: ; heuristic: meta-sprite frame; C0
    db $D0, $F8, $0C, $00 ; entry 0
    db $D0, $00, $0D, $00 ; entry 1
    db $D7, $01, $05, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3F_407ESet10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet10Frame4::
Data_03F_4A12:: ; heuristic: meta-sprite frame; C0
    db $D0, $00, $16, $20 ; entry 0
    db $D0, $F8, $17, $20 ; entry 1
    db $D8, $00, $18, $20 ; entry 2
    db $D8, $F8, $19, $20 ; entry 3
    db $E0, $FC, $18, $20 ; entry 4
    db $E0, $F4, $19, $20 ; entry 5
    db $E8, $F8, $05, $00 ; entry 6
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3F_407ESet10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet10Frame5::
Data_03F_4A2F:: ; heuristic: meta-sprite frame; C0
    db $D0, $01, $06, $20 ; entry 0
    db $D0, $F9, $07, $20 ; entry 1
    db $D8, $03, $08, $20 ; entry 2
    db $D8, $FB, $09, $20 ; entry 3
    db $E0, $00, $0A, $20 ; entry 4
    db $E0, $F8, $0B, $20 ; entry 5
    db $E8, $05, $0C, $20 ; entry 6
    db $E8, $FD, $0D, $20 ; entry 7
    db $F0, $05, $0E, $20 ; entry 8
    db $F0, $FD, $0F, $20 ; entry 9
    db $F8, $00, $10, $20 ; entry 10
    db $F8, $F8, $11, $20 ; entry 11
    db $F8, $F4, $21, $20 ; entry 12
    db $F8, $02, $21, $00 ; entry 13
    db $D0, $10, $22, $00 ; entry 14
    db $D0, $08, $22, $00 ; entry 15
    db $D8, $0B, $22, $00 ; entry 16
    db $D8, $10, $22, $00 ; entry 17
    db $E0, $10, $22, $00 ; entry 18
    db $E0, $08, $22, $00 ; entry 19
    db $E8, $10, $22, $00 ; entry 20
    db $F0, $10, $22, $00 ; entry 21
    db $F8, $10, $22, $00 ; entry 22
    db $F8, $0A, $22, $00 ; entry 23
    db $D0, $F0, $22, $20 ; entry 24
    db $D8, $F0, $22, $20 ; entry 25
    db $E0, $F0, $22, $20 ; entry 26
    db $E8, $F0, $22, $20 ; entry 27
    db $F0, $F0, $22, $20 ; entry 28
    db $F8, $F0, $22, $20 ; entry 29
    db $D0, $E8, $22, $20 ; entry 30
    db $D8, $E8, $22, $20 ; entry 31
    db $E0, $E8, $22, $20 ; entry 32
    db $E8, $E8, $22, $20 ; entry 33
    db $F0, $E8, $22, $20 ; entry 34
    db $F8, $E8, $22, $20 ; entry 35
    db $E8, $F5, $22, $20 ; entry 36
    db $F0, $F5, $22, $20 ; entry 37
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3F_407ESet10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet10Frame6::
Data_03F_4AC8:: ; heuristic: meta-sprite frame; C0
    db $D0, $02, $0C, $20 ; entry 0
    db $D0, $FA, $0D, $20 ; entry 1
    db $D8, $F1, $16, $00 ; entry 2
    db $D8, $F9, $17, $00 ; entry 3
    db $E0, $F7, $16, $20 ; entry 4
    db $E0, $EF, $17, $20 ; entry 5
    db $E8, $F7, $18, $20 ; entry 6
    db $E8, $EF, $19, $20 ; entry 7
    db $F0, $F7, $1A, $20 ; entry 8
    db $F0, $EF, $1B, $20 ; entry 9
    db $E5, $FE, $06, $20 ; entry 10
    db $ED, $01, $05, $20 ; entry 11
    db $F8, $FC, $1E, $00 ; entry 12
    db $F8, $04, $1F, $00 ; entry 13
    db $F8, $F4, $1E, $20 ; entry 14
    db $F8, $EC, $1F, $20 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3F_407ESet10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet10Frame7::
Data_03F_4B09:: ; heuristic: meta-sprite frame; C0
    db $D8, $0B, $08, $20 ; entry 0
    db $D8, $03, $09, $20 ; entry 1
    db $D0, $01, $18, $00 ; entry 2
    db $D0, $09, $19, $00 ; entry 3
    db $E0, $05, $14, $00 ; entry 4
    db $E0, $0D, $15, $00 ; entry 5
    db $E8, $06, $0C, $00 ; entry 6
    db $E8, $0E, $0D, $00 ; entry 7
    db $F0, $05, $0E, $00 ; entry 8
    db $F0, $0D, $0F, $00 ; entry 9
    db $E8, $03, $0D, $20 ; entry 10
    db $F0, $FE, $0C, $00 ; entry 11
    db $F8, $0C, $20, $00 ; entry 12
    db $F8, $04, $20, $20 ; entry 13
    db $F8, $FC, $21, $20 ; entry 14
    db $D0, $E8, $22, $00 ; entry 15
    db $D8, $E8, $22, $00 ; entry 16
    db $E0, $E8, $22, $00 ; entry 17
    db $E8, $E8, $22, $00 ; entry 18
    db $F0, $E9, $22, $00 ; entry 19
    db $F8, $E9, $22, $00 ; entry 20
    db $D0, $F0, $22, $00 ; entry 21
    db $D8, $F1, $22, $00 ; entry 22
    db $E0, $F2, $22, $00 ; entry 23
    db $E8, $F1, $22, $00 ; entry 24
    db $F0, $F3, $22, $00 ; entry 25
    db $F8, $F3, $22, $00 ; entry 26
    db $D0, $F8, $22, $00 ; entry 27
    db $D8, $FA, $22, $00 ; entry 28
    db $E8, $FA, $22, $00 ; entry 29
    db $E0, $FC, $22, $00 ; entry 30
    db $D0, $10, $22, $20 ; entry 31
    db $F8, $14, $1F, $00 ; entry 32
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites3F_407ESet10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet10Frame8::
Data_03F_4B8E:: ; heuristic: meta-sprite frame; C0
    db $F8, $00, $1F, $00 ; entry 0
    db $D0, $03, $14, $20 ; entry 1
    db $D0, $FB, $15, $20 ; entry 2
    db $D8, $09, $0A, $20 ; entry 3
    db $D8, $01, $0B, $20 ; entry 4
    db $F8, $0F, $1E, $00 ; entry 5
    db $F8, $17, $1F, $00 ; entry 6
    db $F8, $07, $1E, $20 ; entry 7
    db $E0, $08, $16, $40 ; entry 8
    db $E0, $10, $17, $40 ; entry 9
    db $E8, $11, $0C, $20 ; entry 10
    db $E8, $09, $0D, $20 ; entry 11
    db $F0, $10, $0E, $20 ; entry 12
    db $F0, $08, $0F, $20 ; entry 13
    db $E8, $FA, $14, $60 ; entry 14
    db $E8, $F2, $15, $60 ; entry 15
    db $F0, $FA, $10, $20 ; entry 16
    db $F0, $F2, $11, $20 ; entry 17
    db $F8, $F0, $20, $20 ; entry 18
    db $F8, $F8, $20, $00 ; entry 19
    db $F8, $00, $21, $00 ; entry 20
    db $D8, $FA, $09, $00 ; entry 21
    db $E0, $FB, $0A, $60 ; entry 22
    db $E0, $F3, $0B, $60 ; entry 23
    db $DB, $F2, $1D, $60 ; entry 24
    db $F8, $E8, $21, $20 ; entry 25
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites3F_407ESet10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet10Frame9::
Data_03F_4BF7:: ; heuristic: meta-sprite frame; C0
    db $D0, $FE, $10, $20 ; entry 0
    db $D0, $F6, $11, $20 ; entry 1
    db $D8, $F4, $12, $40 ; entry 2
    db $D8, $FC, $13, $40 ; entry 3
    db $E0, $ED, $1D, $60 ; entry 4
    db $E8, $F6, $10, $20 ; entry 5
    db $E8, $EE, $11, $20 ; entry 6
    db $F0, $F0, $18, $20 ; entry 7
    db $D8, $06, $14, $00 ; entry 8
    db $D8, $0E, $15, $00 ; entry 9
    db $E0, $0F, $10, $20 ; entry 10
    db $E0, $07, $11, $20 ; entry 11
    db $E8, $04, $06, $00 ; entry 12
    db $E8, $0C, $07, $00 ; entry 13
    db $F0, $01, $14, $00 ; entry 14
    db $F0, $09, $15, $00 ; entry 15
    db $F8, $10, $1F, $00 ; entry 16
    db $F8, $01, $1E, $20 ; entry 17
    db $F8, $09, $1E, $00 ; entry 18
    db $F0, $0C, $04, $00 ; entry 19
    db $F8, $10, $05, $20 ; entry 20
    db $E0, $FA, $05, $20 ; entry 21
    db $E0, $F5, $1C, $60 ; entry 22
    db $D0, $02, $12, $00 ; entry 23
    db $D0, $0A, $13, $00 ; entry 24
    db $F8, $F9, $1F, $20 ; entry 25
    db $F8, $F4, $20, $00 ; entry 26
    db $F8, $FC, $21, $00 ; entry 27
    db $F8, $EC, $20, $20 ; entry 28
    db $F0, $F8, $22, $00 ; entry 29
    db $F8, $E4, $1F, $20 ; entry 30
    db $D0, $E8, $22, $20 ; entry 31
    db $D8, $E8, $22, $20 ; entry 32
    db $E0, $E8, $22, $20 ; entry 33
    db $D0, $10, $22, $00 ; entry 34
    db $E8, $FD, $22, $00 ; entry 35
    db $F0, $E8, $0E, $00 ; entry 36
    db $80 ; end

; E-0147 (derived: frame 10 of MetaSprites3F_407ESet10; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet10Frame10::
    db $80 ; end

; E-0147 (derived: meta-sprite set 17 of MetaSprites3F_407ETable: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3F_407ESet11::
Data_03F_4C8D:: ; heuristic: meta-sprite set; C0
    dw MetaSprites3F_407ESet11Frame0 ; entry 0
    dw MetaSprites3F_407ESet11Frame1 ; entry 1
    dw MetaSprites3F_407ESet11Frame2 ; entry 2
    dw MetaSprites3F_407ESet11Frame3 ; entry 3
    dw MetaSprites3F_407ESet11Frame4 ; entry 4
    dw MetaSprites3F_407ESet11Frame5 ; entry 5
    dw MetaSprites3F_407ESet11Frame6 ; entry 6
    dw MetaSprites3F_407ESet11Frame7 ; entry 7
    dw MetaSprites3F_407ESet11Frame8 ; entry 8
    dw MetaSprites3F_407ESet11Frame9 ; entry 9
    dw MetaSprites3F_407ESet11Frame10 ; entry 10
    dw MetaSprites3F_407ESet11Frame11 ; entry 11
    dw MetaSprites3F_407ESet11Frame12 ; entry 12
    dw MetaSprites3F_407ESet11Frame13 ; entry 13
    dw MetaSprites3F_407ESet11Frame14 ; entry 14
    dw MetaSprites3F_407ESet11Frame15 ; entry 15
    dw MetaSprites3F_407ESet11Frame16 ; entry 16
    dw MetaSprites3F_407ESet11Frame16 ; entry 17
    dw MetaSprites3F_407ESet11Frame16 ; entry 18
    dw MetaSprites3F_407ESet11Frame16 ; entry 19
    dw MetaSprites3F_407ESet11Frame16 ; entry 20
    dw MetaSprites3F_407ESet11Frame16 ; entry 21
    dw MetaSprites3F_407ESet11Frame16 ; entry 22
    dw MetaSprites3F_407ESet11Frame16 ; entry 23
    dw MetaSprites3F_407ESet11Frame16 ; entry 24
    dw MetaSprites3F_407ESet11Frame16 ; entry 25
    dw MetaSprites3F_407ESet11Frame16 ; entry 26
    dw MetaSprites3F_407ESet11Frame16 ; entry 27
    dw MetaSprites3F_407ESet11Frame16 ; entry 28
    dw MetaSprites3F_407ESet11Frame16 ; entry 29
    dw MetaSprites3F_407ESet11Frame16 ; entry 30
    dw MetaSprites3F_407ESet11Frame16 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3F_407ESet11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet11Frame0::
Data_03F_4CCD:: ; heuristic: meta-sprite frame; C0
    db $F8, $F8, $01, $40 ; entry 0
    db $F8, $00, $01, $60 ; entry 1
    db $D0, $F8, $01, $00 ; entry 2
    db $D0, $00, $01, $20 ; entry 3
    db $F0, $FE, $05, $60 ; entry 4
    db $D8, $FA, $05, $00 ; entry 5
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3F_407ESet11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet11Frame1::
Data_03F_4CE6:: ; heuristic: meta-sprite frame; C0
    db $D0, $FC, $00, $00 ; entry 0
    db $D4, $FC, $2B, $00 ; entry 1
    db $F8, $FC, $00, $40 ; entry 2
    db $F4, $FC, $2B, $40 ; entry 3
    db $E7, $FC, $00, $00 ; entry 4
    db $E2, $FC, $00, $40 ; entry 5
    db $DC, $FC, $2F, $00 ; entry 6
    db $ED, $FC, $2F, $00 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3F_407ESet11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet11Frame2::
Data_03F_4D07:: ; heuristic: meta-sprite frame; C0
    db $DB, $0D, $1D, $00 ; entry 0
    db $EA, $07, $14, $20 ; entry 1
    db $F2, $06, $05, $00 ; entry 2
    db $DB, $F4, $23, $40 ; entry 3
    db $E8, $F8, $01, $00 ; entry 4
    db $E0, $F8, $01, $40 ; entry 5
    db $E0, $00, $01, $60 ; entry 6
    db $E8, $00, $01, $20 ; entry 7
    db $ED, $F5, $24, $40 ; entry 8
    db $DB, $05, $1C, $00 ; entry 9
    db $EE, $ED, $1D, $60 ; entry 10
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3F_407ESet11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet11Frame3::
Data_03F_4D34:: ; heuristic: meta-sprite frame; C0
    db $E8, $08, $06, $20 ; entry 0
    db $E8, $00, $02, $60 ; entry 1
    db $E0, $00, $03, $00 ; entry 2
    db $E8, $F8, $2C, $00 ; entry 3
    db $E8, $F0, $27, $00 ; entry 4
    db $DC, $08, $27, $60 ; entry 5
    db $F8, $FC, $2E, $00 ; entry 6
    db $F0, $FD, $2D, $00 ; entry 7
    db $E0, $F8, $2C, $40 ; entry 8
    db $E0, $F0, $0B, $20 ; entry 9
    db $D0, $FC, $2E, $60 ; entry 10
    db $D8, $FB, $2D, $60 ; entry 11
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3F_407ESet11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet11Frame4::
Data_03F_4D65:: ; heuristic: meta-sprite frame; C0
    db $E0, $FB, $17, $60 ; entry 0
    db $E0, $03, $14, $60 ; entry 1
    db $D8, $03, $10, $60 ; entry 2
    db $E8, $FD, $17, $00 ; entry 3
    db $E8, $F5, $14, $00 ; entry 4
    db $F0, $F5, $10, $00 ; entry 5
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3F_407ESet11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet11Frame5::
Data_03F_4D7E:: ; heuristic: meta-sprite frame; C0
    db $E4, $F8, $1E, $00 ; entry 0
    db $EC, $F8, $1F, $00 ; entry 1
    db $E4, $F0, $1C, $00 ; entry 2
    db $EC, $F0, $1D, $00 ; entry 3
    db $E4, $E8, $1F, $40 ; entry 4
    db $EC, $E6, $24, $20 ; entry 5
    db $F1, $E2, $0D, $20 ; entry 6
    db $E4, $00, $1E, $60 ; entry 7
    db $DC, $00, $1F, $60 ; entry 8
    db $E4, $08, $1C, $60 ; entry 9
    db $DC, $08, $1D, $60 ; entry 10
    db $E4, $10, $1F, $20 ; entry 11
    db $DC, $12, $24, $40 ; entry 12
    db $D7, $16, $0D, $40 ; entry 13
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3F_407ESet11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet11Frame6::
Data_03F_4DB7:: ; heuristic: meta-sprite frame; C0
    db $E2, $F8, $18, $60 ; entry 0
    db $DA, $F8, $19, $60 ; entry 1
    db $E1, $F0, $1A, $60 ; entry 2
    db $D9, $F0, $1B, $60 ; entry 3
    db $E6, $00, $18, $00 ; entry 4
    db $EE, $00, $19, $00 ; entry 5
    db $E7, $08, $1A, $00 ; entry 6
    db $EF, $08, $1B, $00 ; entry 7
    db $E8, $10, $1C, $00 ; entry 8
    db $F0, $10, $1D, $00 ; entry 9
    db $E9, $18, $1E, $00 ; entry 10
    db $F1, $18, $16, $40 ; entry 11
    db $E9, $20, $20, $00 ; entry 12
    db $E8, $28, $09, $00 ; entry 13
    db $F1, $20, $21, $00 ; entry 14
    db $F8, $28, $1C, $00 ; entry 15
    db $F8, $30, $15, $00 ; entry 16
    db $F0, $2A, $08, $00 ; entry 17
    db $DF, $E0, $1E, $60 ; entry 18
    db $D7, $E0, $1E, $00 ; entry 19
    db $DF, $D8, $20, $60 ; entry 20
    db $E0, $D0, $09, $60 ; entry 21
    db $E0, $E8, $1C, $60 ; entry 22
    db $D8, $E8, $1D, $60 ; entry 23
    db $D8, $CE, $08, $60 ; entry 24
    db $D7, $D8, $21, $60 ; entry 25
    db $D0, $D0, $1C, $60 ; entry 26
    db $D0, $C8, $15, $60 ; entry 27
    db $F8, $20, $1E, $60 ; entry 28
    db $D0, $D8, $1E, $00 ; entry 29
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3F_407ESet11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet11Frame7::
Data_03F_4E30:: ; heuristic: meta-sprite frame; C0
    db $D8, $02, $08, $20 ; entry 0
    db $D8, $FA, $09, $20 ; entry 1
    db $E0, $FC, $14, $00 ; entry 2
    db $E0, $04, $15, $00 ; entry 3
    db $E8, $FD, $0C, $00 ; entry 4
    db $E8, $05, $0D, $00 ; entry 5
    db $E8, $FA, $0D, $20 ; entry 6
    db $F0, $12, $0E, $20 ; entry 7
    db $F0, $0A, $0F, $20 ; entry 8
    db $F8, $0A, $09, $00 ; entry 9
    db $F8, $1A, $0B, $40 ; entry 10
    db $F8, $12, $0F, $20 ; entry 11
    db $F8, $02, $20, $00 ; entry 12
    db $F0, $F4, $11, $60 ; entry 13
    db $D0, $02, $0B, $40 ; entry 14
    db $D8, $F3, $16, $40 ; entry 15
    db $D0, $E7, $1C, $60 ; entry 16
    db $D0, $F7, $08, $20 ; entry 17
    db $D0, $EF, $09, $20 ; entry 18
    db $D0, $DF, $2A, $20 ; entry 19
    db $D8, $DF, $05, $00 ; entry 20
    db $F0, $1A, $0C, $60 ; entry 21
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites3F_407ESet11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet11Frame8::
Data_03F_4E89:: ; heuristic: meta-sprite frame; C0
    db $F0, $03, $08, $60 ; entry 0
    db $F0, $FB, $09, $60 ; entry 1
    db $E8, $FD, $14, $40 ; entry 2
    db $E8, $05, $15, $40 ; entry 3
    db $E0, $FE, $0C, $40 ; entry 4
    db $E0, $06, $0D, $40 ; entry 5
    db $E0, $FB, $0D, $60 ; entry 6
    db $D8, $13, $0E, $60 ; entry 7
    db $D8, $0B, $0F, $60 ; entry 8
    db $D8, $1A, $0C, $60 ; entry 9
    db $D0, $0B, $09, $40 ; entry 10
    db $D0, $1B, $0B, $00 ; entry 11
    db $D0, $13, $0F, $60 ; entry 12
    db $D0, $03, $20, $40 ; entry 13
    db $D8, $F5, $11, $20 ; entry 14
    db $F8, $03, $0B, $00 ; entry 15
    db $F0, $F4, $16, $00 ; entry 16
    db $F8, $E8, $1C, $20 ; entry 17
    db $F8, $F8, $08, $60 ; entry 18
    db $F8, $F0, $09, $60 ; entry 19
    db $F8, $E0, $2A, $60 ; entry 20
    db $F0, $E0, $05, $40 ; entry 21
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites3F_407ESet11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet11Frame9::
Data_03F_4EE2:: ; heuristic: meta-sprite frame; C0
    db $D0, $30, $18, $20 ; entry 0
    db $D8, $30, $19, $20 ; entry 1
    db $D0, $28, $1A, $20 ; entry 2
    db $D8, $28, $1B, $20 ; entry 3
    db $D0, $20, $1C, $20 ; entry 4
    db $D8, $20, $1D, $20 ; entry 5
    db $D0, $18, $1E, $20 ; entry 6
    db $D8, $18, $1E, $40 ; entry 7
    db $D8, $10, $20, $60 ; entry 8
    db $D9, $08, $09, $60 ; entry 9
    db $D1, $06, $08, $60 ; entry 10
    db $D0, $10, $21, $60 ; entry 11
    db $E1, $07, $15, $40 ; entry 12
    db $E4, $FF, $11, $60 ; entry 13
    db $E4, $F9, $11, $00 ; entry 14
    db $E7, $F1, $15, $20 ; entry 15
    db $F7, $F2, $08, $00 ; entry 16
    db $EF, $F0, $09, $00 ; entry 17
    db $F8, $C8, $18, $40 ; entry 18
    db $F0, $C8, $19, $40 ; entry 19
    db $F8, $D0, $1A, $40 ; entry 20
    db $F0, $D0, $1B, $40 ; entry 21
    db $F8, $D8, $1C, $40 ; entry 22
    db $F0, $D8, $1D, $40 ; entry 23
    db $F8, $E0, $1E, $40 ; entry 24
    db $F0, $E0, $1E, $20 ; entry 25
    db $F0, $E8, $20, $00 ; entry 26
    db $F8, $E8, $21, $00 ; entry 27
    db $DF, $13, $08, $00 ; entry 28
    db $E0, $1B, $24, $60 ; entry 29
    db $E8, $1B, $05, $00 ; entry 30
    db $E9, $E5, $08, $60 ; entry 31
    db $E8, $DD, $24, $00 ; entry 32
    db $E0, $DD, $05, $60 ; entry 33
    db $E9, $07, $08, $60 ; entry 34
    db $F8, $0B, $26, $20 ; entry 35
    db $F1, $09, $0D, $60 ; entry 36
    db $DF, $F1, $08, $00 ; entry 37
    db $D0, $ED, $26, $40 ; entry 38
    db $D7, $EF, $0D, $00 ; entry 39
    db $80 ; end

; E-0147 (derived: frame 10 of MetaSprites3F_407ESet11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet11Frame10::
Data_03F_4F83:: ; heuristic: meta-sprite frame; C0
    db $E2, $00, $18, $40 ; entry 0
    db $DA, $00, $19, $40 ; entry 1
    db $E2, $08, $1A, $40 ; entry 2
    db $DA, $08, $1B, $40 ; entry 3
    db $E2, $10, $1C, $40 ; entry 4
    db $DA, $10, $1D, $40 ; entry 5
    db $E2, $18, $1E, $40 ; entry 6
    db $DA, $18, $1F, $40 ; entry 7
    db $DA, $20, $20, $00 ; entry 8
    db $E2, $20, $21, $00 ; entry 9
    db $E8, $40, $09, $40 ; entry 10
    db $DF, $30, $1E, $00 ; entry 11
    db $E7, $30, $1E, $60 ; entry 12
    db $E7, $38, $20, $40 ; entry 13
    db $DF, $38, $21, $40 ; entry 14
    db $DE, $28, $18, $00 ; entry 15
    db $E6, $28, $19, $00 ; entry 16
    db $E0, $40, $08, $60 ; entry 17
    db $F0, $40, $15, $60 ; entry 18
    db $F0, $48, $1C, $20 ; entry 19
    db $F8, $48, $09, $00 ; entry 20
    db $F8, $40, $2A, $40 ; entry 21
    db $D8, $28, $09, $00 ; entry 22
    db $D0, $2C, $0F, $60 ; entry 23
    db $D0, $34, $08, $20 ; entry 24
    db $EA, $1E, $0C, $60 ; entry 25
    db $EA, $16, $0D, $60 ; entry 26
    db $F2, $1E, $0E, $60 ; entry 27
    db $F2, $16, $0F, $60 ; entry 28
    db $F8, $1A, $10, $60 ; entry 29
    db $F8, $12, $11, $60 ; entry 30
    db $80 ; end

; E-0147 (derived: frame 11 of MetaSprites3F_407ESet11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet11Frame11::
Data_03F_5000:: ; heuristic: meta-sprite frame; C0
    db $E6, $F8, $18, $20 ; entry 0
    db $EE, $F8, $19, $20 ; entry 1
    db $E6, $F0, $1A, $20 ; entry 2
    db $EE, $F0, $1B, $20 ; entry 3
    db $E6, $E8, $1C, $20 ; entry 4
    db $EE, $E8, $1D, $20 ; entry 5
    db $E6, $E0, $1E, $20 ; entry 6
    db $EE, $E0, $1F, $20 ; entry 7
    db $EE, $D8, $20, $60 ; entry 8
    db $E6, $D8, $21, $60 ; entry 9
    db $E0, $B8, $09, $20 ; entry 10
    db $E9, $C8, $1E, $60 ; entry 11
    db $E1, $C8, $1E, $00 ; entry 12
    db $E1, $C0, $20, $20 ; entry 13
    db $E9, $C0, $21, $20 ; entry 14
    db $EA, $D0, $18, $60 ; entry 15
    db $E2, $D0, $19, $60 ; entry 16
    db $E8, $B8, $08, $00 ; entry 17
    db $D8, $B8, $15, $00 ; entry 18
    db $D8, $B0, $1C, $40 ; entry 19
    db $D0, $B0, $09, $60 ; entry 20
    db $D0, $B8, $2A, $20 ; entry 21
    db $F0, $D0, $09, $60 ; entry 22
    db $F8, $CC, $0F, $00 ; entry 23
    db $F8, $C4, $08, $40 ; entry 24
    db $DE, $DA, $0C, $00 ; entry 25
    db $DE, $E2, $0D, $00 ; entry 26
    db $D6, $DA, $0E, $00 ; entry 27
    db $D6, $E2, $0F, $00 ; entry 28
    db $D0, $DE, $10, $00 ; entry 29
    db $D0, $E6, $11, $00 ; entry 30
    db $80 ; end

; E-0147 (derived: frame 12 of MetaSprites3F_407ESet11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet11Frame12::
Data_03F_507D:: ; heuristic: meta-sprite frame; C0
    db $E4, $00, $09, $20 ; entry 0
    db $ED, $10, $1E, $60 ; entry 1
    db $E5, $10, $1E, $00 ; entry 2
    db $E5, $08, $20, $20 ; entry 3
    db $ED, $08, $21, $20 ; entry 4
    db $EE, $18, $18, $60 ; entry 5
    db $EC, $00, $08, $00 ; entry 6
    db $DC, $00, $15, $00 ; entry 7
    db $F8, $40, $18, $60 ; entry 8
    db $F0, $40, $19, $60 ; entry 9
    db $F8, $38, $1A, $60 ; entry 10
    db $F0, $38, $1B, $60 ; entry 11
    db $F8, $30, $1C, $60 ; entry 12
    db $F0, $30, $1D, $60 ; entry 13
    db $F8, $28, $1E, $60 ; entry 14
    db $F0, $28, $1F, $60 ; entry 15
    db $F0, $20, $20, $20 ; entry 16
    db $F8, $20, $21, $20 ; entry 17
    db $E8, $F8, $28, $60 ; entry 18
    db $E8, $F0, $29, $60 ; entry 19
    db $E6, $18, $28, $60 ; entry 20
    db $DE, $25, $1A, $60 ; entry 21
    db $DE, $1D, $24, $40 ; entry 22
    db $DC, $2D, $1C, $60 ; entry 23
    db $D4, $2D, $1D, $60 ; entry 24
    db $DC, $35, $22, $40 ; entry 25
    db $D4, $35, $24, $40 ; entry 26
    db $D0, $3D, $1E, $40 ; entry 27
    db $F8, $48, $10, $60 ; entry 28
    db $F0, $F7, $26, $60 ; entry 29
    db $F8, $F4, $26, $00 ; entry 30
    db $DB, $3D, $27, $20 ; entry 31
    db $80 ; end

; E-0147 (derived: frame 13 of MetaSprites3F_407ESet11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet11Frame13::
Data_03F_50FE:: ; heuristic: meta-sprite frame; C0
    db $F4, $CB, $1D, $00 ; entry 0
    db $F4, $C3, $24, $20 ; entry 1
    db $F8, $BB, $1E, $20 ; entry 2
    db $E4, $F8, $09, $40 ; entry 3
    db $DB, $E8, $1E, $00 ; entry 4
    db $E3, $E8, $1E, $60 ; entry 5
    db $E3, $F0, $20, $40 ; entry 6
    db $DB, $F0, $21, $40 ; entry 7
    db $DA, $E0, $18, $00 ; entry 8
    db $DC, $F8, $08, $60 ; entry 9
    db $EC, $F8, $15, $60 ; entry 10
    db $D0, $B8, $18, $00 ; entry 11
    db $D8, $B8, $19, $00 ; entry 12
    db $D0, $C0, $1A, $00 ; entry 13
    db $D8, $C0, $1B, $00 ; entry 14
    db $D0, $C8, $1C, $00 ; entry 15
    db $D8, $C8, $1D, $00 ; entry 16
    db $D0, $D0, $1E, $00 ; entry 17
    db $D8, $D0, $1F, $00 ; entry 18
    db $D8, $D8, $20, $40 ; entry 19
    db $D0, $D8, $21, $40 ; entry 20
    db $E0, $00, $28, $00 ; entry 21
    db $E0, $08, $29, $00 ; entry 22
    db $E2, $E0, $28, $00 ; entry 23
    db $EA, $D3, $1A, $00 ; entry 24
    db $EA, $DB, $24, $20 ; entry 25
    db $EC, $CB, $1C, $00 ; entry 26
    db $EC, $C3, $22, $20 ; entry 27
    db $D0, $B0, $10, $00 ; entry 28
    db $D8, $01, $26, $00 ; entry 29
    db $D0, $04, $26, $60 ; entry 30
    db $ED, $BB, $27, $40 ; entry 31
    db $80 ; end

; E-0147 (derived: frame 14 of MetaSprites3F_407ESet11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet11Frame14::
Data_03F_517F:: ; heuristic: meta-sprite frame; C0
    db $E8, $00, $1E, $60 ; entry 0
    db $E0, $00, $1F, $60 ; entry 1
    db $EA, $08, $1C, $20 ; entry 2
    db $E0, $F8, $1E, $00 ; entry 3
    db $E8, $F8, $1F, $00 ; entry 4
    db $DE, $F0, $1C, $40 ; entry 5
    db $DD, $E8, $1F, $00 ; entry 6
    db $D5, $E6, $24, $60 ; entry 7
    db $D0, $E2, $0D, $60 ; entry 8
    db $EB, $10, $1F, $60 ; entry 9
    db $F3, $12, $24, $00 ; entry 10
    db $F8, $16, $0D, $00 ; entry 11
    db $D6, $F0, $05, $60 ; entry 12
    db $F2, $08, $05, $00 ; entry 13
    db $80 ; end

; E-0147 (derived: frame 15 of MetaSprites3F_407ESet11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet11Frame15::
Data_03F_51B8:: ; heuristic: meta-sprite frame; C0
    db $E0, $FC, $14, $00 ; entry 0
    db $E0, $04, $15, $00 ; entry 1
    db $E8, $FD, $0C, $00 ; entry 2
    db $E8, $05, $0D, $00 ; entry 3
    db $E8, $FA, $0D, $20 ; entry 4
    db $F0, $12, $0E, $20 ; entry 5
    db $F0, $0A, $0F, $20 ; entry 6
    db $F0, $19, $0C, $60 ; entry 7
    db $F8, $0A, $09, $00 ; entry 8
    db $F8, $1A, $0B, $40 ; entry 9
    db $F8, $12, $0F, $20 ; entry 10
    db $F8, $02, $20, $00 ; entry 11
    db $D8, $F8, $08, $00 ; entry 12
    db $D8, $00, $09, $00 ; entry 13
    db $D8, $07, $16, $60 ; entry 14
    db $D0, $13, $1C, $40 ; entry 15
    db $D0, $03, $08, $00 ; entry 16
    db $D0, $0B, $09, $00 ; entry 17
    db $D0, $1B, $2A, $00 ; entry 18
    db $D8, $1B, $05, $20 ; entry 19
    db $D8, $E8, $0E, $40 ; entry 20
    db $D8, $F0, $0F, $40 ; entry 21
    db $D8, $E1, $0C, $00 ; entry 22
    db $D0, $F0, $09, $60 ; entry 23
    db $D0, $E0, $0B, $20 ; entry 24
    db $D0, $E8, $0F, $40 ; entry 25
    db $D0, $F8, $20, $60 ; entry 26
    db $F8, $E6, $1C, $20 ; entry 27
    db $F8, $F5, $08, $60 ; entry 28
    db $F8, $EE, $09, $60 ; entry 29
    db $F8, $DE, $2A, $60 ; entry 30
    db $F0, $DE, $05, $40 ; entry 31
    db $EF, $F7, $09, $00 ; entry 32
    db $F1, $EF, $21, $60 ; entry 33
    db $80 ; end

; E-0147 (derived: frame 16 of MetaSprites3F_407ESet11; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet11Frame16::
    db $80 ; end

; E-0147 (derived: meta-sprite set 18 of MetaSprites3F_407ETable: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3F_407ESet12::
Data_03F_5242:: ; heuristic: meta-sprite set; C0
    dw MetaSprites3F_407ESet12Frame0 ; entry 0
    dw MetaSprites3F_407ESet12Frame1 ; entry 1
    dw MetaSprites3F_407ESet12Frame2 ; entry 2
    dw MetaSprites3F_407ESet12Frame3 ; entry 3
    dw MetaSprites3F_407ESet12Frame4 ; entry 4
    dw MetaSprites3F_407ESet12Frame5 ; entry 5
    dw MetaSprites3F_407ESet12Frame6 ; entry 6
    dw MetaSprites3F_407ESet12Frame7 ; entry 7
    dw MetaSprites3F_407ESet12Frame8 ; entry 8
    dw MetaSprites3F_407ESet12Frame9 ; entry 9
    dw MetaSprites3F_407ESet12Frame10 ; entry 10
    dw MetaSprites3F_407ESet12Frame11 ; entry 11
    dw MetaSprites3F_407ESet12Frame11 ; entry 12
    dw MetaSprites3F_407ESet12Frame11 ; entry 13
    dw MetaSprites3F_407ESet12Frame11 ; entry 14
    dw MetaSprites3F_407ESet12Frame11 ; entry 15
    dw MetaSprites3F_407ESet12Frame11 ; entry 16
    dw MetaSprites3F_407ESet12Frame11 ; entry 17
    dw MetaSprites3F_407ESet12Frame11 ; entry 18
    dw MetaSprites3F_407ESet12Frame11 ; entry 19
    dw MetaSprites3F_407ESet12Frame11 ; entry 20
    dw MetaSprites3F_407ESet12Frame11 ; entry 21
    dw MetaSprites3F_407ESet12Frame11 ; entry 22
    dw MetaSprites3F_407ESet12Frame11 ; entry 23
    dw MetaSprites3F_407ESet12Frame11 ; entry 24
    dw MetaSprites3F_407ESet12Frame11 ; entry 25
    dw MetaSprites3F_407ESet12Frame11 ; entry 26
    dw MetaSprites3F_407ESet12Frame11 ; entry 27
    dw MetaSprites3F_407ESet12Frame11 ; entry 28
    dw MetaSprites3F_407ESet12Frame11 ; entry 29
    dw MetaSprites3F_407ESet12Frame11 ; entry 30
    dw MetaSprites3F_407ESet12Frame11 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3F_407ESet12; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet12Frame0::
Data_03F_5282:: ; heuristic: meta-sprite frame; C0
    db $D0, $10, $00, $10 ; entry 0
    db $D8, $10, $01, $10 ; entry 1
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3F_407ESet12; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet12Frame1::
Data_03F_528B:: ; heuristic: meta-sprite frame; C0
    db $D8, $08, $01, $10 ; entry 0
    db $D0, $08, $00, $10 ; entry 1
    db $D2, $10, $02, $10 ; entry 2
    db $DA, $10, $03, $10 ; entry 3
    db $E2, $10, $04, $10 ; entry 4
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3F_407ESet12; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet12Frame2::
Data_03F_52A0:: ; heuristic: meta-sprite frame; C0
    db $D0, $00, $00, $10 ; entry 0
    db $D8, $00, $01, $10 ; entry 1
    db $D2, $08, $02, $10 ; entry 2
    db $DA, $08, $03, $10 ; entry 3
    db $E2, $08, $04, $10 ; entry 4
    db $D4, $10, $05, $10 ; entry 5
    db $DC, $10, $06, $10 ; entry 6
    db $E4, $10, $07, $10 ; entry 7
    db $EC, $10, $08, $10 ; entry 8
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3F_407ESet12; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet12Frame3::
Data_03F_52C5:: ; heuristic: meta-sprite frame; C0
    db $D0, $F8, $00, $10 ; entry 0
    db $D8, $F8, $01, $10 ; entry 1
    db $D2, $00, $02, $10 ; entry 2
    db $DA, $00, $03, $10 ; entry 3
    db $E2, $00, $04, $10 ; entry 4
    db $D4, $08, $05, $10 ; entry 5
    db $DC, $08, $06, $10 ; entry 6
    db $E4, $08, $07, $10 ; entry 7
    db $EC, $08, $08, $10 ; entry 8
    db $D6, $10, $09, $10 ; entry 9
    db $DE, $10, $0A, $10 ; entry 10
    db $E6, $10, $0B, $10 ; entry 11
    db $EE, $10, $0C, $10 ; entry 12
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3F_407ESet12; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet12Frame4::
Data_03F_52FA:: ; heuristic: meta-sprite frame; C0
    db $D0, $F0, $00, $10 ; entry 0
    db $D8, $F0, $01, $10 ; entry 1
    db $D2, $F8, $02, $10 ; entry 2
    db $DA, $F8, $03, $10 ; entry 3
    db $E2, $F8, $04, $10 ; entry 4
    db $D4, $00, $05, $10 ; entry 5
    db $DC, $00, $06, $10 ; entry 6
    db $E4, $00, $07, $10 ; entry 7
    db $EC, $00, $08, $10 ; entry 8
    db $D6, $08, $09, $10 ; entry 9
    db $DE, $08, $0A, $10 ; entry 10
    db $E6, $08, $0B, $10 ; entry 11
    db $EE, $08, $0C, $10 ; entry 12
    db $E0, $10, $0D, $10 ; entry 13
    db $E8, $10, $0E, $10 ; entry 14
    db $F0, $10, $0F, $10 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3F_407ESet12; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet12Frame5::
Data_03F_533B:: ; heuristic: meta-sprite frame; C0
    db $D0, $E8, $00, $10 ; entry 0
    db $D8, $E8, $01, $10 ; entry 1
    db $D2, $F0, $02, $10 ; entry 2
    db $DA, $F0, $03, $10 ; entry 3
    db $E2, $F0, $04, $10 ; entry 4
    db $D4, $F8, $05, $10 ; entry 5
    db $DC, $F8, $06, $10 ; entry 6
    db $E4, $F8, $07, $10 ; entry 7
    db $EC, $F8, $08, $10 ; entry 8
    db $D6, $00, $09, $10 ; entry 9
    db $DE, $00, $0A, $10 ; entry 10
    db $E6, $00, $0B, $10 ; entry 11
    db $EE, $00, $0C, $10 ; entry 12
    db $E0, $08, $0D, $10 ; entry 13
    db $E8, $08, $0E, $10 ; entry 14
    db $F0, $08, $0F, $10 ; entry 15
    db $EA, $10, $10, $10 ; entry 16
    db $F2, $10, $11, $10 ; entry 17
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3F_407ESet12; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet12Frame6::
Data_03F_5384:: ; heuristic: meta-sprite frame; C0
    db $EA, $08, $10, $10 ; entry 0
    db $F2, $08, $11, $10 ; entry 1
    db $E0, $00, $0D, $10 ; entry 2
    db $E8, $00, $0E, $10 ; entry 3
    db $F0, $00, $0F, $10 ; entry 4
    db $D2, $E8, $02, $10 ; entry 5
    db $DA, $E8, $03, $10 ; entry 6
    db $E2, $E8, $04, $10 ; entry 7
    db $D4, $F0, $05, $10 ; entry 8
    db $DC, $F0, $06, $10 ; entry 9
    db $E4, $F0, $07, $10 ; entry 10
    db $EC, $F0, $08, $10 ; entry 11
    db $D6, $F8, $09, $10 ; entry 12
    db $DE, $F8, $0A, $10 ; entry 13
    db $E6, $F8, $0B, $10 ; entry 14
    db $EE, $F8, $0C, $10 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3F_407ESet12; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet12Frame7::
Data_03F_53C5:: ; heuristic: meta-sprite frame; C0
    db $D4, $E8, $05, $10 ; entry 0
    db $DC, $E8, $06, $10 ; entry 1
    db $E4, $E8, $07, $10 ; entry 2
    db $EC, $E8, $08, $10 ; entry 3
    db $D6, $F0, $09, $10 ; entry 4
    db $DE, $F0, $0A, $10 ; entry 5
    db $E6, $F0, $0B, $10 ; entry 6
    db $EE, $F0, $0C, $10 ; entry 7
    db $E0, $F8, $0D, $10 ; entry 8
    db $E8, $F8, $0E, $10 ; entry 9
    db $F0, $F8, $0F, $10 ; entry 10
    db $EA, $00, $10, $10 ; entry 11
    db $F2, $00, $11, $10 ; entry 12
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites3F_407ESet12; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet12Frame8::
Data_03F_53FA:: ; heuristic: meta-sprite frame; C0
    db $D6, $E8, $09, $10 ; entry 0
    db $DE, $E8, $0A, $10 ; entry 1
    db $E6, $E8, $0B, $10 ; entry 2
    db $EE, $E8, $0C, $10 ; entry 3
    db $E0, $F0, $0D, $10 ; entry 4
    db $E8, $F0, $0E, $10 ; entry 5
    db $F0, $F0, $0F, $10 ; entry 6
    db $EA, $F8, $10, $10 ; entry 7
    db $F2, $F8, $11, $10 ; entry 8
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites3F_407ESet12; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet12Frame9::
Data_03F_541F:: ; heuristic: meta-sprite frame; C0
    db $E0, $E8, $0D, $10 ; entry 0
    db $E8, $E8, $0E, $10 ; entry 1
    db $F0, $E8, $0F, $10 ; entry 2
    db $EA, $F0, $10, $10 ; entry 3
    db $F2, $F0, $11, $10 ; entry 4
    db $80 ; end

; E-0147 (derived: frame 10 of MetaSprites3F_407ESet12; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet12Frame10::
Data_03F_5434:: ; heuristic: meta-sprite frame; C0
    db $EA, $E8, $10, $10 ; entry 0
    db $F2, $E8, $11, $10 ; entry 1
    db $80 ; end

; E-0147 (derived: frame 11 of MetaSprites3F_407ESet12; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet12Frame11::
    db $80 ; end

; E-0147 (derived: meta-sprite set 19 of MetaSprites3F_407ETable: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3F_407ESet13::
Data_03F_543E:: ; heuristic: meta-sprite set; C0
    dw MetaSprites3F_407ESet13Frame0 ; entry 0
    dw MetaSprites3F_407ESet13Frame1 ; entry 1
    dw MetaSprites3F_407ESet13Frame2 ; entry 2
    dw MetaSprites3F_407ESet13Frame3 ; entry 3
    dw MetaSprites3F_407ESet13Frame4 ; entry 4
    dw MetaSprites3F_407ESet13Frame5 ; entry 5
    dw MetaSprites3F_407ESet13Frame6 ; entry 6
    dw MetaSprites3F_407ESet13Frame7 ; entry 7
    dw MetaSprites3F_407ESet13Frame8 ; entry 8
    dw MetaSprites3F_407ESet13Frame8 ; entry 9
    dw MetaSprites3F_407ESet13Frame8 ; entry 10
    dw MetaSprites3F_407ESet13Frame8 ; entry 11
    dw MetaSprites3F_407ESet13Frame8 ; entry 12
    dw MetaSprites3F_407ESet13Frame8 ; entry 13
    dw MetaSprites3F_407ESet13Frame8 ; entry 14
    dw MetaSprites3F_407ESet13Frame8 ; entry 15
    dw MetaSprites3F_407ESet13Frame8 ; entry 16
    dw MetaSprites3F_407ESet13Frame8 ; entry 17
    dw MetaSprites3F_407ESet13Frame8 ; entry 18
    dw MetaSprites3F_407ESet13Frame8 ; entry 19
    dw MetaSprites3F_407ESet13Frame8 ; entry 20
    dw MetaSprites3F_407ESet13Frame8 ; entry 21
    dw MetaSprites3F_407ESet13Frame8 ; entry 22
    dw MetaSprites3F_407ESet13Frame8 ; entry 23
    dw MetaSprites3F_407ESet13Frame8 ; entry 24
    dw MetaSprites3F_407ESet13Frame8 ; entry 25
    dw MetaSprites3F_407ESet13Frame8 ; entry 26
    dw MetaSprites3F_407ESet13Frame8 ; entry 27
    dw MetaSprites3F_407ESet13Frame8 ; entry 28
    dw MetaSprites3F_407ESet13Frame8 ; entry 29
    dw MetaSprites3F_407ESet13Frame8 ; entry 30
    dw MetaSprites3F_407ESet13Frame8 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3F_407ESet13; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet13Frame0::
Data_03F_547E:: ; heuristic: meta-sprite frame; C0
    db $E8, $F0, $00, $10 ; entry 0
    db $E8, $F8, $01, $10 ; entry 1
    db $E8, $00, $00, $10 ; entry 2
    db $E8, $08, $01, $10 ; entry 3
    db $F0, $F0, $02, $10 ; entry 4
    db $F0, $F8, $03, $10 ; entry 5
    db $F0, $00, $02, $10 ; entry 6
    db $F0, $08, $03, $10 ; entry 7
    db $F8, $F0, $04, $10 ; entry 8
    db $F8, $F8, $05, $10 ; entry 9
    db $F8, $00, $04, $10 ; entry 10
    db $F8, $08, $05, $10 ; entry 11
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3F_407ESet13; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet13Frame1::
Data_03F_54AF:: ; heuristic: meta-sprite frame; C0
    db $E0, $F0, $06, $10 ; entry 0
    db $E0, $F8, $07, $10 ; entry 1
    db $E0, $00, $06, $10 ; entry 2
    db $E0, $08, $07, $10 ; entry 3
    db $E8, $F0, $08, $10 ; entry 4
    db $E8, $F8, $09, $10 ; entry 5
    db $E8, $00, $08, $10 ; entry 6
    db $E8, $08, $09, $10 ; entry 7
    db $F0, $F0, $0A, $10 ; entry 8
    db $F0, $F8, $0B, $10 ; entry 9
    db $F0, $00, $0A, $10 ; entry 10
    db $F0, $08, $0B, $10 ; entry 11
    db $F8, $00, $0C, $10 ; entry 12
    db $F8, $08, $0D, $10 ; entry 13
    db $F8, $F0, $0C, $10 ; entry 14
    db $F8, $F8, $0D, $10 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3F_407ESet13; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet13Frame2::
Data_03F_54F0:: ; heuristic: meta-sprite frame; C0
    db $D8, $F0, $00, $10 ; entry 0
    db $D8, $F8, $01, $10 ; entry 1
    db $D8, $00, $00, $10 ; entry 2
    db $D8, $08, $01, $10 ; entry 3
    db $E0, $00, $02, $10 ; entry 4
    db $E0, $08, $03, $10 ; entry 5
    db $E0, $F0, $02, $10 ; entry 6
    db $E0, $F8, $03, $10 ; entry 7
    db $E8, $00, $04, $10 ; entry 8
    db $E8, $08, $05, $10 ; entry 9
    db $E8, $F0, $04, $10 ; entry 10
    db $E8, $F8, $05, $10 ; entry 11
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3F_407ESet13; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet13Frame3::
Data_03F_5521:: ; heuristic: meta-sprite frame; C0
    db $D0, $00, $06, $10 ; entry 0
    db $D0, $08, $07, $10 ; entry 1
    db $D0, $F0, $06, $10 ; entry 2
    db $D0, $F8, $07, $10 ; entry 3
    db $D8, $00, $08, $10 ; entry 4
    db $D8, $08, $09, $10 ; entry 5
    db $D8, $F0, $08, $10 ; entry 6
    db $D8, $F8, $09, $10 ; entry 7
    db $E0, $00, $0A, $10 ; entry 8
    db $E0, $08, $0B, $10 ; entry 9
    db $E0, $F0, $0A, $10 ; entry 10
    db $E0, $F8, $0B, $10 ; entry 11
    db $E8, $00, $0C, $10 ; entry 12
    db $E8, $08, $0D, $10 ; entry 13
    db $E8, $F0, $0C, $10 ; entry 14
    db $E8, $F8, $0D, $10 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3F_407ESet13; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet13Frame4::
Data_03F_5562:: ; heuristic: meta-sprite frame; C0
    db $D0, $F0, $02, $10 ; entry 0
    db $D0, $F8, $03, $10 ; entry 1
    db $D0, $00, $02, $10 ; entry 2
    db $D0, $08, $03, $10 ; entry 3
    db $D8, $00, $04, $10 ; entry 4
    db $D8, $08, $05, $10 ; entry 5
    db $D8, $F0, $04, $10 ; entry 6
    db $D8, $F8, $05, $10 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3F_407ESet13; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet13Frame5::
Data_03F_5583:: ; heuristic: meta-sprite frame; C0
    db $D0, $F0, $0A, $10 ; entry 0
    db $D0, $F8, $0B, $10 ; entry 1
    db $D0, $00, $0A, $10 ; entry 2
    db $D0, $08, $0B, $10 ; entry 3
    db $D8, $F0, $0C, $10 ; entry 4
    db $D8, $F8, $0D, $10 ; entry 5
    db $D8, $00, $0C, $10 ; entry 6
    db $D8, $08, $0D, $10 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3F_407ESet13; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet13Frame6::
Data_03F_55A4:: ; heuristic: meta-sprite frame; C0
    db $D0, $F0, $04, $10 ; entry 0
    db $D0, $F8, $05, $10 ; entry 1
    db $D0, $00, $04, $10 ; entry 2
    db $D0, $08, $05, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3F_407ESet13; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet13Frame7::
Data_03F_55B5:: ; heuristic: meta-sprite frame; C0
    db $D0, $F0, $0C, $10 ; entry 0
    db $D0, $F8, $0D, $10 ; entry 1
    db $D0, $00, $0C, $10 ; entry 2
    db $D0, $08, $0D, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites3F_407ESet13; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet13Frame8::
    db $80 ; end

; E-0147 (derived: meta-sprite set 20 of MetaSprites3F_407ETable: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3F_407ESet14::
Data_03F_55C7:: ; heuristic: meta-sprite set; C0
    dw MetaSprites3F_407ESet14Frame0 ; entry 0
    dw MetaSprites3F_407ESet14Frame1 ; entry 1
    dw MetaSprites3F_407ESet14Frame2 ; entry 2
    dw MetaSprites3F_407ESet14Frame3 ; entry 3
    dw MetaSprites3F_407ESet14Frame4 ; entry 4
    dw MetaSprites3F_407ESet14Frame5 ; entry 5
    dw MetaSprites3F_407ESet14Frame6 ; entry 6
    dw MetaSprites3F_407ESet14Frame7 ; entry 7
    dw MetaSprites3F_407ESet14Frame8 ; entry 8
    dw MetaSprites3F_407ESet14Frame9 ; entry 9
    dw MetaSprites3F_407ESet14Frame10 ; entry 10
    dw MetaSprites3F_407ESet14Frame11 ; entry 11
    dw MetaSprites3F_407ESet14Frame11 ; entry 12
    dw MetaSprites3F_407ESet14Frame11 ; entry 13
    dw MetaSprites3F_407ESet14Frame11 ; entry 14
    dw MetaSprites3F_407ESet14Frame11 ; entry 15
    dw MetaSprites3F_407ESet14Frame11 ; entry 16
    dw MetaSprites3F_407ESet14Frame11 ; entry 17
    dw MetaSprites3F_407ESet14Frame11 ; entry 18
    dw MetaSprites3F_407ESet14Frame11 ; entry 19
    dw MetaSprites3F_407ESet14Frame11 ; entry 20
    dw MetaSprites3F_407ESet14Frame11 ; entry 21
    dw MetaSprites3F_407ESet14Frame11 ; entry 22
    dw MetaSprites3F_407ESet14Frame11 ; entry 23
    dw MetaSprites3F_407ESet14Frame11 ; entry 24
    dw MetaSprites3F_407ESet14Frame11 ; entry 25
    dw MetaSprites3F_407ESet14Frame11 ; entry 26
    dw MetaSprites3F_407ESet14Frame11 ; entry 27
    dw MetaSprites3F_407ESet14Frame11 ; entry 28
    dw MetaSprites3F_407ESet14Frame11 ; entry 29
    dw MetaSprites3F_407ESet14Frame11 ; entry 30
    dw MetaSprites3F_407ESet14Frame11 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3F_407ESet14; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet14Frame0::
Data_03F_5607:: ; heuristic: meta-sprite frame; C0
    db $E5, $F5, $00, $10 ; entry 0
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3F_407ESet14; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet14Frame1::
Data_03F_560C:: ; heuristic: meta-sprite frame; C0
    db $E0, $F0, $00, $10 ; entry 0
    db $E8, $F0, $02, $10 ; entry 1
    db $E8, $F8, $03, $10 ; entry 2
    db $E0, $F8, $05, $10 ; entry 3
    db $DD, $05, $00, $10 ; entry 4
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3F_407ESet14; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet14Frame2::
Data_03F_5621:: ; heuristic: meta-sprite frame; C0
    db $D8, $00, $00, $10 ; entry 0
    db $E0, $00, $02, $10 ; entry 1
    db $E0, $08, $03, $10 ; entry 2
    db $D8, $08, $01, $10 ; entry 3
    db $ED, $05, $00, $10 ; entry 4
    db $E0, $F0, $01, $10 ; entry 5
    db $E4, $F8, $04, $10 ; entry 6
    db $E8, $F8, $01, $10 ; entry 7
    db $E7, $F2, $04, $10 ; entry 8
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3F_407ESet14; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet14Frame3::
Data_03F_5646:: ; heuristic: meta-sprite frame; C0
    db $D8, $00, $01, $10 ; entry 0
    db $DC, $08, $04, $10 ; entry 1
    db $E0, $08, $01, $10 ; entry 2
    db $DF, $02, $04, $10 ; entry 3
    db $E6, $F2, $05, $10 ; entry 4
    db $E0, $F8, $05, $10 ; entry 5
    db $E4, $F4, $04, $10 ; entry 6
    db $E8, $00, $00, $10 ; entry 7
    db $F0, $00, $02, $10 ; entry 8
    db $F0, $08, $03, $10 ; entry 9
    db $E8, $08, $01, $10 ; entry 10
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3F_407ESet14; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet14Frame4::
Data_03F_5673:: ; heuristic: meta-sprite frame; C0
    db $E0, $F0, $01, $10 ; entry 0
    db $D8, $08, $01, $10 ; entry 1
    db $DE, $02, $01, $10 ; entry 2
    db $DC, $04, $04, $10 ; entry 3
    db $E8, $00, $01, $10 ; entry 4
    db $F0, $08, $01, $10 ; entry 5
    db $EF, $02, $04, $10 ; entry 6
    db $EC, $08, $04, $10 ; entry 7
    db $E6, $F7, $01, $50 ; entry 8
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3F_407ESet14; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet14Frame5::
Data_03F_5698:: ; heuristic: meta-sprite frame; C0
    db $D8, $00, $01, $10 ; entry 0
    db $E8, $08, $01, $10 ; entry 1
    db $EE, $02, $01, $10 ; entry 2
    db $EC, $04, $04, $10 ; entry 3
    db $DE, $07, $05, $50 ; entry 4
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3F_407ESet14; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet14Frame6::
Data_03F_56AD:: ; heuristic: meta-sprite frame; C0
    db $E8, $00, $01, $10 ; entry 0
    db $EE, $07, $01, $50 ; entry 1
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3F_407ESet14; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet14Frame7::
Data_03F_56B6:: ; heuristic: meta-sprite frame; C0
    db $E6, $F2, $01, $10 ; entry 0
    db $E0, $F8, $01, $10 ; entry 1
    db $E4, $F4, $04, $10 ; entry 2
    db $E8, $00, $00, $10 ; entry 3
    db $E8, $08, $01, $10 ; entry 4
    db $F0, $00, $02, $10 ; entry 5
    db $F0, $08, $03, $10 ; entry 6
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites3F_407ESet14; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet14Frame8::
Data_03F_56D3:: ; heuristic: meta-sprite frame; C0
    db $E0, $F0, $01, $10 ; entry 0
    db $E8, $00, $01, $10 ; entry 1
    db $F0, $08, $01, $10 ; entry 2
    db $E6, $F7, $01, $50 ; entry 3
    db $EC, $08, $04, $10 ; entry 4
    db $EF, $02, $04, $10 ; entry 5
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites3F_407ESet14; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet14Frame9::
Data_03F_56EC:: ; heuristic: meta-sprite frame; C0
    db $EE, $02, $01, $10 ; entry 0
    db $E8, $08, $01, $10 ; entry 1
    db $EC, $04, $04, $10 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 10 of MetaSprites3F_407ESet14; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet14Frame10::
Data_03F_56F9:: ; heuristic: meta-sprite frame; C0
    db $E8, $00, $01, $10 ; entry 0
    db $EE, $07, $01, $50 ; entry 1
    db $80 ; end

; E-0147 (derived: frame 11 of MetaSprites3F_407ESet14; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet14Frame11::
    db $80 ; end

; E-0147 (derived: meta-sprite set 21 of MetaSprites3F_407ETable: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3F_407ESet15::
Data_03F_5703:: ; heuristic: meta-sprite set; C0
    dw MetaSprites3F_407ESet15Frame0 ; entry 0
    dw MetaSprites3F_407ESet15Frame1 ; entry 1
    dw MetaSprites3F_407ESet15Frame2 ; entry 2
    dw MetaSprites3F_407ESet15Frame3 ; entry 3
    dw MetaSprites3F_407ESet15Frame4 ; entry 4
    dw MetaSprites3F_407ESet15Frame5 ; entry 5
    dw MetaSprites3F_407ESet15Frame6 ; entry 6
    dw MetaSprites3F_407ESet15Frame7 ; entry 7
    dw MetaSprites3F_407ESet15Frame8 ; entry 8
    dw MetaSprites3F_407ESet15Frame9 ; entry 9
    dw MetaSprites3F_407ESet15Frame10 ; entry 10
    dw MetaSprites3F_407ESet15Frame10 ; entry 11
    dw MetaSprites3F_407ESet15Frame10 ; entry 12
    dw MetaSprites3F_407ESet15Frame10 ; entry 13
    dw MetaSprites3F_407ESet15Frame10 ; entry 14
    dw MetaSprites3F_407ESet15Frame10 ; entry 15
    dw MetaSprites3F_407ESet15Frame10 ; entry 16
    dw MetaSprites3F_407ESet15Frame10 ; entry 17
    dw MetaSprites3F_407ESet15Frame10 ; entry 18
    dw MetaSprites3F_407ESet15Frame10 ; entry 19
    dw MetaSprites3F_407ESet15Frame10 ; entry 20
    dw MetaSprites3F_407ESet15Frame10 ; entry 21
    dw MetaSprites3F_407ESet15Frame10 ; entry 22
    dw MetaSprites3F_407ESet15Frame10 ; entry 23
    dw MetaSprites3F_407ESet15Frame10 ; entry 24
    dw MetaSprites3F_407ESet15Frame10 ; entry 25
    dw MetaSprites3F_407ESet15Frame10 ; entry 26
    dw MetaSprites3F_407ESet15Frame10 ; entry 27
    dw MetaSprites3F_407ESet15Frame10 ; entry 28
    dw MetaSprites3F_407ESet15Frame10 ; entry 29
    dw MetaSprites3F_407ESet15Frame10 ; entry 30
    dw MetaSprites3F_407ESet15Frame10 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3F_407ESet15; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet15Frame0::
Data_03F_5743:: ; heuristic: meta-sprite frame; C0
    db $EA, $02, $01, $00 ; entry 0
    db $E0, $F8, $02, $00 ; entry 1
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3F_407ESet15; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet15Frame1::
Data_03F_574C:: ; heuristic: meta-sprite frame; C0
    db $E0, $0B, $01, $00 ; entry 0
    db $EB, $EE, $01, $00 ; entry 1
    db $EA, $02, $02, $00 ; entry 2
    db $E0, $F8, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3F_407ESet15; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet15Frame2::
Data_03F_575D:: ; heuristic: meta-sprite frame; C0
    db $F0, $10, $01, $00 ; entry 0
    db $DB, $EF, $01, $00 ; entry 1
    db $E0, $0B, $02, $00 ; entry 2
    db $EB, $EC, $02, $00 ; entry 3
    db $EA, $02, $03, $00 ; entry 4
    db $E0, $F8, $04, $00 ; entry 5
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3F_407ESet15; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet15Frame3::
Data_03F_5776:: ; heuristic: meta-sprite frame; C0
    db $DA, $FE, $01, $00 ; entry 0
    db $DD, $F8, $00, $00 ; entry 1
    db $DB, $EF, $02, $00 ; entry 2
    db $F0, $10, $02, $00 ; entry 3
    db $E0, $0B, $03, $00 ; entry 4
    db $EB, $EC, $03, $00 ; entry 5
    db $EA, $02, $04, $00 ; entry 6
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3F_407ESet15; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet15Frame4::
Data_03F_5793:: ; heuristic: meta-sprite frame; C0
    db $D6, $FA, $00, $00 ; entry 0
    db $E7, $01, $00, $00 ; entry 1
    db $E2, $E8, $01, $00 ; entry 2
    db $EB, $FF, $01, $00 ; entry 3
    db $E0, $0B, $04, $00 ; entry 4
    db $EB, $EC, $04, $00 ; entry 5
    db $F0, $10, $03, $00 ; entry 6
    db $DB, $EF, $03, $00 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3F_407ESet15; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet15Frame5::
Data_03F_57B4:: ; heuristic: meta-sprite frame; C0
    db $E2, $00, $00, $00 ; entry 0
    db $DD, $0C, $00, $00 ; entry 1
    db $E8, $EA, $00, $00 ; entry 2
    db $E2, $13, $01, $00 ; entry 3
    db $EF, $E7, $01, $00 ; entry 4
    db $E2, $E6, $02, $00 ; entry 5
    db $F0, $10, $04, $00 ; entry 6
    db $DB, $EF, $04, $00 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3F_407ESet15; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet15Frame6::
Data_03F_57D5:: ; heuristic: meta-sprite frame; C0
    db $D9, $EE, $00, $00 ; entry 0
    db $E5, $E7, $00, $00 ; entry 1
    db $EC, $0F, $00, $00 ; entry 2
    db $ED, $0C, $01, $00 ; entry 3
    db $D8, $E9, $01, $00 ; entry 4
    db $E2, $E7, $03, $00 ; entry 5
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3F_407ESet15; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet15Frame7::
Data_03F_57EE:: ; heuristic: meta-sprite frame; C0
    db $D4, $EC, $00, $00 ; entry 0
    db $E9, $13, $01, $00 ; entry 1
    db $E1, $E8, $04, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites3F_407ESet15; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet15Frame8::
Data_03F_57FB:: ; heuristic: meta-sprite frame; C0
    db $D8, $EF, $00, $00 ; entry 0
    db $DE, $E8, $01, $00 ; entry 1
    db $E0, $F7, $01, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites3F_407ESet15; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet15Frame9::
Data_03F_5808:: ; heuristic: meta-sprite frame; C0
    db $D8, $EA, $01, $00 ; entry 0
    db $80 ; end

; E-0147 (derived: frame 10 of MetaSprites3F_407ESet15; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet15Frame10::
    db $80 ; end

; E-0147 (derived: meta-sprite set 22 of MetaSprites3F_407ETable: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3F_407ESet16::
Data_03F_580E:: ; heuristic: meta-sprite set; C0
    dw MetaSprites3F_407ESet16Frame0 ; entry 0
    dw MetaSprites3F_407ESet16Frame1 ; entry 1
    dw MetaSprites3F_407ESet16Frame2 ; entry 2
    dw MetaSprites3F_407ESet16Frame3 ; entry 3
    dw MetaSprites3F_407ESet16Frame4 ; entry 4
    dw MetaSprites3F_407ESet16Frame5 ; entry 5
    dw MetaSprites3F_407ESet16Frame6 ; entry 6
    dw MetaSprites3F_407ESet16Frame7 ; entry 7
    dw MetaSprites3F_407ESet16Frame8 ; entry 8
    dw MetaSprites3F_407ESet16Frame9 ; entry 9
    dw MetaSprites3F_407ESet16Frame9 ; entry 10
    dw MetaSprites3F_407ESet16Frame9 ; entry 11
    dw MetaSprites3F_407ESet16Frame9 ; entry 12
    dw MetaSprites3F_407ESet16Frame9 ; entry 13
    dw MetaSprites3F_407ESet16Frame9 ; entry 14
    dw MetaSprites3F_407ESet16Frame9 ; entry 15
    dw MetaSprites3F_407ESet16Frame9 ; entry 16
    dw MetaSprites3F_407ESet16Frame9 ; entry 17
    dw MetaSprites3F_407ESet16Frame9 ; entry 18
    dw MetaSprites3F_407ESet16Frame9 ; entry 19
    dw MetaSprites3F_407ESet16Frame9 ; entry 20
    dw MetaSprites3F_407ESet16Frame9 ; entry 21
    dw MetaSprites3F_407ESet16Frame9 ; entry 22
    dw MetaSprites3F_407ESet16Frame9 ; entry 23
    dw MetaSprites3F_407ESet16Frame9 ; entry 24
    dw MetaSprites3F_407ESet16Frame9 ; entry 25
    dw MetaSprites3F_407ESet16Frame9 ; entry 26
    dw MetaSprites3F_407ESet16Frame9 ; entry 27
    dw MetaSprites3F_407ESet16Frame9 ; entry 28
    dw MetaSprites3F_407ESet16Frame9 ; entry 29
    dw MetaSprites3F_407ESet16Frame9 ; entry 30
    dw MetaSprites3F_407ESet16Frame9 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3F_407ESet16; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet16Frame0::
Data_03F_584E:: ; heuristic: meta-sprite frame; C0
    db $E8, $FC, $00, $00 ; entry 0
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3F_407ESet16; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet16Frame1::
Data_03F_5853:: ; heuristic: meta-sprite frame; C0
    db $E7, $FD, $00, $00 ; entry 0
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3F_407ESet16; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet16Frame2::
Data_03F_5858:: ; heuristic: meta-sprite frame; C0
    db $E4, $FA, $00, $00 ; entry 0
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3F_407ESet16; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet16Frame3::
Data_03F_585D:: ; heuristic: meta-sprite frame; C0
    db $E1, $FF, $01, $00 ; entry 0
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3F_407ESet16; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet16Frame4::
Data_03F_5862:: ; heuristic: meta-sprite frame; C0
    db $DD, $F6, $01, $00 ; entry 0
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3F_407ESet16; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet16Frame5::
Data_03F_5867:: ; heuristic: meta-sprite frame; C0
    db $D8, $F8, $02, $00 ; entry 0
    db $D8, $00, $03, $00 ; entry 1
    db $E0, $F8, $04, $00 ; entry 2
    db $E0, $00, $05, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3F_407ESet16; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet16Frame6::
Data_03F_5878:: ; heuristic: meta-sprite frame; C0
    db $D9, $F6, $06, $00 ; entry 0
    db $D9, $02, $06, $20 ; entry 1
    db $E1, $F6, $07, $00 ; entry 2
    db $E1, $FE, $08, $00 ; entry 3
    db $D6, $F8, $02, $00 ; entry 4
    db $D6, $00, $03, $00 ; entry 5
    db $DE, $F8, $04, $00 ; entry 6
    db $DE, $00, $05, $00 ; entry 7
    db $E1, $02, $07, $20 ; entry 8
    db $E1, $FA, $08, $20 ; entry 9
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3F_407ESet16; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet16Frame7::
Data_03F_58A1:: ; heuristic: meta-sprite frame; C0
    db $D8, $F4, $06, $00 ; entry 0
    db $D8, $04, $06, $20 ; entry 1
    db $E0, $F4, $07, $00 ; entry 2
    db $E0, $FC, $08, $00 ; entry 3
    db $E0, $04, $07, $20 ; entry 4
    db $E0, $FC, $08, $20 ; entry 5
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites3F_407ESet16; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet16Frame8::
Data_03F_58BA:: ; heuristic: meta-sprite frame; C0
    db $D2, $FC, $00, $00 ; entry 0
    db $D8, $E8, $06, $00 ; entry 1
    db $D8, $F2, $06, $00 ; entry 2
    db $E0, $E8, $07, $00 ; entry 3
    db $E0, $F0, $08, $00 ; entry 4
    db $E0, $F2, $07, $00 ; entry 5
    db $E0, $FA, $08, $00 ; entry 6
    db $E0, $10, $07, $20 ; entry 7
    db $E0, $08, $08, $20 ; entry 8
    db $D8, $10, $06, $20 ; entry 9
    db $E0, $FE, $08, $20 ; entry 10
    db $D8, $06, $06, $20 ; entry 11
    db $E0, $06, $07, $20 ; entry 12
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites3F_407ESet16; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet16Frame9::
    db $80 ; end

; E-0147 (derived: meta-sprite set 23 of MetaSprites3F_407ETable: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3F_407ESet17::
Data_03F_58F0:: ; heuristic: meta-sprite set; C0
    dw MetaSprites3F_407ESet17Frame0 ; entry 0
    dw MetaSprites3F_407ESet17Frame1 ; entry 1
    dw MetaSprites3F_407ESet17Frame2 ; entry 2
    dw MetaSprites3F_407ESet17Frame3 ; entry 3
    dw MetaSprites3F_407ESet17Frame4 ; entry 4
    dw MetaSprites3F_407ESet17Frame5 ; entry 5
    dw MetaSprites3F_407ESet17Frame6 ; entry 6
    dw MetaSprites3F_407ESet17Frame6 ; entry 7
    dw MetaSprites3F_407ESet17Frame6 ; entry 8
    dw MetaSprites3F_407ESet17Frame6 ; entry 9
    dw MetaSprites3F_407ESet17Frame6 ; entry 10
    dw MetaSprites3F_407ESet17Frame6 ; entry 11
    dw MetaSprites3F_407ESet17Frame6 ; entry 12
    dw MetaSprites3F_407ESet17Frame6 ; entry 13
    dw MetaSprites3F_407ESet17Frame6 ; entry 14
    dw MetaSprites3F_407ESet17Frame6 ; entry 15
    dw MetaSprites3F_407ESet17Frame6 ; entry 16
    dw MetaSprites3F_407ESet17Frame6 ; entry 17
    dw MetaSprites3F_407ESet17Frame6 ; entry 18
    dw MetaSprites3F_407ESet17Frame6 ; entry 19
    dw MetaSprites3F_407ESet17Frame6 ; entry 20
    dw MetaSprites3F_407ESet17Frame6 ; entry 21
    dw MetaSprites3F_407ESet17Frame6 ; entry 22
    dw MetaSprites3F_407ESet17Frame6 ; entry 23
    dw MetaSprites3F_407ESet17Frame6 ; entry 24
    dw MetaSprites3F_407ESet17Frame6 ; entry 25
    dw MetaSprites3F_407ESet17Frame6 ; entry 26
    dw MetaSprites3F_407ESet17Frame6 ; entry 27
    dw MetaSprites3F_407ESet17Frame6 ; entry 28
    dw MetaSprites3F_407ESet17Frame6 ; entry 29
    dw MetaSprites3F_407ESet17Frame6 ; entry 30
    dw MetaSprites3F_407ESet17Frame6 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3F_407ESet17; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet17Frame0::
Data_03F_5930:: ; heuristic: meta-sprite frame; C0
    db $F0, $E8, $0A, $60 ; entry 0
    db $D8, $F0, $0A, $00 ; entry 1
    db $D8, $F8, $10, $40 ; entry 2
    db $D8, $E8, $05, $20 ; entry 3
    db $D8, $E0, $0A, $60 ; entry 4
    db $D8, $00, $11, $40 ; entry 5
    db $D8, $D8, $0E, $00 ; entry 6
    db $F0, $F0, $01, $00 ; entry 7
    db $E8, $E8, $17, $60 ; entry 8
    db $E8, $F0, $16, $00 ; entry 9
    db $E0, $00, $16, $00 ; entry 10
    db $E0, $08, $16, $60 ; entry 11
    db $E0, $10, $0C, $40 ; entry 12
    db $E0, $18, $0F, $00 ; entry 13
    db $F8, $00, $17, $00 ; entry 14
    db $F8, $F8, $0C, $20 ; entry 15
    db $F0, $E0, $11, $20 ; entry 16
    db $F8, $F0, $10, $40 ; entry 17
    db $F8, $E8, $0F, $60 ; entry 18
    db $E0, $F0, $00, $00 ; entry 19
    db $E0, $F8, $00, $00 ; entry 20
    db $D0, $F0, $10, $40 ; entry 21
    db $D0, $E8, $0F, $60 ; entry 22
    db $D0, $F8, $11, $40 ; entry 23
    db $F0, $08, $05, $40 ; entry 24
    db $F0, $10, $06, $40 ; entry 25
    db $F0, $18, $07, $40 ; entry 26
    db $E8, $00, $0C, $40 ; entry 27
    db $F0, $00, $16, $60 ; entry 28
    db $E8, $08, $0F, $00 ; entry 29
    db $F0, $F8, $00, $00 ; entry 30
    db $E8, $F8, $00, $00 ; entry 31
    db $E0, $E0, $0A, $60 ; entry 32
    db $E0, $E8, $00, $00 ; entry 33
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3F_407ESet17; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet17Frame1::
Data_03F_59B9:: ; heuristic: meta-sprite frame; C0
    db $F8, $00, $17, $00 ; entry 0
    db $F8, $F0, $19, $20 ; entry 1
    db $F8, $F8, $16, $00 ; entry 2
    db $F0, $F0, $0A, $60 ; entry 3
    db $F0, $F8, $01, $00 ; entry 4
    db $F0, $E8, $0E, $00 ; entry 5
    db $F0, $08, $16, $60 ; entry 6
    db $F0, $00, $00, $00 ; entry 7
    db $F0, $10, $0C, $40 ; entry 8
    db $F0, $18, $0D, $40 ; entry 9
    db $E8, $08, $07, $40 ; entry 10
    db $E8, $E8, $19, $20 ; entry 11
    db $E8, $F0, $15, $20 ; entry 12
    db $E8, $00, $17, $00 ; entry 13
    db $E8, $F8, $00, $00 ; entry 14
    db $D8, $08, $11, $40 ; entry 15
    db $E0, $08, $16, $60 ; entry 16
    db $D8, $00, $0A, $00 ; entry 17
    db $E0, $00, $00, $00 ; entry 18
    db $D8, $F8, $16, $00 ; entry 19
    db $E0, $F8, $09, $20 ; entry 20
    db $D8, $F0, $18, $60 ; entry 21
    db $E0, $10, $17, $00 ; entry 22
    db $D8, $E4, $03, $00 ; entry 23
    db $D8, $DC, $07, $20 ; entry 24
    db $E0, $E8, $0F, $00 ; entry 25
    db $D0, $F0, $0A, $00 ; entry 26
    db $D0, $00, $07, $40 ; entry 27
    db $D0, $F8, $18, $00 ; entry 28
    db $D0, $E8, $17, $60 ; entry 29
    db $E0, $18, $03, $00 ; entry 30
    db $F0, $D8, $11, $20 ; entry 31
    db $F0, $E0, $0E, $00 ; entry 32
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3F_407ESet17; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet17Frame2::
Data_03F_5A3E:: ; heuristic: meta-sprite frame; C0
    db $E8, $E8, $0A, $60 ; entry 0
    db $E8, $00, $05, $40 ; entry 1
    db $E8, $08, $06, $40 ; entry 2
    db $E8, $10, $07, $40 ; entry 3
    db $D0, $00, $11, $40 ; entry 4
    db $E8, $F0, $01, $00 ; entry 5
    db $E8, $F8, $16, $60 ; entry 6
    db $E0, $E8, $17, $60 ; entry 7
    db $F0, $00, $17, $00 ; entry 8
    db $F0, $F8, $0C, $20 ; entry 9
    db $F8, $F8, $00, $00 ; entry 10
    db $F8, $00, $01, $00 ; entry 11
    db $F8, $F0, $13, $20 ; entry 12
    db $F0, $F0, $0F, $60 ; entry 13
    db $F8, $08, $14, $00 ; entry 14
    db $D8, $00, $16, $60 ; entry 15
    db $D8, $08, $0C, $40 ; entry 16
    db $D8, $10, $0F, $00 ; entry 17
    db $D0, $F8, $0A, $00 ; entry 18
    db $D0, $E8, $0A, $60 ; entry 19
    db $D0, $E0, $0E, $00 ; entry 20
    db $D8, $F8, $00, $00 ; entry 21
    db $D8, $E8, $07, $20 ; entry 22
    db $E8, $D8, $11, $20 ; entry 23
    db $E8, $E0, $0E, $00 ; entry 24
    db $D8, $F0, $17, $60 ; entry 25
    db $E0, $F0, $00, $00 ; entry 26
    db $E0, $F8, $08, $00 ; entry 27
    db $D0, $F0, $16, $00 ; entry 28
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3F_407ESet17; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet17Frame3::
Data_03F_5AB3:: ; heuristic: meta-sprite frame; C0
    db $E8, $F8, $16, $60 ; entry 0
    db $F8, $F8, $00, $00 ; entry 1
    db $F8, $F0, $17, $60 ; entry 2
    db $F0, $F8, $19, $20 ; entry 3
    db $F0, $F0, $03, $60 ; entry 4
    db $F7, $E9, $0E, $00 ; entry 5
    db $E8, $F0, $18, $60 ; entry 6
    db $E0, $F8, $0A, $00 ; entry 7
    db $E0, $F0, $06, $20 ; entry 8
    db $E0, $E8, $07, $20 ; entry 9
    db $E0, $00, $03, $40 ; entry 10
    db $D8, $00, $01, $00 ; entry 11
    db $D8, $F0, $03, $60 ; entry 12
    db $D8, $F8, $02, $60 ; entry 13
    db $D0, $00, $06, $40 ; entry 14
    db $D0, $08, $07, $40 ; entry 15
    db $D8, $08, $17, $00 ; entry 16
    db $D0, $F8, $19, $20 ; entry 17
    db $D0, $F0, $03, $60 ; entry 18
    db $D0, $EC, $07, $00 ; entry 19
    db $D0, $E4, $03, $20 ; entry 20
    db $E8, $00, $14, $00 ; entry 21
    db $F0, $00, $15, $40 ; entry 22
    db $F8, $00, $06, $40 ; entry 23
    db $E8, $E8, $07, $20 ; entry 24
    db $E8, $E0, $07, $00 ; entry 25
    db $E8, $D8, $03, $20 ; entry 26
    db $E8, $08, $07, $60 ; entry 27
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3F_407ESet17; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet17Frame4::
Data_03F_5B24:: ; heuristic: meta-sprite frame; C0
    db $F0, $08, $0A, $40 ; entry 0
    db $F0, $00, $01, $20 ; entry 1
    db $F0, $10, $11, $00 ; entry 2
    db $E0, $00, $0A, $40 ; entry 3
    db $E0, $08, $10, $00 ; entry 4
    db $E8, $00, $17, $40 ; entry 5
    db $D0, $00, $10, $60 ; entry 6
    db $D0, $08, $19, $00 ; entry 7
    db $F0, $F8, $06, $60 ; entry 8
    db $F0, $F0, $07, $60 ; entry 9
    db $E0, $F8, $16, $20 ; entry 10
    db $F8, $F8, $17, $20 ; entry 11
    db $F8, $00, $0C, $00 ; entry 12
    db $F8, $08, $11, $40 ; entry 13
    db $F8, $E8, $10, $40 ; entry 14
    db $D8, $F8, $19, $20 ; entry 15
    db $D8, $00, $15, $20 ; entry 16
    db $D8, $08, $00, $00 ; entry 17
    db $D8, $10, $12, $00 ; entry 18
    db $E0, $F0, $0C, $60 ; entry 19
    db $E0, $E8, $0F, $20 ; entry 20
    db $E8, $F8, $19, $60 ; entry 21
    db $F8, $E0, $03, $60 ; entry 22
    db $F8, $F0, $07, $40 ; entry 23
    db $F0, $E0, $07, $60 ; entry 24
    db $F0, $E8, $03, $40 ; entry 25
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3F_407ESet17; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet17Frame5::
Data_03F_5B8D:: ; heuristic: meta-sprite frame; C0
    db $E0, $F8, $16, $00 ; entry 0
    db $F8, $00, $08, $00 ; entry 1
    db $F8, $F0, $0E, $60 ; entry 2
    db $F8, $F8, $02, $60 ; entry 3
    db $F8, $E8, $03, $60 ; entry 4
    db $F0, $08, $17, $40 ; entry 5
    db $F0, $00, $16, $40 ; entry 6
    db $E8, $F8, $02, $00 ; entry 7
    db $E8, $00, $03, $00 ; entry 8
    db $F0, $F8, $00, $00 ; entry 9
    db $F0, $F0, $06, $20 ; entry 10
    db $F0, $E8, $07, $20 ; entry 11
    db $E8, $F0, $09, $20 ; entry 12
    db $E0, $00, $05, $40 ; entry 13
    db $E0, $10, $03, $00 ; entry 14
    db $E0, $08, $02, $00 ; entry 15
    db $E0, $E8, $10, $20 ; entry 16
    db $E0, $F0, $06, $20 ; entry 17
    db $E0, $E0, $07, $20 ; entry 18
    db $D8, $F8, $00, $00 ; entry 19
    db $D8, $00, $17, $00 ; entry 20
    db $D8, $08, $03, $00 ; entry 21
    db $D8, $E8, $06, $20 ; entry 22
    db $D8, $E0, $07, $20 ; entry 23
    db $D8, $F0, $16, $00 ; entry 24
    db $D0, $08, $07, $40 ; entry 25
    db $D0, $F8, $10, $60 ; entry 26
    db $D0, $00, $10, $60 ; entry 27
    db $D0, $F0, $03, $60 ; entry 28
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3F_407ESet17; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet17Frame6::
    db $80 ; end

; E-0147 (derived: meta-sprite set 24 of MetaSprites3F_407ETable: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3F_407ESet18::
Data_03F_5C03:: ; heuristic: meta-sprite set; C0
    dw MetaSprites3F_407ESet18Frame0 ; entry 0
    dw MetaSprites3F_407ESet18Frame1 ; entry 1
    dw MetaSprites3F_407ESet18Frame2 ; entry 2
    dw MetaSprites3F_407ESet18Frame3 ; entry 3
    dw MetaSprites3F_407ESet18Frame4 ; entry 4
    dw MetaSprites3F_407ESet18Frame5 ; entry 5
    dw MetaSprites3F_407ESet18Frame6 ; entry 6
    dw MetaSprites3F_407ESet18Frame7 ; entry 7
    dw MetaSprites3F_407ESet18Frame8 ; entry 8
    dw MetaSprites3F_407ESet18Frame8 ; entry 9
    dw MetaSprites3F_407ESet18Frame8 ; entry 10
    dw MetaSprites3F_407ESet18Frame8 ; entry 11
    dw MetaSprites3F_407ESet18Frame8 ; entry 12
    dw MetaSprites3F_407ESet18Frame8 ; entry 13
    dw MetaSprites3F_407ESet18Frame8 ; entry 14
    dw MetaSprites3F_407ESet18Frame8 ; entry 15
    dw MetaSprites3F_407ESet18Frame8 ; entry 16
    dw MetaSprites3F_407ESet18Frame8 ; entry 17
    dw MetaSprites3F_407ESet18Frame8 ; entry 18
    dw MetaSprites3F_407ESet18Frame8 ; entry 19
    dw MetaSprites3F_407ESet18Frame8 ; entry 20
    dw MetaSprites3F_407ESet18Frame8 ; entry 21
    dw MetaSprites3F_407ESet18Frame8 ; entry 22
    dw MetaSprites3F_407ESet18Frame8 ; entry 23
    dw MetaSprites3F_407ESet18Frame8 ; entry 24
    dw MetaSprites3F_407ESet18Frame8 ; entry 25
    dw MetaSprites3F_407ESet18Frame8 ; entry 26
    dw MetaSprites3F_407ESet18Frame8 ; entry 27
    dw MetaSprites3F_407ESet18Frame8 ; entry 28
    dw MetaSprites3F_407ESet18Frame8 ; entry 29
    dw MetaSprites3F_407ESet18Frame8 ; entry 30
    dw MetaSprites3F_407ESet18Frame8 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3F_407ESet18; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet18Frame0::
Data_03F_5C43:: ; heuristic: meta-sprite frame; C0
    db $E8, $F8, $00, $10 ; entry 0
    db $E8, $00, $01, $10 ; entry 1
    db $F0, $F8, $02, $10 ; entry 2
    db $F0, $00, $03, $10 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3F_407ESet18; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet18Frame1::
Data_03F_5C54:: ; heuristic: meta-sprite frame; C0
    db $E2, $F3, $00, $10 ; entry 0
    db $E2, $FB, $04, $10 ; entry 1
    db $E2, $03, $01, $10 ; entry 2
    db $EA, $F3, $06, $10 ; entry 3
    db $EA, $FB, $07, $10 ; entry 4
    db $EA, $03, $14, $10 ; entry 5
    db $F2, $F3, $0A, $10 ; entry 6
    db $F2, $FB, $0B, $10 ; entry 7
    db $F2, $03, $0C, $10 ; entry 8
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3F_407ESet18; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet18Frame2::
Data_03F_5C79:: ; heuristic: meta-sprite frame; C0
    db $E2, $F0, $0D, $10 ; entry 0
    db $E2, $F8, $0E, $10 ; entry 1
    db $E2, $00, $0F, $10 ; entry 2
    db $E2, $08, $10, $10 ; entry 3
    db $EA, $F0, $11, $10 ; entry 4
    db $EA, $F8, $12, $10 ; entry 5
    db $EA, $00, $13, $10 ; entry 6
    db $EA, $08, $14, $10 ; entry 7
    db $F2, $F0, $15, $10 ; entry 8
    db $F2, $F8, $16, $10 ; entry 9
    db $F2, $00, $17, $10 ; entry 10
    db $F2, $08, $18, $10 ; entry 11
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3F_407ESet18; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet18Frame3::
Data_03F_5CAA:: ; heuristic: meta-sprite frame; C0
    db $D4, $EC, $0D, $10 ; entry 0
    db $D4, $F4, $0E, $10 ; entry 1
    db $D4, $FC, $0F, $10 ; entry 2
    db $D4, $04, $0E, $10 ; entry 3
    db $D4, $0C, $10, $10 ; entry 4
    db $DC, $EC, $11, $10 ; entry 5
    db $DC, $F4, $12, $10 ; entry 6
    db $DC, $FC, $13, $10 ; entry 7
    db $DC, $04, $12, $10 ; entry 8
    db $DC, $0C, $1A, $10 ; entry 9
    db $E4, $EC, $1B, $10 ; entry 10
    db $E4, $F4, $1C, $10 ; entry 11
    db $E4, $FC, $1D, $10 ; entry 12
    db $E4, $04, $1D, $10 ; entry 13
    db $E4, $0C, $1E, $10 ; entry 14
    db $E2, $14, $09, $10 ; entry 15
    db $EC, $EC, $1F, $10 ; entry 16
    db $EC, $F4, $20, $10 ; entry 17
    db $EC, $FC, $13, $10 ; entry 18
    db $EC, $04, $12, $10 ; entry 19
    db $EC, $0C, $21, $10 ; entry 20
    db $F4, $EC, $15, $10 ; entry 21
    db $F4, $F4, $16, $10 ; entry 22
    db $F4, $FC, $17, $10 ; entry 23
    db $F4, $04, $22, $10 ; entry 24
    db $F4, $0C, $23, $10 ; entry 25
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3F_407ESet18; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet18Frame4::
Data_03F_5D13:: ; heuristic: meta-sprite frame; C0
    db $D0, $E8, $0D, $10 ; entry 0
    db $D0, $F0, $0E, $10 ; entry 1
    db $D0, $F8, $01, $10 ; entry 2
    db $D0, $10, $01, $10 ; entry 3
    db $E8, $10, $01, $10 ; entry 4
    db $D0, $00, $00, $10 ; entry 5
    db $E8, $08, $00, $10 ; entry 6
    db $F0, $08, $02, $10 ; entry 7
    db $F0, $10, $03, $10 ; entry 8
    db $D8, $F8, $23, $10 ; entry 9
    db $D0, $08, $04, $10 ; entry 10
    db $D8, $00, $06, $10 ; entry 11
    db $D8, $08, $07, $10 ; entry 12
    db $D8, $F0, $07, $10 ; entry 13
    db $D8, $E8, $11, $10 ; entry 14
    db $F0, $E8, $11, $10 ; entry 15
    db $F0, $F0, $12, $10 ; entry 16
    db $F0, $F8, $13, $10 ; entry 17
    db $F0, $00, $14, $10 ; entry 18
    db $F8, $E8, $15, $10 ; entry 19
    db $F8, $F0, $16, $10 ; entry 20
    db $F8, $F8, $17, $10 ; entry 21
    db $F8, $00, $18, $10 ; entry 22
    db $E8, $E8, $0D, $10 ; entry 23
    db $E8, $F0, $0E, $10 ; entry 24
    db $E8, $F8, $0F, $10 ; entry 25
    db $E8, $00, $10, $10 ; entry 26
    db $D8, $10, $14, $10 ; entry 27
    db $E0, $00, $0A, $10 ; entry 28
    db $E0, $08, $0B, $10 ; entry 29
    db $E0, $10, $0C, $10 ; entry 30
    db $E0, $E8, $15, $10 ; entry 31
    db $E0, $F0, $18, $10 ; entry 32
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3F_407ESet18; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet18Frame5::
Data_03F_5D98:: ; heuristic: meta-sprite frame; C0
    db $D0, $E8, $00, $10 ; entry 0
    db $D0, $F0, $01, $10 ; entry 1
    db $F0, $08, $00, $10 ; entry 2
    db $F0, $10, $01, $10 ; entry 3
    db $EA, $E8, $00, $10 ; entry 4
    db $EA, $F8, $01, $10 ; entry 5
    db $F8, $08, $02, $10 ; entry 6
    db $F8, $10, $03, $10 ; entry 7
    db $D8, $F0, $03, $10 ; entry 8
    db $EA, $F0, $04, $10 ; entry 9
    db $D0, $08, $04, $10 ; entry 10
    db $D0, $10, $01, $10 ; entry 11
    db $D8, $00, $0A, $10 ; entry 12
    db $FA, $E8, $0A, $10 ; entry 13
    db $D8, $08, $0B, $10 ; entry 14
    db $D8, $10, $0C, $10 ; entry 15
    db $FA, $F0, $0B, $10 ; entry 16
    db $FA, $F8, $0C, $10 ; entry 17
    db $D8, $E8, $11, $10 ; entry 18
    db $E0, $E8, $0A, $10 ; entry 19
    db $E0, $F0, $0A, $30 ; entry 20
    db $D0, $00, $0A, $50 ; entry 21
    db $F2, $E8, $06, $10 ; entry 22
    db $F2, $F0, $07, $10 ; entry 23
    db $F2, $F8, $14, $10 ; entry 24
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3F_407ESet18; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet18Frame6::
Data_03F_5DFD:: ; heuristic: meta-sprite frame; C0
    db $E8, $F8, $00, $10 ; entry 0
    db $E8, $00, $01, $10 ; entry 1
    db $CC, $07, $00, $10 ; entry 2
    db $CC, $0F, $01, $10 ; entry 3
    db $CD, $E7, $00, $10 ; entry 4
    db $CD, $EF, $01, $10 ; entry 5
    db $F0, $E8, $00, $10 ; entry 6
    db $F0, $F0, $00, $30 ; entry 7
    db $FB, $11, $00, $70 ; entry 8
    db $E0, $10, $00, $30 ; entry 9
    db $D4, $07, $02, $10 ; entry 10
    db $D4, $0F, $03, $10 ; entry 11
    db $F0, $F8, $02, $10 ; entry 12
    db $F0, $00, $03, $10 ; entry 13
    db $F8, $E8, $03, $30 ; entry 14
    db $F3, $11, $01, $10 ; entry 15
    db $E7, $0F, $0C, $10 ; entry 16
    db $D5, $E7, $0C, $30 ; entry 17
    db $D5, $EF, $00, $70 ; entry 18
    db $FB, $09, $0A, $10 ; entry 19
    db $E8, $08, $0A, $10 ; entry 20
    db $F4, $09, $0A, $50 ; entry 21
    db $E0, $08, $0A, $50 ; entry 22
    db $F8, $F0, $11, $30 ; entry 23
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3F_407ESet18; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet18Frame7::
Data_03F_5E5E:: ; heuristic: meta-sprite frame; C0
    db $EB, $FB, $00, $10 ; entry 0
    db $EB, $03, $01, $10 ; entry 1
    db $F3, $03, $00, $70 ; entry 2
    db $F3, $FB, $0C, $30 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites3F_407ESet18; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet18Frame8::
    db $80 ; end

; E-0147 (derived: meta-sprite set 25 of MetaSprites3F_407ETable: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3F_407ESet19::
Data_03F_5E70:: ; heuristic: meta-sprite set; C0
    dw MetaSprites3F_407ESet19Frame0 ; entry 0
    dw MetaSprites3F_407ESet19Frame1 ; entry 1
    dw MetaSprites3F_407ESet19Frame1 ; entry 2
    dw MetaSprites3F_407ESet19Frame1 ; entry 3
    dw MetaSprites3F_407ESet19Frame1 ; entry 4
    dw MetaSprites3F_407ESet19Frame1 ; entry 5
    dw MetaSprites3F_407ESet19Frame1 ; entry 6
    dw MetaSprites3F_407ESet19Frame2 ; entry 7
    dw MetaSprites3F_407ESet19Frame3 ; entry 8
    dw MetaSprites3F_407ESet19Frame3 ; entry 9
    dw MetaSprites3F_407ESet19Frame3 ; entry 10
    dw MetaSprites3F_407ESet19Frame3 ; entry 11
    dw MetaSprites3F_407ESet19Frame3 ; entry 12
    dw MetaSprites3F_407ESet19Frame3 ; entry 13
    dw MetaSprites3F_407ESet19Frame3 ; entry 14
    dw MetaSprites3F_407ESet19Frame3 ; entry 15
    dw MetaSprites3F_407ESet19Frame3 ; entry 16
    dw MetaSprites3F_407ESet19Frame3 ; entry 17
    dw MetaSprites3F_407ESet19Frame3 ; entry 18
    dw MetaSprites3F_407ESet19Frame3 ; entry 19
    dw MetaSprites3F_407ESet19Frame3 ; entry 20
    dw MetaSprites3F_407ESet19Frame3 ; entry 21
    dw MetaSprites3F_407ESet19Frame3 ; entry 22
    dw MetaSprites3F_407ESet19Frame3 ; entry 23
    dw MetaSprites3F_407ESet19Frame3 ; entry 24
    dw MetaSprites3F_407ESet19Frame3 ; entry 25
    dw MetaSprites3F_407ESet19Frame3 ; entry 26
    dw MetaSprites3F_407ESet19Frame3 ; entry 27
    dw MetaSprites3F_407ESet19Frame3 ; entry 28
    dw MetaSprites3F_407ESet19Frame3 ; entry 29
    dw MetaSprites3F_407ESet19Frame3 ; entry 30
    dw MetaSprites3F_407ESet19Frame3 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3F_407ESet19; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet19Frame0::
Data_03F_5EB0:: ; heuristic: meta-sprite frame; C0
    db $D0, $E8, $00, $10 ; entry 0
    db $D0, $F0, $01, $10 ; entry 1
    db $D0, $F8, $02, $10 ; entry 2
    db $D0, $00, $03, $10 ; entry 3
    db $D0, $08, $04, $10 ; entry 4
    db $D0, $10, $05, $10 ; entry 5
    db $D8, $E8, $06, $10 ; entry 6
    db $D8, $F0, $07, $10 ; entry 7
    db $D8, $F8, $08, $10 ; entry 8
    db $D8, $00, $09, $10 ; entry 9
    db $D8, $08, $0A, $10 ; entry 10
    db $D8, $10, $0B, $10 ; entry 11
    db $E0, $E8, $01, $10 ; entry 12
    db $E0, $F0, $02, $10 ; entry 13
    db $E0, $F8, $03, $10 ; entry 14
    db $E0, $00, $0C, $10 ; entry 15
    db $E0, $08, $05, $10 ; entry 16
    db $E0, $10, $00, $10 ; entry 17
    db $E8, $10, $00, $10 ; entry 18
    db $F0, $10, $00, $10 ; entry 19
    db $F8, $10, $00, $10 ; entry 20
    db $F8, $08, $00, $10 ; entry 21
    db $F0, $08, $00, $10 ; entry 22
    db $F8, $F8, $00, $10 ; entry 23
    db $E8, $E8, $07, $10 ; entry 24
    db $E8, $F0, $08, $10 ; entry 25
    db $E8, $F8, $0D, $10 ; entry 26
    db $E8, $00, $00, $10 ; entry 27
    db $E8, $08, $0B, $10 ; entry 28
    db $F0, $E8, $02, $10 ; entry 29
    db $F0, $F0, $0E, $10 ; entry 30
    db $F0, $F8, $0F, $10 ; entry 31
    db $F0, $00, $10, $10 ; entry 32
    db $F8, $F0, $11, $10 ; entry 33
    db $F8, $E8, $0B, $10 ; entry 34
    db $F8, $00, $0B, $10 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3F_407ESet19; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet19Frame1::
Data_03F_5F41:: ; heuristic: meta-sprite frame; C0
    db $D0, $E8, $50, $10 ; entry 0
    db $D0, $F0, $51, $10 ; entry 1
    db $D0, $F8, $52, $10 ; entry 2
    db $D0, $00, $53, $10 ; entry 3
    db $D0, $08, $54, $10 ; entry 4
    db $D0, $10, $55, $10 ; entry 5
    db $D8, $E8, $60, $10 ; entry 6
    db $D8, $F0, $61, $10 ; entry 7
    db $D8, $F8, $62, $10 ; entry 8
    db $D8, $00, $63, $10 ; entry 9
    db $D8, $08, $64, $10 ; entry 10
    db $D8, $10, $65, $10 ; entry 11
    db $E0, $E8, $70, $10 ; entry 12
    db $E0, $F0, $71, $10 ; entry 13
    db $E0, $F8, $72, $10 ; entry 14
    db $E0, $00, $73, $10 ; entry 15
    db $E0, $08, $74, $10 ; entry 16
    db $E0, $10, $75, $10 ; entry 17
    db $E8, $E8, $80, $10 ; entry 18
    db $E8, $F0, $81, $10 ; entry 19
    db $E8, $F8, $82, $10 ; entry 20
    db $E8, $00, $83, $10 ; entry 21
    db $E8, $08, $84, $10 ; entry 22
    db $E8, $10, $85, $10 ; entry 23
    db $F0, $E8, $90, $10 ; entry 24
    db $F0, $F0, $91, $10 ; entry 25
    db $F0, $F8, $92, $10 ; entry 26
    db $F0, $00, $93, $10 ; entry 27
    db $F0, $08, $94, $10 ; entry 28
    db $F0, $10, $95, $10 ; entry 29
    db $F8, $E8, $A0, $10 ; entry 30
    db $F8, $F0, $A1, $10 ; entry 31
    db $F8, $F8, $A2, $10 ; entry 32
    db $F8, $00, $A3, $10 ; entry 33
    db $F8, $08, $A4, $10 ; entry 34
    db $F8, $10, $A5, $10 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3F_407ESet19; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet19Frame2::
Data_03F_5FD2:: ; heuristic: meta-sprite frame; C0
    db $D8, $E8, $50, $10 ; entry 0
    db $D8, $F0, $51, $10 ; entry 1
    db $D8, $F8, $52, $10 ; entry 2
    db $D8, $00, $53, $10 ; entry 3
    db $D8, $08, $54, $10 ; entry 4
    db $D8, $10, $55, $10 ; entry 5
    db $E0, $E8, $60, $10 ; entry 6
    db $E0, $F0, $61, $10 ; entry 7
    db $E0, $F8, $62, $10 ; entry 8
    db $E0, $00, $63, $10 ; entry 9
    db $E0, $08, $64, $10 ; entry 10
    db $E0, $10, $65, $10 ; entry 11
    db $E8, $E8, $70, $10 ; entry 12
    db $E8, $F0, $71, $10 ; entry 13
    db $E8, $F8, $72, $10 ; entry 14
    db $E8, $00, $73, $10 ; entry 15
    db $E8, $08, $74, $10 ; entry 16
    db $E8, $10, $75, $10 ; entry 17
    db $F0, $E8, $80, $10 ; entry 18
    db $F0, $F0, $81, $10 ; entry 19
    db $F0, $F8, $82, $10 ; entry 20
    db $F0, $00, $83, $10 ; entry 21
    db $F0, $08, $84, $10 ; entry 22
    db $F0, $10, $85, $10 ; entry 23
    db $F8, $E8, $90, $10 ; entry 24
    db $F8, $F0, $91, $10 ; entry 25
    db $F8, $F8, $92, $10 ; entry 26
    db $F8, $00, $93, $10 ; entry 27
    db $F8, $08, $94, $10 ; entry 28
    db $F8, $10, $95, $10 ; entry 29
    db $D0, $E8, $88, $10 ; entry 30
    db $D0, $F0, $88, $10 ; entry 31
    db $D0, $F8, $88, $10 ; entry 32
    db $D0, $00, $88, $10 ; entry 33
    db $D0, $08, $88, $10 ; entry 34
    db $D0, $10, $88, $10 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3F_407ESet19; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet19Frame3::
    db $80 ; end

; E-0147 (derived: meta-sprite set 26 of MetaSprites3F_407ETable: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3F_407ESet1A::
Data_03F_6064:: ; heuristic: meta-sprite set; C0
    dw MetaSprites3F_407ESet1AFrame0 ; entry 0
    dw MetaSprites3F_407ESet1AFrame1 ; entry 1
    dw MetaSprites3F_407ESet1AFrame2 ; entry 2
    dw MetaSprites3F_407ESet1AFrame3 ; entry 3
    dw MetaSprites3F_407ESet1AFrame4 ; entry 4
    dw MetaSprites3F_407ESet1AFrame5 ; entry 5
    dw MetaSprites3F_407ESet1AFrame6 ; entry 6
    dw MetaSprites3F_407ESet1AFrame7 ; entry 7
    dw MetaSprites3F_407ESet1AFrame8 ; entry 8
    dw MetaSprites3F_407ESet1AFrame9 ; entry 9
    dw MetaSprites3F_407ESet1AFrame10 ; entry 10
    dw MetaSprites3F_407ESet1AFrame11 ; entry 11
    dw MetaSprites3F_407ESet1AFrame12 ; entry 12
    dw MetaSprites3F_407ESet1AFrame13 ; entry 13
    dw MetaSprites3F_407ESet1AFrame14 ; entry 14
    dw MetaSprites3F_407ESet1AFrame15 ; entry 15
    dw MetaSprites3F_407ESet1AFrame16 ; entry 16
    dw MetaSprites3F_407ESet1AFrame17 ; entry 17
    dw MetaSprites3F_407ESet1AFrame18 ; entry 18
    dw MetaSprites3F_407ESet1AFrame19 ; entry 19
    dw MetaSprites3F_407ESet1AFrame19 ; entry 20
    dw MetaSprites3F_407ESet1AFrame19 ; entry 21
    dw MetaSprites3F_407ESet1AFrame19 ; entry 22
    dw MetaSprites3F_407ESet1AFrame19 ; entry 23
    dw MetaSprites3F_407ESet1AFrame19 ; entry 24
    dw MetaSprites3F_407ESet1AFrame19 ; entry 25
    dw MetaSprites3F_407ESet1AFrame19 ; entry 26
    dw MetaSprites3F_407ESet1AFrame19 ; entry 27
    dw MetaSprites3F_407ESet1AFrame19 ; entry 28
    dw MetaSprites3F_407ESet1AFrame19 ; entry 29
    dw MetaSprites3F_407ESet1AFrame19 ; entry 30
    dw MetaSprites3F_407ESet1AFrame19 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3F_407ESet1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1AFrame0::
Data_03F_60A4:: ; heuristic: meta-sprite frame; C0
    db $D0, $01, $2E, $00 ; entry 0
    db $D8, $01, $2E, $60 ; entry 1
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3F_407ESet1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1AFrame1::
Data_03F_60AD:: ; heuristic: meta-sprite frame; C0
    db $E0, $FC, $2E, $00 ; entry 0
    db $E8, $FC, $2E, $60 ; entry 1
    db $F0, $F7, $2E, $00 ; entry 2
    db $F8, $F7, $2E, $60 ; entry 3
    db $D0, $01, $2E, $00 ; entry 4
    db $D8, $01, $2E, $60 ; entry 5
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3F_407ESet1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1AFrame2::
Data_03F_60C6:: ; heuristic: meta-sprite frame; C0
    db $F0, $F7, $2E, $00 ; entry 0
    db $F8, $F7, $2E, $60 ; entry 1
    db $E8, $FC, $2F, $60 ; entry 2
    db $E0, $FC, $2F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3F_407ESet1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1AFrame3::
Data_03F_60D7:: ; heuristic: meta-sprite frame; C0
    db $D0, $D8, $00, $00 ; entry 0
    db $D4, $EC, $02, $00 ; entry 1
    db $D0, $F8, $04, $00 ; entry 2
    db $E0, $D8, $02, $00 ; entry 3
    db $D0, $08, $00, $00 ; entry 4
    db $D4, $1C, $02, $60 ; entry 5
    db $D0, $28, $04, $40 ; entry 6
    db $D0, $B8, $00, $00 ; entry 7
    db $D0, $38, $02, $00 ; entry 8
    db $DC, $F4, $01, $00 ; entry 9
    db $E0, $32, $00, $00 ; entry 10
    db $D4, $C9, $02, $60 ; entry 11
    db $D8, $07, $02, $00 ; entry 12
    db $E0, $06, $00, $00 ; entry 13
    db $DC, $C8, $01, $00 ; entry 14
    db $D8, $27, $00, $00 ; entry 15
    db $D0, $14, $03, $00 ; entry 16
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3F_407ESet1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1AFrame4::
Data_03F_611C:: ; heuristic: meta-sprite frame; C0
    db $E0, $D8, $02, $00 ; entry 0
    db $E4, $E9, $02, $00 ; entry 1
    db $EC, $F1, $01, $00 ; entry 2
    db $F0, $04, $02, $00 ; entry 3
    db $E0, $06, $01, $00 ; entry 4
    db $E8, $05, $01, $00 ; entry 5
    db $E4, $C7, $02, $60 ; entry 6
    db $EC, $C6, $01, $00 ; entry 7
    db $E0, $B6, $00, $00 ; entry 8
    db $D8, $D7, $00, $00 ; entry 9
    db $E0, $36, $02, $00 ; entry 10
    db $F0, $30, $00, $20 ; entry 11
    db $E0, $12, $03, $40 ; entry 12
    db $E0, $26, $03, $00 ; entry 13
    db $E8, $25, $02, $00 ; entry 14
    db $E4, $1A, $01, $60 ; entry 15
    db $E0, $F5, $04, $20 ; entry 16
    db $D0, $E8, $0C, $00 ; entry 17
    db $D8, $24, $11, $00 ; entry 18
    db $D0, $28, $10, $00 ; entry 19
    db $D0, $20, $0F, $00 ; entry 20
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3F_407ESet1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1AFrame5::
Data_03F_6171:: ; heuristic: meta-sprite frame; C0
    db $E8, $1C, $02, $60 ; entry 0
    db $E4, $0B, $02, $60 ; entry 1
    db $DC, $03, $01, $60 ; entry 2
    db $D8, $F0, $02, $60 ; entry 3
    db $E8, $EE, $01, $60 ; entry 4
    db $E0, $EF, $01, $60 ; entry 5
    db $E4, $2D, $02, $00 ; entry 6
    db $DC, $2E, $01, $60 ; entry 7
    db $F0, $1D, $00, $60 ; entry 8
    db $E8, $BE, $02, $60 ; entry 9
    db $D8, $C4, $00, $40 ; entry 10
    db $E8, $E2, $03, $20 ; entry 11
    db $E8, $CE, $03, $60 ; entry 12
    db $E0, $CF, $02, $60 ; entry 13
    db $E4, $DA, $01, $00 ; entry 14
    db $E8, $FF, $04, $40 ; entry 15
    db $D0, $D0, $09, $00 ; entry 16
    db $D0, $D8, $0A, $00 ; entry 17
    db $D0, $00, $1A, $00 ; entry 18
    db $D0, $08, $1B, $00 ; entry 19
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3F_407ESet1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1AFrame6::
Data_03F_61C2:: ; heuristic: meta-sprite frame; C0
    db $F0, $D6, $02, $00 ; entry 0
    db $F4, $E7, $02, $00 ; entry 1
    db $F8, $03, $01, $00 ; entry 2
    db $E8, $D5, $00, $20 ; entry 3
    db $F0, $34, $02, $00 ; entry 4
    db $F8, $23, $02, $00 ; entry 5
    db $F4, $18, $01, $60 ; entry 6
    db $F0, $F3, $04, $20 ; entry 7
    db $F0, $24, $04, $00 ; entry 8
    db $F0, $10, $03, $00 ; entry 9
    db $F0, $04, $02, $00 ; entry 10
    db $F0, $B4, $02, $00 ; entry 11
    db $F4, $C5, $01, $00 ; entry 12
    db $E8, $1C, $11, $00 ; entry 13
    db $E0, $20, $10, $00 ; entry 14
    db $E0, $18, $0F, $00 ; entry 15
    db $D8, $18, $0D, $00 ; entry 16
    db $D8, $20, $0E, $00 ; entry 17
    db $E0, $E0, $0C, $00 ; entry 18
    db $D8, $E0, $0B, $00 ; entry 19
    db $D8, $C4, $11, $00 ; entry 20
    db $D0, $C8, $10, $00 ; entry 21
    db $D0, $C0, $0F, $00 ; entry 22
    db $D0, $48, $0C, $00 ; entry 23
    db $D0, $D8, $03, $00 ; entry 24
    db $D8, $F0, $01, $60 ; entry 25
    db $D8, $40, $02, $00 ; entry 26
    db $E0, $30, $04, $00 ; entry 27
    db $D0, $10, $02, $00 ; entry 28
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3F_407ESet1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1AFrame7::
Data_03F_6237:: ; heuristic: meta-sprite frame; C0
    db $F0, $1B, $02, $60 ; entry 0
    db $EC, $0A, $02, $60 ; entry 1
    db $E8, $EE, $01, $60 ; entry 2
    db $F8, $1C, $00, $40 ; entry 3
    db $F0, $BD, $02, $60 ; entry 4
    db $EC, $D9, $01, $00 ; entry 5
    db $F0, $FE, $04, $40 ; entry 6
    db $F0, $CD, $04, $60 ; entry 7
    db $F0, $E1, $03, $60 ; entry 8
    db $F0, $ED, $02, $60 ; entry 9
    db $EC, $2C, $01, $60 ; entry 10
    db $E0, $F8, $1A, $00 ; entry 11
    db $E0, $00, $1B, $00 ; entry 12
    db $D8, $F8, $17, $00 ; entry 13
    db $D8, $00, $18, $00 ; entry 14
    db $D8, $08, $19, $00 ; entry 15
    db $D0, $F8, $14, $00 ; entry 16
    db $D0, $00, $15, $00 ; entry 17
    db $D0, $08, $16, $00 ; entry 18
    db $E8, $C8, $09, $00 ; entry 19
    db $E8, $D0, $0A, $00 ; entry 20
    db $E0, $C8, $07, $40 ; entry 21
    db $E0, $D0, $08, $40 ; entry 22
    db $D0, $30, $23, $00 ; entry 23
    db $D0, $38, $24, $00 ; entry 24
    db $D8, $30, $25, $00 ; entry 25
    db $D8, $E0, $07, $00 ; entry 26
    db $D8, $E8, $08, $00 ; entry 27
    db $D0, $E0, $05, $00 ; entry 28
    db $D0, $E8, $06, $00 ; entry 29
    db $D8, $18, $00, $40 ; entry 30
    db $D0, $28, $01, $60 ; entry 31
    db $D0, $D8, $02, $60 ; entry 32
    db $D8, $C0, $02, $60 ; entry 33
    db $E0, $B0, $04, $40 ; entry 34
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites3F_407ESet1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1AFrame8::
Data_03F_62C4:: ; heuristic: meta-sprite frame; C0
    db $F8, $14, $11, $00 ; entry 0
    db $F0, $18, $10, $00 ; entry 1
    db $F0, $10, $0F, $00 ; entry 2
    db $E8, $10, $0D, $00 ; entry 3
    db $E8, $18, $0E, $00 ; entry 4
    db $F0, $D8, $0C, $00 ; entry 5
    db $E8, $D8, $0B, $00 ; entry 6
    db $E8, $BC, $11, $00 ; entry 7
    db $E0, $C0, $10, $00 ; entry 8
    db $E0, $B8, $0F, $00 ; entry 9
    db $D8, $B8, $0D, $00 ; entry 10
    db $D8, $C0, $0E, $00 ; entry 11
    db $E8, $3C, $0C, $00 ; entry 12
Data_03F_62F8:: ; heuristic: label inside a table; C0
    db $E0, $3C, $0B, $00 ; entry 13
    db $D0, $10, $2B, $00 ; entry 14
Data_03F_6300:: ; heuristic: label inside a table; C0
    db $D0, $18, $2C, $00 ; entry 15
    db $D0, $20, $2D, $00 ; entry 16
    db $D8, $D0, $1A, $00 ; entry 17
    db $D8, $D8, $1B, $00 ; entry 18
    db $D0, $D0, $17, $00 ; entry 19
    db $D0, $D8, $18, $00 ; entry 20
    db $D0, $E0, $19, $00 ; entry 21
    db $E0, $E0, $01, $00 ; entry 22
    db $E0, $10, $03, $00 ; entry 23
    db $E8, $F0, $04, $00 ; entry 24
    db $D0, $3C, $02, $00 ; entry 25
    db $F0, $B0, $00, $00 ; entry 26
    db $F0, $28, $01, $00 ; entry 27
    db $D0, $00, $02, $00 ; entry 28
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites3F_407ESet1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1AFrame9::
Data_03F_6339:: ; heuristic: meta-sprite frame; C0
    db $F0, $F0, $1A, $00 ; entry 0
    db $F0, $F8, $1B, $00 ; entry 1
    db $E8, $F0, $17, $00 ; entry 2
    db $E8, $F8, $18, $00 ; entry 3
    db $E8, $00, $19, $00 ; entry 4
    db $E0, $F0, $14, $00 ; entry 5
    db $E0, $F8, $15, $00 ; entry 6
    db $E0, $00, $16, $00 ; entry 7
    db $D8, $F4, $12, $00 ; entry 8
    db $D8, $FC, $13, $00 ; entry 9
    db $F8, $BC, $07, $40 ; entry 10
    db $F8, $C4, $08, $40 ; entry 11
    db $F0, $24, $25, $00 ; entry 12
    db $E8, $24, $23, $00 ; entry 13
    db $E8, $2C, $24, $00 ; entry 14
    db $E0, $28, $21, $00 ; entry 15
    db $E0, $30, $22, $00 ; entry 16
    db $D8, $30, $20, $00 ; entry 17
    db $D8, $28, $1F, $00 ; entry 18
    db $D0, $2A, $1D, $00 ; entry 19
    db $D0, $32, $1E, $00 ; entry 20
    db $E8, $D8, $07, $00 ; entry 21
    db $E8, $E0, $08, $00 ; entry 22
    db $E0, $D8, $05, $00 ; entry 23
    db $E0, $E0, $06, $00 ; entry 24
    db $D0, $C0, $03, $00 ; entry 25
    db $E8, $C8, $01, $00 ; entry 26
    db $E0, $1C, $03, $00 ; entry 27
    db $D8, $48, $02, $00 ; entry 28
    db $F8, $48, $01, $00 ; entry 29
    db $F8, $08, $00, $00 ; entry 30
    db $F8, $E0, $03, $00 ; entry 31
    db $D0, $08, $02, $00 ; entry 32
    db $80 ; end

; E-0147 (derived: frame 10 of MetaSprites3F_407ESet1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1AFrame10::
Data_03F_63BE:: ; heuristic: meta-sprite frame; C0
    db $F8, $08, $0D, $00 ; entry 0
    db $F8, $10, $0E, $00 ; entry 1
    db $F8, $D4, $0C, $00 ; entry 2
    db $F0, $D4, $0B, $00 ; entry 3
    db $F8, $B4, $11, $00 ; entry 4
    db $F0, $B8, $10, $00 ; entry 5
    db $F0, $B0, $0F, $00 ; entry 6
    db $E8, $B0, $0D, $00 ; entry 7
    db $E8, $B8, $0E, $00 ; entry 8
    db $F8, $30, $0B, $00 ; entry 9
    db $E0, $08, $2B, $00 ; entry 10
    db $E0, $10, $2C, $00 ; entry 11
    db $E0, $18, $2D, $00 ; entry 12
    db $D8, $08, $28, $00 ; entry 13
    db $D8, $10, $29, $00 ; entry 14
    db $D8, $18, $2A, $00 ; entry 15
    db $D0, $10, $26, $00 ; entry 16
    db $D0, $18, $27, $00 ; entry 17
    db $E8, $C8, $1A, $00 ; entry 18
    db $E8, $D0, $1B, $00 ; entry 19
    db $E0, $C8, $17, $00 ; entry 20
    db $E0, $D0, $18, $00 ; entry 21
    db $E0, $D8, $19, $00 ; entry 22
    db $D8, $C8, $14, $00 ; entry 23
    db $D8, $D0, $15, $00 ; entry 24
    db $D8, $D8, $16, $00 ; entry 25
    db $D0, $CC, $12, $00 ; entry 26
    db $D0, $D4, $13, $00 ; entry 27
    db $F0, $08, $03, $00 ; entry 28
    db $F8, $F0, $04, $00 ; entry 29
    db $E8, $DC, $01, $00 ; entry 30
    db $E8, $30, $02, $00 ; entry 31
    db $E0, $F8, $03, $00 ; entry 32
    db $D8, $B0, $01, $00 ; entry 33
    db $E0, $40, $00, $00 ; entry 34
    db $80 ; end

; E-0147 (derived: frame 11 of MetaSprites3F_407ESet1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1AFrame11::
Data_03F_644B:: ; heuristic: meta-sprite frame; C0
    db $F8, $E4, $12, $00 ; entry 0
    db $F8, $EC, $13, $00 ; entry 1
    db $F8, $18, $21, $00 ; entry 2
    db $F8, $20, $22, $00 ; entry 3
    db $F0, $20, $20, $00 ; entry 4
    db $F0, $18, $1F, $00 ; entry 5
    db $E8, $1A, $1D, $00 ; entry 6
    db $E8, $22, $1E, $00 ; entry 7
    db $E0, $22, $1C, $00 ; entry 8
    db $F8, $D0, $07, $00 ; entry 9
    db $F8, $D8, $08, $00 ; entry 10
    db $F0, $D0, $05, $00 ; entry 11
    db $F0, $D8, $06, $00 ; entry 12
    db $D8, $E0, $2B, $00 ; entry 13
    db $D8, $E8, $2C, $00 ; entry 14
    db $D8, $F0, $2D, $00 ; entry 15
    db $D0, $E0, $28, $00 ; entry 16
    db $D0, $E8, $29, $00 ; entry 17
    db $D0, $F0, $2A, $00 ; entry 18
    db $D0, $40, $09, $00 ; entry 19
    db $D0, $48, $0A, $00 ; entry 20
    db $F8, $C0, $01, $00 ; entry 21
    db $F8, $0C, $03, $00 ; entry 22
    db $F0, $38, $02, $00 ; entry 23
    db $D0, $30, $03, $00 ; entry 24
    db $D8, $B8, $03, $00 ; entry 25
    db $D8, $08, $04, $00 ; entry 26
    db $E0, $D8, $00, $00 ; entry 27
    db $E8, $B0, $01, $00 ; entry 28
    db $F0, $48, $01, $00 ; entry 29
    db $E8, $F0, $00, $00 ; entry 30
    db $E0, $40, $02, $00 ; entry 31
    db $80 ; end

; E-0147 (derived: frame 12 of MetaSprites3F_407ESet1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1AFrame12::
Data_03F_64CC:: ; heuristic: meta-sprite frame; C0
    db $F8, $B0, $0E, $00 ; entry 0
    db $F8, $C0, $1A, $00 ; entry 1
    db $F8, $C8, $1B, $00 ; entry 2
    db $F0, $C0, $17, $00 ; entry 3
    db $F0, $C8, $18, $00 ; entry 4
    db $F0, $D0, $19, $00 ; entry 5
    db $E8, $C0, $14, $00 ; entry 6
    db $E8, $C8, $15, $00 ; entry 7
    db $E8, $D0, $16, $00 ; entry 8
    db $E0, $C4, $12, $00 ; entry 9
    db $E0, $CC, $13, $00 ; entry 10
    db $F0, $00, $2B, $00 ; entry 11
    db $F0, $08, $2C, $00 ; entry 12
    db $F0, $10, $2D, $00 ; entry 13
    db $E8, $00, $28, $00 ; entry 14
    db $E8, $08, $29, $00 ; entry 15
    db $E8, $10, $2A, $00 ; entry 16
Data_03F_6510:: ; heuristic: label inside a table; C0
    db $E0, $08, $26, $00 ; entry 17
    db $E0, $10, $27, $00 ; entry 18
    db $D0, $E8, $0C, $00 ; entry 19
    db $D8, $24, $11, $00 ; entry 20
    db $D0, $28, $10, $00 ; entry 21
    db $D0, $20, $0F, $00 ; entry 22
    db $F0, $F0, $03, $00 ; entry 23
    db $F8, $28, $02, $00 ; entry 24
    db $F0, $38, $00, $00 ; entry 25
    db $E0, $B8, $04, $00 ; entry 26
    db $D0, $B8, $00, $00 ; entry 27
    db $D8, $D0, $02, $00 ; entry 28
    db $E8, $E0, $03, $00 ; entry 29
    db $D0, $08, $01, $00 ; entry 30
    db $E0, $30, $00, $00 ; entry 31
    db $80 ; end

; E-0147 (derived: frame 13 of MetaSprites3F_407ESet1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1AFrame13::
Data_03F_654D:: ; heuristic: meta-sprite frame; C0
    db $F8, $06, $1C, $00 ; entry 0
    db $E8, $D8, $2B, $00 ; entry 1
    db $E8, $E0, $2C, $00 ; entry 2
    db $E8, $E8, $2D, $00 ; entry 3
    db $E0, $D8, $28, $00 ; entry 4
    db $E0, $E0, $29, $00 ; entry 5
    db $E0, $E8, $2A, $00 ; entry 6
    db $D8, $E0, $26, $00 ; entry 7
    db $D8, $E8, $27, $00 ; entry 8
    db $E0, $38, $09, $00 ; entry 9
    db $E0, $40, $0A, $00 ; entry 10
    db $D8, $38, $05, $00 ; entry 11
    db $D8, $40, $06, $00 ; entry 12
    db $E8, $B0, $03, $00 ; entry 13
    db $E0, $28, $03, $00 ; entry 14
    db $D0, $10, $02, $00 ; entry 15
    db $F0, $C8, $01, $00 ; entry 16
    db $D0, $F8, $00, $00 ; entry 17
    db $D0, $D0, $00, $00 ; entry 18
    db $F8, $20, $03, $00 ; entry 19
    db $F0, $E8, $04, $00 ; entry 20
    db $E8, $10, $02, $00 ; entry 21
    db $F0, $40, $01, $00 ; entry 22
    db $80 ; end

; E-0147 (derived: frame 14 of MetaSprites3F_407ESet1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1AFrame14::
Data_03F_65AA:: ; heuristic: meta-sprite frame; C0
    db $E8, $1C, $11, $00 ; entry 0
    db $E0, $20, $10, $00 ; entry 1
    db $E0, $18, $0F, $00 ; entry 2
    db $D8, $18, $0D, $00 ; entry 3
    db $D8, $20, $0E, $00 ; entry 4
    db $E0, $E0, $0C, $00 ; entry 5
    db $D8, $E0, $0B, $00 ; entry 6
    db $D0, $48, $0C, $00 ; entry 7
    db $D8, $C4, $11, $00 ; entry 8
    db $D0, $C8, $10, $00 ; entry 9
    db $D0, $C0, $0F, $00 ; entry 10
    db $F8, $F8, $28, $00 ; entry 11
    db $F8, $00, $29, $00 ; entry 12
    db $F8, $08, $2A, $00 ; entry 13
    db $F0, $00, $26, $00 ; entry 14
    db $F0, $08, $27, $00 ; entry 15
    db $F8, $B8, $14, $00 ; entry 16
    db $F8, $C0, $15, $00 ; entry 17
    db $F8, $C8, $16, $00 ; entry 18
    db $F0, $BC, $12, $00 ; entry 19
    db $F0, $C4, $13, $00 ; entry 20
    db $E0, $08, $02, $00 ; entry 21
    db $E0, $F0, $00, $00 ; entry 22
    db $F0, $24, $03, $00 ; entry 23
    db $F8, $B0, $03, $00 ; entry 24
    db $E8, $48, $02, $00 ; entry 25
    db $F8, $38, $01, $00 ; entry 26
    db $D0, $00, $00, $00 ; entry 27
    db $E8, $D0, $02, $00 ; entry 28
    db $80 ; end

; E-0147 (derived: frame 15 of MetaSprites3F_407ESet1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1AFrame15::
Data_03F_661F:: ; heuristic: meta-sprite frame; C0
    db $E0, $F8, $1A, $00 ; entry 0
    db $E0, $00, $1B, $00 ; entry 1
    db $D8, $F8, $17, $00 ; entry 2
    db $D8, $00, $18, $00 ; entry 3
    db $D8, $08, $19, $00 ; entry 4
    db $D0, $F8, $14, $00 ; entry 5
    db $D0, $00, $15, $00 ; entry 6
    db $D0, $08, $16, $00 ; entry 7
    db $D0, $30, $23, $00 ; entry 8
    db $D0, $38, $24, $00 ; entry 9
    db $D8, $30, $25, $00 ; entry 10
    db $D8, $E0, $07, $00 ; entry 11
    db $D8, $E8, $08, $00 ; entry 12
    db $D0, $E0, $05, $00 ; entry 13
    db $D0, $E8, $06, $00 ; entry 14
    db $F8, $D0, $2B, $00 ; entry 15
    db $F8, $D8, $2C, $00 ; entry 16
    db $F8, $E0, $2D, $00 ; entry 17
    db $F0, $D0, $28, $00 ; entry 18
    db $F0, $D8, $29, $00 ; entry 19
    db $F0, $E0, $2A, $00 ; entry 20
    db $E8, $D8, $26, $00 ; entry 21
    db $E8, $E0, $27, $00 ; entry 22
    db $F0, $30, $09, $00 ; entry 23
    db $F0, $38, $0A, $00 ; entry 24
    db $E8, $30, $05, $00 ; entry 25
    db $E8, $38, $06, $00 ; entry 26
    db $F0, $18, $04, $00 ; entry 27
    db $E0, $20, $03, $00 ; entry 28
    db $F0, $B8, $02, $00 ; entry 29
    db $F8, $F8, $01, $00 ; entry 30
    db $D9, $B8, $00, $00 ; entry 31
    db $D1, $D0, $00, $00 ; entry 32
    db $D8, $40, $01, $00 ; entry 33
    db $F8, $40, $00, $00 ; entry 34
    db $80 ; end

; E-0147 (derived: frame 16 of MetaSprites3F_407ESet1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1AFrame16::
Data_03F_66AC:: ; heuristic: meta-sprite frame; C0
    db $F8, $14, $11, $00 ; entry 0
    db $F0, $18, $10, $00 ; entry 1
    db $F0, $10, $0F, $00 ; entry 2
    db $E8, $10, $0D, $00 ; entry 3
    db $E8, $18, $0E, $00 ; entry 4
    db $F0, $D8, $0C, $00 ; entry 5
    db $E8, $D8, $0B, $00 ; entry 6
    db $E0, $48, $0C, $00 ; entry 7
    db $D8, $48, $0B, $00 ; entry 8
    db $F0, $B8, $11, $00 ; entry 9
    db $E8, $BC, $10, $00 ; entry 10
    db $E8, $B4, $0F, $00 ; entry 11
    db $E0, $B4, $0D, $00 ; entry 12
    db $E0, $BC, $0E, $00 ; entry 13
    db $D0, $10, $2B, $00 ; entry 14
    db $D0, $18, $2C, $00 ; entry 15
    db $D0, $20, $2D, $00 ; entry 16
    db $D8, $D0, $1A, $00 ; entry 17
    db $D8, $D8, $1B, $00 ; entry 18
    db $D0, $D0, $17, $00 ; entry 19
    db $D0, $D8, $18, $00 ; entry 20
    db $D0, $E0, $19, $00 ; entry 21
    db $F8, $00, $04, $00 ; entry 22
    db $E0, $F8, $01, $00 ; entry 23
    db $F8, $C0, $00, $00 ; entry 24
    db $E8, $30, $02, $00 ; entry 25
    db $F8, $E8, $03, $00 ; entry 26
    db $D0, $F0, $01, $00 ; entry 27
    db $80 ; end

; E-0147 (derived: frame 17 of MetaSprites3F_407ESet1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1AFrame17::
Data_03F_671D:: ; heuristic: meta-sprite frame; C0
    db $F8, $D0, $26, $00 ; entry 0
    db $F8, $D8, $27, $00 ; entry 1
    db $F8, $28, $05, $00 ; entry 2
    db $F8, $30, $06, $00 ; entry 3
    db $F0, $F0, $1A, $00 ; entry 4
    db $F0, $F8, $1B, $00 ; entry 5
    db $E8, $F0, $17, $00 ; entry 6
    db $E8, $F8, $18, $00 ; entry 7
    db $E8, $00, $19, $00 ; entry 8
    db $E0, $F0, $14, $00 ; entry 9
    db $E0, $F8, $15, $00 ; entry 10
    db $E0, $00, $16, $00 ; entry 11
    db $D8, $F4, $12, $00 ; entry 12
    db $D8, $FC, $13, $00 ; entry 13
    db $F0, $24, $25, $00 ; entry 14
    db $E8, $24, $23, $00 ; entry 15
    db $E8, $2C, $24, $00 ; entry 16
    db $E0, $28, $21, $00 ; entry 17
    db $E0, $30, $22, $00 ; entry 18
    db $E8, $D8, $07, $00 ; entry 19
    db $E8, $E0, $08, $00 ; entry 20
    db $E0, $D8, $05, $00 ; entry 21
    db $E0, $E0, $06, $00 ; entry 22
    db $D8, $32, $20, $00 ; entry 23
    db $D8, $2A, $1F, $00 ; entry 24
    db $D0, $2C, $1D, $00 ; entry 25
    db $D0, $34, $1E, $00 ; entry 26
    db $F0, $B8, $00, $00 ; entry 27
    db $F0, $40, $04, $00 ; entry 28
    db $E0, $C8, $03, $00 ; entry 29
    db $F8, $08, $02, $00 ; entry 30
    db $E0, $18, $01, $00 ; entry 31
    db $D0, $04, $02, $00 ; entry 32
    db $80 ; end

; E-0147 (derived: frame 18 of MetaSprites3F_407ESet1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1AFrame18::
Data_03F_67A2:: ; heuristic: meta-sprite frame; C0
    db $F8, $E4, $12, $00 ; entry 0
    db $F8, $EC, $13, $00 ; entry 1
    db $F8, $18, $21, $00 ; entry 2
    db $F8, $20, $22, $00 ; entry 3
    db $F8, $D0, $07, $00 ; entry 4
    db $F8, $D8, $08, $00 ; entry 5
    db $F0, $D0, $05, $00 ; entry 6
    db $F0, $D8, $06, $00 ; entry 7
    db $F0, $22, $20, $00 ; entry 8
    db $F0, $1A, $1F, $00 ; entry 9
    db $E8, $1C, $1D, $00 ; entry 10
    db $E8, $24, $1E, $00 ; entry 11
    db $E0, $24, $1C, $00 ; entry 12
    db $F0, $08, $01, $00 ; entry 13
    db $F0, $B8, $03, $00 ; entry 14
    db $F0, $F4, $02, $00 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 19 of MetaSprites3F_407ESet1A; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1AFrame19::
    db $80 ; end

; E-0147 (derived: meta-sprite set 27 of MetaSprites3F_407ETable: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3F_407ESet1B::
Data_03F_67E4:: ; heuristic: meta-sprite set; C0
    dw MetaSprites3F_407ESet1BFrame0 ; entry 0
    dw MetaSprites3F_407ESet1BFrame1 ; entry 1
    dw MetaSprites3F_407ESet1BFrame2 ; entry 2
    dw MetaSprites3F_407ESet1BFrame3 ; entry 3
    dw MetaSprites3F_407ESet1BFrame4 ; entry 4
    dw MetaSprites3F_407ESet1BFrame5 ; entry 5
    dw MetaSprites3F_407ESet1BFrame6 ; entry 6
    dw MetaSprites3F_407ESet1BFrame7 ; entry 7
    dw MetaSprites3F_407ESet1BFrame8 ; entry 8
    dw MetaSprites3F_407ESet1BFrame8 ; entry 9
    dw MetaSprites3F_407ESet1BFrame8 ; entry 10
    dw MetaSprites3F_407ESet1BFrame8 ; entry 11
    dw MetaSprites3F_407ESet1BFrame8 ; entry 12
    dw MetaSprites3F_407ESet1BFrame8 ; entry 13
    dw MetaSprites3F_407ESet1BFrame8 ; entry 14
    dw MetaSprites3F_407ESet1BFrame8 ; entry 15
    dw MetaSprites3F_407ESet1BFrame8 ; entry 16
    dw MetaSprites3F_407ESet1BFrame8 ; entry 17
    dw MetaSprites3F_407ESet1BFrame8 ; entry 18
    dw MetaSprites3F_407ESet1BFrame8 ; entry 19
    dw MetaSprites3F_407ESet1BFrame8 ; entry 20
    dw MetaSprites3F_407ESet1BFrame8 ; entry 21
    dw MetaSprites3F_407ESet1BFrame8 ; entry 22
    dw MetaSprites3F_407ESet1BFrame8 ; entry 23
    dw MetaSprites3F_407ESet1BFrame8 ; entry 24
    dw MetaSprites3F_407ESet1BFrame8 ; entry 25
    dw MetaSprites3F_407ESet1BFrame8 ; entry 26
    dw MetaSprites3F_407ESet1BFrame8 ; entry 27
    dw MetaSprites3F_407ESet1BFrame8 ; entry 28
    dw MetaSprites3F_407ESet1BFrame8 ; entry 29
    dw MetaSprites3F_407ESet1BFrame8 ; entry 30
    dw MetaSprites3F_407ESet1BFrame8 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3F_407ESet1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1BFrame0::
Data_03F_6824:: ; heuristic: meta-sprite frame; C0
    db $D0, $F2, $17, $00 ; entry 0
    db $D0, $FA, $18, $00 ; entry 1
    db $D0, $02, $19, $00 ; entry 2
    db $D0, $0A, $1A, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3F_407ESet1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1BFrame1::
Data_03F_6835:: ; heuristic: meta-sprite frame; C0
    db $D0, $F2, $13, $00 ; entry 0
    db $D0, $FA, $14, $00 ; entry 1
    db $D0, $02, $15, $00 ; entry 2
    db $D8, $F2, $17, $00 ; entry 3
    db $D8, $FA, $18, $00 ; entry 4
    db $D8, $02, $19, $00 ; entry 5
    db $D0, $0A, $16, $00 ; entry 6
    db $D8, $0A, $1A, $00 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3F_407ESet1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1BFrame2::
Data_03F_6856:: ; heuristic: meta-sprite frame; C0
    db $D8, $F2, $10, $00 ; entry 0
    db $D8, $FA, $11, $00 ; entry 1
    db $D8, $02, $12, $00 ; entry 2
    db $E0, $F2, $13, $00 ; entry 3
    db $E0, $FA, $14, $00 ; entry 4
    db $E0, $02, $15, $00 ; entry 5
    db $E0, $0A, $16, $00 ; entry 6
    db $E8, $F2, $17, $00 ; entry 7
    db $E8, $FA, $18, $00 ; entry 8
    db $E8, $02, $19, $00 ; entry 9
    db $E8, $0A, $1A, $00 ; entry 10
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3F_407ESet1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1BFrame3::
Data_03F_6883:: ; heuristic: meta-sprite frame; C0
    db $E9, $F8, $06, $00 ; entry 0
    db $E9, $00, $07, $00 ; entry 1
    db $E8, $F2, $0D, $20 ; entry 2
    db $E0, $EA, $00, $20 ; entry 3
    db $E1, $F8, $04, $00 ; entry 4
    db $E1, $00, $05, $00 ; entry 5
    db $E0, $F2, $0C, $20 ; entry 6
    db $DD, $FA, $03, $00 ; entry 7
    db $DC, $02, $02, $00 ; entry 8
    db $E4, $06, $0C, $00 ; entry 9
    db $EC, $06, $0D, $00 ; entry 10
    db $DB, $0A, $01, $00 ; entry 11
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3F_407ESet1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1BFrame4::
Data_03F_68B4:: ; heuristic: meta-sprite frame; C0
    db $D8, $F2, $03, $00 ; entry 0
    db $EB, $EB, $0E, $40 ; entry 1
    db $EB, $F3, $0F, $40 ; entry 2
    db $DE, $E8, $00, $20 ; entry 3
    db $D4, $06, $02, $00 ; entry 4
    db $E4, $10, $0E, $60 ; entry 5
    db $E4, $08, $0F, $60 ; entry 6
    db $DA, $10, $01, $00 ; entry 7
    db $DE, $F8, $04, $00 ; entry 8
    db $DE, $00, $05, $00 ; entry 9
    db $E6, $F8, $06, $00 ; entry 10
    db $E6, $00, $07, $00 ; entry 11
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3F_407ESet1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1BFrame5::
Data_03F_68E5:: ; heuristic: meta-sprite frame; C0
    db $E2, $10, $01, $20 ; entry 0
    db $F2, $10, $0C, $60 ; entry 1
    db $EA, $10, $0D, $60 ; entry 2
    db $DC, $0A, $02, $40 ; entry 3
    db $E0, $ED, $03, $40 ; entry 4
    db $E6, $E8, $01, $00 ; entry 5
    db $F8, $EB, $0C, $40 ; entry 6
    db $F0, $EB, $0D, $40 ; entry 7
    db $E6, $FA, $08, $00 ; entry 8
    db $E6, $02, $09, $00 ; entry 9
    db $EE, $FA, $0A, $00 ; entry 10
    db $EE, $02, $0B, $00 ; entry 11
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3F_407ESet1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1BFrame6::
Data_03F_6916:: ; heuristic: meta-sprite frame; C0
    db $F8, $EB, $0D, $60 ; entry 0
    db $F8, $10, $0C, $40 ; entry 1
    db $F0, $10, $0D, $40 ; entry 2
    db $EC, $E8, $02, $00 ; entry 3
    db $E2, $10, $00, $20 ; entry 4
    db $EE, $FC, $04, $00 ; entry 5
    db $EE, $04, $05, $00 ; entry 6
    db $F6, $FC, $06, $00 ; entry 7
    db $F6, $04, $07, $00 ; entry 8
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3F_407ESet1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1BFrame7::
Data_03F_693B:: ; heuristic: meta-sprite frame; C0
    db $F8, $10, $0D, $60 ; entry 0
    db $F8, $FD, $04, $00 ; entry 1
    db $F8, $05, $05, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites3F_407ESet1B; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1BFrame8::
    db $80 ; end

; E-0147 (derived: meta-sprite set 28 of MetaSprites3F_407ETable: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3F_407ESet1C::
Data_03F_6949:: ; heuristic: meta-sprite set; C0
    dw MetaSprites3F_407ESet1CFrame0 ; entry 0
    dw MetaSprites3F_407ESet1CFrame1 ; entry 1
    dw MetaSprites3F_407ESet1CFrame2 ; entry 2
    dw MetaSprites3F_407ESet1CFrame3 ; entry 3
    dw MetaSprites3F_407ESet1CFrame4 ; entry 4
    dw MetaSprites3F_407ESet1CFrame5 ; entry 5
    dw MetaSprites3F_407ESet1CFrame6 ; entry 6
    dw MetaSprites3F_407ESet1CFrame7 ; entry 7
    dw MetaSprites3F_407ESet1CFrame8 ; entry 8
    dw MetaSprites3F_407ESet1CFrame9 ; entry 9
    dw MetaSprites3F_407ESet1CFrame10 ; entry 10
    dw MetaSprites3F_407ESet1CFrame11 ; entry 11
    dw MetaSprites3F_407ESet1CFrame12 ; entry 12
    dw MetaSprites3F_407ESet1CFrame13 ; entry 13
    dw MetaSprites3F_407ESet1CFrame14 ; entry 14
    dw MetaSprites3F_407ESet1CFrame15 ; entry 15
    dw MetaSprites3F_407ESet1CFrame16 ; entry 16
    dw MetaSprites3F_407ESet1CFrame17 ; entry 17
    dw MetaSprites3F_407ESet1CFrame18 ; entry 18
    dw MetaSprites3F_407ESet1CFrame19 ; entry 19
    dw MetaSprites3F_407ESet1CFrame20 ; entry 20
    dw MetaSprites3F_407ESet1CFrame20 ; entry 21
    dw MetaSprites3F_407ESet1CFrame20 ; entry 22
    dw MetaSprites3F_407ESet1CFrame20 ; entry 23
    dw MetaSprites3F_407ESet1CFrame20 ; entry 24
    dw MetaSprites3F_407ESet1CFrame20 ; entry 25
    dw MetaSprites3F_407ESet1CFrame20 ; entry 26
    dw MetaSprites3F_407ESet1CFrame20 ; entry 27
    dw MetaSprites3F_407ESet1CFrame20 ; entry 28
    dw MetaSprites3F_407ESet1CFrame20 ; entry 29
    dw MetaSprites3F_407ESet1CFrame20 ; entry 30
    dw MetaSprites3F_407ESet1CFrame20 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3F_407ESet1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1CFrame0::
Data_03F_6989:: ; heuristic: meta-sprite frame; C0
    db $F8, $B0, $22, $10 ; entry 0
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3F_407ESet1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1CFrame1::
Data_03F_698E:: ; heuristic: meta-sprite frame; C0
    db $F8, $B0, $20, $10 ; entry 0
    db $F8, $B8, $21, $10 ; entry 1
    db $F8, $C0, $22, $10 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3F_407ESet1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1CFrame2::
Data_03F_699B:: ; heuristic: meta-sprite frame; C0
    db $F8, $C3, $20, $10 ; entry 0
    db $F8, $CB, $21, $10 ; entry 1
    db $F8, $D3, $22, $10 ; entry 2
    db $F8, $B3, $10, $10 ; entry 3
    db $F8, $BB, $11, $10 ; entry 4
    db $F8, $AB, $11, $10 ; entry 5
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3F_407ESet1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1CFrame3::
Data_03F_69B4:: ; heuristic: meta-sprite frame; C0
    db $F8, $D8, $20, $10 ; entry 0
    db $F8, $E0, $21, $10 ; entry 1
    db $F8, $E8, $22, $10 ; entry 2
    db $F8, $C8, $11, $10 ; entry 3
    db $F8, $D0, $11, $10 ; entry 4
    db $F8, $C0, $12, $10 ; entry 5
    db $F8, $B0, $02, $10 ; entry 6
    db $F8, $B8, $02, $10 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3F_407ESet1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1CFrame4::
Data_03F_69D5:: ; heuristic: meta-sprite frame; C0
    db $F8, $B7, $00, $10 ; entry 0
    db $F8, $BF, $01, $10 ; entry 1
    db $F8, $C7, $02, $10 ; entry 2
    db $F8, $CF, $02, $10 ; entry 3
    db $F8, $DF, $10, $10 ; entry 4
    db $F8, $E7, $11, $10 ; entry 5
    db $F8, $D7, $11, $10 ; entry 6
    db $F8, $EF, $20, $10 ; entry 7
    db $F8, $F7, $21, $10 ; entry 8
    db $F8, $FF, $22, $10 ; entry 9
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3F_407ESet1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1CFrame5::
Data_03F_69FE:: ; heuristic: meta-sprite frame; C0
    db $F8, $D0, $00, $10 ; entry 0
    db $F8, $D8, $01, $10 ; entry 1
    db $F8, $E0, $02, $10 ; entry 2
    db $F8, $E8, $02, $10 ; entry 3
    db $F8, $F0, $11, $10 ; entry 4
    db $F8, $F8, $12, $10 ; entry 5
    db $F8, $00, $11, $10 ; entry 6
    db $F8, $08, $20, $10 ; entry 7
    db $F8, $10, $21, $10 ; entry 8
    db $F8, $18, $22, $10 ; entry 9
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3F_407ESet1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1CFrame6::
Data_03F_6A27:: ; heuristic: meta-sprite frame; C0
    db $F8, $EB, $00, $10 ; entry 0
    db $F8, $F3, $01, $10 ; entry 1
    db $F8, $FB, $02, $10 ; entry 2
    db $F8, $03, $02, $10 ; entry 3
    db $F8, $0B, $10, $10 ; entry 4
    db $F8, $13, $11, $10 ; entry 5
    db $F8, $1B, $11, $10 ; entry 6
    db $F8, $23, $20, $10 ; entry 7
    db $F8, $2B, $21, $10 ; entry 8
    db $F8, $33, $22, $10 ; entry 9
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3F_407ESet1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1CFrame7::
Data_03F_6A50:: ; heuristic: meta-sprite frame; C0
    db $F8, $08, $00, $10 ; entry 0
    db $F8, $10, $01, $10 ; entry 1
    db $F8, $18, $02, $10 ; entry 2
    db $F8, $20, $02, $10 ; entry 3
    db $F8, $30, $11, $10 ; entry 4
    db $F8, $38, $11, $10 ; entry 5
    db $F8, $28, $12, $10 ; entry 6
    db $F8, $40, $20, $10 ; entry 7
    db $F8, $48, $21, $10 ; entry 8
    db $F0, $D0, $17, $10 ; entry 9
    db $F6, $D8, $0D, $10 ; entry 10
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites3F_407ESet1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1CFrame8::
Data_03F_6A7D:: ; heuristic: meta-sprite frame; C0
    db $F8, $19, $00, $10 ; entry 0
    db $F8, $21, $01, $10 ; entry 1
    db $F8, $29, $02, $10 ; entry 2
    db $F8, $31, $02, $10 ; entry 3
    db $F8, $39, $12, $10 ; entry 4
    db $F8, $41, $11, $10 ; entry 5
    db $F8, $49, $11, $10 ; entry 6
    db $F8, $C8, $13, $10 ; entry 7
    db $F5, $CB, $27, $10 ; entry 8
    db $ED, $C8, $0D, $10 ; entry 9
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites3F_407ESet1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1CFrame9::
Data_03F_6AA6:: ; heuristic: meta-sprite frame; C0
    db $F8, $2C, $00, $10 ; entry 0
    db $F8, $34, $01, $10 ; entry 1
    db $F8, $3C, $02, $10 ; entry 2
    db $F8, $44, $02, $10 ; entry 3
    db $F8, $4C, $12, $10 ; entry 4
    db $EF, $D0, $13, $10 ; entry 5
    db $F7, $D0, $23, $10 ; entry 6
    db $F3, $DB, $24, $10 ; entry 7
    db $ED, $D3, $27, $10 ; entry 8
    db $E5, $D0, $0D, $10 ; entry 9
    db $80 ; end

; E-0147 (derived: frame 10 of MetaSprites3F_407ESet1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1CFrame10::
Data_03F_6ACF:: ; heuristic: meta-sprite frame; C0
    db $F8, $41, $00, $10 ; entry 0
    db $F8, $49, $01, $10 ; entry 1
    db $F8, $C6, $03, $10 ; entry 2
    db $F8, $DE, $08, $50 ; entry 3
    db $F0, $D6, $15, $10 ; entry 4
    db $F8, $D6, $26, $10 ; entry 5
    db $F8, $E6, $26, $10 ; entry 6
    db $F8, $CE, $25, $10 ; entry 7
    db $F8, $06, $17, $10 ; entry 8
    db $F0, $EE, $0D, $30 ; entry 9
    db $F8, $EE, $0E, $30 ; entry 10
    db $F0, $E6, $0B, $10 ; entry 11
    db $E8, $E8, $14, $10 ; entry 12
    db $F8, $F6, $14, $10 ; entry 13
    db $E8, $E0, $1D, $10 ; entry 14
    db $F0, $DE, $1F, $70 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 11 of MetaSprites3F_407ESet1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1CFrame11::
Data_03F_6B10:: ; heuristic: meta-sprite frame; C0
    db $D8, $06, $13, $10 ; entry 0
    db $F8, $CE, $03, $10 ; entry 1
    db $F8, $D6, $04, $10 ; entry 2
    db $F8, $DE, $05, $10 ; entry 3
    db $F8, $EE, $06, $10 ; entry 4
    db $F8, $F6, $07, $10 ; entry 5
    db $F8, $FE, $08, $10 ; entry 6
    db $F0, $FE, $08, $70 ; entry 7
    db $F8, $E6, $26, $10 ; entry 8
    db $D8, $FE, $25, $30 ; entry 9
    db $D0, $F6, $0D, $10 ; entry 10
    db $D8, $F6, $0E, $10 ; entry 11
    db $E8, $F6, $0F, $30 ; entry 12
    db $F0, $D2, $0D, $10 ; entry 13
    db $E0, $06, $18, $70 ; entry 14
    db $E8, $06, $19, $30 ; entry 15
    db $F0, $0E, $1F, $10 ; entry 16
    db $F8, $0E, $2F, $10 ; entry 17
    db $E8, $0E, $1C, $10 ; entry 18
    db $E8, $FE, $1B, $10 ; entry 19
    db $E0, $FE, $1B, $30 ; entry 20
    db $F0, $06, $2D, $10 ; entry 21
    db $F8, $06, $2E, $50 ; entry 22
    db $F0, $F6, $1F, $30 ; entry 23
    db $F0, $E4, $1D, $30 ; entry 24
    db $80 ; end

; E-0147 (derived: frame 12 of MetaSprites3F_407ESet1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1CFrame12::
Data_03F_6B75:: ; heuristic: meta-sprite frame; C0
    db $F8, $28, $22, $10 ; entry 0
    db $F8, $B8, $13, $10 ; entry 1
    db $F0, $C2, $17, $10 ; entry 2
    db $F0, $C8, $25, $10 ; entry 3
    db $E8, $EF, $27, $50 ; entry 4
    db $F8, $30, $28, $50 ; entry 5
    db $D8, $F0, $18, $10 ; entry 6
    db $E0, $04, $0C, $10 ; entry 7
    db $D8, $08, $0A, $10 ; entry 8
    db $D8, $10, $0B, $10 ; entry 9
    db $D0, $0A, $09, $10 ; entry 10
    db $D0, $F2, $19, $50 ; entry 11
    db $E8, $D0, $0D, $30 ; entry 12
    db $F0, $D0, $0E, $30 ; entry 13
    db $F8, $C0, $18, $50 ; entry 14
    db $F8, $D0, $15, $10 ; entry 15
    db $D8, $E0, $14, $10 ; entry 16
    db $F8, $D8, $14, $10 ; entry 17
    db $F8, $C8, $1B, $10 ; entry 18
    db $D8, $00, $2D, $70 ; entry 19
    db $D8, $F8, $2E, $70 ; entry 20
    db $D0, $FA, $1B, $30 ; entry 21
    db $E8, $26, $1A, $10 ; entry 22
    db $F0, $20, $14, $10 ; entry 23
    db $F8, $18, $1D, $10 ; entry 24
    db $F8, $38, $1C, $10 ; entry 25
    db $F0, $26, $2A, $10 ; entry 26
    db $F8, $20, $2B, $10 ; entry 27
    db $D0, $02, $1F, $50 ; entry 28
    db $E0, $0B, $1A, $50 ; entry 29
    db $E0, $F4, $28, $10 ; entry 30
    db $80 ; end

; E-0147 (derived: frame 13 of MetaSprites3F_407ESet1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1CFrame13::
Data_03F_6BF2:: ; heuristic: meta-sprite frame; C0
    db $EF, $18, $13, $10 ; entry 0
    db $F7, $18, $23, $10 ; entry 1
    db $F8, $B8, $13, $10 ; entry 2
    db $F3, $23, $24, $10 ; entry 3
    db $F8, $C8, $08, $10 ; entry 4
    db $D8, $C8, $16, $30 ; entry 5
    db $ED, $1B, $27, $10 ; entry 6
    db $E5, $18, $0D, $10 ; entry 7
    db $D0, $D8, $0D, $30 ; entry 8
    db $D8, $D8, $0E, $30 ; entry 9
    db $D8, $D0, $0F, $30 ; entry 10
    db $E0, $D7, $19, $30 ; entry 11
    db $E8, $D8, $29, $30 ; entry 12
    db $F8, $F0, $28, $50 ; entry 13
    db $F0, $C7, $0A, $10 ; entry 14
    db $E0, $C7, $2C, $10 ; entry 15
    db $E0, $CF, $1B, $10 ; entry 16
    db $F8, $E8, $2B, $30 ; entry 17
    db $F8, $E0, $2C, $30 ; entry 18
    db $F8, $D8, $2D, $30 ; entry 19
    db $F8, $D0, $2E, $30 ; entry 20
    db $F0, $C0, $1F, $30 ; entry 21
    db $F8, $C0, $2F, $30 ; entry 22
    db $E8, $BF, $1C, $30 ; entry 23
    db $F0, $DF, $1D, $30 ; entry 24
    db $F0, $CF, $1E, $30 ; entry 25
    db $E8, $C8, $1B, $30 ; entry 26
    db $E8, $D0, $2E, $50 ; entry 27
    db $80 ; end

; E-0147 (derived: frame 14 of MetaSprites3F_407ESet1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1CFrame14::
Data_03F_6C63:: ; heuristic: meta-sprite frame; C0
    db $F0, $30, $13, $10 ; entry 0
    db $F8, $E4, $03, $10 ; entry 1
    db $F8, $C8, $13, $30 ; entry 2
    db $F8, $FC, $08, $50 ; entry 3
    db $F5, $D0, $27, $10 ; entry 4
    db $F8, $EC, $25, $10 ; entry 5
    db $F0, $28, $25, $30 ; entry 6
    db $F8, $F4, $26, $10 ; entry 7
    db $F8, $04, $26, $10 ; entry 8
    db $F0, $F4, $15, $10 ; entry 9
    db $F0, $0C, $16, $10 ; entry 10
    db $ED, $CA, $0D, $10 ; entry 11
    db $E8, $20, $0D, $10 ; entry 12
    db $F0, $04, $0B, $10 ; entry 13
    db $F0, $20, $0E, $10 ; entry 14
    db $F8, $0C, $0E, $30 ; entry 15
    db $F8, $30, $18, $70 ; entry 16
    db $F8, $20, $28, $50 ; entry 17
    db $E8, $06, $14, $10 ; entry 18
    db $E8, $FE, $1D, $10 ; entry 19
    db $F8, $28, $1B, $30 ; entry 20
    db $F0, $FC, $1F, $70 ; entry 21
    db $80 ; end

; E-0147 (derived: frame 15 of MetaSprites3F_407ESet1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1CFrame15::
Data_03F_6CBC:: ; heuristic: meta-sprite frame; C0
    db $F8, $28, $08, $30 ; entry 0
    db $D8, $28, $16, $10 ; entry 1
    db $D0, $18, $0D, $10 ; entry 2
    db $D8, $18, $0E, $10 ; entry 3
    db $D8, $20, $0F, $10 ; entry 4
    db $E0, $19, $19, $10 ; entry 5
    db $E8, $18, $29, $10 ; entry 6
    db $F0, $29, $0A, $10 ; entry 7
    db $F8, $00, $28, $70 ; entry 8
    db $F8, $30, $2F, $10 ; entry 9
    db $F0, $31, $1F, $10 ; entry 10
    db $E8, $28, $1B, $10 ; entry 11
    db $E8, $30, $1C, $10 ; entry 12
    db $F0, $21, $1E, $10 ; entry 13
    db $F8, $08, $2B, $10 ; entry 14
    db $F8, $10, $2C, $10 ; entry 15
    db $F8, $18, $2D, $10 ; entry 16
    db $F8, $20, $2E, $10 ; entry 17
    db $E0, $29, $2C, $30 ; entry 18
    db $E0, $21, $1B, $30 ; entry 19
    db $F0, $12, $1D, $10 ; entry 20
    db $F8, $F8, $2A, $50 ; entry 21
    db $E8, $20, $2E, $50 ; entry 22
    db $80 ; end

; E-0147 (derived: frame 16 of MetaSprites3F_407ESet1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1CFrame16::
Data_03F_6D19:: ; heuristic: meta-sprite frame; C0
    db $F8, $0C, $22, $10 ; entry 0
    db $F0, $F7, $13, $10 ; entry 1
    db $F8, $04, $04, $30 ; entry 2
    db $F8, $FC, $07, $30 ; entry 3
    db $F8, $D0, $17, $10 ; entry 4
    db $E8, $F5, $14, $10 ; entry 5
    db $F0, $04, $14, $10 ; entry 6
    db $F8, $14, $14, $10 ; entry 7
    db $F8, $EC, $2B, $10 ; entry 8
    db $F8, $F4, $2C, $10 ; entry 9
    db $E8, $0A, $1A, $10 ; entry 10
    db $F0, $0A, $2A, $10 ; entry 11
    db $F0, $FC, $1D, $30 ; entry 12
    db $80 ; end

; E-0147 (derived: frame 17 of MetaSprites3F_407ESet1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1CFrame17::
Data_03F_6D4E:: ; heuristic: meta-sprite frame; C0
    db $EF, $00, $13, $10 ; entry 0
    db $F7, $00, $23, $10 ; entry 1
    db $F3, $0B, $24, $10 ; entry 2
    db $F0, $E5, $27, $10 ; entry 3
    db $ED, $03, $27, $10 ; entry 4
    db $E5, $00, $0D, $10 ; entry 5
    db $80 ; end

; E-0147 (derived: frame 18 of MetaSprites3F_407ESet1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1CFrame18::
Data_03F_6D67:: ; heuristic: meta-sprite frame; C0
    db $F0, $F8, $17, $10 ; entry 0
    db $F8, $F7, $27, $10 ; entry 1
    db $F8, $F0, $0D, $10 ; entry 2
    db $E8, $08, $0D, $30 ; entry 3
    db $F8, $08, $14, $10 ; entry 4
    db $80 ; end

; E-0147 (derived: frame 19 of MetaSprites3F_407ESet1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1CFrame19::
Data_03F_6D7C:: ; heuristic: meta-sprite frame; C0
    db $F8, $C6, $03, $10 ; entry 0
    db $F8, $DE, $08, $50 ; entry 1
    db $F0, $D6, $15, $10 ; entry 2
    db $F8, $D6, $26, $10 ; entry 3
    db $F8, $E6, $26, $10 ; entry 4
    db $F8, $CE, $25, $10 ; entry 5
    db $F8, $06, $17, $10 ; entry 6
    db $F0, $EE, $0D, $30 ; entry 7
    db $F8, $EE, $0E, $30 ; entry 8
    db $F0, $E6, $0B, $10 ; entry 9
    db $E8, $E8, $14, $10 ; entry 10
    db $F8, $F6, $14, $10 ; entry 11
    db $E8, $E0, $1D, $10 ; entry 12
    db $F0, $DE, $1F, $70 ; entry 13
    db $80 ; end

; E-0147 (derived: frame 20 of MetaSprites3F_407ESet1C; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1CFrame20::
    db $80 ; end

; E-0147 (derived: meta-sprite set 29 of MetaSprites3F_407ETable: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3F_407ESet1D::
Data_03F_6DB6:: ; heuristic: meta-sprite set; C0
    dw MetaSprites3F_407ESet1DFrame0 ; entry 0
    dw MetaSprites3F_407ESet1DFrame1 ; entry 1
    dw MetaSprites3F_407ESet1DFrame2 ; entry 2
    dw MetaSprites3F_407ESet1DFrame3 ; entry 3
    dw MetaSprites3F_407ESet1DFrame4 ; entry 4
    dw MetaSprites3F_407ESet1DFrame5 ; entry 5
    dw MetaSprites3F_407ESet1DFrame6 ; entry 6
    dw MetaSprites3F_407ESet1DFrame6 ; entry 7
    dw MetaSprites3F_407ESet1DFrame6 ; entry 8
    dw MetaSprites3F_407ESet1DFrame6 ; entry 9
    dw MetaSprites3F_407ESet1DFrame6 ; entry 10
    dw MetaSprites3F_407ESet1DFrame6 ; entry 11
    dw MetaSprites3F_407ESet1DFrame6 ; entry 12
    dw MetaSprites3F_407ESet1DFrame6 ; entry 13
    dw MetaSprites3F_407ESet1DFrame6 ; entry 14
    dw MetaSprites3F_407ESet1DFrame6 ; entry 15
    dw MetaSprites3F_407ESet1DFrame6 ; entry 16
    dw MetaSprites3F_407ESet1DFrame6 ; entry 17
    dw MetaSprites3F_407ESet1DFrame6 ; entry 18
    dw MetaSprites3F_407ESet1DFrame6 ; entry 19
    dw MetaSprites3F_407ESet1DFrame6 ; entry 20
    dw MetaSprites3F_407ESet1DFrame6 ; entry 21
    dw MetaSprites3F_407ESet1DFrame6 ; entry 22
    dw MetaSprites3F_407ESet1DFrame6 ; entry 23
    dw MetaSprites3F_407ESet1DFrame6 ; entry 24
    dw MetaSprites3F_407ESet1DFrame6 ; entry 25
    dw MetaSprites3F_407ESet1DFrame6 ; entry 26
    dw MetaSprites3F_407ESet1DFrame6 ; entry 27
    dw MetaSprites3F_407ESet1DFrame6 ; entry 28
    dw MetaSprites3F_407ESet1DFrame6 ; entry 29
    dw MetaSprites3F_407ESet1DFrame6 ; entry 30
    dw MetaSprites3F_407ESet1DFrame6 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3F_407ESet1D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1DFrame0::
Data_03F_6DF6:: ; heuristic: meta-sprite frame; C0
    db $D8, $03, $00, $00 ; entry 0
    db $D8, $0B, $01, $00 ; entry 1
    db $D0, $03, $02, $00 ; entry 2
    db $D0, $0B, $03, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3F_407ESet1D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1DFrame1::
Data_03F_6E07:: ; heuristic: meta-sprite frame; C0
    db $DC, $00, $00, $00 ; entry 0
    db $DC, $08, $01, $00 ; entry 1
    db $D4, $00, $02, $00 ; entry 2
    db $D4, $08, $03, $00 ; entry 3
    db $CC, $04, $04, $00 ; entry 4
    db $E4, $F8, $00, $60 ; entry 5
    db $E4, $F0, $01, $60 ; entry 6
    db $EC, $F8, $02, $60 ; entry 7
    db $EC, $F0, $03, $60 ; entry 8
    db $F4, $F4, $04, $60 ; entry 9
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3F_407ESet1D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1DFrame2::
Data_03F_6E30:: ; heuristic: meta-sprite frame; C0
    db $F0, $FB, $05, $60 ; entry 0
    db $F0, $F3, $06, $60 ; entry 1
    db $E8, $03, $07, $60 ; entry 2
    db $E8, $FB, $08, $60 ; entry 3
    db $E8, $F3, $09, $60 ; entry 4
    db $E0, $03, $0A, $60 ; entry 5
    db $E0, $FB, $0B, $60 ; entry 6
    db $E0, $F3, $0C, $60 ; entry 7
    db $D8, $07, $0D, $60 ; entry 8
    db $D8, $FF, $0E, $60 ; entry 9
    db $D0, $08, $0F, $60 ; entry 10
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3F_407ESet1D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1DFrame3::
Data_03F_6E5D:: ; heuristic: meta-sprite frame; C0
    db $F0, $F3, $11, $00 ; entry 0
    db $E8, $F8, $11, $00 ; entry 1
    db $E0, $FE, $11, $00 ; entry 2
    db $D8, $03, $11, $00 ; entry 3
    db $D0, $08, $11, $00 ; entry 4
    db $F8, $EE, $11, $00 ; entry 5
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3F_407ESet1D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1DFrame4::
Data_03F_6E76:: ; heuristic: meta-sprite frame; C0
    db $F0, $F3, $11, $00 ; entry 0
    db $E8, $F8, $11, $00 ; entry 1
    db $F8, $EE, $11, $00 ; entry 2
    db $E0, $FE, $12, $00 ; entry 3
    db $D8, $03, $12, $00 ; entry 4
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3F_407ESet1D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1DFrame5::
Data_03F_6E8B:: ; heuristic: meta-sprite frame; C0
    db $F8, $EE, $12, $00 ; entry 0
    db $F0, $F3, $12, $00 ; entry 1
    db $E8, $F8, $12, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3F_407ESet1D; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1DFrame6::
    db $80 ; end

; E-0147 (derived: meta-sprite set 30 of MetaSprites3F_407ETable: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3F_407ESet1E::
Data_03F_6E99:: ; heuristic: meta-sprite set; C0
    dw MetaSprites3F_407ESet1EFrame0 ; entry 0
    dw MetaSprites3F_407ESet1EFrame1 ; entry 1
    dw MetaSprites3F_407ESet1EFrame2 ; entry 2
    dw MetaSprites3F_407ESet1EFrame3 ; entry 3
    dw MetaSprites3F_407ESet1EFrame4 ; entry 4
    dw MetaSprites3F_407ESet1EFrame5 ; entry 5
    dw MetaSprites3F_407ESet1EFrame6 ; entry 6
    dw MetaSprites3F_407ESet1EFrame7 ; entry 7
    dw MetaSprites3F_407ESet1EFrame8 ; entry 8
    dw MetaSprites3F_407ESet1EFrame9 ; entry 9
    dw MetaSprites3F_407ESet1EFrame10 ; entry 10
    dw MetaSprites3F_407ESet1EFrame11 ; entry 11
    dw MetaSprites3F_407ESet1EFrame12 ; entry 12
    dw MetaSprites3F_407ESet1EFrame13 ; entry 13
    dw MetaSprites3F_407ESet1EFrame14 ; entry 14
    dw MetaSprites3F_407ESet1EFrame15 ; entry 15
    dw MetaSprites3F_407ESet1EFrame16 ; entry 16
    dw MetaSprites3F_407ESet1EFrame17 ; entry 17
    dw MetaSprites3F_407ESet1EFrame18 ; entry 18
    dw MetaSprites3F_407ESet1EFrame19 ; entry 19
    dw MetaSprites3F_407ESet1EFrame20 ; entry 20
    dw MetaSprites3F_407ESet1EFrame20 ; entry 21
    dw MetaSprites3F_407ESet1EFrame20 ; entry 22
    dw MetaSprites3F_407ESet1EFrame20 ; entry 23
    dw MetaSprites3F_407ESet1EFrame20 ; entry 24
    dw MetaSprites3F_407ESet1EFrame20 ; entry 25
    dw MetaSprites3F_407ESet1EFrame20 ; entry 26
    dw MetaSprites3F_407ESet1EFrame20 ; entry 27
    dw MetaSprites3F_407ESet1EFrame20 ; entry 28
    dw MetaSprites3F_407ESet1EFrame20 ; entry 29
    dw MetaSprites3F_407ESet1EFrame20 ; entry 30
    dw MetaSprites3F_407ESet1EFrame20 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3F_407ESet1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1EFrame0::
Data_03F_6ED9:: ; heuristic: meta-sprite frame; C0
    db $D8, $03, $1C, $00 ; entry 0
    db $D8, $0B, $1D, $00 ; entry 1
    db $D0, $03, $1E, $00 ; entry 2
    db $D0, $0B, $1F, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3F_407ESet1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1EFrame1::
Data_03F_6EEA:: ; heuristic: meta-sprite frame; C0
    db $DC, $00, $1C, $00 ; entry 0
    db $DC, $08, $1D, $00 ; entry 1
    db $CF, $01, $26, $00 ; entry 2
    db $D4, $00, $1E, $00 ; entry 3
    db $D4, $08, $1F, $00 ; entry 4
    db $E4, $F8, $1C, $60 ; entry 5
    db $E4, $F0, $1D, $60 ; entry 6
    db $F1, $F7, $26, $60 ; entry 7
    db $EC, $F8, $1E, $60 ; entry 8
    db $EC, $F0, $1F, $60 ; entry 9
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3F_407ESet1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1EFrame2::
Data_03F_6F13:: ; heuristic: meta-sprite frame; C0
    db $D0, $00, $20, $00 ; entry 0
    db $D0, $08, $21, $00 ; entry 1
    db $D8, $FC, $22, $00 ; entry 2
    db $D8, $04, $23, $00 ; entry 3
    db $E0, $F8, $24, $00 ; entry 4
    db $E0, $00, $25, $00 ; entry 5
    db $E8, $F0, $26, $00 ; entry 6
    db $E8, $F8, $27, $00 ; entry 7
    db $F0, $F4, $28, $00 ; entry 8
    db $F8, $F0, $29, $00 ; entry 9
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3F_407ESet1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1EFrame3::
Data_03F_6F3C:: ; heuristic: meta-sprite frame; C0
    db $D8, $03, $21, $00 ; entry 0
    db $E0, $F7, $22, $00 ; entry 1
    db $E0, $FF, $23, $00 ; entry 2
    db $E8, $FB, $25, $00 ; entry 3
    db $F0, $EB, $26, $00 ; entry 4
    db $F0, $F3, $27, $00 ; entry 5
    db $F8, $EF, $28, $00 ; entry 6
    db $D0, $08, $2A, $00 ; entry 7
    db $D8, $FB, $2A, $00 ; entry 8
    db $E8, $F3, $2A, $00 ; entry 9
    db $E0, $EB, $2B, $00 ; entry 10
    db $D0, $00, $2B, $00 ; entry 11
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3F_407ESet1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1EFrame4::
Data_03F_6F6D:: ; heuristic: meta-sprite frame; C0
    db $D0, $08, $2C, $00 ; entry 0
    db $D8, $03, $2C, $00 ; entry 1
    db $E0, $FE, $2C, $00 ; entry 2
    db $E8, $F8, $2C, $00 ; entry 3
    db $F0, $F3, $2C, $00 ; entry 4
    db $F8, $EE, $2C, $00 ; entry 5
    db $F0, $EB, $2A, $00 ; entry 6
    db $E0, $F6, $2B, $00 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3F_407ESet1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1EFrame5::
Data_03F_6F8E:: ; heuristic: meta-sprite frame; C0
    db $E8, $F8, $2C, $00 ; entry 0
    db $F0, $F3, $2C, $00 ; entry 1
    db $F8, $EE, $2C, $00 ; entry 2
    db $D8, $03, $2D, $00 ; entry 3
    db $E0, $FE, $2D, $00 ; entry 4
    db $E8, $F0, $20, $00 ; entry 5
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3F_407ESet1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1EFrame6::
Data_03F_6FA7:: ; heuristic: meta-sprite frame; C0
    db $E8, $FA, $2D, $00 ; entry 0
    db $F0, $F5, $2D, $00 ; entry 1
    db $F8, $F0, $2D, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3F_407ESet1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1EFrame7::
Data_03F_6FB4:: ; heuristic: meta-sprite frame; C0
    db $F0, $FC, $27, $00 ; entry 0
    db $F8, $FC, $28, $00 ; entry 1
    db $E8, $FC, $24, $20 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites3F_407ESet1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1EFrame8::
Data_03F_6FC1:: ; heuristic: meta-sprite frame; C0
    db $E8, $FC, $02, $00 ; entry 0
    db $F0, $FC, $27, $20 ; entry 1
    db $F8, $FC, $27, $00 ; entry 2
    db $E0, $FC, $21, $20 ; entry 3
    db $F8, $F4, $21, $00 ; entry 4
    db $F0, $F0, $20, $00 ; entry 5
    db $F8, $04, $21, $20 ; entry 6
    db $F0, $08, $20, $20 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites3F_407ESet1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1EFrame9::
Data_03F_6FE2:: ; heuristic: meta-sprite frame; C0
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

; E-0147 (derived: frame 10 of MetaSprites3F_407ESet1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1EFrame10::
Data_03F_7007:: ; heuristic: meta-sprite frame; C0
    db $F8, $05, $11, $00 ; entry 0
    db $F8, $F5, $0F, $00 ; entry 1
    db $F0, $0B, $09, $20 ; entry 2
    db $F0, $03, $0A, $20 ; entry 3
    db $F0, $FB, $0B, $20 ; entry 4
    db $F0, $F3, $0C, $20 ; entry 5
    db $F0, $EB, $0D, $20 ; entry 6
    db $E8, $FF, $06, $20 ; entry 7
    db $E8, $F7, $07, $20 ; entry 8
    db $E8, $EF, $08, $20 ; entry 9
    db $E0, $01, $02, $20 ; entry 10
    db $E0, $F9, $03, $20 ; entry 11
    db $E0, $F1, $04, $20 ; entry 12
    db $D8, $FE, $00, $20 ; entry 13
    db $D8, $F6, $01, $20 ; entry 14
    db $E8, $07, $05, $20 ; entry 15
    db $F8, $ED, $17, $20 ; entry 16
    db $F8, $0D, $13, $20 ; entry 17
    db $F8, $FD, $19, $00 ; entry 18
    db $80 ; end

; E-0147 (derived: frame 11 of MetaSprites3F_407ESet1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1EFrame11::
Data_03F_7054:: ; heuristic: meta-sprite frame; C0
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

; E-0147 (derived: frame 12 of MetaSprites3F_407ESet1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1EFrame12::
Data_03F_70A1:: ; heuristic: meta-sprite frame; C0
    db $F8, $F4, $14, $00 ; entry 0
    db $F8, $FC, $15, $00 ; entry 1
    db $F8, $04, $16, $00 ; entry 2
    db $F0, $FD, $10, $00 ; entry 3
    db $F0, $05, $11, $00 ; entry 4
    db $F0, $0D, $12, $00 ; entry 5
    db $F0, $ED, $0E, $00 ; entry 6
    db $E8, $EB, $09, $00 ; entry 7
    db $E8, $F3, $0A, $00 ; entry 8
    db $E8, $FB, $0B, $00 ; entry 9
    db $E8, $03, $0C, $00 ; entry 10
    db $E8, $0B, $0D, $00 ; entry 11
    db $E0, $F7, $06, $00 ; entry 12
    db $E0, $FF, $07, $00 ; entry 13
    db $E0, $07, $08, $00 ; entry 14
    db $D8, $F5, $02, $00 ; entry 15
    db $D8, $FD, $03, $00 ; entry 16
    db $D0, $F8, $00, $00 ; entry 17
    db $D0, $00, $01, $00 ; entry 18
    db $E0, $EF, $05, $00 ; entry 19
    db $F0, $F5, $18, $00 ; entry 20
    db $F8, $0C, $1A, $00 ; entry 21
    db $F8, $EC, $13, $00 ; entry 22
    db $D8, $05, $0D, $00 ; entry 23
    db $80 ; end

; E-0147 (derived: frame 13 of MetaSprites3F_407ESet1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1EFrame13::
Data_03F_7102:: ; heuristic: meta-sprite frame; C0
    db $F8, $0C, $13, $20 ; entry 0
    db $F8, $04, $14, $20 ; entry 1
    db $F8, $EC, $17, $20 ; entry 2
    db $F0, $FB, $10, $20 ; entry 3
    db $F0, $F3, $11, $20 ; entry 4
    db $F0, $EB, $12, $20 ; entry 5
    db $F0, $0B, $0E, $20 ; entry 6
    db $F0, $03, $0F, $20 ; entry 7
    db $E8, $0D, $09, $20 ; entry 8
    db $E8, $05, $0A, $20 ; entry 9
    db $E8, $FD, $0B, $20 ; entry 10
    db $E8, $F5, $0C, $20 ; entry 11
    db $E8, $ED, $0D, $20 ; entry 12
    db $E0, $01, $06, $20 ; entry 13
    db $E0, $F9, $07, $20 ; entry 14
    db $E0, $F1, $08, $20 ; entry 15
    db $D8, $03, $02, $20 ; entry 16
    db $D8, $FB, $03, $20 ; entry 17
    db $D8, $F3, $04, $20 ; entry 18
    db $D0, $00, $00, $20 ; entry 19
    db $D0, $F8, $01, $20 ; entry 20
    db $E0, $09, $05, $20 ; entry 21
    db $F8, $F4, $18, $00 ; entry 22
    db $F8, $FC, $11, $00 ; entry 23
    db $80 ; end

; E-0147 (derived: frame 14 of MetaSprites3F_407ESet1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1EFrame14::
Data_03F_7163:: ; heuristic: meta-sprite frame; C0
    db $F8, $F0, $11, $20 ; entry 0
    db $F8, $E8, $13, $00 ; entry 1
    db $F8, $F8, $15, $00 ; entry 2
    db $F8, $08, $0F, $20 ; entry 3
    db $F0, $E8, $09, $00 ; entry 4
    db $F0, $F0, $0A, $00 ; entry 5
    db $F0, $F8, $0B, $00 ; entry 6
    db $F0, $08, $0C, $00 ; entry 7
    db $F8, $10, $13, $20 ; entry 8
    db $F0, $10, $09, $20 ; entry 9
    db $F8, $00, $0B, $00 ; entry 10
    db $F0, $00, $07, $00 ; entry 11
    db $E8, $F4, $02, $00 ; entry 12
    db $E8, $FC, $03, $00 ; entry 13
    db $E8, $04, $04, $00 ; entry 14
    db $E0, $F7, $00, $00 ; entry 15
    db $E0, $FF, $01, $00 ; entry 16
    db $E8, $0B, $24, $00 ; entry 17
    db $E8, $ED, $04, $20 ; entry 18
    db $80 ; end

; E-0147 (derived: frame 15 of MetaSprites3F_407ESet1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1EFrame15::
Data_03F_71B0:: ; heuristic: meta-sprite frame; C0
    db $F8, $05, $11, $00 ; entry 0
    db $F8, $F5, $0F, $00 ; entry 1
    db $F8, $ED, $17, $20 ; entry 2
    db $F8, $0D, $13, $20 ; entry 3
    db $F8, $FD, $19, $00 ; entry 4
    db $F0, $F8, $0B, $20 ; entry 5
    db $F0, $F0, $0C, $20 ; entry 6
    db $F0, $E8, $0D, $20 ; entry 7
    db $F0, $08, $0A, $20 ; entry 8
    db $F0, $00, $19, $00 ; entry 9
    db $E8, $F0, $07, $20 ; entry 10
    db $E8, $E8, $08, $20 ; entry 11
    db $E0, $F2, $03, $20 ; entry 12
    db $E0, $EA, $04, $20 ; entry 13
    db $D8, $EF, $01, $20 ; entry 14
    db $E8, $08, $06, $20 ; entry 15
Data_03F_71F0:: ; heuristic: label inside a table; C0
    db $E8, $00, $09, $00 ; entry 16
    db $E8, $F8, $09, $20 ; entry 17
    db $E8, $10, $0D, $00 ; entry 18
    db $E0, $04, $08, $20 ; entry 19
    db $E0, $0C, $05, $20 ; entry 20
    db $D8, $06, $04, $00 ; entry 21
    db $F0, $10, $1A, $00 ; entry 22
    db $80 ; end

; E-0147 (derived: frame 16 of MetaSprites3F_407ESet1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1EFrame16::
Data_03F_720D:: ; heuristic: meta-sprite frame; C0
    db $F8, $E8, $17, $20 ; entry 0
    db $F8, $F0, $18, $00 ; entry 1
    db $F8, $F8, $11, $00 ; entry 2
    db $F8, $10, $13, $20 ; entry 3
    db $F8, $08, $14, $20 ; entry 4
    db $F8, $00, $19, $00 ; entry 5
    db $F0, $F0, $11, $20 ; entry 6
    db $F0, $10, $0E, $20 ; entry 7
    db $F0, $08, $0F, $20 ; entry 8
    db $E8, $10, $09, $20 ; entry 9
    db $F0, $E8, $0E, $00 ; entry 10
    db $E8, $E8, $09, $00 ; entry 11
    db $E8, $F0, $04, $00 ; entry 12
    db $F0, $00, $04, $20 ; entry 13
    db $E8, $08, $02, $00 ; entry 14
    db $F0, $F8, $02, $20 ; entry 15
    db $E0, $0C, $27, $20 ; entry 16
    db $D0, $07, $24, $20 ; entry 17
    db $D8, $0C, $22, $20 ; entry 18
    db $D8, $04, $23, $20 ; entry 19
    db $E0, $EC, $27, $00 ; entry 20
    db $D0, $F1, $24, $00 ; entry 21
    db $D8, $EC, $22, $00 ; entry 22
    db $D8, $F4, $23, $00 ; entry 23
    db $D0, $E8, $2B, $00 ; entry 24
    db $D0, $10, $2B, $20 ; entry 25
    db $80 ; end

; E-0147 (derived: frame 17 of MetaSprites3F_407ESet1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1EFrame17::
Data_03F_7276:: ; heuristic: meta-sprite frame; C0
    db $D8, $0C, $22, $20 ; entry 0
    db $D8, $04, $23, $20 ; entry 1
    db $D8, $EC, $22, $00 ; entry 2
    db $D8, $F4, $23, $00 ; entry 3
    db $E8, $10, $0E, $20 ; entry 4
    db $F0, $10, $13, $20 ; entry 5
    db $F0, $E8, $13, $00 ; entry 6
    db $F0, $F0, $14, $00 ; entry 7
    db $F8, $F0, $1A, $20 ; entry 8
    db $F8, $F8, $0A, $00 ; entry 9
    db $F8, $00, $0C, $00 ; entry 10
    db $F8, $08, $12, $00 ; entry 11
    db $F0, $00, $09, $00 ; entry 12
    db $F0, $08, $0A, $00 ; entry 13
    db $E8, $08, $05, $00 ; entry 14
    db $E0, $08, $0D, $20 ; entry 15
    db $E0, $10, $09, $20 ; entry 16
    db $E8, $E8, $0E, $00 ; entry 17
    db $E8, $F0, $05, $20 ; entry 18
    db $E0, $F0, $0D, $00 ; entry 19
    db $E0, $E8, $09, $00 ; entry 20
    db $F0, $F8, $09, $20 ; entry 21
    db $E8, $00, $26, $00 ; entry 22
    db $E8, $F8, $20, $00 ; entry 23
    db $E0, $00, $21, $00 ; entry 24
    db $E0, $F8, $21, $20 ; entry 25
    db $D3, $00, $20, $00 ; entry 26
    db $D3, $F8, $20, $20 ; entry 27
    db $80 ; end

; E-0147 (derived: frame 18 of MetaSprites3F_407ESet1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1EFrame18::
Data_03F_72E7:: ; heuristic: meta-sprite frame; C0
    db $E4, $03, $06, $20 ; entry 0
    db $E4, $F3, $08, $20 ; entry 1
    db $DC, $05, $02, $20 ; entry 2
    db $DC, $F5, $04, $20 ; entry 3
    db $D4, $FC, $04, $20 ; entry 4
    db $D4, $FF, $02, $20 ; entry 5
    db $DC, $FD, $07, $20 ; entry 6
    db $E4, $FB, $0B, $20 ; entry 7
    db $E4, $09, $09, $20 ; entry 8
    db $EC, $F8, $0F, $40 ; entry 9
    db $EC, $F0, $12, $20 ; entry 10
    db $EC, $08, $17, $00 ; entry 11
    db $EC, $00, $18, $20 ; entry 12
    db $F4, $FB, $19, $00 ; entry 13
    db $F4, $03, $1A, $00 ; entry 14
    db $F4, $F3, $1A, $20 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 19 of MetaSprites3F_407ESet1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1EFrame19::
Data_03F_7328:: ; heuristic: meta-sprite frame; C0
    db $F8, $FC, $1B, $00 ; entry 0
    db $E0, $FC, $24, $00 ; entry 1
    db $E8, $FC, $03, $00 ; entry 2
    db $F0, $04, $12, $00 ; entry 3
    db $F0, $FC, $0C, $20 ; entry 4
    db $F0, $F4, $0D, $20 ; entry 5
    db $E8, $F4, $22, $00 ; entry 6
    db $E8, $04, $23, $00 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 20 of MetaSprites3F_407ESet1E; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1EFrame20::
    db $80 ; end

; E-0147 (derived: meta-sprite set 31 of MetaSprites3F_407ETable: 32 frame pointer(s), chosen by hSpriteSubIndex)
; record: frame
MetaSprites3F_407ESet1F::
Data_03F_734A:: ; heuristic: meta-sprite set; C0
    dw MetaSprites3F_407ESet1FFrame0 ; entry 0
    dw MetaSprites3F_407ESet1FFrame1 ; entry 1
    dw MetaSprites3F_407ESet1FFrame2 ; entry 2
    dw MetaSprites3F_407ESet1FFrame3 ; entry 3
    dw MetaSprites3F_407ESet1FFrame4 ; entry 4
    dw MetaSprites3F_407ESet1FFrame5 ; entry 5
    dw MetaSprites3F_407ESet1FFrame6 ; entry 6
    dw MetaSprites3F_407ESet1FFrame7 ; entry 7
    dw MetaSprites3F_407ESet1FFrame8 ; entry 8
    dw MetaSprites3F_407ESet1FFrame9 ; entry 9
    dw MetaSprites3F_407ESet1FFrame10 ; entry 10
    dw MetaSprites3F_407ESet1FFrame11 ; entry 11
    dw MetaSprites3F_407ESet1FFrame12 ; entry 12
    dw MetaSprites3F_407ESet1FFrame13 ; entry 13
    dw MetaSprites3F_407ESet1FFrame14 ; entry 14
    dw MetaSprites3F_407ESet1FFrame15 ; entry 15
    dw MetaSprites3F_407ESet1FFrame16 ; entry 16
    dw MetaSprites3F_407ESet1FFrame17 ; entry 17
    dw MetaSprites3F_407ESet1FFrame17 ; entry 18
    dw MetaSprites3F_407ESet1FFrame17 ; entry 19
    dw MetaSprites3F_407ESet1FFrame17 ; entry 20
    dw MetaSprites3F_407ESet1FFrame17 ; entry 21
    dw MetaSprites3F_407ESet1FFrame17 ; entry 22
    dw MetaSprites3F_407ESet1FFrame17 ; entry 23
    dw MetaSprites3F_407ESet1FFrame17 ; entry 24
    dw MetaSprites3F_407ESet1FFrame17 ; entry 25
    dw MetaSprites3F_407ESet1FFrame17 ; entry 26
    dw MetaSprites3F_407ESet1FFrame17 ; entry 27
    dw MetaSprites3F_407ESet1FFrame17 ; entry 28
    dw MetaSprites3F_407ESet1FFrame17 ; entry 29
    dw MetaSprites3F_407ESet1FFrame17 ; entry 30
    dw MetaSprites3F_407ESet1FFrame17 ; entry 31

; E-0147 (derived: frame 0 of MetaSprites3F_407ESet1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1FFrame0::
Data_03F_738A:: ; heuristic: meta-sprite frame; C0
    db $D8, $03, $20, $00 ; entry 0
    db $D8, $0B, $21, $00 ; entry 1
    db $D0, $03, $22, $00 ; entry 2
    db $D0, $0B, $23, $00 ; entry 3
    db $80 ; end

; E-0147 (derived: frame 1 of MetaSprites3F_407ESet1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1FFrame1::
Data_03F_739B:: ; heuristic: meta-sprite frame; C0
    db $DC, $00, $20, $00 ; entry 0
    db $DC, $08, $21, $00 ; entry 1
    db $D4, $00, $22, $00 ; entry 2
    db $D4, $08, $23, $00 ; entry 3
    db $E4, $F8, $20, $60 ; entry 4
    db $E4, $F0, $21, $60 ; entry 5
    db $EC, $F8, $22, $60 ; entry 6
    db $EC, $F0, $23, $60 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 2 of MetaSprites3F_407ESet1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1FFrame2::
Data_03F_73BC:: ; heuristic: meta-sprite frame; C0
    db $D0, $00, $24, $00 ; entry 0
    db $D0, $08, $25, $00 ; entry 1
    db $D8, $FC, $26, $00 ; entry 2
    db $D8, $04, $27, $00 ; entry 3
    db $E0, $F8, $28, $00 ; entry 4
    db $E0, $00, $29, $00 ; entry 5
    db $E8, $F0, $2A, $00 ; entry 6
    db $E8, $F8, $2B, $00 ; entry 7
    db $F0, $F4, $2C, $00 ; entry 8
    db $F8, $F0, $2D, $00 ; entry 9
    db $80 ; end

; E-0147 (derived: frame 3 of MetaSprites3F_407ESet1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1FFrame3::
Data_03F_73E5:: ; heuristic: meta-sprite frame; C0
    db $D8, $FB, $24, $00 ; entry 0
    db $D8, $03, $25, $00 ; entry 1
    db $E0, $F7, $26, $00 ; entry 2
    db $E0, $FF, $27, $00 ; entry 3
    db $E8, $F3, $28, $00 ; entry 4
    db $E8, $FB, $29, $00 ; entry 5
    db $F0, $EB, $2A, $00 ; entry 6
    db $F0, $F3, $2B, $00 ; entry 7
    db $F8, $EF, $2C, $00 ; entry 8
    db $D0, $08, $05, $00 ; entry 9
    db $D0, $00, $24, $00 ; entry 10
    db $E8, $EB, $12, $00 ; entry 11
    db $80 ; end

; E-0147 (derived: frame 4 of MetaSprites3F_407ESet1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1FFrame4::
Data_03F_7416:: ; heuristic: meta-sprite frame; C0
    db $F8, $EE, $2E, $00 ; entry 0
    db $F0, $F3, $2E, $00 ; entry 1
    db $E8, $F8, $2E, $00 ; entry 2
    db $E0, $FE, $2E, $00 ; entry 3
    db $D8, $03, $2E, $00 ; entry 4
    db $D0, $08, $2E, $00 ; entry 5
    db $F0, $EB, $11, $20 ; entry 6
    db $E0, $F6, $0B, $20 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 5 of MetaSprites3F_407ESet1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1FFrame5::
Data_03F_7437:: ; heuristic: meta-sprite frame; C0
    db $E8, $F0, $24, $00 ; entry 0
    db $F0, $F3, $2E, $00 ; entry 1
    db $E8, $F8, $2E, $00 ; entry 2
    db $E0, $FE, $2F, $00 ; entry 3
    db $D8, $03, $2F, $00 ; entry 4
    db $F8, $EE, $2E, $00 ; entry 5
    db $80 ; end

; E-0147 (derived: frame 6 of MetaSprites3F_407ESet1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1FFrame6::
Data_03F_7450:: ; heuristic: meta-sprite frame; C0
    db $F8, $F0, $2F, $00 ; entry 0
    db $F0, $F5, $2F, $00 ; entry 1
    db $E8, $FA, $2F, $00 ; entry 2
    db $80 ; end

; E-0147 (derived: frame 7 of MetaSprites3F_407ESet1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1FFrame7::
Data_03F_745D:: ; heuristic: meta-sprite frame; C0
    db $E8, $F8, $05, $00 ; entry 0
    db $E8, $00, $13, $00 ; entry 1
    db $E0, $00, $0C, $60 ; entry 2
    db $E0, $F8, $0B, $20 ; entry 3
    db $D8, $F3, $01, $20 ; entry 4
    db $EE, $F2, $00, $60 ; entry 5
    db $ED, $07, $01, $40 ; entry 6
    db $DD, $04, $00, $00 ; entry 7
    db $80 ; end

; E-0147 (derived: frame 8 of MetaSprites3F_407ESet1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1FFrame8::
Data_03F_747E:: ; heuristic: meta-sprite frame; C0
    db $E8, $F8, $03, $00 ; entry 0
    db $E8, $F0, $02, $00 ; entry 1
    db $E0, $00, $03, $60 ; entry 2
    db $E0, $08, $02, $60 ; entry 3
    db $E0, $F8, $0D, $00 ; entry 4
    db $E8, $00, $0D, $00 ; entry 5
    db $F0, $00, $05, $00 ; entry 6
    db $D8, $F8, $05, $60 ; entry 7
    db $D6, $F0, $00, $20 ; entry 8
    db $D6, $08, $01, $00 ; entry 9
    db $F2, $F0, $01, $60 ; entry 10
    db $F2, $08, $00, $40 ; entry 11
    db $80 ; end

; E-0147 (derived: frame 9 of MetaSprites3F_407ESet1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1FFrame9::
Data_03F_74AF:: ; heuristic: meta-sprite frame; C0
    db $EC, $F0, $08, $00 ; entry 0
    db $EC, $F8, $09, $00 ; entry 1
    db $EC, $08, $0C, $60 ; entry 2
    db $EC, $00, $0D, $60 ; entry 3
    db $DC, $F0, $0E, $40 ; entry 4
    db $DC, $F8, $0F, $40 ; entry 5
    db $DC, $00, $18, $40 ; entry 6
    db $DC, $08, $19, $40 ; entry 7
    db $E4, $F8, $10, $00 ; entry 8
    db $E4, $00, $11, $00 ; entry 9
    db $D4, $03, $05, $60 ; entry 10
    db $F4, $0B, $02, $20 ; entry 11
    db $F4, $03, $03, $20 ; entry 12
    db $D4, $F5, $19, $00 ; entry 13
    db $F4, $F4, $05, $00 ; entry 14
    db $80 ; end

; E-0147 (derived: frame 10 of MetaSprites3F_407ESet1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1FFrame10::
Data_03F_74EC:: ; heuristic: meta-sprite frame; C0
    db $D0, $F8, $0C, $00 ; entry 0
    db $D0, $00, $0D, $00 ; entry 1
    db $D7, $01, $05, $00 ; entry 2
    db $F8, $F8, $08, $20 ; entry 3
    db $F8, $F0, $18, $00 ; entry 4
    db $F0, $EA, $05, $40 ; entry 5
    db $D8, $0C, $01, $00 ; entry 6
    db $F8, $E8, $01, $20 ; entry 7
    db $D5, $F0, $08, $60 ; entry 8
Data_03F_7510:: ; heuristic: label inside a table; C0
    db $D5, $E8, $09, $60 ; entry 9
    db $DD, $EA, $05, $20 ; entry 10
    db $F4, $04, $02, $40 ; entry 11
    db $F8, $0C, $03, $00 ; entry 12
    db $F4, $10, $02, $60 ; entry 13
    db $80 ; end

; E-0147 (derived: frame 11 of MetaSprites3F_407ESet1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1FFrame11::
Data_03F_7525:: ; heuristic: meta-sprite frame; C0
    db $D0, $00, $16, $20 ; entry 0
    db $D0, $F8, $17, $20 ; entry 1
    db $D8, $00, $18, $20 ; entry 2
    db $D8, $F8, $19, $20 ; entry 3
    db $E0, $FC, $18, $20 ; entry 4
    db $E0, $F4, $19, $20 ; entry 5
    db $E8, $F8, $05, $00 ; entry 6
    db $DE, $E3, $0B, $60 ; entry 7
    db $E8, $EC, $01, $00 ; entry 8
    db $F8, $10, $18, $00 ; entry 9
    db $F8, $00, $01, $00 ; entry 10
    db $F8, $F8, $01, $20 ; entry 11
    db $80 ; end

; E-0147 (derived: frame 12 of MetaSprites3F_407ESet1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1FFrame12::
Data_03F_7556:: ; heuristic: meta-sprite frame; C0
    db $D0, $01, $06, $20 ; entry 0
    db $D0, $F9, $07, $20 ; entry 1
    db $D8, $03, $08, $20 ; entry 2
    db $D8, $FB, $09, $20 ; entry 3
    db $E0, $00, $0A, $20 ; entry 4
    db $E0, $F8, $0B, $20 ; entry 5
    db $E8, $05, $0C, $20 ; entry 6
    db $E8, $FD, $0D, $20 ; entry 7
    db $F0, $05, $0E, $20 ; entry 8
    db $F0, $FD, $0F, $20 ; entry 9
    db $F8, $00, $10, $20 ; entry 10
    db $F8, $F8, $11, $20 ; entry 11
    db $F8, $F4, $1D, $20 ; entry 12
    db $F8, $02, $1D, $00 ; entry 13
    db $D0, $10, $1B, $00 ; entry 14
    db $D0, $08, $1B, $00 ; entry 15
    db $D8, $0B, $1B, $00 ; entry 16
    db $D8, $10, $1B, $00 ; entry 17
    db $E0, $10, $1B, $00 ; entry 18
    db $E0, $08, $1B, $00 ; entry 19
    db $E8, $10, $1B, $00 ; entry 20
    db $F0, $10, $1B, $00 ; entry 21
    db $F8, $10, $1B, $00 ; entry 22
    db $F8, $0A, $1B, $00 ; entry 23
    db $D0, $F0, $1B, $20 ; entry 24
    db $D8, $F0, $1B, $20 ; entry 25
    db $E0, $F0, $1B, $20 ; entry 26
    db $E8, $F0, $1B, $20 ; entry 27
    db $F0, $F0, $1B, $20 ; entry 28
    db $F8, $F0, $1B, $20 ; entry 29
    db $D0, $E8, $1B, $20 ; entry 30
    db $D8, $E8, $1B, $20 ; entry 31
    db $E0, $E8, $1B, $20 ; entry 32
    db $E8, $E8, $1B, $20 ; entry 33
    db $F0, $E8, $1B, $20 ; entry 34
    db $F8, $E8, $1B, $20 ; entry 35
    db $E8, $F5, $1B, $20 ; entry 36
    db $F0, $F5, $1B, $20 ; entry 37
    db $80 ; end

; E-0147 (derived: frame 13 of MetaSprites3F_407ESet1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1FFrame13::
Data_03F_75EF:: ; heuristic: meta-sprite frame; C0
    db $D0, $02, $0C, $20 ; entry 0
    db $D0, $FA, $0D, $20 ; entry 1
    db $D8, $F1, $16, $00 ; entry 2
    db $D8, $F9, $17, $00 ; entry 3
    db $E0, $F7, $16, $20 ; entry 4
    db $E0, $EF, $17, $20 ; entry 5
    db $E8, $F7, $18, $20 ; entry 6
    db $E8, $EF, $19, $20 ; entry 7
    db $F0, $F7, $1A, $20 ; entry 8
    db $E5, $FE, $06, $20 ; entry 9
    db $ED, $01, $05, $20 ; entry 10
    db $F8, $FC, $1E, $00 ; entry 11
    db $F8, $04, $1F, $00 ; entry 12
    db $F8, $F4, $1E, $20 ; entry 13
    db $F8, $EC, $1F, $20 ; entry 14
    db $F0, $EF, $0C, $00 ; entry 15
    db $80 ; end

; E-0147 (derived: frame 14 of MetaSprites3F_407ESet1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1FFrame14::
Data_03F_7630:: ; heuristic: meta-sprite frame; C0
    db $D8, $0B, $08, $20 ; entry 0
    db $D8, $03, $09, $20 ; entry 1
    db $D0, $01, $18, $00 ; entry 2
    db $D0, $09, $19, $00 ; entry 3
    db $E0, $05, $14, $00 ; entry 4
    db $E0, $0D, $15, $00 ; entry 5
    db $E8, $06, $0C, $00 ; entry 6
    db $E8, $0E, $0D, $00 ; entry 7
    db $F0, $05, $0E, $00 ; entry 8
    db $F0, $0D, $0F, $00 ; entry 9
    db $E8, $03, $0D, $20 ; entry 10
    db $F0, $FE, $0C, $00 ; entry 11
    db $F8, $0C, $1C, $00 ; entry 12
    db $F8, $04, $1C, $20 ; entry 13
    db $F8, $FC, $1D, $20 ; entry 14
    db $D0, $E8, $1B, $00 ; entry 15
    db $D8, $E8, $1B, $00 ; entry 16
    db $E0, $E8, $1B, $00 ; entry 17
    db $E8, $E8, $1B, $00 ; entry 18
    db $F0, $E9, $1B, $00 ; entry 19
    db $F8, $E9, $1B, $00 ; entry 20
    db $D0, $F0, $1B, $00 ; entry 21
    db $D8, $F1, $1B, $00 ; entry 22
    db $E0, $F2, $1B, $00 ; entry 23
    db $E8, $F1, $1B, $00 ; entry 24
    db $F0, $F3, $1B, $00 ; entry 25
    db $F8, $F3, $1B, $00 ; entry 26
    db $D0, $F8, $1B, $00 ; entry 27
    db $D8, $FA, $1B, $00 ; entry 28
    db $E8, $FA, $1B, $00 ; entry 29
    db $E0, $FC, $1B, $00 ; entry 30
    db $D0, $10, $1B, $20 ; entry 31
    db $F8, $14, $1F, $00 ; entry 32
    db $80 ; end

; E-0147 (derived: frame 15 of MetaSprites3F_407ESet1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1FFrame15::
Data_03F_76B5:: ; heuristic: meta-sprite frame; C0
    db $F8, $00, $1F, $00 ; entry 0
    db $D0, $03, $14, $20 ; entry 1
    db $D0, $FB, $15, $20 ; entry 2
    db $D8, $09, $0A, $20 ; entry 3
    db $D8, $01, $0B, $20 ; entry 4
    db $F8, $0F, $1E, $00 ; entry 5
    db $F8, $17, $1F, $00 ; entry 6
    db $F8, $07, $1E, $20 ; entry 7
    db $E0, $08, $16, $40 ; entry 8
    db $E0, $10, $17, $40 ; entry 9
    db $E8, $11, $0C, $20 ; entry 10
    db $E8, $09, $0D, $20 ; entry 11
    db $F0, $10, $0E, $20 ; entry 12
    db $F0, $08, $0F, $20 ; entry 13
    db $E8, $FA, $14, $60 ; entry 14
    db $E8, $F2, $15, $60 ; entry 15
    db $F0, $FA, $10, $20 ; entry 16
    db $F0, $F2, $11, $20 ; entry 17
    db $F8, $F0, $1C, $20 ; entry 18
    db $F8, $F8, $1C, $00 ; entry 19
    db $F8, $00, $1D, $00 ; entry 20
    db $E0, $F3, $0B, $60 ; entry 21
    db $F8, $E8, $1D, $20 ; entry 22
    db $DC, $F3, $0C, $00 ; entry 23
    db $D8, $FA, $09, $00 ; entry 24
    db $E0, $FB, $0A, $60 ; entry 25
    db $80 ; end

; E-0147 (derived: frame 16 of MetaSprites3F_407ESet1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1FFrame16::
Data_03F_771E:: ; heuristic: meta-sprite frame; C0
    db $D0, $FE, $10, $20 ; entry 0
    db $D0, $F6, $11, $20 ; entry 1
    db $D8, $F4, $12, $40 ; entry 2
    db $D8, $FC, $13, $40 ; entry 3
    db $E8, $F6, $10, $20 ; entry 4
    db $E8, $EE, $11, $20 ; entry 5
    db $F0, $F0, $18, $20 ; entry 6
    db $D8, $06, $14, $00 ; entry 7
    db $D8, $0E, $15, $00 ; entry 8
    db $E0, $0F, $10, $20 ; entry 9
    db $E0, $07, $11, $20 ; entry 10
    db $E8, $04, $06, $00 ; entry 11
    db $E8, $0C, $07, $00 ; entry 12
    db $F0, $01, $14, $00 ; entry 13
    db $F0, $09, $15, $00 ; entry 14
    db $F8, $10, $1F, $00 ; entry 15
    db $F8, $01, $1E, $20 ; entry 16
    db $F8, $09, $1E, $00 ; entry 17
    db $F0, $0C, $04, $00 ; entry 18
    db $F8, $10, $05, $20 ; entry 19
    db $D0, $02, $12, $00 ; entry 20
    db $D0, $0A, $13, $00 ; entry 21
    db $F8, $F9, $1F, $20 ; entry 22
    db $F8, $F4, $1C, $00 ; entry 23
    db $F8, $FC, $1D, $00 ; entry 24
    db $F8, $EC, $1C, $20 ; entry 25
    db $F0, $F8, $1B, $00 ; entry 26
    db $F8, $E4, $1F, $20 ; entry 27
    db $D0, $E8, $1B, $20 ; entry 28
    db $D8, $E8, $1B, $20 ; entry 29
    db $E0, $E8, $1B, $20 ; entry 30
    db $D0, $10, $1B, $00 ; entry 31
    db $E8, $FD, $1B, $00 ; entry 32
    db $F0, $E8, $0E, $00 ; entry 33
    db $E0, $F6, $14, $00 ; entry 34
    db $E0, $FE, $15, $00 ; entry 35
    db $80 ; end

; E-0147 (derived: frame 17 of MetaSprites3F_407ESet1F; ends with $80)
; record: sprite: Y offset, X offset, tile, attribute
MetaSprites3F_407ESet1FFrame17::
    db $80 ; end
    ds $850, $00
