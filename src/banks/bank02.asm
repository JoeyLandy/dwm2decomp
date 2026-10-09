SECTION "Bank 02", ROMX[$4000], BANK[$02]
    db $02

Func_002_4001::
    ld a, [$C56C]
    ld b, a
    bit 7, b
    jr nz, Jump_002_401C
    ld a, $00
    ld [$C572], a
    ld a, [$C56C]
    srl a
    srl a
    ld [$C573], a
    ld [$C574], a
    ret

Jump_002_401C::
    ld a, $20
    ld [$C572], a
    ld a, [$C56D]
    bit 7, a
    jr nz, Jump_002_402D
    ld de, Data_002_7FFF
    jr Jump_002_4030

Jump_002_402D::
    ld de, $0000

Jump_002_4030::
    ld a, [$C56C]
    cpl
    srl a
    srl a
    ld [$C573], a
    ld [$C574], a
    di
    call Func_000_120A
    ld a, $80
    ldh [$FF68], a
    ei
    ld b, $20

Jump_002_4049::
    di
    call Func_000_120A
    ld a, e
    ldh [$FF69], a
    ld a, d
    ldh [$FF69], a
    ei
    dec b
    jr nz, Jump_002_4049
    di
    call Func_000_120A
    ld a, $80
    ldh [$FF6A], a
    ei
    ld b, $20

Jump_002_4062::
    di
    call Func_000_120A
    ld a, e
    ldh [$FF6B], a
    ld a, d
    ldh [$FF6B], a
    ei
    dec b
    jr nz, Jump_002_4062
    ret

Func_002_4071::
    ld a, [$C56C]
    bit 7, a
    jr nz, Jump_002_40A2
    ld a, [$C574]
    or a, a
    jr z, Jump_002_4083
    dec a
    ld [$C574], a
    ret

Jump_002_4083::
    ld a, [$C572]
    add a, $05
    cp a, $1F
    jr c, Jump_002_408E
    ld a, $1F

Jump_002_408E::
    ld [$C572], a
    call Func_002_40CF
    ld a, [$C573]
    ld [$C574], a
    ld a, [$C572]
    cp a, $1F
    jr z, Jump_002_40CA
    ret

Jump_002_40A2::
    ld a, [$C574]
    or a, a
    jr z, Jump_002_40AD
    dec a
    ld [$C574], a
    ret

Jump_002_40AD::
    ld a, [$C572]
    sub a, $05
    bit 7, a
    jr z, Jump_002_40B7
    xor a, a

Jump_002_40B7::
    ld [$C572], a
    call Func_002_41C6
    ld a, [$C573]
    ld [$C574], a
    ld a, [$C572]
    or a, a
    jr z, Jump_002_40CA
    ret

Jump_002_40CA::
    xor a, a
    ld [$C56C], a
    ret

Func_002_40CF::
    di
    call Func_000_120A
    ld a, $80
    ldh [$FF68], a
    ei
    ld hl, $C49F
    call Func_002_4149
    call Func_002_4149
    call Func_002_4149
    call Func_002_4149
    call Func_002_4149
    call Func_002_4149
    call Func_002_4149
    call Func_002_4149
    di
    call Func_000_120A
    ld a, $80
    ldh [$FF6A], a
    ei
    ld hl, $C4DF
    call Func_002_4118
    call Func_002_4118
    call Func_002_4118
    call Func_002_4118
    call Func_002_4118
    call Func_002_4118
    call Func_002_4118
    call Func_002_4118
    ret

Func_002_4118::
    call Func_002_4121
    call Func_002_4121
    call Func_002_4121

Func_002_4121::
    ld a, [$C572]
    ld d, a
    ld c, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld de, $0000
    call Func_002_4176
    call Func_002_4176
    call Func_002_4176
    rr b
    rr c
    rr d
    rr e
    di
    call Func_000_120A
    ld a, e
    ldh [$FF6B], a
    ld a, d
    ldh [$FF6B], a
    ei
    ret

Func_002_4149::
    call Func_002_4152
    call Func_002_4152
    call Func_002_4152

Func_002_4152::
    ld c, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld de, $0000
    call Func_002_4176
    call Func_002_4176
    call Func_002_4176
    rr b
    rr c
    rr d
    rr e
    di
    call Func_000_120A
    ld a, e
    ldh [$FF69], a
    ld a, d
    ldh [$FF69], a
    ei
    ret

Func_002_4176::
    push de
    ld a, [$C56D]
    bit 7, a
    jr nz, Jump_002_418B
    ld a, c
    and a, $1F
    ld d, a
    ld a, [$C572]
    cp a, d
    jr nc, Jump_002_4196
    ld a, d
    jr Jump_002_4196

Jump_002_418B::
    ld a, [$C572]
    ld d, a
    ld a, c
    and a, $1F
    sub a, d
    jr nc, Jump_002_4196
    xor a, a

Jump_002_4196::
    ld e, a
    ld a, c
    and a, $E0
    or a, e
    ld c, a
    pop de
    rr b
    rr c
    rr d
    rr e
    rr b
    rr c
    rr d
    rr e
    rr b
    rr c
    rr d
    rr e
    rr b
    rr c
    rr d
    rr e
    rr b
    rr c
    rr d
    rr e
    ret

Func_002_41C6::
    di
    call Func_000_120A
    ld a, $80
    ldh [$FF68], a
    ei
    ld hl, $C49F
    call Func_002_4240
    call Func_002_4240
    call Func_002_4240
    call Func_002_4240
    call Func_002_4240
    call Func_002_4240
    call Func_002_4240
    call Func_002_4240
    di
    call Func_000_120A
    ld a, $80
    ldh [$FF6A], a
    ei
    ld hl, $C4DF
    call Func_002_420F
    call Func_002_420F
    call Func_002_420F
    call Func_002_420F
    call Func_002_420F
    call Func_002_420F
    call Func_002_420F
    call Func_002_420F
    ret

Func_002_420F::
    call Func_002_4218
    call Func_002_4218
    call Func_002_4218

Func_002_4218::
    ld a, [$C572]
    ld d, a
    ld c, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld de, $0000
    call Func_002_426D
    call Func_002_426D
    call Func_002_426D
    rr b
    rr c
    rr d
    rr e
    di
    call Func_000_120A
    ld a, e
    ldh [$FF6B], a
    ld a, d
    ldh [$FF6B], a
    ei
    ret

Func_002_4240::
    call Func_002_4249
    call Func_002_4249
    call Func_002_4249

Func_002_4249::
    ld c, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld de, $0000
    call Func_002_426D
    call Func_002_426D
    call Func_002_426D
    rr b
    rr c
    rr d
    rr e
    di
    call Func_000_120A
    ld a, e
    ldh [$FF69], a
    ld a, d
    ldh [$FF69], a
    ei
    ret

Func_002_426D::
    push de
    ld a, [$C56D]
    bit 7, a
    jr nz, Jump_002_4285
    ld a, c
    and a, $1F
    ld d, a
    ld a, [$C572]
    add a, d
    cp a, $1F
    jr c, Jump_002_4290
    ld a, $1F
    jr Jump_002_4290

Jump_002_4285::
    ld a, [$C572]
    ld d, a
    ld a, c
    and a, $1F
    sub a, d
    jr nc, Jump_002_4290
    xor a, a

Jump_002_4290::
    ld e, a
    ld a, c
    and a, $E0
    or a, e
    ld c, a
    pop de
    rr b
    rr c
    rr d
    rr e
    rr b
    rr c
    rr d
    rr e
    rr b
    rr c
    rr d
    rr e
    rr b
    rr c
    rr d
    rr e
    rr b
    rr c
    rr d
    rr e
    ret

Func_002_42C0:: ; heuristic: follows a terminator; C0
    ld a, [$C525]
    or a, a
    ret z
    ld a, b
    add a, a
    add a, a
    add a, a
    ld b, a
    ld a, c
    add a, a
    add a, a
    add a, a
    ld de, $C49F
    add a, e
    ld e, a
    jr nc, Jump_002_42D6
    inc d

Jump_002_42D6::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_002_42D6
    ret

Func_002_42DD:: ; heuristic: follows a terminator; C0
    ld a, [$C525]
    or a, a
    ret z
    ld a, b
    add a, a
    add a, a
    add a, a
    ld b, a
    ld a, c
    add a, a
    add a, a
    add a, a
    ld de, $C4DF
    add a, e
    ld e, a
    jr nc, Jump_002_42F3
    inc d

Jump_002_42F3::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_002_42F3
    ret

Func_002_42FA::
    ld a, [$C525]
    or a, a
    ret z
    ld hl, $C49F
    ld de, Data_002_4322
    ld bc, $0008
    call Func_000_1679
    ld a, $7F
    ld [$C526], a
    ld hl, $C4DF
    ld de, Data_002_4322
    ld bc, $0008
    call Func_000_1679
    ld a, $7F
    ld [$C527], a
    ret

Data_002_4322:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $7C, $FF, $7F, $E0, $01, $00, $00

Func_002_432A::
    ld a, [$C525]
    or a, a
    ret z
    call Func_002_4345
    ld hl, $D040
    ld a, [$C5E9]
    cp a, [hl]
    jp z, Jump_002_4519
    ld a, [$C5E9]
    ld [$D040], a
    jp Jump_002_4519

Func_002_4345::
    ld a, [$D781]
    inc a
    ld [$D781], a
    bit 0, a
    jr nz, Jump_002_4351
    ret

Jump_002_4351::
    ld a, [$D780]
    cp a, $FF
    ret z
    rst $00
    dw Jump_002_4360
    dw Jump_002_43DA
    dw Jump_002_43FD
    dw Jump_002_4420

Jump_002_4360::
    ld hl, $D09D
    ld a, [$D783]
    swap a
    ld d, a
    and a, $F0
    ld e, a
    ld a, d
    and a, $0F
    ld d, a
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld de, $FF68
    ld a, $80
    ld [de], a
    inc de

Func_002_4380::
    di

Jump_002_4381::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_002_4381
    ld a, [hl+]
    ld [de], a
    ld a, [hl+]
    ld [de], a

Jump_002_438B::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_002_438B
    ld a, [hl+]
    ld [de], a
    ld a, [hl+]
    ld [de], a

Jump_002_4395::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_002_4395
    ld a, [hl+]
    ld [de], a
    ld a, [hl+]
    ld [de], a

Jump_002_439F::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_002_439F
    ld a, [hl+]
    ld [de], a
    ld a, [hl+]
    ld [de], a

Jump_002_43A9::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_002_43A9
    ld a, [hl+]
    ld [de], a
    ld a, [hl+]
    ld [de], a

Jump_002_43B3::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_002_43B3
    ld a, [hl+]
    ld [de], a
    ld a, [hl+]
    ld [de], a

Jump_002_43BD::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_002_43BD
    ld a, [hl+]
    ld [de], a
    ld a, [hl+]
    ld [de], a

Jump_002_43C7::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_002_43C7
    ld a, [hl+]
    ld [de], a
    ld a, [hl+]
    ld [de], a
    ei
    ld a, [$D780]
    inc a
    ld [$D780], a
    ret

Jump_002_43DA::
    ld hl, $D0AD
    ld a, [$D783]
    swap a
    ld d, a
    and a, $F0
    ld e, a
    ld a, d
    and a, $0F
    ld d, a
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld de, $FF68
    ld a, $90
    ld [de], a
    inc de
    jp Func_002_4380

Jump_002_43FD::
    ld hl, $D0BD
    ld a, [$D783]
    swap a
    ld d, a
    and a, $F0
    ld e, a
    ld a, d
    and a, $0F
    ld d, a
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld de, $FF68
    ld a, $A0
    ld [de], a
    inc de
    jp Func_002_4380

Jump_002_4420::
    ld hl, $D0CD
    ld a, [$D783]
    swap a
    ld d, a
    and a, $F0
    ld e, a
    ld a, d
    and a, $0F
    ld d, a
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld de, $FF68
    ld a, $B0
    ld [de], a
    inc de
    call Func_002_4380
    ld a, [$D783]
    inc a
    ld [$D783], a
    cp a, $08
    jr c, Jump_002_445B
    xor a, a
    ld [$D782], a
    ld [$D783], a
    ld a, $FF
    ld [$D780], a
    ret

Jump_002_445B::
    xor a, a
    ld [$D782], a
    ld [$D780], a
    ret

Func_002_4463::
    ld hl, $C49F
    ld de, $D09D
    ld c, $04

Jump_002_446B::
    push bc
    push hl
    push de
    call Func_002_449A
    pop de
    pop hl
    pop bc
    ld a, $10
    add a, e
    ld e, a
    jr nc, Jump_002_447B
    inc d

Jump_002_447B::
    ld a, $10
    add a, l
    ld l, a
    jr nc, Jump_002_4482
    inc h

Jump_002_4482::
    dec c
    jr nz, Jump_002_446B
    ld c, $04
    ld hl, $C49F
    ld a, [$D783]
    inc a
    ld [$D783], a
    cp a, $08
    jr c, Jump_002_446B
    xor a, a
    ld [$D783], a
    ret

Func_002_449A::
    ld c, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld a, b
    srl a
    srl a
    ld [$D7C4], a
    push bc
    sla c
    rl b
    sla c
    rl b
    sla c
    rl b
    ld a, b
    and a, $1F
    ld [$D7C5], a
    pop bc
    ld a, c
    and a, $1F
    ld [$D7C6], a
    push hl
    ld hl, Data_002_4510
    ld a, [$D783]
    add a, l
    ld l, a
    jr nc, Jump_002_44CC
    inc h

Jump_002_44CC::
    ld b, [hl]
    ld hl, $D7C4
    ld c, $03

Jump_002_44D2::
    ld a, [hl]
    add a, b
    cp a, $20
    jr c, Jump_002_44DA
    ld a, $1F

Jump_002_44DA::
    ld [hl+], a
    dec c
    jr nz, Jump_002_44D2
    pop hl
    ld a, [$D7C4]
    ld b, a
    ld a, [$D7C5]
    sla a
    sla a
    sla a
    ld c, a
    sla c
    rl b
    sla c
    rl b
    ld a, [$D7C6]
    or a, c
    ld c, a
    ld a, c
    ld [de], a
    inc de
    ld a, b
    ld [de], a
    inc de
    ld a, [$D782]
    inc a
    ld [$D782], a
    cp a, $08
    jr c, Func_002_449A
    xor a, a
    ld [$D782], a
    ret

Data_002_4510:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $04, $08, $0C, $10, $14, $18, $1C, $20, $24

Jump_002_4519::
    ld hl, $D041
    ld a, [$C5EA]
    cp a, [hl]
    jp z, Jump_002_45C1
    ld a, [$C5EA]
    ld [$D041], a
    jp Jump_002_45C1

Func_002_452C:: ; heuristic: follows a terminator; C0
    push hl
    ld a, [$C5EA]
    and a, $03
    ld de, Data_002_45C2
    add a, e
    ld e, a
    jr nc, Jump_002_453A
    inc d

Jump_002_453A::
    ld a, [de]
    add a, l
    ld l, a
    jr nc, Jump_002_4540
    inc h

Jump_002_4540::
    di
    call Func_000_120A
    ld a, [hl+]
    ldh [$FF6B], a
    ld a, [hl]
    ldh [$FF6B], a
    ei
    pop hl
    push hl
    ld a, [$C5EA]
    srl a
    srl a
    and a, $03
    ld de, Data_002_45C2
    add a, e
    ld e, a
    jr nc, Jump_002_455E
    inc d

Jump_002_455E::
    ld a, [de]
    add a, l
    ld l, a
    jr nc, Jump_002_4564
    inc h

Jump_002_4564::
    di
    call Func_000_120A
    ld a, [hl+]
    ldh [$FF6B], a
    ld a, [hl]
    ldh [$FF6B], a
    ei
    pop hl
    push hl
    ld a, [$C5EA]
    swap a
    and a, $03
    ld de, Data_002_45C2
    add a, e
    ld e, a
    jr nc, Jump_002_4580
    inc d

Jump_002_4580::
    ld a, [de]
    add a, l
    ld l, a
    jr nc, Jump_002_4586
    inc h

Jump_002_4586::
    di
    call Func_000_120A
    ld a, [hl+]
    ldh [$FF6B], a
    ld a, [hl]
    ldh [$FF6B], a
    ei
    pop hl
    push hl
    ld a, [$C5EA]
    swap a
    srl a
    srl a
    and a, $03
    ld de, Data_002_45C2
    add a, e
    ld e, a
    jr nc, Jump_002_45A6
    inc d

Jump_002_45A6::
    ld a, [de]
    add a, l
    ld l, a
    jr nc, Jump_002_45AC
    inc h

Jump_002_45AC::
    di
    call Func_000_120A
    ld a, [hl+]
    ldh [$FF6B], a
    ld a, [hl]
    ldh [$FF6B], a
    ei
    pop hl
    ld a, l
    add a, $08
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ret

Jump_002_45C1::
    ret

Data_002_45C2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $02, $04, $00, $06

Func_002_45C6::
    call Func_000_08A6
    xor a, a
    ldh [$FF0F], a
    ldh a, [$FF90]
    cp a, $38
    jr nz, Jump_002_45DB
    ldh a, [$FF8F]
    ld c, a
    ldh a, [$FF92]
    or a, c
    call z, Func_000_3290

Jump_002_45DB::
    ld a, [$C88D]
    or a, a
    call nz, Func_000_3290
    call Func_002_4AB5
    call Func_000_13E5
    ld b, $46
    ld de, Func_002_4001
    ld hl, $8800
    call Func_000_0CF5
    ld hl, Data_002_4AD6
    ld a, [hl]
    ld [$C51F], a
    ld hl, Data_002_4AD7
    ld a, [hl]
    ld [$C520], a
    ld hl, Func_017_41CF
    ld b, $17
    rst $10
    call Func_002_4628
    xor a, a
    ld [$C8C5], a
    ld a, [$C5E0]
    or a, a
    jr nz, Jump_002_461A
    call Func_000_3290
    call Func_002_604B

Jump_002_461A::
    xor a, a
    ld [$C5E0], a
    ld a, $03
    ld [$C5EC], a
    ld a, $03
    jp Jump_000_077A

Func_002_4628::
    ld a, $0F
    ldh [$FF8D], a
    call Func_000_1C0C
    ld a, $00
    ldh [$FFA5], a
    ld a, $00
    ldh [$FFA1], a
    ld a, $80
    ldh [$FFA0], a
    ld a, $07
    ldh [$FF9F], a
    ld a, $67
    ldh [$FF45], a
    xor a, a
    ld [$C5F0], a
    ld [$C5F1], a
    ld a, $00
    ld [$C5E1], a
    di
    call Func_000_120A
    ld a, $40
    ldh [$FF41], a
    xor a, a
    ldh [$FF0F], a
    ei
    call Func_002_5E85
    call Func_002_5E85
    ld hl, Func_060_639D
    ld b, $60
    rst $10
    ld hl, Func_060_62F9
    ld b, $60
    rst $10
    call Func_002_470B
    ld a, [$CC44]
    bit 7, a
    jr nz, Jump_002_467D
    ldh a, [$FF90]
    cp a, $14
    jr z, Jump_002_4680

Jump_002_467D::
    call Func_000_222B

Jump_002_4680::
    ld hl, Func_004_4AA8
    ld b, $04
    rst $10
    ld hl, Func_012_70A4
    ld b, $12
    rst $10
    ld hl, Func_012_710A
    ld b, $12
    rst $10
    xor a, a
    ld [$C468], a
    ld a, [$C8C7]
    or a, a
    jr nz, Jump_002_46B3
    call Func_000_19A9
    ld hl, Func_069_4001
    ld b, $69
    rst $10
    ld hl, Func_085_5B53
    ld b, $85
    rst $10
    ld hl, Func_012_7BB0
    ld b, $12
    rst $10
    jr Jump_002_46BC

Jump_002_46B3::
    call Func_002_5F22
    ld hl, Func_085_5B53
    ld b, $85
    rst $10

Jump_002_46BC::
    ld hl, $9800
    call Func_000_1E29
    xor a, a
    ld [$CBCF], a
    ld hl, Func_012_6A6A
    ld b, $12
    rst $10
    xor a, a
    ld [$C8CB], a
    ld [$C8CC], a
    ld [$C8CD], a
    ld [$C8CE], a
    ld a, [$C927]
    bit 7, a
    jr z, Jump_002_46EE
    and a, $7F
    ldh [$FFC6], a
    ld hl, Func_012_6B98
    ld b, $12
    rst $10
    xor a, a
    ld [$C927], a

