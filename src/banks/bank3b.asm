SECTION "Bank 3B", ROMX[$4000], BANK[$3B]
    db $3B

Func_03B_4001::
    ld a, c
    and a, $03
    cp a, $03
    jr z, Jump_03B_4013
    ld a, c
    ld e, $1D
    call Func_000_3F32
    call Func_03B_42F0
    jr Jump_03B_403C

Jump_03B_4013::
    ld a, c
    srl a
    srl a
    and a, $01
    ld hl, $DAAE
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_03B_4023
    inc h

Jump_03B_4023::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, l
    ld [$CFE6], a
    ld a, h
    ld [$CFE7], a
    ld hl, Func_03B_4001
    ld b, $34
    rst $10
    ld a, [$CFF6]
    ld c, a
    ld a, [$CFF7]
    ld b, a

Jump_03B_403C::
    ld a, c
    ld [$DAC4], a
    ld a, b
    ld [$DAC5], a
    ret

Func_03B_4045::
    ld a, c
    and a, $03
    cp a, $03
    jr z, Jump_03B_4057
    ld a, c
    ld e, $21
    call Func_000_3F32
    call Func_03B_42F0
    jr Jump_03B_4080

Jump_03B_4057::
    ld a, c
    srl a
    srl a
    and a, $01
    ld hl, $DAAE
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_03B_4067
    inc h

Jump_03B_4067::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, l
    ld [$CFE6], a
    ld a, h
    ld [$CFE7], a
    ld hl, Func_03B_4001
    ld b, $34
    rst $10
    ld a, [$CFF8]
    ld c, a
    ld a, [$CFF9]
    ld b, a

Jump_03B_4080::
    ld a, c
    ld [$DAC4], a
    ld a, b
    ld [$DAC5], a
    ret

Func_03B_4089::
    ld a, c
    and a, $03
    cp a, $03
    jr z, Jump_03B_409B
    ld a, c
    ld e, $23
    call Func_000_3F32
    call Func_03B_42F0
    jr Jump_03B_40C4

Jump_03B_409B::
    ld a, c
    srl a
    srl a
    and a, $01
    ld hl, $DAAE
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_03B_40AB
    inc h

Jump_03B_40AB::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, l
    ld [$CFE6], a
    ld a, h
    ld [$CFE7], a
    ld hl, Func_03B_4001
    ld b, $34
    rst $10
    ld a, [$CFFA]
    ld c, a
    ld a, [$CFFB]
    ld b, a

Jump_03B_40C4::
    ld a, c
    ld [$DAC4], a
    ld a, b
    ld [$DAC5], a
    ret

Func_03B_40CD::
    ld a, c
    and a, $03
    cp a, $03
    jr z, Jump_03B_40DF
    ld a, c
    ld e, $25
    call Func_000_3F32
    call Func_03B_42F0
    jr Jump_03B_4108

Jump_03B_40DF::
    ld a, c
    srl a
    srl a
    and a, $01
    ld hl, $DAAE
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_03B_40EF
    inc h

Jump_03B_40EF::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, l
    ld [$CFE6], a
    ld a, h
    ld [$CFE7], a
    ld hl, Func_03B_4001
    ld b, $34
    rst $10
    ld a, [$CFFC]
    ld c, a
    ld a, [$CFFD]
    ld b, a

Jump_03B_4108::
    ld a, c
    ld [$DAC4], a
    ld a, b
    ld [$DAC5], a
    ret

Func_03B_4111::
    ld a, c
    and a, $03
    cp a, $03
    jr z, Jump_03B_4123
    ld a, c
    ld e, $27
    call Func_000_3F32
    call Func_03B_42F0
    jr Jump_03B_414C

Jump_03B_4123::
    ld a, c
    srl a
    srl a
    and a, $01
    ld hl, $DAAE
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_03B_4133
    inc h

Jump_03B_4133::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, l
    ld [$CFE6], a
    ld a, h
    ld [$CFE7], a
    ld hl, Func_03B_4001
    ld b, $34
    rst $10
    ld a, [$CFFE]
    ld c, a
    ld a, [$CFFF]
    ld b, a

Jump_03B_414C::
    ld a, c
    ld [$DAC4], a
    ld a, b
    ld [$DAC5], a
    ret

Func_03B_4155::
    ld a, c
    and a, $03
    cp a, $03
    jr z, Jump_03B_4167
    ld a, c
    ld e, $29
    call Func_000_3F32
    call Func_03B_42F0
    jr Jump_03B_4190

Jump_03B_4167::
    ld a, c
    srl a
    srl a
    and a, $01
    ld hl, $DAAE
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_03B_4177
    inc h

Jump_03B_4177::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, l
    ld [$CFE6], a
    ld a, h
    ld [$CFE7], a
    ld hl, Func_03B_4001
    ld b, $34
    rst $10
    ld a, [$D000]
    ld c, a
    ld a, [$D001]
    ld b, a

Jump_03B_4190::
    ld a, c
    ld [$DAC4], a
    ld a, b
    ld [$DAC5], a
    ret

Func_03B_4199::
    ld a, c
    and a, $03
    cp a, $03
    jr z, Jump_03B_41A9
    ld a, c
    ld e, $17
    call Func_000_3F32
    ld c, [hl]
    jr Jump_03B_41CE

Jump_03B_41A9::
    ld a, c
    srl a
    srl a
    and a, $01
    ld hl, $DAAE
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_03B_41B9
    inc h

Jump_03B_41B9::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, l
    ld [$CFE6], a
    ld a, h
    ld [$CFE7], a
    ld hl, Func_03B_4001
    ld b, $34
    rst $10
    ld a, [$CFF5]
    ld c, a

Jump_03B_41CE::
    ld a, c
    ld [$DAC4], a
    ret

Func_03B_41D3::
    ld a, c
    and a, $03
    cp a, $03
    jr z, Jump_03B_41E3
    ld a, c
    ld e, $2D
    call Func_000_3F32
    ld c, [hl]
    jr Jump_03B_4208

Jump_03B_41E3::
    ld a, c
    srl a
    srl a
    and a, $01
    ld hl, $DAAE
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_03B_41F3
    inc h

Jump_03B_41F3::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, l
    ld [$CFE6], a
    ld a, h
    ld [$CFE7], a
    ld hl, Func_03B_4001
    ld b, $34
    rst $10
    ld a, [$D002]
    ld c, a

Jump_03B_4208::
    ld a, c
    ld [$DAC4], a
    ret

Func_03B_420D::
    ld a, c
    and a, $03
    cp a, $03
    jr z, Jump_03B_421D
    ld a, c
    ld e, $30
    call Func_000_3F32
    ld c, [hl]
    jr Jump_03B_4242

Jump_03B_421D::
    ld a, c
    srl a
    srl a
    and a, $01
    ld hl, $DAAE
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_03B_422D
    inc h

Jump_03B_422D::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, l
    ld [$CFE6], a
    ld a, h
    ld [$CFE7], a
    ld hl, Func_03B_4001
    ld b, $34
    rst $10
    ld a, [$D004]
    ld c, a

Jump_03B_4242::
    ld a, c
    ld [$DAC4], a
    ret

Func_03B_4247::
    ld a, c
    and a, $03
    cp a, $03
    jr z, Jump_03B_4257
    ld a, c
    ld e, $2E
    call Func_000_3F32
    ld c, [hl]
    jr Jump_03B_427C

Jump_03B_4257::
    ld a, c
    srl a
    srl a
    and a, $01
    ld hl, $DAAE
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_03B_4267
    inc h

Jump_03B_4267::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, l
    ld [$CFE6], a
    ld a, h
    ld [$CFE7], a
    ld hl, Func_03B_4001
    ld b, $34
    rst $10
    ld a, [$D003]
    ld c, a

Jump_03B_427C::
    ld a, c
    ld [$DAC4], a
    ret

Func_03B_4281::
    ld a, c
    and a, $03
    cp a, $03
    jr z, Jump_03B_4291
    ld a, c
    ld e, $2F
    call Func_000_3F32
    ld c, [hl]
    jr Jump_03B_42B6

Jump_03B_4291::
    ld a, c
    srl a
    srl a
    and a, $01
    ld hl, $DAAE
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_03B_42A1
    inc h

Jump_03B_42A1::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, l
    ld [$CFE6], a
    ld a, h
    ld [$CFE7], a
    ld hl, Func_03B_4001
    ld b, $34
    rst $10
    ld a, [$D005]
    ld c, a

Jump_03B_42B6::
    ld a, c
    ld [$DAC4], a
    ret

Func_03B_42BB::
    ld a, c
    and a, $03
    cp a, $03
    jr z, Jump_03B_42E3
    ld a, c
    ld e, $0A
    call Func_000_3F32
    ld a, [hl+]
    ld [$D006], a
    ld a, [hl]
    ld [$D007], a
    ld hl, Func_03B_4001
    ld b, $35
    rst $10
    ld a, [$D00A]
    swap a
    ld c, a
    ld a, [$D00B]
    or a, c
    ld c, a
    jr Jump_03B_42E5

Jump_03B_42E3::
    ld c, $00

Jump_03B_42E5::
    ret

Func_03B_42E6:: ; heuristic: follows a terminator; C0
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_03B_42EC
    inc h

Jump_03B_42EC::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ret

Func_03B_42F0::
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ret

Func_03B_42F4::
    ld a, [$CFCB]
    rst $00
    dw Jump_03B_4314
    dw Jump_03B_437F
    dw Jump_03B_438A
    dw Jump_03B_4456
    dw Jump_03B_4473
    dw Jump_03B_447B
    dw Jump_03B_4512
    dw Jump_03B_4547
    dw Jump_03B_4548
    dw Jump_03B_459F
    dw Jump_03B_45A6
    dw Jump_03B_469E
    dw Jump_03B_46EF
    dw Jump_03B_46FD

