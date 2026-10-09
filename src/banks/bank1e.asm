SECTION "Bank 1E", ROMX[$4000], BANK[$1E]
    db $1E

Func_01E_4001::
    ld a, [$D788]
    rst $00
    dw Jump_01E_400D
    dw Jump_01E_403F
    dw Jump_01E_4046
    dw Jump_01E_4062

Jump_01E_400D::
    ld hl, $C364
    ld de, $C198
    ld bc, $0104
    call Func_01E_7428
    ld a, [$C525]
    and a, a
    jr z, Jump_01E_402B
    ld hl, $D1CC
    ld de, $D000
    ld bc, $0104
    call Func_01E_7431

Jump_01E_402B::
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    ld a, [$D788]
    inc a
    ld [$D788], a
    ret

Jump_01E_403F::
    ld hl, Func_01E_4001
    ld b, $15
    rst $10
    ret

Jump_01E_4046::
    ld b, $46
    ld de, Func_01E_4001
    ld hl, $8800
    call Func_000_0CF5
    ld hl, $8D00
    ld bc, $0F01
    call Func_000_1881
    ld a, [$D788]
    inc a
    ld [$D788], a
    ret

Jump_01E_4062::
    ld hl, Func_01E_4001
    ld b, $15
    rst $10
    ret

Func_01E_4069::
    ld a, [$D780]
    rst $00
    dw Jump_01E_408B
    dw Jump_01E_40D1
    dw Jump_01E_412A
    dw Jump_01E_422D
    dw Jump_01E_4234
    dw Jump_01E_4C78
    dw Jump_01E_506C
    dw Jump_01E_568E
    dw Jump_01E_65B8
    dw Jump_01E_5B50
    dw Jump_01E_60F4
    dw Jump_01E_6298
    dw Jump_01E_600F
    dw Jump_01E_625A
    dw Jump_01E_5FAA

Jump_01E_408B::
    ld hl, $D780
    ld bc, $006F

Jump_01E_4091::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01E_4091
    ld hl, $C364
    ld de, $C198
    ld bc, $0104
    call Func_01E_7428
    ld a, [$C525]
    and a, a
    jr z, Jump_01E_40B6
    ld hl, $D1CC
    ld de, $D000
    ld bc, $0104
    call Func_01E_7431

Jump_01E_40B6::
    ld a, $03
    ld [$D7F0], a
    ld a, $70
    ldh [$FFBA], a
    xor a, a
    ld [$D7FC], a
    ld hl, $D780
    inc [hl]
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_40D1::
    ld a, [$D781]
    rst $00
    dw Jump_01E_40DD
    dw Jump_01E_40E4
    dw Jump_01E_40F2
    dw Jump_01E_4100

Jump_01E_40DD::
    ld hl, $6C8A
    ld b, $1D
    rst $10
    ret

Jump_01E_40E4::
    ld hl, Data_01E_778C
    ld de, Data_01E_77CE
    call Func_01E_7454
    ld hl, $D781
    inc [hl]
    ret

Jump_01E_40F2::
    ld hl, $5E79
    ld b, $1D
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_4100::
    ld de, Data_01E_79C8
    ld hl, $C364
    ld bc, $0B0B
    call Func_01E_748E
    call Func_01E_750F
    ld bc, $140B
    ld de, $01CC
    call Func_01E_74C8
    ld hl, $5E3F
    ld b, $1D
    rst $10
    xor a, a
    ld [$D781], a
    ld a, [$D780]
    inc a
    ld [$D780], a
    ret

Jump_01E_412A::
    ld a, [$C563]
    bit 6, a
    jr nz, Jump_01E_4146
    bit 7, a
    jr nz, Jump_01E_4174
    ld a, [$C562]
    bit 0, a
    jp nz, Jump_01E_418E
    bit 1, a
    jp nz, Jump_01E_41D0
    call Func_01E_41DF
    ret

Jump_01E_4146::
    call Func_01E_41FD
    ld a, [$D786]
    and a, a
    jr nz, Jump_01E_415D
    ld a, $04
    ld [$D786], a
    call Func_01E_41DF
    ld a, $69
    call Func_000_1278
    ret

Jump_01E_415D::
    dec a

Jump_01E_415E::
    ld [$D786], a
    xor a, a
    ld [$D7AB], a
    ld [$D7AD], a
    ld [$D7AF], a
    call Func_01E_41F9
    ld a, $69
    call Func_000_1278
    ret

Jump_01E_4174::
    call Func_01E_41FD
    ld a, [$D786]
    cp a, $04
    jr c, Jump_01E_418B
    xor a, a
    ld [$D786], a
    call Func_01E_41DF
    ld a, $69
    call Func_000_1278
    ret

Jump_01E_418B::
    inc a
    jr Jump_01E_415E

Jump_01E_418E::
    ld a, $69
    call Func_000_1278
    call Func_01E_4201
    ld c, $00

Jump_01E_4198::
    ld a, c
    ld b, $C3
    ld hl, Data_01E_7880
    push bc
    push hl
    call Func_01E_741A
    pop hl
    pop bc
    inc c
    ld a, c
    cp a, $05
    jr c, Jump_01E_4198
    ld a, [$D786]
    cp a, $04
    jr z, Jump_01E_41D0
    ld [$D7FA], a
    ld a, [$D780]
    inc a
    ld [$D780], a
    xor a, a
    ld [$D7AB], a
    ld [$D7AD], a
    ld [$D7AF], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_41D0::
    ld a, $04
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_01E_41DF::
    ld a, [$C564]
    cp a, $14
    jr c, Func_01E_41F9
    ld a, [$D787]
    inc a
    ld [$D787], a
    cp a, $10
    jr c, Func_01E_41F9
    cp a, $18
    jr c, Func_01E_41FD
    xor a, a
    ld [$D787], a

Func_01E_41F9::
    ld b, $BB
    jr Jump_01E_4203

Func_01E_41FD::
    ld b, $C3
    jr Jump_01E_4203

Func_01E_4201::
    ld b, $BC

Jump_01E_4203::
    ld a, [$D786]
    add a, a
    ld hl, Data_01E_4223
    add a, l
    ld l, a
    jr nc, Jump_01E_420F
    inc h

Jump_01E_420F::
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call Func_01E_750F
    pop de
    add hl, de
    call Func_000_24F8
    di
    call Func_000_120A
    ld a, b
    ld [hl], a
    ei
    ret

Data_01E_4223:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $21, $00, $61, $00, $A1, $00, $E1, $00, $21, $01

Jump_01E_422D::
    ld hl, $6B32
    ld b, $1D
    rst $10
    ret

Jump_01E_4234::
    ld a, [$D781]
    rst $00
    dw Jump_01E_429A
    dw Jump_01E_4371
    dw Jump_01E_439E
    dw Jump_01E_43C2
    dw Jump_01E_43E0
    dw Jump_01E_440A
    dw Jump_01E_4463
    dw Jump_01E_447F
    dw Jump_01E_4493
    dw Jump_01E_44A1
    dw Jump_01E_44B5
    dw Jump_01E_44C3
    dw Jump_01E_4517
    dw Func_01E_46E5
    dw Jump_01E_4720
    dw Jump_01E_473B
    dw Jump_01E_47B2
    dw Jump_01E_4831
    dw Jump_01E_4890
    dw Jump_01E_4933
    dw Jump_01E_49B2
    dw Func_01E_49EA
    dw Func_01E_4A32
    dw Jump_01E_4A39
    dw Jump_01E_439E
    dw Jump_01E_4A5E
    dw Jump_01E_43E0
    dw Jump_01E_4A74
    dw Jump_01E_4463
    dw Jump_01E_447F
    dw Jump_01E_4493
    dw Jump_01E_4933
    dw Jump_01E_4AE0
    dw Jump_01E_4AF1
    dw Jump_01E_4B05
    dw Jump_01E_44B5
    dw Jump_01E_44C3
    dw Jump_01E_4517
    dw Func_01E_46E5
    dw Jump_01E_4B42
    dw Jump_01E_4B5D
    dw Jump_01E_4BE1
    dw Jump_01E_4463
    dw Jump_01E_447F
    dw Jump_01E_4493
    dw Jump_01E_4933
    dw Jump_01E_4AE0
    dw Jump_01E_4AF1
    dw Jump_01E_4C42

Jump_01E_429A::
    ld a, [$D782]
    and a, a
    jp z, Jump_01E_42A9
    cp a, $01
    jp z, Func_01E_42C6
    jp Jump_01E_430D

Jump_01E_42A9::
    ld de, Data_01E_4333
    ld hl, $C364
    ld bc, $0807
    call Func_01E_748E
    ld hl, $8D00
    ld bc, $0F01
    call Func_000_1881
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Func_01E_42C6::
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld b, $00

Jump_01E_42D1::
    push bc
    ld hl, $C6FE
    ld a, b
    add a, l
    ld l, a
    jr nc, Jump_01E_42DB
    inc h

Jump_01E_42DB::
    ld a, [hl]
    ld b, a
    ld c, $01
    call Func_000_1FA4
    ld a, $F0
    ld [$C8D9], a
    pop bc
    push bc
    ld a, b
    add a, a
    ld hl, Data_01E_436B
    add a, l
    ld l, a
    jr nc, Jump_01E_42F3
    inc h

Jump_01E_42F3::
    ld e, [hl]
    inc hl
    ld d, [hl]
    call Func_000_21A1
    pop bc
    inc b
    ld a, [$C6FD]
    cp a, b
    jr nz, Jump_01E_42D1
    xor a, a
    ld [$1FFF], a
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_01E_430D::
    ld hl, $5E79
    ld b, $1D
    rst $10
    ld hl, $C378
    ld c, $28
    call Func_01E_7646
    call Func_01E_750F
    ld bc, $140B
    ld de, $01CC
    call Func_01E_74C8
    xor a, a
    ld [$D782], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Data_01E_4333:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $D0, $D1, $D2, $D3, $D4, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $D5, $D6, $D7, $D8, $D9, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $DA, $DB, $DC, $DD, $DE, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_01E_436B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $8D, $50, $8D, $A0, $8D

Jump_01E_4371::
    ld a, [$D7AB]
    ld hl, $D789
    add a, l
    ld l, a
    jr nc, Jump_01E_437C
    inc h

Jump_01E_437C::
    ld a, [hl]
    ld b, a
    push af
    call Func_01E_75C5
    ld de, Data_01E_795C
    ld hl, $C36C
    ld bc, $0C09
    call Func_01E_748E
    pop af
    ld b, a
    ld [$D7F1], a
    call Func_01E_75EB
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_439E::
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

Jump_01E_43C2::
    ld a, [$D7AB]
    ld hl, $D789
    add a, l
    ld l, a
    jr nc, Jump_01E_43CD
    inc h

Jump_01E_43CD::
    ld a, [hl]
    ld b, a
    ld [$D7F1], a
    ld hl, $5CD7
    ld b, $1D
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_43E0::
    ld a, [$D7AB]
    ld b, $BB
    ld hl, Data_01E_7880
    call Func_01E_741A
    call Func_01E_750F
    ld bc, $140B
    ld de, $01CC
    call Func_01E_74C8
    ld a, [$D7AB]
    ld b, $C3
    ld hl, Data_01E_7880
    call Func_01E_741A
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_440A::
    xor a, a
    ld [$D7F9], a
    ld hl, $65F6
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FD
    jr z, Jump_01E_4426
    cp a, $FE
    jr z, Jump_01E_442C
    cp a, $FF
    jr z, Jump_01E_4442
    ret

Jump_01E_4426::
    ld a, $01
    ld [$D781], a
    ret

Jump_01E_442C::
    ld a, $01
    ld [$D7FA], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_4442::
    ld a, [$D7AB]
    ld b, $BC
    ld hl, Data_01E_7880
    call Func_01E_741A
    xor a, a
    ld [$D7FA], a
    ld a, [$D781]
    add a, $05
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_4463::
    ld c, $0D
    ld hl, $01D4
    ld de, $0008
    xor a, a
    ld [$D7F1], a
    ld a, $0C
    ld [$D7F2], a
    call Func_01E_75F2
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_447F::
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_4493::
    ld hl, Data_01E_7810
    ld de, Data_01E_7824
    call Func_01E_7454
    ld hl, $D781
    inc [hl]
    ret

Jump_01E_44A1::
    ld a, $03
    ld [$D781], a
    ld a, $01
    ld [$D780], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_44B5::
    ld hl, Data_01E_7864
    ld de, Data_01E_7872
    call Func_01E_7454
    ld hl, $D781
    inc [hl]
    ret

Jump_01E_44C3::
    ld de, Func_01E_44EF
    ld hl, $C410
    ld bc, $0805
    call Func_01E_748E
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    ld a, $6C
    call Func_000_1278
    xor a, a
    ld [$D7AD], a
    ld [$D7AE], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_01E_44EF:: ; heuristic: follows a terminator; C0
    or a, b
    or a, c
    or a, c
    or a, c
    or a, c
    or a, c
    or a, c
    or a, d
    or a, [hl]
    jp Jump_01E_7170
    db $72, $73, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $74, $75
    db $C3, $C3, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Jump_01E_4517::
    ld a, [$C563]
    bit 6, a
    jr nz, Jump_01E_4533
    bit 7, a
    jr nz, Jump_01E_454D
    ld a, [$C562]
    bit 0, a
    jp nz, Jump_01E_455D
    bit 1, a
    jp nz, Jump_01E_4687
    call Func_01E_469D
    ret

Jump_01E_4533::
    call Func_01E_46BB
    ld a, [$D7AD]
    and a, a
    jr nz, Jump_01E_4540
    ld a, $01
    jr Jump_01E_4541

Jump_01E_4540::
    dec a

Jump_01E_4541::
    ld [$D7AD], a
    call Func_01E_46B7
    ld a, $69
    call Func_000_1278
    ret

Jump_01E_454D::
    call Func_01E_46BB
    ld a, [$D7AD]
    cp a, $01
    jr c, Jump_01E_455A
    xor a, a
    jr Jump_01E_4541

Jump_01E_455A::
    inc a
    jr Jump_01E_4541

Jump_01E_455D::
    ld a, $69
    call Func_000_1278
    call Func_01E_46BF
    ld a, [$D7AD]
    and a, a
    jp nz, Jump_01E_460F
    ld a, [$D780]
    cp a, $07
    jp z, Jump_01E_45EC
    cp a, $04
    jr z, Jump_01E_45B1
    cp a, $05
    jr z, Jump_01E_457C

Jump_01E_457C::
    ld a, [$D781]
    cp a, $13
    jr c, Jump_01E_45A3
    cp a, $42
    jr c, Jump_01E_4595
    ld a, $05
    ld [$D7B2], a
    ld a, $44
    ld [$D7B3], a
    ld a, $09
    jr Jump_01E_45D2

Jump_01E_4595::
    ld a, $05
    ld [$D7B2], a
    ld a, $2C
    ld [$D7B3], a
    ld a, $08
    jr Jump_01E_45D2

Jump_01E_45A3::
    ld a, $05
    ld [$D7B2], a
    ld a, $12
    ld [$D7B3], a
    ld a, $09
    jr Jump_01E_45D2

Jump_01E_45B1::
    ld a, [$D781]
    cp a, $10
    jr nc, Jump_01E_45C6
    ld a, $04
    ld [$D7B2], a
    ld a, $0C
    ld [$D7B3], a
    ld a, $08
    jr Jump_01E_45D2

Jump_01E_45C6::
    ld a, $04
    ld [$D7B2], a
    ld a, $25
    ld [$D7B3], a
    ld a, $09

Jump_01E_45D2::
    ld [$D780], a
    xor a, a
    ld [$D781], a
    ld [$D782], a
    ld [$D7FA], a
    call Func_01E_7745
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_45EC::
    ld a, [$D781]
    cp a, $16
    jr nz, Jump_01E_4601
    ld a, $07
    ld [$D7B2], a
    ld a, $16
    ld [$D7B3], a
    ld a, $0A
    jr Jump_01E_45D2

Jump_01E_4601::
    ld a, $07
    ld [$D7B2], a
    ld a, $2E
    ld [$D7B3], a
    ld a, $0B
    jr Jump_01E_45D2

Jump_01E_460F::
    ld a, [$D780]
    cp a, $07
    jr nz, Jump_01E_465C
    ld a, [$D7B7]
    and a, a
    jr nz, Jump_01E_4655
    ld a, [$D7AB]
    and a, a
    jr nz, Jump_01E_465C
    ld a, [$C6FD]
    cp a, $02
    jr nc, Jump_01E_465C
    ld hl, $5D84
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld a, [hl]
    ld b, a
    ld a, [$C6FE]
    cp a, b
    jr nz, Jump_01E_465C
    ld a, $03
    ld [$D7FA], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_4655::
    ld a, [$D781]
    inc a
    ld [$D781], a

Jump_01E_465C::
    ld a, [$D780]
    cp a, $04
    jr nz, Jump_01E_4670
    ld a, [$D781]
    cp a, $0C
    jr nz, Jump_01E_4670
    ld hl, $470B
    ld b, $02
    rst $10

Jump_01E_4670::
    ld a, $01
    ld [$D7FA], a
    ld a, [$D781]
    add a, $03
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_4687::
    ld a, $02
    ld [$D7FA], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_01E_469D::
    ld a, [$C564]
    cp a, $14
    jr c, Func_01E_46B7
    ld a, [$D7AE]
    inc a
    ld [$D7AE], a
    cp a, $10
    jr c, Func_01E_46B7
    cp a, $18
    jr c, Func_01E_46BB
    xor a, a
    ld [$D7AE], a

