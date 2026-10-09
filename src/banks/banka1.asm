SECTION "Bank A1", ROMX[$4000], BANK[$A1]
    db $A1

Func_0A1_4001:: ; heuristic: follows a terminator; C0
    ld hl, $D8FF
    jr Jump_0A1_402E
    db $21, $0F, $D9, $18, $23, $21, $CF, $D8, $18, $1E, $21, $EF, $D8, $18, $19, $21
    db $BF, $D8, $18, $14, $21, $DF, $D8, $18, $0F, $21, $1F, $D9, $18, $0A, $21, $53
    db $DA, $85, $6F, $30, $01, $24, $7E, $C9

Jump_0A1_402E::
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A1_4034
    inc h

Jump_0A1_4034::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ret

Func_0A1_4038:: ; heuristic: follows a terminator; C0
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A1_403E
    inc h

Jump_0A1_403E::
    ret

Func_0A1_403F:: ; heuristic: follows a terminator; C0
    ld a, [$C58A]
    cp a, $01
    jr nz, Jump_0A1_4054
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_0A1_4054
    ld a, [$D8A4]
    cp a, $04
    ccf
    ret

Jump_0A1_4054::
    ld a, [$D8A4]
    cp a, $04
    ret

Func_0A1_405A:: ; heuristic: follows a terminator; C0
    ld a, [$C58A]
    cp a, $01
    jr nz, Jump_0A1_406F
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_0A1_406F
    ld a, [$D8A5]
    cp a, $04
    ccf
    ret

Jump_0A1_406F::
    ld a, [$D8A5]
    cp a, $04
    ret
    INCBIN "dwm2-cobi-us.gbc", $284075, $CA

Func_0A1_413F::
    ld a, [$C52B]
    or a, a
    ret nz
    ld a, [$CFCA]
    rst $00
    dw Jump_0A1_4156
    dw Jump_0A1_418A
    dw Jump_0A1_41C3
    dw Jump_0A1_41CA
    dw Jump_0A1_41F4
    dw Jump_0A1_4270
    dw Jump_0A1_4305

Jump_0A1_4156::
    xor a, a
    ld [$C594], a
    xor a, a
    ld [$D8A4], a
    ld bc, $0304
    ld hl, $DA5F

Jump_0A1_4164::
    ld a, [hl]
    ld e, $FF
    cp a, $FF
    jr z, Jump_0A1_417F
    ld e, $03
    cp a, $FE
    jr z, Jump_0A1_417F
    cp a, $FD
    jr z, Jump_0A1_417F
    ld e, $03
    ld a, c
    call Func_000_3E54
    jr c, Jump_0A1_417F
    ld e, $01

Jump_0A1_417F::
    ld [hl], e
    inc hl
    inc c
    dec b
    jr nz, Jump_0A1_4164
    ld hl, $CFCA
    inc [hl]
    ret

Jump_0A1_418A::
    call Func_000_3EDE
    ld a, [$D8A4]
    cp a, $08
    jr z, Jump_0A1_41BC
    ld e, a
    ld hl, $DA5B
    add a, l
    ld l, a
    jr nc, Jump_0A1_419D
    inc h

Jump_0A1_419D::
    ld a, [hl]
    cp a, $01
    jr z, Jump_0A1_41A9

Jump_0A1_41A2::
    inc e
    ld a, e
    ld [$D8A4], a
    jr Jump_0A1_41C2

Jump_0A1_41A9::
    ld a, e
    call Func_000_3E54
    jr c, Jump_0A1_41A2
    ld [$D8A4], a
    ld hl, $CFCA
    inc [hl]
    xor a, a
    ld [$CFCB], a
    jr Jump_0A1_41C2

Jump_0A1_41BC::
    ld hl, $CFCA
    inc [hl]
    inc [hl]
    inc [hl]

Jump_0A1_41C2::
    ret

Jump_0A1_41C3::
    ld hl, Func_030_43C4
    ld b, $30
    rst $10
    ret

Jump_0A1_41CA::
    ld hl, Func_039_4001
    ld b, $39
    rst $10
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A1_41DC
    inc h

Jump_0A1_41DC::
    ld d, [hl]
    ld a, [$D8A4]
    ld hl, $DA5B
    add a, l
    ld l, a
    jr nc, Jump_0A1_41E8
    inc h

Jump_0A1_41E8::
    ld [hl], $02
    ld a, $01
    ld [$CFCA], a
    ld hl, $D8A4
    inc [hl]
    ret

Jump_0A1_41F4::
    ld hl, $D895
    ld bc, $0009
    ld a, $FF
    call Func_000_0949
    ld hl, $D868
    ld bc, $0009
    ld a, $FF
    call Func_000_0949
    ld hl, $D87D
    ld bc, $0012
    ld a, $00
    call Func_000_0949
    xor a, a
    ld [$D89E], a
    ld [$D871], a
    ld hl, $D87D
    ld a, l
    ld [$D87A], a
    ld a, h
    ld [$D87B], a
    ld de, $0800

Jump_0A1_422A::
    ld a, e
    call Func_000_3E54
    jr c, Jump_0A1_4266
    ld a, e
    ld hl, $DA5B
    add a, l
    ld l, a
    jr nc, Jump_0A1_4239
    inc h

Jump_0A1_4239::
    ld a, [hl]
    cp a, $02
    jr nz, Jump_0A1_4266
    ld a, e
    call Func_0A1_437D
    call Func_0A1_43A1
    ld hl, $D87A
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, [$D871]
    ld hl, $D868
    add a, l
    ld l, a
    jr nc, Jump_0A1_4259
    inc h

Jump_0A1_4259::
    ld [hl], e
    ld hl, $D871
    inc [hl]
    ld hl, $D87A
    inc [hl]
    ld hl, $D87A
    inc [hl]

Jump_0A1_4266::
    inc e
    dec d
    jp nz, Jump_0A1_422A
    ld hl, $CFCA
    inc [hl]
    ret

Jump_0A1_4270::
    ld d, $08

Jump_0A1_4272::
    ld hl, $D87D
    ld a, l
    ld [$D87A], a
    ld a, h
    ld [$D87B], a
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld hl, $D87F
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld e, $00

Jump_0A1_4288::
    call Func_000_3E7A
    jr c, Jump_0A1_42C2
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    ld a, c
    ld [$D874], a
    ld a, b
    ld [$D875], a
    ld a, [$D87A]
    ld l, a
    ld a, [$D87B]
    ld h, a
    ld a, [$D872]
    ld [hl+], a
    ld a, [$D873]
    ld [hl+], a
    ld a, [$D874]
    ld [hl+], a
    ld a, [$D875]
    ld [hl], a
    ld a, e
    ld hl, $D868
    add a, l
    ld l, a
    jr nc, Jump_0A1_42BE
    inc h

Jump_0A1_42BE::
    ld a, [hl+]
    ld b, [hl]
    ld [hl-], a
    ld [hl], b

Jump_0A1_42C2::
    inc e
    ld a, e
    cp a, d
    jr z, Jump_0A1_42DB
    ld hl, $D87A
    inc [hl]
    ld hl, $D87A
    inc [hl]
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    inc hl
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    jr Jump_0A1_4288

Jump_0A1_42DB::
    dec d
    jr nz, Jump_0A1_4272
    ld a, [$D89E]
    ld de, $D895
    add a, e
    ld e, a
    jr nc, Jump_0A1_42E9
    inc d

Jump_0A1_42E9::
    ld a, [$D89E]
    ld hl, $D868
    ld b, $09

Jump_0A1_42F1::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_0A1_42FB
    ld [de], a
    inc de
    dec b
    jr nz, Jump_0A1_42F1

Jump_0A1_42FB::
    ld a, $00
    ld [$D89E], a
    ld hl, $CFCA
    inc [hl]
    ret

Jump_0A1_4305::
    ld hl, $D8BF
    ld bc, $0000
    call Func_0A1_434F
    call Func_0A1_434F
    call Func_0A1_434F
    ld a, c
    ld [$D2C8], a
    ld a, b
    ld [$D2C9], a
    ld hl, $D8CF
    ld bc, $0000
    call Func_0A1_434F
    call Func_0A1_434F
    call Func_0A1_434F
    ld a, c
    ld [$D2CA], a
    ld a, b
    ld [$D2CB], a
    ld hl, $CFC9
    inc [hl]
    xor a, a
    ld [$CFCA], a
    xor a, a
    ld hl, $CFCB
    ld bc, $0005
    call Func_000_0949
    ld hl, Func_0A3_4187
    ld b, $A3
    rst $10
    call Func_0A1_4356
    ret

Func_0A1_434F::
    ld a, [hl+]
    add a, c
    ld c, a
    ld a, [hl+]
    adc a, b
    ld b, a
    ret

Func_0A1_4356::
    ld c, $00
    ld b, $08

Jump_0A1_435A::
    ld a, c
    call Func_000_3E54
    jr c, Jump_0A1_4378
    ld a, c
    add a, a
    ld hl, $DA1C
    add a, l
    ld l, a
    jr nc, Jump_0A1_436A
    inc h

Jump_0A1_436A::
    ld a, [hl]
    cp a, $6E
    jr nz, Jump_0A1_4378
    ld a, c
    ld hl, $D812
    call Func_000_3F25
    set 2, [hl]

Jump_0A1_4378::
    inc c
    dec b
    jr nz, Jump_0A1_435A
    ret

Func_0A1_437D::
    push de
    call Func_000_3EDE
    ld a, e
    ld hl, $D91F
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A1_438B
    inc h

Jump_0A1_438B::
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    push bc
    ld a, $03
    call Func_000_16AA
    ld a, $0A
    call Func_000_16E2
    pop bc
    call Func_000_3E98
    ld c, e
    ld b, d
    pop de
    ret

Func_0A1_43A1::
    push de
    ld a, e
    ld hl, $DA1C
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A1_43AC
    inc h

Jump_0A1_43AC::
    ld a, [hl]
    cp a, $62
    jr z, Jump_0A1_4413
    cp a, $69
    jr z, Jump_0A1_441D
    cp a, $D8
    jr z, Jump_0A1_4413
    push af
    push bc
    push de
    push hl
    ld [$CFEC], a
    xor a, a
    ld [$CFED], a
    ld a, [$D868]
    ld l, a
    ld a, [$D869]
    ld h, a
    push hl
    ld a, [$D86A]
    ld l, a
    ld a, [$D86B]
    ld h, a
    push hl
    ld a, $05
    ld [$D868], a
    ld a, $01
    ld [$D869], a
    ld hl, $CFF3
    ld a, l
    ld [$D86A], a
    ld a, h
    ld [$D86B], a
    ld hl, Func_01A_4022
    ld b, $1A
    rst $10
    pop hl
    ld a, l
    ld [$D86A], a
    ld a, h
    ld [$D86B], a
    pop hl
    ld a, l
    ld [$D868], a
    ld a, h
    ld [$D869], a
    pop hl
    pop de
    pop bc
    pop af
    ld a, [$CFF3]
    bit 2, a
    jr nz, Jump_0A1_4418
    ld hl, $000A
    jr Jump_0A1_4430

Jump_0A1_4413::
    ld hl, $0BB8
    jr Jump_0A1_4430

Jump_0A1_4418::
    ld hl, $07D0
    jr Jump_0A1_4430

Jump_0A1_441D::
    call Func_000_3EDE
    ld a, [$C5E7]
    ld b, a
    ld a, $09
    call Func_000_16BF
    add a, $01
    ld c, a
    ld b, $00
    jr Jump_0A1_4433

Jump_0A1_4430::
    add hl, bc
    ld c, l
    ld b, h

Jump_0A1_4433::
    pop de
    ret

Func_0A1_4435::
    ld a, [$CC44]
    bit 7, a
    ret z
    cp a, $80
    ret nz
    ldh a, [$FF92]
    and a, $FC
    ld hl, $CE93
    add a, l
    ld l, a
    jr nc, Jump_0A1_444A
    inc h