Jump_03B_4314::
    ld hl, $CFCB
    inc [hl]
    xor a, a
    ld [$DABA], a
    xor a, a
    ld [$D808], a
    ld a, [$D892]
    cp a, $10
    jr z, Jump_03B_433E
    cp a, $20
    jr z, Jump_03B_434B
    and a, $07
    ld [$D8A5], a
    call Func_000_3E54
    jr nc, Jump_03B_435D
    ld a, [$D893]
    cp a, $0C
    jr z, Jump_03B_435D
    jr Jump_03B_4364

Jump_03B_433E::
    ld c, $00
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_03B_4356
    ld c, $04
    jr Jump_03B_4356

Jump_03B_434B::
    ld c, $04
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_03B_4356
    ld c, $00

Jump_03B_4356::
    call Func_03B_4373
    ld a, c
    ld [$D8A5], a

Jump_03B_435D::
    ld a, [$D893]
    ld [$D8A6], a
    ret

Jump_03B_4364::
    ld [$D8A6], a
    ld hl, Data_03B_6E92
    ld b, $3A
    rst $10
    ld a, $0D
    ld [$CFCB], a
    ret

Func_03B_4373::
    ld b, $03

Jump_03B_4375::
    ld a, c
    call Func_000_3E54
    ret nc
    inc c
    dec b
    jr nz, Jump_03B_4375
    ret

Jump_03B_437F::
    ld hl, $CFCB
    inc [hl]
    ld hl, Data_03B_6E92
    ld b, $3A
    rst $10
    ret

Jump_03B_438A::
    ld hl, $CFCB
    inc [hl]
    ld a, [$D8A6]
    cp a, $19
    jr c, Jump_03B_43E9
    cp a, $1E
    jr nc, Jump_03B_43E9
    call Func_03B_4F74
    jr c, Jump_03B_43E9
    ld a, [$CFC5]
    cp a, $03
    jr z, Jump_03B_43F5
    ld a, [$D8A5]
    and a, $04
    ld c, a
    ld b, $03

Jump_03B_43AD::
    ld a, c
    call Func_000_3E54
    jr c, Jump_03B_43E5
    ld a, c
    and a, $03
    ld hl, $D8A1
    add a, l
    ld l, a
    jr nc, Jump_03B_43BE
    inc h

Jump_03B_43BE::
    ld a, [hl]
    cp a, $07
    jr z, Jump_03B_43F5
    ld a, c
    ld hl, $D80C
    call Func_000_3F25
    ld a, [hl]
    bit 6, a
    jr nz, Jump_03B_4406
    and a, $8C
    jr nz, Jump_03B_4417
    ld a, $05
    add a, l
    ld l, a
    jr nc, Jump_03B_43DA
    inc h

Jump_03B_43DA::
    ld a, [hl]
    and a, $C0
    jr nz, Jump_03B_4428
    ld a, c
    call Func_000_3E25
    jr c, Jump_03B_4439

Jump_03B_43E5::
    inc c
    dec b
    jr nz, Jump_03B_43AD

Jump_03B_43E9::
    ld a, $08
    ld [$DAD2], a
    ld hl, Func_03B_4001
    ld b, $3A
    rst $10
    ret

Jump_03B_43F5::
    call Func_03B_444A
    ld d, $7E
    ld hl, Data_03B_6EE5
    ld b, $3A
    rst $10
    ld a, $0B
    ld [$CFCB], a
    ret

Jump_03B_4406::
    call Func_03B_444A
    ld d, $E6
    ld hl, Data_03B_7193
    ld b, $3A
    rst $10
    ld a, $0B
    ld [$CFCB], a
    ret

Jump_03B_4417::
    call Func_03B_444A
    ld d, $7B
    ld hl, Data_03B_6EE5
    ld b, $3A
    rst $10
    ld a, $0B
    ld [$CFCB], a
    ret

Jump_03B_4428::
    call Func_03B_444A
    ld d, $7D
    ld hl, Data_03B_6EE5
    ld b, $3A
    rst $10
    ld a, $0B
    ld [$CFCB], a
    ret

Jump_03B_4439::
    call Func_03B_444A
    ld d, $7C
    ld hl, Data_03B_6EE5
    ld b, $3A
    rst $10
    ld a, $0B
    ld [$CFCB], a
    ret

Func_03B_444A::
    ld a, [$D890]
    ldh [$FFC6], a
    ld hl, Data_03B_774C
    ld b, $3A
    rst $10
    ret

Jump_03B_4456::
    ld hl, $CFCB
    inc [hl]
    ld a, [$D8A5]
    ld hl, $D811
    call Func_000_3F25
    ld a, [hl]
    and a, $C0
    ret z
    ld d, $66
    ld hl, Data_03B_7193
    ld b, $3A
    rst $10
    call Func_03B_470B
    ret

Jump_03B_4473::
    ld hl, $CFCB
    inc [hl]
    call Func_03B_4B02
    ret

Jump_03B_447B::
    ld hl, $CFCB
    inc [hl]
    ld a, [$DAC0]
    ld b, a
    bit 5, a
    jr z, Jump_03B_449D
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    ld a, h
    or a, l
    jr z, Jump_03B_4497
    set 4, b
    jr Jump_03B_4499

Jump_03B_4497::
    res 4, b

Jump_03B_4499::
    ld a, b
    ld [$DAC0], a

Jump_03B_449D::
    ld a, [$DAC0]
    bit 4, a
    ret z
    ld a, $01
    ld [$D808], a
    ld a, $04
    ld [$DAD2], a
    ld hl, Func_03B_4001
    ld b, $3A
    rst $10
    ld a, $01
    ld [$DAD3], a
    ld hl, Data_03B_5762
    ld b, $3A
    rst $10
    ld a, [$D8A6]
    cp a, $01
    ret c
    cp a, $06
    jr c, Jump_03B_44DA
    cp a, $0B
    jr z, Jump_03B_44DA
    jr c, Jump_03B_44EF
    cp a, $0C
    jr z, Jump_03B_44EF
    cp a, $24
    ret c
    cp a, $28
    jr c, Jump_03B_44FE
    ret

Jump_03B_44DA::
    ld a, [$D8A5]
    cp a, $04
    jr c, Jump_03B_44FE
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    srl h
    rr l
    jr Jump_03B_450E

Jump_03B_44EF::
    ld hl, $0064
    ld a, [$D8A5]
    cp a, $04
    jr nc, Jump_03B_450E
    ld hl, $0005
    jr Jump_03B_450A

Jump_03B_44FE::
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    srl h
    rr l

Jump_03B_450A::
    call Func_03B_4970
    ret

Jump_03B_450E::
    call Func_03B_4953
    ret

Jump_03B_4512::
    ld hl, $CFCB
    inc [hl]
    ld hl, $CFCB
    inc [hl]
    ld a, [$DAC0]
    bit 4, a
    jr z, Jump_03B_4529
    ld a, [$DAC2]
    ld [$C0A0], a
    jr Jump_03B_452F

Jump_03B_4529::
    ld a, [$DAC3]
    ld [$C0A0], a

Jump_03B_452F::
    ld a, [$C0A0]
    ld d, a
    ld hl, Data_03B_7193
    ld b, $3A
    rst $10
    call Func_03B_453D
    ret

Func_03B_453D::
    ld a, [$DAC0]
    bit 4, a
    ret nz
    call Func_03B_470B
    ret

Jump_03B_4547::
    ret

Jump_03B_4548::
    ld hl, $CFCB
    inc [hl]
    ld hl, $CFCB
    inc [hl]
    ld a, [$DAC1]
    and a, $C0
    cp a, $00
    jr z, Jump_03B_459E
    cp a, $40
    jr z, Jump_03B_458B
    ld a, [$D8A5]
    ld hl, $D8BF
    call Func_03B_4F52
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld a, [$D872]
    ld c, a
    ld a, [$D873]
    ld b, a
    ld a, e
    sub a, c
    ld e, a
    ld a, d
    sbc a, b
    ld d, a
    jr c, Jump_03B_4580
    ld a, d
    ld [hl-], a
    ld [hl], e
    or a, e
    jr nz, Jump_03B_458B
    inc hl

Jump_03B_4580::
    xor a, a
    ld [hl-], a
    ld [hl], a
    ld hl, $CFCB
    dec [hl]
    xor a, a
    ld [$CFCD], a

Jump_03B_458B::
    ld a, [$D8A5]
    call Func_03B_4FAB
    ld a, [$D8A5]
    call Func_03B_4FB8
    ld a, [$D8A5]
    call Func_03B_4FC5
    ret

Jump_03B_459E::
    ret

Jump_03B_459F::
    ld hl, Data_03B_6764
    ld b, $32
    rst $10
    ret

Jump_03B_45A6::
    ld hl, $CFCB
    inc [hl]
    ld a, [$D893]
    cp a, $1F
    jr z, Jump_03B_45CF
    cp a, $1D
    jr z, Jump_03B_45C7
    ld a, [$D892]
    cp a, $10
    jr z, Jump_03B_4627
    cp a, $20
    ret nz
    ld a, [$D893]
    cp a, $1E
    jr nz, Jump_03B_4627
    ret

Jump_03B_45C7::
    ld a, [$D8A5]
    cp a, $04
    ret c
    jr Jump_03B_4627

Jump_03B_45CF::
    ld a, [$DABA]
    bit 7, a
    call z, Func_03B_4711
    ld a, [$D8A5]
    add a, a
    ld hl, $D958
    add a, l
    ld l, a
    jr nc, Jump_03B_45E3
    inc h

Jump_03B_45E3::
    ld a, [hl+]
    ld [$D006], a
    ld a, [hl]
    ld [$D007], a
    ld hl, Data_03B_5A7E
    ld b, $16
    rst $10
    ld a, c
    or a, a
    jr z, Jump_03B_45FF
    ld d, $2B
    ld hl, Data_03B_6EE5
    ld b, $3A
    rst $10
    jr Jump_03B_4607

Jump_03B_45FF::
    ld d, $2A
    ld hl, Data_03B_6EE5
    ld b, $3A
    rst $10