Jump_002_46EE::
    ld a, [$C5E0]
    or a, a
    jr nz, Jump_002_46F7
    call Func_002_604B

Jump_002_46F7::
    call Func_002_5F9B
    call Func_002_4745
    xor a, a
    ldh [$FF8D], a
    ld a, [$C525]
    or a, a
    ret z
    ld a, $7F
    ld [$C527], a
    ret

Func_002_470B::
    ld hl, $C60C
    ld de, $C130
    ld bc, $000A
    call Func_000_0952
    ld a, $F0
    ld [$C13A], a
    ld de, $0000
    call Func_000_181B
    jp nc, Jump_002_4735
    ld a, $58
    ld [$C13C], a
    ld a, $87
    ld [$C13D], a
    ld a, $F0
    ld [$C13E], a
    ret

Jump_002_4735::
    ld a, $87
    ld [$C13C], a
    ld a, $60
    ld [$C13D], a
    ld a, $F0
    ld [$C13E], a
    ret

Func_002_4745::
    ld a, [$C8C7]
    and a, $03
    rst $00
    dw Jump_002_4753
    dw Jump_002_48C3
    dw Jump_002_4798
    dw Jump_002_4753

Jump_002_4753::
    xor a, a
    ld [$C8C7], a
    ld a, [$C5DC]
    cp a, $06
    jr nz, Jump_002_4768
    ld a, $05
    ld [$C46B], a
    xor a, a
    ld [$C46C], a
    ret

Jump_002_4768::
    xor a, a
    ld [$C5DC], a
    ld a, [$C91F]
    or a, a
    jr z, Jump_002_4779
    ld a, $01
    ld [$C5DC], a
    jr Jump_002_4786

Jump_002_4779::
    ld a, [$CC44]
    bit 7, a
    jp z, Jump_002_4786
    ld a, $05
    ld [$C5DC], a

Jump_002_4786::
    ld a, [$C524]
    or a, a
    jr z, Jump_002_4792
    ld a, [$C5E0]
    cp a, $02
    ret z

Jump_002_4792::
    ld a, $FC
    call Func_000_0DF2
    ret

Jump_002_4798::
    ld a, [$CFC5]
    cp a, $05
    jp z, Jump_002_48AE
    ld a, [$D092]
    or a, a
    jr z, Jump_002_4753
    cp a, $03
    jp z, Jump_002_4846
    cp a, $02
    jr nz, Jump_002_47B6
    ld a, [$CFC5]
    cp a, $04
    jr nz, Jump_002_4753

Jump_002_47B6::
    ld a, [$CFC5]
    cp a, $04
    jp z, Jump_002_4846
    cp a, $06
    jr z, Jump_002_47C6
    cp a, $07
    jr nz, Jump_002_47CB

Jump_002_47C6::
    call Func_002_4A53
    jr Jump_002_4753

Jump_002_47CB::
    xor a, a
    ld [$C8C7], a
    ld a, $05
    ldh [$FF90], a
    ld a, $01
    ldh [$FF8F], a
    xor a, a
    ldh [$FF92], a
    ld c, $03
    push bc
    ld de, $0025
    call Func_000_181B
    pop bc
    jr nc, Jump_002_47E8
    ld c, $02

Jump_002_47E8::
    ld a, c
    ldh [$FF98], a
    ld [$C8EF], a
    ld [$C8F4], a
    ld [$C8F9], a
    ld a, $50
    ldh [$FF8E], a
    ld [$C8F0], a
    ld [$C8F5], a
    ld [$C8FA], a
    ld a, $30
    ldh [$FF91], a
    ld [$C8F1], a
    ld [$C8F6], a
    ld [$C8FB], a
    ldh a, [$FF8C]
    and a, $F7
    ldh [$FF8C], a
    xor a, a
    ldh [$FF93], a
    ld a, [$CC44]
    bit 7, a
    jr z, Jump_002_4824
    ld hl, Func_060_6C96
    ld b, $60
    rst $10

Jump_002_4824::
    xor a, a
    ld [$CC44], a
    ld hl, Func_002_6050
    ld b, $02
    rst $10
    xor a, a
    ld [$C917], a
    ld a, $05
    ld [$C916], a
    ld hl, Func_013_405C
    ld b, $13
    rst $10
    ld hl, Func_010_4008
    ld b, $10
    rst $10
    jp Func_002_4628

Jump_002_4846::
    ld hl, Func_012_64F8
    ld b, $12
    rst $10
    xor a, a
    ld [$C8C7], a
    ld a, $04
    ldh [$FF90], a
    ld a, $01
    ldh [$FF8F], a
    xor a, a
    ldh [$FF92], a
    ld a, $02
    ldh [$FF98], a
    ldh [$FF98], a
    ld [$C8F4], a
    ld [$C8F9], a
    ld a, $40
    ldh [$FF8E], a
    ld [$C8F0], a
    ld [$C8F5], a
    ld [$C8FA], a
    ld a, $30
    ldh [$FF91], a
    ld [$C8F1], a
    ld [$C8F6], a
    ld [$C8FB], a
    ld a, $01
    ld [$C917], a
    ld a, $65
    ld [$C916], a
    ld a, [$C91C]
    ld [$C919], a
    ld a, [$C91D]
    ld [$C91A], a
    ld a, [$C91E]
    ld [$C91B], a
    ld a, $02
    ldh [$FFB9], a
    ld a, $F7
    ld [$C920], a
    ld a, $01
    ld [$D7FD], a
    jp Func_002_4628

Jump_002_48AE::
    ld hl, Func_012_64F8
    ld b, $12
    rst $10
    call Func_002_5E82
    call Func_000_222B
    ld hl, Func_004_4AA8
    ld b, $04
    rst $10
    jp Jump_002_4753

Jump_002_48C3::
    xor a, a
    ld [$C8C7], a
    call Func_002_4A7A
    ld a, [$D067]
    cp a, $40
    jr nz, Jump_002_48D9
    push af
    xor a, a
    ld [$C5E0], a
    pop af
    jr Jump_002_48EF

Jump_002_48D9::
    or a, a
    jr nz, Jump_002_48EF
    ld a, [$C562]
    set 0, a
    ld [$C562], a
    ld a, $01
    ldh [$FFCE], a
    ld hl, Func_002_64E5
    ld b, $02
    rst $10
    ret

Jump_002_48EF::
    and a, $BF
    push af
    xor a, a
    ld [$C5DC], a
    ld a, [$CC44]
    bit 7, a
    jr z, Jump_002_4902
    ld a, $05
    ld [$C5DC], a

Jump_002_4902::
    pop af
    bit 7, a
    jr z, Jump_002_4945
    and a, $7F
    ld [$C833], a
    ld a, $80
    ld [$C914], a
    xor a, a
    ld [$D067], a
    ld a, [$C833]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $0A
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    ld a, [hl]
    bit 7, a
    jr z, Jump_002_4938
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    cp a, $01
    jr z, Jump_002_4938
    ld de, $0020
    call Func_000_1845

Jump_002_4938::
    ld a, $06
    ld [$C5DC], a
    xor a, a
    ld [$C46B], a
    ld [$C46C], a
    ret

Jump_002_4945::
    or a, a
    ret z
    dec a
    jr nz, Jump_002_495E
    xor a, a
    ld [$D067], a
    ld a, $19
    ld [$C916], a
    xor a, a
    ld [$C917], a
    ld hl, Func_013_405C
    ld b, $13
    rst $10
    ret

Jump_002_495E::
    dec a
    jr nz, Jump_002_497E
    call Func_002_4A2C
    ld a, $02
    call Func_000_122D
    ld a, $67
    call Func_000_1278
    ld a, $08
    ld [$C916], a
    xor a, a
    ld [$C917], a
    ld hl, Func_013_405C
    ld b, $13
    rst $10
    ret

Jump_002_497E::
    dec a
    jr nz, Jump_002_499E
    call Func_002_4A2C
    ld a, $02
    call Func_000_122D
    ld a, $67
    call Func_000_1278
    ld a, $06
    ld [$C916], a
    xor a, a
    ld [$C917], a
    ld hl, Func_013_405C
    ld b, $13
    rst $10
    ret

Jump_002_499E::
    dec a
    jr nz, Jump_002_49BE
    call Func_002_4A2C
    ld a, $02
    call Func_000_122D
    ld a, $67
    call Func_000_1278
    ld a, $07
    ld [$C916], a
    xor a, a
    ld [$C917], a
    ld hl, Func_013_405C
    ld b, $13
    rst $10
    ret

Jump_002_49BE::
    dec a
    jr nz, Jump_002_49D2
    ld a, $39
    ld [$C916], a
    ld a, $02
    ld [$C917], a
    ld hl, Func_013_405C
    ld b, $13
    rst $10
    ret

Jump_002_49D2::
    dec a
    jr nz, Jump_002_49E6
    ld a, $6A
    ld [$C916], a
    ld a, $03
    ld [$C917], a
    ld hl, Func_013_405C
    ld b, $13
    rst $10
    ret

Jump_002_49E6::
    dec a
    jr nz, Jump_002_49FA
    ld a, $A1
    ld [$C916], a
    ld a, $04
    ld [$C917], a
    ld hl, Func_013_405C
    ld b, $13
    rst $10
    ret

Jump_002_49FA::
    dec a
    jr nz, Jump_002_4A0E
    ld a, $AA
    ld [$C916], a
    ld a, $04
    ld [$C917], a
    ld hl, Func_013_405C
    ld b, $13
    rst $10
    ret

Jump_002_4A0E::
    dec a
    jr nz, Jump_002_4A1C
    xor a, a
    ld [$D067], a
    ld hl, Func_084_4A89
    ld b, $84
    rst $10
    ret

Jump_002_4A1C::
    ld a, $09
    ld [$C916], a
    xor a, a
    ld [$C917], a
    ld hl, Func_013_405C
    ld b, $13
    rst $10
    ret

Func_002_4A2C::
    xor a, a
    ldh [$FF98], a
    ld [$C8EF], a
    ld [$C8F4], a
    ld [$C8F9], a
    ldh a, [$FF8E]
    ld [$C8F0], a
    ld [$C8F5], a
    ld [$C8FA], a
    ldh a, [$FF91]
    ld [$C8F1], a
    ld [$C8F6], a
    ld [$C8FB], a
    xor a, a
    ld [$D067], a
    ret

Func_002_4A53::
    ld a, $0A
    ld [$0100], a
    ld a, [$C6FE]
    ld c, $55
    call Func_000_1FD1
    ld [hl], $00
    ld a, [$C6FE]
    ld c, $5B
    call Func_000_1FD1
    ld [hl], $01
    inc hl
    ld [hl], $00
    xor a, a
    ld [$0100], a
    ld hl, Func_004_4AA8
    ld b, $04
    rst $10
    ret

Func_002_4A7A::
    ld a, [$CC44]
    bit 7, a
    ret nz
    ldh a, [$FF90]
    cp a, $00
    ret nz
    ldh a, [$FF8F]
    or a, a
    ret nz
    ldh a, [$FF92]
    cp a, $03
    ret nz
    ld a, [$CECE]
    cp a, $01
    ret nz
    ld a, [$CF8B]
    cp a, $FF
    jr z, Jump_002_4AA1
    ld a, $80
    ld [$CBCF], a
    ret

Jump_002_4AA1::
    xor a, a
    ld [$CF8B], a
    ld a, $15
    ldh [$FFC6], a
    ld hl, Func_012_6B98
    ld b, $12
    rst $10
    ld a, $80
    ld [$CBCF], a
    ret

Func_002_4AB5::
    ld a, [$CC44]
    bit 7, a
    jr nz, Jump_002_4AC5
    ldh a, [$FF90]
    cp a, $20
    jr nc, Jump_002_4AC5

Jump_002_4AC2::
    ld a, $02
    ret

Jump_002_4AC5::
    cp a, $38
    jr nz, Jump_002_4AD3
    ldh a, [$FF8F]
    or a, a
    jr nz, Jump_002_4AD3
    ldh a, [$FF92]
    or a, a
    jr z, Jump_002_4AC2

Jump_002_4AD3::
    ld a, $04
    ret

Data_002_4AD6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00

Data_002_4AD7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00

Func_002_4AD8::
    ld a, [$C5E0]
    cp a, $02
    jp z, Jump_002_5FF7

Func_002_4AE0::
    call Func_002_5F59
    ld a, [$C5DC]
    and a, $0F
    rst $00
    dw Jump_002_4AFB
    dw Jump_002_4B5D
    dw Jump_002_4B95
    dw Jump_002_4BB1
    dw Jump_002_4BCD
    dw Jump_002_4D28
    dw Jump_002_4D86
    dw Jump_002_4D99
    dw Jump_002_4DCC

Jump_002_4AFB::
    ld a, [$C56C]
    or a, a
    jp nz, Jump_002_4B44
    ld a, [$C562]
    bit 2, a
    jr z, Jump_002_4B13
    ld hl, Func_0A1_5903
    ld b, $A1
    rst $10
    ldh a, [$FFC6]
    or a, a
    ret nz

Jump_002_4B13::
    ld hl, Func_087_4001
    ld b, $87
    rst $10
    call Func_002_5B2A
    call Func_002_541B
    call Func_002_5BD7
    ld a, [$C562]
    bit 0, a
    jr z, Jump_002_4B44
    call Func_002_4FE8
    ld hl, Func_012_7333
    ld b, $12
    rst $10
    ld hl, Func_087_42A0
    ld b, $87
    rst $10
    call Func_002_4DED
    xor a, a
    ldh [$FFCE], a
    ld hl, Func_002_64E5
    ld b, $02
    rst $10

Jump_002_4B44::
    ld hl, Func_012_6EC6
    ld b, $12
    rst $10
    ld hl, Func_004_4001
    ld b, $04
    rst $10
    ld hl, Func_012_6893
    ld b, $12
    rst $10
    call Func_002_5074
    call Func_002_4DD6
    ret

Jump_002_4B5D::
    ld hl, Func_010_4001
    ld b, $10
    rst $10
    ld hl, Func_002_69D0
    ld b, $02
    rst $10
    ld a, [$C920]
    cp a, $05
    jr z, Jump_002_4B76
    cp a, $83
    jr z, Jump_002_4B76
    jr Jump_002_4B7C

Jump_002_4B76::
    call Func_002_541B
    call Func_002_5BD7

Jump_002_4B7C::
    ld hl, Func_012_6EC6
    ld b, $12
    rst $10
    ld hl, Func_004_4001
    ld b, $04
    rst $10
    ld hl, Func_012_6893
    ld b, $12
    rst $10
    call Func_002_5074
    call Func_002_4DD6
    ret

Jump_002_4B95::
    call Func_002_6391
    ld hl, Func_012_6EC6
    ld b, $12
    rst $10
    ld hl, Func_004_4001
    ld b, $04
    rst $10
    ld hl, Func_012_6893
    ld b, $12
    rst $10
    call Func_002_5074
    call Func_002_4DD6
    ret

Jump_002_4BB1::
    ld hl, Func_00A_51FD
    ld b, $0A
    rst $10
    ld hl, Func_012_6EC6
    ld b, $12
    rst $10
    ld hl, Func_004_4001
    ld b, $04
    rst $10
    ld hl, Func_012_6893
    ld b, $12
    rst $10
    call Func_002_5074
    ret

Jump_002_4BCD::
    ld hl, Func_012_6EC6
    ld b, $12
    rst $10
    ld hl, Func_004_4BB0
    ld b, $04
    rst $10
    ld hl, Func_012_6893
    ld b, $12
    rst $10
    call Func_002_5074
    ld a, [$C56C]
    or a, a
    ret nz
    ld a, [$C8C5]
    and a, $7F
    jp nz, Jump_002_4C18
    ld a, $FF
    ld [$C8FE], a
    ld hl, Func_060_65AA
    ld b, $60
    rst $10
    ld a, [$C8CA]
    cp a, $F0
    jr nz, Jump_002_4C14
    push af
    ld a, $80
    ld [$CC44], a
    ld a, [$CD0D]
    ld [$C190], a
    ld a, [$CD0E]
    ld [$C191], a
    pop af

Jump_002_4C14::
    call Func_002_4C4E
    ret

Jump_002_4C18::
    ld a, [$C8C5]
    bit 7, a
    jr z, Jump_002_4C3F
    ld a, $01
    ld [$C5DB], a
    ld hl, $C5DF
    inc [hl]
    xor a, a
    ld [$C5E0], a
    ld a, [$CC44]
    bit 7, a
    jr nz, Jump_002_4C39
    ld a, $00
    ld [$C5DC], a
    ret

Jump_002_4C39::
    ld a, $05
    ld [$C5DC], a
    ret

Jump_002_4C3F::
    ld hl, $C5E0
    inc [hl]
    call Func_002_6050
    xor a, a
    ld [$C8C7], a
    call Func_002_4628
    ret

Func_002_4C4E::
    ld a, [$C8C6]
    or a, a
    jr z, Jump_002_4C57
    dec a
    ldh [$FF98], a

Jump_002_4C57::
    ld a, [$C957]
    or a, a
    jr z, Jump_002_4C82
    xor a, a
    ld [$C957], a
    ld de, $0025
    call Func_000_181B
    jr nc, Jump_002_4C6D
    ld a, $02
    ldh [$FF98], a

Jump_002_4C6D::
    xor a, a
    ld [$CC44], a
    ldh a, [$FF8C]
    and a, $B7
    ldh [$FF8C], a
    ld a, $05
    ldh [$FF90], a
    ld a, $01
    ldh [$FF8F], a
    xor a, a
    ldh [$FF92], a

Jump_002_4C82::
    ld a, [$C936]
    or a, a
    jr nz, Jump_002_4CDA
    ld a, [$C8C8]
    ldh [$FF8E], a
    ld a, [$C8C9]
    ldh [$FF91], a
    ldh a, [$FF98]
    ld [$C8EF], a
    ld [$C8F4], a
    ld [$C8F9], a
    ldh a, [$FF8E]
    ld [$C8F0], a
    ld [$C8F5], a
    ld [$C8FA], a
    ldh a, [$FF91]
    ld [$C8F1], a
    ld [$C8F6], a
    ld [$C8FB], a
    ldh a, [$FF8C]
    and a, $F9
    ldh [$FF8C], a
    ld hl, $C8C5
    inc [hl]
    ld a, [$CC44]
    bit 7, a
    ret nz
    ldh a, [$FF90]
    cp a, $05
    ret nz
    ldh a, [$FF8C]
    and a, $F7
    ldh [$FF8C], a
    xor a, a
    ld [$CC44], a
    xor a, a
    ldh [$FF93], a
    xor a, a
    ld [$C950], a
    ret

Jump_002_4CDA::
    ld a, [$C938]
    ldh [$FF8E], a
    ld a, [$C939]
    ldh [$FF91], a
    ld a, [$C93A]
    ldh [$FF98], a
    ld a, [$C93B]
    ld [$C8EF], a
    ld a, [$C93C]
    ld [$C8F0], a
    ld a, [$C93D]
    ld [$C8F1], a
    ld a, [$C93E]
    ld [$C8F4], a
    ld a, [$C93F]
    ld [$C8F5], a
    ld a, [$C940]
    ld [$C8F6], a
    ld a, [$C941]
    ld [$C8F9], a
    ld a, [$C942]
    ld [$C8FA], a
    ld a, [$C943]
    ld [$C8FB], a
    xor a, a
    ld [$C936], a
    ld hl, $C8C5
    inc [hl]
    ret

Jump_002_4D28::
    ld a, [$C56C]
    or a, a
    jr nz, Jump_002_4D6D
    ld a, [$C562]
    bit 2, a
    jr z, Jump_002_4D3F
    ld hl, Func_0A1_5903
    ld b, $A1
    rst $10
    ldh a, [$FFC6]
    or a, a
    ret nz

Jump_002_4D3F::
    call Func_002_541B
    call Func_002_5BD7
    ld a, [$C562]
    bit 0, a
    jr z, Jump_002_4D6D
    call Func_002_4F4C
    ld hl, Func_012_7333
    ld b, $12
    rst $10
    ld hl, Func_012_73F3
    ld b, $12
    rst $10
    ld hl, Func_087_42A0
    ld b, $87
    rst $10
    call Func_002_4DED
    xor a, a
    ldh [$FFCE], a
    ld hl, Func_002_64E5
    ld b, $02
    rst $10

