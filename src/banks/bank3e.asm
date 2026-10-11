SECTION "Bank 3E", ROMX[$4000], BANK[$3E]
    db $3E

; sets the sprite origin X = wD804, Y = $68, tile offset = wD801, attribute XOR = wDAB7, then builds OAM from the local sprite table (E-0121)
; 1 call site from 1 routine (e.g. DrawEffectSpriteForWD801Range)
; reads: wEffectSpriteX, wEffectTileOffset, wEffectSpriteAttrXor
; points at: hSpriteOriginX
DrawEffectSpriteAtWD804_Bank3E::
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

Data_03E_4024:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_03E_4091
    dw Data_03E_419E
    dw Data_03E_44C2
    dw Data_03E_485F
    dw Data_03E_4B1E
    dw Data_03E_4ECD
    dw Data_03E_52CD
    dw Data_03E_53A7
    dw Data_03E_5619
    dw Data_03E_6026
    dw Data_03E_61FC
    dw Data_03E_671A
    dw Data_03E_7616
    dw Data_03E_7A3A

; DE = two-level table; entries are chosen by hSpriteSetIndex and hSpriteSubIndex; writes 4-byte OAM entries at $C000 + 4 * hOamNextEntry (Y = hSpriteOriginY + b + $10, X = hSpriteOriginX + b + 8, tile += hSpriteTileOffset, flags ^= hSpriteAttrXor) until a $80 byte or hOamNextEntry reaches $28 (40 entries) (the same 81 bytes appear in 5 banks)
; 1 call site from 1 routine (e.g. DrawEffectSpriteAtWD804_Bank3E)
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

Data_03E_4091:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03E_40D1
    dw Data_03E_40DA
    dw Data_03E_40F3
    dw Data_03E_4110
    dw Data_03E_4135
    dw Data_03E_415A
    dw Data_03E_4173
    dw Data_03E_418C
    dw Data_03E_419D
    dw Data_03E_419D
    dw Data_03E_419D
    dw Data_03E_419D
    dw Data_03E_419D
    dw Data_03E_419D
    dw Data_03E_419D
    dw Data_03E_419D
    dw Data_03E_419D
    dw Data_03E_419D
    dw Data_03E_419D
    dw Data_03E_419D
    dw Data_03E_419D
    dw Data_03E_419D
    dw Data_03E_419D
    dw Data_03E_419D
    dw Data_03E_419D
    dw Data_03E_419D
    dw Data_03E_419D
    dw Data_03E_419D
    dw Data_03E_419D
    dw Data_03E_419D
    dw Data_03E_419D
    dw Data_03E_419D

Data_03E_40D1:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F8, $00, $00, $F8, $00, $01, $00, $80

Data_03E_40DA:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $00, $00, $20, $F0, $F8, $01, $20, $F8, $08, $02, $20, $F8, $00, $03, $20
    db $F8, $F8, $04, $20, $F8, $F0, $05, $20, $80

Data_03E_40F3:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $FC, $06, $00, $E8, $F8, $00, $00, $E8, $00, $01, $00, $F0, $F0, $02, $00
    db $F0, $F8, $03, $00, $F0, $00, $04, $00, $F0, $08, $05, $00, $80

Data_03E_4110:: ; heuristic: target of a monotone pointer table; C0
    db $DE, $F8, $07, $00, $E6, $F0, $08, $00, $E6, $F8, $09, $00, $E6, $00, $0A, $00
    db $E6, $08, $0B, $00, $EE, $F8, $0C, $00, $EE, $00, $0D, $00, $EE, $08, $0E, $00
    db $F6, $00, $0F, $00, $80

Data_03E_4135:: ; heuristic: target of a monotone pointer table; C0
    db $F3, $01
    dw Data_03E_6007
    db $EB, $09
    dw Data_03E_6008
    db $EB, $01
    dw Data_03E_6009
    db $EB, $F9
    dw Data_03E_600A
    db $EB, $F1
    dw Data_03E_600B
    db $E3, $01
    dw Data_03E_600C
    db $E3, $F9
    dw Data_03E_600D
    db $E3, $F1
    dw Data_03E_600E
    db $DB, $F9
    dw Data_03E_600F
    db $80

Data_03E_415A:: ; heuristic: target of a monotone pointer table; C0
    db $EE, $F8, $14, $00, $EE, $00, $15, $00, $E6, $F8, $11, $00, $E6, $00, $12, $00
    db $E6, $08, $13, $00, $DE, $00, $10, $00, $80

Data_03E_4173:: ; heuristic: target of a monotone pointer table; C0
    db $E7, $01, $14, $60, $E7, $F9, $15, $60, $EF, $01, $11, $60, $EF, $F9, $12, $60
    db $EF, $F1, $13, $60, $F7, $F9, $10, $60, $80

Data_03E_418C:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $F7, $16, $00, $E8, $FF, $17, $00, $F0, $F7, $18, $00, $F0, $FF, $19, $00
    db $80

Data_03E_419D:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03E_419E:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03E_41DE
    dw Data_03E_41E7
    dw Data_03E_41FC
    dw Data_03E_4221
    dw Data_03E_4256
    dw Data_03E_4293
    dw Data_03E_42B4
    dw Data_03E_42D5
    dw Data_03E_42E2
    dw Data_03E_4307
    dw Data_03E_4344
    dw Data_03E_4391
    dw Data_03E_43F6
    dw Data_03E_444B
    dw Data_03E_4494
    dw Data_03E_44C1
    dw Data_03E_44C1
    dw Data_03E_44C1
    dw Data_03E_44C1
    dw Data_03E_44C1
    dw Data_03E_44C1
    dw Data_03E_44C1
    dw Data_03E_44C1
    dw Data_03E_44C1
    dw Data_03E_44C1
    dw Data_03E_44C1
    dw Data_03E_44C1
    dw Data_03E_44C1
    dw Data_03E_44C1
    dw Data_03E_44C1
    dw Data_03E_44C1
    dw Data_03E_44C1

Data_03E_41DE:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F8, $00, $00, $F8, $00, $01, $00, $80

Data_03E_41E7:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $FB, $03, $20, $F0, $00, $00, $20, $F8, $F3, $0D, $20, $F8, $03, $05, $20
    db $F0, $F8, $04, $20, $80

Data_03E_41FC:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $F6, $02, $00, $E8, $F9, $00, $00, $F8, $F0, $05, $00, $F8, $08, $05, $20
    db $F0, $03, $02, $20, $F0, $FE, $03, $00, $E8, $FF, $04, $00, $F8, $F8, $18, $00
    db $F8, $00, $18, $20, $80

