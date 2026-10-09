SECTION "Bank 19", ROMX[$4000], BANK[$19]
    db $19

Func_019_4001::
    ld a, [$CFC5]
    push af
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
    pop af
    ld [$CFC5], a
    call Func_019_4079
    ld a, [$C58A]
    or a, a
    jr nz, Jump_019_4069
    ld hl, $D09D
    ld bc, $0200
    xor a, a
    call Func_000_0949
    ld a, $0A
    ld [$0100], a
    ld a, $00
    ld [$4100], a
    call Func_019_4557
    call Func_019_46DD
    ld a, [$D20C]
    ld [$D8A1], a
    ld a, [$D25A]
    ld [$D8A2], a
    ld a, [$D2A8]
    ld [$D8A3], a
    ld a, $00
    ld [$0100], a
    jr Jump_019_4069

Jump_019_4069::
    call Func_019_4224
    call Func_019_419B
    call Func_019_41CB
    call Func_019_4544
    call Func_019_4E1C
    ret

Func_019_4079::
    ld a, [$CFC5]
    cp a, $04
    jr z, Jump_019_408B
    cp a, $05
    jr z, Jump_019_408B
    cp a, $09
    jr z, Jump_019_408B
    xor a, a
    jr Jump_019_408D

Jump_019_408B::
    ld a, $01

Jump_019_408D::
    ld [$DAD7], a
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
    ld bc, $0008
    ld a, $FF
    call Func_000_0949
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
    ld bc, $0080
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
    ld a, [$C58A]
    or a, a
    jr nz, Jump_019_4140
    ld a, [$C6FD]
    ld [$D88F], a
    ld [$C984], a
    ld a, [$CFDC]
    inc a
    ld [$D890], a
    ld [$C985], a
    ld a, [$C835]
    ld [$CFDB], a
    ld a, [$C834]
    ld [$C964], a
    jr Jump_019_417E

Jump_019_4140::
    ld a, $03
    ld [$C964], a
    ld a, [$C57F]
    bit 1, a
    jr nz, Jump_019_4166
    ld hl, $D0EC
    call Func_019_4186
    ld [$D88F], a
    ld [$C984], a
    ld hl, $D1D6
    call Func_019_4186
    ld [$D890], a
    ld [$C985], a
    jr Jump_019_417E

Jump_019_4166::
    ld hl, $D0EC
    call Func_019_4186
    ld [$D890], a
    ld [$C984], a
    ld hl, $D1D6
    call Func_019_4186
    ld [$D88F], a
    ld [$C985], a

Jump_019_417E::
    xor a, a
    ld [$D057], a
    ld [$D058], a
    ret

Func_019_4186::
    ld de, $004E
    ld c, $01
    add hl, de
    ld a, [hl]
    or a, a
    jr z, Jump_019_4199
    ld c, $02
    add hl, de
    ld a, [hl]
    or a, a
    jr z, Jump_019_4199
    ld c, $03

Jump_019_4199::
    ld a, c
    ret

Func_019_419B::
    ld hl, Func_031_7239
    ld b, $31
    rst $10
    ld hl, Func_031_71F5
    ld b, $31
    rst $10
    ld hl, Func_031_72AC
    ld b, $31
    rst $10
    ld hl, Func_031_72CC
    ld b, $31
    rst $10
    ld hl, Func_031_7389
    ld b, $31
    rst $10
    ld hl, Func_031_7321
    ld b, $31
    rst $10
    ld hl, $9800
    call Func_019_4516
    ld a, $7F
    ld [$C526], a
    ret

Func_019_41CB::
    ld de, $D1C9
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_019_41D8
    ld de, $D0DF

Jump_019_41D8::
    ld hl, $9140
    ld c, $01
    call Func_019_4219
    ld a, [$D890]
    cp a, $01
    jr z, Jump_019_4218
    ld de, $D217
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_019_41F4
    ld de, $D12D

Jump_019_41F4::
    ld hl, $9380
    ld c, $03
    call Func_019_4219
    ld a, [$D890]
    cp a, $02
    jr z, Jump_019_4218
    ld de, $D265
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_019_4210
    ld de, $D17B

Jump_019_4210::
    ld hl, $95C0
    ld c, $05
    call Func_019_4219

Jump_019_4218::
    ret

Func_019_4219::
    ld a, [de]
    push af
    inc de
    ld a, [de]
    ld d, a
    pop af
    ld e, a
    call Func_000_1FE3
    ret

Func_019_4224::
    ld a, [$D88F]
    ld b, a
    ld c, $00
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_019_4235
    ld a, [$D890]
    ld b, a

Jump_019_4235::
    call Func_019_4B91
    inc c
    dec b
    jr nz, Jump_019_4235
    ld a, [$D890]
    ld b, a
    ld c, $04
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_019_424D
    ld a, [$D88F]
    ld b, a

Jump_019_424D::
    call Func_019_4B91
    inc c
    dec b
    jr nz, Jump_019_424D
    call Func_019_43ED
    ld de, $D8A7
    ld bc, $0800

Jump_019_425D::
    push bc
    ld a, c
    ld hl, $DA63
    add a, l
    ld l, a
    jr nc, Jump_019_4267
    inc h

Jump_019_4267::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_019_4291
    ld a, c
    add a, a
    ld hl, $D958
    add a, l
    ld l, a
    jr nc, Jump_019_4276
    inc h

