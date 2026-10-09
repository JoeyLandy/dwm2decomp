SECTION "Bank F2", ROMX[$4000], BANK[$F2]
    db $F2

Func_0F2_4001::
    ld hl, wD780
    ld bc, $006F

Jump_0F2_4007::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_0F2_4007
    xor a, a
    ld [wC8C3], a
    ld [wC8C4], a

Jump_0F2_4013::
    ld hl, Func_002_717D
    ld b, $02
    rst $10
    ld a, [wC8C3]
    bit 7, a
    jr z, Jump_0F2_4013
    ld b, $46
    ld de, Func_0F2_4001
    ld hl, vTiles1
    call Func_000_0CF5
    ld hl, Func_0F1_4AA8
    ld b, $F1
    rst $10
    xor a, a
    ldh [hFFA5], a
    ldh [hFFA1], a
    call Func_0F2_434E
    ld bc, $140D
    ld de, $01CC
    call Func_0F2_436F
    ld hl, Func_01B_53AF
    ld b, $1B
    rst $10
    ld hl, Func_002_5F9B
    ld b, $02
    rst $10
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call Func_000_290E
    ld a, $01
    ld [wC8CB], a
    ld a, $00
    ld [wC8CC], a
    ld a, $00
    ldh [hFFB9], a

Jump_0F2_4075::
    ld hl, Func_002_69D0
    ld b, $02
    rst $10
    ld a, [wC8CB]
    and a, $03
    jr nz, Jump_0F2_4075
    ld a, $FC
    call Func_000_0DF2
    ld hl, vTiles1
    ld de, $1202
    call Func_000_2E98
    xor a, a
    ld [wCB7D], a
    ld a, $02
    ldh [hFFB9], a
    ld a, $03
    ld [wC5EC], a
    ld a, $01
    jp Jump_000_077A

Func_0F2_40A2::
    ld a, [wC56C]
    and a, a
    ret nz
    ld a, [wD782]
    and a, a
    jr z, Jump_0F2_40B0
    call Func_0F2_43C3

Jump_0F2_40B0::
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, [wD782]
    rst $00
    dw Jump_0F2_40D5
    dw Jump_0F2_40E0
    dw Jump_0F2_40F6
    dw Jump_0F2_40E0
    dw Jump_0F2_411C
    dw Jump_0F2_412E
    dw Jump_0F2_40E0
    dw Jump_0F2_40E0
    dw Jump_0F2_414F
    dw Jump_0F2_40E0
    dw Jump_0F2_40E0
    dw Jump_0F2_415F
    dw Jump_0F2_4185
    dw Jump_0F2_41C8

Jump_0F2_40D5::
    call Func_0F2_4248
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_0F2_40E0::
    ld a, [wD783]
    inc a
    ld [wD783], a
    cp a, $10
    ret c
    xor a, a
    ld [wD783], a
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_0F2_40F6::
    ld a, [wCB98]
    and a, $03
    and a, a
    ret z
    ld a, [wCB9A]
    dec a
    ld [wCB9A], a
    cp a, $59
    ret nc
    ld a, $58
    ld [wCB9A], a
    ld a, [wCB9C]
    set 1, a
    ld [wCB9C], a
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_0F2_411C::
    ld a, $80
    ld [wCBCF], a
    ld a, $01
    ld [wD7F1], a
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_0F2_412E::
    ld a, [wCB88]
    and a, $03
    and a, a
    ret z
    ld a, [wCB8A]
    inc a
    ld [wCB8A], a
    cp a, $38
    ret nz
    ld a, [wCB8C]
    set 1, a
    ld [wCB8C], a
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_0F2_414F::
    ld a, $00
    ld [wCBCF], a
    ld [wD7F1], a
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_0F2_415F::
    ld a, [wCB8C]
    res 1, a
    ld [wCB8C], a
    ld a, $03
    ld [wCB86], a
    ld a, [wCB88]
    and a, $03
    and a, a
    ret z
    ld a, [wCB8A]
    dec a
    ld [wCB8A], a
    cp a, $E0
    ret nz
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_0F2_4185::
    ld hl, wC60C
    ld de, wC130
    ld c, $0A
    call Func_0F2_41BA
    ld de, wCADB
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    call Func_0F2_41CC
    ld hl, wC8CF
    ld de, wC140
    ld c, $10
    call Func_0F2_41BA
    ld a, $0E
    ld [wC529], a
    xor a, a
    ld [wC528], a
    ld hl, Func_0F0_48A0
    ld b, $F0
    rst $10
    ld hl, wD782
    inc [hl]
    ret

Func_0F2_41BA::
    ld a, [hl+]
    cp a, $F0
    jr z, Jump_0F2_41C4
    ld [de], a
    inc de
    dec c
    jr nz, Func_0F2_41BA

Jump_0F2_41C4::
    ld a, $F0
    ld [de], a
    ret

Jump_0F2_41C8::
    call Func_0F2_4227
    ret

Func_0F2_41CC::
    push hl
    ld a, [wDataBank]
    push af
    ld a, $08
    ld [wDataBank], a
    ld hl, Data_008_4032
    ld a, $04
    add a, l
    ld l, a
    jr nc, Jump_0F2_41E0
    inc h

Jump_0F2_41E0::
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
    ld [wDataBank], a
    ld hl, wC8CF
    ld b, $08
    ld c, $10
    call Func_000_0B2B
    ret

Func_0F2_4202:: ; heuristic: follows a terminator; C0
    ld hl, vTiles1
    ld de, $1202
    call Func_000_2E98
    ld a, $01
    ld [wC8CB], a
    ld a, $00
    ld [wC8CC], a
    ld a, $02
    ldh [hFFB9], a

Jump_0F2_4219::
    ld hl, Func_002_69D0
    ld b, $02
    rst $10
    ld a, [wC8CB]
    and a, $03
    jr nz, Jump_0F2_4219
    ret

Func_0F2_4227::
    ld hl, wD780
    ld bc, $006F

Jump_0F2_422D::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_0F2_422D
    xor a, a
    ld [wC94B], a
    ld a, $05
    ld [wC5DB], a
    ld a, $01
    ld [wC5DC], a
    ld a, $01
    ld [wC5DF], a
    ret

Func_0F2_4248::
    ld de, $0000
    call Func_000_181B
    jr c, Jump_0F2_4255
    ld hl, Data_0F2_42FE
    jr Jump_0F2_4258

Jump_0F2_4255::
    ld hl, Data_0F2_430E

Jump_0F2_4258::
    ld de, wCB7F
    ld b, $10
    call Func_0F2_42D9
    ld a, [wC5C7]
    and a, a
    jr nz, Jump_0F2_426B
    ld hl, Data_0F2_431E
    jr Jump_0F2_426E

Jump_0F2_426B::
    ld hl, Data_0F2_432E

Jump_0F2_426E::
    ld de, wCB8F
    ld b, $10
    call Func_0F2_42D9
    ld de, $0000
    call Func_000_181B
    jr c, Jump_0F2_4283
    ld hl, Data_0F2_42E0
    jr Jump_0F2_4286

Jump_0F2_4283::
    ld hl, Data_0F2_42E6

Jump_0F2_4286::
    ld de, hFFC6
    ld b, $06
    call Func_0F2_42D9
    ld hl, Func_004_431F
    ld b, $04
    rst $10
    ld a, [wC5C7]
    and a, a
    jr nz, Jump_0F2_429F
    ld hl, Data_0F2_42EC
    jr Jump_0F2_42A2

Jump_0F2_429F::
    ld hl, Data_0F2_42F2

Jump_0F2_42A2::
    ld de, hFFC6
    ld b, $06
    call Func_0F2_42D9
    ld hl, Func_004_431F
    ld b, $04
    rst $10
    ld a, $0D
    ldh [hFFC6], a
    ld hl, Func_012_6B98
    ld b, $12
    rst $10
    xor a, a
    ld [wCBCF], a
    ld a, $48
    ld [wCBD3], a
    ld a, $40
    ld [wCBD4], a
    ld a, $02
    ld [wCB7D], a
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_0F2_42D8
    ld a, $7F
    ld [wC527], a

