SECTION "Bank 84", ROMX[$4000], BANK[$84]
    db $84

Func_084_4001::
    xor a, a
    ld [$CC46], a
    ld a, [$CD0C]
    add a, a
    ld hl, Data_084_4CCB
    add a, l
    ld l, a
    jr nc, Jump_084_4011
    inc h

Jump_084_4011::
    ld a, [hl+]
    ldh [$FFCE], a
    ld a, [hl]
    ldh [$FFCF], a
    ldh a, [$FFCE]
    add a, $01
    ldh [$FFCE], a
    ldh a, [$FFCF]
    adc a, $00
    ldh [$FFCF], a
    ld hl, $CD8B
    ld de, $CDAC

Jump_084_4029::
    ld a, [hl]
    cp a, $FF
    ret z
    push hl
    push de
    dec hl
    dec hl
    ld a, [hl]
    ldh [$FFC6], a
    call Func_084_405C
    ldh a, [$FFCE]
    ld l, a
    ldh a, [$FFCF]
    ld h, a
    ld a, $10
    add a, l
    ld l, a
    jr nc, Jump_084_4044
    inc h

Jump_084_4044::
    ld a, l
    ldh [$FFCE], a
    ld a, h
    ldh [$FFCF], a
    pop de
    pop hl
    ld a, $04
    add a, l
    ld l, a
    jr nc, Jump_084_4053
    inc h

Jump_084_4053::
    ld a, $10
    add a, e
    ld e, a
    jr nc, Jump_084_405A
    inc d

Jump_084_405A::
    jr Jump_084_4029

Func_084_405C::
    ldh a, [$FFC6]
    rst $00
    dw Jump_084_406D
    dw Jump_084_4072
    dw Jump_084_4091
    dw Jump_084_40C2
    dw Jump_084_40F3
    dw Jump_084_4156
    dw Jump_084_406E

Jump_084_406D::
    ret

Jump_084_406E::
    ld a, $54
    ld [de], a
    ret

Jump_084_4072::
    ld hl, Data_084_41AE
    ld a, [$CD0B]
    add a, l
    ld l, a
    jr nc, Jump_084_407D
    inc h

Jump_084_407D::
    ld a, [hl]
    ld [de], a
    inc de
    inc de
    ldh a, [$FFCE]
    ld l, a
    ldh a, [$FFCF]
    ld h, a
    inc hl
    ld b, $0E

Jump_084_408A::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_084_408A
    ret

Jump_084_4091::
    ld hl, Data_084_41B8
    ld a, [$CD0B]
    add a, l
    ld l, a
    jr nc, Jump_084_409C
    inc h

Jump_084_409C::
    ld a, [hl]
    add a, $20
    ld [de], a
    call Func_000_09F3
    ld a, [$CD04]
    srl a
    and a, $01
    jr z, Jump_084_40B0
    ld a, [de]
    or a, $80
    ld [de], a

Jump_084_40B0::
    inc de
    inc de
    ldh a, [$FFCE]
    ld l, a
    ldh a, [$FFCF]
    ld h, a
    inc hl
    ld b, $0E

Jump_084_40BB::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_084_40BB
    ret

Jump_084_40C2::
    ld hl, Data_084_41B8
    ld a, [$CD0B]
    add a, l
    ld l, a
    jr nc, Jump_084_40CD
    inc h

Jump_084_40CD::
    ld a, [hl]
    add a, $40
    ld [de], a
    call Func_000_09F3
    ld a, [$CD04]
    srl a
    and a, $01
    jr z, Jump_084_40E1
    ld a, [de]
    or a, $80
    ld [de], a

Jump_084_40E1::
    inc de
    inc de
    ldh a, [$FFCE]
    ld l, a
    ldh a, [$FFCF]
    ld h, a
    inc hl
    ld b, $0E

Jump_084_40EC::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_084_40EC
    ret

Jump_084_40F3::
    ldh a, [$FFCE]
    ld l, a
    ldh a, [$FFCF]
    ld h, a
    inc hl
    ld a, [hl+]
    ld [de], a
    ldh [$FFC6], a
    push hl
    inc de
    ld a, [$CC46]
    ld [de], a
    inc de
    ld a, [$CD0B]
    add a, a
    add a, a
    ld hl, Data_084_41CA
    add a, l
    ld l, a
    jr nc, Jump_084_4112
    inc h

