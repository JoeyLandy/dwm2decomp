SECTION "Bank 26", ROMX[$4000], BANK[$26]
    db $26

; 6 call sites from 6 routines (e.g. DebugMonsterPictureViewer_Update, Func_004_44CE, Func_004_4C96, Func_004_4D43, ...)
; reads: hSpriteSetIndex, hSpriteAttrXor
; writes: hSpriteAttrXor
Func_026_4001::
    ldh a, [hSpriteSetIndex]
    ld e, a
    ld d, $00
    ld hl, Data_026_411E
    add hl, de
    bit 0, [hl]
    jr z, Jump_026_4017
    ld a, [hl]
    and a, $F0
    ld e, a
    ldh a, [hSpriteAttrXor]
    or a, e
    ldh [hSpriteAttrXor], a

Jump_026_4017::
    ld de, Data_026_401E
    call Func_026_419E
    ret

Data_026_401E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_026_441A
    dw Data_026_448C
    dw Data_026_44FE
    dw Data_026_4570
    dw Data_026_45E2
    dw Data_026_4654
    dw Data_026_4654
    dw Data_026_4654
    dw Data_026_4654
    dw Data_026_4654
    dw Data_026_4654
    dw Data_026_4654
    dw Data_026_4654
    dw Data_026_4654
    dw Data_026_46C6
    dw Data_026_4738
    dw Data_026_47AA
    dw Data_026_481C
    dw Data_026_488E
    dw Data_026_4900
    dw Data_026_4972
    dw Data_026_49E4
    dw Data_026_4A56
    dw Data_026_4AC8
    dw Data_026_4B3A
    dw Data_026_4BAC
    dw Data_026_4C1E
    dw Data_026_4C90
    dw Data_026_4D02
    dw Data_026_4D74
    dw Data_026_4DE6
    dw Data_026_4E58
    dw Data_026_4ECA
    dw Data_026_4F3C
    dw Data_026_4FAE
    dw Data_026_5020
    dw Data_026_5092
    dw Data_026_5104
    dw Data_026_5176
    dw Data_026_51E0
    dw Data_026_5252
    dw Data_026_5252
    dw Data_026_5252
    dw Data_026_5252
    dw Data_026_5252
    dw Data_026_5252
    dw Data_026_5252
    dw Data_026_5252
    dw Data_026_5252
    dw Data_026_52C4
    dw Data_026_5336
    dw Data_026_53A8
    dw Data_026_541A
    dw Data_026_5474
    dw Data_026_54DE
    dw Data_026_5550
    dw Data_026_55C2
    dw Data_026_5634
    dw Data_026_56A6
    dw Data_026_5710
    dw Data_026_5782
    dw Data_026_57F4
    dw Data_026_5866
    dw Data_026_58D8
    dw Data_026_594A
    dw Data_026_59BC
    dw Data_026_5A2E
    dw Data_026_5AA0
    dw Data_026_5B12
    dw Data_026_5B84
    dw Data_026_5BF6
    dw Data_026_5C68
    dw Data_026_5CDA
    dw Data_026_5D4C
    dw Data_026_5DBE
    dw Data_026_5DBE
    dw Data_026_5DBE
    dw Data_026_5DBE
    dw Data_026_5DBE
    dw Data_026_5DBE
    dw Data_026_5DBE
    dw Data_026_5DBE
    dw Data_026_5DBE
    dw Data_026_5DBE
    dw Data_026_5E30
    dw Data_026_5EA2
    dw Data_026_5F14
    dw Data_026_5F86
    dw Data_026_5FF8
    dw Data_026_606A
    dw Data_026_60DC
    dw Data_026_614E
    dw Data_026_61C0
    dw Data_026_6232
    dw Data_026_62A4
    dw Data_026_6316
    dw Data_026_6388
    dw Data_026_63FA
    dw Data_026_646C
    dw Data_026_64DE
    dw Data_026_6550
    dw Data_026_65C2
    dw Data_026_6634
    dw Data_026_66A6
    dw Data_026_6718
    dw Data_026_678A
    dw Data_026_67FC
    dw Data_026_686E
    dw Data_026_68E0
    dw Data_026_6952
    dw Data_026_69C4
    dw Data_026_6A36
    dw Data_026_6AA8
    dw Data_026_6B1A
    dw Data_026_6B1A
    dw Data_026_6B1A
    dw Data_026_6B1A
    dw Data_026_6B1A
    dw Data_026_6B1A
    dw Data_026_6B8C
    dw Data_026_6BFE
    dw Data_026_6C70
    dw Data_026_6CE2
    dw Data_026_6D54
    dw Data_026_6DC6
    dw Data_026_6E38
    dw Data_026_6EAA
    dw Data_026_6F1C