Jump_002_4D6D::
    ld hl, Func_012_6EC6
    ld b, $12
    rst $10
    ld hl, Func_004_4001
    ld b, $04
    rst $10
    ld hl, Func_012_6893
    ld b, $12
    rst $10
    call Func_002_5074
    call Func_002_4DD6
    ret

Jump_002_4D86::
    ld hl, Func_002_6C40
    ld b, $02
    rst $10
    ld a, [$C46C]
    or a, a
    jr nz, Jump_002_4D98
    ld hl, Func_004_4001
    ld b, $04
    rst $10

Jump_002_4D98::
    ret

Jump_002_4D99::
    ld hl, Func_00A_4001
    ld b, $0A
    rst $10
    ld hl, Func_004_4001
    ld b, $04
    rst $10
    ld hl, Func_012_722A
    ld b, $12
    rst $10
    ld a, [$C5DC]
    cp a, $07
    ret z
    xor a, a
    ld [$C91F], a
    ld hl, Func_00A_43EC
    ld b, $0A
    rst $10
    ld hl, Func_012_73A1
    ld b, $12
    rst $10
    ld hl, Func_011_4130
    ld b, $11
    rst $10
    xor a, a
    ld [$C8BF], a
    ret

Jump_002_4DCC::
    ld hl, Func_0A1_4519
    ld b, $A1
    rst $10
    call Func_002_4DD6
    ret

Func_002_4DD6::
    ld a, [$CE9D]
    cp a, $3B
    ret nz
    ld a, [$CE9C]
    and a, a
    ret nz
    ld a, [$CE9B]
    and a, a
    ret nz
    ld hl, Func_0F0_72B4
    ld b, $F0
    rst $10
    ret

Func_002_4DED::
    ld a, [$C195]
    or a, a
    ret z
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
    ld a, [$C562]
    bit 0, a
    ret z
    ldh a, [$FF8E]
    ld b, a
    ldh a, [$FF91]
    ld c, a
    ldh a, [$FF98]
    or a, a
    jr z, Jump_002_4E27
    dec a
    jr z, Jump_002_4E30
    dec a
    jr z, Jump_002_4E39
    ld a, b
    or a, a
    ret z
    sub a, $10
    ld b, a
    jr Jump_002_4E3F

Jump_002_4E27::
    ld a, c
    cp a, $80
    ret z
    add a, $10
    ld c, a
    jr Jump_002_4E3F

Jump_002_4E30::
    ld a, b
    cp a, $90
    ret z
    add a, $10
    ld b, a
    jr Jump_002_4E3F

Jump_002_4E39::
    ld a, c
    or a, a
    ret z
    sub a, $10
    ld c, a

Jump_002_4E3F::
    call Func_002_59CD
    ld a, [$C195]
    and a, $F0
    jr z, Jump_002_4E59
    swap a
    call Func_002_4E71
    or a, a
    jr z, Jump_002_4E59
    ld [$C934], a
    call Func_002_4E9E
    or a, a
    ret nz

Jump_002_4E59::
    ld a, [$C195]
    and a, $0F
    ret z
    ldh a, [$FF8C]
    bit 3, a
    jr nz, Jump_002_4E6D
    call Func_002_4E7E
    or a, a
    ret z
    ld [$C934], a

Jump_002_4E6D::
    call Func_002_4ED6
    ret

Func_002_4E71::
    ld de, $001F
    call Func_000_181B
    jr c, Jump_002_4E7B
    xor a, a
    ret

Jump_002_4E7B::
    ld a, $01
    ret

Func_002_4E7E::
    ld a, [$C195]
    and a, $0F
    cp a, $01
    jr nz, Jump_002_4E91
    ld de, $001D
    call Func_000_181B
    jr c, Jump_002_4E9B
    jr Jump_002_4E99

Jump_002_4E91::
    ld de, $001E
    call Func_000_181B
    jr c, Jump_002_4E9B

Jump_002_4E99::
    xor a, a
    ret

Jump_002_4E9B::
    ld a, $01
    ret

Func_002_4E9E::
    ldh a, [$FF8C]
    bit 3, a
    jr z, Jump_002_4EA6

Jump_002_4EA4::
    xor a, a
    ret

Jump_002_4EA6::
    ld a, [$C197]
    ld c, a
    ld a, [$C910]
    cp a, c
    jr nz, Jump_002_4EA4
    ld a, $02
    ld [$C916], a
    xor a, a
    ld [$C917], a
    ld hl, Func_013_405C
    ld b, $13
    rst $10
    xor a, a
    ld [$C55E], a
    ld [$C562], a
    ld a, [$C8CD]
    bit 7, a
    jr z, Jump_002_4ED3
    ld hl, Func_002_5B9E
    ld b, $02
    rst $10

Jump_002_4ED3::
    ld a, $01
    ret

Func_002_4ED6::
    ldh a, [$FF8C]
    bit 3, a
    jr nz, Jump_002_4F13
    ld de, $C910
    ld b, $04

Jump_002_4EE1::
    ld a, [de]
    inc de
    ld c, a
    ld a, [$C196]
    cp a, c
    jr c, Jump_002_4EEC
    jr Jump_002_4EF0

Jump_002_4EEC::
    dec b
    jr nz, Jump_002_4EE1
    ret

Jump_002_4EF0::
    ld a, $01
    ld [$C916], a
    xor a, a
    ld [$C917], a
    ld hl, Func_013_405C
    ld b, $13
    rst $10
    xor a, a
    ld [$C55E], a
    ld [$C562], a
    ld a, [$C8CD]
    bit 7, a
    ret z
    ld hl, Func_002_5B9E
    ld b, $02
    rst $10
    ret

Jump_002_4F13::
    ld de, $C910
    ld b, $04

Jump_002_4F18::
    ld a, [de]
    inc de
    ld c, a
    ld a, [$C192]
    cp a, c
    jr c, Jump_002_4F23
    jr Jump_002_4F28

Jump_002_4F23::
    dec b
    jr nz, Jump_002_4F18
    jr Jump_002_4F29

Jump_002_4F28::
    ret

Jump_002_4F29::
    ld a, $01
    ld [$C916], a
    xor a, a
    ld [$C917], a
    ld hl, Func_013_405C
    ld b, $13
    rst $10
    xor a, a
    ld [$C55E], a
    ld [$C562], a
    ld a, [$C8CD]
    bit 7, a
    ret z
    ld hl, Func_002_5B9E
    ld b, $02
    rst $10
    ret

Func_002_4F4C::
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
    ld a, [$C562]
    bit 0, a
    ret z
    ld a, [$CC44]
    and a, $07
    rst $00
    dw Jump_002_4F7E
    dw Jump_002_4F7E
    dw Jump_002_4F7E
    dw Jump_002_4F7F
    dw Jump_002_4F7E
    dw Jump_002_4F7E
    dw Jump_002_4F7E
    dw Jump_002_4FAB

Jump_002_4F7E::
    ret

Jump_002_4F7F::
    ld a, [$CC45]
    add a, a
    add a, a
    ld hl, $CD89
    add a, l
    ld l, a
    jr nc, Jump_002_4F8C
    inc h

Jump_002_4F8C::
    ld a, [hl]
    cp a, $06
    jr z, Jump_002_4FAA
    cp a, $01
    ret nz
    ldh a, [$FF98]
    cp a, $02
    ret nz
    ldh a, [$FF92]
    cp a, $01
    ret nz
    ldh a, [$FF8E]
    cp a, $80
    ret nz
    ldh a, [$FF91]
    cp a, $10
    ret nz
    jr Jump_002_4FBC

Jump_002_4FAA::
    ret

Jump_002_4FAB::
    ldh a, [$FF98]
    cp a, $02
    ret nz
    ldh a, [$FF8E]
    cp a, $40
    ret nz
    ldh a, [$FF91]
    cp a, $40
    ret nz
    jr Jump_002_4FBC

Jump_002_4FBC::
    ld hl, Func_060_6C96
    ld b, $60
    rst $10
    call Func_002_5B9E
    call Func_002_5EEE
    ld a, $01
    ld [$C8C7], a
    ld a, $69
    call Func_000_1278
    ld a, $02
    ld [$C5DB], a
    ld a, $0B
    ld [$C5DC], a
    xor a, a
    ld [$C5DD], a
    xor a, a
    ld [$C55E], a
    ld [$C562], a
    ret

Func_002_4FE8::
    ld a, [$C193]
    or a, a
    ret z
    ld de, $0002
    call Func_000_181B
    ret nc
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
    ld a, [$C562]
    bit 0, a
    ret z
    ldh a, [$FF8E]
    ld b, a
    ldh a, [$FF91]
    ld c, a
    ldh a, [$FF98]
    or a, a
    jr z, Jump_002_5027
    dec a
    jr z, Jump_002_502D
    dec a
    jr z, Jump_002_5033
    ld a, b
    sub a, $10
    ld b, a
    jr Jump_002_5037

Jump_002_5027::
    ld a, c
    add a, $10
    ld c, a
    jr Jump_002_5037

Jump_002_502D::
    ld a, b
    add a, $10
    ld b, a
    jr Jump_002_5037

Jump_002_5033::
    ld a, c
    sub a, $10
    ld c, a

Jump_002_5037::
    call Func_002_59CD
    ld de, $C910
    ld b, $04

Jump_002_503F::
    ld a, [de]
    inc de
    ld c, a
    ld a, [$C193]
    cp a, c
    jr nz, Jump_002_504A
    jr Jump_002_504E

Jump_002_504A::
    dec b
    jr nz, Jump_002_503F
    ret

Jump_002_504E::
    call Func_002_5B9E
    call Func_002_5EEE
    ld a, $01
    ld [$C8C7], a
    ld a, $69
    call Func_000_1278
    ld a, $02
    ld [$C5DB], a
    ld a, $0B
    ld [$C5DC], a
    xor a, a
    ld [$C5DD], a
    xor a, a
    ld [$C55E], a
    ld [$C562], a
    ret

Func_002_5074::
    ld a, [$C56C]
    or a, a
    ret nz
    ld a, [$C468]
    bit 7, a
    ret nz
    ld a, [$C90D]
    and a, $0F
    rst $00
    dw Jump_002_50AD
    dw Func_002_50AE
    dw Func_002_50AE
    dw Jump_002_5119
    dw Jump_002_5128
    dw Jump_002_5136
    dw Jump_002_51DE
    dw Jump_002_5235
    dw Jump_002_50A9
    dw Jump_002_5147
    dw Jump_002_5155
    dw Jump_002_5284
    dw Jump_002_50A5
    dw Jump_002_50D5
    dw Jump_002_50EE
    dw Jump_002_5163

Jump_002_50A5::
    call Func_002_53D5
    ret

Jump_002_50A9::
    call Func_002_52D8
    ret

Jump_002_50AD::
    ret

Func_002_50AE::
    ld a, [$C5F0]
    and a, $07
    ret nz
    ld hl, $9000
    ld b, $10

Jump_002_50B9::
    di
    call Func_000_120A
    ld a, [hl+]
    ld c, [hl]
    ei
    dec hl
    rlca
    rlc c
    push af
    di

Jump_002_50C6::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_002_50C6
    pop af
    ld [hl+], a
    ld [hl], c
    ei
    inc hl
    dec b
    jr nz, Jump_002_50B9
    ret

Jump_002_50D5::
    ld a, [$C5F0]
    and a, $07
    ret nz
    ld hl, $90A0
    ld b, $20

Jump_002_50E0::
    di
    call Func_000_120A
    ld a, [hl]
    ei
    rlca
    call Func_000_121F
    dec b
    jr nz, Jump_002_50E0
    ret

Jump_002_50EE::
    ld a, [$C5F0]
    and a, $07
    ret nz
    ld hl, $9000
    ld b, $30

Jump_002_50F9::
    di
    call Func_000_120A
    ld a, [hl]
    ei
    rlca
    call Func_000_121F
    dec b
    jr nz, Jump_002_50F9
    ld hl, $9030
    ld b, $30

Jump_002_510B::
    di
    call Func_000_120A
    ld a, [hl]
    ei
    rlca
    call Func_000_121F
    dec b
    jr nz, Jump_002_510B
    ret

Jump_002_5119::
    ld a, [$C5F0]
    and a, $0F
    ret nz
    ld de, $9300
    ld hl, $9320
    jp Jump_002_51AD

Jump_002_5128::
    ld a, [$C5F0]
    and a, $03
    ret nz
    ld de, $9280
    ld hl, $92C0
    jr Jump_002_5176

Jump_002_5136::
    call Func_002_50AE
    ld a, [$C5F0]
    and a, $03
    ret nz
    ld de, $9140
    ld hl, $9180
    jr Jump_002_5176

Jump_002_5147::
    ld a, [$C5F0]
    and a, $03
    ret nz
    ld de, $9280
    ld hl, $92C0
    jr Jump_002_5176

Jump_002_5155::
    ld a, [$C5F0]
    and a, $03
    ret nz
    ld de, $9480
    ld hl, $94C0
    jr Jump_002_5176

Jump_002_5163::
    ldh a, [$FF8F]
    cp a, $01
    ret z
    ld a, [$C5F0]
    and a, $03
    ret nz
    ld de, $9000
    ld hl, $9040
    jr Jump_002_5176

Jump_002_5176::
    ld a, [$C5F0]
    srl a
    srl a
    and a, $03
    swap a
    push af
    add a, l
    ld l, a
    jr nc, Jump_002_5187
    inc h

Jump_002_5187::
    pop af
    add a, e
    ld e, a
    jr nc, Jump_002_518D
    inc d

Jump_002_518D::
    ld b, $10

Jump_002_518F::
    di
    call Func_000_120A
    ld a, [de]
    ld c, a
    ei
    di
    call Func_000_120A
    ld a, [hl]
    ei
    push af
    di
    call Func_000_120A
    pop af
    ld [de], a
    ei
    ld a, c
    call Func_000_121F
    inc de
    dec b
    jr nz, Jump_002_518F
    ret

Jump_002_51AD::
    ld a, [$C5F0]
    and a, $10
    push af
    add a, l
    ld l, a
    jr nc, Jump_002_51B8
    inc h

Jump_002_51B8::
    pop af
    add a, e
    ld e, a
    jr nc, Jump_002_51BE
    inc d

Jump_002_51BE::
    ld b, $10

Jump_002_51C0::
    di
    call Func_000_120A
    ld a, [de]
    ld c, a
    ei
    di
    call Func_000_120A
    ld a, [hl]
    ei
    push af
    di
    call Func_000_120A
    ei
    pop af
    ld [de], a
    ld a, c
    call Func_000_121F
    inc de
    dec b
    jr nz, Jump_002_51C0
    ret

Jump_002_51DE::
    ld de, $0043
    call Func_000_181B
    ret c
    ld a, [$C5F0]
    and a, $1F
    cp a, $0C
    ret nc
    sla a
    sla a
    ld hl, Data_002_5205
    add a, l
    ld l, a
    jr nc, Jump_002_51F9
    inc h

Jump_002_51F9::
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    ld h, a
    ld l, c
    jp Jump_002_52B8

Data_002_5205:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C0, $91, $E0, $91, $D0, $91, $F0, $91, $20, $92, $60, $92, $30, $92, $70, $92
    db $20, $93, $40, $93, $30, $93, $50, $93, $80, $93, $A0, $93, $90, $93, $B0, $93
    db $20, $94, $40, $94, $30, $94, $50, $94, $80, $94, $A0, $94, $90, $94, $B0, $94

Jump_002_5235::
    ld a, [$C5F0]
    and a, $1F
    cp a, $0C
    ret nc
    sla a
    sla a
    ld hl, Data_002_5254
    add a, l
    ld l, a
    jr nc, Jump_002_5249
    inc h

Jump_002_5249::
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    ld h, a
    ld l, c
    jr Jump_002_52B8

Data_002_5254:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $30, $93, $50, $93, $40, $93, $60, $93, $20, $94, $40, $94, $30, $94, $50, $94
    db $C0, $94, $E0, $94, $D0, $94, $F0, $94, $60, $95, $80, $95, $70, $95, $90, $95
    db $20, $96, $60, $96, $30, $96, $70, $96, $A0, $96, $E0, $96, $B0, $96, $F0, $96

Jump_002_5284::
    ldh a, [$FF92]
    or a, a
    ret nz
    ld a, [$C5F0]
    and a, $3F
    cp a, $04
    ret nc
    sla a
    sla a
    ld hl, Data_002_52A8
    add a, l
    ld l, a
    jr nc, Jump_002_529C
    inc h

Jump_002_529C::
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    ld h, a
    ld l, c
    jp Jump_002_52B8

Data_002_52A8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $E0, $94, $00, $95, $F0, $94, $10, $95, $40, $95, $60, $95, $50, $95, $70, $95

Jump_002_52B8::
    ld b, $10

Jump_002_52BA::
    di
    call Func_000_120A
    ld a, [de]
    ld c, a
    ei
    di
    call Func_000_120A
    ld a, [hl]
    ei
    push af
    di
    call Func_000_120A
    ei
    pop af
    ld [de], a
    ld a, c
    call Func_000_121F
    inc de
    dec b
    jr nz, Jump_002_52BA
    ret

Func_002_52D8::
    ld a, [$C920]
    cp a, $ED
    ret z
    ld a, [$C936]
    and a, a
    ret nz
    ld a, [$C46C]
    bit 7, a
    jr nz, Jump_002_52FC
    ld a, $80
    ld [$C46C], a
    ld hl, $C49F
    ld de, $C0F0
    ld bc, $0040
    call Func_000_0952
    ret

Jump_002_52FC::
    ld a, [$C46B]
    inc a
    ld [$C46B], a
    and a, $07
    dec a
    ret nz
    ld a, [$C46B]
    srl a
    srl a
    srl a
    cp a, $08
    jr nz, Jump_002_5321
    ld a, [$C46C]
    inc a
    and a, $81
    ld [$C46C], a
    xor a, a
    ld [$C46B], a

Jump_002_5321::
    ldh [$FFC6], a
    ld hl, $C0F8
    ld de, $C4A7
    call Func_002_534A
    ld hl, $C100
    ld de, $C4AF
    ld hl, $C108
    ld de, $C4B7
    call Func_002_534A
    ld hl, $C110
    ld de, $C4BF
    call Func_002_534A
    ld a, $7F
    ld [$C526], a
    ret

Func_002_534A::
    ld a, [hl]
    ld c, a
    inc hl
    ld a, [hl]
    ld b, a
    inc hl
    push bc
    ld a, b
    srl a
    srl a
    ld [$D7C4], a
    pop bc
    push bc
    sla c
    rl b
    sla c
    rl b
    sla c
    rl b
    ld a, b
    and a, $1F
    ld [$D7C5], a
    pop bc
    ld a, c
    and a, $1F
    ld [$D7C6], a
    push hl
    ld hl, Data_002_53C5
    ldh a, [$FFC6]
    add a, l
    ld l, a
    jr nc, Jump_002_537F
    inc h

Jump_002_537F::
    ld a, [$C46C]
    bit 0, a
    jr z, Jump_002_538D
    ld a, $08
    add a, l
    ld l, a
    jr nc, Jump_002_538D
    inc h

Jump_002_538D::
    ld a, [hl]
    ld b, a
    ld hl, $D7C4
    ld c, $00

Jump_002_5394::
    ld a, [hl]
    add a, b
    bit 7, a
    jr z, Jump_002_539B
    xor a, a

Jump_002_539B::
    ld [hl+], a
    inc c
    ld a, c
    cp a, $03
    jr c, Jump_002_5394
    pop hl
    ld a, [$D7C4]
    ld b, a
    ld a, [$D7C5]
    sla a
    sla a
    sla a
    ld c, a
    sla c
    rl b
    sla c
    rl b
    ld a, [$D7C6]
    or a, c
    ld c, a
    ld a, c
    ld [de], a
    inc de
    ld a, b
    ld [de], a
    inc de
    ret

Data_002_53C5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $FC, $F8, $F4, $F0, $EC, $E8, $E4, $E4, $E8, $EC, $F0, $F4, $F8, $FC, $00

Func_002_53D5::
    ld a, [$C90E]
    bit 7, a
    jr nz, Jump_002_53F0
    and a, $7F
    ld c, a
    ld a, [$CD03]
    and a, $7F
    cp a, c
    jr nz, Jump_002_53EC
    ld a, $80
    ld [$C90E], a

