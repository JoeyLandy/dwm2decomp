SECTION "Bank F1", ROMX[$4000], BANK[$F1]
    db $F1

Func_0F1_4001::
    ld a, [$C0A0]
    rst $00
    dw Jump_0F1_400B
    dw Jump_0F1_40FC
    dw Jump_0F1_414E

Jump_0F1_400B::
    ld a, [$C0A1]
    rst $00
    dw Jump_0F1_4013
    dw Jump_0F1_4057

Jump_0F1_4013::
    ld a, [$D095]
    or a, a
    call nz, Func_0F1_4866
    call Func_0F1_43E0
    call Func_0F1_41EE
    call Func_0F1_43B4
    call Func_0F1_42D9
    call Func_0F1_4811
    ld hl, $8F20
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0107
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld a, $1B
    ld [$C529], a
    xor a, a
    ld [$C528], a
    ld hl, $48AE
    ld b, $F0
    rst $10
    ld hl, $C0A1
    inc [hl]
    xor a, a
    ld [$CF8B], a
    ret

Jump_0F1_4057::
    ld a, [$C61D]
    or a, a
    jr nz, Jump_0F1_4062
    ld a, [$C562]
    jr Jump_0F1_40DC

Jump_0F1_4062::
    ld de, $4A6A
    ld hl, $C46E
    call Func_0F1_4870
    ld a, [$C563]
    and a, $C0
    jr z, Jump_0F1_407C
    ld a, [$C0A2]
    cp a, $01
    ret z
    call Func_0F1_42D9
    ret

Jump_0F1_407C::
    ld hl, $C46E
    bit 7, [hl]
    jr z, Jump_0F1_4092
    res 7, [hl]
    call Func_0F1_43B4
    call Func_0F1_42D9
    call Func_0F1_4307
    call Func_0F1_43A0
    ret

Jump_0F1_4092::
    ld a, [$C562]
    bit 0, a
    jr z, Jump_0F1_40DC
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
    jr nc, Jump_0F1_40B3
    inc h

Jump_0F1_40B3::
    ld a, [hl]
    ld [$D081], a
    ld l, a
    ld h, $05
    ld de, $C150
    call Func_000_2E81
    ld de, $C60C
    ld hl, $C130
    call Func_000_2FE1
    ld hl, $4007
    ld b, $16
    rst $10
    ld hl, $C0A0
    inc [hl]
    xor a, a
    ld [$C0A1], a
    xor a, a
    ld [$C46F], a
    ret

Jump_0F1_40DC::
    bit 1, a
    jr z, Jump_0F1_40EC
    ld a, $40
    ld [$D067], a
    ld hl, $4339
    ld b, $03
    rst $10
    ret

Jump_0F1_40EC::
    bit 2, a
    ret z
    ld hl, $590C
    ld b, $16
    rst $10
    call Func_0F1_42D9
    call Func_0F1_4307
    ret

Jump_0F1_40FC::
    ld a, [$C0A1]
    rst $00
    dw Jump_0F1_4104
    dw Jump_0F1_4119

Jump_0F1_4104::
    call Func_0F1_422D
    call Func_0F1_4811
    ld a, $02
    ld [$C0A2], a
    ld a, $01
    ld [$C0A3], a
    ld hl, $C0A1
    inc [hl]
    ret

Jump_0F1_4119::
    ld de, Data_0F1_4A72
    ld hl, $C46F
    call Func_0F1_4870
    ld a, [$C562]
    bit 0, a
    jr z, Jump_0F1_4142
    ld a, [$C46F]
    and a, $01
    and a, a
    jr z, Jump_0F1_4133
    jr Jump_0F1_4145

Jump_0F1_4133::
    ld a, [$C46F]
    and a, $01
    add a, $02
    ld [$C0A0], a
    xor a, a
    ld [$C0A1], a
    ret

Jump_0F1_4142::
    bit 1, a
    ret z

Jump_0F1_4145::
    ld hl, $C0A0
    dec [hl]
    xor a, a
    ld [$C0A1], a
    ret

Jump_0F1_414E::
    ld a, [$C0A1]
    rst $00
    dw Jump_0F1_415A
    dw Jump_0F1_41C6
    dw Jump_0F1_41D1
    dw Jump_0F1_41E0

Jump_0F1_415A::
    ld a, [$D081]
    cp a, $1F
    jr z, Jump_0F1_4183
    cp a, $21
    jr z, Jump_0F1_4183
    ld b, $2B
    ld c, $2E
    cp a, c
    jr nc, Jump_0F1_416E
    cp a, b
    ccf

Jump_0F1_416E::
    jr c, Jump_0F1_4183
    ld b, $2F
    ld c, $40
    cp a, c
    jr nc, Jump_0F1_4179
    cp a, b
    ccf

Jump_0F1_4179::
    jr c, Jump_0F1_4183
    ld b, $54
    ld c, $5A
    jr c, Jump_0F1_4183
    jr Jump_0F1_4187

Jump_0F1_4183::
    ld a, $22
    jr Jump_0F1_41B9

Jump_0F1_4187::
    ld [$D7F1], a
    ld hl, Data_0F1_7284
    ld b, $F0
    rst $10
    ld a, $FF
    ld [$CF8B], a
    ld a, $69
    call Func_000_1278
    ld a, [$D082]
    ld hl, $C61D
    add a, l
    ld l, a
    jr nc, Jump_0F1_41A5
    inc h

Jump_0F1_41A5::
    ld [hl], $00
    ld hl, $4C48
    ld b, $16
    rst $10
    ld a, $40
    ld [$D067], a
    ld hl, $4339
    ld b, $03
    rst $10
    ret

Jump_0F1_41B9::
    ld [$C529], a
    ld hl, $C0A1
    inc [hl]
    ld a, $69
    call Func_000_1278
    ret

Jump_0F1_41C6::
    call Func_0F1_42B6
    call Func_0F1_4811
    ld hl, $C0A1
    inc [hl]
    ret

Jump_0F1_41D1::
    xor a, a
    ld [$C528], a
    ld hl, $48A0
    ld b, $F0
    rst $10
    ld hl, $C0A1
    inc [hl]
    ret

Jump_0F1_41E0::
    ld a, [$C52B]
    or a, a
    ret nz
    xor a, a
    ld [$C0A0], a
    xor a, a
    ld [$C0A1], a
    ret

Func_0F1_41EE::
    call Func_0F1_49E1
    ld e, $0B
    ld hl, Func_0F1_4001
    ld b, $33
    rst $10
    ld e, $0C
    ld hl, Func_0F1_4001
    ld b, $33
    rst $10
    ld a, [$C61D]
    or a, a
    ret z
    ld e, $0D
    ld hl, Func_0F1_4001
    ld b, $33
    rst $10
    ld a, [$C0A7]
    cp a, $02
    jr c, Jump_0F1_422C
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

Jump_0F1_422C::
    ret

Func_0F1_422D::
    call Func_0F1_41EE
    ld e, $32
    ld hl, Func_0F1_4001
    ld b, $33
    rst $10
    ld a, [$C46E]
    and a, $07
    ld hl, $4A6A
    call Func_0F1_4983
    ret

Func_0F1_4244:: ; heuristic: follows a terminator; C0
    call Func_0F1_422D
    ld e, $11
    ld hl, Func_0F1_4001
    ld b, $33
    rst $10
    ld e, $1B
    ld hl, Func_0F1_4001
    ld b, $33
    rst $10
    ld a, [$D081]
    ld hl, Data_0F1_4613
    add a, l
    ld l, a
    jr nc, Jump_0F1_4262
    inc h

Jump_0F1_4262::
    ld a, [hl]
    ld hl, Data_0F1_4676
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0F1_426C
    inc h

Jump_0F1_426C::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    call Func_0F1_49ED
    call Func_0F1_442F
    ret

Func_0F1_4276:: ; heuristic: follows a terminator; C0
    call Func_000_290E
    call Func_0F1_4244
    ld e, $10
    ld hl, Func_0F1_4001
    ld b, $33
    rst $10
    ld a, [$C46D]
    and a, $03
    ld hl, Func_0F1_4A5E
    call Func_0F1_4983
    ret

Func_0F1_4290:: ; heuristic: follows a terminator; C0
    call Func_0F1_422D
    ld e, $0F
    ld hl, Func_0F1_4001
    ld b, $33
    rst $10
    ret

Func_0F1_429C:: ; heuristic: follows a terminator; C0
    call Func_000_290E
    call Func_0F1_4290
    ld e, $10
    ld hl, Func_0F1_4001
    ld b, $33
    rst $10
    ld a, [$C46F]
    and a, $03
    ld hl, Data_0F1_4A72
    call Func_0F1_4983
    ret

Func_0F1_42B6::
    ld hl, $8800
    ld de, $1202
    call Func_000_2E98
    call Func_000_290E
    call Func_0F1_422D
    ld e, $10
    ld hl, Func_0F1_4001
    ld b, $33
    rst $10
    ld a, [$C46F]
    and a, $03
    ld hl, Data_0F1_4A72
    call Func_0F1_4983
    ret

Func_0F1_42D9::
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
    jr nz, Jump_0F1_42F5
    ld a, $6F

Jump_0F1_42F5::
    ld [$C529], a
    ld a, $06
    ld [$C528], a
    ld hl, $9230
    ld de, $1203
    call Func_0F1_4A23
    ret