Jump_0F2_42D8::
    ret

Func_0F2_42D9::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Func_0F2_42D9
    ret

Data_0F2_42E0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $01, $04, $00, $80

Data_0F2_42E6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $00, $01, $01, $00, $80

Data_0F2_42EC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0C, $00, $01, $05, $00, $81

Data_0F2_42F2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0C, $00, $01, $05, $00, $81, $00, $00, $00, $02, $00, $82

Data_0F2_42FE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $00, $00, $F0, $40, $04, $01, $00, $00, $00, $F0, $40, $04, $00, $00

Data_0F2_430E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $01, $00, $F0, $40, $01, $01, $00, $00, $00, $F0, $40, $04, $00, $00

Data_0F2_431E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $0C, $00, $F0, $40, $05, $03, $10, $00, $00, $F0, $40, $04, $00, $00

Data_0F2_432E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $0C, $00, $F0, $40, $05, $03, $10, $00, $00, $F0, $40, $04, $00, $00
    db $00, $00, $00, $00, $48, $40, $02, $00, $20, $00, $00, $48, $40, $04, $00, $00

Func_0F2_434E::
    ld hl, vBGMap0
    ldh a, [hFFA5]
    and a, $F8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ldh a, [hFFA1]
    srl a
    srl a
    srl a
    add a, l
    ld l, a
    jr nc, Jump_0F2_436E
    inc h

Jump_0F2_436E::
    ret

Func_0F2_436F::
    push de
    push bc
    push hl
    ld hl, wC198
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
    ld [wC554], a
    ld a, h
    ld [wC555], a
    pop hl
    pop bc
    pop de
    ld a, [wIsCGB]
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
    ldh [rSVBK], a
    push hl
    ld hl, wD000
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    pop hl
    call Func_000_18A5
    call Func_000_120A
    ld a, $00
    ldh [rSVBK], a
    ld c, $4F
    ld a, $00
    ldh [c], a
    ret

Func_0F2_43C3::
    ld hl, Func_004_44CE
    ld b, $04
    rst $10
    ld hl, Func_012_6EC6
    ld b, $12
    rst $10
    ret

Func_0F2_43D0::
    ld de, Data_0F2_43E5
    call Func_000_25C9
    ret
    db $11, $E5, $43, $CD, $FE, $25, $C9

Func_0F2_43DE::
    call Func_0F2_43D0
    call Func_000_2611
    ret

Data_0F2_43E5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_0F2_43E7

Data_0F2_43E7:: ; heuristic: target of a monotone pointer table; C0
    dw Data_0F2_442F
    dw Data_0F2_442F
    dw Data_0F2_444E
    dw Data_0F2_446E
    dw Data_0F2_448F
    dw Data_0F2_44AC
    dw Data_0F2_44CF
    dw Data_0F2_44EF
    dw Data_0F2_450C
    dw Data_0F2_452D
    dw Data_0F2_458F
    dw Data_0F2_45C3
    dw Data_0F2_45E6
    dw Data_0F2_460A
    dw Data_0F2_462D
    dw Data_0F2_4653
    dw Data_0F2_4677
    dw Data_0F2_4698
    dw Data_0F2_46BC
    dw Data_0F2_46E2
    dw Data_0F2_470A
    dw Data_0F2_472F
    dw Data_0F2_4753
    dw Data_0F2_477A
    dw Data_0F2_479A
    dw Data_0F2_47BE
    dw Data_0F2_47E4
    dw Data_0F2_4805
    dw Data_0F2_4823
    dw Data_0F2_4843
    dw Data_0F2_488A
    dw Data_0F2_488A
    dw Data_0F2_488A
    dw Data_0F2_488A
    dw Data_0F2_48AC
    dw Data_0F2_48D1

Data_0F2_442F:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $11, $28, $2F, $2F, $32, $AB, $90, $2B, $32, $3A, $90, $30, $24
    db $3C, $90, $12, $F1, $36, $28, $35, $39, $28, $90, $3C, $32, $38, $98, $F0

Data_0F2_444E:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $20, $2B, $2C, $26, $2B, $90, $28, $2A, $2A, $90, $36, $2B, $32
    db $38, $2F, $27, $F1, $12, $90, $24, $33, $33, $35, $24, $2C, $36, $28, $98, $F0

Data_0F2_446E:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $12, $37, $90, $3A, $2C, $2F, $2F, $90, $26, $32, $36, $37, $F1
    db $02, $00, $10, $B5, $90, $12, $37, $90, $37, $2B, $24, $37, $90, $18, $14, $98
    db $F0

Data_0F2_448F:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $11, $32, $3A, $90, $28, $2F, $36, $28, $90, $30, $24, $3C, $90
    db $12, $F1, $36, $28, $35, $39, $28, $90, $3C, $32, $38, $98, $F0

Data_0F2_44AC:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $1E, $30, $A4, $90, $22, $32, $38, $90, $27, $32, $31, $41, $F1
    db $2B, $24, $39, $28, $90, $28, $31, $32, $38, $2A, $2B, $90, $2A, $32, $2F, $27
    db $A4, $F7, $F0

Data_0F2_44CF:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $1E, $30, $A4, $90, $22, $32, $38, $90, $27, $32, $31, $41, $F1
    db $2B, $24, $39, $28, $90, $24, $31, $3C, $90, $28, $2A, $2A, $36, $A4, $F7, $F0

Data_0F2_44EF:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $20, $2B, $2C, $26, $2B, $90, $28, $2A, $2A, $90, $36, $2B, $32
    db $38, $2F, $27, $F1, $12, $90, $25, $2F, $28, $36, $36, $98, $F0

Data_0F2_450C:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $12, $37, $90, $3A, $2C, $2F, $2F, $90, $26, $32, $36, $37, $F1
    db $F9, $00, $10, $B5, $90, $12, $36, $90, $37, $2B, $24, $37, $90, $18, $14, $98
    db $F0

Data_0F2_452D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $3C852D, $62

Data_0F2_458F:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $19, $2F, $28, $24, $36, $28, $90, $26, $32, $30, $28, $90, $36
    db $28, $28, $F1, $30, $28, $90, $3A, $2B, $28, $31, $90, $3C, $32, $38, $90, $2A
    db $28, $37, $FA, $F7, $EF, $EE, $30, $32, $35, $28, $90, $28, $2A, $2A, $36, $B5
    db $EF, $EE, $F7, $F0

Data_0F2_45C3:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $18, $14, $AB, $90, $12, $43, $2F, $90, $28, $39, $24, $2F, $38
    db $24, $37, $28, $F1, $37, $2B, $2C, $36, $90, $28, $2A, $2A, $90, $31, $32, $3A
    db $A4, $F7, $F0

Data_0F2_45E6:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $12, $37, $3E, $90, $29, $2C, $31, $28, $B5, $90, $1D, $2B, $28
    db $35, $28, $3E, $F1, $31, $32, $37, $2B, $2C, $31, $2A, $90, $3A, $35, $32, $31
    db $2A, $B5, $F7, $F0

Data_0F2_460A:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $12, $37, $3E, $90, $2A, $32, $32, $27, $AB, $90, $24, $31, $27
    db $F1, $2A, $35, $32, $3A, $2C, $31, $2A, $90, $2B, $28, $24, $2F, $37, $2B, $3C
    db $B5, $F7, $F0

Data_0F2_462D:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $20, $32, $3A, $AB, $90, $37, $2B, $2C, $36, $90, $28, $2A, $2A
    db $90, $2C, $36, $F1, $35, $28, $24, $2F, $2F, $3C, $90, $39, $2C, $2A, $32, $35
    db $32, $38, $36, $B5, $F7, $F0

Data_0F2_4653:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $18, $2B, $AB, $90, $30, $3C, $99, $90, $1D, $2B, $2C, $36, $90
    db $28, $2A, $2A, $F1, $2C, $36, $90, $2C, $31, $26, $35, $28, $27, $2C, $25, $2F
    db $28, $99, $F7, $F0

