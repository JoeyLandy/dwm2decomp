SECTION "Bank 31", ROMX[$4000], BANK[$31]
    db $31

Func_031_4001::
    call Func_000_08A6
    ld a, $02
    call Func_000_122D
    ld a, [$C524]
    or a, a
    jr z, Jump_031_401F
    ld a, $00
    ld [$C51F], a
    ld a, $00
    ld [$C520], a
    ld hl, $41CF
    ld b, $17
    rst $10

Jump_031_401F::
    xor a, a
    ldh [$FFA1], a
    ldh [$FFA2], a
    xor a, a
    ldh [$FFA5], a
    ldh [$FFA6], a
    ld hl, $9800
    ld bc, $0400
    ld a, $C3
    call Func_000_0949
    ld a, [$C525]
    or a, a
    jr z, Jump_031_404B
    ld a, $01
    ldh [$FF4F], a
    ld hl, $9800
    ld bc, $0400
    xor a, a
    call Func_000_0949
    xor a, a
    ldh [$FF4F], a

Jump_031_404B::
    ld hl, $99C1
    ld a, l
    ld [$C554], a
    ld a, h
    ld [$C555], a
    ld hl, Func_031_4001
    ld b, $19
    rst $10
    ld b, $31
    ld de, Data_031_7C1E
    ld hl, $8A40
    call Func_000_0C5A
    ld b, $31
    ld de, Data_031_7DFB
    ld hl, $8DF0
    call Func_000_0C5A
    ld hl, $8800
    ld de, $1202
    call Func_000_2E98
    ld hl, $99C1
    ld a, l
    ld [$C554], a
    ld a, h
    ld [$C555], a
    ld a, $FC
    call Func_000_0DF2
    ld a, $07
    ldh [$FF9F], a
    ld a, $FF
    ldh [$FFA0], a
    ld a, $00
    ldh [$FFA5], a
    ld a, $00
    ldh [$FFA1], a
    ld a, $03
    ld [$C5EC], a
    ld a, $0B
    jp Jump_000_077A

Func_031_40A5::
    ld a, [$C58A]
    or a, a
    jr z, Jump_031_40C9
    call Func_000_0535
    ld a, [$D802]
    cp a, $FF
    ret z
    ld hl, $4ADB
    ld b, $3A
    rst $10
    ld a, [$D800]
    cp a, $02
    ret nz
    di
    ld hl, Func_031_4001
    ld b, $32
    rst $10
    ei
    ret

Jump_031_40C9::
    call Func_031_4A23

Func_031_40CC::
    ld a, [$CFC8]
    rst $00
    dw Jump_031_40D6
    dw Jump_031_43B2
    dw Jump_031_43E6

Jump_031_40D6::
    ld a, [$CFC9]
    rst $00
    dw Jump_031_40E4
    dw Jump_031_40EE
    dw Jump_031_4106
    dw Jump_031_4243
    dw Jump_031_43A0

Jump_031_40E4::
    ld a, [$C56C]
    or a, a
    ret nz
    ld hl, $CFC9
    inc [hl]
    ret

Jump_031_40EE::
    call Func_031_746F
    call Func_031_7536
    ld hl, $CFC9
    inc [hl]
    xor a, a
    ld [$D868], a
    ld a, [$C58A]
    and a, a
    ret z
    xor a, a
    ld [$D7F1], a
    ret

Jump_031_4106::
    ld a, [$C58A]
    or a, a
    jp z, Jump_031_418E
    ld a, [$D7F1]
    rst $00
    dw Jump_031_4119
    dw Jump_031_4126
    dw Jump_031_4138
    dw Jump_031_416B

Jump_031_4119::
    ld a, [$D7F1]
    inc a
    ld [$D7F1], a
    ld a, $D2
    ld [$C594], a
    ret

Jump_031_4126::
    ld a, [$C58F]
    cp a, $D2
    ret nz
    xor a, a
    ld [$C594], a
    ld a, [$D7F1]
    inc a
    ld [$D7F1], a
    ret

Jump_031_4138::
    ld a, [$D7F1]
    inc a
    ld [$D7F1], a
    ld hl, $C60C
    ld a, l
    ld [$C595], a
    ld a, h
    ld [$C596], a
    ld hl, $000A
    ld a, l
    ld [$C592], a
    ld a, h
    ld [$C593], a
    ld hl, $C958
    ld a, l
    ld [$C590], a
    ld a, h
    ld [$C591], a
    ld a, $FF
    ld [$C594], a
    ld a, $01
    ld [$C58C], a
    ret

Jump_031_416B::
    ld a, [$C58F]
    cp a, $F0
    ret nz
    xor a, a
    ld [$C594], a
    xor a, a
    ld [$C58C], a
    xor a, a
    ld [$D7F1], a
    ld a, $F0
    ld [$C962], a
    ld de, $C958
    ld hl, $C130
    call Func_000_2FE1
    jp Jump_031_4213

Jump_031_418E::
    ld a, [$D960]
    ld l, a
    ld a, [$D961]
    ld h, a
    ld de, $C130
    call Func_031_423B
    ld a, [$D962]
    ld l, a
    ld a, [$D963]
    ld h, a
    ld de, $C140
    ld a, [$D890]
    cp a, $01
    call nz, Func_031_423B
    ld a, [$D964]
    ld l, a
    ld a, [$D965]
    ld h, a
    ld de, $C150
    ld a, [$D890]
    cp a, $03
    call z, Func_031_423B
    ld a, [$D890]
    cp a, $01
    jr z, Jump_031_420F
    ld a, [$D960]
    ld e, a
    ld a, [$D961]
    ld d, a
    ld a, [$D962]
    cp a, e
    jr nz, Jump_031_41F2
    ld a, [$D963]
    cp a, d
    jr nz, Jump_031_41F2
    ld a, [$D890]
    cp a, $02
    jr z, Jump_031_4213
    ld a, [$D964]
    cp a, e
    jr nz, Jump_031_421A
    ld a, [$D965]
    cp a, d
    jr nz, Jump_031_421A
    jr Jump_031_4213

Jump_031_41F2::
    ld a, [$D890]
    cp a, $02
    jr z, Jump_031_421E
    ld a, [$D962]
    ld e, a
    ld a, [$D963]
    ld d, a
    ld a, [$D964]
    cp a, e
    jr nz, Jump_031_4222
    ld a, [$D965]
    cp a, d
    jr nz, Jump_031_4222
    jr Jump_031_4226

Jump_031_420F::
    ld a, $00
    jr Jump_031_4228

Jump_031_4213::
    ld hl, $C130
    ld a, $01
    jr Jump_031_4228

Jump_031_421A::
    ld a, $02
    jr Jump_031_4228

Jump_031_421E::
    ld a, $03
    jr Jump_031_4228

Jump_031_4222::
    ld a, $04
    jr Jump_031_4228

Jump_031_4226::
    ld a, $05

Jump_031_4228::
    ld [$C529], a
    ld a, $00
    ld [$C528], a
    ld hl, Func_031_4001
    ld b, $2F
    rst $10
    ld hl, $CFC9
    inc [hl]
    ret

Func_031_423B::
    ld a, h
    add a, $02
    ld h, a
    call Func_000_2E81
    ret

Jump_031_4243::
    ld a, [$C52B]
    or a, a
    ret nz
    ld hl, $CFC8
    inc [hl]
    xor a, a
    ld [$CFC9], a
    xor a, a
    ld [$CFCA], a
    ld a, [$C58A]
    or a, a
    jp nz, Jump_031_42CF
    ld a, [$CFC5]
    cp a, $02
    jp nc, Jump_031_42CF
    call Func_000_095B
    ld a, [$C5E7]
    cp a, $08
    jr nc, Jump_031_4280
    ld a, [$C5E8]
    and a, $01
    add a, $0B
    ld [$C529], a
    ld a, $00
    ld [$D868], a
    ld c, $04
    jr Jump_031_429B

Jump_031_4280::
    call Func_000_095B
    ld a, [$C5E8]
    cp a, $08
    jr nc, Jump_031_42CF
    ld a, [$C5E7]
    and a, $01
    add a, $0D
    ld [$C529], a
    ld a, $01
    ld [$D868], a
    ld c, $00

Jump_031_429B::
    ld b, $03

Jump_031_429D::
    ld a, c
    ld hl, $DA5B
    add a, l
    ld l, a
    jr nc, Jump_031_42A6
    inc h

Jump_031_42A6::
    ld a, c
    call Func_000_3E54
    jr z, Jump_031_42B0
    ld [hl], $03
    jr Jump_031_42B2

Jump_031_42B0::
    ld [hl], $FF

Jump_031_42B2::
    inc c
    dec b
    jr nz, Jump_031_429D
    ld a, $00
    ld [$C528], a
    call Func_031_42D5
    ld hl, Func_031_4001
    ld b, $2F
    rst $10
    ld hl, $CFC8
    dec [hl]
    ld a, $04
    ld [$CFC9], a
    jr Jump_031_42D4

Jump_031_42CF::
    ld a, $01
    ld [$D891], a

Jump_031_42D4::
    ret

Func_031_42D5::
    ld a, [$D960]
    ld e, a
    ld a, [$D961]
    ld d, a
    ld a, [$D890]
    cp a, $01
    jr z, Jump_031_4305
    ld a, [$D962]
    cp a, e
    jr nz, Jump_031_4329
    ld a, [$D963]
    cp a, d
    jr nz, Jump_031_4329
    ld a, [$D890]
    cp a, $02
    jr z, Jump_031_430A
    ld a, [$D964]
    cp a, e
    jr nz, Jump_031_4329
    ld a, [$D965]
    cp a, d
    jr nz, Jump_031_4329
    jr Jump_031_430A

Jump_031_4305::
    call Func_031_4365
    jr Jump_031_4364

Jump_031_430A::
    ld hl, $C130
    ld [hl], $16
    inc hl
    ld [hl], $32
    inc hl
    ld [hl], $31
    inc hl
    ld [hl], $36
    inc hl
    ld [hl], $37
    inc hl
    ld [hl], $28
    inc hl
    ld [hl], $35
    inc hl
    ld [hl], $36
    inc hl
    ld [hl], $F0
    jr Jump_031_4364

Jump_031_4329::
    ld hl, $C130
    ld de, Data_031_438E
    ld b, $09
    ld a, [$C529]
    cp a, $0B
    jr nz, Jump_031_433F
    ld de, Data_031_4397
    ld b, $09
    jr Jump_031_435E

Jump_031_433F::
    cp a, $0C
    jr nz, Jump_031_434A
    ld de, Data_031_4397
    ld b, $0D
    jr Jump_031_435E

Jump_031_434A::
    cp a, $0D
    jr nz, Jump_031_4355
    ld de, Data_031_4397
    ld b, $0D
    jr Jump_031_435E

Jump_031_4355::
    cp a, $0E
    jr nz, Jump_031_435E
    ld b, $09
    ld de, Data_031_4397

Jump_031_435E::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_031_435E

Jump_031_4364::
    ret

Func_031_4365::
    ld a, [$C528]
    ld l, a
    ld a, [$C529]
    ld h, a
    push hl
    ld l, e
    ld a, d
    add a, $02
    ld h, a
    ld de, $C130
    call Func_000_2E81
    ld hl, $C130

Jump_031_437C::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_031_4384
    inc hl
    jr Jump_031_437C

Jump_031_4384::
    pop de
    ld a, e
    ld [$C528], a
    ld a, d
    ld [$C529], a
    ret

Data_031_438E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $30, $32, $31, $36, $37, $28, $35, $36, $F0

Data_031_4397:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $16, $32, $31, $36, $37, $28, $35, $36, $F0

Jump_031_43A0::
    ld a, [$C52B]
    or a, a
    ret nz
    ld hl, $CFC8
    inc [hl]
    xor a, a
    ld [$CFC9], a
    ld a, [$D868]
    or a, a
    ret

Jump_031_43B2::
    ld a, [$CFC9]
    rst $00
    dw Jump_031_43C0
    dw Jump_031_43CD
    dw Jump_031_43D1
    dw Jump_031_43D8
    dw Jump_031_43DF

Jump_031_43C0::
    ld a, [$C52B]
    or a, a
    ret nz
    call Func_031_4A65
    ld hl, $CFC9
    inc [hl]
    ret

Jump_031_43CD::
    call Func_031_4B10
    ret

Jump_031_43D1::
    ld hl, Func_031_4001
    ld b, $30
    rst $10
    ret

Jump_031_43D8::
    ld hl, $6157
    ld b, $3A
    rst $10
    ret

Jump_031_43DF::
    ld hl, $68C9
    ld b, $3A
    rst $10
    ret

Jump_031_43E6::
    ld a, [$CFC9]
    rst $00
    dw Jump_031_43FE
    dw Jump_031_440E
    dw Jump_031_445B
    dw Jump_031_449C
    dw Jump_031_4693
    dw Jump_031_46CA
    dw Jump_031_4840
    dw Jump_031_48E5
    dw Jump_031_48E5
    dw Jump_031_4975

Jump_031_43FE::
    ld a, $02
    call Func_000_122D
    call Func_031_746F
    call Func_031_7536
    ld hl, $CFC9
    inc [hl]
    ret

Jump_031_440E::
    ld a, $01
    ld [$C964], a
    call Func_031_656B
    ld a, [$D092]
    and a, $01
    jr z, Jump_031_4421
    ld a, $06
    jr Jump_031_4448

Jump_031_4421::
    call Func_031_498E
    ld a, [$D092]
    cp a, $02
    jr z, Jump_031_4443
    ld a, [$C58A]
    cp a, $01
    jr nz, Jump_031_4436
    ld a, $87
    jr Jump_031_4448

Jump_031_4436::
    ld a, [$D868]
    cp a, $01
    ld a, $07
    jr nc, Jump_031_4448
    ld a, $86
    jr Jump_031_4448

Jump_031_4443::
    ld a, [$D868]
    add a, $08

Jump_031_4448::
    ld [$C529], a
    ld a, $00
    ld [$C528], a
    ld hl, Func_031_4001
    ld b, $2F
    rst $10
    ld hl, $CFC9
    inc [hl]
    ret

Jump_031_445B::
    ld a, [$DC00]
    ld hl, $DC01
    and a, [hl]
    ld hl, $DC20
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, $DC40
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, $DC60
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, $DC80
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, $DCA0
    and a, [hl]
    inc hl
    and a, [hl]
    cp a, $FF
    call z, Func_031_4493
    ld a, [$C52B]
    or a, a
    ret nz
    ld hl, $CFC9
    inc [hl]
    xor a, a
    ld [$CFCA], a
    ret

Func_031_4493::
    ld a, [$D2CE]
    dec a
    ld [$D2CE], a
    ret nz
    ret

Jump_031_449C::
    call Func_031_663D
    ld hl, $CFC9
    inc [hl]
    xor a, a
    ld [$CFCA], a
    ld a, [$C58A]
    or a, a
    jr nz, Jump_031_44C4
    ld a, [$D092]
    or a, a
    jr z, Jump_031_44D1
    cp a, $03
    jr z, Jump_031_44BB
    cp a, $02
    jr z, Jump_031_44BB

Jump_031_44BB::
    ld hl, $CFC9
    inc [hl]
    ld hl, $CFC9
    inc [hl]
    ret

Jump_031_44C4::
    ld hl, $CFC9
    inc [hl]
    ld hl, $CFC9
    inc [hl]
    ld hl, $CFC9
    inc [hl]
    ret

Jump_031_44D1::
    ld a, [$DAAB]
    cp a, $FF
    ret z
    sub a, $04
    ret c
    cp a, $03
    ret nc
    ld a, [$C58A]
    or a, a
    call z, Func_031_45A3
    call Func_031_45F2
    ld a, [$DAAB]
    dec a
    ld c, $4E
    call Func_000_1682
    ld a, l
    add a, $D5
    ld e, a
    ld a, h
    adc a, $D0
    ld d, a
    ld hl, $C986
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld b, $0E
    call Func_031_4566
    push de
    ld de, $C60C
    ld b, $0B
    call Func_031_4566
    pop de
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    call Func_031_458E
    ld a, $FF
    ld [hl+], a
    call Func_031_458E
    ld a, $FF
    ld [hl+], a
    ld b, $08
    call Func_031_456D
    ld a, $FF
    ld b, $19

Jump_031_452D::
    ld [hl+], a
    dec b
    jr nz, Jump_031_452D
    ld a, [de]
    inc de
    ld [hl+], a
    ld a, [de]
    inc de
    ld [hl+], a
    ld [hl+], a
    ld b, $15
    call Func_031_4566
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld b, $1F
    call Func_031_4566
    call Func_031_458E
    ld a, $00
    ld [hl+], a
    call Func_031_458E
    ld a, $00
    ld [hl+], a
    ld a, [de]
    ld [hl+], a
    ld hl, $624B
    ld b, $1A
    rst $10
    ld hl, $7364
    ld b, $16
    rst $10
    ld hl, $73A2
    ld b, $19
    rst $10
    ret

Func_031_4566::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Func_031_4566
    ret

Func_031_456D::
    push hl
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    pop hl
    push hl

Jump_031_457A::
    ld a, [de]
    inc de
    cp a, $C8
    jr z, Jump_031_4581
    ld [hl+], a

Jump_031_4581::
    dec b
    jr nz, Jump_031_457A
    pop hl
    ld a, l
    add a, $08
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ret

Func_031_458E::
    ld a, $98
    ld [hl+], a
    ld a, $98
    ld [hl+], a
    ld a, $98
    ld [hl+], a
    ld a, $F0
    ld [hl+], a
    ld a, $F0
    ld b, $06

Jump_031_459E::
    ld [hl+], a
    dec b
    jr nz, Jump_031_459E
    ret

Func_031_45A3::
    ld a, [$D890]
    ld b, a
    ld c, $04
    xor a, a
    ld [$DA6B], a
    ld [$DA6C], a
    ld [$DA6D], a

Jump_031_45B3::
    ld a, c
    ld hl, $DA63
    add a, l
    ld l, a
    jr nc, Jump_031_45BC
    inc h

Jump_031_45BC::
    ld a, [hl]
    cp a, $01
    jr nz, Jump_031_45E7
    ld a, c
    and a, $03
    ld hl, Data_031_45EC
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_45CD
    inc h

Jump_031_45CD::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, [$DA6B]
    add a, [hl]
    ld [$DA6B], a
    inc hl
    ld a, [$DA6C]
    adc a, [hl]
    ld [$DA6C], a
    inc hl
    ld a, [$DA6D]
    adc a, [hl]
    ld [$DA6D], a

Jump_031_45E7::
    inc c
    dec b
    jr nz, Jump_031_45B3
    ret

Data_031_45EC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D7, $D1, $25, $D2, $73, $D2

Func_031_45F2::
    ld a, [$CFC5]
    cp a, $02
    ret nz
    ld a, [$D890]
    cp a, $01
    jr z, Jump_031_461B
    cp a, $02
    jr z, Jump_031_461B
    ld hl, $CFDF
    ld a, l
    ldh [$FFC6], a
    ld a, h
    ldh [$FFC7], a
    ld a, $05
    ld [$DAAB], a
    ld a, [$CFDF]
    ld l, a
    ld a, [$CFE0]
    ld h, a
    jr Jump_031_4631

Jump_031_461B::
    ld hl, $CFDD
    ld a, l
    ldh [$FFC6], a
    ld a, h
    ldh [$FFC7], a
    ld a, [$CFDD]
    ld l, a
    ld a, [$CFDE]
    ld h, a
    ld a, $04
    ld [$DAAB], a

Jump_031_4631::
    ld a, h
    or a, a
    jr nz, Jump_031_4650
    ld a, l
    cp a, $07
    jr z, Jump_031_4640
    cp a, $1A
    jr z, Jump_031_4648
    jr Jump_031_4680

Jump_031_4640::
    ld hl, $0008
    call Func_031_4681
    jr Jump_031_4680

Jump_031_4648::
    ld hl, $001B
    call Func_031_4681
    jr Jump_031_4680

Jump_031_4650::
    cp a, $01
    jr nz, Jump_031_4680
    ld a, l
    cp a, $82
    jr z, Jump_031_4663
    cp a, $AB
    jr z, Jump_031_466B
    cp a, $90
    jr z, Jump_031_4678
    jr Jump_031_4680

Jump_031_4663::
    ld hl, $0183
    call Func_031_4681
    jr Jump_031_4680

Jump_031_466B::
    ld a, $02
    ld [$CB7E], a
    ld hl, $01AC
    call Func_031_4681
    jr Jump_031_4680

Jump_031_4678::
    ld hl, $01AF
    call Func_031_4681
    jr Jump_031_4680

Jump_031_4680::
    ret

Func_031_4681::
    ldh a, [$FFC6]
    ld e, a
    ldh a, [$FFC7]
    ld d, a
    ld a, l
    ld [de], a
    inc de
    ld a, h
    ld [de], a
    ld hl, $46B1
    ld b, $19
    rst $10
    ret

Jump_031_4693::
    ld a, [$DC00]
    ld hl, $DC01
    and a, [hl]
    ld hl, $DC20
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, $DC40
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, $DC60
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, $DC80
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, $DCA0
    and a, [hl]
    inc hl
    and a, [hl]
    cp a, $FF
    call z, Func_031_46C1
    call Func_031_67AA
    ret

Func_031_46C1::
    ld a, [$D2CE]
    dec a
    ld [$D2CE], a
    ret nz
    ret