Func_01E_46B7::
    ld b, $BB
    jr Jump_01E_46C1

Func_01E_46BB::
    ld b, $C3
    jr Jump_01E_46C1

Func_01E_46BF::
    ld b, $BC

Jump_01E_46C1::
    ld a, [$D7AD]
    add a, a
    ld hl, Data_01E_46E1
    add a, l
    ld l, a
    jr nc, Jump_01E_46CD
    inc h

Jump_01E_46CD::
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call Func_01E_750F
    pop de
    add hl, de
    call Func_000_24F8
    di
    call Func_000_120A
    ld a, b
    ld [hl], a
    ei
    ret

Data_01E_46E1:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2D, $01, $6D, $01

Func_01E_46E5::
    ld de, Data_01E_4718
    ld hl, $C410
    ld bc, $0801
    call Func_01E_748E
    ld c, $04
    ld hl, $028C
    ld de, $00C0
    xor a, a
    ld [$D7F1], a
    ld a, $08
    ld [$D7F2], a
    call Func_01E_75F2
    ld a, [$D7AB]
    ld b, $C3
    ld hl, Data_01E_7880
    call Func_01E_741A
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Data_01E_4718:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Jump_01E_4720::
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    ld a, $05
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_473B::
    ld a, [$D7AB]
    ld hl, $D789
    add a, l
    ld l, a
    jr nc, Jump_01E_4746
    inc h

Jump_01E_4746::
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld a, $01
    ldh [$FFC6], a
    ld a, [hl]
    ld c, $00
    ld b, $01
    call Func_01E_76DA
    xor a, a
    ldh [$FFC6], a
    ld a, [hl]
    ld c, $55
    ld b, $01
    call Func_01E_76DA
    xor a, a
    ld [$1FFF], a
    ld a, [$C6FD]
    and a, a
    jr z, Jump_01E_4774
    dec a
    ld [$C6FD], a

Jump_01E_4774::
    ld hl, $5E79
    ld b, $1D
    rst $10
    ld hl, $D789
    ld de, $C6FE
    ld b, $03

Jump_01E_4782::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_01E_4782
    ld hl, $4AA8
    ld b, $04
    rst $10
    ld a, $7F
    ld [$C527], a
    call Func_01E_46E5
    ld a, $06
    ld [$D781], a
    xor a, a
    ld [$D7AB], a
    ld [$D7AD], a
    ld [$D7AC], a
    ld [$D7AE], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_47B2::
    ld hl, Func_01E_6D70
    ld b, $1D
    rst $10
    ld d, c
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld hl, $A000
    ld c, $00

Jump_01E_47C7::
    ld a, [hl]
    cp a, $01
    jr z, Jump_01E_47DA

Jump_01E_47CC::
    ld a, $A5
    add a, l
    ld l, a
    jr nc, Jump_01E_47D3
    inc h

Jump_01E_47D3::
    inc c
    ld a, c
    cp a, d
    jr c, Jump_01E_47C7
    jr Jump_01E_47EC

Jump_01E_47DA::
    push hl
    ld a, $6E
    add a, l
    ld l, a
    jr nc, Jump_01E_47E2
    inc h

Jump_01E_47E2::
    ld a, [hl]
    and a, a
    jr z, Jump_01E_47E9
    pop hl
    jr Jump_01E_47CC

Jump_01E_47E9::
    pop hl
    jr Jump_01E_4817

Jump_01E_47EC::
    xor a, a
    ld [$D7FA], a
    ld a, $01
    ld [$D780], a
    ld a, $03
    ld [$D781], a
    xor a, a
    ld [$D782], a
    xor a, a
    ld [$1FFF], a
    ld a, [$D786]
    ld b, $BC
    ld hl, Data_01E_7880
    call Func_01E_741A
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_4817::
    ld a, $01
    ld [$D7FA], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$1FFF], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_4831::
    ld de, Data_01F_4370
    ld hl, $8DF0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld a, $6C
    call Func_000_1278
    ld de, Data_01E_4872
    ld hl, $C412
    ld bc, $0605
    call Func_01E_748E
    ld a, [$D786]
    ld b, $BC
    ld hl, Data_01E_7880
    call Func_01E_741A
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$D7FA], a
    ret

Data_01E_4872:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $CE, $CF, $DF, $B7, $B6, $C3, $C3, $C3
    db $C3, $B7, $B6, $C3, $F3, $A6, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B5

Jump_01E_4890::
    ld hl, $6540
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_01E_48A4
    cp a, $FF
    jr z, Jump_01E_48C4
    ret

Jump_01E_48A4::
    call Func_01E_48E3
    ld a, $01
    ld [$D7FA], a
    ld a, $01
    ld [$D780], a
    ld a, $03
    ld [$D781], a
    xor a, a
    ld [$D782], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_48C4::
    ld a, [$D7FA]
    cp a, $01
    jr z, Jump_01E_48A4
    call Func_01E_48E3
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$D782], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_01E_48E3::
    ld hl, $C412
    ld de, $C246
    ld c, $05
    call Func_01E_4918
    ld a, [$C525]
    and a, a
    jr z, Jump_01E_490B
    ldh a, [$FF70]
    set 1, a
    ldh [$FF70], a
    ld hl, $D27A
    ld de, $D0AE
    ld c, $05
    call Func_01E_4918
    ldh a, [$FF70]
    res 1, a
    ldh [$FF70], a

Jump_01E_490B::
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    ret

Func_01E_4918::
    push bc
    push hl
    push de
    ld bc, $0006
    call Func_01E_7428
    pop de
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    ld a, $14
    add a, e
    ld e, a
    jr nc, Jump_01E_492F
    inc d

Jump_01E_492F::
    dec c
    jr nz, Func_01E_4918
    ret

Jump_01E_4933::
    ld de, Data_01E_495A
    ld hl, $C364
    ld bc, $080B
    call Func_01E_748E
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    xor a, a
    ld [$D7AF], a
    ld [$D7AE], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Data_01E_495A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $07895A, $58

Jump_01E_49B2::
    ld hl, $8A40
    ld bc, $0C01
    call Func_000_1881
    ld hl, $8D00
    ld bc, $0F01
    call Func_000_1881
    ld hl, $8F00
    ld bc, $0501
    call Func_000_1881
    ld hl, $8CE0
    ld bc, $0201
    call Func_000_1881
    ld de, Data_01E_7A41
    ld hl, $C364
    ld bc, $080B
    call Func_01E_748E
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_01E_49EA::
    ld hl, $5ECE
    ld b, $1D
    rst $10
    jr Func_01E_49F8

Jump_01E_49F2::
    ld hl, $5F2D
    ld b, $1D
    rst $10

Func_01E_49F8::
    call Func_01E_7163
    ld a, [$D7B0]
    cp a, $02
    jr c, Jump_01E_4A2A
    ld de, $0142
    call Func_01E_7530
    ld hl, $C42E
    call Func_01E_7556
    ld de, $0143
    ld a, d
    ld [$D7F1], a
    ld a, e
    ld [$D7F2], a
    call Func_01E_7564
    ld hl, $C42F
    ld a, h
    ld [$D7F1], a
    ld a, l
    ld [$D7F2], a
    call Func_01E_759A

Jump_01E_4A2A::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_01E_4A32::
    ld hl, $5C15
    ld b, $1F
    rst $10
    ret

Jump_01E_4A39::
    call Func_01E_76EB
    ld a, [hl]
    ld b, a
    push af
    call Func_01E_75C5
    ld de, Data_01E_795C
    ld hl, $C36C
    ld bc, $0C09
    call Func_01E_748E
    pop af
    ld b, a
    ld [$D7F1], a
    call Func_01E_75EB
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_4A5E::
    call Func_01E_76EB
    ld a, [hl]
    ld b, a
    ld [$D7F1], a
    ld hl, $5CD7
    ld b, $1D
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_4A74::
    xor a, a
    ld [$D7F9], a
    ld hl, $66B6
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_01E_4A98
    cp a, $FC
    jr z, Jump_01E_4A98
    cp a, $FD
    jr z, Jump_01E_4AD7
    cp a, $FE
    jr z, Jump_01E_4AA1
    cp a, $FF
    jr z, Jump_01E_4AA9
    ret

Jump_01E_4A98::
    ld a, [$D781]
    sub a, $07
    ld [$D781], a
    ret

Jump_01E_4AA1::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_4AA9::
    ld a, [$D781]
    add a, $08
    ld [$D781], a
    xor a, a
    ld [$D7FA], a
    ld a, [$D7AB]
    ld b, $BC
    ld hl, Data_01E_7880
    call Func_01E_741A
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_4AD7::
    ld a, [$D781]
    sub a, $04
    ld [$D781], a
    ret

Jump_01E_4AE0::
    ld hl, Data_01E_7838
    ld de, Data_01E_784E
    call Func_01E_7454
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_4AF1::
    ld hl, $62AD
    ld b, $1D
    rst $10
    ld hl, $5E79
    ld b, $1D
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_4B05::
    ld de, Data_01E_79C8
    ld hl, $C364
    ld bc, $0B0B
    call Func_01E_748E
    ld a, [$D786]
    ld b, $C3
    ld hl, Data_01E_7880
    call Func_01E_741A
    call Func_01E_750F
    ld bc, $140B
    ld de, $01CC
    call Func_01E_74C8
    ld hl, $5E3F
    ld b, $1D
    rst $10
    ld a, $11
    ld [$D781], a
    ld a, $01
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_4B42::
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    ld a, $1B
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_4B5D::
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld a, [$C6FE]
    ld c, $01
    call Func_000_1FA4
    ld a, $F0
    ld [$C8D9], a
    ld hl, $C8CF
    ld de, $C130
    ld c, $00

Jump_01E_4B7B::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_01E_4B89
    ld [de], a
    inc de
    inc hl
    inc c
    ld a, c
    cp a, $0A
    jr c, Jump_01E_4B7B

Jump_01E_4B89::
    ld a, $90
    ld [de], a
    inc de
    ld a, $3A
    ld [de], a
    inc de
    ld a, $2C
    ld [de], a
    inc de
    ld a, $37
    ld [de], a
    inc de
    ld a, $2B
    ld [de], a
    inc de
    ld a, $90
    ld [de], a
    inc de
    push de
    call Func_01E_76EB
    ld a, [hl]
    ld c, $01
    call Func_000_1FA4
    pop de
    ld a, $F0
    ld [$C8D9], a
    ld hl, $C8CF

Jump_01E_4BB4::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_01E_4BBE
    ld [de], a
    inc de
    inc hl
    jr Jump_01E_4BB4

Jump_01E_4BBE::
    ld [de], a
    xor a, a
    ld [$1FFF], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_4BE1::
    ld hl, $C6FE
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld a, $01
    ldh [$FFC6], a
    ld a, [hl]
    ld c, $00
    ld b, $01
    call Func_01E_76DA
    xor a, a
    ldh [$FFC6], a
    ld a, [hl]
    ld c, $55
    ld b, $01
    call Func_01E_76DA
    call Func_01E_76EB
    push hl
    ld a, $02
    ldh [$FFC6], a
    ld a, [hl]
    ld c, $00
    ld b, $01
    call Func_01E_76DA
    xor a, a
    ld [$1FFF], a
    pop hl
    ld a, [hl]
    ld [$C6FE], a
    ld hl, $5E79
    ld b, $1D
    rst $10
    ld hl, $4AA8
    ld b, $04
    rst $10
    ld a, $7F
    ld [$C527], a
    call Func_01E_46E5
    xor a, a
    ld [$D7AB], a
    ld [$D7AD], a
    ld [$D7AF], a
    ld [$D7AC], a
    ld [$D7AE], a
    ret

Jump_01E_4C42::
    ld de, Data_01E_79C8
    ld hl, $C364
    ld bc, $0B0B
    call Func_01E_748E
    call Func_01E_750F
    ld bc, $140B
    ld de, $01CC
    call Func_01E_74C8
    ld hl, $5E3F
    ld b, $1D
    rst $10
    xor a, a
    ld [$D781], a
    ld a, $02
    ld [$D780], a
    ld a, $01
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_4C78::
    ld a, [$D781]
    rst $00
    dw Jump_01E_4933
    dw Jump_01E_49B2
    dw Func_01E_49EA
    dw Func_01E_4A32
    dw Jump_01E_4A39
    dw Jump_01E_439E
    dw Jump_01E_4A5E
    dw Jump_01E_43E0
    dw Jump_01E_4A74
    dw Jump_01E_4463
    dw Jump_01E_447F
    dw Jump_01E_4493
    dw Jump_01E_4933
    dw Jump_01E_4AE0
    dw Jump_01E_4AF1
    dw Jump_01E_4C42
    dw Jump_01E_44B5
    dw Jump_01E_44C3
    dw Jump_01E_4517
    dw Func_01E_46E5
    dw Jump_01E_4D1C
    dw Jump_01E_4D37
    dw Jump_01E_4D5B
    dw Jump_01E_4463
    dw Jump_01E_447F
    dw Jump_01E_4493
    dw Jump_01E_4933
    dw Jump_01E_4AE0
    dw Jump_01E_4AF1
    dw Jump_01E_4C42
    dw Jump_01E_4831
    dw Jump_01E_4890
    dw Jump_01E_429A
    dw Jump_01E_4371
    dw Jump_01E_439E
    dw Jump_01E_43C2
    dw Jump_01E_43E0
    dw Jump_01E_4DB5
    dw Jump_01E_4463
    dw Jump_01E_447F
    dw Jump_01E_4493
    dw Jump_01E_4E0E
    dw Jump_01E_44B5
    dw Jump_01E_44C3
    dw Jump_01E_4517
    dw Func_01E_46E5
    dw Jump_01E_4E4B
    dw Jump_01E_4F9D
    dw Jump_01E_4E66
    dw Jump_01E_4933
    dw Jump_01E_49B2
    dw Func_01E_49EA
    dw Func_01E_4A32
    dw Jump_01E_4A39
    dw Jump_01E_439E
    dw Jump_01E_4A5E
    dw Jump_01E_43E0
    dw Jump_01E_4F31
    dw Jump_01E_4EA3
    dw Jump_01E_4EC3
    dw Jump_01E_4ED4
    dw Jump_01E_4FAC
    dw Jump_01E_4371
    dw Jump_01E_439E
    dw Jump_01E_43C2
    dw Jump_01E_4EFE
    dw Jump_01E_44B5
    dw Jump_01E_44C3
    dw Jump_01E_4517
    dw Func_01E_46E5
    dw Jump_01E_4FBB
    dw Jump_01E_4FD6
    dw Jump_01E_4FF7
    dw Jump_01E_4463
    dw Jump_01E_447F
    dw Jump_01E_4493
    dw Jump_01E_4933
    dw Jump_01E_4AE0
    dw Jump_01E_4AF1
    dw Jump_01E_4C42

Jump_01E_4D1C::
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    ld a, $08
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_4D37::
    ld hl, $470B
    ld b, $02
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_4D5B::
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    call Func_01E_76EB
    ld a, $02
    ldh [$FFC6], a
    ld a, [hl]
    ld c, $00
    ld b, $01
    call Func_01E_76DA
    ld a, [$C6FD]
    ld hl, $C6FE
    add a, l
    ld l, a
    jr nc, Jump_01E_4D7E
    inc h

Jump_01E_4D7E::
    push hl
    call Func_01E_76EB
    ld a, [hl]
    pop hl
    ld [hl], a
    ld a, [$C6FD]
    inc a
    ld [$C6FD], a
    xor a, a
    ld [$1FFF], a
    ld hl, $5E79
    ld b, $1D
    rst $10
    ld hl, $4AA8
    ld b, $04
    rst $10
    ld a, $7F
    ld [$C527], a
    call Func_01E_46E5
    xor a, a
    ld [$D7AB], a
    ld [$D7AD], a
    ld [$D7AF], a
    ld [$D7AC], a
    ld [$D7AE], a
    ret

Jump_01E_4DB5::
    xor a, a
    ld [$D7F9], a
    ld hl, $65F6
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FD
    jr z, Jump_01E_4DD1
    cp a, $FE
    jr z, Jump_01E_4DD7
    cp a, $FF
    jr z, Jump_01E_4DED
    ret

Jump_01E_4DD1::
    ld a, $21
    ld [$D781], a
    ret

Jump_01E_4DD7::
    ld a, $01
    ld [$D7FA], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_4DED::
    ld a, [$D7AB]
    ld b, $BC
    ld hl, Data_01E_7880
    call Func_01E_741A
    xor a, a
    ld [$D7FA], a
    ld a, [$D781]
    add a, $05
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_4E0E::
    ld de, Data_01E_79C8
    ld hl, $C364
    ld bc, $0B0B
    call Func_01E_748E
    ld a, [$D786]
    ld b, $BC
    ld hl, Data_01E_7880
    call Func_01E_741A
    call Func_01E_750F
    ld bc, $140B
    ld de, $01CC
    call Func_01E_74C8
    ld hl, $5E3F
    ld b, $1D
    rst $10
    ld a, $1E
    ld [$D781], a
    ld a, $01
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_4E4B::
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    ld a, $25
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_4E66::
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    ld a, [$D781]
    inc a
    ld [$D781], a
    ld a, [$D7AB]
    ld [$D7B5], a
    ld hl, $D789
    add a, l
    ld l, a
    jr nc, Jump_01E_4E87
    inc h

