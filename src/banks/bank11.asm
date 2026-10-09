SECTION "Bank 11", ROMX[$4000], BANK[$11]
    db $11, $C9

Func_011_4002::
    ld a, [$CC44]
    bit 7, a
    jr z, Jump_011_4010
    ld hl, Func_061_5764
    ld b, $61
    rst $10
    ret

Jump_011_4010::
    ldh a, [$FF90]
    ld l, a
    ld h, $00
    add hl, hl
    ld de, Data_011_67A6
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a

Jump_011_401E::
    push de
    ld a, [de]
    inc de
    cp a, $80
    jr nz, Jump_011_4029
    pop de
    ld c, $00
    ret

Jump_011_4029::
    cp a, $FD
    jr z, Jump_011_407D
    cp a, $FE
    jr z, Jump_011_4066
    cp a, $FF
    jr z, Jump_011_4066
    ld c, a
    ldh a, [$FF98]
    cp a, c
    jr nz, Jump_011_407D
    ld a, [de]
    inc de
    ld [$C8CA], a
    push af
    swap a
    and a, $0F
    ld c, a
    ldh a, [$FF8F]
    cp a, c
    jr nz, Jump_011_407C
    pop af
    and a, $0F
    ld c, a
    ldh a, [$FF92]
    cp a, c
    jr nz, Jump_011_407D
    ld a, [de]
    inc de
    ld c, a
    ldh a, [$FF8E]
    cp a, c
    jr nz, Jump_011_407D
    ld a, [de]
    inc de
    ld c, a
    ldh a, [$FF91]
    cp a, c
    jr nz, Jump_011_407D
    jr Jump_011_4088

Jump_011_4066::
    ld [$C8CA], a
    inc de
    ld a, [de]
    inc de
    ld c, a
    ldh a, [$FF8F]
    cp a, c
    jr nz, Jump_011_407D
    ld a, [de]
    inc de
    ld c, a
    ldh a, [$FF92]
    cp a, c
    jr nz, Jump_011_407D
    jr Jump_011_4088

Jump_011_407C::
    pop af

Jump_011_407D::
    pop de
    ld a, e
    add a, $09
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    jr Jump_011_401E

Jump_011_4088::
    ld a, $01
    ld [$CCEA], a
    ld a, $60
    call Func_000_1278
    ld a, [de]
    inc de
    ldh [$FF90], a
    ld a, [de]
    inc de
    and a, $0F
    ldh [$FF8F], a
    ld a, [de]
    and a, $0F
    inc de
    ldh [$FF92], a
    ld a, [$C8CA]
    cp a, $FF
    jr z, Jump_011_40D2
    ld a, [de]
    inc de
    swap a
    and a, $F0
    ld [$C8C8], a
    ld a, [de]
    swap a
    and a, $F0
    ld [$C8C9], a
    dec de
    dec de
    dec de
    ld a, [de]
    bit 7, a
    jr z, Jump_011_40F9
    ldh a, [$FF8C]
    or a, $40
    ldh [$FF8C], a
    ld a, [$C8C9]
    add a, $08
    ld [$C8C9], a
    jr Jump_011_40F9

Jump_011_40D2::
    ld a, [de]
    inc de
    ld c, a
    ldh a, [$FF8E]
    add a, c
    ld [$C8C8], a
    ld a, [de]
    ld c, a
    ldh a, [$FF91]
    add a, c
    ld [$C8C9], a
    dec de
    dec de
    dec de
    ld a, [de]
    bit 7, a
    jr z, Jump_011_40F9
    ldh a, [$FF8C]
    or a, $40
    ldh [$FF8C], a
    ld a, [$C8C9]
    add a, $08
    ld [$C8C9], a

Jump_011_40F9::
    ld a, [de]
    swap a
    and a, $03
    cp a, $03
    jr z, Jump_011_4105
    ld [$C88B], a

Jump_011_4105::
    inc de
    ld a, [de]
    swap a
    and a, $0F
    ld [$C8C6], a
    ld a, $04
    call Func_000_0DF2
    ld hl, $C5E0
    inc [hl]
    ld a, $04
    ld [$C5DC], a
    xor a, a
    ld [$C8C5], a
    ldh a, [$FF8C]
    or a, $80
    ldh [$FF8C], a
    ld hl, Func_012_7B9F
    ld b, $12
    rst $10
    pop de
    ld c, $01
    ret

Func_011_4130::
    ld a, [$CC44]
    bit 7, a
    jr z, Jump_011_413E
    ld hl, Func_061_596F
    ld b, $61
    rst $10
    ret

Jump_011_413E::
    call Func_011_43BB
    bit 0, c
    ret nz
    ldh a, [$FF90]
    ld l, a
    ld h, $00
    add hl, hl
    ld de, Data_011_67A6
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a

Jump_011_4152::
    push de
    ld a, [de]
    inc de
    cp a, $80
    jr nz, Jump_011_4199
    pop de
    ldh a, [$FF8C]
    bit 7, a
    jr z, Jump_011_4196
    ldh a, [$FF90]
    cp a, $30
    jr nz, Jump_011_4190
    ldh a, [$FF8F]
    cp a, $05
    jr nz, Jump_011_4190
    ldh a, [$FF92]
    cp a, $05
    jr nz, Jump_011_4190
    ldh a, [$FF8E]
    cp a, $40
    jr nz, Jump_011_4190
    ldh a, [$FF91]
    cp a, $50
    jr nz, Jump_011_4190
    ld de, $0076
    call Func_000_181B
    jr c, Jump_011_4190
    ld de, $0070
    call Func_000_181B
    jr nc, Jump_011_4190
    jr Jump_011_4196

Jump_011_4190::
    ldh a, [$FF8C]
    and a, $7F
    ldh [$FF8C], a

Jump_011_4196::
    ld c, $00
    ret

Jump_011_4199::
    cp a, $FD
    jr z, Jump_011_419F
    jr Jump_011_41DA

Jump_011_419F::
    ld a, [de]
    inc de
    ld [$C8CA], a
    push af
    swap a
    and a, $0F
    ld c, a
    ldh a, [$FF8F]
    cp a, c
    jr nz, Jump_011_41D9
    pop af
    and a, $0F
    ld c, a
    ldh a, [$FF92]
    cp a, c
    jr nz, Jump_011_41DA
    ld a, [de]
    inc de
    ld c, a
    ldh a, [$FF8E]
    cp a, c
    jr nz, Jump_011_41DA
    ld a, [de]
    inc de
    ld c, a
    ldh a, [$FF91]
    cp a, c
    jr z, Jump_011_41CD
    add a, $F8
    cp a, c
    jr nz, Jump_011_41DA

Jump_011_41CD::
    ldh a, [$FF8C]
    bit 7, a
    jr z, Jump_011_41D7
    pop de
    ld c, $00
    ret

Jump_011_41D7::
    jr Jump_011_41E6

Jump_011_41D9::
    pop af

Jump_011_41DA::
    pop de
    ld a, e
    add a, $09
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    jp Jump_011_4152

Jump_011_41E6::
    ld a, $01
    ld [$CCEA], a
    ld a, $60
    call Func_000_1278
    ld a, [de]
    inc de
    ldh [$FF90], a
    ld a, [de]
    and a, $0F
    inc de
    ldh [$FF8F], a
    ld a, [de]
    and a, $0F
    inc de
    ldh [$FF92], a
    ld a, [de]
    inc de
    swap a
    and a, $F0
    ld [$C8C8], a
    ld a, [de]
    swap a
    and a, $F0
    ld [$C8C9], a
    dec de
    dec de
    dec de
    ld a, [de]
    bit 7, a
    jr z, Jump_011_4229
    ldh a, [$FF8C]
    or a, $40
    ldh [$FF8C], a
    ld a, [$C8C9]
    add a, $08
    ld [$C8C9], a
    jr Jump_011_4229

Jump_011_4229::
    ld a, [de]
    swap a
    and a, $03
    cp a, $03
    jr z, Jump_011_4235
    ld [$C88B], a

Jump_011_4235::
    inc de
    ld a, [de]
    swap a
    and a, $0F
    ld [$C8C6], a
    ld a, $04
    call Func_000_0DF2
    ld hl, $C5E0
    inc [hl]
    xor a, a
    ld [$C8C7], a
    ld a, $04
    ld [$C5DC], a
    xor a, a
    ld [$C8C5], a
    ldh a, [$FF8C]
    or a, $80
    ldh [$FF8C], a
    ld hl, Func_012_7B9F
    ld b, $12
    rst $10
    pop de
    xor a, a
    ld [$C562], a
    ld c, $01
    ret

Func_011_4268::
    ld a, [$CC44]
    bit 7, a
    jp nz, Jump_011_42D9
    ldh a, [$FF90]
    ld c, a
    ld b, $00
    ld hl, Func_011_42AC

Jump_011_4278::
    ld a, [hl+]
    cp a, $FF
    jr nz, Jump_011_4280
    ld c, $00
    ret

Jump_011_4280::
    cp a, c
    jr z, Jump_011_4286
    inc b
    jr Jump_011_4278

Jump_011_4286::
    ld a, b
    sla a
    add a, b
    ld de, Data_011_42B8
    add a, e
    ld e, a
    jr nc, Jump_011_4292
    inc d

Jump_011_4292::
    ld a, [de]
    inc de
    ldh [$FF90], a
    ld a, [$C88E]
    or a, a
    jr z, Jump_011_42A6
    ld a, [$C891]
    dec a
    cp a, b
    jr nz, Jump_011_42A6
    ld de, $C88F

Jump_011_42A6::
    call Func_011_4340
    ld c, $01
    ret

Func_011_42AC:: ; heuristic: follows a terminator; C0
    add hl, hl
    ld b, l
    ld l, b
    sbc a, l
    and a, h
    xor a, a
    or a, d
    push bc
    ret nc
    reti
    db $E2, $FF

Data_011_42B8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $20, $44, $00, $30, $44, $76, $48, $44, $B4, $70, $44, $B4, $A0, $44, $10, $A8
    db $44, $00, $B0, $44, $01, $B8, $44, $44, $C8, $44, $01, $D1, $44, $00, $DA, $44
    db $00

Jump_011_42D9::
    cp a, $87
    jr z, Jump_011_42E0
    ld c, $00
    ret

