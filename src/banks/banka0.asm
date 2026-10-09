SECTION "Bank A0", ROMX[$4000], BANK[$A0]
    db $A0

Func_0A0_4001::
    ld hl, $D800
    ld bc, $0303
    xor a, a
    call Func_000_0949
    ld a, [$D7FE]
    ld [$D067], a
    ld hl, $CFC8
    ld bc, $0008
    xor a, a
    call Func_000_0949
    ld hl, $CFD0
    ld bc, $0008
    xor a, a
    call Func_000_0949
    ld a, $0A
    ld [$CFC5], a
    call Func_0A0_40B0
    ld hl, $D09D
    ld bc, $0200
    xor a, a
    call Func_000_0949
    call Func_0A0_42E3
    call Func_0A0_4181
    call Func_0A0_415D
    call Func_0A0_42D3
    call Func_0A0_46A1
    ret

Func_0A0_4047::
    xor a, a
    ld hl, $DA67
    ld [hl+], a
    ld [hl+], a
    ld a, [$D78E]
    cp a, $02
    jr z, Jump_0A0_405B
    xor a, a
    ld [hl+], a
    ld a, $FF
    ld [hl], a
    jr Jump_0A0_405F

Jump_0A0_405B::
    ld a, $FF
    ld [hl+], a
    ld [hl], a

Jump_0A0_405F::
    ld hl, $DA5B
    ld a, $00
    call Func_000_3E54
    jr nc, Jump_0A0_406B
    ld a, $03

Jump_0A0_406B::
    ld [hl+], a
    ld a, $01
    call Func_000_3E54
    ld a, $00
    jr nc, Jump_0A0_4077
    ld a, $03

Jump_0A0_4077::
    ld [hl+], a
    ld a, $FF
    ld [hl+], a
    ld a, $03
    call Func_000_3E54
    ld a, $00
    jr nc, Jump_0A0_4086
    ld a, $FF

Jump_0A0_4086::
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld [hl+], a
    ld a, [$D78E]
    cp a, $02
    jr z, Jump_0A0_409A
    ld a, $01
    ld [hl+], a
    ld a, $FF
    ld [hl], a
    jr Jump_0A0_409E

Jump_0A0_409A::
    ld a, $FF
    ld [hl+], a
    ld [hl], a

Jump_0A0_409E::
    xor a, a
    ld [$D891], a
    ld hl, $D868
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ret

Func_0A0_40B0::
    ld a, $FF
    ld [$D802], a
    ld [$DAAC], a
    ld [$DAAD], a
    ld [$D892], a
    ld hl, $C46B
    ld bc, $0008
    xor a, a
    call Func_000_0949
    xor a, a
    ld [$C5FC], a
    ld [$C5FD], a
    ld [$C5FE], a
    ld hl, $DA5B
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld a, $FF
    ld [hl], a
    ld hl, $DAD8
    ld bc, $0008
    ld a, $80
    call Func_000_0949
    ld hl, $DA63
    ld bc, $0008
    ld a, $FF
    call Func_000_0949
    ld hl, $D958
    ld bc, $0010
    ld a, $FF
    call Func_000_0949
    ld a, $FF
    ld hl, $DA08
    ld bc, $0020
    call Func_000_0949
    ld a, $FF
    ld hl, $DAD4
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ld a, $FF
    ld [$DAAB], a
    ld a, $0A
    ld [$D89F], a
    ld hl, $D895
    ld bc, $000A
    ld a, $FF
    call Func_000_0949
    xor a, a
    ld [$D891], a
    ld a, $00
    ld [$D092], a
    xor a, a
    ld [$CFD8], a
    ld [$CFD9], a
    ld [$CFDA], a
    ld [$D04B], a
    ld a, $00
    ld [$D78E], a
    ld a, $02
    ld [$D88F], a
    ld a, $03
    ld [$D890], a
    ld a, [$C835]
    ld [$CFDB], a
    ld a, $03
    ld [$C964], a
    ret

Func_0A0_415D::
    ld hl, $71F5
    ld b, $31
    rst $10
    call Func_0A0_4B10
    call Func_0A0_4C2C
    call Func_0A0_4C52
    call Func_000_290E
    ld hl, $7276
    ld b, $1A
    rst $10
    ld hl, $9800
    call Func_0A0_42B2
    ld a, $7F
    ld [$C526], a
    ret

Func_0A0_4181::
    ld bc, $0200

Jump_0A0_4184::
    push bc
    call Func_0A0_43F7
    pop bc
    inc c
    dec b
    jr nz, Jump_0A0_4184
    ret

Func_0A0_418E::
    ld bc, $0204
    jr Jump_0A0_4196

Func_0A0_4193::
    ld bc, $0304

Jump_0A0_4196::
    push bc
    call Func_0A0_43F7
    pop bc
    inc c
    dec b
    jr nz, Jump_0A0_4196
    call Func_0A0_41F2
    ld de, $D8A7
    ld bc, $0800

Jump_0A0_41A8::
    push bc
    ld a, c
    ld hl, $DA63
    add a, l
    ld l, a
    jr nc, Jump_0A0_41B2
    inc h

Jump_0A0_41B2::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_0A0_41DC
    ld a, c
    add a, a
    ld hl, $D958
    add a, l
    ld l, a
    jr nc, Jump_0A0_41C1
    inc h

Jump_0A0_41C1::
    ld a, [hl+]
    ld [$D006], a
    ld a, [hl]
    ld [$D007], a
    push de
    ld hl, $4001
    ld b, $35
    rst $10
    pop de
    ld a, [$D00B]
    ld h, a
    ld a, [$D00A]
    swap a
    or a, h
    ld [de], a

Jump_0A0_41DC::
    pop bc
    inc de
    inc c
    dec b
    jr nz, Jump_0A0_41A8
    ret

Func_0A0_41E3::
    push bc
    push hl
    ld hl, $D008
    ld bc, $002F
    xor a, a
    call Func_000_0949
    pop hl
    pop bc
    ret

Func_0A0_41F2::
    ld bc, $0800
    ld hl, $D8AF

Jump_0A0_41F8::
    ld a, c
    call Func_000_3E54
    jr c, Jump_0A0_4203
    ld a, [hl]
    or a, a
    call z, Func_0A0_4240

Jump_0A0_4203::
    inc c
    inc hl
    dec b
    jr nz, Jump_0A0_41F8
    ld bc, $0304
    ld hl, $D9C9

Jump_0A0_420E::
    ld a, c
    call Func_000_3E54
    jr c, Jump_0A0_4230
    ld d, $04

Jump_0A0_4216::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_0A0_4230
    cp a, $34
    jr nz, Jump_0A0_4224
    call Func_0A0_4262
    jr Jump_0A0_422B

Jump_0A0_4224::
    cp a, $35
    jr nz, Jump_0A0_422B
    call Func_0A0_4265

Jump_0A0_422B::
    inc hl
    inc hl
    dec d
    jr nz, Jump_0A0_4216

Jump_0A0_4230::
    inc c
    ld a, c
    swap a
    ld hl, $D989
    add a, l
    ld l, a
    jr nc, Jump_0A0_423C
    inc h

Jump_0A0_423C::
    dec b
    jr nz, Jump_0A0_420E
    ret

Func_0A0_4240::
    push hl
    ld a, c
    ld hl, $D989
    swap a
    add a, l
    ld l, a
    jr nc, Jump_0A0_424C
    inc h

Jump_0A0_424C::
    ld d, $08

Jump_0A0_424E::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_0A0_4259
    cp a, $8F
    jr nz, Jump_0A0_425B
    ld [hl], $AA

Jump_0A0_4259::
    pop hl
    ret

Jump_0A0_425B::
    inc hl
    inc hl
    dec d
    jr nz, Jump_0A0_424E
    pop hl
    ret

Func_0A0_4262::
    ld [hl], $AD
    ret

Func_0A0_4265::
    ld [hl], $AE
    ret

Func_0A0_4268::
    push hl
    ld a, c
    ld de, $DA63
    add a, e
    ld e, a
    jr nc, Jump_0A0_4272
    inc d

Jump_0A0_4272::
    bit 7, [hl]
    jr z, Jump_0A0_427B
    ld a, $01
    ld [de], a
    jr Jump_0A0_429A

Jump_0A0_427B::
    ld a, $00
    ld [de], a
    ld a, c
    ld de, $D80C
    add a, a
    add a, a
    add a, a
    add a, c
    add a, e
    ld e, a
    jr nc, Jump_0A0_428B
    inc d

Jump_0A0_428B::
    bit 0, [hl]
    jr z, Jump_0A0_4292
    ld a, $20
    ld [de], a

Jump_0A0_4292::
    bit 2, [hl]
    jr z, Jump_0A0_429A
    ld a, [de]
    or a, $01
    ld [de], a

Jump_0A0_429A::
    pop hl
    ret

Func_0A0_429C::
    ld a, c
    add a, e
    ld e, a
    jr nc, Jump_0A0_42A2
    inc d

Jump_0A0_42A2::
    ld a, [hl+]
    ld [de], a
    ret

Func_0A0_42A5::
    ld a, c
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_0A0_42AC
    inc d

Jump_0A0_42AC::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    ret

Func_0A0_42B2::
    ld de, $C198
    ld bc, $1412

Jump_0A0_42B8::
    push bc
    push hl

Jump_0A0_42BA::
    ld a, [de]
    inc de
    call Func_000_121F
    dec b
    jr nz, Jump_0A0_42BA
    ld a, $0C
    add a, e
    ld e, a
    jr nc, Jump_0A0_42C9
    inc d

Jump_0A0_42C9::
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_0A0_42B8
    ret

Func_0A0_42D3::
    ld a, [$CFC5]
    or a, a
    jr nz, Jump_0A0_42DD
    ld a, $0F
    jr Jump_0A0_42DF

Jump_0A0_42DD::
    ld a, $13

Jump_0A0_42DF::
    call Func_000_122D
    ret

Func_0A0_42E3::
    ld de, $D0D5
    ld a, [$C57F]
    bit 1, a
    jr nz, Jump_0A0_42F8
    ld hl, $C986
    call Func_0A0_4301
    ld hl, $CA2B
    jr Func_0A0_4301

Jump_0A0_42F8::
    ld hl, $CA2B
    call Func_0A0_4301
    ld hl, $C986

Func_0A0_4301::
    inc hl
    ld b, $0E
    call Func_0A0_4344
    ld a, l
    add a, $25
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld b, $08
    call Func_0A0_4344
    xor a, a
    ld [de], a
    inc de
    ld a, l
    add a, $1A
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld b, $01
    call Func_0A0_4344
    inc hl
    ld b, $15
    call Func_0A0_4344
    inc hl
    inc hl
    ld b, $1F
    call Func_0A0_4344
    ld a, l
    add a, $16
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl]
    ld [de], a
    inc de
    call Func_0A0_434B
    ld a, $FF
    ld [de], a
    inc de
    ret

Func_0A0_4344::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Func_0A0_4344
    ret

Func_0A0_434B::
    or a, a
    ret z
    cp a, $0D
    ret c
    cp a, $14
    ret nc
    push af
    ld a, e
    ldh [$FFC6], a
    ld a, d
    ldh [$FFC7], a
    pop af
    push de
    sub a, $0D
    swap a
    ld de, $4387
    add a, e
    ld e, a
    jr nc, Jump_0A0_4368
    inc d

Jump_0A0_4368::
    ld a, [de]
    cp a, $80
    jr nz, Jump_0A0_436F
    pop de
    ret

Jump_0A0_436F::
    ld l, a
    ld h, $FF
    call Func_0A0_4378
    inc de
    jr Jump_0A0_4368

Func_0A0_4378::
    ldh a, [$FFC6]
    add a, l
    ld l, a
    ldh a, [$FFC7]
    adc a, h
    ld h, a
    ld a, [hl]
    cp a, $03
    ret nc
    inc a
    ld [hl], a
    ret
    INCBIN "dwm2-cobi-us.gbc", $280387, $70

Func_0A0_43F7::
    ld a, [$D868]
    push af
    ld a, c
    cp a, $04
    jr nc, Jump_0A0_4405
    call Func_0A0_4410
    jr Jump_0A0_4408

Jump_0A0_4405::
    call Func_0A0_456F

Jump_0A0_4408::
    call Func_0A0_41E3
    pop af
    ld [$D868], a
    ret

Func_0A0_4410::
    ld a, c
    push bc
    call Func_0A0_468A
    pop bc
    ld a, c
    add a, a
    ld de, $D958
    add a, e
    ld e, a
    jr nc, Jump_0A0_4420
    inc d

Jump_0A0_4420::
    ld a, l
    add a, $0A
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc hl
    ld a, c
    ld de, $D8AF
    add a, e
    ld e, a
    jr nc, Jump_0A0_4437
    inc d

Jump_0A0_4437::
    ld a, [hl]
    and a, $0F
    ld [de], a
    ld a, c
    ld de, $DA43
    add a, e
    ld e, a
    jr nc, Jump_0A0_4444
    inc d

Jump_0A0_4444::
    ld a, $00
    ld [de], a
    ld a, c
    ld de, $DA4B
    add a, e
    ld e, a
    jr nc, Jump_0A0_4450
    inc d

Jump_0A0_4450::
    ld a, $00
    ld [de], a
    inc hl
    push af
    ld a, c
    cp a, $04
    jr nc, Jump_0A0_4470
    ld a, [$C57F]
    bit 1, a
    jr nz, Jump_0A0_4488
    ld a, c
    ld de, $CFD8
    add a, e
    ld e, a
    jr nc, Jump_0A0_446A
    inc d

Jump_0A0_446A::
    pop af
    and a, $03
    ld [de], a
    jr Jump_0A0_4489

Jump_0A0_4470::
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_0A0_4488
    ld a, c
    and a, $03
    ld de, $CFD8
    add a, e
    ld e, a
    jr nc, Jump_0A0_4482
    inc d

Jump_0A0_4482::
    pop af
    and a, $03
    ld [de], a
    jr Jump_0A0_4489

Jump_0A0_4488::
    pop af

Jump_0A0_4489::
    push hl
    push bc
    ld a, [$D868]
    or a, a
    jr nz, Jump_0A0_4499
    ld hl, $434D
    ld b, $19
    rst $10
    jr Jump_0A0_449F

Jump_0A0_4499::
    ld hl, $4349
    ld b, $19
    rst $10

Jump_0A0_449F::
    pop bc
    pop hl
    ld a, l
    add a, $08
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [$D871]
    or a, a
    call z, Func_0A0_4268
    inc hl
    ld de, $D8B7
    call Func_0A0_429C
    inc hl
    inc hl
    inc hl
    ld a, [$D871]
    or a, a
    jr z, Jump_0A0_44D2
    inc hl
    inc hl
    ld de, $D8CF
    call Func_0A0_42A5
    inc hl
    inc hl
    ld de, $D8EF
    call Func_0A0_42A5
    jr Jump_0A0_44EA

Jump_0A0_44D2::
    ld de, $D8BF
    call Func_0A0_42A5
    ld de, $D8CF
    call Func_0A0_42A5
    ld de, $D8DF
    call Func_0A0_42A5
    ld de, $D8EF
    call Func_0A0_42A5

Jump_0A0_44EA::
    ld de, $D8FF
    call Func_0A0_42A5
    ld de, $D90F
    call Func_0A0_42A5
    ld de, $D91F
    call Func_0A0_42A5
    ld de, $D92F
    call Func_0A0_42A5
    ld de, $D93F
    call Func_0A0_42A5
    ld a, [$D871]
    or a, a
    jr z, Jump_0A0_452B
    ld a, [$D868]
    push hl
    ld l, a
    add a, a
    add a, a
    add a, a
    add a, l
    ld hl, $D80D
    add a, l
    ld l, a
    jr nc, Jump_0A0_451F
    inc h

Jump_0A0_451F::
    ld a, [hl]
    and a, $30
    pop hl
    jr nz, Jump_0A0_452B
    inc hl
    inc hl
    inc hl
    inc hl
    jr Jump_0A0_4543

Jump_0A0_452B::
    ld de, $D968
    call Func_0A0_429C
    ld de, $D978
    call Func_0A0_429C
    ld de, $D980
    call Func_0A0_429C
    ld de, $D970
    call Func_0A0_429C

Jump_0A0_4543::
    ld a, c
    add a, a
    add a, c
    add a, a
    add a, c
    ld de, $DA72
    add a, e
    ld e, a
    jr nc, Jump_0A0_4550
    inc d

Jump_0A0_4550::
    push bc
    ld a, l
    ld [$D868], a
    ld a, h
    ld [$D869], a
    ld a, e
    ld [$D86A], a
    ld a, d
    ld [$D86B], a
    ld hl, $44B9
    ld b, $19
    rst $10
    pop bc
    ld hl, $4298
    ld b, $19
    rst $10
    ret

Func_0A0_456F::
    push bc
    call Func_0A0_468A
    pop bc
    ld a, c
    add a, a
    ld de, $D958
    add a, e
    ld e, a
    jr nc, Jump_0A0_457E
    inc d

Jump_0A0_457E::
    ld a, l
    add a, $0A
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc hl
    ld a, c
    ld de, $D8AF
    add a, e
    ld e, a
    jr nc, Jump_0A0_4595
    inc d

Jump_0A0_4595::
    ld a, [hl+]
    ld [de], a
    ld a, c
    ld de, $DA43
    add a, e
    ld e, a
    jr nc, Jump_0A0_45A0
    inc d

Jump_0A0_45A0::
    ld a, $00
    ld [de], a
    push hl
    push bc
    ld a, [$D868]
    or a, a
    jr nz, Jump_0A0_45B3
    ld hl, $434D
    ld b, $19
    rst $10
    jr Jump_0A0_45B9

Jump_0A0_45B3::
    ld hl, $4349
    ld b, $19
    rst $10

Jump_0A0_45B9::
    pop bc
    pop hl
    ld a, l
    add a, $08
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [$D871]
    or a, a
    call z, Func_0A0_4268
    inc hl
    ld de, $D8B7
    call Func_0A0_429C
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld a, [$D871]
    or a, a
    jr z, Jump_0A0_45ED
    inc hl
    inc hl
    ld de, $D8CF
    call Func_0A0_42A5
    inc hl
    inc hl
    ld de, $D8EF
    call Func_0A0_42A5
    jr Jump_0A0_4605

Jump_0A0_45ED::
    ld de, $D8BF
    call Func_0A0_42A5
    ld de, $D8CF
    call Func_0A0_42A5
    ld de, $D8DF
    call Func_0A0_42A5
    ld de, $D8EF
    call Func_0A0_42A5

Jump_0A0_4605::
    ld de, $D8FF
    call Func_0A0_42A5
    ld de, $D90F
    call Func_0A0_42A5
    ld de, $D91F
    call Func_0A0_42A5
    ld de, $D92F
    call Func_0A0_42A5
    ld de, $D93F
    call Func_0A0_42A5
    ld a, [$D871]
    or a, a
    jr z, Jump_0A0_4646
    ld a, [$D868]
    push hl
    ld l, a
    add a, a
    add a, a
    add a, a
    add a, l
    ld hl, $D80D
    add a, l
    ld l, a
    jr nc, Jump_0A0_463A
    inc h

Jump_0A0_463A::
    ld a, [hl]
    and a, $30
    pop hl
    jr nz, Jump_0A0_4646
    inc hl
    inc hl
    inc hl
    inc hl
    jr Jump_0A0_465E

Jump_0A0_4646::
    ld de, $D968
    call Func_0A0_429C
    ld de, $D978
    call Func_0A0_429C
    ld de, $D980
    call Func_0A0_429C
    ld de, $D970
    call Func_0A0_429C