Jump_01E_4E87::
    ld a, [hl]
    ld [$D7B4], a
    xor a, a
    ld [$D7AB], a
    ld [$D7AF], a
    ld hl, $5ECE
    ld b, $1D
    rst $10
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret
    db $C9

Jump_01E_4EA3::
    ld de, Data_01E_7A99
    ld hl, $C364
    ld bc, $080B
    call Func_01E_748E
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_4EC3::
    ld hl, Data_01E_7838
    ld de, Data_01E_784E
    call Func_01E_7454
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_4ED4::
    ld de, Data_01E_7AF1
    ld hl, $C364
    ld bc, $080B
    call Func_01E_748E
    ld a, [$D7B5]
    ld [$D7AB], a
    xor a, a
    ld [$D7AF], a
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_4EFE::
    call Func_01E_750F
    ld bc, $140B
    ld de, $01CC
    call Func_01E_74C8
    ld a, $25
    ld [$D781], a
    ld a, $01
    ld [$D7FA], a
    ld hl, $5E79
    ld b, $1D
    rst $10
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_4F31::
    xor a, a
    ld [$D7F9], a
    ld hl, $66B6
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_01E_4F55
    cp a, $FC
    jr z, Jump_01E_4F55
    cp a, $FD
    jr z, Jump_01E_4F94
    cp a, $FE
    jr z, Jump_01E_4F5E
    cp a, $FF
    jr z, Jump_01E_4F66
    ret

Jump_01E_4F55::
    ld a, [$D781]
    sub a, $07
    ld [$D781], a
    ret

Jump_01E_4F5E::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_4F66::
    ld a, [$D781]
    add a, $09
    ld [$D781], a
    xor a, a
    ld [$D7FA], a
    ld a, [$D7AB]
    ld b, $BC
    ld hl, Data_01E_7880
    call Func_01E_741A
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_4F94::
    ld a, [$D781]
    sub a, $04
    ld [$D781], a
    ret

Jump_01E_4F9D::
    call Func_01E_46E5
    ld a, [$D7AB]
    ld b, $BC
    ld hl, Data_01E_7880
    call Func_01E_741A
    ret

Jump_01E_4FAC::
    ld a, [$D782]
    and a, a
    jp z, Jump_01E_42A9
    cp a, $01
    jp z, Func_01E_42C6
    jp Jump_01E_430D

Jump_01E_4FBB::
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    ld a, $39
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_4FD6::
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld a, [$D7B4]
    ld c, $01
    call Func_000_1FA4
    ld a, $F0
    ld [$C8D9], a
    ld hl, $C8CF
    ld de, $C130
    ld c, $00
    jp Jump_01E_4B7B

Jump_01E_4FF7::
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    call Func_01E_76EB
    ld a, $02
    ldh [$FFC6], a
    ld a, [hl]
    ld c, $00
    ld b, $01
    call Func_01E_76DA
    ld a, $01
    ldh [$FFC6], a
    ld a, [$D7B4]
    ld c, $00
    ld b, $01
    call Func_01E_76DA
    xor a, a
    ldh [$FFC6], a
    ld a, [$D7B4]
    ld c, $55
    ld b, $01
    call Func_01E_76DA
    ld a, [$D7B5]
    ld hl, $C6FE
    add a, l
    ld l, a
    jr nc, Jump_01E_5035
    inc h

Jump_01E_5035::
    push hl
    call Func_01E_76EB
    ld a, [hl]
    pop hl
    ld [hl], a
    xor a, a
    ld [$D7B5], a
    ld [$D7B4], a
    xor a, a
    ld [$1FFF], a
    ld hl, $5E79
    ld b, $1D
    rst $10
    ld hl, $4AA8
    ld b, $04
    rst $10
    ld a, $7F
    ld [$C527], a
    call Func_01E_46E5
    xor a, a
    ld [$D7AB], a
    ld [$D7AD], a
    ld [$D7AF], a
    ld [$D7AC], a
    ld [$D7AE], a
    ret

Jump_01E_506C::
    ld a, [$D781]
    rst $00
    dw Jump_01E_50AE
    dw Jump_01E_50BE
    dw Jump_01E_512E
    dw Jump_01E_51E6
    dw Jump_01E_4933
    dw Jump_01E_49B2
    dw Jump_01E_49F2
    dw Func_01E_4A32
    dw Jump_01E_525F
    dw Jump_01E_439E
    dw Jump_01E_4A5E
    dw Jump_01E_43E0
    dw Jump_01E_5290
    dw Jump_01E_5300
    dw Jump_01E_447F
    dw Jump_01E_4493
    dw Jump_01E_4933
    dw Jump_01E_4AE0
    dw Jump_01E_4AF1
    dw Jump_01E_536A
    dw Jump_01E_540F
    dw Jump_01E_5429
    dw Jump_01E_5430
    dw Jump_01E_54D6
    dw Jump_01E_5518
    dw Jump_01E_556A
    dw Jump_01E_557C
    dw Jump_01E_559E
    dw Jump_01E_5300
    dw Jump_01E_55F3
    dw Jump_01E_5654

Jump_01E_50AE::
    ld hl, Data_01E_793C
    ld de, Data_01E_791C
    call Func_01E_7454
    ld a, [$D781]
    inc a
    ld [$D781], a

Jump_01E_50BE::
    ld de, Data_01E_7BBE
    ld hl, $C40B
    ld bc, $0D05
    call Func_01E_748E
    ld a, $6C
    call Func_000_1278
    ld hl, $5F2D
    ld b, $1D
    rst $10
    ld a, [$D7A9]
    ld l, a
    ld h, $00
    call Func_000_16F5
    call Func_01E_75B3
    ld hl, $C429
    ld a, [$C8C1]
    add a, $E0
    ld [hl+], a
    ld a, [$C8C2]
    add a, $E0
    ld [hl], a
    ld a, [$D7B9]
    ld l, a
    ld h, $00
    call Func_000_16F5
    call Func_01E_75B3
    ld hl, $C451
    ld a, [$C8C1]
    add a, $E0
    ld [hl+], a
    ld a, [$C8C2]
    add a, $E0
    ld [hl], a
    ld a, [$D786]
    ld b, $BC
    ld hl, Data_01E_7880
    call Func_01E_741A
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    xor a, a
    ld [$D7B7], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_512E::
    ld hl, $642A
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FD
    ret z
    cp a, $FE
    jr z, Jump_01E_5145
    cp a, $FF
    jr z, Jump_01E_5162
    ret

Jump_01E_5145::
    ld a, $03
    ld [$D7FA], a
    xor a, a
    ld [$D7B7], a
    ld [$D7B8], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_5162::
    ld a, [$D7B7]
    and a, a
    jr nz, Jump_01E_5199
    call Func_01E_7778
    ld a, [$D7B7]
    ld b, $BC
    ld hl, Data_01E_788A
    call Func_01E_741A
    ld a, [$D781]
    add a, $02
    ld [$D781], a
    xor a, a
    ld [$D7FA], a
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_5199::
    ld a, [$D7B9]
    and a, a
    jr nz, Jump_01E_51AE
    ld a, $02
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_51AE::
    call Func_01E_7778
    ld a, [$D7B7]
    ld b, $BC
    ld hl, Data_01E_788A
    call Func_01E_741A
    ld a, $01
    ld [$D7FA], a
    ld a, [$D780]
    cp a, $07
    jr z, Jump_01E_51D7
    ld a, $15
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_51D7::
    ld a, $22
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_51E6::
    ld c, $05
    ld hl, $0273
    ld de, $00A7
    xor a, a
    ld [$D7F1], a
    ld a, $0D
    ld [$D7F2], a
    call Func_01E_75F2
    ld a, [$D786]
    ld b, $C3
    ld hl, Data_01E_7880
    call Func_01E_741A
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    ld de, Data_01F_4A70
    ld hl, $8FF0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4370
    ld hl, $8DF0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01E_79C8
    ld hl, $C364
    ld bc, $0B0B
    call Func_01E_748E
    call Func_01E_750F
    ld bc, $140B
    ld de, $01CC
    call Func_01E_74C8
    ld hl, $5E3F
    ld b, $1D
    rst $10
    xor a, a
    ld [$D781], a
    ld [$D782], a
    ld a, $02
    ld [$D780], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_525F::
    call Func_01E_76EB
    ld a, [hl]
    ld b, a
    call Func_01E_75C5
    ld de, Data_01E_795C
    ld hl, $C36C
    ld bc, $0C09
    call Func_01E_748E
    xor a, a
    ld [$D7F1], a
    ld hl, $6AA5
    ld b, $1D
    rst $10
    call Func_01E_76EB
    ld a, [hl]
    ld b, a
    ld [$D7F1], a
    call Func_01E_75EB
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_5290::
    xor a, a
    ld [$D7F9], a
    ld hl, $66B6
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_01E_52B4
    cp a, $FC
    jr z, Jump_01E_52B4
    cp a, $FD
    jr z, Jump_01E_52F7
    cp a, $FE
    jr z, Jump_01E_52BD
    cp a, $FF
    jr z, Jump_01E_52C9
    ret

Jump_01E_52B4::
    ld a, [$D781]
    sub a, $07
    ld [$D781], a
    ret

Jump_01E_52BD::
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$D7AB], a
    ret

Jump_01E_52C9::
    ld a, [$D781]
    add a, $08
    ld [$D781], a
    xor a, a
    ld [$D7FA], a
    ld a, [$D7AB]
    ld b, $BC
    ld hl, Data_01E_7880
    call Func_01E_741A
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_52F7::
    ld a, [$D781]
    sub a, $04
    ld [$D781], a
    ret

Jump_01E_5300::
    ld c, $09
    ld hl, $01D4
    ld de, $0008
    xor a, a
    ld [$D7F1], a
    ld a, $0C
    ld [$D7F2], a
    call Func_01E_75F2
    ld de, Data_01E_5343
    ld hl, $C40B
    ld bc, $0D03
    call Func_01E_748E
    ld a, [$D7A9]
    ld l, a
    ld h, $00
    call Func_000_16F5
    call Func_01E_75B3
    ld hl, $C429
    ld a, [$C8C1]
    add a, $E0
    ld [hl+], a
    ld a, [$C8C2]
    add a, $E0
    ld [hl], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Data_01E_5343:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $BC, $7C
    db $7D, $7E, $DF, $7F, $FE, $FF, $76, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $C3, $C3, $B7

Jump_01E_536A::
    ld de, Data_01E_79C8
    ld hl, $C364
    ld bc, $0B0B
    call Func_01E_748E
    ld a, [$D786]
    ld b, $BC
    ld hl, Data_01E_7880
    call Func_01E_741A
    call Func_01E_750F
    ld bc, $140B
    ld de, $01CC
    call Func_01E_74C8
    ld hl, $5E3F
    ld b, $1D
    rst $10
    ld de, Data_01E_7BBE
    ld hl, $C40B
    ld bc, $0D05
    call Func_01E_748E
    ld a, $6C
    call Func_000_1278
    ld hl, $5F2D
    ld b, $1D
    rst $10
    ld a, [$D7A9]
    ld l, a
    ld h, $00
    call Func_000_16F5
    call Func_01E_75B3
    ld hl, $C429
    ld a, [$C8C1]
    add a, $E0
    ld [hl+], a
    ld a, [$C8C2]
    add a, $E0
    ld [hl], a
    ld a, [$D7B9]
    ld l, a
    ld h, $00
    call Func_000_16F5
    call Func_01E_75B3
    ld hl, $C451
    ld a, [$C8C1]
    add a, $E0
    ld [hl+], a
    ld a, [$C8C2]
    add a, $E0
    ld [hl], a
    ld a, [$D786]
    ld b, $BC
    ld hl, Data_01E_7880
    call Func_01E_741A
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    xor a, a
    ld [$D7B7], a
    ld a, $02
    ld [$D781], a
    ld a, $01
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_540F::
    ld a, $06
    ld [$D7B2], a
    ld a, $0C
    ld [$D7B3], a
    xor a, a
    ld [$D781], a
    ld [$D782], a
    ld a, $0A
    ld [$D780], a
    call Func_01E_7745
    ret

Jump_01E_5429::
    ld hl, $6C9F
    ld b, $1D
    rst $10
    ret

Jump_01E_5430::
    ld de, Data_01E_5461
    ld hl, $C36B
    ld bc, $0D09
    call Func_01E_748E
    ld a, [$D7B7]
    ld b, $BC
    ld hl, Data_01E_788A
    call Func_01E_741A
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    ld hl, $6026
    ld b, $1D
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Data_01E_5461:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $079461, $75

Jump_01E_54D6::
    ld hl, $8BF0
    ld bc, $0401
    call Func_000_1881
    ld hl, $8C70
    ld bc, $0501
    call Func_000_1881
    ld hl, $8D00
    ld bc, $0F01
    call Func_000_1881
    ld hl, $8EA0
    ld bc, $0401
    call Func_000_1881
    ld hl, $8F50
    ld bc, $0801
    call Func_000_1881
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

Jump_01E_5518::
    ld de, Data_01E_7B49
    ld hl, $C36B
    ld bc, $0D09
    call Func_01E_748E
    call Func_01E_71E1
    ld a, [$D7B0]
    cp a, $02
    jr c, Jump_01E_5556
    ld de, $010E
    call Func_01E_7530
    ld hl, $C412
    call Func_01E_7556
    ld de, $010F
    ld a, d
    ld [$D7F1], a
    ld a, e
    ld [$D7F2], a
    call Func_01E_7564
    ld hl, $C413
    ld a, h
    ld [$D7F1], a
    ld a, l
    ld [$D7F2], a
    call Func_01E_759A

Jump_01E_5556::
    call Func_01E_750F
    ld bc, $1409
    ld de, $01CC
    call Func_01E_74C8
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_556A::
    xor a, a
    ld [$D7F5], a
    ld hl, $6088
    ld b, $1D
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_557C::
    ld de, Data_01F_4990
    ld hl, $8CE0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    xor a, a
    ld [$D7F1], a
    ld [$D7F2], a
    ld hl, $6320
    ld b, $1D
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_559E::
    ld a, $01
    ld [$D7F9], a
    ld hl, $66B6
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_01E_55C3
    cp a, $FC
    jr z, Jump_01E_55C3
    cp a, $FD
    jr z, Jump_01E_55CC
    cp a, $FE
    jr z, Jump_01E_55CD
    cp a, $FF
    jr z, Jump_01E_55D9
    ret

Jump_01E_55C3::
    ld a, [$D781]
    sub a, $04
    ld [$D781], a
    ret

Jump_01E_55CC::
    ret

Jump_01E_55CD::
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$D7AB], a
    ret

Jump_01E_55D9::
    ld a, $06
    ld [$D7B2], a
    ld a, $1B
    ld [$D7B3], a
    xor a, a
    ld [$D781], a
    ld [$D782], a
    ld a, $0B
    ld [$D780], a
    call Func_01E_7745
    ret

Jump_01E_55F3::
    ld de, Data_01E_7BFF
    ld hl, $C36B
    ld bc, $0408
    call Func_01E_748E
    call Func_01E_750F
    ld bc, $1409
    ld de, $01CC
    call Func_01E_74C8
    ld de, Data_01F_4290
    ld hl, $8CF0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4230
    ld hl, $8CE0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4120
    ld hl, $8F50
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4170
    ld hl, $8F60
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_41A0
    ld hl, $8F70
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_5654::
    ld a, $9E
    ld [$D7F1], a
    xor a, a
    ld [$D7F2], a
    ld de, $6DC4
    ld a, d
    ld [$D7F3], a
    ld a, e
    ld [$D7F4], a
    ld hl, $6C14
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    cp a, $FF
    ret nz
    ld a, [$D7B7]
    ld b, $C3
    ld hl, Data_01E_788A
    call Func_01E_741A
    ld a, $02
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_568E::
    ld a, [$D781]
    rst $00
    dw Jump_01E_50AE
    dw Jump_01E_50BE
    dw Jump_01E_5708
    dw Jump_01E_51E6
    dw Jump_01E_4933
    dw Jump_01E_49B2
    dw Jump_01E_49F2
    dw Func_01E_4A32
    dw Jump_01E_525F
    dw Jump_01E_439E
    dw Jump_01E_4A5E
    dw Jump_01E_43E0
    dw Jump_01E_5290
    dw Jump_01E_5300
    dw Jump_01E_447F
    dw Jump_01E_4493
    dw Jump_01E_4933
    dw Jump_01E_4AE0
    dw Jump_01E_4AF1
    dw Jump_01E_536A
    dw Jump_01E_44B5
    dw Jump_01E_44C3
    dw Jump_01E_4517
    dw Jump_01E_5774
    dw Jump_01E_57EB
    dw Jump_01E_581C
    dw Jump_01E_586E
    dw Jump_01E_4463
    dw Jump_01E_447F
    dw Jump_01E_4493
    dw Jump_01E_4933
    dw Jump_01E_4AE0
    dw Jump_01E_4AF1
    dw Jump_01E_4C42
    dw Jump_01E_5429
    dw Jump_01E_5430
    dw Jump_01E_54D6
    dw Jump_01E_5518
    dw Jump_01E_556A
    dw Jump_01E_557C
    dw Jump_01E_58B0
    dw Jump_01E_5300
    dw Jump_01E_55F3
    dw Jump_01E_5654
    dw Jump_01E_44B5
    dw Jump_01E_44C3
    dw Jump_01E_4517
    dw Jump_01E_592B
    dw Jump_01E_5994
    dw Jump_01E_59D4
    dw Jump_01E_5A05
    dw Jump_01E_5A16
    dw Jump_01E_4463
    dw Jump_01E_5B06
    dw Jump_01E_5A88
    dw Jump_01E_5AB0
    dw Jump_01E_4493
    dw Jump_01E_4AF1
    dw Jump_01E_5B32

