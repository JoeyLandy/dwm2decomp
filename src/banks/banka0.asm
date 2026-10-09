SECTION "Bank A0", ROMX[$4000], BANK[$A0]
    db $A0

Func_0A0_4001::
    ld hl, wD800
    ld bc, $0303
    xor a, a
    call FillBytes
    ld a, [wDataBank]
    ld [wDataBankSave], a
    ld hl, wCFC8
    ld bc, $0008
    xor a, a
    call FillBytes
    ld hl, wCFD0
    ld bc, $0008
    xor a, a
    call FillBytes
    ld a, $0A
    ld [wCFC5], a
    call Func_0A0_40B0
    ld hl, wD09D
    ld bc, $0200
    xor a, a
    call FillBytes
    call Func_0A0_42E3
    call Func_0A0_4181
    call Func_0A0_415D
    call Func_0A0_42D3
    call Func_0A0_46A1
    ret

Func_0A0_4047::
    xor a, a
    ld hl, wDA67
    ld [hl+], a
    ld [hl+], a
    ld a, [wD78E]
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
    ld hl, wDA5B
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
    ld a, [wD78E]
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
    ld [wD891], a
    ld hl, wD868
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
    ld [wD802], a
    ld [wDAAC], a
    ld [wDAAD], a
    ld [wD892], a
    ld hl, wC46B
    ld bc, $0008
    xor a, a
    call FillBytes
    xor a, a
    ld [wC5FC], a
    ld [wC5FD], a
    ld [wC5FE], a
    ld hl, wDA5B
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
    ld hl, wDAD8
    ld bc, $0008
    ld a, $80
    call FillBytes
    ld hl, wDA63
    ld bc, $0008
    ld a, $FF
    call FillBytes
    ld hl, wD958
    ld bc, $0010
    ld a, $FF
    call FillBytes
    ld a, $FF
    ld hl, wDA08
    ld bc, $0020
    call FillBytes
    ld a, $FF
    ld hl, wDAD4
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ld a, $FF
    ld [wDAAB], a
    ld a, $0A
    ld [wD89F], a
    ld hl, wD895
    ld bc, $000A
    ld a, $FF
    call FillBytes
    xor a, a
    ld [wD891], a
    ld a, $00
    ld [wD092], a
    xor a, a
    ld [wCFD8], a
    ld [wCFD9], a
    ld [wCFDA], a
    ld [wD04B], a
    ld a, $00
    ld [wD78E], a
    ld a, $02
    ld [wD88F], a
    ld a, $03
    ld [wD890], a
    ld a, [wC835]
    ld [wCFDB], a
    ld a, $03
    ld [wC964], a
    ret

Func_0A0_415D::
    farcall Func_031_71F5
    call Func_0A0_4B10
    call Func_0A0_4C2C
    call Func_0A0_4C52
    call FillTilesFromRequest
    farcall Func_01A_7276
    ld hl, vBGMap0
    call Func_0A0_42B2
    ld a, $7F
    ld [wC526], a
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
    ld de, wD8A7
    ld bc, $0800

Jump_0A0_41A8::
    push bc
    ld a, c
    ld hl, wDA63
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
    ld hl, wD958
    add a, l
    ld l, a
    jr nc, Jump_0A0_41C1
    inc h

Jump_0A0_41C1::
    ld a, [hl+]
    ld [wD006], a
    ld a, [hl]
    ld [wD007], a
    push de
    farcall Func_035_4001
    pop de
    ld a, [wD00B]
    ld h, a
    ld a, [wD00A]
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
    ld hl, wD008
    ld bc, $002F
    xor a, a
    call FillBytes
    pop hl
    pop bc
    ret

Func_0A0_41F2::
    ld bc, $0800
    ld hl, wD8AF

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
    ld hl, wD9C9

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
    ld hl, wD989
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
    ld hl, wD989
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
    ld de, wDA63
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
    ld de, wD80C
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
    ld de, wC198
    ld bc, $1412

Jump_0A0_42B8::
    push bc
    push hl

Jump_0A0_42BA::
    ld a, [de]
    inc de
    call WriteVRAMByteInc
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
    ld a, [wCFC5]
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
    ld de, wD0D5
    ld a, [wC57F]
    bit 1, a
    jr nz, Jump_0A0_42F8
    ld hl, wC986
    call Func_0A0_4301
    ld hl, wCA2B
    jr Func_0A0_4301

Jump_0A0_42F8::
    ld hl, wCA2B
    call Func_0A0_4301
    ld hl, wC986

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
    ldh [hFFC6], a
    ld a, d
    ldh [hFFC7], a
    pop af
    push de
    sub a, $0D
    swap a
    ld de, Data_0A0_4387
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
    ldh a, [hFFC6]
    add a, l
    ld l, a
    ldh a, [hFFC7]
    adc a, h
    ld h, a
    ld a, [hl]
    cp a, $03
    ret nc
    inc a
    ld [hl], a
    ret

Data_0A0_4387:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $280387, $70

Func_0A0_43F7::
    ld a, [wD868]
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
    ld [wD868], a
    ret

Func_0A0_4410::
    ld a, c
    push bc
    call Func_0A0_468A
    pop bc
    ld a, c
    add a, a
    ld de, wD958
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
    ld de, wD8AF
    add a, e
    ld e, a
    jr nc, Jump_0A0_4437
    inc d

Jump_0A0_4437::
    ld a, [hl]
    and a, $0F
    ld [de], a
    ld a, c
    ld de, wDA43
    add a, e
    ld e, a
    jr nc, Jump_0A0_4444
    inc d

Jump_0A0_4444::
    ld a, $00
    ld [de], a
    ld a, c
    ld de, wDA4B
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
    ld a, [wC57F]
    bit 1, a
    jr nz, Jump_0A0_4488
    ld a, c
    ld de, wCFD8
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
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_0A0_4488
    ld a, c
    and a, $03
    ld de, wCFD8
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
    ld a, [wD868]
    or a, a
    jr nz, Jump_0A0_4499
    farcall Func_019_434D
    jr Jump_0A0_449F

Jump_0A0_4499::
    farcall Func_019_4349

Jump_0A0_449F::
    pop bc
    pop hl
    ld a, l
    add a, $08
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wD871]
    or a, a
    call z, Func_0A0_4268
    inc hl
    ld de, wD8B7
    call Func_0A0_429C
    inc hl
    inc hl
    inc hl
    ld a, [wD871]
    or a, a
    jr z, Jump_0A0_44D2
    inc hl
    inc hl
    ld de, wD8CF
    call Func_0A0_42A5
    inc hl
    inc hl
    ld de, wD8EF
    call Func_0A0_42A5
    jr Jump_0A0_44EA

Jump_0A0_44D2::
    ld de, wD8BF
    call Func_0A0_42A5
    ld de, wD8CF
    call Func_0A0_42A5
    ld de, wD8DF
    call Func_0A0_42A5
    ld de, wD8EF
    call Func_0A0_42A5

Jump_0A0_44EA::
    ld de, wD8FF
    call Func_0A0_42A5
    ld de, wD90F
    call Func_0A0_42A5
    ld de, wD91F
    call Func_0A0_42A5
    ld de, wD92F
    call Func_0A0_42A5
    ld de, wD93F
    call Func_0A0_42A5
    ld a, [wD871]
    or a, a
    jr z, Jump_0A0_452B
    ld a, [wD868]
    push hl
    ld l, a
    add a, a
    add a, a
    add a, a
    add a, l
    ld hl, wD80D
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
    ld de, wD968
    call Func_0A0_429C
    ld de, wD978
    call Func_0A0_429C
    ld de, wD980
    call Func_0A0_429C
    ld de, wD970
    call Func_0A0_429C

Jump_0A0_4543::
    ld a, c
    add a, a
    add a, c
    add a, a
    add a, c
    ld de, wDA72
    add a, e
    ld e, a
    jr nc, Jump_0A0_4550
    inc d

Jump_0A0_4550::
    push bc
    ld a, l
    ld [wD868], a
    ld a, h
    ld [wD869], a
    ld a, e
    ld [wD86A], a
    ld a, d
    ld [wD86B], a
    farcall Func_019_44B9
    pop bc
    farcall Func_019_4298
    ret

Func_0A0_456F::
    push bc
    call Func_0A0_468A
    pop bc
    ld a, c
    add a, a
    ld de, wD958
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
    ld de, wD8AF
    add a, e
    ld e, a
    jr nc, Jump_0A0_4595
    inc d

Jump_0A0_4595::
    ld a, [hl+]
    ld [de], a
    ld a, c
    ld de, wDA43
    add a, e
    ld e, a
    jr nc, Jump_0A0_45A0
    inc d

Jump_0A0_45A0::
    ld a, $00
    ld [de], a
    push hl
    push bc
    ld a, [wD868]
    or a, a
    jr nz, Jump_0A0_45B3
    farcall Func_019_434D
    jr Jump_0A0_45B9

Jump_0A0_45B3::
    farcall Func_019_4349

Jump_0A0_45B9::
    pop bc
    pop hl
    ld a, l
    add a, $08
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wD871]
    or a, a
    call z, Func_0A0_4268
    inc hl
    ld de, wD8B7
    call Func_0A0_429C
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld a, [wD871]
    or a, a
    jr z, Jump_0A0_45ED
    inc hl
    inc hl
    ld de, wD8CF
    call Func_0A0_42A5
    inc hl
    inc hl
    ld de, wD8EF
    call Func_0A0_42A5
    jr Jump_0A0_4605

Jump_0A0_45ED::
    ld de, wD8BF
    call Func_0A0_42A5
    ld de, wD8CF
    call Func_0A0_42A5
    ld de, wD8DF
    call Func_0A0_42A5
    ld de, wD8EF
    call Func_0A0_42A5

Jump_0A0_4605::
    ld de, wD8FF
    call Func_0A0_42A5
    ld de, wD90F
    call Func_0A0_42A5
    ld de, wD91F
    call Func_0A0_42A5
    ld de, wD92F
    call Func_0A0_42A5
    ld de, wD93F
    call Func_0A0_42A5
    ld a, [wD871]
    or a, a
    jr z, Jump_0A0_4646
    ld a, [wD868]
    push hl
    ld l, a
    add a, a
    add a, a
    add a, a
    add a, l
    ld hl, wD80D
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
    ld de, wD968
    call Func_0A0_429C
    ld de, wD978
    call Func_0A0_429C
    ld de, wD980
    call Func_0A0_429C
    ld de, wD970
    call Func_0A0_429C

Jump_0A0_465E::
    ld a, c
    add a, a
    add a, c
    add a, a
    add a, c
    ld de, wDA72
    add a, e
    ld e, a
    jr nc, Jump_0A0_466B
    inc d

Jump_0A0_466B::
    push bc
    ld a, l
    ld [wD868], a
    ld a, h
    ld [wD869], a
    ld a, e
    ld [wD86A], a
    ld a, d
    ld [wD86B], a
    farcall Func_019_44B9
    pop bc
    farcall Func_019_4298
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
    call Multiply8
    ld a, l
    add a, $D5
    ld l, a
    ld a, h
    adc a, $D0
    ld h, a
    ret