Func_0F1_4307::
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
    jr nz, Jump_0F1_434F
    ld a, $08
    ld [$C528], a
    ld a, $00
    ld [$C529], a
    ld hl, $95C0
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $402B
    ld b, $08
    rst $10
    ld de, $C61E
    ld hl, $9650
    ld b, $03
    jr Jump_0F1_4363

Jump_0F1_434F::
    ld a, [$C0A6]
    and a, $0F
    add a, a
    add a, a
    ld de, $C61D
    add a, e
    ld e, a
    jr nc, Jump_0F1_435E
    inc d

Jump_0F1_435E::
    ld b, $04
    ld hl, $95C0

Jump_0F1_4363::
    ld a, $05
    ld [$C528], a

Jump_0F1_4368::
    ld a, [de]
    cp a, $FF
    jr nz, Jump_0F1_436E
    xor a, a

Jump_0F1_436E::
    inc de
    ld [$C529], a
    push bc
    push de
    push hl
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $402B
    ld b, $08
    rst $10
    pop hl
    ld de, $0090
    add hl, de
    pop de
    pop bc
    dec b
    jr nz, Jump_0F1_4368
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

Func_0F1_43A0::
    ld a, [$C0A3]
    or a, a
    jr z, Jump_0F1_43B3
    ld a, [$C0A6]
    and a, $0F
    add a, $E1
    ld hl, $990F
    call Func_000_1211

Jump_0F1_43B3::
    ret

Func_0F1_43B4::
    ld a, [$C0A7]
    dec a
    ld c, a
    ld a, [$C0A6]
    and a, $0F
    cp a, c
    jr nz, Jump_0F1_43D5
    ld a, [$C0A5]
    ld [$C0A2], a
    ld c, a
    ld a, [$C46E]
    cp a, c
    jr c, Jump_0F1_43DA
    dec c
    ld a, c
    ld [$C46E], a
    jr Jump_0F1_43DA

Jump_0F1_43D5::
    ld a, $04
    ld [$C0A2], a

Jump_0F1_43DA::
    ld hl, $C0A6
    res 7, [hl]
    ret

Func_0F1_43E0::
    ld hl, $C61D
    ld bc, $1800

Jump_0F1_43E6::
    ld a, [hl+]
    or a, a
    jr z, Jump_0F1_43FA
    cp a, $FF
    jr z, Jump_0F1_43F4
    inc c
    dec b
    jr nz, Jump_0F1_43E6
    jr Jump_0F1_43FA

Jump_0F1_43F4::
    dec hl
    xor a, a

Jump_0F1_43F6::
    ld [hl+], a
    dec b
    jr nz, Jump_0F1_43F6

Jump_0F1_43FA::
    ld b, c
    ld a, $04
    call Func_000_16BF
    ld a, c
    and a, $03
    jr z, Jump_0F1_4406
    inc b

Jump_0F1_4406::
    ld a, b
    cp a, $00
    jr nz, Jump_0F1_440D
    inc b
    ld a, b

Jump_0F1_440D::
    ld [$C0A3], a
    ld [$C0A7], a
    ld a, c
    and a, $03
    or a, a
    jr nz, Jump_0F1_441B
    ld a, $04

Jump_0F1_441B::
    ld [$C0A5], a
    ld a, [$C0A6]
    cp a, b
    jr nz, Jump_0F1_4429
    ld a, [$C0A5]
    jr Jump_0F1_442B

Jump_0F1_4429::
    ld a, $04

Jump_0F1_442B::
    ld [$C0A2], a
    ret

Func_0F1_442F:: ; heuristic: follows a terminator; C0
    ld a, [$C46D]
    ld c, a
    ld a, [$D081]
    ld hl, Data_0F1_4613
    add a, l
    ld l, a
    jr nc, Jump_0F1_443E
    inc h

Jump_0F1_443E::
    ld a, [hl]
    push af
    ld a, $0A
    ld [$0100], a
    ld a, $00
    ld [$4100], a
    pop af
    or a, a
    jr z, Jump_0F1_446D
    cp a, $01
    jr z, Jump_0F1_4472
    cp a, $02
    jr z, Jump_0F1_44BA
    cp a, $03
    jr z, Jump_0F1_4489
    cp a, $04
    jr z, Jump_0F1_448E
    cp a, $05
    jr z, Jump_0F1_4493
    cp a, $06
    jr z, Jump_0F1_4498
    cp a, $07
    jr z, Jump_0F1_449D
    jp Jump_0F1_450D

Jump_0F1_446D::
    ld a, c
    ld c, $5B
    jr Jump_0F1_4475

Jump_0F1_4472::
    ld a, c
    ld c, $5F

Jump_0F1_4475::
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
    jr Jump_0F1_44A3

Jump_0F1_4489::
    ld a, c
    ld c, $6B
    jr Jump_0F1_44A0

Jump_0F1_448E::
    ld a, c
    ld c, $63
    jr Jump_0F1_44A0

Jump_0F1_4493::
    ld a, c
    ld c, $65
    jr Jump_0F1_44A0

Jump_0F1_4498::
    ld a, c
    ld c, $67
    jr Jump_0F1_44A0

Jump_0F1_449D::
    ld a, c
    ld c, $69

Jump_0F1_44A0::
    call Func_000_1F49

Jump_0F1_44A3::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    call Func_000_16F5
    ld de, $C31D
    call Func_000_2123
    ld a, $C3
    ld [$C2DE], a
    ld [$C2DF], a
    jp Jump_0F1_4582

Jump_0F1_44BA::
    ld a, c
    call Func_000_24C5
    call Func_000_2391
    ld c, a
    ld [$C529], a
    ld a, $07
    ld [$C528], a
    ld hl, Data_0F1_45B0
    ld b, $00
    add hl, bc
    ld a, [hl]
    push af
    ld hl, $91A0
    ld de, $0901
    call Func_0F1_4A23
    pop af
    ld hl, $C319
    ld c, a
    ld b, c
    ld a, $1A

Jump_0F1_44E3::
    ld [hl+], a
    inc a
    dec b
    jr nz, Jump_0F1_44E3
    ld a, $09
    sub a, c
    ld b, a
    or a, a
    jr z, Jump_0F1_44F5
    ld a, $C3

Jump_0F1_44F1::
    ld [hl+], a
    dec b
    jr nz, Jump_0F1_44F1

Jump_0F1_44F5::
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
    jr Jump_0F1_4582

Jump_0F1_450D::
    ld a, c
    ld c, $A4
    call Func_000_1F49
    ld a, [hl]
    push af
    or a, a
    jr z, Jump_0F1_451A
    add a, $3F

Jump_0F1_451A::
    ld [$C529], a
    ld a, $05
    ld [$C528], a
    ld hl, $91A0
    ld de, $0901
    call Func_0F1_4A23
    pop af
    ld hl, Data_0F1_45CB
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0F1_4535
    inc h

Jump_0F1_4535::
    ld b, [hl]
    ld a, l
    ldh [$FFC6], a
    ld a, h
    ldh [$FFC7], a
    ld hl, $C2D9
    ld a, b
    ld c, a
    or a, a
    jr z, Jump_0F1_454C
    ld a, $1A

Jump_0F1_4546::
    ld [hl+], a
    inc a
    dec b
    jr nz, Jump_0F1_4546
    ld d, a

Jump_0F1_454C::
    ld a, $07
    sub a, c
    cp a, $00
    jr z, Jump_0F1_455A
    ld b, a
    ld a, $C3

Jump_0F1_4556::
    ld [hl+], a
    dec b
    jr nz, Jump_0F1_4556

Jump_0F1_455A::
    ld hl, $C319
    ld b, $07
    ld a, c
    or a, a
    jr z, Jump_0F1_457A
    push hl
    ldh a, [$FFC6]
    ld l, a
    ldh a, [$FFC7]
    ld h, a
    inc hl
    ld b, [hl]
    pop hl

Jump_0F1_456D::
    ld a, b
    cp a, $00
    jr z, Jump_0F1_4578
    ld a, d
    ld [hl+], a
    inc d
    dec b
    jr nz, Jump_0F1_456D

Jump_0F1_4578::
    ld b, $03

Jump_0F1_457A::
    ld a, $C3

Jump_0F1_457C::
    ld [hl+], a
    dec b
    jr nz, Jump_0F1_457C
    jr Jump_0F1_4599

Jump_0F1_4582::
    ld a, [$C46D]
    ld c, $55
    call Func_000_1F49
    bit 7, [hl]
    call nz, Func_0F1_459E
    bit 2, [hl]
    call nz, Func_0F1_45A4
    bit 0, [hl]
    call nz, Func_0F1_45AA

Jump_0F1_4599::
    xor a, a
    ld [$0100], a
    ret

Func_0F1_459E::
    ld a, $C2
    ld [$C2DF], a
    ret

Func_0F1_45A4::
    ld a, $C1
    ld [$C2DF], a
    ret

Func_0F1_45AA::
    ld a, $C0
    ld [$C2DE], a
    ret

Data_0F1_45B0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $08, $05, $04, $07, $05, $06, $08, $06, $09, $09, $07, $07, $06, $08, $08, $05
    db $06, $07, $05, $03, $05, $03, $07, $05, $08, $08, $04

Data_0F1_45CB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $3C45CB, $48

Data_0F1_4613:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $04, $05, $06
    db $07, $00, $01, $02, $02, $02, $02, $02, $02, $03, $03, $03, $03, $03
    ds $22, $00
    ds $23, $08

