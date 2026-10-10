SECTION "Bank 3F", ROMX[$4000], BANK[$3F]
    db $3F

; only called from DrawEffectSpriteForWD801Range (E-0047)
; 1 call site from 1 routine (e.g. DrawEffectSpriteForWD801Range)
; reads: wD801, wDAD2, wD88F, wBattleTarget, wD804, wDAB7
; writes: wD871, wD868
; points at: wD871, wD868, hSpriteOriginX
DrawEffectSpriteForWD801Range_Sub02::
Func_03F_4001:: ; address name
    ld a, [wD801]
    cp a, $15
    jr nz, DrawEffectSpriteAtWD804_Bank3F
    ld a, [wDAD2]
    bit 3, a
    jr z, DrawEffectSpriteAtWD804_Bank3F
    ld a, [wD88F]
    ld [wD871], a
    ld a, [wBattleTarget]
    and a, $04
    ld [wD868], a
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_03F_402B
    farcall SetEffectSpriteXForTargets
    call DrawEffectSpriteAtWD804_Bank3F

Jump_03F_402B::
    ld hl, wD871
    dec [hl]
    ld a, [hl]
    or a, a
    ret z
    ld hl, wD868
    inc [hl]
    ld a, [hl]
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_03F_4045
    farcall SetEffectSpriteXForTargets
    call DrawEffectSpriteAtWD804_Bank3F

Jump_03F_4045::
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
; 2 call sites from 1 routine (e.g. DrawEffectSpriteForWD801Range_Sub02)
; reads: wD804, wD801, wDAB7
; points at: hSpriteOriginX
DrawEffectSpriteAtWD804_Bank3F::
Func_03F_405B:: ; address name
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
    ld de, Data_03F_407E
    call BuildOamFromSpriteTable_Bank3F
    ret

Data_03F_407E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_03F_410F
    dw Data_03F_410F
    dw Data_03F_410F
    dw Data_03F_410F
    dw Data_03F_410F
    dw Data_03F_410F
    dw Data_03F_410F
    dw Data_03F_410F
    dw Data_03F_410F
    dw Data_03F_410F
    dw Data_03F_410F
    dw Data_03F_410F
    dw Data_03F_410F
    dw Data_03F_410F
    dw Data_03F_410F
    dw Data_03F_4835
    dw Data_03F_49A2
    dw Data_03F_4C8D
    dw Data_03F_5242
    dw Data_03F_543E
    dw Data_03F_55C7
    dw Data_03F_5703
    dw Data_03F_580E
    dw Data_03F_58F0
    dw Data_03F_5C03
    dw Data_03F_5E70
    dw Data_03F_6064
    dw Data_03F_67E4
    dw Data_03F_6949
    dw Data_03F_6DB6
    dw Data_03F_6E99
    dw Data_03F_734A

; DE = two-level table; entries are chosen by hSpriteSetIndex and hSpriteSubIndex; writes 4-byte OAM entries at $C000 + 4 * hOamNextEntry (Y = hSpriteOriginY + b + $10, X = hSpriteOriginX + b + 8, tile += hSpriteTileOffset, flags ^= hSpriteAttrXor) until a $80 byte or hOamNextEntry reaches $28 (40 entries) (the same 81 bytes appear in 5 banks)
; 1 call site from 1 routine (e.g. DrawEffectSpriteAtWD804_Bank3F)
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

Data_03F_410F:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03F_414F
    dw Data_03F_41E0
    dw Data_03F_4271
    dw Data_03F_4302
    dw Data_03F_43A3
    dw Data_03F_4444
    dw Data_03F_4485
    dw Data_03F_4516
    dw Data_03F_45A7
    dw Data_03F_4638
    dw Data_03F_46C9
    dw Data_03F_475A
    dw Data_03F_47EB
    dw Data_03F_4834
    dw Data_03F_4834
    dw Data_03F_4834
    dw Data_03F_4834
    dw Data_03F_4834
    dw Data_03F_4834
    dw Data_03F_4834
    dw Data_03F_4834
    dw Data_03F_4834
    dw Data_03F_4834
    dw Data_03F_4834
    dw Data_03F_4834
    dw Data_03F_4834
    dw Data_03F_4834
    dw Data_03F_4834
    dw Data_03F_4834
    dw Data_03F_4834
    dw Data_03F_4834
    dw Data_03F_4834

Data_03F_414F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FC14F, $91

Data_03F_41E0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FC1E0, $91

Data_03F_4271:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FC271, $91

Data_03F_4302:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FC302, $A1

Data_03F_43A3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FC3A3, $A1

Data_03F_4444:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FC444, $41

Data_03F_4485:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FC485, $91

Data_03F_4516:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FC516, $91

Data_03F_45A7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FC5A7, $91

Data_03F_4638:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FC638, $91

Data_03F_46C9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FC6C9, $91

Data_03F_475A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FC75A, $91

Data_03F_47EB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FC7EB, $49

Data_03F_4834:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03F_4835:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03F_4875
    dw Data_03F_487A
    dw Data_03F_4883
    dw Data_03F_4890
    dw Data_03F_48AD
    dw Data_03F_48E6
    dw Data_03F_491F
    dw Data_03F_4960
    dw Data_03F_49A1
    dw Data_03F_49A1
    dw Data_03F_49A1
    dw Data_03F_49A1
    dw Data_03F_49A1
    dw Data_03F_49A1
    dw Data_03F_49A1
    dw Data_03F_49A1
    dw Data_03F_49A1
    dw Data_03F_49A1
    dw Data_03F_49A1
    dw Data_03F_49A1
    dw Data_03F_49A1
    dw Data_03F_49A1
    dw Data_03F_49A1
    dw Data_03F_49A1
    dw Data_03F_49A1
    dw Data_03F_49A1
    dw Data_03F_49A1
    dw Data_03F_49A1
    dw Data_03F_49A1
    dw Data_03F_49A1
    dw Data_03F_49A1
    dw Data_03F_49A1

Data_03F_4875:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $FC, $00, $00, $80

Data_03F_487A:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $FC, $03, $00, $D8, $FC, $02, $00, $80

Data_03F_4883:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $F8, $0C, $00, $D0, $00, $0D, $00, $D7, $01, $05, $00, $80

Data_03F_4890:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $00, $16, $20, $D0, $F8, $17, $20, $D8, $00, $1C, $00, $D8, $08, $1D, $00
    db $E0, $FA, $18, $20, $E0, $F2, $19, $20, $E8, $F6, $05, $00, $80

Data_03F_48AD:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $F8, $06, $00, $D0, $00, $07, $00, $D8, $F6, $08, $00, $D8, $FE, $09, $00
    db $E0, $F9, $0A, $00, $E0, $01, $0B, $00, $E8, $F4, $0C, $00, $E8, $FC, $0D, $00
    db $F0, $F4, $0E, $00, $F0, $FC, $0F, $00, $F8, $F9, $10, $00, $F8, $01, $11, $00
    db $F8, $04, $1E, $00, $F8, $F8, $1E, $20, $80

Data_03F_48E6:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $FA, $12, $00, $D0, $02, $13, $00, $D8, $FD, $14, $00, $D8, $05, $15, $00
    db $E0, $FD, $16, $00, $E0, $05, $17, $00, $E8, $FD, $18, $00, $E8, $05, $19, $00
    db $F0, $FD, $1A, $00, $F0, $05, $1B, $00, $F8, $FD, $1C, $00, $F8, $05, $1D, $00
    db $F8, $06, $1E, $00, $F8, $F5, $1E, $20, $80

Data_03F_491F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FC91F, $41

Data_03F_4960:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FC960, $41

Data_03F_49A1:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03F_49A2:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03F_49E2
    dw Data_03F_49EB
    dw Data_03F_49F4
    dw Data_03F_4A05
    dw Data_03F_4A12
    dw Data_03F_4A2F
    dw Data_03F_4AC8
    dw Data_03F_4B09
    dw Data_03F_4B8E
    dw Data_03F_4BF7
    dw Data_03F_4C8C
    dw Data_03F_4C8C
    dw Data_03F_4C8C
    dw Data_03F_4C8C
    dw Data_03F_4C8C
    dw Data_03F_4C8C
    dw Data_03F_4C8C
    dw Data_03F_4C8C
    dw Data_03F_4C8C
    dw Data_03F_4C8C
    dw Data_03F_4C8C
    dw Data_03F_4C8C
    dw Data_03F_4C8C
    dw Data_03F_4C8C
    dw Data_03F_4C8C
    dw Data_03F_4C8C
    dw Data_03F_4C8C
    dw Data_03F_4C8C
    dw Data_03F_4C8C
    dw Data_03F_4C8C
    dw Data_03F_4C8C
    dw Data_03F_4C8C

