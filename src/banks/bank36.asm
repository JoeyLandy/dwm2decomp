SECTION "Bank 36", ROMX[$4000], BANK[$36]
    db $36

Func_036_4001::
    ld a, [$CFCB]
    rst $00
    dw Jump_036_4025
    dw Jump_036_4077
    dw Jump_036_431F
    dw Jump_036_4356
    dw Jump_036_438A
    dw Jump_036_458E
    dw Jump_036_4603
    dw Jump_036_460B
    dw Jump_036_4776
    dw Jump_036_47F1
    dw Jump_036_4806
    dw Jump_036_48DE
    dw Jump_036_48FA
    dw Jump_036_4901
    dw Jump_036_4908
    dw Jump_036_490F

Jump_036_4025::
    ld hl, $CFCB
    inc [hl]
    xor a, a
    ld [$CFCC], a
    ld a, [$DABD]
    or a, a
    jr nz, Jump_036_4069
    ld a, [$CFF3]
    bit 7, a
    jr z, Jump_036_4069
    ld a, [$D8A5]
    call Func_036_7F3C
    jr c, Jump_036_4069
    ld a, [$D8A5]
    ld hl, $D854
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_036_404E
    inc h

Jump_036_404E::
    bit 5, [hl]
    jr z, Jump_036_4069
    ld hl, $4A5F
    ld b, $A3
    rst $10
    ld a, c
    cp a, $FF
    jr z, Jump_036_4069
    ld [$C971], a
    ld d, $33
    ld hl, $6EE5
    ld b, $3A
    rst $10
    ret

Jump_036_4069::
    ld a, [$D8A5]
    ld hl, $D854
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_036_4075
    inc h

Jump_036_4075::
    res 5, [hl]

Jump_036_4077::
    ld a, [$CFCC]
    rst $00
    dw Jump_036_407F
    dw Jump_036_4127

Jump_036_407F::
    xor a, a
    ld [$C981], a
    ld a, [$DABD]
    or a, a
    jp nz, Jump_036_411F
    ld a, [$CFF2]
    cp a, $40
    jp z, Jump_036_4127
    and a, $F0
    cp a, $20
    jp z, Jump_036_4127
    ld a, [$CFF3]
    bit 4, a
    jr z, Jump_036_40ED
    ld a, [$D8A5]
    and a, $04
    ld c, a
    rrca
    rrca
    and a, $01
    ld hl, $D80A
    add a, l
    ld l, a
    jr nc, Jump_036_40B2
    inc h

Jump_036_40B2::
    bit 6, [hl]
    jr z, Jump_036_40ED
    ld a, l
    add a, $5A
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl]
    rrca
    rrca
    and a, $03
    or a, c
    ld c, a
    call Func_036_7F3C
    jr c, Jump_036_40ED
    ld a, $01
    ld [$DAB2], a
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_036_40DB
    inc h

Jump_036_40DB::
    ld [hl], c
    ld a, c
    ld [$D8A5], a
    ld d, $CB
    ld hl, Data_036_7193
    ld b, $3A
    rst $10
    ld hl, $CFCC
    inc [hl]
    ret

Jump_036_40ED::
    ld hl, $CFCC
    inc [hl]
    ld a, [$CFF3]
    bit 7, a
    jr nz, Jump_036_4102
    bit 4, a
    jr nz, Jump_036_4109
    bit 6, a
    jr nz, Jump_036_4110
    jr Jump_036_4117

Jump_036_4102::
    call Func_036_4162
    jr c, Jump_036_411E
    jr Jump_036_411C

Jump_036_4109::
    call Func_036_421D
    jr c, Jump_036_411E
    jr Jump_036_411C

Jump_036_4110::
    call Func_036_425A
    jr c, Jump_036_411E
    jr Jump_036_411C

Jump_036_4117::
    call Func_036_42AA
    jr c, Jump_036_411E

Jump_036_411C::
    jr Jump_036_4127

Jump_036_411E::
    ret

Jump_036_411F::
    ld hl, $CFCB
    inc [hl]
    ld hl, $CFCB
    inc [hl]

Jump_036_4127::
    ld hl, $CFCB
    inc [hl]
    xor a, a
    ld [$CFCC], a
    ld a, [$D8A5]
    ld hl, $D80E
    call Func_000_3F25
    bit 3, [hl]
    ret z
    ld a, [$CFF3]
    bit 3, a
    ret z
    res 3, [hl]
    ld d, $E9
    call Func_036_7E87
    jr c, Jump_036_414B
    inc d

Jump_036_414B::
    ld hl, Data_036_7193
    ld b, $3A
    rst $10
    ld a, $03
    ld [$DABE], a
    ld a, [$DAC0]
    res 4, a
    ld [$DAC0], a
    call Func_036_4FD1
    ret

Func_036_4162::
    ld a, [$D8A5]
    call Func_036_7F5B
    jr z, Jump_036_4191
    ld a, [$CFF5]
    bit 5, a
    jr z, Jump_036_4191
    ld a, [$D8A6]
    cp a, $4E
    jr z, Jump_036_4189
    cp a, $4F
    jr z, Jump_036_4189
    ld a, $84
    call Func_000_1278
    call Func_036_4FD1
    ld d, $68
    jp Jump_036_4317

Jump_036_4189::
    call Func_036_4FD1
    ld d, $69
    jp Jump_036_4317

Jump_036_4191::
    call Func_036_42D3
    jp nc, Jump_036_4317
    ld a, [$D8A6]
    cp a, $4E
    jr z, Jump_036_41A2
    cp a, $4F
    jr nz, Jump_036_41AF

Jump_036_41A2::
    ld a, [$D8A4]
    ld hl, $D812
    call Func_000_3F25
    bit 0, [hl]
    jr z, Jump_036_421B

Jump_036_41AF::
    ld a, [$D8A5]
    call Func_036_7F3C
    jr c, Jump_036_421B
    ld a, [$D8A5]
    ld hl, $D854
    call Func_036_7E65
    bit 5, [hl]
    jr nz, Jump_036_41D1
    ld a, [$D8A5]
    ld hl, $D812
    call Func_000_3F25
    bit 5, [hl]
    jr z, Jump_036_421B

Jump_036_41D1::
    call Func_036_4F18
    jr c, Jump_036_4211
    push af
    ld a, [$D8A6]
    cp a, $CC
    jr nz, Jump_036_41EB
    ld a, [$D8A4]
    ld hl, $D810
    call Func_000_3F25
    ld a, [hl]
    and a, $F3
    ld [hl], a

Jump_036_41EB::
    pop af
    push af
    ld d, $C8
    ld hl, Data_036_7193
    ld b, $3A
    rst $10
    ld a, [$D8A5]
    ld [$DAD1], a
    pop af
    ld [$D8A5], a
    ld b, a
    ld a, [$D8A4]
    ld hl, $DA1D
    call Func_036_7E65
    ld [hl], b
    ld hl, $DABF
    set 0, [hl]
    scf
    ret

Jump_036_4211::
    ld d, $C9
    ld hl, Data_036_7193
    ld b, $3A
    rst $10
    scf
    ret

Jump_036_421B::
    xor a, a
    ret

Func_036_421D::
    call Func_036_42D3
    jp nc, Jump_036_4317
    ld a, [$D8A5]
    ld hl, $D80E
    call Func_000_3F25
    bit 6, [hl]
    jr z, Jump_036_4253
    res 6, [hl]
    ld a, $02
    ld [$DABE], a
    ld d, $C7
    ld hl, Data_036_7193
    ld b, $3A
    rst $10
    ld a, $01
    ld [$C981], a
    ld a, [$D8A4]
    call Func_000_3E54
    jr c, Jump_036_4255
    ld d, $01
    call Func_036_4EB1
    scf
    ret

Jump_036_4253::
    xor a, a
    ret

Jump_036_4255::
    call Func_036_4FD1
    scf
    ret

Func_036_425A::
    call Func_036_42D3
    jp nc, Jump_036_4317
    ld a, [$D8A5]
    ld hl, $D80E
    call Func_000_3F25
    ld a, [hl]
    and a, $22
    jr z, Jump_036_42A3
    ld a, [$CFF5]
    bit 7, a
    jr z, Jump_036_42A3
    bit 1, [hl]
    jr nz, Jump_036_4280
    res 5, [hl]
    ld a, $01
    ld [$DABE], a

Jump_036_4280::
    call Func_036_7E87
    ld d, $C5
    jr c, Jump_036_4289
    ld d, $C6

Jump_036_4289::
    ld hl, Data_036_7193
    ld b, $3A
    rst $10
    ld a, $01
    ld [$C981], a
    ld a, [$D8A4]
    call Func_000_3E54
    jr c, Jump_036_42A5
    ld d, $04
    call Func_036_4EB1
    scf
    ret

Jump_036_42A3::
    xor a, a
    ret

Jump_036_42A5::
    call Func_036_4FD1
    scf
    ret

Func_036_42AA::
    ld a, [$D8A5]
    call Func_036_7F5B
    jr z, Jump_036_42CB
    ld a, [$CFF5]
    bit 5, a
    jr z, Jump_036_42CB
    ld a, $84
    call Func_000_1278
    ld d, $68
    ld hl, Data_036_7193
    ld b, $3A
    rst $10
    call Func_036_4FD1
    scf
    ret

Jump_036_42CB::
    call Func_036_42D3
    jp nc, Jump_036_4317
    xor a, a
    ret

Func_036_42D3::
    ld a, [$D8A5]
    ld hl, $D812
    call Func_000_3F25
    bit 4, [hl]
    jr z, Jump_036_4315
    ld a, [$CFF4]
    bit 0, a
    jr z, Jump_036_4315
    inc hl
    ld a, [hl]
    swap a
    and a, $0F
    ld c, a
    call Func_036_7F3C
    jr c, Jump_036_4315
    ld a, [$D8A5]
    ld [$DAD1], a
    ld a, [$D8A4]
    ld hl, $DA1D
    call Func_036_7E65
    ld [hl], c
    ld a, c
    ld [$D8A5], a
    ld a, $01
    ld [$C981], a
    ld hl, $DABF
    set 1, [hl]
    ld d, $CA
    xor a, a
    ret

Jump_036_4315::
    scf
    ret

Jump_036_4317::
    ld hl, Data_036_7193
    ld b, $3A
    rst $10
    scf
    ret

Jump_036_431F::
    ld hl, $CFCB
    inc [hl]
    ld a, [$DABD]
    or a, a
    jr z, Jump_036_4356
    ld a, [$DAB2]
    or a, a
    jr nz, Jump_036_4356
    call Func_036_433F
    ret z
    ld a, $82
    ld [$DAD2], a
    ld hl, Func_036_4001
    ld b, $3A
    rst $10
    ret

Func_036_433F::
    ld a, [$D8A6]
    cp a, $91
    jr z, Jump_036_4347
    ret

Jump_036_4347::
    ld a, [$D8A4]
    ld hl, $D80F
    call Func_000_3F25
    ld a, [hl]
    and a, $40
    xor a, $40
    ret

Jump_036_4356::
    ld hl, $CFCB
    inc [hl]
    ld a, [$D8A5]
    call Func_036_7F3C
    jr c, Jump_036_438A
    ld a, [$CFF4]
    bit 6, a
    jr z, Jump_036_438A
    ld a, [$D8A5]
    ld hl, $D854
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_036_4375
    inc h

Jump_036_4375::
    bit 7, [hl]
    jr z, Jump_036_438A
    ld d, $35
    ld hl, $6EE5
    ld b, $3A
    rst $10
    call Func_036_4FD1
    ld a, $84
    call Func_000_1278
    ret

Jump_036_438A::
    call Func_036_454F
    jr z, Jump_036_439B
    ld a, [$D8A5]
    call Func_000_3E54
    jr nc, Jump_036_439B
    call Func_036_5009
    ret

Jump_036_439B::
    ld hl, $CFCB
    inc [hl]
    call Func_036_4582
    ret z
    ld a, [$CFF4]
    bit 1, a
    jr z, Jump_036_43D8
    ld a, [$D8A6]
    cp a, $CC
    jr nz, Jump_036_43BF
    ld a, [$D8A4]
    ld hl, $D810
    call Func_000_3F25
    ld a, [hl]
    and a, $0C
    jr z, Jump_036_43D8

Jump_036_43BF::
    ld a, [$D8A5]
    ld hl, $D811
    call Func_000_3F25
    ld a, [hl]
    and a, $C0
    jr z, Jump_036_43D8
    ld d, $66
    ld hl, Data_036_7193
    ld b, $3A
    rst $10
    jp Jump_036_4543

Jump_036_43D8::
    ld a, [$CFF3]
    bit 7, a
    jr z, Jump_036_4431
    ld a, [$D8A5]
    ld hl, $D810
    call Func_000_3F25
    ld a, [hl]
    and a, $0C
    jr z, Jump_036_4416
    cp a, $0C
    jr nz, Jump_036_4406
    ld a, [$D8A6]
    cp a, $CC
    jr nz, Jump_036_4406
    ld a, [$D8A4]
    ld hl, $D810
    call Func_000_3F25
    ld a, [hl]
    and a, $0C
    jr z, Jump_036_4416

Jump_036_4406::
    ld a, $84
    call Func_000_1278
    ld d, $68
    ld hl, Data_036_7193
    ld b, $3A
    rst $10
    jp Jump_036_4543

Jump_036_4416::
    ld a, [$D8A5]
    ld hl, $D80F
    call Func_000_3F25
    ld a, [hl]
    and a, $C0
    jr z, Jump_036_4431
    cp a, $C0
    jr nz, Jump_036_4406
    ld a, [$D8A6]
    cp a, $CC
    jr z, Jump_036_4431
    jr Jump_036_4406

Jump_036_4431::
    ld a, [$CFF3]
    bit 0, a
    jr z, Jump_036_447F
    ld a, [$D8A4]
    ld hl, $D80D
    call Func_000_3F25
    bit 1, [hl]
    jr z, Jump_036_4451
    call Func_000_3ED4
    ld a, [$C5E7]
    cp a, $A0
    jr nc, Jump_036_4451
    jr Jump_036_4469

Jump_036_4451::
    ld a, [$D8A4]
    ld hl, $D811
    call Func_000_3F25
    ld a, [hl]
    and a, $03
    jr z, Jump_036_447F
    call Func_000_3ED4
    ld a, [$C5E7]
    cp a, $60
    jr nc, Jump_036_447F

Jump_036_4469::
    ld a, [$D8A4]
    ld hl, $D854
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_036_4475
    inc h

Jump_036_4475::
    bit 2, [hl]
    jr nz, Jump_036_447F
    call Func_036_4FBC
    jp Jump_036_4543

Jump_036_447F::
    ld a, [$CFF4]
    bit 6, a
    jp z, Jump_036_4542
    ld a, [$D8A5]
    ld hl, $D80C
    call Func_000_3F25
    ld a, [hl]
    and a, $D0
    jp nz, Jump_036_4542
    ld bc, $0004
    add hl, bc
    ld a, [hl]
    and a, $03
    jp nz, Jump_036_4542
    inc hl
    ld a, [hl]
    and a, $30
    jp nz, Jump_036_4542
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and a, $03
    jp nz, Jump_036_4542
    call Func_000_3ED4
    ld a, [$D8A5]
    ld hl, $D811
    call Func_000_3F25
    ld a, [hl]
    and a, $0C
    jr z, Jump_036_44C8
    ld a, [$C5E7]
    and a, $01
    jr z, Jump_036_4533

Jump_036_44C8::
    ld a, [$D8A4]
    ld hl, $D91F
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_036_44D4
    inc h

Jump_036_44D4::
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld a, [$D8A5]
    ld hl, $D91F
    call Func_036_7E5B
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    jr c, Jump_036_452B
    or a, l
    jr z, Jump_036_452B
    ld bc, $0320
    call Func_000_3E7A
    jr nc, Jump_036_4517
    ld bc, $0258
    call Func_000_3E7A
    jr nc, Jump_036_451B
    ld bc, $0190
    call Func_000_3E7A
    jr nc, Jump_036_451F
    ld bc, $00C8
    call Func_000_3E7A
    jr nc, Jump_036_4523
    ld bc, $0064
    call Func_000_3E7A
    jr nc, Jump_036_4527
    ld b, $02
    jr Jump_036_452D

Jump_036_4517::
    ld b, $80
    jr Jump_036_452D

Jump_036_451B::
    ld b, $20
    jr Jump_036_452D

Jump_036_451F::
    ld b, $10
    jr Jump_036_452D

Jump_036_4523::
    ld b, $08
    jr Jump_036_452D

Jump_036_4527::
    ld b, $04
    jr Jump_036_452D

Jump_036_452B::
    ld b, $01

Jump_036_452D::
    ld a, [$C5E7]
    cp a, b
    jr nc, Jump_036_4542

Jump_036_4533::
    ld d, $D2
    ld hl, Data_036_7193
    ld b, $3A
    rst $10
    ld a, $84
    call Func_000_1278
    jr Jump_036_4543

Jump_036_4542::
    ret

Jump_036_4543::
    ld a, [$DAC0]
    res 4, a
    ld [$DAC0], a
    call Func_036_4FD1
    ret

Func_036_454F::
    ld a, [$D8A6]
    cp a, $35
    ret z
    cp a, $16
    ret z
    cp a, $17
    ret z
    cp a, $18
    ret z
    cp a, $1B
    ret z
    cp a, $1C
    ret z
    cp a, $1D
    ret z
    cp a, $1E
    ret z
    cp a, $1F
    ret z
    cp a, $20
    ret z
    cp a, $7B
    ret z
    cp a, $98
    ret z
    cp a, $9A
    ret z
    cp a, $9D
    ret z
    cp a, $BB
    ret z
    cp a, $CE
    ret

Func_036_4582::
    ld a, [$D8A6]
    cp a, $6A
    ret z
    cp a, $A0
    ret z
    cp a, $A1
    ret

Jump_036_458E::
    ld hl, $CFCB
    inc [hl]
    ld a, [$CFF4]
    and a, $18
    jr z, Jump_036_4603
    bit 4, a
    jr z, Jump_036_45AA
    ld a, [$D8A4]
    ld hl, $D80D
    call Func_000_3F25
    bit 2, [hl]
    jr nz, Jump_036_4603

Jump_036_45AA::
    ld a, [$CFF4]
    bit 3, a
    jr z, Jump_036_45F7
    ld a, [$D8A4]
    ld hl, $D854
    call Func_036_7E65
    bit 0, [hl]
    jr nz, Jump_036_45D3
    ld a, [$D8A4]
    ld hl, $D80D
    call Func_000_3F25
    bit 3, [hl]
    jr nz, Jump_036_45D3
    call Func_000_3ED4
    call Func_036_4918
    jr nc, Jump_036_45F7

Jump_036_45D3::
    ld a, [$D8A4]
    ld hl, $D80E
    call Func_000_3F25
    set 7, [hl]
    call Func_036_7E6C
    ld d, $9C
    jr c, Jump_036_45E7
    ld d, $9D

Jump_036_45E7::
    ld hl, Data_036_7193
    ld b, $3A
    rst $10
    ld a, $83
    call Func_000_1278
    ld hl, $CFCB
    inc [hl]
    ret

Jump_036_45F7::
    ld a, [$D8A4]
    ld hl, $D80E
    call Func_000_3F25
    res 7, [hl]
    ret

Jump_036_4603::
    ld hl, $CFCB
    inc [hl]
    call Func_036_6717
    ret

Jump_036_460B::
    ld a, [$D8A4]
    ld hl, $D80E
    call Func_000_3F25
    bit 7, [hl]
    jr z, Jump_036_4622
    ld a, [$DC00]
    ld hl, $DC20
    and a, [hl]
    cp a, $FF
    ret nz

Jump_036_4622::
    ld hl, $CFCB
    inc [hl]
    ld a, [$CFF4]
    bit 4, a
    jr z, Jump_036_464D
    ld a, [$D8A4]
    ld hl, $D80D
    call Func_000_3F25
    bit 2, [hl]
    jr z, Jump_036_464D
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    add hl, hl
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    jr Jump_036_46C7

Jump_036_464D::
    ld a, [$CFF4]
    bit 3, a
    jr z, Jump_036_4679
    ld a, [$D8A4]
    ld hl, $D80E
    call Func_000_3F25
    bit 7, [hl]
    jr z, Jump_036_4679
    res 7, [hl]
    call Func_036_7C85
    ld a, [$D8A4]
    call Func_036_7E2E
    call Func_036_4930
    ld a, e
    ld [$D872], a
    ld a, d
    ld [$D873], a
    jr Jump_036_46EB

Jump_036_4679::
    ld a, [$CFF4]
    bit 5, a
    jr z, Jump_036_46A0
    ld a, [$D8A4]
    ld hl, $D810
    call Func_000_3F25
    bit 0, [hl]
    jr z, Jump_036_46A0
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    add hl, hl
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    jr Jump_036_46C7

Jump_036_46A0::
    ld a, [$CFF3]
    bit 1, a
    jr z, Jump_036_46C7
    ld a, [$D8A4]
    ld hl, $D810
    call Func_000_3F25
    bit 4, [hl]
    jr z, Jump_036_46C7
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    call Func_036_494E
    ld a, e
    ld [$D872], a
    ld a, d
    ld [$D873], a

Jump_036_46C7::
    ld a, [$D8A4]
    ld hl, $D854
    call Func_036_7E65
    bit 6, [hl]
    jr z, Jump_036_46EB
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    ld c, l
    ld b, h
    srl b
    rr c
    add hl, bc
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a

Jump_036_46EB::
    ld a, [$D8A5]
    ld hl, $D813
    call Func_000_3F25
    ld a, [hl]
    and a, $07
    jr z, Jump_036_4742
    and a, $03
    ld c, a
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    jr nz, Jump_036_4713
    ld a, [$CFF3]
    bit 7, a
    jr z, Jump_036_4742

Jump_036_470D::
    srl h
    rr l
    jr Jump_036_4723

Jump_036_4713::
    ld a, [$CFF4]
    bit 7, a
    jr z, Jump_036_4742
    bit 0, c
    jr nz, Jump_036_470D
    ld a, $0A
    call Func_000_16D1

Jump_036_4723::
    ld a, [$D8A5]
    ld de, $D854
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_036_472F
    inc d

Jump_036_472F::
    ld a, [de]
    bit 1, a
    jr z, Jump_036_4738
    srl h
    rr l

Jump_036_4738::
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    jr Jump_036_4742

Jump_036_4742::
    ld a, [$D8A5]
    ld hl, $D812
    call Func_000_3F25
    bit 2, [hl]
    jr z, Jump_036_4775
    ld a, [$CFF3]
    bit 7, a
    jr z, Jump_036_4775
    ld a, [$D8A6]
    cp a, $6F
    jr z, Jump_036_4775
    cp a, $70
    jr z, Jump_036_4775
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    sla l
    rl h
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a

Jump_036_4775::
    ret

Jump_036_4776::
    ld a, [$D8A6]
    cp a, $CD
    jr nz, Jump_036_4787
    ld a, [$DC00]
    ld hl, $DC20
    and a, [hl]
    cp a, $FF
    ret nz

Jump_036_4787::
    ld hl, $CFCB
    inc [hl]
    ld hl, $CFCB
    inc [hl]
    ld a, [$DAC0]
    ld b, a
    bit 5, a
    jr z, Jump_036_47B1
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    ld a, h
    or a, l
    jr z, Jump_036_47A9
    set 4, b
    res 6, b
    jr Jump_036_47AD

Jump_036_47A9::
    res 4, b
    set 6, b

Jump_036_47AD::
    ld a, b
    ld [$DAC0], a

Jump_036_47B1::
    ld a, [$D8A6]
    cp a, $CF
    jr nz, Jump_036_47C7
    ld a, [$DAC0]
    bit 4, a
    ret z
    ld hl, $CFCB
    dec [hl]
    ld a, [$DABA]
    or a, a
    ret nz

Jump_036_47C7::
    ld b, $40
    ld a, [$DAC0]
    bit 4, a
    jr z, Jump_036_47D6
    bit 6, a
    jr nz, Jump_036_47D6
    set 0, b

Jump_036_47D6::
    ld a, b
    ld [$DAD2], a
    ld hl, Func_036_4001
    ld b, $3A
    rst $10
    ld a, [$DAC0]
    and a, $10
    or a, $20
    ld [$DAD3], a
    ld hl, $5762
    ld b, $3A
    rst $10
    ret

