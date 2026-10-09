SECTION "Bank A3", ROMX[$4000], BANK[$A3]
    db $A3

Func_0A3_4001:: ; heuristic: follows a terminator; C0
    ld hl, $D8FF
    jr Jump_0A3_402E
    db $21, $0F, $D9, $18, $23, $21, $CF, $D8, $18, $1E, $21, $EF, $D8, $18, $19, $21
    db $BF, $D8, $18, $14, $21, $DF, $D8, $18, $0F, $21, $1F, $D9, $18, $0A, $21, $53
    db $DA, $85, $6F, $30, $01, $24, $7E, $C9

Jump_0A3_402E::
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A3_4034
    inc h

Jump_0A3_4034::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ret

Func_0A3_4038:: ; heuristic: follows a terminator; C0
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0A3_403E
    inc h

Jump_0A3_403E::
    ret

Func_0A3_403F:: ; heuristic: follows a terminator; C0
    ld a, [$C58A]
    cp a, $01
    jr nz, Jump_0A3_4054
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_0A3_4054
    ld a, [$D8A4]
    cp a, $04
    ccf
    ret

Jump_0A3_4054::
    ld a, [$D8A4]
    cp a, $04
    ret

Func_0A3_405A:: ; heuristic: follows a terminator; C0
    ld a, [$C58A]
    cp a, $01
    jr nz, Jump_0A3_406F
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_0A3_406F
    ld a, [$D8A5]
    cp a, $04
    ccf
    ret

Jump_0A3_406F::
    ld a, [$D8A5]
    cp a, $04
    ret
    INCBIN "dwm2-cobi-us.gbc", $28C075, $CA

Func_0A3_413F::
    call Func_0A3_414F
    ldh a, [$FFC6]
    ld hl, $DA5B
    add a, l
    ld l, a
    jr nc, Jump_0A3_414C
    inc h

Jump_0A3_414C::
    ld [hl], $03
    ret

Func_0A3_414F::
    push bc
    ld a, [$D8A4]
    and a, $03
    ld c, a
    ld a, [$D8A4]
    and a, $04
    ld b, a
    sra a
    sra a
    ld hl, $C953
    add a, l
    ld l, a
    jr nc, Jump_0A3_4168
    inc h

Jump_0A3_4168::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_0A3_417D
    sla a
    ld hl, Data_0A3_4181
    add a, l
    ld l, a
    jr nc, Jump_0A3_4177
    inc h

Jump_0A3_4177::
    ld a, [hl+]
    cp a, c
    jr nz, Jump_0A3_417C
    ld a, [hl]

Jump_0A3_417C::
    add a, b

Jump_0A3_417D::
    ldh [$FFC6], a
    pop bc
    ret

Data_0A3_4181:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $00, $02, $01, $02

Func_0A3_4187::
    ld b, $10
    ld hl, $DA1C
    ld de, $DA2C

Jump_0A3_418F::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_0A3_418F
    ld a, $FF
    ld [$C953], a
    ld [$C954], a
    ld a, [$C58A]
    cp a, $01
    ret z
    ld de, $DA1C
    call Func_0A3_41CF
    or a, a
    jr z, Jump_0A3_41B5
    ld de, $DA1C
    call Func_0A3_4917
    ld [$C953], a

Jump_0A3_41B5::
    ld a, [$C58A]
    or a, a
    ret z
    cp a, $02
    ret z
    ld de, $DA24
    call Func_0A3_41CF
    or a, a
    ret z
    ld de, $DA24
    call Func_0A3_4917
    ld [$C954], a
    ret

Func_0A3_41CF::
    ld a, [$D8A4]
    and a, $04
    ldh [$FFC6], a
    ld b, $00
    ld hl, Data_0A3_4289

Jump_0A3_41DB::
    push hl
    ld a, [hl]
    or a, a
    jr nz, Jump_0A3_41E4

Jump_0A3_41E0::
    pop hl
    ld a, $00
    ret

Jump_0A3_41E4::
    push de
    ld a, [hl]
    cp a, $FF
    jr z, Jump_0A3_41FD
    ld c, a
    ld a, [de]
    cp a, c
    jr nz, Jump_0A3_4257
    ldh a, [$FFC6]
    call Func_000_3E25
    jr c, Jump_0A3_4257
    ldh a, [$FFC6]
    call Func_0A3_4278
    jr nz, Jump_0A3_4257

Jump_0A3_41FD::
    inc de
    inc de
    inc hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_0A3_421A
    ld c, a
    ld a, [de]
    cp a, c
    jr nz, Jump_0A3_4257
    ldh a, [$FFC6]
    inc a
    call Func_000_3E25
    jr c, Jump_0A3_4257
    ldh a, [$FFC6]
    inc a
    call Func_0A3_4278
    jr nz, Jump_0A3_4257

