SECTION "Bank 24", ROMX[$4000], BANK[$24]
    db $24

Func_024_4001::
    ld hl, $D780
    ld bc, $006F

Jump_024_4007::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_024_4007
    ld a, [$D04C]
    and a, a
    jr nz, Jump_024_4014
    jr Jump_024_4057

Jump_024_4014::
    ld a, [$D092]
    cp a, $80
    jr z, Jump_024_4057
    and a, $01
    and a, a
    jr nz, Jump_024_4022
    jr Jump_024_4057

Jump_024_4022::
    ld a, [$C986]
    and a, a
    jr z, Jump_024_4057
    ld a, [$C94C]
    ld [$D7F1], a
    xor a, a
    ld [$D7F2], a
    ld hl, $7E96
    ld b, $14
    rst $10
    xor a, a
    ld [$C8C3], a
    ld [$C8C4], a

Jump_024_403F::
    ld hl, $7333
    ld b, $02
    rst $10
    ld a, [$C8C3]
    bit 7, a
    jr z, Jump_024_403F
    ld hl, $D780
    ld bc, $006F

Jump_024_4052::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_024_4052

Jump_024_4057::
    ld b, $46
    ld de, $4001
    ld hl, $8800
    call Func_000_0CF5
    ld hl, $4AA8
    ld b, $F1
    rst $10
    xor a, a
    ldh [$FFA5], a
    ldh [$FFA1], a
    call Func_024_4EAB
    ld bc, $140D
    ld de, $01CC
    call Func_024_4E57
    ld hl, $53AF
    ld b, $1B
    rst $10
    ld hl, $5F9B
    ld b, $02
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
    call Func_000_290E
    ld a, [$D092]
    cp a, $08
    jr nz, Jump_024_40B1
    ld a, [$C991]
    ld [$D0DF], a
    ld a, [$C992]
    ld [$D0E0], a

Jump_024_40B1::
    call Func_024_5201
    ld a, [$D092]
    cp a, $80
    jr nz, Jump_024_40C2
    ld de, $6F4E
    ld b, $24
    jr Jump_024_40D3

Jump_024_40C2::
    and a, $01
    and a, a
    jr nz, Jump_024_40CE
    ld de, $6CE4
    ld b, $24
    jr Jump_024_40D3

Jump_024_40CE::
    ld de, $6E13
    ld b, $24

Jump_024_40D3::
    ld hl, $8E00
    call Func_000_0C5A
    call Func_024_5064
    ld a, $01
    ld [$C8CB], a
    ld a, $00
    ld [$C8CC], a
    ld a, $00
    ldh [$FFB9], a

Jump_024_40EA::
    ld hl, $69D0
    ld b, $02
    rst $10
    ld a, [$C8CB]
    and a, $03
    jr nz, Jump_024_40EA
    ld a, $FC
    call Func_000_0DF2
    ld hl, $8800
    ld de, $1202
    call Func_000_2E98
    xor a, a
    ld [$CB7D], a
    ld a, $02
    ldh [$FFB9], a
    ld a, $03
    ld [$C5EC], a
    ld a, $01
    jp Jump_000_077A

Func_024_4117::
    ld a, [$C56C]
    and a, a
    ret nz
    ld a, [$C52B]
    and a, a
    jr z, Jump_024_414C
    ld a, [$D780]
    cp a, $02
    jr z, Jump_024_413C
    cp a, $03
    ret nz
    ld a, [$D781]
    cp a, $01
    ret nz
    ld a, [$D782]
    cp a, $09
    ret nz
    call Func_024_567C
    ret

Jump_024_413C::
    ld a, [$D781]
    cp a, $0E
    ret nz
    ld a, [$D782]
    cp a, $09
    ret nz
    call Func_024_567C
    ret

Jump_024_414C::
    ld a, [$D780]
    rst $00
    dw Jump_024_4170
    dw Jump_024_4225
    dw Jump_024_424D
    dw Jump_024_452A
    dw Jump_024_4567
    dw Jump_024_47CF
    dw Jump_024_4A5C
    dw Jump_024_4A5C
    dw Jump_024_4A5C
    dw Jump_024_4A5C
    dw Jump_024_4A5C
    dw Jump_024_4A5C
    dw Jump_024_4A5D
    dw Jump_024_4A79
    dw Jump_024_4A94
    dw Jump_024_4C18

Jump_024_4170::
    ld a, [$D781]
    rst $00
    dw Jump_024_4178
    dw Jump_024_41F5

Jump_024_4178::
    ld a, [$D092]
    cp a, $08
    jr z, Jump_024_41C0
    cp a, $80
    jr z, Jump_024_4185
    jr Jump_024_418A

Jump_024_4185::
    ld de, $57B4
    jr Jump_024_418D

Jump_024_418A::
    ld de, $5792

Jump_024_418D::
    ld hl, $C37A
    ld bc, $1102
    call Func_024_4E12
    call Func_024_4D36
    call Func_024_4EAB
    ld bc, $1406
    ld de, $01CC
    call Func_024_4E57
    ld a, [$D781]
    inc a
    ld [$D781], a
    ld a, [$D092]
    cp a, $80
    jr z, Jump_024_41BB
    and a, $01
    add a, $01
    call Func_024_4EE8
    ret

Jump_024_41BB::
    xor a, a
    call Func_024_4EE8
    ret

Jump_024_41C0::
    call Func_024_4EAB
    ld bc, $1406
    ld de, $01CC
    call Func_024_4E57
    ld a, [$D781]
    inc a
    ld [$D781], a
    ld hl, $C987
    ld de, $C130
    ld bc, $000A
    call Func_000_0952
    ld a, $F0
    ld [$C13A], a
    ld a, $05
    ld [$C528], a
    ld a, $13
    ld [$C529], a
    ld hl, $4001
    ld b, $07
    rst $10
    ret

Jump_024_41F5::
    ld a, [$D04C]
    and a, a
    jr nz, Jump_024_41FF

Jump_024_41FB::
    call Func_024_4DEB
    ret

Jump_024_41FF::
    ld a, [$D092]
    cp a, $80
    jr z, Jump_024_41FB
    and a, $01
    and a, a
    jr z, Jump_024_4213
    ld a, [$C986]
    and a, a
    jr z, Jump_024_41FB
    jr Jump_024_4219

Jump_024_4213::
    ld a, [$CA2B]
    and a, a
    jr z, Jump_024_41FB

Jump_024_4219::
    xor a, a
    ld [$D781], a
    ld a, [$D780]
    inc a
    ld [$D780], a
    ret

Jump_024_4225::
    ld de, $58CA
    ld hl, $C3F0
    ld bc, $1406
    call Func_024_4E12
    call Func_024_4EAB
    ld bc, $140D
    ld de, $01CC
    call Func_024_4E57
    ld a, [$D092]
    and a, $01
    add a, $01
    ld b, a
    ld a, [$D780]
    add a, b
    ld [$D780], a
    ret

Jump_024_424D::
    ld a, [$D781]
    rst $00
    dw Jump_024_4271
    dw Jump_024_42B3
    dw Jump_024_4309
    dw Jump_024_4319
    dw Jump_024_4326
    dw Jump_024_4355
    dw Jump_024_4390
    dw Jump_024_4394
    dw Jump_024_43C3
    dw Jump_024_4432
    dw Jump_024_4438
    dw Jump_024_445F
    dw Jump_024_44AA
    dw Jump_024_450E
    dw Jump_024_4519
    dw Jump_024_4520

Jump_024_4271::
    ld a, [$D092]
    cp a, $08
    jr z, Jump_024_4284
    ld a, [$D782]
    and a, a
    jr nz, Jump_024_4284
    ld a, $0D
    ld [$D781], a
    ret

Jump_024_4284::
    ld hl, $5E3F
    ld b, $1D
    rst $10
    ld hl, $6D70
    ld b, $1D
    rst $10
    ld a, [$D7FF]
    ld b, a
    ld a, [$D7AA]
    cp a, b
    jr c, Jump_024_42A4
    ld a, $03
    ld [$D781], a
    xor a, a
    ld [$D782], a
    ret

Jump_024_42A4::
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$D782], a
    ret
    db $0A, $14, $1E

Jump_024_42B3::
    ld hl, $6D70
    ld b, $1D
    rst $10
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld hl, $A000

Jump_024_42C5::
    ld a, [hl]
    and a, a
    jr z, Jump_024_42D6
    cp a, $FF
    jr z, Jump_024_42D6
    ld a, $A5
    add a, l
    ld l, a
    jr nc, Jump_024_42D4
    inc h

Jump_024_42D4::
    jr Jump_024_42C5

Jump_024_42D6::
    ld de, $CA2B
    ld b, $A5

Jump_024_42DB::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_024_42DB
    ld a, [$CA36]
    ld [$D006], a
    ld a, [$CA37]
    ld [$D007], a
    ld hl, $5AAF
    ld b, $16
    rst $10
    xor a, a
    ld [$0100], a
    ld [$4100], a
    xor a, a
    ld [$C8C3], a
    ld [$C8C4], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_024_4309::
    ld hl, $7333
    ld b, $02
    rst $10
    ld a, [$C8C3]
    bit 7, a
    ret z
    call Func_024_4DEB
    ret

Jump_024_4319::
    ld a, $05
    call Func_024_4EE8
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_024_4326::
    ld a, $6C
    call Func_000_1278
    call Func_024_4D65
    ld de, $5A0A
    ld hl, $C412
    ld bc, $0605
    call Func_024_4E12
    call Func_024_51A3
    call Func_024_4EAB
    ld bc, $140D
    ld de, $01CC
    call Func_024_4E57
    xor a, a
    ld [$D7FA], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_024_4355::
    ld hl, $6540
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_024_437D
    cp a, $FF
    jr z, Jump_024_4369
    ret

Jump_024_4369::
    ld a, [$D7FA]
    and a, a
    jr nz, Jump_024_437D
    ld a, $07
    call Func_024_4EE8
    ld a, [$D781]
    add a, $02
    ld [$D781], a
    ret

Jump_024_437D::
    call Func_024_4D65
    call Func_024_4F0C
    ld a, $06
    call Func_024_4EE8
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_024_4390::
    call Func_024_4DEB
    ret

Jump_024_4394::
    ld a, $6C
    call Func_000_1278
    call Func_024_4DA8
    ld de, $5A50
    ld hl, $C40E
    ld bc, $0A05
    call Func_024_4E12
    call Func_024_51A3
    call Func_024_4EAB
    ld bc, $140D
    ld de, $01CC
    call Func_024_4E57
    xor a, a
    ld [$D7FA], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_024_43C3::
    call Func_024_5C39
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_024_43F1
    cp a, $FF
    jr z, Jump_024_43D4
    ret

Jump_024_43D4::
    ld a, [$D7FA]
    and a, a
    jr nz, Jump_024_43E2
    ld hl, $5F2D
    ld b, $1D
    rst $10
    jr Jump_024_43E8

Jump_024_43E2::
    ld hl, $6026
    ld b, $1D
    rst $10

Jump_024_43E8::
    ld a, [$D781]
    add a, $02
    ld [$D781], a
    ret

Jump_024_43F1::
    call Func_024_4D65
    ld de, $5A0A
    ld hl, $C412
    ld bc, $0605
    call Func_024_4E12
    xor a, a
    ld b, $BC
    ld hl, $5AAA
    call Func_024_52CE
    call Func_024_51A3
    call Func_024_4EAB
    ld bc, $140D
    ld de, $01CC
    call Func_024_4E57
    xor a, a
    ld b, $C3
    ld hl, $5AAA
    call Func_024_52CE
    xor a, a
    ld [$D7FA], a
    ld a, $05
    call Func_024_4EE8
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_024_4432::
    ld a, $05
    ld [$D781], a
    ret

Jump_024_4438::
    ld a, [$D7A9]
    and a, a
    jr nz, Jump_024_444C
    ld a, $11
    call Func_024_4EE8
    ld a, [$D781]
    sub a, $02
    ld [$D781], a
    ret

Jump_024_444C::
    ld a, [$D7FA]
    ld b, $BC
    ld hl, $5AAA
    call Func_024_52CE
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_024_445F::
    ld a, [$D092]
    cp a, $08
    jr nz, Jump_024_4474
    ld de, $58CA
    ld hl, $C3F7
    ld bc, $0606
    call Func_024_4E12
    jr Jump_024_4477

Jump_024_4474::
    call Func_024_4D21

Jump_024_4477::
    call Func_024_4EAB
    ld bc, $140D
    ld de, $01CC
    call Func_024_4E57
    ld de, $5942
    ld hl, $C300
    ld bc, $1405
    call Func_024_4E12
    call Func_024_51A3
    call Func_024_4EAB
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call Func_024_4E57
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_024_44AA::
    ld b, $46
    ld de, $4001
    ld hl, $8800
    call Func_000_0CF5
    ld de, $8800
    ld b, $24

Jump_024_44BA::
    push bc
    ld hl, $44FE
    call Func_024_52BA
    pop bc
    dec b
    jr nz, Jump_024_44BA
    ld de, $59A6
    ld hl, $C300
    ld bc, $1405
    call Func_024_4E12
    call Func_024_51A3
    call Func_024_4EAB
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call Func_024_4E57
    ld a, [$D7FA]
    add a, $08
    call Func_024_4EE8
    xor a, a
    ld [$D781], a
    ld a, [$D780]
    add a, $02
    ld b, a
    ld a, [$D7FA]
    add a, b
    ld [$D780], a
    ret
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00

Jump_024_450E::
    call Func_024_568E
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_024_4519::
    call Func_024_567C
    call Func_024_5553
    ret

Jump_024_4520::
    xor a, a
    ld [$D781], a
    ld a, $01
    ld [$D782], a
    ret

Jump_024_452A::
    ld a, [$D781]
    rst $00
    dw Jump_024_4536
    dw Jump_024_4541
    dw Jump_024_4548
    dw Jump_024_4557

Jump_024_4536::
    call Func_024_568E
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_024_4541::
    call Func_024_567C
    call Func_024_5434
    ret

Jump_024_4548::
    xor a, a
    ld [$C8C3], a
    ld [$C8C4], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_024_4557::
    ld hl, $7333
    ld b, $02
    rst $10
    ld a, [$C8C3]
    bit 7, a
    ret z
    call Func_024_4DEB
    ret

Jump_024_4567::
    ld a, [$D781]
    rst $00
    dw Jump_024_4587
    dw Jump_024_4587
    dw Jump_024_4587
    dw Jump_024_4587
    dw Jump_024_458E
    dw Jump_024_458E
    dw Jump_024_4595
    dw Jump_024_459D
    dw Jump_024_45C7
    dw Jump_024_458E
    dw Jump_024_46BA
    dw Jump_024_4724
    dw Jump_024_475C
    dw Jump_024_47BF

Jump_024_4587::
    ld hl, $40FA
    ld b, $15
    rst $10
    ret

Jump_024_458E::
    ld hl, $665E
    ld b, $1B
    rst $10
    ret

