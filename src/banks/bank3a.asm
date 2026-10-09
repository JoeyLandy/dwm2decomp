SECTION "Bank 3A", ROMX[$4000], BANK[$3A]
    db $3A

Func_03A_4001::
    ld a, [$D8A5]
    and a, $03
    cp a, $03
    jr nz, Jump_03A_4019
    ld a, [$D8A6]
    cp a, $85
    ret c
    cp a, $89
    ret nc
    ld a, [$DAD2]
    and a, $41
    ret z

Jump_03A_4019::
    ld a, [$DAD2]
    or a, a
    ret z
    bit 7, a
    jr nz, Jump_03A_406E
    bit 6, a
    jr nz, Jump_03A_4073
    bit 5, a
    jr nz, Jump_03A_407B
    bit 4, a
    jr nz, Jump_03A_404D
    bit 3, a
    jr nz, Jump_03A_4042
    bit 2, a
    jr nz, Jump_03A_4037
    ret

Jump_03A_4037::
    ld a, [$D8A5]
    ld [$D8A4], a
    ld hl, Data_03A_47EC
    jr Jump_03A_407E

Jump_03A_4042::
    ld a, [$D8A5]
    ld [$D8A4], a
    ld hl, Data_03A_486C
    jr Jump_03A_407E

Jump_03A_404D::
    bit 0, a
    ret z
    srl a
    and a, $07
    cp a, $00
    jr z, Jump_03A_4062
    cp a, $01
    jr z, Jump_03A_405D
    ret

Jump_03A_405D::
    ld a, $14
    jp Jump_03A_48EC

Jump_03A_4062::
    call Func_03A_7CB5
    ld a, $02
    jp c, Jump_03A_40B3
    ld a, $03
    jr Jump_03A_40B3

Jump_03A_406E::
    ld hl, Data_03A_40CC
    jr Jump_03A_407E

Jump_03A_4073::
    bit 0, a
    ret z
    ld hl, Data_03A_4294
    jr Jump_03A_407E

Jump_03A_407B::
    ld hl, Data_03A_445C

Jump_03A_407E::
    ld a, [$D8A6]
    push af
    ld c, a
    ld b, $00
    add hl, bc
    add hl, bc
    pop af
    cp a, $6C
    jr z, Jump_03A_40A2
    ld a, [$DABF]
    bit 0, a
    jr nz, Jump_03A_40A2
    ld a, [$CFF2]
    cp a, $80
    jr z, Jump_03A_40A2
    call Func_03A_7C9A
    jr nc, Jump_03A_40AA
    inc hl
    jr Jump_03A_40AA

Jump_03A_40A2::
    call Func_03A_7CB5
    jr c, Jump_03A_40AA
    inc hl
    jr Jump_03A_40AA

Jump_03A_40AA::
    ld a, [hl]
    cp a, $FF
    ret z
    bit 7, a
    jp z, Jump_03A_48EC

Jump_03A_40B3::
    and a, $7F
    ld [$D803], a
    ld a, $00
    ld [$D802], a
    xor a, a
    ld hl, $D804
    ld bc, $0004
    call Func_000_0949
    xor a, a
    ld [$DAF1], a
    ret

Data_03A_40CC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $FF, $FF, $00, $FF, $01, $FF, $02, $FF, $03, $FF, $04, $FF, $05, $FF, $06
    db $FF, $07, $FF, $08, $FF, $09, $FF, $0A, $FF, $0B, $FF, $0F, $FF, $10, $FF, $11
    db $FF, $0C, $FF, $0D, $FF, $0E
    ds $10, $FF

Data_03A_4102:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $42, $FF
    db $86, $86, $FF, $2A, $FF, $29, $FF, $28, $FF, $03, $FF

Data_03A_414F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0E814F, $59
    ds $22, $FF
    db $84, $84, $84, $84, $84, $84, $85, $85, $2B, $2B, $85, $85
    ds $19, $FF
    db $30
    ds $12, $FF
    db $31, $FF, $84, $84
    ds $2C, $FF
    db $85, $85
    ds $33, $FF
    db $30, $FF, $FF, $FF, $FF, $FF, $33, $FF, $34, $FF, $35, $FF, $36, $FF, $37, $FF
    db $38, $FF, $FF, $FF, $30, $FF, $1D, $FF, $2A, $FF, $FF, $85, $85, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $3B, $FF

Data_03A_4294:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0E8294, $60

Data_03A_42F4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0E82F4, $C4
    ds $1A, $FF
    db $14, $FF, $FF, $FF, $32, $32
    ds $10, $FF
    INCBIN "dwm2-cobi-us.gbc", $0E83E8, $74

Data_03A_445C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $BF, $FF
    db $15, $FF, $15, $FF, $15
    ds $16, $FF
    db $8D, $83, $FF, $FF, $8D, $83, $8D, $83
    ds $2AE, $FF

Data_03A_47EC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $FF, $14, $FF, $14, $FF, $14, $FF, $14, $FF, $14, $FF, $14, $FF, $14, $FF
    db $14, $FF, $14, $FF, $14, $FF, $14
    ds $2D, $FF
    db $12, $FF, $FF, $FF, $82, $FF, $82, $FF, $82, $FF, $82
    ds $31, $FF

Data_03A_486C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $32, $FF
    db $2C, $FF, $2C, $FF, $2C, $FF, $2C, $FF, $15, $FF, $32, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $09, $FF, $0F, $FF, $0E, $FF, $02
    ds $31, $FF

Jump_03A_48EC::
    push af
    xor a, a
    ld [$C952], a
    ld a, [$D8A6]
    cp a, $D7
    jr z, Jump_03A_48FA
    jr Jump_03A_48FF

Jump_03A_48FA::
    ld a, $01
    ld [$C952], a

Jump_03A_48FF::
    pop af
    ld b, a
    call Func_03A_4A19
    call Func_03A_49EB
    ld a, b
    jr nc, Jump_03A_492E
    cp a, $2B
    jr z, Jump_03A_492E
    cp a, $32
    jr z, Jump_03A_492E
    cp a, $13
    jr z, Jump_03A_4917
    ret

Jump_03A_4917::
    ld a, [$D8A6]
    cp a, $32
    jr z, Jump_03A_4921
    cp a, $77
    ret nz

Jump_03A_4921::
    ld a, [$DAD2]
    cp a, $41
    ret nz
    ld a, [$D8A4]
    ld [$D868], a
    ld a, b

Jump_03A_492E::
    ld [$D801], a
    ld [$DAB5], a
    ld b, a
    call Func_03A_4A06
    jr z, Jump_03A_4962
    ld a, b
    cp a, $09
    jr nz, Jump_03A_494A
    ld a, [$D8A6]
    cp a, $48
    ld a, b
    jr nz, Jump_03A_494A
    xor a, a
    jr Jump_03A_4962

Jump_03A_494A::
    cp a, $0D
    jr nz, Jump_03A_4959
    ld hl, $DAD2
    bit 1, [hl]
    jr z, Jump_03A_4959
    ld a, $00
    jr Jump_03A_4962

Jump_03A_4959::
    ld hl, Data_03A_49AF
    add a, l
    ld l, a
    jr nc, Jump_03A_4961
    inc h

Jump_03A_4961::
    ld a, [hl]

Jump_03A_4962::
    ld [$DAB9], a
    cp a, $00
    jr nz, Jump_03A_4970
    ld a, [$D868]
    call Func_000_3E54
    ret c

Jump_03A_4970::
    xor a, a
    ld [$D804], a
    ld a, $FF
    ld hl, $D805
    ld bc, $0003
    call Func_000_0949
    ld a, $01
    ld [$D802], a
    ld a, $01
    ld [$D800], a
    ld a, $01
    ld [$DAAA], a
    ld a, $00
    ld [$DAB3], a
    ld hl, $DAB3
    ld a, l
    ld [$CB75], a
    ld a, h
    ld [$CB76], a
    ld hl, Func_03A_4001
    ld b, $32
    rst $10
    call Func_03A_4A3A
    ld a, [$D801]
    ld c, a
    call Func_03A_5516
    ret

Data_03A_49AF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $01, $01, $01, $02, $02, $01, $02, $01, $01, $01, $02, $01, $02
    db $02, $01, $00, $00, $00, $00, $00, $00, $00, $00, $01, $02, $01, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $01, $02, $01, $01, $01, $00, $00, $01, $00
    db $00, $00, $01, $01, $00, $00, $00, $00, $01, $01, $01, $01

Func_03A_49EB::
    ld a, [$C58A]
    cp a, $01
    jr nz, Jump_03A_4A00
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_03A_4A00
    ld a, [$D868]
    cp a, $04
    ccf
    ret

Jump_03A_4A00::
    ld a, [$D868]
    cp a, $04
    ret

Func_03A_4A06::
    ld a, [$DAD2]
    bit 3, a
    ret nz
    ld a, b
    cp a, $1D
    ret nz
    ld a, [$D8A6]
    cp a, $65
    ret nz
    ld a, $02
    ret

Func_03A_4A19::
    ld a, [$DAD2]
    bit 3, a
    jr nz, Jump_03A_4A33
    ld a, [$D8A6]
    cp a, $3A
    jr z, Jump_03A_4A2C
    ld a, [$D8A5]
    jr Jump_03A_4A2F

Jump_03A_4A2C::
    ld a, [$D8A4]

Jump_03A_4A2F::
    ld [$D868], a
    ret

Jump_03A_4A33::
    ld a, [$D8A5]
    ld [$D868], a
    ret

Func_03A_4A3A::
    ld a, [$DAB9]
    cp a, $00
    jr z, Jump_03A_4A4F
    cp a, $01
    jr z, Jump_03A_4A79
    cp a, $02
    jr z, Jump_03A_4A7F
    ld a, $00
    ld [$D804], a
    ret

Jump_03A_4A4F::
    ld a, [$D890]
    ld b, a
    ld a, b
    cp a, $03
    jr z, Jump_03A_4A60
    cp a, $02
    jr z, Jump_03A_4A64
    ld b, $05
    jr Jump_03A_4A66

Jump_03A_4A60::
    ld b, $00
    jr Jump_03A_4A66

Jump_03A_4A64::
    ld b, $03

Jump_03A_4A66::
    ld a, [$D868]
    and a, $03
    add a, b
    ld hl, Data_03A_4AD5
    add a, l
    ld l, a
    jr nc, Jump_03A_4A74
    inc h

Jump_03A_4A74::
    ld a, [hl]
    ld [$D804], a
    ret

Jump_03A_4A79::
    ld a, $50
    ld [$D804], a
    ret

Jump_03A_4A7F::
    ld c, $04
    ld a, [$D890]
    ld b, a
    ld a, [$C58A]
    cp a, $01
    jr nz, Jump_03A_4A95
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_03A_4A95
    ld c, $00

Jump_03A_4A95::
    ld e, $00
    ld a, b
    cp a, $03
    jr z, Jump_03A_4AA4
    cp a, $02
    jr z, Jump_03A_4AA8
    ld d, $05
    jr Jump_03A_4A66

Jump_03A_4AA4::
    ld d, $00
    jr Jump_03A_4AAA

Jump_03A_4AA8::
    ld d, $03

Jump_03A_4AAA::
    ld a, c
    call Func_000_3E54
    jr c, Jump_03A_4ACA
    ld a, e
    ld hl, $D805
    add a, l
    ld l, a
    jr nc, Jump_03A_4AB9
    inc h

Jump_03A_4AB9::
    push hl
    ld a, c
    and a, $03
    add a, d
    ld hl, Data_03A_4AD5
    add a, l
    ld l, a
    jr nc, Jump_03A_4AC6
    inc h

Jump_03A_4AC6::
    ld a, [hl]
    pop hl
    ld [hl], a
    inc e

Jump_03A_4ACA::
    inc c
    dec b
    jr nz, Jump_03A_4AAA
    ld a, [$D805]
    ld [$D804], a
    ret

Data_03A_4AD5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $20, $50, $80, $38, $68, $50

Func_03A_4ADB::
    ld a, [$D802]
    cp a, $00
    jp z, Jump_03A_4C14
    ld a, [$D800]
    cp a, $01
    jr nz, Jump_03A_4B04
    ld a, [$D801]
    ld c, a
    call Func_03A_52A4
    ld a, $02
    ld [$D800], a
    ld a, [$DAD2]
    srl a
    and a, $44
    ld [$DAD3], a
    call Func_03A_5762
    ret

Jump_03A_4B04::
    ld a, [$D800]
    cp a, $02
    jp nz, Jump_03A_4B87
    ld a, [$C58A]
    or a, a
    jr nz, Jump_03A_4B18
    ld hl, Func_03A_4001
    ld b, $32
    rst $10

Jump_03A_4B18::
    call Func_03A_536D
    ld a, [$DAB3]
    or a, a
    jr z, Jump_03A_4B2B
    ld a, [$DAAA]
    or a, a
    jr z, Jump_03A_4B2B
    call Func_03A_5383
    ret

Jump_03A_4B2B::
    ld a, [$DAB9]
    cp a, $02
    jr nz, Jump_03A_4B74
    ld a, [$D806]
    cp a, $FF
    jr z, Jump_03A_4B53
    ld a, [$D806]
    ld [$D804], a
    ld a, $FF
    ld [$D806], a
    xor a, a
    ld [$DAAA], a
    ld a, $03
    ld [$D800], a
    ld a, $08
    ld [$DAF1], a
    ret

Jump_03A_4B53::
    ld a, [$D807]
    cp a, $FF
    jr z, Jump_03A_4B74
    ld a, [$D807]
    ld [$D804], a
    ld a, $FF
    ld [$D807], a
    xor a, a
    ld [$DAAA], a
    ld a, $03
    ld [$D800], a
    ld a, $08
    ld [$DAF1], a
    ret

Jump_03A_4B74::
    ld a, [$C952]
    or a, a
    jr nz, Jump_03A_4BB5
    xor a, a
    ld [$D800], a
    ld [$DAAA], a
    ld a, $FF
    ld [$D802], a
    ret

Jump_03A_4B87::
    ld hl, $DAF1
    dec [hl]
    ld a, [hl]
    or a, a
    ret nz
    xor a, a
    ld [$DAF1], a
    ld a, $02
    ld [$D800], a
    ld a, $01
    ld [$DAAA], a
    ld a, $00
    ld [$DAB3], a
    ld hl, Func_03A_4001
    ld b, $32
    rst $10
    ld a, [$DAD2]
    srl a
    and a, $44
    ld [$DAD3], a
    call Func_03A_5762
    ret

Jump_03A_4BB5::
    xor a, a
    ld [$C952], a
    ld a, [$D8A6]
    sub a, $D7
    sla a
    ld hl, Data_03A_4C12
    add a, l
    ld l, a
    jr nc, Jump_03A_4BC8
    inc h

Jump_03A_4BC8::
    ld a, [hl+]
    ld [$D801], a
    ld [$DAB5], a
    ld a, [hl]
    ld [$DAB9], a
    xor a, a
    ld [$D804], a
    ld a, $FF
    ld hl, $D805
    ld bc, $0003
    call Func_000_0949
    ld a, $01
    ld [$D802], a
    ld a, $01
    ld [$D800], a
    ld a, $01
    ld [$DAAA], a
    ld a, $00
    ld [$DAB3], a
    ld hl, $DAB3
    ld a, l
    ld [$CB75], a
    ld a, h
    ld [$CB76], a
    ld hl, Func_03A_4001
    ld b, $32
    rst $10
    call Func_03A_4A3A
    ld a, [$D801]
    ld c, a
    call Func_03A_5516
    ret

Data_03A_4C12:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $22, $00

Jump_03A_4C14::
    call Func_03A_4C26
    call Func_03A_5536
    ld a, [$D802]
    cp a, $FF
    ret nz
    ld a, $7F
    ld [$C526], a
    ret

Func_03A_4C26::
    ld a, [$DAF1]
    inc a
    cp a, $05
    ld [$DAF1], a
    ret c
    xor a, a
    ld [$DAF1], a
    ld a, [$D803]
    rst $00
    dw Jump_03A_4C54
    dw Jump_03A_4C54
    dw Jump_03A_4C5E
    dw Jump_03A_4DF4
    dw Jump_03A_4E35
    dw Jump_03A_4E74
    dw Jump_03A_4F06
    dw Jump_03A_4F42
    dw Jump_03A_4F97
    dw Jump_03A_507A
    dw Jump_03A_508A
    dw Jump_03A_5114
    dw Jump_03A_513A
    dw Jump_03A_51DF