Data_0F2_4677:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $0D, $32, $31, $41, $90, $28, $3B, $33, $28, $26, $37, $90, $37
    db $32, $32, $F1, $30, $24, $31, $3C, $90, $36, $2E, $2C, $2F, $2F, $36, $B5, $F7
    db $F0

Data_0F2_4698:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $12, $37, $90, $2B, $24, $36, $90, $24, $90, $29, $24, $2C, $35
    db $F1, $31, $38, $30, $25, $28, $35, $90, $32, $29, $90, $36, $2E, $2C, $2F, $2F
    db $36, $B5, $F7, $F0

Data_0F2_46BC:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $12, $37, $90, $2C, $31, $2B, $28, $35, $2C, $37, $28, $27, $90
    db $2C, $37, $36, $F1, $33, $24, $35, $28, $31, $37, $36, $95, $90, $36, $2E, $2C
    db $2F, $2F, $36, $B5, $F7, $F0

Data_0F2_46E2:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $12, $37, $90, $2E, $31, $32, $3A, $36, $90, $24, $90, $2A, $35
    db $28, $24, $37, $F1, $39, $24, $35, $2C, $28, $37, $3C, $90, $32, $29, $90, $36
    db $2E, $2C, $2F, $2F, $36, $99, $F7, $F0

Data_0F2_470A:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $12, $37, $36, $90, $2A, $35, $32, $3A, $37, $2B, $90, $30, $24
    db $3C, $F1, $25, $28, $90, $24, $90, $25, $2C, $37, $90, $3A, $24, $31, $37, $2C
    db $31, $2A, $B5, $F7, $F0

Data_0F2_472F:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $12, $37, $90, $3A, $2C, $2F, $2F, $90, $2A, $35, $32, $3A, $90
    db $2C, $31, $F1, $24, $31, $90, $24, $39, $28, $35, $24, $2A, $28, $90, $3A, $24
    db $3C, $B5, $F7, $F0

Data_0F2_4753:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $12, $37, $90, $3A, $2C, $2F, $2F, $90, $25, $28, $90, $2B, $24
    db $35, $27, $F1, $37, $32, $90, $35, $24, $2C, $36, $28, $90, $24, $90, $2F, $2C
    db $37, $37, $2F, $28, $A4, $F7, $F0

Data_0F2_477A:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $12, $37, $36, $90, $2A, $35, $32, $3A, $37, $2B, $90, $26, $24
    db $31, $41, $F1, $25, $28, $90, $29, $24, $38, $2F, $37, $28, $27, $B5, $F7, $F0

Data_0F2_479A:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $12, $37, $90, $24, $33, $33, $28, $24, $35, $36, $90, $37, $32
    db $90, $25, $28, $F1, $24, $90, $2B, $24, $35, $27, $90, $3A, $32, $35, $2E, $28
    db $35, $B5, $F7, $F0

Data_0F2_47BE:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $1D, $2B, $2C, $36, $90, $32, $31, $28, $90, $36, $28, $28, $30
    db $36, $F1, $37, $32, $90, $25, $28, $90, $34, $38, $2C, $37, $28, $90, $36, $30
    db $24, $35, $37, $B5, $F7, $F0

Data_0F2_47E4:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $12, $90, $26, $24, $31, $90, $37, $28, $2F, $2F, $90, $37, $2B
    db $2C, $36, $F1, $32, $31, $28, $90, $2C, $36, $90, $2E, $2C, $31, $27, $B5, $F7
    db $F0

Data_0F2_4805:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $17, $32, $90, $27, $32, $38, $25, $37, $90, $24, $37, $F1, $24
    db $2F, $2F, $9C, $2C, $37, $3E, $90, $30, $24, $2F, $28, $B5, $F7, $F0

Data_0F2_4823:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $17, $32, $90, $27, $32, $38, $25, $37, $90, $24, $37, $F1, $24
    db $2F, $2F, $9C, $2C, $37, $3E, $90, $29, $28, $30, $24, $2F, $28, $B5, $F7, $F0

Data_0F2_4843:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $3C8843, $47

Data_0F2_488A:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $1C, $2B, $32, $38, $2F, $27, $90, $12, $90, $26, $2B, $24, $31
    db $2A, $28, $F1, $36, $32, $30, $28, $32, $31, $28, $3E, $90, $31, $24, $30, $28
    db $98, $F0

Data_0F2_48AC:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $0C, $32, $30, $28, $90, $2B, $28, $35, $28, $90, $29, $32, $35
    db $F1, $35, $28, $31, $24, $30, $2C, $31, $2A, $90, $30, $32, $31, $36, $37, $28
    db $35, $36, $B5, $F7, $F0

Data_0F2_48D1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $3C88D1, $FE

Func_0F2_49CF::
    ld a, $10
    ld [wC529], a
    xor a, a
    ld [wC528], a
    ld hl, vTiles2 + $20
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1E01
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld hl, Func_00E_537E
    ld b, $0E
    rst $10
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ret

Func_0F2_4A0B::
    ld a, $0E
    ld [wC529], a
    xor a, a
    ld [wC528], a
    ld hl, vTiles2 + $700
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0701
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld hl, Func_00E_537E
    ld b, $0E
    rst $10
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld de, Data_01F_4510
    ld hl, vTiles1 + $6E0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4450
    ld hl, vTiles1 + $6F0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ret

Func_0F2_4A61::
    ld hl, $2940
    ld de, vTiles2 + $290
    call Func_0F2_516E
    ld hl, $2940
    call Func_0F2_516E
    ld hl, $2940
    call Func_0F2_516E
    ld hl, $2940
    call Func_0F2_516E
    ld hl, $2940
    call Func_0F2_516E
    ld hl, wCA3A
    call Func_0F2_4E50
    ld de, vTiles2 + $290
    ld a, $F0
    ld [wC8D9], a
    call Func_000_21A1
    ret

Func_0F2_4A94::
    call Func_0F2_4AD3
    ld c, a
    ld [wC529], a
    ld a, $07
    ld [wC528], a
    ld hl, vTiles2 + $200
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0901
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld hl, Func_008_402B
    ld b, $08
    rst $10
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ret

Func_0F2_4AD3::
    ld a, [wCA9A]
    call Func_0F2_4AF3
    ld a, $09
    call Func_000_1682
    ld b, l
    ld a, [wCA9D]
    call Func_0F2_4AF3
    ld a, c
    add a, a
    add a, c
    add a, b
    ld b, a
    ld a, [wCA9B]
    call Func_0F2_4AF3
    ld a, c
    add a, b
    ret

Func_0F2_4AF3::
    ld c, $00
    cp a, $C0
    ret nc
    inc c
    cp a, $40
    ret nc
    inc c
    ret

Func_0F2_4AFE::
    call Func_0F2_4A94
    call Func_0F2_4A61
    ret

Func_0F2_4B05::
    ld a, [wCA83]
    ld [wC8C0], a
    ld a, [wCA84]
    ld [wC8C1], a
    ld a, [wCA85]
    ld [wC8C2], a
    call Func_000_173A
    ld hl, Func_01E_768E
    ld b, $1E
    rst $10
    call Func_0F2_514D
    ld de, $018C
    add hl, de
    call Func_000_24F8
    call Func_0F2_4E63
    ld a, [wCA81]
    ldh [hFFC6], a
    ld a, [wCA82]
    ldh [hFFC7], a
    ld b, a
    ldh a, [hFFC6]
    cp a, b
    jp nc, Jump_0F2_4BB6
    ldh a, [hFFC6]
    ld b, a
    push bc
    ld a, [wCA36]
    ld [wD006], a
    ld a, [wCA37]
    ld [wD007], a
    ld hl, Func_035_4001
    ld b, $35
    rst $10
    ld a, [wD00F]
    ldh [hFFC6], a
    pop bc
    ld a, b
    ldh [hFFC7], a
    ld hl, Func_019_7380
    ld b, $19
    rst $10
    ld de, hFFC8
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    inc de
    ld a, [de]
    ld e, a
    push bc
    push de
    ld a, [wCA83]
    ldh [hFFC6], a
    ld a, [wCA84]
    ldh [hFFC7], a
    ld a, [wCA85]
    ldh [hFFC8], a
    pop de
    pop bc
    ldh a, [hFFC6]
    ld l, a
    ld a, c
    sub a, l
    ld c, a
    ldh a, [hFFC7]
    ld l, a
    ld a, b
    sbc a, l
    ld b, a
    ldh a, [hFFC8]
    ld l, a
    ld a, e
    sbc a, l
    ld e, a
    ld a, c
    ld [wC8C0], a
    ld a, b
    ld [wC8C1], a
    ld a, e
    ld [wC8C2], a
    call Func_000_173A
    ld hl, Func_01E_768E
    ld b, $1E
    rst $10