Data_0F1_4676:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_0F1_4688
    dw Data_0F1_46B0
    dw Data_0F1_46D8
    dw Data_0F1_4700
    dw Data_0F1_4728
    dw Data_0F1_4750
    dw Data_0F1_4778
    dw Data_0F1_47A0
    dw Data_0F1_47C8

Data_0F1_4688:: ; heuristic: target of a monotone pointer table; C0
    db $41, $01, $0C, $03, $FB, $FC, $ED
    ds $18, $C3
    db $BE, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3

Data_0F1_46B0:: ; heuristic: target of a monotone pointer table; C0
    db $41, $01, $0C, $03, $FD, $FE, $ED
    ds $18, $C3
    db $BE, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3

Data_0F1_46D8:: ; heuristic: target of a monotone pointer table; C0
    db $41, $01, $0C, $03, $F6, $F7, $F8, $F9, $FA, $0E, $0F, $10, $11, $12, $13, $C3
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $1A, $1B, $1C, $1D
    db $1E, $1F, $20, $21, $22, $C3, $C3, $C3

Data_0F1_4700:: ; heuristic: target of a monotone pointer table; C0
    db $41, $01, $0C, $03, $0B, $0C, $0D, $ED
    ds $20, $C3

Data_0F1_4728:: ; heuristic: target of a monotone pointer table; C0
    db $41, $01, $0C, $03, $FF, $00, $01, $ED
    ds $20, $C3

Data_0F1_4750:: ; heuristic: target of a monotone pointer table; C0
    db $41, $01, $0C, $03, $02, $03, $04, $ED
    ds $20, $C3

Data_0F1_4778:: ; heuristic: target of a monotone pointer table; C0
    db $41, $01, $0C, $03, $05, $06, $07, $ED
    ds $20, $C3

Data_0F1_47A0:: ; heuristic: target of a monotone pointer table; C0
    db $41, $01, $0C, $03, $08, $09, $0A, $ED
    ds $20, $C3

Data_0F1_47C8:: ; heuristic: target of a monotone pointer table; C0
    db $41, $01, $0C, $03
    ds $24, $C3
    db $AF, $EA, $A6, $C0, $AF, $EA, $6E, $C4, $CD, $E0, $43, $21, $A6, $C0, $2A, $BE
    db $38, $04, $2B, $35, $18, $F8, $CD, $07, $43, $AF, $EA, $A0, $C0, $EA, $A1, $C0
    db $C9

Func_0F1_4811::
    ld hl, $9800
    ld de, $C198
    ld bc, $1412

Jump_0F1_481A::
    push bc
    push hl
    push de

Jump_0F1_481D::
    ld a, [de]
    inc de
    call Func_000_1211
    ld a, l
    and a, $1F
    cp a, $1F
    jr z, Jump_0F1_482C
    inc hl
    jr Jump_0F1_4830

Jump_0F1_482C::
    ld a, l
    and a, $E0
    ld l, a

Jump_0F1_4830::
    dec b
    jr nz, Jump_0F1_481D
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
    jr nz, Jump_0F1_481A
    ret

Func_0F1_484A:: ; heuristic: follows a terminator; C0
    push bc
    push hl

Jump_0F1_484C::
    ld a, [de]
    inc de
    call Func_000_121F
    dec b
    jr nz, Jump_0F1_484C
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
    jr nz, Func_0F1_484A
    ret

Func_0F1_4866::
    ld hl, Data_0F1_5E82
    ld b, $02
    rst $10
    call Func_000_222B
    ret

Func_0F1_4870::
    ld a, [$C563]
    and a, $40
    jr z, Jump_0F1_4885
    ld a, [hl]
    and a, $0F
    dec a
    cp a, $FF
    jr nz, Jump_0F1_48C9
    ld a, [$C0A2]
    dec a
    jr Jump_0F1_48C9

Jump_0F1_4885::
    ld a, [$C563]
    and a, $80
    jr z, Jump_0F1_489A
    ld a, [$C0A2]
    ld c, a
    ld a, [hl]
    and a, $0F
    inc a
    cp a, c
    jr nz, Jump_0F1_48C9
    xor a, a
    jr Jump_0F1_48C9

Jump_0F1_489A::
    ld a, [$C0A3]
    or a, a
    jr z, Jump_0F1_4916
    cp a, $01
    jr z, Jump_0F1_4916
    ld b, a
    ld a, [$C563]
    and a, $20
    jr z, Jump_0F1_48B8
    ld a, [$C0A6]
    dec a
    cp a, $FF
    jr nz, Jump_0F1_48E7
    ld a, b
    dec a
    jr Jump_0F1_48E7

Jump_0F1_48B8::
    ld a, [$C563]
    and a, $10
    jr z, Jump_0F1_4916
    ld a, [$C0A6]
    inc a
    cp a, b
    jr nz, Jump_0F1_48E7
    xor a, a
    jr Jump_0F1_48E7

Jump_0F1_48C9::
    and a, $0F
    ld b, a
    ld a, [hl]
    and a, $0F
    cp a, b
    jr z, Jump_0F1_48DC
    push de
    call Func_0F1_493B
    pop de
    ld a, $69
    call Func_000_1278

Jump_0F1_48DC::
    ld [hl], b
    ld a, b
    call Func_0F1_4951
    xor a, a
    ld [$C5F0], a
    jr Jump_0F1_493A

Jump_0F1_48E7::
    ld [$C0A6], a
    inc a
    cp a, b
    jr nz, Jump_0F1_4909
    ld a, [hl]
    and a, $0F
    ld c, a
    ld a, [$C0A5]
    dec a
    cp a, c
    jr nc, Jump_0F1_4909
    jr z, Jump_0F1_4909
    push af
    push de
    ld a, [hl]
    and a, $0F
    call Func_0F1_493B
    pop de
    pop af
    ld [hl], a
    call Func_0F1_4951

Jump_0F1_4909::
    set 7, [hl]
    xor a, a
    ld [$C5F0], a
    ld a, $69
    call Func_000_1278
    jr Jump_0F1_493A

Jump_0F1_4916::
    ld a, [$C5F0]
    and a, $0F
    jr nz, Jump_0F1_493A
    ld a, [$C5F0]
    bit 4, a
    jr z, Jump_0F1_492C
    ld a, [hl]
    and a, $0F
    call Func_0F1_4951
    jr Jump_0F1_493A

Jump_0F1_492C::
    ld a, [hl]
    and a, $0F
    call Func_0F1_493B
    ld a, [$C5F0]
    set 3, a
    ld [$C5F0], a

Jump_0F1_493A::
    ret

Func_0F1_493B::
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_0F1_4941
    inc d

Jump_0F1_4941::
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

Func_0F1_4951::
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_0F1_4957
    inc d

Jump_0F1_4957::
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
    db $FA, $6D, $C4, $E6, $03, $21, $5E, $4A, $87, $85, $6F, $30, $01, $24, $2A, $66
    db $6F, $7D, $C6, $98, $6F, $7C, $CE, $29, $67, $36, $BB, $C9

Func_0F1_4983::
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0F1_4989
    inc h

Jump_0F1_4989::
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

Func_0F1_4997:: ; heuristic: follows a terminator; C0
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0F1_499D
    inc h

Jump_0F1_499D::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, $BC
    call Func_000_1211
    ret
    db $FA, $2D, $C5, $4F, $FA, $2E, $C5, $47, $C5, $FA, $2F, $C5, $4F, $FA, $30, $C5
    db $47, $C5, $7D, $EA, $2D, $C5, $7C, $EA, $2E, $C5, $7B, $EA, $2F, $C5, $7A, $EA
    db $30, $C5, $21, $2B, $40, $06, $08, $D7, $E1

Data_0F1_49CF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $7D, $EA, $2F, $C5, $7C, $EA, $30, $C5, $E1, $7D, $EA, $2D, $C5, $7C, $EA, $2E
    db $C5, $C9

Func_0F1_49E1::
    ld hl, $C198
    ld bc, $0240
    ld a, $C3
    call Func_000_0949
    ret

Func_0F1_49ED:: ; heuristic: follows a terminator; C0
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

Jump_0F1_49FB::
    push bc
    push hl

Jump_0F1_49FD::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_0F1_49FD
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_0F1_49FB
    ret

Func_0F1_4A0D:: ; heuristic: follows a terminator; C0
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0F1_4A13
    inc h

Jump_0F1_4A13::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, $08
    ld [$C528], a
    ld a, $05
    ld [$C529], a
    ld de, $0501

Func_0F1_4A23::
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
    ld hl, $402B
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

Func_0F1_4A5E:: ; heuristic: follows a terminator; C0
    ld h, c
    sbc a, b
    and a, c
    sbc a, b
    pop hl
    sbc a, b
    ld hl, Data_0F1_6199
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

Data_0F1_4A72:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A1, $98, $E1, $98, $21, $99, $61, $99, $47, $99, $87, $99, $C7, $99, $07, $9A
    db $61, $98, $A1, $98, $4A, $99, $8A, $99, $CA, $99, $0A, $9A, $64, $98, $A4, $98
    db $E4, $98, $2F, $99, $6F, $99, $82, $99, $84, $99, $86, $99, $88, $99, $8A, $99
    db $8C, $99, $8E, $99, $90, $99

Func_0F1_4AA8::
    ld hl, $C198
    ld bc, $02D0

Jump_0F1_4AAE::
    ld a, $C3
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_0F1_4AAE
    ld a, [$C525]
    and a, a
    ret z
    ld a, $02
    ldh [$FF70], a
    ld hl, $D000
    ld bc, $02D0

