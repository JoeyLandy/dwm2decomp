SECTION "Bank 92", ROMX[$4000], BANK[$92]
    db $92

; 1 call site from 1 routine (e.g. Func_03A_5383)
; reads: wD804, wD801, wDAB7
; points at: hSpriteOriginX
Func_092_4001::
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
    ld de, Data_092_4024
    call BuildOamFromSpriteTable_Bank92
    ret

Data_092_4024:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_40ED
    dw Data_092_493C
    dw Data_092_4CFA
    dw Data_092_56BF
    dw Data_092_5BEC
    dw Data_092_6035
    dw Data_092_6928
    dw Data_092_6F1C
    dw Data_092_78D4

; DE = two-level table; entries are chosen by hSpriteSetIndex and hSpriteSubIndex; writes 4-byte OAM entries at $C000 + 4 * hOamNextEntry (Y = hSpriteOriginY + b + $10, X = hSpriteOriginX + b + 8, tile += hSpriteTileOffset, flags ^= hSpriteAttrXor) until a $80 byte or hOamNextEntry reaches $28 (40 entries) (the same 81 bytes appear in 5 banks)
; 1 call site from 1 routine (e.g. Func_092_4001)
; reads: hOamNextEntry, hSpriteSetIndex, hSpriteSubIndex, hSpriteOriginY, hSpriteOriginX, hSpriteTileOffset, hSpriteAttrXor
; writes: hOamNextEntry
BuildOamFromSpriteTable_Bank92::
Func_092_409C:: ; address name
    ldh a, [hOamNextEntry]
    cp a, $28
    jr nc, Jump_092_40EC
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

Jump_092_40BF::
    ld a, [de]
    inc de
    cp a, $80
    jr z, Jump_092_40EC
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
    jr c, Jump_092_40BF

Jump_092_40EC::
    ret

Data_092_40ED:: ; heuristic: target of a monotone pointer table; C0
    dw Data_092_412D
    dw Data_092_4136
    dw Data_092_4147
    dw Data_092_41A0
    dw Data_092_41E9
    dw Data_092_4282
    dw Data_092_42FB
    dw Data_092_4394
    dw Data_092_440D
    dw Data_092_44A2
    dw Data_092_4513
    dw Data_092_4564
    dw Data_092_45A9
    dw Data_092_45D2
    dw Data_092_45FB
    dw Data_092_4634
    dw Data_092_4685
    dw Data_092_46E2
    dw Data_092_4757
    dw Data_092_47E8
    dw Data_092_4855
    dw Data_092_48C2
    dw Data_092_493B
    dw Data_092_493B
    dw Data_092_493B
    dw Data_092_493B
    dw Data_092_493B
    dw Data_092_493B
    dw Data_092_493B
    dw Data_092_493B
    dw Data_092_493B
    dw Data_092_493B

Data_092_412D:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $BC, $00, $10, $D0, $3C, $00, $10, $80

Data_092_4136:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $B8, $01, $10, $D0, $C0, $01, $30, $D0, $38, $01, $10, $D0, $40, $01, $30
    db $80

Data_092_4147:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $248147, $59

Data_092_41A0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2481A0, $49

Data_092_41E9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2481E9, $99

Data_092_4282:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $248282, $79

Data_092_42FB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2482FB, $99

Data_092_4394:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $248394, $79

Data_092_440D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24840D, $95

Data_092_44A2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2484A2, $71

Data_092_4513:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $248513, $51

Data_092_4564:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $248564, $45

Data_092_45A9:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $00, $05, $70, $F0, $F8, $06, $70, $E8, $00, $07, $70, $E8, $F8, $08, $70
    db $D8, $FA, $04, $70, $E0, $FD, $03, $70, $F8, $00, $09, $70, $F8, $F8, $0A, $70
    db $D0, $FB, $02, $30, $D0, $FC, $00, $30, $80

Data_092_45D2:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $FC, $05, $30, $F8, $F4, $06, $30, $F0, $F6, $04, $30, $E0, $F6, $1E, $50
    db $E0, $FE, $1F, $50, $E8, $F6, $1C, $70, $E8, $EE, $1D, $70, $D8, $FD, $1A, $70
    db $D8, $F5, $1B, $70, $D0, $FE, $04, $50, $80

Data_092_45FB:: ; heuristic: target of a monotone pointer table; C0
    db $D8, $00, $1C, $50, $D8, $08, $1D, $50, $E0, $00, $1A, $50, $E0, $08, $1B, $50
    db $E8, $00, $18, $50, $E8, $08, $19, $50, $F0, $F0, $14, $50, $F0, $F8, $15, $50
    db $F0, $00, $16, $50, $F0, $08, $17, $50, $F8, $F0, $12, $50, $F8, $F8, $13, $50
    db $D0, $00, $1E, $70, $D0, $F8, $1F, $70, $80

Data_092_4634:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $248634, $51

Data_092_4685:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $248685, $5D

Data_092_46E2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2486E2, $75

Data_092_4757:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $248757, $91

Data_092_47E8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2487E8, $6D

Data_092_4855:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $248855, $6D

Data_092_48C2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2488C2, $79