Data_03E_4221:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $F5, $06, $00, $F0, $05, $08, $00, $E8, $F3, $02, $00, $E8, $03, $04, $00
    db $E0, $FC, $04, $00, $E0, $F9, $02, $00, $E8, $FB, $07, $00, $F0, $FD, $0B, $00
    db $F0, $EF, $09, $00, $F8, $00, $0F, $60, $F8, $F8, $18, $40, $F8, $08, $12, $00
    db $F8, $F0, $17, $20, $80

Data_03E_4256:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $03, $06, $20, $E8, $F3, $08, $20, $E0, $05, $02, $20, $E0, $F5, $04, $20
    db $D8, $FC, $04, $20, $D8, $FF, $02, $20, $E0, $FD, $07, $20, $E8, $FB, $0B, $20
    db $E8, $09, $09, $20, $F0, $F8, $0F, $40, $F0, $F0, $12, $20, $F0, $08, $17, $00
    db $F0, $00, $18, $20, $F8, $F8, $23, $00, $F8, $00, $23, $20, $80

Data_03E_4293:: ; heuristic: target of a monotone pointer table; C0
    db $D4, $FC, $1B, $20, $DC, $04, $1C, $20, $DC, $FC, $1D, $20, $DC, $F4, $1E, $20
    db $E4, $04, $1F, $20, $E4, $FC, $20, $20, $E4, $F4, $21, $20, $EC, $FC, $22, $20
    db $80

Data_03E_42B4:: ; heuristic: target of a monotone pointer table; C0
    db $D8, $FC, $1B, $00, $E0, $F4, $1C, $00, $E0, $FC, $1D, $00, $E0, $04, $1E, $00
    db $E8, $F4, $1F, $00, $E8, $FC, $20, $00, $E8, $04, $21, $00, $F0, $FC, $22, $00
    db $80

Data_03E_42D5:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $FC, $25, $20, $E0, $FC, $24, $20, $F0, $FC, $22, $20, $80

Data_03E_42E2:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $F6, $02, $00, $E8, $F9, $00, $00, $F8, $F0, $05, $00, $F8, $08, $05, $20
    db $F0, $03, $02, $20, $F0, $FE, $03, $00, $E8, $FF, $04, $00, $F8, $F8, $18, $00
    db $F8, $00, $18, $20, $80

Data_03E_4307:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $05, $11, $00, $F8, $F5, $0F, $00, $F0, $0B, $09, $20, $F8, $ED, $17, $20
    db $F8, $0D, $13, $20, $F8, $FD, $20, $00, $F0, $03, $0C, $00, $F0, $FB, $18, $00
    db $E8, $06, $02, $20, $E8, $FE, $03, $20, $E8, $F6, $04, $20, $D8, $FD, $24, $20
    db $E0, $FD, $25, $20, $F0, $F3, $09, $00, $F0, $ED, $05, $00, $80

Data_03E_4344:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F8344, $4D

Data_03E_4391:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F8391, $65

Data_03E_43F6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F83F6, $55

Data_03E_444B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F844B, $49

Data_03E_4494:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $FC, $1B, $20, $D8, $04, $1C, $20, $D8, $FC, $1D, $20, $D8, $F4, $1E, $20
    db $E0, $04, $1F, $20, $E0, $FC, $20, $20, $E0, $F4, $21, $20, $E8, $FC, $25, $00
    db $F0, $FC, $22, $00, $E8, $03, $21, $00, $E8, $F5, $1F, $00, $80

Data_03E_44C1:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03E_44C2:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03E_4502
    dw Data_03E_452B
    dw Data_03E_4564
    dw Data_03E_45AD
    dw Data_03E_4616
    dw Data_03E_467F
    dw Data_03E_46E8
    dw Data_03E_4751
    dw Data_03E_47BA
    dw Data_03E_47C3
    dw Data_03E_47DC
    dw Data_03E_4801
    dw Data_03E_4826
    dw Data_03E_4837
    dw Data_03E_4848
    dw Data_03E_4859
    dw Data_03E_485E
    dw Data_03E_485E
    dw Data_03E_485E
    dw Data_03E_485E
    dw Data_03E_485E
    dw Data_03E_485E
    dw Data_03E_485E
    dw Data_03E_485E
    dw Data_03E_485E
    dw Data_03E_485E
    dw Data_03E_485E
    dw Data_03E_485E
    dw Data_03E_485E
    dw Data_03E_485E
    dw Data_03E_485E
    dw Data_03E_485E

Data_03E_4502:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $F0, $00, $00, $F0, $F8, $01, $00, $F0, $00, $02, $00, $F0, $08, $03, $00
    db $F8, $F0, $15, $00, $F8, $F8, $16, $00, $F8, $08, $15, $20, $F8, $00, $16, $20
    db $F8, $10, $19, $00, $F8, $E8, $19, $20, $80

Data_03E_452B:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $08, $00, $20, $E8, $00, $01, $20, $E8, $F8, $02, $20, $E8, $F0, $03, $20
    db $F0, $08, $10, $20, $F0, $00, $11, $20, $F0, $F8, $12, $20, $F0, $F0, $13, $20
    db $F8, $F8, $17, $20, $F8, $F0, $18, $20, $F8, $00, $17, $00, $F8, $08, $18, $00
    db $F8, $10, $1A, $00, $F8, $E8, $1A, $20, $80

Data_03E_4564:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F8564, $49

Data_03E_45AD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F85AD, $69

Data_03E_4616:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F8616, $69

Data_03E_467F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F867F, $69

Data_03E_46E8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F86E8, $69

Data_03E_4751:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F8751, $69

Data_03E_47BA:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F8, $1B, $00, $F8, $00, $1B, $20, $80

Data_03E_47C3:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $F8, $1C, $00, $F0, $00, $1D, $00, $F8, $F8, $1E, $00, $F8, $00, $1F, $00
    db $F8, $07, $27, $00, $F8, $F1, $26, $00, $80

Data_03E_47DC:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $00, $1C, $20, $E8, $F8, $1D, $20, $F0, $00, $1E, $20, $F0, $F8, $1F, $20
    db $F7, $FC, $25, $00, $F0, $07, $26, $20, $F6, $03, $27, $00, $F4, $F4, $26, $00
    db $F0, $F1, $27, $20, $80

Data_03E_4801:: ; heuristic: target of a monotone pointer table; C0
    db $E4, $F8, $1C, $00, $E4, $00, $1D, $00, $EC, $F8, $1E, $00, $EC, $00, $1F, $00
    db $F3, $FC, $25, $20, $EC, $F1, $26, $00, $F2, $F5, $27, $20, $F0, $04, $26, $20
    db $EC, $07, $27, $00, $80