Data_026_411E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $01, $11, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $11, $10
    db $10, $11, $00, $10, $10, $01, $10, $11, $10, $10, $11, $10, $00, $00, $10, $10
    db $11, $01, $00, $01, $01, $00, $01, $01
    ds $10, $00
    INCBIN "dwm2-cobi-us.gbc", $098156, $48

; 1 call site from 1 routine (e.g. Func_026_4001)
; reads: hOamNextEntry, hSpriteScrollYLo, hSpriteScrollYHi, hSpriteOriginY, hSpriteOriginYHi, hSpriteScrollXLo, hSpriteScrollXHi, hSpriteOriginX, ...
; writes: hFFB3, hFFB4, hOamNextEntry
; points at: hFFB5
Func_026_419E::
    ldh a, [hOamNextEntry]
    cp a, $27
    ret nc
    ldh a, [hSpriteScrollYLo]
    ld c, a
    ldh a, [hSpriteScrollYHi]
    ld b, a
    ldh a, [hSpriteOriginY]
    add a, c
    ldh [hFFB3], a
    ldh a, [hSpriteOriginYHi]
    adc a, b
    ldh [hFFB4], a
    ldh a, [hSpriteScrollXLo]
    ld c, a
    ldh a, [hSpriteScrollXHi]
    ld b, a
    ld hl, hFFB5
    ldh a, [hSpriteOriginX]
    add a, c
    ld c, a
    ld [hl+], a
    ldh a, [hSpriteOriginXHi]
    adc a, b
    ld b, a
    ld [hl+], a
    ld a, c
    sub a, $08
    ld [hl+], a
    ld a, b
    sbc a, $00
    ld [hl], a
    ldh a, [hSpriteSetIndex]
    add a, a
    add a, e
    ld l, a
    ld a, $00
    adc a, d
    ld h, a
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ldh a, [hSpriteSubIndex]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, de
    deref_hl
    ldh a, [hOamNextEntry]
    add a, a
    add a, a
    ld e, a
    ld d, $C0
    ldh a, [hFFB9]
    or a, a
    jp nz, Jump_026_42E8
    ldh a, [hSpriteTileOffset]
    ld c, a
    ldh a, [hSpriteAttrXor]
    and a, $20
    jr nz, Jump_026_4270

Jump_026_41FA::
    ld a, [hl+]
    cp a, $80
    ret z
    ld b, a
    jr nc, Jump_026_4212
    ldh a, [hFFB3]
    add a, b
    ld b, a
    ldh a, [hFFB4]
    adc a, $00
    jr nz, Jump_026_4221
    ld a, b
    cp a, $A8
    jr c, Jump_026_4226
    jr Jump_026_4221

Jump_026_4212::
    ldh a, [hFFB3]
    add a, b
    ld b, a
    ldh a, [hFFB4]
    adc a, $FF
    jr nz, Jump_026_4221
    ld a, b
    cp a, $A8
    jr c, Jump_026_4226

Jump_026_4221::
    inc hl
    inc hl
    inc hl
    jr Jump_026_41FA

Jump_026_4226::
    ld a, b
    ld [de], a
    inc e
    ld a, [hl+]
    ld b, a
    rlca
    jr c, Jump_026_423F
    ldh a, [hFFB5]
    add a, b
    ld b, a
    ldh a, [hFFB6]
    adc a, $00
    jr nz, Jump_026_424E
    ld a, b
    cp a, $B8
    jr c, Jump_026_4255
    jr Jump_026_424E

Jump_026_423F::
    ldh a, [hFFB5]
    add a, b
    ld b, a
    ldh a, [hFFB6]
    adc a, $FF
    jr nz, Jump_026_424E
    ld a, b
    cp a, $B8
    jr c, Jump_026_4255