Data_092_493B:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_092_493C:: ; heuristic: target of a monotone pointer table; C0
    dw Data_092_497C
    dw Data_092_4985
    dw Data_092_499E
    dw Data_092_49B7
    dw Data_092_49D8
    dw Data_092_4A01
    dw Data_092_4A2A
    dw Data_092_4A5B
    dw Data_092_4A94
    dw Data_092_4ABD
    dw Data_092_4AEE
    dw Data_092_4B1F
    dw Data_092_4B48
    dw Data_092_4B89
    dw Data_092_4BA2
    dw Data_092_4BB7
    dw Data_092_4BD4
    dw Data_092_4C01
    dw Data_092_4C12
    dw Data_092_4C37
    dw Data_092_4CB8
    dw Data_092_4CF9
    dw Data_092_4CF9
    dw Data_092_4CF9
    dw Data_092_4CF9
    dw Data_092_4CF9
    dw Data_092_4CF9
    dw Data_092_4CF9
    dw Data_092_4CF9
    dw Data_092_4CF9
    dw Data_092_4CF9
    dw Data_092_4CF9

Data_092_497C:: ; heuristic: target of a monotone pointer table; C0
    db $F7, $F5, $05, $00, $F8, $05, $0B, $00, $80

Data_092_4985:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $05, $0A, $00, $E8, $05, $0C, $00, $EF, $F2, $04, $00, $E7, $F5, $23, $00
    db $F8, $05, $0C, $00, $F7, $F5, $23, $20, $80

Data_092_499E:: ; heuristic: target of a monotone pointer table; C0
    db $E0, $05, $0C, $00, $DF, $F1, $23, $20, $E7, $F5, $05, $00, $E8, $05, $0B, $00
    db $F0, $05, $0C, $00, $EF, $F2, $23, $20, $80

Data_092_49B7:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F0, $00, $00, $F8, $F8, $01, $00, $F8, $00, $06, $00, $F8, $08, $07, $00
    db $E0, $05, $0A, $00, $DF, $F5, $04, $20, $D8, $05, $0B, $00, $D7, $F1, $05, $00
    db $80

Data_092_49D8:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $E8, $00, $40, $F8, $F0, $01, $40, $F0, $E8, $02, $40, $F0, $F0, $03, $40
    db $F0, $10, $06, $20, $F0, $08, $07, $20, $F8, $10, $08, $20, $F8, $08, $09, $20
    db $D0, $05, $0C, $00, $D0, $F5, $05, $00, $80

Data_092_4A01:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $F0, $00, $60, $F0, $E8, $01, $60, $E8, $F0, $02, $60, $E8, $E8, $03, $60
    db $E8, $08, $06, $00, $E8, $10, $07, $00, $F0, $08, $08, $00, $F0, $10, $09, $00
    db $F8, $EE, $04, $00, $F8, $0A, $0A, $00, $80

Data_092_4A2A:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $F8, $00, $60, $E8, $F0, $01, $60, $E0, $F8, $02, $60, $E0, $F0, $03, $60
    db $E0, $00, $06, $00, $E0, $08, $07, $00, $E8, $00, $08, $00, $E8, $08, $09, $00
    db $EC, $10, $0B, $00, $F4, $0E, $0C, $00, $EC, $E8, $05, $00, $F4, $EA, $23, $20
    db $80

Data_092_4A5B:: ; heuristic: target of a monotone pointer table; C0
    db $E0, $F8, $06, $00, $E0, $00, $07, $00, $E8, $F8, $08, $00, $E8, $00, $09, $00
    db $E0, $F8, $00, $00, $E0, $00, $01, $00, $E8, $F8, $02, $00, $E8, $00, $03, $00
    db $E8, $08, $0A, $00, $EA, $0E, $0C, $00, $F0, $10, $0B, $00, $E8, $F0, $04, $00
    db $F0, $E8, $05, $00, $EA, $EA, $23, $00, $80

Data_092_4A94:: ; heuristic: target of a monotone pointer table; C0
    db $E0, $F0, $06, $00, $E0, $F8, $07, $00, $E8, $F0, $08, $00, $E8, $F8, $09, $00
    db $E8, $00, $00, $40, $E8, $08, $01, $40, $E0, $00, $02, $40, $E0, $08, $03, $40
    db $E4, $10, $0C, $00, $E4, $E8, $23, $00, $80

Data_092_4ABD:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $F0, $06, $20, $E8, $E8, $07, $20, $F0, $F0, $08, $20, $F0, $E8, $09, $20
    db $E8, $08, $00, $00, $E8, $10, $01, $00, $F0, $08, $02, $00, $F0, $10, $03, $00
    db $E0, $00, $05, $00, $E0, $F8, $0B, $00, $E2, $08, $04, $00, $E2, $F0, $0A, $00
    db $80

Data_092_4AEE:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $E8, $06, $00, $F0, $F0, $07, $00, $F8, $E8, $08, $00, $F8, $F0, $09, $00
    db $F0, $10, $00, $20, $F0, $08, $01, $20, $F8, $10, $02, $20, $F8, $08, $03, $20
    db $EA, $0C, $05, $20, $E4, $0A, $23, $20, $EA, $EC, $0B, $00, $E4, $EE, $0C, $00
    db $80