Data_03E_4826:: ; heuristic: target of a monotone pointer table; C0
    db $E4, $F8, $20, $00, $E4, $00, $21, $00, $EC, $F8, $22, $00, $EC, $00, $23, $00
    db $80

Data_03E_4837:: ; heuristic: target of a monotone pointer table; C0
    db $E6, $00, $20, $20, $E6, $F8, $21, $20, $EE, $00, $22, $20, $EE, $F8, $23, $20
    db $80

Data_03E_4848:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $F8, $20, $00, $E8, $00, $21, $00, $F0, $F8, $22, $00, $F0, $00, $23, $00
    db $80

Data_03E_4859:: ; heuristic: target of a monotone pointer table; C0
    db $EC, $FC, $24, $00, $80

Data_03E_485E:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03E_485F:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03E_489F
    dw Data_03E_48AC
    dw Data_03E_48BD
    dw Data_03E_48E2
    dw Data_03E_4913
    dw Data_03E_4954
    dw Data_03E_4991
    dw Data_03E_49D2
    dw Data_03E_4A13
    dw Data_03E_4A50
    dw Data_03E_4A91
    dw Data_03E_4ACA
    dw Data_03E_4AEF
    dw Data_03E_4B0C
    dw Data_03E_4B1D
    dw Data_03E_4B1D
    dw Data_03E_4B1D
    dw Data_03E_4B1D
    dw Data_03E_4B1D
    dw Data_03E_4B1D
    dw Data_03E_4B1D
    dw Data_03E_4B1D
    dw Data_03E_4B1D
    dw Data_03E_4B1D
    dw Data_03E_4B1D
    dw Data_03E_4B1D
    dw Data_03E_4B1D
    dw Data_03E_4B1D
    dw Data_03E_4B1D
    dw Data_03E_4B1D
    dw Data_03E_4B1D
    dw Data_03E_4B1D

Data_03E_489F:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $B0, $05, $10, $F8, $B0, $0E, $10, $F8, $B8, $0F, $10, $80

Data_03E_48AC:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $B0, $1B, $10, $F8, $B8, $1C, $10, $F8, $C0, $1D, $10, $F8, $C8, $1E, $10
    db $80

Data_03E_48BD:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $B0, $03, $10, $F0, $D8, $03, $10, $F0, $C8, $21, $10, $F8, $B0, $26, $10
    db $F8, $B8, $27, $10, $F8, $C0, $28, $10, $F8, $C8, $29, $10, $F8, $D0, $2A, $10
    db $F8, $D8, $2B, $10, $80

Data_03E_48E2:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $B7, $02, $10, $F0, $C8, $03, $10, $F0, $D0, $04, $10, $F0, $E0, $05, $10
    db $F8, $B0, $08, $10, $F8, $B8, $09, $10, $F8, $C0, $0A, $10, $F8, $C8, $0B, $10
    db $F8, $D0, $0C, $10, $F8, $D8, $0D, $10, $F8, $E0, $0E, $10, $F8, $E8, $0F, $10
    db $80

Data_03E_4913:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F8913, $41

Data_03E_4954:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $E0, $03, $10, $F0, $08, $03, $10, $F0, $C8, $1F, $10, $F0, $D0, $20, $10
    db $F0, $F8, $21, $10, $F8, $C0, $22, $10, $F8, $C8, $23, $10, $F8, $D0, $24, $10
    db $F8, $D8, $25, $10, $F8, $E0, $26, $10, $F8, $E8, $27, $10, $F8, $F0, $28, $10
    db $F8, $F8, $29, $10, $F8, $00, $2A, $10, $F8, $08, $2B, $10, $80

Data_03E_4991:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F8991, $41

Data_03E_49D2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F89D2, $41

Data_03E_4A13:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $10, $03, $10, $F0, $38, $03, $10, $F0, $F8, $1F, $10, $F0, $00, $20, $10
    db $F0, $28, $21, $10, $F8, $F0, $22, $10, $F8, $F8, $23, $10, $F8, $00, $24, $10
    db $F8, $08, $25, $10, $F8, $10, $26, $10, $F8, $18, $27, $10, $F8, $20, $28, $10
    db $F8, $28, $29, $10, $F8, $30, $2A, $10, $F8, $38, $2B, $10, $80

Data_03E_4A50:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F8A50, $41

Data_03E_4A91:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $20, $00, $10, $F0, $10, $10, $10, $F0, $18, $11, $10, $F0, $28, $12, $10
    db $F0, $30, $13, $10, $F0, $38, $14, $10, $F8, $10, $15, $10, $F8, $18, $16, $10
    db $F8, $20, $17, $10, $F8, $28, $18, $10, $F8, $30, $19, $10, $F8, $38, $1A, $10
    db $F8, $40, $1B, $10, $F8, $48, $1C, $10, $80

Data_03E_4ACA:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $40, $03, $10, $F0, $28, $1F, $10, $F0, $30, $20, $10, $F8, $20, $22, $10
    db $F8, $28, $23, $10, $F8, $30, $24, $10, $F8, $38, $25, $10, $F8, $40, $26, $10
    db $F8, $48, $27, $10, $80

Data_03E_4AEF:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $30, $00, $10, $F0, $38, $01, $10, $F0, $47, $02, $10, $F8, $30, $06, $10
    db $F8, $38, $07, $10, $F8, $40, $08, $10, $F8, $48, $09, $10, $80

Data_03E_4B0C:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $40, $10, $10, $F0, $48, $11, $10, $F8, $40, $15, $10, $F8, $48, $16, $10
    db $80

Data_03E_4B1D:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03E_4B1E:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03E_4B5E
    dw Data_03E_4B6B
    dw Data_03E_4B8C
    dw Data_03E_4BC9
    dw Data_03E_4C1E
    dw Data_03E_4C6B
    dw Data_03E_4CC4
    dw Data_03E_4D25
    dw Data_03E_4D72
    dw Data_03E_4DCB
    dw Data_03E_4E2C
    dw Data_03E_4E69
    dw Data_03E_4E92
    dw Data_03E_4EBB
    dw Data_03E_4ECC
    dw Data_03E_4ECC
    dw Data_03E_4ECC
    dw Data_03E_4ECC
    dw Data_03E_4ECC
    dw Data_03E_4ECC
    dw Data_03E_4ECC
    dw Data_03E_4ECC
    dw Data_03E_4ECC
    dw Data_03E_4ECC
    dw Data_03E_4ECC
    dw Data_03E_4ECC
    dw Data_03E_4ECC
    dw Data_03E_4ECC
    dw Data_03E_4ECC
    dw Data_03E_4ECC
    dw Data_03E_4ECC
    dw Data_03E_4ECC