Jump_0A0_465E::
    ld a, c
    add a, a
    add a, c
    add a, a
    add a, c
    ld de, $DA72
    add a, e
    ld e, a
    jr nc, Jump_0A0_466B
    inc d

Jump_0A0_466B::
    push bc
    ld a, l
    ld [$D868], a
    ld a, h
    ld [$D869], a
    ld a, e
    ld [$D86A], a
    ld a, d
    ld [$D86B], a
    ld hl, $44B9
    ld b, $19
    rst $10
    pop bc
    ld hl, $4298
    ld b, $19
    rst $10
    ret

Func_0A0_468A::
    cp a, $03
    jr c, Jump_0A0_4693
    ret z
    cp a, $07
    ret z
    dec a

Jump_0A0_4693::
    ld c, $4E
    call Func_000_1682
    ld a, l
    add a, $D5
    ld l, a
    ld a, h
    adc a, $D0
    ld h, a
    ret

Func_0A0_46A1::
    ld bc, $0200
    ld hl, $DA5B

Jump_0A0_46A7::
    ld a, c
    call Func_000_3E54
    jr z, Jump_0A0_46BB
    ld a, c
    call Func_000_3E25
    jr c, Jump_0A0_46B7
    ld [hl], $00
    jr Jump_0A0_46BD

Jump_0A0_46B7::
    ld [hl], $01
    jr Jump_0A0_46BD

Jump_0A0_46BB::
    ld [hl], $FF

Jump_0A0_46BD::
    inc c
    inc hl
    dec b
    jr nz, Jump_0A0_46A7
    ret

Func_0A0_46C3::
    push bc
    call Func_0A0_46CC
    pop bc
    call Func_0A0_4919
    ret

Func_0A0_46CC::
    push bc
    ld de, $0000
    ld hl, $D0FC
    call Func_0A0_486D
    ld hl, $D0FE
    call Func_0A0_486D
    srl d
    rr e
    ld hl, $D0F2
    call Func_0A0_486D
    ld hl, $D0F6
    call Func_0A0_486D
    ld hl, $D0F8
    call Func_0A0_486D
    ld hl, $D0FA
    call Func_0A0_486D
    ld h, d
    ld l, e
    ld a, $32
    call Func_000_16D1
    push hl
    ld a, [$D0EC]
    ld c, $18
    call Func_000_1682
    push hl
    ld de, $0000
    ld hl, $D0F2
    call Func_0A0_486D
    ld hl, $D0F6
    call Func_0A0_486D
    ld hl, $D0F8
    call Func_0A0_486D
    ld hl, $D0FA
    call Func_0A0_486D
    ld hl, $D0FC
    call Func_0A0_486D
    ld hl, $D0FE
    call Func_0A0_486D
    pop hl
    ld a, e
    sub a, l
    ld l, a
    ld a, d
    sbc a, h
    ld h, a
    jr nc, Jump_0A0_474D
    cpl
    ld h, a
    ld a, l
    cpl
    ld l, a
    inc hl
    ld a, $32
    call Func_000_16D1
    ld a, l
    cpl
    ld l, a
    ld a, h
    cpl
    ld h, a
    inc hl
    jr Jump_0A0_4752

Jump_0A0_474D::
    ld a, $32
    call Func_000_16D1

Jump_0A0_4752::
    pop de
    add hl, de
    bit 7, h
    jr z, Jump_0A0_475B
    ld hl, $0000

Jump_0A0_475B::
    ld a, h
    or a, a
    jr nz, Jump_0A0_4764
    ld a, l
    cp a, $64
    jr c, Jump_0A0_4767

Jump_0A0_4764::
    ld hl, $0063

Jump_0A0_4767::
    push hl
    ld de, $0000
    ld hl, $D14A
    call Func_0A0_486D
    ld hl, $D14C
    call Func_0A0_486D
    srl d
    rr e
    ld hl, $D140
    call Func_0A0_486D
    ld hl, $D144
    call Func_0A0_486D
    ld hl, $D146
    call Func_0A0_486D
    ld hl, $D148
    call Func_0A0_486D
    ld h, d
    ld l, e
    ld a, $32
    call Func_000_16D1
    push hl
    ld a, [$D13A]
    ld c, $18
    call Func_000_1682
    push hl
    ld de, $0000
    ld hl, $D140
    call Func_0A0_486D
    ld hl, $D144
    call Func_0A0_486D
    ld hl, $D146
    call Func_0A0_486D
    ld hl, $D148
    call Func_0A0_486D
    ld hl, $D14A
    call Func_0A0_486D
    ld hl, $D14C
    call Func_0A0_486D
    pop hl
    ld a, e
    sub a, l
    ld l, a
    ld a, d
    sbc a, h
    ld h, a
    jr nc, Jump_0A0_47E8
    cpl
    ld h, a
    ld a, l
    cpl
    ld l, a
    inc hl
    ld a, $32
    call Func_000_16D1
    ld a, h
    cpl
    ld h, a
    ld a, l
    cpl
    ld l, a
    inc hl
    jr Jump_0A0_47ED

Jump_0A0_47E8::
    ld a, $32
    call Func_000_16D1

Jump_0A0_47ED::
    pop de
    add hl, de
    bit 7, h
    jr z, Jump_0A0_47F6
    ld hl, $0000

Jump_0A0_47F6::
    ld a, h
    or a, a
    jr nz, Jump_0A0_47FF
    ld a, l
    cp a, $64
    jr c, Jump_0A0_4802

Jump_0A0_47FF::
    ld hl, $0063

Jump_0A0_4802::
    pop bc
    ld a, l
    or a, c
    jr z, Jump_0A0_4816
    ld a, l
    or a, a
    jr z, Jump_0A0_481A
    ld a, c
    or a, a
    jr z, Jump_0A0_481D
    ld a, l
    cp a, c
    jr nc, Jump_0A0_4820
    ld a, c
    jr Jump_0A0_4820

Jump_0A0_4816::
    ld a, $01
    jr Jump_0A0_4820

Jump_0A0_481A::
    ld a, c
    jr Jump_0A0_4820

Jump_0A0_481D::
    ld a, l
    jr Jump_0A0_4820

Jump_0A0_4820::
    ld [$CFE3], a
    pop bc
    or a, a
    jr z, Jump_0A0_4847
    cp a, $14
    jr c, Jump_0A0_4847
    cp a, $28
    jr c, Jump_0A0_484A
    cp a, $32
    jr c, Jump_0A0_484E
    cp a, $3C
    jr c, Jump_0A0_4852
    cp a, $46
    jr c, Jump_0A0_4856
    cp a, $50
    jr c, Jump_0A0_485A
    cp a, $5A
    jr c, Jump_0A0_485E
    ld a, $07
    jr Jump_0A0_4860

Jump_0A0_4847::
    xor a, a
    jr Jump_0A0_4860

Jump_0A0_484A::
    ld a, $01
    jr Jump_0A0_4860

Jump_0A0_484E::
    ld a, $02
    jr Jump_0A0_4860

Jump_0A0_4852::
    ld a, $03
    jr Jump_0A0_4860

Jump_0A0_4856::
    ld a, $04
    jr Jump_0A0_4860

Jump_0A0_485A::
    ld a, $05
    jr Jump_0A0_4860

Jump_0A0_485E::
    ld a, $06

Jump_0A0_4860::
    ld [$CFE4], a

Jump_0A0_4863::
    push bc
    call Func_0A0_4874
    pop bc
    inc c
    dec b
    jr nz, Jump_0A0_4863
    ret

Func_0A0_486D::
    ld a, [hl+]
    add a, e
    ld e, a
    ld a, [hl]
    adc a, d
    ld d, a
    ret

Func_0A0_4874::
    push bc
    call Func_0A0_48D0
    add a, a
    add a, a
    add a, a
    add a, a
    ld hl, $6D57
    add a, l
    ld l, a
    jr nc, Jump_0A0_4884
    inc h

Jump_0A0_4884::
    ld a, [$CFE4]
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A0_488D
    inc h

Jump_0A0_488D::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, [hl+]
    push hl
    or a, a
    jr z, Jump_0A0_48CC
    ld b, a
    push bc
    ld b, $FF
    call Func_000_16BF
    ld d, b
    call Func_000_3ED4
    pop bc
    ld c, $00
    ld hl, $C5E7
    ld a, d

Jump_0A0_48A7::
    cp a, [hl]
    jr nc, Jump_0A0_48B3
    add a, d
    jr c, Jump_0A0_48CC
    inc c
    dec b
    jr nz, Jump_0A0_48A7
    jr Jump_0A0_48CC

Jump_0A0_48B3::
    pop hl
    ld a, c
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A0_48BB
    inc h

Jump_0A0_48BB::
    pop bc
    ld de, $CFDD
    ld a, c
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_0A0_48C6
    inc d

Jump_0A0_48C6::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    ret

Jump_0A0_48CC::
    pop hl
    pop bc
    jr Func_0A0_4874

Func_0A0_48D0::
    call Func_000_3ED4
    ld a, [$C5E7]
    ld bc, $0B00
    ld hl, $48F5

Jump_0A0_48DC::
    cp a, [hl]
    jr c, Jump_0A0_48E5
    inc hl
    inc c
    dec b
    jr nz, Jump_0A0_48DC
    dec c

Jump_0A0_48E5::
    ld a, c
    cp a, $0A
    jr nz, Jump_0A0_48F3
    ld a, [$CFE4]
    cp a, $06
    jr nc, Jump_0A0_48F3
    jr Func_0A0_48D0

Jump_0A0_48F3::
    ld a, c
    ret
    db $19, $32, $4B, $64, $7D, $96, $AF, $C8, $E1, $FA, $FF

Func_0A0_4900::
    ld hl, $D0D5
    ld de, $D1BF
    ld bc, $004E
    call Func_000_0952
    ld hl, $D123
    ld de, $D20D
    ld bc, $004E
    call Func_000_0952
    ret

Func_0A0_4919::
    push de
    ld a, [$CFE3]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, $05
    call Func_000_16D1
    ld a, $05
    add a, l
    pop de
    cp a, $64
    jr c, Jump_0A0_4931
    ld a, $63

Jump_0A0_4931::
    ldh [$FFC7], a

Jump_0A0_4933::
    push bc
    ld a, c
    ld hl, $4B0A
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A0_493E
    inc h

Jump_0A0_493E::
    ld a, [hl+]
    ld [$D86A], a
    ld a, [hl]
    ld [$D86B], a
    call Func_0A0_494F
    pop bc
    inc c
    dec b
    jr nz, Jump_0A0_4933
    ret

Func_0A0_494F::
    push bc
    ld a, c
    ld [$D869], a
    add a, a
    ld hl, $CFDD
    add a, l
    ld l, a
    jr nc, Jump_0A0_495D
    inc h

Jump_0A0_495D::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, l
    ld [$D006], a
    ld a, h
    ld [$D007], a
    ld hl, $4001
    ld b, $35
    rst $10
    ld a, [$D86A]
    add a, $0A
    ld l, a
    ld a, [$D86B]
    adc a, $00
    ld h, a
    ld a, [$D006]
    ld [hl+], a
    ld a, [$D007]
    ld [hl+], a
    ld a, [$D008]
    ld [hl+], a
    ld a, [$D009]
    ld [hl+], a
    ld a, [$D010]
    ld [hl+], a
    ld a, [$D011]
    ld [hl+], a
    ld a, [$D012]
    ld [hl+], a
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ldh a, [$FFC7]
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    push hl
    ld a, [$D014]
    ldh [$FFC6], a
    ld hl, $63A7
    ld b, $1A
    rst $10
    pop hl
    ld a, $01
    ld [$D868], a
    call Func_0A0_4A55
    call Func_0A0_4A97
    ld a, [$D015]
    ldh [$FFC6], a
    push hl
    ld hl, $63A7
    ld b, $1A
    rst $10
    pop hl
    ld a, $00
    ld [$D868], a
    call Func_0A0_4A55
    call Func_0A0_4A97
    ld a, [$D016]
    ldh [$FFC6], a
    push hl
    ld hl, $63A7
    ld b, $1A
    rst $10
    pop hl
    call Func_0A0_4A55
    ld a, [$D017]
    ldh [$FFC6], a
    push hl
    ld hl, $63A7
    ld b, $1A
    rst $10
    pop hl
    call Func_0A0_4A55
    ld a, [$D018]
    ldh [$FFC6], a
    push hl
    ld hl, $63A7
    ld b, $1A
    rst $10
    pop hl
    call Func_0A0_4A55
    ld a, [$D019]
    ldh [$FFC6], a
    push hl
    ld hl, $63A7
    ld b, $1A
    rst $10
    pop hl
    call Func_0A0_4A55
    ld a, $E7
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    call Func_0A0_4A45
    call Func_0A0_4A45
    call Func_0A0_4A45
    call Func_0A0_4A45
    call Func_0A0_4A9E
    ld a, $00
    ld [hl+], a
    ld a, $07
    ld [hl+], a
    call Func_0A0_4AAA
    ld hl, $5FA7
    ld b, $1A
    rst $10
    ld a, [$D86A]
    ld e, a
    ld a, [$D86B]
    ld d, a
    pop bc
    ret

Func_0A0_4A45::
    push af
    push bc
    push de
    push hl
    call Func_000_095B
    pop hl
    pop de
    pop bc
    pop af
    ld a, [$C5E7]
    ld [hl+], a
    ret

Func_0A0_4A55::
    push af
    push bc
    push de
    push hl
    ldh a, [$FFC8]
    ld c, a
    ldh a, [$FFC9]
    ld b, a
    ld a, [$CFE3]
    rrca
    rrca
    and a, $3F
    add a, $64
    call Func_000_16AA
    ld a, $64
    call Func_000_16E2
    ld a, e
    or a, a
    jr nz, Jump_0A0_4A83
    ld bc, $03E7
    ld a, c
    sub a, l
    ld c, a
    ld a, b
    sbc a, h
    ld b, a
    bit 7, b
    jr nz, Jump_0A0_4A83
    jr Jump_0A0_4A86

Jump_0A0_4A83::
    ld hl, $03E7

Jump_0A0_4A86::
    ld a, l
    ldh [$FFC8], a
    ld a, h
    ldh [$FFC9], a
    pop hl
    pop de
    pop bc
    pop af
    ldh a, [$FFC8]
    ld [hl+], a
    ldh a, [$FFC9]
    ld [hl+], a
    ret

Func_0A0_4A97::
    ldh a, [$FFC8]
    ld [hl+], a
    ldh a, [$FFC9]
    ld [hl+], a
    ret

Func_0A0_4A9E::
    ld de, $D01A
    ld b, $1B

Jump_0A0_4AA3::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_0A0_4AA3
    ret

Func_0A0_4AAA::
    ld a, [$D86A]
    add a, $0D
    ld l, a
    ld a, [$D86B]
    adc a, $00
    ld h, a
    ld a, [hl]
    or a, a
    jr z, Jump_0A0_4AE2
    cp a, $01
    jr z, Jump_0A0_4AC6
    cp a, $02
    jr z, Jump_0A0_4ACA
    ld b, $E6
    jr Jump_0A0_4ACC

Jump_0A0_4AC6::
    ld b, $02
    jr Jump_0A0_4ACC

Jump_0A0_4ACA::
    ld b, $80

Jump_0A0_4ACC::
    push af
    push bc
    push de
    push hl
    call Func_000_095B
    pop hl
    pop de
    pop bc
    pop af
    ld a, [$C5E7]
    cp a, b
    jr c, Jump_0A0_4AE0
    xor a, a
    jr Jump_0A0_4AE2

Jump_0A0_4AE0::
    ld a, $01

Jump_0A0_4AE2::
    ld [hl], a
    ret
    db $F5, $E5, $4B, $CD, $82, $16, $C1, $F1, $E5, $F5, $C5, $48, $CD, $82, $16, $C1
    db $F1, $E5, $CD, $82, $16, $C1, $79, $84, $67, $78, $CE, $00, $5F, $C1, $79, $83
    db $5F, $78, $CE, $00, $57, $C9, $BF, $D1, $0D, $D2, $5B, $D2

Func_0A0_4B10::
    ld a, $90
    ld [$C8CF], a
    ld [$C8D0], a
    ld [$C8D1], a
    ld [$C8D2], a
    ld [$C8D3], a
    ld a, $F0
    ld [$C8D4], a
    ld de, $8D00
    call Func_000_21A1
    ld de, $8D50
    call Func_000_21A1
    ld de, $8DA0
    call Func_000_21A1
    ld hl, $D0D5
    ld de, $C8CF
    ld bc, $000A
    call Func_000_0952
    ld de, $8D00
    call Func_000_21A1
    ld hl, $D123
    ld de, $C8CF
    ld bc, $000A
    call Func_000_0952
    ld de, $8D50
    call Func_000_21A1
    ld a, [$C57F]
    bit 1, a
    jr nz, Jump_0A0_4B7A
    ld hl, $C60C
    ld de, $C8CF
    ld bc, $000A
    call Func_000_0952
    ld de, $8DA0
    call Func_000_21A1
    ld hl, $D05A
    jr Jump_0A0_4B8F

Jump_0A0_4B7A::
    ld hl, $D05A
    ld de, $C8CF
    ld bc, $000A
    call Func_000_0952
    ld de, $8DA0
    call Func_000_21A1
    ld hl, $C60C

Jump_0A0_4B8F::
    ld de, $C8CF
    ld bc, $0400

Jump_0A0_4B95::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_0A0_4BB1
    cp a, $8D
    jr z, Jump_0A0_4BA9
    cp a, $8E
    jr z, Jump_0A0_4BA9
    ld a, c
    cp a, $02
    jr z, Jump_0A0_4BCF
    inc c
    ld a, [hl]

Jump_0A0_4BA9::
    ld [de], a
    inc hl
    inc de
    dec b
    jr nz, Jump_0A0_4B95
    jr Jump_0A0_4BCF

Jump_0A0_4BB1::
    ld [de], a
    ld de, $8A40
    call Func_000_21A1
    ld a, $90
    ld [$C8CF], a
    ld [$C8D0], a
    ld [$C8D1], a
    ld a, $F0
    ld [$C8D2], a
    ld de, $8CB0
    call Func_000_21A1
    ret

Jump_0A0_4BCF::
    ld a, $F0
    ld [de], a
    push hl
    push bc
    ld de, $8A40
    call Func_000_21A1
    ld a, $90
    ld [$C8CF], a
    ld [$C8D0], a
    ld [$C8D1], a
    ld a, $F0
    ld [$C8D2], a
    ld de, $8CB0
    call Func_000_21A1
    pop bc
    ld a, b
    add a, $06
    ld b, a
    pop hl
    ld de, $C8CF

Jump_0A0_4BF9::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_0A0_4C13
    cp a, $8D
    jr z, Jump_0A0_4C0D
    cp a, $8E
    jr z, Jump_0A0_4C0D
    ld a, c
    cp a, $05
    jr z, Jump_0A0_4C13
    inc c
    ld a, [hl]

Jump_0A0_4C0D::
    ld [de], a
    inc hl
    inc de
    dec b
    jr nz, Jump_0A0_4BF9

Jump_0A0_4C13::
    ld a, $F0
    ld [de], a
    ld de, $8CB0
    call Func_000_21A1
    ret

Func_0A0_4C1D:: ; heuristic: follows a terminator; C0
    ld hl, $C278
    ld bc, $0160

Jump_0A0_4C23::
    ld a, $C3
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_0A0_4C23
    ret

Func_0A0_4C2C::
    ld hl, $4D37
    call Func_0A0_4D16
    call Func_0A0_4D25
    ret

Func_0A0_4C36::
    ld hl, $4DC7
    call Func_0A0_4D16
    call Func_0A0_4D25
    ld a, [$C57F]
    bit 1, a
    ret nz
    ld hl, $C1C3
    ld b, $05
    ld a, $DA

