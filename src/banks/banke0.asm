SECTION "Bank E0", ROMX[$4000], BANK[$E0]

Data_0E0_4000:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $E0

Func_0E0_4001::
    ld a, [$C5FE]
    rst $00
    dw Jump_0E0_4011
    dw Jump_0E0_406F
    dw Jump_0E0_40B7
    dw Jump_0E0_4123
    dw Jump_0E0_4175
    dw Jump_0E0_41BD

Jump_0E0_4011::
    ld hl, $8ED0
    ld de, $2101
    ld a, $02
    ld [$C528], a
    ld a, $06
    ld [$C529], a
    call Func_0E0_42A6
    ld hl, $9010
    ld de, $1001
    ld a, $00
    ld [$C528], a
    ld a, $00
    ld [$C529], a
    call Func_0E0_4279
    call Func_000_290E
    ld de, Data_0E0_42D3
    ld bc, $1412
    ld hl, $9800

Jump_0E0_4043::
    push bc
    push hl

Jump_0E0_4045::
    ld a, [de]
    inc de
    call Func_000_121F
    dec b
    jr nz, Jump_0E0_4045
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_0E0_4043
    call Func_0E0_41C7
    call Func_0E0_41E9
    call Func_0E0_421F
    call Func_0E0_425A
    ld hl, $C5FE
    inc [hl]
    ld a, $BB
    ld hl, $9842
    call Func_000_1211
    ret

Jump_0E0_406F::
    ld a, [$C562]
    bit 2, a
    jr z, Jump_0E0_407C
    ld a, $05
    ld [$C5FE], a
    ret

Jump_0E0_407C::
    ld a, [$C563]
    bit 6, a
    jr z, Jump_0E0_408A
    ld a, $04
    ld hl, $9982
    jr Jump_0E0_40A6

Jump_0E0_408A::
    bit 7, a
    jr z, Jump_0E0_4095
    ld a, $02
    ld hl, $98A2
    jr Jump_0E0_40A6

Jump_0E0_4095::
    and a, $30
    ret z
    ld a, [$C5F8]
    and a, $01
    xor a, $01
    ld [$C5F8], a
    call Func_0E0_41C7
    ret

Jump_0E0_40A6::
    ld [$C5FE], a
    ld a, $BB
    call Func_000_1211
    ld a, $C3
    ld hl, $9842
    call Func_000_1211
    ret

Jump_0E0_40B7::
    ld a, [$C562]
    and a, $04
    jr z, Jump_0E0_40C4
    ld a, $05
    ld [$C5FE], a
    ret

Jump_0E0_40C4::
    ld a, [$C562]
    and a, $01
    jr z, Jump_0E0_40D3
    xor a, a
    ld [$C5F9], a
    call Func_0E0_41E9
    ret

Jump_0E0_40D3::
    ld a, [$C563]
    bit 6, a
    jr z, Jump_0E0_40E1
    ld a, $01
    ld hl, $9842
    jr Jump_0E0_4112

Jump_0E0_40E1::
    bit 7, a
    jr z, Jump_0E0_40EC
    ld a, $03
    ld hl, $9922
    jr Jump_0E0_4112

Jump_0E0_40EC::
    bit 5, a
    jr z, Jump_0E0_40FF
    ld a, [$C5F9]
    dec a
    cp a, $FF
    jr nz, Jump_0E0_40FA
    ld a, $E3

Jump_0E0_40FA::
    ld [$C5F9], a
    jr Jump_0E0_410E

Jump_0E0_40FF::
    bit 4, a
    ret z
    ld a, [$C5F9]
    inc a
    cp a, $E4
    jr nz, Jump_0E0_410B
    xor a, a

Jump_0E0_410B::
    ld [$C5F9], a

Jump_0E0_410E::
    call Func_0E0_41E9
    ret

Jump_0E0_4112::
    ld [$C5FE], a
    ld a, $BB
    call Func_000_1211
    ld a, $C3
    ld hl, $98A2
    call Func_000_1211
    ret

Jump_0E0_4123::
    ld a, [$C562]
    and a, $04
    jr z, Jump_0E0_4130
    ld a, $05
    ld [$C5FE], a
    ret

Jump_0E0_4130::
    ld a, [$C563]
    bit 6, a
    jr z, Jump_0E0_413E
    ld a, $02
    ld hl, $98A2
    jr Jump_0E0_4164

Jump_0E0_413E::
    bit 7, a
    jr z, Jump_0E0_4149
    ld a, $04
    ld hl, $9982
    jr Jump_0E0_4164

Jump_0E0_4149::
    bit 5, a
    jr z, Jump_0E0_4156
    ld a, [$C5FA]
    dec a
    ld [$C5FA], a
    jr Jump_0E0_4160

Jump_0E0_4156::
    bit 4, a
    ret z
    ld a, [$C5FA]
    inc a
    ld [$C5FA], a

Jump_0E0_4160::
    call Func_0E0_421F
    ret

Jump_0E0_4164::
    ld [$C5FE], a
    ld a, $BB
    call Func_000_1211
    ld a, $C3
    ld hl, $9922
    call Func_000_1211
    ret

Jump_0E0_4175::
    ld a, [$C562]
    bit 2, a
    jr z, Jump_0E0_4182
    ld a, $05
    ld [$C5FE], a
    ret

Jump_0E0_4182::
    ld a, [$C563]
    bit 6, a
    jr z, Jump_0E0_4190
    ld a, $03
    ld hl, $9922
    jr Jump_0E0_41AC

Jump_0E0_4190::
    bit 7, a
    jr z, Jump_0E0_419B
    ld a, $01
    ld hl, $9842
    jr Jump_0E0_41AC

Jump_0E0_419B::
    and a, $30
    ret z
    ld a, [$D894]
    and a, $01
    xor a, $01
    ld [$D894], a
    call Func_0E0_425A
    ret

Jump_0E0_41AC::
    ld [$C5FE], a
    ld a, $BB
    call Func_000_1211
    ld a, $C3
    ld hl, $9982
    call Func_000_1211
    ret

Jump_0E0_41BD::
    xor a, a
    ld [$C5FE], a
    ld a, $03
    ld [$C5FD], a
    ret

Func_0E0_41C7::
    ld a, [$C5F8]
    and a, $01
    xor a, $01
    ld de, Data_0E0_41E6
    add a, e
    ld e, a
    jr nc, Jump_0E0_41D6
    inc d

Jump_0E0_41D6::
    ld a, [de]
    ld hl, $9869
    call Func_000_1211
    inc de
    ld a, [de]
    ld hl, $986D
    call Func_000_1211
    ret

Data_0E0_41E6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $BB, $C3, $BB

Func_0E0_41E9::
    ld a, [$C5F9]
    swap a
    and a, $0F
    add a, $01
    ld hl, $98CA
    call Func_000_121F
    ld a, [$C5F9]
    and a, $0F
    add a, $01
    call Func_000_1211
    ld de, $C130
    ld a, [$C5F9]
    ld l, a
    ld h, $04
    call Func_000_2E81
    ld a, $08
    ld [$C528], a
    ld a, $05
    ld [$C529], a
    ld hl, Func_008_402B
    ld b, $08
    rst $10
    ret

Func_0E0_421F::
    ld a, [$C5FA]
    ld l, a
    ld h, $00
    call Func_000_16F5
    ld c, $00
    ld hl, $994A
    ld a, [$C8C0]
    or a, a
    jr z, Jump_0E0_4239
    ld c, $01
    add a, $E0
    jr Jump_0E0_423B

Jump_0E0_4239::
    ld a, $C3

Jump_0E0_423B::
    call Func_000_121F
    ld a, [$C8C1]
    or a, a
    jr nz, Jump_0E0_4248
    bit 0, c
    jr z, Jump_0E0_424C

Jump_0E0_4248::
    add a, $E0
    jr Jump_0E0_424E

Jump_0E0_424C::
    ld a, $C3

Jump_0E0_424E::
    call Func_000_121F
    ld a, [$C8C2]
    add a, $E0
    call Func_000_1211
    ret

Func_0E0_425A::
    ld a, [$D894]
    and a, $01
    xor a, $01
    ld de, Data_0E0_41E6
    add a, e
    ld e, a
    jr nc, Jump_0E0_4269
    inc d

Jump_0E0_4269::
    ld a, [de]
    ld hl, $99A9
    call Func_000_1211
    inc de
    ld a, [de]
    ld hl, $99AD
    call Func_000_1211
    ret

Func_0E0_4279::
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld a, e
    ld [$C52F], a
    ld a, d
    ld [$C530], a
    ld hl, Func_008_402B
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

Func_0E0_42A6::
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld a, e
    ld [$C52F], a
    ld a, d
    ld [$C530], a
    ld hl, Func_009_400F
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

Data_0E0_42D3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0
    ds $12, $B1
    db $B2, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $C3, $ED, $EE, $EF, $F0, $F1, $F2, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $F3
    db $F4, $C3, $C3, $F5, $F6, $F7, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $C3, $ED, $EE, $EF, $FB, $FC, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $E0
    db $E0, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $80, $81, $82, $83, $84, $85, $86, $87, $88, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $C3, $FD, $FE, $FF, $00, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $BE, $E2, $E5, $E5, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $C3, $F8, $F9, $FA, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $F3
    db $F4, $C3, $C3, $F5, $F6, $F7, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B3
    ds $12, $B4
    db $B5

Func_0E0_443B::
    ld a, [$C5FD]
    rst $00
    dw Jump_0E0_445B
    dw Jump_0E0_448E
    dw Jump_0E0_4663
    dw Jump_0E0_46DD
    dw Jump_0E0_4724
    dw Jump_0E0_4728
    dw Jump_0E0_47F9
    dw Func_0E0_4804
    dw Jump_0E0_4825
    dw Jump_0E0_493B
    dw Jump_0E0_4A86
    dw Jump_0E0_4B54
    dw Jump_0E0_4C96
    dw Jump_0E0_4C9A

Jump_0E0_445B::
    ld hl, $8ED0
    ld de, $2301
    ld a, $02
    ld [$C528], a
    ld a, $04
    ld [$C529], a
    call Func_0E0_5553
    call Func_0E0_50EE
    ld hl, Data_0E0_448A
    ld a, [$C5FE]
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0E0_447D
    inc h

Jump_0E0_447D::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, $BB
    call Func_000_1211
    ld hl, $C5FD
    inc [hl]
    ret

Data_0E0_448A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $24, $98, $2A, $98

Jump_0E0_448E::
    ld a, [$C5FE]
    or a, a
    jr nz, Jump_0E0_4498
    ld c, $00
    jr Jump_0E0_449A

Jump_0E0_4498::
    ld c, $04

Jump_0E0_449A::
    call Func_0E0_44B3
    inc c
    call Func_0E0_44B3
    inc c
    call Func_0E0_44B3
    ld hl, $9A0B
    ld de, $D89F
    call Func_0E0_459A
    ld hl, $C5FD
    inc [hl]
    ret

Func_0E0_44B3::
    ld a, c
    and a, $03
    ld hl, Data_0E0_4652
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0E0_44BF
    inc h

Jump_0E0_44BF::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, c
    ld de, $DA63
    add a, e
    ld e, a
    jr nc, Jump_0E0_44CB
    inc d

Jump_0E0_44CB::
    ld a, [de]
    cp a, $FF
    jr z, Jump_0E0_452D
    ld de, $D8BF
    call Func_0E0_4593
    ld de, $D8CF
    call Func_0E0_4593
    ld de, $D8DF
    call Func_0E0_4593
    ld de, $D8EF
    call Func_0E0_4593
    inc hl
    ld de, $D8B7
    call Func_0E0_456B
    ld de, $D8FF
    call Func_0E0_455F
    ld de, $D90F
    call Func_0E0_455F
    ld de, $D91F
    call Func_0E0_455F
    ld de, $D92F
    call Func_0E0_455F
    ld de, $D968
    call Func_0E0_456B
    ld de, $D970
    call Func_0E0_456B
    ld de, $D978
    call Func_0E0_456B
    ld de, $D980
    call Func_0E0_456B
    dec hl
    ld de, $D93F
    call Func_0E0_4593
    call Func_0E0_4603
    call Func_0E0_462B
    ret

Jump_0E0_452D::
    xor a, a
    ldh [$FFC6], a
    ldh [$FFC7], a
    call Func_0E0_459D
    call Func_0E0_459D
    call Func_0E0_459D
    call Func_0E0_459D
    inc hl
    call Func_0E0_4583
    call Func_0E0_4583
    call Func_0E0_4583
    call Func_0E0_4583
    call Func_0E0_4583
    call Func_0E0_4583
    call Func_0E0_4583
    call Func_0E0_4583
    call Func_0E0_4583
    dec hl
    call Func_0E0_459D
    ret

Func_0E0_455F::
    ld a, c
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_0E0_4566
    inc d

Jump_0E0_4566::
    call Func_0E0_45EE
    jr Func_0E0_4583

Func_0E0_456B::
    ld a, c
    add a, e
    ld e, a
    jr nc, Jump_0E0_4571
    inc d

Jump_0E0_4571::
    push hl
    ld a, [de]
    ld [$C8C0], a
    xor a, a
    ld [$C8C1], a
    ld [$C8C2], a
    push bc
    call Func_000_173A
    pop bc
    pop hl

Func_0E0_4583::
    ld b, $00
    push hl
    call Func_0E0_45BE
    pop hl
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ret

Func_0E0_4593::
    ld a, c
    add a, a
    add a, e
    ld e, a
    jr nc, Func_0E0_459A
    inc d

Func_0E0_459A::
    call Func_0E0_45EE

Func_0E0_459D::
    push hl
    call Func_0E0_45AB
    pop hl
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ret

Func_0E0_45AB::
    ld b, $00
    ldh a, [$FFC7]
    swap a
    and a, $0F
    or a, a
    jr z, Jump_0E0_45BD
    add a, $E0
    call Func_000_1211
    ld b, $01

Jump_0E0_45BD::
    inc hl

Func_0E0_45BE::
    ldh a, [$FFC7]
    and a, $0F
    or a, a
    jr nz, Jump_0E0_45C9
    bit 0, b
    jr z, Jump_0E0_45D0

Jump_0E0_45C9::
    add a, $E0
    call Func_000_1211
    ld b, $01

Jump_0E0_45D0::
    inc hl
    ldh a, [$FFC6]
    swap a
    and a, $0F
    or a, a
    jr nz, Jump_0E0_45DE
    bit 0, b
    jr z, Jump_0E0_45E3

Jump_0E0_45DE::
    add a, $E0
    call Func_000_1211

Jump_0E0_45E3::
    inc hl
    ldh a, [$FFC6]
    and a, $0F
    add a, $E0
    call Func_000_1211
    ret

Func_0E0_45EE::
    push hl
    ld a, [de]
    ld [$C8C0], a
    inc de
    ld a, [de]
    ld [$C8C1], a
    xor a, a
    ld [$C8C2], a
    push bc
    call Func_000_173A
    pop bc
    pop hl
    ret

Func_0E0_4603::
    ld a, c
    ld hl, $DA53
    add a, l
    ld l, a
    jr nc, Jump_0E0_460C
    inc h

Jump_0E0_460C::
    ld a, [hl]
    ld hl, Data_0E0_465E
    add a, l
    ld l, a
    jr nc, Jump_0E0_4615
    inc h

Jump_0E0_4615::
    ld a, [hl]
    push af
    ld a, c
    and a, $03
    ld hl, Data_0E0_4658
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0E0_4623
    inc h

Jump_0E0_4623::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    pop af
    call Func_000_1211
    ret

Func_0E0_462B::
    ld a, c
    ld de, $D8AF
    add a, e
    ld e, a
    jr nc, Jump_0E0_4634
    inc d

Jump_0E0_4634::
    ld a, c
    and a, $03
    ld hl, Data_0E0_464C
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0E0_4640
    inc h

Jump_0E0_4640::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, [de]
    and a, $01
    add a, $CC
    call Func_000_1211
    ret

Data_0E0_464C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C6, $98, $CC, $98, $D2, $98

Data_0E0_4652:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $42, $98, $48, $98, $4E, $98

Data_0E0_4658:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $46, $99, $4C, $99, $52, $99

Data_0E0_465E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0B, $0A, $09, $08, $EF

Jump_0E0_4663::
    ld a, [$C562]
    and a, $04
    jr z, Jump_0E0_46A3
    ld hl, $D09D
    ld a, [$D88F]
    ld [hl+], a
    ld a, [$D890]
    ld [hl+], a
    ld a, [$D8A4]
    ld [hl+], a
    ld a, [$D8A5]
    ld [hl+], a
    ld a, [$D8A6]
    ld [hl], a
    ld a, $01
    ld [$D88F], a
    ld a, $01
    ld [$D890], a
    ld a, $0A
    ld [$C5FD], a
    call Func_0E0_50FD
    call Func_0E0_4FCE
    xor a, a
    ld [$C5FE], a
    call Func_0E0_4ABB
    ld a, $FF
    ld [$D802], a
    ret

Jump_0E0_46A3::
    ld a, [$C562]
    and a, $08
    jr z, Jump_0E0_46AF
    ld hl, $C5FD
    inc [hl]
    ret

Jump_0E0_46AF::
    ld a, [$C562]
    and a, $30
    jr z, Jump_0E0_46C4
    ld a, [$C5FE]
    inc a
    and a, $01
    ld [$C5FE], a
    xor a, a
    ld [$C5FD], a
    ret

Jump_0E0_46C4::
    ld a, [$C562]
    and a, $01
    jr z, Jump_0E0_46D1
    ld a, $04
    ld [$C5FD], a
    ret

Jump_0E0_46D1::
    ld a, [$C562]
    and a, $02
    ret z
    ld a, $07
    ld [$C5FD], a
    ret

Jump_0E0_46DD::
    ld de, $C198
    ld hl, $9800
    ld bc, $1412

Jump_0E0_46E6::
    push bc
    push hl

Jump_0E0_46E8::
    ld a, [de]
    inc de
    call Func_000_121F
    dec b
    jr nz, Jump_0E0_46E8
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    ld a, $20
    sub a, b
    add a, e
    ld e, a
    jr nc, Jump_0E0_46FE
    inc d

Jump_0E0_46FE::
    dec c
    jr nz, Jump_0E0_46E6
    ld a, [$D88F]
    ld b, a
    ld c, $00
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_0E0_4710
    ld c, $04

Jump_0E0_4710::
    ld a, c
    ld hl, $D095
    add a, l
    ld l, a
    jr nc, Jump_0E0_4719
    inc h