Data_03F_49E2:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $FC, $00, $00, $D0, $FD, $00, $20, $80

Data_03F_49EB:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $F8, $01, $00, $D0, $00, $01, $20, $80

Data_03F_49F4:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $FC, $00, $00, $D0, $FD, $00, $20, $D3, $FD, $03, $00, $DB, $FD, $02, $00
    db $80

Data_03F_4A05:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $F8, $0C, $00, $D0, $00, $0D, $00, $D7, $01, $05, $00, $80

Data_03F_4A12:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $00, $16, $20, $D0, $F8, $17, $20, $D8, $00, $18, $20, $D8, $F8, $19, $20
    db $E0, $FC, $18, $20, $E0, $F4, $19, $20, $E8, $F8, $05, $00, $80

Data_03F_4A2F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FCA2F, $99

Data_03F_4AC8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FCAC8, $41

Data_03F_4B09:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FCB09, $85

Data_03F_4B8E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FCB8E, $69

Data_03F_4BF7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FCBF7, $95

Data_03F_4C8C:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03F_4C8D:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03F_4CCD
    dw Data_03F_4CE6
    dw Data_03F_4D07
    dw Data_03F_4D34
    dw Data_03F_4D65
    dw Data_03F_4D7E
    dw Data_03F_4DB7
    dw Data_03F_4E30
    dw Data_03F_4E89
    dw Data_03F_4EE2
    dw Data_03F_4F83
    dw Data_03F_5000
    dw Data_03F_507D
    dw Data_03F_50FE
    dw Data_03F_517F
    dw Data_03F_51B8
    dw Data_03F_5241
    dw Data_03F_5241
    dw Data_03F_5241
    dw Data_03F_5241
    dw Data_03F_5241
    dw Data_03F_5241
    dw Data_03F_5241
    dw Data_03F_5241
    dw Data_03F_5241
    dw Data_03F_5241
    dw Data_03F_5241
    dw Data_03F_5241
    dw Data_03F_5241
    dw Data_03F_5241
    dw Data_03F_5241
    dw Data_03F_5241

Data_03F_4CCD:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F8, $01, $40, $F8, $00, $01, $60, $D0, $F8, $01, $00, $D0, $00, $01, $20
    db $F0, $FE, $05, $60, $D8, $FA, $05, $00, $80

Data_03F_4CE6:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $FC, $00, $00, $D4, $FC, $2B, $00, $F8, $FC, $00, $40, $F4, $FC, $2B, $40
    db $E7, $FC, $00, $00, $E2, $FC, $00, $40, $DC, $FC, $2F, $00, $ED, $FC, $2F, $00
    db $80

Data_03F_4D07:: ; heuristic: target of a monotone pointer table; C0
    db $DB, $0D, $1D, $00, $EA, $07, $14, $20, $F2, $06, $05, $00, $DB, $F4, $23, $40
    db $E8, $F8, $01, $00, $E0, $F8, $01, $40, $E0, $00, $01, $60, $E8, $00, $01, $20
    db $ED, $F5, $24, $40, $DB, $05, $1C, $00, $EE, $ED, $1D, $60, $80

Data_03F_4D34:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $08, $06, $20, $E8, $00, $02, $60, $E0, $00, $03, $00, $E8, $F8, $2C, $00
    db $E8, $F0, $27, $00, $DC, $08, $27, $60, $F8, $FC, $2E, $00, $F0, $FD, $2D, $00
    db $E0, $F8, $2C, $40, $E0, $F0, $0B, $20, $D0, $FC, $2E, $60, $D8, $FB, $2D, $60
    db $80

Data_03F_4D65:: ; heuristic: target of a monotone pointer table; C0
    db $E0, $FB, $17, $60, $E0, $03, $14, $60, $D8, $03, $10, $60, $E8, $FD, $17, $00
    db $E8, $F5, $14, $00, $F0, $F5, $10, $00, $80

Data_03F_4D7E:: ; heuristic: target of a monotone pointer table; C0
    db $E4, $F8, $1E, $00, $EC, $F8, $1F, $00, $E4, $F0, $1C, $00, $EC, $F0, $1D, $00
    db $E4, $E8, $1F, $40, $EC, $E6, $24, $20, $F1, $E2, $0D, $20, $E4, $00, $1E, $60
    db $DC, $00, $1F, $60, $E4, $08, $1C, $60, $DC, $08, $1D, $60, $E4, $10, $1F, $20
    db $DC, $12, $24, $40, $D7, $16, $0D, $40, $80

Data_03F_4DB7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FCDB7, $79

Data_03F_4E30:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FCE30, $59

Data_03F_4E89:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FCE89, $59

Data_03F_4EE2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FCEE2, $A1

Data_03F_4F83:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FCF83, $7D

Data_03F_5000:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FD000, $7D

Data_03F_507D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FD07D, $81

Data_03F_50FE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FD0FE, $81

Data_03F_517F:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $00, $1E, $60, $E0, $00, $1F, $60, $EA, $08, $1C, $20, $E0, $F8, $1E, $00
    db $E8, $F8, $1F, $00, $DE, $F0, $1C, $40, $DD, $E8, $1F, $00, $D5, $E6, $24, $60
    db $D0, $E2, $0D, $60, $EB, $10, $1F, $60, $F3, $12, $24, $00, $F8, $16, $0D, $00
    db $D6, $F0, $05, $60, $F2, $08, $05, $00, $80

Data_03F_51B8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FD1B8, $89

Data_03F_5241:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03F_5242:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03F_5282
    dw Data_03F_528B
    dw Data_03F_52A0
    dw Data_03F_52C5
    dw Data_03F_52FA
    dw Data_03F_533B
    dw Data_03F_5384
    dw Data_03F_53C5
    dw Data_03F_53FA
    dw Data_03F_541F
    dw Data_03F_5434
    dw Data_03F_543D
    dw Data_03F_543D
    dw Data_03F_543D
    dw Data_03F_543D
    dw Data_03F_543D
    dw Data_03F_543D
    dw Data_03F_543D
    dw Data_03F_543D
    dw Data_03F_543D
    dw Data_03F_543D
    dw Data_03F_543D
    dw Data_03F_543D
    dw Data_03F_543D
    dw Data_03F_543D
    dw Data_03F_543D
    dw Data_03F_543D
    dw Data_03F_543D
    dw Data_03F_543D
    dw Data_03F_543D
    dw Data_03F_543D
    dw Data_03F_543D

Data_03F_5282:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $10, $00, $10, $D8, $10, $01, $10, $80

Data_03F_528B:: ; heuristic: target of a monotone pointer table; C0
    db $D8, $08, $01, $10, $D0, $08, $00, $10, $D2, $10, $02, $10, $DA, $10, $03, $10
    db $E2, $10, $04, $10, $80

Data_03F_52A0:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $00, $00, $10, $D8, $00, $01, $10, $D2, $08, $02, $10, $DA, $08, $03, $10
    db $E2, $08, $04, $10, $D4, $10, $05, $10, $DC, $10, $06, $10, $E4, $10, $07, $10
    db $EC, $10, $08, $10, $80

Data_03F_52C5:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $F8, $00, $10, $D8, $F8, $01, $10, $D2, $00, $02, $10, $DA, $00, $03, $10
    db $E2, $00, $04, $10, $D4, $08, $05, $10, $DC, $08, $06, $10, $E4, $08, $07, $10
    db $EC, $08, $08, $10, $D6, $10, $09, $10, $DE, $10, $0A, $10, $E6, $10, $0B, $10
    db $EE, $10, $0C, $10, $80

Data_03F_52FA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FD2FA, $41

Data_03F_533B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FD33B, $49

Data_03F_5384:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FD384, $41

Data_03F_53C5:: ; heuristic: target of a monotone pointer table; C0
    db $D4, $E8, $05, $10, $DC, $E8, $06, $10, $E4, $E8, $07, $10, $EC, $E8, $08, $10
    db $D6, $F0, $09, $10, $DE, $F0, $0A, $10, $E6, $F0, $0B, $10, $EE, $F0, $0C, $10
    db $E0, $F8, $0D, $10, $E8, $F8, $0E, $10, $F0, $F8, $0F, $10, $EA, $00, $10, $10
    db $F2, $00, $11, $10, $80

Data_03F_53FA:: ; heuristic: target of a monotone pointer table; C0
    db $D6, $E8, $09, $10, $DE, $E8, $0A, $10, $E6, $E8, $0B, $10, $EE, $E8, $0C, $10
    db $E0, $F0, $0D, $10, $E8, $F0, $0E, $10, $F0, $F0, $0F, $10, $EA, $F8, $10, $10
    db $F2, $F8, $11, $10, $80