Jump_024_4595::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_024_459D::
    ld a, [$D7AB]
    ld b, $BB
    ld hl, $5AAE
    call Func_024_52CE
    call Func_024_4EAB
    ld bc, $140D
    ld de, $01CC
    call Func_024_4E57
    ld a, [$D7AB]
    ld b, $C3
    ld hl, $5AAE
    call Func_024_52CE
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_024_45C7::
    ld a, [$D782]
    rst $00
    dw Jump_024_45D1
    dw Jump_024_463A
    dw Jump_024_46B5

Jump_024_45D1::
    xor a, a
    ld [$D7F9], a
    ld hl, $66B6
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_024_45F5
    cp a, $FC
    jr z, Jump_024_45F5
    cp a, $FD
    jr z, Jump_024_45FE
    cp a, $FE
    jr z, Jump_024_4607
    cp a, $FF
    jr z, Jump_024_460F
    ret

Jump_024_45F5::
    ld a, [$D781]
    sub a, $07
    ld [$D781], a
    ret

Jump_024_45FE::
    ld a, [$D781]
    sub a, $04
    ld [$D781], a
    ret

Jump_024_4607::
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_024_460F::
    call Func_024_4F29
    cp a, $FF
    jr nz, Jump_024_4621
    ld a, $02
    ld [$D782], a
    ld a, $12
    call Func_024_4EE8
    ret

Jump_024_4621::
    ld a, [$D7AB]
    ld b, $BC
    ld hl, $5AAE
    call Func_024_52CE
    ld hl, $76E3
    ld b, $1B
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_024_463A::
    ld de, $5814
    ld hl, $C364
    ld bc, $0E0D
    call Func_024_4E12
    ld a, [$D7FA]
    ld b, $BB
    ld hl, $5AAA
    call Func_024_52CE
    ld a, [$D092]
    cp a, $08
    jr nz, Jump_024_4666
    ld de, $58CA
    ld hl, $C3F7
    ld bc, $0606
    call Func_024_4E12
    jr Jump_024_4678

Jump_024_4666::
    ld a, [$D7EB]
    and a, a
    jr nz, Jump_024_4678
    ld de, $57F2
    ld hl, $C37A
    ld bc, $1102
    call Func_024_4E12

Jump_024_4678::
    ld de, $5A50
    ld hl, $C40E
    ld bc, $0A05
    call Func_024_4E12
    call Func_024_4EAB
    ld bc, $140D
    ld de, $01CC
    call Func_024_4E57
    ld a, [$D7FA]
    ld b, $C3
    ld hl, $5AAA
    call Func_024_52CE
    xor a, a
    ld [$D782], a
    ld [$D7AF], a
    ld [$D7AB], a
    ld a, $07
    call Func_024_4EE8
    ld a, $02
    ld [$D780], a
    ld a, $08
    ld [$D781], a
    ret

Jump_024_46B5::
    xor a, a
    ld [$D782], a
    ret

Jump_024_46BA::
    xor a, a
    ld [$D7F5], a
    ld hl, $4D24
    ld b, $0D
    rst $10
    ld a, [$D7F5]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_024_46D2
    cp a, $FF
    jr z, Jump_024_46DA
    ret

Jump_024_46D2::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_024_46DA::
    ld a, [$D7AD]
    and a, a
    jr nz, Jump_024_46F9
    ld a, [$D780]
    ld [$D7B2], a
    ld a, [$D781]
    ld [$D7B3], a
    xor a, a
    ld [$D781], a
    ld [$D782], a
    ld a, $0C
    ld [$D780], a
    ret

Jump_024_46F9::
    ld a, [$C6FD]
    cp a, $02
    jr nc, Jump_024_4713
    ld a, [$D7AF]
    and a, a
    jr nz, Jump_024_4713
    ld a, [$D7AB]
    and a, a
    jr nz, Jump_024_4713
    ld a, $12
    call Func_024_4EE8
    jr Jump_024_46D2

Jump_024_4713::
    call Func_024_4FA3
    ld a, $0A
    call Func_024_4EE8
    ld a, [$D781]
    add a, $02
    ld [$D781], a
    ret

Jump_024_4724::
    ld de, $5A28
    ld hl, $C410
    ld bc, $0805
    call Func_024_4E12
    xor a, a
    ld b, $BC
    ld hl, $5AAA
    call Func_024_52CE
    call Func_024_4DA8
    call Func_024_4EAB
    ld bc, $140D
    ld de, $01CC
    call Func_024_4E57
    ld a, [$D7AB]
    ld b, $C3
    ld hl, $5AAE
    call Func_024_52CE
    ld a, [$D781]
    sub a, $03
    ld [$D781], a
    ret

Jump_024_475C::
    ld hl, $5D84
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld a, [hl]
    ld [$D7F1], a
    xor a, a
    ld [$D7F2], a
    ld hl, $7E96
    ld b, $14
    rst $10
    ld a, [$D7F5]
    ld c, $A5
    call Func_000_1682
    ld de, $A000
    add hl, de
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld b, $A5
    ld de, $CA2B

Jump_024_4792::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_024_4792
    ld a, [$CA36]
    ld [$D006], a
    ld a, [$CA37]
    ld [$D007], a
    ld hl, $5AAF
    ld b, $16
    rst $10
    xor a, a
    ld [$0100], a
    ld [$4100], a
    ld [$C8C3], a
    ld [$C8C4], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_024_47BF::
    ld hl, $7333
    ld b, $02
    rst $10
    ld a, [$C8C3]
    bit 7, a
    ret z
    call Func_024_4DEB
    ret

Jump_024_47CF::
    ld a, [$D781]
    rst $00
    dw Jump_024_47EB
    dw Jump_024_47F6
    dw Jump_024_480A
    dw Jump_024_4842
    dw Jump_024_4854
    dw Jump_024_4878
    dw Jump_024_48C8
    dw Jump_024_48EA
    dw Jump_024_494E
    dw Jump_024_49AF
    dw Jump_024_49E8
    dw Jump_024_4A4C

Jump_024_47EB::
    call Func_024_53A0
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_024_47F6::
    ld de, $5B10
    ld hl, $C364
    ld bc, $0D09
    call Func_024_4E12
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_024_480A::
    ld hl, $71E1
    ld b, $1E
    rst $10
    ld a, [$D7B0]
    cp a, $02
    jr c, Jump_024_482E
    ld hl, $C40B
    call Func_024_5392
    ld hl, $C40C
    ld a, h
    ld [$D7F1], a
    ld a, l
    ld [$D7F2], a
    ld hl, $759A
    ld b, $1E
    rst $10

Jump_024_482E::
    call Func_024_4EAB
    ld bc, $140D
    ld de, $01CC
    call Func_024_4E57
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_024_4842::
    xor a, a
    ld [$D7F5], a
    ld hl, $6088
    ld b, $1D
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_024_4854::
    ld de, $4990
    ld hl, $8CE0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    xor a, a
    ld [$D7F1], a
    ld a, $02
    ld [$D7F2], a
    ld hl, $6320
    ld b, $1D
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_024_4878::
    xor a, a
    ld [$D7F9], a
    ld hl, $66B6
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_024_489C
    cp a, $FC
    jr z, Jump_024_489C
    cp a, $FD
    jr z, Jump_024_48A5
    cp a, $FE
    jr z, Jump_024_48A6
    cp a, $FF
    jr z, Jump_024_48AE
    ret

Jump_024_489C::
    ld a, [$D781]
    sub a, $05
    ld [$D781], a
    ret

Jump_024_48A5::
    ret

Jump_024_48A6::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_024_48AE::
    ld a, [$D7AB]
    ld b, $BC
    ld hl, $5AAE
    call Func_024_52CE
    ld hl, $76E3
    ld b, $1B
    rst $10
    ld a, [$D781]
    add a, $02
    ld [$D781], a
    ret

Jump_024_48C8::
    ld a, [$D7FA]
    ld b, $C3
    ld hl, $5AAA
    call Func_024_52CE
    ld a, $04
    ld [$D780], a
    ld a, $08
    ld [$D781], a
    ld a, $01
    ld [$D782], a
    xor a, a
    ld [$D7AF], a
    ld [$D7AB], a
    ret

Jump_024_48EA::
    ld hl, $9700
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0C01
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    xor a, a
    ld [$C528], a
    ld a, $0D
    ld [$C529], a
    ld hl, $7045
    ld b, $33
    rst $10
    ld a, $6C
    call Func_000_1278
    ld de, $5B85
    ld hl, $C410
    ld bc, $0805
    call Func_024_4E12
    call Func_024_4EAB
    ld bc, $140D
    ld de, $01CC
    call Func_024_4E57
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
    ld [$D7AD], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_024_494E::
    xor a, a
    ld [$D7F5], a
    ld hl, $4D24
    ld b, $0D
    rst $10
    ld a, [$D7F5]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_024_4966
    cp a, $FF
    jr z, Jump_024_496E
    ret

Jump_024_4966::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_024_496E::
    ld a, [$D7AD]
    and a, a
    jr nz, Jump_024_498D
    ld a, [$D780]
    ld [$D7B2], a
    ld a, [$D781]
    ld [$D7B3], a
    xor a, a
    ld [$D781], a
    ld [$D782], a
    ld a, $0D
    ld [$D780], a
    ret

Jump_024_498D::
    ld hl, $5DA1
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    call Func_024_4F41
    call Func_024_4F68
    ld a, $0A
    call Func_024_4EE8
    ld a, [$D781]
    add a, $02
    ld [$D781], a
    ret

Jump_024_49AF::
    ld de, $5A82
    ld hl, $C410
    ld bc, $0805
    call Func_024_4E12
    ld a, $01
    ld b, $BC
    ld hl, $5AAA
    call Func_024_52CE
    call Func_024_4DA8
    call Func_024_4EAB
    ld bc, $140D
    ld de, $01CC
    call Func_024_4E57
    ld a, [$D7AB]
    ld b, $C3
    ld hl, $5AAE
    call Func_024_52CE
    ld a, [$D781]
    sub a, $04
    ld [$D781], a
    ret

Jump_024_49E8::
    ld hl, $5DA1
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld a, [hl]
    ld [$D7F1], a
    xor a, a
    ld [$D7F2], a
    ld hl, $7E96
    ld b, $14
    rst $10
    ld a, [$D7F5]
    ld c, $A5
    call Func_000_1682
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld de, $A000
    add hl, de
    ld b, $A5
    ld de, $CA2B

Jump_024_4A1E::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_024_4A1E
    ld a, [$CA36]
    ld [$D006], a
    ld a, [$CA37]
    ld [$D007], a
    ld hl, $5AAF
    ld b, $16
    rst $10
    xor a, a
    ld [$0100], a
    ld [$4100], a
    xor a, a
    ld [$C8C3], a
    ld [$C8C4], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_024_4A4C::
    ld hl, $7333
    ld b, $02
    rst $10
    ld a, [$C8C3]
    bit 7, a
    ret z
    call Func_024_4DEB
    ret

Jump_024_4A5C::
    ret

Jump_024_4A5D::
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
    add a, $03
    ld [$D780], a
    ret

Jump_024_4A79::
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
    inc a
    ld [$D780], a
    ret

Jump_024_4A94::
    ld a, [$D781]
    rst $00
    dw Jump_024_4AA4
    dw Jump_024_4B0E
    dw Jump_024_4B40
    dw Jump_024_4B52
    dw Jump_024_4B77
    dw Jump_024_4BB0

Jump_024_4AA4::
    ld b, $46
    ld de, $4001
    ld hl, $8800
    call Func_000_0CF5
    ld hl, $9700
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0C01
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    xor a, a
    ld [$C528], a
    ld a, $0D
    ld [$C529], a
    ld hl, $7045
    ld b, $33
    rst $10
    call Func_024_53A0
    ld a, [$D092]
    cp a, $08
    jr nz, Jump_024_4AEC
    ld de, $58CA
    ld hl, $C3F7
    ld bc, $0606
    call Func_024_4E12
    jr Jump_024_4AEF

Jump_024_4AEC::
    call Func_024_4D21

Jump_024_4AEF::
    ld de, $5B10
    ld hl, $C364
    ld bc, $0D09
    call Func_024_4E12
    ld a, [$D7AB]
    ld b, $BB
    ld hl, $5AAE
    call Func_024_52CE
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_024_4B0E::
    ld hl, $6026
    ld b, $1D
    rst $10
    ld hl, $71E1
    ld b, $1E
    rst $10
    ld a, [$D7B0]
    cp a, $02
    jr c, Jump_024_4B38
    ld hl, $C40B
    call Func_024_5392
    ld hl, $C40C
    ld a, h
    ld [$D7F1], a
    ld a, l
    ld [$D7F2], a
    ld hl, $759A
    ld b, $1E
    rst $10

Jump_024_4B38::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_024_4B40::
    xor a, a
    ld [$D7F5], a
    ld hl, $6088
    ld b, $1D
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_024_4B52::
    ld de, $4990
    ld hl, $8CE0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld a, $01
    ld [$D7F1], a
    ld a, $02
    ld [$D7F2], a
    ld hl, $6320
    ld b, $1D
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_024_4B77::
    ld de, $5B85
    ld hl, $C410
    ld bc, $0805
    call Func_024_4E12
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
    ld [$C528], a
    ld a, $09
    ld [$C529], a
    ld hl, $7045
    ld b, $33
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_024_4BB0::
    ld a, [$D7AB]
    ld b, $BC
    ld hl, $5AAE
    call Func_024_52CE
    call Func_024_4EAB
    ld bc, $140D
    ld de, $01CC
    call Func_024_4E57
    call Func_024_4EAB
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call Func_024_4E57
    ld a, $70
    ldh [$FFBA], a
    xor a, a
    ld [$D782], a
    ld a, [$D7B2]
    ld [$D780], a
    ld a, [$D7B3]
    ld [$D781], a
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
    ld a, [$C5DB]
    cp a, $05
    ret nz
    ld a, [$C581]
    cp a, $08
    ret z
    ld a, $08
    ld [$D781], a
    ld a, $11
    ld [$D780], a
    ret

Jump_024_4C18::
    ld a, [$D781]
    rst $00
    dw Jump_024_4C2C
    dw Jump_024_4CA0
    dw Jump_024_4CD2
    dw Jump_024_4CE3
    dw Jump_024_4CE3
    dw Jump_024_4CEA
    dw Jump_024_4CE3
    dw Jump_024_4CF2

Jump_024_4C2C::
    ld b, $46
    ld de, $4001
    ld hl, $8800
    call Func_000_0CF5
    ld hl, $9700
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0C01
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    xor a, a
    ld [$C528], a
    ld a, $0D
    ld [$C529], a
    ld hl, $7045
    ld b, $33
    rst $10
    call Func_024_4FD9
    ld a, [$D092]
    cp a, $08
    jr z, Jump_024_4C69
    call Func_024_4D21