Jump_019_4276::
    ld a, [hl+]
    ld [$D006], a
    ld a, [hl]
    ld [$D007], a
    push de
    ld hl, Func_035_4001
    ld b, $35
    rst $10
    pop de
    ld a, [$D00B]
    ld h, a
    ld a, [$D00A]
    swap a
    or a, h
    ld [de], a

Jump_019_4291::
    pop bc
    inc de
    inc c
    dec b
    jr nz, Jump_019_425D
    ret

Func_019_4298::
    push bc
    ld a, c
    ld hl, $DA53
    add a, l
    ld l, a
    jr nc, Jump_019_42A2
    inc h

Jump_019_42A2::
    push hl
    ld a, c
    ld hl, $D92F
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_019_42AD
    inc h

Jump_019_42AD::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, l
    sub a, $1E
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    jr c, Jump_019_42E8
    ld a, l
    sub a, $46
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    jr c, Jump_019_42E4
    ld a, l
    sub a, $C2
    ld l, a
    ld a, h
    sbc a, $01
    ld h, a
    jr c, Jump_019_42E0
    ld a, l
    sub a, $5E
    ld l, a
    ld a, h
    sbc a, $01
    ld h, a
    jr c, Jump_019_42DC
    ld a, $04
    jr Jump_019_42EA

Jump_019_42DC::
    ld a, $03
    jr Jump_019_42EA

Jump_019_42E0::
    ld a, $02
    jr Jump_019_42EA

Jump_019_42E4::
    ld a, $01
    jr Jump_019_42EA

Jump_019_42E8::
    ld a, $00

Jump_019_42EA::
    pop hl
    ld [hl], a
    pop bc
    ret

Func_019_42EE::
    push bc
    push hl
    ld hl, $D008
    ld bc, $002F
    xor a, a
    call Func_000_0949
    pop hl
    pop bc
    ret

Func_019_42FD::
    ld a, [$CFC5]
    cp a, $02
    ret z
    cp a, $03
    ret z
    cp a, $05
    ret z
    ld a, [$C58A]
    or a, a
    ret nz
    push bc
    push hl
    ld a, [hl+]
    ld h, [hl]
    ld b, h
    ld l, a
    ld c, a
    call Func_019_4537
    ld a, c
    sub a, l
    ld c, a
    ld a, b
    sbc a, h
    ld b, a
    push hl
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
    ld l, a
    ld a, [$C5E8]
    ld h, a

Jump_019_4332::
    call Func_000_3E7A
    jr c, Jump_019_433F
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    jr Jump_019_4332

Jump_019_433F::
    pop bc
    add hl, bc
    pop bc
    ld a, l
    ld [bc], a
    inc bc
    ld a, h
    ld [bc], a
    pop bc
    ret

Func_019_4349::
    ld a, [$D868]
    ld c, a

Func_019_434D::
    ld hl, $D988
    ld a, c
    swap a
    add a, l
    ld l, a
    jr nc, Jump_019_4358
    inc h

Jump_019_4358::
    ld b, $08

Jump_019_435A::
    ld a, $00
    ld [hl+], a
    ld a, $FF
    ld [hl+], a
    dec b
    jr nz, Jump_019_435A
    push bc
    ld a, c
    cp a, $04
    jr c, Jump_019_436B
    dec a
    ld c, a

Jump_019_436B::
    ld a, $4E
    call Func_000_1682
    pop bc
    ld a, l
    add a, $E3
    ld l, a
    ld a, h
    adc a, $D0
    ld h, a
    ld de, $D989
    ld a, c
    swap a
    add a, e
    ld e, a
    jr nc, Jump_019_4384
    inc d

Jump_019_4384::
    ld b, $08

Jump_019_4386::
    ld a, [hl+]
    ld [de], a
    inc de
    inc de
    ld a, [hl]
    or a, a
    jr z, Jump_019_4395
    cp a, $FF
    jr z, Jump_019_4395
    dec b
    jr nz, Jump_019_4386

Jump_019_4395::
    ld a, c
    ld de, $D989
    swap a
    add a, e
    ld e, a
    jr nc, Jump_019_43A0
    inc d

Jump_019_43A0::
    ld b, $08
    ld a, [$D868]
    push af
    xor a, a
    ld [$CFED], a

Jump_019_43AA::
    ld a, [de]
    cp a, $FF
    jr z, Jump_019_43E4
    push bc
    ld a, [de]
    ld [$CFEC], a
    ld a, $03
    ld [$D868], a
    ld a, $01
    ld [$D869], a
    dec de
    push de
    ld a, e
    ld [$D86A], a
    ld a, d
    ld [$D86B], a
    ld hl, Func_01A_4022
    ld b, $1A
    rst $10
    ld a, [$D86A]
    ld e, a
    ld a, [$D86B]
    ld d, a
    ld a, [de]
    swap a
    and a, $0F
    ld [de], a
    pop de
    inc de
    inc de
    inc de
    pop bc
    dec b
    jr nz, Jump_019_43AA

Jump_019_43E4::
    pop af
    ld [$D868], a
    or a, a
    call nz, Func_019_43ED
    ret

Func_019_43ED::
    ld bc, $0800
    ld hl, $D8AF

Jump_019_43F3::
    ld a, c
    call Func_000_3E54
    jr c, Jump_019_43FE
    ld a, [hl]
    or a, a
    call z, Func_019_4440