Jump_026_424E::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_026_41FA

Jump_026_4255::
    ld a, b
    ld [de], a
    inc e
    ldh a, [hSpriteTileOffset]
    ld c, a
    ld a, [hl+]
    add a, c
    ld [de], a
    inc e
    ldh a, [hSpriteAttrXor]
    ld c, a
    ld a, [hl+]
    xor a, c
    ld [de], a
    inc e
    ldh a, [hOamNextEntry]
    inc a
    ldh [hOamNextEntry], a
    cp a, $28
    jr nz, Jump_026_41FA
    ret

Jump_026_4270::
    ld a, [hl+]
    cp a, $80
    ret z
    ld b, a
    jr nc, Jump_026_4288
    ldh a, [hFFB3]
    add a, b
    ld b, a
    ldh a, [hFFB4]
    adc a, $00
    jr nz, Jump_026_4297
    ld a, b
    cp a, $A8
    jr c, Jump_026_429C
    jr Jump_026_4297

Jump_026_4288::
    ldh a, [hFFB3]
    add a, b
    ld b, a
    ldh a, [hFFB4]
    adc a, $FF
    jr nz, Jump_026_4297
    ld a, b
    cp a, $A8
    jr c, Jump_026_429C

Jump_026_4297::
    inc hl
    inc hl
    inc hl
    jr Jump_026_4270

Jump_026_429C::
    ld a, b
    ld [de], a
    inc e
    ld a, [hl+]
    ld b, a
    rlca
    jr c, Jump_026_42B7
    ldh a, [hFFB7]
    sub a, b
    ld b, a
    ldh a, [hFFB8]
    sbc a, $00
    jr z, Jump_026_42CD
    jr nz, Jump_026_42C6
    ld a, b
    cp a, $B8
    jr c, Jump_026_42CD
    jr Jump_026_42C6

Jump_026_42B7::
    ldh a, [hFFB7]
    sub a, b
    ld b, a
    ldh a, [hFFB8]
    sbc a, $FF
    jr nz, Jump_026_42C6
    ld a, b
    cp a, $B8
    jr c, Jump_026_42CD

Jump_026_42C6::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_026_4270

Jump_026_42CD::
    ld a, b
    ld [de], a
    inc e
    ldh a, [hSpriteTileOffset]
    ld c, a
    ld a, [hl+]
    add a, c
    ld [de], a
    inc e
    ldh a, [hSpriteAttrXor]
    ld c, a
    ld a, [hl+]
    xor a, c
    ld [de], a
    inc e
    ldh a, [hOamNextEntry]
    inc a
    ldh [hOamNextEntry], a
    cp a, $28
    jr nz, Jump_026_4270
    ret

Jump_026_42E8::
    ldh a, [hSpriteAttrXor]
    and a, $20
    jr nz, Jump_026_4369

Jump_026_42EE::
    ld a, [hl+]
    cp a, $80
    ret z
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_026_42F9
    dec b

Jump_026_42F9::
    ldh a, [hFFB3]
    add a, c
    ld c, a
    ldh a, [hFFB4]
    adc a, b
    jr nz, Jump_026_4324
    ld a, c
    cp a, $B8
    jr nc, Jump_026_4324
    ldh a, [hFFB9]
    or a, a
    jr z, Jump_026_4329
    cp a, $01
    jr nz, Jump_026_4317
    ld a, c
    cp a, $34
    jr c, Jump_026_4324
    jr Jump_026_4329

Jump_026_4317::
    cp a, $02
    jr nz, Jump_026_4322
    ld a, c
    cp a, $71
    jr c, Jump_026_4329
    jr Jump_026_4324

Jump_026_4322::
    jr Jump_026_4329

Jump_026_4324::
    inc hl
    inc hl
    inc hl
    jr Jump_026_42EE

Jump_026_4329::
    ld a, c
    ld [de], a
    inc e
    ld a, [hl+]
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_026_4334
    dec b

Jump_026_4334::
    ldh a, [hFFB5]
    add a, c
    ld c, a
    ldh a, [hFFB6]
    adc a, b
    jr nz, Jump_026_4342
    ld a, c
    cp a, $B8
    jr c, Jump_026_4349