Jump_002_53EC::
    xor a, a
    ldh [$FFA1], a
    ret

Jump_002_53F0::
    ld a, [$C90F]
    or a, a
    jr nz, Jump_002_53EC
    ld a, [$C5F0]
    and a, $03
    bit 0, a
    jr nz, Jump_002_5408
    dec a
    sla a
    ld c, a
    ldh a, [$FFA1]
    add a, c
    ldh [$FFA1], a

Jump_002_5408::
    ld a, [$C90E]
    inc a
    ld [$C90E], a
    cp a, $BC
    ret nz
    ld a, [$CD04]
    and a, $7F
    ld [$C90E], a
    ret

Func_002_541B::
    ld a, [$C56C]
    or a, a
    ret nz
    ldh a, [$FF9A]
    or a, a
    jr z, Jump_002_542C
    dec a
    ldh [$FF9A], a
    call Func_002_5B9E
    ret

Jump_002_542C::
    ldh a, [$FF8C]
    bit 0, a
    jp nz, Func_002_56DC
    ld a, [$C468]
    bit 7, a
    ret nz
    ldh a, [$FF8C]
    bit 6, a
    jp nz, Jump_002_556F
    ld a, [$C562]
    bit 5, a
    jr z, Jump_002_5459
    ldh a, [$FF98]
    cp a, $03
    jr z, Jump_002_5460

Jump_002_544D::
    ld a, $03
    ldh [$FF98], a
    ld a, $04
    ldh [$FF9A], a
    call Func_002_5B9E
    ret

Jump_002_5459::
    ld a, [$C55E]
    bit 5, a
    jr z, Jump_002_54D7

Jump_002_5460::
    ld a, $03
    ldh [$FF98], a
    ldh a, [$FF8E]
    or a, a
    jr z, Jump_002_54A0
    ld a, [$C91F]
    or a, a
    jr nz, Jump_002_548A
    ldh a, [$FF8E]
    sub a, $10
    ld b, a
    ldh a, [$FF91]
    ld c, a
    call Func_002_59CD
    cp a, $01
    jr z, Jump_002_544D
    call Func_002_5A51
    or a, a
    jr nz, Jump_002_544D
    call Func_002_5AB6
    or a, a
    jr nz, Jump_002_544D

Jump_002_548A::
    ldh a, [$FF8C]
    or a, $05
    ldh [$FF8C], a
    ld hl, $FFF0
    ld a, l
    ldh [$FF9B], a
    ld a, h
    ldh [$FF9C], a
    call Func_002_5923
    call Func_002_56DC
    ret

Jump_002_54A0::
    ldh a, [$FF8C]
    or a, $05
    ldh [$FF8C], a
    ld hl, $FF8F
    dec [hl]
    ld hl, Func_011_4002
    ld b, $11
    rst $10
    bit 0, c
    jr nz, Jump_002_544D
    ldh a, [$FF8F]
    cp a, $FF
    jr nz, Jump_002_54C0
    ld a, [$C190]
    dec a
    ldh [$FF8F], a

Jump_002_54C0::
    ld a, $80
    ld [$C468], a
    ld a, $01
    ld [$C46A], a
    ld hl, $0090
    ld a, l
    ldh [$FF9B], a
    ld a, h
    ldh [$FF9C], a
    call Func_002_56DC
    ret

Jump_002_54D7::
    ld a, [$C562]
    bit 4, a
    jr z, Jump_002_54F0
    ldh a, [$FF98]
    cp a, $01
    jr z, Jump_002_54F7

Jump_002_54E4::
    ld a, $01
    ldh [$FF98], a
    ld a, $04
    ldh [$FF9A], a
    call Func_002_5B9E
    ret

Jump_002_54F0::
    ld a, [$C55E]
    bit 4, a
    jr z, Jump_002_556F

Jump_002_54F7::
    ld a, $01
    ldh [$FF98], a
    ldh a, [$FF8E]
    cp a, $90
    jr z, Jump_002_5538
    ld a, [$C91F]
    or a, a
    jr nz, Jump_002_5522
    ldh a, [$FF8E]
    add a, $11
    ld b, a
    ldh a, [$FF91]
    ld c, a
    call Func_002_59CD
    cp a, $01
    jr z, Jump_002_54E4
    call Func_002_5A51
    or a, a
    jr nz, Jump_002_54E4
    call Func_002_5AB6
    or a, a
    jr nz, Jump_002_54E4

Jump_002_5522::
    ldh a, [$FF8C]
    or a, $05
    ldh [$FF8C], a
    ld hl, $0010
    ld a, l
    ldh [$FF9B], a
    ld a, h
    ldh [$FF9C], a
    call Func_002_5923
    call Func_002_56DC
    ret

Jump_002_5538::
    ldh a, [$FF8C]
    or a, $05
    ldh [$FF8C], a
    ld hl, $FF8F
    inc [hl]
    ld hl, Func_011_4002
    ld b, $11
    rst $10
    bit 0, c
    jr nz, Jump_002_54E4
    ld a, [$C190]
    ld c, a
    ldh a, [$FF8F]
    cp a, c
    jr nz, Jump_002_5558
    xor a, a
    ldh [$FF8F], a

Jump_002_5558::
    ld a, $80
    ld [$C468], a
    ld a, $02
    ld [$C46A], a
    ld hl, $FF70
    ld a, l
    ldh [$FF9B], a
    ld a, h
    ldh [$FF9C], a
    call Func_002_56DC
    ret

Jump_002_556F::
    ld a, [$C562]
    bit 7, a
    jr z, Jump_002_5588
    ldh a, [$FF98]
    cp a, $00
    jr z, Jump_002_5590

Jump_002_557C::
    ld a, $00
    ldh [$FF98], a
    ld a, $04
    ldh [$FF9A], a
    call Func_002_5B9E
    ret

Jump_002_5588::
    ld a, [$C55E]
    bit 7, a
    jp z, Jump_002_562C

Jump_002_5590::
    ld a, $00
    ldh [$FF98], a
    ld hl, Func_011_4002
    ld b, $11
    rst $10
    bit 0, c
    jr nz, Jump_002_557C
    ldh a, [$FF91]
    cp a, $80
    jr z, Jump_002_55EA
    ldh a, [$FF8C]
    bit 6, a
    jr nz, Jump_002_55CB
    ld a, [$C91F]
    or a, a
    jr nz, Jump_002_55CB
    ldh a, [$FF8E]
    ld b, a
    ldh a, [$FF91]
    add a, $11
    ld c, a
    call Func_002_59CD
    cp a, $01
    jr z, Jump_002_557C
    call Func_002_5A51
    or a, a
    jr nz, Jump_002_557C
    call Func_002_5AB6
    or a, a
    jr nz, Jump_002_557C

Jump_002_55CB::
    ldh a, [$FF8C]
    or a, $05
    ldh [$FF8C], a
    ld hl, $0010
    ldh a, [$FF8C]
    bit 6, a
    jr z, Jump_002_55DD
    ld hl, $0008

Jump_002_55DD::
    ld a, l
    ldh [$FF9D], a
    ld a, h
    ldh [$FF9E], a
    call Func_002_5923
    call Func_002_56DC
    ret

Jump_002_55EA::
    ldh a, [$FF8C]
    or a, $05
    ldh [$FF8C], a
    ld hl, $FF92
    inc [hl]
    ld hl, Func_011_4002
    ld b, $11
    rst $10
    bit 0, c
    jp nz, Jump_002_557C
    ld hl, Func_011_4268
    ld b, $11
    rst $10
    bit 0, c
    jp nz, Jump_002_557C
    ld a, [$C191]
    ld c, a
    ldh a, [$FF92]
    cp a, c
    jr nz, Jump_002_5616
    xor a, a
    ldh [$FF92], a

Jump_002_5616::
    ld a, $80
    ld [$C468], a
    ld a, $08
    ld [$C46A], a
    ld hl, $FF80
    ld a, l
    ldh [$FF9D], a
    ld a, h
    ldh [$FF9E], a
    call Func_002_56DC

Jump_002_562C::
    ld a, [$C562]
    bit 6, a
    jr z, Jump_002_5645
    ldh a, [$FF98]
    cp a, $02
    jr z, Jump_002_564B

Jump_002_5639::
    ld a, $02
    ldh [$FF98], a
    ld a, $04
    ldh [$FF9A], a
    call Func_002_5B9E
    ret

Jump_002_5645::
    ld a, [$C55E]
    bit 6, a
    ret z

Jump_002_564B::
    ld a, $02
    ldh [$FF98], a
    ldh a, [$FF91]
    or a, a
    jr z, Jump_002_56A4
    ld hl, Func_011_4002
    ld b, $11
    rst $10
    bit 0, c
    jr nz, Jump_002_5639
    ldh a, [$FF8C]
    bit 6, a
    jr nz, Jump_002_5685
    ld a, [$C91F]
    or a, a
    jr nz, Jump_002_5685
    ldh a, [$FF8E]
    ld b, a
    ldh a, [$FF91]
    sub a, $10
    ld c, a
    call Func_002_59CD
    cp a, $01
    jr z, Jump_002_5639
    call Func_002_5A51
    or a, a
    jr nz, Jump_002_5639
    call Func_002_5AB6
    or a, a
    jr nz, Jump_002_5639

Jump_002_5685::
    ldh a, [$FF8C]
    or a, $05
    ldh [$FF8C], a
    ld hl, $FFF0
    ldh a, [$FF8C]
    bit 6, a
    jr z, Jump_002_5697
    ld hl, $FFF8

Jump_002_5697::
    ld a, l
    ldh [$FF9D], a
    ld a, h
    ldh [$FF9E], a
    call Func_002_5923
    call Func_002_56DC
    ret

Jump_002_56A4::
    ldh a, [$FF8C]
    or a, $05
    ldh [$FF8C], a
    ld hl, $FF92
    dec [hl]
    ld hl, Func_011_4002
    ld b, $11
    rst $10
    bit 0, c
    jp nz, Jump_002_5639
    ldh a, [$FF92]
    cp a, $FF
    jr nz, Jump_002_56C5
    ld a, [$C191]
    dec a
    ldh [$FF92], a

Jump_002_56C5::
    ld a, $80
    ld [$C468], a
    ld a, $04
    ld [$C46A], a
    ld hl, $0080
    ld a, l
    ldh [$FF9D], a
    ld a, h
    ldh [$FF9E], a
    call Func_002_56DC
    ret

Func_002_56DC::
    call Func_002_5B9E
    ldh a, [$FF9B]
    ld l, a
    ldh a, [$FF9C]
    ld h, a
    ld a, h
    or a, l
    jr nz, Jump_002_5700
    ldh a, [$FF9D]
    ld l, a
    ldh a, [$FF9E]
    ld h, a
    ld a, h
    or a, l
    jr nz, Jump_002_5700
    ldh a, [$FF8C]
    and a, $FE
    ldh [$FF8C], a
    xor a, a
    ld [$C918], a
    jp Jump_002_58BF

Jump_002_5700::
    ldh a, [$FF9B]
    ld l, a
    ldh a, [$FF9C]
    ld h, a
    bit 7, h
    jr nz, Jump_002_5729
    ld a, h
    or a, l
    jr nz, Jump_002_5784
    ldh a, [$FF9D]
    ld l, a
    ldh a, [$FF9E]
    ld h, a
    bit 7, h
    jp nz, Jump_002_57E0
    ld a, h
    or a, l
    jp nz, Jump_002_583A
    ldh a, [$FF8C]
    and a, $FA
    ldh [$FF8C], a
    xor a, a
    ld [$C918], a
    ret

Jump_002_5729::
    ld a, [$C468]
    bit 7, a
    jr nz, Jump_002_5747
    call Func_002_5946
    ldh a, [$FF9B]
    ld l, a
    ldh a, [$FF9C]
    ld h, a
    inc hl
    ld a, l
    ldh [$FF9B], a
    ld a, h
    ldh [$FF9C], a
    ld hl, $FF8E
    dec [hl]
    jp Jump_002_5892

Jump_002_5747::
    call Func_002_58FC
    ldh a, [$FF9B]
    ld l, a
    ldh a, [$FF9C]
    ld h, a
    ld a, $08
    add a, l
    ld l, a
    jr nc, Jump_002_5757
    inc h

Jump_002_5757::
    ld a, l
    ldh [$FF9B], a
    ld a, h
    ldh [$FF9C], a
    ldh a, [$FF8E]
    sub a, $08
    ldh [$FF8E], a
    ld a, [$C8F0]
    sub a, $08
    ld [$C8F0], a
    ld a, [$C8F5]
    sub a, $08
    ld [$C8F5], a
    ld a, [$C8FA]
    sub a, $08
    ld [$C8FA], a
    call Func_002_5923
    call Func_002_5946
    jp Jump_002_5892

Jump_002_5784::
    ld a, [$C468]
    bit 7, a
    jr nz, Jump_002_57A2
    call Func_002_5946
    ldh a, [$FF9B]
    ld l, a
    ldh a, [$FF9C]
    ld h, a
    dec hl
    ld a, l
    ldh [$FF9B], a
    ld a, h
    ldh [$FF9C], a
    ld hl, $FF8E
    inc [hl]
    jp Jump_002_5892

Jump_002_57A2::
    call Func_002_58FC
    ldh a, [$FF9B]
    ld l, a
    ldh a, [$FF9C]
    ld h, a
    ld a, l
    sub a, $08
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld a, l
    ldh [$FF9B], a
    ld a, h
    ldh [$FF9C], a
    ldh a, [$FF8E]
    add a, $08
    ldh [$FF8E], a
    ld a, [$C8F0]
    add a, $08
    ld [$C8F0], a
    ld a, [$C8F5]
    add a, $08
    ld [$C8F5], a
    ld a, [$C8FA]
    add a, $08
    ld [$C8FA], a
    call Func_002_5923
    call Func_002_5946
    jp Jump_002_5892

Jump_002_57E0::
    ld a, [$C468]
    bit 7, a
    jr nz, Jump_002_57FE
    call Func_002_5946
    ldh a, [$FF9D]
    ld l, a
    ldh a, [$FF9E]
    ld h, a
    inc hl
    ld a, l
    ldh [$FF9D], a
    ld a, h
    ldh [$FF9E], a
    ld hl, $FF91
    dec [hl]
    jp Jump_002_5892

Jump_002_57FE::
    call Func_002_58FC
    ldh a, [$FF9D]
    ld l, a
    ldh a, [$FF9E]
    ld h, a
    ld a, $08
    add a, l
    ld l, a
    jr nc, Jump_002_580E
    inc h

Jump_002_580E::
    ld a, l
    ldh [$FF9D], a
    ld a, h
    ldh [$FF9E], a
    ldh a, [$FF91]
    sub a, $08
    ldh [$FF91], a
    ld a, [$C8F1]
    sub a, $08
    ld [$C8F1], a
    ld a, [$C8F6]
    sub a, $08
    ld [$C8F6], a
    ld a, [$C8FB]
    sub a, $08
    ld [$C8FB], a
    call Func_002_5923
    call Func_002_5946
    jr Jump_002_5892

Jump_002_583A::
    ld a, [$C468]
    bit 7, a
    jr nz, Jump_002_5857
    call Func_002_5946
    ldh a, [$FF9D]
    ld l, a
    ldh a, [$FF9E]
    ld h, a
    dec hl
    ld a, l
    ldh [$FF9D], a
    ld a, h
    ldh [$FF9E], a
    ld hl, $FF91
    inc [hl]
    jr Jump_002_5892

Jump_002_5857::
    call Func_002_58FC
    ldh a, [$FF9D]
    ld l, a
    ldh a, [$FF9E]
    ld h, a
    ld a, l
    sub a, $08
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld a, l
    ldh [$FF9D], a
    ld a, h
    ldh [$FF9E], a
    ldh a, [$FF91]
    add a, $08
    ldh [$FF91], a
    ld a, [$C8F1]
    add a, $08
    ld [$C8F1], a
    ld a, [$C8F6]
    add a, $08
    ld [$C8F6], a
    ld a, [$C8FB]
    add a, $08
    ld [$C8FB], a
    call Func_002_5923
    call Func_002_5946

Jump_002_5892::
    ldh a, [$FF9B]
    ld l, a
    ldh a, [$FF9C]
    ld h, a
    ld a, h
    or a, l
    ret nz
    ldh a, [$FF9D]
    ld l, a
    ldh a, [$FF9E]
    ld h, a
    ld a, h
    or a, l
    ret nz
    ld a, $01
    ld [$C955], a
    ldh a, [$FF8C]
    bit 6, a
    jr z, Jump_002_58B1
    and a, $7F

Jump_002_58B1::
    and a, $BA
    ldh [$FF8C], a
    ld a, [$C468]
    bit 7, a
    ret nz
    xor a, a
    ld [$C918], a

Jump_002_58BF::
    ld hl, Func_00A_56D0
    ld b, $0A
    rst $10
    ld hl, Func_00A_561E
    ld b, $0A
    rst $10
    ld hl, Func_012_75E0
    ld b, $12
    rst $10
    ld hl, Func_00A_5748
    ld b, $0A
    rst $10
    ld hl, Func_00A_43EC
    ld b, $0A
    rst $10
    ld hl, Func_012_73A1
    ld b, $12
    rst $10
    ld hl, Func_011_4130
    ld b, $11
    rst $10
    ld hl, Func_00A_4214
    ld b, $0A
    rst $10
    ld hl, Func_00A_42BC
    ld b, $0A
    rst $10
    ld hl, Func_00A_43B5
    ld b, $0A
    rst $10
    ret

Func_002_58FC::
    ld a, [$C94D]
    or a, a
    ret z
    ldh a, [$FF98]
    ld [$C8EF], a
    ld [$C8F4], a
    ld [$C8F9], a
    ldh a, [$FF8E]
    ld [$C8F0], a
    ld [$C8F5], a
    ld [$C8FA], a
    ldh a, [$FF91]
    ld [$C8F1], a
    ld [$C8F6], a
    ld [$C8FB], a
    ret

Func_002_5923::
    ldh a, [$FF8E]
    ld [$C8F2], a
    ldh a, [$FF91]
    ld [$C8F3], a
    ld a, [$C8F0]
    ld [$C8F7], a
    ld a, [$C8F1]
    ld [$C8F8], a
    ld a, [$C8F5]
    ld [$C8FC], a
    ld a, [$C8F6]
    ld [$C8FD], a
    ret

Func_002_5946::
    ld a, [$C94D]
    or a, a
    ret nz
    ld b, $03
    ld hl, $C8EF
    ld de, $C8F2

Jump_002_5953::
    push hl
    push de
    inc hl
    ld a, [hl-]
    ld c, a
    ld a, [de]
    cp a, c
    jr z, Jump_002_5986
    jr nc, Jump_002_5972
    ld a, $03
    ld [hl+], a
    ld a, c
    dec a
    push af
    ld a, [$C468]
    ld c, a
    pop af
    bit 7, c
    jr z, Jump_002_596F
    sub a, $03

Jump_002_596F::
    ld [hl], a
    jr Jump_002_59B9

Jump_002_5972::
    ld a, $01
    ld [hl+], a
    ld a, c
    inc a
    push af
    ld a, [$C468]
    ld c, a
    pop af
    bit 7, c
    jr z, Jump_002_5983
    add a, $03

Jump_002_5983::
    ld [hl], a
    jr Jump_002_59B9

Jump_002_5986::
    inc hl
    inc hl
    ld a, [hl]
    ld c, a
    inc de
    ld a, [de]
    cp a, c
    jr z, Jump_002_59B9
    jr nc, Jump_002_59A6
    ld a, c
    dec a
    push af
    ld a, [$C468]
    ld c, a
    pop af
    bit 7, c
    jr z, Jump_002_599F
    sub a, $03

Jump_002_599F::
    ld [hl], a
    dec hl
    dec hl
    ld [hl], $02
    jr Jump_002_59B9

Jump_002_59A6::
    ld a, c
    inc a
    push af
    ld a, [$C468]
    ld c, a
    pop af
    bit 7, c
    jr z, Jump_002_59B4
    add a, $03

Jump_002_59B4::
    ld [hl], a
    dec hl
    dec hl
    ld [hl], $00

Jump_002_59B9::
    pop de
    pop hl
    ld a, $05
    add a, l
    ld l, a
    jr nc, Jump_002_59C2
    inc h