Jump_019_43FE::
    inc c
    inc hl
    dec b
    jr nz, Jump_019_43F3
    ld a, [$C58A]
    or a, a
    ret nz
    ld bc, $0304
    ld hl, $D9C9

Jump_019_440E::
    ld a, c
    call Func_000_3E54
    jr c, Jump_019_4430
    ld d, $04

Jump_019_4416::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_019_4430
    cp a, $34
    jr nz, Jump_019_4424
    call Func_019_4462
    jr Jump_019_442B

Jump_019_4424::
    cp a, $35
    jr nz, Jump_019_442B
    call Func_019_4465

Jump_019_442B::
    inc hl
    inc hl
    dec d
    jr nz, Jump_019_4416

Jump_019_4430::
    inc c
    ld a, c
    swap a
    ld hl, $D989
    add a, l
    ld l, a
    jr nc, Jump_019_443C
    inc h

Jump_019_443C::
    dec b
    jr nz, Jump_019_440E
    ret

Func_019_4440::
    push hl
    ld a, c
    ld hl, $D989
    swap a
    add a, l
    ld l, a
    jr nc, Jump_019_444C
    inc h

Jump_019_444C::
    ld d, $08

Jump_019_444E::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_019_4459
    cp a, $8F
    jr nz, Jump_019_445B
    ld [hl], $AA

Jump_019_4459::
    pop hl
    ret

Jump_019_445B::
    inc hl
    inc hl
    dec d
    jr nz, Jump_019_444E
    pop hl
    ret

Func_019_4462::
    ld [hl], $AD
    ret

Func_019_4465::
    ld [hl], $AE
    ret

Func_019_4468::
    push hl
    ld a, c
    ld de, $DA63
    add a, e
    ld e, a
    jr nc, Jump_019_4472
    inc d

Jump_019_4472::
    bit 7, [hl]
    jr z, Jump_019_447B
    ld a, $01
    ld [de], a
    jr Jump_019_44A1

Jump_019_447B::
    ld a, $00
    ld [de], a
    ld a, [$CFC5]
    cp a, $04
    jr z, Jump_019_44A1
    ld a, c
    ld de, $D80C
    add a, a
    add a, a
    add a, a
    add a, c
    add a, e
    ld e, a
    jr nc, Jump_019_4492
    inc d

Jump_019_4492::
    bit 0, [hl]
    jr z, Jump_019_4499
    ld a, $20
    ld [de], a

Jump_019_4499::
    bit 2, [hl]
    jr z, Jump_019_44A1
    ld a, [de]
    or a, $01
    ld [de], a

Jump_019_44A1::
    pop hl
    ret

Func_019_44A3::
    ld a, c
    add a, e
    ld e, a
    jr nc, Jump_019_44A9
    inc d

Jump_019_44A9::
    ld a, [hl+]
    ld [de], a
    ret

Func_019_44AC::
    ld a, c
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_019_44B3
    inc d

Jump_019_44B3::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    ret

Func_019_44B9::
    ld a, [$D868]
    ld l, a
    ld a, [$D869]
    ld h, a
    ld a, [$D86A]
    ld e, a
    ld a, [$D86B]
    ld d, a

Func_019_44C9::
    push hl
    ld a, $1A
    add a, l
    ld l, a
    jr nc, Jump_019_44D1
    inc h

Jump_019_44D1::
    ld a, [hl]
    and a, $03
    rrc a
    rrc a
    ld c, a
    pop hl
    ld a, [hl+]
    sla a
    sla a
    or a, [hl]
    inc hl
    sla a
    sla a
    or a, [hl]
    inc hl
    or a, c
    ld [de], a
    inc de
    ld b, $05

Jump_019_44EC::
    ld a, [hl+]
    sla a
    sla a
    or a, [hl]
    inc hl
    sla a
    sla a
    or a, [hl]
    inc hl
    sla a
    sla a
    or a, [hl]
    inc hl
    ld [de], a
    inc de
    dec b
    jr nz, Jump_019_44EC
    ld a, [hl+]
    sla a
    sla a
    or a, [hl]
    inc hl
    sla a
    sla a
    or a, [hl]
    sla a
    sla a
    ld [de], a
    ret

Func_019_4516::
    ld de, $C198
    ld bc, $1412

Jump_019_451C::
    push bc
    push hl

Jump_019_451E::
    ld a, [de]
    inc de
    call Func_000_121F
    dec b
    jr nz, Jump_019_451E
    ld a, $0C
    add a, e
    ld e, a
    jr nc, Jump_019_452D
    inc d

Jump_019_452D::
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_019_451C
    ret

Func_019_4537::
    push bc
    push de
    add hl, hl
    add hl, hl
    add hl, hl
    ld a, $0A
    call Func_000_16D1
    pop de
    pop bc
    ret

Func_019_4544::
    ld a, [$CFC5]
    or a, a
    jr z, Jump_019_454D
    dec a
    jr nz, Jump_019_4551

Jump_019_454D::
    ld a, $0F
    jr Jump_019_4553

Jump_019_4551::
    ld a, $13

Jump_019_4553::
    call Func_000_122D
    ret

Func_019_4557::
    ld a, [$D88F]
    ld b, a
    ld c, $00
    ld de, $D0D5

Jump_019_4560::
    push bc
    call Func_019_456A
    pop bc
    inc c
    dec b
    jr nz, Jump_019_4560
    ret