Jump_0A1_444A::
    ldh a, [$FF8F]
    srl a
    and a, $FE
    add a, l
    ld l, a
    jr nc, Jump_0A1_4455
    inc h

Jump_0A1_4455::
    ldh a, [$FF92]
    bit 1, a
    jr z, Jump_0A1_445C
    inc hl

Jump_0A1_445C::
    ld c, $01
    bit 0, a
    jr z, Jump_0A1_4464
    ld c, $10

Jump_0A1_4464::
    ldh a, [$FF8F]
    and a, $03
    jr z, Jump_0A1_4470
    ld b, a

Jump_0A1_446B::
    sla c
    dec b
    jr nz, Jump_0A1_446B

Jump_0A1_4470::
    ld a, [hl]
    or a, c
    ld [hl], a
    ret

Func_0A1_4474::
    ld hl, $CD78
    ld a, [$CC45]
    bit 7, a
    jr z, Jump_0A1_447F
    inc hl

Jump_0A1_447F::
    and a, $0F
    add a, a
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A1_4488
    inc h

Jump_0A1_4488::
    ld a, [hl]
    push af
    and a, $0F
    and a, $FC
    ld hl, $CE93
    add a, l
    ld l, a
    jr nc, Jump_0A1_4496
    inc h

Jump_0A1_4496::
    pop af
    push af
    swap a
    and a, $0F
    srl a
    and a, $FE
    add a, l
    ld l, a
    jr nc, Jump_0A1_44A5
    inc h

Jump_0A1_44A5::
    pop af
    push af
    and a, $0F
    bit 1, a
    jr z, Jump_0A1_44AE
    inc hl

Jump_0A1_44AE::
    ld c, $01
    bit 0, a
    jr z, Jump_0A1_44B6
    ld c, $10

Jump_0A1_44B6::
    pop af
    swap a
    and a, $0F
    and a, $03
    jr z, Jump_0A1_44C5
    ld b, a

Jump_0A1_44C0::
    sla c
    dec b
    jr nz, Jump_0A1_44C0

Jump_0A1_44C5::
    ld a, [hl]
    or a, c
    ld [hl], a
    ret

Func_0A1_44C9::
    ldh a, [$FF8F]
    ldh [$FFC6], a
    dec a
    dec a
    ldh [$FF8F], a
    ldh a, [$FF92]
    ldh [$FFC7], a
    dec a
    dec a
    ldh [$FF92], a
    ld c, $05

Jump_0A1_44DB::
    ld b, $05

Jump_0A1_44DD::
    ld a, [$CD0E]
    ld d, a
    ldh a, [$FF92]
    bit 7, a
    jr nz, Jump_0A1_4503
    cp a, d
    jr nc, Jump_0A1_4503
    ld a, [$CD0D]
    ld d, a
    ldh a, [$FF8F]
    bit 7, a
    jr nz, Jump_0A1_44FC
    cp a, d
    jr nc, Jump_0A1_44FC
    push bc
    call Func_0A1_4435
    pop bc

Jump_0A1_44FC::
    ld hl, $FF8F
    inc [hl]
    dec b
    jr nz, Jump_0A1_44DD

Jump_0A1_4503::
    ldh a, [$FFC6]
    sub a, $02
    ldh [$FF8F], a
    ld hl, $FF92
    inc [hl]
    dec c
    jr nz, Jump_0A1_44DB
    ldh a, [$FFC6]
    ldh [$FF8F], a
    ldh a, [$FFC7]
    ldh [$FF92], a
    ret

Func_0A1_4519::
    ld a, [$C5DD]
    and a, $07
    rst $00
    dw Jump_0A1_4FB8
    dw Jump_0A1_4FE2
    dw Jump_0A1_5095
    dw Jump_0A1_4FB8
    dw Jump_0A1_452D
    dw Jump_0A1_4AA6
    dw Jump_0A1_50BB

Jump_0A1_452D::
    xor a, a
    ldh [$FFA1], a
    ldh [$FFA5], a
    call Func_000_07E0
    ld de, $4EB3
    ld b, $7E
    ld hl, $8000
    call Func_000_0CF5
    ld de, Data_0A1_5B27
    ld b, $7E
    ld hl, $8100
    call Func_000_0CF5
    ld de, Data_0A1_5B46
    ld b, $7E
    ld hl, $8200
    call Func_000_0CF5
    ld de, $43AE
    ld b, $5D
    ld hl, $9000
    call Func_000_0CF5
    call Func_0A1_578E
    call Func_0A1_579F
    ld a, [$CC44]
    bit 7, a
    jr nz, Jump_0A1_4573
    call Func_0A1_47D8
    jr Jump_0A1_4576

Jump_0A1_4573::
    call Func_0A1_45C5

Jump_0A1_4576::
    ld hl, $C5E9
    ld a, $D2
    ld [hl+], a
    ld a, $D2
    ld [hl+], a
    ld a, $E2
    ld [hl], a
    ld a, [$C525]
    or a, a
    jr z, Jump_0A1_45C0
    ld a, $40
    ld de, Data_07E_4BBD
    add a, e
    ld e, a
    jr nc, Jump_0A1_4592
    inc d

Jump_0A1_4592::
    ld b, $7E
    ld hl, $C4DF
    ld c, $08
    call Func_000_0B18
    ld de, Data_07E_5AF6
    ld b, $7E
    ld hl, $C4E7
    ld c, $10
    call Func_000_0B18
    ld a, $7F
    ld [$C527], a
    ld de, Data_05D_4565
    ld b, $5D
    ld hl, $C49F
    ld c, $40
    call Func_000_0B18
    ld a, $7F
    ld [$C526], a

Jump_0A1_45C0::
    ld hl, $C5DD
    inc [hl]
    ret

Func_0A1_45C5::
    call Func_0A1_46DF
    call Func_0A1_4A91
    ld hl, $9800
    ld c, $12

Jump_0A1_45D0::
    push hl
    ldh a, [$FFCB]
    ldh [$FFCF], a
    ldh a, [$FFCD]
    ldh [$FFD0], a
    ld b, $14

Jump_0A1_45DB::
    push bc
    push hl
    ldh a, [$FFD0]
    bit 7, a
    jr nz, Jump_0A1_4610
    ld c, a
    ldh a, [$FFC9]
    dec a
    cp a, c
    jr c, Jump_0A1_4610
    ldh a, [$FFCE]
    bit 7, a
    jr nz, Jump_0A1_4610
    ld c, a
    ldh a, [$FFCA]
    dec a
    cp a, c
    jr c, Jump_0A1_4610
    push bc
    ldh a, [$FFD0]
    and a, $0F
    swap a
    ld c, a
    ldh a, [$FFCE]
    and a, $0F
    or a, c
    pop bc
    push de
    call Func_0A1_58BA
    pop de
    or a, a
    jr z, Jump_0A1_4610
    call Func_0A1_4640

Jump_0A1_4610::
    ldh a, [$FFCF]
    inc a
    cp a, $05
    jr nz, Jump_0A1_461D
    ldh a, [$FFD0]
    inc a
    ldh [$FFD0], a
    xor a, a

Jump_0A1_461D::
    ldh [$FFCF], a
    pop hl
    inc hl
    pop bc
    dec b
    jr nz, Jump_0A1_45DB
    ldh a, [$FFCC]
    inc a
    cp a, $05
    jr nz, Jump_0A1_4632
    ldh a, [$FFCE]
    inc a
    ldh [$FFCE], a
    xor a, a

Jump_0A1_4632::
    ldh [$FFCC], a
    pop hl
    ld a, $20
    add a, l
    ld l, a
    jr nc, Jump_0A1_463C
    inc h

Jump_0A1_463C::
    dec c
    jr nz, Jump_0A1_45D0
    ret

Func_0A1_4640::
    push hl
    ldh a, [$FFCE]
    and a, $FC
    add a, a
    ld l, a
    ld h, $00
    ldh a, [$FFD0]
    and a, $FC
    add a, l
    ld l, a
    jr nc, Jump_0A1_4652
    inc h

Jump_0A1_4652::
    ld a, l
    add a, $60
    ld l, a
    ld a, h
    adc a, $CD
    ld h, a
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl+]
    ld b, a
    push bc
    ld a, [hl]
    ld c, $60
    call Func_000_1682
    add hl, de
    pop bc
    ldh a, [$FFCE]
    and a, $03
    ld c, a
    sla a
    add a, c
    sla a
    sla a
    add a, l
    ld l, a
    jr nc, Jump_0A1_467A
    inc h

Jump_0A1_467A::
    ldh a, [$FFD0]
    and a, $03
    ld c, a
    sla a
    add a, c
    add a, l
    ld l, a
    jr nc, Jump_0A1_4687
    inc h

Jump_0A1_4687::
    ld e, l
    ld d, h
    call Func_000_1872
    ld l, c
    inc de
    call Func_000_1872
    ld h, c
    inc de
    call Func_000_1872
    ld b, c
    ld e, l
    ld d, h
    inc de
    inc de
    inc de
    inc de
    inc de
    inc de
    call Func_000_1872
    ld l, c
    inc de
    call Func_000_1872
    ld h, c
    dec hl
    ld c, l
    ld b, h
    ld a, $19
    call Func_000_16AA
    ld a, l
    ldh [$FFC6], a
    ld a, h
    ldh [$FFC7], a
    ldh a, [$FFCC]
    ld c, a
    sla a
    sla a
    add a, c
    add a, l
    ld l, a
    jr nc, Jump_0A1_46C3
    inc h

Jump_0A1_46C3::
    ldh a, [$FFCF]
    add a, l
    ld l, a
    jr nc, Jump_0A1_46CA
    inc h

Jump_0A1_46CA::
    ld a, l
    add a, $A0
    ld l, a
    ld a, h
    adc a, $43
    ld h, a
    ld e, l
    ld d, h
    ld b, $5E
    call Func_000_1872
    pop hl
    ld a, c
    call Func_000_1211
    ret

Func_0A1_46DF::
    ldh a, [$FF8E]
    ld l, a
    ldh a, [$FF8F]
    ld h, a
    push hl
    ldh a, [$FF91]
    ld l, a
    ldh a, [$FF92]
    ld h, a
    push hl
    call Func_0A1_4744
    ld a, [$CD0D]
    ldh [$FFC9], a
    ld a, [$CD0E]
    ldh [$FFCA], a
    ldh a, [$FF8F]
    dec a
    dec a
    ldh [$FFCD], a
    ldh a, [$FF92]
    dec a
    dec a
    ldh [$FFCE], a
    ldh a, [$FF8E]
    swap a
    and a, $0F
    srl a
    inc a
    cp a, $05
    jr c, Jump_0A1_471B
    sub a, $05
    push af
    ld hl, $FFCD
    inc [hl]
    pop af

Jump_0A1_471B::
    ldh [$FFCB], a
    ldh a, [$FF91]
    swap a
    and a, $0F
    srl a
    inc a
    inc a
    cp a, $05
    jr c, Jump_0A1_4733
    sub a, $05
    push af
    ld hl, $FFCE
    inc [hl]
    pop af

Jump_0A1_4733::
    ldh [$FFCC], a
    pop hl
    ld a, l
    ldh [$FF91], a
    ld a, h
    ldh [$FF92], a
    pop hl
    ld a, l
    ldh [$FF8E], a
    ld a, h
    ldh [$FF8F], a
    ret

Func_0A1_4744::
    ld a, [$CC44]
    and a, $07
    rst $00
    dw Jump_0A1_475A
    dw Jump_0A1_475B
    dw Jump_0A1_475B
    dw Jump_0A1_4775
    dw Jump_0A1_4775
    dw Jump_0A1_4775
    dw Jump_0A1_4775
    dw Jump_0A1_4787

Jump_0A1_475A::
    ret

Jump_0A1_475B::
    ld a, [$CC45]
    and a, $07
    add a, a
    add a, a
    ld hl, $CD78
    add a, l
    ld l, a
    jr nc, Jump_0A1_476A
    inc h