Func_0A0_46A1::
    ld bc, $0200
    ld hl, wDA5B

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
    ld hl, wD0FC
    call Func_0A0_486D
    ld hl, wD0FE
    call Func_0A0_486D
    srl d
    rr e
    ld hl, wD0F2
    call Func_0A0_486D
    ld hl, wD0F6
    call Func_0A0_486D
    ld hl, wD0F8
    call Func_0A0_486D
    ld hl, wD0FA
    call Func_0A0_486D
    ld h, d
    ld l, e
    ld a, $32
    call DivideHLByA
    push hl
    ld a, [wD0EC]
    ld c, $18
    call Multiply8
    push hl
    ld de, $0000
    ld hl, wD0F2
    call Func_0A0_486D
    ld hl, wD0F6
    call Func_0A0_486D
    ld hl, wD0F8
    call Func_0A0_486D
    ld hl, wD0FA
    call Func_0A0_486D
    ld hl, wD0FC
    call Func_0A0_486D
    ld hl, wD0FE
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
    call DivideHLByA
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
    call DivideHLByA

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
    ld hl, wD14A
    call Func_0A0_486D
    ld hl, wD14C
    call Func_0A0_486D
    srl d
    rr e
    ld hl, wD140
    call Func_0A0_486D
    ld hl, wD144
    call Func_0A0_486D
    ld hl, wD146
    call Func_0A0_486D
    ld hl, wD148
    call Func_0A0_486D
    ld h, d
    ld l, e
    ld a, $32
    call DivideHLByA
    push hl
    ld a, [wD13A]
    ld c, $18
    call Multiply8
    push hl
    ld de, $0000
    ld hl, wD140
    call Func_0A0_486D
    ld hl, wD144
    call Func_0A0_486D
    ld hl, wD146
    call Func_0A0_486D
    ld hl, wD148
    call Func_0A0_486D
    ld hl, wD14A
    call Func_0A0_486D
    ld hl, wD14C
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
    call DivideHLByA
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
    call DivideHLByA

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
    ld [wCFE3], a
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
    ld [wCFE4], a

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
    ld hl, Data_0A0_6D57
    add a, l
    ld l, a
    jr nc, Jump_0A0_4884
    inc h

Jump_0A0_4884::
    ld a, [wCFE4]
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
    ld hl, wC5E7
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
    ld de, wCFDD
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
    ld a, [wC5E7]
    ld bc, $0B00
    ld hl, Data_0A0_48F5

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
    ld a, [wCFE4]
    cp a, $06
    jr nc, Jump_0A0_48F3
    jr Func_0A0_48D0

Jump_0A0_48F3::
    ld a, c
    ret

Data_0A0_48F5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $19, $32, $4B, $64, $7D, $96, $AF, $C8, $E1, $FA, $FF

Func_0A0_4900::
    ld hl, wD0D5
    ld de, wD1BF
    ld bc, $004E
    call CopyBytes
    ld hl, wD123
    ld de, wD20D
    ld bc, $004E
    call CopyBytes
    ret

Func_0A0_4919::
    push de
    ld a, [wCFE3]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, $05
    call DivideHLByA
    ld a, $05
    add a, l
    pop de
    cp a, $64
    jr c, Jump_0A0_4931
    ld a, $63

Jump_0A0_4931::
    ldh [hFFC7], a

Jump_0A0_4933::
    push bc
    ld a, c
    ld hl, Data_0A0_4B0A
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A0_493E
    inc h

Jump_0A0_493E::
    ld a, [hl+]
    ld [wD86A], a
    ld a, [hl]
    ld [wD86B], a
    call Func_0A0_494F
    pop bc
    inc c
    dec b
    jr nz, Jump_0A0_4933
    ret

Func_0A0_494F::
    push bc
    ld a, c
    ld [wD869], a
    add a, a
    ld hl, wCFDD
    add a, l
    ld l, a
    jr nc, Jump_0A0_495D
    inc h

Jump_0A0_495D::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, l
    ld [wD006], a
    ld a, h
    ld [wD007], a
    farcall Func_035_4001
    ld a, [wD86A]
    add a, $0A
    ld l, a
    ld a, [wD86B]
    adc a, $00
    ld h, a
    ld a, [wD006]
    ld [hl+], a
    ld a, [wD007]
    ld [hl+], a
    ld a, [wD008]
    ld [hl+], a
    ld a, [wD009]
    ld [hl+], a
    ld a, [wD010]
    ld [hl+], a
    ld a, [wD011]
    ld [hl+], a
    ld a, [wD012]
    ld [hl+], a
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ldh a, [hFFC7]
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    push hl
    ld a, [wD014]
    ldh [hFFC6], a
    farcall Func_01A_63A7
    pop hl
    ld a, $01
    ld [wD868], a
    call Func_0A0_4A55
    call Func_0A0_4A97
    ld a, [wD015]
    ldh [hFFC6], a
    push hl
    farcall Func_01A_63A7
    pop hl
    ld a, $00
    ld [wD868], a
    call Func_0A0_4A55
    call Func_0A0_4A97
    ld a, [wD016]
    ldh [hFFC6], a
    push hl
    farcall Func_01A_63A7
    pop hl
    call Func_0A0_4A55
    ld a, [wD017]
    ldh [hFFC6], a
    push hl
    farcall Func_01A_63A7
    pop hl
    call Func_0A0_4A55
    ld a, [wD018]
    ldh [hFFC6], a
    push hl
    farcall Func_01A_63A7
    pop hl
    call Func_0A0_4A55
    ld a, [wD019]
    ldh [hFFC6], a
    push hl
    farcall Func_01A_63A7
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
    farcall Func_01A_5FA7
    ld a, [wD86A]
    ld e, a
    ld a, [wD86B]
    ld d, a
    pop bc
    ret

Func_0A0_4A45::
    push af
    push bc
    push de
    push hl
    call NextTableByte
    pop hl
    pop de
    pop bc
    pop af
    ld a, [wC5E7]
    ld [hl+], a
    ret

Func_0A0_4A55::
    push af
    push bc
    push de
    push hl
    ldh a, [hFFC8]
    ld c, a
    ldh a, [hFFC9]
    ld b, a
    ld a, [wCFE3]
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
    ldh [hFFC8], a
    ld a, h
    ldh [hFFC9], a
    pop hl
    pop de
    pop bc
    pop af
    ldh a, [hFFC8]
    ld [hl+], a
    ldh a, [hFFC9]
    ld [hl+], a
    ret

Func_0A0_4A97::
    ldh a, [hFFC8]
    ld [hl+], a
    ldh a, [hFFC9]
    ld [hl+], a
    ret

Func_0A0_4A9E::
    ld de, wD01A
    ld b, $1B

Jump_0A0_4AA3::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_0A0_4AA3
    ret

Func_0A0_4AAA::
    ld a, [wD86A]
    add a, $0D
    ld l, a
    ld a, [wD86B]
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
    call NextTableByte
    pop hl
    pop de
    pop bc
    pop af
    ld a, [wC5E7]
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
    db $5F, $78, $CE, $00, $57, $C9

Data_0A0_4B0A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $BF, $D1, $0D, $D2, $5B, $D2

Func_0A0_4B10::
    ld a, $90
    ld [wC8CF], a
    ld [wC8D0], a
    ld [wC8D1], a
    ld [wC8D2], a
    ld [wC8D3], a
    ld a, $F0
    ld [wC8D4], a
    ld de, vTiles1 + $500
    call Func_000_21A1
    ld de, vTiles1 + $550
    call Func_000_21A1
    ld de, vTiles1 + $5A0
    call Func_000_21A1
    ld hl, wD0D5
    ld de, wC8CF
    ld bc, $000A
    call CopyBytes
    ld de, vTiles1 + $500
    call Func_000_21A1
    ld hl, wD123
    ld de, wC8CF
    ld bc, $000A
    call CopyBytes
    ld de, vTiles1 + $550
    call Func_000_21A1
    ld a, [wC57F]
    bit 1, a
    jr nz, Jump_0A0_4B7A
    ld hl, wC60C
    ld de, wC8CF
    ld bc, $000A
    call CopyBytes
    ld de, vTiles1 + $5A0
    call Func_000_21A1
    ld hl, wD05A
    jr Jump_0A0_4B8F

Jump_0A0_4B7A::
    ld hl, wD05A
    ld de, wC8CF
    ld bc, $000A
    call CopyBytes
    ld de, vTiles1 + $5A0
    call Func_000_21A1
    ld hl, wC60C

Jump_0A0_4B8F::
    ld de, wC8CF
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
    ld de, vTiles1 + $240
    call Func_000_21A1
    ld a, $90
    ld [wC8CF], a
    ld [wC8D0], a
    ld [wC8D1], a
    ld a, $F0
    ld [wC8D2], a
    ld de, vTiles1 + $4B0
    call Func_000_21A1
    ret

Jump_0A0_4BCF::
    ld a, $F0
    ld [de], a
    push hl
    push bc
    ld de, vTiles1 + $240
    call Func_000_21A1
    ld a, $90
    ld [wC8CF], a
    ld [wC8D0], a
    ld [wC8D1], a
    ld a, $F0
    ld [wC8D2], a
    ld de, vTiles1 + $4B0
    call Func_000_21A1
    pop bc
    ld a, b
    add a, $06
    ld b, a
    pop hl
    ld de, wC8CF

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
    ld de, vTiles1 + $4B0
    call Func_000_21A1
    ret

Func_0A0_4C1D:: ; heuristic: follows a terminator; C0
    ld hl, wC278
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
    ld hl, Data_0A0_4D37
    call Func_0A0_4D16
    call Func_0A0_4D25
    ret

Func_0A0_4C36::
    ld hl, Data_0A0_4DC7
    call Func_0A0_4D16
    call Func_0A0_4D25
    ld a, [wC57F]
    bit 1, a
    ret nz
    ld hl, wC1C3
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
    ld de, wC338
    ld hl, vBGMap0 + $1A0
    ld bc, $1405
    call Func_0A0_4CFA
    ret

Func_0A0_4C81::
    ld de, wC338
    ld hl, vBGMap0 + $1A0
    ld bc, $0E05
    call Func_0A0_4CFA
    ret

Func_0A0_4C8E::
    ld de, wC278
    ld hl, vBGMap0 + $E0
    ld bc, $140B
    call Func_0A0_4CFA
    ret

Func_0A0_4C9B::
    ld de, wC2B8
    ld hl, vBGMap0 + $120
    ld bc, $0B09
    call Func_0A0_4CFA
    ret

Func_0A0_4CA8:: ; heuristic: follows a terminator; C0
    ld de, wC2B8
    ld hl, vBGMap0 + $120
    ld bc, $1409
    call Func_0A0_4CFA
    ld a, $01
    ld [wD868], a
    ret

Func_0A0_4CBA:: ; heuristic: follows a terminator; C0
    ld de, wC2B8
    ld hl, vBGMap0 + $120
    ld bc, $0809
    call Func_0A0_4CFA
    ret

Func_0A0_4CC7:: ; heuristic: follows a terminator; C0
    ld de, wC2F8
    ld hl, vBGMap0 + $160
    ld bc, $0707
    call Func_0A0_4CFA
    ret

Func_0A0_4CD4::
    ld de, wC2A4
    ld hl, vBGMap0 + $10C
    ld bc, $0701
    call Func_0A0_4CFA
    ld de, wC2B8
    ld hl, vBGMap0 + $120
    ld bc, $1409
    call Func_0A0_4CFA
    ret

Func_0A0_4CED:: ; heuristic: follows a terminator; C0
    ld de, wC2F8
    ld hl, vBGMap0 + $160
    ld bc, $0D07
    call Func_0A0_4CFA
    ret

Func_0A0_4CFA::
    push bc
    push hl

Jump_0A0_4CFC::
    ld a, [de]
    inc de
    call WriteVRAMByteInc
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
    ld hl, wC198
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

Data_0A0_4D37:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $280D37, $90

Data_0A0_4DC7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $280DC7, $108

Func_0A0_4ECF::
    call Func_000_08A6
    ld a, $02
    call Func_000_122D
    ld a, [wC524]
    or a, a
    jr z, Jump_0A0_4EED
    ld a, $00
    ld [wC51F], a
    ld a, $00
    ld [wC520], a
    farcall Func_017_41CF

Jump_0A0_4EED::
    xor a, a
    ldh [hFFA1], a
    ldh [hFFA2], a
    xor a, a
    ldh [hFFA5], a
    ldh [hFFA6], a
    ld hl, vBGMap0
    ld bc, $0400
    ld a, $C3
    call FillBytes
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_0A0_4F19
    ld a, $01
    ldh [rVBK], a
    ld hl, vBGMap0
    ld bc, $0400
    xor a, a
    call FillBytes
    xor a, a
    ldh [rVBK], a