Jump_031_46CA::
    ld a, [$CFCA]
    rst $00
    dw Jump_031_46D8
    dw Jump_031_471C
    dw Jump_031_4751
    dw Jump_031_4793
    dw Jump_031_47B9

Jump_031_46D8::
    ld hl, $5B7E
    ld b, $16
    rst $10
    ld a, [$DAAB]
    cp a, $FF
    jr nz, Jump_031_46EE
    ld hl, $CFC9
    inc [hl]
    xor a, a
    ld [$CFCA], a
    ret

Jump_031_46EE::
    ld a, [$D006]
    ld l, a
    ld a, [$D007]
    ld h, a
    ld a, l
    ld [$D960], a
    ld a, h
    ld [$D961], a
    call Func_031_71F5
    call Func_031_72AC
    call Func_031_7389
    call Func_031_746F
    ld a, $6C
    call Func_000_1278
    ld hl, $CFCA
    inc [hl]
    xor a, a
    ld [$CFCB], a
    xor a, a
    ld [$CFCC], a
    ret

Jump_031_471C::
    ld a, [$CFCB]
    rst $00
    dw Jump_031_4724
    dw Jump_031_474A

Jump_031_4724::
    ld de, $C198
    ld hl, $9800
    ld bc, $1412
    call Func_031_753F
    call Func_031_47DD
    call Func_031_72CC
    call Func_031_7321
    ld de, $C27F
    ld hl, $98E7
    ld bc, $0606
    call Func_031_753F
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_474A::
    ld hl, $5D13
    ld b, $16
    rst $10
    ret

Jump_031_4751::
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
    call Func_031_47C7
    ld b, $31
    ld de, Data_031_7C1E
    ld hl, $8A40
    call Func_000_0CF5
    ld b, $31
    ld de, Data_031_7DFB
    ld hl, $8DF0
    call Func_000_0CF5
    ld hl, $CFCA
    dec [hl]
    ld hl, $CFCC
    inc [hl]
    ret

Jump_031_4793::
    ld a, [$CFCC]
    cp a, $03
    call z, Func_031_47A9
    ld hl, $6A4E
    ld b, $16
    rst $10
    ld a, [$CFCF]
    or a, a
    call nz, Func_031_47DD
    ret

Func_031_47A9::
    call Func_031_47C7
    ld hl, $9800
    ld de, $C198
    ld bc, $1412
    call Func_031_753F
    ret

Jump_031_47B9::
    ld hl, $6C16
    ld b, $16
    rst $10
    ld a, [$CFCF]
    or a, a
    call nz, Func_031_47DD
    ret

Func_031_47C7::
    call Func_031_47DD
    call Func_031_71F5
    call Func_031_72AC
    call Func_031_7389
    call Func_031_72CC
    call Func_031_7321
    call Func_031_746F
    ret

Func_031_47DD::
    xor a, a
    ld [$CFCF], a
    ld a, [$DAAB]
    ld hl, $D958
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_47ED
    inc h

Jump_031_47ED::
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld hl, $9140
    ld c, $01
    call Func_000_1FE3
    ld a, $7F
    ld [$C526], a
    call Func_000_0829
    call Func_000_222B
    ld hl, $8ED0
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0C01
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld a, $02
    ld [$C528], a
    ld a, $05
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

Jump_031_4840::
    ld a, [$CFCA]
    rst $00
    dw Jump_031_484A
    dw Jump_031_486E
    dw Jump_031_4878

Jump_031_484A::
    ld a, [$C52B]
    or a, a
    ret nz
    ld a, [$C608]
    ld hl, $D2CD
    cp a, [hl]
    jr z, Jump_031_485D
    ld a, $02
    call Func_000_122D

Jump_031_485D::
    xor a, a
    ldh [$FFB9], a
    ld a, $80
    ldh [$FFBA], a
    ld a, $04
    call Func_000_0DF2
    ld hl, $CFCA
    inc [hl]
    ret

Jump_031_486E::
    ld a, [$C56C]
    or a, a
    ret nz
    ld hl, $CFCA
    inc [hl]
    ret

Jump_031_4878::
    ld a, [$C608]
    ld hl, $D2CD
    cp a, [hl]
    jr z, Jump_031_4885
    ld a, [hl]
    call Func_000_122D

Jump_031_4885::
    ld a, [$CFC5]
    cp a, $02
    jr c, Jump_031_4893
    cp a, $04
    jr nc, Jump_031_4893
    call Func_031_48C3

Jump_031_4893::
    ld a, $01
    ld [$C5DB], a
    xor a, a
    ld [$C5DC], a
    ld [$C5DD], a
    ld [$C5DE], a
    ld [$D068], a
    ld [$D780], a
    ld b, $46
    ld de, Func_031_4001
    ld hl, $8800
    call Func_000_0CF5
    ld hl, $4339
    ld b, $03
    rst $10
    ld a, $02
    ld [$C5E0], a
    ld hl, $D066
    inc [hl]
    ret

Func_031_48C3::
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

Jump_031_48E5::
    ld a, [$CFCA]
    rst $00
    dw Jump_031_48EF
    dw Jump_031_4926
    dw Jump_031_4931

Jump_031_48EF::
    ld a, [$DC00]
    ld hl, $DC01
    and a, [hl]
    ld hl, $DC20
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, $DC40
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, $DC60
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, $DC80
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, $DCA0
    and a, [hl]
    inc hl
    and a, [hl]
    cp a, $FF
    ret nz
    ld a, [$C52B]
    or a, a
    ret nz
    ld a, $01
    ld [$C594], a
    ld hl, $CFCA
    inc [hl]
    ret

Jump_031_4926::
    ld a, [$C58F]
    cp a, $01
    ret nz
    ld hl, $CFCA
    inc [hl]
    ret

Jump_031_4931::
    ld a, $04
    call Func_000_0DF2
    ld hl, $4B0B
    ld b, $A3
    rst $10
    ld a, $06
    ld [$C5DB], a
    xor a, a
    ld [$C5DC], a
    ld [$C5DD], a
    ld [$C5DE], a
    ld [$D780], a
    ld hl, $C5DF
    inc [hl]
    ld hl, $D066
    inc [hl]
    xor a, a
    ld [$C581], a
    ld [$C582], a
    xor a, a
    ld [$C57F], a
    ld [$C580], a
    xor a, a
    ld [$C58A], a
    xor a, a
    ld [$C58F], a
    xor a, a
    ld [$C594], a
    xor a, a
    ld [$C58B], a
    ret

Jump_031_4975::
    ld a, [$D092]
    cp a, $04
    jr z, Jump_031_4983
    ld a, $42
    call Func_000_122D
    jr Jump_031_4988

Jump_031_4983::
    ld a, $7E
    call Func_000_1278

Jump_031_4988::
    ld a, $07
    ld [$CFC9], a
    ret

Func_031_498E::
    ld a, [$C58A]
    or a, a
    jr nz, Jump_031_49E5
    xor a, a
    ld [$D868], a
    ld hl, $D960
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    inc hl
    ld a, [$D890]
    cp a, $01
    jr z, Func_031_49D8
    ld a, $01
    ld [$D868], a
    ld a, [hl+]
    cp a, e
    jr nz, Jump_031_4A00
    ld a, [hl+]
    cp a, d
    jr nz, Jump_031_4A00
    ld a, [$D890]
    cp a, $02
    jr z, Jump_031_49C2
    ld a, [hl+]
    cp a, e
    jr nz, Jump_031_4A00
    ld a, [hl]
    cp a, d
    jr nz, Jump_031_4A00

Jump_031_49C2::
    call Func_031_49D8
    ld hl, $C130

Jump_031_49C8::
    ld a, [hl+]
    cp a, $F0
    jr nz, Jump_031_49C8
    dec hl
    ld a, $33
    ld [hl+], a
    ld a, $34
    ld [hl+], a
    ld [hl], $F0
    jr Jump_031_4A22

Func_031_49D8::
    ld l, e
    ld a, d
    add a, $02
    ld h, a
    ld de, $C130
    call Func_000_2E81
    jr Jump_031_4A22

Jump_031_49E5::
    ld de, $C958
    ld hl, $C130
    ld b, $0A

Jump_031_49ED::
    ld a, [de]
    cp a, $F0
    jr z, Jump_031_49F7
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_031_49ED

Jump_031_49F7::
    ld [hl], $F0
    ld a, $00
    ld [$D868], a
    jr Jump_031_4A22

Jump_031_4A00::
    ld hl, $C130
    ld a, $30
    ld [hl+], a
    ld a, $32
    ld [hl+], a
    ld a, $31
    ld [hl+], a
    ld a, $36
    ld [hl+], a
    ld a, $37
    ld [hl+], a
    ld a, $28
    ld [hl+], a
    ld a, $35
    ld [hl+], a
    ld a, $36
    ld [hl+], a
    ld [hl], $F0
    ld a, $02
    ld [$D868], a

Jump_031_4A22::
    ret

Func_031_4A23::
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
    jr nz, Jump_031_4A3F
    ld a, [$C82F]
    cp a, $3B
    ret z

Jump_031_4A3F::
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

Func_031_4A65::
    ld hl, $DAD8
    ld b, $08

Jump_031_4A6A::
    set 7, [hl]
    inc hl
    dec b
    jr nz, Jump_031_4A6A
    ld hl, $D854
    ld bc, $0010
    xor a, a
    call Func_000_0949
    ld hl, $D895
    ld bc, $000A
    xor a, a
    call Func_000_0949
    ld hl, $DA1C
    ld bc, $0010
    ld a, $FF
    call Func_000_0949
    ld a, $FF
    ld [$D892], a
    ld [$D893], a
    ld a, $00
    ld [$C46B], a
    ld a, [$C984]
    ld b, a
    ld c, $00
    ld a, [$C58A]
    or a, a
    jr z, Jump_031_4AB5
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_031_4AB5
    ld a, [$C985]
    ld b, a
    ld c, $04

Jump_031_4AB5::
    push bc
    ld a, c
    ld hl, $DA5B
    add a, l
    ld l, a
    jr nc, Jump_031_4ABF
    inc h

Jump_031_4ABF::
    ld c, $00

Jump_031_4AC1::
    ld a, [hl+]
    or a, a
    jr nz, Jump_031_4AC6
    inc c

Jump_031_4AC6::
    dec b
    jr nz, Jump_031_4AC1
    ld a, c
    or a, a
    jr nz, Jump_031_4AD1
    ld hl, $CFC9
    inc [hl]

Jump_031_4AD1::
    pop bc

Jump_031_4AD2::
    ld e, $03
    ld a, c
    call Func_000_3E54
    jr c, Jump_031_4B01
    ld e, $01
    ld a, c
    call Func_000_3E25
    jr c, Jump_031_4B01
    ld a, c
    ld hl, $D80F
    call Func_000_3F25
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_031_4B01
    ld a, [hl+]
    and a, $0C
    jr nz, Jump_031_4B01
    ld a, [hl+]
    and a, $30
    jr nz, Jump_031_4B01
    inc hl
    inc hl
    ld a, [hl]
    and a, $03
    jr nz, Jump_031_4B01
    ld e, $00

Jump_031_4B01::
    ld a, c
    ld hl, $DA5B
    add a, l
    ld l, a
    jr nc, Jump_031_4B0A
    inc h

Jump_031_4B0A::
    ld [hl], e
    inc c
    dec b
    jr nz, Jump_031_4AD2
    ret

Func_031_4B10::
    ld a, [$CFCA]
    rst $00
    dw Jump_031_4B2E
    dw Jump_031_4FF4
    dw Jump_031_5829
    dw Jump_031_5C8D
    dw Jump_031_5CB5
    dw Jump_031_5CDD
    dw Jump_031_5CED
    dw Jump_031_5D92
    dw Jump_031_5DA7
    dw Jump_031_5E7D
    dw Jump_031_5EB7
    dw Jump_031_5ED5
    dw Jump_031_5EF6

Jump_031_4B2E::
    ld a, [$CFCB]
    rst $00
    dw Jump_031_4B54
    dw Jump_031_4B8F
    dw Jump_031_4BCC
    dw Jump_031_4BEE
    dw Jump_031_4C19
    dw Jump_031_4C21
    dw Jump_031_4D3D
    dw Jump_031_4D4E
    dw Jump_031_4D65
    dw Jump_031_4D95
    dw Jump_031_4EE6
    dw Jump_031_4F0F
    dw Jump_031_4F2A
    dw Jump_031_4F50
    dw Jump_031_4FA8
    dw Jump_031_4FCE
    dw Jump_031_4FE9

Jump_031_4B54::
    ld a, [$C58A]
    or a, a
    jr nz, Jump_031_4B5E
    ld c, $00
    jr Jump_031_4B66

Jump_031_4B5E::
    ld a, [$C57F]
    and a, $02
    sla a
    ld c, a

Jump_031_4B66::
    ld de, $DAF2
    ld b, $03

Jump_031_4B6B::
    ld a, c
    ld hl, $DA43
    add a, l
    ld l, a
    jr nc, Jump_031_4B74
    inc h

Jump_031_4B74::
    ld a, [hl]
    ld [de], a
    ld a, $08
    add a, l
    ld l, a
    jr nc, Jump_031_4B7D
    inc h

Jump_031_4B7D::
    push de
    inc de
    inc de
    inc de
    inc de
    ld a, [hl]
    ld [de], a
    pop de
    inc de
    inc c
    dec b
    jr nz, Jump_031_4B6B
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_4B8F::
    ld a, [$C57F]
    rlca
    and a, $04
    ld hl, $DAD8
    add a, l
    ld l, a
    jr nc, Jump_031_4B9D
    inc h

Jump_031_4B9D::
    set 7, [hl]
    inc hl
    set 7, [hl]
    inc hl
    set 7, [hl]
    inc hl
    set 7, [hl]
    call Func_031_722A
    call Func_031_72CC
    call Func_031_7536
    ld hl, $8ED0
    ld de, $0701
    ld a, $02
    ld [$C528], a
    ld a, $00
    ld [$C529], a
    call Func_031_7A02
    call Func_031_7486
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_4BCC::
    call Func_031_748C
    ld hl, Func_031_639F
    ld a, [$C46B]
    and a, $03
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_4BDD
    inc h

Jump_031_4BDD::
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, $9800
    add hl, de
    ld a, $BB
    call Func_000_1211
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_4BEE::
    ld de, Func_031_639F
    ld hl, $C46B
    call Func_031_5F02
    ld a, [$C562]
    bit 0, a
    jr z, Jump_031_4C18
    ld a, $69
    call Func_000_1278
    ld hl, $C46C
    ld bc, $0007
    ld a, $00
    call Func_000_0949
    call Func_031_722A
    call Func_031_72CC
    ld hl, $CFCB
    inc [hl]

Jump_031_4C18::
    ret

Jump_031_4C19::
    call Func_031_748C
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_4C21::
    ld a, [$C46B]
    and a, $03
    ld [$CFDB], a
    or a, a
    jr z, Jump_031_4C37
    cp a, $01
    jr z, Jump_031_4C49
    cp a, $02
    jr z, Jump_031_4C83
    jp Jump_031_4CBC

Jump_031_4C37::
    call Func_031_4CEE
    call Func_031_4D06
    ld a, $03
    ld [$CFCA], a
    xor a, a
    ld [$CFCB], a
    jp Jump_031_4CED

Jump_031_4C49::
    ld a, [$C57F]
    sla a
    and a, $04
    ld c, a
    ld b, $03

Jump_031_4C53::
    ld a, c
    ld hl, $DA5B
    add a, l
    ld l, a
    jr nc, Jump_031_4C5C
    inc h

Jump_031_4C5C::
    ld a, [hl]
    or a, a
    jr z, Jump_031_4C74
    inc c
    dec b
    jr nz, Jump_031_4C53
    ld a, $00
    ld [$C528], a
    ld a, $2D
    ld [$C529], a
    ld hl, $CFCB
    inc [hl]
    jr Jump_031_4CED

Jump_031_4C74::
    ld a, c
    ld [$CFD4], a
    ld a, $01
    ld [$CFCA], a
    xor a, a
    ld [$CFCB], a
    jr Jump_031_4CED

Jump_031_4C83::
    ld a, [$C58A]
    or a, a
    jr nz, Jump_031_4CA2
    ld a, [$CFC5]
    cp a, $04
    jr z, Jump_031_4CA2
    cp a, $05
    jr z, Jump_031_4CA2
    call Func_031_4CEE
    call Func_031_6200
    ld a, e
    or a, a
    jr nz, Jump_031_4CB1
    ld a, $1F
    jr Jump_031_4CA4

Jump_031_4CA2::
    ld a, $1D

Jump_031_4CA4::
    ld [$C529], a
    xor a, a
    ld [$C528], a
    ld hl, $CFCB
    inc [hl]
    jr Jump_031_4CED

Jump_031_4CB1::
    ld a, $02
    ld [$CFCA], a
    xor a, a
    ld [$CFCB], a
    jr Jump_031_4CED

Jump_031_4CBC::
    ld a, [$C58A]
    or a, a
    jr z, Jump_031_4CC6
    ld a, $20
    jr Jump_031_4CA4

Jump_031_4CC6::
    call Func_031_4CEE
    ld hl, $CFCB
    ld [hl], $08
    ld a, [$CFC5]
    cp a, $02
    jr c, Jump_031_4CED
    ld [hl], $0F
    cp a, $02
    jr z, Jump_031_4CED
    cp a, $03
    jr z, Jump_031_4CED
    cp a, $05
    jr z, Jump_031_4CED
    cp a, $06
    jr z, Jump_031_4CED
    cp a, $07
    jr z, Jump_031_4CED
    ld [hl], $0B

Jump_031_4CED::
    ret

Func_031_4CEE::
    ld a, [$C57F]
    and a, $02
    ld hl, $DA1C
    add a, a
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_4CFD
    inc h

Jump_031_4CFD::
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ret

Func_031_4D06::
    ld a, [$C58A]
    or a, a
    jr nz, Jump_031_4D10
    ld c, $00
    jr Jump_031_4D18

Jump_031_4D10::
    ld a, [$C57F]
    and a, $02
    sla a
    ld c, a

Jump_031_4D18::
    ld de, $DAF2
    ld b, $03

Jump_031_4D1D::
    ld a, c
    ld hl, $DA43
    add a, l
    ld l, a
    jr nc, Jump_031_4D26
    inc h

Jump_031_4D26::
    ld a, [de]
    ld [hl], a
    ld a, $08
    add a, l
    ld l, a
    jr nc, Jump_031_4D2F
    inc h

Jump_031_4D2F::
    push de
    inc de
    inc de
    inc de
    inc de
    ld a, [de]
    ld [hl], a
    pop de
    inc de
    inc c
    dec b
    jr nz, Jump_031_4D1D
    ret

Jump_031_4D3D::
    call Func_031_746F
    call Func_031_7479
    ld hl, Func_031_4001
    ld b, $2F
    rst $10
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_4D4E::
    ld a, [$C52B]
    or a, a
    ret nz
    call Func_031_722A
    call Func_031_72CC
    call Func_031_7479
    call Func_031_7486
    ld a, $02
    ld [$CFCB], a
    ret

Jump_031_4D65::
    call Func_031_746F
    call Func_031_7479
    ld hl, $C130
    ld de, $C60C
    ld b, $0A

Jump_031_4D73::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_031_4D73
    ld [hl], $F0
    ld a, $01
    ld [$C528], a
    ld a, $D8
    ld [$C529], a
    ld hl, Func_031_4001
    ld b, $2F
    rst $10
    ld a, $82
    call Func_000_1278
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_4D95::
    ld a, [$C52B]
    or a, a
    ret nz
    ld a, [$DC00]
    ld hl, $DC20
    and a, [hl]
    cp a, $FF
    ret nz
    ld a, [$D891]
    or a, a
    jr z, Jump_031_4E16
    ld a, [$D88F]
    ld b, a
    ld e, $00
    ld c, $00
    ld hl, $D8B7

Jump_031_4DB5::
    ld a, c
    call Func_000_3E54
    jr c, Jump_031_4DC0
    ld a, [hl]
    cp a, e
    jr c, Jump_031_4DC0
    ld e, a

Jump_031_4DC0::
    inc hl
    inc c
    dec b
    jr nz, Jump_031_4DB5
    ld a, [$D890]
    ld b, a
    ld d, $00
    ld c, $04
    ld hl, $D8BB

Jump_031_4DD0::
    ld a, c
    call Func_000_3E54
    jr c, Jump_031_4DDB
    ld a, [hl]
    cp a, d
    jr c, Jump_031_4DDB
    ld d, a

Jump_031_4DDB::
    inc hl
    inc c
    dec b
    jr nz, Jump_031_4DD0
    ld a, d
    add a, $05
    cp a, e
    jr c, Jump_031_4E16
    call Func_000_095B
    ld a, [$C5E7]
    and a, $07
    inc a
    ld b, a
    ld a, [$D891]
    cp a, $04
    jr c, Jump_031_4DF9
    ld a, $07

Jump_031_4DF9::
    cp a, b
    jr nc, Jump_031_4E16
    call Func_031_4E3E
    jr z, Jump_031_4E16
    ld a, $00
    ld [$C528], a
    ld a, $2C
    ld [$C529], a
    ld hl, Func_031_4001
    ld b, $2F
    rst $10
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_4E16::
    ld a, [$C58A]
    or a, a
    jr nz, Jump_031_4E1F
    call Func_031_4E54