Data_03E_4B5E:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $B1, $0C, $10, $F8, $B1, $13, $10, $F8, $B9, $14, $10, $80

Data_03E_4B6B:: ; heuristic: target of a monotone pointer table; C0
    db $E0, $C0, $04, $10, $F8, $B8, $10, $10, $F8, $C0, $11, $10, $F0, $B0, $19, $10
    db $F0, $B8, $1A, $10, $F0, $C0, $1B, $10, $F8, $B0, $22, $10, $F8, $C8, $23, $10
    db $80

Data_03E_4B8C:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $D8, $00, $10, $F0, $B8, $05, $10, $F0, $D0, $09, $10, $F0, $C0, $19, $30
    db $E0, $D0, $24, $10, $E8, $C8, $25, $10, $E8, $D0, $26, $10, $F8, $C0, $20, $10
    db $F8, $B0, $23, $30, $F0, $C8, $28, $10, $F0, $D8, $29, $10, $F8, $C8, $2D, $10
    db $F8, $B8, $1F, $10, $F8, $D0, $0F, $10, $F8, $D8, $2E, $10, $80

Data_03E_4BC9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F8BC9, $55

Data_03E_4C1E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F8C1E, $4D

Data_03E_4C6B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F8C6B, $59

Data_03E_4CC4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F8CC4, $61

Data_03E_4D25:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F8D25, $4D

Data_03E_4D72:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F8D72, $59

Data_03E_4DCB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F8DCB, $61

Data_03E_4E2C:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $18, $06, $10, $F8, $48, $10, $10, $F0, $10, $15, $10, $F0, $20, $16, $10
    db $F0, $28, $17, $10, $F0, $30, $18, $10, $F0, $40, $19, $10, $F0, $48, $1A, $10
    db $F8, $10, $1C, $10, $F8, $18, $1D, $10, $F8, $30, $20, $10, $F8, $38, $21, $10
    db $F8, $40, $22, $10, $F8, $20, $1E, $10, $F8, $28, $1F, $10, $80

Data_03E_4E69:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $48, $05, $10, $F0, $28, $0B, $10, $F0, $30, $0C, $10, $F8, $28, $12, $10
    db $F8, $40, $23, $30, $F0, $38, $27, $10, $F8, $20, $2A, $10, $F8, $30, $2B, $10
    db $F8, $38, $2C, $10, $F8, $48, $1F, $10, $80

Data_03E_4E92:: ; heuristic: target of a monotone pointer table; C0
    db $E0, $48, $00, $10, $E8, $48, $01, $10, $F0, $38, $05, $10, $F0, $40, $06, $10
    db $F0, $48, $07, $10, $F8, $40, $0D, $10, $F8, $30, $23, $30, $E8, $40, $27, $30
    db $F8, $48, $0E, $10, $F8, $38, $1F, $10, $80

Data_03E_4EBB:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $48, $06, $10, $F0, $40, $15, $10, $F8, $40, $1C, $10, $F8, $48, $1D, $10
    db $80

Data_03E_4ECC:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03E_4ECD:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03E_4F0D
    dw Data_03E_4F16
    dw Data_03E_4F3F
    dw Data_03E_4F70
    dw Data_03E_4FB1
    dw Data_03E_5032
    dw Data_03E_50D3
    dw Data_03E_5174
    dw Data_03E_5201
    dw Data_03E_526A
    dw Data_03E_52AB
    dw Data_03E_52CC
    dw Data_03E_52CC
    dw Data_03E_52CC
    dw Data_03E_52CC
    dw Data_03E_52CC
    dw Data_03E_52CC
    dw Data_03E_52CC
    dw Data_03E_52CC
    dw Data_03E_52CC
    dw Data_03E_52CC
    dw Data_03E_52CC
    dw Data_03E_52CC
    dw Data_03E_52CC
    dw Data_03E_52CC
    dw Data_03E_52CC
    dw Data_03E_52CC
    dw Data_03E_52CC
    dw Data_03E_52CC
    dw Data_03E_52CC
    dw Data_03E_52CC
    dw Data_03E_52CC

Data_03E_4F0D:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $B0, $04, $10, $F8, $48, $04, $30, $80

Data_03E_4F16:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $BE, $00, $10, $F8, $B6, $01, $10, $F8, $BE, $02, $10, $F8, $C6, $03, $10
    db $F8, $CE, $09, $10, $F0, $3A, $00, $30, $F8, $42, $01, $30, $F8, $3A, $02, $30
    db $F8, $32, $03, $30, $F8, $2A, $09, $30, $80

Data_03E_4F3F:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $2C, $01, $30, $F8, $CC, $01, $10, $F0, $E4, $05, $10, $F8, $D4, $06, $10
    db $F8, $DC, $07, $10, $F8, $E4, $08, $10, $F8, $EC, $09, $10, $F8, $24, $06, $30
    db $F8, $1C, $07, $30, $F8, $14, $08, $30, $F8, $0C, $09, $30, $F0, $14, $05, $30
    db $80

Data_03E_4F70:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F8F70, $41

Data_03E_4FB1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F8FB1, $81

Data_03E_5032:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F9032, $A1

Data_03E_50D3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F90D3, $A1

Data_03E_5174:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F9174, $8D

Data_03E_5201:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F9201, $69

Data_03E_526A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F926A, $41

Data_03E_52AB:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $F8, $17, $10, $F8, $F8, $24, $10, $F8, $E8, $16, $10, $F8, $F0, $22, $30
    db $F8, $00, $22, $10, $F8, $08, $1D, $10, $F0, $F8, $11, $10, $F0, $FE, $1E, $70
    db $80

Data_03E_52CC:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03E_52CD:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03E_530D
    dw Data_03E_531E
    dw Data_03E_532F
    dw Data_03E_5350
    dw Data_03E_5381
    dw Data_03E_53A6
    dw Data_03E_53A6
    dw Data_03E_53A6
    dw Data_03E_53A6
    dw Data_03E_53A6
    dw Data_03E_53A6
    dw Data_03E_53A6
    dw Data_03E_53A6
    dw Data_03E_53A6
    dw Data_03E_53A6
    dw Data_03E_53A6
    dw Data_03E_53A6
    dw Data_03E_53A6
    dw Data_03E_53A6
    dw Data_03E_53A6
    dw Data_03E_53A6
    dw Data_03E_53A6
    dw Data_03E_53A6
    dw Data_03E_53A6
    dw Data_03E_53A6
    dw Data_03E_53A6
    dw Data_03E_53A6
    dw Data_03E_53A6
    dw Data_03E_53A6
    dw Data_03E_53A6
    dw Data_03E_53A6
    dw Data_03E_53A6