Jump_01E_5708::
    ld hl, $642A
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FD
    ret z
    cp a, $FE
    jp z, Jump_01E_5145
    cp a, $FF
    jr z, Jump_01E_5720
    ret

Jump_01E_5720::
    ld a, [$D7B7]
    and a, a
    jp nz, Jump_01E_5199
    ld hl, $5F2D
    ld b, $1D
    rst $10
    ld a, [$D7A9]
    cp a, $02
    jr nc, Jump_01E_5743
    ld a, $04
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_5743::
    ld a, [$D781]
    add a, $02
    ld [$D781], a
    xor a, a
    ld [$D7FA], a
    call Func_01E_7778
    ld a, [$D7B7]
    ld b, $BC
    ld hl, Data_01E_788A
    call Func_01E_741A
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_5774::
    ld de, Data_01E_7BBE
    ld hl, $C40B
    ld bc, $0D05
    call Func_01E_748E
    ld de, Data_01E_57DC
    ld hl, $C40B
    ld bc, $0D01
    call Func_01E_748E
    ld de, Data_01E_57E9
    ld hl, $C41F
    ld bc, $0102
    call Func_01E_748E
    ld hl, $5F2D
    ld b, $1D
    rst $10
    ld a, [$D7A9]
    ld l, a
    ld h, $00
    call Func_000_16F5
    call Func_01E_75B3
    ld hl, $C429
    ld a, [$C8C1]
    add a, $E0
    ld [hl+], a
    ld a, [$C8C2]
    add a, $E0
    ld [hl], a
    ld a, [$D7B9]
    ld l, a
    ld h, $00
    call Func_000_16F5
    call Func_01E_75B3
    ld hl, $C451
    ld a, [$C8C1]
    add a, $E0
    ld [hl+], a
    ld a, [$C8C2]
    add a, $E0
    ld [hl], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Data_01E_57DC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B7, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_01E_57E9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B7, $B5

Jump_01E_57EB::
    ld a, [$D7AB]
    ld b, $C3
    ld hl, Data_01E_7880
    call Func_01E_741A
    ld a, [$D7B7]
    ld b, $BC
    ld hl, Data_01E_788A
    call Func_01E_741A
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    ld a, $0C
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_581C::
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    call Func_01E_76EB
    ld a, [hl]
    ld c, $01
    call Func_000_1FA4
    ld a, $F0
    ld [$C8D9], a
    ld hl, $C8CF
    ld de, $C130
    ld c, $00

Jump_01E_583B::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_01E_5849
    ld [de], a
    inc de
    inc hl
    inc c
    ld a, c
    cp a, $0A
    jr c, Jump_01E_583B

Jump_01E_5849::
    ld a, $F0
    ld [de], a
    xor a, a
    ld [$1FFF], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_586E::
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    call Func_01E_76EB
    ld a, [hl]
    ld [$D7F1], a
    xor a, a
    ld [$1FFF], a
    ld [$D7F2], a
    ld hl, Data_01E_7E96
    ld b, $14
    rst $10
    ld hl, $5E79
    ld b, $1D
    rst $10
    ld hl, $4AA8
    ld b, $04
    rst $10
    ld a, $7F
    ld [$C527], a
    call Func_01E_5A4D
    xor a, a
    ld [$D7AB], a
    ld [$D7AD], a
    ld [$D7AF], a
    ld [$D7AC], a
    ld [$D7AE], a
    ret

Jump_01E_58B0::
    ld a, $01
    ld [$D7F9], a
    ld hl, $66B6
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_01E_58D5
    cp a, $FC
    jr z, Jump_01E_58D5
    cp a, $FD
    jr z, Jump_01E_58DE
    cp a, $FE
    jr z, Jump_01E_58DF
    cp a, $FF
    jr z, Jump_01E_58FD
    ret

Jump_01E_58D5::
    ld a, [$D781]
    sub a, $04
    ld [$D781], a
    ret

Jump_01E_58DE::
    ret

Jump_01E_58DF::
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$D7AB], a
    ld a, $01
    ld [$D7FA], a
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ret

Jump_01E_58FD::
    xor a, a
    ld [$D7FA], a
    ld a, [$D781]
    add a, $04
    ld [$D781], a
    ld a, [$D7AB]
    ld b, $BC
    ld hl, Data_01E_788E
    call Func_01E_741A
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_592B::
    ld de, Data_01E_7BBE
    ld hl, $C40B
    ld bc, $0D05
    call Func_01E_748E
    ld de, Data_01E_5987
    ld hl, $C40B
    ld bc, $0D01
    call Func_01E_748E
    ld hl, $5F2D
    ld b, $1D
    rst $10
    ld a, [$D7A9]
    ld l, a
    ld h, $00
    call Func_000_16F5
    call Func_01E_75B3
    ld hl, $C429
    ld a, [$C8C1]
    add a, $E0
    ld [hl+], a
    ld a, [$C8C2]
    add a, $E0
    ld [hl], a
    ld a, [$D7B9]
    ld l, a
    ld h, $00
    call Func_000_16F5
    call Func_01E_75B3
    ld hl, $C451
    ld a, [$C8C1]
    add a, $E0
    ld [hl+], a
    ld a, [$C8C2]
    add a, $E0
    ld [hl], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Data_01E_5987:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Jump_01E_5994::
    ld hl, $6026
    ld b, $1D
    rst $10
    call Func_01E_71E1
    ld a, [$D7B0]
    cp a, $02
    jr c, Jump_01E_59CC
    ld de, $010E
    call Func_01E_7530
    ld hl, $C412
    call Func_01E_7556
    ld de, $010F
    ld a, d
    ld [$D7F1], a
    ld a, e
    ld [$D7F2], a
    call Func_01E_7564
    ld hl, $C413
    ld a, h
    ld [$D7F1], a
    ld a, l
    ld [$D7F2], a
    call Func_01E_759A

Jump_01E_59CC::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_59D4::
    ld a, [$D7AB]
    ld b, $C3
    ld hl, Data_01E_788E
    call Func_01E_741A
    ld a, [$D7B7]
    ld b, $BC
    ld hl, Data_01E_788A
    call Func_01E_741A
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    ld a, $28
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_5A05::
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_5A16::
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    call Func_01E_76F3
    ld a, [hl]
    ld [$D7F1], a
    xor a, a
    ld [$1FFF], a
    ld [$D7F2], a
    ld hl, Data_01E_7E96
    ld b, $14
    rst $10
    ld hl, $5E79
    ld b, $1D
    rst $10
    call Func_01E_5A4D
    xor a, a
    ld [$D7AB], a
    ld [$D7AD], a
    ld [$D7AF], a
    ld [$D7AC], a
    ld [$D7AE], a
    ret

Func_01E_5A4D::
    ld de, Data_01E_5A80
    ld hl, $C410
    ld bc, $0801
    call Func_01E_748E
    ld c, $05
    ld hl, $0287
    ld de, $00BB
    xor a, a
    ld [$D7F1], a
    ld a, $0D
    ld [$D7F2], a
    call Func_01E_75F2
    ld a, [$D7AB]
    ld b, $C3
    ld hl, Data_01E_7880
    call Func_01E_741A
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Data_01E_5A80:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Jump_01E_5A88::
    ld a, $9E
    ld [$D7F1], a
    xor a, a
    ld [$D7F2], a
    ld de, $6DC4
    ld a, d
    ld [$D7F3], a
    ld a, e
    ld [$D7F4], a
    ld hl, $6C14
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    cp a, $FF
    ret nz
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_5AB0::
    ld de, Data_01F_4370
    ld hl, $8DF0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4290
    ld hl, $8CF0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4230
    ld hl, $8CE0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4120
    ld hl, $8F50
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4170
    ld hl, $8F60
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_41A0
    ld hl, $8F70
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_5B06::
    ld de, Data_01E_7BFF
    ld hl, $C36B
    ld bc, $0408
    call Func_01E_748E
    ld de, Data_01E_7C1F
    ld hl, $C40B
    ld bc, $0403
    call Func_01E_748E
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_5B32::
    ld hl, $5E3F
    ld b, $1D
    rst $10
    xor a, a
    ld [$D781], a
    ld a, $02
    ld [$D780], a
    ld a, $01
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_5B50::
    ld a, [$D781]
    rst $00
    dw Func_01E_65FE
    dw Jump_01E_6635
    dw Jump_01E_6646
    dw Jump_01E_5B96
    dw Func_01E_667C
    dw Jump_01E_669D
    dw Jump_01E_5BD0
    dw Func_01E_65FE
    dw Jump_01E_679E
    dw Jump_01E_67B1
    dw Func_01E_6810
    dw Jump_01E_6840
    dw Jump_01E_685A
    dw Jump_01E_5C85
    dw Jump_01E_68D3
    dw Jump_01E_6840
    dw Jump_01E_685A
    dw Jump_01E_68E4
    dw Jump_01E_6907
    dw Jump_01E_6920
    dw Jump_01E_694D
    dw Jump_01E_5D1F
    dw Jump_01E_6A57
    dw Jump_01E_5E98
    dw Jump_01E_5ED6
    dw Jump_01E_6A70
    dw Jump_01E_6B10
    dw Jump_01E_5DC5
    dw Jump_01E_6BC6
    dw Jump_01E_6C1F
    dw Jump_01E_6C69
    dw Jump_01E_6C97
    dw Jump_01E_5F1D

Jump_01E_5B96::
    call Func_01E_750F
    ld de, $6717
    ld a, $14
    ld [$D7F3], a
    ld a, $12
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    call Func_01E_6D2B
    ld a, [$D7B0]
    cp a, $02
    jr c, Jump_01E_5BC8
    ld de, $0142
    call Func_01E_7530
    ld de, $0143
    ld a, d
    ld [$D7F1], a
    ld a, e
    ld [$D7F2], a
    call Func_01E_7564

Jump_01E_5BC8::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_5BD0::
    ld a, [$D782]
    rst $00
    dw Jump_01E_5BDC
    dw Func_01E_5C37
    dw Func_01E_5C63
    dw Jump_01E_5C78

Jump_01E_5BDC::
    xor a, a
    ld [$D7F9], a
    ld hl, $66B6
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_01E_5C00
    cp a, $FC
    jr z, Jump_01E_5C00
    cp a, $FD
    jr z, Jump_01E_5C08
    cp a, $FE
    jr z, Jump_01E_5C0E
    cp a, $FF
    jr z, Jump_01E_5C16
    ret

Jump_01E_5C00::
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_01E_5C08::
    ld a, $04
    ld [$D781], a
    ret

Jump_01E_5C0E::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_5C16::
    call Func_01E_750F
    ld de, $0161
    add hl, de
    ld de, $651B
    ld a, $06
    ld [$D7F3], a
    ld a, $06
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    call Func_01E_6D2B
    ld a, $0E
    ld [$D781], a
    ret

Func_01E_5C37::
    ld hl, $8A40
    ld bc, $0C01
    call Func_000_1881
    ld hl, $8D00
    ld bc, $0F01
    call Func_000_1881
    ld hl, $8F00
    ld bc, $0501
    call Func_000_1881
    ld hl, $8CE0
    ld bc, $0201
    call Func_000_1881
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Func_01E_5C63::
    call Func_01E_7163
    call Func_01E_4A32
    ld a, [$D781]
    dec a
    ld [$D781], a
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_01E_5C78::
    call Func_01E_49EA
    ld a, $04
    ld [$D781], a
    xor a, a
    ld [$D782], a
    ret

Jump_01E_5C85::
    ld hl, $4AA8
    ld b, $04
    rst $10
    ld a, $7F
    ld [$C527], a
    ld c, $05
    ld hl, Data_01E_7880
    call Func_01E_7406
    ld a, [$D7FE]
    cp a, $1F
    jr z, Jump_01E_5CB3
    ld a, [$D7B2]
    cp a, $04
    jr z, Jump_01E_5CCA
    cp a, $05
    jr nz, Jump_01E_5CD5
    ld a, [$D7B3]
    cp a, $2F
    jr c, Jump_01E_5CD5
    jr Jump_01E_5CCA

Jump_01E_5CB3::
    ld a, [$D780]
    cp a, $0A
    jr nz, Jump_01E_5CCA
    ld a, [$D7B2]
    cp a, $06
    jr z, Jump_01E_5CD5
    ld a, [$C920]
    cp a, $E8
    jr z, Jump_01E_5CCA
    jr Jump_01E_5CD5

Jump_01E_5CCA::
    ld a, [$D7AB]
    ld b, $BC
    ld hl, Data_01E_7880
    call Func_01E_741A

Jump_01E_5CD5::
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    call Func_01E_750F
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call Func_01E_74C8
    call Func_01E_7763
    ld a, $70
    ldh [$FFBA], a
    xor a, a
    ld [$D782], a
    ld a, [$D7B2]
    ld [$D780], a
    ld a, [$D7B3]
    ld [$D781], a
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_5D1F::
    ld a, [$D782]
    rst $00
    dw Jump_01E_5D2B
    dw Func_01E_5C37
    dw Func_01E_5C63
    dw Jump_01E_5DBD

Jump_01E_5D2B::
    ld a, [$C5DB]
    cp a, $05
    jr z, Jump_01E_5D38
    ld hl, $5C35
    ld b, $1D
    rst $10

Jump_01E_5D38::
    xor a, a
    ld [$D7F9], a
    ld hl, $66B6
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_01E_5D5C
    cp a, $FC
    jr z, Jump_01E_5D5C
    cp a, $FD
    jr z, Jump_01E_5D67
    cp a, $FE
    jr z, Jump_01E_5D7E
    cp a, $FF
    jr z, Jump_01E_5D72
    ret

Jump_01E_5D5C::
    xor a, a
    ldh [$FFBA], a
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_01E_5D67::
    xor a, a
    ldh [$FFBA], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_5D72::
    xor a, a
    ldh [$FFBA], a
    ld a, [$D781]
    inc a
    inc a
    ld [$D781], a
    ret

Jump_01E_5D7E::
    xor a, a
    ldh [$FFBA], a
    call Func_01E_750F
    ld de, $0068
    add hl, de
    ld de, $662B
    ld a, $0C
    ld [$D7F3], a
    ld a, $0F
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    call Func_01E_6D2B
    call Func_01E_750F
    ld de, $0160
    add hl, de
    ld de, $653F
    ld a, $08
    ld [$D7F3], a
    ld a, $07
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    call Func_01E_6D2B
    ld a, $04
    ld [$D781], a
    ret

Jump_01E_5DBD::
    call Func_01E_49EA
    xor a, a
    ld [$D782], a
    ret

Jump_01E_5DC5::
    ld a, [$D782]
    rst $00
    dw Jump_01E_5DD1
    dw Func_01E_5C37
    dw Func_01E_5C63
    dw Jump_01E_5E88

Jump_01E_5DD1::
    xor a, a
    ld [$D7F9], a
    ld hl, $66B6
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_01E_5DF5
    cp a, $FC
    jr z, Jump_01E_5DF5
    cp a, $FD
    jr z, Jump_01E_5DFD
    cp a, $FE
    jr z, Jump_01E_5E06
    cp a, $FF
    jr z, Jump_01E_5E17
    ret

Jump_01E_5DF5::
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_01E_5DFD::
    ld a, [$D781]
    sub a, $02
    ld [$D781], a
    ret

Jump_01E_5E06::
    ld hl, $9200
    ld bc, $1504
    call Func_000_1881
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_5E17::
    ld hl, $9730
    ld de, Data_01F_42D0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld hl, $6D07
    ld b, $1D
    rst $10
    call Func_01E_750F
    ld de, $0160
    add hl, de
    ld de, $6E47
    ld a, $08
    ld [$D7F3], a
    ld a, $07
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    call Func_01E_6D2B
    ld hl, $96C0
    ld bc, $0201
    call Func_000_1881
    call Func_01E_750F
    ld de, $0008
    add hl, de
    ld de, $6D6F
    ld a, $0C
    ld [$D7F3], a
    ld a, $12
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    call Func_01E_6D2B
    ld hl, $9200
    ld bc, $0805
    call Func_000_1881
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, [$D781]
    add a, $03
    ld [$D781], a
    ret

Jump_01E_5E88::
    call Func_01E_49EA
    ld a, [$D781]
    sub a, $04
    ld [$D781], a
    xor a, a
    ld [$D782], a
    ret

