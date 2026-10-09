SECTION "Bank 03", ROMX[$4000], BANK[$03]
    db $03

Func_003_4001::
    xor a, a
    ld [$D067], a
    ld hl, $99C1
    ld a, l
    ld [$C554], a
    ld a, h
    ld [$C555], a
    ld a, $01
    jp Jump_000_077A

Func_003_4015::
    ld a, [$C5DD]
    bit 7, a
    jr z, Jump_003_4036
    call Func_003_4596
    ld a, [$C5DC]
    and a, $07
    rst $00
    dw Jump_003_4692
    dw Jump_003_5274
    dw Jump_003_5E89
    dw Jump_003_6A9D
    dw Jump_003_402F

Jump_003_402F::
    ld hl, Func_0F1_4001
    ld b, $F1
    rst $10
    ret

Jump_003_4036::
    ld a, [$C5DD]
    or a, a
    jp nz, Jump_003_40BE
    xor a, a
    ld [$CB7D], a
    ld a, [$C525]
    or a, a
    jr z, Jump_003_4073
    ld hl, $C49F
    ld bc, $0040
    ld a, $FF
    call Func_000_0949
    ld a, $7F
    ld [$C526], a
    call Func_000_0829
    ld a, $01
    ldh [$FF4F], a
    ld hl, $9800
    ld bc, $2020

Jump_003_4064::
    xor a, a
    call Func_000_121F
    dec b
    jr nz, Jump_003_4064
    ld b, $20
    dec c
    jr nz, Jump_003_4064
    xor a, a
    ldh [$FF4F], a

Jump_003_4073::
    ld hl, $C198
    ld bc, $0240
    ld a, $C3
    call Func_000_0949
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
    jr nc, Jump_003_40A6
    inc d

Jump_003_40A6::
    ld l, e
    ld h, d
    ld de, $C198
    ld bc, $1412
    call Func_003_42E3
    xor a, a
    ldh [$FFA1], a
    ldh [$FFA5], a
    call Func_003_42DA
    ld hl, $C5DD
    inc [hl]
    ret

Jump_003_40BE::
    ld hl, $8800
    ld de, $1202
    call Func_000_2E98
    ld hl, $9000
    ld de, $1007
    call Func_000_2E98
    ld hl, $C0A0
    ld bc, $0020
    xor a, a
    call Func_000_0949
    ld hl, $D09D
    ld bc, $0028
    xor a, a
    call Func_000_0949
    xor a, a
    ld [$C46D], a
    ld [$C46E], a
    ld [$C46F], a
    ld [$C470], a
    ld [$C471], a
    ld [$C472], a
    ld a, $0A
    ld [$0100], a
    ld a, $00
    ld [$4100], a
    call Func_003_4208
    xor a, a
    ld [$0100], a
    xor a, a
    ld [$D095], a
    call Func_003_42DA
    ld hl, $8800
    ld de, $1202
    call Func_000_2E98
    ld a, [$C525]
    or a, a
    jr z, Jump_003_414C
    ld hl, $C49F
    ld a, $39
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $FF
    ld [hl+], a
    ld a, $7F
    ld [hl+], a
    ld a, $3F
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld de, Data_003_7BF5
    ld b, $08

Jump_003_413E::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_003_413E
    ld a, $7F
    ld [$C526], a
    call Func_000_0829

Jump_003_414C::
    ld a, $80
    ld [$C5DD], a
    xor a, a
    ld [$D067], a
    ld hl, $99C0
    ld a, l
    ld [$C554], a
    ld a, h
    ld [$C555], a
    ld de, $0025
    call Func_000_181B
    ret c
    ld de, $019F
    call Func_000_181B
    ret nc
    ld a, [$C933]
    ld [$C6FD], a
    ld de, $0025
    call Func_000_1845
    ld a, [$CC37]
    set 6, a
    ld [$CC37], a
    ld a, $02
    ldh [$FF98], a
    ld [$C8EF], a
    ld [$C8F4], a
    ld [$C8F9], a
    ld a, $60
    ldh [$FF8E], a
    ld [$C8F0], a
    ld [$C8F5], a
    ld [$C8FA], a
    ld a, $50
    ldh [$FF91], a
    ld [$C8F1], a
    ld [$C8F6], a
    ld [$C8FB], a
    ld a, [$CB7D]
    ld [$C83A], a
    ld a, $00
    ld [$CB7F], a
    ld a, $01
    ld [$CB80], a
    ld a, $05
    ld [$CB81], a
    ld a, $00
    ld [$CB82], a
    ld a, $40
    ld [$CB83], a
    ld [$CB8A], a
    ld a, $30
    ld [$CB84], a
    ld [$CB8B], a
    ld a, $05
    ld [$CB85], a
    ld a, $00
    ld [$CB86], a
    ld a, $50
    ld [$CB87], a
    ld a, $62
    ld [$CB88], a
    xor a, a
    ld [$CB89], a
    xor a, a
    ld [$CB8C], a
    ld a, $01
    ld [$CB8D], a
    ld a, $02
    ld [$CB8E], a
    ld a, $E0
    ld [$CB93], a
    ld [$CB9A], a
    ld [$CBA3], a
    ld [$CBAA], a
    ret

Func_003_4208::
    ld a, [$C5DC]
    and a, $07
    rst $00
    dw Jump_003_4218
    dw Jump_003_4235
    dw Jump_003_423F
    dw Jump_003_4259
    dw Jump_003_4235

Jump_003_4218::
    call Func_003_499B
    call Func_003_4A27
    ld hl, Func_016_7A64
    ld b, $16
    rst $10
    ld a, [$C6FD]
    ld [$C0A2], a
    ld a, $00
    ld [$C0A3], a
    ld a, $00
    ld [$C0A6], a
    ret

Jump_003_4235::
    call Func_003_5E68
    call Func_003_581E
    call Func_003_5A07
    ret

Jump_003_423F::
    call Func_003_641E
    call Func_003_6595
    xor a, a
    ld [$C0A3], a
    ld [$C0A6], a
    ld [$C0A7], a
    ld [$C46D], a
    ld [$C46E], a
    ld [$C46F], a
    ret

Jump_003_4259::
    ld a, [$C5DC]
    bit 3, a
    jr z, Jump_003_427D
    ld de, $0025
    call Func_000_181B
    jr c, Jump_003_4270
    ld de, $019F
    call Func_000_181B
    jr c, Jump_003_4277

Jump_003_4270::
    ld a, $01
    ld [$C0A0], a
    jr Jump_003_427D

Jump_003_4277::
    ld a, $06
    ld [$C0A0], a
    ret

Jump_003_427D::
    call Func_003_7692
    call Func_003_7AE8
    ret

Func_003_4284::
    ld hl, $C198
    ld bc, $0240
    ld a, $C3
    call Func_000_0949
    ret

Func_003_4290::
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

Jump_003_429E::
    push bc
    push hl

Jump_003_42A0::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_003_42A0
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_003_429E
    ret

Func_003_42B0:: ; heuristic: follows a terminator; C0
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

Jump_003_42BE::
    push bc
    push hl

Jump_003_42C0::
    ld a, [de]
    cp a, $15
    jr c, Jump_003_42CB
    cp a, $A4
    jr nc, Jump_003_42CB
    ld a, $C3

Jump_003_42CB::
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_003_42C0
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_003_42BE
    ret

Func_003_42DA::
    ld hl, $9800
    ld de, $C198
    ld bc, $1412

Func_003_42E3::
    push bc
    push hl
    push de

Jump_003_42E6::
    ld a, [de]
    inc de
    call Func_000_1211
    ld a, l
    and a, $1F
    cp a, $1F
    jr z, Jump_003_42F5
    inc hl
    jr Jump_003_42F9

Jump_003_42F5::
    ld a, l
    and a, $E0
    ld l, a

Jump_003_42F9::
    dec b
    jr nz, Jump_003_42E6
    pop de
    ld a, e
    add a, $20
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop hl
    ld bc, $0020
    add hl, bc
    ld a, h
    and a, $9B
    ld h, a
    pop bc
    dec c
    jr nz, Func_003_42E3
    ret

Func_003_4313::
    push bc
    push hl

Jump_003_4315::
    ld a, [de]
    inc de
    call Func_000_121F
    dec b
    jr nz, Jump_003_4315
    ld a, e
    add a, $0E
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, Func_003_4313
    ret

Func_003_432F::
    ld hl, Func_002_5E82
    ld b, $02
    rst $10
    call Func_000_222B
    ret

Func_003_4339::
    call Func_003_4389
    ldh a, [$FF8E]
    ld [$C8C8], a
    ldh a, [$FF91]
    ld [$C8C9], a
    xor a, a
    ld [$C8CA], a
    xor a, a
    ld [$0100], a
    ld a, [$C525]
    or a, a
    jr z, Jump_003_4367
    ld hl, $C49F
    ld bc, $0040
    ld a, $FF
    call Func_000_0949
    ld a, $7F
    ld [$C526], a
    call Func_000_0829

Jump_003_4367::
    ld hl, $C198
    ld bc, $0240
    ld a, $C3
    call Func_000_0949
    call Func_003_42DA
    ld hl, $C5E0
    inc [hl]
    ld hl, Func_002_4628
    ld b, $02
    rst $10
    xor a, a
    ld [$C5E0], a
    ld a, $01
    ld [$C5DB], a
    ret

Func_003_4389::
    ldh a, [$FF8C]
    and a, $FD
    ldh [$FF8C], a
    ld hl, $CB8C
    ld a, [hl]
    and a, $FD
    ld [hl], a
    ld a, $10
    add a, l
    ld l, a
    jr nc, Jump_003_439D
    inc h

Jump_003_439D::
    ld a, [hl]
    and a, $FD
    ld [hl], a
    ld a, $10
    add a, l
    ld l, a
    jr nc, Jump_003_43A8
    inc h

Jump_003_43A8::
    ld a, [hl]
    and a, $FD
    ld [hl], a
    ld a, $10
    add a, l
    ld l, a
    jr nc, Jump_003_43B3
    inc h

Jump_003_43B3::
    ld a, [hl]
    and a, $FD
    ld [hl], a
    ld a, $10
    add a, l
    ld l, a
    jr nc, Jump_003_43BE
    inc h

Jump_003_43BE::
    ld a, [hl]
    and a, $FD
    ld [hl], a
    ret

Func_003_43C3::
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_003_43C9
    inc h

Jump_003_43C9::
    ld a, [hl+]
    ld h, [hl]
    ld l, a

Func_003_43CC::
    ld a, $08
    ld [$C528], a
    ld a, $05
    ld [$C529], a

Func_003_43D6::
    ld de, $0501

Func_003_43D9::
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
    ld hl, Func_008_402B
    ld b, $08
    rst $10
    pop bc
    ld a, c
    ld [$C52F], a
    ld a, b
    ld [$C530], a
    pop bc
    ld a, c
    ld [$C52D], a
    ld a, b
    ld [$C52E], a
    ret

Func_003_4414::
    ld de, $C130
    push bc
    ld b, $0A

Jump_003_441A::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_003_441A
    ld a, $F0
    ld [de], a
    pop bc
    ret

Func_003_4425::
    ld a, [$C563]
    and a, $40
    jr z, Jump_003_443A
    ld a, [hl]
    and a, $0F
    dec a
    cp a, $FF
    jr nz, Jump_003_447E
    ld a, [$C0A2]
    dec a
    jr Jump_003_447E

Jump_003_443A::
    ld a, [$C563]
    and a, $80
    jr z, Jump_003_444F
    ld a, [$C0A2]
    ld c, a
    ld a, [hl]
    and a, $0F
    inc a
    cp a, c
    jr nz, Jump_003_447E
    xor a, a
    jr Jump_003_447E

Jump_003_444F::
    ld a, [$C0A3]
    or a, a
    jr z, Jump_003_44CB
    cp a, $01
    jr z, Jump_003_44CB
    ld b, a
    ld a, [$C563]
    and a, $20
    jr z, Jump_003_446D
    ld a, [$C0A6]
    dec a
    cp a, $FF
    jr nz, Jump_003_449C
    ld a, b
    dec a
    jr Jump_003_449C

Jump_003_446D::
    ld a, [$C563]
    and a, $10
    jr z, Jump_003_44CB
    ld a, [$C0A6]
    inc a
    cp a, b
    jr nz, Jump_003_449C
    xor a, a
    jr Jump_003_449C

Jump_003_447E::
    and a, $0F
    ld b, a
    ld a, [hl]
    and a, $0F
    cp a, b
    jr z, Jump_003_4491
    push de
    call Func_003_44F0
    pop de
    ld a, $69
    call Func_000_1278

Jump_003_4491::
    ld [hl], b
    ld a, b
    call Func_003_4506
    xor a, a
    ld [$C5F0], a
    jr Jump_003_44EF

Jump_003_449C::
    ld [$C0A6], a
    inc a
    cp a, b
    jr nz, Jump_003_44BE
    ld a, [hl]
    and a, $0F
    ld c, a
    ld a, [$C0A5]
    dec a
    cp a, c
    jr nc, Jump_003_44BE
    jr z, Jump_003_44BE
    push af
    push de
    ld a, [hl]
    and a, $0F
    call Func_003_44F0
    pop de
    pop af
    ld [hl], a
    call Func_003_4506

Jump_003_44BE::
    set 7, [hl]
    xor a, a
    ld [$C5F0], a
    ld a, $69
    call Func_000_1278
    jr Jump_003_44EF

Jump_003_44CB::
    ld a, [$C5F0]
    and a, $0F
    jr nz, Jump_003_44EF
    ld a, [$C5F0]
    bit 4, a
    jr z, Jump_003_44E1
    ld a, [hl]
    and a, $0F
    call Func_003_4506
    jr Jump_003_44EF

Jump_003_44E1::
    ld a, [hl]
    and a, $0F
    call Func_003_44F0
    ld a, [$C5F0]
    set 3, a
    ld [$C5F0], a

Jump_003_44EF::
    ret

Func_003_44F0::
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_003_44F6
    inc d

Jump_003_44F6::
    ld a, [de]
    push af
    inc de
    ld a, [de]
    ld d, a
    pop af
    ld e, a
    di
    call Func_000_120A
    ld a, $C3
    ld [de], a
    ei
    ret

Func_003_4506::
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_003_450C
    inc d

Jump_003_450C::
    ld a, [de]
    push af
    inc de
    ld a, [de]
    ld d, a
    pop af
    ld e, a
    di
    call Func_000_120A
    ld a, $BB
    ld [de], a
    ei
    ret

Func_003_451C::
    ld a, [$C46D]
    and a, $03
    ld hl, Func_003_460B
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_003_452A
    inc h

Jump_003_452A::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, l
    add a, $98
    ld l, a
    ld a, h
    adc a, $29
    ld h, a
    ld [hl], $BB
    ret

Func_003_4538::
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_003_453E
    inc h

Jump_003_453E::
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
    ret

Func_003_454C::
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_003_4552
    inc h

Jump_003_4552::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, $BC
    call Func_000_1211
    ret
    db $FA, $2D, $C5, $4F, $FA, $2E, $C5, $47, $C5, $FA, $2F, $C5, $4F, $FA, $30, $C5
    db $47, $C5, $7D, $EA, $2D, $C5, $7C, $EA, $2E, $C5, $7B, $EA, $2F, $C5, $7A, $EA
    db $30, $C5, $21, $2B, $40, $06, $08, $D7, $E1, $7D, $EA, $2F, $C5, $7C, $EA, $30
    db $C5, $E1, $7D, $EA, $2D, $C5, $7C, $EA, $2E, $C5, $C9

Func_003_4596::
    ld a, [$CE9B]
    inc a
    cp a, $3C
    jr nc, Jump_003_45A3
    ld [$CE9B], a
    jr Jump_003_45C9

Jump_003_45A3::
    xor a, a
    ld [$CE9B], a
    ld a, [$CE9C]
    inc a
    cp a, $3C
    jr nc, Jump_003_45B4
    ld [$CE9C], a
    jr Jump_003_45C9

Jump_003_45B4::
    xor a, a
    ld [$CE9C], a
    ld a, [$CE9D]
    inc a
    cp a, $3C
    jr nc, Jump_003_45C5
    ld [$CE9D], a
    jr Jump_003_45C9

Jump_003_45C5::
    xor a, a
    ld [$CE9D], a

Jump_003_45C9::
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
    jr nz, Jump_003_45E5
    ld a, [$C82F]
    cp a, $3B
    ret z

Jump_003_45E5::
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

Func_003_460B:: ; heuristic: follows a terminator; C0
    ld h, c
    sbc a, b
    and a, c
    sbc a, b
    pop hl
    sbc a, b
    ld hl, $6199
    sbc a, c
    and a, c
    sbc a, c
    add hl, hl
    sbc a, b
    ld l, c
    sbc a, b
    xor a, c
    sbc a, b
    jp hl
    db $98

Data_003_461F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A1, $98, $E1, $98

Data_003_4623:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $21, $99, $61, $99

Data_003_4627:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $99, $41, $99

Data_003_462B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $47, $99, $87, $99, $C7, $99, $07, $9A

Data_003_4633:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $61, $98, $A1, $98

Data_003_4637:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $4A, $99, $8A, $99, $CA, $99, $0A, $9A

Data_003_463F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $64, $98, $A4, $98, $E4, $98

Data_003_4645:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2F, $99, $6F, $99

Data_003_4649:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $82, $99, $84, $99, $86, $99, $88, $99, $8A, $99, $8C, $99, $8E, $99, $90, $99

Func_003_4659::
    ld a, [$C0A4]
    rst $00
    dw Jump_003_4665
    dw Jump_003_4677
    dw Jump_003_467C
    dw Jump_003_468D

Jump_003_4665::
    ld a, [$C608]
    ld [$C0A5], a
    xor a, a
    ld [$C8C3], a
    ld [$C8C4], a
    ld hl, $C0A4
    inc [hl]
    ret

Jump_003_4677::
    ld hl, $C0A4
    inc [hl]
    ret

Jump_003_467C::
    ld hl, Func_002_7347
    ld b, $02
    rst $10
    ld a, [$C8C3]
    bit 7, a
    ret z
    ld hl, $C0A4
    inc [hl]
    ret

Jump_003_468D::
    ld hl, $C0A4
    inc [hl]
    ret

Jump_003_4692::
    ld a, [$D067]
    or a, a
    jp nz, Jump_003_4FED
    ld a, [$C0A0]
    rst $00
    dw Jump_003_46A7
    dw Jump_003_4735
    dw Jump_003_47C2
    dw Jump_003_4846
    dw Jump_003_48EB

Jump_003_46A7::
    ld a, [$C0A1]
    rst $00
    dw Jump_003_46B3
    dw Jump_003_46C4
    dw Jump_003_46F1
    dw Jump_003_46C3

Jump_003_46B3::
    ld a, [$C0A4]
    or a, a
    jr nz, Jump_003_46BF
    call Func_003_499B
    call Func_003_42DA

Jump_003_46BF::
    ld hl, $C0A1
    inc [hl]

Jump_003_46C3::
    ret

Jump_003_46C4::
    ld a, [$C0A4]
    or a, a
    jr nz, Jump_003_46CD
    call Func_003_48EF

Jump_003_46CD::
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    call Func_003_4A36
    xor a, a
    ld [$0100], a
    call Func_003_4A84
    ld hl, $9800
    ld bc, $1412
    ld de, $C198
    call Func_003_42E3
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_46F1::
    ld de, Func_003_460B
    ld hl, $C46D
    call Func_003_4425
    ld a, [$C563]
    and a, $C0
    jr z, Jump_003_4706
    xor a, a
    ld [$C0A1], a
    ret