Jump_0F2_4BA8::
    call Func_0F2_514D
    ld de, $020C
    add hl, de
    call Func_000_24F8
    call Func_0F2_4E63
    ret

Jump_0F2_4BB6::
    ld a, $E3
    ld [wD7F1], a
    ld [wD7F2], a
    ld [wD7F3], a
    ld [wD7F4], a
    ld [wD7F5], a
    ld [wD7F6], a
    xor a, a
    ld [wD7F7], a
    jr Jump_0F2_4BA8

Func_0F2_4BD0::
    ld a, [wCACF]
    ld [wC529], a
    ld a, $0B
    ld [wC528], a
    xor a, a
    ld [rRAMG2], a
    ld hl, vTiles2 + $320
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0602
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld hl, Func_008_402B
    ld b, $08
    rst $10
    ret

Func_0F2_4BFC::
    ld a, [wCA36]
    ld [wD006], a
    ld a, [wCA37]
    ld [wD007], a
    ld hl, Func_035_4001
    ld b, $35
    rst $10
    ld a, [wD013]
    ld [wC529], a
    ld a, $0D
    ld [wC528], a
    ld hl, vTiles2 + $680
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0602
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld hl, Func_008_402B
    ld b, $08
    rst $10
    ret

Func_0F2_4C36::
    call Func_0F2_4C3D
    call Func_0F2_4D72
    ret

Func_0F2_4C3D::
    ld a, [wCA38]
    and a, $10
    and a, a
    jr nz, Jump_0F2_4C4A
    ld de, Data_0F2_4D62
    jr Jump_0F2_4C4D

Jump_0F2_4C4A::
    ld de, Data_0F2_4D6A

Jump_0F2_4C4D::
    ld a, [de]
    push de
    call Func_0F2_4E40
    pop de
    ldh a, [hFFC7]
    cp a, $FF
    jr nz, Jump_0F2_4C7E
    ld a, $98
    ld [wC8CF], a
    ld a, $98
    ld [wC8D0], a
    ld a, $98
    ld [wC8D1], a
    ld a, $F0
    ld [wC8D2], a
    push de
    ld de, vTiles2 + $200
    call Func_000_21A1
    pop de
    ld a, $03
    add a, e
    ld e, a
    jr nc, Jump_0F2_4C7C
    inc d

Jump_0F2_4C7C::
    jr Jump_0F2_4CA8

Jump_0F2_4C7E::
    inc de
    ld a, [de]
    inc de
    push de
    ld hl, wCA2B
    add a, l
    ld l, a
    jr nc, Jump_0F2_4C8A
    inc h

Jump_0F2_4C8A::
    call Func_0F2_4E50
    ld de, vTiles2 + $200
    call Func_000_21A1
    pop de
    ld a, $92
    ld [wD7F1], a
    ld a, $50
    ld [wD7F2], a
    ld a, [de]
    inc de
    push de
    ld [wD7F3], a
    call Func_0F2_4D2B
    pop de

Jump_0F2_4CA8::
    ld a, [de]
    inc de
    push de
    ld hl, wCA2B
    add a, l
    ld l, a
    jr nc, Jump_0F2_4CB3
    inc h

Jump_0F2_4CB3::
    call Func_0F2_4E50
    ld de, vTiles2 + $2F0
    call Func_000_21A1
    pop de
    ld a, [de]
    push de
    call Func_0F2_4E40
    pop de
    ldh a, [hFFC7]
    cp a, $FF
    jr nz, Jump_0F2_4CEE
    ld a, $98
    ld [wC8CF], a
    ld a, $98
    ld [wC8D0], a
    ld a, $98
    ld [wC8D1], a
    ld a, $F0
    ld [wC8D2], a
    push de
    ld de, vTiles2 + $340
    call Func_000_21A1
    pop de
    ld a, $03
    add a, e
    ld e, a
    jr nc, Jump_0F2_4CEC
    inc d

Jump_0F2_4CEC::
    jr Jump_0F2_4D18

Jump_0F2_4CEE::
    inc de
    ld a, [de]
    inc de
    push de
    ld hl, wCA2B
    add a, l
    ld l, a
    jr nc, Jump_0F2_4CFA
    inc h

Jump_0F2_4CFA::
    call Func_0F2_4E50
    ld de, vTiles2 + $340
    call Func_000_21A1
    pop de
    ld a, $93
    ld [wD7F1], a
    ld a, $90
    ld [wD7F2], a
    ld a, [de]
    inc de
    push de
    ld [wD7F3], a
    call Func_0F2_4D2B
    pop de

Jump_0F2_4D18::
    ld a, [de]
    ld hl, wCA2B
    add a, l
    ld l, a
    jr nc, Jump_0F2_4D21
    inc h

Jump_0F2_4D21::
    call Func_0F2_4E50
    ld de, vTiles2 + $430
    call Func_000_21A1
    ret

Func_0F2_4D2B::
    ld a, [wD7F3]
    ld hl, wCA2B
    add a, l
    ld l, a
    jr nc, Jump_0F2_4D36
    inc h

Jump_0F2_4D36::
    ld a, [hl+]
    ld [wC529], a
    ld a, [hl]
    add a, $02
    ld [wC528], a
    ld a, [wD7F1]
    ld h, a
    ld a, [wD7F2]
    ld l, a
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0901
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld hl, Func_008_402B
    ld b, $08
    rst $10
    ret

Data_0F2_4D62:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $1A, $8E, $1A, $1E, $1C, $99, $1C, $29

Data_0F2_4D6A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $1C, $99, $1C, $29, $1A, $8E, $1A, $1E

Func_0F2_4D72::
    ld a, [wCA38]
    and a, $10
    and a, a
    jr nz, Jump_0F2_4D7F
    ld de, Data_0F2_4E34
    jr Jump_0F2_4D82

Jump_0F2_4D7F::
    ld de, Data_0F2_4E3A

Jump_0F2_4D82::
    ld a, [de]
    push de
    call Func_0F2_4E40
    pop de
    ldh a, [hFFC7]
    cp a, $FF
    jr nz, Jump_0F2_4D9E
    push de
    ld hl, vTiles1 + $430
    ld de, vTiles2 + $6C0
    call Func_0F2_516E
    pop de
    inc de
    inc de
    inc de
    jr Jump_0F2_4DD4

Jump_0F2_4D9E::
    inc de
    ld a, [de]
    ld [wD7F1], a
    inc de
    ld a, [de]
    dec de
    push de
    ld [wD7F5], a
    xor a, a
    ld [wD7F2], a
    ld a, $6A
    ld [wD7F3], a
    ld a, $6C
    ld [wD7F4], a
    call Func_0F2_50C6
    pop de
    call Func_0F2_4E26
    inc de
    inc de
    push de
    call Func_0F2_514D
    ld de, $006E
    add hl, de
    call Func_000_24F8
    di
    call Func_000_120A
    ld a, b
    ld [hl], a
    ei
    pop de