Jump_084_4112::
    call Func_000_09F3
    ld a, [$CD04]
    and a, $03
    add a, l
    ld l, a
    jr nc, Jump_084_411F
    inc h

Jump_084_411F::
    ld a, [hl]
    ld [de], a
    pop hl
    inc de
    push de
    ld b, $0D

Jump_084_4126::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_084_4126
    pop de
    inc de
    ld a, [de]
    cp a, $FF
    jr z, Jump_084_4150
    call Func_000_09F3
    ld a, [$CD04]
    and a, $07
    inc de
    inc de
    ld [de], a
    inc de
    inc de
    ld a, [de]
    cp a, $FF
    jr z, Jump_084_4150
    call Func_000_09F3
    ld a, [$CD04]
    and a, $07
    inc de
    inc de
    ld [de], a

Jump_084_4150::
    ld a, $01
    call Func_084_41F2
    ret

Jump_084_4156::
    ldh a, [$FFCE]
    ld l, a
    ldh a, [$FFCF]
    ld h, a
    inc hl
    ld a, [hl+]
    ld [de], a
    ldh [$FFC6], a
    push hl
    inc de
    ld a, [$CC46]
    ld [de], a
    inc de
    call Func_000_09F3
    ld a, [$CD04]
    and a, $07
    ld hl, Data_084_41C2
    add a, l
    ld l, a
    jr nc, Jump_084_4178
    inc h

Jump_084_4178::
    ld a, [hl]
    ld [de], a
    pop hl
    inc de
    push de
    ld b, $0D

Jump_084_417F::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_084_417F
    pop de
    inc de
    ld a, [de]
    cp a, $FF
    jr z, Jump_084_41A9
    call Func_000_09F3
    ld a, [$CD04]
    and a, $07
    inc de
    inc de
    ld [de], a
    inc de
    inc de
    ld a, [de]
    cp a, $FF
    jr z, Jump_084_41A9
    call Func_000_09F3
    ld a, [$CD04]
    and a, $07
    inc de
    inc de
    ld [de], a

Jump_084_41A9::
    xor a, a
    call Func_084_41F2
    ret

Data_084_41AE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $03, $01, $00, $00, $04, $05, $02, $00

Data_084_41B8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $06, $03, $01, $07, $08, $04, $05, $02, $09

Data_084_41C2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $05, $06, $07, $08, $09, $05, $07, $09

Data_084_41CA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $0B, $00, $0B, $00, $02, $00, $02, $02, $03, $0B, $02, $02, $04, $02, $04
    db $01, $01, $01, $01, $01, $03, $01, $03, $00, $04, $00, $04, $01, $04, $01, $04
    db $01, $03, $0B, $01, $00, $0B, $00, $0B

Func_084_41F2::
    push af
    ld a, [$CC46]
    add a, a
    ld hl, $CE2C
    add a, l
    ld l, a
    jr nc, Jump_084_41FF
    inc h

Jump_084_41FF::
    pop af
    or a, a
    jr nz, Jump_084_4241
    ld a, $A0
    ldh [$FFC8], a
    call Func_000_09F3
    and a, $03
    add a, a
    add a, a
    add a, a
    ld c, a
    ldh a, [$FFC8]
    add a, c
    ldh [$FFC8], a
    ld c, $05
    call Func_084_43AC
    ld c, a
    ldh a, [$FFC8]
    add a, c
    ldh [$FFC8], a
    ld [hl+], a
    ldh a, [$FFC8]
    ld e, a
    ld d, $00
    sla e
    rl d
    call Func_084_435C
    ldh a, [$FFCA]
    swap a
    or a, $0F
    ld [hl+], a
    ld a, $0F
    ldh [$FFC9], a
    ld a, [$CC46]
    inc a
    ld [$CC46], a
    jr Jump_084_427D