Jump_003_4706::
    ld a, [$C562]
    bit 0, a
    jr z, Jump_003_471E
    ld a, $69
    call Func_000_1278
    ld hl, $C0A0
    inc [hl]
    xor a, a
    ld [$C0A1], a
    ld [$C0A4], a
    ret

Jump_003_471E::
    bit 1, a
    jr z, Jump_003_4726
    call Func_003_4339
    ret

Jump_003_4726::
    bit 2, a
    jr z, Jump_003_4734
    ld a, $01
    ld [$D067], a
    xor a, a
    ld [$C0A1], a
    ret

Jump_003_4734::
    ret

Jump_003_4735::
    ld a, [$C0A1]
    rst $00
    dw Jump_003_473F
    dw Jump_003_4750
    dw Jump_003_4770

Jump_003_473F::
    ld a, [$C0A4]
    or a, a
    jr nz, Jump_003_474B
    call Func_003_49C2
    call Func_003_42DA

Jump_003_474B::
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_4750::
    ld a, [$C0A4]
    or a, a
    jr nz, Jump_003_4759
    call Func_003_4917

Jump_003_4759::
    call Func_003_4A98
    ld hl, $9821
    ld bc, $1311
    ld de, $C1B9
    call Func_003_42E3
    call Func_003_4F6F
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_4770::
    ld hl, Func_01D_6A3D
    ld b, $1D
    rst $10
    ld de, Func_003_460B
    ld hl, $C46D
    call Func_003_4425
    ld a, [$C563]
    and a, $C0
    jr z, Jump_003_478B
    xor a, a
    ld [$C0A1], a
    ret

Jump_003_478B::
    ld a, [$C562]
    bit 0, a
    jr z, Jump_003_47A3
    ld a, $69
    call Func_000_1278
    ld hl, $C0A0
    inc [hl]
    xor a, a
    ld [$C0A1], a
    ld [$C0A4], a
    ret

Jump_003_47A3::
    bit 1, a
    jr z, Jump_003_47B3
    ld hl, $C0A0
    dec [hl]
    xor a, a
    ld [$C0A1], a
    ld [$C0A4], a
    ret

Jump_003_47B3::
    bit 2, a
    jr z, Jump_003_47C1
    ld a, $01
    ld [$D067], a
    xor a, a
    ld [$C0A1], a
    ret

Jump_003_47C1::
    ret

Jump_003_47C2::
    ld a, [$C0A1]
    rst $00
    dw Jump_003_47CC
    dw Jump_003_47DD
    dw Jump_003_47FA

Jump_003_47CC::
    ld a, [$C0A4]
    or a, a
    jr nz, Jump_003_47D8
    call Func_003_49E9
    call Func_003_42DA

Jump_003_47D8::
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_47DD::
    ld a, [$C0A4]
    or a, a
    jr nz, Jump_003_47E6
    call Func_003_493F

Jump_003_47E6::
    call Func_003_4AAC
    ld hl, $9821
    ld bc, $1311
    ld de, $C1B9
    call Func_003_42E3
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_47FA::
    ld de, Func_003_460B
    ld hl, $C46D
    call Func_003_4425
    ld a, [$C563]
    and a, $C0
    jr z, Jump_003_480F
    xor a, a
    ld [$C0A1], a
    ret

Jump_003_480F::
    ld a, [$C562]
    bit 0, a
    jr z, Jump_003_4827
    ld a, $69
    call Func_000_1278
    ld hl, $C0A0
    inc [hl]
    xor a, a
    ld [$C0A1], a
    ld [$C0A4], a
    ret

Jump_003_4827::
    bit 1, a
    jr z, Jump_003_4837
    ld hl, $C0A0
    dec [hl]
    xor a, a
    ld [$C0A1], a
    ld [$C0A4], a
    ret

Jump_003_4837::
    bit 2, a
    jr z, Jump_003_4845
    ld a, $01
    ld [$D067], a
    xor a, a
    ld [$C0A1], a
    ret

Jump_003_4845::
    ret

Jump_003_4846::
    ld a, [$C0A1]
    rst $00
    dw Jump_003_4850
    dw Jump_003_4861
    dw Jump_003_4881

Jump_003_4850::
    ld a, [$C0A4]
    or a, a
    jr nz, Jump_003_485C
    call Func_003_4A08
    call Func_003_42DA

Jump_003_485C::
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_4861::
    ld a, [$C0A4]
    or a, a
    jr nz, Jump_003_486A
    call Func_003_495F

Jump_003_486A::
    call Func_003_4ABD
    ld hl, $9821
    ld bc, $1311
    ld de, $C1B9
    call Func_003_42E3
    call Func_003_4FBB
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_4881::
    ld de, Func_003_460B
    ld hl, $C46D
    call Func_003_4425
    ld a, [$C563]
    and a, $C0
    jr z, Jump_003_4896
    xor a, a
    ld [$C0A1], a
    ret

Jump_003_4896::
    ld a, [$C562]
    bit 0, a
    jr z, Jump_003_48B3
    ld a, $69
    call Func_000_1278
    xor a, a
    ldh [$FFB1], a
    ld hl, $C000
    ld bc, $00A0
    call Func_000_0949
    ld hl, $C0A0
    inc [hl]
    ret

Jump_003_48B3::
    ld a, [$D09D]
    ld l, a
    ld a, [$D09E]
    ld h, a
    ld a, l
    ld [$D7F1], a
    ld a, h
    ld [$D7F2], a
    ld hl, Func_01D_6899
    ld b, $1D
    rst $10
    ld a, [$C562]
    bit 1, a
    jr z, Jump_003_48DC
    ld hl, $C0A0
    dec [hl]
    xor a, a
    ld [$C0A1], a
    ld [$C0A4], a
    ret

Jump_003_48DC::
    bit 2, a
    jr z, Jump_003_48EA
    ld a, $01
    ld [$D067], a
    xor a, a
    ld [$C0A1], a
    ret

Jump_003_48EA::
    ret

Jump_003_48EB::
    call Func_003_4339
    ret

Func_003_48EF::
    call Func_003_4284
    ld e, $00
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ld e, $01
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ld e, $02
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ld e, $03
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ld hl, $C0A4
    inc [hl]
    ret

Func_003_4917::
    call Func_003_4284
    ld e, $00
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ld e, $04
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ld e, $05
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ld e, $06
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ld hl, $C0A4
    inc [hl]
    ret

Func_003_493F::
    call Func_003_4284
    ld e, $00
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ld e, $07
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ld e, $08
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ld hl, $C0A4
    inc [hl]
    ret

Func_003_495F::
    call Func_003_4284
    ld e, $00
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ld e, $09
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ld e, $0A
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ld hl, $C0A4
    inc [hl]
    ret

Func_003_497F::
    call Func_003_4284
    ld a, [$C6FD]
    add a, $2D
    ld e, a
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ld e, $31
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ld hl, $C0A4
    inc [hl]
    ret

Func_003_499B::
    call Func_003_4284
    ld e, $00
    ld hl, Func_033_402B
    ld b, $33
    rst $10
    ld e, $01
    ld hl, Func_033_402B
    ld b, $33
    rst $10
    ld e, $02
    ld hl, Func_033_402B
    ld b, $33
    rst $10
    ld e, $03
    ld hl, Func_033_402B
    ld b, $33
    rst $10
    call Func_003_451C
    ret

Func_003_49C2::
    call Func_003_4284
    ld e, $00
    ld hl, Func_033_402B
    ld b, $33
    rst $10
    ld e, $04
    ld hl, Func_033_402B
    ld b, $33
    rst $10
    ld e, $05
    ld hl, Func_033_402B
    ld b, $33
    rst $10
    ld e, $06
    ld hl, Func_033_402B
    ld b, $33
    rst $10
    call Func_003_451C
    ret

Func_003_49E9::
    call Func_003_4284
    ld e, $00
    ld hl, Func_033_402B
    ld b, $33
    rst $10
    ld e, $07
    ld hl, Func_033_402B
    ld b, $33
    rst $10
    ld e, $08
    ld hl, Func_033_402B
    ld b, $33
    rst $10
    call Func_003_451C
    ret

Func_003_4A08::
    call Func_003_4284
    ld e, $00
    ld hl, Func_033_402B
    ld b, $33
    rst $10
    ld e, $09
    ld hl, Func_033_402B
    ld b, $33
    rst $10
    ld e, $0A
    ld hl, Func_033_402B
    ld b, $33
    rst $10
    call Func_003_451C
    ret

Func_003_4A27::
    ld b, $16
    ld de, $7B7D
    ld hl, $8EE0
    call Func_000_0CF5
    call Func_003_4A36
    ret

Func_003_4A36::
    ld c, $0B
    ld a, [$C46D]
    and a, $0F
    call Func_000_1F49
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    ld hl, $95C0
    ld c, $01
    call Func_000_1FE3
    pop de
    ld a, [$C525]
    or a, a
    jr z, Jump_003_4A83
    push de
    ld a, $7F
    ld [$C526], a
    call Func_000_0829
    pop de
    ld a, $01
    ldh [$FFC6], a
    ld hl, $D000
    call Func_000_2038
    ld a, $01
    ldh [$FF4F], a
    ld a, $02
    ldh [$FF70], a
    ld hl, $9961
    ld de, $D000
    ld bc, $0606
    call Func_003_4313
    ld a, $00
    ldh [$FF70], a
    ld a, $00
    ldh [$FF4F], a

Jump_003_4A83::
    ret

Func_003_4A84::
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    call Func_003_4ACE
    call Func_003_4B52
    xor a, a
    ld [$0100], a
    ret

Func_003_4A98::
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    call Func_003_4ACE
    call Func_003_4BE8
    xor a, a
    ld [$0100], a
    ret

Func_003_4AAC::
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    call Func_003_4D57
    xor a, a
    ld [$0100], a
    ret

Func_003_4ABD::
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    call Func_003_4E02
    xor a, a
    ld [$0100], a
    ret

Func_003_4ACE::
    ld hl, $C1C1
    ld a, $C3
    ld [hl+], a
    ld a, $EA
    ld [hl+], a
    ld a, $ED
    ld [hl+], a
    ld a, $C3
    ld [hl+], a
    ld a, $C3
    ld [hl+], a
    ld a, $C3
    ld [hl+], a
    ld a, $C3
    ld [hl+], a
    ld [hl], $C3
    ld c, $56
    ld a, [$C46D]
    and a, $0F
    call Func_000_1F49
    push hl
    ld a, [hl]
    ld l, a
    ld h, $00
    call Func_000_16F5
    ld de, $C1C4
    call Func_000_210D
    pop hl
    ld a, [hl+]
    cp a, [hl]
    jr c, Jump_003_4B0A
    ld a, $14
    ld [$C1C1], a

Jump_003_4B0A::
    ld c, $55
    ld a, [$C46D]
    and a, $0F
    call Func_000_1F49
    ld a, [hl]
    or a, a
    jr z, Jump_003_4B27
    bit 7, a
    call nz, Func_003_4B3A
    bit 0, a
    call nz, Func_003_4B42
    bit 2, a
    call nz, Func_003_4B4A

Jump_003_4B27::
    ld c, $0E
    ld a, [$C46D]
    and a, $0F
    call Func_000_1F49
    ld a, [hl]
    and a, $01
    add a, $CC
    ld [$C1CA], a
    ret

Func_003_4B3A::
    push af
    ld a, $C2
    ld [$C1C8], a
    pop af
    ret

Func_003_4B42::
    push af
    ld a, $C0
    ld [$C1C6], a
    pop af
    ret

Func_003_4B4A::
    push af
    ld a, $C1
    ld [$C1C7], a
    pop af
    ret

Func_003_4B52::
    ld c, $63
    ld a, [$C46D]
    and a, $0F
    call Func_000_1F49
    ld a, [hl+]
    push hl
    ld h, [hl]
    ld l, a
    call Func_000_16F5
    ld de, $C208
    call Func_000_2123
    pop hl
    inc hl
    ld a, [hl+]
    push hl
    ld h, [hl]
    ld l, a
    call Func_000_16F5
    ld de, $C248
    call Func_000_2123
    pop hl
    inc hl
    ld a, [hl+]
    push hl
    ld h, [hl]
    ld l, a
    call Func_000_16F5
    ld de, $C288
    call Func_000_2123
    pop hl
    inc hl
    ld a, [hl+]
    push hl
    ld h, [hl]
    ld l, a
    call Func_000_16F5
    ld de, $C2C8
    call Func_000_2123
    pop hl
    inc hl
    push hl
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    call Func_000_16F5
    ld de, $C308
    call Func_000_2123
    pop hl
    ld a, l
    add a, $F0
    ld l, a
    ld a, h
    adc a, $FF
    ld h, a
    ld a, [hl+]
    push hl
    ld h, [hl]
    ld l, a
    call Func_000_16F5
    ld de, $C364
    call Func_000_2123
    pop hl
    inc hl
    ld a, [hl+]
    push hl
    ld h, [hl]
    ld l, a
    call Func_000_16F5
    ld de, $C368
    call Func_000_2123
    pop hl
    inc hl
    ld a, [hl+]
    push hl
    ld h, [hl]
    ld l, a
    call Func_000_16F5
    ld de, $C3A4
    call Func_000_2123
    pop hl
    inc hl
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    call Func_000_16F5
    ld de, $C3A8
    call Func_000_2123
    ret

Func_003_4BE8::
    ld c, $A4
    ld a, [$C46D]
    and a, $0F
    call Func_000_1F49
    ld a, [hl]
    ld [$C529], a
    ld a, $0B
    ld [$C528], a
    ld hl, $9350
    ld de, $0603
    call Func_003_43D9
    ld c, $6F
    ld a, [$C46D]
    and a, $0F
    call Func_000_1F49
    ld a, [hl+]
    cp a, $40
    jr c, Jump_003_4C1B
    cp a, $C0
    jr c, Jump_003_4C1F
    ld c, $00
    jr Jump_003_4C21

Jump_003_4C1B::
    ld c, $12
    jr Jump_003_4C21

Jump_003_4C1F::
    ld c, $09

Jump_003_4C21::
    ld a, [hl+]
    inc hl
    cp a, $40
    jr c, Jump_003_4C2F
    cp a, $C0
    jr c, Jump_003_4C33
    ld b, $00
    jr Jump_003_4C35

Jump_003_4C2F::
    ld b, $02
    jr Jump_003_4C35

Jump_003_4C33::
    ld b, $01

Jump_003_4C35::
    ld a, [hl]
    cp a, $40
    jr c, Jump_003_4C41
    cp a, $C0
    jr c, Jump_003_4C45
    xor a, a
    jr Jump_003_4C47

Jump_003_4C41::
    ld a, $06
    jr Jump_003_4C47

Jump_003_4C45::
    ld a, $03

Jump_003_4C47::
    add a, b
    add a, c
    ld [$C529], a
    ld a, $07
    ld [$C528], a
    ld hl, $94C0
    ld de, $0901
    call Func_003_43D9
    ld c, $0B
    ld a, [$C46D]
    and a, $0F
    call Func_000_1F49
    ld a, [hl+]
    ld h, [hl]
    ld [$C529], a
    ld a, h
    add a, $02
    ld [$C528], a
    ld hl, $9550
    ld de, $0901
    call Func_003_43D9
    ld a, [$C46D]
    and a, $0F
    add a, $C7
    ld [$C281], a
    ld a, $C3
    ld [$C282], a
    ld [$C283], a
    ld [$C284], a
    ld c, $6D
    ld a, [$C46D]
    and a, $0F
    call Func_000_1F49
    ld a, [hl]
    or a, a
    jr z, Jump_003_4CB8
    ld l, a
    ld h, $00
    call Func_000_16F5
    ld hl, $C283
    ld a, [$C8C1]
    or a, a
    jr z, Jump_003_4CAD
    add a, $E0
    ld [hl+], a

Jump_003_4CAD::
    ld a, [$C8C2]
    add a, $E0
    ld [hl], a
    ld a, $FC
    ld [$C282], a

Jump_003_4CB8::
    ld c, $0F
    ld a, [$C46D]
    and a, $0F
    call Func_000_1F49
    call Func_003_4414
    ld hl, $9470
    call Func_003_43CC
    ld c, $58
    ld a, [$C46D]
    and a, $0F
    call Func_000_1F49
    ld a, [hl+]
    ld [$C8C0], a
    ld e, a
    ld a, [hl+]
    ld [$C8C1], a
    ld d, a
    ld a, [hl]
    ld [$C8C2], a
    ld c, a
    push bc
    push de
    call Func_000_173A
    ld de, $C324
    call Func_000_214F
    ld c, $0B
    ld a, [$C46D]
    and a, $0F
    call Func_000_1F49
    ld a, [hl+]
    ld [$D006], a
    ld a, [hl]
    ld [$D007], a
    ld hl, Func_035_4001
    ld b, $35
    rst $10
    ld a, [$D00F]
    ldh [$FFC6], a
    ld c, $56
    ld a, [$C46D]
    and a, $0F
    call Func_000_1F49
    ld a, [hl]
    ldh [$FFC7], a
    ld hl, Func_019_7380
    ld b, $19
    rst $10
    ld c, $56
    ld a, [$C46D]
    and a, $0F
    call Func_000_1F49
    pop de
    pop bc
    ld a, [hl+]
    cp a, [hl]
    jr nc, Jump_003_4D43
    ldh a, [$FFC8]
    sub a, e
    ld [$C8C0], a
    ldh a, [$FFC9]
    sbc a, d
    ld [$C8C1], a
    ldh a, [$FFCA]
    sbc a, c
    ld [$C8C2], a
    jr Jump_003_4D4D

Jump_003_4D43::
    xor a, a
    ld [$C8C0], a
    ld [$C8C1], a
    ld [$C8C2], a

Jump_003_4D4D::
    call Func_000_173A
    ld de, $C3A4
    call Func_000_214F
    ret

Func_003_4D57::
    ld c, $0B
    ld a, [$C46D]
    and a, $0F
    call Func_000_1F49
    ld a, [hl+]
    ld [$D006], a
    ld a, [hl]
    ld [$D007], a
    ld hl, Func_035_4001
    ld b, $35
    rst $10
    ld a, [$D013]
    ld [$C529], a
    ld a, $0D
    ld [$C528], a
    ld hl, $92C0
    ld de, $0602
    call Func_003_43D9
    ld c, $34
    ld a, [$C46D]
    and a, $0F
    call Func_000_1F49
    ld a, [hl+]
    ld b, $00
    call Func_003_4DBE
    ld a, [hl+]
    ld b, $01
    call Func_003_4DCF
    ld a, [hl+]
    ld b, $02
    call Func_003_4DCF
    ld a, [hl+]
    ld b, $03
    call Func_003_4DCF
    ld a, [hl+]
    ld b, $04
    call Func_003_4DCF
    ld a, [hl+]
    ld b, $05
    call Func_003_4DCF
    ld a, [hl+]
    ld b, $06
    call Func_003_4DCF
    ld a, [hl]
    ld b, $07
    call Func_003_4DCF
    ret

Func_003_4DBE::
    cp a, $FF
    jr nz, Func_003_4DCF
    push hl
    ld a, $08
    ld [$C528], a
    ld a, $0E
    ld [$C529], a
    jr Jump_003_4DDD

Func_003_4DCF::
    push hl
    cp a, $FF
    jr nz, Jump_003_4DD5
    xor a, a

Jump_003_4DD5::
    ld [$C529], a
    ld a, $04
    ld [$C528], a

Jump_003_4DDD::
    ld a, b
    ld hl, Data_003_4DF2
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_003_4DE7
    inc h