Data_092_4B1F:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $08, $02, $60, $F8, $00, $03, $60, $F8, $F8, $06, $20, $F8, $F0, $07, $20
    db $F2, $EE, $0C, $00, $EE, $EC, $0C, $00, $E8, $EC, $0C, $00, $F2, $0A, $23, $00
    db $EE, $0C, $23, $20, $E8, $0C, $23, $00, $80

Data_092_4B48:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $248B48, $41

Data_092_4B89:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $F4, $25, $00, $F0, $04, $25, $20, $F0, $FC, $26, $00, $F8, $F4, $27, $00
    db $F8, $04, $27, $20, $F8, $FC, $2F, $00, $80

Data_092_4BA2:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $F4, $0D, $00, $F0, $FC, $0E, $00, $F8, $F4, $0F, $00, $F8, $FC, $10, $00
    db $F8, $04, $17, $00, $80

Data_092_4BB7:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F3, $15, $00, $F8, $FB, $16, $00, $F8, $03, $17, $00, $E8, $F2, $11, $00
    db $E8, $FA, $12, $00, $F0, $F2, $13, $00, $F0, $FA, $14, $00, $80

Data_092_4BD4:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F3, $20, $00, $F8, $FB, $21, $00, $F8, $03, $22, $00, $F0, $F3, $1E, $00
    db $F0, $FB, $1F, $00, $E8, $F3, $1B, $00, $E8, $FB, $1C, $00, $E8, $03, $1D, $00
    db $E0, $F3, $18, $00, $E0, $FB, $19, $00, $E0, $03, $1A, $00, $80

Data_092_4C01:: ; heuristic: target of a monotone pointer table; C0
    db $E0, $F8, $24, $00, $E0, $00, $24, $20, $E8, $F8, $24, $40, $E8, $00, $24, $60
    db $80

Data_092_4C12:: ; heuristic: target of a monotone pointer table; C0
    db $DC, $F4, $25, $00, $DC, $FC, $26, $00, $E4, $F4, $27, $00, $EC, $04, $25, $60
    db $EC, $FC, $26, $60, $E4, $04, $27, $60, $E4, $FC, $2F, $00, $DC, $04, $25, $20
    db $EC, $F4, $25, $40, $80

Data_092_4C37:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $248C37, $81

Data_092_4CB8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $248CB8, $41

Data_092_4CF9:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_092_4CFA:: ; heuristic: target of a monotone pointer table; C0
    dw Data_092_4D3A
    dw Data_092_4D63
    dw Data_092_4DA4
    dw Data_092_4E05
    dw Data_092_4E66
    dw Data_092_4EAF
    dw Data_092_4ED8
    dw Data_092_4F19
    dw Data_092_4F8A
    dw Data_092_5013
    dw Data_092_5084
    dw Data_092_50C5
    dw Data_092_513E
    dw Data_092_51DF
    dw Data_092_5268
    dw Data_092_5301
    dw Data_092_53A2
    dw Data_092_5437
    dw Data_092_5498
    dw Data_092_54F9
    dw Data_092_5582
    dw Data_092_55F3
    dw Data_092_564C
    dw Data_092_5695
    dw Data_092_56BE
    dw Data_092_56BE
    dw Data_092_56BE
    dw Data_092_56BE
    dw Data_092_56BE
    dw Data_092_56BE
    dw Data_092_56BE
    dw Data_092_56BE

Data_092_4D3A:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $B8, $21, $00, $F8, $C0, $22, $00, $F8, $C8, $23, $00, $F8, $D8, $21, $20
    db $F8, $D0, $22, $20, $F8, $40, $21, $20, $F8, $38, $22, $20, $F8, $30, $23, $20
    db $F8, $20, $21, $00, $F8, $28, $22, $00, $80

Data_092_4D63:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $248D63, $41

Data_092_4DA4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $248DA4, $61

Data_092_4E05:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $248E05, $61

Data_092_4E66:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $248E66, $49

Data_092_4EAF:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $D0, $21, $00, $F8, $D8, $22, $00, $F8, $E0, $23, $00, $F8, $F0, $21, $20
    db $F8, $E8, $22, $20, $F8, $28, $21, $20, $F8, $20, $22, $20, $F8, $18, $23, $20
    db $F8, $08, $21, $00, $F8, $10, $22, $00, $80

Data_092_4ED8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $248ED8, $41

Data_092_4F19:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $248F19, $71

Data_092_4F8A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $248F8A, $89

Data_092_5013:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $249013, $71

Data_092_5084:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $249084, $41

Data_092_50C5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2490C5, $79

Data_092_513E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24913E, $A1

Data_092_51DF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2491DF, $89

Data_092_5268:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $249268, $99

Data_092_5301:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $249301, $A1

Data_092_53A2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2493A2, $95

Data_092_5437:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $249437, $61

Data_092_5498:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $249498, $61

Data_092_54F9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2494F9, $89

Data_092_5582:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $249582, $71

Data_092_55F3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2495F3, $59

Data_092_564C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24964C, $49