Jump_0E0_4719::
    ld [hl], $07
    inc c
    dec b
    jr nz, Jump_0E0_4710
    xor a, a
    ld [$C5FC], a
    ret

Jump_0E0_4724::
    call Func_0E0_4804
    ret

Jump_0E0_4728::
    ld hl, $9861
    ld de, $DA72
    call Func_0E0_4763
    ld hl, $9867
    ld de, $DA79
    call Func_0E0_4763
    ld hl, $986D
    ld de, $DA80
    call Func_0E0_4763
    ld hl, $9941
    ld de, $DA8E
    call Func_0E0_4763
    ld hl, $9947
    ld de, $DA95
    call Func_0E0_4763
    ld hl, $994D
    ld de, $DA9C
    call Func_0E0_4763
    ld hl, $C5FD
    inc [hl]
    ret

Func_0E0_4763::
    ld a, [de]
    ld c, a
    call Func_0E0_47E6
    call Func_0E0_47EB
    call Func_0E0_47F0
    call Func_0E0_47E0
    call Func_0E0_47E6
    ld a, l
    add a, $1B
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    call Func_0E0_47EB
    call Func_0E0_47F0
    call Func_0E0_47E0
    call Func_0E0_47E6
    call Func_0E0_47EB
    ld a, l
    add a, $1B
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    call Func_0E0_47F0
    call Func_0E0_47E0
    call Func_0E0_47E6
    call Func_0E0_47EB
    call Func_0E0_47F0
    ld a, l
    add a, $1B
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    call Func_0E0_47E0
    call Func_0E0_47E6
    call Func_0E0_47EB
    call Func_0E0_47F0
    call Func_0E0_47E0
    ld a, l
    add a, $1B
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    call Func_0E0_47E6
    call Func_0E0_47EB
    call Func_0E0_47F0
    call Func_0E0_47E0
    call Func_0E0_47E6
    ld a, l
    add a, $1B
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    call Func_0E0_47EB
    ld a, c
    rlca
    rlca
    jr Jump_0E0_47F1

Func_0E0_47E0::
    inc de
    ld a, [de]
    rlca
    rlca
    jr Jump_0E0_47F1

Func_0E0_47E6::
    ld a, [de]
    swap a
    jr Jump_0E0_47F1

Func_0E0_47EB::
    ld a, [de]
    rrca
    rrca
    jr Jump_0E0_47F1

Func_0E0_47F0::
    ld a, [de]

Jump_0E0_47F1::
    and a, $03
    add a, $E0
    call Func_000_121F
    ret

Jump_0E0_47F9::
    ld a, [$C562]
    and a, $01
    ret z
    xor a, a
    ld [$C5FD], a
    ret

Func_0E0_4804::
    ld de, Data_0E0_4946
    ld hl, $9820
    ld bc, $1410

Jump_0E0_480D::
    push bc
    push hl

Jump_0E0_480F::
    ld a, [de]
    inc de
    call Func_000_121F
    dec b
    jr nz, Jump_0E0_480F
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_0E0_480D
    ld hl, $C5FD
    inc [hl]
    ret

Jump_0E0_4825::
    ld de, $D989
    ld hl, $9862
    call Func_0E0_4863
    ld de, $D999
    ld hl, $9868
    call Func_0E0_4863
    ld de, $D9A9
    ld hl, $986E
    call Func_0E0_4863
    ld de, $D9C9
    ld hl, $9942
    call Func_0E0_4863
    ld de, $D9D9
    ld hl, $9948
    call Func_0E0_4863
    ld de, $D9E9
    ld hl, $994E
    call Func_0E0_4863
    call Func_0E0_489C
    ld hl, $C5FD
    inc [hl]
    ret

Func_0E0_4863::
    push hl
    call Func_0E0_4870
    pop hl
    ld a, l
    add a, $03
    ld l, a
    ld a, h
    adc a, $00
    ld h, a

Func_0E0_4870::
    ld b, $04

Jump_0E0_4872::
    ld a, [de]
    swap a
    and a, $0F
    call Func_0E0_488E
    ld a, [de]
    and a, $0F
    call Func_0E0_488E
    ld a, l
    add a, $1E
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc de
    inc de
    dec b
    jr nz, Jump_0E0_4872
    ret

Func_0E0_488E::
    cp a, $0A
    jr nc, Jump_0E0_4896
    add a, $E0
    jr Jump_0E0_4898

Jump_0E0_4896::
    sub a, $02

Jump_0E0_4898::
    call Func_000_121F
    ret

Func_0E0_489C::
    ld de, $004E
    ld hl, $D0ED
    add hl, de
    add hl, de
    add hl, de
    ld b, $00
    call Func_0E0_48B7
    add hl, de
    ld b, $01
    call Func_0E0_48B7
    add hl, de
    ld b, $02
    call Func_0E0_48B7
    ret

Func_0E0_48B7::
    push af
    push bc
    push de
    push hl
    ld a, [hl+]
    ld [$C8C0], a
    ld a, [hl+]
    ld [$C8C1], a
    ld a, [hl]
    ld [$C8C2], a
    call Func_000_173A
    pop hl
    pop de
    pop bc
    pop af
    push hl
    ld a, b
    ld hl, Data_0E0_4935
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0E0_48D9
    inc h

Jump_0E0_48D9::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld b, $00
    ldh a, [$FFC8]
    and a, $0F
    or a, a
    jr z, Jump_0E0_48EC
    add a, $E0
    call Func_000_1211
    ld b, $01

Jump_0E0_48EC::
    inc hl
    ldh a, [$FFC7]
    swap a
    and a, $0F
    or a, a
    jr nz, Jump_0E0_48FA
    bit 0, b
    jr z, Jump_0E0_4901

Jump_0E0_48FA::
    add a, $E0
    call Func_000_1211
    ld b, $01

Jump_0E0_4901::
    inc hl
    ldh a, [$FFC7]
    and a, $0F
    or a, a
    jr nz, Jump_0E0_490D
    bit 0, b
    jr z, Jump_0E0_4914

Jump_0E0_490D::
    add a, $E0
    call Func_000_1211
    ld b, $01

Jump_0E0_4914::
    inc hl
    ldh a, [$FFC6]
    swap a
    and a, $0F
    or a, a
    jr nz, Jump_0E0_4922
    bit 0, b
    jr z, Jump_0E0_4929

Jump_0E0_4922::
    add a, $E0
    call Func_000_1211
    ld b, $01

Jump_0E0_4929::
    inc hl
    ldh a, [$FFC6]
    and a, $0F
    add a, $E0
    call Func_000_1211
    pop hl
    ret

Data_0E0_4935:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $E2, $99, $E8, $99, $EE, $99

Jump_0E0_493B::
    ld a, [$C562]
    and a, $02
    ret z
    xor a, a
    ld [$C5FD], a
    ret

Data_0E0_4946:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0
    ds $12, $B1
    db $B2, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $F5, $F6, $F7, $C3, $C3, $C3, $C3
    db $C3, $C3

Data_0E0_496B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $F8, $C3, $F9, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B3
    ds $12, $B4
    db $B5

Jump_0E0_4A86::
    ld a, [$D802]
    cp a, $FF
    jr z, Jump_0E0_4A94
    ld hl, Func_03A_54DC
    ld b, $3A
    rst $10
    ret

Jump_0E0_4A94::
    ld a, [$C562]
    and a, $10
    jr z, Jump_0E0_4AA8
    ld hl, $C5FE
    inc [hl]
    ld a, [hl]
    cp a, $3C
    jr nz, Func_0E0_4ABB
    xor a, a
    ld [hl], a
    jr Func_0E0_4ABB

Jump_0E0_4AA8::
    ld a, [$C562]
    and a, $20
    jr z, Jump_0E0_4AE7
    ld hl, $C5FE
    dec [hl]
    ld a, [hl]
    cp a, $FF
    jr nz, Func_0E0_4ABB
    ld a, $3B
    ld [hl], a

Func_0E0_4ABB::
    push af
    and a, $0F
    cp a, $0A
    jr nc, Jump_0E0_4AC6
    add a, $E0
    jr Jump_0E0_4AC8

Jump_0E0_4AC6::
    sub a, $02

Jump_0E0_4AC8::
    ld hl, $988A
    call Func_000_1211
    pop af
    swap a
    and a, $0F
    cp a, $0A
    jr nc, Jump_0E0_4ADB
    add a, $E0
    jr Jump_0E0_4ADD

Jump_0E0_4ADB::
    sub a, $02

Jump_0E0_4ADD::
    ld hl, $9889
    call Func_000_1211
    call Func_0E0_4FCE
    ret

Jump_0E0_4AE7::
    ld a, [$C562]
    and a, $01
    jr z, Jump_0E0_4AF8
    ld hl, Func_03A_548F
    ld b, $3A
    rst $10
    call Func_0E0_558E
    ret

Jump_0E0_4AF8::
    ld a, [$C562]
    and a, $04
    jr z, Jump_0E0_4B2D
    ld hl, $D09D
    ld a, [hl+]
    ld [$D88F], a
    ld a, [hl+]
    ld [$D890], a
    ld a, [hl+]
    ld [$D8A4], a
    ld a, [hl+]
    ld [$D8A5], a
    ld a, [hl]
    ld [$D8A6], a
    ld a, $0B
    ld [$C5FD], a
    xor a, a
    ld [$C5FE], a
    call Func_0E0_510C
    call Func_0E0_4F28
    xor a, a
    ld [$C5FF], a
    call Func_0E0_4EFD
    ret

Jump_0E0_4B2D::
    ld a, [$C562]
    and a, $02
    ret z
    ld hl, $D09D
    ld a, [hl+]
    ld [$D88F], a
    ld a, [hl+]
    ld [$D890], a
    ld a, [hl+]
    ld [$D8A4], a
    ld a, [hl+]
    ld [$D8A5], a
    ld a, [hl]
    ld [$D8A6], a
    xor a, a
    ld [$C5FD], a
    ld a, $FF
    ld [$D802], a
    ret

Jump_0E0_4B54::
    call Func_0E0_4C7E
    ld a, [$C562]
    and a, $08
    jr z, Jump_0E0_4B74
    ld hl, $C5FE
    inc [hl]
    ld a, [hl]
    cp a, $08
    jr nz, Jump_0E0_4B69
    xor a, a
    ld [hl], a

Jump_0E0_4B69::
    call Func_0E0_4F28
    xor a, a
    ld [$C5FF], a
    call Func_0E0_4EFD
    ret

Jump_0E0_4B74::
    ld a, [$C562]
    and a, $20
    jr z, Jump_0E0_4B9C
    ld a, [$C0A2]
    call Func_000_1211
    ld hl, $C5FF
    ld a, [hl]
    and a, $0F
    dec a
    and a, $0F
    cp a, $0F
    jr nz, Jump_0E0_4B93
    ld a, [hl]
    and a, $F0
    or a, $07

Jump_0E0_4B93::
    push af
    ld a, [hl]
    and a, $F0
    pop bc
    or a, b
    ld [hl], a
    jr Jump_0E0_4C10

Jump_0E0_4B9C::
    ld a, [$C562]
    and a, $10
    jr z, Jump_0E0_4BC2
    ld a, [$C0A2]
    call Func_000_1211
    ld hl, $C5FF
    ld a, [hl]
    and a, $0F
    inc a
    and a, $0F
    cp a, $08
    jr nz, Jump_0E0_4BB9
    ld a, [hl]
    and a, $F0

Jump_0E0_4BB9::
    push af
    ld a, [hl]
    and a, $F0
    pop bc
    or a, b
    ld [hl], a
    jr Jump_0E0_4C10

Jump_0E0_4BC2::
    ld a, [$C562]
    and a, $40
    jr z, Jump_0E0_4BEB
    ld a, [$C0A2]
    call Func_000_1211
    ld hl, $C5FF
    ld a, [hl]
    and a, $F0
    sub a, $10
    and a, $F0
    cp a, $F0
    jr nz, Jump_0E0_4BE2
    ld a, [hl]
    and a, $0F
    or a, $80

Jump_0E0_4BE2::
    push af
    ld a, [hl]
    and a, $0F
    pop bc
    or a, b
    ld [hl], a
    jr Jump_0E0_4C10

Jump_0E0_4BEB::
    ld a, [$C562]
    and a, $80
    jr z, Jump_0E0_4C14
    ld a, [$C0A2]
    call Func_000_1211
    ld hl, $C5FF
    ld a, [hl]
    and a, $F0
    add a, $10
    and a, $F0
    cp a, $90
    jr nz, Jump_0E0_4C09
    ld a, [hl]
    and a, $0F

Jump_0E0_4C09::
    push af
    ld a, [hl]
    and a, $0F
    pop bc
    or a, b
    ld [hl], a

Jump_0E0_4C10::
    call Func_0E0_4EFD
    ret

Jump_0E0_4C14::
    ld a, [$C562]
    and a, $01
    jr z, Jump_0E0_4C6B
    ld a, [$C0A2]
    xor a, $01
    ld [$C0A2], a
    ld a, [$C0A0]
    ld l, a
    ld a, [$C0A1]
    ld h, a
    ld a, [$C0A2]
    call Func_000_1211
    ld a, [$C5FE]
    ld hl, $D80C
    call Func_000_3F25
    ld a, [$C5FF]
    ld e, a
    swap a
    and a, $0F
    ld c, a
    ld b, $00
    add hl, bc
    ld a, [$C0A2]
    and a, $01
    jr z, Jump_0E0_4C5C
    ld a, e
    ld de, Data_0E0_4C76
    and a, $0F
    add a, e
    ld e, a
    jr nc, Jump_0E0_4C58
    inc d

Jump_0E0_4C58::
    ld a, [de]
    or a, [hl]
    ld [hl], a
    ret

Jump_0E0_4C5C::
    ld a, e
    ld de, Data_0E0_4C6E
    and a, $0F
    add a, e
    ld e, a
    jr nc, Jump_0E0_4C67
    inc d

Jump_0E0_4C67::
    ld a, [de]
    and a, [hl]
    ld [hl], a
    ret

Jump_0E0_4C6B::
    jp Jump_0E0_4B2D

Data_0E0_4C6E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FE, $FD, $FB, $F7, $EF, $DF, $BF, $7F

Data_0E0_4C76:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $02, $04, $08, $10, $20, $40, $80

Func_0E0_4C7E::
    ld a, [$C0A0]
    ld l, a
    ld a, [$C0A1]
    ld h, a
    ld a, [$C5F0]
    bit 3, a
    ld a, $C3
    jr z, Jump_0E0_4C92
    ld a, [$C0A2]

Jump_0E0_4C92::
    call Func_000_1211
    ret

Jump_0E0_4C96::
    call Func_0E0_4001
    ret

Jump_0E0_4C9A::
    ld a, [$C5FE]
    rst $00
    dw Jump_0E0_4CAA
    dw Jump_0E0_4CF6
    dw Jump_0E0_4D0B
    dw Jump_0E0_4D17
    dw Jump_0E0_4D72
    dw Jump_0E0_4D89

Jump_0E0_4CAA::
    ld hl, $9010
    ld de, $1001
    ld a, $00
    ld [$C528], a
    ld a, $00
    ld [$C529], a
    call Func_0E0_4279
    ld hl, $8800
    ld de, $1201
    ld a, $0E
    ld [$C528], a
    ld a, $00
    ld [$C529], a
    call Func_0E0_4279
    ld de, Data_0E0_4D95
    ld bc, $1412
    ld hl, $9800

Jump_0E0_4CD9::
    push bc
    push hl

Jump_0E0_4CDB::
    ld a, [de]
    inc de
    call Func_000_121F
    dec b
    jr nz, Jump_0E0_4CDB
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_0E0_4CD9
    xor a, a
    ld [$D8A4], a
    ld a, $01
    ld [$C5FE], a
    ret

Jump_0E0_4CF6::
    ld a, [$D8A4]
    call Func_0E0_7A80
    ld [$D2C7], a
    ld hl, Func_0E0_56C7
    ld b, $E0
    rst $10
    ld a, $02
    ld [$C5FE], a
    ret

Jump_0E0_4D0B::
    ld hl, Func_0E0_572D
    ld b, $E0
    rst $10
    ld a, $03
    ld [$C5FE], a
    ret

Jump_0E0_4D17::
    ld a, [$C562]
    bit 1, a
    jr z, Jump_0E0_4D2A
    ld a, $04
    ld [$C5FE], a
    xor a, a
    ld hl, $CFCA
    ld [hl+], a
    ld [hl], a
    ret

Jump_0E0_4D2A::
    ld a, [$C563]
    bit 0, a
    jr z, Jump_0E0_4D37
    ld a, $01
    ld [$C5FE], a
    ret

Jump_0E0_4D37::
    bit 5, a
    jr z, Jump_0E0_4D4F

Jump_0E0_4D3B::
    ld a, [$D8A4]
    dec a
    and a, $07
    ld [$D8A4], a
    call Func_000_3E54
    jr z, Jump_0E0_4D3B
    ld a, $01
    ld [$C5FE], a
    ret

Jump_0E0_4D4F::
    bit 4, a
    jr z, Jump_0E0_4D67

Jump_0E0_4D53::
    ld a, [$D8A4]
    inc a
    and a, $07
    ld [$D8A4], a
    call Func_000_3E54
    jr z, Jump_0E0_4D53
    ld a, $01
    ld [$C5FE], a
    ret

Jump_0E0_4D67::
    bit 2, a
    jr z, Jump_0E0_4D71
    ld a, $05
    ld [$C5FE], a
    ret

Jump_0E0_4D71::
    ret

Jump_0E0_4D72::
    xor a, a
    ld [$D8A4], a
    ld [$C5FE], a
    ld a, $03
    ld [$C5FD], a
    ld a, $FF
    ld hl, $DA1C
    ld bc, $0010
    jp Func_000_0949

Jump_0E0_4D89::
    ld hl, Func_0E0_5A35
    ld b, $E0
    rst $10
    ld a, $02
    ld [$C5FE], a
    ret

Data_0E0_4D95:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0
    ds $12, $B1
    db $B2, $B6, $C3, $C3, $80, $81, $82, $01, $C3, $C3, $9B, $9C, $9D, $9E, $9F, $A0
    db $A1, $A2, $C3, $C3, $B7, $B6, $C3, $C3, $8B, $8C, $C3, $C3, $C3, $C3, $ED, $EE
    db $EF, $F0, $F1, $F2, $F3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3

Data_0E0_4DDC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $380DDC, $DA