Jump_003_4DE7::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, $0901
    call Func_003_43D9
    pop hl
    ret

Data_003_4DF2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $80, $93, $10, $94, $A0, $94, $30, $95, $C0, $95, $50, $96, $E0, $96, $70, $97

Func_003_4E02::
    ld c, $0D
    ld a, [$C46D]
    and a, $0F
    call Func_000_1F49
    ld a, [hl]
    swap a
    and a, $0F
    ld [$C0A5], a
    ld a, l
    add a, $0D
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl+]
    and a, [hl]
    dec hl
    cp a, $FF
    jr z, Jump_003_4E69
    ld a, [$C0A5]
    ld b, a
    call Func_003_4EB6
    ld a, [$C0A5]
    xor a, $01
    ld b, a
    call Func_003_4EB6
    ld a, [$C0A5]
    ld b, a
    call Func_003_4EFD
    ld a, [$C0A5]
    xor a, $01
    ld b, a
    call Func_003_4EFD
    ld a, l
    add a, $5A
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [$C0A5]
    ld b, a
    call Func_003_4F0D
    ld a, [$C0A5]
    xor a, $01
    ld b, a
    call Func_003_4F0D
    ld a, [$C0A5]
    add a, $CC
    ld [$C206], a
    xor a, $01
    ld [$C326], a
    ret

Jump_003_4E69::
    ld hl, $9580
    ld bc, $0140

Jump_003_4E6F::
    ld a, $FF
    call Func_000_121F
    xor a, a
    call Func_000_121F
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_003_4E6F
    ld a, $C3
    ld hl, $C202
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    inc hl
    ld [hl], a
    ld hl, $C322
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    inc hl
    ld [hl], a
    ld hl, $C130
    ld a, $98
    ld [hl+], a
    ld a, $98
    ld [hl+], a
    ld a, $98
    ld [hl+], a
    ld [hl], $F0
    ld hl, $9580
    call Func_003_43CC
    ld hl, $9670
    call Func_003_43D6
    ld hl, $96C0
    call Func_003_43D6
    ld hl, $97B0
    call Func_003_43D6
    ret

Func_003_4EB6::
    ld a, [hl+]
    ld [$D006], a
    ld [$C529], a
    ld a, [hl+]
    ld [$D007], a
    add a, $02
    ld [$C528], a
    push hl
    push bc
    ld hl, Data_003_4F5D
    ld a, b
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_003_4ED2
    inc h

Jump_003_4ED2::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, $0901
    call Func_003_43D9
    ld hl, Func_035_4001
    ld b, $35
    rst $10
    ld a, [$D008]
    ld [$D09D], a
    pop bc
    ld a, b
    ld hl, Data_003_4F61
    add a, l
    ld l, a
    jr nc, Jump_003_4EF1
    inc h

Jump_003_4EF1::
    ld a, [hl]
    ld [$D09E], a
    ld hl, Func_016_7A48
    ld b, $16
    rst $10
    pop hl
    ret

Func_003_4EFD::
    call Func_003_4414
    inc hl
    push hl
    push bc
    ld a, b
    ld hl, Data_003_4F63
    call Func_003_43C3
    pop bc
    pop hl
    ret

Func_003_4F0D::
    call Func_003_4414
    push hl
    push bc
    ld a, b
    ld hl, Data_003_4F67
    call Func_003_43C3
    pop bc
    pop hl
    push hl
    ld a, b
    ld hl, Data_003_4F6B
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_003_4F26
    inc h

Jump_003_4F26::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, $C3
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    pop hl
    ld a, [hl+]
    push hl
    or a, a
    jr z, Jump_003_4F5B
    ld l, a
    ld h, $00
    push bc
    call Func_000_16F5
    pop bc
    ld a, b
    ld hl, Data_003_4F6B
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_003_4F46
    inc h

Jump_003_4F46::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, $FC
    ld [hl+], a
    ld a, [$C8C1]
    or a, a
    jr z, Jump_003_4F55
    add a, $E0
    ld [hl+], a

Jump_003_4F55::
    ld a, [$C8C2]
    add a, $E0
    ld [hl], a

Jump_003_4F5B::
    pop hl
    ret

Data_003_4F5D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $E0, $95, $20, $97

Data_003_4F61:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $5D, $71

Data_003_4F63:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $70, $96, $B0, $97

Data_003_4F67:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $80, $95, $C0, $96

Data_003_4F6B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $02, $C2, $22, $C3

Func_003_4F6F::
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld c, $0B
    ld a, [$C46D]
    and a, $0F
    call Func_000_1F49
    ld a, [hl+]
    ld [$D7F1], a
    ld a, [hl]
    ld [$D7F2], a
    xor a, a
    ld [$D7F3], a
    ld hl, $8000
    ld a, l
    ld [$D7F4], a
    ld a, h
    ld [$D7F5], a
    ld hl, Func_01D_6973
    ld b, $1D
    rst $10
    xor a, a
    ld [$0100], a
    ld a, $00
    ld [$D7F3], a
    ld a, $90
    ld [$D7F4], a
    ld a, $40
    ld [$D7F5], a
    ld a, $00
    ld [$D7F6], a
    xor a, a
    ldh [$FFB9], a
    ret

Func_003_4FBB::
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld a, [$C46D]
    ld hl, $C6FE
    add a, l
    ld l, a
    jr nc, Jump_003_4FCF
    inc h

Jump_003_4FCF::
    ld a, l
    ld [$D7F1], a
    ld a, h
    ld [$D7F2], a
    ld a, l
    ld [$D09D], a
    ld a, h
    ld [$D09E], a
    ld hl, Func_01D_682A
    ld b, $1D
    rst $10
    xor a, a
    ld [$0100], a
    xor a, a
    ldh [$FFB9], a
    ret

Jump_003_4FED::
    ld a, [$C0A1]
    rst $00
    dw Jump_003_4FFB
    dw Jump_003_5042
    dw Jump_003_51B0
    dw Jump_003_5200
    dw Jump_003_520B

Jump_003_4FFB::
    ld hl, $9800
    ld bc, $1412

Jump_003_5001::
    ld a, $C3
    call Func_000_121F
    dec b
    jr nz, Jump_003_5001
    ld b, $14
    ld a, l
    add a, $0C
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec c
    jr nz, Jump_003_5001
    ld a, [$C525]
    or a, a
    jr z, Jump_003_503D
    ld a, $01
    ldh [$FF4F], a
    ld hl, $9800
    ld bc, $1412

Jump_003_5026::
    xor a, a
    call Func_000_121F
    dec b
    jr nz, Jump_003_5026
    ld b, $14
    ld a, l
    add a, $0C
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec c
    jr nz, Jump_003_5026
    xor a, a
    ldh [$FF4F], a

Jump_003_503D::
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_5042::
    call Func_003_497F
    call Func_000_290E
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld a, [$C6FD]
    ld b, a
    ld c, $00

Jump_003_5057::
    push bc
    push bc
    ld a, c
    ld c, $0B
    call Func_000_1F49
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop bc
    ld hl, Data_003_518F
    ld a, c
    add a, l
    ld l, a
    jr nc, Jump_003_506C
    inc h

Jump_003_506C::
    ld a, c
    ld c, [hl]
    ld hl, Data_003_5192
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_003_5077
    inc h

Jump_003_5077::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    push de
    call Func_000_1FE3
    pop de
    pop bc
    ld a, [$C525]
    or a, a
    jr z, Jump_003_50AC
    push bc
    ld a, c
    ld hl, Data_003_518F
    add a, l
    ld l, a
    jr nc, Jump_003_5090
    inc h

Jump_003_5090::
    ld a, [hl]
    ldh [$FFC6], a
    ld a, c
    ld hl, Data_003_5198
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_003_509D
    inc h

Jump_003_509D::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $D0
    ld h, a
    call Func_000_2038
    pop bc

Jump_003_50AC::
    call Func_003_50DD
    call Func_003_5137
    call Func_003_5171
    inc c
    dec b
    jr nz, Jump_003_5057
    ld hl, $8800
    ld de, $1202
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld a, e
    ld [$C52F], a
    ld a, d
    ld [$C530], a
    xor a, a
    ld [$0100], a
    ld hl, $C0A1
    inc [hl]
    ld a, $7F
    ld [$C526], a
    ret

Func_003_50DD::
    push bc
    ld a, c
    ld hl, Data_003_519E
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_003_50E8
    inc h

Jump_003_50E8::
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld a, c
    ld c, $5B
    call Func_000_1F49
    ld a, [hl+]
    push hl
    ld h, [hl]
    ld l, a
    push de
    call Func_000_16F5
    pop de
    push de
    call Func_000_2123
    pop de
    ld a, e
    add a, $20
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop hl
    inc hl
    inc hl
    inc hl
    push hl
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    push de
    call Func_000_16F5
    pop de
    push de
    call Func_000_2123
    pop de
    ld a, e
    add a, $21
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop hl
    ld a, l
    add a, $F7
    ld l, a
    ld a, h
    adc a, $FF
    ld h, a
    ld l, [hl]
    ld h, $00
    push de
    call Func_000_16F5
    pop de
    call Func_000_210D
    pop bc
    ret

Func_003_5137::
    push bc
    ld a, c
    ld hl, Data_003_51A4
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_003_5142
    inc h

Jump_003_5142::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, $0901
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld a, e
    ld [$C52F], a
    ld a, d
    ld [$C530], a
    ld a, c
    ld c, $0B
    call Func_000_1F49
    ld a, [hl+]
    ld h, [hl]
    ld [$C529], a
    ld a, h
    add a, $02
    ld [$C528], a
    ld hl, Func_008_402B
    ld b, $08
    rst $10
    pop bc
    ret

Func_003_5171::
    push bc
    ld a, c
    ld hl, Data_003_51AA
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_003_517C
    inc h

Jump_003_517C::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    push hl
    ld a, c
    ld c, $0E
    call Func_000_1F49
    ld a, [hl]
    pop hl
    and a, $01
    add a, $CC
    ld [hl], a
    pop bc
    ret

Data_003_518F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $03, $05

Data_003_5192:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $40, $91, $80, $93, $C0, $95

Data_003_5198:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $80, $00, $00, $01

Data_003_519E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FA, $C1, $00, $C2, $06, $C2

Data_003_51A4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $88, $90, $88, $20, $89

Data_003_51AA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $66, $C3, $86, $C3, $A6, $C3

Jump_003_51B0::
    call Func_003_42DA
    ld a, [$C525]
    or a, a
    jr z, Jump_003_51FB
    ld bc, $0606
    ld a, $01
    ldh [$FF4F], a
    ld a, $02
    ldh [$FF70], a
    ld hl, $98E1
    ld de, $D000
    call Func_003_4313
    ld a, [$C6FD]
    cp a, $01
    jr z, Jump_003_51F3
    ld hl, $98E7
    ld de, $D080
    ld bc, $0606
    call Func_003_4313
    ld a, [$C6FD]
    cp a, $02
    jr z, Jump_003_51F3
    ld hl, $98ED
    ld de, $D100
    ld bc, $0606
    call Func_003_4313

Jump_003_51F3::
    ld a, $00
    ldh [$FF70], a
    ld a, $00
    ldh [$FF4F], a

Jump_003_51FB::
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_5200::
    ld a, [$C562]
    and a, $04
    ret z
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_520B::
    ld hl, $9800
    ld bc, $1412
    ld d, $C3
    call Func_003_523E
    ld a, [$C525]
    or a, a
    jr z, Jump_003_522E
    ld a, $01
    ldh [$FF4F], a
    ld hl, $98E0
    ld bc, $1406
    ld d, $00
    call Func_003_523E
    xor a, a
    ldh [$FF4F], a

Jump_003_522E::
    call Func_003_5253
    xor a, a
    ld [$D067], a
    xor a, a
    ld [$C0A1], a
    xor a, a
    ld [$C0A4], a
    ret

Func_003_523E::
    ld a, d
    call Func_000_121F
    dec b
    jr nz, Func_003_523E
    ld a, l
    add a, $0C
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld b, $14
    dec c
    jr nz, Func_003_523E
    ret

Func_003_5253::
    ld de, Data_003_5264
    ld hl, $9140
    ld b, $10

Jump_003_525B::
    ld a, [de]
    call Func_000_121F
    inc de
    dec b
    jr nz, Jump_003_525B
    ret

Data_003_5264:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $00, $FF, $10, $FF, $10, $FF, $FE, $FF, $7C, $FF, $38, $FF, $7C, $FF, $C6

Jump_003_5274::
    ld a, [$C0A0]
    rst $00
    dw Jump_003_5280
    dw Jump_003_5340
    dw Jump_003_538D
    dw Jump_003_572D

Jump_003_5280::
    ld a, [$C0A1]
    rst $00
    dw Jump_003_5288
    dw Jump_003_52A3

Jump_003_5288::
    ld a, [$D095]
    or a, a
    call nz, Func_003_432F
    call Func_003_5A58
    call Func_003_581E
    call Func_003_59DB
    call Func_003_5900
    call Func_003_42DA
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_52A3::
    ld a, [$C61D]
    or a, a
    jr nz, Jump_003_52AE
    ld a, [$C562]
    jr Jump_003_5328

Jump_003_52AE::
    ld de, $4617
    ld hl, $C46E
    call Func_003_4425
    ld a, [$C563]
    and a, $C0
    jr z, Jump_003_52C8
    ld a, [$C0A2]
    cp a, $01
    ret z
    call Func_003_5900
    ret

Jump_003_52C8::
    ld hl, $C46E
    bit 7, [hl]
    jr z, Jump_003_52DE
    res 7, [hl]
    call Func_003_59DB
    call Func_003_5900
    call Func_003_592E
    call Func_003_59C7
    ret

Jump_003_52DE::
    ld a, [$C562]
    bit 0, a
    jr z, Jump_003_5328
    ld a, $69
    call Func_000_1278
    ld a, [$C0A6]
    add a, a
    add a, a
    ld c, a
    ld a, [$C46E]
    add a, c
    ld [$D082], a
    ld hl, $C61D
    add a, l
    ld l, a
    jr nc, Jump_003_52FF
    inc h

Jump_003_52FF::
    ld a, [hl]
    ld [$D081], a
    ld l, a
    ld h, $05
    ld de, $C150
    call Func_000_2E81
    ld de, $C60C
    ld hl, $C130
    call Func_000_2FE1
    ld hl, Func_016_4007
    ld b, $16
    rst $10
    ld hl, $C0A0
    inc [hl]
    xor a, a
    ld [$C0A1], a
    xor a, a
    ld [$C46F], a
    ret

Jump_003_5328::
    bit 1, a
    jr z, Jump_003_5330
    call Func_003_4339
    ret

Jump_003_5330::
    bit 2, a
    ret z
    ld hl, Func_016_590C
    ld b, $16
    rst $10
    call Func_003_5900
    call Func_003_592E
    ret

Jump_003_5340::
    ld a, [$C0A1]
    rst $00
    dw Jump_003_5348
    dw Jump_003_535D

Jump_003_5348::
    call Func_003_585D
    call Func_003_42DA
    ld a, $02
    ld [$C0A2], a
    ld a, $01
    ld [$C0A3], a
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_535D::
    ld de, Data_003_461F
    ld hl, $C46F
    call Func_003_4425
    ld a, [$C562]
    bit 0, a
    jr z, Jump_003_5381
    ld a, $69
    call Func_000_1278
    ld a, [$C46F]
    and a, $01
    add a, $02
    ld [$C0A0], a
    xor a, a
    ld [$C0A1], a
    ret

Jump_003_5381::
    bit 1, a
    ret z
    ld hl, $C0A0
    dec [hl]
    xor a, a
    ld [$C0A1], a
    ret

Jump_003_538D::
    ld a, [$C0A1]
    rst $00
    dw Jump_003_53D5
    dw Jump_003_5401
    dw Jump_003_540C
    dw Jump_003_5421
    dw Jump_003_542F
    dw Jump_003_5449
    dw Jump_003_54A9
    dw Jump_003_54B4
    dw Jump_003_54D4
    dw Jump_003_5512
    dw Jump_003_5547
    dw Jump_003_5550
    dw Jump_003_5547
    dw Jump_003_5401
    dw Jump_003_54B4
    dw Jump_003_54D4
    dw Jump_003_5512
    dw Jump_003_5547
    dw Jump_003_5550
    dw Jump_003_5547
    dw Jump_003_5401
    dw Jump_003_54B4
    dw Jump_003_5591
    dw Jump_003_55C9
    dw Jump_003_55DE
    dw Jump_003_55EB
    dw Jump_003_5619
    dw Jump_003_5622
    dw Jump_003_564A
    dw Jump_003_566D
    dw Jump_003_56D2
    dw Jump_003_56E4
    dw Jump_003_56EB
    dw Jump_003_5700

Jump_003_53D5::
    ld a, [$D088]
    bit 1, a
    jr nz, Jump_003_53FC
    ld a, [$D08A]
    or a, a
    jr z, Jump_003_53F0
    cp a, $04
    jr z, Jump_003_53F0
    cp a, $07
    jr z, Jump_003_53F6
    ld a, $0D
    ld [$C0A1], a
    ret

Jump_003_53F0::
    ld a, $04
    ld [$C0A1], a
    ret

Jump_003_53F6::
    ld a, $14
    ld [$C0A1], a
    ret

Jump_003_53FC::
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_5401::
    call Func_003_58E6
    call Func_003_42DA
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_540C::
    ld a, $08
    ld [$C528], a
    ld a, $06
    ld [$C529], a
    ld hl, Func_008_4001
    ld b, $08
    rst $10
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_5421::
    ld a, [$C52B]
    or a, a
    ret nz
    xor a, a
    ld [$C0A0], a
    xor a, a
    ld [$C0A1], a
    ret

Jump_003_542F::
    xor a, a
    ld [$C46D], a
    call Func_003_5874
    call Func_003_42DA
    ld a, [$C6FD]
    ld [$C0A2], a
    ld a, $01
    ld [$C0A3], a
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_5449::
    ld de, Func_003_460B
    ld hl, $C46D
    call Func_003_4425
    ld a, [$C563]
    and a, $C0
    jr z, Jump_003_5469
    call Func_003_5AA7
    ld hl, $9941
    ld bc, $0903
    ld de, $C2D9
    call Func_003_42E3
    ret

Jump_003_5469::
    ld a, [$C562]
    bit 0, a
    jr z, Jump_003_549C
    ld a, $69
    call Func_000_1278
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld a, [$C46D]
    and a, $03
    ld [$D083], a
    ld c, $01
    call Func_000_1F49
    ld e, l
    ld d, h
    ld hl, $C140
    call Func_000_2FE1
    xor a, a
    ld [$0100], a
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_549C::
    bit 1, a
    ret z
    ld a, $01
    ld [$C0A0], a
    xor a, a
    ld [$C0A1], a
    ret

Jump_003_54A9::
    call Func_003_58A6
    call Func_003_42DA
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_54B4::
    ld a, $00
    ld [$C528], a
    ld a, [$D08D]
    ld [$C529], a
    cp a, $25
    jr z, Jump_003_54CE
    ld hl, Func_037_4001
    ld b, $37
    rst $10
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_54CE::
    ld a, $1B
    ld [$C0A1], a
    ret

Jump_003_54D4::
    ld a, [$C52B]
    or a, a
    ret nz
    ld a, $0A
    ld [$0100], a
    ld a, $00
    ld [$4100], a
    ld hl, Func_016_4025
    ld b, $16
    rst $10
    xor a, a
    ld [$0100], a
    ld hl, $C0A1
    inc [hl]
    ld a, [$D081]
    cp a, $FF
    ret z
    ld a, [$D08A]
    cp a, $00
    jr z, Jump_003_550C
    cp a, $02
    jr z, Jump_003_550C
    cp a, $04
    jr z, Jump_003_550C
    ld a, $12
    ld [$C0A1], a
    ret