Jump_036_47F1::
    ld hl, $CFCB
    inc [hl]
    ld a, $13
    ld [$DAD2], a
    ld hl, Func_036_4001
    ld b, $3A
    rst $10
    ld a, $85
    call Func_000_1278
    ret

Jump_036_4806::
    ld hl, $CFCB
    inc [hl]
    ld a, [$DAC0]
    bit 7, a
    jr z, Jump_036_484E
    bit 4, a
    jr z, Jump_036_4825
    ld a, [$DAC2]
    ld [$C0A0], a
    ld a, [$DAC0]
    bit 3, a
    call nz, Func_036_4991
    jr Jump_036_4833

Jump_036_4825::
    ld a, [$DAC3]
    ld [$C0A0], a
    ld a, [$DAC1]
    bit 3, a
    call nz, Func_036_4A38

Jump_036_4833::
    ld a, [$D8A6]
    cp a, $DC
    jr z, Jump_036_484E
    cp a, $D7
    jr nz, Jump_036_4844
    ld hl, $67AA
    ld b, $32
    rst $10

Jump_036_4844::
    ld a, [$C0A0]
    ld d, a
    ld hl, Data_036_7193
    ld b, $3A
    rst $10

Jump_036_484E::
    call Func_036_4961
    ld a, [$DAC0]
    bit 4, a
    jr nz, Jump_036_4859
    ret

Jump_036_4859::
    ld a, [$D8A6]
    cp a, $3A
    jr z, Jump_036_4879
    cp a, $3B
    jr z, Jump_036_4890
    cp a, $B8
    jr z, Jump_036_4890
    cp a, $32
    jr z, Jump_036_48AE
    cp a, $77
    jr z, Jump_036_48AE
    cp a, $DC
    jr z, Jump_036_48B5
    cp a, $DF
    jr z, Jump_036_48A3
    ret

Jump_036_4879::
    ld a, [$D8A5]
    add a, a
    ld de, $D958
    add a, e
    ld e, a
    jr nc, Jump_036_4885
    inc d

Jump_036_4885::
    ld a, [$D8A4]
    ld b, a
    call Func_036_4E26
    call Func_036_70F4
    ret

Jump_036_4890::
    ld de, $C0A0
    ld a, $60
    ld [de], a
    inc de
    ld a, $01
    ld [de], a
    dec de
    ld a, [$D8A4]
    ld b, a
    call Func_036_4E26
    ret

Jump_036_48A3::
    ld hl, $414F
    ld b, $A3
    rst $10
    ldh a, [$FFC6]
    call Func_036_7ECB

Jump_036_48AE::
    ld a, [$D8A4]
    call Func_036_7ECB
    ret

Jump_036_48B5::
    ld a, [$D8A4]
    push af
    ld hl, $414F
    ld b, $A3
    rst $10
    ldh a, [$FFC6]
    ld [$D8A4], a
    call Func_036_48CB
    pop af
    ld [$D8A4], a

Func_036_48CB::
    ld de, $C0A0
    ld a, $61
    ld [de], a
    inc de
    ld a, $01
    ld [de], a
    dec de
    ld a, [$D8A4]
    ld b, a
    call Func_036_4E26
    ret

Jump_036_48DE::
    ld a, [$D8A6]
    cp a, $82
    jp z, Jump_036_4A9D
    cp a, $83
    jp z, Jump_036_4B16
    cp a, $84
    jp z, Jump_036_4B16
    cp a, $B3
    jp z, Jump_036_4B16
    ld hl, $CFCB
    inc [hl]
    ret

Jump_036_48FA::
    ld hl, Data_036_59DF
    ld b, $32
    rst $10
    ret

Jump_036_4901::
    ld hl, Data_036_5A3A
    ld b, $32
    rst $10
    ret

Jump_036_4908::
    ld hl, Data_036_5EAB
    ld b, $32
    rst $10
    ret

Jump_036_490F::
    ld hl, $CFCA
    inc [hl]
    xor a, a
    ld [$CFCB], a
    ret

Func_036_4918::
    push bc
    push hl
    ld hl, $49D5
    ld b, $A3
    rst $10
    pop hl
    pop bc
    ldh a, [$FFC6]
    ld b, a
    cp a, $03
    jr nz, Jump_036_492B
    ld b, $04

Jump_036_492B::
    ld a, [$C5E7]
    cp a, b
    ret

Func_036_4930::
    push hl
    ld bc, $0014
    call Func_000_3F04
    ld e, l
    ld d, h
    pop bc
    push bc
    add hl, bc
    ld c, l
    ld b, h
    pop hl
    ld a, e
    cpl
    add a, $01
    ld e, a
    ld a, d
    cpl
    adc a, $00
    ld d, a
    add hl, de
    call Func_000_3E98
    ret

Func_036_494E::
    ld c, l
    ld b, h
    srl b
    rr c
    sla l
    rl h
    push hl
    add hl, bc
    ld c, l
    ld b, h
    pop hl
    call Func_000_3E98
    ret

Func_036_4961::
    ld a, [$DAC0]
    bit 4, a
    ret nz
    ld a, [$DABD]
    or a, a
    ret nz
    call Func_036_5009
    ld a, [$DABF]
    or a, a
    ret z
    ld a, [$DAD1]
    cp a, $FF
    ret z
    ld [$D8A5], a
    ld b, a
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_036_498A
    inc h

Jump_036_498A::
    ld [hl], b
    ld a, $FF
    ld [$DAD1], a
    ret

Func_036_4991::
    ld a, [$D8A6]
    cp a, $6C
    jr nz, Jump_036_49A1

Jump_036_4998::
    call Func_036_7E87
    ret nc
    ld hl, $C0A0
    inc [hl]
    ret

Jump_036_49A1::
    ld a, [$DABF]
    bit 0, a
    jr nz, Jump_036_4998
    call Func_036_7E6C
    ret c
    ld a, [$D8A6]
    cp a, $34
    jr z, Jump_036_49FC
    cp a, $AD
    jr z, Jump_036_49FC
    cp a, $78
    jr z, Jump_036_49FC
    cp a, $13
    jr z, Jump_036_4A01
    cp a, $14
    jr z, Jump_036_4A01
    cp a, $15
    jr z, Jump_036_4A13
    cp a, $2B
    jr z, Jump_036_4A23
    cp a, $2C
    jr z, Jump_036_4A23
    cp a, $79
    jr z, Jump_036_4A01
    cp a, $80
    jr z, Jump_036_4A07
    cp a, $92
    jr z, Jump_036_4A0D
    cp a, $B5
    jr z, Jump_036_4A29
    cp a, $BA
    jr z, Jump_036_4A32
    cp a, $BF
    jr z, Jump_036_49FC
    cp a, $C0
    jr z, Jump_036_49FC
    cp a, $C9
    jr z, Jump_036_49FC
    cp a, $CA
    jr z, Jump_036_49FC
    cp a, $CB
    jr z, Jump_036_49FC

Jump_036_49F7::
    ld hl, $C0A0
    inc [hl]
    ret

Jump_036_49FC::
    ld hl, $C0A0
    dec [hl]
    ret

Jump_036_4A01::
    ld a, $8A
    ld [$C0A0], a
    ret

Jump_036_4A07::
    ld a, $56
    ld [$C0A0], a
    ret

Jump_036_4A0D::
    ld a, $63
    ld [$C0A0], a
    ret

Jump_036_4A13::
    ld hl, $D872
    ld a, [hl+]
    sub a, $E8
    ld a, [hl]
    sbc a, $03
    jr z, Jump_036_4A01
    ld hl, $C0A0
    inc [hl]
    ret

Jump_036_4A23::
    ld a, $CD
    ld [$C0A0], a
    ret

Jump_036_4A29::
    ld a, [$DAC2]
    cp a, $73
    jr z, Jump_036_49F7
    jr Jump_036_49FC

Jump_036_4A32::
    ld a, $78
    ld [$C0A0], a
    ret

Func_036_4A38::
    call Func_036_7E6C
    ret c
    ld a, [$D8A6]
    cp a, $72
    jr z, Jump_036_4A74
    cp a, $73
    jr z, Jump_036_4A74
    cp a, $74
    jr z, Jump_036_4A74
    cp a, $75
    jr z, Jump_036_4A7A
    cp a, $7E
    jr z, Jump_036_4A80
    cp a, $7F
    jr z, Jump_036_4A86
    cp a, $80
    jr z, Jump_036_4A8C
    cp a, $8B
    jr z, Jump_036_4A8C
    cp a, $8C
    jr z, Jump_036_4A8C
    cp a, $8F
    jr z, Jump_036_4A92
    cp a, $AA
    jr z, Jump_036_4A92
    cp a, $C0
    jr z, Jump_036_4A98
    ld hl, $C0A0
    inc [hl]
    ret

Jump_036_4A74::
    ld a, $6A
    ld [$C0A0], a
    ret

Jump_036_4A7A::
    ld a, $6B
    ld [$C0A0], a
    ret

Jump_036_4A80::
    ld a, $6C
    ld [$C0A0], a
    ret

Jump_036_4A86::
    ld a, $6D
    ld [$C0A0], a
    ret

Jump_036_4A8C::
    ld a, $6E
    ld [$C0A0], a
    ret

Jump_036_4A92::
    ld a, $71
    ld [$C0A0], a
    ret

Jump_036_4A98::
    ld hl, $C0A0
    dec [hl]
    ret

Jump_036_4A9D::
    ld a, [$DC00]
    ld hl, $DC20
    and a, [hl]
    cp a, $FF
    ret nz
    ld a, [$CFCC]
    or a, a
    jr z, Jump_036_4AE5
    ld hl, $CFCA
    inc [hl]
    xor a, a
    ld [$CFCB], a
    xor a, a
    ld [$CFCC], a
    call Func_036_6E75
    ld a, [$CFCA]
    cp a, $05
    ret z
    ld a, [$DAC0]
    bit 4, a
    ld a, $99
    call nz, Func_000_1278
    ld a, [$DAC3]
    ld d, a
    ld a, [$DAC0]
    bit 4, a
    jr z, Jump_036_4AE1
    ld a, [$DAC2]
    ld d, a
    ld hl, Data_036_7193
    ld b, $3A
    rst $10

Jump_036_4AE1::
    call Func_036_4961
    ret

Jump_036_4AE5::
    call Func_036_6E40
    ld a, [$DAC0]
    bit 4, a
    ld a, $87
    call nz, Func_000_1278
    ld a, [$DAC0]
    bit 4, a
    jr z, Jump_036_4B06
    ld a, [$DAC2]
    ld d, a
    call Func_036_7E6C
    jr c, Jump_036_4B0A
    ld d, $CD
    jr Jump_036_4B0A

Jump_036_4B06::
    ld a, [$DAC3]
    ld d, a

Jump_036_4B0A::
    ld hl, Data_036_7193
    ld b, $3A
    rst $10
    ld a, $01
    ld [$CFCC], a
    ret

Jump_036_4B16::
    ld a, [$CFCC]
    rst $00
    dw Jump_036_4B26
    dw Jump_036_4B41
    dw Jump_036_4D42
    dw Jump_036_4D7F
    dw Jump_036_4DD6
    dw Jump_036_4DF3

Jump_036_4B26::
    ld hl, $CFCC
    inc [hl]
    ld a, [$D8A5]
    ld hl, $D80E
    call Func_000_3F25
    bit 6, [hl]
    ret z
    res 6, [hl]
    ld d, $80
    ld hl, Data_036_7193
    ld b, $3A
    rst $10
    ret

Jump_036_4B41::
    ld hl, $CFCC
    inc [hl]
    ld hl, $CFCC
    inc [hl]
    ld a, [$D8A5]
    ld hl, $D80D
    call Func_000_3F25
    ld a, [hl]
    and a, $30
    jp z, Jump_036_4CCF
    ld a, [hl]
    and a, $CF
    ld [hl], a
    ld hl, $CFCC
    dec [hl]
    ld d, $5F
    ld hl, Data_036_7193
    ld b, $3A
    rst $10
    push hl
    ld hl, $4A02
    ld b, $A3
    rst $10
    ld a, [$D8A5]
    ld hl, $DAD8
    add a, l
    ld l, a
    jr nc, Jump_036_4B7A
    inc h

Jump_036_4B7A::
    ld a, [hl]
    and a, $F8
    ld [hl], a
    pop hl
    ld a, $01
    ld [$D868], a
    ld a, [$D8A5]
    ld c, a
    ld hl, $434D
    ld b, $19
    rst $10
    call Func_036_4D0C
    ld a, [$D8A5]
    ld c, a
    ld hl, Func_036_4001
    ld b, $3B
    rst $10
    ld a, [$DAC4]
    ld c, a
    ld a, [$DAC5]
    ld b, a
    ld a, [$D8A5]
    ld hl, $D8CF
    call Func_036_7E65
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [$D8A5]
    call Func_036_7E42
    call Func_000_3E7A
    jr c, Jump_036_4BCC
    ld a, [$D8A5]
    call Func_036_7EBE
    ld a, [$D8A5]
    ld hl, $D8BF
    call Func_036_7E65
    ld [hl], c
    inc hl
    ld [hl], b

Jump_036_4BCC::
    ld a, [$D8A5]
    ld c, a
    ld hl, $4045
    ld b, $3B
    rst $10
    ld a, [$DAC4]
    ld c, a
    ld a, [$DAC5]
    ld b, a
    ld a, [$D8A5]
    ld hl, $D8EF
    call Func_036_7E65
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [$D8A5]
    call Func_036_7E47
    call Func_000_3E7A
    jr c, Jump_036_4C07
    ld a, [$D8A5]
    call Func_036_7ECB
    ld a, [$D8A5]
    ld hl, $D8DF
    call Func_036_7E65
    ld [hl], c
    inc hl
    ld [hl], b

Jump_036_4C07::
    ld a, [$D8A5]
    ld c, a
    ld hl, $4089
    ld b, $3B
    rst $10
    ld a, [$DAC4]
    ld c, a
    ld a, [$DAC5]
    ld b, a
    ld a, [$D8A5]
    ld hl, $D8FF
    call Func_036_7E65
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [$D8A5]
    ld c, a
    ld hl, $4155
    ld b, $3B
    rst $10
    ld a, [$DAC4]
    ld c, a
    ld a, [$DAC5]
    ld b, a
    ld a, [$D8A5]
    ld hl, $D92F
    call Func_036_7E65
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [$D8A5]
    ld c, a
    ld hl, $4298
    ld b, $19
    rst $10
    ld a, [$D8A5]
    ld c, a
    ld hl, $4199
    ld b, $3B
    rst $10
    ld a, [$DAC4]
    ld c, a
    ld a, [$D8A5]
    ld hl, $D8B7
    add a, l
    ld l, a
    jr nc, Jump_036_4C66
    inc h

Jump_036_4C66::
    ld [hl], c
    ld a, [$D8A5]
    ld c, a
    ld hl, $41D3
    ld b, $3B
    rst $10
    ld a, [$DAC4]
    ld c, a
    ld a, [$D8A5]
    ld hl, $D968
    add a, l
    ld l, a
    jr nc, Jump_036_4C80
    inc h

Jump_036_4C80::
    ld [hl], c
    ld a, [$D8A5]
    ld c, a
    ld hl, $420D
    ld b, $3B
    rst $10
    ld a, [$DAC4]
    ld c, a
    ld a, [$D8A5]
    ld hl, $D970
    add a, l
    ld l, a
    jr nc, Jump_036_4C9A
    inc h

Jump_036_4C9A::
    ld [hl], c
    ld a, [$D8A5]
    ld c, a
    ld hl, $4247
    ld b, $3B
    rst $10
    ld a, [$DAC4]
    ld c, a
    ld a, [$D8A5]
    ld hl, $D978
    add a, l
    ld l, a
    jr nc, Jump_036_4CB4
    inc h

Jump_036_4CB4::
    ld [hl], c
    ld a, [$D8A5]
    ld c, a
    ld hl, $4281
    ld b, $3B
    rst $10
    ld a, [$DAC4]
    ld c, a
    ld a, [$D8A5]
    ld hl, $D980
    add a, l
    ld l, a
    jr nc, Jump_036_4CCE
    inc h

Jump_036_4CCE::
    ld [hl], c

Jump_036_4CCF::
    ld a, [$D8A5]
    ld c, a
    ld hl, $4111
    ld b, $3B
    rst $10
    ld a, [$DAC4]
    ld c, a
    ld a, [$DAC5]
    ld b, a
    ld a, [$D8A5]
    ld hl, $D91F
    call Func_036_7E65
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [$D8A5]
    ld c, a
    ld hl, $40CD
    ld b, $3B
    rst $10
    ld a, [$DAC4]
    ld c, a
    ld a, [$DAC5]
    ld b, a
    ld a, [$D8A5]
    ld hl, $D90F
    call Func_036_7E65
    ld [hl], c
    inc hl
    ld [hl], b
    ret

Func_036_4D0C::
    ld a, [$D8A5]
    ld b, a
    and a, $03
    cp a, $03
    ret z
    ld a, b
    ld e, $31
    call Func_000_3F32
    ld a, l
    ld [$D868], a
    ld a, h
    ld [$D869], a
    ld a, [$D8A5]
    ld de, $DA72
    ld b, a
    add a, a
    add a, b
    add a, a
    add a, b
    add a, e
    ld e, a
    jr nc, Jump_036_4D33
    inc d

Jump_036_4D33::
    ld a, e
    ld [$D86A], a
    ld a, d
    ld [$D86B], a
    ld hl, $44B9
    ld b, $19
    rst $10
    ret

Jump_036_4D42::
    ld hl, $CFCC
    inc [hl]
    ld a, [$D8A5]
    ld b, a
    add a, a
    ld de, $D958
    add a, e
    ld e, a
    jr nc, Jump_036_4D53
    inc d

Jump_036_4D53::
    call Func_036_4E26
    ld a, [$D8A5]
    ld hl, $DA5B
    add a, l
    ld l, a
    jr nc, Jump_036_4D61
    inc h

Jump_036_4D61::
    ld [hl], $03
    ld a, [$C58A]
    cp a, $01
    ret z
    ld a, [$D8A5]
    cp a, $04
    ret c
    and a, $03
    cp a, $03
    ret z
    ld hl, $DAD4
    add a, l
    ld l, a
    jr nc, Jump_036_4D7C
    inc h

Jump_036_4D7C::
    ld [hl], $FF
    ret

Jump_036_4D7F::
    ld hl, $CFCC
    inc [hl]
    ld a, [$D8A5]
    and a, $03
    cp a, $03
    ret nz
    ld a, [$D8A5]
    call Func_000_3E54
    ret c
    ld d, $7F
    ld hl, Data_036_7193
    ld b, $3A
    rst $10
    ld a, [$D8A5]
    ld hl, $DA63
    add a, l
    ld l, a
    jr nc, Jump_036_4DA5
    inc h

Jump_036_4DA5::
    ld [hl], $FF
    ld a, [$D8A5]
    ld hl, $DA5B
    add a, l
    ld l, a
    jr nc, Jump_036_4DB2
    inc h

Jump_036_4DB2::
    ld [hl], $FF
    ld a, [$D8A5]
    ld hl, $D80C
    call Func_000_3F25
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ld a, [$D8A5]
    and a, $04
    rrca
    rrca
    and a, $01
    ld hl, $D80A
    res 2, [hl]
    ret

Jump_036_4DD6::
    ld hl, $CFCC
    inc [hl]
    ld a, [$D8A5]
    ld hl, $D814
    call Func_000_3F25
    bit 4, [hl]
    ret z
    res 4, [hl]
    ld a, $FF
    ld [$DAAC], a
    ld a, $FF
    ld [$DAAD], a
    ret

Jump_036_4DF3::
    ld hl, $CFCA
    inc [hl]
    xor a, a
    ld [$CFCB], a
    xor a, a
    ld [$CFCC], a
    ld a, [$D80A]
    and a, $93
    ld [$D80A], a
    ld a, [$D80B]
    and a, $93
    ld [$D80B], a
    ld a, [$D8A6]
    cp a, $83
    ret z
    ld a, [$D80A]
    or a, $08
    ld [$D80A], a
    ld a, [$D80B]
    or a, $08
    ld [$D80B], a
    ret

Func_036_4E26::
    ld a, [$C58A]
    cp a, $01
    ld a, b
    jr nz, Jump_036_4E3C
    ld a, [$C57F]
    bit 1, a
    ld a, b
    jr z, Jump_036_4E3C
    cp a, $03
    jr nc, Jump_036_4EB0
    jr Jump_036_4E46

Jump_036_4E3C::
    cp a, $04
    jr c, Jump_036_4EB0
    cp a, $07
    jr z, Jump_036_4EB0
    sub a, $04

Jump_036_4E46::
    push de
    push af
    ld bc, $0240
    call Func_000_16AA
    ld bc, $9140
    add hl, bc
    pop af
    pop de
    sla a
    add a, $01
    ld c, a
    push bc
    ld a, [de]
    ld b, a
    inc de
    ld a, [de]
    ld d, a
    ld e, b
    push de
    call Func_000_1FE3
    pop de
    pop bc
    ld a, [$C525]
    or a, a
    ret z
    ld a, $7F
    ld [$C526], a
    ld a, c
    ldh [$FFC6], a
    ld a, [$C58A]
    cp a, $01
    ld a, [$D890]
    jr nz, Jump_036_4E8A
    ld a, [$C57F]
    bit 1, a
    ld a, [$C985]
    jr z, Jump_036_4E8A
    ld a, [$C984]

Jump_036_4E8A::
    cp a, $01
    jr z, Jump_036_4E97
    cp a, $03
    jr z, Jump_036_4E9C
    ld hl, $98E4
    jr Jump_036_4E9F

Jump_036_4E97::
    ld hl, $98E7
    jr Jump_036_4E9F

Jump_036_4E9C::
    ld hl, $98E1

Jump_036_4E9F::
    ld a, c
    sub a, $01
    srl a
    ld b, a
    add a, a
    add a, b
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_036_4EAD
    inc h

Jump_036_4EAD::
    call Func_000_2090

Jump_036_4EB0::
    ret

Func_036_4EB1::
    push de
    ld hl, $DAC9
    ld a, [$D8A4]
    ld [hl+], a
    ld a, [$D8A5]
    ld [hl+], a
    ld a, [$DABA]
    ld [hl+], a
    ld a, [$D8A4]
    ld de, $DA1C
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_036_4ECD
    inc d

Jump_036_4ECD::
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    ld a, [$D8A5]
    ld bc, $DA1C
    add a, a
    add a, c
    ld c, a
    jr nc, Jump_036_4EDE
    inc b

Jump_036_4EDE::
    ld a, [bc]
    ld [hl+], a
    inc bc
    ld a, [bc]
    ld [hl+], a
    ld a, [$D8A4]
    ld [bc], a
    dec bc
    dec de
    ld a, [de]
    ld [bc], a
    ld a, [$D8A4]
    ld l, a
    ld a, [$D8A5]
    ld h, a
    ld a, h
    ld [$D8A4], a
    ld a, l
    ld [$D8A5], a
    pop de
    bit 0, d
    jr nz, Jump_036_4F06
    bit 2, d
    jr nz, Jump_036_4F06
    jr Jump_036_4F06

Jump_036_4F06::
    ld a, [$DABD]
    or a, d
    ld [$DABD], a
    ret

Func_036_4F0E:: ; heuristic: follows a terminator; C0
    ld a, $03
    ld [$CFCA], a
    xor a, a
    ld [$CFCB], a
    ret

Func_036_4F18::
    ld a, [$D8A5]
    ld hl, $D854
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_036_4F24
    inc h

Jump_036_4F24::
    bit 5, [hl]
    jr z, Jump_036_4F2E
    ld a, [$C971]
    scf
    ccf
    ret

Jump_036_4F2E::
    call Func_000_3ED4
    ld a, [$C5E7]
    cp a, $33
    jp c, Jump_036_4FBA
    cp a, $66
    jr c, Jump_036_4F80
    ld a, $FF
    ld hl, $D86D
    ld bc, $0003
    call Func_000_0949
    ld a, [$D8A5]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld e, $00

Jump_036_4F54::
    ld a, c
    call Func_000_3E54
    jr c, Jump_036_4F65
    ld a, e
    ld hl, $D86D
    add a, l
    ld l, a
    jr nc, Jump_036_4F63
    inc h

Jump_036_4F63::
    ld [hl], c
    inc e