Jump_01E_5E98::
    call Func_01E_750F
    ld de, $0008
    add hl, de
    ld de, $6B4F
    ld a, $0C
    ld [$D7F3], a
    ld a, $12
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    call Func_01E_6D2B
    call Func_01E_750F
    ld de, $0160
    add hl, de
    ld de, $6C27
    ld a, $08
    ld [$D7F3], a
    ld a, $07
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    call Func_01E_6D2B
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_5ED6::
    ld hl, $9200
    ld bc, $1504
    call Func_000_1881
    call Func_01E_750F
    ld de, $0008
    add hl, de
    ld de, $6C5F
    ld a, $0C
    ld [$D7F3], a
    ld a, $12
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    call Func_01E_6D2B
    call Func_01E_750F
    ld de, $0160
    add hl, de
    ld de, $6D37
    ld a, $08
    ld [$D7F3], a
    ld a, $07
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    call Func_01E_6D2B
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_5F1D::
    ld a, [$D782]
    rst $00
    dw Jump_01E_5F29
    dw Func_01E_5C37
    dw Func_01E_5C63
    dw Jump_01E_5F99

Jump_01E_5F29::
    xor a, a
    ld [$D7F9], a
    ld hl, $66B6
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    jr z, Jump_01E_5F4D
    cp a, $FB
    jr z, Jump_01E_5F5A
    cp a, $FC
    jr z, Jump_01E_5F5A
    cp a, $FD
    jr z, Jump_01E_5F65
    cp a, $FE
    jr z, Jump_01E_5F87
    cp a, $FF
    jr z, Jump_01E_5F90

Jump_01E_5F4D::
    ld a, [$C5DB]
    cp a, $05
    ret z
    ld hl, $5BF2
    ld b, $1D
    rst $10
    ret

Jump_01E_5F5A::
    xor a, a
    ldh [$FFBA], a
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_01E_5F65::
    xor a, a
    ldh [$FFBA], a
    ld a, [$D781]
    dec a
    dec a
    ld [$D781], a
    ld hl, $9200
    ld bc, $0805
    call Func_000_1881
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ret

Jump_01E_5F87::
    xor a, a
    ldh [$FFBA], a
    ld a, $17
    ld [$D781], a
    ret

Jump_01E_5F90::
    xor a, a
    ldh [$FFBA], a
    ld a, $07
    ld [$D781], a
    ret

Jump_01E_5F99::
    call Func_01E_49EA
    ld a, [$D781]
    dec a
    ld [$D781], a
    xor a, a
    ld [$D782], a
    jp Jump_01E_5F65

Jump_01E_5FAA::
    ld a, [$D781]
    rst $00
    dw Jump_01E_61B4
    dw Jump_01E_6055
    dw Jump_01E_6646
    dw Jump_01E_5FF0
    dw Jump_01E_616A
    dw Jump_01E_669D
    dw Jump_01E_6183
    dw Jump_01E_60E1
    dw Jump_01E_60EC
    dw Jump_01E_60EC
    dw Jump_01E_619F
    dw Jump_01E_6840
    dw Jump_01E_685A
    dw Jump_01E_5C85
    dw Jump_01E_68D3
    dw Jump_01E_6840
    dw Jump_01E_685A
    dw Jump_01E_68E4
    dw Jump_01E_6907
    dw Jump_01E_6920
    dw Jump_01E_694D
    dw Jump_01E_61C5
    dw Jump_01E_6A57
    dw Jump_01E_5E98
    dw Jump_01E_5ED6
    dw Jump_01E_6A70
    dw Jump_01E_6B10
    dw Jump_01E_61F1
    dw Jump_01E_6BC6
    dw Jump_01E_6C1F
    dw Jump_01E_6C69
    dw Jump_01E_6C97
    dw Jump_01E_6225

Jump_01E_5FF0::
    call Func_01E_750F
    ld de, $69E7
    ld a, $14
    ld [$D7F3], a
    ld a, $12
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    call Func_01E_6D2B
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_600F::
    ld a, [$D781]
    rst $00
    dw Jump_01E_61B4
    dw Jump_01E_6055
    dw Jump_01E_6646
    dw Jump_01E_5B96
    dw Jump_01E_616A
    dw Jump_01E_669D
    dw Jump_01E_6183
    dw Jump_01E_60E1
    dw Jump_01E_60EC
    dw Jump_01E_60EC
    dw Jump_01E_619F
    dw Jump_01E_6840
    dw Jump_01E_685A
    dw Jump_01E_5C85
    dw Jump_01E_68D3
    dw Jump_01E_6840
    dw Jump_01E_685A
    dw Jump_01E_68E4
    dw Jump_01E_6907
    dw Jump_01E_6920
    dw Jump_01E_694D
    dw Jump_01E_61C5
    dw Jump_01E_6A57
    dw Jump_01E_5E98
    dw Jump_01E_5ED6
    dw Jump_01E_6A70
    dw Jump_01E_6B10
    dw Jump_01E_61F1
    dw Jump_01E_6BC6
    dw Jump_01E_6C1F
    dw Jump_01E_6C69
    dw Jump_01E_6C97
    dw Jump_01E_6225

Jump_01E_6055::
    ld hl, Data_01E_7898
    ld de, Data_01E_78DA
    call Func_01E_7454
    call Func_01E_6074
    call Func_01E_5C37
    call Func_01E_5C63
    call Func_01E_49F8
    xor a, a
    ld [$D782], a
    ld a, $02
    ld [$D781], a
    ret

Func_01E_6074::
    ld c, $00
    ld b, $10

Jump_01E_6078::
    push bc
    ld a, c
    ld de, Data_01E_60B1
    add a, e
    ld e, a
    jr nc, Jump_01E_6082
    inc d

Jump_01E_6082::
    ld a, [de]
    swap a
    ld d, a
    and a, $F0
    ld e, a
    ld a, d
    and a, $0F
    ld d, a
    ld hl, $4010
    add hl, de
    ld e, l
    ld d, h
    push de
    ld a, c
    add a, a
    ld de, Data_01E_60C1
    add a, e
    ld e, a
    jr nc, Jump_01E_609E
    inc d

Jump_01E_609E::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    pop de
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    pop bc
    inc c
    dec b
    jr nz, Jump_01E_6078
    ret

Data_01E_60B1:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A3, $54, $44, $11, $16, $19, $48, $24, $A6, $12, $31, $29, $32, $18, $14, $A3

Data_01E_60C1:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D0, $8E, $E0, $8E, $F0, $8E, $50, $8F, $60, $8F, $70, $8F, $D0, $8F, $E0, $8F
    db $F0, $8F, $00, $97, $10, $97, $20, $97, $30, $97, $40, $97, $50, $97, $60, $97

Jump_01E_60E1::
    call Func_01E_65FE
    call Func_01E_42C6
    xor a, a
    ld [$D782], a
    ret

Jump_01E_60EC::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_60F4::
    ld a, [$D781]
    rst $00
    dw Jump_01E_61B4
    dw Jump_01E_6635
    dw Jump_01E_6646
    dw Jump_01E_5B96
    dw Jump_01E_616A
    dw Jump_01E_669D
    dw Jump_01E_6183
    dw Func_01E_65FE
    dw Jump_01E_679E
    dw Jump_01E_67B1
    dw Jump_01E_613A
    dw Jump_01E_6840
    dw Jump_01E_685A
    dw Jump_01E_5C85
    dw Jump_01E_68D3
    dw Jump_01E_6840
    dw Jump_01E_685A
    dw Jump_01E_68E4
    dw Jump_01E_6907
    dw Jump_01E_6920
    dw Jump_01E_694D
    dw Jump_01E_61C5
    dw Jump_01E_6A57
    dw Jump_01E_5E98
    dw Jump_01E_5ED6
    dw Jump_01E_6A70
    dw Jump_01E_6B10
    dw Jump_01E_61F1
    dw Jump_01E_6BC6
    dw Jump_01E_6C1F
    dw Jump_01E_6C69
    dw Jump_01E_6C97
    dw Jump_01E_6225

Jump_01E_613A::
    ld hl, Data_01E_793C
    ld de, Data_01E_791C
    call Func_01E_7454
    ld hl, $5F2D
    ld b, $1D
    rst $10
    call Func_01E_76EB
    push hl
    ld a, [hl]
    ld b, a
    call Func_01E_75C5
    pop hl
    push hl
    ld a, [hl]
    ld b, a
    ld [$D7F1], a
    call Func_01E_75EB
    pop hl
    ld a, [hl]
    ld b, a
    call Func_01E_75C5
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_616A::
    call Func_01E_667C
    ld a, $01
    ld [$D7F1], a
    ld hl, $6AA5
    ld b, $1D
    rst $10
    xor a, a
    ld [$D7F1], a
    ld hl, $6AA5
    ld b, $1D
    rst $10
    ret

Jump_01E_6183::
    ld a, [$D782]
    rst $00
    dw Jump_01E_5BDC
    dw Func_01E_5C37
    dw Func_01E_5C63
    dw Jump_01E_618F

Jump_01E_618F::
    call Func_01E_49F8
    call Func_01E_7702
    ld a, $04
    ld [$D781], a
    xor a, a
    ld [$D782], a
    ret

Jump_01E_619F::
    ld hl, Data_01E_793C
    ld de, Data_01E_791C
    call Func_01E_7454
    call Func_01E_6810
    call Func_01E_76EB
    ld a, [hl]
    ld b, a
    call Func_01E_75C5
    ret

Jump_01E_61B4::
    call Func_01E_65FE
    ld de, Data_01F_4A70
    ld hl, $8FF0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ret

Jump_01E_61C5::
    ld a, [$D782]
    rst $00
    dw Jump_01E_5D2B
    dw Func_01E_5C37
    dw Func_01E_5C63
    dw Jump_01E_61D1

Jump_01E_61D1::
    call Func_01E_49F8
    call Func_01E_7702
    ld a, $01
    ld [$D7F1], a
    ld hl, $6AA5
    ld b, $1D
    rst $10
    xor a, a
    ld [$D7F1], a
    ld hl, $6AA5
    ld b, $1D
    rst $10
    xor a, a
    ld [$D782], a
    ret

Jump_01E_61F1::
    ld a, [$D782]
    rst $00
    dw Jump_01E_5DD1
    dw Func_01E_5C37
    dw Func_01E_5C63
    dw Jump_01E_61FD

Jump_01E_61FD::
    call Func_01E_49F8
    call Func_01E_7702
    ld a, $01
    ld [$D7F1], a
    ld hl, $6AA5
    ld b, $1D
    rst $10
    xor a, a
    ld [$D7F1], a
    ld hl, $6AA5
    ld b, $1D
    rst $10
    ld a, [$D781]
    sub a, $04
    ld [$D781], a
    xor a, a
    ld [$D782], a
    ret

Jump_01E_6225::
    ld a, [$D782]
    rst $00
    dw Jump_01E_5F29
    dw Func_01E_5C37
    dw Func_01E_5C63
    dw Jump_01E_6231

Jump_01E_6231::
    call Func_01E_49F8
    call Func_01E_7702
    ld a, $01
    ld [$D7F1], a
    ld hl, $6AA5
    ld b, $1D
    rst $10
    xor a, a
    ld [$D7F1], a
    ld hl, $6AA5
    ld b, $1D
    rst $10
    ld a, [$D781]
    dec a
    ld [$D781], a
    xor a, a
    ld [$D782], a
    jp Jump_01E_5F65

Jump_01E_625A::
    ld a, [$D781]
    rst $00
    dw Jump_01E_61B4
    dw Jump_01E_6282
    dw Jump_01E_6646
    dw Jump_01E_62C0
    dw Jump_01E_62EF
    dw Jump_01E_6325
    dw Jump_01E_6399
    dw Jump_01E_6437
    dw Jump_01E_6492
    dw Jump_01E_60E1
    dw Jump_01E_679E
    dw Jump_01E_67B1
    dw Jump_01E_64AD
    dw Jump_01E_54D6
    dw Jump_01E_6519
    dw Jump_01E_556A
    dw Jump_01E_656F
    dw Jump_01E_64BE

Jump_01E_6282::
    ld hl, Data_01E_7898
    ld de, Data_01E_78DA
    call Func_01E_7454
    call Func_01E_6074
    xor a, a
    ld [$D782], a
    ld a, $02
    ld [$D781], a
    ret

Jump_01E_6298::
    ld a, [$D781]
    rst $00
    dw Jump_01E_61B4
    dw Jump_01E_6635
    dw Jump_01E_6646
    dw Jump_01E_62C0
    dw Jump_01E_62EF
    dw Jump_01E_6325
    dw Jump_01E_6399
    dw Jump_01E_6437
    dw Jump_01E_6492
    dw Func_01E_65FE
    dw Jump_01E_679E
    dw Jump_01E_67B1
    dw Jump_01E_64AD
    dw Jump_01E_54D6
    dw Jump_01E_6519
    dw Jump_01E_556A
    dw Jump_01E_656F
    dw Jump_01E_64BE

Jump_01E_62C0::
    ld hl, $9200
    ld bc, $1304
    call Func_000_1881
    ld de, Data_01F_4A40
    ld hl, $8ED0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld a, [$D7AF]
    add a, a
    add a, a
    ld b, a
    ld a, [$D7AB]
    add a, b
    ld [$D7AB], a
    xor a, a
    ld [$D7AF], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_62EF::
    ld hl, $6D07
    ld b, $1D
    rst $10
    call Func_01E_750F
    ld de, $6E7F
    ld a, $14
    ld [$D7F3], a
    ld a, $12
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    call Func_01E_6D2B
    call Func_01E_76F3
    ld a, l
    ld [$D7F1], a
    ld a, h
    ld [$D7F2], a
    ld hl, $682A
    ld b, $1D
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_6325::
    call Func_01E_76F3
    ld a, [hl]
    ld b, a
    call Func_01E_6D70
    call Func_01E_6FEB
    ld a, $F0
    ldh [$FFBA], a
    call Func_01E_750F
    ld de, $0069
    add hl, de
    call Func_000_24F8
    di
    call Func_000_120A
    ld a, $6C
    ld [hl], a
    ei
    ld de, $0120
    add hl, de
    di
    call Func_000_120A
    ld a, $6D
    ld [hl], a
    ei
    ld a, [$D7A9]
    cp a, $02
    jr c, Jump_01E_6391
    ld de, Data_01F_4AA0
    ld hl, $9020
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4AE0
    ld hl, $9030
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    call Func_01E_750F
    ld de, $0012
    add hl, de
    call Func_000_24F8
    di
    call Func_000_120A
    ld a, $02
    ld [hl], a
    ei
    ld de, $0220
    add hl, de
    di
    call Func_000_120A
    ld a, $03
    ld [hl], a
    ei

Jump_01E_6391::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_6399::
    ld a, [$D782]
    and a, a
    jp nz, Jump_01E_63D3
    call Func_01E_6D0F
    call Func_01E_76F3
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
    ld hl, $9480
    ld c, $01
    call Func_000_1FE3
    pop de
    pop hl
    xor a, a
    ld [$1FFF], a
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_01E_63D3::
    call Func_01E_76F3
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    push hl
    ld a, [$C525]
    and a, a
    jr z, Jump_01E_640A
    ld a, [hl]
    ld c, $0B
    call Func_000_1F89
    ldh a, [$FFC6]
    ld e, a
    ldh a, [$FFC7]
    ld d, a
    push de
    ld a, $7F
    ld [$C526], a
    call Func_000_0829
    ld a, $01
    ldh [$FFC6], a
    call Func_01E_750F
    ld de, $0041
    add hl, de
    pop de
    call Func_000_2090

Jump_01E_640A::
    pop hl
    xor a, a
    ld [$1FFF], a
    call Func_01E_750F
    ld de, $0041
    add hl, de
    ld de, $64F7
    ld a, $06
    ld [$D7F3], a
    ld a, $06
    ld [$D7F4], a
    ld a, $01
    ld [$D7F7], a
    call Func_01E_6D2B
    xor a, a
    ld [$D782], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_6437::
    ld hl, $64D6
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    jr z, Jump_01E_644F
    cp a, $FD
    jr z, Jump_01E_6471
    cp a, $FE
    jr z, Jump_01E_6483
    cp a, $FF
    jr z, Jump_01E_6483

Jump_01E_644F::
    ld a, [$C58A]
    and a, a
    jr z, Jump_01E_645D
    ld a, [$C581]
    cp a, $08
    jr nz, Jump_01E_645D
    ret

Jump_01E_645D::
    call Func_01E_76F3
    ld c, $00
    ld a, l
    ld [$D7F1], a
    ld a, h
    ld [$D7F2], a
    ld hl, $6899
    ld b, $1D
    rst $10
    ret

Jump_01E_6471::
    ld a, [$D7B9]
    cp a, $02
    jr c, Jump_01E_644F
    xor a, a
    ldh [$FFBA], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_6483::
    call Func_01E_7732
    xor a, a
    ldh [$FFBA], a
    ld a, [$D781]
    add a, $02
    ld [$D781], a
    ret

Jump_01E_6492::
    ld hl, $9200
    ld bc, $0805
    call Func_000_1881
    ld hl, $9480
    ld bc, $0904
    call Func_000_1881
    ld a, [$D781]
    sub a, $04
    ld [$D781], a
    ret