Data_03F_541F:: ; heuristic: target of a monotone pointer table; C0
    db $E0, $E8, $0D, $10, $E8, $E8, $0E, $10, $F0, $E8, $0F, $10, $EA, $F0, $10, $10
    db $F2, $F0, $11, $10, $80

Data_03F_5434:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $E8, $10, $10, $F2, $E8, $11, $10, $80

Data_03F_543D:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03F_543E:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03F_547E
    dw Data_03F_54AF
    dw Data_03F_54F0
    dw Data_03F_5521
    dw Data_03F_5562
    dw Data_03F_5583
    dw Data_03F_55A4
    dw Data_03F_55B5
    dw Data_03F_55C6
    dw Data_03F_55C6
    dw Data_03F_55C6
    dw Data_03F_55C6
    dw Data_03F_55C6
    dw Data_03F_55C6
    dw Data_03F_55C6
    dw Data_03F_55C6
    dw Data_03F_55C6
    dw Data_03F_55C6
    dw Data_03F_55C6
    dw Data_03F_55C6
    dw Data_03F_55C6
    dw Data_03F_55C6
    dw Data_03F_55C6
    dw Data_03F_55C6
    dw Data_03F_55C6
    dw Data_03F_55C6
    dw Data_03F_55C6
    dw Data_03F_55C6
    dw Data_03F_55C6
    dw Data_03F_55C6
    dw Data_03F_55C6
    dw Data_03F_55C6

Data_03F_547E:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $F0, $00, $10, $E8, $F8, $01, $10, $E8, $00, $00, $10, $E8, $08, $01, $10
    db $F0, $F0, $02, $10, $F0, $F8, $03, $10, $F0, $00, $02, $10, $F0, $08, $03, $10
    db $F8, $F0, $04, $10, $F8, $F8, $05, $10, $F8, $00, $04, $10, $F8, $08, $05, $10
    db $80

Data_03F_54AF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FD4AF, $41

Data_03F_54F0:: ; heuristic: target of a monotone pointer table; C0
    db $D8, $F0, $00, $10, $D8, $F8, $01, $10, $D8, $00, $00, $10, $D8, $08, $01, $10
    db $E0, $00, $02, $10, $E0, $08, $03, $10, $E0, $F0, $02, $10, $E0, $F8, $03, $10
    db $E8, $00, $04, $10, $E8, $08, $05, $10, $E8, $F0, $04, $10, $E8, $F8, $05, $10
    db $80

Data_03F_5521:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FD521, $41

Data_03F_5562:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $F0, $02, $10, $D0, $F8, $03, $10, $D0, $00, $02, $10, $D0, $08, $03, $10
    db $D8, $00, $04, $10, $D8, $08, $05, $10, $D8, $F0, $04, $10, $D8, $F8, $05, $10
    db $80

Data_03F_5583:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $F0, $0A, $10, $D0, $F8, $0B, $10, $D0, $00, $0A, $10, $D0, $08, $0B, $10
    db $D8, $F0, $0C, $10, $D8, $F8, $0D, $10, $D8, $00, $0C, $10, $D8, $08, $0D, $10
    db $80

Data_03F_55A4:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $F0, $04, $10, $D0, $F8, $05, $10, $D0, $00, $04, $10, $D0, $08, $05, $10
    db $80

Data_03F_55B5:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $F0, $0C, $10, $D0, $F8, $0D, $10, $D0, $00, $0C, $10, $D0, $08, $0D, $10
    db $80

Data_03F_55C6:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03F_55C7:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03F_5607
    dw Data_03F_560C
    dw Data_03F_5621
    dw Data_03F_5646
    dw Data_03F_5673
    dw Data_03F_5698
    dw Data_03F_56AD
    dw Data_03F_56B6
    dw Data_03F_56D3
    dw Data_03F_56EC
    dw Data_03F_56F9
    dw Data_03F_5702
    dw Data_03F_5702
    dw Data_03F_5702
    dw Data_03F_5702
    dw Data_03F_5702
    dw Data_03F_5702
    dw Data_03F_5702
    dw Data_03F_5702
    dw Data_03F_5702
    dw Data_03F_5702
    dw Data_03F_5702
    dw Data_03F_5702
    dw Data_03F_5702
    dw Data_03F_5702
    dw Data_03F_5702
    dw Data_03F_5702
    dw Data_03F_5702
    dw Data_03F_5702
    dw Data_03F_5702
    dw Data_03F_5702
    dw Data_03F_5702

Data_03F_5607:: ; heuristic: target of a monotone pointer table; C0
    db $E5, $F5, $00, $10, $80

Data_03F_560C:: ; heuristic: target of a monotone pointer table; C0
    db $E0, $F0, $00, $10, $E8, $F0, $02, $10, $E8, $F8, $03, $10, $E0, $F8, $05, $10
    db $DD, $05, $00, $10, $80

Data_03F_5621:: ; heuristic: target of a monotone pointer table; C0
    db $D8, $00, $00, $10, $E0, $00, $02, $10, $E0, $08, $03, $10, $D8, $08, $01, $10
    db $ED, $05, $00, $10, $E0, $F0, $01, $10, $E4, $F8, $04, $10, $E8, $F8, $01, $10
    db $E7, $F2, $04, $10, $80

Data_03F_5646:: ; heuristic: target of a monotone pointer table; C0
    db $D8, $00, $01, $10, $DC, $08, $04, $10, $E0, $08, $01, $10, $DF, $02, $04, $10
    db $E6, $F2, $05, $10, $E0, $F8, $05, $10, $E4, $F4, $04, $10, $E8, $00, $00, $10
    db $F0, $00, $02, $10, $F0, $08, $03, $10, $E8, $08, $01, $10, $80

Data_03F_5673:: ; heuristic: target of a monotone pointer table; C0
    db $E0, $F0, $01, $10, $D8, $08, $01, $10, $DE, $02, $01, $10, $DC, $04, $04, $10
    db $E8, $00, $01, $10, $F0, $08, $01, $10, $EF, $02, $04, $10, $EC, $08, $04, $10
    db $E6, $F7, $01, $50, $80

Data_03F_5698:: ; heuristic: target of a monotone pointer table; C0
    db $D8, $00, $01, $10, $E8, $08, $01, $10, $EE, $02, $01, $10, $EC, $04, $04, $10
    db $DE, $07, $05, $50, $80

Data_03F_56AD:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $00, $01, $10, $EE, $07, $01, $50, $80

Data_03F_56B6:: ; heuristic: target of a monotone pointer table; C0
    db $E6, $F2, $01, $10, $E0, $F8, $01, $10, $E4, $F4, $04, $10, $E8, $00, $00, $10
    db $E8, $08, $01, $10, $F0, $00, $02, $10, $F0, $08, $03, $10, $80

Data_03F_56D3:: ; heuristic: target of a monotone pointer table; C0
    db $E0, $F0, $01, $10, $E8, $00, $01, $10, $F0, $08, $01, $10, $E6, $F7, $01, $50
    db $EC, $08, $04, $10, $EF, $02, $04, $10, $80

Data_03F_56EC:: ; heuristic: target of a monotone pointer table; C0
    db $EE, $02, $01, $10, $E8, $08, $01, $10, $EC, $04, $04, $10, $80

Data_03F_56F9:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $00, $01, $10, $EE, $07, $01, $50, $80

Data_03F_5702:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03F_5703:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03F_5743
    dw Data_03F_574C
    dw Data_03F_575D
    dw Data_03F_5776
    dw Data_03F_5793
    dw Data_03F_57B4
    dw Data_03F_57D5
    dw Data_03F_57EE
    dw Data_03F_57FB
    dw Data_03F_5808
    dw Data_03F_580D
    dw Data_03F_580D
    dw Data_03F_580D
    dw Data_03F_580D
    dw Data_03F_580D
    dw Data_03F_580D
    dw Data_03F_580D
    dw Data_03F_580D
    dw Data_03F_580D
    dw Data_03F_580D
    dw Data_03F_580D
    dw Data_03F_580D
    dw Data_03F_580D
    dw Data_03F_580D
    dw Data_03F_580D
    dw Data_03F_580D
    dw Data_03F_580D
    dw Data_03F_580D
    dw Data_03F_580D
    dw Data_03F_580D
    dw Data_03F_580D
    dw Data_03F_580D

Data_03F_5743:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $02, $01, $00, $E0, $F8, $02, $00, $80