Jump_0A0_4F19::
    ld hl, vBGMap0 + $1C1
    ld a, l
    ld [wC554], a
    ld a, h
    ld [wC555], a
    ld b, $31
    ld de, Data_0A0_7C1E
    ld hl, vTiles1 + $240
    call DecompressToRAMLocked
    ld b, $31
    ld de, Data_0A0_7DFB
    ld hl, vTiles1 + $5F0
    call DecompressToRAMLocked
    call Func_0A0_4001
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld hl, vBGMap0 + $1C1
    ld a, l
    ld [wC554], a
    ld a, h
    ld [wC555], a
    ld a, $FC
    call Func_000_0DF2
    ld a, $07
    ldh [hFF9F], a
    ld a, $FF
    ldh [hFFA0], a
    ld a, $00
    ldh [hFFA5], a
    ld a, $00
    ldh [hFFA1], a
    ld a, $03
    ld [wC5EC], a
    ld a, $0B
    jp Jump_000_077A

Func_0A0_4F70::
    call Func_000_0535
    ld a, [wD802]
    cp a, $FF
    ret z
    farcall Func_03A_4ADB
    ld a, [wD800]
    cp a, $02
    ret nz
    di
    farcall Func_032_4001
    ei
    ret

Func_0A0_4F8E::
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, [wCFC8]
    rst $00
    dw Jump_0A0_4F9F
    dw Jump_0A0_5291
    dw Jump_0A0_52C0
    dw Jump_0A0_54DD

Jump_0A0_4F9F::
    ld a, [wCFC9]
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
    ld a, [wC56C]
    and a, a
    ret nz
    ld hl, wCFC9
    inc [hl]
    ld a, $0C
    ld [wC594], a
    ret

Jump_0A0_4FD8::
    ld a, [wC58F]
    cp a, $0C
    ret nz
    xor a, a
    ld [wC594], a
    ld hl, wCFC9
    inc [hl]
    ret

Jump_0A0_4FE7::
    ld hl, wCFC9
    inc [hl]
    ld a, [wC5E7]
    ld [wC597], a
    ld a, [wC5E8]
    ld [wC598], a
    ld hl, wC597
    ld a, l
    ld [wC595], a
    ld a, h
    ld [wC596], a
    ld hl, wC5B7
    ld a, l
    ld [wC590], a
    ld a, h
    ld [wC591], a
    ld a, $02
    ld [wC592], a
    ld a, $FF
    ld [wC594], a
    ld a, $01
    ld [wC58C], a
    ret

Jump_0A0_501D::
    ld a, [wC58F]
    cp a, $F0
    ret nz
    xor a, a
    ld [wC594], a
    xor a, a
    ld [wC58C], a
    ld hl, wCFC9
    inc [hl]
    ret

Jump_0A0_5030::
    ld hl, wCFC9
    inc [hl]
    ld a, $03
    ld [wC594], a
    ret

Jump_0A0_503A::
    ld a, [wC58F]
    cp a, $03
    ret nz
    xor a, a
    ld [wC594], a
    ld a, [wC57F]
    bit 1, a
    jr nz, Jump_0A0_5055
    ld a, [wC5E7]
    ld l, a
    ld a, [wC5E8]
    ld h, a
    jr Jump_0A0_505D

Jump_0A0_5055::
    ld a, [wC5B7]
    ld l, a
    ld a, [wC5B8]
    ld h, a

Jump_0A0_505D::
    ld a, l
    ld [wC5B7], a
    ld [wC5BA], a
    ld [wC5E7], a
    ld a, h
    ld [wC5B8], a
    ld [wC5BB], a
    ld [wC5E8], a
    ld hl, wCFC9
    inc [hl]
    ret

Jump_0A0_5076::
    call Func_0A0_4047
    ld a, [wD78E]
    cp a, $02
    jr z, Jump_0A0_5093
    ld a, $02
    ld [wCFDC], a
    ld bc, $0300
    call Func_0A0_46C3
    call Func_0A0_4193
    ld hl, wCFC9
    inc [hl]
    ret

Jump_0A0_5093::
    ld a, $01
    ld [wCFDC], a
    ld a, $02
    ld [wD890], a
    ld a, $02
    ld [wC985], a
    call Func_0A0_4900
    call Func_0A0_418E
    ld hl, wCFC9
    inc [hl]
    ret

Jump_0A0_50AD::
    ld a, [wC56C]
    or a, a
    ret nz
    ld a, [wD78E]
    ld [wC529], a
    ld a, $06
    ld [wC528], a
    farcall Func_007_4001
    ld hl, wCFC9
    inc [hl]
    ret

Jump_0A0_50C8::
    ld a, [wC52B]
    or a, a
    ret nz
    ld a, [wD960]
    ld l, a
    ld a, [wD961]
    add a, $02
    ld h, a
    ld de, wC130
    call Func_000_2E81
    ld a, $03
    ld [wC529], a
    ld a, $06
    ld [wC528], a
    farcall Func_007_4001
    ld hl, wCFC9
    inc [hl]
    ret

Jump_0A0_50F2::
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_0A0_5105
    ld de, $0000
    ld hl, vBGMap0 + $E1
    ld a, $01
    ldh [hFFC6], a
    call Func_000_2090

Jump_0A0_5105::
    ld a, [wD960]
    ld e, a
    ld a, [wD961]
    ld d, a
    ld hl, vTiles2 + $140
    ld c, $01
    call Func_000_1FE3
    ld a, $7F
    ld [wC526], a
    ld hl, wCFC9
    inc [hl]
    ret

Jump_0A0_511F::
    ld hl, vBGMap0 + $E1
    ld a, [wD78E]
    cp a, $02
    jr nz, Jump_0A0_512C
    ld hl, vBGMap0 + $E4

Jump_0A0_512C::
    ld d, $14
    call Func_0A0_5278
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_0A0_5153
    ld hl, vBGMap0 + $E1
    ld a, [wD78E]
    cp a, $02
    jr nz, Jump_0A0_5144
    ld hl, vBGMap0 + $E4

Jump_0A0_5144::
    ld a, $01
    ldh [hFFC6], a
    ld a, [wD960]
    ld e, a
    ld a, [wD961]
    ld d, a
    call Func_000_2090

Jump_0A0_5153::
    ld hl, wCFC9
    inc [hl]
    ret

Jump_0A0_5158::
    ld a, [wC52B]
    or a, a
    ret nz
    ld a, [wD962]
    ld l, a
    ld a, [wD963]
    add a, $02
    ld h, a
    ld de, wC130
    call Func_000_2E81
    ld a, $04
    ld [wC529], a
    ld a, $06
    ld [wC528], a
    farcall Func_007_4001
    ld hl, wCFC9
    inc [hl]
    ret

Jump_0A0_5182::
    ld a, [wD962]
    ld e, a
    ld a, [wD963]
    ld d, a
    ld hl, vTiles2 + $380
    ld c, $03
    call Func_000_1FE3
    ld a, $7F
    ld [wC526], a
    ld hl, wCFC9
    inc [hl]
    ret

Jump_0A0_519C::
    ld hl, vBGMap0 + $E7
    ld a, [wD78E]
    cp a, $02
    jr nz, Jump_0A0_51B1
    ld a, [wCFC9]
    add a, $03
    ld [wCFC9], a
    ld hl, vBGMap0 + $EA

Jump_0A0_51B1::
    ld d, $38
    call Func_0A0_5278
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_0A0_51D8
    ld hl, vBGMap0 + $E7
    ld a, [wD78E]
    cp a, $02
    jr nz, Jump_0A0_51C9
    ld hl, vBGMap0 + $EA

Jump_0A0_51C9::
    ld a, $03
    ldh [hFFC6], a
    ld a, [wD962]
    ld e, a
    ld a, [wD963]
    ld d, a
    call Func_000_2090

Jump_0A0_51D8::
    ld hl, wCFC9
    inc [hl]
    ret

Jump_0A0_51DD::
    ld a, [wC52B]
    or a, a
    ret nz
    ld a, [wD964]
    ld l, a
    ld a, [wD965]
    add a, $02
    ld h, a
    ld de, wC130
    call Func_000_2E81
    ld a, $05
    ld [wC529], a
    ld a, $06
    ld [wC528], a
    farcall Func_007_4001
    ld hl, wCFC9
    inc [hl]
    ret

Jump_0A0_5207::
    ld a, [wD964]
    ld e, a
    ld a, [wD965]
    ld d, a
    ld hl, vTiles2 + $5C0
    ld c, $05
    call Func_000_1FE3
    ld a, $7F
    ld [wC526], a
    ld hl, wCFC9
    inc [hl]
    ret

Jump_0A0_5221::
    ld d, $5C
    ld hl, vBGMap0 + $ED
    call Func_0A0_5278
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_0A0_5241
    ld hl, vBGMap0 + $ED
    ld a, $05
    ldh [hFFC6], a
    ld a, [wD964]
    ld e, a
    ld a, [wD965]
    ld d, a
    call Func_000_2090

Jump_0A0_5241::
    ld hl, wCFC9
    inc [hl]
    ret

Jump_0A0_5246::
    ld a, [wC52B]
    or a, a
    ret nz
    ld a, $05
    ld [wC528], a
    ld a, $0C
    ld [wC529], a
    farcall Func_007_400F
    ld a, $01
    ld [wC594], a
    ld hl, wCFC9
    inc [hl]
    ret

Jump_0A0_5265::
    ld a, [wC58F]
    cp a, $01
    ret nz
    xor a, a
    ld [wCFC9], a
    xor a, a
    ld [wC594], a
    ld hl, wCFC8
    inc [hl]
    ret

Func_0A0_5278::
    ld bc, $0606

Jump_0A0_527B::
    ld a, d
    inc d
    call WriteVRAMByteInc
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
    ld a, [wCFC9]
    rst $00
    dw Jump_0A0_529F
    dw Jump_0A0_52A7
    dw Jump_0A0_52AB
    dw Jump_0A0_52B2
    dw Jump_0A0_52B9

Jump_0A0_529F::
    call Func_0A0_5D7A
    ld hl, wCFC9
    inc [hl]
    ret

Jump_0A0_52A7::
    call Func_0A0_5E07
    ret

Jump_0A0_52AB::
    farcall Func_0A1_413F
    ret

Jump_0A0_52B2::
    farcall Func_03A_6157
    ret

Jump_0A0_52B9::
    farcall Func_03A_68C9
    ret

Jump_0A0_52C0::
    ld a, [wCFC9]
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
    ld [wC594], a
    ld hl, wCFC9
    inc [hl]
    ret

Jump_0A0_52E0::
    ld a, [wC58F]
    cp a, $01
    ret nz
    ld hl, wDA63
    ld a, l
    ld [wC595], a
    ld a, h
    ld [wC596], a
    ld hl, wC5B7
    ld a, l
    ld [wC590], a
    ld a, h
    ld [wC591], a
    ld a, $08
    ld [wC592], a
    ld a, $FF
    ld [wC594], a
    ld hl, wCFC9
    inc [hl]
    ret

Jump_0A0_530B::
    ld a, [wC58F]
    cp a, $F0
    ret nz
    ld a, [wC57F]
    bit 1, a
    jr nz, Jump_0A0_5320
    ld a, [wC5B8]
    ld [wDA64], a
    jr Jump_0A0_5326

Jump_0A0_5320::
    ld a, [wC5B7]
    ld [wDA63], a

Jump_0A0_5326::
    ld hl, wCFC9
    inc [hl]
    xor a, a
    ld [wC594], a
    ret

Jump_0A0_532F::
    ld a, [wD891]
    inc a
    ld b, a
    ld a, [wD04B]
    add a, b
    cp a, $64
    jr c, Jump_0A0_533E
    ld a, $63

Jump_0A0_533E::
    ld [wD04B], a
    ld hl, wDA63
    ld a, [hl]
    cp a, $01
    jr z, Jump_0A0_5356
    ld a, $00
    ld hl, wD80C
    call AddAx9ToHL
    ld a, [hl]
    bit 6, a
    jr z, Jump_0A0_536B

Jump_0A0_5356::
    ld hl, wDA64
    ld a, [hl]
    cp a, $01
    jr z, Jump_0A0_5383
    ld a, $01
    ld hl, wD80C
    call AddAx9ToHL
    ld a, [hl]
    bit 6, a
    jr nz, Jump_0A0_5383

