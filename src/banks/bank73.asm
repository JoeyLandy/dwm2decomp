SECTION "Bank 73", ROMX[$4000], BANK[$73]
    db $73

Func_073_4001::
    ld a, [$C935]
    and a, $0F
    rst $00
    dw Jump_073_4E03
    dw Jump_073_4D8D
    dw Jump_073_4D20
    dw Jump_073_4CA0
    dw Jump_073_4BC3
    dw Jump_073_4B68
    dw Jump_073_4647
    dw Jump_073_4A82
    dw Jump_073_45D0
    dw Jump_073_4840
    dw Jump_073_411F
    dw Jump_073_4098
    dw Jump_073_4027
    dw Jump_073_4027
    dw Jump_073_4027
    dw Jump_073_4027

Jump_073_4027::
    ld a, [$C923]
    rst $00
    dw Jump_073_403F
    dw Func_073_4E5D
    dw Jump_073_5194
    dw Jump_073_4053
    dw Func_073_4E5D
    dw Func_073_4E9C
    dw Func_073_4E5D
    dw Jump_073_4111
    dw Func_073_4E5D
    dw Func_073_4E9C

Jump_073_403F::
    ld a, [$C935]
    and a, $0F
    sub a, $0C
    add a, $3A
    ld l, a
    ld h, $00
    call Func_073_4ED8
    ld hl, $C923
    inc [hl]
    ret

Jump_073_4053::
    ld a, [$D092]
    or a, a
    jr nz, Jump_073_407B
    ld hl, $003E
    call Func_073_4ED8
    ld a, [$C935]
    and a, $0F
    sub a, $0C
    add a, a
    ld hl, $4090
    add a, l
    ld l, a
    jr nc, Jump_073_406F
    inc h

Jump_073_406F::
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    call Func_000_1845
    ld hl, $C923
    inc [hl]
    ret

Jump_073_407B::
    ld a, [$C935]
    and a, $0F
    sub a, $0C
    add a, $3F
    ld l, a
    ld h, $00
    call Func_073_4ED8
    ld a, $06
    ld [$C923], a
    ret
    db $93, $01, $96, $01, $99, $01, $9C, $01

Jump_073_4098::
    ld a, [$C923]
    rst $00
    dw Jump_073_40BA
    dw Func_073_4E5D
    dw Jump_073_40C5
    dw Func_073_4E5D
    dw Jump_073_5194
    dw Jump_073_40E2
    dw Func_073_4E5D
    dw Jump_073_4E41
    dw Func_073_4E48
    dw Func_073_4E67
    dw Func_073_4E9C
    dw Func_073_4E5D
    dw Jump_073_4111
    dw Func_073_4E5D
    dw Func_073_4E9C

Jump_073_40BA::
    ld hl, $4037
    call Func_073_4ED8
    ld hl, $C923
    inc [hl]
    ret

Jump_073_40C5::
    ld a, [$C552]
    or a, a
    jr nz, Jump_073_40D6
    ld hl, $8049
    call Func_073_4ED8
    ld hl, $C923
    inc [hl]
    ret

Jump_073_40D6::
    ld hl, $8048
    call Func_073_4ED8
    ld a, $0D
    ld [$C923], a
    ret

Jump_073_40E2::
    ld a, [$D092]
    or a, a
    jr nz, Jump_073_4105
    ld hl, $0038
    call Func_073_4ED8
    ld a, [$C525]
    or a, a
    jr z, Jump_073_4100
    ld hl, $C49F
    ld de, $C0F0
    ld bc, $0040
    call Func_000_0952

Jump_073_4100::
    ld hl, $C923
    inc [hl]
    ret

Jump_073_4105::
    ld hl, $0039
    call Func_073_4ED8
    ld a, $0B
    ld [$C923], a
    ret

Jump_073_4111::
    ld hl, $000F
    call Func_073_4ED8
    call Func_073_4C5D
    ld hl, $C923
    inc [hl]
    ret

Jump_073_411F::
    ld a, [$C923]
    rst $00
    dw Jump_073_43B3
    dw Func_073_4E5D
    dw Jump_073_4387
    dw Func_073_4E5D
    dw Func_073_42F1
    dw Func_073_42D8
    dw Func_073_42C2
    dw Func_073_4269
    dw Func_073_4139
    db $5D, $4E, $9C, $4E

Func_073_4139:: ; heuristic: target of a pointer table; C0
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $3C
    ret nz
    ld hl, $5F22
    ld b, $02
    rst $10
    ld hl, $6DDB
    ld b, $5F
    rst $10
    ld b, $46
    ld de, $4001
    ld hl, $8800
    call Func_000_0CF5
    call Func_000_222B
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ld a, [$C46B]
    and a, $F0
    swap a
    ld de, $453A
    add a, e
    ld e, a
    jr nc, Jump_073_4174
    inc d

Jump_073_4174::
    ld a, [de]
    ld c, a
    ld a, [$C46C]
    and a, $F0
    swap a
    ld de, $4544
    add a, e
    ld e, a
    jr nc, Jump_073_4185
    inc d

Jump_073_4185::
    ld a, [de]
    cp a, c
    jp nz, Jump_073_4220
    ld a, [$C46D]
    and a, $F0
    swap a
    ld de, $454E
    add a, e
    ld e, a
    jr nc, Jump_073_4199
    inc d

Jump_073_4199::
    ld a, [de]
    cp a, c
    jp nz, Jump_073_4227
    ld a, [$C46B]
    and a, $F0
    swap a
    ld de, $453A
    add a, e
    ld e, a
    jr nc, Jump_073_41AD
    inc d

Jump_073_41AD::
    ld a, [de]
    or a, a
    jr nz, Jump_073_41C3
    ld hl, $0032
    call Func_073_4ED8
    ld a, $1E
    ld [$C928], a
    ld hl, $6C8C
    ld b, $5F
    rst $10
    ret

Jump_073_41C3::
    dec a
    jr nz, Jump_073_41D8
    ld hl, $0030
    call Func_073_4ED8
    ld a, $2C
    ld [$C928], a
    ld hl, $6C8C
    ld b, $5F
    rst $10
    ret

Jump_073_41D8::
    dec a
    jr nz, Jump_073_41F1
    ld hl, $0031
    call Func_073_4ED8
    ld hl, $03E8
    ld a, l
    ldh [$FFC6], a
    ld a, h
    ldh [$FFC7], a
    ld hl, $7EC2
    ld b, $12
    rst $10
    ret

Jump_073_41F1::
    dec a
    jr nz, Jump_073_420A
    ld hl, $0044
    call Func_073_4ED8
    ld hl, $01F4
    ld a, l
    ldh [$FFC6], a
    ld a, h
    ldh [$FFC7], a
    ld hl, $7EC2
    ld b, $12
    rst $10
    ret

Jump_073_420A::
    ld hl, $0045
    call Func_073_4ED8
    ld hl, $00C8
    ld a, l
    ldh [$FFC6], a
    ld a, h
    ldh [$FFC7], a
    ld hl, $7EC2
    ld b, $12
    rst $10
    ret

Jump_073_4220::
    ld hl, $0035
    call Func_073_4ED8
    ret

Jump_073_4227::
    ld a, [$C46B]
    and a, $F0
    swap a
    ld de, $453A
    add a, e
    ld e, a
    jr nc, Jump_073_4236
    inc d

Jump_073_4236::
    ld a, [de]
    or a, a
    jr nz, Jump_073_4250
    ld hl, $0046
    call Func_073_4ED8
    ld hl, $0064
    ld a, l
    ldh [$FFC6], a
    ld a, h
    ldh [$FFC7], a
    ld hl, $7EC2
    ld b, $12
    rst $10
    ret

Jump_073_4250::
    dec a
    jr nz, Jump_073_4220
    ld hl, $0047
    call Func_073_4ED8
    ld hl, $0032
    ld a, l
    ldh [$FFC6], a
    ld a, h
    ldh [$FFC7], a
    ld hl, $7EC2
    ld b, $12
    rst $10
    ret

Func_073_4269:: ; heuristic: target of a pointer table; C0
    call Func_073_43BE
    ld a, [$C5F0]
    and a, $01
    jr z, Jump_073_42A7
    ld a, [$C46E]
    dec a
    jr nz, Jump_073_4288
    ld hl, $C46B
    call Func_073_42AB
    or a, a
    jr z, Jump_073_42A7
    ld hl, $C923
    dec [hl]
    jr Jump_073_42A7

Jump_073_4288::
    dec a
    jr nz, Jump_073_429A
    ld hl, $C46C
    call Func_073_42AB
    or a, a
    jr z, Jump_073_42A7
    ld hl, $C923
    dec [hl]
    jr Jump_073_42A7

Jump_073_429A::
    ld hl, $C46D
    call Func_073_42AB
    or a, a
    jr z, Jump_073_42A7
    ld hl, $C923
    inc [hl]

Jump_073_42A7::
    call Func_073_441D
    ret

Func_073_42AB::
    ld a, [hl]
    and a, $0F
    jr z, Jump_073_42BF
    ld a, [hl]
    inc a
    ld [hl], a
    and a, $F0
    swap a
    cp a, $0A
    jr nz, Jump_073_42BD
    xor a, a
    ld [hl], a

Jump_073_42BD::
    xor a, a
    ret

Jump_073_42BF::
    ld a, $01
    ret

Func_073_42C2:: ; heuristic: target of a pointer table; C0
    ld a, [$C562]
    bit 0, a
    jr z, Jump_073_42D1
    ld hl, $C46E
    inc [hl]
    ld hl, $C923
    inc [hl]

Jump_073_42D1::
    call Func_073_43BE
    call Func_073_441D
    ret

Func_073_42D8:: ; heuristic: target of a pointer table; C0
    call Func_073_43BE
    call Func_073_441D
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $1E
    ret nz
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Func_073_42F1:: ; heuristic: target of a pointer table; C0
    ld hl, $5EEE
    ld b, $02
    rst $10
    call Func_000_09F3
    ld a, [$CD04]
    and a, $07
    swap a
    ld [$C46B], a
    call Func_000_09F3
    ld a, [$CD04]
    and a, $07
    swap a
    ld [$C46C], a
    call Func_000_09F3
    ld a, [$CD04]
    and a, $07
    swap a
    ld [$C46D], a
    xor a, a
    ld [$C46E], a
    call Func_073_441D
    ld de, $4378
    ld hl, $C198
    ld b, $03

Jump_073_432D::
    push hl
    ld a, [de]
    inc de
    ld [hl+], a
    ld a, [de]
    inc de
    ld [hl+], a
    ld a, [de]
    inc de
    ld [hl+], a
    ld a, [de]
    inc de
    ld [hl+], a
    ld a, [de]
    inc de
    ld [hl+], a
    pop hl
    ld a, [$C525]
    or a, a
    jr z, Jump_073_4363
    push hl
    ld a, l
    sub a, $98
    ld l, a
    ld a, h
    sbc a, $C1
    ld h, a
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $D0
    ld h, a
    ld a, $02
    ldh [$FF70], a
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    xor a, a
    ldh [$FF70], a
    pop hl

Jump_073_4363::
    ld a, $14
    add a, l
    ld l, a
    jr nc, Jump_073_436A
    inc h

Jump_073_436A::
    dec b
    jr nz, Jump_073_432D
    ld hl, $6DDB
    ld b, $5F
    rst $10
    ld hl, $C923
    inc [hl]
    ret
    db $B0, $B1, $B1, $B1, $B2, $B6, $A4, $A5, $A6, $B7, $B3, $B4, $B4, $B4, $B5

Jump_073_4387::
    ld a, [$C552]
    or a, a
    jr nz, Jump_073_43A7
    ld hl, $002F
    call Func_073_4ED8
    ld hl, $0064
    ld a, l
    ldh [$FFC6], a
    ld a, h
    ldh [$FFC7], a
    ld hl, $7E84
    ld b, $12
    rst $10
    ld hl, $C923
    inc [hl]
    ret

Jump_073_43A7::
    ld hl, $0036
    call Func_073_4ED8
    ld a, $09
    ld [$C923], a
    ret

Jump_073_43B3::
    ld hl, $C923
    inc [hl]
    ld hl, $002E
    call Func_073_4ED8
    ret

Func_073_43BE::
    ld a, [$C5F0]
    and a, $01
    ret z
    ld a, [$C46E]
    cp a, $03
    ret z
    or a, a
    jr nz, Jump_073_43E5
    ld a, [$C46B]
    add a, $02
    ld [$C46B], a
    and a, $F0
    swap a
    cp a, $0A
    jr nz, Jump_073_43E5
    ld a, [$C46B]
    and a, $0F
    ld [$C46B], a

Jump_073_43E5::
    ld a, [$C46E]
    cp a, $02
    jr z, Jump_073_4404
    ld a, [$C46C]
    add a, $01
    ld [$C46C], a
    and a, $F0
    swap a
    cp a, $0A
    jr nz, Jump_073_4404
    ld a, [$C46C]
    and a, $0F
    ld [$C46C], a

Jump_073_4404::
    ld a, [$C46D]
    add a, $04
    ld [$C46D], a
    and a, $F0
    swap a
    cp a, $0A
    jr nz, Jump_073_441C
    ld a, [$C46D]
    and a, $0F
    ld [$C46D], a

Jump_073_441C::
    ret

Func_073_441D::
    ld hl, $8A40
    ld a, [$C46B]
    and a, $F0
    swap a
    push af
    ld de, $453A
    add a, e
    ld e, a
    jr nc, Jump_073_4430
    inc d

Jump_073_4430::
    ld a, [de]
    ldh [$FFC6], a
    pop af
    inc a
    cp a, $0A
    jr nz, Jump_073_443B
    ld a, $00

Jump_073_443B::
    ld de, $453A
    add a, e
    ld e, a
    jr nc, Jump_073_4443
    inc d

Jump_073_4443::
    ld a, [de]
    ldh [$FFC7], a
    ld a, [$C46B]
    call Func_073_44A5
    ld a, [$C46C]
    and a, $F0
    swap a
    push af
    ld de, $4544
    add a, e
    ld e, a
    jr nc, Jump_073_445C
    inc d

Jump_073_445C::
    ld a, [de]
    ldh [$FFC6], a
    pop af
    inc a
    cp a, $0A
    jr nz, Jump_073_4467
    ld a, $00

Jump_073_4467::
    ld de, $4544
    add a, e
    ld e, a
    jr nc, Jump_073_446F
    inc d

Jump_073_446F::
    ld a, [de]
    ldh [$FFC7], a
    ld a, [$C46C]
    call Func_073_44A5
    ld a, [$C46D]
    and a, $F0
    swap a
    push af
    ld de, $454E
    add a, e
    ld e, a
    jr nc, Jump_073_4488
    inc d

Jump_073_4488::
    ld a, [de]
    ldh [$FFC6], a
    pop af
    inc a
    cp a, $0A
    jr nz, Jump_073_4493
    ld a, $00

Jump_073_4493::
    ld de, $454E
    add a, e
    ld e, a
    jr nc, Jump_073_449B
    inc d

Jump_073_449B::
    ld a, [de]
    ldh [$FFC7], a
    ld a, [$C46D]
    call Func_073_44A5
    ret

Func_073_44A5::
    and a, $0E
    ldh [$FFC8], a
    or a, a
    jr z, Jump_073_44CE
    ldh a, [$FFC7]
    swap a
    ld de, $44EA
    add a, e
    ld e, a
    jr nc, Jump_073_44B8
    inc d

Jump_073_44B8::
    ldh a, [$FFC8]
    ld c, a
    ld a, $10
    sub a, c
    add a, e
    ld e, a
    jr nc, Jump_073_44C3
    inc d

Jump_073_44C3::
    ldh a, [$FFC8]
    ld b, a

Jump_073_44C6::
    ld a, [de]
    inc de
    call Func_000_121F
    dec b
    jr nz, Jump_073_44C6

Jump_073_44CE::
    ldh a, [$FFC8]
    ld c, a
    ld a, $10
    sub a, c
    ld b, a
    ldh a, [$FFC6]
    swap a
    ld de, $44EA
    add a, e
    ld e, a
    jr nc, Jump_073_44E1
    inc d

Jump_073_44E1::
    ld a, [de]
    inc de
    call Func_000_121F
    dec b
    jr nz, Jump_073_44E1
    ret
    INCBIN "dwm2-cobi-us.gbc", $1CC4EA, $E6

Jump_073_45D0::
    ld a, [$C923]
    rst $00
    dw Jump_073_45E4
    dw Func_073_4E5D
    dw Func_073_45EF
    dw Func_073_4E20
    dw Func_073_4635
    dw Func_073_463C
    db $5D, $4E, $9C, $4E

Jump_073_45E4::
    ld hl, $C923
    inc [hl]
    ld hl, $4021
    call Func_073_4ED8
    ret

Func_073_45EF:: ; heuristic: target of a pointer table; C0
    ld a, [$C552]
    or a, a
    jr nz, Jump_073_4629
    ld hl, $8023
    call Func_073_4ED8
    ld a, $FF
    db $EA, $93

Func_073_45FF:: ; heuristic: target of a pointer table; C0
    adc a, $EA
    sub a, h
    adc a, $EA
    sub a, l
    adc a, $EA
    sub a, [hl]
    adc a, $EA
    sub a, a
    adc a, $EA
    sbc a, b
    adc a, $EA
    sbc a, c
    adc a, $EA
    sbc a, d
    adc a, $21
    ret z
    nop
    ld a, l
    ldh [$FFC6], a
    ld a, h
    ldh [$FFC7], a
    ld hl, $7E84
    ld b, $12
    rst $10
    ld hl, $C923
    inc [hl]
    ret

Jump_073_4629::
    ld hl, $8022
    call Func_073_4ED8
    ld a, $06
    ld [$C923], a
    ret

Func_073_4635:: ; heuristic: target of a pointer table; C0
    ld hl, $653F
    ld b, $12
    rst $10
    ret

Func_073_463C:: ; heuristic: target of a pointer table; C0
    ld hl, $0052
    call Func_073_4ED8
    ld hl, $C923
    inc [hl]
    ret

Jump_073_4647::
    ld a, [$C923]
    rst $00
    dw Jump_073_47FD
    dw Func_073_4E5D
    dw Jump_073_47DB
    dw Func_073_4E5D
    dw Jump_073_46B3
    dw Func_073_4E5D
    dw Func_073_4E9C
    INCBIN "dwm2-cobi-us.gbc", $1CC659, $5A

Jump_073_46B3::
    call Func_000_09F3
    ld a, [$CD03]
    and a, $0F
    cp a, $0D
    jr nc, Jump_073_46B3
    ld [$C46C], a
    inc a
    ld [$C8C0], a
    xor a, a
    ld [$C8C1], a
    xor a, a
    ld [$C8C2], a
    call Func_000_173A
    ld de, $C17E
    call Func_000_23CA
    ld a, [$C46B]
    ld c, a
    ld a, [$C46C]
    cp a, c
    jr nz, Jump_073_46EA
    ld hl, $8018
    call Func_073_4ED8
    jp Jump_073_4797

Jump_073_46EA::
    ld a, [$C552]
    or a, a
    jr nz, Jump_073_46FD
    ld a, [$C46B]
    ld c, a
    ld a, [$C46C]
    cp a, c
    jp c, Jump_073_4791
    jr Jump_073_470A

Jump_073_46FD::
    ld a, [$C46B]
    ld c, a
    ld a, [$C46C]
    cp a, c
    db $D2

Func_073_4706:: ; heuristic: target of a pointer table; C0
    sub a, c
    ld b, a
    jr Jump_073_470A

Jump_073_470A::
    ld a, [$C922]
    inc a
    ld [$C922], a
    ld a, [$C921]
    ld [$C46D], a
    ld a, [$C922]
    cp a, $05
    jr nz, Jump_073_473F
    ld hl, $801C
    call Func_073_4ED8
    ld a, [$C46D]
    ld de, $C152
    call Func_000_2431
    ld a, [$C46D]
    ld [$C928], a
    ld hl, $6C8C
    ld b, $5F
    rst $10
    ld a, $0E
    ld [$C923], a
    ret

Jump_073_473F::
    call Func_000_09F3
    ld a, [$CD03]
    and a, $03
    ld hl, $4822
    add a, l
    ld l, a
    jr nc, Jump_073_474F
    inc h

Jump_073_474F::
    ld a, [$C922]
    add a, a
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_073_4759
    inc h

Jump_073_4759::
    ld a, [hl]
    ld [$C921], a
    ld de, $C152
    call Func_000_2431
    ld a, [$C922]
    sla a
    ld hl, $4836
    add a, l
    ld l, a
    jr nc, Jump_073_4770
    inc h

Jump_073_4770::
    ld a, [hl+]
    ld [$C8C0], a
    ld a, [hl]
    ld [$C8C1], a
    xor a, a
    ld [$C8C2], a
    call Func_000_173A
    ld de, $C181
    call Func_000_23CA
    ld hl, $C016
    call Func_073_4ED8
    ld a, $08
    ld [$C923], a
    ret

Jump_073_4791::
    ld hl, $8017
    call Func_073_4ED8

Jump_073_4797::
    ld a, [$C922]
    add a, a
    ld hl, $4836
    add a, l
    ld l, a
    jr nc, Jump_073_47A3
    inc h

