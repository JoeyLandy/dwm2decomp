SECTION "Bank 14", ROMX[$4000], BANK[$14]
    db $14

Func_014_4001::
    ld a, [$D788]
    rst $00
    dw Func_014_400D
    dw $403F
    dw Func_014_4080
    dw $409E

Func_014_400D:: ; heuristic: target of a pointer table; C0
    ld hl, $C364

Func_014_4010:: ; heuristic: target of a pointer table; C0
    ld de, $C198
    ld bc, $0104
    call Func_014_57E5
    ld a, [$C525]
    and a, a
    jr z, Jump_014_402B
    db $21

Func_014_4020:: ; heuristic: target of a pointer table; C0
    call z, Func_000_11D1
    nop
    ret nc
    ld bc, $0104
    call Func_014_57EE

Jump_014_402B::
    call Func_014_5800
    db $01, $0D

Func_014_4030:: ; heuristic: target of a pointer table; C0
    inc d
    ld de, $01CC
    call Func_014_585B
    ld a, [$D788]
    inc a
    ld [$D788], a
    ret
    db $3E

Func_014_4040:: ; heuristic: target of a pointer table; C0
    sbc a, h
    ld [$D7F1], a
    xor a, a
    ld [$D7F2], a
    ld de, Data_014_6D84
    ld a, d
    ld [$D7F3], a
    ld a, e

Func_014_4050:: ; heuristic: target of a pointer table; C0
    ld [$D7F4], a
    ld hl, $6C14
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    cp a, $FF
    ret nz
    xor a, a

Func_014_4060:: ; heuristic: target of a pointer table; C0
    ld [$D784], a
    ld [$D785], a
    ld [$D780], a
    ld [$D781], a
    ld [$C46B], a
    db $FA

Func_014_4070:: ; heuristic: target of a pointer table; C0
    adc a, b
    rst $10
    inc a
    ld [$D788], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_014_4080:: ; heuristic: target of a pointer table; C0
    ld hl, $8D00
    ld bc, $0F01
    call Func_000_1881
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88

Func_014_4090:: ; heuristic: target of a pointer table; C0
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, [$D788]
    inc a
    ld [$D788], a
    ret
    db $21, $AD

Func_014_40A0:: ; heuristic: target of a pointer table; C0
    ld h, d
    ld b, $1D
    rst $10
    xor a, a
    ld [$D7F0], a
    ld [$D788], a
    ld bc, $006F
    db $21, $80

Func_014_40B0:: ; heuristic: target of a pointer table; C0
    rst $10

Jump_014_40B1::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_014_40B1
    ld a, $80
    ldh [$FFBA], a
    ld hl, $470B
    ld b, $02
    rst $10
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_014_40CC::
    ld a, [$D780]
    rst $00
    dw Jump_014_40E8
    dw Jump_014_412B
    dw Jump_014_418A
    dw $428A
    dw Jump_014_4D64
    dw Jump_014_4446
    dw Jump_014_5492
    dw Jump_014_55C9
    dw Func_014_56A4
    dw Func_014_56A4
    dw Func_014_56A4
    dw Func_014_56A4

Jump_014_40E8::
    ld hl, $D780
    ld bc, $006F

Jump_014_40EE::
    xor a, a
    ld [hl+], a

Func_014_40F0:: ; heuristic: target of a pointer table; C0
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_014_40EE
    ld hl, $C364
    ld de, $C198
    ld bc, $0104
    db $CD, $E5

Func_014_4100:: ; heuristic: target of a pointer table; C0
    ld d, a
    ld a, [$C525]
    and a, a
    jr z, Jump_014_4113
    ld hl, $D1CC
    ld de, $D000
    ld bc, $0104

Func_014_4110:: ; heuristic: target of a pointer table; C0
    call Func_014_57EE

Jump_014_4113::
    ld a, $04
    ld [$D7F0], a
    ld a, $70
    ldh [$FFBA], a
    xor a, a
    ld hl, $D780

Func_014_4120:: ; heuristic: target of a pointer table; C0
    inc [hl]
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_014_412B::
    ld a, [$D781]
    rst $00
    dw Func_014_4137
    dw $413E
    dw $414F
    dw Func_014_415D

Func_014_4137:: ; heuristic: target of a pointer table; C0
    ld hl, $6C8A
    ld b, $1D
    rst $10
    ret
    db $21, $28

Func_014_4140:: ; heuristic: target of a pointer table; C0
    ld e, d
    ld de, Data_014_5A84
    call Func_014_5898
    cp a, $FF
    ret nz
    ld hl, $D781
    inc [hl]
    ret
    db $21

Func_014_4150:: ; heuristic: target of a pointer table; C0
    ld a, c
    ld e, [hl]
    ld b, $1D
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_014_415D:: ; heuristic: target of a pointer table; C0
    ld de, Data_014_5AC4

Func_014_4160:: ; heuristic: target of a pointer table; C0
    ld hl, $C364
    ld bc, $0A09
    call Func_014_5821
    call Func_014_5910
    call Func_014_5800
    ld bc, $140B
    ld de, $01CC
    call Func_014_585B
    ld hl, $5E3F
    ld b, $1D
    rst $10
    xor a, a
    ld [$D781], a
    ld a, [$D780]
    inc a
    ld [$D780], a
    ret

Jump_014_418A::
    ld a, [$C563]
    bit 6, a
    db $20

Func_014_4190:: ; heuristic: target of a pointer table; C0
    dec d
    bit 7, a
    jr nz, Jump_014_41D4
    ld a, [$C562]
    bit 0, a
    jp nz, Jump_014_41EE
    bit 1, a
    jp nz, Func_014_4230
    call $423F
    ret
    db $CD, $5D, $42, $FA, $86, $D7, $A7, $20, $0E, $3E

Func_014_41B0:: ; heuristic: target of a pointer table; C0
    inc bc
    ld [$D786], a
    call $423F
    ld a, $69
    call Func_000_1278
    ret
    db $3D

Jump_014_41BE::
    ld [$D786], a
    xor a, a
    ld [$D7AB], a
    ld [$D7AD], a
    ld [$D7AF], a
    call Func_014_4259
    ld a, $69
    call Func_000_1278
    ret

Jump_014_41D4::
    call Func_014_425D
    ld a, [$D786]
    cp a, $03
    jr c, Jump_014_41EB
    xor a, a
    db $EA

Func_014_41E0:: ; heuristic: target of a pointer table; C0
    add a, [hl]
    rst $10
    call $423F
    ld a, $69
    call Func_000_1278
    ret

Jump_014_41EB::
    inc a
    jr Jump_014_41BE

Jump_014_41EE::
    ld a, $69

Func_014_41F0:: ; heuristic: target of a pointer table; C0
    call Func_000_1278
    call Func_014_4261
    ld c, $00

Jump_014_41F8::
    ld a, c
    ld b, $C3
    ld hl, Data_014_5B1E
    push bc
    push hl

Func_014_4200:: ; heuristic: target of a pointer table; C0
    call Func_014_5902
    pop hl
    pop bc
    inc c
    ld a, c
    cp a, $04
    jr c, Jump_014_41F8
    ld a, [$D786]
    cp a, $03

Func_014_4210:: ; heuristic: target of a pointer table; C0
    jr z, Func_014_4230
    ld [$D7FA], a
    ld a, [$D780]
    inc a
    ld [$D780], a
    xor a, a
    ld [$D7AB], a

Func_014_4220:: ; heuristic: target of a pointer table; C0
    ld [$D7AD], a
    ld [$D7AF], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_014_4230:: ; heuristic: target of a pointer table; C0
    ld a, $03
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret
    db $FA

Func_014_4240:: ; heuristic: target of a pointer table; C0
    ld h, h
    push bc
    cp a, $14
    jr c, Func_014_4259
    ld a, [$D787]
    inc a
    ld [$D787], a
    cp a, $10
    jr c, Func_014_4259
    cp a, $18
    jr c, Func_014_425D
    xor a, a
    ld [$D787], a

Func_014_4259::
    ld b, $BB
    jr Jump_014_4263

Func_014_425D::
    ld b, $C3
    db $18

Func_014_4260:: ; heuristic: target of a pointer table; C0
    ld [bc], a

Func_014_4261::
    ld b, $BC

Jump_014_4263::
    ld a, [$D786]
    add a, a
    ld hl, Func_014_4280
    add a, l
    ld l, a
    jr nc, Jump_014_426F
    inc h

Jump_014_426F::
    ld e, [hl]

Func_014_4270:: ; heuristic: target of a pointer table; C0
    inc hl
    ld d, [hl]
    push de
    call Func_014_5800
    pop de
    add hl, de
    di
    call Func_000_120A
    ld a, b
    ld [hl], a
    ei
    ret

Func_014_4280:: ; heuristic: target of a pointer table; C0
    ld hl, $6100
    nop
    and a, c
    nop
    pop hl
    nop
    ld hl, $FA01
    add a, [hl]
    rst $10
    and a, a
    jr z, Jump_014_429B

Func_014_4290:: ; heuristic: target of a pointer table; C0
    cp a, $01
    jp z, Jump_014_4309
    cp a, $02
    jp z, Jump_014_4409
    ret

Jump_014_429B::
    ld hl, $5ECE
    ld b, $1D

Func_014_42A0:: ; heuristic: target of a pointer table; C0
    rst $10
    ld a, [$D780]
    inc a
    ld [$D780], a
    ld a, [$D7A9]
    and a, a
    jr z, Jump_014_42F1
    db $21, $F8

Func_014_42B0:: ; heuristic: target of a pointer table; C0
    ld l, l
    ld b, $1D
    rst $10
    ld hl, Data_014_6D70
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    cp a, c
    jr c, Jump_014_42DA

Func_014_42C0:: ; heuristic: target of a pointer table; C0
    ld a, $1E
    ld [$D781], a
    xor a, a
    ld [$D7FA], a
    xor a, a
    ld [$D7AF], a
    ld [$D7AB], a

Func_014_42D0:: ; heuristic: target of a pointer table; C0
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_014_42DA::
    xor a, a
    ld [$D781], a
    ld a, $02

Func_014_42E0:: ; heuristic: target of a pointer table; C0
    ld [$D7FA], a
    xor a, a
    ld [$D7AF], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_014_42F1::
    ld a, $01
    ld [$D7FA], a
    ld a, $02
    ld [$D780], a
    xor a, a
    ld [$D781], a
    xor a, a

Func_014_4300:: ; heuristic: target of a pointer table; C0
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_014_4309::
    ld hl, Data_014_6DF8
    ld b, $1D
    rst $10
    db $FA

Func_014_4310:: ; heuristic: target of a pointer table; C0
    push af
    rst $10
    and a, a
    jp z, Jump_014_43B1
    ld hl, $5F2D
    ld b, $1D
    rst $10
    ld hl, Data_014_6D70
    ld b, $1D
    rst $10
    ld a, [$D7A9]
    cp a, c
    jr nc, Jump_014_4339
    ld b, a
    ld a, [$D7B9]
    cp a, c
    jr nc, Jump_014_4396
    add a, b

Func_014_4330:: ; heuristic: target of a pointer table; C0
    cp a, c
    jr c, Jump_014_4359
    ld a, [$C6FD]
    cp a, b
    jr z, Jump_014_437B

Jump_014_4339::
    ld a, $01
    ld [$D7FA], a
    xor a, a
    ld [$D782], a
    ld a, $1B
    ld [$D781], a
    ld a, [$D780]
    inc a
    inc a
    ld [$D780], a
    xor a, a

Func_014_4350:: ; heuristic: target of a pointer table; C0
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_014_4359::
    ld hl, $5ECE
    ld b, $1D
    rst $10
    xor a, a

Func_014_4360:: ; heuristic: target of a pointer table; C0
    ld [$D7FA], a
    ld [$D782], a
    ld [$D781], a
    ld a, [$D780]
    inc a
    inc a
    ld [$D780], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_014_437B::
    ld a, $04

Func_014_437D:: ; heuristic: target of a pointer table; C0
    ld [$D7FA], a

Func_014_4380:: ; heuristic: target of a pointer table; C0
    xor a, a
    ld [$D782], a
    ld [$D781], a
    ld a, $02
    ld [$D780], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_014_4396::
    ld a, $02
    ld [$D7FA], a
    xor a, a
    ld [$D782], a
    db $EA

Func_014_43A0:: ; heuristic: target of a pointer table; C0
    add a, c
    rst $10
    ld a, $02
    ld [$D780], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_014_43B1::
    ld a, $03
    ld [$D7FA], a
    xor a, a
    ld [$D782], a
    ld [$D781], a
    ld a, $02
    ld [$D780], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret
    db $21, $CE, $5E, $06

Func_014_43D0:: ; heuristic: target of a pointer table; C0
    dec e
    rst $10
    ld a, [$D7A9]
    and a, a
    jr nz, Jump_014_43F3
    ld a, $01
    ld [$D7FA], a
    ld a, $02
    db $EA

Func_014_43E0:: ; heuristic: target of a pointer table; C0
    add a, b
    rst $10
    xor a, a
    ld [$D781], a
    ld [$D782], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_014_43F3::
    xor a, a
    ld [$D7FA], a
    ld a, [$D780]
    add a, $03
    ld [$D780], a
    xor a, a

Func_014_4400:: ; heuristic: target of a pointer table; C0
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_014_4409::
    ld hl, Data_014_6DF8
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    and a, a
    jr nz, Jump_014_4430
    ld a, $01
    ld [$D7FA], a
    ld a, $02
    ld [$D780], a
    xor a, a
    ld [$D781], a
    ld [$D782], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_014_4430::
    xor a, a
    ld [$D7FA], a
    ld a, [$D780]
    add a, $04
    ld [$D780], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_014_4446::
    ld a, [$D781]
    rst $00
    dw Func_014_4A75
    dw Func_014_4B5A
    dw Func_014_4DFE
    dw Func_014_4E07
    dw Func_014_4E0E
    dw Func_014_46F4
    dw Func_014_4E46
    dw Func_014_4718
    dw Func_014_51E9
    dw Func_014_4742
    dw $475E
    dw Func_014_4772
    dw Func_014_4A75
    dw Func_014_4CA8
    dw Func_014_4CBC
    dw Func_014_4D2B
    dw Func_014_4F51
    dw $5601
    dw Func_014_5002
    dw Func_014_5095
    dw Func_014_4742
    dw $475E
    dw Func_014_4772
    dw Func_014_4A75
    dw Func_014_4CA8
    dw Func_014_4CBC
    dw Func_014_4D2B
    dw Func_014_496D
    dw Func_014_49CC
    dw Func_014_4A75
    dw Func_014_4B5A
    dw Func_014_4B92
    dw Func_014_4BE3
    dw Func_014_4BEA
    dw Func_014_46F4
    dw Func_014_4C1C
    dw Func_014_4718
    dw Func_014_4C3C
    dw Func_014_4742
    dw $475E
    dw Func_014_4772
    dw Func_014_4A75
    dw Func_014_4CA8
    dw Func_014_4CBC
    dw Func_014_4CD0
    dw Func_014_4783
    dw Func_014_4794
    dw Func_014_47E8
    dw Func_014_4932
    dw Func_014_4D10
    dw Func_014_44DA
    dw Func_014_4A75
    dw Func_014_4B5A
    dw Func_014_4DFE
    dw Func_014_4E07
    dw Func_014_4E0E
    dw Func_014_46F4
    dw Func_014_4E46
    dw Func_014_4718
    dw Func_014_52E4
    dw Func_014_450C
    dw Func_014_4F51
    dw Func_014_4590
    dw $45DE
    dw Func_014_46A1
    dw Func_014_4742
    dw $475E
    dw Func_014_4772
    dw Func_014_4A75
    dw Func_014_4CA8
    dw Func_014_4CBC
    dw Func_014_4D2B

Func_014_44DA:: ; heuristic: target of a pointer table; C0
    call Func_014_4932
    ld hl, $5ECE
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld a, [hl]
    ld [$D7B4], a
    db $FA

Func_014_44F0:: ; heuristic: target of a pointer table; C0
    xor a, e
    rst $10
    ld [$D7B5], a
    ld a, [$D7AF]
    ld [$D7B6], a
    ld a, [$D7B4]
    ld b, a
    ld c, $00
    call Func_014_56B0
    xor a, a
    ld [$D7AB], a
    ld [$D7AF], a
    ret

Func_014_450C:: ; heuristic: target of a pointer table; C0
    call Func_014_5800
    push hl

Func_014_4510:: ; heuristic: target of a pointer table; C0
    ld a, [$D7AB]
    add a, a
    ld hl, Data_014_4586
    add a, l
    ld l, a
    jr nc, Jump_014_451C
    inc h

Jump_014_451C::
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    add hl, de
    di
    call Func_000_120A
    ld a, $BC
    ld [hl], a
    ei
    ld a, [$D7B5]
    ld [$D7AB], a
    ld a, [$D7B6]
    ld [$D7AF], a
    ld hl, $5ECE
    ld b, $1D
    rst $10
    call Func_014_4BA0
    db $CD, $EE

Func_014_4540:: ; heuristic: target of a pointer table; C0
    ld e, b
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
    ld a, $01
    ld [$D7FA], a
    ld a, $20
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

Data_014_4586:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $21, $00, $61, $00, $A1, $00, $E1, $00, $21, $01

Func_014_4590:: ; heuristic: target of a pointer table; C0
    ld hl, $6540
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_014_45B8
    cp a, $FF
    jp z, Jump_014_45A5
    ret

Jump_014_45A5::
    ld a, [$D7FA]
    cp a, $01
    jr z, Jump_014_45B8
    ld hl, $5CA3
    db $06

Func_014_45B0:: ; heuristic: target of a pointer table; C0
    dec e
    rst $10
    call Func_014_56EB
    jp Jump_014_4EA7

Jump_014_45B8::
    call Func_014_4EBF
    ld a, [$D7AB]
    ld b, $C3

Func_014_45C0:: ; heuristic: target of a pointer table; C0
    ld hl, Data_014_5B1E
    call Func_014_5902
    ld a, $01
    ld [$D7FA], a
    ld a, $3B
    ld [$D781], a

Func_014_45D0:: ; heuristic: target of a pointer table; C0
    xor a, a
    ld [$D782], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret
    db $FA, $82

Func_014_45E0:: ; heuristic: target of a pointer table; C0
    rst $10
    and a, a
    jp nz, Jump_014_4630
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld a, [$D7B4]
    ld [$D7F1], a
    xor a, a
    ld [$1FFF], a
    ld [$D7F2], a
    ld hl, $C986
    ld a, l
    db $EA

Func_014_4600:: ; heuristic: target of a pointer table; C0
    di
    rst $10
    ld a, h
    ld [$D7F4], a
    ld hl, $6E39
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    cp a, $FF
    ret nz
    ld a, [$D7B4]
    ld [$D7F1], a
    xor a, a
    ld [$D7F2], a
    ld hl, Func_014_7E96
    ld b, $14
    rst $10
    ld a, [$D7F5]
    ld [$D7B4], a
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_014_4630::
    ld hl, $5D84
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld a, [hl]
    cp a, $1D
    jr z, Jump_014_464F
    ld c, $6F
    call Func_000_1682
    ld de, $B356
    add hl, de
    xor a, a
    jr Jump_014_4654

Jump_014_464F::
    ld hl, $A000
    ld a, $01

Jump_014_4654::
    ld [$D7F2], a
    push hl
    ld a, [$D7B4]
    ld [$D7F1], a
    pop hl
    ld a, l

Func_014_4660:: ; heuristic: target of a pointer table; C0
    ld [$D7F3], a
    ld a, h
    ld [$D7F4], a
    ld hl, Data_014_7492
    ld b, $1D
    rst $10
    ld a, [$D7F5]

Func_014_4670:: ; heuristic: target of a pointer table; C0
    cp a, $FF
    ret nz
    ld hl, $5D84
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]

Func_014_4680:: ; heuristic: target of a pointer table; C0
    ld l, a
    ld a, [hl]
    ld [$D7F1], a
    xor a, a
    ld [$D7F2], a
    ld hl, Func_014_7D7F
    ld b, $14
    rst $10
    ld a, [$D7F5]
    ld [$D7B4], a
    xor a, a
    ld [$D782], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_014_46A1:: ; heuristic: target of a pointer table; C0
    ld a, $0A
    ld [$1FFF], a
    ld a, [$D7B4]
    cp a, $1D
    jr z, Jump_014_46B9
    ld c, $6F
    call Func_000_1682
    ld de, $B356
    add hl, de
    xor a, a
    jr Jump_014_46BE

Jump_014_46B9::
    ld hl, $A000
    ld a, $01

Jump_014_46BE::
    ld [$4100], a
    ld de, $C986
    ld b, $6F

Jump_014_46C6::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_014_46C6
    xor a, a
    ld [$1FFF], a
    xor a, a
    ld [$D7B5], a
    ld [$D7B6], a
    ld [$D7B4], a
    ld hl, $5E79
    ld b, $1D
    rst $10

Func_014_46E0:: ; heuristic: target of a pointer table; C0
    call Func_014_4932
    xor a, a
    ld [$D7AB], a
    ld [$D7AD], a
    ld [$D7AF], a
    ld [$D7AC], a
    ld [$D7AE], a
    ret