Jump_024_4C69::
    ld a, [$D092]
    cp a, $08
    jr z, Jump_024_4C75
    call Func_024_527E
    jr Jump_024_4C81

Jump_024_4C75::
    ld de, $58CA
    ld hl, $C3F7
    ld bc, $0606
    call Func_024_4E12

Jump_024_4C81::
    ld de, $5AB8
    ld hl, $C364
    ld bc, $080B
    call Func_024_4E12
    ld a, [$D7AB]
    ld b, $BC
    ld hl, $5AAE
    call Func_024_52CE
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_024_4CA0::
    ld hl, $5F2D
    ld b, $1D
    rst $10
    ld hl, $7163
    ld b, $1E
    rst $10
    ld a, [$D7B0]
    cp a, $02
    jr c, Jump_024_4CCA
    ld hl, $C42E
    call Func_024_5392
    ld hl, $C42F
    ld a, h
    ld [$D7F1], a
    ld a, l
    ld [$D7F2], a
    ld hl, $759A
    ld b, $1E
    rst $10

Jump_024_4CCA::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_024_4CD2::
    ld hl, $5C15
    ld b, $1F
    rst $10
    xor a, a
    ld [$D7F1], a
    ld hl, $6AA5
    ld b, $1D
    rst $10
    ret

Jump_024_4CE3::
    ld hl, $665E
    ld b, $1B
    rst $10
    ret

Jump_024_4CEA::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_024_4CF2::
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
    ld a, $08
    ld [$C529], a
    xor a, a
    ld [$C528], a
    ld hl, $7045
    ld b, $33
    rst $10
    ld hl, $665E
    ld b, $1B
    rst $10
    ret

Func_024_4D21::
    ld a, [$D7EB]
    and a, a
    ret nz
    call Func_024_504C
    ld de, $57F2
    ld hl, $C37A
    ld bc, $1102
    call Func_024_4E12
    ret

Func_024_4D36::
    ld a, [$C525]
    and a, a
    ret z
    ld hl, $FF68
    di
    call Func_000_120A
    ld a, $B8
    ld [hl+], a
    ei
    ld de, $6CA4
    ld b, $08

Jump_024_4D4B::
    di
    call Func_000_120A
    ld a, [de]
    ld [hl], a
    ei
    inc de
    dec b
    jr nz, Jump_024_4D4B
    ld de, $57D6
    ld hl, $D1E3
    ld b, $1C

Jump_024_4D5E::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_024_4D5E
    ret

Func_024_4D65::
    ld hl, $96D0
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0301
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    xor a, a
    ld [$C528], a
    ld a, $0C
    ld [$C529], a
    ld hl, $7045
    ld b, $33
    rst $10
    xor a, a
    ld [$C52B], a
    ld [$C52C], a
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

Func_024_4DA8::
    ld hl, $9760
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0701
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    xor a, a
    ld [$C528], a
    ld a, $0B
    ld [$C529], a
    ld hl, $7045
    ld b, $33
    rst $10
    xor a, a
    ld [$C52B], a
    ld [$C52C], a
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

Func_024_4DEB::
    ld hl, $D780
    ld bc, $006F

Jump_024_4DF1::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_024_4DF1
    xor a, a
    ld [$C94B], a
    ld a, $05
    ld [$C5DB], a
    ld a, $01
    ld [$C5DC], a
    ld a, $01
    ld [$C5DF], a
    ld a, [$D092]
    cp a, $08
    ret nz
    ret

Func_024_4E12::
    push hl
    push bc

Jump_024_4E14::
    push hl
    push bc

Jump_024_4E16::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_024_4E16
    pop bc
    pop hl
    ld a, l
    add a, $14
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec c
    jp nz, Jump_024_4E14
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

Jump_024_4E3D::
    push hl
    push bc

Jump_024_4E3F::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_024_4E3F
    pop bc
    pop hl
    ld a, l
    add a, $14
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec c
    jp nz, Jump_024_4E3D
    ld a, $00
    ldh [$FF70], a
    ret

Func_024_4E57::
    push de
    push bc
    push hl
    ld hl, $C198
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    pop hl
    push hl
    call Func_000_18A5
    pop hl
    push hl
    ld a, l
    add a, $C1
    ld l, a
    ld a, h
    adc a, $01
    ld h, a
    ld a, l
    ld [$C554], a
    ld a, h
    ld [$C555], a
    pop hl
    pop bc
    pop de
    ld a, [$C525]
    or a, a
    ret z
    push de
    call Func_000_120A
    push bc
    ld c, $4F
    ld a, $01
    ldh [c], a
    pop bc
    pop de
    ld a, $02
    ldh [$FF70], a
    push hl
    ld hl, $D000
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    pop hl
    call Func_000_18A5
    call Func_000_120A
    ld a, $00
    ldh [$FF70], a
    ld c, $4F
    ld a, $00
    ldh [c], a
    ret

Func_024_4EAB::
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
    jr nc, Jump_024_4ECB
    inc h

Jump_024_4ECB::
    ret

Func_024_4ECC:: ; heuristic: follows a terminator; C0
    ld a, [de]
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Func_024_4ECC
    ret

Func_024_4ED5:: ; heuristic: follows a terminator; C0
    ld a, $02
    ldh [$FF70], a

Jump_024_4ED9::
    ld a, [de]
    and a, $07
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_024_4ED9
    ld a, $00
    ldh [$FF70], a
    ret

Func_024_4EE8::
    ld [$C529], a
    xor a, a
    ld [$C528], a
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
    ld hl, $7037
    ld b, $33
    rst $10
    ret

Func_024_4F0C::
    ld hl, $CA2C
    jp Jump_024_4F15

Func_024_4F12::
    ld hl, $C987

Jump_024_4F15::
    ld de, $C130
    ld b, $0A

Jump_024_4F1A::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_024_4F25
    ld [de], a
    inc de
    inc hl
    dec b
    jr nz, Jump_024_4F1A

Jump_024_4F25::
    ld a, $F0
    ld [de], a
    ret

Func_024_4F29::
    ld a, [$C6FD]
    cp a, $02
    jr nc, Jump_024_4F3F
    ld a, [$D7AB]
    and a, a
    jr nz, Jump_024_4F3F
    ld a, [$D7AF]
    and a, a
    jr nz, Jump_024_4F3F
    ld a, $FF
    ret

Jump_024_4F3F::
    xor a, a
    ret

Func_024_4F41::
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld a, [hl]
    ld c, $A5
    call Func_000_1682
    ld de, $A000
    add hl, de
    ld a, $0B
    add a, l
    ld l, a
    jr nc, Jump_024_4F5B
    inc h

Jump_024_4F5B::
    ld a, [hl+]
    ld e, a
    ld d, [hl]
    ld h, d
    ld l, e
    xor a, a
    ld [$0100], a
    ld [$4100], a
    ret

Func_024_4F68::
    push hl
    ld a, [$D7FE]
    push af
    ld a, $08
    ld [$D7FE], a
    ld hl, $4032
    ld a, $04
    add a, l
    ld l, a
    jr nc, Jump_024_4F7C
    inc h

Jump_024_4F7C::
    call Func_000_0B6C
    ld a, b
    ld e, a
    ld a, c
    ld b, a
    ld a, e
    ld c, a
    pop af
    pop hl
    push af
    sla l
    rl h
    add hl, bc
    call Func_000_0B6C
    ld a, b
    ld e, a
    ld a, c
    ld d, a
    pop af
    ld [$D7FE], a
    ld hl, $C130
    ld b, $08
    ld c, $10
    call Func_000_0B2B
    ret

Func_024_4FA3::
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld hl, $5D84
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld a, [hl]
    ld c, $01
    call Func_000_1FA4
    ld a, $F0
    ld [$C8D9], a
    ld hl, $C8CF
    ld de, $C130

Jump_024_4FCB::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_024_4FD5
    ld [de], a
    inc hl
    inc de
    jr Jump_024_4FCB

Jump_024_4FD5::
    ld a, $F0
    ld [de], a
    ret

Func_024_4FD9::
    ld hl, $8D00
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0F01
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    call Func_000_290E
    ld hl, $8F00
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0501
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    call Func_000_290E
    ld hl, $8F80
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    call Func_000_290E
    ld hl, $8A40
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0301
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    call Func_000_290E
    ld hl, $8CE0
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0201
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    call Func_000_290E
    ret

Func_024_504C::
    and a, $01
    and a, a
    jr nz, Jump_024_5058
    ld de, $6CE4
    ld b, $24
    jr Jump_024_505D

Jump_024_5058::
    ld de, $6E13
    ld b, $24

Jump_024_505D::
    ld hl, $9000
    call Func_000_0CF5
    ret

Func_024_5064::
    ld a, [$D092]
    cp a, $08
    ret z
    ld a, [$C525]
    and a, a
    jp z, Jump_024_50F0
    ld hl, $D0DF
    ld de, $D1C9
    call Func_024_51F7
    ld a, [hl+]
    ld e, a
    ld d, [hl]
    push de
    ld a, $7F
    ld [$C526], a
    call Func_000_0829
    ld a, $01
    ldh [$FFC6], a
    call Func_024_4EAB
    xor a, a
    call Func_024_5174
    add hl, de
    pop de
    call Func_000_2090
    ld a, [$D7BD]
    cp a, $01
    jr z, Jump_024_50F0
    ld hl, $D12D
    ld de, $D217
    call Func_024_51F7
    ld a, [hl+]
    ld e, a
    ld d, [hl]
    push de
    ld a, $7F
    ld [$C526], a
    call Func_000_0829
    ld a, $03
    ldh [$FFC6], a
    call Func_024_4EAB
    ld a, $02
    call Func_024_5174
    add hl, de
    pop de
    call Func_000_2090
    ld a, [$D7BD]
    cp a, $02
    jr z, Jump_024_50F0
    ld hl, $D17B
    ld de, $D265
    call Func_024_51F7
    ld a, [hl+]
    ld e, a
    ld d, [hl]
    push de
    ld a, $7F
    ld [$C526], a
    call Func_000_0829
    ld a, $05
    ldh [$FFC6], a
    call Func_024_4EAB
    ld a, $04
    call Func_024_5174
    add hl, de
    pop de
    call Func_000_2090

Jump_024_50F0::
    ld a, [$D092]
    cp a, $08
    jp nz, Jump_024_513A
    ld hl, $C3F7
    call Func_024_5101
    ld hl, $C22B

Func_024_5101::
    ld bc, $0606
    ld d, $20

Jump_024_5106::
    ld [hl], d
    inc d
    inc hl
    dec b
    jr nz, Jump_024_5106
    ld b, $06
    ld a, l
    add a, $0E
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec c
    jr nz, Jump_024_5106
    ld hl, $98E7
    ld bc, $0606
    ld d, $20

Jump_024_5121::
    ld a, d
    call Func_000_121F
    inc d
    dec b
    jr nz, Jump_024_5121
    ld a, l
    add a, $1A
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld b, $06
    dec c
    jr nz, Jump_024_5121
    call Func_024_51A3
    ret

Jump_024_513A::
    call Func_024_4EAB
    ld de, $00E0
    add hl, de
    ld a, h
    ld [$D7F5], a
    ld a, l
    ld [$D7F6], a
    ld a, [$D7BD]
    dec a
    ld c, $78
    call Func_000_1682
    ld de, $720D
    add hl, de
    ld a, h
    ld [$D7F1], a
    ld a, l
    ld [$D7F2], a
    ld a, $14
    ld [$D7F3], a
    ld a, $06
    ld [$D7F4], a
    ld a, $01
    ld [$D7F7], a
    ld hl, $5D2A
    ld b, $1F
    rst $10
    ret

Func_024_5174::
    push hl
    ld e, a
    ld d, $00
    ld a, [$D7BD]
    dec a
    ld hl, $5191
    jr z, Jump_024_518A
    dec a
    ld hl, $5197
    jr z, Jump_024_518A
    ld hl, $519D

Jump_024_518A::
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    pop hl
    ret
    db $E7, $00, $00, $00, $00, $00, $E4, $00, $EA, $00, $00, $00, $E1, $00, $E7, $00
    db $ED, $00

Func_024_51A3::
    ret

Func_024_51A4:: ; heuristic: follows a terminator; C0
    ld a, [$C525]
    and a, a
    ret z
    ld a, [$D092]
    cp a, $08
    ret nz
    ld hl, $51D3
    ld de, $D25F
    ld a, $02
    ldh [$FF70], a
    ld bc, $0606

Jump_024_51BC::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_024_51BC
    ld b, $06
    ld a, e
    add a, $0E
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    dec c
    jr nz, Jump_024_51BC
    xor a, a
    ldh [$FF70], a
    ret
    ds $24, $01

Func_024_51F7::
    ld a, [$C94B]
    and a, a
    jr nz, Jump_024_51FE
    ret

Jump_024_51FE::
    ld l, e
    ld h, d
    ret

Func_024_5201::
    ld a, [$D092]
    cp a, $08
    jr nz, Jump_024_5222
    ld hl, $D0DF
    ld de, $D1C9
    call Func_024_51F7
    ld a, [hl+]
    ld e, a
    ld d, [hl]
    ld hl, $9200
    ld c, $01
    call Func_000_1FE3
    ld a, $01
    ld [$D7BD], a
    ret

Jump_024_5222::
    ld hl, $D0DF
    ld de, $D1C9
    call Func_024_51F7
    ld a, [hl+]
    ld e, a
    ld d, [hl]
    ld hl, $9000
    ld c, $01
    call Func_000_1FE3
    ld hl, $D12D
    ld de, $D217
    call Func_024_51F7
    ld a, [hl+]
    ld b, a
    ld a, [hl-]
    or a, b
    and a, a
    jr nz, Jump_024_524C
    ld a, $01
    ld [$D7BD], a
    ret

Jump_024_524C::
    ld a, [hl+]
    ld e, a
    ld d, [hl]
    ld hl, $9240
    ld c, $03
    call Func_000_1FE3
    ld hl, $D17B
    ld de, $D265
    call Func_024_51F7
    ld a, [hl+]
    ld b, a
    ld a, [hl-]
    or a, b
    and a, a
    jr nz, Jump_024_526D
    ld a, $02
    ld [$D7BD], a
    ret

Jump_024_526D::
    ld a, [hl+]
    ld e, a
    ld d, [hl]
    ld hl, $9480
    ld c, $05
    call Func_000_1FE3
    ld a, $03
    ld [$D7BD], a
    ret

Func_024_527E::
    ld a, [$D7AF]
    ld b, a
    sla a
    sla a
    add a, b
    ld b, a
    ld a, [$D7AB]
    add a, b
    ld hl, $D789
    add a, l
    ld l, a
    jr nc, Jump_024_5294
    inc h

Jump_024_5294::
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    push hl
    ld a, [hl]
    ld c, $0B
    call Func_000_1F89
    ldh a, [$FFC6]
    ld e, a
    ldh a, [$FFC7]
    ld d, a
    push de
    ld hl, $9200
    ld c, $01
    call Func_000_1FE3
    pop de
    pop hl
    xor a, a
    ld [$1FFF], a
    ret