Data_0E0_4EB6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $C3, $C3, $C3, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $C3
    db $C3, $C3, $C3, $C3, $B7, $B3
    ds $12, $B4
    db $B5

Func_0E0_4EFD::
    ld a, [$C5FF]
    ld b, a
    and a, $0F
    ld c, a
    ld a, b
    swap a
    and a, $0F
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld b, $00
    add hl, bc
    ld bc, $9889
    add hl, bc
    ld a, l
    ld [$C0A0], a
    ld a, h
    ld [$C0A1], a
    call Func_000_120A
    ld a, [hl]
    ld [$C0A2], a
    ret

Func_0E0_4F28::
    ld a, [$C5FE]
    call Func_0E0_4F86
    ld hl, $9889
    ld a, l
    ld [$D868], a
    ld a, h
    ld [$D869], a
    ld c, $00
    ld a, [$C5FE]
    ld hl, $D80C
    call Func_000_3F25

Jump_0E0_4F44::
    ld d, [hl]
    ld b, $00

Jump_0E0_4F47::
    push hl
    ld a, [$D868]
    ld l, a
    ld a, [$D869]
    ld h, a
    ld a, l
    add a, b
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, d
    and a, $01
    add a, $E0
    call Func_000_1211
    pop hl
    srl d
    inc b
    ld a, b
    cp a, $08
    jr nz, Jump_0E0_4F47
    push hl
    ld a, [$D868]
    ld l, a
    ld a, [$D869]
    ld h, a
    ld de, $0020
    add hl, de
    ld a, l
    ld [$D868], a
    ld a, h
    ld [$D869], a
    pop hl
    inc hl
    inc c
    ld a, c
    cp a, $09
    jr nz, Jump_0E0_4F44
    ret

Func_0E0_4F86::
    add a, a
    ld hl, Data_0E0_4F9E
    add a, l
    ld l, a
    jr nc, Jump_0E0_4F8F
    inc h

Jump_0E0_4F8F::
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, $9827
    ld bc, $0401
    ld a, $E0
    call Func_000_15DE
    ret

Data_0E0_4F9E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_0E0_4FAE
    dw Data_0E0_4FB2
    dw Data_0E0_4FB6
    dw Data_0E0_4FBA
    dw Data_0E0_4FBE
    dw Data_0E0_4FC2
    dw Data_0E0_4FC6
    dw Data_0E0_4FCA

Data_0E0_4FAE:: ; heuristic: target of a monotone pointer table; C0
    db $F5, $F6, $F7, $E0

Data_0E0_4FB2:: ; heuristic: target of a monotone pointer table; C0
    db $F5, $F6, $F7, $E1

Data_0E0_4FB6:: ; heuristic: target of a monotone pointer table; C0
    db $F5, $F6, $F7, $E2

Data_0E0_4FBA:: ; heuristic: target of a monotone pointer table; C0
    db $F5, $F6, $F7, $E3

Data_0E0_4FBE:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F9, $E0, $C3

Data_0E0_4FC2:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F9, $E1, $C3

Data_0E0_4FC6:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F9, $E2, $C3

Data_0E0_4FCA:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F9, $E3, $C3

Func_0E0_4FCE::
    call Func_0E0_4FDB
    call Func_0E0_502B
    ld hl, Func_03A_53B9
    ld b, $3A
    rst $10
    ret

Func_0E0_4FDB::
    ld a, $00
    ld [$D868], a
    ld a, [$C5F9]
    ld [$CFEC], a
    xor a, a
    ld [$CFED], a
    ld a, $01
    ld [$D869], a
    ld hl, $CFEE
    ld a, l
    ld [$D86A], a
    ld a, h
    ld [$D86B], a
    ld hl, Func_01A_4022
    ld b, $1A
    rst $10
    ld a, [$CFEE]
    ld l, a
    ld h, $00
    call Func_000_16F5
    ld a, [$C8C0]
    add a, $E0
    ld hl, $9A04
    call Func_000_1211
    ld a, [$C8C1]
    add a, $E0
    ld hl, $9A05
    call Func_000_1211
    ld a, [$C8C2]
    add a, $E0
    ld hl, $9A06
    call Func_000_1211
    ret

Func_0E0_502B::
    ld a, [$C5F9]
    ld [$CFEC], a
    xor a, a
    ld [$CFED], a
    ld hl, Func_01A_4001
    ld b, $1A
    rst $10
    ld a, [$CFF7]
    ld l, a
    ld a, [$CFF8]
    ld h, a
    push hl
    call Func_000_16F5
    ld a, [$C8C0]
    add a, $E0
    ld hl, $99C3
    call Func_000_1211
    ld a, [$C8C1]
    add a, $E0
    ld hl, $99C4
    call Func_000_1211
    ld a, [$C8C2]
    add a, $E0
    ld hl, $99C5
    call Func_000_1211
    pop hl
    ld a, [$CFF9]
    ld c, a
    ld b, $00
    add hl, bc
    call Func_000_16F5
    ld a, [$C8C0]
    add a, $E0
    ld hl, $99E3
    call Func_000_1211
    ld a, [$C8C1]
    add a, $E0
    ld hl, $99E4
    call Func_000_1211
    ld a, [$C8C2]
    add a, $E0
    ld hl, $99E5
    call Func_000_1211
    ld a, [$CFFB]
    ld l, a
    ld a, [$CFFC]
    ld h, a
    push hl
    call Func_000_16F5
    ld a, [$C8C0]
    add a, $E0
    ld hl, $99C7
    call Func_000_1211
    ld a, [$C8C1]
    add a, $E0
    ld hl, $99C8
    call Func_000_1211
    ld a, [$C8C2]
    add a, $E0
    ld hl, $99C9
    call Func_000_1211
    pop hl
    ld a, [$CFFD]
    ld c, a
    ld b, $00
    add hl, bc
    call Func_000_16F5
    ld a, [$C8C0]
    add a, $E0
    ld hl, $99E7
    call Func_000_1211
    ld a, [$C8C1]
    add a, $E0
    ld hl, $99E8
    call Func_000_1211
    ld a, [$C8C2]
    add a, $E0
    ld hl, $99E9
    call Func_000_1211
    ret

Func_0E0_50EE::
    ld hl, $9800
    ld de, Data_0E0_511B
    ld bc, $1412
    ld a, $E0
    call Func_000_15DE
    ret

Func_0E0_50FD::
    ld hl, $9800
    ld de, Data_0E0_5283
    ld bc, $1412
    ld a, $E0
    call Func_000_15DE
    ret

Func_0E0_510C::
    ld hl, $9800
    ld de, Data_0E0_53EB
    ld bc, $1412
    ld a, $E0
    call Func_000_15DE
    ret

Data_0E0_511B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0
    ds $12, $B1
    db $B2, $B6, $C3, $C3, $C3, $C3, $F5, $F6, $F7, $C3, $C3, $C3, $F8, $F9, $C3, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6, $EB, $C3, $C3, $C3, $C3, $C3, $EB, $C3, $C3, $C3
    db $C3, $C3, $EB, $C3, $C3, $C3, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $EC, $C3, $C3, $C3, $C3, $C3, $EC, $C3, $C3, $C3, $C3, $C3, $EC, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6
    ds $12, $C3
    INCBIN "dwm2-cobi-us.gbc", $381192, $AA

Data_0E0_523C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $C3, $C3, $C3, $F1, $03, $C3, $C3, $C3, $C3, $B7, $B6, $F1, $07, $C3, $C3
    db $C3, $C3, $F1, $07, $C3, $C3, $C3, $C3, $F1, $07, $C3, $C3, $C3, $C3, $B7, $B6
    db $C3, $C3, $C3, $C3, $FA, $FB, $FC, $FD, $FE, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $B7, $B3
    ds $12, $B4
    db $B5

Data_0E0_5283:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0
    ds $12, $B1
    db $B2, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $C3, $C3, $C3, $0E, $09, $0F, $C3, $0C, $0D, $0D, $0C, $0A, $FF
    db $C3, $C3

Data_0E0_52BC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $C3, $C3, $C3, $C3

Data_0E0_5301:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3
    db $C3, $C3, $C3, $C3, $C3, $14, $15, $16, $17, $18, $19, $C3, $C3, $C3

Data_0E0_531F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $38131F, $B9
    ds $12, $B4
    db $B5

Data_0E0_53EB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0
    ds $12, $B1
    db $B2, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $C3, $C3, $C3, $09, $F0, $FF, $C3, $E0, $E1, $E2, $E3, $E4, $E5
    db $E6, $E7, $C3, $C3, $B7, $B6
    ds $12, $C3
    INCBIN "dwm2-cobi-us.gbc", $38143A, $85

Data_0E0_54BF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $09, $FF, $E7, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $09, $FF
    db $E8, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B3
    ds $12, $B4
    db $B5

Func_0E0_5553::
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
    ld hl, Func_009_400F
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

Func_0E0_558E::
    ld a, [$C5FE]
    ld hl, Func_0E0_55BF
    add a, l
    ld l, a
    jr nc, Jump_0E0_5599
    inc h

Jump_0E0_5599::
    ld a, [hl]
    call Func_000_1278
    ret

Func_0E0_559E:: ; heuristic: follows a terminator; C0
    add a, a
    add a, a
    ld hl, Data_0E0_55FB
    add a, l
    ld l, a
    jr nc, Jump_0E0_55A8
    inc h

Jump_0E0_55A8::
    ld a, [hl+]
    ld [$D8A4], a
    ld a, [hl+]
    ld [$D8A5], a
    ld a, [hl+]
    ld [$D8A6], a
    ld a, [hl]
    ld [$DAD3], a
    ld hl, Func_03A_5762
    ld b, $3A
    rst $10
    ret

Func_0E0_55BF:: ; heuristic: follows a terminator; C0
    adc a, c
    adc a, e
    adc a, e
    adc a, l
    adc a, l
    adc a, a
    sub a, b
    reti
    db $91, $93, $93, $94, $95, $95, $96, $97, $97, $98, $87, $86, $85, $88, $88, $99
    db $9A, $9B, $9D

Data_0E0_55DA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $9E, $9F, $99, $A2, $A3, $A4, $A5, $A7, $A8, $DA, $99, $A9, $AA, $AB, $AC, $AE
    db $B0, $85, $B2, $B4, $B8, $B6, $DC, $BA, $BC, $BD, $BF, $C1, $C3, $C5, $C7, $C9
    db $CB

Data_0E0_55FB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $3815FB, $CC

Func_0E0_56C7::
    ld a, [$D8A4]
    ld hl, $DA1C
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0E0_56D3
    inc h

Jump_0E0_56D3::
    ld a, $FF
    ld [hl+], a
    ld [hl], a
    ld a, [$C58A]
    or a, a
    jr z, Jump_0E0_570B
    ld a, [$C5BA]
    ld l, a
    ld a, [$C5BB]
    ld h, a
    push hl
    ld a, [$C5E7]
    ld l, a
    ld a, [$C5E8]
    ld h, a
    push hl
    ld hl, Func_030_4595
    ld b, $30
    rst $10
    call Func_0E0_5715
    pop hl
    ld a, l
    ld [$C5E7], a
    ld a, h
    ld [$C5E8], a
    pop hl
    ld a, l
    ld [$C5BA], a
    ld a, h
    ld [$C5BB], a
    ret

Jump_0E0_570B::
    ld hl, Func_030_4595
    ld b, $30
    rst $10
    call Func_0E0_5715
    ret

Func_0E0_5715::
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0E0_5721
    inc h

Jump_0E0_5721::
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_0E0_572C
    ld hl, Func_039_4001
    ld b, $39
    rst $10

Jump_0E0_572C::
    ret

Func_0E0_572D::
    call Func_0E0_5992
    ld hl, Data_0E0_5A05
    call Func_000_0B0D
    ld d, h
    ld e, l
    ld hl, $9823
    ld b, $04

Jump_0E0_573D::
    di
    ld a, [de]
    call Func_000_121F
    ei
    inc de
    dec b
    jr nz, Jump_0E0_573D
    ld hl, $89B0
    ld de, $0801
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld a, e
    ld [$C52F], a
    ld a, d
    ld [$C530], a
    call Func_000_290E
    ld a, [$D8A4]
    and a, $03
    cp a, $03
    jr z, Jump_0E0_578A
    ld a, [$D8A4]
    ld hl, $DA43
    add a, l
    ld l, a
    jr nc, Jump_0E0_5774
    inc h

Jump_0E0_5774::
    ld a, [hl]
    and a, $03
    add a, $02
    ld [$C529], a
    ld a, $0E
    ld [$C528], a
    ld hl, $89B0
    ld de, $0801
    call Func_0E0_5A79

Jump_0E0_578A::
    ld a, [$D8A4]
    ld de, $DA53
    add a, e
    ld e, a
    jr nc, Jump_0E0_5795
    inc d

Jump_0E0_5795::
    ld a, [de]
    add a, $8D
    ld hl, $9846
    di
    call Func_000_1211
    ei
    ld hl, $8ED0
    ld de, $0701
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld a, e
    ld [$C52F], a
    ld a, d
    ld [$C530], a
    call Func_000_290E
    ld a, [$D8A4]
    call Func_0E0_7A80
    ld [$C529], a
    ld a, $07
    ld [$C528], a
    ld hl, $8ED0
    ld de, $0701
    call Func_0E0_5A79
    ld a, [$C58A]
    cp a, $01
    ld a, [$D8A4]
    jr z, Jump_0E0_57DE
    sub a, $04
    jr nc, Jump_0E0_57F0

Jump_0E0_57DE::
    ld a, $C3
    ld hl, $99AF
    di
    call Func_000_121F
    call Func_000_121F
    call Func_000_1211
    ei
    jr Jump_0E0_581A

Jump_0E0_57F0::
    ld de, $CFDE
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_0E0_57F9
    inc d

Jump_0E0_57F9::
    ld hl, $99AF
    ld a, [de]
    and a, $0F
    inc a
    di
    call Func_000_121F
    ei
    dec de
    ld a, [de]
    and a, $F0
    swap a
    inc a
    di
    call Func_000_121F
    ei
    ld a, [de]
    and a, $0F
    inc a
    di
    call Func_000_121F
    ei

Jump_0E0_581A::
    ld a, [$D8A4]
    swap a
    ld hl, $D988
    add a, l
    ld l, a
    jr nc, Jump_0E0_5827
    inc h

Jump_0E0_5827::
    ld d, h
    ld e, l
    ld hl, $98A2
    ld b, $08

Jump_0E0_582E::
    push hl
    ld a, [de]
    and a, $0F
    inc a
    di
    call Func_000_121F
    ei
    inc hl
    inc de
    ld a, [de]
    and a, $F0
    swap a
    inc a
    di
    call Func_000_121F
    ei
    ld a, [de]
    and a, $0F
    inc a
    di
    call Func_000_121F
    ei
    pop hl
    push de
    ld de, $0020
    add hl, de
    pop de
    inc de
    dec b
    jr nz, Jump_0E0_582E
    ld de, $D2AD
    ld hl, $98A8
    ld b, $0A

Jump_0E0_5861::
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    and a, c
    cp a, $FF
    jr nz, Jump_0E0_5898
    ld a, [de]
    and a, $F0
    swap a
    push hl
    inc a
    di
    call Func_000_121F
    ei
    ld a, [de]
    and a, $0F
    inc a
    di
    call Func_000_121F
    ei
    dec de
    ld a, [de]
    and a, $F0
    swap a
    inc a
    di
    call Func_000_121F
    ei
    ld a, [de]
    and a, $0F
    inc a
    di
    call Func_000_121F
    ei
    pop hl
    inc de
    jr Jump_0E0_58C4

Jump_0E0_5898::
    push hl
    push de
    push bc
    ld a, c
    ld [$C8C0], a
    ld a, [de]
    ld [$C8C1], a
    xor a, a
    ld [$C8C2], a
    call Func_000_173A
    pop bc
    pop de
    pop hl
    ldh a, [$FFC9]
    ld c, a
    ldh a, [$FFC8]
    or a, c
    jr z, Jump_0E0_58BB
    ld a, $99
    ldh [$FFC7], a
    ldh [$FFC6], a

Jump_0E0_58BB::
    push bc
    push hl
    ld c, $00
    call Func_0E0_59C0
    pop hl
    pop bc

Jump_0E0_58C4::
    inc de
    push de
    ld de, $0020
    add hl, de
    pop de
    dec b
    jr nz, Jump_0E0_5861
    ld a, $04
    ld [$C528], a
    ld a, [$D8A4]
    add a, a
    ld hl, $DA1C
    add a, l
    ld l, a
    jr nc, Jump_0E0_58DF
    inc h

Jump_0E0_58DF::
    ld a, [hl]
    ld [$C529], a
    or a, a
    jr nz, Jump_0E0_58F0
    ld a, $0E
    ld [$C528], a
    ld a, $01
    ld [$C529], a

Jump_0E0_58F0::
    ld hl, $8920
    ld de, $0901
    call Func_0E0_5A79
    ld a, [$D8A4]
    add a, a
    ld de, $DA1C
    add a, e
    ld e, a
    jr nc, Jump_0E0_5905
    inc d

Jump_0E0_5905::
    ld a, [de]
    ld hl, $9A02
    and a, $F0
    swap a
    inc a
    di
    call Func_000_121F
    ei
    ld a, [de]
    and a, $0F
    inc a
    di
    call Func_000_121F
    ei
    call Func_0E0_59A4
    ld hl, Data_0E0_5A05
    call Func_000_0B0D
    ld d, h
    ld e, l
    ld hl, $9A0F
    ld b, $04

Jump_0E0_592C::
    di
    ld a, [de]
    call Func_000_121F
    ei
    inc de
    dec b
    jr nz, Jump_0E0_592C
    ld b, $03
    ld c, $01
    ld hl, $DA3F

Jump_0E0_593D::
    push bc
    push hl
    ld b, $03

Jump_0E0_5941::
    ld a, [hl+]
    cp a, c
    jr nz, Jump_0E0_596D
    ld de, $FFFC
    add hl, de
    ld a, [hl]
    ld [$C8C0], a
    xor a, a
    ld [$C8C1], a
    ld [$C8C2], a
    push bc
    call Func_000_173A
    pop bc
    swap c
    ld b, $00
    ld hl, $988F
    add hl, bc
    add hl, bc
    push bc
    push hl
    ld c, $00
    call Func_0E0_59D4
    pop hl
    pop bc
    jr Jump_0E0_5970

Jump_0E0_596D::
    dec b
    jr nz, Jump_0E0_5941