Jump_026_4342::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_026_42EE

Jump_026_4349::
    ld a, c
    ld [de], a
    call BGTileUnderPointIsHFFBA_Bank26
    jr nc, Jump_026_4342
    inc e
    ldh a, [hSpriteTileOffset]
    ld b, a
    ld a, [hl+]
    add a, b
    ld [de], a
    inc e
    ldh a, [hSpriteAttrXor]
    ld c, a
    ld a, [hl+]
    xor a, c
    ld [de], a
    inc e
    ldh a, [hOamNextEntry]
    inc a
    ldh [hOamNextEntry], a
    cp a, $28
    jr nz, Jump_026_42EE
    ret

Jump_026_4369::
    ld a, [hl+]
    cp a, $80
    ret z
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_026_4374
    dec b

Jump_026_4374::
    ldh a, [hFFB3]
    add a, c
    ld c, a
    ldh a, [hFFB4]
    adc a, b
    jr nz, Jump_026_439F
    ld a, c
    cp a, $B8
    jr nc, Jump_026_439F
    ldh a, [hFFB9]
    or a, a
    jr z, Jump_026_43A4
    cp a, $01
    jr nz, Jump_026_4392
    ld a, c
    cp a, $34
    jr c, Jump_026_439F
    jr Jump_026_43A4

Jump_026_4392::
    cp a, $02
    jr nz, Jump_026_439D
    ld a, c
    cp a, $71
    jr c, Jump_026_43A4
    jr Jump_026_439F

Jump_026_439D::
    jr Jump_026_43A4

Jump_026_439F::
    inc hl
    inc hl
    inc hl
    jr Jump_026_4369

Jump_026_43A4::
    ld a, c
    ld [de], a
    inc e
    ld a, [hl+]
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_026_43AF
    dec b

Jump_026_43AF::
    ldh a, [hFFB7]
    sub a, c
    ld c, a
    ldh a, [hFFB8]
    sbc a, b
    jr nz, Jump_026_43BD
    ld a, c
    cp a, $B8
    jr c, Jump_026_43C4

Jump_026_43BD::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_026_4369

Jump_026_43C4::
    ld a, c
    ld [de], a
    call BGTileUnderPointIsHFFBA_Bank26
    jr nc, Jump_026_43BD
    inc e
    ldh a, [hSpriteTileOffset]
    ld b, a
    ld a, [hl+]
    add a, b
    ld [de], a
    inc e
    ldh a, [hSpriteAttrXor]
    ld c, a
    ld a, [hl+]
    xor a, c
    ld [de], a
    inc e
    ldh a, [hOamNextEntry]
    inc a
    ldh [hOamNextEntry], a
    cp a, $28
    jr nz, Jump_026_4369
    ret

; DE = address of an X byte with its Y byte at DE - 1 (screen coordinates): HL = the $9800 BG map entry under (X + hScrollX - 4, Y + hScrollY - 12), rows wrapping inside the map; reads it after rSTAT bit 1 clears (interrupts off) and compares with hFFBA: Z set when equal, A = the tile; BC, HL kept (E-0065) (the same 54 bytes appear in 6 banks)
; 2 call sites from 1 routine (e.g. Func_026_419E)
; reads: hScrollY, hScrollX, hFFBA, rSTAT
BGTileUnderPointIsHFFBA_Bank26::
Func_026_43E4:: ; address name
    push hl
    push bc
    ldh a, [hScrollY]
    ld b, a
    dec e
    ld a, [de]
    inc e
    add a, b
    sub a, $0C
    and a, $F8
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ldh a, [hScrollX]
    ld b, a
    ld a, [de]
    add a, b
    sub a, $04
    and a, $F8
    rrca
    rrca
    rrca
    add a, l
    ld l, a
    ld a, h
    and a, $03
    adc a, $98
    ld h, a
    ldh a, [hFFBA]
    ld b, a
    di

Jump_026_440E::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_026_440E
    ld a, [hl]
    ei
    cp a, b
    pop bc
    pop hl
    ret

Data_026_441A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09841A, $72

Data_026_448C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09848C, $72

Data_026_44FE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0984FE, $72