Jump_0A0_4C4C::
    ld [hl+], a
    inc a
    dec b
    jr nz, Jump_0A0_4C4C
    ret

Func_0A0_4C52::
    ld c, $00
    call Func_0A0_4C59
    ld c, $01

Func_0A0_4C59::
    call Func_0A0_6B46
    call Func_0A0_6B79
    call Func_0A0_6A45
    ret

Func_0A0_4C63:: ; heuristic: follows a terminator; C0
    ld c, $00
    call Func_0A0_4C6A
    ld c, $01

Func_0A0_4C6A::
    call Func_0A0_6BF0
    call Func_0A0_6C22
    call Func_0A0_6B1E
    ret

Func_0A0_4C74::
    ld de, $C338
    ld hl, $99A0
    ld bc, $1405
    call Func_0A0_4CFA
    ret

Func_0A0_4C81::
    ld de, $C338
    ld hl, $99A0
    ld bc, $0E05
    call Func_0A0_4CFA
    ret

Func_0A0_4C8E::
    ld de, $C278
    ld hl, $98E0
    ld bc, $140B
    call Func_0A0_4CFA
    ret

Func_0A0_4C9B::
    ld de, $C2B8
    ld hl, $9920
    ld bc, $0B09
    call Func_0A0_4CFA
    ret

Func_0A0_4CA8:: ; heuristic: follows a terminator; C0
    ld de, $C2B8
    ld hl, $9920
    ld bc, $1409
    call Func_0A0_4CFA
    ld a, $01
    ld [$D868], a
    ret

Func_0A0_4CBA:: ; heuristic: follows a terminator; C0
    ld de, $C2B8
    ld hl, $9920
    ld bc, $0809
    call Func_0A0_4CFA
    ret

Func_0A0_4CC7:: ; heuristic: follows a terminator; C0
    ld de, $C2F8
    ld hl, $9960
    ld bc, $0707
    call Func_0A0_4CFA
    ret

Func_0A0_4CD4::
    ld de, $C2A4
    ld hl, $990C
    ld bc, $0701
    call Func_0A0_4CFA
    ld de, $C2B8
    ld hl, $9920
    ld bc, $1409
    call Func_0A0_4CFA
    ret

Func_0A0_4CED:: ; heuristic: follows a terminator; C0
    ld de, $C2F8
    ld hl, $9960
    ld bc, $0D07
    call Func_0A0_4CFA
    ret

Func_0A0_4CFA::
    push bc
    push hl

Jump_0A0_4CFC::
    ld a, [de]
    inc de
    call Func_000_121F
    dec b
    jr nz, Jump_0A0_4CFC
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    ld a, $20
    sub a, b
    add a, e
    ld e, a
    jr nc, Jump_0A0_4D12
    inc d

Jump_0A0_4D12::
    dec c
    jr nz, Func_0A0_4CFA
    ret

Func_0A0_4D16::
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld c, [hl]
    inc hl
    push hl
    ld hl, $C198
    add hl, de
    pop de
    ret

Func_0A0_4D25::
    push bc
    push hl

Jump_0A0_4D27::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_0A0_4D27
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, Func_0A0_4D25
    ret
    INCBIN "dwm2-cobi-us.gbc", $280D37, $198

Func_0A0_4ECF::
    call Func_000_08A6
    ld a, $02
    call Func_000_122D
    ld a, [$C524]
    or a, a
    jr z, Jump_0A0_4EED
    ld a, $00
    ld [$C51F], a
    ld a, $00
    ld [$C520], a
    ld hl, $41CF
    ld b, $17
    rst $10

Jump_0A0_4EED::
    xor a, a
    ldh [$FFA1], a
    ldh [$FFA2], a
    xor a, a
    ldh [$FFA5], a
    ldh [$FFA6], a
    ld hl, $9800
    ld bc, $0400
    ld a, $C3
    call Func_000_0949
    ld a, [$C525]
    or a, a
    jr z, Jump_0A0_4F19
    ld a, $01
    ldh [$FF4F], a
    ld hl, $9800
    ld bc, $0400
    xor a, a
    call Func_000_0949
    xor a, a
    ldh [$FF4F], a

Jump_0A0_4F19::
    ld hl, $99C1
    ld a, l
    ld [$C554], a
    ld a, h
    ld [$C555], a
    ld b, $31
    ld de, $7C1E
    ld hl, $8A40
    call Func_000_0C5A
    ld b, $31
    ld de, $7DFB
    ld hl, $8DF0
    call Func_000_0C5A
    call Func_0A0_4001
    ld hl, $8800
    ld de, $1202
    call Func_000_2E98
    ld hl, $99C1
    ld a, l
    ld [$C554], a
    ld a, h
    ld [$C555], a
    ld a, $FC
    call Func_000_0DF2
    ld a, $07
    ldh [$FF9F], a
    ld a, $FF
    ldh [$FFA0], a
    ld a, $00
    ldh [$FFA5], a
    ld a, $00
    ldh [$FFA1], a
    ld a, $03
    ld [$C5EC], a
    ld a, $0B
    jp Jump_000_077A

Func_0A0_4F70::
    call Func_000_0535
    ld a, [$D802]
    cp a, $FF
    ret z
    ld hl, $4ADB
    ld b, $3A
    rst $10
    ld a, [$D800]
    cp a, $02
    ret nz
    di
    ld hl, $4001
    ld b, $32
    rst $10
    ei
    ret

Func_0A0_4F8E::
    ld a, [$C52B]
    and a, a
    ret nz
    ld a, [$CFC8]
    rst $00
    dw Jump_0A0_4F9F
    dw Jump_0A0_5291
    dw Jump_0A0_52C0
    dw Jump_0A0_54DD

Jump_0A0_4F9F::
    ld a, [$CFC9]
    rst $00
    dw Jump_0A0_4FC9
    dw Jump_0A0_4FD8
    dw Jump_0A0_4FE7
    dw Jump_0A0_501D
    dw Jump_0A0_5030
    dw Jump_0A0_503A
    dw Jump_0A0_5076
    dw Jump_0A0_50AD
    dw Jump_0A0_50C8
    dw Jump_0A0_50F2
    dw Jump_0A0_511F
    dw Jump_0A0_5158
    dw Jump_0A0_5182
    dw Jump_0A0_519C
    dw Jump_0A0_51DD
    dw Jump_0A0_5207
    dw Jump_0A0_5221
    dw Jump_0A0_5246
    dw Jump_0A0_5265

Jump_0A0_4FC9::
    ld a, [$C56C]
    and a, a
    ret nz
    ld hl, $CFC9
    inc [hl]
    ld a, $0C
    ld [$C594], a
    ret

Jump_0A0_4FD8::
    ld a, [$C58F]
    cp a, $0C
    ret nz
    xor a, a
    ld [$C594], a
    ld hl, $CFC9
    inc [hl]
    ret

Jump_0A0_4FE7::
    ld hl, $CFC9
    inc [hl]
    ld a, [$C5E7]
    ld [$C597], a
    ld a, [$C5E8]
    ld [$C598], a
    ld hl, $C597
    ld a, l
    ld [$C595], a
    ld a, h
    ld [$C596], a
    ld hl, $C5B7
    ld a, l
    ld [$C590], a
    ld a, h
    ld [$C591], a
    ld a, $02
    ld [$C592], a
    ld a, $FF
    ld [$C594], a
    ld a, $01
    ld [$C58C], a
    ret

Jump_0A0_501D::
    ld a, [$C58F]
    cp a, $F0
    ret nz
    xor a, a
    ld [$C594], a
    xor a, a
    ld [$C58C], a
    ld hl, $CFC9
    inc [hl]
    ret

Jump_0A0_5030::
    ld hl, $CFC9
    inc [hl]
    ld a, $03
    ld [$C594], a
    ret

Jump_0A0_503A::
    ld a, [$C58F]
    cp a, $03
    ret nz
    xor a, a
    ld [$C594], a
    ld a, [$C57F]
    bit 1, a
    jr nz, Jump_0A0_5055
    ld a, [$C5E7]
    ld l, a
    ld a, [$C5E8]
    ld h, a
    jr Jump_0A0_505D

Jump_0A0_5055::
    ld a, [$C5B7]
    ld l, a
    ld a, [$C5B8]
    ld h, a

Jump_0A0_505D::
    ld a, l
    ld [$C5B7], a
    ld [$C5BA], a
    ld [$C5E7], a
    ld a, h
    ld [$C5B8], a
    ld [$C5BB], a
    ld [$C5E8], a
    ld hl, $CFC9
    inc [hl]
    ret

Jump_0A0_5076::
    call Func_0A0_4047
    ld a, [$D78E]
    cp a, $02
    jr z, Jump_0A0_5093
    ld a, $02
    ld [$CFDC], a
    ld bc, $0300
    call Func_0A0_46C3
    call Func_0A0_4193
    ld hl, $CFC9
    inc [hl]
    ret

Jump_0A0_5093::
    ld a, $01
    ld [$CFDC], a
    ld a, $02
    ld [$D890], a
    ld a, $02
    ld [$C985], a
    call Func_0A0_4900
    call Func_0A0_418E
    ld hl, $CFC9
    inc [hl]
    ret

Jump_0A0_50AD::
    ld a, [$C56C]
    or a, a
    ret nz
    ld a, [$D78E]
    ld [$C529], a
    ld a, $06
    ld [$C528], a
    ld hl, $4001
    ld b, $07
    rst $10
    ld hl, $CFC9
    inc [hl]
    ret

Jump_0A0_50C8::
    ld a, [$C52B]
    or a, a
    ret nz
    ld a, [$D960]
    ld l, a
    ld a, [$D961]
    add a, $02
    ld h, a
    ld de, $C130
    call Func_000_2E81
    ld a, $03
    ld [$C529], a
    ld a, $06
    ld [$C528], a
    ld hl, $4001
    ld b, $07
    rst $10
    ld hl, $CFC9
    inc [hl]
    ret

Jump_0A0_50F2::
    ld a, [$C525]
    or a, a
    jr z, Jump_0A0_5105
    ld de, $0000
    ld hl, $98E1
    ld a, $01
    ldh [$FFC6], a
    call Func_000_2090

Jump_0A0_5105::
    ld a, [$D960]
    ld e, a
    ld a, [$D961]
    ld d, a
    ld hl, $9140
    ld c, $01
    call Func_000_1FE3
    ld a, $7F
    ld [$C526], a
    ld hl, $CFC9
    inc [hl]
    ret

Jump_0A0_511F::
    ld hl, $98E1
    ld a, [$D78E]
    cp a, $02
    jr nz, Jump_0A0_512C
    ld hl, $98E4

Jump_0A0_512C::
    ld d, $14
    call Func_0A0_5278
    ld a, [$C525]
    or a, a
    jr z, Jump_0A0_5153
    ld hl, $98E1
    ld a, [$D78E]
    cp a, $02
    jr nz, Jump_0A0_5144
    ld hl, $98E4

Jump_0A0_5144::
    ld a, $01
    ldh [$FFC6], a
    ld a, [$D960]
    ld e, a
    ld a, [$D961]
    ld d, a
    call Func_000_2090

Jump_0A0_5153::
    ld hl, $CFC9
    inc [hl]
    ret

Jump_0A0_5158::
    ld a, [$C52B]
    or a, a
    ret nz
    ld a, [$D962]
    ld l, a
    ld a, [$D963]
    add a, $02
    ld h, a
    ld de, $C130
    call Func_000_2E81
    ld a, $04
    ld [$C529], a
    ld a, $06
    ld [$C528], a
    ld hl, $4001
    ld b, $07
    rst $10
    ld hl, $CFC9
    inc [hl]
    ret

Jump_0A0_5182::
    ld a, [$D962]
    ld e, a
    ld a, [$D963]
    ld d, a
    ld hl, $9380
    ld c, $03
    call Func_000_1FE3
    ld a, $7F
    ld [$C526], a
    ld hl, $CFC9
    inc [hl]
    ret

Jump_0A0_519C::
    ld hl, $98E7
    ld a, [$D78E]
    cp a, $02
    jr nz, Jump_0A0_51B1
    ld a, [$CFC9]
    add a, $03
    ld [$CFC9], a
    ld hl, $98EA

Jump_0A0_51B1::
    ld d, $38
    call Func_0A0_5278
    ld a, [$C525]
    or a, a
    jr z, Jump_0A0_51D8
    ld hl, $98E7
    ld a, [$D78E]
    cp a, $02
    jr nz, Jump_0A0_51C9
    ld hl, $98EA

Jump_0A0_51C9::
    ld a, $03
    ldh [$FFC6], a
    ld a, [$D962]
    ld e, a
    ld a, [$D963]
    ld d, a
    call Func_000_2090

Jump_0A0_51D8::
    ld hl, $CFC9
    inc [hl]
    ret

Jump_0A0_51DD::
    ld a, [$C52B]
    or a, a
    ret nz
    ld a, [$D964]
    ld l, a
    ld a, [$D965]
    add a, $02
    ld h, a
    ld de, $C130
    call Func_000_2E81
    ld a, $05
    ld [$C529], a
    ld a, $06
    ld [$C528], a
    ld hl, $4001
    ld b, $07
    rst $10
    ld hl, $CFC9
    inc [hl]
    ret

Jump_0A0_5207::
    ld a, [$D964]
    ld e, a
    ld a, [$D965]
    ld d, a
    ld hl, $95C0
    ld c, $05
    call Func_000_1FE3
    ld a, $7F
    ld [$C526], a
    ld hl, $CFC9
    inc [hl]
    ret

Jump_0A0_5221::
    ld d, $5C
    ld hl, $98ED
    call Func_0A0_5278
    ld a, [$C525]
    or a, a
    jr z, Jump_0A0_5241
    ld hl, $98ED
    ld a, $05
    ldh [$FFC6], a
    ld a, [$D964]
    ld e, a
    ld a, [$D965]
    ld d, a
    call Func_000_2090

Jump_0A0_5241::
    ld hl, $CFC9
    inc [hl]
    ret

Jump_0A0_5246::
    ld a, [$C52B]
    or a, a
    ret nz
    ld a, $05
    ld [$C528], a
    ld a, $0C
    ld [$C529], a
    ld hl, $400F
    ld b, $07
    rst $10
    ld a, $01
    ld [$C594], a
    ld hl, $CFC9
    inc [hl]
    ret

Jump_0A0_5265::
    ld a, [$C58F]
    cp a, $01
    ret nz
    xor a, a
    ld [$CFC9], a
    xor a, a
    ld [$C594], a
    ld hl, $CFC8
    inc [hl]
    ret

Func_0A0_5278::
    ld bc, $0606

Jump_0A0_527B::
    ld a, d
    inc d
    call Func_000_121F
    dec b
    jr nz, Jump_0A0_527B
    ld a, l
    add a, $1A
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld b, $06
    dec c
    jr nz, Jump_0A0_527B
    ret

Jump_0A0_5291::
    ld a, [$CFC9]
    rst $00
    dw Jump_0A0_529F
    dw Jump_0A0_52A7
    dw Jump_0A0_52AB
    dw Jump_0A0_52B2
    dw Jump_0A0_52B9

Jump_0A0_529F::
    call Func_0A0_5D7A
    ld hl, $CFC9
    inc [hl]
    ret

Jump_0A0_52A7::
    call Func_0A0_5E07
    ret

Jump_0A0_52AB::
    ld hl, $413F
    ld b, $A1
    rst $10
    ret

Jump_0A0_52B2::
    ld hl, $6157
    ld b, $3A
    rst $10
    ret

Jump_0A0_52B9::
    ld hl, $68C9
    ld b, $3A
    rst $10
    ret

Jump_0A0_52C0::
    ld a, [$CFC9]
    rst $00
    dw Jump_0A0_52D6
    dw Jump_0A0_52E0
    dw Jump_0A0_530B
    dw Jump_0A0_532F
    dw Jump_0A0_5391
    dw Jump_0A0_5422
    dw Jump_0A0_5444
    dw Jump_0A0_5474
    dw Jump_0A0_547E

Jump_0A0_52D6::
    ld a, $01
    ld [$C594], a
    ld hl, $CFC9
    inc [hl]
    ret

Jump_0A0_52E0::
    ld a, [$C58F]
    cp a, $01
    ret nz
    ld hl, $DA63
    ld a, l
    ld [$C595], a
    ld a, h
    ld [$C596], a
    ld hl, $C5B7
    ld a, l
    ld [$C590], a
    ld a, h
    ld [$C591], a
    ld a, $08
    ld [$C592], a
    ld a, $FF
    ld [$C594], a
    ld hl, $CFC9
    inc [hl]
    ret

Jump_0A0_530B::
    ld a, [$C58F]
    cp a, $F0
    ret nz
    ld a, [$C57F]
    bit 1, a
    jr nz, Jump_0A0_5320
    ld a, [$C5B8]
    ld [$DA64], a
    jr Jump_0A0_5326

Jump_0A0_5320::
    ld a, [$C5B7]
    ld [$DA63], a

Jump_0A0_5326::
    ld hl, $CFC9
    inc [hl]
    xor a, a
    ld [$C594], a
    ret

Jump_0A0_532F::
    ld a, [$D891]
    inc a
    ld b, a
    ld a, [$D04B]
    add a, b
    cp a, $64
    jr c, Jump_0A0_533E
    ld a, $63

Jump_0A0_533E::
    ld [$D04B], a
    ld hl, $DA63
    ld a, [hl]
    cp a, $01
    jr z, Jump_0A0_5356
    ld a, $00
    ld hl, $D80C
    call Func_000_3F25
    ld a, [hl]
    bit 6, a
    jr z, Jump_0A0_536B

Jump_0A0_5356::
    ld hl, $DA64
    ld a, [hl]
    cp a, $01
    jr z, Jump_0A0_5383
    ld a, $01
    ld hl, $D80C
    call Func_000_3F25
    ld a, [hl]
    bit 6, a
    jr nz, Jump_0A0_5383

Jump_0A0_536B::
    ld a, [$D78E]
    add a, $06
    ld [$C529], a
    ld a, $06
    ld [$C528], a
    ld hl, $4001
    ld b, $07
    rst $10
    ld hl, $CFC9
    inc [hl]
    ret

Jump_0A0_5383::
    ld a, $02
    call Func_000_122D
    ld hl, $CFC8
    inc [hl]
    xor a, a
    ld [$CFC9], a
    ret

Jump_0A0_5391::
    ld a, [$C52B]
    or a, a
    ret nz
    ld a, [$D78E]
    cp a, $02
    jp z, Jump_0A0_5415
    inc a
    ld [$D78E], a
    ld hl, $5E3B
    ld b, $32
    rst $10
    ld c, $00
    ld hl, $76AE
    ld b, $31
    rst $10
    ld hl, $77B9
    ld b, $31
    rst $10
    ld c, $00
    ld hl, $7806
    ld b, $31
    rst $10
    ld hl, $7914
    ld b, $31
    rst $10
    ld c, $00
    ld hl, $785F
    ld b, $31
    rst $10
    ld hl, $7965
    ld b, $31
    rst $10
    ld c, $01
    ld hl, $76AE
    ld b, $31
    rst $10
    ld hl, $77B9
    ld b, $31
    rst $10
    ld c, $01
    ld hl, $7806
    ld b, $31
    rst $10
    ld hl, $7914
    ld b, $31
    rst $10
    ld c, $01
    ld hl, $785F
    ld b, $31
    rst $10
    ld hl, $7965
    ld b, $31
    rst $10
    ld a, $05
    ld [$C528], a
    ld a, $0C
    ld [$C529], a
    ld hl, $4001
    ld b, $07
    rst $10
    xor a, a
    ld [$C594], a
    ld hl, $CFC9
    inc [hl]
    ret