Jump_03A_4C54::
    ld a, $FF
    ld [$D802], a
    xor a, a
    ld [$D804], a
    ret

Jump_03A_4C5E::
    ld a, [$D8A5]
    and a, $03
    cp a, $03
    jp z, Jump_03A_4CEB
    ld a, [$C58A]
    cp a, $01
    jr nz, Jump_03A_4C7F
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_03A_4C7F
    ld a, [$D8A5]
    cp a, $04
    jr nc, Jump_03A_4CEB
    jr Jump_03A_4C86

Jump_03A_4C7F::
    ld a, [$D8A5]
    cp a, $04
    jr c, Jump_03A_4CEB

Jump_03A_4C86::
    ld a, [$D8A5]
    call Func_000_3E54
    jr c, Jump_03A_4CEB
    ld a, [$D804]
    rst $00
    dw Jump_03A_4C9C
    dw Jump_03A_4CC2
    dw Jump_03A_4C9C
    dw Jump_03A_4CC2
    dw Jump_03A_4CEB

Jump_03A_4C9C::
    ld a, $06
    ld [$D805], a
    call Func_03A_4CF9
    ld hl, Data_03A_4D52
    call Func_03A_4D47
    ld de, $9800
    add hl, de
    ld e, l
    ld d, h
    ld a, $03
    ld hl, Data_03A_4D5C
    call Func_03A_4D47
    ld c, $06
    call Func_03A_4D2B
    ld hl, $D804
    inc [hl]
    ret

Jump_03A_4CC2::
    ld a, $06
    ld [$D805], a
    call Func_03A_4CF9
    ld hl, Data_03A_4D52
    call Func_03A_4D47
    ld de, $9800
    add hl, de
    ld e, l
    ld d, h
    ld a, [$D8A5]
    and a, $03
    ld hl, Data_03A_4D5C
    call Func_03A_4D47
    ld c, $06
    call Func_03A_4D2B
    ld hl, $D804
    inc [hl]
    ret

Jump_03A_4CEB::
    ld a, $FF
    ld [$D802], a
    xor a, a
    ld [$D804], a
    xor a, a
    ld [$D805], a
    ret

Func_03A_4CF9::
    ld a, [$D890]
    cp a, $01
    jr z, Jump_03A_4D28
    cp a, $02
    jr z, Jump_03A_4D17
    ld a, [$D8A5]
    and a, $03
    cp a, $01
    jr z, Jump_03A_4D28
    jr c, Jump_03A_4D13
    ld a, $04
    jr Jump_03A_4D2A

Jump_03A_4D13::
    ld a, $03
    jr Jump_03A_4D2A

Jump_03A_4D17::
    ld a, [$D8A5]
    and a, $03
    cp a, $01
    jr z, Jump_03A_4D24
    ld a, $01
    jr Jump_03A_4D2A

Jump_03A_4D24::
    ld a, $02
    jr Jump_03A_4D2A

Jump_03A_4D28::
    ld a, $00

Jump_03A_4D2A::
    ret

Func_03A_4D2B::
    push de
    ld a, [$D805]
    ld b, a

Jump_03A_4D30::
    di
    call Func_000_120A
    ld a, [hl+]
    ld [de], a
    ei
    inc de
    dec b
    jr nz, Jump_03A_4D30
    pop de
    dec c
    ret z
    ld a, $20
    add a, e
    ld e, a
    jr nc, Jump_03A_4D45
    inc d

Jump_03A_4D45::
    jr Func_03A_4D2B

Func_03A_4D47::
    add a, a
    add a, l
    ld l, a
    ld a, $00
    adc a, h
    ld h, a
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ret

Data_03A_4D52:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $E7, $00, $E4, $00, $EA, $00, $E1, $00, $ED, $00

Data_03A_4D5C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0E8D5C, $74
    ds $24, $C3

Jump_03A_4DF4::
    ld a, [$D804]
    rst $00
    dw Jump_03A_4E00
    dw Jump_03A_4E1A
    dw Jump_03A_4E00
    dw Jump_03A_4E25

Jump_03A_4E00::
    ld a, $02
    ldh [$FFA5], a
    ld a, $00
    ldh [$FFA1], a
    ld hl, $D804
    inc [hl]
    ret

Func_03A_4E0D:: ; heuristic: follows a terminator; C0
    ld a, $00
    ldh [$FFA5], a
    ld a, $01
    ldh [$FFA1], a
    ld hl, $D804
    inc [hl]
    ret

Jump_03A_4E1A::
    xor a, a
    ldh [$FFA5], a
    xor a, a
    ldh [$FFA1], a
    ld hl, $D804
    inc [hl]
    ret

Jump_03A_4E25::
    ld a, $FF
    ld [$D802], a
    xor a, a
    ldh [$FFA5], a
    xor a, a
    ldh [$FFA1], a
    xor a, a
    ld [$D804], a
    ret

Jump_03A_4E35::
    ld a, [$D804]
    rst $00
    dw Jump_03A_4E47
    dw Func_03A_4E57
    dw Jump_03A_4E47
    dw Func_03A_4E57
    dw Jump_03A_4E47
    dw Func_03A_4E57
    dw Jump_03A_4E67

Jump_03A_4E47::
    ld hl, $C5E9
    ld [hl], $00
    inc hl
    ld [hl], $00
    inc hl
    ld [hl], $00
    ld hl, $D804
    inc [hl]
    ret

Func_03A_4E57::
    ld hl, $C5E9
    ld [hl], $D2
    inc hl
    ld [hl], $D2
    inc hl
    ld [hl], $E2
    ld hl, $D804
    inc [hl]
    ret

Jump_03A_4E67::
    call Func_03A_4E57
    ld a, $FF
    ld [$D802], a
    xor a, a
    ld [$D804], a
    ret

Jump_03A_4E74::
    ld a, [$D804]
    rst $00
    dw Jump_03A_4E80
    dw Jump_03A_4E96
    dw Jump_03A_4EA9
    dw Jump_03A_4EB9

Jump_03A_4E80::
    call Func_03A_4EC3
    ld a, [$D807]
    cp a, $04
    ret c
    xor a, a
    ld [$D806], a
    xor a, a
    ld [$D807], a
    ld hl, $D804
    inc [hl]
    ret

Jump_03A_4E96::
    ld hl, $D805
    inc [hl]
    ld a, [$D805]
    cp a, $0A
    ret nz
    ld hl, $D804
    inc [hl]
    xor a, a
    ld [$D805], a
    ret

Jump_03A_4EA9::
    ld hl, $C5E9
    ld [hl], $D2
    inc hl
    ld [hl], $D2
    inc hl
    ld [hl], $E2
    ld hl, $D804
    inc [hl]
    ret

Jump_03A_4EB9::
    ld a, $FF
    ld [$D802], a
    xor a, a
    ld [$D804], a
    ret

Func_03A_4EC3::
    ld hl, $D807
    inc [hl]
    ld b, $03
    ld c, $00
    ld hl, $C5E9

Jump_03A_4ECE::
    ld a, [hl]
    and a, $03
    add a, $01
    cp a, $04
    jr c, Jump_03A_4ED9
    ld a, $03

Jump_03A_4ED9::
    or a, c
    ld c, a
    ld a, [hl]
    and a, $0C
    add a, $04
    cp a, $0D
    jr c, Jump_03A_4EE6
    ld a, $0C

Jump_03A_4EE6::
    or a, c
    ld c, a
    ld a, [hl]
    and a, $30
    add a, $10
    cp a, $31
    jr c, Jump_03A_4EF3
    ld a, $30

Jump_03A_4EF3::
    or a, c
    ld c, a
    ld a, [hl]
    and a, $C0
    add a, $40
    cp a, $C1
    jr c, Jump_03A_4F00
    ld a, $C0

Jump_03A_4F00::
    or a, c
    ld [hl+], a
    dec b
    jr nz, Jump_03A_4ECE
    ret

Jump_03A_4F06::
    ld a, [$D804]
    rst $00
    dw Jump_03A_4F24
    dw Jump_03A_4F24
    dw Jump_03A_4F24
    dw Jump_03A_4F24
    dw Jump_03A_4F24
    dw Jump_03A_4F24
    dw Jump_03A_4F24
    dw Jump_03A_4F24
    dw Jump_03A_4F24
    dw Jump_03A_4F24
    dw Jump_03A_4F24
    dw Jump_03A_4F24
    dw Jump_03A_4F38

Jump_03A_4F24::
    ld hl, $C5E9
    ld a, [hl]
    xor a, $FF
    ld [hl+], a
    ld a, [hl]
    xor a, $FF
    ld [hl+], a
    ld a, [hl]
    xor a, $FF
    ld [hl], a
    ld hl, $D804
    inc [hl]
    ret

Jump_03A_4F38::
    ld a, $FF
    ld [$D802], a
    xor a, a
    ld [$D804], a
    ret

Jump_03A_4F42::
    ld a, [$D804]
    rst $00
    dw Jump_03A_4F54
    dw Jump_03A_4F6A
    dw Jump_03A_4F7D
    dw Jump_03A_4F54
    dw Jump_03A_4F6A
    dw Jump_03A_4F7D
    dw Jump_03A_4F8D

Jump_03A_4F54::
    call Func_03A_4EC3
    ld a, [$D807]
    cp a, $04
    ret c
    xor a, a
    ld [$D806], a
    xor a, a
    ld [$D807], a
    ld hl, $D804
    inc [hl]
    ret

Jump_03A_4F6A::
    ld hl, $D805
    inc [hl]
    ld a, [$D805]
    cp a, $05
    ret nz
    ld hl, $D804
    inc [hl]
    xor a, a
    ld [$D805], a
    ret

Jump_03A_4F7D::
    ld hl, $C5E9
    ld [hl], $D2
    inc hl
    ld [hl], $D2
    inc hl
    ld [hl], $E2
    ld hl, $D804
    inc [hl]
    ret

Jump_03A_4F8D::
    ld a, $FF
    ld [$D802], a
    xor a, a
    ld [$D804], a
    ret

Jump_03A_4F97::
    ld a, [$D804]
    or a, a
    call z, Func_03A_4FB4
    call Func_03A_5028
    ld a, [$D804]
    or a, a
    ret z
    ld a, $FF
    ld [$D802], a
    xor a, a
    ld [$D804], a
    xor a, a
    ld [$D805], a
    ret

Func_03A_4FB4::
    ld a, [$D804]
    or a, a
    ret nz
    ld a, [$D805]
    rst $00
    dw Jump_03A_4FF3
    dw Jump_03A_500D
    dw Jump_03A_5000
    dw Jump_03A_500D
    dw Jump_03A_4FF3
    dw Jump_03A_500D
    dw Jump_03A_5000
    dw Jump_03A_500D
    dw Jump_03A_4FF3
    dw Jump_03A_500D
    dw Jump_03A_5000
    dw Jump_03A_4FF3
    dw Jump_03A_500D
    dw Jump_03A_5000
    dw Jump_03A_500D
    dw Jump_03A_4FF3
    dw Jump_03A_500D
    dw Jump_03A_5000
    dw Jump_03A_500D
    dw Jump_03A_4FF3
    dw Jump_03A_500D
    dw Jump_03A_5000
    dw Jump_03A_500D
    dw Jump_03A_4FF3
    dw Jump_03A_500D
    dw Jump_03A_5000
    dw Jump_03A_5018

Jump_03A_4FF3::
    ld a, $04
    ldh [$FFA5], a
    ld a, $00
    ldh [$FFA1], a
    ld hl, $D805
    inc [hl]
    ret

Jump_03A_5000::
    ld a, $00
    ldh [$FFA5], a
    ld a, $03
    ldh [$FFA1], a
    ld hl, $D805
    inc [hl]
    ret

Jump_03A_500D::
    xor a, a
    ldh [$FFA5], a
    xor a, a
    ldh [$FFA1], a
    ld hl, $D805
    inc [hl]
    ret

Jump_03A_5018::
    ld a, $01
    ld [$D804], a
    xor a, a
    ldh [$FFA5], a
    xor a, a
    ldh [$FFA1], a
    xor a, a
    ld [$D805], a
    ret

Func_03A_5028::
    ld a, [$D805]
    rst $00
    dw Jump_03A_506E
    dw Jump_03A_506E
    dw Jump_03A_506E
    dw Jump_03A_506E
    dw Jump_03A_506E
    dw Jump_03A_506E
    dw Jump_03A_506E
    dw Jump_03A_506E
    dw Jump_03A_506E
    dw Jump_03A_5062
    dw Jump_03A_506E
    dw Jump_03A_5062
    dw Jump_03A_506E
    dw Jump_03A_5062
    dw Jump_03A_506E
    dw Jump_03A_5062
    dw Jump_03A_506E
    dw Jump_03A_5062
    dw Jump_03A_506E
    dw Jump_03A_5062
    dw Jump_03A_506E
    dw Jump_03A_5062
    dw Jump_03A_506E
    dw Jump_03A_5062
    dw Jump_03A_506E
    dw Jump_03A_5062
    dw Jump_03A_506E

Jump_03A_5062::
    ld hl, $C5E9
    ld [hl], $00
    inc hl
    ld [hl], $00
    inc hl
    ld [hl], $00
    ret

Jump_03A_506E::
    ld hl, $C5E9
    ld [hl], $D2
    inc hl
    ld [hl], $D2
    inc hl
    ld [hl], $E2
    ret

Jump_03A_507A::
    ld a, [$D807]
    or a, a
    jr nz, Jump_03A_5085
    ld hl, $D807
    inc [hl]
    ret

Jump_03A_5085::
    ld hl, $D807
    inc [hl]
    ret

Jump_03A_508A::
    ld a, [$D804]
    rst $00
    dw Jump_03A_5096
    dw Jump_03A_50AC
    dw Jump_03A_50BF
    dw Jump_03A_50CF

Jump_03A_5096::
    call Func_03A_50D9
    ld a, [$D807]
    cp a, $04
    ret c
    xor a, a
    ld [$D806], a
    xor a, a
    ld [$D807], a
    ld hl, $D804
    inc [hl]
    ret

Jump_03A_50AC::
    ld hl, $D805
    inc [hl]
    ld a, [$D805]
    cp a, $0A
    ret nz
    ld hl, $D804
    inc [hl]
    xor a, a
    ld [$D805], a
    ret

Jump_03A_50BF::
    ld hl, $C5E9
    ld [hl], $D2
    inc hl
    ld [hl], $D2
    inc hl
    ld [hl], $E2
    ld hl, $D804
    inc [hl]
    ret

Jump_03A_50CF::
    ld a, $FF
    ld [$D802], a
    xor a, a
    ld [$D804], a
    ret

Func_03A_50D9::
    ld hl, $D807
    inc [hl]
    ld b, $03
    ld c, $00
    ld hl, $C5E9

Jump_03A_50E4::
    ld a, [hl]
    and a, $03
    cp a, $00
    jr z, Jump_03A_50ED
    sub a, $01

Jump_03A_50ED::
    or a, c
    ld c, a
    ld a, [hl]
    and a, $0C
    cp a, $00
    jr z, Jump_03A_50F8
    sub a, $04

Jump_03A_50F8::
    or a, c
    ld c, a
    ld a, [hl]
    and a, $30
    cp a, $00
    jr z, Jump_03A_5103
    sub a, $10

Jump_03A_5103::
    or a, c
    ld c, a
    ld a, [hl]
    and a, $C0
    cp a, $00
    jr z, Jump_03A_510E
    sub a, $40

Jump_03A_510E::
    or a, c
    ld [hl+], a
    dec b
    jr nz, Jump_03A_50E4
    ret

Jump_03A_5114::
    ld a, [$D804]
    rst $00
    dw Jump_03A_4E47
    dw Func_03A_4E57
    dw Jump_03A_4E47
    dw Func_03A_4E57
    dw Jump_03A_4E47
    dw Func_03A_4E57
    dw Jump_03A_4E47
    dw Func_03A_4E57
    dw Jump_03A_4E47
    dw Func_03A_4E57
    dw Jump_03A_4E47
    dw Func_03A_4E57
    dw Jump_03A_4E47
    dw Func_03A_4E57
    dw Jump_03A_4E47
    dw Func_03A_4E57
    dw Jump_03A_4E67