Jump_073_47A3::
    ld a, [hl+]
    ld [$C8C0], a
    ld a, [hl]
    ld [$C8C1], a
    xor a, a
    ld [$C8C2], a
    ld a, [$C8C0]
    ld c, a
    ld a, [$C617]
    sub a, c
    ld [$C617], a
    ld a, [$C8C1]
    ld c, a
    ld a, [$C618]
    sbc a, c
    ld [$C618], a
    ld a, [$C619]
    sbc a, $00
    ld [$C619], a
    call Func_000_173A
    ld de, $C181
    call Func_000_23CA
    ld hl, $C923
    inc [hl]
    ret

Jump_073_47DB::
    ld hl, $C923
    inc [hl]
    ld a, [$C552]
    or a, a
    jr nz, Jump_073_47F1
    ld a, $06
    ld [$C46B], a
    ld hl, $C014
    call Func_073_4ED8
    ret

Jump_073_47F1::
    ld hl, $8015
    call Func_073_4ED8
    ld a, $10
    ld [$C923], a
    ret

Jump_073_47FD::
    call Func_000_09F3
    ld a, [$CD03]
    and a, $03
    ld hl, $4822
    add a, l
    ld l, a
    jr nc, Jump_073_480D
    inc h

Jump_073_480D::
    ld a, [hl]
    ld [$C921], a
    ld de, $C152
    call Func_000_2431
    ld hl, $4013
    call Func_073_4ED8
    ld hl, $C923
    inc [hl]
    ret
    db $03, $22, $28, $2A, $0B, $25, $05, $2B, $0C, $23, $27, $2C, $11, $12, $26, $1E
    db $0D, $0E, $0F, $10, $64, $00, $2C, $01, $58, $02, $E8, $03, $DC, $05

Jump_073_4840::
    ld a, [$C923]
    rst $00
    dw Jump_073_4860
    dw Func_073_4E5D
    dw Jump_073_486B
    dw Func_073_4E5D
    dw Jump_073_5194
    dw Jump_073_4888
    dw Func_073_4E5D
    dw Jump_073_48A0
    dw Func_073_4E5D
    dw Jump_073_48F8
    dw Func_073_4E5D
    dw Jump_073_493C
    dw Func_073_4E5D
    dw Func_073_4E9C

Jump_073_4860::
    ld hl, $C923
    inc [hl]
    ld hl, $4024
    call Func_073_4ED8
    ret

Jump_073_486B::
    ld a, [$C552]
    or a, a
    jr nz, Jump_073_487C
    ld hl, $8051
    call Func_073_4ED8
    ld hl, $C923
    inc [hl]
    ret

Jump_073_487C::
    ld hl, $8050
    call Func_073_4ED8
    ld a, $0C
    ld [$C923], a
    ret

Jump_073_4888::
    ld hl, $C923
    inc [hl]
    ld a, [$D092]
    or a, a
    jr nz, Jump_073_4899
    ld hl, $0025
    call Func_073_4ED8
    ret

Jump_073_4899::
    ld hl, $0053
    call Func_073_4ED8
    ret

Jump_073_48A0::
    ld hl, $C923
    inc [hl]
    ld a, [$D092]
    or a, a
    jr nz, Jump_073_48E9
    ld a, $00
    call Func_073_4956
    ld a, $00
    call Func_073_49E6
    ld a, $00
    call Func_073_4A0F
    ld a, [$C6FD]
    dec a
    jr nz, Jump_073_48CB

Jump_073_48BF::
    ld hl, $0026
    call Func_073_4ED8
    ld a, $0C
    ld [$C923], a
    ret

Jump_073_48CB::
    ld a, $0A
    ld [$0100], a
    ld a, [$C6FF]
    ld c, $55
    call Func_000_1F80
    xor a, a
    ld [$0100], a
    ldh a, [$FFC6]
    bit 7, a
    jr nz, Jump_073_48BF
    ld hl, $4026
    call Func_073_4ED8
    ret

Jump_073_48E9::
    ld hl, $000F
    call Func_073_4ED8
    call Func_073_4C5D
    ld a, $0C
    ld [$C923], a
    ret

Jump_073_48F8::
    ld hl, $C923
    inc [hl]
    ld a, $01
    call Func_073_4956
    ld a, $01
    call Func_073_49E6
    ld a, $01
    call Func_073_4A0F
    ld a, [$C6FD]
    dec a
    dec a
    jr nz, Jump_073_491E

Jump_073_4912::
    ld hl, $8026
    call Func_073_4ED8
    ld a, $0C
    ld [$C923], a
    ret

Jump_073_491E::
    ld a, $0A
    ld [$0100], a
    ld a, [$C700]
    ld c, $55
    call Func_000_1F80
    xor a, a
    ld [$0100], a
    ldh a, [$FFC6]
    bit 7, a
    jr nz, Jump_073_4912
    ld hl, $C026
    call Func_073_4ED8
    ret

Jump_073_493C::
    ld hl, $C923
    inc [hl]
    ld hl, $8026
    call Func_073_4ED8
    ld a, $02
    call Func_073_4956
    ld a, $02
    call Func_073_49E6
    ld a, $02
    call Func_073_4A0F
    ret

Func_073_4956::
    ld hl, $C6FE
    add a, l
    ld l, a
    jr nc, Jump_073_495E
    inc h

Jump_073_495E::
    ld a, $0A
    ld [$0100], a
    xor a, a
    ldh [$FFC8], a
    ld a, [hl]
    ld c, $5D
    call Func_000_1F89
    ldh a, [$FFC6]
    ld e, a
    ldh a, [$FFC7]
    ld d, a
    ld b, $01
    ld a, [hl]
    ld c, $61
    call Func_000_1F89
    call Func_073_49B1
    ld b, $02
    ld a, [hl]
    ld c, $63
    call Func_000_1F89
    call Func_073_49B1
    ld b, $03
    ld a, [hl]
    ld c, $65
    call Func_000_1F89
    call Func_073_49B1
    ld b, $04
    ld a, [hl]
    ld c, $67
    call Func_000_1F89
    call Func_073_49B1
    ld b, $05
    ld a, [hl]
    ld c, $69
    call Func_000_1F89
    call Func_073_49B1
    xor a, a
    ld [$0100], a
    call Func_073_49C5
    ret

Func_073_49B1::
    ldh a, [$FFC7]
    cp a, d
    jr c, Jump_073_49BB
    ret nz
    ldh a, [$FFC6]
    cp a, e
    ret nc

Jump_073_49BB::
    ld a, b
    ldh [$FFC8], a
    ldh a, [$FFC6]
    ld e, a
    ldh a, [$FFC7]
    ld d, a
    ret

Func_073_49C5::
    ldh a, [$FFC8]
    ld [$C921], a
    add a, $28
    ld [$C529], a
    ld a, $05
    ld [$C528], a
    ld hl, $C152
    ld a, l
    ld [$C53D], a
    ld a, h
    ld [$C53E], a
    ld hl, $4008
    ld b, $09
    rst $10
    ret

Func_073_49E6::
    ld hl, $C6FE
    add a, l
    ld l, a
    jr nc, Jump_073_49EE
    inc h

Jump_073_49EE::
    ld a, $0A
    ld [$0100], a
    ld a, [hl]
    ld c, $01
    call Func_000_1FA4
    xor a, a
    ld [$0100], a
    ld hl, $C8CF
    ld de, $C147
    ld b, $0A

Jump_073_4A05::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_073_4A05
    ld a, $F0
    ld [de], a
    ret

Func_073_4A0F::
    ld hl, $C6FE
    add a, l
    ld l, a
    jr nc, Jump_073_4A17
    inc h

Jump_073_4A17::
    ld a, $0A
    ld [$0100], a
    ld a, [$C921]
    ld de, $4A7C
    add a, e
    ld e, a
    jr nc, Jump_073_4A27
    inc d

Jump_073_4A27::
    ld a, [de]
    ld c, a
    ld a, [hl]
    call Func_000_1F89
    ldh a, [$FFC6]
    add a, $14
    ldh [$FFC8], a
    ldh a, [$FFC7]
    adc a, $00
    ldh [$FFC9], a
    ldh a, [$FFC9]
    cp a, $03
    jr nz, Jump_073_4A4E
    ldh a, [$FFC8]
    cp a, $E8
    jr c, Jump_073_4A4E
    ld de, $03E7
    ld a, e
    ldh [$FFC8], a
    ld a, d
    ldh [$FFC9], a

Jump_073_4A4E::
    ld a, [hl]
    call Func_000_1FD1
    ldh a, [$FFC8]
    ld [hl+], a
    ldh a, [$FFC9]
    ld [hl], a
    xor a, a
    ld [$0100], a
    ldh a, [$FFC6]
    ld c, a
    ldh a, [$FFC8]
    sub a, c
    ld [$C8C0], a
    ldh a, [$FFC7]
    ld c, a
    ldh a, [$FFC9]
    sbc a, c
    ld [$C8C1], a
    xor a, a
    ld [$C8C2], a
    call Func_000_173A
    ld de, $C17E
    call Func_000_23CA
    ret
    db $5D, $61, $63, $65, $67, $69

Jump_073_4A82::
    ld a, [$C923]
    rst $00
    dw Jump_073_4A9E
    dw Func_073_4E5D
    dw Jump_073_4AA9
    dw Func_073_4E5D
    dw Jump_073_5194
    dw Jump_073_4AC6
    dw Func_073_4E5D
    dw Jump_073_4ADE
    dw Func_073_4E5D
    dw Func_073_4E9C
    dw Func_073_4E5D
    dw Jump_073_4B2B

Jump_073_4A9E::
    ld hl, $C923
    inc [hl]
    ld hl, $401D
    call Func_073_4ED8
    ret

Jump_073_4AA9::
    ld a, [$C552]
    or a, a
    jr nz, Jump_073_4ABA
    ld hl, $804B
    call Func_073_4ED8
    ld hl, $C923
    inc [hl]
    ret

Jump_073_4ABA::
    ld hl, $804A
    call Func_073_4ED8
    ld a, $08
    ld [$C923], a
    ret

Jump_073_4AC6::
    ld hl, $C923
    inc [hl]
    ld a, [$D092]
    or a, a
    jr nz, Jump_073_4AD7
    ld hl, $001E
    call Func_073_4ED8
    ret

Jump_073_4AD7::
    ld hl, $001F
    call Func_073_4ED8
    ret

Jump_073_4ADE::
    ld hl, $C923
    inc [hl]
    ld a, [$D092]
    or a, a
    jr nz, Jump_073_4B21
    call Func_000_09F3
    ld a, [$CD03]
    and a, $03
    add a, $19
    ld [$C928], a
    ld hl, $6C8C
    ld b, $5F
    rst $10
    ld a, [$C928]
    ld de, $C152
    call Func_000_2431
    ld a, [$C634]
    or a, a
    jr z, Jump_073_4B15
    cp a, $FF
    jr z, Jump_073_4B15
    ld hl, $001B
    call Func_073_4ED8
    ret

Jump_073_4B15::
    ld hl, $401B
    call Func_073_4ED8
    ld a, $0A
    ld [$C923], a
    ret

Jump_073_4B21::
    ld hl, $000F
    call Func_073_4ED8
    call Func_073_4C5D
    ret

Jump_073_4B2B::
    call Func_000_09F3
    ld a, [$CD03]
    and a, $03
    add a, $19
    ld [$C928], a
    ld hl, $6C8C
    ld b, $5F
    rst $10
    ld a, [$C928]
    ld de, $C152
    call Func_000_2431
    ld a, [$C634]
    or a, a
    jr z, Jump_073_4B5D
    cp a, $FF
    jr z, Jump_073_4B5D
    ld hl, $801B
    call Func_073_4ED8
    ld a, $08
    ld [$C923], a
    ret

Jump_073_4B5D::
    ld hl, $C01B
    call Func_073_4ED8
    ld hl, $C923
    dec [hl]
    ret

Jump_073_4B68::
    ld a, [$C923]
    rst $00
    dw Jump_073_4B80
    dw Func_073_4E5D
    dw Jump_073_4B8B
    dw Func_073_4E5D
    dw Jump_073_5194
    dw Jump_073_4BA8
    dw Func_073_4E5D
    dw Jump_073_4C1B
    dw Func_073_4E5D
    dw Func_073_4E9C

Jump_073_4B80::
    ld hl, $C923
    inc [hl]
    ld hl, $4010
    call Func_073_4ED8
    ret

Jump_073_4B8B::
    ld a, [$C552]
    or a, a
    jr nz, Jump_073_4B9C
    ld hl, $804F
    call Func_073_4ED8
    ld hl, $C923
    inc [hl]
    ret

Jump_073_4B9C::
    ld hl, $804E
    call Func_073_4ED8
    ld a, $08
    ld [$C923], a
    ret

Jump_073_4BA8::
    ld hl, $C923
    inc [hl]
    ld a, [$D092]
    or a, a
    jr nz, Jump_073_4BB9
    db $21

Func_073_4BB3:: ; heuristic: target of a pointer table; C0
    ld de, $CD00
    ret c
    ld c, [hl]
    ret

Jump_073_4BB9::
    ld hl, $0012
    call Func_073_4ED8
    call Func_073_4C5D
    ret

Jump_073_4BC3::
    ld a, [$C923]
    rst $00
    dw Jump_073_4BDB
    dw Func_073_4E5D
    dw Jump_073_4BE6
    dw Func_073_4E5D
    dw Jump_073_5194
    dw Jump_073_4C03
    dw Func_073_4E5D
    dw Jump_073_4C1B
    dw Func_073_4E5D
    dw Func_073_4E9C

Jump_073_4BDB::
    ld hl, $C923
    inc [hl]
    ld hl, $400B
    call Func_073_4ED8
    ret

Jump_073_4BE6::
    ld a, [$C552]
    or a, a
    jr nz, Jump_073_4BF7
    ld hl, $804D
    call Func_073_4ED8
    ld hl, $C923
    inc [hl]
    ret

Jump_073_4BF7::
    ld hl, $804C
    call Func_073_4ED8
    ld a, $08
    ld [$C923], a
    ret

Jump_073_4C03::
    ld hl, $C923
    inc [hl]
    ld a, [$D092]
    or a, a
    jr nz, Jump_073_4C14
    ld hl, $000C
    call Func_073_4ED8
    ret

Jump_073_4C14::
    ld hl, $000E
    call Func_073_4ED8
    ret

Jump_073_4C1B::
    ld hl, $C923
    inc [hl]
    ld a, [$D092]
    or a, a
    jr nz, Jump_073_4C53
    call Func_000_095B
    ld a, [$C5E7]
    cp a, $10
    jr c, $4C41

Jump_073_4C2F::
    ld hl, $000D
    call Func_073_4ED8
    ld a, $29
    ld [$C928], a
    ld hl, $6C8C
    ld b, $5F
    rst $10
    ret
    db $21

Func_073_4C42:: ; heuristic: target of a pointer table; C0
    sbc a, d
    ld l, b
    ld b, $12
    rst $10
    ldh a, [$FFC6]
    or a, a
    jr z, Jump_073_4C2F
    ld hl, $0043
    call Func_073_4ED8
    ret

Jump_073_4C53::
    ld hl, $000F
    call Func_073_4ED8
    call Func_073_4C5D
    ret

Func_073_4C5D::
    ld a, [$C617]
    ld [$C8C0], a
    ld a, [$C618]
    ld [$C8C1], a
    ld a, [$C619]
    ld [$C8C2], a
    ld hl, $7F1C
    ld b, $12
    rst $10
    ld a, [$C617]
    ld c, a
    ld a, [$C8C0]
    sub a, c
    ld [$C8C0], a
    ld a, [$C618]
    ld c, a
    ld a, [$C8C1]
    sbc a, c
    ld [$C8C1], a
    ld a, [$C619]
    ld c, a
    ld a, [$C8C2]
    sbc a, c
    ld [$C8C2], a
    call Func_000_173A
    ld de, $C17E
    call Func_000_23CA
    ret

Jump_073_4CA0::
    ld a, [$C923]
    rst $00
    dw Jump_073_4CAE
    dw Func_073_4E5D
    dw Jump_073_4CE5
    dw Func_073_4E5D
    dw Func_073_4E9C

Jump_073_4CAE::
    ld hl, $C923
    inc [hl]
    ld hl, $4008
    call Func_073_4ED8
    call Func_073_4FD2
    ld a, [$C921]
    ld de, $C152
    call Func_000_2431
    ld a, [$C921]
    call Func_073_4FB7
    ld e, l

Func_073_4CCB:: ; heuristic: target of a pointer table; C0
    ld d, h
    add hl, hl
    add hl, hl
    add hl, de
    ld a, l
    ld [$C8C0], a
    ld a, h
    ld [$C8C1], a
    xor a, a
    ld [$C8C2], a
    call Func_000_173A
    ld de, $C17E
    call Func_000_23CA
    ret

Jump_073_4CE5::
    ld hl, $C923
    inc [hl]
    ld a, [$C552]
    or a, a
    jr nz, Jump_073_4D19
    ld a, [$C921]
    ld [$C928], a
    ld hl, $6C8C
    ld b, $5F
    rst $10
    ld a, [$C921]
    call Func_073_4FB7
    ld e, l
    ld d, h
    add hl, hl
    add hl, hl
    add hl, de
    ld a, l
    ldh [$FFC6], a
    ld a, h
    ldh [$FFC7], a
    ld hl, $7E84
    ld b, $12
    rst $10
    ld hl, $8009
    call Func_073_4ED8
    ret

Jump_073_4D19::
    ld hl, $800A
    call Func_073_4ED8
    ret

Jump_073_4D20::
    ld a, [$C923]
    rst $00
    dw Jump_073_4D36
    dw Func_073_4E5D
    dw Jump_073_4D41
    dw Func_073_4E20
    dw Jump_073_4E41
    dw Jump_073_4D5B
    dw Func_073_4E67
    dw Func_073_4E5D
    dw Func_073_4E9C

Jump_073_4D36::
    ld hl, $C923
    inc [hl]
    ld hl, $4005
    call Func_073_4ED8
    ret

Jump_073_4D41::
    ld hl, $C923
    inc [hl]
    ld a, [$C552]
    or a, a
    jr nz, Jump_073_4D52
    ld hl, $8027
    call Func_073_4ED8
    ret

Jump_073_4D52::
    ld hl, $C923
    inc [hl]
    ld hl, $C923
    inc [hl]
    ret

Jump_073_4D5B::
    ld hl, $C923
    inc [hl]
    ld a, [$C924]
    cp a, $27
    jr nz, Jump_073_4D82
    ld hl, $03E8
    ld a, l
    ldh [$FFC6], a
    ld a, h
    ldh [$FFC7], a
    ld hl, $7E84
    ld b, $12
    rst $10
    ld hl, $64F8
    ld b, $12
    rst $10
    ld hl, $0006
    call Func_073_4ED8
    ret

Jump_073_4D82::
    ld hl, $8007
    call Func_073_4ED8
    ld hl, $C923
    inc [hl]
    ret

Jump_073_4D8D::
    ld a, [$C923]
    rst $00
    dw Jump_073_4D9B
    dw Func_073_4E5D
    dw Jump_073_4DCD
    dw Func_073_4E5D
    dw Func_073_4E9C

Jump_073_4D9B::
    ld hl, $C923
    inc [hl]
    ld hl, $4002
    call Func_073_4ED8
    call Func_073_4FD2
    ld a, [$C921]
    ld de, $C152
    call Func_000_2431
    ld a, [$C921]
    call Func_073_4FB7
    ld a, l
    ld [$C8C0], a
    ld a, h
    ld [$C8C1], a
    xor a, a
    ld [$C8C2], a
    call Func_000_173A
    ld de, $C17E
    call Func_000_23CA
    ret

Jump_073_4DCD::
    ld hl, $C923
    inc [hl]
    ld a, [$C552]
    or a, a
    jr nz, Jump_073_4DFC
    ld a, [$C921]
    ld [$C928], a
    ld hl, $6C8C
    ld b, $5F
    rst $10
    ld a, [$C921]
    call Func_073_4FB7
    ld a, l
    ldh [$FFC6], a
    ld a, h
    ldh [$FFC7], a
    ld hl, $7E84
    ld b, $12
    rst $10
    ld hl, $8003
    call Func_073_4ED8
    ret

Jump_073_4DFC::
    ld hl, $8004
    call Func_073_4ED8
    ret

Jump_073_4E03::
    ld a, [$C923]
    rst $00
    dw Jump_073_4E15
    dw Func_073_4E20
    dw Jump_073_4E41
    dw Func_073_4E48
    dw Func_073_4E67
    dw Func_073_4E5D
    dw Func_073_4E9C

Jump_073_4E15::
    ld hl, $0000
    call Func_073_4ED8
    ld hl, $C923
    inc [hl]
    ret

Func_073_4E20:: ; heuristic: target of a pointer table; C0
    xor a, a
    call Func_073_4FA9
    ret nc
    ld a, [$C525]
    or a, a
    jr z, Jump_073_4E37
    ld hl, $C49F
    ld de, $C0F0
    ld bc, $0040
    call Func_000_0952

Jump_073_4E37::
    ld a, $7A
    call Func_000_1278
    ld hl, $C923
    inc [hl]
    ret

Jump_073_4E41::
    ld hl, $653F
    ld b, $12
    rst $10
    ret