Jump_0A3_421A::
    inc de
    inc de
    inc hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_0A3_4239
    ld c, a
    ld a, [de]
    cp a, c
    jr nz, Jump_0A3_4257
    ldh a, [$FFC6]
    inc a
    inc a
    call Func_000_3E25
    jr c, Jump_0A3_4257
    ldh a, [$FFC6]
    inc a
    inc a
    call Func_0A3_4278
    jr nz, Jump_0A3_4257

Jump_0A3_4239::
    pop de
    ld a, [$C58A]
    cp a, $02
    jr z, Jump_0A3_4264
    inc hl
    ld a, [hl]
    cp a, $01
    jr nz, Jump_0A3_41E0
    inc hl
    push bc
    push hl
    call Func_0A3_44C4
    pop hl
    pop bc
    or a, a
    jr z, Jump_0A3_41E0
    ld a, [hl]
    ldh [$FFC6], a
    jr Jump_0A3_4274

Jump_0A3_4257::
    pop de
    pop hl
    ld a, $05
    add a, l
    ld l, a
    jr nc, Jump_0A3_4260
    inc h

Jump_0A3_4260::
    inc b
    jp Jump_0A3_41DB

Jump_0A3_4264::
    inc hl
    inc hl
    push bc
    push hl
    call Func_0A3_44C4
    pop hl
    pop bc
    or a, a
    jp z, Jump_0A3_41E0
    ld a, [hl]
    ldh [$FFC6], a

Jump_0A3_4274::
    pop hl
    ld a, $01
    ret

Func_0A3_4278::
    push hl
    ld hl, $D80F
    call Func_000_3F25
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_0A3_4287
    ld a, [hl]
    and a, $0C

Jump_0A3_4287::
    pop hl
    ret

Data_0A3_4289:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $28C289, $23B

Func_0A3_44C4::
    push hl
    ld a, $03
    call Func_000_16BF
    or a, a
    jr z, Jump_0A3_4505
    dec a
    jr z, Jump_0A3_453A
    ld a, $01
    call Func_0A3_497E
    push af
    ld a, $02
    call Func_0A3_497E
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    pop af
    add a, l
    ld l, a
    jr nc, Jump_0A3_44E9
    inc h

Jump_0A3_44E9::
    ld a, l
    add a, $B7
    ld l, a
    ld a, h
    adc a, $45
    ld h, a
    ld a, [hl]
    inc a
    ldh [$FFC6], a
    ld a, [$D981]
    ld c, a
    ld b, $00
    ld a, [$D982]
    add a, c
    ld c, a
    jr nc, Jump_0A3_4503
    inc b

Jump_0A3_4503::
    jr Jump_0A3_456D

Jump_0A3_4505::
    ld a, $00
    call Func_0A3_497E
    push af
    ld a, $01
    call Func_0A3_497E
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    pop af
    add a, l
    ld l, a
    jr nc, Jump_0A3_451E
    inc h

Jump_0A3_451E::
    ld a, l
    add a, $B7
    ld l, a
    ld a, h
    adc a, $45
    ld h, a
    ld a, [hl]
    inc a
    ldh [$FFC6], a
    ld a, [$D980]
    ld c, a
    ld b, $00
    ld a, [$D981]
    add a, c
    ld c, a
    jr nc, Jump_0A3_4538
    inc b

Jump_0A3_4538::
    jr Jump_0A3_456D

Jump_0A3_453A::
    ld a, $00
    call Func_0A3_497E
    push af
    ld a, $02
    call Func_0A3_497E
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    pop af
    add a, l
    ld l, a
    jr nc, Jump_0A3_4553
    inc h

Jump_0A3_4553::
    ld a, l
    add a, $B7
    ld l, a
    ld a, h
    adc a, $45
    ld h, a
    ld a, [hl]
    inc a
    ldh [$FFC6], a
    ld a, [$D980]
    ld c, a
    ld b, $00
    ld a, [$D982]
    add a, c
    ld c, a
    jr nc, Jump_0A3_456D
    inc b

Jump_0A3_456D::
    ldh a, [$FFC6]
    call Func_000_16AA
    ld c, h
    ld b, e
    pop hl
    ld a, [hl]
    sub a, $D0
    ld hl, Data_0A3_45A3
    add a, l
    ld l, a
    jr nc, Jump_0A3_4580
    inc h

Jump_0A3_4580::
    ld a, [hl]
    call Func_000_16AA
    ld a, $0A
    call Func_000_16D1
    ld a, h
    or a, a
    jr z, Jump_0A3_458F
    ld l, $FF