Jump_002_59C2::
    ld a, $05
    add a, e
    ld e, a
    jr nc, Jump_002_59C9
    inc d

Jump_002_59C9::
    dec b
    jr nz, Jump_002_5953
    ret

Func_002_59CD::
    push bc
    push de
    ldh a, [$FF8C]
    bit 3, a
    jr nz, Jump_002_59D5

Jump_002_59D5::
    ld a, c
    srl a
    srl a
    srl a
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add a, l
    ld l, a
    jr nc, Jump_002_59E6
    inc h

Jump_002_59E6::
    add hl, hl
    add hl, hl
    ld a, b
    srl a
    srl a
    srl a
    add a, l
    ld l, a
    jr nc, Jump_002_59F4
    inc h

Jump_002_59F4::
    ld a, l
    add a, $98
    ld l, a
    ld a, h
    adc a, $C1
    ld h, a
    ld a, [hl+]
    ld [$C910], a
    ld a, [hl-]
    ld [$C911], a
    ld a, $14
    add a, l
    ld l, a
    jr nc, Jump_002_5A0B
    inc h

Jump_002_5A0B::
    ld a, [hl+]
    ld [$C912], a
    ld a, [hl]
    ld [$C913], a
    ldh a, [$FF8C]
    bit 3, a
    jr nz, Jump_002_5A35
    ld de, $C910
    ld b, $04

Jump_002_5A1E::
    ld a, [de]
    inc de
    ld c, a
    ld a, [$C192]
    cp a, c
    jr c, Jump_002_5A29
    jr Jump_002_5A30

Jump_002_5A29::
    dec b
    jr nz, Jump_002_5A1E
    xor a, a
    pop de
    pop bc
    ret

Jump_002_5A30::
    ld a, $01
    pop de
    pop bc
    ret

Jump_002_5A35::
    ld de, $C910
    ld b, $02

Jump_002_5A3A::
    ld a, [de]
    inc de
    ld c, a
    ld a, [$C196]
    cp a, c
    jr nc, Jump_002_5A45
    jr Jump_002_5A4C

Jump_002_5A45::
    dec b
    jr nz, Jump_002_5A3A
    xor a, a
    pop de
    pop bc
    ret

Jump_002_5A4C::
    ld a, $01
    pop de
    pop bc
    ret

Func_002_5A51::
    ld a, [$CB7D]
    or a, a
    ret z
    push bc
    ld a, c
    swap a
    and a, $0F
    ldh [$FFC6], a
    ld a, b
    swap a
    and a, $0F
    ldh [$FFC7], a
    ld a, [$CB7D]
    ld b, a
    ld c, $01
    ld hl, $CB8A

Jump_002_5A6E::
    push hl
    push bc
    ld a, [hl]
    swap a
    and a, $0F
    ld c, a
    ldh a, [$FFC7]
    cp a, c
    jr z, Jump_002_5A88
    ld a, [hl]
    add a, $0F
    swap a
    and a, $0F
    ld c, a
    ldh a, [$FFC7]
    cp a, c
    jr nz, Jump_002_5AA1

Jump_002_5A88::
    inc hl
    ld a, [hl]
    swap a
    and a, $0F
    ld c, a
    ldh a, [$FFC6]
    cp a, c
    jr z, Jump_002_5AB1
    ld a, [hl]
    add a, $0F
    swap a
    and a, $0F
    ld c, a
    ldh a, [$FFC6]
    cp a, c
    jr z, Jump_002_5AB1

Jump_002_5AA1::
    pop bc
    inc c
    pop hl
    ld a, $10
    add a, l
    ld l, a
    jr nc, Jump_002_5AAB
    inc h

Jump_002_5AAB::
    dec b
    jr nz, Jump_002_5A6E
    xor a, a
    pop bc
    ret

Jump_002_5AB1::
    pop bc
    pop hl
    ld a, c
    pop bc
    ret

Func_002_5AB6::
    push bc
    ld a, [$C8FE]
    cp a, $02
    jr z, Jump_002_5AC5
    cp a, $03
    jr z, Jump_002_5AC5

Jump_002_5AC2::
    xor a, a
    pop bc
    ret

Jump_002_5AC5::
    ld a, b
    swap a
    and a, $0F
    ld b, a
    ld a, c
    swap a
    and a, $0F
    ld c, a
    ld a, [$CC44]
    bit 7, a
    jr nz, Jump_002_5AEE

Jump_002_5AD8::
    ld a, [$C8FF]
    swap a
    and a, $0F
    cp a, b
    jr nz, Jump_002_5AC2
    ld a, [$C8FF]
    and a, $0F
    cp a, c
    jr nz, Jump_002_5AC2
    ld a, $01
    pop bc
    ret

Jump_002_5AEE::
    cp a, $85
    jr z, Jump_002_5AD8
    ld a, [$C8FF]
    add a, a
    ld hl, Data_002_5B0A
    add a, l
    ld l, a
    jr nc, Jump_002_5AFE
    inc h

Jump_002_5AFE::
    ld a, [hl+]
    cp a, b
    jr nz, Jump_002_5AC2
    ld a, [hl]
    cp a, c
    jr nz, Jump_002_5AC2
    ld a, $01
    pop bc
    ret

Data_002_5B0A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $02, $01, $07, $02, $01, $02, $04, $02, $06, $03, $03, $04, $05, $04, $07
    db $05, $01, $05, $03, $06, $05, $07, $02, $07, $04, $07, $07, $08, $01, $08, $06

Func_002_5B2A::
    ld a, [$C56C]
    or a, a
    ret nz
    ldh a, [$FF8C]
    bit 0, a
    ret nz
    ld a, [$C55E]
    bit 7, a
    ret z
    ldh a, [$FF8F]
    swap a
    ld d, a
    ldh a, [$FF92]
    or a, d
    ld d, a
    ldh a, [$FF90]
    ld e, a
    ld hl, Data_002_5B89
    ld b, $00

Jump_002_5B4B::
    push hl
    ld a, [hl+]
    cp a, $FF
    jr nz, Jump_002_5B53
    pop hl
    ret

Jump_002_5B53::
    cp a, e
    jr nz, Jump_002_5B81
    ld a, [hl+]
    cp a, d
    jr nz, Jump_002_5B81
    ld a, [hl+]
    ld c, a
    ldh a, [$FF8E]
    cp a, c
    jr nz, Jump_002_5B81
    ld a, [hl]
    ld c, a
    ldh a, [$FF91]
    cp a, c
    jr nz, Jump_002_5B81
    ld a, b
    add a, $10
    ld [$C916], a
    xor a, a
    ld [$C917], a
    ld hl, Func_013_405C
    ld b, $13
    rst $10
    xor a, a
    ld [$C55E], a
    ld [$C562], a
    pop hl
    ret

Jump_002_5B81::
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    inc b
    jr Jump_002_5B4B

Data_002_5B89:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $11, $70, $70, $01, $11, $70, $20, $01, $10, $70, $50, $1A, $10, $70, $70
    db $85, $10, $50, $60, $FF

Func_002_5B9E::
    xor a, a
    ld [$C8CE], a
    ld a, [$C8CD]
    bit 7, a
    ret z
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
    ld a, h
    and a, $9B
    ld h, a
    ldh a, [$FFA1]
    srl a
    srl a
    srl a
    add a, l
    ld l, a
    jr nc, Jump_002_5BCC
    inc h

Jump_002_5BCC::
    call Func_000_1E29
    xor a, a
    ld [$C8CD], a
    ld [$C8CE], a
    ret

Func_002_5BD7::
    ld a, [$C468]
    bit 7, a
    ret z
    and a, $03
    rst $00
    dw Jump_002_5BE8
    dw Jump_002_5C5F
    dw Jump_002_5C27
    dw Jump_002_5BF4

Jump_002_5BE8::
    call Func_000_19A9
    xor a, a
    ld [$C469], a
    ld hl, $C468
    inc [hl]
    ret

Jump_002_5BF4::
    xor a, a
    ld [$C918], a
    ld hl, Func_00A_561E
    ld b, $0A
    rst $10
    ld hl, Func_012_75E0
    ld b, $12
    rst $10
    ld hl, Func_00A_43EC
    ld b, $0A
    rst $10
    ld hl, Func_011_4130
    ld b, $11
    rst $10
    ld hl, Func_00A_4214
    ld b, $0A
    rst $10
    ld hl, Func_00A_42BC
    ld b, $0A
    rst $10
    ld hl, Func_00A_43B5
    ld b, $0A
    rst $10
    xor a, a
    ld [$C468], a
    ret

Jump_002_5C27::
    ld hl, $C468
    inc [hl]
    ld hl, Func_012_70A4
    ld b, $12
    rst $10
    ld hl, Func_012_710A
    ld b, $12
    rst $10
    ld hl, Func_069_4001
    ld b, $69
    rst $10
    ld a, [$C935]
    bit 7, a
    jr z, Jump_002_5C4E
    bit 6, a
    jr nz, Jump_002_5C4E
    xor a, a
    ld [$C935], a
    jr Jump_002_5C54

Jump_002_5C4E::
    ld hl, Func_012_7BB0
    ld b, $12
    rst $10

Jump_002_5C54::
    xor a, a
    ld [$CBCF], a
    ld hl, Func_012_6A6A
    ld b, $12
    rst $10
    ret

Jump_002_5C5F::
    ldh a, [$FFA5]
    and a, $F8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add a, $00
    ld e, a
    ld a, d
    adc a, $98
    ld d, a
    ldh a, [$FFA1]
    srl a
    srl a
    srl a
    add a, e
    ld e, a
    jr nc, Jump_002_5C83
    inc d

Jump_002_5C83::
    ld a, [$C46A]
    bit 1, a
    jr z, Jump_002_5CCC
    ld a, e
    add a, $14
    and a, $1F
    ld c, a
    ld a, e
    and a, $E0
    or a, c
    ld e, a
    ld hl, $C198
    ld a, [$C469]
    add a, l
    ld l, a
    jr nc, Jump_002_5CA0
    inc h

Jump_002_5CA0::
    call Func_002_5DC8
    ldh a, [$FFA1]
    add a, $08
    ldh [$FFA1], a
    ld hl, $C469
    inc [hl]
    ld a, [$C469]
    cp a, $14
    jr nc, Jump_002_5CB8
    call Func_000_252D
    ret

Jump_002_5CB8::
    ldh a, [$FFA1]
    and a, $F8
    ldh [$FFA1], a
    ld hl, Func_0A1_4435
    ld b, $A1
    rst $10
    ld hl, $C468
    inc [hl]
    call Func_000_252D
    ret

Jump_002_5CCC::
    bit 0, a
    jr z, Jump_002_5D15
    ld a, e
    dec a
    and a, $1F
    ld c, a
    ld a, e
    and a, $E0
    or a, c
    ld e, a
    ld hl, $C198
    ld a, [$C469]
    ld c, a
    ld a, $13
    sub a, c
    add a, l
    ld l, a
    jr nc, Jump_002_5CE9
    inc h

Jump_002_5CE9::
    call Func_002_5DC8
    ldh a, [$FFA1]
    sub a, $08
    ldh [$FFA1], a
    ld hl, $C469
    inc [hl]
    ld a, [$C469]
    cp a, $14
    jr nc, Jump_002_5D01
    call Func_000_252D
    ret

Jump_002_5D01::
    ldh a, [$FFA1]
    and a, $F8
    ldh [$FFA1], a
    ld hl, Func_0A1_4435
    ld b, $A1
    rst $10
    ld hl, $C468
    inc [hl]
    call Func_000_252D
    ret

Jump_002_5D15::
    bit 3, a
    jr z, Jump_002_5D68
    ld a, e
    add a, $40
    ld e, a
    ld a, d
    adc a, $02
    ld d, a
    ld a, d
    and a, $9B
    ld d, a
    ld a, [$C469]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add a, l
    ld l, a
    jr nc, Jump_002_5D32
    inc h

Jump_002_5D32::
    add hl, hl
    add hl, hl
    ld a, l
    add a, $98
    ld l, a
    ld a, h
    adc a, $C1
    ld h, a
    call Func_002_5E2C
    ldh a, [$FFA5]
    add a, $08
    ldh [$FFA5], a
    ld hl, $C469
    inc [hl]
    ld a, [$C469]
    cp a, $12
    jr nc, Jump_002_5D54
    call Func_000_252D
    ret

Jump_002_5D54::
    ldh a, [$FFA5]
    and a, $F8
    ldh [$FFA5], a
    ld hl, Func_0A1_4435
    ld b, $A1
    rst $10
    ld hl, $C468
    inc [hl]
    call Func_000_252D
    ret

Jump_002_5D68::
    bit 2, a
    jr z, Jump_002_5DC7
    ld a, e
    sub a, $20
    ld e, a
    ld a, d
    sbc a, $00
    ld d, a
    ld a, d
    cp a, $97
    jr nz, Jump_002_5D81
    ld a, e
    add a, $00
    ld e, a
    ld a, d
    adc a, $04
    ld d, a

Jump_002_5D81::
    ld a, [$C469]
    ld c, a
    ld a, $11
    sub a, c
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add a, l
    ld l, a
    jr nc, Jump_002_5D92
    inc h

Jump_002_5D92::
    add hl, hl
    add hl, hl
    ld a, l
    add a, $98
    ld l, a
    ld a, h
    adc a, $C1
    ld h, a
    call Func_002_5E2C
    ldh a, [$FFA5]
    sub a, $08
    ldh [$FFA5], a
    ld hl, $C469
    inc [hl]
    ld a, [$C469]
    cp a, $12
    jr nc, Jump_002_5DB4
    call Func_000_252D
    ret

Jump_002_5DB4::
    ldh a, [$FFA5]
    and a, $F8
    ldh [$FFA5], a
    ld hl, Func_0A1_4435
    ld b, $A1
    rst $10
    ld hl, $C468
    inc [hl]
    call Func_000_252D

Jump_002_5DC7::
    ret

Func_002_5DC8::
    ld a, e
    ld [$C0C0], a
    ld a, d
    ld [$C0C1], a
    ld a, $01
    ld [$C0C2], a
    ld a, $12
    ld [$C0C3], a
    push hl
    push de
    ld b, $12
    ld de, $C0C4

Jump_002_5DE1::
    ld a, [hl]
    ld [de], a
    ld a, $14
    add a, l
    ld l, a
    jr nc, Jump_002_5DEA
    inc h

Jump_002_5DEA::
    inc de
    dec b
    jr nz, Jump_002_5DE1
    pop de
    pop hl
    ld a, [$C525]
    or a, a
    ret z
    ld a, e
    ld [$C0D8], a
    ld a, d
    ld [$C0D9], a
    ld a, $01
    ld [$C0DA], a
    ld a, $12
    ld [$C0DB], a
    ld de, $0E68
    add hl, de
    ld b, $12
    ld de, $C0DC

Jump_002_5E10::
    ld a, $02
    ldh [$FF70], a
    ld a, [hl]
    ldh [$FFC6], a
    ld a, $00
    ldh [$FF70], a
    ldh a, [$FFC6]
    and a, $07
    ld [de], a
    ld a, $14
    add a, l
    ld l, a
    jr nc, Jump_002_5E27
    inc h

Jump_002_5E27::
    inc de
    dec b
    jr nz, Jump_002_5E10
    ret

Func_002_5E2C::
    ld a, e
    ld [$C0C0], a
    ld a, d
    ld [$C0C1], a
    xor a, a
    ld [$C0C2], a
    ld a, $14
    ld [$C0C3], a
    push hl
    push de
    ld b, $14
    ld de, $C0C4

Jump_002_5E44::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_002_5E44
    pop de
    pop hl
    ld a, [$C525]
    or a, a
    ret z
    ld a, e
    ld [$C0D8], a
    ld a, d
    ld [$C0D9], a
    ld a, $00
    ld [$C0DA], a
    ld a, $14
    ld [$C0DB], a
    ld de, $0E68
    add hl, de
    ld b, $14
    ld de, $C0DC

Jump_002_5E6C::
    ld a, $02
    ldh [$FF70], a
    ld a, [hl+]
    ldh [$FFC6], a
    ld a, $00
    ldh [$FF70], a
    ldh a, [$FFC6]
    and a, $07
    ld [de], a
    ld [de], a
    inc de
    dec b
    jr nz, Jump_002_5E6C
    ret

Func_002_5E82::
    call Func_002_5E85

Func_002_5E85::
    ld a, [$C6FD]
    dec a
    ret z
    dec a
    jr nz, Jump_002_5E8F
    jr Jump_002_5EBA

Jump_002_5E8F::
    ld a, $0A
    ld [$0100], a
    ld c, $55
    ld a, [$C6FF]
    call Func_000_1F80
    bit 7, a
    jr z, Jump_002_5EBA
    ld c, $55
    ld a, [$C700]
    call Func_000_1F80
    bit 7, a
    jr nz, Jump_002_5EBA
    ld a, [$C6FF]
    ld c, a
    ld a, [$C700]
    ld [$C6FF], a
    ld a, c
    ld [$C700], a

Jump_002_5EBA::
    ld a, $0A
    ld [$0100], a
    ld c, $55
    ld a, [$C6FE]
    call Func_000_1F80
    ldh a, [$FFC6]
    bit 7, a
    jr z, Jump_002_5EE9
    ld c, $55
    ld a, [$C6FF]
    call Func_000_1F80
    ldh a, [$FFC6]
    bit 7, a
    jr nz, Jump_002_5EE9
    ld a, [$C6FE]
    ld c, a
    ld a, [$C6FF]
    ld [$C6FE], a
    ld a, c
    ld [$C6FF], a

Jump_002_5EE9::
    xor a, a
    ld [$0100], a
    ret

Func_002_5EEE::
    ld de, $C198
    ld hl, $9C00
    ld bc, $0168

Jump_002_5EF7::
    ld a, [de]
    inc de
    call Func_000_121F
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_002_5EF7
    ld a, [$C525]
    or a, a
    jr z, Jump_002_5F1B
    ld a, $02
    ldh [$FF70], a
    ld hl, $D000
    ld de, $D2D0
    ld bc, $0168
    call Func_000_0952
    ld a, $00
    ldh [$FF70], a

Jump_002_5F1B::
    ld a, [$CB7D]
    ld [$CB7E], a
    ret

Func_002_5F22::
    ld hl, $9C00
    ld de, $C198
    ld bc, $0168

Jump_002_5F2B::
    di
    call Func_000_120A
    ld a, [hl+]
    ld [de], a
    ei
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_002_5F2B
    ld a, [$C525]
    or a, a
    jr z, Jump_002_5F52
    ld a, $02
    ldh [$FF70], a
    ld hl, $D2D0
    ld de, $D000
    ld bc, $0168
    call Func_000_0952
    ld a, $00
    ldh [$FF70], a

Jump_002_5F52::
    ld a, [$CB7E]
    ld [$CB7D], a
    ret

Func_002_5F59::
    ld a, [$C830]
    ld l, a
    ld a, [$C831]
    ld h, a
    ld bc, $03E7
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    ld a, h
    or a, l
    or a, a
    jr nz, Jump_002_5F75
    ld a, [$C82F]
    cp a, $3B
    ret z

Jump_002_5F75::
    ld hl, $C82D
    ld a, [hl]
    inc a
    ld [hl], a
    cp a, $3C
    ret c
    ld [hl], $00
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    cp a, $3C
    ret c
    ld [hl], $00
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    cp a, $3C
    ret c
    ld [hl], $00
    inc hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    inc bc
    ld a, b
    ld [hl-], a
    ld [hl], c
    ret

Func_002_5F9B::
    ld a, [$C524]
    or a, a
    jr z, Jump_002_5FEB
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

Jump_002_5FEB::
    ld a, [$C5E0]
    cp a, $01
    ret nz
    ld a, $02
    ld [$C5E0], a
    ret

Jump_002_5FF7::
    xor a, a
    ld [$C55E], a
    ld [$C55F], a
    xor a, a
    ld [$C562], a
    ld [$C563], a
    xor a, a
    ld [$C564], a
    ld [$C565], a
    call Func_002_4AE0
    xor a, a
    ld [$C5E0], a
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
    jr z, Jump_002_6045
    ld hl, $C4DF
    ld de, $C4FF
    ld b, $20

Jump_002_603F::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_002_603F

Jump_002_6045::
    ld a, $FD
    call Func_000_0DF2
    ret