Jump_0A0_5415::
    ld hl, $CFC8
    inc [hl]
    xor a, a
    ld [$CFC9], a
    xor a, a
    ld [$C594], a
    ret

Jump_0A0_5422::
    ld hl, $98E1
    ld bc, $1206
    ld de, $000E

Jump_0A0_542B::
    di

Jump_0A0_542C::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_0A0_542C
    ld [hl], $C3
    ei
    inc hl
    dec b
    jr nz, Jump_0A0_542B
    add hl, de
    ld b, $12
    dec c
    jr nz, Jump_0A0_542B
    ld hl, $CFC9
    inc [hl]
    ret

Jump_0A0_5444::
    ld a, [$C525]
    or a, a
    jr z, Jump_0A0_546F
    ld a, $01
    ldh [$FF4F], a
    ld hl, $98E1
    ld bc, $1206
    ld de, $000E

Jump_0A0_5457::
    di

Jump_0A0_5458::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_0A0_5458
    ld [hl], $00
    ei
    inc hl
    dec b
    jr nz, Jump_0A0_5457
    add hl, de
    ld b, $12
    dec c
    jr nz, Jump_0A0_5457
    ld a, $00
    ldh [$FF4F], a

Jump_0A0_546F::
    ld hl, $CFC9
    inc [hl]
    ret

Jump_0A0_5474::
    ld hl, $CFC9
    inc [hl]
    ld a, $01
    ld [$C594], a
    ret

Jump_0A0_547E::
    ld a, [$C58F]
    cp a, $01
    ret nz
    xor a, a
    ld [$C594], a
    xor a, a
    ld [$CFC8], a
    xor a, a
    ld [$CFC9], a
    ret

Func_0A0_5491::
    ld a, $0A
    ld [$0100], a
    ld a, [$C6FD]
    ld b, a
    ld hl, $C6FE
    ld de, $C972

Jump_0A0_54A0::
    inc de
    ld a, [de]
    cp a, $FF
    jr z, Jump_0A0_54D2
    dec de
    push hl
    ld a, [hl]
    ld c, $5B
    call Func_000_1FD1
    ld a, [de]
    inc de
    ld [hl+], a
    ld a, [de]
    inc de
    ld [hl], a
    pop hl
    push hl
    ld a, [hl]
    ld c, $5F
    call Func_000_1FD1
    ld a, [de]
    inc de
    ld [hl+], a
    ld a, [de]
    inc de
    ld [hl], a
    pop hl
    push hl
    ld a, [hl]
    ld c, $55
    call Func_000_1FD1
    ld a, [de]
    inc de
    ld [hl+], a
    pop hl
    inc hl
    dec b
    jr nz, Jump_0A0_54A0

Jump_0A0_54D2::
    ld hl, $65E6
    ld b, $F2
    rst $10
    xor a, a
    ld [$0100], a
    ret

Jump_0A0_54DD::
    ld a, [$CFC9]
    rst $00
    dw Jump_0A0_54F7
    dw Jump_0A0_558C
    dw Jump_0A0_55B6
    dw Jump_0A0_55D1
    dw Jump_0A0_5622
    dw Jump_0A0_56D2
    dw Jump_0A0_56F7
    dw Jump_0A0_5732
    dw Jump_0A0_5772
    dw Jump_0A0_57B1
    dw Jump_0A0_59D4

Jump_0A0_54F7::
    ld a, $01
    ld [$C964], a
    ld a, [$C899]
    ld l, a
    ld a, [$C89A]
    ld h, a
    ld a, l
    ld [$C89B], a
    ld a, h
    ld [$C89C], a
    ld hl, $DA63
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    sla a
    or a, c
    ld c, a
    ld hl, $D80C
    ld a, [hl]
    and a, $40
    sra a
    sra a
    or a, c
    ld c, a
    ld hl, $D815
    ld a, [hl]
    and a, $40
    sra a
    or a, c
    ld c, a
    and a, $03
    cp a, $03
    jr z, Jump_0A0_5568
    ld a, c
    and a, $30
    cp a, $30
    jr z, Jump_0A0_5568
    ld a, c
    and a, $21
    cp a, $21
    jr z, Jump_0A0_5568
    ld a, c
    and a, $12
    cp a, $12
    jr z, Jump_0A0_5568
    ld a, c
    and a, $03
    jr z, Jump_0A0_5560
    ld a, [$C57F]
    and a, $02
    rrca
    ld hl, $DA63
    add a, l
    ld l, a
    jr nc, Jump_0A0_555A
    inc h

Jump_0A0_555A::
    ld a, [hl]
    or a, a
    jr z, Jump_0A0_5564
    jr Jump_0A0_556C

Jump_0A0_5560::
    ld a, $00
    jr Jump_0A0_556E

Jump_0A0_5564::
    ld a, $01
    jr Jump_0A0_556E

Jump_0A0_5568::
    ld a, $02
    jr Jump_0A0_556E

Jump_0A0_556C::
    ld a, $03

Jump_0A0_556E::
    ld [$C899], a
    ld a, [$D064]
    ld [$C89A], a
    call Func_0A0_5A6C
    call Func_0A0_5B47
    xor a, a
    ld [$C8C3], a
    ld [$C8C4], a
    ld hl, $CFC9
    inc [hl]
    call Func_0A0_5491
    ret

Jump_0A0_558C::
    ld hl, $7718
    ld b, $02
    rst $10
    ld a, [$C8C3]
    bit 7, a
    ret z
    ld hl, $7688
    ld b, $02
    rst $10
    ld a, [$C899]
    add a, $0F
    ld [$C529], a
    ld a, $05
    ld [$C528], a
    ld hl, $4001
    ld b, $07
    rst $10
    ld hl, $CFC9
    inc [hl]
    ret

Jump_0A0_55B6::
    ld a, [$C52B]
    or a, a
    ret nz
    ld hl, $C198
    ld bc, $01A0
    ld a, $C3
    call Func_000_0949
    ld hl, $9800
    call Func_0A0_42B2
    ld hl, $CFC9
    inc [hl]
    ret

Jump_0A0_55D1::
    ld hl, $8F00
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $2C01
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld a, $01
    ld [$C528], a
    ld a, $03
    ld [$C529], a
    ld hl, $400F
    ld b, $07
    rst $10
    ld hl, $9200
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0801
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld a, $01
    ld [$C528], a
    ld a, $05
    ld [$C529], a
    ld hl, $400F
    ld b, $07
    rst $10
    ld hl, $CFC9
    inc [hl]
    ret

Jump_0A0_5622::
    call Func_0A0_4C36
    ld a, [$C899]
    ld hl, $56CA
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A0_5631
    inc h

Jump_0A0_5631::
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld hl, $C1F9

Jump_0A0_5637::
    ld [hl], d
    inc d
    inc hl
    dec e
    ld a, e
    cp a, $00
    jr z, Jump_0A0_5647
    cp a, $02
    jr nc, Jump_0A0_5637
    inc hl
    jr Jump_0A0_5637

Jump_0A0_5647::
    ld a, [$CFE3]
    ld hl, $C23F
    call Func_0A0_5678
    ld a, [$D04B]
    ld hl, $C27F
    call Func_0A0_5678
    ld a, [$CFE4]
    ld hl, $C2BF
    call Func_0A0_5678
    ld a, [$CFE5]
    add a, $20
    ld [$C300], a
    ld de, $C895
    ld hl, $C209
    call Func_0A0_569E
    ld hl, $CFC9
    inc [hl]
    ret

Func_0A0_5678::
    push hl
    ld l, a
    ld h, $00
    call Func_000_16F5
    pop hl
    ld a, [$C8C1]
    add a, $E0
    cp a, $E0
    jr nz, Jump_0A0_568B
    ld a, $C3

Jump_0A0_568B::
    ld [hl+], a
    ld a, [$C8C2]
    add a, $E0
    ld [hl], a
    ret

Func_0A0_5693:: ; heuristic: follows a terminator; C0
    ld c, $00

Jump_0A0_5695::
    cp a, [hl]
    jr c, Jump_0A0_569C
    inc c
    inc hl
    jr Jump_0A0_5695

Jump_0A0_569C::
    ld a, c
    ret

Func_0A0_569E::
    call Func_0A0_56A7
    call Func_0A0_56A7
    call Func_0A0_56A7

Func_0A0_56A7::
    push hl
    ld a, [de]
    inc de
    ld l, a
    ld h, $00
    call Func_000_16F5
    pop hl
    ld a, [$C8C1]
    or a, a
    jr z, Jump_0A0_56BA
    add a, $E0
    ld [hl], a

Jump_0A0_56BA::
    inc hl
    ld a, [$C8C2]
    add a, $E0
    ld [hl], a
    ld a, l
    add a, $3F
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ret
    db $04, $F7, $04, $0E, $04, $12, $04, $16

Jump_0A0_56D2::
    ld hl, $9800
    call Func_0A0_42B2
    ld hl, $8800
    ld de, $1202
    call Func_000_2E98
    ld hl, $C987
    ld de, $C130
    ld bc, $000A
    call Func_000_0952
    ld a, $F0
    ld [$C13A], a
    ld hl, $CFC9
    inc [hl]
    ret

Jump_0A0_56F7::
    ld a, [$D0A6]
    cp a, $FF
    jr nz, Jump_0A0_5704
    ld hl, $CFC9
    inc [hl]
    jr Jump_0A0_5737

Jump_0A0_5704::
    call Func_0A0_5A30
    ld a, [$D0A7]
    ld hl, $C150
    call Func_000_2EAC
    ld a, [$C899]
    cp a, $02
    ld a, $14
    jr c, Jump_0A0_571B
    ld a, $15

Jump_0A0_571B::
    ld [$C529], a
    ld a, $05
    ld [$C528], a
    ld hl, $4001
    ld b, $07
    rst $10
    ld hl, $CFC9
    inc [hl]
    ld hl, $CFC9
    inc [hl]
    ret

Jump_0A0_5732::
    ld a, [$C52B]
    or a, a
    ret nz

Jump_0A0_5737::
    ld a, [$CFCA]
    call Func_0A0_5A30
    ld a, [$CFCA]
    ld hl, $D0A7
    add a, l
    ld l, a
    jr nc, Jump_0A0_5748
    inc h

Jump_0A0_5748::
    ld a, [hl]
    ld hl, $C150
    call Func_000_2EAC
    ld a, $05
    ld [$C528], a
    ld a, $15
    ld [$C529], a
    ld hl, $4001
    ld b, $07
    rst $10
    ld a, [$CFCA]
    inc a
    ld [$CFCA], a
    cp a, $06
    ret c
    xor a, a
    ld [$CFCA], a
    ld hl, $CFC9
    inc [hl]
    ret

Jump_0A0_5772::
    ld a, [$C52B]
    or a, a
    ret nz
    ld a, [$D0AD]
    ldh [$FFC6], a
    ld a, [$D0AE]
    ldh [$FFC7], a
    xor a, a
    ldh [$FFC8], a
    ld hl, $C150
    call Func_000_2ECF
    ld a, $05
    ld [$C528], a
    ld a, $16
    ld [$C529], a
    ld hl, $4001
    ld b, $07
    rst $10
    xor a, a
    ld [$CFCA], a
    xor a, a
    ld [$C594], a
    ld hl, $CFC9
    inc [hl]
    ld a, [$C899]
    cp a, $01
    ret z
    ld hl, $CFC9
    inc [hl]
    ret

Jump_0A0_57B1::
    ld a, [$CFCA]
    rst $00
    dw Jump_0A0_57B9
    dw Jump_0A0_57C8

Jump_0A0_57B9::
    ld a, [$C52B]
    or a, a
    ret nz
    ld a, $01
    ld [$C594], a
    ld hl, $CFCA
    inc [hl]
    ret

Jump_0A0_57C8::
    ld a, [$C58F]
    cp a, $01
    ret nz
    ld a, $08
    ld [$D092], a
    ld a, $01
    ld [$D04C], a
    ld hl, $C986
    ld de, $CA2B
    ld bc, $00A5
    call Func_000_0952
    ld a, $01
    ld [$CA2B], a
    ld a, $FF
    ld [$CA45], a
    ld [$CA46], a
    ld [$CA47], a
    ld [$CA48], a
    ld hl, $CA49
    call Func_0A0_591A
    ld a, $FF
    ld [$CA53], a
    ld hl, $CA54
    call Func_0A0_591A
    ld a, $FF
    ld [$CA5E], a
    call Func_0A0_5939
    xor a, a
    ld [$CA80], a
    ld a, $01
    ld [$CA81], a
    xor a, a
    ld [$CA83], a
    ld [$CA84], a
    ld [$CA85], a
    ld a, [$CA88]
    ld l, a
    ld a, [$CA89]
    ld h, a
    call Func_0A0_590B
    ld a, l
    ld [$CA88], a
    ld a, h
    ld [$CA89], a
    ld a, l
    ld [$CA86], a
    ld a, h
    ld [$CA87], a
    ld a, [$CA8C]
    ld l, a
    ld a, [$CA8D]
    ld h, a
    call Func_0A0_590B
    ld a, l
    ld [$CA8C], a
    ld a, h
    ld [$CA8D], a
    ld a, l
    ld [$CA8A], a
    ld a, h
    ld [$CA8B], a
    ld a, [$CA8E]
    ld l, a
    ld a, [$CA8F]
    ld h, a
    call Func_0A0_590B
    ld a, l
    ld [$CA8E], a
    ld a, h
    ld [$CA8F], a
    ld a, [$CA90]
    ld l, a
    ld a, [$CA91]
    ld h, a
    call Func_0A0_590B
    ld a, l
    ld [$CA90], a
    ld a, h
    ld [$CA91], a
    ld a, [$CA92]
    ld l, a
    ld a, [$CA93]
    ld h, a
    call Func_0A0_590B
    ld a, l
    ld [$CA92], a
    ld a, h
    ld [$CA93], a
    ld a, [$CA94]
    ld l, a
    ld a, [$CA95]
    ld h, a
    call Func_0A0_590B
    ld a, l
    ld [$CA94], a
    ld a, h
    ld [$CA95], a
    xor a, a
    ld [$CA96], a
    ld [$CA97], a
    xor a, a
    ld [$CA98], a
    ld a, $01
    ld [$CA99], a
    ld hl, $CAB9
    call Func_0A0_591A
    xor a, a
    ld [$CAC3], a
    ld hl, $CAC4
    call Func_0A0_591A
    xor a, a
    ld [$CACE], a
    xor a, a
    ld [$CACF], a
    ld a, $04
    call Func_000_0DF2
    ld a, $06
    ld [$C5DB], a
    xor a, a
    ld [$C5DC], a
    ld [$C5DD], a
    ld [$C5DE], a
    ld [$D780], a
    ld hl, $C5DF
    inc [hl]
    ld hl, $D066
    inc [hl]
    xor a, a
    ld [$C581], a
    ld [$C582], a
    xor a, a
    ld [$C57F], a
    ld [$C580], a
    xor a, a
    ld [$C58A], a
    xor a, a
    ld [$C594], a
    xor a, a
    ld [$C58F], a
    xor a, a
    ld [$C58B], a
    ret

Func_0A0_590B::
    sra h
    rr l
    sra h
    rr l
    ld a, l
    or a, h
    ret nz
    ld hl, $0001
    ret

Func_0A0_591A::
    ld a, $98
    ld [hl+], a
    ld a, $98
    ld [hl+], a
    ld a, $98
    ld [hl+], a
    ld a, $F0
    ld [hl+], a
    ld a, $F0
    ld [hl+], a
    ld a, $F0
    ld [hl+], a
    ld a, $F0
    ld [hl+], a
    ld a, $F0
    ld [hl+], a
    ld a, $F0
    ld [hl+], a
    ld a, $F0
    ld [hl], a
    ret

Func_0A0_5939::
    ld de, $CA67
    ld b, $19

Jump_0A0_593E::
    ld a, [de]
    cp a, $FF
    jr z, Jump_0A0_5948
    inc de
    dec b
    jr nz, Jump_0A0_593E
    ret

Jump_0A0_5948::
    ld b, $08
    ld hl, $CA5F

Jump_0A0_594D::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_0A0_596E
    push hl
    ld c, a
    ld hl, $597A

Jump_0A0_5957::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_0A0_5966
    cp a, c
    jr z, Jump_0A0_5963
    inc hl
    inc hl
    jr Jump_0A0_5957

Jump_0A0_5963::
    inc hl
    ld a, [hl]
    ld c, a

Jump_0A0_5966::
    ld a, c
    ld [de], a
    pop hl
    inc hl
    inc de
    dec b
    jr nz, Jump_0A0_594D

Jump_0A0_596E::
    ld hl, $CA5F
    ld b, $08

Jump_0A0_5973::
    ld a, $FF
    ld [hl+], a
    dec b
    jr nz, Jump_0A0_5973
    ret
    INCBIN "dwm2-cobi-us.gbc", $28197A, $5A

Jump_0A0_59D4::
    ld a, [$CFCA]
    rst $00
    dw Jump_0A0_59DC
    dw Jump_0A0_59EB

Jump_0A0_59DC::
    ld a, [$C52B]
    or a, a
    ret nz
    ld a, $01
    ld [$C594], a
    ld hl, $CFCA
    inc [hl]
    ret

Jump_0A0_59EB::
    ld a, [$C58F]
    cp a, $01
    ret nz
    ld a, $04
    call Func_000_0DF2
    ld a, $05
    ld [$C5DB], a
    ld a, $01
    ld [$C5DC], a
    xor a, a
    ld [$C5DD], a
    ld [$C5DE], a
    ld [$D780], a
    ld hl, $C5DF
    inc [hl]
    xor a, a
    ld [$C581], a
    ld [$C582], a
    xor a, a
    ld [$C57F], a
    ld [$C580], a
    xor a, a
    ld [$C58A], a
    xor a, a
    ld [$C594], a
    xor a, a
    ld [$C58F], a
    xor a, a
    ld [$C58B], a
    ret
    db $0A, $14, $1E

Func_0A0_5A30::
    ld hl, $5A4A
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A0_5A39
    inc h

Jump_0A0_5A39::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, $C140

Jump_0A0_5A3F::
    ld a, [hl+]
    cp a, $F0
    jr z, Jump_0A0_5A48
    ld [de], a
    inc de
    jr Jump_0A0_5A3F

Jump_0A0_5A48::
    ld [de], a
    ret
    db $56, $5A, $59, $5A, $5C, $5A, $60, $5A, $64, $5A, $68, $5A, $11, $19, $F0, $16
    db $19, $F0, $0A, $1D, $14, $F0, $0D, $0E, $0F, $F0, $0A, $10, $15, $F0, $12, $17
    db $1D, $F0

Func_0A0_5A6C::
    ld a, [$C899]
    ld hl, $C895
    add a, l
    ld l, a
    jr nc, Jump_0A0_5A77
    inc h

Jump_0A0_5A77::
    ld a, [hl]
    inc a
    cp a, $64
    jr c, Jump_0A0_5A7F
    ld a, $63

Jump_0A0_5A7F::
    ld [hl], a
    ld a, [$D04B]
    ld hl, $5B25
    call Func_0A0_5B1A
    ld hl, $5B2C
    add a, l
    ld l, a
    jr nc, Jump_0A0_5A91
    inc h

Jump_0A0_5A91::
    push hl
    ld hl, $C895
    ld a, [hl+]
    add a, [hl]
    ld c, a
    ld b, $00
    push bc
    ld a, $0A
    call Func_000_1682
    pop bc
    ld a, [$C897]
    add a, c
    ld c, a
    ld a, $00
    adc a, b
    ld b, a
    ld a, [$C898]
    add a, c
    ld c, a
    ld a, $00
    adc a, b
    ld b, a
    call Func_000_3F04
    ld a, l
    ld [$D09D], a
    ld [$CFE4], a
    ld hl, $5B33
    call Func_0A0_5B1A
    ld hl, $5B39
    add a, l
    ld l, a
    jr nc, Jump_0A0_5ACB
    inc h

