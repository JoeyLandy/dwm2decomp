SECTION "Bank 0A", ROMX[$4000], BANK[$0A]
    db $0A

Func_00A_4001::
    call Func_00A_4196
    ld a, [$C46B]
    inc a
    ld [$C46B], a
    cp a, $05
    ret nz
    ld a, $0A
    ld [$0100], a
    ld a, [$C46C]
    or a, a
    jr nz, Jump_00A_4021
    call Func_00A_4110
    call Func_00A_4055
    jr Jump_00A_4027

Jump_00A_4021::
    call Func_00A_40A4
    call Func_00A_4055

Jump_00A_4027::
    xor a, a
    ld [$0100], a
    ld a, [$C915]
    and a, $07
    jr z, Jump_00A_4042
    ld a, $04
    ld [$C916], a
    xor a, a
    ld [$C917], a
    ld hl, $405C
    ld b, $13
    rst $10
    ret

Jump_00A_4042::
    ld a, [$CC44]
    bit 7, a
    jr nz, Jump_00A_404F
    ld a, $00
    ld [$C5DC], a
    ret

Jump_00A_404F::
    ld a, $05
    ld [$C5DC], a
    ret

Func_00A_4055::
    ld a, [$C88C]
    and a, $01
    ret z
    ld a, [$C6FD]
    ld b, a
    ld hl, $C6FE

Jump_00A_4062::
    push bc
    ld a, [hl]
    ld c, $55
    call Func_000_1F80
    bit 7, a
    jr nz, Jump_00A_4095
    bit 0, a
    jr z, Jump_00A_4095
    ld a, [hl]
    ld c, $5F
    call Func_000_1F89
    ldh a, [$FFC6]
    ld e, a
    ldh a, [$FFC7]
    ld d, a
    ld a, e
    or a, d
    jr z, Jump_00A_4095
    ld a, e
    sub a, $01
    ld e, a
    ld a, d
    sbc a, $00
    ld d, a
    push hl
    ld a, [hl]
    ld c, $5F
    call Func_000_1FD1
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl], a
    pop hl

Jump_00A_4095::
    inc hl
    pop bc
    dec b
    jr nz, Jump_00A_4062
    ret

Func_00A_409B::
    ld a, [$C8BF]
    set 7, a
    ld [$C8BF], a
    ret

Func_00A_40A4::
    ld a, [$C6FD]
    ld b, a
    ld hl, $C6FE

Jump_00A_40AB::
    push bc
    ld a, [hl]
    ld c, $55
    call Func_000_1F80
    bit 7, a
    jr nz, Jump_00A_410A
    bit 2, a
    jr z, Jump_00A_410A
    ld a, [hl]
    ld c, $5B
    call Func_000_1F89
    ldh a, [$FFC6]
    ld e, a
    ldh a, [$FFC7]
    ld d, a
    ld a, e
    sub a, $01
    ld e, a
    ld a, d
    sbc a, $00
    ld d, a
    bit 7, a
    jr nz, Jump_00A_40D5
    or a, e
    jr nz, Jump_00A_40FE

Jump_00A_40D5::
    ld c, $01
    call Func_00A_409B
    ld a, [$C6FD]
    sub a, b
    jr z, Jump_00A_40E6
    ld b, a

Jump_00A_40E1::
    sla c
    dec b
    jr nz, Jump_00A_40E1

Jump_00A_40E6::
    ld a, [$C915]
    or a, c
    ld [$C915], a
    push hl
    ld a, [hl]
    ld c, $55
    call Func_000_1FD1
    ld a, [hl]
    and a, $F3
    or a, $80
    ld [hl], a
    pop hl
    ld de, $0000

Jump_00A_40FE::
    push hl
    ld a, [hl]
    ld c, $5B
    call Func_000_1FD1
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl], a
    pop hl

Jump_00A_410A::
    inc hl
    pop bc
    dec b
    jr nz, Jump_00A_40AB
    ret

Func_00A_4110::
    ld a, [$C6FD]
    ld b, a
    ld hl, $C6FE

Jump_00A_4117::
    push bc
    ld a, [hl]
    ld c, $55
    call Func_000_1F80
    bit 7, a
    jr nz, Jump_00A_4190
    ld a, [hl]
    ld c, $5B
    call Func_000_1F89
    ldh a, [$FFC6]
    ld e, a
    ldh a, [$FFC7]
    ld d, a
    ld a, [$C915]
    bit 7, a
    jr nz, Jump_00A_413E
    ld c, $0A
    ld a, $40
    ld [$C8BF], a
    jr Jump_00A_414F

Jump_00A_413E::
    ld c, $02
    ld a, [$CC44]
    bit 7, a
    jr nz, Jump_00A_414F
    ldh a, [$FF90]
    cp a, $3A
    jr nz, Jump_00A_414F
    ld c, $05

Jump_00A_414F::
    ld a, e
    sub a, c
    ld e, a
    ld a, d
    sbc a, $00
    ld d, a
    bit 7, a
    jr nz, Jump_00A_415D
    or a, e
    jr nz, Jump_00A_4184

Jump_00A_415D::
    ld c, $01
    call Func_00A_409B
    ld a, [$C6FD]
    sub a, b
    jr z, Jump_00A_416E
    ld b, a

Jump_00A_4169::
    sla c
    dec b
    jr nz, Jump_00A_4169

Jump_00A_416E::
    ld a, [$C915]
    or a, c
    ld [$C915], a
    push hl
    ld a, [hl]
    ld c, $55
    call Func_000_1FD1
    ld a, [hl]
    or a, $80
    ld [hl], a
    pop hl
    ld de, $0000

Jump_00A_4184::
    push hl
    ld a, [hl]
    ld c, $5B
    call Func_000_1FD1
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl], a
    pop hl

Jump_00A_4190::
    inc hl
    pop bc
    dec b
    jr nz, Jump_00A_4117
    ret

Func_00A_4196::
    ld a, [$C46B]
    or a, a
    jr nz, Jump_00A_41C1
    ld a, $66
    call Func_000_1278
    ld hl, $C5E9
    ld a, $D2
    ld [hl+], a
    ld a, $D2
    ld [hl+], a
    ld a, $E2
    ld [hl], a
    ld a, [$C525]
    or a, a
    jr z, Jump_00A_4213
    ld hl, $C49F
    ld de, $C0F0
    ld bc, $0040
    call Func_000_0952
    jr Jump_00A_420E

Jump_00A_41C1::
    ld a, [$C46B]
    srl a
    srl a
    and a, $01
    jr z, Jump_00A_41EC
    ld hl, $C5E9
    ld a, $D2
    ld [hl+], a
    ld a, $D2
    ld [hl+], a
    ld a, $E2
    ld [hl], a
    ld a, [$C525]
    or a, a
    jr z, Jump_00A_4213
    ld hl, $C0F0
    ld de, $C49F
    ld bc, $0040
    call Func_000_0952
    jr Jump_00A_420E

Jump_00A_41EC::
    ld hl, $C5E9
    ld a, $2D
    ld [hl+], a
    ld a, $2D
    ld [hl+], a
    ld a, $1D
    ld [hl], a
    ld a, [$C525]
    or a, a
    jr z, Jump_00A_4213
    ld b, $40
    ld hl, $C0F0
    ld de, $C49F

Jump_00A_4206::
    ld a, [hl+]
    xor a, $FF
    ld [de], a
    inc de
    dec b
    jr nz, Jump_00A_4206

Jump_00A_420E::
    ld a, $7F
    ld [$C526], a

Jump_00A_4213::
    ret

Func_00A_4214::
    ld a, [$C194]
    rst $00
    dw Jump_00A_4228
    dw Jump_00A_4243
    dw Jump_00A_424D
    dw Jump_00A_4257
    dw Jump_00A_4261
    dw Jump_00A_4271
    dw Jump_00A_4229
    dw Jump_00A_4239

Jump_00A_4228::
    ret

Jump_00A_4229::
    ld a, $50
    ldh [$FFC7], a
    ld a, $80
    ld [$C915], a
    ld a, $40
    ld [$C8BF], a
    jr Jump_00A_427B

Jump_00A_4239::
    ld a, $52
    ldh [$FFC7], a
    xor a, a
    ld [$C915], a
    jr Jump_00A_427B

Jump_00A_4243::
    ld a, $44
    ldh [$FFC7], a
    xor a, a
    ld [$C915], a
    jr Jump_00A_427B

Jump_00A_424D::
    ld a, $56
    ldh [$FFC7], a
    xor a, a
    ld [$C915], a
    jr Jump_00A_427B

Jump_00A_4257::
    ld a, $44
    ldh [$FFC7], a
    xor a, a
    ld [$C915], a
    jr Jump_00A_427B

Jump_00A_4261::
    ld a, $44
    ldh [$FFC7], a
    ld a, $80
    ld [$C915], a
    ld a, $40
    ld [$C8BF], a
    jr Jump_00A_427B

Jump_00A_4271::
    ld a, $44
    ldh [$FFC7], a
    xor a, a
    ld [$C915], a
    jr Jump_00A_427B

Jump_00A_427B::
    ld a, [$C56C]
    or a, a
    ret nz
    ld a, [$C91F]
    or a, a
    ret nz
    ld a, [$D069]
    or a, a
    ret nz
    ldh a, [$FF8E]
    ld b, a
    ldh a, [$FF91]
    ld c, a
    call Func_00A_461E
    ldh a, [$FFC7]
    ld c, a
    ld a, [$C910]
    cp a, c
    jr z, Jump_00A_42AF
    ld a, [$C911]
    cp a, c
    jr z, Jump_00A_42AF
    ld a, [$C912]
    cp a, c
    jr z, Jump_00A_42AF
    ld a, [$C913]
    cp a, c
    jr z, Jump_00A_42AF
    ret

