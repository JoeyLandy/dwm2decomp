SECTION "Bank 16", ROMX[$4000], BANK[$16]
    db $16

Data_016_4001:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $F0, $C6, $CD, $92, $4A, $C9

Func_016_4007::
    ld de, $D084
    push de
    ld a, [$D081]
    ld c, $0D
    call Func_000_1682
    ld a, l
    add a, $C2
    ld l, a
    ld a, h
    adc a, $4C
    ld h, a
    pop de
    ld b, $0D

Jump_016_401E::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_016_401E
    ret

Func_016_4025::
    ld a, [$D081]
    cp a, $FF
    ret z
    ld a, [$D081]
    rst $00
    dw Jump_016_40F5
    dw Func_016_40F6
    dw Func_016_40F6
    dw Func_016_4118
    dw Func_016_41FD
    dw Func_016_41FD
    dw Func_016_421F
    dw Jump_016_4234
    dw Jump_016_4249
    dw Jump_016_4301
    dw Jump_016_4316
    dw Func_016_4118
    dw Func_016_432B
    dw Jump_016_433C
    dw Jump_016_4352
    dw Jump_016_4368
    dw Jump_016_437E
    dw Jump_016_4394
    dw Jump_016_43AA
    dw Jump_016_43C0
    dw Jump_016_43D6
    dw Jump_016_43EB
    dw Jump_016_4401
    dw Jump_016_4416
    dw Jump_016_442C
    dw Jump_016_4441
    dw Jump_016_4441
    dw Jump_016_4441
    dw Jump_016_4441
    dw Jump_016_4441
    dw Jump_016_4441
    dw Jump_016_4446
    dw Func_016_4447
    dw Func_016_4447
    dw Jump_016_4453
    dw Jump_016_4453
    dw Jump_016_4453
    dw Jump_016_4453
    dw Jump_016_4453
    dw Jump_016_4453
    dw Func_016_4454
    dw Func_016_44AD
    dw Func_016_44D0
    dw Jump_016_4453
    dw Jump_016_44F9
    dw Jump_016_44F9
    dw Jump_016_4458
    dw Jump_016_44FA
    dw Jump_016_44FB
    dw Jump_016_4548
    dw Jump_016_4583
    dw Jump_016_45C2
    dw Jump_016_45C3
    dw Jump_016_45FA
    dw Func_016_44AD
    dw Jump_016_462C
    dw Jump_016_462C
    dw Jump_016_462D
    dw Jump_016_462D
    dw Jump_016_462D
    dw Jump_016_462D
    dw Jump_016_462D
    dw Jump_016_462E
    dw Jump_016_462E
    dw Jump_016_462F
    dw Jump_016_462F
    dw Jump_016_462F
    dw Jump_016_462F
    dw Jump_016_462F
    dw Jump_016_462F
    dw Jump_016_462F
    dw Jump_016_462F
    dw Jump_016_462F
    dw Jump_016_462F
    dw Jump_016_462F
    dw Jump_016_462F
    dw Jump_016_462F
    dw Jump_016_462F
    dw Jump_016_462F
    dw Jump_016_462F
    dw Jump_016_462F
    dw Jump_016_462F
    dw Jump_016_462F
    dw Jump_016_462F
    dw Jump_016_462F
    dw Jump_016_462F
    dw Jump_016_462F
    dw Jump_016_462F
    dw Jump_016_462F
    dw Jump_016_462F
    dw Jump_016_462F
    dw Jump_016_462F
    dw Jump_016_462F
    dw Jump_016_462F
    dw Jump_016_462F
    dw Jump_016_462F
    dw Jump_016_462F
    dw Jump_016_462F
    dw Jump_016_462F

Jump_016_40F5::
    ret

Func_016_40F6::
    call Func_016_4633
    ret nz
    ld a, [$D083]
    ld c, $5B
    call Func_000_1F49
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    inc hl
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    ld a, h
    or a, l
    ret nz
    ld a, $FF
    ld [$D081], a
    ret

Func_016_4118::
    ld a, [$C6FD]
    or a, a
    jr z, Jump_016_4195
    ld a, $00
    ld c, $55
    call Func_000_1F49
    bit 7, [hl]
    jr nz, Jump_016_4141
    ld a, $00
    ld c, $5B
    call Func_000_1F49
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    inc hl
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    ld a, h
    or a, l
    jr nz, Jump_016_419B

Jump_016_4141::
    ld a, [$C6FD]
    cp a, $01
    jr z, Jump_016_4195
    ld a, $01
    ld c, $55
    call Func_000_1F49
    bit 7, [hl]
    jr nz, Jump_016_416B
    ld a, $01
    ld c, $5B
    call Func_000_1F49
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    inc hl
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    ld a, h
    or a, l
    jr nz, Jump_016_419B

Jump_016_416B::
    ld a, [$C6FD]
    cp a, $02
    jr z, Jump_016_4195
    ld a, $02
    ld c, $55
    call Func_000_1F49
    bit 7, [hl]
    jr nz, Jump_016_4195
    ld a, $02
    ld c, $5B
    call Func_000_1F49
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    inc hl
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    ld a, h
    or a, l
    jr nz, Jump_016_419B

Jump_016_4195::
    ld a, $FF
    ld [$D081], a
    ret

Jump_016_419B::
    ld d, $00
    ld a, $00
    call Func_016_41B3
    ld a, $01
    call Func_016_41B3
    ld a, $02
    call Func_016_41B3
    ld a, $27
    add a, d
    ld [$D08E], a
    ret

Func_016_41B3::
    ld [$D083], a
    ld hl, $C6FD
    cp a, [hl]
    ret nc
    push de
    ld c, $55
    call Func_000_1F49
    bit 7, [hl]
    pop de
    ret nz
    push de
    ld a, [$D083]
    ld c, $5B
    call Func_000_1F49
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    inc hl
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    pop de
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    ld a, h
    or a, l
    ret z
    push de
    ld a, d
    swap a
    ld hl, $C160
    add a, l
    ld l, a
    jr nc, Jump_016_41EB
    inc h

Jump_016_41EB::
    push hl
    ld a, [$D083]
    ld c, $01
    call Func_000_1F49
    ld e, l
    ld d, h
    pop hl
    call Func_000_2FE1
    pop de
    inc d
    ret

Func_016_41FD::
    call Func_016_4633
    ret nz
    ld a, [$D083]
    ld c, $5F
    call Func_000_1F49
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    inc hl
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    ld a, h
    or a, l
    ret nz
    ld a, $FF
    ld [$D081], a
    ret

Func_016_421F::
    call Func_016_4633
    ret nz
    ld a, [$D083]
    ld c, $55
    call Func_000_1F49
    bit 2, [hl]
    ret nz
    ld a, $FF
    ld [$D081], a
    ret

Jump_016_4234::
    call Func_016_4633
    ret nz
    ld a, [$D083]
    ld c, $55
    call Func_000_1F49
    bit 3, [hl]
    ret nz
    ld a, $FF
    ld [$D081], a
    ret

Jump_016_4249::
    call Func_016_4633
    ret nz
    ld a, [$D083]
    ld c, $55
    call Func_000_1F49
    bit 0, [hl]
    ret nz
    ld a, $FF
    ld [$D081], a
    ret

Func_016_425E::
    ld a, [$C6FD]
    and a, a
    jr z, Jump_016_42A6
    xor a, a
    call Func_016_4636
    jr nz, Jump_016_4274
    xor a, a
    ld c, $55
    call Func_000_1F49
    bit 0, [hl]
    jr nz, Jump_016_42AC

Jump_016_4274::
    ld a, [$C6FD]
    cp a, $02
    jr c, Jump_016_42A6
    ld a, $01
    call Func_016_4636
    jr nz, Jump_016_428D
    ld a, $01
    ld c, $55
    call Func_000_1F49
    bit 0, [hl]
    jr nz, Jump_016_42AC

Jump_016_428D::
    ld a, [$C6FD]
    cp a, $03
    jr c, Jump_016_42A6
    ld a, $02
    call Func_016_4636
    jr nz, Jump_016_42A6
    ld a, $02
    ld c, $55
    call Func_000_1F49
    bit 0, [hl]
    jr nz, Jump_016_42AC

Jump_016_42A6::
    ld a, $FF
    ld [$D081], a
    ret

Jump_016_42AC::
    ld d, $00
    ld a, $00
    call Func_016_42C4
    ld a, $01
    call Func_016_42C4
    ld a, $02
    call Func_016_42C4
    ld a, $32
    add a, d
    ld [$D08E], a
    ret

Func_016_42C4::
    ld [$D083], a
    ld hl, $C6FD
    cp a, [hl]
    ret nc
    push de
    ld c, $55
    call Func_000_1F49
    bit 7, [hl]
    pop de
    ret nz
    push de
    ld a, [$D083]
    ld c, $55
    call Func_000_1F49
    bit 0, [hl]
    pop de
    ret z
    push de
    ld a, d
    swap a
    ld hl, $C160
    add a, l
    ld l, a
    jr nc, Jump_016_42EF
    inc h

Jump_016_42EF::
    push hl
    ld a, [$D083]
    ld c, $01
    call Func_000_1F49
    ld e, l
    ld d, h
    pop hl
    call Func_000_2FE1
    pop de
    inc d
    ret

Jump_016_4301::
    call Func_016_4633
    ret nz
    ld a, [$D083]
    ld c, $55
    call Func_000_1F49
    bit 1, [hl]
    ret nz
    ld a, $FF
    ld [$D081], a
    ret

Jump_016_4316::
    call Func_016_4633
    ret nz
    ld a, [$D083]
    ld c, $55
    call Func_000_1F49
    bit 4, [hl]
    ret nz
    ld a, $FF
    ld [$D081], a
    ret

Func_016_432B::
    ld a, [$D083]
    ld c, $55
    call Func_000_1F49
    bit 7, [hl]
    ret nz
    ld a, $FF
    ld [$D081], a
    ret

Jump_016_433C::
    call Func_016_4633
    ret nz
    ld a, [$D083]
    ld c, $63
    call Func_000_1F49
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld hl, $03E7
    call Func_016_466A
    ret

Jump_016_4352::
    call Func_016_4633
    ret nz
    ld a, [$D083]
    ld c, $65
    call Func_000_1F49
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld hl, $03E7
    call Func_016_466A
    ret

Jump_016_4368::
    call Func_016_4633
    ret nz
    ld a, [$D083]
    ld c, $67
    call Func_000_1F49
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld hl, $03E7
    call Func_016_466A
    ret

Jump_016_437E::
    call Func_016_4633
    ret nz
    ld a, [$D083]
    ld c, $69
    call Func_000_1F49
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld hl, $03E7
    call Func_016_466A
    ret

Jump_016_4394::
    call Func_016_4633
    ret nz
    ld a, [$D083]
    ld c, $5D
    call Func_000_1F49
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld hl, $03E7
    call Func_016_466A
    ret

Jump_016_43AA::
    call Func_016_4633
    ret nz
    ld a, [$D083]
    ld c, $61
    call Func_000_1F49
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld hl, $03E7
    call Func_016_466A
    ret

Jump_016_43C0::
    call Func_016_4633
    ret nz
    ld a, [$D083]
    ld c, $6F
    call Func_000_1F49
    ld a, [hl]
    cp a, $FF
    ret nz
    ld a, $FF
    ld [$D081], a
    ret

Jump_016_43D6::
    call Func_016_4633
    ret nz
    ld a, [$D083]
    ld c, $6F
    call Func_000_1F49
    ld a, [hl]
    or a, a
    ret nz
    ld a, $FF
    ld [$D081], a
    ret

Jump_016_43EB::
    call Func_016_4633
    ret nz
    ld a, [$D083]
    ld c, $70
    call Func_000_1F49
    ld a, [hl]
    cp a, $FF
    ret nz
    ld a, $FF
    ld [$D081], a
    ret

Jump_016_4401::
    call Func_016_4633
    ret nz
    ld a, [$D083]
    ld c, $70
    call Func_000_1F49
    ld a, [hl]
    or a, a
    ret nz
    ld a, $FF
    ld [$D081], a
    ret

Jump_016_4416::
    call Func_016_4633
    ret nz
    ld a, [$D083]
    ld c, $72
    call Func_000_1F49
    ld a, [hl]
    cp a, $FF
    ret nz
    ld a, $FF
    ld [$D081], a
    ret

Jump_016_442C::
    call Func_016_4633
    ret nz
    ld a, [$D083]
    ld c, $72
    call Func_000_1F49
    ld a, [hl]
    or a, a
    ret nz
    ld a, $FF
    ld [$D081], a
    ret

Jump_016_4441::
    call Func_016_4633
    ret nz
    ret

Jump_016_4446::
    ret

Func_016_4447::
    ld a, [$C901]
    and a, $7F
    ret nz
    ld a, $FF
    ld [$D081], a
    ret

Jump_016_4453::
    ret

Func_016_4454::
    call Func_016_44AD
    ret

Jump_016_4458::
    ld a, [$CC44]
    bit 7, a
    jr z, Jump_016_4469
    cp a, $80
    jr z, Jump_016_449D
    ld a, $FF
    ld [$D081], a
    ret

Jump_016_4469::
    ldh a, [$FF90]
    cp a, $20
    jr z, Jump_016_449D
    cp a, $30
    jr z, Jump_016_449D
    cp a, $48
    jr z, Jump_016_449D
    cp a, $70
    jr z, Jump_016_449D
    cp a, $A0
    jr z, Jump_016_449D
    cp a, $A8
    jr z, Jump_016_449D
    cp a, $B0
    jr z, Jump_016_449D
    cp a, $B8
    jr z, Jump_016_449D
    cp a, $C8
    jr z, Jump_016_449D
    cp a, $D1
    jr z, Jump_016_449D
    cp a, $DA
    jr z, Jump_016_449D
    ld a, $FF
    ld [$D081], a
    ret

Jump_016_449D::
    ld hl, $47C2
    ld b, $84
    rst $10
    ldh a, [$FFD0]
    or a, a
    ret nz
    ld a, $FE
    ld [$D081], a
    ret

Func_016_44AD::
    ld a, [$CC44]
    bit 7, a
    jr z, Jump_016_44BD
    cp a, $80
    ret z
    ld a, $FF
    ld [$D081], a
    ret

Jump_016_44BD::
    ldh a, [$FF90]
    ld hl, Data_016_51C9
    add a, l
    ld l, a
    jr nc, Jump_016_44C7
    inc h

Jump_016_44C7::
    bit 6, [hl]
    ret nz
    ld a, $FF
    ld [$D081], a
    ret

Func_016_44D0::
    ld a, [$CC44]
    bit 7, a
    jr z, Jump_016_44E6
    cp a, $81
    ret z
    cp a, $85
    ret z
    cp a, $86
    ret z
    ld a, $FF
    ld [$D081], a
    ret

Jump_016_44E6::
    ldh a, [$FF90]
    ld hl, Data_016_51C9
    add a, l
    ld l, a
    jr nc, Jump_016_44F0
    inc h

Jump_016_44F0::
    bit 5, [hl]
    ret nz
    ld a, $FF
    ld [$D081], a
    ret

Jump_016_44F9::
    ret

Jump_016_44FA::
    ret

Jump_016_44FB::
    ld a, [$CC44]
    bit 7, a
    jr nz, Jump_016_4542
    ldh a, [$FF90]
    cp a, $2F
    jr nz, Jump_016_4542
    ldh a, [$FF8F]
    cp a, $00
    jr nz, Jump_016_4542
    ldh a, [$FF92]
    cp a, $01
    jr nz, Jump_016_4542
    ldh a, [$FF8E]
    cp a, $40
    jr nz, Jump_016_4528
    ldh a, [$FF91]
    cp a, $30
    jr nz, Jump_016_4542
    ldh a, [$FF98]
    cp a, $01
    jr nz, Jump_016_4542
    jr Jump_016_4538

Jump_016_4528::
    cp a, $50
    jr nz, Jump_016_4542
    ldh a, [$FF91]
    cp a, $40
    jr nz, Jump_016_4542
    ldh a, [$FF98]
    cp a, $02
    jr nz, Jump_016_4542

Jump_016_4538::
    ld de, $0058
    call Func_000_181B
    jr c, Jump_016_4542
    jr Jump_016_4547

Jump_016_4542::
    ld a, $FF
    ld [$D081], a

Jump_016_4547::
    ret

Jump_016_4548::
    ld a, [$CC44]
    bit 7, a
    jr nz, Jump_016_457D
    ldh a, [$FF90]
    cp a, $40
    jr nz, Jump_016_457D
    ldh a, [$FF8F]
    ld b, a
    ldh a, [$FF92]
    or a, b
    jr nz, Jump_016_457D
    ldh a, [$FF91]
    cp a, $40
    jr nz, Jump_016_457D
    ldh a, [$FF98]
    cp a, $02
    jr nz, Jump_016_457D
    ldh a, [$FF8E]
    cp a, $40
    jr c, Jump_016_457D
    cp a, $51
    jr nc, Jump_016_457D
    ld de, $007A
    call Func_000_181B
    jr c, Jump_016_457D
    jr Jump_016_4582

Jump_016_457D::
    ld a, $FF
    ld [$D081], a

Jump_016_4582::
    ret

Jump_016_4583::
    ld a, [$CC44]
    bit 7, a
    jr nz, Jump_016_45BC
    ldh a, [$FF90]
    cp a, $49
    jr nz, Jump_016_45BC
    ldh a, [$FF8F]
    ld b, a
    ldh a, [$FF92]
    or a, b
    jr nz, Jump_016_45BC
    ldh a, [$FF8E]
    cp a, $40
    jr nz, Jump_016_45BC
    ldh a, [$FF91]
    cp a, $40
    jr nz, Jump_016_45BC
    ldh a, [$FF98]
    cp a, $02
    jr nz, Jump_016_45BC
    ld de, $01E4
    call Func_000_181B
    jr nc, Jump_016_45BC
    ld de, $01E5
    call Func_000_181B
    jr c, Jump_016_45BC
    jr Jump_016_45C1

Jump_016_45BC::
    ld a, $FF
    ld [$D081], a

Jump_016_45C1::
    ret

Jump_016_45C2::
    ret

Jump_016_45C3::
    ld a, [$CC44]
    bit 7, a
    jr nz, Jump_016_45F4
    ldh a, [$FF90]
    cp a, $61
    jr nz, Jump_016_45F4
    ldh a, [$FF8F]
    ld b, a
    ldh a, [$FF92]
    or a, b
    jr nz, Jump_016_45F4
    ldh a, [$FF8E]
    cp a, $40
    jr nz, Jump_016_45F4
    ldh a, [$FF91]
    cp a, $40
    jr nz, Jump_016_45F4
    ldh a, [$FF98]
    cp a, $02
    jr nz, Jump_016_45F4
    ld de, $01E1
    call Func_000_181B
    jr c, Jump_016_45F4
    jr Jump_016_45F9

Jump_016_45F4::
    ld a, $FF
    ld [$D081], a

Jump_016_45F9::
    ret

Jump_016_45FA::
    ld a, [$CC44]
    bit 7, a
    jr nz, Jump_016_4626
    ldh a, [$FF90]
    cp a, $70
    jr c, Jump_016_4626
    cp a, $A0
    jr nc, Jump_016_4626
    cp a, $76
    jr z, Jump_016_4626
    cp a, $9B
    jr z, Jump_016_4626
    cp a, $9A
    jr z, Jump_016_4626
    cp a, $7A
    jr nz, Jump_016_4621
    ldh a, [$FF92]
    cp a, $01
    jr z, Jump_016_4626