Jump_0A0_5ACB::
    ld a, [$CFE3]
    ld e, a
    ld d, $00
    ld a, [hl]
    ld c, a
    ld b, $00
    bit 7, a
    jr z, Jump_0A0_5ADB
    ld b, $FF

Jump_0A0_5ADB::
    ld a, e
    add a, c
    ld e, a
    ld a, d
    adc a, b
    ld d, a
    pop hl
    ld a, [hl]
    ld c, a
    ld b, $00
    bit 7, a
    jr z, Jump_0A0_5AEC
    ld b, $FF

Jump_0A0_5AEC::
    ld a, e
    add a, c
    ld e, a
    ld a, d
    adc a, b
    ld d, a
    bit 7, d
    jr z, Jump_0A0_5AFB
    ld de, $0000
    jr Jump_0A0_5B0C

Jump_0A0_5AFB::
    ld a, d
    or a, a
    jr z, Jump_0A0_5B04
    ld de, $0063
    jr Jump_0A0_5B0C

Jump_0A0_5B04::
    ld a, e
    cp a, $64
    jr c, Jump_0A0_5B0C
    ld de, $0063

Jump_0A0_5B0C::
    ld a, e
    ld hl, $5B3F
    call Func_0A0_5B1A
    ld [$D09E], a
    ld [$CFE5], a
    ret

Func_0A0_5B1A::
    ld c, $00

Jump_0A0_5B1C::
    cp a, [hl]
    jr c, Jump_0A0_5B23
    inc c
    inc hl
    jr Jump_0A0_5B1C

Jump_0A0_5B23::
    ld a, c
    ret
    db $06, $0B, $15, $29, $33, $3D, $FF, $14, $0A, $05, $00, $FB, $F6, $EC, $01, $03
    db $05, $07, $09, $FF, $EC, $F6, $FB, $00, $05, $0A, $14, $28, $32, $3C, $46, $50
    db $5A, $FF

Func_0A0_5B47::
    ld a, $FF
    ld [$D0A6], a
    ld [$D0A7], a
    ld [$D0A8], a
    ld [$D0A9], a
    ld [$D0AA], a
    ld [$D0AB], a
    ld [$D0AC], a
    ld [$D0AD], a
    ld [$D0AE], a
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld a, [$D065]
    ld c, $5D
    call Func_000_1FD1
    ld a, [$C899]
    or a, a
    jr z, Jump_0A0_5B85
    cp a, $01
    jr z, Jump_0A0_5B85
    cp a, $02
    jr z, Jump_0A0_5BAE
    jr Jump_0A0_5BCB

Jump_0A0_5B85::
    call Func_0A0_5CCD
    push hl
    ld a, [$D09E]
    ld hl, $5D5A
    add a, l
    ld l, a
    jr nc, Jump_0A0_5B94
    inc h

Jump_0A0_5B94::
    ld c, [hl]
    pop hl
    call Func_0A0_5C8F
    ld a, c
    ld [$D0A7], a
    ld a, [$D09E]
    add a, a
    ld hl, $5D6A
    add a, l
    ld l, a
    jr nc, Jump_0A0_5BA9
    inc h

Jump_0A0_5BA9::
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    jr Jump_0A0_5C08

Jump_0A0_5BAE::
    call Func_0A0_5D0C
    push hl
    ld a, [$D09E]
    ld hl, $5D62
    add a, l
    ld l, a
    jr nc, Jump_0A0_5BBD
    inc h

Jump_0A0_5BBD::
    ld c, [hl]
    pop hl
    call Func_0A0_5CB2
    ld a, b
    ld [$D0A7], a
    ld de, $03E8
    jr Jump_0A0_5C08

Jump_0A0_5BCB::
    push hl
    ld a, [$D09E]
    ld hl, $5D62
    add a, l
    ld l, a
    jr nc, Jump_0A0_5BD7
    inc h

Jump_0A0_5BD7::
    ld c, [hl]
    pop hl
    call Func_0A0_5CB2
    ld a, b
    ld [$D0A7], a
    inc hl
    inc hl
    call Func_0A0_5CB2
    ld a, b
    ld [$D0A8], a
    call Func_0A0_5CB2
    ld a, b
    ld [$D0A9], a
    call Func_0A0_5CB2
    ld a, b
    ld [$D0AA], a
    call Func_0A0_5CB2
    ld a, b
    ld [$D0AB], a
    call Func_0A0_5CB2
    ld a, b
    ld [$D0AC], a
    ld de, $03E8

Jump_0A0_5C08::
    ld a, e
    ld [$D0AD], a
    ld a, d
    ld [$D0AE], a
    ld a, [$C617]
    add a, e
    ld l, a
    ld a, [$C618]
    adc a, d
    ld h, a
    ld a, [$C619]
    adc a, $00
    ld e, a
    push hl
    ld a, l
    sub a, $9F
    ld l, a
    ld a, h
    sbc a, $86
    ld h, a
    ld a, e
    sbc a, $01
    jr c, Jump_0A0_5C4A
    or a, h
    or a, l
    jr z, Jump_0A0_5C4A
    ld a, l
    cpl
    ld l, a
    ld a, h
    cpl
    ld h, a
    inc hl
    ld a, l
    ld [$D0AD], a
    ld a, h
    ld [$D0AE], a
    pop hl
    ld e, $01
    ld h, $86
    ld l, $9F
    jr Jump_0A0_5C4B

Jump_0A0_5C4A::
    pop hl

Jump_0A0_5C4B::
    ld a, l
    ld [$C617], a
    ld a, h
    ld [$C618], a
    ld a, e
    ld [$C619], a
    ld a, [$D065]
    ld c, $5E
    call Func_000_1FD1
    ld a, [hl-]
    ld b, a
    ld a, [hl-]
    ld c, a
    push hl
    ld a, [hl-]
    ld l, [hl]
    ld a, h
    call Func_000_3E7A
    pop hl
    jr c, Jump_0A0_5C70
    ld a, b
    ld [hl-], a
    ld [hl], c

Jump_0A0_5C70::
    ld a, [$D065]
    ld c, $62
    call Func_000_1FD1
    ld a, [hl-]
    ld b, a
    ld a, [hl-]
    ld c, a
    push hl
    ld a, [hl-]
    ld a, [hl]
    ld l, a
    ld h, a
    call Func_000_3E7A
    pop hl
    jr c, Jump_0A0_5C8A
    ld a, b
    ld [hl-], a
    ld [hl], c

Jump_0A0_5C8A::
    xor a, a
    ld [$0100], a
    ret

Func_0A0_5C8F::
    ld a, [hl+]
    add a, c
    ld e, a
    ld a, [hl]
    adc a, $00
    ld d, a
    push de
    ld a, e
    sub a, $E7
    ld e, a
    ld a, d
    sbc a, $03
    jr c, Jump_0A0_5CAD
    or a, e
    jr z, Jump_0A0_5CAD
    ld a, c
    sub a, e
    ld c, a
    pop de
    ld d, $03
    ld e, $E7
    jr Jump_0A0_5CAE

Jump_0A0_5CAD::
    pop de

Jump_0A0_5CAE::
    ld [hl], d
    dec hl
    ld [hl], e
    ret

Func_0A0_5CB2::
    ld b, c
    ld a, [hl+]
    sub a, c
    ld e, a
    ld a, [hl-]
    sbc a, $00
    ld d, a
    jr c, Jump_0A0_5CC1
    or a, e
    jr nz, Jump_0A0_5CC8
    jr Jump_0A0_5CC5

Jump_0A0_5CC1::
    ld a, e
    cpl
    inc a
    ld b, a

Jump_0A0_5CC5::
    ld de, $0001

Jump_0A0_5CC8::
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl+], a
    ret

Func_0A0_5CCD::
    push hl
    ld de, $0000
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    inc hl
    inc hl
    call Func_0A0_5CF9
    call Func_0A0_5CF9
    call Func_0A0_5CF9
    call Func_0A0_5CF9
    call Func_0A0_5CF9
    ld a, e
    ld [$D0A6], a
    ld hl, $5D54
    add a, l
    ld l, a
    jr nc, Jump_0A0_5CF1
    inc h

Jump_0A0_5CF1::
    ld a, [hl]
    pop hl
    add a, l
    ld l, a
    jr nc, Jump_0A0_5CF8
    inc h

Jump_0A0_5CF8::
    ret

Func_0A0_5CF9::
    inc hl
    inc d
    ld a, [hl+]
    push hl
    ld h, [hl]
    ld l, a
    call Func_000_3E7A
    call z, Func_0A0_5D4B
    jr nc, Jump_0A0_5D0A
    ld b, h
    ld c, l
    ld e, d

Jump_0A0_5D0A::
    pop hl
    ret

Func_0A0_5D0C::
    push hl
    ld de, $0000
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    inc hl
    inc hl
    call Func_0A0_5D38
    call Func_0A0_5D38
    call Func_0A0_5D38
    call Func_0A0_5D38
    call Func_0A0_5D38
    ld a, e
    ld [$D0A6], a
    ld hl, $5D54
    add a, l
    ld l, a
    jr nc, Jump_0A0_5D30
    inc h

Jump_0A0_5D30::
    ld a, [hl]
    pop hl
    add a, l
    ld l, a
    jr nc, Jump_0A0_5D37
    inc h

Jump_0A0_5D37::
    ret

Func_0A0_5D38::
    inc hl
    inc d
    ld a, [hl+]
    push hl
    ld h, [hl]
    ld l, a
    call Func_000_3E7A
    call z, Func_0A0_5D4B
    jr c, Jump_0A0_5D49
    ld b, h
    ld c, l
    ld e, d

Jump_0A0_5D49::
    pop hl
    ret

Func_0A0_5D4B::
    call Func_000_3ED4
    ld a, [$C5E7]
    cp a, $80
    ret
    db $00, $04, $06, $08, $0A, $0C, $01, $02, $03, $04, $05, $06, $08, $0A, $01, $01
    db $01, $01, $01, $01, $01, $01, $E8, $03, $E8, $03, $E8, $03, $E8, $03, $E8, $03
    db $E8, $03, $E8, $03, $E8, $03

Func_0A0_5D7A::
    ld hl, $DAD8
    ld b, $08

Jump_0A0_5D7F::
    set 7, [hl]
    inc hl
    dec b
    jr nz, Jump_0A0_5D7F
    ld hl, $D854
    ld bc, $0010
    xor a, a
    call Func_000_0949
    ld hl, $D895
    ld bc, $000A
    xor a, a
    call Func_000_0949
    ld hl, $DA1C
    ld bc, $0010
    ld a, $FF
    call Func_000_0949
    ld a, $FF
    ld [$D892], a
    ld [$D893], a
    ld a, $00
    ld [$C46B], a
    ld bc, $0200
    ld hl, $DA5B
    push bc

Jump_0A0_5DB8::
    ld a, [hl+]
    or a, a
    jr nz, Jump_0A0_5DBD
    inc c

Jump_0A0_5DBD::
    dec b
    jr nz, Jump_0A0_5DB8
    ld a, c
    or a, a
    jr nz, Jump_0A0_5DC8
    ld hl, $CFC9
    inc [hl]

Jump_0A0_5DC8::
    pop bc

Jump_0A0_5DC9::
    ld e, $03
    ld a, c
    call Func_000_3E54
    jr c, Jump_0A0_5DF8
    ld e, $01
    ld a, c
    call Func_000_3E25
    jr c, Jump_0A0_5DF8
    ld a, c
    ld hl, $D80F
    call Func_000_3F25
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_0A0_5DF8
    ld a, [hl+]
    and a, $0C
    jr nz, Jump_0A0_5DF8
    ld a, [hl+]
    and a, $30
    jr nz, Jump_0A0_5DF8
    inc hl
    inc hl
    ld a, [hl]
    and a, $03
    jr nz, Jump_0A0_5DF8
    ld e, $00

Jump_0A0_5DF8::
    ld a, c
    ld hl, $DA5B
    add a, l
    ld l, a
    jr nc, Jump_0A0_5E01
    inc h

Jump_0A0_5E01::
    ld [hl], e
    inc c
    dec b
    jr nz, Jump_0A0_5DC9
    ret

Func_0A0_5E07::
    ld a, [$CFCA]
    rst $00
    dw Jump_0A0_5E25
    dw Jump_0A0_5F76
    dw Jump_0A0_63F2
    dw Jump_0A0_63F3
    dw Jump_0A0_6424
    dw Jump_0A0_6442
    dw Jump_0A0_6497
    dw Jump_0A0_64C1
    dw Jump_0A0_64D0
    dw Jump_0A0_6553
    dw Jump_0A0_6585
    dw Jump_0A0_659D
    dw Jump_0A0_65BD

Jump_0A0_5E25::
    ld a, [$CFCB]
    rst $00
    dw Jump_0A0_5E39
    dw Jump_0A0_5E71
    dw Jump_0A0_5E93
    dw Jump_0A0_5EBE
    dw Jump_0A0_5EC6
    dw Jump_0A0_5F40
    dw Jump_0A0_5F51
    dw Jump_0A0_5F5C

Jump_0A0_5E39::
    ld hl, $DAD8
    set 7, [hl]
    inc hl
    set 7, [hl]
    inc hl
    set 7, [hl]
    inc hl
    set 7, [hl]
    ld hl, $72C9
    ld b, $31
    rst $10
    ld hl, $7536
    ld b, $31
    rst $10
    ld hl, $8ED0
    ld de, $0701
    ld a, $02
    ld [$C528], a
    ld a, $00
    ld [$C529], a
    call Func_0A0_6C81
    ld hl, $727D
    ld b, $1A
    rst $10
    ld hl, $CFCB
    inc [hl]
    ret

Jump_0A0_5E71::
    call Func_0A0_4C81
    ld hl, $6977
    ld a, [$C46B]
    and a, $03
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A0_5E82
    inc h

Jump_0A0_5E82::
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, $9800
    add hl, de
    ld a, $BB
    call Func_000_1211
    ld hl, $CFCB
    inc [hl]
    ret

Jump_0A0_5E93::
    ld de, $6977
    ld hl, $C46B
    call Func_0A0_65CF
    ld a, [$C562]
    bit 0, a
    jr z, Jump_0A0_5EBD
    ld a, $69
    call Func_000_1278
    ld hl, $C46C
    ld bc, $0007
    ld a, $00
    call Func_000_0949
    ld hl, $72C9
    ld b, $31
    rst $10
    ld hl, $CFCB
    inc [hl]

Jump_0A0_5EBD::
    ret

Jump_0A0_5EBE::
    call Func_0A0_4C81
    ld hl, $CFCB
    inc [hl]
    ret

Jump_0A0_5EC6::
    ld a, [$C46B]
    and a, $03
    ld [$CFDB], a
    or a, a
    jr z, Jump_0A0_5EDB
    cp a, $01
    jr z, Jump_0A0_5EEA
    cp a, $02
    jr z, Jump_0A0_5F1C
    jr Jump_0A0_5F20

Jump_0A0_5EDB::
    call Func_0A0_5F2E
    ld a, $03
    ld [$CFCA], a
    xor a, a
    ld [$CFCB], a
    jp Jump_0A0_5F2D

Jump_0A0_5EEA::
    ld a, [$C57F]
    rrca
    and a, $01
    ld c, a
    ld hl, $DA5B
    add a, l
    ld l, a
    jr nc, Jump_0A0_5EF9
    inc h

Jump_0A0_5EF9::
    ld a, [hl]
    or a, a
    jr z, Jump_0A0_5F0D
    ld a, $00
    ld [$C528], a
    ld a, $2D
    ld [$C529], a
    ld hl, $CFCB
    inc [hl]
    jr Jump_0A0_5F2D

Jump_0A0_5F0D::
    ld a, c
    ld [$CFD4], a
    ld a, $01
    ld [$CFCA], a
    xor a, a
    ld [$CFCB], a
    jr Jump_0A0_5F2D

Jump_0A0_5F1C::
    ld a, $1D
    jr Jump_0A0_5F22

Jump_0A0_5F20::
    ld a, $20

Jump_0A0_5F22::
    ld [$C529], a
    xor a, a
    ld [$C528], a
    ld hl, $CFCB
    inc [hl]

Jump_0A0_5F2D::
    ret

Func_0A0_5F2E::
    ld a, [$C57F]
    and a, $02
    ld hl, $DA1C
    add a, l
    ld l, a
    jr nc, Jump_0A0_5F3B
    inc h

Jump_0A0_5F3B::
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ret

Jump_0A0_5F40::
    call Func_0A0_6A2C
    ld hl, $7276
    ld b, $1A
    rst $10
    call Func_0A0_4C74
    ld hl, $CFCB
    inc [hl]
    ret

Jump_0A0_5F51::
    ld hl, $4001
    ld b, $2F
    rst $10
    ld hl, $CFCB
    inc [hl]
    ret

Jump_0A0_5F5C::
    ld a, [$C52B]
    or a, a
    ret nz
    ld hl, $72C9
    ld b, $31
    rst $10
    call Func_0A0_4C74
    ld hl, $727D
    ld b, $1A
    rst $10
    ld a, $01
    ld [$CFCB], a
    ret

Jump_0A0_5F76::
    ld a, [$CFCB]
    rst $00
    dw Jump_0A0_5FAC
    dw Jump_0A0_5FEB
    dw Jump_0A0_6021
    dw Jump_0A0_60A0
    dw Jump_0A0_60AC
    dw Jump_0A0_60F3
    dw Jump_0A0_6115
    dw Jump_0A0_61DA
    dw Jump_0A0_61E9
    dw Jump_0A0_61FA
    dw Jump_0A0_622A
    dw Jump_0A0_623A
    dw Jump_0A0_6243
    dw Jump_0A0_62A3
    dw Jump_0A0_62CD
    dw Jump_0A0_639B
    dw Jump_0A0_63A9
    dw Jump_0A0_63BD
    dw Jump_0A0_63CF
    dw Jump_0A0_63DF
    dw Jump_0A0_63E8
    dw Jump_0A0_61E9
    dw Jump_0A0_6212
    dw Jump_0A0_622A
    dw Jump_0A0_623A

Jump_0A0_5FAC::
    ld hl, $8ED0
    ld de, $2001
    ld a, $02
    ld [$C528], a
    ld a, $01
    ld [$C529], a
    call Func_0A0_6C81
    ld a, $08
    ld [$C529], a
    ld hl, $9050
    ld de, $0801
    call Func_0A0_6C81
    xor a, a
    ld [$CFD7], a
    ld a, $03
    ld [$CFD6], a
    xor a, a
    ld [$CFD5], a
    ld hl, $728B
    ld b, $1A
    rst $10
    ld hl, $C29B
    call Func_0A0_67B8
    ld hl, $CFCB
    inc [hl]
    ret

Jump_0A0_5FEB::
    ld a, [$CFD4]
    ld hl, $CFD8
    add a, l
    ld l, a
    jr nc, Jump_0A0_5FF6
    inc h

Jump_0A0_5FF6::
    ld a, [hl]
    ld [$C46C], a
    call Func_0A0_4C8E
    ld hl, $697F
    ld a, [$C46C]
    and a, $03
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A0_600B
    inc h

Jump_0A0_600B::
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, $9800
    add hl, de
    ld a, $BB
    call Func_000_1211
    ld hl, $CFCB
    inc [hl]
    ld a, $03
    ld [$CFD3], a
    ret

Jump_0A0_6021::
    ld de, $697F
    ld hl, $C46C
    call Func_0A0_666B
    ld a, [$C562]
    bit 0, a
    jr z, Jump_0A0_6062
    ld a, $69
    call Func_000_1278
    ld a, [$CFD4]
    ld hl, $CFD8
    add a, l
    ld l, a
    jr nc, Jump_0A0_6041
    inc h