Jump_036_4F65::
    inc c
    dec b
    jr nz, Jump_036_4F54

Func_036_4F69::
    ld hl, $0000
    ld b, $00
    dec e
    ld c, e
    call Func_000_3E98
    ld a, e
    ld hl, $D86D
    add a, l
    ld l, a
    jr nc, Jump_036_4F7C
    inc h

Jump_036_4F7C::
    ld a, [hl]
    scf
    ccf
    ret

Jump_036_4F80::
    ld a, $FF
    ld hl, $D86D
    ld bc, $0003
    call Func_000_0949
    ld a, [$D8A5]
    ld d, a
    ld a, [$D8A5]
    and a, $04
    ld c, a
    ld b, $03
    ld e, $00

Jump_036_4F99::
    ld a, c
    cp a, d
    jr z, Jump_036_4FAE
    ld a, c
    call Func_000_3E54
    jr c, Jump_036_4FAE
    ld a, e
    ld hl, $D86D
    add a, l
    ld l, a
    jr nc, Jump_036_4FAC
    inc h

Jump_036_4FAC::
    ld [hl], c
    inc e

Jump_036_4FAE::
    inc c
    dec b
    jr nz, Jump_036_4F99
    ld a, e
    or a, a
    jr z, Jump_036_4FBA
    call Func_036_4F69
    ret

Jump_036_4FBA::
    scf
    ret

Func_036_4FBC::
    ld a, $84
    call Func_000_1278
    call Func_036_7E6C
    ld d, $D0
    jr c, Jump_036_4FCA
    ld d, $D1

Jump_036_4FCA::
    ld hl, Data_036_7193
    ld b, $3A
    rst $10
    ret

Func_036_4FD1::
    ld a, [$D8A6]
    cp a, $CC
    jr z, Jump_036_4FF3
    ld a, [$D8A6]
    cp a, $D0
    jr c, Jump_036_4FE9
    cp a, $E4
    jr nc, Jump_036_4FE9
    ld hl, $413F
    ld b, $A3
    rst $10

Jump_036_4FE9::
    ld a, $02
    ld [$CFCA], a
    xor a, a
    ld [$CFCB], a
    ret

Jump_036_4FF3::
    ld a, [$D8A4]
    ld hl, $D810
    call Func_000_3F25
    ld a, [hl]
    and a, $0C
    cp a, $04
    jr nz, Jump_036_4FE9
    ld a, [hl]
    and a, $F3
    ld [hl], a
    jr Jump_036_4FE9

Func_036_5009::
    ld a, $03
    ld [$CFCA], a
    xor a, a
    ld [$CFCB], a
    ret

Func_036_5013::
    call Func_000_3ED4
    ld a, [$D8A5]
    ld hl, $D90F
    call Func_036_7E65
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    call Func_036_650B

Func_036_5025::
    ld a, [$D8A4]
    call Func_036_7E2E
    call Func_000_3E7A
    jr z, Jump_036_504E
    jr c, Jump_036_504E
    ld a, l
    sub a, c
    ld e, a
    ld a, h
    sbc a, b
    ld d, a
    srl d
    rr e
    push hl
    push bc
    ld b, d
    ld c, e
    call Func_036_6510
    call Func_000_3E7A
    pop bc
    pop hl
    jr z, Jump_036_5059
    jr nc, Jump_036_5059
    jr Jump_036_5066

Jump_036_504E::
    ld hl, $0000
    ld bc, $0001
    call Func_000_3E98
    jr Jump_036_508B

Jump_036_5059::
    call Func_036_6510
    ld c, l
    ld b, h
    ld hl, $0000
    call Func_000_3E98
    jr Jump_036_508B

Jump_036_5066::
    ld l, e
    ld h, d
    push hl
    call Func_036_6510
    ld c, l
    ld b, h
    ld a, l
    cpl
    add a, $01
    ld l, a
    ld a, h
    cpl
    adc a, $00
    ld h, a
    call Func_000_3E98
    pop hl
    add hl, de
    push hl
    ld hl, $FFFF
    ld bc, $0001
    call Func_000_3E98
    pop hl
    add hl, de
    ld e, l
    ld d, h

Jump_036_508B::
    ld a, e
    ld [$D872], a
    ld a, d
    ld [$D873], a
    ret

Func_036_5094:: ; heuristic: follows a terminator; C0
    call Func_036_6159
    ld a, $00
    call Func_036_621C
    ret

Func_036_509D:: ; heuristic: follows a terminator; C0
    call Func_036_5A6C
    call Func_036_6594
    cp a, $00
    jr z, Jump_036_50AE
    cp a, $08
    jr z, Jump_036_50AE
    cp a, $09
    ret nz

Jump_036_50AE::
    call Func_036_6451
    ret

Func_036_50B2:: ; heuristic: follows a terminator; C0
    call Func_036_5A6C
    call Func_036_6594
    cp a, $01
    jr z, Jump_036_50C3
    cp a, $03
    jr z, Jump_036_50C3
    cp a, $06
    ret nz

Jump_036_50C3::
    call Func_036_6451
    ret

Func_036_50C7:: ; heuristic: follows a terminator; C0
    call Func_036_5A6C
    call Func_036_6594
    cp a, $02
    jr z, Jump_036_50D8
    cp a, $05
    jr z, Jump_036_50D8
    cp a, $04
    ret nz

Jump_036_50D8::
    call Func_036_6451
    ret

Func_036_50DC:: ; heuristic: follows a terminator; C0
    ld a, [$D8A4]
    push af
    call Func_000_3ED4
    ld bc, $0000
    call Func_036_5025
    ld a, [$D872]
    ld e, a
    ld a, [$D873]
    ld d, a
    push de
    ld hl, $414F
    ld b, $A3
    rst $10
    ldh a, [$FFC6]
    ld [$D8A4], a
    call Func_000_3ED4
    ld bc, $0000
    call Func_036_5025
    pop de
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    add hl, de
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    pop af
    ld [$D8A4], a
    ret

Func_036_511D:: ; heuristic: follows a terminator; C0
    ld a, [$D8A4]
    push af
    call Func_036_5013
    ld a, [$D872]
    ld e, a
    ld a, [$D873]
    ld d, a
    push de
    ld hl, $414F
    ld b, $A3
    rst $10
    ldh a, [$FFC6]
    ld [$D8A4], a
    call Func_036_5013
    pop de
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    add hl, de
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    pop af
    ld [$D8A4], a
    ret
    INCBIN "dwm2-cobi-us.gbc", $0D9152, $7F

Func_036_51D1::
    call Func_036_6159
    call Func_036_61A6
    swap a
    and a, $03
    call Func_036_621C
    ret

Func_036_51DF::
    call Func_036_6159
    call Func_036_61A6
    rrca
    rrca
    and a, $03
    call Func_036_621C
    ret

Func_036_51ED::
    call Func_036_6159
    call Func_036_61A6
    and a, $03
    call Func_036_621C
    ret

Func_036_51F9::
    call Func_036_6159

Func_036_51FC::
    call Func_036_61AB
    rlca
    rlca
    and a, $03
    call Func_036_621C
    ret

Func_036_5207::
    call Func_036_6159
    call Func_036_61AB
    swap a
    and a, $03
    call Func_036_621C
    ret

Func_036_5215::
    call Func_036_6159
    call Func_036_61AB
    rrca
    rrca
    and a, $03
    call Func_036_621C
    ret

Func_036_5223::
    ld a, [$D8A6]
    cp a, $18
    jp z, Jump_036_52CC
    cp a, $1A
    jp z, Jump_036_52CC
    cp a, $20
    jr z, Jump_036_5251
    cp a, $B1
    jr z, Jump_036_5251
    cp a, $7B
    jr z, Jump_036_5251
    cp a, $CF
    jr z, Jump_036_528B
    cp a, $DA
    jr z, Jump_036_5251

Jump_036_5244::
    call Func_036_6159
    ld a, [$D872]
    ld e, a
    ld a, [$D873]
    ld d, a
    jr Jump_036_5265

Jump_036_5251::
    ld a, [$D8A5]
    ld hl, $D8CF
    call Func_036_7E65
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld a, e
    ld [$D872], a
    ld a, d
    ld [$D873], a

Jump_036_5265::
    ld a, [$D8A5]
    ld hl, $D8BF
    call Func_036_7E65
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
    call Func_036_7E38
    call Func_000_3E7A
    jr nc, Jump_036_5285
    ld b, h
    ld c, l

Jump_036_5285::
    pop hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    scf
    ret

Jump_036_528B::
    ld a, [$D8A5]
    ld hl, $D8CF
    call Func_036_7E65
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld a, e
    ld [$D872], a
    ld a, d
    ld [$D873], a
    ld a, [$D8A4]
    ld hl, $DAFA
    add a, l
    ld l, a
    jr nc, Jump_036_52AA
    inc h

Jump_036_52AA::
    ld a, [hl]
    or a, a
    jr z, Jump_036_5265
    push af
    call Func_036_640D
    ld a, [$D872]
    ld e, a
    ld a, [$D873]
    ld d, a
    pop af
    dec a
    jr z, Jump_036_5265
    sra d
    rr e
    ld a, e
    ld [$D872], a
    ld a, d
    ld [$D873], a
    jr Jump_036_5265

Jump_036_52CC::
    ld a, [$C58A]
    cp a, $01
    jp z, Jump_036_5251
    ld a, [$D8A4]
    bit 2, a
    jp z, Jump_036_5251
    jp Jump_036_5244

Func_036_52DF::
    ld a, [$D8A6]
    cp a, $1B
    jr z, Jump_036_52EF
    cp a, $1C
    jr z, Jump_036_52F4
    ld de, $0050
    jr Jump_036_52F7

Jump_036_52EF::
    ld de, $000F
    jr Jump_036_52F7

Jump_036_52F4::
    ld de, $001E

Jump_036_52F7::
    ld a, e
    ld [$D872], a
    ld a, d
    ld [$D873], a
    ld a, [$D8A5]
    ld hl, $D8DF
    call Func_036_7E65
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
    call Func_036_7E3D
    call Func_000_3E7A
    jr nc, Jump_036_531F
    ld b, h
    ld c, l

Jump_036_531F::
    pop hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    scf
    ret
    db $37, $3F, $C9

Func_036_5328::
    call Func_036_6159
    call Func_036_61A6
    swap a
    and a, $03
    call Func_036_6232
    ret

Func_036_5336::
    call Func_036_6159
    call Func_036_61BA
    swap a
    and a, $03
    call Func_036_6232
    ret

Func_036_5344::
    call Func_036_6159
    call Func_036_61BA
    rrca
    rrca
    and a, $03
    call Func_036_6232
    ret

Func_036_5352::
    call Func_036_6159
    call Func_036_61C4
    swap a
    and a, $03
    call Func_036_621C
    ret

Func_036_5360::
    ld a, [$D8A5]
    call Func_036_6521
    jr nc, Jump_036_53C4
    jr z, Jump_036_53C4
    ld a, [$D8A5]
    call Func_036_6634
    ld a, [$D8A6]
    cp a, $25
    jr z, Jump_036_5380
    ld l, c
    ld h, b
    call Func_036_64DB
    ld c, l
    ld b, h
    jr Jump_036_5383

Jump_036_5380::
    call Func_036_650B

Jump_036_5383::
    ld a, c
    ld [$D872], a
    ld a, b
    ld [$D873], a
    ld a, [$D8A5]
    ld hl, $D90F
    call Func_036_7E65
    ld a, [hl]
    add a, c
    ld [hl+], a
    ld a, [hl]
    adc a, b
    ld [hl], a
    ld a, [$D8A5]
    push hl
    call Func_036_6521
    pop hl
    jr c, Jump_036_53C2
    ld a, [hl-]
    ld e, [hl]
    ld d, a
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, e
    sub a, c
    ld e, a
    ld a, d
    sbc a, b
    ld d, a
    ld a, [$D872]
    sub a, e
    ld e, a
    ld a, [$D873]
    sbc a, d
    ld d, a
    ld a, e
    ld [$D872], a
    ld a, d
    ld [$D873], a

Jump_036_53C2::
    scf
    ret

Jump_036_53C4::
    xor a, a
    ret

Func_036_53C6::
    call Func_036_6185
    call Func_036_61B5
    swap a
    and a, $03
    ld [$D86A], a
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_53DC
    scf
    ret

Jump_036_53DC::
    and a, $03
    ld b, a
    ld a, [$D8A6]
    cp a, $8C
    ld a, b
    jr z, Jump_036_53EB
    call Func_036_61D6
    ret

Jump_036_53EB::
    call Func_036_620F
    ret

Func_036_53EF::
    ld a, [$D8A5]
    call Func_036_7E33
    ld b, h
    ld c, l
    ld hl, $0001
    call Func_000_3E7A
    jr c, Jump_036_5401
    xor a, a
    ret

Jump_036_5401::
    ld a, [$D8A5]
    call Func_036_6634
    ld a, [$D8A6]
    cp a, $27
    jr z, Jump_036_5417
    ld l, c
    ld h, b
    call Func_036_64DB
    ld c, l
    ld b, h
    jr Jump_036_541A

Jump_036_5417::
    call Func_036_650B

Jump_036_541A::
    ld a, [$D8A5]
    ld hl, $D90F
    call Func_036_7E65
    push hl
    ld a, [hl+]
    ld h, [hl]
    or a, h
    pop hl
    jr z, Jump_036_543F
    ld a, c
    ld [$D872], a
    ld a, b
    ld [$D873], a
    ld a, [hl]
    sub a, c
    ld [hl+], a
    ld a, [hl]
    sbc a, b
    ld [hl], a
    jr nc, Jump_036_543D
    xor a, a
    ld [hl-], a
    ld [hl], a

Jump_036_543D::
    scf
    ret

Jump_036_543F::
    xor a, a
    ret

Func_036_5441::
    ld a, [$D8A5]
    call Func_036_6558
    jr nc, Jump_036_54A5
    ld a, [$D8A5]
    call Func_036_6646
    ld a, [$D8A6]
    cp a, $29
    jr z, Jump_036_545F
    ld l, c
    ld h, b
    call Func_036_64DB
    ld c, l
    ld b, h
    jr Jump_036_5462

Jump_036_545F::
    call Func_036_650B

Jump_036_5462::
    ld a, c
    ld [$D872], a
    ld a, b
    ld [$D873], a
    ld a, [$D8A5]
    ld hl, $D91F
    call Func_036_7E65
    ld a, [hl]
    add a, c
    ld [hl+], a
    ld a, [hl]
    adc a, b
    ld [hl], a
    ld a, [$D8A5]
    push hl
    call Func_036_6558
    pop hl
    jr c, Jump_036_54A3
    dec hl
    ld a, [hl+]
    sub a, c
    ld e, a
    ld a, [hl]
    sbc a, b
    ld d, a
    ld a, b
    ld [hl-], a
    ld [hl], c
    ld a, [$D872]
    ld c, a
    ld a, [$D873]
    ld b, a
    ld a, c
    sub a, e
    ld e, a
    ld a, b
    sbc a, d
    ld d, a
    ld a, e
    ld [$D872], a
    ld a, d
    ld [$D873], a

Jump_036_54A3::
    scf
    ret

Jump_036_54A5::
    xor a, a
    ret

Func_036_54A7:: ; heuristic: follows a terminator; C0
    call Func_036_6185
    call Func_036_61B5
    rrca
    rrca
    and a, $03
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_54BA
    scf
    ret

Jump_036_54BA::
    call Func_036_61D6
    ret

Func_036_54BE::
    ld a, [$D8A5]
    call Func_036_6646
    ld a, [$D8A6]
    cp a, $2B
    jr z, Jump_036_54D4
    ld l, c
    ld h, b
    call Func_036_64DB
    ld c, l
    ld b, h
    jr Jump_036_54D7

Jump_036_54D4::
    call Func_036_650B

Jump_036_54D7::
    ld a, [$D8A5]
    ld hl, $D91F
    call Func_036_7E65
    push hl
    ld d, $00
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    call Func_000_3E7A
    jr nz, Jump_036_54ED
    ld d, $01

Jump_036_54ED::
    push bc
    ld bc, $0002
    call Func_000_3E7A
    pop bc
    pop hl
    jr c, Jump_036_5520
    ld a, c
    sub a, d
    ld c, a
    ld a, b
    sbc a, $00
    ld b, a
    ld a, c
    ld [$D872], a
    ld a, b
    ld [$D873], a
    ld a, [hl]
    ld e, a
    sub a, c
    ld [hl+], a
    ld a, [hl]
    ld d, a
    sbc a, b
    ld [hl], a
    jr nc, Jump_036_551E
    xor a, a
    ld [hl-], a
    ld [hl], $01
    dec de
    ld a, e
    ld [$D872], a
    ld a, d
    ld [$D873], a

Jump_036_551E::
    scf
    ret

Jump_036_5520::
    xor a, a
    ret

Func_036_5522:: ; heuristic: follows a terminator; C0
    call Func_036_5013
    call Func_036_6185
    call Func_036_61A6
    swap a
    and a, $03
    call Func_036_6248
    ret

Func_036_5533:: ; heuristic: follows a terminator; C0
    call Func_036_5013
    call Func_036_6185
    call Func_036_61AB
    rlca
    rlca
    and a, $03
    call Func_036_6248
    ret

Func_036_5544:: ; heuristic: follows a terminator; C0
    call Func_036_5013
    call Func_036_6185
    call Func_036_61AB
    swap a
    and a, $03
    call Func_036_6248
    ret

Func_036_5555:: ; heuristic: follows a terminator; C0
    call Func_036_5013
    call Func_036_6185
    call Func_036_61AB
    rrca
    rrca
    and a, $03
    call Func_036_6248
    ret

Func_036_5566:: ; heuristic: follows a terminator; C0
    call Func_036_6594
    cp a, $00
    jp nz, Func_036_5013
    jp Func_036_66E0

Func_036_5571:: ; heuristic: follows a terminator; C0
    call Func_036_6594
    cp a, $01
    jp nz, Func_036_5013
    jp Func_036_66E0

Func_036_557C:: ; heuristic: follows a terminator; C0
    call Func_036_6594
    cp a, $02
    jp nz, Func_036_5013
    jp Func_036_66E0

Func_036_5587:: ; heuristic: follows a terminator; C0
    call Func_036_6594
    cp a, $03
    jp nz, Func_036_5013
    jp Func_036_66E0

Func_036_5592:: ; heuristic: follows a terminator; C0
    call Func_036_6594
    cp a, $05
    jp nz, Func_036_5013
    jp Func_036_66E0

Func_036_559D:: ; heuristic: follows a terminator; C0
    call Func_036_6594
    cp a, $04
    jp nz, Func_036_5013
    jp Func_036_66E0

Func_036_55A8:: ; heuristic: follows a terminator; C0
    call Func_036_6594
    cp a, $06
    jp nz, Func_036_5013
    jp Func_036_66E0

Func_036_55B3:: ; heuristic: follows a terminator; C0
    call Func_036_6594
    cp a, $07
    jp nz, Func_036_5013
    jp Func_036_66E0

Func_036_55BE:: ; heuristic: follows a terminator; C0
    call Func_036_6594
    cp a, $08
    jp nz, Func_036_5013
    jp Func_036_66E0

Func_036_55C9:: ; heuristic: follows a terminator; C0
    call Func_036_6594
    cp a, $09
    jp nz, Func_036_5013
    jp Func_036_66E0

Func_036_55D4:: ; heuristic: follows a terminator; C0
    call Func_036_5013
    ld a, [$D8A5]
    ld hl, $D8A7
    add a, l
    ld l, a
    jr nc, Jump_036_55E2
    inc h

Jump_036_55E2::
    bit 0, [hl]
    jr z, Jump_036_55FA
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    call Func_036_6465
    inc hl
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a

Jump_036_55FA::
    ret

Func_036_55FB::
    ld a, [$D8A6]
    cp a, $82
    jr z, Jump_036_5611
    call Func_036_6185
    call Func_036_61AB
    and a, $03
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_5613

Jump_036_5611::
    scf
    ret

Jump_036_5613::
    and a, $03
    ld b, a
    ld a, [$D8A6]
    cp a, $7E
    ld a, b
    jr z, Jump_036_5622
    call Func_036_61D6
    ret

Jump_036_5622::
    call Func_036_61F9
    ret

Func_036_5626:: ; heuristic: follows a terminator; C0
    call Func_036_6185
    call Func_036_61B0
    rrca
    rrca
    and a, $03
    ld [$D86A], a
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_563C
    scf
    ret

Jump_036_563C::
    call Func_036_61D6
    ret

Func_036_5640:: ; heuristic: follows a terminator; C0
    call Func_036_5671
    ld a, [$D8A4]
    ld hl, $D8DF
    call Func_036_7E65
    push hl
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    add hl, bc
    ld b, h
    ld c, l
    pop hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, [$D8A4]
    call Func_036_65D6
    jr nc, Jump_036_5670
    ld a, [$D8A4]
    ld bc, $D8F0
    add a, a
    add a, c
    ld c, a
    jr nc, Jump_036_566B
    inc b

Jump_036_566B::
    ld a, [bc]
    ld [hl-], a
    dec bc
    ld a, [bc]
    ld [hl], a

Jump_036_5670::
    ret

Func_036_5671::
    ld a, [$D8A5]
    ld hl, $D8DF
    call Func_036_7E65
    push hl
    ld a, [$D8A6]
    cp a, $DF
    jr nz, Jump_036_568C
    ld a, [$C982]
    ld c, a
    ld a, [$C983]
    ld b, a
    jr Jump_036_56AE

Jump_036_568C::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    or a, h
    jr z, Jump_036_56B8
    ld a, [$D8A4]
    ld de, $D8B7
    add a, e
    ld e, a
    jr nc, Jump_036_569D
    inc d

Jump_036_569D::
    ld a, [de]
    srl a
    srl a
    add a, $05
    ld c, a
    ld b, $00
    call Func_000_3E7A
    jr nc, Jump_036_56AE
    ld b, h
    ld c, l

Jump_036_56AE::
    ld a, c
    ld [$D872], a
    ld a, b
    ld [$D873], a
    jr Jump_036_56C3

Jump_036_56B8::
    ld bc, $0000
    ld a, c
    ld [$D872], a
    ld a, b
    ld [$D873], a

Jump_036_56C3::
    pop hl
    ld a, [hl]
    sub a, c
    ld [hl+], a
    ld a, [hl]
    sbc a, b
    ld [hl], a
    ret

Func_036_56CB:: ; heuristic: follows a terminator; C0
    call Func_036_6185
    call Func_036_61B0
    and a, $03
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_56DC
    scf
    ret

Jump_036_56DC::
    call Func_036_61D6
    ret

Func_036_56E0:: ; heuristic: follows a terminator; C0
    call Func_036_6185
    call Func_036_61B5
    rlca
    rlca
    and a, $03
    push af
    ld a, [$D8A6]
    cp a, $E1
    jr nz, Jump_036_56F5
    pop af
    xor a, a
    push af

Jump_036_56F5::
    pop af
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_56FF
    scf
    ret

Jump_036_56FF::
    call Func_036_620F
    ret

Func_036_5703:: ; heuristic: follows a terminator; C0
    ld a, [$D8A5]
    call Func_036_66D6
    ld a, [$D8A4]
    ld hl, $D8A7
    add a, l
    ld l, a
    jr nc, Jump_036_5714
    inc h

Jump_036_5714::
    ld [hl], c
    ld a, [$D8A5]
    call Func_036_65E8
    ld a, [$D8A4]
    ld hl, $D8BF
    call Func_036_7E65
    push hl
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    call Func_000_3E7A
    pop hl
    jr c, Jump_036_5737
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, [$D8A4]
    call Func_036_7EBE

Jump_036_5737::
    ld a, [$D8A4]
    ld hl, $D8CF
    call Func_036_7E65
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, [$D8A5]
    call Func_036_6605
    ld a, [$D8A4]
    ld hl, $D8DF
    call Func_036_7E65
    push hl
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    call Func_000_3E7A
    pop hl
    jr c, Jump_036_5765
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, [$D8A4]
    call Func_036_7ECB