Jump_0F1_4AC5::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_0F1_4AC5
    xor a, a
    ldh [$FF70], a
    ret

Func_0F1_4AD0::
    ld a, [$C56C]
    and a, a
    ret nz
    ld a, [$D780]
    rst $00
    dw Jump_0F1_4AFD
    dw Jump_0F1_4B0B
    dw Jump_0F1_4B2E
    dw Jump_0F1_4B47
    dw Jump_0F1_4B9F
    dw Jump_0F1_4B0B
    dw Jump_0F1_4B0B
    dw Jump_0F1_4B0B
    dw Jump_0F1_4B0B
    dw Jump_0F1_4B0B
    dw Jump_0F1_4B0B
    dw Jump_0F1_4B0B
    dw Jump_0F1_5242
    dw Jump_0F1_52D8
    dw Jump_0F1_568B
    dw Jump_0F1_4B0B
    dw Jump_0F1_4B0B
    dw Jump_0F1_525E

Jump_0F1_4AFD::
    ld hl, $4069
    ld b, $1E
    rst $10
    ld a, [$D780]
    inc a
    ld [$D780], a
    ret

Jump_0F1_4B0B::
    ld a, [$C52B]
    bit 0, a
    ret nz
    ld hl, $D780
    ld bc, $006F

Jump_0F1_4B17::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_0F1_4B17
    ld a, $05
    ld [$C5DB], a
    ld a, $01
    ld [$C5DC], a
    ld a, $01
    ld [$C5DF], a
    ret

Jump_0F1_4B2E::
    ld a, [$D780]
    inc a
    ld [$D780], a
    xor a, a
    ld [$C528], a
    ld a, $01
    call Func_0F1_5834
    xor a, a
    ld [$C594], a
    ld hl, $D06A
    inc [hl]
    ret

Jump_0F1_4B47::
    ld a, [$D781]
    rst $00
    dw Jump_0F1_4B53
    dw Jump_0F1_4B65
    dw Jump_0F1_4B77
    dw Jump_0F1_4B8E

Jump_0F1_4B53::
    ld a, [$C52B]
    and a, a
    ret nz
    ld a, $07
    call Func_0F1_5834
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F1_4B65::
    ld a, [$C52B]
    and a, a
    ret nz
    ld a, $01
    ld [$C594], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F1_4B77::
    ld a, [$C58F]
    cp a, $01
    ret nz
    xor a, a
    ld [$C594], a
    ld a, $09
    call Func_0F1_5834
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F1_4B8E::
    ld a, [$C52B]
    and a, a
    ret nz
    xor a, a
    ld [$D781], a
    ld a, [$D780]
    inc a
    ld [$D780], a
    ret

Jump_0F1_4B9F::
    ld a, [$D781]
    rst $00
    dw Jump_0F1_4C40
    dw Jump_0F1_4C40
    dw Jump_0F1_4C40
    dw Jump_0F1_4C40
    dw Jump_0F1_4D07
    dw Jump_0F1_4C40
    dw Jump_0F1_4C40
    dw Jump_0F1_4C40
    dw Jump_0F1_4C08
    dw Jump_0F1_51CA
    dw Jump_0F1_51DC
    dw Jump_0F1_51F2
    dw Jump_0F1_4CCA
    dw Jump_0F1_4C40
    dw Jump_0F1_4BE5
    dw Jump_0F1_4D49
    dw Jump_0F1_4C4C
    dw Jump_0F1_4D6F
    dw Jump_0F1_4DFA
    dw Jump_0F1_4E38
    dw Jump_0F1_4E4A
    dw Jump_0F1_4E95
    dw Jump_0F1_4EA7
    dw Jump_0F1_4F6F
    dw Jump_0F1_4FAA
    dw Jump_0F1_5037
    dw Jump_0F1_50C3
    dw Jump_0F1_4E38
    dw Jump_0F1_51A4
    dw Jump_0F1_4F4C
    dw Jump_0F1_50FF
    dw Jump_0F1_4E38
    dw Jump_0F1_5220

Jump_0F1_4BE5::
    ld a, [$C52B]
    and a, a
    ret nz
    ld a, [$C58F]
    cp a, $FE
    jr nz, Jump_0F1_4C01
    ld a, $09
    ld [$D781], a
    ld a, $03
    call Func_0F1_5834
    ld a, $FE
    ld [$C594], a
    ret

Jump_0F1_4C01::
    ld hl, $40FA
    ld b, $15
    rst $10
    ret

Jump_0F1_4C08::
    ld a, [$C52B]
    and a, a
    ret nz
    ld a, [$C58F]
    cp a, $FE
    jr nz, Jump_0F1_4C24
    ld a, $09
    ld [$D781], a
    ld a, $03
    call Func_0F1_5834
    ld a, $FE
    ld [$C594], a
    ret

Jump_0F1_4C24::
    ld hl, $40FA
    ld b, $15
    rst $10
    ld a, [$D7F9]
    cp a, $FE
    ret nz
    ld a, $09
    ld [$D781], a
    ld a, $02
    call Func_0F1_5834
    ld a, $FE
    ld [$C594], a
    ret

Jump_0F1_4C40::
    ld a, [$C52B]
    and a, a
    ret nz
    ld hl, $40FA
    ld b, $15
    rst $10
    ret

Jump_0F1_4C4C::
    ld a, [$D7B4]
    cp a, $FF
    jr z, Jump_0F1_4C64
    ld a, [$C52B]
    and a, a
    ret nz
    ld hl, $40FA
    ld b, $15
    rst $10
    ld a, $09
    call Func_0F1_5834
    ret

Jump_0F1_4C64::
    ld a, [$D782]
    rst $00
    dw Jump_0F1_4C78
    dw Jump_0F1_4C8E
    dw Jump_0F1_4CA0
    dw Jump_0F1_4CB7
    dw Jump_0F1_4C78
    dw Jump_0F1_4C8E
    dw Jump_0F1_4CA0
    dw Jump_0F1_4CB7

Jump_0F1_4C78::
    ld a, [$C52B]
    and a, a
    ret nz
    xor a, a
    ld [$C594], a
    ld a, [$D782]
    inc a
    ld [$D782], a
    ld a, $07
    call Func_0F1_5834
    ret

Jump_0F1_4C8E::
    ld a, [$C52B]
    and a, a
    ret nz
    ld a, [$D782]
    inc a
    ld [$D782], a
    ld a, $01
    ld [$C594], a
    ret

Jump_0F1_4CA0::
    ld a, [$C58F]
    cp a, $01
    ret nz
    xor a, a
    ld [$C594], a
    ld a, $09
    call Func_0F1_5834
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_0F1_4CB7::
    ld a, [$C52B]
    and a, a
    ret nz
    ld hl, $40FA
    ld b, $15
    rst $10
    xor a, a
    ld [$D7B4], a
    ld [$D782], a
    ret

Jump_0F1_4CCA::
    ld a, [$C52B]
    and a, a
    ret nz
    ld a, [$D782]
    and a, a
    jr nz, Jump_0F1_4CE2
    ld a, $04
    call Func_0F1_5834
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_0F1_4CE2::
    ld hl, Data_01F_40FA
    ld b, $15
    rst $10
    ld de, Data_01F_4510
    ld hl, $8EE0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4450
    ld hl, $8EF0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    xor a, a
    ld [$D782], a
    ret

Jump_0F1_4D07::
    ld hl, Data_0F1_5D84
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld a, [hl]
    ld b, a
    push af
    ld a, $C7
    ld [$D7F1], a
    call Func_0F1_5969
    ld de, Data_0F1_5A36
    ld hl, $C36C
    ld bc, $0C05
    call Func_0F1_5990
    pop af
    ld [$D7F1], a
    ld hl, $C386
    ld a, l
    ld [$D7F2], a
    ld a, h
    ld [$D7F3], a
    ld hl, Data_0F1_688D
    ld b, $15
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F1_4D49::
    ld a, [$C52B]
    and a, a
    ret nz

Func_0F1_4D4E::
    ld bc, $0005
    ld hl, $0278
    ld de, $00AC
    xor a, a
    ld [$D7F1], a
    ld a, $08
    ld [$D7F2], a
    call Func_0F1_58FA
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$D7B4], a
    ret

Jump_0F1_4D6F::
    ld a, [$C52B]
    and a, a
    ret nz
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld hl, Data_0F1_5D84
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    push hl
    ld a, [hl]
    ld c, $56
    call Func_000_1F80
    ldh a, [$FFC6]
    cp a, $0A
    jr nc, Jump_0F1_4DAB
    pop hl
    xor a, a
    ld [$1FFF], a
    ld a, [$D781]
    dec a
    dec a
    ld [$D781], a
    ld a, $05
    call Func_0F1_5834
    ret

Jump_0F1_4DAB::
    pop hl
    ld c, [hl]
    ld a, [$C6FD]
    ld b, a
    ld de, $C6FE

Jump_0F1_4DB4::
    ld a, [de]
    cp a, c
    jr z, Jump_0F1_4DBE
    inc de
    dec b
    jr nz, Jump_0F1_4DB4
    jr Jump_0F1_4DD0

Jump_0F1_4DBE::
    xor a, a
    ld [$1FFF], a
    ld a, [$D781]
    dec a
    dec a
    ld [$D781], a
    ld a, $06
    call Func_0F1_5834
    ret