Func_073_4E48:: ; heuristic: follows a terminator; C0
    ld hl, $64F8
    ld b, $12
    rst $10
    ld hl, $0001
    call Func_073_4ED8
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Func_073_4E5D:: ; heuristic: follows a terminator; C0
    xor a, a
    call Func_073_4FA9
    ret nc
    ld hl, $C923
    inc [hl]
    ret

Func_073_4E67:: ; heuristic: follows a terminator; C0
    ld a, [$C921]
    or a, a
    jr nz, Jump_073_4E76
    inc a
    ld [$C921], a
    ld a, $0E
    ldh [$FF8D], a
    ret

Jump_073_4E76::
    ld hl, $5E85
    ld b, $02
    rst $10
    ld hl, $5E85
    ld b, $02
    rst $10
    call Func_000_222B
    ld hl, $4AA8
    ld b, $04
    rst $10
    ld a, $7F
    ld [$C527], a
    xor a, a
    ldh [$FF8D], a
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Func_073_4E9C:: ; heuristic: follows a terminator; C0
    ld a, [$C921]
    cp a, $1E
    jr nc, Jump_073_4EA9
    bit 3, a
    jr z, Jump_073_4EB9
    jr Jump_073_4EC0

Jump_073_4EA9::
    cp a, $3C
    jr nc, Jump_073_4EB3
    bit 2, a
    jr z, Jump_073_4EB9
    jr Jump_073_4EC0

Jump_073_4EB3::
    bit 1, a
    jr z, Jump_073_4EB9
    jr Jump_073_4EC0

Jump_073_4EB9::
    ld a, $01
    ld [$CB7D], a
    jr Jump_073_4EC4

Jump_073_4EC0::
    xor a, a
    ld [$CB7D], a

Jump_073_4EC4::
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $78
    ret nz
    ld a, $80
    ld [$C919], a
    xor a, a
    ld [$C935], a
    ret

Func_073_4ED8::
    ld a, l
    ld [$C924], a
    ld a, h
    ld [$C925], a
    xor a, a
    ld [$C926], a
    ret

Func_073_4EE5:: ; heuristic: follows a terminator; C0
    push af
    ld a, [$C926]
    cp a, $FF
    jr nz, Jump_073_4EEF
    pop af
    ret

Jump_073_4EEF::
    rst $00
    dw Jump_073_4EF8
    dw Jump_073_4F3C
    dw Jump_073_4F59
    dw Jump_073_4F90

Jump_073_4EF8::
    pop af
    or a, a
    jr nz, Jump_073_4F02
    ld hl, $4470
    ld b, $04
    rst $10

Jump_073_4F02::
    ld a, [$C925]
    bit 7, a
    jr nz, Jump_073_4F37
    ld hl, $8800
    ld de, $1202
    call Func_000_2E98
    call Func_000_290E
    ld a, $69
    call Func_000_1278
    ld a, $01
    ld [$C8CB], a
    ld a, $00
    ld [$C8CC], a
    ld a, $02
    ldh [$FFB9], a
    ldh a, [$FF91]
    cp a, $48
    jr c, Jump_073_4F37
    ld a, $81
    ld [$C8CB], a
    ld a, $01
    ldh [$FFB9], a

Jump_073_4F37::
    ld hl, $C926
    inc [hl]
    ret

Jump_073_4F3C::
    pop af
    ld a, [$C8CB]
    and a, $03
    ret nz
    ld a, [$C924]
    ld [$C529], a
    ld a, $05
    ld [$C528], a
    ld hl, $4001
    ld b, $09
    rst $10
    ld hl, $C926
    inc [hl]
    ret

Jump_073_4F59::
    pop af
    ld a, [$C52B]
    bit 0, a
    ret nz
    ld a, [$C925]
    bit 6, a
    jr z, Jump_073_4F6D
    ld a, $FF
    ld [$C926], a
    ret

Jump_073_4F6D::
    ld a, $69
    call Func_000_1278
    ld a, $02
    ld [$C8CB], a
    ld a, $00
    ld [$C8CC], a
    ld a, $00
    ldh [$FFB9], a
    ldh a, [$FF91]
    cp a, $48
    jr c, Jump_073_4F8B
    ld a, $82
    ld [$C8CB], a

Jump_073_4F8B::
    ld hl, $C926
    inc [hl]
    ret

Jump_073_4F90::
    ld a, [$C8CB]
    and a, $03
    jr z, Jump_073_4F99
    pop af
    ret

Jump_073_4F99::
    pop af
    or a, a
    jr nz, Jump_073_4FA3
    ld hl, $449F
    ld b, $04
    rst $10

Jump_073_4FA3::
    ld a, $FF
    ld [$C926], a
    ret

Func_073_4FA9::
    call Func_073_4EE5
    ld a, [$C926]
    cp a, $FF
    jr z, Jump_073_4FB5
    sub a, a
    ret

Jump_073_4FB5::
    scf
    ret

Func_073_4FB7::
    ld c, $0D
    call Func_000_1682
    ld a, l
    add a, $C3
    ld l, a
    ld a, h
    adc a, $4C
    ld h, a
    ld e, l
    ld d, h
    ld b, $16
    call Func_000_1872
    ld l, c
    inc de
    call Func_000_1872
    ld h, c
    ret

Func_073_4FD2::
    ld hl, $6CA9
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    jr z, Jump_073_4FE8
    ld a, $0C
    ld [$C921], a
    call Func_073_516B
    or a, a
    ret nz

Jump_073_4FE8::
    ld hl, $6D0D
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    jr z, Jump_073_4FFE
    ld a, $08
    ld [$C921], a
    call Func_073_516B
    or a, a
    ret nz

Jump_073_4FFE::
    ld hl, $6CDB
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    jr z, Jump_073_5014
    ld a, $06
    ld [$C921], a
    call Func_073_516B
    or a, a
    ret nz

Jump_073_5014::
    ld a, [$C6FD]
    cp a, $03
    jr z, Jump_073_505C
    ld hl, $5E3F
    ld b, $1D
    rst $10
    ld a, [$D7AA]
    cp a, $03
    jr nc, Jump_073_5032
    ld a, $19
    ld [$C921], a
    call Func_073_516B
    or a, a
    ret nz

Jump_073_5032::
    ld a, [$D7AA]
    cp a, $03
    jr c, Jump_073_5047
    cp a, $06
    jr nc, Jump_073_5047
    ld a, $1A
    ld [$C921], a
    call Func_073_516B
    or a, a
    ret nz

Jump_073_5047::
    ld a, [$D7AA]
    cp a, $06
    jr c, Jump_073_505C
    cp a, $0B
    jr nc, Jump_073_505C
    ld a, $1B
    ld [$C921], a
    call Func_073_516B
    or a, a
    ret nz

Jump_073_505C::
    call Func_073_5117
    ldh a, [$FFC9]
    or a, a
    jr nz, Jump_073_506A
    ldh a, [$FFC8]
    cp a, $65
    jr c, Jump_073_5074

Jump_073_506A::
    ld a, $05
    ld [$C921], a
    call Func_073_516B
    or a, a
    ret nz

Jump_073_5074::
    ldh a, [$FFC9]
    or a, a
    jr nz, Jump_073_508C
    ldh a, [$FFC8]
    cp a, $65
    jr nc, Jump_073_508C
    or a, a
    jr z, Jump_073_508C
    ld a, $04
    ld [$C921], a
    call Func_073_516B
    or a, a
    ret nz

Jump_073_508C::
    call Func_073_50C3
    ldh a, [$FFC9]
    or a, a
    jr nz, Jump_073_509A
    ldh a, [$FFC8]
    cp a, $65
    jr c, Jump_073_50A4

Jump_073_509A::
    ld a, $03
    ld [$C921], a
    call Func_073_516B
    or a, a
    ret nz

Jump_073_50A4::
    ldh a, [$FFC9]
    or a, a
    jr nz, Jump_073_50BD
    ldh a, [$FFC8]
    cp a, $33
    jr c, Jump_073_50BD
    cp a, $64
    jr nc, Jump_073_50BD
    ld a, $02
    ld [$C921], a
    call Func_073_516B
    or a, a
    ret nz

Jump_073_50BD::
    ld a, $01
    ld [$C921], a
    ret

Func_073_50C3::
    ld hl, $0000
    ld a, l
    ldh [$FFC8], a
    ld a, h
    ldh [$FFC9], a
    ld a, $0A
    ld [$0100], a
    ld a, [$C6FD]
    or a, a
    jr z, Jump_073_5112
    ld b, a
    ld hl, $C6FE

Jump_073_50DB::
    ld a, [hl]
    ld c, $5D
    call Func_000_1F89
    push hl
    ldh a, [$FFC6]
    ld l, a
    ldh a, [$FFC7]
    ld h, a
    ldh a, [$FFC8]
    ld e, a
    ldh a, [$FFC9]
    ld d, a
    add hl, de
    ld a, l
    ldh [$FFC8], a
    ld a, h
    ldh [$FFC9], a
    pop hl
    ld a, [hl]
    ld c, $5B
    call Func_000_1F89
    push hl
    ldh a, [$FFC6]
    ld l, a
    ldh a, [$FFC7]
    ld h, a
    ldh a, [$FFC8]
    sub a, l
    ldh [$FFC8], a
    ldh a, [$FFC9]
    sbc a, h
    ldh [$FFC9], a
    pop hl
    inc hl
    dec b
    jr nz, Jump_073_50DB

Jump_073_5112::
    xor a, a
    ld [$0100], a
    ret

Func_073_5117::
    ld hl, $0000
    ld a, l
    ldh [$FFC8], a
    ld a, h
    ldh [$FFC9], a
    ld a, $0A
    ld [$0100], a
    ld a, [$C6FD]
    or a, a
    jr z, Jump_073_5166
    ld b, a
    ld hl, $C6FE

Jump_073_512F::
    ld a, [hl]
    ld c, $61
    call Func_000_1F89
    push hl
    ldh a, [$FFC6]
    ld l, a
    ldh a, [$FFC7]
    ld h, a
    ldh a, [$FFC8]
    ld e, a
    ldh a, [$FFC9]
    ld d, a
    add hl, de
    ld a, l
    ldh [$FFC8], a
    ld a, h
    ldh [$FFC9], a
    pop hl
    ld a, [hl]
    ld c, $5F
    call Func_000_1F89
    push hl
    ldh a, [$FFC6]
    ld l, a
    ldh a, [$FFC7]
    ld h, a
    ldh a, [$FFC8]
    sub a, l
    ldh [$FFC8], a
    ldh a, [$FFC9]
    sbc a, h
    ldh [$FFC9], a
    pop hl
    inc hl
    dec b
    jr nz, Jump_073_512F

Jump_073_5166::
    xor a, a
    ld [$0100], a
    ret

Func_073_516B::
    call Func_073_4FB7
    ld a, [$C935]
    and a, $0F
    dec a
    jr z, Jump_073_517B
    ld e, l
    ld d, h
    add hl, hl
    add hl, hl
    add hl, de

Jump_073_517B::
    ld a, [$C619]
    or a, a
    jr z, Jump_073_5184

Jump_073_5181::
    ld a, $01
    ret

Jump_073_5184::
    ld a, [$C618]
    cp a, h
    jr c, Jump_073_5192
    jr nz, Jump_073_5181
    ld a, [$C617]
    cp a, l
    jr nc, Jump_073_5181

Jump_073_5192::
    xor a, a
    ret

Jump_073_5194::
    ld hl, $C923
    inc [hl]
    ld a, $06
    ld [$C903], a
    ld a, $01
    ld [$C905], a
    ld a, $03
    ld [$C5DC], a
    xor a, a
    ld [$C904], a
    ld a, $02
    ld [$C8C7], a
    ld hl, $5EEE
    ld b, $02
    rst $10
    ld hl, $476E
    ld b, $0A
    rst $10
    ret

Func_073_51BD::
    ld a, [$C923]
    rst $00
    dw Jump_073_52EE
    dw Jump_073_7AC6
    dw Jump_073_52B9
    dw Jump_073_52B2
    dw Jump_073_7AC6
    dw Jump_073_5265
    dw Jump_073_524B
    dw Jump_073_51FB
    dw Jump_073_53D8
    dw Jump_073_51D7
    dw Jump_073_51FB

Jump_073_51D7::
    ld a, [$C922]
    ld c, a
    ld a, [$CB8A]
    add a, c
    ld [$CB8A], a
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $10
    ret nz
    xor a, a
    ld [$CB86], a
    ld hl, $CB8C
    call Func_073_7A4C
    ld hl, $C923
    inc [hl]
    ret

Jump_073_51FB::
    ldh a, [$FF90]
    sub a, $C8
    add a, a
    ld hl, $5215
    add a, l
    ld l, a
    jr nc, Jump_073_5208
    inc h

Jump_073_5208::
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    call Func_000_1845
    ld a, $80
    ld [$C919], a
    ret
    db $00, $00, $00, $00, $D4, $01, $D9, $01, $DD, $01, $6A, $01, $6E, $01, $00, $00
    db $00, $00, $00, $00, $00, $00, $74, $01, $78, $01, $7C, $01, $D5, $00, $D9, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $DF, $00, $F8, $00, $FC, $00, $F2, $01
    db $F6, $01, $00, $00, $00, $00

Jump_073_524B::
    xor a, a
    ldh [$FFC6], a
    ld a, $30
    ldh [$FFC7], a
    ld hl, $6BF8
    ld b, $5F
    rst $10
    ldh a, [$FFC6]
    or a, a
    ret z
    xor a, a
    ld [$CB7D], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_5265::
    ldh a, [$FF90]
    cp a, $CE
    jr z, Jump_073_5278
    cp a, $D7
    jr z, Jump_073_528A
    cp a, $E0
    jr z, Jump_073_529C
    ld hl, $C923
    inc [hl]
    ret

Jump_073_5278::
    ld a, $0A
    ldh [$FFC6], a
    ld hl, $6DAC
    ld b, $5F
    rst $10
    ld de, $0206
    call Func_000_1845
    jr Jump_073_52AC

Jump_073_528A::
    ld a, $0B
    ldh [$FFC6], a
    ld hl, $6DAC
    ld b, $5F
    rst $10
    ld de, $0207
    call Func_000_1845
    jr Jump_073_52AC

Jump_073_529C::
    ld a, $0C
    ldh [$FFC6], a
    ld hl, $6DAC
    ld b, $5F
    rst $10
    ld de, $0208
    call Func_000_1845

Jump_073_52AC::
    ld a, $08
    ld [$C923], a
    ret

Jump_073_52B2::
    ld de, $5342
    call Func_073_52F5
    ret

Jump_073_52B9::
    ldh a, [$FF90]
    sub a, $C8
    ld de, $52D3
    add a, e
    ld e, a
    jr nc, Jump_073_52C5
    inc d

Jump_073_52C5::
    ld a, [de]
    ldh [$FFC6], a
    ld hl, $47A4
    ld b, $0A
    rst $10
    ld hl, $C923
    inc [hl]
    ret
    db $00, $00, $20, $21, $22, $23, $24, $00, $00, $00, $00, $25, $26, $27, $28, $29
    db $00, $00, $00, $00, $2A, $2B, $2C, $2D, $2E, $00, $00

Jump_073_52EE::
    ld de, $530C
    call Func_073_52F5
    ret

Func_073_52F5::
    ldh a, [$FF90]
    sub a, $C8
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_073_52FF
    inc d

Jump_073_52FF::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    call Func_073_7AA5
    ld hl, $C923
    inc [hl]
    ret
    INCBIN "dwm2-cobi-us.gbc", $1CD30C, $6C

Func_073_5378::
    xor a, a
    ldh [$FFC6], a
    ld a, $20
    ldh [$FFC7], a
    ld hl, $6BF8
    ld b, $5F
    rst $10
    ldh a, [$FFC6]
    or a, a
    ret z
    ld a, $09
    ldh [$FFC6], a
    ld hl, $6DAC
    ld b, $5F
    rst $10
    ld a, [$CC3F]
    set 1, a
    ld [$CC3F], a
    ld a, $50
    ld [$CB9A], a
    ld a, $70
    ld [$CB9B], a
    ld a, $80
    ld [$C919], a
    ret

Func_073_53AB::
    ld a, [$C923]
    rst $00
    dw Jump_073_53D8
    dw Jump_073_53B3

Jump_073_53B3::
    ld a, [$C922]
    ld c, a
    ld a, [$CB8A]
    add a, c
    ld [$CB8A], a
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $10
    ret nz
    xor a, a
    ld [$CB86], a
    ld hl, $CB8C
    call Func_073_7A4C
    ld a, $80
    ld [$C919], a
    ret

Jump_073_53D8::
    ld hl, $CB8C
    call Func_073_7A47
    ld hl, $C923
    inc [hl]
    ldh a, [$FF8E]
    cp a, $30
    jr nz, Jump_073_53EE
    ldh a, [$FF91]
    cp a, $20
    jr z, Jump_073_5412

Jump_073_53EE::
    ld a, [$C6FD]
    ld b, a
    ld hl, $C8F0

Jump_073_53F5::
    push hl
    ld a, [hl+]
    cp a, $30
    jr nz, Jump_073_5400
    ld a, [hl]
    cp a, $20
    jr z, Jump_073_5411

Jump_073_5400::
    pop hl
    inc hl
    inc hl
    dec b
    jr nz, Jump_073_53F5
    ld a, $FF
    ld [$C922], a
    ld a, $03
    ld [$CB86], a
    ret

Jump_073_5411::
    pop hl

Jump_073_5412::
    ld a, $01
    ld [$C922], a
    ld a, $01
    ld [$CB86], a
    ret

Func_073_541D::
    ld a, $10
    ld [$CBAB], a
    xor a, a
    ld [$CB86], a
    ld [$CB96], a
    ld hl, $CB8C
    call Func_073_7A47
    ld hl, $CB9C
    call Func_073_7A47
    ld a, [$CB8B]
    inc a
    inc a
    ld [$CB8B], a
    ld [$CB9B], a
    cp a, $B0
    ret nz
    ld a, $80
    ld [$C919], a
    ret

Func_073_5449::
    ld a, [$C923]
    rst $00
    dw Jump_073_5509
    dw Jump_073_54CA
    dw Jump_073_54BF
    dw Jump_073_7AC6
    dw Jump_073_54BA
    dw Jump_073_54AF
    dw Jump_073_7AC6
    dw Jump_073_546C
    dw Jump_073_5461
    dw Func_073_7AD0

Jump_073_5461::
    ld hl, $0782
    call Func_073_7AA5
    ld hl, $C923
    inc [hl]
    ret

Jump_073_546C::
    ld a, [$CB8B]
    cp a, $40
    jr z, Jump_073_5488
    xor a, a
    ld [$C929], a
    ld a, $00
    ld [$C92A], a
    ld a, $40
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ret

Jump_073_5488::
    xor a, a
    ld [$C929], a
    ld a, $03
    ld [$C92A], a
    ld a, $10
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ldh a, [$FF98]
    inc a
    inc a
    and a, $03
    ld [$CB86], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_54AF::
    ld hl, $0781
    call Func_073_7AA5
    ld hl, $C923
    inc [hl]
    ret

Jump_073_54BA::
    ld hl, $C923
    inc [hl]
    ret

Jump_073_54BF::
    ld hl, $0780
    call Func_073_7AA5
    ld hl, $C923
    inc [hl]
    ret

Jump_073_54CA::
    ld a, [$CB8A]
    cp a, $50
    jr z, Jump_073_54E6
    xor a, a
    ld [$C929], a
    ld a, $01
    ld [$C92A], a
    ld a, $50
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ret

Jump_073_54E6::
    xor a, a
    ld [$C929], a
    ld a, $02
    ld [$C92A], a
    ld a, $30
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld a, $03
    ld [$CB86], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_5509::
    ldh a, [$FF8E]
    cp a, $40
    jr nz, Jump_073_5515
    ldh a, [$FF91]
    cp a, $40
    jr z, Jump_073_5541

Jump_073_5515::
    ld a, [$C6FD]
    or a, a
    jr z, Jump_073_5535
    ld b, a
    ld hl, $C8F0

Jump_073_551F::
    push hl
    ld a, [hl+]
    cp a, $40
    jr nz, Jump_073_552A
    ld a, [hl]
    cp a, $40
    jr z, Jump_073_5540

Jump_073_552A::
    pop hl
    ld a, $05
    add a, l
    ld l, a
    jr nc, Jump_073_5532
    inc h

Jump_073_5532::
    dec b
    jr nz, Jump_073_551F

Jump_073_5535::
    ld a, $02
    ld [$CB86], a
    ld a, $02
    ld [$C923], a
    ret

Jump_073_5540::
    pop hl

Jump_073_5541::
    ld hl, $C923
    inc [hl]
    ret

Func_073_5546::
    ld a, [$C923]
    rst $00
    dw Jump_073_555E
    dw Jump_073_554E

Jump_073_554E::
    ld b, $3C
    call Func_073_7A2B
    ret nc
    xor a, a
    ld [$CBCF], a
    ld a, $80
    ld [$C919], a
    ret

Jump_073_555E::
    ld a, $05
    ldh [$FFC6], a
    ld hl, $6B98
    ld b, $12
    rst $10
    ld a, $40
    ld [$CBD3], a
    ld a, $20
    ld [$CBD4], a
    ld hl, $C923
    inc [hl]
    ret