Func_014_46F4:: ; heuristic: target of a pointer table; C0
    ld hl, $8A70
    ld bc, $0901
    call Func_000_1881
    ld hl, $8F80

Func_014_4700:: ; heuristic: target of a pointer table; C0
    ld bc, $0501
    call Func_000_1881
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02

Func_014_4710:: ; heuristic: target of a pointer table; C0
    ld [hl+], a
    ld [hl], $12
    ld hl, $D781
    inc [hl]
    ret

Func_014_4718:: ; heuristic: target of a pointer table; C0
    ld a, [$D7AB]
    ld b, $BB
    ld hl, Data_014_5B1E

Func_014_4720:: ; heuristic: target of a pointer table; C0
    call Func_014_5902
    call Func_014_5800
    ld bc, $140B
    ld de, $01CC
    call Func_014_585B
    db $FA

Func_014_4730:: ; heuristic: target of a pointer table; C0
    xor a, e
    rst $10
    ld b, $C3
    ld hl, Data_014_5B1E
    call Func_014_5902
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_014_4742:: ; heuristic: target of a pointer table; C0
    ld c, $0D
    ld hl, $01D4
    ld de, $0008
    xor a, a
    ld [$D7F1], a
    ld a, $0C

Func_014_4750:: ; heuristic: target of a pointer table; C0
    ld [$D7F2], a
    call Func_014_5925
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret
    db $CD, $00

Func_014_4760:: ; heuristic: target of a pointer table; C0
    ld e, b
    ld bc, $140D
    ld de, $01CC
    call Func_014_585B
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_014_4772:: ; heuristic: target of a pointer table; C0
    ld hl, Data_014_5C36
    ld de, Data_014_5C4A
    call Func_014_5898
    cp a, $FF
    ret nz
    ld hl, $D781
    inc [hl]
    ret

Func_014_4783:: ; heuristic: target of a pointer table; C0
    ld hl, Data_014_5C8A
    ld de, Data_014_5C9A
    call Func_014_5898
    cp a, $FF
    ret nz
    ld hl, $D781
    inc [hl]
    ret

Func_014_4794:: ; heuristic: target of a pointer table; C0
    ld de, Data_014_47C0
    ld hl, $C410
    ld bc, $0805
    call Func_014_5821
    call Func_014_5800
    ld bc, $140D
    ld de, $01CC
    call Func_014_585B
    ld a, $6C
    call Func_000_1278
    xor a, a
    ld [$D7AD], a
    ld [$D7AE], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Data_014_47C0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $70, $71, $72, $73, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $74, $75, $C3, $C3, $C3, $B7

Func_014_47E0:: ; heuristic: target of a pointer table; C0
    or a, e
    or a, h
    or a, h
    or a, h
    or a, h
    or a, h
    or a, h
    or a, l

Func_014_47E8:: ; heuristic: target of a pointer table; C0
    ld a, [$C563]
    bit 6, a
    jr nz, Jump_014_4804
    db $CB

Func_014_47F0:: ; heuristic: target of a pointer table; C0
    ld a, a
    jr nz, $481E
    ld a, [$C562]
    bit 0, a
    jp nz, Jump_014_482E
    bit 1, a
    jp nz, Jump_014_48D7

Func_014_4800:: ; heuristic: target of a pointer table; C0
    call Func_014_48ED
    ret

Jump_014_4804::
    call Func_014_490B
    ld a, [$D7AD]
    and a, a
    jr nz, $4811
    ld a, $01
    db $18

Func_014_4810:: ; heuristic: target of a pointer table; C0
    ld bc, $EA3D
    xor a, l
    rst $10
    call Func_014_4907
    ld a, $69
    call Func_000_1278
    ret
    db $CD, $0B

Func_014_4820:: ; heuristic: target of a pointer table; C0
    ld c, c
    ld a, [$D7AD]
    cp a, $01
    jr c, Jump_014_482B
    xor a, a
    jr $4812

Jump_014_482B::
    inc a
    jr $4812

Jump_014_482E::
    ld a, $69

Func_014_4830:: ; heuristic: target of a pointer table; C0
    call Func_000_1278
    call Func_014_490F
    ld a, [$D7AD]
    and a, a
    jp nz, Jump_014_48AC
    ld a, [$D780]

Func_014_4840:: ; heuristic: target of a pointer table; C0
    cp a, $05
    jr z, Jump_014_486D
    cp a, $04
    jr z, Jump_014_4848

Jump_014_4848::
    ld a, [$D781]
    cp a, $13
    jr c, Jump_014_485E
    db $3E

Func_014_4850:: ; heuristic: target of a pointer table; C0
    inc b
    ld [$D7B2], a
    ld a, $3F
    ld [$D7B3], a
    ld a, $09
    jp Jump_014_488F

Jump_014_485E::
    ld a, $04

Func_014_4860:: ; heuristic: target of a pointer table; C0
    ld [$D7B2], a
    ld a, $12
    ld [$D7B3], a
    ld a, $09
    jp Jump_014_488F

Jump_014_486D::
    ld a, [$D781]

Func_014_4870:: ; heuristic: target of a pointer table; C0
    cp a, $2E
    jr c, Jump_014_4883
    ld a, $05
    ld [$D7B2], a
    ld a, $2F
    ld [$D7B3], a
    ld a, $09

Func_014_4880:: ; heuristic: target of a pointer table; C0
    jp Jump_014_488F

Jump_014_4883::
    ld a, $04
    ld [$D7B2], a
    ld a, $25
    ld [$D7B3], a
    ld a, $09

Jump_014_488F::
    ld [$D780], a
    xor a, a
    ld [$D781], a
    ld [$D782], a
    ld [$D7FA], a
    ld hl, Data_014_7745
    ld b, $1E
    rst $10
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_014_48AC::
    ld a, [$D780]
    cp a, $04
    jr nz, Func_014_48C0
    ld a, [$D781]
    cp a, $3F
    jr nz, Func_014_48C0
    call Func_014_578E
    call Func_014_574E

Func_014_48C0:: ; heuristic: target of a pointer table; C0
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

Jump_014_48D7::
    ld a, $02
    ld [$D7FA], a
    ld a, [$D781]
    inc a

Func_014_48E0:: ; heuristic: target of a pointer table; C0
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_014_48ED::
    ld a, [$C564]

Func_014_48F0:: ; heuristic: target of a pointer table; C0
    cp a, $14
    jr c, Func_014_4907
    ld a, [$D7AE]
    inc a
    ld [$D7AE], a
    cp a, $10
    jr c, Func_014_4907
    cp a, $18
    jr c, Func_014_490B
    xor a, a
    ld [$D7AE], a

Func_014_4907::
    ld b, $BB
    jr Jump_014_4911

Func_014_490B::
    ld b, $C3
    jr Jump_014_4911

Func_014_490F::
    ld b, $BC

Jump_014_4911::
    ld a, [$D7AD]
    add a, a
    ld hl, Data_014_492E
    add a, l
    ld l, a
    jr nc, Jump_014_491D
    inc h

Jump_014_491D::
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call Func_014_5800
    pop de
    add hl, de
    di
    call Func_000_120A
    ld a, b
    ld [hl], a
    ei
    ret

Data_014_492E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2D, $01, $6D, $01

Func_014_4932:: ; heuristic: target of a pointer table; C0
    ld de, Data_014_4965
    ld hl, $C410
    ld bc, $0801
    call Func_014_5821
    ld c, $04
    ld hl, $028C
    ld de, $00C0
    xor a, a
    ld [$D7F1], a
    ld a, $08
    ld [$D7F2], a
    call Func_014_5925
    ld a, [$D7AB]
    ld b, $C3
    ld hl, Data_014_5B1E
    call Func_014_5902
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Data_014_4965:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Func_014_496D:: ; heuristic: target of a pointer table; C0
    ld de, Data_01F_4330
    ld hl, $9730
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld a, $6C
    db $CD

Func_014_497D:: ; heuristic: target of a pointer table; C0
    ld a, b
    ld [de], a
    ld de, Data_014_49AE
    ld hl, $C412
    ld bc, $0605
    call Func_014_5821
    ld a, [$D786]
    ld b, $BC

Func_014_4990:: ; heuristic: target of a pointer table; C0
    ld hl, Data_014_5B1E
    call Func_014_5902
    call Func_014_5800
    ld bc, $140D
    ld de, $01CC
    call Func_014_585B
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$D7FA], a
    ret

Data_014_49AE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $CE, $CF, $DF, $B7, $B6, $C3, $C3, $C3
    db $C3, $B7, $B6, $C3, $EF, $73, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B5

Func_014_49CC:: ; heuristic: target of a pointer table; C0
    ld hl, $6540
    db $06

Func_014_49D0:: ; heuristic: target of a pointer table; C0
    dec e
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_014_49E0
    cp a, $FF
    jr z, Func_014_4A00
    ret

Jump_014_49E0::
    call Func_014_4A1F
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

Func_014_4A00:: ; heuristic: target of a pointer table; C0
    ld a, [$D7FA]
    cp a, $01
    jr z, Jump_014_49E0
    call Func_014_4A1F
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

Func_014_4A1F::
    ld hl, $C412
    ld de, $C246
    ld c, $00
    call Func_014_4A54
    ld a, [$C525]
    and a, a
    jr z, Jump_014_4A47
    ldh a, [$FF70]
    set 1, a
    ldh [$FF70], a
    ld hl, $D27A
    ld de, $D0AE
    ld c, $00
    call Func_014_4A54
    ldh a, [$FF70]
    res 1, a
    ldh [$FF70], a

Jump_014_4A47::
    call Func_014_5800
    ld bc, $140D
    ld de, $01CC
    call Func_014_585B
    ret

Func_014_4A54::
    push hl
    push de
    push bc
    ld bc, $0006
    call Func_014_57E5
    pop bc
    pop de
    pop hl
    ld a, $14
    add a, l
    ld l, a
    jr nc, Jump_014_4A67
    inc h

Jump_014_4A67::
    ld a, $14
    add a, e
    ld e, a
    jr nc, Jump_014_4A6E
    inc d

Jump_014_4A6E::
    inc c
    ld a, c

Func_014_4A70:: ; heuristic: target of a pointer table; C0
    cp a, $05
    jr c, Func_014_4A54
    ret

Func_014_4A75:: ; heuristic: target of a pointer table; C0
    ld de, Data_014_4AA8
    ld hl, $C364
    ld bc, $0A09
    call Func_014_5821
    ld de, Data_014_4B02
    ld hl, $C364
    ld bc, $080B
    call Func_014_5821
    call Func_014_5800
    ld bc, $140D
    ld de, $01CC
    call Func_014_585B
    xor a, a
    ld [$D7AF], a
    ld [$D7AE], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Data_014_4AA8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $050AA8, $5A

Data_014_4B02:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $050B02, $58

Func_014_4B5A:: ; heuristic: target of a pointer table; C0
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
    ld de, Data_014_5B36
    ld hl, $C364
    ld bc, $080B
    call Func_014_5821
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_014_4B92:: ; heuristic: target of a pointer table; C0
    ld hl, $5ECE
    ld b, $1D
    rst $10
    jr Func_014_4BA0
    db $21, $2D, $5F, $06, $1D, $D7

Func_014_4BA0::
    ld hl, Data_014_7163
    ld b, $1E
    rst $10
    ld a, [$D7B0]
    cp a, $02
    jr c, Jump_014_4BDB
    ld de, $0142
    call Func_014_599F
    ld hl, $C42E
    call Func_014_59C2
    ld de, $0143
    ld a, d
    ld [$D7F1], a
    ld a, e
    ld [$D7F2], a
    ld hl, Data_014_7564
    ld b, $1E
    rst $10
    ld hl, $C42F
    ld a, h
    ld [$D7F1], a
    ld a, l
    ld [$D7F2], a
    ld hl, Data_014_759A
    ld b, $1E
    rst $10

Jump_014_4BDB::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_014_4BE3:: ; heuristic: target of a pointer table; C0
    ld hl, Data_014_5C15
    ld b, $1F
    rst $10
    ret

Func_014_4BEA:: ; heuristic: target of a pointer table; C0
    ld hl, $5D84
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld a, [hl]
    ld b, a
    push af
    call Func_014_5979
    ld de, Data_014_5B8E
    ld hl, $C36C
    ld bc, $0C09
    call Func_014_5821
    pop af
    ld [$D7F1], a
    ld hl, Data_014_5B4D
    ld b, $1D
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_014_4C1C:: ; heuristic: target of a pointer table; C0
    ld hl, $5D84
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld a, [hl]
    ld [$D7F1], a
    ld hl, $5CD7
    ld b, $1D
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_014_4C3C:: ; heuristic: target of a pointer table; C0
    xor a, a
    ld [$D7F9], a
    ld hl, $66B6
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_014_4C60
    cp a, $FC
    jr z, Jump_014_4C60
    cp a, $FD
    jr z, Jump_014_4C9F
    cp a, $FE
    jr z, Jump_014_4C69
    cp a, $FF
    jr z, Jump_014_4C71
    ret

Jump_014_4C60::
    ld a, [$D781]
    sub a, $07
    ld [$D781], a
    ret

Jump_014_4C69::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_014_4C71::
    ld a, [$D781]
    add a, $08
    ld [$D781], a
    xor a, a
    ld [$D7FA], a
    ld a, [$D7AB]
    ld b, $BC
    ld hl, Data_014_5B1E
    call Func_014_5902
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

Jump_014_4C9F::
    ld a, [$D781]
    sub a, $04
    ld [$D781], a
    ret

Func_014_4CA8:: ; heuristic: target of a pointer table; C0
    ld hl, Data_014_5C5E
    ld de, Data_014_5C74
    call Func_014_5898
    cp a, $FF
    ret nz
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_014_4CBC:: ; heuristic: target of a pointer table; C0
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

Func_014_4CD0:: ; heuristic: target of a pointer table; C0
    ld de, Data_014_5AC4
    ld hl, $C364
    ld bc, $0A09
    call Func_014_5821
    call Func_014_5910
    ld a, [$D786]
    ld b, $C3
    ld hl, Data_014_5B1E
    call Func_014_5902
    call Func_014_5800
    ld bc, $140B
    ld de, $01CC
    call Func_014_585B
    ld hl, $5E3F
    ld b, $1D
    rst $10
    ld a, $1B
    ld [$D781], a
    ld a, $01
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_014_4D10:: ; heuristic: target of a pointer table; C0
    call Func_014_5800
    ld bc, $140D
    ld de, $01CC
    call Func_014_585B
    ld a, $25
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_014_4D2B:: ; heuristic: target of a pointer table; C0
    ld de, Data_014_5AC4
    ld hl, $C364
    ld bc, $0A09
    call Func_014_5821
    call Func_014_5910
    call Func_014_5800
    ld bc, $140B
    ld de, $01CC
    call Func_014_585B
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

Jump_014_4D64::
    ld a, [$D781]
    rst $00
    dw Func_014_4A75
    dw Func_014_4B5A
    dw Func_014_4B92
    dw Func_014_4BE3
    dw Func_014_4BEA
    dw Func_014_46F4
    dw Func_014_4C1C
    dw Func_014_4718
    dw Func_014_4C3C
    dw Func_014_4742
    dw $475E
    dw Func_014_4772
    dw Func_014_4A75
    dw Func_014_4CA8
    dw Func_014_4CBC
    dw Func_014_4D2B
    dw Func_014_4783
    dw Func_014_4794
    dw Func_014_47E8
    dw Func_014_4932
    dw Func_014_5104
    dw Func_014_511F
    dw Func_014_5171
    dw Func_014_4742
    dw $475E
    dw Func_014_4772
    dw Func_014_4A75
    dw Func_014_4CA8
    dw Func_014_4CBC
    dw Func_014_4D2B
    dw Func_014_496D
    dw Func_014_49CC
    dw Func_014_4A75
    dw Func_014_4B5A
    dw Func_014_4DFE
    dw Func_014_4E07
    dw Func_014_4E0E
    dw Func_014_46F4
    dw Func_014_4E46
    dw Func_014_4718
    dw Func_014_51E9
    dw Func_014_4742
    dw $475E
    dw Func_014_4772
    dw Func_014_4A75
    dw Func_014_4CA8
    dw Func_014_4CBC
    dw Func_014_525C
    dw Func_014_4F51
    dw Func_014_4E66
    dw Func_014_529C
    dw Func_014_4A75
    dw Func_014_4B5A
    dw Func_014_4B92
    dw Func_014_4BE3
    dw Func_014_4BEA
    dw Func_014_46F4
    dw Func_014_4C1C
    dw Func_014_4718
    dw Func_014_52E4
    dw Func_014_4FCC
    dw Func_014_4783
    dw Func_014_4794
    dw Func_014_47E8
    dw Func_014_4932
    dw Func_014_5371
    dw Func_014_538C
    dw Func_014_543F
    dw Func_014_4742
    dw $475E
    dw Func_014_4772
    dw Func_014_4A75
    dw Func_014_4CA8
    dw Func_014_4CBC
    dw Func_014_4D2B

Func_014_4DFE:: ; heuristic: target of a pointer table; C0
    ld hl, Data_014_77AC
    ld b, $15
    rst $10
    jp Func_014_4BA0

Func_014_4E07:: ; heuristic: target of a pointer table; C0
    ld hl, Data_014_77FB
    ld b, $15
    rst $10
    ret

Func_014_4E0E:: ; heuristic: target of a pointer table; C0
    ld hl, $5D84
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld a, [hl]
    ld b, a
    push af
    ld [$D7F1], a
    ld hl, $7954
    ld b, $15
    rst $10
    ld de, Data_014_5B8E
    ld hl, $C36C
    ld bc, $0C09
    call Func_014_5821
    pop af
    ld [$D7F1], a
    ld hl, $7976
    ld b, $15
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_014_4E46:: ; heuristic: target of a pointer table; C0
    ld hl, $5D84
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld a, [hl]
    ld [$D7F1], a
    ld hl, Data_014_7A5F
    ld b, $15
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_014_4E66:: ; heuristic: target of a pointer table; C0
    ld hl, $6540
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_014_4E7A
    cp a, $FF
    jr z, Jump_014_4EA0
    ret

Jump_014_4E7A::
    ld a, [$D7AB]
    ld b, $C3
    ld hl, Data_014_5B1E
    call Func_014_5902
    call Func_014_4EBF
    ld a, $01
    ld [$D7FA], a
    ld a, $28
    ld [$D781], a
    xor a, a
    ld [$D782], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_014_4EA0::
    ld a, [$D7FA]
    cp a, $01
    jr z, Jump_014_4E7A

Jump_014_4EA7::
    call Func_014_4EBF
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

Func_014_4EBF::
    ld hl, $C412
    ld de, $C246
    ld c, $00
    call Func_014_4F30
    ld hl, $C412
    ld de, Data_014_4F24
    ld c, $04
    call Func_014_4F30
    ld a, [$C525]
    and a, a
    jr z, Jump_014_4EFD
    ldh a, [$FF70]
    set 1, a
    ldh [$FF70], a
    ld hl, $D27A
    ld de, $D0AE
    ld c, $00
    call Func_014_4F30
    ld hl, $D27A
    ld de, Data_014_4F2A
    ld c, $04
    call Func_014_4F30
    ldh a, [$FF70]
    res 1, a
    ldh [$FF70], a

Jump_014_4EFD::
    call Func_014_5800
    ld bc, $140D
    ld de, $01CC
    call Func_014_585B
    ld de, Data_01F_4130
    ld hl, $9700
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4320
    ld hl, $9710
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ret

Data_014_4F24:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B4, $B4, $B4, $B4, $B4, $B5

Data_014_4F2A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $00, $00

Func_014_4F30::
    push hl
    push de
    push bc
    ld bc, $0006
    call Func_014_57E5
    pop bc
    pop de
    pop hl
    ld a, $14
    add a, l
    ld l, a
    jr nc, Jump_014_4F43
    inc h

Jump_014_4F43::
    ld a, $14
    add a, e
    ld e, a
    jr nc, Jump_014_4F4A
    inc d

Jump_014_4F4A::
    inc c
    ld a, c
    cp a, $05
    jr c, Func_014_4F30
    ret

Func_014_4F51:: ; heuristic: target of a pointer table; C0
    ld de, Data_01F_4330
    ld hl, $9730
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld a, $6C
    call Func_000_1278
    ld de, Data_01F_4FAE
    ld hl, $C412
    ld bc, $0605
    call Func_014_5821
    ld de, Data_01F_4230
    ld hl, $9700
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    db $11

Func_014_4F7D:: ; heuristic: target of a pointer table; C0
    sub a, b
    ld b, d
    ld hl, $9710
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4180
    ld hl, $9760
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    call Func_014_5800
    ld bc, $140D
    ld de, $01CC
    call Func_014_585B
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$D7FA], a
    ret
    db $B0, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $70, $71, $DF, $B7, $B6, $C3, $C3, $C3
    db $C3, $B7, $B6, $C3, $76, $73, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B5

Func_014_4FCC:: ; heuristic: target of a pointer table; C0
    ld a, [$D7B5]
    ld [$D7AB], a
    ld a, [$D7B6]
    ld [$D7AF], a
    ld hl, Data_014_77AC
    ld b, $15
    rst $10
    call Func_014_4BA0
    ld a, $01
    ld [$D7FA], a
    ld a, $20
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