Jump_03A_513A::
    ld a, [$D804]
    rst $00
    dw Jump_03A_5180
    dw Jump_03A_5176
    dw Jump_03A_5189
    dw Jump_03A_5176
    dw Jump_03A_5192
    dw Jump_03A_5176
    dw Jump_03A_519B
    dw Jump_03A_5176
    dw Jump_03A_51A4
    dw Jump_03A_5176
    dw Jump_03A_51AD
    dw Jump_03A_5176
    dw Jump_03A_51B6
    dw Jump_03A_5176
    dw Jump_03A_51C3
    dw Jump_03A_5176
    dw Jump_03A_51B6
    dw Jump_03A_5176
    dw Jump_03A_51C3
    dw Jump_03A_5176
    dw Jump_03A_51B6
    dw Jump_03A_5176
    dw Jump_03A_51C3
    dw Jump_03A_5176
    dw Jump_03A_51B6
    dw Jump_03A_5176
    dw Jump_03A_51C3
    dw Jump_03A_51D0

Jump_03A_5176::
    xor a, a
    ldh [$FFA1], a
    ldh [$FFA5], a
    ld hl, $D804
    inc [hl]
    ret

Jump_03A_5180::
    ld a, $FE
    ldh [$FFA1], a
    ld hl, $D804
    inc [hl]
    ret

Jump_03A_5189::
    ld a, $02
    ldh [$FFA1], a
    ld hl, $D804
    inc [hl]
    ret

Jump_03A_5192::
    ld a, $FC
    ldh [$FFA1], a
    ld hl, $D804
    inc [hl]
    ret

Jump_03A_519B::
    ld a, $04
    ldh [$FFA1], a
    ld hl, $D804
    inc [hl]
    ret

Jump_03A_51A4::
    ld a, $F8
    ldh [$FFA1], a
    ld hl, $D804
    inc [hl]
    ret

Jump_03A_51AD::
    ld a, $08
    ldh [$FFA1], a
    ld hl, $D804
    inc [hl]
    ret

Jump_03A_51B6::
    ld a, $F8
    ldh [$FFA1], a
    ld a, $02
    ldh [$FFA5], a
    ld hl, $D804
    inc [hl]
    ret

Jump_03A_51C3::
    ld a, $08
    ldh [$FFA1], a
    ld a, $02
    ldh [$FFA5], a
    ld hl, $D804
    inc [hl]
    ret

Jump_03A_51D0::
    xor a, a
    ldh [$FFA1], a
    ldh [$FFA5], a
    ld a, $FF
    ld [$D802], a
    xor a, a
    ld [$D804], a
    ret

Jump_03A_51DF::
    ld a, [$C57F]
    ld b, a
    ld a, [$C58A]
    ld c, a
    ld a, [$D8A4]
    cp a, $07
    jr nc, Jump_03A_5264
    cp a, $03
    jr z, Jump_03A_5264
    dec c
    jr nz, Jump_03A_51FB
    cp a, $04
    jr nc, Jump_03A_5264
    jr Jump_03A_51FF

Jump_03A_51FB::
    cp a, $04
    jr c, Jump_03A_5264

Jump_03A_51FF::
    ld a, [$D8A4]
    call Func_000_3E54
    jr c, Jump_03A_5264
    ld a, [$D804]
    rst $00
    dw Jump_03A_5215
    dw Jump_03A_523B
    dw Jump_03A_5215
    dw Jump_03A_523B
    dw Jump_03A_5264

Jump_03A_5215::
    ld a, $06
    ld [$D805], a
    call Func_03A_5272
    ld hl, Data_03A_4D52
    call Func_03A_4D47
    ld de, $9800
    add hl, de
    ld e, l
    ld d, h
    ld a, $03
    ld hl, Data_03A_4D5C
    call Func_03A_4D47
    ld c, $06
    call Func_03A_4D2B
    ld hl, $D804
    inc [hl]
    ret

Jump_03A_523B::
    ld a, $06
    ld [$D805], a
    call Func_03A_5272
    ld hl, Data_03A_4D52
    call Func_03A_4D47
    ld de, $9800
    add hl, de
    ld e, l
    ld d, h
    ld a, [$D8A4]
    and a, $03
    ld hl, Data_03A_4D5C
    call Func_03A_4D47
    ld c, $06
    call Func_03A_4D2B
    ld hl, $D804
    inc [hl]
    ret

Jump_03A_5264::
    ld a, $FF
    ld [$D802], a
    xor a, a
    ld [$D804], a
    xor a, a
    ld [$D805], a
    ret

Func_03A_5272::
    ld a, [$D890]
    cp a, $01
    jr z, Jump_03A_52A1
    cp a, $02
    jr z, Jump_03A_5290
    ld a, [$D8A4]
    and a, $03
    cp a, $01
    jr z, Jump_03A_52A1
    jr c, Jump_03A_528C
    ld a, $04
    jr Jump_03A_52A3

Jump_03A_528C::
    ld a, $03
    jr Jump_03A_52A3

Jump_03A_5290::
    ld a, [$D8A4]
    and a, $03
    cp a, $01
    jr z, Jump_03A_529D
    ld a, $01
    jr Jump_03A_52A3

Jump_03A_529D::
    ld a, $02
    jr Jump_03A_52A3

Jump_03A_52A1::
    ld a, $00

Jump_03A_52A3::
    ret

Func_03A_52A4::
    ld c, a
    ld b, $00
    ld hl, Data_03A_52B9
    add hl, bc
    add hl, bc
    add hl, bc
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld b, [hl]
    ld hl, $8000
    call Func_000_0CF5
    ret

Data_03A_52B9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0E92B9, $B4

Func_03A_536D::
    ld a, [$DAB9]
    cp a, $03
    ret nz
    ld a, [$D804]
    add a, $04
    ld [$D804], a
    cp a, $D0
    ret c
    xor a, a
    ld [$DAAA], a
    ret

Func_03A_5383::
    ld a, [$D801]
    cp a, $0E
    jr c, Jump_03A_539D
    cp a, $20
    jr c, Jump_03A_53A4
    cp a, $2D
    jr c, Jump_03A_53AB
    cp a, $33
    jr c, Jump_03A_53B2
    ld hl, Func_03A_4001
    ld b, $92
    rst $10
    ret

Jump_03A_539D::
    ld hl, Func_03A_4001
    ld b, $3E
    rst $10
    ret

Jump_03A_53A4::
    ld hl, Func_03A_4001
    ld b, $3F
    rst $10
    ret

Jump_03A_53AB::
    ld hl, Func_03A_4001
    ld b, $3D
    rst $10
    ret

Jump_03A_53B2::
    ld hl, $5059
    ld b, $3B
    rst $10
    ret

Func_03A_53B9::
    ld hl, $99CE
    ld a, l
    ld [$D868], a
    ld a, h
    ld [$D869], a
    ld hl, $99D2
    ld a, l
    ld [$D86A], a
    ld a, h
    ld [$D86B], a
    ld hl, Data_03A_40CC
    call Func_03A_540A
    ld hl, $99EE
    ld a, l
    ld [$D868], a
    ld a, h
    ld [$D869], a
    ld hl, $99F2
    ld a, l
    ld [$D86A], a
    ld a, h
    ld [$D86B], a
    ld hl, Data_03A_4294
    call Func_03A_540A
    ld hl, $9A0E
    ld a, l
    ld [$D868], a
    ld a, h
    ld [$D869], a
    ld hl, $9A12
    ld a, l
    ld [$D86A], a
    ld a, h
    ld [$D86B], a
    ld hl, Data_03A_445C

Func_03A_540A::
    ld a, [$C5F9]
    ld c, a
    ld b, $00
    add hl, bc
    add hl, bc
    inc hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_03A_5451
    push hl
    push af
    and a, $0F
    cp a, $0A
    jr nc, Jump_03A_5424
    add a, $E0
    jr Jump_03A_5426

Jump_03A_5424::
    sub a, $02

Jump_03A_5426::
    ld b, a
    ld a, [$D868]
    ld l, a
    ld a, [$D869]
    ld h, a
    ld a, b
    call Func_000_1211
    pop af
    swap a
    and a, $0F
    cp a, $0A
    jr nc, Jump_03A_5440
    add a, $E0
    jr Jump_03A_5442

Jump_03A_5440::
    sub a, $02

Jump_03A_5442::
    ld b, a
    ld a, [$D868]
    ld l, a
    ld a, [$D869]
    ld h, a
    dec hl
    ld a, b
    call Func_000_1211
    pop hl

Jump_03A_5451::
    dec hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_03A_548E
    push af
    and a, $0F
    cp a, $0A
    jr nc, Jump_03A_5462
    add a, $E0
    jr Jump_03A_5464

Jump_03A_5462::
    sub a, $02

Jump_03A_5464::
    ld b, a
    ld a, [$D86A]
    ld l, a
    ld a, [$D86B]
    ld h, a
    ld a, b
    call Func_000_1211
    pop af
    swap a
    and a, $0F
    cp a, $0A
    jr nc, Jump_03A_547E
    add a, $E0
    jr Jump_03A_5480

Jump_03A_547E::
    sub a, $02

Jump_03A_5480::
    ld b, a
    ld a, [$D86A]
    ld l, a
    ld a, [$D86B]
    ld h, a
    dec hl
    ld a, b
    call Func_000_1211

Jump_03A_548E::
    ret

Func_03A_548F::
    ld a, [$C5FE]
    ld [$D801], a
    ld [$DAB5], a
    ld a, $01
    ld [$DAB9], a
    xor a, a
    ld [$D804], a
    ld a, $FF
    ld hl, $D805
    ld bc, $0003
    call Func_000_0949
    ld a, $01
    ld [$D802], a
    ld a, $01
    ld [$D800], a
    ld a, $01
    ld [$DAAA], a
    ld a, $00
    ld [$DAB3], a
    ld hl, $DAB3
    ld a, l
    ld [$CB75], a
    ld a, h
    ld [$CB76], a
    ld hl, Func_03A_4001
    ld b, $32
    rst $10
    call Func_03A_4A3A
    ld a, [$D801]
    ld c, a
    call Func_03A_5516
    ret

Func_03A_54DC::
    ld a, [$D800]
    cp a, $01
    jr nz, Jump_03A_54F0
    ld a, [$D801]
    ld c, a
    call Func_03A_52A4
    ld a, $02
    ld [$D800], a
    ret

Jump_03A_54F0::
    ld hl, Func_03A_4001
    ld b, $32
    rst $10
    call Func_03A_536D
    ld a, [$DAB3]
    or a, a
    jr z, Jump_03A_5509
    ld a, [$DAAA]
    or a, a
    jr z, Jump_03A_5509
    call Func_03A_5383
    ret

Jump_03A_5509::
    xor a, a
    ld [$D800], a
    ld [$DAAA], a
    ld a, $FF
    ld [$D802], a
    ret

Func_03A_5516::
    ld a, [$C525]
    or a, a
    ret z
    ld l, c
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    ld bc, Data_03A_7D9A
    add hl, bc
    ld b, $08
    ld de, $C4DF

Jump_03A_552A::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_03A_552A
    ld a, $80
    ld [$C527], a
    ret

Func_03A_5536::
    ld a, [$C525]
    or a, a
    ret z
    ld hl, $D040
    ld a, [$C5E9]
    cp a, [hl]
    jp z, Jump_03A_564C
    ld c, $69

Jump_03A_5547::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_03A_5547
    ld a, $80
    ldh [$FF68], a
    ld hl, $C49F
    call Func_03A_55BB

Jump_03A_5557::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_03A_5557
    ld a, $88
    ldh [$FF68], a
    call Func_03A_55BB

Jump_03A_5564::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_03A_5564
    ld a, $90
    ldh [$FF68], a
    call Func_03A_55BB

Jump_03A_5571::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_03A_5571
    ld a, $98
    ldh [$FF68], a
    call Func_03A_55BB

Jump_03A_557E::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_03A_557E
    ld a, $A0
    ldh [$FF68], a
    call Func_03A_55BB

Jump_03A_558B::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_03A_558B
    ld a, $A8
    ldh [$FF68], a
    call Func_03A_55BB

Jump_03A_5598::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_03A_5598
    ld a, $B0
    ldh [$FF68], a
    call Func_03A_55BB

Jump_03A_55A5::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_03A_55A5
    ld a, $B8
    ldh [$FF68], a
    call Func_03A_55BB
    ld a, [$C5E9]
    ld [$D040], a
    jp Jump_03A_564C

Func_03A_55BB::
    push hl
    ld a, [$C5E9]
    and a, $03
    ld de, Data_03A_575E
    add a, e
    ld e, a
    jr nc, Jump_03A_55C9
    inc d

Jump_03A_55C9::
    ld a, [de]
    add a, l
    ld l, a
    jr nc, Jump_03A_55CF
    inc h

Jump_03A_55CF::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_03A_55CF
    ld a, [hl+]
    ldh [c], a
    ld a, [hl]
    ldh [c], a
    pop hl
    push hl
    ld a, [$C5E9]
    srl a
    srl a
    and a, $03
    ld de, Data_03A_575E
    add a, e
    ld e, a
    jr nc, Jump_03A_55EC
    inc d

Jump_03A_55EC::
    ld a, [de]
    add a, l
    ld l, a
    jr nc, Jump_03A_55F2
    inc h

Jump_03A_55F2::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_03A_55F2
    ld a, [hl+]
    ldh [c], a
    ld a, [hl]
    ldh [c], a
    pop hl
    push hl
    ld a, [$C5E9]
    swap a
    and a, $03
    ld de, Data_03A_575E
    add a, e
    ld e, a
    jr nc, Jump_03A_560D
    inc d

Jump_03A_560D::
    ld a, [de]
    add a, l
    ld l, a
    jr nc, Jump_03A_5613
    inc h

Jump_03A_5613::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_03A_5613
    ld a, [hl+]
    ldh [c], a
    ld a, [hl]
    ldh [c], a
    pop hl
    push hl
    ld a, [$C5E9]
    swap a
    srl a
    srl a
    and a, $03
    ld de, Data_03A_575E
    add a, e
    ld e, a
    jr nc, Jump_03A_5632
    inc d

Jump_03A_5632::
    ld a, [de]
    add a, l
    ld l, a
    jr nc, Jump_03A_5638
    inc h

Jump_03A_5638::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_03A_5638
    ld a, [hl+]
    ldh [c], a
    ld a, [hl]
    ldh [c], a
    pop hl
    ld a, l
    add a, $08
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ret

Jump_03A_564C::
    ld hl, $D041
    ld a, [$C5EA]
    cp a, [hl]
    jp z, Jump_03A_575D
    ld c, $6B

Jump_03A_5658::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_03A_5658
    ld a, $80
    ldh [$FF6A], a
    ld hl, $C4DF
    call Func_03A_56CC

Jump_03A_5668::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_03A_5668
    ld a, $88
    ldh [$FF6A], a
    call Func_03A_56CC

Jump_03A_5675::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_03A_5675
    ld a, $90
    ldh [$FF6A], a
    call Func_03A_56CC

Jump_03A_5682::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_03A_5682
    ld a, $98
    ldh [$FF6A], a
    call Func_03A_56CC

Jump_03A_568F::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_03A_568F
    ld a, $A0
    ldh [$FF6A], a
    call Func_03A_56CC

Jump_03A_569C::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_03A_569C
    ld a, $A8
    ldh [$FF6A], a
    call Func_03A_56CC

Jump_03A_56A9::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_03A_56A9
    ld a, $B0
    ldh [$FF6A], a
    call Func_03A_56CC

Jump_03A_56B6::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_03A_56B6
    ld a, $B8
    ldh [$FF6A], a
    call Func_03A_56CC
    ld a, [$C5EA]
    ld [$D041], a
    jp Jump_03A_575D

Func_03A_56CC::
    push hl
    ld a, [$C5EA]
    and a, $03
    ld de, Data_03A_575E
    add a, e
    ld e, a
    jr nc, Jump_03A_56DA
    inc d

