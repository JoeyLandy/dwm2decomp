SECTION "Bank 3D", ROMX[$4000], BANK[$3D]
    db $3D

; only called from DrawEffectSpriteForWD801Range (E-0047)
; 1 call site from 1 routine (e.g. DrawEffectSpriteForWD801Range)
; reads: wD801, wD890, wBattleTarget, wD804, wDAB7
; writes: wD871, wD868
; points at: wD871, wD868, hSpriteOriginX
DrawEffectSpriteForWD801Range_Sub01::
Func_03D_4001:: ; address name
    ld a, [wD801]
    cp a, $2C
    jr nz, DrawEffectSpriteAtWD804_Bank3D
    ld a, [wD890]
    ld [wD871], a
    ld a, [wBattleTarget]
    and a, $04
    ld [wD868], a
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_03D_4024
    farcall SetEffectSpriteXForTargets
    call DrawEffectSpriteAtWD804_Bank3D

Jump_03D_4024::
    ld hl, wD871
    dec [hl]
    ld a, [hl]
    or a, a
    ret z
    ld hl, wD868
    inc [hl]
    ld a, [hl]
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_03D_403E
    farcall SetEffectSpriteXForTargets
    call DrawEffectSpriteAtWD804_Bank3D

Jump_03D_403E::
    ld hl, wD871
    dec [hl]
    ld a, [hl]
    or a, a
    ret z
    ld hl, wD868
    inc [hl]
    ld a, [hl]
    call CarryUnlessWDA63SlotEmpty
    ret c
    farcall SetEffectSpriteXForTargets

; sets the sprite origin X = wD804, Y = $68, tile offset = wD801, attribute XOR = wDAB7, then builds OAM from the local sprite table (E-0121)
; 2 call sites from 1 routine (e.g. DrawEffectSpriteForWD801Range_Sub01)
; reads: wD804, wD801, wDAB7
; points at: hSpriteOriginX
DrawEffectSpriteAtWD804_Bank3D::
Func_03D_4054:: ; address name
    ld hl, hSpriteOriginX
    ld a, [wD804]
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $68
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, [wD801]
    ld [hl+], a
    ld a, [wDAB7]
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld [hl+], a
    ld de, Data_03D_4077
    call BuildOamFromSpriteTable_Bank3D
    ret

Data_03D_4077:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_03D_4122
    dw Data_03D_4122
    dw Data_03D_4122
    dw Data_03D_4122
    dw Data_03D_4122
    dw Data_03D_4122
    dw Data_03D_4122
    dw Data_03D_4122
    dw Data_03D_4122
    dw Data_03D_4122
    dw Data_03D_4122
    dw Data_03D_4122
    dw Data_03D_4122
    dw Data_03D_4122
    dw Data_03D_4122
    dw Data_03D_4122
    dw Data_03D_4122
    dw Data_03D_4122
    dw Data_03D_4122
    dw Data_03D_4122
    dw Data_03D_4122
    dw Data_03D_4122
    dw Data_03D_4122
    dw Data_03D_4122
    dw Data_03D_4122
    dw Data_03D_4122
    dw Data_03D_4122
    dw Data_03D_4122
    dw Data_03D_4122
    dw Data_03D_4122
    dw Data_03D_4122
    dw Data_03D_4122
    dw Data_03D_4122
    dw Data_03D_467D
    dw Data_03D_48BA
    dw Data_03D_49B1
    dw Data_03D_4AE1
    dw Data_03D_4CAD
    dw Data_03D_4E57
    dw Data_03D_5118
    dw Data_03D_5667
    dw Data_03D_58E2
    dw Data_03D_633F
    dw Data_03D_6FA8
    dw Data_03D_763A

; DE = two-level table; entries are chosen by hSpriteSetIndex and hSpriteSubIndex; writes 4-byte OAM entries at $C000 + 4 * hOamNextEntry (Y = hSpriteOriginY + b + $10, X = hSpriteOriginX + b + 8, tile += hSpriteTileOffset, flags ^= hSpriteAttrXor) until a $80 byte or hOamNextEntry reaches $28 (40 entries) (the same 81 bytes appear in 5 banks)
; 1 call site from 1 routine (e.g. DrawEffectSpriteAtWD804_Bank3D)
; reads: hOamNextEntry, hSpriteSetIndex, hSpriteSubIndex, hSpriteOriginY, hSpriteOriginX, hSpriteTileOffset, hSpriteAttrXor
; writes: hOamNextEntry
BuildOamFromSpriteTable_Bank3D::
Func_03D_40D1:: ; address name
    ldh a, [hOamNextEntry]
    cp a, $28
    jr nc, Jump_03D_4121
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

Jump_03D_40F4::
    ld a, [de]
    inc de
    cp a, $80
    jr z, Jump_03D_4121
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
    jr c, Jump_03D_40F4

Jump_03D_4121::
    ret

Data_03D_4122:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03D_4162
    dw Data_03D_4173
    dw Data_03D_419C
    dw Data_03D_41CD
    dw Data_03D_41FE
    dw Data_03D_4223
    dw Data_03D_4238
    dw Data_03D_4245
    dw Data_03D_426A
    dw Data_03D_428B
    dw Data_03D_42C0
    dw Data_03D_42FD
    dw Data_03D_4336
    dw Data_03D_4367
    dw Data_03D_43A8
    dw Data_03D_43E9
    dw Data_03D_4426
    dw Data_03D_4467
    dw Data_03D_44A0
    dw Data_03D_44CD
    dw Data_03D_4512
    dw Data_03D_4567
    dw Data_03D_45B4
    dw Data_03D_45F1
    dw Data_03D_4632
    dw Data_03D_465F
    dw Data_03D_467C
    dw Data_03D_467C
    dw Data_03D_467C
    dw Data_03D_467C
    dw Data_03D_467C
    dw Data_03D_467C

Data_03D_4162:: ; heuristic: target of a monotone pointer table; C0
    db $D8, $03, $20, $00, $D8, $0B, $21, $00, $D0, $03, $22, $00, $D0, $0B, $23, $00
    db $80