Jump_0E0_5970::
    pop hl
    pop bc
    inc c
    dec b
    jr nz, Jump_0E0_593D
    ld hl, $9931
    ld de, $DA3F
    ld b, $03

Jump_0E0_597E::
    ld a, [de]
    and a, $0F
    inc a
    di
    call Func_000_1211
    ei
    push de
    ld de, $0020
    add hl, de
    pop de
    inc de
    dec b
    jr nz, Jump_0E0_597E
    ret

Func_0E0_5992::
    ld a, [$C58A]
    ld hl, $C57F
    cp a, $01
    ld a, [$D8A4]
    ret nz
    bit 1, [hl]
    ret z
    xor a, $04
    ret

Func_0E0_59A4::
    ld a, [$D8A4]
    add a, a
    ld de, $DA1D
    add a, e
    ld e, a
    jr nc, Jump_0E0_59B0
    inc d

Jump_0E0_59B0::
    ld a, [$C58A]
    ld hl, $C57F
    cp a, $01
    ld a, [de]
    ret nz
    bit 1, [hl]
    ret z
    xor a, $04
    ret

Func_0E0_59C0::
    ldh a, [$FFC7]
    and a, $F0
    swap a
    ld b, a
    or a, c
    ld c, a
    ld a, b
    jr nz, Jump_0E0_59CE
    ld a, $C2

Jump_0E0_59CE::
    inc a
    di
    call Func_000_121F
    ei

Func_0E0_59D4::
    ldh a, [$FFC7]
    and a, $0F
    ld b, a
    or a, c
    ld c, a
    ld a, b
    jr nz, Jump_0E0_59E0
    ld a, $C2

Jump_0E0_59E0::
    inc a
    di
    call Func_000_121F
    ei
    ldh a, [$FFC6]
    and a, $F0
    swap a
    ld b, a
    or a, c
    ld c, a
    ld a, b
    jr nz, Jump_0E0_59F4
    ld a, $C2

Jump_0E0_59F4::
    inc a
    di
    call Func_000_121F
    ei
    ldh a, [$FFC6]
    and a, $0F
    inc a
    di
    call Func_000_121F
    ei
    ret

Data_0E0_5A05:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_0E0_5A15
    dw Data_0E0_5A19
    dw Data_0E0_5A1D
    dw Data_0E0_5A21
    dw Data_0E0_5A25
    dw Data_0E0_5A29
    dw Data_0E0_5A2D
    dw Data_0E0_5A31

Data_0E0_5A15:: ; heuristic: target of a monotone pointer table; C0
    db $80, $81, $82, $01

Data_0E0_5A19:: ; heuristic: target of a monotone pointer table; C0
    db $80, $81, $82, $02

Data_0E0_5A1D:: ; heuristic: target of a monotone pointer table; C0
    db $80, $81, $82, $03

Data_0E0_5A21:: ; heuristic: target of a monotone pointer table; C0
    db $80, $81, $82, $04

Data_0E0_5A25:: ; heuristic: target of a monotone pointer table; C0
    db $83, $84, $01, $C3

Data_0E0_5A29:: ; heuristic: target of a monotone pointer table; C0
    db $83, $84, $02, $C3

Data_0E0_5A2D:: ; heuristic: target of a monotone pointer table; C0
    db $83, $84, $03, $C3

Data_0E0_5A31:: ; heuristic: target of a monotone pointer table; C0
    db $83, $84, $04, $C3

Func_0E0_5A35::
    ld a, [$C58A]
    or a, a
    jr z, Jump_0E0_5A6C
    ld a, [$C5BA]
    ld l, a
    ld a, [$C5BB]
    ld h, a
    push hl
    ld a, [$C5E7]
    ld l, a
    ld a, [$C5E8]
    ld h, a
    push hl
    ld hl, Func_030_5440
    ld b, $30
    rst $10
    ld hl, Func_039_4001
    ld b, $39
    rst $10
    pop hl
    ld a, l
    ld [$C5E7], a
    ld a, h
    ld [$C5E8], a
    pop hl
    ld a, l
    ld [$C5BA], a
    ld a, h
    ld [$C5BB], a
    ret

Jump_0E0_5A6C::
    ld hl, Func_030_5440
    ld b, $30
    rst $10
    ld hl, Func_039_4001
    ld b, $39
    rst $10
    ret

Func_0E0_5A79::
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld a, e
    ld [$C52F], a
    ld a, d
    ld [$C530], a
    ld hl, Func_008_402B
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
    db $7D, $EA, $2D, $C5, $7C, $EA, $2E, $C5, $7B, $EA, $2F, $C5, $7A, $EA, $30, $C5
    db $21, $0F, $40, $06, $09, $D7, $21, $00, $88, $7D, $EA, $2D, $C5, $7C, $EA, $2E
    db $C5, $21, $02, $12, $7D, $EA, $2F, $C5, $7C, $EA, $30, $C5, $C9

Func_0E0_5AD3::
    ld a, [$D09D]
    or a, a
    jp z, Jump_0E0_6FF7
    ld hl, Func_002_5074
    ld b, $02
    rst $10
    call Func_0E0_7480
    ld a, [$D09F]
    dec a
    rst $00
    dw Jump_0E0_5AF2
    dw Jump_0E0_5E4B
    dw Jump_0E0_6266
    dw Jump_0E0_6841
    dw Jump_0E0_6C0A

Jump_0E0_5AF2::
    ld a, [$D09E]
    rst $00
    dw Jump_0E0_5B16
    dw Jump_0E0_5C32
    dw Jump_0E0_5C58
    dw Jump_0E0_5C7B
    dw Jump_0E0_5C91
    dw Jump_0E0_5CB5
    dw Jump_0E0_5CD1
    dw Jump_0E0_5E07
    dw Jump_0E0_5E24
    dw Jump_0E0_5CEA
    dw Jump_0E0_5D14
    dw Jump_0E0_5D46
    dw Jump_0E0_5D7F
    dw Jump_0E0_5D9F
    dw Jump_0E0_5DCA
    dw Jump_0E0_5DDD

Jump_0E0_5B16::
    ld b, $7D
    ld de, Func_0E0_4001
    ld hl, $8000
    call Func_000_0CF5
    ld b, $7D
    ld de, Jump_0E0_40FA
    ld hl, $8100
    call Func_000_0CF5
    ld b, $7D
    ld de, $41E1
    ld hl, $8200
    call Func_000_0CF5
    ld b, $7E
    ld de, $4F22
    ld hl, $8300
    call Func_000_0CF5
    ld b, $93
    ld de, Func_0E0_4001
    ld hl, $9000
    call Func_000_0CF5
    ld b, $46
    ld de, Data_0E0_496B
    ld hl, $C198
    call Func_000_0C5A
    ld a, [$C525]
    or a, a
    jr z, Jump_0E0_5BB2
    ld a, $02
    ldh [$FF70], a
    ld b, $46
    ld de, Data_0E0_5301
    ld hl, $D000
    call Func_000_0C5A
    ld a, $00
    ldh [$FF70], a
    ld b, $48
    ld de, Data_07E_4001
    ld hl, $C49F
    ld c, $40
    call Func_000_0B2B
    ld b, $7E
    ld de, Data_07E_4BA5
    ld hl, $C4DF
    ld c, $08
    call Func_000_0B2B
    ld b, $7E
    ld de, Data_07E_4BAD
    ld hl, $C4E7
    ld c, $08
    call Func_000_0B2B
    ld b, $7E
    ld de, Data_07E_4B45
    ld hl, $C4EF
    ld c, $08
    call Func_000_0B2B
    ld b, $7E
    ld de, Data_07E_4C0D
    ld hl, $C4F7
    ld c, $08
    call Func_000_0B2B

Jump_0E0_5BB2::
    ld hl, $9800
    call Func_000_1E29
    ld a, $03
    ld [$CB7D], a
    ld a, $01
    ld [$C90D], a
    ld hl, $CB7F
    ld a, $01
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $60
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $10
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $0A
    ld [hl+], a
    ld a, $50
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $30
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $A0
    ld [hl+], a
    ld a, $50
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $20
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    call Func_0E0_75BF
    ld a, $FC
    call Func_000_0DF2
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_5C32::
    call Func_0E0_7420
    ld a, [$C56C]
    or a, a
    ret nz
    ld a, $04
    ld [$CB7D], a
    ld a, $03
    ld de, $6050
    call Func_0E0_7492
    ret nz
    ld a, $03
    ld c, $02
    call Func_0E0_74C5
    call Func_0E0_754F
    ret nz
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_5C58::
    call Func_0E0_7420
    ld a, [$D0A7]
    inc a
    ld [$D0A7], a
    and a, $01
    ret nz
    ld a, $03
    ld de, $6060
    call Func_0E0_7492
    ret nz
    call Func_0E0_754F
    ret nz
    xor a, a
    ld [$D0A7], a
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_5C7B::
    call Func_0E0_7420
    ld a, $03
    ld de, $6050
    call Func_0E0_7492
    ld a, $03
    call Func_0E0_7492
    ret nz
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_5C91::
    call Func_0E0_7420
    ld a, $00
    ld de, $6020
    call Func_0E0_7492
    ld a, $00
    call Func_0E0_7492
    ld a, $00
    call Func_0E0_7492
    ld a, $00
    call Func_0E0_7492
    ret nz
    call Func_0E0_754F
    ret nz
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_5CB5::
    call Func_0E0_7420
    ld a, $03
    ld de, Data_0E0_6040
    call Func_0E0_7492
    ret nz
    ld a, $03
    ld c, $03
    call Func_0E0_74C5
    call Func_0E0_754F
    ret nz
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_5CD1::
    call Func_0E0_7420
    ld a, $02
    ld de, $6030
    call Func_0E0_74D8
    ret nz
    call Func_0E0_754F
    ret nz
    xor a, a
    ld [$D0A7], a
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_5CEA::
    call Func_0E0_7420
    ld a, $02
    ld de, $5030
    call Func_0E0_7492
    ld a, $02
    call Func_0E0_7492
    ld a, $03
    ld de, $5040
    call Func_0E0_7492
    ld a, $03
    call Func_0E0_7492
    ret nz
    ld a, $01
    ld c, $01
    call Func_0E0_74C5
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_5D14::
    call Func_0E0_7420
    ld a, $01
    ld de, $1040
    call Func_0E0_7492
    ld a, $01
    call Func_0E0_7492
    ld a, $01
    call Func_0E0_7492
    ld a, $01
    call Func_0E0_7492
    ret nz
    call Func_0E0_754F
    ret nz
    ld a, $00
    ld c, $03
    call Func_0E0_74C5
    ld a, $03
    ld c, $02
    call Func_0E0_74C5
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_5D46::
    call Func_0E0_7420
    ld a, $02
    ld de, $5000
    call Func_0E0_7492
    ld a, $03
    ld de, $5000
    call Func_0E0_7492
    ret nz
    ld a, $00
    ld c, $02
    call Func_0E0_74C5
    ld a, $01
    ld c, $02
    call Func_0E0_74C5
    call Func_0E0_754F
    ret nz
    ld a, $00
    ld c, $00
    call Func_0E0_74C5
    ld a, $01
    ld c, $01
    call Func_0E0_74C5
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_5D7F::
    call Func_0E0_7420
    ld a, $01
    ld de, $4040
    call Func_0E0_7492
    ld a, $00
    ld de, $6030
    call Func_0E0_7492
    ret nz
    ld a, $00
    ld c, $03
    call Func_0E0_74C5
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_5D9F::
    call Func_0E0_7420
    ld a, $00
    ld de, $4030
    call Func_0E0_7492
    ld a, $01
    ld de, $4040
    call Func_0E0_7492
    ret nz
    ld a, $00
    ld c, $00
    call Func_0E0_74C5
    ld a, $01
    ld c, $02
    call Func_0E0_74C5
    call Func_0E0_754F
    ret nz
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_5DCA::
    call Func_0E0_7420
    call Func_0E0_754F
    ret nz
    ld a, $00
    ld c, $02
    call Func_0E0_74C5
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_5DDD::
    call Func_0E0_7420
    ld a, $00
    ld de, Data_0E0_4000
    call Func_0E0_7492
    ld a, $01
    ld de, Data_0E0_4000
    call Func_0E0_7492
    ret nz
    call Func_0E0_754F
    ret nz
    xor a, a
    ld [$C90D], a
    ld a, $04
    call Func_000_0DF2
    xor a, a
    ld [$D09D], a
    xor a, a
    ld [$D09E], a
    ret

Jump_0E0_5E07::
    call Func_0E0_7420
    ld a, $02
    ld de, $5030
    call Func_0E0_7492
    ld a, $03
    ld de, $5040
    call Func_0E0_7492
    ret nz
    call Func_0E0_754F
    ret nz
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_5E24::
    call Func_0E0_7420
    ld a, [$D0A7]
    inc a
    ld [$D0A7], a
    and a, $01
    ret nz
    ld a, $02
    ld de, $6030
    call Func_0E0_7492
    ld a, $03
    ld de, Data_0E0_6040
    call Func_0E0_7492
    ret nz
    call Func_0E0_754F
    ret nz
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_5E4B::
    ld a, [$D09E]
    rst $00
    dw Jump_0E0_5E83
    dw Jump_0E0_5F6F
    dw Jump_0E0_5F91
    dw Jump_0E0_5FED
    dw Jump_0E0_5FFE
    dw Jump_0E0_6048
    dw Jump_0E0_6165
    dw Jump_0E0_61C3
    dw Jump_0E0_61F2
    dw Jump_0E0_6194
    dw Jump_0E0_6165
    dw Jump_0E0_61C3
    dw Jump_0E0_61F2
    dw Jump_0E0_6194
    dw Jump_0E0_6165
    dw Jump_0E0_61C3
    dw Jump_0E0_61F2
    dw Jump_0E0_6194
    dw Jump_0E0_6165
    dw Jump_0E0_61C3
    dw Jump_0E0_6093
    dw Jump_0E0_60C0
    dw Jump_0E0_605D
    dw Jump_0E0_6221
    dw Jump_0E0_60DF
    dw Jump_0E0_6120

Jump_0E0_5E83::
    ld b, $7D
    ld de, Func_0E0_4001
    ld hl, $8000
    call Func_000_0CF5
    ld b, $7D
    ld de, Jump_0E0_40FA
    ld hl, $8100
    call Func_000_0CF5
    ld b, $7D
    ld de, $41E1
    ld hl, $8200
    call Func_000_0CF5
    ld b, $46
    ld de, $7025
    ld hl, $9000
    call Func_000_0CF5
    ld b, $46
    ld de, $777A
    ld hl, $C198
    call Func_000_0C5A
    ld a, [$C525]
    or a, a
    jr z, Jump_0E0_5F07
    ld a, $02
    ldh [$FF70], a
    ld b, $46
    ld de, $7A9D
    ld hl, $D000
    call Func_000_0C5A
    ld a, $00
    ldh [$FF70], a
    ld b, $48
    ld de, Data_07E_4081
    ld hl, $C49F
    ld c, $40
    call Func_000_0B2B
    ld b, $7E
    ld de, Data_07E_4BA5
    ld hl, $C4DF
    ld c, $08
    call Func_000_0B2B
    ld b, $7E
    ld de, Data_07E_4BAD
    ld hl, $C4E7
    ld c, $08
    call Func_000_0B2B
    ld b, $7E
    ld de, Data_07E_4B45
    ld hl, $C4EF
    ld c, $08
    call Func_000_0B2B

Jump_0E0_5F07::
    ld hl, $9800
    call Func_000_1E29
    ld a, $02
    ld [$CB7D], a
    ld a, $01
    ld [$C90D], a
    ld hl, $CB7F
    ld a, $01
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $A0
    ld [hl+], a
    ld a, $30
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $B0
    ld [hl+], a
    ld a, $30
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $10
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $70
    ld [hl+], a
    ld a, $60
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $20
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    call Func_0E0_75BF
    ld a, $FC
    call Func_000_0DF2
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_5F6F::
    call Func_0E0_7420
    ld a, [$C56C]
    or a, a
    ret nz
    ld a, $00
    ld de, $5030
    call Func_0E0_7492
    ld a, $01
    ld de, $6030
    call Func_0E0_7492
    ret nz
    call Func_0E0_754F
    ret nz
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_5F91::
    call Func_0E0_7420
    ld a, [$D0A3]
    srl a
    swap a
    and a, $07
    ld hl, Data_0E0_5FE3
    add a, l
    ld l, a
    jr nc, Jump_0E0_5FA5
    inc h

Jump_0E0_5FA5::
    ld c, [hl]
    ld a, $00
    call Func_0E0_74C5
    ld a, [$D0A3]
    srl a
    swap a
    and a, $07
    ld hl, Data_0E0_5FE8
    add a, l
    ld l, a
    jr nc, Jump_0E0_5FBC
    inc h

Jump_0E0_5FBC::
    ld c, [hl]
    ld a, $01
    call Func_0E0_74C5
    ld a, [$D0A3]
    inc a
    ld [$D0A3], a
    cp a, $9F
    ret c
    xor a, a
    ld [$D0A3], a
    ld a, $00
    ld c, $00
    call Func_0E0_74C5
    ld a, $01
    ld c, $00
    call Func_0E0_74C5
    ld hl, $D09E
    inc [hl]
    ret

Data_0E0_5FE3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $03, $02, $03, $00, $03

Data_0E0_5FE8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $00, $01, $02, $01

Jump_0E0_5FED::
    call Func_0E0_7420
    ld a, $03
    ld [$CB7D], a
    call Func_0E0_754F
    ret nz
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_5FFE::
    call Func_0E0_7420
    ld d, $60
    ld a, [$CB92]
    ld e, a
    ld a, $02
    call Func_0E0_7492
    jr nz, Jump_0E0_6022
    call Func_0E0_754F
    ret nz
    ld a, $02
    ld c, $02
    call Func_0E0_74C5
    xor a, a
    ld [$D0A3], a
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_6022::
    ld a, [$D0A3]
    ld c, a
    ld b, $00
    inc a
    ld [$D0A3], a
    ld hl, Data_0E0_6038
    add hl, bc
    ld a, [$CB92]
    add a, [hl]
    ld [$CB92], a
    ret

Data_0E0_6038:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FE, $FE, $FE, $FF, $FF, $FF, $00, $00

Data_0E0_6040:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $01, $01, $01, $02, $02, $02