Data_03E_530D:: ; heuristic: target of a monotone pointer table; C0
    db $E2, $F8, $00, $00, $E2, $00, $01, $00, $EA, $F8, $02, $00, $EA, $00, $03, $00
    db $80

Data_03E_531E:: ; heuristic: target of a monotone pointer table; C0
    db $E4, $F8, $07, $00, $E4, $00, $08, $00, $EC, $F8, $09, $00, $EC, $00, $0A, $00
    db $80

Data_03E_532F:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $08, $00, $20, $E8, $00, $01, $20, $F0, $08, $02, $20, $F0, $00, $03, $20
    db $DF, $F1, $00, $00, $DF, $F9, $01, $00, $E7, $F1, $02, $00, $E7, $F9, $03, $00
    db $80

Data_03E_5350:: ; heuristic: target of a monotone pointer table; C0
    db $E2, $00, $0F, $00, $E2, $08, $10, $00, $DA, $00, $0C, $00, $DA, $F8, $0B, $00
    db $EA, $FF, $0E, $60, $EA, $F7, $0F, $60, $EA, $EF, $10, $60, $EA, $07, $0D, $60
    db $F2, $F7, $0C, $60, $F2, $FF, $0B, $60, $E2, $F8, $0E, $00, $E2, $F0, $0D, $00
    db $80

Data_03E_5381:: ; heuristic: target of a monotone pointer table; C0
    db $DF, $06, $01, $00, $E7, $FE, $02, $00, $E7, $06, $03, $00, $DF, $FE, $00, $00
    db $E6, $EF, $01, $20, $EE, $EF, $03, $20, $EE, $FF, $02, $20, $E6, $F7, $04, $00
    db $EE, $F7, $05, $00, $80

Data_03E_53A6:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03E_53A7:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03E_53E7
    dw Data_03E_5448
    dw Data_03E_5489
    dw Data_03E_549A
    dw Data_03E_54BF
    dw Data_03E_54F0
    dw Data_03E_5541
    dw Data_03E_5582
    dw Data_03E_55B7
    dw Data_03E_5618
    dw Data_03E_5618
    dw Data_03E_5618
    dw Data_03E_5618
    dw Data_03E_5618
    dw Data_03E_5618
    dw Data_03E_5618
    dw Data_03E_5618
    dw Data_03E_5618
    dw Data_03E_5618
    dw Data_03E_5618
    dw Data_03E_5618
    dw Data_03E_5618
    dw Data_03E_5618
    dw Data_03E_5618
    dw Data_03E_5618
    dw Data_03E_5618
    dw Data_03E_5618
    dw Data_03E_5618
    dw Data_03E_5618
    dw Data_03E_5618
    dw Data_03E_5618
    dw Data_03E_5618

Data_03E_53E7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F93E7, $61

Data_03E_5448:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F9448, $41

Data_03E_5489:: ; heuristic: target of a monotone pointer table; C0
    db $EC, $F8, $19, $40, $EC, $00, $19, $60, $E4, $00, $19, $20, $E4, $F8, $19, $00
    db $80

Data_03E_549A:: ; heuristic: target of a monotone pointer table; C0
    db $DF, $06, $01, $00, $E7, $FE, $02, $00, $E7, $06, $03, $00, $DF, $FE, $00, $00
    db $E6, $EF, $01, $20, $EE, $EF, $03, $20, $EE, $FF, $02, $20, $E6, $F7, $04, $00
    db $EE, $F7, $05, $00, $80

Data_03E_54BF:: ; heuristic: target of a monotone pointer table; C0
    db $E2, $00, $0F, $00, $E2, $08, $10, $00, $DA, $00, $0C, $00, $DA, $F8, $0B, $00
    db $EA, $FF, $0E, $60, $EA, $F7, $0F, $60, $EA, $EF, $10, $60, $EA, $07, $0D, $60
    db $F2, $F7, $0C, $60, $F2, $FF, $0B, $60, $E2, $F8, $0E, $00, $E2, $F0, $0D, $00
    db $80

Data_03E_54F0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F94F0, $51

Data_03E_5541:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F9541, $41

Data_03E_5582:: ; heuristic: target of a monotone pointer table; C0
    db $DA, $EF, $00, $00, $DA, $F7, $01, $00, $E2, $EF, $02, $00, $E2, $F7, $03, $00
    db $E7, $05, $02, $00, $E7, $0D, $03, $00, $DF, $0F, $00, $20, $DF, $07, $01, $20
    db $F4, $FA, $03, $00, $F4, $F2, $03, $20, $EC, $FA, $06, $00, $EC, $F2, $01, $20
    db $EF, $01, $02, $20, $80

Data_03E_55B7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F95B7, $61

Data_03E_5618:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03E_5619:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03E_5659
    dw Data_03E_56FA
    dw Data_03E_577B
    dw Data_03E_580C
    dw Data_03E_581D
    dw Data_03E_583E
    dw Data_03E_58C3
    dw Data_03E_5964
    dw Data_03E_59E9
    dw Data_03E_5A76
    dw Data_03E_5AEF
    dw Data_03E_5B80
    dw Data_03E_5C09
    dw Data_03E_5C92
    dw Data_03E_5D07
    dw Data_03E_5D94
    dw Data_03E_5E0D
    dw Data_03E_5E9E
    dw Data_03E_5F27
    dw Data_03E_5FB0
    dw Data_03E_6025
    dw Data_03E_6025
    dw Data_03E_6025
    dw Data_03E_6025
    dw Data_03E_6025
    dw Data_03E_6025
    dw Data_03E_6025
    dw Data_03E_6025
    dw Data_03E_6025
    dw Data_03E_6025
    dw Data_03E_6025
    dw Data_03E_6025

Data_03E_5659:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F9659, $A1

Data_03E_56FA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F96FA, $81

Data_03E_577B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F977B, $91

Data_03E_580C:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $F8, $19, $40, $E8, $00, $19, $60, $E0, $00, $19, $20, $E0, $F8, $19, $00
    db $80

Data_03E_581D:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $00, $02, $20, $E8, $F8, $03, $20, $E0, $F8, $02, $40, $E0, $00, $03, $40
    db $DE, $08, $28, $00, $DE, $10, $29, $00, $D9, $F3, $21, $00, $EF, $FB, $20, $60
    db $80

Data_03E_583E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F983E, $85

Data_03E_58C3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F98C3, $A1

Data_03E_5964:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F9964, $85

Data_03E_59E9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F99E9, $8D

Data_03E_5A76:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F9A76, $79