Jump_084_4241::
    xor a, a
    ldh [$FFC8], a
    ld c, $09
    call Func_084_43AC
    sla a
    sla a
    sla a
    ld c, a
    ldh a, [$FFC8]
    add a, c
    ldh [$FFC8], a
    ld c, $08
    call Func_084_43AC
    ld c, a
    ldh a, [$FFC8]
    add a, c
    ldh [$FFC8], a
    ld [hl+], a
    ldh a, [$FFC8]
    ld e, a
    ld d, $00
    sla e
    rl d
    call Func_084_435C
    ldh a, [$FFCA]
    swap a
    ld c, a
    ldh a, [$FFC9]
    or a, c
    ld [hl+], a
    ld a, [$CC46]
    inc a
    ld [$CC46], a

Jump_084_427D::
    ldh a, [$FFC6]
    dec a
    dec a
    ld b, a

Jump_084_4282::
    push bc
    ldh a, [$FFCA]
    and a, $0F
    swap a
    ld de, Data_084_42C7
    add a, e
    ld e, a
    jr nc, Jump_084_4291
    inc d

Jump_084_4291::
    ld c, $0A
    call Func_084_43AC
    add a, e
    ld e, a
    jr nc, Jump_084_429B
    inc d

Jump_084_429B::
    ld a, [de]
    ld b, a
    ld c, $08
    call Func_084_43AC
    add a, b
    ld [hl+], a
    ld e, a
    ld d, $00
    sla e
    rl d
    ldh a, [$FFCA]
    ldh [$FFC9], a
    call Func_084_4327
    ldh a, [$FFC9]
    ld c, a
    ldh a, [$FFCA]
    swap a
    or a, c
    ld [hl+], a
    ld a, [$CC46]
    inc a
    ld [$CC46], a
    pop bc
    dec b
    jr nz, Jump_084_4282
    ret

Data_084_42C7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $2102C7, $60

Func_084_4327::
    push hl
    ld a, e
    add a, $01
    ld e, a
    ld a, d
    adc a, $40
    ld d, a
    ld a, $72
    ld b, a
    call Func_000_1872
    ld l, c
    inc de
    call Func_000_1872
    ld h, c

Jump_084_433C::
    call Func_000_09F3
    and a, $03
    jr z, Jump_084_433C
    push hl
    dec a
    add a, l
    ld l, a
    jr nc, Jump_084_434A
    inc h

Jump_084_434A::
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    call Func_000_1872
    pop hl
    ldh a, [$FFC9]
    cp a, c
    jr z, Jump_084_433C
    ld a, c
    ldh [$FFCA], a
    pop hl
    ret

Func_084_435C::
    push hl
    ld a, e
    add a, $01
    ld e, a
    ld a, d
    adc a, $40
    ld d, a
    ld a, $72
    ld b, a
    call Func_000_1872
    ld a, c
    ld l, a
    inc de
    call Func_000_1872
    ld a, c
    ld h, a
    push hl

Jump_084_4374::
    call Func_000_09F3
    and a, $03
    jr z, Jump_084_4374
    dec a
    add a, l
    ld l, a
    jr nc, Jump_084_4381
    inc h

Jump_084_4381::
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    call Func_000_1872
    ld a, c
    ldh [$FFC9], a
    pop hl

Jump_084_438C::
    call Func_000_09F3
    and a, $03
    jr z, Jump_084_438C
    push hl
    dec a
    add a, l
    ld l, a
    jr nc, Jump_084_439A
    inc h

Jump_084_439A::
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    call Func_000_1872
    pop hl
    ldh a, [$FFC9]
    cp a, c
    jr z, Jump_084_438C
    ld a, c
    ldh [$FFCA], a
    pop hl
    ret

Func_084_43AC::
    call Func_000_09F3
    ld a, [$CD04]
    and a, $0F
    cp a, c
    jr nc, Func_084_43AC
    ret

Func_084_43B8::
    ld hl, Data_084_4461

Jump_084_43BB::
    push hl
    ld a, [hl+]
    cp a, $FF
    jr nz, Jump_084_43C3
    pop hl
    ret