Jump_0F2_4DD4::
    ld a, [de]
    push de
    call Func_0F2_4E40
    pop de
    ldh a, [hFFC7]
    cp a, $FF
    jr nz, Jump_0F2_4DF0
    push de
    ld hl, vTiles1 + $430
    ld de, vTiles2 + $6D0
    call Func_0F2_516E
    pop de
    inc de
    inc de
    inc de
    jr Jump_0F2_4E25

Jump_0F2_4DF0::
    inc de
    ld a, [de]
    ld [wD7F1], a
    inc de
    ld a, [de]
    dec de
    push de
    ld [wD7F5], a
    ld a, $01
    ld [wD7F2], a
    ld a, $8A
    ld [wD7F3], a
    ld a, $6D
    ld [wD7F4], a
    call Func_0F2_50C6
    pop de
    call Func_0F2_4E26
    push de
    call Func_0F2_514D
    ld de, $018E
    add hl, de
    call Func_000_24F8
    di
    call Func_000_120A
    ld a, b
    ld [hl], a
    ei
    pop de

Jump_0F2_4E25::
    ret

Func_0F2_4E26::
    ld a, [de]
    cp a, $98
    jr z, Jump_0F2_4E30
    ld bc, wCDCC
    jr Jump_0F2_4E33

Jump_0F2_4E30::
    ld bc, wCCCD

Jump_0F2_4E33::
    ret

Data_0F2_4E34:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $1A, $98, $1A, $1C, $A3, $1C

Data_0F2_4E3A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $1C, $A3, $1C, $1A, $98, $1A

Func_0F2_4E40::
    ld de, wCA2B
    add a, e
    ld e, a
    jr nc, Jump_0F2_4E48
    inc d

Jump_0F2_4E48::
    ld a, [de]
    ldh [hFFC6], a
    inc de
    ld a, [de]
    ldh [hFFC7], a
    ret

Func_0F2_4E50::
    ld de, wC8CF
    ld c, $0A

Jump_0F2_4E55::
    ld a, [hl+]
    cp a, $F0
    jr z, Jump_0F2_4E5F
    ld [de], a
    inc de
    dec c
    jr nz, Jump_0F2_4E55

Jump_0F2_4E5F::
    ld a, $F0
    ld [de], a
    ret

Func_0F2_4E63::
    ld de, wD7F1
    ld c, $07

Jump_0F2_4E68::
    di
    call Func_000_120A
    ld a, [de]
    add a, $E0
    ld [hl+], a
    inc de
    ei
    dec c
    jr nz, Jump_0F2_4E68
    ret

Func_0F2_4E76::
    ld c, $00

Jump_0F2_4E78::
    push bc
    ld a, [wCA38]
    and a, $10
    jr nz, Jump_0F2_4E85
    ld de, Data_0F2_4F41
    jr Jump_0F2_4E88

Jump_0F2_4E85::
    ld de, Data_0F2_4F44

Jump_0F2_4E88::
    pop bc
    push bc
    ld a, c
    add a, e
    ld e, a
    jr nc, Jump_0F2_4E90
    inc d

Jump_0F2_4E90::
    ld a, [de]
    ld hl, wCA2B
    add a, l
    ld l, a
    jr nc, Jump_0F2_4E99
    inc h

Jump_0F2_4E99::
    ld a, [hl+]
    ldh [hFFC6], a
    ld a, [hl]
    ldh [hFFC7], a
    cp a, $FF
    jr z, Jump_0F2_4ECC
    pop bc
    push bc
    ldh a, [hFFC6]
    ld [wD7F1], a
    ldh a, [hFFC7]
    ld [wD7F2], a
    ld a, c
    ld b, a
    add a, a
    add a, b
    ld de, Data_0F2_4ED4
    add a, e
    ld e, a
    jr nc, Jump_0F2_4EBB
    inc d

Jump_0F2_4EBB::
    ld hl, wD7F3
    ld c, $03

Jump_0F2_4EC0::
    ld a, [de]
    ld [hl+], a
    inc de
    dec c
    jr nz, Jump_0F2_4EC0
    ld hl, Func_01D_6973
    ld b, $1D
    rst $10

Jump_0F2_4ECC::
    pop bc
    inc c
    ld a, c
    cp a, $03
    jr c, Jump_0F2_4E78
    ret

Data_0F2_4ED4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $80, $08, $00, $81, $10, $00, $82

Func_0F2_4EDD::
    ld c, $00

Jump_0F2_4EDF::
    push bc
    ld a, [wCA38]
    ldh [hFFC6], a
    and a, $10
    jr nz, Jump_0F2_4EEE
    ld de, Data_0F2_4F41
    jr Jump_0F2_4EF1

Jump_0F2_4EEE::
    ld de, Data_0F2_4F44

Jump_0F2_4EF1::
    pop bc
    push bc
    ld a, c
    add a, e
    ld e, a
    jr nc, Jump_0F2_4EF9
    inc d

Jump_0F2_4EF9::
    ld a, [de]
    call Func_0F2_4E40
    ldh a, [hFFC7]
    cp a, $FF
    jr z, Jump_0F2_4F2D
    pop bc
    push bc
    ldh a, [hFFC6]
    ld [wD7F1], a
    ldh a, [hFFC7]
    ld [wD7F2], a
    ld a, c
    add a, a
    add a, a
    ld de, Data_0F2_4F35
    add a, e
    ld e, a
    jr nc, Jump_0F2_4F1A
    inc d

Jump_0F2_4F1A::
    ld hl, wD7F3
    ld c, $04

Jump_0F2_4F1F::
    ld a, [de]
    ld [hl+], a
    inc de
    dec c
    jr nz, Jump_0F2_4F1F
    ld c, $00
    ld hl, Func_01D_6A3D
    ld b, $1D
    rst $10

Jump_0F2_4F2D::
    pop bc
    inc c
    ld a, c
    cp a, $03
    jr c, Jump_0F2_4EDF
    ret

Data_0F2_4F35:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $10, $78, $00, $10, $30, $68, $01, $20, $30, $88, $02

Data_0F2_4F41:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0B, $1A, $1C

Data_0F2_4F44:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0B, $1C, $1A

Func_0F2_4F47::
    ld hl, wCA81
    ld a, [hl+]
    ldh [hFFC6], a
    ld a, [hl]
    ldh [hFFC7], a
    call Func_0F2_514D
    ld de, $0029
    add hl, de
    call Func_000_24F8
    ldh a, [hFFC7]
    ld b, a
    ldh a, [hFFC6]
    cp a, b
    jr c, Jump_0F2_4F6C
    di
    call Func_000_120A
    ld a, $6F
    ld [hl], a
    ei
    jr Jump_0F2_4F74

Jump_0F2_4F6C::
    di
    call Func_000_120A
    ld a, $C3
    ld [hl], a
    ei

Jump_0F2_4F74::
    inc hl
    di
    call Func_000_120A
    ld a, $EA
    ld [hl+], a
    ld a, $ED
    ld [hl+], a
    ei
    push hl
    ldh a, [hFFC6]
    ld l, a
    ld h, $00
    call Func_000_16F5
    ld hl, Func_01E_75B3
    ld b, $1E
    rst $10
    pop hl
    ld a, [wC8C1]
    add a, $E0
    ld e, a
    di
    call Func_000_120A
    ld [hl], e
    ei
    inc hl
    ld a, [wC8C2]
    add a, $E0
    ld e, a
    di
    call Func_000_120A
    ld [hl], e
    ei
    inc hl
    call Func_0F2_4FD6
    ld a, [wCA80]
    push af
    bit 0, a
    call nz, Func_0F2_4FE7
    pop af
    inc hl
    push af
    bit 2, a
    call nz, Func_0F2_4FF0
    pop af
    inc hl
    bit 7, a
    call nz, Func_0F2_4FF9
    inc hl
    inc hl
    ld a, [wCA39]
    and a, $01
    add a, $CC
    ld e, a
    di
    call Func_000_120A
    ld [hl], e
    ei
    ret

Func_0F2_4FD6::
    push hl
    ld e, $C3
    ld c, $03