Jump_003_550C::
    ld a, $0B
    ld [$C0A1], a
    ret

Jump_003_5512::
    ld a, [$D082]
    ld hl, $C61D
    add a, l
    ld l, a
    jr nc, Jump_003_551D
    inc h

Jump_003_551D::
    ld a, [hl]
    cp a, $40
    jr c, Jump_003_5532
    cp a, $62
    jr nc, Jump_003_5532
    ld a, $32
    ld [$C529], a
    ld a, $00
    ld [$C528], a
    jr Jump_003_553C

Jump_003_5532::
    ld a, $02
    ld [$C529], a
    ld a, $00
    ld [$C528], a

Jump_003_553C::
    ld hl, Func_037_4001
    ld b, $37
    rst $10
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_5547::
    ld a, [$C52B]
    or a, a
    ret nz
    call Func_003_5E68
    ret

Jump_003_5550::
    ld a, $0A
    ld [$0100], a
    ld a, $00
    ld [$4100], a
    ld hl, Func_016_468E
    ld b, $16
    rst $10
    xor a, a
    ld [$0100], a
    ld a, [$D08E]
    ld [$C529], a
    cp a, $27
    jr z, Jump_003_5585

Jump_003_556E::
    ld a, $00
    ld [$C528], a
    ld hl, Func_037_4001
    ld b, $37
    rst $10
    ld hl, $C0A1
    inc [hl]
    xor a, a
    ld [$C0A6], a
    ld [$C46E], a
    ret

Jump_003_5585::
    ldh a, [$FFC6]
    or a, a
    jr z, Jump_003_556E
    ld a, $31
    ld [$C529], a
    jr Jump_003_556E

Jump_003_5591::
    ld a, [$C52B]
    or a, a
    ret nz
    ld a, $0A
    ld [$0100], a
    ld a, $00
    ld [$4100], a
    ld hl, Func_016_4025
    ld b, $16
    rst $10
    xor a, a
    ld [$0100], a
    ld hl, $C0A1
    inc [hl]
    ld a, [$D081]
    cp a, $FF
    ret z
    cp a, $FE
    ret z
    ld hl, $C0A1
    inc [hl]
    ld hl, $C0A1
    inc [hl]
    ld a, [$D08E]
    or a, a
    ret nz
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_55C9::
    ld a, $02
    ld [$C529], a
    ld a, $00
    ld [$C528], a
    ld hl, Func_037_4001
    ld b, $37
    rst $10
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_55DE::
    ld a, [$C52B]
    or a, a
    ret nz
    xor a, a
    ld [$C0A0], a
    ld [$C0A1], a
    ret

Jump_003_55EB::
    ld a, $0A
    ld [$0100], a
    ld a, $00
    ld [$4100], a
    ld hl, Func_016_468E
    ld b, $16
    rst $10
    xor a, a
    ld [$0100], a
    ld a, [$D08E]
    ld [$C529], a
    cp a, $FF
    jr z, Jump_003_5614
    ld a, $00
    ld [$C528], a
    ld hl, Func_037_4001
    ld b, $37
    rst $10

Jump_003_5614::
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_5619::
    ld a, [$C52B]
    or a, a
    ret nz
    call Func_003_4339
    ret

Jump_003_5622::
    ld hl, Func_016_4025
    ld b, $16
    rst $10
    ld hl, $C0A1
    inc [hl]
    ld a, [$D081]
    cp a, $FF
    jr nz, Jump_003_5643
    ld a, $01
    ld [$C528], a
    ld a, $14
    ld [$C529], a
    ld hl, $C0A1
    inc [hl]
    inc [hl]
    inc [hl]

Jump_003_5643::
    ld hl, Func_037_4001
    ld b, $37
    rst $10
    ret

Jump_003_564A::
    ld a, [$C52B]
    or a, a
    ret nz
    ld a, $6C
    call Func_000_1278
    call Func_003_7791
    call Func_003_42DA
    ld a, $02
    ld [$C0A2], a
    ld a, $01
    ld [$C0A3], a
    xor a, a
    ld [$C46F], a
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_566D::
    ld hl, $C46F
    ld de, Data_003_4645
    call Func_003_4425
    ld a, [$C562]
    bit 0, a
    jr z, Jump_003_56C7
    ld a, $69
    call Func_000_1278
    ld a, [$C46F]
    and a, $01
    jr nz, Jump_003_56CA
    ld a, [$CC44]
    cp a, $80
    jr nz, Jump_003_56AA
    ld a, [$C935]
    bit 7, a
    jr z, Jump_003_56AA
    ld a, [$CB7D]
    ld [$C96D], a
    ld a, [$CB7E]
    ld [$C96E], a
    xor a, a
    ld [$CB7D], a
    ld [$CB7E], a

Jump_003_56AA::
    ld a, $0A
    ld [$0100], a
    ld a, $00
    ld [$4100], a
    ld hl, Func_016_468E
    ld b, $16
    rst $10
    xor a, a
    ld [$0100], a
    xor a, a
    ld [$C0A4], a
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_56C7::
    bit 1, a
    ret z

Jump_003_56CA::
    xor a, a
    ld [$C0A0], a
    ld [$C0A1], a
    ret

Jump_003_56D2::
    call Func_003_4659
    ld a, [$C0A4]
    cp a, $04
    ret nz
    ld hl, $C0A1
    inc [hl]
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_56E4::
    ld a, [$C52B]
    or a, a
    ret nz
    jr Jump_003_56CA

Jump_003_56EB::
    ld a, $26
    ld [$C529], a
    ld a, $00
    ld [$C528], a
    ld hl, Func_037_4001
    ld b, $37
    rst $10
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_5700::
    ld a, [$C52B]
    or a, a
    ret nz
    ld a, [$CC44]
    cp a, $80
    jr nz, Jump_003_571F
    ld a, [$C935]
    bit 7, a
    jr z, Jump_003_571F
    ld a, [$C96D]
    ld [$CB7D], a
    ld a, [$C96E]
    ld [$CB7E], a

Jump_003_571F::
    call Func_003_5E68
    xor a, a
    ld [$C0A0], a
    ld [$C0A1], a
    ld [$C0A4], a
    ret

Jump_003_572D::
    ld a, [$C0A1]
    rst $00
    dw Jump_003_573F
    dw Jump_003_574A
    dw Jump_003_575F
    dw Jump_003_5782
    dw Jump_003_57C6
    dw Jump_003_580A
    dw Jump_003_581A

Jump_003_573F::
    call Func_003_58E6
    call Func_003_42DA
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_574A::
    ld a, $08
    ld [$C528], a
    ld a, $01
    ld [$C529], a
    ld hl, Func_008_4001
    ld b, $08
    rst $10
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_575F::
    ld a, [$C52B]
    or a, a
    ret nz
    xor a, a
    ld [$C470], a
    ld a, $02
    ld [$C0A2], a
    ld a, $01
    ld [$C0A3], a
    call Func_003_58CF
    call Func_003_42DA
    ld a, $6C
    call Func_000_1278
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_5782::
    ld de, Data_003_4623
    ld hl, $C470
    call Func_003_4425
    ld a, [$C562]
    bit 0, a
    jr z, Jump_003_57B9
    ld a, $69
    call Func_000_1278
    ld a, [$C470]
    and a, $01
    ld hl, Data_003_4623
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_003_57A5
    inc h

Jump_003_57A5::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, $BC
    call Func_000_1211
    ld a, [$C470]
    and a, $01
    add a, a
    add a, $04
    ld [$C0A1], a
    ret

Jump_003_57B9::
    bit 1, a
    ret z
    ld a, $01
    ld [$C0A0], a
    xor a, a
    ld [$C0A1], a
    ret

Jump_003_57C6::
    ld a, [$D08C]
    bit 1, a
    jr z, Jump_003_57E2
    ld a, $08
    ld [$C528], a
    ld a, $02
    ld [$C529], a
    ld hl, Func_008_4001
    ld b, $08
    rst $10
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_57E2::
    ld a, [$D082]
    ld hl, $C61D
    add a, l
    ld l, a
    jr nc, Jump_003_57ED
    inc h

Jump_003_57ED::
    ld [hl], $00
    ld a, $08
    ld [$C528], a
    ld a, $04
    ld [$C529], a
    ld hl, Func_008_4001
    ld b, $08
    rst $10
    ld hl, Func_016_4C48
    ld b, $16
    rst $10
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_580A::
    ld a, [$C52B]
    or a, a
    ret nz
    xor a, a
    ld [$C0A6], a
    ld [$C46E], a
    call Func_003_5E68
    ret

Jump_003_581A::
    call Func_003_5E68
    ret

Func_003_581E::
    call Func_003_4284
    ld e, $0B
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ld e, $0C
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ld a, [$C61D]
    or a, a
    ret z
    ld e, $0D
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ld a, [$C0A7]
    cp a, $02
    jr c, Jump_003_585C
    ld hl, $C2A6
    ld a, $C5
    ld [hl+], a
    ld a, [$C0A6]
    add a, $E1
    ld [hl+], a
    ld a, $BE
    ld [hl+], a
    ld a, [$C0A7]
    add a, $E0
    ld [hl+], a
    ld [hl], $C6

Jump_003_585C::
    ret

Func_003_585D::
    call Func_003_581E
    ld e, $0E
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ld a, [$C46E]
    and a, $07
    ld hl, $4617
    call Func_003_4538
    ret

Func_003_5874::
    call Func_003_585D
    ld e, $11
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ld e, $1B
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ld a, [$D081]
    ld hl, Data_003_5C8B
    add a, l
    ld l, a
    jr nc, Jump_003_5892
    inc h

Jump_003_5892::
    ld a, [hl]
    ld hl, Data_003_5CEE
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_003_589C
    inc h

Jump_003_589C::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    call Func_003_4290
    call Func_003_5AA7
    ret

Func_003_58A6::
    call Func_000_290E
    call Func_003_5874
    ld e, $10
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ld a, [$C46D]
    and a, $03
    ld hl, Func_003_460B
    call Func_003_4538
    ret

Func_003_58C0::
    call Func_003_585D
    ld e, $0F
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ret
    db $CD, $0E, $29

Func_003_58CF::
    call Func_003_58C0
    ld e, $10
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ld a, [$C46F]
    and a, $03
    ld hl, Data_003_461F
    call Func_003_4538
    ret

Func_003_58E6::
    call Func_000_290E
    call Func_003_585D
    ld e, $10
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ld a, [$C46F]
    and a, $03
    ld hl, Data_003_461F
    call Func_003_4538
    ret

Func_003_5900::
    ld a, [$C0A6]
    and a, $0F
    add a, a
    add a, a
    ld c, a
    ld a, [$C46E]
    and a, $0F
    add a, c
    ld c, a
    ld b, $00
    ld hl, $C61D
    add hl, bc
    ld a, [hl]
    cp a, $1F
    jr nz, Jump_003_591C
    ld a, $6F

Jump_003_591C::
    ld [$C529], a
    ld a, $06
    ld [$C528], a
    ld hl, $9230
    ld de, $1203
    call Func_003_43D9
    ret

Func_003_592E::
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
    ld hl, $0901
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld a, [$C61D]
    or a, a
    jr nz, Jump_003_5976
    ld a, $08
    ld [$C528], a
    ld a, $00
    ld [$C529], a
    ld hl, $95C0
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, Func_008_402B
    ld b, $08
    rst $10
    ld de, $C61E
    ld hl, $9650
    ld b, $03
    jr Jump_003_598A

Jump_003_5976::
    ld a, [$C0A6]
    and a, $0F
    add a, a
    add a, a
    ld de, $C61D
    add a, e
    ld e, a
    jr nc, Jump_003_5985
    inc d

Jump_003_5985::
    ld b, $04
    ld hl, $95C0

Jump_003_598A::
    ld a, $05
    ld [$C528], a

Jump_003_598F::
    ld a, [de]
    cp a, $FF
    jr nz, Jump_003_5995
    xor a, a

Jump_003_5995::
    inc de
    ld [$C529], a
    push bc
    push de
    push hl
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, Func_008_402B
    ld b, $08
    rst $10
    pop hl
    ld de, $0090
    add hl, de
    pop de
    pop bc
    dec b
    jr nz, Jump_003_598F
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

Func_003_59C7::
    ld a, [$C0A3]
    or a, a
    jr z, Jump_003_59DA
    ld a, [$C0A6]
    and a, $0F
    add a, $E1
    ld hl, $990F
    call Func_000_1211

Jump_003_59DA::
    ret

Func_003_59DB::
    ld a, [$C0A7]
    dec a
    ld c, a
    ld a, [$C0A6]
    and a, $0F
    cp a, c
    jr nz, Jump_003_59FC
    ld a, [$C0A5]
    ld [$C0A2], a
    ld c, a
    ld a, [$C46E]
    cp a, c
    jr c, Jump_003_5A01
    dec c
    ld a, c
    ld [$C46E], a
    jr Jump_003_5A01

Jump_003_59FC::
    ld a, $04
    ld [$C0A2], a

Jump_003_5A01::
    ld hl, $C0A6
    res 7, [hl]
    ret

Func_003_5A07::
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
    ld hl, $8EE0
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $2701
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld a, $00
    ld [$C528], a
    ld a, $00
    ld [$C529], a
    ld hl, Func_009_400F
    ld b, $09
    rst $10
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
    call Func_003_5900
    call Func_003_592E
    ret

Func_003_5A58::
    ld hl, $C61D
    ld bc, $1800

Jump_003_5A5E::
    ld a, [hl+]
    or a, a
    jr z, Jump_003_5A72
    cp a, $FF
    jr z, Jump_003_5A6C
    inc c
    dec b
    jr nz, Jump_003_5A5E
    jr Jump_003_5A72

Jump_003_5A6C::
    dec hl
    xor a, a

Jump_003_5A6E::
    ld [hl+], a
    dec b
    jr nz, Jump_003_5A6E

Jump_003_5A72::
    ld b, c
    ld a, $04
    call Func_000_16BF
    ld a, c
    and a, $03
    jr z, Jump_003_5A7E
    inc b

Jump_003_5A7E::
    ld a, b
    cp a, $00
    jr nz, Jump_003_5A85
    inc b
    ld a, b

Jump_003_5A85::
    ld [$C0A3], a
    ld [$C0A7], a
    ld a, c
    and a, $03
    or a, a
    jr nz, Jump_003_5A93
    ld a, $04

Jump_003_5A93::
    ld [$C0A5], a
    ld a, [$C0A6]
    cp a, b
    jr nz, Jump_003_5AA1
    ld a, [$C0A5]
    jr Jump_003_5AA3

Jump_003_5AA1::
    ld a, $04

Jump_003_5AA3::
    ld [$C0A2], a
    ret

Func_003_5AA7::
    ld a, [$C46D]
    ld c, a
    ld a, [$D081]
    ld hl, Data_003_5C8B
    add a, l
    ld l, a
    jr nc, Jump_003_5AB6
    inc h

Jump_003_5AB6::
    ld a, [hl]
    push af
    ld a, $0A
    ld [$0100], a
    ld a, $00
    ld [$4100], a
    pop af
    or a, a
    jr z, Jump_003_5AE5
    cp a, $01
    jr z, Jump_003_5AEA
    cp a, $02
    jr z, Jump_003_5B32
    cp a, $03
    jr z, Jump_003_5B01
    cp a, $04
    jr z, Jump_003_5B06
    cp a, $05
    jr z, Jump_003_5B0B
    cp a, $06
    jr z, Jump_003_5B10
    cp a, $07
    jr z, Jump_003_5B15
    jp Jump_003_5B85

Jump_003_5AE5::
    ld a, c
    ld c, $5B
    jr Jump_003_5AED

Jump_003_5AEA::
    ld a, c
    ld c, $5F

Jump_003_5AED::
    call Func_000_1F49
    ld a, [hl+]
    push hl
    ld h, [hl]
    ld l, a
    call Func_000_16F5
    ld de, $C319
    call Func_000_2123
    pop hl
    inc hl
    jr Jump_003_5B1B

Jump_003_5B01::
    ld a, c
    ld c, $6B
    jr Jump_003_5B18

Jump_003_5B06::
    ld a, c
    ld c, $63
    jr Jump_003_5B18

Jump_003_5B0B::
    ld a, c
    ld c, $65
    jr Jump_003_5B18

Jump_003_5B10::
    ld a, c
    ld c, $67
    jr Jump_003_5B18

Jump_003_5B15::
    ld a, c
    ld c, $69

Jump_003_5B18::
    call Func_000_1F49

Jump_003_5B1B::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    call Func_000_16F5
    ld de, $C31D
    call Func_000_2123
    ld a, $C3
    ld [$C2DE], a
    ld [$C2DF], a
    jp Jump_003_5BFA

Jump_003_5B32::
    ld a, c
    call Func_000_24C5
    call Func_000_2391
    ld c, a
    ld [$C529], a
    ld a, $07
    ld [$C528], a
    ld hl, Data_003_5C28
    ld b, $00
    add hl, bc
    ld a, [hl]
    push af
    ld hl, $91A0
    ld de, $0901
    call Func_003_43D9
    pop af
    ld hl, $C319
    ld c, a
    ld b, c
    ld a, $1A

Jump_003_5B5B::
    ld [hl+], a
    inc a
    dec b
    jr nz, Jump_003_5B5B
    ld a, $09
    sub a, c
    ld b, a
    or a, a
    jr z, Jump_003_5B6D
    ld a, $C3

Jump_003_5B69::
    ld [hl+], a
    dec b
    jr nz, Jump_003_5B69

Jump_003_5B6D::
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
    jr Jump_003_5BFA

Jump_003_5B85::
    ld a, c
    ld c, $A4
    call Func_000_1F49
    ld a, [hl]
    push af
    or a, a
    jr z, Jump_003_5B92
    add a, $3F

Jump_003_5B92::
    ld [$C529], a
    ld a, $05
    ld [$C528], a
    ld hl, $91A0
    ld de, $0901
    call Func_003_43D9
    pop af
    ld hl, Data_003_5C43
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_003_5BAD
    inc h

Jump_003_5BAD::
    ld b, [hl]
    ld a, l
    ldh [$FFC6], a
    ld a, h
    ldh [$FFC7], a
    ld hl, $C2D9
    ld a, b
    ld c, a
    or a, a
    jr z, Jump_003_5BC4
    ld a, $1A

Jump_003_5BBE::
    ld [hl+], a
    inc a
    dec b
    jr nz, Jump_003_5BBE
    ld d, a

Jump_003_5BC4::
    ld a, $07
    sub a, c
    cp a, $00
    jr z, Jump_003_5BD2
    ld b, a
    ld a, $C3

Jump_003_5BCE::
    ld [hl+], a
    dec b
    jr nz, Jump_003_5BCE

Jump_003_5BD2::
    ld hl, $C319
    ld b, $07
    ld a, c
    or a, a
    jr z, Jump_003_5BF2
    push hl
    ldh a, [$FFC6]
    ld l, a
    ldh a, [$FFC7]
    ld h, a
    inc hl
    ld b, [hl]
    pop hl

Jump_003_5BE5::
    ld a, b
    cp a, $00
    jr z, Jump_003_5BF0
    ld a, d
    ld [hl+], a
    inc d
    dec b
    jr nz, Jump_003_5BE5

Jump_003_5BF0::
    ld b, $03

Jump_003_5BF2::
    ld a, $C3