Jump_031_4E1F::
    ld a, $02
    ld [$D092], a
    ld a, $02
    ld [$CFC8], a
    ld a, $03
    ld [$CFC9], a
    ld a, $01
    ld [$C964], a
    ld a, [$D067]
    ld [$D7FE], a
    xor a, a
    ld [$D067], a
    ret

Func_031_4E3E::
    ld a, [$D890]
    ld b, a
    ld c, $04
    ld e, $00

Jump_031_4E46::
    ld a, c
    call Func_031_7BEE
    jr c, Jump_031_4E4D
    inc e

Jump_031_4E4D::
    inc c
    dec b
    jr nz, Jump_031_4E46
    ld a, e
    or a, a
    ret

Func_031_4E54::
    ld a, [$D88F]
    ld b, a
    ld c, $00

Jump_031_4E5A::
    ld a, c
    call Func_000_3E54
    jr c, Jump_031_4EB4
    ld hl, $D8B7
    add a, l
    ld l, a
    jr nc, Jump_031_4E68
    inc h

Jump_031_4E68::
    ld a, [hl]
    ld e, $00
    cp a, $0A
    jr c, Jump_031_4E7D
    ld e, $01
    cp a, $14
    jr c, Jump_031_4E7D
    ld e, $02
    cp a, $1E
    jr c, Jump_031_4E7D
    ld e, $03

Jump_031_4E7D::
    ld a, c
    ld hl, $D980
    add a, l
    ld l, a
    jr nc, Jump_031_4E86
    inc h

Jump_031_4E86::
    ld a, [hl]
    cp a, $97
    ld hl, Data_031_4EC6
    jr c, Jump_031_4E91
    ld hl, Data_031_4ED6

Jump_031_4E91::
    ld a, e
    add a, a
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_4E99
    inc h

Jump_031_4E99::
    ld de, $D968
    call Func_031_4EB9
    inc hl
    ld de, $D970
    call Func_031_4EB9
    inc hl
    ld de, $D978
    call Func_031_4EB9
    inc hl
    ld de, $D980
    call Func_031_4EB9

Jump_031_4EB4::
    inc c
    dec b
    jr nz, Jump_031_4E5A
    ret

Func_031_4EB9::
    ld a, c
    add a, e
    ld e, a
    jr nc, Jump_031_4EBF
    inc d

Jump_031_4EBF::
    ld a, [de]
    sub a, [hl]
    ld [de], a
    ret nc
    xor a, a
    ld [de], a
    ret

Data_031_4EC6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $04, $00, $00, $0A, $03, $00, $00, $05, $02, $00, $00, $03, $01, $00, $00, $02

Data_031_4ED6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $08, $00, $00, $0F, $06, $00, $00, $0A, $04, $00, $00, $05, $02, $00, $00, $03

Jump_031_4EE6::
    ld a, [$C52B]
    or a, a
    ret nz
    ld a, [$D88F]
    ld b, a
    ld c, $00
    ld hl, $DA5B

Jump_031_4EF4::
    ld a, c
    call Func_000_3E54
    jr c, Jump_031_4EFE
    ld [hl], $03
    jr Jump_031_4F00

Jump_031_4EFE::
    ld [hl], $FF

Jump_031_4F00::
    inc hl
    inc c
    dec b
    jr nz, Jump_031_4EF4
    ld a, $03
    ld [$CFCA], a
    xor a, a
    ld [$CFCB], a
    ret

Jump_031_4F0F::
    call Func_031_746F
    call Func_031_7479
    ld a, $00
    ld [$C528], a
    ld a, $27
    ld [$C529], a
    ld hl, Func_031_4001
    ld b, $2F
    rst $10
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_4F2A::
    ld a, [$C52B]
    or a, a
    ret nz
    ld hl, Jump_031_72DB
    ld b, $1A
    rst $10
    ld a, $BB
    ld [$C307], a
    ld a, $01
    ld [$C46C], a
    ld de, $C2A6
    ld hl, $990E
    ld bc, $0605
    call Func_031_753F
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_4F50::
    ld de, Data_031_63C5
    ld hl, $C46C
    call Func_031_5F02
    ld a, [$C562]
    and a, $01
    ret z
    ld a, [$C46C]
    and a, $01
    ld hl, Data_031_4FA4
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_4F6D
    inc h

Jump_031_4F6D::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, $BC
    call Func_000_1211
    ld a, [$C46C]
    and a, $01
    jr z, Jump_031_4F8F
    call Func_031_722A
    call Func_031_72CC
    call Func_031_74A0
    ld a, $01
    ld [$CFCB], a
    xor a, a
    ld [$CFCA], a
    ret

Jump_031_4F8F::
    ld a, $00
    ld [$C528], a
    ld a, $60
    ld [$C529], a
    ld hl, Func_031_4001
    ld b, $2F
    rst $10
    ld hl, $CFCB
    inc [hl]
    ret

Data_031_4FA4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2F, $99, $6F, $99

Jump_031_4FA8::
    ld a, [$C52B]
    or a, a
    ret nz
    ld a, $03
    ld [$D092], a
    ld a, $02
    ld [$CFC8], a
    ld a, $06
    ld [$CFC9], a
    xor a, a
    ld [$CFCA], a
    ld [$CFCB], a
    ld a, [$D067]
    ld [$D7FE], a
    xor a, a
    ld [$D067], a
    ret

Jump_031_4FCE::
    call Func_031_746F
    call Func_031_7479
    ld a, $00
    ld [$C528], a
    ld a, $20
    ld [$C529], a
    ld hl, Func_031_4001
    ld b, $2F
    rst $10
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_4FE9::
    ld a, [$C52B]
    or a, a
    ret nz
    ld a, $01
    ld [$CFCB], a
    ret

Jump_031_4FF4::
    ld a, [$CFCB]
    rst $00
    dw Jump_031_5040
    dw Jump_031_5087
    dw Jump_031_50BF
    dw Jump_031_517D
    dw Jump_031_518A
    dw Jump_031_51CE
    dw Jump_031_51F0
    dw Jump_031_52B5
    dw Jump_031_52C4
    dw Jump_031_52CF
    dw Jump_031_52E7
    dw Jump_031_52F7
    dw Jump_031_5300
    dw Jump_031_5319
    dw Jump_031_5350
    dw Jump_031_53BA
    dw Jump_031_53CD
    dw Jump_031_542A
    dw Jump_031_5454
    dw Jump_031_55C1
    dw Jump_031_55CF
    dw Jump_031_55E0
    dw Jump_031_55F2
    dw Jump_031_5602
    dw Jump_031_560B
    dw Jump_031_562A
    dw Jump_031_566A
    dw Jump_031_56FE
    dw Jump_031_5708
    dw Jump_031_572D
    dw Jump_031_576F
    dw Jump_031_57D6
    dw Jump_031_57E0
    dw Jump_031_580E
    dw Jump_031_55F2
    dw Jump_031_5820

Jump_031_5040::
    ld hl, $8ED0
    ld de, $2001
    ld a, $02
    ld [$C528], a
    ld a, $01
    ld [$C529], a
    call Func_031_7A02
    ld a, [$DAD7]
    or a, a
    jr z, Jump_031_5067
    ld a, $07
    ld [$C529], a
    ld hl, $9050
    ld de, $0801
    call Func_031_7A02

Jump_031_5067::
    xor a, a
    ld [$CFD7], a
    ld a, $03
    ld [$CFD6], a
    xor a, a
    ld [$CFD5], a
    call Func_031_7499
    ld a, [$CFD4]
    and a, $03
    ld hl, $C29B
    call Func_031_60EB
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_5087::
    ld a, [$CFD4]
    and a, $03
    ld hl, $CFD8
    add a, l
    ld l, a
    jr nc, Jump_031_5094
    inc h

Jump_031_5094::
    ld a, [hl]
    ld [$C46C], a
    call Func_031_74A0
    ld hl, $63A7
    ld a, [$C46C]
    and a, $03
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_50A9
    inc h

Jump_031_50A9::
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, $9800
    add hl, de
    ld a, $BB
    call Func_000_1211
    ld hl, $CFCB
    inc [hl]
    ld a, $03
    ld [$CFD3], a
    ret

Jump_031_50BF::
    ld de, $63A7
    ld hl, $C46C
    call Func_031_5F9E
    ld a, [$C562]
    bit 0, a
    jr z, Jump_031_5118
    ld a, $69
    call Func_000_1278
    ld a, [$CFD4]
    and a, $03
    ld hl, $CFD8
    add a, l
    ld l, a
    jr nc, Jump_031_50E1
    inc h

Jump_031_50E1::
    ld a, [$C46C]
    and a, $03
    ld [hl], a
    call Func_031_63CD
    cp a, $03
    jr nz, Jump_031_514E
    ld a, [$DAD7]
    or a, a
    jr z, Jump_031_5104
    ld a, [$CFD4]
    ld hl, $DA1C
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_5100
    inc h

Jump_031_5100::
    ld [hl], $00
    jr Jump_031_515E

Jump_031_5104::
    call Func_031_722A
    call Func_031_72CC
    ld hl, $CFCB
    inc [hl]
    ld hl, $CFCB
    inc [hl]
    ld a, $00
    ld [$D869], a
    ret

Jump_031_5118::
    bit 1, a
    jr z, Jump_031_517C

Jump_031_511C::
    ld a, [$CFD4]
    and a, $03
    jr z, Jump_031_5147
    ld a, [$CFD4]
    dec a
    ld [$CFD4], a
    ld hl, $DA5B
    add a, l
    ld l, a
    jr nc, Jump_031_5132
    inc h

Jump_031_5132::
    ld a, [hl]
    or a, a
    jr nz, Jump_031_511C
    ld a, [$CFD4]
    and a, $03
    ld hl, $C29B
    call Func_031_60EB
    ld hl, $CFCB
    dec [hl]
    jr Jump_031_517C

Jump_031_5147::
    ld a, $00
    ld [$D869], a
    jr Jump_031_5172

Jump_031_514E::
    ld a, [$CFD4]
    ld hl, $DA1C
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_515A
    inc h

Jump_031_515A::
    ld a, $FF
    ld [hl+], a
    ld [hl], a

Jump_031_515E::
    ld a, [$CFD4]
    ld hl, $DAD8
    add a, l
    ld l, a
    jr nc, Jump_031_5169
    inc h

Jump_031_5169::
    set 7, [hl]
    ld a, $20
    ld [$CFCB], a
    jr Jump_031_517C

Jump_031_5172::
    call Func_031_722A
    call Func_031_72CC
    ld hl, $CFCB
    inc [hl]

Jump_031_517C::
    ret

Jump_031_517D::
    call Func_031_74A0
    ld a, $01
    ld [$CFCB], a
    xor a, a
    ld [$CFCA], a
    ret

Jump_031_518A::
    ld a, [$D869]
    or a, a
    call z, Func_031_74A0
    xor a, a
    ld [$D869], a
    ld hl, $8ED0
    ld de, $0801
    ld a, $02
    ld [$C528], a
    ld a, $02
    ld [$C529], a
    call Func_031_7A02
    call Func_031_74AD
    ld a, [$CFD4]
    and a, $03
    ld hl, $C2D9
    call Func_031_60EB
    ld a, [$CFD4]
    ld hl, $DAD8
    add a, l
    ld l, a
    jr nc, Jump_031_51C1
    inc h

Jump_031_51C1::
    ld a, [hl]
    swap a
    and a, $03
    ld [$C46D], a
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_51CE::
    call Func_031_74B4
    ld hl, $63AF
    ld a, [$C46D]
    and a, $03
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_51DF
    inc h

Jump_031_51DF::
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, $9800
    add hl, de
    ld a, $BB
    call Func_000_1211
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_51F0::
    ld de, $63AF
    ld hl, $C46D
    call Func_031_5F4E
    ld a, [$C562]
    bit 1, a
    jr z, Jump_031_5212
    ld a, $00
    ld [$D869], a
    call Func_031_722A
    call Func_031_72CC
    ld hl, $CFCB
    inc [hl]
    jp Jump_031_52B4

Jump_031_5212::
    bit 0, a
    jp z, Jump_031_52B4
    ld a, $69
    call Func_000_1278
    ld a, [$CFD4]
    ld hl, $DAD8
    add a, l
    ld l, a
    jr nc, Jump_031_5227
    inc h

Jump_031_5227::
    ld a, [hl]
    and a, $0F
    ld [hl], a
    ld a, [$C46D]
    and a, $03
    swap a
    or a, [hl]
    ld [hl], a
    ld a, [$C46D]
    and a, $03
    or a, a
    jr z, Jump_031_5242
    cp a, $01
    jr z, Jump_031_526D
    jr Jump_031_5292

Jump_031_5242::
    call Func_031_641D
    ld a, d
    cp a, $01
    jr nz, Jump_031_525C
    ld a, [$CFD4]
    ld hl, $DA1C
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_5256
    inc h

Jump_031_5256::
    ld a, $00
    ld [hl+], a
    ld [hl], e
    jr Jump_031_52A5

Jump_031_525C::
    call Func_031_722A
    call Func_031_72CC
    ld a, $0C
    ld [$CFCB], a
    xor a, a
    ld [$C470], a
    jr Jump_031_52B4

Jump_031_526D::
    call Func_031_6105
    ld a, d
    or a, a
    jr nz, Jump_031_5281
    call Func_031_722A
    call Func_031_72CC
    ld a, $08
    ld [$CFCB], a
    jr Jump_031_52B4

Jump_031_5281::
    call Func_031_722A
    call Func_031_72CC
    xor a, a
    ld [$D869], a
    ld a, $10
    ld [$CFCB], a
    jr Jump_031_52B4

Jump_031_5292::
    ld a, [$CFD4]
    ld hl, $DA1C
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_529E
    inc h

Jump_031_529E::
    ld a, $AC
    ld [hl+], a
    ld a, [$CFD4]
    ld [hl], a

Jump_031_52A5::
    ld a, $01
    ld [$D869], a
    call Func_031_722A
    call Func_031_72CC
    ld hl, $CFCB
    inc [hl]

Jump_031_52B4::
    ret

Jump_031_52B5::
    call Func_031_74B4
    ld a, [$D869]
    or a, a
    jr z, Jump_031_52C0
    ld a, $20

Jump_031_52C0::
    ld [$CFCB], a
    ret

Jump_031_52C4::
    call Func_031_74B4
    call Func_031_746F
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_52CF::
    call Func_031_7479
    ld a, $00
    ld [$C528], a
    ld a, $29
    ld [$C529], a
    ld hl, Func_031_4001
    ld b, $2F
    rst $10
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_52E7::
    ld a, [$C52B]
    or a, a
    ret nz
    call Func_031_722A
    call Func_031_72CC
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_52F7::
    call Func_031_7479
    ld a, $04
    ld [$CFCB], a
    ret

Jump_031_5300::
    call Func_031_74B4
    call Func_031_7522
    xor a, a
    ld [$D869], a
    ld hl, Data_031_7BA0
    ld b, $3A
    rst $10
    xor a, a
    ld [$D869], a
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_5319::
    call Func_031_7529
    xor a, a
    ld [$D86C], a
    ld a, [$C57F]
    sla a
    and a, $04
    xor a, $04
    ld b, a
    ld hl, $C470
    ld e, $01
    ld a, $00
    call Func_031_64D8
    ld hl, $63AF
    and a, $03
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_533F
    inc h

Jump_031_533F::
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, $9800
    add hl, de
    ld a, $BB
    call Func_000_1211
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_5350::
    ld a, [$C57F]
    sla a
    and a, $04
    xor a, $04
    ld b, a
    ld hl, $C470
    ld de, $63AF
    call Func_031_6518
    ld a, [$C562]
    bit 1, a
    jr z, Jump_031_537B
    call Func_031_722A
    call Func_031_72CC
    ld a, $00
    ld [$D868], a
    ld hl, $CFCB
    inc [hl]
    jr Jump_031_53B9

Jump_031_537B::
    bit 0, a
    jr z, Jump_031_53B9
    ld a, $69
    call Func_000_1278
    call Func_031_722A
    call Func_031_72CC
    ld a, [$CFD4]
    ld hl, $DA1C
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_5396
    inc h

Jump_031_5396::
    ld a, $00
    ld [hl+], a
    ld a, [$C470]
    and a, $03
    ld b, a
    ld a, [$C57F]
    sla a
    and a, $04
    xor a, $04
    or a, b
    ld [hl], a
    call Func_031_722A
    call Func_031_72CC
    ld a, $01
    ld [$D868], a
    ld hl, $CFCB
    inc [hl]

Jump_031_53B9::
    ret

Jump_031_53BA::
    call Func_031_7529
    ld a, [$D868]
    or a, a
    jr z, Jump_031_53C7
    ld a, $20
    jr Jump_031_53C9

Jump_031_53C7::
    ld a, $04

Jump_031_53C9::
    ld [$CFCB], a
    ret

Jump_031_53CD::
    ld a, [$D869]
    or a, a
    call z, Func_031_74B4
    xor a, a
    ld [$D869], a
    ld a, [$CFD4]
    ld hl, $DAD8
    add a, l
    ld l, a
    jr nc, Jump_031_53E3
    inc h

Jump_031_53E3::
    ld a, [hl]
    and a, $03
    ld [$C46E], a
    ld a, [hl]
    rrca
    rrca
    and a, $01
    ld [$CFD5], a
    ld hl, $CFD5
    res 7, [hl]
    ld de, $63A7
    call Func_031_6153
    call Func_031_61A4
    call Func_031_7502
    ld a, $09
    ld [$C528], a
    ld a, [$D86A]
    ld l, a
    ld a, [$D86B]
    ld h, a
    ld a, [$CFD5]
    add a, a
    add a, a
    ld c, a
    ld a, [$C46E]
    and a, $03
    add a, c
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_5421
    inc h

Jump_031_5421::
    ld a, [hl]
    call Func_031_6331
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_542A::
    call Func_031_7509
    ld hl, $63A7
    ld a, [$C46E]
    and a, $03
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_543B
    inc h

Jump_031_543B::
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, $9800
    add hl, de
    ld a, $BB
    call Func_000_1211
    call Func_031_6373
    ld hl, $CFCB
    inc [hl]
    ld a, $03
    ld [$CFD3], a
    ret

Jump_031_5454::
    ld de, $63A7
    ld hl, $C46E
    call Func_031_5F9E
    ld a, [$C562]
    bit 0, a
    jp z, Jump_031_557A
    ld a, $69
    call Func_000_1278
    call Func_031_722A
    call Func_031_72CC
    ld a, $20
    ld [$D869], a
    call Func_031_63ED
    ld a, [$CFF1]
    bit 0, a
    jp z, Jump_031_5599
    ld a, [$CFD4]
    ld hl, $D8DF
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_548C
    inc h

Jump_031_548C::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, [$CFEE]
    ld c, a
    cp a, $FF
    jr nz, Jump_031_5499
    ld c, $01

Jump_031_5499::
    xor a, a
    ld b, a
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    bit 7, h
    jp nz, Jump_031_55AD
    ld a, [$CFD4]
    ld hl, $DAD8
    add a, l
    ld l, a
    jr nc, Jump_031_54B1
    inc h

Jump_031_54B1::
    ld a, [hl]
    and a, $F0
    ld [hl], a
    ld a, [$CFD5]
    rlca
    rlca
    and a, $04
    or a, [hl]
    ld [hl], a
    ld a, [$C46E]
    and a, $03
    or a, [hl]
    ld [hl], a
    ld a, [$CFD4]
    ld hl, $DA1C
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_54D1
    inc h

Jump_031_54D1::
    ld a, [$CFEC]
    ld [hl+], a
    cp a, $35
    jr z, Jump_031_5523
    ld a, [$CFF2]
    cp a, $FF
    jr z, Jump_031_54FF
    cp a, $14
    jr z, Jump_031_54FF
    cp a, $80
    jr z, Jump_031_5506
    cp a, $12
    jr z, Jump_031_5515
    cp a, $22
    jr z, Jump_031_5523
    cp a, $11
    jr z, Jump_031_552F
    cp a, $21
    jr z, Jump_031_5549
    cp a, $40
    jr z, Jump_031_5571
    jp Jump_031_5598

Jump_031_54FF::
    ld hl, $CFCB
    inc [hl]
    jp Jump_031_5598

Jump_031_5506::
    ld a, [$CFD4]
    and a, $04
    xor a, $04
    ld [hl], a
    ld hl, $CFCB
    inc [hl]
    jp Jump_031_5598

Jump_031_5515::
    ld a, [$CFD4]
    and a, $04
    xor a, $04
    ld [hl], a
    ld hl, $CFCB
    inc [hl]
    jr Jump_031_5598

Jump_031_5523::
    ld a, [$CFD4]
    and a, $04
    ld [hl], a
    ld hl, $CFCB
    inc [hl]
    jr Jump_031_5598

Jump_031_552F::
    call Func_031_641D
    ld a, d
    cp a, $01
    jr nz, Jump_031_553E
    ld [hl], e
    ld hl, $CFCB
    inc [hl]
    jr Jump_031_5598

Jump_031_553E::
    ld a, $1C
    ld [$D869], a
    ld hl, $CFCB
    inc [hl]
    jr Jump_031_5598

Jump_031_5549::
    call Func_031_6439
    ld a, d
    cp a, $01
    jr nz, Jump_031_5566
    ld a, [$CFEC]
    cp a, $1E
    jr z, Jump_031_5566
    cp a, $1F
    jr z, Jump_031_5566
    ld a, [$CFD4]
    ld [hl], a
    ld hl, $CFCB
    inc [hl]
    jr Jump_031_5598