Data_03D_4173:: ; heuristic: target of a monotone pointer table; C0
    db $DC, $00, $20, $00, $DC, $08, $21, $00, $E4, $F8, $20, $60, $E4, $F0, $21, $60
    db $D0, $03, $2F, $00, $D4, $00, $22, $00, $D4, $08, $23, $00, $F0, $F5, $2F, $60
    db $EC, $F8, $22, $60, $EC, $F0, $23, $60, $80

Data_03D_419C:: ; heuristic: target of a monotone pointer table; C0
    db $D8, $FC, $26, $00, $D8, $04, $27, $00, $D8, $0C, $28, $00, $F0, $F4, $2E, $00
    db $F8, $EF, $2F, $00, $D0, $00, $24, $00, $D0, $08, $25, $00, $E0, $F8, $29, $00
    db $E0, $00, $2A, $00, $E0, $08, $2B, $00, $E8, $F8, $2C, $00, $E8, $00, $2D, $00
    db $80

Data_03D_41CD:: ; heuristic: target of a monotone pointer table; C0
    db $E0, $F7, $26, $00, $E0, $FF, $27, $00, $E0, $07, $28, $00, $F8, $EF, $2E, $00
    db $D8, $FB, $24, $00, $D8, $03, $25, $00, $E8, $F3, $29, $00, $E8, $FB, $2A, $00
    db $E8, $03, $2B, $00, $F0, $F3, $2C, $00, $F0, $FB, $2D, $00, $D0, $09, $2F, $00
    db $80

Data_03D_41FE:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $09, $2E, $00, $D8, $04, $2E, $00, $E0, $FF, $2E, $00, $E8, $F9, $2E, $00
    db $F8, $F5, $29, $60, $F8, $ED, $2A, $60, $F8, $E5, $2B, $60, $F0, $F5, $2C, $60
    db $F0, $ED, $2D, $60, $80

Data_03D_4223:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $EF, $2E, $00, $F0, $F4, $2E, $00, $E8, $F9, $2E, $00, $E0, $FF, $2F, $00
    db $D8, $04, $2F, $00, $80

Data_03D_4238:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $EF, $2F, $00, $F0, $F4, $2F, $00, $E8, $F9, $2F, $00, $80

Data_03D_4245:: ; heuristic: target of a monotone pointer table; C0
    db $DC, $F4, $02, $00, $DC, $FC, $03, $00, $EE, $F4, $00, $00, $EE, $FC, $01, $00
    db $E3, $F5, $04, $00, $E3, $FD, $05, $00, $E3, $05, $06, $00, $EA, $ED, $07, $00
    db $EB, $F5, $08, $00, $80

Data_03D_426A:: ; heuristic: target of a monotone pointer table; C0
    db $DE, $F4, $00, $00, $DE, $FC, $01, $00, $F0, $F0, $0C, $00, $F0, $F8, $0D, $00
    db $F0, $00, $0E, $00, $E2, $F6, $09, $00, $E2, $FE, $0A, $00, $E2, $06, $0B, $00
    db $80

Data_03D_428B:: ; heuristic: target of a monotone pointer table; C0
    db $DD, $F0, $0C, $00, $DD, $F8, $0D, $00, $DD, $00, $0E, $00, $F0, $F0, $04, $00
    db $F0, $F8, $05, $00, $F0, $00, $06, $00, $F8, $F0, $08, $00, $F7, $E8, $07, $00
    db $EA, $F8, $1C, $00, $EA, $00, $1D, $00, $E2, $F8, $1B, $00, $E6, $08, $1E, $00
    db $E6, $10, $1F, $00, $80

Data_03D_42C0:: ; heuristic: target of a monotone pointer table; C0
    db $DA, $F1, $04, $00, $DA, $F9, $05, $00, $DA, $01, $06, $00, $E2, $F1, $08, $00
    db $E1, $E9, $07, $00, $F2, $EE, $0C, $00, $F2, $F6, $0D, $00, $F2, $FE, $0E, $00
    db $E2, $F8, $0F, $00, $E2, $00, $10, $00, $E2, $08, $11, $00, $E2, $10, $12, $00
    db $EA, $F8, $13, $00, $EA, $00, $14, $00, $EA, $0C, $15, $00, $80

Data_03D_42FD:: ; heuristic: target of a monotone pointer table; C0
    db $E2, $00, $16, $00, $EA, $00, $19, $00, $E9, $0E, $15, $00, $E2, $10, $18, $00
    db $E2, $08, $17, $00, $EA, $08, $1A, $00, $E0, $E8, $1C, $00, $E0, $F0, $1D, $00
    db $D8, $E8, $1B, $00, $DA, $F3, $09, $00, $DA, $FB, $0A, $00, $DA, $03, $0B, $00
    db $DC, $F8, $1E, $00, $DC, $00, $1F, $00, $80

Data_03D_4336:: ; heuristic: target of a monotone pointer table; C0
    db $D8, $F0, $10, $00, $D8, $F8, $11, $00, $D8, $00, $12, $00, $D8, $E8, $0F, $00
    db $E0, $E8, $13, $00, $E0, $F0, $14, $00, $E0, $FC, $15, $00, $E9, $F6, $0C, $00
    db $E9, $FE, $0D, $00, $E9, $06, $0E, $00, $D0, $00, $00, $00, $D0, $08, $01, $00
    db $80

Data_03D_4367:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F4367, $41

Data_03D_43A8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F43A8, $41

Data_03D_43E9:: ; heuristic: target of a monotone pointer table; C0
    db $E4, $F5, $09, $00, $E4, $FD, $0A, $00, $E4, $05, $0B, $00, $D0, $00, $10, $00
    db $D0, $08, $11, $00, $D0, $10, $12, $00, $D0, $F8, $0F, $00, $D8, $F8, $13, $00
    db $D8, $00, $14, $00, $D8, $0C, $15, $00, $F8, $EE, $1C, $00, $F8, $F6, $1D, $00
    db $F4, $FE, $1E, $00, $F4, $06, $1F, $00, $F0, $EE, $1B, $00, $80

Data_03D_4426:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F4426, $41

Data_03D_4467:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $F6, $16, $00, $F8, $F6, $19, $00, $F7, $04, $15, $00, $F0, $FE, $17, $00
    db $F8, $FE, $1A, $00, $F0, $06, $18, $00, $E8, $F0, $09, $00, $E8, $F8, $0A, $00
    db $E8, $00, $0B, $00, $D8, $F0, $0C, $00, $D8, $F8, $0D, $00, $D8, $00, $0E, $00
    db $DC, $04, $02, $00, $DC, $0C, $03, $00, $80