Jump_0F1_4DD0::
    ld hl, Data_0F1_5D84
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld a, [hl]
    ld [$D7B4], a
    ld a, [$D7AB]
    ld [$D7B5], a
    ld a, [$D7AF]
    ld [$D7B6], a
    xor a, a
    ld [$1FFF], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F1_4DFA::
    ld a, [$C52B]
    and a, a
    ret nz
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld a, [$D7B4]
    ld c, $A5
    call Func_000_1682
    ld de, $A000
    add hl, de
    ld de, $C986
    ld b, $A5

Jump_0F1_4E19::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_0F1_4E19
    xor a, a
    ld [$1FFF], a
    ld a, $07
    call Func_0F1_5834
    call Func_0F1_4D4E
    call Func_0F1_5A07
    ld bc, $140D
    ld de, $01CC
    call Func_0F1_59CA
    ret

Jump_0F1_4E38::
    ld a, [$C52B]
    and a, a
    ret nz
    ld a, [$D781]
    inc a
    ld [$D781], a
    ld a, $01
    ld [$C594], a
    ret

Jump_0F1_4E4A::
    ld a, [$C58F]
    cp a, $01
    jr z, Jump_0F1_4E64
    cp a, $FE
    ret nz
    ld a, $09
    ld [$D781], a
    ld a, $03
    call Func_0F1_5834
    ld a, $FE
    ld [$C594], a
    ret

Jump_0F1_4E64::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ld a, $A5
    ld [$C592], a
    xor a, a
    ld [$C593], a
    ld hl, $C986
    ld a, l
    ld [$C595], a
    ld a, h
    ld [$C596], a
    ld hl, $CA2B
    ld a, l
    ld [$C590], a
    ld a, h
    ld [$C591], a
    ld a, $FF
    ld [$C594], a
    ld a, $01
    ld [$C58C], a
    ret

Jump_0F1_4E95::
    ld a, [$C58F]
    cp a, $F0
    ret nz
    xor a, a
    ld [$C58C], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F1_4EA7::
    ld a, [$C52B]
    and a, a
    ret nz
    ld hl, $C994
    ld a, [$C994]
    and a, $01
    ld b, a
    ld a, [$CA39]
    and a, $01
    cp a, b
    jr nz, Jump_0F1_4ED1
    ld a, $08
    call Func_0F1_5834
    ld a, $10
    ld [$D781], a
    xor a, a
    ld [$D782], a
    ld a, $FF
    ld [$D7B4], a
    ret

Jump_0F1_4ED1::
    ld hl, Data_0F1_5F91
    ld b, $0E
    rst $10
    ld a, [$D7F5]
    cp a, $03
    jr nz, Jump_0F1_4EF2

Jump_0F1_4EDE::
    ld a, $0A
    call Func_0F1_5834
    ld a, $10
    ld [$D781], a
    xor a, a
    ld [$D782], a
    ld a, $FF
    ld [$D7B4], a
    ret

Jump_0F1_4EF2::
    cp a, $02
    jr nz, Jump_0F1_4F12
    ld a, [$C9DC]
    cp a, $28
    jr c, Jump_0F1_4EDE
    ld a, [$C9F3]
    cp a, $05
    jr c, Jump_0F1_4EDE
    ld a, [$CA81]
    cp a, $28
    jr c, Jump_0F1_4EDE
    ld a, [$CA98]
    cp a, $05
    jr c, Jump_0F1_4EDE

Jump_0F1_4F12::
    xor a, a
    ld [$C594], a
    ld a, $0F
    ld [$C529], a
    xor a, a
    ld [$C528], a
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $96
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld [hl], $0D
    ld hl, $537E
    ld b, $0E
    rst $10
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, $0B
    call Func_0F1_5834
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F1_4F4C::
    ld a, [$C52B]
    and a, a
    ret nz
    ld a, $02
    ld [$D7F1], a
    ld hl, $5688
    ld b, $0E
    rst $10
    ld a, [$D7F5]
    cp a, $FF
    ret nz
    ld a, [$D781]
    inc a
    ld [$D781], a
    ld a, $0D
    call Func_0F1_5834
    ret

Jump_0F1_4F6F::
    ld a, [$C52B]
    and a, a
    ret nz
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [$D7FA], a
    ld a, $6C
    call Func_000_1278
    ld de, Data_0F1_5A90
    ld hl, $C3E7
    ld bc, $0907
    call Func_0F1_5990
    call Func_0F1_5A07
    ld bc, $140D
    ld de, $01CC
    call Func_0F1_59CA
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F1_4FAA::
    ld a, [$C52B]
    and a, a
    ret nz
    ld a, [$C58F]
    cp a, $FE
    jr nz, Jump_0F1_4FC9
    call Func_0F1_5812
    ld a, $09
    ld [$D781], a
    ld a, $03
    call Func_0F1_5834
    ld a, $FE
    ld [$C594], a
    ret

Jump_0F1_4FC9::
    call Func_0F1_5842
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_0F1_4FD7
    cp a, $FF
    jr z, Jump_0F1_4FEA
    ret

Jump_0F1_4FD7::
    call Func_0F1_5812
    ld a, $09
    ld [$D781], a
    ld a, $02
    call Func_0F1_5834
    ld a, $FE
    ld [$C594], a
    ret

Jump_0F1_4FEA::
    ld a, [$D7FA]
    cp a, $02
    jr z, Jump_0F1_4FD7
    cp a, $01
    jr z, Jump_0F1_500C
    ld a, [$D7FA]
    ld b, $BC
    ld hl, Data_0F1_5ACF
    call Func_0F1_5A28
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$D782], a
    ret

Jump_0F1_500C::
    ld a, [$D780]
    ld [$D7B2], a
    ld a, [$D781]
    ld [$D7B3], a
    ld a, [$D7AB]
    ld [$D7B5], a
    ld a, [$D7AF]
    ld [$D7B6], a
    xor a, a
    ld [$D781], a
    ld [$D782], a
    ld [$D7AB], a
    ld [$D7AF], a
    ld a, $0D
    ld [$D780], a
    ret

Jump_0F1_5037::
    ld a, [$C52B]
    and a, a
    ret nz
    ld a, [$D782]
    and a, a
    jr z, Jump_0F1_5048
    cp a, $01
    jr z, Jump_0F1_505A
    jr Jump_0F1_5067

Jump_0F1_5048::
    ld hl, Data_0F1_6EA5
    ld b, $15
    rst $10
    ld a, [$D7FA]
    and a, a
    jr z, Jump_0F1_5059
    ld a, $16
    call Func_0F1_5834

Jump_0F1_5059::
    ret

Jump_0F1_505A::
    ld a, $0C
    call Func_0F1_5834
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_0F1_5067::
    xor a, a
    ld [$D782], a
    ld de, Data_01F_4230
    ld hl, $9700
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4290
    ld hl, $9710
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4370
    ld hl, $9720
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4180
    ld hl, $9760
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    xor a, a
    ld [$D7FA], a
    ld de, Data_0F1_5A72
    ld hl, $C412
    ld bc, $0605
    call Func_0F1_5990
    call Func_0F1_5A07
    ld bc, $140D
    ld de, $01CC
    call Func_0F1_59CA
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F1_50C3::
    ld a, [$C52B]
    and a, a
    ret nz
    ld hl, Data_0F1_6540
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_0F1_50DC
    cp a, $FF
    jr z, Jump_0F1_50E7
    ret

Jump_0F1_50DC::
    ld a, $0B
    call Func_0F1_5834
    ld a, $17
    ld [$D781], a
    ret

Jump_0F1_50E7::
    ld a, [$D7FA]
    cp a, $01
    jr z, Jump_0F1_50DC
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$D782], a
    ld a, $07
    call Func_0F1_5834
    ret

Jump_0F1_50FF::
    ld a, [$C52B]
    and a, a
    ret nz
    ld a, [$D782]
    and a, a
    jr z, Jump_0F1_511B
    ld a, [$D7EE]
    and a, a
    ret nz
    xor a, a
    ld [$D782], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F1_511B::
    ld a, [$D7B5]
    ld [$D7AB], a
    ld a, [$D7B6]
    ld [$D7AF], a
    ld hl, Data_0F1_5D84
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld a, [hl]
    ld [$D7F1], a
    ld a, $01
    ld [$D7F2], a
    ld hl, Data_0F1_7E96
    ld b, $14
    rst $10
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld a, [$D7F6]
    ld l, a
    ld a, [$D7F7]
    ld h, a
    ld de, $CAD0
    ld b, $A5

Jump_0F1_515A::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_0F1_515A
    xor a, a
    ld [$1FFF], a
    xor a, a
    ld [$C8C3], a
    ld [$C8C4], a
    ld hl, $CADB
    ld a, [hl+]
    ld [$D7F1], a
    ld a, [hl]
    ld [$D7F2], a
    ld de, $C7FC
    ld a, e
    ld [$D7F3], a
    ld a, d
    ld [$D7F4], a
    ld hl, Data_0F1_68F3
    ld b, $15
    rst $10
    ld hl, $D7E0
    ld b, $07

Jump_0F1_518C::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_0F1_518C
    ld hl, Data_0F1_6E64
    ld b, $15
    rst $10
    ld a, [$D782]
    inc a
    ld [$D782], a
    ld a, $01
    ld [$D7EE], a
    ret

Jump_0F1_51A4::
    ld a, [$C58F]
    cp a, $01
    jr z, Jump_0F1_51BE
    cp a, $FE
    ret nz
    ld a, $09
    ld [$D781], a
    ld a, $03
    call Func_0F1_5834
    ld a, $FE
    ld [$C594], a
    ret