Jump_003_5BF4::
    ld [hl+], a
    dec b
    jr nz, Jump_003_5BF4
    jr Jump_003_5C11

Jump_003_5BFA::
    ld a, [$C46D]
    ld c, $55
    call Func_000_1F49
    bit 7, [hl]
    call nz, Func_003_5C16
    bit 2, [hl]
    call nz, Func_003_5C1C
    bit 0, [hl]
    call nz, Func_003_5C22

Jump_003_5C11::
    xor a, a
    ld [$0100], a
    ret

Func_003_5C16::
    ld a, $C2
    ld [$C2DF], a
    ret

Func_003_5C1C::
    ld a, $C1
    ld [$C2DF], a
    ret

Func_003_5C22::
    ld a, $C0
    ld [$C2DE], a
    ret

Data_003_5C28:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $08, $05, $04, $07, $05, $06, $08, $06, $09, $09, $07, $07, $06, $08, $08, $05
    db $06, $07, $05, $03, $05, $03, $07, $05, $08, $08, $04

Data_003_5C43:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $00DC43, $48

Data_003_5C8B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $04, $05, $06
    db $07, $00, $01, $02, $02, $02, $02, $02, $02, $03, $03, $03, $03, $03
    ds $22, $00
    ds $23, $08

Data_003_5CEE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_003_5D00
    dw Data_003_5D28
    dw Data_003_5D50
    dw Data_003_5D78
    dw Data_003_5DA0
    dw Data_003_5DC8
    dw Data_003_5DF0
    dw Data_003_5E18
    dw Data_003_5E40

; LZSS-compressed asset: 253 bytes expand to 321 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_003_5D00:: ; heuristic: target of a monotone pointer table; C0
    db $41, $01, $0C, $03, $FB, $FC, $ED
    ds $18, $C3
    db $BE, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3

; LZSS-compressed asset: 258 bytes expand to 321 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_003_5D28:: ; heuristic: target of a monotone pointer table; C0
    db $41, $01, $0C, $03, $FD, $FE, $ED
    ds $18, $C3
    db $BE, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3

; LZSS-compressed asset: 261 bytes expand to 321 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_003_5D50:: ; heuristic: target of a monotone pointer table; C0
    db $41, $01, $0C, $03, $F6, $F7, $F8, $F9, $FA, $0E, $0F, $10, $11, $12, $13, $C3
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $1A, $1B, $1C, $1D
    db $1E, $1F, $20, $21, $22, $C3, $C3, $C3

; LZSS-compressed asset: 273 bytes expand to 321 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_003_5D78:: ; heuristic: target of a monotone pointer table; C0
    db $41, $01, $0C, $03, $0B, $0C, $0D, $ED
    ds $20, $C3

; LZSS-compressed asset: 302 bytes expand to 321 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_003_5DA0:: ; heuristic: target of a monotone pointer table; C0
    db $41, $01, $0C, $03, $FF, $00, $01, $ED
    ds $20, $C3

; LZSS-compressed asset: 305 bytes expand to 321 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_003_5DC8:: ; heuristic: target of a monotone pointer table; C0
    db $41, $01, $0C, $03, $02, $03, $04, $ED
    ds $20, $C3

; LZSS-compressed asset: 311 bytes expand to 321 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_003_5DF0:: ; heuristic: target of a monotone pointer table; C0
    db $41, $01, $0C, $03, $05, $06, $07, $ED
    ds $20, $C3

; LZSS-compressed asset: 320 bytes expand to 321 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_003_5E18:: ; heuristic: target of a monotone pointer table; C0
    db $41, $01, $0C, $03, $08, $09, $0A, $ED
    ds $20, $C3

; LZSS-compressed asset: 324 bytes expand to 321 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_003_5E40:: ; heuristic: target of a monotone pointer table; C0
    db $41, $01, $0C, $03
    ds $24, $C3

Func_003_5E68::
    xor a, a
    ld [$C0A6], a
    xor a, a
    ld [$C46E], a
    call Func_003_5A58
    ld hl, $C0A6

Jump_003_5E76::
    ld a, [hl+]
    cp a, [hl]
    jr c, Jump_003_5E7E
    dec hl
    dec [hl]
    jr Jump_003_5E76

Jump_003_5E7E::
    call Func_003_592E
    xor a, a
    ld [$C0A0], a
    ld [$C0A1], a
    ret

Jump_003_5E89::
    ld a, [$C0A0]
    rst $00
    dw Jump_003_5E95
    dw Jump_003_5FAF
    dw Jump_003_60F9
    dw Jump_003_61CE

Jump_003_5E95::
    ld a, [$C0A1]
    rst $00
    dw Jump_003_5EA3
    dw Jump_003_5EF0
    dw Jump_003_5F7C
    dw Jump_003_5F90
    dw Jump_003_5FA5

Jump_003_5EA3::
    ld a, [$D095]
    or a, a
    call nz, Func_003_432F
    ld a, [$C0A3]
    or a, a
    jr z, Jump_003_5EC8
    ld a, $0A
    ld [$0100], a
    ld a, $00
    ld [$4100], a
    call Func_003_641E
    call Func_003_67B0
    ld a, $00
    ld [$0100], a
    call Func_003_42DA

Jump_003_5EC8::
    ld a, [$C6FD]
    ld [$C0A2], a
    ld a, $01
    ld [$C0A3], a
    ld hl, $C0A1
    inc [hl]
    ld a, $0A
    ld [$0100], a
    ld a, $00
    ld [$4100], a
    call Func_003_69C3
    call Func_003_6432
    ld a, $00
    ld [$0100], a
    call Func_003_42DA
    ret

Jump_003_5EF0::
    ld de, Func_003_460B
    ld hl, $C46D
    call Func_003_4425
    ld a, [$C563]
    and a, $C0
    jr z, Jump_003_5F23
    xor a, a
    ld [$C0A6], a
    ld a, $0A
    ld [$0100], a
    ld a, $00
    ld [$4100], a
    call Func_003_69C3
    call Func_003_6432
    call Func_003_67B0
    call Func_003_6A60
    ld a, $00
    ld [$0100], a
    call Func_003_42DA
    ret

Jump_003_5F23::
    ld a, [$C562]
    bit 0, a
    jr z, Jump_003_5F75
    ld a, $69
    call Func_000_1278
    ld a, $0A
    ld [$0100], a
    ld a, $00
    ld [$4100], a
    ld a, [$C46D]
    and a, $03
    ld c, $34
    call Func_000_1F49
    ld a, [hl]
    or a, a
    jr z, Jump_003_5F6F
    cp a, $FF
    jr z, Jump_003_5F6F
    ld a, [$C46D]
    ld c, $55
    call Func_000_1F49
    bit 7, [hl]
    jr nz, Jump_003_5F6A
    ld a, $01
    ld [$C0A0], a
    xor a, a
    ld [$C0A1], a
    xor a, a
    ld [$C0A6], a
    xor a, a
    ld [$C46E], a
    jr Jump_003_5F6F

Jump_003_5F6A::
    ld a, $02
    ld [$C0A1], a

Jump_003_5F6F::
    ld a, $00
    ld [$0100], a
    ret

Jump_003_5F75::
    bit 1, a
    ret z
    call Func_003_4339
    ret

Jump_003_5F7C::
    call Func_003_657B
    ld hl, $99A0
    ld bc, $1405
    ld de, $C338
    call Func_003_42E3
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_5F90::
    ld a, $01
    ld [$C528], a
    ld a, $1A
    ld [$C529], a
    ld hl, Func_037_4001
    ld b, $37
    rst $10
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_5FA5::
    ld a, [$C52B]
    or a, a
    ret nz
    xor a, a
    ld [$C0A1], a
    ret

Jump_003_5FAF::
    ld a, [$C0A1]
    rst $00
    dw Jump_003_5FBD
    dw Jump_003_601D
    dw Jump_003_60C6
    dw Jump_003_60D7
    dw Jump_003_60E7

Jump_003_5FBD::
    ld a, $0A
    ld [$0100], a
    ld a, $00
    ld [$4100], a
    call Func_003_646F
    call Func_003_65E3
    ld a, $00
    ld [$0100], a
    call Func_003_6432
    call Func_003_6A60
    call Func_003_42DA
    ld a, $0A
    ld [$0100], a
    ld a, $00
    ld [$4100], a
    ld a, [$C46D]
    and a, $03
    ld c, $34
    call Func_000_1F49
    ld bc, $0800

Jump_003_5FF2::
    ld a, [hl+]
    or a, a
    jr z, Jump_003_5FFB
    cp a, $FF
    jr z, Jump_003_5FFB
    inc c

Jump_003_5FFB::
    dec b
    jr nz, Jump_003_5FF2
    call Func_003_69FF
    ld [$C0A2], a
    call Func_003_6432
    call Func_003_6A34
    call Func_003_67B0
    call Func_003_6A60
    ld a, $00
    ld [$0100], a
    call Func_003_42DA
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_601D::
    ld de, $4617
    ld hl, $C46E
    call Func_003_4425
    ld a, [$C563]
    and a, $C0
    jr z, Jump_003_6052
    ld a, [$C0A2]
    cp a, $01
    ret z
    ld a, $0A
    ld [$0100], a
    ld a, $00
    ld [$4100], a
    call Func_003_65E3
    ld a, $00
    ld [$0100], a
    ld hl, $9A06
    ld bc, $0301
    ld de, $C39E
    call Func_003_42E3
    ret

Jump_003_6052::
    ld hl, $C46E
    bit 7, [hl]
    jr z, Jump_003_6083
    ld a, $0A
    ld [$0100], a
    ld a, $00
    ld [$4100], a
    res 7, [hl]
    call Func_003_6A34
    call Func_003_65E3
    call Func_003_67B0
    call Func_003_6A60
    ld hl, $9A06
    ld bc, $0301
    ld de, $C39E
    call Func_003_42E3
    ld a, $00
    ld [$0100], a
    ret

Jump_003_6083::
    ld a, [$C562]
    bit 0, a
    jr z, Jump_003_60B8
    ld a, $69
    call Func_000_1278
    call Func_003_66EE
    jr z, Jump_003_60A7
    call Func_003_66BB
    jr nz, Jump_003_60AE
    ld a, $02
    ld [$C0A0], a
    xor a, a
    ld [$C46F], a
    xor a, a
    ld [$C0A1], a
    ret

Jump_003_60A7::
    ld a, $1B
    ld [$C529], a
    jr Jump_003_60B3

Jump_003_60AE::
    ld a, $19
    ld [$C529], a

Jump_003_60B3::
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_60B8::
    bit 1, a
    ret z
    xor a, a
    ld [$C0A0], a
    ld [$C0A1], a
    ld [$C0A6], a
    ret

Jump_003_60C6::
    call Func_003_650C
    call Func_003_6432
    call Func_003_6A60
    call Func_003_42DA
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_60D7::
    ld a, $01
    ld [$C528], a
    ld hl, Func_037_4001
    ld b, $37
    rst $10
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_60E7::
    ld a, [$C52B]
    or a, a
    ret nz
    xor a, a
    ld [$C0A0], a
    xor a, a
    ld [$C0A1], a
    xor a, a
    ld [$C0A6], a
    ret

Jump_003_60F9::
    ld a, [$C0A1]
    rst $00
    dw Jump_003_6103
    dw Jump_003_6120
    dw Jump_003_6149

Jump_003_6103::
    ld a, [$CFF2]
    cp a, $21
    jr z, Jump_003_611B
    call Func_003_650C
    call Func_003_6432
    call Func_003_6A60
    call Func_003_42DA
    ld hl, $C0A0
    inc [hl]
    ret

Jump_003_611B::
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_6120::
    ld a, $0A
    ld [$0100], a
    ld a, $00
    ld [$4100], a
    call Func_003_649C
    call Func_003_664A
    ld a, $00
    ld [$0100], a
    call Func_003_6432
    call Func_003_6A60
    call Func_003_42DA
    ld a, [$C6FD]
    ld [$C0A2], a
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_6149::
    ld de, Func_003_460B
    ld hl, $C46F
    call Func_003_4425
    ld a, [$C563]
    and a, $C0
    jr z, Jump_003_6178
    ld a, $0A
    ld [$0100], a
    ld a, $00
    ld [$4100], a
    call Func_003_664A
    ld a, $00
    ld [$0100], a
    ld hl, $9941
    ld bc, $0703
    ld de, $C2D9
    call Func_003_42E3
    ret

Jump_003_6178::
    ld a, [$C562]
    bit 0, a
    jr z, Jump_003_61BD
    ld a, $69
    call Func_000_1278
    ld a, $0A
    ld [$0100], a
    ld a, $00
    ld [$4100], a
    ld a, [$C46F]
    and a, $03
    ld [$D083], a
    call Func_003_6526
    call Func_003_664A
    call Func_003_42DA
    ld a, [$D083]
    ld c, $01
    call Func_000_1F49
    ld e, l
    ld d, h
    ld hl, $C140
    call Func_000_2FE1
    ld a, $00
    ld [$0100], a
    ld hl, $C0A0
    inc [hl]
    xor a, a
    ld [$C0A1], a
    ret

Jump_003_61BD::
    bit 1, a
    ret z
    ld a, $01
    ld [$C0A0], a
    xor a, a
    ld [$C0A1], a
    xor a, a
    ld [$C0A6], a
    ret

Jump_003_61CE::
    ld a, [$C0A1]
    rst $00
    dw Jump_003_61EA
    dw Jump_003_6223
    dw Jump_003_6253
    dw Jump_003_6286
    dw Jump_003_62A1
    dw Jump_003_62B2
    dw Jump_003_630E
    dw Jump_003_6324
    dw Jump_003_6369
    dw Jump_003_6387
    dw Jump_003_63D0
    dw Jump_003_63F9

Jump_003_61EA::
    call Func_003_6432
    call Func_003_6A60
    call Func_003_42DA
    ld a, $0A
    ld [$0100], a
    ld a, $00
    ld [$4100], a
    ld a, [$C46D]
    ld c, $01
    call Func_000_1F49
    ld e, l
    ld d, h
    ld hl, $C130
    call Func_000_2FE1
    ld a, [$CFEC]
    ld l, a
    ld h, $04
    ld de, $C150
    call Func_000_2E81
    ld a, $00
    ld [$0100], a
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_6223::
    ld a, [$D082]
    ld hl, Data_003_6987
    add a, l
    ld l, a
    jr nc, Jump_003_622E
    inc h

Jump_003_622E::
    ld a, [hl]
    cp a, $FF
    call nz, Func_000_1278
    ld a, [$D082]
    ld hl, Data_003_69AF
    add a, l
    ld l, a
    jr nc, Jump_003_623F
    inc h

Jump_003_623F::
    ld a, [hl]
    ld [$C529], a
    ld a, $01
    ld [$C528], a
    ld hl, Func_037_4001
    ld b, $37
    rst $10
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_6253::
    ld a, [$C52B]
    or a, a
    ret nz
    ld a, [$C46F]
    ld [$D083], a
    ld a, $0A
    ld [$0100], a
    ld a, $00
    ld [$4100], a
    ld hl, Func_016_52C9
    ld b, $16
    rst $10
    ld a, $00
    ld [$0100], a
    ld hl, $C0A1
    inc [hl]
    ld a, [$D081]
    cp a, $FF
    ret z
    ld hl, $C0A1
    inc [hl]
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_6286::
    ld a, [$C52B]
    or a, a
    ret nz
    ld a, [$D08D]
    ld [$C529], a
    ld a, $01
    ld [$C528], a
    ld hl, Func_037_4001
    ld b, $37
    rst $10
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_62A1::
    ld a, [$C52B]
    or a, a
    ret nz
    xor a, a
    ld [$C0A0], a
    ld [$C0A1], a
    xor a, a
    ld [$C0A6], a
    ret

Jump_003_62B2::
    ld a, $0A
    ld [$0100], a
    ld a, $00
    ld [$4100], a
    ld a, [$CFEE]
    cp a, $FF
    jr nz, Jump_003_62D8
    ld a, [$C46D]
    ld c, $5F
    call Func_000_1F49
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, l
    ld [$D08F], a
    ld a, h
    ld [$D090], a
    jr Jump_003_62DB

Jump_003_62D8::
    ld l, a
    ld h, $00

Jump_003_62DB::
    push hl
    ld a, [$C46D]
    ld c, $5F
    call Func_000_1F49
    pop bc
    ld a, [hl]
    sub a, c
    ld [hl+], a
    ld a, [hl]
    sbc a, b
    ld [hl], a
    ld hl, $C0A1
    inc [hl]
    ld a, $00
    ld [$0100], a
    ld a, [$D081]
    cp a, $1E
    ret nz
    call Func_000_095B
    ld a, [$C5E7]
    bit 7, a
    ret z
    ld a, $13
    ld [$D08D], a
    ld a, $03
    ld [$C0A1], a
    ret

Jump_003_630E::
    ld a, [$D082]
    ld hl, Data_003_699B
    add a, l
    ld l, a
    jr nc, Jump_003_6319
    inc h

Jump_003_6319::
    ld a, [hl]
    cp a, $FF
    call nz, Func_000_1278
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_6324::
    ld a, $0A
    ld [$0100], a
    ld a, $00
    ld [$4100], a
    ld hl, Func_016_53E6
    ld b, $16
    rst $10
    ld a, $00
    ld [$0100], a
    ld a, [$D081]
    cp a, $19
    jr z, Jump_003_634F
    cp a, $1A
    jr z, Jump_003_634F
    cp a, $24
    jr z, Jump_003_634F
    ld a, $01
    ld [$C528], a
    jr Jump_003_6354

Jump_003_634F::
    ld a, $00
    ld [$C528], a

Jump_003_6354::
    ld a, [$D08D]
    ld [$C529], a
    cp a, $FF
    jr z, Jump_003_6364
    ld hl, Func_037_4001
    ld b, $37
    rst $10

Jump_003_6364::
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_6369::
    ld a, [$C52B]
    or a, a
    ret nz
    ld hl, $C0A1
    inc [hl]
    ld a, [$D082]
    cp a, $10
    ret z
    ld hl, $C0A1
    inc [hl]
    ld a, [$D082]
    cp a, $11
    ret z
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_6387::
    ld a, [$C52B]
    or a, a
    ret nz
    ld a, [$D081]
    cp a, $FF
    jr z, Jump_003_63CA
    ld a, [$D09E]
    ld hl, $D09F
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_003_639F
    inc h

Jump_003_639F::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, h
    add a, $02
    ld h, a
    ld de, $C160
    call Func_000_2E81
    ld a, $01
    ld [$C528], a
    ld a, $0C
    ld [$C529], a
    ld hl, Func_037_4001
    ld b, $37
    rst $10
    ld hl, $D09E
    ld a, [hl]
    inc a
    ld [hl-], a
    cp a, [hl]
    ret c
    ld a, $FF
    ld [$D081], a
    ret

Jump_003_63CA::
    ld a, $0B
    ld [$C0A1], a
    ret

Jump_003_63D0::
    ld a, [$C52B]
    or a, a
    ret nz
    ld a, [$D081]
    cp a, $FF
    jr z, Jump_003_63E3
    ld a, $0F
    ld [$C529], a
    jr Jump_003_63E8

Jump_003_63E3::
    ld a, $10
    ld [$C529], a

Jump_003_63E8::
    ld a, $01
    ld [$C528], a
    ld hl, Func_037_4001
    ld b, $37
    rst $10
    ld a, $0B
    ld [$C0A1], a
    ret

Jump_003_63F9::
    ld a, [$C52B]
    or a, a
    ret nz
    xor a, a
    ld [$C0A0], a
    ld [$C0A1], a
    ld a, [$D067]
    or a, a
    jr z, Jump_003_640F
    call Func_003_4339
    ret