Data_092_5695:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $FB, $0D, $20, $E8, $FB, $0D, $20, $E0, $FB, $0D, $20, $F8, $FB, $0D, $20
    db $F8, $C4, $08, $20, $F8, $BC, $09, $20, $F8, $CC, $11, $20, $F8, $33, $08, $00
    db $F8, $3B, $09, $00, $F8, $2B, $11, $00, $80

Data_092_56BE:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_092_56BF:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $56, $08, $57, $19, $57, $56, $57, $AB, $57, $E4, $57
    dw Func_092_5805
    dw Func_092_580E
    dw Func_092_5827
    dw Func_092_5860
    dw Data_092_58A9
    dw Data_092_58C2
    dw Data_092_5903
    dw Data_092_5944
    dw Data_092_5975
    dw Data_092_59A6
    dw Data_092_59EF
    dw Data_092_5A50
    dw Data_092_5AC9
    dw Data_092_5B5A
    dw Data_092_5BEB
    dw Data_092_5BEB
    dw Data_092_5BEB
    dw Data_092_5BEB
    dw Data_092_5BEB
    dw Data_092_5BEB
    dw Data_092_5BEB
    dw Data_092_5BEB
    dw Data_092_5BEB
    dw Data_092_5BEB
    dw Data_092_5BEB
    dw Data_092_5BEB
    INCBIN "dwm2-cobi-us.gbc", $2496FF, $106

; no direct call (reached through a table, a jump or a vector)
; reads: rNR30
; writes: hFFF9, rP1
Func_092_5805:: ; heuristic: target of a pointer table; C0
    ret nc
    add sp, 26
    nop
    ret c
    ldh a, [rNR30]
    nop
    add a, b

; no direct call (reached through a table, a jump or a vector)
; writes: hFFF9, rP1
Func_092_580E:: ; heuristic: target of a pointer table; C0
    ldh [hFFF9], a
    ld e, $00
    rst $20
    ld sp, hl
    ld e, $40
    ldh [rP1], a
    ld e, $20
    rst $20
    nop
    ld e, $60
    jp hl
    db $02, $1A, $00, $DE, $F7, $1A, $00, $80

; no direct call (reached through a table, a jump or a vector)
; reads: rP1, hFFF8, rNR30, rSB, rNR11, rNR23, rNR22, rNR24
; writes: hFFF0, rP1, hFFF9
Func_092_5827:: ; heuristic: target of a pointer table; C0
    ldh [hFFF0], a
    ld de, $E000
    ld hl, sp + 18
    nop
    ret c
    ld hl, sp + 15
    nop
    ret c
    nop
    db $10, $00 ; stop
    add sp, -16
    inc d
    nop
    add sp, 8
    ld de, $E860
    nop
    ld [de], a
    ld h, b
    add sp, -8
    inc de
    ld h, b
    ldh a, [rP1]
    rrca
    ld h, b
    ldh a, [hFFF8]
    db $10, $60 ; stop
    ldh [$FF08], a
    inc d
    ld h, b
    ldh [rP1], a
    dec d
    ld h, b
    ldh a, [$FF08]
    ld a, [de]
    nop
    ret c
    ldh a, [rNR30]
    nop
    add a, b

; no direct call (reached through a table, a jump or a vector)
; reads: rSB, rNR11, rNR23, rNR22, rNR24
; writes: hFFF9, rP1
Func_092_5860:: ; heuristic: target of a pointer table; C0
    ldh [hFFF9], a
    ld e, $00
    rst $20
    ld sp, hl
    ld e, $40
    ldh [rP1], a
    ld e, $20
    rst $20
    nop
    ld e, $60
    ldh a, [$FF09]
    jr Jump_092_5874

Jump_092_5874::
    add sp, 1
    ld d, $00
    add sp, 9
    rla
    nop
    ldh a, [rSB]
    rla
    ld h, b
    ldh a, [rNR11]
    add hl, de
    nop
    ld hl, sp + 9
    add hl, de
    ld h, b
    ld hl, sp + 17
    ld a, [de]
    nop
    rst $10
    ldh a, [rNR23]
    ld h, b
    rst $18
    ld hl, sp + 22
    ld h, b
    rst $18
    ldh a, [rNR22]
    ld h, b
    rst $10
    ld hl, sp + 23
    nop
    rst $10
    add sp, 25
    ld h, b
    rst $08
    ldh a, [rNR24]
    nop
    ret nc
    jp hl
    db $1A, $60, $80

Data_092_58A9:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $08, $1A, $00, $F8, $10, $1A, $00, $E8, $00, $1A, $00, $E0, $F8, $1A, $00
    db $D8, $F0, $1A, $00, $D0, $E8, $1A, $60, $80

Data_092_58C2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2498C2, $41

Data_092_5903:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $249903, $41

Data_092_5944:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $0C, $1B, $60, $F8, $14, $1B, $00, $D0, $E4, $1B, $60, $D0, $EC, $1B, $00
    db $D8, $EC, $1B, $60, $D8, $F4, $1B, $00, $E0, $F4, $1B, $60, $E0, $FC, $1B, $00
    db $E8, $FC, $1B, $60, $E8, $04, $1B, $00, $F0, $04, $1B, $60, $F0, $0C, $1B, $00
    db $80