Jump_031_5566::
    ld a, $18
    ld [$D869], a
    ld hl, $CFCB
    inc [hl]
    jr Jump_031_5598

Jump_031_5571::
    ld a, [$CFD4]
    ld [hl], a
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_557A::
    ld a, [$C562]
    bit 1, a
    jr z, Jump_031_5592
    call Func_031_722A
    call Func_031_72CC
    ld a, $04
    ld [$D869], a
    ld hl, $CFCB
    inc [hl]
    jr Jump_031_5598

Jump_031_5592::
    call Func_031_61A4
    call Func_031_6373

Jump_031_5598::
    ret

Jump_031_5599::
    ld a, $25
    ld [$C529], a
    ld a, $13
    ld [$D869], a
    ld hl, $CFCB
    inc [hl]
    ld hl, $CFCB
    inc [hl]
    jr Jump_031_5598

Jump_031_55AD::
    ld a, $26
    ld [$C529], a
    ld a, $13
    ld [$D869], a
    ld hl, $CFCB
    inc [hl]
    ld hl, $CFCB
    inc [hl]
    jr Jump_031_5598

Jump_031_55C1::
    call Func_031_7509
    ld a, [$D869]
    ld [$CFCB], a
    xor a, a
    ld [$D869], a
    ret

Jump_031_55CF::
    call Func_031_722A
    call Func_031_72CC
    call Func_031_7509
    call Func_031_746F
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_55E0::
    call Func_031_7479
    xor a, a
    ld [$C528], a
    ld hl, Func_031_4001
    ld b, $2F
    rst $10
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_55F2::
    ld a, [$C52B]
    or a, a
    ret nz
    call Func_031_722A
    call Func_031_72CC
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_5602::
    call Func_031_7479
    ld a, $10
    ld [$CFCB], a
    ret

Jump_031_560B::
    ld hl, $8ED0
    ld de, $0801
    ld a, $02
    ld [$C528], a
    ld a, $03
    ld [$C529], a
    call Func_031_7A02
    call Func_031_6451
    xor a, a
    ld [$C470], a
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_562A::
    call Func_031_74E1
    ld a, [$CFEC]
    cp a, $1E
    jr z, Jump_031_5639
    cp a, $1F
    jr z, Jump_031_5639
    xor a, a

Jump_031_5639::
    ld [$D86C], a
    ld a, [$C57F]
    sla a
    and a, $04
    ld b, a
    ld hl, $C470
    ld e, $01
    ld a, $00
    call Func_031_64D8
    ld hl, $63AF
    and a, $03
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_5659
    inc h

Jump_031_5659::
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, $9800
    add hl, de
    ld a, $BB
    call Func_000_1211
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_566A::
    ld a, [$C57F]
    sla a
    and a, $04
    ld b, a
    ld hl, $C470
    ld de, $63AF
    call Func_031_6518
    ld a, [$C562]
    bit 1, a
    jr z, Jump_031_5693
    call Func_031_722A
    call Func_031_72CC
    ld a, $10
    ld [$D868], a
    ld hl, $CFCB
    inc [hl]
    jr Jump_031_56FD

Jump_031_5693::
    bit 0, a
    jr z, Jump_031_56FD
    ld a, $69
    call Func_000_1278
    ld a, [$CFEC]
    cp a, $1B
    jr z, Jump_031_56AF
    cp a, $1C
    jr z, Jump_031_56AF
    cp a, $1D
    jr z, Jump_031_56AF
    cp a, $97
    jr nz, Jump_031_56D5

Jump_031_56AF::
    ld a, [$CFD4]
    and a, $03
    ld c, a
    ld a, [$C470]
    and a, $03
    cp a, c
    jr nz, Jump_031_56D5
    call Func_031_722A
    call Func_031_72CC
    call Func_031_7509
    call Func_031_746F
    ld a, $65
    ld [$C529], a
    ld a, $21
    ld [$CFCB], a
    jr Jump_031_56FD