Jump_00A_42AF::
    ld a, $07
    ld [$C5DC], a
    xor a, a
    ld [$C46B], a
    ld [$C46C], a
    ret

Func_00A_42BC::
    ldh a, [$FF8C]
    bit 7, a
    ret nz
    bit 5, a
    ret nz
    ld de, $0002
    call Func_000_181B
    ret nc
    ld a, [$C5DC]
    and a, $0F
    dec a
    ret z
    ld a, [$C5DC]
    cp a, $07
    ret z
    ld a, [$CC44]
    bit 7, a
    jr nz, Jump_00A_42F1
    ldh a, [$FF90]
    cp a, $20
    ret c
    ld c, a
    ld hl, $4374

Jump_00A_42E8::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_00A_42FD
    cp a, c
    ret z
    jr Jump_00A_42E8

Jump_00A_42F1::
    cp a, $82
    ret z
    cp a, $83
    ret z
    cp a, $84
    ret z
    cp a, $87
    ret z

Jump_00A_42FD::
    ld a, $0A
    ld [$0100], a
    ld a, [$C6FD]
    ld b, a
    ld hl, $C6FE

Jump_00A_4309::
    push bc
    ld a, [hl]
    ld c, $55
    call Func_000_1F80
    bit 7, a
    jr nz, Jump_00A_4350
    bit 2, a
    jr nz, Jump_00A_431E
    bit 0, a
    jr nz, Jump_00A_4349
    jr Jump_00A_4350

Jump_00A_431E::
    call Func_00A_4362

Jump_00A_4321::
    pop bc
    ld a, [$C5DC]
    cp a, $03
    jr nz, Jump_00A_432D
    xor a, a
    ld [$C902], a

Jump_00A_432D::
    ld a, $07
    ld [$C5DC], a
    xor a, a
    ld [$C46B], a
    ld a, $01
    ld [$C46C], a
    xor a, a
    ld [$C915], a
    ld a, [$C88C]
    and a, $7F
    ld [$C88C], a
    jr Jump_00A_4355

Jump_00A_4349::
    call Func_00A_4362
    and a, $01
    jr nz, Jump_00A_4321

Jump_00A_4350::
    pop bc
    inc hl
    dec b
    jr nz, Jump_00A_4309

Jump_00A_4355::
    ld a, [$C88C]
    and a, $7F
    ld [$C88C], a
    xor a, a
    ld [$0100], a
    ret

Func_00A_4362::
    ld a, [$C88C]
    bit 7, a
    ret nz
    ld a, [$C88C]
    inc a
    and a, $01
    or a, $80
    ld [$C88C], a
    ret
    db $21, $22, $23, $24, $25, $26, $29, $2A, $2B, $2D, $2E, $31, $32, $33, $34, $3C
    db $3D, $41, $45, $49, $4A, $4B, $4C, $4D, $4F
    dw Data_00A_5150
    dw Data_00A_5852
    dw Data_00A_5A59
    dw Data_00A_5C5B
    dw Data_00A_5E5D
    dw Data_00A_605F
    dw Data_00A_6861
    dw Data_00A_7271
    dw Data_00A_7978
    dw Data_00A_7D7C
    dw Data_00A_7F7E
    db $89, $92, $9D, $A4, $A9, $AB, $AF, $B2, $B1, $B6, $B9, $BA, $BC, $C5, $D0, $D9
    db $E2, $FF

Func_00A_43B5::
    ld a, [$C56C]
    or a, a
    ret nz
    ld a, [$C91F]
    or a, a
    ret nz
    ld a, [$C901]
    and a, $7F
    ret z
    ld a, [$D069]
    or a, a
    ret z
    dec a
    ld [$D069], a
    or a, a
    ret nz
    ld a, [$C91F]
    or a, a
    jr z, Jump_00A_43DC
    ld a, $01
    ld [$D069], a
    ret

Jump_00A_43DC::
    ld a, $1E
    ld [$C916], a
    xor a, a
    ld [$C917], a
    ld hl, $405C
    ld b, $13
    rst $10
    ret

Func_00A_43EC::
    ld a, [$C56C]
    or a, a
    ret nz
    ld a, [$C91F]
    or a, a
    ret nz
    ldh a, [$FF8C]
    bit 7, a
    ret nz
    bit 5, a
    ret nz
    ld a, [$C5DC]
    cp a, $04
    ret z
    cp a, $01
    ret z
    ld a, [$C901]
    bit 7, a
    jr z, Jump_00A_4414
    and a, $7F
    ld [$C901], a
    ret

Jump_00A_4414::
    ld a, [$C901]
    or a, a
    ret z
    ld a, [$D091]
    or a, a
    jr z, Jump_00A_4442
    dec a
    ld [$D091], a
    or a, a
    ret nz
    ld a, [$C5DC]
    cp a, $01
    jr nz, Jump_00A_4432
    ld a, $01
    ld [$D091], a
    ret

Jump_00A_4432::
    ld a, $1D
    ld [$C916], a
    xor a, a
    ld [$C917], a
    ld hl, $405C
    ld b, $13
    rst $10
    ret

Jump_00A_4442::
    ld a, [$C901]
    push af
    ldh a, [$FF8C]
    bit 3, a
    jr z, Jump_00A_4451
    pop af
    ld b, $02
    jr Jump_00A_44A0

Jump_00A_4451::
    pop af
    ld l, a
    ld h, $00
    sla l
    rl h
    sla l
    rl h
    sla l
    rl h
    ld a, l
    add a, $FE
    ld l, a
    ld a, h
    adc a, $44
    ld h, a
    ld a, [hl+]
    or a, a
    jr nz, Jump_00A_44AD
    push hl
    ldh a, [$FF8E]
    ld b, a
    ldh a, [$FF91]
    ld c, a
    call Func_00A_461E
    pop hl
    ld b, $02

Jump_00A_447A::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_00A_4498
    ld c, a
    ld a, [$C910]
    cp a, c
    jr z, Jump_00A_44A0
    ld a, [$C911]
    cp a, c
    jr z, Jump_00A_44A0
    ld a, [$C912]
    cp a, c
    jr z, Jump_00A_44A0
    ld a, [$C913]
    cp a, c
    jr z, Jump_00A_44A0

Jump_00A_4498::
    inc b
    ld a, b
    cp a, $09
    jr nz, Jump_00A_447A
    ld b, $02

Jump_00A_44A0::
    ld a, b
    srl a
    ld b, a
    ld a, [$C902]
    sub a, b
    ld [$C902], a
    jr Jump_00A_44B6

Jump_00A_44AD::
    ld a, [hl]
    ld c, a
    ld a, [$C902]
    sub a, c
    ld [$C902], a

Jump_00A_44B6::
    jr c, Jump_00A_44C3
    ld a, [$C902]
    or a, a
    jr z, Jump_00A_44C3
    cp a, $E0
    jr nc, Jump_00A_44C3
    ret

Jump_00A_44C3::
    xor a, a
    ld [$C903], a
    ld a, [$CC44]
    bit 7, a
    jr z, Jump_00A_44D3
    ld a, $01
    ld [$C903], a

Jump_00A_44D3::
    ld hl, $5B9E
    ld b, $02
    rst $10
    ld a, $03
    ld [$C5DC], a
    xor a, a
    ld [$C904], a
    call Func_000_09F3
    ld a, [$CD03]
    and a, $01
    sla a
    ld [$C905], a
    ld a, $02
    ld [$C8C7], a
    ld hl, $5EEE
    ld b, $02
    rst $10
    call Func_00A_476E
    ret
    INCBIN "dwm2-cobi-us.gbc", $0284FE, $120

Func_00A_461E::
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
    jr nc, Jump_00A_462F
    inc h

Jump_00A_462F::
    add hl, hl
    add hl, hl
    ld a, b
    srl a
    srl a
    srl a
    add a, l
    ld l, a
    jr nc, Jump_00A_463D
    inc h

Jump_00A_463D::
    ld a, l
    add a, $98
    ld l, a
    ld a, h
    adc a, $C1
    ld h, a
    ld a, [hl+]
    ld [$C910], a
    ld a, [hl-]
    ld [$C911], a
    ld a, $14
    add a, l
    ld l, a
    jr nc, Jump_00A_4654
    inc h

Jump_00A_4654::
    ld a, [hl+]
    ld [$C912], a
    ld a, [hl]
    ld [$C913], a
    ret

Func_00A_465D::
    xor a, a
    ld [$C96C], a
    ld a, [$C903]
    and a, $07
    rst $00
    dw Jump_00A_49B4
    dw Jump_00A_50D1
    dw Jump_00A_50CB
    dw Jump_00A_51DF
    dw Jump_00A_51F1
    dw Jump_00A_472E
    dw Jump_00A_4677
    dw Jump_00A_51F7

Jump_00A_4677::
    ld a, [$C935]
    and a, $0F
    cp a, $0C
    jr nc, Jump_00A_46D0
    ld hl, $40B4
    ld b, $61
    rst $10
    ld a, [$CD05]
    ld b, a
    ld a, $05
    call Func_000_16BF
    ld a, b
    add a, a
    ld de, $46EE
    add a, e
    ld e, a
    jr nc, Jump_00A_4699
    inc d

Jump_00A_4699::
    ld a, [de]
    ldh [$FFC6], a
    inc de
    ld a, [de]
    ldh [$FFC7], a
    ld hl, $CFDD
    ld b, $03

Jump_00A_46A5::
    call Func_000_09F3
    ld a, [$CD04]
    and a, $0F
    cp a, $0A
    jr nc, Jump_00A_46A5
    push af
    ldh a, [$FFC6]
    ld e, a
    ldh a, [$FFC7]
    ld d, a
    pop af
    add a, e
    ld e, a
    jr nc, Jump_00A_46BE
    inc d

Jump_00A_46BE::
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl+], a
    dec b
    jr nz, Jump_00A_46A5