Jump_011_42E0::
    ld a, [$C88E]
    or a, a
    jr z, Jump_011_431E
    ld a, [$C891]
    bit 7, a
    jr z, Jump_011_431E
    and a, $7F
    ld c, a
    ld a, [$CC42]
    cp a, c
    jr nz, Jump_011_431E
    ld a, [$C88F]
    and a, $F0
    ld [$C8C8], a
    ld a, [$C88F]
    and a, $0F
    swap a
    ld [$C8C9], a
    ld a, [$C890]
    and a, $F0
    swap a
    ldh [$FF8F], a
    ld a, [$C890]
    and a, $0F
    ldh [$FF92], a
    call Func_011_438F
    ld c, $01
    ret

Jump_011_431E::
    ld a, [$CD09]
    ld [$C8C8], a
    ld a, [$CD0A]
    ld [$C8C9], a
    ld a, [$CD08]
    and a, $F0
    swap a
    ldh [$FF8F], a
    ld a, [$CD08]
    and a, $0F
    ldh [$FF92], a
    call Func_011_438F
    ld c, $01
    ret

Func_011_4340::
    ld a, $01
    ld [$CCEA], a
    ld a, $60
    call Func_000_1278
    ld a, [de]
    and a, $F0
    ld [$C8C8], a
    ld a, [de]
    swap a
    and a, $F0
    ld [$C8C9], a
    inc de
    ld a, [de]
    swap a
    and a, $0F
    ldh [$FF8F], a
    ld a, [de]
    and a, $0F
    inc de
    ldh [$FF92], a
    ld a, $01
    ld [$C8C6], a
    ld a, $04
    call Func_000_0DF2
    ld hl, $C5E0
    inc [hl]
    ld a, $04
    ld [$C5DC], a
    xor a, a
    ld [$C8C5], a
    ldh a, [$FF8C]
    or a, $20
    and a, $7F
    ldh [$FF8C], a
    ld hl, Func_012_7B9F
    ld b, $12
    rst $10
    pop de
    ld c, $01
    ret

Func_011_438F::
    ld a, $F0
    ld [$C8CA], a
    ld a, $60
    call Func_000_1278
    ld a, $04
    call Func_000_0DF2
    ld a, $04
    ld [$C5DC], a
    xor a, a
    ld [$C8C5], a
    ldh a, [$FF8C]
    or a, $20
    and a, $7F
    ldh [$FF8C], a
    ldh a, [$FF8C]
    and a, $FE
    ldh [$FF8C], a
    ld a, $01
    ld [$C8C6], a
    ret

Func_011_43BB::
    ldh a, [$FF90]
    cp a, $20
    jr c, Jump_011_43CC
    ld c, a
    ld b, $00
    ld hl, Data_011_4480

Jump_011_43C7::
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_011_43D5

Jump_011_43CC::
    ldh a, [$FF8C]
    and a, $DF
    ldh [$FF8C], a
    ld c, $00
    ret

Jump_011_43D5::
    cp a, c
    jr z, Jump_011_43DF
    inc b
    inc hl
    inc hl
    inc hl
    inc hl
    jr Jump_011_43C7

Jump_011_43DF::
    ld a, [$C88E]
    or a, a
    jr z, Jump_011_43F3
    ld a, [$C891]
    dec a
    cp a, b
    jr nz, Jump_011_43F3
    ld de, $C88F
    call Func_011_43FA
    ret

Jump_011_43F3::
    ld e, l
    ld d, h
    inc de
    call Func_011_43FA
    ret

Func_011_43FA::
    ldh a, [$FF8E]
    and a, $F0
    ld c, a
    ldh a, [$FF91]
    and a, $F0
    swap a
    or a, c
    ld c, a
    ld a, [de]
    cp a, c
    jr nz, Jump_011_4422
    ldh a, [$FF8F]
    swap a
    ld c, a
    ldh a, [$FF92]
    or a, c
    ld c, a
    inc de
    ld a, [de]
    cp a, c
    jr nz, Jump_011_4422
    ldh a, [$FF8C]
    bit 5, a
    jr z, Jump_011_442B
    ld c, $00
    ret

Jump_011_4422::
    ldh a, [$FF8C]
    and a, $DF
    ldh [$FF8C], a
    ld c, $00
    ret

Jump_011_442B::
    ld a, $01
    ld [$CCEA], a
    ld a, $60
    call Func_000_1278
    inc de
    ld a, [de]
    dec a
    ld hl, Data_011_44AD
    add a, l
    ld l, a
    jr nc, Jump_011_4440
    inc h

Jump_011_4440::
    ld a, [hl]
    ldh [$FF90], a
    xor a, a
    ldh [$FF8F], a
    ldh [$FF92], a
    ld a, $40
    ld [$C8C8], a
    ld a, $80
    ld [$C8C9], a
    xor a, a
    ld [$C88B], a
    ld a, $03
    ld [$C8C6], a
    ld a, $04
    call Func_000_0DF2
    ld hl, $C5E0
    inc [hl]
    xor a, a
    ld [$C8C7], a
    ld a, $04
    ld [$C5DC], a
    xor a, a
    ld [$C8C5], a
    ldh a, [$FF8C]
    or a, $20
    ldh [$FF8C], a
    ld hl, Func_012_7B9F
    ld b, $12
    rst $10
    ld c, $01
    ret

Data_011_4480:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $20, $44, $00, $01, $30, $44, $76, $02, $48, $44, $B4, $03, $70, $44, $B4, $04
    db $A0, $44, $10, $05, $A8, $44, $00, $06, $B0, $44, $01, $07, $B8, $44, $44, $08
    db $C8, $44, $01, $09, $D1, $44, $00, $0A, $DA, $44, $00, $0B, $FF

Data_011_44AD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $29, $45, $68, $9D, $A4, $AF, $B2, $C5, $D0, $D9, $E2
    dw Data_011_46B8
    db $FA, $46
    dw Data_011_473C
    db $7E, $47
    dw Data_011_47C0
    db $02, $48
    dw Data_011_4844
    db $86, $48
    dw Data_011_490A
    db $C8, $48
    dw Data_011_494C
    db $8E, $49
    dw Data_011_49D0
    db $12, $4A
    dw Data_011_4A54
    db $96, $4A
    dw Data_011_4AD8
    db $1A, $4B
    dw Data_011_4B5C
    db $9E, $4B
    dw Data_011_4BE0
    db $22, $4C
    dw Data_011_4C64
    db $A6, $4C
    dw Data_011_4CE8
    db $2A, $4D
    dw Data_011_4D6C
    db $AE, $4D
    dw Data_011_4DF0
    db $0E, $4E, $00, $00, $00, $00, $2C, $4E, $68, $4E
    dw Data_011_4EA4
    db $E0, $4E, $1C, $4F
    dw Data_011_4F58
    db $94, $4F, $00, $00
    dw Data_011_4FD0
    db $0C, $50, $48, $50
    dw Data_011_5084
    db $00, $00, $C0, $50
    dw Data_011_50FC
    db $38, $51, $74, $51
    dw Data_011_51A4
    db $D4, $51, $04, $52
    dw Data_011_5234
    db $64, $52, $94, $52
    dw Data_011_52C4
    db $F4, $52, $24, $53
    dw Data_011_5354
    db $84, $53, $B4, $53
    dw Data_011_53E4
    db $14, $54, $44, $54
    dw Data_011_5474
    db $A4, $54, $D4, $54
    dw Data_011_5504
    db $34, $55
    dw Data_011_500C
    db $00, $00, $00, $00
    dw Data_011_5564
    db $88, $55, $AC, $55
    dw Data_011_55D0
    db $F4, $55, $18, $56
    dw Data_011_563C
    db $60, $56, $84, $56
    dw Data_011_56A8
    db $CC, $56, $F0, $56
    dw Data_011_5714
    db $38, $57, $5C, $57
    dw Data_011_5780
    db $A4, $57, $C8, $57
    dw Data_011_57EC
    db $10, $58, $34, $58
    dw Data_011_5858
    db $7C, $58, $A0, $58
    dw Data_011_58C4
    db $E8, $58, $0C, $59
    dw Data_011_5930
    db $54, $59, $78, $59
    dw Data_011_599C
    db $C0, $59, $0C, $50, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00
    dw Data_011_5A08
    dw Data_011_5A38
    dw Data_011_5A68
    dw Data_011_5A98
    dw Data_011_5AC8
    dw Data_011_5AF8
    dw Data_011_5B28
    dw Data_011_5B58
    dw Data_011_5B88
    dw Data_011_5BB8
    dw Data_011_5BE8
    dw Data_011_5C18
    dw Data_011_5C48
    dw Data_011_5C78
    dw Data_011_5CA8
    dw Data_011_5CD8
    dw Data_011_5D08
    dw Data_011_5D38
    dw Data_011_5D68
    dw Data_011_5D98
    dw Data_011_5DC8
    dw Data_011_5DF8
    dw Data_011_5E28
    dw Data_011_5E58
    dw Data_011_5E88
    dw Data_011_5EB8
    dw Data_011_5EE8
    dw Data_011_5F18
    dw Data_011_5F48
    dw Data_011_5F78
    dw Data_011_5FA8
    dw Data_011_5FD8
    dw Data_011_6008
    dw Data_011_6038
    dw Data_011_6068
    dw Data_011_6098
    dw Data_011_60C8
    dw Data_011_60F8
    dw Data_011_6128
    dw Data_011_6158
    dw Data_011_6188
    dw Data_011_61B8
    dw Data_011_61E8
    dw Data_011_6218
    db $00, $00, $0C, $50, $00, $00, $00, $00, $78, $62, $96, $62, $B4, $62, $D2, $62
    db $0C, $50, $00, $00, $00, $00, $00, $00, $0E, $63, $26, $63
    dw Data_011_633E
    db $56, $63, $6E, $63
    dw Data_011_6386
    db $9E, $63, $0C, $50
    dw Data_011_63B6
    db $D4, $63, $0C, $50
    dw Data_011_63F2
    db $10, $64, $2E, $64
    dw Data_011_644C
    db $00, $00, $6A, $64
    dw Data_011_648E
    db $B2, $64, $D6, $64
    dw Data_011_64FA
    db $1E, $65, $42, $65
    dw Data_011_6566
    db $8A, $65, $AE, $65
    dw Data_011_65D2
    db $F6, $65, $1A, $66
    dw Data_011_500C
    db $00, $00, $00, $00
    dw Data_011_663E
    db $5C, $66, $7A, $66
    dw Data_011_667A
    db $7A, $66, $7A, $66
    dw Data_011_6698
    db $00, $00, $0C, $50
    dw Data_011_66B6
    db $D4, $66, $F2, $66
    dw Data_011_66F2
    db $F2, $66, $F2, $66
    dw Data_011_6710
    db $00, $00, $0C, $50
    dw Data_011_672E
    db $4C, $67, $6A, $67
    dw Data_011_676A
    db $6A, $67, $6A, $67
    dw Data_011_6788
    db $00, $00, $0C, $50
    ds $3A, $00