Func_019_456A::
    ld a, c
    ld c, $01
    call Func_000_1F49
    ld b, $0A

Jump_019_4572::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_019_4572
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, l
    add a, $25
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld b, $08

Jump_019_45A6::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_019_45A6
    ld a, l
    add a, $19
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld b, $15

Jump_019_45CC::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_019_45CC
    ld a, l
    add a, $02
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld b, $04

Jump_019_45DC::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_019_45DC
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld b, $1B

Jump_019_45EC::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_019_45EC
    ld a, l
    add a, $16
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl]
    ld [de], a
    call Func_019_4605
    inc de
    ld a, $FF
    ld [de], a
    inc de
    ret

Func_019_4605::
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
    ld de, Data_019_4641
    add a, e
    ld e, a
    jr nc, Jump_019_4622
    inc d

Jump_019_4622::
    ld a, [de]
    cp a, $80
    jr nz, Jump_019_4629
    pop de
    ret

Jump_019_4629::
    ld l, a
    ld h, $FF
    call Func_019_4632
    inc de
    jr Jump_019_4622

Func_019_4632::
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

Data_019_4641:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $064641, $70

Func_019_46B1::
    ld de, $D20D
    ld a, [$DAAB]
    and a, $03
    ld c, a
    cp a, $01
    jr z, Jump_019_46C1
    ld de, $D1BF

Jump_019_46C1::
    push de
    ld a, e
    add a, $0D
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    ld a, [de]
    pop de
    push af
    push de
    call Func_019_470F
    pop de
    ld a, e
    add a, $0D
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop af
    ld [de], a
    ret

Func_019_46DD::
    ld a, [$D890]
    ld b, a
    ld c, $00
    ld de, $D1BF
    ld a, [$CFC5]
    cp a, $05
    jr z, Jump_019_46F3
    and a, $01
    jr z, Jump_019_46F3
    jr Jump_019_46FD

Jump_019_46F3::
    push bc
    call Func_019_470F
    pop bc
    inc c
    dec b
    jr nz, Jump_019_46F3
    ret

Jump_019_46FD::
    push bc
    call Func_019_4752
    pop bc
    inc c
    ld a, e
    add a, $4E
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    dec b
    jr nz, Jump_019_46FD
    ret

Func_019_470F::
    push bc
    ld a, c
    ld hl, $CFDD
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_019_471A
    inc h

Jump_019_471A::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, l
    ld [$CFE6], a
    ld a, h
    ld [$CFE7], a
    push de
    ld hl, Func_034_4001
    ld b, $34
    rst $10
    pop de
    pop bc
    push de
    call Func_019_4A9A
    pop de
    ld a, [$CFEC]
    ld l, a
    ld a, [$CFED]
    ld h, a
    ld a, l
    ld [$D006], a
    ld a, h
    ld [$D007], a
    push bc
    push de
    ld hl, Func_035_4001
    ld b, $35
    rst $10
    pop de
    pop bc
    call Func_019_4B37
    pop bc
    ret

Func_019_4752::
    push bc
    ld a, e
    ld [$D86A], a
    ld a, d
    ld [$D86B], a
    ld a, c
    ld [$D869], a
    ld hl, $CFE3
    add a, l
    ld l, a
    jr nc, Jump_019_4767
    inc h

Jump_019_4767::
    ld a, [hl]
    ldh [$FFC7], a
    or a, a
    jr nz, Jump_019_4771
    ld a, $01
    ldh [$FFC7], a

Jump_019_4771::
    ld a, c
    add a, a
    ld hl, $CFDD
    add a, l
    ld l, a
    jr nc, Jump_019_477B
    inc h

Jump_019_477B::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, l
    ld [$D006], a
    ld a, h
    ld [$D007], a
    ld hl, Func_035_4001
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
    ld a, [$D035]
    ld [hl+], a
    ld a, [$D036]
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    push hl
    ld a, [$D014]
    ldh [$FFC6], a
    ld hl, Func_01A_63A7
    ld b, $1A
    rst $10
    pop hl
    ld a, $01
    ld [$D868], a
    call Func_019_48B1
    call Func_019_495C
    ld a, [$D015]
    ldh [$FFC6], a
    push hl
    ld hl, Func_01A_63A7
    ld b, $1A
    rst $10
    pop hl
    ld a, $00
    ld [$D868], a
    call Func_019_48B1
    call Func_019_495C
    ld a, $02
    ld [$D868], a
    ld a, [$D016]
    ldh [$FFC6], a
    push hl
    ld hl, Func_01A_63A7
    ld b, $1A
    rst $10
    pop hl
    call Func_019_48B1
    ld a, $03
    ld [$D868], a
    ld a, [$D017]
    ldh [$FFC6], a
    push hl
    ld hl, Func_01A_63A7
    ld b, $1A
    rst $10
    pop hl
    call Func_019_48B1
    ld a, $00
    ld [$D868], a
    ld a, [$D018]
    ldh [$FFC6], a
    push hl
    ld hl, Func_01A_63A7
    ld b, $1A
    rst $10
    pop hl
    call Func_019_48B1
    ld a, [$D019]
    ldh [$FFC6], a
    push hl
    ld hl, Func_01A_63A7
    ld b, $1A
    rst $10
    pop hl
    call Func_019_48B1
    ld a, $E7
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    call Func_019_489D
    call Func_019_488D
    call Func_019_488D
    call Func_019_488D
    call Func_019_4963
    ld a, $00
    ld [hl+], a
    push hl
    ld a, [$D006]
    ld l, a
    ld a, [$D007]
    ld h, a
    ld a, l
    add a, $1C
    ld l, a
    ld a, h
    adc a, $74
    ld h, a
    ld a, [hl]
    pop hl
    ld [hl+], a
    call Func_019_496F
    call Func_019_49B1
    ld hl, Func_01A_5FA7
    ld b, $1A
    rst $10
    ld a, [$D86A]
    ld e, a
    ld a, [$D86B]
    ld d, a
    pop bc
    ret