Jump_0A1_476A::
    ld a, [$CC45]
    bit 7, a
    jr z, Jump_0A1_4772
    inc hl

Jump_0A1_4772::
    ld a, [hl]
    jr Func_0A1_47C5

Jump_0A1_4775::
    ld a, [$CC45]
    and a, $07
    add a, a
    add a, a
    ld hl, $CD88
    add a, l
    ld l, a
    jr nc, Jump_0A1_4784
    inc h

Jump_0A1_4784::
    ld a, [hl]
    jr Func_0A1_47C5

Jump_0A1_4787::
    ld a, [$C88E]
    or a, a
    jr z, Jump_0A1_47B4
    ld a, [$C891]
    bit 7, a
    jr z, Jump_0A1_47B4
    and a, $7F
    ld c, a
    ld a, [$CC42]
    cp a, c
    jr nz, Jump_0A1_47B4
    ld a, [$C890]
    call Func_0A1_47C5
    ld a, [$C88F]
    and a, $F0
    ldh [$FF8E], a
    ld a, [$C88F]
    and a, $0F
    swap a
    ldh [$FF91], a
    ret

Jump_0A1_47B4::
    ld a, [$CD08]
    call Func_0A1_47C5
    ld a, [$CD09]
    ldh [$FF8E], a
    ld a, [$CD0A]
    ldh [$FF91], a
    ret

Func_0A1_47C5::
    push af
    swap a
    and a, $0F
    ldh [$FF8F], a
    pop af
    and a, $0F
    ldh [$FF92], a
    ld a, $40
    ldh [$FF8E], a
    ldh [$FF91], a
    ret

Func_0A1_47D8::
    call Func_0A1_4874
    call Func_0A1_4A91
    ldh a, [$FFC6]
    ld e, a
    ldh a, [$FFC7]
    ld d, a
    ld hl, $9800
    ld c, $12

Jump_0A1_47E9::
    push hl
    push de
    ldh a, [$FFCB]
    ldh [$FFCF], a
    ldh a, [$FFCD]
    ldh [$FFD0], a
    ld b, $14

Jump_0A1_47F5::
    push bc
    push hl
    ldh a, [$FFD0]
    bit 7, a
    jr nz, Jump_0A1_481B
    ld c, a
    ldh a, [$FFC9]
    dec a
    cp a, c
    jr c, Jump_0A1_481B
    ldh a, [$FFCE]
    bit 7, a
    jr nz, Jump_0A1_481B
    ld c, a
    ldh a, [$FFCA]
    dec a
    cp a, c
    jr c, Jump_0A1_481B
    ldh a, [$FFC8]
    ld b, a
    call Func_000_1872
    ld a, c
    call Func_000_1211

Jump_0A1_481B::
    inc de
    ldh a, [$FFCF]
    inc a
    cp a, $05
    jr nz, Jump_0A1_4831
    ldh a, [$FFD0]
    inc a
    ldh [$FFD0], a
    ld a, e
    add a, $14
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    xor a, a

Jump_0A1_4831::
    ldh [$FFCF], a
    pop hl
    inc hl
    pop bc
    dec b
    jr nz, Jump_0A1_47F5
    pop de
    ld a, $05
    add a, e
    ld e, a
    jr nc, Jump_0A1_4841
    inc d

Jump_0A1_4841::
    ldh a, [$FFCC]
    inc a
    cp a, $05
    jr nz, Jump_0A1_4865
    ldh a, [$FFCE]
    inc a
    ldh [$FFCE], a
    push bc
    ldh a, [$FFC9]
    ld c, a
    ld a, $19
    push de
    call Func_000_1682
    pop de
    add hl, de
    ld e, l
    ld d, h
    ld a, e
    sub a, $19
    ld e, a
    ld a, d
    sbc a, $00
    ld d, a
    pop bc
    xor a, a

Jump_0A1_4865::
    ldh [$FFCC], a
    pop hl
    ld a, $20
    add a, l
    ld l, a
    jr nc, Jump_0A1_486F
    inc h

Jump_0A1_486F::
    dec c
    jp nz, Jump_0A1_47E9
    ret

Func_0A1_4874::
    ldh a, [$FF8E]
    ld l, a
    ldh a, [$FF8F]
    ld h, a
    push hl
    ldh a, [$FF91]
    ld l, a
    ldh a, [$FF92]
    ld h, a
    push hl
    call Func_0A1_49A8
    ld a, [$C944]
    add a, a
    add a, a
    ld hl, Data_0A1_497C
    add a, l
    ld l, a
    jr nc, Jump_0A1_4892
    inc h

Jump_0A1_4892::
    ld a, [hl]
    swap a
    and a, $0F
    ldh [$FFC9], a
    ld a, [hl+]
    and a, $0F
    ldh [$FFCA], a
    ld a, [hl+]
    ldh [$FFC6], a
    ld a, [hl+]
    ldh [$FFC7], a
    ld a, [hl]
    ldh [$FFC8], a
    ldh a, [$FF8F]
    ld c, a
    ldh a, [$FF90]
    ld b, a
    ld b, $00
    dec bc
    dec bc
    ld a, c
    ldh [$FFCD], a
    ld a, $19
    call Func_000_16AA
    ldh a, [$FFC6]
    ld e, a
    ldh a, [$FFC7]
    ld d, a
    add hl, de
    ld a, l
    ldh [$FFC6], a
    ld a, h
    ldh [$FFC7], a
    ldh a, [$FF92]
    ld c, a
    ldh a, [$FF93]
    ld b, a
    ld b, $00
    dec bc
    dec bc
    ld a, c
    ldh [$FFCE], a
    ldh a, [$FFC9]
    call Func_000_16AA
    ld c, l
    ld b, h
    ld a, $19
    call Func_000_16AA
    ldh a, [$FFC6]
    ld e, a
    ldh a, [$FFC7]
    ld d, a
    add hl, de
    ld a, l
    ldh [$FFC6], a
    ld a, h
    ldh [$FFC7], a
    ldh a, [$FF8E]
    swap a
    and a, $0F
    srl a
    inc a
    cp a, $05
    jr c, Jump_0A1_4915
    sub a, $05
    push af
    ld hl, $FFCD
    inc [hl]
    ldh a, [$FFC6]
    ld l, a
    ldh a, [$FFC7]
    ld h, a
    ld a, l
    add a, $19
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, l
    ldh [$FFC6], a
    ld a, h
    ldh [$FFC7], a
    pop af

Jump_0A1_4915::
    ldh [$FFCB], a
    push af
    ldh a, [$FFC6]
    ld l, a
    ldh a, [$FFC7]
    ld h, a
    pop af
    add a, l
    ld l, a
    jr nc, Jump_0A1_4924
    inc h

Jump_0A1_4924::
    ld a, l
    ldh [$FFC6], a
    ld a, h
    ldh [$FFC7], a
    ldh a, [$FF91]
    swap a
    and a, $0F
    srl a
    inc a
    inc a
    cp a, $05
    jr c, Jump_0A1_4954
    sub a, $05
    push af
    ld hl, $FFCE
    inc [hl]
    ldh a, [$FFC9]
    ld c, $19
    call Func_000_1682
    ldh a, [$FFC6]
    ld e, a
    ldh a, [$FFC7]
    ld d, a
    add hl, de
    ld a, l
    ldh [$FFC6], a
    ld a, h
    ldh [$FFC7], a
    pop af

Jump_0A1_4954::
    ldh [$FFCC], a
    ld c, a
    add a, a
    add a, a
    add a, c
    push af
    ldh a, [$FFC6]
    ld l, a
    ldh a, [$FFC7]
    ld h, a
    pop af
    add a, l
    ld l, a
    jr nc, Jump_0A1_4967
    inc h

Jump_0A1_4967::
    ld a, l
    ldh [$FFC6], a
    ld a, h
    ldh [$FFC7], a
    pop hl
    ld a, l
    ldh [$FF91], a
    ld a, h
    ldh [$FF92], a
    pop hl
    ld a, l
    ldh [$FF8E], a
    ld a, h
    ldh [$FF8F], a
    ret

Data_0A1_497C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $88, $A5
    dw Data_0A1_5D45
    db $88, $E5
    dw Data_0A1_5D4B
    db $CC, $25
    dw Data_0A1_5D52
    db $CC, $35
    dw Data_0A1_5D60
    db $43, $45
    dw Data_0A1_5D6E
    db $66, $71
    dw Data_0A1_5D6F
    db $32, $F5
    dw Data_0A1_5D72
    db $55, $8B
    dw Data_0A1_5D73
    db $12, $FC
    dw Data_0A1_5D75
    db $12, $2E
    dw Data_0A1_5D76
    db $21, $60
    dw Data_0A1_5D76

Func_0A1_49A8::
    ldh a, [$FF90]
    ld c, $01
    cp a, $29
    jp z, Jump_0A1_4A31
    ld c, $02
    cp a, $45
    jp z, Jump_0A1_4A31
    ld c, $03
    cp a, $68
    jp z, Jump_0A1_4A31
    ld c, $04
    cp a, $9D
    jp z, Jump_0A1_4A31
    ld c, $05
    cp a, $A4
    jp z, Jump_0A1_4A31
    ld c, $06
    cp a, $AF
    jp z, Jump_0A1_4A31
    ld c, $07
    cp a, $B2
    jp z, Jump_0A1_4A31
    ld c, $08
    cp a, $C5
    jr z, Jump_0A1_4A31
    ld c, $09
    cp a, $D0
    jr z, Jump_0A1_4A31
    ld c, $0A
    cp a, $D9
    jr z, Jump_0A1_4A31
    ld c, $0B
    cp a, $E2
    jr z, Jump_0A1_4A31
    cp a, $20
    ret z
    cp a, $30
    ret z
    cp a, $48
    ret z
    cp a, $70
    ret z
    cp a, $A0
    ret z
    cp a, $A8
    ret z
    cp a, $B0
    ret z
    cp a, $B8
    ret z
    cp a, $C8
    ret z
    cp a, $D1
    ret z
    cp a, $DA
    ret z
    ld c, a
    ld hl, Data_0A1_5D80

Jump_0A1_4A18::
    ld a, [hl]
    cp a, c
    jr z, Jump_0A1_4A23
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    jr Jump_0A1_4A18

Jump_0A1_4A23::
    ld a, [$C88B]
    dec a
    dec a
    jr nz, Jump_0A1_4A2C
    inc hl
    inc hl

Jump_0A1_4A2C::
    inc hl
    call Func_0A1_4A77
    ret

Jump_0A1_4A31::
    ld a, [$C944]
    inc a
    ld c, a
    ld a, [$C88E]
    or a, a
    jr z, Jump_0A1_4A67
    ld a, [$C891]
    bit 7, a
    jr nz, Jump_0A1_4A67
    cp a, c
    jr nz, Jump_0A1_4A67
    ld a, [$C890]
    swap a
    and a, $0F
    ldh [$FF8F], a
    ld a, [$C890]
    and a, $0F
    ldh [$FF92], a
    ld a, [$C88F]
    and a, $F0
    ldh [$FF8E], a
    ld a, [$C88F]
    and a, $0F
    swap a
    ldh [$FF91], a
    ret

Jump_0A1_4A67::
    ld a, c
    dec a
    add a, a
    add a, a
    ld hl, Data_0A1_59D6
    add a, l
    ld l, a
    jr nc, Jump_0A1_4A73
    inc h

Jump_0A1_4A73::
    call Func_0A1_4A77
    ret

Func_0A1_4A77::
    ld a, [hl]
    swap a
    and a, $0F
    ldh [$FF8F], a
    ld a, [hl]
    and a, $0F
    ldh [$FF92], a
    inc hl
    ld a, [hl]
    and a, $F0
    ldh [$FF8E], a
    ld a, [hl]
    and a, $0F
    swap a
    ldh [$FF91], a
    ret

Func_0A1_4A91::
    ldh a, [$FFCB]
    ld [$C945], a
    ldh a, [$FFCD]
    ld [$C946], a
    ldh a, [$FFCC]
    ld [$C947], a
    ldh a, [$FFCE]
    ld [$C948], a
    ret