Jump_036_5765::
    ld a, [$D8A4]
    ld hl, $D8EF
    call Func_036_7E65
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, [$D8A4]
    ld hl, $D8FF
    call Func_036_7E65
    ld a, [$D8A5]
    call Func_036_6622
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, [$D8A4]
    ld hl, $D90F
    call Func_036_7E65
    ld a, [$D8A5]
    call Func_036_6634
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, [$D8A4]
    ld hl, $D91F
    call Func_036_7E65
    ld a, [$D8A5]
    call Func_036_6646
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, [$D8A5]
    call Func_036_6658
    ld a, [$D8A4]
    ld de, $DA72
    ld b, a
    add a, a
    add a, b
    add a, a
    add a, b
    add a, e
    ld e, a
    jr nc, Jump_036_57BD
    inc d

Jump_036_57BD::
    ld a, l
    ld [$D868], a
    ld a, h
    ld [$D869], a
    ld a, e
    ld [$D86A], a
    ld a, d
    ld [$D86B], a
    ld hl, $44B9
    ld b, $19
    rst $10
    ld a, [$D8A5]
    call Func_036_669E
    ld a, [$D8A4]
    ld de, $D988
    swap a
    add a, e
    ld e, a
    jr nc, Jump_036_57E6
    inc d

Jump_036_57E6::
    ld c, $00

Jump_036_57E8::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_036_584D
    cp a, $C8
    jr z, Jump_036_584D
    push af
    ld a, [$C58A]
    cp a, $01
    jr z, Jump_036_5822
    ld a, [$D8A5]
    cp a, $04
    jr nc, Jump_036_5811
    pop af
    cp a, $34
    jr nz, Jump_036_5809
    ld a, $AD
    jr Jump_036_5823

Jump_036_5809::
    cp a, $35
    jr nz, Jump_036_5823
    ld a, $AE
    jr Jump_036_5823

Jump_036_5811::
    pop af
    cp a, $AD
    jr nz, Jump_036_581A
    ld a, $34
    jr Jump_036_5823

Jump_036_581A::
    cp a, $AE
    jr nz, Jump_036_5823
    ld a, $35
    jr Jump_036_5823

Jump_036_5822::
    pop af

Jump_036_5823::
    push af
    push hl
    push de
    push bc
    ld [$CFEC], a
    xor a, a
    ld [$CFED], a
    ld hl, Func_036_4001
    ld b, $1A
    rst $10
    pop bc
    pop de
    pop hl
    ld a, [$CFF1]
    swap a
    and a, $0F
    ld [de], a
    inc de
    pop af
    ld [de], a
    inc hl
    inc de
    inc c
    dec b
    jr nz, Jump_036_57E8
    ld a, c
    cp a, $08
    jr z, Jump_036_585B

Jump_036_584D::
    ld a, $00
    ld [de], a
    inc de
    ld a, $FF
    ld [de], a
    inc de
    inc c
    ld a, c
    cp a, $08
    jr nz, Jump_036_584D

Jump_036_585B::
    ret
    INCBIN "dwm2-cobi-us.gbc", $0D985C, $69

Func_036_58C5::
    ld a, [$D8A4]
    ld hl, $D8B7
    add a, l
    ld l, a
    jr nc, Jump_036_58D0
    inc h

Jump_036_58D0::
    ld l, [hl]
    ld h, $00
    ld b, h
    ld c, l
    ld a, [$C58A]
    cp a, $01
    jr z, Jump_036_58E8
    ld a, [$D8A4]
    cp a, $04
    jr c, Jump_036_58E8
    call Func_036_650B
    jr Jump_036_58ED

Jump_036_58E8::
    add hl, bc
    add hl, bc
    ld bc, $000A

Jump_036_58ED::
    add hl, bc
    ld bc, $00B4
    call Func_000_3E7A
    jr c, Jump_036_58F9
    ld hl, $00B4

Jump_036_58F9::
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    call Func_036_64D4
    call Func_036_651C
    ld b, h
    ld c, l
    ld a, l
    cpl
    add a, $01
    ld l, a
    ld a, h
    cpl
    adc a, $00
    ld h, a
    call Func_000_3E98
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    add hl, de
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    call Func_036_6185
    call Func_036_51FC
    ret

Func_036_592E::
    ld a, [$D8A4]
    ld hl, $D8B7
    add a, l
    ld l, a
    jr nc, Jump_036_5939
    inc h

Jump_036_5939::
    ld l, [hl]
    ld h, $00
    ld a, [$C58A]
    cp a, $01
    jr z, Jump_036_594E
    cp a, $04
    jr c, Jump_036_594E
    ld b, h
    ld c, l
    call Func_036_650B
    jr Jump_036_5952

Jump_036_594E::
    add hl, hl
    ld bc, $001E

Jump_036_5952::
    add hl, bc
    ld bc, $0096
    call Func_000_3E7A
    jr c, Jump_036_595E
    ld hl, $0096

Jump_036_595E::
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    call Func_036_64CD
    call Func_036_6518
    ld b, h
    ld c, l
    ld a, l
    cpl
    add a, $01
    ld l, a
    ld a, h
    cpl
    adc a, $00
    ld h, a
    call Func_000_3E98
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    add hl, de
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    call Func_036_6185
    call Func_036_51FC
    ret
    INCBIN "dwm2-cobi-us.gbc", $0D9993, $4C

Data_036_59DF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0D99DF, $5B

Data_036_5A3A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $67, $FA, $F9, $CF, $EA, $6A, $D8, $CD, $8F, $61, $CD, $94, $65, $FE, $07, $20
    db $13, $FA, $72, $D8, $6F, $FA, $73, $D8, $67, $CD, $6C, $64, $7D, $EA, $72, $D8
    db $7C, $EA, $73, $D8, $CD, $85, $61, $CD, $AB, $61, $07, $07, $E6, $03, $CD, $32
    db $62, $C9

Func_036_5A6C::
    call Func_036_6159
    call Func_036_61C4
    rrca
    rrca
    and a, $03
    call Func_036_621C
    ret

Func_036_5A7A:: ; heuristic: follows a terminator; C0
    ld a, [$D8A5]
    call Func_036_7E42
    call Func_036_64A3
    inc hl
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    call Func_036_6185
    call Func_036_61B5
    and a, $03
    call Func_036_621C
    ret

Func_036_5A98:: ; heuristic: follows a terminator; C0
    call Func_036_6185
    call Func_036_61B5
    and a, $03
    call Func_036_61D6
    jr nc, Jump_036_5AF5
    ld a, [$D8A4]
    call Func_036_7E42
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, h
    or a, a
    jr nz, Jump_036_5ABF
    ld a, l
    cp a, $01
    jr z, Jump_036_5AEB

Jump_036_5ABF::
    ld a, [$C58A]
    or a, a
    jr nz, Jump_036_5AD8
    ld a, [$CFC5]
    or a, a
    jr z, Jump_036_5ACF
    cp a, $01
    jr nz, Jump_036_5AD8

Jump_036_5ACF::
    ld a, [$D8A5]
    call Func_036_7E42
    dec hl
    jr Jump_036_5AE4

Jump_036_5AD8::
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    dec hl
    call Func_036_651C

Jump_036_5AE4::
    ld a, h
    or a, l
    jr nz, Jump_036_5AEB
    ld hl, $0001

Jump_036_5AEB::
    scf
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    ret

Jump_036_5AF5::
    ld hl, $0000
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    xor a, a
    ret

Func_036_5B02:: ; heuristic: follows a terminator; C0
    call Func_036_6185
    call Func_036_61BF
    swap a
    and a, $03
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_5B15
    scf
    ret

Jump_036_5B15::
    call Func_036_620F
    ret

Func_036_5B19:: ; heuristic: follows a terminator; C0
    call Func_036_6141
    jp z, Jump_036_613D
    call Func_036_6185
    call Func_036_61B0
    swap a
    and a, $03
    ld [$D86A], a
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_5B35
    scf
    ret

Jump_036_5B35::
    ld a, [$D8A6]
    cp a, $13
    jr c, Jump_036_5B4F
    cp a, $14
    jr z, Jump_036_5B4F
    cp a, $79
    jr z, Jump_036_5B4F
    cp a, $82
    jr z, Jump_036_5B56
    ld a, [$D86A]
    call Func_036_61D6
    ret

Jump_036_5B4F::
    ld a, [$D86A]
    call Func_036_620F
    ret

Jump_036_5B56::
    ld a, [$D86A]
    call Func_036_61F9
    ret

Func_036_5B5D:: ; heuristic: follows a terminator; C0
    call Func_036_6185
    call Func_036_61BF
    rrca
    rrca
    and a, $03
    ld b, a
    ld a, [$D8A6]
    cp a, $7A
    jr z, Jump_036_5B7D
    cp a, $8E
    jr z, Jump_036_5B7D
    cp a, $90
    jr z, Jump_036_5B7D
    ld a, b
    call Func_036_61D6
    jr Jump_036_5B8A

Jump_036_5B7D::
    ld a, b
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_5B87
    scf
    ret

Jump_036_5B87::
    call Func_036_620F

Jump_036_5B8A::
    ret

Func_036_5B8B:: ; heuristic: follows a terminator; C0
    ld a, [$D8A5]
    ld hl, $D90F
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_036_5B97
    inc h

Jump_036_5B97::
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_036_5BC2
    ld a, [$D8A5]
    ld hl, $D91F
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_036_5BAB
    inc h

Jump_036_5BAB::
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_036_5BC2
    ld a, [$D8A5]
    ld hl, $D80D
    call Func_000_3F25
    bit 1, [hl]
    jr z, Jump_036_5BC2
    xor a, a
    ret

Jump_036_5BC2::
    scf
    ret

Func_036_5BC4:: ; heuristic: follows a terminator; C0
    ld a, [$D871]
    ld hl, $D80C
    call Func_000_3F25
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ld a, [$D871]
    ld hl, $DA63
    add a, l
    ld l, a
    jr nc, Jump_036_5BE2
    inc h

Jump_036_5BE2::
    ld [hl], $00
    ld a, [$D871]
    srl a
    srl a
    and a, $01
    ld hl, $DAAE
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_036_5BF6
    inc h

Jump_036_5BF6::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, l
    ld [$CFE6], a
    ld a, h
    ld [$CFE7], a
    ld hl, Func_036_4001
    ld b, $34
    rst $10
    ld a, [$CFEC]
    ld c, a
    ld a, [$CFED]
    ld b, a
    ld hl, $D958
    call Func_036_5D84
    ld a, [$CFF5]
    ld c, a
    ld hl, $D8B7
    call Func_036_5D7A
    ld a, [$CFF6]
    ld c, a
    ld a, [$CFF7]
    ld b, a
    ld hl, $D8BF
    call Func_036_5D84
    ld a, [$CFF6]
    ld c, a
    ld a, [$CFF7]
    ld b, a
    ld hl, $D8CF
    call Func_036_5D84
    ld a, [$CFF8]
    ld c, a
    ld a, [$CFF9]
    ld b, a
    ld hl, $D8DF
    call Func_036_5D84
    ld a, [$CFF8]
    ld c, a
    ld a, [$CFF9]
    ld b, a
    ld hl, $D8EF
    call Func_036_5D84
    ld a, [$CFFA]
    ld c, a
    ld a, [$CFFB]
    ld b, a
    ld hl, $D8FF
    call Func_036_5D84
    ld a, [$CFFC]
    ld c, a
    ld a, [$CFFD]
    ld b, a
    ld hl, $D90F
    call Func_036_5D84
    ld a, [$CFFE]
    ld c, a
    ld a, [$CFFF]
    ld b, a
    ld hl, $D91F
    call Func_036_5D84
    ld a, [$D000]
    ld c, a
    ld a, [$D001]
    ld b, a
    ld hl, $D92F
    call Func_036_5D84
    ld bc, $03E7
    ld hl, $D93F
    call Func_036_5D84
    ld a, [$D002]
    ld c, a
    ld hl, $D968
    call Func_036_5D7A
    ld a, [$D003]
    ld c, a
    ld hl, $D978
    call Func_036_5D7A
    ld a, [$D004]
    ld c, a
    ld hl, $D970
    call Func_036_5D7A
    ld a, [$D005]
    ld c, a
    ld hl, $D980
    call Func_036_5D7A
    ld c, $00
    ld hl, $D8A7
    call Func_036_5D7A
    ld c, $00
    ld hl, $D8AF
    call Func_036_5D7A
    ld a, [$D871]
    ld c, a
    ld hl, $4298
    ld b, $19
    rst $10
    ld a, [$CFEC]
    ld l, a
    ld a, [$CFED]
    ld h, a
    ld a, l
    ld [$D006], a
    ld a, h
    ld [$D007], a
    ld hl, Func_036_4001
    ld b, $35
    rst $10
    ld hl, $D01A
    ld a, l
    ld [$D868], a
    ld a, h
    ld [$D869], a
    ld a, [$D871]
    ld c, a
    add a, a
    add a, c
    add a, a
    add a, c
    ld de, $DA72
    add a, e
    ld e, a
    jr nc, Jump_036_5D0B
    inc d

Jump_036_5D0B::
    ld a, e
    ld [$D86A], a
    ld a, d
    ld [$D86B], a
    ld hl, $44B9
    ld b, $19
    rst $10
    ld hl, $CFEE
    ld de, $C0A0
    ld bc, $0004
    call Func_000_0952
    ld hl, $C0A0
    call Func_036_5D2C
    ret

Func_036_5D2C::
    ld b, $04
    ld a, [$D871]
    ld de, $D989
    swap a
    add a, e
    ld e, a
    jr nc, Jump_036_5D3B
    inc d

Jump_036_5D3B::
    ld a, [hl]
    cp a, $FF
    ret z
    push hl
    push bc
    ld a, [hl]
    ld [de], a
    dec de
    push de
    ld [$CFEC], a
    ld a, $03
    ld [$D868], a
    xor a, a
    ld [$CFED], a
    ld a, $01
    ld [$D869], a
    ld hl, $CFF1
    ld a, l
    ld [$D86A], a
    ld a, h
    ld [$D86B], a
    ld hl, $4022
    ld b, $1A
    rst $10
    ld a, [$CFF1]
    swap a
    and a, $0F
    pop de
    ld [de], a
    inc de
    inc de
    inc de
    pop bc
    pop hl
    inc hl
    dec b
    jr nz, Jump_036_5D3B
    ret

Func_036_5D7A::
    ld a, [$D871]
    add a, l
    ld l, a
    jr nc, Jump_036_5D82
    inc h

Jump_036_5D82::
    ld [hl], c
    ret

Func_036_5D84::
    ld a, [$D871]
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_036_5D8D
    inc h

Jump_036_5D8D::
    ld [hl], c
    inc hl
    ld [hl], b
    ret

Func_036_5D91:: ; heuristic: follows a terminator; C0
    ld a, [$D8A5]
    ld hl, $D8A7
    add a, l
    ld l, a
    jr nc, Jump_036_5D9C
    inc h

Jump_036_5D9C::
    bit 4, [hl]
    ret nz
    call Func_036_5B5D
    ret

Func_036_5DA3:: ; heuristic: follows a terminator; C0
    call Func_036_6185
    call Func_036_61BF
    and a, $03
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_5DB4
    scf
    ret

Jump_036_5DB4::
    call Func_036_61D6
    ret

Func_036_5DB8:: ; heuristic: follows a terminator; C0
    call Func_036_6185
    call Func_036_61C4
    rlca
    rlca
    and a, $03
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_5DCB
    scf
    ret

Jump_036_5DCB::
    call Func_036_61D6
    ret

Func_036_5DCF:: ; heuristic: follows a terminator; C0
    ld a, [$D8A4]
    ld hl, $D8B7
    add a, l
    ld l, a
    jr nc, Jump_036_5DDA
    inc h

Jump_036_5DDA::
    ld l, [hl]
    ld h, $00
    ld a, [$C58A]
    cp a, $01
    jr z, Jump_036_5DF4
    ld a, [$D8A4]
    cp a, $04
    jr c, Jump_036_5DF4
    push hl
    srl h
    rr l
    pop bc
    add hl, bc
    jr Jump_036_5DF5

Jump_036_5DF4::
    add hl, hl

Jump_036_5DF5::
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    call Func_036_6185
    call Func_036_61C4
    swap a
    and a, $03
    call Func_036_621C
    ret
    db $FA, $A4, $D8, $21, $FF, $D8, $CD, $65, $7E, $7D, $EA, $7F, $D8, $7C, $EA, $80
    db $D8, $2A, $66

Data_036_5E1E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0D9E1E, $8D

Data_036_5EAB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2A, $66, $6F, $CD, $7A, $3E, $28, $22, $01, $F4, $01, $09, $FA, $76, $D8, $4F
    db $FA, $77, $D8, $47, $CD, $7A, $3E, $38, $02, $60, $69, $FA, $78, $D8, $4F, $FA
    db $79, $D8, $47, $7D, $02, $03, $7C, $02, $37, $C9, $37, $3F, $C9

Func_036_5ED8::
    call Func_036_6141
    jp z, Jump_036_613D
    call Func_036_6185
    call Func_036_61B5
    and a, $03
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_5EEF
    scf
    ret

Jump_036_5EEF::
    push af
    ld a, [$D8A6]
    cp a, $D6
    jr z, Jump_036_5EFC
    pop af
    call Func_036_61EC
    ret

Jump_036_5EFC::
    pop af
    call Func_036_6346
    ret

Func_036_5F01::
    call Func_036_6159
    call Func_036_61B0
    rlca
    rlca
    and a, $03
    ld [$D86A], a
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_5F17
    scf
    ret

Jump_036_5F17::
    ld a, [$D8A6]
    cp a, $2F
    ld a, [$D86A]
    jp z, Func_036_61D6
    jp Func_036_620F

Func_036_5F25:: ; heuristic: follows a terminator; C0
    ld hl, $0082
    ld a, [$D8A6]
    cp a, $DC
    jr nz, Jump_036_5F32
    ld hl, $0262

Jump_036_5F32::
    ld a, l
    ld [$CFE6], a
    ld a, h
    ld [$CFE7], a
    ld hl, Func_036_4001
    ld b, $34
    rst $10
    ld a, [$CFF6]
    ld c, a
    ld a, [$CFF7]
    ld b, a
    ld hl, $D8CF
    call Func_036_608B
    ld a, [$D8A4]
    ld hl, $D8BF
    call Func_036_6701
    ld a, [$CFF8]
    ld c, a
    ld a, [$CFF9]
    ld b, a
    ld hl, $D8EF
    call Func_036_608B
    ld a, [$D8A4]
    ld hl, $D8DF
    call Func_036_6701
    ld a, [$CFFA]
    ld c, a
    ld a, [$CFFB]
    ld b, a
    ld hl, $D8FF
    call Func_036_608B
    ld a, [$CFFC]
    ld c, a
    ld a, [$CFFD]
    ld b, a
    ld hl, $D90F
    call Func_036_608B
    ld a, [$CFFE]
    ld c, a
    ld a, [$CFFF]
    ld b, a
    ld hl, $D91F
    call Func_036_608B
    ld a, [$D000]
    ld c, a
    ld a, [$D001]
    ld b, a
    ld hl, $D92F
    call Func_036_608B
    ld a, [$CFEC]
    ld l, a
    ld a, [$CFED]
    ld h, a
    ld a, l
    ld [$D006], a
    ld a, h
    ld [$D007], a
    ld hl, Func_036_4001
    ld b, $35
    rst $10
    ld a, [$D8A4]
    ld c, a
    ld hl, $4298
    ld b, $19
    rst $10
    ld hl, $D01A
    ld a, l
    ld [$D868], a
    ld a, h
    ld [$D869], a
    ld a, [$D8A4]
    ld c, a
    add a, a
    add a, c
    add a, a
    add a, c
    ld de, $DA72
    add a, e
    ld e, a
    jr nc, Jump_036_5FE1
    inc d

Jump_036_5FE1::
    ld a, e
    ld [$D86A], a
    ld a, d
    ld [$D86B], a
    ld hl, $44B9
    ld b, $19
    rst $10
    ld hl, $CFEE
    ld de, $C0A0
    ld bc, $0004
    call Func_000_0952
    call Func_036_6018
    ld a, [$D8A4]
    ld hl, $D8A7
    add a, l
    ld l, a
    jr nc, Jump_036_6009
    inc h

Jump_036_6009::
    ld [hl], $00
    ld a, [$D8A4]
    call Func_036_7EBE
    ld a, [$D8A4]
    call Func_036_7ECB
    ret

Func_036_6018::
    ld hl, $C0A0
    ld b, $04
    ld a, [$D8A4]
    ld de, $D989
    swap a
    add a, e
    ld e, a
    jr nc, Jump_036_602A
    inc d

Jump_036_602A::
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_036_6034
    call Func_036_6077
    jr Jump_036_606A

Jump_036_6034::
    push hl
    push bc
    ld a, [hl]
    ld [de], a
    dec de
    push de
    ld [$CFEC], a
    ld a, $03
    ld [$D868], a
    xor a, a
    ld [$CFED], a
    ld a, $01
    ld [$D869], a
    ld hl, $CFF1
    ld a, l
    ld [$D86A], a
    ld a, h
    ld [$D86B], a
    ld hl, $4022
    ld b, $1A
    rst $10
    ld a, [$CFF1]
    swap a
    and a, $0F
    pop de
    pop bc
    pop hl
    ld [de], a
    inc de
    inc de
    inc de

Jump_036_606A::
    inc hl
    dec b
    jr nz, Jump_036_602A
    call Func_036_6077
    call Func_036_6077
    call Func_036_6077

Func_036_6077::
    ld a, $FF
    ld [de], a
    dec de
    xor a, a
    ld [de], a
    inc de
    inc de
    inc de
    ret

Func_036_6081:: ; heuristic: follows a terminator; C0
    ld a, [$D8A4]
    add a, l
    ld l, a
    jr nc, Jump_036_6089
    inc h

Jump_036_6089::
    ld [hl], c
    ret

Func_036_608B::
    ld a, [$D8A4]
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_036_6094
    inc h

Jump_036_6094::
    ld [hl], c
    inc hl
    ld [hl], b
    ret

Func_036_6098:: ; heuristic: follows a terminator; C0
    ld a, [$D8A4]
    ld hl, $D8FF
    call Func_036_7E65
    push hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    push bc
    ld a, $00
    ld [hl-], a
    ld [hl], $C8
    call Func_036_5013
    pop bc
    pop hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    ret

Func_036_60B4:: ; heuristic: follows a terminator; C0
    call Func_036_6159
    call Func_036_61A6
    swap a
    rrca
    rrca
    and a, $03
    ld b, a
    ld a, [$D8A6]
    cp a, $4C
    ld a, b
    jr z, Jump_036_60CD
    call Func_036_6232
    ret

Jump_036_60CD::
    call Func_036_621C
    ret

Func_036_60D1::
    call Func_036_6185
    call Func_036_61BA
    and a, $03
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_60E2
    scf
    ret

Jump_036_60E2::
    call Func_036_620F
    ld e, $00
    ret c
    ld e, $01
    ret

Func_036_60EB::
    call Func_036_6141
    jp z, Jump_036_613D
    call Func_036_6185
    call Func_036_61BF
    rlca
    rlca
    and a, $03
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_6104
    scf
    ret

Jump_036_6104::
    call Func_036_620F
    ld e, $00
    ret c
    ld e, $01
    ret

Func_036_610D::
    call Func_036_5F01
    ld e, $00
    ret c
    ld e, $01
    ret

Func_036_6116:: ; heuristic: follows a terminator; C0
    call Func_036_6185
    call Func_036_61A6
    swap a
    rrca
    rrca
    and a, $03
    call Func_036_61D6
    ret

Func_036_6126:: ; heuristic: follows a terminator; C0
    call Func_036_6185
    call Func_036_61B0
    swap a
    and a, $03
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_6139
    scf
    ret

Jump_036_6139::
    call Func_036_61D6
    ret

Jump_036_613D::
    xor a, a
    ld e, $01
    ret

Func_036_6141::
    ld a, [$CFC5]
    cp a, $02
    jr z, Jump_036_614C
    cp a, $03
    jr nz, Jump_036_6155

Jump_036_614C::
    ld a, [$D8A4]
    cp a, $04
    jr nc, Jump_036_6155
    xor a, a
    ret

Jump_036_6155::
    ld a, $01
    or a, a
    ret

Func_036_6159::
    ld a, [$C58A]
    cp a, $01
    jr z, Jump_036_6174
    ld a, [$D8A4]
    bit 2, a
    jr z, Jump_036_6174
    ld a, [$CFFB]
    ld l, a
    ld a, [$CFFC]
    ld h, a
    ld a, [$CFFD]
    jr Jump_036_617F