Func_002_604B::
    ld a, $FF
    ld [$C608], a

Func_002_6050::
    ld a, [$CC44]
    bit 7, a
    jr z, Jump_002_609D
    ld c, $22
    cp a, $86
    jr z, Jump_002_6089
    ld c, $25
    cp a, $85
    jr z, Jump_002_6089
    ld c, $19
    cp a, $84
    jr z, Jump_002_6089
    cp a, $83
    jr nz, Jump_002_607F
    ld a, [$CC45]
    add a, a
    add a, a
    ld hl, $CD89
    add a, l
    ld l, a
    jr nc, Jump_002_607A
    inc h

Jump_002_607A::
    ld a, [hl]
    cp a, $06
    jr nz, Jump_002_6089

Jump_002_607F::
    ld c, $2B
    ldh a, [$FF8C]
    bit 3, a
    jr nz, Jump_002_6089
    ld c, $35

Jump_002_6089::
    ld a, [$C608]
    cp a, c
    ret z
    ld a, c
    call Func_000_122D
    ret

Jump_002_6093::
    ld a, [$C60B]
    cp a, c
    ret z
    ld a, c
    call Func_000_1278
    ret

Jump_002_609D::
    ldh a, [$FF90]
    rst $00
    dw Jump_002_6268
    dw Jump_002_626D
    dw Jump_002_6268
    dw Jump_002_6268
    dw Jump_002_62C0
    dw Jump_002_6291
    dw Jump_002_6268
    dw Jump_002_6268
    dw Jump_002_6268
    dw Jump_002_6268
    dw Jump_002_6268
    dw Jump_002_6268
    dw Jump_002_6268
    dw Jump_002_62BB
    dw Jump_002_6268
    dw Jump_002_6268
    dw Jump_002_6268
    dw Jump_002_6268
    dw Jump_002_6268
    dw Jump_002_6268
    dw Jump_002_62BB
    dw Jump_002_6268
    dw Jump_002_6268
    dw Jump_002_6268
    dw Jump_002_62C0
    dw Jump_002_6268
    dw Jump_002_6268
    dw Jump_002_6268
    dw Jump_002_62DA
    dw Jump_002_62D5
    INCBIN "dwm2-cobi-us.gbc", $00A0DC, $54
    dw Func_002_631A
    dw Func_002_631A
    dw Func_002_62E0
    dw Func_002_62E0
    dw Func_002_62E0
    dw Func_002_62ED
    dw Func_002_631A
    dw Func_002_62E0
    dw Func_002_62E0
    dw Func_002_62E0
    dw Func_002_631A
    db $39, $63, $39, $63, $39, $63, $39, $63, $39, $63
    dw Func_002_62E0
    dw Func_002_62E0
    dw Func_002_62E0
    dw Func_002_62E0
    dw Func_002_62E0
    db $72, $63
    dw Func_002_62E0
    dw Func_002_62E0
    dw Func_002_62E0
    dw Func_002_62E0
    INCBIN "dwm2-cobi-us.gbc", $00A164, $104

Jump_002_6268::
    ld c, $16
    jp Jump_002_6089

Jump_002_626D::
    ldh a, [$FF92]
    cp a, $02
    jr nz, Jump_002_6268
    ldh a, [$FF8F]
    or a, a
    jr z, Jump_002_627C
    cp a, $02
    jr nz, Jump_002_6268

Jump_002_627C::
    ld de, $0007
    call Func_000_181B
    jr nc, Jump_002_6268
    ld de, $000A
    call Func_000_181B
    jr c, Jump_002_6268
    ld c, $28
    jp Jump_002_6089

Jump_002_6291::
    ldh a, [$FF8F]
    or a, a
    jr nz, Jump_002_6268
    ld de, $000A
    call Func_000_181B
    jr nc, Jump_002_6268
    ld de, $000C
    call Func_000_181B
    jr nc, Jump_002_62B6
    ld de, $00C2
    call Func_000_181B
    jr nc, Jump_002_6268
    ld de, $00C3
    call Func_000_181B
    jr c, Jump_002_6268

Jump_002_62B6::
    ld c, $28
    jp Jump_002_6089

Jump_002_62BB::
    ld c, $0C
    jp Jump_002_6089

Jump_002_62C0::
    ld de, $00CC
    call Func_000_181B
    jr nc, Jump_002_6268
    ld de, $0038
    call Func_000_181B
    jr c, Jump_002_6268
    ld c, $CF
    jp Jump_002_6089

Jump_002_62D5::
    ld c, $76
    jp Jump_002_6093

Jump_002_62DA::
    ret

Jump_002_62DB::
    ld c, $19
    jp Jump_002_6089

Func_002_62E0:: ; heuristic: target of a pointer table; C0
    ld de, $0023
    call Func_000_181B
    jr c, Jump_002_62DB
    ld c, $2E
    jp Jump_002_6089

Func_002_62ED:: ; heuristic: target of a pointer table; C0
    ldh a, [$FF92]
    or a, a
    jr z, Func_002_62E0
    ld de, $0087
    call Func_000_181B
    jr nc, Func_002_62E0
    ld de, $008A
    call Func_000_181B
    jr c, Func_002_62E0
    ld c, $28
    jp Jump_002_6089

Jump_002_6307::
    ld c, $1C
    jp Jump_002_6089

Func_002_630C:: ; heuristic: follows a terminator; C0
    ld c, $1C
    ldh a, [$FF8C]
    bit 3, a
    jp z, Jump_002_6089
    ld c, $2B
    jp Jump_002_6089

Func_002_631A:: ; heuristic: target of a pointer table; C0
    ld de, $0023
    call Func_000_181B
    jr c, Jump_002_6307
    ld c, $2E
    jp Jump_002_6089

Func_002_6327:: ; heuristic: follows a terminator; C0
    ld de, $0025
    call Func_000_181B
    jr c, Jump_002_6307
    ld c, $1F
    jp Jump_002_6089
    INCBIN "dwm2-cobi-us.gbc", $00A334, $5D

Func_002_6391::
    call Func_002_641E
    ld a, [$C562]
    bit 1, a
    jr z, Jump_002_63BD
    xor a, a
    ld [$C8C7], a
    ld hl, Func_004_449F
    ld b, $04
    rst $10
    xor a, a
    ldh [$FFB9], a
    call Func_002_64B3
    ld a, [$CC44]
    bit 7, a
    jr nz, Jump_002_63B7
    xor a, a
    ld [$C5DC], a
    ret

Jump_002_63B7::
    ld a, $05
    ld [$C5DC], a
    ret

Jump_002_63BD::
    bit 0, a
    jr z, Jump_002_63D6
    ld a, $69
    call Func_000_1278
    ld a, $02
    ld [$C5DB], a
    ld a, [$C46B]
    ld [$C5DC], a
    xor a, a
    ld [$C5DD], a
    ret

Jump_002_63D6::
    bit 5, a
    jr z, Jump_002_63E8
    ld a, $69
    call Func_000_1278
    ld a, [$C46B]
    xor a, $01
    ld [$C46B], a
    ret

Jump_002_63E8::
    bit 4, a
    jr z, Jump_002_63FA
    ld a, $69
    call Func_000_1278
    ld a, [$C46B]
    xor a, $01
    ld [$C46B], a
    ret

Jump_002_63FA::
    bit 6, a
    jr z, Jump_002_640C
    ld a, $69
    call Func_000_1278
    ld a, [$C46B]
    xor a, $02
    ld [$C46B], a
    ret

Jump_002_640C::
    bit 7, a
    jr z, Jump_002_641D
    ld a, $69
    call Func_000_1278
    ld a, [$C46B]
    xor a, $02
    ld [$C46B], a

Jump_002_641D::
    ret

Func_002_641E::
    ldh a, [$FFA5]
    and a, $F8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add a, $00
    ld e, a
    ld a, d
    adc a, $98
    ld d, a
    ldh a, [$FFA1]
    srl a
    srl a
    srl a
    add a, e
    ld e, a
    jr nc, Jump_002_6442
    inc d

Jump_002_6442::
    ld l, e
    ld h, d
    ld b, $00
    ld de, Data_002_64AB

Jump_002_6449::
    push hl
    ld a, [de]
    inc de
    ld c, a
    add a, l
    ld l, a
    and a, $1F
    cp a, c
    jr nc, Jump_002_645C
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_002_645C::
    ld a, [de]
    inc de
    push de
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    ld a, l
    add a, e
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    pop de
    ld a, h
    and a, $9B
    ld h, a
    ld c, $C3
    ld a, [$C46B]
    cp a, b
    jr nz, Jump_002_649F
    ld c, $BC
    bit 7, a
    jr nz, Jump_002_649F
    ld c, $BB
    ld a, [$C46C]
    inc a
    ld [$C46C], a
    bit 3, a
    jr z, Jump_002_649F
    ld c, $C3

Jump_002_649F::
    ld a, c
    call Func_000_1211
    pop hl
    inc b
    ld a, b
    cp a, $04
    jr nz, Jump_002_6449
    ret

Data_002_64AB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $01, $06, $01, $01, $03, $06, $03

Func_002_64B3::
    ldh a, [$FFA5]
    and a, $F8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add a, $00
    ld e, a
    ld a, d
    adc a, $98
    ld d, a
    ldh a, [$FFA1]
    srl a
    srl a
    srl a
    add a, e
    ld e, a
    jr nc, Jump_002_64D7
    inc d

Jump_002_64D7::
    ld l, e
    ld h, d
    call Func_000_1E29
    xor a, a
    ld [$C8CD], a
    xor a, a
    ld [$C8CE], a
    ret

Func_002_64E5::
    ld a, [$C56C]
    or a, a
    ret nz
    ld de, $0002
    call Func_000_181B
    ret nc
    ld a, [$C8CB]
    and a, $03
    ret nz
    ld a, [$C468]
    bit 7, a
    ret nz
    ldh a, [$FF8C]
    bit 0, a
    ret nz
    ld a, [$C562]
    bit 0, a
    ret z
    ld a, $03
    ldh [$FFB9], a
    ld a, $01
    ld [$C8C7], a
    ld hl, Func_002_5EEE
    ld b, $02
    rst $10
    ld hl, Func_004_4470
    ld b, $04
    rst $10
    ld hl, $C300
    ld de, $C198
    ld b, $64

Jump_002_6525::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_002_6525
    ld a, [$C525]
    or a, a
    jr z, Jump_002_6549
    ld hl, $D168
    ld de, $D000
    ld a, $02
    ldh [$FF70], a
    ld b, $64

Jump_002_653D::
    ld a, [de]
    inc de
    and a, $07
    ld [hl+], a
    dec b
    jr nz, Jump_002_653D
    ld a, $00
    ldh [$FF70], a

Jump_002_6549::
    ld de, Data_002_6606
    ld hl, $C300
    ld bc, $0C05
    call Func_002_65C3
    ld de, Data_002_6642
    ld hl, $C30C
    ld bc, $0803
    call Func_002_65C3
    ldh a, [$FFA5]
    and a, $F8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add a, $00
    ld e, a
    ld a, d
    adc a, $98
    ld d, a
    ldh a, [$FFA1]
    srl a
    srl a
    srl a
    add a, e
    ld e, a
    jr nc, Jump_002_6585
    inc d

Jump_002_6585::
    ld l, e
    ld h, d
    push hl
    ld bc, $1405
    call Func_002_6B19
    ld a, $B3
    ld [$C8CE], a
    call Func_002_66CC
    pop hl
    ld a, $2E
    add a, l
    ld l, a
    jr nc, Jump_002_659E
    inc h

Jump_002_659E::
    ld a, l
    and a, $1F
    cp a, $0E
    jr nc, Jump_002_65AD
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_002_65AD::
    call Func_002_665A
    ld a, $69
    call Func_000_1278
    ld a, $02
    ld [$C5DC], a
    ldh a, [$FFCE]
    or a, a
    ret nz
    xor a, a
    ld [$C46B], a
    ret

Func_002_65C3::
    push hl
    push bc

Jump_002_65C5::
    push hl
    push bc

Jump_002_65C7::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_002_65C7
    pop bc
    pop hl
    ld a, l
    add a, $14
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec c
    jr nz, Jump_002_65C5
    pop bc
    pop hl
    ld a, [$C525]
    or a, a
    ret z
    ld a, l
    add a, $68
    ld l, a
    ld a, h
    adc a, $0E
    ld h, a
    ld a, $02
    ldh [$FF70], a

Jump_002_65ED::
    push hl
    push bc

Jump_002_65EF::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_002_65EF
    pop bc
    pop hl
    ld a, l
    add a, $14
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec c
    jr nz, Jump_002_65ED
    ld a, $00
    ldh [$FF70], a
    ret

Data_002_6606:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $A4, $A5
    db $A6, $A7, $C3, $A4, $A8, $A9, $EC, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $B7, $B6, $C3, $AA, $AB, $A4, $AC, $C3, $AD, $AC, $AE, $A5, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_002_6642:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $BF, $C3, $C3, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Func_002_665A::
    push hl
    ld a, [$C617]
    ld l, a
    ld a, [$C618]
    ld h, a
    ld a, l
    ld [$C8C0], a
    ld a, h
    ld [$C8C1], a
    ld a, [$C619]
    ld [$C8C2], a
    call Func_000_173A
    pop hl
    ld c, $00
    ld b, $03
    ld de, $FFC8
    jr Jump_002_66A9

Jump_002_667E::
    ld a, [de]
    srl a
    srl a
    srl a
    srl a
    or a, a
    jr nz, Jump_002_668E
    bit 0, c
    jr z, Jump_002_6695

Jump_002_668E::
    add a, $E0
    call Func_000_1211
    ld c, $01

Jump_002_6695::
    inc hl
    ld a, l
    and a, $1F
    jr nz, Jump_002_66A3
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_002_66A3::
    ld a, b
    dec a
    jr nz, Jump_002_66A9
    ld c, $01

Jump_002_66A9::
    ld a, [de]
    dec de
    and a, $0F
    jr nz, Jump_002_66B3
    bit 0, c
    jr z, Jump_002_66BA

Jump_002_66B3::
    add a, $E0
    call Func_000_1211
    ld c, $01

Jump_002_66BA::
    inc hl
    ld a, l
    and a, $1F
    jr nz, Jump_002_66C8
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_002_66C8::
    dec b
    jr nz, Jump_002_667E
    ret

Func_002_66CC::
    ld de, $0002
    call Func_000_181B
    ret nc
    ld a, [$C8CB]
    and a, $03
    ret nz
    ld a, [$C468]
    bit 7, a
    ret nz
    ld a, [$C6FD]
    or a, a
    ret z
    ldh a, [$FF8C]
    bit 0, a
    ret nz
    ld a, [$C8CD]
    bit 7, a
    ret nz
    ld a, [$C8CE]
    inc a
    ld [$C8CE], a
    cp a, $B4
    ret nz
    xor a, a
    ld [$C8CE], a
    ld a, [$C6FD]
    dec a
    or a, $80
    ld [$C8CD], a
    ld a, $03
    ldh [$FFB9], a
    ld hl, $C364
    ld de, $C198
    ld a, e
    add a, $F0
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    push de
    ld b, $78

Jump_002_671B::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_002_671B
    pop de
    ld a, [$C525]
    or a, a
    jr z, Jump_002_6745
    ld hl, $D1CC
    ld a, e
    add a, $68
    ld e, a
    ld a, d
    adc a, $0E
    ld d, a
    ld a, $02
    ldh [$FF70], a
    ld b, $78

Jump_002_6739::
    ld a, [de]
    inc de
    and a, $07
    ld [hl+], a
    dec b
    jr nz, Jump_002_6739
    ld a, $00
    ldh [$FF70], a

Jump_002_6745::
    ld a, [$C8CD]
    and a, $03
    jr z, Jump_002_6753
    dec a
    jr z, Jump_002_6761
    dec a
    jr z, Jump_002_676F
    ret

Jump_002_6753::
    ld de, Data_002_68E6
    ld hl, $C364
    ld bc, $0706
    call Func_002_68A3
    jr Jump_002_677B

Jump_002_6761::
    ld de, Data_002_6910
    ld hl, $C364
    ld bc, $0D06
    call Func_002_68A3
    jr Jump_002_677B

Jump_002_676F::
    ld de, Data_002_695E
    ld hl, $C364
    ld bc, $1306
    call Func_002_68A3

Jump_002_677B::
    call Func_002_6788
    call Func_002_6841
    ld hl, Func_016_7A64
    ld b, $16
    rst $10
    ret

Func_002_6788::
    ld a, $0A
    ld [$0100], a
    ld a, [$C8CD]
    and a, $03
    inc a
    ld b, a
    ld hl, Data_002_6835
    ld de, $C6FE

Jump_002_679A::
    push bc
    push de
    ld a, [de]
    ldh [$FFCB], a
    ld c, $56
    call Func_000_1F80
    push hl
    ldh a, [$FFC6]
    ld l, a
    ld h, $00
    call Func_000_16F5
    pop hl
    ld a, [hl+]
    ld de, $C364
    add a, e
    ld e, a
    jr nc, Jump_002_67B7
    inc d

Jump_002_67B7::
    call Func_000_210D
    ldh a, [$FFCB]
    ld c, $5B
    call Func_000_1F89
    push hl
    ldh a, [$FFC6]
    ld l, a
    ldh a, [$FFC7]
    ld h, a
    call Func_000_16F5
    pop hl
    ld a, [hl+]
    ld de, $C364
    add a, e
    ld e, a
    jr nc, Jump_002_67D5
    inc d

Jump_002_67D5::
    call Func_000_2123
    ldh a, [$FFCB]
    ld c, $5F
    call Func_000_1F89
    push hl
    ldh a, [$FFC6]
    ld l, a
    ldh a, [$FFC7]
    ld h, a
    call Func_000_16F5
    pop hl
    ld a, [hl+]
    ld de, $C364
    add a, e
    ld e, a
    jr nc, Jump_002_67F3
    inc d

Jump_002_67F3::
    call Func_000_2123
    ld a, [hl+]
    ld de, $C364
    add a, e
    ld e, a
    jr nc, Jump_002_67FF
    inc d

Jump_002_67FF::
    ldh a, [$FFCB]
    ld c, $55
    call Func_000_1F80
    ldh a, [$FFC6]
    bit 7, a
    jr z, Jump_002_6811
    ld a, $C2
    ld [de], a
    jr Jump_002_6829

Jump_002_6811::
    bit 2, a
    jr z, Jump_002_6818
    ld a, $C1
    ld [de], a

Jump_002_6818::
    ldh a, [$FFC6]
    bit 0, a
    jr z, Jump_002_6829
    ld a, e
    sub a, $14
    ld e, a
    ld a, d
    sbc a, $00
    ld d, a
    ld a, $C0
    ld [de], a

Jump_002_6829::
    pop de
    inc de
    pop bc
    dec b
    jp nz, Jump_002_679A
    xor a, a
    ld [$0100], a
    ret

Data_002_6835:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $54, $2B, $3F, $51, $5A, $31, $45, $57, $60, $37, $4B, $5D

Func_002_6841::
    ldh a, [$FFA5]
    and a, $F8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add a, $00
    ld e, a
    ld a, d
    adc a, $98
    ld d, a
    ld a, d
    and a, $9B
    ld d, a
    ldh a, [$FFA1]
    srl a
    srl a
    srl a
    add a, e
    ld e, a
    jr nc, Jump_002_6869
    inc d

Jump_002_6869::
    ld a, e
    add a, $80
    ld e, a
    ld a, d
    adc a, $01
    ld d, a
    ld a, d
    and a, $9B
    ld d, a
    ld l, e
    ld h, d
    push hl
    ld de, $C364
    ld bc, $1406
    xor a, a
    call Func_000_160B
    pop hl
    ld a, [$C525]
    or a, a
    ret z
    ld a, $01
    ldh [$FF4F], a
    ld a, $02
    ldh [$FF70], a
    ld de, $D1CC
    ld bc, $1406
    xor a, a
    call Func_000_160B
    ld a, $00
    ldh [$FF70], a
    ld a, $00
    ldh [$FF4F], a
    ret

Func_002_68A3::
    push hl
    push bc

Jump_002_68A5::
    push hl
    push bc