Jump_016_4621::
    ld a, [$CB7E]
    or a, a
    ret nz

Jump_016_4626::
    ld a, $FF
    ld [$D081], a
    ret

Jump_016_462C::
    ret

Jump_016_462D::
    ret

Jump_016_462E::
    ret

Jump_016_462F::
    call Func_016_4633
    ret

Func_016_4633::
    ld a, [$D083]

Func_016_4636::
    ld c, $55
    call Func_000_1F49
    bit 7, [hl]
    ret z
    ld a, $FF
    ld [$D081], a
    or a, a
    ret

Func_016_4645::
    ld a, [$CC44]
    bit 7, a
    jr z, Jump_016_4655
    ld a, [$C901]
    and a, $7F
    jr nz, Jump_016_4667
    jr Jump_016_4663

Jump_016_4655::
    ldh a, [$FF90]
    ld hl, Data_016_51C9
    add a, l
    ld l, a
    jr nc, Jump_016_465F
    inc h

Jump_016_465F::
    bit 4, [hl]
    jr z, Jump_016_4667

Jump_016_4663::
    ld c, $00
    jr Jump_016_4669

Jump_016_4667::
    ld c, $01

Jump_016_4669::
    ret

Func_016_466A::
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    ld a, h
    or a, l
    jr z, Jump_016_4688
    ld a, h
    or a, a
    ld a, [$D08F]
    jr nz, Jump_016_4681
    cp a, l
    jr z, Jump_016_4681
    jr c, Jump_016_4681
    ld a, l

Jump_016_4681::
    ld hl, $C160
    call Func_000_2EAC
    ret

Jump_016_4688::
    ld a, $FF
    ld [$D081], a
    ret

Func_016_468E::
    ld a, [$D081]
    cp a, $FF
    ret z
    ld a, [$D081]
    rst $00
    dw Jump_016_475E
    dw Jump_016_475F
    dw Jump_016_475F
    dw Jump_016_477D
    dw Jump_016_47B0
    dw Jump_016_47CE
    dw Jump_016_47E5
    dw Jump_016_47F3
    dw Jump_016_4801
    dw Jump_016_480F
    dw Jump_016_481D
    dw Jump_016_482B
    dw Jump_016_482C
    dw Jump_016_4852
    dw Jump_016_4862
    dw Jump_016_4872
    dw Jump_016_4882
    dw Jump_016_4892
    dw Jump_016_48A2
    dw Jump_016_48B2
    dw Jump_016_48C2
    dw Jump_016_48D2
    dw Jump_016_48E2
    dw Jump_016_48F2
    dw Jump_016_4902
    dw Jump_016_4912
    dw Jump_016_4912
    dw Jump_016_4912
    dw Jump_016_4912
    dw Jump_016_4922
    dw Jump_016_493C
    dw Jump_016_493D
    dw Jump_016_493E
    dw Jump_016_4947
    dw Jump_016_4950
    dw Jump_016_4950
    dw Jump_016_4950
    dw Jump_016_4950
    dw Jump_016_4950
    dw Jump_016_4950
    dw Jump_016_4951
    dw Jump_016_495A
    dw Jump_016_4963
    dw Jump_016_496C
    dw Jump_016_4970
    dw Jump_016_4970
    dw Jump_016_4971
    dw Jump_016_497A
    dw Jump_016_497B
    dw Jump_016_4981
    dw Jump_016_4987
    dw Jump_016_498D
    dw Jump_016_498E
    dw Jump_016_4994
    dw Jump_016_499A
    dw Jump_016_49AD
    dw Jump_016_49AD
    dw Jump_016_49AD
    dw Jump_016_49AD
    dw Jump_016_49AD
    dw Jump_016_49AD
    dw Jump_016_49AD
    dw Jump_016_49AE
    dw Jump_016_49AE
    dw Jump_016_49AF
    dw Jump_016_49BA
    dw Jump_016_49C5
    dw Jump_016_49D0
    dw Jump_016_49DB
    dw Jump_016_49E6
    dw Jump_016_49F1
    dw Jump_016_49FC
    dw Jump_016_4A07
    dw Jump_016_4A12
    dw Jump_016_4A1D
    dw Jump_016_4A28
    dw Jump_016_4A33
    dw Jump_016_4A33
    dw Jump_016_4A33
    dw Jump_016_4A33
    dw Jump_016_4A33
    dw Jump_016_4A33
    dw Jump_016_4A33
    dw Jump_016_4A37
    dw Jump_016_4A42
    dw Jump_016_4A42
    dw Jump_016_4A42
    dw Jump_016_4A42
    dw Jump_016_4A42
    dw Jump_016_4A42
    dw Jump_016_4A43
    dw Jump_016_4A43
    dw Jump_016_4A43
    dw Jump_016_4A43
    dw Jump_016_4A43
    dw Jump_016_4A43
    dw Jump_016_4A43
    dw Jump_016_4A43
    dw Jump_016_4A47

Jump_016_475E::
    ret

Jump_016_475F::
    call Func_000_095B
    ld a, [$C5E7]
    ld b, a
    ld a, $0B
    call Func_000_16BF
    ld b, a
    ld a, [$D08F]
    add a, b
    ld l, a
    ld h, $00
    ld a, [$D083]
    call Func_016_57D1
    call Func_016_4C1D
    ret

Jump_016_477D::
    ld a, $00
    call Func_016_4790
    ld a, $01
    call Func_016_4790
    ld a, $02
    call Func_016_4790
    call Func_016_4C1D
    ret

Func_016_4790::
    ld hl, $C6FD
    cp a, [hl]
    ret nc
    ld [$D083], a
    call Func_016_4633
    ret nz
    ld a, [$D083]
    ld c, $5D
    call Func_000_1F49
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, [$D083]
    ld c, $5B
    call Func_016_58FD
    ret

Jump_016_47B0::
    call Func_000_095B
    ld a, [$C5E7]
    ld b, a
    ld a, $0B
    call Func_000_16BF
    ld b, a
    ld a, [$D08F]
    add a, b
    ld l, a
    ld h, $00
    ld a, [$D083]
    call Func_016_57E8
    call Func_016_4C1D
    ret

Jump_016_47CE::
    ld a, [$D083]
    ld c, $61
    call Func_000_1F49
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, [$D083]
    ld c, $5F
    call Func_016_58FD
    call Func_016_4C1D
    ret

Jump_016_47E5::
    ld a, [$D083]
    ld c, $55
    call Func_000_1F49
    res 2, [hl]
    call Func_016_4C1D
    ret

Jump_016_47F3::
    ld a, [$D083]
    ld c, $55
    call Func_000_1F49
    res 3, [hl]
    call Func_016_4C1D
    ret

Jump_016_4801::
    ld a, [$D083]
    ld c, $55
    call Func_000_1F49
    res 0, [hl]
    call Func_016_4C1D
    ret

Jump_016_480F::
    ld a, [$D083]
    ld c, $55
    call Func_000_1F49
    res 1, [hl]
    call Func_016_4C1D
    ret

Jump_016_481D::
    ld a, [$D083]
    ld c, $55
    call Func_000_1F49
    res 4, [hl]
    call Func_016_4C1D
    ret

Jump_016_482B::
    ret

Jump_016_482C::
    ld a, [$D083]
    ld c, $55
    call Func_000_1F49
    ld [hl], $00
    ld a, [$D083]
    ld c, $5D
    call Func_000_1F49
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, [$D083]
    ld c, $5B
    call Func_016_58FD
    ld a, $01
    ld [$D095], a
    call Func_016_4C1D
    ret

Jump_016_4852::
    ld a, [$D08F]
    ld l, a
    ld h, $00
    ld a, [$D083]
    call Func_016_57FF
    call Func_016_4C1D
    ret

Jump_016_4862::
    ld a, [$D08F]
    ld l, a
    ld h, $00
    ld a, [$D083]
    call Func_016_580B
    call Func_016_4C1D
    ret

Jump_016_4872::
    ld a, [$D08F]
    ld l, a
    ld h, $00
    ld a, [$D083]
    call Func_016_5817
    call Func_016_4C1D
    ret

Jump_016_4882::
    ld a, [$D08F]
    ld l, a
    ld h, $00
    ld a, [$D083]
    call Func_016_5823
    call Func_016_4C1D
    ret

Jump_016_4892::
    ld a, [$D08F]
    ld l, a
    ld h, $00
    ld a, [$D083]
    call Func_016_582F
    call Func_016_4C1D
    ret

Jump_016_48A2::
    ld a, [$D08F]
    ld l, a
    ld h, $00
    ld a, [$D083]
    call Func_016_583B
    call Func_016_4C1D
    ret

Jump_016_48B2::
    ld a, [$D08F]
    ld l, a
    ld h, $00
    ld a, [$D083]
    call Func_016_5847
    call Func_016_4C1D
    ret

Jump_016_48C2::
    ld a, [$D08F]
    ld l, a
    ld h, $00
    ld a, [$D083]
    call Func_016_5852
    call Func_016_4C1D
    ret

Jump_016_48D2::
    ld a, [$D08F]
    ld l, a
    ld h, $00
    ld a, [$D083]
    call Func_016_585D
    call Func_016_4C1D
    ret

Jump_016_48E2::
    ld a, [$D08F]
    ld l, a
    ld h, $00
    ld a, [$D083]
    call Func_016_5868
    call Func_016_4C1D
    ret

Jump_016_48F2::
    ld a, [$D08F]
    ld l, a
    ld h, $00
    ld a, [$D083]
    call Func_016_5873
    call Func_016_4C1D
    ret

Jump_016_4902::
    ld a, [$D08F]
    ld l, a
    ld h, $00
    ld a, [$D083]
    call Func_016_587E
    call Func_016_4C1D
    ret

Jump_016_4912::
    ld a, [$D08F]
    ld l, a
    ld h, $00
    ld a, [$D083]
    call Func_016_5889
    call Func_016_4C1D
    ret

Jump_016_4922::
    ld a, [$D08F]
    ld l, a
    ld h, $00
    ld a, [$D083]
    call Func_016_5889
    ld a, [$D083]
    ld c, $55
    call Func_000_1F49
    set 2, [hl]
    call Func_016_4C1D
    ret

Jump_016_493C::
    ret

Jump_016_493D::
    ret

Jump_016_493E::
    ld a, $C8
    ld [$D091], a
    call Func_016_4C1D
    ret

Jump_016_4947::
    ld a, $01
    ld [$D067], a
    call Func_016_4C1D
    ret

Jump_016_4950::
    ret

Jump_016_4951::
    ld a, $02
    ld [$D067], a
    call Func_016_4C1D
    ret

Jump_016_495A::
    ld a, $03
    ld [$D067], a
    call Func_016_4C1D
    ret

Jump_016_4963::
    ld a, $04
    ld [$D067], a
    call Func_016_4C1D
    ret

Jump_016_496C::
    call Func_016_4C1D
    ret

Jump_016_4970::
    ret

Jump_016_4971::
    ld a, $09
    ld [$D067], a
    call Func_016_4C1D
    ret

Jump_016_497A::
    ret

Jump_016_497B::
    ld a, $05
    ld [$D067], a
    ret

Jump_016_4981::
    ld a, $06
    ld [$D067], a
    ret

Jump_016_4987::
    ld a, $07
    ld [$D067], a
    ret

Jump_016_498D::
    ret

Jump_016_498E::
    ld a, $08
    ld [$D067], a
    ret

Jump_016_4994::
    ld a, $0A
    ld [$D067], a
    ret

Jump_016_499A::
    ld a, [$C832]
    add a, $32
    jr nc, Jump_016_49A3
    ld a, $FF

Jump_016_49A3::
    cp a, $F0
    jr c, Jump_016_49A9
    ld a, $F0

Jump_016_49A9::
    ld [$C832], a
    ret

Jump_016_49AD::
    ret

Jump_016_49AE::
    ret

Jump_016_49AF::
    ld a, $1E
    ld c, $5D
    call Func_016_4B68
    call Func_016_4A48
    ret

Jump_016_49BA::
    ld a, $50
    ld c, $5D
    call Func_016_4B68
    call Func_016_4A48
    ret

Jump_016_49C5::
    ld a, $1E
    ld c, $61
    call Func_016_4B68
    call Func_016_4A48
    ret

Jump_016_49D0::
    ld a, $50
    ld c, $61
    call Func_016_4B68
    call Func_016_4A48
    ret

Jump_016_49DB::
    ld a, $0A
    ld c, $63
    call Func_016_4B4D
    call Func_016_4A48
    ret

Jump_016_49E6::
    ld a, $32
    ld c, $63
    call Func_016_4B4D
    call Func_016_4A48
    ret

Jump_016_49F1::
    ld a, $0A
    ld c, $65
    call Func_016_4B4D
    call Func_016_4A48
    ret

Jump_016_49FC::
    ld a, $32
    ld c, $65
    call Func_016_4B4D
    call Func_016_4A48
    ret

Jump_016_4A07::
    ld a, $0A
    ld c, $67
    call Func_016_4B4D
    call Func_016_4A48
    ret

Jump_016_4A12::
    ld a, $32
    ld c, $67
    call Func_016_4B4D
    call Func_016_4A48
    ret

Jump_016_4A1D::
    ld a, $32
    ld c, $69
    call Func_016_4B4D
    call Func_016_4A48
    ret

Jump_016_4A28::
    ld a, $64
    ld c, $69
    call Func_016_4B4D
    call Func_016_4A48
    ret

Jump_016_4A33::
    call Func_016_4A48
    ret

Jump_016_4A37::
    ld a, $05
    ld c, $65
    call Func_016_4B4D
    call Func_016_4A48
    ret

Jump_016_4A42::
    ret

Jump_016_4A43::
    call Func_016_4A48
    ret

Jump_016_4A47::
    ret

Func_016_4A48::
    ld a, [$D083]
    ld c, $A4
    call Func_000_1F49
    ld a, [hl]
    or a, a
    jr nz, Jump_016_4A61
    ld a, [$D081]
    sub a, $3F
    ld [hl], a
    call Func_016_4C1D
    xor a, a
    ldh [$FFC6], a
    ret

Jump_016_4A61::
    push af
    ld a, [$D081]
    sub a, $3F
    ld [hl], a
    ld a, $FF
    ld [$D081], a
    ld a, [$D082]
    ld hl, $C61D
    add a, l
    ld l, a
    jr nc, Jump_016_4A78
    inc h

Jump_016_4A78::
    pop af
    add a, $3F
    ld [hl], a
    push af
    call Func_016_4C48
    pop af
    call Func_016_4A92
    ld l, a
    ld h, $05
    ld de, $C160
    call Func_000_2E81
    ld a, $01
    ldh [$FFC6], a
    ret

Func_016_4A92::
    push af
    call Func_016_4A98
    pop af
    ret

Func_016_4A98::
    sub a, $40
    rst $00
    dw Jump_016_4AE1
    dw Jump_016_4AE9
    dw Jump_016_4AF1
    dw Jump_016_4AF9
    dw Jump_016_4B01
    dw Jump_016_4B09
    dw Jump_016_4B11
    dw Jump_016_4B19
    dw Jump_016_4B21
    dw Jump_016_4B29
    dw Jump_016_4B31
    dw Jump_016_4B39
    dw Jump_016_4B41
    dw Jump_016_4B41
    dw Jump_016_4B41
    dw Jump_016_4B41
    dw Jump_016_4B41
    dw Jump_016_4B41
    dw Jump_016_4B41
    dw Jump_016_4B42
    dw Jump_016_4B4A
    dw Jump_016_4B4A
    dw Jump_016_4B4A
    dw Jump_016_4B4A
    dw Jump_016_4B4A
    dw Jump_016_4B4A
    dw Jump_016_4B4B
    dw Jump_016_4B4B
    dw Jump_016_4B4B
    dw Jump_016_4B4B
    dw Jump_016_4B4B
    dw Jump_016_4B4B
    dw Jump_016_4B4B
    dw Jump_016_4B4B
    dw Jump_016_4B4C

Jump_016_4AE1::
    ld a, $1E
    ld c, $5D
    call Func_016_4BC4
    ret

Jump_016_4AE9::
    ld a, $50
    ld c, $5D
    call Func_016_4BC4
    ret

Jump_016_4AF1::
    ld a, $1E
    ld c, $61
    call Func_016_4BC4
    ret

Jump_016_4AF9::
    ld a, $50
    ld c, $61
    call Func_016_4BC4
    ret

Jump_016_4B01::
    ld a, $0A
    ld c, $63
    call Func_016_4B97
    ret

Jump_016_4B09::
    ld a, $32
    ld c, $63
    call Func_016_4B97
    ret

Jump_016_4B11::
    ld a, $0A
    ld c, $65
    call Func_016_4B97
    ret

Jump_016_4B19::
    ld a, $32
    ld c, $65
    call Func_016_4B97
    ret

Jump_016_4B21::
    ld a, $0A
    ld c, $67
    call Func_016_4B97
    ret

Jump_016_4B29::
    ld a, $32
    ld c, $67
    call Func_016_4B97
    ret

Jump_016_4B31::
    ld a, $32
    ld c, $69
    call Func_016_4B97
    ret

Jump_016_4B39::
    ld a, $64
    ld c, $69
    call Func_016_4B97
    ret

Jump_016_4B41::
    ret

Jump_016_4B42::
    ld a, $05
    ld c, $65
    call Func_016_4B97
    ret

Jump_016_4B4A::
    ret

Jump_016_4B4B::
    ret

Jump_016_4B4C::
    ret

Func_016_4B4D::
    ldh [$FFC6], a
    ld a, [$D083]
    call Func_000_1F49
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ldh a, [$FFC6]
    add a, e
    ld e, a
    jr nc, Jump_016_4B60
    inc d

Jump_016_4B60::
    call Func_016_4C0E
    ld a, d
    ld [hl-], a
    ld a, e
    ld [hl], a
    ret

Func_016_4B68::
    ldh [$FFC6], a
    ld a, [$D083]
    call Func_000_1F49
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ldh a, [$FFC6]
    add a, e
    ld e, a
    jr nc, Jump_016_4B7B
    inc d

Jump_016_4B7B::
    call Func_016_4C0E
    ld a, d
    ld [hl-], a
    ld a, e
    ld [hl], a
    dec hl
    dec hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ldh a, [$FFC6]
    add a, e
    ld e, a
    jr nc, Jump_016_4B8F
    inc d

Jump_016_4B8F::
    call Func_016_4C0E
    ld a, d
    ld [hl-], a
    ld a, e
    ld [hl], a
    ret

Func_016_4B97::
    ldh [$FFC6], a
    ld a, [$D083]
    call Func_000_1F49
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld a, e
    cp a, $E7
    jr nz, Jump_016_4BAC
    ld a, d
    cp a, $03
    ret z

Jump_016_4BAC::
    ld a, e
    push af
    ldh a, [$FFC6]
    ld e, a
    pop af
    sub a, e
    ld e, a
    ld a, d
    sbc a, $00
    ld d, a
    bit 7, a
    jr z, Jump_016_4BBF
    ld de, $0001

Jump_016_4BBF::
    ld a, d
    ld [hl-], a
    ld a, e
    ld [hl], a
    ret

Func_016_4BC4::
    ldh [$FFC6], a
    ld a, [$D083]
    call Func_000_1F49
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld a, e
    cp a, $E7
    jr nz, Jump_016_4BD9
    ld a, d
    cp a, $03
    ret z