Func_014_5002:: ; heuristic: target of a pointer table; C0
    ld a, $0A
    ld [$1FFF], a
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
    cp a, $1D
    jr nc, Jump_014_502A
    ld c, $6F
    call Func_000_1682
    ld de, $B356
    add hl, de
    xor a, a
    jr Jump_014_502F

Jump_014_502A::
    ld hl, $A000
    ld a, $01

Jump_014_502F::
    ld [$D7F2], a
    ld a, l
    ld [$D7F3], a
    ld a, h
    ld [$D7F4], a
    ld hl, $A000
    ld c, $00

Jump_014_503F::
    ld a, [hl]
    cp a, $01
    jr z, Jump_014_504A
    cp a, $02
    jr z, Jump_014_504A
    jr Jump_014_506D

Jump_014_504A::
    ld a, $A5
    add a, l
    ld l, a
    jr nc, Jump_014_5051
    inc h

Jump_014_5051::
    inc c
    ld a, c
    cp a, $1E
    jr c, Jump_014_503F
    xor a, a
    ld [$1FFF], a
    ld a, [$D781]
    inc a
    inc a
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_014_506D::
    ld a, c
    ld [$D7F1], a
    xor a, a
    ld [$1FFF], a
    ld a, [$D7F1]
    ld [$D7BE], a
    ld a, [$D7F2]
    ld [$D7BF], a
    ld a, [$D7F3]
    ld [$D7C0], a
    ld a, [$D7F4]
    ld [$D7C1], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_014_5095:: ; heuristic: target of a pointer table; C0
    ld a, [$D7BE]
    ld [$D7F1], a
    ld a, [$D7BF]
    ld [$D7F2], a
    ld a, [$D7C0]
    ld [$D7F3], a
    ld a, [$D7C1]
    ld [$D7F4], a
    ld hl, Data_014_7492
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    cp a, $FF
    ret nz
    ld a, $0A
    ld [$1FFF], a
    ld a, [$D7BF]
    ld [$4100], a
    ld a, [$D7C0]
    ld l, a
    ld a, [$D7C1]
    ld h, a
    ld b, $6F

Jump_014_50CE::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_014_50CE
    xor a, a
    ld [$1FFF], a
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
    ld hl, Func_014_7D7F
    ld b, $14
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_014_5104:: ; heuristic: target of a pointer table; C0
    call Func_014_5800
    ld bc, $140D
    ld de, $01CC
    call Func_014_585B
    ld a, $08
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_014_511F:: ; heuristic: target of a pointer table; C0
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld hl, $5D84
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    push hl
    call Func_014_59D0
    pop hl
    cp a, $FF
    jr z, Jump_014_514B
    xor a, a
    ld [$1FFF], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_014_514B::
    xor a, a
    ld [$1FFF], a
    ld a, [$D781]
    inc a
    inc a
    ld [$D781], a
    ld hl, $5E79
    ld b, $1D
    rst $10
    call Func_014_4932
    xor a, a
    ld [$D7AB], a
    ld [$D7AD], a
    ld [$D7AF], a
    ld [$D7AC], a
    ld [$D7AE], a
    ret

Func_014_5171:: ; heuristic: target of a pointer table; C0
    ld a, [$D7F5]
    ld [$D7F2], a
    ld a, [$D7F6]
    ld [$D7F3], a
    ld a, [$D7F7]
    ld [$D7F4], a
    ld a, [$D7AF]
    ld b, a
    add a, a
    add a, a
    add a, b
    ld b, a
    ld a, [$D7AB]
    add a, b
    ld hl, $D789
    add a, l
    ld l, a
    jr nc, Jump_014_5197
    inc h

Jump_014_5197::
    ld a, [hl]
    ld [$D7F1], a
    ld hl, $6E39
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    cp a, $FF
    ret nz
    ld a, $0A
    ld [$1FFF], a
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
    ld [$D7F1], a
    xor a, a
    ld [$1FFF], a
    ld [$D7F2], a
    ld hl, Func_014_7E96
    ld b, $14
    rst $10
    ld hl, $5E79
    ld b, $1D
    rst $10
    call Func_014_4932
    xor a, a
    ld [$D7AB], a
    ld [$D7AD], a
    ld [$D7AF], a
    ld [$D7AC], a
    ld [$D7AE], a
    ret

Func_014_51E9:: ; heuristic: target of a pointer table; C0
    xor a, a
    ld [$D7F9], a
    ld hl, $66B6
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_014_520D
    cp a, $FC
    jr z, Jump_014_520D
    cp a, $FD
    jr z, Jump_014_5219
    cp a, $FE
    jr z, Jump_014_5222
    cp a, $FF
    jr z, Jump_014_5238
    ret

Jump_014_520D::
    call Func_014_4B5A
    ld a, [$D781]
    sub a, $07
    ld [$D781], a
    ret

Jump_014_5219::
    ld a, [$D781]
    sub a, $04
    ld [$D781], a
    ret

Jump_014_5222::
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

Jump_014_5238::
    call Func_014_58EE
    ld a, [$D7AB]
    ld b, $BC
    ld hl, Data_014_5B1E
    call Func_014_5902
    xor a, a
    ld [$D7FA], a
    ld a, [$D781]
    add a, $08
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_014_525C:: ; heuristic: target of a pointer table; C0
    ld de, Data_014_5AC4
    ld hl, $C364
    ld bc, $0A09
    call Func_014_5821
    call Func_014_5910
    ld a, [$D786]
    ld b, $C3
    ld hl, Data_014_5B1E
    call Func_014_5902
    call Func_014_5800
    ld bc, $140B
    ld de, $01CC
    call Func_014_585B
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

Func_014_529C:: ; heuristic: target of a pointer table; C0
    call Func_014_5800
    ld bc, $140D
    ld de, $01CC
    call Func_014_585B
    ld a, [$D781]
    inc a
    ld [$D781], a
    ld a, [$D7AB]
    ld [$D7B5], a
    ld hl, $5D84
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld a, [hl]
    ld [$D7B4], a
    ld a, [$D7AF]
    ld [$D7B6], a
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

Func_014_52E4:: ; heuristic: target of a pointer table; C0
    xor a, a
    ld [$D7F9], a
    ld hl, $66B6
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_014_5308
    cp a, $FC
    jr z, Jump_014_5308
    cp a, $FD
    jr z, Jump_014_5368
    cp a, $FE
    jr z, Jump_014_5311
    cp a, $FF
    jr z, Jump_014_533A
    ret

Jump_014_5308::
    ld a, [$D781]
    sub a, $07
    ld [$D781], a
    ret

Jump_014_5311::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ld a, [$D780]
    cp a, $04
    jr z, Jump_014_532E
    ld a, $01
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_014_532E::
    ld a, [$D7AB]
    ld b, $BC
    ld hl, Data_014_5B1E
    call Func_014_5902
    ret

Jump_014_533A::
    ld a, [$D781]
    inc a
    inc a
    ld [$D781], a
    xor a, a
    ld [$D7FA], a
    ld a, [$D7AB]
    ld b, $BC
    ld hl, Data_014_5B1E
    call Func_014_5902
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

Jump_014_5368::
    ld a, [$D781]
    sub a, $04
    ld [$D781], a
    ret

Func_014_5371:: ; heuristic: target of a pointer table; C0
    call Func_014_5800
    ld bc, $140D
    ld de, $01CC
    call Func_014_585B
    ld a, $3B
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_014_538C:: ; heuristic: target of a pointer table; C0
    ld a, [$D782]
    and a, a
    jp nz, Jump_014_53EC
    ld a, $0A
    ld [$1FFF], a
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
    push af
    ld [$D7F1], a
    xor a, a
    ld [$1FFF], a
    ld [$D7F2], a
    ld hl, $C986
    ld a, l
    ld [$D7F3], a
    ld a, h
    ld [$D7F4], a
    ld hl, $6E39
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    cp a, $FF
    jr z, Jump_014_53D0
    pop af
    ret

Jump_014_53D0::
    pop af
    ld [$D7F1], a
    xor a, a
    ld [$D7F2], a
    ld hl, Func_014_7E96
    ld b, $14
    rst $10
    ld a, [$D7F5]
    ld [$D7F1], a
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_014_53EC::
    ld a, [$D7B4]
    cp a, $1D
    jr z, Jump_014_53FF
    ld c, $6F
    call Func_000_1682
    ld de, $B356
    add hl, de
    xor a, a
    jr Jump_014_5404

Jump_014_53FF::
    ld hl, $A000
    ld a, $01

Jump_014_5404::
    ld [$D7F2], a
    push hl
    pop hl
    ld a, l
    ld [$D7F3], a
    ld a, h
    ld [$D7F4], a
    ld hl, Data_014_7492
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    cp a, $FF
    ret nz
    ld a, [$D7B4]
    ld [$D7F1], a
    xor a, a
    ld [$D7F2], a
    ld hl, Func_014_7D7F
    ld b, $14
    rst $10
    ld a, [$D7F5]
    ld [$D7B4], a
    xor a, a
    ld [$D782], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_014_543F:: ; heuristic: target of a pointer table; C0
    ld a, $0A
    ld [$1FFF], a
    ld a, [$D7B4]
    cp a, $1D
    jr z, Jump_014_5457
    ld c, $6F
    call Func_000_1682
    ld de, $B356
    add hl, de
    xor a, a
    jr Jump_014_545C

Jump_014_5457::
    ld hl, $A000
    ld a, $01

Jump_014_545C::
    ld [$4100], a
    ld de, $C986
    ld b, $6F

Jump_014_5464::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_014_5464
    xor a, a
    ld [$1FFF], a
    xor a, a
    ld [$D7B5], a
    ld [$D7B6], a
    ld [$D7B4], a
    ld hl, $5E79
    ld b, $1D
    rst $10
    call Func_014_4932
    xor a, a
    ld [$D7AB], a
    ld [$D7AD], a
    ld [$D7AF], a
    ld [$D7AC], a
    ld [$D7AE], a
    ret

Jump_014_5492::
    ld a, [$D781]
    rst $00
    dw Func_014_4A75
    dw Func_014_4B5A
    dw Func_014_4B92
    dw Func_014_4BE3
    dw Func_014_54B8
    dw Func_014_46F4
    dw Func_014_4C1C
    dw Func_014_4718
    dw Func_014_5501
    dw Func_014_4742
    dw $475E
    dw Func_014_4772
    dw Func_014_4A75
    dw Func_014_4CA8
    dw Func_014_4CBC
    dw Func_014_4D2B
    dw Func_014_55A0

Func_014_54B8:: ; heuristic: target of a pointer table; C0
    ld hl, $5D84
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld a, [hl]
    ld b, a
    call Func_014_5979
    ld de, Data_014_5B8E
    ld hl, $C36C
    ld bc, $0C09
    call Func_014_5821
    xor a, a
    ld [$D7F1], a
    ld hl, $6AA5
    ld b, $1D
    rst $10
    ld hl, $5D84
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld a, [hl]
    ld [$D7F1], a
    ld hl, Data_014_5B4D
    ld b, $1D
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_014_5501:: ; heuristic: target of a pointer table; C0
    xor a, a
    ld [$D7F9], a
    ld hl, $66B6
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_014_5525
    cp a, $FC
    jr z, Jump_014_5525
    cp a, $FD
    jr z, Jump_014_5564
    cp a, $FE
    jr z, Jump_014_552E
    cp a, $FF
    jr z, Jump_014_5536
    ret

Jump_014_5525::
    ld a, [$D781]
    sub a, $07
    ld [$D781], a
    ret

Jump_014_552E::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_014_5536::
    ld a, [$D781]
    add a, $08
    ld [$D781], a
    xor a, a
    ld [$D7FA], a
    ld a, [$D7AB]
    ld b, $BC
    ld hl, Data_014_5B1E
    call Func_014_5902
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

Jump_014_5564::
    ld a, [$D781]
    sub a, $04
    ld [$D781], a
    ret
    db $0E, $09, $21, $D4, $01, $11, $08, $00, $AF, $EA, $F1, $D7, $3E, $0C, $EA, $F2

Func_014_557D:: ; heuristic: target of a pointer table; C0
    rst $10
    call Func_014_5925
    ld de, Data_014_5595
    ld hl, $C40D
    ld bc, $0B01
    call Func_014_5821
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Data_014_5595:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2

Func_014_55A0:: ; heuristic: target of a pointer table; C0
    ld hl, Data_014_5C8A
    ld de, Data_014_5C9A
    call Func_014_5898
    cp a, $FF
    ret nz
    ld a, $06
    ld [$D7B2], a
    ld a, $08
    ld [$D7B3], a
    xor a, a
    ld [$D781], a
    ld [$D782], a
    ld a, $09
    ld [$D780], a
    ld hl, Data_014_7745
    ld b, $1E
    rst $10
    ret

Jump_014_55C9::
    ld a, [$D781]
    rst $00
    dw Func_014_4A75
    dw Func_014_4B5A
    dw Func_014_4DFE
    dw Func_014_4E07
    dw Func_014_4E0E
    dw Func_014_46F4
    dw Func_014_4E46
    dw Func_014_4718
    dw Func_014_51E9
    dw Func_014_4742
    dw $475E
    dw Func_014_4772
    dw Func_014_4A75
    dw Func_014_4CA8
    dw Func_014_4CBC
    dw Func_014_4D2B
    dw Func_014_4F51
    dw $5601
    dw Func_014_5649
    dw Func_014_4742
    dw $475E
    dw Func_014_4772
    dw Func_014_4A75
    dw Func_014_4CA8
    dw Func_014_4CBC
    dw Func_014_4D2B

Func_014_5601:: ; heuristic: target of a pointer table; C0
    dw $4021

Func_014_5603:: ; heuristic: follows a terminator; C0
    ld h, l
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_014_5623
    cp a, $FF
    jp z, Jump_014_5616
    ret

Jump_014_5616::
    ld a, [$D7FA]
    cp a, $01
    jr z, Jump_014_5623
    call Func_014_56EB
    jp Jump_014_4EA7

Jump_014_5623::
    call Func_014_4EBF
    ld a, [$D7AB]
    ld b, $C3
    ld hl, Data_014_5B1E
    call Func_014_5902
    ld a, $01
    ld [$D7FA], a
    ld a, $08
    ld [$D781], a
    xor a, a
    ld [$D782], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_014_5649:: ; heuristic: target of a pointer table; C0
    ld a, $0A
    ld [$1FFF], a
    ld hl, $5D84
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld a, [hl]
    cp a, $1D
    jr z, Jump_014_566D
    ld c, $6F
    call Func_000_1682
    ld de, $B356
    add hl, de
    xor a, a
    jr Jump_014_5672

Jump_014_566D::
    ld hl, $A000
    ld a, $01

Jump_014_5672::
    ld [$4100], a
    ld b, $6F

Jump_014_5677::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_014_5677
    xor a, a
    ld [$1FFF], a
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
    ld hl, Func_014_7D7F
    ld b, $14
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_014_56A4:: ; heuristic: target of a pointer table; C0
    ld a, $01
    ld [$D7FC], a
    ld hl, $4069
    ld b, $1E
    rst $10
    ret

Func_014_56B0::
    push bc
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld a, b
    ld a, [hl]
    ld c, $01
    call Func_000_1FA4
    ld a, $F0
    ld [$C8D9], a
    xor a, a
    ld [$1FFF], a
    ld hl, $C8CF
    ld de, $C130
    pop bc
    ld a, c
    add a, e
    ld e, a
    jr nc, Jump_014_56D7
    inc d

Jump_014_56D7::
    ld c, $00

Jump_014_56D9::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_014_56E7
    ld [de], a
    inc hl
    inc de
    inc c
    ld a, c
    cp a, $0A
    jr c, Jump_014_56D9

Jump_014_56E7::
    ld a, $F0
    ld [de], a
    ret

Func_014_56EB::
    ld hl, $5D84
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld a, [hl]
    cp a, $1D
    jr z, Jump_014_570A
    ld c, $6F
    call Func_000_1682
    ld de, $B356
    add hl, de
    xor a, a
    jr Jump_014_570F

Jump_014_570A::
    ld hl, $A000
    ld a, $01

Jump_014_570F::
    ld [$D7F2], a
    ld a, l
    ld [$D7F3], a
    ld a, h
    ld [$D7F4], a
    xor a, a
    ld [$D7F1], a
    ld hl, Data_014_795D
    ld b, $1D
    rst $10
    ld a, $F0
    ld [$C8D9], a
    ld hl, $C8CF
    ld de, $C140
    ld c, $00

Jump_014_5731::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_014_573F
    ld [de], a
    inc hl
    inc de
    inc c
    ld a, c
    cp a, $0A
    jr c, Jump_014_5731

Jump_014_573F::
    ld a, $F0
    ld [de], a
    ld a, [$C140]
    cp a, $E0
    ret c
    ld a, $F0
    ld [$C140], a
    ret

Func_014_574E::
    ld hl, $5D84
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld a, [hl]
    ld c, $01
    call Func_000_1FA4
    ld a, $F0
    ld [$C8D9], a
    xor a, a
    ld [$1FFF], a
    ld hl, $C8CF
    ld de, $C140
    ld c, $00

Jump_014_577C::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_014_578A
    ld [de], a
    inc hl
    inc de
    inc c
    ld a, c
    cp a, $0A
    jr c, Jump_014_577C

Jump_014_578A::
    ld a, $F0
    ld [de], a
    ret

Func_014_578E::
    ld a, [$D7B4]
    cp a, $1D
    jr z, Jump_014_57A1
    ld c, $6F
    call Func_000_1682
    ld de, $B356
    add hl, de
    xor a, a
    jr Jump_014_57A6

Jump_014_57A1::
    ld hl, $A000
    ld a, $01

Jump_014_57A6::
    ld [$D7F2], a
    ld a, l
    ld [$D7F3], a
    ld a, h
    ld [$D7F4], a
    xor a, a
    ld [$D7F1], a
    ld hl, Data_014_795D
    ld b, $1D
    rst $10
    ld a, $F0
    ld [$C8D9], a
    ld hl, $C8CF
    ld de, $C130
    ld c, $00

Jump_014_57C8::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_014_57D6
    ld [de], a
    inc hl
    inc de
    inc c
    ld a, c
    cp a, $0A
    jr c, Jump_014_57C8

Jump_014_57D6::
    ld a, $F0
    ld [de], a
    ld a, [$C130]
    cp a, $E0
    ret c
    ld a, $F0
    ld [$C132], a
    ret

Func_014_57E5::
    ld a, [de]
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Func_014_57E5
    ret

Func_014_57EE::
    ld a, $02
    ldh [$FF70], a

Jump_014_57F2::
    ld a, [de]
    and a, $07
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_014_57F2
    xor a, a
    ldh [$FF70], a
    ret

Func_014_5800::
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
    jr nc, Jump_014_5820
    inc h

Jump_014_5820::
    ret

Func_014_5821::
    push hl
    push bc

Jump_014_5823::
    push bc
    push hl

Jump_014_5825::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_014_5825
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_014_5823
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

Jump_014_5847::
    push bc
    push hl

Jump_014_5849::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_014_5849
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_014_5847
    xor a, a
    ldh [$FF70], a
    ret

Func_014_585B::
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

Func_014_5898::
    xor a, a
    ld [$D784], a

Jump_014_589C::
    push hl
    push de
    ld a, [$D785]
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_014_58A7
    inc h

Jump_014_58A7::
    ld a, [hl]
    cp a, $FF
    jp z, Jump_014_58E2
    ld e, a
    inc hl
    ld h, [hl]
    ld l, e
    pop de
    push de
    push hl
    ld a, [$D785]
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_014_58BD
    inc d

Jump_014_58BD::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld d, a
    ld a, l
    ld e, a
    pop hl
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    pop de
    pop hl
    ld a, [$D785]
    inc a
    ld [$D785], a
    ld a, [$D784]
    inc a
    ld [$D784], a
    cp a, $08
    jr c, Jump_014_589C
    xor a, a
    ret

Jump_014_58E2::
    pop de
    pop hl
    xor a, a
    ld [$D785], a
    ld [$D784], a
    ld a, $FF
    ret

Func_014_58EE::
    ld c, $00

Jump_014_58F0::
    push bc
    ld a, c
    ld b, $C3
    ld hl, Data_014_5B1E
    call Func_014_5902
    pop bc
    inc c
    ld a, c
    cp a, $05
    jr c, Jump_014_58F0
    ret

Func_014_5902::
    push bc
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_014_5909
    inc h

Jump_014_5909::
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop bc
    ld a, b
    ld [de], a
    ret

Func_014_5910::
    ld c, $02
    ld hl, $0280
    ld de, $00B4
    xor a, a
    ld [$D7F1], a
    ld a, $08
    ld [$D7F2], a
    call Func_014_5925
    ret

Func_014_5925::
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
    call Func_014_57E5
    pop de
    pop hl
    ld a, [$C525]
    and a, a
    jr z, Jump_014_5966
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
    call Func_014_57EE
    pop de
    pop hl

Jump_014_5966::
    pop bc
    ld a, $14
    add a, l
    ld l, a
    jr nc, Jump_014_596E
    inc h