Jump_031_56D5::
    ld a, [$CFD4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_56E1
    inc h

Jump_031_56E1::
    ld a, [$C470]
    and a, $03
    ld b, a
    ld a, [$CFD4]
    and a, $04
    or a, b
    ld [hl], a
    call Func_031_722A
    call Func_031_72CC
    ld a, $20
    ld [$D868], a
    ld hl, $CFCB
    inc [hl]

Jump_031_56FD::
    ret

Jump_031_56FE::
    call Func_031_74E1
    ld a, [$D868]
    ld [$CFCB], a
    ret

Jump_031_5708::
    call Func_031_7522
    ld a, [$CFEC]
    cp a, $1E
    jr z, Jump_031_5717
    cp a, $1F
    jr z, Jump_031_5717
    xor a, a

Jump_031_5717::
    ld [$D869], a
    ld hl, Data_031_7BA0
    ld b, $3A
    rst $10
    xor a, a
    ld [$D869], a
    xor a, a
    ld [$C470], a
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_572D::
    call Func_031_7529
    ld a, [$CFEC]
    cp a, $1E
    jr z, Jump_031_573C
    cp a, $1F
    jr z, Jump_031_573C
    xor a, a

Jump_031_573C::
    ld [$D86C], a
    ld a, [$C57F]
    sla a
    and a, $04
    xor a, $04
    ld b, a
    ld hl, $C470
    ld e, $01
    ld a, $00
    call Func_031_64D8
    ld hl, $63AF
    and a, $03
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_575E
    inc h

Jump_031_575E::
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, $9800
    add hl, de
    ld a, $BB
    call Func_000_1211
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_576F::
    ld a, [$C57F]
    sla a
    and a, $04
    xor a, $04
    ld b, a
    ld hl, $C470
    ld de, $63AF
    call Func_031_6518
    ld a, [$C562]
    bit 1, a
    jr z, Jump_031_579A
    call Func_031_722A
    call Func_031_72CC
    ld a, $10
    ld [$D868], a
    ld hl, $CFCB
    inc [hl]
    jr Jump_031_57D5

Jump_031_579A::
    bit 0, a
    jr z, Jump_031_57D5
    ld a, $69
    call Func_000_1278
    call Func_031_722A
    call Func_031_72CC
    ld a, [$CFD4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_57B5
    inc h

Jump_031_57B5::
    ld a, [$C470]
    and a, $03
    ld b, a
    ld a, [$C57F]
    sla a
    and a, $04
    xor a, $04
    or a, b
    ld [hl], a
    call Func_031_722A
    call Func_031_72CC
    ld a, $20
    ld [$D868], a
    ld hl, $CFCB
    inc [hl]

Jump_031_57D5::
    ret

Jump_031_57D6::
    call Func_031_7529
    ld a, [$D868]
    ld [$CFCB], a
    ret

Jump_031_57E0::
    ld a, [$CFD4]
    and a, $04
    or a, $03
    ld b, a

Jump_031_57E8::
    ld a, [$CFD4]
    inc a
    ld [$CFD4], a
    cp a, b
    jr z, Jump_031_5804
    ld hl, $DA5B
    add a, l
    ld l, a
    jr nc, Jump_031_57FA
    inc h

Jump_031_57FA::
    ld a, [hl]
    or a, a
    jr nz, Jump_031_57E8
    xor a, a
    ld [$CFCB], a
    jr Jump_031_580D

Jump_031_5804::
    xor a, a
    ld [$CFCB], a
    ld a, $03
    ld [$CFCA], a

Jump_031_580D::
    ret

Jump_031_580E::
    call Func_031_7479
    xor a, a
    ld [$C528], a
    ld hl, Func_031_4001
    ld b, $2F
    rst $10
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_5820::
    call Func_031_7479
    ld a, $18
    ld [$CFCB], a
    ret

Jump_031_5829::
    ld a, [$CFCB]
    rst $00
    dw Jump_031_5855
    dw Jump_031_589C
    dw Jump_031_58CF
    dw Jump_031_59B0
    dw Jump_031_59BC
    dw Jump_031_59EA
    dw Jump_031_5A0C
    dw Jump_031_5A90
    dw Jump_031_5AA6
    dw Jump_031_5AC1
    dw Jump_031_5AFD
    dw Jump_031_5B49
    dw Jump_031_5B7B
    dw Jump_031_5B98
    dw Jump_031_5BD6
    dw Jump_031_5C26
    dw Jump_031_5C58
    dw Jump_031_5C63
    dw Jump_031_5C6B
    dw Jump_031_5C80

Jump_031_5855::
    call Func_031_722A
    call Func_031_72CC
    call Func_031_7536
    ld hl, $CFD5
    res 7, [hl]
    ld de, $63A7
    call Func_031_624F
    call Func_031_6288
    call Func_031_74C1
    ld a, $06
    ld [$C528], a
    ld hl, $C61D
    ld a, [$CFD5]
    and a, $0F
    add a, a
    add a, a
    ld c, a
    ld a, [$C471]
    and a, $03
    add a, c
    add a, l
    ld l, a
    jr nc, Jump_031_588A
    inc h

Jump_031_588A::
    ld a, [hl]
    ld [$C529], a
    ld hl, $8800
    ld de, $0603
    call Func_031_7A3D
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_589C::
    call Func_031_74C8
    ld a, [$D868]
    or a, a
    ret z
    xor a, a
    ld [$D868], a
    ld hl, $63A7
    ld a, [$C471]
    and a, $03
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_58B6
    inc h

Jump_031_58B6::
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, $9800
    add hl, de
    ld a, $BB
    call Func_000_1211
    call Func_031_6373
    ld hl, $CFCB
    inc [hl]
    ld a, $03
    ld [$CFD3], a
    ret

Jump_031_58CF::
    ld de, $63A7
    ld hl, $C471
    call Func_031_5F9E
    ld a, [$C562]
    bit 0, a
    jp z, Jump_031_597D
    ld a, $69
    call Func_000_1278
    call Func_031_722A
    call Func_031_72CC
    ld a, $00
    ld [$D869], a
    call Func_031_62D3
    ld a, [$D081]
    ld [$D893], a
    ld a, [$D088]
    bit 0, a
    jr nz, Jump_031_5921
    ld a, [$D08A]
    or a, a
    jr z, Jump_031_5933
    cp a, $01
    jr z, Jump_031_5943
    cp a, $02
    jr z, Jump_031_5953
    cp a, $03
    jr z, Jump_031_595D
    cp a, $04
    jr z, Jump_031_596D
    cp a, $05
    jr z, Jump_031_596D
    cp a, $06
    jr z, Jump_031_5974
    jp Jump_031_595D

Jump_031_5921::
    call Func_031_722A
    call Func_031_72CC
    ld a, $10
    ld [$CFCB], a
    ld a, $1E
    ld [$C529], a
    jr Jump_031_59AF

Jump_031_5933::
    call Func_031_722A
    call Func_031_72CC
    call Func_031_74C8
    ld a, $08
    ld [$CFCB], a
    jr Jump_031_59AF

Jump_031_5943::
    ld a, $10
    ld [$D892], a
    ld a, $03
    ld [$CFCA], a
    xor a, a
    ld [$CFCB], a
    jr Jump_031_59AF

Jump_031_5953::
    call Func_031_74C8
    ld a, $0C
    ld [$CFCB], a
    jr Jump_031_59AF

Jump_031_595D::
    ld a, $20
    ld [$D892], a
    ld a, $03
    ld [$CFCA], a
    xor a, a
    ld [$CFCB], a
    jr Jump_031_59AF

Jump_031_596D::
    ld a, $04
    ld [$CFCB], a
    jr Jump_031_59AF

Jump_031_5974::
    ld a, $03
    ld [$CFCA], a
    xor a, a
    ld [$CFCB], a

Jump_031_597D::
    bit 1, a
    jr z, Jump_031_5995
    call Func_031_722A
    call Func_031_72CC
    ld a, $FF
    ld [$D892], a
    ld [$D893], a
    ld hl, $CFCB
    inc [hl]
    jr Jump_031_59AF

Jump_031_5995::
    bit 2, a
    jr z, Jump_031_59A7
    ld hl, $590C
    ld b, $16
    rst $10
    ld de, $63A7
    ld hl, $CFD5
    set 7, [hl]

Jump_031_59A7::
    call Func_031_6288
    call Func_031_6373
    jr Jump_031_59AF

Jump_031_59AF::
    ret

Jump_031_59B0::
    call Func_031_74C8
    xor a, a
    ld [$CFCB], a
    xor a, a
    ld [$CFCA], a
    ret

Jump_031_59BC::
    ld a, [$C46F]
    and a, $01
    ld [$C46F], a
    ld a, [$D869]
    or a, a
    call z, Func_031_74C8
    xor a, a
    ld [$D869], a
    ld hl, $8ED0
    ld de, $0801
    ld a, $02
    ld [$C528], a
    ld a, $03
    ld [$C529], a
    call Func_031_7A02
    call Func_031_74EE
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_59EA::
    call Func_031_74F5
    ld hl, Func_031_639F
    ld a, [$C46F]
    and a, $03
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_59FB
    inc h

Jump_031_59FB::
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, $9800
    add hl, de
    ld a, $BB
    call Func_000_1211
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_5A0C::
    ld de, $63B5
    ld hl, $C46F
    call Func_031_5F02
    ld a, [$C562]
    bit 0, a
    jr z, Jump_031_5A78
    ld a, $69
    call Func_000_1278
    call Func_031_62D3
    ld a, [$D08A]
    and a, $01
    jr nz, Jump_031_5A5B
    ld a, [$D081]
    cp a, $19
    jr c, Jump_031_5A71
    cp a, $1F
    jr nc, Jump_031_5A71
    ld a, [$C46F]
    and a, $01
    jr z, Jump_031_5A71
    ld b, $04
    ld a, [$DA67]
    or a, a
    jr z, Jump_031_5A55
    ld b, $05
    ld a, [$DA68]
    or a, a
    jr z, Jump_031_5A55
    ld b, $06
    ld a, [$DA69]
    or a, a
    jr nz, Jump_031_5A8F

Jump_031_5A55::
    ld a, b
    ld [$D892], a
    jr Jump_031_5A66

Jump_031_5A5B::
    ld a, [$C46F]
    and a, $01
    inc a
    swap a
    ld [$D892], a

Jump_031_5A66::
    ld a, $03
    ld [$CFCA], a
    xor a, a
    ld [$CFCB], a
    jr Jump_031_5A8F

Jump_031_5A71::
    ld a, $01
    ld [$D868], a
    jr Jump_031_5A85

Jump_031_5A78::
    bit 1, a
    jr z, Jump_031_5A8F
    xor a, a
    ld [$C46F], a
    ld a, $00
    ld [$D868], a

Jump_031_5A85::
    call Func_031_722A
    call Func_031_72CC
    ld hl, $CFCB
    inc [hl]

Jump_031_5A8F::
    ret

Jump_031_5A90::
    call Func_031_74F5
    ld a, [$D868]
    or a, a
    jr z, Jump_031_5AA2
    ld a, [$C46F]
    and a, $01
    add a, a
    add a, a
    add a, $08

Jump_031_5AA2::
    ld [$CFCB], a
    ret

Jump_031_5AA6::
    ld hl, $8ED0
    ld de, $0801
    ld a, $02
    ld [$C528], a
    ld a, $03
    ld [$C529], a
    call Func_031_7A02
    call Func_031_645E
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_5AC1::
    call Func_031_74E1
    ld a, [$D081]
    cp a, $0C
    jr z, Jump_031_5ACC
    xor a, a

Jump_031_5ACC::
    ld [$D86C], a
    ld a, [$C57F]
    sla a
    and a, $04
    ld b, a
    ld hl, $C470
    ld e, $01
    ld a, $00
    call Func_031_64D8
    ld hl, $63AF
    and a, $03
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_5AEC
    inc h

Jump_031_5AEC::
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, $9800
    add hl, de
    ld a, $BB
    call Func_000_1211
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_5AFD::
    ld a, [$C57F]
    sla a
    and a, $04
    ld b, a
    ld hl, $C470
    ld de, $63AF
    call Func_031_6518
    ld a, [$C562]
    bit 1, a
    jr z, Jump_031_5B26
    call Func_031_722A
    call Func_031_72CC
    ld a, $00
    ld [$D868], a
    ld hl, $CFCB
    inc [hl]
    jr Jump_031_5B48

Jump_031_5B26::
    bit 0, a
    jr z, Jump_031_5B48
    ld a, $69
    call Func_000_1278
    call Func_031_722A
    call Func_031_72CC
    ld a, [$C470]
    and a, $03
    ld [$D892], a
    ld a, $01
    ld [$D868], a
    ld hl, $CFCB
    inc [hl]
    jr Jump_031_5B48

Jump_031_5B48::
    ret

Jump_031_5B49::
    call Func_031_74E1
    ld a, [$D868]
    or a, a
    jr nz, Jump_031_5B66
    call Func_031_62D3
    ld a, [$D08A]
    cp a, $04
    jr z, Jump_031_5B71
    cp a, $05
    jr z, Jump_031_5B71
    xor a, a
    ld [$CFCB], a
    jr Jump_031_5B76

Jump_031_5B66::
    ld a, $03
    ld [$CFCA], a
    xor a, a
    ld [$CFCB], a
    jr Jump_031_5B76

Jump_031_5B71::
    ld a, $04
    ld [$CFCB], a

Jump_031_5B76::
    xor a, a
    ld [$D868], a
    ret

Jump_031_5B7B::
    call Func_031_7522
    ld a, [$D081]
    cp a, $0C
    jr z, Jump_031_5B86
    xor a, a

Jump_031_5B86::
    ld [$D869], a
    ld hl, Data_031_7BA0
    ld b, $3A
    rst $10
    xor a, a
    ld [$D869], a
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_5B98::
    call Func_031_7529
    ld a, [$D081]
    cp a, $0C
    jr z, Jump_031_5BA3
    xor a, a

Jump_031_5BA3::
    ld [$D86C], a
    ld a, [$C57F]
    sla a
    and a, $04
    xor a, $04
    ld b, a
    ld hl, $C470
    ld e, $01
    ld a, $00
    call Func_031_64D8
    ld hl, $63AF
    and a, $03
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_5BC5
    inc h

Jump_031_5BC5::
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, $9800
    add hl, de
    ld a, $BB
    call Func_000_1211
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_5BD6::
    ld a, [$C57F]
    sla a
    and a, $04
    xor a, $04
    ld b, a
    ld hl, $C470
    ld de, $63AF
    call Func_031_6518
    ld a, [$C562]
    bit 1, a
    jr z, Jump_031_5C01
    call Func_031_722A
    call Func_031_72CC
    ld a, $00
    ld [$D868], a
    ld hl, $CFCB
    inc [hl]
    jr Jump_031_5C25

Jump_031_5C01::
    bit 0, a
    jr z, Jump_031_5C25
    ld a, $69
    call Func_000_1278
    call Func_031_722A
    call Func_031_72CC
    ld a, [$C470]
    and a, $03
    set 2, a
    ld [$D892], a
    ld a, $01
    ld [$D868], a
    ld hl, $CFCB
    inc [hl]
    jr Jump_031_5C25

Jump_031_5C25::
    ret

Jump_031_5C26::
    call Func_031_74E1
    ld a, [$D868]
    or a, a
    jr nz, Jump_031_5C43
    call Func_031_62D3
    ld a, [$D08A]
    cp a, $04
    jr z, Jump_031_5C4E
    cp a, $05
    jr z, Jump_031_5C4E
    xor a, a
    ld [$CFCB], a
    jr Jump_031_5C53

Jump_031_5C43::
    ld a, $03
    ld [$CFCA], a
    xor a, a
    ld [$CFCB], a
    jr Jump_031_5C53

Jump_031_5C4E::
    ld a, $04
    ld [$CFCB], a

Jump_031_5C53::
    xor a, a
    ld [$D868], a
    ret

Jump_031_5C58::
    call Func_031_74C8
    call Func_031_746F
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_5C63::
    call Func_031_7479
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_5C6B::
    xor a, a
    ld [$C528], a
    ld hl, Func_031_4001
    ld b, $2F
    rst $10
    ld hl, $CFCB
    inc [hl]
    call Func_031_722A
    call Func_031_72CC
    ret

Jump_031_5C80::
    ld a, [$C52B]
    or a, a
    ret nz
    call Func_031_7479
    xor a, a
    ld [$CFCB], a
    ret

Jump_031_5C8D::
    ld b, $08
    ld hl, $DA5B

Jump_031_5C92::
    ld a, [hl]
    or a, a
    jr nz, Jump_031_5C98
    ld [hl], $01

Jump_031_5C98::
    inc hl
    dec b
    jr nz, Jump_031_5C92
    xor a, a
    ld [$D8A4], a
    call Func_031_722A
    call Func_031_72CC
    call Func_031_746F
    call Func_031_7536
    ld hl, $CFCA
    inc [hl]
    xor a, a
    ld [$C594], a
    ret

Jump_031_5CB5::
    ld a, [$C58A]
    or a, a
    jr z, Jump_031_5CD8
    ld de, $C958
    ld hl, $C130
    call Func_000_2FE1
    ld a, $00
    ld [$C528], a
    ld a, $22
    ld [$C529], a
    ld hl, Func_031_4001
    ld b, $2F
    rst $10
    xor a, a
    ld [$C594], a

Jump_031_5CD8::
    ld hl, $CFCA
    inc [hl]
    ret

Jump_031_5CDD::
    ld a, [$C58A]
    or a, a
    jr z, Jump_031_5CE8
    ld a, $01
    ld [$C594], a

Jump_031_5CE8::
    ld hl, $CFCA
    inc [hl]
    ret

Jump_031_5CED::
    ld a, [$C58A]
    or a, a
    jp z, Jump_031_5D8D
    ld a, [$C58F]
    cp a, $01
    ret nz
    xor a, a
    ld [$C594], a
    ld de, $DA43
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_031_5D0B
    ld de, $DA47

Jump_031_5D0B::
    ld hl, $C597
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    ld a, [$C5E7]
    ld [hl+], a
    ld a, [$C5E8]
    ld [hl+], a
    ld a, [$C46B]
    ld [hl+], a
    ld a, [$C46B]
    ld [hl+], a
    ld de, $DA1C
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_031_5D33
    ld de, $DA24

Jump_031_5D33::
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    ld de, $DA5B
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_031_5D51
    ld de, $DA5F

Jump_031_5D51::
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    ld de, $DAD8
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_031_5D66
    ld de, $DADC

Jump_031_5D66::
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    ld a, $13
    ld [$C592], a
    xor a, a
    ld [$C593], a
    ld hl, $C597
    ld a, l
    ld [$C595], a
    ld a, h
    ld [$C596], a
    ld hl, $C5B7
    ld a, l
    ld [$C590], a
    ld a, h
    ld [$C591], a

Jump_031_5D8D::
    ld hl, $CFCA
    inc [hl]
    ret

Jump_031_5D92::
    ld hl, $CFCA
    inc [hl]
    ld a, [$C58A]
    and a, a
    jr z, Jump_031_5DA6
    ld a, $FF
    ld [$C594], a
    ld a, $01
    ld [$C58C], a

Jump_031_5DA6::
    ret

Jump_031_5DA7::
    ld a, [$C58A]
    or a, a
    jp z, Jump_031_5E78
    ld a, [$C58F]
    cp a, $F0
    ret nz
    xor a, a
    ld [$C594], a
    xor a, a
    ld [$C58C], a
    ld de, $DA47
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_031_5DC9
    ld de, $DA43

Jump_031_5DC9::
    ld hl, $C5B7
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc hl
    inc hl
    ld a, [hl+]
    ld [$DAE9], a
    ld a, [hl+]
    ld [$DAEA], a
    ld de, $DA24
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_031_5DEB
    ld de, $DA1C

Jump_031_5DEB::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    ld de, $DA5F
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_031_5E09
    ld de, $DA5B

Jump_031_5E09::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    ld de, $DADC
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_031_5E1E
    ld de, $DAD8

Jump_031_5E1E::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    ld a, [$C57F]
    bit 1, a
    jr nz, Jump_031_5E4D
    ld a, [$C5E7]
    ld [$C5BA], a
    ld a, [$C5E8]
    ld [$C5BB], a
    ld a, [$C46B]
    ld [$C5BC], a
    ld a, [$C46B]
    ld [$DAE9], a
    ld hl, $DA47
    ld de, $DA4F
    jr Jump_031_5E6B

Jump_031_5E4D::
    ld a, [$C5BA]
    ld [$C5E7], a
    ld a, [$C5BB]
    ld [$C5E8], a
    ld a, [$C46B]
    ld [$C5BD], a
    ld a, [$C46B]
    ld [$DAEA], a
    ld hl, $DA43
    ld de, $DA4B

Jump_031_5E6B::
    ld b, $03

Jump_031_5E6D::
    ld a, [hl]
    cp a, $03
    jr z, Jump_031_5E73
    ld [de], a

Jump_031_5E73::
    inc hl
    inc de
    dec b
    jr nz, Jump_031_5E6D

Jump_031_5E78::
    ld hl, $CFCA
    inc [hl]
    ret

Jump_031_5E7D::
    ld a, [$C58A]
    and a, a
    jr nz, Jump_031_5E85
    jr Jump_031_5EB2

Jump_031_5E85::
    ld hl, $C59A
    ld a, [hl+]
    ld b, a
    ld a, [$C5E7]
    cp a, b
    ld a, [$C5BA]
    cp a, b
    jr nz, Jump_031_5EAA
    ld a, [hl]
    ld b, a
    ld a, [$C5E8]
    cp a, b
    ld a, [$C5BB]
    cp a, b
    jr nz, Jump_031_5EAA
    ld a, $22
    ld [$C594], a
    ld [$CF8B], a
    jr Jump_031_5EB2

Jump_031_5EAA::
    ld a, $33
    ld [$C594], a
    ld [$CF8B], a

Jump_031_5EB2::
    ld hl, $CFCA
    inc [hl]
    ret

Jump_031_5EB7::
    ld a, [$C58A]
    and a, a
    jr z, Jump_031_5ED0
    ld a, [$C58F]
    cp a, $22
    jr z, Jump_031_5EC9
    cp a, $33
    jr z, Jump_031_5EC9
    ret

Jump_031_5EC9::
    ld [$CF8C], a
    xor a, a
    ld [$C594], a

Jump_031_5ED0::
    ld hl, $CFCA
    inc [hl]
    ret

Jump_031_5ED5::
    ld a, [$C58A]
    and a, a
    jr z, Jump_031_5EF1
    ld a, [$CF8B]
    cp a, $22
    jr nz, Jump_031_5EEB
    ld a, [$CF8C]
    cp a, $22
    jr nz, Jump_031_5EEB
    jr Jump_031_5EF1

Jump_031_5EEB::
    ld a, $05
    ld [$CFCA], a
    ret

Jump_031_5EF1::
    ld hl, $CFCA
    inc [hl]
    ret

Jump_031_5EF6::
    call Func_000_290E
    ld hl, $CFC9
    inc [hl]
    xor a, a
    ld [$CFCA], a
    ret

Func_031_5F02::
    ld a, [$C563]
    and a, $C0
    jr z, Jump_031_5F1A
    call Func_031_60AD
    ld a, [hl]
    xor a, $01
    ld [hl], a
    call Func_031_60CC
    ld a, $69
    call Func_000_1278
    jr Jump_031_5F45

Jump_031_5F1A::
    ld a, [$C563]
    and a, $30
    jr z, Jump_031_5F32
    call Func_031_60AD
    ld a, [hl]
    xor a, $02
    ld [hl], a
    call Func_031_60CC
    ld a, $69
    call Func_000_1278
    jr Jump_031_5F45

Jump_031_5F32::
    ld a, [$C5F0]
    and a, $0F
    jr nz, Jump_031_5F4D
    bit 6, [hl]
    jr z, Jump_031_5F42
    call Func_031_60CC
    jr Jump_031_5F45

Jump_031_5F42::
    call Func_031_60AD

Jump_031_5F45::
    ld a, [$C5F0]
    and a, $F0
    ld [$C5F0], a

Jump_031_5F4D::
    ret

Func_031_5F4E::
    ld a, [$C563]
    and a, $40
    jr z, Jump_031_5F64
    call Func_031_60AD
    ld a, [hl]
    and a, $03
    dec a
    cp a, $FF
    jr nz, Jump_031_5F77
    ld a, $02
    jr Jump_031_5F77

Jump_031_5F64::
    ld a, [$C563]
    and a, $80
    jr z, Jump_031_5F82
    call Func_031_60AD
    ld a, [hl]
    and a, $03
    inc a
    cp a, $03
    jr nz, Jump_031_5F77
    xor a, a

Jump_031_5F77::
    ld [hl], a
    call Func_031_60CC
    ld a, $69
    call Func_000_1278
    jr Jump_031_5F95

Jump_031_5F82::
    ld a, [$C5F0]
    and a, $0F
    jr nz, Jump_031_5F9D
    bit 6, [hl]
    jr z, Jump_031_5F92
    call Func_031_60CC
    jr Jump_031_5F95

Jump_031_5F92::
    call Func_031_60AD

Jump_031_5F95::
    ld a, [$C5F0]
    and a, $F0
    ld [$C5F0], a

Jump_031_5F9D::
    ret

Func_031_5F9E::
    ld a, [$C563]
    and a, $40
    jr z, Jump_031_5FE2
    ld a, [$CFD5]
    ld b, a
    ld a, [$CFD7]
    cp a, b
    jr nz, Jump_031_5FC6
    ld a, [$CFD6]
    or a, a
    jp z, Jump_031_60A4
    call Func_031_60AD
    ld a, [hl]
    and a, $0F
    dec a
    cp a, $FF
    jr nz, Jump_031_5FD4
    ld a, [$CFD6]
    jr Jump_031_5FD4

Jump_031_5FC6::
    call Func_031_60AD
    ld a, [hl]
    and a, $0F
    dec a
    cp a, $FF
    jr nz, Jump_031_5FD4
    ld a, [$CFD3]

Jump_031_5FD4::
    ld [hl], a
    call Func_031_60CC
    set 7, [hl]
    ld a, $69
    call Func_000_1278
    jp Jump_031_60A4

Jump_031_5FE2::
    ld a, [$C563]
    and a, $80
    jr z, Jump_031_6027
    ld a, [$CFD5]
    ld b, a
    ld a, [$CFD7]
    cp a, b
    jr nz, Jump_031_600A
    ld a, [$CFD6]
    or a, a
    jp z, Jump_031_60A4
    ld b, a
    call Func_031_60AD
    inc b
    ld a, [hl]
    and a, $0F
    inc a
    cp a, b
    jr nz, Jump_031_601A
    ld a, $00
    jr Jump_031_601A

Jump_031_600A::
    call Func_031_60AD
    ld a, [$CFD3]
    inc a
    ld b, a
    ld a, [hl]
    and a, $0F
    inc a
    cp a, b
    jr nz, Jump_031_601A
    xor a, a

Jump_031_601A::
    ld [hl], a
    call Func_031_60CC
    set 7, [hl]
    ld a, $69
    call Func_000_1278
    jr Jump_031_60A4

Jump_031_6027::
    ld a, [$CFD7]
    or a, a
    jr z, Jump_031_6068
    ld b, a
    ld a, [$C563]
    and a, $20
    jr z, Jump_031_604B
    ld a, [$CFD5]
    or a, a
    jr nz, Jump_031_603E
    ld a, b
    jr Jump_031_603F

Jump_031_603E::
    dec a

Jump_031_603F::
    or a, $80
    ld [$CFD5], a
    ld a, $69
    call Func_000_1278
    jr Jump_031_607D

Jump_031_604B::
    ld a, [$C563]
    and a, $10
    jr z, Jump_031_6068
    ld a, [$CFD5]
    cp a, b
    jr nz, Jump_031_605B
    xor a, a
    jr Jump_031_605C

Jump_031_605B::
    inc a

Jump_031_605C::
    or a, $80
    ld [$CFD5], a
    ld a, $69
    call Func_000_1278
    jr Jump_031_607D

Jump_031_6068::
    ld a, [$C5F0]
    and a, $0F
    jr nz, Jump_031_60AC
    bit 6, [hl]
    jr z, Jump_031_6078
    call Func_031_60CC
    jr Jump_031_60A4

Jump_031_6078::
    call Func_031_60AD
    jr Jump_031_60A4

Jump_031_607D::
    call Func_031_60AD
    ld a, [$CFD7]
    ld b, a
    ld a, [$CFD5]
    res 7, a
    cp a, b
    jr nz, Jump_031_60A4
    ld a, [$CFD6]
    or a, a
    jr nz, Jump_031_6095
    xor a, a
    jr Jump_031_60A1

Jump_031_6095::
    ld b, a

Jump_031_6096::
    ld a, [hl]
    and a, $0F
    cp a, b
    jr z, Jump_031_60A1
    jr c, Jump_031_60A4
    dec [hl]
    jr Jump_031_6096

Jump_031_60A1::
    set 7, a
    ld [hl], a

Jump_031_60A4::
    ld a, [$C5F0]
    and a, $F0
    ld [$C5F0], a

Jump_031_60AC::
    ret

Func_031_60AD::
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
    call Func_000_1211
    pop hl
    ret

Func_031_60CC::
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
    call Func_000_1211
    pop hl
    ret

Func_031_60EB::
    push hl
    ld hl, Data_031_6102
    add a, l
    ld l, a
    jr nc, Jump_031_60F4
    inc h

Jump_031_60F4::
    xor a, a
    ld [$C46C], a
    ld a, [hl]
    pop hl
    ld b, $05

Jump_031_60FC::
    ld [hl+], a
    inc a
    dec b
    jr nz, Jump_031_60FC
    ret

Data_031_6102:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D0, $D5, $DA

Func_031_6105::
    ld a, [$CFD4]
    ld hl, $D989
    swap a
    and a, $F0
    add a, l
    ld l, a
    jr nc, Jump_031_6114
    inc h

Jump_031_6114::
    ld a, l
    ld [$D86A], a
    ld a, h
    ld [$D86B], a
    ld bc, $0800
    ld d, $00

Jump_031_6121::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_031_6137
    or a, a
    jr z, Jump_031_6137
    cp a, $A2
    jr c, Jump_031_6131
    cp a, $AA
    jr c, Jump_031_6132

Jump_031_6131::
    inc d

Jump_031_6132::
    inc c
    inc hl
    dec b
    jr nz, Jump_031_6121

Jump_031_6137::
    ld a, c
    cp a, $05
    ld a, $00
    jr c, Jump_031_613F
    inc a

Jump_031_613F::
    ld [$CFD7], a
    ld a, c
    or a, a
    jr z, Jump_031_614B
    and a, $03
    dec a
    and a, $03

Jump_031_614B::
    ld [$CFD6], a
    xor a, a
    ld [$CFD5], a
    ret

Func_031_6153::
    ld a, $04
    ld [$C528], a
    ld a, [$CFD4]
    ld hl, $D989
    swap a
    and a, $F0
    add a, l
    ld l, a
    jr nc, Jump_031_6167
    inc h

Jump_031_6167::
    ld a, l
    ld [$D86A], a
    ld a, h
    ld [$D86B], a
    ld a, [$CFD5]
    add a, a
    add a, a
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_617A
    inc h

Jump_031_617A::
    ld a, [hl+]
    inc hl
    cp a, $FF
    call z, Func_031_61A2
    call Func_031_62F7
    ld a, [hl+]
    inc hl
    cp a, $FF
    call z, Func_031_61A2
    call Func_031_6306
    ld a, [hl+]
    inc hl
    cp a, $FF
    call z, Func_031_61A2
    call Func_031_6315
    ld a, [hl]
    cp a, $FF
    call z, Func_031_61A2
    call Func_031_6324
    ret

Func_031_61A2::
    xor a, a
    ret

Func_031_61A4::
    ld a, [$CFD5]
    bit 7, a
    jr z, Jump_031_61BE
    res 7, a
    ld [$CFD5], a
    ld hl, $C46E
    call Func_031_60CC
    call Func_031_6153
    ld hl, $C46E
    set 7, [hl]

Jump_031_61BE::
    ld a, [$C46E]
    bit 7, a
    ret z
    res 7, a
    ld [$C46E], a
    and a, $0F
    push af
    ld a, $09
    ld [$C528], a
    ld a, [$D86A]
    ld l, a
    ld a, [$D86B]
    ld h, a
    ld a, [$CFD5]
    add a, a
    add a, a
    ld c, a
    pop af
    add a, c
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_61E7
    inc h

Jump_031_61E7::
    ld a, [hl]
    call Func_031_6331
    ld de, $C388
    ld hl, $99F0
    ld a, [de]
    call Func_000_121F
    inc de
    ld a, [de]
    call Func_000_121F
    inc de
    ld a, [de]
    call Func_000_1211
    ret

Func_031_6200::
    ld hl, $C61D
    ld bc, $1800
    ld e, $00

Jump_031_6208::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_031_6229
    or a, a
    jr z, Jump_031_6229
    inc c
    cp a, $0D
    jr c, Jump_031_6225
    cp a, $19
    jr c, Jump_031_6226
    cp a, $20
    jr c, Jump_031_6225
    cp a, $22
    jr c, Jump_031_6226
    cp a, $28
    jr nc, Jump_031_6226

Jump_031_6225::
    inc e

Jump_031_6226::
    dec b
    jr nz, Jump_031_6208

Jump_031_6229::
    ld a, c
    and a, $FC
    rrca
    rrca
    ld [$CFD7], a
    ld a, c
    or a, a
    jr z, Jump_031_623D
    and a, $03
    call z, Func_031_6245
    dec a
    and a, $03

Jump_031_623D::
    ld [$CFD6], a
    xor a, a
    ld [$CFD5], a
    ret

Func_031_6245::
    push af
    ld a, [$CFD7]
    dec a
    ld [$CFD7], a
    pop af
    ret

Func_031_624F::
    ld a, $05
    ld [$C528], a
    ld hl, $C61D
    ld a, [$CFD5]
    add a, a
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_6261
    inc h

Jump_031_6261::
    ld a, [hl+]
    cp a, $FF
    call z, Func_031_6286
    call Func_031_62F7
    ld a, [hl+]
    cp a, $FF
    call z, Func_031_6286
    call Func_031_6306
    ld a, [hl+]
    cp a, $FF
    call z, Func_031_6286
    call Func_031_6315
    ld a, [hl]
    cp a, $FF
    call z, Func_031_6286
    call Func_031_6324
    ret

Func_031_6286::
    xor a, a
    ret

Func_031_6288::
    ld a, [$CFD5]
    bit 7, a
    jr z, Jump_031_62A2
    res 7, a
    ld [$CFD5], a
    ld hl, $C471
    call Func_031_60CC
    call Func_031_624F
    ld hl, $C471
    set 7, [hl]

Jump_031_62A2::
    ld a, [$C471]
    bit 7, a
    ret z
    res 7, a
    ld [$C471], a
    and a, $0F
    push af
    ld a, $06
    ld [$C528], a
    ld hl, $C61D
    ld a, [$CFD5]
    add a, a
    add a, a
    ld c, a
    pop af
    add a, c
    add a, l
    ld l, a
    jr nc, Jump_031_62C5
    inc h

Jump_031_62C5::
    ld a, [hl]
    ld [$C529], a
    ld hl, $8800
    ld de, $0603
    call Func_031_7A3D
    ret

Func_031_62D3::
    ld a, [$CFD5]
    and a, $0F
    add a, a
    add a, a
    ld hl, $C61D
    add a, l
    ld l, a
    jr nc, Jump_031_62E2
    inc h

Jump_031_62E2::
    ld a, [$C471]
    and a, $03
    add a, l
    ld l, a
    jr nc, Jump_031_62EC
    inc h

Jump_031_62EC::
    ld a, [hl]
    ld [$D081], a
    ld hl, $4007
    ld b, $16
    rst $10
    ret

Func_031_62F7::
    ld [$C529], a
    push hl
    ld hl, $8ED0
    ld de, $0901
    call Func_031_7A3D
    pop hl
    ret

Func_031_6306::
    ld [$C529], a
    push hl
    ld hl, $8F60
    ld de, $0901
    call Func_031_7A3D
    pop hl
    ret

Func_031_6315::
    ld [$C529], a
    push hl
    ld hl, $8FF0
    ld de, $0901
    call Func_031_7A3D
    pop hl
    ret

Func_031_6324::
    ld [$C529], a
    ld hl, $9080
    ld de, $0901
    call Func_031_7A3D
    ret

Func_031_6331::
    push af
    ld [$C529], a
    ld hl, $8800
    ld de, $0603
    call Func_031_7A3D
    pop af
    ld [$CFEC], a
    xor a, a
    ld [$CFED], a
    ld hl, Func_031_4001
    ld b, $1A
    rst $10
    ld a, [$CFEE]
    cp a, $FF
    jr nz, Jump_031_6364
    ld a, [$CFD4]
    ld hl, $D8DF
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_635F
    inc h

Jump_031_635F::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    jr Jump_031_6369

Jump_031_6364::
    ld l, a
    ld h, $00
    jr Jump_031_6369

Jump_031_6369::
    call Func_000_16F5
    ld de, $C388
    call Func_000_2123
    ret

Func_031_6373::
    ld a, [$CFD7]
    or a, a
    ret z
    ld hl, $9A26
    ld a, $C5
    call Func_000_121F
    ld a, [$CFD5]
    and a, $07
    inc a
    add a, $E0
    call Func_000_121F
    ld a, $BE
    call Func_000_121F
    ld a, [$CFD7]
    inc a
    add a, $E0
    call Func_000_121F
    ld a, $C6
    call Func_000_1211
    ret

Func_031_639F:: ; heuristic: follows a terminator; C0
    pop bc
    ld bc, $0201
    ret z
    ld bc, $0208
    ld b, c
    ld bc, $0181
    pop bc
    ld bc, $0201
    add a, c
    ld bc, $01C1
    ld bc, $C102
    ld bc, $0201
    pop bc
    ld bc, $0201
    add hl, hl
    nop
    ld l, c
    nop
    xor a, c
    nop
    jp hl
    db $00

Data_031_63C5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2F, $01, $6F, $01, $2F, $01, $6F, $01

Func_031_63CD::
    push af
    ld a, [$CFD4]
    ld hl, $DA43
    add a, l
    ld l, a
    jr nc, Jump_031_63D9
    inc h

Jump_031_63D9::
    pop af
    ld [hl], a
    cp a, $03
    ret z
    push af
    ld a, [$CFD4]
    ld hl, $DA4B
    add a, l
    ld l, a
    jr nc, Jump_031_63EA
    inc h

Jump_031_63EA::
    pop af
    ld [hl], a
    ret

Func_031_63ED::
    ld a, [$C46E]
    and a, $03
    ld b, a
    ld a, [$CFD5]
    and a, $01
    add a, a
    add a, a
    add a, b
    add a, a
    ld hl, $D989
    add a, l
    ld l, a
    jr nc, Jump_031_6404
    inc h

Jump_031_6404::
    ld a, [$CFD4]
    swap a
    add a, l
    ld l, a
    jr nc, Jump_031_640E
    inc h

Jump_031_640E::
    ld a, [hl]
    ld [$CFEC], a
    xor a, a
    ld [$CFED], a
    ld hl, Func_031_4001
    ld b, $1A
    rst $10
    ret

Func_031_641D::
    ld de, $0000
    ld b, $03
    ld a, [$C57F]
    sla a
    and a, $04
    xor a, $04
    ld c, a

Jump_031_642C::
    ld a, c
    call Func_000_3E54
    jr c, Jump_031_6434
    inc d
    ld e, c

Jump_031_6434::
    inc c
    dec b
    jr nz, Jump_031_642C
    ret

Func_031_6439::
    ld d, $00
    ld b, $03
    ld a, [$C57F]
    sla a
    and a, $04
    ld c, a

Jump_031_6445::
    ld a, c
    call Func_000_3E54
    jr c, Jump_031_644C
    inc d

Jump_031_644C::
    inc c
    dec b
    jr nz, Jump_031_6445
    ret

Func_031_6451::
    ld a, [$CFEC]
    cp a, $1E
    jr z, Jump_031_6465
    cp a, $1F
    jr z, Jump_031_6465
    jr Jump_031_6486

Func_031_645E::
    ld a, [$D081]
    cp a, $0C
    jr nz, Jump_031_6486

Jump_031_6465::
    ld a, [$C57F]
    sla a
    and a, $04
    ld de, $DA63
    add a, e
    ld e, a
    jr nc, Jump_031_6474
    inc d

Jump_031_6474::
    ld b, $03
    ld hl, $D86D

Jump_031_6479::
    ld a, [de]
    cp a, $FF
    jr z, Jump_031_647F
    xor a, a

Jump_031_647F::
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_031_6479
    jr Jump_031_64A2

Jump_031_6486::
    ld a, [$C57F]
    sla a
    and a, $04
    ld de, $DA63
    add a, e
    ld e, a
    jr nc, Jump_031_6495
    inc d

Jump_031_6495::
    ld b, $03
    ld hl, $D86D

Jump_031_649A::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_031_649A
    jr Jump_031_64A2

Jump_031_64A2::
    call Func_031_74DA
    ld hl, $C31A
    ld a, [$D86D]
    or a, a
    call nz, Func_031_64CE
    ld a, l
    add a, $40
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [$D86E]
    or a, a
    call nz, Func_031_64CE
    ld a, l
    add a, $40
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [$D86F]
    or a, a
    call nz, Func_031_64CE
    ret

Func_031_64CE::
    push hl
    ld a, $C3
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    pop hl
    ret

Func_031_64D8::
    or a, a
    jr nz, Jump_031_64EB
    ld a, [$D86C]
    or a, a
    jr z, Jump_031_64E5
    ld c, $00
    jr Jump_031_6513

Jump_031_64E5::
    ld a, [hl]
    and a, $03
    dec a
    jr Jump_031_64EE

Jump_031_64EB::
    ld a, [hl]
    and a, $03

Jump_031_64EE::
    add a, e
    and a, $03
    or a, b
    ld c, a
    ld d, $04

Jump_031_64F5::
    ld a, c
    and a, $03
    cp a, $03
    jr z, Jump_031_650A
    ld a, c
    call Func_000_3E54
    jr nc, Jump_031_6513
    jr z, Jump_031_650A
    ld a, [$D86C]
    or a, a
    jr nz, Jump_031_6513

Jump_031_650A::
    ld a, c
    add a, e
    and a, $03
    or a, b
    ld c, a
    dec d
    jr nz, Jump_031_64F5

Jump_031_6513::
    ld a, c
    and a, $03
    ld [hl], a
    ret

Func_031_6518::
    ld a, [$C563]
    and a, $40
    jr z, Jump_031_6530
    call Func_031_60AD
    push de
    ld e, $FF
    ld a, $01
    call Func_031_64D8
    pop de
    call Func_031_60CC
    jr Jump_031_655B

Jump_031_6530::
    ld a, [$C563]
    and a, $80
    jr z, Jump_031_6548
    call Func_031_60AD
    push de
    ld e, $01
    ld a, $01
    call Func_031_64D8
    pop de
    call Func_031_60CC
    jr Jump_031_655B

Jump_031_6548::
    ld a, [$C5F0]
    and a, $0F
    jr nz, Jump_031_6563
    bit 6, [hl]
    jr z, Jump_031_6558
    call Func_031_60CC
    jr Jump_031_655B

Jump_031_6558::
    call Func_031_60AD

Jump_031_655B::
    ld a, [$C5F0]
    and a, $F0
    ld [$C5F0], a

Jump_031_6563::
    ret

Func_031_6564:: ; heuristic: follows a terminator; C0
    ld hl, $443B
    ld b, $E0
    rst $10
    ret

Func_031_656B::
    ld a, [$D067]
    ld [$D7FE], a
    xor a, a
    ld [$D067], a
    ld a, [$CFC5]
    cp a, $08
    jr nc, Jump_031_65A0
    ld bc, $0300
    ld e, $00
    call Func_031_65FF
    jr c, Jump_031_659C
    ld bc, $0304
    ld de, $0000
    call Func_031_6620
    jr nc, Jump_031_659C
    ld a, d
    or a, a
    jr z, Jump_031_6598
    xor a, a
    jr Jump_031_65FB

Jump_031_6598::
    ld a, $02
    jr Jump_031_65FB

Jump_031_659C::
    ld a, $01
    jr Jump_031_65FB

Jump_031_65A0::
    ld a, [$D092]
    or a, a
    jr nz, Jump_031_65FB
    ld a, [$C57F]
    bit 1, a
    jr nz, Jump_031_65CF
    ld bc, $0300
    ld e, $00
    call Func_031_65FF
    jr nc, Jump_031_65C3
    ld bc, $0304
    ld e, $00
    call Func_031_65FF
    jr c, Jump_031_65F9
    jr Jump_031_65F5

Jump_031_65C3::
    ld bc, $0304
    ld e, $00
    call Func_031_65FF
    jr c, Jump_031_65F1
    jr Jump_031_65F9

Jump_031_65CF::
    ld bc, $0304
    ld e, $00
    call Func_031_65FF
    jr nc, Jump_031_65E5
    ld bc, $0300
    ld e, $00
    call Func_031_65FF
    jr c, Jump_031_65F9
    jr Jump_031_65F5

Jump_031_65E5::
    ld bc, $0300
    ld e, $00
    call Func_031_65FF
    jr c, Jump_031_65F1
    jr Jump_031_65F9

Jump_031_65F1::
    ld a, $04
    jr Jump_031_65FB

Jump_031_65F5::
    ld a, $05
    jr Jump_031_65FB

Jump_031_65F9::
    ld a, $80

Jump_031_65FB::
    ld [$D092], a
    ret

Func_031_65FF::
    ld a, c
    ld hl, $DA63
    add a, l
    ld l, a
    jr nc, Jump_031_6608
    inc h

Jump_031_6608::
    ld a, [hl]
    or a, a
    jr nz, Jump_031_6618
    ld a, c
    ld hl, $D80C
    call Func_000_3F25
    bit 6, [hl]
    jr nz, Jump_031_6618
    inc e

Jump_031_6618::
    inc c
    dec b
    jr nz, Func_031_65FF
    ld a, e
    cp a, $01
    ret

Func_031_6620::
    ld a, c
    ld hl, $DA63
    add a, l
    ld l, a
    jr nc, Jump_031_6629
    inc h

Jump_031_6629::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_031_6635
    or a, a
    jr nz, Jump_031_6634
    inc e
    jr Jump_031_6635

Jump_031_6634::
    inc d

Jump_031_6635::
    inc c
    dec b
    jr nz, Func_031_6620
    ld a, e
    cp a, $01
    ret

Func_031_663D::
    ld a, [$C58A]
    or a, a
    jr nz, Jump_031_6677
    ld a, $0A
    ld [$0100], a
    ld a, $00
    ld [$4100], a
    ld a, [$D88F]
    ld b, a
    ld c, $00

Jump_031_6653::
    push bc
    call Func_031_6678
    ld a, c
    push bc
    ld c, $55
    call Func_000_1F49
    pop bc
    call Func_031_66AE
    call Func_031_66E2
    call Func_031_6723
    call Func_031_6757
    call Func_031_6776
    pop bc
    inc c
    dec b
    jr nz, Jump_031_6653
    xor a, a
    ld [$0100], a

Jump_031_6677::
    ret

Func_031_6678::
    push bc
    ld a, c
    ld hl, $DA43
    add a, l
    ld l, a
    jr nc, Jump_031_6682
    inc h

Jump_031_6682::
    ld a, [hl]
    and a, $03
    ld b, a
    ld a, c
    ld hl, $DA4B
    add a, l
    ld l, a
    jr nc, Jump_031_668F
    inc h

Jump_031_668F::
    ld a, [hl]
    rlca
    rlca
    and a, $0C
    or a, b
    swap a
    push af
    ld a, c
    ld c, $0E
    call Func_000_1F49
    ld a, [hl]
    and a, $0F
    pop bc
    or a, b
    ld [hl], a
    ld a, [$C46B]
    and a, $03
    ld [$C835], a
    pop bc
    ret

Func_031_66AE::
    ld [hl], $00
    ld a, c
    ld de, $DA63
    add a, e
    ld e, a
    jr nc, Jump_031_66B9
    inc d

Jump_031_66B9::
    ld a, [de]
    cp a, $01
    jr z, Jump_031_66D9
    ld a, [$CFC5]
    cp a, $04
    ret z
    ld a, c
    push hl
    ld hl, $D80C
    call Func_000_3F25
    ld a, [hl]
    pop hl
    bit 5, a
    call nz, Func_031_66DC
    and a, $03
    call nz, Func_031_66DF
    ret

Jump_031_66D9::
    set 7, [hl]
    ret

Func_031_66DC::
    set 0, [hl]
    ret

Func_031_66DF::
    set 2, [hl]
    ret

Func_031_66E2::
    ld a, [hl]
    ld [$D868], a
    bit 7, [hl]
    push af
    ld a, l
    add a, $06
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    pop af
    jr nz, Jump_031_6719
    push hl
    inc hl
    inc hl
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    push hl
    ld a, c
    ld hl, $D8BF
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_6705
    inc h

Jump_031_6705::
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    pop hl
    ld a, l
    sub a, e
    ld l, a
    ld a, h
    sbc a, d
    ld h, a
    bit 7, h
    jr z, Jump_031_6716
    add hl, de
    ld d, h
    ld e, l

Jump_031_6716::
    pop hl
    jr Jump_031_671C

Jump_031_6719::
    ld de, $0000

Jump_031_671C::
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl+], a
    inc hl
    inc hl
    ret

Func_031_6723::
    push hl
    inc hl
    inc hl
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    push hl
    ld a, c
    ld hl, $D8DF
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_6734
    inc h

Jump_031_6734::
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    pop hl
    bit 7, d
    jr nz, Jump_031_6747
    ld a, l
    sub a, e
    ld l, a
    ld a, h
    sbc a, d
    ld h, a
    bit 7, h
    jr z, Jump_031_6749
    add hl, de

Jump_031_6747::
    ld d, h
    ld e, l

Jump_031_6749::
    pop hl
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl+], a
    ld a, l
    add a, $0A
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ret

