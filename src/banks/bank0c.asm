SECTION "Bank 0C", ROMX[$4000], BANK[$0C]
    db $0C

Func_00C_4001::
    ld a, [$D780]
    rst $00
    dw Func_00C_4027
    dw Func_00C_404A
    dw Func_00C_4087
    dw Func_00C_4092
    dw Func_00C_40E6
    dw Func_00C_41D7
    dw Func_00C_433D
    dw Func_00C_4360
    dw Func_00C_43CE
    dw Func_00C_443D
    dw Func_00C_4448
    dw Func_00C_4492
    dw Func_00C_449D
    dw Func_00C_4609
    dw Func_00C_4650
    dw Func_00C_4676
    db $84, $46

Func_00C_4027:: ; heuristic: target of a pointer table; C0
    ld hl, $D780
    ld bc, $0020

Jump_00C_402D::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_00C_402D
    ld a, $09
    ld [$D7F0], a
    ld a, [$D780]
    inc a
    db $EA, $80

Func_00C_403F:: ; heuristic: target of a pointer table; C0
    rst $10
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_00C_404A:: ; heuristic: target of a pointer table; C0
    call Func_00C_5177
    xor a, a
    ldh [$FFA5], a
    ldh [$FFA1], a
    ldh a, [$FFB9]
    ld [$D799], a
    ldh a, [$FFBA]
    ld [$D79A], a
    ld a, $90
    ldh [$FFBA], a
    ld a, $01
    ldh [$FFB9], a
    ld a, $0F
    ldh [$FF8D], a
    ld hl, $8000
    ld bc, $0800

Jump_00C_406E::
    di

Jump_00C_406F::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_00C_406F
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_00C_406E
    call Func_00C_511B
    ld a, [$D780]
    inc a
    ld [$D780], a
    ret

Func_00C_4087:: ; heuristic: target of a pointer table; C0
    call Func_00C_5269
    ld a, [$D780]
    inc a
    ld [$D780], a
    ret

Func_00C_4092:: ; heuristic: target of a pointer table; C0
    ld de, Data_00C_56D9
    ld hl, $C364
    ld bc, $090D
    call Func_00C_51BB
    ld a, [$D787]
    and a, a
    jr z, Jump_00C_40A9
    ld a, $C3
    ld [$C445], a

Jump_00C_40A9::
    ld a, [$D786]
    ld hl, Data_00C_58FE
    ld b, $BB
    call Func_00C_525B
    call Func_00C_5156
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    ld a, [$D786]
    ld hl, Data_00C_58FE
    ld b, $C3
    call Func_00C_525B
    call Func_00C_5156
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call Func_00C_51F5
    call Func_00C_4F74
    ld a, [$D780]
    inc a
    ld [$D780], a
    ret

Func_00C_40E6:: ; heuristic: target of a pointer table; C0
    call Func_00C_5156
    ld de, $0182
    add hl, de
    ld a, [$D787]
    add a, $E1
    ld b, a
    di
    call Func_000_120A
    ld a, b
    ld [hl+], a
    ei
    ld c, $00

Jump_00C_40FC::
    ld a, [$D787]
    add a, a
    ld b, a
    add a, a

Func_00C_4102:: ; heuristic: target of a pointer table; C0
    add a, b
    ld b, a
    ld a, c
    add a, b
    add a, a
    ld hl, Data_00C_5916
    add a, l
    ld l, a
    jr nc, Jump_00C_410F
    inc h

Jump_00C_410F::
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld b, $00

Jump_00C_4114::
    ld a, d
    cp a, $FF
    jp z, Jump_00C_41AA
    push de
    push bc
    ld a, e
    ld [$D7F1], a
    ld a, d
    ld [$D7F2], a
    ld de, $C7FC
    ld a, e
    ld [$D7F3], a
    ld a, d
    ld [$D7F4], a
    ld hl, $68FA
    ld b, $15
    rst $10
    ld a, [$D7F5]
    cp a, $FF
    jr nz, Jump_00C_4141

Jump_00C_413C::
    pop bc
    inc b
    push bc
    jr Jump_00C_4159

Jump_00C_4141::
    pop bc
    pop de
    push de
    push bc
    ld a, e
    ld [$D006], a
    ld a, d
    ld [$D007], a
    ld hl, Data_00C_5A7E
    ld b, $16
    rst $10
    ld a, c
    and a, a
    jr z, Jump_00C_4159
    jr Jump_00C_413C

Jump_00C_4159::
    pop bc
    pop de
    inc de
    ld a, [$D787]
    add a, a
    ld l, a
    add a, a
    add a, l
    ld l, a
    ld a, c
    add a, l
    add a, a
    ld hl, Data_00C_592E
    add a, l
    ld l, a
    jr nc, Jump_00C_416F
    inc h

Jump_00C_416F::
    push de
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    pop de
    ld a, d
    cp a, h
    jr c, Jump_00C_4114
    jr nz, Jump_00C_417F
    ld a, e
    cp a, l
    jr c, Jump_00C_4114

Jump_00C_417F::
    push bc
    ld a, [$D787]
    add a, a
    ld b, a
    add a, a
    add a, b
    ld hl, $D78E
    add a, l
    ld l, a
    jr nc, Jump_00C_418F
    inc h

Jump_00C_418F::
    pop bc
    ld a, c
    add a, l
    ld l, a
    jr nc, Jump_00C_4196
    inc h

Jump_00C_4196::
    ld a, b
    ld [hl], a
    ld a, [$D787]
    and a, a
    jr z, Jump_00C_41A2
    ld b, $05
    jr Jump_00C_41A4

Jump_00C_41A2::
    ld b, $06

Jump_00C_41A4::
    inc c
    ld a, c
    cp a, b
    jp c, Jump_00C_40FC

Jump_00C_41AA::
    xor a, a
    ld [$D7F1], a
    call Func_00C_5085
    ld a, $01
    ld [$D7F1], a
    call Func_00C_5085
    ld a, [$D780]
    inc a
    ld [$D780], a
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

Func_00C_41D7:: ; heuristic: target of a pointer table; C0
    ld a, [$C563]
    bit 4, a
    jr nz, Jump_00C_41FB
    bit 5, a
    jr nz, Jump_00C_4229
    bit 6, a
    jr nz, Jump_00C_4236
    bit 7, a
    jr nz, Jump_00C_425C
    ld a, [$C562]
    bit 0, a
    jp nz, Jump_00C_4278
    bit 1, a
    jp nz, Jump_00C_42D3
    call Func_00C_42F0
    ret

Jump_00C_41FB::
    ld a, [$D787]
    cp a, $01
    db $38

Func_00C_4201:: ; heuristic: target of a pointer table; C0
    inc bc

Func_00C_4202:: ; heuristic: target of a pointer table; C0
    xor a, a
    jr Jump_00C_4206
    db $3C

Jump_00C_4206::
    ld [$D787], a
    cp a, $01
    jr c, Jump_00C_4218
    ld a, [$D786]
    cp a, $05
    jr c, Jump_00C_4218
    dec a
    ld [$D786], a

Jump_00C_4218::
    call Func_00C_430A
    ld a, $69
    call Func_000_1278
    ld a, [$D780]
    sub a, $03
    ld [$D780], a
    ret

Jump_00C_4229::
    ld a, [$D787]
    and a, a
    jr nz, Jump_00C_4233
    ld a, $01
    jr Jump_00C_4206

Jump_00C_4233::
    dec a
    jr Jump_00C_4206

Jump_00C_4236::
    call Func_00C_430E
    ld a, [$D787]
    ld de, Data_00C_56D7
    add a, e
    ld e, a
    jr nc, Jump_00C_4244
    inc d

Jump_00C_4244::
    ld a, [de]
    ld b, a
    ld a, [$D786]
    and a, a
    jr nz, Jump_00C_424F
    ld a, b
    jr Jump_00C_4250

Jump_00C_424F::
    dec a

Jump_00C_4250::
    ld [$D786], a
    call Func_00C_430A
    ld a, $69
    call Func_000_1278
    ret

Jump_00C_425C::
    call Func_00C_430E
    ld a, [$D787]
    ld de, Data_00C_56D7
    add a, e
    ld e, a
    jr nc, Jump_00C_426A
    inc d

Jump_00C_426A::
    ld a, [de]
    ld b, a
    ld a, [$D786]
    cp a, b
    jr c, Jump_00C_4275
    xor a, a
    jr Jump_00C_4250

Jump_00C_4275::
    inc a
    jr Jump_00C_4250

Jump_00C_4278::
    ld a, [$D787]
    add a, a
    ld b, a
    add a, a
    add a, b
    ld b, a
    ld a, [$D786]
    add a, b
    ld hl, $D78E
    add a, l
    ld l, a
    jr nc, Jump_00C_428C
    inc h

Jump_00C_428C::
    ld a, [hl]
    and a, a
    jr nz, Jump_00C_42A2
    call Func_00C_4312
    ld a, $01
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_00C_42A2::
    ld a, $69
    call Func_000_1278
    call Func_00C_4312
    ld a, [$D786]
    ld hl, Data_00C_58FE
    ld b, $BC
    call Func_00C_525B
    ld a, [$D787]
    add a, $E1
    ld [$C456], a
    xor a, a
    ld [$D7FA], a
    ld a, [$D780]
    add a, $04
    ld [$D780], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_00C_42D3::
    ld a, [$D780]
    inc a
    ld [$D780], a
    ld a, $02
    ld [$D7FA], a
    ld a, $02
    ldh [$FFB9], a
    xor a, a
    ldh [$FFBA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_00C_42F0::
    ld a, [$C564]
    cp a, $14
    jr c, Func_00C_430A
    ld a, [$D785]
    inc a
    ld [$D785], a
    cp a, $10
    jr c, Func_00C_430A

Func_00C_4302:: ; heuristic: target of a pointer table; C0
    cp a, $18
    jr c, Func_00C_430E
    xor a, a
    ld [$D785], a

Func_00C_430A::
    ld b, $BB
    jr Jump_00C_4314

Func_00C_430E::
    ld b, $C3
    jr Jump_00C_4314

Func_00C_4312::
    ld b, $BC

Jump_00C_4314::
    ld a, [$D786]
    add a, a
    ld hl, Data_00C_4331
    add a, l
    ld l, a
    jr nc, Jump_00C_4320
    inc h

Jump_00C_4320::
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call Func_00C_5156
    pop de
    add hl, de
    di
    call Func_000_120A
    ld a, b
    ld [hl], a
    ei
    ret

Data_00C_4331:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $21, $00, $61, $00, $A1, $00, $E1, $00, $21, $01, $61, $01

Func_00C_433D:: ; heuristic: target of a pointer table; C0
    call Func_00C_5177
    ld a, $11
    ldh [$FF90], a
    call Func_000_1C0C
    ld hl, $4AA8
    ld b, $04
    rst $10
    ld a, $7F
    ld [$C527], a
    ld hl, Func_00C_4001
    ld b, $69
    rst $10
    ld a, [$D780]
    inc a
    ld [$D780], a
    ret

Func_00C_4360:: ; heuristic: target of a pointer table; C0
    ld hl, $C364
    ld de, $C198
    ld bc, $0104
    call Func_00C_52D0
    ld a, [$C525]
    and a, a
    jr z, Jump_00C_437E
    ld hl, $D1CC
    ld de, $D000
    ld bc, $0104
    call Func_00C_52D9

Jump_00C_437E::
    call Func_00C_5156
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    call Func_00C_5156
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call Func_00C_51F5
    ld a, [$D799]
    ldh [$FFB9], a
    ld a, [$D79A]
    ldh [$FFBA], a
    xor a, a
    ldh [$FF8D], a
    ld a, [$D780]
    inc a
    ld [$D780], a
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
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_00C_43CE:: ; heuristic: target of a pointer table; C0
    ld hl, $2940
    ld de, $8D00
    call Func_00C_5145
    call Func_00C_4424
    call Func_00C_4424
    call Func_00C_4424
    ld hl, $2940
    call Func_00C_5145
    ld hl, $2940
    call Func_00C_5145
    ld hl, Data_00C_62AD
    ld b, $1D
    rst $10
    ld hl, Data_00C_7A64
    ld b, $16
    rst $10
    xor a, a
    ld [$D7F0], a
    ld hl, $D780
    ld bc, $0020

Func_00C_4402:: ; heuristic: target of a pointer table; C0
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Func_00C_4402
    ld hl, $C130
    ld b, $10

Jump_00C_440E::
    ld a, $F0
    ld [hl+], a
    dec b
    jr nz, Jump_00C_440E
    ld hl, $470B
    ld b, $02
    rst $10
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_00C_4424::
    ld hl, $2940
    call Func_00C_5145
    ld hl, $2940
    call Func_00C_5145
    ld hl, $2940
    call Func_00C_5145
    ld hl, $2940
    call Func_00C_5145
    ret

Func_00C_443D:: ; heuristic: target of a pointer table; C0
    call Func_00C_5283
    db $FA

Func_00C_4441:: ; heuristic: target of a pointer table; C0
    add a, b
    rst $10
    inc a
    ld [$D780], a
    ret

Func_00C_4448:: ; heuristic: target of a pointer table; C0
    ld de, Data_00C_574E
    ld hl, $C36C
    ld bc, $0C0D
    call Func_00C_51BB
    call Func_00C_52EC
    ld de, Data_00C_5944
    add a, e
    ld e, a
    jr nc, Jump_00C_445F
    inc d

Jump_00C_445F::
    ld a, [de]
    add a, $E1
    ld [$C465], a
    ld a, [$D78A]
    ld hl, Data_00C_590A
    ld b, $BB
    call Func_00C_525B
    call Func_00C_5156
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    ld a, [$D78A]
    ld hl, Data_00C_590A
    ld b, $C3
    call Func_00C_525B
    call Func_00C_4EC7
    ld a, [$D780]
    inc a
    ld [$D780], a
    ret

Func_00C_4492:: ; heuristic: target of a pointer table; C0
    call Func_00C_501F
    ld a, [$D780]
    inc a
    ld [$D780], a
    ret

Func_00C_449D:: ; heuristic: target of a pointer table; C0
    ld a, [$C563]
    bit 4, a
    jr nz, Func_00C_44C3
    bit 5, a
    jr nz, Jump_00C_451C
    bit 6, a
    jp nz, Jump_00C_4533
    bit 7, a
    jp nz, Jump_00C_4550
    ld a, [$C562]
    bit 0, a
    jp nz, Jump_00C_4563
    bit 1, a
    jp nz, Jump_00C_459F
    call Func_00C_45BC
    ret

Func_00C_44C3:: ; heuristic: target of a pointer table; C0
    call Func_00C_52EC
    ld de, Data_00C_5944
    add a, e
    ld e, a
    jr nc, Jump_00C_44CE
    inc d

Jump_00C_44CE::
    ld a, [de]
    ld b, a
    ld a, [$D78B]
    cp a, b
    jr c, Jump_00C_44D9
    xor a, a
    jr Jump_00C_44DA

Jump_00C_44D9::
    inc a

Jump_00C_44DA::
    ld [$D78B], a
    push af
    call Func_00C_52EC
    ld de, Data_00C_5944
    add a, e
    ld e, a
    jr nc, Jump_00C_44E9
    inc d

Jump_00C_44E9::
    ld a, [de]
    ld b, a
    pop af
    cp a, b
    jr c, Jump_00C_450B
    call Func_00C_506C
    ld b, a
    ld a, [$D78A]
    cp a, b
    jr c, Jump_00C_450B
    ld a, b
    ld [$D78A], a
    ld a, [$D780]
    db $D6

Func_00C_4501:: ; heuristic: target of a pointer table; C0
    inc bc

Func_00C_4502:: ; heuristic: target of a pointer table; C0
    ld [$D780], a
    ld a, $69
    call Func_000_1278
    ret

Jump_00C_450B::
    call Func_00C_45D6
    ld a, [$D780]
    sub a, $03
    ld [$D780], a
    ld a, $69
    call Func_000_1278
    ret

Jump_00C_451C::
    ld a, [$D78B]
    and a, a
    jr nz, Jump_00C_4530
    call Func_00C_52EC
    ld de, Data_00C_5944
    add a, e
    ld e, a
    jr nc, Jump_00C_452D
    inc d

Jump_00C_452D::
    ld a, [de]
    jr Jump_00C_44DA

Jump_00C_4530::
    dec a
    jr Jump_00C_44DA

Jump_00C_4533::
    call Func_00C_45DA
    call Func_00C_506C
    ld b, a
    ld a, [$D78A]
    and a, a
    jr nz, Jump_00C_4543
    ld a, b
    jr Jump_00C_4544

Jump_00C_4543::
    dec a

Jump_00C_4544::
    ld [$D78A], a
    call Func_00C_45D6
    ld a, $69
    call Func_000_1278
    ret

Jump_00C_4550::
    call Func_00C_45DA
    call Func_00C_506C
    ld b, a
    ld a, [$D78A]
    cp a, b
    jr c, Jump_00C_4560
    xor a, a
    jr Jump_00C_4544

Jump_00C_4560::
    inc a
    jr Jump_00C_4544

Jump_00C_4563::
    call Func_00C_52EC
    add a, a
    ld de, Data_00C_5916
    add a, e
    ld e, a
    jr nc, Jump_00C_456F
    inc d

Jump_00C_456F::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    push hl
    call Func_00C_52FB
    pop hl
    add a, l
    ld l, a
    jr nc, Jump_00C_457E
    inc h

Jump_00C_457E::
    call Func_00C_530A
    and a, a
    jr z, Jump_00C_459B
    ld a, $69
    call Func_000_1278
    ld a, [$D780]
    add a, $03
    ld [$D780], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_00C_459B::
    call Func_00C_45D6
    ret

Jump_00C_459F::
    ld a, [$D780]
    inc a
    ld [$D780], a
    ld a, $01
    ld [$D7FA], a
    xor a, a
    ld [$D78A], a
    ld [$D78B], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_00C_45BC::
    ld a, [$C564]
    cp a, $14
    jr c, Func_00C_45D6
    ld a, [$D789]
    inc a
    ld [$D789], a
    cp a, $10
    jr c, Func_00C_45D6
    cp a, $18
    jr c, Func_00C_45DA
    xor a, a
    ld [$D789], a

Func_00C_45D6::
    ld b, $BB
    jr Jump_00C_45E0

Func_00C_45DA::
    ld b, $C3
    jr Jump_00C_45E0
    db $06, $BC

Jump_00C_45E0::
    ld a, [$D78A]
    add a, a
    ld hl, Data_00C_45FD
    add a, l
    ld l, a
    jr nc, Jump_00C_45EC
    inc h

Jump_00C_45EC::
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call Func_00C_5156
    pop de
    add hl, de
    di
    call Func_000_120A
    ld a, b
    ld [hl], a
    ei
    ret

Data_00C_45FD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $29, $00, $69, $00, $A9, $00, $E9, $00, $29, $01, $69, $01

Func_00C_4609:: ; heuristic: target of a pointer table; C0
    ld de, Data_00C_57EA
    ld hl, $C36C
    ld bc, $0C0D
    call Func_00C_51BB
    ld a, $01
    ld [$D7F1], a
    call Func_00C_5085
    call Func_00C_5156
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    ld a, [$D780]
    inc a
    ld [$D780], a
    ld hl, $8800
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $1202
    ld a, l
    ld [$C52F], a
    ld a, h
    db $EA, $30

Func_00C_4645:: ; heuristic: target of a pointer table; C0
    push bc
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_00C_4650:: ; heuristic: target of a pointer table; C0
    ld a, [$D786]
    ld hl, Data_00C_58FE
    ld b, $C3
    call Func_00C_525B
    call Func_00C_5156
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    ld a, $05
    ld [$D780], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_00C_4676:: ; heuristic: target of a pointer table; C0
    call Func_00C_5177
    call Func_00C_511B
    ld a, [$D780]
    inc a
    ld [$D780], a
    ret
    db $FA, $81, $D7, $C7
    dw Func_00C_46A4
    dw Func_00C_4778
    dw Func_00C_490A
    dw Func_00C_49B5
    dw Func_00C_49DA
    dw Func_00C_4AA6
    dw Func_00C_4B12
    dw Func_00C_4B5C
    dw Func_00C_4B95
    dw Func_00C_4CE2
    dw Func_00C_4CFB
    dw Func_00C_4D6B
    dw Func_00C_4D7C
    dw Func_00C_4DD6

Func_00C_46A4:: ; heuristic: target of a pointer table; C0
    call Func_00C_529D
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
    call Func_000_290E
    ld hl, Data_00C_4718
    ld de, $9610
    call Func_00C_5145
    call Func_00C_5145
    call Func_00C_5145
    call Func_00C_5145
    call Func_00C_5145
    call Func_00C_5145
    ld de, Data_01F_41D0
    ld hl, $97C0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4170
    ld hl, $97D0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4160
    ld hl, $97E0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4110
    ld hl, $97F0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$D782], a
    ret