Func_024_52BA::
    xor a, a

Jump_024_52BB::
    push af
    di

Jump_024_52BD::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_024_52BD
    ld a, [hl+]
    ld [de], a
    inc de
    ei
    pop af
    inc a
    cp a, $10
    jr c, Jump_024_52BB
    ret

Func_024_52CE::
    push bc
    sla a
    add a, l
    ld l, a
    jr nc, Jump_024_52D6
    inc h

Jump_024_52D6::
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    pop bc
    ld a, b
    ld [de], a
    ret

Func_024_52DE:: ; heuristic: follows a terminator; C0
    ld hl, $52ED
    ld de, $CA2B
    ld b, $A5

Jump_024_52E6::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_024_52E6
    ret
    db $01, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $D4, $00, $07, $00, $98
    db $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $FF, $FF, $FF, $FF, $98, $98
    db $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $98, $98, $98, $F0, $F0, $F0, $F0
    db $F0, $F0, $F0, $00, $16, $1B, $40
    ds $1F, $00
    INCBIN "dwm2-cobi-us.gbc", $091343, $4F

Func_024_5392::
    ld a, $C5
    ld [hl], a
    inc hl
    inc hl
    ld a, $BE
    ld [hl], a
    inc hl
    inc hl
    ld a, $C6
    ld [hl], a
    ret

Func_024_53A0::
    ld hl, $8BF0
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0401
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    call Func_000_290E
    ld hl, $8C70
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0501
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    call Func_000_290E
    ld hl, $8D00
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0F01
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    call Func_000_290E
    ld hl, $8EA0
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0401
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    call Func_000_290E
    ld hl, $8F50
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0801
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    call Func_000_290E
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

Func_024_5434::
    ld a, [$D782]
    rst $00
    dw Jump_024_5474
    dw Jump_024_5454
    dw Jump_024_5474
    dw Jump_024_548A
    dw Jump_024_5474
    dw Jump_024_54A3
    dw Jump_024_5474
    dw Jump_024_54B6
    dw Jump_024_54DA
    dw Jump_024_5474
    dw Jump_024_5474
    dw Jump_024_54EA
    dw Jump_024_550C
    dw Jump_024_5531

Jump_024_5454::
    ld a, [$CB88]
    and a, $03
    and a, a
    ret z
    ld a, [$CBAA]
    dec a
    ld [$CBAA], a
    ld a, [$CB8A]
    dec a
    ld [$CB8A], a
    cp a, $58
    ret nz
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_024_5474::
    ld a, [$D783]
    inc a
    ld [$D783], a
    cp a, $10
    ret c
    xor a, a
    ld [$D783], a
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_024_548A::
    ld a, [$CB98]
    and a, $03
    and a, a
    ret z
    ld a, [$CB9A]
    inc a
    ld [$CB9A], a
    cp a, $38
    ret nz
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_024_54A3::
    ld a, [$CA99]
    and a, a
    jr z, Jump_024_54AE
    ld a, $80
    ld [$CBCF], a

Jump_024_54AE::
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_024_54B6::
    ld a, [$CA99]
    and a, a
    jr nz, Jump_024_54D2
    ld a, [$CBA8]
    and a, $03
    and a, a
    ret z
    ld a, [$CBAA]
    dec a
    ld [$CBAA], a
    cp a, $28
    ret nz
    ld a, $01
    ld [$CBA6], a

Jump_024_54D2::
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_024_54DA::
    call Func_024_4F12
    ld a, $03
    call Func_024_4EE8
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_024_54EA::
    xor a, a
    ld [$CBCF], a
    ld a, $03
    ld [$CB96], a
    ld a, [$CB98]
    and a, $03
    and a, a
    ret z
    ld a, [$CB9A]
    dec a
    ld [$CB9A], a
    cp a, $18
    ret nz
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_024_550C::
    ld a, $03
    ld [$CBA6], a
    ld a, [$CB98]
    and a, $03
    and a, a
    ret z
    ld a, [$CBAA]
    dec a
    ld [$CBAA], a
    ld a, [$CB9A]
    dec a
    ld [$CB9A], a
    cp a, $D8
    ret nz
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_024_5531::
    ld a, $01
    ld [$CB86], a
    ld a, [$CB88]
    and a, $03
    and a, a
    ret z
    ld a, [$CB8A]
    inc a
    ld [$CB8A], a
    cp a, $B0
    ret nz
    xor a, a
    ld [$D782], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_024_5553::
    ld a, [$D782]
    rst $00
    dw Jump_024_55B1
    dw Jump_024_5573
    dw Jump_024_55B1
    dw Jump_024_5591
    dw Jump_024_55B1
    dw Jump_024_55C7
    dw Jump_024_55B1
    dw Jump_024_55DA
    dw Jump_024_5603
    dw Jump_024_55B1
    dw Jump_024_55B1
    dw Jump_024_5613
    dw Jump_024_5631
    dw Jump_024_5653

Jump_024_5573::
    ld a, [$CB88]
    and a, $03
    and a, a
    ret z
    ld a, [$CB8A]
    dec a
    ld [$CB8A], a
    cp a, $59
    ret nc
    ld a, $58
    ld [$CB8A], a
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_024_5591::
    ld a, [$CB98]
    and a, $03
    and a, a
    ret z
    ld a, [$CBAA]
    inc a
    ld [$CBAA], a
    ld a, [$CB9A]
    inc a
    ld [$CB9A], a
    cp a, $38
    ret nz
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_024_55B1::
    ld a, [$D783]
    inc a
    ld [$D783], a
    cp a, $10
    ret c
    xor a, a
    ld [$D783], a
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_024_55C7::
    ld a, [$CA99]
    and a, a
    jr z, Jump_024_55D2
    ld a, $80
    ld [$CBCF], a

Jump_024_55D2::
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_024_55DA::
    ld a, [$CA99]
    and a, a
    jr nz, Jump_024_55FB
    ld a, [$CBA8]
    and a, $03
    and a, a
    ret z
    ld a, [$CBAA]
    inc a
    ld [$CBAA], a
    cp a, $68
    ret c
    ld a, $68
    ld [$CBAA], a
    ld a, $03
    ld [$CBA6], a

Jump_024_55FB::
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_024_5603::
    call Func_024_4F0C
    ld a, $04
    call Func_024_4EE8
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_024_5613::
    ld a, $03
    ld [$CB96], a
    ld a, [$CB98]
    and a, $03
    and a, a
    ret z
    ld a, [$CB9A]
    dec a
    ld [$CB9A], a
    cp a, $E0
    ret nz
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_024_5631::
    xor a, a
    ld [$CBCF], a
    ld a, $01
    ld [$CB86], a
    ld a, [$CB88]
    and a, $03
    and a, a
    ret z
    ld a, [$CB8A]
    inc a
    ld [$CB8A], a
    cp a, $78
    ret c
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_024_5653::
    ld a, $01
    ld [$CBA6], a
    ld a, [$CB88]
    and a, $03
    and a, a
    ret z
    ld a, [$CBAA]
    inc a
    ld [$CBAA], a
    ld a, [$CB8A]
    inc a
    ld [$CB8A], a
    cp a, $C0
    ret c
    xor a, a
    ld [$D782], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_024_567C::
    ld hl, $44CE
    ld b, $04
    rst $10
    ld a, [$CA99]
    and a, a
    ret z
    ld hl, $6EC6
    ld b, $12
    rst $10
    ret

Func_024_568E::
    ld de, $0000
    call Func_000_181B
    jr c, Jump_024_569B
    ld hl, $5BE9
    jr Jump_024_569E

Jump_024_569B::
    ld hl, $5BF9

Jump_024_569E::
    ld de, $CB7F
    ld b, $10
    call Func_024_578B
    ld hl, $5C09
    ld de, $CB8F
    ld b, $10
    call Func_024_578B
    ld de, $0000
    call Func_000_181B
    jr c, Jump_024_56BE
    ld hl, $5BD1
    jr Jump_024_56C1

Jump_024_56BE::
    ld hl, $5BD7

Jump_024_56C1::
    ld de, $FFC6
    ld b, $06
    call Func_024_578B
    ld hl, $431F
    ld b, $04
    rst $10
    ld hl, $5BDD
    ld de, $FFC6
    ld b, $06
    call Func_024_578B
    ld hl, $431F
    ld b, $04
    rst $10
    ld a, [$CA99]
    and a, a
    jr nz, Jump_024_5762
    ld hl, $5BE3
    ld de, $FFC6
    ld b, $06
    call Func_024_578B
    ld a, [$D092]
    cp a, $08
    jr z, Jump_024_5709
    and a, $01
    and a, a
    jr nz, Jump_024_5709
    ld a, [$CA36]
    ldh [$FFC6], a
    ld a, [$CA37]
    ldh [$FFC7], a
    jr Jump_024_5713

Jump_024_5709::
    ld a, [$C991]
    ldh [$FFC6], a
    ld a, [$C992]
    ldh [$FFC7], a

Jump_024_5713::
    ld hl, $431F
    ld b, $04
    rst $10
    ld a, [$D092]
    cp a, $08
    jr z, Jump_024_572A
    and a, $01
    and a, a
    jr nz, Jump_024_572A
    ld hl, $5C19
    jr Jump_024_572D

Jump_024_572A::
    ld hl, $5C29

Jump_024_572D::
    ld de, $CB9F
    ld b, $10
    call Func_024_578B
    ld a, [$D092]
    cp a, $08
    jr z, Jump_024_574F
    and a, $01
    and a, a
    jr nz, Jump_024_574F
    ld a, [$CA36]
    ld [$CBA1], a
    ld a, [$CA37]
    ld [$CBA2], a
    jr Jump_024_575B

Jump_024_574F::
    ld a, [$C991]
    ld [$CBA1], a
    ld a, [$C992]
    ld [$CBA2], a

Jump_024_575B::
    ld a, $03
    ld [$CB7D], a
    jr Jump_024_577F

Jump_024_5762::
    ld a, $0D
    ldh [$FFC6], a
    ld hl, $6B98
    ld b, $12
    rst $10
    xor a, a
    ld [$CBCF], a
    ld a, $48
    ld [$CBD3], a
    ld a, $40
    ld [$CBD4], a
    ld a, $02
    ld [$CB7D], a

Jump_024_577F::
    ld a, [$C525]
    and a, a
    jr z, Jump_024_578A
    ld a, $7F
    ld [$C527], a

Jump_024_578A::
    ret

Func_024_578B::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Func_024_578B
    ret
    INCBIN "dwm2-cobi-us.gbc", $091792, $44
    ds $1C, $07
    db $00, $01, $02, $03, $04, $05, $C3, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E
    db $0F, $10, $11, $12, $13, $14, $15, $C3, $16, $17, $18, $19, $1A, $1B, $1C, $1D
    db $1E, $1F
    ds $12E, $C3
    db $B0
    ds $12, $B1
    db $B2, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B3
    ds $12, $B4
    db $B5, $B0
    ds $12, $B1
    db $B2, $B6, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8A, $8B, $8C, $8D
    db $8E, $8F, $90, $91, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F
    db $A0, $A1, $A2, $A3, $B7, $B3
    ds $12, $B4
    INCBIN "dwm2-cobi-us.gbc", $091A09, $230

Func_024_5C39::
    ld a, [$C563]
    bit 6, a
    jr nz, Jump_024_5C57
    bit 7, a
    jr nz, Jump_024_5C6D
    ld a, [$C562]
    bit 0, a
    jr nz, Jump_024_5C93
    bit 1, a
    jr nz, Jump_024_5CA1
    call Func_024_5CA7
    xor a, a
    ld [$D7F9], a
    ret

Jump_024_5C57::
    call Func_024_5CC5
    ld a, [$D7FA]
    and a, a
    jr nz, Jump_024_5C67
    ld a, $01
    ld [$D7FA], a
    jr Jump_024_5C81

Jump_024_5C67::
    dec a
    ld [$D7FA], a
    jr Jump_024_5C81

Jump_024_5C6D::
    call Func_024_5CC5
    ld a, [$D7FA]
    cp a, $01
    jr c, Jump_024_5C7D
    xor a, a
    ld [$D7FA], a
    jr Jump_024_5C81

Jump_024_5C7D::
    inc a
    ld [$D7FA], a

Jump_024_5C81::
    xor a, a
    ld [$D783], a
    call Func_024_5CC1
    ld a, $69
    call Func_000_1278
    ld a, $FD
    ld [$D7F9], a
    ret

Jump_024_5C93::
    call Func_024_5CC9
    ld a, $69
    call Func_000_1278
    ld a, $FF
    ld [$D7F9], a
    ret

Jump_024_5CA1::
    ld a, $FE
    ld [$D7F9], a
    ret

Func_024_5CA7::
    ld a, [$C564]
    cp a, $14
    jr c, Func_024_5CC1
    ld a, [$D783]
    inc a
    ld [$D783], a
    cp a, $10
    jr c, Func_024_5CC1
    cp a, $18
    jr c, Func_024_5CC5
    xor a, a
    ld [$D783], a

Func_024_5CC1::
    ld b, $BB
    jr Jump_024_5CCB

Func_024_5CC5::
    ld b, $C3
    jr Jump_024_5CCB

Func_024_5CC9::
    ld b, $BC

Jump_024_5CCB::
    ld a, [$D7FA]
    add a, a
    ld hl, $5D0C
    add a, l
    ld l, a
    jr nc, Jump_024_5CD7
    inc h

Jump_024_5CD7::
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call Func_024_5CEB
    pop de
    add hl, de
    call Func_000_24F8
    di
    call Func_000_120A
    ld a, b
    ld [hl], a
    ei
    ret

Func_024_5CEB::
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
    jr nc, Jump_024_5D0B
    inc h

Jump_024_5D0B::
    ret
    db $2B, $01, $6B, $01

Func_024_5D10::
    ld de, $5D25
    call Func_000_25C9
    ret
    db $11, $25, $5D, $CD, $FE, $25, $C9

Func_024_5D1E::
    call Func_024_5D10
    call Func_000_2611
    ret
    db $27, $5D
    dw Data_024_5D53
    dw Data_024_5D53
    dw Data_024_5D78
    dw Data_024_5D99
    dw Data_024_5DBC
    dw Data_024_5DDB
    dw Data_024_5DF9
    dw Data_024_5E1D
    dw Data_024_5E3F
    dw Data_024_5E62
    dw Data_024_5E8B
    dw Data_024_5EB2
    dw Data_024_5ED7
    dw Data_024_5F15
    dw Data_024_5F57
    dw Data_024_5F90
    dw Data_024_5FCB
    dw Data_024_5FDD
    dw Data_024_5FFA
    dw Data_024_6019
    dw Data_024_6087
    dw Data_024_60CD

Data_024_5D53:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $18, $2B, $98, $90, $0B, $38, $37, $90, $31, $32, $31, $28, $F1
    db $24, $33, $33, $28, $24, $35, $90, $37, $32, $90, $25, $28, $90, $27, $28, $24
    db $27, $A4, $FA, $F7, $F0