Jump_00A_46C5::
    ld a, $02
    ld [$CFDC], a
    ld a, $06
    ld [$CFC5], a
    ret

Jump_00A_46D0::
    sub a, $0C
    ld c, a
    add a, a
    add a, c
    add a, a
    ld de, $4716
    add a, e
    ld e, a
    jr nc, Jump_00A_46DE
    inc d

Jump_00A_46DE::
    ld hl, $CFDD
    ld b, $03

Jump_00A_46E3::
    ld a, [de]
    inc de
    ld [hl+], a
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_00A_46E3
    jr Jump_00A_46C5
    db $AC, $00, $BC, $00, $CC, $00, $DC, $00, $EC, $00, $FC, $00, $0C, $01, $1C, $01
    db $2C, $01, $3C, $01, $1E, $02, $23, $02, $28, $02, $2D, $02, $32, $02, $37, $02
    db $3C, $02, $41, $02, $46, $02, $48, $02, $0B, $02, $0C, $02, $0D, $02, $0E, $02
    db $0F, $02, $0E, $02, $10, $02, $11, $02, $12, $02, $13, $02, $14, $02, $15, $02

Jump_00A_472E::
    ld hl, $4001
    ld b, $61
    rst $10
    ld c, $76
    ld a, [$CD05]
    cp a, $05
    jr c, Jump_00A_475C
    inc c
    cp a, $0A
    jr c, Jump_00A_475C
    inc c
    cp a, $0F
    jr c, Jump_00A_475C
    inc c
    cp a, $14
    jr c, Jump_00A_475C
    inc c
    cp a, $19
    jr c, Jump_00A_475C
    inc c
    cp a, $1E
    jr c, Jump_00A_475C
    inc c
    cp a, $23
    jr c, Jump_00A_475C
    inc c

Jump_00A_475C::
    ld a, c
    ld [$CFDD], a
    xor a, a
    ld [$CFDE], a
    xor a, a
    ld [$CFDC], a
    ld a, $02
    ld [$CFC5], a
    ret

Func_00A_476E::
    call Func_000_09F3
    ld a, [$CD04]
    and a, $3F
    cp a, $64
    jr nc, Func_00A_476E
    ld b, a
    ld a, $05
    call Func_000_16BF
    ld a, b
    ld hl, $478F
    add a, l
    ld l, a
    jr nc, Jump_00A_4789
    inc h

Jump_00A_4789::
    ld a, [hl]
    add a, a
    ld [$C902], a
    ret
    db $0A, $14, $19, $1E, $23, $28, $2A, $2C, $2D, $2E, $30, $32, $34, $36, $38, $3A
    db $3C, $41, $46, $50, $50

Func_00A_47A4::
    push hl
    ldh a, [$FFC6]
    ld l, a
    ld h, $00
    sla l
    rl h
    sla l
    rl h
    sla l
    rl h
    ld a, l
    add a, $1C
    ld l, a
    ld a, h
    adc a, $48
    ld h, a
    ld a, [hl+]
    ld [$CFDC], a
    inc hl
    ld a, [hl+]
    ld [$CFDD], a
    ld a, [hl+]
    ld [$CFDE], a
    ld a, [hl+]
    ld [$CFDF], a
    ld a, [hl+]
    ld [$CFE0], a
    ld a, [hl+]
    ld [$CFE1], a
    ld a, [hl]
    ld [$CFE2], a
    ld a, $02
    ld [$C903], a
    ldh a, [$FFC6]
    cp a, $14
    jr z, Jump_00A_47F6
    cp a, $15
    jr z, Jump_00A_47F6
    cp a, $2F
    jr z, Jump_00A_47F6
    cp a, $30
    jr z, Jump_00A_47F6
    cp a, $31
    jr nz, Jump_00A_47FB

Jump_00A_47F6::
    ld a, $07
    ld [$C903], a

Jump_00A_47FB::
    ld a, $03
    ld [$C5DC], a
    xor a, a
    ld [$C904], a
    ld a, $01
    ld [$C905], a
    ld a, $02
    ld [$C8C7], a
    ld hl, $5EEE
    ld b, $02
    rst $10
    ld hl, $476E
    ld b, $0A
    rst $10
    pop hl
    ret
    INCBIN "dwm2-cobi-us.gbc", $02881C, $198

Jump_00A_49B4::
    ldh a, [$FF90]
    cp a, $20
    jp z, Jump_00A_4ACF
    cp a, $2B
    jp z, Jump_00A_4AD8
    cp a, $30
    jp z, Jump_00A_4AEE
    cp a, $35
    jp z, Jump_00A_4B04
    cp a, $38
    jp z, Jump_00A_4B0D
    cp a, $39
    jp z, Jump_00A_4B16
    cp a, $3A
    jp z, Jump_00A_4B1F
    cp a, $3E
    jp z, Jump_00A_4B28
    cp a, $3F
    jp z, Jump_00A_4B31
    cp a, $37
    jp z, Jump_00A_4B3A
    cp a, $42
    jp z, Jump_00A_4B43
    cp a, $43
    jp z, Jump_00A_4B4C
    cp a, $48
    jp z, Jump_00A_4B55
    cp a, $53
    jp z, Jump_00A_4B6B
    cp a, $54
    jp z, Jump_00A_4B74
    cp a, $55
    jp z, Jump_00A_4B74
    cp a, $56
    jp z, Jump_00A_4B74
    cp a, $5D
    jp z, Jump_00A_4B7B
    cp a, $62
    jp z, Jump_00A_4B84
    cp a, $63
    jp z, Jump_00A_4B8D
    cp a, $64
    jp z, Jump_00A_4B96
    cp a, $65
    jp z, Jump_00A_4B9F
    cp a, $66
    jp z, Jump_00A_4BA8
    cp a, $67
    jp z, Jump_00A_4BB1
    cp a, $70
    jp z, Jump_00A_4BBA
    cp a, $73
    jp z, Jump_00A_4BC3
    cp a, $74
    jp z, Jump_00A_4BCC
    cp a, $75
    jp z, Jump_00A_4BD5
    cp a, $76
    jp z, Jump_00A_4BDE
    cp a, $81
    jp z, Jump_00A_4BE7
    cp a, $82
    jp z, Jump_00A_4BF0
    cp a, $83
    jp z, Jump_00A_4BF9
    cp a, $85
    jp z, Jump_00A_4C02
    cp a, $86
    jp z, Jump_00A_4C0B
    cp a, $87
    jp z, Jump_00A_4C14
    cp a, $88
    jp z, Jump_00A_4C1D
    cp a, $8B
    jp z, Jump_00A_4C26
    cp a, $8C
    jp z, Jump_00A_4C2F
    cp a, $8E
    jp z, Jump_00A_4C38
    cp a, $90
    jp z, Jump_00A_4C41
    cp a, $A0
    jp z, Jump_00A_4C4A
    cp a, $A2
    jp z, Jump_00A_4C53
    cp a, $A8
    jp z, Jump_00A_4C5C
    cp a, $AD
    jp z, Jump_00A_4C65
    cp a, $AE
    jp z, Jump_00A_4C65
    cp a, $B0
    jp z, Jump_00A_4C6E
    cp a, $B3
    jp z, Jump_00A_4C77
    cp a, $B4
    jp z, Jump_00A_4C77
    cp a, $B5
    jp z, Jump_00A_4C77
    cp a, $B8
    jp z, Jump_00A_4C80
    cp a, $BE
    jp z, Jump_00A_4C96
    cp a, $BF
    jp z, Jump_00A_4C9F
    cp a, $C0
    jp z, Jump_00A_4CA8
    cp a, $C1
    jp z, Jump_00A_4CA8
    cp a, $C2
    jp z, Jump_00A_4CB1
    cp a, $C3
    jp z, Jump_00A_4CB1
    ret

Jump_00A_4ACF::
    ld de, $5773
    ld a, $08
    call Func_00A_4CBA
    ret

Jump_00A_4AD8::
    ldh a, [$FF8C]
    bit 3, a
    jr nz, Jump_00A_4AE7
    ld de, $5856
    ld a, $04
    call Func_00A_4CBA
    ret

Jump_00A_4AE7::
    ld de, $588E
    call Func_00A_4CD4
    ret

Jump_00A_4AEE::
    ldh a, [$FF8C]
    bit 3, a
    jr nz, Jump_00A_4AFD
    ld de, $589B
    ld a, $08
    call Func_00A_4CBA
    ret

Jump_00A_4AFD::
    ld de, $5A3B
    call Func_00A_4CD4
    ret

Jump_00A_4B04::
    ld de, $5A4C
    ld a, $04
    call Func_00A_4CBA
    ret

Jump_00A_4B0D::
    ld de, $5A8A
    ld a, $04
    call Func_00A_4CBA
    ret

Jump_00A_4B16::
    ld de, $5AB7
    ld a, $04
    call Func_00A_4CBA
    ret

Jump_00A_4B1F::
    ld de, $5ADE
    ld a, $03
    call Func_00A_4CBA
    ret

Jump_00A_4B28::
    ld de, $5AFF
    ld a, $02
    call Func_00A_4CBA
    ret

Jump_00A_4B31::
    ld de, $5B14
    ld a, $02
    call Func_00A_4CBA
    ret

Jump_00A_4B3A::
    ld de, $5B29
    ld a, $03
    call Func_00A_4CBA
    ret

Jump_00A_4B43::
    ld de, $5B45
    ld a, $03
    call Func_00A_4CBA
    ret

Jump_00A_4B4C::
    ld de, $5B58
    ld a, $03
    call Func_00A_4CBA
    ret

Jump_00A_4B55::
    ldh a, [$FF8C]
    bit 3, a
    jr nz, Jump_00A_4B64
    ld de, $5B6B
    ld a, $0C
    call Func_00A_4CBA
    ret

Jump_00A_4B64::
    ld de, $5D4E
    call Func_00A_4CD4
    ret