Jump_016_4BD9::
    ld a, e
    push af
    ldh a, [$FFC6]
    ld e, a
    pop af
    sub a, e
    ld e, a
    ld a, d
    sbc a, $00
    ld d, a
    bit 7, a
    jr z, Jump_016_4BEC
    ld de, $0001

Jump_016_4BEC::
    ld a, d
    ld [hl-], a
    ld a, e
    ld [hl], a
    dec hl
    dec hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld a, e
    push af
    ldh a, [$FFC6]
    ld e, a
    pop af
    sub a, e
    ld e, a
    ld a, d
    sbc a, $00
    ld d, a
    bit 7, a
    jr z, Jump_016_4C09
    ld de, $0001

Jump_016_4C09::
    ld a, d
    ld [hl-], a
    ld a, e
    ld [hl], a
    ret

Func_016_4C0E::
    ld a, d
    cp a, $03
    ret c
    jr nz, Jump_016_4C18
    ld a, e
    cp a, $E8
    ret c

Jump_016_4C18::
    ld e, $E7
    ld d, $03
    ret

Func_016_4C1D::
    call Func_000_095B
    ld a, [$C5E7]
    ld l, a
    ld a, [$C5E8]
    ld h, a
    ld a, $64
    call Func_000_16D1
    ld hl, $D087
    cp a, [hl]
    ret nc
    ld a, $FF
    ld [$D081], a
    ld a, [$D082]
    ld hl, $C61D
    add a, l
    ld l, a
    jr nc, Jump_016_4C42
    inc h

Jump_016_4C42::
    ld [hl], $FF
    call Func_016_4C48
    ret

Func_016_4C48::
    ld hl, $D09D
    ld de, $C61D
    ld b, $18

Jump_016_4C50::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_016_4C50
    ld hl, $C61D
    ld bc, $0018
    ld a, $FF
    call Func_000_0949
    ld hl, $D09D
    ld de, $C61D
    ld b, $18

Jump_016_4C69::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_016_4C74
    cp a, $00
    jr z, Jump_016_4C74
    ld [de], a
    inc de

Jump_016_4C74::
    dec b
    jr nz, Jump_016_4C69
    ret

Func_016_4C78:: ; heuristic: follows a terminator; C0
    ld a, [$D081]
    cp a, $00
    ret z
    cp a, $FF
    ret z
    ld hl, $C61D
    ld b, $18

Jump_016_4C86::
    ld a, [hl]
    cp a, $00
    jr z, Jump_016_4C99
    cp a, $FF
    jr z, Jump_016_4C99
    inc hl
    dec b
    jr nz, Jump_016_4C86
    ld a, $FF
    ld [$D081], a
    ret

Jump_016_4C99::
    ld a, [$D081]
    ld [hl], a
    ret

Func_016_4C9E:: ; heuristic: follows a terminator; C0
    ld a, [$D081]
    cp a, $00
    ret z
    cp a, $FF
    ret z
    ld hl, $C61D
    ld b, $18

Jump_016_4CAC::
    ld a, [$D081]
    cp a, [hl]
    jr z, Jump_016_4CBC
    inc hl
    dec b
    jr nz, Jump_016_4CAC
    ld a, $FF
    ld [$D081], a
    ret

Jump_016_4CBC::
    ld [hl], $FF
    call Func_016_4C48
    ret
    INCBIN "dwm2-cobi-us.gbc", $058CC2, $9C

Data_016_4D5E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $058D5E, $288
    ds $1C, $00
    INCBIN "dwm2-cobi-us.gbc", $059002, $1C7

Data_016_51C9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $20, $10
    INCBIN "dwm2-cobi-us.gbc", $0591E9, $C3
    ds $1D, $00

Func_016_52C9::
    ld a, [$D082]
    cp a, $14
    jr c, Jump_016_52D6
    ld a, $FF
    ld [$D081], a
    ret

Jump_016_52D6::
    rst $00
    dw Jump_016_52FF
    dw Jump_016_52FF
    dw Jump_016_52FF
    dw Jump_016_5306
    dw Jump_016_5306
    dw Jump_016_530D
    dw Jump_016_530D
    dw Jump_016_530D
    dw Jump_016_5325
    dw Jump_016_5325
    dw Jump_016_532C
    dw Jump_016_5333
    dw Jump_016_533A
    dw Jump_016_533A
    dw Jump_016_533A
    dw Jump_016_5359
    dw Jump_016_533A
    dw Jump_016_5360
    dw Jump_016_5398
    dw Jump_016_53C7

Jump_016_52FF::
    call Func_016_40F6
    call Func_016_53CE
    ret

Jump_016_5306::
    call Func_016_4118
    call Func_016_53CE
    ret

Jump_016_530D::
    ld a, [$C46D]
    ld c, a
    ld a, [$D083]
    cp a, c
    jr nz, Jump_016_531E
    ld a, $FF
    ld [$D081], a
    jr Jump_016_5321

Jump_016_531E::
    call Func_016_41FD

Jump_016_5321::
    call Func_016_53CE
    ret

Jump_016_5325::
    call Func_016_432B
    call Func_016_53CE
    ret

Jump_016_532C::
    call Func_016_421F
    call Func_016_53CE
    ret

Jump_016_5333::
    call Func_016_425E
    call Func_016_53CE
    ret

Jump_016_533A::
    call Func_016_4447
    ld a, [$D082]
    cp a, $10
    jr z, Jump_016_5348
    call Func_016_53DA
    ret

Jump_016_5348::
    ld a, [$D081]
    cp a, $FF
    jr nz, Jump_016_5355
    ld a, $15
    ld [$D08D], a
    ret

Jump_016_5355::
    call Func_016_56E4
    ret

Jump_016_5359::
    call Func_016_44D0
    call Func_016_53DA
    ret

Jump_016_5360::
    call Func_016_4447
    call Func_016_53DA
    ret z
    ld a, [$C619]
    or a, a
    jr nz, Jump_016_5385
    ld a, [$C618]
    or a, a
    jr nz, Jump_016_5385
    ld a, [$C617]
    cp a, $64
    jr nc, Jump_016_5385
    ld a, $FF
    ld [$D081], a
    ld a, $17
    ld [$D08D], a
    ret

Jump_016_5385::
    ld a, [$C634]
    or a, a
    ret z
    cp a, $FF
    ret z
    ld a, $FF
    ld [$D081], a
    ld a, $16
    ld [$D08D], a
    ret

Jump_016_5398::
    call Func_016_4454
    call Func_016_53DA
    ret z
    ld a, [$CC47]
    or a, a
    jr z, Jump_016_53BB
    ld hl, $CC48
    ld a, [$CC47]
    ld b, a

Jump_016_53AC::
    bit 7, [hl]
    jr z, Jump_016_53C6
    ld a, l
    add a, $08
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec b
    jr nz, Jump_016_53AC

Jump_016_53BB::
    ld a, $FF
    ld [$D081], a
    ld a, $18
    ld [$D08D], a
    ret

Jump_016_53C6::
    ret

Jump_016_53C7::
    call Func_016_44AD
    call Func_016_53DA
    ret

Func_016_53CE::
    ld a, [$D081]
    cp a, $FF
    ret nz
    ld a, $12
    ld [$D08D], a
    ret

Func_016_53DA::
    ld a, [$D081]
    cp a, $FF
    ret nz
    ld a, $14
    ld [$D08D], a
    ret

Func_016_53E6::
    ld a, [$D081]
    cp a, $FF
    ret z
    ld a, [$D082]
    rst $00
    dw Jump_016_5418
    dw Jump_016_542B
    dw Func_016_543E
    dw Jump_016_5457
    dw Jump_016_549B
    dw Jump_016_54CD
    dw Jump_016_54DB
    dw Jump_016_54E9
    dw Jump_016_54F7
    dw Jump_016_5522
    dw Jump_016_553A
    dw Jump_016_554A
    dw Jump_016_5573
    dw Jump_016_5583
    dw Jump_016_55A5
    dw Jump_016_55B5
    dw Jump_016_55C5
    dw Jump_016_55CB
    dw Jump_016_568E
    dw Jump_016_569E

Jump_016_5418::
    ld a, $0A
    ld [$D08F], a
    ld a, $1E
    ld [$D090], a
    call Func_016_56AF
    ld a, $06
    ld [$D08D], a
    ret

Jump_016_542B::
    ld a, $0F
    ld [$D08F], a
    ld a, $4B
    ld [$D090], a
    call Func_016_56AF
    ld a, $06
    ld [$D08D], a
    ret

Func_016_543E::
    ld a, [$D083]
    ld c, $5D
    call Func_000_1F49
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, [$D083]
    ld c, $5B
    call Func_016_58FD
    ld a, $06
    ld [$D08D], a
    ret

Jump_016_5457::
    ld a, $1E
    ld [$D08F], a
    ld a, $5A
    ld [$D090], a
    ld a, [$D08E]
    ld [$D08D], a
    ld a, $00
    call Func_016_5473
    ld a, $01
    call Func_016_5473
    ld a, $02

Func_016_5473::
    ld hl, $C6FD
    cp a, [hl]
    ret nc
    ld [$D083], a
    call Func_016_56D9
    ret nz
    ld a, [$D083]
    ld c, $5B
    call Func_000_1F49
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    inc hl
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    ld a, h
    or a, l
    ret z
    call Func_016_56AF
    ret

Jump_016_549B::
    ld a, [$D08E]
    ld [$D08D], a
    ld a, $00
    call Func_016_54AD
    ld a, $01
    call Func_016_54AD
    ld a, $02

Func_016_54AD::
    ld hl, $C6FD
    cp a, [hl]
    ret nc
    ld [$D083], a
    call Func_016_56D9
    ret nz
    ld a, [$D083]
    ld c, $5D
    call Func_000_1F49
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, [$D083]
    ld c, $5B
    call Func_016_58FD
    ret

Jump_016_54CD::
    ld a, $0F
    ld [$D08F], a
    call Func_016_56CC
    ld a, $07
    ld [$D08D], a
    ret

Jump_016_54DB::
    ld a, $1E
    ld [$D08F], a
    call Func_016_56CC
    ld a, $07
    ld [$D08D], a
    ret

Jump_016_54E9::
    ld a, $50
    ld [$D08F], a
    call Func_016_56CC
    ld a, $07
    ld [$D08D], a
    ret

Jump_016_54F7::
    ld a, [$D083]
    ld c, $55
    call Func_000_1F49
    ld [hl], $00
    ld a, [$D083]
    ld c, $5B
    call Func_000_1F49
    push hl
    inc hl
    inc hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    srl b
    rr c
    pop hl
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, $08
    ld [$D08D], a
    ld a, $01
    ld [$D095], a
    ret

Jump_016_5522::
    ld a, [$D083]
    ld c, $55
    call Func_000_1F49
    ld [hl], $00
    call Func_016_543E
    ld a, $08
    ld [$D08D], a
    ld a, $01
    ld [$D095], a
    ret

Jump_016_553A::
    ld a, [$D083]
    ld c, $55
    call Func_000_1F49
    res 2, [hl]
    ld a, $09
    ld [$D08D], a
    ret

Jump_016_554A::
    ld a, [$D08E]
    ld [$D08D], a
    ld a, $00
    call Func_016_555C
    ld a, $01
    call Func_016_555C
    ld a, $02

Func_016_555C::
    ld hl, $C6FD
    cp a, [hl]
    ret nc
    ld [$D083], a
    call Func_016_56D9
    ret nz
    ld a, [$D083]
    ld c, $55
    call Func_000_1F49
    res 0, [hl]
    ret

Jump_016_5573::
    ld a, $01
    ld [$D067], a
    ld a, $FF
    ld [$D08D], a
    ld a, $FF
    ld [$D081], a
    ret

Jump_016_5583::
    ld a, $01
    ld [$D067], a
    ld a, [$C46D]
    ld c, $0E
    call Func_000_1F49
    ld a, [hl]
    and a, $01
    xor a, $01
    or a, $10
    ld [$D068], a
    ld a, $FF
    ld [$D08D], a
    ld a, $FF
    ld [$D081], a
    ret

Jump_016_55A5::
    ld a, $C8
    ld [$D069], a
    ld a, $FF
    ld [$D08D], a
    ld a, $FF
    ld [$D081], a
    ret

Jump_016_55B5::
    ld a, $04
    ld [$D067], a
    ld a, $FF
    ld [$D08D], a
    ld a, $FF
    ld [$D081], a
    ret

Jump_016_55C5::
    ld a, $0B
    ld [$D08D], a
    ret

Jump_016_55CB::
    ld a, [$CC44]
    cp a, $80
    jr nz, Jump_016_55E3
    ld a, [$C935]
    bit 7, a
    jr z, Jump_016_55E3
    xor a, a
    ld [$CB7D], a
    ld [$CB7E], a
    ld [$C935], a

Jump_016_55E3::
    ld hl, $C617
    ld a, [hl]
    sub a, $64
    ld [hl+], a
    ld a, [hl]
    sbc a, $00
    ld [hl+], a
    ld a, [hl]
    sbc a, $00
    ld [hl], a
    call Func_000_095B
    ld a, [$C5E7]
    ld l, a
    ld a, [$C5E8]
    ld h, a
    ld a, $64
    call Func_000_16E2
    ld c, $01
    sub a, $19
    jr c, Jump_016_5675
    ld c, $02
    sub a, $0A
    jr c, Jump_016_5675
    ld c, $04
    sub a, $05
    jr c, Jump_016_5675
    ld c, $06
    sub a, $05
    jr c, Jump_016_5675
    ld c, $07
    sub a, $05
    jr c, Jump_016_5675
    ld c, $08
    sub a, $05
    jr c, Jump_016_5675
    ld c, $09
    sub a, $05
    jr c, Jump_016_5675
    ld c, $0A
    sub a, $05
    jr c, Jump_016_5675
    ld c, $19
    sub a, $05
    jr c, Jump_016_5675
    ld c, $1A
    sub a, $05
    jr c, Jump_016_5675
    ld c, $1B
    sub a, $02
    jr c, Jump_016_5675
    ld c, $1C
    sub a, $01
    jr c, Jump_016_5675
    ld c, $1D
    sub a, $05
    jr c, Jump_016_5675
    ld c, $20
    sub a, $05
    jr c, Jump_016_5675
    ld c, $28
    sub a, $05
    jr c, Jump_016_5675
    ld c, $29
    sub a, $01
    jr c, Jump_016_5675
    ld c, $2A
    sub a, $05
    jr c, Jump_016_5675
    ld c, $2B
    sub a, $01
    jr c, Jump_016_5675
    ld a, $FF
    ld [$D081], a
    jr Jump_016_5688

Jump_016_5675::
    ld a, c
    ld [$C634], a
    ld l, c
    ld h, $05
    ld de, $C160
    call Func_000_2E81
    ld hl, Func_016_4C48
    ld b, $16
    rst $10

Jump_016_5688::
    ld a, $0E
    ld [$D08D], a
    ret

Jump_016_568E::
    ld a, $01
    ld [$C950], a
    ld a, $11
    ld [$D08D], a
    ld a, $FF
    ld [$D081], a
    ret

Jump_016_569E::
    ld hl, $44C9
    ld b, $A1
    rst $10
    ld a, $1C
    ld [$D08D], a
    ld a, $FF
    ld [$D081], a
    ret

Func_016_56AF::
    call Func_000_095B
    ld a, [$C5E7]
    ld b, a
    ld a, [$D08F]
    inc a
    call Func_000_16BF
    ld b, a
    ld a, [$D090]
    add a, b
    ld l, a
    ld h, $00
    ld a, [$D083]
    call Func_016_57D1
    ret

Func_016_56CC::
    ld a, [$D08F]
    ld l, a
    ld h, $00
    ld a, [$D083]
    call Func_016_57E8
    ret

Func_016_56D9::
    ld a, [$D083]
    ld c, $55
    call Func_000_1F49
    bit 7, [hl]
    ret

Func_016_56E4::
    ld a, [$CC44]
    bit 7, a
    jr nz, Jump_016_56F2
    ld hl, Data_016_4D5E
    ld b, $0A
    rst $10
    ret

Jump_016_56F2::
    call Func_016_5766
    ld de, $D09F
    ld b, $08

Jump_016_56FA::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    and a, $01
    ld [de], a
    inc de
    dec b
    jr nz, Jump_016_56FA
    ld hl, $D0A1
    ld a, [$D09F]
    ld e, a
    ld a, [$D0A0]
    ld d, a
    ld bc, $0707

Jump_016_5713::
    push bc
    push hl

Jump_016_5715::
    ld a, [hl+]
    cp a, e
    jr nz, Jump_016_5728
    ld a, [hl]
    cp a, d
    jr nz, Jump_016_5728
    ld a, [$D09E]
    inc a
    ld [$D09E], a
    ld a, $FF
    ld [hl-], a
    ld [hl+], a

Jump_016_5728::
    inc hl
    dec c
    jr nz, Jump_016_5715
    pop hl
    pop bc

Jump_016_572E::
    dec c
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld a, e
    and a, d
    cp a, $FF
    jr nz, Jump_016_573E
    dec b
    jr nz, Jump_016_572E
    jr Jump_016_5741

Jump_016_573E::
    dec b
    jr nz, Jump_016_5713

Jump_016_5741::
    ld de, $D09F
    ld hl, $D09F
    ld bc, $0800

Jump_016_574A::
    ld a, [hl+]
    ld [de], a
    cp a, $FF
    ld a, [hl]
    jr nz, Jump_016_5755
    cp a, $FF
    jr z, Jump_016_5759

Jump_016_5755::
    inc de
    ld [de], a
    inc de
    inc c

Jump_016_5759::
    inc hl
    dec b
    jr nz, Jump_016_574A
    ld a, c
    ld [$D09D], a
    xor a, a
    ld [$D09E], a
    ret

Func_016_5766::
    ldh a, [$FF8C]
    bit 3, a
    jr nz, Jump_016_57C4
    ld a, [$CC44]
    and a, $07
    cp a, $01
    jr z, Jump_016_5778
    or a, a
    jr nz, Jump_016_5795

Jump_016_5778::
    ldh a, [$FF92]
    srl a
    and a, $FE
    ld c, a
    ldh a, [$FF8F]
    srl a
    srl a
    add a, c
    ld hl, $CD70
    add a, l
    ld l, a
    jr nc, Jump_016_578E
    inc h

Jump_016_578E::
    ld a, [hl]
    add a, a
    add a, a
    add a, c
    ld c, a
    jr Jump_016_57C6

Jump_016_5795::
    ld a, [$CC45]
    add a, a
    add a, a
    ld hl, $CD88
    add a, l
    ld l, a
    jr nc, Jump_016_57A2
    inc h

Jump_016_57A2::
    ld a, [hl]
    push af
    and a, $0F
    srl a
    and a, $FE
    ld c, a
    pop af
    swap a
    and a, $0F
    srl a
    srl a
    add a, c
    ld hl, $CD70
    add a, l
    ld l, a
    jr nc, Jump_016_57BD
    inc h

Jump_016_57BD::
    ld a, [hl]
    add a, a
    add a, a
    add a, a
    ld c, a
    jr Jump_016_57C6

Jump_016_57C4::
    ld c, $20

Jump_016_57C6::
    ld a, c
    add a, a
    ld hl, $CD10
    add a, l
    ld l, a
    jr nc, Jump_016_57D0
    inc h

Jump_016_57D0::
    ret

Func_016_57D1::
    push af
    push hl
    ld c, $5D
    call Func_000_1F49
    pop de
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    pop af
    push bc
    ld c, $5B
    call Func_000_1F49
    pop bc
    call Func_016_58CC
    ret