Jump_03B_4607::
    ld hl, $DABA
    dec [hl]
    ld a, [hl]
    cp a, $80
    ret z
    ld a, $04
    ld [$CFCB], a
    ld a, [hl]
    and a, $7F
    dec a
    ld hl, $D88B
    add a, l
    ld l, a
    jr nc, Jump_03B_4620
    inc h

Jump_03B_4620::
    ld a, [hl]
    and a, $7F
    ld [$D8A5], a
    ret

Jump_03B_4627::
    call Func_03B_4635
    ret z
    ld a, c
    ld [$D8A5], a
    ld a, $03
    ld [$CFCB], a
    ret

Func_03B_4635::
    ld a, [$DABA]
    bit 7, a
    jr nz, Jump_03B_4647
    call Func_03B_4650
    ld a, [$DABA]
    or a, $80
    ld [$DABA], a

Jump_03B_4647::
    call Func_03B_4673
    ld a, [$DABA]
    and a, $7F
    ret

Func_03B_4650::
    ld b, $04
    ld a, [$D8A5]
    and a, $04
    ld c, a

Jump_03B_4658::
    ld a, [$D8A5]
    cp a, c
    jr z, Jump_03B_4668
    ld a, c
    call Func_000_3E54
    jr nc, Jump_03B_4668
    jr z, Jump_03B_466C
    jr Jump_03B_466C

Jump_03B_4668::
    ld hl, $DABA
    inc [hl]

Jump_03B_466C::
    inc c
    dec b
    ld a, b
    or a, a
    jr nz, Jump_03B_4658
    ret

Func_03B_4673::
    ld a, [$D8A5]
    inc a
    ld c, a
    ld hl, $DABA
    dec [hl]
    ld a, [hl]
    and a, $7F
    ret z

Jump_03B_4680::
    ld a, [$CFF2]
    cp a, $80
    jr nz, Jump_03B_4694
    ld a, c
    and a, $03
    jr nz, Jump_03B_4694
    ld a, [$D8A5]
    and a, $04
    xor a, $04
    ld c, a

Jump_03B_4694::
    ld a, c
    call Func_000_3E54
    ret nc
    jr z, Jump_03B_469B

Jump_03B_469B::
    inc c
    jr Jump_03B_4680

Jump_03B_469E::
    ld hl, $CFCB
    inc [hl]
    ld a, [$DAC1]
    bit 0, a
    jr nz, Jump_03B_46AE
    ld a, [$D808]
    or a, a
    ret z

Jump_03B_46AE::
    ld a, [$D893]
    ld [$D081], a
    ld a, [$CFD5]
    and a, $0F
    add a, a
    add a, a
    ld b, a
    ld a, [$C471]
    and a, $03
    add a, b
    ld [$D082], a
    ld hl, $4007
    ld b, $16
    rst $10
    ld hl, Data_03B_4C1D
    ld b, $16
    rst $10
    ld a, [$D081]
    cp a, $FF
    ret nz
    ld a, [$D087]
    cp a, $64
    jr nz, Jump_03B_46E6
    ld a, [$D893]
    cp a, $1E
    jr z, Jump_03B_46E6
    ret

Jump_03B_46E6::
    ld d, $87
    ld hl, Data_03B_7193
    ld b, $3A
    rst $10
    ret

Jump_03B_46EF::
    xor a, a
    ld [$DABA], a
    ld a, $07
    ld [$CFCA], a
    xor a, a
    ld [$CFCB], a
    ret

Jump_03B_46FD::
    ld d, $CC
    ld hl, Data_03B_7193
    ld b, $3A
    rst $10
    ld a, $0C
    ld [$CFCB], a
    ret

Func_03B_470B::
    ld a, $0A
    ld [$CFCB], a
    ret

Func_03B_4711::
    ld a, $FF
    ld hl, $D88B
    ld bc, $0003
    call Func_000_0949
    ld hl, Data_03B_7AE3
    ld b, $3A
    rst $10
    ld a, d
    cp a, $03
    jr z, Jump_03B_4735
    cp a, $02
    jp z, Jump_03B_47CD
    ld a, [$D8A5]
    ld [$D88B], a
    jp Jump_03B_4813

Jump_03B_4735::
    ld a, [$D8A5]
    ld c, a
    ld a, c
    add a, a
    ld hl, $C0A0
    add a, l
    ld l, a
    jr nc, Jump_03B_4743
    inc h

Jump_03B_4743::
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    inc c
    ld a, c
    add a, a
    ld hl, $C0A0
    add a, l
    ld l, a
    jr nc, Jump_03B_4751
    inc h

Jump_03B_4751::
    ld a, [hl+]
    cp a, e
    jr nz, Jump_03B_4785
    ld a, [hl]
    cp a, d
    jr nz, Jump_03B_4785
    inc c
    ld a, c
    add a, a
    ld hl, $C0A0
    add a, l
    ld l, a
    jr nc, Jump_03B_4764
    inc h

Jump_03B_4764::
    ld a, [hl+]
    cp a, e
    jr nz, Jump_03B_4775
    ld a, [hl]
    cp a, d
    jr nz, Jump_03B_4775
    ld a, c
    or a, $80
    ld [$D88B], a
    jp Jump_03B_4813

Jump_03B_4775::
    ld a, [$D8A5]
    or a, $80
    ld [$D88C], a
    ld a, c
    ld d, a
    ld [$D88B], a
    jp Jump_03B_481F

Jump_03B_4785::
    inc c
    ld a, c
    add a, a
    ld hl, $C0A0
    add a, l
    ld l, a
    jr nc, Jump_03B_4790
    inc h

Jump_03B_4790::
    ld a, [hl+]
    cp a, e
    jr nz, Jump_03B_47A8
    ld a, [hl]
    cp a, d
    jr nz, Jump_03B_47A8
    ld a, [$D8A5]
    or a, $80
    ld [$D88C], a
    dec c
    ld a, c
    ld d, a
    ld [$D88B], a
    jr Jump_03B_481F

Jump_03B_47A8::
    ld d, [hl]
    dec hl
    ld e, [hl]
    dec c
    ld a, c
    add a, a
    ld hl, $C0A0
    add a, l
    ld l, a
    jr nc, Jump_03B_47B6
    inc h

Jump_03B_47B6::
    ld a, [hl+]
    cp a, e
    jr nz, Jump_03B_4823
    ld a, [hl]
    cp a, d
    jr nz, Jump_03B_4823
    ld a, [$D8A5]
    ld [$D88C], a
    ld a, c
    ld d, a
    or a, $80
    ld [$D88B], a
    jr Jump_03B_481F

Jump_03B_47CD::
    ld a, [$D8A5]
    ld c, a
    ld a, c
    call Func_000_3E54
    jr c, Jump_03B_47E3
    inc c
    ld a, c
    call Func_000_3E54
    jr c, Jump_03B_47E9
    ld d, c
    dec c
    ld e, c
    jr Jump_03B_47EE

Jump_03B_47E3::
    inc c
    ld e, c
    inc c
    ld d, c
    jr Jump_03B_47EE

Jump_03B_47E9::
    dec c
    ld e, c
    inc c
    inc c
    ld d, c

Jump_03B_47EE::
    ld a, e
    add a, a
    ld hl, $C0A0
    add a, l
    ld l, a
    jr nc, Jump_03B_47F8
    inc h

Jump_03B_47F8::
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld a, d
    add a, a
    ld hl, $C0A0
    add a, l
    ld l, a
    jr nc, Jump_03B_4805
    inc h

Jump_03B_4805::
    ld a, [hl+]
    cp a, c
    jr nz, Jump_03B_4817
    ld a, [hl]
    cp a, b
    jr nz, Jump_03B_4817
    ld a, e
    or a, $80
    ld [$D88B], a

Jump_03B_4813::
    ld a, $01
    jr Jump_03B_4834

Jump_03B_4817::
    ld a, e
    ld [$D88C], a
    ld a, d
    ld [$D88B], a

Jump_03B_481F::
    ld a, $02
    jr Jump_03B_4834

Jump_03B_4823::
    dec c
    ld a, c
    ld [$D88D], a
    inc c
    ld a, c
    ld [$D88C], a
    inc c
    ld a, c
    ld [$D88B], a
    ld a, $03

Jump_03B_4834::
    or a, $80
    ld [$DABA], a
    ret

Func_03B_483A::
    ld a, [$D8A6]
    cp a, $03
    jr z, Jump_03B_485F
    cp a, $01
    jr z, Jump_03B_4854
    cp a, $38
    jr z, Jump_03B_4854
    ld hl, $003C
    ld bc, $0046
    call Func_03B_4A40
    jr Jump_03B_4873

Jump_03B_4854::
    ld hl, $001E
    ld bc, $0028
    call Func_03B_4A40
    jr Jump_03B_4873

Jump_03B_485F::
    ld a, [$D8A5]
    ld hl, $D8CF
    call Func_03B_4F52
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld a, e
    ld [$D872], a
    ld a, d
    ld [$D873], a

Jump_03B_4873::
    ld a, [$D8A5]
    ld hl, $D8BF
    call Func_03B_4F52
    push hl
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, l
    add a, e
    ld c, a
    ld a, h
    adc a, d
    ld b, a
    ld a, [$D8A5]
    call Func_03B_4F25
    call Func_000_3E7A
    jr nc, Jump_03B_4896
    call Func_03B_48E9
    ld b, h
    ld c, l

Jump_03B_4896::
    pop hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    ret

Func_03B_489B:: ; heuristic: follows a terminator; C0
    ld a, [$D8A6]
    cp a, $05
    jr z, Jump_03B_48AD
    ld hl, $0014
    ld bc, $001E
    call Func_03B_4A40
    jr Jump_03B_48C1

Jump_03B_48AD::
    ld a, [$D8A5]
    ld hl, $D8EF
    call Func_03B_4F52
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld a, e
    ld [$D872], a
    ld a, d
    ld [$D873], a