Jump_0A0_536B::
    ld a, [wD78E]
    add a, $06
    ld [wC529], a
    ld a, $06
    ld [wC528], a
    farcall Func_007_4001
    ld hl, wCFC9
    inc [hl]
    ret

Jump_0A0_5383::
    ld a, $02
    call Func_000_122D
    ld hl, wCFC8
    inc [hl]
    xor a, a
    ld [wCFC9], a
    ret

Jump_0A0_5391::
    ld a, [wC52B]
    or a, a
    ret nz
    ld a, [wD78E]
    cp a, $02
    jp z, Jump_0A0_5415
    inc a
    ld [wD78E], a
    farcall Func_032_5E3B
    ld c, $00
    farcall Func_031_76AE
    farcall Func_031_77B9
    ld c, $00
    farcall Func_031_7806
    farcall Func_031_7914
    ld c, $00
    farcall Func_031_785F
    farcall Func_031_7965
    ld c, $01
    farcall Func_031_76AE
    farcall Func_031_77B9
    ld c, $01
    farcall Func_031_7806
    farcall Func_031_7914
    ld c, $01
    farcall Func_031_785F
    farcall Func_031_7965
    ld a, $05
    ld [wC528], a
    ld a, $0C
    ld [wC529], a
    farcall Func_007_4001
    xor a, a
    ld [wC594], a
    ld hl, wCFC9
    inc [hl]
    ret

Jump_0A0_5415::
    ld hl, wCFC8
    inc [hl]
    xor a, a
    ld [wCFC9], a
    xor a, a
    ld [wC594], a
    ret

Jump_0A0_5422::
    ld hl, vBGMap0 + $E1
    ld bc, $1206
    ld de, $000E

Jump_0A0_542B::
    di

Jump_0A0_542C::
    ldh a, [rSTAT]
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
    ld hl, wCFC9
    inc [hl]
    ret

Jump_0A0_5444::
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_0A0_546F
    ld a, $01
    ldh [rVBK], a
    ld hl, vBGMap0 + $E1
    ld bc, $1206
    ld de, $000E

Jump_0A0_5457::
    di

Jump_0A0_5458::
    ldh a, [rSTAT]
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
    ldh [rVBK], a

Jump_0A0_546F::
    ld hl, wCFC9
    inc [hl]
    ret

Jump_0A0_5474::
    ld hl, wCFC9
    inc [hl]
    ld a, $01
    ld [wC594], a
    ret

Jump_0A0_547E::
    ld a, [wC58F]
    cp a, $01
    ret nz
    xor a, a
    ld [wC594], a
    xor a, a
    ld [wCFC8], a
    xor a, a
    ld [wCFC9], a
    ret

Func_0A0_5491::
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC6FD]
    ld b, a
    ld hl, wC6FE
    ld de, wC972

Jump_0A0_54A0::
    inc de
    ld a, [de]
    cp a, $FF
    jr z, Jump_0A0_54D2
    dec de
    push hl
    ld a, [hl]
    ld c, $5B
    call SRAMRecordAddress
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
    call SRAMRecordAddress
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
    call SRAMRecordAddress
    ld a, [de]
    inc de
    ld [hl+], a
    pop hl
    inc hl
    dec b
    jr nz, Jump_0A0_54A0

Jump_0A0_54D2::
    farcall Func_0F2_65E6
    xor a, a
    ld [rRAMG], a
    ret

Jump_0A0_54DD::
    ld a, [wCFC9]
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
    ld [wC964], a
    ld a, [wC899]
    ld l, a
    ld a, [wC89A]
    ld h, a
    ld a, l
    ld [wC89B], a
    ld a, h
    ld [wC89C], a
    ld hl, wDA63
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    sla a
    or a, c
    ld c, a
    ld hl, wD80C
    ld a, [hl]
    and a, $40
    sra a
    sra a
    or a, c
    ld c, a
    ld hl, wD815
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
    ld a, [wC57F]
    and a, $02
    rrca
    ld hl, wDA63
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
    ld [wC899], a
    ld a, [wD064]
    ld [wC89A], a
    call Func_0A0_5A6C
    call Func_0A0_5B47
    xor a, a
    ld [wC8C3], a
    ld [wC8C4], a
    ld hl, wCFC9
    inc [hl]
    call Func_0A0_5491
    ret

Jump_0A0_558C::
    farcall Func_002_7718
    ld a, [wC8C3]
    bit 7, a
    ret z
    farcall Func_002_7688
    ld a, [wC899]
    add a, $0F
    ld [wC529], a
    ld a, $05
    ld [wC528], a
    farcall Func_007_4001
    ld hl, wCFC9
    inc [hl]
    ret

Jump_0A0_55B6::
    ld a, [wC52B]
    or a, a
    ret nz
    ld hl, wC198
    ld bc, $01A0
    ld a, $C3
    call FillBytes
    ld hl, vBGMap0
    call Func_0A0_42B2
    ld hl, wCFC9
    inc [hl]
    ret

Jump_0A0_55D1::
    ld hl, vTiles1 + $700
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $2C01
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld a, $01
    ld [wC528], a
    ld a, $03
    ld [wC529], a
    farcall Func_007_400F
    ld hl, vTiles2 + $200
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0801
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld a, $01
    ld [wC528], a
    ld a, $05
    ld [wC529], a
    farcall Func_007_400F
    ld hl, wCFC9
    inc [hl]
    ret

Jump_0A0_5622::
    call Func_0A0_4C36
    ld a, [wC899]
    ld hl, Data_0A0_56CA
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A0_5631
    inc h

Jump_0A0_5631::
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld hl, wC1F9

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
    ld a, [wCFE3]
    ld hl, wC23F
    call Func_0A0_5678
    ld a, [wD04B]
    ld hl, wC27F
    call Func_0A0_5678
    ld a, [wCFE4]
    ld hl, wC2BF
    call Func_0A0_5678
    ld a, [wCFE5]
    add a, $20
    ld [wC300], a
    ld de, wC895
    ld hl, wC209
    call Func_0A0_569E
    ld hl, wCFC9
    inc [hl]
    ret

Func_0A0_5678::
    push hl
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    pop hl
    ld a, [wC8C1]
    add a, $E0
    cp a, $E0
    jr nz, Jump_0A0_568B
    ld a, $C3

Jump_0A0_568B::
    ld [hl+], a
    ld a, [wC8C2]
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
    call HLToDecimalDigits
    pop hl
    ld a, [wC8C1]
    or a, a
    jr z, Jump_0A0_56BA
    add a, $E0
    ld [hl], a

Jump_0A0_56BA::
    inc hl
    ld a, [wC8C2]
    add a, $E0
    ld [hl], a
    ld a, l
    add a, $3F
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ret

Data_0A0_56CA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $04, $F7, $04, $0E, $04, $12, $04, $16

Jump_0A0_56D2::
    ld hl, vBGMap0
    call Func_0A0_42B2
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld hl, wC987
    ld de, wC130
    ld bc, $000A
    call CopyBytes
    ld a, $F0
    ld [wC13A], a
    ld hl, wCFC9
    inc [hl]
    ret

Jump_0A0_56F7::
    ld a, [wD0A6]
    cp a, $FF
    jr nz, Jump_0A0_5704
    ld hl, wCFC9
    inc [hl]
    jr Jump_0A0_5737

Jump_0A0_5704::
    call Func_0A0_5A30
    ld a, [wD0A7]
    ld hl, wC150
    call Func_000_2EAC
    ld a, [wC899]
    cp a, $02
    ld a, $14
    jr c, Jump_0A0_571B
    ld a, $15

Jump_0A0_571B::
    ld [wC529], a
    ld a, $05
    ld [wC528], a
    farcall Func_007_4001
    ld hl, wCFC9
    inc [hl]
    ld hl, wCFC9
    inc [hl]
    ret

Jump_0A0_5732::
    ld a, [wC52B]
    or a, a
    ret nz

Jump_0A0_5737::
    ld a, [wCFCA]
    call Func_0A0_5A30
    ld a, [wCFCA]
    ld hl, wD0A7
    add a, l
    ld l, a
    jr nc, Jump_0A0_5748
    inc h

Jump_0A0_5748::
    ld a, [hl]
    ld hl, wC150
    call Func_000_2EAC
    ld a, $05
    ld [wC528], a
    ld a, $15
    ld [wC529], a
    farcall Func_007_4001
    ld a, [wCFCA]
    inc a
    ld [wCFCA], a
    cp a, $06
    ret c
    xor a, a
    ld [wCFCA], a
    ld hl, wCFC9
    inc [hl]
    ret

Jump_0A0_5772::
    ld a, [wC52B]
    or a, a
    ret nz
    ld a, [wD0AD]
    ldh [hFFC6], a
    ld a, [wD0AE]
    ldh [hFFC7], a
    xor a, a
    ldh [hFFC8], a
    ld hl, wC150
    call Func_000_2ECF
    ld a, $05
    ld [wC528], a
    ld a, $16
    ld [wC529], a
    farcall Func_007_4001
    xor a, a
    ld [wCFCA], a
    xor a, a
    ld [wC594], a
    ld hl, wCFC9
    inc [hl]
    ld a, [wC899]
    cp a, $01
    ret z
    ld hl, wCFC9
    inc [hl]
    ret

Jump_0A0_57B1::
    ld a, [wCFCA]
    rst $00
    dw Jump_0A0_57B9
    dw Jump_0A0_57C8

Jump_0A0_57B9::
    ld a, [wC52B]
    or a, a
    ret nz
    ld a, $01
    ld [wC594], a
    ld hl, wCFCA
    inc [hl]
    ret

Jump_0A0_57C8::
    ld a, [wC58F]
    cp a, $01
    ret nz
    ld a, $08
    ld [wD092], a
    ld a, $01
    ld [wD04C], a
    ld hl, wC986
    ld de, wCA2B
    ld bc, $00A5
    call CopyBytes
    ld a, $01
    ld [wCA2B], a
    ld a, $FF
    ld [wCA45], a
    ld [wCA46], a
    ld [wCA47], a
    ld [wCA48], a
    ld hl, wCA49
    call Func_0A0_591A
    ld a, $FF
    ld [wCA53], a
    ld hl, wCA54
    call Func_0A0_591A
    ld a, $FF
    ld [wCA5E], a
    call Func_0A0_5939
    xor a, a
    ld [wCA80], a
    ld a, $01
    ld [wCA81], a
    xor a, a
    ld [wCA83], a
    ld [wCA84], a
    ld [wCA85], a
    ld a, [wCA88]
    ld l, a
    ld a, [wCA89]
    ld h, a
    call Func_0A0_590B
    ld a, l
    ld [wCA88], a
    ld a, h
    ld [wCA89], a
    ld a, l
    ld [wCA86], a
    ld a, h
    ld [wCA87], a
    ld a, [wCA8C]
    ld l, a
    ld a, [wCA8D]
    ld h, a
    call Func_0A0_590B
    ld a, l
    ld [wCA8C], a
    ld a, h
    ld [wCA8D], a
    ld a, l
    ld [wCA8A], a
    ld a, h
    ld [wCA8B], a
    ld a, [wCA8E]
    ld l, a
    ld a, [wCA8F]
    ld h, a
    call Func_0A0_590B
    ld a, l
    ld [wCA8E], a
    ld a, h
    ld [wCA8F], a
    ld a, [wCA90]
    ld l, a
    ld a, [wCA91]
    ld h, a
    call Func_0A0_590B
    ld a, l
    ld [wCA90], a
    ld a, h
    ld [wCA91], a
    ld a, [wCA92]
    ld l, a
    ld a, [wCA93]
    ld h, a
    call Func_0A0_590B
    ld a, l
    ld [wCA92], a
    ld a, h
    ld [wCA93], a
    ld a, [wCA94]
    ld l, a
    ld a, [wCA95]
    ld h, a
    call Func_0A0_590B
    ld a, l
    ld [wCA94], a
    ld a, h
    ld [wCA95], a
    xor a, a
    ld [wCA96], a
    ld [wCA97], a
    xor a, a
    ld [wCA98], a
    ld a, $01
    ld [wCA99], a
    ld hl, wCAB9
    call Func_0A0_591A
    xor a, a
    ld [wCAC3], a
    ld hl, wCAC4
    call Func_0A0_591A
    xor a, a
    ld [wCACE], a
    xor a, a
    ld [wCACF], a
    ld a, $04
    call Func_000_0DF2
    ld a, $06
    ld [wC5DB], a
    xor a, a
    ld [wC5DC], a
    ld [wC5DD], a
    ld [wC5DE], a
    ld [wD780], a
    ld hl, wC5DF
    inc [hl]
    ld hl, wD066
    inc [hl]
    xor a, a
    ld [wC581], a
    ld [wC582], a
    xor a, a
    ld [wC57F], a
    ld [wC580], a
    xor a, a
    ld [wC58A], a
    xor a, a
    ld [wC594], a
    xor a, a
    ld [wC58F], a
    xor a, a
    ld [wC58B], a
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
    ld de, wCA67
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
    ld hl, wCA5F