Jump_0E0_6048::
    call Func_0E0_7420
    ld a, $02
    ld de, $6050
    call Func_0E0_7492
    ret nz
    call Func_0E0_755E
    ret nz
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_605D::
    call Func_0E0_7420
    ld a, $02
    ld c, $01
    call Func_0E0_74C5
    ld a, [$D0A3]
    cp a, $20
    jr nc, Jump_0E0_6086
    and a, $0F
    ld c, a
    ld b, $00
    ld hl, Data_0E0_6038
    add hl, bc
    ld a, [$CB92]
    add a, [hl]
    ld [$CB92], a
    ld a, [$D0A3]
    inc a
    ld [$D0A3], a
    ret

Jump_0E0_6086::
    call Func_0E0_754F
    ret nz
    xor a, a
    ld [$D0A3], a
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_6093::
    call Func_0E0_7420
    ld a, $02
    ld c, $02
    call Func_0E0_74C5
    ld a, $02
    ld de, $4030
    call Func_0E0_7492
    ret nz
    ld a, $00
    ld c, $03
    call Func_0E0_74C5
    ld a, $01
    ld c, $03
    call Func_0E0_74C5
    ld a, $02
    ld c, $01
    call Func_0E0_74C5
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_60C0::
    call Func_0E0_7420
    ld a, [$D0A3]
    inc a
    ld [$D0A3], a
    and a, $03
    ret nz
    ld a, $02
    ld de, $3030
    call Func_0E0_7492
    ret nz
    xor a, a
    ld [$D0A3], a
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_60DF::
    call Func_0E0_7420
    ld a, $02
    ld c, $03
    call Func_0E0_74C5
    ld a, [$CB91]
    cp a, $F0
    jr nz, Jump_0E0_6113
    ld a, $02
    ld [$CB7D], a
    ld a, $00
    ld c, $01
    call Func_0E0_74C5
    ld a, $01
    ld c, $03
    call Func_0E0_74C5
    call Func_0E0_754F
    ret nz
    ld a, $00
    ld c, $03
    call Func_0E0_74C5
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_6113::
    sub a, $02
    ld [$CB91], a
    ld a, [$CB96]
    inc a
    ld [$CB96], a
    ret

Jump_0E0_6120::
    call Func_0E0_7420
    ld a, [$CB81]
    cp a, $F0
    jr z, Jump_0E0_6136
    sub a, $01
    ld [$CB81], a
    ld a, [$CB86]
    inc a
    ld [$CB86], a

Jump_0E0_6136::
    ld a, [$CB89]
    cp a, $F0
    jr nz, Jump_0E0_6158
    ld a, $02
    ld [$CB7D], a
    call Func_0E0_754F
    ret nz
    xor a, a
    ld [$C90D], a
    ld a, $04
    call Func_000_0DF2
    xor a, a
    ld [$D09D], a
    xor a, a
    ld [$D09E], a
    ret

Jump_0E0_6158::
    sub a, $01
    ld [$CB89], a
    ld a, [$CB8E]
    inc a
    ld [$CB8E], a
    ret

Jump_0E0_6165::
    call Func_0E0_7420
    ld d, $50
    ld a, [$CB92]
    ld e, a
    ld a, $02
    call Func_0E0_7492
    jr nz, Jump_0E0_617E
    xor a, a
    ld [$D0A3], a
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_617E::
    ld a, [$D0A3]
    ld c, a
    ld b, $00
    inc a
    ld [$D0A3], a
    ld hl, Data_0E0_6038
    add hl, bc
    ld a, [$CB92]
    add a, [hl]
    ld [$CB92], a
    ret

Jump_0E0_6194::
    call Func_0E0_7420
    ld d, $60
    ld a, [$CB92]
    ld e, a
    ld a, $02
    call Func_0E0_7492
    jr nz, Jump_0E0_61AD
    xor a, a
    ld [$D0A3], a
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_61AD::
    ld a, [$D0A3]
    ld c, a
    ld b, $00
    inc a
    ld [$D0A3], a
    ld hl, Data_0E0_6038
    add hl, bc
    ld a, [$CB92]
    add a, [hl]
    ld [$CB92], a
    ret

Jump_0E0_61C3::
    call Func_0E0_7420
    ld d, $40
    ld a, [$CB92]
    ld e, a
    ld a, $02
    call Func_0E0_7492
    jr nz, Jump_0E0_61DC
    xor a, a
    ld [$D0A3], a
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_61DC::
    ld a, [$D0A3]
    ld c, a
    ld b, $00
    inc a
    ld [$D0A3], a
    ld hl, Data_0E0_6038
    add hl, bc
    ld a, [$CB92]
    add a, [hl]
    ld [$CB92], a
    ret

Jump_0E0_61F2::
    call Func_0E0_7420
    ld d, $50
    ld a, [$CB92]
    ld e, a
    ld a, $02
    call Func_0E0_7492
    jr nz, Jump_0E0_620B
    xor a, a
    ld [$D0A3], a
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_620B::
    ld a, [$D0A3]
    ld c, a
    ld b, $00
    inc a
    ld [$D0A3], a
    ld hl, Data_0E0_6038
    add hl, bc
    ld a, [$CB92]
    add a, [hl]
    ld [$CB92], a
    ret

Jump_0E0_6221::
    call Func_0E0_7420
    ld a, [$D0A3]
    cp a, $10
    jr nc, Jump_0E0_624A
    and a, $07
    ld c, a
    ld b, $00
    ld hl, Data_0E0_625E
    add hl, bc
    ld a, [$CB82]
    add a, [hl]
    ld [$CB82], a
    ld a, [$CB8A]
    add a, [hl]
    ld [$CB8A], a
    ld a, [$D0A3]
    inc a
    ld [$D0A3], a
    ret

Jump_0E0_624A::
    call Func_0E0_754F
    ret nz
    ld a, $02
    ld c, $03
    call Func_0E0_74C5
    xor a, a
    ld [$D0A3], a
    ld hl, $D09E
    inc [hl]
    ret

Data_0E0_625E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FD, $FE, $FF, $00, $00, $01, $02, $03

Jump_0E0_6266::
    ld a, [$D09E]
    rst $00
    dw Jump_0E0_62A0
    dw Jump_0E0_6417
    dw Jump_0E0_6439
    dw Jump_0E0_649A
    dw Jump_0E0_64B0
    dw Jump_0E0_6626
    dw Jump_0E0_664D
    dw Jump_0E0_666D
    dw Jump_0E0_668D
    dw Jump_0E0_66A5
    dw Jump_0E0_64DE
    dw Jump_0E0_64F4
    dw Jump_0E0_66DB
    dw Jump_0E0_6702
    dw Jump_0E0_6722
    dw Jump_0E0_6742
    dw Jump_0E0_675A
    dw Jump_0E0_6514
    dw Jump_0E0_67B1
    dw Jump_0E0_67E7
    dw Jump_0E0_6801
    dw Jump_0E0_680D
    dw Jump_0E0_6551
    dw Jump_0E0_6595
    dw Jump_0E0_65BD
    dw Jump_0E0_65F8
    dw Jump_0E0_677D

Jump_0E0_62A0::
    ld b, $7D
    ld de, Func_0E0_4001
    ld hl, $8000
    call Func_000_0CF5
    ld b, $7D
    ld de, Jump_0E0_40FA
    ld hl, $8100
    call Func_000_0CF5
    ld b, $7E
    ld de, $48D6
    ld hl, $8200
    call Func_000_0CF5
    ld b, $21
    ld de, Data_0E0_7548
    ld hl, $8300
    call Func_000_0CF5
    ld b, $7D
    ld de, $42BD
    ld hl, $8400
    call Func_000_0CF5
    ld b, $7D
    ld de, $41E1
    ld hl, $8500
    call Func_000_0CF5
    ld b, $48
    ld de, Data_0E0_4DDC
    ld hl, $9000
    call Func_000_0CF5
    ld b, $48
    ld de, Data_0E0_523C
    ld hl, $C198
    call Func_000_0C5A
    ld a, [$C525]
    or a, a
    jr z, Jump_0E0_636C
    ld a, $02
    ldh [$FF70], a
    ld b, $48
    ld de, Data_0E0_54BF
    ld hl, $D000
    call Func_000_0C5A
    ld a, $00
    ldh [$FF70], a
    ld b, $48
    ld de, Data_07E_5138
    ld hl, $C49F
    ld c, $40
    call Func_000_0B2B
    ld b, $7E
    ld de, Data_07E_4BA5
    ld hl, $C4DF
    ld c, $08
    call Func_000_0B2B
    ld b, $7E
    ld de, Data_07E_4BAD
    ld hl, $C4E7
    ld c, $08
    call Func_000_0B2B
    ld b, $7E
    ld de, Data_027_4B2D
    ld hl, $C4EF
    ld c, $08
    call Func_000_0B2B
    ld b, $27
    ld de, Data_07E_7850
    ld hl, $C4F7
    ld c, $08
    call Func_000_0B2B
    ld b, $7E
    ld de, Data_07E_4B4D
    ld hl, $C4FF
    ld c, $08
    call Func_000_0B2B
    ld b, $7E
    ld de, Data_07E_4B45
    ld hl, $C507
    ld c, $08
    call Func_000_0B2B

Jump_0E0_636C::
    ld hl, $9800
    call Func_000_1E29
    ld a, $02
    ld [$CB7D], a
    ld hl, $CB7F
    ld a, $01
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $A0
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $B0
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $10
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $5F
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $10
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $20
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $A5
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $10
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $30
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $50
    ld [hl+], a
    ld a, $10
    ld [hl+], a
    ld a, $04
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $50
    ld [hl+], a
    ld a, $10
    ld [hl+], a
    ld a, $05
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $50
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    call Func_0E0_75BF
    ld a, $FC
    call Func_000_0DF2
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_6417::
    call Func_0E0_7420
    ld a, [$C56C]
    or a, a
    ret nz
    ld a, $00
    ld de, $4070
    call Func_0E0_7492
    ld a, $01
    ld de, $4080
    call Func_0E0_7492
    ret nz
    call Func_0E0_754F
    ret nz
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_6439::
    call Func_0E0_7420
    ld a, [$D0A3]
    srl a
    swap a
    and a, $07
    ld hl, Data_0E0_6490
    add a, l
    ld l, a
    jr nc, Jump_0E0_644D
    inc h

Jump_0E0_644D::
    ld c, [hl]
    ld a, $00
    call Func_0E0_74C5
    ld a, [$D0A3]
    srl a
    swap a
    and a, $07
    ld hl, Data_0E0_6495
    add a, l
    ld l, a
    jr nc, Jump_0E0_6464
    inc h

Jump_0E0_6464::
    ld c, [hl]
    ld a, $01
    call Func_0E0_74C5
    ld a, [$D0A3]
    inc a
    ld [$D0A3], a
    cp a, $9F
    ret c
    xor a, a
    ld [$D0A3], a
    ld a, $00
    ld c, $00
    call Func_0E0_74C5
    ld a, $01
    ld c, $02
    call Func_0E0_74C5
    ld a, $03
    ld [$CB7D], a
    ld hl, $D09E
    inc [hl]
    ret

Data_0E0_6490:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $03, $02, $01, $02, $03

Data_0E0_6495:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $00, $03, $00, $01

Jump_0E0_649A::
    call Func_0E0_7420
    ld a, $02
    ld de, $4020
    call Func_0E0_7492
    ret nz
    ld a, $04
    ld [$CB7D], a
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_64B0::
    call Func_0E0_7420
    ld a, $02
    ld de, $4030
    call Func_0E0_7492
    ld a, $03
    ld de, $4020
    call Func_0E0_7492
    ret nz
    ld a, $00
    ld c, $02
    call Func_0E0_74C5
    ld a, $01
    ld c, $02
    call Func_0E0_74C5
    ld a, $02
    ld c, $03
    call Func_0E0_74C5
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_64DE::
    call Func_0E0_7420
    ld a, $04
    ld de, $5020
    call Func_0E0_7492
    ret nz
    ld a, $06
    ld [$CB7D], a
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_64F4::
    call Func_0E0_7420
    ld a, $04
    ld de, $5030
    call Func_0E0_7492
    ld a, $05
    ld de, $5020
    call Func_0E0_7492
    ret nz
    ld a, $04
    ld c, $01
    call Func_0E0_74C5
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_6514::
    call Func_0E0_7420
    ld a, [$D0A3]
    cp a, $10
    jr nc, Jump_0E0_653D
    and a, $0F
    ld c, a
    ld b, $00
    ld hl, Data_0E0_6038
    add hl, bc
    ld a, [$CB82]
    add a, [hl]
    ld [$CB82], a
    ld a, [$CB8A]
    add a, [hl]
    ld [$CB8A], a
    ld a, [$D0A3]
    inc a
    ld [$D0A3], a
    ret

Jump_0E0_653D::
    ld a, $05
    ld c, $00
    call Func_0E0_74C5
    call Func_0E0_754F
    ret nz
    xor a, a
    ld [$D0A3], a
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_6551::
    call Func_0E0_7420
    ld a, [$D0A3]
    cp a, $10
    jr nc, Jump_0E0_657A
    and a, $0F
    ld c, a
    ld b, $00
    ld hl, Data_0E0_6038
    add hl, bc
    ld a, [$CBA2]
    add a, [hl]
    ld [$CBA2], a
    ld a, [$CBAA]
    add a, [hl]
    ld [$CBAA], a
    ld a, [$D0A3]
    inc a
    ld [$D0A3], a
    ret

Jump_0E0_657A::
    call Func_0E0_755E
    ret nz
    ld a, $04
    ld c, $02
    call Func_0E0_74C5
    ld a, $05
    ld c, $02
    call Func_0E0_74C5
    xor a, a
    ld [$D0A3], a
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_6595::
    call Func_0E0_7420
    ld a, $04
    ld de, $5020
    call Func_0E0_7492
    ld a, $04
    call Func_0E0_7492
    ld a, $05
    ld de, $5010
    call Func_0E0_7492
    ld a, $05
    call Func_0E0_7492
    ret nz
    ld a, $05
    ld [$CB7D], a
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_65BD::
    call Func_0E0_7420
    ld a, $04
    ld de, $5010
    call Func_0E0_7492
    ld a, $04
    call Func_0E0_7492
    ret nz
    ld a, $04
    ld [$CB7D], a
    ld a, $00
    ld c, $00
    call Func_0E0_74C5
    ld a, $02
    ld c, $02
    call Func_0E0_74C5
    ld a, $03
    ld c, $02
    call Func_0E0_74C5
    call Func_0E0_754F
    ret nz
    ld a, $00
    ld c, $01
    call Func_0E0_74C5
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_65F8::
    call Func_0E0_7420
    ld a, $00
    ld de, $A070
    call Func_0E0_7492
    ld a, $01
    ld de, $4070
    call Func_0E0_7492
    ret nz
    ld a, $01
    ld c, $01
    call Func_0E0_74C5
    ld a, $02
    ld c, $00
    call Func_0E0_74C5
    ld a, $03
    ld c, $00
    call Func_0E0_74C5
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_6626::
    call Func_0E0_7420
    ld a, $02
    ld de, $3030
    call Func_0E0_7492
    ld a, $03
    ld de, $4030
    call Func_0E0_7492
    ret nz
    ld a, $02
    ld c, $00
    call Func_0E0_74C5
    ld a, $03
    ld c, $03
    call Func_0E0_74C5
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_664D::
    call Func_0E0_7420
    ld a, $02
    ld de, $3040
    call Func_0E0_7492
    ld a, $03
    ld de, $3030
    call Func_0E0_7492
    ret nz
    ld a, $03
    ld c, $00
    call Func_0E0_74C5
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_666D::
    call Func_0E0_7420
    ld a, $02
    ld de, $3050
    call Func_0E0_7492
    ld a, $03
    ld de, $3040
    call Func_0E0_7492
    ret nz
    ld a, $02
    ld c, $03
    call Func_0E0_74C5
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_668D::
    call Func_0E0_7420
    ld a, $02
    ld de, $2050
    call Func_0E0_7492
    ret nz
    ld a, $02
    ld c, $02
    call Func_0E0_74C5
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_66A5::
    call Func_0E0_7420
    ld a, $02
    ld de, $2040
    call Func_0E0_7492
    ret nz
    ld a, $00
    ld c, $02
    call Func_0E0_74C5
    ld a, $01
    ld c, $02
    call Func_0E0_74C5
    ld a, $02
    ld c, $01
    call Func_0E0_74C5
    ld a, $03
    ld c, $01
    call Func_0E0_74C5
    call Func_0E0_754F
    ret nz
    ld a, $05
    ld [$CB7D], a
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_66DB::
    call Func_0E0_7420
    ld a, $04
    ld de, $6030
    call Func_0E0_7492
    ld a, $05
    ld de, $5030
    call Func_0E0_7492
    ret nz
    ld a, $04
    ld c, $00
    call Func_0E0_74C5
    ld a, $05
    ld c, $01
    call Func_0E0_74C5
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_6702::
    call Func_0E0_7420
    ld a, $04
    ld de, Data_0E0_6040
    call Func_0E0_7492
    ld a, $05
    ld de, $6030
    call Func_0E0_7492
    ret nz
    ld a, $05
    ld c, $00
    call Func_0E0_74C5
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_6722::
    call Func_0E0_7420
    ld a, $04
    ld de, $6050
    call Func_0E0_7492
    ld a, $05
    ld de, Data_0E0_6040
    call Func_0E0_7492
    ret nz
    ld a, $04
    ld c, $01
    call Func_0E0_74C5
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_6742::
    call Func_0E0_7420
    ld a, $04
    ld de, $7050
    call Func_0E0_7492
    ret nz
    ld a, $04
    ld c, $02
    call Func_0E0_74C5
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_675A::
    call Func_0E0_7420
    ld a, $04
    ld de, $7040
    call Func_0E0_7492
    ret nz
    ld a, $04
    ld c, $03
    call Func_0E0_74C5
    ld a, $05
    ld c, $03
    call Func_0E0_74C5
    call Func_0E0_754F
    ret nz
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_677D::
    call Func_0E0_7420
    ld a, $01
    ld de, $A070
    call Func_0E0_7492
    ld a, $00
    ld de, $A070
    call Func_0E0_7492
    ret nz
    ld a, $02
    ld c, $01
    call Func_0E0_74C5
    ld a, $03
    ld c, $01
    call Func_0E0_74C5
    call Func_0E0_754F
    ret nz
    ld a, $04
    call Func_000_0DF2
    xor a, a
    ld [$D09D], a
    xor a, a
    ld [$D09E], a
    ret