Jump_00A_4B6B::
    ld de, $5D5D
    ld a, $04
    call Func_00A_4CBA
    ret

Jump_00A_4B74::
    ld de, $5D8C
    call Func_00A_4CD4
    ret

Jump_00A_4B7B::
    ld de, $5D9B
    ld a, $04
    call Func_00A_4CBA
    ret

Jump_00A_4B84::
    ld de, $5DCA
    ld a, $02
    call Func_00A_4CBA
    ret

Jump_00A_4B8D::
    ld de, $5DE7
    ld a, $02
    call Func_00A_4CBA
    ret

Jump_00A_4B96::
    ld de, $5DEF
    ld a, $02
    call Func_00A_4CBA
    ret

Jump_00A_4B9F::
    ld de, $5DF7
    ld a, $02
    call Func_00A_4CBA
    ret

Jump_00A_4BA8::
    ld de, $5E0C
    ld a, $02
    call Func_00A_4CBA
    ret

Jump_00A_4BB1::
    ld de, $5E14
    ld a, $02
    call Func_00A_4CBA
    ret

Jump_00A_4BBA::
    ld de, $5E2B
    ld a, $0C
    call Func_00A_4CBA
    ret

Jump_00A_4BC3::
    ld de, $6028
    ld a, $02
    call Func_00A_4CBA
    ret

Jump_00A_4BCC::
    ld de, $603D
    ld a, $02
    call Func_00A_4CBA
    ret

Jump_00A_4BD5::
    ld de, $6052
    ld a, $02
    call Func_00A_4CBA
    ret

Jump_00A_4BDE::
    ld de, $606B
    ld a, $02
    call Func_00A_4CBA
    ret

Jump_00A_4BE7::
    ld de, $6084
    ld a, $01
    call Func_00A_4CBA
    ret

Jump_00A_4BF0::
    ld de, $6097
    ld a, $03
    call Func_00A_4CBA
    ret

Jump_00A_4BF9::
    ld de, $60BA
    ld a, $03
    call Func_00A_4CBA
    ret

Jump_00A_4C02::
    ld de, $60DD
    ld a, $02
    call Func_00A_4CBA
    ret

Jump_00A_4C0B::
    ld de, $60F2
    ld a, $02
    call Func_00A_4CBA
    ret

Jump_00A_4C14::
    ld de, $6107
    ld a, $02
    call Func_00A_4CBA
    ret

Jump_00A_4C1D::
    ld de, $6120
    ld a, $02
    call Func_00A_4CBA
    ret

Jump_00A_4C26::
    ld de, $6139
    ld a, $03
    call Func_00A_4CBA
    ret

Jump_00A_4C2F::
    ld de, $6160
    ld a, $03
    call Func_00A_4CBA
    ret

Jump_00A_4C38::
    ld de, $6181
    ld a, $03
    call Func_00A_4CBA
    ret

Jump_00A_4C41::
    ld de, $61A2
    ld a, $03
    call Func_00A_4CBA
    ret

Jump_00A_4C4A::
    ld de, $61BD
    ld a, $04
    call Func_00A_4CBA
    ret

Jump_00A_4C53::
    ld de, $61FB
    ld a, $03
    call Func_00A_4CBA
    ret

Jump_00A_4C5C::
    ld de, $6220
    ld a, $06
    call Func_00A_4CBA
    ret

Jump_00A_4C65::
    ld de, $62AB
    ld a, $03
    call Func_00A_4CBA
    ret

Jump_00A_4C6E::
    ld de, $62D2
    ld a, $03
    call Func_00A_4CBA
    ret

Jump_00A_4C77::
    ld de, $62EB
    ld a, $02
    call Func_00A_4CBA
    ret

Jump_00A_4C80::
    ldh a, [$FF8C]
    bit 3, a
    jr nz, Jump_00A_4C8F
    ld de, $6300
    ld a, $05
    call Func_00A_4CBA
    ret

Jump_00A_4C8F::
    ld de, $6375
    call Func_00A_4CD4
    ret

Jump_00A_4C96::
    ld de, $6382
    ld a, $01
    call Func_00A_4CBA
    ret

Jump_00A_4C9F::
    ld de, $6393
    ld a, $02
    call Func_00A_4CBA
    ret

Jump_00A_4CA8::
    ld de, $63AA
    ld a, $02
    call Func_00A_4CBA
    ret

Jump_00A_4CB1::
    ld de, $63BF
    ld a, $02
    call Func_00A_4CBA
    ret

Func_00A_4CBA::
    sla a
    ld c, a
    ldh a, [$FF92]
    and a, $0F
    call Func_000_1682
    ldh a, [$FF8F]
    and a, $0F
    sla a
    add a, l
    ld l, a
    jr nc, Jump_00A_4CCF
    inc h

Jump_00A_4CCF::
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a

Func_00A_4CD4::
    ld a, [de]
    inc de
    dec a
    ld [$CFDC], a
    ld a, [de]
    inc de
    ldh [$FFC6], a
    ld a, [de]
    inc de
    ldh [$FFC7], a
    ld a, [de]
    inc de
    ldh [$FFC8], a
    ld a, [de]
    inc de
    ldh [$FFC9], a
    ld a, [de]
    inc de
    ldh [$FFCA], a
    ld a, [de]
    inc de
    ldh [$FFCB], a
    ld hl, $CFDD
    ld b, $03

Jump_00A_4CF7::
    call Func_000_095B
    ld a, [$C5E7]
    and a, $7F
    ld c, a
    ldh a, [$FFC6]
    cp a, c
    jr c, Jump_00A_4CF7
    push hl
    push de
    ldh a, [$FFC7]
    cp a, c
    jr nc, Jump_00A_4D31
    inc de
    inc de
    ldh a, [$FFC8]
    cp a, c
    jr nc, Jump_00A_4D31
    inc de
    inc de
    ldh a, [$FFC9]
    cp a, c
    jr nc, Jump_00A_4D31
    inc de
    inc de
    ldh a, [$FFCA]
    cp a, c
    jr nc, Jump_00A_4D31
    inc de
    inc de
    ldh a, [$FFCB]
    cp a, c
    jr nc, Jump_00A_4D31

Jump_00A_4D28::
    pop de
    pop hl
    inc hl
    inc hl
    dec b
    jr nz, Jump_00A_4CF7
    jr Jump_00A_4D38

Jump_00A_4D31::
    ld a, [de]
    inc de
    ld [hl+], a
    ld a, [de]
    ld [hl], a
    jr Jump_00A_4D28

Jump_00A_4D38::
    xor a, a
    ld [$CFC5], a
    ld a, [$CFDC]
    or a, a
    ret z
    dec a
    jr nz, Jump_00A_4D49
    ld hl, $5150
    jr Jump_00A_4D4C

Jump_00A_4D49::
    ld hl, $514C

Jump_00A_4D4C::
    call Func_000_095B
    ld a, [$C5E7]
    and a, $03
    add a, l
    ld l, a
    jr nc, Jump_00A_4D59
    inc h

Jump_00A_4D59::
    ld a, [hl]
    ld [$CFDC], a
    ret

Func_00A_4D5E::
    ldh a, [$FF90]
    cp a, $20
    jp z, Jump_00A_4E79
    cp a, $2B
    jp z, Jump_00A_4E82
    cp a, $30
    jp z, Jump_00A_4E98
    cp a, $35
    jp z, Jump_00A_4EAE
    cp a, $38
    jp z, Jump_00A_4EB7
    cp a, $39
    jp z, Jump_00A_4EC0
    cp a, $3A
    jp z, Jump_00A_4EC9
    cp a, $3E
    jp z, Jump_00A_4ED2
    cp a, $3F
    jp z, Jump_00A_4EDB
    cp a, $37
    jp z, Jump_00A_4EE4
    cp a, $42
    jp z, Jump_00A_4EED
    cp a, $43
    jp z, Jump_00A_4EF6
    cp a, $48
    jp z, Jump_00A_4EFF
    cp a, $53
    jp z, Jump_00A_4F15
    cp a, $54
    jp z, Jump_00A_4F1E
    cp a, $55
    jp z, Jump_00A_4F1E
    cp a, $56
    jp z, Jump_00A_4F1E
    cp a, $5D
    jp z, Jump_00A_4F25
    cp a, $62
    jp z, Jump_00A_4F2E
    cp a, $63
    jp z, Jump_00A_4F37
    cp a, $64
    jp z, Jump_00A_4F40
    cp a, $65
    jp z, Jump_00A_4F49
    cp a, $66
    jp z, Jump_00A_4F52
    cp a, $67
    jp z, Jump_00A_4F5B
    cp a, $70
    jp z, Jump_00A_4F64
    cp a, $73
    jp z, Jump_00A_4F6D
    cp a, $74
    jp z, Jump_00A_4F76
    cp a, $75
    jp z, Jump_00A_4F7F
    cp a, $76
    jp z, Jump_00A_4F88
    cp a, $81
    jp z, Jump_00A_4F91
    cp a, $82
    jp z, Jump_00A_4F9A
    cp a, $83
    jp z, Jump_00A_4FA3
    cp a, $85
    jp z, Jump_00A_4FAC
    cp a, $86
    jp z, Jump_00A_4FB5
    cp a, $87
    jp z, Jump_00A_4FBE
    cp a, $88
    jp z, Jump_00A_4FC7
    cp a, $8B
    jp z, Jump_00A_4FD0
    cp a, $8C
    jp z, Jump_00A_4FD9
    cp a, $8E
    jp z, Jump_00A_4FE2
    cp a, $90
    jp z, Jump_00A_4FEB
    cp a, $A0
    jp z, Jump_00A_4FF4
    cp a, $A2
    jp z, Jump_00A_4FFD
    cp a, $A8
    jp z, Jump_00A_5006
    cp a, $AD
    jp z, Jump_00A_500F
    cp a, $AE
    jp z, Jump_00A_500F
    cp a, $B0
    jp z, Jump_00A_5018
    cp a, $B3
    jp z, Jump_00A_5021
    cp a, $B4
    jp z, Jump_00A_5021
    cp a, $B5
    jp z, Jump_00A_5021
    cp a, $B8
    jp z, Jump_00A_502A
    cp a, $BE
    jp z, Jump_00A_5033
    cp a, $BF
    jp z, Jump_00A_503C
    cp a, $C0
    jp z, Jump_00A_5045
    cp a, $C1
    jp z, Jump_00A_5045
    cp a, $C2
    jp z, Jump_00A_504E
    cp a, $C3
    jp z, Jump_00A_504E
    ret