Data_024_5D78:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $18, $2B, $98, $90, $0B, $38, $37, $90, $31, $32, $90, $32, $31
    db $28, $F1, $2C, $36, $90, $33, $32, $2C, $36, $32, $31, $28, $27, $B5, $FA, $F7
    db $F0

Data_024_5D99:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0B, $38, $37, $90, $31, $32, $31, $28, $90, $24, $33, $33, $28
    db $24, $35, $F1, $37, $32, $90, $25, $28, $90, $26, $38, $35, $36, $28, $27, $A4
    db $FA, $F7, $F0

Data_024_5DBC:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0D, $32, $90, $3C, $32, $38, $90, $31, $28, $28, $27, $90, $24
    db $31, $3C, $F1, $32, $37, $2B, $28, $35, $90, $2B, $28, $2F, $33, $98, $F0

Data_024_5DDB:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $16, $24, $3C, $90, $37, $2B, $28, $90, $2A, $32, $27, $36, $90
    db $2A, $32, $F1, $3A, $2C, $37, $2B, $90, $3C, $32, $38, $B5, $F7, $F0

Data_024_5DF9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $2B, $2C, $26, $2B, $90, $30, $32, $31, $36, $37, $28, $35
    db $F1, $36, $2B, $32, $38, $2F, $27, $90, $25, $28, $90, $35, $28, $39, $2C, $39
    db $28, $27, $98, $F0

Data_024_5E1D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $2B, $32, $90, $36, $2B, $32, $38, $2F, $27, $90, $25, $28
    db $F1, $26, $38, $35, $28, $27, $90, $32, $29, $90, $33, $32, $2C, $36, $32, $31
    db $98, $F0

Data_024_5E3F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $2B, $32, $90, $36, $2B, $32, $38, $2F, $27, $90, $25, $28
    db $F1, $29, $35, $28, $28, $27, $90, $32, $29, $90, $24, $90, $26, $38, $35, $36
    db $28, $98, $F0

Data_024_5E62:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1C, $38, $35, $28, $2F, $3C, $90, $3C, $32, $38, $90, $2D, $28
    db $36, $37, $B5, $F1, $1D, $2B, $24, $37, $90, $32, $31, $28, $90, $2C, $36, $90
    db $24, $2F, $2C, $39, $28, $B5, $FA, $F7, $F0

Data_024_5E8B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0B, $38, $37, $90, $37, $2B, $24, $37, $90, $30, $32, $31, $36
    db $37, $28, $35, $F1, $2C, $36, $90, $31, $32, $37, $90, $33, $32, $2C, $36, $32
    db $31, $28, $27, $B5, $FA, $F7, $F0

Data_024_5EB2:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0B, $38, $37, $90, $37, $2B, $24, $37, $90, $30, $32, $31, $36
    db $37, $28, $35, $F1, $2C, $36, $90, $31, $32, $37, $90, $26, $38, $35, $36, $28
    db $27, $B5, $FA, $F7, $F0

Data_024_5ED7:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $90, $30, $38, $36, $37, $90, $24, $36, $2E, $90, $29, $32
    db $35, $90, $24, $F1, $36, $30, $24, $2F, $2F, $90, $27, $32, $31, $24, $37, $2C
    db $32, $31, $90, $32, $29, $FA, $F7, $EF, $EE, $F9, $00, $10, $B5, $EF, $EE, $0D
    db $32, $90, $3C, $32, $38, $90, $24, $26, $26, $28, $33, $37, $98, $F0

Data_024_5F15:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $091F15, $42

Data_024_5F57:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $10, $32, $27, $36, $AB, $90, $12, $90, $90, $25, $28, $2A, $F1
    db $3C, $32, $38, $AB, $90, $33, $38, $35, $2C, $29, $3C, $90, $37, $2B, $28, $FA
    db $F7, $EF, $EE, $33, $32, $2C, $36, $32, $31, $90, $36, $38, $2F, $2F, $3C, $2C
    db $31, $2A, $EF, $EE, $F9, $00, $99, $F7, $F0

Data_024_5F90:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $10, $32, $27, $36, $AB, $90, $12, $90, $25, $28, $2A, $F1, $3C
    db $32, $38, $AB, $90, $29, $35, $28, $28, $90, $F9, $00, $FA, $F7, $EF, $EE, $29
    db $35, $32, $30, $90, $2C, $37, $36, $90, $28, $31, $36, $2F, $24, $39, $2C, $31
    db $2A, $EF, $EE, $26, $38, $35, $36, $28, $99, $F7, $F0

Data_024_5FCB:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $F9, $00, $90, $3A, $24, $36, $90, $35, $28, $39, $2C, $39, $28, $27, $99
    db $F7, $F0

Data_024_5FDD:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $F9, $00, $90, $3A, $24, $36, $90, $26, $2F, $28, $24, $31, $36, $28, $27
    db $F1, $32, $29, $90, $33, $32, $2C, $36, $32, $31, $B5, $F7, $F0

Data_024_5FFA:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $F9, $00, $90, $3A, $24, $36, $90, $29, $35, $28, $28, $27, $F1, $29, $35
    db $32, $30, $90, $37, $2B, $28, $90, $26, $38, $35, $36, $28, $B5, $F7, $F0

Data_024_6019:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $092019, $6E

Data_024_6087:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $092087, $46

Data_024_60CD:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $39, $2C, $0D, $9C, $32, $3B, $1E, $31, $26, $38, $35, $37, $F0

Func_024_60DB::
    ld a, [$D780]
    rst $00
    dw Jump_024_60E5
    dw Jump_024_60F1
    dw Jump_024_615B

Jump_024_60E5::
    ld hl, $4069
    ld b, $1E
    rst $10
    ld a, $0B
    ld [$D7F0], a
    ret

Jump_024_60F1::
    ld a, [$D781]
    rst $00
    dw Jump_024_60FB
    dw Jump_024_612C
    dw Jump_024_6143

Jump_024_60FB::
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $8F
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld [hl], $0E
    xor a, a
    ld [$C528], a
    ld a, $15
    ld [$C529], a
    ld hl, $5D1E
    ld b, $24
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

Jump_024_612C::
    ld de, $6B8B
    ld hl, $C364
    ld bc, $0A09
    call Func_024_67FD
    call Func_024_68B0
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_024_6143::
    call Func_024_6866
    ld bc, $140B
    ld de, $01CC
    call Func_024_6837
    xor a, a
    ld [$D781], a
    ld a, [$D780]
    inc a
    ld [$D780], a
    ret

Jump_024_615B::
    ld a, [$D781]
    rst $00
    dw Func_024_6183
    dw Func_024_620A
    dw Func_024_6269
    dw Func_024_628C
    dw Func_024_62C9
    dw Func_024_631E
    dw Func_024_637B
    dw Func_024_6445
    dw Func_024_6497
    dw Func_024_6513
    dw Func_024_6535
    dw Func_024_65B1
    dw Func_024_668D
    db $A3, $66
    dw Func_024_668D
    dw Func_024_6655
    dw Func_024_673C
    dw Func_024_67C0

Func_024_6183:: ; heuristic: target of a pointer table; C0
    xor a, a
    ld [$D7F9], a
    ld a, $04
    ld [$D7A9], a
    ld hl, $65F6
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_024_61A0
    cp a, $FF
    jr z, Jump_024_61AF
    ret

Jump_024_61A0::
    ld a, $04

Jump_024_61A2::
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_024_61AF::
    ld a, [$D7AB]
    and a, a
    jr z, Jump_024_61BF
    cp a, $01
    jr z, Jump_024_61CC
    cp a, $02
    jr z, Jump_024_61D9
    jr Jump_024_61A0

Jump_024_61BF::
    ld b, $80
    call Func_024_6903
    cp a, $FF
    jr z, Jump_024_61E6
    ld a, $01
    jr Jump_024_61A2

Jump_024_61CC::
    ld b, $04
    call Func_024_6903
    cp a, $FF
    jr z, Jump_024_61E6
    ld a, $02
    jr Jump_024_61A2

Jump_024_61D9::
    ld b, $01
    call Func_024_6903
    cp a, $FF
    jr z, Jump_024_61E6
    ld a, $03
    jr Jump_024_61A2

Jump_024_61E6::
    xor a, a
    ld [$D7FA], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ld a, [$D7AB]
    ld b, $BC
    ld hl, $6C96
    call Func_024_68A2
    xor a, a
    ld [$D7AD], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_024_620A:: ; heuristic: target of a pointer table; C0
    ld a, [$D7AB]
    ld [$D7FA], a
    ld hl, $6239
    ld de, $8FE0
    call Func_024_6B7A
    ld hl, $6249
    call Func_024_6B7A
    ld hl, $6259
    ld de, $8EF0
    call Func_024_6B7A
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret
    db $FF, $06, $FF, $06, $FF, $06, $FF, $FF, $FF, $FF, $FF, $00, $FF, $00, $FF, $00
    db $FF, $00, $FF, $00, $FF, $00, $FF, $F8, $FF, $FC, $FF, $0E, $FF, $06, $FF, $06
    db $FF, $60, $FF, $60, $FF, $60, $FF, $1F, $FF, $3F, $FF, $70, $FF, $60, $FF, $60

Func_024_6269:: ; heuristic: target of a pointer table; C0
    ld de, $6C49
    ld hl, $C3DC
    ld bc, $0B07
    call Func_024_67FD
    call Func_024_6944
    call Func_024_6866
    ld bc, $140D
    ld de, $01CC
    call Func_024_6837
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_024_628C:: ; heuristic: target of a pointer table; C0
    call Func_024_69D2
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_024_629D
    cp a, $FF
    jr z, Jump_024_62B3
    ret

Jump_024_629D::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ld a, $01
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_024_62B3::
    ld a, [$D781]
    add a, $02
    ld [$D781], a
    xor a, a
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_024_62C9:: ; heuristic: target of a pointer table; C0
    ld b, $00
    ld c, $07
    ld hl, $0244
    ld de, $0078
    xor a, a
    ld [$D7F1], a
    ld a, $0B
    ld [$D7F2], a
    call Func_024_6A90
    ld de, $6B8B
    ld hl, $C364
    ld bc, $0A09
    call Func_024_67FD
    call Func_024_68B0
    ld a, [$D7AB]
    ld b, $BB
    ld hl, $6C96
    call Func_024_68A2
    call Func_024_6866
    ld bc, $140D
    ld de, $01CC
    call Func_024_6837
    ld a, [$D7AB]
    ld b, $C3
    ld hl, $6C96
    call Func_024_68A2
    xor a, a
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_024_631E:: ; heuristic: target of a pointer table; C0
    ld a, [$D7AB]
    and a, a
    jr z, Jump_024_632C
    cp a, $01
    jr z, Jump_024_6330
    ld b, $01
    jr Jump_024_6332

Jump_024_632C::
    ld b, $80
    jr Jump_024_6332

Jump_024_6330::
    ld b, $04

Jump_024_6332::
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld a, [$D7AD]
    ld hl, $C6FE
    add a, l
    ld l, a
    jr nc, Jump_024_6346
    inc h

Jump_024_6346::
    ld a, [hl]
    ld c, $55
    push bc
    call Func_000_1F80
    pop bc
    xor a, a
    ld [$0100], a
    ld [$4100], a
    ldh a, [$FFC6]
    and a, b
    and a, a
    jr nz, Jump_024_6366
    ld a, $01
    ld [$D781], a
    ld a, [$D7AB]
    inc a
    jr Jump_024_636E

Jump_024_6366::
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a

Jump_024_636E::
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_024_637B:: ; heuristic: target of a pointer table; C0
    ld a, [$D7AB]
    and a, a
    jr z, Jump_024_63C9
    cp a, $01
    jr z, Jump_024_63A2
    ld a, $14
    ld [$D789], a
    xor a, a
    ld [$D78A], a
    ld [$D78B], a
    ld a, $02
    ld [$C130], a
    ld a, $00
    ld [$C131], a
    ld a, $F0
    ld [$C132], a
    jr Jump_024_63B8

Jump_024_63A2::
    ld a, $03
    ld [$D789], a
    xor a, a
    ld [$D78A], a
    ld [$D78B], a
    ld a, $03
    ld [$C130], a
    ld a, $F0
    ld [$C131], a

Jump_024_63B8::
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_024_63C9::
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld a, [$D7AD]
    ld hl, $C6FE
    add a, l
    ld l, a
    jr nc, Jump_024_63DD
    inc h

Jump_024_63DD::
    ld a, [hl]
    ld c, $56
    call Func_000_1F80
    xor a, a
    ld [$0100], a
    ld [$4100], a
    ldh a, [$FFC6]
    ld c, $0A
    call Func_000_1682
    ld a, $0A
    add a, l
    ld l, a
    jr nc, Jump_024_63F8
    inc h

Jump_024_63F8::
    srl h
    rr l
    ld a, l
    ld [$D789], a
    ld [$C8C0], a
    ld a, h
    ld [$D78A], a
    ld [$C8C1], a
    xor a, a
    ld [$D78B], a
    ld [$C8C2], a
    call Func_000_173A
    ld hl, $6676
    ld b, $15
    rst $10
    ld hl, $D7F4
    ld de, $C130
    ld b, $04

Jump_024_6422::
    ld a, [hl]
    cp a, $E3
    jr nz, Jump_024_642B
    inc hl
    dec b
    jr nz, Jump_024_6422

Jump_024_642B::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_024_642B
    ld a, $F0
    ld [de], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_024_6445:: ; heuristic: target of a pointer table; C0
    ld a, $6C
    call Func_000_1278
    ld de, $6479
    ld hl, $C412
    ld bc, $0605
    call Func_024_67FD
    ld a, [$D7AD]
    ld b, $BC
    ld hl, $6C9E
    call Func_024_68A2
    call Func_024_6866
    ld bc, $140D
    ld de, $01CC
    call Func_024_6837
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$D7FA], a
    ret
    db $B0, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $CE, $CF, $DF, $B7, $B6, $C3, $C3, $C3
    db $C3, $B7, $B6, $C3, $A5, $F5, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B5

Func_024_6497:: ; heuristic: target of a pointer table; C0
    ld hl, $6540
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_024_64AB
    cp a, $FF
    jr z, Jump_024_64C8
    ret

Jump_024_64AB::
    call Func_024_6AE4
    xor a, a
    ld [$D782], a
    ld a, $02

Jump_024_64B4::
    ld [$D7FA], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_024_64C8::
    ld a, [$D7FA]
    and a, a
    jr nz, Jump_024_64AB
    ld a, [$D78B]
    ld [$D7F3], a
    ld a, [$D78A]
    ld [$D7F2], a
    ld a, [$D789]
    ld [$D7F1], a
    ld hl, $440F
    ld b, $1C
    rst $10
    ld a, [$D7F1]
    cp a, $FF
    jr z, Jump_024_650A
    call Func_024_6AE4
    xor a, a
    ld [$D7FA], a
    ld a, [$D781]
    add a, $02
    ld [$D781], a
    xor a, a
    ld [$D782], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_024_650A::
    ld a, $01
    ld [$D782], a
    ld a, $01
    jr Jump_024_64B4