Func_073_5577::
    ld a, [$C923]
    or a, a
    jr nz, Jump_073_559E
    ld a, $A9
    ldh [$FF90], a
    ld a, $01
    ldh [$FF8F], a
    xor a, a
    ldh [$FF92], a
    ld a, $60
    ld [$C8C8], a
    ld a, $10
    ld [$C8C9], a
    ld a, $02
    ld [$C8C6], a
    ld hl, $6C5A
    ld b, $5F
    rst $10
    ret

Jump_073_559E::
    ld a, $80
    ld [$C919], a
    ret

Func_073_55A4::
    xor a, a
    ldh [$FFC6], a
    ld a, $30
    ldh [$FFC7], a
    ld hl, $6BF8
    ld b, $5F
    rst $10
    ldh a, [$FFC6]
    or a, a
    ret z
    ld a, $07
    ldh [$FFC6], a
    ld hl, $6DAC
    ld b, $5F
    rst $10
    ld a, $80
    ld [$C919], a
    ret

Func_073_55C5::
    ld a, [$C923]
    rst $00
    dw Jump_073_5659
    dw Jump_073_7AC6
    dw Jump_073_562C
    dw Jump_073_55D1

Jump_073_55D1::
    ld a, [$C924]
    ld l, a
    ld a, [$C925]
    ld h, a
    ld a, l
    sub a, $08
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld a, l
    ld [$C924], a
    ld a, h
    ld [$C925], a
    ld a, [$CB8B]
    sub a, h
    ld [$CB8B], a
    ld a, [$CB9B]
    sub a, h
    ld [$CB9B], a
    ld a, $00
    ld [$C929], a
    ld a, $01
    ld [$C92A], a
    ld a, $C0
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, $01
    ld [$C929], a
    ld a, $01
    ld [$C92A], a
    ld a, $C0
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld a, $80
    ld [$C919], a
    ret

Jump_073_562C::
    ld hl, $CB9C
    call Func_073_7A47
    ld a, $01
    ld [$CB96], a
    ld a, [$CB9A]
    cp a, $60
    jr z, Jump_073_5643
    inc a
    ld [$CB9A], a
    ret

Jump_073_5643::
    ld hl, $CB9C
    call Func_073_7A4C
    ld hl, $0300
    ld a, l
    ld [$C924], a
    ld a, h
    ld [$C925], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_5659::
    ld a, $02
    ldh [$FFC6], a
    ld a, $40
    ldh [$FFC7], a
    ld hl, $6BF8
    ld b, $5F
    rst $10
    ld a, [$CBAB]
    cp a, $40
    jr z, Jump_073_5670
    ld a, $30

Jump_073_5670::
    ld [$CBBB], a
    ldh a, [$FFC6]
    or a, a
    ret z
    ld a, [$CB7D]
    dec a
    dec a
    ld [$CB7D], a
    xor a, a
    ld [$CB96], a
    ld hl, $0725
    call Func_073_7AA5
    ld hl, $C923
    inc [hl]
    ret

Func_073_568E::
    ld a, [$C923]
    rst $00
    dw Jump_073_56F6
    dw Jump_073_56DB
    dw Jump_073_56BD
    dw Jump_073_569A

Jump_073_569A::
    ld a, [$CBAB]
    dec a
    ld [$CBAB], a
    ld a, [$CB9B]
    dec a
    ld [$CB9B], a
    cp a, $50
    ret nz
    ld hl, $CB9C
    call Func_073_7A4C
    ld hl, $CBAC
    call Func_073_7A4C
    ld a, $80
    ld [$C919], a
    ret

Jump_073_56BD::
    ld a, [$CBAA]
    inc a
    ld [$CBAA], a
    ld a, [$CB9A]
    inc a
    ld [$CB9A], a
    cp a, $60
    ret nz
    ld a, $02
    ld [$CB96], a
    ld [$CBA6], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_56DB::
    ld a, [$CB9A]
    inc a
    ld [$CB9A], a
    ld a, [$CBAB]
    dec a
    ld [$CBAB], a
    cp a, $60
    ret nz
    ld a, $01
    ld [$CBA6], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_56F6::
    ld hl, $CB9C
    call Func_073_7A47
    ld hl, $CBAC
    call Func_073_7A47
    ld a, [$CBAB]
    dec a
    ld [$CBAB], a
    ld a, [$CB9B]
    dec a
    ld [$CB9B], a
    cp a, $60
    ret nz
    ld a, $01
    ld [$CB96], a
    ld hl, $C923
    inc [hl]
    ret

Func_073_571D::
    ld a, [$C923]
    rst $00
    dw Func_073_619B
    dw Func_073_619B
    dw Func_073_619B
    dw Jump_073_5729

Jump_073_5729::
    ld a, $80
    ld [$C919], a
    ret

Func_073_572F::
    ld a, [$C923]
    or a, a
    jr nz, Jump_073_575B
    ld a, $28
    ldh [$FF90], a
    xor a, a
    ldh [$FF8F], a
    ld a, $01
    ldh [$FF92], a
    ld a, $40
    ld [$C8C8], a
    ld a, $80
    ld [$C8C9], a
    ld a, $03
    ld [$C8C6], a
    ld hl, $6C5A
    ld b, $5F
    rst $10
    ld a, $04
    call Func_000_0DF2
    ret

Jump_073_575B::
    ld a, $80
    ld [$C919], a
    ret

Func_073_5761::
    ld a, [$C923]
    rst $00
    dw Jump_073_5873
    dw Jump_073_5873
    dw Jump_073_5873
    dw Jump_073_5825
    dw Jump_073_57EA
    dw Jump_073_57C5
    dw Jump_073_5773

Jump_073_5773::
    ld hl, $C240
    ld [hl], $2B
    inc hl
    ld [hl], $2C
    ld hl, $C254
    ld [hl], $2D
    inc hl
    ld [hl], $2E
    ld a, [$C6FD]
    dec a
    jr z, Jump_073_57B0
    ld hl, $C266
    ld [hl], $2B
    inc hl
    ld [hl], $2C
    ld hl, $C27A
    ld [hl], $2D
    inc hl
    ld [hl], $2E
    ld a, [$C6FD]
    dec a
    dec a
    jr z, Jump_073_57B0
    ld hl, $C290
    ld [hl], $2B
    inc hl
    ld [hl], $2C
    ld hl, $C2A4
    ld [hl], $2D
    inc hl
    ld [hl], $2E

Jump_073_57B0::
    ld hl, $6DDB
    ld b, $5F
    rst $10
    ld a, $01
    ld [$C94D], a
    xor a, a
    ld [$C195], a
    ld a, $80
    ld [$C919], a
    ret

Jump_073_57C5::
    ld a, [$C8FB]
    cp a, $60
    jr z, Jump_073_57D1
    ld hl, $C8FB
    inc [hl]
    ret

Jump_073_57D1::
    ld a, $01
    ld [$C8F9], a
    ld a, [$C8FA]
    inc a
    ld [$C8FA], a
    cp a, $40
    ret nz
    ld a, $02
    ld [$C8F9], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_57EA::
    ld a, [$C8F5]
    cp a, $30
    jr z, Jump_073_57FC
    ld a, [$C8F5]
    dec a
    ld [$C8F5], a
    ld [$C8FA], a
    ret

Jump_073_57FC::
    xor a, a
    ld [$C8F4], a
    ld [$C8F9], a
    ld a, [$C8F6]
    inc a
    ld [$C8F6], a
    ld [$C8FB], a
    cp a, $50
    ret nz
    ld a, $01
    ld [$C8F4], a
    ld hl, $C923
    inc [hl]
    ld a, [$C6FD]
    dec a
    dec a
    ret nz
    ld a, $06
    ld [$C923], a
    ret

Jump_073_5825::
    ld a, [$C8F1]
    cp a, $40
    jr z, Jump_073_5845
    ld a, $02
    ld [$C8EF], a
    ld [$C8F4], a
    ld [$C8F9], a
    ld a, [$C8F1]
    dec a
    ld [$C8F1], a
    ld [$C8F6], a
    ld [$C8FB], a
    ret

Jump_073_5845::
    ld a, $03
    ld [$C8EF], a
    ld [$C8F4], a
    ld [$C8F9], a
    ld a, [$C8F0]
    dec a
    ld [$C8F0], a
    ld [$C8F5], a
    ld [$C8FA], a
    cp a, $40
    ret nz
    xor a, a
    ld [$C8EF], a
    ld hl, $C923
    inc [hl]
    ld a, [$C6FD]
    dec a
    ret nz
    ld a, $06
    ld [$C923], a
    ret

Jump_073_5873::
    ld hl, $61EF
    ld b, $12
    rst $10
    ret

Func_073_587A::
    ld a, [$C923]
    rst $00
    dw Jump_073_58E0
    dw Jump_073_6C0C
    dw Jump_073_58BC
    dw Jump_073_58B1
    dw Jump_073_5888

Jump_073_5888::
    ld hl, $CBD3
    inc [hl]
    ld hl, $CBD4
    inc [hl]
    ld de, $CBD4
    call Func_073_7A5D
    ret nc
    xor a, a
    ld [$CBCF], a
    ld a, $2C
    ldh [$FFC6], a
    ld hl, $7DCE
    ld b, $12
    rst $10
    ld hl, $7DF1
    ld b, $12
    rst $10
    ld a, $80
    ld [$C919], a
    ret

Jump_073_58B1::
    ld b, $5A
    call Func_073_7A2B
    ret nc
    ld hl, $C923
    inc [hl]
    ret

Jump_073_58BC::
    ld de, $CB8B
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, $6BCD
    ld b, $5F
    rst $10
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $20
    ret nz
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_58E0::
    ld a, $10
    ldh [$FFC6], a
    ld hl, $6B98
    ld b, $12
    rst $10
    ld a, $50
    ld [$CBD3], a
    ld a, $30
    ld [$CBD4], a
    ld a, $80
    ld [$CBCF], a
    ld hl, $C923
    inc [hl]
    ret

Func_073_58FE::
    xor a, a
    ldh [$FFC6], a
    ld a, $30
    ldh [$FFC7], a
    ld hl, $6BF8
    ld b, $5F
    rst $10
    ldh a, [$FFC6]
    or a, a
    ret z
    xor a, a
    ld [$CB7D], a
    ld a, $80
    ld [$C919], a
    ret

Func_073_5919::
    ld a, [$C921]
    cp a, $1E
    jr nc, Jump_073_5926
    bit 1, a
    jr z, Jump_073_5936
    jr Jump_073_593D

Jump_073_5926::
    cp a, $3C
    jr nc, Jump_073_5930
    bit 2, a
    jr z, Jump_073_5936
    jr Jump_073_593D

Jump_073_5930::
    bit 3, a
    jr z, Jump_073_5936
    jr Jump_073_593D

Jump_073_5936::
    ld a, $20
    ld [$CB9B], a
    jr Jump_073_5942

Jump_073_593D::
    ld a, $E0
    ld [$CB9B], a

Jump_073_5942::
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $78
    ret nz
    ld a, $20
    ld [$CB9B], a
    ld a, $36
    ldh [$FFC6], a
    ld hl, $7DCE
    ld b, $12
    rst $10
    ld hl, $7DF1
    ld b, $12
    rst $10
    ld a, $37
    ldh [$FFC6], a
    ld hl, $7DCE
    ld b, $12
    rst $10
    ld hl, $7DF1
    ld b, $12
    rst $10
    ld a, $38
    ldh [$FFC6], a
    ld hl, $7DCE
    ld b, $12
    rst $10
    ld hl, $7DF1
    ld b, $12
    rst $10
    ld a, $80
    ld [$C919], a
    ret

Func_073_5987::
    ld a, [$C923]
    rst $00
    dw Jump_073_59E6
    dw Jump_073_59AF
    dw Jump_073_5991

Jump_073_5991::
    ld hl, $6990
    ld b, $12
    rst $10
    ld a, $05
    ldh [$FFC7], a
    ld hl, $6955
    ld b, $12
    rst $10
    ld a, [$C836]
    set 7, a
    ld [$C836], a
    ld a, $80
    ld [$C919], a
    ret

Jump_073_59AF::
    ld hl, $C8F1
    dec [hl]
    ld hl, $C8F6
    dec [hl]
    ld hl, $C8FB
    dec [hl]
    ldh a, [$FF91]
    dec a
    ldh [$FF91], a
    cp a, $C0
    ret nz
    ld hl, $FF8C
    call Func_073_7A4C
    ld a, $19
    ldh [$FF90], a
    xor a, a
    ldh [$FF8F], a
    ldh [$FF92], a
    ld a, $40
    ld [$C8C8], a
    ld [$C8C9], a
    ld a, $03
    ld [$C8C6], a
    ld hl, $6C5A
    ld b, $5F
    rst $10
    ret

Jump_073_59E6::
    ld a, $00
    ld [$C929], a
    ld a, $02
    ld [$C92A], a
    ld a, $B0
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, $00
    ld [$C928], a
    ld hl, $6AEB
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld hl, $FF8C
    call Func_073_7A47
    ld hl, $C923
    inc [hl]
    ret

Func_073_5A16::
    ld a, [$C923]
    rst $00
    dw Jump_073_5A48
    dw Jump_073_5A3D
    dw Jump_073_7AC6
    dw Jump_073_5A22

Jump_073_5A22::
    xor a, a
    ldh [$FFC6], a
    ld a, $20
    ldh [$FFC7], a
    ld hl, $6BF8
    ld b, $5F
    rst $10
    ldh a, [$FFC6]
    or a, a
    ret z
    xor a, a
    ld [$CB7D], a
    ld a, $80
    ld [$C919], a
    ret

Jump_073_5A3D::
    ld hl, $0480
    call Func_073_7AA5
    ld hl, $C923
    inc [hl]
    ret

Jump_073_5A48::
    ld a, $1C
    ldh [$FFC6], a
    ld hl, $47A4
    ld b, $0A
    rst $10
    ld hl, $C923
    inc [hl]
    ret

Func_073_5A57:: ; heuristic: follows a terminator; C0
    ldh a, [$FF8E]
    cp a, $40
    jr z, Jump_073_5A9C
    cp a, $60
    jr z, Jump_073_5A90
    ld a, [$C6FD]
    ld b, a
    ld hl, $C8F0

Jump_073_5A68::
    push hl
    ld a, [hl]
    cp a, $40
    jr nz, Jump_073_5A77
    inc hl
    ld a, [hl]
    cp a, $40
    jr nz, Jump_073_5A85
    pop hl
    jr Jump_073_5A9C

Jump_073_5A77::
    ld a, [hl]
    cp a, $60
    jr nz, Jump_073_5A85
    inc hl
    ld a, [hl]
    cp a, $40
    jr nz, Jump_073_5A85
    pop hl
    jr Jump_073_5A90

Jump_073_5A85::
    pop hl
    ld a, $05
    add a, l
    ld l, a
    jr nc, Jump_073_5A8D
    inc h

Jump_073_5A8D::
    dec b
    jr nz, Jump_073_5A68

Jump_073_5A90::
    ld a, $03
    ld [$C92A], a
    ld a, $40
    ld [$C928], a
    jr Jump_073_5AA6

Jump_073_5A9C::
    ld a, $01
    ld [$C92A], a
    ld a, $60
    ld [$C928], a

Jump_073_5AA6::
    xor a, a
    ld [$C929], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld a, $80
    ld [$C919], a
    ret

Func_073_5ABB::
    xor a, a
    ldh [$FFC6], a
    ld a, $30
    ldh [$FFC7], a
    ld hl, $6BF8
    ld b, $5F
    rst $10
    ldh a, [$FFC6]
    or a, a
    ret z
    xor a, a
    ld [$CB7D], a
    ld a, $80
    ld [$C919], a
    ret

Func_073_5AD6::
    ld a, [$CC3B]
    set 2, a
    ld [$CC3B], a
    ld a, $80
    ld [$C919], a
    ret

Func_073_5AE4::
    ld a, [$C923]
    rst $00
    dw Jump_073_5C1F
    dw Jump_073_5BAE
    dw Func_073_5B66
    dw Jump_073_5B47
    dw Jump_073_5AF2

Jump_073_5AF2::
    xor a, a
    ldh [$FFC6], a
    ld a, $20
    ldh [$FFC7], a
    ld hl, $6BF8
    ld b, $5F
    rst $10
    ldh a, [$FFC6]
    or a, a
    ret z
    xor a, a
    ld [$CB7D], a
    ld a, [$CC3B]
    set 1, a
    ld [$CC3B], a
    ld a, $66
    call Func_000_1278
    ld hl, $C19A
    ld [hl], $56
    inc hl
    ld [hl], $57
    inc hl
    ld [hl], $57
    inc hl
    ld [hl], $58
    inc hl
    ld a, $10
    add a, l
    ld l, a
    jr nc, Jump_073_5B2A
    inc h

Jump_073_5B2A::
    ld [hl], $59
    inc hl
    ld [hl], $5A
    inc hl
    ld [hl], $5A
    inc hl
    ld [hl], $5B
    ld hl, $6DDB
    ld b, $5F
    rst $10
    ld de, $00B1
    call Func_000_1845
    ld a, $80
    ld [$C919], a
    ret

Jump_073_5B47::
    ld a, $00
    ld [$C929], a
    ld a, $02
    ld [$C92A], a
    ld a, $20
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld hl, $C923
    inc [hl]
    ret

Func_073_5B66::
    ld a, [$C922]
    or a, a
    jr nz, Jump_073_5B72
    ld hl, $CB8B
    inc [hl]
    jr Jump_073_5B88

Jump_073_5B72::
    dec a
    jr nz, Jump_073_5B7B
    ld hl, $CB8A
    inc [hl]
    jr Jump_073_5B88

Jump_073_5B7B::
    dec a
    jr nz, Jump_073_5B84
    ld hl, $CB8B
    dec [hl]
    jr Jump_073_5B88

Jump_073_5B84::
    ld hl, $CB8A
    dec [hl]

Jump_073_5B88::
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $10
    ret nz
    xor a, a
    ld [$C921], a
    ld a, [$CB8B]
    cp a, $30
    jr nz, Jump_073_5BA9
    ld a, [$CB8A]
    cp a, $80
    jr nz, Jump_073_5BA9
    ld hl, $C923
    inc [hl]
    ret

Jump_073_5BA9::
    ld hl, $C923
    dec [hl]
    ret

Jump_073_5BAE::
    ld a, [$C924]
    ld d, a
    ld a, [$CB8A]
    add a, d
    ld b, a
    ld a, [$C925]
    ld d, a
    ld a, [$CB8B]
    add a, d
    ld c, a
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
    jr nc, Jump_073_5BD1
    inc h

Jump_073_5BD1::
    add hl, hl
    add hl, hl
    ld a, b
    srl a
    srl a
    srl a
    add a, l
    ld l, a
    jr nc, Jump_073_5BDF
    inc h

Jump_073_5BDF::
    ld de, $C198
    add hl, de
    ld de, $C910
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    ld a, $13
    inc de
    add a, l
    ld l, a
    jr nc, Jump_073_5BF3
    inc h

Jump_073_5BF3::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    dec de
    dec de
    dec de
    ld b, $04

Jump_073_5BFD::
    ld a, [de]
    inc de
    ld c, a
    ld a, [$C192]
    cp a, c
    jr c, Jump_073_5C08
    jr Jump_073_5C13

Jump_073_5C08::
    dec b
    jr nz, Jump_073_5BFD
    call Func_073_5B66
    ld hl, $C923
    inc [hl]
    ret

Jump_073_5C13::
    ld hl, $CB8C
    call Func_073_7A4C
    ld a, $80
    ld [$C919], a
    ret

Jump_073_5C1F::
    ldh a, [$FF8E]
    swap a
    and a, $0F
    sub a, $05
    and a, $03
    sla a
    sla a
    ld hl, $5C4F
    add a, l
    ld l, a
    jr nc, Jump_073_5C35
    inc h

Jump_073_5C35::
    ld a, [hl+]
    ld [$C922], a
    ld [$CB86], a
    ld a, [hl+]
    ld [$C924], a
    ld a, [hl]
    ld [$C925], a
    ld hl, $CB8C
    call Func_073_7A47
    ld hl, $C923
    inc [hl]
    ret
    db $03, $F0, $00, $00, $02, $00, $F0, $00, $00, $00, $10, $00, $01, $10, $00, $00

Func_073_5C5F::
    ldh a, [$FF8E]
    cp a, $30
    jr nz, Jump_073_5C8D
    ldh a, [$FF91]
    cp a, $30
    jr nz, Jump_073_5C7F
    ld hl, $C1EA
    call Func_073_5D09
    ld hl, $C28A
    call Func_073_5D09
    ld hl, $C298
    call Func_073_5D09
    jr Jump_073_5CAD

Jump_073_5C7F::
    ld hl, $C28A
    call Func_073_5D09
    ld hl, $C298
    call Func_073_5D09
    jr Jump_073_5CAD

Jump_073_5C8D::
    ldh a, [$FF91]
    cp a, $30
    jr nz, Jump_073_5CA1
    ld hl, $C1F8
    call Func_073_5D09
    ld hl, $C28A
    call Func_073_5D09
    jr Jump_073_5CAD