Jump_014_596E::
    ld a, $14
    add a, e
    ld e, a
    jr nc, Jump_014_5975
    inc d

Jump_014_5975::
    dec c
    jr nz, Func_014_5925
    ret

Func_014_5979::
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
    ld hl, Data_014_7A48
    ld b, $16
    rst $10
    xor a, a
    ld [$1FFF], a
    ret

Func_014_599F::
    push de
    call Func_014_5800
    pop de
    add hl, de
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

Func_014_59C2::
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

Func_014_59D0::
    ld hl, $B356
    ld c, $00

Jump_014_59D5::
    ld a, [hl]
    bit 7, a
    jr z, Jump_014_59F7
    ld a, $6F
    add a, l
    ld l, a
    jr nc, Jump_014_59E1
    inc h

Jump_014_59E1::
    inc c
    ld a, c
    cp a, $1D
    jr c, Jump_014_59D5
    ld a, $01
    ld [$4100], a
    ld hl, $A000
    ld a, [hl]
    bit 7, a
    jr z, Jump_014_59F7
    ld a, $FF
    ret

Jump_014_59F7::
    push bc
    ld a, c
    cp a, $1D
    jr z, Jump_014_5A15
    ld c, $6F
    call Func_000_1682
    ld de, $B356
    add hl, de
    ld a, l
    ld [$D7F6], a
    ld a, h
    ld [$D7F7], a
    xor a, a
    ld [$D7F5], a
    pop bc
    xor a, a
    ret

Jump_014_5A15::
    pop bc
    ld hl, $A000
    ld a, l
    ld [$D7F6], a
    ld a, h
    ld [$D7F7], a
    ld a, $01
    ld [$D7F5], a
    xor a, a
    ret
    INCBIN "dwm2-cobi-us.gbc", $051A28, $5C

Data_014_5A84:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D0, $41
    dw Func_014_4300
    dw Func_014_4290
    dw $4340
    dw Func_014_4210
    dw $4250
    db $F0, $42
    dw $41C0
    dw $4370
    dw Func_014_40F0
    dw $43C0
    dw Func_014_42D0
    dw Func_014_4380
    dw $4180
    dw $4910
    dw $4910
    dw $4910
    dw $4910
    dw $4910
    dw Func_014_4120
    dw $4170
    dw $41A0
    dw $4910
    dw $4910
    dw $4910
    dw $4910
    dw $4910
    dw $4910
    dw $4910
    dw Func_014_4A70
    dw $4910
    db $FF, $FF

Data_014_5AC4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $051AC4, $5A

Data_014_5B1E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $79, $C3, $A1, $C3, $C9, $C3, $F1, $C3, $19, $C4, $22, $C4, $4A, $C4, $80, $C3
    db $A8, $C3, $D0, $C3, $F8, $C3, $20, $C4

Data_014_5B36:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $D0, $D1, $D2, $D3, $D4, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3

Data_014_5B4D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $051B4D, $41

Data_014_5B8E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $051B8E, $87

Data_014_5C15:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $8F, $FF, $FF
    dw $4910
    dw $4910
    dw $4910
    dw $4910
    dw $4910
    dw $4910
    dw $4910
    dw $4910
    dw $4910
    dw $4910
    dw $4910
    dw $4910
    dw $4910
    dw $4910
    db $FF, $FF

Data_014_5C36:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $70, $8A, $80, $8A, $90, $8A, $A0, $8A, $B0, $8A, $C0, $8A, $D0, $8A, $E0, $8A
    db $F0, $8A, $FF, $FF

Data_014_5C4A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $40, $43, $10, $42, $50, $42, $F0, $42
    dw $41C0
    dw $4370
    dw Func_014_40F0
    dw $43C0
    dw Func_014_42D0
    db $FF, $FF

Data_014_5C5E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $40, $8A, $50, $8A, $60, $8A, $00, $8F, $10, $8F, $20, $8F, $30, $8F, $40, $8F
    db $E0, $8C, $F0, $8C, $FF, $FF

Data_014_5C74:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D0, $41
    dw Func_014_4300
    dw Func_014_4290
    dw $4910
    dw $4910
    dw $4910
    dw $4910
    dw $4910
    dw Func_014_4230
    dw Func_014_4290
    db $FF, $FF

Data_014_5C8A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $97, $10, $97, $20, $97, $30, $97, $40, $97, $50, $97, $60, $97, $FF, $FF

Data_014_5C9A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $30, $41
    dw $4320
    dw Func_014_42A0
    dw Func_014_4330
    dw Func_014_4190
    dw Func_014_4150
    db $FF, $FF

Func_014_5CA8::
    ld a, [$C56C]
    and a, a
    ret nz
    ld a, [$CFA8]
    rst $00
    dw Jump_014_5CC1
    dw Jump_014_5F57
    dw Jump_014_64C4
    dw Jump_014_65AA
    dw Jump_014_66B1
    dw Jump_014_66F3
    dw Jump_014_6729
    dw Jump_014_67B0

Jump_014_5CC1::
    ld a, [$CFA9]
    rst $00
    dw Jump_014_5CCF
    dw Jump_014_5D72
    dw Jump_014_5D8B
    dw Jump_014_5DE0
    dw Jump_014_5EBF

Jump_014_5CCF::
    ld hl, $CFA8
    ld bc, $001D

Jump_014_5CD5::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_014_5CD5
    call Func_014_6BCF
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
    ldh [$FFA5], a
    ldh [$FFA1], a
    ldh a, [$FFB9]
    ld [$D7BC], a
    ld a, $01
    ldh [$FFBA], a
    ld a, $02
    ldh [$FFB9], a
    ld de, Data_01F_4910
    ld hl, $9000
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4230
    ld hl, $8CE0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4290
    ld hl, $8CF0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4370
    ld hl, $8DF0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4A80
    ld hl, $8CC0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4A90
    ld hl, $8CD0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld a, [$CFA9]
    inc a
    ld [$CFA9], a
    xor a, a
    ld [$D7F5], a
    ret

Jump_014_5D72::
    ld hl, Data_014_6D56
    ld de, Data_014_6DF8
    call Func_014_6BF8
    cp a, $FF
    jr nz, Jump_014_5D86
    ld a, [$CFA9]
    inc a
    ld [$CFA9], a

Jump_014_5D86::
    xor a, a
    ld [$D7F5], a
    ret

Jump_014_5D8B::
    ld a, [$D7F2]
    push af
    call Func_014_6BCF
    ld a, h
    ld [$D7F5], a
    ld a, l
    ld [$D7F6], a
    ld de, Data_014_6FE7
    ld a, d
    ld [$D7F1], a
    ld a, e
    ld [$D7F2], a
    ld a, $14
    ld [$D7F3], a
    ld a, $12
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    ld hl, $5D2A
    ld b, $1F
    rst $10
    call Func_014_6BCF
    ld de, $0043
    add hl, de
    di
    call Func_000_120A
    pop af
    and a, $01
    add a, $CC
    ld [hl], a
    ei
    ld hl, Data_014_6F3E
    ld de, $9550
    call Func_014_6981
    ld a, [$CFA9]
    inc a
    ld [$CFA9], a
    xor a, a
    ld [$D7F5], a
    ret

Jump_014_5DE0::
    ld hl, $D7F1
    ld de, $CF8B
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
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [$D7F1]
    or a, a
    jr nz, Jump_014_5E44
    ld hl, Data_014_5E9F
    ld a, [$D7F2]
    or a, a
    jr z, Jump_014_5E10
    ld hl, Data_014_5EAF

Jump_014_5E10::
    ld de, $CB7F
    ld b, $10
    call Func_014_5E8C
    ld hl, Data_014_5E93
    ld a, [$D7F2]
    or a, a
    jr z, Jump_014_5E24
    ld hl, Data_014_5E99

Jump_014_5E24::
    ld de, $FFC6
    ld b, $06
    call Func_014_5E8C
    ld hl, $431F
    ld b, $04
    rst $10
    ld a, $01
    ld [$CB7D], a
    ld a, [$C525]
    or a, a
    jr z, Jump_014_5E62
    ld a, $7F
    ld [$C527], a
    jr Jump_014_5E62

Jump_014_5E44::
    ld a, [$D7F4]
    ld [$D7F1], a
    ld a, [$D7F5]
    ld [$D7F2], a
    xor a, a
    ld [$D7F3], a
    ld [$D7F4], a
    ld a, $80
    ld [$D7F5], a
    ld hl, $6973
    ld b, $1D
    rst $10

Jump_014_5E62::
    ld hl, $CF8B
    ld de, $D7F1
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
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [$CFA9]
    inc a
    ld [$CFA9], a
    xor a, a
    ld [$D7F5], a
    ret

Func_014_5E8C::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Func_014_5E8C
    ret

Data_014_5E93:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $01, $04, $00, $80

Data_014_5E99:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $00, $01, $01, $00, $80

Data_014_5E9F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $00, $00, $08, $08, $04, $00, $00, $00, $00, $08, $08, $04, $00, $00

Data_014_5EAF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $01, $00, $08, $08, $01, $00, $00, $00, $00, $08, $08, $04, $00, $00

Jump_014_5EBF::
    call Func_014_6A28
    ld a, [$D7F1]
    and a, a
    jp z, Jump_014_5F12
    cp a, $01
    jp z, Jump_014_5F44
    cp a, $02
    jp z, Jump_014_5F44
    ld hl, $C6FE
    ld a, [$D786]
    add a, l
    ld l, a
    jr nc, Jump_014_5EDE
    inc h

Jump_014_5EDE::
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld a, [hl]
    ld c, $01
    call Func_000_1FD1
    ld de, $CFAD
    ld c, $00

Jump_014_5EF2::
    push hl
    push bc
    ld a, [hl]
    cp a, $F0
    jr z, Jump_014_5F07
    call Func_014_631C
    pop bc
    pop hl
    inc hl
    inc c
    ld a, c
    cp a, $0A
    jr c, Jump_014_5EF2
    jr Jump_014_5F09

Jump_014_5F07::
    pop bc
    pop hl

Jump_014_5F09::
    xor a, a
    ld [$CFBF], a
    ld [$CFC0], a
    jr Jump_014_5F44

Jump_014_5F12::
    ld de, $0000
    call Func_000_181B
    jr c, Jump_014_5F30
    ld hl, $CFAD
    ld a, $0C
    ld [hl+], a
    ld a, $32
    ld [hl+], a
    ld a, $25
    ld [hl+], a
    ld a, $2C
    ld [hl], a
    ld a, $04
    ld [$CFC2], a
    jr Jump_014_5F44

Jump_014_5F30::
    ld hl, $CFAD
    ld a, $1D
    ld [hl+], a
    ld a, $24
    ld [hl+], a
    ld a, $35
    ld [hl+], a
    ld a, $24
    ld [hl], a
    ld a, $04
    ld [$CFC2], a

Jump_014_5F44::
    call Func_014_6804
    xor a, a
    ld [$CFA9], a
    ld a, [$CFA8]
    inc a
    ld [$CFA8], a
    xor a, a
    ld [$D7F5], a
    ret

Jump_014_5F57::
    call Func_014_6804
    ld a, [$CFA9]
    rst $00
    dw Jump_014_5F72
    dw Jump_014_628C
    dw Jump_014_6302
    dw Jump_014_6476
    dw Jump_014_6488
    dw Jump_014_5F72
    dw Jump_014_628C
    dw Jump_014_6302
    dw Jump_014_6476
    dw Jump_014_64AE

Jump_014_5F72::
    call Func_014_6992
    ld b, $55
    call Func_014_6A0D
    ld a, [$C563]
    bit 6, a
    jp nz, Jump_014_5FA7
    bit 7, a
    jp nz, Jump_014_5FD4
    bit 4, a
    jp nz, Jump_014_601A
    bit 5, a
    jp nz, Jump_014_6063
    ld a, [$C562]
    bit 0, a
    jp nz, Jump_014_60A6
    bit 1, a
    jp nz, Jump_014_60BB
    bit 3, a
    jp nz, Jump_014_60CF
    call Func_014_6172
    ret

Jump_014_5FA7::
    call Func_014_6189
    ld a, [$CFC0]
    and a, a
    jr nz, Jump_014_5FC3
    ld a, $04
    ld [$CFC0], a
    ld a, [$CFBF]
    cp a, $06
    jr c, Jump_014_5FC7
    ld a, $0D
    ld [$CFBF], a
    jr Jump_014_5FC7

Jump_014_5FC3::
    dec a
    ld [$CFC0], a

Jump_014_5FC7::
    call Func_014_6172
    ld a, $69
    call Func_000_1278
    xor a, a
    ld [$D7F5], a
    ret

Jump_014_5FD4::
    call Func_014_6189
    ld a, [$CFC0]
    cp a, $04
    jr c, Jump_014_5FE4
    xor a, a
    ld [$CFC0], a
    jr Jump_014_600D

Jump_014_5FE4::
    cp a, $02
    jr nz, Jump_014_5FF6
    ld a, [$CFBF]
    cp a, $0D
    jr c, Jump_014_6006
    ld a, $0D
    ld [$CFBF], a
    jr Jump_014_6006

Jump_014_5FF6::
    cp a, $03
    jr nz, Jump_014_6006
    ld a, [$CFBF]
    cp a, $06
    jr c, Jump_014_6006
    ld a, $0D
    ld [$CFBF], a

Jump_014_6006::
    ld a, [$CFC0]
    inc a
    ld [$CFC0], a

Jump_014_600D::
    call Func_014_6172
    ld a, $69
    call Func_000_1278
    xor a, a
    ld [$D7F5], a
    ret

Jump_014_601A::
    call Func_014_6189
    ld a, [$CFC0]
    ld hl, Data_014_605E
    add a, l
    ld l, a
    jr nc, Jump_014_6028
    inc h

Jump_014_6028::
    ld b, [hl]
    ld a, [$CFBF]
    cp a, b
    jr c, Jump_014_6035
    xor a, a
    ld [$CFBF], a
    jr Jump_014_6051

Jump_014_6035::
    ld a, [$CFC0]
    cp a, $04
    jr nz, Jump_014_604A
    ld a, [$CFBF]
    cp a, $05
    jr c, Jump_014_604A
    ld a, $0D
    ld [$CFBF], a
    jr Jump_014_6051

Jump_014_604A::
    ld a, [$CFBF]
    inc a
    ld [$CFBF], a

Jump_014_6051::
    call Func_014_6172
    ld a, $69
    call Func_000_1278
    xor a, a
    ld [$D7F5], a
    ret

Data_014_605E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $10, $10, $10, $0D, $0D

Jump_014_6063::
    call Func_014_6189
    ld a, [$CFBF]
    and a, a
    jr nz, Jump_014_607D
    ld a, [$CFC0]
    ld hl, Data_014_605E
    add a, l
    ld l, a
    jr nc, Jump_014_6077
    inc h

Jump_014_6077::
    ld a, [hl]
    ld [$CFBF], a
    jr Jump_014_6099

Jump_014_607D::
    ld a, [$CFC0]
    cp a, $04
    jr nz, Jump_014_6092
    ld a, [$CFBF]
    cp a, $0D
    jr c, Jump_014_6092
    ld a, $05
    ld [$CFBF], a
    jr Jump_014_6099

Jump_014_6092::
    ld a, [$CFBF]
    dec a
    ld [$CFBF], a

Jump_014_6099::
    call Func_014_6172
    ld a, $69
    call Func_000_1278
    xor a, a
    ld [$D7F5], a
    ret

Jump_014_60A6::
    ld a, $69
    call Func_000_1278
    call Func_014_618D
    ld a, [$CFA9]
    inc a
    inc a
    ld [$CFA9], a
    xor a, a
    ld [$D7F5], a
    ret

Jump_014_60BB::
    ld a, $69
    call Func_000_1278
    call Func_014_6172
    ld a, [$CFA9]
    inc a
    ld [$CFA9], a
    xor a, a
    ld [$D7F5], a
    ret

Jump_014_60CF::
    ld a, $69
    call Func_000_1278
    call Func_014_6189
    ld a, $0D
    ld [$CFBF], a
    ld a, $04
    ld [$CFC0], a
    xor a, a
    ld [$D7F5], a
    ret

Func_014_60E6:: ; heuristic: follows a terminator; C0
    call Func_014_6C3F
    ld hl, $CFAD

Jump_014_60EC::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_014_60F8
    cp a, $9F
    jr z, Jump_014_60F8
    inc hl
    jr Jump_014_60EC

Jump_014_60F8::
    dec hl
    ld a, [hl]
    cp a, $8E
    jr z, Jump_014_6142
    cp a, $8D
    jr z, Jump_014_6154
    ld b, $8D
    push bc
    call Func_014_6875
    pop bc
    cp a, $FF
    jr nz, Jump_014_6112
    xor a, a
    ld [$D7F5], a
    ret

Jump_014_6112::
    ld a, $69
    call Func_000_1278
    ld hl, $CFAD

Jump_014_611A::
    ld a, [hl]
    cp a, $9F
    jr z, Jump_014_612D
    cp a, $F0
    jr z, Jump_014_6126
    inc hl
    jr Jump_014_611A

Jump_014_6126::
    ld a, b
    ld [hl], a
    xor a, a
    ld [$D7F5], a
    ret

Jump_014_612D::
    ld a, b
    ld [hl], a
    ld hl, $CFAD

Jump_014_6132::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_014_613A
    inc hl
    jr Jump_014_6132

Jump_014_613A::
    ld a, $9F
    ld [hl], a
    xor a, a
    ld [$D7F5], a
    ret

Jump_014_6142::
    ld a, $9F
    ld [hl], a

Jump_014_6145::
    ld a, [hl+]
    cp a, $F0
    jr nz, Jump_014_6145
    dec hl
    dec hl
    ld a, $F0
    ld [hl], a
    xor a, a
    ld [$D7F5], a
    ret

Jump_014_6154::
    dec hl
    ld b, $8E
    push bc
    call Func_014_68B5
    pop bc
    cp a, $FF
    jr nz, Jump_014_6164
    inc hl
    jp Jump_014_6142

Jump_014_6164::
    inc hl
    ld a, $8E
    ld [hl], a
    ld a, $69
    call Func_000_1278
    xor a, a
    ld [$D7F5], a
    ret

Func_014_6172::
    ld a, [$CFC1]
    inc a
    ld [$CFC1], a
    cp a, $10
    jr c, Jump_014_6185
    cp a, $18
    jr c, Func_014_6189
    xor a, a
    ld [$CFC1], a

Jump_014_6185::
    ld b, $55
    jr Jump_014_618F

Func_014_6189::
    ld b, $C3
    jr Jump_014_618F

Func_014_618D::
    ld b, $55

Jump_014_618F::
    ld a, [$CFC0]
    ld hl, Data_014_61E2
    cp a, $00
    jr z, Jump_014_61A1
    ld e, $22
    ld d, $00

Jump_014_619D::
    add hl, de
    dec a
    jr nz, Jump_014_619D

Jump_014_61A1::
    ld a, [$CFBF]
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_014_61AA
    inc h

Jump_014_61AA::
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call Func_014_6BCF
    pop de
    add hl, de
    di
    call Func_000_120A
    ld a, b
    ld [hl], a
    ei
    ld a, [$CFBF]
    cp a, $0D
    ret nz
    ld a, [$CFC0]
    cp a, $04
    jr z, Jump_014_61D2
    cp a, $03
    ret nz
    inc hl
    di
    call Func_000_120A
    ld a, b
    ld [hl], a
    ei

Jump_014_61D2::
    inc hl
    di
    call Func_000_120A
    ld a, b
    ld [hl+], a
    ei
    di
    call Func_000_120A
    ld a, b
    ld [hl], a
    ei
    ret

Data_014_61E2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0521E2, $AA

Jump_014_628C::
    ld b, $55
    call Func_014_6A0D
    ld a, [$CFC2]
    and a, a
    jr nz, Jump_014_62A6
    call Func_014_6A28
    ld a, [$CFA9]
    dec a
    ld [$CFA9], a
    xor a, a
    ld [$D7F5], a
    ret

Jump_014_62A6::
    ld b, $C3
    call Func_014_6A0D
    ld hl, $CFAD

Jump_014_62AE::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_014_62BA
    cp a, $9F
    jr z, Jump_014_62BA
    inc hl
    jr Jump_014_62AE

Jump_014_62BA::
    dec hl
    ld a, [hl]
    cp a, $8D
    jr z, Jump_014_62C6
    cp a, $8E
    jr z, Jump_014_62C6
    jr Jump_014_62DD

Jump_014_62C6::
    ld a, $9F
    ld [hl-], a
    ld a, $9F
    ld [hl], a
    ld hl, $CFAD

Jump_014_62CF::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_014_62D7
    inc hl
    jr Jump_014_62CF

Jump_014_62D7::
    dec hl
    ld a, $F0
    ld [hl], a
    jr Jump_014_62E0

Jump_014_62DD::
    ld a, $9F
    ld [hl-], a

Jump_014_62E0::
    call Func_014_6C3F
    ld a, [$CFC3]
    and a, a
    jr z, Jump_014_62EF
    xor a, a
    ld [$CFC3], a
    jr Jump_014_62F6

Jump_014_62EF::
    ld a, [$CFC2]
    dec a
    ld [$CFC2], a