Data_03E_5AEF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F9AEF, $91

Data_03E_5B80:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F9B80, $89

Data_03E_5C09:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F9C09, $89

Data_03E_5C92:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F9C92, $75

Data_03E_5D07:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F9D07, $8D

Data_03E_5D94:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F9D94, $79

Data_03E_5E0D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F9E0D, $91

Data_03E_5E9E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F9E9E, $89

Data_03E_5F27:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F9F27, $89

Data_03E_5FB0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F9FB0, $57

Data_03E_6007:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_03E_6008:: ; heuristic: target of a monotone pointer table; C0
    db $E0

Data_03E_6009:: ; heuristic: target of a monotone pointer table; C0
    db $E8

Data_03E_600A:: ; heuristic: target of a monotone pointer table; C0
    db $08

Data_03E_600B:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_03E_600C:: ; heuristic: target of a monotone pointer table; C0
    db $E8

Data_03E_600D:: ; heuristic: target of a monotone pointer table; C0
    db $E0

Data_03E_600E:: ; heuristic: target of a monotone pointer table; C0
    db $09

Data_03E_600F:: ; heuristic: target of a monotone pointer table; C0
    db $00, $E8, $E8, $0A, $00, $D0, $D0, $07, $60, $D0, $C8, $08, $60, $F8, $CE, $09
    db $60, $F8, $C6, $0A, $60, $80

Data_03E_6025:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03E_6026:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03E_6066
    dw Data_03E_606F
    dw Data_03E_6080
    dw Data_03E_609D
    dw Data_03E_60C2
    dw Data_03E_60E3
    dw Data_03E_610C
    dw Data_03E_6139
    dw Data_03E_615A
    dw Data_03E_616F
    dw Data_03E_6198
    dw Data_03E_61C5
    dw Data_03E_61E6
    dw Data_03E_61FB
    dw Data_03E_61FB
    dw Data_03E_61FB
    dw Data_03E_61FB
    dw Data_03E_61FB
    dw Data_03E_61FB
    dw Data_03E_61FB
    dw Data_03E_61FB
    dw Data_03E_61FB
    dw Data_03E_61FB
    dw Data_03E_61FB
    dw Data_03E_61FB
    dw Data_03E_61FB
    dw Data_03E_61FB
    dw Data_03E_61FB
    dw Data_03E_61FB
    dw Data_03E_61FB
    dw Data_03E_61FB
    dw Data_03E_61FB

Data_03E_6066:: ; heuristic: target of a monotone pointer table; C0
    db $E6, $FC, $02, $00, $E6, $04, $03, $00, $80

Data_03E_606F:: ; heuristic: target of a monotone pointer table; C0
    db $EE, $F4, $02, $00, $EE, $FC, $03, $00, $E8, $FC, $00, $00, $E8, $04, $01, $00
    db $80

Data_03E_6080:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $F4, $00, $00, $F0, $FC, $01, $00, $DE, $F4, $00, $00, $DE, $FC, $01, $00
    db $E5, $F5, $0C, $00, $E5, $FD, $0D, $00, $E5, $05, $0E, $00, $80

Data_03E_609D:: ; heuristic: target of a monotone pointer table; C0
    db $DC, $F4, $02, $00, $DC, $FC, $03, $00, $EE, $F4, $00, $00, $EE, $FC, $01, $00
    db $E3, $F5, $04, $00, $E3, $FD, $05, $00, $E3, $05, $06, $00, $EA, $ED, $07, $00
    db $EB, $F5, $08, $00, $80

Data_03E_60C2:: ; heuristic: target of a monotone pointer table; C0
    db $DE, $F4, $00, $00, $DE, $FC, $01, $00, $F0, $F0, $0C, $00, $F0, $F8, $0D, $00
    db $F0, $00, $0E, $00, $E2, $F6, $09, $00, $E2, $FE, $0A, $00, $E2, $06, $0B, $00
    db $80

Data_03E_60E3:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $FC, $00, $00, $E8, $04, $01, $00, $DD, $F0, $0C, $00, $DD, $F8, $0D, $00
    db $DD, $00, $0E, $00, $F0, $F0, $04, $00, $F0, $F8, $05, $00, $F0, $00, $06, $00
    db $F8, $F0, $08, $00, $F7, $E8, $07, $00, $80

Data_03E_610C:: ; heuristic: target of a monotone pointer table; C0
    db $DA, $F1, $04, $00, $DA, $F9, $05, $00, $DA, $01, $06, $00, $E2, $F1, $08, $00
    db $E1, $E9, $07, $00, $F2, $EE, $0C, $00, $F2, $F6, $0D, $00, $F2, $FE, $0E, $00
    db $E6, $F8, $09, $00, $E6, $00, $0A, $00, $E6, $08, $0B, $00, $80

Data_03E_6139:: ; heuristic: target of a monotone pointer table; C0
    db $DB, $F2, $09, $00, $DB, $FA, $0A, $00, $DB, $02, $0B, $00, $E6, $F8, $04, $00
    db $E6, $00, $05, $00, $E6, $08, $06, $00, $EE, $F8, $08, $00, $ED, $F0, $07, $00
    db $80

Data_03E_615A:: ; heuristic: target of a monotone pointer table; C0
    db $E9, $F6, $0C, $00, $E9, $FE, $0D, $00, $E9, $06, $0E, $00, $E0, $F8, $00, $00
    db $E0, $00, $01, $00, $80

Data_03E_616F:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $FC, $00, $00, $E8, $04, $01, $00, $E4, $F3, $0C, $00, $E4, $FB, $0D, $00
    db $E4, $03, $0E, $00, $F0, $F4, $04, $00, $F0, $FC, $05, $00, $F0, $04, $06, $00
    db $F8, $F4, $08, $00, $F7, $EC, $07, $00, $80

Data_03E_6198:: ; heuristic: target of a monotone pointer table; C0
    db $EE, $F3, $0C, $00, $EE, $FB, $0D, $00, $EE, $03, $0E, $00, $F5, $F2, $09, $00
    db $F5, $FA, $0A, $00, $F5, $02, $0B, $00, $E5, $F4, $04, $00, $E5, $FC, $05, $00
    db $E5, $04, $06, $00, $ED, $F4, $08, $00, $EC, $EC, $07, $00, $80

Data_03E_61C5:: ; heuristic: target of a monotone pointer table; C0
    db $E4, $F5, $09, $00, $E4, $FD, $0A, $00, $E4, $05, $0B, $00, $EC, $F6, $04, $00
    db $EC, $FE, $05, $00, $EC, $06, $06, $00, $F4, $F6, $08, $00, $F3, $EE, $07, $00
    db $80