Data_092_5975:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $EC, $1C, $00, $D0, $E4, $1C, $60, $D8, $F4, $1C, $00, $D8, $EC, $1C, $60
    db $E0, $FC, $1C, $00, $E0, $F4, $1C, $60, $E8, $04, $1C, $00, $E8, $FC, $1C, $60
    db $F0, $0C, $1C, $00, $F0, $04, $1C, $60, $F8, $14, $1C, $00, $F8, $0C, $1C, $60
    db $80

Data_092_59A6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2499A6, $49

Data_092_59EF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2499EF, $61

Data_092_5A50:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $249A50, $79

Data_092_5AC9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $249AC9, $91

Data_092_5B5A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $249B5A, $91

Data_092_5BEB:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_092_5BEC:: ; heuristic: target of a monotone pointer table; C0
    dw Data_092_5C2C
    dw Data_092_5C35
    dw Data_092_5C46
    dw Data_092_5C67
    dw Data_092_5C90
    dw Data_092_5CD9
    dw Data_092_5D22
    dw Data_092_5D6B
    dw Data_092_5DB4
    dw Data_092_5E1D
    dw Data_092_5E8E
    dw Data_092_5EF7
    dw Data_092_5F50
    dw Data_092_5F99
    dw Data_092_5FE2
    dw Data_092_6023
    dw Data_092_6034
    dw Data_092_6034
    dw Data_092_6034
    dw Data_092_6034
    dw Data_092_6034
    dw Data_092_6034
    dw Data_092_6034
    dw Data_092_6034
    dw Data_092_6034
    dw Data_092_6034
    dw Data_092_6034
    dw Data_092_6034
    dw Data_092_6034
    dw Data_092_6034
    dw Data_092_6034
    dw Data_092_6034

Data_092_5C2C:: ; heuristic: target of a monotone pointer table; C0
    db $D8, $FC, $00, $10, $D0, $FC, $01, $10, $80

Data_092_5C35:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $FC, $00, $10, $E0, $FC, $01, $10, $D0, $FC, $03, $10, $D8, $FC, $02, $10
    db $80

Data_092_5C46:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $FC, $00, $10, $F0, $FC, $01, $10, $E0, $FC, $03, $10, $E8, $FC, $02, $10
    db $D8, $FC, $04, $10, $D0, $FC, $05, $10, $F8, $00, $08, $10, $F8, $F7, $08, $30
    db $80

Data_092_5C67:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $FC, $05, $10, $F8, $FC, $03, $10, $F0, $FC, $04, $10, $E8, $FC, $05, $10
    db $E0, $FC, $05, $10, $D8, $FC, $05, $10, $F8, $03, $06, $10, $F8, $0B, $07, $10
    db $F8, $F4, $06, $30, $F8, $EC, $07, $30, $80

Data_092_5C90:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $249C90, $49

Data_092_5CD9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $249CD9, $49

Data_092_5D22:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $249D22, $49

Data_092_5D6B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $249D6B, $49

Data_092_5DB4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $249DB4, $69

Data_092_5E1D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $249E1D, $71

Data_092_5E8E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $249E8E, $69

Data_092_5EF7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $249EF7, $59

Data_092_5F50:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $249F50, $49

Data_092_5F99:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $249F99, $49

Data_092_5FE2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $249FE2, $41

Data_092_6023:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $48, $21, $30, $F8, $B0, $21, $10, $F8, $20, $1F, $70, $F8, $D8, $1F, $50
    db $80

Data_092_6034:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_092_6035:: ; heuristic: target of a monotone pointer table; C0
    dw Data_092_6075
    dw Data_092_6096
    dw Data_092_60C7
    dw Data_092_6140
    dw Data_092_61C9
    dw Data_092_625E
    dw Data_092_62FF
    dw Data_092_6340
    dw Data_092_63D1
    dw Data_092_6462
    dw Data_092_6503
    dw Data_092_6540
    dw Data_092_657D
    dw Data_092_65EA
    dw Data_092_6657
    dw Data_092_6694
    dw Data_092_66D1
    dw Data_092_676A
    dw Data_092_6803
    dw Data_092_684C
    dw Data_092_6895
    dw Data_092_68DE
    dw Data_092_6927
    dw Data_092_6927
    dw Data_092_6927
    dw Data_092_6927
    dw Data_092_6927
    dw Data_092_6927
    dw Data_092_6927
    dw Data_092_6927
    dw Data_092_6927
    dw Data_092_6927

Data_092_6075:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $10, $00, $10, $F0, $18, $01, $10, $F0, $20, $02, $10, $F0, $28, $03, $10
    db $F8, $18, $04, $10, $F8, $20, $05, $10, $F8, $28, $06, $10, $F8, $30, $07, $10
    db $80

Data_092_6096:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $00, $00, $10, $E8, $08, $01, $10, $E8, $10, $02, $10, $E8, $18, $03, $10
    db $F0, $08, $04, $10, $F0, $10, $05, $10, $F0, $18, $06, $10, $F0, $20, $07, $10
    db $F8, $10, $08, $10, $F8, $18, $09, $10, $F8, $20, $0A, $10, $F8, $28, $0B, $10
    db $80

Data_092_60C7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24A0C7, $79

Data_092_6140:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24A140, $89