Func_016_57E8::
    push af
    push hl
    ld c, $61
    call Func_000_1F49
    pop de
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    pop af
    push bc
    ld c, $5F
    call Func_000_1F49
    pop bc
    call Func_016_58CC
    ret

Func_016_57FF::
    call Func_016_5906
    ld c, $63
    ld de, $03E7
    call Func_016_58AD
    ret

Func_016_580B::
    call Func_016_5906
    ld c, $65
    ld de, $03E7
    call Func_016_58AD
    ret

Func_016_5817::
    call Func_016_5906
    ld c, $67
    ld de, $03E7
    call Func_016_58AD
    ret

Func_016_5823::
    call Func_016_5906
    ld c, $69
    ld de, $03E7
    call Func_016_58AD
    ret

Func_016_582F::
    call Func_016_5906
    ld c, $5D
    ld de, $03E7
    call Func_016_58AD
    ret

Func_016_583B::
    call Func_016_5906
    ld c, $61
    ld de, $03E7
    call Func_016_58AD
    ret

Func_016_5847::
    call Func_016_5906
    ld c, $6F
    ld e, $FF
    call Func_016_5897
    ret

Func_016_5852::
    call Func_016_5906
    ld c, $6F
    ld e, $00
    call Func_016_58A2
    ret

Func_016_585D::
    call Func_016_5906
    ld c, $70
    ld e, $FF
    call Func_016_5897
    ret

Func_016_5868::
    call Func_016_5906
    ld c, $70
    ld e, $00
    call Func_016_58A2
    ret

Func_016_5873::
    call Func_016_5906
    ld c, $72
    ld e, $FF
    call Func_016_5897
    ret

Func_016_587E::
    call Func_016_5906
    ld c, $72
    ld e, $00
    call Func_016_58A2
    ret

Func_016_5889::
    call Func_016_5906
    push hl
    ld c, $6B
    call Func_000_1FD1
    pop de
    call Func_016_58E0
    ret

Func_016_5897::
    push hl
    push de
    call Func_000_1FD1
    pop bc
    pop de
    call Func_016_58B8
    ret

Func_016_58A2::
    push hl
    push de
    call Func_000_1FD1
    pop bc
    pop de
    call Func_016_58C2
    ret

Func_016_58AD::
    push hl
    push de
    call Func_000_1FD1
    pop bc
    pop de
    call Func_016_58CC
    ret

Func_016_58B8::
    ld a, [hl]
    add a, e
    jr c, Jump_016_58BF
    cp a, c
    jr c, Jump_016_58C0

Jump_016_58BF::
    ld a, c

Jump_016_58C0::
    ld [hl], a
    ret

Func_016_58C2::
    ld a, [hl]
    sub a, e
    jr c, Jump_016_58C9
    cp a, c
    jr nc, Jump_016_58CA

Jump_016_58C9::
    ld a, c

Jump_016_58CA::
    ld [hl], a
    ret

Func_016_58CC::
    push hl
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    add hl, de
    jr c, Jump_016_58D9
    ld a, l
    sub a, c
    ld a, h
    sbc a, b
    jr nc, Jump_016_58DB

Jump_016_58D9::
    ld c, l
    ld b, h

Jump_016_58DB::
    pop hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    ret

Func_016_58E0::
    push hl
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, l
    sub a, e
    ld l, a
    ld a, h
    sbc a, d
    ld h, a
    jr nc, Jump_016_58EF
    ld hl, $0000

Jump_016_58EF::
    ld e, l
    ld d, h
    pop hl
    ld a, e
    ld [hl+], a
    ld [hl], d
    ret

Func_016_58F6:: ; heuristic: follows a terminator; C0
    push hl
    call Func_000_1F49
    pop bc
    ld [hl], c
    ret

Func_016_58FD::
    push hl
    call Func_000_1F49
    pop bc
    ld a, c
    ld [hl+], a
    ld [hl], b
    ret

Func_016_5906::
    push hl
    call Func_000_24C5
    pop hl
    ret

Func_016_590C::
    ld hl, $D09F
    ld a, l
    ld [$D09D], a
    ld a, h
    ld [$D09E], a
    ld bc, $0018
    ld a, $FF
    call Func_000_0949
    ld a, [$C836]
    bit 7, a
    jr nz, Jump_016_5928
    xor a, $01

Jump_016_5928::
    res 7, a
    ld [$C836], a
    ld de, Data_016_599E
    bit 0, a
    jr z, Jump_016_5937
    ld de, Data_016_5A0E

Jump_016_5937::
    ld hl, $C61D
    ld b, $18

Jump_016_593C::
    push bc
    push hl
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_016_5944
    xor a, a

Jump_016_5944::
    ld l, a
    ld h, $00
    add hl, de
    ld a, [$D09D]
    ld c, a
    ld a, [$D09E]
    ld b, a
    ld a, [hl]
    ld [bc], a
    inc bc
    ld a, c
    ld [$D09D], a
    ld a, b
    ld [$D09E], a
    pop hl
    pop bc
    inc hl
    dec b
    jr nz, Jump_016_593C
    ld a, $18
    ld [$D09D], a

Jump_016_5966::
    ld hl, $D09F
    ld de, $D0A0
    ld b, $17
    ld c, $00

Jump_016_5970::
    ld a, [de]
    cp a, [hl]
    jr nc, Jump_016_597C
    push af
    ld a, [hl]
    ld [de], a
    pop af
    ld [hl], a
    call Func_016_598C

Jump_016_597C::
    inc de
    inc hl
    inc c
    dec b
    jr nz, Jump_016_5970
    ld a, [$D09D]
    dec a
    ld [$D09D], a
    jr nz, Jump_016_5966
    ret

Func_016_598C::
    push hl
    ld hl, $C61D
    ld a, c
    add a, l
    ld l, a
    jr nc, Jump_016_5996
    inc h

Jump_016_5996::
    ld a, [hl+]
    push af
    ld a, [hl-]
    ld [hl+], a
    pop af
    ld [hl], a
    pop hl
    ret

Data_016_599E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $05999E, $70

Data_016_5A0E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $059A0E, $70

Func_016_5A7E::
    ld a, [$D006]
    ld c, a
    ld a, [$D007]
    ld b, a
    ld a, c
    and a, $07
    ld hl, Data_016_5AA7
    add a, l
    ld l, a
    jr nc, Jump_016_5A91
    inc h

Jump_016_5A91::
    ld a, [hl]
    srl b
    rr c
    srl b
    rr c
    srl b
    rr c
    ld hl, $C7CC
    add hl, bc
    ld b, a
    ld a, [hl]
    and a, b
    ld c, a
    ret

Data_016_5AA7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $02, $04, $08, $10, $20, $40, $80

Func_016_5AAF::
    call Func_016_5A7E
    ld a, b
    or a, [hl]
    ld [hl], a
    push af
    ld a, [$C7FB]
    and a, $0F
    ld [$C7FB], a
    pop af
    ret

Func_016_5AC0::
    xor a, a
    ld hl, $D09D
    ld bc, $000B
    call Func_000_0949
    xor a, a
    ld [$D006], a
    ld [$D007], a

Jump_016_5AD1::
    ld hl, $400A
    ld b, $35
    rst $10
    ld a, [$D008]
    cp a, $FF
    jr z, Jump_016_5B16
    ld de, $D09D
    add a, e
    ld e, a
    jr nc, Jump_016_5AE6
    inc d

Jump_016_5AE6::
    call Func_016_5A7E
    jr nz, Jump_016_5B13
    push de
    ld a, [$D006]
    ld [$D7F1], a
    ld a, [$D007]
    ld [$D7F2], a
    ld hl, $C7FC
    ld a, l
    ld [$D7F3], a
    ld a, h
    ld [$D7F4], a
    ld hl, $68FA
    ld b, $15
    rst $10
    pop de
    ld a, [$D7F5]
    cp a, $FF
    jr z, Jump_016_5B13
    jr Jump_016_5B16

Jump_016_5B13::
    ld a, [de]
    inc a
    ld [de], a

Jump_016_5B16::
    ld a, [$D006]
    ld l, a
    ld a, [$D007]
    ld h, a
    inc hl
    ld a, l
    ld [$D006], a
    ld a, h
    ld [$D007], a
    ld bc, $0175
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    jr c, Jump_016_5AD1
    ret

Func_016_5B33::
    xor a, a
    ld hl, $D09D
    ld bc, $000B
    call Func_000_0949
    xor a, a
    ld [$D006], a
    ld [$D007], a

Jump_016_5B44::
    ld hl, $400A
    ld b, $35
    rst $10
    ld a, [$D008]
    cp a, $FF
    jr z, Jump_016_5B61
    ld de, $D09D
    add a, e
    ld e, a
    jr nc, Jump_016_5B59
    inc d

Jump_016_5B59::
    call Func_016_5A7E
    jr z, Jump_016_5B61
    ld a, [de]
    inc a
    ld [de], a

Jump_016_5B61::
    ld a, [$D006]
    ld l, a
    ld a, [$D007]
    ld h, a
    inc hl
    ld a, l
    ld [$D006], a
    ld a, h
    ld [$D007], a
    ld bc, $0175
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    jr c, Jump_016_5B44
    ret

Func_016_5B7E::
    ld a, $01
    ld [$D890], a
    ld a, [$C58A]
    or a, a
    jp nz, Jump_016_5CF5
    ld a, [$CFC5]
    cp a, $03
    jp z, Jump_016_5CF5
    cp a, $04
    jp z, Jump_016_5CF5
    cp a, $05
    jp z, Jump_016_5CF5
    cp a, $08
    jp nc, Jump_016_5CF5
    ld a, [$DAAB]
    cp a, $FF
    jp z, Jump_016_5CF5
    cp a, $04
    jp c, Jump_016_5CF5
    cp a, $07
    jp nc, Jump_016_5CF5
    and a, $03
    ld hl, $D8A1
    add a, l
    ld l, a
    jr nc, Jump_016_5BBD
    inc h

Jump_016_5BBD::
    ld a, [hl]
    cp a, $07
    jp z, Jump_016_5CF5
    ld a, [$DAAB]
    ld hl, $D958
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_016_5BCF
    inc h

Jump_016_5BCF::
    ld a, [hl+]
    ld [$D006], a
    ld a, [hl]
    ld [$D007], a
    call Func_016_5A7E
    ld de, $5D0B
    jr nz, Jump_016_5C15
    ld hl, Data_016_4001
    ld b, $35
    rst $10
    call Func_000_095B
    ld a, [$C5E7]
    ld l, a
    ld a, [$C5E8]
    ld h, a
    ld a, $C8
    call Func_000_16D1
    ld b, a
    ld a, [$D00C]
    cp a, $07
    jp z, Jump_016_5CF5
    ld hl, Func_016_5CFB
    add a, l
    ld l, a
    jr nc, Jump_016_5C06
    inc h

Jump_016_5C06::
    ld a, [hl]
    cp a, b
    jp nc, Jump_016_5CFA
    ld a, [$D894]
    or a, a
    jp nz, Jump_016_5CFA
    ld de, Data_016_5D03

Jump_016_5C15::
    ld a, [$D89F]
    ld c, a
    ld a, [$D8A0]
    ld b, a
    ld a, [$DAAB]
    and a, $03
    ld hl, $D8A1
    add a, l
    ld l, a
    jr nc, Jump_016_5C2A
    inc h

Jump_016_5C2A::
    ld a, [hl]
    add a, e
    ld e, a
    jr nc, Jump_016_5C30
    inc d

Jump_016_5C30::
    ld a, [de]
    ld h, b
    ld l, c
    or a, a
    jp z, Jump_016_5CFA
    cp a, $07
    jp z, Jump_016_5CF5
    ld a, [$D894]
    or a, a
    jp nz, Jump_016_5CFA
    ld a, [de]
    cp a, $01
    jr z, Jump_016_5C77
    cp a, $02
    jr z, Jump_016_5C7C
    cp a, $03
    jr z, Jump_016_5C7F
    cp a, $04
    jr z, Jump_016_5C81
    cp a, $05
    jr z, Jump_016_5C87
    cp a, $06
    jr z, Jump_016_5C8E
    cp a, $11
    jr z, Jump_016_5CA0
    cp a, $12
    jr z, Jump_016_5CA2
    cp a, $13
    jr z, Jump_016_5CAC
    cp a, $14
    jr z, Jump_016_5CAC
    cp a, $15
    jr z, Jump_016_5CAC
    cp a, $16
    jr z, Jump_016_5CBA
    jp Jump_016_5CF5

Jump_016_5C77::
    add hl, hl
    add hl, hl
    add hl, bc
    jr Jump_016_5CBF

Jump_016_5C7C::
    add hl, hl
    jr Jump_016_5CBF

Jump_016_5C7F::
    jr Jump_016_5CBF

Jump_016_5C81::
    srl h
    rr l
    jr Jump_016_5CBF

Jump_016_5C87::
    ld a, $05
    call Func_000_16D1
    jr Jump_016_5CBF

Jump_016_5C8E::
    srl h
    rr l
    srl h
    rr l
    srl h
    rr l
    srl h
    rr l
    jr Jump_016_5CBF

Jump_016_5CA0::
    jr Jump_016_5CBF

Jump_016_5CA2::
    srl h
    rr l
    srl h
    rr l
    jr Jump_016_5CBF

Jump_016_5CAC::
    srl h
    rr l
    srl h
    rr l
    srl h
    rr l
    jr Jump_016_5CBF

Jump_016_5CBA::
    ld a, $14
    call Func_000_16D1

Jump_016_5CBF::
    push hl
    call Func_000_095B
    ld a, [$C5E7]
    ld l, a
    ld a, [$C5E8]
    ld h, a
    ld a, $5B
    call Func_000_16D1
    add a, $0A
    ld c, a
    ld b, $00
    pop hl
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    bit 7, h
    jr nz, Jump_016_5CF5
    call Func_000_095B
    ld a, [$C5E7]
    ld l, a
    ld a, [$C5E8]
    ld h, a
    ld a, $64
    call Func_000_16D1
    inc a
    cp a, $5B
    jr c, Jump_016_5CFA

Jump_016_5CF5::
    ld a, $FF
    ld [$DAAB], a

Jump_016_5CFA::
    ret

Func_016_5CFB:: ; heuristic: follows a terminator; C0
    ld h, h
    ld [hl-], a
    jr Jump_016_5D09
    db $06, $02, $01, $00

Data_016_5D03:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $02, $03, $04, $05

Jump_016_5D09::
    ld b, $07
    nop
    ld de, $1312
    inc d
    dec d
    ld d, $07

Func_016_5D13::
    ld a, [$CFCC]
    rst $00
    dw Jump_016_5D51
    dw Jump_016_5D8C
    dw Jump_016_5DA0
    dw Jump_016_5DB2
    dw Jump_016_5DE6
    dw Jump_016_5E0B
    dw Jump_016_5E3B
    dw Jump_016_5DB2
    dw Jump_016_5DE6
    dw Jump_016_5E48
    dw Jump_016_5E5A
    dw Jump_016_5E96
    dw Jump_016_5EEC
    dw Jump_016_5F24
    dw Jump_016_5F5C
    dw Jump_016_5FA4
    dw Jump_016_6017
    dw Jump_016_6058
    dw Jump_016_60B5
    dw Jump_016_614C
    dw Jump_016_6151
    dw Jump_016_615E
    dw Jump_016_61D2
    dw Jump_016_6250
    dw Jump_016_62A9
    dw Jump_016_631B
    dw Jump_016_637E
    dw Jump_016_63B9
    dw Jump_016_643D

Jump_016_5D51::
    ld hl, $CFCC
    inc [hl]
    ld de, $C130
    call Func_016_6A10
    ld a, [$CFC5]
    cp a, $08
    jr nc, Jump_016_5D71
    and a, $01
    jr z, Jump_016_5D7A
    ld hl, Jump_016_606D
    ld b, $61
    rst $10
    ldh a, [$FFC6]
    or a, a
    jr nz, Jump_016_5D7A

Jump_016_5D71::
    ld a, $1E
    ld [$C529], a
    call Func_016_6955
    ret

Jump_016_5D7A::
    call Func_016_6493
    xor a, a
    ld [$C470], a
    ld [$C471], a
    ld [$CFD6], a
    ld hl, $CFCC
    inc [hl]
    ret

Jump_016_5D8C::
    ld a, [$C52B]
    or a, a
    ret nz
    ld hl, $CFC9
    inc [hl]
    xor a, a
    ld [$CFCA], a
    ld [$CFCB], a
    ld [$CFCC], a
    ret

Jump_016_5DA0::
    ld a, [$C52B]
    or a, a
    ret nz
    ld a, $0B
    ld [$C529], a
    call Func_016_6955
    ld hl, $CFCC
    inc [hl]
    ret

Jump_016_5DB2::
    ld a, [$C52B]
    or a, a
    ret nz
    ld hl, Data_016_72DB
    ld b, $1A
    rst $10
    ld de, $C2A6
    ld hl, $990E
    ld bc, $0605
    call Func_016_7321
    xor a, a
    ld [$C46B], a
    ld a, $02
    ld [$CFD0], a
    ld a, $00
    ld [$CFD1], a
    ld a, $01
    ld [$CFD2], a
    ld a, $02
    ld [$CFD3], a
    ld hl, $CFCC
    inc [hl]
    ret

Jump_016_5DE6::
    ld de, $C46B
    ld hl, Data_016_66E7
    call Func_016_6480
    ret z
    ld hl, $CFCC
    inc [hl]
    ld a, [de]
    or a, a
    ret z
    ld de, $C130
    call Func_016_6A10
    ld a, $0C
    ld [$C529], a
    call Func_016_6955
    ld a, $01
    ld [$CFCC], a
    ret

Jump_016_5E0B::
    ld a, $BC
    ld hl, $992F
    call Func_000_1211
    ld a, [$C7C7]
    ld hl, Data_016_75EB
    add a, l
    ld l, a
    jr nc, Jump_016_5E1E
    inc h

Jump_016_5E1E::
    ld a, [$C0A0]
    ld b, a
    ld a, [$C0A1]
    add a, b
    cp a, [hl]
    jr c, Jump_016_5E2E
    ld hl, $CFCC
    inc [hl]
    ret

Jump_016_5E2E::
    ld hl, $CFCA
    inc [hl]
    ld hl, $CFCA
    inc [hl]
    xor a, a
    ld [$CFCC], a
    ret

Jump_016_5E3B::
    ld a, $0D
    ld [$C529], a
    call Func_016_6955
    ld hl, $CFCC
    inc [hl]
    ret

Jump_016_5E48::
    ld a, [$C52B]
    or a, a
    ret nz
    ld a, $0E
    ld [$C529], a
    call Func_016_6955
    ld hl, $CFCC
    inc [hl]
    ret

Jump_016_5E5A::
    ld a, [$C52B]
    or a, a
    ret nz
    call Func_016_733F
    ld hl, Data_016_72F4
    ld b, $1A
    rst $10
    ld a, $6C
    call Func_000_1278
    ld hl, $9800
    ld de, $C198
    ld bc, $140D
    call Func_016_7321
    xor a, a
    ld [$C46B], a
    ld a, $02
    ld [$CFD0], a
    ld a, $00
    ld [$CFD1], a
    ld a, $01
    ld [$CFD2], a
    ld a, $02
    ld [$CFD3], a
    ld hl, $CFCC
    inc [hl]
    ret