Data_03D_44A0:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $E8, $1C, $00, $F0, $F0, $1D, $00, $E8, $E8, $1B, $00, $EC, $F8, $1E, $00
    db $EC, $00, $1F, $00, $F8, $F0, $0C, $00, $F8, $F8, $0D, $00, $F8, $00, $0E, $00
    db $DC, $00, $09, $00, $DC, $08, $0A, $00, $DC, $10, $0B, $00, $80

Data_03D_44CD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F44CD, $45

Data_03D_4512:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F4512, $55

Data_03D_4567:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F4567, $4D

Data_03D_45B4:: ; heuristic: target of a monotone pointer table; C0
    db $E0, $F5, $09, $00, $E0, $FD, $0A, $00, $E0, $05, $0B, $00, $D0, $00, $10, $00
    db $D0, $08, $11, $00, $D0, $10, $12, $00, $D0, $F8, $0F, $00, $D8, $F8, $13, $00
    db $D8, $00, $14, $00, $D8, $0C, $15, $00, $F4, $EE, $1C, $00, $F4, $F6, $1D, $00
    db $F0, $FE, $1E, $00, $F0, $06, $1F, $00, $EC, $EE, $1B, $00, $80

Data_03D_45F1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F45F1, $41

Data_03D_4632:: ; heuristic: target of a monotone pointer table; C0
    db $EC, $EE, $16, $00, $F4, $EE, $19, $00, $F3, $FC, $15, $00, $EC, $F6, $17, $00
    db $F4, $F6, $1A, $00, $EC, $FE, $18, $00, $E0, $FD, $00, $00, $E0, $05, $01, $00
    db $D8, $F0, $0C, $00, $D8, $F8, $0D, $00, $D8, $00, $0E, $00, $80

Data_03D_465F:: ; heuristic: target of a monotone pointer table; C0
    db $E0, $FD, $02, $00, $E0, $05, $03, $00, $D4, $FB, $00, $00, $D4, $03, $01, $00
    db $F4, $E8, $0C, $00, $F4, $F0, $0D, $00, $F4, $F8, $0E, $00, $80

Data_03D_467C:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03D_467D:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03D_46BD
    dw Data_03D_46CE
    dw Data_03D_46EF
    dw Data_03D_4718
    dw Data_03D_4749
    dw Data_03D_4766
    dw Data_03D_477F
    dw Data_03D_478C
    dw Data_03D_4799
    dw Data_03D_47B6
    dw Data_03D_47EF
    dw Data_03D_4854
    dw Data_03D_48B9
    dw Data_03D_48B9
    dw Data_03D_48B9
    dw Data_03D_48B9
    dw Data_03D_48B9
    dw Data_03D_48B9
    dw Data_03D_48B9
    dw Data_03D_48B9
    dw Data_03D_48B9
    dw Data_03D_48B9
    dw Data_03D_48B9
    dw Data_03D_48B9
    dw Data_03D_48B9
    dw Data_03D_48B9
    dw Data_03D_48B9
    dw Data_03D_48B9
    dw Data_03D_48B9
    dw Data_03D_48B9
    dw Data_03D_48B9
    dw Data_03D_48B9

Data_03D_46BD:: ; heuristic: target of a monotone pointer table; C0
    db $D8, $03, $20, $00, $D8, $0B, $21, $00, $D0, $03, $22, $00, $D0, $0B, $23, $00
    db $80

Data_03D_46CE:: ; heuristic: target of a monotone pointer table; C0
    db $DC, $00, $20, $00, $DC, $08, $21, $00, $D4, $00, $22, $00, $D4, $08, $23, $00
    db $E4, $F8, $20, $60, $E4, $F0, $21, $60, $EC, $F8, $22, $60, $EC, $F0, $23, $60
    db $80

Data_03D_46EF:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $F4, $2C, $00, $F8, $F0, $2D, $00, $E8, $F8, $2A, $00, $E8, $00, $2B, $00
    db $D0, $04, $24, $00, $D0, $0C, $25, $00, $D8, $00, $26, $00, $D8, $08, $27, $00
    db $E0, $FB, $28, $00, $E0, $03, $29, $00, $80

Data_03D_4718:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F0, $2C, $00, $F0, $EC, $2E, $00, $D8, $08, $25, $00, $D0, $0C, $2E, $00
    db $D0, $04, $24, $00, $D8, $00, $28, $40, $E0, $FC, $26, $00, $E0, $04, $27, $00
    db $E8, $F7, $28, $00, $E8, $FF, $29, $00, $F0, $F4, $2A, $00, $F0, $FC, $2B, $00
    db $80

Data_03D_4749:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $EE, $2E, $00, $F0, $F3, $2E, $00, $E8, $F8, $2E, $00, $E0, $FE, $2E, $00
    db $D8, $03, $2E, $00, $D0, $08, $2E, $00, $E0, $F6, $24, $00, $80

Data_03D_4766:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $EE, $2E, $00, $F0, $F3, $2E, $00, $E8, $F8, $2E, $00, $E0, $FE, $2F, $00
    db $D8, $03, $2F, $00, $F8, $E6, $24, $00, $80

Data_03D_477F:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F0, $2F, $00, $F0, $F5, $2F, $00, $E8, $FA, $2F, $00, $80

Data_03D_478C:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F8, $1C, $00, $F8, $00, $1E, $00, $F0, $FD, $1F, $00, $80

Data_03D_4799:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $FC, $1D, $00, $F8, $04, $1E, $00, $F0, $FC, $1A, $00, $F0, $04, $1B, $00
    db $F8, $F4, $1C, $00, $F0, $F4, $19, $00, $EA, $FA, $00, $20, $80

Data_03D_47B6:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $FC, $0E, $00, $E8, $FC, $1A, $20, $E8, $F4, $1B, $20, $F0, $FC, $1D, $20
    db $F8, $F4, $14, $00, $F8, $04, $16, $00, $F0, $0C, $19, $20, $F8, $0C, $1C, $20
    db $F0, $EC, $1B, $20, $F8, $EC, $1E, $20, $E2, $FE, $00, $00, $E8, $04, $0C, $00
    db $F0, $04, $1E, $00, $F0, $F4, $0E, $00, $80