Data_092_61C9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24A1C9, $95

Data_092_625E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24A25E, $A1

Data_092_62FF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24A2FF, $41

Data_092_6340:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24A340, $91

Data_092_63D1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24A3D1, $91

Data_092_6462:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24A462, $A1

Data_092_6503:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $D8, $20, $10, $D0, $E0, $21, $10, $D0, $E8, $22, $10, $D8, $E8, $23, $10
    db $D8, $F0, $24, $10, $E0, $F0, $20, $10, $E0, $F8, $21, $10, $E0, $00, $22, $10
    db $E8, $00, $23, $10, $E8, $08, $24, $10, $F0, $08, $20, $10, $F0, $10, $21, $10
    db $F0, $18, $22, $10, $F8, $18, $23, $10, $F8, $20, $24, $10, $80

Data_092_6540:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $20, $20, $30, $D0, $18, $21, $30, $D0, $10, $22, $30, $D8, $10, $23, $30
    db $D8, $08, $24, $30, $E0, $08, $20, $30, $E0, $00, $21, $30, $E0, $F8, $22, $30
    db $E8, $F8, $23, $30, $E8, $F0, $24, $30, $F0, $F0, $20, $30, $F0, $E8, $21, $30
    db $F0, $E0, $22, $30, $F8, $E0, $23, $30, $F8, $D8, $24, $30, $80

Data_092_657D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24A57D, $6D

Data_092_65EA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24A5EA, $6D

Data_092_6657:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $D8, $23, $10, $D0, $E0, $24, $10, $D8, $E0, $20, $10, $D8, $E8, $21, $10
    db $D8, $F0, $22, $10, $E0, $F0, $23, $10, $E0, $F8, $24, $10, $E8, $F8, $20, $10
    db $E8, $00, $21, $10, $E8, $08, $22, $10, $F0, $08, $23, $10, $F0, $10, $24, $10
    db $F8, $10, $20, $10, $F8, $18, $21, $10, $F8, $20, $22, $10, $80

Data_092_6694:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $20, $23, $30, $D0, $18, $24, $30, $D8, $18, $20, $30, $D8, $10, $21, $30
    db $D8, $08, $22, $30, $E0, $08, $23, $30, $E0, $00, $24, $30, $E8, $00, $20, $30
    db $E8, $F8, $21, $30, $E8, $F0, $22, $30, $F0, $F0, $23, $30, $F0, $E8, $24, $30
    db $F8, $E8, $20, $30, $F8, $E0, $21, $30, $F8, $D8, $22, $30, $80

Data_092_66D1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24A6D1, $99

Data_092_676A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24A76A, $99

Data_092_6803:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24A803, $49

Data_092_684C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24A84C, $49

Data_092_6895:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24A895, $49

Data_092_68DE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24A8DE, $49

Data_092_6927:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_092_6928:: ; heuristic: target of a monotone pointer table; C0
    dw Data_092_6968
    dw Data_092_69C5
    dw Data_092_6A56
    dw Data_092_6AE7
    dw Data_092_6B78
    dw Data_092_6C09
    dw Data_092_6C9A
    dw Data_092_6D2B
    dw Data_092_6DBC
    dw Data_092_6E4D
    dw Data_092_6E56
    dw Data_092_6E7F
    dw Data_092_6EA8
    dw Data_092_6ED1
    dw Data_092_6EFA
    dw Data_092_6F1B
    dw Data_092_6F1B
    dw Data_092_6F1B
    dw Data_092_6F1B
    dw Data_092_6F1B
    dw Data_092_6F1B
    dw Data_092_6F1B
    dw Data_092_6F1B
    dw Data_092_6F1B
    dw Data_092_6F1B
    dw Data_092_6F1B
    dw Data_092_6F1B
    dw Data_092_6F1B
    dw Data_092_6F1B
    dw Data_092_6F1B
    dw Data_092_6F1B
    dw Data_092_6F1B

Data_092_6968:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24A968, $5D

Data_092_69C5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24A9C5, $91

Data_092_6A56:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24AA56, $91

Data_092_6AE7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24AAE7, $91

Data_092_6B78:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24AB78, $91

Data_092_6C09:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24AC09, $91

Data_092_6C9A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24AC9A, $91

Data_092_6D2B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24AD2B, $91

Data_092_6DBC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24ADBC, $91

Data_092_6E4D:: ; heuristic: target of a monotone pointer table; C0
    db $E6, $04, $05, $10, $E2, $F4, $05, $10, $80

Data_092_6E56:: ; heuristic: target of a monotone pointer table; C0
    db $E2, $01, $08, $10, $EA, $01, $09, $10, $E2, $08, $08, $30, $EA, $08, $09, $30
    db $DE, $F0, $08, $10, $E6, $F0, $09, $10, $DE, $F7, $08, $30, $E6, $F7, $09, $30
    db $E0, $14, $05, $10, $E8, $E4, $05, $10, $80

Data_092_6E7F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $24, $05, $10, $DE, $D4, $05, $10, $DC, $11, $0A, $10, $E4, $11, $0B, $10
    db $DC, $18, $0A, $30, $E4, $18, $0B, $30, $E4, $E0, $0A, $10, $EC, $E0, $0B, $10
    db $E4, $E7, $0A, $30, $EC, $E7, $0B, $30, $80