Data_00C_4718:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $030718, $60

Func_00C_4778:: ; heuristic: target of a pointer table; C0
    ld a, [$D782]
    and a, a
    jr nz, Jump_00C_47E9
    ld hl, $8A20
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $1202
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    call Func_000_290E
    ld de, Data_00C_5C14
    ld hl, $8800
    ld b, $F1
    call Func_000_0CF5
    ld de, Data_00C_5D44
    ld hl, $C364
    ld b, $F1
    call Func_000_0CF5
    ld de, Data_00C_5D9C
    ld hl, $C300
    ld b, $F1
    call Func_000_0CF5
    ld a, [$C525]
    and a, a
    jr z, Jump_00C_47E9
    ld a, $02
    ldh [$FF70], a
    ld de, Data_00C_5DBC
    ld hl, $D1CC
    ld b, $F1
    call Func_000_0CF5
    ld de, Data_00C_5DEE
    ld hl, $D168
    ld b, $F1
    call Func_000_0CF5
    xor a, a
    ldh [$FF70], a
    ld hl, Data_00C_5C05
    ld b, $F1
    rst $10
    ld a, $7F
    ld [$C526], a
    call Func_000_0829

Jump_00C_47E9::
    ld de, Data_00C_48AB
    ld hl, $C381
    ld bc, $0A01
    call Func_00C_51BB
    ld de, Data_00C_48B5
    ld hl, $C3BD
    ld bc, $0A01
    call Func_00C_51BB

Func_00C_4801:: ; heuristic: target of a pointer table; C0
    ld de, Data_00C_48BF
    ld hl, $C3E5
    ld bc, $0A01
    call Func_00C_51BB
    ld de, $48C9
    ld hl, $C40D
    ld bc, $0901
    call Func_00C_51BB
    ld de, $48D2
    ld hl, $C435
    ld bc, $0901
    call Func_00C_51BB
    ld de, $48DB
    ld hl, $C45D
    ld bc, $0901
    call Func_00C_51BB
    ld de, Data_00C_48E4
    ld hl, $C315
    ld bc, $1201
    call Func_00C_51BB
    ld de, Data_00C_48F6
    ld hl, $C33D
    ld bc, $1201
    call Func_00C_51BB
    call Func_00C_534A
    ld de, $D79C
    ld hl, $C408
    ld bc, $0201
    call Func_00C_51BB
    call Func_00C_54F3
    ld de, $D79C
    ld hl, $C430
    ld bc, $0401
    call Func_00C_51BB
    ld a, [$C525]
    and a, a
    jr z, Jump_00C_4883
    ld a, $02
    ldh [$FF70], a
    ld hl, $D298
    ld a, $02
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    xor a, a
    ldh [$FF70], a

Jump_00C_4883::
    call Func_00C_5156
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    call Func_00C_5156
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call Func_00C_51F5
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$D782], a
    ret

Data_00C_48AB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2F, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $2E

Data_00C_48B5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $42, $30, $31, $32, $33, $34, $35, $36, $37, $38

Data_00C_48BF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $43, $39, $3A, $3B, $3C, $3D, $3E
    dw Func_00C_403F
    dw Func_00C_4441
    dw Func_00C_4645
    dw $4847
    dw Func_00C_4A49
    db $4B
    dw $4D4C
    dw Func_00C_4F4E
    dw Func_00C_5150
    dw Func_00C_5352
    dw Func_00C_5554
    dw Func_00C_5756
    db $58, $59, $5A, $5B, $5C, $5D, $5E

Data_00C_48E4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A2, $A3, $A4, $A5, $A6, $A7, $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF, $B0, $B1
    db $B2, $B3

Data_00C_48F6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B4, $B5, $B6, $B7, $B8, $B9, $BA, $BB, $BC, $BD, $BE, $BF, $C0, $C1, $C2, $C3
    db $C4, $C5, $7E, $7F

Func_00C_490A:: ; heuristic: target of a pointer table; C0
    ld a, [$D782]
    and a, a
    jp nz, Jump_00C_4957
    call Func_00C_5156
    ld de, $0021
    add hl, de
    ld a, h
    ld [$D7F5], a
    ld a, l
    ld [$D7F6], a
    ld de, Data_00C_651B
    ld a, d
    ld [$D7F1], a
    ld a, e
    ld [$D7F2], a
    ld a, $06
    ld [$D7F3], a
    ld a, $06
    ld [$D7F4], a
    ld a, $00
    ld [$D7F7], a
    ld hl, Data_00C_5D2A
    ld b, $1F
    rst $10
    call Func_00C_5050
    ld e, l
    ld d, h
    push de
    db $21, $20

Func_00C_4948:: ; heuristic: target of a pointer table; C0
    sub a, b
    ld c, $04
    call Func_000_1FE3
    pop de
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_00C_4957::
    call Func_00C_5050
    ld a, [$C525]
    and a, a
    jr z, Jump_00C_497A
    ld e, l
    ld d, h
    push de
    ld a, $7F
    ld [$C526], a
    call Func_000_0829
    ld a, $04
    ldh [$FFC6], a
    call Func_00C_5156
    ld de, $0021
    add hl, de
    pop de
    call Func_000_2090

Jump_00C_497A::
    call Func_00C_5156
    ld de, $0021
    add hl, de
    ld a, h
    ld [$D7F5], a
    ld a, l
    ld [$D7F6], a
    ld de, Data_00C_64D3
    ld a, d
    ld [$D7F1], a
    ld a, e
    ld [$D7F2], a
    ld a, $06
    ld [$D7F3], a
    ld a, $06
    ld [$D7F4], a
    ld a, $01
    ld [$D7F7], a
    ld hl, Data_00C_5D2A
    ld b, $1F
    rst $10
    xor a, a
    ld [$D782], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_00C_49B5:: ; heuristic: target of a pointer table; C0
    call Func_00C_5050
    ld a, l
    ld [$D7F1], a
    ld a, h
    ld [$D7F2], a
    xor a, a
    ld [$D7F3], a
    ld [$D7F4], a
    ld a, $80
    ld [$D7F5], a
    ld hl, $6973
    ld b, $1D
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_00C_49DA:: ; heuristic: target of a pointer table; C0
    call Func_00C_4FC2
    call Func_00C_5050
    ld a, h
    add a, $02
    ld [$C528], a
    ld a, l
    ld [$C529], a
    ld hl, $9260
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0901
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld hl, $402B
    ld b, $08
    rst $10
    call Func_00C_52EC
    and a, $0F
    ld [$D09D], a
    ld a, $2F
    ld [$D09E], a
    ld hl, Data_00C_7A48
    ld b, $16
    rst $10
    call Func_00C_52EC
    ld [$C529], a
    ld a, $02
    ld [$C528], a
    ld hl, $9670
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0701
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld hl, $400F
    ld b, $0B
    rst $10
    call Func_00C_5050
    ld a, l
    ld [$D7F1], a
    ld a, h
    db $EA

Func_00C_4A49:: ; heuristic: target of a pointer table; C0
    ldh a, [c]
    rst $10
    ld hl, Data_00C_5C2B
    ld b, $0E
    rst $10
    ld hl, $5181
    ld b, $F2
    rst $10
    ld a, $04
    ld [$C528], a
    ld hl, $D7F5
    ld c, $00

Jump_00C_4A61::
    push hl
    push bc
    ld a, [hl]
    ld [$C529], a
    ld a, c
    add a, a
    ld de, Data_00C_4AA0
    add a, e
    ld e, a
    jr nc, Jump_00C_4A71
    inc d

Jump_00C_4A71::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0901
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld hl, $402B
    ld b, $08
    rst $10
    pop bc
    pop hl
    inc hl
    inc c
    ld a, c
    cp a, $03
    jr c, Jump_00C_4A61
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Data_00C_4AA0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $40, $94, $D0, $94, $60, $95

Func_00C_4AA6:: ; heuristic: target of a pointer table; C0
    call Func_00C_4FC2
    call Func_00C_5050
    call Func_00C_530A
    cp a, $FF
    jr z, Jump_00C_4B0A
    ld de, Data_01F_4990
    ld hl, $9420
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4990
    ld hl, $9430
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    xor a, a
    ld [$C528], a
    ld [$C529], a
    ld hl, $9300
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0901
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld hl, $400F
    ld b, $0B
    rst $10
    ld hl, $9390
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $400F
    ld b, $0B
    rst $10

Func_00C_4B01:: ; heuristic: target of a pointer table; C0
    ld a, [$D781]
    inc a
    inc a
    ld [$D781], a
    ret

Jump_00C_4B0A::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_00C_4B12:: ; heuristic: target of a pointer table; C0
    call Func_00C_4FC2
    call Func_00C_5050
    push hl
    sla l
    rl h
    ld de, Data_00C_599F
    add hl, de
    ld a, $42
    call Func_00C_4E75
    pop hl
    push hl
    sla l
    rl h
    ld de, Data_00C_5F9F
    add hl, de
    ld a, $43
    call Func_00C_4E75
    pop hl
    push hl
    sla l
    rl h
    ld de, Data_00C_599F
    add hl, de
    ld de, $9300
    call Func_00C_4E16
    pop hl
    sla l
    rl h