Jump_03B_48C1::
    ld a, [$D8A5]
    ld hl, $D8DF
    call Func_03B_4F52
    push hl
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, l
    add a, e
    ld c, a
    ld a, h
    adc a, d
    ld b, a
    ld a, [$D8A5]
    call Func_03B_4F2A
    call Func_000_3E7A
    jr nc, Jump_03B_48E4
    call Func_03B_48E9
    ld b, h
    ld c, l

Jump_03B_48E4::
    pop hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    ret

Func_03B_48E9::
    ld a, c
    sub a, l
    ld c, a
    ld a, b
    sbc a, h
    ld b, a
    ld a, e
    sub a, c
    ld [$D872], a
    ld a, d
    sbc a, b
    ld [$D873], a
    ret

Func_03B_48FA::
    ld a, [$D8A5]
    ld hl, $D93F
    call Func_03B_4F52
    push hl
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    push hl
    ld a, [$D8A6]
    sub a, $19
    add a, a
    ld hl, Data_03B_492A
    add a, l
    ld l, a
    jr nc, Jump_03B_4916
    inc h

Jump_03B_4916::
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    pop hl
    ld a, l
    sub a, c
    ld c, a
    ld a, h
    sbc a, b
    ld b, a
    jr nc, Jump_03B_4925
    ld bc, $0000

Jump_03B_4925::
    pop hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    ret

Data_03B_492A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $05, $00, $0A, $00, $14, $00, $64, $00, $05, $00

Func_03B_4934::
    ld a, [$D8A6]
    sub a, $19
    add a, a
    ld hl, Data_03B_4949
    add a, l
    ld l, a
    jr nc, Jump_03B_4942
    inc h

Jump_03B_4942::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    call Func_03B_4953
    ret

Data_03B_4949:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0A, $00, $1E, $00, $64, $00, $E7, $03, $05, $00

Func_03B_4953::
    ld a, [$D89F]
    ld c, a
    ld a, [$D8A0]
    ld b, a
    add hl, bc
    ld bc, $0708
    call Func_000_3E7A
    jr c, Jump_03B_4967
    ld hl, $0708

Jump_03B_4967::
    ld a, l
    ld [$D89F], a
    ld a, h
    ld [$D8A0], a
    ret

Func_03B_4970::
    ld a, [$D89F]
    ld c, a
    ld a, [$D8A0]
    ld b, a
    ld a, h
    cpl
    ld h, a
    ld a, l
    cpl
    ld l, a
    inc hl
    add hl, bc
    bit 7, h
    jr z, Jump_03B_4987
    ld hl, $0000

Jump_03B_4987::
    ld a, l
    ld [$D89F], a
    ld a, h
    ld [$D8A0], a
    ret

Func_03B_4990:: ; heuristic: follows a terminator; C0
    ld a, [$D8A6]
    sub a, $24
    add a, a
    add a, a
    ld de, Func_03B_4A24
    add a, e
    ld e, a
    jr nc, Jump_03B_499F
    inc d

Jump_03B_499F::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    inc de
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    call Func_03B_4A40
    ld a, [$D8A6]
    cp a, $24
    jr nz, Jump_03B_49BD
    call Func_03B_4A5B
    rlca
    rlca
    and a, $03
    jr Jump_03B_49DE

Jump_03B_49BD::
    cp a, $25
    jr nz, Jump_03B_49CA
    call Func_03B_4A5B
    swap a
    and a, $03
    jr Jump_03B_49DE

Jump_03B_49CA::
    cp a, $26
    jr nz, Jump_03B_49D7
    call Func_03B_4A5B
    rrca
    rrca
    and a, $03
    jr Jump_03B_49DE

Jump_03B_49D7::
    call Func_03B_4A56
    swap a
    and a, $03

Jump_03B_49DE::
    and a, a
    ret z
    cp a, $01
    jr nz, Jump_03B_4A03
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    push de
    ld b, h
    ld c, l
    ld a, $55
    call Func_000_16AA
    ld a, $64
    call Func_000_16E2
    pop de
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    ret

Jump_03B_4A03::
    cp a, $02
    jr nz, Jump_03B_4A1C
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    srl h
    rr l
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    ret

Jump_03B_4A1C::
    xor a, a
    ld [$D872], a
    ld [$D873], a
    ret

Func_03B_4A24:: ; heuristic: follows a terminator; C0
    ld [$1800], sp
    nop
    inc hl
    nop
    ld [hl-], a
    nop
    ld a, b
    nop
    adc a, h
    nop
    or a, h
    nop
    ret z
    nop

Func_03B_4A34::
    call Func_03B_4A4C
    call Func_03B_4A60
    and a, $03
    call Func_03B_4A86
    ret

Func_03B_4A40::
    call Func_000_3E98
    ld a, e
    ld [$D872], a
    ld a, d
    ld [$D873], a
    ret

Func_03B_4A4C:: ; heuristic: follows a terminator; C0
    ld a, [$D8A5]
    ld hl, $D814
    call Func_000_3F25
    ret

Func_03B_4A56::
    ld de, $DA72
    jr Jump_03B_4A77

Func_03B_4A5B::
    ld de, $DA73
    jr Jump_03B_4A77

Func_03B_4A60::
    ld de, $DA74
    jr Jump_03B_4A77
    db $11, $75, $DA, $18, $0D, $11, $76, $DA, $18, $08, $11, $77, $DA, $18, $03, $11
    db $78, $DA

Jump_03B_4A77::
    ld a, [$D8A5]
    ld b, a
    add a, a
    add a, b
    add a, a
    add a, b
    add a, e
    ld e, a
    jr nc, Jump_03B_4A84
    inc d

Jump_03B_4A84::
    ld a, [de]
    ret

Func_03B_4A86:: ; heuristic: follows a terminator; C0
    bit 6, [hl]
    jr z, Jump_03B_4A8F
    call Func_03B_4ABF
    jr Jump_03B_4A9B

Jump_03B_4A8F::
    bit 7, [hl]
    jr z, Jump_03B_4A98
    call Func_03B_4AB2
    jr Jump_03B_4A9B

Jump_03B_4A98::
    call Func_03B_4A9C

Jump_03B_4A9B::
    ret

Func_03B_4A9C::
    and a, a
    jr nz, Jump_03B_4AA1
    scf
    ret

Jump_03B_4AA1::
    cp a, $01
    jr nz, Jump_03B_4AA8
    jp Jump_03B_4AD5

Jump_03B_4AA8::
    cp a, $02
    jr nz, Jump_03B_4AAF
    jp Jump_03B_4AE7

Jump_03B_4AAF::
    scf
    ccf
    ret

Func_03B_4AB2::
    cp a, $02
    jr nc, Jump_03B_4AB7
    ret

Jump_03B_4AB7::
    jr nz, Jump_03B_4ABC
    jp Jump_03B_4ADE

Jump_03B_4ABC::
    scf
    ccf
    ret

Func_03B_4ABF::
    and a, a
    jr nz, Jump_03B_4AC4
    scf
    ret

Jump_03B_4AC4::
    cp a, $01
    jr nz, Jump_03B_4ACB
    jp Jump_03B_4ADE

Jump_03B_4ACB::
    cp a, $02
    jr nz, Jump_03B_4AD2
    jp Jump_03B_4AF0

Jump_03B_4AD2::
    scf
    ccf
    ret

Jump_03B_4AD5::
    call Func_000_3ED4
    ld a, [$C5E7]
    cp a, $D8
    ret

Jump_03B_4ADE::
    call Func_000_3ED4
    ld a, [$C5E7]
    cp a, $BF
    ret

Jump_03B_4AE7::
    call Func_000_3ED4
    ld a, [$C5E7]
    cp a, $7F
    ret

Jump_03B_4AF0::
    call Func_000_3ED4
    ld a, [$C5E7]
    cp a, $66
    ret

Func_03B_4AF9:: ; heuristic: follows a terminator; C0
    call Func_000_3ED4
    ld a, [$C5E7]
    cp a, $3F
    ret

Func_03B_4B02::
    ld a, [$D8A6]
    ld c, a
    ld b, $00
    ld hl, $4B11
    add hl, bc
    add hl, bc
    call Func_000_000B
    ret
    db $91, $4B, $92, $4B, $92, $4B, $92, $4B, $BD, $4B, $BD, $4B, $E8, $4B, $FE, $4B
    dw Func_03B_4C21
    dw Func_03B_4C37
    dw Func_03B_4C5A
    dw Func_03B_4B92
    dw Func_03B_4C7D
    db $94, $4C, $94, $4C, $94, $4C, $94, $4C, $94, $4C, $94, $4C, $94, $4C, $94, $4C
    db $94, $4C, $94, $4C, $94, $4C, $94, $4C
    dw Func_03B_4C95
    dw Func_03B_4C95
    dw Func_03B_4C95
    dw Func_03B_4C95
    dw Func_03B_4D1C
    dw Func_03B_4E0A
    dw Func_03B_4E18
    INCBIN "dwm2-cobi-us.gbc", $0ECB51, $41

Func_03B_4B92:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A5]
    ld hl, $D8BF
    call Func_03B_4F52
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld a, [$D8A5]
    ld hl, $D8CF
    call Func_03B_4F52
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    call Func_000_3E7A
    jr z, Jump_03B_4BBA
    call Func_03B_483A
    ld l, $37
    ld bc, $4090
    jp Jump_03B_4ED6

Jump_03B_4BBA::
    jp Jump_03B_4EE3

Func_03B_4BBD:: ; heuristic: follows a terminator; C0
    ld a, [$D8A5]
    ld hl, $D8DF
    call Func_03B_4F52
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld a, [$D8A5]
    ld hl, $D8EF
    call Func_03B_4F52
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    call Func_000_3E7A
    jr z, Jump_03B_4BE5
    call Func_03B_489B
    ld l, $C3
    ld bc, $4090
    jp Jump_03B_4ED6