Jump_0A1_4AA6::
    ld a, [$C562]
    bit 1, a
    jr nz, Func_0A1_4AB1
    bit 2, a
    jr z, Jump_0A1_4ADC

Func_0A1_4AB1::
    ld hl, $C5E9
    ld a, $00
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ld a, [$C525]
    or a, a
    jr z, Jump_0A1_4AD7
    ld hl, $C49F
    ld bc, $0050
    ld a, $FF
    call Func_000_0949
    ld a, $7F
    ld [$C526], a
    ld a, $7F
    ld [$C527], a
    call Func_000_0829

Jump_0A1_4AD7::
    ld hl, $C5DD
    inc [hl]
    ret

Jump_0A1_4ADC::
    call Func_0A1_4F8B
    call Func_0A1_4DA4
    call Func_0A1_4EE7
    call Func_0A1_4C2E
    call Func_0A1_4AEC
    ret

Func_0A1_4AEC::
    ld a, [$CC44]
    bit 7, a
    jp nz, Jump_0A1_4B64
    ldh a, [$FF90]
    ld c, $01
    cp a, $30
    jr c, Jump_0A1_4B34
    ld c, $02
    cp a, $48
    jr c, Jump_0A1_4B34
    ld c, $03
    cp a, $70
    jr c, Jump_0A1_4B34
    ld c, $04
    cp a, $A0
    jr c, Jump_0A1_4B34
    ld c, $05
    cp a, $A8
    jr c, Jump_0A1_4B34
    ld c, $06
    cp a, $B0
    jr c, Jump_0A1_4B34
    ld c, $07
    cp a, $B8
    jr c, Jump_0A1_4B34
    ld c, $08
    cp a, $C8
    jr c, Jump_0A1_4B34
    ld c, $09
    cp a, $D1
    jr c, Jump_0A1_4B34
    ld c, $0A
    cp a, $DA
    jr c, Jump_0A1_4B34
    ld c, $0B

Jump_0A1_4B34::
    ld a, [$C88E]
    or a, a
    jr z, Jump_0A1_4B4E
    ld a, [$C891]
    cp a, c
    jr nz, Jump_0A1_4B4E
    ld a, [$C890]
    ldh [$FFC7], a
    ld a, [$C88F]
    ldh [$FFC8], a
    call Func_0A1_4BA1
    ret

Jump_0A1_4B4E::
    ld a, c
    dec a
    add a, a
    add a, a
    ld hl, Data_0A1_59D6
    add a, l
    ld l, a
    jr nc, Jump_0A1_4B5A
    inc h

Jump_0A1_4B5A::
    ld a, [hl+]
    ldh [$FFC7], a
    ld a, [hl]
    ldh [$FFC8], a
    call Func_0A1_4BA1
    ret

Jump_0A1_4B64::
    ld a, [$C88E]
    or a, a
    jr z, Jump_0A1_4B88
    ld a, [$C891]
    bit 7, a
    jr z, Jump_0A1_4B88
    and a, $7F
    ld c, a
    ld a, [$CC42]
    cp a, c
    jr nz, Jump_0A1_4B88
    ld a, [$C890]
    ldh [$FFC7], a
    ld a, [$C88F]
    ldh [$FFC8], a
    call Func_0A1_4BA1
    ret

Jump_0A1_4B88::
    ld a, [$CD08]
    ldh [$FFC7], a
    ld a, [$CD09]
    and a, $F0
    ld c, a
    ld a, [$CD0A]
    and a, $F0
    swap a
    or a, c
    ldh [$FFC8], a
    call Func_0A1_4BA1
    ret

Func_0A1_4BA1::
    ld a, [$C946]
    ld c, a
    ldh a, [$FFC7]
    swap a
    and a, $0F
    sub a, c
    bit 7, a
    jp nz, Jump_0A1_4C2D
    cp a, $05
    jp nc, Jump_0A1_4C2D
    ld c, $28
    call Func_000_1682
    ld a, l
    ldh [$FFA9], a
    ld a, [$C948]
    ld c, a
    ldh a, [$FFC7]
    and a, $0F
    sub a, c
    bit 7, a
    jr nz, Jump_0A1_4C2D
    cp a, $05
    jr nc, Jump_0A1_4C2D
    ld c, $28
    call Func_000_1682
    ld a, l
    ldh [$FFAB], a
    ld a, [$C945]
    sla a
    sla a
    sla a
    ld c, a
    ldh a, [$FFC8]
    swap a
    and a, $0F
    srl a
    sla a
    sla a
    sla a
    sub a, c
    ld c, a
    ldh a, [$FFA9]
    add a, c
    ldh [$FFA9], a
    ld a, [$C947]
    sla a
    sla a
    sla a
    ld c, a
    ldh a, [$FFC8]
    and a, $0F
    srl a
    sla a
    sla a
    sla a
    sub a, c
    ld c, a
    ldh a, [$FFAB]
    add a, c
    ldh [$FFAB], a
    ld a, $20
    ldh [$FFAF], a
    ld a, $01
    ldh [$FFB0], a
    ld a, $28
    ldh [$FFAD], a
    xor a, a
    ldh [$FFAE], a
    xor a, a
    ldh [$FFAA], a
    ldh [$FFAC], a
    ld hl, Func_07F_700A
    ld b, $7F
    rst $10

Jump_0A1_4C2D::
    ret

Func_0A1_4C2E::
    ld a, [$C950]
    or a, a
    ret z
    ld a, [$CC44]
    bit 7, a
    jp nz, Jump_0A1_4CDD
    ld a, [$CC47]
    ld b, a
    ld de, $CC48

Jump_0A1_4C42::
    push bc
    push de
    ld a, [de]
    bit 7, a
    jp nz, Jump_0A1_4CCF
    inc de
    inc de
    inc de
    inc de
    ld a, [$C946]
    ld c, a
    ld a, [de]
    swap a
    and a, $0F
    sub a, c
    bit 7, a
    jp nz, Jump_0A1_4CCF
    cp a, $05
    jp nc, Jump_0A1_4CCF
    ld c, $28
    push de
    call Func_000_1682
    pop de
    ld a, l
    ldh [$FFA9], a
    ld a, [$C948]
    ld c, a
    ld a, [de]
    and a, $0F
    sub a, c
    bit 7, a
    jr nz, Jump_0A1_4CCF
    cp a, $05
    jr nc, Jump_0A1_4CCF
    ld c, $28
    push de
    call Func_000_1682
    pop de
    ld a, l
    ldh [$FFAB], a
    ld a, [$C945]
    add a, a
    add a, a
    add a, a
    ld c, a
    inc de
    ld a, [de]
    swap a
    and a, $0F
    srl a
    add a, a
    add a, a
    add a, a
    sub a, c
    ld c, a
    ldh a, [$FFA9]
    add a, c
    ldh [$FFA9], a
    ld a, [$C947]
    add a, a
    add a, a
    add a, a
    ld c, a
    ld a, [de]
    and a, $0F
    srl a
    add a, a
    add a, a
    add a, a
    sub a, c
    ld c, a
    ldh a, [$FFAB]
    add a, c
    ldh [$FFAB], a
    ld a, $10
    ldh [$FFAF], a
    ld a, $02
    ldh [$FFB0], a
    ld a, $27
    ldh [$FFAD], a
    xor a, a
    ldh [$FFAE], a
    xor a, a
    ldh [$FFAA], a
    ldh [$FFAC], a
    ld hl, Func_07F_700A
    ld b, $7F
    rst $10

Jump_0A1_4CCF::
    pop de
    ld a, $08
    add a, e
    ld e, a
    jr nc, Jump_0A1_4CD7
    inc d

Jump_0A1_4CD7::
    pop bc
    dec b
    jp nz, Jump_0A1_4C42
    ret

Jump_0A1_4CDD::
    ld a, [$CC47]
    ld b, a
    ld de, $CC48

Jump_0A1_4CE4::
    push bc
    push de
    ld a, [de]
    bit 7, a
    jp nz, Jump_0A1_4D86
    inc de
    inc de
    inc de
    inc de
    ld a, [$C946]
    ld c, a
    ld a, [de]
    swap a
    and a, $0F
    sub a, c
    bit 7, a
    jp nz, Jump_0A1_4D86
    cp a, $05
    jp nc, Jump_0A1_4D86
    ld c, $28
    push de
    call Func_000_1682
    pop de
    ld a, l
    ldh [$FFA9], a
    ld a, [$C948]
    ld c, a
    ld a, [de]
    and a, $0F
    sub a, c
    bit 7, a
    jr nz, Jump_0A1_4D86
    cp a, $05
    jr nc, Jump_0A1_4D86
    ld c, $28
    push de
    call Func_000_1682
    pop de
    ld a, l
    ldh [$FFAB], a
    inc de
    ld a, [de]
    ld hl, Data_0A1_4D94
    add a, l
    ld l, a
    jr nc, Jump_0A1_4D32
    inc h

Jump_0A1_4D32::
    ld a, [$C945]
    sla a
    sla a
    sla a
    ld c, a
    ld a, [hl]
    swap a
    and a, $0F
    srl a
    sla a
    sla a
    sla a
    sub a, c
    ld c, a
    ldh a, [$FFA9]
    add a, c
    ldh [$FFA9], a
    ld a, [$C947]
    sla a
    sla a
    sla a
    ld c, a
    ld a, [hl]
    and a, $0F
    srl a
    sla a
    sla a
    sla a
    sub a, c
    ld c, a
    ldh a, [$FFAB]
    add a, c
    ldh [$FFAB], a
    ld a, $10
    ldh [$FFAF], a
    ld a, $02
    ldh [$FFB0], a
    ld a, $27
    ldh [$FFAD], a
    xor a, a
    ldh [$FFAE], a
    xor a, a
    ldh [$FFAA], a
    ldh [$FFAC], a
    ld hl, Func_07F_700A
    ld b, $7F
    rst $10

Jump_0A1_4D86::
    pop de
    ld a, $08
    add a, e
    ld e, a
    jr nc, Jump_0A1_4D8E
    inc d

Jump_0A1_4D8E::
    pop bc
    dec b
    jp nz, Jump_0A1_4CE4
    ret

Data_0A1_4D94:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $12, $17, $21, $24, $26, $33, $45, $47, $51, $53, $65, $72, $74, $77, $81, $86

Func_0A1_4DA4::
    ld a, [$CC44]
    bit 7, a
    jp nz, Jump_0A1_4E4D
    ld a, [$C944]
    add a, a
    ld hl, Data_0A1_5A49
    add a, l
    ld l, a
    jr nc, Jump_0A1_4DB8
    inc h

Jump_0A1_4DB8::
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld a, [de]
    or a, a
    ret z
    inc de
    ld b, a

Jump_0A1_4DC1::
    push bc
    push de
    ld a, [$C946]
    ld c, a
    ld a, [de]
    swap a
    and a, $0F
    sub a, c
    bit 7, a
    jp nz, Jump_0A1_4E44
    cp a, $05
    jp nc, Jump_0A1_4E44
    ld c, $28
    push de
    call Func_000_1682
    pop de
    ld a, l
    ldh [$FFA9], a
    ld a, [$C948]
    ld c, a
    ld a, [de]
    and a, $0F
    sub a, c
    bit 7, a
    jr nz, Jump_0A1_4E44
    cp a, $05
    jr nc, Jump_0A1_4E44
    ld c, $28
    push de
    call Func_000_1682
    pop de
    ld a, l
    ldh [$FFAB], a
    ld a, [$C945]
    add a, a
    add a, a
    add a, a
    ld c, a
    inc de
    ld a, [de]
    swap a
    and a, $0F
    srl a
    add a, a
    add a, a
    add a, a
    sub a, c
    ld c, a
    ldh a, [$FFA9]
    add a, c
    ldh [$FFA9], a
    ld a, [$C947]
    add a, a
    add a, a
    add a, a
    ld c, a
    ld a, [de]
    and a, $0F
    srl a
    add a, a
    add a, a
    add a, a
    sub a, c
    ld c, a
    ldh a, [$FFAB]
    add a, c
    ldh [$FFAB], a
    ld a, $20
    ldh [$FFAF], a
    ld a, $01
    ldh [$FFB0], a
    ld a, $28
    ldh [$FFAD], a
    xor a, a
    ldh [$FFAE], a
    xor a, a
    ldh [$FFAA], a
    ldh [$FFAC], a
    ld hl, Func_07F_700A
    ld b, $7F
    rst $10