Data_03F_574C:: ; heuristic: target of a monotone pointer table; C0
    db $E0, $0B, $01, $00, $EB, $EE, $01, $00, $EA, $02, $02, $00, $E0, $F8, $03, $00
    db $80

Data_03F_575D:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $10, $01, $00, $DB, $EF, $01, $00, $E0, $0B, $02, $00, $EB, $EC, $02, $00
    db $EA, $02, $03, $00, $E0, $F8, $04, $00, $80

Data_03F_5776:: ; heuristic: target of a monotone pointer table; C0
    db $DA, $FE, $01, $00, $DD, $F8, $00, $00, $DB, $EF, $02, $00, $F0, $10, $02, $00
    db $E0, $0B, $03, $00, $EB, $EC, $03, $00, $EA, $02, $04, $00, $80

Data_03F_5793:: ; heuristic: target of a monotone pointer table; C0
    db $D6, $FA, $00, $00, $E7, $01, $00, $00, $E2, $E8, $01, $00, $EB, $FF, $01, $00
    db $E0, $0B, $04, $00, $EB, $EC, $04, $00, $F0, $10, $03, $00, $DB, $EF, $03, $00
    db $80

Data_03F_57B4:: ; heuristic: target of a monotone pointer table; C0
    db $E2, $00, $00, $00, $DD, $0C, $00, $00, $E8, $EA, $00, $00, $E2, $13, $01, $00
    db $EF, $E7, $01, $00, $E2, $E6, $02, $00, $F0, $10, $04, $00, $DB, $EF, $04, $00
    db $80

Data_03F_57D5:: ; heuristic: target of a monotone pointer table; C0
    db $D9, $EE, $00, $00, $E5, $E7, $00, $00, $EC, $0F, $00, $00, $ED, $0C, $01, $00
    db $D8, $E9, $01, $00, $E2, $E7, $03, $00, $80

Data_03F_57EE:: ; heuristic: target of a monotone pointer table; C0
    db $D4, $EC, $00, $00, $E9, $13, $01, $00, $E1, $E8, $04, $00, $80

Data_03F_57FB:: ; heuristic: target of a monotone pointer table; C0
    db $D8, $EF, $00, $00, $DE, $E8, $01, $00, $E0, $F7, $01, $00, $80

Data_03F_5808:: ; heuristic: target of a monotone pointer table; C0
    db $D8, $EA, $01, $00, $80

Data_03F_580D:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03F_580E:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03F_584E
    dw Data_03F_5853
    dw Data_03F_5858
    dw Data_03F_585D
    dw Data_03F_5862
    dw Data_03F_5867
    dw Data_03F_5878
    dw Data_03F_58A1
    dw Data_03F_58BA
    dw Data_03F_58EF
    dw Data_03F_58EF
    dw Data_03F_58EF
    dw Data_03F_58EF
    dw Data_03F_58EF
    dw Data_03F_58EF
    dw Data_03F_58EF
    dw Data_03F_58EF
    dw Data_03F_58EF
    dw Data_03F_58EF
    dw Data_03F_58EF
    dw Data_03F_58EF
    dw Data_03F_58EF
    dw Data_03F_58EF
    dw Data_03F_58EF
    dw Data_03F_58EF
    dw Data_03F_58EF
    dw Data_03F_58EF
    dw Data_03F_58EF
    dw Data_03F_58EF
    dw Data_03F_58EF
    dw Data_03F_58EF
    dw Data_03F_58EF

Data_03F_584E:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $FC, $00, $00, $80

Data_03F_5853:: ; heuristic: target of a monotone pointer table; C0
    db $E7, $FD, $00, $00, $80

Data_03F_5858:: ; heuristic: target of a monotone pointer table; C0
    db $E4, $FA, $00, $00, $80

Data_03F_585D:: ; heuristic: target of a monotone pointer table; C0
    db $E1, $FF, $01, $00, $80

Data_03F_5862:: ; heuristic: target of a monotone pointer table; C0
    db $DD, $F6, $01, $00, $80

Data_03F_5867:: ; heuristic: target of a monotone pointer table; C0
    db $D8, $F8, $02, $00, $D8, $00, $03, $00, $E0, $F8, $04, $00, $E0, $00, $05, $00
    db $80

Data_03F_5878:: ; heuristic: target of a monotone pointer table; C0
    db $D9, $F6, $06, $00, $D9, $02, $06, $20, $E1, $F6, $07, $00, $E1, $FE, $08, $00
    db $D6, $F8, $02, $00, $D6, $00, $03, $00, $DE, $F8, $04, $00, $DE, $00, $05, $00
    db $E1, $02, $07, $20, $E1, $FA, $08, $20, $80

Data_03F_58A1:: ; heuristic: target of a monotone pointer table; C0
    db $D8, $F4, $06, $00, $D8, $04, $06, $20, $E0, $F4, $07, $00, $E0, $FC, $08, $00
    db $E0, $04, $07, $20, $E0, $FC, $08, $20, $80

Data_03F_58BA:: ; heuristic: target of a monotone pointer table; C0
    db $D2, $FC, $00, $00, $D8, $E8, $06, $00, $D8, $F2, $06, $00, $E0, $E8, $07, $00
    db $E0, $F0, $08, $00, $E0, $F2, $07, $00, $E0, $FA, $08, $00, $E0, $10, $07, $20
    db $E0, $08, $08, $20, $D8, $10, $06, $20, $E0, $FE, $08, $20, $D8, $06, $06, $20
    db $E0, $06, $07, $20, $80

Data_03F_58EF:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03F_58F0:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03F_5930
    dw Data_03F_59B9
    dw Data_03F_5A3E
    dw Data_03F_5AB3
    dw Data_03F_5B24
    dw Data_03F_5B8D
    dw Data_03F_5C02
    dw Data_03F_5C02
    dw Data_03F_5C02
    dw Data_03F_5C02
    dw Data_03F_5C02
    dw Data_03F_5C02
    dw Data_03F_5C02
    dw Data_03F_5C02
    dw Data_03F_5C02
    dw Data_03F_5C02
    dw Data_03F_5C02
    dw Data_03F_5C02
    dw Data_03F_5C02
    dw Data_03F_5C02
    dw Data_03F_5C02
    dw Data_03F_5C02
    dw Data_03F_5C02
    dw Data_03F_5C02
    dw Data_03F_5C02
    dw Data_03F_5C02
    dw Data_03F_5C02
    dw Data_03F_5C02
    dw Data_03F_5C02
    dw Data_03F_5C02
    dw Data_03F_5C02
    dw Data_03F_5C02

Data_03F_5930:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FD930, $89

Data_03F_59B9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FD9B9, $85

Data_03F_5A3E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FDA3E, $75

Data_03F_5AB3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FDAB3, $71

Data_03F_5B24:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FDB24, $69

Data_03F_5B8D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FDB8D, $75

Data_03F_5C02:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03F_5C03:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03F_5C43
    dw Data_03F_5C54
    dw Data_03F_5C79
    dw Data_03F_5CAA
    dw Data_03F_5D13
    dw Data_03F_5D98
    dw Data_03F_5DFD
    dw Data_03F_5E5E
    dw Data_03F_5E6F
    dw Data_03F_5E6F
    dw Data_03F_5E6F
    dw Data_03F_5E6F
    dw Data_03F_5E6F
    dw Data_03F_5E6F
    dw Data_03F_5E6F
    dw Data_03F_5E6F
    dw Data_03F_5E6F
    dw Data_03F_5E6F
    dw Data_03F_5E6F
    dw Data_03F_5E6F
    dw Data_03F_5E6F
    dw Data_03F_5E6F
    dw Data_03F_5E6F
    dw Data_03F_5E6F
    dw Data_03F_5E6F
    dw Data_03F_5E6F
    dw Data_03F_5E6F
    dw Data_03F_5E6F
    dw Data_03F_5E6F
    dw Data_03F_5E6F
    dw Data_03F_5E6F
    dw Data_03F_5E6F

Data_03F_5C43:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $F8, $00, $10, $E8, $00, $01, $10, $F0, $F8, $02, $10, $F0, $00, $03, $10
    db $80

Data_03F_5C54:: ; heuristic: target of a monotone pointer table; C0
    db $E2, $F3, $00, $10, $E2, $FB, $04, $10, $E2, $03, $01, $10, $EA, $F3, $06, $10
    db $EA, $FB, $07, $10, $EA, $03, $14, $10, $F2, $F3, $0A, $10, $F2, $FB, $0B, $10
    db $F2, $03, $0C, $10, $80