Jump_0E0_67B1::
    call Func_0E0_7420
    ld a, [$D0A3]
    cp a, $10
    jr nc, Jump_0E0_67D3
    and a, $0F
    ld c, a
    ld b, $00
    ld hl, Data_0E0_6038
    add hl, bc
    ld a, [$CBAA]
    add a, [hl]
    ld [$CBAA], a
    ld a, [$D0A3]
    inc a
    ld [$D0A3], a
    ret

Jump_0E0_67D3::
    call Func_0E0_757C
    ret nz
    ld a, $05
    ld c, $01
    call Func_0E0_74C5
    xor a, a
    ld [$D0A3], a
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_67E7::
    call Func_0E0_7420
    call Func_0E0_757C
    ret nz
    ld a, $04
    ld c, $00
    call Func_0E0_74C5
    ld a, $05
    ld c, $00
    call Func_0E0_74C5
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_6801::
    call Func_0E0_7420
    call Func_0E0_755E
    ret nz
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_680D::
    call Func_0E0_7420
    ld a, [$D0A3]
    inc a
    ld [$D0A3], a
    and a, $07
    ret nz
    ld a, $04
    ld de, $7050
    call Func_0E0_7492
    ld a, $05
    ld de, $6050
    call Func_0E0_7492
    ret nz
    ld a, [$D0A4]
    inc a
    ld [$D0A4], a
    cp a, $03
    ret c
    xor a, a
    ld [$D0A3], a
    ld [$D0A4], a
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_6841::
    ld a, [$D09E]
    rst $00
    dw Jump_0E0_685B
    dw Jump_0E0_6A10
    dw Jump_0E0_6A32
    dw Jump_0E0_6A89
    dw Jump_0E0_6AA1
    dw Jump_0E0_6ABE
    dw Jump_0E0_6B0A
    dw Jump_0E0_6B56
    dw Jump_0E0_6B99
    dw Jump_0E0_6BC4
    dw Jump_0E0_6BE4

Jump_0E0_685B::
    ld b, $7D
    ld de, Func_0E0_4001
    ld hl, $8000
    call Func_000_0CF5
    ld b, $7D
    ld de, Jump_0E0_40FA
    ld hl, $8100
    call Func_000_0CF5
    ld b, $7D
    ld de, $42BD
    ld hl, $8200
    call Func_000_0CF5
    ld b, $7D
    ld de, $41E1
    ld hl, $8300
    call Func_000_0CF5
    ld b, $7D
    ld de, Data_0E0_4EB6
    ld hl, $8400
    call Func_000_0CF5
    ld b, $7D
    ld de, $4B4A
    ld hl, $8500
    call Func_000_0CF5
    ld b, $7E
    ld de, Data_0E0_52BC
    ld hl, $8600
    call Func_000_0CF5
    ld b, $48
    ld de, Data_0E0_55DA
    ld hl, $9000
    call Func_000_0CF5
    ld b, $48
    ld de, $5C7D
    ld hl, $C198
    call Func_000_0C5A
    ld a, [$C525]
    or a, a
    jp z, Jump_0E0_694D
    ld a, $02
    ldh [$FF70], a
    ld b, $48
    ld de, Jump_0E0_61F2
    ld hl, $D000
    call Func_000_0C5A
    ld a, $00
    ldh [$FF70], a
    ld b, $94
    ld de, Data_048_4001
    ld hl, $C49F
    ld c, $40
    call Func_000_0B2B
    ld b, $48
    ld de, Data_07E_5138
    ld hl, $C49F
    ld c, $40
    call Func_000_0B2B
    ld b, $7E
    ld de, Data_07E_4BA5
    ld hl, $C4DF
    ld c, $08
    call Func_000_0B2B
    ld b, $7E
    ld de, Data_07E_4BAD
    ld hl, $C4E7
    ld c, $08
    call Func_000_0B2B
    ld b, $7E
    ld de, Data_07E_4B4D
    ld hl, $C4EF
    ld c, $08
    call Func_000_0B2B
    ld b, $7E
    ld de, Data_07E_4B45
    ld hl, $C4F7
    ld c, $08
    call Func_000_0B2B
    ld b, $7E
    ld de, Data_07E_4B2D
    ld hl, $C4FF
    ld c, $08
    call Func_000_0B2B
    ld b, $7E
    ld de, Data_07E_4B1D
    ld hl, $C507
    ld c, $08
    call Func_000_0B2B
    ld b, $7E
    ld de, Data_07E_4C65
    ld hl, $C50F
    ld c, $08
    call Func_000_0B2B

Jump_0E0_694D::
    ld hl, $9800
    call Func_000_1E29
    ld a, $06
    ld [$CB7D], a
    ld hl, $CB7F
    ld a, $01
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $A0
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $B0
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $10
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $60
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $20
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $30
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $12
    ld [hl+], a
    ld a, $60
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $04
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $0E
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $30
    ld [hl+], a
    ld a, $05
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $50
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $15
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $06
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $60
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    call Func_0E0_75BF
    ld a, $FC
    call Func_000_0DF2
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_6A10::
    call Func_0E0_7420
    ld a, [$C56C]
    or a, a
    ret nz
    ld a, $00
    ld de, $4050
    call Func_0E0_7492
    ld a, $01
    ld de, $4060
    call Func_0E0_7492
    ret nz
    call Func_0E0_754F
    ret nz
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_6A32::
    call Func_0E0_7420
    ld a, [$D0A3]
    srl a
    swap a
    and a, $07
    ld hl, Data_0E0_6490
    add a, l
    ld l, a
    jr nc, Jump_0E0_6A46
    inc h

Jump_0E0_6A46::
    ld c, [hl]
    ld a, $00
    call Func_0E0_74C5
    ld a, [$D0A3]
    srl a
    swap a
    and a, $07
    ld hl, Data_0E0_6495
    add a, l
    ld l, a
    jr nc, Jump_0E0_6A5D
    inc h

Jump_0E0_6A5D::
    ld c, [hl]
    ld a, $01
    call Func_0E0_74C5
    ld a, [$D0A3]
    inc a
    ld [$D0A3], a
    cp a, $9F
    ret c
    xor a, a
    ld [$D0A3], a
    ld a, $00
    ld c, $02
    call Func_0E0_74C5
    ld a, $01
    ld c, $00
    call Func_0E0_74C5
    ld a, $07
    ld [$CB7D], a
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_6A89::
    call Func_0E0_7420
    call Func_0E0_756D
    ret nz
    ld a, $01
    ld c, $02
    call Func_0E0_74C5
    ld a, $06
    ld [$CB7D], a
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_6AA1::
    call Func_0E0_7420
    ld a, $00
    ld de, $4040
    call Func_0E0_7492
    ld a, $01
    ld de, $4050
    call Func_0E0_7492
    ret nz
    call Func_0E0_755E
    ret nz
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_6ABE::
    call Func_0E0_7420
    ld a, [$D0A3]
    cp a, $10
    jr nc, Jump_0E0_6AED
    and a, $0F
    ld c, a
    ld b, $00
    ld hl, Data_0E0_6038
    add hl, bc
    ld a, [$CBAA]
    add a, [hl]
    ld [$CBAA], a
    ld a, [$D0A3]
    srl a
    srl a
    ld hl, Data_0E0_6B06
    ld [$CBAC], a
    ld a, [$D0A3]
    inc a
    ld [$D0A3], a
    ret

Jump_0E0_6AED::
    ld a, $05
    ld [$CB7D], a
    ld a, [$CBAA]
    add a, [hl]
    ld [$CB9A], a
    call Func_0E0_754F
    ret nz
    xor a, a
    ld [$D0A3], a
    ld hl, $D09E
    inc [hl]
    ret

Data_0E0_6B06:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $03, $02, $01, $00

Jump_0E0_6B0A::
    call Func_0E0_7420
    ld a, [$D0A3]
    cp a, $10
    jr nc, Jump_0E0_6B39
    and a, $0F
    ld c, a
    ld b, $00
    ld hl, Data_0E0_6038
    add hl, bc
    ld a, [$CBA2]
    add a, [hl]
    ld [$CBA2], a
    ld a, [$D0A3]
    srl a
    srl a
    ld hl, Data_0E0_6B52
    ld [$CBA4], a
    ld a, [$D0A3]
    inc a
    ld [$D0A3], a
    ret

Jump_0E0_6B39::
    ld a, $04
    ld [$CB7D], a
    ld a, [$CBA2]
    add a, [hl]
    ld [$CB92], a
    call Func_0E0_755E
    ret nz
    xor a, a
    ld [$D0A3], a
    ld hl, $D09E
    inc [hl]
    ret

Data_0E0_6B52:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $02, $01, $00, $03

Jump_0E0_6B56::
    call Func_0E0_7420
    ld a, $02
    ld c, $03
    call Func_0E0_74C5
    ld a, $03
    ld c, $01
    call Func_0E0_74C5
    ld a, $02
    ld de, $5040
    call Func_0E0_7492
    ld a, $03
    ld de, $5030
    call Func_0E0_7492
    ret nz
    ld a, $00
    ld c, $01
    call Func_0E0_74C5
    ld a, $01
    ld c, $01
    call Func_0E0_74C5
    ld a, $02
    ld c, $00
    call Func_0E0_74C5
    ld a, $03
    ld c, $00
    call Func_0E0_74C5
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_6B99::
    call Func_0E0_7420
    ld a, $02
    ld de, $50A0
    call Func_0E0_7492
    ld a, $03
    ld de, $50A0
    call Func_0E0_7492
    ret nz
    ld a, $00
    ld c, $00
    call Func_0E0_74C5
    ld a, $01
    ld c, $02
    call Func_0E0_74C5
    call Func_0E0_755E
    ret nz
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_6BC4::
    call Func_0E0_7420
    ld a, $00
    ld de, $40A0
    call Func_0E0_7492
    ld a, $01
    ld de, $4040
    call Func_0E0_7492
    ret nz
    ld a, $01
    ld c, $00
    call Func_0E0_74C5
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_6BE4::
    call Func_0E0_7420
    ld a, $00
    ld de, $40A0
    call Func_0E0_7492
    ld a, $01
    ld de, $40B0
    call Func_0E0_7492
    ret nz
    call Func_0E0_754F
    ret nz
    ld a, $04
    call Func_000_0DF2
    xor a, a
    ld [$D09D], a
    xor a, a
    ld [$D09E], a
    ret

Jump_0E0_6C0A::
    ld a, [$D09E]
    rst $00
    dw Jump_0E0_6C2C
    dw Jump_0E0_6D43
    dw Jump_0E0_6D73
    dw Jump_0E0_6DA7
    dw Jump_0E0_6F8D
    dw Jump_0E0_6F41
    dw Jump_0E0_6FA7
    dw Jump_0E0_6FB3
    dw Jump_0E0_6FDE
    dw Jump_0E0_6DEE
    dw Jump_0E0_6EA3
    dw Jump_0E0_6EEF
    dw Jump_0E0_6F5B
    dw Jump_0E0_6EFB
    dw Jump_0E0_6F1B

Jump_0E0_6C2C::
    ld b, $7D
    ld de, Func_0E0_4001
    ld hl, $8000
    call Func_000_0CF5
    ld b, $7D
    ld de, Jump_0E0_40FA
    ld hl, $8100
    call Func_000_0CF5
    ld b, $7D
    ld de, $42BD
    ld hl, $8200
    call Func_000_0CF5
    ld b, $7D
    ld de, $41E1
    ld hl, $8300
    call Func_000_0CF5
    ld b, $49
    ld de, $4C1B
    ld hl, $9000
    call Func_000_0CF5
    ld b, $49
    ld de, Data_0E0_531F
    ld hl, $C198
    call Func_000_0C5A
    ld a, [$C525]
    or a, a
    jr z, Jump_0E0_6CC8
    ld a, $02
    ldh [$FF70], a
    ld b, $49
    ld de, Func_0E0_572D
    ld hl, $D000
    call Func_000_0C5A
    ld a, $00
    ldh [$FF70], a
    ld b, $49
    ld de, Data_07E_52BB
    ld hl, $C49F
    ld c, $40
    call Func_000_0B2B
    ld b, $7E
    ld de, Data_07E_4BA5
    ld hl, $C4DF
    ld c, $08
    call Func_000_0B2B
    ld b, $7E
    ld de, Data_07E_4BAD
    ld hl, $C4E7
    ld c, $08
    call Func_000_0B2B
    ld b, $7E
    ld de, Data_07E_4B4D
    ld hl, $C4EF
    ld c, $08
    call Func_000_0B2B
    ld b, $7E
    ld de, Data_07E_4B45
    ld hl, $C4F7
    ld c, $08
    call Func_000_0B2B

Jump_0E0_6CC8::
    ld hl, $9800
    call Func_000_1E29
    ld a, $04
    ld [$CB7D], a
    ld hl, $CB7F
    ld a, $01
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $A0
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $B0
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $10
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $20
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $50
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $30
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    call Func_0E0_75BF
    ld a, $FC
    call Func_000_0DF2
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_6D43::
    call Func_0E0_7420
    ld a, [$C56C]
    or a, a
    ret nz
    ld a, $00
    ld de, $8040
    call Func_0E0_7492
    ld a, $01
    ld de, $9040
    call Func_0E0_7492
    ret nz
    call Func_0E0_755E
    ret nz
    ld a, $02
    ld c, $01
    call Func_0E0_74C5
    ld a, $03
    ld c, $01
    call Func_0E0_74C5
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_6D73::
    call Func_0E0_7420
    ld a, [$D0A3]
    inc a
    ld [$D0A3], a
    and a, $03
    ret nz
    ld a, $00
    ld de, $7040
    call Func_0E0_7492
    ld a, $01
    ld de, $8040
    call Func_0E0_7492
    ret nz
    ld a, [$D0A4]
    inc a
    ld [$D0A4], a
    cp a, $07
    ret c
    xor a, a
    ld [$D0A3], a
    ld [$D0A4], a
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_6DA7::
    call Func_0E0_7420
    ld a, [$D0A3]
    inc a
    ld [$D0A3], a
    and a, $03
    ret nz
    ld a, $02
    ld de, $3040
    call Func_0E0_7492
    ld a, $03
    ld de, $4040
    call Func_0E0_7492
    ret nz
    ld a, [$D0A4]
    inc a
    ld [$D0A4], a
    cp a, $07
    ret c
    cp a, $0F
    jr c, Jump_0E0_6DDF
    xor a, a
    ld [$D0A3], a
    ld [$D0A4], a
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_6DDF::
    ld a, $02
    ld c, $03
    call Func_0E0_74C5
    ld a, $03
    ld c, $03
    call Func_0E0_74C5
    ret

Jump_0E0_6DEE::
    call Func_0E0_7420
    ld a, [$D0A3]
    cp a, $20
    jr nc, Jump_0E0_6E12
    and a, $1F
    ld c, a
    ld b, $00
    ld hl, Data_0E0_6E83
    add hl, bc
    ld a, [$CB92]
    add a, [hl]
    ld [$CB92], a
    ld e, a
    ld d, $10
    ld a, $02
    call Func_0E0_7492
    jr Jump_0E0_6E29

Jump_0E0_6E12::
    ld a, $02
    ld de, $10A0
    call Func_0E0_7492
    ld a, $02
    call Func_0E0_7492
    ld a, $02
    call Func_0E0_7492
    ld a, $02
    call Func_0E0_7492

Jump_0E0_6E29::
    ld a, [$D0A3]
    sub a, $10
    jr c, Jump_0E0_6E4E
    cp a, $20
    jr nc, Jump_0E0_6E5E
    and a, $1F
    ld c, a
    ld b, $00
    ld hl, Data_0E0_6E83
    add hl, bc
    ld a, [$CB9A]
    add a, [hl]
    ld [$CB9A], a
    ld e, a
    ld d, $10
    ld a, $03
    call Func_0E0_7492
    jr Jump_0E0_6E56

Jump_0E0_6E4E::
    ld a, $03
    ld de, $3040
    call Func_0E0_7492

Jump_0E0_6E56::
    ld a, [$D0A3]
    inc a
    ld [$D0A3], a
    ret

Jump_0E0_6E5E::
    ld a, $03
    ld de, $10A0
    call Func_0E0_7492
    ld a, $03
    call Func_0E0_7492
    ld a, $03
    call Func_0E0_7492
    ld a, $03
    call Func_0E0_7492
    ret nz
    call Func_0E0_755E
    ret nz
    xor a, a
    ld [$D0A3], a
    ld hl, $D09E
    inc [hl]
    ret

Data_0E0_6E83:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FD, $FD, $FD, $FD, $FE, $FE, $FE, $FE, $FF, $FF, $FF, $FF, $00, $00, $00, $00
    db $00, $00, $00, $00, $01, $01, $01, $01, $02, $02, $02, $02, $03, $03, $03, $03

Jump_0E0_6EA3::
    call Func_0E0_7420
    ld a, [$D0A3]
    cp a, $10
    jr nc, Jump_0E0_6ECC
    and a, $0F
    ld c, a
    ld b, $00
    ld hl, Data_0E0_6038
    add hl, bc
    ld a, [$CB82]
    add a, [hl]
    ld [$CB82], a
    ld a, [$CB8A]
    add a, [hl]
    ld [$CB8A], a
    ld a, [$D0A3]
    inc a
    ld [$D0A3], a
    ret

Jump_0E0_6ECC::
    cp a, $20
    push af
    inc a
    ld [$D0A3], a
    pop af
    ret c
    ld a, $00
    ld de, $3040
    call Func_0E0_7492
    ld a, $01
    ld de, $4040
    call Func_0E0_7492
    ret nz
    xor a, a
    ld [$D0A3], a
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_6EEF::
    call Func_0E0_7420
    call Func_0E0_757C
    ret nz
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_6EFB::
    call Func_0E0_7420
    ld a, $00
    ld de, $A040
    call Func_0E0_7492
    ld a, $01
    ld de, $4040
    call Func_0E0_7492
    ret nz
    ld a, $01
    ld c, $01
    call Func_0E0_74C5
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_6F1B::
    call Func_0E0_7420
    ld a, $00
    ld de, $A040
    call Func_0E0_7492
    ld a, $01
    ld de, $A040
    call Func_0E0_7492
    ret nz
    call Func_0E0_754F
    ret nz
    ld a, $04
    call Func_000_0DF2
    xor a, a
    ld [$D09D], a
    xor a, a
    ld [$D09E], a
    ret