Jump_0A0_6041::
    ld a, [$C46C]
    and a, $03
    ld [hl], a
    call Func_0A0_69A1
    cp a, $03
    jr nz, Jump_0A0_606D
    ld hl, $72C9
    ld b, $31
    rst $10
    ld hl, $CFCB
    inc [hl]
    ld hl, $CFCB
    inc [hl]
    ld a, $00
    ld [$D869], a
    ret

Jump_0A0_6062::
    bit 1, a
    jr z, Jump_0A0_609F
    ld a, $00
    ld [$D869], a
    jr Jump_0A0_6095

Jump_0A0_606D::
    ld a, [$CFD4]
    ld hl, $DA1C
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A0_6079
    inc h

Jump_0A0_6079::
    ld a, $FF
    ld [hl+], a
    ld [hl], a
    ld a, [$CFD4]
    ld hl, $DAD8
    add a, l
    ld l, a
    jr nc, Jump_0A0_6088
    inc h

Jump_0A0_6088::
    set 7, [hl]
    xor a, a
    ld [$CFCB], a
    ld a, $03
    ld [$CFCA], a
    jr Jump_0A0_609F

Jump_0A0_6095::
    ld hl, $72C9
    ld b, $31
    rst $10
    ld hl, $CFCB
    inc [hl]

Jump_0A0_609F::
    ret

Jump_0A0_60A0::
    call Func_0A0_4C8E
    xor a, a
    ld [$CFCB], a
    xor a, a
    ld [$CFCA], a
    ret

Jump_0A0_60AC::
    ld a, [$D869]
    or a, a
    call z, Func_0A0_4C8E
    xor a, a
    ld [$D869], a
    ld hl, $8ED0
    ld de, $0803
    ld a, $02
    ld [$C528], a
    ld a, $09
    ld [$C529], a
    call Func_0A0_6C81
    ld hl, $7299
    ld b, $1A
    rst $10
    ld a, [$CFD4]
    and a, $03
    ld hl, $C2DA
    call Func_0A0_67B8
    ld a, [$CFD4]
    ld hl, $DAD8
    add a, l
    ld l, a
    jr nc, Jump_0A0_60E6
    inc h

Jump_0A0_60E6::
    ld a, [hl]
    swap a
    and a, $03
    ld [$C46D], a
    ld hl, $CFCB
    inc [hl]
    ret

Jump_0A0_60F3::
    call Func_0A0_4C9B
    ld hl, $6987
    ld a, [$C46D]
    and a, $03
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A0_6104
    inc h

Jump_0A0_6104::
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, $9800
    add hl, de
    ld a, $BB
    call Func_000_1211
    ld hl, $CFCB
    inc [hl]
    ret

Jump_0A0_6115::
    ld de, $6987
    ld hl, $C46D
    call Func_0A0_661B
    ld a, [$C562]
    bit 1, a
    jr z, Jump_0A0_6137
    ld a, $00
    ld [$D869], a
    ld hl, $72C9
    ld b, $31
    rst $10
    ld hl, $CFCB
    inc [hl]
    jp Jump_0A0_61D9

Jump_0A0_6137::
    bit 0, a
    jp z, Jump_0A0_61D9
    ld a, $69
    call Func_000_1278
    ld a, [$CFD4]
    ld hl, $DAD8
    add a, l
    ld l, a
    jr nc, Jump_0A0_614C
    inc h

Jump_0A0_614C::
    ld a, [hl]
    and a, $0F
    ld [hl], a
    ld a, [$C46D]
    and a, $03
    swap a
    or a, [hl]
    ld [hl], a
    ld a, [$C46D]
    and a, $03
    or a, a
    jr z, Jump_0A0_6167
    cp a, $01
    jr z, Jump_0A0_6192
    jr Jump_0A0_61B7

Jump_0A0_6167::
    ld a, [$CFD4]
    ld hl, $DA1C
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A0_6173
    inc h

Jump_0A0_6173::
    ld a, $C0
    ld [hl+], a
    ld a, [$CFD4]
    xor a, $01
    ld c, a
    call Func_000_3E54
    jr c, Jump_0A0_6185
    ld a, c
    ld [hl], a
    jr Jump_0A0_61CA

Jump_0A0_6185::
    ld hl, $72C9
    ld b, $31
    rst $10
    ld a, $15
    ld [$CFCB], a
    jr Jump_0A0_61D9

Jump_0A0_6192::
    call Func_0A0_67D4
    ld a, d
    or a, a
    jr nz, Jump_0A0_61A6
    ld hl, $72C9
    ld b, $31
    rst $10
    ld a, $08
    ld [$CFCB], a
    jr Jump_0A0_61D9

Jump_0A0_61A6::
    ld hl, $72C9
    ld b, $31
    rst $10
    xor a, a
    ld [$D869], a
    ld a, $0C
    ld [$CFCB], a
    jr Jump_0A0_61D9

Jump_0A0_61B7::
    ld a, [$CFD4]
    ld hl, $DA1C
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A0_61C3
    inc h

Jump_0A0_61C3::
    ld a, $AC
    ld [hl+], a
    ld a, [$CFD4]
    ld [hl], a

Jump_0A0_61CA::
    ld a, $01
    ld [$D869], a
    ld hl, $72C9
    ld b, $31
    rst $10
    ld hl, $CFCB
    inc [hl]

Jump_0A0_61D9::
    ret

Jump_0A0_61DA::
    call Func_0A0_4C9B
    ld a, [$D869]
    or a, a
    jr z, Jump_0A0_61E5
    ld a, $14

Jump_0A0_61E5::
    ld [$CFCB], a
    ret

Jump_0A0_61E9::
    call Func_0A0_4C9B
    call Func_000_290E
    ld hl, $7276
    ld b, $1A
    rst $10
    ld hl, $CFCB
    inc [hl]
    ret

Jump_0A0_61FA::
    call Func_0A0_4C74
    ld a, $00
    ld [$C528], a
    ld a, $29
    ld [$C529], a
    ld hl, $4001
    ld b, $2F
    rst $10
    ld hl, $CFCB
    inc [hl]
    ret

Jump_0A0_6212::
    call Func_0A0_4C74
    ld a, $00
    ld [$C528], a
    ld a, $7F
    ld [$C529], a
    ld hl, $4001
    ld b, $2F
    rst $10
    ld hl, $CFCB
    inc [hl]
    ret

Jump_0A0_622A::
    ld a, [$C52B]
    or a, a
    ret nz
    ld hl, $72C9
    ld b, $31
    rst $10
    ld hl, $CFCB
    inc [hl]
    ret

Jump_0A0_623A::
    call Func_0A0_4C74
    ld a, $04
    ld [$CFCB], a
    ret

Jump_0A0_6243::
    ld a, [$D869]
    or a, a
    call z, Func_0A0_4C9B
    xor a, a
    ld [$D869], a
    ld a, [$CFD4]
    ld hl, $DAD8
    add a, l
    ld l, a
    jr nc, Jump_0A0_6259
    inc h

Jump_0A0_6259::
    ld a, [hl]
    and a, $03
    ld [$C46E], a
    ld a, [hl]
    rrca
    rrca
    and a, $01
    ld [$CFD5], a
    ld hl, $CFD5
    res 7, [hl]
    ld de, $697F
    call Func_0A0_6822
    call Func_0A0_6873
    ld hl, $72B5
    ld b, $1A
    rst $10
    ld a, $09
    ld [$C528], a
    ld a, [$D86A]
    ld l, a
    ld a, [$D86B]
    ld h, a
    ld a, [$CFD5]
    add a, a
    add a, a
    ld c, a
    ld a, [$C46E]
    and a, $03
    add a, c
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A0_629A
    inc h

Jump_0A0_629A::
    ld a, [hl]
    call Func_0A0_6909
    ld hl, $CFCB
    inc [hl]
    ret

Jump_0A0_62A3::
    call Func_0A0_4CD4
    ld hl, $697F
    ld a, [$C46E]
    and a, $03
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A0_62B4
    inc h

Jump_0A0_62B4::
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, $9800
    add hl, de
    ld a, $BB
    call Func_000_1211
    call Func_0A0_694B
    ld hl, $CFCB
    inc [hl]
    ld a, $03
    ld [$CFD3], a
    ret

Jump_0A0_62CD::
    ld de, $697F
    ld hl, $C46E
    call Func_0A0_666B
    ld a, [$C562]
    bit 0, a
    jp z, Jump_0A0_6354
    ld a, $69
    call Func_000_1278
    ld hl, $72C9
    ld b, $31
    rst $10
    ld a, $14
    ld [$D869], a
    call Func_0A0_69C1
    ld a, [$CFF1]
    bit 0, a
    jp z, Jump_0A0_6373
    ld a, [$CFD4]
    ld hl, $D8DF
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A0_6305
    inc h

Jump_0A0_6305::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, [$CFEE]
    ld c, a
    cp a, $FF
    jr nz, Jump_0A0_6312
    ld c, $01

Jump_0A0_6312::
    xor a, a
    ld b, a
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    bit 7, h
    jp nz, Jump_0A0_6387
    ld a, [$CFD4]
    ld hl, $DAD8
    add a, l
    ld l, a
    jr nc, Jump_0A0_632A
    inc h

Jump_0A0_632A::
    ld a, [hl]
    and a, $F0
    ld [hl], a
    ld a, [$CFD5]
    rlca
    rlca
    and a, $04
    or a, [hl]
    ld [hl], a
    ld a, [$C46E]
    and a, $03
    or a, [hl]
    ld [hl], a
    ld a, [$CFD4]
    ld hl, $DA1C
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A0_634A
    inc h

Jump_0A0_634A::
    ld a, [$CFEC]
    ld [hl], a
    ld hl, $CFCB
    inc [hl]
    jr Jump_0A0_6372

Jump_0A0_6354::
    ld a, [$C562]
    bit 1, a
    jr z, Jump_0A0_636C
    ld hl, $72C9
    ld b, $31
    rst $10
    ld a, $04
    ld [$D869], a
    ld hl, $CFCB
    inc [hl]
    jr Jump_0A0_6372

Jump_0A0_636C::
    call Func_0A0_6873
    call Func_0A0_694B

Jump_0A0_6372::
    ret

Jump_0A0_6373::
    ld a, $25
    ld [$C529], a
    ld a, $13
    ld [$D869], a
    ld hl, $CFCB
    inc [hl]
    ld hl, $CFCB
    inc [hl]
    jr Jump_0A0_6372

Jump_0A0_6387::
    ld a, $26
    ld [$C529], a
    ld a, $13
    ld [$D869], a
    ld hl, $CFCB
    inc [hl]
    ld hl, $CFCB
    inc [hl]
    jr Jump_0A0_6372

Jump_0A0_639B::
    call Func_0A0_4CD4
    ld a, [$D869]
    ld [$CFCB], a
    xor a, a
    ld [$D869], a
    ret

Jump_0A0_63A9::
    ld hl, $72C9
    ld b, $31
    rst $10
    call Func_0A0_4CD4
    ld hl, $7276
    ld b, $1A
    rst $10
    ld hl, $CFCB
    inc [hl]
    ret

Jump_0A0_63BD::
    call Func_0A0_4C74
    xor a, a
    ld [$C528], a
    ld hl, $4001
    ld b, $2F
    rst $10
    ld hl, $CFCB
    inc [hl]
    ret

Jump_0A0_63CF::
    ld a, [$C52B]
    or a, a
    ret nz
    ld hl, $72C9
    ld b, $31
    rst $10
    ld hl, $CFCB
    inc [hl]
    ret

Jump_0A0_63DF::
    call Func_0A0_4C74
    ld a, $0C
    ld [$CFCB], a
    ret

Jump_0A0_63E8::
    xor a, a
    ld [$CFCB], a
    ld a, $03
    ld [$CFCA], a
    ret

Jump_0A0_63F2::
    ret

Jump_0A0_63F3::
    ld b, $08
    ld hl, $DA5B

Jump_0A0_63F8::
    ld a, [hl]
    or a, a
    jr nz, Jump_0A0_63FE
    ld [hl], $01

Jump_0A0_63FE::
    inc hl
    dec b
    jr nz, Jump_0A0_63F8
    xor a, a
    ld [$D8A4], a
    ld hl, $72C9
    ld b, $31
    rst $10
    call Func_0A0_6A2C
    ld hl, $7276
    ld b, $1A
    rst $10
    ld hl, $7536
    ld b, $31
    rst $10
    ld hl, $CFCA
    inc [hl]
    xor a, a
    ld [$C594], a
    ret

Jump_0A0_6424::
    ld de, $D05A
    ld hl, $C130
    call Func_000_2FE1
    ld a, $00
    ld [$C528], a
    ld a, $22
    ld [$C529], a
    ld hl, $4001
    ld b, $2F
    rst $10
    ld hl, $CFCA
    inc [hl]
    ret

Jump_0A0_6442::
    call Func_000_3ED4
    ld a, [$C5E7]
    cp a, $F3
    ret z
    ld a, [$C5E8]
    cp a, $F3
    ret z
    ld a, [$C57F]
    rrca
    and a, $01
    ld hl, $DA43
    add a, l
    ld l, a
    jr nc, Jump_0A0_645F
    inc h

Jump_0A0_645F::
    ld d, [hl]
    ld hl, $C597
    ld a, [$C46B]
    ld [hl+], a
    ld a, [$C46C]
    ld [hl+], a
    ld a, d
    ld [hl+], a
    ld a, [$C5E7]
    ld [hl+], a
    ld a, [$C5E8]
    ld [hl+], a
    ld a, [$DAD8]
    ld [hl+], a
    ld a, [$DAD9]
    ld [hl+], a
    ld a, [$DA1C]
    ld [hl+], a
    ld a, [$DA1D]
    ld [hl+], a
    ld a, [$DA1E]
    ld [hl+], a
    ld a, [$DA1F]
    ld [hl+], a
    ld a, $01
    ld [$C594], a
    ld hl, $CFCA
    inc [hl]
    ret

Jump_0A0_6497::
    ld a, [$C58F]
    cp a, $01
    ret nz
    ld hl, $CFCA
    inc [hl]
    xor a, a
    ld [$C593], a
    ld a, $0B
    ld [$C592], a
    ld hl, $C597
    ld a, l
    ld [$C595], a
    ld a, h
    ld [$C596], a
    ld hl, $C5B7
    ld a, l
    ld [$C590], a
    ld a, h
    ld [$C591], a
    ret

Jump_0A0_64C1::
    ld hl, $CFCA
    inc [hl]
    ld a, $FF
    ld [$C594], a
    ld a, $01
    ld [$C58C], a
    ret

Jump_0A0_64D0::
    ld a, [$C58F]
    cp a, $F0
    ret nz
    xor a, a
    ld [$C594], a
    xor a, a
    ld [$C58C], a
    ld a, [$C57F]
    bit 1, a
    jr nz, Jump_0A0_6513
    ld hl, $C5B7
    ld a, [hl+]
    ld [$DAE9], a
    ld a, [hl+]
    ld [$DAEA], a
    ld a, [hl+]
    ld [$DA44], a
    ld a, [$C59A]
    ld [hl+], a
    ld a, [$C59B]
    ld [hl+], a
    inc hl
    ld a, [hl+]
    ld [$DAD9], a
    inc hl
    inc hl
    ld a, [hl+]
    ld [$DA1E], a
    ld a, [hl]
    ld [$DA1F], a
    ld hl, $DA44
    ld de, $DA4C
    jr Jump_0A0_6548

Jump_0A0_6513::
    ld hl, $C46B
    ld a, [hl+]
    ld [$DAE9], a
    ld a, [hl]
    ld [$DAEA], a
    ld hl, $C5B7
    ld a, [hl+]
    ld [$C46B], a
    ld a, [hl+]
    ld [$C46C], a
    ld a, [hl+]
    ld [$DA43], a
    ld a, [hl+]
    ld [$C5E7], a
    ld a, [hl+]
    ld [$C5E8], a
    ld a, [hl+]
    ld [$DAD8], a
    inc hl
    ld a, [hl+]
    ld [$DA1C], a
    ld a, [hl]
    ld [$DA1D], a
    ld hl, $DA43
    ld de, $DA4B

Jump_0A0_6548::
    ld a, [hl]
    cp a, $03
    jr z, Jump_0A0_654E
    ld [de], a

Jump_0A0_654E::
    ld hl, $CFCA
    inc [hl]
    ret

Jump_0A0_6553::
    ld hl, $C59A
    ld a, [hl+]
    ld b, a
    ld a, [$C5E7]
    cp a, b
    ld a, [$C5BA]
    cp a, b
    jr nz, Jump_0A0_6578
    ld a, [hl]
    ld b, a
    ld a, [$C5E8]
    cp a, b
    ld a, [$C5BB]
    cp a, b
    jr nz, Jump_0A0_6578
    ld a, $22
    ld [$C594], a
    ld [$CF8B], a
    jr Jump_0A0_6580

Jump_0A0_6578::
    ld a, $33
    ld [$C594], a
    ld [$CF8B], a

Jump_0A0_6580::
    ld hl, $CFCA
    inc [hl]
    ret

Jump_0A0_6585::
    ld a, [$C58F]
    cp a, $22
    jr z, Jump_0A0_6591
    cp a, $33
    jr z, Jump_0A0_6591
    ret

Jump_0A0_6591::
    ld [$CF8C], a
    xor a, a
    ld [$C594], a
    ld hl, $CFCA
    inc [hl]
    ret

Jump_0A0_659D::
    ld a, [$CF8B]
    cp a, $22
    jr nz, Jump_0A0_65AD
    ld a, [$CF8C]
    cp a, $22
    jr nz, Jump_0A0_65AD
    jr Jump_0A0_65B3

Jump_0A0_65AD::
    ld a, $05
    ld [$CFCA], a
    ret

Jump_0A0_65B3::
    ld hl, $CFCA
    inc [hl]
    ld a, $02
    ld [$C594], a
    ret

Jump_0A0_65BD::
    ld a, [$C58F]
    cp a, $02
    ret nz
    call Func_000_290E
    ld hl, $CFC9
    inc [hl]
    xor a, a
    ld [$CFCA], a
    ret

Func_0A0_65CF::
    ld a, [$C563]
    and a, $C0
    jr z, Jump_0A0_65E7
    call Func_0A0_677A
    ld a, [hl]
    xor a, $01
    ld [hl], a
    call Func_0A0_6799
    ld a, $69
    call Func_000_1278
    jr Jump_0A0_6612

Jump_0A0_65E7::
    ld a, [$C563]
    and a, $30
    jr z, Jump_0A0_65FF
    call Func_0A0_677A
    ld a, [hl]
    xor a, $02
    ld [hl], a
    call Func_0A0_6799
    ld a, $69
    call Func_000_1278
    jr Jump_0A0_6612

Jump_0A0_65FF::
    ld a, [$C5F0]
    and a, $0F
    jr nz, Jump_0A0_661A
    bit 6, [hl]
    jr z, Jump_0A0_660F
    call Func_0A0_6799
    jr Jump_0A0_6612

Jump_0A0_660F::
    call Func_0A0_677A

Jump_0A0_6612::
    ld a, [$C5F0]
    and a, $F0
    ld [$C5F0], a

Jump_0A0_661A::
    ret

Func_0A0_661B::
    ld a, [$C563]
    and a, $40
    jr z, Jump_0A0_6631
    call Func_0A0_677A
    ld a, [hl]
    and a, $03
    dec a
    cp a, $FF
    jr nz, Jump_0A0_6644
    ld a, $02
    jr Jump_0A0_6644