Jump_014_62F6::
    ld a, [$CFA9]
    dec a
    ld [$CFA9], a
    xor a, a
    ld [$D7F5], a
    ret

Jump_014_6302::
    ld a, [$CFC0]
    ld hl, Data_014_6F4E
    cp a, $00
    jr z, Jump_014_6314
    ld e, $11
    ld d, $00

Jump_014_6310::
    add hl, de
    dec a
    jr nz, Jump_014_6310

Jump_014_6314::
    ld a, [$CFBF]
    add a, l
    ld l, a
    jr nc, Func_014_631C
    inc h

Func_014_631C::
    ld a, [hl]
    cp a, $FD
    jp z, Jump_014_643F
    cp a, $FE
    jp z, Jump_014_644C
    cp a, $FF
    jp z, Jump_014_6458
    push af
    ld hl, $CFAD

Jump_014_6330::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_014_633C
    cp a, $9F
    jr z, Jump_014_633C
    inc hl
    jr Jump_014_6330

Jump_014_633C::
    pop af
    cp a, $8D
    jr z, Jump_014_6375
    cp a, $8E
    jr z, Jump_014_6375
    push af
    ld a, [$CFC2]
    cp a, $04
    jr nz, Jump_014_6371
    ld a, $01
    ld [$CFC3], a
    dec hl
    ld a, [hl]
    cp a, $8D
    jr z, Jump_014_6365
    cp a, $8E
    jr z, Jump_014_6365
    inc hl
    ld a, [hl]
    cp a, $9F
    jr z, Jump_014_6371
    dec hl
    jr Jump_014_6371

Jump_014_6365::
    inc hl
    ld a, [hl-]
    cp a, $9F
    jr nz, Jump_014_636D
    inc hl
    inc hl

Jump_014_636D::
    ld a, $F0
    ld [hl], a
    dec hl

Jump_014_6371::
    pop af
    ld [hl+], a
    jr Jump_014_63CE

Jump_014_6375::
    dec hl
    push af
    ld a, [hl]
    cp a, $8D
    jp z, Jump_014_641A
    cp a, $8E
    jp z, Jump_014_6431
    pop af
    push af
    cp a, $8D
    jr z, Jump_014_6392
    call Func_014_68B5
    cp a, $FF
    jp z, Jump_014_63FD
    jr Jump_014_639A

Jump_014_6392::
    call Func_014_6875
    cp a, $FF
    jp z, Jump_014_63FD

Jump_014_639A::
    pop af
    inc hl
    ld [hl], a
    ld a, [$CFC2]
    cp a, $04
    jr z, Jump_014_63A8

Jump_014_63A4::
    ld b, $F0
    jr Jump_014_63B0

Jump_014_63A8::
    ld a, [$CFC3]
    and a, a
    jr z, Jump_014_63A4
    ld b, $9F

Jump_014_63B0::
    ld hl, $CFAD
    ld c, $00

Jump_014_63B5::
    ld a, [hl]
    cp a, b
    jr z, Jump_014_63C2
    inc hl
    inc c
    ld a, c
    cp a, $0A
    jr z, Jump_014_63C7
    jr Jump_014_63B5

Jump_014_63C2::
    ld a, $9F
    ld [hl], a
    jr Jump_014_63F0

Jump_014_63C7::
    ld a, $01
    ld [$CFC3], a
    jr Jump_014_63FE

Jump_014_63CE::
    ld b, $C3
    call Func_014_6A0D
    ld a, [$CFC2]
    cp a, $04
    jr nc, Jump_014_63E3
    ld a, [$CFC2]
    inc a
    ld [$CFC2], a
    jr Jump_014_63F0

Jump_014_63E3::
    call Func_014_6189
    ld a, $0D
    ld [$CFBF], a
    ld a, $04
    ld [$CFC0], a

Jump_014_63F0::
    ld a, [$CFA9]
    dec a
    dec a
    ld [$CFA9], a
    xor a, a
    ld [$D7F5], a
    ret

Jump_014_63FD::
    pop af

Jump_014_63FE::
    ld a, [$CFC2]
    cp a, $04
    jr c, Jump_014_63F0
    ld a, [$CFC3]
    and a, a
    jr z, Jump_014_63F0
    call Func_014_6189
    ld a, $0D
    ld [$CFBF], a
    ld a, $04
    ld [$CFC0], a
    jr Jump_014_63F0

Jump_014_641A::
    pop af
    push af
    cp a, $8D
    jr z, Jump_014_63FD
    dec hl
    call Func_014_68B5
    cp a, $FF
    jr z, Jump_014_63FD
    inc hl
    ld a, $8E
    ld [hl], a
    call Func_014_6C3F
    jr Jump_014_63FD

Jump_014_6431::
    pop af
    push af
    cp a, $8E
    jr z, Jump_014_63FD
    ld a, $8D
    ld [hl], a
    call Func_014_6C3F
    jr Jump_014_63FD

Jump_014_643F::
    ld a, [$CFA9]
    inc a
    inc a
    ld [$CFA9], a
    xor a, a
    ld [$D7F5], a
    ret

Jump_014_644C::
    ld a, [$CFA9]
    dec a
    ld [$CFA9], a
    xor a, a
    ld [$D7F5], a
    ret

Jump_014_6458::
    ld a, [$CFC2]
    and a, a
    jr z, Jump_014_646A
    ld a, [$CFA8]
    inc a
    ld [$CFA8], a
    xor a, a
    ld [$D7F5], a
    ret

Jump_014_646A::
    ld a, [$CFA9]
    inc a
    ld [$CFA9], a
    xor a, a
    ld [$D7F5], a
    ret

Jump_014_6476::
    call Func_014_6C70
    call Func_014_6992
    ld a, [$CFA8]
    inc a
    ld [$CFA8], a
    xor a, a
    ld [$D7F5], a
    ret

Jump_014_6488::
    ld hl, Data_014_6DF6
    ld de, $6E98
    call Func_014_6BF8
    cp a, $FF
    jr nz, Jump_014_64A9
    ld a, [$CFA9]
    inc a
    ld [$CFA9], a
    ld de, Data_01F_48E0
    ld hl, $9480
    ld b, $1F
    ld c, $10
    call Func_000_0B46

Jump_014_64A9::
    xor a, a
    ld [$D7F5], a
    ret

Jump_014_64AE::
    ld hl, Data_014_6DF6
    ld de, Data_014_6DF8
    call Func_014_6BF8
    cp a, $FF
    jr nz, Jump_014_64BF
    xor a, a
    ld [$CFA9], a

Jump_014_64BF::
    xor a, a
    ld [$D7F5], a
    ret

Jump_014_64C4::
    call Func_014_6804
    ld a, [$CFAA]
    rst $00
    dw Jump_014_64D3
    dw Jump_014_64F8
    dw Jump_014_6532
    dw Jump_014_656C

Jump_014_64D3::
    ld hl, $95C0
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
    ld a, [$CFAA]
    inc a
    ld [$CFAA], a
    xor a, a
    ld [$D7F5], a
    ret

Jump_014_64F8::
    call Func_014_6BCF
    ld de, $01E0
    add hl, de
    ld a, h
    ld [$D7F5], a
    ld a, l
    ld [$D7F6], a
    ld de, Data_014_7177
    ld a, d
    ld [$D7F1], a
    ld a, e
    ld [$D7F2], a
    ld a, $14
    ld [$D7F3], a
    ld a, $01
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    ld hl, $5D2A
    ld b, $1F
    rst $10
    ld a, [$CFAA]
    inc a
    ld [$CFAA], a
    xor a, a
    ld [$D7F5], a
    ret

Jump_014_6532::
    call Func_014_6BCF
    ld de, $01C0
    add hl, de
    ld a, h
    ld [$D7F5], a
    ld a, l
    ld [$D7F6], a
    ld de, Data_014_71B3
    ld a, d
    ld [$D7F1], a
    ld a, e
    ld [$D7F2], a
    ld a, $14
    ld [$D7F3], a
    ld a, $03
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    ld hl, $5D2A
    ld b, $1F
    rst $10
    ld a, [$CFAA]
    inc a
    ld [$CFAA], a
    xor a, a
    ld [$D7F5], a
    ret

Jump_014_656C::
    call Func_014_6BCF
    ld de, $01A0
    add hl, de
    ld a, h
    ld [$D7F5], a
    ld a, l
    ld [$D7F6], a
    ld de, Data_014_714F
    ld a, d
    ld [$D7F1], a
    ld a, e
    ld [$D7F2], a
    ld a, $14
    ld [$D7F3], a
    ld a, $05
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    ld hl, $5D2A
    ld b, $1F
    rst $10
    xor a, a
    ld [$CFAA], a
    ld a, [$CFA8]
    inc a
    ld [$CFA8], a
    xor a, a
    ld [$D7F5], a
    ret

Jump_014_65AA::
    call Func_014_6804
    ld a, [$CFAA]
    rst $00
    dw Jump_014_65DC
    dw Jump_014_6647
    dw Jump_014_6664
    dw Jump_014_6671
    dw Jump_014_6694
    dw Jump_014_65BD

Jump_014_65BD::
    xor a, a
    ld [$C528], a
    ld a, $03
    ld [$C529], a
    call Func_014_6B76
    cp a, $FF
    ret nz
    ld a, [$CFA8]
    add a, $04
    ld [$CFA8], a
    xor a, a
    ld [$CFBD], a
    ld [$D7F5], a
    ret

Jump_014_65DC::
    ld a, [$D7F1]
    and a, a
    jp z, Jump_014_661F
    call Func_014_6AB7
    cp a, $FF
    jr z, Jump_014_663A
    call Func_014_6B08
    cp a, $FF
    jr z, Jump_014_663A
    call Func_014_6A45
    cp a, $FF
    jr nz, Jump_014_6604
    ld a, [$CFAA]
    inc a
    ld [$CFAA], a
    xor a, a
    ld [$D7F5], a
    ret

Jump_014_6604::
    call Func_014_6AB7
    cp a, $FF
    jr z, Jump_014_663A
    call Func_014_6B08
    cp a, $FF
    jr z, Jump_014_663A
    ld a, [$CFAA]
    add a, $03
    ld [$CFAA], a
    xor a, a
    ld [$D7F5], a
    ret

Jump_014_661F::
    call Func_014_6AB7
    cp a, $FF
    jr z, Jump_014_663A
    call Func_014_6B08
    cp a, $FF
    jr z, Jump_014_663A
    ld a, [$CFAA]
    inc a
    inc a
    ld [$CFAA], a
    xor a, a
    ld [$D7F5], a
    ret

Jump_014_663A::
    ld a, [$CFAA]
    add a, $05
    ld [$CFAA], a
    xor a, a
    ld [$D7F5], a
    ret

Jump_014_6647::
    xor a, a
    ld [$C528], a
    ld a, $02
    ld [$C529], a
    call Func_014_6B76
    cp a, $FF
    jr nz, Jump_014_665F
    ld a, [$CFAA]
    inc a
    inc a
    ld [$CFAA], a

Jump_014_665F::
    xor a, a
    ld [$D7F5], a
    ret

Jump_014_6664::
    ld de, $C130
    ld a, [$CFAA]
    inc a
    ld [$CFAA], a
    jp Jump_014_6671

Jump_014_6671::
    ld hl, $CFAD
    ld de, $C130

Jump_014_6677::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_014_6685
    cp a, $9F
    jr z, Jump_014_6685
    ld [de], a
    inc hl
    inc de
    jr Jump_014_6677

Jump_014_6685::
    ld a, $F0
    ld [de], a
    ld a, [$CFAA]
    inc a
    ld [$CFAA], a
    xor a, a
    ld [$D7F5], a
    ret

Jump_014_6694::
    xor a, a
    ld [$C528], a
    ld [$C529], a
    call Func_014_6B76
    cp a, $FF
    ret nz
    xor a, a
    ld [$CFAA], a
    ld a, [$CFA8]
    inc a
    ld [$CFA8], a
    xor a, a
    ld [$D7F5], a
    ret

Jump_014_66B1::
    call Func_014_6804
    call Func_014_6BCF
    ld de, $010E
    add hl, de
    ld a, h
    ld [$D7F5], a
    ld a, l
    ld [$D7F6], a
    ld de, Data_014_71EF
    ld a, d
    ld [$D7F1], a
    ld a, e
    ld [$D7F2], a
    ld a, $06
    ld [$D7F3], a
    ld a, $05
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    ld hl, $5D2A
    ld b, $1F
    rst $10
    ld a, [$CFA8]
    inc a
    ld [$CFA8], a
    ld a, $6C
    call Func_000_1278
    xor a, a
    ld [$D7F5], a
    ret

Jump_014_66F3::
    call Func_014_6804
    call Func_014_68D5
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_014_6704
    cp a, $FF
    jr z, Jump_014_6714
    ret

Jump_014_6704::
    ld a, [$CFA8]
    inc a
    inc a
    ld [$CFA8], a
    xor a, a
    ld [$CFBD], a
    ld [$D7F5], a
    ret

Jump_014_6714::
    ld a, [$CFBD]
    and a, a
    jr nz, Jump_014_6704
    ld a, [$CFA8]
    inc a
    ld [$CFA8], a
    xor a, a
    ld [$CFBD], a
    ld [$D7F5], a
    ret

Jump_014_6729::
    call Func_014_6804
    ld a, [$CFAA]
    rst $00
    dw Jump_014_6734
    dw Jump_014_676A

Jump_014_6734::
    call Func_014_6BCF
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
    ld a, [$CFAA]
    inc a
    ld [$CFAA], a
    xor a, a
    ld [$D7F5], a
    ret

Jump_014_676A::
    ld hl, $CFAD
    ld de, $C8CF

Jump_014_6770::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_014_677E
    cp a, $9F
    jr z, Jump_014_677E
    ld [de], a
    inc hl
    inc de
    jr Jump_014_6770

Jump_014_677E::
    ld a, $F0
    ld [de], a
    ld hl, $CFA8
    ld bc, $001D

Jump_014_6787::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_014_6787
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
    ldh [$FFBA], a
    ld a, [$D7BC]
    ld a, $FF
    ld [$D7F5], a
    ret

Jump_014_67B0::
    call Func_014_6804
    call Func_014_6BCF
    ld de, $0100
    add hl, de
    ld a, h
    ld [$D7F5], a
    ld a, l
    ld [$D7F6], a
    ld de, Data_014_7087
    ld a, d
    ld [$D7F1], a
    ld a, e
    ld [$D7F2], a
    ld a, $14
    ld [$D7F3], a
    ld a, $0A
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    ld hl, $5D2A
    ld b, $1F
    rst $10
    ld a, $01
    ld [$CFA8], a
    xor a, a
    ld [$CFAA], a
    ld a, [$CFA9]
    cp a, $04
    jr nc, Jump_014_67FA
    xor a, a
    ld [$CFA9], a
    xor a, a
    ld [$D7F5], a
    ret

Jump_014_67FA::
    ld a, $05
    ld [$CFA9], a
    xor a, a
    ld [$D7F5], a
    ret

Func_014_6804::
    ld hl, $D7F1
    ld de, $CF8B
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
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [$D7F1]
    or a, a
    jr nz, Jump_014_6830
    ld hl, $44CE
    ld b, $04
    rst $10
    jr Jump_014_6856

Jump_014_6830::
    ld a, [$D7F4]
    ld [$D7F1], a
    ld a, [$D7F5]
    ld [$D7F2], a
    xor a, a
    ld [$D7F3], a
    ld a, $10
    ld [$D7F4], a
    ld a, $18
    ld [$D7F5], a
    xor a, a
    ld [$D7F6], a
    ld c, $00
    ld hl, $6A3D
    ld b, $1D
    rst $10

Jump_014_6856::
    ld hl, $CF8B
    ld de, $D7F1
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
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ret

Func_014_6875::
    ld de, Data_014_688A

Jump_014_6878::
    ld a, [de]
    cp a, $FF
    jr z, Jump_014_6887
    ld b, a
    ld a, [hl]
    cp a, b
    jr z, Jump_014_6885
    inc de
    jr Jump_014_6878

Jump_014_6885::
    xor a, a
    ret

Jump_014_6887::
    ld a, $FF
    ret

Data_014_688A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $3E, $3F, $40, $41, $42, $29, $2A, $2B, $2C, $2D, $2E, $2F, $30, $31, $32, $33
    db $34, $35, $37, $38, $75, $76, $77, $78, $79, $60, $61, $62, $63, $64, $65, $66
    db $67, $68, $69, $6A, $6B, $6C, $6E, $6F, $26, $5A, $FF

Func_014_68B5::
    ld de, Data_014_68CA

Jump_014_68B8::
    ld a, [de]
    cp a, $FF
    jr z, Jump_014_68C7
    ld b, a
    ld a, [hl]
    cp a, b
    jr z, Jump_014_68C5
    inc de
    jr Jump_014_68B8

Jump_014_68C5::
    xor a, a
    ret

Jump_014_68C7::
    ld a, $FF
    ret

Data_014_68CA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $3E, $3F, $40, $41, $42, $75, $76, $77, $78, $79, $FF

Func_014_68D5::
    ld a, [$C563]
    bit 6, a
    jr nz, Jump_014_68F3
    bit 7, a
    jr nz, Jump_014_6909
    ld a, [$C562]
    bit 0, a
    jr nz, Jump_014_692F
    bit 1, a
    jr nz, Jump_014_693D
    call Func_014_6943
    xor a, a
    ld [$D7F9], a
    ret

Jump_014_68F3::
    call Func_014_695A
    ld a, [$CFBD]
    and a, a
    jr nz, Jump_014_6903
    ld a, $01
    ld [$CFBD], a
    jr Jump_014_691D

Jump_014_6903::
    dec a
    ld [$CFBD], a
    jr Jump_014_691D

Jump_014_6909::
    call Func_014_695A
    ld a, [$CFBD]
    cp a, $01
    jr c, Jump_014_6919
    xor a, a
    ld [$CFBD], a
    jr Jump_014_691D

Jump_014_6919::
    inc a
    ld [$CFBD], a

Jump_014_691D::
    xor a, a
    ld [$CFBE], a
    call Func_014_6943
    ld a, $69
    call Func_000_1278
    ld a, $FD
    ld [$D7F9], a
    ret

Jump_014_692F::
    ld a, $69
    call Func_000_1278
    call Func_014_695E
    ld a, $FF
    ld [$D7F9], a
    ret

Jump_014_693D::
    ld a, $FE
    ld [$D7F9], a
    ret

Func_014_6943::
    ld a, [$CFBE]
    inc a
    ld [$CFBE], a
    cp a, $10
    jr c, Jump_014_6956
    cp a, $18
    jr c, Func_014_695A
    xor a, a
    ld [$CFBE], a

Jump_014_6956::
    ld b, $BB
    jr Jump_014_6960

Func_014_695A::
    ld b, $C3
    jr Jump_014_6960

Func_014_695E::
    ld b, $BC

Jump_014_6960::
    ld a, [$CFBD]
    add a, a
    ld hl, Data_014_697D
    add a, l
    ld l, a
    jr nc, Jump_014_696C
    inc h

Jump_014_696C::
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call Func_014_6BCF
    pop de
    add hl, de
    di
    call Func_000_120A
    ld a, b
    ld [hl], a
    ei
    ret

Data_014_697D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2F, $01, $6F, $01

Func_014_6981::
    ld c, $10

Jump_014_6983::
    di

Jump_014_6984::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_014_6984
    ld a, [hl+]
    ld [de], a
    inc de
    ei
    dec c
    jr nz, Jump_014_6983
    ret

Func_014_6992::
    ld hl, $CFAD
    ld bc, $0000

Jump_014_6998::
    ld a, [hl]
    cp a, $F0
    ret z
    ld [$CFBC], a
    push hl
    ld hl, Func_014_4010
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
    ld e, c
    ld d, b
    ld hl, $9500
    add hl, de
    pop de
    push bc
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    pop bc
    pop hl
    inc hl
    ld a, $10
    add a, c
    ld c, a
    jr nc, Jump_014_69CA
    inc b

Jump_014_69CA::
    jp Jump_014_6998
    db $40, $95, $30, $95, $20, $95, $10, $95, $00, $95, $D9, $69, $AD, $CF, $D5, $FA
    db $2D, $C5, $EA, $31, $C5, $EA, $35, $C5, $FA, $2E, $C5, $EA, $32, $C5, $EA, $36
    db $C5, $D1, $CD, $40, $2E, $7B, $EA, $33, $C5, $EA, $37, $C5, $7A, $EA, $34, $C5
    db $EA, $38, $C5, $3E, $01, $EA, $2B, $C5, $AF, $EA, $2C, $C5, $EA, $4F, $C5, $C9

Func_014_6A0D::
    push bc
    call Func_014_6BCF
    ld de, $0047
    add hl, de
    ld a, [$CFC2]
    add a, l
    ld l, a
    jr nc, Jump_014_6A1D
    inc h

Jump_014_6A1D::
    pop bc
    di

Jump_014_6A1F::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_014_6A1F
    ld [hl], b
    ei
    ret

Func_014_6A28::
    ld hl, $CFAD
    ld c, $00

Jump_014_6A2D::
    ld a, $F0
    ld [hl+], a
    inc c
    ld a, c
    cp a, $0B
    jr c, Jump_014_6A2D
    ld hl, $CFAD
    ld c, $00