Jump_00A_4E79::
    ld de, $5773
    ld a, $08
    call Func_00A_5057
    ret

Jump_00A_4E82::
    ldh a, [$FF8C]
    bit 3, a
    jr nz, Jump_00A_4E91
    ld de, $5856
    ld a, $04
    call Func_00A_5057
    ret

Jump_00A_4E91::
    ld de, $588E
    call Func_00A_5071
    ret

Jump_00A_4E98::
    ldh a, [$FF8C]
    bit 3, a
    jr nz, Jump_00A_4EA7
    ld de, $589B
    ld a, $08
    call Func_00A_5057
    ret

Jump_00A_4EA7::
    ld de, $5A3B
    call Func_00A_5071
    ret

Jump_00A_4EAE::
    ld de, $5A4C
    ld a, $04
    call Func_00A_5057
    ret

Jump_00A_4EB7::
    ld de, $5A8A
    ld a, $04
    call Func_00A_5057
    ret

Jump_00A_4EC0::
    ld de, $5AB7
    ld a, $04
    call Func_00A_5057
    ret

Jump_00A_4EC9::
    ld de, $5ADE
    ld a, $03
    call Func_00A_5057
    ret

Jump_00A_4ED2::
    ld de, $5AFF
    ld a, $02
    call Func_00A_5057
    ret

Jump_00A_4EDB::
    ld de, $5B14
    ld a, $02
    call Func_00A_5057
    ret

Jump_00A_4EE4::
    ld de, $5B29
    ld a, $03
    call Func_00A_5057
    ret

Jump_00A_4EED::
    ld de, $5B45
    ld a, $03
    call Func_00A_5057
    ret

Jump_00A_4EF6::
    ld de, $5B58
    ld a, $03
    call Func_00A_5057
    ret

Jump_00A_4EFF::
    ldh a, [$FF8C]
    bit 3, a
    jr nz, Jump_00A_4F0E
    ld de, $5B6B
    ld a, $0C
    call Func_00A_5057
    ret

Jump_00A_4F0E::
    ld de, $5D4E
    call Func_00A_5071
    ret

Jump_00A_4F15::
    ld de, $5D5D
    ld a, $04
    call Func_00A_5057
    ret

Jump_00A_4F1E::
    ld de, $5D8C
    call Func_00A_5071
    ret

Jump_00A_4F25::
    ld de, $5D9B
    ld a, $04
    call Func_00A_5057
    ret

Jump_00A_4F2E::
    ld de, $5DCA
    ld a, $02
    call Func_00A_5057
    ret

Jump_00A_4F37::
    ld de, $5DE7
    ld a, $02
    call Func_00A_5057
    ret

Jump_00A_4F40::
    ld de, $5DEF
    ld a, $02
    call Func_00A_5057
    ret

Jump_00A_4F49::
    ld de, $5DF7
    ld a, $02
    call Func_00A_5057
    ret

Jump_00A_4F52::
    ld de, $5E0C
    ld a, $02
    call Func_00A_5057
    ret

Jump_00A_4F5B::
    ld de, $5E14
    ld a, $02
    call Func_00A_5057
    ret

Jump_00A_4F64::
    ld de, $5E2B
    ld a, $0C
    call Func_00A_5057
    ret

Jump_00A_4F6D::
    ld de, $6028
    ld a, $02
    call Func_00A_5057
    ret

Jump_00A_4F76::
    ld de, $603D
    ld a, $02
    call Func_00A_5057
    ret

Jump_00A_4F7F::
    ld de, $6052
    ld a, $02
    call Func_00A_5057
    ret

Jump_00A_4F88::
    ld de, $606B
    ld a, $02
    call Func_00A_5057
    ret

Jump_00A_4F91::
    ld de, $6084
    ld a, $01
    call Func_00A_5057
    ret

Jump_00A_4F9A::
    ld de, $6097
    ld a, $03
    call Func_00A_5057
    ret

Jump_00A_4FA3::
    ld de, $60BA
    ld a, $03
    call Func_00A_5057
    ret

Jump_00A_4FAC::
    ld de, $60DD
    ld a, $02
    call Func_00A_5057
    ret

Jump_00A_4FB5::
    ld de, $60F2
    ld a, $02
    call Func_00A_5057
    ret

Jump_00A_4FBE::
    ld de, $6107
    ld a, $02
    call Func_00A_5057
    ret

Jump_00A_4FC7::
    ld de, $6120
    ld a, $02
    call Func_00A_5057
    ret

Jump_00A_4FD0::
    ld de, $6139
    ld a, $03
    call Func_00A_5057
    ret

Jump_00A_4FD9::
    ld de, $6160
    ld a, $03
    call Func_00A_5057
    ret

Jump_00A_4FE2::
    ld de, $6181
    ld a, $03
    call Func_00A_5057
    ret

Jump_00A_4FEB::
    ld de, $61A2
    ld a, $03
    call Func_00A_5057
    ret

Jump_00A_4FF4::
    ld de, $61BD
    ld a, $04
    call Func_00A_5057
    ret

Jump_00A_4FFD::
    ld de, $61FB
    ld a, $03
    call Func_00A_5057
    ret

Jump_00A_5006::
    ld de, $6220
    ld a, $06
    call Func_00A_5057
    ret

Jump_00A_500F::
    ld de, $62AB
    ld a, $03
    call Func_00A_5057
    ret

Jump_00A_5018::
    ld de, $62D2
    ld a, $03
    call Func_00A_5057
    ret

Jump_00A_5021::
    ld de, $62EB
    ld a, $02
    call Func_00A_5057
    ret

Jump_00A_502A::
    ld de, $6300
    ld a, $05
    call Func_00A_5057
    ret

Jump_00A_5033::
    ld de, $6382
    ld a, $01
    call Func_00A_5057
    ret

Jump_00A_503C::
    ld de, $6393
    ld a, $02
    call Func_00A_5057
    ret

Jump_00A_5045::
    ld de, $63AA
    ld a, $02
    call Func_00A_5057
    ret

Jump_00A_504E::
    ld de, $63BF
    ld a, $02
    call Func_00A_5057
    ret

Func_00A_5057::
    sla a
    ld c, a
    ldh a, [$FF92]
    and a, $0F
    call Func_000_1682
    ldh a, [$FF8F]
    and a, $0F
    sla a
    add a, l
    ld l, a
    jr nc, Jump_00A_506C
    inc h

Jump_00A_506C::
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a

Func_00A_5071::
    inc de
    inc de
    push de
    ld b, $00

Jump_00A_5076::
    ld a, [de]
    inc de
    or a, a
    jr z, Jump_00A_5083
    inc b
    ld a, b
    cp a, $05
    jr z, Jump_00A_5083
    jr Jump_00A_5076

Jump_00A_5083::
    pop de
    ld a, $05
    add a, e
    ld e, a
    jr nc, Jump_00A_508B
    inc d

Jump_00A_508B::
    ld a, b
    ld [$D09D], a
    xor a, a
    ld [$D09E], a
    ld hl, $D09F

Jump_00A_5096::
    ld a, [de]
    inc de
    ld [hl+], a
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_00A_5096
    ld a, [$D09D]
    ld b, a
    ld hl, $D09F

Jump_00A_50A6::
    push bc
    ld a, [hl+]
    ld [$CFE6], a
    ld a, [hl-]
    ld [$CFE7], a
    push hl
    ld a, $02
    ldh [$FFC6], a
    ld de, $FFC6
    ld c, $00
    ld hl, $4008
    ld b, $34
    rst $10
    pop hl
    ldh a, [$FFC6]
    ld [hl+], a
    ldh a, [$FFC7]
    ld [hl+], a
    pop bc
    dec b
    jr nz, Jump_00A_50A6
    ret

Jump_00A_50CB::
    ld a, $02
    ld [$CFC5], a
    ret

Jump_00A_50D1::
    call Func_000_095B
    ld a, [$C5E7]
    and a, $03
    ld hl, $514C
    add a, l
    ld l, a
    jr nc, Jump_00A_50E1
    inc h

Jump_00A_50E1::
    ld a, [hl]
    ld [$CFDC], a
    ld a, [$CC44]
    and a, $07
    cp a, $01
    jr z, Jump_00A_50F1
    or a, a
    jr nz, Jump_00A_5116

Jump_00A_50F1::
    ldh a, [$FF92]
    srl a
    and a, $FE
    ld c, a
    ldh a, [$FF8F]
    srl a
    srl a
    add a, c
    ld hl, $CD70
    add a, l
    ld l, a
    jr nc, Jump_00A_5107
    inc h

Jump_00A_5107::
    ld a, [hl]
    ld c, a
    add a, a
    add a, a
    add a, c
    ld c, a
    call Func_00A_5154
    ld a, $01
    ld [$CFC5], a
    ret

Jump_00A_5116::
    ld a, [$CC45]
    add a, a
    add a, a
    ld hl, $CD88
    add a, l
    ld l, a
    jr nc, Jump_00A_5123
    inc h