Func_00C_4B4A:: ; heuristic: target of a pointer table; C0
    ld de, Data_00C_5F9F
    add hl, de
    ld de, $9390
    call Func_00C_4E16
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_00C_4B5C:: ; heuristic: target of a pointer table; C0
    call Func_00C_4FC2
    call Func_00C_5050
    ld a, $10
    add a, l
    ld l, a
    jr nc, Jump_00C_4B69
    inc h

Jump_00C_4B69::
    ld a, h
    ld [$C528], a
    ld a, l
    ld [$C529], a
    ld hl, $8A20
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $1202
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld hl, $400F
    ld b, $0B
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_00C_4B95:: ; heuristic: target of a pointer table; C0
    call Func_00C_4FC2
    ld a, [$D787]
    add a, a
    ld b, a
    add a, a
    add a, b
    ld b, a
    ld a, [$D786]
    add a, b
    ld hl, $D78E
    add a, l
    ld l, a
    jr nc, Jump_00C_4BAC
    inc h

Jump_00C_4BAC::
    ld a, [hl]
    cp a, $01
    jr z, Jump_00C_4BBD
    ld a, [$C563]
    bit 4, a
    jr nz, Jump_00C_4BCB
    bit 5, a
    jp nz, Jump_00C_4C4F

Jump_00C_4BBD::
    ld a, [$C562]
    bit 0, a
    jp nz, Jump_00C_4CD5
    bit 1, a
    jp nz, Jump_00C_4CDA
    ret

Jump_00C_4BCB::
    ld a, [$D78A]
    cp a, $05
    jr c, Jump_00C_4BF8
    xor a, a
    ld [$D78A], a
    call Func_00C_52EC
    ld de, Data_00C_5944
    add a, e
    ld e, a
    jr nc, Jump_00C_4BE1
    inc d

Jump_00C_4BE1::
    ld a, [de]
    ld b, a
    ld a, [$D78B]
    cp a, b
    jr c, Jump_00C_4BF2

Jump_00C_4BE9::
    xor a, a
    ld [$D78A], a
    ld [$D78B], a
    jr Jump_00C_4BFC

Jump_00C_4BF2::
    inc a
    ld [$D78B], a
    jr Jump_00C_4BFC

Jump_00C_4BF8::
    inc a
    ld [$D78A], a

Jump_00C_4BFC::
    call Func_00C_5050
    push hl
    call Func_00C_52EC
    add a, a
    ld hl, Data_00C_592E
    add a, l
    ld l, a
    jr nc, Jump_00C_4C0C
    inc h

Jump_00C_4C0C::
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    ld a, h
    cp a, d
    jr c, Jump_00C_4C1C
    jr nz, Jump_00C_4BE9
    ld a, l
    cp a, e
    jr c, Jump_00C_4C1C
    jr Jump_00C_4BE9

Jump_00C_4C1C::
    call Func_00C_5050
    call Func_00C_530A
    and a, a
    jr z, Jump_00C_4BCB
    ld a, $69
    call Func_000_1278
    call Func_00C_529D
    ld hl, $8A20
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $1202
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    call Func_000_290E
    ld a, $01
    ld [$D781], a
    ld [$D782], a
    ret

Jump_00C_4C4F::
    ld a, [$D78A]
    and a, a
    jr nz, Jump_00C_4C7E
    ld a, [$D78B]
    and a, a
    jr nz, Jump_00C_4C72

Jump_00C_4C5B::
    call Func_00C_52EC
    ld de, Data_00C_5944
    add a, e
    ld e, a
    jr nc, Jump_00C_4C66
    inc d

Jump_00C_4C66::
    ld a, [de]
    ld [$D78B], a
    call Func_00C_506C
    ld [$D78A], a
    jr Jump_00C_4C82

Jump_00C_4C72::
    dec a
    ld [$D78B], a
    call Func_00C_506C
    ld [$D78A], a
    jr Jump_00C_4C82

Jump_00C_4C7E::
    dec a
    ld [$D78A], a

Jump_00C_4C82::
    call Func_00C_5050
    push hl
    call Func_00C_52EC
    add a, a
    ld hl, Data_00C_592E
    add a, l
    ld l, a
    jr nc, Jump_00C_4C92
    inc h

Jump_00C_4C92::
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    ld a, h
    cp a, d
    jr c, Jump_00C_4CA2
    jr nz, Jump_00C_4C5B
    ld a, l
    cp a, e
    jr c, Jump_00C_4CA2
    jr nz, Jump_00C_4C5B

Jump_00C_4CA2::
    call Func_00C_5050
    call Func_00C_530A
    and a, a
    jr z, Jump_00C_4C4F
    ld a, $69
    call Func_000_1278
    call Func_00C_529D
    ld hl, $8A20
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $1202
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    call Func_000_290E
    ld a, $01
    ld [$D781], a
    ld [$D782], a
    ret

Jump_00C_4CD5::
    ld a, $69
    call Func_000_1278

Jump_00C_4CDA::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_00C_4CE2:: ; heuristic: target of a pointer table; C0
    call Func_00C_5177
    ld b, $46
    ld de, Func_00C_4001
    ld hl, $8800
    call Func_000_0CF5
    call Func_00C_511B
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_00C_4CFB:: ; heuristic: target of a pointer table; C0
    ld de, Data_00C_56D9
    ld hl, $C364
    db $01

Func_00C_4D02:: ; heuristic: target of a pointer table; C0
    dec c
    add hl, bc
    call Func_00C_51BB
    ld a, [$D787]
    and a, a
    jr z, Jump_00C_4D12
    ld a, $C3
    ld [$C445], a

Jump_00C_4D12::
    ld a, [$D786]
    ld hl, Data_00C_58FE
    ld b, $BC
    call Func_00C_525B
    ld a, [$D787]
    add a, $E1
    ld [$C456], a
    ld de, Data_00C_574E
    ld hl, $C36C
    ld bc, $0C0D
    call Func_00C_51BB
    ld a, [$D78A]
    ld b, $BC
    ld hl, Data_00C_590A
    call Func_00C_525B
    call Func_00C_5269
    call Func_00C_5283
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
    call Func_000_290E
    ld a, $7F
    ld [$C526], a
    call Func_000_0829
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_00C_4D6B:: ; heuristic: target of a pointer table; C0
    call Func_00C_5543
    call Func_00C_4F74
    call Func_00C_4EC7
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_00C_4D7C:: ; heuristic: target of a pointer table; C0
    ld a, $01
    ld [$D7F1], a
    call Func_00C_5085
    call Func_00C_5156
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    ld de, Data_00C_589A
    ld hl, $C300
    ld bc, $1405
    call Func_00C_51BB
    call Func_00C_5156
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call Func_00C_51F5
    call Func_00C_501F
    ld a, [$D781]
    inc a
    ld [$D781], a
    ld hl, $8800
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    db $21, $02

Func_00C_4DC3:: ; heuristic: target of a pointer table; C0
    ld [de], a
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_00C_4DD6:: ; heuristic: target of a pointer table; C0
    ld a, [$D78A]
    ld b, $C3
    ld hl, Data_00C_590A
    call Func_00C_525B
    call Func_00C_5156
    ld bc, $140C
    ld de, $01CC
    call Func_00C_51F5
    xor a, a
    ld [$D781], a
    ld a, $0C
    ld [$D780], a
    ld hl, $8800
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    db $21

Func_00C_4E02:: ; heuristic: target of a pointer table; C0
    ld [bc], a
    ld [de], a
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_00C_4E16::
    push de
    inc hl
    ld a, [hl-]
    cp a, $FE
    jr z, Jump_00C_4E42
    ld a, [hl+]
    ld [$C529], a
    ld a, [hl]
    add a, $02
    ld [$C528], a
    pop de
    ld a, e
    ld [$C52D], a
    ld a, d
    ld [$C52E], a
    ld hl, $0901
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld hl, $402B
    ld b, $08
    rst $10
    ret

Jump_00C_4E42::
    ld a, [hl]
    cp a, $FE
    jr z, Jump_00C_4E53
    and a, $0F
    ld [$C529], a
    ld a, $02
    ld [$C528], a
    jr Jump_00C_4E5A

Jump_00C_4E53::
    xor a, a
    ld [$C528], a
    ld [$C529], a

Jump_00C_4E5A::
    pop de
    ld a, e
    ld [$C52D], a
    ld a, d
    ld [$C52E], a
    ld hl, $0901
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld hl, $400F
    ld b, $0B
    rst $10
    ret

Func_00C_4E75::
    push af
    inc hl
    ld a, [hl-]
    cp a, $FE
    jr z, Jump_00C_4E8F
    ld a, [hl+]
    ld [$D7F6], a
    ld a, [hl]
    ld [$D7F7], a
    ld hl, Data_00C_615A
    ld b, $0E
    rst $10
    ld a, [$D7F5]
    jr Jump_00C_4E94

Jump_00C_4E8F::
    ld a, [hl]
    cp a, $FE
    jr z, Jump_00C_4EA4

Jump_00C_4E94::
    and a, $0F
    ld [$D09D], a
    pop af
    ld [$D09E], a
    ld hl, Data_00C_7A48
    ld b, $16
    rst $10
    ret

Jump_00C_4EA4::
    pop af
    ld l, a
    ld h, $00
    sla l
    rl h
    sla l
    rl h
    sla l
    rl h
    sla l
    rl h
    ld de, $9000
    add hl, de
    ld de, Data_01F_4990
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ret

Func_00C_4EC7::
    call Func_00C_52EC
    add a, a
    ld de, Data_00C_5916
    add a, e
    ld e, a
    jr nc, Jump_00C_4ED3
    inc d

Jump_00C_4ED3::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [$D78B]
    add a, a
    ld b, a
    add a, a
    add a, b
    add a, l
    ld l, a
    jr nc, Jump_00C_4EE4
    inc h

Jump_00C_4EE4::
    ld c, $00

Jump_00C_4EE6::
    push hl
    push bc
    call Func_00C_530A
    and a, a
    jr z, Jump_00C_4F26
    pop bc
    pop hl
    push hl
    push bc
    ld a, h
    add a, $02
    ld [$C528], a
    ld a, l
    ld [$C529], a
    ld a, c
    add a, a
    ld de, Data_00C_4F68

Func_00C_4F01:: ; heuristic: target of a pointer table; C0
    add a, e

Func_00C_4F02:: ; heuristic: target of a pointer table; C0
    ld e, a
    jr nc, Jump_00C_4F06
    inc d

Jump_00C_4F06::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0901
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld hl, $402B
    ld b, $08
    rst $10
    jr Jump_00C_4F57

Jump_00C_4F26::
    pop bc
    push bc
    xor a, a
    ld [$C528], a
    ld [$C529], a
    ld a, c
    add a, a
    ld de, Data_00C_4F68
    add a, e
    ld e, a
    jr nc, Jump_00C_4F39
    inc d

Jump_00C_4F39::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0901
    ld a, l
    ld [$C52F], a
    ld a, h

Func_00C_4F4E:: ; heuristic: target of a pointer table; C0
    ld [$C530], a
    ld hl, $400F
    ld b, $0B
    rst $10

Jump_00C_4F57::
    pop bc
    pop hl
    inc hl
    push hl
    inc c
    call Func_00C_506C
    inc a
    ld b, a
    pop hl
    ld a, c
    cp a, b
    jp c, Jump_00C_4EE6
    ret

Data_00C_4F68:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $92, $90, $92, $20, $93, $B0, $93, $40, $94, $D0, $94

Func_00C_4F74::
    ld a, [$D787]
    add a, a
    ld b, a
    add a, a
    add a, b
    ld de, Data_00C_4FAA
    add a, e
    ld e, a
    jr nc, Jump_00C_4F83
    inc d

Jump_00C_4F83::
    ld c, $00

Jump_00C_4F85::
    ld a, [de]
    cp a, $FF
    jr z, Jump_00C_4FA2
    push de
    push bc
    ld [$D09D], a
    cp a, $06
    jr c, Jump_00C_4F95
    sub a, $06

Jump_00C_4F95::
    inc a
    inc a
    ld [$D09E], a
    ld hl, Data_00C_7A48
    ld b, $16
    rst $10
    pop bc
    pop de

Jump_00C_4FA2::
    inc de
    inc c
    ld a, c
    cp a, $06
    jr c, Jump_00C_4F85
    ret

Data_00C_4FAA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $FF, $20, $90, $70, $90
    db $C0, $90, $10, $91, $60, $91, $B0, $91

Func_00C_4FC2::
    call Func_00C_5050
    ld a, l
    ld [$D7F1], a
    ld a, h
    ld [$D7F2], a
    xor a, a
    ld [$D7F3], a
    ld a, $10
    ld [$D7F4], a
    ld a, $6C
    ld [$D7F5], a
    xor a, a
    ld [$D7F6], a
    ld c, $01
    xor a, a
    ldh [$FFAE], a
    ld hl, $6A36
    ld b, $1D
    rst $10
    ld a, $24
    ld [$D7F4], a
    ld a, $6C
    ld [$D7F5], a
    xor a, a
    ld [$D7F6], a
    ld c, $01
    ld a, $04
    ldh [$FFAE], a
    ld hl, $6A36
    db $06

Func_00C_5002:: ; heuristic: target of a pointer table; C0
    dec e
    rst $10
    ld a, $38
    ld [$D7F4], a
    ld a, $6C
    ld [$D7F5], a
    xor a, a
    ld [$D7F6], a
    ld c, $01
    ld a, $02
    ldh [$FFAE], a
    ld hl, $6A36
    ld b, $1D
    rst $10
    ret

Func_00C_501F::
    call Func_00C_5156
    ld de, $018F
    add hl, de
    push hl
    ld a, [$D78B]
    add a, $E1
    ld b, a
    di
    call Func_000_120A
    ld a, b
    ld [hl+], a
    ei
    pop hl
    inc hl
    inc hl
    push hl
    call Func_00C_52EC
    ld de, Data_00C_5944
    add a, e
    ld e, a
    jr nc, Jump_00C_5043
    inc d

Jump_00C_5043::
    ld a, [de]
    add a, $E1
    ld b, a
    pop hl
    di
    call Func_000_120A
    ld a, b
    ld [hl], a
    ei
    ret

Func_00C_5050::
    call Func_00C_52EC
    add a, a
    ld de, Data_00C_5916
    add a, e
    ld e, a
    jr nc, Jump_00C_505C
    inc d

Jump_00C_505C::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    push hl
    call Func_00C_52FB
    pop hl
    add a, l
    ld l, a
    jr nc, Jump_00C_506B
    inc h

Jump_00C_506B::
    ret

Func_00C_506C::
    call Func_00C_52EC
    add a, a
    ld hl, Data_00C_594F
    add a, l
    ld l, a
    jr nc, Jump_00C_5078
    inc h

Jump_00C_5078::
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, [$D78B]
    add a, e
    ld e, a
    jr nc, Jump_00C_5083
    inc d

Jump_00C_5083::
    ld a, [de]
    ret