Jump_0E0_6F41::
    call Func_0E0_7420
    call Func_0E0_757C
    ret nz
    ld a, $02
    ld c, $03
    call Func_0E0_74C5
    ld a, $03
    ld c, $03
    call Func_0E0_74C5
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_6F5B::
    call Func_0E0_7420
    ld a, [$D0A3]
    inc a
    ld [$D0A3], a
    and a, $03
    ret nz
    ld a, $00
    ld de, $4040
    call Func_0E0_7492
    ld a, $01
    ld de, $5040
    call Func_0E0_7492
    ret nz
    call Func_0E0_754F
    ret nz
    xor a, a
    ld [$D0A3], a
    ld a, $00
    ld c, $01
    call Func_0E0_74C5
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_6F8D::
    call Func_0E0_7420
    call Func_0E0_757C
    ret nz
    ld a, $02
    ld c, $01
    call Func_0E0_74C5
    ld a, $03
    ld c, $01
    call Func_0E0_74C5
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_6FA7::
    call Func_0E0_7420
    call Func_0E0_757C
    ret nz
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_6FB3::
    call Func_0E0_7420
    ld a, [$D0A3]
    inc a
    ld [$D0A3], a
    and a, $03
    ret nz
    ld a, $02
    ld de, $4040
    call Func_0E0_7492
    ld a, $03
    ld de, $5040
    call Func_0E0_7492
    ret nz
    call Func_0E0_754F
    ret nz
    xor a, a
    ld [$D0A3], a
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_6FDE::
    call Func_0E0_7420
    ld a, $02
    ld de, $3040
    call Func_0E0_7492
    ld a, $03
    ld de, $4040
    call Func_0E0_7492
    ret nz
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_6FF7::
    ld a, [$D09F]
    or a, a
    jr z, Jump_0E0_7007
    ld a, [$D09E]
    rst $00
    dw Jump_0E0_7011
    dw Jump_0E0_72C0
    dw Jump_0E0_733E

Jump_0E0_7007::
    ld a, [$D09E]
    rst $00
    dw Jump_0E0_735E
    dw Jump_0E0_73DC
    dw Jump_0E0_73FC

Jump_0E0_7011::
    ld a, [$D0A1]
    or a, a
    jr nz, Jump_0E0_7036
    ld hl, $97F0
    ld de, $0101
    call Func_000_2E98
    ld a, [$D09F]
    dec a
    ld hl, Data_0E0_7649
    call Func_000_0B0D
    ld a, [hl+]
    ld [$D0A1], a
    ld a, l
    ld [$D0A5], a
    ld a, h
    ld [$D0A6], a

Jump_0E0_7036::
    ld a, [$D0A5]
    ld l, a
    ld a, [$D0A6]
    ld h, a
    ld a, [hl+]
    cp a, $FE
    jp nz, Jump_0E0_719F
    ld a, l
    ld [$D0AD], a
    ld a, h
    ld [$D0AE], a
    ld bc, $8800
    ld a, c
    ld [$D0A9], a
    ld a, b
    ld [$D0AA], a
    xor a, a
    ld [$D0A7], a

Jump_0E0_705B::
    ld a, [hl+]
    ld c, a
    cp a, $FF
    jp z, Jump_0E0_70EB
    ld a, [$D0A7]
    add a, c
    ld [$D0A7], a
    ld a, c
    or a, a
    jr nz, Jump_0E0_7070
    inc hl
    jr Jump_0E0_70A5

Jump_0E0_7070::
    push hl
    ld a, [$D0A9]
    ld l, a
    ld a, [$D0AA]
    ld h, a
    ld de, $1202
    call Func_000_2E98
    ld a, [$D0A9]
    ld l, a
    ld a, [$D0AA]
    ld h, a
    ld de, $0240
    add hl, de
    ld a, l
    ld [$D0A9], a
    ld a, h
    ld [$D0AA], a
    pop hl
    xor a, a
    ld [$C528], a
    ld a, [hl+]
    ld [$C529], a
    cp a, $FF
    jr z, Jump_0E0_70A5
    push hl
    call Func_0E0_76F5
    pop hl

Jump_0E0_70A5::
    ld a, [hl+]
    ld c, a
    ld a, [$D0A7]
    add a, c
    ld a, a
    ld [$D0A7], a
    ld a, c
    or a, a
    jr nz, Jump_0E0_70B6
    inc hl
    jr Jump_0E0_705B

Jump_0E0_70B6::
    push hl
    ld a, [$D0A9]
    ld l, a
    ld a, [$D0AA]
    ld h, a
    ld de, $1201
    call Func_000_2E98
    ld a, [$D0A9]
    ld l, a
    ld a, [$D0AA]
    ld h, a
    ld de, $0120
    add hl, de
    ld a, l
    ld [$D0A9], a
    ld a, h
    ld [$D0AA], a
    pop hl
    ld a, $01
    ld [$C528], a
    ld a, [hl+]
    ld [$C529], a
    push hl
    call Func_0E0_76F5
    pop hl
    jp Jump_0E0_705B

Jump_0E0_70EB::
    ld a, l
    ld [$D0A5], a
    ld a, h
    ld [$D0A6], a
    ld a, [$C525]
    or a, a
    jr z, Jump_0E0_710C
    ld a, $01
    ldh [$FF4F], a
    ld a, $00
    ld hl, $9800
    ld bc, $1412
    call Func_0E0_758B
    ld a, $00
    ldh [$FF4F], a

Jump_0E0_710C::
    ld a, $7F
    ld hl, $9800
    ld bc, $1412
    call Func_0E0_758B
    ld bc, $9841
    ld a, c
    ld [$D0AB], a
    ld a, b
    ld [$D0AC], a
    ld bc, $0080
    ld a, c
    ld [$D0A9], a
    ld a, b
    ld [$D0AA], a

Jump_0E0_712D::
    ld a, [$D0AD]
    ld l, a
    ld a, [$D0AE]
    ld h, a
    ld a, [hl]
    cp a, $FF
    jp z, Jump_0E0_7259
    ld a, [$D0AB]
    ld l, a
    ld a, [$D0AC]
    ld h, a
    ld a, [$D0A9]
    ld b, a
    add a, $24
    ld [$D0A9], a
    ld a, b
    ld b, $12
    ld c, $02
    ld de, $0020
    call Func_0E0_740E
    ld a, l
    and a, $E0
    add a, $01
    ld l, a
    push hl
    ld a, [$D0AD]
    ld l, a
    ld a, [$D0AE]
    ld h, a
    ld a, [hl+]
    cp a, $01
    ld a, [hl+]
    ld a, [hl+]
    ld a, [hl+]
    ld a, l
    ld [$D0AD], a
    ld a, h
    ld [$D0AE], a
    pop hl
    jr z, Jump_0E0_717B
    ld de, $0020
    add hl, de

Jump_0E0_717B::
    ld a, [$D0A9]
    ld b, a
    add a, $12
    ld [$D0A9], a
    ld a, b
    ld de, $0040
    ld b, $12
    ld c, $01
    call Func_0E0_740E
    ld a, l
    and a, $E0
    add a, $01
    ld l, a
    ld a, l
    ld [$D0AB], a
    ld a, h
    ld [$D0AC], a
    jr Jump_0E0_712D

Jump_0E0_719F::
    ld [$D0A7], a
    or a, a
    jr nz, Jump_0E0_71A8
    inc hl
    jr Jump_0E0_71C4

Jump_0E0_71A8::
    push hl
    ld hl, $8800
    ld de, $1202
    call Func_000_2E98
    pop hl
    xor a, a
    ld [$C528], a
    ld a, [hl+]
    ld [$C529], a
    cp a, $FF
    jr z, Jump_0E0_71C4
    push hl
    call Func_0E0_76F5
    pop hl

Jump_0E0_71C4::
    ld a, [hl+]
    ld [$D0A8], a
    or a, a
    jr nz, Jump_0E0_71CE
    inc hl
    jr Jump_0E0_71E7

Jump_0E0_71CE::
    push hl
    ld hl, $8A40
    ld de, $1206
    call Func_000_2E98
    pop hl
    ld a, $01
    ld [$C528], a
    ld a, [hl+]
    ld [$C529], a
    push hl
    call Func_0E0_76F5
    pop hl

Jump_0E0_71E7::
    ld a, l
    ld [$D0A5], a
    ld a, h
    ld [$D0A6], a
    ld a, [$C525]
    or a, a
    jr z, Jump_0E0_7208
    ld a, $01
    ldh [$FF4F], a
    ld a, $00
    ld hl, $9800
    ld bc, $1412
    call Func_0E0_758B
    ld a, $00
    ldh [$FF4F], a

Jump_0E0_7208::
    ld a, $7F
    ld hl, $9800
    ld bc, $1412
    call Func_0E0_758B
    ld hl, $D0A8
    ld a, [hl-]
    add a, a
    add a, [hl]
    ld b, a
    ld a, $12
    sub a, b
    srl a
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld de, $9800
    add hl, de
    ld de, $0001
    add hl, de
    ld de, $0020
    ld b, $12
    ld a, [$D0A7]
    ld c, a
    or a, a
    jr z, Jump_0E0_7240
    ld a, $80
    call Func_0E0_740E

Jump_0E0_7240::
    ld a, l
    and a, $E0
    ld l, a
    ld de, $0041
    add hl, de
    ld de, $0040
    ld b, $12
    ld a, [$D0A8]
    ld c, a
    or a, a
    jr z, Jump_0E0_7259
    ld a, $A4
    call Func_0E0_740E

Jump_0E0_7259::
    ld hl, $D09E
    inc [hl]
    ld a, [$C524]
    or a, a
    ld hl, $01A4
    jr z, Jump_0E0_7269
    ld hl, $012C

Jump_0E0_7269::
    ld a, [$D0A5]
    ld e, a
    ld a, [$D0A6]
    ld d, a
    dec de
    dec de
    dec de
    ld a, [de]
    cp a, $00
    jr z, Jump_0E0_72AC
    cp a, $05
    jr z, Jump_0E0_72AC
    cp a, $0F
    jr z, Jump_0E0_72AC
    cp a, $13
    jr z, Jump_0E0_72AC
    cp a, $14
    jr z, Jump_0E0_72AC
    cp a, $15
    jr z, Jump_0E0_72AC
    cp a, $16
    jr z, Jump_0E0_72AC
    cp a, $17
    jr z, Jump_0E0_72AC
    cp a, $18
    jr z, Jump_0E0_72AC
    cp a, $19
    jr z, Jump_0E0_72AC
    cp a, $1A
    jr z, Jump_0E0_72AC
    cp a, $1B
    cp a, $20
    jr c, Jump_0E0_72AF
    ld hl, $FFFF
    jr Jump_0E0_72AF

Jump_0E0_72AC::
    ld hl, $012C

Jump_0E0_72AF::
    ld a, l
    ld [$D0A2], a
    ld a, h
    ld [$D0A3], a
    call Func_0E0_75BF
    ld a, $FC
    call Func_000_0DF2
    ret

Jump_0E0_72C0::
    ld hl, $D0A2
    ld a, [hl+]
    and a, [hl]
    cp a, $FF
    jr z, Jump_0E0_72DB
    ld a, [$D0A2]
    sub a, $01
    ld [$D0A2], a
    ld a, [$D0A3]
    sbc a, $00
    ld [$D0A3], a
    jr Jump_0E0_732E

Jump_0E0_72DB::
    ld a, [$DC40]
    ld hl, $DC41
    and a, [hl]
    ld hl, $DC60
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, $DC80
    and a, [hl]
    inc hl
    and a, [hl]
    cp a, $FF
    ret nz
    ld a, $10
    call Func_000_0DF2
    ld a, $05
    ldh [$FF90], a
    ld a, $01
    ldh [$FF8F], a
    xor a, a
    ldh [$FF92], a
    ld a, $B0
    ldh [$FF8E], a
    ld [$C8F0], a
    ld a, $40
    ldh [$FF91], a
    ld [$C8F1], a
    ld a, $03
    ldh [$FF98], a
    ld a, [$C6FD]
    ld [$C933], a
    ld de, $019F
    call Func_000_1845
    ld a, $01
    ld [$C5DB], a
    ld a, $01
    ld [$C5DC], a
    ld hl, $C5DF
    inc [hl]
    ret

Jump_0E0_732E::
    ld hl, $D0A2
    ld a, [hl+]
    or a, [hl]
    ret nz
    ld a, $04
    call Func_000_0DF2
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_733E::
    ld a, [$C56C]
    or a, a
    ret nz
    ld a, [$D0A1]
    dec a
    ld [$D0A1], a
    jr z, Jump_0E0_7351
    xor a, a
    ld [$D09E], a
    ret

Jump_0E0_7351::
    ld hl, $D09F
    inc [hl]
    ld hl, $D09D
    inc [hl]
    xor a, a
    ld [$D09E], a
    ret

Jump_0E0_735E::
    ld hl, $97F0
    ld de, $0101
    call Func_000_2E98
    ld hl, $8800
    ld de, $0E02
    call Func_000_2E98
    ld a, $02
    ld [$C528], a
    xor a, a
    ld [$C529], a
    call Func_0E0_76F5
    ld a, [$C525]
    or a, a
    jr z, Jump_0E0_73A2
    ld b, $48
    ld de, Data_048_4001
    ld hl, $C49F
    ld c, $08
    call Func_000_0B2B
    ld a, $01
    ldh [$FF4F], a
    ld a, $00
    ld hl, $9800
    ld bc, $1412
    call Func_0E0_758B
    ld a, $00
    ldh [$FF4F], a

Jump_0E0_73A2::
    ld a, $7F
    ld hl, $9800
    ld bc, $1412
    call Func_0E0_758B
    ld a, $80
    ld hl, $98E3
    ld de, $0040
    ld bc, $0E02
    call Func_0E0_740E
    ld a, [$C524]
    or a, a
    ld hl, $0168
    jr z, Jump_0E0_73C7
    ld hl, $00F0

Jump_0E0_73C7::
    ld a, l
    ld [$D0A2], a
    ld a, h
    ld [$D0A3], a
    call Func_0E0_75BF
    ld a, $FC
    call Func_000_0DF2
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_73DC::
    ld a, [$D0A2]
    sub a, $01
    ld [$D0A2], a
    ld a, [$D0A3]
    sbc a, $00
    ld [$D0A3], a
    ld hl, $D0A2
    ld a, [hl+]
    or a, [hl]
    ret nz
    ld a, $04
    call Func_000_0DF2
    ld hl, $D09E
    inc [hl]
    ret

Jump_0E0_73FC::
    ld a, [$C56C]
    or a, a
    ret nz
    ld hl, $D09F
    inc [hl]
    ld hl, $D09D
    inc [hl]
    xor a, a
    ld [$D09E], a
    ret

Func_0E0_740E::
    push bc
    push hl

Jump_0E0_7410::
    di
    call Func_000_121F
    ei
    inc a
    dec b
    jr nz, Jump_0E0_7410
    pop hl
    pop bc
    add hl, de
    dec c
    jr nz, Func_0E0_740E
    ret

Func_0E0_7420::
    ld a, [$CB7D]
    or a, a
    ret z
    ld b, a
    ld hl, $CB7F

Jump_0E0_7429::
    push bc
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    ldh [$FFAD], a
    ld a, [hl+]
    add a, $08
    ldh [$FFA9], a
    ld a, [hl+]
    ldh [$FFAB], a
    ld a, [hl+]
    ldh [$FFB0], a
    ld a, [hl+]
    ld b, a
    ld a, [hl+]
    ldh [$FFAF], a
    ld a, [hl+]
    ld e, a
    ld a, c
    cp a, $02
    ld a, b
    jr z, Jump_0E0_745E
    ld a, e
    and a, $20
    srl a
    swap a
    ld e, a
    ld a, b
    cp a, $03
    jr nz, Jump_0E0_745C
    ldh a, [$FFB0]
    or a, $20
    ldh [$FFB0], a
    ld a, $01

Jump_0E0_745C::
    add a, a
    add a, e

Jump_0E0_745E::
    ldh [$FFAE], a
    ld b, $00
    push hl
    ld hl, Data_0E0_7477
    add hl, bc
    add hl, bc
    add hl, bc
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld b, [hl]
    ld l, e
    ld h, d
    rst $10
    pop hl
    pop bc
    dec b
    jr nz, Jump_0E0_7429
    ret

Data_0E0_7477:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $40, $25, $01, $40, $7F, $0A, $70, $7F

Func_0E0_7480::
    ld b, $08
    ld hl, $CB7F

Jump_0E0_7485::
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    inc [hl]
    inc hl
    dec b
    jr nz, Jump_0E0_7485
    ret

Func_0E0_7492::
    ld c, $00
    swap a
    srl a
    ld hl, $CB7F
    add a, l
    ld l, a
    jr nc, Jump_0E0_74A0
    inc h

Jump_0E0_74A0::
    inc hl
    inc hl
    ld a, [hl]
    cp a, d
    jr z, Jump_0E0_74AF
    jr c, Jump_0E0_74AB
    dec a
    jr Jump_0E0_74AC

Jump_0E0_74AB::
    inc a

Jump_0E0_74AC::
    ld [hl], a
    ld c, $01

Jump_0E0_74AF::
    inc hl
    ld a, [hl]
    cp a, e
    jr z, Jump_0E0_74BD
    jr c, Jump_0E0_74B9
    dec a
    jr Jump_0E0_74BA

Jump_0E0_74B9::
    inc a

Jump_0E0_74BA::
    ld [hl], a
    ld c, $01

Jump_0E0_74BD::
    inc hl
    inc hl
    inc hl
    inc hl
    inc [hl]
    ld a, c
    or a, a
    ret

Func_0E0_74C5::
    swap a
    srl a
    ld hl, $CB7F
    add a, l
    ld l, a
    jr nc, Jump_0E0_74D1
    inc h

Jump_0E0_74D1::
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    ld [hl], c
    ret

Func_0E0_74D8::
    ld c, $00
    swap a
    srl a
    ld hl, $CB7F
    add a, l
    ld l, a
    jr nc, Jump_0E0_74E6
    inc h

Jump_0E0_74E6::
    inc hl
    inc hl
    ld a, [hl]
    ld b, a
    cp a, d
    jr z, Jump_0E0_7513
    jr c, Jump_0E0_7501
    push hl
    ld a, [$D0A7]
    ld hl, Data_0E0_7535
    add a, l
    ld l, a
    jr nc, Jump_0E0_74FB
    inc h

Jump_0E0_74FB::
    ld a, b
    sub a, [hl]
    pop hl
    ld [hl], a
    jr Jump_0E0_7511

Jump_0E0_7501::
    push hl
    ld a, [$D0A7]
    ld hl, Data_0E0_7535
    add a, l
    ld l, a
    jr nc, Jump_0E0_750D
    inc h