Jump_01E_64AD::
    ld hl, Data_01E_793C
    ld de, Data_01E_791C
    call Func_01E_7454
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_64BE::
    ld hl, $4AA8
    ld b, $04
    rst $10
    ld a, $7F
    ld [$C527], a
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    call Func_01E_750F
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call Func_01E_74C8
    call Func_01E_7763
    ld a, $70
    ldh [$FFBA], a
    xor a, a
    ld [$D782], a
    ld a, [$D7B2]
    ld [$D780], a
    ld a, [$D7B3]
    ld [$D781], a
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, [$D7B2]
    cp a, $07
    ret nz
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_6519::
    ld de, Data_01E_7B49
    ld hl, $C36B
    ld bc, $0D09
    call Func_01E_748E
    call Func_01E_71E1
    ld a, [$D7B0]
    cp a, $02
    jr c, Jump_01E_6552
    ld a, [$D7B2]
    cp a, $07
    jr z, Jump_01E_6559
    ld hl, $C412
    call Func_01E_7556
    ld hl, $C413
    ld a, h
    ld [$D7F1], a
    ld a, l
    ld [$D7F2], a
    call Func_01E_759A

Jump_01E_654A::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_6552::
    ld a, [$D7B2]
    cp a, $07
    jr nz, Jump_01E_654A

Jump_01E_6559::
    ld de, Data_01E_6567
    ld hl, $C410
    ld bc, $0801
    call Func_01E_748E
    jr Jump_01E_654A

Data_01E_6567:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2

Jump_01E_656F::
    ld de, Data_01F_4990
    ld hl, $8CE0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld a, $01
    ld [$D7F1], a
    xor a, a
    ld [$D7F2], a
    ld hl, $6320
    ld b, $1D
    rst $10
    ld a, [$D786]
    ld b, $BC
    ld hl, Data_01E_7880
    call Func_01E_741A
    ld a, [$D7B2]
    cp a, $07
    jr z, Jump_01E_65A5
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_65A5::
    ld a, [$D7AB]
    ld b, $BC
    ld hl, Data_01E_788E
    call Func_01E_741A
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_65B8::
    ld a, [$D781]
    rst $00
    dw Func_01E_65FE
    dw Jump_01E_6635
    dw Jump_01E_6646
    dw Jump_01E_664E
    dw Func_01E_667C
    dw Jump_01E_669D
    dw Jump_01E_6753
    dw Func_01E_65FE
    dw Jump_01E_679E
    dw Jump_01E_67B1
    dw Func_01E_6810
    dw Jump_01E_6840
    dw Jump_01E_685A
    dw Jump_01E_6870
    dw Jump_01E_68D3
    dw Jump_01E_6840
    dw Jump_01E_685A
    dw Jump_01E_68E4
    dw Jump_01E_6907
    dw Jump_01E_6920
    dw Jump_01E_694D
    dw Jump_01E_69AD
    dw Jump_01E_6A57
    dw Jump_01E_5E98
    dw Jump_01E_5ED6
    dw Jump_01E_6A70
    dw Jump_01E_6B10
    dw Jump_01E_6B1F
    dw Jump_01E_6BC6
    dw Jump_01E_6C1F
    dw Jump_01E_6C69
    dw Jump_01E_6C97
    dw Jump_01E_6CAB

Func_01E_65FE::
    call Func_01E_750F
    ld a, h
    ld [$D7F5], a
    ld a, l
    ld [$D7F6], a
    ld de, $5E12
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
    ld hl, $5D9A
    ld b, $1F
    rst $10
    xor a, a
    ldh [$FFA1], a
    ldh [$FFA5], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_6635::
    ld hl, Data_01E_7898
    ld de, Data_01E_78DA
    call Func_01E_7454
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_6646::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_664E::
    call Func_01E_750F
    ld de, $5E37
    ld a, $14
    ld [$D7F3], a
    ld a, $12
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    call Func_01E_6D2B
    call Func_01E_750F
    ld de, $0020
    add hl, de
    call Func_000_24F8
    ld c, $40
    call Func_01E_7646
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_01E_667C::
    call Func_01E_76EB
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    call Func_01E_725D
    call Func_01E_7332
    call Func_01E_7399
    xor a, a
    ld [$1FFF], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_669D::
    ld a, [$D782]
    and a, a
    jp nz, Jump_01E_66EF
    call Func_01E_750F
    ld de, $0161
    add hl, de
    ld de, $651B
    ld a, $06
    ld [$D7F3], a
    ld a, $06
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    call Func_01E_6D2B
    call Func_01E_76EB
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
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_01E_66EF::
    call Func_01E_76EB
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    push hl
    ld a, [$C525]
    and a, a
    jr z, Jump_01E_6726
    ld a, [hl]
    ld c, $0B
    call Func_000_1F89
    ldh a, [$FFC6]
    ld e, a
    ldh a, [$FFC7]
    ld d, a
    push de
    ld a, $7F
    ld [$C526], a
    call Func_000_0829
    ld a, $01
    ldh [$FFC6], a
    call Func_01E_750F
    ld de, $0161
    add hl, de
    pop de
    call Func_000_2090

Jump_01E_6726::
    pop hl
    xor a, a
    ld [$1FFF], a
    call Func_01E_750F
    ld de, $0161
    add hl, de
    ld de, $64AF
    ld a, $06
    ld [$D7F3], a
    ld a, $06
    ld [$D7F4], a
    ld a, $01
    ld [$D7F7], a
    call Func_01E_6D2B
    xor a, a
    ld [$D782], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_6753::
    xor a, a
    ld [$D7F9], a
    ld hl, $65F6
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FD
    jr z, Jump_01E_676F
    cp a, $FE
    jr z, Jump_01E_6775
    cp a, $FF
    jr z, Jump_01E_677D
    ret

Jump_01E_676F::
    ld a, $04
    ld [$D781], a
    ret

Jump_01E_6775::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_677D::
    call Func_01E_750F
    ld de, $0161
    add hl, de
    ld de, $651B
    ld a, $06
    ld [$D7F3], a
    ld a, $06
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    call Func_01E_6D2B
    ld a, $0E
    ld [$D781], a
    ret

Jump_01E_679E::
    ld hl, $5D47
    ld b, $1D
    rst $10
    ld a, $7F
    ld [$C526], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_67B1::
    ld hl, Data_01E_7864
    ld de, Data_01E_7872
    call Func_01E_7454
    xor a, a
    ld b, $C3
    ld hl, Data_01E_7880
    call Func_01E_741A
    ld a, $01
    ld b, $C3
    ld hl, Data_01E_7880
    call Func_01E_741A
    ld a, $02
    ld b, $C3
    ld hl, Data_01E_7880
    call Func_01E_741A
    ld a, [$D780]
    cp a, $08
    jr z, Jump_01E_67F2
    ld a, $03
    ld b, $C3
    ld hl, Data_01E_7880
    call Func_01E_741A
    ld a, $04
    ld b, $C3
    ld hl, Data_01E_7880
    call Func_01E_741A

Jump_01E_67F2::
    ld a, [$D780]
    cp a, $0A
    jr z, Jump_01E_6808
    cp a, $0B
    jr z, Jump_01E_6808
    ld a, [$D7AB]
    ld b, $BC
    ld hl, Data_01E_7880
    call Func_01E_741A

Jump_01E_6808::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_01E_6810::
    ld a, [$D780]
    cp a, $08
    jr nz, Jump_01E_681F
    ld hl, $5E79
    ld b, $1D
    rst $10
    jr Jump_01E_6825

Jump_01E_681F::
    ld hl, $5ECE
    ld b, $1D
    rst $10

Jump_01E_6825::
    call Func_01E_76EB
    ld a, [hl]
    ld b, a
    call Func_01E_75C5
    call Func_01E_76EB
    ld a, [hl]
    ld b, a
    ld [$D7F1], a
    call Func_01E_75EB
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_6840::
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

Jump_01E_685A::
    call Func_01E_76EB
    ld a, [hl]
    ld b, a
    ld [$D7F1], a
    ld hl, $5CD7
    ld b, $1D
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_6870::
    ld hl, $5E79
    ld b, $1D
    rst $10
    call Func_01E_76F3
    ld a, [hl]
    ld b, a
    call Func_01E_75C5
    ld hl, $4AA8
    ld b, $04
    rst $10
    ld a, $7F
    ld [$C527], a
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    call Func_01E_750F
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call Func_01E_74C8
    call Func_01E_7763
    ld a, $70
    ldh [$FFBA], a
    xor a, a
    ld [$D782], a
    ld a, [$D7B2]
    ld [$D780], a
    ld a, [$D7B3]
    ld [$D781], a
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_01E_68D3::
    ld hl, $9200
    ld bc, $0F02
    call Func_000_1881
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_68E4::
    call Func_01E_750F
    ld de, $0068
    add hl, de
    ld de, $6577
    ld a, $0C
    ld [$D7F3], a
    ld a, $0F
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    call Func_01E_6D2B
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_6907::
    call Func_01E_76EB
    ld a, [hl]
    push hl
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    call Func_01E_6D42
    pop hl
    call Func_01E_6EE2
    xor a, a
    ld [$1FFF], a

Jump_01E_6920::
    call Func_01E_76EB
    push hl
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld a, [hl]
    ld b, a
    ld a, $6D
    ld [$D7F1], a
    xor a, a
    ld [$D7F2], a
    ld a, $EA
    ld [$D7F3], a
    ld a, $C7
    ld [$D7F4], a
    call Func_01E_70EF
    pop hl
    call Func_01E_6F17
    xor a, a
    ld [$1FFF], a

Jump_01E_694D::
    call Func_01E_76EB
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld a, [hl]
    ld c, $0B
    call Func_000_1F89
    xor a, a
    ld [$1FFF], a
    ldh a, [$FFC6]
    ld [$D7F1], a
    ldh a, [$FFC7]
    ld [$D7F2], a
    xor a, a
    ld [$D7F3], a
    ld [$D7F4], a
    ld a, $80
    ld [$D7F5], a
    ld hl, $6973
    ld b, $1D
    rst $10
    ld a, $F0
    ldh [$FFBA], a
    ld hl, $5DBC
    ld b, $1D
    rst $10
    call Func_01E_750F
    ld de, $0160
    add hl, de
    ld de, $66DF
    ld a, $08
    ld [$D7F3], a
    ld a, $07
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    call Func_01E_6D2B
    ld a, [$D781]
    add a, $03
    ld [$D781], a
    ret

Jump_01E_69AD::
    call Func_01E_76EB
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld a, [hl]
    ld c, $0B
    call Func_000_1F89
    xor a, a
    ld [$1FFF], a
    ldh a, [$FFC6]
    ld [$D7F1], a
    ldh a, [$FFC7]
    ld [$D7F2], a
    xor a, a
    ld [$D7F3], a
    ld a, $90
    ld [$D7F4], a
    ld a, $40
    ld [$D7F5], a
    xor a, a
    ld [$D7F6], a
    ld hl, $6A3D
    ld b, $1D
    rst $10
    xor a, a
    ld [$D7F9], a
    ld hl, $65F6
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FD
    jr z, Jump_01E_6A01
    cp a, $FE
    jr z, Jump_01E_6A18
    cp a, $FF
    jr z, Jump_01E_6A0C
    ret

Jump_01E_6A01::
    xor a, a
    ldh [$FFBA], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_6A0C::
    xor a, a
    ldh [$FFBA], a
    ld a, [$D781]
    inc a
    inc a
    ld [$D781], a
    ret

Jump_01E_6A18::
    xor a, a
    ldh [$FFBA], a
    call Func_01E_750F
    ld de, $0068
    add hl, de
    ld de, $662B
    ld a, $0C
    ld [$D7F3], a
    ld a, $0F
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    call Func_01E_6D2B
    call Func_01E_750F
    ld de, $0160
    add hl, de
    ld de, $653F
    ld a, $08
    ld [$D7F3], a
    ld a, $07
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    call Func_01E_6D2B
    ld a, $04
    ld [$D781], a
    ret

Jump_01E_6A57::
    call Func_01E_76EB
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    call Func_01E_725D
    xor a, a
    ld [$1FFF], a
    ld a, $0F
    ld [$D781], a
    ret

Jump_01E_6A70::
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    call Func_01E_76EB
    ld a, [hl]
    ldh [$FFCB], a
    ld c, $34
    call Func_000_1F80
    ldh a, [$FFC6]
    cp a, $FF
    jr z, Jump_01E_6A8F
    and a, a
    jr z, Jump_01E_6A8F
    jr Jump_01E_6AB7

Jump_01E_6A8F::
    ld hl, $9200
    ld bc, $1504
    call Func_000_1881
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $92
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld [hl], $09
    ld a, $08
    ld [$C528], a
    ld a, $0E
    ld [$C529], a
    ld hl, Jump_01E_402B
    ld b, $08
    rst $10
    jr Jump_01E_6AFF

Jump_01E_6AB7::
    ld hl, $9200
    ld c, $34
    ld b, $08
    ld a, $01
    ld [$C52F], a
    ld a, $09
    ld [$C530], a
    ld a, $04
    ld [$C528], a

Jump_01E_6ACD::
    push bc
    push hl
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ldh a, [$FFCB]
    call Func_000_1F80
    ldh a, [$FFC6]
    and a, a
    jr z, Jump_01E_6AE7
    cp a, $FF
    jr z, Jump_01E_6AE7
    jr Jump_01E_6AEC

Jump_01E_6AE7::
    call Func_000_290E
    jr Jump_01E_6AF5

Jump_01E_6AEC::
    ld [$C529], a
    ld hl, Jump_01E_402B
    ld b, $08
    rst $10

Jump_01E_6AF5::
    pop hl
    ld bc, $0090
    add hl, bc
    pop bc
    inc c
    dec b
    jr nz, Jump_01E_6ACD

Jump_01E_6AFF::
    xor a, a
    ld [$1FFF], a
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12

Jump_01E_6B10::
    ld hl, $5DF9
    ld b, $1D
    rst $10
    ld a, [$D781]
    add a, $02
    ld [$D781], a
    ret

Jump_01E_6B1F::
    xor a, a
    ld [$D7F9], a
    ld hl, $65F6
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FD
    jr z, Jump_01E_6B3B
    cp a, $FE
    jr z, Jump_01E_6B44
    cp a, $FF
    jr z, Jump_01E_6B55
    ret

Jump_01E_6B3B::
    ld a, [$D781]
    sub a, $02
    ld [$D781], a
    ret

Jump_01E_6B44::
    ld hl, $9200
    ld bc, $1504
    call Func_000_1881
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_6B55::
    ld hl, $9730
    ld de, Data_01F_42D0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld hl, $6D07
    ld b, $1D
    rst $10
    call Func_01E_750F
    ld de, $0160
    add hl, de
    ld de, $6E47
    ld a, $08
    ld [$D7F3], a
    ld a, $07
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    call Func_01E_6D2B
    ld hl, $96C0
    ld bc, $0201
    call Func_000_1881
    call Func_01E_750F
    ld de, $0008
    add hl, de
    ld de, $6D6F
    ld a, $0C
    ld [$D7F3], a
    ld a, $12
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    call Func_01E_6D2B
    ld hl, $9200
    ld bc, $0805
    call Func_000_1881
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, [$D781]
    add a, $03
    ld [$D781], a
    ret

Jump_01E_6BC6::
    ld a, [$D782]
    and a, a
    jr nz, Jump_01E_6C0A
    call Func_01E_750F
    ld de, $0008
    add hl, de
    ld de, $5E13
    ld a, $0C
    ld [$D7F3], a
    ld a, $03
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    call Func_01E_6D2B
    call Func_01E_750F
    ld de, $0160
    add hl, de
    ld de, $66DF
    ld a, $08
    ld [$D7F3], a
    ld a, $07
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    call Func_01E_6D2B
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_01E_6C0A::
    ld hl, Data_01E_7864
    ld de, Data_01E_7872
    call Func_01E_7454
    xor a, a
    ld [$D782], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_01E_6C1F::
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    call Func_01E_76EB
    ld a, [hl]
    ld b, a
    push bc
    call Func_01E_725D
    xor a, a
    ld [$1FFF], a
    ld hl, $8A70
    ld bc, $0901
    call Func_000_1881
    pop bc
    ld a, b
    ld [$D7F1], a
    ld hl, $5CD7
    ld b, $1D
    rst $10
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

Jump_01E_6C69::
    call Func_01E_750F
    ld de, $0008
    add hl, de
    ld de, $63D7
    ld a, $0C
    ld [$D7F3], a
    ld a, $12
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    call Func_01E_6D2B
    call Func_01E_76EB
    ld a, l
    ld [$D7F1], a
    ld a, h
    ld [$D7F2], a
    push hl
    ld hl, $682A
    ld b, $1D
    rst $10
    pop hl

Jump_01E_6C97::
    ld b, [hl]
    call Func_01E_6D70
    call Func_01E_6FEB
    ld a, $F0
    ldh [$FFBA], a
    ld a, [$D781]
    add a, $02
    ld [$D781], a
    ret

Jump_01E_6CAB::
    xor a, a
    ld [$D7F9], a
    ld hl, $65F6
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    jr z, Jump_01E_6CC7
    cp a, $FD
    jr z, Jump_01E_6CDB
    cp a, $FE
    jr z, Jump_01E_6CFD
    cp a, $FF
    jr z, Jump_01E_6D06

Jump_01E_6CC7::
    call Func_01E_76EB
    ld c, $00
    ld a, l
    ld [$D7F1], a
    ld a, h
    ld [$D7F2], a
    ld hl, $6899
    ld b, $1D
    rst $10
    ret

Jump_01E_6CDB::
    xor a, a
    ldh [$FFBA], a
    ld a, [$D781]
    dec a
    dec a
    ld [$D781], a
    ld hl, $9200
    ld bc, $0805
    call Func_000_1881
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ret