Data_03D_47EF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F47EF, $65

Data_03D_4854:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F4854, $65

Data_03D_48B9:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03D_48BA:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03D_48FA
    dw Data_03D_4903
    dw Data_03D_491C
    dw Data_03D_4935
    dw Data_03D_494E
    dw Data_03D_498F
    dw Data_03D_49B0
    dw Data_03D_49B0
    dw Data_03D_49B0
    dw Data_03D_49B0
    dw Data_03D_49B0
    dw Data_03D_49B0
    dw Data_03D_49B0
    dw Data_03D_49B0
    dw Data_03D_49B0
    dw Data_03D_49B0
    dw Data_03D_49B0
    dw Data_03D_49B0
    dw Data_03D_49B0
    dw Data_03D_49B0
    dw Data_03D_49B0
    dw Data_03D_49B0
    dw Data_03D_49B0
    dw Data_03D_49B0
    dw Data_03D_49B0
    dw Data_03D_49B0
    dw Data_03D_49B0
    dw Data_03D_49B0
    dw Data_03D_49B0
    dw Data_03D_49B0
    dw Data_03D_49B0
    dw Data_03D_49B0

Data_03D_48FA:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $F8, $04, $00, $D0, $00, $05, $00, $80

Data_03D_4903:: ; heuristic: target of a monotone pointer table; C0
    db $E0, $F8, $04, $00, $E0, $00, $05, $00, $D8, $F8, $02, $00, $D8, $00, $03, $00
    db $D0, $F8, $00, $00, $D0, $00, $01, $00, $80

Data_03D_491C:: ; heuristic: target of a monotone pointer table; C0
    db $DC, $F8, $17, $00, $DC, $00, $17, $20, $E4, $F0, $15, $00, $E4, $F8, $16, $00
    db $E4, $08, $15, $20, $E4, $00, $16, $20, $80

Data_03D_4935:: ; heuristic: target of a monotone pointer table; C0
    db $E4, $00, $07, $00, $E4, $08, $08, $00, $E4, $F8, $07, $20, $E4, $F0, $08, $20
    db $DC, $F8, $00, $00, $DC, $00, $01, $00, $80

Data_03D_494E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F494E, $41

Data_03D_498F:: ; heuristic: target of a monotone pointer table; C0
    db $DC, $F8, $09, $20, $DC, $F0, $0A, $20, $DC, $00, $09, $00, $DC, $08, $0A, $00
    db $E4, $F8, $0B, $20, $E4, $F0, $0C, $20, $E4, $00, $0B, $00, $E4, $08, $0C, $00
    db $80

Data_03D_49B0:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03D_49B1:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03D_49F1
    dw Data_03D_49FA
    dw Data_03D_4A0B
    dw Data_03D_4A38
    dw Data_03D_4A79
    dw Data_03D_4AB6
    dw Data_03D_4AD7
    dw Data_03D_4AE0
    dw Data_03D_4AE0
    dw Data_03D_4AE0
    dw Data_03D_4AE0
    dw Data_03D_4AE0
    dw Data_03D_4AE0
    dw Data_03D_4AE0
    dw Data_03D_4AE0
    dw Data_03D_4AE0
    dw Data_03D_4AE0
    dw Data_03D_4AE0
    dw Data_03D_4AE0
    dw Data_03D_4AE0
    dw Data_03D_4AE0
    dw Data_03D_4AE0
    dw Data_03D_4AE0
    dw Data_03D_4AE0
    dw Data_03D_4AE0
    dw Data_03D_4AE0
    dw Data_03D_4AE0
    dw Data_03D_4AE0
    dw Data_03D_4AE0
    dw Data_03D_4AE0
    dw Data_03D_4AE0
    dw Data_03D_4AE0

Data_03D_49F1:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F0, $00, $60, $F8, $E8, $01, $60, $80

Data_03D_49FA:: ; heuristic: target of a monotone pointer table; C0
    db $F7, $F5, $00, $60, $F7, $ED, $01, $60, $F1, $FD, $00, $00, $F1, $05, $01, $00
    db $80

Data_03D_4A0B:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F0, $0B, $00, $F8, $F8, $0C, $00, $F0, $FC, $09, $00, $F0, $04, $0A, $00
    db $E0, $08, $05, $00, $E0, $10, $06, $00, $E8, $04, $07, $00, $E8, $0C, $08, $00
    db $D8, $10, $04, $00, $D0, $08, $02, $00, $D0, $10, $03, $00, $80

Data_03D_4A38:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F4A38, $41

Data_03D_4A79:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F0, $0B, $00, $F8, $F8, $0C, $00, $D0, $FC, $17, $00, $D0, $04, $18, $00
    db $D0, $0C, $19, $00, $D8, $EC, $1A, $00, $D8, $F4, $1B, $00, $D8, $FC, $1C, $00
    db $D8, $08, $1D, $00, $D8, $10, $1E, $00, $E0, $E8, $1F, $00, $E0, $10, $20, $00
    db $E8, $0C, $28, $00, $F0, $FC, $29, $00, $F0, $04, $2A, $00, $80

Data_03D_4AB6:: ; heuristic: target of a monotone pointer table; C0
    db $E0, $E8, $1F, $00, $E0, $10, $27, $00, $D8, $10, $26, $00, $D0, $FC, $21, $00
    db $D0, $04, $22, $00, $D0, $0C, $23, $00, $D8, $EE, $24, $00, $D8, $F6, $25, $00
    db $80

Data_03D_4AD7:: ; heuristic: target of a monotone pointer table; C0
    db $E0, $E8, $1F, $00, $D8, $EE, $24, $00, $80