Jump_014_6A3B::
    ld a, $9F
    ld [hl+], a
    inc c
    ld a, c
    cp a, $05
    jr c, Jump_014_6A3B
    ret

Func_014_6A45::
    ld hl, $A000
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld c, $00

Jump_014_6A53::
    ld a, [hl]
    and a, a
    jr z, Jump_014_6A7E
    push bc
    push hl
    inc hl
    ld de, $CFAD
    ld c, $00
    ld b, $00

Jump_014_6A61::
    ld a, [de]
    cp a, $9F
    jr nz, Jump_014_6A69
    inc de
    jr Jump_014_6A61

Jump_014_6A69::
    ld a, [de]
    cp a, $F0
    jr z, Jump_014_6A8D
    push bc
    ld b, a
    ld a, [hl]
    cp a, b
    jr nz, Jump_014_6A7B
    pop bc
    inc de
    inc hl
    inc c
    inc b
    jr Jump_014_6A61

Jump_014_6A7B::
    pop bc

Jump_014_6A7C::
    pop hl
    pop bc

Jump_014_6A7E::
    ld a, $A5
    add a, l
    ld l, a
    jr nc, Jump_014_6A85
    inc h

Jump_014_6A85::
    inc c
    ld a, c
    cp a, $1E
    jr c, Jump_014_6A53
    xor a, a
    ret

Jump_014_6A8D::
    ld a, c
    cp a, $0A
    jr z, Jump_014_6A97
    ld a, [hl]
    cp a, $F0
    jr nz, Jump_014_6A7C

Jump_014_6A97::
    ld a, [$D7F1]
    cp a, $03
    jr nz, Jump_014_6AB2
    ld hl, $C6FE
    ld a, [$D786]
    add a, l
    ld l, a
    jr nc, Jump_014_6AA9
    inc h

Jump_014_6AA9::
    ld e, [hl]
    pop hl
    pop bc
    push bc
    push hl
    ld a, c
    cp a, e
    jr z, Jump_014_6A7C

Jump_014_6AB2::
    pop hl
    pop bc
    ld a, $FF
    ret

Func_014_6AB7::
    ld hl, Data_014_70F0
    ld c, $00

Jump_014_6ABC::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_014_6AF0
    push bc
    push hl
    ld de, $CFAD
    ld c, $00
    ld b, $00

Jump_014_6ACA::
    ld a, [de]
    cp a, $9F
    jr nz, Jump_014_6AD2
    inc de
    jr Jump_014_6ACA

Jump_014_6AD2::
    ld a, [de]
    cp a, $F0
    jr z, Jump_014_6AF2
    push bc
    ld b, a
    ld a, [hl]
    cp a, b
    jr nz, Jump_014_6AE4
    pop bc
    inc de
    inc hl
    inc c
    inc b
    jr Jump_014_6ACA

Jump_014_6AE4::
    pop bc

Jump_014_6AE5::
    pop hl
    pop bc
    ld a, $0A
    add a, l
    ld l, a
    jr nc, Jump_014_6AEE
    inc h

Jump_014_6AEE::
    jr Jump_014_6ABC

Jump_014_6AF0::
    xor a, a
    ret

Jump_014_6AF2::
    ld a, c
    cp a, $0A
    jr z, Jump_014_6AFC
    ld a, [hl]
    cp a, $F0
    jr nz, Jump_014_6AE5

Jump_014_6AFC::
    ld a, [$D7F1]
    cp a, $03
    jr nz, Jump_014_6B03

Jump_014_6B03::
    pop hl
    pop bc
    ld a, $FF
    ret

Func_014_6B08::
    ld hl, $CFAD
    ld c, $00
    ld b, [hl]
    inc hl
    ld a, [hl-]
    cp a, $8D
    jr z, Jump_014_6B1D
    cp a, $8E
    jr z, Jump_014_6B1D
    xor a, a
    ld e, $00
    jr Jump_014_6B21

Jump_014_6B1D::
    ld d, a
    ld e, $01
    inc hl

Jump_014_6B21::
    inc hl

Jump_014_6B22::
    ld a, [hl]
    cp a, $9F
    jr z, Jump_014_6B61
    cp a, $F0
    jr z, Jump_014_6B64
    ld a, e
    and a, a
    jr z, Jump_014_6B48
    ld a, [hl]
    cp a, $8D
    jr z, Jump_014_6B58
    cp a, $8E
    jr z, Jump_014_6B58
    ld a, [hl]
    cp a, b
    jr nz, Jump_014_6B74
    inc hl
    ld a, [hl-]
    cp a, $8D
    jr z, Jump_014_6B61
    cp a, $8E
    jr z, Jump_014_6B61
    jr Jump_014_6B74

Jump_014_6B48::
    ld a, [hl]
    cp a, b
    jr nz, Jump_014_6B74
    inc hl
    ld a, [hl-]
    cp a, $8D
    jr z, Jump_014_6B61
    cp a, $8E
    jr z, Jump_014_6B61
    jr Jump_014_6B5B

Jump_014_6B58::
    cp a, d
    jr nz, Jump_014_6B74

Jump_014_6B5B::
    inc c
    ld a, c
    cp a, $03
    jr nc, Jump_014_6B64

Jump_014_6B61::
    inc hl
    jr Jump_014_6B22

Jump_014_6B64::
    ld a, c
    cp a, $03
    jr c, Jump_014_6B6C
    ld a, $FF
    ret

Jump_014_6B6C::
    ld a, b
    cp a, $90
    jr nz, Jump_014_6B74
    ld a, $FF
    ret

Jump_014_6B74::
    xor a, a
    ret

Func_014_6B76::
    ld a, [$CFC4]
    and a, a
    jr z, Jump_014_6B82
    cp a, $01
    jr z, Jump_014_6BA4
    jr Jump_014_6BBF

Jump_014_6B82::
    ld hl, $95C0
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
    ld a, [$CFC4]
    inc a
    ld [$CFC4], a
    xor a, a
    ret

Jump_014_6BA4::
    ld a, [$D7F1]
    cp a, $03
    jr z, Jump_014_6BB0
    ld de, Data_014_7003
    jr Jump_014_6BB3

Jump_014_6BB0::
    ld de, Data_014_706D

Jump_014_6BB3::
    call Func_000_25C9
    ld a, [$CFC4]
    inc a
    ld [$CFC4], a
    xor a, a
    ret

Jump_014_6BBF::
    ld a, [$C52B]
    bit 0, a
    jr nz, Jump_014_6BCD
    xor a, a
    ld [$CFC4], a
    ld a, $FF
    ret

Jump_014_6BCD::
    xor a, a
    ret

Func_014_6BCF::
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
    ldh a, [$FFA1]
    srl a
    srl a
    srl a
    add a, e
    ld e, a
    jr nc, Jump_014_6BF3
    inc d

Jump_014_6BF3::
    ld a, e
    ld l, a
    ld a, d
    ld h, a
    ret

Func_014_6BF8::
    push hl
    push de
    ld a, [$CFAB]
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_014_6C03
    inc h

Jump_014_6C03::
    ld a, [hl]
    cp a, $FF
    jp z, Jump_014_6C33
    ld e, a
    inc hl
    ld h, [hl]
    ld l, e
    pop de
    push de
    push hl
    ld a, [$CFAB]
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_014_6C19
    inc d

Jump_014_6C19::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld d, a
    ld a, l
    ld e, a
    pop hl
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    pop de
    pop hl
    ld a, [$CFAB]
    inc a
    ld [$CFAB], a
    jr Func_014_6BF8

Jump_014_6C33::
    pop de
    pop hl
    xor a, a
    ld [$CFAB], a
    ld [$CFAC], a
    ld a, $FF
    ret

Func_014_6C3F::
    ld hl, Data_014_6C56
    ld a, [$CFC2]
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_014_6C4B
    inc h

Jump_014_6C4B::
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    ld de, Data_014_6C60
    call Func_014_6981
    ret

Data_014_6C56:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $95, $10, $95, $20, $95, $30, $95, $40, $95

Data_014_6C60:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00

Func_014_6C70::
    ld a, [$D7F1]
    or a, a
    jp z, Jump_014_6D28
    ld a, [$C5E7]
    ld b, a

Jump_014_6C7B::
    ld a, b
    cp a, $4D
    jr c, Jump_014_6C85
    sub a, $4D
    ld b, a
    jr Jump_014_6C7B

Jump_014_6C85::
    and a, $7F
    cp a, $07
    jp nc, Jump_014_6CC0
    ld b, a
    ld hl, Data_014_7439
    ld a, [$D7F3]
    and a, $0F
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_014_6C9B
    inc h

Jump_014_6C9B::
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, [$D7F2]
    ld c, a
    add a, a
    add a, c
    ld c, a
    ld a, [$D7F2]
    add a, a
    add a, a
    add a, c
    ld c, a
    ld a, b
    add a, c
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_014_6CB4
    inc d

Jump_014_6CB4::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld de, $CFAD
    call Func_014_6CEA
    ret

Jump_014_6CC0::
    sub a, $07
    ld b, a
    push bc
    ld a, [$D7F2]
    and a, $01
    ld c, $46
    call Func_000_1682
    pop bc
    ld a, b
    add a, l
    ld de, Data_014_791F
    ld l, a
    ld h, $00
    sla l
    rl h
    add hl, de
    ld e, l
    ld d, h
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld de, $CFAD
    call Func_014_6CEA
    ret

Func_014_6CEA::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_014_6CF4
    ld [de], a
    inc de
    inc hl
    jr Func_014_6CEA

Jump_014_6CF4::
    ld b, $C3
    call Func_014_6A0D
    ld hl, $CFAD
    ld c, $00

Jump_014_6CFE::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_014_6D13
    cp a, $9F
    jr z, Jump_014_6D18
    cp a, $8D
    jr z, Jump_014_6D10
    cp a, $8E
    jr z, Jump_014_6D10
    inc c

Jump_014_6D10::
    inc hl
    jr Jump_014_6CFE

Jump_014_6D13::
    ld a, $01
    ld [$CFC3], a

Jump_014_6D18::
    ld a, c
    cp a, $05
    jr c, Jump_014_6D1F
    ld a, $04

Jump_014_6D1F::
    ld [$CFC2], a
    ld b, $55
    call Func_014_6A0D
    ret

Jump_014_6D28::
    ld a, [$D7F2]
    or a, a
    jr nz, Jump_014_6D42
    ld hl, $CFAD
    ld hl, $CFAD
    ld a, $0C
    ld [hl+], a
    ld a, $32
    ld [hl+], a
    ld a, $25
    ld [hl+], a
    ld a, $2C
    ld [hl], a
    jr Jump_014_6D54

Jump_014_6D42::
    ld hl, $CFAD
    ld hl, $CFAD
    ld a, $1D
    ld [hl+], a
    ld a, $24
    ld [hl+], a
    ld a, $35
    ld [hl+], a
    ld a, $24
    ld [hl], a

Jump_014_6D54::
    jr Jump_014_6CF4

Data_014_6D56:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $20, $90, $30, $90, $40, $90, $50, $90, $60, $90, $70, $90, $80, $90, $90, $90
    db $A0, $90, $B0, $90, $C0, $90, $D0, $90, $E0, $90

Data_014_6D70:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $F0, $90, $00, $91, $10, $91, $20, $91, $30, $91, $40, $91, $50, $91, $60, $91
    db $70, $91, $80, $91

Data_014_6D84:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $052D84, $72

Data_014_6DF6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $FF

Data_014_6DF8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $40, $C0, $40, $D0, $40, $E0, $40
    dw Func_014_40F0
    dw Func_014_4100
    dw Func_014_4110
    dw Func_014_4120
    db $30, $41
    dw Func_014_4140
    dw Func_014_4150
    dw Func_014_4160
    dw $4170
    dw Func_014_4010
    dw Func_014_4020
    dw Func_014_4030
    dw Func_014_4040
    dw $4180
    dw Func_014_4190
    dw $41A0
    dw Func_014_41B0
    dw $41C0
    db $D0, $41
    dw Func_014_41E0
    dw Func_014_41F0
    dw Func_014_4200
    dw Func_014_4210
    dw Func_014_4220
    dw Func_014_4230
    dw Func_014_4240
    dw Func_014_4050
    dw Func_014_4060
    dw Func_014_4070
    dw Func_014_4080
    dw $4250
    dw Func_014_4260
    dw Func_014_4270
    dw Func_014_4280
    dw Func_014_4290
    dw Func_014_42A0
    dw Func_014_42B0
    dw Func_014_42C0
    dw Func_014_42D0
    dw Func_014_42E0
    db $F0, $42
    dw Func_014_4300
    dw Func_014_4310
    dw Func_014_4090
    dw Func_014_40A0
    dw $49A0
    dw Func_014_4990
    dw $4320
    dw Func_014_4330
    dw $4340
    dw Func_014_4350
    dw Func_014_4360
    dw $4370
    dw Func_014_4380
    db $90, $43, $A0, $43, $B0, $43
    dw $43C0
    dw Func_014_43D0
    dw Func_014_43E0
    dw $40C0
    dw Func_014_40B0
    db $D0, $40, $50, $41, $60, $49, $C0, $4A, $60, $4B, $50, $49, $40, $49, $00, $4B
    dw Func_014_4A00
    dw Func_014_4A00
    dw Func_014_4A00
    dw Func_014_4A00
    dw Func_014_4A00
    db $FF, $FF
    dw $4570
    dw Func_014_4590
    dw Func_014_45B0
    dw Func_014_45D0
    dw $45F0
    db $10, $46, $20, $46, $30, $46, $40, $46, $50, $46
    dw Func_014_4660
    dw Func_014_4670
    dw Func_014_4680
    dw $4690
    db $A0, $46, $B0, $46, $C0, $46, $D0, $46, $F0, $46
    dw Func_014_4700
    dw Func_014_4710
    dw Func_014_4720
    dw Func_014_4730
    db $40, $47
    dw Func_014_4750
    dw Func_014_4020
    dw Func_014_4030
    dw Func_014_4040
    dw Func_014_4050
    dw Func_014_4060
    dw Func_014_4760
    db $70, $47, $80, $47, $90, $47, $A0, $47, $B0, $47, $C0, $47, $D0, $47
    dw Func_014_47E0
    dw Func_014_47F0
    dw Func_014_4800
    dw Func_014_4820
    dw Func_014_4840
    dw Func_014_4860
    dw Func_014_4870
    dw Func_014_4880
    dw $4890
    dw $48A0
    dw $48B0
    dw Func_014_48C0
    db $D0, $48
    dw Func_014_46E0
    dw Func_014_49D0
    dw Func_014_4070
    dw Func_014_4080
    dw Func_014_4090
    dw Func_014_40A0
    dw Func_014_4010
    db $80, $45, $A0, $45
    dw Func_014_45C0
    dw Func_014_45E0
    dw Func_014_4600
    dw Func_014_4810
    dw Func_014_4830
    dw Func_014_4850
    dw Func_014_48E0
    dw Func_014_48F0
    dw Func_014_4400
    dw Func_014_44F0
    dw Func_014_42A0
    dw Func_014_43A0
    db $80, $44
    dw Func_014_4510
    dw Func_014_4290
    dw Func_014_4540
    dw Func_014_4510
    dw Func_014_4A00
    dw Func_014_4A00
    dw Func_014_4A00
    dw Func_014_4A00
    dw Func_014_4A00
    db $FF, $FF

Data_014_6F3E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $00, $FF, $FF, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00

Data_014_6F4E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $052F4E, $99

Data_014_6FE7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $74, $8A, $8B, $8C, $6D, $9C, $FE, $FF, $FF, $FF, $FF, $FF, $01, $02, $03, $04
    db $05, $06, $07, $08, $09, $00, $FF, $FF, $FF, $FF, $FF, $FF

Data_014_7003:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $053003, $6A

Data_014_706D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $6F, $70, $77, $70, $84, $70, $91, $70, $B2, $70, $EB, $45, $90, $12, $36, $90
    db $F9, $00, $90, $18, $14, $98, $F0, $EB, $45, $90

Data_014_7087:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $053087, $69

Data_014_70F0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0530F0, $5F

Data_014_714F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $00, $0F, $38, $26, $2E, $F0, $00, $00, $00, $00, $00, $0F
    db $1E, $0C, $14, $F0

Data_014_7163:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $00, $1C, $2B, $2C, $37, $F0, $00, $00, $00, $00, $00, $1C
    db $11, $12, $1D, $F0

Data_014_7177:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $00, $1C, $28, $3B, $F0, $00, $00, $00, $00, $00, $00, $1C
    db $0E, $21, $F0, $00, $00, $00, $00, $00, $00, $19, $32, $32, $33, $F0, $00, $00
    db $00, $00, $00, $19, $18, $18, $19, $F0, $00, $00, $00, $00, $00, $0D, $32, $31
    db $2A, $F0, $00, $00, $00, $00, $00, $0D, $18, $17, $10, $F0

Data_014_71B3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $00, $19, $28, $31, $28, $F0, $00, $00, $00, $00, $00, $19
    db $0E, $17, $0E, $F0, $00, $00, $00, $00, $00, $0C, $2F, $2C, $37, $F0, $00, $00
    db $00, $00, $00, $0C, $15, $12, $1D, $F0, $00, $00, $00, $00, $00, $1D, $3A, $24
    db $37, $F0, $00, $00, $00, $00, $00, $1D, $20, $0A, $1D, $F0

Data_014_71EF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0531EF, $24A

Data_014_7439:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_014_744F
    dw Data_014_74BF
    dw Data_014_752F
    dw Data_014_759F
    dw Data_014_760F
    dw Data_014_767F
    dw Data_014_76EF
    dw Data_014_775F
    dw Data_014_77CF
    dw Data_014_783F
    dw Data_014_78AF

Data_014_744F:: ; heuristic: target of a monotone pointer table; C0
    dw Data_014_746B
    dw Data_014_7471
    dw Data_014_7477
    dw Data_014_747D
    dw Data_014_7483
    dw Data_014_7489
    dw Data_014_748F
    dw Data_014_7495
    dw Data_014_749B
    dw Data_014_74A1
    dw Data_014_74A7
    dw Data_014_74AD
    dw Data_014_74B3
    dw Data_014_74B9

Data_014_746B:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $2C, $25, $9F, $F0

Data_014_7471:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $24, $35, $26, $28, $F0

Data_014_7477:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $32, $31, $32, $9F, $F0

Data_014_747D:: ; heuristic: target of a monotone pointer table; C0
    db $16, $2C, $2F, $28, $36, $F0

Data_014_7483:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $25, $25, $24, $F0

Data_014_7489:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $28, $35, $2C, $32, $F0

Data_014_748F:: ; heuristic: target of a monotone pointer table; C0
    db $18, $31, $28

Data_014_7492:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $32, $9F, $F0

Data_014_7495:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $24, $35, $2C, $F0

Data_014_749B:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $28, $35, $24, $F0

Data_014_74A1:: ; heuristic: target of a monotone pointer table; C0
    db $19, $38, $35, $2F, $24, $F0

Data_014_74A7:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2C, $2E, $32, $35, $F0

Data_014_74AD:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $2C, $33, $33, $9F, $F0

Data_014_74B3:: ; heuristic: target of a monotone pointer table; C0
    db $19, $28, $37, $37, $2C, $F0

Data_014_74B9:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2B, $24, $2F, $32, $F0

Data_014_74BF:: ; heuristic: target of a monotone pointer table; C0
    dw Data_014_74DB
    dw Data_014_74E1
    dw Data_014_74E7
    dw Data_014_74ED
    dw Data_014_74F3
    dw Data_014_74F9
    dw Data_014_74FF
    dw Data_014_7505
    dw Data_014_750B
    dw Data_014_7511
    dw Data_014_7517
    dw Data_014_751D
    dw Data_014_7523
    dw Data_014_7529

Data_014_74DB:: ; heuristic: target of a monotone pointer table; C0
    db $11, $32, $35, $35, $3C, $F0

Data_014_74E1:: ; heuristic: target of a monotone pointer table; C0
    db $14, $24, $25, $28, $2F, $F0

Data_014_74E7:: ; heuristic: target of a monotone pointer table; C0
    db $10, $24, $2F, $28, $37, $F0

Data_014_74ED:: ; heuristic: target of a monotone pointer table; C0
    db $19, $32, $35, $33, $32, $F0

Data_014_74F3:: ; heuristic: target of a monotone pointer table; C0
    db $14, $28, $2D, $28, $37, $F0

Data_014_74F9:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $32, $35, $24, $27, $F0

Data_014_74FF:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $24, $35, $32, $31, $F0

Data_014_7505:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $32, $38, $2A, $28, $F0

Data_014_750B:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $3D, $24, $35, $2C, $F0

Data_014_7511:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2B, $24, $25, $32, $F0

Data_014_7517:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $35, $2C, $36, $36, $F0

Data_014_751D:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $38, $31, $24, $35, $F0

Data_014_7523:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $38, $27, $2C, $9F, $F0

Data_014_7529:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $38, $3C, $9F, $9F, $F0

Data_014_752F:: ; heuristic: target of a monotone pointer table; C0
    dw Data_014_754B
    dw Data_014_7551
    dw Data_014_7557
    dw Data_014_755D
    dw Data_014_7563
    dw Data_014_7569
    dw Data_014_756F
    dw Data_014_7575
    dw Data_014_757B
    dw Data_014_7581
    dw Data_014_7587
    dw Data_014_758D
    dw Data_014_7593
    dw Data_014_7599