Jump_0A0_594D::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_0A0_596E
    push hl
    ld c, a
    ld hl, Data_0A0_597A

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
    ld hl, wCA5F
    ld b, $08

Jump_0A0_5973::
    ld a, $FF
    ld [hl+], a
    dec b
    jr nz, Jump_0A0_5973
    ret

Data_0A0_597A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $28197A, $5A

Jump_0A0_59D4::
    ld a, [wCFCA]
    rst $00
    dw Jump_0A0_59DC
    dw Jump_0A0_59EB

Jump_0A0_59DC::
    ld a, [wC52B]
    or a, a
    ret nz
    ld a, $01
    ld [wC594], a
    ld hl, wCFCA
    inc [hl]
    ret

Jump_0A0_59EB::
    ld a, [wC58F]
    cp a, $01
    ret nz
    ld a, $04
    call Func_000_0DF2
    ld a, $05
    ld [wC5DB], a
    ld a, $01
    ld [wC5DC], a
    xor a, a
    ld [wC5DD], a
    ld [wC5DE], a
    ld [wD780], a
    ld hl, wC5DF
    inc [hl]
    xor a, a
    ld [wC581], a
    ld [wC582], a
    xor a, a
    ld [wC57F], a
    ld [wC580], a
    xor a, a
    ld [wC58A], a
    xor a, a
    ld [wC594], a
    xor a, a
    ld [wC58F], a
    xor a, a
    ld [wC58B], a
    ret
    db $0A, $14, $1E

Func_0A0_5A30::
    ld hl, Data_0A0_5A4A
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A0_5A39
    inc h

Jump_0A0_5A39::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, wC140

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

Data_0A0_5A4A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $56, $5A, $59, $5A, $5C, $5A, $60, $5A, $64, $5A, $68, $5A, $11, $19, $F0, $16
    db $19, $F0, $0A, $1D, $14, $F0, $0D, $0E, $0F, $F0, $0A, $10, $15, $F0, $12, $17
    db $1D, $F0

Func_0A0_5A6C::
    ld a, [wC899]
    ld hl, wC895
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
    ld a, [wD04B]
    ld hl, Data_0A0_5B25
    call Func_0A0_5B1A
    ld hl, Data_0A0_5B2C
    add a, l
    ld l, a
    jr nc, Jump_0A0_5A91
    inc h

Jump_0A0_5A91::
    push hl
    ld hl, wC895
    ld a, [hl+]
    add a, [hl]
    ld c, a
    ld b, $00
    push bc
    ld a, $0A
    call Multiply8
    pop bc
    ld a, [wC897]
    add a, c
    ld c, a
    ld a, $00
    adc a, b
    ld b, a
    ld a, [wC898]
    add a, c
    ld c, a
    ld a, $00
    adc a, b
    ld b, a
    call Func_000_3F04
    ld a, l
    ld [wD09D], a
    ld [wCFE4], a
    ld hl, Data_0A0_5B33
    call Func_0A0_5B1A
    ld hl, Data_0A0_5B39
    add a, l
    ld l, a
    jr nc, Jump_0A0_5ACB
    inc h

Jump_0A0_5ACB::
    ld a, [wCFE3]
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
    ld hl, Data_0A0_5B3F
    call Func_0A0_5B1A
    ld [wD09E], a
    ld [wCFE5], a
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

Data_0A0_5B25:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $06, $0B, $15, $29, $33, $3D, $FF

Data_0A0_5B2C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $14, $0A, $05, $00, $FB, $F6, $EC

Data_0A0_5B33:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $03, $05, $07, $09, $FF

Data_0A0_5B39:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $EC, $F6, $FB, $00, $05, $0A

Data_0A0_5B3F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $14, $28, $32, $3C, $46, $50, $5A, $FF

Func_0A0_5B47::
    ld a, $FF
    ld [wD0A6], a
    ld [wD0A7], a
    ld [wD0A8], a
    ld [wD0A9], a
    ld [wD0AA], a
    ld [wD0AB], a
    ld [wD0AC], a
    ld [wD0AD], a
    ld [wD0AE], a
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wD065]
    ld c, $5D
    call SRAMRecordAddress
    ld a, [wC899]
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
    ld a, [wD09E]
    ld hl, Data_0A0_5D5A
    add a, l
    ld l, a
    jr nc, Jump_0A0_5B94
    inc h

Jump_0A0_5B94::
    ld c, [hl]
    pop hl
    call Func_0A0_5C8F
    ld a, c
    ld [wD0A7], a
    ld a, [wD09E]
    add a, a
    ld hl, Data_0A0_5D6A
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
    ld a, [wD09E]
    ld hl, Data_0A0_5D62
    add a, l
    ld l, a
    jr nc, Jump_0A0_5BBD
    inc h

Jump_0A0_5BBD::
    ld c, [hl]
    pop hl
    call Func_0A0_5CB2
    ld a, b
    ld [wD0A7], a
    ld de, $03E8
    jr Jump_0A0_5C08

Jump_0A0_5BCB::
    push hl
    ld a, [wD09E]
    ld hl, Data_0A0_5D62
    add a, l
    ld l, a
    jr nc, Jump_0A0_5BD7
    inc h

Jump_0A0_5BD7::
    ld c, [hl]
    pop hl
    call Func_0A0_5CB2
    ld a, b
    ld [wD0A7], a
    inc hl
    inc hl
    call Func_0A0_5CB2
    ld a, b
    ld [wD0A8], a
    call Func_0A0_5CB2
    ld a, b
    ld [wD0A9], a
    call Func_0A0_5CB2
    ld a, b
    ld [wD0AA], a
    call Func_0A0_5CB2
    ld a, b
    ld [wD0AB], a
    call Func_0A0_5CB2
    ld a, b
    ld [wD0AC], a
    ld de, $03E8

Jump_0A0_5C08::
    ld a, e
    ld [wD0AD], a
    ld a, d
    ld [wD0AE], a
    ld a, [wC617]
    add a, e
    ld l, a
    ld a, [wC618]
    adc a, d
    ld h, a
    ld a, [wC619]
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
    ld [wD0AD], a
    ld a, h
    ld [wD0AE], a
    pop hl
    ld e, $01
    ld h, $86
    ld l, $9F
    jr Jump_0A0_5C4B

Jump_0A0_5C4A::
    pop hl

Jump_0A0_5C4B::
    ld a, l
    ld [wC617], a
    ld a, h
    ld [wC618], a
    ld a, e
    ld [wC619], a
    ld a, [wD065]
    ld c, $5E
    call SRAMRecordAddress
    ld a, [hl-]
    ld b, a
    ld a, [hl-]
    ld c, a
    push hl
    ld a, [hl-]
    ld l, [hl]
    ld a, h
    call CompareHLToBC
    pop hl
    jr c, Jump_0A0_5C70
    ld a, b
    ld [hl-], a
    ld [hl], c

Jump_0A0_5C70::
    ld a, [wD065]
    ld c, $62
    call SRAMRecordAddress
    ld a, [hl-]
    ld b, a
    ld a, [hl-]
    ld c, a
    push hl
    ld a, [hl-]
    ld a, [hl]
    ld l, a
    ld h, a
    call CompareHLToBC
    pop hl
    jr c, Jump_0A0_5C8A
    ld a, b
    ld [hl-], a
    ld [hl], c

Jump_0A0_5C8A::
    xor a, a
    ld [rRAMG], a
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
    ld [wD0A6], a
    ld hl, Data_0A0_5D54
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
    call CompareHLToBC
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
    ld [wD0A6], a
    ld hl, Data_0A0_5D54
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
    call CompareHLToBC
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
    ld a, [wC5E7]
    cp a, $80
    ret

Data_0A0_5D54:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $04, $06, $08, $0A, $0C

Data_0A0_5D5A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $02, $03, $04, $05, $06, $08, $0A

Data_0A0_5D62:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $01, $01, $01, $01, $01, $01, $01

Data_0A0_5D6A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $E8, $03, $E8, $03, $E8, $03, $E8, $03, $E8, $03, $E8, $03, $E8, $03, $E8, $03

Func_0A0_5D7A::
    ld hl, wDAD8
    ld b, $08

Jump_0A0_5D7F::
    set 7, [hl]
    inc hl
    dec b
    jr nz, Jump_0A0_5D7F
    ld hl, wD854
    ld bc, $0010
    xor a, a
    call FillBytes
    ld hl, wD895
    ld bc, $000A
    xor a, a
    call FillBytes
    ld hl, wDA1C
    ld bc, $0010
    ld a, $FF
    call FillBytes
    ld a, $FF
    ld [wD892], a
    ld [wD893], a
    ld a, $00
    ld [wC46B], a
    ld bc, $0200
    ld hl, wDA5B
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
    ld hl, wCFC9
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
    ld hl, wD80F
    call AddAx9ToHL
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
    ld hl, wDA5B
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
    ld a, [wCFCA]
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
    ld a, [wCFCB]
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
    ld hl, wDAD8
    set 7, [hl]
    inc hl
    set 7, [hl]
    inc hl
    set 7, [hl]
    inc hl
    set 7, [hl]
    farcall Func_031_72C9
    farcall Func_031_7536
    ld hl, vTiles1 + $6D0
    ld de, $0701
    ld a, $02
    ld [wC528], a
    ld a, $00
    ld [wC529], a
    call Func_0A0_6C81
    farcall Func_01A_727D
    ld hl, wCFCB
    inc [hl]
    ret

Jump_0A0_5E71::
    call Func_0A0_4C81
    ld hl, Data_0A0_6977
    ld a, [wC46B]
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
    ld hl, vBGMap0
    add hl, de
    ld a, $BB
    call WriteVRAMByte
    ld hl, wCFCB
    inc [hl]
    ret

Jump_0A0_5E93::
    ld de, Data_0A0_6977
    ld hl, wC46B
    call Func_0A0_65CF
    ld a, [wC562]
    bit 0, a
    jr z, Jump_0A0_5EBD
    ld a, $69
    call StoreWC60B
    ld hl, wC46C
    ld bc, $0007
    ld a, $00
    call FillBytes
    farcall Func_031_72C9
    ld hl, wCFCB
    inc [hl]

Jump_0A0_5EBD::
    ret

Jump_0A0_5EBE::
    call Func_0A0_4C81
    ld hl, wCFCB
    inc [hl]
    ret

Jump_0A0_5EC6::
    ld a, [wC46B]
    and a, $03
    ld [wCFDB], a
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
    ld [wCFCA], a
    xor a, a
    ld [wCFCB], a
    jp Jump_0A0_5F2D

Jump_0A0_5EEA::
    ld a, [wC57F]
    rrca
    and a, $01
    ld c, a
    ld hl, wDA5B
    add a, l
    ld l, a
    jr nc, Jump_0A0_5EF9
    inc h

Jump_0A0_5EF9::
    ld a, [hl]
    or a, a
    jr z, Jump_0A0_5F0D
    ld a, $00
    ld [wC528], a
    ld a, $2D
    ld [wC529], a
    ld hl, wCFCB
    inc [hl]
    jr Jump_0A0_5F2D