Jump_003_640F::
    ld a, [$D081]
    cp a, $FF
    ret z
    xor a, a
    ld [$C0A6], a
    xor a, a
    ld [$C46E], a
    ret

Func_003_641E::
    call Func_003_4284
    ld e, $1C
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ld e, $0C
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ret

Func_003_6432::
    ld a, [$C46D]
    and a, $03
    ld c, $34
    call Func_000_1F49
    ld d, h
    ld e, l
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_003_6450

Jump_003_6443::
    ld de, Data_003_6A98
    ld bc, $0501
    ld hl, $C2A6
    call Func_003_42E3
    ret

Jump_003_6450::
    ld a, [$C0A7]
    cp a, $01
    jr z, Jump_003_6443
    ld hl, $C2A6
    ld a, $C5
    ld [hl+], a
    ld a, [$C0A6]
    add a, $E1
    ld [hl+], a
    ld a, $BE
    ld [hl+], a
    ld a, [$C0A7]
    add a, $E0
    ld [hl+], a
    ld [hl], $C6
    ret

Func_003_646F::
    call Func_003_641E
    ld e, $1D
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ld a, [$C46D]
    and a, $03
    ld c, $5F
    call Func_000_1F49
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    call Func_000_16F5
    ld de, $C3A2
    call Func_000_2123
    ld a, [$C46D]
    and a, $03
    ld hl, Func_003_460B
    call Func_003_4538
    ret

Func_003_649C::
    call Func_003_4284
    ld e, $20
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ld e, $0C
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ld e, $1D
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ld a, [$C46D]
    and a, $03
    ld c, $5F
    call Func_000_1F49
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    call Func_000_16F5
    ld de, $C3A2
    call Func_000_2123
    ld a, [$CFEE]
    cp a, $FF
    jr z, Jump_003_64DA
    ld l, a
    ld h, $00
    call Func_000_16F5

Jump_003_64DA::
    ld de, $C39E
    call Func_000_2123
    ld a, [$C46E]
    and a, $07
    ld hl, $4617
    call Func_003_4538
    ld a, [$CFEC]
    ld l, a
    ld a, [$CFED]
    ld h, a
    ld a, l
    add a, $51
    ld l, a
    ld a, h
    adc a, $68
    ld h, a
    ld a, [hl]
    ld hl, Data_003_6921
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_003_6505
    inc h

Jump_003_6505::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    call Func_003_4290
    ret

Func_003_650C::
    call Func_000_290E
    call Func_003_646F
    ld a, [$C46E]
    and a, $07
    ld hl, $4617
    call Func_003_4538
    ld e, $10
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ret

Func_003_6526::
    call Func_000_290E
    call Func_003_4284
    ld e, $20
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ld e, $0C
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ld a, [$C46E]
    and a, $07
    ld hl, $4617
    call Func_003_4538
    ld a, [$C46F]
    and a, $03
    ld hl, Func_003_460B
    call Func_003_4538
    ld a, [$CFEC]
    ld l, a
    ld a, [$CFED]
    ld h, a
    ld a, l
    add a, $51
    ld l, a
    ld a, h
    adc a, $68
    ld h, a
    ld a, [hl]
    ld hl, Data_003_6921
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_003_656C
    inc h

Jump_003_656C::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    call Func_003_4290
    ld e, $10
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ret

Func_003_657B::
    call Func_000_290E
    call Func_003_641E
    ld a, [$C46D]
    and a, $03
    ld hl, Func_003_460B
    call Func_003_4538
    ld e, $10
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ret

Func_003_6595::
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
    ld hl, $8EE0
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0701
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld a, $00
    ld [$C528], a
    ld a, $01
    ld [$C529], a
    ld hl, Func_009_400F
    ld b, $09
    rst $10
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
    call Func_003_67B0
    ret

Func_003_65E3::
    ld a, [$C46D]
    and a, $03
    ld c, $34
    call Func_000_1F49
    ld a, [$C46E]
    and a, $07
    ld c, a
    ld a, [$C0A6]
    and a, $0F
    add a, a
    add a, a
    add a, c
    add a, l
    ld l, a
    jr nc, Jump_003_6600
    inc h

Jump_003_6600::
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_003_6606
    xor a, a

Jump_003_6606::
    ld [$C529], a
    ld [$CFEC], a
    ld [$D081], a
    xor a, a
    ld [$CFED], a
    ld hl, Func_01A_4001
    ld b, $1A
    rst $10
    ld a, [$CFEE]
    cp a, $FF
    jr z, Jump_003_6625
    ld l, a
    ld h, $00
    jr Jump_003_6632

Jump_003_6625::
    ld a, [$C46D]
    and a, $03
    ld c, $5F
    call Func_000_1F49
    ld a, [hl+]
    ld h, [hl]
    ld l, a

Jump_003_6632::
    call Func_000_16F5
    ld de, $C39E
    call Func_000_2123
    ld a, $09
    ld [$C528], a
    ld hl, $9230
    ld de, $1203
    call Func_003_43D9
    ret

Func_003_664A::
    ld a, [$CFEC]
    ld l, a
    ld a, [$CFED]
    ld h, a
    ld a, l
    add a, $51
    ld l, a
    ld a, h
    adc a, $68
    ld h, a
    ld a, [hl]
    or a, a
    jr nz, Jump_003_6662
    ld c, $5B
    jr Jump_003_6664

Jump_003_6662::
    ld c, $5F

Jump_003_6664::
    ld a, [$C46F]
    and a, $03
    call Func_000_1F49
    ld a, [hl+]
    push hl
    ld h, [hl]
    ld l, a
    call Func_000_16F5
    ld de, $C319
    call Func_000_2123
    pop hl
    inc hl
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    call Func_000_16F5
    ld de, $C31D
    call Func_000_2123
    ld a, [$C46F]
    and a, $03
    ld c, $55
    call Func_000_1F49
    ld a, $C3
    ld [$C2DE], a
    ld [$C2DF], a
    bit 7, [hl]
    call nz, Func_003_66A9
    bit 2, [hl]
    call nz, Func_003_66AF
    bit 0, [hl]
    call nz, Func_003_66B5
    ret

Func_003_66A9::
    ld a, $C2
    ld [$C2DF], a
    ret

Func_003_66AF::
    ld a, $C1
    ld [$C2DF], a
    ret

Func_003_66B5::
    ld a, $C0
    ld [$C2DE], a
    ret

Func_003_66BB::
    ld a, $0A
    ld [$0100], a
    ld a, $00
    ld [$4100], a
    ld a, [$C46D]
    and a, $03
    ld c, $5F
    call Func_000_1F49
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld a, $00
    ld [$0100], a
    ld a, [$CFEE]
    cp a, $FF
    jr nz, Jump_003_66E2
    ld h, d
    ld l, e
    jr Jump_003_66E5

Jump_003_66E2::
    ld l, a
    ld h, $00

Jump_003_66E5::
    ld a, e
    sub a, l
    ld e, a
    ld a, d
    sbc a, h
    ld d, a
    bit 7, d
    ret

Func_003_66EE::
    ld a, [$CFEC]
    ld hl, Data_003_6700
    add a, l
    ld l, a
    jr nc, Jump_003_66F9
    inc h

Jump_003_66F9::
    ld a, [hl]
    ld [$D082], a
    cp a, $FF
    ret

Data_003_6700:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $16, $FF
    db $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $FF, $0A, $FF, $FF, $0B
    ds $7D, $FF
    db $0C, $0D, $0E, $0F, $10, $11, $12, $13, $FF, $FF, $FF, $FF, $FF, $FF

Func_003_67B0::
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
    ld hl, $0901
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld a, [$C46D]
    and a, $03
    ld c, $34
    call Func_000_1F49
    ld d, h
    ld e, l
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_003_6803
    ld a, $08
    ld [$C528], a
    ld a, $0E
    ld [$C529], a
    ld hl, $95C0
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    push de
    ld hl, Func_008_402B
    ld b, $08
    rst $10
    pop de
    inc de
    ld hl, $9650
    ld b, $03
    jr Jump_003_6814

Jump_003_6803::
    ld a, [$C0A6]
    and a, $0F
    add a, a
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_003_680F
    inc d

Jump_003_680F::
    ld b, $04
    ld hl, $95C0

Jump_003_6814::
    ld a, $04
    ld [$C528], a

Jump_003_6819::
    ld a, [de]
    cp a, $FF
    jr nz, Jump_003_681F
    xor a, a

Jump_003_681F::
    inc de
    ld [$C529], a
    push bc
    push de
    push hl
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, Func_008_402B
    ld b, $08
    rst $10
    pop hl
    ld de, $0090
    add hl, de
    pop de
    pop bc
    dec b
    jr nz, Jump_003_6819
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
    ds $1B, $00
    db $01, $01, $01
    ds $B2, $00

Data_003_6921:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $00E921, $66

Data_003_6987:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $7A, $7A, $7A, $7A, $7A, $7A, $7A, $7A, $7A, $7A, $7A, $7A, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF

Data_003_699B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $85, $85, $85, $85, $85, $85, $85, $85, $85, $85, $85, $85, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF

Data_003_69AF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $02, $00, $00
    db $03, $04, $05, $00

Func_003_69C3::
    ld a, [$C46D]
    and a, $03
    ld c, $34
    call Func_000_1F49
    ld c, $00

Jump_003_69CF::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_003_69D7
    inc c
    jr Jump_003_69CF

Jump_003_69D7::
    ld a, c
    cp a, $00
    jr z, Jump_003_69E6
    cp a, $05
    jr c, Jump_003_69E4
    ld a, $02
    jr Jump_003_69E6

Jump_003_69E4::
    ld a, $01

Jump_003_69E6::
    ld b, a
    ld [$C0A3], a
    ld [$C0A7], a
    ld a, c
    cp a, $09
    jr c, Jump_003_69F4
    ld a, $04

Jump_003_69F4::
    and a, $03
    or a, a
    jr nz, Jump_003_69FB
    ld a, $04

Jump_003_69FB::
    ld [$C0A5], a
    ret

Func_003_69FF::
    ld a, c
    cp a, $00
    jr z, Jump_003_6A0E
    cp a, $05
    jr c, Jump_003_6A0C
    ld a, $02
    jr Jump_003_6A0E

Jump_003_6A0C::
    ld a, $01

Jump_003_6A0E::
    ld b, a
    ld [$C0A3], a
    ld [$C0A7], a
    ld a, c
    cp a, $09
    jr c, Jump_003_6A1C
    ld a, $04

Jump_003_6A1C::
    and a, $03
    or a, a
    jr nz, Jump_003_6A23
    ld a, $04

Jump_003_6A23::
    ld [$C0A5], a
    ld a, [$C0A6]
    cp a, b
    jr nz, Jump_003_6A31
    ld a, [$C0A5]
    jr Jump_003_6A33

Jump_003_6A31::
    ld a, $04

Jump_003_6A33::
    ret

Func_003_6A34::
    ld a, [$C0A7]
    dec a
    ld c, a
    ld a, [$C0A6]
    and a, $0F
    cp a, c
    jr nz, Jump_003_6A55
    ld a, [$C0A5]
    ld [$C0A2], a
    ld c, a
    ld a, [$C46E]
    cp a, c
    jr c, Jump_003_6A5A
    dec c
    ld a, c
    ld [$C46E], a
    jr Jump_003_6A5A

Jump_003_6A55::
    ld a, $04
    ld [$C0A2], a

Jump_003_6A5A::
    ld hl, $C0A6
    res 7, [hl]
    ret

Func_003_6A60::
    ld a, [$C46D]
    and a, $03
    ld c, $34
    call Func_000_1F49
    ld d, h
    ld e, l
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_003_6A7E

Jump_003_6A71::
    ld de, Data_003_6A98
    ld bc, $0501
    ld hl, $C2A6
    call Func_003_42E3
    ret

Jump_003_6A7E::
    ld a, [$C0A7]
    cp a, $01
    jr z, Jump_003_6A71
    ld a, [$C0A3]
    or a, a
    ret z
    ld a, [$C0A6]
    and a, $0F
    add a, $E1
    ld hl, $990F
    call Func_000_1211
    ret

Data_003_6A98:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B4, $B4, $B4, $B4, $B4

Jump_003_6A9D::
    ld a, [$C0A0]
    rst $00
    dw Jump_003_6AAF
    dw Jump_003_6B67
    dw Jump_003_6ED8
    dw Jump_003_6FBE
    dw Jump_003_706B
    dw Jump_003_7398
    dw Jump_003_74EF

Jump_003_6AAF::
    ld a, [$C0A1]
    rst $00
    dw Jump_003_6ABB
    dw Jump_003_6ADC
    dw Jump_003_6B33
    dw Jump_003_6B54

Jump_003_6ABB::
    call Func_003_7692
    call Func_003_42DA
    call Func_000_222B
    ld hl, Func_016_7A64
    ld b, $16
    rst $10
    ld a, $06
    ld [$C0A2], a
    ld a, $01
    ld [$C0A3], a
    ld hl, $C0A1
    inc [hl]
    call Func_003_7B61
    ret

Jump_003_6ADC::
    ld hl, $C46D
    ld de, Func_003_460B
    call Func_003_4425
    ld a, [$C562]
    bit 0, a
    jr z, Jump_003_6B2C
    ld a, $69
    call Func_000_1278
    ld a, [$C46D]
    and a, $07
    ld hl, Func_003_460B
    call Func_003_454C
    ld a, [$C46D]
    and a, $07
    inc a
    ld [$C0A0], a
    cp a, $06
    jr nz, Jump_003_6B1F
    call Func_003_6B5E
    jr z, Jump_003_6B1F
    ld e, $10
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    xor a, a
    ld [$C0A0], a
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_6B1F::
    xor a, a
    ld [$C0A1], a
    xor a, a
    ld [$C0A6], a
    xor a, a
    ld [$C46E], a
    ret

Jump_003_6B2C::
    bit 1, a
    ret z
    call Func_003_4339
    ret

Jump_003_6B33::
    ld hl, $99A0
    ld de, $C338
    ld bc, $1405
    call Func_003_42E3
    ld a, $08
    ld [$C528], a
    ld a, $0D
    ld [$C529], a
    ld hl, Func_008_4001
    ld b, $08
    rst $10
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_6B54::
    ld a, [$C52B]
    or a, a
    ret nz
    xor a, a
    ld [$C0A1], a
    ret

Func_003_6B5E::
    ld hl, Func_016_4645
    ld b, $16
    rst $10
    ld a, c
    or a, a
    ret

Jump_003_6B67::
    ld a, [$C0A1]
    rst $00
    dw Jump_003_6B8D
    dw Jump_003_6BD7
    dw Jump_003_6C6E
    dw Jump_003_6C90
    dw Jump_003_6D31
    dw Jump_003_6D39
    dw Jump_003_6D90
    dw Jump_003_6DA3
    dw Jump_003_6DAB
    dw Jump_003_6DC0
    dw Jump_003_6DCA
    dw Jump_003_6DDC
    dw Jump_003_6DF1
    dw Jump_003_6DFB
    dw Jump_003_6E27
    dw Jump_003_6E88
    dw Jump_003_6E9D

Jump_003_6B8D::
    ld hl, $9710
    ld de, Data_01F_4910
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld hl, $9720
    ld de, Data_01F_4910
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld hl, $9730
    ld de, Data_01F_4910
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    call Func_003_76AD
    ld hl, $C52D
    ld a, $50
    ld [hl+], a
    ld a, $93
    ld [hl+], a
    ld a, $05
    ld [hl+], a
    ld a, $0C
    ld [hl+], a
    call Func_000_290E
    call Func_003_42DA
    call Func_003_779A
    call Func_003_78CB
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_6BD7::
    ld a, [$D0C7]
    or a, a
    jr z, Jump_003_6C52
    ld hl, $C46E
    ld de, Data_003_462B
    call Func_003_4425
    ld a, [$C562]
    and a, $04
    jr z, Jump_003_6C05
    ld a, $69
    call Func_000_1278
    ld a, [$C836]
    bit 7, a
    jr nz, Jump_003_6BFB
    xor a, $02

Jump_003_6BFB::
    res 7, a
    ld [$C836], a
    xor a, a
    ld [$C0A1], a
    ret

Jump_003_6C05::
    ld a, [$C563]
    and a, $C0
    jr z, Jump_003_6C10
    call Func_003_78CB
    ret

Jump_003_6C10::
    ld a, [$C563]
    and a, $30
    jr z, Jump_003_6C36
    ld a, [$C0A3]
    cp a, $02
    ret c
    call Func_003_779A
    call Func_003_78CB
    ld a, [$C0A3]
    cp a, $02
    ret c
    call Func_003_7A58
    ld hl, $9A2F
    ld a, [$C3C7]
    call Func_000_1211
    ret

Jump_003_6C36::
    ld a, [$C562]
    bit 0, a
    jr z, Jump_003_6C52
    ld a, $69
    call Func_000_1278
    ld a, [$C46E]
    and a, $07
    ld hl, Data_003_462B
    call Func_003_454C
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_6C52::
    ld a, [$C562]
    bit 1, a
    ret z
    xor a, a
    ld [$C0A0], a
    ld [$C0A1], a
    ld a, [$C5DC]
    bit 3, a
    ret z
    ld a, $40
    ld [$D067], a
    call Func_003_4339
    ret

Jump_003_6C6E::
    call Func_003_76C9
    ld hl, $9800
    ld de, $C198
    ld bc, $0709
    call Func_003_42E3
    ld a, $02
    ld [$C0A2], a
    ld a, $01
    ld [$C0A3], a
    xor a, a
    ld [$C46F], a
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_6C90::
    ld hl, $C46F
    ld de, Data_003_4633
    call Func_003_4425
    ld a, [$C562]
    bit 0, a
    jp z, Jump_003_6D29
    ld a, $69
    call Func_000_1278
    ld a, [$C46F]
    and a, $01
    jr nz, Jump_003_6CB2
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_6CB2::
    call Func_003_6EBF
    jr nz, Jump_003_6CEE
    push af
    ld c, a
    ld a, [$C833]
    cp a, c
    jr nz, Jump_003_6CC9
    ld a, [$CC44]
    bit 7, a
    jr z, Jump_003_6CC9
    pop af
    jr Jump_003_6D23

Jump_003_6CC9::
    pop af
    push af
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    ld a, [hl]
    cp a, $FE
    jr nz, Jump_003_6CE1
    pop af
    ld a, [hl]
    jr Jump_003_6CE2

Jump_003_6CE1::
    pop af

Jump_003_6CE2::
    ld de, $C150
    call Func_000_2458
    ld a, $0A
    ld [$C0A1], a
    ret

Jump_003_6CEE::
    and a, $7F
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    ld a, [hl]
    and a, $3F
    cp a, $07
    jr c, Jump_003_6D23
    ld [$C529], a
    ld a, $06
    ld [$C528], a
    ld hl, $C150
    ld a, l
    ld [$C53D], a
    ld a, h
    ld [$C53E], a
    ld hl, Func_009_4008
    ld b, $09
    rst $10
    ld a, $0A
    ld [$C0A1], a
    ret

Jump_003_6D23::
    ld a, $07
    ld [$C0A1], a
    ret

Jump_003_6D29::
    bit 1, a
    ret z
    xor a, a
    ld [$C0A1], a
    ret

Jump_003_6D31::
    call Func_003_76D5
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_6D39::
    call Func_003_6EBF
    jr nz, Jump_003_6D60
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    ld a, [hl]
    cp a, $FE
    jr nz, Jump_003_6D60
    ld a, [$C5DC]
    bit 3, a
    jr z, Jump_003_6D5C
    ld a, $40
    ld [$D067], a