Jump_036_6174::
    ld a, [$CFF7]
    ld l, a
    ld a, [$CFF8]
    ld h, a
    ld a, [$CFF9]

Jump_036_617F::
    ld [$D86A], a
    call Func_036_618F

Func_036_6185::
    ld a, [$D8A5]
    ld hl, $D814
    call Func_000_3F25
    ret

Func_036_618F::
    push hl
    ld a, [$D86A]
    ld c, a
    ld b, $00
    add hl, bc
    ld c, l
    ld b, h
    pop hl
    call Func_000_3E98
    ld a, e
    ld [$D872], a
    ld a, d
    ld [$D873], a
    ret

Func_036_61A6::
    ld de, $DA72
    jr Jump_036_61C7

Func_036_61AB::
    ld de, $DA73
    jr Jump_036_61C7

Func_036_61B0::
    ld de, $DA74
    jr Jump_036_61C7

Func_036_61B5::
    ld de, $DA75
    jr Jump_036_61C7

Func_036_61BA::
    ld de, $DA76
    jr Jump_036_61C7

Func_036_61BF::
    ld de, $DA77
    jr Jump_036_61C7

Func_036_61C4::
    ld de, $DA78

Jump_036_61C7::
    ld a, [$D8A5]
    ld b, a
    add a, a
    add a, b
    add a, a
    add a, b
    add a, e
    ld e, a
    jr nc, Jump_036_61D4
    inc d

Jump_036_61D4::
    ld a, [de]
    ret

Func_036_61D6::
    bit 6, [hl]
    jr z, Jump_036_61DF
    call Func_036_629B
    jr Jump_036_61EB

Jump_036_61DF::
    bit 7, [hl]
    jr z, Jump_036_61E8
    call Func_036_628E
    jr Jump_036_61EB

Jump_036_61E8::
    call Func_036_6278

Jump_036_61EB::
    ret

Func_036_61EC:: ; heuristic: follows a terminator; C0
    bit 6, [hl]
    jr z, Jump_036_61F5
    call Func_036_6278
    jr Jump_036_61F8

Jump_036_61F5::
    call Func_036_628E

Jump_036_61F8::
    ret

Func_036_61F9::
    bit 6, [hl]
    jr z, Jump_036_6202
    call Func_036_62B1
    jr Jump_036_620E

Jump_036_6202::
    bit 7, [hl]
    jr z, Jump_036_620B
    call Func_036_628E
    jr Jump_036_620E

Jump_036_620B::
    call Func_036_629B

Jump_036_620E::
    ret

Func_036_620F::
    bit 7, [hl]
    jr z, Jump_036_6218
    call Func_036_6278
    jr Jump_036_621B

Jump_036_6218::
    call Func_036_62B1

Jump_036_621B::
    ret

Func_036_621C:: ; heuristic: follows a terminator; C0
    bit 6, [hl]
    jr z, Jump_036_6225
    call Func_036_62EF
    jr Jump_036_6231

Jump_036_6225::
    bit 7, [hl]
    jr z, Jump_036_622E
    call Func_036_6302
    jr Jump_036_6231

Jump_036_622E::
    call Func_036_62DC

Jump_036_6231::
    ret

Func_036_6232:: ; heuristic: follows a terminator; C0
    bit 6, [hl]
    jr z, Jump_036_623B
    call Func_036_6319
    jr Jump_036_6247

Jump_036_623B::
    bit 7, [hl]
    jr z, Jump_036_6244
    call Func_036_6302
    jr Jump_036_6247

Jump_036_6244::
    call Func_036_62EF

Jump_036_6247::
    ret

Func_036_6248::
    bit 6, [hl]
    jr z, Jump_036_6251
    call Func_036_62DC
    jr Jump_036_6254

Jump_036_6251::
    call Func_036_6302

Jump_036_6254::
    ret

Func_036_6255:: ; heuristic: follows a terminator; C0
    bit 7, [hl]
    jr z, Jump_036_625E
    call Func_036_62DC
    jr Jump_036_6261

Jump_036_625E::
    call Func_036_6319

Jump_036_6261::
    ret

Func_036_6262:: ; heuristic: follows a terminator; C0
    bit 6, [hl]
    jr z, Jump_036_626B
    call Func_036_629B
    jr Jump_036_6277

Jump_036_626B::
    bit 7, [hl]
    jr z, Jump_036_6274
    call Func_036_6346
    jr Jump_036_6277

Jump_036_6274::
    call Func_036_6330

Jump_036_6277::
    ret

Func_036_6278::
    and a, a
    jr nz, Jump_036_627D
    scf
    ret

Jump_036_627D::
    cp a, $01
    jr nz, Jump_036_6284
    jp Jump_036_636A

Jump_036_6284::
    cp a, $02
    jr nz, Jump_036_628B
    jp Jump_036_637C

Jump_036_628B::
    scf
    ccf
    ret

Func_036_628E::
    cp a, $02
    jr nc, Jump_036_6293
    ret

Jump_036_6293::
    jr nz, Jump_036_6298
    jp Jump_036_6373

Jump_036_6298::
    scf
    ccf
    ret

Func_036_629B::
    and a, a
    jr nz, Jump_036_62A0
    scf
    ret

Jump_036_62A0::
    cp a, $01
    jr nz, Jump_036_62A7
    jp Jump_036_6373

Jump_036_62A7::
    cp a, $02
    jr nz, Jump_036_62AE
    jp Jump_036_6385

Jump_036_62AE::
    scf
    ccf
    ret

Func_036_62B1::
    push af
    ld a, [$C58A]
    cp a, $01
    jr z, Jump_036_62C4
    ld a, [$D8A5]
    cp a, $04
    jr nc, Jump_036_62C4
    pop af
    jp Jump_036_6353

Jump_036_62C4::
    pop af
    and a, a
    jr nz, Jump_036_62CB
    jp Jump_036_6373

Jump_036_62CB::
    cp a, $01
    jr nz, Jump_036_62D2
    jp Jump_036_637C

Jump_036_62D2::
    cp a, $02
    jr nz, Jump_036_62D9
    jp Jump_036_6397

Jump_036_62D9::
    scf
    ccf
    ret

Func_036_62DC:: ; heuristic: follows a terminator; C0
    and a, a
    ret z
    cp a, $01
    jr nz, Jump_036_62E5
    jp Jump_036_63D1

Jump_036_62E5::
    cp a, $02
    jr nz, Jump_036_62EC
    jp Jump_036_63F9

Jump_036_62EC::
    jp Jump_036_6449

Func_036_62EF::
    and a, a
    ret z
    cp a, $01
    jr nz, Jump_036_62F8
    jp Jump_036_63E5

Jump_036_62F8::
    cp a, $02
    jr nz, Jump_036_62FF
    jp Func_036_640D

Jump_036_62FF::
    jp Jump_036_6449

Func_036_6302::
    and a, a
    jr nz, Jump_036_6308
    jp Jump_036_63A9

Jump_036_6308::
    cp a, $01
    jr nz, Jump_036_630F
    jp Jump_036_63BD

Jump_036_630F::
    cp a, $02
    jr nz, Jump_036_6316
    jp Jump_036_63E5

Jump_036_6316::
    jp Jump_036_6421

Func_036_6319:: ; heuristic: follows a terminator; C0
    and a, a
    jr nz, Jump_036_631F
    jp Jump_036_63E5

Jump_036_631F::
    cp a, $01
    jr nz, Jump_036_6326
    jp Jump_036_63F9

Jump_036_6326::
    cp a, $02
    jr nz, Jump_036_632D
    jp Jump_036_6435

Jump_036_632D::
    jp Jump_036_6449

Func_036_6330:: ; heuristic: follows a terminator; C0
    and a, a
    jr nz, Jump_036_6335
    scf
    ret

Jump_036_6335::
    cp a, $01
    jr nz, Jump_036_633C
    jp Jump_036_6373

Jump_036_633C::
    cp a, $02
    jr nz, Jump_036_6343
    jp Jump_036_637C

Jump_036_6343::
    jp Jump_036_6397

Func_036_6346::
    cp a, $02
    jr nc, Jump_036_634B
    ret

Jump_036_634B::
    jr nz, Jump_036_6350
    jp Jump_036_6373

Jump_036_6350::
    jp Jump_036_6385

Jump_036_6353::
    and a, a
    jr nz, Jump_036_6359
    jp Jump_036_637C

Jump_036_6359::
    cp a, $01
    jr nz, Jump_036_6360
    jp Jump_036_638E

Jump_036_6360::
    cp a, $02
    jr nz, Jump_036_6367
    jp Jump_036_63A0

Jump_036_6367::
    scf
    ccf
    ret

Jump_036_636A::
    call Func_000_3ED4
    ld a, [$C5E7]
    cp a, $D8
    ret

Jump_036_6373::
    call Func_000_3ED4
    ld a, [$C5E7]
    cp a, $BF
    ret

Jump_036_637C::
    call Func_000_3ED4
    ld a, [$C5E7]
    cp a, $7F
    ret

Jump_036_6385::
    call Func_000_3ED4
    ld a, [$C5E7]
    cp a, $66
    ret

Jump_036_638E::
    call Func_000_3ED4
    ld a, [$C5E7]
    cp a, $4C
    ret

Jump_036_6397::
    call Func_000_3ED4
    ld a, [$C5E7]
    cp a, $3F
    ret

Jump_036_63A0::
    call Func_000_3ED4
    ld a, [$C5E7]
    cp a, $26
    ret

Jump_036_63A9::
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    call Func_036_646C
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    ret

Jump_036_63BD::
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    call Func_036_6477
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    ret

Jump_036_63D1::
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    call Func_036_6494
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    ret

Jump_036_63E5::
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    call Func_036_64B2
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    ret

Jump_036_63F9::
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    call Func_036_651C
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    ret

Func_036_640D::
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    call Func_036_64CD
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    ret

Jump_036_6421::
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    call Func_036_64D4
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    ret

Jump_036_6435::
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    call Func_036_6518
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    ret

Jump_036_6449::
    xor a, a
    ld [$D872], a
    ld [$D873], a
    ret

Func_036_6451::
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    call Func_036_6465
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    ret

Func_036_6465::
    ld b, h
    ld c, l
    call Func_036_651C
    add hl, bc
    ret

Func_036_646C::
    ld b, h
    ld c, l
    call Func_036_6507
    add hl, bc
    call Func_036_6507
    add hl, bc
    ret

Func_036_6477::
    ld b, h
    ld c, l
    call Func_036_6503
    add hl, bc
    call Func_036_6507
    add hl, bc
    ret

Func_036_6482:: ; heuristic: follows a terminator; C0
    call Func_036_651C
    ld b, h
    ld c, l
    call Func_036_650B
    add hl, bc
    call Func_036_650B
    add hl, bc
    call Func_036_6507
    add hl, bc
    ret

Func_036_6494::
    push de
    ld b, h
    ld c, l
    ld a, $55
    call Func_000_16AA
    ld a, $64
    call Func_000_16E2
    pop de
    ret

Func_036_64A3::
    push de
    ld b, h
    ld c, l
    ld a, $08
    call Func_000_16AA
    ld a, $0A
    call Func_000_16E2
    pop de
    ret

Func_036_64B2::
    push bc
    call Func_036_651C
    ld b, h
    ld c, l
    call Func_036_650B
    add hl, bc
    pop bc
    ret

Func_036_64BE::
    push de
    ld b, h
    ld c, l
    ld a, $06
    call Func_000_16AA
    ld a, $0A
    call Func_000_16E2
    pop de
    ret

Func_036_64CD::
    call Func_036_64A3
    call Func_036_651C
    ret

Func_036_64D4::
    call Func_036_64BE
    call Func_036_651C
    ret

Func_036_64DB::
    ld bc, $0003
    call Func_000_3F04
    ret

Func_036_64E2:: ; heuristic: follows a terminator; C0
    call Func_036_64BE
    call Func_036_651C
    call Func_036_651C
    ret

Func_036_64EC:: ; heuristic: follows a terminator; C0
    call Func_036_64A3
    call Func_036_651C
    call Func_036_651C
    call Func_036_651C
    call Func_036_651C
    ret

Func_036_64FC:: ; heuristic: follows a terminator; C0
    call Func_036_7E65
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ret

Func_036_6503::
    srl b
    rr c

Func_036_6507::
    srl b
    rr c

Func_036_650B::
    srl b
    rr c
    ret

Func_036_6510:: ; heuristic: follows a terminator; C0
    srl h
    rr l
    srl h
    rr l

Func_036_6518::
    srl h
    rr l

Func_036_651C::
    srl h
    rr l
    ret

Func_036_6521:: ; heuristic: follows a terminator; C0
    ld [$D868], a
    call Func_036_7E33
    ld bc, $03E7
    call Func_000_3E7A
    jr nc, Jump_036_6554
    push hl
    ld a, [$D868]
    call Func_036_6634
    ld a, [$C58A]
    cp a, $01
    jr z, Jump_036_6544
    ld a, [$D868]
    cp a, $04
    jr nc, Jump_036_6548

Jump_036_6544::
    sla c
    rl b

Jump_036_6548::
    sla c
    rl b
    pop hl
    call Func_000_3E7A
    jr nc, Jump_036_6554

Jump_036_6552::
    scf
    ret

Jump_036_6554::
    jr z, Jump_036_6552
    xor a, a
    ret

Func_036_6558:: ; heuristic: follows a terminator; C0
    ld [$D868], a
    ld hl, $D91F
    call Func_036_64FC
    ld bc, $03E7
    call Func_000_3E7A
    jr z, Jump_036_6590
    jr nc, Jump_036_6590
    push hl
    ld a, [$D868]
    call Func_036_6646
    ld a, [$C58A]
    cp a, $01
    jr z, Jump_036_6544
    ld a, [$D868]
    cp a, $04
    jr nc, Jump_036_6584
    sla c
    rl b

Jump_036_6584::
    sla c
    rl b
    pop hl
    call Func_000_3E7A
    jr nc, Jump_036_6590

Jump_036_658E::
    scf
    ret

Jump_036_6590::
    jr z, Jump_036_658E
    xor a, a
    ret

Func_036_6594::
    call Func_036_65A9
    ld a, [hl+]
    ld [$D006], a
    ld a, [hl]
    ld [$D007], a
    ld hl, Func_036_4001
    ld b, $35
    rst $10
    ld a, [$D008]
    ret

Func_036_65A9::
    ld a, [$D8A5]
    add a, a
    ld hl, $D958
    add a, l
    ld l, a
    jr nc, Jump_036_65B5
    inc h

Jump_036_65B5::
    ret

Func_036_65B6::
    cp a, $03
    ret z
    push bc
    push hl
    ld b, a
    ld a, [$D8A4]
    ld hl, $D854
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_036_65C8
    inc h

Jump_036_65C8::
    ld a, [hl]
    and a, $04
    jr nz, Jump_036_65D1
    ld a, b
    pop hl
    pop bc
    ret

Jump_036_65D1::
    ld a, $04
    pop hl
    pop bc
    ret

Func_036_65D6:: ; heuristic: follows a terminator; C0
    push hl
    push bc
    ld b, a
    call Func_036_7E47
    push hl
    ld a, b
    call Func_036_7E3D
    pop bc
    call Func_000_3E7A
    pop bc
    pop hl
    ret

Func_036_65E8:: ; heuristic: follows a terminator; C0
    push hl
    ld c, a
    ld hl, Func_036_4001
    ld b, $3B
    rst $10
    ld a, [$DAC4]
    ld c, a
    ld a, [$DAC5]
    ld b, a
    ld hl, $03E7
    call Func_000_3E7A
    jr nc, Jump_036_6603
    ld bc, $03E7

Jump_036_6603::
    pop hl
    ret

Func_036_6605:: ; heuristic: follows a terminator; C0
    push hl
    ld c, a
    ld hl, $4045
    ld b, $3B
    rst $10
    ld a, [$DAC4]
    ld c, a
    ld a, [$DAC5]
    ld b, a
    ld hl, $03E7
    call Func_000_3E7A
    jr nc, Jump_036_6620
    ld bc, $03E7

Jump_036_6620::
    pop hl
    ret

Func_036_6622::
    push hl
    ld c, a
    ld hl, $4089
    ld b, $3B
    rst $10
    ld a, [$DAC4]
    ld c, a
    ld a, [$DAC5]
    ld b, a
    pop hl
    ret

Func_036_6634::
    push hl
    ld c, a
    ld hl, $40CD
    ld b, $3B
    rst $10
    ld a, [$DAC4]
    ld c, a
    ld a, [$DAC5]
    ld b, a
    pop hl
    ret

Func_036_6646::
    push hl
    ld c, a
    ld hl, $4111
    ld b, $3B
    rst $10
    ld a, [$DAC4]
    ld c, a
    ld a, [$DAC5]
    ld b, a
    pop hl
    ret

Func_036_6658:: ; heuristic: follows a terminator; C0
    ld b, a
    and a, $03
    cp a, $03
    jr z, Jump_036_6667
    ld a, b
    ld e, $31
    call Func_000_3F32
    jr Jump_036_669D

Jump_036_6667::
    ld a, b
    srl a
    srl a
    and a, $01
    ld hl, $DAAE
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_036_6677
    inc h

Jump_036_6677::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, l
    ld [$CFE6], a
    ld a, h
    ld [$CFE7], a
    ld hl, Func_036_4001
    ld b, $34
    rst $10
    ld a, [$CFEC]
    ld [$D006], a
    ld a, [$CFED]
    ld [$D007], a
    ld hl, Func_036_4001
    ld b, $35
    rst $10
    ld hl, $D01A

Jump_036_669D::
    ret

Func_036_669E:: ; heuristic: follows a terminator; C0
    ld b, a
    and a, $03
    cp a, $03
    jr z, Jump_036_66AF
    ld a, b
    ld e, $0E
    call Func_000_3F32
    ld b, $08
    jr Jump_036_66D5

Jump_036_66AF::
    ld a, b
    srl a
    srl a
    and a, $01
    ld hl, $DAAE
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_036_66BF
    inc h

Jump_036_66BF::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, l
    ld [$CFE6], a
    ld a, h
    ld [$CFE7], a
    ld hl, Func_036_4001
    ld b, $34
    rst $10
    ld hl, $CFEE
    ld b, $04

Jump_036_66D5::
    ret

Func_036_66D6:: ; heuristic: follows a terminator; C0
    push hl
    ld c, a
    ld hl, $42BB
    ld b, $3B
    rst $10
    pop hl
    ret

Func_036_66E0:: ; heuristic: follows a terminator; C0
    ld a, [$D8A5]
    add a, a
    ld hl, $D90F
    add a, l
    ld l, a
    jr nc, Jump_036_66EC
    inc h

Jump_036_66EC::
    push hl
    ld a, [hl+]
    ld c, a
    ld b, [hl]
    push bc
    srl b
    rr c
    ld [hl], b
    dec hl
    ld [hl], c
    call Func_036_5013
    pop bc
    pop hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    ret

Func_036_6701::
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_036_6707
    inc h

Jump_036_6707::
    push hl
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    call Func_000_3E7A
    jr nc, Jump_036_6712
    ld b, h
    ld c, l

Jump_036_6712::
    pop hl
    ld [hl], c
    inc hl
    ld [hl], b
    ret

Func_036_6717::
    ld a, [$D8A6]
    ld c, a
    ld b, $00
    ld hl, $6726
    add hl, bc
    add hl, bc
    call Func_000_000B
    ret
    db $75, $6B
    dw Func_036_6B7B
    dw Func_036_6B7B
    dw Func_036_6B7B
    dw Func_036_6B81
    dw Func_036_6B81
    dw Func_036_6B81
    dw Func_036_6B87
    dw Func_036_6B87
    dw Func_036_6B87
    dw Func_036_6B8D
    dw Func_036_6B8D
    dw Func_036_6B8D
    dw Func_036_6B93
    dw Func_036_6B93
    dw Func_036_6B93
    dw Func_036_6B99
    dw Func_036_6B99
    dw Func_036_6B99
    dw Func_036_6B9F
    dw Func_036_6B9F
    dw Func_036_6BC7
    dw Func_036_6C24
    dw Func_036_6C24
    dw Func_036_6C24
    dw Func_036_6C24
    dw Func_036_6C24
    dw Func_036_6C5E
    dw Func_036_6C5E
    dw Func_036_6C5E
    dw Func_036_6C9A
    dw Func_036_6CF5
    dw Func_036_6D20
    dw Func_036_6D4E
    dw Func_036_6D64
    dw Func_036_6D87
    dw Func_036_6DB5
    dw Func_036_6DCB
    dw Func_036_6DCB
    dw Func_036_6DF2
    dw Func_036_6DF2
    db $13, $6E, $13, $6E, $3A, $6E, $3A, $6E, $5B, $6E, $75, $6E, $A8, $6E, $A8, $6E
    db $E2, $6E, $FC, $6E, $96, $6F, $C1, $6F, $F1, $6F, $3D, $70, $3D, $70, $79, $70
    db $AE, $70, $CC, $70, $0F, $71, $4F, $71, $96, $71
    dw Func_036_71A9
    dw Func_036_6B93
    dw Func_036_71AF
    dw Func_036_71AF
    dw Func_036_71AF
    dw Func_036_71AF
    dw Func_036_71B8
    dw Func_036_71B8
    dw Func_036_71B8
    dw Func_036_71B8
    dw Func_036_71C1
    dw Func_036_71C7
    db $CD, $71
    dw Func_036_71D3
    dw Func_036_71D9
    dw Func_036_71D9
    dw Func_036_71DF
    dw Func_036_71DF
    dw Data_036_721A
    dw Data_036_7220
    dw Data_036_7226
    dw Data_036_722C
    dw Data_036_7232
    dw Data_036_7238
    dw Data_036_723E
    dw Data_036_7244
    dw Data_036_724A
    dw Data_036_7250
    dw Data_036_7256
    dw Data_036_725C
    dw Data_036_7262
    dw Data_036_7268
    db $6E
    dw $7472
    dw $7472
    dw $7472
    dw Func_036_7872
    db $72, $91, $72, $91, $72, $97, $72, $C4, $72, $CA, $72, $D0, $72, $E0, $72
    dw Func_036_72F9
    dw Func_036_7314
    dw Func_036_7353
    dw Func_036_7378
    dw Func_036_7387
    db $B7, $73, $BD, $73, $A8, $6E
    dw Func_036_73C3
    dw Func_036_73EC
    dw Func_036_73EC
    dw Func_036_7434
    dw Func_036_745D
    db $FC, $6E, $C1, $6F
    dw Func_036_6B9F
    dw Func_036_747E
    dw Func_036_74A0
    dw Func_036_6C24
    dw Func_036_74D1
    dw Func_036_74F2
    dw Func_036_74F6
    dw Func_036_753C
    dw Func_036_7571
    dw Func_036_757F
    dw Func_036_7599
    dw Func_036_7599
    dw Func_036_75AB
    dw Func_036_75AB
    dw Func_036_75AB
    dw Func_036_75AB
    dw Func_036_7627
    dw Func_036_7637
    dw Func_036_7645
    dw Func_036_7645
    dw Func_036_7697
    dw Func_036_7697
    dw Func_036_76CD
    dw Func_036_76F4
    dw Func_036_771B
    dw Func_036_77B5
    dw Func_036_77DE
    dw Func_036_7809
    dw Func_036_7836
    dw Func_036_7809
    dw Func_036_7844
    dw Func_036_7844
    dw Func_036_789B
    dw Func_036_789B
    dw Func_036_78DE
    dw Func_036_78EC
    dw Func_036_78FA
    dw Func_036_7931
    db $3F, $79, $4F, $79, $9B, $79, $EC, $79, $EC, $79, $EC, $79, $EC, $79, $EC, $79
    db $EC, $79, $EC, $79, $EC, $79, $ED, $79, $A5, $7B, $06, $7A, $C1, $6F, $F1, $6F
    db $74, $6B
    dw Func_036_7A18
    dw Func_036_6C24
    dw Func_036_7A18
    dw Func_036_7599
    dw Func_036_7A8E
    dw Func_036_7AAC
    dw Func_036_7AD5
    db $A5, $7B, $0F, $71, $EE, $7A
    dw Func_036_7AF4
    dw Func_036_6CF5
    dw Func_036_7B09
    dw Func_036_7B36
    db $74, $6B
    dw Func_036_7C2C
    dw Func_036_7B6B
    dw Func_036_7B89
    dw Func_036_7BA1
    db $A5, $7B, $A5, $7B
    dw Func_036_7BA8
    dw Func_036_7BB6
    dw Func_036_7BB6
    dw Func_036_7BC9
    dw Func_036_7BF8
    dw Func_036_7BF8
    dw Func_036_7C2C
    dw Func_036_7C5F
    dw Func_036_7C6B
    dw Func_036_7C77
    dw Func_036_7C7A
    dw Func_036_6906
    dw Func_036_6912
    dw Func_036_691E
    dw Func_036_692A
    dw Func_036_6936
    dw Func_036_6942
    dw Func_036_694E
    dw Func_036_6957
    dw Func_036_6963
    db $6F, $69
    dw Func_036_697B
    dw Func_036_69ED
    dw Func_036_6A69
    dw Func_036_6A82
    dw Func_036_6ACA
    dw Func_036_6AE7
    dw Func_036_6AF0
    dw Func_036_6B0F
    dw Func_036_6B18
    dw Func_036_6B42
    db $74
    dw Func_036_746B
    dw Func_036_746B
    dw Func_036_746B
    dw Func_036_746B
    dw Func_036_746B
    dw Func_036_746B
    dw Func_036_746B
    dw Func_036_746B
    dw Func_036_746B
    dw Func_036_746B
    dw Func_036_746B
    db $6B