Jump_00A_5123::
    ld a, [hl]
    push af
    and a, $0F
    srl a
    and a, $FE
    ld c, a
    pop af
    swap a
    and a, $0F
    srl a
    srl a
    add a, c
    ld hl, $CD70
    add a, l
    ld l, a
    jr nc, Jump_00A_513E
    inc h

Jump_00A_513E::
    ld a, [hl]
    add a, a
    add a, a
    add a, a
    ld c, a
    call Func_00A_5154
    ld a, $01
    ld [$CFC5], a
    ret
    db $00, $02, $01, $02

Data_00A_5150:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $00, $01

Func_00A_5154::
    ldh a, [$FF8C]
    bit 3, a
    jr nz, Jump_00A_519F
    ld b, $03
    ld de, $CFDD

Jump_00A_515F::
    push bc
    call Func_000_09F3
    ld a, [$CD03]
    and a, $07
    add a, c
    cp a, $20
    jr c, Jump_00A_516F
    ld a, $1F

Jump_00A_516F::
    add a, a
    ld hl, $CD10
    add a, l
    ld l, a
    jr nc, Jump_00A_5178
    inc h

Jump_00A_5178::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    and a, $01
    ld [de], a
    inc de
    push de
    ld a, e
    sub a, $DF
    ld e, a
    ld a, d
    sbc a, $CF
    ld d, a
    sra d
    rr e
    ld a, e
    add a, $E3
    ld e, a
    ld a, d
    adc a, $CF
    ld d, a
    ld a, [hl]
    srl a
    ld [de], a
    pop de
    pop bc
    dec b
    jr nz, Jump_00A_515F
    ret

Jump_00A_519F::
    ld b, $03
    ld de, $CFDD

Jump_00A_51A4::
    push bc
    call Func_000_09F3
    ld a, [$CD03]
    and a, $07
    add a, $20
    add a, a
    ld hl, $CD10
    add a, l
    ld l, a
    jr nc, Jump_00A_51B8
    inc h

Jump_00A_51B8::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    and a, $01
    ld [de], a
    inc de
    push de
    ld a, e
    sub a, $DF
    ld e, a
    ld a, d
    sbc a, $CF
    ld d, a
    sra d
    rr e
    ld a, e
    add a, $E3
    ld e, a
    ld a, d
    adc a, $CF
    ld d, a
    ld a, [hl]
    srl a
    ld [de], a
    pop de
    pop bc
    dec b
    jr nz, Jump_00A_51A4
    ret

Jump_00A_51DF::
    ld a, [$CC44]
    cp a, $82
    jr nz, Jump_00A_51EB
    ld a, $01
    ld [$C96C], a

Jump_00A_51EB::
    ld a, $03
    ld [$CFC5], a
    ret

Jump_00A_51F1::
    ld a, $04
    ld [$CFC5], a
    ret

Jump_00A_51F7::
    ld a, $05
    ld [$CFC5], a
    ret

Func_00A_51FD::
    ld a, [$C904]
    rst $00
    dw Jump_00A_5207
    dw Jump_00A_52A4
    dw Jump_00A_525C

Jump_00A_5207::
    ld a, [$C608]
    ld [$D2CD], a
    ld a, [$C905]
    and a, $01
    sla a
    add a, $44
    call Func_000_122D
    ld a, $03
    ldh [$FFB9], a
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
    jr nc, Jump_00A_5245
    inc d

Jump_00A_5245::
    ld a, e
    ld [$C909], a
    ld a, d
    ld [$C90A], a
    xor a, a
    ld [$C906], a
    ld [$C907], a
    ld [$C908], a
    ld hl, $C904
    inc [hl]
    ret

Jump_00A_525C::
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
    call Func_00A_465D
    ld a, $04
    call Func_000_0DF2
    ld a, $04
    ld [$C5DB], a
    xor a, a
    ld [$C5DC], a
    ld [$C5DD], a
    ld [$C5DE], a
    ld hl, $C5DF
    inc [hl]
    ld hl, $D066
    inc [hl]
    ret

Jump_00A_52A4::
    ld a, [$C905]
    rst $00
    dw Jump_00A_52AE
    dw Jump_00A_5362
    dw Jump_00A_54AF

Jump_00A_52AE::
    ld a, [$C906]
    rst $00
    dw Jump_00A_52B6
    dw Jump_00A_5309

Jump_00A_52B6::
    ld a, [$C907]
    cp a, $14
    jr nz, Jump_00A_52C2
    ld hl, $C906
    inc [hl]
    ret

Jump_00A_52C2::
    ld a, [$C907]
    ld hl, $0000
    add a, l
    ld l, a
    jr nc, Jump_00A_52CD
    inc h

Jump_00A_52CD::
    ld b, $09

Jump_00A_52CF::
    push hl
    push bc
    call Func_00A_530E
    pop bc
    pop hl
    ld a, l
    add a, $40
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec b
    jr nz, Jump_00A_52CF
    ld a, [$C907]
    ld b, a
    ld a, $13
    sub a, b
    ld hl, $0020
    add a, l
    ld l, a
    jr nc, Jump_00A_52F0
    inc h

Jump_00A_52F0::
    ld b, $09

Jump_00A_52F2::
    push hl
    push bc
    call Func_00A_530E
    pop bc
    pop hl
    ld a, l
    add a, $40
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec b
    jr nz, Jump_00A_52F2
    ld hl, $C907
    inc [hl]
    ret

Jump_00A_5309::
    ld hl, $C904
    inc [hl]
    ret

Func_00A_530E::
    call Func_00A_5328
    ld a, $C4
    call Func_000_1211
    ld a, [$C525]
    or a, a
    ret z
    ld a, $01
    ldh [$FF4F], a
    xor a, a
    call Func_000_1211
    ld a, $00
    ldh [$FF4F], a
    ret

Func_00A_5328::
    push bc
    ld b, l
    ld a, l
    and a, $E0
    ld l, a
    call Func_00A_534E
    ld a, b
    and a, $1F
    jr z, Jump_00A_533D
    ld b, a

Jump_00A_5337::
    call Func_00A_533F
    dec b
    jr nz, Jump_00A_5337

Jump_00A_533D::
    pop bc
    ret

Func_00A_533F::
    push af
    ld a, l
    and a, $E0
    push af
    ld a, l
    inc a
    and a, $1F
    ld l, a
    pop af
    or a, l
    ld l, a
    pop af
    ret

Func_00A_534E::
    ld a, [$C909]
    add a, l
    ld l, a
    ld a, [$C90A]
    adc a, h
    and a, $03
    ld h, a
    ld a, [$C90A]
    and a, $FC
    or a, h
    ld h, a
    ret

Jump_00A_5362::
    ld b, $06

Jump_00A_5364::
    ld a, [$C906]
    rst $00
    dw Jump_00A_536E
    dw Jump_00A_53C6
    dw Jump_00A_54AA

Jump_00A_536E::
    push bc
    ld a, [$C907]
    cp a, $11
    jp c, Jump_00A_5413
    cp a, $23
    jp c, Jump_00A_5438
    cp a, $33
    jp c, Jump_00A_545D
    cp a, $43
    jp c, Jump_00A_5474
    cp a, $51
    jp c, Jump_00A_5413
    cp a, $5F
    jp c, Jump_00A_5438
    cp a, $6B
    jp c, Jump_00A_545D
    cp a, $77
    jp c, Jump_00A_5474
    cp a, $81
    jr c, Jump_00A_5413
    cp a, $8B
    jp c, Jump_00A_5438
    cp a, $93
    jp c, Jump_00A_545D
    cp a, $9B
    jp c, Jump_00A_5474
    cp a, $A1
    jr c, Jump_00A_5413
    cp a, $A7
    jp c, Jump_00A_5438
    cp a, $AB
    jp c, Jump_00A_545D
    cp a, $AF
    jp c, Jump_00A_5474
    cp a, $B1
    jr c, Jump_00A_5413
    jr Jump_00A_5438

Jump_00A_53C6::
    push bc
    ld a, [$C907]
    cp a, $02
    jr c, Jump_00A_5438
    cp a, $04
    jr c, Jump_00A_5413
    cp a, $08
    jp c, Jump_00A_5474
    cp a, $0C
    jp c, Jump_00A_545D
    cp a, $12
    jr c, Jump_00A_5438
    cp a, $18
    jr c, Jump_00A_5413
    cp a, $20
    jp c, Jump_00A_5474
    cp a, $28
    jr c, Jump_00A_545D
    cp a, $32
    jr c, Jump_00A_5438
    cp a, $3C
    jr c, Jump_00A_5413
    cp a, $48
    jr c, Jump_00A_5474
    cp a, $54
    jr c, Jump_00A_545D
    cp a, $62
    jr c, Jump_00A_5438
    cp a, $70
    jr c, Jump_00A_5413
    cp a, $80
    jr c, Jump_00A_5474
    cp a, $90
    jr c, Jump_00A_545D
    cp a, $A2
    jr c, Jump_00A_5438
    jr Jump_00A_5413

Jump_00A_5413::
    or a, a
    jr nz, Jump_00A_5421
    ld hl, $0233
    ld a, l
    ld [$C90B], a
    ld a, h
    ld [$C90C], a

Jump_00A_5421::
    ld a, [$C90B]
    ld l, a
    ld a, [$C90C]
    ld h, a
    push hl
    call Func_00A_530E
    pop hl
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    jr Jump_00A_5489

Jump_00A_5438::
    or a, a
    jr nz, Jump_00A_5446
    ld hl, $012A
    ld a, l
    ld [$C90B], a
    ld a, h
    ld [$C90C], a

Jump_00A_5446::
    ld a, [$C90B]
    ld l, a
    ld a, [$C90C]
    ld h, a
    push hl
    call Func_00A_530E
    pop hl
    ld a, l
    sub a, $01
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    jr Jump_00A_5489