Data_026_4570:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $098570, $72

Data_026_45E2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0985E2, $72

Data_026_4654:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $098654, $72

Data_026_46C6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0986C6, $72

Data_026_4738:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $098738, $72

Data_026_47AA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0987AA, $72

Data_026_481C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09881C, $72

Data_026_488E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09888E, $72

Data_026_4900:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $098900, $72

Data_026_4972:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $098972, $72

Data_026_49E4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0989E4, $72

Data_026_4A56:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $098A56, $72

Data_026_4AC8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $098AC8, $72

Data_026_4B3A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $098B3A, $72

Data_026_4BAC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $098BAC, $72

Data_026_4C1E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $098C1E, $72

Data_026_4C90:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $098C90, $72

Data_026_4D02:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $098D02, $72

Data_026_4D74:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $098D74, $72

Data_026_4DE6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $098DE6, $72

Data_026_4E58:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $098E58, $72

Data_026_4ECA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $098ECA, $72

Data_026_4F3C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $098F3C, $72

Data_026_4FAE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $098FAE, $72

Data_026_5020:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $099020, $72

Data_026_5092:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $099092, $72

Data_026_5104:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $099104, $72

Data_026_5176:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $099176, $6A

Data_026_51E0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0991E0, $72

Data_026_5252:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $099252, $72

Data_026_52C4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0992C4, $72

Data_026_5336:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $099336, $72

Data_026_53A8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0993A8, $72

Data_026_541A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09941A, $5A

Data_026_5474:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $099474, $6A

Data_026_54DE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0994DE, $72

Data_026_5550:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $099550, $72

Data_026_55C2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0995C2, $72

Data_026_5634:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $099634, $72

Data_026_56A6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0996A6, $6A

Data_026_5710:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $099710, $72

Data_026_5782:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $099782, $72

Data_026_57F4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0997F4, $72

Data_026_5866:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $099866, $72

Data_026_58D8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0998D8, $72

Data_026_594A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09994A, $72

Data_026_59BC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0999BC, $72

Data_026_5A2E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $099A2E, $72

Data_026_5AA0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $099AA0, $72

Data_026_5B12:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $099B12, $72

Data_026_5B84:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $099B84, $72

Data_026_5BF6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $099BF6, $72

Data_026_5C68:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $099C68, $72

Data_026_5CDA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $099CDA, $72

Data_026_5D4C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $099D4C, $72

Data_026_5DBE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $099DBE, $72

Data_026_5E30:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $099E30, $72

Data_026_5EA2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $099EA2, $72

Data_026_5F14:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $099F14, $72

Data_026_5F86:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $099F86, $72

Data_026_5FF8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $099FF8, $72

Data_026_606A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09A06A, $72

Data_026_60DC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09A0DC, $72

Data_026_614E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09A14E, $72

Data_026_61C0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09A1C0, $72

Data_026_6232:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09A232, $72

Data_026_62A4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09A2A4, $72

Data_026_6316:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09A316, $72

Data_026_6388:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09A388, $72

Data_026_63FA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09A3FA, $72

Data_026_646C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09A46C, $72

Data_026_64DE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09A4DE, $72

Data_026_6550:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09A550, $72

Data_026_65C2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09A5C2, $72

Data_026_6634:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09A634, $72

Data_026_66A6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09A6A6, $72

Data_026_6718:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09A718, $72

Data_026_678A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09A78A, $72

Data_026_67FC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09A7FC, $72

Data_026_686E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09A86E, $72

Data_026_68E0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09A8E0, $72

Data_026_6952:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09A952, $72

Data_026_69C4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09A9C4, $72

Data_026_6A36:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09AA36, $72

Data_026_6AA8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09AAA8, $72

Data_026_6B1A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09AB1A, $72

Data_026_6B8C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09AB8C, $72

Data_026_6BFE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09ABFE, $72

Data_026_6C70:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09AC70, $72

Data_026_6CE2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09ACE2, $72

Data_026_6D54:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09AD54, $72

Data_026_6DC6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09ADC6, $72

Data_026_6E38:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09AE38, $72

Data_026_6EAA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09AEAA, $72

Data_026_6F1C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09AF1C, $72
    ds $1072, $00