Data_03F_5C79:: ; heuristic: target of a monotone pointer table; C0
    db $E2, $F0, $0D, $10, $E2, $F8, $0E, $10, $E2, $00, $0F, $10, $E2, $08, $10, $10
    db $EA, $F0, $11, $10, $EA, $F8, $12, $10, $EA, $00, $13, $10, $EA, $08, $14, $10
    db $F2, $F0, $15, $10, $F2, $F8, $16, $10, $F2, $00, $17, $10, $F2, $08, $18, $10
    db $80

Data_03F_5CAA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FDCAA, $69

Data_03F_5D13:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FDD13, $85

Data_03F_5D98:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FDD98, $65

Data_03F_5DFD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FDDFD, $61

Data_03F_5E5E:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $FB, $00, $10, $EB, $03, $01, $10, $F3, $03, $00, $70, $F3, $FB, $0C, $30
    db $80

Data_03F_5E6F:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03F_5E70:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03F_5EB0
    dw Data_03F_5F41
    dw Data_03F_5F41
    dw Data_03F_5F41
    dw Data_03F_5F41
    dw Data_03F_5F41
    dw Data_03F_5F41
    dw Data_03F_5FD2
    dw Data_03F_6063
    dw Data_03F_6063
    dw Data_03F_6063
    dw Data_03F_6063
    dw Data_03F_6063
    dw Data_03F_6063
    dw Data_03F_6063
    dw Data_03F_6063
    dw Data_03F_6063
    dw Data_03F_6063
    dw Data_03F_6063
    dw Data_03F_6063
    dw Data_03F_6063
    dw Data_03F_6063
    dw Data_03F_6063
    dw Data_03F_6063
    dw Data_03F_6063
    dw Data_03F_6063
    dw Data_03F_6063
    dw Data_03F_6063
    dw Data_03F_6063
    dw Data_03F_6063
    dw Data_03F_6063
    dw Data_03F_6063

Data_03F_5EB0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FDEB0, $91

Data_03F_5F41:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $E8, $50, $10, $D0, $F0, $51, $10, $D0, $F8, $52, $10, $D0, $00, $53, $10
    db $D0, $08, $54, $10, $D0, $10, $55, $10, $D8
    dw Data_03F_60E8
    db $10, $D8
    dw Data_03F_61F0
    db $10, $D8
    dw Data_03F_62F8
    db $10, $D8
    dw Data_03F_6300
    db $10, $D8
    dw Data_03F_6408
    db $10, $D8
    dw Data_03F_6510
    db $10, $E0
    dw Data_03F_70E8
    db $10, $E0
    dw Data_03F_71F0
    db $10, $E0
    dw Data_03F_72F8
    db $10, $E0
    dw Data_03F_7300
    db $10, $E0
    dw Data_03F_7408
    db $10, $E0
    dw Data_03F_7510
    INCBIN "dwm2-cobi-us.gbc", $0FDF88, $4A

Data_03F_5FD2:: ; heuristic: target of a monotone pointer table; C0
    db $D8, $E8, $50, $10, $D8, $F0, $51, $10, $D8, $F8, $52, $10, $D8, $00, $53, $10
    db $D8, $08, $54, $10, $D8, $10, $55, $10, $E0
    dw Data_03F_60E8
    db $10, $E0
    dw Data_03F_61F0
    db $10, $E0
    dw Data_03F_62F8
    db $10, $E0
    dw Data_03F_6300
    db $10, $E0
    dw Data_03F_6408
    db $10, $E0
    dw Data_03F_6510
    db $10, $E8
    dw Data_03F_70E8
    db $10, $E8
    dw Data_03F_71F0
    db $10, $E8
    dw Data_03F_72F8
    db $10, $E8
    dw Data_03F_7300
    db $10, $E8
    dw Data_03F_7408
    db $10, $E8
    dw Data_03F_7510
    INCBIN "dwm2-cobi-us.gbc", $0FE019, $4A

Data_03F_6063:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03F_6064:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03F_60A4
    dw Data_03F_60AD
    dw Data_03F_60C6
    dw Data_03F_60D7
    dw Data_03F_611C
    dw Data_03F_6171
    dw Data_03F_61C2
    dw Data_03F_6237
    dw Data_03F_62C4
    dw Data_03F_6339
    dw Data_03F_63BE
    dw Data_03F_644B
    dw Data_03F_64CC
    dw Data_03F_654D
    dw Data_03F_65AA
    dw Data_03F_661F
    dw Data_03F_66AC
    dw Data_03F_671D
    dw Data_03F_67A2
    dw Data_03F_67E3
    dw Data_03F_67E3
    dw Data_03F_67E3
    dw Data_03F_67E3
    dw Data_03F_67E3
    dw Data_03F_67E3
    dw Data_03F_67E3
    dw Data_03F_67E3
    dw Data_03F_67E3
    dw Data_03F_67E3
    dw Data_03F_67E3
    dw Data_03F_67E3
    dw Data_03F_67E3

Data_03F_60A4:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $01, $2E, $00, $D8, $01, $2E, $60, $80

Data_03F_60AD:: ; heuristic: target of a monotone pointer table; C0
    db $E0, $FC, $2E, $00, $E8, $FC, $2E, $60, $F0, $F7, $2E, $00, $F8, $F7, $2E, $60
    db $D0, $01, $2E, $00, $D8, $01, $2E, $60, $80

Data_03F_60C6:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $F7, $2E, $00, $F8, $F7, $2E, $60, $E8, $FC, $2F, $60, $E0, $FC, $2F, $00
    db $80

Data_03F_60D7:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $D8, $00, $00, $D4, $EC, $02, $00, $D0, $F8, $04, $00, $E0, $D8, $02, $00
    db $D0

Data_03F_60E8:: ; heuristic: target of a monotone pointer table; C0
    db $08, $00, $00, $D4, $1C, $02, $60, $D0, $28, $04, $40, $D0, $B8, $00, $00, $D0
    db $38, $02, $00, $DC, $F4, $01, $00, $E0, $32, $00, $00, $D4, $C9, $02, $60, $D8
    db $07, $02, $00, $E0, $06, $00, $00, $DC, $C8, $01, $00, $D8, $27, $00, $00, $D0
    db $14, $03, $00, $80

Data_03F_611C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FE11C, $55

Data_03F_6171:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FE171, $51

Data_03F_61C2:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $D6, $02, $00, $F4, $E7, $02, $00, $F8, $03, $01, $00, $E8, $D5, $00, $20
    db $F0, $34, $02, $00, $F8, $23, $02, $00, $F4, $18, $01, $60, $F0, $F3, $04, $20
    db $F0, $24, $04, $00, $F0, $10, $03, $00, $F0, $04, $02, $00, $F0, $B4

Data_03F_61F0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FE1F0, $47

Data_03F_6237:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FE237, $8D

Data_03F_62C4:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $14, $11, $00, $F0, $18, $10, $00, $F0, $10, $0F, $00, $E8, $10, $0D, $00
    db $E8, $18, $0E, $00, $F0, $D8, $0C, $00, $E8, $D8, $0B, $00, $E8, $BC, $11, $00
    db $E0, $C0, $10, $00, $E0, $B8, $0F, $00, $D8, $B8, $0D, $00, $D8, $C0, $0E, $00
    db $E8, $3C, $0C, $00

Data_03F_62F8:: ; heuristic: target of a monotone pointer table; C0
    db $E0, $3C, $0B, $00, $D0, $10, $2B, $00

Data_03F_6300:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $18, $2C, $00, $D0, $20, $2D, $00, $D8, $D0, $1A, $00, $D8, $D8, $1B, $00
    db $D0, $D0, $17, $00, $D0, $D8, $18, $00, $D0, $E0, $19, $00, $E0, $E0, $01, $00
    db $E0, $10, $03, $00, $E8, $F0, $04, $00, $D0, $3C, $02, $00, $F0, $B0, $00, $00
    db $F0, $28, $01, $00, $D0, $00, $02, $00, $80

Data_03F_6339:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FE339, $85

Data_03F_63BE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FE3BE, $4A

Data_03F_6408:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FE408, $43

Data_03F_644B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FE44B, $81

Data_03F_64CC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FE4CC, $44

Data_03F_6510:: ; heuristic: target of a monotone pointer table; C0
    db $E0, $08, $26, $00, $E0, $10, $27, $00, $D0, $E8, $0C, $00, $D8, $24, $11, $00
    db $D0, $28, $10, $00, $D0, $20, $0F, $00, $F0, $F0, $03, $00, $F8, $28, $02, $00
    db $F0, $38, $00, $00, $E0, $B8, $04, $00, $D0, $B8, $00, $00, $D8, $D0, $02, $00
    db $E8, $E0, $03, $00, $D0, $08, $01, $00, $E0, $30, $00, $00, $80