Jump_0A0_5F0D::
    ld a, c
    ld [wCFD4], a
    ld a, $01
    ld [wCFCA], a
    xor a, a
    ld [wCFCB], a
    jr Jump_0A0_5F2D

Jump_0A0_5F1C::
    ld a, $1D
    jr Jump_0A0_5F22

Jump_0A0_5F20::
    ld a, $20

Jump_0A0_5F22::
    ld [wC529], a
    xor a, a
    ld [wC528], a
    ld hl, wCFCB
    inc [hl]

Jump_0A0_5F2D::
    ret

Func_0A0_5F2E::
    ld a, [wC57F]
    and a, $02
    ld hl, wDA1C
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
    farcall Func_01A_7276
    call Func_0A0_4C74
    ld hl, wCFCB
    inc [hl]
    ret

Jump_0A0_5F51::
    farcall Func_02F_4001
    ld hl, wCFCB
    inc [hl]
    ret

Jump_0A0_5F5C::
    ld a, [wC52B]
    or a, a
    ret nz
    farcall Func_031_72C9
    call Func_0A0_4C74
    farcall Func_01A_727D
    ld a, $01
    ld [wCFCB], a
    ret

Jump_0A0_5F76::
    ld a, [wCFCB]
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
    ld hl, vTiles1 + $6D0
    ld de, $2001
    ld a, $02
    ld [wC528], a
    ld a, $01
    ld [wC529], a
    call Func_0A0_6C81
    ld a, $08
    ld [wC529], a
    ld hl, vTiles2 + $50
    ld de, $0801
    call Func_0A0_6C81
    xor a, a
    ld [wCFD7], a
    ld a, $03
    ld [wCFD6], a
    xor a, a
    ld [wCFD5], a
    farcall Func_01A_728B
    ld hl, wC29B
    call Func_0A0_67B8
    ld hl, wCFCB
    inc [hl]
    ret

Jump_0A0_5FEB::
    ld a, [wCFD4]
    ld hl, wCFD8
    add a, l
    ld l, a
    jr nc, Jump_0A0_5FF6
    inc h

Jump_0A0_5FF6::
    ld a, [hl]
    ld [wC46C], a
    call Func_0A0_4C8E
    ld hl, Data_0A0_697F
    ld a, [wC46C]
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
    ld hl, vBGMap0
    add hl, de
    ld a, $BB
    call WriteVRAMByte
    ld hl, wCFCB
    inc [hl]
    ld a, $03
    ld [wCFD3], a
    ret

Jump_0A0_6021::
    ld de, Data_0A0_697F
    ld hl, wC46C
    call Func_0A0_666B
    ld a, [wC562]
    bit 0, a
    jr z, Jump_0A0_6062
    ld a, $69
    call StoreWC60B
    ld a, [wCFD4]
    ld hl, wCFD8
    add a, l
    ld l, a
    jr nc, Jump_0A0_6041
    inc h

Jump_0A0_6041::
    ld a, [wC46C]
    and a, $03
    ld [hl], a
    call Func_0A0_69A1
    cp a, $03
    jr nz, Jump_0A0_606D
    farcall Func_031_72C9
    ld hl, wCFCB
    inc [hl]
    ld hl, wCFCB
    inc [hl]
    ld a, $00
    ld [wD869], a
    ret

Jump_0A0_6062::
    bit 1, a
    jr z, Jump_0A0_609F
    ld a, $00
    ld [wD869], a
    jr Jump_0A0_6095

Jump_0A0_606D::
    ld a, [wCFD4]
    ld hl, wDA1C
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A0_6079
    inc h

Jump_0A0_6079::
    ld a, $FF
    ld [hl+], a
    ld [hl], a
    ld a, [wCFD4]
    ld hl, wDAD8
    add a, l
    ld l, a
    jr nc, Jump_0A0_6088
    inc h

Jump_0A0_6088::
    set 7, [hl]
    xor a, a
    ld [wCFCB], a
    ld a, $03
    ld [wCFCA], a
    jr Jump_0A0_609F

Jump_0A0_6095::
    farcall Func_031_72C9
    ld hl, wCFCB
    inc [hl]

Jump_0A0_609F::
    ret

Jump_0A0_60A0::
    call Func_0A0_4C8E
    xor a, a
    ld [wCFCB], a
    xor a, a
    ld [wCFCA], a
    ret

Jump_0A0_60AC::
    ld a, [wD869]
    or a, a
    call z, Func_0A0_4C8E
    xor a, a
    ld [wD869], a
    ld hl, vTiles1 + $6D0
    ld de, $0803
    ld a, $02
    ld [wC528], a
    ld a, $09
    ld [wC529], a
    call Func_0A0_6C81
    farcall Func_01A_7299
    ld a, [wCFD4]
    and a, $03
    ld hl, wC2DA
    call Func_0A0_67B8
    ld a, [wCFD4]
    ld hl, wDAD8
    add a, l
    ld l, a
    jr nc, Jump_0A0_60E6
    inc h

Jump_0A0_60E6::
    ld a, [hl]
    swap a
    and a, $03
    ld [wC46D], a
    ld hl, wCFCB
    inc [hl]
    ret

Jump_0A0_60F3::
    call Func_0A0_4C9B
    ld hl, Data_0A0_6987
    ld a, [wC46D]
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
    ld hl, vBGMap0
    add hl, de
    ld a, $BB
    call WriteVRAMByte
    ld hl, wCFCB
    inc [hl]
    ret

Jump_0A0_6115::
    ld de, Data_0A0_6987
    ld hl, wC46D
    call Func_0A0_661B
    ld a, [wC562]
    bit 1, a
    jr z, Jump_0A0_6137
    ld a, $00
    ld [wD869], a
    farcall Func_031_72C9
    ld hl, wCFCB
    inc [hl]
    jp Jump_0A0_61D9

Jump_0A0_6137::
    bit 0, a
    jp z, Jump_0A0_61D9
    ld a, $69
    call StoreWC60B
    ld a, [wCFD4]
    ld hl, wDAD8
    add a, l
    ld l, a
    jr nc, Jump_0A0_614C
    inc h

Jump_0A0_614C::
    ld a, [hl]
    and a, $0F
    ld [hl], a
    ld a, [wC46D]
    and a, $03
    swap a
    or a, [hl]
    ld [hl], a
    ld a, [wC46D]
    and a, $03
    or a, a
    jr z, Jump_0A0_6167
    cp a, $01
    jr z, Jump_0A0_6192
    jr Jump_0A0_61B7

Jump_0A0_6167::
    ld a, [wCFD4]
    ld hl, wDA1C
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A0_6173
    inc h

Jump_0A0_6173::
    ld a, $C0
    ld [hl+], a
    ld a, [wCFD4]
    xor a, $01
    ld c, a
    call Func_000_3E54
    jr c, Jump_0A0_6185
    ld a, c
    ld [hl], a
    jr Jump_0A0_61CA

Jump_0A0_6185::
    farcall Func_031_72C9
    ld a, $15
    ld [wCFCB], a
    jr Jump_0A0_61D9

Jump_0A0_6192::
    call Func_0A0_67D4
    ld a, d
    or a, a
    jr nz, Jump_0A0_61A6
    farcall Func_031_72C9
    ld a, $08
    ld [wCFCB], a
    jr Jump_0A0_61D9

Jump_0A0_61A6::
    farcall Func_031_72C9
    xor a, a
    ld [wD869], a
    ld a, $0C
    ld [wCFCB], a
    jr Jump_0A0_61D9

Jump_0A0_61B7::
    ld a, [wCFD4]
    ld hl, wDA1C
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A0_61C3
    inc h

Jump_0A0_61C3::
    ld a, $AC
    ld [hl+], a
    ld a, [wCFD4]
    ld [hl], a

Jump_0A0_61CA::
    ld a, $01
    ld [wD869], a
    farcall Func_031_72C9
    ld hl, wCFCB
    inc [hl]

Jump_0A0_61D9::
    ret

Jump_0A0_61DA::
    call Func_0A0_4C9B
    ld a, [wD869]
    or a, a
    jr z, Jump_0A0_61E5
    ld a, $14

Jump_0A0_61E5::
    ld [wCFCB], a
    ret

Jump_0A0_61E9::
    call Func_0A0_4C9B
    call FillTilesFromRequest
    farcall Func_01A_7276
    ld hl, wCFCB
    inc [hl]
    ret

Jump_0A0_61FA::
    call Func_0A0_4C74
    ld a, $00
    ld [wC528], a
    ld a, $29
    ld [wC529], a
    farcall Func_02F_4001
    ld hl, wCFCB
    inc [hl]
    ret

Jump_0A0_6212::
    call Func_0A0_4C74
    ld a, $00
    ld [wC528], a
    ld a, $7F
    ld [wC529], a
    farcall Func_02F_4001
    ld hl, wCFCB
    inc [hl]
    ret

Jump_0A0_622A::
    ld a, [wC52B]
    or a, a
    ret nz
    farcall Func_031_72C9
    ld hl, wCFCB
    inc [hl]
    ret

Jump_0A0_623A::
    call Func_0A0_4C74
    ld a, $04
    ld [wCFCB], a
    ret

Jump_0A0_6243::
    ld a, [wD869]
    or a, a
    call z, Func_0A0_4C9B
    xor a, a
    ld [wD869], a
    ld a, [wCFD4]
    ld hl, wDAD8
    add a, l
    ld l, a
    jr nc, Jump_0A0_6259
    inc h

Jump_0A0_6259::
    ld a, [hl]
    and a, $03
    ld [wC46E], a
    ld a, [hl]
    rrca
    rrca
    and a, $01
    ld [wCFD5], a
    ld hl, wCFD5
    res 7, [hl]
    ld de, Data_0A0_697F
    call Func_0A0_6822
    call Func_0A0_6873
    farcall Func_01A_72B5
    ld a, $09
    ld [wC528], a
    ld a, [wD86A]
    ld l, a
    ld a, [wD86B]
    ld h, a
    ld a, [wCFD5]
    add a, a
    add a, a
    ld c, a
    ld a, [wC46E]
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
    ld hl, wCFCB
    inc [hl]
    ret

Jump_0A0_62A3::
    call Func_0A0_4CD4
    ld hl, Data_0A0_697F
    ld a, [wC46E]
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
    ld hl, vBGMap0
    add hl, de
    ld a, $BB
    call WriteVRAMByte
    call Func_0A0_694B
    ld hl, wCFCB
    inc [hl]
    ld a, $03
    ld [wCFD3], a
    ret

Jump_0A0_62CD::
    ld de, Data_0A0_697F
    ld hl, wC46E
    call Func_0A0_666B
    ld a, [wC562]
    bit 0, a
    jp z, Jump_0A0_6354
    ld a, $69
    call StoreWC60B
    farcall Func_031_72C9
    ld a, $14
    ld [wD869], a
    call Func_0A0_69C1
    ld a, [wCFF1]
    bit 0, a
    jp z, Jump_0A0_6373
    ld a, [wCFD4]
    ld hl, wD8DF
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A0_6305
    inc h

Jump_0A0_6305::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, [wCFEE]
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
    ld a, [wCFD4]
    ld hl, wDAD8
    add a, l
    ld l, a
    jr nc, Jump_0A0_632A
    inc h

Jump_0A0_632A::
    ld a, [hl]
    and a, $F0
    ld [hl], a
    ld a, [wCFD5]
    rlca
    rlca
    and a, $04
    or a, [hl]
    ld [hl], a
    ld a, [wC46E]
    and a, $03
    or a, [hl]
    ld [hl], a
    ld a, [wCFD4]
    ld hl, wDA1C
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A0_634A
    inc h

Jump_0A0_634A::
    ld a, [wCFEC]
    ld [hl], a
    ld hl, wCFCB
    inc [hl]
    jr Jump_0A0_6372

Jump_0A0_6354::
    ld a, [wC562]
    bit 1, a
    jr z, Jump_0A0_636C
    farcall Func_031_72C9
    ld a, $04
    ld [wD869], a
    ld hl, wCFCB
    inc [hl]
    jr Jump_0A0_6372