Func_019_488D::
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

Func_019_489D::
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
    and a, $7F
    add a, $80
    ld [hl+], a
    ret

Func_019_48B1::
    push af
    push bc
    push de
    push hl
    ldh a, [$FFC8]
    ld c, a
    ldh a, [$FFC9]
    ld b, a
    ld a, $01
    add a, $64
    call Func_000_16AA
    ld a, $64
    call Func_000_16E2
    ld a, [$CFC5]
    cp a, $03
    jr nz, Jump_019_48EB
    ld a, [$D868]
    cp a, $01
    jr nz, Jump_019_48EB
    ld a, [$C96C]
    cp a, $01
    ld a, $05
    jr z, Jump_019_493C
    ld a, [$D869]
    cp a, $01
    ld a, $02
    jr nz, Jump_019_493C
    ld a, $05
    jr Jump_019_493C

Jump_019_48EB::
    ld a, [$D868]
    cp a, $02
    jr z, Jump_019_48FB
    cp a, $03
    jr z, Jump_019_490C
    ld bc, $03E7
    jr Jump_019_491F

Jump_019_48FB::
    ld a, [$CFC5]
    cp a, $03
    jr z, Jump_019_4907
    ld bc, $0258
    jr Jump_019_491F

Jump_019_4907::
    ld bc, $02BC
    jr Jump_019_491F

Jump_019_490C::
    ld bc, $02BC
    ld a, [$CFC5]
    cp a, $03
    jr nz, Jump_019_491F
    ld a, [$D00B]
    or a, a
    jr z, Jump_019_491F
    ld bc, $03E7

Jump_019_491F::
    ld a, e
    or a, a
    jr nz, Jump_019_4948
    push bc
    ld a, c
    sub a, l
    ld c, a
    ld a, b
    sbc a, h
    ld b, a
    bit 7, b
    jr nz, Jump_019_4948
    pop bc
    jr Jump_019_494B

Func_019_4931:: ; heuristic: follows a terminator; C0
    ld a, [$D869]
    cp a, $01
    ld a, $06
    jr nz, Jump_019_493C
    ld a, $0C

Jump_019_493C::
    call Func_019_4A74
    ld a, d
    or a, e
    jr z, Jump_019_494B
    ld hl, $2710
    jr Jump_019_494B

Jump_019_4948::
    pop bc
    ld l, c
    ld h, b

Jump_019_494B::
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

Func_019_495C::
    ldh a, [$FFC8]
    ld [hl+], a
    ldh a, [$FFC9]
    ld [hl+], a
    ret

Func_019_4963::
    ld de, $D01A
    ld b, $1B

Jump_019_4968::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_019_4968
    ret

Func_019_496F::
    ld a, [$D86A]
    add a, $0D
    ld l, a
    ld a, [$D86B]
    adc a, $00
    ld h, a
    ld a, [hl]
    or a, a
    jr z, Jump_019_49A7
    cp a, $01
    jr z, Jump_019_498B
    cp a, $02
    jr z, Jump_019_498F
    ld b, $E6
    jr Jump_019_4991

Jump_019_498B::
    ld b, $02
    jr Jump_019_4991

Jump_019_498F::
    ld b, $80

Jump_019_4991::
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
    jr c, Jump_019_49A5
    xor a, a
    jr Jump_019_49A7

Jump_019_49A5::
    ld a, $01

Jump_019_49A7::
    ld [hl], a
    ld a, [$D068]
    or a, a
    ret z
    res 4, a
    ld [hl], a
    ret

Func_019_49B1::
    ld a, [$D86A]
    add a, $18
    ld l, a
    ld a, [$D86B]
    adc a, $00
    ld h, a
    push de
    push hl
    xor a, a
    ldh [$FFCA], a
    ldh [$FFCB], a
    ldh [$FFCC], a
    ldh [$FFCF], a
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, l
    ldh [$FFCD], a
    ld a, h
    ldh [$FFCE], a
    ldh a, [$FFC7]
    ld b, a
    ld c, $01

Jump_019_49D6::
    push bc
    ldh a, [$FFCD]
    ld l, a
    ldh a, [$FFCE]
    ld h, a
    ld e, $00
    ld a, c
    call Func_019_4A74
    ld a, [$CFC5]
    cp a, $03
    jr z, Jump_019_49F5
    ld a, $14
    call Func_000_16E2
    ld c, a
    ldh a, [$FFCF]
    add a, c
    ldh [$FFCF], a