Jump_003_6D5C::
    ld a, $0C
    jr Jump_003_6D69

Jump_003_6D60::
    ld a, [$C5DC]
    bit 3, a
    jr nz, Jump_003_6D73
    ld a, $09

Jump_003_6D69::
    ld [$C529], a
    ld a, $08
    ld [$C528], a
    jr Jump_003_6D85

Jump_003_6D73::
    call Func_003_6EBF
    set 7, a
    ld [$D067], a
    ld a, $08
    ld [$C528], a
    ld a, $0B
    ld [$C529], a

Jump_003_6D85::
    ld hl, Func_008_4001
    ld b, $08
    rst $10
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_6D90::
    ld a, [$C52B]
    or a, a
    ret nz
    xor a, a
    ld [$C0A1], a
    ld a, [$C5DC]
    bit 3, a
    ret z
    call Func_003_4339
    ret

Jump_003_6DA3::
    call Func_003_76D5
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_6DAB::
    ld a, $08
    ld [$C528], a
    ld a, $08
    ld [$C529], a
    ld hl, Func_008_4001
    ld b, $08
    rst $10
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_6DC0::
    ld a, [$C52B]
    or a, a
    ret nz
    xor a, a
    ld [$C0A1], a
    ret

Jump_003_6DCA::
    call Func_003_76D5
    ld a, $02
    ld [$C0A2], a
    ld a, $01
    ld [$C0A3], a
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_6DDC::
    ld a, $08
    ld [$C528], a
    ld a, $07
    ld [$C529], a
    ld hl, Func_008_4001
    ld b, $08
    rst $10
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_6DF1::
    ld a, [$C52B]
    or a, a
    ret nz
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_6DFB::
    call Func_003_7707
    ld hl, $98E0
    ld de, $C278
    ld bc, $0605
    call Func_003_42E3
    ld a, $6C
    call Func_000_1278
    ld a, $02
    ld [$C0A2], a
    ld a, $01
    ld [$C0A3], a
    xor a, a
    ld [$C470], a
    ld a, $01
    ld [$C470], a
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_6E27::
    ld hl, $C470
    ld de, Data_003_4627
    call Func_003_4425
    ld a, [$C562]
    bit 0, a
    jr z, Jump_003_6E53
    ld a, $69
    call Func_000_1278
    ld a, [$C470]
    and a, $01
    ld hl, Data_003_4627
    call Func_003_454C
    ld a, [$C470]
    and a, $01
    jr nz, Jump_003_6E56
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_6E53::
    bit 1, a
    ret z

Jump_003_6E56::
    call Func_003_76C9
    ld hl, $9880
    ld de, $C218
    ld bc, $0609
    call Func_003_42E3
    ld hl, $99A0
    ld de, $C338
    ld bc, $1405
    call Func_003_42E3
    call Func_003_779A
    ld a, $02
    ld [$C0A2], a
    ld a, $01
    ld [$C0A3], a
    xor a, a
    ld [$C46F], a
    ld a, $03
    ld [$C0A1], a
    ret

Jump_003_6E88::
    ld a, $04
    ld [$C529], a
    ld a, $08
    ld [$C528], a
    ld hl, Func_008_4001
    ld b, $08
    rst $10
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_6E9D::
    ld a, [$C52B]
    or a, a
    ret nz
    xor a, a
    ld [$C0A1], a
    call Func_003_6EBF
    jr z, Jump_003_6EAF
    res 7, a
    and a, $3F

Jump_003_6EAF::
    ldh [$FFC6], a
    ld hl, Func_012_69B0
    ld b, $12
    rst $10
    xor a, a
    ld [$C0A6], a
    ld [$C46E], a
    ret

Func_003_6EBF::
    ld a, [$C0A6]
    ld b, a
    add a, a
    add a, a
    ld b, a
    ld a, [$C46E]
    and a, $07
    add a, b
    ld hl, $D0A7
    add a, l
    ld l, a
    jr nc, Jump_003_6ED4
    inc h

Jump_003_6ED4::
    ld a, [hl]
    bit 7, a
    ret

Jump_003_6ED8::
    ld a, [$C0A1]
    rst $00
    dw Jump_003_6EE2
    dw Jump_003_6F00
    dw Jump_003_6F48

Jump_003_6EE2::
    xor a, a
    ld [$C0A8], a
    call Func_003_7726
    call Func_003_42DA
    ld a, $04
    ld [$C0A2], a
    ld a, $01
    ld [$C0A3], a
    ld a, $00
    ld [$C0A6], a
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_6F00::
    ld a, [$C0A8]
    ld hl, Data_003_6FBB
    add a, l
    ld l, a
    jr nc, Jump_003_6F0B
    inc h

Jump_003_6F0B::
    ld a, [hl]
    ld hl, $C286
    ld [hl+], a
    inc a
    ld [hl+], a
    inc a
    ld [hl+], a
    inc a
    ld [hl+], a
    inc a
    ld [hl], a
    ld hl, $98EA
    ld de, $C282
    ld bc, $090A
    call Func_003_42E3
    ld a, $0A
    ld [$0100], a
    ld a, $00
    ld [$4100], a
    ld a, [$C0A8]
    ld c, $0E
    call Func_000_1F49
    ld a, [hl]
    swap a
    and a, $03
    ld [$C46E], a
    ld a, $00
    ld [$0100], a
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_6F48::
    ld hl, $C46E
    ld de, Data_003_4637
    call Func_003_4425
    ld a, [$C562]
    bit 1, a
    jr z, Jump_003_6F6F
    ld a, [$C0A8]
    or a, a
    jr z, Jump_003_6F67
    dec a
    ld [$C0A8], a
    ld hl, $C0A1
    dec [hl]
    ret

Jump_003_6F67::
    xor a, a
    ld [$C0A0], a
    ld [$C0A1], a
    ret

Jump_003_6F6F::
    bit 0, a
    ret z
    ld a, $69
    call Func_000_1278
    ld a, $0A
    ld [$0100], a
    ld a, $00
    ld [$4100], a
    ld a, [$C0A8]
    ld c, $0E
    call Func_000_1F49
    ld a, [$C46E]
    and a, $03
    swap a
    ld c, a
    cp a, $30
    jr nz, Jump_003_6F9A
    ld a, [hl]
    and a, $C0
    jr Jump_003_6F9C

Jump_003_6F9A::
    rlca
    rlca

Jump_003_6F9C::
    or a, c
    ld c, a
    ld a, [hl]
    and a, $0F
    or a, c
    ld [hl], a
    ld a, $00
    ld [$0100], a
    ld a, [$C6FD]
    ld c, a
    ld a, [$C0A8]
    inc a
    ld [$C0A8], a
    cp a, c
    jr z, Jump_003_6F67
    ld hl, $C0A1
    dec [hl]
    ret

Data_003_6FBB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D0, $D5, $DA

Jump_003_6FBE::
    ld a, [$C0A1]
    rst $00
    dw Jump_003_6FC6
    dw Jump_003_6FD7

Jump_003_6FC6::
    call Func_003_7743
    call Func_003_42DA
    ld a, [$C834]
    ld [$C46E], a
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_6FD7::
    ld a, [$C562]
    bit 0, a
    jr z, Jump_003_6FED
    ld a, $69
    call Func_000_1278
    ld a, [$C46E]
    and a, $07
    ld [$C834], a
    jr Jump_003_6FF1

Jump_003_6FED::
    bit 1, a
    jr z, Jump_003_6FF9

Jump_003_6FF1::
    xor a, a
    ld [$C0A0], a
    ld [$C0A1], a
    ret

Jump_003_6FF9::
    ld a, [$C563]
    bit 5, a
    jr z, Jump_003_7009
    call Func_003_7052
    ld a, [$C46E]
    dec a
    jr Jump_003_7014

Jump_003_7009::
    bit 4, a
    jr z, Jump_003_702A
    call Func_003_7052
    ld a, [$C46E]
    inc a

Jump_003_7014::
    and a, $07
    ld [$C46E], a
    call Func_003_7049
    ld a, [$C5F0]
    and a, $F0
    ld [$C5F0], a
    ld a, $69
    call Func_000_1278
    ret

Jump_003_702A::
    ld a, [$C5F0]
    and a, $0F
    jr nz, Jump_003_7048
    ld a, [$C5F0]
    bit 4, a
    jr z, Jump_003_703D
    call Func_003_7049
    jr Jump_003_7048

Jump_003_703D::
    call Func_003_7052
    ld a, [$C5F0]
    set 3, a
    ld [$C5F0], a

Jump_003_7048::
    ret

Func_003_7049::
    call Func_003_705B
    ld a, $BB
    call Func_000_1211
    ret

Func_003_7052::
    call Func_003_705B
    ld a, $C3
    call Func_000_1211
    ret

Func_003_705B::
    ld a, [$C46E]
    ld hl, Data_003_4649
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_003_7067
    inc h

Jump_003_7067::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ret

Jump_003_706B::
    ld a, [$C0A1]
    rst $00
    dw Jump_003_707B
    dw Jump_003_70CA
    dw Jump_003_70D9
    dw Jump_003_716F
    dw Jump_003_7191
    dw Jump_003_71AE

Jump_003_707B::
    ld a, [$C6FD]
    dec a
    ld [$D09F], a
    ld c, $00
    ld a, c
    ld [$D0A0], a
    ld a, [$C6FD]
    cp a, $01
    jr z, Jump_003_7092
    inc c
    jr Jump_003_7094

Jump_003_7092::
    ld c, $FF

Jump_003_7094::
    ld a, c
    ld [$D0A1], a
    ld a, [$C6FD]
    cp a, $03
    jr nz, Jump_003_70A2
    inc c
    jr Jump_003_70A4

Jump_003_70A2::
    ld c, $FF

Jump_003_70A4::
    ld a, c
    ld [$D0A2], a
    ld a, $FF
    ld [$D0A3], a
    ld [$D0A4], a
    ld [$D0A5], a
    ld a, $01
    ld [$C0A3], a
    xor a, a
    ld [$C0A6], a
    ld [$C0A8], a
    call Func_003_774F
    call Func_003_42DA
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_70CA::
    call Func_003_7202
    xor a, a
    ld [$C46E], a
    call Func_003_7281
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_70D9::
    ld hl, $C46E
    ld de, Data_003_463F
    call Func_003_4425
    ld a, [$C563]
    and a, $C0
    jr z, Jump_003_70ED
    call Func_003_7281
    ret

Jump_003_70ED::
    ld a, [$C562]
    bit 0, a
    jr z, Jump_003_7134
    ld a, $69
    call Func_000_1278
    ld a, [$C46E]
    and a, $03
    ld hl, $D0A0
    add a, l
    ld l, a
    jr nc, Jump_003_7106
    inc h

Jump_003_7106::
    ld c, [hl]
    ld [hl], $FF
    ld a, [$C0A8]
    ld hl, $D0A3
    add a, l
    ld l, a
    jr nc, Jump_003_7114
    inc h

Jump_003_7114::
    ld [hl], c
    call Func_003_7335
    ld hl, $D09F
    dec [hl]
    ld a, [$C6FD]
    ld b, a
    ld a, [$C0A8]
    inc a
    ld [$C0A8], a
    cp a, b
    jr z, Jump_003_712F
    ld hl, $C0A1
    dec [hl]
    ret

Jump_003_712F::
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_7134::
    bit 1, a
    ret z
    ld a, [$C0A8]
    or a, a
    jr nz, Func_003_7145
    xor a, a
    ld [$C0A0], a
    ld [$C0A1], a
    ret

Func_003_7145::
    ld hl, $D09F
    inc [hl]
    ld a, [$C0A8]
    dec a
    ld [$C0A8], a
    ld hl, $D0A3
    add a, l
    ld l, a
    jr nc, Jump_003_7158
    inc h

Jump_003_7158::
    ld c, [hl]
    ld [hl], $FF
    ld a, [$D09F]
    ld hl, $D0A0
    add a, l
    ld l, a
    jr nc, Jump_003_7166
    inc h

Jump_003_7166::
    ld [hl], c
    call Func_003_7335
    ld hl, $C0A1
    dec [hl]
    ret

Jump_003_716F::
    call Func_003_7692
    ld a, [$C46D]
    and a, $07
    ld hl, Func_003_460B
    call Func_003_4538
    call Func_003_7202
    ld de, $C2C0
    ld hl, $9928
    ld bc, $0C09
    call Func_003_42E3
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_7191::
    ld a, [$C562]
    and a, $01
    jr z, Jump_003_71A3
    call Func_003_71CA
    xor a, a
    ld [$C0A0], a
    ld [$C0A1], a
    ret

Jump_003_71A3::
    ld a, [$C562]
    and a, $02
    ret z
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_71AE::
    call Func_003_774F
    call Func_003_7145
    call Func_003_7202
    xor a, a
    ld [$C46E], a
    call Func_003_7281
    call Func_003_42DA
    ld hl, $C0A1
    dec [hl]
    ld hl, $C0A1
    dec [hl]
    ret

Func_003_71CA::
    ld a, [$D0A3]
    ld hl, $C6FE
    add a, l
    ld l, a
    jr nc, Jump_003_71D5
    inc h

Jump_003_71D5::
    ld c, [hl]
    ld a, [$D0A4]
    cp a, $FF
    jr z, Jump_003_71FD
    ld hl, $C6FE
    add a, l
    ld l, a
    jr nc, Jump_003_71E5
    inc h

Jump_003_71E5::
    ld b, [hl]
    ld a, [$D0A5]
    cp a, $FF
    jr z, Jump_003_71F9
    ld hl, $C6FE
    add a, l
    ld l, a
    jr nc, Jump_003_71F5
    inc h

Jump_003_71F5::
    ld a, [hl]
    ld [$C700], a

Jump_003_71F9::
    ld a, b
    ld [$C6FF], a

Jump_003_71FD::
    ld a, c
    ld [$C6FE], a
    ret

Func_003_7202::
    call Func_003_775A
    ld a, [$D09F]
    inc a
    ld [$C0A2], a
    ld de, $C1FB
    ld a, [$D0A0]
    call Func_003_726E
    ld de, $C23B
    ld a, [$D0A1]
    call Func_003_726E
    ld de, $C27B
    ld a, [$D0A2]
    call Func_003_726E
    ld de, $C204
    ld a, [$D0A3]
    ld b, $E1
    call Func_003_7278
    ld de, $C244
    ld a, [$D0A4]
    ld b, $E2
    call Func_003_7278
    ld de, $C284
    ld a, [$D0A5]
    ld b, $E3
    call Func_003_7278
    ld de, $C1FB
    ld hl, $9863
    ld bc, $1005
    call Func_003_42E3
    ret

Jump_003_7255::
    inc de
    inc de

Func_003_7257::
    ld hl, Data_003_7395
    add a, l
    ld l, a
    jr nc, Jump_003_725F
    inc h

Jump_003_725F::
    ld a, [hl]
    ld [de], a
    inc a
    inc de
    ld [de], a
    inc a
    inc de
    ld [de], a
    inc a
    inc de
    ld [de], a
    inc a
    inc de
    ld [de], a
    ret

Func_003_726E::
    cp a, $FF
    ret z
    push af
    add a, $E1
    ld [de], a
    pop af
    jr Jump_003_7255

Func_003_7278::
    cp a, $FF
    ret z
    push af
    ld a, b
    ld [de], a
    pop af
    jr Jump_003_7255

Func_003_7281::
    ld a, $0A
    ld [$0100], a
    ld a, $00
    ld [$4100], a
    ld a, [$C46E]
    and a, $03
    ld hl, $D0A0
    add a, l
    ld l, a
    jr nc, Jump_003_7298
    inc h

Jump_003_7298::
    ld a, [hl]
    push af
    ld c, $0B
    call Func_000_1F49
    ld a, [hl+]
    ld [$C529], a
    ld a, [hl+]
    push hl
    add a, $02
    ld [$C528], a
    ld hl, $9200
    ld de, $0901
    call Func_003_43D9
    pop hl
    inc hl
    ld a, [hl]
    and a, $01
    add a, $CC
    ld [$C2E6], a
    ld a, l
    add a, $48
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl]
    push hl
    ld l, a
    ld h, $00
    call Func_000_16F5
    ld de, $C2E9
    call Func_000_210D
    pop hl
    ld a, l
    add a, $05
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl+]
    push hl
    ld h, [hl]
    ld l, a
    call Func_000_16F5
    ld de, $C364
    call Func_000_2123
    pop hl
    inc hl
    ld a, [hl+]
    push hl
    ld h, [hl]
    ld l, a
    call Func_000_16F5
    ld de, $C368
    call Func_000_2123
    pop hl
    inc hl
    ld a, [hl+]
    push hl
    ld h, [hl]
    ld l, a
    call Func_000_16F5
    ld de, $C3A4
    call Func_000_2123
    pop hl
    inc hl
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    call Func_000_16F5
    ld de, $C3A8
    call Func_000_2123
    pop af
    push af
    add a, $C7
    ld [$C321], a
    pop af
    ld de, $C2E1
    call Func_003_7257
    ld a, $00
    ld [$0100], a
    ld hl, $9949
    ld de, $C2E1
    ld bc, $0A07
    call Func_003_42E3
    ret

Func_003_7335::
    ld a, [$D0A0]
    ld c, a
    ld a, [$D0A1]
    ld b, a
    ld a, [$D0A2]
    ld e, a
    cp a, b
    jr c, Jump_003_7360
    cp a, c
    jr c, Jump_003_7389
    ld [$D0A2], a
    ld a, b
    cp a, c
    jr c, Jump_003_7357
    ld [$D0A1], a
    ld a, c
    ld [$D0A0], a
    jr Jump_003_7394

Jump_003_7357::
    ld [$D0A0], a
    ld a, c
    ld [$D0A1], a
    jr Jump_003_7394

Jump_003_7360::
    cp a, c
    jr c, Jump_003_7370
    ld [$D0A1], a
    ld a, c
    ld [$D0A0], a
    ld a, b
    ld [$D0A2], a
    jr Jump_003_7394

Jump_003_7370::
    ld [$D0A0], a
    ld a, b
    cp a, c
    jr c, Jump_003_7380
    ld [$D0A2], a
    ld a, c
    ld [$D0A1], a
    jr Jump_003_7394

Jump_003_7380::
    ld [$D0A1], a
    ld a, c
    ld [$D0A2], a
    jr Jump_003_7394

Jump_003_7389::
    ld [$D0A1], a
    ld a, b
    ld [$D0A0], a
    ld a, c
    ld [$D0A2], a

Jump_003_7394::
    ret

Data_003_7395:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D0, $D5, $DA

Jump_003_7398::
    ld a, [$C0A1]
    rst $00
    dw Jump_003_73A0
    dw Jump_003_7487