Jump_084_43C3::
    ld c, a
    ldh a, [$FF90]
    cp a, c
    jr nz, Jump_084_43E8
    ld a, [hl+]
    ld c, a
    ldh a, [$FF8F]
    cp a, c
    jr nz, Jump_084_43E8
    ld a, [hl+]
    ld c, a
    ldh a, [$FF92]
    cp a, c
    jr nz, Jump_084_43E8
    ld a, [hl+]
    ldh [$FFC6], a
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    call Func_000_181B
    jr nc, Jump_084_43E8
    pop hl
    push hl
    call Func_084_43F2

Jump_084_43E8::
    pop hl
    ld a, $08
    add a, l
    ld l, a
    jr nc, Jump_084_43F0
    inc h

Jump_084_43F0::
    jr Jump_084_43BB

Func_084_43F2::
    ldh a, [$FFC6]
    cp a, $FF
    jr z, Jump_084_4412
    ld a, $06
    add a, l
    ld l, a
    jr nc, Jump_084_43FF
    inc h

Jump_084_43FF::
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld a, e
    add a, $98
    ld e, a
    ld a, d
    adc a, $C1
    ld d, a
    ldh a, [$FFC6]
    ld [de], a
    inc a
    inc de
    ld [de], a
    ret

Jump_084_4412::
    ld a, $06
    add a, l
    ld l, a
    jr nc, Jump_084_4419
    inc h

Jump_084_4419::
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    push de
    ld a, e
    add a, $98
    ld e, a
    ld a, d
    adc a, $C1
    ld d, a
    ld a, $40
    ld [de], a
    inc a
    inc de
    ld [de], a
    ld a, $13
    add a, e
    ld e, a
    jr nc, Jump_084_4433
    inc d

Jump_084_4433::
    ld a, $50
    ld [de], a
    inc a
    inc de
    ld [de], a
    pop de
    ld a, [$C525]
    or a, a
    ret z
    ld a, $02
    ldh [$FF70], a
    ld a, e
    add a, $00
    ld e, a
    ld a, d
    adc a, $D0
    ld d, a
    ld a, $05
    ld [de], a
    inc de
    ld [de], a
    ld a, $13
    add a, e
    ld e, a
    jr nc, Jump_084_4457
    inc d

Jump_084_4457::
    ld a, $05
    ld [de], a
    inc de
    ld [de], a
    ld a, $00
    ldh [$FF70], a
    ret

Data_084_4461:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $210461, $361

Func_084_47C2::
    xor a, a
    ldh [$FFD0], a
    ldh a, [$FF8C]
    bit 3, a
    ret nz
    ld a, [$CC44]
    bit 7, a
    jp nz, Jump_084_48A9
    ldh a, [$FF90]
    cp a, $20
    ret c
    push af
    call Func_084_4A6A
    or a, a
    jr z, Jump_084_47E0
    pop af
    ret

Jump_084_47E0::
    pop af
    ld e, a
    ld hl, Data_084_49A1
    ldh a, [$FF8F]
    swap a
    ld c, a
    ldh a, [$FF92]
    or a, c
    ld c, a
    ldh a, [$FF8E]
    and a, $F0
    ld b, a
    ldh a, [$FF91]
    and a, $F0
    swap a
    or a, b
    ld b, a

Jump_084_47FB::
    push hl
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_084_481D
    cp a, e
    jr nz, Jump_084_4814
    ld a, [hl+]
    cp a, c
    jr nz, Jump_084_4814
    ld a, [hl+]
    cp a, b
    jr z, Jump_084_481B
    ld a, [hl]
    cp a, $FF
    jr z, Jump_084_4814
    cp a, b
    jr z, Jump_084_481B

Jump_084_4814::
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    jr Jump_084_47FB

Jump_084_481B::
    pop hl
    ret

Jump_084_481D::
    pop hl
    ldh a, [$FF90]
    ld d, a
    ld e, $00
    ld hl, Data_084_4887

Jump_084_4826::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_084_4870
    cp a, d
    jr z, Jump_084_4834
    inc e
    inc hl
    inc hl
    inc hl
    jr Jump_084_4826