Data_092_6EA8:: ; heuristic: target of a monotone pointer table; C0
    db $EE, $21, $08, $50, $E6, $21, $09, $50, $EE, $28, $08, $70, $E6, $28, $09, $70
    db $DA, $D7, $08, $30, $E2, $D7, $09, $30, $DA, $D0, $08, $10, $E2, $D0, $09, $10
    db $DC, $34, $05, $10, $EC, $C4, $05, $10, $80

Data_092_6ED1:: ; heuristic: target of a monotone pointer table; C0
    db $EE, $44, $05, $10, $DA, $B4, $05, $10, $D8, $31, $0A, $10, $E0, $31, $0B, $10
    db $D8, $38, $0A, $30, $E0, $38, $0B, $30, $E8, $C0, $0A, $10, $F0, $C0, $0B, $10
    db $E8, $C7, $0A, $30, $F0, $C7, $0B, $30, $80

Data_092_6EFA:: ; heuristic: target of a monotone pointer table; C0
    db $F2, $41, $08, $50, $EA, $41, $09, $50, $F2, $48, $08, $70, $EA, $48, $09, $70
    db $D6, $B7, $08, $30, $DE, $B7, $09, $30, $D6, $B0, $08, $10, $DE, $B0, $09, $10
    db $80

Data_092_6F1B:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_092_6F1C:: ; heuristic: target of a monotone pointer table; C0
    dw Data_092_6F5C
    dw Data_092_6F61
    dw Data_092_6F76
    dw Data_092_6F9F
    dw Data_092_6FF8
    dw Data_092_7079
    dw Data_092_70EE
    dw Data_092_714F
    dw Data_092_71B8
    dw Data_092_7239
    dw Data_092_72BA
    dw Data_092_734B
    dw Data_092_73C8
    dw Data_092_7439
    dw Data_092_74A2
    dw Data_092_74DF
    dw Data_092_74F4
    dw Data_092_74F9
    dw Data_092_750E
    dw Data_092_7557
    dw Data_092_75EC
    dw Data_092_7641
    dw Data_092_7682
    dw Data_092_771F
    dw Data_092_77A4
    dw Data_092_77E5
    dw Data_092_7872
    dw Data_092_78D3
    dw Data_092_78D3
    dw Data_092_78D3
    dw Data_092_78D3
    dw Data_092_78D3

Data_092_6F5C:: ; heuristic: target of a monotone pointer table; C0
    db $E4, $FC, $05, $10, $80

Data_092_6F61:: ; heuristic: target of a monotone pointer table; C0
    db $E0, $F8, $06, $10, $E0, $00, $06, $30, $E8, $F8, $06, $50, $E8, $00, $06, $70
    db $EC, $EC, $05, $10, $80

Data_092_6F76:: ; heuristic: target of a monotone pointer table; C0
    db $E0, $F8, $07, $10, $E0, $00, $07, $30, $E8, $F8, $07, $50, $E8, $00, $07, $70
    db $E8, $E8, $06, $10, $E8, $F0, $06, $30, $F0, $E8, $06, $50, $F0, $F0, $06, $70
    db $DC, $0C, $05, $10, $D8, $EC, $05, $10, $80

Data_092_6F9F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24AF9F, $59

Data_092_6FF8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24AFF8, $81

Data_092_7079:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24B079, $75

Data_092_70EE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24B0EE, $61

Data_092_714F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24B14F, $69

Data_092_71B8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24B1B8, $81

Data_092_7239:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24B239, $81

Data_092_72BA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24B2BA, $91

Data_092_734B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24B34B, $7D

Data_092_73C8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24B3C8, $71

Data_092_7439:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24B439, $69

Data_092_74A2:: ; heuristic: target of a monotone pointer table; C0
    db $EC, $B0, $13, $10, $EC, $B8, $14, $10, $F4, $B8, $11, $70, $F4, $B0, $12, $70
    db $FC, $AE, $10, $70, $D8, $4C, $0F, $30, $D0, $4C, $0D, $30, $D8, $44, $0E, $10
    db $D0, $44, $0C, $10, $E0, $4C, $0D, $70, $E0, $44, $0C, $50, $D0, $38, $0A, $10
    db $D8, $38, $0B, $10, $D0, $3F, $0A, $30, $D8, $3F, $0B, $30, $80

Data_092_74DF:: ; heuristic: target of a monotone pointer table; C0
    db $DC, $48, $13, $70, $DC, $40, $14, $70, $D4, $40, $11, $10, $D4, $48, $12, $10
    db $CC, $4A, $10, $10, $80

Data_092_74F4:: ; heuristic: target of a monotone pointer table; C0
    db $DC, $0C, $05, $10, $80

Data_092_74F9:: ; heuristic: target of a monotone pointer table; C0
    db $E0, $10, $07, $70, $E0, $08, $07, $50, $D8, $08, $07, $10, $D8, $10, $07, $30
    db $F8, $E4, $22, $50, $80

Data_092_750E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24B50E, $49

Data_092_7557:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24B557, $95

Data_092_75EC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24B5EC, $55

Data_092_7641:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24B641, $41