Jump_0F2_4FDB::
    di
    call Func_000_120A
    ld [hl], e
    ei
    inc hl
    dec c
    jr nz, Jump_0F2_4FDB
    pop hl
    ret

Func_0F2_4FE7::
    di
    call Func_000_120A
    ld a, $C1
    ld [hl], a
    ei
    ret

Func_0F2_4FF0::
    di
    call Func_000_120A
    ld a, $C0
    ld [hl], a
    ei
    ret

Func_0F2_4FF9::
    di
    call Func_000_120A
    ld a, $C2
    ld [hl], a
    ei
    ret

Func_0F2_5002::
    call Func_0F2_4F47
    call Func_0F2_505C
    call Func_0F2_500C
    ret

Func_0F2_500C::
    ld c, $00

Jump_0F2_500E::
    push bc
    ld a, c
    ld hl, Data_0F2_5050
    add a, l
    ld l, a
    jr nc, Jump_0F2_5018
    inc h

Jump_0F2_5018::
    ld a, [hl]
    ld hl, wCA2B
    add a, l
    ld l, a
    jr nc, Jump_0F2_5021
    inc h

Jump_0F2_5021::
    ld a, [hl+]
    ld b, a
    ld a, [hl]
    ld h, a
    ld l, b
    call Func_000_16F5
    ld hl, Func_01E_75B3
    ld b, $1E
    rst $10
    pop bc
    ld a, c
    add a, a
    ld hl, Data_0F2_5054
    add a, l
    ld l, a
    jr nc, Jump_0F2_503A
    inc h

Jump_0F2_503A::
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call Func_0F2_514D
    pop de
    add hl, de
    call Func_000_24F8
    call Func_0F2_50A4
    inc c
    ld a, c
    cp a, $04
    jr c, Jump_0F2_500E
    ret

Data_0F2_5050:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $5B, $5D, $5F, $61

Data_0F2_5054:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $CC, $01, $D0, $01, $0C, $02, $10, $02

Func_0F2_505C::
    call Func_0F2_514D
    ld de, $0070
    add hl, de
    call Func_000_24F8
    ld c, $00

Jump_0F2_5068::
    push bc
    push hl
    ld a, c
    ld de, Data_0F2_509F
    add a, e
    ld e, a
    jr nc, Jump_0F2_5073
    inc d

Jump_0F2_5073::
    ld a, [de]
    ld hl, wCA2B
    add a, l
    ld l, a
    jr nc, Jump_0F2_507C
    inc h

Jump_0F2_507C::
    ld a, [hl+]
    ld b, a
    ld a, [hl]
    ld h, a
    ld l, b
    call Func_000_16F5
    ld hl, Func_01E_75B3
    ld b, $1E
    rst $10
    pop hl
    push hl
    call Func_0F2_50A4
    pop hl
    ld a, $40
    add a, l
    ld l, a
    jr nc, Jump_0F2_5097
    inc h

Jump_0F2_5097::
    pop bc
    inc c
    ld a, c
    cp a, $05
    jr c, Jump_0F2_5068
    ret

Data_0F2_509F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $63, $65, $67, $69, $6B

Func_0F2_50A4::
    di
    call Func_000_120A
    ld a, [wC8C0]
    add a, $E0
    ld [hl+], a
    ei
    di
    call Func_000_120A
    ld a, [wC8C1]
    add a, $E0
    ld [hl+], a
    ei
    di
    call Func_000_120A
    ld a, [wC8C2]
    add a, $E0
    ld [hl+], a
    ei
    ret

Func_0F2_50C6::
    push bc
    ld hl, wCA2B
    ld a, [wD7F5]
    add a, l
    ld l, a
    jr nc, Jump_0F2_50D2
    inc h

Jump_0F2_50D2::
    ld a, [hl+]
    ldh [hFFC6], a
    ld a, [hl]
    ldh [hFFC7], a
    ld hl, Func_00E_6138
    ld b, $0E
    rst $10
    pop bc
    jp Jump_0F2_50F8

Func_0F2_50E2::
    push bc
    ld a, [wCA38]
    and a, $0F
    ld [wD09D], a
    ld a, [wD7F4]
    ld [wD09E], a
    ld hl, Func_016_7A48
    ld b, $16
    rst $10
    pop bc

Jump_0F2_50F8::
    ld a, [wD7F1]
    ld hl, wCA2B
    add a, l
    ld l, a
    jr nc, Jump_0F2_5103
    inc h

Jump_0F2_5103::
    ld a, [hl]
    and a, a
    jr nz, Jump_0F2_5108
    ret

Jump_0F2_5108::
    push af
    call Func_0F2_514D
    ld a, [wD7F2]
    ld d, a
    ld a, [wD7F3]
    ld e, a
    add hl, de
    call Func_000_24F8
    di
    call Func_000_120A
    ld a, $1E
    ld [hl+], a
    ei
    pop af
    push hl
    ld l, a
    ld h, $00
    call Func_000_16F5
    ld hl, Func_01E_75B3
    ld b, $1E
    rst $10
    pop hl
    ld a, [wC8C1]
    cp a, $E3
    jr z, Jump_0F2_5141
    di
    call Func_000_120A
    ld a, [wC8C1]
    add a, $E0
    ld [hl+], a
    ei

Jump_0F2_5141::
    di
    call Func_000_120A
    ld a, [wC8C2]
    add a, $E0
    ld [hl+], a
    ei
    ret

Func_0F2_514D::
    ld hl, vBGMap0
    ldh a, [hFFA5]
    and a, $F8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ldh a, [hFFA1]
    srl a
    srl a
    srl a
    add a, l
    ld l, a
    jr nc, Jump_0F2_516D
    inc h

Jump_0F2_516D::
    ret

Func_0F2_516E::
    ld a, $10

Jump_0F2_5170::
    push af
    di

Jump_0F2_5172::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_0F2_5172
    ld a, [hl+]
    ld [de], a
    inc de
    ei
    pop af
    dec a
    jr nz, Jump_0F2_5170
    ret

Func_0F2_5181:: ; heuristic: follows a terminator; C0
    ld a, [wD7F1]
    ld c, a
    ld a, [wD7F2]
    ld b, a
    ld a, $03
    call Func_000_16AA
    ld de, Data_0F2_51C3
    add hl, de
    ld c, $03
    ld b, $00

Jump_0F2_5196::
    ld a, [hl+]
    ld de, wD7F1
    add a, e
    ld e, a
    jr nc, Jump_0F2_519F
    inc d

Jump_0F2_519F::
    push hl
    ld a, b
    ld hl, wD7F5
    add a, l
    ld l, a
    jr nc, Jump_0F2_51A9
    inc h

Jump_0F2_51A9::
    ld a, [hl]
    pop hl
    ld [de], a
    inc b
    dec c
    jr nz, Jump_0F2_5196
    ld a, [wD7F1]
    ld [wD7F5], a
    ld a, [wD7F2]
    ld [wD7F6], a
    ld a, [wD7F3]
    ld [wD7F7], a
    ret

Data_0F2_51C3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $3C91C3, $480

Data_0F2_5643:: ; heuristic: argument of a bank-switching copy helper; C0
    dw Data_0F2_5673
    dw Data_0F2_577B
    dw Data_0F2_580B
    dw Data_0F2_589B
    dw Data_0F2_592B
    dw Data_0F2_59BB
    dw Data_0F2_5A4B
    dw Data_0F2_5ADB
    dw Data_0F2_5B6B
    dw Data_0F2_5BFB
    dw Data_0F2_5C8B
    dw Data_0F2_5CEB
    dw Data_0F2_5D7B
    dw Data_0F2_5E0B
    dw Data_0F2_5E9B
    dw Data_0F2_5F2B
    dw Data_0F2_5FBB
    dw Data_0F2_604B
    dw Data_0F2_60DB
    dw Data_0F2_616B
    db $BB, $59, $BB, $59, $BB, $59, $FB, $61