Jump_01E_6CFD::
    xor a, a
    ldh [$FFBA], a
    ld a, $17
    ld [$D781], a
    ret

Jump_01E_6D06::
    xor a, a
    ldh [$FFBA], a
    ld a, $07
    ld [$D781], a
    ret

Func_01E_6D0F::
    call Func_01E_750F
    ld de, $0041
    add hl, de
    ld de, $651B
    ld a, $06
    ld [$D7F3], a
    ld a, $06
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    call Func_01E_6D2B
    ret

Func_01E_6D2B::
    ld a, h
    ld [$D7F5], a
    ld a, l
    ld [$D7F6], a
    ld a, d
    ld [$D7F1], a
    ld a, e
    ld [$D7F2], a
    ld hl, $5D2A
    ld b, $1F
    rst $10
    ret

Func_01E_6D42::
    ld a, [hl]
    call Func_000_2391
    ld c, a
    ld [$C529], a
    ld a, $07
    ld [$C528], a
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $92
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld [hl], $09
    ld hl, Jump_01E_402B
    ld b, $08
    rst $10
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ret

Func_01E_6D70::
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    push bc
    ld a, b
    ld c, $0D
    call Func_000_1F80
    ldh a, [$FFC6]
    and a, $10
    and a, a
    jr nz, Jump_01E_6D8C
    ld de, Data_01E_6ED2
    jr Jump_01E_6D8F

Jump_01E_6D8C::
    ld de, Data_01E_6EDA

Jump_01E_6D8F::
    pop bc
    push bc
    ld a, [de]
    ld c, a
    ld a, b
    push de
    call Func_000_1F89
    pop de
    ldh a, [$FFC7]
    cp a, $FF
    jr nz, Jump_01E_6DC5
    ld a, $98
    ld [$C8CF], a
    ld a, $98
    ld [$C8D0], a
    ld a, $98
    ld [$C8D1], a
    ld a, $F0
    ld [$C8D2], a
    push de
    ld de, $9200
    call Func_000_21A1
    pop de
    pop bc
    ld a, $03
    add a, e
    ld e, a
    jr nc, Jump_01E_6DC3
    inc d

Jump_01E_6DC3::
    jr Jump_01E_6DF3

Jump_01E_6DC5::
    inc de
    pop bc
    push bc
    ld a, [de]
    ld c, a
    inc de
    push de
    ld a, b
    call Func_000_1FA4
    ld a, $F0
    ld [$C8D9], a
    ld de, $9200
    call Func_000_21A1
    pop de
    pop bc
    push bc
    ld a, $92
    ld [$D7F1], a
    ld a, $50
    ld [$D7F2], a
    ld a, [de]
    inc de
    push de
    ld [$D7F3], a
    call Func_01E_6E84
    pop de
    pop bc

Jump_01E_6DF3::
    push bc
    ld a, [de]
    ld c, a
    inc de
    push de
    ld a, b
    call Func_000_1FA4
    ld de, $92F0
    ld a, $F0
    ld [$C8D9], a
    call Func_000_21A1
    pop de
    pop bc
    push bc
    ld a, [de]
    ld c, a
    ld a, b
    push de
    call Func_000_1F89
    pop de
    ldh a, [$FFC7]
    cp a, $FF
    jr nz, Jump_01E_6E3E
    ld a, $98
    ld [$C8CF], a
    ld a, $98
    ld [$C8D0], a
    ld a, $98
    ld [$C8D1], a
    ld a, $F0
    ld [$C8D2], a
    push de
    ld de, $9340
    call Func_000_21A1
    pop de
    pop bc
    ld a, $03
    add a, e
    ld e, a
    jr nc, Jump_01E_6E3C
    inc d

Jump_01E_6E3C::
    jr Jump_01E_6E6C

Jump_01E_6E3E::
    inc de
    pop bc
    push bc
    ld a, [de]
    ld c, a
    inc de
    push de
    ld a, b
    call Func_000_1FA4
    ld a, $F0
    ld [$C8D9], a
    ld de, $9340
    call Func_000_21A1
    pop de
    pop bc
    push bc
    ld a, $93
    ld [$D7F1], a
    ld a, $90
    ld [$D7F2], a
    ld a, [de]
    inc de
    push de
    ld [$D7F3], a
    call Func_01E_6E84
    pop de
    pop bc

Jump_01E_6E6C::
    push bc
    ld a, [de]
    ld c, a
    ld a, b
    call Func_000_1FA4
    ld de, $9430
    ld a, $F0
    ld [$C8D9], a
    call Func_000_21A1
    pop bc
    xor a, a
    ld [$1FFF], a
    ret

Func_01E_6E84::
    push bc
    ld a, [$D7F3]
    ld c, a
    ld a, b
    call Func_000_1F89
    ldh a, [$FFC6]
    ld l, a
    ldh a, [$FFC7]
    ld h, a
    push hl
    ld a, [$D7FE]
    push af
    ld a, $08
    ld [$D7FE], a
    ld hl, $4032
    ld bc, $0004
    add hl, bc
    call Func_000_0B6C
    ld e, b
    ld b, c
    ld c, e
    pop af
    pop hl
    push af
    sla l
    rl h
    add hl, bc
    call Func_000_0B6C
    ld e, b
    ld d, c
    pop af
    ld [$D7FE], a
    ld hl, $C8CF
    ld b, $08
    ld c, $10
    call Func_000_0B2B
    ld a, [$D7F1]
    ld d, a
    ld a, [$D7F2]
    ld e, a
    call Func_000_21A1
    pop bc
    ret

Data_01E_6ED2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $1A, $8E, $1A, $1E, $1C, $99, $1C, $29

Data_01E_6EDA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $1C, $99, $1C, $29, $1A, $8E, $1A, $1E

Func_01E_6EE2::
    push hl
    ld hl, $2940
    ld de, $9290
    call Func_01E_7443
    ld hl, $2940
    call Func_01E_7443
    ld hl, $2940
    call Func_01E_7443
    ld hl, $2940
    call Func_01E_7443
    ld hl, $2940
    call Func_01E_7443
    pop hl
    ld a, [hl]
    ld c, $0F
    call Func_000_1FA4
    ld de, $9290
    ld a, $F0
    ld [$C8D9], a
    call Func_000_21A1
    ret

Func_01E_6F17::
    call Func_01E_76EB
    push hl
    ld a, [hl]
    ld c, $58
    call Func_000_1F95
    ldh a, [$FFC6]
    ld [$C8C0], a
    ldh a, [$FFC7]
    ld [$C8C1], a
    ldh a, [$FFC8]
    ld [$C8C2], a
    call Func_000_173A
    call Func_01E_768E
    call Func_01E_750F
    ld de, $018C
    add hl, de
    call Func_000_24F8
    call Func_01E_76C7
    pop hl
    push hl
    ld a, [hl]
    ld c, $56
    call Func_000_1F89
    ldh a, [$FFC7]
    ld b, a
    ldh a, [$FFC6]
    cp a, b
    jp nc, Jump_01E_6FC9
    ldh a, [$FFC6]
    ld b, a
    pop hl
    push hl
    push bc
    ld a, [hl]
    ld c, $0B
    call Func_000_1F89
    ldh a, [$FFC6]
    ld [$D006], a
    ldh a, [$FFC7]
    ld [$D007], a
    ld hl, Func_01E_4001
    ld b, $35
    rst $10
    ld a, [$D00F]
    ldh [$FFC6], a
    pop bc
    ld a, b
    ldh [$FFC7], a
    ld hl, $7380
    ld b, $19
    rst $10
    ld de, $FFC8
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    inc de
    ld a, [de]
    ld e, a
    pop hl
    push hl
    push bc
    push de
    ld a, [hl]
    ld c, $58
    call Func_000_1F95
    pop de
    pop bc
    ldh a, [$FFC6]
    ld l, a
    ld a, c
    sub a, l
    ld c, a
    ldh a, [$FFC7]
    ld l, a
    ld a, b
    sbc a, l
    ld b, a
    ldh a, [$FFC8]
    ld l, a
    ld a, e
    sbc a, l
    ld e, a
    ld a, c
    ld [$C8C0], a
    ld a, b
    ld [$C8C1], a
    ld a, e
    ld [$C8C2], a
    call Func_000_173A
    call Func_01E_768E

Jump_01E_6FBA::
    call Func_01E_750F
    ld de, $020C
    add hl, de
    call Func_000_24F8
    call Func_01E_76C7
    pop hl
    ret

Jump_01E_6FC9::
    ld a, $E3
    ld [$D7F1], a
    ld [$D7F2], a
    ld [$D7F3], a
    ld [$D7F4], a
    ld [$D7F5], a
    ld [$D7F6], a
    xor a, a
    ld [$D7F7], a
    jr Jump_01E_6FBA

Func_01E_6FE3::
    ld b, e
    call Func_01E_6D70
    call Func_01E_6FEB
    ret

Func_01E_6FEB::
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    push bc
    ld a, b
    ld c, $0D
    call Func_000_1F80
    ldh a, [$FFC6]
    and a, $10
    and a, a
    jr nz, Jump_01E_7007
    ld de, Data_01E_70D7
    jr Jump_01E_700A

Jump_01E_7007::
    ld de, Data_01E_70DD

Jump_01E_700A::
    pop bc
    push bc
    ld a, [de]
    ld c, a
    ld a, b
    push de
    call Func_000_1F89
    pop de
    ldh a, [$FFC7]
    cp a, $FF
    jr nz, Jump_01E_702A
    push de
    ld hl, $8C30
    ld de, $96C0
    call Func_01E_7443
    pop de
    inc de
    inc de
    inc de
    jr Jump_01E_7067

Jump_01E_702A::
    inc de
    pop bc
    push bc
    ld a, [de]
    ld [$D7F1], a
    inc de
    ld a, [de]
    dec de
    push de
    ld [$D7F5], a
    xor a, a
    ld [$D7F2], a
    ld a, $6A
    ld [$D7F3], a
    ld a, $6C
    ld [$D7F4], a
    call Func_01E_70E3
    pop de
    pop bc
    push bc
    call Func_01E_70C9
    inc de
    inc de
    push de
    call Func_01E_750F
    ld de, $006E
    add hl, de
    call Func_000_24F8
    di

Jump_01E_705D::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_01E_705D
    ld a, b
    ld [hl], a
    ei
    pop de

Jump_01E_7067::
    pop bc
    push bc
    ld a, [de]
    ld c, a
    ld a, b
    push de
    call Func_000_1F89
    pop de
    ldh a, [$FFC7]
    cp a, $FF
    jr nz, Jump_01E_7087
    push de
    ld hl, $8C30
    ld de, $96D0
    call Func_01E_7443
    pop de
    inc de
    inc de
    inc de
    jr Jump_01E_70C3

Jump_01E_7087::
    inc de
    pop bc
    push bc
    ld a, [de]
    ld [$D7F1], a
    inc de
    ld a, [de]
    dec de
    push de
    ld [$D7F5], a
    ld a, $01
    ld [$D7F2], a
    ld a, $8A
    ld [$D7F3], a
    ld a, $6D
    ld [$D7F4], a
    call Func_01E_70E3
    pop de
    pop bc
    push bc
    call Func_01E_70C9
    push de
    call Func_01E_750F
    ld de, $018E
    add hl, de
    call Func_000_24F8
    di

Jump_01E_70B9::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_01E_70B9
    ld a, b
    ld [hl], a
    ei
    pop de

Jump_01E_70C3::
    pop bc
    xor a, a
    ld [$1FFF], a
    ret

Func_01E_70C9::
    ld a, [de]
    cp a, $98
    jr z, Jump_01E_70D3
    ld bc, $CDCC
    jr Jump_01E_70D6

Jump_01E_70D3::
    ld bc, $CCCD

Jump_01E_70D6::
    ret

Data_01E_70D7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $1A, $98, $1A, $1C, $A3, $1C

Data_01E_70DD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $1C, $A3, $1C, $1A, $98, $1A

Func_01E_70E3::
    push bc
    ld c, b
    ld hl, $612E
    ld b, $0E
    rst $10
    pop bc
    jp Jump_01E_710A

Func_01E_70EF::
    push bc
    ld c, $0D
    ld a, b
    call Func_000_1F80
    ldh a, [$FFC6]
    and a, $0F
    ld [$D09D], a
    ld a, [$D7F4]
    ld [$D09E], a
    ld hl, Data_01E_7A48
    ld b, $16
    rst $10
    pop bc

Jump_01E_710A::
    ld a, [$D7F1]
    ld c, a
    ld a, b
    call Func_000_1F80
    ldh a, [$FFC6]
    and a, a
    jr nz, Jump_01E_7118
    ret

Jump_01E_7118::
    push af
    call Func_01E_750F
    ld a, [$D7F2]
    ld d, a
    ld a, [$D7F3]
    ld e, a
    add hl, de
    call Func_000_24F8
    di

Jump_01E_7129::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_01E_7129
    ld a, $1E
    ld [hl+], a
    ei
    pop af
    push hl
    ld l, a
    ld h, $00
    call Func_000_16F5
    call Func_01E_75B3
    pop hl
    ld a, [$C8C1]
    cp a, $E3
    jr z, Jump_01E_7154
    di

Jump_01E_7147::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_01E_7147
    ld a, [$C8C1]
    add a, $E0
    ld [hl+], a
    ei

Jump_01E_7154::
    di

Jump_01E_7155::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_01E_7155
    ld a, [$C8C2]
    add a, $E0
    ld [hl+], a
    ei
    ret

Func_01E_7163::
    ld a, [$D7A9]
    ld l, a
    ld h, $00
    ld a, $05
    call Func_000_16D1
    push af
    and a, a

Jump_01E_7170::
    jr z, Jump_01E_7173
    inc l

Jump_01E_7173::
    ld a, l
    ld [$D7B0], a
    ld a, [$D7AF]
    inc a
    cp a, l
    jr c, Jump_01E_71AE
    pop af
    push af
    and a, a
    jr nz, Jump_01E_7193
    ld a, [$D7AF]
    inc a
    cp a, l
    jr z, Jump_01E_71AE
    ld a, [$D7AF]
    dec a
    ld [$D7AF], a
    jr Jump_01E_71AE

Jump_01E_7193::
    pop af
    dec a
    ld [$D7B1], a
    ld b, a
    ld a, [$D7AB]
    cp a, b
    jr c, Jump_01E_71B4
    jr z, Jump_01E_71B4
    push bc
    push hl
    call Func_01E_71B5
    pop hl
    pop bc
    ld a, b
    ld [$D7AB], a
    jr Jump_01E_71B4

Jump_01E_71AE::
    pop af
    ld a, $04
    ld [$D7B1], a

Jump_01E_71B4::
    ret

Func_01E_71B5::
    ld b, $C3
    ld a, [$D7AB]
    add a, a
    ld hl, Data_01E_71D7
    add a, l
    ld l, a
    jr nc, Jump_01E_71C3
    inc h

Jump_01E_71C3::
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call Func_01E_750F
    pop de
    add hl, de
    call Func_000_24F8
    di
    call Func_000_120A
    ld a, b
    ld [hl], a
    ei
    ret

Data_01E_71D7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $21, $00, $61, $00, $A1, $00, $E1, $00, $21, $01

Func_01E_71E1::
    ld a, [$D7A9]
    ld l, a
    ld h, $00
    ld a, $04
    call Func_000_16D1
    push af
    and a, a
    jr z, Jump_01E_71F1
    inc l

Jump_01E_71F1::
    ld a, l
    ld [$D7B0], a
    ld a, [$D7AF]
    inc a
    cp a, l
    jr c, Jump_01E_722C
    pop af
    push af
    and a, a
    jr nz, Jump_01E_7211
    ld a, [$D7AF]
    inc a
    cp a, l
    jr z, Jump_01E_722C
    ld a, [$D7AF]
    dec a
    ld [$D7AF], a
    jr Jump_01E_722C

Jump_01E_7211::
    pop af
    dec a
    ld [$D7B1], a
    ld b, a
    ld a, [$D7AB]
    cp a, b
    jr c, Jump_01E_7232
    jr z, Jump_01E_7232
    push bc
    push hl
    call Func_01E_7233
    pop hl
    pop bc
    ld a, b
    ld [$D7AB], a
    jr Jump_01E_7232

Jump_01E_722C::
    pop af
    ld a, $03
    ld [$D7B1], a

Jump_01E_7232::
    ret

Func_01E_7233::
    ld b, $C3
    ld a, [$D7AB]
    add a, a
    ld hl, Data_01E_7255
    add a, l
    ld l, a
    jr nc, Jump_01E_7241
    inc h

Jump_01E_7241::
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call Func_01E_750F
    pop de
    add hl, de
    call Func_000_24F8
    di
    call Func_000_120A
    ld a, b
    ld [hl], a
    ei
    ret

Data_01E_7255:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $28, $00, $68, $00, $A8, $00, $E8, $00

Func_01E_725D::
    push hl
    ld a, [hl]
    ld c, $56
    ld b, $02
    call Func_000_1F89
    call Func_01E_750F
    ld de, $0029
    add hl, de
    call Func_000_24F8
    ldh a, [$FFC7]
    ld b, a
    ldh a, [$FFC6]
    cp a, b
    jr c, Jump_01E_7282
    di
    call Func_000_120A
    ld a, $6F
    ld [hl], a
    ei
    jr Jump_01E_728A

Jump_01E_7282::
    di
    call Func_000_120A
    ld a, $C3
    ld [hl], a
    ei