Func_036_6906:: ; heuristic: target of a pointer table; C0
    call Func_036_5207
    ld hl, $413F
    ld b, $A3
    rst $10
    jp Jump_036_7C7D

Func_036_6912:: ; heuristic: target of a pointer table; C0
    call Func_036_5094
    ld hl, $413F
    ld b, $A3
    rst $10
    jp Jump_036_7C7D

Func_036_691E:: ; heuristic: target of a pointer table; C0
    call Func_036_509D
    ld hl, $413F
    ld b, $A3
    rst $10
    jp Func_036_7C85

Func_036_692A:: ; heuristic: target of a pointer table; C0
    call Func_036_50B2
    ld hl, $413F
    ld b, $A3
    rst $10
    jp Func_036_7C85

Func_036_6936:: ; heuristic: target of a pointer table; C0
    call Func_036_50C7
    ld hl, $413F
    ld b, $A3
    rst $10
    jp Func_036_7C85

Func_036_6942:: ; heuristic: target of a pointer table; C0
    call Func_036_5A6C
    ld hl, $413F
    ld b, $A3
    rst $10
    jp Func_036_7C85

Func_036_694E:: ; heuristic: target of a pointer table; C0
    ld hl, $413F
    ld b, $A3
    rst $10
    jp Func_036_6BC7

Func_036_6957:: ; heuristic: target of a pointer table; C0
    ld hl, $413F
    ld b, $A3
    rst $10
    call Func_036_50DC
    jp Func_036_7C85

Func_036_6963:: ; heuristic: target of a pointer table; C0
    ld hl, $413F
    ld b, $A3
    rst $10
    call Func_036_511D
    jp Func_036_7C85
    db $CD, $52, $51, $21, $3F, $41, $06, $A3, $D7, $C3, $85, $7C

Func_036_697B:: ; heuristic: target of a pointer table; C0
    ld hl, $413F
    ld b, $A3
    rst $10
    xor a, a
    ldh [$FFC6], a
    call Func_036_7D33
    or a, a
    jr z, Jump_036_6990
    ld [hl], $00
    ld a, $01
    ldh [$FFC6], a

Jump_036_6990::
    ld a, [$D8A5]
    ld hl, $D8BF
    call Func_036_7E65
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld a, [$D8A5]
    ld hl, $D8CF
    call Func_036_7E65
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    call Func_000_3E7A
    jr z, Jump_036_69B4
    call Func_036_5223
    ld a, $01
    ldh [$FFC6], a

Jump_036_69B4::
    ld a, [$D8A5]
    ld hl, $D8DF
    call Func_036_7E65
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    dec hl
    ld e, l
    ld d, h
    ld a, [$D8A5]
    ld hl, $D8EF
    call Func_036_7E65
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    call Func_000_3E7A
    jr z, Jump_036_69DD
    ld a, l
    ld [de], a
    inc de
    ld a, h
    ld [de], a
    ld a, $01
    ldh [$FFC6], a

Jump_036_69DD::
    ldh a, [$FFC6]
    or a, a
    jr z, Jump_036_69EA
    ld l, $37
    ld bc, $4090
    jp Jump_036_7CA3

Jump_036_69EA::
    jp Jump_036_7CB0

Func_036_69ED:: ; heuristic: target of a pointer table; C0
    ld hl, $413F
    ld b, $A3
    rst $10
    call Func_036_7D33
    call Func_000_3ED4
    ld a, [$C5E7]
    sra a
    sra a
    and a, $03
    sla a
    sla a
    ld de, Func_036_6A59
    add a, e
    ld e, a
    jr nc, Jump_036_6A0E
    inc d

Jump_036_6A0E::
    ld a, [de]
    inc de
    ld c, a
    ld a, [hl]
    or a, c
    ld [hl], a
    ld a, [$D8A6]
    push af
    push de
    ld a, [de]
    cp a, $FF
    jr z, Jump_036_6A4B
    ld [$D8A6], a
    ld a, [$DAD3]
    ldh [$FFC6], a
    ld a, [$DAD2]
    ldh [$FFC7], a
    ld a, $41
    ld [$DAD2], a
    ld a, $30
    ld [$DAD3], a
    ld hl, Func_036_4001
    ld b, $3A
    rst $10
    ld hl, $5762
    ld b, $3A
    rst $10
    ldh a, [$FFC6]
    ld [$DAD3], a
    ldh a, [$FFC7]
    ld [$DAD2], a

Jump_036_6A4B::
    pop de
    inc de
    pop af
    ld [$D8A6], a
    ld a, [de]
    ld l, a
    ld bc, $4090
    jp Jump_036_7CA3

Func_036_6A59:: ; heuristic: follows a terminator; C0
    ld [bc], a
    cpl
    ld [hl], a
    nop
    jr nz, Jump_036_6A93
    reti
    db $00, $40, $2F, $76, $00, $10, $34, $42, $00

Func_036_6A69:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    push af
    ld hl, $414F
    ld b, $A3
    rst $10
    ldh a, [$FFC6]
    ld [$D8A4], a
    call Func_036_710F
    pop af
    ld [$D8A4], a
    jp Func_036_710F

Func_036_6A82:: ; heuristic: target of a pointer table; C0
    ld hl, $413F
    ld b, $A3
    rst $10
    ld a, [$D8A5]
    ld hl, $D80D
    call Func_000_3F25
    set 2, [hl]

Jump_036_6A93::
    push hl
    call Func_000_3ED4
    pop hl
    ld a, $04
    add a, l
    ld l, a
    jr nc, Jump_036_6A9F
    inc h

Jump_036_6A9F::
    ld a, [$C5E7]
    and a, $04
    add a, $04
    ld b, a
    ld a, [hl]
    and a, $F3
    or a, b
    ld [hl], a
    call Func_036_5360
    jr nc, Jump_036_6AB7
    ld a, [$D8A5]
    call Func_036_7D45

Jump_036_6AB7::
    call Func_036_5441
    jr nc, Jump_036_6AC2
    ld a, [$D8A5]
    call Func_036_7D45

Jump_036_6AC2::
    ld l, $93
    ld bc, $0090
    jp Func_036_7C9C

Func_036_6ACA:: ; heuristic: target of a pointer table; C0
    ld hl, $413F
    ld b, $A3
    rst $10
    ld a, [$D8A5]
    ld hl, $D80D
    call Func_000_3F25
    set 0, [hl]
    set 6, [hl]
    set 7, [hl]
    ld l, $9E
    ld bc, $0090
    jp Func_036_7C9C

Func_036_6AE7:: ; heuristic: target of a pointer table; C0
    ld hl, $413F
    ld b, $A3
    rst $10
    jp Func_036_6EFC

Func_036_6AF0:: ; heuristic: target of a pointer table; C0
    ld hl, $413F
    ld b, $A3
    rst $10
    ld a, [$D8A4]
    push af
    ld hl, $414F
    ld b, $A3
    rst $10
    ldh a, [$FFC6]
    ld [$D8A4], a
    call Func_036_7809
    pop af
    ld [$D8A4], a
    jp Func_036_7809

Func_036_6B0F:: ; heuristic: target of a pointer table; C0
    ld hl, $413F
    ld b, $A3
    rst $10
    jp Func_036_6FC1

Func_036_6B18:: ; heuristic: target of a pointer table; C0
    ld hl, $413F
    ld b, $A3
    rst $10
    ld a, [$D8A4]
    and a, $04
    ldh [$FFC6], a
    ld b, $04

Jump_036_6B27::
    ldh a, [$FFC6]
    ld c, a
    call Func_000_3E54
    jr c, Jump_036_6B38
    ld a, c
    ld hl, $D813
    call Func_000_3F25
    set 1, [hl]

Jump_036_6B38::
    ld hl, $FFC6
    inc [hl]
    dec b
    jr nz, Jump_036_6B27
    jp Jump_036_7CD3

Func_036_6B42:: ; heuristic: target of a pointer table; C0
    ld hl, $413F
    ld b, $A3
    rst $10
    ld a, [$D8A4]
    and a, $04
    ldh [$FFC6], a
    ld b, $03

Jump_036_6B51::
    ldh a, [$FFC6]
    ld c, a
    call Func_000_3E54
    jr c, Jump_036_6B6A
    ldh a, [$FFC6]
    ld hl, $D80D
    call Func_000_3F25
    set 3, [hl]
    inc hl
    inc hl
    inc hl
    res 6, [hl]
    set 7, [hl]

Jump_036_6B6A::
    ld hl, $FFC6
    inc [hl]
    dec b
    jr nz, Jump_036_6B51
    jp Jump_036_7CD3
    db $C9

Func_036_6B75::
    call Func_036_5013
    jp Func_036_7C85

Func_036_6B7B:: ; heuristic: target of a pointer table; C0
    call Func_036_51D1
    jp Jump_036_7C7D

Func_036_6B81:: ; heuristic: target of a pointer table; C0
    call Func_036_51DF
    jp Jump_036_7C7D

Func_036_6B87:: ; heuristic: target of a pointer table; C0
    call Func_036_51ED
    jp Jump_036_7C7D

Func_036_6B8D:: ; heuristic: target of a pointer table; C0
    call Func_036_51F9
    jp Jump_036_7C7D

Func_036_6B93:: ; heuristic: target of a pointer table; C0
    call Func_036_5207
    jp Jump_036_7C7D

Func_036_6B99:: ; heuristic: target of a pointer table; C0
    call Func_036_5215
    jp Jump_036_7C7D

Func_036_6B9F:: ; heuristic: target of a pointer table; C0
    call Func_036_5B19
    jr nc, Jump_036_6BC4
    ld a, [$D8A5]
    ld hl, $D8BF
    call Func_036_7E65
    xor a, a
    ld [hl+], a
    ld [hl], a
    ld hl, $03E8
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    ld hl, $B58E
    ld bc, $80A8
    jp Jump_036_7C8B

Jump_036_6BC4::
    jp Jump_036_7CB7

Func_036_6BC7:: ; heuristic: target of a pointer table; C0
    call Func_036_5ED8
    jr nc, Jump_036_6C21
    call Func_000_3ED4
    ld a, [$C5E7]
    and a, $01
    jr z, Jump_036_6C01
    ld a, [$D8A5]
    call Func_036_7E42
    push hl
    ld a, $64
    call Func_000_16D1
    ld a, h
    or a, l
    jr nz, Jump_036_6BE9
    ld hl, $0001

Jump_036_6BE9::
    pop bc
    ld a, c
    sub a, l
    ld c, a
    ld a, b
    sbc a, h
    ld b, a
    or a, c
    jr nz, Jump_036_6BF6
    ld bc, $0001

Jump_036_6BF6::
    ld a, c
    ld [$D872], a
    ld a, b
    ld [$D873], a
    jp Jump_036_7C7D

Jump_036_6C01::
    ld a, [$D8A5]
    ld hl, $D8BF
    call Func_036_7E65
    xor a, a
    ld [hl+], a
    ld [hl], a
    ld hl, $03E8
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    ld hl, $B58F
    ld bc, $80A8
    jp Jump_036_7C8B

Jump_036_6C21::
    jp Jump_036_7CB7

Func_036_6C24:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A5]
    call Func_000_3E54
    jr nc, Jump_036_6C30
    jr z, Jump_036_6C5B
    jr Jump_036_6C58

Jump_036_6C30::
    ld a, [$D8A5]
    ld hl, $D8BF
    call Func_036_7E65
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld a, [$D8A5]
    ld hl, $D8CF
    call Func_036_7E65
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    call Func_000_3E7A
    jr z, Jump_036_6C58
    call Func_036_5223
    ld l, $37
    ld bc, $4090
    jp Jump_036_7CA3

Jump_036_6C58::
    jp Jump_036_7CB0

Jump_036_6C5B::
    jp Jump_036_7CD3

Func_036_6C5E:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A5]
    call Func_000_3E54
    jr nc, Jump_036_6C6A
    jr z, Jump_036_6C97
    jr Jump_036_6C94

Jump_036_6C6A::
    ld a, [$D8A5]
    ld hl, $D8DF
    call Func_036_7E65
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld a, [$D8A5]
    ld hl, $D8EF
    call Func_036_7E65
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    call Func_000_3E7A
    jr z, Jump_036_6C94
    call Func_036_52DF
    jr nc, Jump_036_6C94
    ld l, $C3
    ld bc, $4090
    jp Jump_036_7CA3

Jump_036_6C94::
    jp Jump_036_7CB0

Jump_036_6C97::
    jp Jump_036_7CD3

Func_036_6C9A:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A5]
    call Func_000_3E54
    jp nc, Jump_036_6D1A
    jp z, Jump_036_6D1D
    call Func_000_3ED4
    ld a, [$C5E7]
    and a, $01
    jr z, Jump_036_6CED
    ld a, [$D8A5]
    ld b, a
    ld hl, $D8CF
    call Func_036_7E65
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    srl d
    rr e

Jump_036_6CC1::
    ld a, b
    ld hl, $D8BF
    call Func_036_7E65
    ld a, e
    ld [hl+], a
    ld [hl], d
    call Func_036_7E87
    jr c, Jump_036_6CE2
    ld a, [$D8A5]
    ld b, a
    add a, a
    ld de, $D958
    add a, e
    ld e, a
    jr nc, Jump_036_6CDD
    inc d

Jump_036_6CDD::
    call Func_036_4E26
    jr Jump_036_6CE2

Jump_036_6CE2::
    call Func_036_7D79
    ld l, $50
    ld bc, $4090
    jp Func_036_7C9C

Jump_036_6CED::
    ld h, $67
    ld bc, $0080
    jp Jump_036_7CBC

Func_036_6CF5:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A5]
    and a, $03
    cp a, $03
    jr z, Jump_036_6D1D
    ld a, [$D8A5]
    call Func_000_3E54
    jp nc, Jump_036_6D1A
    jp z, Jump_036_6D1D

Func_036_6D0A::
    ld a, [$D8A5]
    ld b, a
    ld hl, $D8CF
    call Func_036_7E65
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    jp Jump_036_6CC1

Jump_036_6D1A::
    jp Jump_036_7CB0

Jump_036_6D1D::
    jp Jump_036_7CD3

Func_036_6D20:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A5]
    ld hl, $D8A4
    cp a, [hl]
    jr z, Jump_036_6D1D
    ld a, [$D8A5]
    and a, $03
    cp a, $03
    jr z, Jump_036_6D1D
    ld a, [$D8A5]
    call Func_000_3E54
    jr nc, Jump_036_6D45
    jr z, Jump_036_6D1D
    call Func_036_6D0A
    ld hl, $DAC0
    set 6, [hl]
    ret

Jump_036_6D45::
    call Func_036_6C24
    ld hl, $DAC0
    res 6, [hl]
    ret

Func_036_6D4E:: ; heuristic: target of a pointer table; C0
    call Func_036_7D33
    and a, $03
    jr z, Jump_036_6D61
    ld a, [hl]
    and a, $FC
    ld [hl], a
    ld l, $4E
    ld bc, $4090
    jp Func_036_7C9C

Jump_036_6D61::
    jp Jump_036_7CB0

Func_036_6D64:: ; heuristic: target of a pointer table; C0
    call Func_036_7D33
    and a, $10
    jr z, Jump_036_6D84
    ld a, [hl]
    and a, $EF
    ld [hl], a
    ld a, [$D8A5]
    ld hl, $DA5B
    add a, l
    ld l, a
    jr nc, Jump_036_6D7A
    inc h

Jump_036_6D7A::
    ld [hl], $03
    ld l, $83
    ld bc, $4090
    jp Func_036_7C9C

Jump_036_6D84::
    jp Jump_036_7CB0

Func_036_6D87:: ; heuristic: target of a pointer table; C0
    call Func_036_7D33
    and a, $CC
    jr z, Jump_036_6DB2
    push hl
    bit 6, [hl]
    jr z, Jump_036_6D97
    ld l, $4F
    jr Jump_036_6D99

Jump_036_6D97::
    ld l, $82

Jump_036_6D99::
    ld bc, $4090
    call Func_036_7C9C
    pop hl
    ld a, [hl]
    and a, $33
    ld [hl], a
    ld a, [$D8A5]
    ld hl, $DA5B
    add a, l
    ld l, a
    jr nc, Jump_036_6DAF
    inc h

Jump_036_6DAF::
    ld [hl], $03
    ret

Jump_036_6DB2::
    jp Jump_036_7CB0

Func_036_6DB5:: ; heuristic: target of a pointer table; C0
    call Func_036_7D33
    and a, $20
    jr z, Jump_036_6DC8
    ld a, [hl]
    and a, $DF
    ld [hl], a
    ld l, $51
    ld bc, $4090
    jp Func_036_7C9C

Jump_036_6DC8::
    jp Jump_036_7CB0

Func_036_6DCB:: ; heuristic: target of a pointer table; C0
    call Func_036_5360
    jr nc, Jump_036_6DEA
    ld a, [$D8A5]
    call Func_036_7D45
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    ld a, l
    or a, h
    jr z, Jump_036_6DEA
    ld l, $45
    ld bc, $0090
    jp Jump_036_7CA3

Jump_036_6DEA::
    ld h, $CC
    ld bc, $0084
    jp Jump_036_7CBC

Func_036_6DF2:: ; heuristic: target of a pointer table; C0
    call Func_036_53C6
    jp nc, Jump_036_7CB7

Func_036_6DF8::
    call Func_036_53EF
    jr nc, Jump_036_6E0B
    ld a, [$D8A5]
    call Func_036_7D50
    ld l, $39
    ld bc, $0098
    jp Jump_036_7CA3

Jump_036_6E0B::
    ld h, $CC
    ld bc, $0084
    jp Jump_036_7CBC

Func_036_6E13:: ; heuristic: follows a terminator; C0
    call Func_036_5441
    jr nc, Jump_036_6E32
    ld a, [$D8A5]
    call Func_036_7D45
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    ld a, l
    or a, h
    jr z, Jump_036_6E32
    ld l, $49
    ld bc, $0090
    jp Jump_036_7CA3

Jump_036_6E32::
    ld h, $CC
    ld bc, $0084
    jp Jump_036_7CBC
    db $CD, $A7, $54, $D2, $B7, $7C

Func_036_6E40::
    call Func_036_54BE
    jr nc, Jump_036_6E53
    ld a, [$D8A5]
    call Func_036_7D50
    ld l, $48
    ld bc, $0098
    jp Jump_036_7CA3

Jump_036_6E53::
    ld h, $CC
    ld bc, $0084
    jp Jump_036_7CBC

Func_036_6E5B:: ; heuristic: follows a terminator; C0
    ld a, [$D8A5]
    ld hl, $D80D
    call Func_000_3F25
    bit 2, [hl]
    jr nz, Jump_036_6E72
    set 2, [hl]
    ld l, $43
    ld bc, $0090
    jp Func_036_7C9C

Jump_036_6E72::
    jp Jump_036_7CD3

Func_036_6E75::
    ld a, [$D8A5]
    ld hl, $D80D
    call Func_000_3F25
    bit 1, [hl]
    jr nz, Jump_036_6E9A
    call Func_036_55FB
    jr nc, Jump_036_6EA5
    ld a, [$D8A5]
    ld hl, $D80D
    call Func_000_3F25
    set 1, [hl]
    ld l, $4A
    ld bc, $0090
    jp Func_036_7C9C

Jump_036_6E9A::
    ld a, [$DAC0]
    and a, $EF
    ld [$DAC0], a
    jp Jump_036_7CD3

Jump_036_6EA5::
    jp Jump_036_7CB7

Func_036_6EA8:: ; heuristic: follows a terminator; C0
    ld a, [$D8A5]
    ld hl, $D80C
    call Func_000_3F25
    ld a, [hl]
    and a, $8C
    jr nz, Jump_036_6EDA
    push hl
    call Func_036_5F01
    pop hl
    jr nc, Jump_036_6EC9
    ld a, [hl]
    or a, $8C
    ld [hl], a
    ld l, $73
    ld bc, $4098
    jp Func_036_7C9C

Jump_036_6EC9::
    ld a, [$D8A6]
    cp a, $71
    ld h, $B5
    jr z, Jump_036_6ED4
    ld h, $CE

Jump_036_6ED4::
    ld bc, $0080
    jp Jump_036_7CBC

Jump_036_6EDA::
    ld h, $D4
    ld bc, $0080
    jp Jump_036_7CBC

Func_036_6EE2:: ; heuristic: follows a terminator; C0
    ld a, [$D8A4]
    ld hl, $D80E
    call Func_000_3F25
    bit 0, [hl]
    jr nz, Jump_036_6EF9
    set 0, [hl]
    ld l, $3F
    ld bc, $0090
    jp Func_036_7C9C

Jump_036_6EF9::
    jp Jump_036_7CD3

Func_036_6EFC:: ; heuristic: follows a terminator; C0
    ld a, [$D8A5]
    ld hl, $D8DF
    call Func_036_7E65
    ld a, [hl+]
    or a, [hl]
    jp z, Jump_036_6F93
    ld a, [$D8A6]
    cp a, $DF
    jr z, Jump_036_6F2D
    ld a, [$D8A4]
    call Func_036_7E47
    ld a, [$D8A4]
    ld de, $D8EF
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_036_6F23
    inc d

Jump_036_6F23::
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    call Func_000_3E7A
    jr nc, Jump_036_6F93

Jump_036_6F2D::
    call Func_036_5626
    jr nc, Jump_036_6F93
    ld a, [$D8A5]
    ld hl, $D8DF
    call Func_036_7E65
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    ld b, a
    sra b
    rr c
    ld a, c
    ld [$C982], a
    ld a, b
    ld [$C983], a
    call Func_036_5640
    ld a, [$D8A6]
    cp a, $DF
    jr nz, Jump_036_6F8B
    ld hl, $414F
    ld b, $A3
    rst $10
    ld a, [$D8A4]
    push af
    ldh a, [$FFC6]
    ld [$D8A4], a
    call Func_036_5640
    pop af
    ld [$D8A4], a
    ld a, [$D8A5]
    ld hl, $D8DF
    call Func_036_7E65
    xor a, a
    ld [hl+], a
    ld [hl], a
    ld a, [$C982]
    ld c, a
    ld a, [$C983]
    ld b, a
    sla c
    rl b
    ld a, c
    ld [$D872], a
    ld a, b
    ld [$D873], a

Jump_036_6F8B::
    ld l, $3D
    ld bc, $4098
    jp Jump_036_7CA3

Jump_036_6F93::
    jp Jump_036_7CD3

Func_036_6F96:: ; heuristic: follows a terminator; C0
    ld a, [$D8A5]
    ld hl, $D80D
    call Func_000_3F25
    bit 0, [hl]
    jr nz, Jump_036_6FBB
    call Func_036_56CB
    jr nc, Jump_036_6FBE
    ld a, [$D8A5]
    ld hl, $D80D
    call Func_000_3F25
    set 0, [hl]
    ld l, $3B
    ld bc, $4098
    jp Func_036_7C9C

Jump_036_6FBB::
    jp Jump_036_7CD3

Jump_036_6FBE::
    jp Jump_036_7CB7