Jump_00A_545D::
    ld a, [$C90B]
    ld l, a
    ld a, [$C90C]
    ld h, a
    push hl
    call Func_00A_530E
    pop hl
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    jr Jump_00A_5489

Jump_00A_5474::
    ld a, [$C90B]
    ld l, a
    ld a, [$C90C]
    ld h, a
    push hl
    call Func_00A_530E
    pop hl
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a

Jump_00A_5489::
    ld a, l
    ld [$C90B], a
    ld a, h
    ld [$C90C], a
    ld hl, $C907
    inc [hl]
    ld a, [$C907]
    cp a, $B4
    jr nz, Jump_00A_54A4
    ld hl, $C906
    inc [hl]
    xor a, a
    ld [$C907], a

Jump_00A_54A4::
    pop bc
    dec b
    jp nz, Jump_00A_5364
    ret

Jump_00A_54AA::
    ld hl, $C904
    inc [hl]
    ret

Jump_00A_54AF::
    ld a, [$C906]
    rst $00
    dw Jump_00A_54B9
    dw Jump_00A_5589
    dw Jump_00A_558E

Jump_00A_54B9::
    ld a, [$C907]
    or a, a
    jr nz, Jump_00A_54CA
    ld hl, $0000
    ld a, l
    ld [$C90B], a
    ld a, h
    ld [$C90C], a

Jump_00A_54CA::
    ld hl, $55FA
    ld a, [$C907]
    add a, l
    ld l, a
    jr nc, Jump_00A_54D5
    inc h

Jump_00A_54D5::
    ld b, [hl]
    ld hl, $560C
    ld a, [$C907]
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_00A_54E2
    inc h

Jump_00A_54E2::
    ld a, [$C90B]
    ld e, a
    ld a, [$C90C]
    ld d, a
    call Func_00A_5593

Jump_00A_54ED::
    push hl
    push bc
    call Func_00A_530E
    pop bc
    pop hl
    inc hl
    dec b
    jr nz, Jump_00A_54ED
    ld hl, $55FA
    ld a, [$C907]
    add a, l
    ld l, a
    jr nc, Jump_00A_5503
    inc h

Jump_00A_5503::
    ld b, [hl]
    ld a, [$C90B]
    ld l, a
    ld a, [$C90C]
    ld h, a

Jump_00A_550C::
    push hl
    push bc
    call Func_00A_530E
    pop bc
    pop hl
    inc hl
    dec b
    jr nz, Jump_00A_550C
    push hl
    ld hl, $5603
    ld a, [$C907]
    add a, l
    ld l, a
    jr nc, Jump_00A_5523
    inc h

Jump_00A_5523::
    ld b, [hl]
    pop hl
    dec hl

Jump_00A_5526::
    push hl
    push bc
    call Func_00A_530E
    pop bc
    pop hl
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec b
    jr nz, Jump_00A_5526
    ld hl, $5603
    ld a, [$C907]
    add a, l
    ld l, a
    jr nc, Jump_00A_5543
    inc h

Jump_00A_5543::
    ld b, [hl]
    ld a, [$C90B]
    ld l, a
    ld a, [$C90C]
    ld h, a

Jump_00A_554C::
    push hl
    push bc
    call Func_00A_530E
    pop bc
    pop hl
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec b
    jr nz, Jump_00A_554C
    ld a, [$C90B]
    ld l, a
    ld a, [$C90C]
    ld h, a
    ld a, l
    add a, $21
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, l
    ld [$C90B], a
    ld a, h
    ld [$C90C], a
    ld hl, $C907
    inc [hl]
    ld hl, $C906
    inc [hl]
    ld a, [$C907]
    cp a, $09
    ret nz
    ld hl, $C906
    inc [hl]
    ret

Jump_00A_5589::
    ld hl, $C906
    dec [hl]
    ret

Jump_00A_558E::
    ld hl, $C904
    inc [hl]
    ret

Func_00A_5593::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    jp hl
    INCBIN "dwm2-cobi-us.gbc", $029597, $87

Func_00A_561E::
    ld a, [$C91F]
    or a, a
    ret nz
    ld a, [$C901]
    and a, $7F
    ret z
    xor a, a
    ldh [$FFC6], a
    ld a, [$C7C9]
    ld l, a
    ld a, [$C7CA]
    ld h, a
    inc hl
    push hl
    ld a, $64
    call Func_000_16D1
    or a, a
    jr nz, Jump_00A_5642
    ld a, $01
    ldh [$FFC6], a

Jump_00A_5642::
    pop hl
    ld a, l
    cp a, $E8
    jr nz, Jump_00A_5656
    ld a, h
    cp a, $03
    jr nz, Jump_00A_5656
    ldh a, [$FFC6]
    or a, $02
    ldh [$FFC6], a
    ld hl, $0000

Jump_00A_5656::
    ld a, l
    ld [$C7C9], a
    ld a, h
    ld [$C7CA], a
    ldh a, [$FFC6]
    or a, a
    ret z
    ld a, $0A
    ld [$0100], a
    ld hl, $A000
    ld a, $6B
    add a, l
    ld l, a
    jr nc, Jump_00A_5671
    inc h

Jump_00A_5671::
    ld de, $A000
    ld b, $1E

Jump_00A_5676::
    ld a, [de]
    or a, a
    jr z, Jump_00A_56B8
    dec a
    jr nz, Jump_00A_56A7
    ldh a, [$FFC6]
    bit 1, a
    jr z, Jump_00A_56B8
    push de
    ld a, e
    add a, $6E
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    ld a, [de]
    pop de
    or a, a
    jr nz, Jump_00A_56B8
    push de
    ld a, [hl+]
    ld e, a
    ld a, [hl-]
    ld d, a
    cp a, $03
    jr nz, Jump_00A_569F
    ld a, e
    cp a, $E7
    jr z, Jump_00A_56A4

Jump_00A_569F::
    inc de
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl-], a

Jump_00A_56A4::
    pop de
    jr Jump_00A_56B8

Jump_00A_56A7::
    push de
    ld a, [hl+]
    ld e, a
    ld a, [hl-]
    ld d, a
    cp a, e
    jr nz, Jump_00A_56B2
    or a, a
    jr z, Jump_00A_56B7

Jump_00A_56B2::
    dec de
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl-], a

Jump_00A_56B7::
    pop de

Jump_00A_56B8::
    ld a, e
    add a, $A5
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    ld a, l
    add a, $A5
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec b
    jr nz, Jump_00A_5676
    xor a, a
    ld [$0100], a
    ret

Func_00A_56D0::
    ld a, [$C901]
    and a, $7F
    ret z
    ld a, [$C91F]
    or a, a
    ret nz
    ld de, $0002
    call Func_000_181B
    ret nc
    ld a, [$C6FD]
    or a, a
    ret z
    ld b, a
    ld hl, $C6FE
    ld a, $0A
    ld [$0100], a

Jump_00A_56F0::
    push bc
    ld a, [hl]
    ld c, $55
    call Func_000_1F80
    bit 7, a
    jr nz, Jump_00A_573E
    ld a, [hl]
    ld c, $A4
    call Func_000_1F80
    cp a, $1B
    jr nz, Jump_00A_5709
    ld c, $5D
    jr Jump_00A_570F

Jump_00A_5709::
    cp a, $1C
    jr nz, Jump_00A_573E
    ld c, $61

Jump_00A_570F::
    push bc
    ld a, [hl]
    call Func_000_1F89
    ldh a, [$FFC6]
    ld e, a
    ldh a, [$FFC7]
    ld d, a
    pop bc
    dec c
    dec c
    push bc
    ld a, [hl]
    call Func_000_1F89
    pop bc
    ldh a, [$FFC6]
    cp a, e
    jr nz, Jump_00A_572D
    ldh a, [$FFC7]
    cp a, d
    jr z, Jump_00A_573E

Jump_00A_572D::
    ldh a, [$FFC6]
    ld e, a
    ldh a, [$FFC7]
    ld d, a
    inc de
    push hl
    ld a, [hl]
    call Func_000_1FD1
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl], a
    pop hl

Jump_00A_573E::
    pop bc
    inc hl
    dec b
    jr nz, Jump_00A_56F0
    xor a, a
    ld [$0100], a
    ret

Func_00A_5748::
    ldh a, [$FF93]
    bit 7, a
    ret z
    ld a, [$C91F]
    or a, a
    ret nz
    ldh a, [$FF96]
    ld l, a
    ldh a, [$FF97]
    ld h, a
    dec hl
    ld a, l
    ldh [$FF96], a
    ld a, h
    ldh [$FF97], a
    ld a, h
    bit 7, a
    ret z
    ld a, $0A
    ld [$C916], a
    xor a, a
    ld [$C917], a
    ld hl, $405C
    ld b, $13
    rst $10
    ret
    dw Data_00A_57F3
    dw Data_00A_57F3
    dw Data_00A_57F3
    dw Data_00A_57F3
    dw Data_00A_57FE
    dw Data_00A_5827
    dw Data_00A_5827
    dw Data_00A_5845
    db $F3, $57, $F3, $57, $F3, $57, $F3, $57, $FE, $57, $FE, $57, $27, $58, $27, $58
    db $F3, $57, $F3, $57, $F3, $57, $FE, $57, $FE, $57, $FE, $57, $FE, $57, $27, $58
    dw Data_00A_57F3
    dw Data_00A_57F3
    dw Data_00A_57F3
    dw Data_00A_57FE
    dw Data_00A_57FE
    dw Data_00A_57FE
    dw Data_00A_5818
    dw Data_00A_5827
    dw Data_00A_57F3
    dw Data_00A_57F3
    dw Data_00A_57F3
    dw Data_00A_57F3
    dw Data_00A_5818
    dw Data_00A_5836
    dw Data_00A_5845
    dw Data_00A_5845
    db $0B, $58, $F3, $57, $F3, $57, $F3, $57, $18, $58, $36, $58, $45, $58, $45, $58
    dw Data_00A_580B
    dw Data_00A_580B
    dw Data_00A_580B
    dw Data_00A_580B
    dw Data_00A_5818
    dw Data_00A_5836
    dw Data_00A_5845
    dw Data_00A_5845
    dw Data_00A_57F3
    dw Data_00A_57F3
    dw Data_00A_580B
    dw Data_00A_5818
    dw Data_00A_5818
    dw Data_00A_5836
    dw Data_00A_5845
    dw Data_00A_5845