Data_03E_61E6:: ; heuristic: target of a monotone pointer table; C0
    db $E6, $F3, $0C, $00, $E6, $FB, $0D, $00, $E6, $03, $0E, $00, $F1, $01, $03, $00
    db $F1, $F9, $02, $00, $80

Data_03E_61FB:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03E_61FC:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03E_623C
    dw Data_03E_625D
    dw Data_03E_6282
    dw Data_03E_62C7
    dw Data_03E_6344
    dw Data_03E_63BD
    dw Data_03E_642E
    dw Data_03E_64AB
    dw Data_03E_6528
    dw Data_03E_65A1
    dw Data_03E_661A
    dw Data_03E_6693
    dw Data_03E_66F0
    dw Data_03E_6719
    dw Data_03E_6719
    dw Data_03E_6719
    dw Data_03E_6719
    dw Data_03E_6719
    dw Data_03E_6719
    dw Data_03E_6719
    dw Data_03E_6719
    dw Data_03E_6719
    dw Data_03E_6719
    dw Data_03E_6719
    dw Data_03E_6719
    dw Data_03E_6719
    dw Data_03E_6719
    dw Data_03E_6719
    dw Data_03E_6719
    dw Data_03E_6719
    dw Data_03E_6719
    dw Data_03E_6719

Data_03E_623C:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $B0, $1B, $00, $F8, $B8, $1C, $00, $E0, $B0, $0D, $00, $E8, $B0, $11, $00
    db $F0, $B0, $16, $00, $F8, $BD, $1D, $00, $F0, $B8, $1E, $00, $F8, $C5, $1F, $00
    db $80

Data_03E_625D:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $B0, $1A, $00, $F8, $B8, $1B, $00, $F0, $B0, $15, $00, $F0, $B8, $16, $00
    db $E0, $AE, $0D, $00, $D8, $AD, $05, $20, $E8, $B0, $0E, $20, $F8, $C0, $1C, $00
    db $F8, $CC, $1E, $00, $80

Data_03E_6282:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FA282, $45

Data_03E_62C7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FA2C7, $7D

Data_03E_6344:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FA344, $79

Data_03E_63BD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FA3BD, $71

Data_03E_642E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FA42E, $7D

Data_03E_64AB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FA4AB, $7D

Data_03E_6528:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FA528, $79

Data_03E_65A1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FA5A1, $79

Data_03E_661A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FA61A, $79

Data_03E_6693:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FA693, $5D

Data_03E_66F0:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $48, $1B, $20, $E0, $48, $16, $20, $F0, $48, $00, $00, $F8, $48, $05, $00
    db $D0, $40, $0A, $00, $D0, $48, $0B, $00, $E7, $40, $1C, $20, $D8, $48, $11, $20
    db $F8, $38, $1F, $20, $F8, $40, $1D, $20, $80

Data_03E_6719:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03E_671A:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03E_675A
    dw Data_03E_678F
    dw Data_03E_67C8
    dw Data_03E_6851
    dw Data_03E_689A
    dw Data_03E_693B
    dw Data_03E_69D8
    dw Data_03E_6A79
    dw Data_03E_6B1A
    dw Data_03E_6BBB
    dw Data_03E_6C5C
    dw Data_03E_6CFD
    dw Data_03E_6D9E
    dw Data_03E_6E3F
    dw Data_03E_6EE0
    dw Data_03E_6F81
    dw Data_03E_7022
    dw Data_03E_70C3
    dw Data_03E_7164
    dw Data_03E_7205
    dw Data_03E_72A6
    dw Data_03E_7347
    dw Data_03E_73E8
    dw Data_03E_7489
    dw Data_03E_752A
    dw Data_03E_75CB
    dw Data_03E_7604
    dw Data_03E_7615
    dw Data_03E_7615
    dw Data_03E_7615
    dw Data_03E_7615
    dw Data_03E_7615

Data_03E_675A:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $B0, $04, $00, $F8, $B8, $05, $00, $F8, $C0, $06, $00, $F8, $C8, $07, $00
    db $F8, $D0, $08, $00, $F8, $D8, $09, $00, $F2, $D0, $05, $00, $F2, $D8, $06, $00
    db $F2, $C9, $04, $00, $F0, $B0, $08, $00, $F0, $B8, $09, $00, $F8, $E0, $20, $00
    db $F8, $E8, $1C, $40, $80

Data_03E_678F:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $C0, $0A, $00, $F8, $C8, $0B, $00, $F8, $D0, $0C, $00, $F8, $D8, $0D, $00
    db $F0, $B8, $04, $00, $F0, $C0, $05, $00, $F0, $C8, $06, $00, $F0, $D0, $07, $00
    db $F0, $D8, $08, $00, $F0, $E0, $09, $00, $F8, $B0, $20, $20, $F8, $E8, $21, $00
    db $F0, $F0, $1D, $00, $E8, $B0, $1C, $00, $80

Data_03E_67C8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FA7C8, $89

Data_03E_6851:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FA851, $49

Data_03E_689A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FA89A, $A1

Data_03E_693B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FA93B, $9D

Data_03E_69D8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FA9D8, $A1

Data_03E_6A79:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FAA79, $A1

Data_03E_6B1A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FAB1A, $A1

Data_03E_6BBB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FABBB, $A1

Data_03E_6C5C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FAC5C, $A1

Data_03E_6CFD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FACFD, $A1

Data_03E_6D9E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FAD9E, $A1

Data_03E_6E3F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FAE3F, $A1

Data_03E_6EE0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FAEE0, $A1

Data_03E_6F81:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FAF81, $A1

Data_03E_7022:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FB022, $A1

Data_03E_70C3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FB0C3, $A1

Data_03E_7164:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FB164, $A1

Data_03E_7205:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FB205, $A1

Data_03E_72A6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FB2A6, $A1

Data_03E_7347:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FB347, $A1

Data_03E_73E8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FB3E8, $A1

Data_03E_7489:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FB489, $A1

Data_03E_752A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FB52A, $A1

Data_03E_75CB:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $40, $0E, $00, $D0, $40, $0E, $00, $D0, $48, $0F, $00, $D8, $48, $19, $00
    db $F0, $40, $19, $00, $F0, $48, $1A, $00, $F8, $30, $19, $00, $F8, $38, $1A, $00
    db $F8, $48, $1A, $60, $F8, $20, $20, $20, $F8, $18, $21, $20, $E8, $00, $1C, $20
    db $E8, $28, $1F, $00, $F8, $10, $1E, $20, $80

Data_03E_7604:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $20, $1D, $00, $D8, $38, $1F, $00, $F8, $48, $1C, $00, $D0, $48, $1E, $00
    db $80