Jump_073_5CA1::
    ld hl, $C1F8
    call Func_073_5D09
    ld hl, $C298
    call Func_073_5D09

Jump_073_5CAD::
    ld a, [$C1EA]
    cp a, $10
    jr nz, Jump_073_5CFD
    ld a, [$C1F8]
    cp a, $10
    jr nz, Jump_073_5CFD
    ld a, [$C28A]
    cp a, $10
    jr nz, Jump_073_5CFD
    ld a, [$C298]
    cp a, $10
    jr nz, Jump_073_5CFD
    ld a, $66
    call Func_000_1278
    ld hl, $C1C8
    ld [hl], $46
    inc hl
    ld [hl], $47
    inc hl
    ld [hl], $47
    inc hl
    ld [hl], $48
    inc hl
    ld a, $10
    add a, l
    ld l, a
    jr nc, Jump_073_5CE4
    inc h

Jump_073_5CE4::
    ld [hl], $49
    inc hl
    ld [hl], $4A
    inc hl
    ld [hl], $4A
    inc hl
    ld [hl], $4B
    ld a, [$CC3B]
    set 0, a
    ld [$CC3B], a
    ld de, $00B0
    call Func_000_1845

Jump_073_5CFD::
    ld hl, $6DDB
    ld b, $5F
    rst $10
    ld a, $80
    ld [$C919], a
    ret

Func_073_5D09::
    push hl
    call Func_073_5D48
    call Func_073_5D48
    call Func_073_5D48
    call Func_073_5D48
    pop hl
    ld a, [$C525]
    or a, a
    ret z
    ld c, $04
    ld a, [hl]
    cp a, $18
    ld c, $05
    ld a, l
    sub a, $98
    ld l, a
    ld a, h
    sbc a, $C1
    ld h, a
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $D0
    ld h, a
    ld a, $02
    ldh [$FF70], a
    call Func_073_5D65
    call Func_073_5D65
    call Func_073_5D65
    call Func_073_5D65
    ld a, $00
    ldh [$FF70], a
    ret

Func_073_5D48::
    ld a, [hl]
    add a, $08
    cp a, $28
    jr c, Jump_073_5D51
    sub a, $18

Jump_073_5D51::
    ld [hl+], a
    ld a, [hl]
    add a, $08
    cp a, $28
    jr c, Jump_073_5D5B
    sub a, $18

Jump_073_5D5B::
    ld [hl-], a
    ld a, $14
    add a, l
    ld l, a
    jr nc, Jump_073_5D63
    inc h

Jump_073_5D63::
    ld a, [hl]
    ret

Func_073_5D65::
    ld a, c
    ld [hl+], a
    ld [hl-], a
    ld a, $14
    add a, l
    ld l, a
    jr nc, Jump_073_5D6F
    inc h

Jump_073_5D6F::
    ld a, [hl]
    ret

Func_073_5D71:: ; heuristic: follows a terminator; C0
    xor a, a
    ldh [$FFC6], a
    ld a, $20
    ldh [$FFC7], a
    ldh a, [$FF90]
    cp a, $8C
    jr z, Jump_073_5D88
    ldh a, [$FF8F]
    cp a, $01
    jr nz, Jump_073_5D88
    ld a, $50
    ldh [$FFC7], a

Jump_073_5D88::
    ld hl, $6BF8
    ld b, $5F
    rst $10
    ldh a, [$FFC6]
    or a, a
    ret z
    xor a, a
    ld [$CB7D], a
    ld a, $80
    ld [$C919], a
    ld de, $00C5
    ldh a, [$FF90]
    cp a, $8C
    jr z, Jump_073_5DAB
    inc de
    ldh a, [$FF8F]
    or a, a
    jr z, Jump_073_5DAB
    inc de

Jump_073_5DAB::
    call Func_000_1845
    ret

Func_073_5DAF::
    ld a, [$C923]
    or a, a
    jr nz, Jump_073_5DD7
    ld a, $82
    ldh [$FF90], a
    ld a, $01
    ldh [$FF8F], a
    ld a, $02
    ldh [$FF92], a
    ld a, $40
    ld [$C8C8], a
    ld a, $80
    ld [$C8C9], a
    ld a, $03
    ld [$C8C6], a
    ld hl, $6C5A
    ld b, $5F
    rst $10
    ret

Jump_073_5DD7::
    ld a, $80
    ld [$C919], a
    ret

Func_073_5DDD::
    ld a, [$C923]
    rst $00
    dw Jump_073_5E97
    dw Jump_073_5E51
    dw Jump_073_5E11
    dw Jump_073_5DF8
    dw Jump_073_5DED
    dw Func_073_7AD0

Jump_073_5DED::
    ld hl, $0433
    call Func_073_7AA5
    ld hl, $C923
    inc [hl]
    ret

Jump_073_5DF8::
    xor a, a
    ldh [$FF92], a
    ld a, $40
    ld [$C8C8], a
    ld a, $30
    ld [$C8C9], a
    ld a, $03
    ld [$C8C6], a
    ld hl, $6C5A
    ld b, $5F
    rst $10
    ret

Jump_073_5E11::
    ld hl, $CB8A
    inc [hl]
    ld a, [$C921]
    and a, $01
    jr nz, Jump_073_5E20
    ld hl, $CB8A
    inc [hl]

Jump_073_5E20::
    ld hl, $C921
    inc [hl]
    call Func_073_5E73
    add a, $10
    ldh [$FF91], a
    ld [$C8F1], a
    ld [$C8F6], a
    ld [$C8FB], a
    ld a, [$CB8A]
    ldh [$FF8E], a
    ld [$C8F0], a
    ld [$C8F5], a
    ld [$C8FA], a
    ld a, [$CB8B]
    cp a, $C0
    ret c
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_5E51::
    ld hl, $CB8A
    inc [hl]
    ld a, [$C921]
    and a, $01
    jr nz, Jump_073_5E60
    ld hl, $CB8A
    inc [hl]

Jump_073_5E60::
    ld hl, $C921
    inc [hl]
    call Func_073_5E73
    cp a, $70
    ret nz
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Func_073_5E73::
    ld a, [$C924]
    ld l, a
    ld a, [$C925]
    ld h, a
    ld a, l
    sub a, $18
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld a, l
    ld [$C924], a
    ld a, h
    ld [$C925], a
    ld a, [$C925]
    ld h, a
    ld a, [$CB8B]
    add a, h
    ld [$CB8B], a
    ret

Jump_073_5E97::
    ld b, $3C
    call Func_073_7A2B
    ret nc
    ld hl, $CB8C
    call Func_073_7A47
    ld hl, $05C0
    ld a, l
    ld [$C924], a
    ld a, h
    ld [$C925], a
    ld hl, $C923
    inc [hl]
    ret

Func_073_5EB3::
    ld a, [$C923]
    rst $00
    dw Jump_073_5F1D
    dw Jump_073_5EDF
    dw Jump_073_5EBD

Jump_073_5EBD::
    ld hl, $CB8A
    dec [hl]
    ld hl, $C921
    inc [hl]
    call Func_073_5EF9
    add a, $10
    ld [$CB9B], a
    ld a, [$CB8A]
    ld [$CB9A], a
    ld a, [$CB8A]
    cp a, $E0
    ret nz
    ld a, $80
    ld [$C919], a
    ret

Jump_073_5EDF::
    ld hl, $CB8A
    dec [hl]
    ld hl, $C921
    inc [hl]
    call Func_073_5EF9
    ld a, [$CB8A]
    cp a, $40
    ret nz
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Func_073_5EF9::
    ld a, [$C924]
    ld l, a
    ld a, [$C925]
    ld h, a
    ld a, l
    sub a, $10
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld a, l
    ld [$C924], a
    ld a, h
    ld [$C925], a
    ld a, [$C925]
    ld h, a
    ld a, [$CB8B]
    add a, h
    ld [$CB8B], a
    ret

Jump_073_5F1D::
    ld b, $3C
    call Func_073_7A2B
    ret nc
    ld hl, $CB8C
    call Func_073_7A47
    ld hl, $03C0
    ld a, l
    ld [$C924], a
    ld a, h
    ld [$C925], a
    ld hl, $C923
    inc [hl]
    ret

Func_073_5F39::
    ld hl, $C26A
    ld [hl], $68
    inc hl
    ld [hl], $69
    ld hl, $C27E
    ld [hl], $6A
    inc hl
    ld [hl], $6B
    ld hl, $6DDB
    ld b, $5F
    rst $10
    ld a, $80
    ld [$C919], a
    ret

Func_073_5F55:: ; heuristic: follows a terminator; C0
    ld a, $00
    ldh [$FFC7], a
    ld a, [$D7F5]
    ldh [$FFC8], a
    ld a, $02
    ldh [$FFC9], a
    ld hl, $6E46
    ld b, $01
    rst $10
    ld hl, $C6FD
    inc [hl]
    ld a, [$C6FD]
    dec a
    ld c, a
    add a, a
    add a, a
    add a, c
    ld hl, $C8EF
    add a, l
    ld l, a
    jr nc, Jump_073_5F7C
    inc h

Jump_073_5F7C::
    ld a, [$CBB6]
    ld [hl+], a
    ld a, [$CBBA]
    ld [hl+], a
    ld a, [$CBBB]
    ld [hl], a
    ld a, [$C6FD]
    dec a
    ld hl, $C6FE
    add a, l
    ld l, a
    jr nc, Jump_073_5F94
    inc h

Jump_073_5F94::
    ld a, [$D7F5]
    ld [hl], a
    ld hl, $5E85
    ld b, $02
    rst $10
    ld hl, $5E85
    ld b, $02
    rst $10
    call Func_000_222B
    ld hl, $4AA8
    ld b, $04
    rst $10
    ld a, $7F
    ld [$C527], a
    ld hl, $CB7D
    dec [hl]
    ld a, $80
    ld [$C919], a
    ret

Func_073_5FBC::
    ld a, [$C923]
    rst $00
    dw Jump_073_5FE4
    dw Jump_073_5FC4

Jump_073_5FC4::
    ld a, $80
    ld [$CBCF], a
    ld a, [$C921]
    and a, $03
    jr nz, Jump_073_5FD4
    ld hl, $CBD4
    dec [hl]

Jump_073_5FD4::
    ld b, $5A
    call Func_073_7A2B
    ret nc
    xor a, a
    ld [$CBCF], a
    ld a, $80
    ld [$C919], a
    ret

Jump_073_5FE4::
    ld a, $11
    ldh [$FFC6], a
    ld hl, $6B98
    ld b, $12
    rst $10
    ld hl, $6020
    ld de, $00D1
    call Func_000_181B
    jr nc, Jump_073_5FFC
    ld hl, $602C

Jump_073_5FFC::
    ldh a, [$FF90]
    ld c, a

Jump_073_5FFF::
    push hl
    ld a, [hl]
    cp a, c
    jr nz, Jump_073_601B
    inc hl
    ld a, [hl]
    and a, $F0
    ld [$CBD3], a
    ld a, [hl]
    and a, $0F
    swap a
    add a, $F8
    ld [$CBD4], a
    pop hl
    ld hl, $C923
    inc [hl]
    ret

Jump_073_601B::
    pop hl
    inc hl
    inc hl
    jr Jump_073_5FFF
    db $06, $31, $12, $44, $00, $63, $02, $24, $16, $53, $1A, $43, $06, $31, $12, $44
    db $00, $53, $02, $24, $16, $42, $1A, $43

Func_073_6038::
    ld a, [$C923]
    rst $00
    dw Jump_073_604F
    dw Jump_073_6040

Jump_073_6040::
    ld a, [$C921]
    and a, $01
    jr z, Jump_073_604B
    ld hl, $CB8B
    inc [hl]

Jump_073_604B::
    call Func_073_4E9C
    ret

Jump_073_604F::
    ld hl, $CB8C
    call Func_073_7A3D
    ld b, $1E
    call Func_073_7A2B
    ret nc
    xor a, a
    ld [$CB86], a
    ld hl, $C923
    inc [hl]
    ld de, $0098
    call Func_000_181B
    jr c, Jump_073_6072
    ld de, $0098
    call Func_000_1845
    ret

Jump_073_6072::
    ld de, $0099
    call Func_000_1845
    ret

Func_073_6079::
    ld a, [$C923]
    rst $00
    dw Jump_073_60CD
    dw Jump_073_60A7
    dw Jump_073_6083

Jump_073_6083::
    ld b, $78
    call Func_073_7A2B
    ret nc
    ld a, $40
    ld [$CBAB], a
    ld a, $50
    ld [$CB9B], a
    xor a, a
    ld [$CBCF], a
    ld a, $03
    ld [$CB7D], a
    ld a, $00
    call Func_000_1278
    ld a, $80
    ld [$C919], a
    ret

Jump_073_60A7::
    ld a, [$CBAB]
    inc a
    inc a
    ld [$CBAB], a
    ld a, [$CB9B]
    dec a
    dec a
    ld [$CB9B], a
    cp a, $48
    ret nz
    xor a, a
    ld [$CB7D], a
    ld a, $80
    ld [$CBCF], a
    ld a, $7D
    call Func_000_1278
    ld hl, $C923
    inc [hl]
    ret

Jump_073_60CD::
    ld a, [$C921]
    inc a
    ld [$C921], a
    and a, $03
    ret nz
    ld hl, $CBAB
    dec [hl]
    ld a, [$CB9B]
    inc a
    ld [$CB9B], a
    cp a, $58
    ret nz
    ld a, $0C
    ldh [$FFC6], a
    ld hl, $6B98
    ld b, $12
    rst $10
    ld a, $40
    ld [$CBD3], a
    ld a, $48
    ld [$CBD4], a
    ld hl, $C923
    inc [hl]
    ret

Func_073_60FE::
    ld a, [$C5F0]
    bit 2, a
    jr z, Jump_073_610C
    ld a, $01
    ld [$CB7D], a
    jr Jump_073_6111

Jump_073_610C::
    ld a, $02
    ld [$CB7D], a

Jump_073_6111::
    ld a, [$CB9B]
    inc a
    ld [$CB9B], a
    cp a, $70
    ret nz
    ld a, $02
    ld [$CB7D], a
    ld a, $80
    ld [$C919], a
    ret

Func_073_6126::
    ld a, [$C923]
    rst $00
    dw Jump_073_618F
    dw Jump_073_6188
    dw Jump_073_6181
    dw Jump_073_6132

Jump_073_6132::
    ld a, [$C925]
    swap a
    and a, $0F
    sla a
    ld l, a
    ld e, a
    ld h, $00
    ld d, $00
    add hl, hl
    add hl, hl
    add hl, de
    add hl, hl
    add hl, hl
    ld a, [$C924]
    swap a
    and a, $0F
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_073_6153
    inc h

Jump_073_6153::
    ld a, l
    add a, $98
    ld l, a
    ld a, h
    adc a, $C1
    ld h, a
    push hl
    ld [hl], $44
    inc hl
    ld [hl], $45
    ld a, $13
    add a, l
    ld l, a
    jr nc, Jump_073_6168
    inc h

Jump_073_6168::
    ld [hl], $46
    inc hl
    ld [hl], $47
    pop hl
    ld hl, $6DDB
    ld b, $5F
    rst $10
    xor a, a
    ldh [$FF8D], a
    xor a, a
    ld [$C195], a
    ld a, $80
    ld [$C919], a
    ret

Jump_073_6181::
    ld hl, $5B9A
    ld b, $12
    rst $10
    ret

Jump_073_6188::
    ld hl, $5C27
    ld b, $12
    rst $10
    ret

Jump_073_618F::
    ld a, $10
    ld [$C195], a
    ld hl, $5C31
    ld b, $12
    rst $10
    ret

Func_073_619B:: ; heuristic: follows a terminator; C0
    ld a, $10
    ld [$C195], a
    ld hl, $61EF
    ld b, $12
    rst $10
    ret

Func_073_61A7::
    ld a, [$C923]
    rst $00
    dw Jump_073_62D7
    dw Jump_073_62B0
    dw Jump_073_628C
    dw Jump_073_625D
    dw Jump_073_6252
    dw Jump_073_622D
    dw Jump_073_7AC6
    dw Jump_073_620B
    dw Jump_073_7AC6
    dw Jump_073_61BF

Jump_073_61BF::
    ld a, $80
    ld [$C919], a
    ldh a, [$FF98]
    inc a
    inc a
    and a, $03
    ld [$CB96], a
    ld de, $0191
    call Func_000_181B
    jr c, Jump_073_61EC
    ld a, [$C634]
    cp a, $FF
    jr z, Jump_073_61E0
    or a, a
    jr z, Jump_073_61E0
    ret

Jump_073_61E0::
    ld a, $2C
    ld [$C928], a
    ld hl, $6C8C
    ld b, $5F
    rst $10
    ret

Jump_073_61EC::
    ld hl, $6990
    ld b, $12
    rst $10
    ld a, $04
    ldh [$FFC7], a
    ld hl, $6955
    ld b, $12
    rst $10
    ld a, [$C836]
    set 7, a
    ld [$C836], a
    ld de, $0135
    call Func_000_1845
    ret

Jump_073_620B::
    ld de, $0191
    call Func_000_181B
    jr c, Jump_073_6218
    ld hl, $0D3F
    jr Jump_073_621B

Jump_073_6218::
    ld hl, $0D4B

Jump_073_621B::
    call Func_073_7AA5
    ld a, $00
    ld [$CB96], a
    ld a, $02
    ld [$CBB6], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_622D::
    ld a, [$C921]
    swap a
    and a, $01
    add a, a
    inc a
    ld [$CBB6], a
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $78
    ret nz
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ld hl, $0D3E
    call Func_073_7AA5
    ret

Jump_073_6252::
    ld b, $3C
    call Func_073_7A2B
    ret nc
    ld hl, $C923
    inc [hl]
    ret

Jump_073_625D::
    ld a, [$C924]
    ld l, a
    ld a, [$C925]
    ld h, a
    ld a, [$C937]
    ld [hl+], a
    ld a, [$C938]
    ld [hl+], a
    ld a, [$C939]
    ld [hl], a
    ld hl, $00B9
    ld a, l
    ldh [$FFC6], a
    ld a, h
    ldh [$FFC7], a
    ld hl, $6D3F
    ld b, $5F
    rst $10
    xor a, a
    ldh [$FF8D], a
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_628C::
    ld a, [$C924]
    ld l, a
    ld a, [$C925]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp a, $50
    jr z, Jump_073_62A2
    inc a
    ld [hl], a
    dec hl
    dec hl
    ld [hl], $00
    ret

Jump_073_62A2::
    dec hl
    dec hl
    ld [hl], $01
    ld a, $50
    ld [$CBBB], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_62B0::
    ld a, [$C924]
    ld l, a
    ld a, [$C925]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp a, $40
    jr z, Jump_073_62C6
    inc a
    ld [hl], a
    dec hl
    dec hl
    ld [hl], $00
    ret

Jump_073_62C6::
    dec hl
    ld a, [hl]
    cp a, $20
    jr z, Jump_073_62D2
    dec a
    ld [hl], a
    dec hl
    ld [hl], $03
    ret

Jump_073_62D2::
    ld hl, $C923
    inc [hl]
    ret

Jump_073_62D7::
    ld hl, $00B9
    ld a, l
    ldh [$FFC6], a
    ld a, h
    ldh [$FFC7], a
    ld hl, $7D95
    ld b, $12
    rst $10
    ldh a, [$FFC6]
    ld c, a
    sla a
    sla a
    add a, c
    ld hl, $C8EF
    add a, l
    ld l, a
    jr nc, Jump_073_62F6
    inc h

Jump_073_62F6::
    ld a, l
    ld [$C924], a
    ld a, h
    ld [$C925], a
    ld a, [hl+]
    ld [$C937], a
    ld a, [hl+]
    ld [$C938], a
    ld a, [hl]
    ld [$C939], a
    ld hl, $C923
    inc [hl]
    ret

Func_073_630F::
    ld a, [$C923]
    rst $00
    dw Jump_073_653D
    dw Jump_073_651C
    dw Jump_073_64FF
    dw Jump_073_64DC
    dw Jump_073_64BA
    dw Jump_073_649E
    dw Jump_073_647A
    dw Jump_073_651C
    dw Jump_073_645D
    dw Jump_073_64DC
    dw Jump_073_64BA
    dw Jump_073_6441
    dw Jump_073_647A
    dw Jump_073_640A
    dw Jump_073_63FF
    dw Jump_073_63DA
    dw Jump_073_7AC6
    dw Jump_073_6387
    dw Jump_073_7AC6
    dw Jump_073_633B

Jump_073_633B::
    ld a, $80
    ld [$C919], a
    ldh a, [$FF98]
    inc a
    inc a
    and a, $03
    ld [$CB86], a
    ld de, $0134
    call Func_000_181B
    jr c, Jump_073_6368
    ld a, [$C634]
    cp a, $FF
    jr z, Jump_073_635C
    or a, a
    jr z, Jump_073_635C
    ret

Jump_073_635C::
    ld a, $2C
    ld [$C928], a
    ld hl, $6C8C
    ld b, $5F
    rst $10
    ret

Jump_073_6368::
    ld hl, $6990
    ld b, $12
    rst $10
    ld a, $04
    ldh [$FFC7], a
    ld hl, $6955
    ld b, $12
    rst $10
    ld a, [$C836]
    set 7, a
    ld [$C836], a
    ld de, $0135
    call Func_000_1845
    ret