Func_024_6513:: ; heuristic: target of a pointer table; C0
    call Func_024_6AE4
    ld a, [$D782]
    and a, a
    jr nz, Jump_024_652B
    ld a, $01
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_024_652B::
    ld a, $04
    ld [$D781], a
    xor a, a
    ld [$D782], a
    ret

Func_024_6535:: ; heuristic: target of a pointer table; C0
    ld a, [$D782]
    and a, a
    jr z, Jump_024_6541
    cp a, $01
    jr z, Jump_024_6571
    jr Jump_024_659A

Jump_024_6541::
    xor a, a
    ld [$D7F3], a
    ld a, [$D78A]
    ld [$D7F2], a
    ld a, [$D789]
    ld [$D7F1], a
    ld hl, $683C
    ld b, $15
    rst $10
    call Func_024_68B0
    call Func_024_6866
    ld bc, $140D
    ld de, $01CC
    call Func_024_6837
    call Func_024_6B3A
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_024_6571::
    ld a, [$D7AB]
    and a, a
    jr z, Jump_024_657F
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_024_657F::
    xor a, a
    ld [$D782], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ld a, [$D7AB]
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_024_659A::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ld a, [$D7AB]
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_024_65B1:: ; heuristic: target of a pointer table; C0
    ld a, [$D782]
    and a, a
    jr z, Jump_024_65BD
    cp a, $01
    jr z, Jump_024_65CA
    jr Jump_024_65F4

Jump_024_65BD::
    ld a, $3D
    call Func_000_122D
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_024_65CA::
    ld a, [$D783]
    add a, $01
    ld [$D783], a
    ld a, [$D784]
    adc a, $00
    ld [$D784], a
    ld a, [$D784]
    and a, a
    ret z
    ld a, [$D783]
    cp a, $28
    ret c
    xor a, a
    ld [$D783], a
    ld [$D784], a
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_024_65F4::
    ld hl, $C364
    ld de, $C198
    ld bc, $0104
    call Func_024_6887
    ld hl, $C300
    ld de, $C29C
    ld bc, $0064
    call Func_024_6887
    ld a, [$C525]
    and a, a
    jr z, Jump_024_662A
    ld hl, $D1CC
    ld de, $D000
    ld bc, $0104
    call Func_024_6890
    ld hl, $D168
    ld de, $D104
    ld bc, $0064
    call Func_024_6890

Jump_024_662A::
    call Func_024_6866
    ld bc, $140D
    ld de, $01CC
    call Func_024_6837
    call Func_024_6866
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call Func_024_6837
    xor a, a
    ldh [$FFB9], a
    xor a, a
    ld [$D782], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_024_6655:: ; heuristic: target of a pointer table; C0
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    call Func_000_290E
    ld de, $6BE5
    ld hl, $C300
    ld bc, $1405
    call Func_024_67FD
    call Func_024_6866
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call Func_024_6837
    ld a, $02
    ldh [$FFB9], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_024_668D:: ; heuristic: target of a pointer table; C0
    ld hl, $D783
    inc [hl]
    ld a, [$D783]
    cp a, $1C
    ret c
    xor a, a
    ld [$D783], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret
    INCBIN "dwm2-cobi-us.gbc", $0926A3, $99

Func_024_673C:: ; heuristic: target of a pointer table; C0
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld a, [$D7AD]
    ld hl, $C6FE
    add a, l
    ld l, a
    jr nc, Jump_024_6750
    inc h

Jump_024_6750::
    push hl
    ld a, [hl]
    ld c, $55
    call Func_000_1FD1
    ld a, [$D7AB]
    ld de, $67BD
    add a, e
    ld e, a
    jr nc, Jump_024_6762
    inc d

Jump_024_6762::
    ld a, [de]
    ld b, a
    ld a, [hl]
    and a, b
    ld [hl], a
    pop hl
    ld a, [$D7AB]
    and a, a
    jr nz, Jump_024_6797
    ld a, [hl]
    ld c, $5D
    call Func_000_1FD1
    ld a, [hl+]
    ld e, a
    ld a, [hl-]
    ld d, a
    dec hl
    dec hl
    ld a, e
    ld [hl+], a
    ld [hl], d
    inc hl
    ld a, $04
    add a, l
    ld l, a
    jr nc, Jump_024_6785
    inc h

Jump_024_6785::
    ld a, [hl+]
    ld e, a
    ld a, [hl-]
    ld d, a
    dec hl
    dec hl
    ld a, e
    ld [hl+], a
    ld [hl], d
    ld hl, $5E82
    ld b, $02
    rst $10
    call Func_000_222B

Jump_024_6797::
    xor a, a
    ld [$0100], a
    ld [$4100], a
    call Func_024_6B3A
    ld a, [$D781]
    inc a
    ld [$D781], a
    ld hl, $4AA8
    ld b, $04
    rst $10
    ld a, $7F
    ld [$C527], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret
    db $00, $FB, $FE

Func_024_67C0:: ; heuristic: target of a pointer table; C0
    ld b, $80
    call Func_024_6903
    cp a, $FF
    jr z, Jump_024_67EA
    ld b, $04
    call Func_024_6903
    cp a, $FF
    jr z, Jump_024_67EA
    ld b, $01
    call Func_024_6903
    cp a, $FF
    jr z, Jump_024_67EA
    ld a, $01
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_024_67EA::
    xor a, a
    ld [$D7FA], a
    ld a, $04
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_024_67FD::
    push hl
    push bc

Jump_024_67FF::
    push bc
    push hl

Jump_024_6801::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_024_6801
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_024_67FF
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

Jump_024_6823::
    push bc
    push hl

Jump_024_6825::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_024_6825
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_024_6823
    xor a, a
    ldh [$FF70], a
    ret

Func_024_6837::
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

Func_024_6866::
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
    jr nc, Jump_024_6886
    inc h

Jump_024_6886::
    ret

Func_024_6887::
    ld a, [de]
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Func_024_6887
    ret

Func_024_6890::
    ld a, $02
    ldh [$FF70], a

Jump_024_6894::
    ld a, [de]
    and a, $07
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_024_6894
    xor a, a
    ldh [$FF70], a
    ret

Func_024_68A2::
    push bc
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_024_68A9
    inc h

Jump_024_68A9::
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop bc
    ld a, b
    ld [de], a
    ret

Func_024_68B0::
    ld de, $68EB
    ld hl, $C370
    ld bc, $0803
    call Func_024_67FD
    ld a, [$C617]
    ld [$C8C0], a
    ld a, [$C618]
    ld [$C8C1], a
    ld a, [$C619]
    ld [$C8C2], a
    call Func_000_173A
    ld hl, $6676
    ld b, $15
    rst $10
    ld hl, $C386
    ld de, $D7F3
    ld c, $00

Jump_024_68DF::
    ld a, [de]
    add a, $E0
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $05
    jr c, Jump_024_68DF
    ret
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $BF, $C3, $C3, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Func_024_6903::
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld a, [$C6FD]
    ld c, a
    ld hl, $C6FE
    ld e, $00

Jump_024_6915::
    push de
    push hl
    push bc
    ld a, [hl]
    ld c, $55
    call Func_000_1F80
    ldh a, [$FFC6]
    pop bc
    push bc
    and a, b
    and a, a
    jr nz, Jump_024_6937
    pop bc
    pop hl
    pop de
    inc hl
    inc e
    ld a, e
    cp a, c
    jr c, Jump_024_6915
    xor a, a
    ld [$0100], a
    ld [$4100], a
    ret

Jump_024_6937::
    pop bc
    pop hl
    pop de
    xor a, a
    ld [$0100], a
    ld [$4100], a
    ld a, $FF
    ret

Func_024_6944::
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld a, [$C6FD]
    ld c, a
    ld e, $00
    ld hl, $C6FE

Jump_024_6956::
    push hl
    push bc
    push de
    ld a, [hl]
    ld c, $55
    call Func_000_1F80
    pop de
    push de
    ldh a, [$FFC6]
    bit 0, a
    call nz, Func_024_6987
    ldh a, [$FFC6]
    bit 2, a
    call nz, Func_024_699A
    ldh a, [$FFC6]
    bit 7, a
    call nz, Func_024_69AD
    pop de
    pop bc
    pop hl
    inc hl
    inc e
    ld a, e
    cp a, c
    jr c, Jump_024_6956
    xor a, a
    ld [$0100], a
    ld [$4100], a
    ret

Func_024_6987::
    push de
    ld a, e
    add a, a
    ld hl, $69C0
    add a, l
    ld l, a
    jr nc, Jump_024_6992
    inc h

Jump_024_6992::
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, $C0
    ld [de], a
    pop de
    ret

Func_024_699A::
    push de
    ld a, e
    add a, a
    ld hl, $69C6
    add a, l
    ld l, a
    jr nc, Jump_024_69A5
    inc h

Jump_024_69A5::
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, $C1
    ld [de], a
    pop de
    ret

Func_024_69AD::
    push de
    ld a, e
    add a, a
    ld hl, $69CC
    add a, l
    ld l, a
    jr nc, Jump_024_69B8
    inc h

Jump_024_69B8::
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, $C2
    ld [de], a
    pop de
    ret
    db $F7, $C3, $1F, $C4, $47, $C4, $F8, $C3, $20, $C4, $48, $C4, $F9, $C3, $21, $C4
    db $49, $C4

Func_024_69D2::
    ld a, [$C563]
    bit 6, a
    jr nz, Jump_024_69F0
    bit 7, a
    jr nz, Jump_024_6A08
    ld a, [$C562]
    bit 0, a
    jr nz, Jump_024_6A32
    bit 1, a
    jr nz, Jump_024_6A40
    call Func_024_6A46
    xor a, a
    ld [$D7F9], a
    ret

Jump_024_69F0::
    call Func_024_6A64
    ld a, [$D7AD]
    and a, a
    jr nz, Jump_024_6A02
    ld a, [$C6FD]
    dec a
    ld [$D7AD], a
    jr Jump_024_6A20

Jump_024_6A02::
    dec a
    ld [$D7AD], a
    jr Jump_024_6A20

Jump_024_6A08::
    call Func_024_6A64
    ld a, [$C6FD]
    dec a
    ld b, a
    ld a, [$D7AD]
    cp a, b
    jr c, Jump_024_6A1C
    xor a, a
    ld [$D7AD], a
    jr Jump_024_6A20

Jump_024_6A1C::
    inc a
    ld [$D7AD], a

Jump_024_6A20::
    xor a, a
    ld [$D7AE], a
    call Func_024_6A60
    ld a, $69
    call Func_000_1278
    ld a, $FD
    ld [$D7F9], a
    ret

Jump_024_6A32::
    ld a, $69
    call Func_000_1278
    call Func_024_6A68
    ld a, $FF
    ld [$D7F9], a
    ret

Jump_024_6A40::
    ld a, $FE
    ld [$D7F9], a
    ret

Func_024_6A46::
    ld a, [$C564]
    cp a, $14
    jr c, Func_024_6A60
    ld a, [$D7AE]
    inc a
    ld [$D7AE], a
    cp a, $10
    jr c, Func_024_6A60
    cp a, $18
    jr c, Func_024_6A64
    xor a, a
    ld [$D7AE], a

Func_024_6A60::
    ld b, $BB
    jr Jump_024_6A6A

Func_024_6A64::
    ld b, $C3
    jr Jump_024_6A6A

Func_024_6A68::
    ld b, $BC

Jump_024_6A6A::
    ld a, [$D7AD]
    add a, a
    ld hl, $6A8A
    add a, l
    ld l, a
    jr nc, Jump_024_6A76
    inc h

Jump_024_6A76::
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call Func_024_6866
    pop de
    add hl, de
    call Func_000_24F8
    di
    call Func_000_120A
    ld a, b
    ld [hl], a
    ei
    ret
    db $E1, $00, $21, $01, $61, $01

Func_024_6A90::
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
    call Func_024_6887
    pop de
    pop hl
    ld a, [$C525]
    and a, a
    jr z, Jump_024_6AD1
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
    call Func_024_6890
    pop de
    pop hl

Jump_024_6AD1::
    pop bc
    ld a, $14
    add a, l
    ld l, a
    jr nc, Jump_024_6AD9
    inc h

Jump_024_6AD9::
    ld a, $14
    add a, e
    ld e, a
    jr nc, Jump_024_6AE0
    inc d

Jump_024_6AE0::
    dec c
    jr nz, Func_024_6A90
    ret

Func_024_6AE4::
    ld hl, $C412
    ld de, $C246
    ld c, $00
    call Func_024_6B19
    ld a, [$C525]
    and a, a
    jr z, Jump_024_6B0C
    ldh a, [$FF70]
    set 1, a
    ldh [$FF70], a
    ld hl, $D27A
    ld de, $D0AE
    ld c, $00
    call Func_024_6B19
    ldh a, [$FF70]
    res 1, a
    ldh [$FF70], a

Jump_024_6B0C::
    call Func_024_6866
    ld bc, $140D
    ld de, $01CC
    call Func_024_6837
    ret

Func_024_6B19::
    push hl
    push de
    push bc
    ld bc, $0006
    call Func_024_6887
    pop bc
    pop de
    pop hl
    ld a, $14
    add a, l
    ld l, a
    jr nc, Jump_024_6B2C
    inc h

Jump_024_6B2C::
    ld a, $14
    add a, e
    ld e, a
    jr nc, Jump_024_6B33
    inc d

Jump_024_6B33::
    inc c
    ld a, c
    cp a, $05
    jr c, Func_024_6B19
    ret

Func_024_6B3A::
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld a, [$D7AD]
    ld hl, $C6FE
    add a, l
    ld l, a
    jr nc, Jump_024_6B4E
    inc h

Jump_024_6B4E::
    ld a, [hl]
    ld c, $01
    call Func_000_1FA4
    ld a, $F0
    ld [$C8D9], a
    xor a, a
    ld [$0100], a
    ld [$4100], a
    ld hl, $C8CF
    ld de, $C130
    ld c, $00

Jump_024_6B68::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_024_6B76
    ld [de], a
    inc hl
    inc de
    inc c
    ld a, c
    cp a, $0A
    jr c, Jump_024_6B68

Jump_024_6B76::
    ld a, $F0
    ld [de], a
    ret

Func_024_6B7A::
    ld c, $10

Jump_024_6B7C::
    di

Jump_024_6B7D::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_024_6B7D
    ld a, [hl+]
    ld [de], a
    inc de
    ei
    dec c
    jr nz, Jump_024_6B7C
    ret
    INCBIN "dwm2-cobi-us.gbc", $092B8B, $5B
    ds $12, $B1
    db $B2, $B6, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8A, $8B, $8C, $8D
    db $8E, $8F, $90, $91, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F
    db $A0, $A1, $A2, $A3, $B7, $B3
    ds $12, $B4
    INCBIN "dwm2-cobi-us.gbc", $092C48, $5C
    ds $38, $00
    INCBIN "dwm2-cobi-us.gbc", $092CDC, $369