Jump_03A_56DA::
    ld a, [de]
    add a, l
    ld l, a
    jr nc, Jump_03A_56E0
    inc h

Jump_03A_56E0::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_03A_56E0
    ld a, [hl+]
    ldh [c], a
    ld a, [hl]
    ldh [c], a
    pop hl
    push hl
    ld a, [$C5EA]
    srl a
    srl a
    and a, $03
    ld de, Data_03A_575E
    add a, e
    ld e, a
    jr nc, Jump_03A_56FD
    inc d

Jump_03A_56FD::
    ld a, [de]
    add a, l
    ld l, a
    jr nc, Jump_03A_5703
    inc h

Jump_03A_5703::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_03A_5703
    ld a, [hl+]
    ldh [c], a
    ld a, [hl]
    ldh [c], a
    pop hl
    push hl
    ld a, [$C5EA]
    swap a
    and a, $03
    ld de, Data_03A_575E
    add a, e
    ld e, a
    jr nc, Jump_03A_571E
    inc d

Jump_03A_571E::
    ld a, [de]
    add a, l
    ld l, a
    jr nc, Jump_03A_5724
    inc h

Jump_03A_5724::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_03A_5724
    ld a, [hl+]
    ldh [c], a
    ld a, [hl]
    ldh [c], a
    pop hl
    push hl
    ld a, [$C5EA]
    swap a
    srl a
    srl a
    and a, $03
    ld de, Data_03A_575E
    add a, e
    ld e, a
    jr nc, Jump_03A_5743
    inc d

Jump_03A_5743::
    ld a, [de]
    add a, l
    ld l, a
    jr nc, Jump_03A_5749
    inc h

Jump_03A_5749::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_03A_5749
    ld a, [hl+]
    ldh [c], a
    ld a, [hl]
    ldh [c], a
    pop hl
    ld a, l
    add a, $08
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ret

Jump_03A_575D::
    ret

Data_03A_575E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $02, $04, $00, $06

Func_03A_5762::
    ld a, [$DAD3]
    or a, a
    ret z
    bit 7, a
    jr nz, Jump_03A_5796
    bit 6, a
    jr nz, Jump_03A_579B
    bit 5, a
    jr nz, Jump_03A_57A0
    bit 3, a
    jr nz, Jump_03A_57B1
    bit 2, a
    jr nz, Jump_03A_578B
    bit 0, a
    jr nz, Jump_03A_5780
    ret

Jump_03A_5780::
    ld a, [$D8A5]
    ld [$D8A4], a
    ld hl, Data_03A_60B7
    jr Jump_03A_57B4

Jump_03A_578B::
    ld a, [$D8A5]
    ld [$D8A4], a
    ld hl, Data_03A_6107
    jr Jump_03A_57B4

Jump_03A_5796::
    ld hl, Data_03A_57F7
    jr Jump_03A_57B4

Jump_03A_579B::
    ld hl, Data_03A_59BF
    jr Jump_03A_57B4

Jump_03A_57A0::
    ld b, a
    call Func_03A_57CA
    ret nz
    ld hl, Data_03A_5B87
    bit 4, b
    jr nz, Jump_03A_57B4
    ld hl, Data_03A_5D4F
    jr Jump_03A_57B4

Jump_03A_57B1::
    ld hl, Data_03A_5F17

Jump_03A_57B4::
    ld a, [$D8A6]
    ld c, a
    ld b, $00
    add hl, bc
    add hl, bc
    call Func_03A_7C9A
    jr nc, Jump_03A_57C2
    inc hl

Jump_03A_57C2::
    ld a, [hl]
    cp a, $FF
    ret z
    call Func_000_1278
    ret

Func_03A_57CA::
    bit 4, a
    ret z
    ld a, [$D8A6]
    cp a, $15
    jr z, Jump_03A_57E2
    cp a, $20
    jr z, Jump_03A_57F1
    cp a, $7B
    jr z, Jump_03A_57F1
    cp a, $D6
    jr z, Jump_03A_57E2
    xor a, a
    ret

Jump_03A_57E2::
    ld hl, $D872
    ld a, [hl+]
    sub a, $E8
    ld a, [hl]
    sbc a, $03
    ld a, $81
    call Func_000_1278
    ret

Jump_03A_57F1::
    ld a, [$DAC0]
    bit 6, a
    ret

Data_03A_57F7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $80, $7C
    ds $27, $7A

Data_03A_5820:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $51, $7A
    INCBIN "dwm2-cobi-us.gbc", $0E9871, $BE
    ds $1C, $FF
    db $80, $7C, $FF, $FF, $FF, $FF, $7A, $FF, $7A
    ds $15, $FF
    INCBIN "dwm2-cobi-us.gbc", $0E9969, $56

Data_03A_59BF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $FF, $FF, $89, $FF, $8B, $FF, $8B, $FF, $8D, $FF, $8D, $FF, $8F, $FF, $90
    db $FF, $D9, $FF, $91, $FF, $93, $FF, $93, $FF, $94, $FF, $97, $FF, $97, $FF, $98
    db $FF, $95, $FF, $95, $FF, $96
    ds $55, $FF
    INCBIN "dwm2-cobi-us.gbc", $0E9A3A, $61
    ds $18, $FF

Data_03A_5AB3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $12, $FF
    db $B0, $B0
    ds $1B, $FF
    db $B6
    ds $12, $FF
    db $DC, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $BA
    ds $10, $FF

Data_03A_5B12:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $4E, $FF
    db $BC, $FF, $BD, $FF, $BF, $FF, $C1, $FF, $C3, $FF, $C5, $FF, $FF, $FF, $99, $FF
    db $99, $FF, $C7
    ds $12, $FF
    db $CB, $FF

Data_03A_5B87:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $26, $81
    db $B1, $B1, $B1, $B1, $B1, $B1
    ds $10, $85
    db $FF, $FF, $FF, $FF, $85, $85, $85, $85, $85, $85, $85, $85, $85, $85, $86, $86
    db $86, $86, $87, $87, $87, $87, $86, $86, $86, $86, $87, $87, $87, $87, $86, $86
    db $99, $99, $88, $88, $88, $88, $86, $FF, $86, $87, $87, $87, $FF, $88, $FF, $FF
    db $9B, $9B, $9B, $9B, $FF, $FF, $FF, $FF, $9A, $9A, $9A, $9A, $FF, $FF
    ds $56, $81
    db $FF, $FF
    ds $10, $81
    db $88, $88, $88, $88, $88, $88, $88, $88, $88, $88, $87, $87, $86, $87, $88, $88
    db $B1, $B1, $88, $88, $85, $85, $85, $85, $FF, $FF, $88, $99, $81, $81, $FF, $FF
    db $85, $85, $87, $87
    ds $10, $FF
    db $88, $88, $88, $88, $81, $81, $81, $81, $88, $88, $81, $81, $7A, $7A, $87, $87
    db $87, $87, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $9B, $9B, $85, $85, $FF, $FF, $FF, $FF, $85, $85
    ds $14, $FF
    INCBIN "dwm2-cobi-us.gbc", $0E9CDB, $4C
    ds $14, $81
    db $85, $85, $FF, $FF, $9A, $9A, $86, $86, $FF, $FF, $86, $87, $FF, $FF, $88, $88
    db $FF, $FF, $FF, $FF

Data_03A_5D4F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $84, $84
    ds $9E, $FF
    ds $30, $84
    db $FF, $FF
    ds $10, $84
    ds $72, $FF
    db $84, $84
    ds $1C, $FF
    db $84, $84, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $84, $84
    db $84, $84, $84, $84, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $82, $82
    db $FF, $FF, $FF, $FF, $FF, $FF, $84, $84, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $84, $84, $84, $84, $84, $84, $84, $84, $FF, $FF, $84, $84, $84, $84
    ds $16, $FF

Data_03A_5F17:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $BE, $FF
    db $88, $88, $88, $88, $88, $88
    ds $16, $FF
    db $81, $81, $FF, $FF, $81, $81, $81, $81
    ds $BE, $FF

Data_03A_60B7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $FF
    ds $18, $85
    ds $2A, $FF
    db $87, $FF, $86, $FF, $81, $FF, $81, $FF, $81, $FF, $81, $FF

Data_03A_6107:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $32, $FF
    db $85, $FF, $85, $FF, $85, $FF, $85, $FF, $88, $88, $85, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $93, $FF, $97, $FF, $96, $FF, $96, $FF

Func_03A_6157::
    ld a, [$C52B]
    or a, a
    ret nz
    call Func_03A_66A9
    ld a, [$D802]
    cp a, $FF
    jr z, Jump_03A_6172
    ld a, [$C58A]
    or a, a
    ret nz
    ld hl, Func_03A_4ADB
    ld b, $3A
    rst $10
    ret

Jump_03A_6172::
    ld a, [$CFCA]
    rst $00
    dw Jump_03A_618C
    dw Jump_03A_6193
    dw Jump_03A_619A
    dw Jump_03A_61AE
    dw Func_03A_61F8
    dw Jump_03A_6269
    dw Jump_03A_62A3
    dw Jump_03A_6300
    dw Jump_03A_6408
    dw Jump_03A_640F
    dw Jump_03A_6698

Jump_03A_618C::
    ld hl, $4ADC
    ld b, $32
    rst $10
    ret

Jump_03A_6193::
    ld hl, Func_03A_4001
    ld b, $36
    rst $10
    ret

Jump_03A_619A::
    ld a, [$D8A6]
    ld [$CFEC], a
    xor a, a
    ld [$CFED], a
    ld hl, Func_03A_4001
    ld b, $1A
    rst $10
    call Func_03A_69AA
    ret

Jump_03A_61AE::
    ld a, [$CFF2]
    cp a, $80
    jr z, Jump_03A_61CB
    and a, $0F
    cp a, $02
    jr z, Jump_03A_61CB
    cp a, $04
    jr z, Jump_03A_61D7
    ld a, [$D8A6]
    cp a, $63
    jr z, Jump_03A_61F4
    ld hl, $CFCA
    inc [hl]
    ret

Jump_03A_61CB::
    ld a, [$DAB2]
    or a, a
    jp z, Func_03A_6711
    ld hl, $CFCA
    inc [hl]
    ret

Jump_03A_61D7::
    ld a, [$D8A6]
    cp a, $64
    jr z, Jump_03A_61F4
    ld a, [$D8A4]
    ld hl, $D812
    call Func_000_3F25
    bit 0, [hl]
    jr nz, Jump_03A_61F0
    ld hl, $CFCA
    inc [hl]
    ret

Jump_03A_61F0::
    call Func_03A_6814
    ret

Jump_03A_61F4::
    call Func_03A_6846
    ret

Func_03A_61F8::
    ld a, [$D8A6]
    cp a, $4E
    jr z, Jump_03A_6211
    cp a, $4F
    jr z, Jump_03A_6211
    cp a, $B9
    jr z, Jump_03A_6230
    cp a, $15
    jr z, Jump_03A_624F
    cp a, $D6
    jr z, Jump_03A_6245
    jr Jump_03A_6264

Jump_03A_6211::
    ld a, [$DABA]
    or a, a
    jr z, Jump_03A_6264
    ld a, [$D8A4]
    ld hl, $D812
    call Func_000_3F25
    bit 0, [hl]
    jr z, Jump_03A_6264
    res 0, [hl]
    ld d, $81
    ld hl, Func_03A_7193
    ld b, $3A
    rst $10
    jr Jump_03A_6264

Jump_03A_6230::
    ld a, [$D8A4]
    ld hl, $D812
    call Func_000_3F25
    res 0, [hl]
    ld d, $86
    ld hl, Func_03A_7193
    ld b, $3A
    rst $10
    jr Jump_03A_6264

Jump_03A_6245::
    ld a, [$D8A4]
    ld [$C982], a
    xor a, a
    ld [$C983], a

Jump_03A_624F::
    ld a, $01
    ld [$CFCA], a
    ld a, $0E
    ld [$CFCB], a
    ld a, $00
    ld [$CFCC], a
    ld hl, $CFCF
    set 0, [hl]
    ret

Jump_03A_6264::
    ld hl, $CFCA
    inc [hl]
    ret

Jump_03A_6269::
    ld a, [$DAB2]
    or a, a
    jr z, Jump_03A_629F
    xor a, a
    ld [$DAB2], a
    ld a, $01
    ld [$C970], a
    ld a, [$D8A5]
    call Func_03A_7D6A
    jr c, Jump_03A_629F
    ld hl, $D812
    call Func_000_3F25
    bit 1, [hl]
    jr z, Jump_03A_629F
    ld hl, $CFC9
    inc [hl]
    xor a, a
    ld [$CFCA], a
    xor a, a
    ld [$CFCB], a
    ld d, $7E
    ld hl, Func_03A_7193
    ld b, $3A
    rst $10
    ret

Jump_03A_629F::
    ld hl, $CFCA
    inc [hl]

Jump_03A_62A3::
    ld a, [$D8A4]
    call Func_000_3E54
    jr c, Jump_03A_62FC
    ld hl, $D810
    call Func_000_3F25
    bit 6, [hl]
    jr z, Jump_03A_62FC
    res 6, [hl]
    ld a, [$CFF5]
    bit 4, a
    jr z, Jump_03A_62FC
    call Func_03A_639A
    jr nc, Jump_03A_62C5
    jr Jump_03A_62FC

Jump_03A_62C5::
    xor a, a
    ld [$DAD2], a
    ld a, $FF
    ld [$D802], a
    xor a, a
    ld [$DABA], a
    xor a, a
    ld [$DABF], a
    xor a, a
    ld [$DABD], a
    ld a, $FF
    ld [$DAD1], a
    xor a, a
    ld [$CFCA], a
    ld a, $01
    ld [$CFCB], a
    ld a, $04
    ld [$CFCC], a
    xor a, a
    ld [$DABA], a
    ld hl, Data_03A_4102
    ld b, $30
    rst $10
    ld a, d
    ld [$D8A5], a
    ret

Jump_03A_62FC::
    ld hl, $CFCA
    inc [hl]

Jump_03A_6300::
    xor a, a
    ld [$DABD], a
    xor a, a
    ld [$DABE], a
    xor a, a
    ld [$CFCF], a
    call Func_03A_639A
    jr nc, Jump_03A_6322
    ld hl, $CFC8
    inc [hl]
    xor a, a
    ld [$CFC9], a
    xor a, a
    ld [$CFCA], a
    xor a, a
    ld [$CFCB], a
    ret

Jump_03A_6322::
    ld a, [$D89E]
    ld hl, $D895
    add a, l
    ld l, a
    jr nc, Jump_03A_632D
    inc h

Jump_03A_632D::
    ld a, [hl]
    cp a, $10
    jr z, Jump_03A_635F
    ld a, [$D8A4]
    ld hl, $DA5B
    add a, l
    ld l, a
    jr nc, Jump_03A_633D
    inc h

Jump_03A_633D::
    ld [hl], $03
    push hl
    ld a, [$D8A4]
    ld hl, $DA1C
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_03A_634C
    inc h

Jump_03A_634C::
    ld a, [hl]
    cp a, $CC
    jr nz, Jump_03A_635E
    ld a, [$D8A4]
    ld hl, $D810
    call Func_000_3F25
    ld a, [hl]
    and a, $F3
    ld [hl], a

Jump_03A_635E::
    pop hl

Jump_03A_635F::
    ld a, [$D89E]
    inc a
    ld [$D89E], a
    cp a, $09
    jr nc, Jump_03A_6390
    ld a, [$D89E]
    ld hl, $D895
    add a, l
    ld l, a
    jr nc, Jump_03A_6375
    inc h

Jump_03A_6375::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_03A_6390
    cp a, $10
    jr z, Jump_03A_6383
    call Func_000_3E54
    jr c, Jump_03A_635F

Jump_03A_6383::
    xor a, a
    ld [$CFCA], a
    xor a, a
    ld [$CFCB], a
    xor a, a
    ld [$CFCC], a
    ret

Jump_03A_6390::
    ld a, $09
    ld [$CFCA], a
    xor a, a
    ld [$CFCB], a
    ret

Func_03A_639A::
    ld a, [$D8A6]
    cp a, $BD
    jr nz, Jump_03A_63AA
    ld a, [$DABA]
    and a, $7F
    jr z, Jump_03A_63AA
    xor a, a
    ret