Jump_073_6387::
    ld de, $0134
    call Func_000_181B
    jr c, Jump_073_6394
    ld hl, $0D46
    jr Jump_073_6397

Jump_073_6394::
    ld hl, $0D16

Jump_073_6397::
    call Func_073_7AA5
    ld hl, $C923
    inc [hl]
    ld a, [$CB9A]
    cp a, $50
    jr nz, Jump_073_63B0
    ld a, $03
    ld [$CB86], a
    ld a, $01
    ld [$CB96], a
    ret

Jump_073_63B0::
    cp a, $70
    jr nz, Jump_073_63BF
    ld a, $01
    ld [$CB86], a
    ld a, $03
    ld [$CB96], a
    ret

Jump_073_63BF::
    ld a, [$CB9B]
    cp a, $20
    jr nz, Jump_073_63D0
    ld a, $02
    ld [$CB86], a
    xor a, a
    ld [$CB96], a
    ret

Jump_073_63D0::
    xor a, a
    ld [$CB86], a
    ld a, $02
    ld [$CB96], a
    ret

Jump_073_63DA::
    ld a, [$C921]
    swap a
    and a, $01
    add a, a
    inc a
    ld [$CB96], a
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $78
    ret nz
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ld hl, $0D15
    call Func_073_7AA5
    ret

Jump_073_63FF::
    ld b, $3C
    call Func_073_7A2B
    ret nc
    ld hl, $C923
    inc [hl]
    ret

Jump_073_640A::
    ld a, [$C924]
    ld l, a
    ld a, [$C925]
    ld h, a
    ld a, [$C937]
    ld [hl+], a
    ld a, [$C938]
    ld [hl+], a
    ld a, [$C939]
    ld [hl], a
    ld hl, $005A
    ld a, l
    ldh [$FFC6], a
    ld a, h
    ldh [$FFC7], a
    ld hl, $6D3F
    ld b, $5F
    rst $10
    xor a, a
    ldh [$FF8D], a
    xor a, a
    ld [$CB96], a
    ld hl, $CB7D
    inc [hl]
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_6441::
    ld a, [$C924]
    ld l, a
    ld a, [$C925]
    ld h, a
    inc hl
    ld a, [hl]
    cp a, $50
    jr nz, Jump_073_6459
    ld a, $50
    ld [$CB9A], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_6459::
    call Func_073_65A4
    ret

Jump_073_645D::
    ld a, [$C924]
    ld l, a
    ld a, [$C925]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp a, $20
    jr nz, Jump_073_6476
    ld a, $20
    ld [$CB9B], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_6476::
    call Func_073_659D
    ret

Jump_073_647A::
    ld a, [$C924]
    ld l, a
    ld a, [$C925]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp a, $30
    jr nz, Jump_073_6494
    ld a, $30
    ld [$CB9B], a
    ld a, $0D
    ld [$C923], a
    ret

Jump_073_6494::
    jr nc, Jump_073_649A
    call Func_073_6596
    ret

Jump_073_649A::
    call Func_073_659D
    ret

Jump_073_649E::
    ld a, [$C924]
    ld l, a
    ld a, [$C925]
    ld h, a
    inc hl
    ld a, [hl]
    cp a, $70
    jr nz, Jump_073_64B6
    ld a, $70
    ld [$CB9A], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_64B6::
    call Func_073_65AA
    ret

Jump_073_64BA::
    ld a, [$C924]
    ld l, a
    ld a, [$C925]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp a, $20
    jr nz, Jump_073_64CE

Jump_073_64C9::
    ld hl, $C923
    inc [hl]
    ret

Jump_073_64CE::
    cp a, $40
    jr z, Jump_073_64C9
    jr nc, Jump_073_64D8
    call Func_073_6596
    ret

Jump_073_64D8::
    call Func_073_659D
    ret

Jump_073_64DC::
    ld a, [$C924]
    ld l, a
    ld a, [$C925]
    ld h, a
    inc hl
    ld a, [hl]
    cp a, $60
    jr nz, Jump_073_64F5
    ld a, $60
    ld [$CB9A], a
    ld a, $0D
    ld [$C923], a
    ret

Jump_073_64F5::
    jr nc, Jump_073_64FB
    call Func_073_65AA
    ret

Jump_073_64FB::
    call Func_073_65A4
    ret

Jump_073_64FF::
    ld a, [$C924]
    ld l, a
    ld a, [$C925]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp a, $40
    jr nz, Jump_073_6518
    ld a, $40
    ld [$CB9B], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_6518::
    call Func_073_6596
    ret

Jump_073_651C::
    ld a, [$C924]
    ld l, a
    ld a, [$C925]
    ld h, a
    inc hl
    ld a, [hl]
    cp a, $70
    jr nz, Jump_073_652F

Jump_073_652A::
    ld hl, $C923
    inc [hl]
    ret

Jump_073_652F::
    cp a, $50
    jr z, Jump_073_652A
    jr nc, Jump_073_6539
    call Func_073_65AA
    ret

Jump_073_6539::
    call Func_073_65A4
    ret

Jump_073_653D::
    ld hl, $005A
    ld a, l
    ldh [$FFC6], a
    ld a, h
    ldh [$FFC7], a
    ld hl, $7D95
    ld b, $12
    rst $10
    ldh a, [$FFC6]
    ld c, a
    sla a
    sla a
    add a, c
    ld hl, $C8EF
    add a, l
    ld l, a
    jr nc, Jump_073_655C
    inc h

Jump_073_655C::
    ld a, l
    ld [$C924], a
    ld a, h
    ld [$C925], a
    ld a, [hl+]
    ld [$C937], a
    ld a, [hl+]
    ld [$C938], a
    ld a, [hl]
    ld [$C939], a
    ld hl, $CB7D
    dec [hl]
    ldh a, [$FF98]
    or a, a
    jr nz, Jump_073_657E
    ld hl, $C923
    inc [hl]
    ret

Jump_073_657E::
    dec a
    jr nz, Jump_073_6587
    ld a, $04
    ld [$C923], a
    ret

Jump_073_6587::
    dec a
    jr nz, Jump_073_6590
    ld a, $07
    ld [$C923], a
    ret

Jump_073_6590::
    ld a, $0A
    ld [$C923], a
    ret

Func_073_6596::
    inc a
    ld [hl], a
    dec hl
    dec hl
    ld [hl], $00
    ret

Func_073_659D::
    dec a
    ld [hl], a
    dec hl
    dec hl
    ld [hl], $02
    ret

Func_073_65A4::
    dec a
    ld [hl], a
    dec hl
    ld [hl], $03
    ret

Func_073_65AA::
    inc a
    ld [hl], a
    dec hl
    ld [hl], $01
    ret

Func_073_65B0::
    ld a, [$C923]
    rst $00
    dw Jump_073_6729
    dw Jump_073_6705
    dw Jump_073_66EA
    dw Jump_073_66D1
    dw Jump_073_66B6
    dw Jump_073_6688
    dw Jump_073_666A
    dw Jump_073_66D1
    dw Jump_073_664F
    dw Jump_073_6618
    dw Jump_073_65ED
    dw Jump_073_65CC

Jump_073_65CC::
    ld de, $CB8B
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, $6BCD
    ld b, $5F
    rst $10
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $20
    ret nz
    ld a, $80
    ld [$C919], a
    ret

Jump_073_65ED::
    ld a, [$C924]
    ld l, a
    ld a, [$C925]
    ld h, a
    ld a, [$C937]
    ld [hl+], a
    ld a, [$C938]
    ld [hl+], a
    ld a, [$C939]
    ld [hl], a
    ld hl, $0002
    ld a, l
    ldh [$FFC6], a
    ld a, h
    ldh [$FFC7], a
    ld hl, $6D3F
    ld b, $5F
    rst $10
    xor a, a
    ldh [$FF8D], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_6618::
    ld a, [$C924]
    ld l, a
    ld a, [$C925]
    ld h, a
    inc hl
    ld a, [hl]
    cp a, $40
    jr nz, Jump_073_6641
    dec hl
    ld [hl], $02
    ld a, $02
    ld [$CB86], a
    ld a, $40
    ld [$CB8A], a
    ld a, $50
    ld [$CB8B], a
    ld a, $0E
    ldh [$FF8D], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_6641::
    jr nc, Jump_073_6649
    inc a
    ld [hl], a
    dec hl
    ld [hl], $01
    ret

Jump_073_6649::
    dec a
    ld [hl], a
    dec hl
    ld [hl], $03
    ret

Jump_073_664F::
    ld a, [$C924]
    ld l, a
    ld a, [$C925]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp a, $50
    jr nz, Jump_073_6663
    ld hl, $C923
    inc [hl]
    ret

Jump_073_6663::
    inc a
    ld [hl], a
    dec hl
    dec hl
    ld [hl], $00
    ret

Jump_073_666A::
    ld a, [$C924]
    ld l, a
    ld a, [$C925]
    ld h, a
    inc hl
    ld a, [hl]
    cp a, $40
    jr z, Jump_073_667C
    cp a, $50
    jr nz, Jump_073_6682

Jump_073_667C::
    ld a, $07
    ld [$C923], a
    ret

Jump_073_6682::
    ld a, $08
    ld [$C923], a
    ret

Jump_073_6688::
    ld a, [$C924]
    ld l, a
    ld a, [$C925]
    ld h, a
    inc hl
    ld a, [hl]
    cp a, $40
    jr nz, Jump_073_66A8
    dec hl
    ld [hl], $00
    ld a, $40
    ld [$CB8A], a
    ld a, $0E
    ldh [$FF8D], a
    ld a, $0A
    ld [$C923], a
    ret

Jump_073_66A8::
    jr nc, Jump_073_66B0
    inc a
    ld [hl], a
    dec hl
    ld [hl], $01
    ret

Jump_073_66B0::
    dec a
    ld [hl], a
    dec hl
    ld [hl], $03
    ret

Jump_073_66B6::
    ld a, [$C924]
    ld l, a
    ld a, [$C925]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp a, $30
    jr nz, Jump_073_66CA
    ld hl, $C923
    inc [hl]
    ret

Jump_073_66CA::
    dec a
    ld [hl], a
    dec hl
    dec hl
    ld [hl], $02
    ret

Jump_073_66D1::
    ld a, [$C924]
    ld l, a
    ld a, [$C925]
    ld h, a
    inc hl
    ld a, [hl]
    cp a, $60
    jr nz, Jump_073_66E4
    ld hl, $C923
    inc [hl]
    ret

Jump_073_66E4::
    inc a
    ld [hl], a
    dec hl
    ld [hl], $01
    ret

Jump_073_66EA::
    ld a, [$C924]
    ld l, a
    ld a, [$C925]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp a, $50
    jr nz, Jump_073_66FE
    ld hl, $C923
    inc [hl]
    ret

Jump_073_66FE::
    dec a
    ld [hl], a
    dec hl
    dec hl
    ld [hl], $02
    ret

Jump_073_6705::
    ld a, [$C924]
    ld l, a
    ld a, [$C925]
    ld h, a
    inc hl
    ld a, [hl]
    cp a, $40
    jr nz, Jump_073_6719
    ld a, $02
    ld [$C923], a
    ret

Jump_073_6719::
    cp a, $50
    jr nz, Jump_073_6723
    ld a, $03
    ld [$C923], a
    ret

Jump_073_6723::
    ld a, $04
    ld [$C923], a
    ret

Jump_073_6729::
    ld hl, $0002
    ld a, l
    ldh [$FFC6], a
    ld a, h
    ldh [$FFC7], a
    ld hl, $7D95
    ld b, $12
    rst $10
    ldh a, [$FFC6]
    ld c, a
    sla a
    sla a
    add a, c
    ld hl, $C8EF
    add a, l
    ld l, a
    jr nc, Jump_073_6748
    inc h

Jump_073_6748::
    ld a, l
    ld [$C924], a
    ld a, h
    ld [$C925], a
    ld a, [hl+]
    ld [$C937], a
    ld a, [hl+]
    ld [$C938], a
    ld a, [hl]
    ld [$C939], a
    ldh a, [$FF91]
    cp a, $50
    jr nz, Jump_073_6767

Jump_073_6762::
    ld hl, $C923
    inc [hl]
    ret

Jump_073_6767::
    ldh a, [$FF91]
    cp a, $30
    jr nz, Jump_073_6773

Jump_073_676D::
    ld a, $06
    ld [$C923], a
    ret

Jump_073_6773::
    ld hl, $C924
    inc hl
    inc hl
    ld a, [$C924]
    cp a, $40
    jr z, Jump_073_6783
    jr c, Jump_073_676D
    jr Jump_073_6762

Jump_073_6783::
    ld a, [$C6FD]
    ld b, a
    ld hl, $C8F0

Jump_073_678A::
    push hl
    ld a, [hl+]
    cp a, $40
    jr nz, Jump_073_6798
    ld a, [hl]
    cp a, $30
    jr nz, Jump_073_6798
    pop hl
    jr Jump_073_676D

Jump_073_6798::
    pop hl
    dec b
    jr nz, Jump_073_678A
    jr Jump_073_6762
    db $C9

Func_073_679F::
    ld a, [$C923]
    rst $00
    dw Jump_073_6927
    dw Jump_073_691C
    dw Jump_073_6910
    dw Jump_073_68B8
    dw Jump_073_691C
    dw Jump_073_691C
    dw Jump_073_6896
    dw Jump_073_691C
    dw Jump_073_6931
    dw Jump_073_6910
    dw Jump_073_683F
    dw Jump_073_691C
    dw Jump_073_691C
    dw Jump_073_6835
    dw Jump_073_691C
    dw Jump_073_6931
    dw Jump_073_6910
    dw Jump_073_67FC
    dw Jump_073_691C
    dw Jump_073_691C
    dw Jump_073_67D5
    dw Jump_073_67CF

Jump_073_67CF::
    ld a, $80
    ld [$C919], a
    ret

Jump_073_67D5::
    ld a, [$CC39]
    set 1, a
    ld [$CC39], a
    ld a, $40
    ldh [$FF90], a
    xor a, a
    ldh [$FF8F], a
    ldh [$FF92], a
    ldh a, [$FF8E]
    ld [$C8C8], a
    ld a, $40
    ld [$C8C9], a
    ld a, $03
    ld [$C8C6], a
    ld hl, $6C5A
    ld b, $5F
    rst $10
    ret

Jump_073_67FC::
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $14
    jr nz, Jump_073_680F
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]

Jump_073_680F::
    ld a, [$C921]
    bit 0, a
    jr z, Jump_073_6826
    ld de, $77D0
    ld b, $56
    call Func_073_6882
    ld de, $5ADB
    ld b, $56
    jp Func_073_6875

Jump_073_6826::
    ld de, $7827
    ld b, $56
    call Func_073_6882
    ld de, $5B8F
    ld b, $56
    jr Func_073_6875

Jump_073_6835::
    ld a, $05
    ldh [$FF8F], a
    ld a, $04
    ldh [$FF92], a
    jr Jump_073_689E

Jump_073_683F::
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $14
    jr nz, Jump_073_6852
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]

Jump_073_6852::
    ld a, [$C921]
    bit 0, a
    jr z, Jump_073_6868
    ld de, $7ABA
    ld b, $56
    call Func_073_6882
    ld de, $61F0
    ld b, $56
    jr Func_073_6875

Jump_073_6868::
    ld de, $6D99
    ld b, $56
    call Func_073_6882
    ld de, $4301
    ld b, $56

Func_073_6875::
    ld hl, $C198
    call Func_000_0CF5
    ld hl, $6DDB
    ld b, $5F
    rst $10
    ret

Func_073_6882::
    ld a, [$C525]
    or a, a
    ret z
    ld a, $02
    ldh [$FF70], a
    ld hl, $D000
    call Func_000_0CF5
    ld a, $00
    ldh [$FF70], a
    ret

Jump_073_6896::
    ld a, $06
    ldh [$FF8F], a
    ld a, $05
    ldh [$FF92], a

Jump_073_689E::
    ld a, $30
    ldh [$FF90], a
    ldh a, [$FF8E]
    ld [$C8C8], a
    ld a, $E0
    ld [$C8C9], a
    ld a, $03
    ld [$C8C6], a
    ld hl, $6C5A
    ld b, $5F
    rst $10
    ret

Jump_073_68B8::
    ld a, [$C921]
    ld b, a
    ld a, $06
    call Func_000_16BF
    add a, a
    add a, a
    ld hl, $68F8
    add a, l
    ld l, a
    jr nc, Jump_073_68CB
    inc h

Jump_073_68CB::
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld b, $58
    push hl
    call Func_073_6875
    pop hl
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld b, $58
    call Func_073_6882
    ld hl, $6DDB
    ld b, $5F
    rst $10
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $09
    ret nz
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret
    db $06, $47, $42, $4C, $FB, $47, $CB, $4C, $EE, $48, $3C, $4D, $FB, $47
    dw Func_073_4CCB
    dw Func_073_4706
    dw Func_073_4C42
    dw Func_073_45FF
    dw Func_073_4BB3

Jump_073_6910::
    ld a, $B4
    ld [$C928], a
    ld hl, $729C
    ld b, $0F
    rst $10
    ret

Jump_073_691C::
    ld b, $3C
    call Func_073_7A2B
    ret nc
    ld hl, $C923
    inc [hl]
    ret

Jump_073_6927::
    ld a, $02
    call Func_000_122D
    ld a, $70
    call Func_000_1278

Jump_073_6931::
    ld a, $48
    ld [$CB8A], a
    ld hl, $6E09
    ld b, $5F
    rst $10
    ld hl, $C923
    inc [hl]
    ret

Func_073_6941::
    ld a, $58
    ld [$C242], a
    ld a, $59
    ld [$C243], a
    ld a, $5A
    ld [$C256], a
    ld a, $5B
    ld [$C257], a
    ld hl, $6DDB
    ld b, $5F
    rst $10
    ld a, [$CC39]
    set 0, a
    ld [$CC39], a
    ld a, $80
    ld [$C919], a
    ret

Func_073_6969::
    ld a, [$C923]
    rst $00
    dw Jump_073_6A71
    dw Jump_073_6A2B
    dw Jump_073_6A0B
    dw Jump_073_69E3
    dw Jump_073_69C8
    dw Jump_073_69AB
    dw Jump_073_698E
    dw Jump_073_697F
    dw Func_073_4E9C

Jump_073_697F::
    ld a, [$C8FB]
    inc a
    ld [$C8FB], a
    cp a, $40
    ret nz
    ld hl, $C923
    inc [hl]
    ret

Jump_073_698E::
    ld a, [$C8F6]
    inc a
    ld [$C8F6], a
    cp a, $40
    ret nz
    ld a, $40
    ld [$C8FA], a
    ld a, $30
    ld [$C8FB], a
    xor a, a
    ld [$C8F9], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_69AB::
    ld a, [$C8F1]
    inc a
    ld [$C8F1], a
    cp a, $40
    ret nz
    ld a, $40
    ld [$C8F5], a
    ld a, $30
    ld [$C8F6], a
    xor a, a
    ld [$C8F4], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_69C8::
    ldh a, [$FF91]
    inc a
    ldh [$FF91], a
    cp a, $40
    ret nz
    ld a, $40
    ld [$C8F0], a
    ld a, $30
    ld [$C8F1], a
    xor a, a
    ld [$C8EF], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_69E3::
    ld a, [$C921]
    inc a
    ld [$C921], a
    and a, $01
    ret nz
    ld a, [$CB8B]
    inc a
    ld [$CB8B], a
    cp a, $30
    ret nz
    ld a, $40
    ldh [$FF8E], a
    ld a, $30
    ldh [$FF91], a
    xor a, a
    ldh [$FF98], a
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_6A0B::
    ld hl, $541B
    ld b, $02
    rst $10
    ld hl, $5BD7
    ld b, $02
    rst $10
    ld a, [$C468]
    bit 7, a
    ret nz
    xor a, a
    ld [$CB8B], a
    ld a, $01
    ld [$CB7D], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_6A2B::
    ld a, [$C921]
    inc a
    ld [$C921], a
    and a, $01
    ret nz
    ld a, [$CB8B]
    inc a
    ld [$CB8B], a
    cp a, $80
    ret nz
    ld a, $80
    ld [$C468], a
    ld a, $08
    ld [$C46A], a
    ld hl, $FF92
    inc [hl]
    ldh a, [$FF8C]
    or a, $01
    ldh [$FF8C], a
    ld hl, $FF80
    ld a, l
    ldh [$FF9D], a
    ld a, h
    ldh [$FF9E], a
    ld hl, $541B
    ld b, $02
    rst $10
    ld hl, $5BD7
    ld b, $02
    rst $10
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_6A71::
    ld a, $30
    ldh [$FF90], a
    ld a, $05
    ldh [$FF8F], a
    ldh [$FF92], a
    ld a, $E0
    ld [$C8C8], a
    ld a, $E0
    ld [$C8C9], a
    ld a, $03
    ld [$C8C6], a
    ld hl, $6C5A
    ld b, $5F
    rst $10
    ret

Func_073_6A91::
    ld a, [$C923]
    rst $00
    dw Jump_073_6A99
    dw Jump_073_6AB8