Jump_0F1_51BE::
    xor a, a
    ld [$C594], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F1_51CA::
    ld a, [$C58F]
    cp a, $FE
    ret nz
    xor a, a
    ld [$C594], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F1_51DC::
    ld a, [$C52B]
    and a, a
    ret nz
    ld a, $07
    call Func_0F1_5834
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$D782], a
    ret

Jump_0F1_51F2::
    ld a, [$D782]
    rst $00
    dw Jump_0F1_51FA
    dw Jump_0F1_520C

Jump_0F1_51FA::
    ld a, [$C52B]
    and a, a
    ret nz
    ld a, $01
    ld [$C594], a
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_0F1_520C::
    ld a, [$C58F]
    cp a, $01
    ret nz
    xor a, a
    ld [$C594], a
    xor a, a
    ld [$D781], a
    ld a, $01
    ld [$D780], a
    ret

Jump_0F1_5220::
    ld a, [$C52B]
    and a, a
    ret nz
    ld a, [$C58F]
    cp a, $01
    ret nz
    xor a, a
    ld [$C594], a
    ld hl, $D780
    ld bc, $006F

Jump_0F1_5235::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_0F1_5235
    ld a, $01
    ld [$C94B], a
    ret

Jump_0F1_5242::
    ld hl, $4069
    ld b, $1E
    rst $10
    ld a, [$D781]
    cp a, $0A
    ret nz
    xor a, a
    ld [$D781], a
    ld [$D782], a
    ld a, [$D780]
    add a, $05
    ld [$D780], a
    ret

Jump_0F1_525E::
    ld a, [$D781]
    rst $00
    dw Jump_0F1_527D
    dw Func_0F1_5285
    dw Jump_0F1_5276
    dw Jump_0F1_5276
    dw Jump_0F1_5276
    dw Jump_0F1_4D07
    dw Jump_0F1_5293
    dw Jump_0F1_52B7
    dw Jump_0F1_5276
    dw Jump_0F1_5276

Jump_0F1_5276::
    ld hl, $40FA
    ld b, $15
    rst $10
    ret

Jump_0F1_527D::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_0F1_5285::
    ld hl, $4A0B
    ld b, $F2
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F1_5293::
    ld hl, $8A70
    ld bc, $0901
    call Func_000_1881
    ld hl, $8F80
    ld bc, $0501
    call Func_000_1881
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld hl, $D781
    inc [hl]
    ret

Jump_0F1_52B7::
    ld hl, Data_0F1_5D84
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld a, [hl]
    ld b, a
    ld [$D7F1], a
    ld hl, Data_0F1_5CD7
    ld b, $1D
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F1_52D8::
    ld a, [$D781]
    rst $00
    dw Jump_0F1_531F
    dw Jump_0F1_532D
    dw Jump_0F1_533C
    dw Jump_0F1_535A
    dw Jump_0F1_5379
    dw Jump_0F1_5387
    dw Jump_0F1_538E
    dw Jump_0F1_53D9
    dw Jump_0F1_531E
    dw Jump_0F1_531E
    dw Jump_0F1_531E
    dw Jump_0F1_531E
    dw Jump_0F1_531E
    dw Jump_0F1_531E
    dw Jump_0F1_5412
    dw Jump_0F1_5423
    dw Jump_0F1_543D
    dw Jump_0F1_5448
    dw Jump_0F1_546B
    dw Jump_0F1_5478
    dw Jump_0F1_549E
    dw Jump_0F1_54E9
    dw Jump_0F1_5526
    dw Jump_0F1_5532
    dw Jump_0F1_5540
    dw Jump_0F1_554E
    dw Jump_0F1_555B
    dw Jump_0F1_5569
    dw Jump_0F1_55AE
    dw Jump_0F1_55E9
    dw Jump_0F1_561B
    dw Jump_0F1_5644
    dw Jump_0F1_5656

Jump_0F1_531E::
    ret

Jump_0F1_531F::
    ld hl, Data_0F1_7494
    ld b, $1F
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F1_532D::
    ld hl, Data_0F1_49CF
    ld b, $F2
    rst $10
    ld hl, Data_0F1_7375
    ld b, $1F
    rst $10
    call Func_0F1_5344

Jump_0F1_533C::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_0F1_5344::
    ld hl, $8D00
    ld bc, $0501
    call Func_000_1881
    ld hl, $CA2C
    call Func_0F1_57BA
    ld de, $8D00
    call Func_000_21A1
    ret

Jump_0F1_535A::
    call Func_0F1_5A07
    ld de, Data_0F1_687F
    ld a, $14
    ld [$D7F3], a
    ld a, $12
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    call Func_0F1_57FB
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F1_5379::
    ld hl, $5002
    ld b, $F2
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F1_5387::
    ld hl, Data_0F1_73EC
    ld b, $1F
    rst $10
    ret

Jump_0F1_538E::
    ld a, [$C563]
    res 7, a
    res 6, a
    ld [$C563], a
    xor a, a
    ld [$D7F9], a
    ld hl, Data_0F1_66B6
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_0F1_53B0
    cp a, $FF
    jr z, Jump_0F1_53B8
    ret

Jump_0F1_53B0::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F1_53B8::
    call Func_0F1_5A07
    ld de, $0161
    add hl, de
    ld de, Data_0F1_651B
    ld a, $06
    ld [$D7F3], a
    ld a, $06
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    call Func_0F1_57FB
    ld a, $0E
    ld [$D781], a
    ret

Jump_0F1_53D9::
    call Func_0F1_5A07
    ld a, h
    ld [$D7F5], a
    ld a, l
    ld [$D7F6], a
    ld de, Data_0F1_5E12
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
    ld hl, Data_0F1_5D9A
    ld b, $1F
    rst $10
    xor a, a
    ld [$D781], a
    ld [$D782], a
    ld a, [$D780]
    inc a
    ld [$D780], a
    ret

Jump_0F1_5412::
    ld hl, $9200
    ld bc, $0F02
    call Func_000_1881
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F1_5423::
    ld hl, $8A70
    ld bc, $0901
    call Func_000_1881
    ld hl, $8F80
    ld bc, $0501
    call Func_000_1881
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F1_543D::
    call Func_0F1_57CD
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F1_5448::
    call Func_0F1_5A07
    ld de, $0068
    add hl, de
    ld de, Data_0F1_6577
    ld a, $0C
    ld [$D7F3], a
    ld a, $0F
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    call Func_0F1_57FB
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F1_546B::
    ld hl, $4AFE
    ld b, $F2
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a

Jump_0F1_5478::
    ld a, $6D
    ld [$D7F1], a
    xor a, a
    ld [$D7F2], a
    ld a, $EA
    ld [$D7F3], a
    ld a, $C7
    ld [$D7F4], a
    ld hl, $50E2
    ld b, $F2
    rst $10
    ld hl, $4B05
    ld b, $F2
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a

Jump_0F1_549E::
    ld a, [$CA36]
    ld [$D7F1], a
    ld a, [$CA37]
    ld [$D7F2], a
    xor a, a
    ld [$D7F3], a
    ld [$D7F4], a
    ld a, $80
    ld [$D7F5], a
    ld hl, Data_0F1_6973
    ld b, $1D
    rst $10
    ld a, $F0
    ldh [$FFBA], a
    ld hl, $4BD0
    ld b, $F2
    rst $10
    call Func_0F1_5A07
    ld de, $0160
    add hl, de
    ld de, Data_0F1_66DF
    ld a, $08
    ld [$D7F3], a
    ld a, $07
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    call Func_0F1_57FB
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F1_54E9::
    ld a, [$C563]
    res 7, a
    res 6, a
    ld [$C563], a
    xor a, a
    ld [$D7F9], a
    ld hl, Data_0F1_66B6
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_0F1_5517
    cp a, $FF
    jr z, Jump_0F1_550B
    ret

Jump_0F1_550B::
    xor a, a
    ldh [$FFBA], a
    ld a, [$D781]
    inc a
    inc a
    ld [$D781], a
    ret

Jump_0F1_5517::
    xor a, a
    ldh [$FFBA], a
    ld hl, Data_0F1_74E3
    ld b, $1F
    rst $10
    ld a, $04
    ld [$D781], a
    ret

Jump_0F1_5526::
    ld hl, $4F47
    ld b, $F2
    rst $10
    ld a, $0F
    ld [$D781], a
    ret

Jump_0F1_5532::
    ld hl, Data_0F1_753A
    ld b, $1F
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F1_5540::
    ld hl, Data_0F1_7591
    ld b, $1F
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F1_554E::
    ld hl, Data_0F1_7601
    ld b, $1F
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a

Jump_0F1_555B::
    ld hl, $4BFC
    ld b, $F2
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F1_5569::
    ld a, [$C563]
    res 7, a
    res 6, a
    ld [$C563], a
    xor a, a
    ld [$D7F9], a
    ld hl, Data_0F1_66B6
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_0F1_558B
    cp a, $FF
    jr z, Jump_0F1_559C
    ret

Jump_0F1_558B::
    ld hl, $9200
    ld bc, $1504
    call Func_000_290E
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F1_559C::
    call Func_0F1_573E
    ld hl, Data_0F1_76B5
    ld b, $1F
    rst $10
    ld a, [$D781]
    add a, $03
    ld [$D781], a
    ret