Jump_03B_4BE5::
    jp Jump_03B_4EE3

Func_03B_4BE8:: ; heuristic: follows a terminator; C0
    call Func_03B_4F03
    and a, $03
    jr z, Jump_03B_4BFB
    ld a, [hl]
    and a, $FC
    ld [hl], a
    ld l, $4E
    ld bc, $4090
    jp Func_03B_4ECF

Jump_03B_4BFB::
    jp Jump_03B_4EE3
    db $CD, $03, $4F, $E6, $40, $28, $19, $7E, $E6, $BF, $77, $FA, $A5, $D8, $21, $5B
    db $DA, $85, $6F, $30, $01, $24, $36, $03, $2E, $4F, $01, $90, $40, $C3, $CF

Data_03B_4C1D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $4E, $C3, $E3, $4E

Func_03B_4C21:: ; heuristic: target of a pointer table; C0
    call Func_03B_4F03
    and a, $20
    jr z, Jump_03B_4C34
    ld a, [hl]
    and a, $DF
    ld [hl], a
    ld l, $51
    ld bc, $4090
    jp Func_03B_4ECF

Jump_03B_4C34::
    jp Jump_03B_4EE3

Func_03B_4C37:: ; heuristic: target of a pointer table; C0
    call Func_03B_4F03
    and a, $8C
    jr z, Jump_03B_4C57
    ld a, [hl]
    and a, $73
    ld [hl], a
    ld a, [$D8A5]
    ld hl, $DA5B
    add a, l
    ld l, a
    jr nc, Jump_03B_4C4D
    inc h

Jump_03B_4C4D::
    ld [hl], $03
    ld l, $82
    ld bc, $4090
    jp Func_03B_4ECF

Jump_03B_4C57::
    jp Jump_03B_4EE3

Func_03B_4C5A:: ; heuristic: target of a pointer table; C0
    call Func_03B_4F03
    and a, $10
    jr z, Jump_03B_4C7A
    ld a, [hl]
    and a, $EF
    ld [hl], a
    ld a, [$D8A5]
    ld hl, $DA5B
    add a, l
    ld l, a
    jr nc, Jump_03B_4C70
    inc h

Jump_03B_4C70::
    ld [hl], $03
    ld l, $83
    ld bc, $4090
    jp Func_03B_4ECF

Jump_03B_4C7A::
    jp Jump_03B_4EE3

Func_03B_4C7D:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A5]
    call Func_000_3E54
    jr nc, Jump_03B_4C8E
    jr z, Jump_03B_4C91
    ld hl, Data_03B_6D0A
    ld b, $36
    rst $10
    ret

Jump_03B_4C8E::
    jp Jump_03B_4EE3

Jump_03B_4C91::
    jp Jump_03B_4F15
    db $C9

Func_03B_4C95:: ; heuristic: target of a pointer table; C0
    call Func_03B_4F74
    jr c, Jump_03B_4C9F
    call Func_03B_4934
    jr Jump_03B_4CC8

Jump_03B_4C9F::
    ld a, [$D8A5]
    ld hl, $D80C
    call Func_000_3F25
    ld a, [hl]
    bit 6, a
    jr nz, Jump_03B_4CEA
    and a, $8C
    jr nz, Jump_03B_4CF2
    ld a, $05
    add a, l
    ld l, a
    jr nc, Jump_03B_4CB8
    inc h

Jump_03B_4CB8::
    ld a, [hl]
    and a, $C0
    jr nz, Jump_03B_4D00
    ld a, [$D8A5]
    call Func_000_3E25
    jr c, Jump_03B_4D0E
    call Func_03B_48FA

Jump_03B_4CC8::
    ld a, [$D8A5]
    cp a, $03
    jr c, Jump_03B_4CE2
    ld hl, Data_03B_7AE3
    ld b, $3A
    rst $10
    ld a, b
    cp a, $01
    jr z, Jump_03B_4CE2
    ld l, $FD
    ld bc, $0090
    jp Func_03B_4ECF

Jump_03B_4CE2::
    ld l, $95
    ld bc, $0090
    jp Func_03B_4ECF

Jump_03B_4CEA::
    ld h, $E6
    ld bc, $0080
    jp Jump_03B_4EF6

Jump_03B_4CF2::
    ld d, $7B
    ld hl, Data_03B_6EE5
    ld b, $3A
    rst $10
    ld bc, $0000
    jp Jump_03B_4EFA

Jump_03B_4D00::
    ld d, $7D
    ld hl, Data_03B_6EE5
    ld b, $3A
    rst $10
    ld bc, $0000
    jp Jump_03B_4EFA

Jump_03B_4D0E::
    ld d, $7C
    ld hl, Data_03B_6EE5
    ld b, $3A
    rst $10
    ld bc, $0000
    jp Jump_03B_4EFA

Func_03B_4D1C:: ; heuristic: target of a pointer table; C0
    call Func_03B_4F74
    jr c, Jump_03B_4D2C
    ld a, [$DABA]
    or a, a
    jr nz, Jump_03B_4D59
    call Func_03B_4934
    jr Jump_03B_4D59

Jump_03B_4D2C::
    ld a, [$D8A5]
    ld hl, $D80C
    call Func_000_3F25
    ld a, [hl]
    bit 6, a
    jp nz, Jump_03B_4DD8
    and a, $8C
    jp nz, Jump_03B_4DE0
    ld a, $05
    add a, l
    ld l, a
    jr nc, Jump_03B_4D47
    inc h

Jump_03B_4D47::
    ld a, [hl]
    and a, $C0
    jp nz, Jump_03B_4DEE
    ld a, [$D8A5]
    call Func_000_3E25
    jp c, Jump_03B_4DFC
    call Func_03B_48FA

Jump_03B_4D59::
    ld a, [$D8A5]
    ld hl, $D80C
    call Func_000_3F25
    ld a, [hl]
    and a, $03
    jr nz, Jump_03B_4DAC
    push hl
    ld hl, Data_03B_60D1
    ld b, $36
    rst $10
    pop hl
    ld a, e
    or a, a
    jr nz, Jump_03B_4DAC
    set 0, [hl]
    ld a, [$D8A5]
    call Func_03B_4FC5
    ld l, $75
    ld bc, $0090
    call Func_03B_4ECF
    ld a, [$DABA]
    or a, a
    ret nz
    ld a, [$D8A5]
    cp a, $03
    jr c, Jump_03B_4DA3
    ld hl, Data_03B_7AE3
    ld b, $3A
    rst $10
    ld a, b
    cp a, $01
    jr z, Jump_03B_4DA3
    ld d, $FE
    ld hl, Data_03B_7193
    ld b, $3A
    rst $10
    ret

Jump_03B_4DA3::
    ld d, $96
    ld hl, Data_03B_7193
    ld b, $3A
    rst $10
    ret

Jump_03B_4DAC::
    call Func_03B_4EF1
    ld a, [$DABA]
    or a, a
    ret nz
    ld a, [$D8A5]
    cp a, $03
    jr c, Jump_03B_4DCF
    ld hl, Data_03B_7AE3
    ld b, $3A
    rst $10
    ld a, b
    cp a, $01
    jr z, Jump_03B_4DCF
    ld d, $FE
    ld hl, Data_03B_7193
    ld b, $3A
    rst $10
    ret

Jump_03B_4DCF::
    ld d, $96
    ld hl, Data_03B_7193
    ld b, $3A
    rst $10
    ret

Jump_03B_4DD8::
    ld h, $E6
    ld bc, $0080
    jp Jump_03B_4EF6

Jump_03B_4DE0::
    ld d, $7B
    ld hl, Data_03B_6EE5
    ld b, $3A
    rst $10
    ld bc, $0000
    jp Jump_03B_4EFA

Jump_03B_4DEE::
    ld d, $7D
    ld hl, Data_03B_6EE5
    ld b, $3A
    rst $10
    ld bc, $0000
    jp Jump_03B_4EFA

Jump_03B_4DFC::
    ld d, $7C
    ld hl, Data_03B_6EE5
    ld b, $3A
    rst $10
    ld bc, $0000
    jp Jump_03B_4EFA

Func_03B_4E0A:: ; heuristic: target of a pointer table; C0
    ld a, $01
    ld [$D894], a
    ld l, $98
    ld bc, $0090
    jp Func_03B_4ECF
    db $C9

Func_03B_4E18:: ; heuristic: target of a pointer table; C0
    jp Jump_03B_4F15

Func_03B_4E1B:: ; heuristic: follows a terminator; C0
    ld a, [$D8A5]
    ld hl, $D80D
    call Func_000_3F25
    bit 0, [hl]
    jr nz, Jump_03B_4E40
    call Func_03B_4A34
    jr nc, Jump_03B_4E43
    ld a, [$D8A5]
    ld hl, $D80D
    call Func_000_3F25
    set 0, [hl]
    ld l, $3B
    ld bc, $4098
    jp Func_03B_4ECF

Jump_03B_4E40::
    jp Jump_03B_4F15

Jump_03B_4E43::
    jp Jump_03B_4EEA

Func_03B_4E46:: ; heuristic: follows a terminator; C0
    ld a, [$D8A5]
    ld hl, $D80D
    call Func_000_3F25
    bit 2, [hl]
    jr nz, Jump_03B_4E5D
    set 2, [hl]
    ld l, $43
    ld bc, $0090
    jp Func_03B_4ECF

Jump_03B_4E5D::
    jp Jump_03B_4F15
    INCBIN "dwm2-cobi-us.gbc", $0ECE60, $6F

Func_03B_4ECF::
    xor a, a
    ld [$D872], a
    ld [$D873], a

Jump_03B_4ED6::
    ld a, l
    ld [$DAC2], a
    ld a, c
    ld [$DAC0], a
    ld a, b
    ld [$DAC1], a
    ret

Jump_03B_4EE3::
    ld h, $CC
    ld bc, $0080
    jr Jump_03B_4EF6