Data_011_46B8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0446B8, $54
    dw Data_011_5C54
    db $46, $78, $5C, $46
    dw Data_011_5C54
    db $46, $78, $5C, $46
    dw Data_011_5C54
    db $46, $78, $5C, $46
    dw Data_011_5C9C
    db $46, $C0, $5C, $46
    dw Data_011_5CE4
    db $46, $08, $5D, $46
    dw Data_011_5D2C
    db $46, $50, $5D, $46
    dw Data_011_5D74
    db $46, $98, $5D, $46
    dw Data_011_5D74
    db $46, $98, $5D, $46

Data_011_473C:: ; heuristic: target of a monotone pointer table; C0
    dw Data_011_7025
    db $46, $81, $40, $48, $03, $01, $31, $00, $01, $00, $00, $01, $0D, $00, $37, $CC
    dw Data_011_7360
    db $46, $69, $73, $46
    dw Data_011_7372
    db $46, $7B, $73, $46
    dw Data_011_7372
    db $46, $7B, $73, $46
    dw Data_011_7384
    db $46, $8D, $73, $46
    dw Data_011_7396
    db $46, $9F, $73, $46
    dw Data_011_73A8
    db $46, $B1, $73, $46
    dw Data_011_73BA
    db $46, $C3, $73, $46
    dw Data_011_73BA
    INCBIN "dwm2-cobi-us.gbc", $04477A, $46

Data_011_47C0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0447C0, $84

Data_011_4844:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $044844, $C6

Data_011_490A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $04490A, $42

Data_011_494C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $04494C, $84

Data_011_49D0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0449D0, $54
    dw Data_011_6822
    db $47, $3A, $68, $47
    dw Data_011_6822
    db $47, $3A, $68, $47
    dw Data_011_6822
    db $47, $3A, $68, $47
    dw Data_011_6822
    db $47, $3A, $68, $47
    dw Data_011_6852
    db $47, $6A, $68, $47
    dw Data_011_6852
    db $47, $6A, $68, $47
    dw Data_011_6852
    db $47, $6A, $68, $47
    dw Data_011_6882
    db $47, $9A, $68, $47

Data_011_4A54:: ; heuristic: target of a monotone pointer table; C0
    dw Data_011_6E1E
    INCBIN "dwm2-cobi-us.gbc", $044A56, $82

Data_011_4AD8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $044AD8, $84

Data_011_4B5C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $044B5C, $84

Data_011_4BE0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $044BE0, $84

Data_011_4C64:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $044C64, $84

Data_011_4CE8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $044CE8, $84

Data_011_4D6C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $044D6C, $84

Data_011_4DF0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $044DF0, $B4

Data_011_4EA4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $044EA4, $B4

Data_011_4F58:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $044F58, $78

Data_011_4FD0:: ; heuristic: target of a monotone pointer table; C0
    db $92, $42, $4B, $0F, $78, $4A, $01, $02, $2F, $00, $01, $00, $00, $00, $00, $00
    db $38, $CC, $FF, $45, $4B, $05, $46, $4B, $FF, $45, $4B, $05, $46, $4B, $FF, $45
    db $4B, $05, $46, $4B, $FF, $45, $4B, $05, $46, $4B, $FF, $45, $4B, $05, $46, $4B
    db $FF, $45, $4B, $05, $46, $4B, $FF, $45, $4B, $05, $46, $4B

Data_011_500C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $04500C, $78

Data_011_5084:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $045084, $78

Data_011_50FC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0450FC, $A8

Data_011_51A4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0451A4, $90

Data_011_5234:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $045234, $90

Data_011_52C4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0452C4, $90

Data_011_5354:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $045354, $90

Data_011_53E4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0453E4, $90

Data_011_5474:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $045474, $90

Data_011_5504:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $045504, $60

Data_011_5564:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $045564, $6C

Data_011_55D0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0455D0, $6C

Data_011_563C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $04563C, $6C

Data_011_56A8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0456A8, $6C

Data_011_5714:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $045714, $6C

Data_011_5780:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $045780, $6C

Data_011_57EC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0457EC, $6C

Data_011_5858:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $045858, $6C

Data_011_58C4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0458C4, $6C

Data_011_5930:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $045930, $6C

Data_011_599C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $04599C, $6C

Data_011_5A08:: ; heuristic: target of a monotone pointer table; C0
    db $91, $4C, $51, $01, $40, $50, $0C, $0C, $2D, $00, $00, $10, $00, $02, $29, $00
    db $3B, $CC, $41, $40, $50, $66, $52, $51, $41, $40, $50, $66, $52, $51, $41, $40
    db $50, $66, $52, $51, $41, $40, $50, $66, $52, $51, $41, $40, $50, $66, $52, $51

Data_011_5A38:: ; heuristic: target of a monotone pointer table; C0
    db $68, $6C, $51, $56, $70, $51, $03, $01, $31, $00, $00, $00, $00, $00, $00, $00
    db $3B, $CC, $96, $70, $51, $9F, $70, $51, $96, $70, $51, $9F, $70, $51, $96, $70
    db $51, $9F, $70, $51, $96, $70, $51, $9F, $70, $51, $96, $70, $51, $9F, $70, $51

Data_011_5A68:: ; heuristic: target of a monotone pointer table; C0
    db $89, $74, $51, $BD, $76, $51, $01, $01, $23, $00, $00, $00, $00, $00, $00, $00
    db $3B, $CC, $FD, $76, $51, $00, $77, $51, $FD, $76, $51, $00, $77, $51, $FD, $76
    db $51, $00, $77, $51, $FD, $76, $51, $00, $77, $51, $FD, $76, $51, $00, $77, $51

Data_011_5A98:: ; heuristic: target of a monotone pointer table; C0
    db $01, $40, $52, $43, $45, $52, $02, $02, $4F, $00, $00, $11, $00, $00, $00, $00
    db $3B, $CC, $83, $45, $52, $8F, $45, $52, $83, $45, $52, $8F, $45, $52, $83, $45
    db $52, $8F, $45, $52, $83, $45, $52, $8F, $45, $52, $83, $45, $52, $8F, $45, $52

Data_011_5AC8:: ; heuristic: target of a monotone pointer table; C0
    db $01, $40, $52, $43, $45, $52, $02, $02, $4F, $00, $00, $11, $00, $00, $00, $00
    db $3B, $CC, $C7, $49, $52, $D3, $49, $52, $C7, $49, $52, $D3, $49, $52, $C7, $49
    db $52, $D3, $49, $52, $C7, $49, $52, $D3, $49, $52, $C7, $49, $52, $D3, $49, $52

Data_011_5AF8:: ; heuristic: target of a monotone pointer table; C0
    db $01, $40, $52, $43, $45, $52, $02, $02, $4F, $00, $00, $11, $00, $00, $00, $00
    db $3B, $CC, $BE, $4D, $52, $CA, $4D, $52, $BE, $4D, $52, $CA, $4D, $52, $BE, $4D
    db $52, $CA, $4D, $52, $BE, $4D, $52, $CA, $4D, $52, $BE, $4D, $52, $CA, $4D, $52

Data_011_5B28:: ; heuristic: target of a monotone pointer table; C0
    db $01, $40, $52, $43, $45, $52, $02, $02, $4F, $00, $00, $11, $00, $00, $00, $00
    db $3B, $CC, $08, $52, $52, $14, $52, $52, $08, $52, $52, $14, $52, $52, $08, $52
    db $52, $14, $52, $52, $08, $52, $52, $14, $52, $52, $08, $52, $52, $14, $52, $52

Data_011_5B58:: ; heuristic: target of a monotone pointer table; C0
    db $A0, $56, $52, $B3, $5B, $52, $03, $01, $3F, $00, $00, $00, $00, $00, $00, $00
    db $3B, $CC, $F3, $5B, $52, $FC, $5B, $52, $F3, $5B, $52, $FC, $5B, $52, $F3, $5B
    db $52, $FC, $5B, $52, $F3, $5B, $52, $FC, $5B, $52, $F3, $5B, $52, $FC, $5B, $52

Data_011_5B88:: ; heuristic: target of a monotone pointer table; C0
    db $B2, $5F, $52, $10, $65, $52, $02, $02, $3D, $00, $00, $00, $00, $00, $00, $00
    db $3B, $CC, $50, $65, $52, $5C, $65, $52, $50, $65, $52, $5C, $65, $52, $50, $65
    db $52, $5C, $65, $52, $50, $65, $52, $5C, $65, $52, $50, $65, $52, $5C, $65, $52

Data_011_5BB8:: ; heuristic: target of a monotone pointer table; C0
    db $91, $6B, $52, $E3, $6F, $52, $01, $02, $45, $00, $00, $00, $00, $00, $00, $00
    db $3B, $CC, $23, $70, $52, $29, $70, $52, $23, $70, $52, $29, $70, $52, $23, $70
    db $52, $29, $70, $52, $23, $70, $52, $29, $70, $52, $23, $70, $52, $29, $70, $52

Data_011_5BE8:: ; heuristic: target of a monotone pointer table; C0
    db $84, $72, $52, $A5, $78, $52, $01, $02, $4B, $00, $00, $00, $00, $00, $00, $00
    db $3B, $CC, $E5, $78, $52, $EB, $78, $52, $E5, $78, $52, $EB, $78, $52, $E5, $78
    db $52, $EB, $78, $52, $E5, $78, $52, $EB, $78, $52, $E5, $78, $52, $EB, $78, $52