Jump_0A0_636C::
    call Func_0A0_6873
    call Func_0A0_694B

Jump_0A0_6372::
    ret

Jump_0A0_6373::
    ld a, $25
    ld [wC529], a
    ld a, $13
    ld [wD869], a
    ld hl, wCFCB
    inc [hl]
    ld hl, wCFCB
    inc [hl]
    jr Jump_0A0_6372

Jump_0A0_6387::
    ld a, $26
    ld [wC529], a
    ld a, $13
    ld [wD869], a
    ld hl, wCFCB
    inc [hl]
    ld hl, wCFCB
    inc [hl]
    jr Jump_0A0_6372

Jump_0A0_639B::
    call Func_0A0_4CD4
    ld a, [wD869]
    ld [wCFCB], a
    xor a, a
    ld [wD869], a
    ret

Jump_0A0_63A9::
    farcall Func_031_72C9
    call Func_0A0_4CD4
    farcall Func_01A_7276
    ld hl, wCFCB
    inc [hl]
    ret

Jump_0A0_63BD::
    call Func_0A0_4C74
    xor a, a
    ld [wC528], a
    farcall Func_02F_4001
    ld hl, wCFCB
    inc [hl]
    ret

Jump_0A0_63CF::
    ld a, [wC52B]
    or a, a
    ret nz
    farcall Func_031_72C9
    ld hl, wCFCB
    inc [hl]
    ret

Jump_0A0_63DF::
    call Func_0A0_4C74
    ld a, $0C
    ld [wCFCB], a
    ret

Jump_0A0_63E8::
    xor a, a
    ld [wCFCB], a
    ld a, $03
    ld [wCFCA], a
    ret

Jump_0A0_63F2::
    ret

Jump_0A0_63F3::
    ld b, $08
    ld hl, wDA5B

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
    ld [wD8A4], a
    farcall Func_031_72C9
    call Func_0A0_6A2C
    farcall Func_01A_7276
    farcall Func_031_7536
    ld hl, wCFCA
    inc [hl]
    xor a, a
    ld [wC594], a
    ret

Jump_0A0_6424::
    ld de, wD05A
    ld hl, wC130
    call Func_000_2FE1
    ld a, $00
    ld [wC528], a
    ld a, $22
    ld [wC529], a
    farcall Func_02F_4001
    ld hl, wCFCA
    inc [hl]
    ret

Jump_0A0_6442::
    call Func_000_3ED4
    ld a, [wC5E7]
    cp a, $F3
    ret z
    ld a, [wC5E8]
    cp a, $F3
    ret z
    ld a, [wC57F]
    rrca
    and a, $01
    ld hl, wDA43
    add a, l
    ld l, a
    jr nc, Jump_0A0_645F
    inc h

Jump_0A0_645F::
    ld d, [hl]
    ld hl, wC597
    ld a, [wC46B]
    ld [hl+], a
    ld a, [wC46C]
    ld [hl+], a
    ld a, d
    ld [hl+], a
    ld a, [wC5E7]
    ld [hl+], a
    ld a, [wC5E8]
    ld [hl+], a
    ld a, [wDAD8]
    ld [hl+], a
    ld a, [wDAD9]
    ld [hl+], a
    ld a, [wDA1C]
    ld [hl+], a
    ld a, [wDA1D]
    ld [hl+], a
    ld a, [wDA1E]
    ld [hl+], a
    ld a, [wDA1F]
    ld [hl+], a
    ld a, $01
    ld [wC594], a
    ld hl, wCFCA
    inc [hl]
    ret

Jump_0A0_6497::
    ld a, [wC58F]
    cp a, $01
    ret nz
    ld hl, wCFCA
    inc [hl]
    xor a, a
    ld [wC593], a
    ld a, $0B
    ld [wC592], a
    ld hl, wC597
    ld a, l
    ld [wC595], a
    ld a, h
    ld [wC596], a
    ld hl, wC5B7
    ld a, l
    ld [wC590], a
    ld a, h
    ld [wC591], a
    ret

Jump_0A0_64C1::
    ld hl, wCFCA
    inc [hl]
    ld a, $FF
    ld [wC594], a
    ld a, $01
    ld [wC58C], a
    ret

Jump_0A0_64D0::
    ld a, [wC58F]
    cp a, $F0
    ret nz
    xor a, a
    ld [wC594], a
    xor a, a
    ld [wC58C], a
    ld a, [wC57F]
    bit 1, a
    jr nz, Jump_0A0_6513
    ld hl, wC5B7
    ld a, [hl+]
    ld [wDAE9], a
    ld a, [hl+]
    ld [wDAEA], a
    ld a, [hl+]
    ld [wDA44], a
    ld a, [wC59A]
    ld [hl+], a
    ld a, [wC59B]
    ld [hl+], a
    inc hl
    ld a, [hl+]
    ld [wDAD9], a
    inc hl
    inc hl
    ld a, [hl+]
    ld [wDA1E], a
    ld a, [hl]
    ld [wDA1F], a
    ld hl, wDA44
    ld de, wDA4C
    jr Jump_0A0_6548

Jump_0A0_6513::
    ld hl, wC46B
    ld a, [hl+]
    ld [wDAE9], a
    ld a, [hl]
    ld [wDAEA], a
    ld hl, wC5B7
    ld a, [hl+]
    ld [wC46B], a
    ld a, [hl+]
    ld [wC46C], a
    ld a, [hl+]
    ld [wDA43], a
    ld a, [hl+]
    ld [wC5E7], a
    ld a, [hl+]
    ld [wC5E8], a
    ld a, [hl+]
    ld [wDAD8], a
    inc hl
    ld a, [hl+]
    ld [wDA1C], a
    ld a, [hl]
    ld [wDA1D], a
    ld hl, wDA43
    ld de, wDA4B

Jump_0A0_6548::
    ld a, [hl]
    cp a, $03
    jr z, Jump_0A0_654E
    ld [de], a

Jump_0A0_654E::
    ld hl, wCFCA
    inc [hl]
    ret

Jump_0A0_6553::
    ld hl, wC59A
    ld a, [hl+]
    ld b, a
    ld a, [wC5E7]
    cp a, b
    ld a, [wC5BA]
    cp a, b
    jr nz, Jump_0A0_6578
    ld a, [hl]
    ld b, a
    ld a, [wC5E8]
    cp a, b
    ld a, [wC5BB]
    cp a, b
    jr nz, Jump_0A0_6578
    ld a, $22
    ld [wC594], a
    ld [wCF8B], a
    jr Jump_0A0_6580

Jump_0A0_6578::
    ld a, $33
    ld [wC594], a
    ld [wCF8B], a

Jump_0A0_6580::
    ld hl, wCFCA
    inc [hl]
    ret

Jump_0A0_6585::
    ld a, [wC58F]
    cp a, $22
    jr z, Jump_0A0_6591
    cp a, $33
    jr z, Jump_0A0_6591
    ret

Jump_0A0_6591::
    ld [wCF8C], a
    xor a, a
    ld [wC594], a
    ld hl, wCFCA
    inc [hl]
    ret

Jump_0A0_659D::
    ld a, [wCF8B]
    cp a, $22
    jr nz, Jump_0A0_65AD
    ld a, [wCF8C]
    cp a, $22
    jr nz, Jump_0A0_65AD
    jr Jump_0A0_65B3

Jump_0A0_65AD::
    ld a, $05
    ld [wCFCA], a
    ret

Jump_0A0_65B3::
    ld hl, wCFCA
    inc [hl]
    ld a, $02
    ld [wC594], a
    ret

Jump_0A0_65BD::
    ld a, [wC58F]
    cp a, $02
    ret nz
    call FillTilesFromRequest
    ld hl, wCFC9
    inc [hl]
    xor a, a
    ld [wCFCA], a
    ret

Func_0A0_65CF::
    ld a, [wC563]
    and a, $C0
    jr z, Jump_0A0_65E7
    call Func_0A0_677A
    ld a, [hl]
    xor a, $01
    ld [hl], a
    call Func_0A0_6799
    ld a, $69
    call StoreWC60B
    jr Jump_0A0_6612

Jump_0A0_65E7::
    ld a, [wC563]
    and a, $30
    jr z, Jump_0A0_65FF
    call Func_0A0_677A
    ld a, [hl]
    xor a, $02
    ld [hl], a
    call Func_0A0_6799
    ld a, $69
    call StoreWC60B
    jr Jump_0A0_6612

Jump_0A0_65FF::
    ld a, [wC5F0]
    and a, $0F
    jr nz, Jump_0A0_661A
    bit 6, [hl]
    jr z, Jump_0A0_660F
    call Func_0A0_6799
    jr Jump_0A0_6612

Jump_0A0_660F::
    call Func_0A0_677A

Jump_0A0_6612::
    ld a, [wC5F0]
    and a, $F0
    ld [wC5F0], a

Jump_0A0_661A::
    ret

Func_0A0_661B::
    ld a, [wC563]
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
    ld a, [wC563]
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
    call StoreWC60B
    jr Jump_0A0_6662

Jump_0A0_664F::
    ld a, [wC5F0]
    and a, $0F
    jr nz, Jump_0A0_666A
    bit 6, [hl]
    jr z, Jump_0A0_665F
    call Func_0A0_6799
    jr Jump_0A0_6662

Jump_0A0_665F::
    call Func_0A0_677A

Jump_0A0_6662::
    ld a, [wC5F0]
    and a, $F0
    ld [wC5F0], a

Jump_0A0_666A::
    ret

Func_0A0_666B::
    ld a, [wC563]
    and a, $40
    jr z, Jump_0A0_66AF
    ld a, [wCFD5]
    ld b, a
    ld a, [wCFD7]
    cp a, b
    jr nz, Jump_0A0_6693
    ld a, [wCFD6]
    or a, a
    jp z, Jump_0A0_6771
    call Func_0A0_677A
    ld a, [hl]
    and a, $0F
    dec a
    cp a, $FF
    jr nz, Jump_0A0_66A1
    ld a, [wCFD6]
    jr Jump_0A0_66A1

Jump_0A0_6693::
    call Func_0A0_677A
    ld a, [hl]
    and a, $0F
    dec a
    cp a, $FF
    jr nz, Jump_0A0_66A1
    ld a, [wCFD3]

Jump_0A0_66A1::
    ld [hl], a
    call Func_0A0_6799
    set 7, [hl]
    ld a, $69
    call StoreWC60B
    jp Jump_0A0_6771

Jump_0A0_66AF::
    ld a, [wC563]
    and a, $80
    jr z, Jump_0A0_66F4
    ld a, [wCFD5]
    ld b, a
    ld a, [wCFD7]
    cp a, b
    jr nz, Jump_0A0_66D7
    ld a, [wCFD6]
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
    ld a, [wCFD3]
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
    call StoreWC60B
    jr Jump_0A0_6771

Jump_0A0_66F4::
    ld a, [wCFD7]
    or a, a
    jr z, Jump_0A0_6735
    ld b, a
    ld a, [wC563]
    and a, $20
    jr z, Jump_0A0_6718
    ld a, [wCFD5]
    or a, a
    jr nz, Jump_0A0_670B
    ld a, b
    jr Jump_0A0_670C

Jump_0A0_670B::
    dec a

Jump_0A0_670C::
    or a, $80
    ld [wCFD5], a
    ld a, $69
    call StoreWC60B
    jr Jump_0A0_674A

Jump_0A0_6718::
    ld a, [wC563]
    and a, $10
    jr z, Jump_0A0_6735
    ld a, [wCFD5]
    cp a, b
    jr nz, Jump_0A0_6728
    xor a, a
    jr Jump_0A0_6729

Jump_0A0_6728::
    inc a

Jump_0A0_6729::
    or a, $80
    ld [wCFD5], a
    ld a, $69
    call StoreWC60B
    jr Jump_0A0_674A