Jump_084_4834::
    ld a, [$C88E]
    ld [$C83B], a
    or a, a
    jr z, Jump_084_4866
    ld a, [$C88F]
    ld [$C83C], a
    ld a, [$C890]
    ld [$C83D], a
    ld a, [$C891]
    ld [$C83E], a
    ld a, [$C891]
    bit 7, a
    jr nz, Jump_084_4866
    cp a, e
    jr nz, Jump_084_4866
    ld a, [$C88F]
    cp a, b
    jr nz, Jump_084_4870
    ld a, [$C890]
    cp a, c
    jr nz, Jump_084_4870
    ret

Jump_084_4866::
    inc hl
    ld a, [hl]
    cp a, b
    jr nz, Jump_084_4870
    inc hl
    cp a, c
    jr nz, Jump_084_4870
    ret

Jump_084_4870::
    ld a, $01
    ld [$C88E], a
    ld a, b
    ld [$C88F], a
    ld a, c
    ld [$C890], a
    ld a, e
    inc a
    ld [$C891], a
    ld a, $01
    ldh [$FFD0], a
    ret

Data_084_4887:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $20, $44, $00, $30, $44, $76, $48, $44, $B4, $70, $44, $B4, $A0, $44, $10, $A8
    db $44, $00, $B0, $44, $01, $B8, $44, $44, $C8, $44, $01, $D1, $44, $00, $DA, $44
    db $00, $FF

Jump_084_48A9::
    cp a, $80
    ret nz
    call Func_084_4A6A
    or a, a
    ret nz
    ldh a, [$FF8F]
    swap a
    ld c, a
    ldh a, [$FF92]
    or a, c
    ld c, a
    ldh a, [$FF8E]
    cp a, $40
    jr nz, Jump_084_48E4
    ldh a, [$FF91]
    cp a, $40
    jr nz, Jump_084_48E4
    ld hl, $CD7B

Jump_084_48C9::
    push hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_084_48E3
    dec hl
    dec hl
    dec hl
    ld a, [hl+]
    cp a, c
    jp z, Jump_084_499F
    ld a, [hl]
    cp a, c
    jp z, Jump_084_499F
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    jr Jump_084_48C9

Jump_084_48E3::
    pop hl

Jump_084_48E4::
    ldh a, [$FF91]
    cp a, $40
    jr nz, Jump_084_491A
    ld hl, $CD8B

Jump_084_48ED::
    push hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_084_4919
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    cp a, c
    jr nz, Jump_084_4912
    ldh a, [$FF8E]
    cp a, $40
    jp z, Jump_084_499F
    inc hl
    ld a, [hl]
    cp a, $04
    jr z, Jump_084_4912
    cp a, $05
    jr z, Jump_084_4912
    ldh a, [$FF8E]
    cp a, $50
    jp z, Jump_084_499F

Jump_084_4912::
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    jr Jump_084_48ED

Jump_084_4919::
    pop hl

Jump_084_491A::
    ld a, [$C88E]
    ld [$C83B], a
    or a, a
    jr z, Jump_084_495F
    ld a, [$C88F]
    ld [$C83C], a
    ld a, [$C890]
    ld [$C83D], a
    ld a, [$C891]
    ld [$C83E], a
    ld a, [$C891]
    bit 7, a
    jr z, Jump_084_495F
    and a, $7F
    ld b, a
    ld a, [$CC42]
    cp a, b
    jr nz, Jump_084_495F
    ldh a, [$FF8E]
    and a, $F0
    ld b, a
    ldh a, [$FF91]
    and a, $F0
    swap a
    or a, b
    ld b, a
    ld a, [$C88F]
    cp a, b
    jr nz, Jump_084_4978
    ld a, [$C890]
    cp a, c
    jr nz, Jump_084_4978
    ret

Jump_084_495F::
    ld a, [$CD08]
    cp a, c
    jr nz, Jump_084_4978
    ld a, [$CD09]
    ld b, a
    ldh a, [$FF8E]
    cp a, b
    jr nz, Jump_084_4978
    ld a, [$CD0A]
    ld b, a
    ldh a, [$FF91]
    cp a, b
    jr nz, Jump_084_4978
    ret

Jump_084_4978::
    ldh a, [$FF8E]
    and a, $F0
    ld b, a
    ldh a, [$FF91]
    and a, $F0
    swap a
    or a, b
    ld b, a
    ld a, $01
    ld [$C88E], a
    ld a, b
    ld [$C88F], a
    ld a, c
    ld [$C890], a
    ld a, [$CC42]
    or a, $80
    ld [$C891], a
    ld a, $01
    ldh [$FFD0], a
    ret