Func_024_7045::
    ld a, [$D7C9]
    and a, a
    jr nz, Jump_024_704B

Jump_024_704B::
    ld a, [$D780]
    cp a, $04
    jr nz, Jump_024_7057
    ld hl, $D7D5
    jr Jump_024_7062

Jump_024_7057::
    ld hl, $68FA
    ld b, $1C
    rst $10
    ld a, [$D7F1]
    jr Jump_024_707A

Jump_024_7062::
    ld a, [$D7B6]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, [$D7B5]
    add a, l
    ld l, a
    jr nc, Jump_024_7079
    inc h

Jump_024_7079::
    ld a, [hl]

Jump_024_707A::
    ld e, a
    ld d, $00
    sla e
    rl d
    ld hl, $7158
    add hl, de
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    ld a, [$D7C4]
    ld e, a
    ld a, [$D7C3]
    ld d, a
    add hl, de
    ld a, [hl]
    cp a, $F0
    jp z, Jump_024_7124
    cp a, $F1
    jp z, Jump_024_7139
    ld [$D7B8], a
    push hl
    ld hl, $4010
    swap a
    ld d, a
    and a, $F0
    ld e, a
    ld a, d
    and a, $0F
    ld d, a
    add hl, de
    ld e, l
    ld d, h
    push de
    ld a, [$D7B8]
    cp a, $8D
    jr z, Jump_024_70BF
    cp a, $8E
    jr z, Jump_024_70BF
    jr Jump_024_70D5

Jump_024_70BF::
    ld a, [$D7C6]
    ld e, a
    ld a, [$D7C5]
    ld d, a
    ld a, e
    sub a, $10
    ld e, a
    ld a, d
    sbc a, $00
    ld [$D7C5], a
    ld a, e
    ld [$D7C6], a

Jump_024_70D5::
    ld a, [$D7C6]
    ld e, a
    ld a, [$D7C5]
    ld d, a
    ld hl, $8800
    add hl, de
    pop de
    ld b, $1F
    ld c, $10
    ld a, [$D7B8]
    cp a, $8D
    jr z, Jump_024_70F6
    cp a, $8E
    jr z, Jump_024_70F6
    call Func_000_0B2B
    jr Jump_024_70F9

Jump_024_70F6::
    call Func_000_0B46

Jump_024_70F9::
    pop hl
    ld a, [$D7C3]
    ld d, a
    ld a, [$D7C4]
    add a, $01
    ld [$D7C4], a
    ld a, d
    adc a, $00
    ld [$D7C3], a
    ld a, [$D7C5]
    ld d, a
    ld a, [$D7C6]
    ld e, a
    add a, $10
    ld e, a
    ld a, d
    adc a, $00
    ld [$D7C5], a
    ld a, e
    ld [$D7C6], a
    jp Func_024_7045

Jump_024_7124::
    xor a, a
    ld [$D7C3], a
    ld [$D7C4], a
    ld [$D7C5], a
    ld [$D7C6], a
    ld a, [$D7C2]
    inc a
    ld [$D7C2], a
    ret

Jump_024_7139::
    ld a, [$D7C3]
    ld d, a
    ld a, [$D7C4]
    add a, $01
    ld [$D7C4], a
    ld a, d
    adc a, $00
    ld [$D7C3], a
    ld a, $01
    ld [$D7C5], a
    ld a, $20
    ld [$D7C6], a
    jp Func_024_7045
    dw Data_024_721E
    dw Data_024_721E
    dw Data_024_7243
    dw Data_024_7268
    dw Data_024_728B
    dw Data_024_72B0
    dw Data_024_72D2
    dw Data_024_72F0
    dw Data_024_7301
    dw Data_024_7320
    dw Data_024_733C
    dw Data_024_735E
    dw Data_024_7384
    dw Data_024_739C
    dw Data_024_73AD
    dw Data_024_73BE
    dw Data_024_73CF
    dw Data_024_73E0
    dw Data_024_73F5
    dw Data_024_740A
    dw Data_024_7423
    dw Data_024_7443
    dw Data_024_7461
    dw Data_024_747C
    dw Data_024_749E
    dw Data_024_74BE
    dw Data_024_74DC
    dw Data_024_74F9
    dw Data_024_750F
    dw Data_024_7529
    dw Data_024_754D
    dw Data_024_7568
    dw Data_024_758D
    dw Data_024_75AF
    dw Data_024_75D0
    dw Data_024_75EC
    dw Data_024_760B
    dw Data_024_762E
    dw Data_024_764F
    dw Data_024_7671
    dw Data_024_7692
    dw Data_024_76B6
    dw Data_024_76D3
    dw Data_024_76F0
    dw Data_024_770F
    dw Data_024_7731
    dw Data_024_7755
    dw Data_024_776C
    dw Data_024_776C
    dw Data_024_7781
    dw Data_024_77A5
    dw Data_024_77C8
    dw Data_024_77E5
    dw Data_024_7807
    dw Data_024_7827
    dw Data_024_784C
    dw Data_024_7867
    dw Data_024_7883
    dw Data_024_78A7
    dw Data_024_78CB
    dw Data_024_78F0
    dw Data_024_7911
    dw Data_024_7928
    dw Data_024_7928
    dw Data_024_7933
    dw Data_024_7949
    dw Data_024_795F
    dw Data_024_7975
    dw Data_024_798B
    dw Data_024_799D
    dw Data_024_79AF
    dw Data_024_79C1
    dw Data_024_79D3
    dw Data_024_79E5
    dw Data_024_79F7
    dw Data_024_7A09
    dw Data_024_7A1C
    dw Data_024_7A40
    dw Data_024_7A63
    dw Data_024_7A86
    dw Data_024_7AA2
    dw Data_024_7AC4
    dw Data_024_7AE7
    dw Data_024_7B0A
    dw Data_024_7B1B
    dw Data_024_7B1B
    dw Data_024_7B1B
    dw Data_024_7B1B
    dw Data_024_7B1B
    dw Data_024_7B1B
    dw Data_024_7B26
    dw Data_024_7B46
    dw Data_024_7B66
    dw Data_024_7B7D
    dw Data_024_7B94
    dw Data_024_7BB5
    dw Data_024_7BD6
    dw Data_024_7BF7
    dw Data_024_7C18

Data_024_721E:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $36, $37, $32, $35, $28, $36, $90, $11, $19, $90, $32, $29, $90, $32
    db $31, $28, $F1, $30, $32, $31, $36, $37, $28, $35, $90, $25, $3C, $90, $03, $00
    db $9D, $04, $00, $B5, $F0

Data_024_7243:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $36, $37, $32, $35, $28, $36, $90, $11, $19, $90, $32, $29, $90, $32
    db $31, $28, $F1, $30, $32, $31, $36, $37, $28, $35, $90, $25, $3C, $90, $06, $00
    db $9D, $07, $00, $B5, $F0

Data_024_7268:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $38, $2F, $2F, $3C, $90, $35, $28, $36, $37, $32, $35, $28, $36, $90, $11
    db $19, $F1, $32, $29, $90, $24, $2F, $2F, $90, $30, $32, $31, $36, $37, $28, $35
    db $36, $B5, $F0

Data_024_728B:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $36, $37, $32, $35, $28, $36, $90, $16, $19, $90, $32, $29, $90, $32
    db $31, $28, $F1, $30, $32, $31, $36, $37, $28, $35, $90, $25, $3C, $90, $02, $00
    db $9D, $03, $00, $B5, $F0

Data_024_72B0:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $38, $2F, $2F, $3C, $90, $35, $28, $36, $37, $32, $35, $28, $36, $90, $16
    db $19, $F1, $32, $29, $90, $32, $31, $28, $90, $30, $32, $31, $36, $37, $28, $35
    db $B5, $F0

Data_024_72D2:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $30, $32, $39, $28, $36, $90, $24, $2F, $2F, $90, $37, $35, $24, $26
    db $28, $36, $F1, $32, $29, $90, $33, $32, $2C, $36, $32, $31, $B5, $F0

Data_024_72F0:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $38, $35, $28, $36, $90, $33, $24, $35, $24, $2F, $3C, $36, $2C, $36, $B5
    db $F0

Data_024_7301:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $29, $37, $36, $90, $24, $90, $26, $38, $35, $36, $28, $90, $32, $29
    db $29, $F1, $32, $31, $28, $90, $30, $32, $31, $36, $37, $28, $35, $B5, $F0

Data_024_7320:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $3A, $24, $2E, $28, $31, $36, $90, $24, $90, $36, $2F, $28, $28, $33, $2C
    db $31, $2A, $F1, $30, $32, $31, $36, $37, $28, $35, $B5, $F0

Data_024_733C:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $31, $24, $33, $36, $90, $24, $90, $30, $32, $31, $36, $37, $28, $35, $F1
    db $32, $38, $37, $90, $32, $29, $90, $26, $32, $31, $29, $38, $36, $2C, $32, $31
    db $B5, $F0

Data_024_735E:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $36, $37, $32, $35, $28, $36, $90, $11, $19, $90, $32, $29, $90, $24
    db $2F, $2F, $F1, $30, $32, $31, $36, $37, $28, $35, $36, $90, $25, $3C, $90, $06
    db $00, $9D, $07, $00, $B5, $F0

Data_024_7384:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $39, $2C, $39, $28, $36, $90, $24, $90, $27, $28, $24, $27, $F1, $30
    db $32, $31, $36, $37, $28, $35, $B5, $F0

Data_024_739C:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $2C, $36, $28, $36, $90, $0A, $1D, $14, $90, $25, $3C, $90, $03, $B5
    db $F0

Data_024_73AD:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $2C, $36, $28, $36, $90, $0D, $0E, $0F, $90, $25, $3C, $90, $03, $B5
    db $F0

Data_024_73BE:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $2C, $36, $28, $36, $90, $0A, $10, $15, $90, $25, $3C, $90, $03, $B5
    db $F0

Data_024_73CF:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $2C, $36, $28, $36, $90, $12, $17, $1D, $90, $25, $3C, $90, $03, $B5
    db $F0

Data_024_73E0:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $2C, $36, $28, $36, $90, $30, $24, $3B, $B5, $90, $11, $19, $F1, $25
    db $3C, $90, $05, $B5, $F0

Data_024_73F5:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $2C, $36, $28, $36, $90, $30, $24, $3B, $B5, $90, $16, $19, $F1, $25
    db $3C, $90, $05, $B5, $F0

Data_024_740A:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $2E, $28, $36, $90, $37, $2B, $28, $90, $35, $28, $24, $27, $28, $35
    db $F1, $25, $35, $24, $39, $28, $35, $B5, $F0

Data_024_7423:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $2E, $28, $36, $90, $37, $2B, $28, $90, $35, $28, $24, $27, $28, $35
    db $F1, $30, $32, $35, $28, $90, $26, $32, $3A, $24, $35, $27, $2F, $3C, $B5, $F0

Data_024_7443:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $2E, $28, $36, $90, $37, $2B, $28, $90, $35, $28, $24, $27, $28, $35
    db $F1, $30, $32, $35, $28, $90, $2E, $2C, $31, $27, $2F, $3C, $B5, $F0

Data_024_7461:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $2E, $28, $36, $90, $37, $2B, $28, $90, $35, $28, $24, $27, $28, $35
    db $F1, $30, $32, $35, $28, $90, $36, $2F, $3C, $B5, $F0

Data_024_747C:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $2E, $28, $36, $90, $37, $2B, $28, $90, $35, $28, $24, $27, $28, $35
    db $F1, $30, $32, $35, $28, $90, $37, $2B, $32, $38, $2A, $2B, $37, $29, $38, $2F
    db $B5, $F0

Data_024_749E:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $2E, $28, $36, $90, $37, $2B, $28, $90, $35, $28, $24, $27, $28, $35
    db $F1, $36, $2C, $30, $33, $2F, $28, $9C, $30, $2C, $31, $27, $28, $27, $B5, $F0

Data_024_74BE:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $24, $30, $28, $36, $90, $30, $32, $31, $36, $37, $28, $35, $36, $F1, $2D
    db $38, $36, $37, $90, $24, $90, $2F, $2C, $37, $37, $2F, $28, $B5, $F0

Data_024_74DC:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $24, $30, $28, $36, $90, $30, $32, $31, $36, $37, $28, $35, $36, $90, $24
    db $F1, $2F, $2C, $37, $37, $2F, $28, $90, $25, $2C, $37, $B5, $F0

Data_024_74F9:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $24, $30, $28, $36, $90, $30, $32, $31, $36, $37, $28, $35, $36, $90, $24
    db $F1, $2F, $32, $37, $B5, $F0

Data_024_750F:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $24, $30, $28, $36, $90, $30, $32, $31, $36, $37, $28, $35, $36, $F1, $39
    db $28, $35, $3C, $90, $30, $38, $26, $2B, $B5, $F0

Data_024_7529:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $24, $30, $28, $36, $90, $24, $90, $37, $2C, $31, $3C, $90, $25, $2C, $37
    db $AB, $F1, $25, $38, $37, $90, $24, $2F, $36, $32, $90, $33, $32, $2C, $36, $32
    db $31, $36, $B5, $F0

Data_024_754D:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $24, $30, $28, $36, $90, $30, $32, $31, $36, $37, $28, $35, $36, $F1, $2C
    db $31, $26, $35, $28, $27, $2C, $25, $2F, $3C, $B5, $F0

Data_024_7568:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2B, $28, $26, $2E, $36, $90, $2C, $29, $90, $30, $32, $31, $36, $37, $28
    db $35, $F1, $3A, $24, $36, $90, $26, $24, $38, $2A, $2B, $37, $90, $25, $28, $29
    db $32, $35, $28, $B5, $F0

Data_024_758D:: ; heuristic: target of a monotone pointer table; C0
    db $19, $35, $28, $39, $28, $31, $37, $36, $90, $30, $32, $31, $36, $37, $28, $35
    db $36, $F1, $29, $35, $32, $30, $90, $24, $33, $33, $28, $24, $35, $2C, $31, $2A
    db $B5, $F0

Data_024_75AF:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $37, $37, $35, $24, $26, $37, $36, $90, $30, $32, $31, $36, $37, $28, $35
    db $36, $F1, $3A, $2B, $28, $31, $90, $36, $37, $35, $38, $30, $30, $28, $27, $B5
    db $F0

Data_024_75D0:: ; heuristic: target of a monotone pointer table; C0
    db $19, $35, $28, $39, $28, $31, $37, $36, $90, $26, $24, $36, $37, $2C, $31, $2A
    db $F1, $32, $29, $90, $36, $33, $28, $2F, $2F, $36, $B5, $F0