Data_03F_654D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FE54D, $5D

Data_03F_65AA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FE5AA, $75

Data_03F_661F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FE61F, $8D

Data_03F_66AC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FE6AC, $71

Data_03F_671D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FE71D, $85

Data_03F_67A2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FE7A2, $41

Data_03F_67E3:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03F_67E4:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03F_6824
    dw Data_03F_6835
    dw Data_03F_6856
    dw Data_03F_6883
    dw Data_03F_68B4
    dw Data_03F_68E5
    dw Data_03F_6916
    dw Data_03F_693B
    dw Data_03F_6948
    dw Data_03F_6948
    dw Data_03F_6948
    dw Data_03F_6948
    dw Data_03F_6948
    dw Data_03F_6948
    dw Data_03F_6948
    dw Data_03F_6948
    dw Data_03F_6948
    dw Data_03F_6948
    dw Data_03F_6948
    dw Data_03F_6948
    dw Data_03F_6948
    dw Data_03F_6948
    dw Data_03F_6948
    dw Data_03F_6948
    dw Data_03F_6948
    dw Data_03F_6948
    dw Data_03F_6948
    dw Data_03F_6948
    dw Data_03F_6948
    dw Data_03F_6948
    dw Data_03F_6948
    dw Data_03F_6948

Data_03F_6824:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $F2, $17, $00, $D0, $FA, $18, $00, $D0, $02, $19, $00, $D0, $0A, $1A, $00
    db $80

Data_03F_6835:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $F2, $13, $00, $D0, $FA, $14, $00, $D0, $02, $15, $00, $D8, $F2, $17, $00
    db $D8, $FA, $18, $00, $D8, $02, $19, $00, $D0, $0A, $16, $00, $D8, $0A, $1A, $00
    db $80

Data_03F_6856:: ; heuristic: target of a monotone pointer table; C0
    db $D8, $F2, $10, $00, $D8, $FA, $11, $00, $D8, $02, $12, $00, $E0, $F2, $13, $00
    db $E0, $FA, $14, $00, $E0, $02, $15, $00, $E0, $0A, $16, $00, $E8, $F2, $17, $00
    db $E8, $FA, $18, $00, $E8, $02, $19, $00, $E8, $0A, $1A, $00, $80

Data_03F_6883:: ; heuristic: target of a monotone pointer table; C0
    db $E9, $F8, $06, $00, $E9, $00, $07, $00, $E8, $F2, $0D, $20, $E0, $EA, $00, $20
    db $E1, $F8, $04, $00, $E1, $00, $05, $00, $E0, $F2, $0C, $20, $DD, $FA, $03, $00
    db $DC, $02, $02, $00, $E4, $06, $0C, $00, $EC, $06, $0D, $00, $DB, $0A, $01, $00
    db $80

Data_03F_68B4:: ; heuristic: target of a monotone pointer table; C0
    db $D8, $F2, $03, $00, $EB, $EB, $0E, $40, $EB, $F3, $0F, $40, $DE, $E8, $00, $20
    db $D4, $06, $02, $00, $E4, $10, $0E, $60, $E4, $08, $0F, $60, $DA, $10, $01, $00
    db $DE, $F8, $04, $00, $DE, $00, $05, $00, $E6, $F8, $06, $00, $E6, $00, $07, $00
    db $80

Data_03F_68E5:: ; heuristic: target of a monotone pointer table; C0
    db $E2, $10, $01, $20, $F2, $10, $0C, $60, $EA, $10, $0D, $60, $DC, $0A, $02, $40
    db $E0, $ED, $03, $40, $E6, $E8, $01, $00, $F8, $EB, $0C, $40, $F0, $EB, $0D, $40
    db $E6, $FA, $08, $00, $E6, $02, $09, $00, $EE, $FA, $0A, $00, $EE, $02, $0B, $00
    db $80

Data_03F_6916:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $EB, $0D, $60, $F8, $10, $0C, $40, $F0, $10, $0D, $40, $EC, $E8, $02, $00
    db $E2, $10, $00, $20, $EE, $FC, $04, $00, $EE, $04, $05, $00, $F6, $FC, $06, $00
    db $F6, $04, $07, $00, $80

Data_03F_693B:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $10, $0D, $60, $F8, $FD, $04, $00, $F8, $05, $05, $00, $80

Data_03F_6948:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03F_6949:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03F_6989
    dw Data_03F_698E
    dw Data_03F_699B
    dw Data_03F_69B4
    dw Data_03F_69D5
    dw Data_03F_69FE
    dw Data_03F_6A27
    dw Data_03F_6A50
    dw Data_03F_6A7D
    dw Data_03F_6AA6
    dw Data_03F_6ACF
    dw Data_03F_6B10
    dw Data_03F_6B75
    dw Data_03F_6BF2
    dw Data_03F_6C63
    dw Data_03F_6CBC
    dw Data_03F_6D19
    dw Data_03F_6D4E
    dw Data_03F_6D67
    dw Data_03F_6D7C
    dw Data_03F_6DB5
    dw Data_03F_6DB5
    dw Data_03F_6DB5
    dw Data_03F_6DB5
    dw Data_03F_6DB5
    dw Data_03F_6DB5
    dw Data_03F_6DB5
    dw Data_03F_6DB5
    dw Data_03F_6DB5
    dw Data_03F_6DB5
    dw Data_03F_6DB5
    dw Data_03F_6DB5

Data_03F_6989:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $B0, $22, $10, $80

Data_03F_698E:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $B0, $20, $10, $F8, $B8, $21, $10, $F8, $C0, $22, $10, $80

Data_03F_699B:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $C3, $20, $10, $F8, $CB, $21, $10, $F8, $D3, $22, $10, $F8, $B3, $10, $10
    db $F8, $BB, $11, $10, $F8, $AB, $11, $10, $80

Data_03F_69B4:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $D8, $20, $10, $F8, $E0, $21, $10, $F8, $E8, $22, $10, $F8, $C8, $11, $10
    db $F8, $D0, $11, $10, $F8, $C0, $12, $10, $F8, $B0, $02, $10, $F8, $B8, $02, $10
    db $80

Data_03F_69D5:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $B7, $00, $10, $F8, $BF, $01, $10, $F8, $C7, $02, $10, $F8, $CF, $02, $10
    db $F8, $DF, $10, $10, $F8, $E7, $11, $10, $F8, $D7, $11, $10, $F8, $EF, $20, $10
    db $F8, $F7, $21, $10, $F8, $FF, $22, $10, $80

Data_03F_69FE:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $D0, $00, $10, $F8, $D8, $01, $10, $F8, $E0, $02, $10, $F8, $E8, $02, $10
    db $F8, $F0, $11, $10, $F8, $F8, $12, $10, $F8, $00, $11, $10, $F8, $08, $20, $10
    db $F8, $10, $21, $10, $F8, $18, $22, $10, $80

Data_03F_6A27:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $EB, $00, $10, $F8, $F3, $01, $10, $F8, $FB, $02, $10, $F8, $03, $02, $10
    db $F8, $0B, $10, $10, $F8, $13, $11, $10, $F8, $1B, $11, $10, $F8, $23, $20, $10
    db $F8, $2B, $21, $10, $F8, $33, $22, $10, $80

Data_03F_6A50:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $08, $00, $10, $F8, $10, $01, $10, $F8, $18, $02, $10, $F8, $20, $02, $10
    db $F8, $30, $11, $10, $F8, $38, $11, $10, $F8, $28, $12, $10, $F8, $40, $20, $10
    db $F8, $48, $21, $10, $F0, $D0, $17, $10, $F6, $D8, $0D, $10, $80

Data_03F_6A7D:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $19, $00, $10, $F8, $21, $01, $10, $F8, $29, $02, $10, $F8, $31, $02, $10
    db $F8, $39, $12, $10, $F8, $41, $11, $10, $F8, $49, $11, $10, $F8, $C8, $13, $10
    db $F5, $CB, $27, $10, $ED, $C8, $0D, $10, $80

Data_03F_6AA6:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $2C, $00, $10, $F8, $34, $01, $10, $F8, $3C, $02, $10, $F8, $44, $02, $10
    db $F8, $4C, $12, $10, $EF, $D0, $13, $10, $F7, $D0, $23, $10, $F3, $DB, $24, $10
    db $ED, $D3, $27, $10, $E5, $D0, $0D, $10, $80

Data_03F_6ACF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FEACF, $41

Data_03F_6B10:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FEB10, $65

Data_03F_6B75:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FEB75, $7D