Data_011_5C18:: ; heuristic: target of a monotone pointer table; C0
    db $01, $40, $53, $CE, $42, $53, $01, $03, $1F, $00, $00, $00, $00, $00, $00, $00
    db $3B, $CC, $0E, $43, $53, $17, $43, $53, $0E, $43, $53, $17, $43, $53, $0E, $43
    db $53, $17, $43, $53, $0E, $43, $53, $17, $43, $53, $0E, $43, $53, $17, $43, $53

Data_011_5C48:: ; heuristic: target of a monotone pointer table; C0
    db $AF, $45, $53, $9A, $4B, $53, $02, $02, $45, $00, $00, $00

Data_011_5C54:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $3B, $CC, $DA, $4B, $53, $E6, $4B, $53, $DA, $4B, $53, $E6
    db $4B, $53, $DA, $4B, $53, $E6, $4B, $53, $DA, $4B, $53, $E6, $4B, $53, $DA, $4B
    db $53, $E6, $4B, $53

Data_011_5C78:: ; heuristic: target of a monotone pointer table; C0
    db $69, $52, $53, $C1, $56, $53, $01, $01, $3B, $00, $00, $00, $00, $00, $00, $00
    db $3B, $CC, $01, $57, $53, $04, $57, $53, $01, $57, $53, $04, $57, $53, $01, $57
    db $53, $04, $57, $53

Data_011_5C9C:: ; heuristic: target of a monotone pointer table; C0
    db $01, $57, $53, $04, $57, $53, $01, $57, $53, $04, $57, $53

Data_011_5CA8:: ; heuristic: target of a monotone pointer table; C0
    db $69, $52, $53, $C1, $56, $53, $01, $01, $3B, $00, $00, $00, $00, $00, $00, $00
    db $3B, $CC, $0B, $58, $53, $0E, $58, $53, $0B, $58, $53, $0E, $58, $53, $0B, $58
    db $53, $0E, $58, $53, $0B, $58, $53, $0E, $58, $53, $0B, $58, $53, $0E, $58, $53

Data_011_5CD8:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $58, $53, $E8, $5C, $53, $01, $02, $2F, $00, $00, $00

Data_011_5CE4:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $3B, $CC, $28, $5D, $53, $2E, $5D, $53, $28, $5D, $53, $2E
    db $5D, $53, $28, $5D, $53, $2E, $5D, $53, $28, $5D, $53, $2E, $5D, $53, $28, $5D
    db $53, $2E, $5D, $53

Data_011_5D08:: ; heuristic: target of a monotone pointer table; C0
    db $E9, $5F, $53, $FB, $64, $53, $03, $01, $3F, $00, $00, $00, $00, $00, $00, $00
    db $3B, $CC, $3B, $65, $53, $44, $65, $53, $3B, $65, $53, $44, $65, $53, $3B, $65
    db $53, $44, $65, $53

Data_011_5D2C:: ; heuristic: target of a monotone pointer table; C0
    db $3B, $65, $53, $44, $65, $53, $3B, $65, $53, $44, $65, $53

Data_011_5D38:: ; heuristic: target of a monotone pointer table; C0
    db $01, $40, $54, $2C, $43, $54, $01, $01, $2F, $00, $00, $12, $00, $00, $00, $00
    db $3B, $CC, $6C, $43, $54, $6F, $43, $54, $6C, $43, $54, $6F, $43, $54, $6C, $43
    db $54, $6F, $43, $54, $6C, $43, $54, $6F, $43, $54, $6C, $43, $54, $6F, $43, $54

Data_011_5D68:: ; heuristic: target of a monotone pointer table; C0
    db $01, $40, $54, $2C, $43, $54, $03, $03, $2F, $00, $00, $13

Data_011_5D74:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $3B, $CC, $63, $44, $54, $7E, $44, $54, $63, $44, $54, $7E
    db $44, $54, $63, $44, $54, $7E, $44, $54, $63, $44, $54, $7E, $44, $54, $63, $44
    db $54, $7E, $44, $54

Data_011_5D98:: ; heuristic: target of a monotone pointer table; C0
    db $01, $40, $54, $2C, $43, $54, $03, $03, $2F, $00, $00, $13, $00, $00, $00, $00
    db $3B, $CC, $C7, $4E, $54, $E2, $4E, $54, $C7, $4E, $54, $E2, $4E, $54, $C7, $4E
    db $54, $E2, $4E, $54, $C7, $4E, $54, $E2, $4E, $54, $C7, $4E, $54, $E2, $4E, $54

Data_011_5DC8:: ; heuristic: target of a monotone pointer table; C0
    db $01, $40, $54, $2C, $43, $54, $01, $01, $2F, $00, $00, $00, $00, $00, $00, $00
    db $3B, $CC, $1A, $57, $54, $1D, $57, $54, $1A, $57, $54, $1D, $57, $54, $1A, $57
    db $54, $1D, $57, $54, $1A, $57, $54, $1D, $57, $54, $1A, $57, $54, $1D, $57, $54

Data_011_5DF8:: ; heuristic: target of a monotone pointer table; C0
    db $56, $58, $54, $25, $5D, $54, $02, $02, $3F, $00, $00, $14, $00, $02, $01, $00
    db $3B, $CC, $65, $5D, $54, $71, $5D, $54, $65, $5D, $54, $71, $5D, $54, $65, $5D
    db $54, $71, $5D, $54, $65, $5D, $54, $71, $5D, $54, $65, $5D, $54, $71, $5D, $54

Data_011_5E28:: ; heuristic: target of a monotone pointer table; C0
    db $56, $58, $54, $25, $5D, $54, $02, $02, $2F, $00, $00, $14, $00, $02, $01, $00
    db $3B, $CC, $63, $62, $54, $6F, $62, $54, $63, $62, $54, $6F, $62, $54, $63, $62
    db $54, $6F, $62, $54, $63, $62, $54, $6F, $62, $54, $63, $62, $54, $6F, $62, $54

Data_011_5E58:: ; heuristic: target of a monotone pointer table; C0
    db $56, $58, $54, $25, $5D, $54, $02, $02, $2F, $00, $00, $14, $00, $02, $01, $00
    db $3B, $CC, $73, $67, $54, $7F, $67, $54, $73, $67, $54, $7F, $67, $54, $73, $67
    db $54, $7F, $67, $54, $73, $67, $54, $7F, $67, $54, $73, $67, $54, $7F, $67, $54

Data_011_5E88:: ; heuristic: target of a monotone pointer table; C0
    db $56, $58, $54, $25, $5D, $54, $02, $02, $2F, $00, $00, $14, $00, $02, $01, $00
    db $3B, $CC, $6F, $6C, $54, $7B, $6C, $54, $6F, $6C, $54, $7B, $6C, $54, $6F, $6C
    db $54, $7B, $6C, $54, $6F, $6C, $54, $7B, $6C, $54, $6F, $6C, $54, $7B, $6C, $54

Data_011_5EB8:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $69, $53, $2C, $6F, $53, $02, $02, $48, $00, $00, $00, $00, $00, $00, $00
    db $3B, $CC, $6C, $6F, $53, $78, $6F, $53, $6C, $6F, $53, $78, $6F, $53, $6C, $6F
    db $53, $78, $6F, $53, $6C, $6F, $53, $78, $6F, $53, $6C, $6F, $53, $78, $6F, $53

Data_011_5EE8:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $73, $53, $8B, $77, $53, $01, $01, $33, $00, $00, $00, $00, $00, $00, $00
    db $3B, $CC, $B5, $70, $54, $B8, $70, $54, $B5, $70, $54, $B8, $70, $54, $B5, $70
    db $54, $B8, $70, $54, $B5, $70, $54, $B8, $70, $54, $B5, $70, $54, $B8, $70, $54

Data_011_5F18:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $7B, $52, $4A, $72, $54, $03, $04, $2D, $00, $00, $15, $00, $00, $00, $00
    db $3B, $CC, $CB, $77, $53, $EF, $77, $53, $CB, $77, $53, $EF, $77, $53, $CB, $77
    db $53, $EF, $77, $53, $CB, $77, $53, $EF, $77, $53, $CB, $77, $53, $EF, $77, $53

Data_011_5F48:: ; heuristic: target of a monotone pointer table; C0
    db $01, $40, $55, $45, $76, $93, $03, $03, $4F, $00, $00, $15, $00, $00, $00, $00
    db $3B, $CC, $DC, $42, $55, $F7, $42, $55, $DC, $42, $55, $F7, $42, $55, $DC, $42
    db $55, $F7, $42, $55, $DC, $42, $55, $F7, $42, $55, $DC, $42, $55, $F7, $42, $55

Data_011_5F78:: ; heuristic: target of a monotone pointer table; C0
    db $8A, $72, $54, $6C, $76, $54, $01, $01, $2C, $00, $00, $00, $00, $00, $00, $00
    db $3B, $CC, $AC, $76, $54, $AF, $76, $54, $B2, $76, $54, $B5, $76, $54, $B2, $76
    db $54, $B5, $76, $54, $B2, $76, $54, $B5, $76, $54, $B2, $76, $54, $B5, $76, $54

Data_011_5FA8:: ; heuristic: target of a monotone pointer table; C0
    db $24, $51, $55, $85, $76, $93, $03, $03, $53, $00, $00, $15, $00, $00, $00, $00
    db $3B, $CC, $42, $57, $55, $5D, $57, $55, $42, $57, $55, $5D, $57, $55, $42, $57
    db $55, $5D, $57, $55, $78, $57, $55, $93, $57, $55, $78, $57, $55, $93, $57, $55

Data_011_5FD8:: ; heuristic: target of a monotone pointer table; C0
    db $02, $7A, $93, $28, $7F, $93, $01, $01, $2F, $00, $00, $00, $00, $00, $00, $00
    db $3B, $CC, $F2, $77, $51, $F5, $77, $51, $F2, $77, $51, $F5, $77, $51, $F8, $77
    db $51, $FB, $77, $51, $F8, $77, $51, $FB, $77, $51, $F8, $77, $51, $FB, $77, $51