Jump_03B_4EEA::
    ld h, $B5
    ld bc, $0080
    jr Jump_03B_4EF6

Func_03B_4EF1::
    ld h, $B5
    ld bc, $0180

Jump_03B_4EF6::
    ld a, h
    ld [$DAC3], a

Jump_03B_4EFA::
    ld a, c
    ld [$DAC0], a
    ld a, b
    ld [$DAC1], a
    ret

Func_03B_4F03::
    xor a, a
    ld [$D872], a
    ld [$D873], a
    ld a, [$D8A5]
    ld hl, $D80C
    call Func_000_3F25
    ld a, [hl]
    ret

Jump_03B_4F15::
    ld a, $0A
    ld [$CFCB], a
    ret
    db $21, $FF, $D8, $18, $28, $21, $0F, $D9, $18, $23

Func_03B_4F25::
    ld hl, $D8CF
    jr Jump_03B_4F48

Func_03B_4F2A::
    ld hl, $D8EF
    jr Jump_03B_4F48
    db $21, $BF, $D8, $18, $14, $21, $DF, $D8, $18, $0F, $21, $1F, $D9, $18, $0A, $21
    db $53, $DA, $85, $6F, $30, $01, $24, $7E, $C9

Jump_03B_4F48::
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_03B_4F4E
    inc h

Jump_03B_4F4E::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ret

Func_03B_4F52::
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_03B_4F58
    inc h

Jump_03B_4F58::
    ret

Func_03B_4F59:: ; heuristic: follows a terminator; C0
    ld a, [$C58A]
    cp a, $01
    jr nz, Jump_03B_4F6E
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_03B_4F6E
    ld a, [$D8A4]
    cp a, $04
    ccf
    ret

Jump_03B_4F6E::
    ld a, [$D8A4]
    cp a, $04
    ret

Func_03B_4F74::
    ld a, [$C58A]
    cp a, $01
    jr nz, Jump_03B_4F89
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_03B_4F89
    ld a, [$D8A5]
    cp a, $04
    ccf
    ret

Jump_03B_4F89::
    ld a, [$D8A5]
    cp a, $04
    ret
    db $7A, $21, $A4, $4F, $85, $6F, $30, $01, $24, $56, $7B, $21, $0C, $D8, $CD, $25
    db $3F, $7A, $A6, $77, $C9, $DF, $FE, $00, $FD, $73, $EF, $BF

Func_03B_4FAB::
    push hl
    ld hl, $D095
    add a, l
    ld l, a
    jr nc, Jump_03B_4FB4
    inc h

Jump_03B_4FB4::
    set 0, [hl]
    pop hl
    ret

Func_03B_4FB8::
    push hl
    ld hl, $D095
    add a, l
    ld l, a
    jr nc, Jump_03B_4FC1
    inc h

Jump_03B_4FC1::
    set 1, [hl]
    pop hl
    ret

Func_03B_4FC5::
    push hl
    ld hl, $D095
    add a, l
    ld l, a
    jr nc, Jump_03B_4FCE
    inc h

Jump_03B_4FCE::
    set 2, [hl]
    pop hl
    ret

Func_03B_4FD2:: ; heuristic: follows a terminator; C0
    push hl
    push bc
    ld c, a
    ld b, $00
    ld hl, $D968
    add a, l
    ld l, a
    jr nc, Jump_03B_4FDF
    inc h

Jump_03B_4FDF::
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_03B_4FEE
    ld l, $09
    cp a, $40
    jr nc, Jump_03B_4FEE
    ld l, $12

Jump_03B_4FEE::
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, $D970
    add a, l
    ld l, a
    jr nc, Jump_03B_4FFA
    inc h

Jump_03B_4FFA::
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_03B_5009
    ld l, $03
    cp a, $40
    jr nc, Jump_03B_5009
    ld l, $06

Jump_03B_5009::
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, $D978
    add a, l
    ld l, a
    jr nc, Jump_03B_5015
    inc h

Jump_03B_5015::
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_03B_5024
    ld l, $01
    cp a, $40
    jr nc, Jump_03B_5024
    ld l, $02

Jump_03B_5024::
    ld a, l
    add a, b
    pop bc
    pop hl
    ret

Func_03B_5029:: ; heuristic: follows a terminator; C0
    call Func_000_3E25
    ret c
    push hl
    push bc
    ld c, a
    ld hl, $D80F
    call Func_000_3F25
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_03B_5043
    ld a, [hl]
    and a, $0C
    jr nz, Jump_03B_5043
    xor a, a
    jr Jump_03B_5044

Jump_03B_5043::
    scf

Jump_03B_5044::
    ld a, c
    pop bc
    pop hl
    ret

Func_03B_5048:: ; heuristic: follows a terminator; C0
    push hl
    ld hl, $D80F
    call Func_000_3F25
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_03B_5057
    ld a, [hl]
    and a, $0C

Jump_03B_5057::
    pop hl
    ret

Func_03B_5059::
    ld hl, $FFA9
    ld a, [$D804]
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $68
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, [$D801]
    ld [hl+], a
    ld a, [$DAB7]
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld [hl+], a
    ld de, Data_03B_507C
    call Func_03B_50E2
    ret

Data_03B_507C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_5133
    dw Data_03B_52C8
    dw Data_03B_5AE1
    dw Data_03B_5E7C
    dw Data_03B_6208
    dw Data_03B_6901

Func_03B_50E2::
    ldh a, [$FFB1]
    cp a, $28
    jr nc, Jump_03B_5132
    ldh a, [$FFAD]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, de
    ld e, [hl]
    inc hl
    ld d, [hl]
    ldh a, [$FFAE]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, de
    ld e, [hl]
    inc hl
    ld d, [hl]
    ldh a, [$FFB1]
    sla a
    sla a
    ld l, a
    ld h, $C0

Jump_03B_5105::
    ld a, [de]
    inc de
    cp a, $80
    jr z, Jump_03B_5132
    ld b, a
    ldh a, [$FFAB]
    add a, b
    add a, $10
    ld [hl+], a
    ld a, [de]
    inc de
    ld b, a
    ldh a, [$FFA9]
    add a, b
    add a, $08
    ld [hl+], a
    ldh a, [$FFAF]
    ld b, a
    ld a, [de]
    inc de
    add a, b
    ld [hl+], a
    ld a, [de]
    inc de
    ld b, a
    ldh a, [$FFB0]
    xor a, b
    ld [hl+], a
    ldh a, [$FFB1]
    inc a
    ldh [$FFB1], a
    cp a, $28
    jr c, Jump_03B_5105

Jump_03B_5132::
    ret

Data_03B_5133:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03B_5173
    dw Data_03B_517C
    dw Data_03B_5195
    dw Data_03B_51AE
    dw Data_03B_51BF
    dw Data_03B_51C8
    dw Data_03B_51D5
    dw Data_03B_51E2
    dw Data_03B_51F7
    dw Data_03B_5218
    dw Data_03B_5255
    dw Data_03B_5296
    dw Data_03B_52C7
    dw Data_03B_52C7
    dw Data_03B_52C7
    dw Data_03B_52C7
    dw Data_03B_52C7
    dw Data_03B_52C7
    dw Data_03B_52C7
    dw Data_03B_52C7
    dw Data_03B_52C7
    dw Data_03B_52C7
    dw Data_03B_52C7
    dw Data_03B_52C7
    dw Data_03B_52C7
    dw Data_03B_52C7
    dw Data_03B_52C7
    dw Data_03B_52C7
    dw Data_03B_52C7
    dw Data_03B_52C7
    dw Data_03B_52C7
    dw Data_03B_52C7

Data_03B_5173:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F8, $00, $00, $F8, $FF, $00, $20, $80

Data_03B_517C:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F0, $02, $00, $F8, $F8, $03, $00, $F8, $00, $03, $20, $F8, $07, $02, $20
    db $F0, $FF, $01, $20, $F0, $F8, $01, $00, $80

Data_03B_5195:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F0, $05, $00, $F8, $F8, $06, $00, $F8, $07, $05, $20, $F8, $FF, $06, $20
    db $F0, $F8, $04, $00, $F0, $FF, $04, $20, $80

Data_03B_51AE:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F8, $08, $00, $F0, $F8, $07, $00, $F8, $FF, $08, $20, $F0, $FF, $07, $20
    db $80

Data_03B_51BF:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $FC, $0A, $00, $F0, $FC, $09, $00, $80

Data_03B_51C8:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $FC, $0B, $00, $F0, $FC, $0A, $00, $E8, $FC, $09, $00, $80

Data_03B_51D5:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $FC, $0D, $00, $F0, $FC, $0E, $00, $F8, $FC, $0C, $00, $80

Data_03B_51E2:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $F8, $11, $00, $E8, $00, $12, $00, $E0, $F8, $0F, $00, $E0, $00, $10, $00
    db $F0, $FC, $0C, $00, $80

Data_03B_51F7:: ; heuristic: target of a monotone pointer table; C0
    db $E4, $F4, $16, $00, $E4, $FC, $17, $00, $E4, $04, $18, $00, $DC, $F4, $13, $00
    db $DC, $FC, $14, $00, $DC, $04, $15, $00, $EC, $F8, $19, $00, $EC, $00, $1A, $00
    db $80

Data_03B_5218:: ; heuristic: target of a monotone pointer table; C0
    db $D8, $F0, $1B, $00, $D8, $F8, $1C, $00, $D8, $00, $1D, $00, $E0, $F0, $1E, $00
    db $E0, $F8, $1F, $00, $E0, $00, $1F, $20, $E8, $F8, $1F, $40, $E8, $00, $1F, $60
    db $E0, $08, $20, $00, $E8, $08, $1E, $60, $F0, $F0, $22, $00, $F0, $F8, $23, $00
    db $F0, $00, $24, $00, $F0, $08, $25, $00, $E8, $F0, $21, $00, $80

Data_03B_5255:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ED255, $41