Jump_0A3_458F::
    call Func_000_3ED4
    ld a, [$C5E7]
    and a, $7F
    cp a, $64
    jr nc, Jump_0A3_458F
    cp a, l
    jr c, Jump_0A3_45A0
    xor a, a
    ret

Jump_0A3_45A0::
    ld a, $01
    ret

Data_0A3_45A3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $28C5A3, $374

Func_0A3_4917::
    push bc
    push de
    ld a, $03
    call Func_000_16BF
    pop de
    pop bc
    or a, a
    jr z, Jump_0A3_4928
    dec a
    jr z, Jump_0A3_4938
    jr Jump_0A3_494E

Jump_0A3_4928::
    ldh a, [$FFC6]
    ld [de], a
    inc de
    inc de
    ld [de], a
    dec de
    ld a, $FF
    ld [de], a
    inc de
    inc de
    ld [de], a
    ld a, $00
    ret

Jump_0A3_4938::
    ldh a, [$FFC6]
    ld [de], a
    inc de
    inc de
    inc de
    inc de
    ld [de], a
    dec de
    dec de
    dec de
    ld a, $FF
    ld [de], a
    inc de
    inc de
    inc de
    inc de
    ld [de], a
    ld a, $01
    ret

Jump_0A3_494E::
    inc de
    inc de
    ldh a, [$FFC6]
    ld [de], a
    inc de
    inc de
    ld [de], a
    dec de
    ld a, $FF
    ld [de], a
    inc de
    inc de
    ld [de], a
    ld a, $02
    ret

Func_0A3_4960::
    ld a, [$D8A4]
    add a, a
    ld hl, $DA1C
    add a, l
    ld l, a
    jr nc, Jump_0A3_496C
    inc h

Jump_0A3_496C::
    ld a, [hl]
    cp a, $D0
    jr c, Jump_0A3_497A
    cp a, $E4
    jr nc, Jump_0A3_497A
    ld a, $01
    ldh [$FFC6], a
    ret

Jump_0A3_497A::
    xor a, a
    ldh [$FFC6], a
    ret

Func_0A3_497E::
    push hl
    push bc
    ld c, a
    ld b, $00
    ld hl, $D968
    add a, l
    ld l, a
    jr nc, Jump_0A3_498B
    inc h

Jump_0A3_498B::
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_0A3_499A
    ld l, $09
    cp a, $40
    jr nc, Jump_0A3_499A
    ld l, $12

Jump_0A3_499A::
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, $D970
    add a, l
    ld l, a
    jr nc, Jump_0A3_49A6
    inc h

Jump_0A3_49A6::
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_0A3_49B5
    ld l, $03
    cp a, $40
    jr nc, Jump_0A3_49B5
    ld l, $06

Jump_0A3_49B5::
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, $D978
    add a, l
    ld l, a
    jr nc, Jump_0A3_49C1
    inc h

Jump_0A3_49C1::
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_0A3_49D0
    ld l, $01
    cp a, $40
    jr nc, Jump_0A3_49D0
    ld l, $02

Jump_0A3_49D0::
    ld a, l
    add a, b
    pop bc
    pop hl
    ret

Func_0A3_49D5::
    ld a, [$C58A]
    or a, a
    jr z, Jump_0A3_49DF
    cp a, $02
    jr nz, Jump_0A3_49EB

Jump_0A3_49DF::
    ld a, [$D8A4]
    cp a, $04
    jr c, Jump_0A3_49EB
    ld de, Data_0A3_4CD7
    jr Jump_0A3_49EE

Jump_0A3_49EB::
    ld de, Data_0A3_4B57

Jump_0A3_49EE::
    ld a, [$D8A4]
    add a, a
    ld hl, $D958
    add a, l
    ld l, a
    jr nc, Jump_0A3_49FA
    inc h

Jump_0A3_49FA::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    add hl, de
    ld a, [hl]
    ldh [$FFC6], a
    ret

Func_0A3_4A02::
    ld a, [$D8A5]
    add a, a
    ld hl, $DA1C
    add a, l
    ld l, a
    jr nc, Jump_0A3_4A0E
    inc h

Jump_0A3_4A0E::
    ld a, [hl]
    cp a, $00
    ret z
    cp a, $AC
    ret z
    cp a, $CC
    ret z
    cp a, $CD
    ret z
    cp a, $CE
    ret z
    cp a, $CF
    ret z
    cp a, $D0
    jr nc, Jump_0A3_4A2B
    ld [hl], $00
    inc hl
    ld [hl], $FF
    ret