Func_00C_5085::
    ld a, [$D787]
    add a, a
    ld b, a
    add a, a
    add a, b
    ld hl, $D78E
    add a, l
    ld l, a
    jr nc, Jump_00C_5094
    inc h

Jump_00C_5094::
    ld a, [$D787]
    and a, a
    jr nz, Jump_00C_509E
    ld b, $06
    jr Jump_00C_50A0

Jump_00C_509E::
    ld b, $05

Jump_00C_50A0::
    ld c, $00

Jump_00C_50A2::
    push hl
    push bc
    ld a, [hl]
    ld l, a
    ld h, $00
    call Func_000_16F5
    ld a, [$C8C1]
    and a, a
    jr nz, Jump_00C_50B6
    add a, $E3
    ld [$C8C1], a

Jump_00C_50B6::
    call Func_00C_5156
    pop bc
    push bc
    ld a, c
    add a, a
    push hl
    push af
    ld a, [$D7F1]
    and a, a
    jr z, Jump_00C_50D6
    ld hl, Data_00C_510F
    pop af
    add a, l
    ld l, a
    jr nc, Jump_00C_50CE
    inc h

Jump_00C_50CE::
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    ld l, e
    ld h, d
    jr Jump_00C_50E4

Jump_00C_50D6::
    ld hl, Data_00C_5103
    pop af
    add a, l
    ld l, a
    jr nc, Jump_00C_50DF
    inc h

Jump_00C_50DF::
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    add hl, de

Jump_00C_50E4::
    di
    call Func_000_120A
    ld a, [$C8C1]
    add a, $E0
    ld [hl+], a
    ei
    di
    call Func_000_120A
    ld a, [$C8C2]
    add a, $E0
    ld [hl], a
    ei
    pop bc
    pop hl
    inc hl
    inc c
    ld a, c
    cp a, b
    jr c, Jump_00C_50A2
    ret

Data_00C_5103:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $26, $00, $66, $00, $A6, $00, $E6, $00, $26, $01, $66, $01

Data_00C_510F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $7E, $C3, $A6, $C3, $CE, $C3, $F6, $C3, $1E, $C4, $46, $C4

Func_00C_511B::
    ld hl, $C364
    ld bc, $0104

Jump_00C_5121::
    ld a, $C3
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_00C_5121
    ld a, [$C525]
    and a, a
    jr z, Jump_00C_5144
    ld a, $02
    ldh [$FF70], a
    ld hl, $D1CC
    ld bc, $0104

Jump_00C_5139::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_00C_5139
    ld a, $00
    ldh [$FF70], a

Jump_00C_5144::
    ret

Func_00C_5145::
    ld c, $10

Jump_00C_5147::
    di

Jump_00C_5148::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_00C_5148
    ld a, [hl+]
    ld [de], a

Func_00C_5150:: ; heuristic: target of a pointer table; C0
    inc de
    ei
    dec c
    jr nz, Jump_00C_5147
    ret

Func_00C_5156::
    ld hl, $9800
    ldh a, [$FFA5]
    and a, $F8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ldh a, [$FFA1]
    srl a
    srl a
    srl a
    add a, l
    ld l, a
    jr nc, Jump_00C_5176
    inc h

Jump_00C_5176::
    ret

Func_00C_5177::
    ld hl, Data_00C_51AB
    ld de, $8C30
    call Func_00C_5145
    call Func_00C_5156
    ld a, h
    ld [$D7F5], a
    ld a, l
    ld [$D7F6], a
    ld de, Data_00C_5E12
    ld a, d
    ld [$D7F1], a
    ld a, e
    ld [$D7F2], a
    ld a, $20
    ld [$D7F3], a
    ld a, $20
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    ld hl, Data_00C_5D9A
    ld b, $1F
    rst $10
    ret

Data_00C_51AB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00

Func_00C_51BB::
    push hl
    push bc

Jump_00C_51BD::
    push bc
    push hl

Jump_00C_51BF::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_00C_51BF
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_00C_51BD
    pop bc
    pop hl
    ld a, [$C525]
    and a, a
    ret z
    ld a, l
    add a, $68
    ld l, a
    ld a, h
    adc a, $0E
    ld h, a
    ld a, $02
    ldh [$FF70], a

Jump_00C_51E1::
    push bc
    push hl

Jump_00C_51E3::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_00C_51E3
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_00C_51E1
    xor a, a
    ldh [$FF70], a
    ret

Func_00C_51F5::
    push de
    push bc
    push hl
    ld hl, $C198
    add hl, de
    ld e, l
    ld d, h
    pop hl
    push hl
    call Func_000_18A5
    pop hl
    push hl
    ld a, l
    add a, $C1
    ld [$C554], a
    ld a, h
    adc a, $01
    ld [$C555], a
    ld a, [$C529]
    cp a, $18
    jr z, Jump_00C_5226
    cp a, $12
    jr z, Jump_00C_5226
    ld a, $C1
    ld [$C554], a
    ld a, $99
    ld [$C555], a

Jump_00C_5226::
    pop hl
    pop bc
    pop de
    ld a, [$C525]
    and a, a
    ret z
    ld a, $01
    ldh [$FF4F], a
    ld a, $02
    ldh [$FF70], a
    push hl
    ld hl, $D000
    add hl, de
    ld e, l
    ld d, h
    pop hl
    call Func_000_18A5
    xor a, a
    ldh [$FF70], a
    ldh [$FF4F], a
    ret

Func_00C_5247::
    ld a, c
    ld b, a
    ld c, $00

Jump_00C_524B::
    ld a, c
    push bc
    ld b, $C3
    push hl
    call Func_00C_525B
    pop hl
    pop bc
    inc c
    ld a, c
    cp a, b
    jr c, Jump_00C_524B
    ret

Func_00C_525B::
    push bc
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_00C_5262
    inc h

Jump_00C_5262::
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop bc
    ld a, b
    ld [de], a
    ret

Func_00C_5269::
    ld hl, $9020
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $1702
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    call Func_000_290E
    ret

Func_00C_5283::
    ld hl, $9200
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $5301
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    call Func_000_290E
    ret

Func_00C_529D::
    ld hl, $9000
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, Data_00C_6101
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    call Func_000_290E
    ld hl, $9670
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0701
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    call Func_000_290E
    ret

Func_00C_52D0::
    ld a, [de]
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Func_00C_52D0
    ret

Func_00C_52D9::
    ld a, $02
    ldh [$FF70], a

Jump_00C_52DD::
    ld a, [de]
    and a, $07
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_00C_52DD
    ld a, $00
    ldh [$FF70], a
    ret

Func_00C_52EC::
    push bc
    ld a, [$D787]
    add a, a
    ld b, a
    add a, a
    add a, b
    ld b, a
    ld a, [$D786]
    add a, b
    pop bc
    ret

Func_00C_52FB::
    push bc
    ld a, [$D78B]
    add a, a
    ld b, a
    add a, a
    add a, b
    ld b, a
    ld a, [$D78A]
    add a, b
    pop bc
    ret

Func_00C_530A::
    push hl
    ld a, l
    ld [$D7F1], a
    ld a, h
    ld [$D7F2], a
    ld de, $C7FC
    ld a, e
    ld [$D7F3], a
    ld a, d
    ld [$D7F4], a
    ld hl, $68FA
    ld b, $15
    rst $10
    ld a, [$D7F5]
    cp a, $FF
    jr nz, Jump_00C_532F
    pop hl
    ld a, $FF
    ret

Jump_00C_532F::
    pop hl
    push hl
    ld a, l
    ld [$D006], a
    ld a, h
    ld [$D007], a
    ld hl, Data_00C_5A7E
    ld b, $16
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_00C_5346
    pop hl
    xor a, a
    ret

Jump_00C_5346::
    pop hl
    ld a, $FE
    ret

Func_00C_534A::
    call Func_00C_5050
    ld de, Data_00C_536A
    add hl, de
    ld a, [hl]

Func_00C_5352:: ; heuristic: target of a pointer table; C0
    ld hl, $54DF
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_00C_535B
    inc h

Jump_00C_535B::
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld b, $02
    ld hl, $D79C

Jump_00C_5363::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_00C_5363
    ret

Data_00C_536A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $03136A, $A4
    ds $14, $00
    INCBIN "dwm2-cobi-us.gbc", $031422, $BD
    dw Func_00C_54E9
    dw Func_00C_54EB
    dw Func_00C_54ED
    dw Func_00C_54EF
    dw Func_00C_54F1

Func_00C_54E9:: ; heuristic: target of a pointer table; C0
    ld a, h
    add a, b

Func_00C_54EB:: ; heuristic: target of a pointer table; C0
    ld a, l
    add a, b

Func_00C_54ED:: ; heuristic: target of a pointer table; C0
    ld a, [hl]
    add a, b

Func_00C_54EF:: ; heuristic: target of a pointer table; C0
    ld a, [hl]
    ld a, [hl]

Func_00C_54F1:: ; heuristic: target of a pointer table; C0
    ld a, a
    add a, b

Func_00C_54F3::
    call Func_00C_5050
    ld de, Data_00C_5562
    add hl, de
    ld a, [hl]
    add a, a
    ld hl, $5513
    add a, l
    ld l, a
    jr nc, Jump_00C_5504
    inc h

Jump_00C_5504::
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld b, $04
    ld hl, $D79C

Jump_00C_550C::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_00C_550C
    ret
    dw Func_00C_5523
    dw Func_00C_5527
    dw Func_00C_552B
    dw Func_00C_552F
    dw Func_00C_5533
    dw Func_00C_5537
    dw Func_00C_553B
    dw Func_00C_553F

Func_00C_5523:: ; heuristic: target of a pointer table; C0
    add a, c
    add a, b
    add a, b
    add a, b

Func_00C_5527:: ; heuristic: target of a pointer table; C0
    add a, d
    add a, b
    add a, b
    add a, b

Func_00C_552B:: ; heuristic: target of a pointer table; C0
    add a, d
    add a, c
    add a, b
    add a, b

Func_00C_552F:: ; heuristic: target of a pointer table; C0
    add a, d
    add a, d
    add a, b
    add a, b

Func_00C_5533:: ; heuristic: target of a pointer table; C0
    add a, d
    add a, d
    add a, c
    add a, b

Func_00C_5537:: ; heuristic: target of a pointer table; C0
    add a, d
    add a, d
    add a, d
    add a, b

Func_00C_553B:: ; heuristic: target of a pointer table; C0
    add a, d
    add a, d
    add a, d
    add a, c

Func_00C_553F:: ; heuristic: target of a pointer table; C0
    add a, d
    add a, d
    add a, d
    add a, d

Func_00C_5543::
    ld hl, Data_00C_555C
    ld b, $80
    ld c, $68
    ld a, b
    ldh [c], a
    ld c, $69
    ld d, $06

Jump_00C_5550::
    ldh a, [$FF41]
    and a, $02

Func_00C_5554:: ; heuristic: target of a pointer table; C0
    jr nz, Jump_00C_5550
    ld a, [hl+]
    ldh [c], a
    dec d
    jr nz, Jump_00C_5550
    ret

Data_00C_555C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $86, $7D, $FF, $7F, $E1, $7F

Data_00C_5562:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $031562, $175

Data_00C_56D7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $05, $04

Data_00C_56D9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0316D9, $75

Data_00C_574E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1

Func_00C_5756:: ; heuristic: target of a pointer table; C0
    or a, c
    or a, c
    or a, c
    or a, d
    or a, [hl]
    jp Jump_000_2120
    INCBIN "dwm2-cobi-us.gbc", $03175E, $5D
    dw Func_00C_44C3
    dw Func_00C_4645
    dw $4847
    dw Func_00C_4A49
    db $4B, $4C, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6
    dw Func_00C_4DC3
    dw Func_00C_4F4E
    dw Func_00C_5150
    dw Func_00C_5352
    dw Func_00C_5554
    db $B7, $B3, $B4, $B4, $B4, $B4, $B4, $C5, $C3, $BE, $C3, $C6, $B5

Data_00C_57EA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0317EA, $B0

Data_00C_589A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0
    ds $12, $B1
    db $B2, $B6, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8A, $8B, $8C, $8D
    db $8E, $8F, $90, $91, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F
    db $A0, $A1, $A2, $A3, $B7, $B3
    ds $12, $B4
    db $B5

Data_00C_58FE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $79, $C3, $A1, $C3, $C9, $C3, $F1, $C3, $19, $C4, $41, $C4

Data_00C_590A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $81, $C3, $A9, $C3, $D1, $C3, $F9, $C3, $21, $C4, $49, $C4

Data_00C_5916:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $00, $24, $00, $47, $00, $6A, $00, $8D, $00, $B0, $00, $D3, $00, $F6, $00
    db $19, $01, $3C, $01, $5F, $01, $FF, $FF

Data_00C_592E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $1B, $00, $43, $00, $67, $00, $85, $00, $A8, $00, $CA, $00, $F1, $00, $11, $01
    db $39, $01, $5C, $01, $75, $01

Data_00C_5944:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $04, $05, $05, $04, $04, $04, $04, $04, $05, $05, $03

Data_00C_594F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_00C_5965
    dw Data_00C_596A
    dw Data_00C_5970
    dw Data_00C_5976
    dw Data_00C_597B
    dw Data_00C_5980
    dw Data_00C_5985
    dw Data_00C_598A
    dw Data_00C_598F
    dw Data_00C_5995
    dw Data_00C_599B

Data_00C_5965:: ; heuristic: target of a monotone pointer table; C0
    db $05, $05, $05, $05, $01

Data_00C_596A:: ; heuristic: target of a monotone pointer table; C0
    db $05, $05, $05, $05, $05, $00

Data_00C_5970:: ; heuristic: target of a monotone pointer table; C0
    db $05, $05, $05, $05, $05, $01

Data_00C_5976:: ; heuristic: target of a monotone pointer table; C0
    db $05, $05, $05, $05, $02

Data_00C_597B:: ; heuristic: target of a monotone pointer table; C0
    db $05, $05, $05, $05, $02

Data_00C_5980:: ; heuristic: target of a monotone pointer table; C0
    db $05, $05, $05, $05, $01

Data_00C_5985:: ; heuristic: target of a monotone pointer table; C0
    db $05, $05, $05, $05, $05

Data_00C_598A:: ; heuristic: target of a monotone pointer table; C0
    db $05, $05, $05, $05, $02

Data_00C_598F:: ; heuristic: target of a monotone pointer table; C0
    db $05, $05, $05, $05, $05, $01

Data_00C_5995:: ; heuristic: target of a monotone pointer table; C0
    db $05, $05, $05, $05, $05, $01

Data_00C_599B:: ; heuristic: target of a monotone pointer table; C0
    db $05, $05, $05, $03

Data_00C_599F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $FE, $00, $FE, $00, $FE, $00, $FE, $00, $FE, $00, $FE, $00, $FE, $00, $FE
    db $00, $FE, $00, $FE, $FE, $FE, $00, $FE, $00, $FE, $00, $FE, $01, $00, $00, $FE
    db $00, $FE, $00, $FE, $11, $00, $10, $00, $04, $00, $0B, $00, $15, $00, $13, $00
    db $17, $00, $18, $00
    ds $14, $FE
    INCBIN "dwm2-cobi-us.gbc", $0319E7, $97