Data_0F2_5673:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $0A, $00, $00, $32, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $04
    ds $38, $00
    db $0A, $00, $00, $28
    ds $2C, $00
    db $19, $00, $00, $00, $00, $00, $32
    ds $77, $00
    db $14, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Data_0F2_577B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $F4, $01, $00, $C8, $00, $00, $00
    db $00, $00, $00, $00, $00, $14, $00, $00, $14, $00, $00, $14, $00, $00, $14
    ds $32, $00
    db $C8
    ds $2F, $00
    db $32, $00, $00, $00, $00, $00, $00, $00, $00, $32, $00, $00, $00, $00, $00

Data_0F2_580B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $D0
    db $07
    ds $10, $00
    db $E8, $03, $00, $E8, $03
    ds $2E, $00
    db $E8, $03, $00, $00, $00, $00, $00, $00, $00, $20, $03, $00, $00, $00, $00, $E8
    db $03, $00, $BC, $02, $00, $20, $03, $00, $DC, $05, $00, $B8, $0B
    ds $16, $00
    db $20, $4E, $00, $00, $00, $00, $00, $00, $00

Data_0F2_589B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $0A, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $04, $00, $00, $00, $00, $00, $00, $00, $00, $14
    ds $2F, $00
    db $0A
    ds $2F, $00
    db $1E
    ds $14, $00

Data_0F2_592B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $0A, $00, $00, $32, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $04, $00, $00, $00, $00, $00, $00, $00, $00, $14
    ds $32, $00
    db $28
    ds $2C, $00
    db $1E, $00, $00, $00, $00, $00, $32, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00

Data_0F2_59BB:: ; heuristic: target of a monotone pointer table; C0
    ds $90, $00

Data_0F2_5A4B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $00, $00, $32, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $04, $00, $00, $00, $00, $00, $00, $00, $00, $14
    ds $32, $00
    db $28, $00, $00, $C8
    ds $26, $00
    db $32, $00, $00, $00, $00, $00, $32, $00, $00, $32, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00

Data_0F2_5ADB:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $00, $00, $41, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $05, $00, $00, $14, $00, $00, $14
    ds $35, $00
    db $32, $00, $00, $FA
    ds $26, $00
    db $32, $00, $00, $00, $00, $00, $64, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $32, $00, $00, $00, $00, $00

Data_0F2_5B6B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $00, $00, $41, $00, $00, $EE, $02, $00, $2C, $01
    ds $10, $00
    db $1E
    ds $2F, $00
    db $32
    ds $29, $00
    db $32, $00, $00, $00, $00, $00, $64
    ds $11, $00

Data_0F2_5BFB:: ; heuristic: target of a monotone pointer table; C0
    ds $18, $00
    db $14, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $DC, $05
    ds $2B, $00
    db $C8, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $20, $03, $00, $00
    db $00, $00, $B0, $04
    ds $1C, $00
    db $64, $00, $00, $00, $00, $00, $20, $4E, $00, $64, $00, $00, $00, $00, $00

Data_0F2_5C8B:: ; heuristic: target of a monotone pointer table; C0
    ds $39, $00
    db $10, $27, $00, $10, $27, $00, $10, $27, $00, $10, $27, $00, $10, $27, $00, $10
    db $27
    ds $16, $00

Data_0F2_5CEB:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $00, $00, $4B, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $2D, $00, $00, $00, $00, $00, $00, $00, $00, $1E
    ds $32, $00
    db $2C, $01
    ds $28, $00
    db $1E, $00, $00, $96, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $32
    db $00, $00, $00, $00, $00

Data_0F2_5D7B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $00, $00, $32, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $2D, $00, $00, $00, $00, $00, $00, $00, $00, $1E
    ds $32, $00
    db $C8
    ds $26, $00
    db $64, $00, $00, $00, $00, $00, $64, $00, $00, $64, $00, $00, $00, $00, $00, $00
    db $00, $00, $32, $00, $00, $00, $00, $00

Data_0F2_5E0B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $00, $00, $3C, $00, $00, $58, $02, $00, $FA
    ds $44, $00
    db $C8, $00, $00, $DC, $05, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $78
    ds $17, $00
    db $64, $00, $00, $00, $00, $00, $64
    ds $11, $00

Data_0F2_5E9B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $00, $00, $4B, $00, $00, $EE, $02, $00, $2C, $01
    ds $16, $00
    db $E8, $03
    ds $2E, $00
    db $DC, $05, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $2C, $01
    ds $16, $00
    db $96, $00, $00, $00, $00, $00, $96, $00, $00, $64, $00, $00, $00, $00, $00, $00
    db $00, $00, $32, $00, $00, $00, $00, $00

Data_0F2_5F2B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $0F, $00, $00, $4B, $00, $00, $EE, $02, $00, $2C, $01, $00, $00
    db $00, $00, $0F, $00, $00, $2D, $00, $00, $4B, $00, $00, $00, $00, $00, $1E
    ds $32, $00
    db $2C, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $64
    ds $17, $00
    db $96, $00, $00, $00, $00, $00, $96
    ds $11, $00

Data_0F2_5FBB:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $0F, $00, $00, $4B, $00, $00, $EE, $02, $00, $00, $00, $00, $B8
    db $0B, $00, $0F, $00, $00, $2D, $00, $00, $4B
    ds $5C, $00
    db $4C, $1D
    ds $19, $00

Data_0F2_604B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $00, $00, $4B, $00, $00, $00, $00, $00, $2C, $01
    ds $13, $00
    db $DC, $05
    ds $31, $00
    db $DC, $05, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $2C, $01, $00, $DC
    db $05
    ds $2B, $00

Data_0F2_60DB:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $00, $00, $4B, $00, $00, $EE, $02, $00, $00, $00, $00, $D0
    db $07
    ds $43, $00
    db $DC, $05, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $2C, $01, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $DC, $05, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $96, $00, $00, $00, $00, $00, $96
    ds $11, $00

Data_0F2_616B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $0F, $00, $00, $4B, $00, $00, $00, $00, $00, $2C, $01, $00, $00
    db $00, $00, $0F
    ds $3E, $00
    db $2C, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $2C
    db $01
    ds $16, $00
    db $96, $00, $00, $00, $00, $00, $96
    ds $11, $00
    INCBIN "dwm2-cobi-us.gbc", $3CA1FB, $138

Func_0F2_6333::
    ret

Func_0F2_6334:: ; heuristic: follows a terminator; C0
    call Func_0F2_6355
    call Func_0F2_6346
    ret

Func_0F2_633B:: ; heuristic: follows a terminator; C0
    call Func_0F2_6355
    call Func_0F2_6346
    xor a, a
    ld [wD781], a
    ret

Func_0F2_6346::
    ld hl, wD09E
    ld de, wC707
    ld c, $C0

Jump_0F2_634E::
    ld a, [hl+]
    ld [de], a
    inc de
    dec c
    jr nz, Jump_0F2_634E
    ret

Func_0F2_6355::
    ld hl, wD09E
    ld c, $C0

Jump_0F2_635A::
    ld a, $FF
    ld [hl+], a
    dec c
    jr nz, Jump_0F2_635A
    xor a, a
    ld [wD15E], a
    ld a, [wD09D]
    and a, a
    jr nz, Jump_0F2_637F
    ld a, $01
    ld [wD09D], a
    ld hl, wC707
    ld de, wD09E
    call Func_0F2_63EF
    ld hl, wC707
    call Func_0F2_6393
    ret

Jump_0F2_637F::
    xor a, a
    ld [wD09D], a
    ld hl, wC707
    ld de, wD09E
    call Func_0F2_6393
    ld hl, wC707
    call Func_0F2_63EF
    ret

Func_0F2_6393::
    ld b, $00
    ld c, $20

Jump_0F2_6397::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_0F2_63E3
    push hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    bit 7, a
    jr z, Jump_0F2_63B0
    pop hl
    push hl
    ld a, [hl]
    and a, $3F
    cp a, $07
    jr nc, Jump_0F2_63B0
    jr Jump_0F2_63E2