Data_03D_4AE0:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03D_4AE1:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03D_4B21
    dw Data_03D_4B2A
    dw Data_03D_4B43
    dw Data_03D_4B88
    dw Data_03D_4BCD
    dw Data_03D_4C12
    dw Data_03D_4C5B
    dw Data_03D_4CAC
    dw Data_03D_4CAC
    dw Data_03D_4CAC
    dw Data_03D_4CAC
    dw Data_03D_4CAC
    dw Data_03D_4CAC
    dw Data_03D_4CAC
    dw Data_03D_4CAC
    dw Data_03D_4CAC
    dw Data_03D_4CAC
    dw Data_03D_4CAC
    dw Data_03D_4CAC
    dw Data_03D_4CAC
    dw Data_03D_4CAC
    dw Data_03D_4CAC
    dw Data_03D_4CAC
    dw Data_03D_4CAC
    dw Data_03D_4CAC
    dw Data_03D_4CAC
    dw Data_03D_4CAC
    dw Data_03D_4CAC
    dw Data_03D_4CAC
    dw Data_03D_4CAC
    dw Data_03D_4CAC
    dw Data_03D_4CAC

Data_03D_4B21:: ; heuristic: target of a monotone pointer table; C0
    db $D8, $FC, $00, $00, $D0, $FC, $01, $00, $80

Data_03D_4B2A:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $F8, $05, $00, $D8, $F8, $08, $00, $E0, $FC, $01, $00, $D0, $FC, $03, $00
    db $D8, $FC, $02, $00, $E8, $FC, $0B, $00, $80

Data_03D_4B43:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F4B43, $45

Data_03D_4B88:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F4B88, $45

Data_03D_4BCD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F4BCD, $45

Data_03D_4C12:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F4C12, $49

Data_03D_4C5B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F4C5B, $51

Data_03D_4CAC:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03D_4CAD:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03D_4CED
    dw Data_03D_4CF6
    dw Data_03D_4D0F
    dw Data_03D_4D40
    dw Data_03D_4D89
    dw Data_03D_4DBA
    dw Data_03D_4E03
    dw Data_03D_4E24
    dw Data_03D_4E3D
    dw Data_03D_4E56
    dw Data_03D_4E56
    dw Data_03D_4E56
    dw Data_03D_4E56
    dw Data_03D_4E56
    dw Data_03D_4E56
    dw Data_03D_4E56
    dw Data_03D_4E56
    dw Data_03D_4E56
    dw Data_03D_4E56
    dw Data_03D_4E56
    dw Data_03D_4E56
    dw Data_03D_4E56
    dw Data_03D_4E56
    dw Data_03D_4E56
    dw Data_03D_4E56
    dw Data_03D_4E56
    dw Data_03D_4E56
    dw Data_03D_4E56
    dw Data_03D_4E56
    dw Data_03D_4E56
    dw Data_03D_4E56
    dw Data_03D_4E56

Data_03D_4CED:: ; heuristic: target of a monotone pointer table; C0
    db $D8, $FC, $00, $00, $D0, $FC, $01, $00, $80

Data_03D_4CF6:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $FC, $00, $00, $E0, $FC, $01, $00, $D0, $FC, $03, $00, $D8, $FC, $02, $00
    db $E4, $F4, $06, $20, $E4, $03, $06, $00, $80

Data_03D_4D0F:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $FC, $00, $00, $F0, $FC, $01, $00, $E0, $FC, $03, $00, $E8, $FC, $02, $00
    db $D8, $FC, $04, $00, $D0, $FC, $05, $00, $DC, $03, $07, $00, $DC, $0B, $08, $00
    db $E4, $03, $09, $00, $E4, $F4, $09, $20, $DC, $F4, $07, $20, $DC, $EC, $08, $20
    db $80

Data_03D_4D40:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F4D40, $49

Data_03D_4D89:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $FC, $10, $00, $D8, $FC, $10, $00, $E0, $FC, $10, $00, $E8, $FC, $10, $00
    db $F0, $FC, $10, $00, $F8, $FC, $10, $00, $E4, $F4, $09, $20, $DC, $F4, $07, $20
    db $DC, $EC, $08, $20, $DC, $04, $07, $00, $DC, $0C, $08, $00, $E4, $03, $09, $00
    db $80

Data_03D_4DBA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F4DBA, $49

Data_03D_4E03:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $FB, $10, $20, $D8, $FB, $10, $20, $E0, $FB, $10, $20, $E8, $FB, $10, $20
    db $F0, $FB, $10, $20, $F8, $FB, $10, $20, $E4, $F4, $06, $20, $E4, $03, $06, $00
    db $80

Data_03D_4E24:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $FC, $11, $00, $D8, $FC, $11, $00, $E0, $FC, $11, $00, $E8, $FC, $11, $00
    db $F0, $FC, $11, $00, $F8, $FC, $11, $00, $80

Data_03D_4E3D:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $FB, $11, $20, $D8, $FB, $11, $20, $E0, $FB, $11, $20, $E8, $FB, $11, $20
    db $F0, $FB, $11, $20, $F8, $FB, $11, $20, $80

Data_03D_4E56:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03D_4E57:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03D_4E97
    dw Data_03D_4EA8
    dw Data_03D_4EC9
    dw Data_03D_4EEA
    dw Data_03D_4F27
    dw Data_03D_4F68
    dw Data_03D_4F95
    dw Data_03D_4FC2
    dw Data_03D_5053
    dw Data_03D_5084
    dw Data_03D_50B5
    dw Data_03D_50E6
    dw Data_03D_5117
    dw Data_03D_5117
    dw Data_03D_5117
    dw Data_03D_5117
    dw Data_03D_5117
    dw Data_03D_5117
    dw Data_03D_5117
    dw Data_03D_5117
    dw Data_03D_5117
    dw Data_03D_5117
    dw Data_03D_5117
    dw Data_03D_5117
    dw Data_03D_5117
    dw Data_03D_5117
    dw Data_03D_5117
    dw Data_03D_5117
    dw Data_03D_5117
    dw Data_03D_5117
    dw Data_03D_5117
    dw Data_03D_5117

Data_03D_4E97:: ; heuristic: target of a monotone pointer table; C0
    db $D8, $03, $00, $00, $D8, $0B, $01, $00, $D0, $03, $02, $00, $D0, $0B, $03, $00
    db $80

Data_03D_4EA8:: ; heuristic: target of a monotone pointer table; C0
    db $DC, $FF, $00, $00, $DC, $07, $01, $00, $D4, $FF, $02, $00, $D4, $07, $03, $00
    db $E4, $F9, $00, $60, $E4, $F1, $01, $60, $EC, $F9, $02, $60, $EC, $F1, $03, $60
    db $80