Data_011_6008:: ; heuristic: target of a monotone pointer table; C0
    db $01, $40, $55, $45, $76, $93, $03, $02, $4F, $00, $00, $15, $00, $00, $00, $00
    db $3B, $CC, $FF, $4A, $55, $11, $4B, $55, $FF, $4A, $55, $11, $4B, $55, $FF, $4A
    db $55, $11, $4B, $55, $FF, $4A, $55, $11, $4B, $55, $FF, $4A, $55, $11, $4B, $55

Data_011_6038:: ; heuristic: target of a monotone pointer table; C0
    db $70, $79, $54, $58, $7D, $54, $01, $01, $3B, $00, $03, $00, $00, $00, $00, $00
    db $3B, $CC, $98, $7D, $54, $9B, $7D, $54, $98, $7D, $54, $9B, $7D, $54, $98, $7D
    db $54, $9B, $7D, $54, $98, $7D, $54, $9B, $7D, $54, $98, $7D, $54, $9B, $7D, $54

Data_011_6068:: ; heuristic: target of a monotone pointer table; C0
    db $E6, $43, $95, $C5, $76, $93, $01, $01, $17, $00, $00, $00, $00, $00, $00, $00
    db $3B, $CC, $81, $45, $95, $84, $45, $95, $81, $45, $95, $84, $45, $95, $81, $45
    db $95, $84, $45, $95, $81, $45, $95, $84, $45, $95, $81, $45, $95, $84, $45, $95

Data_011_6098:: ; heuristic: target of a monotone pointer table; C0
    db $40, $7B, $51, $55, $7E, $51, $01, $01, $24, $00, $00, $00, $00, $00, $00, $00
    db $3B, $CC, $95, $7E, $51, $98, $7E, $51, $95, $7E, $51, $98, $7E, $51, $95, $7E
    db $51, $98, $7E, $51, $95, $7E, $51, $98, $7E, $51, $95, $7E, $51, $98, $7E, $51

Data_011_60C8:: ; heuristic: target of a monotone pointer table; C0
    db $34, $65, $55, $05, $77, $93, $03, $03, $3F, $00, $04, $00, $00, $00, $00, $00
    db $3B, $CC, $70, $69, $55, $8B, $69, $55, $70, $69, $55, $8B, $69, $55, $70, $69
    db $55, $8B, $69, $55, $70, $69, $55, $8B, $69, $55, $70, $69, $55, $8B, $69, $55

Data_011_60F8:: ; heuristic: target of a monotone pointer table; C0
    db $34, $65, $55, $05, $77, $93, $02, $03, $3F, $00, $00, $00, $00, $00, $00, $00
    db $3B, $CC, $5E, $73, $55, $70, $73, $55, $5E, $73, $55, $70, $73, $55, $5E, $73
    db $55, $70, $73, $55, $5E, $73, $55, $70, $73, $55, $5E, $73, $55, $70, $73, $55

Data_011_6128:: ; heuristic: target of a monotone pointer table; C0
    db $34, $65, $55, $05, $77, $93, $02, $02, $3F, $00, $00, $00, $00, $00, $00, $00
    db $3B, $CC, $89, $79, $55, $95, $79, $55, $89, $79, $55, $95, $79, $55, $89, $79
    db $55, $95, $79, $55, $89, $79, $55, $95, $79, $55, $89, $79, $55, $95, $79, $55

Data_011_6158:: ; heuristic: target of a monotone pointer table; C0
    db $4F, $5C, $90, $1F, $60, $90, $01, $01, $3F, $00, $00, $00, $00, $02, $1F, $00
    db $3B, $CC, $5F, $60, $90, $62, $60, $90, $5F, $60, $90, $62, $60, $90, $5F, $60
    db $90, $62, $60, $90, $5F, $60, $90, $62, $60, $90, $5F, $60, $90, $62, $60, $90

Data_011_6188:: ; heuristic: target of a monotone pointer table; C0
    db $4F, $5C, $90, $1F, $60, $90, $01, $01, $3F, $00, $00, $00, $00, $02, $1F, $00
    db $3B, $CC, $65, $60, $90, $68, $60, $90, $65, $60, $90, $68, $60, $90, $65, $60
    db $90, $68, $60, $90, $65, $60, $90, $68, $60, $90, $65, $60, $90, $68, $60, $90

Data_011_61B8:: ; heuristic: target of a monotone pointer table; C0
    db $4F, $5C, $90, $1F, $60, $90, $01, $01, $3F, $00, $00, $00, $00, $02, $1F, $00
    db $3B, $CC, $6B, $60, $90, $6E, $60, $90, $6B, $60, $90, $6E, $60, $90, $6B, $60
    db $90, $6E, $60, $90, $6B, $60, $90, $6E, $60, $90, $6B, $60, $90, $6E, $60, $90

Data_011_61E8:: ; heuristic: target of a monotone pointer table; C0
    db $4F, $5C, $90, $1F, $60, $90, $01, $01, $3F, $00, $00, $00, $00, $02, $1F, $00
    db $3B, $CC, $71, $60, $90, $74, $60, $90, $71, $60, $90, $74, $60, $90, $71, $60
    db $90, $74, $60, $90, $71, $60, $90, $74, $60, $90, $71, $60, $90, $74, $60, $90

Data_011_6218:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $046218, $126

Data_011_633E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $04633E, $48

Data_011_6386:: ; heuristic: target of a monotone pointer table; C0
    db $FB, $6F, $59, $43, $72, $59, $03, $04, $3F, $00, $00, $19, $01, $00, $00, $00
    db $3D, $CC, $83, $72, $59, $A7, $72, $59, $FB, $6F, $59, $43, $72, $59, $03, $04
    db $3F, $00, $00, $19, $01, $00, $00, $00, $3D, $CC, $01, $40, $5A, $25, $40, $5A

Data_011_63B6:: ; heuristic: target of a monotone pointer table; C0
    db $C4, $49, $5A, $68, $7F, $93, $03, $02, $3F, $00, $00, $1A, $00, $00, $00, $00
    db $3E, $CC, $87, $4E, $5A, $99, $4E, $5A, $87, $4E, $5A, $99, $4E, $5A, $A2, $53
    db $5A, $B7, $57, $5A, $01, $01, $37, $00, $00, $00, $00, $00, $00, $00, $3E, $CC
    db $F7, $57, $5A, $FA, $57, $5A, $F7, $57, $5A, $FA, $57, $5A

Data_011_63F2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0463F2, $5A

Data_011_644C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $04644C, $42

Data_011_648E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $04648E, $6C

Data_011_64FA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0464FA, $6C

Data_011_6566:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $046566, $6C

Data_011_65D2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0465D2, $6C

Data_011_663E:: ; heuristic: target of a monotone pointer table; C0
    db $01, $40, $5C, $D6, $45, $5C, $01, $02, $3F, $00, $00, $00, $00, $00, $00, $00
    db $40, $CC, $0A, $77, $5B, $10, $77, $5B, $0A, $77, $5B, $10, $77, $5B, $16, $46
    db $5C, $04, $4B, $5C, $01, $02, $4F, $00, $04, $00, $00, $00, $00, $00, $40, $CC
    db $44, $4B, $5C, $4A, $4B, $5C, $44, $4B, $5C, $4A, $4B, $5C

Data_011_667A:: ; heuristic: target of a monotone pointer table; C0
    db $16, $46, $5C, $04, $4B, $5C, $01, $02, $4F, $00, $04, $00, $00, $00, $00, $00
    db $40, $CC, $35, $4D, $5C, $3B, $4D, $5C, $35, $4D, $5C, $3B, $4D, $5C

Data_011_6698:: ; heuristic: target of a monotone pointer table; C0
    db $16, $46, $5C, $04, $4B, $5C, $01, $02, $4F, $00, $04, $00, $00, $00, $00, $00
    db $40, $CC, $71, $4F, $5C, $77, $4F, $5C, $71, $4F, $5C, $77, $4F, $5C

Data_011_66B6:: ; heuristic: target of a monotone pointer table; C0
    db $BF, $51, $5C, $37, $54, $5C, $01, $02, $3F, $00, $00, $00, $00, $00, $00, $00
    db $40, $CC, $77, $54, $5C, $7D, $54, $5C, $77, $54, $5C, $7D, $54, $5C, $E3, $55
    db $5C, $DB, $5A, $5C, $01, $02, $4F, $00, $04, $00, $00, $00, $00, $00, $40, $CC
    db $44, $4B, $5C, $4A, $4B, $5C, $44, $4B, $5C, $4A, $4B, $5C

Data_011_66F2:: ; heuristic: target of a monotone pointer table; C0
    db $E3, $55, $5C, $DB, $5A, $5C, $01, $02, $4F, $00, $04, $00, $00, $00, $00, $00
    db $40, $CC, $35, $4D, $5C, $3B, $4D, $5C, $35, $4D, $5C, $3B, $4D, $5C

Data_011_6710:: ; heuristic: target of a monotone pointer table; C0
    db $E3, $55, $5C, $DB, $5A, $5C, $01, $02, $4F, $00, $04, $00, $00, $00, $00, $00
    db $40, $CC, $1B, $5B, $5C, $21, $5B, $5C, $1B, $5B, $5C, $21, $5B, $5C

Data_011_672E:: ; heuristic: target of a monotone pointer table; C0
    db $85, $5D, $5C, $CD, $60, $5C, $02, $01, $3F, $00, $00, $00, $00, $00, $00, $00
    db $40, $CC, $0D, $61, $5C, $13, $61, $5C, $0D, $61, $5C, $13, $61, $5C, $7C, $62
    db $5C, $76, $67, $5C, $01, $02, $4F, $00, $04, $00, $00, $00, $00, $00, $40, $CC
    db $44, $4B, $5C, $4A, $4B, $5C, $44, $4B, $5C, $4A, $4B, $5C

Data_011_676A:: ; heuristic: target of a monotone pointer table; C0
    db $7C, $62, $5C, $76, $67, $5C, $01, $02, $4F, $00, $04, $00, $00, $00, $00, $00
    db $40, $CC, $35, $4D, $5C, $3B, $4D, $5C, $35, $4D, $5C, $3B, $4D, $5C