Jump_084_499F::
    pop hl
    ret

Data_084_49A1:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $2109A1, $C9

Func_084_4A6A::
    ld a, [$C8FE]
    cp a, $FF
    jr z, Jump_084_4A87
    ldh a, [$FF8E]
    and a, $F0
    ld c, a
    ldh a, [$FF91]
    swap a
    and a, $0F
    or a, c
    ld c, a
    ld a, [$C8FF]
    cp a, c
    jr nz, Jump_084_4A87
    ld a, $01
    ret

Jump_084_4A87::
    xor a, a
    ret

Func_084_4A89::
    xor a, a
    ldh [$FFB9], a
    ld a, [$CC44]
    bit 7, a
    jr nz, Jump_084_4AFE
    ldh a, [$FF90]
    ld c, a
    ld hl, Data_084_4ADC
    ld b, $00

Jump_084_4A9B::
    ld a, [hl]
    cp a, c
    jr z, Jump_084_4AA5
    inc b
    inc hl
    inc hl
    inc hl
    jr Jump_084_4A9B

Jump_084_4AA5::
    ld a, b
    ldh [$FFC6], a
    ldh a, [$FF8F]
    swap a
    ld c, a
    ldh a, [$FF92]
    or a, c
    ld c, a
    ld a, [$C83B]
    or a, a
    jr z, Jump_084_4ACE
    ld a, [$C83E]
    dec a
    cp a, b
    jr nz, Jump_084_4ACE
    ld a, [$C83D]
    cp a, c
    jp nz, Jump_084_4B46
    ld a, [$C83C]
    ld c, a
    call Func_084_4C04
    jr Jump_084_4B46

Jump_084_4ACE::
    inc hl
    inc hl
    ld a, [hl]
    cp a, c
    jr nz, Jump_084_4B46
    dec hl
    ld a, [hl]
    ld c, a
    call Func_084_4C04
    jr Jump_084_4B46

Data_084_4ADC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $20, $44, $00, $30, $44, $76, $48, $44, $B4, $70, $44, $B4, $A0, $44, $10, $A8
    db $44, $00, $B0, $44, $01, $B8, $44, $44, $C8, $44, $01, $D1, $44, $00, $DA, $44
    db $00, $FF

Jump_084_4AFE::
    ldh a, [$FF8F]
    swap a
    ld c, a
    ldh a, [$FF92]
    or a, c
    ld c, a
    ld a, [$C83B]
    or a, a
    jr z, Jump_084_4B2C
    ld a, [$C83E]
    bit 7, a
    jr z, Jump_084_4B2C
    and a, $7F
    ld b, a
    ld a, [$CC42]
    cp a, b
    jr nz, Jump_084_4B2C
    ld a, [$C83D]
    cp a, c
    jr nz, Jump_084_4B46
    ld a, [$C83C]
    ld c, a
    call Func_084_4C04
    jr Jump_084_4B46

Jump_084_4B2C::
    ld a, [$CD08]
    cp a, c
    jr nz, Jump_084_4B46
    ld a, [$CD09]
    and a, $F0
    ld c, a
    ld a, [$CD0A]
    and a, $F0
    swap a
    or a, c
    ld c, a
    call Func_084_4C04
    jr Jump_084_4B46

Jump_084_4B46::
    ld a, [$C88F]
    and a, $0F
    ld l, a
    ld e, a
    ld h, $00
    ld d, $00
    sla l
    rl h
    sla l
    rl h
    add hl, de
    sla l
    rl h
    sla l
    rl h
    sla l
    rl h
    ld a, [$C88F]
    and a, $F0
    swap a
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_084_4B73
    inc h

Jump_084_4B73::
    push hl
    ld a, l
    add a, $98
    ld l, a
    ld a, h
    adc a, $C1
    ld h, a
    ld [hl], $46
    inc hl
    ld [hl], $47
    ld a, $13
    add a, l
    ld l, a
    jr nc, Jump_084_4B88
    inc h