Func_031_6757::
    ld a, [$D868]
    bit 7, a
    jr nz, Jump_031_676D
    ld a, c
    ld de, $D93F
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_031_6768
    inc d

Jump_031_6768::
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl-], a

Jump_031_676D::
    ld a, l
    add a, $04
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ret

Func_031_6776::
    ld a, [$D868]
    bit 7, a
    jr nz, Jump_031_67A9
    ld a, c
    ld de, $D968
    add a, e
    ld e, a
    jr nc, Jump_031_6786
    inc d

Jump_031_6786::
    ld a, [de]
    ld [hl+], a
    ld a, c
    ld de, $D978
    add a, e
    ld e, a
    jr nc, Jump_031_6791
    inc d

Jump_031_6791::
    ld a, [de]
    ld [hl+], a
    ld a, c
    ld de, $D980
    add a, e
    ld e, a
    jr nc, Jump_031_679C
    inc d

Jump_031_679C::
    ld a, [de]
    ld [hl+], a
    ld a, c
    ld de, $D970
    add a, e
    ld e, a
    jr nc, Jump_031_67A7
    inc d

Jump_031_67A7::
    ld a, [de]
    ld [hl], a

Jump_031_67A9::
    ret

Func_031_67AA::
    ld a, [$CFCA]
    rst $00
    dw Jump_031_67C2
    dw Jump_031_6851
    dw Jump_031_68B8
    dw Jump_031_6966
    dw Jump_031_6A0A
    dw Jump_031_6AC2
    dw Jump_031_6B65
    dw Jump_031_6BAC
    dw Jump_031_6C5E
    dw Jump_031_6C67

Jump_031_67C2::
    ld a, [$CFC5]
    cp a, $04
    jr c, Jump_031_67E4
    cp a, $06
    jr z, Jump_031_67E4
    cp a, $07
    jr z, Jump_031_67E4
    xor a, a
    ld [$CFCB], a
    ld a, $09
    ld [$CFCA], a
    ld a, [$C58A]
    ret z
    ld a, $08
    ld [$CFCA], a
    ret

Jump_031_67E4::
    ld bc, $0300
    ld d, $00

Jump_031_67E9::
    ld a, c
    ld hl, $DA63
    add a, l
    ld l, a
    jr nc, Jump_031_67F2
    inc h

Jump_031_67F2::
    ld a, [hl]
    or a, a
    jr nz, Jump_031_67F7
    inc d

Jump_031_67F7::
    inc c
    dec b
    jr nz, Jump_031_67E9
    ld a, [$DA6B]
    ld l, a
    ld a, [$DA6C]
    ld h, a
    ld a, [$DA6D]
    ld e, a
    ld a, d
    push af
    call Func_000_16E2
    pop af
    ld a, l
    ldh [$FFC6], a
    ld [$DA6B], a
    ld a, h
    ldh [$FFC7], a
    ld [$DA6C], a
    ld a, e
    ldh [$FFC8], a
    ld [$DA6D], a
    ld hl, $C130
    call Func_000_2ECF
    ld hl, $0500
    call Func_031_6DDD
    ld hl, $CFCA
    inc [hl]
    ret
    db $FE, $02, $C8, $FE, $03, $28, $0D, $7D, $D6, $01, $6F, $7C, $DE, $00, $67, $7B
    db $DE, $00, $5F, $C9, $7D, $C6, $01, $6F, $7C, $CE, $00, $67, $7B, $CE, $00, $5F
    db $C9

Jump_031_6851::
    ld a, [$C52B]
    or a, a
    ret nz
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld bc, $0300

Jump_031_6862::
    ld a, c
    ld hl, $DA63
    add a, l
    ld l, a
    jr nc, Jump_031_686B
    inc h

Jump_031_686B::
    ld a, [hl]
    or a, a
    call z, Func_031_6885
    inc c
    dec b
    jr nz, Jump_031_6862
    xor a, a
    ld [$0100], a
    ld hl, $CFCA
    inc [hl]
    xor a, a
    ld [$CFCB], a
    xor a, a
    ld [$D868], a
    ret

Func_031_6885::
    push bc
    ld a, c
    ld c, $58
    call Func_000_1F49
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    ld b, a
    ld d, [hl]
    ld a, [$DA6B]
    add a, c
    ld c, a
    ld a, [$DA6C]
    adc a, b
    ld b, a
    ld a, [$DA6D]
    adc a, d
    ld d, a
    ld a, $7F
    sub a, c
    ld a, $96
    sbc a, b
    ld a, $98
    sbc a, d
    jr nc, Jump_031_68B1
    ld c, $7F
    ld b, $96
    ld d, $98

Jump_031_68B1::
    ld a, d
    ld [hl-], a
    ld a, b
    ld [hl-], a
    ld [hl], c
    pop bc
    ret

Jump_031_68B8::
    ld a, [$CFCB]
    rst $00
    dw Jump_031_68C0
    dw Jump_031_6925

Jump_031_68C0::
    ld a, [$C52B]
    or a, a
    ret nz
    ld a, [$D868]
    ld hl, $DA63
    add a, l
    ld l, a
    jr nc, Jump_031_68D0
    inc h

Jump_031_68D0::
    ld a, [hl]
    or a, a
    jr nz, Jump_031_68E7
    ld a, [$D868]
    ld hl, $C6FE
    add a, l
    ld l, a
    jr nc, Jump_031_68DF
    inc h

Jump_031_68DF::
    ld a, [hl]
    call Func_031_6D28
    bit 0, c
    jr nz, Jump_031_6901

Jump_031_68E7::
    ld a, [$C6FD]
    ld b, a
    ld a, [$D868]
    inc a
    ld [$D868], a
    cp a, b
    ret c
    ld hl, $CFCA
    inc [hl]
    ld hl, $CFCA
    inc [hl]
    ld hl, $CFCA
    inc [hl]
    ret

Jump_031_6901::
    ld a, $3C
    ld [$D2CE], a
    ld a, [$D868]
    ld hl, $D8B7
    add a, l
    ld l, a
    jr nc, Jump_031_6911
    inc h

Jump_031_6911::
    inc [hl]
    ld a, [$D868]
    ld c, a
    call Func_031_76AE
    ld a, [$D868]
    ld c, a
    call Func_031_77B9
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_6925::
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld a, [$D868]
    ld c, $01
    call Func_000_1F49
    call Func_031_6D87
    push hl
    ld a, [$D868]
    ld hl, $C6FE
    add a, l
    ld l, a
    jr nc, Jump_031_6945
    inc h

Jump_031_6945::
    ld a, [hl]
    ld [$D869], a
    ld hl, $6418
    ld b, $1A
    rst $10
    pop hl
    call Func_031_6D96
    ld hl, $0501
    call Func_031_6DDD
    xor a, a
    ld [$0100], a
    ld hl, $CFCA
    inc [hl]
    xor a, a
    ld [$CFCB], a
    ret

Jump_031_6966::
    call Func_031_71C4
    ld a, [$CFCB]
    rst $00
    dw Jump_031_6973
    dw Jump_031_69A4
    dw Jump_031_6A06

Jump_031_6973::
    ld a, [$C52B]
    or a, a
    ret nz
    ld hl, $D09D
    ld bc, $0038
    ld a, $FF
    call Func_000_0949
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld a, [$D868]
    ld c, $34
    call Func_000_1F49
    ld de, $D09D
    ld b, $08

Jump_031_6999::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_031_6999
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_69A4::
    ld a, [$C52B]
    or a, a
    ret nz
    ld hl, $60F1
    ld b, $1A
    rst $10
    ldh a, [$FFC9]
    cp a, $FF
    jr z, Jump_031_69FA
    ld l, a
    ld h, $04
    ld de, $C150
    call Func_000_2E81
    ld c, $FF
    ld hl, $0503
    ldh a, [$FFCA]
    or a, a
    jr z, Jump_031_69E2
    ld hl, $0505
    ldh a, [$FFCA]
    cp a, $02
    jr z, Jump_031_69E2
    ldh a, [$FFCB]
    ld l, a
    ld h, $04
    ld de, $C160
    call Func_000_2E81
    ld hl, $0504
    ldh a, [$FFCB]
    ld c, a

Jump_031_69E2::
    push bc
    call Func_031_6DDD
    pop bc
    ld hl, $D09D
    ld b, $38

Jump_031_69EC::
    ld a, [hl]
    cp a, c
    jr nz, Jump_031_69F5
    ldh a, [$FFC9]
    ld [hl], a
    jr Jump_031_69F9

Jump_031_69F5::
    inc hl
    dec b
    jr nz, Jump_031_69EC

Jump_031_69F9::
    ret

Jump_031_69FA::
    call Func_031_6DEC
    ld hl, $CFCB
    inc [hl]
    xor a, a
    ld [$CFCC], a
    ret

Jump_031_6A06::
    call Func_031_6E67
    ret

Jump_031_6A0A::
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    call Func_031_6AAE
    call Func_031_6A2D
    call Func_031_6A92
    xor a, a
    ld [$0100], a
    ld hl, $CFCA
    dec [hl]
    ld hl, $CFCA
    dec [hl]
    xor a, a
    ld [$CFCB], a
    ret

Func_031_6A2D::
    ld a, [$D868]
    ld c, $56
    call Func_000_1F49
    inc [hl]
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [$D095]
    call Func_031_6A8B
    ld a, l
    add a, $03
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [$D096]
    call Func_031_6A8B
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [$D097]
    call Func_031_6A8B
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [$D098]
    call Func_031_6A8B
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [$D099]
    call Func_031_6A8B
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [$D09A]
    call Func_031_6A8B
    ret

Func_031_6A8B::
    add a, [hl]
    ld [hl+], a
    ld a, $00
    adc a, [hl]
    ld [hl], a
    ret