Data_011_6788:: ; heuristic: target of a monotone pointer table; C0
    db $7C, $62, $5C, $76, $67, $5C, $01, $02, $4F, $00, $04, $00, $00, $00, $00, $00
    db $40, $CC
    dw Data_011_67B6
    db $5C, $BC, $67, $5C
    dw Data_011_67B6
    db $5C, $BC, $67, $5C

Data_011_67A6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_011_69A7
    db $D5, $69, $5D, $6A
    dw Data_011_6A70
    db $7A, $6A, $96, $6A
    dw Data_011_6AB2
    db $BC, $6A

Data_011_67B6:: ; heuristic: target of a monotone pointer table; C0
    db $CF, $6A
    dw Data_011_6AD9
    db $E3, $6A, $A6, $69
    dw Data_011_6AF6
    db $1B, $6B, $37, $6B
    dw Data_011_6B41
    db $5D, $6B, $67, $6B
    dw Data_011_6B71
    db $7B, $6B, $A6, $69
    dw Data_011_6B85
    db $8F, $6B, $99, $6B
    dw Data_011_6BA3
    db $C8, $6B, $DB, $6B
    dw Data_011_6BEE
    dw Data_011_69A6
    db $A6, $69, $A6, $69
    dw Data_011_69A6
    db $F8, $6B, $2F, $6C
    dw Data_011_6C54
    db $5E, $6C, $68, $6C
    dw Data_011_6CA8
    db $D6, $6C, $A6, $69
    dw Data_011_6CE0
    db $EA, $6C, $EB, $6C
    dw Data_011_6CFE
    db $A6, $69, $11, $6D
    dw Data_011_6D1B
    db $25, $6D, $6E, $6D
    dw Data_011_6DC0
    db $CA, $6D, $EF, $6D
    dw Data_011_6DF9
    db $03, $6E, $0D, $6E
    dw Data_011_6E29
    db $3C, $6E, $58, $6E
    dw Data_011_6E74
    db $87, $6E, $91, $6E
    dw Data_011_6EA4

Data_011_6822:: ; heuristic: target of a monotone pointer table; C0
    db $AE, $6E, $DC, $6E
    dw Data_011_6F2E
    db $38, $6F, $39, $6F
    dw Data_011_6F55
    db $71, $6F
    dw Data_011_6F7B
    db $A6, $69, $A6, $69
    dw Data_011_6F7C
    db $31, $70, $3B, $70
    dw Data_011_7072
    db $7C, $70, $86, $70
    dw Data_011_7090
    db $A3, $70, $BF, $70
    dw Data_011_70D2
    db $DC, $70, $13, $71
    dw Data_011_7165
    db $6F, $71

Data_011_6852:: ; heuristic: target of a monotone pointer table; C0
    db $79, $71
    dw Data_011_718C
    db $A8, $71, $CD, $71
    dw Data_011_71D7
    db $17, $72, $2A, $72
    dw Data_011_723D
    db $47, $72, $7E, $72
    dw Data_011_7288
    db $9B, $72, $A5, $72
    dw Data_011_72AF
    db $C2, $72, $14, $73
    dw Data_011_736F
    db $8B, $73, $95, $73
    dw Data_011_69A6
    dw Data_011_69A6
    dw Data_011_69A6
    dw Data_011_69A6
    dw Data_011_69A6

Data_011_6882:: ; heuristic: target of a monotone pointer table; C0
    dw Data_011_69A6
    dw Data_011_69A6
    dw Data_011_7396
    dw Data_011_7442
    dw Data_011_7467
    dw Data_011_7471
    dw Data_011_7496
    dw Data_011_74CD
    dw Data_011_74F2
    dw Data_011_74FC
    dw Data_011_750F
    dw Data_011_752B
    dw Data_011_7535
    dw Data_011_753F
    dw Data_011_7552
    dw Data_011_7577
    dw Data_011_758A
    dw Data_011_7594
    dw Data_011_759E
    dw Data_011_75B1
    dw Data_011_75C4
    dw Data_011_7616
    dw Data_011_7656
    dw Data_011_7660
    dw Data_011_767C
    dw Data_011_76A1
    dw Data_011_76C6
    dw Data_011_76D9
    dw Data_011_76EC
    dw Data_011_7708
    dw Data_011_772D
    dw Data_011_7740
    dw Data_011_775C
    dw Data_011_778A
    dw Data_011_77A6
    dw Data_011_77B9
    dw Data_011_77C3
    dw Data_011_77CD
    dw Data_011_77E9
    dw Data_011_77FC
    dw Data_011_7818
    dw Data_011_7834
    dw Data_011_7847
    dw Data_011_785A
    dw Data_011_786D
    dw Data_011_7880
    db $A6, $69, $8A, $78, $A6, $69, $A6, $69, $8B, $78, $95, $78, $A8, $78, $C4, $78
    db $CE, $78
    dw Data_011_69A6
    dw Data_011_69A6
    dw Data_011_69A6
    dw Data_011_78CF
    dw Data_011_78FD
    dw Data_011_7919
    dw Data_011_7923
    dw Data_011_792D
    dw Data_011_7937
    dw Data_011_794A
    dw Data_011_795D
    dw Data_011_795E
    dw Data_011_7968
    dw Data_011_69A6
    db $7B, $79
    dw Data_011_798E
    db $A1, $79
    dw Data_011_79BD
    db $A6, $69
    dw Data_011_79C7
    db $EC, $79
    dw Data_011_7A11
    db $1B, $7A
    dw Data_011_7A2E
    db $38, $7A
    dw Data_011_7A42
    db $55, $7A
    dw Data_011_7A68
    db $7B, $7A
    dw Data_011_7A8E
    db $A1, $7A
    dw Data_011_7AB4
    dw Data_011_69A6
    dw Data_011_69A6
    dw Data_011_69A6
    dw Data_011_7AC7
    dw Data_011_7AD1
    dw Data_011_7AE4
    dw Data_011_7AF7
    dw Data_011_7B0A
    dw Data_011_7B1D
    dw Data_011_7B30
    dw Data_011_69A6
    dw Data_011_69A6
    dw Data_011_7B3A
    dw Data_011_7B44
    dw Data_011_7B57
    dw Data_011_7B6A
    dw Data_011_7B7D
    dw Data_011_7B90
    dw Data_011_7BA3
    dw Data_011_69A6
    dw Data_011_69A6
    dw Data_011_7BAD
    dw Data_011_7BB7
    dw Data_011_7BCA
    dw Data_011_7BDD
    dw Data_011_7BF0
    dw Data_011_7C03
    dw Data_011_7C16
    db $A6, $69, $A6, $69, $A6, $69, $A6, $69, $A6, $69, $A6, $69, $A6, $69, $A6, $69
    db $A6, $69, $A6, $69, $A6, $69, $A6, $69, $A6, $69, $A6, $69, $A6, $69, $A6, $69
    db $A6, $69, $A6, $69, $A6, $69, $A6, $69, $A6, $69, $A6, $69, $A6, $69, $A6, $69
    db $A6, $69, $A6, $69, $A6, $69, $A6, $69, $A6, $69, $A6, $69, $A6, $69

Data_011_69A6:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_011_69A7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0469A7, $C9

Data_011_6A70:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $046A70, $42

Data_011_6AB2:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $00, $00, $01, $00, $80, $02, $04, $04, $80, $FD, $00, $60, $30, $00, $02
    db $11, $06, $03, $FD, $00, $50, $00, $0D, $03, $31, $05, $08, $80, $FE, $00, $00
    db $01, $01, $80, $02, $04, $04, $80

Data_011_6AD9:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $00, $00, $01, $01, $81, $01, $03, $04, $80, $FE, $00, $00, $01, $01, $82
    db $01, $05, $05, $FD, $00, $80, $40, $0D, $01, $11, $08, $04, $80

Data_011_6AF6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $046AF6, $4B

Data_011_6B41:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $40, $80, $0C, $80, $00, $02, $01, $00, $00, $20, $80, $0C, $80, $00
    db $02, $01, $00, $00, $70, $80, $0C, $80, $00, $07, $01, $80, $FE, $00, $00, $01
    db $0C, $80, $00, $07, $01, $80, $FF, $00, $00, $02, $01, $80, $01, $00, $D0, $80

Data_011_6B71:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $00, $00, $01, $0C, $80, $00, $07, $04, $80, $FE, $00, $00, $01, $01, $81
    db $01, $02, $01, $80

Data_011_6B85:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $00, $00, $01, $01, $80, $00, $05, $05, $80, $FE, $00, $00, $01, $01, $80
    db $02, $06, $01, $80, $FE, $00, $00, $01, $01, $81, $00, $03, $04, $80

Data_011_6BA3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $046BA3, $4B

Data_011_6BEE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $046BEE, $66

Data_011_6C54:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $046C54, $54

Data_011_6CA8:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $00, $00, $01, $24, $80, $00, $00, $80, $FD, $00, $40, $00, $26, $00, $00
    db $04, $08, $FD, $00, $50, $00, $26, $00, $00, $05, $08, $FD, $00, $20, $60, $2E
    db $00, $10, $02, $06, $FD, $10, $80, $30, $2D, $00, $10, $08, $03, $80, $FF, $00
    db $00, $01, $25, $80, $00, $00, $80, $80

Data_011_6CE0:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $00, $00, $02, $2F, $81, $10, $04, $03, $80, $80, $FE, $00, $00, $01, $21
    db $81, $00, $02, $02, $FD, $00, $10, $20, $2B, $11, $10, $01, $02, $80

Data_011_6CFE:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $10, $10, $20, $2A, $00, $10, $01, $02, $FE, $00, $03, $02, $24, $01, $11
    db $02, $05, $80, $FD, $00, $80, $30, $25, $01, $10, $08, $03, $80

Data_011_6D1B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $046D1B, $A5

Data_011_6DC0:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $00, $00, $02, $30, $05, $16, $04, $04, $80, $FE, $00, $00, $FF, $30, $04
    db $12, $04, $04, $FE, $00, $02, $00, $30, $04, $12, $04, $04, $FD, $10, $40, $10
    db $33, $00, $01, $04, $08, $FD, $11, $40, $20, $34, $00, $00, $04, $08, $80, $FE
    db $00, $00, $02, $32, $81, $00, $04, $01, $80