Jump_03A_63AA::
    call Func_03A_63B2
    ret c
    call Func_03A_63D2
    ret

Func_03A_63B2::
    ld c, $00
    ld a, [$C58A]
    cp a, $01
    jr nz, Jump_03A_63C4
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_03A_63C4
    ld c, $04

Jump_03A_63C4::
    call Func_03A_63F7
    ret nc
    inc c
    call Func_03A_63F7
    ret nc
    inc c
    call Func_03A_63F7
    ret

Func_03A_63D2::
    ld c, $04
    ld a, [$C58A]
    cp a, $01
    jr nz, Jump_03A_63E6
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_03A_63C4
    ld c, $00
    jr Jump_03A_63C4

Jump_03A_63E6::
    ld a, c
    call Func_000_3E54
    ret nc
    inc c
    ld a, c
    call Func_000_3E54
    ret nc
    inc c
    ld a, c
    call Func_000_3E54
    ret

Func_03A_63F7::
    ld a, c
    call Func_000_3E54
    ret c
    ld a, c
    ld hl, $D80C
    call Func_000_3F25
    bit 6, [hl]
    ret z
    scf
    ret

Jump_03A_6408::
    ld hl, Data_03A_42F4
    ld b, $3B
    rst $10
    ret

Jump_03A_640F::
    ld a, [$CFCB]
    rst $00
    dw Jump_03A_6421
    dw Jump_03A_6480
    dw Jump_03A_64AF
    dw Jump_03A_6584
    dw Jump_03A_65A4
    dw Jump_03A_6665
    dw Jump_03A_6677

Jump_03A_6421::
    ld hl, $CFCB
    inc [hl]
    ld hl, $D80A
    ld a, [hl]
    and a, $AF
    ld [hl+], a
    ld a, [hl]
    and a, $AF
    ld [hl], a
    ld hl, $D864
    ld a, [hl]
    and a, $03
    ld [hl+], a
    ld a, [hl]
    and a, $03
    ld [hl], a
    ld b, $09
    ld hl, $D80C

Jump_03A_6440::
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    rrca
    and a, $55
    ld [hl+], a
    ld a, [hl]
    and a, $30
    jr z, Jump_03A_6458
    ld a, [hl]
    and a, $CF
    ld e, a
    ld a, [hl]
    rrca
    and a, $10
    or a, e
    ld [hl], a

Jump_03A_6458::
    inc hl
    ld a, [hl]
    and a, $C0
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld a, [hl]
    and a, $03
    jr z, Jump_03A_646E
    ld a, [hl]
    and a, $FC
    ld e, a
    ld a, [hl]
    rrca
    and a, $01
    or a, e
    ld [hl], a

Jump_03A_646E::
    inc hl
    dec b
    jr nz, Jump_03A_6440
    xor a, a
    ld [$D8A4], a
    call Func_000_3E54
    ret nc
    ld a, $04
    ld [$CFCB], a
    ret

Jump_03A_6480::
    ld hl, $CFCB
    inc [hl]
    ld a, [$D8A4]
    ld hl, $D811
    call Func_000_3F25
    ld a, [hl]
    and a, $3F
    ld d, a
    ld a, [hl]
    and a, $C0
    jr z, Jump_03A_64AE
    push hl
    push de
    sub a, $40
    jr nz, Jump_03A_64A5
    ld d, $84
    ld hl, Func_03A_7193
    ld b, $3A
    rst $10
    xor a, a

Jump_03A_64A5::
    pop de
    pop hl
    or a, d
    ld [hl], a
    ld a, $04
    ld [$CFCB], a

Jump_03A_64AE::
    ret

Jump_03A_64AF::
    ld hl, $CFCB
    inc [hl]
    ld hl, $CFCB
    inc [hl]
    ld a, [$D8A4]
    ld hl, $D80C
    call Func_000_3F25
    ld a, [hl]
    and a, $03
    ret z
    bit 0, a
    jr nz, Jump_03A_64D1
    ld b, $06
    ld a, $89
    ld [$D868], a
    jr Jump_03A_64D8

Jump_03A_64D1::
    ld b, $10
    ld a, $88
    ld [$D868], a

Jump_03A_64D8::
    ld a, [$D8A4]
    ld [$D8A5], a
    call Func_03A_64F8
    call Func_03A_6533
    ld a, [$D868]
    ld d, a
    ld hl, Func_03A_7193
    ld b, $3A
    rst $10
    ld a, [$D871]
    or a, a
    ret z
    ld hl, $CFCB
    dec [hl]
    ret

Func_03A_64F8::
    push bc
    ld a, [$D8A4]
    call Func_03A_7C66
    ld a, b
    call Func_000_16D1
    ld a, h
    or a, l
    jr nz, Jump_03A_650A
    ld hl, $0001

Jump_03A_650A::
    pop bc
    ld a, b
    cp a, $06
    jr z, Jump_03A_651E
    ld a, h
    or a, a
    jr nz, Jump_03A_6519
    ld a, l
    cp a, $32
    jr c, Jump_03A_652A

Jump_03A_6519::
    ld hl, $0032
    jr Jump_03A_652A

Jump_03A_651E::
    ld a, h
    or a, a
    jr nz, Jump_03A_6527
    ld a, l
    cp a, $96
    jr c, Jump_03A_652A

Jump_03A_6527::
    ld hl, $0096

Jump_03A_652A::
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    ret

Func_03A_6533::
    xor a, a
    ld [$D871], a
    ld a, [$D8A4]
    ld hl, $D8BF
    call Func_03A_7C93
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
    jr c, Jump_03A_655A
    ld a, d
    ld [hl-], a
    ld [hl], e
    or a, e
    jr nz, Jump_03A_657D
    inc hl

Jump_03A_655A::
    ld a, [hl-]
    ld b, a
    ld c, [hl]
    xor a, a
    ld [hl+], a
    ld [hl], a
    ld a, [$D8A4]
    call Func_03A_7D06
    ld a, [$D868]
    push af
    ld hl, Data_03A_5B12
    ld b, $32
    rst $10
    pop af
    ld [$D868], a
    xor a, a
    ld [$DABE], a
    ld a, $01
    ld [$D871], a

Jump_03A_657D::
    ld a, [$D8A4]
    call Func_03A_7CEC
    ret

Jump_03A_6584::
    ld hl, $CFCB
    inc [hl]
    ld hl, Data_03A_5AB3
    ld b, $32
    rst $10
    ld d, $90
    ld hl, Func_03A_7193
    ld b, $3A
    rst $10
    call Func_03A_639A
    ret nc
    ld a, $0A
    ld [$CFCA], a
    xor a, a
    ld [$CFCB], a
    ret

Jump_03A_65A4::
    ld hl, $D8A4
    inc [hl]
    ld a, [hl]
    cp a, $08
    jr z, Jump_03A_65B8
    call Func_000_3E54
    jr c, Jump_03A_65A4
    ld a, $01
    ld [$CFCB], a
    ret

Jump_03A_65B8::
    ld hl, $DA5B
    ld bc, $0008
    ld a, $FF
    call Func_000_0949
    ld b, $03
    ld c, $00
    ld d, $00
    call Func_03A_6650
    ld b, $01
    ld d, $01
    call Func_03A_6650
    ld b, $03
    ld c, $04
    ld d, $00
    ld a, [$C58A]
    cp a, $01
    jr z, Jump_03A_65E2
    ld d, $01

Jump_03A_65E2::
    call Func_03A_6650
    ld b, $01
    ld d, $01
    call Func_03A_6650
    ld hl, $D891
    ld a, [hl]
    cp a, $FF
    jr z, Jump_03A_65F5
    inc [hl]

Jump_03A_65F5::
    ld a, [$C58A]
    or a, a
    jr z, Jump_03A_6631
    cp a, $02
    jr z, Jump_03A_6631
    ld a, [$D043]
    or a, a
    jr z, Jump_03A_6631
    ld a, [$D04B]
    bit 7, a
    jr z, Jump_03A_6631
    res 7, a
    sub a, [hl]
    jr nc, Jump_03A_6619
    ld hl, $CFCB
    inc [hl]
    ld a, $62
    jr Jump_03A_663E

Jump_03A_6619::
    inc a
    ld c, a
    ld b, $00
    ld hl, $C130
    call Func_000_2F84
    ld hl, $C130
    ld a, [hl]
    cp a, $01
    ld a, $61
    jr nz, Jump_03A_662F
    ld a, $88

Jump_03A_662F::
    jr Jump_03A_663E

Jump_03A_6631::
    xor a, a
    ld [$CFC9], a
    xor a, a
    ld [$CFCA], a
    xor a, a
    ld [$CFCB], a
    ret

Jump_03A_663E::
    ld [$C529], a
    xor a, a
    ld [$C528], a
    ld hl, Func_03A_4001
    ld b, $2F
    rst $10
    ld hl, $CFCB
    inc [hl]
    ret

Func_03A_6650::
    ld a, c
    call Func_000_3E54
    jr c, Jump_03A_6660
    ld a, c
    ld hl, $DA5B
    add a, l
    ld l, a
    jr nc, Jump_03A_665F
    inc h

Jump_03A_665F::
    ld [hl], d

Jump_03A_6660::
    inc c
    dec b
    jr nz, Func_03A_6650
    ret

Jump_03A_6665::
    ld a, [$C52B]
    or a, a
    ret nz
    xor a, a
    ld [$CFC9], a
    xor a, a
    ld [$CFCA], a
    xor a, a
    ld [$CFCB], a
    ret

Jump_03A_6677::
    ld a, [$C52B]
    or a, a
    ret nz
    ld a, $02
    ld [$CFC8], a
    ld a, $08
    ld [$CFC9], a
    xor a, a
    ld [$CFCA], a
    ld [$CFCB], a
    ld a, $80
    ld [$D092], a
    ld a, $42
    call Func_000_122D
    ret

Jump_03A_6698::
    ld hl, $CFC8
    inc [hl]
    xor a, a
    ld [$CFC9], a
    xor a, a
    ld [$CFCA], a
    xor a, a
    ld [$CFCB], a
    ret

Func_03A_66A9::
    ld a, [$C58A]
    cp a, $01
    jr nz, Jump_03A_66B7
    ld a, [$C57F]
    bit 1, a
    jr nz, Jump_03A_66BF

Jump_03A_66B7::
    ld a, [$D88F]
    ld b, a
    ld c, $00
    jr Jump_03A_66C5

Jump_03A_66BF::
    ld a, [$D88F]
    ld b, a
    ld c, $04

Jump_03A_66C5::
    push bc
    ld a, c
    ld hl, $D095
    add a, l
    ld l, a
    jr nc, Jump_03A_66CF
    inc h

Jump_03A_66CF::
    bit 0, [hl]
    jr z, Jump_03A_66E3
    push hl
    ld hl, $7806
    ld b, $31
    rst $10
    ld hl, $7914
    ld b, $31
    rst $10
    pop hl
    res 0, [hl]

Jump_03A_66E3::
    bit 1, [hl]
    jr z, Jump_03A_66F7
    push hl
    ld hl, $785F
    ld b, $31
    rst $10
    ld hl, $7965
    ld b, $31
    rst $10
    pop hl
    res 1, [hl]

Jump_03A_66F7::
    bit 2, [hl]
    jr z, Jump_03A_670B
    push hl
    ld hl, Data_03A_76AE
    ld b, $31
    rst $10
    ld hl, $77B9
    ld b, $31
    rst $10
    pop hl
    res 2, [hl]

Jump_03A_670B::
    pop bc
    inc c
    dec b
    jr nz, Jump_03A_66C5
    ret

Func_03A_6711::
    call Func_03A_6731
    ret z
    ld a, c
    ld [$D8A5], a
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_03A_6725
    inc h

Jump_03A_6725::
    ld [hl], c
    ld a, $01
    ld [$CFCA], a
    ld a, $00
    ld [$CFCB], a
    ret

Func_03A_6731::
    ld a, [$DABA]
    bit 7, a
    jr nz, Jump_03A_6743
    call Func_03A_6785
    ld a, [$DABA]
    or a, $80
    ld [$DABA], a

Jump_03A_6743::
    call Func_03A_67D8
    ld a, [$DABA]
    and a, $7F
    ret nz
    ld a, [$D8A6]
    cp a, $15
    jr z, Jump_03A_676F
    cp a, $20
    jr z, Jump_03A_676F
    cp a, $7B
    jr z, Jump_03A_676F
    cp a, $D6
    jr z, Jump_03A_6765
    ld hl, $CFCA
    inc [hl]
    jr Jump_03A_6783

Jump_03A_6765::
    ld a, [$D8A4]
    ld [$C982], a
    xor a, a
    ld [$C983], a

Jump_03A_676F::
    ld a, $01
    ld [$CFCA], a
    ld a, $0E
    ld [$CFCB], a
    ld a, $00
    ld [$CFCC], a
    ld hl, $CFCF
    set 0, [hl]

Jump_03A_6783::
    xor a, a
    ret

Func_03A_6785::
    ld b, $04
    ld a, [$CFF2]
    cp a, $80
    jr nz, Jump_03A_6790
    ld b, $08

Jump_03A_6790::
    ld a, [$D8A5]
    and a, $04
    ld c, a

Jump_03A_6796::
    ld a, [$D8A5]
    cp a, c
    jr z, Jump_03A_67B9
    ld a, c
    call Func_000_3E54
    jr nc, Jump_03A_67B9
    jr z, Jump_03A_67BD
    ld a, [$D8A6]
    cp a, $20
    jr z, Jump_03A_67B9
    cp a, $7B
    jr z, Jump_03A_67B9
    cp a, $CE
    jr z, Jump_03A_67B9
    cp a, $BB
    jr z, Jump_03A_67B9
    jr Jump_03A_67BD

Jump_03A_67B9::
    ld hl, $DABA
    inc [hl]

Jump_03A_67BD::
    inc c
    dec b
    ld a, [$CFF2]
    cp a, $80
    jr nz, Jump_03A_67D3
    ld a, b
    cp a, $04
    jr nz, Jump_03A_67D3
    ld a, [$D8A5]
    and a, $04
    xor a, $04
    ld c, a

Jump_03A_67D3::
    ld a, b
    or a, a
    jr nz, Jump_03A_6796
    ret

Func_03A_67D8::
    ld a, [$D8A5]
    inc a
    ld c, a
    ld hl, $DABA
    dec [hl]
    ld a, [hl]
    and a, $7F
    ret z

Jump_03A_67E5::
    ld a, [$CFF2]
    cp a, $80
    jr nz, Jump_03A_67FB
    ld a, c
    and a, $03
    jr nz, Jump_03A_67FB
    ld a, [$D8A5]
    and a, $04
    xor a, $04
    ld c, a
    jr nz, Jump_03A_67FB

Jump_03A_67FB::
    ld a, c
    call Func_000_3E54
    ret nc
    jr z, Jump_03A_6811
    ld a, [$D8A6]
    cp a, $20
    ret z
    cp a, $7B
    ret z
    cp a, $CE
    ret z
    cp a, $BB
    ret z

Jump_03A_6811::
    inc c
    jr Jump_03A_67E5

Func_03A_6814::
    ld a, [$DABA]
    bit 7, a
    jp nz, Jump_03A_6877
    ld hl, $0001
    ld bc, $0004
    ld a, [$C58A]
    cp a, $01
    jr z, Jump_03A_6832
    ld a, [$D8A4]
    cp a, $04
    jr c, Jump_03A_6832
    ld c, $03

Jump_03A_6832::
    ld a, [$D8A6]
    cp a, $4E
    jr z, Jump_03A_683B
    sla c

Jump_03A_683B::
    call Func_000_3E98
    ld a, e
    or a, $80
    ld [$DABA], a
    jr Jump_03A_688F

Func_03A_6846::
    ld a, [$D8A4]
    call Func_000_3E54
    jr nc, Jump_03A_6855
    ld a, $80
    ld [$DABA], a
    jr Jump_03A_68A4

Jump_03A_6855::
    ld a, [$DABA]
    bit 7, a
    jp nz, Jump_03A_6877
    ld a, [$D8A6]
    cp a, $63
    ld a, $81
    jr z, Jump_03A_6868
    ld a, $83