Jump_0A1_4E44::
    pop de
    inc de
    inc de
    pop bc
    dec b
    jp nz, Jump_0A1_4DC1
    ret

Jump_0A1_4E4D::
    ld de, $CD8B

Jump_0A1_4E50::
    push de
    ld a, [de]
    cp a, $FF
    jr nz, Jump_0A1_4E58
    pop de
    ret

Jump_0A1_4E58::
    dec de
    dec de
    dec de
    ld a, [$C946]
    ld c, a
    ld a, [de]
    swap a
    and a, $0F
    sub a, c
    bit 7, a
    jp nz, Jump_0A1_4EDF
    cp a, $05
    jr nc, Jump_0A1_4EDF
    ld c, $28
    push de
    call Func_000_1682
    pop de
    ld a, l
    ldh [$FFA9], a
    ld a, [$C948]
    ld c, a
    ld a, [de]
    and a, $0F
    sub a, c
    bit 7, a
    jr nz, Jump_0A1_4EDF
    cp a, $05
    jr nc, Jump_0A1_4EDF
    ld c, $28
    push de
    call Func_000_1682
    pop de
    ld a, l
    ldh [$FFAB], a
    ld a, [$C950]
    or a, a
    jr nz, Jump_0A1_4E9F
    ld a, [de]
    call Func_0A1_58BA
    or a, a
    jr z, Jump_0A1_4EDF

Jump_0A1_4E9F::
    ld a, [$C945]
    add a, a
    add a, a
    add a, a
    ld c, a
    ld a, $02
    add a, a
    add a, a
    add a, a
    sub a, c
    ld c, a
    ldh a, [$FFA9]
    add a, c
    ldh [$FFA9], a
    ld a, [$C947]
    add a, a
    add a, a
    add a, a
    ld c, a
    ld a, $02
    add a, a
    add a, a
    add a, a
    sub a, c
    ld c, a
    ldh a, [$FFAB]
    add a, c
    ldh [$FFAB], a
    ld a, $20
    ldh [$FFAF], a
    ld a, $01
    ldh [$FFB0], a
    ld a, $28
    ldh [$FFAD], a
    xor a, a
    ldh [$FFAE], a
    xor a, a
    ldh [$FFAA], a
    ldh [$FFAC], a
    ld hl, Func_07F_700A
    ld b, $7F
    rst $10

Jump_0A1_4EDF::
    pop de
    inc de
    inc de
    inc de
    inc de
    jp Jump_0A1_4E50

Func_0A1_4EE7::
    ld a, [$CC44]
    bit 7, a
    ret z
    ld de, $CD7B

Jump_0A1_4EF0::
    push de
    ld a, [de]
    cp a, $FF
    jr nz, Jump_0A1_4EF8
    pop de
    ret

Jump_0A1_4EF8::
    dec de
    dec de
    dec de
    call Func_0A1_4F0A
    inc de
    call Func_0A1_4F0A
    pop de
    inc de
    inc de
    inc de
    inc de
    jp Jump_0A1_4EF0

Func_0A1_4F0A::
    ld a, [$C946]
    ld c, a
    ld a, [de]
    swap a
    and a, $0F
    sub a, c
    bit 7, a
    ret nz
    cp a, $05
    ret nc
    ld c, $28
    push de
    call Func_000_1682
    pop de
    ld a, l
    ldh [$FFA9], a
    ld a, [$C948]
    ld c, a
    ld a, [de]
    and a, $0F
    sub a, c
    bit 7, a
    ret nz
    cp a, $05
    ret nc
    ld c, $28
    push de
    call Func_000_1682
    pop de
    ld a, l
    ldh [$FFAB], a
    ld a, [$C950]
    or a, a
    jr nz, Jump_0A1_4F48
    ld a, [de]
    call Func_0A1_58BA
    or a, a
    ret z

Jump_0A1_4F48::
    ld a, [$C945]
    add a, a
    add a, a
    add a, a
    ld c, a
    ld a, $02
    add a, a
    add a, a
    add a, a
    sub a, c
    ld c, a
    ldh a, [$FFA9]
    add a, c
    ldh [$FFA9], a
    ld a, [$C947]
    add a, a
    add a, a
    add a, a
    ld c, a
    ld a, $02
    add a, a
    add a, a
    add a, a
    sub a, c
    ld c, a
    ldh a, [$FFAB]
    add a, c
    ldh [$FFAB], a
    ld a, $20
    ldh [$FFAF], a
    ld a, $01
    ldh [$FFB0], a
    ld a, $28
    ldh [$FFAD], a
    xor a, a
    ldh [$FFAE], a
    xor a, a
    ldh [$FFAA], a
    ldh [$FFAC], a
    push de
    ld hl, Func_07F_700A
    ld b, $7F
    rst $10
    pop de
    ret

Func_0A1_4F8B::
    ld a, [$C5F0]
    bit 5, a
    ret z
    ld a, $50
    dec a
    dec a
    ldh [$FFA9], a
    ld a, $48
    dec a
    dec a
    ldh [$FFAB], a
    ld a, $00
    ldh [$FFAF], a
    ld a, $00
    ldh [$FFB0], a
    ld a, $08
    ldh [$FFAD], a
    xor a, a
    ldh [$FFAE], a
    xor a, a
    ldh [$FFAA], a
    ldh [$FFAC], a
    ld hl, Func_07F_700A
    ld b, $7F
    rst $10
    ret

Jump_0A1_4FB8::
    xor a, a
    ld [$CB7D], a
    ld hl, $C5E9
    ld a, $00
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ld a, [$C525]
    or a, a
    jr z, Jump_0A1_4FDD
    ld hl, $C49F
    ld bc, $0040
    ld a, $FF
    call Func_000_0949
    ld a, $7F
    ld [$C526], a
    call Func_000_0829

Jump_0A1_4FDD::
    ld hl, $C5DD
    inc [hl]
    ret

Jump_0A1_4FE2::
    xor a, a
    ldh [$FFA1], a
    ldh [$FFA5], a
    call Func_000_07E0
    ld de, $4EB3
    ld b, $7E
    ld hl, $8000
    call Func_000_0CF5
    ld de, Data_0A1_5B0E
    ld b, $7E
    ld hl, $8100
    call Func_000_0CF5
    ld de, Func_0A1_4001
    ld b, $5D
    ld hl, $9000
    call Func_000_0CF5
    ld de, Data_05E_4001
    ld b, $5E
    ld hl, $9500
    call Func_000_0CF5
    ld de, Data_05E_4238
    ld a, $5E
    ld bc, $1412
    ld hl, $9800
    call Func_000_15DE
    call Func_0A1_57F9
    call Func_0A1_57BE
    ld a, [$CC44]
    bit 7, a
    jr nz, Jump_0A1_5036
    call Func_0A1_52D4
    jr Jump_0A1_5039

Jump_0A1_5036::
    call Func_0A1_50BF

Jump_0A1_5039::
    ld hl, $C5E9
    ld a, $D2
    ld [hl+], a
    ld a, $D2
    ld [hl+], a
    ld a, $E2
    ld [hl], a
    ld a, [$C525]
    or a, a
    jr z, Jump_0A1_5090
    ld a, $40
    ld de, Data_07E_4BBD
    add a, e
    ld e, a
    jr nc, Jump_0A1_5055
    inc d

Jump_0A1_5055::
    ld b, $7E
    ld hl, $C4DF
    ld c, $08
    call Func_000_0B18
    ld de, Data_07E_5AF6
    ld b, $7E
    ld hl, $C4E7
    ld c, $08
    call Func_000_0B18
    ld a, $7F
    ld [$C527], a
    ld de, Data_05D_4139
    ld b, $5D
    ld hl, $C49F
    ld c, $08
    call Func_000_0B18
    ld de, Data_05E_422F
    ld b, $5E
    ld hl, $C4A7
    ld c, $08
    call Func_000_0B18
    ld a, $7F
    ld [$C526], a

Jump_0A1_5090::
    ld hl, $C5DD
    inc [hl]
    ret

Jump_0A1_5095::
    ld a, [$C562]
    bit 1, a
    jr z, Jump_0A1_50A5
    call Func_0A1_4AB1
    ld a, $06
    ld [$C5DD], a
    ret

Jump_0A1_50A5::
    bit 2, a
    jr z, Jump_0A1_50AE
    ld hl, $C5DD
    inc [hl]
    ret

Jump_0A1_50AE::
    call Func_0A1_5479
    call Func_0A1_5654
    call Func_0A1_56F7
    call Func_0A1_5394
    ret

Jump_0A1_50BB::
    call Func_0A1_5898
    ret

Func_0A1_50BF::
    ld a, [$CD0E]
    ld c, a
    ld a, [$CD0D]
    ld b, a
    call Func_0A1_5764
    ld a, l
    ldh [$FFC6], a
    ld a, h
    ldh [$FFC7], a
    ld a, l
    ldh [$FFC8], a
    ld a, h
    ldh [$FFC9], a
    ld hl, $CE93
    ld a, l
    ldh [$FFCA], a
    ld a, h
    ldh [$FFCB], a
    ld a, l
    ldh [$FFCC], a
    ld a, h
    ldh [$FFCD], a
    ld a, [$CD0E]
    srl a
    srl a
    ld c, a
    ld a, [$CD0D]
    srl a
    srl a
    ld b, a
    ld hl, $CD60

Jump_0A1_50F8::
    push bc
    push hl

Jump_0A1_50FA::
    push bc
    push hl
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl+]
    ld b, a
    push bc
    ld a, [hl]
    ld c, $60
    call Func_000_1682
    add hl, de
    pop bc
    ldh a, [$FFCA]
    ld e, a
    ldh a, [$FFCB]
    ld d, a
    ld a, [de]
    call Func_0A1_5242
    call Func_0A1_5242
    call Func_0A1_5242
    call Func_0A1_5242
    push af
    ldh a, [$FFC6]
    ld e, a
    ldh a, [$FFC7]
    ld d, a
    ld a, $1C
    add a, e
    ld e, a
    jr nc, Jump_0A1_512C
    inc d

Jump_0A1_512C::
    ld a, e
    ldh [$FFC6], a
    ld a, d
    ldh [$FFC7], a
    pop af
    call Func_0A1_5242
    call Func_0A1_5242
    call Func_0A1_5242
    call Func_0A1_5242
    ldh a, [$FFC6]
    ld e, a
    ldh a, [$FFC7]
    ld d, a
    ld a, $1C
    add a, e
    ld e, a
    jr nc, Jump_0A1_514C
    inc d

Jump_0A1_514C::
    ld a, e
    ldh [$FFC6], a
    ld a, d
    ldh [$FFC7], a
    ldh a, [$FFCA]
    ld e, a
    ldh a, [$FFCB]
    ld d, a
    inc de
    ld a, e
    ldh [$FFCA], a
    ld a, d
    ldh [$FFCB], a
    ld a, [de]
    call Func_0A1_5242
    call Func_0A1_5242
    call Func_0A1_5242
    call Func_0A1_5242
    push af
    ldh a, [$FFC6]
    ld e, a
    ldh a, [$FFC7]
    ld d, a
    ld a, $1C
    add a, e
    ld e, a
    jr nc, Jump_0A1_517A
    inc d

Jump_0A1_517A::
    ld a, e
    ldh [$FFC6], a
    ld a, d
    ldh [$FFC7], a
    pop af
    call Func_0A1_5242
    call Func_0A1_5242
    call Func_0A1_5242
    call Func_0A1_5242
    ldh a, [$FFC6]
    ld e, a
    ldh a, [$FFC7]
    ld d, a
    ld a, $1C
    add a, e
    ld e, a
    jr nc, Jump_0A1_519A
    inc d