Data_011_6DF9:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $00, $00, $01, $32, $81, $01, $04, $02, $80, $FE, $00, $01, $04, $30, $00
    db $13, $04, $04, $80, $FD, $00, $40, $20, $37, $02, $30, $04, $08, $FD, $00, $50
    db $20, $37, $02, $30, $04

Data_011_6E1E:: ; heuristic: target of a monotone pointer table; C0
    db $08, $FE, $00, $00, $01, $30, $05, $15, $04, $05, $80

Data_011_6E29:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $046E29, $4B

Data_011_6E74:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $00, $01, $03, $3B, $80, $00, $00, $80, $FD, $21, $40, $40, $39, $00, $12
    db $04, $04, $80, $FF, $00, $00, $FF, $3A, $01, $02, $00, $80, $80, $FE, $00, $01
    db $01, $30, $02, $14, $04, $04, $FD, $10, $70, $20, $3D, $00, $30, $07, $08, $80

Data_011_6EA4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $046EA4, $8A

Data_011_6F2E:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $01, $40, $40, $3F, $01, $11, $04, $04, $80, $80, $FD, $20, $20, $50, $37
    db $02, $10, $02, $05, $FD, $00, $80, $10, $43, $00, $10, $08, $02, $FD, $00, $50
    db $40, $43, $00, $10, $05, $04, $80

Data_011_6F55:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $00, $80, $20, $42, $00, $10, $08, $01, $FD, $00, $50, $40, $42, $00, $10
    db $05, $04, $FD, $20, $40, $40, $44, $00, $30, $04, $08, $80, $FE, $00, $00, $01
    db $43, $82, $10, $04, $04, $80

Data_011_6F7B:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_011_6F7C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $046F7C, $A9

Data_011_7025:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $047025, $4D

Data_011_7072:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $00, $00, $01, $4A, $81, $10, $07, $04, $80, $FF, $00, $00, $02, $4A, $80
    db $10, $00, $80, $80, $FD, $00, $60, $20, $4C, $00, $10, $06, $01, $80

Data_011_7090:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $047090, $42

Data_011_70D2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0470D2, $93

Data_011_7165:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $00, $20, $40, $53, $30, $12, $02, $04, $80, $FD, $10, $60, $30, $53, $33
    db $11, $06, $03, $80, $FD, $02, $70, $20, $53, $31, $11, $07, $02, $FD, $00, $40
    db $70, $57, $31, $10, $04, $07, $80

Data_011_718C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $04718C, $4B

Data_011_71D7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0471D7, $66

Data_011_723D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $04723D, $4B

Data_011_7288:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $00, $00, $03, $5E, $81, $00, $00, $80, $FD, $01, $80, $60, $61, $00, $11
    db $08, $06, $80, $FD, $01, $80, $60, $60, $00, $11, $08, $06, $80, $FE, $00, $01
    db $04, $48, $0A, $15, $04, $04, $80

Data_011_72AF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0472AF, $B1

Data_011_7360:: ; heuristic: target of a monotone pointer table; C0
    db $66, $00, $10, $01, $02, $FD, $01, $10, $60, $66, $00, $11, $01, $06, $80

Data_011_736F:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $00, $10

Data_011_7372:: ; heuristic: target of a monotone pointer table; C0
    db $20, $65, $00, $10, $01, $02, $FD, $01, $10, $60, $65, $00, $11, $01, $06, $FD
    db $10, $40

Data_011_7384:: ; heuristic: target of a monotone pointer table; C0
    db $40, $67, $00, $10, $04, $04, $80, $FD, $00, $40, $40, $66, $01, $10, $04, $04
    db $80, $80

Data_011_7396:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $B1, $40, $40, $71, $01, $30, $04, $08, $FD, $A4, $40, $40, $77, $12, $30
    db $04, $08

Data_011_73A8:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $94, $40, $40, $77, $20, $30, $04, $08, $FD, $56, $40, $40, $78, $00, $31
    db $04, $08

Data_011_73BA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0473BA, $88

Data_011_7442:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $00, $00, $01, $70, $0B, $11, $04, $04, $FE, $00, $01, $01, $70, $0B, $11
    db $04, $04, $FD, $20, $20, $20, $72, $00, $30, $03, $08, $FE, $00, $01, $FF, $89
    db $00, $31, $04, $08, $80

Data_011_7467:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $00, $00, $01, $71, $82, $10, $02, $02, $80

Data_011_7471:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $00, $00, $02, $89, $00, $11, $05, $06, $FD, $00, $40, $40, $74, $00, $10
    db $04, $04, $FD, $01, $60, $20, $74, $00, $11, $06, $02, $FD, $11, $50, $50, $74
    db $01, $11, $05, $05, $80

Data_011_7496:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $00, $40, $40, $73, $00, $10, $04, $04, $FD, $01, $60, $20, $73, $00, $11
    db $06, $02, $FD, $11, $50, $50, $73, $01, $11, $05, $05, $FD, $10, $50, $40, $75
    db $01, $10, $05, $04, $FD, $01, $40, $50, $75, $00, $11, $04, $05, $FD, $11, $30
    db $20, $75, $01, $11, $03, $02, $80

Data_011_74CD:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $10, $50, $40, $74, $01, $10, $05, $04, $FD, $01, $40, $50, $74, $00, $11
    db $04, $05, $FD, $11, $30, $20, $74, $01, $11, $03, $02, $FD, $01, $40, $20, $76
    db $00, $11, $04, $02, $80

Data_011_74F2:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $01, $40, $20, $75, $00, $11, $04, $02, $80

Data_011_74FC:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $00, $02, $01, $70, $0A, $14, $04, $04, $FE, $00, $00, $01, $70, $09, $14
    db $04, $04, $80

Data_011_750F:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $00, $00, $02, $70, $05, $16, $04, $04, $FE, $00, $02, $01, $70, $05, $16
    db $04, $04, $FD, $11, $60, $30, $79, $00, $11, $06, $03, $80

Data_011_752B:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $01, $60, $30, $78, $01, $11, $06, $03, $80

Data_011_7535:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $00, $00, $02, $70, $00, $14, $04, $04, $80

Data_011_753F:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $00, $40, $40, $70, $03, $16, $04, $04, $FD, $02, $40, $40, $70, $03, $17
    db $04, $04, $80

Data_011_7552:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $00, $01, $02, $70, $05, $19, $04, $04, $FD, $11, $20, $40, $7D, $00, $30
    db $02, $08, $FD, $00, $40, $40, $7F, $00, $31, $04, $08, $FD, $00, $50, $40, $7F
    db $00, $31, $05, $08, $80

Data_011_7577:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $00, $00, $01, $7C, $81, $11, $02, $04, $FD, $00, $10, $60, $7E, $00, $10
    db $01, $06, $80

Data_011_758A:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $00, $10, $60, $7D, $00, $10, $01, $06, $80

Data_011_7594:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $00, $00, $02, $7C, $80, $10, $00, $C0, $80

Data_011_759E:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $00, $00, $01, $70, $08, $19, $04, $04, $FE, $00, $02, $01, $70, $09, $19
    db $04, $04, $80

Data_011_75B1:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $00, $40, $40, $70, $05, $1B, $04, $04, $FD, $00, $40, $20, $82, $01, $32
    db $04, $08, $80

Data_011_75C4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0475C4, $52

Data_011_7616:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $00, $60, $60, $82, $00, $10, $06, $06, $FD, $10, $30, $60, $82, $01, $10
    db $03, $06, $FD, $20, $40, $60, $82, $02, $10, $04, $06, $FD, $01, $70, $20, $82
    db $00, $11, $07, $02, $FD, $01, $40, $60, $82, $00, $11, $04, $06, $FD, $21, $20
    db $20, $82, $02, $11, $02, $02, $FD, $22, $70, $60, $82, $02, $12, $07, $06, $80

Data_011_7656:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $00, $20, $50, $82, $00, $12, $02, $05, $80

Data_011_7660:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $00, $00, $02, $70, $01, $1B, $04, $04, $FD, $00, $20, $30, $86, $00, $10
    db $02, $03, $FD, $10, $80, $50, $86, $01, $10, $08, $05, $80

Data_011_767C:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $00, $20, $30, $85, $00, $10, $02, $03, $FD, $10, $80, $50, $85, $01, $10
    db $08, $05, $FD, $10, $60, $20, $87, $01, $10, $06, $02, $FD, $10, $80, $30, $87
    db $01, $10, $08, $03, $80

Data_011_76A1:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $10, $60, $20, $86, $01, $10, $06, $02, $FD, $10, $80, $30, $86, $01, $10
    db $08, $03, $FD, $10, $80, $50, $88, $01, $10, $08, $05, $FD, $01, $20, $60, $88
    db $00, $11, $02, $06, $80

Data_011_76C6:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $10, $80, $50, $87, $01, $10, $08, $05, $FD, $01, $20, $60, $87, $00, $11
    db $02, $06, $80

Data_011_76D9:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $00, $00, $02, $71, $01, $10, $04, $00, $FD, $01, $50, $50, $73, $00, $31
    db $05, $08, $80

Data_011_76EC:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $00, $00, $01, $70, $0B, $1A, $04, $04, $FD, $00, $40, $40, $8B, $01, $33
    db $04, $08, $FD, $00, $50, $40, $8B, $01, $33, $05, $08, $80

Data_011_7708:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $00, $01, $04, $8A, $80, $10, $00, $C0, $FD, $01, $20, $60, $8C, $00, $11
    db $02, $06, $FD, $21, $70, $60, $8C, $02, $11, $07, $06, $FD, $21, $60, $10, $8D
    db $00, $30, $04, $08, $80

Data_011_772D:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $01, $20, $60, $8B, $00, $11, $02, $06, $FD, $21, $70, $60, $8B, $02, $11
    db $07, $06, $80

Data_011_7740:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $00, $00, $01, $8B, $82, $11, $06, $01, $FD, $00, $40, $10, $8E, $02, $32
    db $04, $08, $FD, $00, $50, $10, $8E, $02, $32, $05, $08, $80

Data_011_775C:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $00, $02, $03, $8D, $80, $10, $00, $90, $FD, $00, $10, $10, $8F, $00, $10
    db $01, $07, $FD, $10, $50, $60, $90, $01, $11, $05, $06, $FD, $10, $40, $10, $91
    db $00, $30, $04, $08, $FD, $10, $50, $10, $91, $00, $30, $05, $08, $80