Jump_016_5E96::
    ld de, $C46B
    ld hl, Data_016_6701
    call Func_016_6480
    ret z
    ld a, [$C562]
    and a, $02
    jr nz, Jump_016_5ED7
    ld a, [de]
    ld e, a
    xor a, a
    ld [$C46B], a
    ld a, [$C470]
    ld [$CFD1], a
    ld hl, $CFCC
    inc [hl]
    ld a, e
    or a, a
    ret z
    call Func_016_6493
    ld a, [$C0A1]
    or a, a
    jr nz, Jump_016_5ED1
    ld a, $0F
    ld [$C529], a
    call Func_016_6955
    ld a, $09
    ld [$CFCC], a
    ret

Jump_016_5ED1::
    ld a, $16
    ld [$CFCC], a
    ret

Jump_016_5ED7::
    call Func_016_733F
    ld hl, $9800
    ld de, $C198
    ld bc, $140D
    call Func_016_7321
    ld a, $06
    ld [$CFCC], a
    ret

Jump_016_5EEC::
    ld hl, $D789
    ld bc, $001E
    ld a, $FF
    call Func_000_0949
    ld hl, Data_016_7315
    ld b, $1A
    rst $10
    call Func_016_64DC
    call Func_016_6705
    ld de, $C198
    ld hl, $9800
    ld bc, $080B
    call Func_016_7321
    ld hl, $992B
    ld a, $BC
    call Func_000_1211
    ld a, $11
    ld [$C529], a
    call Func_016_6961
    ld hl, $CFCC
    inc [hl]
    ret

Jump_016_5F24::
    ld de, $C46B
    ld hl, Data_016_66F7
    call Func_016_65FF
    ld a, [$C563]
    and a, $30
    jr z, Jump_016_5F38
    call Func_016_6705
    ret

Jump_016_5F38::
    ld a, [$C562]
    bit 0, a
    jr z, Jump_016_5F4D
    ld a, [$CFD1]
    ld [$C470], a
    call Func_016_696D
    ld hl, $CFCC
    inc [hl]
    ret

Jump_016_5F4D::
    bit 1, a
    ret z
    ld a, [$CFD1]
    ld [$C470], a
    ld a, $09
    ld [$CFCC], a
    ret

Jump_016_5F5C::
    ld a, [$C46B]
    ld hl, Data_016_66F7
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_016_5F68
    inc h

Jump_016_5F68::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, $BC
    call Func_000_1211
    ld hl, Data_016_72FB
    ld b, $1A
    rst $10
    ld a, $BB
    ld [$C2C5], a
    ld de, $C2A4
    ld hl, $990C
    ld bc, $0805
    call Func_016_7321
    xor a, a
    ld [$C46C], a
    ld a, $02
    ld [$CFD0], a
    ld a, $00
    ld [$CFD1], a
    ld a, $01
    ld [$CFD2], a
    ld a, $02
    ld [$CFD3], a
    ld hl, $CFCC
    inc [hl]
    ret

Jump_016_5FA4::
    ld de, $C46C
    ld hl, Data_016_66EB
    call Func_016_65FF
    ld a, [$C562]
    bit 0, a
    jr z, Jump_016_5FC7
    ld hl, $CFCC
    inc [hl]
    ld a, [$C46C]
    and a, $01
    ret z
    ld hl, $CFCC
    inc [hl]
    ld hl, $CFCC
    inc [hl]
    ret

Jump_016_5FC7::
    bit 1, a
    ret z
    ld a, $1F
    ld [$C2A4], a
    ld a, $25
    ld [$C2C4], a
    ld a, $2B
    ld [$C2E4], a
    ld a, $31
    ld [$C304], a
    ld a, $37
    ld [$C324], a
    ld a, $C3
    ld [$C2A5], a
    ld [$C2C5], a
    ld [$C2E5], a
    ld [$C305], a
    ld [$C325], a
    ld hl, Data_016_72F4
    ld b, $1A
    rst $10
    ld a, $BC
    ld [$C2C3], a
    ld de, $C2A2
    ld hl, $990A
    ld bc, $0A05
    call Func_016_7321
    ld a, [$C470]
    ld [$CFD1], a
    ld a, $0C
    ld [$CFCC], a
    ret

Jump_016_6017::
    ld a, [$C0A0]
    ld [$D7A9], a
    ld a, [$C46B]
    ld [$D7AB], a
    ld a, [$C470]
    ld [$D7AF], a
    ld hl, $7163
    ld b, $1E
    rst $10
    ld hl, $7745
    ld b, $1E
    rst $10
    ld a, $0C
    ld [$D780], a
    xor a, a
    ld [$D781], a
    xor a, a
    ld [$D782], a
    ld hl, $5F2D
    ld b, $1D
    rst $10
    ld hl, $C198
    ld bc, $02D0
    ld a, $C3
    call Func_000_0949
    ld hl, $CFCA
    inc [hl]
    ret

Jump_016_6058::
    ld hl, Data_016_7315
    ld b, $1A
    rst $10
    ld a, [$D7AB]
    ld [$C46B], a
    ld hl, Data_016_66DD
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_016_606D
    inc h

Jump_016_606D::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld [hl], $BC
    ld a, [$D7AF]
    ld [$C470], a
    ld [$CFD1], a
    ld hl, Data_016_72FB
    ld b, $1A
    rst $10
    ld a, $BB
    ld [$C2C5], a
    call Func_016_64DC
    call Func_016_6705
    ld de, $C198
    ld hl, $9800
    ld bc, $1412
    call Func_016_7321
    call Func_016_696D
    ld a, $02
    ld [$CFD0], a
    ld a, $00
    ld [$CFD1], a
    ld a, $01
    ld [$CFD2], a
    ld a, $02
    ld [$CFD3], a
    ld a, $0F
    ld [$CFCC], a
    ret

Jump_016_60B5::
    ld a, $BC
    ld hl, $996D
    call Func_000_1211
    ld a, [$C470]
    ld b, a
    add a, a
    add a, a
    add a, b
    ld b, a
    ld a, [$C46B]
    add a, b
    ld hl, $D789
    add a, l
    ld l, a
    jr nc, Jump_016_60D1
    inc h

Jump_016_60D1::
    ld b, [hl]
    ld a, [$C6FD]
    cp a, $01
    jr nz, Jump_016_60ED
    ld a, [$C6FE]
    cp a, b
    jr nz, Jump_016_6143

Jump_016_60DF::
    ld a, $15
    ld [$C529], a
    call Func_016_6955
    ld a, $09
    ld [$CFCC], a
    ret

Jump_016_60ED::
    ld a, [$C6FD]
    cp a, $02
    jr nz, Jump_016_6118
    ld a, [$DA63]
    ld c, a
    ld a, [$DA64]
    or a, c
    jr z, Jump_016_6143
    ld hl, $DA63
    ld a, [$C6FE]
    cp a, b
    jr z, Jump_016_6112
    ld hl, $DA64
    ld a, [$C6FF]
    cp a, b
    jr z, Jump_016_6112
    jr Jump_016_6143

Jump_016_6112::
    ld a, [hl]
    or a, a
    jr z, Jump_016_60DF
    jr Jump_016_6143

Jump_016_6118::
    ld a, [$DA63]
    ld c, a
    ld a, [$DA64]
    add a, c
    ld a, [$DA65]
    add a, c
    cp a, $02
    jr c, Jump_016_6143
    ld hl, $DA63
    ld a, [$C6FE]
    cp a, b
    jr z, Jump_016_6112
    ld hl, $DA64
    ld a, [$C6FF]
    cp a, b
    jr z, Jump_016_6112
    ld hl, $DA65
    ld a, [$C700]
    cp a, b
    jr z, Jump_016_6112

Jump_016_6143::
    xor a, a
    ld [$0100], a
    ld hl, $CFCC
    inc [hl]
    ret

Jump_016_614C::
    ld hl, $CFCC
    inc [hl]
    ret

Jump_016_6151::
    ld hl, $CFCC
    inc [hl]
    ld a, $13
    ld [$C529], a
    call Func_016_6955
    ret

Jump_016_615E::
    ld a, [$C52B]
    or a, a
    ret nz
    ld a, [$C470]
    ld b, a
    add a, a
    add a, a
    add a, b
    ld b, a
    ld a, [$C46B]
    add a, b
    ld hl, $D789
    add a, l
    ld l, a
    jr nc, Jump_016_6177
    inc h

Jump_016_6177::
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    push hl
    ld a, [hl]
    ld [$D7F1], a
    xor a, a
    ld [$D7F2], a
    ld hl, Data_016_7E96
    ld b, $14
    rst $10
    pop hl
    ld a, [$C6FD]
    ld [$D88F], a
    cp a, $03
    jr z, Jump_016_61A8
    cp a, $02
    jr z, Jump_016_61A3
    ld a, $FF
    ld [$C6FF], a

Jump_016_61A3::
    ld a, $FF
    ld [$C700], a

Jump_016_61A8::
    ld a, [$C6FE]
    ld [$C0A0], a
    ld a, [$C6FF]
    ld [$C0A1], a
    ld a, [$C700]
    ld [$C0A2], a
    call Func_016_70DB
    xor a, a
    ld [$0100], a
    ld hl, $CFCA
    inc [hl]
    ld hl, $CFCA
    inc [hl]
    xor a, a
    ld [$CFCB], a
    xor a, a
    ld [$CFCC], a
    ret

Jump_016_61D2::
    call Func_016_733F
    ld hl, Data_016_72F4
    ld b, $1A
    rst $10
    ld a, $BC
    ld [$C303], a
    ld hl, Data_016_7307
    ld b, $1A
    rst $10
    ld a, $6C
    call Func_000_1278
    ld a, $16
    ld [$C529], a
    call Func_016_6961
    call Func_016_6493
    call Func_016_65B1
    ld a, [$C0A1]
    ld [$D7A9], a
    dec a
    ld b, a
    and a, $03
    inc a
    ld [$CFD3], a
    ld a, b
    and a, $FC
    rrca
    rrca
    ld [$CFD7], a
    inc a
    ld [$CFD2], a
    cp a, $02
    jr c, Jump_016_622B
    add a, $E0
    ld [$C322], a
    ld a, $C5
    ld [$C31F], a
    ld a, $BE
    ld [$C321], a
    ld a, $C6
    ld [$C323], a

Jump_016_622B::
    ld a, $04
    ld [$CFD0], a
    ld a, [$C471]
    ld [$CFD1], a
    ld a, [$CFD6]
    ld [$C46B], a
    call Func_016_682F
    ld hl, $9800
    ld de, $C198
    ld bc, $140D
    call Func_016_7321
    ld hl, $CFCC
    inc [hl]
    ret

Jump_016_6250::
    ld de, $C46B
    ld hl, Data_016_66EF
    call Func_016_65FF
    ld a, [$C563]
    and a, $30
    jr z, Jump_016_6279
    call Func_016_682F
    ld hl, $98AB
    ld de, $C243
    ld bc, $0107
    call Func_016_7321
    ld a, [$C320]
    ld hl, $9988
    call Func_000_1211
    ret

Jump_016_6279::
    ld a, [$C562]
    bit 0, a
    jr z, Jump_016_6291
    ld a, [$C46B]
    ld [$CFD6], a
    ld a, [$CFD1]
    ld [$C471], a
    ld hl, $CFCC
    inc [hl]
    ret

Jump_016_6291::
    bit 1, a
    ret z
    call Func_016_733F
    ld hl, $9800
    ld de, $C198
    ld bc, $140D
    call Func_016_7321
    ld a, $09
    ld [$CFCC], a
    ret

Jump_016_62A9::
    call Func_016_733F
    ld hl, Data_016_7307
    ld b, $1A
    rst $10
    ld hl, Data_016_72FB
    ld b, $1A
    rst $10
    ld a, [$CFD2]
    cp a, $02
    jr c, Jump_016_62D3
    add a, $E0
    ld [$C322], a
    ld a, $C5
    ld [$C31F], a
    ld a, $BE
    ld [$C321], a
    ld a, $C6
    ld [$C323], a

Jump_016_62D3::
    call Func_016_682F
    ld a, [$CFD6]
    ld hl, Data_016_66EF
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_016_62E2
    inc h

Jump_016_62E2::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, l
    add a, $98
    ld l, a
    ld a, h
    adc a, $29
    ld h, a
    ld [hl], $BC
    ld hl, $9800
    ld de, $C198
    ld bc, $140D
    call Func_016_7321
    xor a, a
    ld [$C46D], a
    ld a, $02
    ld [$CFD0], a
    ld a, $00
    ld [$CFD1], a
    ld a, $01
    ld [$CFD2], a
    ld a, $02
    ld [$CFD3], a
    call Func_016_69AB
    ld hl, $CFCC
    inc [hl]
    ret

Jump_016_631B::
    ld hl, Data_016_66EB
    ld de, $C46D
    call Func_016_65FF
    ld a, [$C562]
    bit 0, a
    jr z, Jump_016_6375
    ld hl, $CFCC
    inc [hl]
    ld a, [de]
    or a, a
    ret z
    ld hl, $CFCC
    inc [hl]
    ld hl, $CFCC
    inc [hl]
    ld a, [$C471]
    add a, a
    add a, a
    ld b, a
    ld a, [$CFD6]
    add a, b
    ld hl, $D789
    add a, l
    ld l, a
    jr nc, Jump_016_634C
    inc h

Jump_016_634C::
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld a, [hl]
    ld c, $0B
    call Func_000_1FD1
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, h
    add a, $02
    ld h, a
    ld de, $C140
    call Func_000_2E81
    ld a, $18
    ld [$C529], a
    call Func_016_6955
    xor a, a
    ld [$0100], a
    ret

Jump_016_6375::
    bit 1, a
    ret z
    ld a, $16
    ld [$CFCC], a
    ret

Jump_016_637E::
    ld a, [$C46B]
    ld [$D7AB], a
    ld a, [$C471]
    ld [$D7AF], a
    ld hl, Data_016_71E1
    ld b, $1E
    rst $10
    ld hl, $7745
    ld b, $1E
    rst $10
    ld a, $0D
    ld [$D780], a
    xor a, a
    ld [$D781], a
    xor a, a
    ld [$D782], a
    ld hl, $6026
    ld b, $1D
    rst $10
    ld hl, $C198
    ld bc, $02D0
    ld a, $C3
    call Func_000_0949
    ld hl, $CFCA
    inc [hl]
    ret

Jump_016_63B9::
    ld hl, Data_016_7307
    ld b, $1A
    rst $10
    ld a, [$D7AB]
    ld [$C46B], a
    ld [$CFD6], a
    ld hl, Data_016_66EF
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_016_63D1
    inc h

Jump_016_63D1::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, l
    add a, $98
    ld l, a
    ld a, h
    adc a, $29
    ld h, a
    ld [hl], $BC
    ld a, [$D7AF]
    ld [$C471], a
    ld [$CFD1], a
    ld hl, Data_016_72FB
    ld b, $1A
    rst $10
    ld a, $BB
    ld [$C2C5], a
    ld a, [$CFD7]
    inc a
    cp a, $02
    jr c, Jump_016_640E
    add a, $E0
    ld [$C322], a
    ld a, $C5
    ld [$C31F], a
    ld a, $BE
    ld [$C321], a
    ld a, $C6
    ld [$C323], a

Jump_016_640E::
    call Func_016_65B1
    call Func_016_682F
    ld de, $C198
    ld hl, $9800
    ld bc, $1412
    call Func_016_7321
    ld a, $02
    ld [$CFD0], a
    ld a, $00
    ld [$CFD1], a
    ld a, $01
    ld [$CFD2], a
    ld a, $02
    ld [$CFD3], a
    call Func_016_69AB
    ld a, $19
    ld [$CFCC], a
    ret

Jump_016_643D::
    ld a, [$C52B]
    or a, a
    ret nz
    ld a, [$C471]
    add a, a
    add a, a
    ld b, a
    ld a, [$CFD6]
    add a, b
    ld hl, $D789
    add a, l
    ld l, a
    jr nc, Jump_016_6454
    inc h

Jump_016_6454::
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld a, [hl]
    ld [$D7F1], a
    xor a, a
    ld [$D7F2], a
    ld hl, Data_016_7E96
    ld b, $14
    rst $10
    xor a, a
    ld [$0100], a
    ld hl, $CFCA
    inc [hl]
    ld hl, $CFCA
    inc [hl]
    xor a, a
    ld [$CFCB], a
    xor a, a
    ld [$CFCC], a
    ret

Func_016_6480::
    call Func_016_65FF
    ld a, [$C562]
    and a, $01
    ret nz
    ld a, [$C562]
    and a, $02
    ret z
    ld a, $01
    ld [de], a
    ret

Func_016_6493::
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld a, [$C7C7]
    ld hl, Data_016_75EB
    add a, l
    ld l, a
    jr nc, Jump_016_64A7
    inc h

Jump_016_64A7::
    ld b, [hl]
    ld hl, $A000
    ld de, $0000

Jump_016_64AE::
    ld a, [hl]
    or a, a
    jr z, Jump_016_64C4
    push hl
    ld a, l
    add a, $6E
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl]
    pop hl
    or a, a
    jr z, Jump_016_64C3
    inc d
    jr Jump_016_64C4

Jump_016_64C3::
    inc e

Jump_016_64C4::
    ld a, l
    add a, $A5
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec b
    jr nz, Jump_016_64AE
    ld a, e
    ld [$C0A0], a
    ld a, d
    ld [$C0A1], a
    xor a, a
    ld [$0100], a
    ret

Func_016_64DC::
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    xor a, a
    ld [$C0A0], a
    ld de, $D789
    ld a, [$C6FD]
    ld b, a
    ld hl, $C6FE

Jump_016_64F3::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [$C0A0]
    inc a
    ld [$C0A0], a
    dec b
    jr nz, Jump_016_64F3
    ld a, [$C7C7]
    ld hl, Data_016_75EB
    add a, l
    ld l, a
    jr nc, Jump_016_650B
    inc h

Jump_016_650B::
    ld b, [hl]
    ld hl, $A000
    ld c, $00

Jump_016_6511::
    ld a, [hl]
    cp a, $01
    jr nz, Jump_016_652E
    push hl
    ld a, l
    add a, $6E
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl]
    pop hl
    or a, a
    jr nz, Jump_016_652E
    ld a, c
    ld [de], a
    inc de
    ld a, [$C0A0]
    inc a
    ld [$C0A0], a

Jump_016_652E::
    inc c
    ld a, l
    add a, $A5
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec b
    jr nz, Jump_016_6511
    xor a, a
    ld [$0100], a
    ld a, [$C0A0]
    dec a
    ld b, a
    ld a, $05
    call Func_000_16BF
    inc a
    ld [$CFD3], a
    ld a, b
    inc a
    ld [$CFD2], a
    ld a, $05
    ld [$CFD0], a
    ld a, [$C470]
    or a, a
    jr nz, Jump_016_657B
    ld a, $E1
    ld [$C1B8], a
    ld a, [$C6FD]
    cp a, $01
    jr z, Jump_016_6580
    ld a, $E2
    ld [$C1F8], a
    ld a, [$C6FD]
    cp a, $02
    jr z, Jump_016_6585
    ld a, $E3
    ld [$C238], a
    jr Jump_016_658A

Jump_016_657B::
    ld a, $B6
    ld [$C1B8], a

Jump_016_6580::
    ld a, $B6
    ld [$C1F8], a

Jump_016_6585::
    ld a, $B6
    ld [$C238], a