Jump_0A3_4A2B::
    ld a, [$D8A5]
    ld hl, $DA5B
    add a, l
    ld l, a
    jr nc, Jump_0A3_4A36
    inc h

Jump_0A3_4A36::
    ld [hl], $03
    ret

Func_0A3_4A39:: ; heuristic: follows a terminator; C0
    push de
    ld hl, $D895
    ld b, $08
    ld d, $00

Jump_0A3_4A41::
    bit 0, d
    jr nz, Jump_0A3_4A4B
    ld a, [hl]
    cp a, c
    jr nz, Jump_0A3_4A59
    ld d, $01

Jump_0A3_4A4B::
    inc hl
    ld a, [hl]
    ld [hl], $FF
    dec hl
    ld [hl], a
    inc hl
    dec b
    jr nz, Jump_0A3_4A41
    ld [hl], $FF
    pop de
    ret

Jump_0A3_4A59::
    inc hl
    dec b
    jr nz, Jump_0A3_4A41
    pop de
    ret

Func_0A3_4A5F::
    call Func_000_3ED4
    ld a, $FF
    ld hl, $D86D
    ld bc, $0003
    call Func_000_0949
    ld a, [$D8A5]
    ld d, a
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld e, $00

Jump_0A3_4A7A::
    ld a, c
    call Func_000_3E54
    jr c, Jump_0A3_4A8E
    cp a, d
    jr z, Jump_0A3_4A7A
    ld a, e
    ld hl, $D86D
    add a, l
    ld l, a
    jr nc, Jump_0A3_4A8C
    inc h

Jump_0A3_4A8C::
    ld [hl], c
    inc e

Jump_0A3_4A8E::
    inc c
    dec b
    jr nz, Jump_0A3_4A7A
    ld a, e
    or a, a
    jr nz, Jump_0A3_4A99
    ld c, $FF
    ret

Jump_0A3_4A99::
    ld hl, $0000
    ld b, $00
    dec e
    ld c, e
    call Func_000_3E98
    ld a, e
    ld hl, $D86D
    add a, l
    ld l, a
    jr nc, Jump_0A3_4AAC
    inc h

Jump_0A3_4AAC::
    ld a, [hl]
    ld c, a
    ret

Func_0A3_4AAF:: ; heuristic: follows a terminator; C0
    call Func_000_3ED4
    ld a, [$C5E7]
    ld b, a
    ld a, $0E
    call Func_000_16BF
    ld hl, Data_0A3_4AFD
    add a, l
    ld l, a
    jr nc, Jump_0A3_4AC3
    inc h

Jump_0A3_4AC3::
    ld a, [hl]
    ld c, a
    ld a, [$C58A]
    or a, a
    jr nz, Jump_0A3_4AF3
    ld a, [$CFC5]
    cp a, $02
    jr z, Jump_0A3_4AE2
    cp a, $03
    jr z, Jump_0A3_4AE2
    cp a, $05
    jr z, Jump_0A3_4AE2
    ld a, [$D8A4]
    bit 2, a
    ret z
    jr Jump_0A3_4AF3

Jump_0A3_4AE2::
    ld a, c
    cp a, $B3
    jr z, Func_0A3_4AAF
    cp a, $B4
    jr z, Func_0A3_4AAF
    cp a, $B6
    jr z, Func_0A3_4AAF
    cp a, $BD
    jr z, Func_0A3_4AAF

Jump_0A3_4AF3::
    ld a, c
    cp a, $B0
    jr z, Func_0A3_4AAF
    cp a, $B2
    jr z, Func_0A3_4AAF
    ret

Data_0A3_4AFD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B2, $B3, $B4, $B5, $B6, $B7, $B8, $B9, $BA, $BB, $BC, $BD

Func_0A3_4B0B::
    ld a, $0A
    ld [$0100], a
    ld a, [$C6FD]
    ld b, a
    ld hl, $C6FE
    ld de, $C972

Jump_0A3_4B1A::
    inc de
    ld a, [de]
    cp a, $FF
    jr z, Jump_0A3_4B4C
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
    jr nz, Jump_0A3_4B1A

Jump_0A3_4B4C::
    ld hl, Func_0F2_65E6
    ld b, $F2
    rst $10
    xor a, a
    ld [$0100], a
    ret

Data_0A3_4B57:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $28CB57, $180

Data_0A3_4CD7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $01, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $01
    db $01, $00, $00, $01
    ds $11, $00
    INCBIN "dwm2-cobi-us.gbc", $28CCFC, $83
    ds $11, $00
    INCBIN "dwm2-cobi-us.gbc", $28CD90, $A2
    ds $17, $00
    db $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $03
    ds $31AA, $00