Jump_0A0_6631::
    ld a, [$C563]
    and a, $80
    jr z, Jump_0A0_664F
    call Func_0A0_677A
    ld a, [hl]
    and a, $03
    inc a
    cp a, $03
    jr nz, Jump_0A0_6644
    xor a, a

Jump_0A0_6644::
    ld [hl], a
    call Func_0A0_6799
    ld a, $69
    call Func_000_1278
    jr Jump_0A0_6662

Jump_0A0_664F::
    ld a, [$C5F0]
    and a, $0F
    jr nz, Jump_0A0_666A
    bit 6, [hl]
    jr z, Jump_0A0_665F
    call Func_0A0_6799
    jr Jump_0A0_6662

Jump_0A0_665F::
    call Func_0A0_677A

Jump_0A0_6662::
    ld a, [$C5F0]
    and a, $F0
    ld [$C5F0], a

Jump_0A0_666A::
    ret

Func_0A0_666B::
    ld a, [$C563]
    and a, $40
    jr z, Jump_0A0_66AF
    ld a, [$CFD5]
    ld b, a
    ld a, [$CFD7]
    cp a, b
    jr nz, Jump_0A0_6693
    ld a, [$CFD6]
    or a, a
    jp z, Jump_0A0_6771
    call Func_0A0_677A
    ld a, [hl]
    and a, $0F
    dec a
    cp a, $FF
    jr nz, Jump_0A0_66A1
    ld a, [$CFD6]
    jr Jump_0A0_66A1

Jump_0A0_6693::
    call Func_0A0_677A
    ld a, [hl]
    and a, $0F
    dec a
    cp a, $FF
    jr nz, Jump_0A0_66A1
    ld a, [$CFD3]

Jump_0A0_66A1::
    ld [hl], a
    call Func_0A0_6799
    set 7, [hl]
    ld a, $69
    call Func_000_1278
    jp Jump_0A0_6771

Jump_0A0_66AF::
    ld a, [$C563]
    and a, $80
    jr z, Jump_0A0_66F4
    ld a, [$CFD5]
    ld b, a
    ld a, [$CFD7]
    cp a, b
    jr nz, Jump_0A0_66D7
    ld a, [$CFD6]
    or a, a
    jp z, Jump_0A0_6771
    ld b, a
    call Func_0A0_677A
    inc b
    ld a, [hl]
    and a, $0F
    inc a
    cp a, b
    jr nz, Jump_0A0_66E7
    ld a, $00
    jr Jump_0A0_66E7

Jump_0A0_66D7::
    call Func_0A0_677A
    ld a, [$CFD3]
    inc a
    ld b, a
    ld a, [hl]
    and a, $0F
    inc a
    cp a, b
    jr nz, Jump_0A0_66E7
    xor a, a

Jump_0A0_66E7::
    ld [hl], a
    call Func_0A0_6799
    set 7, [hl]
    ld a, $69
    call Func_000_1278
    jr Jump_0A0_6771

Jump_0A0_66F4::
    ld a, [$CFD7]
    or a, a
    jr z, Jump_0A0_6735
    ld b, a
    ld a, [$C563]
    and a, $20
    jr z, Jump_0A0_6718
    ld a, [$CFD5]
    or a, a
    jr nz, Jump_0A0_670B
    ld a, b
    jr Jump_0A0_670C

Jump_0A0_670B::
    dec a

Jump_0A0_670C::
    or a, $80
    ld [$CFD5], a
    ld a, $69
    call Func_000_1278
    jr Jump_0A0_674A

Jump_0A0_6718::
    ld a, [$C563]
    and a, $10
    jr z, Jump_0A0_6735
    ld a, [$CFD5]
    cp a, b
    jr nz, Jump_0A0_6728
    xor a, a
    jr Jump_0A0_6729

Jump_0A0_6728::
    inc a

Jump_0A0_6729::
    or a, $80
    ld [$CFD5], a
    ld a, $69
    call Func_000_1278
    jr Jump_0A0_674A

Jump_0A0_6735::
    ld a, [$C5F0]
    and a, $0F
    jr nz, Jump_0A0_6779
    bit 6, [hl]
    jr z, Jump_0A0_6745
    call Func_0A0_6799
    jr Jump_0A0_6771

Jump_0A0_6745::
    call Func_0A0_677A
    jr Jump_0A0_6771

Jump_0A0_674A::
    call Func_0A0_677A
    ld a, [$CFD7]
    ld b, a
    ld a, [$CFD5]
    res 7, a
    cp a, b
    jr nz, Jump_0A0_6771
    ld a, [$CFD6]
    or a, a
    jr nz, Jump_0A0_6762
    xor a, a
    jr Jump_0A0_676E

Jump_0A0_6762::
    ld b, a

Jump_0A0_6763::
    ld a, [hl]
    and a, $0F
    cp a, b
    jr z, Jump_0A0_676E
    jr c, Jump_0A0_6771
    dec [hl]
    jr Jump_0A0_6763

Jump_0A0_676E::
    set 7, a
    ld [hl], a

Jump_0A0_6771::
    ld a, [$C5F0]
    and a, $F0
    ld [$C5F0], a

Jump_0A0_6779::
    ret

Func_0A0_677A::
    set 6, [hl]
    ld a, [hl]
    and a, $3F
    push hl
    add a, a
    add a, e
    ld l, a
    ld a, d
    adc a, $00
    ld h, a
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $98
    ld h, a
    ld a, $C3
    call Func_000_1211
    pop hl
    ret

Func_0A0_6799::
    res 6, [hl]
    ld a, [hl]
    and a, $3F
    push hl
    add a, a
    add a, e
    ld l, a
    ld a, d
    adc a, $00
    ld h, a
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $98
    ld h, a
    ld a, $BB
    call Func_000_1211
    pop hl
    ret

Func_0A0_67B8::
    push hl
    ld a, [$CFD4]
    ld hl, $67D2
    add a, l
    ld l, a
    jr nc, Jump_0A0_67C4
    inc h

Jump_0A0_67C4::
    xor a, a
    ld [$C46C], a
    ld a, [hl]
    pop hl
    ld b, $05

Jump_0A0_67CC::
    ld [hl+], a
    inc a
    dec b
    jr nz, Jump_0A0_67CC
    ret
    db $D0, $D5

Func_0A0_67D4::
    ld a, [$CFD4]
    ld hl, $D989
    swap a
    and a, $F0
    add a, l
    ld l, a
    jr nc, Jump_0A0_67E3
    inc h

Jump_0A0_67E3::
    ld a, l
    ld [$D86A], a
    ld a, h
    ld [$D86B], a
    ld bc, $0800
    ld d, $00

Jump_0A0_67F0::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_0A0_6806
    or a, a
    jr z, Jump_0A0_6806
    cp a, $A2
    jr c, Jump_0A0_6800
    cp a, $AA
    jr c, Jump_0A0_6801

Jump_0A0_6800::
    inc d

Jump_0A0_6801::
    inc c
    inc hl
    dec b
    jr nz, Jump_0A0_67F0

Jump_0A0_6806::
    ld a, c
    cp a, $05
    ld a, $00
    jr c, Jump_0A0_680E
    inc a

Jump_0A0_680E::
    ld [$CFD7], a
    ld a, c
    or a, a
    jr z, Jump_0A0_681A
    and a, $03
    dec a
    and a, $03

Jump_0A0_681A::
    ld [$CFD6], a
    xor a, a
    ld [$CFD5], a
    ret

Func_0A0_6822::
    ld a, $04
    ld [$C528], a
    ld a, [$CFD4]
    ld hl, $D989
    swap a
    and a, $F0
    add a, l
    ld l, a
    jr nc, Jump_0A0_6836
    inc h

Jump_0A0_6836::
    ld a, l
    ld [$D86A], a
    ld a, h
    ld [$D86B], a
    ld a, [$CFD5]
    add a, a
    add a, a
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A0_6849
    inc h

Jump_0A0_6849::
    ld a, [hl+]
    inc hl
    cp a, $FF
    call z, Func_0A0_6871
    call Func_0A0_68CF
    ld a, [hl+]
    inc hl
    cp a, $FF
    call z, Func_0A0_6871
    call Func_0A0_68DE
    ld a, [hl+]
    inc hl
    cp a, $FF
    call z, Func_0A0_6871
    call Func_0A0_68ED
    ld a, [hl]
    cp a, $FF
    call z, Func_0A0_6871
    call Func_0A0_68FC
    ret

Func_0A0_6871::
    xor a, a
    ret

Func_0A0_6873::
    ld a, [$CFD5]
    bit 7, a
    jr z, Jump_0A0_688D
    res 7, a
    ld [$CFD5], a
    ld hl, $C46E
    call Func_0A0_6799
    call Func_0A0_6822
    ld hl, $C46E
    set 7, [hl]

Jump_0A0_688D::
    ld a, [$C46E]
    bit 7, a
    ret z
    res 7, a
    ld [$C46E], a
    and a, $0F
    push af
    ld a, $09
    ld [$C528], a
    ld a, [$D86A]
    ld l, a
    ld a, [$D86B]
    ld h, a
    ld a, [$CFD5]
    add a, a
    add a, a
    ld c, a
    pop af
    add a, c
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A0_68B6
    inc h

Jump_0A0_68B6::
    ld a, [hl]
    call Func_0A0_6909
    ld de, $C388
    ld hl, $99F0
    ld a, [de]
    call Func_000_121F
    inc de
    ld a, [de]
    call Func_000_121F
    inc de
    ld a, [de]
    call Func_000_1211
    ret

Func_0A0_68CF::
    ld [$C529], a
    push hl
    ld hl, $8ED0
    ld de, $0901
    call Func_0A0_6CBC
    pop hl
    ret

Func_0A0_68DE::
    ld [$C529], a
    push hl
    ld hl, $8F60
    ld de, $0901
    call Func_0A0_6CBC
    pop hl
    ret

Func_0A0_68ED::
    ld [$C529], a
    push hl
    ld hl, $8FF0
    ld de, $0901
    call Func_0A0_6CBC
    pop hl
    ret

Func_0A0_68FC::
    ld [$C529], a
    ld hl, $9080
    ld de, $0901
    call Func_0A0_6CBC
    ret

Func_0A0_6909::
    push af
    ld [$C529], a
    ld hl, $8800
    ld de, $0603
    call Func_0A0_6CBC
    pop af
    ld [$CFEC], a
    xor a, a
    ld [$CFED], a
    ld hl, $4001
    ld b, $1A
    rst $10
    ld a, [$CFEE]
    cp a, $FF
    jr nz, Jump_0A0_693C
    ld a, [$CFD4]
    ld hl, $D8DF
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A0_6937
    inc h

Jump_0A0_6937::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    jr Jump_0A0_6941

Jump_0A0_693C::
    ld l, a
    ld h, $00
    jr Jump_0A0_6941

Jump_0A0_6941::
    call Func_000_16F5
    ld de, $C388
    call Func_000_2123
    ret

Func_0A0_694B::
    ld a, [$CFD7]
    or a, a
    ret z
    ld hl, $9A26
    ld a, $C5
    call Func_000_121F
    ld a, [$CFD5]
    and a, $07
    inc a
    add a, $E0
    call Func_000_121F
    ld a, $BE
    call Func_000_121F
    ld a, [$CFD7]
    inc a
    add a, $E0
    call Func_000_121F
    ld a, $C6
    call Func_000_1211
    ret
    db $C1, $01, $01, $02, $C7, $01, $07, $02, $41, $01, $81, $01, $C1, $01, $01, $02
    db $81, $01, $C1, $01, $01, $02, $C1, $01, $01, $02, $C1, $01, $01, $02, $29, $00
    db $69, $00, $A9, $00, $E9, $00, $2F, $01, $6F, $01

Func_0A0_69A1::
    push af
    ld a, [$CFD4]
    ld hl, $DA43
    add a, l
    ld l, a
    jr nc, Jump_0A0_69AD
    inc h

Jump_0A0_69AD::
    pop af
    ld [hl], a
    cp a, $03
    ret z
    push af
    ld a, [$CFD4]
    ld hl, $DA4B
    add a, l
    ld l, a
    jr nc, Jump_0A0_69BE
    inc h

Jump_0A0_69BE::
    pop af
    ld [hl], a
    ret

Func_0A0_69C1::
    ld a, [$C46E]
    and a, $03
    ld b, a
    ld a, [$CFD5]
    and a, $01
    add a, a
    add a, a
    add a, b
    add a, a
    ld hl, $D989
    add a, l
    ld l, a
    jr nc, Jump_0A0_69D8
    inc h

Jump_0A0_69D8::
    ld a, [$CFD4]
    swap a
    add a, l
    ld l, a
    jr nc, Jump_0A0_69E2
    inc h

Jump_0A0_69E2::
    ld a, [hl]
    ld [$CFEC], a
    xor a, a
    ld [$CFED], a
    ld hl, $4001
    ld b, $1A
    rst $10
    ret

Func_0A0_69F1:: ; heuristic: follows a terminator; C0
    ld de, $0000
    ld b, $03
    ld a, [$C57F]
    sla a
    and a, $04
    xor a, $04
    ld c, a

Jump_0A0_6A00::
    ld a, c
    call Func_000_3E54
    jr c, Jump_0A0_6A08
    inc d
    ld e, c

Jump_0A0_6A08::
    inc c
    dec b
    jr nz, Jump_0A0_6A00
    ret

Func_0A0_6A0D:: ; heuristic: follows a terminator; C0
    ld d, $00
    ld b, $03
    ld a, [$C57F]
    sla a
    and a, $04
    ld c, a

Jump_0A0_6A19::
    ld a, c
    call Func_000_3E54
    jr c, Jump_0A0_6A20
    inc d

Jump_0A0_6A20::
    inc c
    dec b
    jr nz, Jump_0A0_6A19
    ret

Func_0A0_6A25:: ; heuristic: follows a terminator; C0
    ld hl, $443B
    ld b, $E0
    rst $10
    ret

Func_0A0_6A2C::
    ld hl, $8800
    ld bc, $0120

Jump_0A0_6A32::
    di

Jump_0A0_6A33::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_0A0_6A33
    ld a, $FF
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ei
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_0A0_6A32
    ret

Func_0A0_6A45::
    push bc
    ld a, c
    cp a, $03
    jr nc, Jump_0A0_6AA9
    ld a, c
    call Func_000_3E54
    jr c, Jump_0A0_6A95
    ld a, c
    ld hl, $D80C
    call Func_000_3F25
    ld a, [hl]
    or a, a
    jr z, Jump_0A0_6A7F
    call Func_0A0_6AAB
    bit 0, [hl]
    call nz, Func_0A0_6AC6
    bit 1, [hl]
    call nz, Func_0A0_6AD1
    bit 4, [hl]
    call nz, Func_0A0_6AE7
    bit 5, [hl]
    call nz, Func_0A0_6ABB
    bit 6, [hl]
    call nz, Func_0A0_6AF2
    bit 7, [hl]
    call nz, Func_0A0_6ADC
    jr Jump_0A0_6AA9

Jump_0A0_6A7F::
    call Func_0A0_6BB3
    ld a, c
    and a, $03
    ld hl, $6B1A
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A0_6A8E
    inc h

Jump_0A0_6A8E::
    call Func_0A0_6B06
    ld [hl], $C3
    jr Jump_0A0_6AA9

Jump_0A0_6A95::
    call Func_0A0_6BB3
    ld a, c
    and a, $03
    ld hl, $6B1A
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A0_6AA4
    inc h

Jump_0A0_6AA4::
    call Func_0A0_6B06
    ld [hl], $C2

Jump_0A0_6AA9::
    pop bc
    ret

Func_0A0_6AAB::
    push hl
    ld hl, $6B0A
    call Func_0A0_6AFD
    ld a, $C3
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    pop hl
    ret

Func_0A0_6ABB::
    push hl
    ld hl, $6B0A
    call Func_0A0_6AFD
    ld [hl], $C0
    pop hl
    ret

Func_0A0_6AC6::
    push hl
    ld hl, $6B12
    call Func_0A0_6AFD
    ld [hl], $C1
    pop hl
    ret

Func_0A0_6AD1::
    push hl
    ld hl, $6B12
    call Func_0A0_6AFD
    ld [hl], $C7
    pop hl
    ret

Func_0A0_6ADC::
    push hl
    ld hl, $6B16
    call Func_0A0_6AFD
    ld [hl], $C8
    pop hl
    ret

Func_0A0_6AE7::
    push hl
    ld hl, $6B0E
    call Func_0A0_6AFD
    ld [hl], $C9
    pop hl
    ret

Func_0A0_6AF2::
    push hl
    ld hl, $6B1A
    call Func_0A0_6AFD
    ld [hl], $CA
    pop hl
    ret

Func_0A0_6AFD::
    ld a, c
    and a, $03
    add a, a
    add a, l
    ld l, a
    jr nc, Func_0A0_6B06
    inc h

Func_0A0_6B06::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ret
    db $39, $C2, $46, $C2, $3A, $C2, $47, $C2, $3B, $C2, $48, $C2, $3C, $C2, $49, $C2
    db $3D, $C2, $4A, $C2

Func_0A0_6B1E::
    ld a, c
    cp a, $03
    jr nc, Jump_0A0_6B45
    ld hl, $6D53
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A0_6B2C
    inc h

Jump_0A0_6B2C::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    push hl
    ld de, $C198
    add hl, de
    pop de
    push hl
    ld hl, $9800
    add hl, de
    pop de
    ld b, $05

Jump_0A0_6B3D::
    ld a, [de]
    inc de
    call Func_000_121F
    dec b
    jr nz, Jump_0A0_6B3D

Jump_0A0_6B45::
    ret

Func_0A0_6B46::
    push bc
    ld a, c
    cp a, $03
    jr nc, Jump_0A0_6B77
    ld hl, $D8BF
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A0_6B55
    inc h

Jump_0A0_6B55::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    push bc
    call Func_000_16F5
    pop bc
    ld a, c
    and a, $03
    push hl
    ld hl, $6D47
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A0_6B6A
    inc h

Jump_0A0_6B6A::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, $C198
    add hl, de
    ld d, h
    ld e, l
    pop hl
    call Func_000_2123

Jump_0A0_6B77::
    pop bc
    ret

Func_0A0_6B79::
    push bc
    ld a, c
    cp a, $04
    jr nc, Jump_0A0_6BB1
    and a, $03
    cp a, $03
    jr z, Jump_0A0_6BB1
    ld a, c
    ld hl, $D8DF
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A0_6B8F
    inc h

Jump_0A0_6B8F::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    push bc
    call Func_000_16F5
    pop bc
    ld a, c
    and a, $03
    push hl
    ld hl, $6D4B
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A0_6BA4
    inc h

Jump_0A0_6BA4::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, $C198
    add hl, de
    ld d, h
    ld e, l
    pop hl
    call Func_000_2123

Jump_0A0_6BB1::
    pop bc
    ret

Func_0A0_6BB3::
    push bc
    ld a, c
    cp a, $04
    jr nc, Jump_0A0_6BEE
    and a, $03
    cp a, $03
    jr z, Jump_0A0_6BEE
    ld a, c
    and a, $03
    ld hl, $6D4F
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A0_6BCB
    inc h

Jump_0A0_6BCB::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, $C198
    add hl, de
    ld [hl], $EA
    inc hl
    ld [hl], $AF
    inc hl
    push hl
    ld a, c
    ld hl, $D8B7
    add a, l
    ld l, a
    jr nc, Jump_0A0_6BE2
    inc h

Jump_0A0_6BE2::
    ld l, [hl]
    ld h, $00
    push bc
    call Func_000_16F5
    pop bc
    pop de
    call Func_000_210D

Jump_0A0_6BEE::
    pop bc
    ret