Data_00C_5A7E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FE, $03, $FE, $03, $FE, $03, $FE, $6A, $00, $6E, $00, $FE, $FE, $03, $FE, $6C
    db $00, $6B, $00, $77, $00, $6F, $00, $03, $FE, $03, $FE, $7C, $00, $7D, $00, $03
    db $FE, $03, $FE, $7B, $00, $81, $00, $7F, $00, $7A, $00
    ds $10, $FE
    db $04, $FE, $04, $FE, $04, $FE, $04, $FE, $04, $FE, $04, $FE, $04, $FE, $04, $FE
    db $04, $FE, $94, $00, $04, $FE, $04, $FE, $04, $FE, $04, $FE, $9C, $00, $04, $FE
    db $04, $FE, $04, $FE, $9E, $00, $9F, $00, $96, $00, $04, $FE, $A2, $00, $FE, $FE
    db $FE, $FE, $04, $FE, $99, $00
    ds $10, $FE
    db $05, $FE, $05, $FE, $05, $FE, $05, $FE, $05, $FE, $05, $FE, $05, $FE, $05, $FE
    db $05, $FE, $B0, $00, $FE, $FE, $B4, $00, $B5, $00, $05, $FE, $B3, $00, $05, $FE
    db $05, $FE, $B8, $00, $C1, $00, $C5, $00, $B7, $00, $05, $FE, $C4, $00, $05, $FE
    db $C6, $00, $B1, $00
    ds $12, $FE
    INCBIN "dwm2-cobi-us.gbc", $031B45, $7C
    ds $10, $FE
    db $08, $FE, $08, $FE, $08, $FE, $08, $FE, $08, $FE, $08, $FE, $08, $FE, $08, $FE
    db $08, $FE, $19, $01, $21, $01, $08, $FE, $08, $FE, $08, $FE, $08, $FE, $08, $FE
    db $26, $01, $29, $01, $08, $FE, $1B, $01, $24, $01, $24, $01, $08, $FE, $08, $FE
    db $22, $01, $31, $01

Data_00C_5C05:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $32, $01, $1E, $01, $2E, $01, $35, $01, $20, $01, $2C, $01, $FE, $FE, $FE

Data_00C_5C14:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FE, $FE, $FE, $09, $FE, $09, $FE, $09, $FE, $09, $FE, $09, $FE, $09, $FE, $09
    db $FE, $09, $FE, $09, $FE, $3C, $01

Data_00C_5C2B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $3C, $01, $46, $01, $46, $01, $41, $01, $49, $01, $4A, $01, $09, $FE, $4C, $01
    db $3C
    dw Func_00C_4B01
    dw Func_00C_4201
    dw Func_00C_4B01
    dw Func_00C_4501
    dw $5201
    dw Func_00C_4801
    dw Func_00C_4F01
    db $01, $54, $01, $52, $01, $09, $FE, $58, $01, $09, $FE, $45, $01, $FE, $FE, $FE
    db $FE, $FE, $FE, $0B, $01, $5F, $01, $60, $01, $08, $01, $ED, $00, $63, $01, $62
    db $01, $5F, $01, $66, $01, $EE, $00, $68, $01, $68, $01, $6A, $01, $6B, $01, $65
    db $01, $6B, $01, $6E, $01, $6F, $01, $70, $01, $69, $01, $72, $01
    ds $18, $FE
    db $00, $FE, $00, $FE, $00, $FE, $00, $FE, $00, $FE, $00, $FE, $00, $FE, $00, $FE
    db $00, $FE, $00, $FE, $FE, $FE, $00, $FE, $00, $FE, $00, $FE, $01, $00, $00, $FE
    db $00, $FE, $00, $FE, $11, $00, $10, $00, $04, $00, $0B, $00, $15, $00, $13, $00
    db $17, $00, $18, $00
    ds $14, $FE
    INCBIN "dwm2-cobi-us.gbc", $031CE7, $43

Data_00C_5D2A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FE, $FE, $FE, $02, $FE, $02, $FE, $02, $FE, $02, $FE, $02, $FE, $55, $00, $02
    db $FE, $02, $FE, $02, $FE, $4B, $00, $02, $FE, $02

Data_00C_5D44:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $031D44, $56

Data_00C_5D9A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $7D

Data_00C_5D9C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $03, $FE, $03, $FE, $7B, $00, $81, $00, $7F, $00, $7A, $00
    ds $10, $FE
    db $04, $FE, $04

Data_00C_5DBC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FE, $04, $FE, $04, $FE, $04, $FE, $04, $FE, $04, $FE, $04, $FE, $04, $FE, $94
    db $00, $04, $FE, $8D, $00, $04, $FE, $04, $FE, $04, $FE, $04, $FE, $04, $FE, $04
    db $FE, $9E, $00, $9F, $00, $96, $00, $04, $FE, $A2, $00, $FE, $FE, $FE, $FE, $04
    db $FE, $99

Data_00C_5DEE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00
    ds $10, $FE
    db $05, $FE, $05, $FE, $05, $FE, $05, $FE, $05, $FE, $05, $FE, $05, $FE, $05, $FE
    db $05, $FE, $B0

Data_00C_5E12:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $FE, $FE, $B4, $00, $B5, $00, $05, $FE, $B3, $00, $05, $FE, $05, $FE, $B8
    db $00, $C1, $00, $C5, $00, $B7, $00, $05, $FE, $C4, $00, $05, $FE, $C6, $00, $B1
    db $00
    ds $12, $FE
    INCBIN "dwm2-cobi-us.gbc", $031E45, $7C
    ds $10, $FE
    INCBIN "dwm2-cobi-us.gbc", $031ED1, $6B
    dw Func_00C_4B01
    dw Func_00C_4201
    dw Func_00C_4B01
    dw Func_00C_4501
    dw $5201
    dw Func_00C_4801
    dw Func_00C_4F01
    db $01, $54, $01, $52, $01, $09, $FE, $58, $01, $09, $FE, $45, $01, $FE, $FE, $FE
    db $FE, $FE, $FE, $0B, $01, $5F, $01, $60, $01, $08, $01, $ED, $00, $63, $01, $62
    db $01, $5F, $01, $66, $01, $EE, $00, $68, $01, $68, $01, $6A, $01, $6B, $01, $65
    db $01, $6B, $01, $6E, $01, $6F, $01, $70, $01, $69, $01, $72, $01
    ds $18, $FE

Data_00C_5F9F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FE, $FE, $01, $FE, $02, $FE, $03, $FE, $04, $FE, $05, $FE, $06, $FE, $07, $FE
    db $08, $FE, $09, $FE, $FE, $FE, $4A, $00, $48, $00, $32, $01, $2B, $00, $4D, $00
    db $0A, $FE, $24, $01, $11, $00, $5C, $00, $02, $FE, $DC, $00, $07, $FE, $24, $01
    db $17, $00, $18, $00
    ds $14, $FE
    INCBIN "dwm2-cobi-us.gbc", $031FE7, $C1
    ds $11, $FE
    db $00, $FE, $01, $FE, $02, $FE, $03, $FE, $05, $FE, $06, $FE, $07, $FE, $08, $FE
    db $09, $FE, $02, $FE, $40, $01, $1D, $01, $D3, $00, $92, $00, $01, $FE, $80, $00
    db $4A, $00, $0D, $00, $9E, $00, $9F, $00, $07, $FE, $0A, $FE, $EA, $00, $FE, $FE
    db $FE, $FE, $B6, $00, $06, $00
    ds $10, $FE
    db $00, $FE

Data_00C_6101:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $FE, $02, $FE, $03, $FE, $04, $FE, $06, $FE, $07, $FE, $08, $FE, $09, $FE
    db $00, $FE, $FE, $FE, $04, $FE, $08, $FE, $49, $01, $06, $FE, $F6, $00, $FB, $00
    db $07, $FE, $07, $FE, $06, $FE, $B7, $00, $DC, $00, $C4, $00, $0A, $FE, $08, $01
    db $B1, $00
    ds $12, $FE
    db $00, $FE, $01, $FE, $01, $FE, $03, $FE, $04, $FE, $05, $FE, $07, $FE, $08, $FE
    db $09, $FE, $00, $FE, $02

Data_00C_615A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $03215A, $67
    ds $10, $FE
    INCBIN "dwm2-cobi-us.gbc", $0321D1, $B6
    ds $1A, $FE
    db $01, $FE, $02, $FE, $03, $FE, $04, $FE, $05, $FE, $06, $FE

Data_00C_62AD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $07, $FE, $08, $FE, $09, $FE, $FE, $FE, $4A, $00, $48, $00, $32, $01, $2B, $00
    db $4D, $00, $0A, $FE, $24, $01, $11, $00, $5C, $00, $02, $FE, $DC, $00, $07, $FE
    db $24, $01, $17, $00, $18, $00
    ds $14, $FE
    INCBIN "dwm2-cobi-us.gbc", $0322E7, $C1
    ds $11, $FE
    db $00, $FE, $01, $FE, $02, $FE, $03, $FE, $05, $FE, $06, $FE, $07, $FE, $08, $FE
    db $09, $FE, $02, $FE, $B2, $00, $02, $FE, $D3, $00, $92, $00, $01, $01, $80, $00
    db $4A, $00, $0D, $00, $9E, $00, $9F, $00, $07, $FE, $0A, $FE, $EA, $00, $FE, $FE
    db $FE, $FE, $B6, $00, $06, $00
    ds $10, $FE
    db $00, $FE, $01, $FE, $02, $FE, $03, $FE, $04, $FE, $06, $FE, $07, $FE, $08, $FE
    db $09, $FE, $00, $FE, $FE, $FE, $04, $FE, $08, $FE, $45, $01, $06, $FE, $F6, $00
    db $FB, $00, $07, $FE, $07, $FE, $06, $FE, $B7, $00, $DC, $00, $C4, $00, $0A, $FE
    db $08, $01, $B1, $00
    ds $12, $FE
    INCBIN "dwm2-cobi-us.gbc", $032445, $59

Data_00C_649E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FE, $BF, $00, $71, $00, $4E, $00, $06, $FE, $FF, $00, $02, $FE, $09, $FE, $FC
    db $00, $13, $00, $8F, $00, $09, $01, $0A, $01, $5F, $01, $FE, $FE, $01, $FE, $27
    db $00, $2A, $01
    ds $10, $FE
    db $00, $FE

Data_00C_64D3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0324D3, $48

Data_00C_651B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $02, $FE, $03, $FE, $04, $FE, $05, $FE, $06, $FE, $08, $FE, $07, $FE, $02, $FE
    db $08, $FE, $D9, $00, $01, $FE, $05, $FE, $C0, $00, $4A, $01, $19, $01, $06, $FE
    db $01, $FE, $55, $01, $62

Data_00C_6540:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $032540, $47
    ds $18, $FE

Func_00C_659F::
    ld a, [$D780]
    rst $00
    dw Func_00C_66D7
    dw Func_00C_67E5
    dw Func_00C_680B
    dw Func_00C_6922
    dw Func_00C_694B
    dw Func_00C_6A04
    dw Func_00C_6A21
    dw Func_00C_6A29
    dw Func_00C_6A6A
    dw Func_00C_6A21
    dw Func_00C_6AC4
    dw Func_00C_6AC8
    dw Func_00C_6ACF
    dw Func_00C_6B10
    dw Func_00C_6B18
    dw Func_00C_6B2E
    dw Func_00C_6B78
    dw Func_00C_6BB4
    dw Func_00C_6BE3
    dw Func_00C_6CD0
    dw Func_00C_6D05
    dw Func_00C_6D0D
    dw Func_00C_6922
    dw Func_00C_6D4C
    dw Func_00C_6DC5
    dw Func_00C_6E0C
    dw Func_00C_6E42
    dw Func_00C_6E59
    dw Func_00C_6EB0
    dw Func_00C_6A21
    dw Func_00C_6EB4
    dw Func_00C_6A6A
    dw Func_00C_6A21
    dw Func_00C_6ED3
    dw Func_00C_6ED7
    dw Func_00C_6F26
    dw Func_00C_6F5E
    dw Func_00C_6922
    dw Func_00C_6674
    dw Func_00C_65F3

Func_00C_65F3:: ; heuristic: target of a pointer table; C0
    ld a, [$D7FC]
    add a, a
    ld hl, Data_00C_75D2
    add a, l
    ld l, a
    jr nc, Jump_00C_65FF
    inc h

Jump_00C_65FF::
    ld e, [hl]
    inc hl

Func_00C_6601:: ; heuristic: target of a pointer table; C0
    ld d, [hl]
    push de
    ld b, $1F
    call Func_00C_73B3
    pop de
    ld b, $00

Jump_00C_660B::
    ld a, [de]
    cp a, $FF
    jp z, Jump_00C_665E
    cp a, l
    jr nc, Jump_00C_6618
    inc de
    inc b
    jr Jump_00C_660B

Jump_00C_6618::
    ld a, [$D7FC]
    add a, a
    ld hl, Data_00C_7602
    add a, l
    ld l, a
    jr nc, Jump_00C_6624
    inc h

Jump_00C_6624::
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, b
    add a, e
    ld e, a
    jr nc, Jump_00C_662D
    inc d

Jump_00C_662D::
    ld a, [de]
    cp a, $FE
    jr z, Jump_00C_663F
    cp a, $FD
    jr z, Jump_00C_6655
    ld [$D7F1], a
    call Func_00C_755C
    jp Jump_00C_6663

Jump_00C_663F::
    ld hl, $689A
    ld b, $12
    rst $10
    ldh a, [$FFC6]
    and a, a
    jr z, Jump_00C_664E
    ld a, $01
    jr Jump_00C_6663

Jump_00C_664E::
    call Func_00C_75BC
    ld a, $03
    jr Jump_00C_6663

Jump_00C_6655::
    call Func_00C_750F
    call Func_00C_755C
    jp Jump_00C_6663

Jump_00C_665E::
    call Func_00C_75BC
    ld a, $03

Jump_00C_6663::
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    xor a, a
    ld [$D7FC], a
    ret

Func_00C_6674:: ; heuristic: target of a pointer table; C0
    ld hl, Data_00C_6540
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_00C_6688
    cp a, $FF
    jr z, Jump_00C_66C0
    ret

Jump_00C_6688::
    ld a, $01
    ld [$D7FA], a
    ld a, [$D780]
    dec a
    ld [$D780], a
    ld b, $00
    ld c, $05
    ld hl, $027A
    ld de, $00AE
    xor a, a
    ld [$D7F1], a
    ld a, $06
    ld [$D7F2], a
    call Func_00C_72CC
    call Func_00C_5156
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_00C_66C0::
    ld a, [$D7FA]
    and a, a
    jr nz, Jump_00C_6688
    ld a, [$D780]
    inc a
    ld [$D780], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_00C_66D7:: ; heuristic: target of a pointer table; C0
    ld hl, $D780
    ld b, $6F