Jump_073_6A99::
    ld a, $36
    ldh [$FF90], a
    xor a, a
    ldh [$FF8F], a
    ldh [$FF92], a
    ld a, $40
    ld [$C8C8], a
    ld a, $80
    ld [$C8C9], a
    ld a, $03
    ld [$C8C6], a
    ld hl, $6C5A
    ld b, $5F
    rst $10
    ret

Jump_073_6AB8::
    ld a, $80
    ld [$C919], a
    ret

Func_073_6ABE::
    ld a, [$C923]
    or a, a
    jr nz, Jump_073_6AE9
    ld a, [$C923]
    or a, a
    jr nz, Jump_073_6AE9
    ld a, $3C
    ldh [$FF90], a
    xor a, a
    ldh [$FF8F], a
    ldh [$FF92], a
    ld a, $50
    ld [$C8C8], a
    ld a, $40
    ld [$C8C9], a
    ld a, $04
    ld [$C8C6], a
    ld hl, $6C5A
    ld b, $5F
    rst $10
    ret

Jump_073_6AE9::
    ld a, $80
    ld [$C919], a
    ret

Func_073_6AEF::
    ld a, [$C923]
    or a, a
    jr nz, Jump_073_6AF9
    call Func_073_6B1F
    ret

Jump_073_6AF9::
    ld a, $80
    ld [$C919], a
    ret

Func_073_6AFF::
    ld a, [$C923]
    rst $00
    dw Jump_073_6D22
    dw Jump_073_6D1B
    dw Jump_073_6D1B
    dw Jump_073_6D1B
    dw Jump_073_6CD1
    dw Jump_073_6CCA
    dw Func_073_6C77
    dw Jump_073_6B46
    dw Jump_073_7AC6
    dw Func_073_6B1F
    dw Jump_073_6B19

Jump_073_6B19::
    ld a, $80
    ld [$C919], a
    ret

Func_073_6B1F::
    ld a, $41
    ldh [$FF90], a
    xor a, a
    ldh [$FF8F], a
    ld a, $01
    ldh [$FF92], a
    ld a, $70
    ld [$C8C8], a
    ld a, $30
    ld [$C8C9], a
    ld a, $01
    ld [$C8C6], a
    ld hl, $6C5A
    ld b, $5F
    rst $10
    ld de, $006F
    call Func_000_1845
    ret

Jump_073_6B46::
    xor a, a
    call Func_073_7AB2
    ret nc
    ld a, $01
    ld [$CB96], a
    ld hl, $C923
    inc [hl]
    ld hl, $0849
    call Func_073_7AA5
    ret

Func_073_6B5B::
    ld a, [$C923]
    rst $00
    dw Jump_073_6D22
    dw Jump_073_6D1B
    dw Jump_073_6D1B
    dw Jump_073_6D1B
    dw Jump_073_6CD1
    dw Jump_073_6B87
    dw Jump_073_6B80
    dw Jump_073_6B77
    dw Jump_073_6B71

Jump_073_6B71::
    ld a, $80
    ld [$C919], a
    ret

Jump_073_6B77::
    call Func_073_6C77
    ld a, $E0
    ld [$CB9A], a
    ret

Jump_073_6B80::
    ld hl, $6E58
    ld b, $5F
    rst $10
    ret

Jump_073_6B87::
    ld hl, $FF8C
    call Func_073_7A47
    ld hl, $FF8C
    call Func_073_7A3D
    ld hl, $C923
    inc [hl]
    ret

Func_073_6B98::
    ld a, [$C923]
    rst $00
    dw Jump_073_6D22
    dw Jump_073_6D1B
    dw Jump_073_6D1B
    dw Jump_073_6D1B
    dw Jump_073_6CD1
    dw Jump_073_6CCA
    dw Func_073_6C77
    dw Jump_073_6C3E
    dw Jump_073_6BB6
    dw Jump_073_6C21
    dw Jump_073_6C0C
    dw Jump_073_6BC6
    dw Jump_073_6BB6

Jump_073_6BB6::
    xor a, a
    call Func_073_7AB2
    ret nc
    ld a, $E0
    ld [$CB9A], a
    ld a, $80
    ld [$C919], a
    ret

Jump_073_6BC6::
    ld a, [$CBD3]
    inc a
    inc a
    ld [$CBD3], a
    ld de, $CBD4
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, $6BCD
    ld b, $5F
    rst $10
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $20
    ret nz
    xor a, a
    ld [$CBCF], a
    ld a, $2C
    ld [$C928], a
    ld hl, $6C8C
    ld b, $5F
    rst $10
    ld de, $006E
    call Func_000_1845
    ld hl, $0813
    call Func_073_7AA5
    xor a, a
    ldh [$FF8D], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_6C0C::
    ld hl, $CBD4
    dec [hl]
    ld de, $CBD4
    call Func_073_7A5D
    ret nc
    ld a, $65
    call Func_000_1278
    ld hl, $C923
    inc [hl]
    ret

Jump_073_6C21::
    xor a, a
    call Func_073_7AB2
    ret nc
    ld a, $10
    ldh [$FFC6], a
    ld hl, $6B98
    ld b, $12
    rst $10
    ld a, $80
    ld [$CBCF], a
    ld a, $0E
    ldh [$FF8D], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_6C3E::
    xor a, a
    call Func_073_7AB2
    ret nc
    ld a, $01
    ld [$CB96], a
    ld hl, $C923
    inc [hl]
    ld de, $006E
    call Func_000_181B
    jr nc, Jump_073_6C5B
    ld hl, $0815
    call Func_073_7AA5
    ret

Jump_073_6C5B::
    ld a, [$C634]
    cp a, $FF
    jr z, Jump_073_6C6C
    or a, a
    jr z, Jump_073_6C6C
    ld hl, $0814
    call Func_073_7AA5
    ret

Jump_073_6C6C::
    ld hl, $0812
    call Func_073_7AA5
    ld hl, $C923
    inc [hl]
    ret

Func_073_6C77::
    ld hl, $FF8C
    call Func_073_7A47
    ld a, $03
    ld [$C8EF], a
    xor a, a
    ld [$C8F4], a
    ld a, $02
    ld [$C8F9], a
    ld a, $01
    ldh [$FF98], a
    ld hl, $C8F0
    dec [hl]
    ld hl, $C8F6
    inc [hl]
    ld hl, $C8FB
    dec [hl]
    ldh a, [$FF8E]
    inc a
    ldh [$FF8E], a
    cp a, $70
    ret nz
    ld a, $03
    ldh [$FF98], a
    ld [$C8EF], a
    ld [$C8F4], a
    ld [$C8F9], a
    ld hl, $FF8C
    call Func_073_7A4C
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ld a, $30
    ld [$CB9A], a
    ld hl, $0886
    call Func_073_7AA5
    ret

Jump_073_6CCA::
    ld hl, $6EC3
    ld b, $5F
    rst $10
    ret

Jump_073_6CD1::
    ld hl, $FF8C
    call Func_073_7A47
    ld a, $01
    ld [$C8EF], a
    ld a, $02
    ld [$C8F4], a
    xor a, a
    ld [$C8F9], a
    ld a, $03
    ldh [$FF98], a
    ld hl, $C8F0
    inc [hl]
    ld hl, $C8F6
    dec [hl]
    ld hl, $C8FB
    inc [hl]
    ldh a, [$FF8E]
    dec a
    ldh [$FF8E], a
    cp a, $60
    ret nz
    xor a, a
    ldh [$FF98], a
    ld [$C8EF], a
    ld [$C8F4], a
    ld [$C8F9], a
    ld hl, $FF8C
    call Func_073_7A4C
    ld hl, $C923
    inc [hl]
    xor a, a
    ld [$C921], a
    ld [$C92D], a
    ret

Jump_073_6D1B::
    ld hl, $61EF
    ld b, $12
    rst $10
    ret

Jump_073_6D22::
    ldh a, [$FF91]
    cp a, $40
    jr z, Jump_073_6D34
    ld a, $40
    ld [$C928], a
    ld hl, $6A94
    ld b, $5F
    rst $10
    ret

Jump_073_6D34::
    ldh a, [$FF8E]
    cp a, $70
    jr z, Jump_073_6D4D
    ld a, $70
    ld [$C928], a
    ld hl, $6ABF
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    xor a, a
    ldh [$FF98], a

Jump_073_6D4D::
    ld hl, $C923
    inc [hl]
    ret
    INCBIN "dwm2-cobi-us.gbc", $1CED52, $C5

Func_073_6E17::
    ld a, [$C923]
    rst $00
    dw Jump_073_6E40
    dw Jump_073_4E41
    dw Jump_073_6E29
    dw Jump_073_6E23

Jump_073_6E23::
    ld a, $80
    ld [$C919], a
    ret

Jump_073_6E29::
    ldh a, [$FF8E]
    ld [$C8C8], a
    ldh a, [$FF91]
    ld [$C8C9], a
    ldh a, [$FF98]
    inc a
    ld [$C8C6], a
    ld hl, $6C5A
    ld b, $5F
    rst $10
    ret

Jump_073_6E40::
    xor a, a
    ldh [$FFB9], a
    ld a, [$C525]
    or a, a
    jr z, Jump_073_6E55
    ld hl, $C49F
    ld de, $C0F0
    ld bc, $0040
    call Func_000_0952

Jump_073_6E55::
    ld a, $7A
    call Func_000_1278
    ld hl, $C923
    inc [hl]
    ret

Func_073_6E5F::
    ld a, $19
    ldh [$FFC6], a
    ld hl, $7DCE
    ld b, $12
    rst $10
    ldh a, [$FFC6]
    bit 7, a
    jr z, Jump_073_6EA0
    ld a, $1A
    ldh [$FFC6], a
    ld hl, $7DCE
    ld b, $12
    rst $10
    ldh a, [$FFC6]
    bit 7, a
    jr z, Jump_073_6EA0
    ld a, $1B
    ldh [$FFC6], a
    ld hl, $7DCE
    ld b, $12
    rst $10
    ldh a, [$FFC6]
    bit 7, a
    jr z, Jump_073_6EA0
    ld a, $1C
    ldh [$FFC6], a
    ld hl, $7DCE
    ld b, $12
    rst $10
    ldh a, [$FFC6]
    bit 7, a
    jr z, Jump_073_6EA0
    ret

Jump_073_6EA0::
    ld hl, $C61D
    ldh a, [$FFC6]
    add a, l
    ld l, a
    jr nc, Jump_073_6EAA
    inc h

Jump_073_6EAA::
    ld [hl], $30
    ld a, [$C836]
    set 6, a
    ld [$C836], a
    ld a, $80
    ld [$C919], a
    ret

Func_073_6EBA::
    ld a, [$C923]
    rst $00
    dw Jump_073_6EC8
    dw Jump_073_6EC2

Jump_073_6EC2::
    ld a, $80
    ld [$C919], a
    ret

Jump_073_6EC8::
    ld a, [$CC38]
    or a, $02
    ld [$CC38], a
    ldh a, [$FF8E]
    ld [$C8C8], a
    ldh a, [$FF91]
    ld [$C8C9], a
    ldh a, [$FF98]
    inc a
    ld [$C8C6], a
    ld hl, $6C5A
    ld b, $5F
    rst $10
    ret

Func_073_6EE7::
    ld a, [$C923]
    rst $00
    dw Jump_073_6EEF
    dw Jump_073_6F04

Jump_073_6EEF::
    ld b, $5A
    call Func_073_7A2B
    ret nc
    ld a, $05
    ldh [$FFC6], a
    ld hl, $6B98
    ld b, $12
    rst $10
    ld hl, $C923
    inc [hl]
    ret

Jump_073_6F04::
    ld b, $28
    call Func_073_7A2B
    ret nc
    xor a, a
    ld [$CBCF], a
    ld a, $80
    ld [$C919], a
    ret

Func_073_6F14::
    ldh a, [$FF8E]
    cp a, $50
    jr nz, Jump_073_6F24
    ld hl, $CBD3
    inc [hl]
    ld hl, $CBD4
    inc [hl]
    jr Jump_073_6F40

Jump_073_6F24::
    cp a, $30
    jr nz, Jump_073_6F32
    ld hl, $CBD3
    dec [hl]
    ld hl, $CBD4
    inc [hl]
    jr Jump_073_6F40

Jump_073_6F32::
    ldh a, [$FF91]
    cp a, $20
    jr z, Jump_073_6F40
    ld a, [$CBD4]
    inc a
    inc a
    ld [$CBD4], a

Jump_073_6F40::
    ld de, $CBD4
    call Func_073_7A5D
    ret nc
    xor a, a
    ld [$CBCF], a
    ld a, $40
    ld [$CBD3], a
    ld a, $30
    ld [$CBD4], a
    ld a, $80
    ld [$C919], a
    ret

Func_073_6F5B::
    ld a, [$C923]
    or a, a
    jr nz, Jump_073_6F6B
    ld a, $80
    ld [$CBCF], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_6F6B::
    ld hl, $CBD4
    dec [hl]
    ld de, $CBD4
    call Func_073_7A5D
    ret nc
    ld a, $80
    ld [$C919], a
    ret

Func_073_6F7C::
    ld a, [$C923]
    rst $00
    dw Jump_073_7007
    dw Jump_073_6FC5
    dw Jump_073_6FB1
    dw Jump_073_6F88

Jump_073_6F88::
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $3C
    ret nz
    ld a, $72
    call Func_000_1278
    ldh a, [$FF98]
    inc a
    inc a
    and a, $03
    ld [$CB86], a
    ld a, $40
    ld [$CB8A], a
    ld de, $0019
    call Func_000_1845
    ld a, $80
    ld [$C919], a
    ret

Jump_073_6FB1::
    ld a, $01
    ld [$C8F4], a
    ld a, [$C8F5]
    inc a
    ld [$C8F5], a
    cp a, $B0
    ret nz
    ld hl, $C923
    inc [hl]
    ret

Jump_073_6FC5::
    ld a, [$C921]
    or a, a
    jr nz, Jump_073_6FE2
    ld a, [$C8F5]
    cp a, $50
    jr nz, Jump_073_6FD8
    ld a, $01
    ld [$C921], a
    ret

Jump_073_6FD8::
    ld a, $01
    ld [$C8F4], a
    ld hl, $C8F5
    inc [hl]
    ret

Jump_073_6FE2::
    ld a, [$C8F6]
    cp a, $40
    jr nz, Jump_073_6FF2
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_6FF2::
    jr nc, Jump_073_6FFD
    xor a, a
    ld [$C8F4], a
    ld hl, $C8F6
    inc [hl]
    ret

Jump_073_6FFD::
    ld a, $02
    ld [$C8F4], a
    ld hl, $C8F6
    dec [hl]
    ret

Jump_073_7007::
    ld hl, $C923
    inc [hl]
    ld a, [$C8F5]
    cp a, $40
    jr nz, Jump_073_701E
    ld a, [$C8F6]
    cp a, $20
    jr nz, Jump_073_701E
    xor a, a
    ld [$C921], a
    ret

Jump_073_701E::
    ld a, $01
    ld [$C921], a
    ret

Func_073_7024::
    ld a, [$C923]
    rst $00
    dw Func_073_734D
    dw Jump_073_733B
    dw Jump_073_733B
    dw Jump_073_7AC6
    dw Jump_073_7329
    dw Jump_073_7329
    dw Jump_073_7AC6
    dw Jump_073_7317
    dw Jump_073_7317
    dw Jump_073_7AC6
    dw Func_073_734D
    dw Jump_073_7300
    dw Jump_073_72D6
    dw Jump_073_7AC6
    dw Jump_073_72A9
    dw Jump_073_724F
    dw Jump_073_7223
    dw Jump_073_71F6
    dw Jump_073_71DB
    dw Jump_073_71BC
    dw Jump_073_71DB
    dw Jump_073_7180
    dw Jump_073_715A
    dw Jump_073_70D3
    dw Jump_073_70C2
    dw Jump_073_7AC6
    dw Jump_073_70A9
    dw Jump_073_7095
    dw Jump_073_7062

Jump_073_7062::
    ld a, [$C921]
    inc a
    cp a, $1E
    jr z, Jump_073_706E
    ld [$C921], a
    ret

Jump_073_706E::
    dec a
    ld [$C921], a
    ld a, $40
    ld [$C928], a
    ld hl, $6B17
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld a, $02
    ldh [$FF98], a
    ld [$C8EF], a
    ld de, $000C
    call Func_000_1845
    ld a, $80
    ld [$C919], a
    ret

Jump_073_7095::
    ld hl, $CBD4
    inc [hl]
    ld de, $CBD4
    call Func_073_7A5D
    ret nc
    xor a, a
    ld [$CBCF], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_70A9::
    ld a, $68
    ld [$C928], a
    ld hl, $6B17
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld a, $02
    ldh [$FF98], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_70C2::
    ld b, $B4
    call Func_073_7A2B
    ret nc
    ld hl, $005C
    call Func_073_7AA5
    ld hl, $C923
    inc [hl]
    ret

Jump_073_70D3::
    ld a, [$C926]
    cp a, $FF
    jr z, Jump_073_70E5
    xor a, a
    ld [$C928], a
    ld hl, $6936
    ld b, $5F
    rst $10
    ret

Jump_073_70E5::
    ld a, [$C921]
    or a, a
    jr nz, Jump_073_70F0
    ld a, $65
    call Func_000_1278

Jump_073_70F0::
    ld de, $CB8B
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, $6BCD
    ld b, $5F
    rst $10
    ld a, [$C921]
    and a, $01
    jr nz, Jump_073_7111
    ld a, [$CB86]
    inc a
    and a, $03
    ld [$CB86], a

Jump_073_7111::
    ld a, [$CB8A]
    cp a, $40
    jr z, Jump_073_711D
    dec a
    dec a
    ld [$CB8A], a

Jump_073_711D::
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $20
    jr z, Jump_073_7138
    ld hl, $6B22
    ld b, $12
    rst $10
    xor a, a
    ldh [$FFC6], a
    ld hl, $6B33
    ld b, $12
    rst $10
    ret

Jump_073_7138::
    ld a, $72
    call Func_000_1278
    ld de, $7AD4
    ld b, $7D
    ld hl, $8500
    call Func_000_0CF5
    ld a, $49
    ld [$CB81], a
    xor a, a
    ld [$CB86], a
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_715A::
    ld hl, $6B22
    ld b, $12
    rst $10
    xor a, a
    ldh [$FFC6], a
    ld hl, $6B33
    ld b, $12
    rst $10
    ld de, $CB86
    call Func_073_7A51
    ld b, $78
    call Func_073_7A2B
    ret nc
    ld hl, $005B
    call Func_073_7AA5
    ld hl, $C923
    inc [hl]
    ret

Jump_073_7180::
    ld hl, $6B22
    ld b, $12
    rst $10
    xor a, a
    ldh [$FFC6], a
    ld hl, $6B33
    ld b, $12
    rst $10
    ld de, $CB86
    call Func_073_7A51
    ld hl, $C921
    inc [hl]
    ld a, $01
    ld [$C929], a
    ld a, $81
    ld [$C92A], a
    ld a, $B0
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_71BC::
    ld hl, $6B22
    ld b, $12
    rst $10
    xor a, a
    ldh [$FFC6], a
    ld hl, $6B33
    ld b, $12
    rst $10
    ld de, $CB86
    call Func_073_7A51
    ld de, $CB9B
    ld hl, $005A
    call Func_073_7A7F
    ret

Jump_073_71DB::
    ld a, $01
    call Func_073_7AB2
    push af
    ld de, $CB86
    call Func_073_7A51
    ld hl, $C921
    inc [hl]
    pop af
    ret nc
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_71F6::
    ld a, $02
    ld [$C8EF], a
    ld a, $70
    ld [$C8F0], a
    ld a, $40
    ld [$C8F1], a
    ld hl, $6B22
    ld b, $12
    rst $10
    xor a, a
    ldh [$FFC6], a
    ld hl, $6B33
    ld b, $12
    rst $10
    ld a, $80
    ld [$CBCF], a
    ld de, $CB8B
    ld hl, $0059
    call Func_073_7A7F
    ret

Jump_073_7223::
    ld a, $02
    ld [$CBA6], a
    ld hl, $CBAB
    inc [hl]
    ld de, $CBAB
    call Func_073_7A5D
    ret nc
    ld de, $000B
    call Func_000_1845
    ldh a, [$FF8E]
    ld [$C8C8], a
    ldh a, [$FF91]
    ld [$C8C9], a
    ld a, $04
    ld [$C8C6], a
    ld hl, $6C5A
    ld b, $5F
    rst $10
    ret

Jump_073_724F::
    ld hl, $CBAA
    dec [hl]
    ld de, $CB9B
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, $6BCD
    ld b, $5F
    rst $10
    ld de, $CBAB
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, $6BCD
    ld b, $5F
    rst $10
    ld de, $CBD4
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, $6BCD
    ld b, $5F
    rst $10
    ld a, [$C921]
    and a, $01
    jr z, Jump_073_728D

Jump_073_728D::
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $20
    ret nz
    xor a, a
    ldh [$FFC6], a
    ld hl, $6AD9
    ld b, $12
    rst $10
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_72A9::
    ld a, [$C8F1]
    dec a
    dec a
    ld [$C8F1], a
    cp a, $38
    jr z, Jump_073_72B9
    call Func_073_736B
    ret