Func_0A0_6BF0::
    ld a, c
    cp a, $04
    jr nc, Jump_0A0_6C21
    and a, $03
    cp a, $03
    jr z, Jump_0A0_6C21
    ld hl, $6D47
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A0_6C04
    inc h

Jump_0A0_6C04::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    push hl
    ld de, $C198
    add hl, de
    pop de
    push hl
    ld hl, $9800
    add hl, de
    pop de
    ld a, [de]
    inc de
    call Func_000_121F
    ld a, [de]
    inc de
    call Func_000_121F
    ld a, [de]
    call Func_000_1211

Jump_0A0_6C21::
    ret

Func_0A0_6C22::
    ld a, c
    cp a, $04
    jr nc, Jump_0A0_6C53
    and a, $03
    cp a, $03
    jr z, Jump_0A0_6C53
    ld hl, $6D4B
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A0_6C36
    inc h

Jump_0A0_6C36::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    push hl
    ld de, $C198
    add hl, de
    pop de
    push hl
    ld hl, $9800
    add hl, de
    pop de
    ld a, [de]
    inc de
    call Func_000_121F
    ld a, [de]
    inc de
    call Func_000_121F
    ld a, [de]
    call Func_000_1211

Jump_0A0_6C53::
    ret

Func_0A0_6C54:: ; heuristic: follows a terminator; C0
    ld a, c
    cp a, $04
    jr nc, Jump_0A0_6C80
    and a, $03
    cp a, $03
    jr z, Jump_0A0_6C80
    ld hl, $6D4F
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A0_6C68
    inc h

Jump_0A0_6C68::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    push hl
    ld de, $C198
    add hl, de
    pop de
    push hl
    ld hl, $9800
    add hl, de
    pop de
    ld a, [de]
    inc de
    call Func_000_121F
    ld a, [de]
    call Func_000_1211

Jump_0A0_6C80::
    ret

Func_0A0_6C81::
    ld a, [$C52D]
    ld c, a
    ld a, [$C52E]
    ld b, a
    push bc
    ld a, [$C52F]
    ld c, a
    ld a, [$C530]
    ld b, a
    push bc
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld a, e
    ld [$C52F], a
    ld a, d
    ld [$C530], a
    ld hl, $400F
    ld b, $09
    rst $10
    pop de
    pop hl
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld a, e
    ld [$C52F], a
    ld a, d
    ld [$C530], a
    ret

Func_0A0_6CBC::
    ld a, [$C52D]
    ld c, a
    ld a, [$C52E]
    ld b, a
    push bc
    ld a, [$C52F]
    ld c, a
    ld a, [$C530]
    ld b, a
    push bc
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld a, e
    ld [$C52F], a
    ld a, d
    ld [$C530], a
    ld hl, $402B
    ld b, $08
    rst $10
    pop de
    pop hl
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld a, e
    ld [$C52F], a
    ld a, d
    ld [$C530], a
    ret
    INCBIN "dwm2-cobi-us.gbc", $282CF7, $60
    dw Data_0A0_6E07
    dw Data_0A0_6E0E
    dw Data_0A0_6E17
    dw Data_0A0_6E20
    dw Data_0A0_6E2B
    dw Data_0A0_6E34
    dw Data_0A0_6E3B
    dw Data_0A0_6E3E
    dw Data_0A0_6E43
    dw Data_0A0_6E4A
    dw Data_0A0_6E55
    dw Data_0A0_6E60
    dw Data_0A0_6E69
    dw Data_0A0_6E76
    dw Data_0A0_6E7F
    dw Data_0A0_6E86
    dw Data_0A0_6E89
    dw Data_0A0_6E96
    dw Data_0A0_6EA3
    dw Data_0A0_6EB0
    dw Data_0A0_6EBD
    dw Data_0A0_6EC6
    dw Data_0A0_6ECB
    dw Data_0A0_6ECE
    dw Data_0A0_6ED1
    dw Data_0A0_6ED6
    dw Data_0A0_6EDF
    dw Data_0A0_6EEC
    dw Data_0A0_6EF9
    dw Data_0A0_6F02
    dw Data_0A0_6F07
    dw Data_0A0_6F0C
    dw Data_0A0_6F0F
    dw Data_0A0_6F18
    dw Data_0A0_6F1F
    dw Data_0A0_6F2A
    dw Data_0A0_6F39
    dw Data_0A0_6F3E
    dw Data_0A0_6F43
    dw Data_0A0_6F46
    dw Data_0A0_6F4D
    dw Data_0A0_6F56
    dw Data_0A0_6F5D
    dw Data_0A0_6F68
    dw Data_0A0_6F77
    dw Data_0A0_6F7C
    dw Data_0A0_6F83
    dw Data_0A0_6F86
    dw Data_0A0_6F89
    dw Data_0A0_6F8E
    dw Data_0A0_6F93
    dw Data_0A0_6F9A
    dw Data_0A0_6FA3
    dw Data_0A0_6FB0
    dw Data_0A0_6FC1
    dw Data_0A0_6FCA
    dw Data_0A0_6FCD
    dw Data_0A0_6FD0
    dw Data_0A0_6FD9
    dw Data_0A0_6FEA
    dw Data_0A0_6FF7
    dw Data_0A0_6FFA
    dw Data_0A0_6FFF
    dw Data_0A0_7008
    dw Data_0A0_700B
    dw Data_0A0_7016
    dw Data_0A0_701F
    dw Data_0A0_7026
    dw Data_0A0_7037
    dw Data_0A0_7044
    dw Data_0A0_704D
    dw Data_0A0_7050
    dw Data_0A0_7053
    dw Data_0A0_705A
    dw Data_0A0_7063
    dw Data_0A0_706E
    dw Data_0A0_707B
    dw Data_0A0_7086
    dw Data_0A0_7091
    dw Data_0A0_7098
    dw Data_0A0_709B
    dw Data_0A0_70A8
    dw Data_0A0_70B5
    dw Data_0A0_70C2
    dw Data_0A0_70CF
    dw Data_0A0_70DC
    dw Data_0A0_70EA
    dw Data_0A0_70F7

Data_0A0_6E07:: ; heuristic: target of a monotone pointer table; C0
    db $03, $02, $00, $05, $00, $0F, $00

Data_0A0_6E0E:: ; heuristic: target of a monotone pointer table; C0
    db $04, $04, $00, $07, $00, $0A, $00, $14, $00

Data_0A0_6E17:: ; heuristic: target of a monotone pointer table; C0
    db $04, $02, $00, $08, $00, $09, $00, $0B, $00

Data_0A0_6E20:: ; heuristic: target of a monotone pointer table; C0
    db $05, $01, $00, $06, $00, $0C, $00, $0D, $00, $0E, $00

Data_0A0_6E2B:: ; heuristic: target of a monotone pointer table; C0
    db $04, $11, $00, $13, $00, $15, $00, $16, $00

Data_0A0_6E34:: ; heuristic: target of a monotone pointer table; C0
    db $03, $10, $00, $12, $00, $17, $00

Data_0A0_6E3B:: ; heuristic: target of a monotone pointer table; C0
    db $01, $18, $00

Data_0A0_6E3E:: ; heuristic: target of a monotone pointer table; C0
    db $02, $19, $00, $1A, $00

Data_0A0_6E43:: ; heuristic: target of a monotone pointer table; C0
    db $03, $28, $00, $31, $00, $32, $00

Data_0A0_6E4A:: ; heuristic: target of a monotone pointer table; C0
    db $05, $2A, $00, $2E, $00, $34, $00, $36, $00, $39, $00

Data_0A0_6E55:: ; heuristic: target of a monotone pointer table; C0
    db $05, $24, $00, $25, $00, $26, $00, $27, $00, $3A, $00

Data_0A0_6E60:: ; heuristic: target of a monotone pointer table; C0
    db $04, $2B, $00, $2C, $00, $30, $00, $35, $00

Data_0A0_6E69:: ; heuristic: target of a monotone pointer table; C0
    db $06, $29, $00, $2D, $00, $2F, $00, $33, $00, $37, $00, $3B, $00

Data_0A0_6E76:: ; heuristic: target of a monotone pointer table; C0
    db $04, $38, $00, $3D, $00, $3E, $00, $3F, $00

Data_0A0_6E7F:: ; heuristic: target of a monotone pointer table; C0
    db $03, $3C, $00, $40, $00, $42, $00

Data_0A0_6E86:: ; heuristic: target of a monotone pointer table; C0
    db $01, $41, $00

Data_0A0_6E89:: ; heuristic: target of a monotone pointer table; C0
    db $06, $48, $00, $49, $00, $4A, $00, $4B, $00, $50, $00, $5B, $00

Data_0A0_6E96:: ; heuristic: target of a monotone pointer table; C0
    db $06, $4D, $00, $4E, $00, $53, $00, $54, $00, $57, $00, $5A, $00

Data_0A0_6EA3:: ; heuristic: target of a monotone pointer table; C0
    db $06, $47, $00, $4F, $00, $51, $00, $52, $00, $58, $00, $59, $00

Data_0A0_6EB0:: ; heuristic: target of a monotone pointer table; C0
    db $06, $55, $00, $56, $00, $5D, $00, $5E, $00, $65, $00, $66, $00

Data_0A0_6EBD:: ; heuristic: target of a monotone pointer table; C0
    db $04, $4C, $00, $5F, $00, $62, $00, $63, $00

Data_0A0_6EC6:: ; heuristic: target of a monotone pointer table; C0
    db $02, $5C, $00, $61, $00

Data_0A0_6ECB:: ; heuristic: target of a monotone pointer table; C0
    db $01, $60, $00

Data_0A0_6ECE:: ; heuristic: target of a monotone pointer table; C0
    db $01, $64, $00

Data_0A0_6ED1:: ; heuristic: target of a monotone pointer table; C0
    db $02, $6A, $00, $73, $00

Data_0A0_6ED6:: ; heuristic: target of a monotone pointer table; C0
    db $04, $6D, $00, $70, $00, $74, $00, $75, $00

Data_0A0_6EDF:: ; heuristic: target of a monotone pointer table; C0
    db $06, $6C, $00, $71, $00, $72, $00, $76, $00, $77, $00, $84, $00

Data_0A0_6EEC:: ; heuristic: target of a monotone pointer table; C0
    db $06, $6B, $00, $6E, $00, $6F, $00, $78, $00, $79, $00, $7A, $00

Data_0A0_6EF9:: ; heuristic: target of a monotone pointer table; C0
    db $04, $7B, $00, $7C, $00, $7D, $00, $80, $00

Data_0A0_6F02:: ; heuristic: target of a monotone pointer table; C0
    db $02, $7E, $00, $7F, $00

Data_0A0_6F07:: ; heuristic: target of a monotone pointer table; C0
    db $02, $81, $00, $83, $00

Data_0A0_6F0C:: ; heuristic: target of a monotone pointer table; C0
    db $01, $82, $00

Data_0A0_6F0F:: ; heuristic: target of a monotone pointer table; C0
    db $04, $91, $00, $93, $00, $95, $00, $A6, $00

Data_0A0_6F18:: ; heuristic: target of a monotone pointer table; C0
    db $03, $8D, $00, $90, $00, $97, $00

Data_0A0_6F1F:: ; heuristic: target of a monotone pointer table; C0
    db $05, $8E, $00, $8F, $00, $92, $00, $96, $00, $98, $00

Data_0A0_6F2A:: ; heuristic: target of a monotone pointer table; C0
    db $07, $94, $00, $99, $00, $9A, $00, $9D, $00, $9E, $00, $9F, $00, $A7, $00

Data_0A0_6F39:: ; heuristic: target of a monotone pointer table; C0
    db $02, $A0, $00, $A1, $00

Data_0A0_6F3E:: ; heuristic: target of a monotone pointer table; C0
    db $02, $9B, $00, $9C, $00

Data_0A0_6F43:: ; heuristic: target of a monotone pointer table; C0
    db $01, $A2, $00

Data_0A0_6F46:: ; heuristic: target of a monotone pointer table; C0
    db $03, $A3, $00, $A4, $00, $A5, $00

Data_0A0_6F4D:: ; heuristic: target of a monotone pointer table; C0
    db $04, $B0, $00, $B5, $00, $B9, $00, $BB, $00

Data_0A0_6F56:: ; heuristic: target of a monotone pointer table; C0
    db $03, $B2, $00, $B3, $00, $BA, $00

Data_0A0_6F5D:: ; heuristic: target of a monotone pointer table; C0
    db $05, $B6, $00, $B7, $00, $B8, $00, $BD, $00, $C2, $00

Data_0A0_6F68:: ; heuristic: target of a monotone pointer table; C0
    db $07, $B1, $00, $B4, $00, $BC, $00, $BE, $00, $BF, $00, $C1, $00, $C9, $00

Data_0A0_6F77:: ; heuristic: target of a monotone pointer table; C0
    db $02, $C0, $00, $C5, $00

Data_0A0_6F7C:: ; heuristic: target of a monotone pointer table; C0
    db $03, $C3, $00, $C4, $00, $C7, $00

Data_0A0_6F83:: ; heuristic: target of a monotone pointer table; C0
    db $01, $C6, $00

Data_0A0_6F86:: ; heuristic: target of a monotone pointer table; C0
    db $01, $C8, $00

Data_0A0_6F89:: ; heuristic: target of a monotone pointer table; C0
    db $02, $D3, $00, $D6, $00

Data_0A0_6F8E:: ; heuristic: target of a monotone pointer table; C0
    db $02, $DC, $00, $DD, $00

Data_0A0_6F93:: ; heuristic: target of a monotone pointer table; C0
    db $03, $D4, $00, $D8, $00, $E1, $00

Data_0A0_6F9A:: ; heuristic: target of a monotone pointer table; C0
    db $04, $D7, $00, $D9, $00, $EA, $00, $EC, $00

Data_0A0_6FA3:: ; heuristic: target of a monotone pointer table; C0
    db $06, $D5, $00, $DA, $00, $DB, $00, $DF, $00, $E2, $00, $E8, $00

Data_0A0_6FB0:: ; heuristic: target of a monotone pointer table; C0
    db $08, $DE, $00, $E0, $00, $E3, $00, $E4, $00, $E5, $00, $E6, $00, $E9, $00, $EB
    db $00

Data_0A0_6FC1:: ; heuristic: target of a monotone pointer table; C0
    db $04, $E7, $00, $ED, $00, $EE, $00, $F0, $00

Data_0A0_6FCA:: ; heuristic: target of a monotone pointer table; C0
    db $01, $EF, $00

Data_0A0_6FCD:: ; heuristic: target of a monotone pointer table; C0
    db $01, $F6, $00

Data_0A0_6FD0:: ; heuristic: target of a monotone pointer table; C0
    db $04, $F9, $00, $00, $01, $04, $01, $05, $01

Data_0A0_6FD9:: ; heuristic: target of a monotone pointer table; C0
    db $08, $F8, $00, $FA, $00, $FD, $00, $FE, $00, $FF, $00, $01, $01, $02, $01, $0F
    db $01

Data_0A0_6FEA:: ; heuristic: target of a monotone pointer table; C0
    db $06, $FB, $00, $FC, $00, $03, $01, $06, $01, $09, $01, $0E, $01

Data_0A0_6FF7:: ; heuristic: target of a monotone pointer table; C0
    db $01, $0A, $01

Data_0A0_6FFA:: ; heuristic: target of a monotone pointer table; C0
    db $02, $F7, $00, $0B, $01

Data_0A0_6FFF:: ; heuristic: target of a monotone pointer table; C0
    db $04, $07, $01, $08, $01, $0D, $01, $10, $01

Data_0A0_7008:: ; heuristic: target of a monotone pointer table; C0
    db $01, $0C, $01

Data_0A0_700B:: ; heuristic: target of a monotone pointer table; C0
    db $05, $1B, $01, $1D, $01, $1E, $01, $22, $01, $31, $01

Data_0A0_7016:: ; heuristic: target of a monotone pointer table; C0
    db $04, $19, $01, $1C, $01, $28, $01, $37, $01

Data_0A0_701F:: ; heuristic: target of a monotone pointer table; C0
    db $03, $1A, $01, $21, $01, $27, $01

Data_0A0_7026:: ; heuristic: target of a monotone pointer table; C0
    db $08, $1F, $01, $20, $01, $23, $01, $26, $01, $2B, $01, $2C, $01, $30, $01, $38
    db $01

Data_0A0_7037:: ; heuristic: target of a monotone pointer table; C0
    db $06, $24, $01, $29, $01, $2F, $01, $32, $01, $33, $01, $34, $01

Data_0A0_7044:: ; heuristic: target of a monotone pointer table; C0
    db $04, $25, $01, $2A, $01, $2D, $01, $2E, $01

Data_0A0_704D:: ; heuristic: target of a monotone pointer table; C0
    db $01, $35, $01

Data_0A0_7050:: ; heuristic: target of a monotone pointer table; C0
    db $01, $36, $01

Data_0A0_7053:: ; heuristic: target of a monotone pointer table; C0
    db $03, $3C, $01, $3D, $01, $44, $01

Data_0A0_705A:: ; heuristic: target of a monotone pointer table; C0
    db $04, $43, $01, $49, $01, $4D, $01, $5B, $01

Data_0A0_7063:: ; heuristic: target of a monotone pointer table; C0
    db $05, $40, $01, $41, $01, $45, $01, $4C, $01, $5A, $01

Data_0A0_706E:: ; heuristic: target of a monotone pointer table; C0
    db $06, $3E, $01, $3F, $01, $42, $01, $46, $01, $47, $01, $4A, $01

Data_0A0_707B:: ; heuristic: target of a monotone pointer table; C0
    db $05, $48, $01, $4B, $01, $4E, $01, $4F, $01, $50, $01

Data_0A0_7086:: ; heuristic: target of a monotone pointer table; C0
    db $05, $51, $01, $52, $01, $54, $01, $55, $01, $57, $01

Data_0A0_7091:: ; heuristic: target of a monotone pointer table; C0
    db $03, $53, $01, $56, $01, $58, $01

Data_0A0_7098:: ; heuristic: target of a monotone pointer table; C0
    db $01, $59, $01

Data_0A0_709B:: ; heuristic: target of a monotone pointer table; C0
    db $06, $5F, $01, $62, $01, $65, $01, $6A, $01, $6B, $01, $6D, $01

Data_0A0_70A8:: ; heuristic: target of a monotone pointer table; C0
    db $06, $5F, $01, $62, $01, $65, $01, $6A, $01, $6B, $01, $6D, $01

Data_0A0_70B5:: ; heuristic: target of a monotone pointer table; C0
    db $06, $5F, $01, $62, $01, $65, $01, $6A, $01, $6B, $01, $6D, $01

Data_0A0_70C2:: ; heuristic: target of a monotone pointer table; C0
    db $06, $5F, $01, $62, $01, $65, $01, $6A, $01, $6B, $01, $6D, $01

Data_0A0_70CF:: ; heuristic: target of a monotone pointer table; C0
    db $06, $5F, $01, $62, $01, $65, $01, $6A, $01, $6B, $01, $6D, $01

Data_0A0_70DC:: ; heuristic: target of a monotone pointer table; C0
    db $06, $5F, $01, $62, $01, $65, $01, $6A, $01, $6B, $01, $6D, $01, $06

Data_0A0_70EA:: ; heuristic: target of a monotone pointer table; C0
    db $06, $5F, $01, $62, $01, $65, $01, $6A, $01, $6B, $01, $6D, $01

Data_0A0_70F7:: ; heuristic: target of a monotone pointer table; C0
    db $10, $60, $01, $61, $01, $63, $01, $64, $01, $66, $01, $67, $01, $68, $01, $69
    db $01, $6C, $01, $6E, $01, $6F, $01, $70, $01, $71, $01, $72, $01, $73, $01, $74
    db $01
    ds $EE8, $00