Data_03F_6BF2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FEBF2, $71

Data_03F_6C63:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FEC63, $59

Data_03F_6CBC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FECBC, $5D

Data_03F_6D19:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $0C, $22, $10, $F0, $F7, $13, $10, $F8, $04, $04, $30, $F8, $FC, $07, $30
    db $F8, $D0, $17, $10, $E8, $F5, $14, $10, $F0, $04, $14, $10, $F8, $14, $14, $10
    db $F8, $EC, $2B, $10, $F8, $F4, $2C, $10, $E8, $0A, $1A, $10, $F0, $0A, $2A, $10
    db $F0, $FC, $1D, $30, $80

Data_03F_6D4E:: ; heuristic: target of a monotone pointer table; C0
    db $EF, $00, $13, $10, $F7, $00, $23, $10, $F3, $0B, $24, $10, $F0, $E5, $27, $10
    db $ED, $03, $27, $10, $E5, $00, $0D, $10, $80

Data_03F_6D67:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $F8, $17, $10, $F8, $F7, $27, $10, $F8, $F0, $0D, $10, $E8, $08, $0D, $30
    db $F8, $08, $14, $10, $80

Data_03F_6D7C:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $C6, $03, $10, $F8, $DE, $08, $50, $F0, $D6, $15, $10, $F8, $D6, $26, $10
    db $F8, $E6, $26, $10, $F8, $CE, $25, $10, $F8, $06, $17, $10, $F0, $EE, $0D, $30
    db $F8, $EE, $0E, $30, $F0, $E6, $0B, $10, $E8, $E8, $14, $10, $F8, $F6, $14, $10
    db $E8, $E0, $1D, $10, $F0, $DE, $1F, $70, $80

Data_03F_6DB5:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03F_6DB6:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03F_6DF6
    dw Data_03F_6E07
    dw Data_03F_6E30
    dw Data_03F_6E5D
    dw Data_03F_6E76
    dw Data_03F_6E8B
    dw Data_03F_6E98
    dw Data_03F_6E98
    dw Data_03F_6E98
    dw Data_03F_6E98
    dw Data_03F_6E98
    dw Data_03F_6E98
    dw Data_03F_6E98
    dw Data_03F_6E98
    dw Data_03F_6E98
    dw Data_03F_6E98
    dw Data_03F_6E98
    dw Data_03F_6E98
    dw Data_03F_6E98
    dw Data_03F_6E98
    dw Data_03F_6E98
    dw Data_03F_6E98
    dw Data_03F_6E98
    dw Data_03F_6E98
    dw Data_03F_6E98
    dw Data_03F_6E98
    dw Data_03F_6E98
    dw Data_03F_6E98
    dw Data_03F_6E98
    dw Data_03F_6E98
    dw Data_03F_6E98
    dw Data_03F_6E98

Data_03F_6DF6:: ; heuristic: target of a monotone pointer table; C0
    db $D8, $03, $00, $00, $D8, $0B, $01, $00, $D0, $03, $02, $00, $D0, $0B, $03, $00
    db $80

Data_03F_6E07:: ; heuristic: target of a monotone pointer table; C0
    db $DC, $00, $00, $00, $DC, $08, $01, $00, $D4, $00, $02, $00, $D4, $08, $03, $00
    db $CC, $04, $04, $00, $E4, $F8, $00, $60, $E4, $F0, $01, $60, $EC, $F8, $02, $60
    db $EC, $F0, $03, $60, $F4, $F4, $04, $60, $80

Data_03F_6E30:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $FB, $05, $60, $F0, $F3, $06, $60, $E8, $03, $07, $60, $E8, $FB, $08, $60
    db $E8, $F3, $09, $60, $E0, $03, $0A, $60, $E0, $FB, $0B, $60, $E0, $F3, $0C, $60
    db $D8, $07, $0D, $60, $D8, $FF, $0E, $60, $D0, $08, $0F, $60, $80

Data_03F_6E5D:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $F3, $11, $00, $E8, $F8, $11, $00, $E0, $FE, $11, $00, $D8, $03, $11, $00
    db $D0, $08, $11, $00, $F8, $EE, $11, $00, $80

Data_03F_6E76:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $F3, $11, $00, $E8, $F8, $11, $00, $F8, $EE, $11, $00, $E0, $FE, $12, $00
    db $D8, $03, $12, $00, $80

Data_03F_6E8B:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $EE, $12, $00, $F0, $F3, $12, $00, $E8, $F8, $12, $00, $80

Data_03F_6E98:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03F_6E99:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03F_6ED9
    dw Data_03F_6EEA
    dw Data_03F_6F13
    dw Data_03F_6F3C
    dw Data_03F_6F6D
    dw Data_03F_6F8E
    dw Data_03F_6FA7
    dw Data_03F_6FB4
    dw Data_03F_6FC1
    dw Data_03F_6FE2
    dw Data_03F_7007
    dw Data_03F_7054
    dw Data_03F_70A1
    dw Data_03F_7102
    dw Data_03F_7163
    dw Data_03F_71B0
    dw Data_03F_720D
    dw Data_03F_7276
    dw Data_03F_72E7
    dw Data_03F_7328
    dw Data_03F_7349
    dw Data_03F_7349
    dw Data_03F_7349
    dw Data_03F_7349
    dw Data_03F_7349
    dw Data_03F_7349
    dw Data_03F_7349
    dw Data_03F_7349
    dw Data_03F_7349
    dw Data_03F_7349
    dw Data_03F_7349
    dw Data_03F_7349

Data_03F_6ED9:: ; heuristic: target of a monotone pointer table; C0
    db $D8, $03, $1C, $00, $D8, $0B, $1D, $00, $D0, $03, $1E, $00, $D0, $0B, $1F, $00
    db $80

Data_03F_6EEA:: ; heuristic: target of a monotone pointer table; C0
    db $DC, $00, $1C, $00, $DC, $08, $1D, $00, $CF, $01, $26, $00, $D4, $00, $1E, $00
    db $D4, $08, $1F, $00, $E4, $F8, $1C, $60, $E4, $F0, $1D, $60, $F1, $F7, $26, $60
    db $EC, $F8, $1E, $60, $EC, $F0, $1F, $60, $80

Data_03F_6F13:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $00, $20, $00, $D0, $08, $21, $00, $D8, $FC, $22, $00, $D8, $04, $23, $00
    db $E0, $F8, $24, $00, $E0, $00, $25, $00, $E8, $F0, $26, $00, $E8, $F8, $27, $00
    db $F0, $F4, $28, $00, $F8, $F0, $29, $00, $80

Data_03F_6F3C:: ; heuristic: target of a monotone pointer table; C0
    db $D8, $03, $21, $00, $E0, $F7, $22, $00, $E0, $FF, $23, $00, $E8, $FB, $25, $00
    db $F0, $EB, $26, $00, $F0, $F3, $27, $00, $F8, $EF, $28, $00, $D0, $08, $2A, $00
    db $D8, $FB, $2A, $00, $E8, $F3, $2A, $00, $E0, $EB, $2B, $00, $D0, $00, $2B, $00
    db $80

Data_03F_6F6D:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $08, $2C, $00, $D8, $03, $2C, $00, $E0, $FE, $2C, $00, $E8, $F8, $2C, $00
    db $F0, $F3, $2C, $00, $F8, $EE, $2C, $00, $F0, $EB, $2A, $00, $E0, $F6, $2B, $00
    db $80

Data_03F_6F8E:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $F8, $2C, $00, $F0, $F3, $2C, $00, $F8, $EE, $2C, $00, $D8, $03, $2D, $00
    db $E0, $FE, $2D, $00, $E8, $F0, $20, $00, $80

Data_03F_6FA7:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $FA, $2D, $00, $F0, $F5, $2D, $00, $F8, $F0, $2D, $00, $80

Data_03F_6FB4:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $FC, $27, $00, $F8, $FC, $28, $00, $E8, $FC, $24, $20, $80

Data_03F_6FC1:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $FC, $02, $00, $F0, $FC, $27, $20, $F8, $FC, $27, $00, $E0, $FC, $21, $20
    db $F8, $F4, $21, $00, $F0, $F0, $20, $00, $F8, $04, $21, $20, $F0, $08, $20, $20
    db $80

Data_03F_6FE2:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $F6, $02, $00, $E8, $F9, $00, $00, $F8, $F0, $05, $00, $F8, $08, $05, $20
    db $F0, $03, $02, $20, $F0, $FE, $03, $00, $E8, $FF, $04, $00, $F8, $F8, $18, $00
    db $F8, $00, $18, $20, $80