Jump_03A_6868::
    ld [$DABA], a
    jr nz, Jump_03A_68A9
    ld a, [$D8A5]
    call Func_000_3E54
    jr nc, Jump_03A_6899
    jr Jump_03A_68A4

Jump_03A_6877::
    ld hl, $DABA
    dec [hl]
    ld a, [hl]
    and a, $7F
    jr z, Jump_03A_68A4
    ld a, [$D8A6]
    cp a, $63
    jr nz, Jump_03A_68A9
    ld a, [$D8A5]
    call Func_000_3E54
    jr nc, Jump_03A_6899

Jump_03A_688F::
    ld hl, Data_03A_4102
    ld b, $30
    rst $10
    ld a, d
    ld [$D8A5], a

Jump_03A_6899::
    ld a, $01
    ld [$CFCA], a
    ld a, $01
    ld [$CFCB], a
    ret

Jump_03A_68A4::
    ld hl, $CFCA
    inc [hl]
    ret

Jump_03A_68A9::
    ld a, [$D8A4]
    ld hl, $DAD8
    add a, l
    ld l, a
    jr nc, Jump_03A_68B4
    inc h

Jump_03A_68B4::
    push hl
    ld a, [hl]
    push af
    or a, $80
    ld [hl], a
    ld hl, Data_03A_4102
    ld b, $30
    rst $10
    ld a, d
    ld [$D8A5], a
    pop af
    pop hl
    ld [hl], a
    jr Jump_03A_6899

Func_03A_68C9::
    ld a, [$C52B]
    or a, a
    ret nz
    call Func_03A_66A9
    ld a, [$D802]
    cp a, $FF
    jr z, Jump_03A_68E4
    ld a, [$C58A]
    or a, a
    ret nz
    ld hl, Func_03A_4ADB
    ld b, $3A
    rst $10
    ret

Jump_03A_68E4::
    ld a, [$CFCA]
    rst $00
    dw Jump_03A_68F4
    dw Jump_03A_68FB
    dw Jump_03A_6902
    dw Jump_03A_6906
    dw Jump_03A_6944
    dw Jump_03A_6948

Jump_03A_68F4::
    ld hl, Data_03A_5820
    ld b, $32
    rst $10
    ret

Jump_03A_68FB::
    ld hl, Func_03A_4001
    ld b, $36
    rst $10
    ret

Jump_03A_6902::
    call Func_03A_69AA
    ret

Jump_03A_6906::
    ld a, [$CFF2]
    and a, $0F
    cp a, $02
    jr z, Jump_03A_691F
    cp a, $04
    jr z, Jump_03A_6923
    ld a, [$D8A6]
    cp a, $63
    jr z, Jump_03A_6940
    ld hl, $CFCA
    inc [hl]
    ret

Jump_03A_691F::
    call Func_03A_6711
    ret

Jump_03A_6923::
    ld a, [$D8A6]
    cp a, $64
    jr z, Jump_03A_6940
    ld a, [$D8A4]
    ld hl, $D812
    call Func_000_3F25
    bit 0, [hl]
    jr nz, Jump_03A_693C
    ld hl, $CFCA
    inc [hl]
    ret

Jump_03A_693C::
    call Func_03A_6814
    ret

Jump_03A_6940::
    call Func_03A_6846
    ret

Jump_03A_6944::
    call Func_03A_61F8
    ret

Jump_03A_6948::
    ld hl, $DAC9
    ld a, [hl+]
    ld [$D8A4], a
    ld a, [hl+]
    ld [$D8A5], a
    ld a, [hl+]
    ld [$DABA], a
    ld a, [$D8A4]
    ld de, $DA1C
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_03A_6963
    inc d

Jump_03A_6963::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    ld a, [$D8A5]
    ld de, $DA1C
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_03A_6974
    inc d

Jump_03A_6974::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    ld a, [$D8A5]
    ld de, $DA5B
    add a, e
    ld e, a
    jr nc, Jump_03A_6984
    inc d

Jump_03A_6984::
    ld a, [hl]
    ld [de], a
    xor a, a
    ld [$DABD], a
    ld hl, $CFC9
    dec [hl]
    ld a, $03
    ld [$CFCA], a
    xor a, a
    ld [$CFCB], a
    xor a, a
    ld [$CFCC], a
    ld a, [$C970]
    or a, a
    ret z
    xor a, a
    ld [$C970], a
    ld a, $06
    ld [$CFCA], a
    ret

Func_03A_69AA::
    ld a, [$CFCB]
    rst $00
    dw Jump_03A_69C2
    dw Jump_03A_6A60
    dw Jump_03A_6ABC
    dw Jump_03A_6AEC
    dw Jump_03A_6AFE
    dw Jump_03A_6BF1
    dw Jump_03A_6BF8
    dw Jump_03A_6C52
    dw Jump_03A_6C5E
    dw Jump_03A_6C76

Jump_03A_69C2::
    ld hl, $CFCB
    inc [hl]
    ld a, [$D8A5]
    ld hl, $D80E
    call Func_000_3F25
    bit 0, [hl]
    jp z, Jump_03A_6A60
    ld a, [$D8A5]
    call Func_000_3E54
    jp c, Jump_03A_6A60
    ld a, [$CFF5]
    bit 0, a
    jr z, Jump_03A_6A60
    ld a, [$DABD]
    bit 2, a
    jr z, Jump_03A_69F2
    ld a, [$DAC0]
    bit 4, a
    jr z, Jump_03A_6A60

Jump_03A_69F2::
    ld a, [$D8A5]
    call Func_03A_7C6B
    push hl
    ld a, [$D8A5]
    call Func_03A_7C75
    pop bc
    call Func_000_3E7A
    jr z, Jump_03A_6A60
    ld a, [$D872]
    ld e, a
    ld a, [$D873]
    ld d, a
    push de
    ld a, [$CFEE]
    ld e, a
    ld d, $00
    ld a, e
    ld [$D872], a
    ld a, d
    ld [$D873], a
    add hl, de
    call Func_000_3E7A
    jr c, Jump_03A_6A3A
    jr z, Jump_03A_6A3A
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    ld a, e
    sub a, l
    ld e, a
    ld a, d
    sbc a, h
    ld d, a
    ld a, e
    ld [$D872], a
    ld a, d
    ld [$D873], a
    ld h, b
    ld l, c

Jump_03A_6A3A::
    push hl
    ld a, [$D8A5]
    ld hl, $D8DF
    call Func_03A_7C93
    pop bc
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [$D8A5]
    call Func_03A_7CF9
    ld d, $40
    ld hl, Func_03A_7193
    ld b, $3A
    rst $10
    pop de
    ld a, e
    ld [$D872], a
    ld a, d
    ld [$D873], a
    ret

Jump_03A_6A60::
    ld hl, $CFCB
    inc [hl]
    ld a, [$D8A5]
    call Func_000_3E54
    jr c, Jump_03A_6AB6
    ld a, [$CFF5]
    bit 3, a
    jr z, Jump_03A_6AB6
    ld a, [$DAC0]
    bit 4, a
    jr z, Jump_03A_6AB6
    ld a, [$D8A5]
    ld hl, $D80C
    call Func_000_3F25
    ld a, [hl]
    and a, $90
    jr z, Jump_03A_6AB6
    push hl
    call Func_000_3ED4
    call Func_03A_6C7A
    pop hl
    jr nc, Jump_03A_6AB6
    bit 7, [hl]
    jr z, Jump_03A_6ABC
    ld a, [hl]
    and a, $73
    ld [hl], a
    ld a, [$D8A5]
    ld hl, $DA5B
    add a, l
    ld l, a
    jr nc, Jump_03A_6AA5
    inc h

Jump_03A_6AA5::
    ld [hl], $03
    ld a, [$D8A5]
    call Func_03A_7D06
    ld d, $82
    ld hl, Func_03A_7193
    ld b, $3A
    rst $10
    ret

Jump_03A_6AB6::
    ld hl, $CFCB
    inc [hl]
    jr Jump_03A_6AEC

Jump_03A_6ABC::
    ld hl, $CFCB
    inc [hl]
    ld a, [$D8A5]
    ld hl, $D80C
    call Func_000_3F25
    ld a, [hl]
    bit 4, [hl]
    jr z, Jump_03A_6AEC
    res 4, [hl]
    ld a, [$D8A5]
    ld hl, $DA5B
    add a, l
    ld l, a
    jr nc, Jump_03A_6ADB
    inc h

Jump_03A_6ADB::
    ld [hl], $03
    ld a, [$D8A5]
    call Func_03A_7D06
    ld d, $83
    ld hl, Func_03A_7193
    ld b, $3A
    rst $10
    ret

Jump_03A_6AEC::
    ld hl, $CFCB
    inc [hl]
    call Func_03A_639A
    jr nc, Jump_03A_6AFE
    ld hl, $CFCB
    inc [hl]
    ld hl, $CFCB
    inc [hl]
    ret

Jump_03A_6AFE::
    ld a, [$DABD]
    or a, a
    jp nz, Jump_03A_6BE8
    ld a, [$D8A5]
    ld hl, $D813
    call Func_000_3F25
    bit 2, [hl]
    jp z, Jump_03A_6BE8
    ld a, [$CFF3]
    bit 7, a
    jp z, Jump_03A_6BE8
    ld a, [$D8A4]
    call Func_000_3E54
    jp c, Jump_03A_6BE8
    ld a, [$D8A5]
    call Func_000_3E25
    jp c, Jump_03A_6BE8
    ld a, [$DAC0]
    bit 4, a
    jp z, Jump_03A_6BE8
    ld a, [$D8A5]
    ld hl, $D854
    call Func_03A_7C93
    ld a, [hl]
    and a, $08
    ld [$D868], a
    push hl
    ld a, [$D8A5]
    ld hl, $D813
    call Func_000_3F25
    bit 3, [hl]
    jr z, Jump_03A_6B66
    pop hl
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    add hl, hl
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    jr Jump_03A_6B7B

Jump_03A_6B66::
    pop hl
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

Jump_03A_6B7B::
    ld a, h
    or a, l
    jr z, Jump_03A_6B86
    ld a, $11
    ld [$DAD2], a
    jr Jump_03A_6B8B

Jump_03A_6B86::
    ld a, $10
    ld [$DAD2], a

Jump_03A_6B8B::
    ld hl, $D8A4
    ld a, [hl+]
    push af
    ld a, [hl-]
    ld [hl+], a
    pop af
    ld [hl], a
    ld a, [$DAD2]
    bit 0, a
    jr z, Jump_03A_6BB9
    ld a, [$D868]
    or a, a
    jr z, Jump_03A_6BAB
    ld d, $31
    ld hl, Func_03A_6EE5
    ld b, $3A
    rst $10
    jr Jump_03A_6BCF

Jump_03A_6BAB::
    call Func_000_3ED4
    ld a, [$C5E7]
    and a, $01
    jr nz, Jump_03A_6BB9
    ld d, $7C
    jr Jump_03A_6BBB

Jump_03A_6BB9::
    ld d, $7D

Jump_03A_6BBB::
    ld hl, Func_03A_7193
    ld b, $3A
    rst $10
    ld a, [$DAD2]
    bit 0, a
    jr z, Jump_03A_6BD8
    ld a, [$C5E7]
    and a, $01
    jr nz, Jump_03A_6BD8

Jump_03A_6BCF::
    ld hl, $CFCB
    inc [hl]
    xor a, a
    ld [$CFCC], a
    ret

Jump_03A_6BD8::
    ld a, [$D8A4]
    ld l, a
    ld a, [$D8A5]
    ld h, a
    ld a, l
    ld [$D8A5], a
    ld a, h
    ld [$D8A4], a

Jump_03A_6BE8::
    ld hl, $CFCB
    inc [hl]
    ld hl, $CFCB
    inc [hl]
    ret

Jump_03A_6BF1::
    ld hl, $6662
    ld b, $32
    rst $10
    ret

Jump_03A_6BF8::
    ld hl, $CFCB
    inc [hl]
    ld a, [$DAD1]
    cp a, $FF
    jr z, Jump_03A_6C17
    ld [$D8A5], a
    ld b, a
    ld a, [$D8A4]
    ld hl, $DA1D
    call Func_03A_7C93
    ld [hl], b
    ld a, $FF
    ld [$DAD1], a
    ret

Jump_03A_6C17::
    ld a, [$CFC9]
    cp a, $04
    jr z, Jump_03A_6C52
    ld a, [$DABD]
    or a, a
    jr z, Jump_03A_6C52
    xor a, a
    ld [$DABD], a
    ld hl, $DAC9
    ld a, [hl+]
    ld [$D8A4], a
    ld a, [hl+]
    ld [$D8A5], a
    ld a, [hl+]
    ld [$DABA], a
    ld a, [$D8A4]
    ld de, $DA1C
    call Func_03A_6C46
    ld a, [$D8A5]
    ld de, $DA1C

Func_03A_6C46::
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_03A_6C4C
    inc d

Jump_03A_6C4C::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    ret

Jump_03A_6C52::
    ld a, [$DABE]
    or a, a
    call nz, Func_03A_6C93
    ld hl, $CFCB
    inc [hl]
    ret

Jump_03A_6C5E::
    call Func_03A_639A
    jr c, Jump_03A_6C68
    ld hl, $CFCB
    inc [hl]
    ret

Jump_03A_6C68::
    xor a, a
    ld [$DABA], a
    ld a, $04
    ld [$CFCA], a
    xor a, a
    ld [$CFCB], a
    ret

Jump_03A_6C76::
    call Func_03A_6CD4
    ret

Func_03A_6C7A::
    ld a, [$C58A]
    cp a, $01
    jr z, Jump_03A_6C8C
    ld a, [$D8A5]
    cp a, $04
    jr c, Jump_03A_6C8C
    ld b, $40
    jr Jump_03A_6C8E

Jump_03A_6C8C::
    ld b, $80

Jump_03A_6C8E::
    ld a, [$C5E7]
    cp a, b
    ret

Func_03A_6C93::
    ld a, [$DABE]
    dec a
    rst $00
    dw Jump_03A_6CAC
    dw Jump_03A_6CB7
    dw Jump_03A_6CC2
    dw Jump_03A_6CC6
    dw Jump_03A_6CC6
    dw Jump_03A_6CC6
    dw Jump_03A_6CC6
    dw Jump_03A_6CC6
    dw Jump_03A_6CC7
    dw Jump_03A_6CC6

Jump_03A_6CAC::
    call Func_03A_7CB5
    ld d, $85
    jr c, Jump_03A_6CC9
    ld d, $E8
    jr Jump_03A_6CC9

Jump_03A_6CB7::
    call Func_03A_7CB5
    ld d, $80
    jr c, Jump_03A_6CC9
    ld d, $E7
    jr Jump_03A_6CC9

Jump_03A_6CC2::
    ld d, $AC
    jr Jump_03A_6CC9

Jump_03A_6CC6::
    ret

Jump_03A_6CC7::
    ld d, $7F

Jump_03A_6CC9::
    ld hl, Func_03A_7193
    ld b, $3A
    rst $10
    xor a, a
    ld [$DABE], a
    ret

Func_03A_6CD4::
    ld a, [$CFC9]
    cp a, $04
    jr z, Jump_03A_6D45
    ld a, [$DABD]
    or a, a
    jr nz, Jump_03A_6D39
    ld a, [$D8A5]
    call Func_03A_7D6A
    jr c, Jump_03A_6D45
    ld hl, $D812
    call Func_000_3F25
    bit 3, [hl]
    jr z, Jump_03A_6D45
    ld a, [$CFF5]
    bit 2, a
    jr z, Jump_03A_6D3D
    ld a, [$D8A6]
    cp a, $6C
    jr nz, Jump_03A_6D11
    ld a, [$D8A4]
    and a, $04
    ld l, a
    ld a, [$D8A5]
    and a, $04
    add a, l
    and a, $04
    jr z, Jump_03A_6D45

Jump_03A_6D11::
    ld a, [$C981]
    cp a, $01
    jr z, Jump_03A_6D45
    ld a, [$DAC0]
    bit 4, a
    jr z, Jump_03A_6D45
    ld d, $7A
    ld hl, Func_03A_7193
    ld b, $3A
    rst $10
    ld hl, $CFC9
    inc [hl]
    xor a, a
    ld [$CFCA], a
    xor a, a
    ld [$CFCB], a
    xor a, a
    ld [$CFCC], a
    xor a, a
    ret