Jump_019_49F5::
    ldh a, [$FFCA]
    add a, l
    ldh [$FFCA], a
    ldh a, [$FFCB]
    adc a, h
    ldh [$FFCB], a
    ldh a, [$FFCC]
    adc a, e
    ldh [$FFCC], a
    pop bc
    inc c
    dec b
    jr nz, Jump_019_49D6
    ldh a, [$FFCF]
    ld b, a
    ld a, $14
    call Func_000_16BF
    ldh a, [$FFCA]
    add a, b
    ldh [$FFCA], a
    ldh a, [$FFCB]
    adc a, $00
    ldh [$FFCB], a
    ldh a, [$FFCC]
    adc a, $00
    ldh [$FFCC], a
    push bc
    push de
    ldh a, [$FFCC]
    ld e, a
    ldh a, [$FFCB]
    ld h, a
    ldh a, [$FFCA]
    ld l, a
    ld a, $03
    call Func_000_16E2
    ld a, [$CFC5]
    cp a, $03
    jr nz, Jump_019_4A45
    sra e
    rr h
    rr l
    sra e
    rr h
    rr l

Jump_019_4A45::
    ld a, e
    or a, h
    or a, l
    jr nz, Jump_019_4A4D
    ld hl, $0001

Jump_019_4A4D::
    ld a, e
    ldh [$FFCC], a
    ld a, h
    ldh [$FFCB], a
    ld a, l
    ldh [$FFCA], a
    pop de
    pop bc
    ldh a, [$FFCC]
    ld e, a
    ldh a, [$FFCB]
    ld h, a
    ldh a, [$FFCA]
    ld l, a
    ld a, d
    or a, e
    jr z, Jump_019_4A68
    ld hl, $FFFF

Jump_019_4A68::
    pop bc
    ld a, l
    ld [bc], a
    inc bc
    ld a, h
    ld [bc], a
    inc bc
    ld a, $00
    ld [bc], a
    pop de
    ret

Func_019_4A74::
    push af
    push hl
    ld c, e
    call Func_000_1682
    pop bc
    pop af
    push hl
    push af
    push bc
    ld c, b
    call Func_000_1682
    pop bc
    pop af
    push hl
    call Func_000_1682
    pop bc
    ld a, c
    add a, h
    ld h, a
    ld a, b
    adc a, $00
    ld e, a
    pop bc
    ld a, c
    add a, e
    ld e, a
    ld a, b
    adc a, $00
    ld d, a
    ret

Func_019_4A9A::
    push bc
    ld b, $0A
    ld a, $FF

Jump_019_4A9F::
    ld [de], a
    inc de
    dec b
    jr nz, Jump_019_4A9F
    ld a, [$CFEC]
    ld [de], a
    inc de
    ld a, [$CFED]
    ld [de], a
    inc de
    inc de
    inc de
    ld b, $04
    ld hl, $CFEE

Jump_019_4AB5::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_019_4AB5
    ld a, $FF
    ld b, $04

Jump_019_4ABF::
    ld [de], a
    inc de
    dec b
    jr nz, Jump_019_4ABF
    ld a, $00
    ld [de], a
    inc de
    ld a, [$CFF5]
    ld [de], a
    inc de
    ld a, [$CFF2]
    ld [de], a
    inc de
    ld a, [$CFF3]
    ld [de], a
    inc de
    ld a, $00
    ld [de], a
    inc de
    ld hl, $CFF6
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl-]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl-]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, $E7
    ld [de], a
    inc de
    ld a, $03
    ld [de], a
    inc de
    ld a, [$D002]
    ld [de], a
    inc de
    ld a, [$D003]
    ld [de], a
    inc de
    ld a, [$D005]
    ld [de], a
    inc de
    ld a, [$D004]
    ld [de], a
    inc de
    ld a, $1C
    add a, e
    ld e, a
    jr nc, Jump_019_4B31
    inc d

Jump_019_4B31::
    ld a, [$CFF4]
    ld [de], a
    pop bc
    ret

Func_019_4B37::
    ld a, $0C
    add a, e
    ld e, a
    jr nc, Jump_019_4B3E
    inc d

Jump_019_4B3E::
    ld a, [$D008]
    ld [de], a
    inc de
    ld a, [$D009]
    or a, a
    jr z, Jump_019_4B71
    cp a, $01
    jr z, Jump_019_4B55
    cp a, $02
    jr z, Jump_019_4B59
    ld b, $E6
    jr Jump_019_4B5B

Jump_019_4B55::
    ld b, $02
    jr Jump_019_4B5B

Jump_019_4B59::
    ld b, $80

Jump_019_4B5B::
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
    jr c, Jump_019_4B6F
    xor a, a
    jr Jump_019_4B71

Jump_019_4B6F::
    ld a, $01

Jump_019_4B71::
    ld [de], a
    ld a, [$D068]
    or a, a
    jr z, Jump_019_4B7B
    res 4, a
    ld [de], a

Jump_019_4B7B::
    ld a, $24
    add a, e
    ld e, a
    jr nc, Jump_019_4B82
    inc d

Jump_019_4B82::
    ld b, $1B
    ld hl, $D01A

Jump_019_4B87::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_019_4B87
    inc de
    inc de
    pop bc
    ret

Func_019_4B91::
    ld a, [$C58A]
    or a, a
    jr nz, Func_019_4BA8
    ld a, c
    cp a, $04
    jr nc, Jump_019_4BA1
    call Func_019_4BA8
    jr Jump_019_4BA4

Jump_019_4BA1::
    call Func_019_4CF8