Data_00A_57F3:: ; heuristic: target of a monotone pointer table; C0
    db $01, $07, $03, $07, $00, $00, $00, $02, $00, $03, $00

Data_00A_57FE:: ; heuristic: target of a monotone pointer table; C0
    db $01, $0B, $04, $08, $0B, $00, $00, $02, $00, $03, $00, $05, $00

Data_00A_580B:: ; heuristic: target of a monotone pointer table; C0
    db $01, $0C, $05, $0A, $0C, $00, $00, $02, $00, $03, $00, $04, $00

Data_00A_5818:: ; heuristic: target of a monotone pointer table; C0
    db $01, $10, $05, $0A, $0C, $10, $00, $02, $00, $03, $00, $04, $00, $05, $00

Data_00A_5827:: ; heuristic: target of a monotone pointer table; C0
    db $02, $0D, $02, $04, $09, $0D, $00, $02, $00, $03, $00, $05, $00, $06, $00

Data_00A_5836:: ; heuristic: target of a monotone pointer table; C0
    db $02, $0E, $02, $04, $09, $0E, $00, $02, $00, $03, $00, $05, $00, $04, $00

Data_00A_5845:: ; heuristic: target of a monotone pointer table; C0
    db $02, $14, $02, $04, $09, $0E, $14, $02, $00, $03, $00, $05, $00

Data_00A_5852:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $029852, $207

Data_00A_5A59:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $029A59, $172
    dw Data_00A_5C8B
    dw Data_00A_5C8B
    dw Data_00A_5C8B
    dw Data_00A_5C8B
    dw Data_00A_5C8B
    dw Data_00A_5CB4
    dw Data_00A_5CB4
    dw Data_00A_5CB4
    dw Data_00A_5CC3
    dw Data_00A_5CD2
    INCBIN "dwm2-cobi-us.gbc", $029BDF, $62
    dw Data_00A_5C8B
    dw Data_00A_5C8B
    dw Data_00A_5CEE
    dw Data_00A_5CEE
    dw Data_00A_5CEE
    dw Data_00A_5D0E
    dw Data_00A_5D0E
    dw Data_00A_5D0E
    dw Data_00A_5D0E
    dw Data_00A_5D1D
    dw Data_00A_5D1D
    dw Data_00A_5D1D
    dw Data_00A_5D1D

Data_00A_5C5B:: ; heuristic: target of a monotone pointer table; C0
    db $EE, $5C, $FD, $5C, $EE, $5C, $EE, $5C, $0E, $5D, $0E, $5D, $0E, $5D, $8B, $5C
    db $1D, $5D, $1D, $5D, $1D, $5D, $1D, $5D, $EE, $5C, $EE, $5C, $EE, $5C, $8B, $5C
    db $8B, $5C, $8B, $5C, $8B, $5C, $8B, $5C, $8B, $5C, $1D, $5D, $1D, $5D, $1D, $5D

Data_00A_5C8B:: ; heuristic: target of a monotone pointer table; C0
    db $01, $07, $03, $07, $00, $00, $00, $02, $00, $03, $00, $03, $0E, $04, $09, $0E
    db $00, $00, $36, $00, $3C, $00, $91, $01, $03, $15, $04, $09, $0E, $11, $15, $38
    db $00, $2B, $00, $3B, $00, $36, $00, $3C, $00

Data_00A_5CB4:: ; heuristic: target of a monotone pointer table; C0
    db $03, $12, $05, $09, $0D, $12, $00, $2A, $00, $2B, $00, $3B, $00, $36, $00

Data_00A_5CC3:: ; heuristic: target of a monotone pointer table; C0
    db $03, $12, $04, $08, $0D, $12, $00, $2B, $00, $3B, $00, $36, $00, $91, $01

Data_00A_5CD2:: ; heuristic: target of a monotone pointer table; C0
    db $03, $0C, $02, $07, $0C, $00, $00, $40, $00, $36, $00, $91, $01, $03, $10, $04
    db $09, $0D, $10, $00, $2A, $00, $2D, $00, $36, $00, $34, $00

Data_00A_5CEE:: ; heuristic: target of a monotone pointer table; C0
    db $03, $12, $04, $09, $0E, $12, $00, $28, $00, $2D, $00, $34, $00, $3E, $00, $03
    db $15, $03, $07, $0D, $11, $15, $28, $00, $2D, $00, $38, $00, $3B, $00, $3E, $00

Data_00A_5D0E:: ; heuristic: target of a monotone pointer table; C0
    db $03, $12, $05, $0A, $0E, $12, $00, $2C, $00, $37, $00, $34, $00, $3E, $00

Data_00A_5D1D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $029D1D, $140

Data_00A_5E5D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $029E5D, $92
    dw Data_00A_5F4B
    dw Data_00A_5FA1
    dw Data_00A_5FBF
    dw Data_00A_5FBF
    dw Data_00A_5FBF
    dw Data_00A_5FCE
    dw Data_00A_5FCE
    dw Data_00A_5FCE
    db $4B, $5F, $4B, $5F, $EE, $5F, $EE, $5F
    dw Data_00A_5F4B
    dw Data_00A_5F4B
    dw Data_00A_5FBF
    dw Data_00A_5FBF
    dw Data_00A_5FBF
    dw Data_00A_5FBF
    dw Data_00A_5FBF
    dw Data_00A_5FDF
    dw Data_00A_5FDF
    dw Data_00A_5FDF
    dw Data_00A_5FEE
    dw Data_00A_5FEE
    dw Data_00A_5FEE
    dw Data_00A_5FEE
    db $B0, $5F, $B0, $5F, $BF, $5F, $4B, $5F, $4B, $5F, $DF, $5F, $DF, $5F, $DF, $5F
    db $EE, $5F, $EE, $5F, $EE, $5F, $EE, $5F, $B0, $5F, $B0, $5F, $BF, $5F, $4B, $5F
    db $4B, $5F, $4B, $5F, $DF, $5F, $DF, $5F

Data_00A_5F4B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $029F4B, $56

Data_00A_5FA1:: ; heuristic: target of a monotone pointer table; C0
    db $02, $10, $03, $06, $0B, $10, $00, $5E, $00, $A9, $01, $A8, $01, $4D, $00, $02
    db $13, $06, $0C, $12, $13, $00, $A8, $01, $5C, $00, $4D, $00, $53, $00

Data_00A_5FBF:: ; heuristic: target of a monotone pointer table; C0
    db $02, $14, $06, $0C, $12, $14, $00, $A8, $01, $5C, $00, $4D, $00, $58, $00

Data_00A_5FCE:: ; heuristic: target of a monotone pointer table; C0
    db $03, $16, $04, $09, $0E, $13, $16, $55, $00, $5D, $00, $4D, $00, $5C, $00, $A8
    db $01

Data_00A_5FDF:: ; heuristic: target of a monotone pointer table; C0
    db $03, $12, $05, $0A, $0E, $12, $00, $AA, $01, $6F, $00, $59, $00, $62, $00

Data_00A_5FEE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $029FEE, $71

Data_00A_605F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $02A05F, $19D
    dw Func_000_1362
    dw Func_000_1362
    dw Func_000_1362
    dw Func_000_1362
    dw Func_000_1362
    dw Func_000_1362
    dw Func_000_1362
    dw Func_000_1362
    dw Func_000_1362
    dw Func_000_1362
    dw Func_000_1362
    INCBIN "dwm2-cobi-us.gbc", $02A212, $F8
    dw Data_00A_6332
    dw Data_00A_6332
    dw Data_00A_633F
    dw Data_00A_633F
    dw Data_00A_633F
    dw Data_00A_634E
    dw Data_00A_634E
    dw Data_00A_634E
    dw Data_00A_634E
    dw Data_00A_635D
    dw Data_00A_635D
    dw Data_00A_635D
    dw Data_00A_635D
    dw Data_00A_635D
    dw Data_00A_635D
    dw Data_00A_636A
    dw Data_00A_636A
    db $5D, $63, $5D, $63, $5D, $63

Data_00A_6332:: ; heuristic: target of a monotone pointer table; C0
    db $03, $0A, $03, $07, $0A, $00, $00, $EF, $01, $F2, $01, $F7, $01

Data_00A_633F:: ; heuristic: target of a monotone pointer table; C0
    db $03, $0A, $03, $06, $08, $0A, $00, $EF, $01, $F2, $01, $F4, $01, $F7, $01

Data_00A_634E:: ; heuristic: target of a monotone pointer table; C0
    db $03, $0A, $03, $06, $08, $0A, $00, $ED, $01, $EE, $01, $EF, $01, $F7, $01

Data_00A_635D:: ; heuristic: target of a monotone pointer table; C0
    db $03, $0A, $04, $07, $0A, $00, $00, $ED, $01, $EE, $01, $F7, $01

Data_00A_636A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $02A36A, $6A
    ds $48D, $00

Data_00A_6861:: ; heuristic: target of a monotone pointer table; C0
    ds $A10, $00

Data_00A_7271:: ; heuristic: target of a monotone pointer table; C0
    ds $707, $00

Data_00A_7978:: ; heuristic: target of a monotone pointer table; C0
    ds $404, $00

Data_00A_7D7C:: ; heuristic: target of a monotone pointer table; C0
    ds $202, $00

Data_00A_7F7E:: ; heuristic: target of a monotone pointer table; C0
    ds $82, $00