Data_03B_5296:: ; heuristic: target of a monotone pointer table; C0
    db $DA, $06, $2F, $00, $D2, $06, $2E, $00, $D6, $12, $2F, $00, $DA, $F2, $2E, $20
    db $D2, $F2, $2F, $20, $D7, $EA, $2E, $20, $EE, $F2, $2F, $60, $F6, $F2, $2E, $60
    db $F2, $E6, $2F, $60, $EE, $06, $2E, $40, $F6, $06, $2F, $40, $F1, $0E, $2E, $40
    db $80

Data_03B_52C7:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03B_52C8:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03B_5308
    dw Data_03B_5351
    dw Data_03B_53C2
    dw Data_03B_5453
    dw Data_03B_54E8
    dw Data_03B_5585
    dw Data_03B_560E
    dw Data_03B_567F
    dw Data_03B_56C8
    dw Data_03B_5701
    dw Data_03B_5742
    dw Data_03B_5783
    dw Data_03B_57B8
    dw Data_03B_57E1
    dw Data_03B_580A
    dw Data_03B_5847
    dw Data_03B_5870
    dw Data_03B_5895
    dw Data_03B_58B6
    dw Data_03B_58DF
    dw Data_03B_5920
    dw Data_03B_5961
    dw Data_03B_598A
    dw Data_03B_59BB
    dw Data_03B_59F4
    dw Data_03B_5A39
    dw Data_03B_5A7E
    dw Data_03B_5AAB
    dw Data_03B_5AE0
    dw Data_03B_5AE0
    dw Data_03B_5AE0
    dw Data_03B_5AE0

Data_03B_5308:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ED308, $49

Data_03B_5351:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ED351, $71

Data_03B_53C2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ED3C2, $91

Data_03B_5453:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ED453, $95

Data_03B_54E8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ED4E8, $9D

Data_03B_5585:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ED585, $89

Data_03B_560E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ED60E, $71

Data_03B_567F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ED67F, $49

Data_03B_56C8:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $40, $27, $00, $F8, $38, $2A, $00, $F8, $40, $2B, $00, $F0, $38, $28, $00
    db $F0, $40, $29, $00, $F0, $28, $00, $00, $F0, $30, $04, $00, $F8, $28, $0C, $00
    db $F8, $30, $0D, $00, $F8, $10, $20, $00, $F8, $18, $21, $00, $F8, $20, $22, $00
    db $F8, $08, $20, $20, $F8, $00, $21, $20, $80

Data_03B_5701:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ED701, $41

Data_03B_5742:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $08, $20, $00, $F8, $10, $21, $00, $F8, $18, $23, $20, $F0, $20, $20, $00
    db $F0, $28, $21, $00, $F0, $40, $21, $20, $F0, $38, $22, $20, $F0, $30, $23, $20

Data_03B_5762:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $F0, $48, $20, $20, $F8, $48, $24, $20, $F8, $40, $25, $20, $F8, $20, $24, $00
    db $F8, $28, $25, $00, $F8, $30, $26, $00, $F8, $00, $20, $20, $F8, $38, $2C, $00
    db $80

Data_03B_5783:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $20, $20, $00, $F8, $28, $21, $00, $F8, $30, $23, $20, $F0, $38, $20, $00
    db $F0, $40, $21, $00, $F0, $48, $23, $20, $F8, $38, $24, $00, $F8, $40, $25, $00
    db $F8, $48, $26, $00, $F8, $18, $20, $20, $F8, $10, $21, $20, $F8, $08, $23, $00
    db $F8, $00, $22, $00, $80

Data_03B_57B8:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $08, $20, $00, $F8, $10, $21, $00, $F8, $38, $20, $00, $F8, $40, $21, $00
    db $F8, $48, $23, $20, $F8, $00, $20, $20, $F8, $30, $20, $20, $F8, $28, $21, $20
    db $F8, $20, $23, $00, $F8, $18, $22, $00, $80

Data_03B_57E1:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $20, $20, $00, $F8, $28, $21, $00, $F8, $18, $20, $20, $F8, $10, $21, $20
    db $F8, $48, $20, $20, $F8, $40, $21, $20, $F8, $38, $23, $00, $F8, $30, $22, $00
    db $F8, $08, $23, $00, $F8, $00, $25, $00, $80

Data_03B_580A:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $28, $20, $00, $F0, $30, $21, $00, $F0, $38, $23, $20, $F8, $28, $24, $00
    db $F8, $30, $25, $00, $F8, $10, $20, $00, $F8, $18, $21, $00, $F8, $20, $23, $20
    db $F8, $08, $20, $20, $F8, $00, $21, $20, $F0, $48, $21, $20, $F0, $40, $22, $20
    db $F8, $48, $25, $20, $F8, $40, $26, $20, $F8, $38, $2C, $00, $80

Data_03B_5847:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F8, $21, $00, $F8, $00, $22, $00, $F8, $20, $20, $20, $F8, $18, $21, $20
    db $F8, $10, $23, $00, $F8, $30, $20, $00, $F8, $38, $21, $00, $F8, $40, $23, $20
    db $F8, $48, $22, $20, $F8, $08, $2C, $20, $80

Data_03B_5870:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $00, $20, $20, $F8, $F8, $21, $20, $F8, $F0, $22, $20, $F8, $D0, $20, $00
    db $F8, $D8, $21, $00, $F8, $E0, $23, $20, $F8, $30, $20, $00, $F8, $38, $20, $20
    db $F8, $E8, $2C, $40, $80

Data_03B_5895:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $40, $20, $00, $F8, $48, $20, $20, $F8, $00, $20, $00, $F8, $08, $20, $20
    db $F8, $D8, $20, $00, $F8, $E0, $20, $20, $F8, $C8, $20, $00, $F8, $D0, $20, $20
    db $80

Data_03B_58B6:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $D0, $21, $00, $F8, $C8, $21, $20, $F8, $C0, $22, $20, $F0, $B8, $20, $20
    db $F0, $B0, $21, $20, $F8, $B8, $24, $20, $F8, $B0, $25, $20, $F0, $25, $27, $20
    db $F8, $25, $29, $20, $F8, $2D, $08, $00, $80

Data_03B_58DF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ED8DF, $41

Data_03B_5920:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ED920, $41

Data_03B_5961:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $C0, $20, $00, $F8, $C8, $21, $00, $F8, $B8, $20, $20, $F8, $B0, $21, $20
    db $F8, $F0, $20, $00, $F8, $F8, $21, $00, $F8, $E0, $21, $20, $F8, $D8, $22, $20
    db $F8, $D0, $23, $20, $F8, $E8, $20, $20, $80

Data_03B_598A:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $D8, $20, $00, $F8, $E0, $21, $00, $F8, $D0, $20, $20, $F8, $C8, $21, $20
    db $F8, $F8, $21, $20, $F8, $F0, $23, $00, $F8, $E8, $22, $00, $F8, $C0, $23, $00
    db $F8, $B0, $24, $00, $F8, $B8, $25, $00, $F0, $B0, $21, $20, $F0, $B8, $20, $20
    db $80

Data_03B_59BB:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F0, $20, $00, $F8, $F8, $21, $00, $F8, $E8, $20, $20, $F8, $E0, $21, $20
    db $F8, $D8, $23, $00, $F8, $C8, $24, $00, $F8, $D0, $25, $00, $F0, $C0, $21, $20
    db $F0, $B8, $22, $20, $F0, $C8, $20, $20, $F8, $C0, $25, $20, $F8, $B8, $26, $20
    db $F0, $B0, $18, $00, $F8, $B0, $2C, $00, $80

Data_03B_59F4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0ED9F4, $45

Data_03B_5A39:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EDA39, $45

Data_03B_5A7E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $F8, $D8, $20, $00, $F8, $E0, $21, $00, $F8, $D0, $20, $20, $F8, $C8, $21, $20
    db $F8, $E8, $22, $00, $F8, $C0, $23, $00, $F8, $B0, $24, $00, $F8, $B8, $25, $00
    db $F0, $B0, $20, $20, $F8, $F8, $23, $00, $F8, $F0, $26, $00, $80

Data_03B_5AAB:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F0, $20, $00, $F8, $E8, $20, $20, $F8, $E0, $21, $20, $F8, $D8, $23, $00
    db $F8, $C8, $24, $00, $F8, $D0, $25, $00, $F0, $C8, $20, $20, $F0, $B0, $23, $20
    db $F0, $C0, $21, $20, $F0, $B8, $22, $20, $F8, $C0, $25, $20, $F8, $B0, $2C, $20
    db $F8, $B8, $26, $00, $80

Data_03B_5AE0:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03B_5AE1:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03B_5B21
    dw Data_03B_5B32
    dw Data_03B_5B53
    dw Data_03B_5B78
    dw Data_03B_5B99
    dw Data_03B_5BAA
    dw Data_03B_5BBB
    dw Data_03B_5BC8
    dw Data_03B_5BD1
    dw Data_03B_5BE2
    dw Data_03B_5C03
    dw Data_03B_5C54
    dw Data_03B_5CB5
    dw Data_03B_5CFE
    dw Data_03B_5D47
    dw Data_03B_5D98
    dw Data_03B_5DE9
    dw Data_03B_5E32
    dw Data_03B_5E7B
    dw Data_03B_5E7B
    dw Data_03B_5E7B
    dw Data_03B_5E7B
    dw Data_03B_5E7B
    dw Data_03B_5E7B
    dw Data_03B_5E7B
    dw Data_03B_5E7B
    dw Data_03B_5E7B
    dw Data_03B_5E7B
    dw Data_03B_5E7B
    dw Data_03B_5E7B
    dw Data_03B_5E7B
    dw Data_03B_5E7B

Data_03B_5B21:: ; heuristic: target of a monotone pointer table; C0
    db $D8, $03, $20, $00, $D8, $0B, $21, $00, $D0, $03, $22, $00, $D0, $0B, $23, $00
    db $80