Jump_016_658A::
    ld a, [$CFD2]
    cp a, $02
    jr c, Jump_016_65B0
    ld a, $C5
    ld [$C2DA], a
    ld a, $BE
    ld [$C2DC], a
    ld a, $C6
    ld [$C2DE], a
    ld a, [$C470]
    add a, $E1
    ld [$C2DB], a
    ld a, [$CFD2]
    add a, $E0
    ld [$C2DD], a

Jump_016_65B0::
    ret

Func_016_65B1::
    ld hl, $D789
    ld bc, $001E
    ld a, $FF
    call Func_000_0949
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld a, [$C7C7]
    ld hl, Data_016_75EB
    add a, l
    ld l, a
    jr nc, Jump_016_65D0
    inc h

Jump_016_65D0::
    ld b, [hl]
    ld hl, $A000
    ld de, $D789
    ld c, $00

Jump_016_65D9::
    ld a, [hl]
    or a, a
    jr z, Jump_016_65EE
    push hl
    ld a, l
    add a, $6E
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl]
    pop hl
    or a, a
    jr z, Jump_016_65EE
    ld a, c
    ld [de], a
    inc de

Jump_016_65EE::
    inc c
    ld a, l
    add a, $A5
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec b
    jr nz, Jump_016_65D9
    xor a, a
    ld [$0100], a
    ret

Func_016_65FF::
    ld a, [$C563]
    bit 6, a
    jr z, Jump_016_662B
    call Func_016_66B9
    ld a, [de]
    sub a, $01
    jp nc, Jump_016_6691
    ld a, [$CFD2]
    cp a, $02
    jr c, Jump_016_661E
    ld b, a
    ld a, [$CFD1]
    inc a
    cp a, b
    jr nz, Jump_016_6625

Jump_016_661E::
    ld a, [$CFD3]
    dec a
    jp Jump_016_6691

Jump_016_6625::
    ld a, [$CFD0]
    dec a
    jr Jump_016_6691

Jump_016_662B::
    bit 7, a
    jr z, Jump_016_664E
    call Func_016_66B9
    ld a, [$CFD1]
    inc a
    ld b, a
    ld a, [$CFD2]
    cp a, b
    jr nz, Jump_016_6642
    ld a, [$CFD3]
    jr Jump_016_6645

Jump_016_6642::
    ld a, [$CFD0]

Jump_016_6645::
    ld b, a
    ld a, [de]
    inc a
    cp a, b
    jr c, Jump_016_6691
    xor a, a
    jr Jump_016_6691

Jump_016_664E::
    ld a, [$CFD2]
    cp a, $02
    jr c, Jump_016_6682
    ld a, [$C563]
    bit 5, a
    jr z, Jump_016_666D
    call Func_016_66B9
    ld a, [$CFD1]
    dec a
    cp a, $FF
    jr nz, Jump_016_669B
    ld a, [$CFD2]
    dec a
    jr Jump_016_669B

Jump_016_666D::
    bit 4, a
    jr z, Jump_016_6682
    call Func_016_66B9
    ld a, [$CFD2]
    ld b, a
    ld a, [$CFD1]
    inc a
    cp a, b
    jr c, Jump_016_669B
    xor a, a
    jr Jump_016_669B

Jump_016_6682::
    ld a, [$C5F0]
    and a, $0F
    ret z
    ld a, [$C5F0]
    bit 4, a
    jr z, Func_016_66B9
    jr Func_016_66CB

Jump_016_6691::
    ld [de], a
    call Func_016_66CB
    ld a, $02
    ld [$C5F0], a
    ret

Jump_016_669B::
    ld [$CFD1], a
    ld b, a
    ld a, [$CFD2]
    dec a
    cp a, b
    jr nz, Jump_016_66B1
    ld a, [$CFD3]
    ld b, a
    ld a, [de]
    cp a, b
    jr c, Jump_016_66B1
    ld a, b
    dec a
    ld [de], a

Jump_016_66B1::
    call Func_016_66CB
    xor a, a
    ld [$C5F0], a
    ret

Func_016_66B9::
    ld a, [de]
    push hl
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_016_66C1
    inc h

Jump_016_66C1::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, $C3
    call Func_000_1211
    pop hl
    ret

Func_016_66CB::
    ld a, [de]
    push hl
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_016_66D3
    inc h

Jump_016_66D3::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, $BB
    call Func_000_1211
    pop hl
    ret

Data_016_66DD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B9, $C1, $F9, $C1, $39, $C2, $79, $C2, $B9, $C2

Data_016_66E7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2F, $99, $6F, $99

Data_016_66EB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2D, $99, $6D, $99

Data_016_66EF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A1, $98, $E1, $98, $21, $99, $61, $99

Data_016_66F7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $21, $98, $61, $98, $A1, $98, $E1, $98, $21, $99

Data_016_6701:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2B, $99, $6B, $99

Func_016_6705::
    ld a, [$C52D]
    ld l, a
    ld a, [$C52E]
    ld h, a
    push hl
    ld a, [$C52F]
    ld l, a
    ld a, [$C530]
    ld h, a
    push hl
    ld hl, $0501
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld a, [$CFD1]
    ld b, a
    add a, a
    add a, a
    add a, b
    ld b, a
    ld hl, $D789
    add a, l
    ld l, a
    jr nc, Jump_016_6732
    inc h

Jump_016_6732::
    ld b, $05
    ld de, $93B0
    call Func_016_67E0
    pop hl
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    pop hl
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld a, [$CFD1]
    or a, a
    jr nz, Jump_016_677A
    ld a, $E1
    ld hl, $9820
    call Func_000_1211
    ld a, [$C6FD]
    cp a, $01
    jr z, Jump_016_6782
    ld a, $E2
    ld hl, $9860
    call Func_000_1211
    ld a, [$C6FD]
    cp a, $02
    jr z, Jump_016_678A
    ld a, $E3
    ld hl, $98A0
    call Func_000_1211
    jr Jump_016_6792

Jump_016_677A::
    ld a, $B6
    ld hl, $9820
    call Func_000_1211

Jump_016_6782::
    ld a, $B6
    ld hl, $9860
    call Func_000_1211

Jump_016_678A::
    ld a, $B6
    ld hl, $98A0
    call Func_000_1211

Jump_016_6792::
    ld a, [$CFD2]
    cp a, $02
    jr c, Jump_016_67A4
    ld a, [$CFD1]
    add a, $E1
    ld hl, $9943
    call Func_000_1211

Jump_016_67A4::
    ret

Func_016_67A5::
    ld a, [$C52D]
    ld l, a
    ld a, [$C52E]
    ld h, a
    push hl
    ld a, [$C52F]
    ld l, a
    ld a, [$C530]
    ld h, a
    push hl
    ld hl, $0501
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld hl, $D868
    ld b, $04
    ld de, $93B0
    call Func_016_67E0
    pop hl
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    pop hl
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ret

Func_016_67E0::
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld a, $08
    ld [$C528], a
    ld a, $05
    ld [$C529], a

Jump_016_67F3::
    ld a, [hl+]
    push bc
    ld c, $01
    push hl
    push de
    cp a, $FF
    jr nz, Jump_016_6802
    ld de, $C130
    jr Jump_016_6810

Jump_016_6802::
    call Func_000_1FD1
    ld b, $0A
    ld de, $C130

Jump_016_680A::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_016_680A

Jump_016_6810::
    ld a, $F0
    ld [de], a
    pop de
    push de
    ld a, e
    ld [$C52D], a
    ld a, d
    ld [$C52E], a
    ld hl, $402B
    ld b, $08
    rst $10
    pop de
    inc d
    pop hl
    pop bc
    dec b
    jr nz, Jump_016_67F3
    xor a, a
    ld [$0100], a
    ret

Func_016_682F::
    ld hl, $0901
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld a, [$CFD1]
    add a, a
    add a, a
    ld hl, $D789
    add a, l
    ld l, a
    jr nc, Jump_016_6850
    inc h

Jump_016_6850::
    ld a, $00
    ld [$D868], a
    call Func_016_6891
    inc hl
    ld a, $01
    ld [$D868], a
    call Func_016_6891
    inc hl
    ld a, $02
    ld [$D868], a
    call Func_016_6891
    inc hl
    ld a, $03
    ld [$D868], a
    call Func_016_6891
    xor a, a
    ld [$0100], a
    call Func_016_6917
    ld hl, $8800
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $1202
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ret

Func_016_6891::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_016_68CB
    push hl
    call Func_016_68E5
    pop hl
    ld a, [hl]
    push hl
    ld c, $6E
    call Func_000_1FD1
    ld a, [hl]
    cp a, $02
    jr nz, Jump_016_68B6
    ld a, l
    add a, $A0
    ld l, a
    ld a, h
    adc a, $FF
    ld h, a
    ld a, [hl]
    and a, $01
    add a, $CC
    jr Jump_016_68B8

Jump_016_68B6::
    ld a, $C9

Jump_016_68B8::
    ld c, a
    ld a, [$D868]
    ld hl, Data_016_690F
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_016_68C5
    inc h

Jump_016_68C5::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld [hl], c
    pop hl
    ret

Jump_016_68CB::
    push hl
    ld bc, $0200
    call Func_016_68F0
    ld a, [$D868]
    ld hl, Data_016_690F
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_016_68DE
    inc h

Jump_016_68DE::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld [hl], $C3
    pop hl
    ret

Func_016_68E5::
    ld c, $0B
    call Func_000_1FD1
    ld c, [hl]
    inc hl
    ld a, [hl]
    add a, $02
    ld b, a

Func_016_68F0::
    ld a, c
    ld [$C529], a
    ld a, b
    ld [$C528], a
    ld a, [$D868]
    add a, $94
    ld h, a
    ld l, $00
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $402B
    ld b, $08
    rst $10
    ret

Data_016_690F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $43, $C2, $83, $C2, $C3, $C2, $03, $C3

Func_016_6917::
    ld a, [$D7A9]
    cp a, $05
    ret c
    ld a, [$CFD1]
    add a, $E1
    ld [$C320], a
    ret

Func_016_6926:: ; heuristic: follows a terminator; C0
    ld a, [$C6FD]
    ld b, a
    ld hl, $C6FE
    ld de, $C0A0

Jump_016_6930::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_016_6937
    ld [de], a
    inc de

Jump_016_6937::
    dec b
    jr nz, Jump_016_6930
    ld a, [$C6FD]
    dec a
    ld [$C6FD], a
    ld [$D88F], a
    ld b, a
    ld hl, $C0A0
    ld de, $C6FE

Jump_016_694B::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_016_694B
    ld a, $FF
    ld [de], a
    ret

Func_016_6955::
    ld a, $05
    ld [$C528], a
    ld hl, Data_016_4001
    ld b, $2F
    rst $10
    ret

Func_016_6961::
    ld a, $05
    ld [$C528], a
    ld hl, $400F
    ld b, $2F
    rst $10
    ret

Func_016_696D::
    ld a, [$C470]
    ld b, a
    add a, a
    add a, a
    add a, b
    ld b, a
    ld a, [$C46B]
    add a, b
    ld hl, $D789
    add a, l
    ld l, a
    jr nc, Jump_016_6981
    inc h

Jump_016_6981::
    ld a, [hl]
    ld c, $01
    call Func_000_1FD1
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld b, $0A
    ld de, $C140

Jump_016_6995::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_016_6995
    ld a, $F0
    ld [de], a
    xor a, a
    ld [$0100], a
    ld a, $12
    ld [$C529], a
    call Func_016_6961
    ret

Func_016_69AB::
    ld a, [$C471]
    add a, a
    add a, a
    ld b, a
    ld a, [$CFD6]
    add a, b
    ld hl, $D789
    add a, l
    ld l, a
    jr nc, Jump_016_69BD
    inc h

Jump_016_69BD::
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld a, [hl]
    ld c, $0B
    call Func_000_1FD1
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, h
    add a, $02
    ld h, a
    ld de, $C140
    call Func_000_2E81
    ld a, $17
    ld [$C529], a
    call Func_016_6961
    ret

Func_016_69E2::
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld a, [$C46C]
    ld hl, $D868
    add a, l
    ld l, a
    jr nc, Jump_016_69F6
    inc h

Jump_016_69F6::
    ld a, [hl]
    ld c, $01
    call Func_000_1FD1
    ld de, $C130
    ld b, $0A

Jump_016_6A01::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_016_6A01
    ld a, $1D
    ld [$C529], a
    call Func_016_6955
    ret

Func_016_6A10::
    push de
    call Func_016_6A36
    ld a, [$DAAB]
    ld hl, $D8AF
    add a, l
    ld l, a
    jr nc, Jump_016_6A1F
    inc h

Jump_016_6A1F::
    ld a, [hl]
    and a, $01
    add a, $A7
    ld d, a
    ld a, [$DAAB]
    pop hl

Jump_016_6A29::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_016_6A31
    inc hl
    jr Jump_016_6A29

Jump_016_6A31::
    ld [hl], d
    inc hl
    ld [hl], $F0
    ret

Func_016_6A36::
    ld a, [$DAAB]
    ld hl, $D958
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_016_6A42
    inc h

Jump_016_6A42::
    ld a, [hl+]
    push af
    ld a, [hl]
    add a, $02
    ld h, a
    pop af
    ld l, a
    call Func_000_2E81
    ret

Func_016_6A4E::
    ld a, [$CFCC]
    rst $00
    dw Jump_016_6A5C
    dw Jump_016_6A6F
    dw Jump_016_6AE3
    dw Jump_016_6B52
    dw Jump_016_6B57

Jump_016_6A5C::
    ld de, $C130
    call Func_016_6A10
    ld a, $14
    ld [$C529], a
    call Func_016_6955
    ld hl, $CFCC
    inc [hl]
    ret

Jump_016_6A6F::
    ld a, [$C52B]
    or a, a
    ret nz
    ld hl, $CFA8
    ld bc, $001D
    xor a, a
    call Func_000_0949
    ld a, $01
    ld [$D7F1], a
    ld a, [$DAAB]
    ld hl, $D8AF
    add a, l
    ld l, a
    jr nc, Jump_016_6A8E
    inc h

Jump_016_6A8E::
    ld a, [hl]
    ld [$D7F2], a
    ld a, [$DAAB]
    ld hl, $C986
    ld a, l
    add a, $0D
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl]
    ld [$D7F3], a
    ld a, l
    add a, $FE
    ld l, a
    ld a, h
    adc a, $FF
    ld h, a
    ld a, [hl+]
    ld [$D7F4], a
    ld [$D006], a
    ld a, [hl]
    ld [$D7F5], a
    ld [$D007], a
    call Func_016_5AAF
    ld a, $C3
    ld hl, $C198
    ld bc, $02D0
    call Func_000_0949
    ld hl, $8800
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $1202
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld hl, $CFCC
    inc [hl]
    ret

Jump_016_6AE3::
    ld a, $01
    ld [$D7F1], a
    ld a, [$DAAB]
    ld hl, $D8AF
    add a, l
    ld l, a
    jr nc, Jump_016_6AF3
    inc h

Jump_016_6AF3::
    ld a, [hl]
    ld [$D7F2], a
    ld a, [$DAAB]
    ld hl, $C986
    ld a, l
    add a, $0D
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl]
    ld [$D7F3], a
    ld a, l
    add a, $FE
    ld l, a
    ld a, h
    adc a, $FF
    ld h, a
    ld a, [hl+]
    ld [$D7F4], a
    ld a, [hl]
    ld [$D7F5], a
    ld hl, $5CA8
    ld b, $14
    rst $10
    ld a, [$D7F5]
    cp a, $FF
    ret nz
    ld b, $31
    ld de, Data_016_7C1E
    ld hl, $8A40
    call Func_000_0CF5
    ld b, $31
    ld de, Data_016_7DFB
    ld hl, $8DF0
    call Func_000_0CF5
    ld hl, $CFCF
    inc [hl]
    ld hl, $D09E
    ld de, $C8CF
    ld b, $0A

Jump_016_6B47::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_016_6B47
    ld hl, $CFCC
    inc [hl]
    ret

Jump_016_6B52::
    ld hl, $CFCC
    inc [hl]
    ret

Jump_016_6B57::
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld a, [$C7C7]
    ld hl, Data_016_75EB
    add a, l
    ld l, a
    jr nc, Jump_016_6B6B
    inc h

Jump_016_6B6B::
    ld b, [hl]
    ld hl, $A000
    ld c, $00

Jump_016_6B71::
    ld a, [hl]
    or a, a
    jr z, Jump_016_6B83
    inc c
    ld a, l
    add a, $A5
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec b
    jr nz, Jump_016_6B71
    jr Jump_016_6BCC

Jump_016_6B83::
    ld a, c
    ld [$D09D], a
    ld [hl], $01
    inc hl
    ld b, $0A
    ld de, $D09E
    call Func_016_6BD9
    ld de, $C991
    ld b, $9A
    call Func_016_6BD9
    ld a, $00
    ld c, $55
    call Func_000_1F49
    ld c, $00
    call Func_016_6BE0
    ld a, [$C6FD]
    cp a, $01
    jr z, Jump_016_6BCC
    ld a, $01
    ld c, $55
    call Func_000_1F49
    ld c, $01
    call Func_016_6BE0
    ld a, [$C6FD]
    cp a, $02
    jr z, Jump_016_6BCC
    ld a, $02
    ld c, $55
    call Func_000_1F49
    ld c, $02
    call Func_016_6BE0

Jump_016_6BCC::
    ld hl, $CFCA
    inc [hl]
    xor a, a
    ld [$CFCC], a
    xor a, a
    ld [$0100], a
    ret

Func_016_6BD9::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Func_016_6BD9
    ret

Func_016_6BE0::
    bit 7, [hl]
    jr nz, Jump_016_6C0A
    ld d, [hl]
    ld a, c
    ld hl, $DA63
    add a, l
    ld l, a
    jr nc, Jump_016_6BEE
    inc h

Jump_016_6BEE::
    ld [hl], $00
    ld a, c
    ld hl, $D80C
    call Func_000_3F25
    ld [hl], $00
    bit 2, d
    call nz, Func_016_6C07
    bit 0, d
    call nz, Func_016_6C04
    ret

Func_016_6C04::
    set 5, [hl]
    ret

Func_016_6C07::
    set 0, [hl]
    ret

Jump_016_6C0A::
    ld a, c
    ld hl, $DA63
    add a, l
    ld l, a
    jr nc, Jump_016_6C13
    inc h

Jump_016_6C13::
    ld [hl], $01
    ret

Func_016_6C16::
    ld a, [$CFCC]
    rst $00
    dw Jump_016_6C42
    dw Jump_016_6C9E
    dw Jump_016_6CC8
    dw Jump_016_6CF5
    dw Jump_016_6D11
    dw Jump_016_6D1E
    dw Jump_016_6D47
    dw Jump_016_6D7B
    dw Jump_016_6D8D
    dw Jump_016_6DA6
    dw Jump_016_6DE4
    dw Jump_016_6E38
    dw Jump_016_6E80
    dw Jump_016_6EE9
    dw Jump_016_6F30
    dw Jump_016_6F6F
    dw Jump_016_6FA4
    dw Jump_016_6FEE
    dw Jump_016_7008
    dw Jump_016_7051

Jump_016_6C42::
    call Func_016_733F
    ld hl, $9800
    ld de, $C198
    ld bc, $140D
    call Func_016_7321
    ld a, [$D09D]
    push af
    ld a, [$D88F]
    ld b, a
    ld hl, $D868
    ld de, $C6FE