Jump_0F2_63B0::
    pop hl
    push hl
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    inc de
    push de
    ld a, b
    add a, a
    ld hl, wC787
    add a, l
    ld l, a
    jr nc, Jump_0F2_63C9
    inc h

Jump_0F2_63C9::
    ld a, [wD15E]
    add a, a
    ld de, wD11E
    add a, e
    ld e, a
    jr nc, Jump_0F2_63D5
    inc d

Jump_0F2_63D5::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    ld a, [wD15E]
    inc a
    ld [wD15E], a
    pop de

Jump_0F2_63E2::
    pop hl

Jump_0F2_63E3::
    ld a, $04
    add a, l
    ld l, a
    jr nc, Jump_0F2_63EA
    inc h

Jump_0F2_63EA::
    inc b
    dec c
    jr nz, Jump_0F2_6397
    ret

Func_0F2_63EF::
    ld b, $00
    ld c, $20

Jump_0F2_63F3::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_0F2_63E3
    push hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    bit 7, a
    jr z, Jump_0F2_643C
    pop hl
    push hl
    ld a, [hl]
    and a, $3F
    cp a, $07
    jr nc, Jump_0F2_643C
    pop hl
    push hl
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    inc de
    push de
    ld a, b
    add a, a
    ld hl, wC787
    add a, l
    ld l, a
    jr nc, Jump_0F2_6423
    inc h

Jump_0F2_6423::
    ld a, [wD15E]
    add a, a
    ld de, wD11E
    add a, e
    ld e, a
    jr nc, Jump_0F2_642F
    inc d

Jump_0F2_642F::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    ld a, [wD15E]
    inc a
    ld [wD15E], a
    pop de

Jump_0F2_643C::
    pop hl
    ld a, $04
    add a, l
    ld l, a
    jr nc, Jump_0F2_6444
    inc h

Jump_0F2_6444::
    inc b
    dec c
    jr nz, Jump_0F2_63F3
    ret

Func_0F2_6449:: ; heuristic: follows a terminator; C0
    ld a, [wD780]
    cp a, $03
    jr z, Jump_0F2_6470
    call Func_0F2_64C7
    ret

Func_0F2_6454:: ; heuristic: follows a terminator; C0
    ld hl, wD09D
    ld b, $18

Jump_0F2_6459::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_0F2_6459
    ld a, [wCF8B]
    and a, a
    jr nz, Jump_0F2_6469
    ld de, Data_0F2_6586
    jr Jump_0F2_646C

Jump_0F2_6469::
    ld de, Data_0F2_6526

Jump_0F2_646C::
    call Func_0F2_648E
    ret

Jump_0F2_6470::
    ld hl, wD09D
    ld b, $18

Jump_0F2_6475::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_0F2_6475
    ld a, [wCF8B]
    and a, a
    jr nz, Jump_0F2_6487
    ld de, Data_0F2_6526
    ld a, $01
    jr Jump_0F2_648B

Jump_0F2_6487::
    ld de, Data_0F2_6586
    xor a, a

Jump_0F2_648B::
    ld [wCF8B], a

Func_0F2_648E::
    ld b, $00

Jump_0F2_6490::
    ld a, [de]
    cp a, $FF
    jr z, Jump_0F2_64B8
    ld c, a
    push de
    ld hl, wC61D
    ld d, $18

Jump_0F2_649C::
    ld a, [hl]
    cp a, c
    jr z, Jump_0F2_64A8
    inc hl
    dec d
    jr nz, Jump_0F2_649C

Jump_0F2_64A4::
    pop de
    inc de
    jr Jump_0F2_6490

Jump_0F2_64A8::
    ld e, b
    ld d, $00
    push hl
    ld hl, wD09D
    add hl, de
    ld e, l
    ld d, h
    pop hl
    ld a, [hl+]
    ld [de], a
    inc b
    jr Jump_0F2_64A4

Jump_0F2_64B8::
    ld hl, wD09D
    ld de, wD7D5
    ld b, $18

Jump_0F2_64C0::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_0F2_64C0
    ret

Func_0F2_64C7::
    ld hl, wD09D
    ld b, $C8

Jump_0F2_64CC::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_0F2_64CC
    ld a, [wCF8B]
    and a, a
    jr nz, Jump_0F2_64DE
    ld de, Data_0F2_6526
    ld a, $01
    jr Jump_0F2_64E2

Jump_0F2_64DE::
    ld de, Data_0F2_6586
    xor a, a

Jump_0F2_64E2::
    ld [wCF8B], a
    ld b, $00

Jump_0F2_64E7::
    ld a, [de]
    cp a, $FF
    jr z, Jump_0F2_6517
    ld c, a
    push de
    ld hl, wC635
    ld d, $64

Jump_0F2_64F3::
    ld a, [hl]
    cp a, c
    jr z, Jump_0F2_6500
    inc hl
    inc hl
    dec d
    jr nz, Jump_0F2_64F3

Jump_0F2_64FC::
    pop de
    inc de
    jr Jump_0F2_64E7

Jump_0F2_6500::
    ld e, b
    ld d, $00
    sla e
    rl d
    push hl
    ld hl, wD09D
    add hl, de
    ld e, l
    ld d, h
    pop hl
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc b
    jr Jump_0F2_64FC

Jump_0F2_6517::
    ld hl, wD09D
    ld de, wC635
    ld b, $C8

Jump_0F2_651F::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_0F2_651F
    ret

Data_0F2_6526:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $3CA526, $60

Data_0F2_6586:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $3CA586, $60

Func_0F2_65E6::
    ld a, [wC6FD]
    and a, a
    ret z
    ld b, a
    ld hl, wC6FE

Jump_0F2_65EF::
    push bc
    push hl
    ld a, [hl]
    ld c, $5B
    call Func_000_1FD1
    ld a, [hl+]
    ld [wCF8B], a
    ld a, [hl]
    ld [wCF8C], a
    pop hl
    push hl
    ld a, [hl]
    ld c, $5D
    call Func_000_1FD1
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    ld a, [wCF8B]
    ld e, a
    ld a, [wCF8C]
    ld d, a
    ld a, l
    ld [wCF8B], a
    ld a, h
    ld [wCF8C], a
    call Func_0F2_667D
    ld a, c
    and a, a
    jr nz, Jump_0F2_6632
    pop hl
    push hl
    ld a, [hl]
    ld c, $5B
    call Func_000_1FD1
    ld a, [wCF8B]
    ld [hl+], a
    ld a, [wCF8C]
    ld [hl], a

Jump_0F2_6632::
    pop hl
    push hl
    ld a, [hl]
    ld c, $5F
    call Func_000_1FD1
    ld a, [hl+]
    ld [wCF8B], a
    ld a, [hl]
    ld [wCF8C], a
    pop hl
    push hl
    ld a, [hl]
    ld c, $61
    call Func_000_1FD1
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    ld a, [wCF8B]
    ld e, a
    ld a, [wCF8C]
    ld d, a
    ld a, l
    ld [wCF8B], a
    ld a, h
    ld [wCF8C], a
    call Func_0F2_667D
    ld a, c
    and a, a
    jr nz, Jump_0F2_6675
    pop hl
    push hl
    ld a, [hl]
    ld c, $5F
    call Func_000_1FD1
    ld a, [wCF8B]
    ld [hl+], a
    ld a, [wCF8C]
    ld [hl], a

Jump_0F2_6675::
    pop hl
    inc hl
    pop bc
    dec b
    jp nz, Jump_0F2_65EF
    ret

Func_0F2_667D::
    ld a, h
    cp a, d
    jr c, Jump_0F2_668C
    jr nz, Jump_0F2_6689
    ld a, l
    cp a, e
    jr c, Jump_0F2_668C
    jr z, Jump_0F2_668F

Jump_0F2_6689::
    ld c, $FF
    ret

Jump_0F2_668C::
    ld c, $00
    ret

Jump_0F2_668F::
    ld c, $01
    ret

Func_0F2_6692::
    ld hl, wD580
    ld bc, $020F

Jump_0F2_6698::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_0F2_6698
    ret
    ds $1960, $00