Jump_002_68A7::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_002_68A7
    pop bc
    pop hl
    ld a, l
    add a, $14
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec c
    jr nz, Jump_002_68A5
    pop bc
    pop hl
    ld a, l
    add a, $68
    ld l, a
    ld a, h
    adc a, $0E
    ld h, a
    ld a, [$C525]
    or a, a
    ret z
    ld a, $02
    ldh [$FF70], a

Jump_002_68CD::
    push hl
    push bc

Jump_002_68CF::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_002_68CF
    pop bc
    pop hl
    ld a, l
    add a, $14
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec c
    jr nz, Jump_002_68CD
    ld a, $00
    ldh [$FF70], a
    ret

Data_002_68E6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $D0, $D1, $D2, $D3, $D4, $B7, $B6, $C7
    db $EB, $C3, $C3, $C3, $B7, $B6, $C3, $EC, $C3, $C3, $C3, $B7, $B6, $C3, $EA, $ED
    db $C3, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B4, $B5

Data_002_6910:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $00A910, $4E

Data_002_695E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0
    ds $11, $B1
    INCBIN "dwm2-cobi-us.gbc", $00A970, $4E
    ds $11, $B4
    db $B5

Func_002_69D0::
    ld a, [$C8CB]
    and a, $03
    ret z
    ld hl, $C300
    ld de, $C198
    ld a, [$C8CB]
    bit 7, a
    jr nz, Jump_002_69EB
    ld a, e
    add a, $04
    ld e, a
    ld a, d
    adc a, $01
    ld d, a

Jump_002_69EB::
    push hl
    push de
    ld b, $64

Jump_002_69EF::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_002_69EF
    pop de
    pop hl
    ld a, [$C525]
    or a, a
    jr z, Jump_002_6A1F
    ld a, e
    add a, $68
    ld e, a
    ld a, d
    adc a, $0E
    ld d, a
    ld a, l
    add a, $68
    ld l, a
    ld a, h
    adc a, $0E
    ld h, a
    ld a, $02
    ldh [$FF70], a
    ld b, $64

Jump_002_6A13::
    ld a, [de]
    inc de
    and a, $07
    ld [hl+], a
    dec b
    jr nz, Jump_002_6A13
    ld a, $00
    ldh [$FF70], a

Jump_002_6A1F::
    ldh a, [$FFA5]
    and a, $F8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add a, $00
    ld e, a
    ld a, d
    adc a, $98
    ld d, a
    ld a, d
    and a, $9B
    ld d, a
    ldh a, [$FFA1]
    srl a
    srl a
    srl a
    add a, e
    ld e, a
    jr nc, Jump_002_6A47
    inc d

Jump_002_6A47::
    ld a, [$C8CB]
    bit 7, a
    jr nz, Jump_002_6A5A
    ld a, e
    add a, $A0
    ld e, a
    ld a, d
    adc a, $01
    ld d, a
    ld a, d
    and a, $9B
    ld d, a

Jump_002_6A5A::
    ld hl, $C8CC
    inc [hl]
    ld a, [$C8CC]
    and a, $01
    dec a
    ret nz
    ld a, [$C8CC]
    srl a
    and a, $03
    rst $00
    dw Jump_002_6A75
    dw Jump_002_6AA8
    dw Jump_002_6ADB
    dw Jump_002_6ADB

Jump_002_6A75::
    ld a, [$C8CB]
    bit 0, a
    jr z, Jump_002_6A92
    push de
    ld hl, $C328
    ld de, Data_002_6B8C
    ld b, $01
    call Func_002_6B5D
    pop de
    ld l, e
    ld h, d
    ld bc, $1405
    call Func_002_6B19
    ret

Jump_002_6A92::
    push de
    ld hl, $C314
    ld de, Data_002_6BA0
    ld b, $03
    call Func_002_6B5D
    pop de
    ld l, e
    ld h, d
    ld bc, $1405
    call Func_002_6B19
    ret

Jump_002_6AA8::
    ld a, [$C8CB]
    bit 0, a
    jr z, Jump_002_6AC5
    push de
    ld hl, $C314
    ld de, Data_002_6BA0
    ld b, $03
    call Func_002_6B5D
    pop de
    ld l, e
    ld h, d
    ld bc, $1405
    call Func_002_6B19
    ret

Jump_002_6AC5::
    push de
    ld hl, $C328
    ld de, Data_002_6B8C
    ld b, $01
    call Func_002_6B5D
    pop de
    ld l, e
    ld h, d
    ld bc, $1405
    call Func_002_6B19
    ret

Jump_002_6ADB::
    ld a, [$C8CB]
    bit 0, a
    jr z, Jump_002_6B04
    push de
    ld hl, $C300
    ld de, Data_002_6BDC
    ld b, $05
    call Func_002_6B5D
    pop de
    ld l, e
    ld h, d
    ld bc, $1405
    call Func_002_6B19
    ld a, [$C8CB]
    and a, $80
    ld [$C8CB], a
    xor a, a
    ld [$C8CC], a
    ret

Jump_002_6B04::
    ld l, e
    ld h, d
    ld bc, $1405
    call Func_002_6B19
    ld a, [$C8CB]
    and a, $80
    ld [$C8CB], a
    xor a, a
    ld [$C8CC], a
    ret

Func_002_6B19::
    push bc
    push hl
    ld de, $C300
    xor a, a
    call Func_000_160B
    pop hl
    push hl
    ld a, h
    and a, $9C
    push af
    ld a, $21
    add a, l
    ld l, a
    jr nc, Jump_002_6B2F
    inc h

Jump_002_6B2F::
    ld a, h
    and a, $03
    ld h, a
    pop af
    or a, h
    ld h, a
    ld a, l
    ld [$C554], a
    ld a, h
    ld [$C555], a
    pop hl
    pop bc
    ld a, [$C525]
    or a, a
    ret z
    ld a, $01
    ldh [$FF4F], a
    ld a, $02
    ldh [$FF70], a
    ld de, $D168
    xor a, a
    call Func_000_160B
    ld a, $00
    ldh [$FF4F], a
    ld a, $00
    ldh [$FF70], a
    ret

Func_002_6B5D::
    push hl
    push bc

Jump_002_6B5F::
    ld c, $14

Jump_002_6B61::
    ld a, [de]
    inc de
    ld [hl+], a
    dec c
    jr nz, Jump_002_6B61
    dec b
    jr nz, Jump_002_6B5F
    pop bc
    pop hl
    ld a, l
    add a, $68
    ld l, a
    ld a, h
    adc a, $0E
    ld h, a
    ld a, [$C525]
    or a, a
    ret z
    ld a, $02
    ldh [$FF70], a

Jump_002_6B7D::
    ld c, $14

Jump_002_6B7F::
    xor a, a
    ld [hl+], a
    dec c
    jr nz, Jump_002_6B7F
    dec b
    jr nz, Jump_002_6B7D
    ld a, $00
    ldh [$FF70], a
    ret

Data_002_6B8C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B6
    ds $12, $C3
    db $B7

Data_002_6BA0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0
    ds $12, $B1
    db $B2, $B6
    ds $12, $C3
    db $B7, $B3
    ds $12, $B4
    db $B5

Data_002_6BDC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0
    ds $12, $B1
    db $B2, $B6, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8A, $8B, $8C, $8D
    db $8E, $8F, $90, $91, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F
    db $A0, $A1, $A2, $A3, $B7, $B3
    ds $12, $B4
    db $B5

Func_002_6C40::
    ld a, [$C46B]
    or a, a
    jr nz, Jump_002_6C46

Jump_002_6C46::
    ld a, [$C46B]
    and a, $0F
    rst $00
    dw Jump_002_6C5F
    dw Jump_002_6C89
    dw Jump_002_6D28
    dw Jump_002_6D4D
    dw Jump_002_6DEE
    dw Jump_002_6E25
    dw Jump_002_6C5E
    dw Jump_002_6C5E
    dw Jump_002_6C5E

Jump_002_6C5E::
    ret

Jump_002_6C5F::
    ld a, $02
    call Func_000_122D
    call Func_000_3290
    ld hl, $C46B
    inc [hl]
    ld a, [$C914]
    bit 7, a
    jr z, Jump_002_6C7F
    xor a, a
    ld [$C46C], a
    ld [$C46E], a
    ld a, $78
    call Func_000_1278
    ret

Jump_002_6C7F::
    xor a, a
    ld [$C46C], a
    ld a, $3B
    ld [$C46E], a
    ret

Jump_002_6C89::
    ld a, [$C46E]
    inc a
    ld [$C46E], a
    cp a, $3C
    ret c
    ld a, $61
    call Func_000_1278
    call Func_002_6CD4
    xor a, a
    ld [$C46C], a
    ld [$C46D], a
    ld [$C46E], a
    ld [$C46F], a
    ld [$C470], a
    ld [$C471], a
    ld [$C472], a
    ld hl, $C0F0
    ld b, $90

Jump_002_6CB6::
    ldh a, [$FFA1]
    ld [hl+], a
    dec b
    jr nz, Jump_002_6CB6
    ld hl, $C46B
    inc [hl]
    ld a, $1E
    ld [$C46D], a
    xor a, a
    ld [$D780], a
    ld [$D782], a
    call Func_002_4463
    xor a, a
    ld [$D780], a
    ret

Func_002_6CD4::
    ldh a, [$FFA5]
    and a, $F8
    ld l, a
    ld h, $00
    sla l
    rl h
    sla l
    rl h
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $98
    ld h, a
    ld a, h
    and a, $9B
    ld h, a
    ldh a, [$FFA1]
    srl a
    srl a
    srl a
    add a, $14
    and a, $1F
    add a, l
    ld l, a
    jr nc, Jump_002_6D00
    inc h

Jump_002_6D00::
    ld c, $12

Jump_002_6D02::
    push hl
    ld b, $0C

Jump_002_6D05::
    ld a, $C4
    call Func_000_1211
    ld a, l
    push af
    and a, $E0
    ld l, a
    pop af
    inc a
    and a, $1F
    or a, l
    ld l, a
    dec b
    jr nz, Jump_002_6D05
    pop hl
    ld a, $20
    add a, l
    ld l, a
    jr nc, Jump_002_6D20
    inc h

Jump_002_6D20::
    ld a, h
    and a, $9B
    ld h, a
    dec c
    jr nz, Jump_002_6D02
    ret

Jump_002_6D28::
    ld a, [$C46D]
    and a, $01
    ld [$C46C], a
    ld a, [$C46D]
    dec a
    ld [$C46D], a
    ret nz
    ld hl, $C46B
    inc [hl]
    ld a, $01
    ld [$C46E], a
    di
    ld a, $02
    ldh [$FF45], a
    ld a, $02
    ld [$C5E1], a
    ei
    ret

Jump_002_6D4D::
    ld a, $01
    ld [$C46C], a
    ld a, [$C5F0]
    and a, $07
    jr nz, Jump_002_6D75
    ld a, [$C46E]
    swap a
    and a, $0F
    inc a
    ld b, a
    ld a, [$C46E]
    add a, b
    ld [$C46E], a
    cp a, $38
    jr c, Jump_002_6D75
    ld hl, $C46B
    inc [hl]
    xor a, a
    ld [$C46F], a

Jump_002_6D75::
    ld a, [$C46E]
    ldh [$FFC6], a
    ld a, [$C5F0]
    rra
    rra
    and a, $0F
    ld e, a
    ld d, $00
    ld a, [$C5F0]
    and a, $03
    cp a, $00
    jr nz, Jump_002_6D96
    ld bc, $C0F0
    ld a, $24
    ldh [$FFC7], a
    jr Jump_002_6DB7

Jump_002_6D96::
    cp a, $01
    jr nz, Jump_002_6DA3
    ld bc, $C114
    ld a, $48
    ldh [$FFC7], a
    jr Jump_002_6DB7

Jump_002_6DA3::
    cp a, $02
    jr nz, Jump_002_6DB0
    ld bc, $C138
    ld a, $6C
    ldh [$FFC7], a
    jr Jump_002_6DB7

Jump_002_6DB0::
    ld bc, $C15C
    ld a, $90
    ldh [$FFC7], a

Jump_002_6DB7::
    inc e
    ld a, e
    and a, $0F
    ld e, a
    ld hl, Data_002_6DDE
    add hl, de
    push bc
    ld c, [hl]
    ldh a, [$FFC6]
    call Func_000_1682
    pop bc
    bit 3, e
    jr z, Jump_002_6DD1
    ldh a, [$FFA1]
    sub a, h
    jr Jump_002_6DD4

Jump_002_6DD1::
    ldh a, [$FFA1]
    add a, h

Jump_002_6DD4::
    ld [bc], a
    inc bc
    ld [bc], a
    inc bc
    ldh a, [$FFC7]
    cp a, c
    jr nz, Jump_002_6DB7
    ret

Data_002_6DDE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $60, $B6, $EC, $FF, $EC, $B6, $60, $00, $60, $B6, $EC, $FF, $EC, $B6, $60

Jump_002_6DEE::
    ld a, [$C5F0]
    and a, $0F
    jr nz, Jump_002_6E0B
    ld a, [$C46F]
    inc a
    ld [$C46F], a
    cp a, $04
    jr nz, Jump_002_6E0B
    call Func_002_432A
    ld hl, $C46B
    inc [hl]
    xor a, a
    ld [$C5E1], a

Jump_002_6E0B::
    ld a, [$C46F]
    ld hl, Data_002_6E20
    add a, l
    ld l, a
    jr nc, Jump_002_6E16
    inc h

Jump_002_6E16::
    ld a, [hl]
    ld [$C5E9], a
    call Func_002_432A
    jp Jump_002_6D75

Data_002_6E20:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D2, $81, $40, $00, $00

Jump_002_6E25::
    call Func_000_3290
    ld hl, Func_002_604B
    ld b, $02
    rst $10
    xor a, a
    ld [$D780], a
    ld [$D783], a
    ld [$D781], a
    ld a, [$C914]
    bit 7, a
    jr nz, Jump_002_6EBA
    ld a, [$C8CA]
    cp a, $F0
    jr nz, Jump_002_6E59
    push af
    ld a, $80
    ld [$CC44], a
    ld a, [$CD0D]
    ld [$C190], a
    ld a, [$CD0E]
    ld [$C191], a
    pop af

Jump_002_6E59::
    cp a, $FF
    jr z, Jump_002_6E61
    ld a, $00
    ldh [$FF98], a

Jump_002_6E61::
    xor a, a
    ldh [$FF98], a
    ld a, [$C8C8]
    ldh [$FF8E], a
    ld a, [$C8C9]
    ldh [$FF91], a
    ldh a, [$FF98]
    ld [$C8EF], a
    ld [$C8F4], a
    ld [$C8F9], a
    ldh a, [$FF8E]
    ld [$C8F0], a
    ld [$C8F5], a
    ld [$C8FA], a
    ldh a, [$FF91]
    ld [$C8F1], a
    ld [$C8F6], a
    ld [$C8FB], a
    ld a, [$CC44]
    bit 7, a
    jr nz, Jump_002_6EA5
    ld a, $01
    ld [$C5DB], a
    ld a, $00
    ld [$C5DC], a
    ld hl, $C5DF
    inc [hl]
    ret

Jump_002_6EA5::
    ld a, $01
    ld [$C5DB], a
    ld a, $05
    ld [$C5DC], a
    ld hl, $C5DF
    inc [hl]
    ld hl, Func_0A1_4474
    ld b, $A1
    rst $10
    ret

Jump_002_6EBA::
    ld a, [$CC44]
    bit 7, a
    jr z, Jump_002_6EC7
    ld hl, Func_060_6C96
    ld b, $60
    rst $10

Jump_002_6EC7::
    ld a, [$C833]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $0A
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    ld a, [hl]
    dec hl
    dec hl
    dec hl
    bit 7, a
    jp z, Jump_002_6F59
    push hl
    ld a, $01
    ld [$C5DB], a
    ld a, $00
    ld [$C5DC], a
    ld hl, $C5DF
    inc [hl]
    pop hl
    ld a, [hl]
    and a, $3F
    push af
    add a, a
    add a, a
    add a, a
    ld hl, Data_002_7006
    add a, l
    ld l, a
    jr nc, Jump_002_6EFF
    inc h

Jump_002_6EFF::
    ld a, [hl+]
    ldh [$FF90], a
    ld a, [hl+]
    ldh [$FF8F], a
    ld a, [hl+]
    ldh [$FF92], a
    ld a, [hl+]
    ldh [$FF8E], a
    ld a, [hl]
    ldh [$FF91], a
    xor a, a
    ld [$C950], a
    xor a, a
    ld [$CC44], a
    ld a, $80
    ld [$C893], a
    xor a, a
    ld [$CCE9], a
    ld de, $0165
    call Func_000_181B
    jr nc, Jump_002_6F2D
    ld de, $0167
    call Func_000_1845

Jump_002_6F2D::
    ld de, $01C4
    call Func_000_181B
    jr nc, Jump_002_6F3B
    ld de, $01C5
    call Func_000_1845

Jump_002_6F3B::
    pop af
    cp a, $01
    jp nz, Jump_002_6FDE
    ld a, $1A
    ld [$C916], a
    xor a, a
    ld [$C917], a
    ld hl, Func_013_405C
    ld b, $13
    rst $10
    ld hl, Func_010_4008
    ld b, $10
    rst $10
    jp Jump_002_6FDE

Jump_002_6F59::
    ld a, [hl]
    bit 7, a
    jr nz, Jump_002_6F73
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    ld [$CD05], a
    ld hl, Func_060_4001
    ld b, $60
    rst $10
    ld hl, Func_060_6C96
    ld b, $60
    rst $10
    jr Jump_002_6F7E

Jump_002_6F73::
    and a, $3F
    ld [$CC42], a
    ld hl, Func_060_6CD1
    ld b, $60
    rst $10

Jump_002_6F7E::
    ld a, $80
    ld [$C893], a
    ld a, $01
    ld [$C5DB], a
    ld a, $05
    ld [$C5DC], a
    ld hl, $C5DF
    inc [hl]
    ld a, [$CD0D]
    ld [$C190], a
    ld a, [$CD0E]
    ld [$C191], a
    ld a, [$CD08]
    swap a
    and a, $0F
    ldh [$FF8F], a
    ld a, [$CD08]
    and a, $0F
    ldh [$FF92], a
    ld a, [$CD09]
    ldh [$FF8E], a
    ld a, [$CD0A]
    ldh [$FF91], a
    xor a, a
    ld [$C950], a
    ld a, $80
    ld [$CC44], a
    ld hl, Func_0A1_4435
    ld b, $A1
    rst $10
    ld a, $87
    ld [$CC44], a
    ld a, $01
    ld [$C190], a
    ld [$C191], a
    xor a, a
    ldh [$FF8F], a
    ldh [$FF92], a
    ld a, $40
    ldh [$FF8E], a
    ldh [$FF91], a

Jump_002_6FDE::
    xor a, a
    ldh [$FF98], a
    ldh a, [$FF98]
    ld [$C8EF], a
    ld [$C8F4], a
    ld [$C8F9], a
    ldh a, [$FF8E]
    ld [$C8F0], a
    ld [$C8F5], a
    ld [$C8FA], a
    ldh a, [$FF91]
    ld [$C8F1], a
    ld [$C8F6], a
    ld [$C8FB], a
    xor a, a
    ldh [$FF93], a
    ret

Data_002_7006:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $00B006, $68

Func_002_706E::
    ld a, $0A
    ld [$0100], a
    ld a, $01
    ld [$4100], a
    ld a, [$BB00]
    cp a, $55
    jr z, Jump_002_7083
    ld a, $01
    jr Jump_002_7098

Jump_002_7083::
    call Func_002_70A2
    or a, a
    jr z, Jump_002_708D
    ld a, $02
    jr Jump_002_7098

Jump_002_708D::
    call Func_002_7111
    or a, a
    jr z, Jump_002_7097
    ld a, $02
    jr Jump_002_7098

Jump_002_7097::
    xor a, a

Jump_002_7098::
    ldh [$FFC6], a
    xor a, a
    ld [$0100], a
    ld [$4100], a
    ret

Func_002_70A2::
    ld a, $01
    ld [$4100], a
    ld hl, $A06F
    ld bc, $029A
    ld de, $0000

Jump_002_70B0::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_70B6
    inc d

Jump_002_70B6::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_70BC
    inc d

Jump_002_70BC::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_70C2
    inc d

Jump_002_70C2::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_70C8
    inc d

Jump_002_70C8::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_70CE
    inc d