Jump_0A1_519A::
    ld a, e
    ldh [$FFC6], a
    ld a, d
    ldh [$FFC7], a
    ldh a, [$FFCA]
    ld e, a
    ldh a, [$FFCB]
    ld d, a
    inc de
    ld a, e
    ldh [$FFCA], a
    ld a, d
    ldh [$FFCB], a
    ld a, [de]
    ldh a, [$FFC6]
    ld e, a
    ldh a, [$FFC7]
    ld d, a
    ld a, e
    sub a, $7C
    ld e, a
    ld a, d
    sbc a, $00
    ld d, a
    ld a, e
    ldh [$FFC6], a
    ld a, d
    ldh [$FFC7], a
    pop hl
    ld a, $04
    add a, l
    ld l, a
    jr nc, Jump_0A1_51CA
    inc h

Jump_0A1_51CA::
    pop bc
    dec b
    jp nz, Jump_0A1_50FA
    ldh a, [$FFC8]
    ld e, a
    ldh a, [$FFC9]
    ld d, a
    ld a, $80
    add a, e
    ld e, a
    jr nc, Jump_0A1_51DC
    inc d

Jump_0A1_51DC::
    ld a, e
    ldh [$FFC8], a
    ld a, d
    ldh [$FFC9], a
    ld a, e
    ldh [$FFC6], a
    ld a, d
    ldh [$FFC7], a
    ldh a, [$FFCC]
    ld e, a
    ldh a, [$FFCD]
    ld d, a
    ld a, e
    add a, $04
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    ld a, e
    ldh [$FFCA], a
    ld a, d
    ldh [$FFCB], a
    ld a, e
    ldh [$FFCC], a
    ld a, d
    ldh [$FFCD], a
    pop hl
    ld a, $08
    add a, l
    ld l, a
    jr nc, Jump_0A1_520A
    inc h

Jump_0A1_520A::
    pop bc
    dec c
    jp nz, Jump_0A1_50F8
    ld hl, $8800
    ld b, $58

Jump_0A1_5214::
    ld a, $FF
    call Func_000_121F
    xor a, a
    call Func_000_121F
    dec b
    jr nz, Jump_0A1_5214
    ld de, $C8CF
    ld a, [$C833]
    call Func_000_2458
    call Func_0A1_528B
    ld de, $8800
    call Func_000_21A1
    ld e, $80
    ld hl, $9A04
    ld b, $0B

Jump_0A1_5239::
    ld a, e
    call Func_000_121F
    inc e
    dec b
    jr nz, Jump_0A1_5239
    ret

Func_0A1_5242::
    sra a
    push af
    jr c, Jump_0A1_5255
    ld a, $03
    add a, l
    ld l, a
    jr nc, Jump_0A1_524E
    inc h

Jump_0A1_524E::
    ldh a, [$FFC6]
    inc a
    ldh [$FFC6], a
    pop af
    ret

Jump_0A1_5255::
    push bc
    push hl
    ld e, l
    ld d, h
    call Func_000_1872
    ld l, c
    inc de
    call Func_000_1872
    ld h, c
    inc de
    call Func_000_1872
    ld b, c
    ld e, l
    ld d, h
    inc de
    inc de
    inc de
    inc de
    inc de
    call Func_000_1872
    ldh a, [$FFC6]
    ld l, a
    ldh a, [$FFC7]
    ld h, a
    ld a, c
    call Func_000_1211
    pop hl
    ld a, $03
    add a, l
    ld l, a
    jr nc, Jump_0A1_5283
    inc h

Jump_0A1_5283::
    ldh a, [$FFC6]
    inc a
    ldh [$FFC6], a
    pop bc
    pop af
    ret

Func_0A1_528B::
    push hl
    push de
    ld hl, $C8CF
    ld bc, $0000

Jump_0A1_5293::
    inc b
    ld a, [hl+]
    cp a, $8D
    jr z, Jump_0A1_5293
    cp a, $8E
    jr z, Jump_0A1_5293
    inc c
    cp a, $F0
    jr z, Jump_0A1_52A4
    jr Jump_0A1_5293

Jump_0A1_52A4::
    ld a, $0D
    sub a, c
    srl a
    jr z, Jump_0A1_52D1
    ld c, b
    ld b, a
    ld a, c
    add a, b
    ld de, $C8CF
    add a, e
    ld e, a
    jr nc, Jump_0A1_52B7
    inc d

Jump_0A1_52B7::
    ld a, c
    ld hl, $C8CF
    add a, l
    ld l, a
    jr nc, Jump_0A1_52C0
    inc h

Jump_0A1_52C0::
    inc c

Jump_0A1_52C1::
    ld a, [hl]
    ld [de], a
    dec hl
    dec de
    dec c
    jr nz, Jump_0A1_52C1
    ld hl, $C8CF

Jump_0A1_52CB::
    ld [hl], $90
    inc hl
    dec b
    jr nz, Jump_0A1_52CB

Jump_0A1_52D1::
    pop de
    pop hl
    ret

Func_0A1_52D4::
    ld a, [$C944]
    add a, a
    add a, a
    add a, a
    ld hl, Data_0A1_533C
    add a, l
    ld l, a
    jr nc, Jump_0A1_52E2
    inc h

Jump_0A1_52E2::
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    ld b, a
    push hl
    push de
    call Func_0A1_5764
    pop de
    ld a, $5D
    call Func_000_15DE
    pop hl
    ld hl, $8800
    ld b, $58

Jump_0A1_52FB::
    ld a, $FF
    call Func_000_121F
    xor a, a
    call Func_000_121F
    dec b
    jr nz, Jump_0A1_52FB
    ldh a, [$FF90]
    add a, $0A
    ld [$C529], a
    xor a, a
    ld [$C528], a
    ld de, $C8CF
    ld a, e
    ld [$C53D], a
    ld a, d
    ld [$C53E], a
    ld hl, Func_008_4016
    ld b, $08
    rst $10
    call Func_0A1_528B
    ld de, $8800
    call Func_000_21A1
    ld e, $80
    ld hl, $9A04
    ld b, $0B

Jump_0A1_5333::
    ld a, e
    call Func_000_121F
    inc e
    dec b
    jr nz, Jump_0A1_5333
    ret

Data_0A1_533C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $28533C, $58

Func_0A1_5394::
    ld a, [$CC44]
    bit 7, a
    jp nz, Jump_0A1_5406
    ldh a, [$FF90]
    ld c, $01
    cp a, $30
    jr c, Jump_0A1_53DC
    ld c, $02
    cp a, $48
    jr c, Jump_0A1_53DC
    ld c, $03
    cp a, $70
    jr c, Jump_0A1_53DC
    ld c, $04
    cp a, $A0
    jr c, Jump_0A1_53DC
    ld c, $05
    cp a, $A8
    jr c, Jump_0A1_53DC
    ld c, $06
    cp a, $B0
    jr c, Jump_0A1_53DC
    ld c, $07
    cp a, $B8
    jr c, Jump_0A1_53DC
    ld c, $08
    cp a, $C8
    jr c, Jump_0A1_53DC
    ld c, $09
    cp a, $D1
    jr c, Jump_0A1_53DC
    ld c, $0A
    cp a, $DA
    jr c, Jump_0A1_53DC
    ld c, $0B

Jump_0A1_53DC::
    ld a, [$C88E]
    or a, a
    jr z, Jump_0A1_53F1
    ld a, [$C891]
    cp a, c
    jr nz, Jump_0A1_53F1
    ld a, [$C890]
    ldh [$FFC7], a
    call Func_0A1_542E
    ret

Jump_0A1_53F1::
    ld a, c
    dec a
    sla a
    sla a
    ld hl, Data_0A1_59D6
    add a, l
    ld l, a
    jr nc, Jump_0A1_53FF
    inc h

Jump_0A1_53FF::
    ld a, [hl]
    ldh [$FFC7], a
    call Func_0A1_542E
    ret

Jump_0A1_5406::
    ld a, [$C88E]
    or a, a
    jr z, Jump_0A1_5425
    ld a, [$C891]
    bit 7, a
    jr z, Jump_0A1_5425
    and a, $7F
    ld c, a
    ld a, [$CC42]
    cp a, c
    jr nz, Jump_0A1_5425
    ld a, [$C890]
    ldh [$FFC7], a
    call Func_0A1_542E
    ret

Jump_0A1_5425::
    ld a, [$CD08]
    ldh [$FFC7], a
    call Func_0A1_542E
    ret

Func_0A1_542E::
    ldh a, [$FFC7]
    and a, $F0
    swap a
    sla a
    sla a
    sla a
    ld c, a
    ld a, [$C945]
    sla a
    sla a
    sla a
    add a, c
    ldh [$FFA9], a
    ldh a, [$FFC7]
    and a, $0F
    sla a
    sla a
    sla a
    ld c, a
    ld a, [$C946]
    sla a
    sla a
    sla a
    add a, c
    ldh [$FFAB], a
    ld a, $10
    ldh [$FFAF], a
    ld a, $01
    ldh [$FFB0], a
    ld a, $26
    ldh [$FFAD], a
    xor a, a
    ldh [$FFAE], a
    xor a, a
    ldh [$FFAA], a
    ldh [$FFAC], a
    ld hl, Func_07F_700A
    ld b, $7F
    rst $10
    ret

Func_0A1_5479::
    ld a, [$C5F0]
    bit 5, a
    ret z
    ld a, [$CC44]
    bit 7, a
    jp nz, Jump_0A1_55A1
    ldh a, [$FF90]
    ld c, $01
    cp a, $29
    jp z, Jump_0A1_553D
    ld c, $02
    cp a, $45
    jp z, Jump_0A1_553D
    ld c, $03
    cp a, $68
    jp z, Jump_0A1_553D
    ld c, $04
    cp a, $9D
    jp z, Jump_0A1_553D
    ld c, $05
    cp a, $A4
    jp z, Jump_0A1_553D
    ld c, $06
    cp a, $AF
    jp z, Jump_0A1_553D
    ld c, $07
    cp a, $B2
    jp z, Jump_0A1_553D
    ld c, $08
    cp a, $C5
    jr z, Jump_0A1_553D
    ld c, $09
    cp a, $D0
    jr z, Jump_0A1_553D
    ld c, $0A
    cp a, $D9
    jr z, Jump_0A1_553D
    ld c, $0B
    cp a, $E2
    jr z, Jump_0A1_553D
    cp a, $20
    jr z, Jump_0A1_5523
    cp a, $30
    jr z, Jump_0A1_5523
    cp a, $48
    jr z, Jump_0A1_5523
    cp a, $70
    jr z, Jump_0A1_5523
    cp a, $A0
    jr z, Jump_0A1_5523
    cp a, $A8
    jr z, Jump_0A1_5523
    cp a, $B0
    jr z, Jump_0A1_5523
    cp a, $B8
    jr z, Jump_0A1_5523
    cp a, $C8
    jr z, Jump_0A1_5523
    cp a, $D1
    jr z, Jump_0A1_5523
    cp a, $DA
    jr z, Jump_0A1_5523
    ld c, a
    ld hl, Data_0A1_5A92

Jump_0A1_5502::
    ld a, [hl]
    cp a, c
    jr z, Jump_0A1_550D
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    jr Jump_0A1_5502

Jump_0A1_550D::
    ld a, [$C88B]
    dec a
    dec a
    jr nz, Jump_0A1_5516
    inc hl
    inc hl

Jump_0A1_5516::
    inc hl
    ld a, [hl+]
    call Func_0A1_5581
    ld a, [hl]
    call Func_0A1_5591
    call Func_0A1_5639
    ret

Jump_0A1_5523::
    ldh a, [$FF8F]
    sla a
    sla a
    sla a
    call Func_0A1_5581
    ldh a, [$FF92]
    sla a
    sla a
    sla a
    call Func_0A1_5591
    call Func_0A1_5639
    ret