Jump_00C_66DC::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_00C_66DC
    ld hl, $C364
    ld de, $C198
    ld bc, $0104
    call Func_00C_52D0
    ld a, [$C525]
    and a, a
    jr z, Jump_00C_66FF
    ld hl, $D1CC
    ld de, $D000
    ld bc, $0104
    call Func_00C_52D9

Jump_00C_66FF::
    ld a, $0A

Func_00C_6701:: ; heuristic: target of a pointer table; C0
    ld [$D7F0], a
    ld a, [$C82C]
    cp a, $05
    jr nc, Jump_00C_6770
    and a, a
    jr nz, Jump_00C_673F
    ld a, [$D7FB]
    cp a, $1F
    jr z, Jump_00C_6717
    ld a, $1D

Jump_00C_6717::
    ld [$D780], a
    ld a, $02
    ld [$D7FA], a
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
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_00C_673F::
    xor a, a
    ld [$D7FA], a
    ld [$C528], a
    ld a, $17
    ld [$C529], a
    ld hl, $8A40
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0A01
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld hl, Data_00C_649E
    ld b, $33
    rst $10
    ld a, [$D780]
    inc a
    ld [$D780], a
    jr Jump_00C_67B5

Jump_00C_6770::
    ld a, $01
    ld [$D7FA], a
    xor a, a
    ld [$C528], a
    ld a, $1A
    ld [$C529], a
    ld hl, $8A40
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0A01
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld hl, Data_00C_649E
    ld b, $33
    rst $10
    ld hl, $8F00
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld a, $18
    ld [$C529], a
    ld hl, Data_00C_649E
    ld b, $33
    rst $10
    ld a, $0B
    ld [$D780], a

Jump_00C_67B5::
    ld a, [$D7FB]
    cp a, $08
    jr z, Jump_00C_67C2
    cp a, $1B
    jr z, Jump_00C_67C2
    jr Jump_00C_67C5

Jump_00C_67C2::
    ld [$D780], a

Jump_00C_67C5::
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
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_00C_67E5:: ; heuristic: target of a pointer table; C0
    ld de, Data_00C_762E
    ld hl, $C3B4
    ld bc, $1109
    call Func_00C_51BB
    call Func_00C_7064
    call Func_00C_7098
    call Func_00C_5156
    ld bc, $140D
    ld de, $01CC
    db $CD

Func_00C_6801:: ; heuristic: target of a pointer table; C0
    push af
    ld d, c
    ld a, [$D780]
    inc a
    ld [$D780], a
    ret

Func_00C_680B:: ; heuristic: target of a pointer table; C0
    ld a, [$C563]
    bit 6, a
    jr nz, Jump_00C_6825
    bit 7, a
    jr nz, Jump_00C_683F
    ld a, [$C562]
    bit 1, a
    jr nz, Jump_00C_684F
    bit 0, a
    jr nz, Jump_00C_685E
    call Func_00C_68D5
    ret

Jump_00C_6825::
    call Func_00C_68F3
    ld a, [$D786]
    and a, a
    jr nz, Jump_00C_6832
    ld a, $03
    jr Jump_00C_6833

Jump_00C_6832::
    dec a

Jump_00C_6833::
    ld [$D786], a
    call Func_00C_68EF
    ld a, $69
    call Func_000_1278
    ret

Jump_00C_683F::
    call Func_00C_68F3
    ld a, [$D786]
    cp a, $03
    jr c, Jump_00C_684C
    xor a, a
    jr Jump_00C_6833

Jump_00C_684C::
    inc a
    jr Jump_00C_6833

Jump_00C_684F::
    ld a, $03
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_00C_685E::
    call Func_00C_68EF
    ld a, [$C82C]
    dec a
    ld b, a
    ld a, [$D786]
    cp a, b
    jr c, Jump_00C_687D
    jr z, Jump_00C_688C
    ld a, $02
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_00C_687D::
    ld a, $01
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_00C_688C::
    ld a, $69
    call Func_000_1278
    ld a, [$D786]
    ld hl, Data_00C_68D1
    add a, l
    ld l, a
    jr nc, Jump_00C_689C
    inc h

Jump_00C_689C::
    ld a, [hl]
    ld [$C130], a
    ld a, $F0
    ld [$C131], a
    ld a, [$D786]
    ld hl, Data_00C_784F
    ld b, $BC
    call Func_00C_525B
    call Func_00C_5156
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    ld a, [$D780]
    inc a
    ld [$D780], a
    xor a, a
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Data_00C_68D1:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0C, $0B, $0A, $1C

Func_00C_68D5::
    ld a, [$C564]
    cp a, $14
    jr c, Func_00C_68EF
    ld a, [$D787]
    inc a
    ld [$D787], a
    cp a, $10
    jr c, Func_00C_68EF
    cp a, $18
    jr c, Func_00C_68F3
    xor a, a
    ld [$D787], a

Func_00C_68EF::
    ld b, $BB
    jr Jump_00C_68F9

Func_00C_68F3::
    ld b, $C3
    jr Jump_00C_68F9
    db $06, $BC

Jump_00C_68F9::
    ld a, [$D786]
    sla a
    ld hl, Data_00C_691A

Func_00C_6901:: ; heuristic: target of a pointer table; C0
    add a, l
    ld l, a
    jr nc, Jump_00C_6906
    inc h

Jump_00C_6906::
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call Func_00C_5156
    pop de
    add hl, de
    call Func_000_24F8
    di
    call Func_000_120A
    ld a, b
    ld [hl], a
    ei
    ret

Data_00C_691A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A2, $00, $E2, $00, $22, $01, $62, $01

Func_00C_6922:: ; heuristic: target of a pointer table; C0
    ld a, $6C
    call Func_000_1278
    ld de, Data_00C_7831
    ld hl, $C412
    ld bc, $0605
    call Func_00C_51BB
    call Func_00C_5156
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    ld a, [$D780]
    inc a
    ld [$D780], a
    xor a, a
    ld [$D7FA], a
    ret

Func_00C_694B:: ; heuristic: target of a pointer table; C0
    ld hl, Data_00C_6540
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_00C_695F
    cp a, $FF
    jr z, Jump_00C_6978
    ret

Jump_00C_695F::
    call Func_00C_69D5
    ld a, [$D780]
    inc a
    ld [$D780], a
    ld a, $02
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_00C_6978::
    ld a, [$D7FA]
    and a, a
    jr nz, Jump_00C_695F
    ld a, [$D786]
    sla a
    ld de, Data_00C_7871
    add a, e
    ld e, a
    jr nc, Jump_00C_698B
    inc d

Jump_00C_698B::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    xor a, a
    ld [$D7F3], a
    ld a, h
    ld [$D7F2], a
    ld a, l
    ld [$D7F1], a
    ld hl, $440F
    ld b, $1C
    rst $10
    ld a, [$D7F1]
    cp a, $FF
    jr nz, Jump_00C_69BF
    ld a, $01
    ld [$D7FA], a
    ld a, [$D780]
    inc a
    ld [$D780], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_00C_69BF::
    xor a, a
    ld [$D7FA], a
    ld a, [$D780]
    inc a
    inc a
    ld [$D780], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_00C_69D5::
    ld b, $00
    ld c, $05
    ld hl, $027A
    ld de, $00AE
    xor a, a
    ld [$D7F1], a
    ld a, $06
    ld [$D7F2], a
    call Func_00C_72CC
    ld de, Data_00C_76C7
    ld hl, $C412
    ld bc, $0305
    call Func_00C_51BB
    call Func_00C_5156
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    ret

Func_00C_6A04:: ; heuristic: target of a pointer table; C0
    call Func_00C_69D5
    ld c, $04
    ld hl, Data_00C_784F
    call Func_00C_5247
    call Func_00C_5156
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    ld a, $02
    ld [$D780], a
    ret

Func_00C_6A21:: ; heuristic: target of a pointer table; C0
    ld a, [$D780]
    inc a
    ld [$D780], a
    ret

Func_00C_6A29:: ; heuristic: target of a pointer table; C0
    call Func_00C_7478
    ld a, [$D786]
    sla a
    ld de, Data_00C_7871
    add a, e
    ld e, a
    jr nc, Jump_00C_6A39
    inc d

Jump_00C_6A39::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    xor a, a
    ld [$D7F3], a
    ld a, h
    ld [$D7F2], a
    ld a, l
    ld [$D7F1], a
    ld hl, $683C
    ld b, $15
    rst $10
    ld a, [$D780]
    inc a
    ld [$D780], a
    ld [$D7FB], a
    ld a, [$D78E]
    ld [$D7FF], a
    ld a, [$D786]
    ld [$D7FC], a
    call Func_00C_6FCB
    ret

Func_00C_6A6A:: ; heuristic: target of a pointer table; C0
    ld a, [$D092]
    and a, a
    jr nz, Jump_00C_6AA1
    ld a, [$D7FF]
    cp a, $02
    jr nc, Jump_00C_6A8B
    call Func_00C_704B
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ld a, [$D780]
    inc a
    ld [$D780], a
    ret

Jump_00C_6A8B::
    ld a, [$C82C]
    inc a
    ld [$C82C], a
    xor a, a
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    jr Jump_00C_6AAF

Jump_00C_6AA1::
    ld a, $02
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a

Jump_00C_6AAF::
    xor a, a
    ld [$D7FC], a
    ld [$D7FB], a
    ld [$D7FF], a
    ld a, [$C82C]
    and a, a
    ret z
    ld a, $22
    ld [$D780], a
    ret

Func_00C_6AC4:: ; heuristic: target of a pointer table; C0
    call Func_00C_7478
    ret

Func_00C_6AC8:: ; heuristic: target of a pointer table; C0
    call Func_00C_7098
    call Func_00C_6922
    ret

Func_00C_6ACF:: ; heuristic: target of a pointer table; C0
    ld hl, Data_00C_6540
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_00C_6AE3
    cp a, $FF
    jr z, Jump_00C_6AF2
    ret

Jump_00C_6AE3::
    ld a, $01
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_00C_6AF2::
    ld a, [$D7FA]
    and a, a
    jr nz, Jump_00C_6AE3
    call Func_00C_69D5
    xor a, a
    ld [$D7FA], a
    ld a, [$D780]
    inc a
    ld [$D780], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_00C_6B10:: ; heuristic: target of a pointer table; C0
    ld a, [$D780]
    inc a
    ld [$D780], a
    ret

Func_00C_6B18:: ; heuristic: target of a pointer table; C0
    ld a, [$D780]
    inc a
    inc a
    ld [$D780], a
    xor a, a
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_00C_6B2E:: ; heuristic: target of a pointer table; C0
    ld b, $00
    ld c, $03
    ld hl, $01E0
    ld de, $0014
    xor a, a
    ld [$D7F1], a
    ld a, $08
    ld [$D7F2], a
    call Func_00C_72CC
    ld b, $00
    ld c, $07
    ld hl, $0244
    ld de, $0078
    xor a, a
    ld [$D7F1], a
    ld a, $0D
    ld [$D7F2], a
    call Func_00C_72CC
    call Func_00C_5156
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    ld a, [$D780]
    sub a, $04
    ld [$D780], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_00C_6B78:: ; heuristic: target of a pointer table; C0
    ld de, Data_00C_76D6
    ld hl, $C3B4
    ld bc, $1109
    call Func_00C_51BB
    call Func_00C_7098
    call Func_00C_5156
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    call Func_00C_5156
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    call Func_00C_74DB
    ld a, [$D780]
    inc a
    inc a
    ld [$D780], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_00C_6BB4:: ; heuristic: target of a pointer table; C0
    ld de, Data_00C_76D6
    ld hl, $C3B4
    ld bc, $1109
    call Func_00C_51BB
    call Func_00C_7098
    call Func_00C_5156
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    call Func_00C_5156
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    ld a, [$D780]
    inc a
    ld [$D780], a
    ret

Func_00C_6BE3:: ; heuristic: target of a pointer table; C0
    ld a, [$C563]
    bit 6, a
    jr nz, Jump_00C_6BFD
    bit 7, a
    jr nz, Jump_00C_6C17
    ld a, [$C562]
    bit 1, a
    jr nz, Jump_00C_6C27
    bit 0, a
    jr nz, Jump_00C_6C36
    call Func_00C_6C83
    ret

Jump_00C_6BFD::
    call Func_00C_6CA1
    ld a, [$D786]
    and a, a
    jr nz, Jump_00C_6C0A
    ld a, $03
    jr Jump_00C_6C0B

Jump_00C_6C0A::
    dec a

Jump_00C_6C0B::
    ld [$D786], a
    call Func_00C_6C9D
    ld a, $69
    call Func_000_1278
    ret

Jump_00C_6C17::
    call Func_00C_6CA1
    ld a, [$D786]
    cp a, $03
    jr c, Jump_00C_6C24
    xor a, a
    jr Jump_00C_6C0B

Jump_00C_6C24::
    inc a
    jr Jump_00C_6C0B

Jump_00C_6C27::
    ld a, $01
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_00C_6C36::
    call Func_00C_6C9D
    ld a, $69
    call Func_000_1278
    ld a, [$D786]
    ld hl, Data_00C_6C7F
    add a, l
    ld l, a
    jr nc, Jump_00C_6C49
    inc h

Jump_00C_6C49::
    ld a, [hl]
    ld [$C130], a
    ld a, $F0
    ld [$C131], a
    ld a, [$D786]
    ld hl, Data_00C_7857
    ld b, $BC
    call Func_00C_525B
    call Func_00C_5156
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    ld a, [$D780]
    inc a
    inc a
    ld [$D780], a
    xor a, a
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Data_00C_6C7F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0C, $0B, $0A, $1C

Func_00C_6C83::
    ld a, [$C564]
    cp a, $14
    jr c, Func_00C_6C9D
    ld a, [$D787]
    inc a
    ld [$D787], a
    cp a, $10
    jr c, Func_00C_6C9D
    cp a, $18
    jr c, Func_00C_6CA1
    xor a, a
    ld [$D787], a

Func_00C_6C9D::
    ld b, $BB
    jr Jump_00C_6CA7

Func_00C_6CA1::
    ld b, $C3
    jr Jump_00C_6CA7
    db $06, $BC

Jump_00C_6CA7::
    ld a, [$D786]
    sla a
    ld hl, Data_00C_6CC8
    add a, l
    ld l, a
    jr nc, Jump_00C_6CB4
    inc h

Jump_00C_6CB4::
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call Func_00C_5156
    pop de
    add hl, de
    call Func_000_24F8
    di
    call Func_000_120A
    ld a, b
    ld [hl], a
    ei
    ret

Data_00C_6CC8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A1, $00, $E1, $00, $21, $01, $61, $01

Func_00C_6CD0:: ; heuristic: target of a pointer table; C0
    ld b, $00
    ld c, $05
    ld hl, $01E0
    ld de, $0014
    xor a, a
    ld [$D7F1], a
    ld a, $08
    ld [$D7F2], a
    call Func_00C_72CC
    call Func_00C_5156
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    ld a, $0D
    ld [$D780], a
    xor a, a
    ld [$D78A], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_00C_6D05:: ; heuristic: target of a pointer table; C0
    ld a, [$D780]
    inc a
    ld [$D780], a
    ret