Data_024_75EC:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $32, $38, $25, $2F, $28, $36, $90, $33, $2B, $3C, $36, $2C, $26, $24, $2F
    db $F1, $33, $32, $3A, $28, $35, $90, $32, $29, $90, $32, $31, $28, $B5, $F0

Data_024_760B:: ; heuristic: target of a monotone pointer table; C0
    db $11, $2C, $37, $36, $90, $24, $2F, $2F, $90, $28, $31, $28, $30, $2C, $28, $36
    db $F1, $3A, $2C, $37, $2B, $90, $24, $90, $3A, $2C, $31, $27, $36, $37, $32, $35
    db $30, $B5, $F0

Data_024_762E:: ; heuristic: target of a monotone pointer table; C0
    db $11, $2C, $37, $36, $90, $24, $2F, $2F, $90, $28, $31, $28, $30, $2C, $28, $36
    db $F1, $3A, $2C, $37, $2B, $90, $2F, $2C, $2A, $2B, $37, $31, $2C, $31, $2A, $B5
    db $F0

Data_024_764F:: ; heuristic: target of a monotone pointer table; C0
    db $11, $2C, $37, $36, $90, $24, $2F, $2F, $90, $28, $31, $28, $30, $2C, $28, $36
    db $F1, $3A, $2C, $37, $2B, $90, $24, $90, $25, $2F, $2C, $3D, $3D, $24, $35, $27
    db $B5, $F0

Data_024_7671:: ; heuristic: target of a monotone pointer table; C0
    db $11, $2C, $37, $36, $90, $32, $31, $28, $90, $37, $24, $35, $2A, $28, $37, $F1
    db $3A, $2C, $37, $2B, $90, $24, $90, $29, $2C, $35, $28, $25, $24, $2F, $2F, $B5
    db $F0

Data_024_7692:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $36, $37, $24, $31, $37, $2F, $3C, $90, $3A, $24, $35, $33, $36, $90
    db $37, $32, $F1, $37, $2B, $28, $90, $0D, $32, $32, $35, $90, $1C, $2B, $35, $2C
    db $31, $28, $B5, $F0

Data_024_76B6:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $36, $37, $24, $31, $37, $2F, $3C, $90, $3A, $24, $35, $33, $36, $90
    db $37, $32, $F1, $10, $35, $28, $24, $37, $15, $32, $2A, $B5, $F0

Data_024_76D3:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $36, $37, $24, $31, $37, $2F, $3C, $90, $3A, $24, $35, $33, $36, $90
    db $37, $32, $F1, $37, $2B, $28, $90, $28, $3B, $2C, $37, $B5, $F0

Data_024_76F0:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $31, $24, $25, $2F, $28, $36, $90, $36, $24, $39, $2C, $31, $2A, $90, $2C
    db $31, $F1, $37, $2B, $28, $90, $13, $32, $38, $35, $31, $24, $2F, $B5, $F0

Data_024_770F:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $32, $2F, $2F, $28, $26, $37, $90, $24, $31, $27, $90, $37, $35, $24, $27
    db $28, $F1, $29, $32, $35, $90, $35, $24, $35, $28, $90, $2A, $2C, $29, $37, $36
    db $B5, $F0

Data_024_7731:: ; heuristic: target of a monotone pointer table; C0
    db $10, $28, $37, $90, $24, $90, $01, $00, $9C, $33, $28, $35, $26, $28, $31, $37
    db $F1, $27, $2C, $36, $26, $32, $38, $31, $37, $90, $24, $37, $90, $36, $2B, $32
    db $33, $36, $B5, $F0

Data_024_7755:: ; heuristic: target of a monotone pointer table; C0
    db $16, $32, $39, $28, $36, $90, $37, $2B, $28, $90, $0D, $32, $32, $35, $F1, $1C
    db $2B, $35, $2C, $31, $28, $B5, $F0

Data_024_776C:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $39, $28, $24, $2F, $36, $90, $16, $2C, $35, $24, $2A, $28, $F1, $15
    db $24, $2E, $28, $B5, $F0

Data_024_7781:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $30, $24, $2A, $2C, $26, $90, $36, $37, $32, $31, $28, $90, $37, $2B
    db $24, $37, $F1, $35, $24, $2C, $36, $28, $36, $90, $37, $2B, $28, $90, $37, $2C
    db $27, $28, $B5, $F0

Data_024_77A5:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $30, $28, $27, $24, $2F, $90, $29, $35, $32, $30, $90, $37, $2B, $28
    db $F1, $28, $2F, $28, $30, $28, $31, $37, $24, $2F, $90, $36, $33, $2C, $35, $2C
    db $37, $B5, $F0

Data_024_77C8:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $90, $2F, $32, $36, $37, $90, $36, $32, $38, $2F, $90, $32, $29
    db $90, $24, $F1, $33, $35, $2C, $31, $26, $28, $36, $36, $B5, $F0

Data_024_77E5:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $25, $2F, $38, $28, $90, $29, $2F, $32, $3A, $28, $35, $90, $37, $2B
    db $24, $37, $F1, $2A, $35, $32, $3A, $36, $90, $2C, $31, $90, $36, $31, $32, $3A
    db $B5, $F0

Data_024_7807:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $35, $24, $31, $36, $29, $32, $35, $30, $36, $90, $38, $36, $28, $35, $36
    db $F1, $2C, $31, $37, $32, $90, $30, $32, $31, $36, $37, $28, $35, $36, $B5, $F0

Data_024_7827:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $38, $30, $30, $32, $31, $36, $90, $24, $90, $26, $2F, $24, $30, $90, $29
    db $32, $35, $F1, $26, $35, $32, $36, $36, $2C, $31, $2A, $90, $37, $2B, $28, $90
    db $36, $28, $24, $B5, $F0

Data_024_784C:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $36, $37, $35, $32, $3C, $36, $90, $3A, $2B, $24, $37, $90, $2C, $37
    db $F1, $35, $28, $29, $2F, $28, $26, $37, $36, $B5, $F0

Data_024_7867:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $38, $30, $30, $32, $31, $36, $90, $24, $90, $26, $2F, $32, $38, $27, $F1
    db $29, $32, $35, $90, $29, $2F, $3C, $2C, $31, $2A, $B5, $F0

Data_024_7883:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $2F, $28, $2A, $28, $31, $27, $24, $35, $3C, $90, $2B, $28, $2F, $30
    db $28, $37, $F1, $29, $32, $38, $31, $27, $90, $2C, $31, $90, $24, $90, $26, $24
    db $39, $28, $B5, $F0

Data_024_78A7:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $2F, $28, $2A, $28, $31, $27, $24, $35, $3C, $90, $24, $35, $30, $32
    db $35, $F1, $29, $32, $38, $31, $27, $90, $2C, $31, $90, $24, $90, $37, $32, $3A
    db $28, $35, $B5, $F0

Data_024_78CB:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $2F, $28, $2A, $28, $31, $27, $24, $35, $3C, $90, $36, $3A, $32, $35
    db $27, $F1, $29, $32, $38, $31, $27, $90, $2C, $31, $90, $24, $90, $26, $24, $36
    db $37, $2F, $28, $B5, $F0

Data_024_78F0:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $30, $24, $2A, $2C, $26, $24, $2F, $90, $36, $37, $32, $31, $28, $F1
    db $37, $2B, $24, $37, $90, $2A, $2F, $32, $3A, $36, $90, $25, $2F, $38, $28, $B5
    db $F0

Data_024_7911:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $90, $25, $28, $24, $38, $37, $2C, $29, $38, $2F, $90, $2A, $32, $2F, $27
    db $F1, $35, $2C, $31, $2A, $B5, $F0

Data_024_7928:: ; heuristic: target of a monotone pointer table; C0
    db $1E, $31, $27, $28, $29, $2C, $31, $28, $27, $B5, $F0

Data_024_7933:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $2C, $36, $28, $36, $90, $30, $24, $3B, $B5, $90, $11, $19, $F1, $25
    db $3C, $90, $03, $00, $B5, $F0

Data_024_7949:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $2C, $36, $28, $36, $90, $30, $24, $3B, $B5, $90, $11, $19, $F1, $25
    db $3C, $90, $08, $00, $B5, $F0

Data_024_795F:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $2C, $36, $28, $36, $90, $30, $24, $3B, $B5, $90, $16, $19, $F1, $25
    db $3C, $90, $03, $00, $B5, $F0

Data_024_7975:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $2C, $36, $28, $36, $90, $30, $24, $3B, $B5, $90, $16, $19, $F1, $25
    db $3C, $90, $08, $00, $B5, $F0

Data_024_798B:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $2C, $36, $28, $36, $90, $0A, $1D, $14, $90, $25, $3C, $90, $01, $00
    db $B5, $F0

Data_024_799D:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $2C, $36, $28, $36, $90, $0A, $1D, $14, $90, $25, $3C, $90, $05, $00
    db $B5, $F0

Data_024_79AF:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $2C, $36, $28, $36, $90, $0D, $0E, $0F, $90, $25, $3C, $90, $01, $00
    db $B5, $F0

Data_024_79C1:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $2C, $36, $28, $36, $90, $0D, $0E, $0F, $90, $25, $3C, $90, $05, $00
    db $B5, $F0

Data_024_79D3:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $2C, $36, $28, $36, $90, $0A, $10, $15, $90, $25, $3C, $90, $01, $00
    db $B5, $F0

Data_024_79E5:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $2C, $36, $28, $36, $90, $0A, $10, $15, $90, $25, $3C, $90, $05, $00
    db $B5, $F0

Data_024_79F7:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $2C, $36, $28, $36, $90, $12, $17, $1D, $90, $25, $3C, $90, $05, $00
    db $B5, $F0

Data_024_7A09:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $2C, $36, $28, $36, $90, $12, $17, $1D, $90, $25, $3C, $90, $01, $00
    db $00, $B5, $F0

Data_024_7A1C:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $2C, $36, $28, $36, $90, $35, $28, $36, $2C, $36, $37, $24, $31, $26
    db $28, $F1, $37, $32, $90, $24, $37, $37, $24, $26, $2E, $90, $36, $33, $28, $2F
    db $2F, $36, $B5, $F0

Data_024_7A40:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $2C, $36, $28, $36, $90, $35, $28, $36, $2C, $36, $37, $24, $31, $26
    db $28, $F1, $37, $32, $90, $29, $2C, $35, $28, $90, $24, $31, $27, $90, $2C, $26
    db $28, $B5, $F0

Data_024_7A63:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $36, $2C, $36, $37, $36, $90, $26, $32, $31, $29, $38, $36, $2C, $32
    db $31, $AB, $F1, $33, $32, $2C, $36, $32, $31, $90, $B6, $90, $36, $2F, $28, $28
    db $33, $B5, $F0

Data_024_7A86:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $36, $2C, $36, $37, $36, $90, $30, $32, $36, $37, $F1, $36, $37, $24
    db $37, $38, $36, $90, $36, $2E, $2C, $2F, $2F, $36, $B5, $F0

Data_024_7AA2:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $36, $2C, $36, $37, $36, $90, $26, $38, $35, $36, $28, $AB, $F1, $33
    db $24, $35, $24, $2F, $3C, $36, $2C, $36, $90, $B6, $90, $27, $28, $24, $37, $2B
    db $B5, $F0

Data_024_7AC4:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $2C, $36, $28, $36, $90, $35, $28, $36, $2C, $36, $37, $24, $31, $26
    db $28, $F1, $37, $32, $90, $3A, $24, $37, $28, $35, $90, $36, $2E, $2C, $2F, $2F
    db $36, $B5, $F0

Data_024_7AE7:: ; heuristic: target of a monotone pointer table; C0
    db $19, $35, $28, $39, $28, $31, $37, $36, $90, $36, $2E, $2C, $2F, $2F, $36, $F1
    db $29, $35, $32, $30, $90, $25, $28, $2C, $31, $2A, $90, $36, $28, $24, $2F, $28
    db $27, $B5, $F0

Data_024_7B0A:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $2C, $36, $28, $36, $90, $0D, $0E, $0F, $90, $25, $3C, $90, $05, $B5
    db $F0

Data_024_7B1B:: ; heuristic: target of a monotone pointer table; C0
    db $1E, $31, $27, $28, $29, $2C, $31, $28, $27, $B5, $F0

Data_024_7B26:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $36, $37, $32, $35, $28, $36, $90, $11, $19, $90, $25, $3C, $90, $01
    db $F1, $32, $31, $90, $28, $39, $28, $35, $3C, $90, $36, $37, $28, $33, $B5, $F0

Data_024_7B46:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $36, $37, $32, $35, $28, $36, $90, $16, $19, $90, $25, $3C, $90, $01
    db $F1, $32, $31, $90, $28, $39, $28, $35, $3C, $90, $36, $37, $28, $33, $B5, $F0

Data_024_7B66:: ; heuristic: target of a monotone pointer table; C0
    db $19, $35, $32, $30, $32, $37, $28, $36, $90, $30, $24, $3B, $B5, $90, $11, $19
    db $F1, $2A, $24, $2C, $31, $B5, $F0

Data_024_7B7D:: ; heuristic: target of a monotone pointer table; C0
    db $19, $35, $32, $30, $32, $37, $28, $36, $90, $30, $24, $3B, $B5, $F1, $16, $19
    db $90, $2A, $24, $2C, $31, $B5, $F0

Data_024_7B94:: ; heuristic: target of a monotone pointer table; C0
    db $19, $35, $32, $30, $32, $37, $28, $36, $90, $0A, $1D, $14, $90, $2A, $24, $2C
    db $31, $F1, $3A, $2B, $2C, $2F, $28, $90, $2A, $35, $32, $3A, $2C, $31, $2A, $B5
    db $F0

Data_024_7BB5:: ; heuristic: target of a monotone pointer table; C0
    db $19, $35, $32, $30, $32, $37, $28, $36, $90, $0D, $0E, $0F, $90, $2A, $24, $2C
    db $31, $F1, $3A, $2B, $2C, $2F, $28, $90, $2A, $35, $32, $3A, $2C, $31, $2A, $B5
    db $F0

Data_024_7BD6:: ; heuristic: target of a monotone pointer table; C0
    db $19, $35, $32, $30, $32, $37, $28, $36, $90, $0A, $10, $15, $90, $2A, $24, $2C
    db $31, $F1, $3A, $2B, $2C, $2F, $28, $90, $2A, $35, $32, $3A, $2C, $31, $2A, $B5
    db $F0

Data_024_7BF7:: ; heuristic: target of a monotone pointer table; C0
    db $19, $35, $32, $30, $32, $37, $28, $36, $90, $12, $17, $1D, $90, $2A, $24, $2C
    db $31, $F1, $3A, $2B, $2C, $2F, $28, $90, $2A, $35, $32, $3A, $2C, $31, $2A, $B5
    db $F0

Data_024_7C18:: ; heuristic: target of a monotone pointer table; C0
    db $1E, $31, $27, $28, $29, $2C, $31, $28, $27, $B5, $F0
    ds $3DD, $00