Data_014_754B:: ; heuristic: target of a monotone pointer table; C0
    db $1E, $3A, $2C, $31, $2A, $F0

Data_014_7551:: ; heuristic: target of a monotone pointer table; C0
    db $12, $39, $28, $35, $9F, $F0

Data_014_7557:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $32, $27, $30, $24, $F0

Data_014_755D:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $2C, $27, $2C, $28, $F0

Data_014_7563:: ; heuristic: target of a monotone pointer table; C0
    db $16

Data_014_7564:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $24, $35, $2A, $2A, $F0

Data_014_7569:: ; heuristic: target of a monotone pointer table; C0
    db $18, $2A, $24, $30, $2C, $F0

Data_014_756F:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $24, $35, $35, $32, $F0

Data_014_7575:: ; heuristic: target of a monotone pointer table; C0
    db $17, $2C, $2E, $2C, $37, $F0

Data_014_757B:: ; heuristic: target of a monotone pointer table; C0
    db $16, $28, $36, $36, $24, $F0

Data_014_7581:: ; heuristic: target of a monotone pointer table; C0
    db $15, $24, $35, $30, $24, $F0

Data_014_7587:: ; heuristic: target of a monotone pointer table; C0
    db $13, $24, $31, $31, $38, $F0

Data_014_758D:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $28, $39, $35, $2C, $F0

Data_014_7593:: ; heuristic: target of a monotone pointer table; C0
    db $13, $24, $39, $28, $2F, $F0

Data_014_7599:: ; heuristic: target of a monotone pointer table; C0
    db $10

Data_014_759A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $38, $35, $35, $2C, $F0

Data_014_759F:: ; heuristic: target of a monotone pointer table; C0
    dw Data_014_75BB
    dw Data_014_75C1
    dw Data_014_75C7
    dw Data_014_75CD
    dw Data_014_75D3
    dw Data_014_75D9
    dw Data_014_75DF
    dw Data_014_75E5
    dw Data_014_75EB
    dw Data_014_75F1
    dw Data_014_75F7
    dw Data_014_75FD
    dw Data_014_7603
    dw Data_014_7609

Data_014_75BB:: ; heuristic: target of a monotone pointer table; C0
    db $19, $24, $37, $37, $24, $F0

Data_014_75C1:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $28, $31, $2D, $3C, $F0

Data_014_75C7:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $31, $2A, $3C, $9F, $F0

Data_014_75CD:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $32, $39, $3C, $31, $F0

Data_014_75D3:: ; heuristic: target of a monotone pointer table; C0
    db $15, $28, $2C, $37, $9F, $F0

Data_014_75D9:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $3C, $35, $32, $31, $F0

Data_014_75DF:: ; heuristic: target of a monotone pointer table; C0
    db $17, $2C, $2F, $36, $28, $F0

Data_014_75E5:: ; heuristic: target of a monotone pointer table; C0
    db $19, $24, $2E, $2C, $31, $F0

Data_014_75EB:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $28, $35, $35, $9F, $F0

Data_014_75F1:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $24, $30, $24, $35, $F0

Data_014_75F7:: ; heuristic: target of a monotone pointer table; C0
    db $14, $24, $26, $2C, $36, $F0

Data_014_75FD:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $24, $2E, $2C, $9F, $F0

Data_014_7603:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $2F, $2F, $2C, $F0

Data_014_7609:: ; heuristic: target of a monotone pointer table; C0
    db $16, $32, $2E, $32, $9F, $F0

Data_014_760F:: ; heuristic: target of a monotone pointer table; C0
    dw Data_014_762B
    dw Data_014_7631
    dw Data_014_7637
    dw Data_014_763D
    dw Data_014_7643
    dw Data_014_7649
    dw Data_014_764F
    dw Data_014_7655
    dw Data_014_765B
    dw Data_014_7661
    dw Data_014_7667
    dw Data_014_766D
    dw Data_014_7673
    dw Data_014_7679

Data_014_762B:: ; heuristic: target of a monotone pointer table; C0
    db $10, $24, $31, $2C, $30, $F0

Data_014_7631:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $28, $2F, $35, $2C, $F0

Data_014_7637:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $24, $2C, $30, $9F, $F0

Data_014_763D:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $24, $35, $3D, $3D, $F0

Data_014_7643:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2C, $37, $24, $9F, $F0

Data_014_7649:: ; heuristic: target of a monotone pointer table; C0
    db $19, $28, $3C, $32, $37, $F0

Data_014_764F:: ; heuristic: target of a monotone pointer table; C0
    db $16, $38, $33, $33, $24, $F0

Data_014_7655:: ; heuristic: target of a monotone pointer table; C0
    db $15, $24, $39, $28, $31, $F0

Data_014_765B:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $24, $35, $24, $27, $F0

Data_014_7661:: ; heuristic: target of a monotone pointer table; C0
    db $10, $3C, $24, $30, $9F, $F0

Data_014_7667:: ; heuristic: target of a monotone pointer table; C0
    db $10, $38, $30, $30, $3C, $F0

Data_014_766D:: ; heuristic: target of a monotone pointer table; C0
    db $19, $38, $33, $38, $2F, $F0

Data_014_7673:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $24, $31, $3C, $2F, $F0

Data_014_7679:: ; heuristic: target of a monotone pointer table; C0
    db $19, $32, $33, $2F, $24, $F0

Data_014_767F:: ; heuristic: target of a monotone pointer table; C0
    dw Data_014_769B
    dw Data_014_76A1
    dw Data_014_76A7
    dw Data_014_76AD
    dw Data_014_76B3
    dw Data_014_76B9
    dw Data_014_76BF
    dw Data_014_76C5
    dw Data_014_76CB
    dw Data_014_76D1
    dw Data_014_76D7
    dw Data_014_76DD
    dw Data_014_76E3
    dw Data_014_76E9

Data_014_769B:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $25, $2C, $2C, $9F, $F0

Data_014_76A1:: ; heuristic: target of a monotone pointer table; C0
    db $1E, $2F, $35, $2C, $2E, $F0

Data_014_76A7:: ; heuristic: target of a monotone pointer table; C0
    db $20, $28, $35, $37, $2B, $F0

Data_014_76AD:: ; heuristic: target of a monotone pointer table; C0
    db $10, $35, $38, $31, $37, $F0

Data_014_76B3:: ; heuristic: target of a monotone pointer table; C0
    db $10, $2F, $24, $37, $2B, $F0

Data_014_76B9:: ; heuristic: target of a monotone pointer table; C0
    db $10, $24, $30, $2B, $24, $F0

Data_014_76BF:: ; heuristic: target of a monotone pointer table; C0
    db $16, $32, $24, $2B, $30, $F0

Data_014_76C5:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $35, $32, $31, $F0

Data_014_76CB:: ; heuristic: target of a monotone pointer table; C0
    db $1A, $38, $2C, $2C, $9F, $F0

Data_014_76D1:: ; heuristic: target of a monotone pointer table; C0
    db $14, $32, $2E, $2C, $36, $F0

Data_014_76D7:: ; heuristic: target of a monotone pointer table; C0
    db $13, $38, $27, $27, $2C, $F0

Data_014_76DD:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2B, $28, $35, $35, $F0

Data_014_76E3:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2F, $2C, $36, $36, $F0

Data_014_76E9:: ; heuristic: target of a monotone pointer table; C0
    db $10, $38, $39, $35, $2C, $F0

Data_014_76EF:: ; heuristic: target of a monotone pointer table; C0
    dw Data_014_770B
    dw Data_014_7711
    dw Data_014_7717
    dw Data_014_771D
    dw Data_014_7723
    dw Data_014_7729
    dw Data_014_772F
    dw Data_014_7735
    dw Data_014_773B
    dw Data_014_7741
    dw Data_014_7747
    dw Data_014_774D
    dw Data_014_7753
    dw Data_014_7759

Data_014_770B:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $24, $30, $2C, $24, $F0

Data_014_7711:: ; heuristic: target of a monotone pointer table; C0
    db $1A, $38, $25, $28, $9F, $F0

Data_014_7717:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $2C, $2A, $2A, $9F, $F0

Data_014_771D:: ; heuristic: target of a monotone pointer table; C0
    db $13, $24, $3B, $32, $31, $F0

Data_014_7723:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2B, $28, $2F, $9F, $F0

Data_014_7729:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $24, $38, $36, $36, $F0

Data_014_772F:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $31, $26, $2B, $32, $F0

Data_014_7735:: ; heuristic: target of a monotone pointer table; C0
    db $12, $3C, $24, $31, $9F, $F0

Data_014_773B:: ; heuristic: target of a monotone pointer table; C0
    db $12, $35, $35, $2C, $36, $F0

Data_014_7741:: ; heuristic: target of a monotone pointer table; C0
    db $14, $28, $35, $2C

Data_014_7745:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2A, $F0

Data_014_7747:: ; heuristic: target of a monotone pointer table; C0
    db $14, $24, $2C, $26, $32, $F0

Data_014_774D:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $24, $2F, $32, $35, $F0

Data_014_7753:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $2E, $31, $28, $36, $F0

Data_014_7759:: ; heuristic: target of a monotone pointer table; C0
    db $17, $2C, $39, $28, $2F, $F0

Data_014_775F:: ; heuristic: target of a monotone pointer table; C0
    dw Data_014_777B
    dw Data_014_7781
    dw Data_014_7787
    dw Data_014_778D
    dw Data_014_7793
    dw Data_014_7799
    dw Data_014_779F
    dw Data_014_77A5
    dw Data_014_77AB
    dw Data_014_77B1
    dw Data_014_77B7
    dw Data_014_77BD
    dw Data_014_77C3
    dw Data_014_77C9

Data_014_777B:: ; heuristic: target of a monotone pointer table; C0
    db $10, $2F, $28, $3C, $9F, $F0

Data_014_7781:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $28, $35, $32, $31, $F0

Data_014_7787:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $32, $31, $24, $27, $F0

Data_014_778D:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $32, $25, $32, $36, $F0

Data_014_7793:: ; heuristic: target of a monotone pointer table; C0
    db $13, $38, $31, $24, $36, $F0

Data_014_7799:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $38, $33, $28, $2F, $F0

Data_014_779F:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $32, $2F, $32, $F0

Data_014_77A5:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $38, $30, $2C, $9F, $F0

Data_014_77AB:: ; heuristic: target of a monotone pointer table; C0
    db $14

Data_014_77AC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $3C, $24, $35, $9F, $F0

Data_014_77B1:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $32, $3D, $24, $35, $F0

Data_014_77B7:: ; heuristic: target of a monotone pointer table; C0
    db $14, $3C, $35, $2C, $28, $F0

Data_014_77BD:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2C, $31, $24, $9F, $F0

Data_014_77C3:: ; heuristic: target of a monotone pointer table; C0
    db $16, $3C, $35, $24, $31, $F0

Data_014_77C9:: ; heuristic: target of a monotone pointer table; C0
    db $19, $24, $31, $27, $32, $F0

Data_014_77CF:: ; heuristic: target of a monotone pointer table; C0
    dw Data_014_77EB
    dw Data_014_77F1
    dw Data_014_77F7
    dw Data_014_77FD
    dw Data_014_7803
    dw Data_014_7809
    dw Data_014_780F
    dw Data_014_7815
    dw Data_014_781B
    dw Data_014_7821
    dw Data_014_7827
    dw Data_014_782D
    dw Data_014_7833
    dw Data_014_7839

Data_014_77EB:: ; heuristic: target of a monotone pointer table; C0
    db $14, $2B, $28, $35, $2C, $F0

Data_014_77F1:: ; heuristic: target of a monotone pointer table; C0
    db $17, $28, $36, $37, $24, $F0

Data_014_77F7:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $31, $39, $24

Data_014_77FB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $35, $F0

Data_014_77FD:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $3C, $31, $2A, $9F, $F0

Data_014_7803:: ; heuristic: target of a monotone pointer table; C0
    db $18, $2F, $3C, $39, $24, $F0

Data_014_7809:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $35, $2C, $27, $3D, $F0

Data_014_780F:: ; heuristic: target of a monotone pointer table; C0
    db $12, $3A, $24, $31, $9F, $F0

Data_014_7815:: ; heuristic: target of a monotone pointer table; C0
    db $22, $36, $36, $24, $9F, $F0

Data_014_781B:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $39, $39, $2C, $F0

Data_014_7821:: ; heuristic: target of a monotone pointer table; C0
    db $18, $33, $24, $2F, $2F, $F0

Data_014_7827:: ; heuristic: target of a monotone pointer table; C0
    db $13, $2C, $27, $27, $24, $F0

Data_014_782D:: ; heuristic: target of a monotone pointer table; C0
    db $16, $38, $35, $35, $2C, $F0

Data_014_7833:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $2C, $31, $24, $F0

Data_014_7839:: ; heuristic: target of a monotone pointer table; C0
    db $22, $32, $32, $35, $2C, $F0

Data_014_783F:: ; heuristic: target of a monotone pointer table; C0
    dw Data_014_785B
    dw Data_014_7861
    dw Data_014_7867
    dw Data_014_786D
    dw Data_014_7873
    dw Data_014_7879
    dw Data_014_787F
    dw Data_014_7885
    dw Data_014_788B
    dw Data_014_7891
    dw Data_014_7897
    dw Data_014_789D
    dw Data_014_78A3
    dw Data_014_78A9

Data_014_785B:: ; heuristic: target of a monotone pointer table; C0
    db $12, $3D, $24, $2E, $9F, $F0

Data_014_7861:: ; heuristic: target of a monotone pointer table; C0
    db $20, $24, $2F, $2F, $2C, $F0

Data_014_7867:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $32, $27, $24, $9F, $F0

Data_014_786D:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $39, $2C, $9F, $9F, $F0

Data_014_7873:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $31, $3C, $9F, $F0

Data_014_7879:: ; heuristic: target of a monotone pointer table; C0
    db $13, $24, $3A, $24, $2B, $F0

Data_014_787F:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $24, $39, $2C, $31, $F0

Data_014_7885:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $3C, $24, $26, $2C, $F0

Data_014_788B:: ; heuristic: target of a monotone pointer table; C0
    db $16, $2C, $3D, $38, $35, $F0

Data_014_7891:: ; heuristic: target of a monotone pointer table; C0
    db $19, $38, $35, $2F, $2F, $F0

Data_014_7897:: ; heuristic: target of a monotone pointer table; C0
    db $18, $24, $36, $2C, $3D, $F0

Data_014_789D:: ; heuristic: target of a monotone pointer table; C0
    db $17, $24, $27, $28, $24, $F0

Data_014_78A3:: ; heuristic: target of a monotone pointer table; C0
    db $15, $38, $24, $9F, $9F, $F0

Data_014_78A9:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $32, $39, $2C, $31, $F0

Data_014_78AF:: ; heuristic: target of a monotone pointer table; C0
    dw Data_014_78CB
    dw Data_014_78D1
    dw Data_014_78D7
    dw Data_014_78DD
    dw Data_014_78E3
    dw Data_014_78E9
    dw Data_014_78EF
    dw Data_014_78F5
    dw Data_014_78FB
    dw Data_014_7901
    dw Data_014_7907
    dw Data_014_790D
    dw Data_014_7913
    dw Data_014_7919

Data_014_78CB:: ; heuristic: target of a monotone pointer table; C0
    db $11, $28, $39, $31, $3D, $F0

Data_014_78D1:: ; heuristic: target of a monotone pointer table; C0
    db $11, $24, $27, $28, $3D, $F0

Data_014_78D7:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $2E, $35, $32, $F0

Data_014_78DD:: ; heuristic: target of a monotone pointer table; C0
    db $18, $36, $2E, $35, $32, $F0

Data_014_78E3:: ; heuristic: target of a monotone pointer table; C0
    db $16, $2C, $35, $2C, $32, $F0

Data_014_78E9:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $24, $36, $2C, $36, $F0

Data_014_78EF:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $2E, $38, $2F, $2F, $F0

Data_014_78F5:: ; heuristic: target of a monotone pointer table; C0
    db $15, $28, $27, $24, $2B, $F0

Data_014_78FB:: ; heuristic: target of a monotone pointer table; C0
    db $1E, $2F, $33, $2B, $9F, $F0

Data_014_7901:: ; heuristic: target of a monotone pointer table; C0
    db $20, $3C, $2F, $2F, $9F, $F0

Data_014_7907:: ; heuristic: target of a monotone pointer table; C0
    db $20, $28, $39, $9F, $9F, $F0

Data_014_790D:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $28, $36, $2C, $2F, $F0

Data_014_7913:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $3C, $24, $2F, $2F, $F0

Data_014_7919:: ; heuristic: target of a monotone pointer table; C0
    db $20, $24, $2F, $37, $3D, $F0

Data_014_791F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_014_7A37
    dw Data_014_7A3D
    dw Data_014_7A43
    dw Data_014_7A49
    dw Data_014_7A4F
    dw Data_014_7A55
    dw Data_014_7A5B
    dw Data_014_7A61
    dw Data_014_7A67
    dw Data_014_7A6D
    dw Data_014_7A73
    dw Data_014_7A79
    dw Data_014_7A7F
    dw Data_014_7A85
    dw Data_014_7A8B
    dw Data_014_7A91
    dw Data_014_7A97
    dw Data_014_7A9D
    dw Data_014_7AA3
    dw Data_014_7AA9
    dw Data_014_7AAF
    dw Data_014_7AB5
    dw Data_014_7ABB
    dw Data_014_7AC1
    dw Data_014_7AC7
    dw Data_014_7ACD
    dw Data_014_7AD3
    dw Data_014_7AD9
    dw Data_014_7ADF
    dw Data_014_7AE5
    dw Data_014_7AEB

Data_014_795D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_014_7AF1
    dw Data_014_7AF7
    dw Data_014_7AFD
    dw Data_014_7B03
    dw Data_014_7B09
    dw Data_014_7B0F
    dw Data_014_7B15
    dw Data_014_7B1B
    dw Data_014_7B21
    dw Data_014_7B27
    dw Data_014_7B2D
    dw Data_014_7B33
    dw Data_014_7B39
    dw Data_014_7B3F
    dw Data_014_7B45
    dw Data_014_7B4B
    dw Data_014_7B51
    dw Data_014_7B57
    dw Data_014_7B5D
    dw Data_014_7B63
    dw Data_014_7B69
    dw Data_014_7B6F
    dw Data_014_7B75
    dw Data_014_7B7B
    dw Data_014_7B81
    dw Data_014_7B87
    dw Data_014_7B8D
    dw Data_014_7B93
    dw Data_014_7B99
    dw Data_014_7B9F
    dw Data_014_7BA5
    dw Data_014_7BAB
    dw Data_014_7BB1
    dw Data_014_7BB7
    dw Data_014_7BBD
    dw Data_014_7BC3
    dw Data_014_7BC9
    dw Data_014_7BCF
    dw Data_014_7BD5
    dw Data_014_7BDB
    dw Data_014_7BE1
    dw Data_014_7BE7
    dw Data_014_7BED
    dw Data_014_7BF3
    dw Data_014_7BF9
    dw Data_014_7BFF
    dw Data_014_7C05
    dw Data_014_7C0B
    dw Data_014_7C11
    dw Data_014_7C17
    dw Data_014_7C1D
    dw Data_014_7C23
    dw Data_014_7C29
    dw Data_014_7C2F
    dw Data_014_7C35
    dw Data_014_7C3B
    dw Data_014_7C41
    dw Data_014_7C47
    dw Data_014_7C4D
    dw Data_014_7C53
    dw Data_014_7C59
    dw Data_014_7C5F
    dw Data_014_7C65
    dw Data_014_7C6B
    dw Data_014_7C71
    dw Data_014_7C77
    dw Data_014_7C7D
    dw Data_014_7C83
    dw Data_014_7C89
    dw Data_014_7C8F
    dw Data_014_7C95
    dw Data_014_7C9B
    dw Data_014_7CA1
    dw Data_014_7CA7
    dw Data_014_7CAD
    dw Data_014_7CB3
    dw Data_014_7CB9
    dw Data_014_7CBF
    dw Data_014_7CC5
    dw Data_014_7CCB
    dw Data_014_7CD1
    dw Data_014_7CD7
    dw Data_014_7CDD
    dw Data_014_7CE3
    dw Data_014_7CE9
    dw Data_014_7CEF
    dw Data_014_7CF5
    dw Data_014_7CFB
    dw Data_014_7D01
    dw Data_014_7D07
    dw Data_014_7D0D
    dw Data_014_7D13
    dw Data_014_7D19
    dw Data_014_7D1F
    dw Data_014_7D25
    dw Data_014_7D2B
    dw Data_014_7D31
    dw Data_014_7D37
    db $3D
    dw Func_014_437D
    dw Func_014_497D
    dw Func_014_4F7D
    dw Func_014_557D
    db $7D, $5B, $7D, $61, $7D, $67, $7D, $6D, $7D, $73, $7D, $79, $7D

Data_014_7A37:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $3C, $2E, $28, $31, $F0

Data_014_7A3D:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $9F, $9F, $9F, $F0