Jump_016_6C5F::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_016_6C5F
    pop af
    ld [hl], a
    ld c, $01
    call Func_000_1FD1
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld b, $0A
    ld de, $C130

Jump_016_6C7A::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_016_6C7A
    ld a, $F0
    ld [de], a
    xor a, a
    ld [$0100], a
    ld hl, Data_016_72DB
    ld b, $1A
    rst $10
    ld a, $19
    ld [$C529], a
    call Func_016_6961
    ld hl, $CFCC
    inc [hl]
    xor a, a
    ld [$C46B], a
    ret

Jump_016_6C9E::
    ld a, [$C52B]
    or a, a
    ret nz
    ld hl, $990E
    ld de, $C2A6
    ld bc, $0605
    call Func_016_7321
    ld a, $02
    ld [$CFD0], a
    ld a, $00
    ld [$CFD1], a
    ld a, $01
    ld [$CFD2], a
    ld a, $02
    ld [$CFD3], a
    ld hl, $CFCC
    inc [hl]
    ret

Jump_016_6CC8::
    ld hl, Data_016_66E7
    ld de, $C46B
    call Func_016_65FF
    ld a, [$C562]
    and a, $01
    jr z, Jump_016_6CEA
    ld a, $6C
    call Func_000_1278
    ld a, [$C46B]
    and a, $01
    jr nz, Jump_016_6CF0
    ld a, $05
    ld [$CFCC], a
    ret

Jump_016_6CEA::
    ld a, [$C562]
    and a, $02
    ret z

Jump_016_6CF0::
    ld hl, $CFCC
    inc [hl]
    ret

Jump_016_6CF5::
    ld hl, $CFCC
    inc [hl]
    call Func_016_7188
    or a, a
    jr z, Jump_016_6D08
    ld a, $20
    ld [$C529], a
    call Func_016_6955
    ret

Jump_016_6D08::
    ld a, $1A
    ld [$C529], a
    call Func_016_6955
    ret

Jump_016_6D11::
    ld hl, $CFC9
    inc [hl]
    xor a, a
    ld [$CFCA], a
    xor a, a
    ld [$CFCC], a
    ret

Jump_016_6D1E::
    ld a, [$C6FD]
    cp a, $03
    jr c, Jump_016_6D2B
    ld a, $08
    ld [$CFCC], a
    ret

Jump_016_6D2B::
    ld hl, $CFCC
    inc [hl]
    call Func_016_7188
    or a, a
    jr z, Jump_016_6D3E
    ld a, $21
    ld [$C529], a
    call Func_016_6955
    ret

Jump_016_6D3E::
    ld a, $1B
    ld [$C529], a
    call Func_016_6955
    ret

Jump_016_6D47::
    ld a, [$C52B]
    or a, a
    ret nz
    ld a, [$C6FD]
    ld hl, $D868
    add a, l
    ld l, a
    jr nc, Jump_016_6D57
    inc h

Jump_016_6D57::
    ld b, [hl]
    ld hl, $C6FD
    inc [hl]
    ld a, [hl]
    ld [$D88F], a
    dec a
    ld hl, $C6FE
    add a, l
    ld l, a
    jr nc, Jump_016_6D69
    inc h

Jump_016_6D69::
    ld [hl], b
    call Func_016_70C5
    call Func_000_222B
    call Func_016_70DB
    call Func_016_733F
    ld hl, $CFCC
    inc [hl]
    ret

Jump_016_6D7B::
    ld hl, $9800
    ld de, $C198
    ld bc, $140D
    call Func_016_7321
    ld a, $04
    ld [$CFCC], a
    ret

Jump_016_6D8D::
    call Func_016_7078
    ld a, $1C
    ld [$C529], a
    call Func_016_6961
    xor a, a
    ld [$C46C], a
    ld hl, $C2C7
    ld [hl], $BC
    ld hl, $CFCC
    inc [hl]
    ret

Jump_016_6DA6::
    ld a, [$C52B]
    or a, a
    ret nz
    ld a, $04
    ld [$CFD0], a
    ld a, $00
    ld [$CFD1], a
    ld a, $01
    ld [$CFD2], a
    ld a, $04
    ld [$CFD3], a
    ld hl, $9800
    ld de, $C198
    ld bc, $140D
    call Func_016_7321
    ld a, [$C46C]
    ld hl, Data_016_66F7
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_016_6DD7
    inc h

Jump_016_6DD7::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, $BB
    call Func_000_1211
    ld hl, $CFCC
    inc [hl]
    ret

Jump_016_6DE4::
    ld hl, Data_016_66F7
    ld de, $C46C
    call Func_016_65FF
    ld a, [$C562]
    and a, $02
    jr z, Jump_016_6E22
    ld a, [$D88F]
    ld hl, $D868
    add a, l
    ld l, a
    jr nc, Jump_016_6DFF
    inc h

Jump_016_6DFF::
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld a, [hl]
    ld c, $01
    call Func_000_1FD1
    ld b, $0A
    ld de, $C130

Jump_016_6E13::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_016_6E13
    ld a, $F0
    ld [de], a
    ld a, $13
    ld [$CFCC], a
    ret

Jump_016_6E22::
    ld a, [$C562]
    and a, $01
    ret z
    ld a, $69
    call Func_000_1278
    ld hl, Data_016_72FB
    ld b, $1A
    rst $10
    ld hl, $CFCC
    inc [hl]
    ret

Jump_016_6E38::
    xor a, a
    ld [$C46D], a
    ld hl, $990C
    ld de, $C2A4
    ld bc, $0805
    call Func_016_7321
    ld a, $02
    ld [$CFD0], a
    ld a, $00
    ld [$CFD1], a
    ld a, $01
    ld [$CFD2], a
    ld a, $02
    ld [$CFD3], a
    ld hl, Data_016_66F7
    ld a, [$C46C]
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_016_6E68
    inc h

Jump_016_6E68::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, $BC
    call Func_000_1211
    ld hl, $992D
    ld a, $BB
    call Func_000_1211
    call Func_016_69E2
    ld hl, $CFCC
    inc [hl]
    ret

Jump_016_6E80::
    ld hl, Data_016_66EB
    ld de, $C46D
    call Func_016_65FF
    ld a, [$C562]
    and a, $01
    jr z, Jump_016_6ED4
    ld a, $69
    call Func_000_1278
    ld a, [$C46D]
    and a, $01
    jr nz, Jump_016_6EA1
    ld hl, $CFCC
    inc [hl]
    ret

Jump_016_6EA1::
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld a, [$C46C]
    ld hl, $D868
    add a, l
    ld l, a
    jr nc, Jump_016_6EB5
    inc h

Jump_016_6EB5::
    ld a, [hl]
    ld c, $01
    call Func_000_1FD1
    ld de, $C130
    ld b, $0A

Jump_016_6EC0::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_016_6EC0
    ld a, $1A
    ld [$C529], a
    call Func_016_6955
    ld a, $12
    ld [$CFCC], a
    ret

Jump_016_6ED4::
    ld a, [$C562]
    and a, $02
    ret z
    call Func_016_733F
    ld hl, Data_016_72DB
    ld b, $1A
    rst $10
    ld a, $11
    ld [$CFCC], a
    ret

Jump_016_6EE9::
    ld hl, $D789
    ld bc, $001E
    xor a, a
    call Func_000_0949
    ld a, [$D88F]
    inc a
    ld [$D7A9], a
    ld b, a
    ld de, $D868
    ld hl, $D789

Jump_016_6F01::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_016_6F01
    ld a, [$C46C]
    ld [$D7AB], a
    ld a, $00
    ld [$D7AF], a
    ld hl, $7163
    ld b, $1E
    rst $10
    ld hl, $7745
    ld b, $1E
    rst $10
    ld a, $0E
    ld [$D780], a
    xor a, a
    ld [$D781], a
    xor a, a
    ld [$D782], a
    ld hl, $CFCC
    inc [hl]
    ret

Jump_016_6F30::
    ld hl, $4069
    ld b, $1E
    rst $10
    ld a, [$D781]
    cp a, $0A
    ret nz
    ld a, [$D7BC]
    ldh [$FFB9], a
    ld a, $80
    ldh [$FFBA], a
    ld a, [$D7BA]
    ldh [$FF8D], a
    ld a, [$D7BB]
    ld [$CB7D], a
    ld b, $31
    ld de, Data_016_7C1E
    ld hl, $8A40
    call Func_000_0CF5
    ld b, $31
    ld de, Data_016_7DFB
    ld hl, $8DF0
    call Func_000_0CF5
    ld hl, $CFCF
    inc [hl]
    ld hl, $CFCC
    inc [hl]
    ret

Jump_016_6F6F::
    call Func_016_733F
    call Func_016_7078
    ld a, [$D7AB]
    ld [$C46C], a
    ld hl, Data_016_66DD
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_016_6F84
    inc h

Jump_016_6F84::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld [hl], $BC
    ld hl, Data_016_72FB
    ld b, $1A
    rst $10
    ld hl, $9800
    ld de, $C198
    ld bc, $1412
    call Func_016_7321
    call Func_016_69E2
    ld a, $0C
    ld [$CFCC], a
    ret

Jump_016_6FA4::
    ld a, $1F
    ld [$C2A4], a
    ld a, $25
    ld [$C2C4], a
    ld a, $2B
    ld [$C2E4], a
    ld a, $31
    ld [$C304], a
    ld a, $37
    ld [$C324], a
    ld a, $C3
    ld [$C2A5], a
    ld [$C2C5], a
    ld [$C2E5], a
    ld [$C305], a
    ld [$C325], a
    ld hl, Data_016_72DB
    ld b, $1A
    rst $10
    ld hl, $990C
    ld hl, $C2A4
    ld bc, $0805
    call Func_016_7321
    ld a, $19
    ld [$C529], a
    call Func_016_6961
    ld a, $01
    ld [$CFCC], a
    ret

Jump_016_6FEE::
    call Func_016_7078
    ld hl, $C2C7
    ld [hl], $BC
    xor a, a
    ld [$C46D], a
    ld a, $1C
    ld [$C529], a
    call Func_016_6961
    ld a, $09
    ld [$CFCC], a
    ret

Jump_016_7008::
    ld a, [$C46C]
    ld hl, $D868
    add a, l
    ld l, a
    jr nc, Jump_016_7013
    inc h

Jump_016_7013::
    ld a, [hl]
    call Func_016_7082
    ld [hl], $FF
    ld hl, $D868
    ld de, $C6FE
    ld a, [$D88F]
    ld b, a

Jump_016_7023::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_016_7023
    ld [de], a
    push hl
    push de
    push bc
    call Func_016_70C6
    pop bc
    pop de
    pop hl
    inc de
    dec b
    jr nz, Jump_016_7023
    call Func_000_222B
    call Func_016_70DB
    call Func_016_733F
    ld hl, $9800
    ld de, $C198
    ld bc, $140D
    call Func_016_7321
    ld a, $04
    ld [$CFCC], a
    ret

Jump_016_7051::
    call Func_016_733F
    ld hl, $9800
    ld de, $C198
    ld bc, $140D
    call Func_016_7321
    ld hl, Data_016_72DB
    ld b, $1A
    rst $10
    ld a, $19
    ld [$C529], a
    call Func_016_6961
    ld a, $01
    ld [$CFCC], a
    xor a, a
    ld [$C46B], a
    ret

Func_016_7078::
    ld hl, Data_016_730E
    ld b, $1A
    rst $10
    call Func_016_67A5
    ret

Func_016_7082::
    push hl
    ld c, $00
    call Func_000_1FD1
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld [hl], $01
    ld a, l
    add a, $55
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld [hl], $00
    ld a, l
    add a, $08
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    ld b, a
    push hl
    ld a, l
    add a, $FC
    ld l, a
    ld a, h
    adc a, $FF
    ld h, a
    ld a, c
    ld [hl+], a
    ld [hl], b
    pop hl
    ld b, h
    ld c, l
    inc hl
    inc hl
    ld a, [hl+]
    ld [bc], a
    inc bc
    ld a, [hl]
    ld [bc], a
    xor a, a
    ld [$0100], a
    pop hl
    ret

Func_016_70C5::
    ld a, b

Func_016_70C6::
    ld c, $00
    call Func_000_1FD1
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld [hl], $02
    xor a, a
    ld [$0100], a
    ret

Func_016_70DB::
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld c, $00
    ld a, [$C6FE]
    call Func_016_710F
    ld a, [$C6FD]
    cp a, $01
    jr z, Jump_016_710A
    ld c, $01
    ld a, [$C6FF]
    call Func_016_710F
    ld a, [$C6FD]
    cp a, $02
    jr z, Jump_016_710A
    ld c, $02
    ld a, [$C700]
    call Func_016_710F

Jump_016_710A::
    xor a, a
    ld [$0100], a
    ret

Func_016_710F::
    push bc
    ld c, $56
    call Func_000_1FD1
    pop bc
    ld a, c
    ld de, $D8B7
    add a, e
    ld e, a
    jr nc, Jump_016_711F
    inc d

Jump_016_711F::
    ld a, [hl]
    ld [de], a
    ld a, l
    add a, $05
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, c
    ld de, $D8BF
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_016_7133
    inc d

Jump_016_7133::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc hl
    inc hl
    ld a, c
    ld de, $D8DF
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_016_7144
    inc d

Jump_016_7144::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    ld a, c
    ld de, $DA63
    add a, e
    ld e, a
    jr nc, Jump_016_7152
    inc d

Jump_016_7152::
    xor a, a
    ld [de], a
    ld a, l
    add a, $F4
    ld l, a
    ld a, h
    adc a, $FF
    ld h, a
    bit 7, [hl]
    jr nz, Jump_016_717A
    ld a, c
    add a, a
    add a, a
    add a, a
    add a, c
    ld de, $D80C
    add a, e
    ld e, a
    jr nc, Jump_016_716D
    inc d

Jump_016_716D::
    xor a, a
    ld [de], a
    bit 0, [hl]
    call nz, Func_016_717E
    bit 2, [hl]
    call nz, Func_016_7183
    ret

Jump_016_717A::
    ld a, $01
    ld [de], a
    ret

Func_016_717E::
    ld a, [de]
    set 5, a
    ld [de], a
    ret

Func_016_7183::
    ld a, [de]
    set 0, a
    ld [de], a
    ret

Func_016_7188::
    ld a, [$DAAB]
    ld hl, $D958
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_016_7194
    inc h

Jump_016_7194::
    ld a, [hl+]
    push af
    ld a, [hl]
    ld h, a
    pop af
    ld l, a
    ld a, l
    add a, $AC
    ld l, a
    ld a, h
    adc a, $71
    ld h, a
    ld a, [hl]
    cp a, $06
    jr c, Jump_016_71AA
    ld a, $01
    ret

Jump_016_71AA::
    xor a, a
    ret
    db $00, $03, $00, $02, $01, $00, $03, $01, $02, $02, $01, $02, $03, $03, $03, $00
    db $05, $04, $05, $04, $01, $04, $04, $05, $06, $07, $07, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $02, $02, $02, $02, $00, $04, $01, $03, $03, $04, $01, $04
    db $03, $00, $00, $04, $01

Data_016_71E1:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $03, $01, $04, $05, $01, $02, $04, $06, $05, $05, $05, $06, $07, $06, $00, $00
    db $00, $00, $02, $00

Data_016_71F5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $05B1F5, $81

Data_016_7276:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $02, $04, $00, $03, $02, $03
    db $04, $04, $01, $01, $05, $04, $05, $03, $04, $05, $05, $05, $05, $06, $04, $05
    db $03, $05, $03, $06, $06, $07, $06, $00, $00, $00, $00, $00, $00, $05, $02, $01
    db $02, $03, $03, $02, $02, $02

Data_016_72AC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $02, $02, $03, $01, $01, $03, $06, $06, $03, $04, $05, $07, $06, $03, $02
    db $06, $00, $00, $00, $00, $00, $00, $00, $00, $01, $02, $00, $01, $00, $00, $03

Data_016_72CC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $03, $02, $00, $03, $04, $05, $03, $02, $01, $04, $05, $03, $03, $05, $05

Data_016_72DB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $04, $03, $00, $04, $05, $04, $06, $07, $02, $04, $00, $00, $00, $00, $00, $03
    db $03, $02, $02, $03, $01, $00, $02, $03, $03

Data_016_72F4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $04, $01, $03, $04, $02, $01, $04

Data_016_72FB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $04, $04, $05, $05, $06, $05, $05, $06, $05, $06, $07, $02

Data_016_7307:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $00, $00, $00, $06, $07, $07

Data_016_730E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $06, $07, $07, $06, $07, $07, $07

Data_016_7315:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $07, $06, $06, $07, $06, $07, $07, $07, $07, $07, $07, $07

Func_016_7321::
    push bc
    push de
    push hl

Jump_016_7324::
    ld a, [de]
    inc de
    call Func_000_121F
    dec b
    jr nz, Jump_016_7324
    pop hl
    ld de, $0020
    add hl, de
    pop de
    ld a, e
    add a, $20
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop bc
    dec c
    jr nz, Func_016_7321
    ret

Func_016_733F::
    ld hl, Data_016_71F5
    ld b, $31
    rst $10
    ld hl, Data_016_72AC
    ld b, $31
    rst $10
    ld hl, $7389
    ld b, $31
    rst $10
    ld hl, Data_016_72CC
    ld b, $31
    rst $10
    ld hl, Func_016_7321
    ld b, $31
    rst $10
    ld hl, Data_016_7276
    ld b, $1A
    rst $10
    ret

Func_016_7364::
    ld a, [$CFC5]
    cp a, $02
    jr nz, Jump_016_736F
    ld c, $00
    jr Jump_016_7382

Jump_016_736F::
    call Func_000_095B
    ld a, [$C5E7]
    ld l, a
    ld a, [$C5E8]
    ld h, a
    ld a, $05
    call Func_000_16D1
    sub a, $02
    ld c, a

Jump_016_7382::
    ld a, [$C9DC]
    add a, c
    bit 7, a
    jr nz, Jump_016_7395
    or a, a
    jr z, Jump_016_7395
    cp a, $64
    jr c, Jump_016_7397
    ld a, $63
    jr Jump_016_7397

Jump_016_7395::
    ld a, $01

Jump_016_7397::
    ld [$C9DC], a
    ld a, [$C991]
    ld l, a
    ld a, [$C992]
    ld h, a
    ld a, l
    ld [$D006], a
    ld a, h
    ld [$D007], a
    ld hl, Data_016_4001
    ld b, $35
    rst $10
    ld a, [$D00E]
    ld c, a
    ld a, [$C9DC]
    cp a, c
    jr c, Jump_016_73BB
    ld c, a

Jump_016_73BB::
    ld a, c
    ld [$C9DD], a
    ld a, [$CFC5]
    cp a, $02
    jp z, Jump_016_7456
    ld a, [$C9E3]
    ld c, a
    ld a, [$C9E4]
    ld b, a
    call Func_016_751B
    ld a, l
    ld [$C9E3], a
    ld a, h
    ld [$C9E4], a
    ld a, l
    ld [$C9E1], a
    ld a, h
    ld [$C9E2], a
    ld a, [$C9E7]
    ld c, a
    ld a, [$C9E8]
    ld b, a
    call Func_016_74D2
    ld a, l
    ld [$C9E7], a
    ld a, h
    ld [$C9E8], a
    ld a, l
    ld [$C9E5], a
    ld a, h
    ld [$C9E6], a
    ld a, [$C9E9]
    ld c, a
    ld a, [$C9EA]
    ld b, a
    call Func_016_74D2
    ld a, l
    ld [$C9E9], a
    ld a, h
    ld [$C9EA], a
    ld a, [$C9EB]
    ld c, a
    ld a, [$C9EC]
    ld b, a
    call Func_016_74D2
    ld a, l
    ld [$C9EB], a
    ld a, h
    ld [$C9EC], a
    ld a, [$C9ED]
    ld c, a
    ld a, [$C9EE]
    ld b, a
    call Func_016_74D2
    ld a, l
    ld [$C9ED], a
    ld a, h
    ld [$C9EE], a
    ld a, [$C9EF]
    ld c, a
    ld a, [$C9F0]
    ld b, a
    call Func_016_74D2
    ld a, l
    ld [$C9EF], a
    ld a, h
    ld [$C9F0], a
    ld a, [$C9F7]
    ld c, a
    ld b, $00
    call Func_016_74D2
    ld a, l
    ld [$C9F7], a