Func_00C_6D0D:: ; heuristic: target of a pointer table; C0
    ld a, [$D786]
    inc a
    inc a
    ld [$D78C], a
    ld a, $02
    ld [$D78A], a
    ld a, [$D786]
    add a, a
    ld hl, Data_00C_6D44
    add a, l
    ld l, a
    jr nc, Jump_00C_6D26
    inc h

Jump_00C_6D26::
    ld a, [hl]
    ld [$D586], a
    inc hl
    ld a, [hl]
    ld [$D587], a
    ld a, [$D780]
    inc a
    ld [$D780], a
    xor a, a
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Data_00C_6D44:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $E8, $03, $D0, $07, $B8, $0B, $88, $13

Func_00C_6D4C:: ; heuristic: target of a pointer table; C0
    ld hl, Data_00C_6540
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_00C_6D60
    cp a, $FF
    jr z, Jump_00C_6D76
    ret

Jump_00C_6D60::
    ld a, $02
    ld [$D7FA], a
    ld a, [$D780]
    inc a
    ld [$D780], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_00C_6D76::
    ld a, [$D7FA]
    and a, a
    jr nz, Jump_00C_6D60
    ld a, [$D586]
    ld [$D7F1], a
    ld a, [$D587]
    ld [$D7F2], a
    xor a, a
    ld [$D7F3], a
    ld hl, $440F
    ld b, $1C
    rst $10
    ld a, [$D7F1]
    cp a, $FF
    jr nz, Jump_00C_6DAF
    ld a, $01
    ld [$D7FA], a
    ld a, [$D780]
    inc a
    ld [$D780], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_00C_6DAF::
    ld a, [$D780]
    inc a
    inc a
    ld [$D780], a
    xor a, a
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_00C_6DC5:: ; heuristic: target of a pointer table; C0
    ld b, $00
    ld c, $05
    ld hl, $027A
    ld de, $00AE
    xor a, a
    ld [$D7F1], a
    ld a, $06
    ld [$D7F2], a
    call Func_00C_72CC
    ld de, Data_00C_776F
    ld hl, $C412
    ld bc, $0305
    call Func_00C_51BB
    call Func_00C_5156
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    call Func_00C_74DB
    ld a, $11
    ld [$D780], a
    xor a, a
    ld [$D78A], a
    ld [$D78C], a

Func_00C_6E02:: ; heuristic: target of a pointer table; C0
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_00C_6E0C:: ; heuristic: target of a pointer table; C0
    xor a, a
    ld [$D7F3], a
    ld a, [$D587]
    ld [$D7F2], a
    ld a, [$D586]
    ld [$D7F1], a
    ld hl, $683C
    ld b, $15
    rst $10
    call Func_00C_7098
    call Func_00C_5156
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    ld a, [$D780]
    inc a
    ld [$D780], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_00C_6E42:: ; heuristic: target of a pointer table; C0
    ld a, [$D78C]
    ld [$D7FC], a
    call Func_00C_73C7
    ld a, [$D780]
    inc a
    ld [$D780], a
    ld [$D7FB], a
    call Func_00C_6FCB
    ret

Func_00C_6E59:: ; heuristic: target of a pointer table; C0
    ld a, [$D092]
    and a, a
    jr nz, Jump_00C_6EA2
    ld a, [$D588]
    cp a, $02
    jr nc, Jump_00C_6E85
    call Func_00C_703D
    ld a, $01
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ld a, [$D780]
    ld [$D7FB], a
    ld a, [$D780]
    inc a
    ld [$D780], a
    ret

Jump_00C_6E85::
    call Func_00C_73C6
    xor a, a

Jump_00C_6E89::
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    xor a, a
    ld [$D7FB], a
    ld [$D7FF], a
    ld a, $23
    ld [$D780], a
    ret

Jump_00C_6EA2::
    xor a, a
    ld [$D7F3], a
    ld [$D7F2], a
    ld [$D7F1], a
    ld a, $02
    jr Jump_00C_6E89

Func_00C_6EB0:: ; heuristic: target of a pointer table; C0
    call Func_00C_7402
    ret

Func_00C_6EB4:: ; heuristic: target of a pointer table; C0
    call Func_00C_741F
    ld a, [$D780]
    inc a
    ld [$D780], a
    ld [$D7FB], a
    ld a, [$D78E]
    xor a, a
    ld [$D7FF], a
    ld a, [$D786]
    xor a, a
    ld [$D7FC], a
    call Func_00C_6FCB
    ret

Func_00C_6ED3:: ; heuristic: target of a pointer table; C0
    call Func_00C_741F
    ret

Func_00C_6ED7:: ; heuristic: target of a pointer table; C0
    ld a, [$D092]
    and a, a
    jr nz, Func_00C_6F02
    ld a, [$C82C]
    dec a
    dec a
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ld a, [$C82C]
    cp a, $01
    jr c, Jump_00C_6F01
    cp a, $05
    jr nc, Jump_00C_6F01
    ld a, [$D780]
    inc a
    inc a
    ld [$D780], a

Jump_00C_6F01::
    ret

Func_00C_6F02:: ; heuristic: target of a pointer table; C0
    ld a, [$C82C]
    cp a, $03
    jr nc, Jump_00C_6F17
    xor a, a
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_00C_6F17::
    ld a, $01
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_00C_6F26:: ; heuristic: target of a pointer table; C0
    ld a, [$D092]
    and a, a
    jr nz, Jump_00C_6F2E
    jr Jump_00C_6F30

Jump_00C_6F2E::
    jr Jump_00C_6F49

Jump_00C_6F30::
    call Func_00C_701C
    xor a, a
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ld a, [$D780]
    inc a
    inc a
    ld [$D780], a
    ret

Jump_00C_6F49::
    ld hl, $470B
    ld b, $02
    rst $10
    ld a, $01
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_00C_6F5E:: ; heuristic: target of a pointer table; C0
    ld a, [$C82C]
    cp a, $01
    jr nz, Jump_00C_6F8B
    ld de, $0188
    call Func_000_1845
    ld hl, $6990
    ld b, $12
    rst $10
    ld a, $03
    ldh [$FFC7], a
    ld hl, $6955
    ld b, $12
    rst $10
    ld a, [$C836]
    set 7, a
    ld [$C836], a
    ld de, $012F
    call Func_000_1845
    jr Jump_00C_6F99

Jump_00C_6F8B::
    ld hl, $689A
    ld b, $12
    rst $10
    ldh a, [$FFC6]
    ld [$C892], a
    and a, a
    jr z, Jump_00C_6FBC

Jump_00C_6F99::
    ld hl, $C130
    ld de, $C60C
    ld b, $0A

Jump_00C_6FA1::
    ld a, [de]
    cp a, $F0
    jr z, Jump_00C_6FAB
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_00C_6FA1

Jump_00C_6FAB::
    ld a, $F0
    ld [hl], a
    xor a, a
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_00C_6FBC::
    ld a, $01
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_00C_6FCB::
    ld b, $00
    ld c, $0D
    ld hl, $01CC
    ld de, $0000
    xor a, a
    ld [$D7F1], a
    ld a, $14
    ld [$D7F2], a
    call Func_00C_72CC
    ld hl, $C300
    ld de, $C29C
    ld bc, $0064
    call Func_00C_52D0
    ld a, [$C525]
    and a, a
    jr z, Jump_00C_6FFF
    ld hl, $D168
    ld de, $D104
    ld bc, $0064
    call Func_00C_52D9

Jump_00C_6FFF::
    call Func_00C_5156

Func_00C_7002:: ; heuristic: target of a pointer table; C0
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    call Func_00C_5156
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call Func_00C_51F5
    ret

Func_00C_701C::
    ld hl, $470B
    ld b, $02
    rst $10
    ld a, [$D7FC]
    ld hl, Data_00C_7037
    add a, l
    ld l, a
    jr nc, Jump_00C_702D
    inc h

Jump_00C_702D::
    ld a, [hl]
    ld [$C130], a
    ld a, $F0
    ld [$C131], a
    ret

Data_00C_7037:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0C, $0C, $0C, $0B, $0A, $1C

Func_00C_703D::
    ld a, [$D588]
    inc a
    ld [$D588], a
    ld a, [$D7FC]
    ld [$D78C], a
    ret

Func_00C_704B::
    ld a, [$D7FF]
    inc a
    ld [$D78E], a
    ld a, [$D7FC]
    ld [$D786], a
    ld a, $01
    ld [$D7FA], a
    ld a, [$D78E]
    ld [$D7FF], a
    ret

Func_00C_7064::
    ld hl, $C3C9
    ld a, [$C82C]
    cp a, $02
    jr c, Jump_00C_7071
    ld a, $AD
    ld [hl], a

Jump_00C_7071::
    ld a, [$C82C]
    cp a, $03
    jr c, Jump_00C_707E
    ld hl, $C3F1
    ld a, $AD
    ld [hl], a

Jump_00C_707E::
    ld a, [$C82C]
    cp a, $04
    jr c, Jump_00C_708B
    ld hl, $C419
    ld a, $AD
    ld [hl], a

Jump_00C_708B::
    ld a, [$C82C]
    cp a, $05
    ret c
    ld hl, $C441
    ld a, $AD
    ld [hl], a
    ret

Func_00C_7098::
    ld de, Data_00C_777E
    ld hl, $C370
    ld bc, $0803
    call Func_00C_51BB
    ld a, [$C617]
    ld [$C8C0], a
    ld a, [$C618]
    ld [$C8C1], a
    ld a, [$C619]
    ld [$C8C2], a
    call Func_000_173A
    ld hl, Data_00C_768E
    ld b, $1E
    rst $10
    ld hl, $C386
    ld de, $D7F3
    ld c, $00

Jump_00C_70C7::
    ld a, [de]
    add a, $E0
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $05
    jr c, Jump_00C_70C7
    ret

Func_00C_70D3::
    ld hl, $0000
    ld de, $D580
    ld c, $00

Jump_00C_70DB::
    push de
    push bc
    ld a, [de]
    add a, l
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    pop bc
    pop de
    inc de
    inc c
    ld a, [$C6FD]
    ld b, a
    ld a, c
    cp a, b
    jr c, Jump_00C_70DB
    ld a, [$C6FD]
    call Func_000_16D1
    ld a, h
    and a, a
    ret z
    ld h, $00
    ld l, $FF
    ret

Func_00C_70FE::
    xor a, a
    ld [$D580], a

Func_00C_7102:: ; heuristic: target of a pointer table; C0
    ld [$D581], a
    ld [$D582], a
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld de, $C6FE
    ld c, $00

Jump_00C_7116::
    push bc
    push de
    ld hl, $0000
    push hl
    ld a, [de]
    ld c, $5D
    call Func_000_1F89
    pop hl
    call Func_00C_7246
    pop de
    push de
    ld hl, $0000
    push hl
    ld a, [de]
    ld c, $61
    call Func_000_1F89
    pop hl
    call Func_00C_7246
    pop de
    push de
    push hl
    ld a, [de]
    ld c, $63
    call Func_000_1F89
    pop hl
    call Func_00C_7246
    pop de
    push de
    push hl
    ld a, [de]
    ld c, $65
    call Func_000_1F89
    pop hl
    call Func_00C_7246
    pop de
    push de
    push hl
    ld a, [de]
    ld c, $67
    call Func_000_1F89
    ld hl, $0000
    call Func_00C_7246
    ld c, l
    ld b, h
    pop hl
    pop de
    push de
    push hl
    push bc
    ld a, [de]
    ld c, $69
    call Func_000_1F89
    pop hl
    call Func_00C_7246
    srl h
    rr l
    ld c, l
    ld b, h
    pop hl
    add hl, bc
    ld a, $32
    call Func_000_16D1
    ld a, h
    and a, a
    jr z, Jump_00C_7187
    ld h, $00
    ld l, $63
    jr Jump_00C_7190

Jump_00C_7187::
    ld a, l
    cp a, $64
    jr c, Jump_00C_7190
    ld h, $00
    ld l, $63

Jump_00C_7190::
    pop de
    pop bc
    push bc
    push de
    ld de, $D580
    ld a, c
    add a, e
    ld e, a
    jr nc, Jump_00C_719D
    inc d

Jump_00C_719D::
    ld a, l
    ld [de], a
    pop de
    push de
    ld hl, $0000
    push hl
    ld a, [de]
    ld c, $5D
    call Func_000_1F89
    pop hl
    call Func_00C_7246
    pop de
    push de
    ld hl, $0000
    push hl
    ld a, [de]
    ld c, $61
    call Func_000_1F89
    pop hl
    call Func_00C_7246
    pop de
    push de
    push hl
    ld a, [de]
    ld c, $63
    call Func_000_1F89
    pop hl
    call Func_00C_7246
    pop de
    push de
    push hl
    ld a, [de]
    ld c, $65
    call Func_000_1F89
    pop hl
    call Func_00C_7246
    pop de
    push de
    push hl
    ld a, [de]
    ld c, $67
    call Func_000_1F89
    pop hl
    call Func_00C_7246
    pop de
    push de
    push hl
    ld a, [de]
    ld c, $69
    call Func_000_1F89
    pop hl
    call Func_00C_7246
    pop de
    push de
    push hl
    ld a, [de]
    ld c, $56
    call Func_000_1F80
    ldh a, [$FFC6]
    ld c, $18
    call Func_000_1682
    ld b, h
    ld c, l
    pop hl
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    ld a, $32
    call Func_000_16D1
    ld a, h
    and a, a
    jr z, Jump_00C_721B
    ld h, $00
    ld l, $63
    jr Jump_00C_7224

Jump_00C_721B::
    ld a, l
    cp a, $64
    jr c, Jump_00C_7224
    ld h, $00
    ld l, $63

Jump_00C_7224::
    pop de
    pop bc
    push bc
    push de
    ld de, $D580
    ld a, c
    add a, e
    ld e, a
    jr nc, Jump_00C_7231
    inc d

Jump_00C_7231::
    ld a, [de]
    add a, l
    ld [de], a
    pop de
    pop bc
    inc de
    inc c
    ld a, [$C6FD]
    ld b, a
    ld a, c
    cp a, b
    jp c, Jump_00C_7116
    xor a, a
    ld [$1FFF], a
    ret

Func_00C_7246::
    ldh a, [$FFC6]
    add a, l
    ld l, a
    ldh a, [$FFC7]
    adc a, h
    ld h, a
    ret

Func_00C_724F:: ; heuristic: follows a terminator; C0
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld hl, $C6FE
    ld de, $0000
    ld c, $00