Jump_0E0_750D::
    ld a, b
    add a, [hl]
    pop hl
    ld [hl], a

Jump_0E0_7511::
    ld c, $01

Jump_0E0_7513::
    inc hl
    ld a, [hl]
    cp a, e
    jr z, Jump_0E0_7532
    ld b, a
    push hl
    ld a, [$D0A7]
    ld hl, Data_0E0_7542
    add a, l
    ld l, a
    jr nc, Jump_0E0_7525
    inc h

Jump_0E0_7525::
    ld a, b
    sub a, [hl]
    pop hl
    ld [hl], a
    ld a, [$D0A7]
    inc a
    ld [$D0A7], a
    ld c, $01

Jump_0E0_7532::
    ld a, c
    or a, a
    ret

Data_0E0_7535:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $01, $01, $01, $01, $01, $01, $01, $02, $02, $02, $02, $00

Data_0E0_7542:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $02, $02, $02, $02, $01, $01

Data_0E0_7548:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $01, $01, $01, $01, $01, $00

Func_0E0_754F::
    ld a, [$D0A2]
    inc a
    ld [$D0A2], a
    cp a, $0F
    ret c
    xor a, a
    ld [$D0A2], a
    ret

Func_0E0_755E::
    ld a, [$D0A2]
    inc a
    ld [$D0A2], a
    cp a, $1E
    ret c
    xor a, a
    ld [$D0A2], a
    ret

Func_0E0_756D::
    ld a, [$D0A2]
    inc a
    ld [$D0A2], a
    cp a, $2D
    ret c
    xor a, a
    ld [$D0A2], a
    ret

Func_0E0_757C::
    ld a, [$D0A2]
    inc a
    ld [$D0A2], a
    cp a, $3C
    ret c
    xor a, a
    ld [$D0A2], a
    ret

Func_0E0_758B::
    push bc
    push hl

Jump_0E0_758D::
    di
    push af
    call Func_000_120A
    pop af
    ld [hl], a
    ei
    push af
    ld a, l
    push af
    inc l
    ld a, l
    and a, $1F
    ld l, a
    pop af
    and a, $E0
    or a, l
    ld l, a
    pop af
    dec b
    jr nz, Jump_0E0_758D
    pop hl
    push af
    ld a, h
    and a, $9C
    ld c, a
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, h
    and a, $03
    or a, c
    ld h, a
    pop af
    pop bc
    dec c
    jr nz, Func_0E0_758B
    ret

Func_0E0_75BF::
    ld hl, $C5E9
    ld a, $D2
    ld [hl+], a
    ld a, $D2
    ld [hl+], a
    ld a, $E2
    ld [hl], a
    ld hl, $D040
    ld a, [$C5E9]
    ld [hl+], a
    ld a, [$C5EA]
    ld [hl+], a
    ld a, [$C5EB]
    ld [hl], a
    call Func_000_0DCA
    ld a, [$C524]
    or a, a
    jr z, Jump_0E0_7640
    xor a, a
    ldh [$FF47], a
    ldh [$FF48], a
    ldh [$FF49], a
    ld a, [$C51F]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    ld [$C577], a
    ld a, h
    ld [$C578], a
    inc hl
    ld a, l
    ld [$C579], a
    ld a, h
    ld [$C57A], a
    inc hl
    ld a, l
    ld [$C57B], a
    ld a, h
    ld [$C57C], a
    inc hl
    ld a, l
    ld [$C57D], a
    ld a, h
    ld [$C57E], a
    ld a, $B1
    ld [$C47F], a
    ld a, [$C520]
    ld [$C480], a
    ld a, $FF
    ld [$C47C], a
    ld b, $1F
    ld hl, Func_01F_5040
    rst $10
    call Func_000_05D1
    ld hl, Func_017_421A
    ld b, $17
    rst $10
    ld hl, Data_0E0_7641
    ld de, $C4FF
    ld bc, $0008
    call Func_000_0952

Jump_0E0_7640::
    ret

Data_0E0_7641:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $DE, $67, $1F, $33, $3C, $12, $00, $00

Data_0E0_7649:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $383649, $97

Func_0E0_76E0::
    ld a, [$C528]
    cp a, $01
    jr c, Jump_0E0_76EE
    ld hl, Func_0A2_49E2
    ld b, $A2

Jump_0E0_76EC::
    rst $10
    ret

Jump_0E0_76EE::
    ld de, Data_0E0_76FC
    call Func_000_25C9
    ret

Func_0E0_76F5::
    call Func_0E0_76E0
    call Func_000_2611
    ret

Data_0E0_76FC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FE, $76
    dw Func_0E0_7740
    dw Func_0E0_7753
    dw Func_0E0_7776
    dw Func_0E0_7795
    dw Func_0E0_77A6
    dw Func_0E0_77C6
    dw Func_0E0_77D9
    dw Func_0E0_77F9
    dw Func_0E0_780B
    dw Func_0E0_7828
    db $39, $78, $49, $78
    dw Func_0E0_7861
    dw Func_0E0_787B
    dw Func_0E0_788B
    dw Func_0E0_789A
    dw Func_0E0_78AC
    dw Func_0E0_78BA
    dw Func_0E0_78CD
    dw Func_0E0_78E0
    dw Func_0E0_78F0
    dw Func_0E0_7900
    dw Func_0E0_7910
    dw Func_0E0_7920
    dw Func_0E0_7930
    dw Func_0E0_7940
    dw Func_0E0_7950
    dw Func_0E0_7960
    dw Func_0E0_797E
    dw Func_0E0_798C
    dw Func_0E0_79AA
    dw $79B9
    dw Func_0E0_79BA

Func_0E0_7740:: ; heuristic: target of a pointer table; C0
    ld c, $21
    ld c, $0C
    ld e, $1D
    ld [de], a
    rra
    ld c, $90
    dec c
    ld [de], a
    dec de
    ld c, $0C
    dec e
    jr Jump_0E0_776D
    db $F0

Func_0E0_7753:: ; heuristic: target of a pointer table; C0
    inc e
    inc c
    ld c, $17
    ld a, [bc]
    dec de
    ld [de], a
    jr Jump_0E0_76EC
    db $B6, $90, $10, $0A, $16, $0E, $F1, $90, $90, $90, $90, $90, $90, $90, $90, $90
    db $0D

Jump_0E0_776D::
    ld c, $1C
    ld [de], a
    db $10, $17 ; stop
    ld c, $1B
    inc e
    db $F0

Func_0E0_7776:: ; heuristic: target of a pointer table; C0
    inc c
    ld de, $1B0A
    ld a, [bc]
    inc c
    dec e
    ld c, $1B
    sub a, b
    or a, [hl]
    pop af
    sub a, b
    sub a, b
    ld d, $18
    rla
    inc e
    dec e
    ld c, $1B
    sub a, b
    dec c
    ld c, $1C
    ld [de], a
    db $10, $17 ; stop
    ld c, $1B
    db $F0

Func_0E0_7795:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    ld d, $1E
    inc e
    ld [de], a
    inc c
    sub a, b
    inc c
    jr Jump_0E0_77B6
    db $19, $18, $1C, $0E, $1B, $F0

Func_0E0_77A6:: ; heuristic: target of a pointer table; C0
    dec d
    jr Jump_0E0_77B5

Func_0E0_77A9:: ; heuristic: follows a terminator; C0
    ld a, [bc]
    dec d
    ld [de], a
    inc hl
    ld a, [bc]
    dec e
    ld [de], a
    jr Jump_0E0_77C9
    db $F1, $90, $90

Jump_0E0_77B5::
    sub a, b

Jump_0E0_77B6::
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    inc e
    add hl, de
    ld c, $0C
    ld [de], a
    ld a, [bc]
    dec d
    ld [de], a
    inc e
    dec e
    inc e
    db $F0

Func_0E0_77C6:: ; heuristic: target of a pointer table; C0
    sub a, b
    ld c, $17

Jump_0E0_77C9::
    ld [de], a
    ld hl, $0A90
    ld d, $0E
    dec de
    ld [de], a
    inc c
    ld a, [bc]
    sub a, b
    ld [de], a
    rla
    inc c
    or a, l
    db $F0

Func_0E0_77D9:: ; heuristic: target of a pointer table; C0
    dec d
    jr Jump_0E0_77E8

Func_0E0_77DC:: ; heuristic: follows a terminator; C0
    ld a, [bc]
    dec d
    ld [de], a
    inc hl
    ld a, [bc]
    dec e
    ld [de], a
    jr Jump_0E0_77FC
    db $F1, $90, $90

Jump_0E0_77E8::
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    ld d, $0A
    rla
    ld a, [bc]
    db $10, $0E ; stop
    dec de
    db $F0

Func_0E0_77F9:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    add hl, de

Jump_0E0_77FC::
    dec de
    jr Jump_0E0_780C
    db $1E, $0C, $1D, $90, $16, $0A, $17, $0A, $10, $0E, $1B, $F0

Func_0E0_780B:: ; heuristic: target of a pointer table; C0
    ld a, [bc]

Jump_0E0_780C::
    inc e
    inc e
    ld [de], a
    inc e
    dec e
    ld a, [bc]
    rla
    dec e
    pop af
    sub a, b
    sub a, b
    sub a, b
    add hl, de
    dec de
    jr Jump_0E0_7829
    db $1E, $0C, $1D, $90, $16, $0A, $17, $0A, $10, $0E, $1B, $F0

Func_0E0_7828:: ; heuristic: target of a pointer table; C0
    sub a, b

Jump_0E0_7829::
    sub a, b
    sub a, b
    ld a, [de]
    ld a, [bc]
    sub a, b
    dec e
    dec de
    ld a, [bc]
    rla
    inc e
    dec d
    ld a, [bc]
    dec e
    jr Jump_0E0_7853
    db $F0, $90, $90, $90, $19, $15, $0A, $22, $90, $1D, $0E, $1C, $1D, $0E, $1B, $1C
    db $F0, $1C, $0A, $15, $0E, $1C, $9E, $16, $0A, $1B, $14

Jump_0E0_7853::
    ld c, $1D
    ld [de], a
    rla
    db $10, $F1 ; stop
    ld d, $0A
    rla
    ld a, [bc]
    db $10, $0E ; stop
    dec de
    db $F0

Func_0E0_7861:: ; heuristic: target of a pointer table; C0
    ld a, [bc]
    inc c
    inc c
    jr Jump_0E0_7884
    db $17, $1D, $12, $17, $10, $9E, $0C, $1B, $0E, $0D, $12, $1D, $F1, $16, $0A, $17
    db $0A, $10, $0E, $1B, $F0

Func_0E0_787B:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    ld a, [bc]
    sbc a, [hl]
    dec de
    sub a, b
    ld a, [bc]

Jump_0E0_7884::
    rla
    ld a, [bc]
    dec d
    ld [hl+], a
    inc e
    dec e
    db $F0

Func_0E0_788B:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    add hl, de
    dec de
    ld c, $1C
    ld [de], a
    dec c
    ld c, $17
    dec e
    db $F0

Func_0E0_789A:: ; heuristic: target of a pointer table; C0
    sub a, b
    ld c, $17
    ld [de], a
    ld hl, $0C90
    jr Jump_0E0_78BE
    db $19, $18, $1B, $0A, $1D, $12, $18, $17, $F0

Func_0E0_78AC:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    ld a, [bc]
    dec de
    dec e
    jr nz, Jump_0E0_78CF
    dec de
    inc d
    db $F0

Func_0E0_78BA:: ; heuristic: target of a pointer table; C0
    sub a, b
    dec e
    ld c, $0C

Jump_0E0_78BE::
    ld de, $1217
    inc c
    ld a, [bc]
    dec d
    sub a, b
    inc e
    ld e, $19
    add hl, de
    jr Jump_0E0_78E6
    db $1D, $F0

Func_0E0_78CD:: ; heuristic: target of a pointer table; C0
    sub a, b
    dec e

Jump_0E0_78CF::
    ld c, $0C
    ld de, $1217
    inc c
    ld a, [bc]
    dec d
    sub a, b
    inc e
    ld e, $19
    add hl, de
    jr Jump_0E0_78F9
    db $1D, $F0

Func_0E0_78E0:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    sub a, b
    add hl, de
    dec d
    ld a, [bc]

Jump_0E0_78E6::
    ld [hl+], a
    sub a, b
    dec e
    ld c, $1C
    dec e
    ld c, $1B
    inc e
    db $F0

Func_0E0_78F0:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    sub a, b
    add hl, de
    dec d
    ld a, [bc]
    ld [hl+], a
    sub a, b
    dec e

Jump_0E0_78F9::
    ld c, $1C
    dec e
    ld c, $1B
    inc e
    db $F0

Func_0E0_7900:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    sub a, b
    add hl, de
    dec d
    ld a, [bc]
    ld [hl+], a
    sub a, b
    dec e
    ld c, $1C
    dec e
    ld c, $1B
    inc e
    db $F0

Func_0E0_7910:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    sub a, b
    add hl, de
    dec d
    ld a, [bc]
    ld [hl+], a
    sub a, b
    dec e
    ld c, $1C
    dec e
    ld c, $1B
    inc e
    db $F0

Func_0E0_7920:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    sub a, b
    add hl, de
    dec d
    ld a, [bc]
    ld [hl+], a
    sub a, b
    dec e
    ld c, $1C
    dec e
    ld c, $1B
    inc e
    db $F0

Func_0E0_7930:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    sub a, b
    add hl, de
    dec d
    ld a, [bc]
    ld [hl+], a
    sub a, b
    dec e
    ld c, $1C
    dec e
    ld c, $1B
    inc e
    db $F0

Func_0E0_7940:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    sub a, b
    add hl, de
    dec d
    ld a, [bc]
    ld [hl+], a
    sub a, b
    dec e
    ld c, $1C
    dec e
    ld c, $1B
    inc e
    db $F0

Func_0E0_7950:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    sub a, b
    add hl, de
    dec d
    ld a, [bc]
    ld [hl+], a
    sub a, b
    dec e
    ld c, $1C
    dec e
    ld c, $1B
    inc e
    db $F0

Func_0E0_7960:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    ld a, [bc]
    inc e
    inc e
    ld [de], a
    inc e
    dec e
    ld a, [bc]
    rla
    dec e
    pop af
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    add hl, de
    dec de
    jr Jump_0E0_7985
    db $1E, $0C, $0E, $1B, $1C, $F0

Func_0E0_797E:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    add hl, de
    dec de

Jump_0E0_7985::
    jr Jump_0E0_7994
    db $1E, $0C, $0E, $1B, $F0

Func_0E0_798C:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    ld c, $21
    ld c, $0C

Jump_0E0_7994::
    ld e, $1D
    ld [de], a
    rra
    ld c, $F1
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    add hl, de
    dec de
    jr Jump_0E0_79B1
    db $1E, $0C, $0E, $1B, $1C, $F0

Func_0E0_79AA:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    add hl, de
    dec de

Jump_0E0_79B1::
    ld c, $1C
    ld [de], a
    dec c
    ld c, $17
    dec e
    ldh a, [$FFF0]

Func_0E0_79BA:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    cp a, b
    ld [bc], a
    nop
    nop
    ld bc, $0E90
    rla
    ld [de], a
    ld hl, $21F0
    rst $38
    ret c
    jr Jump_0E0_79F6
    db $21, $0F, $D9, $18, $23, $21, $CF, $D8, $18, $1E, $21, $EF, $D8, $18, $19, $21
    db $BF, $D8, $18, $14, $21, $DF, $D8, $18, $0F, $21, $1F, $D9, $18, $0A, $21, $53
    db $DA, $85, $6F, $30, $01, $24, $7E, $C9

Jump_0E0_79F6::
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0E0_79FC
    inc h

Jump_0E0_79FC::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ret

Func_0E0_7A00:: ; heuristic: follows a terminator; C0
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0E0_7A06
    inc h

Jump_0E0_7A06::
    ret

Func_0E0_7A07:: ; heuristic: follows a terminator; C0
    ld a, [$C58A]
    cp a, $01
    jr nz, Jump_0E0_7A1C
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_0E0_7A1C
    ld a, [$D8A4]
    cp a, $04
    ccf
    ret

Jump_0E0_7A1C::
    ld a, [$D8A4]
    cp a, $04
    ret

Func_0E0_7A22:: ; heuristic: follows a terminator; C0
    ld a, [$C58A]
    cp a, $01
    jr nz, Jump_0E0_7A37
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_0E0_7A37
    ld a, [$D8A5]
    cp a, $04
    ccf
    ret

Jump_0E0_7A37::
    ld a, [$D8A5]
    cp a, $04
    ret
    INCBIN "dwm2-cobi-us.gbc", $383A3D, $43

Func_0E0_7A80::
    push hl
    push bc
    ld c, a
    ld b, $00
    ld hl, $D968
    add a, l
    ld l, a
    jr nc, Jump_0E0_7A8D
    inc h

Jump_0E0_7A8D::
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_0E0_7A9C
    ld l, $09
    cp a, $40
    jr nc, Jump_0E0_7A9C
    ld l, $12

Jump_0E0_7A9C::
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, $D970
    add a, l
    ld l, a
    jr nc, Jump_0E0_7AA8
    inc h

Jump_0E0_7AA8::
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_0E0_7AB7
    ld l, $03
    cp a, $40
    jr nc, Jump_0E0_7AB7
    ld l, $06

Jump_0E0_7AB7::
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, $D978
    add a, l
    ld l, a
    jr nc, Jump_0E0_7AC3
    inc h

Jump_0E0_7AC3::
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_0E0_7AD2
    ld l, $01
    cp a, $40
    jr nc, Jump_0E0_7AD2
    ld l, $02

Jump_0E0_7AD2::
    ld a, l
    add a, b
    pop bc
    pop hl
    ret

Func_0E0_7AD7:: ; heuristic: follows a terminator; C0
    call Func_000_3E25
    ret c
    push hl
    push bc
    ld c, a
    ld hl, $D80F
    call Func_000_3F25
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_0E0_7AF1
    ld a, [hl]
    and a, $0C
    jr nz, Jump_0E0_7AF1
    xor a, a
    jr Jump_0E0_7AF2

Jump_0E0_7AF1::
    scf

Jump_0E0_7AF2::
    ld a, c
    pop bc
    pop hl
    ret

Func_0E0_7AF6:: ; heuristic: follows a terminator; C0
    push hl
    ld hl, $D80F
    call Func_000_3F25
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_0E0_7B05
    ld a, [hl]
    and a, $0C

Jump_0E0_7B05::
    pop hl
    ret
    ds $4F9, $00