Data_03F_7007:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FF007, $4D

Data_03F_7054:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FF054, $4D

Data_03F_70A1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FF0A1, $47

Data_03F_70E8:: ; heuristic: target of a monotone pointer table; C0
    db $00, $D0, $00, $01, $00, $E0, $EF, $05, $00, $F0, $F5, $18, $00, $F8, $0C, $1A
    db $00, $F8, $EC, $13, $00, $D8, $05, $0D, $00, $80

Data_03F_7102:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FF102, $61

Data_03F_7163:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FF163, $4D

Data_03F_71B0:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $05, $11, $00, $F8, $F5, $0F, $00, $F8, $ED, $17, $20, $F8, $0D, $13, $20
    db $F8, $FD, $19, $00, $F0, $F8, $0B, $20, $F0, $F0, $0C, $20, $F0, $E8, $0D, $20
    db $F0, $08, $0A, $20, $F0, $00, $19, $00, $E8, $F0, $07, $20, $E8, $E8, $08, $20
    db $E0, $F2, $03, $20, $E0, $EA, $04, $20, $D8, $EF, $01, $20, $E8, $08, $06, $20

Data_03F_71F0:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $00, $09, $00, $E8, $F8, $09, $20, $E8, $10, $0D, $00, $E0, $04, $08, $20
    db $E0, $0C, $05, $20, $D8, $06, $04, $00, $F0, $10, $1A, $00, $80

Data_03F_720D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FF20D, $69

Data_03F_7276:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FF276, $71

Data_03F_72E7:: ; heuristic: target of a monotone pointer table; C0
    db $E4, $03, $06, $20, $E4, $F3, $08, $20, $DC, $05, $02, $20, $DC, $F5, $04, $20
    db $D4

Data_03F_72F8:: ; heuristic: target of a monotone pointer table; C0
    db $FC, $04, $20, $D4, $FF, $02, $20, $DC

Data_03F_7300:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $07, $20, $E4, $FB, $0B, $20, $E4, $09, $09, $20, $EC, $F8, $0F, $40, $EC
    db $F0, $12, $20, $EC, $08, $17, $00, $EC, $00, $18, $20, $F4, $FB, $19, $00, $F4
    db $03, $1A, $00, $F4, $F3, $1A, $20, $80

Data_03F_7328:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $FC, $1B, $00, $E0, $FC, $24, $00, $E8, $FC, $03, $00, $F0, $04, $12, $00
    db $F0, $FC, $0C, $20, $F0, $F4, $0D, $20, $E8, $F4, $22, $00, $E8, $04, $23, $00
    db $80

Data_03F_7349:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03F_734A:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03F_738A
    dw Data_03F_739B
    dw Data_03F_73BC
    dw Data_03F_73E5
    dw Data_03F_7416
    dw Data_03F_7437
    dw Data_03F_7450
    dw Data_03F_745D
    dw Data_03F_747E
    dw Data_03F_74AF
    dw Data_03F_74EC
    dw Data_03F_7525
    dw Data_03F_7556
    dw Data_03F_75EF
    dw Data_03F_7630
    dw Data_03F_76B5
    dw Data_03F_771E
    dw Data_03F_77AF
    dw Data_03F_77AF
    dw Data_03F_77AF
    dw Data_03F_77AF
    dw Data_03F_77AF
    dw Data_03F_77AF
    dw Data_03F_77AF
    dw Data_03F_77AF
    dw Data_03F_77AF
    dw Data_03F_77AF
    dw Data_03F_77AF
    dw Data_03F_77AF
    dw Data_03F_77AF
    dw Data_03F_77AF
    dw Data_03F_77AF

Data_03F_738A:: ; heuristic: target of a monotone pointer table; C0
    db $D8, $03, $20, $00, $D8, $0B, $21, $00, $D0, $03, $22, $00, $D0, $0B, $23, $00
    db $80

Data_03F_739B:: ; heuristic: target of a monotone pointer table; C0
    db $DC, $00, $20, $00, $DC, $08, $21, $00, $D4, $00, $22, $00, $D4, $08, $23, $00
    db $E4, $F8, $20, $60, $E4, $F0, $21, $60, $EC, $F8, $22, $60, $EC, $F0, $23, $60
    db $80

Data_03F_73BC:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $00, $24, $00, $D0, $08, $25, $00, $D8, $FC, $26, $00, $D8, $04, $27, $00
    db $E0, $F8, $28, $00, $E0, $00, $29, $00, $E8, $F0, $2A, $00, $E8, $F8, $2B, $00
    db $F0, $F4, $2C, $00, $F8, $F0, $2D, $00, $80

Data_03F_73E5:: ; heuristic: target of a monotone pointer table; C0
    db $D8, $FB, $24, $00, $D8, $03, $25, $00, $E0, $F7, $26, $00, $E0, $FF, $27, $00
    db $E8, $F3, $28, $00, $E8, $FB, $29, $00, $F0, $EB, $2A, $00, $F0, $F3, $2B, $00
    db $F8, $EF, $2C

Data_03F_7408:: ; heuristic: target of a monotone pointer table; C0
    db $00, $D0, $08, $05, $00, $D0, $00, $24, $00, $E8, $EB, $12, $00, $80

Data_03F_7416:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $EE, $2E, $00, $F0, $F3, $2E, $00, $E8, $F8, $2E, $00, $E0, $FE, $2E, $00
    db $D8, $03, $2E, $00, $D0, $08, $2E, $00, $F0, $EB, $11, $20, $E0, $F6, $0B, $20
    db $80

Data_03F_7437:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $F0, $24, $00, $F0, $F3, $2E, $00, $E8, $F8, $2E, $00, $E0, $FE, $2F, $00
    db $D8, $03, $2F, $00, $F8, $EE, $2E, $00, $80

Data_03F_7450:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F0, $2F, $00, $F0, $F5, $2F, $00, $E8, $FA, $2F, $00, $80

Data_03F_745D:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $F8, $05, $00, $E8, $00, $13, $00, $E0, $00, $0C, $60, $E0, $F8, $0B, $20
    db $D8, $F3, $01, $20, $EE, $F2, $00, $60, $ED, $07, $01, $40, $DD, $04, $00, $00
    db $80

Data_03F_747E:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $F8, $03, $00, $E8, $F0, $02, $00, $E0, $00, $03, $60, $E0, $08, $02, $60
    db $E0, $F8, $0D, $00, $E8, $00, $0D, $00, $F0, $00, $05, $00, $D8, $F8, $05, $60
    db $D6, $F0, $00, $20, $D6, $08, $01, $00, $F2, $F0, $01, $60, $F2, $08, $00, $40
    db $80

Data_03F_74AF:: ; heuristic: target of a monotone pointer table; C0
    db $EC, $F0, $08, $00, $EC, $F8, $09, $00, $EC, $08, $0C, $60, $EC, $00, $0D, $60
    db $DC, $F0, $0E, $40, $DC, $F8, $0F, $40, $DC, $00, $18, $40, $DC, $08, $19, $40
    db $E4, $F8, $10, $00, $E4, $00, $11, $00, $D4, $03, $05, $60, $F4, $0B, $02, $20
    db $F4, $03, $03, $20, $D4, $F5, $19, $00, $F4, $F4, $05, $00, $80

Data_03F_74EC:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $F8, $0C, $00, $D0, $00, $0D, $00, $D7, $01, $05, $00, $F8, $F8, $08, $20
    db $F8, $F0, $18, $00, $F0, $EA, $05, $40, $D8, $0C, $01, $00, $F8, $E8, $01, $20
    db $D5, $F0, $08, $60

Data_03F_7510:: ; heuristic: target of a monotone pointer table; C0
    db $D5, $E8, $09, $60, $DD, $EA, $05, $20, $F4, $04, $02, $40, $F8, $0C, $03, $00
    db $F4, $10, $02, $60, $80

Data_03F_7525:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $00, $16, $20, $D0, $F8, $17, $20, $D8, $00, $18, $20, $D8, $F8, $19, $20
    db $E0, $FC, $18, $20, $E0, $F4, $19, $20, $E8, $F8, $05, $00, $DE, $E3, $0B, $60
    db $E8, $EC, $01, $00, $F8, $10, $18, $00, $F8, $00, $01, $00, $F8, $F8, $01, $20
    db $80

Data_03F_7556:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FF556, $99

Data_03F_75EF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FF5EF, $41

Data_03F_7630:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FF630, $85

Data_03F_76B5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FF6B5, $69

Data_03F_771E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0FF71E, $91

Data_03F_77AF:: ; heuristic: target of a monotone pointer table; C0
    db $80
    ds $850, $00