Jump_019_4BA4::
    call Func_019_42EE
    ret

Func_019_4BA8::
    ld a, c
    push bc
    call Func_019_4E05
    pop bc
    ld a, c
    add a, a
    ld de, $D958
    add a, e
    ld e, a
    jr nc, Jump_019_4BB8
    inc d

Jump_019_4BB8::
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
    jr nc, Jump_019_4BCF
    inc d

Jump_019_4BCF::
    ld a, [hl]
    and a, $0F
    ld [de], a
    ld a, [$C58A]
    or a, a
    jr z, Jump_019_4BF5
    ld a, c
    ld de, $DA43
    add a, e
    ld e, a
    jr nc, Jump_019_4BE2
    inc d

Jump_019_4BE2::
    ld a, $00
    ld [de], a
    ld a, c
    ld de, $DA4B
    add a, e
    ld e, a
    jr nc, Jump_019_4BEE
    inc d

Jump_019_4BEE::
    ld a, $00
    ld [de], a
    inc hl
    push af
    jr Jump_019_4C19

Jump_019_4BF5::
    ld a, c
    ld de, $DA43
    add a, e
    ld e, a
    jr nc, Jump_019_4BFE
    inc d

Jump_019_4BFE::
    ld a, [hl+]
    swap a
    and a, $0F
    push af
    and a, $03
    ld [de], a
    pop af
    push af
    push af
    ld a, c
    ld de, $DA4B
    add a, e
    ld e, a
    jr nc, Jump_019_4C13
    inc d

Jump_019_4C13::
    pop af
    rrca
    rrca
    and a, $03
    ld [de], a

Jump_019_4C19::
    ld a, c
    cp a, $04
    jr nc, Jump_019_4C2D
    ld a, c
    ld de, $CFD8
    add a, e
    ld e, a
    jr nc, Jump_019_4C27
    inc d

Jump_019_4C27::
    pop af
    and a, $03
    ld [de], a
    jr Jump_019_4C2E

Jump_019_4C2D::
    pop af

Jump_019_4C2E::
    push hl
    push bc
    ld a, [$D868]
    or a, a
    jr nz, Jump_019_4C3B
    call Func_019_434D
    jr Jump_019_4C3E

Jump_019_4C3B::
    call Func_019_4349

Jump_019_4C3E::
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
    call z, Func_019_4468
    inc hl
    ld de, $D8B7
    call Func_019_44A3
    inc hl
    inc hl
    inc hl
    ld a, [$D871]
    or a, a
    jr z, Jump_019_4C71
    inc hl
    inc hl
    ld de, $D8CF
    call Func_019_44AC
    inc hl
    inc hl
    ld de, $D8EF
    call Func_019_44AC
    jr Jump_019_4C89

Jump_019_4C71::
    ld de, $D8BF
    call Func_019_44AC
    ld de, $D8CF
    call Func_019_44AC
    ld de, $D8DF
    call Func_019_44AC
    ld de, $D8EF
    call Func_019_44AC

Jump_019_4C89::
    ld de, $D8FF
    call Func_019_44AC
    ld de, $D90F
    call Func_019_44AC
    ld de, $D91F
    call Func_019_44AC
    ld de, $D92F
    call Func_019_44AC
    ld de, $D93F
    call Func_019_44AC
    ld a, [$D871]
    or a, a
    jr z, Jump_019_4CCA
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
    jr nc, Jump_019_4CBE
    inc h

Jump_019_4CBE::
    ld a, [hl]
    and a, $30
    pop hl
    jr nz, Jump_019_4CCA
    inc hl
    inc hl
    inc hl
    inc hl
    jr Jump_019_4CE2

Jump_019_4CCA::
    ld de, $D968
    call Func_019_44A3
    ld de, $D978
    call Func_019_44A3
    ld de, $D980
    call Func_019_44A3
    ld de, $D970
    call Func_019_44A3

Jump_019_4CE2::
    ld a, c
    add a, a
    add a, c
    add a, a
    add a, c
    ld de, $DA72
    add a, e
    ld e, a
    jr nc, Jump_019_4CEF
    inc d

Jump_019_4CEF::
    push bc
    call Func_019_44C9
    pop bc
    call Func_019_4298
    ret

Func_019_4CF8::
    push bc
    call Func_019_4E05
    pop bc
    ld a, c
    add a, a
    ld de, $D958
    add a, e
    ld e, a
    jr nc, Jump_019_4D07
    inc d

Jump_019_4D07::
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
    jr nc, Jump_019_4D1E
    inc d

Jump_019_4D1E::
    ld a, [hl+]
    ld [de], a
    ld a, c
    ld de, $DA43
    add a, e
    ld e, a
    jr nc, Jump_019_4D29
    inc d

Jump_019_4D29::
    ld a, $00
    ld [de], a
    push hl
    push bc
    ld a, [$D868]
    or a, a
    jr nz, Jump_019_4D39
    call Func_019_434D
    jr Jump_019_4D3C

Jump_019_4D39::
    call Func_019_4349

Jump_019_4D3C::
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
    call z, Func_019_4468
    inc hl
    ld de, $D8B7
    call Func_019_44A3
    inc hl
    inc hl
    inc hl
    ld a, [$D871]
    or a, a
    jr z, Jump_019_4D6F
    inc hl
    inc hl
    ld de, $D8CF
    call Func_019_44AC
    inc hl
    inc hl
    ld de, $D8EF
    call Func_019_44AC
    jr Jump_019_4D96