Func_031_6A92::
    ld a, [$D868]
    ld c, $56
    call Func_000_1F49
    ld a, [hl+]
    cp a, [hl]
    ret c
    ld a, $0A
    ld [$C529], a
    ld a, $05
    ld [$C528], a
    ld hl, Func_031_4001
    ld b, $2F
    rst $10
    ret

Func_031_6AAE::
    ld a, [$D868]
    ld c, $34
    call Func_000_1F49
    ld de, $D09D
    ld b, $08

Jump_031_6ABB::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_031_6ABB
    ret

Jump_031_6AC2::
    call Func_031_6AFE
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld hl, $A000
    ld b, $1E
    ld c, $00

Jump_031_6AD5::
    ld a, [hl]
    cp a, $01
    jr nz, Jump_031_6AE9
    push hl
    ld a, l
    add a, $6E
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl]
    and a, a
    pop hl
    call z, Func_031_6B2E

Jump_031_6AE9::
    ld a, l
    add a, $A5
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc c
    dec b
    jr nz, Jump_031_6AD5
    xor a, a
    ld [$0100], a
    ld hl, $CFCA
    inc [hl]
    ret

Func_031_6AFE::
    ld a, [$DA6B]
    ld l, a
    ld a, [$DA6C]
    ld h, a
    ld a, [$DA6D]
    ld e, a
    ld a, [$C7C7]
    or a, a
    jr z, Jump_031_6B18
    cp a, $01
    jr z, Jump_031_6B1C
    ld a, $0A
    jr Jump_031_6B1E

Jump_031_6B18::
    ld a, $14
    jr Jump_031_6B1E

Jump_031_6B1C::
    ld a, $0F

Jump_031_6B1E::
    call Func_000_16E2
    ld a, l
    ld [$DA6B], a
    ld a, h
    ld [$DA6C], a
    ld a, e
    ld [$DA6D], a
    ret

Func_031_6B2E::
    push bc
    push hl
    ld a, l
    add a, $58
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    ld b, a
    ld d, [hl]
    ld a, [$DA6B]
    add a, c
    ld c, a
    ld a, [$DA6C]
    adc a, b
    ld b, a
    ld a, [$DA6D]
    adc a, d
    ld d, a
    ld a, $7F
    sub a, c
    ld a, $96
    sbc a, b
    ld a, $98
    sbc a, d
    jr nc, Jump_031_6B5D
    ld c, $7F
    ld b, $96
    ld d, $98

Jump_031_6B5D::
    ld a, d
    ld [hl-], a
    ld a, b
    ld [hl-], a
    ld [hl], c
    pop hl
    pop bc
    ret

Jump_031_6B65::
    ld hl, $A000
    ld b, $1E
    ld c, $00

Jump_031_6B6C::
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld a, [hl]
    cp a, $01
    jr nz, Jump_031_6B86
    push hl
    push bc
    ld a, c
    call Func_031_6D28
    bit 0, c
    pop bc
    pop hl
    jr nz, Jump_031_6B9F

Jump_031_6B86::
    ld a, l
    add a, $A5
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc c
    dec b
    jr nz, Jump_031_6B6C
    xor a, a
    ld [$0100], a
    ld hl, $CFCA
    inc [hl]
    ld hl, $CFCA
    inc [hl]
    ret

Jump_031_6B9F::
    xor a, a
    ld [$0100], a
    ld a, c
    ld [$D869], a
    ld hl, $CFCA
    inc [hl]
    ret

Jump_031_6BAC::
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld hl, $6418
    ld b, $1A
    rst $10
    call Func_031_6BCA
    call Func_031_6C2F
    xor a, a
    ld [$0100], a
    ld hl, $CFCA
    dec [hl]
    ret

Func_031_6BCA::
    ld a, [$D869]
    ld c, $56
    call Func_000_1FD1
    inc [hl]
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [$D095]
    call Func_031_6C28
    ld a, l
    add a, $03
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [$D096]
    call Func_031_6C28
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [$D097]
    call Func_031_6C28
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [$D098]
    call Func_031_6C28
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [$D099]
    call Func_031_6C28
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [$D09A]
    call Func_031_6C28
    ret

Func_031_6C28::
    add a, [hl]
    ld [hl+], a
    ld a, $00
    adc a, [hl]
    ld [hl], a
    ret

Func_031_6C2F::
    ld a, [$D869]
    ld c, $5D
    call Func_000_1FD1
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
    push hl
    inc hl
    inc hl
    ld a, [hl+]
    ld c, a
    ld b, [hl]
    pop hl
    ld a, c
    ld [hl+], a
    ld a, b
    ld [hl+], a
    ld a, l
    add a, $F4
    ld l, a
    ld a, h
    adc a, $FF
    ld h, a
    ld [hl], $00
    ret

Jump_031_6C5E::
    ld hl, $CFC9
    inc [hl]
    xor a, a
    ld [$CFCA], a
    ret

Jump_031_6C67::
    ld a, [$CFCB]
    rst $00
    dw Jump_031_6C71
    dw Jump_031_6CA0
    dw Jump_031_6D17

Jump_031_6C71::
    ld a, [$C82C]
    cp a, $05
    jr c, Jump_031_6C93
    ld a, [$D88F]
    cp a, $01
    jr nz, Jump_031_6C93
    ld a, [$D093]
    or a, a
    jr z, Jump_031_6C93
    cp a, $AA
    jr nz, Jump_031_6C8E
    ld a, $8F
    ld [$D093], a

Jump_031_6C8E::
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_6C93::
    ld hl, $CFC9
    inc [hl]
    xor a, a
    ld [$CFCA], a
    xor a, a
    ld [$CFCB], a
    ret

Jump_031_6CA0::
    ld a, [$D093]
    ldh [$FFC6], a
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld a, [$C6FE]
    ld c, $34
    call Func_000_1FD1
    ld de, $D09D
    ld b, $08

Jump_031_6CBB::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_031_6CBB
    ld hl, $631A
    ld b, $1A
    rst $10
    ldh a, [$FFC6]
    or a, a
    jr nz, Jump_031_6CD2
    xor a, a
    ld [$0100], a
    jr Jump_031_6C93

Jump_031_6CD2::
    ld l, a
    ld h, $04
    ld de, $C140
    call Func_000_2E81
    ld a, [$C6FE]
    ld c, $01
    call Func_000_1FD1
    ld d, h
    ld e, l
    ld hl, $C130
    call Func_000_2FE1
    ld a, [$C6FE]
    ld c, $34
    call Func_000_1FD1
    ld de, $D09D
    ld b, $08

Jump_031_6CF8::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_031_6CF8
    xor a, a
    ld [$0100], a
    ld a, $05
    ld [$C528], a
    ld a, $1F
    ld [$C529], a
    ld hl, Func_031_4001
    ld b, $2F
    rst $10
    ld hl, $CFCB
    inc [hl]
    ret

Jump_031_6D17::
    ld a, [$C52B]
    or a, a
    ret nz
    jp Jump_031_6C93

Func_031_6D1F:: ; heuristic: follows a terminator; C0
    push hl
    ld c, $4E
    call Func_000_1682
    pop bc
    add hl, bc
    ret

Func_031_6D28::
    push af
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    pop af
    ld c, $56
    call Func_000_1FD1
    ld a, [hl+]
    cp a, [hl]
    jr nc, Jump_031_6D80
    ldh [$FFC7], a
    ld a, l
    add a, $B4
    ld l, a
    ld a, h
    adc a, $FF
    ld h, a
    ld a, [hl+]
    ld [$D006], a
    ld a, [hl+]
    ld [$D007], a
    ld a, l
    add a, $4B
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    push hl
    ld hl, Func_031_4001
    ld b, $35
    rst $10
    ld a, [$D00F]
    ldh [$FFC6], a
    ld hl, $7380
    ld b, $19
    rst $10
    pop hl
    ldh a, [$FFC8]
    sub a, [hl]
    ld e, a
    inc hl
    ldh a, [$FFC9]
    sbc a, [hl]
    ld d, a
    inc hl
    ldh a, [$FFCA]
    sbc a, [hl]
    jr c, Jump_031_6D7C
    or a, d
    or a, e
    jr nz, Jump_031_6D80

Jump_031_6D7C::
    ld c, $01
    jr Jump_031_6D82

Jump_031_6D80::
    ld c, $00

Jump_031_6D82::
    xor a, a
    ld [$0100], a
    ret

Func_031_6D87::
    ld de, $C130
    ld b, $0A

Jump_031_6D8C::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_031_6D8C
    ld a, $F0
    ld [de], a
    ret

Func_031_6D96::
    ld a, l
    add a, $4B
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl]
    inc a
    ld hl, $C140
    call Func_000_2EAC
    ld a, [$D095]
    ld hl, $C150
    call Func_000_2EAC
    ld a, [$D096]
    ld hl, $C154
    call Func_000_2EAC
    ld a, [$D097]
    ld hl, $C158
    call Func_000_2EAC
    ld a, [$D098]
    ld hl, $C15C
    call Func_000_2EAC
    ld a, [$D099]
    ld hl, $C160
    call Func_000_2EAC
    ld a, [$D09A]
    ld hl, $C164
    call Func_000_2EAC
    ret

Func_031_6DDD::
    ld a, h
    ld [$C528], a
    ld a, l
    ld [$C529], a
    ld hl, Func_031_4001
    ld b, $2F
    rst $10
    ret

Func_031_6DEC::
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld hl, $A000
    ld b, $00

Jump_031_6DFA::
    ld a, [hl]
    or a, a
    jr z, Jump_031_6E05
    push hl
    push bc
    call Func_031_6E18
    pop bc
    pop hl

Jump_031_6E05::
    ld a, l
    add a, $A5
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc b
    ld a, b
    cp a, $1E
    jr nz, Jump_031_6DFA
    xor a, a
    ld [$0100], a
    ret

Func_031_6E18::
    push bc
    ld a, b
    ld c, $34
    call Func_000_1FD1
    pop bc
    ld c, $08

Jump_031_6E22::
    ld a, [hl+]
    cp a, $FF
    push hl
    push bc
    call nz, Func_031_6E30
    pop bc
    pop hl
    dec c
    jr nz, Jump_031_6E22
    ret

Func_031_6E30::
    ld d, a
    push de
    ld a, b
    ld c, $3C
    call Func_000_1FD1
    pop de
    push hl
    ld c, $19

Jump_031_6E3C::
    ld a, [hl]
    cp a, d
    jr nz, Jump_031_6E42
    ld [hl], $FF

Jump_031_6E42::
    inc hl
    dec c
    jr nz, Jump_031_6E3C
    pop hl
    push hl
    ld de, $D0D9
    ld b, $19

Jump_031_6E4D::
    ld a, [hl]
    ld [de], a
    ld a, $FF
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_031_6E4D
    pop hl
    ld de, $D0D9
    ld b, $19

Jump_031_6E5C::
    ld a, [de]
    cp a, $FF
    jr z, Jump_031_6E62
    ld [hl+], a

Jump_031_6E62::
    inc de
    dec b
    jr nz, Jump_031_6E5C
    ret

Func_031_6E67::
    ld a, [$CFCC]
    rst $00
    dw Jump_031_6E79
    dw Jump_031_6EF7
    dw Jump_031_6F57
    dw Jump_031_6FB1
    dw Jump_031_6FE9
    dw Jump_031_700F
    dw Jump_031_705A

Jump_031_6E79::
    call Func_031_7064
    cp a, $09
    jr nc, Jump_031_6ECA
    ld hl, $CFCA
    inc [hl]
    xor a, a
    ld [$CFCB], a
    ld hl, Func_031_71F5
    ld b, $31
    rst $10
    ld hl, Func_031_72AC
    ld b, $31
    rst $10
    ld hl, Func_031_7389
    ld b, $31
    rst $10
    call Func_000_290E
    ld hl, $7276
    ld b, $1A
    rst $10
    ld hl, $9800
    ld bc, $1412
    ld de, $C198

Jump_031_6EAC::
    push bc

Jump_031_6EAD::
    ld a, [de]
    inc de
    call Func_000_121F
    dec b
    jr nz, Jump_031_6EAD
    ld a, l
    add a, $0C
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, e
    add a, $0C
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop bc
    dec c
    jr nz, Jump_031_6EAC
    ret

Jump_031_6ECA::
    ld b, a
    dec a
    and a, $03
    ld [$CFD6], a
    ld a, $04
    call Func_000_16BF
    cp a, $00
    jr nz, Jump_031_6EDB
    dec b

Jump_031_6EDB::
    ld a, b
    ld [$CFD7], a
    xor a, a
    ld [$CFD5], a
    ld a, $03
    ld [$CFD3], a
    ld hl, $0506
    call Func_031_6DDD
    ld hl, $CFCC
    inc [hl]
    xor a, a
    ld [$C46B], a
    ret

Jump_031_6EF7::
    ld a, [$C52B]
    or a, a
    ret nz
    call Func_031_722A
    call Func_031_7536
    call Func_031_7096
    ld hl, Func_031_72C9
    ld b, $1A
    rst $10
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld a, [$D868]
    ld c, $5F
    call Func_000_1F49
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    call Func_000_16F5
    ld de, $C3A2
    call Func_000_2123
    xor a, a
    ld [$0100], a
    ld a, [$CFD7]
    add a, $E1
    ld [$C2A9], a
    call Func_031_7105
    ld de, $C1A0
    ld hl, $9808
    ld bc, $0C09
    call Func_031_753F
    ld de, $C2B8
    ld hl, $9920
    ld bc, $1409
    call Func_031_753F
    call Func_031_71B6
    ld hl, $CFCC
    inc [hl]
    ret

Jump_031_6F57::
    ld de, $63BD
    ld hl, $C46B
    call Func_031_5F9E
    ld a, [$C562]
    and a, $01
    jr z, Jump_031_6F91
    ld a, $69
    call Func_000_1278
    ld a, [$CFD5]
    and a, $0F
    add a, a
    add a, a
    ld b, a
    ld a, [$C46B]
    and a, $0F
    add a, b
    ld hl, $D09D
    add a, l
    ld l, a
    jr nc, Jump_031_6F82
    inc h

Jump_031_6F82::
    ld a, [hl]
    ld l, a
    ld h, $04
    ld de, $C150
    call Func_000_2E81
    ld hl, $CFCC
    inc [hl]
    ret

Jump_031_6F91::
    ld a, [$C563]
    and a, $C0
    jr z, Jump_031_6F9C
    call Func_031_719E
    ret

Jump_031_6F9C::
    ld a, [$C563]
    and a, $30
    ret z
    ld hl, $CFD5
    res 7, [hl]
    call Func_031_7096
    call Func_031_719E
    call Func_031_71B6
    ret

Jump_031_6FB1::
    ld a, [$C46B]
    and a, $0F
    ld hl, $63BD
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_6FBF
    inc h

Jump_031_6FBF::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $98
    ld h, a
    ld [hl], $BC
    ld hl, $7276
    ld b, $1A
    rst $10
    ld hl, $99A0
    ld de, $C338
    ld bc, $1405
    call Func_031_753F
    ld hl, $0508
    call Func_031_6DDD
    ld hl, $CFCC
    inc [hl]
    ret

Jump_031_6FE9::
    ld a, [$C52B]
    or a, a
    ret nz
    ld hl, Jump_031_72DB
    ld b, $1A
    rst $10
    ld a, $BB
    ld [$C307], a
    ld hl, $990E
    ld de, $C2A6
    ld bc, $0605
    call Func_031_753F
    ld a, $01
    ld [$C46C], a
    ld hl, $CFCC
    inc [hl]
    ret

Jump_031_700F::
    ld de, Data_031_63C5
    ld hl, $C46C
    call Func_031_5F02
    ld a, [$C562]
    and a, $01
    jr z, Jump_031_704E
    ld a, $69
    call Func_000_1278
    ld a, [$C46C]
    bit 0, a
    jr nz, Jump_031_7054
    ld a, [$CFD5]
    and a, $0F
    add a, a
    add a, a
    ld b, a
    ld a, [$C46B]
    and a, $0F
    add a, b
    ld hl, $D09D
    add a, l
    ld l, a
    jr nc, Jump_031_7041
    inc h

Jump_031_7041::
    ld [hl], $FF
    ld hl, $0509
    call Func_031_6DDD
    ld hl, $CFCC
    inc [hl]
    ret

Jump_031_704E::
    ld a, [$C562]
    and a, $02
    ret z

Jump_031_7054::
    ld a, $01
    ld [$CFCC], a
    ret

Jump_031_705A::
    ld a, [$C52B]
    or a, a
    ret nz
    xor a, a
    ld [$CFCC], a
    ret

Func_031_7064::
    ld hl, $D0D9
    ld bc, $0038
    ld a, $FF
    call Func_000_0949
    ld hl, $D09D
    ld de, $D0D9
    ld b, $38
    ld c, $00

Jump_031_7079::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_031_7081
    ld [de], a
    inc de
    inc c

Jump_031_7081::
    dec b
    jr nz, Jump_031_7079
    ld a, c
    push af
    ld hl, $D09D
    ld de, $D0D9
    ld b, $38

Jump_031_708E::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_031_708E
    pop af
    ret

Func_031_7096::
    ld hl, $0901
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld a, [$CFD5]
    and a, $0F
    add a, a
    add a, a
    ld hl, $D09D
    add a, l
    ld l, a
    jr nc, Jump_031_70B0
    inc h

Jump_031_70B0::
    ld bc, $0400

Jump_031_70B3::
    push bc
    push hl
    ld a, c
    ld hl, Data_031_70FD
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_70BF
    inc h

Jump_031_70BF::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    pop hl
    ld a, [hl+]
    push hl
    cp a, $FF
    jr nz, Jump_031_70D2
    xor a, a

Jump_031_70D2::
    ld [$C529], a
    ld a, $04
    ld [$C528], a
    ld hl, $402B
    ld b, $08
    rst $10
    pop hl
    pop bc
    inc c
    dec b
    jr nz, Jump_031_70B3
    ld hl, $1202
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld hl, $8800
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ret

Data_031_70FD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C0, $95, $50, $96, $E0, $96, $70, $97

Func_031_7105::
    ld hl, $9260
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $1203
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld a, [$CFD5]
    and a, $0F
    add a, a
    add a, a
    ld b, a
    ld a, [$C46B]
    and a, $0F
    add a, b
    ld hl, $D09D
    add a, l
    ld l, a
    jr nc, Jump_031_7131
    inc h

Jump_031_7131::
    ld a, [hl]
    push af
    ld [$C529], a
    ld a, $09
    ld [$C528], a
    ld hl, $402B
    ld b, $08
    rst $10
    pop af
    ld [$CFEC], a
    xor a, a
    ld [$CFED], a
    ld hl, Func_031_4001
    ld b, $1A
    rst $10
    ld a, [$CFEC]
    cp a, $3D
    jr z, Jump_031_715E
    cp a, $20
    jr z, Jump_031_715E
    cp a, $7B
    jr nz, Jump_031_7178

Jump_031_715E::
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld a, [$D868]
    ld c, $5F
    call Func_000_1F49
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    xor a, a
    ld [$0100], a
    jr Jump_031_717E

Jump_031_7178::
    ld a, [$CFEE]
    ld l, a
    ld h, $00

Jump_031_717E::
    call Func_000_16F5
    ld de, $C39E
    call Func_000_2123
    ld hl, $1202
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld hl, $8800
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ret

Func_031_719E::
    call Func_031_7105
    ld hl, $9A06
    ld de, $C39E
    ld a, [de]
    call Func_000_121F
    inc de
    ld a, [de]
    call Func_000_121F
    inc de
    ld a, [de]
    call Func_000_1211
    ret

Func_031_71B6::
    ld a, [$CFD5]
    and a, $0F
    add a, $E1
    ld hl, $990F
    call Func_000_1211
    ret

Func_031_71C4::
    ld a, [$DC00]
    ld hl, $DC01
    and a, [hl]
    ld hl, $DC20
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, $DC40
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, $DC60
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, $DC80
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, $DCA0
    and a, [hl]
    inc hl
    and a, [hl]
    cp a, $FF
    ret nz
    ld a, [$D2CE]
    dec a
    ld [$D2CE], a
    ret nz
    ret

Func_031_71F5::
    ld a, [$C525]
    or a, a
    jr z, Jump_031_721B
    ld a, $01
    ldh [$FF4F], a
    ld hl, $9800
    ld bc, $1412

Jump_031_7205::
    push bc
    push hl

Jump_031_7207::
    xor a, a
    call Func_000_121F
    dec b
    jr nz, Jump_031_7207
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_031_7205
    ld a, $00
    ldh [$FF4F], a

Jump_031_721B::
    ld hl, $C198
    ld bc, $0240

Jump_031_7221::
    ld a, $C3
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_031_7221
    ret

Func_031_722A::
    ld hl, $C278
    ld bc, $0160

Jump_031_7230::
    ld a, $C3
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_031_7230
    ret

Func_031_7239::
    ld a, $90
    ld [$C8CF], a
    ld [$C8D0], a
    ld [$C8D1], a
    ld [$C8D2], a
    ld [$C8D3], a
    ld a, $F0
    ld [$C8D4], a
    ld de, $8D00
    call Func_000_21A1
    ld de, $8D50
    call Func_000_21A1
    ld de, $8DA0
    call Func_000_21A1
    ld a, [$D88F]
    ld b, a
    ld c, $00
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_031_7270
    ld c, $03