Data_011_778A:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $00, $10, $70, $8E, $00, $10, $01, $01, $FD, $00, $10, $00, $90, $00, $31
    db $01, $08, $FD, $00, $20, $00, $90, $00, $31, $02, $08, $80

Data_011_77A6:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $00, $00, $02, $8F, $80, $10, $00, $80, $FD, $11, $50, $60, $8E, $01, $10
    db $05, $06, $80

Data_011_77B9:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $00, $00, $01, $8E, $81, $10, $00, $90, $80

Data_011_77C3:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $00, $00, $01, $70, $05, $12, $04, $04, $80

Data_011_77CD:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $00, $00, $01, $70, $04, $11, $04, $04, $FD, $00, $40, $20, $94, $00, $32
    db $04, $08, $FD, $00, $50, $20, $94, $00, $32, $05, $08, $80

Data_011_77E9:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $00, $00, $03, $93, $80, $10, $00, $A0, $FD, $10, $40, $40, $95, $00, $10
    db $04, $04, $80

Data_011_77FC:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $00, $40, $40, $94, $01, $10, $04, $04, $FD, $01, $40, $40, $96, $00, $11
    db $04, $04, $FD, $11, $40, $40, $96, $01, $11, $04, $04, $80

Data_011_7818:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $01, $40, $40, $95, $00, $11, $04, $04, $FD, $11, $40, $40, $95, $01, $11
    db $04, $04, $FD, $01, $10, $70, $97, $00, $10, $01, $07, $80

Data_011_7834:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $00, $10, $70, $96, $00, $11, $01, $07, $FD, $00, $80, $70, $98, $00, $10
    db $08, $07, $80

Data_011_7847:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $00, $80, $70, $97, $00, $10, $08, $07, $FD, $00, $80, $10, $99, $00, $10
    db $08, $01, $80

Data_011_785A:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $00, $80, $10, $98, $00, $10, $08, $01, $FD, $00, $10, $10, $9A, $00, $10
    db $01, $01, $80

Data_011_786D:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $00, $10, $10, $99, $00, $10, $01, $01, $FD, $00, $10, $70, $9B, $00, $12
    db $01, $07, $80

Data_011_7880:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $047880, $4F

Data_011_78CF:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $24, $40, $40, $A9, $00, $31, $04, $08, $FD, $24, $50, $40, $A9, $00, $31
    db $04, $08, $FD, $11, $40, $40, $AA, $00, $31, $04, $08, $FD, $43, $40, $40, $AB
    db $00, $30, $04, $08, $FD, $51, $40, $40, $AD, $01, $33, $04, $08, $80

Data_011_78FD:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $01, $00, $02, $A8, $02, $14, $04, $04, $FE, $10, $02, $00, $A8, $02, $14
    db $04, $04, $FE, $11, $01, $02, $A8, $02, $14, $04, $04, $80

Data_011_7919:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $01, $00, $02, $A8, $01, $11, $04, $04, $80

Data_011_7923:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $00, $00, $01, $A8, $04, $13, $04, $04, $80

Data_011_792D:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $00, $00, $01, $AE, $01, $00, $04, $00, $80

Data_011_7937:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $00, $01, $04, $A8, $05, $11, $04, $04, $FF, $00, $02, $FF, $AE, $02, $03
    db $00, $80, $80

Data_011_794A:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $00, $01, $FF, $AC, $00, $30, $04, $08, $FF, $00, $02, $04, $AD, $02, $00
    db $00, $80, $80

Data_011_795D:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_011_795E:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $10, $40, $40, $B1, $00, $30, $04, $08, $80

Data_011_7968:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $00, $00, $01, $B0, $01, $10, $04, $04, $FD, $00, $10, $30, $B3, $00, $11
    db $01, $03, $80, $FD, $01, $10, $30, $B1, $00, $10, $01, $03, $FD, $11, $50, $40
    db $B4, $01, $11, $05, $04, $80

Data_011_798E:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $11, $50, $40, $B3, $01, $11, $05, $04, $FD, $01, $20, $50, $B5, $00, $11
    db $02, $05, $80, $FD, $01, $20, $50, $B4, $00, $11, $02, $05, $FD, $11, $40, $00
    db $B6, $00, $30, $04, $08, $FD, $11, $50, $00, $B6, $00, $30, $04, $08, $80

Data_011_79BD:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $00, $00, $01, $B5, $81, $11, $00, $80, $80

Data_011_79C7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0479C7, $4A

Data_011_7A11:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $00, $00, $02, $B8, $01, $11, $03, $05, $80, $FE, $01, $00, $02, $B8, $04
    db $10, $04, $04, $FD, $00, $40, $00, $BE, $00, $00, $04, $08, $80

Data_011_7A2E:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $00, $00, $01, $B9, $81, $11, $05, $02, $80, $FD, $00, $50, $70, $C4, $00
    db $10, $05, $07, $80

Data_011_7A42:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $00, $00, $01, $BB, $80, $00, $04, $00, $FD, $00, $40, $30, $BF, $00, $10
    db $04, $03, $80, $FD, $00, $40, $30, $BE, $00, $10, $04, $03, $FD, $11, $50, $50
    db $C0, $01, $11, $05, $05, $80

Data_011_7A68:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $11, $50, $50, $BF, $01, $11, $05, $05, $FD, $10, $70, $20, $C1, $01, $10
    db $07, $02, $80, $FD, $10, $70, $20, $C0, $01, $10, $07, $02, $FD, $00, $70, $20
    db $C2, $00, $10, $07, $02, $80

Data_011_7A8E:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $00, $70, $20, $C1, $00, $10, $07, $02, $FD, $10, $40, $50, $C3, $01, $10
    db $04, $05, $80, $FD, $10, $40, $50, $C2, $01, $10, $04, $05, $FD, $00, $70, $20
    db $C4, $00, $10, $07, $02, $80

Data_011_7AB4:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $00, $70, $20, $C3, $00, $10, $07, $02, $FD, $00, $50, $70, $BD, $00, $10
    db $05, $07, $80

Data_011_7AC7:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $00, $40, $40, $C9, $00, $31, $04, $08, $80

Data_011_7AD1:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $00, $00, $02, $C8, $00, $10, $04, $04, $FD, $00, $40, $50, $CA, $00, $11
    db $04, $05, $80

; LZSS-compressed asset: 273 bytes expand to 509 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_011_7AE4:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $01, $40, $50, $C9, $00, $10, $04, $05, $FD, $00, $40, $50, $CB, $00, $11
    db $04, $05, $80

; LZSS-compressed asset: 265 bytes expand to 509 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_011_7AF7:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $01, $40, $50, $CA, $00, $10, $04, $05, $FD, $00, $40, $50, $CC, $00, $11
    db $04, $05, $80

; LZSS-compressed asset: 274 bytes expand to 509 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_011_7B0A:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $01, $40, $50, $CB, $00, $10, $04, $05, $FD, $00, $40, $50, $CD, $00, $11
    db $04, $05, $80

; LZSS-compressed asset: 286 bytes expand to 509 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_011_7B1D:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $01, $40, $50, $CC, $00, $10, $04, $05, $FD, $00, $40, $50, $CE, $00, $11
    db $04, $05, $80

; LZSS-compressed asset: 315 bytes expand to 509 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_011_7B30:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $01, $40, $50, $CD, $00, $10, $04, $05, $80

Data_011_7B3A:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $01, $40, $40, $D2, $00, $31, $04, $08, $80

Data_011_7B44:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $00, $00, $02, $D1, $00, $11, $04, $04, $FD, $00, $40, $50, $D3, $00, $11
    db $04, $05, $80

; LZSS-compressed asset: 325 bytes expand to 509 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_011_7B57:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $01, $40, $50, $D2, $00, $10, $04, $05, $FD, $00, $40, $50, $D4, $00, $11
    db $04, $05, $80

; LZSS-compressed asset: 334 bytes expand to 509 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_011_7B6A:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $01, $40, $50, $D3, $00, $10, $04, $05, $FD, $00, $40, $50, $D5, $00, $11
    db $04, $05, $80

; LZSS-compressed asset: 345 bytes expand to 509 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_011_7B7D:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $01, $40, $50, $D4, $00, $10, $04, $05, $FD, $00, $40, $50, $D6, $00, $11
    db $04, $05, $80

; LZSS-compressed asset: 358 bytes expand to 509 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_011_7B90:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $01, $40, $50, $D5, $00, $10, $04, $05, $FD, $00, $40, $50, $D7, $00, $11
    db $04, $05, $80

; LZSS-compressed asset: 373 bytes expand to 509 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_011_7BA3:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $01, $40, $50, $D6, $00, $10, $04, $05, $80

Data_011_7BAD:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $10, $40, $40, $DB, $00, $31, $04, $08, $80

Data_011_7BB7:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $00, $00, $02, $DA, $01, $10, $04, $04, $FD, $00, $40, $50, $DC, $00, $11
    db $04, $05, $80

; LZSS-compressed asset: 410 bytes expand to 509 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_011_7BCA:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $01, $40, $50, $DB, $00, $10, $04, $05, $FD, $00, $40, $50, $DD, $00, $11
    db $04, $05, $80

; LZSS-compressed asset: 437 bytes expand to 509 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_011_7BDD:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $01, $40, $50, $DC, $00, $10, $04, $05, $FD, $00, $40, $50, $DE, $00, $11
    db $04, $05, $80

; LZSS-compressed asset: 466 bytes expand to 509 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_011_7BF0:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $01, $40, $50, $DD, $00, $10, $04, $05, $FD, $00, $40, $50, $DF, $00, $11
    db $04, $05, $80

; LZSS-compressed asset: 496 bytes expand to 509 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_011_7C03:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $01, $40, $50, $DE, $00, $10, $04, $05, $FD, $00, $40, $50, $E0, $00, $11
    db $04, $05, $80

; LZSS-compressed asset: 512 bytes expand to 509 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_011_7C16:: ; heuristic: target of a monotone pointer table; C0
    db $FD, $01, $40, $50, $DF, $00, $10, $04, $05, $80
    ds $3E0, $00