Jump_0F1_55AE::
    ld a, [$D782]
    and a, a
    jr nz, Jump_0F1_55DB
    ld hl, $9200
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $1504
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    call Func_000_290E
    ld hl, Data_0F1_7754
    ld b, $1F
    rst $10
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_0F1_55DB::
    ld hl, Data_0F1_49CF
    ld b, $F2
    rst $10
    call Func_0F1_5285
    xor a, a
    ld [$D782], a
    ret

Jump_0F1_55E9::
    ld hl, $4F47
    ld b, $F2
    rst $10
    ld hl, $8A70
    ld bc, $0901
    call Func_000_1881
    call Func_0F1_57CD
    ld de, Data_01F_4AD0
    ld hl, $96F0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, $11
    ld [$D781], a
    ret

Jump_0F1_561B::
    call Func_0F1_5A07
    ld de, $0008
    add hl, de
    ld de, Data_0F1_63D7
    ld a, $0C
    ld [$D7F3], a
    ld a, $12
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    call Func_0F1_57FB
    ld hl, $4E76
    ld b, $F2
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F1_5644::
    ld hl, $4C36
    ld b, $F2
    rst $10
    ld a, $F0
    ldh [$FFBA], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F1_5656::
    ld a, [$C563]
    res 7, a
    res 6, a
    ld [$C563], a
    xor a, a
    ld [$D7F9], a
    ld hl, Data_0F1_66B6
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    jr z, Jump_0F1_5678
    cp a, $FE
    jr z, Jump_0F1_5679
    cp a, $FF
    jr z, Jump_0F1_5682

Jump_0F1_5678::
    ret

Jump_0F1_5679::
    xor a, a
    ldh [$FFBA], a
    ld a, $17
    ld [$D781], a
    ret

Jump_0F1_5682::
    xor a, a
    ldh [$FFBA], a
    ld a, $07
    ld [$D781], a
    ret

Jump_0F1_568B::
    ld a, [$D781]
    rst $00
    dw Jump_0F1_56A3
    dw Func_0F1_5285
    dw Jump_0F1_56C8
    dw Jump_0F1_56C8
    dw Jump_0F1_56C8
    dw Jump_0F1_4D07
    dw Jump_0F1_5293
    dw Jump_0F1_52B7
    dw Jump_0F1_56DC
    dw Jump_0F1_56B7

Jump_0F1_56A3::
    ld a, [$D7B5]
    ld [$D7AB], a
    ld a, [$D7B6]
    ld [$D7AF], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F1_56B7::
    ld a, [$D780]
    push af
    ld a, $11
    ld [$D780], a
    ld hl, $40FA
    ld b, $15
    rst $10
    pop af
    ret

Jump_0F1_56C8::
    ld a, [$D780]
    push af
    ld a, $11
    ld [$D780], a
    ld hl, $40FA
    ld b, $15
    rst $10
    pop af
    ld [$D780], a
    ret

Jump_0F1_56DC::
    ld de, Data_0F1_5A90
    ld hl, $C3E7
    ld bc, $0907
    call Func_0F1_5990
    ld a, $0F
    ld [$C529], a
    xor a, a
    ld [$C528], a
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $96
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld [hl], $0D
    ld hl, $537E
    ld b, $0E
    rst $10
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_0F1_5719::
    ld a, [$CA36]
    ld [$D7F1], a
    ld a, [$CA37]
    ld [$D7F2], a
    xor a, a
    ld [$D7F3], a
    ld a, $90
    ld [$D7F4], a
    ld a, $40
    ld [$D7F5], a
    xor a, a
    ld [$D7F6], a
    ld hl, Data_0F1_6A3D
    ld b, $1D
    rst $10
    ret

Func_0F1_573E::
    ld hl, Data_0F1_5757
    ld de, $96E0
    call Func_0F1_57A7
    call Func_0F1_57A7
    ld de, $97C0
    call Func_0F1_57A7
    call Func_0F1_57A7
    call Func_0F1_57A7
    ret

Data_0F1_5757:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $3C5757, $50

Func_0F1_57A7::
    ld a, $10

Jump_0F1_57A9::
    push af
    di

Jump_0F1_57AB::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_0F1_57AB
    ld a, [hl+]
    ld [de], a
    ei
    inc de
    pop af
    dec a
    jr nz, Jump_0F1_57A9
    ret

Func_0F1_57BA::
    ld de, $C8CF
    ld c, $0A

Jump_0F1_57BF::
    ld a, [hl+]
    cp a, $F0
    jr z, Jump_0F1_57C9
    ld [de], a
    inc de
    dec c
    jr nz, Jump_0F1_57BF

Jump_0F1_57C9::
    ld a, $F0
    ld [de], a
    ret

Func_0F1_57CD::
    ld hl, $CA2C
    call Func_0F1_57BA
    ld de, $8F80
    call Func_000_21A1
    ld hl, $CA36
    ld a, [hl+]
    ld [$C529], a
    ld a, [hl]
    add a, $02
    ld [$C528], a
    ld hl, $C52D
    ld a, $70
    ld [hl+], a
    ld a, $8A
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld [hl], $09
    ld hl, $402B
    ld b, $08
    rst $10
    ret

Func_0F1_57FB::
    ld a, h
    ld [$D7F5], a
    ld a, l
    ld [$D7F6], a
    ld a, d
    ld [$D7F1], a
    ld a, e
    ld [$D7F2], a
    ld hl, Data_0F1_5D2A
    ld b, $1F
    rst $10
    ret

Func_0F1_5812::
    ld bc, $0007
    ld hl, $024F
    ld de, $0083
    xor a, a
    ld [$D7F1], a
    ld a, $09
    ld [$D7F2], a
    call Func_0F1_58FA
    call Func_0F1_5A07
    ld bc, $140D
    ld de, $01CC
    call Func_0F1_59CA
    ret

Func_0F1_5834::
    ld [$C529], a
    xor a, a
    ld [$C528], a
    ld hl, $5370
    ld b, $0E
    rst $10
    ret

Func_0F1_5842::
    ld a, [$C563]
    bit 6, a
    jr nz, Jump_0F1_5860
    bit 7, a
    jr nz, Jump_0F1_5876
    ld a, [$C562]
    bit 0, a
    jr nz, Jump_0F1_589C
    bit 1, a
    jr nz, Jump_0F1_58AA
    call Func_0F1_58B0
    xor a, a
    ld [$D7F9], a
    ret

Jump_0F1_5860::
    call Func_0F1_58CE
    ld a, [$D7FA]
    and a, a
    jr nz, Jump_0F1_5870
    ld a, $02
    ld [$D7FA], a
    jr Jump_0F1_588A

Jump_0F1_5870::
    dec a
    ld [$D7FA], a
    jr Jump_0F1_588A

Jump_0F1_5876::
    call Func_0F1_58CE
    ld a, [$D7FA]
    cp a, $02
    jr c, Jump_0F1_5886
    xor a, a
    ld [$D7FA], a
    jr Jump_0F1_588A

Jump_0F1_5886::
    inc a
    ld [$D7FA], a

Jump_0F1_588A::
    xor a, a
    ld [$D783], a
    call Func_0F1_58CA
    ld a, $69
    call Func_000_1278
    ld a, $FD
    ld [$D7F9], a
    ret

Jump_0F1_589C::
    call Func_0F1_58D2
    ld a, $69
    call Func_000_1278
    ld a, $FF
    ld [$D7F9], a
    ret

Jump_0F1_58AA::
    ld a, $FE
    ld [$D7F9], a
    ret

Func_0F1_58B0::
    ld a, [$C564]
    cp a, $14
    jr c, Func_0F1_58CA
    ld a, [$D783]
    inc a
    ld [$D783], a
    cp a, $10
    jr c, Func_0F1_58CA
    cp a, $18
    jr c, Func_0F1_58CE
    xor a, a
    ld [$D783], a

Func_0F1_58CA::
    ld b, $BB
    jr Jump_0F1_58D4

Func_0F1_58CE::
    ld b, $C3
    jr Jump_0F1_58D4

Func_0F1_58D2::
    ld b, $BC

Jump_0F1_58D4::
    ld a, [$D7FA]
    add a, a
    ld hl, Data_0F1_58F4
    add a, l
    ld l, a
    jr nc, Jump_0F1_58E0
    inc h

Jump_0F1_58E0::
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call Func_0F1_5A07
    pop de
    add hl, de
    call Func_000_24F8
    di
    call Func_000_120A
    ld a, b
    ld [hl], a
    ei
    ret

Data_0F1_58F4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $EC, $00, $2C, $01, $6C, $01

Func_0F1_58FA::
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
    ld e, l
    ld d, h
    pop hl
    ld a, [$D7F1]
    ld b, a
    ld a, [$D7F2]
    ld c, a
    call Func_0F1_594E
    pop de
    pop hl
    ld a, [$C525]
    and a, a
    jr z, Jump_0F1_593B
    push hl
    push de
    ld de, $D000
    add hl, de
    pop de
    push de
    push hl
    ld hl, $D000
    add hl, de
    ld e, l
    ld d, h
    pop hl
    ld a, [$D7F1]
    ld b, a
    ld a, [$D7F2]
    ld c, a
    call Func_0F1_5957
    pop de
    pop hl

Jump_0F1_593B::
    pop bc
    ld a, $14
    add a, l
    ld l, a
    jr nc, Jump_0F1_5943
    inc h

Jump_0F1_5943::
    ld a, $14
    add a, e
    ld e, a
    jr nc, Jump_0F1_594A
    inc d

Jump_0F1_594A::
    dec c
    jr nz, Func_0F1_58FA
    ret