Jump_084_4B88::
    ld [hl], $56
    inc hl
    ld [hl], $57
    pop hl
    ld a, [$C525]
    or a, a
    jr z, Jump_084_4BD6
    ld c, $05
    ld a, [$CC44]
    bit 7, a
    jr nz, Jump_084_4BB9
    ld c, $03
    ldh a, [$FFC6]
    cp a, $04
    jr z, Jump_084_4BB9
    cp a, $0A
    jr z, Jump_084_4BB9
    ld c, $05
    cp a, $05
    jr z, Jump_084_4BB9
    cp a, $06
    jr z, Jump_084_4BB9
    cp a, $07
    jr z, Jump_084_4BB9
    ld c, $01

Jump_084_4BB9::
    ld a, $02
    ldh [$FF70], a
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $D0
    ld h, a
    ld a, c
    ld [hl+], a
    ld [hl], a
    ld a, $13
    add a, l
    ld l, a
    jr nc, Jump_084_4BCF
    inc h

Jump_084_4BCF::
    ld a, c
    ld [hl+], a
    ld [hl], a
    ld a, $00
    ldh [$FF70], a

Jump_084_4BD6::
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
    jr nc, Jump_084_4BFE
    inc d

Jump_084_4BFE::
    ld l, e
    ld h, d
    call Func_000_1E29
    ret

Func_084_4C04::
    ld a, c
    and a, $0F
    ld l, a
    ld e, a
    ld h, $00
    ld d, $00
    sla l
    rl h
    sla l
    rl h
    add hl, de
    sla l
    rl h
    sla l
    rl h
    sla l
    rl h
    ld a, c
    and a, $F0
    swap a
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_084_4C2D
    inc h

Jump_084_4C2D::
    push hl
    ld a, l
    add a, $98
    ld l, a
    ld a, h
    adc a, $C1
    ld h, a
    ld [hl], $40
    inc hl
    ld [hl], $41
    ld a, $13
    add a, l
    ld l, a
    jr nc, Jump_084_4C42
    inc h

Jump_084_4C42::
    ld [hl], $50
    inc hl
    ld [hl], $51
    pop hl
    ld a, [$C525]
    or a, a
    ret z
    ld c, $01
    ld a, [$CC44]
    bit 7, a
    jr nz, Jump_084_4C61
    ld a, b
    ld de, Data_084_4C7F
    add a, e
    ld e, a
    jr nc, Jump_084_4C5F
    inc d

Jump_084_4C5F::
    ld a, [de]
    ld c, a

Jump_084_4C61::
    ld a, $02
    ldh [$FF70], a
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $D0
    ld h, a
    ld a, c
    ld [hl+], a
    ld [hl], a
    ld a, $13
    add a, l
    ld l, a
    jr nc, Jump_084_4C77
    inc h

Jump_084_4C77::
    ld a, c
    ld [hl+], a
    ld [hl], a
    ld a, $00
    ldh [$FF70], a
    ret

Data_084_4C7F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $01, $03, $02, $02

Func_084_4C84::
    ld a, [$C88E]
    or a, a
    ret z
    ldh a, [$FFC6]
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
    jr z, Jump_084_4CB1
    ld a, [hl]
    ld c, a
    ld a, [$C891]
    bit 7, a
    ret nz
    dec a
    cp a, c
    ret nz
    ld a, $00
    ld [$C88E], a
    ret

Jump_084_4CB1::
    ld a, [hl]
    cp a, $FF
    ret z
    bit 7, a
    ret z
    and a, $3F
    ld c, a
    ld a, [$C891]
    bit 7, a
    ret z
    and a, $7F
    cp a, c
    ret nz
    ld a, $00
    ld [$C88E], a
    ret