Jump_016_7456::
    call Func_016_5B33
    ld hl, $D09D
    ld b, $0B
    ld de, $0000

Jump_016_7461::
    ld a, e
    add a, [hl]
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    inc hl
    dec b
    jr nz, Jump_016_7461
    ld a, d
    or a, a
    jr nz, Jump_016_74A2
    ld hl, $0000
    ld a, e
    cp a, $15
    jr c, Jump_016_74A5
    ld hl, $0032
    cp a, $29
    jr c, Jump_016_74A5
    ld hl, $0064
    cp a, $3D
    jr c, Jump_016_74A5
    ld hl, $0096
    cp a, $51
    jr c, Jump_016_74A5
    ld hl, $00C8
    cp a, $65
    jr c, Jump_016_74A5
    ld hl, $00FA
    cp a, $79
    jr c, Jump_016_74A5
    ld hl, $012C
    cp a, $8D
    jr c, Jump_016_74A5

Jump_016_74A2::
    ld hl, $0190

Jump_016_74A5::
    push hl
    ld a, [$C9DC]
    ld c, $19
    call Func_000_1682
    pop de
    ld a, l
    sub a, e
    ld l, a
    ld a, h
    sbc a, d
    ld h, a
    bit 7, h
    jr z, Jump_016_74BE
    ld hl, $0000
    jr Jump_016_74C9

Jump_016_74BE::
    ld a, l
    sub a, $E7
    ld a, h
    sbc a, $03
    jr c, Jump_016_74C9
    ld hl, $03E7

Jump_016_74C9::
    ld a, l
    ld [$C9F1], a
    ld a, h
    ld [$C9F2], a
    ret

Func_016_74D2::
    ld hl, $03E7
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    bit 7, h
    jr z, Jump_016_74E2
    ld bc, $03E7

Jump_016_74E2::
    ld a, c
    ld [$D87D], a
    ld a, b
    ld [$D87E], a
    ld a, $14
    call Func_000_16AA
    ld a, $64
    call Func_000_16E2
    ld a, l
    ld [$D87F], a
    ld a, h
    ld [$D880], a
    call Func_000_095B
    ld a, [$C5E7]
    ld l, a
    ld a, [$C5E8]
    ld h, a
    ld a, [$D87F]
    or a, a
    call nz, Func_000_16D1
    ld c, a
    ld a, [$D87D]
    sub a, c
    ld l, a
    ld a, [$D87E]
    sbc a, $00
    ld h, a
    ret

Func_016_751B::
    ld hl, $03E7
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    bit 7, h
    jr z, Jump_016_752B
    ld bc, $03E7

Jump_016_752B::
    ld a, c
    ld [$D87D], a
    ld a, b
    ld [$D87E], a
    ld a, $14
    call Func_000_16AA
    ld a, $64
    call Func_000_16E2
    ld a, l
    ld [$D87F], a
    ld a, h
    ld [$D880], a
    call Func_000_095B
    ld a, [$C5E7]
    ld l, a
    ld a, [$C5E8]
    ld h, a
    ld a, [$D87F]
    or a, a
    call nz, Func_000_16D1
    ld c, a
    ld a, [$D87D]
    sub a, c
    ld l, a
    ld a, [$D87E]
    sbc a, $00
    ld h, a
    ld a, h
    cp a, $03
    ret z
    ld a, $08
    add a, l
    ld l, a
    jr nc, Jump_016_756E
    inc h

Jump_016_756E::
    ret

Func_016_756F:: ; heuristic: follows a terminator; C0
    ld de, $8AF0
    ld hl, $8ED0
    ld b, $10

Jump_016_7577::
    call Func_000_120A
    ld a, [de]
    inc de
    call Func_000_121F
    dec b
    jr nz, Jump_016_7577
    ld hl, $0301
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld hl, $8ED0
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld a, $02
    ld [$C528], a
    ld a, $06
    ld [$C529], a
    ld hl, $400F
    ld b, $09
    rst $10
    ld hl, $8F50
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld a, $07
    ld [$C529], a
    ld hl, $400F
    ld b, $09
    rst $10
    ld hl, $8FD0
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld a, $08
    ld [$C529], a
    ld hl, $400F
    ld b, $09
    rst $10
    ld hl, $8800
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $1202
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ret

Data_016_75EB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0A, $14, $1E

Func_016_75EE::
    ld hl, $D0D5
    ld bc, $003C
    xor a, a
    call Func_000_0949
    ld hl, $706E
    ld b, $02
    rst $10
    ldh a, [$FFC6]
    or a, a
    jr z, Jump_016_760B
    ld a, $00
    ld [$D0D5], a
    jp Jump_016_76B5

Jump_016_760B::
    ld a, $01
    ld [$D0D5], a
    ld a, $0A
    ld [$0100], a
    ld a, $01
    ld [$4100], a
    ld hl, $BB0F
    ld de, $D0D6
    ld b, $0A
    call Func_016_76B6
    ld hl, $BD30
    ld de, $D0E0
    ld b, $05
    call Func_016_76B6
    ld a, [$BC00]
    ld [$D0E5], a
    push af
    ld a, [$BC01]
    ld [$D09D], a
    ld de, $D0E6
    ld a, e
    ld [$D09E], a
    ld a, d
    ld [$D09F], a
    call Func_016_76BD
    pop af
    cp a, $01
    jr z, Jump_016_767E
    push af
    ld a, [$BC02]
    ld [$D09D], a
    ld de, $D0F2
    ld a, e
    ld [$D09E], a
    ld a, d
    ld [$D09F], a
    call Func_016_76BD
    pop af
    cp a, $02
    jr z, Jump_016_767E
    ld a, [$BC03]
    ld [$D09D], a
    ld de, $D0FE
    ld a, e
    ld [$D09E], a
    ld a, d
    ld [$D09F], a
    call Func_016_76BD

Jump_016_767E::
    ld a, [$BD3A]
    ld [$D10A], a
    ld a, [$BE0D]
    ld [$D10B], a
    ld a, [$BB07]
    ld [$D10C], a
    ld a, [$BD36]
    ld hl, $BC0A
    add a, a
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_016_769D
    inc h

Jump_016_769D::
    ld a, [hl+]
    ld [$D10D], a
    ld a, [hl+]
    ld [$D10E], a
    ld a, [hl+]
    ld [$D10F], a
    ld a, [hl]
    ld [$D110], a
    xor a, a
    ld [$4100], a
    xor a, a
    ld [$0100], a

Jump_016_76B5::
    ret

Func_016_76B6::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Func_016_76B6
    ret

Func_016_76BD::
    ld a, [$D09D]
    ld c, $6F
    call Func_000_1682
    ld a, l
    add a, $6F
    ld l, a
    ld a, h
    adc a, $A0
    ld h, a
    ld a, l
    ld [$D0A0], a
    ld a, h
    ld [$D0A1], a
    ld a, [$D09E]
    ld e, a
    ld a, [$D09F]
    ld d, a
    ld a, [hl]
    and a, $0F
    ld [de], a
    inc de
    ld a, l
    add a, $21
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld b, [hl]
    ld a, l
    add a, $06
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld c, [hl]
    ld a, [$D0A0]
    add a, $03
    ld l, a
    ld a, [$D0A1]
    adc a, $00
    ld h, a
    call Func_016_7720
    ld a, [$D0A0]
    add a, $62
    ld l, a
    ld a, [$D0A1]
    adc a, $00
    ld h, a
    ld a, [$D09E]
    add a, $0B
    ld e, a
    ld a, [$D09F]
    adc a, $00
    ld d, a
    ld a, [hl]
    and a, $7F
    ld [de], a
    ret

Func_016_7720::
    push de
    ld a, $F0
    ld [de], a
    inc de
    ld [de], a
    inc de
    ld [de], a
    inc de
    ld [de], a
    inc de
    ld [de], a
    inc de
    ld [de], a
    inc de
    ld [de], a
    inc de
    ld [de], a
    inc de
    ld [de], a
    inc de
    ld [de], a
    pop de
    ld a, [hl+]
    ld [de], a
    ld a, b
    and a, $C0
    jr z, Jump_016_7744
    inc de
    rlca
    rlca
    add a, $8C
    ld [de], a

Jump_016_7744::
    inc de
    ld a, [hl+]
    ld [de], a
    ld a, b
    and a, $30
    jr z, Jump_016_7752
    inc de
    swap a
    add a, $8C
    ld [de], a

Jump_016_7752::
    inc de
    ld a, [hl+]
    ld [de], a
    ld a, b
    and a, $0C
    jr z, Jump_016_7760
    inc de
    rrca
    rrca
    add a, $8C
    ld [de], a

Jump_016_7760::
    inc de
    ld a, [hl+]
    ld [de], a
    ld a, b
    and a, $03
    jr z, Jump_016_776C
    inc de
    add a, $8C
    ld [de], a

Jump_016_776C::
    inc de
    ld a, [hl+]
    ld [de], a
    ld a, c
    and a, $C0
    jr z, Jump_016_777A
    inc de
    rlca
    rlca
    add a, $8C
    ld [de], a

Jump_016_777A::
    ret

Func_016_777B::
    ld hl, $63B8
    ld b, $15
    rst $10
    jr Jump_016_77A6

Func_016_7783:: ; heuristic: follows a terminator; C0
    ld b, $7E
    ld de, $5B63
    ld hl, $8000
    call Func_000_0CF5
    ld a, [$C525]
    or a, a
    jr z, Jump_016_77A6
    ld de, Data_07E_5BB8
    ld b, $7E
    ld hl, $C4DF
    ld c, $08
    call Func_000_0B18
    ld a, $7F
    ld [$C527], a

Jump_016_77A6::
    call Func_016_75EE
    ld a, [$D0D5]
    or a, a
    jp nz, Jump_016_7832
    ld hl, $C1D9
    ld bc, $1104
    ld a, [$C5DB]
    cp a, $05
    jr nz, Jump_016_77C0
    ld hl, $C219

Jump_016_77C0::
    ld a, $C3

Jump_016_77C2::
    push bc
    push hl

Jump_016_77C4::
    ld [hl+], a
    dec b
    jr nz, Jump_016_77C4
    pop hl
    ld bc, $0040
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_016_77C2
    ld hl, $C25C
    ld b, $0E
    ld a, [$C5DB]
    cp a, $05
    jr nz, Jump_016_77E4
    ld hl, $C29C
    ld a, $40
    jr Jump_016_77E6

Jump_016_77E4::
    ld a, $20

Jump_016_77E6::
    ld [hl+], a
    inc a
    dec b
    jr nz, Jump_016_77E6
    ld hl, $9200
    ld a, [$C5DB]
    cp a, $05
    jr nz, Jump_016_77F8
    ld hl, $9400

Jump_016_77F8::
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0E01
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld a, $08
    ld [$C528], a
    ld a, $0A
    ld [$C529], a
    ld hl, $402B
    ld b, $08
    rst $10
    ld hl, $8800
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $1202
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ret

Jump_016_7832::
    ld hl, $0501
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld a, $08
    ld [$C528], a
    ld a, $05
    ld [$C529], a
    ld hl, $D0D6
    ld de, $9200
    ld a, [$C5DB]
    cp a, $05
    jr nz, Jump_016_7857
    ld de, $9400

Jump_016_7857::
    call Func_016_78DC
    ld a, [$D0E3]
    ld l, a
    ld a, [$D0E4]
    ld h, a
    call Func_000_16F5
    ld de, $C1E5
    ld a, [$C5DB]
    cp a, $05
    jr nz, Jump_016_7872
    ld de, $C225

Jump_016_7872::
    call Func_016_78C7
    ld a, [$D0E2]
    ld l, a
    ld h, $00
    call Func_000_16F5
    ld de, $C1E9
    ld a, [$C5DB]
    cp a, $05
    jr nz, Jump_016_788B
    ld de, $C229

Jump_016_788B::
    call Func_016_78CF
    ld a, [$D0E5]
    ld b, a
    ld c, $00
    ld hl, $D0E6
    call Func_016_78F9
    ld c, $01
    ld hl, $D0F2
    call Func_016_78F9
    ld c, $02
    ld hl, $D0FE
    call Func_016_78F9
    call Func_016_7990
    call Func_016_79B5
    ld hl, $8800
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $1202
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ret

Func_016_78C7::
    ld hl, $C8C0
    ld a, [hl]
    add a, $E0
    ld [de], a
    inc de

Func_016_78CF::
    ld hl, $C8C1
    ld a, [hl+]
    add a, $E0
    ld [de], a
    inc de
    ld a, [hl]
    add a, $E0
    ld [de], a
    ret

Func_016_78DC::
    ld a, e
    ld [$C52D], a
    ld a, d
    ld [$C52E], a
    ld de, $C130
    ld b, $0A

Jump_016_78E9::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_016_78E9
    ld a, $F0
    ld [de], a
    ld hl, $402B
    ld b, $08
    rst $10
    ret

Func_016_78F9::
    ld a, c
    cp a, b
    jr nc, Jump_016_7969
    push bc
    ld a, [hl+]
    ld [$D09D], a
    push hl
    ld a, c
    ld hl, Data_016_7A36
    push af
    ld a, [$C5DB]
    cp a, $05
    jr nz, Jump_016_7912
    ld hl, Data_016_7A39

Jump_016_7912::
    pop af
    add a, l
    ld l, a
    jr nc, Jump_016_7918
    inc h

Jump_016_7918::
    ld a, [hl]
    ld [$D09E], a
    push hl
    call Func_016_7A48
    pop hl
    ld a, [hl]
    swap a
    and a, $0F
    or a, $90
    ld d, a
    ld a, [hl]
    swap a
    and a, $F0
    ld e, a
    ld a, e
    add a, $10
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop hl
    push hl
    call Func_016_78DC
    pop hl
    ld a, l
    add a, $0A
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld l, [hl]
    ld h, $00
    call Func_000_16F5
    pop bc
    ld a, c
    ld hl, Data_016_7A3C
    push af
    ld a, [$C5DB]
    cp a, $05
    jr nz, Jump_016_795B
    ld hl, Data_016_7A42

Jump_016_795B::
    pop af
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_016_7962
    inc h

Jump_016_7962::
    ld e, [hl]
    inc hl
    ld d, [hl]
    call Func_016_78CF
    ret

Jump_016_7969::
    ld hl, Data_016_7A3C
    push af
    ld a, [$C5DB]
    cp a, $05
    jr nz, Jump_016_7977
    ld hl, Data_016_7A42

Jump_016_7977::
    pop af
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_016_797E
    inc h

Jump_016_797E::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, $FFF7
    add hl, de
    push bc
    ld b, $0B
    ld a, $C3

Jump_016_798A::
    ld [hl+], a
    dec b
    jr nz, Jump_016_798A
    pop bc
    ret

Func_016_7990::
    ld a, [$C5DB]
    cp a, $05
    jr z, Jump_016_79A6
    ld a, $C3
    ld [$C227], a
    ld [$C228], a
    ld [$C247], a
    ld [$C248], a
    ret

Jump_016_79A6::
    ld a, $C3
    ld [$C267], a
    ld [$C268], a
    ld [$C287], a
    ld [$C288], a
    ret

Func_016_79B5::
    ld hl, $93B0
    ld a, [$C5DB]
    cp a, $05
    jr nz, Jump_016_79C2
    ld hl, $95B0

Jump_016_79C2::
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0D01
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld a, [$D10B]
    bit 7, a
    jr nz, Jump_016_79EF
    ld a, [$D10C]
    add a, $0A
    ld [$C529], a
    xor a, a
    ld [$C528], a
    ld hl, $402B
    ld b, $08
    rst $10
    ret

Jump_016_79EF::
    ld a, [$D110]
    bit 7, a
    jr nz, Jump_016_7A22
    ld de, $C130
    ld a, [$D10E]
    inc a
    call Func_016_7A1E
    dec de
    ld a, [$D10F]
    add a, $11
    call Func_016_7A1E
    dec de
    ld a, $F0
    ld [de], a
    ld a, $08
    ld [$C528], a
    ld a, $05
    ld [$C529], a
    ld hl, $402B
    ld b, $08
    rst $10
    ret

Func_016_7A1E::
    call Func_000_24A2
    ret

Jump_016_7A22::
    ld a, [$D10D]
    and a, $3F
    ld [$C529], a
    ld a, $06
    ld [$C528], a
    ld hl, $400F
    ld b, $09
    rst $10
    ret

Data_016_7A36:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $25, $2B, $31

Data_016_7A39:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $45, $4B, $51

Data_016_7A3C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $22, $C2, $62, $C2, $A2, $C2

Data_016_7A42:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $62, $C2, $A2, $C2, $E2, $C2

Func_016_7A48::
    ld a, [$D09D]
    swap a
    ld de, Data_016_7ACD
    add a, e
    ld e, a
    jr nc, Jump_016_7A55
    inc d

Jump_016_7A55::
    ld b, $10
    call Func_016_7AAF
    ret

Func_016_7A5B::
    ld de, Data_016_7ACD
    ld b, $B0
    call Func_016_7AAF
    ret

Func_016_7A64::
    ld a, $0A
    ld [$0100], a
    ld a, $00
    ld [$4100], a
    ld a, $00
    ld h, $C7
    call Func_016_7A97
    ld a, [$C6FD]
    cp a, $01
    jr z, Jump_016_7A91
    ld a, $01
    ld h, $C8
    call Func_016_7A97
    ld a, [$C6FD]
    cp a, $02
    jr z, Jump_016_7A91
    ld a, $02
    ld h, $C9
    call Func_016_7A97

Jump_016_7A91::
    ld a, $00
    ld [$0100], a
    ret

Func_016_7A97::
    push hl
    ld c, $0D
    call Func_000_1F49
    ld a, [hl]
    and a, $0F
    swap a
    ld de, Data_016_7ACD
    add a, e
    ld e, a
    jr nc, Jump_016_7AAA
    inc d

Jump_016_7AAA::
    ld b, $10
    pop af
    jr Jump_016_7AB2

Func_016_7AAF::
    ld a, [$D09E]

Jump_016_7AB2::
    swap a
    ld h, a
    and a, $F0
    ld l, a
    ld a, h
    and a, $0F
    or a, $80
    ld h, a
    cp a, $88
    jr nc, Jump_016_7AC4
    set 4, h

Jump_016_7AC4::
    ld a, [de]
    call Func_000_121F
    inc de
    dec b
    jr nz, Jump_016_7AC4
    ret

Data_016_7ACD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $05BACD, $151

Data_016_7C1E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $05BC1E, $136
    ds $A7, $00

Data_016_7DFB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $9B, $00

Data_016_7E96:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $16A, $00