Jump_0A1_553D::
    ld a, [$C88E]
    or a, a
    jr z, Jump_0A1_5565
    ld a, [$C891]
    cp a, c
    jr nz, Jump_0A1_5565
    ld a, [$C890]
    and a, $F0
    swap a
    add a, a
    add a, a
    add a, a
    call Func_0A1_5581
    ld a, [$C890]
    and a, $0F
    add a, a
    add a, a
    add a, a
    call Func_0A1_5591
    call Func_0A1_5639
    ret

Jump_0A1_5565::
    ld a, [$CD08]
    and a, $F0
    swap a
    add a, a
    add a, a
    add a, a
    call Func_0A1_5581
    ld a, [$CD08]
    and a, $0F
    add a, a
    add a, a
    add a, a
    call Func_0A1_5591
    call Func_0A1_5639
    ret

Func_0A1_5581::
    ld c, a
    ld a, [$C945]
    sla a
    sla a
    sla a
    add a, c
    add a, $06
    ldh [$FFA9], a
    ret

Func_0A1_5591::
    ld c, a
    ld a, [$C946]
    sla a
    sla a
    sla a
    add a, c
    add a, $06
    ldh [$FFAB], a
    ret

Jump_0A1_55A1::
    ld a, [$CC44]
    and a, $07
    rst $00
    dw Jump_0A1_5523
    dw Jump_0A1_55B7
    dw Jump_0A1_55B7
    dw Jump_0A1_55D5
    dw Jump_0A1_55D5
    dw Jump_0A1_55D5
    dw Jump_0A1_55D5
    dw Jump_0A1_55E9

Jump_0A1_55B7::
    ld a, [$CC45]
    and a, $07
    sla a
    sla a
    ld hl, $CD78
    add a, l
    ld l, a
    jr nc, Jump_0A1_55C8
    inc h

Jump_0A1_55C8::
    ld a, [$CC45]
    bit 7, a
    jr z, Jump_0A1_55D0
    inc hl

Jump_0A1_55D0::
    ld a, [hl]
    call Func_0A1_560D
    ret

Jump_0A1_55D5::
    ld a, [$CC45]
    and a, $07
    add a, a
    add a, a
    ld hl, $CD88
    add a, l
    ld l, a
    jr nc, Jump_0A1_55E4
    inc h

Jump_0A1_55E4::
    ld a, [hl]
    call Func_0A1_560D
    ret

Jump_0A1_55E9::
    ld a, [$C88E]
    or a, a
    jr z, Jump_0A1_5606
    ld a, [$C891]
    bit 7, a
    jr z, Jump_0A1_5606
    and a, $7F
    ld c, a
    ld a, [$CC42]
    cp a, c
    jr nz, Jump_0A1_5606
    ld a, [$C890]
    call Func_0A1_560D
    ret

Jump_0A1_5606::
    ld a, [$CD08]
    call Func_0A1_560D
    ret

Func_0A1_560D::
    push af
    and a, $F0
    srl a
    ld c, a
    ld a, [$C945]
    sla a
    sla a
    sla a
    add a, c
    add a, $06
    ldh [$FFA9], a
    pop af
    and a, $0F
    sla a
    sla a
    sla a
    ld c, a
    ld a, [$C946]
    sla a
    sla a
    sla a
    add a, c
    add a, $06
    ldh [$FFAB], a

Func_0A1_5639::
    ld a, $00
    ldh [$FFAF], a
    ld a, $00
    ldh [$FFB0], a
    ld a, $08
    ldh [$FFAD], a
    xor a, a
    ldh [$FFAE], a
    xor a, a
    ldh [$FFAA], a
    ldh [$FFAC], a
    ld hl, Func_07F_700A
    ld b, $7F
    rst $10
    ret

Func_0A1_5654::
    ld a, [$CC44]
    bit 7, a
    jr nz, Jump_0A1_5694
    ld a, [$C944]
    add a, a
    ld hl, Data_0A1_5A00
    add a, l
    ld l, a
    jr nc, Jump_0A1_5667
    inc h

Jump_0A1_5667::
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld a, [de]
    or a, a
    ret z
    inc de
    ld b, a

Jump_0A1_5670::
    push bc
    push de
    ld a, [de]
    ld c, a
    ld a, [$C945]
    add a, a
    add a, a
    add a, a
    add a, c
    ldh [$FFA9], a
    inc de
    ld a, [de]
    ld c, a
    ld a, [$C946]
    add a, a
    add a, a
    add a, a
    add a, c
    ldh [$FFAB], a
    call Func_0A1_56DC
    pop de
    inc de
    inc de
    pop bc
    dec b
    jr nz, Jump_0A1_5670
    ret

Jump_0A1_5694::
    ld de, $CD8B

Jump_0A1_5697::
    ld a, [de]
    cp a, $FF
    ret z
    push de
    dec de
    dec de
    dec de
    ld a, [de]
    ld a, [$C950]
    or a, a
    jr nz, Jump_0A1_56AD
    ld a, [de]
    call Func_0A1_58BA
    or a, a
    jr z, Jump_0A1_56D2

Jump_0A1_56AD::
    ld a, [de]
    swap a
    and a, $0F
    add a, a
    add a, a
    add a, a
    ld c, a
    ld a, [$C945]
    add a, a
    add a, a
    add a, a
    add a, c
    ldh [$FFA9], a
    ld a, [de]
    and a, $0F
    add a, a
    add a, a
    add a, a
    ld c, a
    ld a, [$C946]
    add a, a
    add a, a
    add a, a
    add a, c
    ldh [$FFAB], a
    call Func_0A1_56DC

Jump_0A1_56D2::
    pop de
    ld a, $04
    add a, e
    ld e, a
    jr nc, Jump_0A1_56DA
    inc d

Jump_0A1_56DA::
    jr Jump_0A1_5697

Func_0A1_56DC::
    ld a, $10
    ldh [$FFAF], a
    ld a, $01
    ldh [$FFB0], a
    ld a, $26
    ldh [$FFAD], a
    xor a, a
    ldh [$FFAE], a
    xor a, a
    ldh [$FFAA], a
    ldh [$FFAC], a
    ld hl, Func_07F_700A
    ld b, $7F
    rst $10
    ret

Func_0A1_56F7::
    ld a, [$CC44]
    bit 7, a
    ret z
    ld de, $CD7B

Jump_0A1_5700::
    ld a, [de]
    cp a, $FF
    ret z
    push de
    dec de
    dec de
    dec de
    call Func_0A1_5719
    inc de
    call Func_0A1_5719
    pop de
    ld a, $04
    add a, e
    ld e, a
    jr nc, Jump_0A1_5717
    inc d

Jump_0A1_5717::
    jr Jump_0A1_5700

Func_0A1_5719::
    ld a, [$C950]
    or a, a
    jr nz, Jump_0A1_5725
    ld a, [de]
    call Func_0A1_58BA
    or a, a
    ret z

Jump_0A1_5725::
    ld a, [de]
    swap a
    and a, $0F
    add a, a
    add a, a
    add a, a
    ld c, a
    ld a, [$C945]
    add a, a
    add a, a
    add a, a
    add a, c
    ldh [$FFA9], a
    ld a, [de]
    and a, $0F
    add a, a
    add a, a
    add a, a
    ld c, a
    ld a, [$C946]
    add a, a
    add a, a
    add a, a
    add a, c
    ldh [$FFAB], a
    ld a, $10
    ldh [$FFAF], a
    ld a, $01
    ldh [$FFB0], a
    ld a, $26
    ldh [$FFAD], a
    xor a, a
    ldh [$FFAE], a
    xor a, a
    ldh [$FFAA], a
    ldh [$FFAC], a
    push de
    ld hl, Func_07F_700A
    ld b, $7F
    rst $10
    pop de
    ret

Func_0A1_5764::
    ld a, c
    srl a
    ld l, a
    ld a, $09
    sub a, l
    ld [$C946], a
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $98
    ld h, a
    ld a, b
    srl a
    ld e, a
    ld a, $0A
    sub a, e
    ld [$C945], a
    add a, l
    ld l, a
    jr nc, Jump_0A1_578D
    inc h

Jump_0A1_578D::
    ret

Func_0A1_578E::
    ld hl, $9800
    ld bc, $0400

Jump_0A1_5794::
    ld a, $57
    call Func_000_121F
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_0A1_5794
    ret

Func_0A1_579F::
    ld a, [$C525]
    or a, a
    ret z
    ld c, $4F
    ld a, $01
    ldh [c], a
    ld hl, $9800
    ld bc, $0400

Jump_0A1_57AF::
    xor a, a
    call Func_000_121F
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_0A1_57AF
    ld c, $4F
    ld a, $00
    ldh [c], a
    ret

Func_0A1_57BE::
    ld a, [$C525]
    or a, a
    ret z
    ld c, $4F
    ld a, $01
    ldh [c], a
    ld hl, $9800
    ld bc, $0400

Jump_0A1_57CE::
    ld a, $01
    call Func_000_121F
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_0A1_57CE
    ld hl, $9864
    ld c, $0C

Jump_0A1_57DD::
    push hl
    ld b, $0C

Jump_0A1_57E0::
    xor a, a
    call Func_000_1211
    inc hl
    dec b
    jr nz, Jump_0A1_57E0
    pop hl
    ld a, $20
    add a, l
    ld l, a
    jr nc, Jump_0A1_57F0
    inc h

Jump_0A1_57F0::
    dec c
    jr nz, Jump_0A1_57DD
    ld c, $4F
    ld a, $00
    ldh [c], a
    ret

Func_0A1_57F9::
    ld de, Data_0A1_5808
    ld bc, $0C0C
    ld hl, $9864
    ld a, $A1
    call Func_000_15DE
    ret

Data_0A1_5808:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $90, $34

Func_0A1_5898::
    ld a, $03
    ld [$C5E0], a
    ld a, $40
    ld [$D067], a
    ld hl, Func_002_4628
    ld b, $02
    rst $10
    ld hl, $C5E9
    ld a, $D2
    ld [hl+], a
    ld a, $D2
    ld [hl+], a
    ld a, $E2
    ld [hl], a
    ld a, $01
    ld [$C5DB], a
    ret

Func_0A1_58BA::
    push bc
    push hl
    ldh [$FFC6], a
    and a, $0F
    and a, $FC
    ld hl, $CE93
    add a, l
    ld l, a
    jr nc, Jump_0A1_58CA
    inc h

Jump_0A1_58CA::
    ldh a, [$FFC6]
    swap a
    and a, $0F
    srl a
    and a, $FE
    add a, l
    ld l, a
    jr nc, Jump_0A1_58D9
    inc h

Jump_0A1_58D9::
    ldh a, [$FFC6]
    bit 1, a
    jr z, Jump_0A1_58E0
    inc hl

Jump_0A1_58E0::
    ld c, $01
    bit 0, a
    jr z, Jump_0A1_58E8
    ld c, $10

Jump_0A1_58E8::
    ldh a, [$FFC6]
    swap a
    and a, $03
    jr z, Jump_0A1_58F6
    ld b, a

Jump_0A1_58F1::
    sla c
    dec b
    jr nz, Jump_0A1_58F1

Jump_0A1_58F6::
    ld a, [hl]
    and a, c
    jr nz, Jump_0A1_58FE
    xor a, a
    pop hl
    pop bc
    ret

Jump_0A1_58FE::
    ld a, $01
    pop hl
    pop bc
    ret