Jump_019_4D6F::
    ld de, $D8BF
    call Func_019_44AC
    push de
    push hl
    ld a, e
    sub a, $01
    ld l, a
    ld a, d
    sbc a, $00
    ld h, a
    call Func_019_42FD
    pop hl
    pop de
    ld de, $D8CF
    call Func_019_44AC
    ld de, $D8DF
    call Func_019_44AC
    ld de, $D8EF
    call Func_019_44AC

Jump_019_4D96::
    ld de, $D8FF
    call Func_019_44AC
    ld de, $D90F
    call Func_019_44AC
    ld de, $D91F
    call Func_019_44AC
    ld de, $D92F
    call Func_019_44AC
    ld de, $D93F
    call Func_019_44AC
    ld a, [$D871]
    or a, a
    jr z, Jump_019_4DD7
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
    jr nc, Jump_019_4DCB
    inc h

Jump_019_4DCB::
    ld a, [hl]
    and a, $30
    pop hl
    jr nz, Jump_019_4DD7
    inc hl
    inc hl
    inc hl
    inc hl
    jr Jump_019_4DEF

Jump_019_4DD7::
    ld de, $D968
    call Func_019_44A3
    ld de, $D978
    call Func_019_44A3
    ld de, $D980
    call Func_019_44A3
    ld de, $D970
    call Func_019_44A3

Jump_019_4DEF::
    ld a, c
    add a, a
    add a, c
    add a, a
    add a, c
    ld de, $DA72
    add a, e
    ld e, a
    jr nc, Jump_019_4DFC
    inc d

Jump_019_4DFC::
    push bc
    call Func_019_44C9
    pop bc
    call Func_019_4298
    ret

Func_019_4E05::
    cp a, $03
    jr c, Jump_019_4E0E
    ret z
    cp a, $07
    ret z
    dec a

Jump_019_4E0E::
    ld c, $4E
    call Func_000_1682
    ld a, l
    add a, $D5
    ld l, a
    ld a, h
    adc a, $D0
    ld h, a
    ret

Func_019_4E1C::
    ld a, [$C58A]
    or a, a
    jr nz, Jump_019_4E3E
    ld hl, $DA5F
    ld bc, $0404

Jump_019_4E28::
    ld a, c
    call Func_000_3E54
    jr z, Jump_019_4E32
    ld [hl], $01
    jr Jump_019_4E34

Jump_019_4E32::
    ld [hl], $FF

Jump_019_4E34::
    inc hl
    inc c
    dec b
    jr nz, Jump_019_4E28
    ld bc, $0400
    jr Jump_019_4E41

Jump_019_4E3E::
    ld bc, $0800

Jump_019_4E41::
    ld hl, $DA5B

Jump_019_4E44::
    ld a, c
    call Func_000_3E54
    jr z, Jump_019_4E58
    ld a, c
    call Func_000_3E25
    jr c, Jump_019_4E54
    ld [hl], $00
    jr Jump_019_4E5A

Jump_019_4E54::
    ld [hl], $01
    jr Jump_019_4E5A

Jump_019_4E58::
    ld [hl], $FF

Jump_019_4E5A::
    inc c
    inc hl
    dec b
    jr nz, Jump_019_4E44
    ret
    INCBIN "dwm2-cobi-us.gbc", $064E60, $2520

Func_019_7380::
    ld bc, $0129
    ldh a, [$FFC6]
    call Func_000_16AA
    ldh a, [$FFC7]
    ld c, a
    ld b, $00
    add hl, bc
    add hl, bc
    add hl, bc
    ld a, l
    add a, $60
    ld l, a
    ld a, h
    adc a, $4E
    ld h, a
    ld a, [hl+]
    ldh [$FFC8], a
    ld a, [hl+]
    ldh [$FFC9], a
    ld a, [hl]
    ldh [$FFCA], a
    ret

Func_019_73A2::
    ld a, [$C991]
    ld l, a
    ld a, [$C992]
    ld h, a
    ld a, l
    ld [$D006], a
    ld a, h
    ld [$D007], a
    ld hl, Func_035_4001
    ld b, $35
    rst $10
    ld a, [$D00F]
    ld bc, $0129
    call Func_000_16AA
    ld a, [$C9DC]
    dec a
    ld c, a
    ld b, $00
    add hl, bc
    add hl, bc
    add hl, bc
    ld a, l
    add a, $60
    ld l, a
    ld a, h
    adc a, $4E
    ld h, a
    ld de, $C9DE
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    ret

Func_019_73DF::
    ld a, [$CA36]
    ld l, a
    ld a, [$CA37]
    ld h, a
    ld a, l
    ld [$D006], a
    ld a, h
    ld [$D007], a
    ld hl, Func_035_4001
    ld b, $35
    rst $10
    ld a, [$D00F]
    ld bc, $0129
    call Func_000_16AA
    ld a, [$CA81]
    dec a
    ld c, a
    ld b, $00
    add hl, bc
    add hl, bc
    add hl, bc
    ld a, l
    add a, $60
    ld l, a
    ld a, h
    adc a, $4E
    ld h, a
    ld de, $CA83
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    ret
    INCBIN "dwm2-cobi-us.gbc", $06741C, $15C
    ds $24, $07
    ds $A64, $00