Jump_002_70CE::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_70D4
    inc d

Jump_002_70D4::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_70DA
    inc d

Jump_002_70DA::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_70E0
    inc d

Jump_002_70E0::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_70E6
    inc d

Jump_002_70E6::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_70EC
    inc d

Jump_002_70EC::
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_002_70B0
    ld a, e
    xor a, $FF
    ld e, a
    ld a, d
    xor a, $FF
    ld d, a
    ld a, e
    add a, $21
    ld e, a
    ld a, d
    adc a, $43
    ld d, a
    ld hl, $BA73
    ld a, [hl+]
    cp a, e
    jr nz, Jump_002_710E
    ld a, [hl]
    cp a, d
    jr nz, Jump_002_710E
    xor a, a
    ret

Jump_002_710E::
    ld a, $01
    ret

Func_002_7111::
    ld a, $03
    ld [$4100], a
    ld hl, $A000
    ld bc, $0333
    ld de, $0000

Jump_002_711F::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_7125
    inc d

Jump_002_7125::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_712B
    inc d

Jump_002_712B::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_7131
    inc d

Jump_002_7131::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_7137
    inc d

Jump_002_7137::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_713D
    inc d

Jump_002_713D::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_7143
    inc d

Jump_002_7143::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_7149
    inc d

Jump_002_7149::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_714F
    inc d

Jump_002_714F::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_7155
    inc d

Jump_002_7155::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_715B
    inc d

Jump_002_715B::
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_002_711F
    ld a, e
    xor a, $FF
    ld e, a
    ld a, d
    xor a, $FF
    ld d, a
    ld a, e
    add a, $34
    ld e, a
    ld a, d
    adc a, $12
    ld d, a
    ld a, [hl+]
    cp a, e
    jr nz, Jump_002_717A
    ld a, [hl]
    cp a, d
    jr nz, Jump_002_717A
    xor a, a
    ret

Jump_002_717A::
    ld a, $01
    ret

Func_002_717D::
    ld a, $0A
    ld [$0100], a
    ld a, [$C8C3]
    or a, a
    jr nz, Jump_002_719A
    inc a
    ld [$C8C3], a
    call Func_002_72B0
    call Func_002_7247
    call Func_002_71ED
    call Func_002_72E9
    jr Jump_002_71AA

Jump_002_719A::
    dec a
    jr nz, Jump_002_71A2
    call Func_002_71B2
    jr Jump_002_71AA

Jump_002_71A2::
    ld a, [$C8C3]
    or a, $80
    ld [$C8C3], a

Jump_002_71AA::
    xor a, a
    ld [$0100], a
    ld [$4100], a
    ret

Func_002_71B2::
    ld a, [$C8C4]
    ld [$D7F1], a
    ld c, $6F
    call Func_000_1682
    ld a, l
    add a, $6F
    ld l, a
    ld a, h
    adc a, $A0
    ld h, a
    ld a, l
    ld [$D7F3], a
    ld a, h
    ld [$D7F4], a
    ld a, $01
    ld [$D7F2], a
    ld hl, Func_01D_7492
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    cp a, $FF
    ret nz
    ld a, [$C8C4]
    inc a
    ld [$C8C4], a
    cp a, $1E
    ret nz
    ld hl, $C8C3
    inc [hl]
    ret

Func_002_71ED::
    ld hl, $AD71
    ld de, $B356
    ld bc, $0309

Jump_002_71F6::
    push bc
    ld a, $01
    ld [$4100], a
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    ld b, a
    xor a, a
    ld [$4100], a
    ld a, c
    ld [de], a
    inc de
    ld a, b
    ld [de], a
    inc de
    ld a, $01
    ld [$4100], a
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    ld b, a
    xor a, a
    ld [$4100], a
    ld a, c
    ld [de], a
    inc de
    ld a, b
    ld [de], a
    inc de
    pop bc
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_002_71F6
    ld b, $6F

Jump_002_7225::
    ld a, $01
    ld [$4100], a
    ld a, [hl+]
    ld c, a
    xor a, a
    ld [$4100], a
    ld a, c
    ld [de], a
    inc de
    dec b
    jr nz, Jump_002_7225
    ld a, $01
    ld [$4100], a
    ld de, $A000
    ld b, $6F

Jump_002_7240::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_002_7240
    ret

Func_002_7247::
    ld hl, $A000
    ld bc, $0333

Jump_002_724D::
    push bc
    ld a, $03
    ld [$4100], a
    ld a, [hl+]
    ld c, a
    ld a, [hl-]
    ld b, a
    ld a, $02
    ld [$4100], a
    ld a, c
    ld [hl+], a
    ld a, b
    ld [hl+], a
    ld a, $03
    ld [$4100], a
    ld a, [hl+]
    ld c, a
    ld a, [hl-]
    ld b, a
    ld a, $02
    ld [$4100], a
    ld a, c
    ld [hl+], a
    ld a, b
    ld [hl+], a
    ld a, $03
    ld [$4100], a
    ld a, [hl+]
    ld c, a
    ld a, [hl-]
    ld b, a
    ld a, $02
    ld [$4100], a
    ld a, c
    ld [hl+], a
    ld a, b
    ld [hl+], a
    ld a, $03
    ld [$4100], a
    ld a, [hl+]
    ld c, a
    ld a, [hl-]
    ld b, a
    ld a, $02
    ld [$4100], a
    ld a, c
    ld [hl+], a
    ld a, b
    ld [hl+], a
    ld a, $03
    ld [$4100], a
    ld a, [hl+]
    ld c, a
    ld a, [hl-]
    ld b, a
    ld a, $02
    ld [$4100], a
    ld a, c
    ld [hl+], a
    ld a, b
    ld [hl+], a
    pop bc
    dec bc
    ld a, b
    or a, c
    jp nz, Jump_002_724D
    ret

Func_002_72B0::
    ld a, $01
    ld [$4100], a
    ld hl, Data_002_75F7
    ld de, $BB01

Jump_002_72BB::
    push hl
    ld a, [hl+]
    ldh [$FFC6], a
    ld a, [hl+]
    ldh [$FFC7], a
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    ld b, a
    ldh a, [$FFC6]
    ld l, a
    ldh a, [$FFC7]
    ld h, a
    ld a, l
    or a, h
    jr nz, Jump_002_72D7
    pop hl
    ld a, $80
    ld [$C88D], a
    ret

Jump_002_72D7::
    ld a, [de]
    ld [hl+], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_002_72D7
    pop hl
    ld a, $04
    add a, l
    ld l, a
    jr nc, Jump_002_72E7
    inc h

Jump_002_72E7::
    jr Jump_002_72BB

Func_002_72E9::
    xor a, a
    ldh [$FF70], a
    ld a, $01
    ld [$4100], a
    ld hl, $BEC0
    ld a, [$BEF3]
    cp a, $01
    jr z, Jump_002_72FF
    and a, a
    jr z, Jump_002_72FF
    ret

Jump_002_72FF::
    ld bc, $00D8
    ld de, $CE9B

Jump_002_7305::
    ld a, [hl+]
    ld [de], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_002_7305
    ret

Func_002_730E::
    ld hl, $CE9B
    ld bc, $00D8
    ld de, $BEC0
    ld a, $01
    ld [$4100], a
    xor a, a
    ldh [$FF70], a
    ld a, [$CECE]
    cp a, $01
    jr z, Jump_002_732A
    and a, a
    jr z, Jump_002_732A
    ret

Jump_002_732A::
    ld a, [hl+]
    ld [de], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_002_732A
    ret

Func_002_7333::
    ld a, $0A
    ld [$0100], a
    ld a, [$C8C3]
    or a, a
    jr nz, Jump_002_7364
    inc a
    ld [$C8C3], a
    call Func_002_7598
    jr Jump_002_7359

Func_002_7347::
    ld a, $0A
    ld [$0100], a
    ld a, [$C8C3]
    or a, a
    jr nz, Jump_002_7364
    inc a
    ld [$C8C3], a
    call Func_002_755E

Jump_002_7359::
    call Func_002_7491
    call Func_002_741B
    call Func_002_730E
    jr Jump_002_7377

Jump_002_7364::
    dec a
    jr nz, Jump_002_736C
    call Func_002_73E6
    jr Jump_002_7377

Jump_002_736C::
    call Func_002_737F
    ld a, [$C8C3]
    or a, $80
    ld [$C8C3], a

Jump_002_7377::
    xor a, a
    ld [$0100], a
    ld [$4100], a
    ret

Func_002_737F::
    ld a, $01
    ld [$4100], a
    ld hl, $A06F
    ld bc, $029A
    ld de, $0000

Jump_002_738D::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_7393
    inc d

Jump_002_7393::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_7399
    inc d

Jump_002_7399::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_739F
    inc d

Jump_002_739F::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_73A5
    inc d

Jump_002_73A5::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_73AB
    inc d

Jump_002_73AB::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_73B1
    inc d

Jump_002_73B1::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_73B7
    inc d

Jump_002_73B7::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_73BD
    inc d

Jump_002_73BD::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_73C3
    inc d

Jump_002_73C3::
    ld a, [hl+]
    add a, e
    ld e, a
    jr nc, Jump_002_73C9
    inc d

Jump_002_73C9::
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_002_738D
    ld a, e
    xor a, $FF
    ld e, a
    ld a, d
    xor a, $FF
    ld d, a
    ld a, e
    add a, $21
    ld e, a
    ld a, d
    adc a, $43
    ld d, a
    ld hl, $BA73
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl], a
    ret

Func_002_73E6::
    ld a, [$C8C4]
    ld [$D7F1], a
    ld c, $6F
    call Func_000_1682
    ld a, l
    add a, $6F
    ld l, a
    ld a, h
    adc a, $A0
    ld h, a
    ld a, l
    ld [$D7F3], a
    ld a, h
    ld [$D7F4], a
    ld a, $01
    ld [$D7F2], a
    ld hl, Func_01D_6E39
    ld b, $1D
    rst $10
    ld a, [$C8C4]
    inc a
    ld [$C8C4], a
    cp a, $1E
    ret nz
    ld hl, $C8C3
    inc [hl]
    ret

Func_002_741B::
    ld hl, $B356
    ld de, $AD71
    ld bc, $0309

Jump_002_7424::
    push bc
    xor a, a
    ld [$4100], a
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    ld b, a
    ld a, $01
    ld [$4100], a
    ld a, c
    ld [de], a
    inc de
    ld a, b
    ld [de], a
    inc de
    xor a, a
    ld [$4100], a
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    ld b, a
    ld a, $01
    ld [$4100], a
    ld a, c
    ld [de], a
    inc de
    ld a, b
    ld [de], a
    inc de
    pop bc
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_002_7424
    ld b, $6F

Jump_002_7453::
    xor a, a
    ld [$4100], a
    ld a, [hl+]
    ld c, a
    ld a, $01
    ld [$4100], a
    ld a, c
    ld [de], a
    inc de
    dec b
    jr nz, Jump_002_7453
    ld hl, $A000
    ld b, $6F

Jump_002_7469::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_002_7469
    ret

Func_002_7470::
    ld a, $02
    ld [$4100], a
    ld hl, $A000
    ld bc, $2000
    ld a, $FF
    call Func_000_0949
    ld a, $03
    ld [$4100], a
    ld hl, $A000
    ld bc, $2000
    ld a, $FF
    call Func_000_0949
    ret

Func_002_7491::
    ld a, [$C94E]
    or a, a
    jr z, Jump_002_749A
    call Func_002_7470

Jump_002_749A::
    ld a, [$CC44]
    bit 7, a
    jr z, Jump_002_74AC
    ld hl, Func_060_6C96
    ld b, $60
    rst $10
    ld a, $0A
    ld [$0100], a

Jump_002_74AC::
    ld hl, $A000
    ld bc, $0333
    ld de, $0000

Jump_002_74B5::
    push bc
    ld a, $02
    ld [$4100], a
    ld a, [hl+]
    ld c, a
    ld a, [hl-]
    ld b, a
    ld a, $03
    ld [$4100], a
    ld a, c
    ld [hl+], a
    add a, e
    ld e, a
    jr nc, Jump_002_74CB
    inc d

Jump_002_74CB::
    ld a, b
    ld [hl+], a
    add a, e
    ld e, a
    jr nc, Jump_002_74D2
    inc d

Jump_002_74D2::
    ld a, $02
    ld [$4100], a
    ld a, [hl+]
    ld c, a
    ld a, [hl-]
    ld b, a
    ld a, $03
    ld [$4100], a
    ld a, c
    ld [hl+], a
    add a, e
    ld e, a
    jr nc, Jump_002_74E7
    inc d

Jump_002_74E7::
    ld a, b
    ld [hl+], a
    add a, e
    ld e, a
    jr nc, Jump_002_74EE
    inc d

Jump_002_74EE::
    ld a, $02
    ld [$4100], a
    ld a, [hl+]
    ld c, a
    ld a, [hl-]
    ld b, a
    ld a, $03
    ld [$4100], a
    ld a, c
    ld [hl+], a
    add a, e
    ld e, a
    jr nc, Jump_002_7503
    inc d

Jump_002_7503::
    ld a, b
    ld [hl+], a
    add a, e
    ld e, a
    jr nc, Jump_002_750A
    inc d

Jump_002_750A::
    ld a, $02
    ld [$4100], a
    ld a, [hl+]
    ld c, a
    ld a, [hl-]
    ld b, a
    ld a, $03
    ld [$4100], a
    ld a, c
    ld [hl+], a
    add a, e
    ld e, a
    jr nc, Jump_002_751F
    inc d

Jump_002_751F::
    ld a, b
    ld [hl+], a
    add a, e
    ld e, a
    jr nc, Jump_002_7526
    inc d

Jump_002_7526::
    ld a, $02
    ld [$4100], a
    ld a, [hl+]
    ld c, a
    ld a, [hl-]
    ld b, a
    ld a, $03
    ld [$4100], a
    ld a, c
    ld [hl+], a
    add a, e
    ld e, a
    jr nc, Jump_002_753B
    inc d

Jump_002_753B::
    ld a, b
    ld [hl+], a
    add a, e
    ld e, a
    jr nc, Jump_002_7542
    inc d

Jump_002_7542::
    pop bc
    dec bc
    ld a, b
    or a, c
    jp nz, Jump_002_74B5
    ld a, e
    xor a, $FF
    ld e, a
    ld a, d
    xor a, $FF
    ld d, a
    ld a, e
    add a, $34
    ld e, a
    ld a, d
    adc a, $12
    ld d, a
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl], a
    ret

Func_002_755E::
    ld a, [$CB7E]
    ld [$C83A], a
    ld hl, $CB7F
    ld de, $C83B
    ld bc, $0050
    call Func_000_0952
    ld a, [$C848]
    and a, $FD
    ld [$C848], a
    ld a, [$C858]
    and a, $FD
    ld [$C858], a
    ld a, [$C868]
    and a, $FD
    ld [$C868], a
    ld a, [$C878]
    and a, $FD
    ld [$C878], a
    ld a, [$C888]
    and a, $FD
    ld [$C888], a

Func_002_7598::
    ld a, $01
    ld [$4100], a
    ld hl, Data_002_75F7
    ld de, $BB01
    xor a, a
    ldh [$FFC8], a
    ldh [$FFC9], a

Jump_002_75A8::
    push hl
    ld a, [hl+]
    ldh [$FFC6], a
    ld a, [hl+]
    ldh [$FFC7], a
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    ld b, a
    ldh a, [$FFC6]
    ld l, a
    ldh a, [$FFC7]
    ld h, a
    ld a, l
    or a, h
    jr nz, Jump_002_75DA
    pop hl
    ld a, $55
    ld [$BB00], a
    ldh a, [$FFC8]
    ld l, a
    ldh a, [$FFC9]
    ld h, a
    ld a, l
    add a, $53
    ld l, a
    ld a, h
    adc a, $97
    ld h, a
    ld a, l
    ld [$BF98], a
    ld a, h
    ld [$BF99], a
    ret

Jump_002_75DA::
    ldh a, [$FFC8]
    add a, [hl]
    ldh [$FFC8], a
    ldh a, [$FFC9]
    adc a, $00
    ldh [$FFC9], a
    ld a, [hl+]
    ld [de], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_002_75DA
    pop hl
    ld a, $04
    add a, l
    ld l, a
    jr nc, Jump_002_75F5
    inc h

Jump_002_75F5::
    jr Jump_002_75A8

Data_002_75F7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $8A, $FF, $0E, $00, $0C, $C6, $91, $02, $D7, $CB, $6B, $00, $42, $CC, $B5, $00
    db $00, $00, $00, $00

Func_002_760B::
    ld a, $0A
    ld [$0100], a
    ld a, $01
    ld [$4100], a
    xor a, a
    ldh [$FFC8], a
    ldh [$FFC9], a
    ld a, [$BB00]
    cp a, $55
    jr nz, Jump_002_766D
    ld hl, $BB01
    ld de, $FF8A
    ld bc, $000E
    call Func_002_7674
    ld de, $C60C
    ld bc, $0291
    call Func_002_7674
    ld de, $CBD7
    ld bc, $006B
    call Func_002_7674
    ld de, $CC42
    ld bc, $00B5
    call Func_002_7674
    ldh a, [$FFC8]
    ld l, a
    ldh a, [$FFC9]
    ld h, a
    ld a, l
    add a, $53
    ld l, a
    ld a, h
    adc a, $97
    ld h, a
    ld a, [$BF98]
    ld c, a
    ld a, [$BF99]
    ld b, a
    ld a, c
    sub a, l
    ld c, a
    ld a, b
    sbc a, h
    ld b, a
    ld a, b
    or a, c
    jr z, Jump_002_766D
    xor a, a
    ld [$0100], a
    ret

Jump_002_766D::
    xor a, a
    ld [$0100], a
    ld c, $FF
    ret

Func_002_7674::
    ldh a, [$FFC8]
    add a, [hl]
    ldh [$FFC8], a
    ldh a, [$FFC9]
    adc a, $00
    ldh [$FFC9], a
    ld a, [hl+]
    ld [de], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, Func_002_7674
    ret

Func_002_7688::
    ld a, $0A
    ld [$0100], a
    ld a, $01
    ld [$4100], a
    xor a, a
    ldh [$FFC8], a
    ldh [$FFC9], a
    ld de, $BB01
    ld hl, $FF8A
    ld bc, $000E
    call Func_002_76DE
    ld hl, $C60C
    ld bc, $0291
    call Func_002_76DE
    ld hl, $CBD7
    ld bc, $006B
    call Func_002_76DE
    ld hl, $CC42
    ld bc, $00B5
    call Func_002_76DE
    ldh a, [$FFC8]
    ld l, a
    ldh a, [$FFC9]
    ld h, a
    ld a, l
    add a, $53
    ld l, a
    ld a, h
    adc a, $97
    ld h, a
    ld a, l
    ld [$BF98], a
    ld a, h
    ld [$BF99], a
    ld a, $55
    ld [$BB00], a
    xor a, a
    ld [$0100], a
    ret

Func_002_76DE::
    ldh a, [$FFC8]
    add a, [hl]
    ldh [$FFC8], a
    ldh a, [$FFC9]
    adc a, $00
    ldh [$FFC9], a
    ld a, [hl+]
    ld [de], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, Func_002_76DE
    ret

Func_002_76F2:: ; heuristic: follows a terminator; C0
    ld a, $0A
    ld [$0100], a
    ld a, [$C8C3]
    or a, a
    jr nz, Jump_002_7704
    inc a
    ld [$C8C3], a
    call Func_002_71ED

Jump_002_7704::
    call Func_002_71B2
    ld a, [$C8C3]
    cp a, $02
    jr nz, Jump_002_7713
    ld a, $80
    ld [$C8C3], a

Jump_002_7713::
    xor a, a
    ld [$0100], a
    ret

Func_002_7718::
    ld a, $0A
    ld [$0100], a
    ld a, [$C8C3]
    or a, a
    jr nz, Jump_002_772A
    inc a
    ld [$C8C3], a
    call Func_002_741B

Jump_002_772A::
    call Func_002_73E6
    ld a, [$C8C3]
    cp a, $02
    jr nz, Jump_002_7741
    ld a, $0A
    ld [$0100], a
    call Func_002_737F
    ld a, $80
    ld [$C8C3], a

Jump_002_7741::
    xor a, a
    ld [$0100], a
    ret
    ds $8B9, $00

Data_002_7FFF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00