Data_03B_5B32:: ; heuristic: target of a monotone pointer table; C0
    db $DC, $00, $20, $00, $DC, $08, $21, $00, $E4, $F8, $20, $60, $E4, $F0, $21, $60
    db $D4, $00, $22, $00, $D4, $08, $23, $00, $EC, $F8, $22, $60, $EC, $F0, $23, $60
    db $80

Data_03B_5B53:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F0, $24, $00, $E8, $F4, $27, $00, $E8, $FC, $28, $00, $F0, $F0, $25, $00
    db $F0, $F8, $26, $00, $D8, $03, $2B, $00, $E0, $F8, $29, $00, $E0, $00, $2A, $00
    db $D0, $08, $2B, $00, $80

Data_03B_5B78:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $EB, $27, $00, $F8, $F3, $28, $00, $E8, $FA, $2B, $00, $F0, $EF, $29, $00
    db $F0, $F7, $2A, $00, $E0, $FE, $2C, $00, $D0, $08, $2C, $00, $D8, $03, $2C, $00
    db $80

Data_03B_5B99:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $F4, $2D, $00, $F8, $EF, $2D, $00, $E8, $F9, $2C, $00, $DC, $01, $2C, $00
    db $80

Data_03B_5BAA:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $F4, $2D, $00, $E8, $F9, $2D, $00, $E0, $FE, $2D, $00, $F8, $EF, $2B, $00
    db $80

Data_03B_5BBB:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $EF, $2D, $00, $F0, $F4, $2D, $00, $E8, $F9, $2D, $00, $80

Data_03B_5BC8:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F8, $00, $00, $F8, $00, $01, $00, $80

Data_03B_5BD1:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $F8, $02, $00, $F0, $00, $03, $00, $F8, $F8, $04, $00, $F8, $00, $05, $00
    db $80

Data_03B_5BE2:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $F8, $02, $00, $E8, $00, $03, $00, $F0, $F8, $04, $00, $F0, $00, $05, $00
    db $F8, $F8, $06, $00, $F8, $00, $07, $00, $F8, $F0, $00, $00, $F8, $08, $01, $00
    db $80

Data_03B_5C03:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EDC03, $51

Data_03B_5C54:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EDC54, $61

Data_03B_5CB5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EDCB5, $49

Data_03B_5CFE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EDCFE, $49

Data_03B_5D47:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EDD47, $51

Data_03B_5D98:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EDD98, $51

Data_03B_5DE9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EDDE9, $49

Data_03B_5E32:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EDE32, $49

Data_03B_5E7B:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03B_5E7C:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03B_5EBC
    dw Data_03B_5EC5
    dw Data_03B_5ED6
    dw Data_03B_5EE7
    dw Data_03B_5F08
    dw Data_03B_5F59
    dw Data_03B_5FBA
    dw Data_03B_602B
    dw Data_03B_60A4
    dw Data_03B_6125
    dw Data_03B_61A6
    dw Data_03B_6207
    dw Data_03B_6207
    dw Data_03B_6207
    dw Data_03B_6207
    dw Data_03B_6207
    dw Data_03B_6207
    dw Data_03B_6207
    dw Data_03B_6207
    dw Data_03B_6207
    dw Data_03B_6207
    dw Data_03B_6207
    dw Data_03B_6207
    dw Data_03B_6207
    dw Data_03B_6207
    dw Data_03B_6207
    dw Data_03B_6207
    dw Data_03B_6207
    dw Data_03B_6207
    dw Data_03B_6207
    dw Data_03B_6207
    dw Data_03B_6207

Data_03B_5EBC:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F8, $00, $00, $F8, $00, $01, $00, $80

Data_03B_5EC5:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $F8, $02, $00, $F0, $00, $03, $00, $F8, $F8, $04, $00, $F8, $00, $05, $00
    db $80

Data_03B_5ED6:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $00, $02, $20, $F0, $F8, $03, $20, $F8, $00, $04, $20, $F8, $F8, $05, $20
    db $80

Data_03B_5EE7:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $F8, $02, $00, $E8, $00, $03, $00, $F0, $F8, $04, $00, $F0, $00, $05, $00
    db $F8, $F8, $06, $00, $F8, $00, $07, $00, $F8, $F0, $00, $00, $F8, $08, $01, $00
    db $80

Data_03B_5F08:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EDF08, $51

Data_03B_5F59:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EDF59, $61

Data_03B_5FBA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EDFBA, $71

Data_03B_602B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EE02B, $79

Data_03B_60A4:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $E8, $28, $00, $E8, $10, $28, $20, $E8, $08, $29, $20, $E8, $F8, $2A, $00
    db $E8, $00, $2B, $00, $E8, $F0, $29, $00, $E0, $10, $18, $20, $E0, $08, $19, $20
    db $E0, $F8, $1A, $00, $E0, $00, $1B, $00, $E0, $E8, $18, $00, $E0

Data_03B_60D1:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0EE0D1, $54

Data_03B_6125:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EE125, $81

Data_03B_61A6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EE1A6, $61

Data_03B_6207:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03B_6208:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03B_6248
    dw Data_03B_6251
    dw Data_03B_6266
    dw Data_03B_628B
    dw Data_03B_62C4
    dw Data_03B_6315
    dw Data_03B_637E
    dw Data_03B_63F7
    dw Data_03B_647C
    dw Data_03B_6509
    dw Data_03B_659A
    dw Data_03B_662B
    dw Data_03B_66BC
    dw Data_03B_674D
    dw Data_03B_67DE
    dw Data_03B_686F
    dw Data_03B_6900
    dw Data_03B_6900
    dw Data_03B_6900
    dw Data_03B_6900
    dw Data_03B_6900
    dw Data_03B_6900
    dw Data_03B_6900
    dw Data_03B_6900
    dw Data_03B_6900
    dw Data_03B_6900
    dw Data_03B_6900
    dw Data_03B_6900
    dw Data_03B_6900
    dw Data_03B_6900
    dw Data_03B_6900
    dw Data_03B_6900

Data_03B_6248:: ; heuristic: target of a monotone pointer table; C0
    db $D8, $10, $00, $00, $D0, $10, $01, $00, $80

Data_03B_6251:: ; heuristic: target of a monotone pointer table; C0
    db $D8, $08, $00, $20, $E0, $10, $00, $00, $D0, $08, $01, $20, $D8, $10, $01, $00
    db $D0, $10, $02, $00, $80

Data_03B_6266:: ; heuristic: target of a monotone pointer table; C0
    db $D8, $00, $00, $00, $E0, $08, $00, $20, $E8, $10, $00, $00, $D0, $00, $01, $00
    db $D8, $08, $01, $20, $E0, $10, $01, $00, $D0, $08, $02, $20, $D8, $10, $02, $00
    db $D0, $10, $03, $00, $80

Data_03B_628B:: ; heuristic: target of a monotone pointer table; C0
    db $D8, $F8, $00, $20, $E0, $00, $00, $00, $E8, $08, $00, $20, $F0, $10, $00, $00
    db $D0, $F8, $01, $20, $D8, $00, $01, $00, $E0, $08, $01, $20, $E8, $10, $01, $00
    db $D0, $00, $02, $00, $D8, $08, $02, $20, $E0, $10, $02, $00, $D0, $08, $03, $20
    db $D8, $10, $03, $00, $D0, $10, $04, $00, $80

Data_03B_62C4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EE2C4, $51

Data_03B_6315:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EE315, $69

Data_03B_637E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EE37E, $79

Data_03B_63F7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EE3F7, $85

Data_03B_647C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EE47C, $8D

Data_03B_6509:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EE509, $91

Data_03B_659A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EE59A, $91

Data_03B_662B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EE62B, $91

Data_03B_66BC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EE6BC, $91

Data_03B_674D:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $E8, $04, $00, $D0, $E8, $05, $00, $D0, $F0, $06, $00, $D0, $F8, $05, $00
    db $D8, $E8, $07, $00, $D8, $F0, $08

Data_03B_6764:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0EE764, $7A

Data_03B_67DE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EE7DE, $91

Data_03B_686F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EE86F, $91

Data_03B_6900:: ; heuristic: target of a monotone pointer table; C0
    db $80

Data_03B_6901:: ; heuristic: target of a monotone pointer table; C0
    dw Data_03B_6941
    dw Data_03B_6962
    dw Data_03B_69AB
    dw Data_03B_69FC
    dw Data_03B_6A4D
    dw Data_03B_6A92
    dw Data_03B_6ADB
    dw Data_03B_6AF8
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D
    dw Data_03B_6B0D

Data_03B_6941:: ; heuristic: target of a monotone pointer table; C0
    db $D0, $28, $00, $00, $D0, $E0, $00, $00, $D0, $C0, $01, $00, $D8, $D0, $00, $00
    db $E0, $F6, $01, $00, $D8, $18, $01, $00, $E0, $30, $02, $00, $D0, $FE, $02, $00
    db $80

Data_03B_6962:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EE962, $49

Data_03B_69AB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EE9AB, $51

Data_03B_69FC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EE9FC, $51

Data_03B_6A4D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EEA4D, $45

Data_03B_6A92:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EEA92, $49

Data_03B_6ADB:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $38, $05, $20, $EC, $E8, $05, $20, $E4, $BE, $05, $20, $E8, $D9, $03, $00
    db $EA, $00, $03, $00, $E0, $28, $05, $20, $EB, $20, $03, $00, $80

Data_03B_6AF8:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $2A, $03, $00, $F8, $3C, $03, $00, $F1, $BA, $03, $00, $F8, $20, $03, $00
    db $F8, $E6, $03, $00, $80

Data_03B_6B0D:: ; heuristic: target of a monotone pointer table; C0
    db $80
    ds $1FC, $00

Data_03B_6D0A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $188, $00

Data_03B_6E92:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $53, $00

Data_03B_6EE5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $2AE, $00

Data_03B_7193:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $5B9, $00

Data_03B_774C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $397, $00

Data_03B_7AE3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $51D, $00