Data_092_7682:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24B682, $9D

Data_092_771F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24B71F, $85

Data_092_77A4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24B7A4, $41

Data_092_77E5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24B7E5, $8D

Data_092_7872:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24B872, $61

Data_092_78D3:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_092_78D4:: ; heuristic: target of a monotone pointer table; C0
    dw Data_092_7914
    dw Data_092_7925
    dw Data_092_7946
    dw Data_092_798B
    dw Data_092_79BC
    dw Data_092_79ED
    dw Data_092_7A1A
    dw Data_092_7A4B
    dw Data_092_7A88
    dw Data_092_7AD1
    dw Data_092_7B1A
    dw Data_092_7B2B
    dw Data_092_7B30
    dw Data_092_7B30
    dw Data_092_7B30
    dw Data_092_7B30
    dw Data_092_7B30
    dw Data_092_7B30
    dw Data_092_7B30
    dw Data_092_7B30
    dw Data_092_7B30
    dw Data_092_7B30
    dw Data_092_7B30
    dw Data_092_7B30
    dw Data_092_7B30
    dw Data_092_7B30
    dw Data_092_7B30
    dw Data_092_7B30
    dw Data_092_7B30
    dw Data_092_7B30
    dw Data_092_7B30
    dw Data_092_7B30

Data_092_7914:: ; heuristic: target of a monotone pointer table; C0
    db $E2, $B8, $00, $20, $E0, $B0, $01, $20, $E8, $B0, $02, $20, $E3, $C0, $10, $20
    db $80

Data_092_7925:: ; heuristic: target of a monotone pointer table; C0
    db $E0, $B8, $02, $60, $E0, $B0, $03, $60, $E8, $D4, $08, $40, $E8, $CC, $07, $40
    db $E8, $BC, $02, $00, $E9, $C4, $07, $60, $E0, $D4, $09, $40, $E2, $DC, $20, $40
    db $80

Data_092_7946:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24B946, $45

Data_092_798B:: ; heuristic: target of a monotone pointer table; C0
    db $E4, $F0, $04, $60, $E2, $F8, $03, $60, $E2, $00, $02, $60, $E7, $08, $20, $40
    db $E1, $E8, $00, $20, $E3, $E0, $01, $60, $DB, $E0, $02, $60, $DE, $D8, $1B, $00
    db $E6, $D0, $1E, $00, $E6, $D8, $1F, $00, $E3, $C8, $07, $00, $E4, $C0, $20, $60
    db $80

Data_092_79BC:: ; heuristic: target of a monotone pointer table; C0
    db $E2, $F2, $00, $00, $E0, $FA, $01, $00, $E8, $FA, $02, $00, $E7, $02, $15, $40
    db $E7, $0A, $16, $40, $DF, $08, $1D, $40, $DF, $10, $1E, $40, $DF, $18, $1F, $40
    db $E7, $17, $1D, $00, $E8, $1F, $20, $40, $E1, $EB, $13, $40, $E1, $E3, $20, $60
    db $80

Data_092_79ED:: ; heuristic: target of a monotone pointer table; C0
    db $E3, $28, $19, $20, $E3, $18, $1B, $20, $EB, $18, $1F, $20, $EB, $28, $1D, $20
    db $EB, $20, $1E, $20, $DB, $29, $09, $40, $DE, $31, $20, $40, $E7, $09, $13, $00
    db $E3, $10, $1C, $20, $E6, $01, $11, $00, $E6, $F9, $20, $20, $80

Data_092_7A1A:: ; heuristic: target of a monotone pointer table; C0
    db $DA, $31, $01, $00, $E2, $31, $02, $00, $DE, $29, $16, $20, $E6, $29, $09, $20
    db $E4, $21, $07, $20, $E8, $19, $12, $40, $E3, $0B, $10, $40, $E5, $11, $13, $20
    db $E0, $41, $0D, $20, $E0, $39, $0E, $20, $E3, $49, $1E, $00, $E4, $FC, $0F, $00
    db $80

Data_092_7A4B:: ; heuristic: target of a monotone pointer table; C0
    db $E2, $48, $0C, $00, $E4, $40, $04, $40, $E4, $38, $02, $00, $DC, $38, $08, $00
    db $DC, $30, $07, $00, $DD, $28, $1B, $00, $E5, $22, $17, $00, $E5, $2A, $18, $00
    db $EB, $1C, $00, $40, $ED, $24, $01, $40, $E7, $14, $20, $20, $E0, $F8, $21, $00
    db $E7, $F8, $21, $40, $E0, $FF, $21, $20, $E7, $FF, $21, $60, $80

Data_092_7A88:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24BA88, $49

Data_092_7AD1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $24BAD1, $49

Data_092_7B1A:: ; heuristic: target of a monotone pointer table; C0
    db $E0, $F8, $21, $00, $E7, $F8, $21, $40, $E0, $FF, $21, $20, $E7, $FF, $21, $60
    db $80

Data_092_7B2B:: ; heuristic: target of a monotone pointer table; C0
    db $E4, $FC, $0F, $00, $80

Data_092_7B30:: ; heuristic: target of a monotone pointer table; C0
    db $80
    ds $4CF, $00