Jump_03A_6D39::
    xor a, a
    ld [$DABD], a

Jump_03A_6D3D::
    ld d, $7B
    ld hl, Func_03A_7193
    ld b, $3A
    rst $10

Jump_03A_6D45::
    xor a, a
    ld [$C981], a
    ld hl, $CFCA
    inc [hl]
    xor a, a
    ld [$CFCB], a
    scf
    ret

Func_03A_6D53:: ; heuristic: follows a terminator; C0
    ld hl, $D895
    ld b, $08
    ld d, $00

Jump_03A_6D5A::
    bit 0, d
    jr nz, Jump_03A_6D64
    ld a, [hl]
    cp a, c
    jr nz, Jump_03A_6D71
    ld d, $01

Jump_03A_6D64::
    inc hl
    ld a, [hl]
    ld [hl], $FF
    dec hl
    ld [hl], a
    inc hl
    dec b
    jr nz, Jump_03A_6D5A
    ld [hl], $FF
    ret

Jump_03A_6D71::
    inc hl
    dec b
    jr nz, Jump_03A_6D5A
    ret

Func_03A_6D76::
    ld a, [$D8A6]
    ld hl, Data_03A_6DAA
    add a, l
    ld l, a
    jr nc, Jump_03A_6D81
    inc h

Jump_03A_6D81::
    ld a, [hl]
    cp a, $FF
    ret z
    ld d, a
    ld a, [$D8A6]
    cp a, $CF
    call z, Func_03A_6D91
    jp Func_03A_7193

Func_03A_6D91::
    call Func_000_3ED4
    ld a, [$C5E7]
    cp a, $80
    jr c, Jump_03A_6DA2
    xor a, a
    ld [$C96F], a
    ld d, $91
    ret

Jump_03A_6DA2::
    ld a, $01
    ld [$C96F], a
    ld d, $D6
    ret

Data_03A_6DAA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00
    ds $3C, $01
    INCBIN "dwm2-cobi-us.gbc", $0EADE7, $AB

Func_03A_6E92::
    ld a, [$D8A6]
    ld hl, Data_03A_6EA5
    add a, l
    ld l, a
    jr nc, Jump_03A_6E9D
    inc h

Jump_03A_6E9D::
    ld a, [hl]
    cp a, $FF
    ret z
    ld d, a
    jp Func_03A_7193

Data_03A_6EA5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $9F, $9F, $A2, $9F, $9F, $9F, $9F, $9F, $9F, $9F, $A1, $9F, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $94, $94, $94, $94, $94, $97, $99
    db $FF, $FF, $A5, $9B, $A4, $A3, $A6, $A7
    ds $10, $FF
    db $97, $FF, $FF, $FF, $0D, $A9, $28, $D6

Func_03A_6EE5::
    push de
    ld hl, Data_03A_6F06
    ld c, d
    ld b, $00
    add hl, bc
    add hl, bc
    ld a, [hl+]
    or a, [hl]
    jr z, Jump_03A_6EF6
    dec hl
    call Func_000_000B

Jump_03A_6EF6::
    pop af
    ld [$C529], a
    ld a, $00
    ld [$C528], a
    ld hl, Func_03A_4001
    ld b, $2F
    rst $10
    ret

Data_03A_6F06:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_03A_7106
    dw Data_03A_7106
    dw Data_03A_7107
    dw Data_03A_7108
    dw Data_03A_7108
    dw Data_03A_7109
    dw Data_03A_710A
    dw Data_03A_710B
    dw Data_03A_710C
    dw Data_03A_710C
    INCBIN "dwm2-cobi-us.gbc", $0EAF1A, $F0
    ds $FC, $00

Data_03A_7106:: ; heuristic: target of a monotone pointer table; C0
    db $C9

Data_03A_7107:: ; heuristic: target of a monotone pointer table; C0
    db $C9

Data_03A_7108:: ; heuristic: target of a monotone pointer table; C0
    db $C9

Data_03A_7109:: ; heuristic: target of a monotone pointer table; C0
    db $C9

Data_03A_710A:: ; heuristic: target of a monotone pointer table; C0
    db $C9

Data_03A_710B:: ; heuristic: target of a monotone pointer table; C0
    db $C9

Data_03A_710C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EB10C, $87

Func_03A_7193::
    push de
    ld hl, Data_03A_71B4
    ld c, d
    ld b, $00
    add hl, bc
    add hl, bc
    ld a, [hl+]
    or a, [hl]
    jr z, Jump_03A_71A4
    dec hl
    call Func_000_000B

Jump_03A_71A4::
    pop af
    ld [$C529], a
    ld a, $01
    ld [$C528], a
    ld hl, Func_03A_4001
    ld b, $2F
    rst $10
    ret

Data_03A_71B4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0EB1B4, $1C2
    dw Data_03A_73B4
    db $B4, $73
    dw Data_03A_73CB
    db $CB, $73
    dw Data_03A_73CB
    db $B8, $73
    dw Data_03A_73E0
    db $E0, $73
    dw Data_03A_73E0
    db $E0, $73
    dw Data_03A_74F7
    db $F7, $74
    dw Data_03A_74F7
    db $F7, $74
    dw Data_03A_74F7
    db $F7, $74
    dw Data_03A_74F7
    db $FE, $74
    dw Data_03A_74F7
    db $F7, $74
    dw Data_03A_74F7
    db $F7, $74
    dw Data_03A_74F7
    db $F7, $74
    dw Data_03A_74F7
    db $F7, $74, $00, $00, $00, $00, $BB, $74, $BB, $74, $00, $00

Data_03A_73B4:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $EE, $78, $C9, $FA, $A5, $D8, $FE, $03, $38, $0B, $CD, $E3, $7A, $78, $FE
    db $01, $20, $03, $CD, $27, $79, $C9

Data_03A_73CB:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $EE, $78, $CD, $1A, $79, $C9, $CD, $EE, $78, $CD, $34, $79, $C9, $CD, $27
    db $79, $CD, $4E, $79, $C9

Data_03A_73E0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EB3E0, $117

Data_03A_74F7:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $EE, $78, $CD, $08, $79, $C9, $CD, $41, $79, $CD, $EE, $78, $CD, $08, $79
    db $C9

Func_03A_7508::
    push de
    ld a, [$D8A6]
    cp a, $D0
    jr nc, Jump_03A_7532
    xor a, a
    ld [$C982], a
    call Func_03A_78EE
    call Func_03A_791A
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_03A_7526
    inc h

Jump_03A_7526::
    ld a, [hl]
    ld hl, $C150
    ld [$D86C], a
    call Func_03A_799C
    jr Jump_03A_753D

Jump_03A_7532::
    ld a, $01
    ld [$C982], a
    call Func_03A_78EE
    call Func_03A_7908

Jump_03A_753D::
    pop de
    ld a, d
    cp a, $03
    jp z, Jump_03A_7570
    cp a, $04
    jp z, Jump_03A_7594
    cp a, $05
    jp z, Jump_03A_7580
    cp a, $06
    jp z, Jump_03A_7584
    ld a, [$D8A6]
    ld hl, Data_03A_7603
    add a, l
    ld l, a
    jr nc, Jump_03A_755E
    inc h

Jump_03A_755E::
    ld a, [hl]
    ld hl, Data_03A_76E7
    dec d
    jr z, Jump_03A_7568
    ld hl, Data_03A_76FE

Jump_03A_7568::
    add a, l
    ld l, a
    jr nc, Jump_03A_756D
    inc h

Jump_03A_756D::
    ld a, [hl]
    jr Jump_03A_75A4

Jump_03A_7570::
    ld a, [$C982]
    bit 0, a
    jr nz, Jump_03A_757B
    ld a, $49
    jr Jump_03A_75A4

Jump_03A_757B::
    ld hl, Data_03A_75C7
    jr Jump_03A_75B7

Jump_03A_7580::
    ld a, $4A
    jr Jump_03A_75A4

Jump_03A_7584::
    ld a, [$C982]
    bit 0, a
    jr nz, Jump_03A_758F
    ld a, $4B
    jr Jump_03A_75A4

Jump_03A_758F::
    ld hl, Data_03A_75DB
    jr Jump_03A_75B7

Jump_03A_7594::
    ld a, [$C982]
    bit 0, a
    jr nz, Jump_03A_759F
    ld a, $4C
    jr Jump_03A_75A4

Jump_03A_759F::
    ld hl, Data_03A_75EF
    jr Jump_03A_75B7

Jump_03A_75A4::
    cp a, $FF
    jr z, Jump_03A_75B6
    ld [$C529], a
    ld a, $00
    ld [$C528], a
    ld hl, Func_03A_4001
    ld b, $2F
    rst $10

Jump_03A_75B6::
    ret

Jump_03A_75B7::
    ld a, [$D8A6]
    sub a, $D0
    add a, l
    ld l, a
    jr nc, Jump_03A_75C1
    inc h

Jump_03A_75C1::
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_03A_75A4
    ret

Data_03A_75C7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $6C, $6E, $FF, $FF, $FF, $FF, $70, $FF, $80, $72, $FF, $FF, $76, $FF, $FF, $78
    db $FF, $81, $FF, $FF

Data_03A_75DB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $74, $75, $FF, $FF, $82, $83
    db $FF, $7A, $FF, $FF

Data_03A_75EF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $6D, $6F, $FF, $FF, $FF, $FF, $71, $FF, $84, $73, $FF, $FF, $77, $FF, $FF, $79
    db $FF, $85, $FF, $FF

Data_03A_7603:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $3D, $00
    db $04, $04, $04, $01, $01, $01, $01, $01, $01, $01, $01, $04, $04, $11, $03, $10
    db $11, $06, $07
    ds $18, $03
    INCBIN "dwm2-cobi-us.gbc", $0EB66B, $43

Data_03A_76AE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $25, $00
    db $14, $14, $15, $15, $15, $15, $15, $15, $15, $16, $15, $15, $14, $15, $15, $15
    db $15, $15, $15, $15

Data_03A_76E7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $36, $37, $38, $46, $47, $39, $3A, $3B, $3C, $3D, $3E, $3F, $40, $41, $42, $43
    db $44, $45, $48, $FF, $69, $6A, $6B

Data_03A_76FE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $4D, $4F, $56, $4E, $50, $55, $51, $52, $54, $5F, $5A, $58, $5B, $59, $5C, $FF
    db $4D, $4E, $57, $53, $FF, $FF, $FF

Func_03A_7715::
    call Func_03A_78EE
    call Func_03A_7908
    ld a, [$D8A6]
    sub a, $D0
    ld hl, Data_03A_7738
    add a, l
    ld l, a
    jr nc, Jump_03A_7728
    inc h

Jump_03A_7728::
    ld a, [hl]
    ld [$C529], a
    ld a, $00
    ld [$C528], a
    ld hl, Func_03A_4001
    ld b, $2F
    rst $10
    ret

Data_03A_7738:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $66, $66, $67, $67, $67, $67, $67, $67, $67, $68, $67, $67, $66, $67, $67, $67
    db $67, $67, $67, $67

Func_03A_774C::
    ldh a, [$FFC6]
    ld b, a
    ld a, b
    cp a, $01
    jr z, Jump_03A_77CF
    xor a, a
    ld [$DAC4], a
    ld a, [$D8A5]
    bit 2, a
    ld hl, $C0A0
    jr z, Jump_03A_7765
    ld hl, $C0A8

Jump_03A_7765::
    ld a, b
    sub a, $01
    ld e, a
    ld d, $01

Jump_03A_776B::
    ld a, b
    sub a, d
    ld c, a
    push hl
    push de
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a

Jump_03A_7774::
    ld a, e
    cp a, [hl]
    inc hl
    jr nz, Jump_03A_7784
    ld a, d
    cp a, [hl]
    jr nz, Jump_03A_7784
    ld a, [$DAC4]
    inc a
    ld [$DAC4], a

Jump_03A_7784::
    inc hl
    dec c
    jr nz, Jump_03A_7774
    pop de
    pop hl
    inc d
    inc hl
    inc hl
    dec e
    jr nz, Jump_03A_776B
    ld a, b
    dec b
    ld c, b
    call Func_000_1682
    srl h
    rr l
    ld a, [$DAC4]
    cp a, l
    jr z, Jump_03A_77BE
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
    ret

Jump_03A_77BE::
    call Func_03A_7927
    jr Jump_03A_77CB

Func_03A_77C3:: ; heuristic: follows a terminator; C0
    ld a, e
    cp a, $01
    jr z, Jump_03A_77CF
    call Func_03A_795D

Jump_03A_77CB::
    call Func_03A_7B82
    ret

Jump_03A_77CF::
    call Func_03A_7927
    ret

Func_03A_77D3:: ; heuristic: follows a terminator; C0
    ldh a, [$FFC6]
    ld b, a
    ld a, b
    cp a, $01
    jr z, Jump_03A_7856
    xor a, a
    ld [$DAC4], a
    ld a, [$D8A5]
    bit 2, a
    ld hl, $C0A0
    jr z, Jump_03A_77EC
    ld hl, $C0A8

Jump_03A_77EC::
    ld a, b
    sub a, $01
    ld e, a
    ld d, $01

Jump_03A_77F2::
    ld a, b
    sub a, d
    ld c, a
    push hl
    push de
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a

Jump_03A_77FB::
    ld a, e
    cp a, [hl]
    inc hl
    jr nz, Jump_03A_780B
    ld a, d
    cp a, [hl]
    jr nz, Jump_03A_780B
    ld a, [$DAC4]
    inc a
    ld [$DAC4], a

Jump_03A_780B::
    inc hl
    dec c
    jr nz, Jump_03A_77FB
    pop de
    pop hl
    inc d
    inc hl
    inc hl
    dec e
    jr nz, Jump_03A_77F2
    ld a, b
    dec b
    ld c, b
    call Func_000_1682
    srl h
    rr l
    ld a, [$DAC4]
    cp a, l
    jr z, Jump_03A_7845
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
    ret

Jump_03A_7845::
    call Func_03A_7927
    jr Jump_03A_7852

Func_03A_784A:: ; heuristic: follows a terminator; C0
    ld a, e
    cp a, $01
    jr z, Jump_03A_7856
    call Func_03A_795D

Jump_03A_7852::
    call Func_03A_7B82
    ret

Jump_03A_7856::
    call Func_03A_7927
    ret

Func_03A_785A:: ; heuristic: follows a terminator; C0
    ldh a, [$FFC6]
    ld b, a
    ld a, b
    cp a, $01
    jp z, Jump_03A_78EA
    xor a, a
    ld [$DAC4], a
    ld a, [$D8A5]
    bit 2, a
    ld hl, $C0A0
    jr z, Jump_03A_7874
    ld hl, $C0A8

Jump_03A_7874::
    ld a, b
    sub a, $01
    ld e, a
    ld d, $01

Jump_03A_787A::
    ld a, b
    sub a, d
    ld c, a
    push hl
    push de
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a

Jump_03A_7883::
    ld a, e
    cp a, [hl]
    inc hl
    jr nz, Jump_03A_7893
    ld a, d
    cp a, [hl]
    jr nz, Jump_03A_7893
    ld a, [$DAC4]
    inc a
    ld [$DAC4], a

Jump_03A_7893::
    inc hl
    dec c
    jr nz, Jump_03A_7883
    pop de
    pop hl
    inc d
    inc hl
    inc hl
    dec e
    jr nz, Jump_03A_787A
    ld a, b
    dec b
    ld c, b
    call Func_000_1682
    srl h
    rr l
    ld a, [$DAC4]
    cp a, l
    jr z, Jump_03A_78D9
    ld hl, $C130
    ld [hl], $1D
    inc hl
    ld [hl], $2B
    inc hl
    ld [hl], $28
    inc hl
    ld [hl], $90
    inc hl
    ld [hl], $30
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
    ret

Jump_03A_78D9::
    call Func_03A_7927
    jr Jump_03A_78E6

Func_03A_78DE:: ; heuristic: follows a terminator; C0
    ld a, e
    cp a, $01
    jr z, Jump_03A_78EA
    call Func_03A_795D