Data_03D_4EC9:: ; heuristic: target of a monotone pointer table; C0
    db $E0, $FE, $11, $00, $E0, $06, $12, $00, $D8, $0E, $10, $00, $D8, $FE, $0E, $00
    db $D8, $06, $0F, $00, $D0, $02, $0B, $00, $D0, $0A, $0C, $00, $D0, $12, $0D, $00
    db $80

Data_03D_4EEA:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $F5, $11, $00, $F0, $FD, $12, $00, $D0, $02, $06, $00, $D0, $0A, $07, $00
    db $D8, $01, $09, $00, $D8, $09, $0A, $00, $E0, $09, $0D, $00, $E8, $05, $10, $00
    db $D8, $F9, $08, $00, $D8, $F7, $19, $00, $E8, $F0, $1D, $00, $E8, $F8, $1E, $00
    db $E8, $00, $1F, $00, $E0, $F9, $1B, $00, $E0, $01, $1C, $00, $80

Data_03D_4F27:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F4F27, $41

Data_03D_4F68:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $F4, $13, $00, $F8, $EF, $13, $00, $D8, $04, $14, $00, $EC, $F0, $1D, $00
    db $EC, $F8, $1E, $00, $EC, $00, $1F, $00, $DC, $09, $1A, $00, $DC, $F8, $19, $00
    db $E0, $FF, $14, $00, $E4, $F9, $1B, $00, $E4, $01, $1C, $00, $80

Data_03D_4F95:: ; heuristic: target of a monotone pointer table; C0
    db $DC, $F4, $2E, $00, $E4, $F4, $2F, $40, $DC, $FC, $2D, $20, $DC, $04, $2E, $20
    db $E4, $04, $2F, $60, $E4, $FC, $04, $00, $F8, $EF, $14, $00, $F0, $F4, $14, $00
    db $EC, $FC, $2D, $60, $EC, $04, $2E, $60, $EC, $F4, $2E, $40, $80

Data_03D_4FC2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F4FC2, $91

Data_03D_5053:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $05, $15, $00, $D0, $0D, $16, $00, $D8, $00, $15, $00, $D8, $08, $16, $00
    db $E0, $FB, $15, $00, $E0, $03, $16, $00, $E8, $F5, $15, $00, $E8, $FD, $16, $00
    db $F0, $F0, $15, $00, $F0, $F8, $16, $00, $F8, $EB, $15, $00, $F8, $F3, $16, $00
    db $80

Data_03D_5084:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $0D, $15, $60, $D0, $05, $16, $60, $D8, $08, $15, $60, $D8, $00, $16, $60
    db $E0, $03, $15, $60, $E0, $FB, $16, $60, $E8, $FD, $15, $60, $E8, $F5, $16, $60
    db $F0, $F8, $15, $60, $F0, $F0, $16, $60, $F8, $F3, $15, $60, $F8, $EB, $16, $60
    db $80

Data_03D_50B5:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $05, $17, $00, $D0, $0D, $18, $00, $D8, $00, $17, $00, $D8, $08, $18, $00
    db $E0, $FB, $17, $00, $E0, $03, $18, $00, $E8, $F5, $17, $00, $E8, $FD, $18, $00
    db $F0, $F0, $17, $00, $F0, $F8, $18, $00, $F8, $EB, $17, $00, $F8, $F3, $18, $00
    db $80

Data_03D_50E6:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $0D, $17, $60, $D0, $05, $18, $60, $D8, $08, $17, $60, $D8, $00, $18, $60
    db $E0, $03, $17, $60, $E0, $FB, $18, $60, $E8, $FD, $17, $60, $E8, $F5, $18, $60
    db $F0, $F8, $17, $60, $F0, $F0, $18, $60, $F8, $F3, $17, $60, $F8, $EB, $18, $60
    db $80

Data_03D_5117:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03D_5118:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03D_5158
    dw Data_03D_516D
    dw Data_03D_518E
    dw Data_03D_51CF
    dw Data_03D_5228
    dw Data_03D_5285
    dw Data_03D_52EA
    dw Data_03D_5343
    dw Data_03D_5378
    dw Data_03D_53A5
    dw Data_03D_53CA
    dw Data_03D_53F3
    dw Data_03D_54B4
    dw Data_03D_5585
    dw Data_03D_5666
    dw Data_03D_5666
    dw Data_03D_5666
    dw Data_03D_5666
    dw Data_03D_5666
    dw Data_03D_5666
    dw Data_03D_5666
    dw Data_03D_5666
    dw Data_03D_5666
    dw Data_03D_5666
    dw Data_03D_5666
    dw Data_03D_5666
    dw Data_03D_5666
    dw Data_03D_5666
    dw Data_03D_5666
    dw Data_03D_5666
    dw Data_03D_5666
    dw Data_03D_5666

Data_03D_5158:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $B0, $1C, $10, $E8, $C0, $1E, $10, $E8, $C8, $1F, $10, $E6, $B8, $1D, $10
    db $E2, $BF, $22, $10, $80

Data_03D_516D:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $B0, $1C, $10, $E8, $B8, $1C, $10, $E8, $C0, $1C, $10, $E8, $D0, $1E, $10
    db $E8, $D8, $1F, $10, $E6, $C8, $1D, $10, $DC, $BA, $22, $10, $E2, $C2, $22, $10
    db $80

Data_03D_518E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F518E, $41

Data_03D_51CF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F51CF, $59

Data_03D_5228:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F5228, $5D

Data_03D_5285:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F5285, $65

Data_03D_52EA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F52EA, $59

Data_03D_5343:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $1F, $1C, $10, $E8, $27, $1C, $10, $E8, $37, $1E, $10, $E8, $3F, $1F, $10
    db $DB, $FA, $12, $10, $E6, $2F, $1D, $10, $DE, $D6, $22, $10, $DB, $1D, $22, $10
    db $E8, $F1, $20, $10, $E8, $04, $20, $10, $E8, $0D, $20, $10, $E8, $15, $21, $10
    db $E2, $27, $26, $10, $80

Data_03D_5378:: ; heuristic: target of a monotone pointer table; C0
    db $E0, $3D, $12, $10, $E8, $15, $20, $10, $E8, $20, $20, $10, $E8, $29, $20, $10
    db $E8, $3A, $20, $10, $E0, $2D, $22, $10, $E8, $32, $21, $10, $E8, $4A, $21, $10
    db $E8, $B8, $20, $10, $E8, $D4, $20, $10, $E8, $F4, $22, $10, $80