Jump_003_73A0::
    call Func_003_7763
    ld a, $20
    ld [$D09E], a
    ld hl, Func_016_7A5B
    ld b, $16
    rst $10
    ld hl, $C60C
    call Func_003_4414
    ld hl, $9300
    call Func_003_43CC
    ld a, [$C830]
    ld l, a
    ld a, [$C831]
    ld h, a
    call Func_000_16F5
    ld de, $C200
    call Func_003_74DA
    ld a, [$C82F]
    call Func_003_74CA
    ld de, $C204
    call Func_003_74E2
    call Func_003_7B25
    ld a, [$D09D]
    ld de, $C243
    call Func_003_74D1
    ld a, [$D09E]
    ld de, $C249
    call Func_003_74D1
    ld hl, Func_01D_6DF8
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld de, $C283
    call Func_003_74D1
    ld hl, Func_016_5AC0
    ld b, $16
    rst $10
    ld a, [$D09D]
    ld de, $C31B
    call Func_003_74D1
    ld a, [$D09E]
    ld de, $C31F
    call Func_003_74D1
    ld a, [$D09F]
    ld de, $C323
    call Func_003_74D1
    ld a, [$D0A0]
    ld de, $C327
    call Func_003_74D1
    ld a, [$D0A1]
    ld de, $C35B
    call Func_003_74D1
    ld a, [$D0A2]
    ld de, $C35F
    call Func_003_74D1
    ld a, [$D0A3]
    ld de, $C363
    call Func_003_74D1
    ld a, [$D0A4]
    ld de, $C367
    call Func_003_74D1
    ld a, [$D0A5]
    ld de, $C39B
    call Func_003_74D1
    ld a, [$D0A6]
    ld de, $C39F
    call Func_003_74D1
    ld a, [$D0A7]
    ld de, $C3A3
    call Func_003_74D1
    ld hl, $0000
    ld de, $D09D
    ld b, $0B

Jump_003_746C::
    ld a, [de]
    inc de
    add a, l
    ld l, a
    jr nc, Jump_003_7473
    inc h

Jump_003_7473::
    dec b
    jr nz, Jump_003_746C
    call Func_000_16F5
    ld de, $C2E6
    call Func_000_2123
    call Func_003_42DA
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_7487::
    ld a, [$C562]
    and a, $03
    jr nz, Jump_003_74C2
    ld a, [$C82D]
    or a, a
    ret nz
    ld a, [$C82E]
    or a, a
    ret nz
    ld a, [$C82F]
    call Func_003_74CA
    ld de, $C204
    call Func_003_74E2
    ld a, [$C830]
    ld l, a
    ld a, [$C831]
    ld h, a
    call Func_000_16F5
    ld de, $C200
    call Func_003_74DA
    ld de, $C200
    ld hl, $9868
    ld bc, $0601
    call Func_003_42E3
    ret

Jump_003_74C2::
    xor a, a
    ld [$C0A0], a
    ld [$C0A1], a
    ret

Func_003_74CA::
    ld l, a
    ld h, $00
    call Func_000_16F5
    ret

Func_003_74D1::
    push de
    call Func_003_74CA
    pop de
    call Func_000_210D
    ret

Func_003_74DA::
    ld hl, $C8C0
    ld a, [hl]
    add a, $E0
    ld [de], a
    inc de

Func_003_74E2::
    ld hl, $C8C1
    ld a, [hl+]
    add a, $E0
    ld [de], a
    inc de
    ld a, [hl]
    add a, $E0
    ld [de], a
    ret

Jump_003_74EF::
    ld a, [$C0A1]
    rst $00
    dw Jump_003_7501
    dw Jump_003_7571
    dw Jump_003_75A4
    dw Jump_003_75EE
    dw Jump_003_75FF
    dw Jump_003_7617
    dw Jump_003_7630

Jump_003_7501::
    xor a, a
    ldh [$FFB9], a
    call Func_003_776C
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
    ld hl, $9050
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0401
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld a, $00
    ld [$C528], a
    ld a, $04
    ld [$C529], a
    ld hl, Func_007_400F
    ld b, $07
    rst $10
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
    ld a, $C3
    ld [$C1F9], a
    call Func_003_42DA
    ld a, $00
    ld [$C528], a
    ld a, $25
    ld [$C529], a
    ld hl, Func_037_4001
    ld b, $37
    rst $10
    call Func_003_7647
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_7571::
    call Func_003_7647
    ld a, [$C52B]
    or a, a
    ret nz
    ld de, Data_01F_4330
    ld hl, $8F40
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld a, $6C
    call Func_000_1278
    call Func_003_7791
    call Func_003_42DA
    ld a, $02
    ld [$C0A2], a
    ld a, $01
    ld [$C0A3], a
    xor a, a
    ld [$C46F], a
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_75A4::
    ld hl, $C46F
    ld de, Data_003_4645
    call Func_003_4425
    ld a, [$C562]
    bit 0, a
    jr z, Jump_003_75E6
    ld a, $69
    call Func_000_1278
    ld a, [$C46F]
    and a, $01
    ld hl, Data_003_4645
    call Func_003_454C
    ld a, [$C46F]
    and a, $01
    jr nz, Jump_003_75D7
    call Func_003_7647
    xor a, a
    ld [$C0A4], a
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_75D7::
    ld a, [$C5DC]
    bit 3, a
    jr nz, Jump_003_7633
    xor a, a
    ld [$C0A0], a
    ld [$C0A1], a
    ret

Jump_003_75E6::
    bit 1, a
    jr nz, Jump_003_75D7
    call Func_003_7647
    ret

Jump_003_75EE::
    call Func_003_7647
    call Func_003_4659
    ld a, [$C0A4]
    cp a, $04
    ret nz
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_75FF::
    call Func_003_7647
    ld a, $00
    ld [$C528], a
    ld a, $26
    ld [$C529], a
    ld hl, Func_037_4001
    ld b, $37
    rst $10
    ld hl, $C0A1
    inc [hl]
    ret

Jump_003_7617::
    ld a, [$C52B]
    or a, a
    jr z, Jump_003_7621
    call Func_003_7647
    ret

Jump_003_7621::
    ld a, [$C5DC]
    bit 3, a
    jr nz, Jump_003_7633
    xor a, a
    ld [$C0A0], a
    ld [$C0A1], a
    ret

Jump_003_7630::
    jp Jump_000_015A

Jump_003_7633::
    ld bc, $0240
    ld hl, $C198
    ld a, $C3
    call Func_000_0949
    call Func_003_42DA
    ld a, $06
    ld [$C0A1], a
    ret

Func_003_7647::
    ld a, $0A
    ld [$0100], a
    ld a, $01
    ld [$4100], a
    ld a, [$D0D5]
    or a, a
    jr z, Jump_003_7689
    ld a, [$D10A]
    or a, a
    jr z, Jump_003_7689
    ld a, $29
    ldh [$FFAD], a
    xor a, a
    ldh [$FFAE], a
    ldh [$FFAF], a
    ldh [$FFB0], a
    ld hl, $0080
    ld a, l
    ldh [$FFA9], a
    ld a, h
    ldh [$FFAA], a
    ld hl, $0030
    ld a, l
    ldh [$FFAB], a
    ld a, h
    ldh [$FFAC], a
    xor a, a
    ld [$4100], a
    xor a, a
    ld [$0100], a
    ld hl, Func_07F_700A
    ld b, $7F
    rst $10
    ret

Jump_003_7689::
    xor a, a
    ld [$4100], a
    xor a, a
    ld [$0100], a
    ret

Func_003_7692::
    call Func_003_4284
    ld e, $21
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ret

Func_003_769E::
    call Func_003_7692
    ld a, [$C46D]
    and a, $07
    ld hl, Func_003_460B
    call Func_003_4538
    ret

Func_003_76AD::
    call Func_003_769E
    ld e, $23
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    call Func_003_7978
    jr z, Jump_003_76C5
    ld e, $22
    ld hl, Func_033_4001
    ld b, $33
    rst $10

Jump_003_76C5::
    call Func_003_7A58
    ret

Func_003_76C9::
    call Func_003_76AD
    ld e, $24
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ret

Func_003_76D5::
    call Func_003_76C9
    call Func_000_290E
    ld e, $10
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ld a, [$C46F]
    and a, $07
    ld hl, Data_003_4633
    call Func_003_4538
    ld hl, $9880
    ld de, $C218
    ld bc, $0609
    call Func_003_42E3
    ld hl, $99A0
    ld de, $C338
    ld bc, $1405
    call Func_003_42E3
    ret

Func_003_7707::
    call Func_003_76C9
    ld a, [$C46F]
    and a, $07
    ld hl, Data_003_4633
    call Func_003_4538
    ld e, $25
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ld e, $10
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ret

Func_003_7726::
    call Func_003_769E
    ld hl, Data_003_7B9F
    ld de, Data_003_7BAF
    call Func_003_7BBF
    ld e, $26
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ld e, $27
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ret

Func_003_7743::
    call Func_003_769E
    ld e, $2C
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ret

Func_003_774F::
    call Func_003_769E
    ld e, $29
    ld hl, Func_033_4001
    ld b, $33
    rst $10

Func_003_775A::
    ld e, $28
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ret

Func_003_7763::
    ld e, $2D
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ret

Func_003_776C::
    ld e, $2A
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ld a, [$C46D]
    and a, $07
    ld hl, Func_003_460B
    call Func_003_4538
    call Func_000_290E
    ld e, $10
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ld hl, Func_016_777B
    ld b, $16
    rst $10
    ret

Func_003_7791::
    ld e, $2B
    ld hl, Func_033_4001
    ld b, $33
    rst $10
    ret

Func_003_779A::
    ld hl, $0C01
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld a, [$C0A6]
    ld b, a
    add a, a
    add a, a
    ld de, $D0A7
    add a, e
    ld e, a
    jr nc, Jump_003_77B3
    inc d

Jump_003_77B3::
    ld bc, $0400
    ld a, [$D0C7]
    or a, a
    jr nz, Jump_003_77E0
    ld a, $08
    ld [$C528], a
    ld a, $00
    ld [$C529], a
    ld hl, $9440
    ld de, $0C01
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, Func_008_402B
    ld b, $08
    rst $10
    ld bc, $0301
    ld de, $D0A8

Jump_003_77E0::
    push bc
    push de
    ld a, c
    ld hl, Data_003_78B9
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_003_77EC
    inc h

Jump_003_77EC::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld a, [de]
    call Func_003_7880
    cp a, $FF
    jr z, Jump_003_7851
    and a, $3F
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
    jr nz, Jump_003_783B
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    cp a, $FE
    jr z, Jump_003_781C
    ld a, [de]

Jump_003_781C::
    ld de, $C130
    call Func_000_2458
    ld a, $5B
    ld [de], a
    inc de
    ld a, $F0
    ld [de], a
    ld a, $08
    ld [$C528], a
    ld a, $05
    ld [$C529], a
    ld hl, Func_008_402B
    ld b, $08
    rst $10
    jr Jump_003_7861

Jump_003_783B::
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    and a, $3F
    ld [$C529], a
    ld a, $06
    ld [$C528], a
    ld hl, Func_009_400F
    ld b, $09
    rst $10
    jr Jump_003_7861

Jump_003_7851::
    ld a, $06
    ld [$C528], a
    ld a, $00
    ld [$C529], a
    ld hl, Func_009_400F
    ld b, $09
    rst $10

Jump_003_7861::
    pop de
    pop bc
    inc de
    inc c
    dec b
    jp nz, Jump_003_77E0
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

Func_003_7880::
    push af
    cp a, $FF
    jr z, Jump_003_7899
    and a, $3F
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    ld a, [hl]
    and a, $F0
    cp a, $F0

Jump_003_7899::
    push af
    ld a, c
    ld hl, Data_003_78C3
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_003_78A4
    inc h

Jump_003_78A4::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    pop af
    jr z, Jump_003_78B2
    bit 6, a
    jr z, Jump_003_78B2
    ld a, $1D
    jr Jump_003_78B4

Jump_003_78B2::
    ld a, $C3

Jump_003_78B4::
    call Func_000_1211
    pop af
    ret

Data_003_78B9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $40, $94, $00, $95, $C0, $95, $80, $96, $40, $97

Data_003_78C3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $46, $99, $86, $99, $C6, $99, $06, $9A

Func_003_78CB::
    ld a, [$D0C7]
    or a, a
    ret z
    ld hl, $9200
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0C03
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld a, [$C0A6]
    ld b, a
    add a, a
    add a, a
    ld b, a
    ld hl, $D0A7
    add a, l
    ld l, a
    jr nc, Jump_003_78F5
    inc h

Jump_003_78F5::
    ld a, [$C46E]
    and a, $07
    add a, l
    ld l, a
    jr nc, Jump_003_78FF
    inc h

Jump_003_78FF::
    ld a, [hl]
    and a, $3F
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
    bit 7, [hl]
    jr nz, Jump_003_794D
    ld de, $D0A7
    ld a, [$C0A6]
    ld b, a
    add a, a
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_003_7921
    inc d

Jump_003_7921::
    ld a, [$C46E]
    and a, $03
    add a, e
    ld e, a
    jr nc, Jump_003_792B
    inc d

Jump_003_792B::
    ld a, [de]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    ld a, [hl]
    cp a, $FE
    jr z, Jump_003_7949
    ld a, [de]
    ld de, $C130
    call Func_000_2458
    ld a, $0E
    jr Jump_003_7953

Jump_003_7949::
    ld a, $0D
    jr Jump_003_7953

Jump_003_794D::
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    and a, $3F

Jump_003_7953::
    ld [$C529], a
    ld a, $07
    ld [$C528], a
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

Func_003_7978::
    ld hl, $D0A7
    ld bc, $0020
    ld a, $FF
    call Func_000_0949
    ld hl, $D0A7
    ld de, $C707
    ld bc, $2000
    xor a, a
    ld [$D0C7], a
    ld a, [$C836]
    bit 1, a
    jr nz, Jump_003_79F6

Jump_003_7997::
    ld a, [de]
    cp a, $FF
    jr z, Jump_003_79B4
    push de
    ld a, e
    add a, $03
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    ld a, [de]
    pop de
    bit 7, a
    jr nz, Jump_003_79B4
    ld [hl], c
    inc hl
    ld a, [$D0C7]
    inc a
    ld [$D0C7], a

Jump_003_79B4::
    inc c
    ld a, e
    add a, $04
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    dec b
    jr nz, Jump_003_7997
    ld de, $C707
    ld bc, $2000

Jump_003_79C6::
    ld a, [de]
    or a, a
    jr z, Jump_003_79E8
    cp a, $FF
    jr z, Jump_003_79E8
    push de
    ld a, e
    add a, $03
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    ld a, [de]
    pop de
    bit 7, a
    jr z, Jump_003_79E8
    ld [hl], c
    set 7, [hl]
    inc hl
    ld a, [$D0C7]
    inc a
    ld [$D0C7], a

Jump_003_79E8::
    inc c
    ld a, e
    add a, $04
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    dec b
    jr nz, Jump_003_79C6
    jr Jump_003_7A53

Jump_003_79F6::
    ld a, [de]
    or a, a
    jr z, Jump_003_7A18
    cp a, $FF
    jr z, Jump_003_7A18
    push de
    ld a, e
    add a, $03
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    ld a, [de]
    pop de
    bit 7, a
    jr z, Jump_003_7A18
    ld [hl], c
    set 7, [hl]
    inc hl
    ld a, [$D0C7]
    inc a
    ld [$D0C7], a

Jump_003_7A18::
    inc c
    ld a, e
    add a, $04
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    dec b
    jr nz, Jump_003_79F6
    ld de, $C707
    ld bc, $2000

Jump_003_7A2A::
    ld a, [de]
    cp a, $FF
    jr z, Jump_003_7A47
    push de
    ld a, e
    add a, $03
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    ld a, [de]
    pop de
    bit 7, a
    jr nz, Jump_003_7A47
    ld [hl], c
    inc hl
    ld a, [$D0C7]
    inc a
    ld [$D0C7], a

Jump_003_7A47::
    inc c
    ld a, e
    add a, $04
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    dec b
    jr nz, Jump_003_7A2A

Jump_003_7A53::
    ld a, [$D0C7]
    or a, a
    ret

Func_003_7A58::
    ld a, [$D0C7]
    or a, a
    jr z, Jump_003_7A80
    cp a, $05
    jr c, Jump_003_7A84
    cp a, $09
    jr c, Jump_003_7A88
    cp a, $0D
    jr c, Jump_003_7A8E
    cp a, $11
    jr c, Jump_003_7A94
    cp a, $15
    jr c, Jump_003_7A9A
    cp a, $19
    jr c, Jump_003_7AA0
    cp a, $1D
    jr c, Jump_003_7AA6
    ld b, $08
    sub a, $1C
    jr Jump_003_7AAC

Jump_003_7A80::
    ld b, $00
    jr Jump_003_7AAC

Jump_003_7A84::
    ld b, $01
    jr Jump_003_7AAC

Jump_003_7A88::
    ld b, $02
    sub a, $04
    jr Jump_003_7AAC

Jump_003_7A8E::
    ld b, $03
    sub a, $08
    jr Jump_003_7AAC

Jump_003_7A94::
    ld b, $04
    sub a, $0C
    jr Jump_003_7AAC

Jump_003_7A9A::
    ld b, $05
    sub a, $10
    jr Jump_003_7AAC

Jump_003_7AA0::
    ld b, $06
    sub a, $14
    jr Jump_003_7AAC

Jump_003_7AA6::
    ld b, $07
    sub a, $18
    jr Jump_003_7AAC

Jump_003_7AAC::
    ld [$C0A5], a
    ld a, b
    ld [$C0A3], a
    ld a, [$C0A6]
    inc a
    cp a, b
    jr nz, Jump_003_7ABF
    ld a, [$C0A5]
    jr Jump_003_7AC1

Jump_003_7ABF::
    ld a, $04

Jump_003_7AC1::
    ld [$C0A2], a
    ld a, [$C0A3]
    cp a, $02
    ret c
    add a, $E0
    ld [$C3C9], a
    ld a, [$C0A6]
    inc a
    add a, $E0
    ld [$C3C7], a
    ld a, $C5
    ld [$C3C6], a
    ld a, $BE
    ld [$C3C8], a
    ld a, $C6
    ld [$C3CA], a
    ret

Func_003_7AE8::
    ld hl, $8EE0
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $1003
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld a, $00
    ld [$C528], a
    ld a, $02
    ld [$C529], a
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

Func_003_7B25::
    ld a, $0A
    ld [$0100], a
    ld a, $00
    ld [$4100], a
    xor a, a
    ld [$D09D], a
    ld [$D09E], a
    ld de, $A000
    ld b, $1E

Jump_003_7B3B::
    ld a, [de]
    cp a, $01
    jr nz, Jump_003_7B51
    ld hl, $006E
    add hl, de
    ld a, [hl]
    or a, a
    jr z, Jump_003_7B4D
    ld hl, $D09E
    jr Jump_003_7B50

Jump_003_7B4D::
    ld hl, $D09D

Jump_003_7B50::
    inc [hl]

Jump_003_7B51::
    ld a, e
    add a, $A5
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    dec b
    jr nz, Jump_003_7B3B
    xor a, a
    ld [$0100], a
    ret

Func_003_7B61::
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
    ld hl, $91E0
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $6201
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    call Func_000_290E
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

Data_003_7B9F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $50, $90, $60, $90, $70, $90, $80, $90, $90, $90, $A0, $90, $B0, $90, $FF, $FF

Data_003_7BAF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $E0, $40, $70, $43, $B0, $42, $D0, $42, $10, $43, $C0, $42, $B0, $43, $FF, $FF

Func_003_7BBF::
    ld b, $00

Jump_003_7BC1::
    push bc
    push hl
    push de
    ld a, b
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_003_7BCB
    inc h

Jump_003_7BCB::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_003_7BF1
    ld e, a
    ld a, [hl]
    ld h, a
    ld l, e
    pop de
    push de
    push hl
    ld l, e
    ld h, d
    ld a, b
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_003_7BE0
    inc h

Jump_003_7BE0::
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    pop de
    pop hl
    pop bc
    inc b
    jr Jump_003_7BC1

Jump_003_7BF1::
    pop de
    pop hl
    pop bc
    ret

Data_003_7BF5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $11, $20, $FF, $7F, $7D, $3D
    ds $405, $00