Func_0F1_594E::
    ld a, [de]
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Func_0F1_594E
    ret

Func_0F1_5957::
    ld a, $02
    ldh [$FF70], a

Jump_0F1_595B::
    ld a, [de]
    and a, $07
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_0F1_595B
    xor a, a
    ldh [$FF70], a
    ret

Func_0F1_5969::
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld a, b
    ld c, $0D
    call Func_000_1F80
    ldh a, [$FFC6]
    and a, $0F
    ld [$D09D], a
    ld a, [$D7F1]
    ld [$D09E], a
    ld hl, Data_0F1_7A48
    ld b, $16
    rst $10
    xor a, a
    ld [$1FFF], a
    ret

Func_0F1_5990::
    push hl
    push bc

Jump_0F1_5992::
    push bc
    push hl

Jump_0F1_5994::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_0F1_5994
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_0F1_5992
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

Jump_0F1_59B6::
    push bc
    push hl

Jump_0F1_59B8::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_0F1_59B8
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_0F1_59B6
    xor a, a
    ldh [$FF70], a
    ret

Func_0F1_59CA::
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
    pop hl
    pop bc
    pop de
    ld a, [$C525]
    or a, a
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

Func_0F1_5A07::
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
    jr nc, Jump_0F1_5A27
    inc h

Jump_0F1_5A27::
    ret

Func_0F1_5A28::
    push bc
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0F1_5A2F
    inc h

Jump_0F1_5A2F::
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop bc
    ld a, b
    ld [de], a
    ret

Data_0F1_5A36:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $F8, $F9, $FA
    db $FB, $FC, $C3, $EA, $ED, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $B7, $B6, $C7, $A7, $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_0F1_5A72:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $70, $71, $72, $B7, $B6, $C3, $C3, $C3
    db $C3, $B7, $B6, $C3, $76, $73, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B5

Data_0F1_5A90:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $C3, $60, $61, $62, $62
    db $63, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $64, $65
    db $66, $67, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3
    db $68, $69, $6A, $6B, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_0F1_5ACF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FC, $C3, $24, $C4, $4C, $C4

Func_0F1_5AD5::
    call Func_000_0535
    ld a, [$D06A]
    cp a, $01
    jr z, Jump_0F1_5AE0
    ret

Jump_0F1_5AE0::
    ld a, [$D7EE]
    cp a, $02
    jr nz, Jump_0F1_5AF7
    ld hl, $42B3
    ld b, $1C
    rst $10
    ld a, $FC
    call Func_000_0DF2
    xor a, a
    ld [$D7EE], a
    ret

Jump_0F1_5AF7::
    call Func_0F1_5B0F
    ld a, [$D780]
    cp a, $07
    ret c
    call Func_0F1_5B8E
    call Func_0F1_5B38
    ld a, [$D7EE]
    and a, a
    ret z
    call Func_0F1_5BA5
    ret

Func_0F1_5B0F::
    ld a, [$D7DC]
    and a, a
    ret z
    ld a, $0A
    ld [$1FFF], a
    ld a, $01
    ld [$4100], a
    ld hl, $BB0F
    ld de, $022B
    add hl, de
    ld a, [hl]
    and a, a
    jr nz, Jump_0F1_5B31
    xor a, a
    ld [$4100], a
    ld [$1FFF], a
    ret

Jump_0F1_5B31::
    ld hl, Data_0F1_6403
    ld b, $15
    rst $10
    ret

Func_0F1_5B38::
    ld a, [$D7E8]
    cp a, $0C
    jr z, Jump_0F1_5B45
    cp a, $0D
    jp z, Jump_0F1_5B68
    ret

Jump_0F1_5B45::
    ld a, [$D7EA]
    and a, a
    ret nz
    ld a, [$D7E9]
    cp a, $15
    jr z, Jump_0F1_5B56
    cp a, $20
    jr z, Jump_0F1_5B5D
    ret

Jump_0F1_5B56::
    ld hl, Data_0F1_5C35
    ld b, $1D
    rst $10
    ret

Jump_0F1_5B5D::
    ld a, $01
    ldh [$FFB9], a
    ld hl, $5BF2
    ld b, $1D
    rst $10
    ret

Jump_0F1_5B68::
    ld a, [$D7EA]
    and a, a
    ret nz
    ld a, [$D7E9]
    cp a, $07
    ret nz
    ld hl, Data_0F1_76F3
    ld b, $1E
    rst $10
    ld c, $00
    ld a, l
    ld [$D7F1], a
    ld a, h
    ld [$D7F2], a
    ld a, $01
    ldh [$FFB9], a
    ld hl, Data_0F1_6899
    ld b, $1D
    rst $10
    ret

Func_0F1_5B8E::
    ld a, [$CB7D]
    and a, a
    ret z
    ld hl, $44CE
    ld b, $04
    rst $10
    ld a, [$D7F1]
    and a, a
    ret z
    ld hl, Data_0F1_6EC6
    ld b, $12
    rst $10
    ret

Func_0F1_5BA5::
    ld a, $01
    ld [$D7F1], a
    ld a, [$CEDC]
    ld [$D7F2], a
    ld a, [$CEDB]
    ld [$D7F3], a
    ld a, [$CED9]
    ld [$D7F4], a
    ld a, [$CEDA]
    ld [$D7F5], a
    ld hl, Data_0F1_5CA8
    ld b, $14
    rst $10
    ld a, [$D7F5]
    cp a, $FF
    ret nz
    ld hl, $C8CF
    ld de, $CECF
    ld b, $0A

Jump_0F1_5BD6::
    ld a, [hl+]
    cp a, $F0
    jr z, Jump_0F1_5BE2
    ld [de], a
    inc de
    dec b
    jr nz, Jump_0F1_5BD6
    jr Jump_0F1_5BE5

Jump_0F1_5BE2::
    ld a, $F0
    ld [de], a

Jump_0F1_5BE5::
    ld hl, $CECE
    ld de, $CA2B
    ld b, $A5

Jump_0F1_5BED::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_0F1_5BED
    ld hl, $CE9B
    ld b, $D8

Jump_0F1_5BF8::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_0F1_5BF8
    xor a, a
    ld [$CA99], a
    ld [$D7EE], a
    ret

Func_0F1_5C05:: ; heuristic: follows a terminator; C0
    ld hl, Data_0F1_5E04
    ld de, $C49F
    ld c, $40

Jump_0F1_5C0D::
    ld a, [hl+]
    ld [de], a
    inc de
    dec c
    jr nz, Jump_0F1_5C0D
    ret
    db $20, $02, $02, $FF, $02, $FF, $FE, $10, $FF, $10, $FF, $F0, $FF, $70, $FF, $30
    db $FF, $70, $FF, $C0, $02, $10, $03, $FE, $FF, $7C, $FF, $38, $FF, $7C, $FF, $C6
    db $02

Data_0F1_5C35:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $3C5C35, $73

Data_0F1_5CA8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $00, $8B, $00, $13, $00, $07, $02, $FF, $F2, $78, $FF, $84, $FF, $81, $FF
    db $78, $FF, $05, $FF, $85, $FF, $79, $02, $00, $03, $72, $FF, $15, $FF, $27, $FF
    db $44, $FF, $73, $02, $00, $0F, $00, $F0, $FF, $88, $FF, $8B, $FF, $F0, $FF

Data_0F1_5CD7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $3C5CD7, $53

Data_0F1_5D2A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $3C5D2A, $5A

Data_0F1_5D84:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $8F, $00, $27, $05, $8E, $86, $00, $BD, $04, $8F, $9D, $9C, $96, $97, $00, $A3
    db $0F, $13, $00, $B5, $04, $00

Data_0F1_5D9A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $3C5D9A, $6A

Data_0F1_5E04:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $EE, $3D, $FF, $7F, $D6, $5A, $63, $00, $12, $36, $FF, $7F, $D8, $42

Data_0F1_5E12:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $66, $00, $12, $36, $FF, $7F, $D8, $42, $BF, $30, $FF, $7F, $FF, $7F, $FF, $7F
    db $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F
    db $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F
    db $FF, $7F
    ds $3E, $00

Data_0F1_5E82:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $10F, $00

Data_0F1_5F91:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $208, $00

Data_0F1_6199:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $23E, $00

Data_0F1_63D7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $2C, $00

Data_0F1_6403:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $118, $00

Data_0F1_651B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $25, $00

Data_0F1_6540:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $37, $00

Data_0F1_6577:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $13F, $00

Data_0F1_66B6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $29, $00

Data_0F1_66DF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $1A0, $00

Data_0F1_687F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Data_0F1_688D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Data_0F1_6899:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $5A, $00

Data_0F1_68F3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $80, $00

Data_0F1_6973:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $CA, $00

Data_0F1_6A3D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $427, $00

Data_0F1_6E64:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $41, $00

Data_0F1_6EA5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $21, $00

Data_0F1_6EC6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $3BE, $00

Data_0F1_7284:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $F1, $00

Data_0F1_7375:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $77, $00

Data_0F1_73EC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $A8, $00

Data_0F1_7494:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $4F, $00

Data_0F1_74E3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $57, $00

Data_0F1_753A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $57, $00

Data_0F1_7591:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $70, $00

Data_0F1_7601:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $B4, $00

Data_0F1_76B5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $3E, $00

Data_0F1_76F3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $61, $00

Data_0F1_7754:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $2F4, $00

Data_0F1_7A48:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $44E, $00

Data_0F1_7E96:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $16A, $00