Data_03D_53A5:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $4A, $20, $10, $E8, $20, $20, $10, $E8, $3E, $22, $10, $E8, $2E, $21, $10
    db $E8, $0D, $21, $10, $E8, $02, $22, $10, $E8, $DC, $22, $10, $E8, $EA, $20, $10
    db $E8, $BB, $22, $10, $80

Data_03D_53CA:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $B1, $20, $10, $E8, $D2, $20, $10, $E8, $F8, $20, $10, $E8, $E0, $21, $10
    db $E8, $BF, $22, $10, $E8, $0B, $22, $10, $E8, $13, $20, $10, $E8, $34, $20, $10
    db $E8, $1C, $21, $10, $E8, $40, $21, $10, $80

Data_03D_53F3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F53F3, $C1

Data_03D_54B4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F54B4, $D1

Data_03D_5585:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F5585, $E1

Data_03D_5666:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03D_5667:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03D_56A7
    dw Data_03D_56D4
    dw Data_03D_5725
    dw Data_03D_5772
    dw Data_03D_57DB
    dw Data_03D_5864
    dw Data_03D_58E1
    dw Data_03D_58E1
    dw Data_03D_58E1
    dw Data_03D_58E1
    dw Data_03D_58E1
    dw Data_03D_58E1
    dw Data_03D_58E1
    dw Data_03D_58E1
    dw Data_03D_58E1
    dw Data_03D_58E1
    dw Data_03D_58E1
    dw Data_03D_58E1
    dw Data_03D_58E1
    dw Data_03D_58E1
    dw Data_03D_58E1
    dw Data_03D_58E1
    dw Data_03D_58E1
    dw Data_03D_58E1
    dw Data_03D_58E1
    dw Data_03D_58E1
    dw Data_03D_58E1
    dw Data_03D_58E1
    dw Data_03D_58E1
    dw Data_03D_58E1
    dw Data_03D_58E1
    dw Data_03D_58E1

Data_03D_56A7:: ; heuristic: target of a monotone pointer table; C0
    db $E4, $02, $0F, $10, $EC, $02, $1F, $10, $F8, $F2, $2F, $10, $F8, $FF, $21, $10
    db $F8, $F7, $26, $10, $F0, $FF, $29, $50, $E5, $EF, $19, $10, $E9, $F4, $2A, $70
    db $F0, $F7, $20, $10, $E9, $FC, $29, $50, $E3, $FB, $17, $10, $80

Data_03D_56D4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F56D4, $51

Data_03D_5725:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F5725, $4D

Data_03D_5772:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F5772, $69

Data_03D_57DB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F57DB, $89

Data_03D_5864:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F5864, $7D

Data_03D_58E1:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03D_58E2:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03D_5922
    dw Data_03D_592B
    dw Data_03D_594C
    dw Data_03D_59C5
    dw Data_03D_5A62
    dw Data_03D_5AFB
    dw Data_03D_5B9C
    dw Data_03D_5C3D
    dw Data_03D_5CDE
    dw Data_03D_5D6B
    dw Data_03D_5DE4
    dw Data_03D_5E75
    dw Data_03D_5EFE
    dw Data_03D_5F87
    dw Data_03D_600C
    dw Data_03D_6099
    dw Data_03D_6112
    dw Data_03D_61A3
    dw Data_03D_622C
    dw Data_03D_62B5
    dw Data_03D_633E
    dw Data_03D_633E
    dw Data_03D_633E
    dw Data_03D_633E
    dw Data_03D_633E
    dw Data_03D_633E
    dw Data_03D_633E
    dw Data_03D_633E
    dw Data_03D_633E
    dw Data_03D_633E
    dw Data_03D_633E
    dw Data_03D_633E

Data_03D_5922:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F8, $1B, $00, $F8, $00, $1B, $20, $80

Data_03D_592B:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $F0, $1C, $00, $F0, $F8, $1D, $00, $F0, $08, $1C, $20, $F0, $00, $1D, $20
    db $F8, $F0, $1E, $00, $F8, $F8, $1F, $00, $F8, $08, $1E, $20, $F8, $00, $1F, $20
    db $80

Data_03D_594C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F594C, $79

Data_03D_59C5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F59C5, $9D

Data_03D_5A62:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F5A62, $99

Data_03D_5AFB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F5AFB, $A1

Data_03D_5B9C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F5B9C, $A1

Data_03D_5C3D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F5C3D, $A1

Data_03D_5CDE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F5CDE, $8D

Data_03D_5D6B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F5D6B, $79

Data_03D_5DE4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F5DE4, $91

Data_03D_5E75:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F5E75, $89

Data_03D_5EFE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F5EFE, $89

Data_03D_5F87:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F5F87, $85

Data_03D_600C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F600C, $8D

Data_03D_6099:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F6099, $79

Data_03D_6112:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F6112, $91

Data_03D_61A3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F61A3, $89

Data_03D_622C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F622C, $89

Data_03D_62B5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F62B5, $89

Data_03D_633E:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03D_633F:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03D_637F
    dw Data_03D_63DC
    dw Data_03D_646D
    dw Data_03D_64FE
    dw Data_03D_658F
    dw Data_03D_6620
    dw Data_03D_66B1
    dw Data_03D_6742
    dw Data_03D_67D3
    dw Data_03D_6864
    dw Data_03D_6885
    dw Data_03D_68C6
    dw Data_03D_6967
    dw Data_03D_6A08
    dw Data_03D_6AA9
    dw Data_03D_6B3E
    dw Data_03D_6BD7
    dw Data_03D_6C78
    dw Data_03D_6D09
    dw Data_03D_6D96
    dw Data_03D_6E1B
    dw Data_03D_6EBC
    dw Data_03D_6F39
    dw Data_03D_6F92
    dw Data_03D_6FA7
    dw Data_03D_6FA7
    dw Data_03D_6FA7
    dw Data_03D_6FA7
    dw Data_03D_6FA7
    dw Data_03D_6FA7
    dw Data_03D_6FA7
    dw Data_03D_6FA7

Data_03D_637F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F637F, $5D