Jump_073_72B9::
    ld a, $80
    ld [$CB9A], a
    ld a, $60
    ld [$CBAA], a
    ld a, $70
    ld [$CBD3], a
    ld a, $63
    call Func_000_1278
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_72D6::
    ld a, [$C5F0]
    and a, $03
    ret nz
    ld a, [$C8F1]
    inc a
    ld [$C8F1], a
    cp a, $48
    ret nz
    ld hl, $C923
    inc [hl]
    ld de, $0001
    call Func_000_181B
    jr c, Jump_073_72F9
    ld hl, $0058
    call Func_073_7AA5
    ret

Jump_073_72F9::
    ld hl, $005E
    call Func_073_7AA5
    ret

Jump_073_7300::
    call Func_073_736B
    ld a, [$C8F0]
    dec a
    ld [$C8F0], a
    cp a, $70
    ret nz
    ld a, $02
    ld [$C8EF], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_7317::
    ld de, $CB9B
    call Func_073_7A5D
    ret nc
    ld hl, $0055
    call Func_073_7AA5
    ld hl, $C923
    inc [hl]
    ret

Jump_073_7329::
    ld de, $CBAB
    call Func_073_7A5D
    ret nc
    ld hl, $0054
    call Func_073_7AA5
    ld hl, $C923
    inc [hl]
    ret

Jump_073_733B::
    ld de, $CB9B
    call Func_073_7A5D
    ret nc
    ld hl, $0053
    call Func_073_7AA5
    ld hl, $C923
    inc [hl]
    ret

Func_073_734D::
    ld hl, $CB9C
    call Func_073_7A47
    ld hl, $CBAC
    call Func_073_7A47
    ld a, $80
    ld [$CBCF], a
    call Func_073_736B
    ld a, [$C921]
    or a, a
    ret nz
    ld hl, $C923
    inc [hl]
    ret

Func_073_736B::
    ld a, [$C921]
    and a, $3F
    ld hl, $7526
    add a, l
    ld l, a
    jr nc, Jump_073_7378
    inc h

Jump_073_7378::
    ld a, [hl]
    ld c, a
    ld a, [$C921]
    and a, $40
    jr z, Jump_073_7386
    ld a, c
    xor a, $FF
    inc a
    ld c, a

Jump_073_7386::
    ld a, [$CB9A]
    add a, c
    ld [$CB9A], a
    ld a, [$CBAA]
    add a, c
    ld [$CBAA], a
    ld a, [$CBD3]
    add a, c
    ld [$CBD3], a
    ld hl, $C921
    inc [hl]
    ret

Func_073_73A0::
    ld a, [$C923]
    rst $00
    dw Jump_073_7566
    dw Jump_073_74EC
    dw Jump_073_74DA
    dw Jump_073_74DA
    dw Jump_073_74EC
    dw Jump_073_74EC
    dw Jump_073_74DA
    dw Jump_073_74DA
    dw Jump_073_74EC
    dw Jump_073_741E
    dw Jump_073_73BA

Jump_073_73BA::
    ld a, [$C921]
    or a, a
    jr nz, Jump_073_73F9
    ld a, $01
    ld [$C929], a
    ld a, $82
    ld [$C92A], a
    ld a, $50
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, $02
    ld [$C929], a
    ld a, $81
    ld [$C92A], a
    ld a, $50
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld a, $E0
    ld [$CBAA], a
    ld hl, $C921
    inc [hl]
    ret

Jump_073_73F9::
    ld a, $01
    ld [$C929], a
    ld a, $81
    ld [$C92A], a
    ld a, $50
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld a, $E0
    ld [$CB9A], a
    ld a, $80
    ld [$C919], a
    ret

Jump_073_741E::
    ld a, [$C921]
    or a, a
    jr nz, Jump_073_7429
    ld a, $65
    call Func_000_1278

Jump_073_7429::
    ld a, [$C921]
    ld hl, $749A
    add a, l
    ld l, a
    jr nc, Jump_073_7434
    inc h

Jump_073_7434::
    ld a, [hl]
    ld [$CBD3], a
    ld a, [$C921]
    push af
    srl a
    ld [$C921], a
    ld de, $CBD4
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, $6BCD
    ld b, $5F
    rst $10
    pop af
    ld [$C921], a
    ldh a, [$FF8E]
    cp a, $00
    jr nz, Jump_073_746A
    ld hl, $FF8C
    call Func_073_7A4C
    ld hl, $CBAC
    call Func_073_7A4C
    jr Jump_073_7476

Jump_073_746A::
    dec a
    dec a
    ldh [$FF8E], a
    ld a, [$CBAA]
    inc a
    inc a
    ld [$CBAA], a

Jump_073_7476::
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $40
    ret nz
    xor a, a
    ld [$CBCF], a
    ld a, $68
    ld [$CBD3], a
    ld a, $30
    ld [$CBD4], a
    ld hl, $C923
    inc [hl]
    xor a, a
    ld [$C921], a
    ld [$C922], a
    ret
    db $21, $22, $23, $23, $24, $25, $26, $27, $28, $29, $2A, $2A, $2B, $2C, $2D, $2E
    db $2F, $30, $30, $31, $32, $33, $34, $35, $35, $36, $37, $38, $39, $39, $3A, $3B
    db $3C, $3C, $3D, $3E, $3E, $3F, $40, $40, $41, $42, $42, $43, $44, $44, $45, $46
    db $46, $47, $48, $48, $49, $4A, $4A, $4B, $4C, $4C, $4D, $4E, $4E, $4F, $50, $50

Jump_073_74DA::
    ld a, [$C921]
    ld hl, $7526
    add a, l
    ld l, a
    jr nc, Jump_073_74E5
    inc h

Jump_073_74E5::
    ld a, [hl]
    xor a, $FF
    inc a
    ld c, a
    jr Jump_073_74F9

Jump_073_74EC::
    ld a, [$C921]
    ld hl, $7526
    add a, l
    ld l, a
    jr nc, Jump_073_74F7
    inc h

Jump_073_74F7::
    ld a, [hl]
    ld c, a

Jump_073_74F9::
    ld a, [$CBAA]
    add a, c
    ld [$CBAA], a
    ldh a, [$FF8E]
    add a, c
    ldh [$FF8E], a
    ld a, [$C8F0]
    add a, c
    ld [$C8F0], a
    ld a, [$CBD3]
    add a, c
    ld [$CBD3], a
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $40
    ret nz
    ld hl, $C923
    inc [hl]
    xor a, a
    ld [$C921], a
    ret
    db $01, $00, $01, $00, $01, $01, $00, $FF, $01, $00, $00, $FF, $00, $FF, $FF, $00
    db $01, $00, $00, $00, $01, $01, $FF, $00, $00, $FF, $00, $00, $00, $FF, $01, $00
    db $01, $00, $01, $00, $00, $01, $01, $01, $00, $00, $FF, $00, $00, $00, $FF, $01
    db $FF, $00, $00, $01, $FF, $FF, $FF, $00, $00, $00, $FF, $00, $00, $FF, $FF, $00

Jump_073_7566::
    ld a, $10
    ld [$C928], a
    ld hl, $6ABF
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld a, $01
    ld [$C8EF], a
    ld hl, $FF8C
    call Func_073_7A47
    ld hl, $CBAC
    call Func_073_7A47
    ld hl, $C923
    inc [hl]
    ret

Func_073_758C:: ; heuristic: follows a terminator; C0
    ld a, [$C923]
    or a, a
    jr nz, Jump_073_75A6
    ldh a, [$FF8E]
    ld [$CBD3], a
    ldh a, [$FF91]
    ld [$CBD4], a
    ld a, $80
    ld [$CBCF], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_75A6::
    ldh a, [$FF8E]
    cp a, $30
    jr nz, Jump_073_75B2
    ld hl, $CBD3
    inc [hl]
    jr Jump_073_75CC

Jump_073_75B2::
    cp a, $50
    jr nz, Jump_073_75BC
    ld hl, $CBD3
    dec [hl]
    jr Jump_073_75CC

Jump_073_75BC::
    ldh a, [$FF91]
    cp a, $20
    jr nz, Jump_073_75C8
    ld hl, $CBD4
    inc [hl]
    jr Jump_073_75CC

Jump_073_75C8::
    ld hl, $CBD4
    dec [hl]

Jump_073_75CC::
    ld de, $CBD4
    call Func_073_7A5D
    ret nc
    xor a, a
    ld [$CBCF], a
    ld a, $80
    ld [$C919], a
    ret

Func_073_75DD::
    ld a, [$C923]
    rst $00
    dw Jump_073_764E
    dw Jump_073_7639
    dw Jump_073_75F5
    dw Jump_073_75E9

Jump_073_75E9::
    ld b, $3C
    call Func_073_7A2B
    ret nc
    ld a, $80
    ld [$C919], a
    ret

Jump_073_75F5::
    ldh a, [$FF8E]
    cp a, $00
    jr z, Jump_073_760B
    dec a
    dec a
    ldh [$FF8E], a
    ld a, [$C8F0]
    cp a, $00
    jr z, Jump_073_760B
    dec a
    dec a
    ld [$C8F0], a

Jump_073_760B::
    ld a, $80
    ld [$CBCF], a
    ld de, $CBD4
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, $6BCD
    ld b, $5F
    rst $10
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $20
    ret nz
    ld a, $50
    ld [$CBD4], a
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_7639::
    ld a, [$CBAA]
    dec a
    dec a
    ld [$CBAA], a
    cp a, $30
    ret nz
    ld a, $63
    call Func_000_1278
    ld hl, $C923
    inc [hl]
    ret

Jump_073_764E::
    ld a, [$CBAA]
    inc a
    ld [$CBAA], a
    cp a, $40
    ret nz
    ld hl, $C923
    inc [hl]
    ret

Func_073_765D::
    ld a, [$C923]
    rst $00
    dw Jump_073_77A5
    dw Jump_073_7765
    dw Jump_073_775A
    dw Jump_073_7741
    dw Jump_073_775A
    dw Jump_073_7719
    dw Jump_073_775A
    dw Jump_073_7713
    dw Jump_073_775A
    dw Jump_073_7719
    dw Jump_073_775A
    dw Jump_073_7713
    dw Jump_073_775A
    dw Jump_073_7709
    dw Jump_073_7AC6
    dw Jump_073_76B8
    dw Jump_073_7683

Jump_073_7683::
    ld a, $01
    ld [$C929], a
    ld a, $82
    ld [$C92A], a
    ld a, $E0
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, $02
    ld [$C929], a
    ld a, $82
    ld [$C92A], a
    ld a, $E0
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld a, $80
    ld [$C919], a
    ret

Jump_073_76B8::
    ld a, [$CBAA]
    cp a, $40
    jr z, Jump_073_76CB
    ld a, $83
    ld [$C92A], a
    ld a, $40
    ld [$C928], a
    jr Jump_073_76D5

Jump_073_76CB::
    ld a, $82
    ld [$C92A], a
    ld a, $E0
    ld [$C928], a

Jump_073_76D5::
    ld a, $02
    ld [$C929], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, $01
    ld [$C929], a
    ld a, $82
    ld [$C92A], a
    ld a, $40
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld hl, $CBD4
    inc [hl]
    ld de, $CBD4
    call Func_073_7A5D
    ret nc
    xor a, a
    ld [$CBCF], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_7709::
    ld de, $CB8B
    ld hl, $0039
    call Func_073_7A7F
    ret

Jump_073_7713::
    ld hl, $CBD3
    inc [hl]
    jr Jump_073_771D

Jump_073_7719::
    ld hl, $CBD3
    dec [hl]

Jump_073_771D::
    ld de, $CBD4
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, $6BCD
    ld b, $5F
    rst $10
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $20
    ret nz
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_7741::
    ld hl, $CBD3
    dec [hl]
    ld hl, $CBD4
    dec [hl]
    ld de, $CBD4
    call Func_073_7A5D
    ret nc
    ld a, $03
    ld [$CBA6], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_775A::
    ld b, $1E
    call Func_073_7A2B
    ret nc
    ld hl, $C923
    inc [hl]
    ret

Jump_073_7765::
    ld a, [$CB9A]
    cp a, $30
    jr z, Jump_073_7781
    ld a, $01
    ld [$C929], a
    ld a, $01
    ld [$C92A], a
    ld a, $30
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10

Jump_073_7781::
    ld a, $02
    ld [$C929], a
    ld a, $00
    ld [$C92A], a
    ld a, $40
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld a, $01
    ld [$CBA6], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_77A5::
    ld hl, $C921
    inc [hl]
    ld a, [$C921]
    cp a, $3C
    jr nz, Jump_073_77B6
    ld a, $50
    ld [$CBAA], a
    ret

Jump_073_77B6::
    cp a, $78
    jr nz, Jump_073_77C0
    ld a, $20
    ld [$CB9A], a
    ret

Jump_073_77C0::
    cp a, $B4
    ret nz
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Func_073_77CC::
    ld a, [$C923]
    rst $00
    dw Jump_073_78E7
    dw Jump_073_78CC
    dw Jump_073_78B2
    dw Jump_073_787B
    dw Jump_073_77EA
    dw Jump_073_77DC

Jump_073_77DC::
    call Func_073_79CE
    ld a, [$C922]
    or a, a
    ret nz
    ld a, $80
    ld [$C919], a
    ret

Jump_073_77EA::
    call Func_073_79CE
    ld a, [$CB9B]
    cp a, $30
    jr z, Jump_073_7800
    ld a, $82
    ld [$C92A], a
    ld a, $30
    ld [$C928], a
    jr Jump_073_780A

Jump_073_7800::
    ld a, $83
    ld [$C92A], a
    ld a, $E0
    ld [$C928], a

Jump_073_780A::
    ld a, $01
    ld [$C929], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, [$C924]
    or a, a
    jr nz, Jump_073_783B
    ld a, $02
    ld [$C929], a
    ld a, $83
    ld [$C92A], a
    ld a, $20
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld a, $01
    ld [$C924], a
    ret

Jump_073_783B::
    ld a, [$CBAB]
    cp a, $30
    jr z, Jump_073_7858
    ld a, $02
    ld [$C929], a
    ld a, $82
    ld [$C92A], a
    ld a, $30
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ret

Jump_073_7858::
    ld a, $02
    ld [$C929], a
    ld a, $83
    ld [$C92A], a
    ld a, $E0
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_787B::
    call Func_073_79CE
    ld a, $02
    ld [$C929], a
    ld a, $83
    ld [$C92A], a
    ld a, $20
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, $01
    ld [$C929], a
    ld a, $83
    ld [$C92A], a
    ld a, $20
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld hl, $C923
    inc [hl]
    ret

Jump_073_78B2::
    call Func_073_78F5
    call Func_073_79B8
    ld b, $A0
    call Func_073_7A2B
    ret nc
    ld a, $40
    ld [$C922], a
    xor a, a
    ld [$C924], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_78CC::
    call Func_073_78F5
    call Func_073_79B8
    ld b, $80
    call Func_073_7A2B
    ret nc
    ld a, $81
    ld [$C924], a
    ld a, $80
    ld [$C925], a
    ld hl, $C923
    inc [hl]
    ret

Jump_073_78E7::
    ld a, $01
    ld [$C924], a
    xor a, a
    ld [$C925], a
    ld hl, $C923
    inc [hl]
    ret

Func_073_78F5::
    ld b, $00
    ld a, [$C924]
    bit 7, a
    jr z, Jump_073_7900
    ld b, $80

Jump_073_7900::
    and a, $03
    jr nz, Jump_073_7911
    ld a, b
    or a, $01
    ld [$C92A], a
    ld a, $50
    ld [$C928], a
    jr Jump_073_793C

Jump_073_7911::
    dec a
    jr nz, Jump_073_7921
    ld a, b
    or a, $00
    ld [$C92A], a
    ld a, $50
    ld [$C928], a
    jr Jump_073_793C

Jump_073_7921::
    dec a
    jr nz, Jump_073_7931
    ld a, b
    or a, $03
    ld [$C92A], a
    ld a, $30
    ld [$C928], a
    jr Jump_073_793C

Jump_073_7931::
    ld a, b
    or a, $02
    ld [$C92A], a
    ld a, $30
    ld [$C928], a

Jump_073_793C::
    ld a, $01
    ld [$C929], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    jr z, Jump_073_7956
    ld a, [$C924]
    inc a
    and a, $83
    ld [$C924], a

Jump_073_7956::
    ld b, $00
    ld a, [$C925]
    bit 7, a
    jr z, Jump_073_7961
    ld b, $80

Jump_073_7961::
    and a, $03
    jr nz, Jump_073_7972
    ld a, b
    or a, $01
    ld [$C92A], a
    ld a, $50
    ld [$C928], a
    jr Jump_073_799D

Jump_073_7972::
    dec a
    jr nz, Jump_073_7982
    ld a, b
    or a, $00
    ld [$C92A], a
    ld a, $50
    ld [$C928], a
    jr Jump_073_799D

Jump_073_7982::
    dec a
    jr nz, Jump_073_7992
    ld a, b
    or a, $03
    ld [$C92A], a
    ld a, $30
    ld [$C928], a
    jr Jump_073_799D

Jump_073_7992::
    ld a, b
    or a, $02
    ld [$C92A], a
    ld a, $30
    ld [$C928], a

Jump_073_799D::
    ld a, $02
    ld [$C929], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    jr z, Jump_073_79B7
    ld a, [$C925]
    inc a
    and a, $83
    ld [$C925], a

Jump_073_79B7::
    ret

Func_073_79B8::
    ld a, [$C925]
    and a, $03
    ld hl, $79CA
    add a, l
    ld l, a
    jr nc, Jump_073_79C5
    inc h

Jump_073_79C5::
    ld a, [hl]
    ld [$CB86], a
    ret
    db $01, $00, $03, $02

Func_073_79CE::
    ld a, [$C5F0]
    and a, $08
    jr nz, Jump_073_79D9
    ld hl, $C922
    dec [hl]

Jump_073_79D9::
    ld a, [$C922]
    swap a
    and a, $0F
    ld c, a
    ld a, [$C921]
    add a, c
    ld [$C921], a
    swap a
    and a, $03
    ld c, a
    ld a, $03
    sub a, c
    ld [$CB86], a
    ret

Func_073_79F4::
    ld a, [$C923]
    rst $00
    dw Jump_073_7A11
    dw Jump_073_79FC

Jump_073_79FC::
    ld hl, $CBD4
    inc [hl]
    ld de, $CBD4
    call Func_073_7A5D
    ret nc
    xor a, a
    ld [$CBCF], a
    ld a, $80
    ld [$C919], a
    ret

Jump_073_7A11::
    ld a, $40
    ld [$CBD3], a
    ld a, $30
    ld [$CBD4], a
    ld a, $80
    ld [$CBCF], a
    ld b, $3C
    call Func_073_7A2B
    ret nc
    ld hl, $C923
    inc [hl]
    ret

Func_073_7A2B::
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, b
    jr z, Jump_073_7A37
    sub a, a
    ret

Jump_073_7A37::
    xor a, a
    ld [$C921], a
    scf
    ret

Func_073_7A3D:: ; heuristic: follows a terminator; C0
    ld a, [hl]
    or a, $02
    ld [hl], a
    ret

Func_073_7A42:: ; heuristic: follows a terminator; C0
    ld a, [hl]
    and a, $FD
    ld [hl], a
    ret

Func_073_7A47:: ; heuristic: follows a terminator; C0
    ld a, [hl]
    or a, $04
    ld [hl], a
    ret

Func_073_7A4C:: ; heuristic: follows a terminator; C0
    ld a, [hl]
    and a, $FB
    ld [hl], a
    ret

Func_073_7A51:: ; heuristic: follows a terminator; C0
    ld a, [$C921]
    and a, $1F
    ret nz
    ld a, [de]
    inc a
    and a, $03
    ld [de], a
    ret

Func_073_7A5D::
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, $6BCD
    ld b, $5F
    rst $10
    ld a, [$C921]
    inc a
    inc a
    ld [$C921], a
    cp a, $20
    jr z, Jump_073_7A79
    sub a, a
    ret

Jump_073_7A79::
    xor a, a
    ld [$C921], a
    scf
    ret

Func_073_7A7F:: ; heuristic: follows a terminator; C0
    push hl
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, $6BCD
    ld b, $5F
    rst $10
    ld a, [$C921]
    inc a
    ld [$C921], a
    pop hl
    cp a, $20
    ret nz
    call Func_073_7AA5
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Func_073_7AA5::
    ld a, l
    ld [$C924], a
    ld a, h
    ld [$C925], a
    xor a, a
    ld [$C926], a
    ret

Func_073_7AB2:: ; heuristic: follows a terminator; C0
    ld [$C928], a
    ld hl, $6936
    ld b, $5F
    rst $10
    ld a, [$C926]
    cp a, $FF
    jr z, Jump_073_7AC4
    sub a, a
    ret

Jump_073_7AC4::
    scf
    ret

Jump_073_7AC6::
    xor a, a
    call Func_073_7AB2
    ret nc
    ld hl, $C923
    inc [hl]
    ret

Func_073_7AD0:: ; heuristic: follows a terminator; C0
    xor a, a
    call Func_073_7AB2
    ret nc
    ld a, $80
    ld [$C919], a
    ret
    ds $525, $00