Jump_031_7270::
    push bc
    ld a, c
    ld bc, $004E
    call Func_000_16AA
    ld a, l
    add a, $D5
    ld l, a
    ld a, h
    adc a, $D0
    ld h, a
    ld de, $C8CF
    ld b, $0A

Jump_031_7285::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_031_7285
    pop bc
    push bc
    ld b, $00
    ld hl, $72A0
    add hl, bc
    add hl, bc
    ld e, [hl]
    inc hl
    ld d, [hl]
    call Func_000_21A1
    pop bc
    inc c
    dec b
    jr nz, Jump_031_7270
    ret

Data_031_72A0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $8D, $50, $8D, $A0, $8D, $00

Data_031_72A7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $8D, $50, $8D, $A0, $8D

Func_031_72AC::
    ld a, [$D88F]
    dec a
    ld hl, Data_031_72C3
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_72B9
    inc h

Jump_031_72B9::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    call Func_031_755B
    call Func_031_756A
    ret

Data_031_72C3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $7C, $75, $B8, $75, $1E, $76

Func_031_72C9::
    call Func_031_722A

Func_031_72CC::
    ld d, $14
    ld a, [$D890]
    dec a
    ld hl, Data_031_7317
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_72DB
    inc h

Jump_031_72DB::
    call Func_031_72FF
    ld a, [$D890]
    cp a, $01
    jr z, Jump_031_7316
    dec a
    dec a
    ld hl, Data_031_731D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_72F0
    inc h

Jump_031_72F0::
    call Func_031_72FF
    ld a, [$D890]
    cp a, $03
    jr nz, Jump_031_7316
    ld hl, $C285
    jr Jump_031_7302

Func_031_72FF::
    ld a, [hl+]
    ld h, [hl]
    ld l, a

Jump_031_7302::
    ld bc, $0606

Jump_031_7305::
    push bc
    push hl

Jump_031_7307::
    ld a, d
    inc d
    ld [hl+], a
    dec b
    jr nz, Jump_031_7307
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_031_7305

Jump_031_7316::
    ret

Data_031_7317:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $7F, $C2, $7C, $C2, $79, $C2

Data_031_731D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $82, $C2, $7F, $C2

Func_031_7321::
    ld a, [$C525]
    or a, a
    ret z
    ld a, [$C57F]
    bit 1, a
    ld de, $D960
    jr z, Jump_031_7333
    ld de, $D958

Jump_031_7333::
    ld a, [$D890]
    cp a, $01
    jr z, Jump_031_7340
    cp a, $02
    jr z, Jump_031_7349
    jr Jump_031_735C

Jump_031_7340::
    ld c, $01
    ld hl, $98E7
    call Func_031_7379
    ret

Jump_031_7349::
    ld c, $01
    ld hl, $98E4
    call Func_031_7379
    ld c, $03
    inc de
    inc de
    ld hl, $98EA
    call Func_031_7379
    ret

Jump_031_735C::
    ld c, $01
    ld hl, $98E1
    call Func_031_7379
    ld c, $03
    inc de
    inc de
    ld hl, $98E7
    call Func_031_7379
    ld c, $05
    inc de
    inc de
    ld hl, $98ED
    call Func_031_7379
    ret

Func_031_7379::
    push de
    ld a, c
    ldh [$FFC6], a
    ld a, [de]
    push af
    inc de
    ld a, [de]
    ld d, a
    pop af
    ld e, a
    call Func_000_2090
    pop de
    ret

Func_031_7389::
    call Func_031_739F
    ld a, [$D88F]
    cp a, $01
    ret z
    call Func_031_73BE
    ld a, [$D88F]
    cp a, $02
    ret z
    call Func_031_73DD
    ret

Func_031_739F::
    ld c, $00
    ld a, [$C58A]
    or a, a
    jr z, Jump_031_73B4
    cp a, $02
    jr z, Jump_031_73B4
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_031_73B4
    ld c, $04

Jump_031_73B4::
    call Func_031_7806
    call Func_031_785F
    call Func_031_76AE
    ret

Func_031_73BE::
    ld c, $01
    ld a, [$C58A]
    or a, a
    jr z, Jump_031_73D3
    cp a, $02
    jr z, Jump_031_73D3
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_031_73D3
    ld c, $05

Jump_031_73D3::
    call Func_031_7806
    call Func_031_785F
    call Func_031_76AE
    ret

Func_031_73DD::
    ld c, $02
    ld a, [$C58A]
    or a, a
    jr z, Jump_031_73F2
    cp a, $02
    jr z, Jump_031_73F2
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_031_73F2
    ld c, $06

Jump_031_73F2::
    call Func_031_7806
    call Func_031_785F
    call Func_031_76AE
    ret

Func_031_73FC:: ; heuristic: follows a terminator; C0
    call Func_031_7412
    ld a, [$D88F]
    cp a, $01
    ret z
    call Func_031_7431
    ld a, [$D88F]
    cp a, $02
    ret z
    call Func_031_7450
    ret

Func_031_7412::
    ld c, $00
    ld a, [$C58A]
    or a, a
    jr z, Jump_031_7427
    cp a, $02
    jr z, Jump_031_7427
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_031_7427
    ld c, $04

Jump_031_7427::
    call Func_031_7914
    call Func_031_7965
    call Func_031_77B9
    ret

Func_031_7431::
    ld c, $01
    ld a, [$C58A]
    or a, a
    jr z, Jump_031_7446
    cp a, $02
    jr z, Jump_031_7446
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_031_7446
    ld c, $05

Jump_031_7446::
    call Func_031_7914
    call Func_031_7965
    call Func_031_77B9
    ret

Func_031_7450::
    ld c, $02
    ld a, [$C58A]
    or a, a
    jr z, Jump_031_7465
    cp a, $02
    jr z, Jump_031_7465
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_031_7465
    ld c, $06

Jump_031_7465::
    call Func_031_7914
    call Func_031_7965
    call Func_031_77B9
    ret

Func_031_746F::
    call Func_000_290E
    ld hl, $7276
    ld b, $1A
    rst $10
    ret

Func_031_7479::
    ld de, $C338
    ld hl, $99A0
    ld bc, $1405
    call Func_031_753F
    ret

Func_031_7486::
    ld hl, $727D
    ld b, $1A
    rst $10

Func_031_748C::
    ld de, $C338
    ld hl, $99A0
    ld bc, $0E05
    call Func_031_753F
    ret

Func_031_7499::
    ld hl, $7284
    ld b, $1A
    rst $10
    ret

Func_031_74A0::
    ld de, $C278
    ld hl, $98E0
    ld bc, $0C0B
    call Func_031_753F
    ret

Func_031_74AD::
    ld hl, $7292
    ld b, $1A
    rst $10
    ret

Func_031_74B4::
    ld de, $C2B8
    ld hl, $9920
    ld bc, $0809
    call Func_031_753F
    ret

Func_031_74C1::
    ld hl, Data_031_72A0
    ld b, $1A
    rst $10
    ret

Func_031_74C8::
    ld de, $C2B8
    ld hl, $9920
    ld bc, $1409
    call Func_031_753F
    ld a, $01
    ld [$D868], a
    ret

Func_031_74DA::
    ld hl, Data_031_72A7
    ld b, $1A
    rst $10
    ret

Func_031_74E1::
    ld de, $C2B8
    ld hl, $9920
    ld bc, $0809
    call Func_031_753F
    ret

Func_031_74EE::
    ld hl, $72AE
    ld b, $1A
    rst $10
    ret

Func_031_74F5::
    ld de, $C2F8
    ld hl, $9960
    ld bc, $0807
    call Func_031_753F
    ret

Func_031_7502::
    ld hl, $72B5
    ld b, $1A
    rst $10
    ret

Func_031_7509::
    ld de, $C2A4
    ld hl, $990C
    ld bc, $0701
    call Func_031_753F
    ld de, $C2B8
    ld hl, $9920
    ld bc, $1409
    call Func_031_753F
    ret

Func_031_7522::
    ld hl, $72C2
    ld b, $1A
    rst $10
    ret

Func_031_7529::
    ld de, $C2F8
    ld hl, $9960
    ld bc, $0E07
    call Func_031_753F
    ret

Func_031_7536::
    ld de, $C278
    ld hl, $98E0
    ld bc, $140B

Func_031_753F::
    push bc
    push hl

Jump_031_7541::
    ld a, [de]
    inc de
    call Func_000_121F
    dec b
    jr nz, Jump_031_7541
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    ld a, $20
    sub a, b
    add a, e
    ld e, a
    jr nc, Jump_031_7557
    inc d

Jump_031_7557::
    dec c
    jr nz, Func_031_753F
    ret

Func_031_755B::
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
    ret

Func_031_756A::
    push bc
    push hl

Jump_031_756C::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_031_756C
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, Func_031_756A
    ret
    INCBIN "dwm2-cobi-us.gbc", $0C757C, $A7
    ds $12, $B1
    db $B2, $B6, $D0, $D1, $D2, $D3, $D4, $C3, $D5, $D6, $D7, $D8, $D9, $C3, $DA, $DB
    db $DC, $DD, $DE, $C3, $B7, $B8
    ds $12, $B9
    db $BA, $B6, $EB, $C3, $C3, $C3, $C3, $C3, $EB, $C3, $C3, $C3, $C3, $C3, $EB, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6, $EC, $C3, $C3, $C3, $C3, $C3, $EC, $C3, $C3, $C3
    db $C3, $C3, $EC, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $EA, $AF, $C3, $C3, $C3, $C3
    db $EA, $AF, $C3, $C3, $C3, $C3, $EA, $AF, $C3, $C3, $C3, $C3, $B7, $B3
    ds $12, $B4
    db $B5

Func_031_76AE::
    ld a, [$C58A]
    cp a, $02
    jr nz, Jump_031_76BC
    ld hl, $6A45
    ld b, $A0
    rst $10
    ret

Jump_031_76BC::
    push bc
    ld a, [$C58A]
    or a, a
    jr z, Jump_031_76D1
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_031_76D1
    ld a, c
    cp a, $04
    jr c, Jump_031_773A
    jr Jump_031_76D6

Jump_031_76D1::
    ld a, c
    cp a, $04
    jr nc, Jump_031_773A

Jump_031_76D6::
    and a, $03
    cp a, $03
    jr z, Jump_031_773A
    ld a, c
    call Func_000_3E54
    jr c, Jump_031_7726
    ld a, c
    ld hl, $D80C
    call Func_000_3F25
    ld a, [hl]
    or a, a
    jr z, Jump_031_7710
    call Func_031_773C
    bit 0, [hl]
    call nz, Func_031_7757
    bit 1, [hl]
    call nz, Func_031_7762
    bit 4, [hl]
    call nz, Func_031_7778
    bit 5, [hl]
    call nz, Func_031_774C
    bit 6, [hl]
    call nz, Func_031_7783
    bit 7, [hl]
    call nz, Func_031_776D
    jr Jump_031_773A

Jump_031_7710::
    call Func_031_78B8
    ld a, c
    and a, $03
    ld hl, Data_031_77B3
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_771F
    inc h

Jump_031_771F::
    call Func_031_7797
    ld [hl], $C3
    jr Jump_031_773A

Jump_031_7726::
    call Func_031_78B8
    ld a, c
    and a, $03
    ld hl, Data_031_77B3
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_7735
    inc h

Jump_031_7735::
    call Func_031_7797
    ld [hl], $C2

Jump_031_773A::
    pop bc
    ret

Func_031_773C::
    push hl
    ld hl, Data_031_779B
    call Func_031_778E
    ld a, $C3
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    pop hl
    ret

Func_031_774C::
    push hl
    ld hl, Data_031_779B
    call Func_031_778E
    ld [hl], $C0
    pop hl
    ret

Func_031_7757::
    push hl
    ld hl, Data_031_77A7
    call Func_031_778E
    ld [hl], $C1
    pop hl
    ret

Func_031_7762::
    push hl
    ld hl, Data_031_77A7
    call Func_031_778E
    ld [hl], $C7
    pop hl
    ret

Func_031_776D::
    push hl
    ld hl, Data_031_77AD
    call Func_031_778E
    ld [hl], $C8
    pop hl
    ret

Func_031_7778::
    push hl
    ld hl, Data_031_77A1
    call Func_031_778E
    ld [hl], $C9
    pop hl
    ret

Func_031_7783::
    push hl
    ld hl, Data_031_77B3
    call Func_031_778E
    ld [hl], $CA
    pop hl
    ret

Func_031_778E::
    ld a, c
    and a, $03
    add a, a
    add a, l
    ld l, a
    jr nc, Func_031_7797
    inc h

Func_031_7797::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ret

Data_031_779B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $39, $C2, $3F, $C2, $45, $C2

Data_031_77A1:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $3A, $C2, $40, $C2, $46, $C2

Data_031_77A7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $3B, $C2, $41, $C2, $47, $C2

Data_031_77AD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $3C, $C2, $42, $C2, $48, $C2

Data_031_77B3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $3D, $C2, $43, $C2, $49, $C2

Func_031_77B9::
    ld a, [$C58A]
    or a, a
    jr z, Jump_031_77D8
    cp a, $02
    jr nz, Jump_031_77CA
    ld hl, Jump_031_6B1E
    ld b, $A0
    rst $10
    ret

Jump_031_77CA::
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_031_77D8
    ld a, c
    cp a, $04
    jr c, Jump_031_7805
    jr Jump_031_77DD

Jump_031_77D8::
    ld a, c
    cp a, $04
    jr nc, Jump_031_7805

Jump_031_77DD::
    and a, $03
    cp a, $03
    jr z, Jump_031_7805
    ld hl, Data_031_7ADA
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_77EC
    inc h

Jump_031_77EC::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    push hl
    ld de, $C198
    add hl, de
    pop de
    push hl
    ld hl, $9800
    add hl, de
    pop de
    ld b, $05

Jump_031_77FD::
    ld a, [de]
    inc de
    call Func_000_121F
    dec b
    jr nz, Jump_031_77FD

Jump_031_7805::
    ret

Func_031_7806::
    ld a, [$C58A]
    cp a, $02
    jr nz, Jump_031_7814
    ld hl, $6B46
    ld b, $A0
    rst $10
    ret

Jump_031_7814::
    push bc
    or a, a
    jr z, Jump_031_7826
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_031_7826
    ld a, c
    cp a, $04
    jr c, Jump_031_785D
    jr Jump_031_782B

Jump_031_7826::
    ld a, c
    cp a, $04
    jr nc, Jump_031_785D

Jump_031_782B::
    and a, $03
    cp a, $03
    jr z, Jump_031_785D
    ld a, c
    ld hl, $D8BF
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_783B
    inc h

Jump_031_783B::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    push bc
    call Func_000_16F5
    pop bc
    ld a, c
    and a, $03
    push hl
    ld hl, Data_031_7AC8
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_7850
    inc h

Jump_031_7850::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, $C198
    add hl, de
    ld d, h
    ld e, l
    pop hl
    call Func_000_2123

Jump_031_785D::
    pop bc
    ret

Func_031_785F::
    ld a, [$C58A]
    cp a, $02
    jr nz, Jump_031_786D
    ld hl, $6B79
    ld b, $A0
    rst $10
    ret

Jump_031_786D::
    push bc
    or a, a
    jr z, Jump_031_787F
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_031_787F
    ld a, c
    cp a, $04
    jr c, Jump_031_78B6
    jr Jump_031_7884

Jump_031_787F::
    ld a, c
    cp a, $04
    jr nc, Jump_031_78B6

Jump_031_7884::
    and a, $03
    cp a, $03
    jr z, Jump_031_78B6
    ld a, c
    ld hl, $D8DF
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_7894
    inc h

Jump_031_7894::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    push bc
    call Func_000_16F5
    pop bc
    ld a, c
    and a, $03
    push hl
    ld hl, Data_031_7ACE
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_78A9
    inc h

Jump_031_78A9::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, $C198
    add hl, de
    ld d, h
    ld e, l
    pop hl
    call Func_000_2123

Jump_031_78B6::
    pop bc
    ret

Func_031_78B8::
    ld a, [$C58A]
    cp a, $02
    jr nz, Jump_031_78C6
    ld hl, $6BB3
    ld b, $A0
    rst $10
    ret

Jump_031_78C6::
    push bc
    or a, a
    jr z, Jump_031_78D8
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_031_78D8
    ld a, c
    cp a, $04
    jr c, Jump_031_7912
    jr Jump_031_78DD

Jump_031_78D8::
    ld a, c
    cp a, $04
    jr nc, Jump_031_7912

Jump_031_78DD::
    and a, $03
    cp a, $03
    jr z, Jump_031_7912
    ld a, c
    and a, $03
    ld hl, Data_031_7AD4
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_78EF
    inc h

Jump_031_78EF::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, $C198
    add hl, de
    ld [hl], $EA
    inc hl
    ld [hl], $AF
    inc hl
    push hl
    ld a, c
    ld hl, $D8B7
    add a, l
    ld l, a
    jr nc, Jump_031_7906
    inc h

Jump_031_7906::
    ld l, [hl]
    ld h, $00
    push bc
    call Func_000_16F5
    pop bc
    pop de
    call Func_000_210D

Jump_031_7912::
    pop bc
    ret

Func_031_7914::
    ld a, [$C58A]
    or a, a
    jr z, Jump_031_7933
    cp a, $02
    jr nz, Jump_031_7925
    ld hl, $6BF0
    ld b, $A0
    rst $10
    ret

Jump_031_7925::
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_031_7933
    ld a, c
    cp a, $04
    jr c, Jump_031_7964
    jr Jump_031_7938

Jump_031_7933::
    ld a, c
    cp a, $04
    jr nc, Jump_031_7964

Jump_031_7938::
    and a, $03
    cp a, $03
    jr z, Jump_031_7964
    ld hl, Data_031_7AC8
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_7947
    inc h

Jump_031_7947::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    push hl
    ld de, $C198
    add hl, de
    pop de
    push hl
    ld hl, $9800
    add hl, de
    pop de
    ld a, [de]
    inc de
    call Func_000_121F
    ld a, [de]
    inc de
    call Func_000_121F
    ld a, [de]
    call Func_000_1211

Jump_031_7964::
    ret

Func_031_7965::
    ld a, [$C58A]
    or a, a
    jr z, Jump_031_7984
    cp a, $02
    jr nz, Jump_031_7976
    ld hl, $6C22
    ld b, $A0
    rst $10
    ret

Jump_031_7976::
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_031_7984
    ld a, c
    cp a, $04
    jr c, Jump_031_79B5
    jr Jump_031_7989

Jump_031_7984::
    ld a, c
    cp a, $04
    jr nc, Jump_031_79B5

Jump_031_7989::
    and a, $03
    cp a, $03
    jr z, Jump_031_79B5
    ld hl, Data_031_7ACE
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_7998
    inc h

Jump_031_7998::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    push hl
    ld de, $C198
    add hl, de
    pop de
    push hl
    ld hl, $9800
    add hl, de
    pop de
    ld a, [de]
    inc de
    call Func_000_121F
    ld a, [de]
    inc de
    call Func_000_121F
    ld a, [de]
    call Func_000_1211

Jump_031_79B5::
    ret

Func_031_79B6:: ; heuristic: follows a terminator; C0
    ld a, [$C58A]
    or a, a
    jr z, Jump_031_79D5
    cp a, $02
    jr nz, Jump_031_79C7
    ld hl, $6C54
    ld b, $A0
    rst $10
    ret

Jump_031_79C7::
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_031_79D5
    ld a, c
    cp a, $04
    jr c, Jump_031_7A01
    jr Jump_031_79DA

Jump_031_79D5::
    ld a, c
    cp a, $04
    jr nc, Jump_031_7A01

Jump_031_79DA::
    and a, $03
    cp a, $03
    jr z, Jump_031_7A01
    ld hl, Data_031_7AD4
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_031_79E9
    inc h

Jump_031_79E9::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    push hl
    ld de, $C198
    add hl, de
    pop de
    push hl
    ld hl, $9800
    add hl, de
    pop de
    ld a, [de]
    inc de
    call Func_000_121F
    ld a, [de]
    call Func_000_1211

Jump_031_7A01::
    ret

Func_031_7A02::
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
    ld hl, $400F
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

Func_031_7A3D::
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
    INCBIN "dwm2-cobi-us.gbc", $0C7A78, $50

Data_031_7AC8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $62, $00, $68, $00, $6E, $00

Data_031_7ACE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $82, $00, $88, $00, $8E, $00

Data_031_7AD4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A1, $00, $A7, $00, $AD, $00

Data_031_7ADA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0C7ADA, $C6

Data_031_7BA0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0C7BA0, $4E

Func_031_7BEE::
    call Func_000_3E25
    ret c
    push hl
    push bc
    ld c, a
    ld hl, $D80F
    call Func_000_3F25
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_031_7C08
    ld a, [hl]
    and a, $0C
    jr nz, Jump_031_7C08
    xor a, a
    jr Jump_031_7C09

Jump_031_7C08::
    scf

Jump_031_7C09::
    ld a, c
    pop bc
    pop hl
    ret

Func_031_7C0D:: ; heuristic: follows a terminator; C0
    push hl
    ld hl, $D80F
    call Func_000_3F25
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_031_7C1C
    ld a, [hl]
    and a, $0C

Jump_031_7C1C::
    pop hl
    ret

Data_031_7C1E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0C7C1E, $1DD

Data_031_7DFB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0C7DFB, $97
    ds $16E, $00