Data_03D_63DC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F63DC, $91

Data_03D_646D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F646D, $91

Data_03D_64FE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F64FE, $91

Data_03D_658F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F658F, $91

Data_03D_6620:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F6620, $91

Data_03D_66B1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F66B1, $91

Data_03D_6742:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F6742, $91

Data_03D_67D3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F67D3, $91

Data_03D_6864:: ; heuristic: target of a monotone pointer table; C0
    db $D8, $18, $07, $00, $E4, $F8, $12, $00, $E4, $00, $13, $00, $F8, $40, $0C, $00
    db $F8, $48, $0D, $00, $F0, $30, $05, $00, $F8, $E8, $05, $00, $F0, $10, $07, $00
    db $80

Data_03D_6885:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F6885, $41

Data_03D_68C6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F68C6, $A1

Data_03D_6967:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F6967, $A1

Data_03D_6A08:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F6A08, $A1

Data_03D_6AA9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F6AA9, $95

Data_03D_6B3E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F6B3E, $99

Data_03D_6BD7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F6BD7, $A1

Data_03D_6C78:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F6C78, $91

Data_03D_6D09:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F6D09, $8D

Data_03D_6D96:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F6D96, $85

Data_03D_6E1B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F6E1B, $A1

Data_03D_6EBC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F6EBC, $7D

Data_03D_6F39:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F6F39, $59

Data_03D_6F92:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $08, $25, $20, $D0, $00, $26, $20, $D0, $F8, $27, $20, $D8, $06, $28, $20
    db $D8, $FE, $29, $20, $80

Data_03D_6FA7:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03D_6FA8:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03D_6FE8
    dw Data_03D_7059
    dw Data_03D_70E2
    dw Data_03D_719B
    dw Data_03D_7244
    dw Data_03D_7305
    dw Data_03D_73EE
    dw Data_03D_74CF
    dw Data_03D_7578
    dw Data_03D_7639
    dw Data_03D_7639
    dw Data_03D_7639
    dw Data_03D_7639
    dw Data_03D_7639
    dw Data_03D_7639
    dw Data_03D_7639
    dw Data_03D_7639
    dw Data_03D_7639
    dw Data_03D_7639
    dw Data_03D_7639
    dw Data_03D_7639
    dw Data_03D_7639
    dw Data_03D_7639
    dw Data_03D_7639
    dw Data_03D_7639
    dw Data_03D_7639
    dw Data_03D_7639
    dw Data_03D_7639
    dw Data_03D_7639
    dw Data_03D_7639
    dw Data_03D_7639
    dw Data_03D_7639

Data_03D_6FE8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F6FE8, $71

Data_03D_7059:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F7059, $89

Data_03D_70E2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F70E2, $B9

Data_03D_719B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F719B, $A9

Data_03D_7244:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F7244, $C1

Data_03D_7305:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F7305, $E9

Data_03D_73EE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F73EE, $E1

Data_03D_74CF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F74CF, $A9

Data_03D_7578:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0F7578, $C1

Data_03D_7639:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03D_763A:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03D_767A
    dw Data_03D_768B
    dw Data_03D_769C
    dw Data_03D_76AD
    dw Data_03D_76BE
    dw Data_03D_76CF
    dw Data_03D_76E0
    dw Data_03D_76F1
    dw Data_03D_7702
    dw Data_03D_7713
    dw Data_03D_7724
    dw Data_03D_7724
    dw Data_03D_7724
    dw Data_03D_7724
    dw Data_03D_7724
    dw Data_03D_7724
    dw Data_03D_7724
    dw Data_03D_7724
    dw Data_03D_7724
    dw Data_03D_7724
    dw Data_03D_7724
    dw Data_03D_7724
    dw Data_03D_7724
    dw Data_03D_7724
    dw Data_03D_7724
    dw Data_03D_7724
    dw Data_03D_7724
    dw Data_03D_7724
    dw Data_03D_7724
    dw Data_03D_7724
    dw Data_03D_7724
    dw Data_03D_7724

Data_03D_767A:: ; heuristic: target of a monotone pointer table; C0
    db $DF, $01, $00, $00, $DF, $09, $01, $00, $E7, $01, $02, $00, $E7, $09, $03, $00
    db $80

Data_03D_768B:: ; heuristic: target of a monotone pointer table; C0
    db $DC, $05, $00, $00, $DC, $0D, $01, $00, $E4, $05, $02, $00, $E4, $0D, $03, $00
    db $80

Data_03D_769C:: ; heuristic: target of a monotone pointer table; C0
    db $DA, $FE, $00, $00, $DA, $06, $01, $00, $E2, $FE, $02, $00, $E2, $06, $03, $00
    db $80

Data_03D_76AD:: ; heuristic: target of a monotone pointer table; C0
    db $D6, $02, $00, $00, $D6, $0A, $01, $00, $DE, $02, $02, $00, $DE, $0A, $03, $00
    db $80

Data_03D_76BE:: ; heuristic: target of a monotone pointer table; C0
    db $D5, $07, $00, $00, $D5, $0F, $01, $00, $DD, $07, $02, $00, $DD, $0F, $03, $00
    db $80

Data_03D_76CF:: ; heuristic: target of a monotone pointer table; C0
    db $D4, $0B, $00, $00, $D4, $13, $01, $00, $DC, $0B, $02, $00, $DC, $13, $03, $00
    db $80

Data_03D_76E0:: ; heuristic: target of a monotone pointer table; C0
    db $D2, $0A, $00, $00, $D2, $12, $01, $00, $DA, $0A, $02, $00, $DA, $12, $03, $00
    db $80

Data_03D_76F1:: ; heuristic: target of a monotone pointer table; C0
    db $D1, $08, $00, $00, $D1, $10, $01, $00, $D9, $08, $02, $00, $D9, $10, $03, $00
    db $80

Data_03D_7702:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $0A, $00, $00, $D0, $12, $01, $00, $D8, $0A, $02, $00, $D8, $12, $03, $00
    db $80

Data_03D_7713:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $0C, $00, $00, $D0, $14, $01, $00, $D8, $0C, $02, $00, $D8, $14, $03, $00
    db $80

Data_03D_7724:: ; heuristic: target of a monotone pointer table; C0
    db $80
    ds $8DB, $00