Jump_03A_78E6::
    call Func_03A_7B82
    ret

Jump_03A_78EA::
    call Func_03A_7927
    ret

Func_03A_78EE::
    ld a, [$D8A4]
    ld hl, $C130
    ld [$D86C], a
    call Func_03A_799C
    ret

Func_03A_78FB:: ; heuristic: follows a terminator; C0
    ld a, [$D8A4]
    ld hl, $C140
    ld [$D86C], a
    call Func_03A_799C
    ret

Func_03A_7908::
    ld hl, Data_03A_414F
    ld b, $A3
    rst $10
    ldh a, [$FFC6]
    ld hl, $C140
    ld [$D86C], a
    call Func_03A_799C
    ret

Func_03A_791A::
    ld a, [$D8A6]
    ld l, a
    ld h, $04
    ld de, $C140
    call Func_000_2E81
    ret

Func_03A_7927::
    ld a, [$D8A5]
    ld hl, $C130
    ld [$D86C], a
    call Func_03A_799C
    ret

Func_03A_7934:: ; heuristic: follows a terminator; C0
    ld a, [$D8A5]
    ld hl, $C140
    ld [$D86C], a
    call Func_03A_799C
    ret

Func_03A_7941:: ; heuristic: follows a terminator; C0
    ld a, [$D8A5]
    ld hl, $C150
    ld [$D86C], a
    call Func_03A_799C
    ret
    db $21, $40, $C1, $FA, $72, $D8, $4F, $FA, $73, $D8, $47, $CD, $84, $2F, $C9

Func_03A_795D::
    ld a, [$D8A5]
    and a, $04
    ld hl, $C130
    ld [$D86C], a
    call Func_03A_799C
    ret

Func_03A_796C:: ; heuristic: follows a terminator; C0
    ld de, $C60C
    ld hl, $C130
    call Func_000_2FE1
    ret

Func_03A_7976:: ; heuristic: follows a terminator; C0
    ld de, $C60C
    ld hl, $C140
    call Func_000_2FE1
    ret

Func_03A_7980:: ; heuristic: follows a terminator; C0
    ld a, [$D8A6]
    ld l, a
    ld h, $05
    ld de, $C150
    call Func_000_2E81
    ret

Func_03A_798D:: ; heuristic: follows a terminator; C0
    ld a, [$D8A4]
    and a, $04
    ld hl, $C130
    ld [$D86C], a
    call Func_03A_799C
    ret

Func_03A_799C::
    cp a, $03
    jr nc, Jump_03A_79BB

Func_03A_79A0::
    push hl
    push bc
    ld e, $00
    call Func_000_3F32
    ld e, l
    ld d, h
    pop bc
    pop hl
    push hl
    call Func_000_2FE1
    pop hl

Jump_03A_79B0::
    ld a, [hl]
    cp a, $F0
    ret z
    inc hl
    jr Jump_03A_79B0

Jump_03A_79B7::
    ld a, b
    pop bc
    jr Func_03A_79A0

Jump_03A_79BB::
    push bc
    ld b, a
    and a, $03
    cp a, $03
    ld a, b
    pop bc
    jr z, Jump_03A_79E4
    push bc
    ld b, a
    ld a, [$C58A]
    cp a, $01
    jr z, Jump_03A_79B7
    push hl
    ld a, b
    and a, $03
    ld hl, $DAD4
    add a, l
    ld l, a
    jr nc, Jump_03A_79DA
    inc h

Jump_03A_79DA::
    ld a, [hl]
    pop hl
    cp a, $FF
    jr nz, Jump_03A_79E1
    ld a, b

Jump_03A_79E1::
    pop bc
    jr nz, Jump_03A_7A10

Jump_03A_79E4::
    push af
    call Func_03A_79ED
    pop af
    call Func_03A_7A6E
    ret

Func_03A_79ED::
    ld [$D87C], a
    push hl
    ld hl, $D958
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_03A_79FA
    inc h

Jump_03A_79FA::
    push bc
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    add a, $02
    ld h, a
    ld l, c
    pop bc
    pop de
    ld a, e
    ld [$D87A], a
    ld a, d
    ld [$D87B], a
    call Func_000_2E81
    ret

Jump_03A_7A10::
    call Func_03A_79A0
    ld a, $47
    ld [hl+], a
    ld [hl], $F0
    push hl
    ld hl, $DAD4
    ld a, [$D86C]
    and a, $03
    cp a, $01
    jr z, Jump_03A_7A33
    cp a, $02
    jr z, Jump_03A_7A3D
    ld a, [hl+]
    cp a, [hl]
    jr z, Jump_03A_7A59
    inc hl
    cp a, [hl]
    jr z, Jump_03A_7A59
    jr Jump_03A_7A68

Jump_03A_7A33::
    ld a, [hl+]
    cp a, [hl]
    jr z, Jump_03A_7A5E
    ld a, [hl+]
    cp a, [hl]
    jr z, Jump_03A_7A59
    jr Jump_03A_7A68

Jump_03A_7A3D::
    ld d, $00
    inc hl
    inc hl
    ld a, [hl-]
    dec hl
    cp a, [hl]
    jr nz, Jump_03A_7A47
    inc d

Jump_03A_7A47::
    inc hl
    cp a, [hl]
    jr nz, Jump_03A_7A4C
    inc d

Jump_03A_7A4C::
    ld a, d
    or a, a
    jr z, Jump_03A_7A68
    cp a, $01
    jr z, Jump_03A_7A5E
    pop hl
    ld a, $0C
    jr Jump_03A_7A61

Jump_03A_7A59::
    pop hl
    ld a, $0A
    jr Jump_03A_7A61

Jump_03A_7A5E::
    pop hl
    ld a, $0B

Jump_03A_7A61::
    ld [$D869], a
    ld [hl+], a
    ld [hl], $F0
    ret

Jump_03A_7A68::
    pop hl
    xor a, a
    ld [$D869], a
    ret

Func_03A_7A6E::
    call Func_03A_7AE3
    inc b
    ld c, $04
    xor a, a
    ld [$C0A0], a
    ld a, [$D87C]
    add a, a
    ld hl, $D958
    add a, l
    ld l, a
    jr nc, Jump_03A_7A84
    inc h

Jump_03A_7A84::
    ld a, [hl+]
    ld d, [hl]
    ld e, a

Jump_03A_7A87::
    ld a, c
    add a, a
    ld hl, $D958
    add a, l
    ld l, a
    jr nc, Jump_03A_7A91
    inc h

Jump_03A_7A91::
    ld a, [hl+]
    cp a, e
    jr nz, Jump_03A_7AA4
    ld a, [hl]
    cp a, d
    jr nz, Jump_03A_7AA4
    ld a, [$D87C]
    cp a, c
    jp z, Jump_03A_7AA9
    ld hl, $C0A0
    inc [hl]

Jump_03A_7AA4::
    inc c
    dec b
    jr nz, Jump_03A_7A87
    ret

Jump_03A_7AA9::
    ld a, [$C0A0]
    or a, a
    jr nz, Jump_03A_7AC7
    inc c

Jump_03A_7AB0::
    ld a, c
    add a, a
    ld hl, $D958
    add a, l
    ld l, a
    jr nc, Jump_03A_7ABA
    inc h

Jump_03A_7ABA::
    ld a, [hl+]
    cp a, e
    jr nz, Jump_03A_7AC2
    ld a, [hl]
    cp a, d
    jr z, Jump_03A_7AC7

Jump_03A_7AC2::
    inc c
    dec b
    jr nz, Jump_03A_7AB0
    ret

Jump_03A_7AC7::
    ld a, [$D87A]
    ld l, a
    ld a, [$D87B]
    ld h, a
    ld a, [$C0A0]
    add a, $0A
    push af

Jump_03A_7AD5::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_03A_7ADD
    inc hl
    jr Jump_03A_7AD5

Jump_03A_7ADD::
    pop af
    ld [hl+], a
    ld a, $F0
    ld [hl], a
    ret

Func_03A_7AE3::
    xor a, a
    ld hl, $C0A0
    ld bc, $0010
    call Func_000_0949
    ld de, $0000
    ld c, $00
    ld a, [$C58A]
    cp a, $01
    jr nz, Jump_03A_7B02
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_03A_7B02
    ld c, $04

Jump_03A_7B02::
    ld b, $03

Jump_03A_7B04::
    ld a, c
    call Func_000_3E54
    jr c, Jump_03A_7B26
    ld a, e
    add a, a
    ld hl, $C0A0
    add a, l
    ld l, a
    jr nc, Jump_03A_7B14
    inc h

Jump_03A_7B14::
    push de
    ld a, c
    add a, a
    ld de, $D958
    add a, e
    ld e, a
    jr nc, Jump_03A_7B1F
    inc d

Jump_03A_7B1F::
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    pop de
    inc e

Jump_03A_7B26::
    inc c
    dec b
    jr nz, Jump_03A_7B04
    ld c, $04
    ld a, [$C58A]
    cp a, $01
    jr nz, Jump_03A_7B3C
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_03A_7B3C
    ld c, $00

Jump_03A_7B3C::
    ld b, $03

Jump_03A_7B3E::
    ld a, c
    call Func_000_3E54
    jr c, Jump_03A_7B60
    ld a, d
    add a, a
    ld hl, $C0A8
    add a, l
    ld l, a
    jr nc, Jump_03A_7B4E
    inc h

Jump_03A_7B4E::
    push de
    ld a, c
    add a, a
    ld de, $D958
    add a, e
    ld e, a
    jr nc, Jump_03A_7B59
    inc d

Jump_03A_7B59::
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl], a
    pop de
    inc d

Jump_03A_7B60::
    inc c
    dec b
    jr nz, Jump_03A_7B3E
    ld b, d
    ret

Func_03A_7B66:: ; heuristic: follows a terminator; C0
    ld a, [$C58A]
    cp a, $01
    jr z, Jump_03A_7B77
    ld a, [$D8A5]
    cp a, $04
    jr c, Jump_03A_7B77

Jump_03A_7B74::
    ld d, $47
    ret

Jump_03A_7B77::
    call Func_03A_7AE3
    ld a, e
    cp a, $01
    jr z, Jump_03A_7B74
    ld d, $46
    ret

Func_03A_7B82::
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
    ret

Func_03A_7BA0::
    ld a, $FF
    ld hl, $D86D
    ld bc, $0003
    call Func_000_0949
    ld a, [$C58A]
    cp a, $01
    jr z, Jump_03A_7BB6
    ld c, $04
    jr Jump_03A_7BC0

Jump_03A_7BB6::
    ld a, [$C57F]
    sla a
    and a, $04
    xor a, $04
    ld c, a

Jump_03A_7BC0::
    ld b, $03
    ld e, $00

Jump_03A_7BC4::
    ld a, c
    call Func_000_3E54
    jr z, Jump_03A_7BDC
    jr nc, Jump_03A_7BD2
    ld a, [$D869]
    or a, a
    jr z, Jump_03A_7BDC

Jump_03A_7BD2::
    ld a, e
    ld hl, $D86D
    add a, l
    ld l, a
    jr nc, Jump_03A_7BDB
    inc h

Jump_03A_7BDB::
    ld [hl], c

Jump_03A_7BDC::
    inc e
    inc c
    dec b
    jr nz, Jump_03A_7BC4
    ld a, [$D86D]
    ld hl, $8ED0
    call Func_03A_7BF9
    ld hl, $8F70
    ld a, [$D86E]
    call Func_03A_7BF9
    ld hl, $9010
    ld a, [$D86F]

Func_03A_7BF9::
    cp a, $FF
    jr z, Jump_03A_7C14
    push hl
    ld hl, $C130
    ld [$D86C], a
    call Func_03A_799C
    ld a, $08
    ld [$C528], a
    ld a, $05
    ld [$C529], a
    pop hl
    jr Jump_03A_7C1E

Jump_03A_7C14::
    ld a, $02
    ld [$C528], a
    ld a, $00
    ld [$C529], a

Jump_03A_7C1E::
    ld de, $0A01
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
    db $21, $FF, $D8, $18, $28, $21, $0F, $D9, $18, $23

Func_03A_7C66::
    ld hl, $D8CF
    jr Jump_03A_7C89

Func_03A_7C6B::
    ld hl, $D8EF
    jr Jump_03A_7C89
    db $21, $BF, $D8, $18, $14

Func_03A_7C75::
    ld hl, $D8DF
    jr Jump_03A_7C89
    db $21, $1F, $D9, $18, $0A, $21, $53, $DA, $85, $6F, $30, $01, $24, $7E, $C9

Jump_03A_7C89::
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_03A_7C8F
    inc h

Jump_03A_7C8F::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ret

Func_03A_7C93::
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_03A_7C99
    inc h

Jump_03A_7C99::
    ret

Func_03A_7C9A::
    ld a, [$C58A]
    cp a, $01
    jr nz, Jump_03A_7CAF
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_03A_7CAF
    ld a, [$D8A4]
    cp a, $04
    ccf
    ret

Jump_03A_7CAF::
    ld a, [$D8A4]
    cp a, $04
    ret

Func_03A_7CB5::
    ld a, [$C58A]
    cp a, $01
    jr nz, Jump_03A_7CCA
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_03A_7CCA
    ld a, [$D8A5]
    cp a, $04
    ccf
    ret

Jump_03A_7CCA::
    ld a, [$D8A5]
    cp a, $04
    ret
    db $7A, $21, $E5, $7C, $85, $6F, $30, $01, $24, $56, $7B, $21, $0C, $D8, $CD, $25
    db $3F, $7A, $A6, $77, $C9, $DF, $FE, $00, $FD, $73, $EF, $BF

Func_03A_7CEC::
    push hl
    ld hl, $D095
    add a, l
    ld l, a
    jr nc, Jump_03A_7CF5
    inc h

Jump_03A_7CF5::
    set 0, [hl]
    pop hl
    ret

Func_03A_7CF9::
    push hl
    ld hl, $D095
    add a, l
    ld l, a
    jr nc, Jump_03A_7D02
    inc h

Jump_03A_7D02::
    set 1, [hl]
    pop hl
    ret

Func_03A_7D06::
    push hl
    ld hl, $D095
    add a, l
    ld l, a
    jr nc, Jump_03A_7D0F
    inc h

Jump_03A_7D0F::
    set 2, [hl]
    pop hl
    ret

Func_03A_7D13:: ; heuristic: follows a terminator; C0
    push hl
    push bc
    ld c, a
    ld b, $00
    ld hl, $D968
    add a, l
    ld l, a
    jr nc, Jump_03A_7D20
    inc h

Jump_03A_7D20::
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_03A_7D2F
    ld l, $09
    cp a, $40
    jr nc, Jump_03A_7D2F
    ld l, $12

Jump_03A_7D2F::
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, $D970
    add a, l
    ld l, a
    jr nc, Jump_03A_7D3B
    inc h

Jump_03A_7D3B::
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_03A_7D4A
    ld l, $03
    cp a, $40
    jr nc, Jump_03A_7D4A
    ld l, $06

Jump_03A_7D4A::
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, $D978
    add a, l
    ld l, a
    jr nc, Jump_03A_7D56
    inc h

Jump_03A_7D56::
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_03A_7D65
    ld l, $01
    cp a, $40
    jr nc, Jump_03A_7D65
    ld l, $02

Jump_03A_7D65::
    ld a, l
    add a, b
    pop bc
    pop hl
    ret

Func_03A_7D6A::
    call Func_000_3E25
    ret c
    push hl
    push bc
    ld c, a
    ld hl, $D80F
    call Func_000_3F25
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_03A_7D84
    ld a, [hl]
    and a, $0C
    jr nz, Jump_03A_7D84
    xor a, a
    jr Jump_03A_7D85

Jump_03A_7D84::
    scf

Jump_03A_7D85::
    ld a, c
    pop bc
    pop hl
    ret

Func_03A_7D89:: ; heuristic: follows a terminator; C0
    push hl
    ld hl, $D80F
    call Func_000_3F25
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_03A_7D98
    ld a, [hl]
    and a, $0C

Jump_03A_7D98::
    pop hl
    ret

Data_03A_7D9A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0EBD9A, $1DF
    ds $87, $00