Data_03E_7615:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03E_7616:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03E_7656
    dw Data_03E_7667
    dw Data_03E_7690
    dw Data_03E_76BD
    dw Data_03E_76FE
    dw Data_03E_773F
    dw Data_03E_7784
    dw Data_03E_77C9
    dw Data_03E_7816
    dw Data_03E_785F
    dw Data_03E_78A8
    dw Data_03E_78ED
    dw Data_03E_793A
    dw Data_03E_7983
    dw Data_03E_79C0
    dw Data_03E_79ED
    dw Data_03E_7A12
    dw Data_03E_7A27
    dw Data_03E_7A34
    dw Data_03E_7A39
    dw Data_03E_7A39
    dw Data_03E_7A39
    dw Data_03E_7A39
    dw Data_03E_7A39
    dw Data_03E_7A39
    dw Data_03E_7A39
    dw Data_03E_7A39
    dw Data_03E_7A39
    dw Data_03E_7A39
    dw Data_03E_7A39
    dw Data_03E_7A39
    dw Data_03E_7A39

Data_03E_7656:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $B0, $04, $00, $F8, $B8, $05, $00, $F0, $B0, $01, $00, $F0, $B8, $02, $00
    db $80

Data_03E_7667:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $C4, $13, $20, $F8, $BC, $14, $20, $F8, $B4, $15, $20, $F0, $C4, $10, $20
    db $F0, $BC, $11, $20, $F0, $B4, $12, $20, $E8, $C4, $0E, $20, $E8, $BC, $0F, $20
    db $F0, $AC, $1C, $00, $F8, $AC, $1D, $00, $80

Data_03E_7690:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $C0, $14, $00, $F8, $C8, $15, $00, $F0, $B8, $10, $00, $F0, $C0, $11, $00
    db $F0, $C8, $12, $00, $E8, $B8, $0E, $00, $E8, $C0, $0F, $00, $F0, $B0, $01, $20
    db $F8, $B0, $04, $20, $F8, $D0, $18, $00, $F8, $B8, $16, $20, $80

Data_03E_76BD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FB6BD, $41

Data_03E_76FE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FB6FE, $41

Data_03E_773F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FB73F, $45

Data_03E_7784:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FB784, $45

Data_03E_77C9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FB7C9, $4D

Data_03E_7816:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FB816, $49

Data_03E_785F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FB85F, $49

Data_03E_78A8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FB8A8, $45

Data_03E_78ED:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FB8ED, $4D

Data_03E_793A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FB93A, $49

Data_03E_7983:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $3C, $03, $20, $F0, $3C, $00, $20, $F8, $44, $15, $20, $F0, $44, $12, $20
    db $F8, $34, $08, $20, $F8, $2C, $09, $20, $F0, $34, $06, $20, $F0, $2C, $07, $20
    db $F8, $24, $0B, $20, $F8, $1C, $0C, $20, $F8, $14, $0D, $20, $F8, $0C, $0E, $20
    db $E8, $4C, $20, $00, $F0, $4C, $21, $00, $F8, $4C, $22, $00, $80

Data_03E_79C0:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $48, $10, $00, $E8, $48, $0E, $00, $F0, $40, $01, $20, $F0, $38, $02, $20
    db $F8, $40, $04, $20, $F8, $38, $05, $20, $F8, $48, $16, $20, $F8, $28, $0B, $00
    db $F8, $30, $0C, $00, $F8, $18, $0D, $20, $F8, $20, $0C, $00, $80

Data_03E_79ED:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $44, $01, $20, $F0, $3C, $02, $20, $F8, $44, $04, $20, $F8, $3C, $05, $20
    db $F8, $34, $0C, $20, $F8, $24, $1B, $20, $F8, $2C, $0B, $20, $F0, $4C, $23, $00
    db $F8, $4C, $24, $00, $80

Data_03E_7A12:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $48, $02, $20, $F8, $48, $05, $20, $F8, $40, $0C, $20, $F8, $30, $1B, $20
    db $F8, $38, $0B, $20, $80

Data_03E_7A27:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $44, $0C, $20, $F8, $3C, $0D, $20, $F8, $4C, $25, $00, $80

Data_03E_7A34:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $48, $0E, $20, $80

Data_03E_7A39:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03E_7A3A:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03E_7A7A
    dw Data_03E_7A8B
    dw Data_03E_7AA8
    dw Data_03E_7AE1
    dw Data_03E_7B46
    dw Data_03E_7BAB
    dw Data_03E_7BAB
    dw Data_03E_7BAB
    dw Data_03E_7BAB
    dw Data_03E_7BAB
    dw Data_03E_7BAB
    dw Data_03E_7BAB
    dw Data_03E_7BAB
    dw Data_03E_7BAB
    dw Data_03E_7BAB
    dw Data_03E_7BAB
    dw Data_03E_7BAB
    dw Data_03E_7BAB
    dw Data_03E_7BAB
    dw Data_03E_7BAB
    dw Data_03E_7BAB
    dw Data_03E_7BAB
    dw Data_03E_7BAB
    dw Data_03E_7BAB
    dw Data_03E_7BAB
    dw Data_03E_7BAB
    dw Data_03E_7BAB
    dw Data_03E_7BAB
    dw Data_03E_7BAB
    dw Data_03E_7BAB
    dw Data_03E_7BAB
    dw Data_03E_7BAB

Data_03E_7A7A:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F8, $22, $00, $F8, $00, $23, $00, $F0, $F8, $20, $00, $F0, $00, $21, $00
    db $80

Data_03E_7A8B:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F4, $1D, $00, $F8, $FC, $1E, $00, $F8, $04, $1F, $00, $F0, $F4, $1A, $00
    db $F0, $FC, $1B, $00, $F0, $04, $1C, $00, $E8, $FC, $19, $00, $80

Data_03E_7AA8:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $F4, $1D, $00, $F0, $FC, $1E, $00, $F0, $04, $1F, $00, $E8, $F4, $1A, $00
    db $E8, $FC, $1B, $00, $E8, $04, $1C, $00, $E0, $FC, $19, $00, $F8, $F4, $22, $00
    db $F8, $04, $23, $00, $F8, $FC, $0E, $00, $F8, $EC, $1F, $20, $F0, $EC, $1C, $20
    db $F8, $0C, $1D, $20, $F0, $0C, $1A, $20, $80

Data_03E_7AE1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FBAE1, $65

Data_03E_7B46:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FBB46, $65

Data_03E_7BAB:: ; heuristic: target of a monotone pointer table; C0
    db $80
    ds $454, $00