Jump_0A0_6735::
    ld a, [wC5F0]
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
    ld a, [wCFD7]
    ld b, a
    ld a, [wCFD5]
    res 7, a
    cp a, b
    jr nz, Jump_0A0_6771
    ld a, [wCFD6]
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
    ld a, [wC5F0]
    and a, $F0
    ld [wC5F0], a

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
    call WriteVRAMByte
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
    call WriteVRAMByte
    pop hl
    ret

Func_0A0_67B8::
    push hl
    ld a, [wCFD4]
    ld hl, Data_0A0_67D2
    add a, l
    ld l, a
    jr nc, Jump_0A0_67C4
    inc h

Jump_0A0_67C4::
    xor a, a
    ld [wC46C], a
    ld a, [hl]
    pop hl
    ld b, $05

Jump_0A0_67CC::
    ld [hl+], a
    inc a
    dec b
    jr nz, Jump_0A0_67CC
    ret

Data_0A0_67D2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D0, $D5

Func_0A0_67D4::
    ld a, [wCFD4]
    ld hl, wD989
    swap a
    and a, $F0
    add a, l
    ld l, a
    jr nc, Jump_0A0_67E3
    inc h

Jump_0A0_67E3::
    ld a, l
    ld [wD86A], a
    ld a, h
    ld [wD86B], a
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
    ld [wCFD7], a
    ld a, c
    or a, a
    jr z, Jump_0A0_681A
    and a, $03
    dec a
    and a, $03

Jump_0A0_681A::
    ld [wCFD6], a
    xor a, a
    ld [wCFD5], a
    ret

Func_0A0_6822::
    ld a, $04
    ld [wC528], a
    ld a, [wCFD4]
    ld hl, wD989
    swap a
    and a, $F0
    add a, l
    ld l, a
    jr nc, Jump_0A0_6836
    inc h

Jump_0A0_6836::
    ld a, l
    ld [wD86A], a
    ld a, h
    ld [wD86B], a
    ld a, [wCFD5]
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
    ld a, [wCFD5]
    bit 7, a
    jr z, Jump_0A0_688D
    res 7, a
    ld [wCFD5], a
    ld hl, wC46E
    call Func_0A0_6799
    call Func_0A0_6822
    ld hl, wC46E
    set 7, [hl]

Jump_0A0_688D::
    ld a, [wC46E]
    bit 7, a
    ret z
    res 7, a
    ld [wC46E], a
    and a, $0F
    push af
    ld a, $09
    ld [wC528], a
    ld a, [wD86A]
    ld l, a
    ld a, [wD86B]
    ld h, a
    ld a, [wCFD5]
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
    ld de, wC388
    ld hl, vBGMap0 + $1F0
    ld a, [de]
    call WriteVRAMByteInc
    inc de
    ld a, [de]
    call WriteVRAMByteInc
    inc de
    ld a, [de]
    call WriteVRAMByte
    ret

Func_0A0_68CF::
    ld [wC529], a
    push hl
    ld hl, vTiles1 + $6D0
    ld de, $0901
    call Func_0A0_6CBC
    pop hl
    ret

Func_0A0_68DE::
    ld [wC529], a
    push hl
    ld hl, vTiles1 + $760
    ld de, $0901
    call Func_0A0_6CBC
    pop hl
    ret

Func_0A0_68ED::
    ld [wC529], a
    push hl
    ld hl, vTiles1 + $7F0
    ld de, $0901
    call Func_0A0_6CBC
    pop hl
    ret

Func_0A0_68FC::
    ld [wC529], a
    ld hl, vTiles2 + $80
    ld de, $0901
    call Func_0A0_6CBC
    ret

Func_0A0_6909::
    push af
    ld [wC529], a
    ld hl, vTiles1
    ld de, $0603
    call Func_0A0_6CBC
    pop af
    ld [wCFEC], a
    xor a, a
    ld [wCFED], a
    farcall Func_01A_4001
    ld a, [wCFEE]
    cp a, $FF
    jr nz, Jump_0A0_693C
    ld a, [wCFD4]
    ld hl, wD8DF
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
    call HLToDecimalDigits
    ld de, wC388
    call Func_000_2123
    ret

Func_0A0_694B::
    ld a, [wCFD7]
    or a, a
    ret z
    ld hl, vBGMap0 + $226
    ld a, $C5
    call WriteVRAMByteInc
    ld a, [wCFD5]
    and a, $07
    inc a
    add a, $E0
    call WriteVRAMByteInc
    ld a, $BE
    call WriteVRAMByteInc
    ld a, [wCFD7]
    inc a
    add a, $E0
    call WriteVRAMByteInc
    ld a, $C6
    call WriteVRAMByte
    ret

Data_0A0_6977:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C1, $01, $01, $02, $C7, $01, $07, $02

Data_0A0_697F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $41, $01, $81, $01, $C1, $01, $01, $02

Data_0A0_6987:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $81, $01, $C1, $01, $01, $02, $C1, $01, $01, $02, $C1, $01, $01, $02, $29, $00
    db $69, $00, $A9, $00, $E9, $00, $2F, $01, $6F, $01

Func_0A0_69A1::
    push af
    ld a, [wCFD4]
    ld hl, wDA43
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
    ld a, [wCFD4]
    ld hl, wDA4B
    add a, l
    ld l, a
    jr nc, Jump_0A0_69BE
    inc h

Jump_0A0_69BE::
    pop af
    ld [hl], a
    ret

Func_0A0_69C1::
    ld a, [wC46E]
    and a, $03
    ld b, a
    ld a, [wCFD5]
    and a, $01
    add a, a
    add a, a
    add a, b
    add a, a
    ld hl, wD989
    add a, l
    ld l, a
    jr nc, Jump_0A0_69D8
    inc h

Jump_0A0_69D8::
    ld a, [wCFD4]
    swap a
    add a, l
    ld l, a
    jr nc, Jump_0A0_69E2
    inc h

Jump_0A0_69E2::
    ld a, [hl]
    ld [wCFEC], a
    xor a, a
    ld [wCFED], a
    farcall Func_01A_4001
    ret

Func_0A0_69F1:: ; heuristic: follows a terminator; C0
    ld de, $0000
    ld b, $03
    ld a, [wC57F]
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
    ld a, [wC57F]
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
    farcall Func_0E0_443B
    ret

Func_0A0_6A2C::
    ld hl, vTiles1
    ld bc, $0120

Jump_0A0_6A32::
    di

Jump_0A0_6A33::
    ldh a, [rSTAT]
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
    ld hl, wD80C
    call AddAx9ToHL
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
    ld hl, Data_0A0_6B1A
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
    ld hl, Data_0A0_6B1A
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
    ld hl, Data_0A0_6B0A
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
    ld hl, Data_0A0_6B0A
    call Func_0A0_6AFD
    ld [hl], $C0
    pop hl
    ret

Func_0A0_6AC6::
    push hl
    ld hl, Data_0A0_6B12
    call Func_0A0_6AFD
    ld [hl], $C1
    pop hl
    ret

Func_0A0_6AD1::
    push hl
    ld hl, Data_0A0_6B12
    call Func_0A0_6AFD
    ld [hl], $C7
    pop hl
    ret

Func_0A0_6ADC::
    push hl
    ld hl, Data_0A0_6B16
    call Func_0A0_6AFD
    ld [hl], $C8
    pop hl
    ret

Func_0A0_6AE7::
    push hl
    ld hl, Data_0A0_6B0E
    call Func_0A0_6AFD
    ld [hl], $C9
    pop hl
    ret

Func_0A0_6AF2::
    push hl
    ld hl, Data_0A0_6B1A
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

Data_0A0_6B0A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $39, $C2, $46, $C2

Data_0A0_6B0E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $3A, $C2, $47, $C2

Data_0A0_6B12:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $3B, $C2, $48, $C2

Data_0A0_6B16:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $3C, $C2, $49, $C2

Data_0A0_6B1A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $3D, $C2, $4A, $C2

Func_0A0_6B1E::
    ld a, c
    cp a, $03
    jr nc, Jump_0A0_6B45
    ld hl, Data_0A0_6D53
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
    ld de, wC198
    add hl, de
    pop de
    push hl
    ld hl, vBGMap0
    add hl, de
    pop de
    ld b, $05

Jump_0A0_6B3D::
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, Jump_0A0_6B3D

Jump_0A0_6B45::
    ret

Func_0A0_6B46::
    push bc
    ld a, c
    cp a, $03
    jr nc, Jump_0A0_6B77
    ld hl, wD8BF
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
    call HLToDecimalDigits
    pop bc
    ld a, c
    and a, $03
    push hl
    ld hl, Data_0A0_6D47
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A0_6B6A
    inc h

Jump_0A0_6B6A::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, wC198
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
    ld hl, wD8DF
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
    call HLToDecimalDigits
    pop bc
    ld a, c
    and a, $03
    push hl
    ld hl, Data_0A0_6D4B
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A0_6BA4
    inc h

Jump_0A0_6BA4::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, wC198
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
    ld hl, Data_0A0_6D4F
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A0_6BCB
    inc h

Jump_0A0_6BCB::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, wC198
    add hl, de
    ld [hl], $EA
    inc hl
    ld [hl], $AF
    inc hl
    push hl
    ld a, c
    ld hl, wD8B7
    add a, l
    ld l, a
    jr nc, Jump_0A0_6BE2
    inc h

Jump_0A0_6BE2::
    ld l, [hl]
    ld h, $00
    push bc
    call HLToDecimalDigits
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
    ld hl, Data_0A0_6D47
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
    ld de, wC198
    add hl, de
    pop de
    push hl
    ld hl, vBGMap0
    add hl, de
    pop de
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    ld a, [de]
    call WriteVRAMByte

Jump_0A0_6C21::
    ret

Func_0A0_6C22::
    ld a, c
    cp a, $04
    jr nc, Jump_0A0_6C53
    and a, $03
    cp a, $03
    jr z, Jump_0A0_6C53
    ld hl, Data_0A0_6D4B
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
    ld de, wC198
    add hl, de
    pop de
    push hl
    ld hl, vBGMap0
    add hl, de
    pop de
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    ld a, [de]
    call WriteVRAMByte

Jump_0A0_6C53::
    ret

Func_0A0_6C54:: ; heuristic: follows a terminator; C0
    ld a, c
    cp a, $04
    jr nc, Jump_0A0_6C80
    and a, $03
    cp a, $03
    jr z, Jump_0A0_6C80
    ld hl, Data_0A0_6D4F
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
    ld de, wC198
    add hl, de
    pop de
    push hl
    ld hl, vBGMap0
    add hl, de
    pop de
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    ld a, [de]
    call WriteVRAMByte

Jump_0A0_6C80::
    ret

Func_0A0_6C81::
    ld a, [wC52D]
    ld c, a
    ld a, [wC52E]
    ld b, a
    push bc
    ld a, [wC52F]
    ld c, a
    ld a, [wC530]
    ld b, a
    push bc
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld a, e
    ld [wC52F], a
    ld a, d
    ld [wC530], a
    farcall Func_009_400F
    pop de
    pop hl
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld a, e
    ld [wC52F], a
    ld a, d
    ld [wC530], a
    ret

Func_0A0_6CBC::
    ld a, [wC52D]
    ld c, a
    ld a, [wC52E]
    ld b, a
    push bc
    ld a, [wC52F]
    ld c, a
    ld a, [wC530]
    ld b, a
    push bc
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld a, e
    ld [wC52F], a
    ld a, d
    ld [wC530], a
    farcall Func_008_402B
    pop de
    pop hl
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld a, e
    ld [wC52F], a
    ld a, d
    ld [wC530], a
    ret
    INCBIN "dwm2-cobi-us.gbc", $282CF7, $50

Data_0A0_6D47:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $62, $00, $6F, $00

Data_0A0_6D4B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $82, $00, $8F, $00

Data_0A0_6D4F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A1, $00, $AE, $00

Data_0A0_6D53:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A1, $00, $AE, $00

Data_0A0_6D57:: ; heuristic: pointer load in the same bank (bank assumed); C0
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
    ds $B06, $00

Data_0A0_7C1E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $1DD, $00

Data_0A0_7DFB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $205, $00