Data_084_4CCB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_084_4D2B
    dw Data_084_4D5D
    dw Data_084_4D8F
    dw Data_084_4DC1
    dw Data_084_4DF3
    dw Data_084_4E35
    dw Data_084_4E77
    dw Data_084_4EB9
    dw Data_084_4EFB
    dw Data_084_4F3D
    dw Data_084_4F7F
    dw Data_084_4FC1
    dw Data_084_5003
    dw Data_084_5045
    dw Data_084_5087
    dw Data_084_50C9
    dw Data_084_510B
    dw Data_084_515D
    dw Data_084_51AF
    dw Data_084_5201
    dw Data_084_5253
    dw Data_084_52A5
    dw Data_084_52F7
    dw Data_084_5349
    dw Data_084_539B
    dw Data_084_53ED
    dw Data_084_543F
    dw Data_084_5491
    dw Data_084_54E3
    dw Data_084_5545
    dw Data_084_55A7
    dw Data_084_5609
    dw Data_084_566B
    dw Data_084_56DD
    dw Data_084_574F
    dw Data_084_57C1
    dw Data_084_5833
    dw Data_084_58A5
    dw Data_084_5917
    dw Data_084_5989
    dw Data_084_59FB
    dw Data_084_5A7D
    dw Data_084_5AFF
    dw Data_084_5B81
    dw Data_084_5C03
    dw Data_084_5C85
    dw Data_084_5D07
    dw Data_084_5D89

Data_084_4D2B:: ; heuristic: target of a monotone pointer table; C0
    db $03, $03, $0A, $9E, $E0, $C2, $00, $00, $00, $00, $0A, $9E, $E0, $C2, $00, $00
    db $00, $05, $03, $03, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00
    db $00, $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $FF

Data_084_4D5D:: ; heuristic: target of a monotone pointer table; C0
    db $03, $03, $A6, $09, $6A, $C8, $00, $00, $00, $00, $A6, $09, $6A, $C8, $00, $00
    db $00, $04, $03, $03, $01, $2C, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00
    db $00, $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $FF

Data_084_4D8F:: ; heuristic: target of a monotone pointer table; C0
    db $03, $03, $B1, $8E, $08, $C6, $00, $00, $00, $00, $00, $8E, $08, $C6, $00, $00
    db $00, $04, $03, $03, $01, $2C, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00
    db $00, $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $FF

Data_084_4DC1:: ; heuristic: target of a monotone pointer table; C0
    db $03, $02, $69, $E5, $0A, $00, $BB, $92, $C9, $7B, $00, $00, $00, $00, $00, $00
    db $00, $05, $03, $03, $00, $2C, $00, $00, $01, $2A, $00, $00, $00, $00, $00, $00
    db $00, $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $FF

Data_084_4DF3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $210DF3, $42

Data_084_4E35:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $210E35, $42

Data_084_4E77:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $210E77, $42

Data_084_4EB9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $210EB9, $42

Data_084_4EFB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $210EFB, $42

Data_084_4F3D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $210F3D, $42

Data_084_4F7F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $210F7F, $42

Data_084_4FC1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $210FC1, $42

Data_084_5003:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $211003, $42

Data_084_5045:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $211045, $42

Data_084_5087:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $211087, $42

Data_084_50C9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2110C9, $42

Data_084_510B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21110B, $52

Data_084_515D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21115D, $52

Data_084_51AF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2111AF, $52

Data_084_5201:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $211201, $52

Data_084_5253:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $211253, $52

Data_084_52A5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2112A5, $52

Data_084_52F7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2112F7, $52

Data_084_5349:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $211349, $52

Data_084_539B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21139B, $52

Data_084_53ED:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2113ED, $52

Data_084_543F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21143F, $52

Data_084_5491:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $211491, $52

Data_084_54E3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2114E3, $62

Data_084_5545:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $211545, $62

Data_084_55A7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2115A7, $62

Data_084_5609:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $211609, $62

Data_084_566B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21166B, $72

Data_084_56DD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2116DD, $72

Data_084_574F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21174F, $72

Data_084_57C1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2117C1, $72

Data_084_5833:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $211833, $72

Data_084_58A5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2118A5, $72

Data_084_5917:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $211917, $72

Data_084_5989:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $211989, $72

Data_084_59FB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2119FB, $82

Data_084_5A7D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $211A7D, $82

Data_084_5AFF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $211AFF, $82

Data_084_5B81:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $211B81, $82

Data_084_5C03:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $211C03, $82

Data_084_5C85:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $211C85, $82

Data_084_5D07:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $211D07, $82

Data_084_5D89:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $211D89, $82
    ds $21F5, $00