Jump_00C_7260::
    push bc
    push hl
    push de
    ld a, [hl]
    ld c, $56
    call Func_000_1F80
    pop de
    ldh a, [$FFC6]
    add a, e
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop hl
    pop bc
    inc hl
    inc c
    ld a, [$C6FD]
    ld b, a
    ld a, c
    cp a, b
    jr c, Jump_00C_7260
    xor a, a
    ld [$1FFF], a
    ld a, d
    and a, a
    jr nz, Jump_00C_729E
    ld a, e
    cp a, $DC
    jr nc, Jump_00C_729E
    cp a, $B5
    jr nc, Jump_00C_72A2
    cp a, $8B
    jr nc, Jump_00C_72A6
    cp a, $5B
    jr nc, Jump_00C_72AA
    cp a, $31
    jr nc, Jump_00C_72AE
    xor a, a
    jr Jump_00C_72B0

Jump_00C_729E::
    ld a, $05
    jr Jump_00C_72B0

Jump_00C_72A2::
    ld a, $04
    jr Jump_00C_72B0

Jump_00C_72A6::
    ld a, $03
    jr Jump_00C_72B0

Jump_00C_72AA::
    ld a, $02
    jr Jump_00C_72B0

Jump_00C_72AE::
    ld a, $01

Jump_00C_72B0::
    sla a
    ld de, Func_00C_72C0
    add a, e
    ld e, a
    jr nc, Jump_00C_72BA
    inc d

Jump_00C_72BA::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ret

Func_00C_72C0:: ; heuristic: follows a terminator; C0
    sub a, b
    ld bc, $0258
    jr nz, Jump_00C_72C9
    or a, b
    inc b
    ld a, b

Jump_00C_72C9::
    dec b
    ld a, b
    dec b

Func_00C_72CC::
    push bc
    push hl
    push de
    ld de, $C198
    add hl, de
    pop de
    push de
    push hl
    ld hl, $C198
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    pop hl
    ld a, [$D7F1]
    ld b, a
    ld a, [$D7F2]
    ld c, a
    call Func_00C_52D0
    pop de
    pop hl
    ld a, [$C525]
    and a, a
    jr z, Jump_00C_7311
    push hl
    push de
    ld de, $D000
    add hl, de
    pop de
    push de
    push hl
    ld hl, $D000
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    pop hl
    ld a, [$D7F1]
    ld b, a
    ld a, [$D7F2]
    ld c, a
    call Func_00C_52D9
    pop de
    pop hl

Jump_00C_7311::
    pop bc
    ld a, $14
    add a, l
    ld l, a
    jr nc, Jump_00C_7319
    inc h

Jump_00C_7319::
    ld a, $14
    add a, e
    ld e, a
    jr nc, Jump_00C_7320
    inc d

Jump_00C_7320::
    inc b
    ld a, b
    cp a, c
    jr c, Func_00C_72CC
    ret

Func_00C_7326::
    ld hl, $D589
    ld b, $28

Jump_00C_732B::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_00C_732B
    ld a, [$D588]
    ld b, a
    ld c, $00

Jump_00C_7336::
    push bc
    ld b, $1F
    call Func_00C_73B3

Jump_00C_733C::
    ld de, Data_00C_78FF
    ld a, [$D7FC]
    add a, e
    ld e, a
    jr nc, Jump_00C_7347
    inc d

Jump_00C_7347::
    ld a, [de]
    ld b, a

Jump_00C_7349::
    ld a, l
    cp a, b
    jr c, Jump_00C_7351
    sub a, b
    ld l, a
    jr Jump_00C_733C

Jump_00C_7351::
    push hl
    ld hl, $D589
    add a, l
    ld l, a
    jr nc, Jump_00C_735A
    inc h

Jump_00C_735A::
    ld a, [hl]
    cp a, $03
    jr c, Jump_00C_7363
    pop hl
    inc l
    jr Jump_00C_7349

Jump_00C_7363::
    inc a
    ld [hl], a
    pop hl
    ld b, l
    ld hl, Data_00C_7905
    ld a, [$D7FC]
    sla a
    add a, l
    ld l, a
    jr nc, Jump_00C_7374
    inc h

Jump_00C_7374::
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, b
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_00C_737E
    inc d

Jump_00C_737E::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld d, a
    ld e, l
    pop bc
    push bc
    ld a, b
    sla a
    ld l, a
    sla a
    add a, l
    ld hl, $D5B1
    add a, l
    ld l, a
    jr nc, Jump_00C_7395
    inc h

Jump_00C_7395::
    ld a, c
    sla a
    add a, l
    ld l, a
    jr nc, Jump_00C_739D
    inc h

Jump_00C_739D::
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl], a
    pop bc
    inc c
    ld a, c
    cp a, $03
    jp c, Jump_00C_7336
    ld c, $00
    inc b
    ld a, b
    cp a, $03
    jp c, Jump_00C_7336
    ret

Func_00C_73B3::
    push bc
    call Func_000_095B
    pop bc
    ld a, [$C5E7]
    ld l, a
    rl a
    and a, b
    ld h, a
    ld a, $52
    call Func_000_16D1
    ret

Func_00C_73C6::
    ret

Func_00C_73C7::
    ld a, [$C919]
    ld [$C91C], a
    ld a, [$C91A]
    ld [$C91D], a
    ld a, [$C91B]
    ld [$C91E], a
    xor a, a
    ld [$C917], a
    ld a, $1F
    ld [$C916], a
    ld hl, $405C
    ld b, $13
    rst $10
    xor a, a
    ld [$D7FD], a
    xor a, a
    ldh [$FFB9], a
    ld hl, $449F
    ld b, $04
    rst $10

Func_00C_73F5::
    ld a, $04
    ld [$C903], a
    ld a, $02
    ld [$CFDC], a
    call Func_00C_7326

Func_00C_7402::
    ld a, [$D588]
    sla a
    ld b, a
    sla a
    add a, b
    ld hl, $D5B1
    add a, l
    ld l, a
    jr nc, Jump_00C_7413
    inc h

Jump_00C_7413::
    ld de, $CFDD
    ld b, $06

Jump_00C_7418::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_00C_7418
    ret

Func_00C_741F::
    ld a, [$C919]
    ld [$C91C], a
    ld a, [$C91A]
    ld [$C91D], a
    ld a, [$C91B]
    ld [$C91E], a
    xor a, a
    ld [$C917], a
    ld a, $18
    ld [$C916], a
    ld hl, $405C
    ld b, $13
    rst $10
    xor a, a
    ld [$D7FD], a
    xor a, a
    ldh [$FFB9], a
    ld hl, $449F
    ld b, $04
    rst $10

Func_00C_744D::
    ld a, $04
    ld [$C903], a
    ld a, $02
    ld [$CFDC], a
    ld hl, Data_00C_787D
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, [$D78E]
    sla a
    add a, e
    ld e, a
    jr nc, Jump_00C_7467
    inc d

Jump_00C_7467::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld de, $CFDD
    ld b, $06

Jump_00C_7471::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_00C_7471
    ret

Func_00C_7478::
    ld a, [$C919]
    ld [$C91C], a
    ld a, [$C91A]
    ld [$C91D], a
    ld a, [$C91B]
    ld [$C91E], a
    xor a, a
    ld [$C917], a
    ld a, $18
    ld [$C916], a
    ld hl, $405C
    ld b, $13
    rst $10
    xor a, a
    ld [$D7FD], a
    xor a, a
    ldh [$FFB9], a
    ld hl, $449F
    ld b, $04
    rst $10

Func_00C_74A6::
    ld a, $04
    ld [$C903], a
    ld a, $02
    ld [$CFDC], a
    ld a, [$D786]
    sla a
    ld hl, Data_00C_7897
    add a, l
    ld l, a
    jr nc, Jump_00C_74BD
    inc h

Jump_00C_74BD::
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, [$D78E]
    sla a
    add a, e
    ld e, a
    jr nc, Jump_00C_74CA
    inc d

Jump_00C_74CA::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld de, $CFDD
    ld b, $06

Jump_00C_74D4::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_00C_74D4
    ret

Func_00C_74DB::
    call Func_00C_70FE
    call Func_00C_70D3
    ld a, l
    cp a, $50
    jr nc, Jump_00C_74FA
    cp a, $3C
    jr nc, Jump_00C_74FD
    cp a, $28
    jr nc, Jump_00C_7501
    cp a, $1E
    jr nc, Jump_00C_7505
    cp a, $00
    jr nc, Jump_00C_7509
    ld a, $05
    jr Jump_00C_750B

Jump_00C_74FA::
    xor a, a
    jr Jump_00C_750B

Jump_00C_74FD::
    ld a, $01
    jr Jump_00C_750B

Jump_00C_7501::
    ld a, $02
    jr Jump_00C_750B

Jump_00C_7505::
    ld a, $03
    jr Jump_00C_750B

Jump_00C_7509::
    ld a, $04

Jump_00C_750B::
    ld [$D7FA], a
    ret

Func_00C_750F::
    ld b, $1F
    call Func_00C_73B3
    ld c, l
    ld a, l
    and a, $03
    sla a
    ld hl, Data_00C_7538
    add a, l
    ld l, a
    jr nc, Jump_00C_7522
    inc h

Jump_00C_7522::
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, c

Jump_00C_7526::
    cp a, $07
    jr c, Jump_00C_752E
    sub a, $07
    jr Jump_00C_7526

Jump_00C_752E::
    add a, e
    ld e, a
    jr nc, Jump_00C_7533
    inc d

Jump_00C_7533::
    ld a, [de]
    ld [$D7F1], a
    ret

Data_00C_7538:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $40, $75, $47, $75, $4E, $75, $55, $75, $40, $41, $42, $43, $44, $45, $46, $47
    dw Func_00C_4948
    dw Func_00C_4B4A
    dw $4D4C
    dw Func_00C_4F4E
    dw Func_00C_5150
    dw Func_00C_5352
    db $5A, $5B, $5C, $5D, $5E, $5F, $60, $61

Func_00C_755C::
    ld hl, $C61D
    ld c, $18

Jump_00C_7561::
    ld a, [hl]
    and a, a
    jr z, Jump_00C_757E
    cp a, $FF
    jr z, Jump_00C_757E
    inc hl
    dec c
    jr nz, Jump_00C_7561
    ld a, [$D7F1]
    push af
    call Func_00C_75BC
    pop af
    ld [$D7F1], a
    call Func_00C_7587
    ld a, $02
    ret

Jump_00C_757E::
    ld a, [$D7F1]
    ld [hl], a
    call Func_00C_7587
    xor a, a
    ret

Func_00C_7587::
    ld de, Data_008_403C
    ld b, $08
    call Func_000_18D6
    ld c, l
    ld b, h
    ld a, [$D7F1]
    ld e, a
    ld d, $00
    sla e
    rl d
    ld l, c
    ld h, b
    add hl, de
    ld e, l
    ld d, h
    ld b, $08
    call Func_000_18D6
    ld e, l
    ld d, h
    ld hl, $C140

Jump_00C_75AA::
    ld b, $08
    call Func_000_1872
    ld a, c
    cp a, $F0
    jr z, Jump_00C_75B8
    ld [hl+], a
    inc de
    jr Jump_00C_75AA

Jump_00C_75B8::
    ld a, $F0
    ld [hl+], a
    ret

Func_00C_75BC::
    ld hl, $1770
    ld a, l
    ld [$D7F1], a
    ld a, h
    ld [$D7F2], a
    xor a, a
    ld [$D7F3], a
    ld hl, $45B0
    ld b, $1C
    rst $10
    ret

Data_00C_75D2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $DE, $75, $DE, $75, $DE, $75, $E7, $75, $F0, $75, $F9, $75, $19, $23, $2D, $37
    db $41, $4B, $5F, $64, $FF, $14, $1F, $2A, $35, $40, $4B, $5A, $64, $FF, $0F, $17
    db $1F, $27, $2F, $37, $50, $64, $FF, $0A, $15, $20, $2B, $36, $41, $50, $64, $FF

Data_00C_7602:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0E, $76, $0E, $76, $0E, $76, $16, $76, $1E, $76, $26, $76, $01, $53, $05, $0C
    db $24, $0B, $1C, $44, $02, $18, $0F, $10, $13, $15, $45, $FE, $03, $0D, $11, $12
    db $17, $2C, $FD, $FE, $23, $2C, $0D, $0E, $17, $FD, $1E, $FE

Data_00C_762E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $03362E, $60

Data_00C_768E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $E1, $E0, $E0, $E0, $BF, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $A7, $C3, $AA, $A4, $A5, $A6
    db $A6, $C3, $E5, $E0, $E0, $E0, $BF, $B7, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4
    db $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_00C_76C7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $C3, $B7, $E0, $BF, $B7, $C3, $C3, $B7, $E0, $BF, $B7, $B4, $B4, $B5

Data_00C_76D6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0336D6, $99

Data_00C_776F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $C3, $B7, $BF, $C3, $B7, $C3, $C3, $B7, $BF, $C3, $B7, $B4, $B4, $B5

Data_00C_777E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $03377E, $B3

Data_00C_7831:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $CE, $CF, $DF, $B7, $B6, $C3, $C3, $C3
    db $C3, $B7, $B6, $C3, $AE, $AF, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B5

Data_00C_784F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $CA, $C3, $F2, $C3, $1A, $C4, $42, $C4

Data_00C_7857:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C9, $C3, $F1, $C3, $19, $C4, $41, $C4, $8D, $C3, $8F, $C3, $91, $C3, $8D, $C3
    db $8F, $C3, $91, $C3, $B5, $C3, $B7, $C3, $B9, $C3

Data_00C_7871:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $64, $00, $F4, $01, $E8, $03, $88, $13, $02, $04, $08, $10

Data_00C_787D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $7F, $78, $85, $78, $8B, $78, $91, $78, $83, $00, $84, $00, $83, $00, $85, $00
    db $86, $00, $87, $00, $88, $00, $89, $00, $88, $00

Data_00C_7897:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $033897, $68

Data_00C_78FF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $27, $27, $27, $27, $27, $27

Data_00C_7905:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $033905, $8F
    dw Func_00C_6601
    dw Func_00C_6701
    dw Func_00C_6801
    dw Func_00C_6901
    INCBIN "dwm2-cobi-us.gbc", $03399C, $5A
    dw Func_00C_4102
    dw Func_00C_4202
    dw Func_00C_4302
    dw Func_00C_4402
    dw Func_00C_4502
    db $02, $FF, $01, $00, $02, $01, $02, $02, $02, $03, $02, $04, $02, $46, $02, $47
    db $02, $48, $02, $49, $02, $4A, $02, $4B, $02, $4C
    dw Func_00C_4D02
    dw Func_00C_4E02
    dw Func_00C_4F02
    dw Func_00C_5002
    db $02, $51, $02, $52, $02, $53, $02, $54, $02, $55, $02, $56, $02, $57, $02, $67
    db $02, $68, $02, $69, $02, $6A, $02, $6B, $02, $6C, $02, $6D
    dw Func_00C_6E02
    dw Func_00C_6F02
    dw Func_00C_7002
    dw Func_00C_7102
    db $02, $72

Data_00C_7A48:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $02, $73, $02, $74, $02, $75, $02, $76, $02, $F7, $E4, $08, $04, $00, $07, $5F
    db $7A, $07, $FE, $7A, $07, $75, $7A, $F7, $F7, $E4, $0B, $07

Data_00C_7A64:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $033A64, $1E3
    ds $3B9, $00