Jump_01E_728A::
    inc hl
    di
    call Func_000_120A
    ld a, $EA
    ld [hl+], a
    ld a, $ED
    ld [hl+], a
    ei
    push hl
    ldh a, [$FFC6]
    ld l, a
    ld h, $00
    call Func_000_16F5
    call Func_01E_75B3
    pop hl
    ld a, [$C8C1]
    add a, $E0
    ld e, a
    di
    call Func_000_120A
    ld [hl], e
    ei
    inc hl
    ld a, [$C8C2]
    add a, $E0
    ld e, a
    di
    call Func_000_120A
    ld [hl], e
    ei
    inc hl
    ld e, l
    ld d, h
    pop hl
    push hl
    push de
    ld a, [hl]
    ld c, $55
    call Func_000_1F80
    pop de
    ld l, e
    ld h, d
    call Func_01E_7306
    ldh a, [$FFC6]
    push af
    bit 0, a
    call nz, Func_01E_7317
    pop af
    inc hl
    push af
    bit 2, a
    call nz, Func_01E_7320
    pop af
    inc hl
    bit 7, a
    call nz, Func_01E_7329
    inc hl
    inc hl
    ld e, l
    ld d, h
    pop hl
    push hl
    push de
    ld a, [hl]
    ld c, $0E
    ld b, $01
    call Func_000_1F80
    pop de
    ld l, e
    ld h, d
    ldh a, [$FFC6]
    and a, $01
    add a, $CC
    ld e, a
    di
    call Func_000_120A
    ld [hl], e
    ei
    pop hl
    ret

Func_01E_7306::
    push hl
    ld e, $C3
    ld c, $03

Jump_01E_730B::
    di
    call Func_000_120A
    ld [hl], e
    ei
    inc hl
    dec c
    jr nz, Jump_01E_730B
    pop hl
    ret

Func_01E_7317::
    di
    call Func_000_120A
    ld a, $C0
    ld [hl], a
    ei
    ret

Func_01E_7320::
    di
    call Func_000_120A
    ld a, $C1
    ld [hl], a
    ei
    ret

Func_01E_7329::
    di
    call Func_000_120A
    ld a, $C2
    ld [hl], a
    ei
    ret

Func_01E_7332::
    push hl
    call Func_01E_750F
    ld de, $0070
    add hl, de
    call Func_000_24F8
    ld e, l
    ld d, h
    pop hl
    ld c, $00

Jump_01E_7342::
    push bc
    push hl
    push de
    ld a, c
    ld de, Data_01E_7394
    add a, e
    ld e, a
    jr nc, Jump_01E_734E
    inc d

Jump_01E_734E::
    ld a, [de]
    ld c, a
    ld a, [hl]
    call Func_000_1F89
    ldh a, [$FFC6]
    ld l, a
    ldh a, [$FFC7]
    ld h, a
    call Func_000_16F5
    call Func_01E_75B3
    pop de
    ld l, e
    ld h, d
    di
    call Func_000_120A
    ld a, [$C8C0]
    add a, $E0
    ld [hl+], a
    ei
    di
    call Func_000_120A
    ld a, [$C8C1]
    add a, $E0
    ld [hl+], a
    ei
    di
    call Func_000_120A
    ld a, [$C8C2]
    add a, $E0
    ld [hl+], a
    ei
    ld a, $40
    add a, e
    ld e, a
    jr nc, Jump_01E_738B
    inc d

Jump_01E_738B::
    pop hl
    pop bc
    inc c
    ld a, c
    cp a, $05
    jr c, Jump_01E_7342
    ret

Data_01E_7394:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $63, $65, $67, $69, $6B

Func_01E_7399::
    ld c, $00

Jump_01E_739B::
    push hl
    ld a, [hl]
    ld b, a
    push bc
    ld a, c
    ld hl, Data_01E_73FA
    add a, l
    ld l, a
    jr nc, Jump_01E_73A8
    inc h

Jump_01E_73A8::
    ld a, [hl]
    ld c, a
    ld a, b
    call Func_000_1F89
    ldh a, [$FFC6]
    ld l, a
    ldh a, [$FFC7]
    ld h, a
    call Func_000_16F5
    call Func_01E_75B3
    pop bc
    ld a, c
    add a, a
    ld hl, Data_01E_73FE
    add a, l
    ld l, a
    jr nc, Jump_01E_73C5
    inc h

Jump_01E_73C5::
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call Func_01E_750F
    pop de
    add hl, de
    call Func_000_24F8
    di
    call Func_000_120A
    ld a, [$C8C0]
    add a, $E0
    ld [hl+], a
    ei
    di
    call Func_000_120A
    ld a, [$C8C1]
    add a, $E0
    ld [hl+], a
    ei
    di
    call Func_000_120A
    ld a, [$C8C2]
    add a, $E0
    ld [hl], a
    ei
    pop hl
    inc c
    ld a, c
    cp a, $04
    jr c, Jump_01E_739B
    ret

Data_01E_73FA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $5B, $5D, $5F, $61

Data_01E_73FE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $CC, $01, $D0, $01, $0C, $02, $10, $02

Func_01E_7406::
    ld a, c
    ld b, a
    ld c, $00

Jump_01E_740A::
    ld a, c
    push bc
    ld b, $C3
    push hl
    call Func_01E_741A
    pop hl
    pop bc
    inc c
    ld a, c
    cp a, b
    jr c, Jump_01E_740A
    ret

Func_01E_741A::
    push bc
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_01E_7421
    inc h

Jump_01E_7421::
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop bc
    ld a, b
    ld [de], a
    ret

Func_01E_7428::
    ld a, [de]
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Func_01E_7428
    ret

Func_01E_7431::
    ld a, $02
    ldh [$FF70], a

Jump_01E_7435::
    ld a, [de]
    and a, $07
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01E_7435
    xor a, a
    ldh [$FF70], a
    ret

Func_01E_7443::
    ld c, $10

Jump_01E_7445::
    di

Jump_01E_7446::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_01E_7446
    ld a, [hl+]
    ld [de], a
    inc de
    ei
    dec c
    jr nz, Jump_01E_7445
    ret

Func_01E_7454::
    ld b, $00

Jump_01E_7456::
    push bc
    push hl
    push de
    ld a, b
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_01E_7460
    inc h

Jump_01E_7460::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_01E_7486
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
    jr nc, Jump_01E_7475
    inc h

Jump_01E_7475::
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
    jr Jump_01E_7456

Jump_01E_7486::
    pop de
    pop hl
    pop bc
    xor a, a
    ld [$D784], a
    ret

Func_01E_748E::
    push hl
    push bc

Jump_01E_7490::
    push bc
    push hl

Jump_01E_7492::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_01E_7492
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_01E_7490
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

Jump_01E_74B4::
    push bc
    push hl

Jump_01E_74B6::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_01E_74B6
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_01E_74B4
    xor a, a
    ldh [$FF70], a
    ret

Func_01E_74C8::
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
    cp a, $00
    jr nz, Jump_01E_74EE
    ld a, h
    cp a, $98
    jr nz, Jump_01E_74EE
    ld a, l
    add a, $C1
    ld [$C554], a
    ld a, h
    adc a, $01
    ld [$C555], a

Jump_01E_74EE::
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

Func_01E_750F::
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
    jr nc, Jump_01E_752F
    inc h

Jump_01E_752F::
    ret

Func_01E_7530::
    push de
    call Func_01E_750F
    pop de
    add hl, de
    call Func_000_24F8
    di
    call Func_000_120A
    ld a, $C5
    ld [hl], a
    ei
    inc hl
    inc hl
    di
    call Func_000_120A
    ld a, $BE
    ld [hl], a
    ei
    inc hl
    inc hl
    di
    call Func_000_120A
    ld a, $C6
    ld [hl], a
    ei
    ret

Func_01E_7556::
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

Func_01E_7564::
    ld a, [$D7F1]
    ld d, a
    ld a, [$D7F2]
    ld e, a
    push de
    call Func_01E_750F
    pop de
    add hl, de
    push hl
    call Func_000_24F8
    ld a, [$D7AF]
    inc a
    ld b, a
    di
    call Func_000_120A
    ld a, b
    add a, $E0
    ld [hl], a
    ei
    pop hl
    inc hl
    inc hl
    push hl
    ld a, [$D7B0]
    ld b, a
    pop hl
    call Func_000_24F8
    di
    call Func_000_120A
    ld a, b
    add a, $E0
    ld [hl], a
    ei
    ret

Func_01E_759A::
    ld a, [$D7F1]
    ld h, a
    ld a, [$D7F2]
    ld l, a
    ld a, [$D7AF]
    inc a
    add a, $E0
    ld [hl+], a
    inc hl
    ld a, [$D7B0]
    ld b, a
    ld a, b
    add a, $E0
    ld [hl], a
    ret

Func_01E_75B3::
    ld hl, $C8C0
    ld a, [hl]
    and a, a
    jr nz, Jump_01E_75C4
    add a, $E3
    ld [hl+], a
    ld a, [hl]
    and a, a
    jr nz, Jump_01E_75C4
    add a, $E3
    ld [hl], a

Jump_01E_75C4::
    ret

Func_01E_75C5::
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
    ld a, $C7
    ld [$D09E], a
    ld hl, Data_01E_7A48
    ld b, $16
    rst $10
    xor a, a
    ld [$1FFF], a
    ret

Func_01E_75EB::
    ld hl, $5B4D
    ld b, $1D
    rst $10
    ret

Func_01E_75F2::
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
    call Func_01E_7428
    pop de
    pop hl
    ld a, [$C525]
    and a, a
    jr z, Jump_01E_7633
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
    call Func_01E_7431
    pop de
    pop hl

Jump_01E_7633::
    pop bc
    ld a, $14
    add a, l
    ld l, a
    jr nc, Jump_01E_763B
    inc h

Jump_01E_763B::
    ld a, $14
    add a, e
    ld e, a
    jr nc, Jump_01E_7642
    inc d

Jump_01E_7642::
    dec c
    jr nz, Func_01E_75F2
    ret

Func_01E_7646::
    ld b, $00

Jump_01E_7648::
    push bc
    push hl
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld hl, $D789
    ld a, b
    add a, l
    ld l, a
    jr nc, Jump_01E_765C
    inc h

Jump_01E_765C::
    ld a, [hl]
    ld c, $00
    ld b, $01
    call Func_000_1F80
    xor a, a
    ld [$1FFF], a
    ldh a, [$FFC6]
    cp a, $02
    jr nz, Jump_01E_7684
    pop hl
    pop bc
    push bc
    di

Jump_01E_7672::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_01E_7672
    ld a, b
    add a, $E1
    ld [hl], a
    ei
    ld a, c
    add a, l
    ld l, a
    jr nc, Jump_01E_7683
    inc h

Jump_01E_7683::
    push hl

Jump_01E_7684::
    pop hl
    pop bc
    inc b
    ld a, [$C6FD]
    cp a, b
    jr nz, Jump_01E_7648
    ret

Func_01E_768E::
    ld de, $FFC9
    ld hl, $D7F1
    ld a, [de]
    ld [hl+], a
    dec de
    ld a, [de]
    and a, $F0
    swap a
    ld [hl+], a
    ld a, [de]
    and a, $0F
    ld [hl+], a
    dec de
    ld a, [de]
    and a, $F0
    swap a
    ld [hl+], a
    ld a, [de]
    and a, $0F
    ld [hl+], a
    dec de
    ld a, [de]
    and a, $F0
    swap a
    ld [hl+], a
    ld a, [de]
    and a, $0F
    ld [hl], a
    ld c, $06
    ld hl, $D7F1

Jump_01E_76BC::
    ld a, [hl]
    and a, a
    jr nz, Jump_01E_76C6
    add a, $E3
    ld [hl+], a
    dec c
    jr nz, Jump_01E_76BC

Jump_01E_76C6::
    ret

Func_01E_76C7::
    ld de, $D7F1
    ld c, $07

Jump_01E_76CC::
    di
    call Func_000_120A
    ld a, [de]
    add a, $E0
    ld [hl+], a
    inc de
    ei
    dec c
    jr nz, Jump_01E_76CC
    ret

Func_01E_76DA::
    push hl
    push de
    call Func_000_1FD1
    ld de, $FFC6

Jump_01E_76E2::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_01E_76E2
    pop de
    pop hl
    ret

Func_01E_76EB::
    ld hl, $5D84
    ld b, $1D
    rst $10
    jr Jump_01E_76F9

Func_01E_76F3::
    ld hl, $5DA1
    ld b, $1D
    rst $10

Jump_01E_76F9::
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ret

Func_01E_7702::
    call Func_01E_750F
    ld de, $0020
    add hl, de
    call Func_000_24F8
    ld c, $05

Jump_01E_770E::
    di
    call Func_000_120A
    ld a, $B6
    ld [hl], a
    ei
    ld a, $40
    add a, l
    ld l, a
    jr nc, Jump_01E_771D
    inc h

Jump_01E_771D::
    dec c
    jr nz, Jump_01E_770E
    ld a, $B6
    ld [$C378], a
    ld [$C3A0], a
    ld [$C3C8], a
    ld [$C3F0], a
    ld [$C418], a
    ret

Func_01E_7732::
    ld a, [$D7AB]
    ld l, a
    ld h, $00
    ld a, $04
    call Func_000_16D1
    ld [$D7AB], a
    ld a, l
    ld [$D7AF], a
    ret

Func_01E_7745::
    ldh a, [$FFB9]
    ld [$D7BC], a
    xor a, a
    ldh [$FFB9], a
    ldh [$FFBA], a
    ldh a, [$FF8D]
    ld [$D7BA], a
    ld a, [$CB7D]
    ld [$D7BB], a
    ld a, $FF
    ldh [$FF8D], a
    xor a, a
    ld [$CB7D], a
    ret

Func_01E_7763::
    ld a, [$D7BC]
    ldh [$FFB9], a
    ld a, $80
    ldh [$FFBA], a
    ld a, [$D7BA]
    ldh [$FF8D], a
    ld a, [$D7BB]
    ld [$CB7D], a
    ret

Func_01E_7778::
    xor a, a
    ld b, $C3
    ld hl, Data_01E_788A
    call Func_01E_741A
    ld a, $01
    ld b, $C3
    ld hl, Data_01E_788A
    call Func_01E_741A
    ret

Data_01E_778C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $07B78C, $42

Data_01E_77CE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $07B7CE, $42

Data_01E_7810:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $70, $8A, $80, $8A, $90, $8A, $A0, $8A, $B0, $8A, $C0, $8A, $D0, $8A, $E0, $8A
    db $F0, $8A, $FF, $FF

Data_01E_7824:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $40, $43, $A0, $42, $E0, $40, $70, $42, $F0, $42, $90, $43, $D0, $40, $C0, $42
    db $60, $43, $FF, $FF

Data_01E_7838:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $40, $8A, $50, $8A, $60, $8A, $00, $8F, $10, $8F, $20, $8F, $30, $8F, $40, $8F
    db $E0, $8C, $F0, $8C, $FF, $FF

Data_01E_784E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C0, $41, $D0, $42, $30, $43, $F0, $40, $C0, $43, $80, $43, $80, $41, $A0, $41
    db $30, $42, $90, $42, $FF, $FF

Data_01E_7864:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $97, $10, $97, $20, $97, $30, $97, $40, $97, $50, $97, $FF, $FF

Data_01E_7872:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $30, $41, $20, $43, $A0, $42, $30, $43, $90, $41, $50, $41, $FF, $FF

Data_01E_7880:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $79, $C3, $A1, $C3, $C9, $C3, $F1, $C3, $19, $C4

Data_01E_788A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $20, $C4, $48, $C4

Data_01E_788E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $80, $C3, $A8, $C3, $D0, $C3, $F8, $C3, $20, $C4

Data_01E_7898:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $07B898, $42

Data_01E_78DA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $07B8DA, $42

Data_01E_791C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $70, $41, $30, $43, $20, $43, $80, $43, $70, $43, $90, $42, $60, $43, $F0, $40
    db $B0, $42, $30, $41, $20, $43, $A0, $42, $30, $43, $90, $41, $50, $41, $FF, $FF

Data_01E_793C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C0, $97, $D0, $97, $E0, $97, $F0, $97, $F0, $8D, $E0, $8F, $F0, $8F, $70, $97
    db $80, $97, $00, $97, $10, $97, $20, $97, $30, $97, $40, $97, $50, $97, $FF, $FF

Data_01E_795C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $07B95C, $6C

Data_01E_79C8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $07B9C8, $79

Data_01E_7A41:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1

Data_01E_7A48:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $07BA48, $51

Data_01E_7A99:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $07BA99, $58

Data_01E_7AF1:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $07BAF1, $58

Data_01E_7B49:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $07BB49, $75

Data_01E_7BBE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $07BBBE, $41

Data_01E_7BFF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B1, $B1, $B1, $B2, $A6, $A8, $A8, $B7, $C3, $C3, $C3, $B7, $AC, $A7, $C3, $B7
    db $C3, $C3, $C3, $B7, $C3, $C3, $C3, $B7, $C3, $C3, $C3, $B7, $DF, $CF, $C3, $B7

Data_01E_7C1F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $C3, $C3, $B7, $C3, $C3, $C3, $B7, $B4, $B4, $B4, $B5
    ds $26B, $00

Data_01E_7E96:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $16A, $00