Func_036_6FC1:: ; heuristic: follows a terminator; C0
    ld a, [$D8A5]
    ld hl, $D80C
    call Func_000_3F25
    bit 4, [hl]
    jr nz, Jump_036_6FE6
    call Func_036_56E0
    jr nc, Jump_036_6FEE
    ld a, [$D8A5]
    ld hl, $D80C
    call Func_000_3F25
    set 4, [hl]
    ld l, $42
    ld bc, $4098
    jp Func_036_7C9C

Jump_036_6FE6::
    ld h, $CF
    ld bc, $0084
    jp Jump_036_7CBC

Jump_036_6FEE::
    jp Jump_036_7CB7

Func_036_6FF1:: ; heuristic: follows a terminator; C0
    ld a, [$C58A]
    cp a, $01
    jr z, Jump_036_700D
    ld a, [$D8A5]
    cp a, $04
    jr c, Jump_036_700D
    ld hl, $D811
    call Func_000_3F25
    ld b, $01
    ld a, [$D8A5]
    ld c, a
    jr Jump_036_701B

Jump_036_700D::
    ld b, $04
    ld a, [$D8A5]
    and a, $04
    ld c, a
    ld hl, $D811
    call Func_000_3F25

Jump_036_701B::
    ld a, c
    call Func_000_3E54
    jr c, Jump_036_7025
    ld a, [hl]
    or a, $C0
    ld [hl], a

Jump_036_7025::
    ld a, $09
    add a, l
    ld l, a
    jr nc, Jump_036_702C
    inc h

Jump_036_702C::
    inc c
    dec b
    jr nz, Jump_036_701B
    ld hl, $7B66
    ld b, $3A
    rst $10
    ld l, d
    ld bc, $0090
    jp Func_036_7C9C

Func_036_703D:: ; heuristic: follows a terminator; C0
    ld a, [$D8A4]
    ld hl, $D80E
    call Func_000_3F25
    ld a, [$D8A6]
    cp a, $37
    jr z, Jump_036_705F
    bit 5, [hl]
    jr nz, Jump_036_7071
    ld a, [hl]
    and a, $DD
    or a, $20
    ld [hl], a
    ld l, $4B
    ld bc, $0090
    jp Func_036_7C9C

Jump_036_705F::
    bit 1, [hl]
    jr nz, Jump_036_7071
    ld a, [hl]
    and a, $DD
    or a, $02
    ld [hl], a
    ld l, $4C
    ld bc, $0090
    jp Func_036_7C9C

Jump_036_7071::
    ld h, $CC
    ld bc, $0084
    jp Jump_036_7CBC

Func_036_7079:: ; heuristic: follows a terminator; C0
    ld a, [$D8A5]
    and a, $04
    ld c, a
    ld b, $04
    ld d, $00

Jump_036_7083::
    ld a, c
    ld hl, $D80E
    call Func_000_3F25
    ld a, c
    call Func_000_3E54
    jr c, Jump_036_7099
    bit 2, [hl]
    jr nz, Jump_036_709B
    inc d
    set 2, [hl]
    jr Jump_036_709B

Jump_036_7099::
    res 2, [hl]

Jump_036_709B::
    inc c
    dec b
    jr nz, Jump_036_7083
    ld a, d
    or a, a
    jr z, Jump_036_70AB
    ld l, $4D
    ld bc, $0090
    jp Func_036_7C9C

Jump_036_70AB::
    jp Jump_036_7CD3

Func_036_70AE:: ; heuristic: follows a terminator; C0
    ld a, [$D8A4]
    and a, $04
    ld c, a
    ld b, $03

Jump_036_70B6::
    ld a, c
    call Func_000_3E54
    jr c, Jump_036_70C5
    ld a, c
    ld hl, $D814
    call Func_000_3F25
    set 6, [hl]

Jump_036_70C5::
    inc c
    dec b
    jr nz, Jump_036_70B6
    jp Jump_036_7CD3

Func_036_70CC:: ; heuristic: follows a terminator; C0
    ld l, $52
    ld bc, $4090
    call Func_036_7C9C
    call Func_036_5703
    ld a, [$D8A4]
    ld hl, $DAD8
    add a, l
    ld l, a
    jr nc, Jump_036_70E2
    inc h

Jump_036_70E2::
    ld a, [hl]
    and a, $F8
    ld [hl], a
    ld a, [$D8A4]
    ld hl, $D80D
    call Func_000_3F25
    set 5, [hl]
    res 4, [hl]
    ret

Func_036_70F4::
    ld a, [$C58A]
    cp a, $01
    ret z
    ld a, [$D8A4]
    cp a, $04
    ret c
    and a, $03
    ld hl, $DAD4
    add a, l
    ld l, a
    jr nc, Jump_036_710A
    inc h

Jump_036_710A::
    ld a, [$D8A5]
    ld [hl], a
    ret

Func_036_710F:: ; heuristic: follows a terminator; C0
    call Func_036_5F25
    ld a, [$D8A4]
    ld hl, $DAD8
    add a, l
    ld l, a
    jr nc, Jump_036_711D
    inc h

Jump_036_711D::
    ld a, [hl]
    and a, $F8
    ld [hl], a
    ld a, [$D8A4]
    ld hl, $D80D
    call Func_000_3F25
    set 4, [hl]
    res 5, [hl]
    ld a, [$D8A4]
    ld c, a
    ld hl, Data_036_5E1E
    ld b, $32
    rst $10
    ld a, [$D8A6]
    cp a, $DC
    jr z, Jump_036_7147
    ld l, $44
    ld bc, $4090
    jp Func_036_7C9C

Jump_036_7147::
    ld l, $F7
    ld bc, $4090
    jp Func_036_7C9C
    INCBIN "dwm2-cobi-us.gbc", $0DB14F, $44

Data_036_7193:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $CB, $CF, $C9, $FA, $66, $D8, $6F, $FA, $67, $D8, $67, $7D, $B4, $CA, $B7, $7C
    db $CD, $5C, $58, $C3, $7D, $7C

Func_036_71A9:: ; heuristic: target of a pointer table; C0
    call Func_036_5328
    jp Jump_036_7C7D

Func_036_71AF:: ; heuristic: target of a pointer table; C0
    call Func_036_5336
    call Func_036_7D13
    jp Jump_036_7C7D

Func_036_71B8:: ; heuristic: target of a pointer table; C0
    call Func_036_5344
    call Func_036_7D13
    jp Jump_036_7C7D

Func_036_71C1:: ; heuristic: target of a pointer table; C0
    call Func_036_58C5
    jp Jump_036_7C7D

Func_036_71C7:: ; heuristic: target of a pointer table; C0
    call Func_036_592E
    jp Jump_036_7C7D
    db $CD, $93, $59, $C3, $7D, $7C

Func_036_71D3:: ; heuristic: target of a pointer table; C0
    call Func_036_5352
    jp Jump_036_7C7D

Func_036_71D9:: ; heuristic: target of a pointer table; C0
    call Func_036_60B4
    jp Jump_036_7C7D

Func_036_71DF:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    ld hl, $D812
    call Func_000_3F25
    bit 0, [hl]
    jr nz, Jump_036_7214
    push hl
    call Func_000_3ED4
    pop hl
    ld a, [$C5E7]
    cp a, $80
    jr c, Jump_036_720C
    set 0, [hl]
    ld d, $53
    ld hl, Data_036_7193
    ld b, $3A
    rst $10
    ld a, $03
    ld [$CFCA], a
    xor a, a
    ld [$CFCB], a
    ret

Jump_036_720C::
    ld h, $69
    ld bc, $0080
    jp Jump_036_7CBC

Jump_036_7214::
    call Func_036_5DCF
    jp Func_036_7C85

Data_036_721A:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $22, $55, $C3, $85, $7C

Data_036_7220:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $33, $55, $C3, $85, $7C

Data_036_7226:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $44, $55, $C3, $85, $7C

Data_036_722C:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $55, $55, $C3, $85, $7C

Data_036_7232:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $66, $55, $C3, $85, $7C

Data_036_7238:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $71, $55, $C3, $85, $7C

Data_036_723E:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $7C, $55, $C3, $85, $7C

Data_036_7244:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $87, $55, $C3, $85, $7C

Data_036_724A:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $92, $55, $C3, $85, $7C

Data_036_7250:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $9D, $55, $C3, $85, $7C

Data_036_7256:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $A8, $55, $C3, $85, $7C

Data_036_725C:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $B3, $55, $C3, $85, $7C

Data_036_7262:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $BE, $55, $C3, $85, $7C

Data_036_7268:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0DB268, $78

Func_036_72E0::
    call Func_036_5013
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    call Func_036_6465
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    jp Func_036_7C85

Func_036_72F9:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    ld hl, $D810
    call Func_000_3F25
    ld a, [hl]
    and a, $0C
    jr nz, Jump_036_730E
    ld a, [hl]
    or a, $0C
    ld [hl], a
    jp Jump_036_7CD3

Jump_036_730E::
    ld a, [hl]
    and a, $F3
    ld [hl], a
    jr Func_036_72E0

Func_036_7314:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A5]
    call Func_000_3E25
    jr c, Jump_036_7326
    call Func_000_3ED4
    ld a, [$C5E7]
    cp a, $A0
    jr c, Jump_036_734B

Jump_036_7326::
    ld a, [$D8A4]
    ld hl, $D80E
    call Func_000_3F25
    res 7, [hl]
    ld a, [$D8A4]
    call Func_036_7E2E
    call Func_036_4930
    ld a, e
    ld [$D872], a
    ld a, d
    ld [$D873], a
    ld hl, $D235
    ld bc, $80A8
    jp Jump_036_7C8B

Jump_036_734B::
    ld h, $D2
    ld bc, $0080
    jp Jump_036_7CBC

Func_036_7353:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    ld hl, $D80E
    call Func_000_3F25
    res 7, [hl]
    ld a, [$D8A4]
    call Func_036_7E2E
    call Func_036_4930
    ld a, e
    ld [$D872], a
    ld a, d
    ld [$D873], a
    ld hl, $B535
    ld bc, $80A8
    jp Jump_036_7C8B

Func_036_7378:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    ld hl, $D80E
    call Func_000_3F25
    res 7, [hl]
    call Func_036_72E0
    ret

Func_036_7387:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    ld hl, $D812
    call Func_000_3F25
    set 2, [hl]
    ld a, [$D8A4]
    ld hl, $D80E
    call Func_000_3F25
    res 7, [hl]
    call Func_036_5013
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    sla l
    rl h
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    jp Func_036_7C85
    db $CD, $7A, $5A, $C3, $85, $7C, $CD, $98, $5A, $C3, $7D, $7C

Func_036_73C3:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A5]
    ld hl, $D80C
    call Func_000_3F25
    bit 6, [hl]
    jr nz, Jump_036_73E9
    push hl
    call Func_036_60EB
    pop hl
    jr c, Jump_036_73DF
    ld h, $B5
    ld bc, $0888
    jp Jump_036_7CBC

Jump_036_73DF::
    set 6, [hl]
    ld l, $76
    ld bc, $4090
    jp Func_036_7C9C

Jump_036_73E9::
    jp Jump_036_7CD3

Func_036_73EC:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A5]
    ld hl, $D80C
    call Func_000_3F25
    ld a, [$D8A6]
    cp a, $74
    jr z, Jump_036_7403
    ld a, [hl]
    and a, $03
    jr nz, Jump_036_7431
    jr Jump_036_7407

Jump_036_7403::
    bit 1, [hl]
    jr nz, Jump_036_7431

Jump_036_7407::
    push hl
    call Func_036_60D1
    pop hl
    jr c, Jump_036_7416
    ld h, $B5
    ld bc, $0888
    jp Jump_036_7CBC

Jump_036_7416::
    ld a, [$D8A6]
    cp a, $74
    jr z, Jump_036_7425
    set 0, [hl]
    res 1, [hl]
    ld l, $75
    jr Jump_036_742B

Jump_036_7425::
    set 1, [hl]
    res 0, [hl]
    ld l, $77

Jump_036_742B::
    ld bc, $4090
    jp Func_036_7C9C

Jump_036_7431::
    jp Jump_036_7CD3

Func_036_7434:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A5]
    ld hl, $D80C
    call Func_000_3F25
    bit 5, [hl]
    jr nz, Jump_036_745A
    push hl
    call Func_036_5B02
    pop hl
    jr c, Jump_036_7450
    ld h, $B5
    ld bc, $0888
    jp Jump_036_7CBC

Jump_036_7450::
    set 5, [hl]
    ld l, $D9
    ld bc, $4090
    jp Func_036_7C9C

Jump_036_745A::
    jp Jump_036_7CD3

Func_036_745D:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A5]
    ld hl, $D8DF
    call Func_036_7E65
    ld a, [hl+]
    or a, [hl]
    jr z, Jump_036_747B
    db $CD

Func_036_746B:: ; heuristic: target of a pointer table; C0
    ld h, $56
    jp nc, Jump_036_7CB7
    call Func_036_5671
    ld l, $57
    ld bc, $4090
    jp Jump_036_7CA3

Jump_036_747B::
    jp Jump_036_7CD3

Func_036_747E:: ; heuristic: target of a pointer table; C0
    call Func_036_7D5B
    bit 1, [hl]
    jr nz, Jump_036_749D
    call Func_036_5B5D
    jr nc, Jump_036_749A
    call Func_036_7D5B
    set 1, [hl]
    call Func_036_7D65
    ld l, $58
    ld bc, $0090
    jp Func_036_7C9C

Jump_036_749A::
    jp Jump_036_7CB7

Jump_036_749D::
    jp Jump_036_7CD3

Func_036_74A0:: ; heuristic: target of a pointer table; C0
    ld a, [$DABA]
    or a, a
    jr nz, Jump_036_74CD
    call Func_000_3ED4
    ld a, [$C5E7]
    and a, $01
    jr nz, Jump_036_74CD
    ld d, $CC
    ld hl, Data_036_7193
    ld b, $3A
    rst $10
    ld a, $01
    ld [$CFCA], a
    ld a, $0E
    ld [$CFCB], a
    ld a, $00
    ld [$CFCC], a
    ld hl, $CFCF
    set 0, [hl]
    ret

Jump_036_74CD::
    call Func_036_6D20
    ret

Func_036_74D1:: ; heuristic: target of a pointer table; C0
    call Func_000_3ED4
    ld a, [$D8A4]
    ld hl, $D811
    call Func_000_3F25
    ld a, [hl]
    and a, $0C
    jr nz, Jump_036_74EF
    ld a, [$C5E7]
    and a, $04
    add a, $04
    ld b, a
    ld a, [hl]
    and a, $F3
    or a, b
    ld [hl], a

Jump_036_74EF::
    jp Jump_036_7CD3

Func_036_74F2:: ; heuristic: target of a pointer table; C0
    ld d, $02
    jr Jump_036_74F8

Func_036_74F6:: ; heuristic: target of a pointer table; C0
    ld d, $01

Jump_036_74F8::
    ld a, [$D8A5]
    ld hl, $D811
    call Func_000_3F25
    ld a, [hl]
    and a, d
    jr nz, Jump_036_7539
    ld a, [$D8A5]
    ld hl, $D80D
    call Func_000_3F25
    bit 1, [hl]
    jr nz, Jump_036_7539
    push de
    call Func_036_55FB
    pop de
    jr nc, Jump_036_7531
    ld a, [$D8A5]
    ld hl, $D811
    call Func_000_3F25
    ld a, [hl]
    or a, d
    ld [hl], a
    ld a, [$D8A6]
    sub a, $2A
    ld l, a
    ld bc, $0090
    jp Func_036_7C9C

Jump_036_7531::
    ld h, $B5
    ld bc, $0888
    jp Jump_036_7CBC

Jump_036_7539::
    jp Jump_036_7CD3

Func_036_753C:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A5]
    ld hl, $D814
    call Func_000_3F25
    bit 7, [hl]
    jr nz, Jump_036_7569
    call Func_036_6126
    jr nc, Jump_036_7561
    ld a, [$D8A5]
    ld hl, $D814
    call Func_000_3F25
    set 7, [hl]
    ld l, $D5
    ld bc, $0098
    jp Func_036_7C9C

Jump_036_7561::
    ld h, $B5
    ld bc, $0888
    jp Jump_036_7CBC

Jump_036_7569::
    ld h, $CC
    ld bc, $0084
    jp Jump_036_7CBC

Func_036_7571:: ; heuristic: target of a pointer table; C0
    ld hl, $6581
    ld b, $32
    rst $10
    ld l, $60
    ld bc, $0090
    jp Func_036_7C9C

Func_036_757F:: ; heuristic: target of a pointer table; C0
    call Func_036_5B19
    jr nc, Jump_036_7591
    call Func_036_5B8B
    jr nc, Jump_036_7591
    call Func_036_6DF8
    xor a, a
    ld [$CFCC], a
    ret

Jump_036_7591::
    ld h, $B5
    ld bc, $0080
    jp Jump_036_7CBC

Func_036_7599:: ; heuristic: target of a pointer table; C0
    ld hl, Func_036_6622
    ld b, $32
    rst $10
    xor a, a
    ld [$CFCC], a
    ld l, $5E
    ld bc, $0090
    jp Func_036_7C9C

Func_036_75AB:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    rrca
    rrca
    and a, $01
    ld hl, $D80A
    add a, l
    ld l, a
    jr nc, Jump_036_75BA
    inc h

Jump_036_75BA::
    bit 2, [hl]
    jr nz, Jump_036_761F
    push hl
    ld a, [$D8A4]
    ld hl, $D854
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_036_75CB
    inc h

Jump_036_75CB::
    ld a, [hl]
    pop hl
    and a, $04
    jr nz, Jump_036_75DD
    call Func_000_3ED4
    ld a, $C0
    ld b, a
    ld a, [$C5E7]
    cp a, b
    jr nc, Jump_036_7617

Jump_036_75DD::
    set 2, [hl]
    ld a, [$D8A4]
    and a, $04
    or a, $03
    ld [$D871], a
    ld a, [$D8A6]
    sub a, $07
    ld c, a
    ld b, $00
    ld a, [$D871]
    srl a
    srl a
    and a, $01
    add a, a
    ld hl, $DAAE
    add a, l
    ld l, a
    jr nc, Jump_036_7603
    inc h

Jump_036_7603::
    ld [hl], c
    inc hl
    ld [hl], b
    call Func_036_5BC4
    ld a, [$D871]
    ld [$D8A5], a
    ld l, $61
    ld bc, $0090
    jp Func_036_7C9C

Jump_036_7617::
    ld h, $72
    ld bc, $0080
    jp Jump_036_7CBC

Jump_036_761F::
    ld h, $CC
    ld bc, $0084
    jp Jump_036_7CBC

Func_036_7627:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    ld hl, $D810
    call Func_000_3F25
    ld a, [hl]
    or a, $30
    ld [hl], a
    jp Jump_036_7CD3

Func_036_7637:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    ld hl, $D810
    call Func_000_3F25
    set 7, [hl]
    jp Jump_036_7CD3

Func_036_7645:: ; heuristic: target of a pointer table; C0
    call Func_036_7D5B
    bit 3, [hl]
    jr nz, Jump_036_7694
    ld a, [$D8A6]
    cp a, $8C
    jr z, Jump_036_7658
    call Func_036_5B5D
    jr Jump_036_765B

Jump_036_7658::
    call Func_036_53C6

Jump_036_765B::
    jr nc, Jump_036_768C
    call Func_036_7D5B
    set 3, [hl]
    call Func_036_7D65
    ld a, [$D8A6]
    cp a, $8B
    jr z, Jump_036_7680
    ld a, [$D8A5]
    ld hl, $D90F
    call Func_036_7E65
    ld a, $01
    ld [hl+], a
    ld [hl], $00
    ld a, [$D8A5]
    call Func_036_7D50

Jump_036_7680::
    ld a, [$D8A6]
    sub a, $31
    ld l, a
    ld bc, $0090
    jp Func_036_7C9C

Jump_036_768C::
    ld h, $71
    ld bc, $0888
    jp Jump_036_7CBC

Jump_036_7694::
    jp Jump_036_7CD3

Func_036_7697:: ; heuristic: target of a pointer table; C0
    call Func_036_7D5B
    bit 2, [hl]
    jp nz, Jump_036_7CD3
    call Func_036_5D91
    jr nc, Jump_036_76B4
    call Func_036_7D5B
    set 2, [hl]
    call Func_036_7D65
    ld l, $5D
    ld bc, $0090
    jp Func_036_7C9C

Jump_036_76B4::
    ld a, [$D8A5]
    ld hl, $D8A7
    add a, l
    ld l, a
    jr nc, Jump_036_76BF
    inc h

Jump_036_76BF::
    bit 4, [hl]
    ld h, $70
    jr z, Jump_036_76C7
    ld h, $68

Jump_036_76C7::
    ld bc, $0080
    jp Jump_036_7CBC

Func_036_76CD:: ; heuristic: target of a pointer table; C0
    call Func_036_7D5B
    bit 5, [hl]
    jr nz, Jump_036_76F1
    call Func_036_5B5D
    jr nc, Jump_036_76E9
    call Func_036_7D5B
    set 5, [hl]
    call Func_036_7D65
    ld l, $59
    ld bc, $0090
    jp Func_036_7C9C

Jump_036_76E9::
    ld h, $B5
    ld bc, $0888
    jp Jump_036_7CBC

Jump_036_76F1::
    jp Jump_036_7CD3

Func_036_76F4:: ; heuristic: target of a pointer table; C0
    call Func_036_7D5B
    bit 4, [hl]
    jr nz, Jump_036_7718
    call Func_036_5B5D
    jr nc, Jump_036_7710
    call Func_036_7D5B
    set 4, [hl]
    call Func_036_7D65
    ld l, $5C
    ld bc, $0090
    jp Func_036_7C9C

Jump_036_7710::
    ld h, $6B
    ld bc, $0080
    jp Jump_036_7CBC

Jump_036_7718::
    jp Jump_036_7CD3

Func_036_771B:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    ld hl, $D80F
    call Func_000_3F25
    ld a, [hl]
    and a, $C0
    cp a, $40
    jr z, Jump_036_775E
    call Func_036_6116
    jr nc, Jump_036_7756
    ld a, [$D8A5]
    ld hl, $D80F
    call Func_000_3F25
    ld a, [hl]
    ld a, $40
    ld [hl], a
    ld a, [$D8A5]
    add a, a
    ld hl, $D854
    add a, l
    ld l, a
    jr nc, Jump_036_7749
    inc h

Jump_036_7749::
    ld [hl], $00
    ld d, $DD
    ld hl, Data_036_7193
    ld b, $3A
    rst $10
    jp Func_036_7CC9

Jump_036_7756::
    ld h, $6E
    ld bc, $0080
    jp Jump_036_7CBC

Jump_036_775E::
    ld a, [hl]
    and a, $3F
    ld [hl], a
    ld a, [$D8A4]
    ld [$D8A5], a
    ld hl, $D80C
    call Func_000_3F25
    bit 6, [hl]
    jr nz, Jump_036_7780
    bit 7, [hl]
    jr nz, Jump_036_7780
    call Func_000_3ED4
    ld a, [$C5E7]
    and a, $01
    jr z, Jump_036_77AD

Jump_036_7780::
    ld a, [$D8A4]
    call Func_036_7E38
    push hl
    call Func_036_64E2
    ld c, l
    ld b, h
    pop hl
    push bc
    call Func_036_64EC
    pop bc
    call Func_000_3E98
    ld a, d
    or a, e
    jr nz, Jump_036_779C
    ld de, $0001

Jump_036_779C::
    ld a, e
    ld [$D872], a
    ld a, d
    ld [$D873], a
    ld hl, $D0AD
    ld bc, $88A8
    jp Jump_036_7C8B

Jump_036_77AD::
    ld h, $AF
    ld bc, $0080
    jp Jump_036_7CBC

Func_036_77B5:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A5]
    ld hl, $D80D
    call Func_000_3F25
    bit 6, [hl]
    jp nz, Jump_036_7CD3
    call Func_036_5DA3
    jr nc, Jump_036_77DB
    ld a, [$D8A5]
    ld hl, $D80D
    call Func_000_3F25
    set 6, [hl]
    ld l, $DE
    ld bc, $4098
    jp Func_036_7C9C

Jump_036_77DB::
    jp Jump_036_7CB7