Data_014_7A43:: ; heuristic: target of a monotone pointer table; C0
    db $19, $3C, $31, $31, $9F

Data_014_7A48:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $F0

Data_014_7A49:: ; heuristic: target of a monotone pointer table; C0
    db $19, $24, $3D, $38, $9F, $F0

Data_014_7A4F:: ; heuristic: target of a monotone pointer table; C0
    db $14, $32, $35, $27, $2C, $F0

Data_014_7A55:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $3C, $30, $25, $32, $F0

Data_014_7A5B:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2B, $28, $36

Data_014_7A5F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $37, $F0

Data_014_7A61:: ; heuristic: target of a monotone pointer table; C0
    db $23, $28, $35, $35, $32, $F0

Data_014_7A67:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $2F, $3C, $24, $2B, $F0

Data_014_7A6D:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $28, $35, $32, $2F, $F0

Data_014_7A73:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $24, $35, $28, $2F, $F0

Data_014_7A79:: ; heuristic: target of a monotone pointer table; C0
    db $10, $24, $35, $32, $31, $F0

Data_014_7A7F:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $2F, $37, $2B, $32, $F0

Data_014_7A85:: ; heuristic: target of a monotone pointer table; C0
    db $16, $38, $31, $32, $31, $F0

Data_014_7A8B:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $2F, $29, $28, $35, $F0

Data_014_7A91:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $32, $37, $38, $30, $F0

Data_014_7A97:: ; heuristic: target of a monotone pointer table; C0
    db $13, $38, $31, $31, $32, $F0

Data_014_7A9D:: ; heuristic: target of a monotone pointer table; C0
    db $20, $28, $2C, $25, $9F, $F0

Data_014_7AA3:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $32, $35, $30, $24, $F0

Data_014_7AA9:: ; heuristic: target of a monotone pointer table; C0
    db $11, $38, $2E, $2E, $38, $F0

Data_014_7AAF:: ; heuristic: target of a monotone pointer table; C0
    db $10, $28, $37, $37, $38, $F0

Data_014_7AB5:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2C, $27, $3D, $24, $F0

Data_014_7ABB:: ; heuristic: target of a monotone pointer table; C0
    db $17, $24, $2E, $2E, $9F, $F0

Data_014_7AC1:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $38, $2F, $32, $9F, $F0

Data_014_7AC7:: ; heuristic: target of a monotone pointer table; C0
    db $18, $2F, $2A, $24, $31, $F0

Data_014_7ACD:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $28, $29, $37, $2C, $F0

Data_014_7AD3:: ; heuristic: target of a monotone pointer table; C0
    db $18, $36, $2B, $24, $31, $F0

Data_014_7AD9:: ; heuristic: target of a monotone pointer table; C0
    db $17, $32, $26, $2E, $32, $F0

Data_014_7ADF:: ; heuristic: target of a monotone pointer table; C0
    db $18, $2F, $37, $2B, $32, $F0

Data_014_7AE5:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $3D, $28, $35, $F0

Data_014_7AEB:: ; heuristic: target of a monotone pointer table; C0
    db $11, $3C, $27, $28, $9F, $F0

Data_014_7AF1:: ; heuristic: target of a monotone pointer table; C0
    db $18, $35, $32, $35, $24, $F0

Data_014_7AF7:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $24, $35, $2F, $2C, $F0

Data_014_7AFD:: ; heuristic: target of a monotone pointer table; C0
    db $18, $29, $29, $36, $2C, $F0

Data_014_7B03:: ; heuristic: target of a monotone pointer table; C0
    db $14, $24, $33, $37, $24, $F0

Data_014_7B09:: ; heuristic: target of a monotone pointer table; C0
    db $13, $24, $36, $36, $9F, $F0

Data_014_7B0F:: ; heuristic: target of a monotone pointer table; C0
    db $23, $28, $2C, $2E, $9F, $F0

Data_014_7B15:: ; heuristic: target of a monotone pointer table; C0
    db $22, $38, $31, $31, $9F, $F0

Data_014_7B1B:: ; heuristic: target of a monotone pointer table; C0
    db $13, $38, $31, $2C, $24, $F0

Data_014_7B21:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $38, $2F, $9F, $9F, $F0

Data_014_7B27:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2C, $28, $2F, $2F, $F0

Data_014_7B2D:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $32, $2F, $37, $32, $F0

Data_014_7B33:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $38, $2F, $32, $9F, $F0

Data_014_7B39:: ; heuristic: target of a monotone pointer table; C0
    db $13, $2C, $2E, $2C, $2F, $F0

Data_014_7B3F:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $28, $39, $2C, $31, $F0

Data_014_7B45:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $28, $37, $2B, $24, $F0

Data_014_7B4B:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $2C, $36, $36, $F0

Data_014_7B51:: ; heuristic: target of a monotone pointer table; C0
    db $14, $38, $31, $32, $31, $F0

Data_014_7B57:: ; heuristic: target of a monotone pointer table; C0
    db $23, $24, $2E, $38, $2F, $F0

Data_014_7B5D:: ; heuristic: target of a monotone pointer table; C0
    db $14, $2C, $35, $38, $24, $F0

Data_014_7B63:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $32, $35, $25, $2C, $F0

Data_014_7B69:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2C, $37, $28, $3C, $F0

Data_014_7B6F:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $39, $2C, $31, $9F, $F0

Data_014_7B75:: ; heuristic: target of a monotone pointer table; C0
    db $14, $38, $2F, $32, $28, $F0

Data_014_7B7B:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $38, $27, $2C, $9F, $F0

Data_014_7B81:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $2B, $3C, $9F, $F0

Data_014_7B87:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $38, $38, $9F, $9F, $F0

Data_014_7B8D:: ; heuristic: target of a monotone pointer table; C0
    db $10, $24, $35, $35, $2C, $F0

Data_014_7B93:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $24, $25, $38, $9F, $F0

Data_014_7B99:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $28, $2B, $27, $24, $F0

Data_014_7B9F:: ; heuristic: target of a monotone pointer table; C0
    db $14, $24, $35, $37, $32, $F0

Data_014_7BA5:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $2C, $24, $9F, $9F, $F0

Data_014_7BAB:: ; heuristic: target of a monotone pointer table; C0
    db $16, $38, $37, $24, $2B, $F0

Data_014_7BB1:: ; heuristic: target of a monotone pointer table; C0
    db $16, $32, $31, $36, $38, $F0

Data_014_7BB7:: ; heuristic: target of a monotone pointer table; C0
    db $19, $38, $2F, $2E, $9F, $F0

Data_014_7BBD:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $24, $2C, $3D, $9F, $F0

Data_014_7BC3:: ; heuristic: target of a monotone pointer table; C0
    db $23, $28, $2C, $2F, $9F, $F0

Data_014_7BC9:: ; heuristic: target of a monotone pointer table; C0
    db $14, $24, $3D, $31, $24, $F0

Data_014_7BCF:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2C, $2E, $2E, $24, $F0

Data_014_7BD5:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $28, $35, $3D, $32, $F0

Data_014_7BDB:: ; heuristic: target of a monotone pointer table; C0
    db $16, $38, $28, $3C, $9F, $F0

Data_014_7BE1:: ; heuristic: target of a monotone pointer table; C0
    db $16, $3C, $36, $37, $2C, $F0

Data_014_7BE7:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $24, $30, $24, $31, $F0

Data_014_7BED:: ; heuristic: target of a monotone pointer table; C0
    db $12, $24, $31, $24, $9F, $F0

Data_014_7BF3:: ; heuristic: target of a monotone pointer table; C0
    db $16, $2C, $2E, $2E, $32, $F0

Data_014_7BF9:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $32, $33, $24, $3D, $F0

Data_014_7BFF:: ; heuristic: target of a monotone pointer table; C0
    db $19, $38, $2F, $24, $30, $F0

Data_014_7C05:: ; heuristic: target of a monotone pointer table; C0
    db $17, $3C, $24, $35, $9F, $F0

Data_014_7C0B:: ; heuristic: target of a monotone pointer table; C0
    db $23, $32, $31, $2C, $24, $F0

Data_014_7C11:: ; heuristic: target of a monotone pointer table; C0
    db $19, $38, $2F, $2C, $31, $F0

Data_014_7C17:: ; heuristic: target of a monotone pointer table; C0
    db $14, $31, $38, $2F, $2F, $F0

Data_014_7C1D:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $24, $38, $2F, $2C, $F0

Data_014_7C23:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $24, $35, $2C, $31, $F0

Data_014_7C29:: ; heuristic: target of a monotone pointer table; C0
    db $16, $3C, $2F, $2E, $2C, $F0

Data_014_7C2F:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $2F, $29, $38, $24, $F0

Data_014_7C35:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $38, $35, $2C, $2F, $F0

Data_014_7C3B:: ; heuristic: target of a monotone pointer table; C0
    db $11, $24, $30, $28, $31, $F0

Data_014_7C41:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $2A, $2A, $9F, $F0

Data_014_7C47:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $30, $30, $28, $F0

Data_014_7C4D:: ; heuristic: target of a monotone pointer table; C0
    db $11, $32, $2B, $30, $2C, $F0

Data_014_7C53:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $36, $28, $37, $F0

Data_014_7C59:: ; heuristic: target of a monotone pointer table; C0
    db $14, $24, $37, $38, $24, $F0

Data_014_7C5F:: ; heuristic: target of a monotone pointer table; C0
    db $19, $24, $28, $2F, $24, $F0

Data_014_7C65:: ; heuristic: target of a monotone pointer table; C0
    db $19, $38, $37, $37, $2C, $F0

Data_014_7C6B:: ; heuristic: target of a monotone pointer table; C0
    db $16, $3C, $30, $28, $28, $F0

Data_014_7C71:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $31, $31, $2C, $36, $F0

Data_014_7C77:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $2E, $2E, $2C, $F0

Data_014_7C7D:: ; heuristic: target of a monotone pointer table; C0
    db $13, $28, $30, $31, $2C, $F0

Data_014_7C83:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2B, $24, $24, $35, $F0

Data_014_7C89:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $29, $2C, $31, $F0

Data_014_7C8F:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2C, $24, $31, $31, $F0

Data_014_7C95:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $2F, $2C, $31, $F0

Data_014_7C9B:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $24, $33, $2F, $2C, $F0

Data_014_7CA1:: ; heuristic: target of a monotone pointer table; C0
    db $16, $38, $2F, $37, $3C, $F0

Data_014_7CA7:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $26, $2B, $24, $2C, $F0

Data_014_7CAD:: ; heuristic: target of a monotone pointer table; C0
    db $11, $3C, $2F, $27, $24, $F0

Data_014_7CB3:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2B, $24, $35, $32, $F0

Data_014_7CB9:: ; heuristic: target of a monotone pointer table; C0
    db $16, $2C, $2F, $2F, $2E, $F0

Data_014_7CBF:: ; heuristic: target of a monotone pointer table; C0
    db $16, $2C, $2F, $27, $24, $F0

Data_014_7CC5:: ; heuristic: target of a monotone pointer table; C0
    db $14, $32, $31, $31, $2C, $F0

Data_014_7CCB:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $38, $31, $27, $2C, $F0

Data_014_7CD1:: ; heuristic: target of a monotone pointer table; C0
    db $14, $32, $30, $28, $37, $F0

Data_014_7CD7:: ; heuristic: target of a monotone pointer table; C0
    db $16, $28, $2F, $24, $31, $F0

Data_014_7CDD:: ; heuristic: target of a monotone pointer table; C0
    db $16, $32, $38, $35, $24, $F0

Data_014_7CE3:: ; heuristic: target of a monotone pointer table; C0
    db $16, $32, $31, $28, $3D, $F0

Data_014_7CE9:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $2F, $2F, $24, $31, $F0

Data_014_7CEF:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $35, $2C, $36, $36, $F0

Data_014_7CF5:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $38, $2F, $32, $28, $F0

Data_014_7CFB:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2F, $32, $35, $24, $F0

Data_014_7D01:: ; heuristic: target of a monotone pointer table; C0
    db $17, $2C, $37, $2B, $28, $F0

Data_014_7D07:: ; heuristic: target of a monotone pointer table; C0
    db $22, $38, $3A, $30, $2C, $F0

Data_014_7D0D:: ; heuristic: target of a monotone pointer table; C0
    db $22, $38, $35, $35, $32, $F0

Data_014_7D13:: ; heuristic: target of a monotone pointer table; C0
    db $19, $24, $2C, $3D, $28, $F0

Data_014_7D19:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $28, $2F, $28, $31, $F0

Data_014_7D1F:: ; heuristic: target of a monotone pointer table; C0
    db $11, $28, $35, $28, $31, $F0

Data_014_7D25:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $28, $2F, $24, $2B, $F0

Data_014_7D2B:: ; heuristic: target of a monotone pointer table; C0
    db $16, $2C, $31, $37, $32, $F0

Data_014_7D31:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $2C, $37, $37, $32, $F0

Data_014_7D37:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $053D37, $48

Func_014_7D7F::
    ld a, [$D7F1]
    cp a, $1E
    jr nc, Jump_014_7DB2
    cp a, $1D
    jr z, Jump_014_7D9E
    ld c, $6F
    call Func_000_1682
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld de, $B356
    add hl, de
    jr Jump_014_7DAB

Jump_014_7D9E::
    ld hl, $A000
    ld a, $0A
    ld [$1FFF], a
    ld a, $01
    ld [$4100], a

Jump_014_7DAB::
    ld b, $6F

Jump_014_7DAD::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_014_7DAD

Jump_014_7DB2::
    ld hl, $B356
    ld de, $B3C5
    xor a, a
    ld [$4100], a
    ld bc, $0000

Jump_014_7DBF::
    push de
    push hl
    ld a, [hl]
    bit 7, a
    jr nz, Jump_014_7DCD
    ld a, [de]
    bit 7, a
    jr nz, Jump_014_7DE7
    jr Jump_014_7DD6

Jump_014_7DCD::
    pop hl
    ld a, $6F
    add a, l
    ld l, a
    jr nc, Jump_014_7DD5
    inc h

Jump_014_7DD5::
    push hl

Jump_014_7DD6::
    pop hl
    pop de
    ld a, $6F
    add a, e
    ld e, a
    jr nc, Jump_014_7DDF
    inc d

Jump_014_7DDF::
    inc c
    ld a, c
    cp a, $1D
    jr c, Jump_014_7DBF
    jr Jump_014_7DF8

Jump_014_7DE7::
    pop hl
    pop de
    ld a, [de]
    ld [hl+], a
    xor a, a
    ld [de], a
    inc de
    ld b, $6E

Jump_014_7DF0::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_014_7DF0
    jr Jump_014_7DDF

Jump_014_7DF8::
    ld hl, $B356
    xor a, a
    ld [$4100], a
    ld c, $00

Jump_014_7E01::
    ld a, [hl]
    bit 7, a
    jr z, Jump_014_7E16
    ld a, l
    add a, $6F
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc c
    ld a, c
    cp a, $1D
    jr c, Jump_014_7E01
    jr Jump_014_7E44

Jump_014_7E16::
    push hl
    ld de, $CA2B
    ld hl, $A000
    ld a, $01
    ld [$4100], a
    ld b, $6F

Jump_014_7E24::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_014_7E24
    ld hl, $A000
    ld b, $6F

Jump_014_7E2F::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_014_7E2F
    pop hl
    xor a, a
    ld [$4100], a
    ld de, $CA2B
    ld b, $6F

Jump_014_7E3E::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_014_7E3E

Jump_014_7E44::
    xor a, a
    ld [$4100], a
    ld hl, $B356
    ld c, $00

Jump_014_7E4D::
    ld a, [hl]
    bit 7, a
    jr nz, Jump_014_7E6D

Jump_014_7E52::
    ld a, c
    ld [$D7F5], a
    ld a, l
    ld [$D7F6], a
    ld a, h
    ld [$D7F7], a
    ld b, $6F

Jump_014_7E60::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_014_7E60
    xor a, a
    ld [$1FFF], a
    ld [$4100], a
    ret

Jump_014_7E6D::
    ld a, $6F
    add a, l
    ld l, a
    jr nc, Jump_014_7E74
    inc h

Jump_014_7E74::
    inc c
    ld a, c
    cp a, $1D
    jr c, Jump_014_7E4D
    ld a, $01
    ld [$4100], a
    ld hl, $A000
    ld a, [hl]
    bit 7, a
    jr nz, Jump_014_7E89
    jr Jump_014_7E52

Jump_014_7E89::
    ld a, $FF
    ld [$D7F5], a
    xor a, a
    ld [$1FFF], a
    ld [$4100], a
    ret

Func_014_7E96::
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld a, [$D7F1]
    cp a, $1E
    jr nc, Jump_014_7EB6
    ld c, $A5
    call Func_000_1682
    ld de, $A000
    add hl, de
    ld b, $A5

Jump_014_7EB1::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_014_7EB1

Jump_014_7EB6::
    ld hl, $A000
    ld de, $A0A5
    ld bc, $0000

Jump_014_7EBF::
    push de
    push hl
    ld a, [hl]
    cp a, $01
    jr z, Jump_014_7ED5
    cp a, $02
    jr z, Jump_014_7ED5
    ld a, [de]
    cp a, $01
    jr z, Jump_014_7EEF
    cp a, $02
    jr z, Jump_014_7EEF
    jr Jump_014_7EDE

Jump_014_7ED5::
    pop hl
    ld a, $A5
    add a, l
    ld l, a
    jr nc, Jump_014_7EDD
    inc h

Jump_014_7EDD::
    push hl

Jump_014_7EDE::
    pop hl
    pop de
    ld a, $A5
    add a, e
    ld e, a
    jr nc, Jump_014_7EE7
    inc d

Jump_014_7EE7::
    inc c
    ld a, c
    cp a, $1E
    jr c, Jump_014_7EBF
    jr Jump_014_7F00

Jump_014_7EEF::
    pop hl
    pop de
    ld a, [de]
    ld [hl+], a
    xor a, a
    ld [de], a
    inc de
    ld b, $A4

Jump_014_7EF8::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_014_7EF8
    jr Jump_014_7EE7

Jump_014_7F00::
    xor a, a
    ld [$D7F3], a
    ld a, [$D7F2]
    and a, a
    jr nz, Jump_014_7F41
    ld a, [$D7F1]
    cp a, $1E
    jr nc, Jump_014_7F41
    ld b, a
    ld a, [$C6FD]
    ld e, a
    ld c, $00
    ld hl, $C6FE

Jump_014_7F1B::
    ld a, [hl]
    cp a, b
    jr z, Jump_014_7F28
    inc hl
    inc c
    ld a, c
    cp a, e
    jr c, Jump_014_7F1B
    jp Jump_014_7F41

Jump_014_7F28::
    ld a, c
    cp a, $02
    jr z, Jump_014_7F33
    inc hl
    ld a, [hl-]
    ld [hl+], a
    inc c
    jr Jump_014_7F28

Jump_014_7F33::
    xor a, a
    ld [hl], a
    ld a, [$C6FD]
    dec a
    ld [$C6FD], a
    ld a, $01
    ld [$D7F3], a

Jump_014_7F41::
    ld hl, $C6FE
    ld a, [$D7F1]
    cp a, $1E
    jr nc, Jump_014_7F5F
    ld c, $00

Jump_014_7F4D::
    ld a, [hl]
    ld b, a
    ld a, [$D7F1]
    cp a, b
    jr nc, Jump_014_7F58
    ld a, b
    dec a
    ld [hl], a

Jump_014_7F58::
    inc hl
    inc c
    ld a, c
    cp a, $03
    jr c, Jump_014_7F4D

Jump_014_7F5F::
    ld hl, $A000
    ld c, $00

Jump_014_7F64::
    ld a, [hl]
    cp a, $01
    jr z, Jump_014_7F85
    cp a, $02
    jr z, Jump_014_7F85
    ld a, c
    ld [$D7F5], a
    ld a, l
    ld [$D7F6], a
    ld a, h
    ld [$D7F7], a
    ld b, $A5

Jump_014_7F7B::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_014_7F7B
    xor a, a
    ld [$1FFF], a
    ret

Jump_014_7F85::
    ld a, $A5
    add a, l
    ld l, a
    jr nc, Jump_014_7F8C
    inc h

Jump_014_7F8C::
    inc c
    ld a, c
    cp a, $1E
    jr c, Jump_014_7F64
    ld a, $FF
    ld [$D7F5], a
    xor a, a
    ld [$1FFF], a
    ret

Func_014_7F9C::
    ld a, [$D09D]
    ld c, a
    ld b, $00
    ld hl, Data_014_7439
    add hl, bc
    add hl, bc
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, [$D09E]
    ld c, a
    jr Jump_014_7FB9
    db $FA, $9E, $D0, $4F, $06, $00, $21, $1F, $79

Jump_014_7FB9::
    add hl, bc
    add hl, bc
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, [$D09F]
    ld e, a
    ld a, [$D0A0]
    ld d, a

Jump_014_7FC6::
    ld a, [hl+]
    cp a, $9F
    jr z, Jump_014_7FC6
    ld [de], a
    cp a, $F0
    jr z, Jump_014_7FD3
    inc de
    jr Jump_014_7FC6

Jump_014_7FD3::
    ret
    ds $2C, $00