Func_0A1_5903::
    xor a, a
    ldh [$FFC6], a
    ld a, [$C56C]
    or a, a
    ret nz
    ld a, [$C8CB]
    and a, $03
    ret nz
    ld a, [$C468]
    bit 7, a
    ret nz
    ldh a, [$FF8C]
    bit 0, a
    ret nz
    ld a, [$CC44]
    bit 7, a
    jp nz, Jump_0A1_59AE
    ldh a, [$FF90]
    cp a, $20
    ret c
    ld c, $00
    cp a, $30
    jr c, Jump_0A1_595D
    inc c
    cp a, $48
    jr c, Jump_0A1_595D
    inc c
    cp a, $70
    jr c, Jump_0A1_595D
    inc c
    cp a, $A0
    jr c, Jump_0A1_595D
    inc c
    cp a, $A8
    jr c, Jump_0A1_595D
    inc c
    cp a, $B0
    jr c, Jump_0A1_595D
    inc c
    cp a, $B8
    jr c, Jump_0A1_595D
    inc c
    cp a, $C8
    jr c, Jump_0A1_595D
    inc c
    cp a, $D1
    jr c, Jump_0A1_595D
    inc c
    cp a, $DA
    jr c, Jump_0A1_595D
    inc c

Jump_0A1_595D::
    ld a, c
    ld [$C944], a
    ld a, $01
    ldh [$FFC6], a
    ld a, $01
    ld [$C8C7], a
    ld hl, Func_002_5EEE
    ld b, $02
    rst $10
    ld a, $08
    ld [$C5DC], a
    ldh a, [$FF90]
    cp a, $20
    jr z, Jump_0A1_59A9
    cp a, $30
    jr z, Jump_0A1_59A9
    cp a, $48
    jr z, Jump_0A1_59A9
    cp a, $70
    jr z, Jump_0A1_59A9
    cp a, $A0
    jr z, Jump_0A1_59A9
    cp a, $A8
    jr z, Jump_0A1_59A9
    cp a, $B0
    jr z, Jump_0A1_59A9
    cp a, $B8
    jr z, Jump_0A1_59A9
    cp a, $C8
    jr z, Jump_0A1_59A9
    cp a, $D1
    jr z, Jump_0A1_59A9
    cp a, $DA
    jr z, Jump_0A1_59A9
    ld a, $03
    ld [$C5DD], a
    ret

Jump_0A1_59A9::
    xor a, a
    ld [$C5DD], a
    ret

Jump_0A1_59AE::
    ld a, $01
    ldh [$FFC6], a
    ld a, $01
    ld [$C8C7], a
    ld hl, Func_002_5EEE
    ld b, $02
    rst $10
    ld a, $08
    ld [$C5DC], a
    ld a, [$CC44]
    and a, $7F
    jr nz, Jump_0A1_59CE
    xor a, a
    ld [$C5DD], a
    ret

Jump_0A1_59CE::
    ld a, $03
    ld [$C5DD], a
    ret
    db $01, $01

Data_0A1_59D6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $44, $39, $31, $76, $44, $59, $21, $B4, $44, $59, $21, $B4, $44, $09, $01
    db $10, $44, $01, $01, $00, $44, $01, $09, $01, $44, $21, $21, $44, $44, $01, $09
    db $01, $44, $01, $01, $00, $44, $01, $01, $00, $44

Data_0A1_5A00:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_0A1_5A16
    dw Data_0A1_5A1B
    dw Data_0A1_5A22
    dw Data_0A1_5A2D
    dw Data_0A1_5A34
    dw Data_0A1_5A35
    dw Data_0A1_5A38
    dw Data_0A1_5A3B
    dw Data_0A1_5A40
    dw Data_0A1_5A43
    dw Data_0A1_5A46

Data_0A1_5A16:: ; heuristic: target of a monotone pointer table; C0
    db $02, $11, $09, $11, $29

Data_0A1_5A1B:: ; heuristic: target of a monotone pointer table; C0
    db $03, $29, $31, $21, $11, $11, $21

Data_0A1_5A22:: ; heuristic: target of a monotone pointer table; C0
    db $05, $41, $11, $39, $29, $21, $41, $11, $49, $49, $49

Data_0A1_5A2D:: ; heuristic: target of a monotone pointer table; C0
    db $03, $59, $09, $29, $31, $29, $49

Data_0A1_5A34:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_0A1_5A35:: ; heuristic: target of a monotone pointer table; C0
    db $01, $11, $21

Data_0A1_5A38:: ; heuristic: target of a monotone pointer table; C0
    db $01, $09, $01

Data_0A1_5A3B:: ; heuristic: target of a monotone pointer table; C0
    db $02, $21, $19, $09, $09

Data_0A1_5A40:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $01

Data_0A1_5A43:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $09

Data_0A1_5A46:: ; heuristic: target of a monotone pointer table; C0
    db $01, $09, $01

Data_0A1_5A49:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_0A1_5A5F
    dw Data_0A1_5A64
    dw Data_0A1_5A6B
    dw Data_0A1_5A76
    dw Data_0A1_5A7D
    dw Data_0A1_5A7E
    dw Data_0A1_5A81
    dw Data_0A1_5A84
    dw Data_0A1_5A89
    dw Data_0A1_5A8C
    dw Data_0A1_5A8F

Data_0A1_5A5F:: ; heuristic: target of a monotone pointer table; C0
    db $02, $21, $44, $25, $44

Data_0A1_5A64:: ; heuristic: target of a monotone pointer table; C0
    db $03, $56, $44, $42, $44, $24, $44

Data_0A1_5A6B:: ; heuristic: target of a monotone pointer table; C0
    db $05, $82, $44, $75, $44, $48, $44, $29, $44, $99, $44

Data_0A1_5A76:: ; heuristic: target of a monotone pointer table; C0
    db $03, $B1, $44, $56, $64, $59, $44

Data_0A1_5A7D:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_0A1_5A7E:: ; heuristic: target of a monotone pointer table; C0
    db $01, $24, $44

Data_0A1_5A81:: ; heuristic: target of a monotone pointer table; C0
    db $01, $10, $44

Data_0A1_5A84:: ; heuristic: target of a monotone pointer table; C0
    db $02, $43, $44, $11, $35

Data_0A1_5A89:: ; heuristic: target of a monotone pointer table; C0
    db $01, $00, $44

Data_0A1_5A8C:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $44

Data_0A1_5A8F:: ; heuristic: target of a monotone pointer table; C0
    db $01, $10, $44

Data_0A1_5A92:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $285A92, $7C

Data_0A1_5B0E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $3E, $31, $0D, $00, $00, $3F, $31, $0D, $00, $00, $40, $31, $0D, $00, $00
    db $41, $11, $21, $00, $00, $42, $29, $29, $00

Data_0A1_5B27:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $43, $29, $29, $00, $00, $44, $29, $29, $00, $00, $49, $29, $01, $00, $00
    db $4A, $41, $11, $00, $00, $4B, $41, $11, $00, $00, $4C, $41, $11, $00, $00

Data_0A1_5B46:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $285B46, $4F
    dw Data_0A1_5D00
    db $28, $51, $00
    dw Data_0A1_5E00
    db $49, $49, $00
    dw Data_0A1_5F00
    db $49, $49, $00
    dw Data_0A1_6000
    db $49, $49, $00
    dw Data_0A1_6100
    db $49, $49, $00
    dw Data_0A1_6200
    db $51, $29, $00
    dw Data_0A1_6300
    db $41, $39, $00
    dw Data_0A1_6400
    db $41, $39, $00
    dw Data_0A1_6500
    db $41, $39, $00
    dw Data_0A1_6600
    db $41, $39, $00
    dw Data_0A1_6700
    db $41, $39, $00
    dw Data_0A1_7100
    db $59, $09, $00
    dw Data_0A1_7200
    db $59, $09, $00
    dw Data_0A1_7300
    db $59, $09, $00
    dw Data_0A1_7400
    db $59, $09, $00
    dw Data_0A1_7500
    db $59, $09, $00
    dw Data_0A1_7600
    db $59, $09, $00
    dw Data_0A1_7700
    db $51, $21, $49
    dw Data_0A1_7821
    db $29, $31, $00
    dw Data_0A1_7900
    db $29, $31, $00
    dw Data_0A1_7A00
    db $01, $21, $00
    dw Data_0A1_7B00
    db $19, $31, $19
    dw Data_0A1_7C39
    db $29, $49, $00
    dw Data_0A1_7D00
    db $29, $49, $00
    dw Data_0A1_7E00
    db $29, $49, $00
    dw Data_0A1_7F00
    INCBIN "dwm2-cobi-us.gbc", $285C14, $EC

Data_0A1_5D00:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $285D00, $45

Data_0A1_5D45:: ; heuristic: target of a monotone pointer table; C0
    db $01, $09, $00, $00, $D3, $01

Data_0A1_5D4B:: ; heuristic: target of a monotone pointer table; C0
    db $09, $00, $00, $D4, $01, $09, $00

Data_0A1_5D52:: ; heuristic: target of a monotone pointer table; C0
    db $00, $D5, $01, $09, $00, $00, $D6, $01, $09, $00, $00, $D7, $01, $09

Data_0A1_5D60:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $DB, $09, $01, $00, $00, $DC, $09, $01, $00, $00, $DD, $09

Data_0A1_5D6E:: ; heuristic: target of a monotone pointer table; C0
    db $01

Data_0A1_5D6F:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $DE

Data_0A1_5D72:: ; heuristic: target of a monotone pointer table; C0
    db $09

Data_0A1_5D73:: ; heuristic: target of a monotone pointer table; C0
    db $01, $00

Data_0A1_5D75:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_0A1_5D76:: ; heuristic: target of a monotone pointer table; C0
    db $DF, $09, $01, $00, $00, $E0, $09, $01, $00, $00

Data_0A1_5D80:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $285D80, $80

Data_0A1_5E00:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $285E00, $92
    dw Data_0A1_6000
    db $99, $44, $00
    dw Data_0A1_6100
    db $99, $44, $00
    dw Data_0A1_6200
    db $A5, $44, $00
    dw Data_0A1_6300
    db $87, $44, $00
    dw Data_0A1_6400
    db $87, $44, $00
    dw Data_0A1_6500
    db $87, $44, $00
    dw Data_0A1_6600
    db $87, $44, $00
    dw Data_0A1_6700
    db $87, $44, $00
    dw Data_0A1_7100
    db $B1, $44, $00
    dw Data_0A1_7200
    db $B1, $44, $00
    dw Data_0A1_7300
    db $B1, $44, $00
    dw Data_0A1_7400
    db $B1, $44, $00
    dw Data_0A1_7500
    db $B1, $44, $00
    dw Data_0A1_7600
    db $B1, $44, $00
    dw Data_0A1_7700
    db $A4, $44, $94
    dw Data_0A1_7844
    db $56, $44, $00
    dw Data_0A1_7900
    db $56, $44, $00
    dw Data_0A1_7A00
    db $04, $44, $00
    dw Data_0A1_7B00
    db $36, $44, $37
    dw Data_0A1_7C44
    db $59, $44, $00
    dw Data_0A1_7D00
    db $59, $44, $00
    dw Data_0A1_7E00
    db $59, $44, $00

Data_0A1_5F00:: ; heuristic: target of a monotone pointer table; C0
    dw Data_0A1_7F00
    INCBIN "dwm2-cobi-us.gbc", $285F02, $FE

Data_0A1_6000:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $286000, $6C
    ds $94, $00

Data_0A1_6100:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_0A1_6200:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_0A1_6300:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_0A1_6400:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_0A1_6500:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_0A1_6600:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_0A1_6700:: ; heuristic: target of a monotone pointer table; C0
    ds $A00, $00

Data_0A1_7100:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_0A1_7200:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_0A1_7300:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_0A1_7400:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_0A1_7500:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_0A1_7600:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_0A1_7700:: ; heuristic: target of a monotone pointer table; C0
    ds $121, $00

Data_0A1_7821:: ; heuristic: target of a monotone pointer table; C0
    ds $23, $00

Data_0A1_7844:: ; heuristic: target of a monotone pointer table; C0
    ds $BC, $00

Data_0A1_7900:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_0A1_7A00:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_0A1_7B00:: ; heuristic: target of a monotone pointer table; C0
    ds $139, $00

Data_0A1_7C39:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Data_0A1_7C44:: ; heuristic: target of a monotone pointer table; C0
    ds $BC, $00

Data_0A1_7D00:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_0A1_7E00:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_0A1_7F00:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00