Func_036_77DE:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A5]
    ld hl, $D80D
    call Func_000_3F25
    bit 7, [hl]
    jr nz, Jump_036_7806
    call Func_036_5DB8
    jr nc, Jump_036_7803
    ld a, [$D8A5]
    ld hl, $D80D
    call Func_000_3F25
    set 7, [hl]
    ld l, $64
    ld bc, $4098
    jp Func_036_7C9C

Jump_036_7803::
    jp Jump_036_7CB7

Jump_036_7806::
    jp Jump_036_7CD3

Func_036_7809:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    ld hl, $D813
    call Func_000_3F25
    ld a, [$D8A6]
    cp a, $96
    jr z, Jump_036_782D
    cp a, $E0
    jr nz, Jump_036_7825
    ld a, [hl]
    and a, $F0
    or a, $0C
    ld [hl], a
    jr Jump_036_7833

Jump_036_7825::
    ld a, [hl]
    and a, $F0
    or a, $02
    ld [hl], a
    jr Jump_036_7833

Jump_036_782D::
    ld a, [hl]
    and a, $F0
    or a, $04
    ld [hl], a

Jump_036_7833::
    jp Jump_036_7CD3

Func_036_7836:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    ld hl, $D812
    call Func_000_3F25
    set 5, [hl]
    jp Jump_036_7CD3

Func_036_7844:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A5]
    rrca
    rrca
    and a, $01
    ld hl, $D80A
    add a, l
    ld l, a

Func_036_7850:: ; heuristic: target of a pointer table; C0
    jr nc, Jump_036_7853
    inc h

Jump_036_7853::
    bit 4, [hl]
    jp nz, Jump_036_7CD3
    ld a, [$D8A6]
    cp a, $98
    jr z, Jump_036_7867
    ld a, [$D8A5]
    ld c, a
    ld b, $01
    jr Jump_036_7871

Jump_036_7867::
    set 4, [hl]
    ld a, [$D8A5]
    and a, $04
    ld c, a
    ld b, $03

Jump_036_7871::
    ld a, c

Func_036_7872:: ; heuristic: target of a pointer table; C0
    call Func_000_3E54
    jr c, Jump_036_7894
    ld a, c
    ld hl, $D8A4
    cp a, [hl]
    jr z, Jump_036_7894
    ld hl, $D812
    call Func_000_3F25
    bit 4, [hl]
    jr nz, Jump_036_7894
    set 4, [hl]
    inc hl
    ld a, [$D8A4]
    and a, $0F
    swap a
    or a, [hl]
    ld [hl], a

Jump_036_7894::
    inc c
    dec b
    jr nz, Jump_036_7871
    jp Jump_036_7CD3

Func_036_789B:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A6]
    cp a, $9A
    jr z, Jump_036_78AF
    ld a, [$D8A5]
    ld hl, $D80E
    call Func_000_3F25
    set 6, [hl]
    jr Jump_036_78DB

Jump_036_78AF::
    ld a, [$D8A5]
    and a, $04
    ld c, a
    ld b, $03

Jump_036_78B7::
    ld a, c
    call Func_000_3E54
    jr c, Jump_036_78C6
    ld a, c
    ld hl, $D80E
    call Func_000_3F25
    set 6, [hl]

Jump_036_78C6::
    inc c
    dec b
    jr nz, Jump_036_78B7
    ld a, [$D8A5]
    rra
    rra
    and a, $01
    ld hl, $D80A
    add a, l
    ld l, a
    jr nc, Jump_036_78D9
    inc h

Jump_036_78D9::
    set 5, [hl]

Jump_036_78DB::
    jp Jump_036_7CD3

Func_036_78DE:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    ld hl, $D80E
    call Func_000_3F25
    set 3, [hl]
    jp Jump_036_7CD3

Func_036_78EC:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    ld hl, $D814
    call Func_000_3F25
    set 4, [hl]
    jp Jump_036_7CD3

Func_036_78FA:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    rrca
    rrca
    and a, $01
    ld b, a
    ld hl, $D80A
    add a, l
    ld l, a
    jr nc, Jump_036_790A
    inc h

Jump_036_790A::
    bit 6, [hl]
    jp nz, Jump_036_7CD3
    set 6, [hl]
    ld a, b
    ld hl, $D864
    add a, l
    ld l, a
    jr nc, Jump_036_791A
    inc h

Jump_036_791A::
    ld a, [$D8A4]
    and a, $03
    rla
    rla
    or a, [hl]
    ld [hl], a
    ld a, [$D8A4]
    ld hl, $D812
    call Func_000_3F25
    set 1, [hl]
    jp Jump_036_7CD3

Func_036_7931:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    ld hl, $D812
    call Func_000_3F25
    set 3, [hl]
    jp Jump_036_7CD3
    db $CD, $86, $5E, $30, $08, $2E, $37, $01, $90, $40, $C3, $A3, $7C, $C3, $B0, $7C
    db $FA, $A4, $D8, $21, $11, $D8, $CD, $25, $3F, $7E, $E6, $10, $20, $09, $7E, $E6
    db $CF, $F6, $20, $77, $C3, $03, $7D

Jump_036_7966::
    ld a, [$DABA]
    or a, a
    jr nz, Jump_036_7981
    call Func_000_3ED4
    ld a, [$C5E7]
    cp a, $80
    jr c, Jump_036_7981
    ld d, $72
    ld hl, Data_036_7193
    ld b, $3A
    rst $10
    jp Func_036_7D03

Jump_036_7981::
    ld a, [$D8A5]
    call Func_000_3E54
    jr nc, Jump_036_7998
    jr z, Jump_036_7998
    ld a, [$D8A5]
    and a, $03
    cp a, $03
    jr z, Jump_036_7998
    call Func_036_6D0A
    ret

Jump_036_7998::
    jp Jump_036_7CD3

Func_036_799B:: ; heuristic: follows a terminator; C0
    ld a, [$D8A4]
    ld hl, $D814
    call Func_000_3F25
    ld a, [hl]
    and a, $01
    jr nz, Jump_036_79CF
    push hl
    call Func_000_3ED4
    ld a, [$C5E7]
    and a, $0F
    ld hl, Data_036_79DC
    add a, l
    ld l, a
    jr nc, Jump_036_79BA
    inc h

Jump_036_79BA::
    ld a, [hl]
    push af
    ld a, [$D8A4]
    ld hl, $DAFA
    add a, l
    ld l, a
    jr nc, Jump_036_79C7
    inc h

Jump_036_79C7::
    pop af
    ld [hl], a
    pop hl
    set 1, [hl]
    jp Func_036_7D03

Jump_036_79CF::
    ld a, [$C96F]
    or a, a
    jr z, Jump_036_79D9
    call Func_036_6C24
    ret

Jump_036_79D9::
    jp Func_036_7D03

Data_036_79DC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $01, $01, $02, $02, $02, $02
    db $C9, $CD, $13, $50, $FA, $72, $D8, $6F, $FA, $73, $D8, $67, $CD, $1C, $65, $7D
    db $EA, $72, $D8, $7C, $EA, $73, $D8, $C3, $7D, $7C, $FA, $A4, $D8, $21, $13, $D8
    db $CD, $25, $3F, $7E, $E6, $F0, $F6, $01, $77, $C3, $D3, $7C

Func_036_7A18:: ; heuristic: target of a pointer table; C0
    ld a, [$C58A]
    or a, a
    jp nz, Jump_036_7CD3
    ld a, [$D8A4]
    cp a, $04
    jp nc, Jump_036_7CD3
    ld a, [$D8A5]
    cp a, $04
    jr c, Jump_036_7A7A
    ld a, [$D8A5]
    ld hl, $D8BF
    call Func_036_7E65
    xor a, a
    ld [hl+], a
    ld [hl], a
    ld a, [$D8A5]
    ld hl, $DA63
    add a, l
    ld l, a
    jr nc, Jump_036_7A45
    inc h

Jump_036_7A45::
    ld [hl], $FF
    ld a, [$D8A5]
    and a, $03
    ld hl, $D94F
    ld b, a
    add a, a
    add a, b
    add a, l
    ld l, a
    jr nc, Jump_036_7A57
    inc h

Jump_036_7A57::
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ld hl, $5AB3
    ld b, $32
    rst $10
    ld a, [$D8A6]
    cp a, $B2
    ld d, $8F
    jr z, Jump_036_7A85
    ld d, $D8
    ld hl, Data_036_7193
    ld b, $3A
    rst $10
    ld a, $82
    call Func_000_1278
    jp Jump_036_7CD3

Jump_036_7A7A::
    ld a, [$D8A6]
    cp a, $B2
    ld d, $8F
    jr z, Jump_036_7A85
    ld d, $5C

Jump_036_7A85::
    ld hl, Data_036_7193
    ld b, $3A
    rst $10
    jp Jump_036_7CD3

Func_036_7A8E:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    and a, $04
    ld c, a
    ld b, $03

Jump_036_7A96::
    ld a, c
    call Func_000_3E54
    jr c, Jump_036_7AA5
    ld a, c
    ld hl, $D80D
    call Func_000_3F25
    set 3, [hl]

Jump_036_7AA5::
    inc c
    dec b
    jr nz, Jump_036_7A96
    jp Jump_036_7CD3

Func_036_7AAC:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A5]
    ld hl, $D80C
    call Func_000_3F25
    ld a, [hl]
    and a, $8C
    jr nz, Jump_036_7ACD
    ld a, [hl]
    or a, $8C
    ld [hl], a
    call Func_036_7E87
    ld l, $73
    jr nc, Jump_036_7AC7
    ld l, $74

Jump_036_7AC7::
    ld bc, $4090
    jp Func_036_7C9C

Jump_036_7ACD::
    ld h, $D4
    ld bc, $0080
    jp Jump_036_7CBC

Func_036_7AD5:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A5]
    ld hl, $D8DF
    call Func_036_7E65
    ld a, [hl+]
    or a, [hl]
    jp z, Jump_036_7CD3
    xor a, a
    ld [hl-], a
    ld [hl], a
    ld l, $DF
    ld bc, $4090
    jp Jump_036_7CA3
    db $CD, $98, $60, $C3, $85, $7C

Func_036_7AF4:: ; heuristic: target of a pointer table; C0
    call Func_036_7D5B
    bit 0, [hl]
    jp nz, Jump_036_7CD3
    set 0, [hl]
    call Func_036_7D65
    ld l, $78
    ld bc, $0098
    jp Jump_036_7CA3

Func_036_7B09:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A5]
    ld hl, $D8DF
    call Func_036_7E65
    push hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld a, [$D8A5]
    ld hl, $D8EF
    call Func_036_7E65
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    call Func_000_3E7A
    pop bc
    jp z, Jump_036_7CD3
    ld a, l
    ld [bc], a
    inc bc
    ld a, h
    ld [bc], a
    ld l, $C3
    ld bc, $4090
    jp Jump_036_7CA3

Func_036_7B36:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A5]
    ld hl, $D8BF
    call Func_036_7E65
    ld c, l
    ld b, h
    ld a, [hl+]
    cp a, $01
    jr nz, Jump_036_7B5C
    ld a, [hl]
    or a, a
    jr nz, Jump_036_7B5C
    ld hl, $0001
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    ld l, $35
    ld bc, $88A8
    jr Jump_036_7B68

Jump_036_7B5C::
    ld a, $01
    ld [bc], a
    inc bc
    ld a, $00
    ld [bc], a
    ld l, $38
    ld bc, $4090

Jump_036_7B68::
    jp Jump_036_7CA3

Func_036_7B6B:: ; heuristic: target of a pointer table; C0
    call Func_000_3ED4
    ld a, [$C5E7]
    cp a, $40
    jr c, Jump_036_7B81
    call Func_036_5013
    ld hl, $D136
    ld bc, $80A8
    jp Jump_036_7C8B

Jump_036_7B81::
    ld h, $D1
    ld bc, $0888
    jp Jump_036_7CBC

Func_036_7B89:: ; heuristic: target of a pointer table; C0
    call Func_000_3ED4
    ld a, [$C5E7]
    cp a, $C0
    jr c, Jump_036_7B99
    call Func_036_5013
    jp Func_036_7C85

Jump_036_7B99::
    ld h, $D0
    ld bc, $0888
    jp Jump_036_7CBC

Func_036_7BA1:: ; heuristic: target of a pointer table; C0
    call Func_036_6B75
    ret
    db $C3, $D3, $7C

Func_036_7BA8:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    ld hl, $D80F
    call Func_000_3F25
    set 2, [hl]
    jp Jump_036_7CD3

Func_036_7BB6:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    ld hl, $D80C
    call Func_000_3F25
    set 6, [hl]
    ld l, $76
    ld bc, $4090
    jp Jump_036_7CA3

Func_036_7BC9:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A5]
    ld hl, $DA63
    add a, l
    ld l, a
    jr nc, Jump_036_7BD4
    inc h

Jump_036_7BD4::
    ld [hl], $FF
    call Func_036_7E87
    jr c, Jump_036_7BF5
    ld a, [$D8A5]
    and a, $03
    ld hl, $D94F
    ld b, a
    add a, a
    add a, b
    add a, l
    ld l, a
    jr nc, Jump_036_7BEB
    inc h

Jump_036_7BEB::
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ld hl, $5AB3
    ld b, $32
    rst $10

Jump_036_7BF5::
    jp Jump_036_7CD3

Func_036_7BF8:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    ld hl, $D80F
    call Func_000_3F25
    ld a, [hl]
    and a, $3F
    ld [hl+], a
    ld a, [hl]
    and a, $F3
    ld [hl], a
    ld a, [$D8A4]
    call Func_036_7E42
    ld a, $0A
    call Func_000_16D1
    ld a, h
    or a, l
    jr nz, Jump_036_7C1B
    ld hl, $0001

Jump_036_7C1B::
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    ld hl, $AF36
    ld bc, $80A8
    jp Jump_036_7C8B

Func_036_7C2C:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    ld hl, $D80F
    call Func_000_3F25
    ld a, [hl]
    and a, $3F
    ld [hl+], a
    ld a, [hl]
    and a, $F3
    ld [hl], a
    ld a, [$D8A4]
    ld hl, $D80C
    call Func_000_3F25
    ld a, [hl]
    and a, $0C
    jr nz, Func_036_7BF8
    ld hl, $0000
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    ld hl, $AFAF
    ld bc, $0080
    jp Jump_036_7C8B

Func_036_7C5F:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    ld hl, $D810
    call Func_000_3F25
    jp Jump_036_730E

Func_036_7C6B:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    ld hl, $D80F
    call Func_000_3F25
    jp Jump_036_775E

Func_036_7C77:: ; heuristic: target of a pointer table; C0
    jp Jump_036_7966

Func_036_7C7A:: ; heuristic: target of a pointer table; C0
    jp Jump_036_79CF

Jump_036_7C7D::
    ld hl, $B535
    ld bc, $80A8
    jr Jump_036_7C8B

Func_036_7C85::
    ld hl, $D035
    ld bc, $88A8

Jump_036_7C8B::
    ld a, l
    ld [$DAC2], a
    ld a, h
    ld [$DAC3], a
    ld a, c
    ld [$DAC0], a
    ld a, b
    ld [$DAC1], a
    ret

Func_036_7C9C::
    xor a, a
    ld [$D872], a
    ld [$D873], a

Jump_036_7CA3::
    ld a, l
    ld [$DAC2], a
    ld a, c
    ld [$DAC0], a
    ld a, b
    ld [$DAC1], a
    ret

Jump_036_7CB0::
    ld h, $CC
    ld bc, $0080
    jr Jump_036_7CBC

Jump_036_7CB7::
    ld h, $B5
    ld bc, $0080

Jump_036_7CBC::
    ld a, h
    ld [$DAC3], a

Jump_036_7CC0::
    ld a, c
    ld [$DAC0], a
    ld a, b
    ld [$DAC1], a
    ret

Func_036_7CC9:: ; heuristic: follows a terminator; C0
    ld a, $02
    ld [$CFCA], a
    xor a, a
    ld [$CFCB], a
    ret

Jump_036_7CD3::
    ld a, [$DAD1]
    cp a, $FF
    jr z, Jump_036_7CF3
    push hl
    ld [$D8A5], a
    push af
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_036_7CEB
    inc h

Jump_036_7CEB::
    pop af
    ld [hl], a
    ld a, $FF
    ld [$DAD1], a
    pop hl

Jump_036_7CF3::
    ld a, [$DABD]
    or a, a
    jr nz, Jump_036_7D0D
    ld a, $03
    ld [$CFCA], a
    xor a, a
    ld [$CFCB], a
    ret

Func_036_7D03:: ; heuristic: follows a terminator; C0
    ld a, $07
    ld [$CFCA], a
    xor a, a
    ld [$CFCB], a
    ret

Jump_036_7D0D::
    ld bc, $0000
    jp Jump_036_7CC0

Func_036_7D13:: ; heuristic: follows a terminator; C0
    ld a, [$D8A5]
    ld hl, $D80E
    call Func_000_3F25
    bit 2, [hl]
    ret z
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    call Func_036_651C
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    ret

Func_036_7D33:: ; heuristic: follows a terminator; C0
    xor a, a
    ld [$D872], a
    ld [$D873], a
    ld a, [$D8A5]
    ld hl, $D80C
    call Func_000_3F25
    ld a, [hl]
    ret

Func_036_7D45:: ; heuristic: follows a terminator; C0
    push hl
    ld hl, $D812
    call Func_000_3F25
    set 6, [hl]
    pop hl
    ret

Func_036_7D50::
    push hl
    ld hl, $D812
    call Func_000_3F25
    set 7, [hl]
    pop hl
    ret

Func_036_7D5B:: ; heuristic: follows a terminator; C0
    ld a, [$D8A5]
    ld hl, $D80F
    call Func_000_3F25
    ret

Func_036_7D65:: ; heuristic: follows a terminator; C0
    ld a, [$D8A5]
    ld hl, $D811
    call Func_000_3F25
    ld a, [hl]
    and a, $F3
    ld [hl], a
    inc hl
    inc hl
    ld a, [hl]
    and a, $F8
    ld [hl], a
    ret

Func_036_7D79:: ; heuristic: follows a terminator; C0
    ld a, [$D8A5]
    ld b, a
    ld hl, $DA63
    add a, l
    ld l, a
    jr nc, Jump_036_7D85
    inc h

Jump_036_7D85::
    ld [hl], $00
    ld a, b
    ld hl, $D80C
    call Func_000_3F25
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ld a, [$D8A5]
    ld hl, $DA5B
    add a, l
    ld l, a
    jr nc, Jump_036_7DA3
    inc h

Jump_036_7DA3::
    ld [hl], $03
    ret

Func_036_7DA6:: ; heuristic: follows a terminator; C0
    ld hl, $D895
    ld b, $08
    ld d, $00

Jump_036_7DAD::
    bit 0, d
    jr nz, Jump_036_7DB7
    ld a, [hl]
    cp a, c
    jr nz, Jump_036_7DC4
    ld d, $01

Jump_036_7DB7::
    inc hl
    ld a, [hl]
    ld [hl], $FF
    dec hl
    ld [hl], a
    inc hl
    dec b
    jr nz, Jump_036_7DAD
    ld [hl], $FF
    ret

Jump_036_7DC4::
    inc hl
    dec b
    jr nz, Jump_036_7DAD
    ret

Func_036_7DC9:: ; heuristic: follows a terminator; C0
    ld a, [$D8A6]
    or a, a
    jr z, Jump_036_7DD1
    sub a, $47

Jump_036_7DD1::
    ld hl, Data_036_7DDE
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_036_7DDA
    inc h

Jump_036_7DDA::
    call Func_000_000B
    ret

Data_036_7DDE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $13, $50, $C5, $58, $2E, $59, $93, $59, $52, $53, $B4, $60, $B4, $60, $CF, $5D
    db $CF, $5D, $22, $55, $33, $55, $44, $55, $55, $55, $66, $55, $71, $55, $7C, $55
    db $87, $55, $92, $55, $9D, $55, $A8, $55, $B3, $55, $BE, $55, $C9, $55, $D4
    dw Func_000_1355
    dw Func_000_1350
    dw Func_000_1350
    dw Func_036_7850
    db $72, $0B, $5E, $0B, $5E, $13, $50, $13, $50, $6C, $5A, $13, $50, $E0, $72, $13
    db $50, $13, $50, $13, $50, $E0, $72, $13, $50

Func_036_7E2E::
    ld hl, $D8FF
    jr Func_036_7E5B

Func_036_7E33::
    ld hl, $D90F
    jr Func_036_7E5B

Func_036_7E38::
    ld hl, $D8CF
    jr Func_036_7E5B

Func_036_7E3D::
    ld hl, $D8EF
    jr Func_036_7E5B

Func_036_7E42::
    ld hl, $D8BF
    jr Func_036_7E5B

Func_036_7E47::
    ld hl, $D8DF
    jr Func_036_7E5B
    db $21, $1F, $D9, $18, $0A, $21, $53, $DA, $85, $6F, $30, $01, $24, $7E, $C9

Func_036_7E5B::
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_036_7E61
    inc h

Jump_036_7E61::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ret

Func_036_7E65::
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_036_7E6B
    inc h

Jump_036_7E6B::
    ret

Func_036_7E6C::
    ld a, [$C58A]
    cp a, $01
    jr nz, Jump_036_7E81
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_036_7E81
    ld a, [$D8A4]
    cp a, $04
    ccf
    ret

Jump_036_7E81::
    ld a, [$D8A4]
    cp a, $04
    ret

Func_036_7E87::
    ld a, [$C58A]
    cp a, $01
    jr nz, Jump_036_7E9C
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_036_7E9C
    ld a, [$D8A5]
    cp a, $04
    ccf
    ret

Jump_036_7E9C::
    ld a, [$D8A5]
    cp a, $04
    ret
    db $7A, $21, $B7, $7E, $85, $6F, $30, $01, $24, $56, $7B, $21, $0C, $D8, $CD, $25
    db $3F, $7A, $A6, $77, $C9, $DF, $FE, $00, $FD, $73, $EF, $BF

Func_036_7EBE::
    push hl
    ld hl, $D095
    add a, l
    ld l, a
    jr nc, Jump_036_7EC7
    inc h

Jump_036_7EC7::
    set 0, [hl]
    pop hl
    ret

Func_036_7ECB::
    push hl
    ld hl, $D095
    add a, l
    ld l, a
    jr nc, Jump_036_7ED4
    inc h

Jump_036_7ED4::
    set 1, [hl]
    pop hl
    ret

Func_036_7ED8:: ; heuristic: follows a terminator; C0
    push hl
    ld hl, $D095
    add a, l
    ld l, a
    jr nc, Jump_036_7EE1
    inc h

Jump_036_7EE1::
    set 2, [hl]
    pop hl
    ret

Func_036_7EE5:: ; heuristic: follows a terminator; C0
    push hl
    push bc
    ld c, a
    ld b, $00
    ld hl, $D968
    add a, l
    ld l, a
    jr nc, Jump_036_7EF2
    inc h

Jump_036_7EF2::
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_036_7F01
    ld l, $09
    cp a, $40
    jr nc, Jump_036_7F01
    ld l, $12

Jump_036_7F01::
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, $D970
    add a, l
    ld l, a
    jr nc, Jump_036_7F0D
    inc h

Jump_036_7F0D::
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_036_7F1C
    ld l, $03
    cp a, $40
    jr nc, Jump_036_7F1C
    ld l, $06

Jump_036_7F1C::
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, $D978
    add a, l
    ld l, a
    jr nc, Jump_036_7F28
    inc h

Jump_036_7F28::
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_036_7F37
    ld l, $01
    cp a, $40
    jr nc, Jump_036_7F37
    ld l, $02

Jump_036_7F37::
    ld a, l
    add a, b
    pop bc
    pop hl
    ret

Func_036_7F3C::
    call Func_000_3E25
    ret c
    push hl
    push bc
    ld c, a
    ld hl, $D80F
    call Func_000_3F25
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_036_7F56
    ld a, [hl]
    and a, $0C
    jr nz, Jump_036_7F56
    xor a, a
    jr Jump_036_7F57

Jump_036_7F56::
    scf

Jump_036_7F57::
    ld a, c
    pop bc
    pop hl
    ret

Func_036_7F5B::
    push hl
    ld hl, $D80F
    call Func_000_3F25
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_036_7F6A
    ld a, [hl]
    and a, $0C

Jump_036_7F6A::
    pop hl
    ret
    ds $94, $00
