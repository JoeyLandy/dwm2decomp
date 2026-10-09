SECTION "Bank F0", ROMX[$4000], BANK[$F0]
    db $F0

Func_0F0_4001::
    ld de, Data_0F0_4016
    call Func_000_25C9
    ret
    db $11, $16, $40, $CD, $FE, $25, $C9, $CD, $01, $40, $CD, $11, $26, $C9

Data_0F0_4016:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $18, $40, $A2, $40, $DA, $40, $FB, $40, $1E, $41, $65, $41, $84, $41, $BA, $41
    db $D9, $41, $FE, $41, $19, $42, $3C, $42, $44, $42, $53, $42, $72, $42, $95, $42

Data_0F0_4036:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $3C0036, $86A

Func_0F0_48A0::
    ld de, Data_0F0_48B5
    call Func_000_25C9
    ret
    db $11, $B5, $48, $CD, $FE, $25, $C9

Func_0F0_48AE::
    call Func_0F0_48A0
    call Func_000_2611
    ret

Data_0F0_48B5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_0F0_48B7

Data_0F0_48B7:: ; heuristic: target of a monotone pointer table; C0
    dw Data_0F0_48FD
    dw Data_0F0_491A
    dw Data_0F0_4933
    dw Data_0F0_4954
    dw Data_0F0_4973
    dw Data_0F0_4998
    dw Data_0F0_49BB
    dw Data_0F0_49DA
    dw Data_0F0_49FD
    dw Data_0F0_4A0B
    dw Data_0F0_4A23
    dw Data_0F0_4A3E
    dw Data_0F0_4A5A
    dw Data_0F0_4AAF
    dw Data_0F0_4B05
    dw Data_0F0_4B43
    dw Data_0F0_4B43
    dw Data_0F0_4B43
    dw Data_0F0_4B57
    dw Data_0F0_4B65
    dw Data_0F0_4B89
    dw Data_0F0_4BC8
    dw Data_0F0_4C00
    dw Data_0F0_4C1E
    dw Data_0F0_4C1E
    dw Data_0F0_4C1E
    dw Data_0F0_4C1E
    dw Data_0F0_4C1E
    dw Data_0F0_4C27
    dw Data_0F0_4C32
    dw Data_0F0_4C3D
    dw Data_0F0_4C44
    dw Data_0F0_4C4A
    dw Data_0F0_4C67
    dw Data_0F0_4C83

Data_0F0_48FD:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $18, $25, $37, $24, $2C, $31, $90, $24, $90, $0D, $35, $28, $24, $30, $90
    db $0E, $2A, $2A, $F1, $29, $35, $32, $30, $90, $F9, $30, $98, $F0

Data_0F0_491A:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $10, $2C, $39, $28, $90, $24, $90, $0D, $35, $28, $24, $30, $90, $0E, $2A
    db $2A, $F1, $37, $32, $90, $F9, $30, $98, $F0

Data_0F0_4933:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $1B, $28, $29, $38, $36, $28, $27, $90, $37, $32, $90, $24, $26, $26, $28
    db $33, $37, $F1, $24, $90, $0D, $35, $28, $24, $30, $90, $0E, $2A, $2A, $B5, $F7
    db $F0

Data_0F0_4954:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $22, $32, $38, $35, $90, $0D, $35, $28, $24, $30, $90, $0E, $2A, $2A, $90
    db $3A, $24, $36, $F1, $35, $28, $2D, $28, $26, $37, $28, $27, $B5, $F7, $F0

Data_0F0_4973:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $0C, $2B, $32, $32, $36, $28, $90, $37, $2B, $28, $90, $2E, $2C, $31, $27
    db $90, $32, $29, $F1, $28, $2A, $2A, $90, $37, $32, $90, $37, $35, $24, $31, $36
    db $29, $28, $35, $B5, $F0

Data_0F0_4998:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $0C, $2B, $32, $32, $36, $28, $90, $37, $2B, $28, $90, $28, $2A, $2A, $90
    db $37, $32, $F1, $25, $28, $90, $37, $35, $24, $31, $36, $29, $28, $35, $35, $28
    db $27, $B5, $F0

Data_0F0_49BB:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $12, $36, $90, $2C, $37, $90, $18, $14, $90, $37, $32, $F1, $37, $35, $24
    db $31, $36, $29, $28, $35, $90, $37, $2B, $28, $90, $28, $2A, $2A, $98, $F0

Data_0F0_49DA:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $18, $14, $90, $37, $32, $90, $36, $24, $39, $28, $90, $37, $2B, $28, $90
    db $28, $2A, $2A, $F1, $37, $35, $24, $27, $28, $90, $35, $28, $36, $38, $2F, $37
    db $36, $98, $F0

Data_0F0_49FD:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $19, $2F, $28, $24, $36, $28, $90, $3A, $24, $2C, $37, $A4, $F0

Data_0F0_4A0B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $F9, $00, $90, $35, $28, $26, $28, $2C, $39, $28, $27, $F1, $3C, $32, $38
    db $35, $90, $28, $2A, $2A, $B5, $F7, $F0

Data_0F0_4A23:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $18, $25, $37, $24, $2C, $31, $28, $27, $90, $24, $31, $90, $28, $2A, $2A
    db $F1, $29, $35, $32, $30, $90, $F9, $00, $B5, $F7, $F0

Data_0F0_4A3E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $0E, $2A, $2A, $36, $90, $3A, $28, $35, $28, $90, $37, $35, $24, $27, $28
    db $27, $F1, $3A, $2C, $37, $2B, $90, $F9, $00, $B5, $F7, $F0

Data_0F0_4A5A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $3C0A5A, $55

Data_0F0_4AAF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $3C0AAF, $56

Data_0F0_4B05:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $F9, $00, $90, $35, $28, $26, $28, $2C, $39, $28, $27, $F1, $F9, $10, $95
    db $36, $90, $28, $2A, $2A, $B5, $FA, $F7, $EF, $EE, $19, $2F, $28, $24, $36, $28
    db $90, $35, $24, $2C, $36, $28, $90, $2C, $37, $EF, $EE, $3A, $2C, $37, $2B, $90
    db $2F, $32, $39, $2C, $31, $2A, $90, $26, $24, $35, $28, $B5, $F7, $F0

Data_0F0_4B43:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $22, $32, $38, $90, $2B, $24, $39, $28, $90, $31, $32, $90, $28, $2A, $2A
    db $36, $B5, $F7, $F0

Data_0F0_4B57:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $19, $2F, $28, $24, $36, $28, $90, $3A, $24, $2C, $37, $A4, $F0

Data_0F0_4B65:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $F9, $30, $90, $2B, $24, $36, $90, $31, $32, $90, $0D, $35, $28, $24, $30
    db $F1, $0E, $2A, $2A, $90, $37, $32, $90, $37, $35, $24, $27, $28, $90, $3C, $32
    db $38, $B5, $F7, $F0

Data_0F0_4B89:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $1D, $2B, $28, $35, $28, $90, $2C, $36, $90, $31, $32, $90, $30, $32, $35
    db $28, $F1, $35, $32, $32, $30, $90, $29, $32, $35, $90, $28, $2A, $2A, $36, $B5
    db $FA, $F7, $EF, $EE, $1D, $35, $24, $27, $2C, $31, $2A, $90, $2C, $36, $90, $31
    db $32, $37, $EF, $EE, $33, $32, $36, $36, $2C, $25, $2F, $28, $B5, $F7, $F0

Data_0F0_4BC8:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $22, $32, $38, $90, $2B, $24, $39, $28, $90, $24, $31, $90, $28, $2A, $2A
    db $F1, $24, $2F, $35, $28, $24, $27, $3C, $B5, $FA, $F7, $EF, $EE, $1D, $35, $24
    db $27, $2C, $31, $2A, $90, $2C, $36, $90, $31, $32, $37, $EF, $EE, $33, $32, $36
    db $36, $2C, $25, $2F, $28, $B5, $F7, $F0

Data_0F0_4C00:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $F9, $30, $90, $24, $2F, $35, $28, $24, $27, $3C, $90, $2B, $24, $36, $F1
    db $24, $90, $0D, $35, $28, $24, $30, $90, $0E, $2A, $2A, $B5, $F7, $F0

Data_0F0_4C1E:: ; heuristic: target of a monotone pointer table; C0
    db $10, $2C, $29, $37, $0E, $3B, $2C, $37, $F0

Data_0F0_4C27:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $32, $35, $28, $90, $90, $10, $28, $37, $F0

Data_0F0_4C32:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $2F, $2F, $3C, $90, $1C, $37, $32, $35, $28, $F0

Data_0F0_4C3D:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $29, $32, $18, $14, $F0

Data_0F0_4C44:: ; heuristic: target of a monotone pointer table; C0
    db $22, $28, $36, $17, $32, $F0

Data_0F0_4C4A:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2B, $32, $32, $36, $28, $90, $3A, $2B, $24, $37, $90, $37, $32, $F1, $2A
    db $2C, $39, $28, $90, $37, $2B, $28, $90, $28, $2A, $2A, $B5, $F0

Data_0F0_4C67:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $20, $90, $2C, $36, $90, $2C, $31, $F1, $29, $35, $32, $31, $37, $90, $32
    db $29, $90, $37, $2B, $28, $90, $28, $2A, $2A, $B5, $F7, $F0

Data_0F0_4C83:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $20, $90, $26, $24, $31, $41, $90, $25, $28, $F1, $2A, $2C, $39, $28, $31
    db $90, $37, $32, $90, $24, $31, $90, $28, $2A, $2A, $B5, $F7, $F0

Func_0F0_4CA0::
    ld a, $01
    ld [$D06A], a
    ld a, [$C56C]
    and a, a
    ret nz
    ld a, [$D780]
    cp a, $04
    jr z, Jump_0F0_4CB7
    ld a, [$C52B]
    bit 0, a
    ret nz

Jump_0F0_4CB7::
    ld a, [$D780]
    rst $00
    dw Jump_0F0_4CD5
    dw Jump_0F0_4E54
    dw Jump_0F0_4E71
    dw Jump_0F0_4FED
    dw Jump_0F0_4FF1
    dw Jump_0F0_507B
    dw Jump_0F0_51B8
    dw Jump_0F0_54FA
    dw Jump_0F0_55FB
    dw Jump_0F0_565E
    dw Jump_0F0_56F8
    dw Jump_0F0_5967
    dw Jump_0F0_5ACE

Jump_0F0_4CD5::
    ld a, [$C58F]
    cp a, $BD
    jr nz, Jump_0F0_4CEE
    xor a, a
    ld [$D781], a
    ld [$D782], a
    ld a, $04
    ld [$D780], a
    ld a, $BB
    ld [$C594], a
    ret

Jump_0F0_4CEE::
    ld a, [$D781]
    rst $00
    dw Jump_0F0_4D02
    dw Jump_0F0_4D0F
    dw Jump_0F0_4D21
    dw Jump_0F0_4D70
    dw Jump_0F0_4D86
    dw Jump_0F0_4DA4
    dw Jump_0F0_4DF0
    dw Jump_0F0_4E11

Jump_0F0_4D02::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ld a, $BA
    ld [$C594], a
    ret

Jump_0F0_4D0F::
    ld a, [$C58F]
    cp a, $BA
    ret nz
    xor a, a
    ld [$C594], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F0_4D21::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ld hl, $C60C
    ld de, $C597
    ld c, $0A

Jump_0F0_4D30::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_0F0_4D3B
    ld [de], a
    inc hl
    inc de
    dec c
    jr nz, Jump_0F0_4D30

Jump_0F0_4D3B::
    ld a, $F0
    ld [de], a
    ld a, [$C616]
    ld [$C5A3], a
    ld hl, $000C
    ld a, l
    ld [$C592], a
    ld a, h
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
    ld a, $FF
    ld [$C594], a
    ld a, $01
    ld [$C58C], a
    ret

Jump_0F0_4D70::
    ld a, [$C58F]
    cp a, $F0
    ret nz
    xor a, a
    ld [$C594], a
    xor a, a
    ld [$C58C], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F0_4D86::
    ld hl, $C5B7
    ld de, $C160
    ld c, $0A

Jump_0F0_4D8E::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_0F0_4D99
    ld [de], a
    inc de
    inc hl
    dec c
    jr nz, Jump_0F0_4D8E

Jump_0F0_4D99::
    ld a, $F0
    ld [de], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F0_4DA4::
    ld hl, $CF73
    ld b, $35

Jump_0F0_4DA9::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_0F0_4DA9
    xor a, a
    ld [$C528], a
    ld a, $1F
    ld [$C529], a
    ld hl, $9700
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0501
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    call Func_0F0_48AE
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, [$CECE]
    and a, a
    jr z, Jump_0F0_4DE7
    ld a, $01
    jr Jump_0F0_4DE8

Jump_0F0_4DE7::
    xor a, a

Jump_0F0_4DE8::
    call Func_0F0_5DDD
    ld hl, $D781
    inc [hl]
    ret

Jump_0F0_4DF0::
    ld de, Data_0F0_663F
    ld hl, $C412
    ld bc, $0605
    call Func_0F0_62B8
    call Func_0F0_632F
    ld bc, $140D
    ld de, $01CC
    call Func_0F0_62F2
    xor a, a
    ld [$D7B7], a
    ld hl, $D781
    inc [hl]
    ret

Jump_0F0_4E11::
    ld a, $02
    ld [$D7F2], a
    call Func_0F0_6709
    ld a, [$D7F9]
    cp a, $FF
    jr z, Jump_0F0_4E25
    cp a, $FE
    jr z, Jump_0F0_4E3D
    ret

Jump_0F0_4E25::
    ld a, [$D7B7]
    and a, a
    jr nz, Jump_0F0_4E3D
    xor a, a
    ld [$D781], a
    ld [$D782], a
    ld a, $05
    ld [$D780], a
    ld a, $07
    call Func_0F0_5DDD
    ret

Jump_0F0_4E3D::
    xor a, a
    ld [$D781], a
    ld [$D782], a
    ld a, $04
    ld [$D780], a
    ld a, $08
    call Func_0F0_5DDD
    ld a, $BD
    ld [$C594], a
    ret

Jump_0F0_4E54::
    ld a, [$C58F]
    cp a, $BD
    jr nz, Jump_0F0_4E6D
    xor a, a
    ld [$D781], a
    ld [$D782], a
    ld a, $04
    ld [$D780], a
    ld a, $BB
    ld [$C594], a
    ret

Jump_0F0_4E6D::
    call Func_0F0_5B50
    ret

Jump_0F0_4E71::
    ld a, [$C58F]
    cp a, $BD
    jr nz, Jump_0F0_4E8A
    xor a, a
    ld [$D781], a
    ld [$D782], a
    ld a, $04
    ld [$D780], a
    ld a, $BB
    ld [$C594], a
    ret

Jump_0F0_4E8A::
    ld a, [$D781]
    rst $00
    dw Jump_0F0_4E9A
    dw Jump_0F0_4EA4
    dw Jump_0F0_4EFE
    dw Jump_0F0_4F22
    dw Jump_0F0_4F64
    dw Jump_0F0_4FBB

Jump_0F0_4E9A::
    ld a, $06
    call Func_0F0_5DDD
    ld hl, $D781
    inc [hl]
    ret

Jump_0F0_4EA4::
    ld de, Data_0F0_665D
    ld hl, $C410
    ld bc, $0805
    call Func_0F0_62B8
    ld a, [$D7AB]
    ld b, $BC
    ld hl, Data_0F0_6526
    call Func_0F0_66FB
    call Func_0F0_632F
    ld bc, $140D
    ld de, $01CC
    call Func_0F0_62F2
    xor a, a
    ld [$C528], a
    ld a, $1E
    ld [$C529], a
    ld hl, $9700
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0901
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    call Func_0F0_48AE
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

Jump_0F0_4EFE::
    ld de, Data_0F0_6617
    ld hl, $C410
    ld bc, $0805
    call Func_0F0_62B8
    call Func_0F0_632F
    ld bc, $140D
    ld de, $01CC
    call Func_0F0_62F2
    xor a, a
    ld [$D7B7], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F0_4F22::
    xor a, a
    ld [$D7F2], a
    call Func_0F0_6709
    ld a, [$D7F9]
    cp a, $FF
    jr z, Jump_0F0_4F35
    cp a, $FE
    jr z, Jump_0F0_4F5A
    ret

Jump_0F0_4F35::
    ld a, [$D7B7]
    and a, a
    jr nz, Jump_0F0_4F47
    xor a, a
    ld [$D781], a
    ld [$D782], a
    ld hl, $D780
    inc [hl]
    ret

Jump_0F0_4F47::
    ld a, $07
    call Func_0F0_5DDD
    xor a, a
    ld [$D781], a
    ld a, $05
    ld [$D780], a
    xor a, a
    ld [$D7EC], a
    ret

Jump_0F0_4F5A::
    ld a, $05
    call Func_0F0_5DDD
    ld hl, $D781
    inc [hl]
    ret

Jump_0F0_4F64::
    ld de, Data_0F0_6685
    ld hl, $C410
    ld bc, $0805
    call Func_0F0_62B8
    ld a, [$D7AB]
    ld b, $C3
    ld hl, Data_0F0_6526
    call Func_0F0_66FB
    call Func_0F0_632F
    ld bc, $140D
    ld de, $01CC
    call Func_0F0_62F2
    xor a, a
    ld [$C528], a
    ld a, $1D
    ld [$C529], a
    ld hl, $9700
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0701
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    call Func_0F0_48AE
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

Jump_0F0_4FBB::
    ld de, Data_0F0_65FB
    ld hl, $C425
    ld bc, $0704
    call Func_0F0_62B8
    ld a, [$D7B7]
    ld b, $BC
    ld hl, Data_0F0_6522
    call Func_0F0_66FB
    call Func_0F0_632F
    ld bc, $140D
    ld de, $01CC
    call Func_0F0_62F2
    xor a, a
    ld [$D782], a
    ld a, $01
    ld [$D780], a
    ld a, $06
    ld [$D781], a
    ret

Jump_0F0_4FED::
    call Func_0F0_5DE8
    ret

Jump_0F0_4FF1::
    ld a, [$D781]
    rst $00
    dw Jump_0F0_5028
    dw Jump_0F0_4FFD
    dw Jump_0F0_5010
    dw Jump_0F0_5055

Jump_0F0_4FFD::
    ld a, [$C52B]
    bit 0, a
    ret nz
    ld a, $01
    ld [$C594], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F0_5010::
    ld a, [$C52B]
    bit 0, a
    ret nz
    ld a, [$C58F]
    cp a, $01
    ret nz
    xor a, a
    ld [$C594], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F0_5028::
    ld a, [$C58F]
    cp a, $BB
    jr z, Jump_0F0_5046
    cp a, $BD
    ret nz
    ld a, [$C594]
    cp a, $BB
    jr z, Jump_0F0_5042
    ld a, [$C57F]
    bit 1, a
    jr nz, Jump_0F0_5042
    jr Jump_0F0_5046

Jump_0F0_5042::
    ld b, $03
    jr Jump_0F0_5048

Jump_0F0_5046::
    ld b, $02

Jump_0F0_5048::
    xor a, a
    ld [$C594], a
    ld a, b
    call Func_0F0_5DDD
    ld hl, $D781
    inc [hl]
    ret

Jump_0F0_5055::
    ld a, [$C52B]
    bit 0, a
    ret nz
    ld hl, $D780
    ld bc, $006F

Jump_0F0_5061::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_0F0_5061
    xor a, a
    ldh [$FF70], a
    ld a, $05
    ld [$C5DB], a
    ld a, $01
    ld [$C5DC], a
    ld a, $01
    ld [$C5DF], a
    ret

Jump_0F0_507B::
    ld a, [$C58F]
    cp a, $BD
    jr nz, Jump_0F0_5094
    xor a, a
    ld [$D781], a
    ld [$D782], a
    ld a, $04
    ld [$D780], a
    ld a, $BB
    ld [$C594], a
    ret

Jump_0F0_5094::
    ld a, [$D781]
    rst $00
    dw Jump_0F0_50D7
    dw Jump_0F0_50A4
    dw Jump_0F0_50AF
    dw Jump_0F0_50BF
    dw Jump_0F0_5155
    dw Jump_0F0_5176

Jump_0F0_50A4::
    ld hl, Func_015_645F
    ld b, $15
    rst $10
    ld hl, $D781
    inc [hl]
    ret

Jump_0F0_50AF::
    ld hl, Func_015_6B00
    ld b, $15
    rst $10
    ld hl, $D781
    inc [hl]
    ld a, $01
    ld [$D7DC], a
    ret

Jump_0F0_50BF::
    ld hl, Func_015_642D
    ld b, $15
    rst $10
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

Jump_0F0_50D7::
    ld c, $09
    ld hl, $01D3
    ld de, $0007
    xor a, a
    ld [$D7F1], a
    ld a, $0D
    ld [$D7F2], a
    call Func_0F0_63EE
    ld de, Data_01F_4A60
    ld hl, $8EA0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4A40
    ld hl, $8ED0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_0F0_66AD
    ld hl, $C410
    ld bc, $0805
    call Func_0F0_62B8
    call Func_0F0_632F
    ld bc, $140D
    ld de, $01CC
    call Func_0F0_62F2
    xor a, a
    ld [$C528], a
    ld a, $1F
    ld [$C529], a
    ld hl, $9700
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0501
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    call Func_0F0_48AE
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [$D7B7], a
    ld hl, $D781
    inc [hl]
    ret

Jump_0F0_5155::
    ld de, Data_0F0_663F
    ld hl, $C412
    ld bc, $0605
    call Func_0F0_62B8
    call Func_0F0_632F
    ld bc, $140D
    ld de, $01CC
    call Func_0F0_62F2
    xor a, a
    ld [$D7B7], a
    ld hl, $D781
    inc [hl]
    ret

Jump_0F0_5176::
    ld a, $02
    ld [$D7F2], a
    call Func_0F0_6709
    ld a, [$D7F9]
    cp a, $FF
    jr z, Jump_0F0_518A
    cp a, $FE
    jr z, Jump_0F0_51A1
    ret

Jump_0F0_518A::
    ld a, [$D7B7]
    and a, a
    jr nz, Jump_0F0_51A1
    xor a, a
    ld [$D781], a
    ld [$D782], a
    ld a, $08
    call Func_0F0_5DDD
    ld hl, $D780
    inc [hl]
    ret

Jump_0F0_51A1::
    xor a, a
    ld [$D781], a
    ld [$D782], a
    ld a, $04
    ld [$D780], a
    ld a, $08
    call Func_0F0_5DDD
    ld a, $BD
    ld [$C594], a
    ret

Jump_0F0_51B8::
    ld a, [$C58F]
    cp a, $BD
    jr nz, Jump_0F0_51D1
    xor a, a
    ld [$D781], a
    ld [$D782], a
    ld a, $04
    ld [$D780], a
    ld a, $BB
    ld [$C594], a
    ret

Jump_0F0_51D1::
    ld a, [$D781]
    rst $00
    dw Jump_0F0_5398
    dw Jump_0F0_5379
    dw Jump_0F0_5386
    dw Jump_0F0_53B9
    dw Jump_0F0_53EC
    dw Jump_0F0_5402
    dw Jump_0F0_5433
    dw Jump_0F0_5379
    dw Jump_0F0_5386
    dw Jump_0F0_527B
    dw Jump_0F0_53EC
    dw Jump_0F0_5379
    dw Jump_0F0_5386
    dw Jump_0F0_52B9
    dw Jump_0F0_53EC
    dw Jump_0F0_5379
    dw Jump_0F0_5386
    dw Jump_0F0_52EC
    dw Jump_0F0_53EC
    dw Jump_0F0_5447
    dw Jump_0F0_546E
    dw Jump_0F0_520D
    dw Jump_0F0_522C
    dw Jump_0F0_54B9
    dw Jump_0F0_521A
    dw Jump_0F0_523E
    dw Jump_0F0_5250
    dw Jump_0F0_525D

Jump_0F0_520D::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ld a, $B3
    ld [$C594], a
    ret

Jump_0F0_521A::
    ld a, [$D7EE]
    and a, a
    ret nz
    ld a, [$D781]
    inc a
    ld [$D781], a
    ld a, $A8
    ld [$C594], a
    ret

Jump_0F0_522C::
    ld a, [$C58F]
    cp a, $B3
    ret nz
    xor a, a
    ld [$C594], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F0_523E::
    ld a, [$C58F]
    cp a, $A8
    ret nz
    xor a, a
    ld [$C594], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F0_5250::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ld a, $B6
    ld [$C594], a
    ret

Jump_0F0_525D::
    ld a, [$C58F]
    cp a, $B6
    ret nz
    xor a, a
    ld [$C594], a
    ld a, [$D7EC]
    ld b, a
    ld a, [$D780]
    add a, b
    inc a
    ld [$D780], a
    xor a, a
    ld [$D781], a
    ld [$D782], a
    ret

Jump_0F0_527B::
    ld a, [$CECE]
    and a, a
    jr nz, Jump_0F0_5286
    ld hl, Data_0F0_6A58
    jr Jump_0F0_5289

Jump_0F0_5286::
    ld hl, $CECE

Jump_0F0_5289::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ld a, l
    ld [$C595], a
    ld a, h
    ld [$C596], a
    ld hl, $00A5
    ld a, l
    ld [$C592], a
    ld a, h
    ld [$C593], a
    ld hl, $C986
    ld a, l
    ld [$C590], a
    ld a, h
    ld [$C591], a
    ld a, $FF
    ld [$C594], a
    ld a, $01
    ld [$C58C], a
    ret

Jump_0F0_52B9::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ld hl, $CE9B
    ld a, l
    ld [$C595], a
    ld a, h
    ld [$C596], a
    ld hl, $00D8
    ld a, l
    ld [$C592], a
    ld a, h
    ld [$C593], a
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

Jump_0F0_52EC::
    ld de, $0000
    call Func_000_181B
    jr c, Jump_0F0_52F7
    xor a, a
    jr Jump_0F0_52F9

Jump_0F0_52F7::
    ld a, $01

Jump_0F0_52F9::
    ld [$C5A7], a
    ld a, [$C599]
    and a, a
    jp z, Jump_0F0_5323
    call Func_0F0_6BE0
    call Func_0F0_6BA1
    ld a, [$CE9E]
    ld c, a
    ld a, [$CF8A]
    ld b, a
    ld a, $08
    sub a, b
    call Func_000_1682
    ld a, $05
    call Func_000_16D1
    ld a, l
    ld [$CE9E], a
    call Func_0F0_6AFE

Jump_0F0_5323::
    ld a, [$CED9]
    ld [$C5A8], a
    ld a, [$CEDA]
    ld [$C5A9], a
    ld a, [$CEDB]
    ld [$C5AA], a
    ld hl, $C60C
    ld de, $C5AB
    ld b, $0A

Jump_0F0_533D::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_0F0_533D
    ld a, $F0
    ld [de], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ld hl, $C5A7
    ld a, l
    ld [$C595], a
    ld a, h
    ld [$C596], a
    ld hl, $0010
    ld a, l
    ld [$C592], a
    ld a, h
    ld [$C593], a
    ld hl, $C5C7
    ld a, l
    ld [$C590], a
    ld a, h
    ld [$C591], a
    ld a, $FF
    ld [$C594], a
    ld a, $00
    ld [$C58C], a
    ret

Jump_0F0_5379::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ld a, $BA
    ld [$C594], a
    ret

Jump_0F0_5386::
    ld a, [$C58F]
    cp a, $BA
    ret nz
    xor a, a
    ld [$C594], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F0_5398::
    ld a, [$D7EC]
    ld [$C597], a
    ld a, [$CECE]
    ld [$C598], a
    ld a, [$C5A3]
    ld b, a
    call Func_0F0_7245
    call Func_0F0_7E69
    ld [$C599], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F0_53B9::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ld hl, $0003
    ld a, l
    ld [$C592], a
    ld a, h
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
    ld a, $FF
    ld [$C594], a
    ld a, $01
    ld [$C58C], a
    ret

Jump_0F0_53EC::
    ld a, [$C58F]
    cp a, $F0
    ret nz
    xor a, a
    ld [$C594], a
    xor a, a
    ld [$C58C], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F0_5402::
    ld a, [$CECE]
    and a, a
    jr nz, Jump_0F0_5410
    ld a, [$C5B8]
    and a, a
    jr z, Jump_0F0_5429
    jr Jump_0F0_5416

Jump_0F0_5410::
    ld a, [$C5B8]
    and a, a
    jr nz, Jump_0F0_541F

Jump_0F0_5416::
    ld a, [$D781]
    add a, $02
    ld [$D781], a
    ret

Jump_0F0_541F::
    ld a, $16
    call Func_0F0_5DDD
    ld hl, $D781
    inc [hl]
    ret

Jump_0F0_5429::
    ld a, $13
    call Func_0F0_5DDD
    ld hl, $D781
    inc [hl]
    ret

Jump_0F0_5433::
    ld a, $12
    call Func_0F0_5DDD
    xor a, a
    ld [$D782], a
    ld a, $01
    ld [$D781], a
    ld a, $04
    ld [$D780], a
    ret

Jump_0F0_5447::
    ld a, [$C599]
    and a, a
    jr nz, Jump_0F0_545D
    ld a, [$C5B9]
    and a, a
    jr nz, Jump_0F0_5461
    ld a, [$CECE]
    and a, a
    jr nz, Jump_0F0_5465
    ld a, $01
    jr Jump_0F0_5466

Jump_0F0_545D::
    ld a, $03
    jr Jump_0F0_5466

Jump_0F0_5461::
    ld a, $04
    jr Jump_0F0_5466

Jump_0F0_5465::
    xor a, a

Jump_0F0_5466::
    ld [$D7EC], a
    ld hl, $D781
    inc [hl]
    ret

Jump_0F0_546E::
    ld a, [$D7EC]
    and a, a
    jr z, Jump_0F0_5483
    cp a, $01
    jr z, Jump_0F0_548F
    cp a, $02
    jr z, Jump_0F0_548F
    cp a, $03
    jp z, Jump_0F0_54B0
    jr Jump_0F0_54B0

Jump_0F0_5483::
    ld hl, $CE9B
    ld b, $D8

Jump_0F0_5488::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_0F0_5488
    jr Jump_0F0_54B0

Jump_0F0_548F::
    ld hl, $C986
    ld a, $01
    ld [hl], a
    ld de, $CECE
    ld b, $A5

Jump_0F0_549A::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_0F0_549A
    ld hl, $CA2B
    ld de, $CE9B
    ld b, $33

Jump_0F0_54A8::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_0F0_54A8
    jr Jump_0F0_54B0

Jump_0F0_54B0::
    ld hl, $D781
    inc [hl]
    xor a, a
    ld [$D7DC], a
    ret

Jump_0F0_54B9::
    call Func_0F0_632F
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
    ld hl, Func_01F_5D9A
    ld b, $1F
    rst $10
    call Func_0F0_67D2
    xor a, a
    ldh [$FFB9], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ld a, [$C524]
    and a, a
    jr z, Jump_0F0_54F9
    ld a, $02
    ret

Jump_0F0_54F9::
    ret

Jump_0F0_54FA::
    ld a, [$D782]
    rst $00
    dw Jump_0F0_557E
    dw Jump_0F0_5537
    dw Jump_0F0_557E
    dw Jump_0F0_5594
    dw Jump_0F0_5558
    dw Jump_0F0_557E
    dw Jump_0F0_557E
    dw Jump_0F0_55A6
    dw Jump_0F0_557E
    dw Jump_0F0_557E
    dw Jump_0F0_55B6
    dw Jump_0F0_55DC
    dw Jump_0F0_5518

Jump_0F0_5518::
    ld a, [$C52B]
    bit 0, a
    ret nz
    ld hl, Func_002_7333
    ld b, $02
    rst $10
    ld a, [$C8C3]
    bit 7, a
    ret z
    xor a, a
    ld [$D781], a
    ld [$D782], a
    ld a, $0C
    ld [$D780], a
    ret

Jump_0F0_5537::
    ld a, [$CB88]
    and a, $03
    and a, a
    ret z
    ld a, [$CB8A]
    inc a
    ld [$CB8A], a
    cp a, $38
    ret nz
    ld a, [$CB8C]
    set 1, a
    ld [$CB8C], a
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_0F0_5558::
    ld a, [$CB98]
    and a, $03
    and a, a
    ret z
    ld a, [$CB9A]
    dec a
    ld [$CB9A], a
    cp a, $59
    ret nc
    ld a, $58
    ld [$CB9A], a
    ld a, [$CB9C]
    set 1, a
    ld [$CB9C], a
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_0F0_557E::
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

Jump_0F0_5594::
    ld a, $80
    ld [$CBCF], a
    ld a, $01
    ld [$D7F1], a
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_0F0_55A6::
    ld a, $00
    ld [$CBCF], a
    ld [$D7F1], a
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_0F0_55B6::
    ld a, [$CB9C]
    res 1, a
    ld [$CB9C], a
    ld a, $01
    ld [$CB96], a
    ld a, [$CB98]
    and a, $03
    and a, a
    ret z
    ld a, [$CB9A]
    inc a
    ld [$CB9A], a
    cp a, $E0
    ret nz
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_0F0_55DC::
    call Func_0F0_622A
    ld hl, $C5CB
    ld de, $C130
    ld b, $0A
    call Func_0F0_5B42
    ld a, $09
    call Func_0F0_5DDD
    ld hl, $D782
    inc [hl]
    xor a, a
    ld [$C8C3], a
    ld [$C8C4], a
    ret

Jump_0F0_55FB::
    ld a, [$D782]
    rst $00
    dw Jump_0F0_557E
    dw Jump_0F0_5558
    dw Jump_0F0_557E
    dw Jump_0F0_5594
    dw Jump_0F0_5537
    dw Jump_0F0_557E
    dw Jump_0F0_557E
    dw Jump_0F0_55A6
    dw Jump_0F0_557E
    dw Jump_0F0_557E
    dw Jump_0F0_5619
    dw Jump_0F0_563F
    dw Jump_0F0_5518

Jump_0F0_5619::
    ld a, [$CB8C]
    res 1, a
    ld [$CB8C], a
    ld a, $03
    ld [$CB86], a
    ld a, [$CB88]
    and a, $03
    and a, a
    ret z
    ld a, [$CB8A]
    dec a
    ld [$CB8A], a
    cp a, $E0
    ret nz
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_0F0_563F::
    call Func_0F0_622A
    ld hl, $C5CB
    ld de, $C130
    ld b, $0A
    call Func_0F0_5B42
    ld a, $0A
    call Func_0F0_5DDD
    ld hl, $D782
    inc [hl]
    xor a, a
    ld [$C8C3], a
    ld [$C8C4], a
    ret

Jump_0F0_565E::
    ld a, [$D782]
    rst $00
    dw Jump_0F0_557E
    dw Jump_0F0_5537
    dw Jump_0F0_557E
    dw Jump_0F0_5594
    dw Jump_0F0_5558
    dw Jump_0F0_557E
    dw Jump_0F0_557E
    dw Jump_0F0_55A6
    dw Jump_0F0_557E
    dw Jump_0F0_557E
    dw Jump_0F0_5594
    dw Jump_0F0_557E
    dw Jump_0F0_557E
    dw Jump_0F0_55A6
    dw Jump_0F0_5684
    dw Jump_0F0_56D9
    dw Jump_0F0_5518

Jump_0F0_5684::
    ld a, [$CB8C]
    res 1, a
    ld [$CB8C], a
    ld a, [$CB9C]
    res 1, a
    ld [$CB9C], a
    call Func_0F0_56C2
    call Func_0F0_56A5
    cp a, $FF
    ret nz
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Func_0F0_56A5::
    ld a, $03
    ld [$CB86], a
    ld a, [$CB88]
    and a, $03
    and a, a
    jr z, Jump_0F0_56C0
    ld a, [$CB8A]
    dec a
    ld [$CB8A], a
    cp a, $E0
    jr nz, Jump_0F0_56C0
    ld a, $FF
    ret

Jump_0F0_56C0::
    xor a, a
    ret

Func_0F0_56C2::
    ld a, $01
    ld [$CB96], a
    ld a, [$CB98]
    and a, $03
    and a, a
    ret z
    ld a, [$CB9A]
    inc a
    ld [$CB9A], a
    cp a, $E0
    ret nz
    ret

Jump_0F0_56D9::
    call Func_0F0_622A
    ld hl, $C5CB
    ld de, $C130
    ld b, $0A
    call Func_0F0_5B42
    ld a, $0B
    call Func_0F0_5DDD
    ld hl, $D782
    inc [hl]
    xor a, a
    ld [$C8C3], a
    ld [$C8C4], a
    ret

Jump_0F0_56F8::
    ld a, [$D782]
    rst $00
    dw Jump_0F0_557E
    dw Jump_0F0_5537
    dw Jump_0F0_557E
    dw Jump_0F0_5594
    dw Jump_0F0_557E
    dw Jump_0F0_5558
    dw Jump_0F0_557E
    dw Jump_0F0_557E
    dw Jump_0F0_57F0
    dw Jump_0F0_583B
    dw Jump_0F0_58CD
    dw Jump_0F0_58FE
    dw Jump_0F0_557E
    dw Jump_0F0_557E
    dw Jump_0F0_557E
    dw Jump_0F0_5848
    dw Jump_0F0_557E
    dw Jump_0F0_5855
    dw Jump_0F0_557E
    dw Jump_0F0_5848
    dw Jump_0F0_557E
    dw Jump_0F0_5855
    dw Jump_0F0_557E
    dw Jump_0F0_5848
    dw Jump_0F0_557E
    dw Jump_0F0_557E
    dw Jump_0F0_5862
    dw Jump_0F0_557E
    dw Jump_0F0_590A
    dw Jump_0F0_557E
    dw Jump_0F0_593A
    dw Jump_0F0_5752
    dw Jump_0F0_5742
    dw Jump_0F0_5779
    dw Jump_0F0_5518

Jump_0F0_5742::
    ld a, [$D7EE]
    and a, a
    ret nz
    call Func_0F0_622A
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_0F0_5752::
    ld de, Data_0F0_68E6
    ld hl, $C364
    ld bc, $140D
    call Func_0F0_62B8
    ld a, [$D782]
    inc a
    ld [$D782], a
    xor a, a
    ld [$D092], a
    ld [$CB7D], a
    xor a, a
    ld [$CFA8], a
    ld [$CFA9], a
    ld a, $01
    ld [$D7EE], a
    ret

Jump_0F0_5779::
    ld a, [$D780]
    ld l, a
    ld a, [$D781]
    ld h, a
    ld a, [$D782]
    ld e, a
    push hl
    push de
    ld a, [$D7E8]
    ld [$D780], a
    ld a, [$D7E9]
    ld [$D781], a
    ld a, [$D7EA]
    ld [$D782], a
    ld hl, Func_024_4117
    ld b, $24
    rst $10
    ld a, [$D780]
    ld [$D7E8], a
    ld a, [$D781]
    ld [$D7E9], a
    ld a, [$D782]
    ld [$D7EA], a
    pop de
    pop hl
    ld a, l
    ld [$D780], a
    ld a, h
    ld [$D781], a
    ld a, e
    ld [$D782], a
    ld a, [$C5DF]
    and a, a
    ret z
    xor a, a
    ld [$C5DF], a
    ld a, $07
    ld [$C5DB], a
    ld a, $0A
    ld [$D780], a
    xor a, a
    ld [$D781], a
    ld a, $22
    ld [$D782], a
    ld hl, $CE9B
    ld bc, $00D8

Jump_0F0_57E1::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_0F0_57E1
    xor a, a
    ld [$C8C3], a
    ld [$C8C4], a
    ret

Jump_0F0_57F0::
    ld a, [$CB8C]
    res 1, a
    ld [$CB8C], a
    ld a, $03
    ld [$CB86], a
    ld a, [$CB88]
    and a, $03
    and a, a
    ret z
    ld a, [$CB8A]
    dec a
    ld [$CB8A], a
    cp a, $20
    ret nz
    ld a, $0E
    ldh [$FFC6], a
    ld hl, Func_012_6B98
    ld b, $12
    rst $10
    ld a, $48
    ld [$CBD3], a
    ld a, $40
    ld [$CBD4], a
    xor a, a
    ld [$D783], a
    ld a, [$CB8C]
    set 1, a
    ld [$CB8C], a
    ld a, $00
    ld [$CB86], a
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_0F0_583B::
    ld a, $01
    ld [$CB86], a
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_0F0_5848::
    ld a, $03
    ld [$CBA6], a
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_0F0_5855::
    ld a, $01
    ld [$CBA6], a
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_0F0_5862::
    ld a, [$CBAC]
    res 1, a
    ld [$CBAC], a
    ld a, $03
    ld [$CBA6], a
    ld a, [$CBA8]
    and a, $03
    and a, a
    ret z
    ld a, [$CBAA]
    dec a
    ld [$CBAA], a
    cp a, $30
    ret nz
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Func_0F0_5888:: ; heuristic: follows a terminator; C0
    ld a, [$CB98]
    and a, $03
    and a, a
    ret z
    ld a, [$CB9A]
    dec a
    ld [$CB9A], a
    cp a, $60
    jr nz, Jump_0F0_58B2
    ld a, $0E
    ldh [$FFC6], a
    ld hl, Func_012_6B98
    ld b, $12
    rst $10
    ld a, $48
    ld [$CBD3], a
    ld a, $40
    ld [$CBD4], a
    xor a, a
    ld [$D783], a

Jump_0F0_58B2::
    ld a, [$CB9A]
    cp a, $59
    ret nc
    ld a, $58
    ld [$CB9A], a
    ld a, [$CB9C]
    set 1, a
    ld [$CB9C], a
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_0F0_58CD::
    ld a, [$D783]
    cp a, $BA
    jr nz, Jump_0F0_58D9
    ld a, $74
    call Func_000_1278

Jump_0F0_58D9::
    ld a, [$D783]
    inc a
    ld [$D783], a
    cp a, $D9
    ret c
    xor a, a
    ld [$D783], a
    xor a, a
    ld [$CBCF], a
    ld a, [$CB7D]
    inc a
    ld [$CB7D], a
    ld a, [$D782]
    inc a
    ld [$D782], a
    xor a, a
    ld [$D781], a
    ret

Jump_0F0_58FE::
    ld de, $CB9B
    call Func_0F0_5B06
    ld a, $01
    ld [$CB86], a
    ret

Jump_0F0_590A::
    ld a, [$CBAC]
    res 1, a
    ld [$CBAC], a
    ld a, $03
    ld [$CB86], a
    ld [$CBA6], a
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
    cp a, $E0
    ret nz
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_0F0_593A::
    call Func_0F0_622A
    ld hl, $C5A8
    ld de, $C140
    call Func_0F0_7C96
    ld a, $0C
    call Func_0F0_5DDD
    xor a, a
    ldh [$FFB9], a
    ld hl, $D782
    inc [hl]
    ld a, $02
    ld [$D7E8], a
    ld a, $00
    ld [$D7E9], a
    ld a, $01
    ld [$D7EA], a
    ld a, $01
    ld [$D7EB], a
    ret

Jump_0F0_5967::
    ld a, [$D782]
    rst $00
    dw Jump_0F0_557E
    dw Jump_0F0_5558
    dw Jump_0F0_557E
    dw Jump_0F0_5594
    dw Jump_0F0_557E
    dw Jump_0F0_5537
    dw Jump_0F0_557E
    dw Jump_0F0_557E
    dw Jump_0F0_59AB
    dw Jump_0F0_59F6
    dw Jump_0F0_58CD
    dw Jump_0F0_5A6C
    dw Jump_0F0_557E
    dw Jump_0F0_557E
    dw Jump_0F0_557E
    dw Jump_0F0_5855
    dw Jump_0F0_557E
    dw Jump_0F0_5848
    dw Jump_0F0_557E
    dw Jump_0F0_5855
    dw Jump_0F0_557E
    dw Jump_0F0_5848
    dw Jump_0F0_557E
    dw Jump_0F0_5855
    dw Jump_0F0_557E
    dw Jump_0F0_557E
    dw Jump_0F0_5A03
    dw Jump_0F0_557E
    dw Jump_0F0_5A73
    dw Jump_0F0_557E
    dw Jump_0F0_5AA3
    dw Jump_0F0_5518

Jump_0F0_59AB::
    ld a, [$CB9C]
    res 1, a
    ld [$CB9C], a
    ld a, $01
    ld [$CB96], a
    ld a, [$CB98]
    and a, $03
    and a, a
    ret z
    ld a, [$CB9A]
    inc a
    ld [$CB9A], a
    cp a, $70
    ret nz
    ld a, $0E
    ldh [$FFC6], a
    ld hl, Func_012_6B98
    ld b, $12
    rst $10
    ld a, $48
    ld [$CBD3], a
    ld a, $40
    ld [$CBD4], a
    xor a, a
    ld [$D783], a
    ld a, [$CB9C]
    set 1, a
    ld [$CB9C], a
    ld a, $00
    ld [$CB96], a
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_0F0_59F6::
    ld a, $03
    ld [$CB96], a
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_0F0_5A03::
    ld a, [$CBAC]
    res 1, a
    ld [$CBAC], a
    ld a, $01
    ld [$CBA6], a
    ld a, [$CBA8]
    and a, $03
    and a, a
    ret z
    ld a, [$CBAA]
    inc a
    ld [$CBAA], a
    cp a, $60
    ret nz
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Func_0F0_5A29:: ; heuristic: follows a terminator; C0
    ld a, [$CB88]
    and a, $03
    and a, a
    ret z
    ld a, [$CB8A]
    inc a
    ld [$CB8A], a
    cp a, $30
    jr nz, Jump_0F0_5A53
    ld a, $0E
    ldh [$FFC6], a
    ld hl, Func_012_6B98
    ld b, $12
    rst $10
    ld a, $48
    ld [$CBD3], a
    ld a, $40
    ld [$CBD4], a
    xor a, a
    ld [$D783], a

Jump_0F0_5A53::
    ld a, [$CB8A]
    cp a, $38
    ret nz
    ld [$CB8A], a
    ld a, [$CB8C]
    set 1, a
    ld [$CB8C], a
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_0F0_5A6C::
    ld de, $CB8B
    call Func_0F0_5B06
    ret

Jump_0F0_5A73::
    ld a, [$CB8C]
    res 1, a
    ld [$CB8C], a
    ld a, $01
    ld [$CB96], a
    ld [$CBA6], a
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
    cp a, $E0
    ret nz
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_0F0_5AA3::
    call Func_0F0_622A
    ld hl, $C5CB
    ld de, $C130
    ld b, $0A
    call Func_0F0_5B42
    ld hl, $C5C8
    ld de, $C140
    call Func_0F0_7C96
    ld a, $0D
    call Func_0F0_5DDD
    xor a, a
    ldh [$FFB9], a
    ld hl, $D782
    inc [hl]
    xor a, a
    ld [$C8C3], a
    ld [$C8C4], a
    ret

Jump_0F0_5ACE::
    ld a, [$D781]
    rst $00
    dw Jump_0F0_5ADA
    dw Jump_0F0_5AE7
    dw Jump_0F0_5AF4
    dw Jump_0F0_5055

Jump_0F0_5ADA::
    ld a, $08
    call Func_0F0_5DDD
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F0_5AE7::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ld a, $BA
    ld [$C594], a
    ret

Jump_0F0_5AF4::
    ld a, [$C58F]
    cp a, $BA
    ret nz
    xor a, a
    ld [$C594], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_0F0_5B06::
    ld a, [$D783]
    inc a
    ld [$D783], a
    and a, $03
    and a, a
    ret nz
    ld a, [$D781]
    ld hl, Data_0F0_5B39
    add a, l
    ld l, a
    jr nc, Jump_0F0_5B1C
    inc h

Jump_0F0_5B1C::
    ld a, [hl]
    cp a, $80
    jr z, Jump_0F0_5B2A
    ld b, a
    ld a, [de]
    add a, b
    ld [de], a
    ld hl, $D781
    inc [hl]
    ret

Jump_0F0_5B2A::
    ld a, [$D782]
    inc a
    ld [$D782], a
    xor a, a
    ld [$D781], a
    ld [$D783], a
    ret

Data_0F0_5B39:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FD, $FD, $FE, $00, $01, $01, $03, $03, $80

Func_0F0_5B42::
    ld a, [hl+]
    cp a, $F0
    jr z, Jump_0F0_5B4C
    ld [de], a
    inc de
    dec b
    jr nz, Func_0F0_5B42

Jump_0F0_5B4C::
    ld a, $F0
    ld [de], a
    ret

Func_0F0_5B50::
    ld a, [$D781]
    rst $00
    dw Jump_0F0_5B68
    dw Jump_0F0_5B6F
    dw Jump_0F0_5C15
    dw Jump_0F0_5C57
    dw Jump_0F0_5CAC
    dw Jump_0F0_5CBE
    dw Jump_0F0_5CE0
    dw Jump_0F0_5D29
    dw Jump_0F0_5D58
    dw Jump_0F0_5DA0

Jump_0F0_5B68::
    ld hl, Func_01D_6C9F
    ld b, $1D
    rst $10
    ret

Jump_0F0_5B6F::
    ld de, Data_0F0_5BA0
    ld hl, $C36B
    ld bc, $0D09
    call Func_0F0_62B8
    ld a, [$D7B7]
    ld b, $BC
    ld hl, Data_0F0_6522
    call Func_0F0_66FB
    call Func_0F0_632F
    ld bc, $140D
    ld de, $01CC
    call Func_0F0_62F2
    ld hl, Func_01D_6026
    ld b, $1D
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Data_0F0_5BA0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $3C1BA0, $75

Jump_0F0_5C15::
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

Jump_0F0_5C57::
    ld de, Data_0F0_6530
    ld hl, $C36B
    ld bc, $0D09
    call Func_0F0_62B8
    ld hl, Func_01E_71E1
    ld b, $1E
    rst $10
    ld a, [$D7B0]
    cp a, $02
    jr c, Jump_0F0_5C98
    ld de, $010E
    call Func_0F0_6350
    ld hl, $C412
    call Func_0F0_6376
    ld de, $010F
    ld a, d
    ld [$D7F1], a
    ld a, e
    ld [$D7F2], a
    call Func_0F0_6384
    ld hl, $C413
    ld a, h
    ld [$D7F1], a
    ld a, l
    ld [$D7F2], a
    call Func_0F0_63BA

Jump_0F0_5C98::
    call Func_0F0_632F
    ld bc, $1409
    ld de, $01CC
    call Func_0F0_62F2
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F0_5CAC::
    xor a, a
    ld [$D7F5], a
    ld hl, Func_01D_6088
    ld b, $1D
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F0_5CBE::
    ld de, Data_01F_4990
    ld hl, $8CE0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    xor a, a
    ld [$D7F1], a
    ld [$D7F2], a
    ld hl, Func_01D_6320
    ld b, $1D
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F0_5CE0::
    ld a, $01
    ld [$D7F9], a
    ld hl, Func_01D_66B6
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_0F0_5D05
    cp a, $FC
    jr z, Jump_0F0_5D05
    cp a, $FD
    jr z, Jump_0F0_5D0E
    cp a, $FE
    jr z, Jump_0F0_5D0F
    cp a, $FF
    jr z, Jump_0F0_5D17
    ret

Jump_0F0_5D05::
    ld a, [$D781]
    sub a, $04
    ld [$D781], a
    ret

Jump_0F0_5D0E::
    ret

Jump_0F0_5D0F::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F0_5D17::
    xor a, a
    ld [$D781], a
    ld [$D782], a
    ld a, [$D780]
    inc a
    ld [$D780], a
    call Func_0F0_61F6
    ret

Jump_0F0_5D29::
    ld c, $09
    ld hl, $01D3
    ld de, $0007
    xor a, a
    ld [$D7F1], a
    ld a, $0D
    ld [$D7F2], a
    call Func_0F0_63EE
    ld de, Data_0F0_5D51
    ld hl, $C411
    ld bc, $0701
    call Func_0F0_62B8
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Data_0F0_5D51:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B2

Jump_0F0_5D58::
    call Func_0F0_632F
    ld bc, $1409
    ld de, $01CC
    call Func_0F0_62F2
    ld de, Data_01F_4260
    ld hl, $8CF0
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

Jump_0F0_5DA0::
    ld a, $9E
    ld [$D7F1], a
    xor a, a
    ld [$D7F2], a
    ld de, Data_0F0_6DC4
    ld a, d
    ld [$D7F3], a
    ld a, e
    ld [$D7F4], a
    ld hl, Func_01D_6C14
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    cp a, $FF
    ret nz
    ld a, [$D7B7]
    ld b, $C3
    ld hl, Data_0F0_6522
    call Func_0F0_66FB
    xor a, a
    ld [$D780], a
    ld [$D782], a
    ld a, $04
    call Func_0F0_5DDD
    ld a, $07
    ld [$D781], a
    ret

Func_0F0_5DDD::
    ld [$C529], a
    xor a, a
    ld [$C528], a
    call Func_0F0_48A0
    ret

Func_0F0_5DE8::
    ld a, [$D781]
    rst $00
    dw Jump_0F0_5E0E
    dw Jump_0F0_5E63
    dw Jump_0F0_5E74
    dw Jump_0F0_5ECA
    dw Jump_0F0_5EF9
    dw Jump_0F0_5F2F
    dw Jump_0F0_5FA3
    dw Jump_0F0_6041
    dw Jump_0F0_607B
    dw Func_0F0_5E2C
    dw Jump_0F0_6096
    dw Jump_0F0_60A7
    dw Jump_0F0_60E7
    dw Jump_0F0_6129
    dw Jump_0F0_6176
    dw Jump_0F0_6188
    dw Jump_0F0_61B7

Jump_0F0_5E0E::
    call Func_0F0_5E2C
    ld de, Data_01F_4250
    ld hl, $8FE0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4A70
    ld hl, $8FF0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ret

Func_0F0_5E2C::
    call Func_0F0_632F
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
    ld hl, Func_01F_5D9A
    ld b, $1F
    rst $10
    xor a, a
    ldh [$FFA1], a
    ldh [$FFA5], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F0_5E63::
    ld hl, Data_0F0_6442
    ld de, Data_0F0_6482
    call Func_0F0_627E
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F0_5E74::
    ld de, Data_01F_48E0
    ld hl, $9020
    ld b, $1F
    ld c, $10
    call Func_000_0B46
    ld de, Data_01F_48E0
    ld hl, $9060
    ld b, $1F
    ld c, $10
    call Func_000_0B46
    ld de, Data_01F_48E0
    ld hl, $9090
    ld b, $1F
    ld c, $10
    call Func_000_0B46
    ld de, Data_01F_48E0
    ld hl, $9140
    ld b, $1F
    ld c, $10
    call Func_000_0B46
    ld de, Data_01F_48E0
    ld hl, $9170
    ld b, $1F
    ld c, $10
    call Func_000_0B46
    ld de, Data_01F_48E0
    ld hl, $91A0
    ld b, $1F
    ld c, $10
    call Func_000_0B46
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F0_5ECA::
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

Jump_0F0_5EF9::
    ld hl, Func_01D_6D07
    ld b, $1D
    rst $10
    call Func_0F0_632F
    ld de, Data_0F0_6E7F
    ld a, $14
    ld [$D7F3], a
    ld a, $12
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    call Func_0F0_66D5
    call Func_0F0_66EC
    ld a, l
    ld [$D7F1], a
    ld a, h
    ld [$D7F2], a
    ld hl, Func_01D_682A
    ld b, $1D
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F0_5F2F::
    call Func_0F0_66EC
    ld a, [hl]
    ld e, a
    ld hl, Func_01E_6FE3
    ld b, $1E
    rst $10
    ld a, $F0
    ldh [$FFBA], a
    call Func_0F0_632F
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
    jr c, Jump_0F0_5F9B
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
    call Func_0F0_632F
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

Jump_0F0_5F9B::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F0_5FA3::
    ld a, [$D782]
    and a, a
    jp nz, Jump_0F0_5FDD
    call Func_0F0_6262
    call Func_0F0_66EC
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

Jump_0F0_5FDD::
    call Func_0F0_66EC
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    push hl
    ld a, [$C525]
    and a, a
    jr z, Jump_0F0_6014
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
    call Func_0F0_632F
    ld de, $0041
    add hl, de
    pop de
    call Func_000_2090

Jump_0F0_6014::
    pop hl
    xor a, a
    ld [$1FFF], a
    call Func_0F0_632F
    ld de, $0041
    add hl, de
    ld de, Data_0F0_64F7
    ld a, $06
    ld [$D7F3], a
    ld a, $06
    ld [$D7F4], a
    ld a, $01
    ld [$D7F7], a
    call Func_0F0_66D5
    xor a, a
    ld [$D782], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F0_6041::
    ld hl, Func_01D_64D6
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    jr z, Jump_0F0_6059
    cp a, $FD
    jr z, Jump_0F0_605A
    cp a, $FE
    jr z, Jump_0F0_606C
    cp a, $FF
    jr z, Jump_0F0_606C

Jump_0F0_6059::
    ret

Jump_0F0_605A::
    ld a, [$D7B9]
    cp a, $02
    jr c, Jump_0F0_6059
    xor a, a
    ldh [$FFBA], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F0_606C::
    call Func_0F0_624F
    xor a, a
    ldh [$FFBA], a
    ld a, [$D781]
    add a, $02
    ld [$D781], a
    ret

Jump_0F0_607B::
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

Jump_0F0_6096::
    ld hl, Data_0F0_64C2
    ld de, Data_0F0_64D2
    call Func_0F0_627E
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F0_60A7::
    ld hl, Data_0F0_6500
    ld de, Data_0F0_64E0
    call Func_0F0_627E
    xor a, a
    ld [$C528], a
    ld a, $1E
    ld [$C529], a
    ld hl, $9700
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0901
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    call Func_0F0_48AE
    ld de, Data_01F_48E0
    ld hl, $8FF0
    ld b, $1F
    ld c, $10
    call Func_000_0B46
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F0_60E7::
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

Jump_0F0_6129::
    ld de, Data_0F0_6530
    ld hl, $C36B
    ld bc, $0D09
    call Func_0F0_62B8
    ld hl, Func_01E_71E1
    ld b, $1E
    rst $10
    jr Jump_0F0_6160

Func_0F0_613D:: ; heuristic: follows a terminator; C0
    ld a, [$D7B0]
    cp a, $02
    jr c, Jump_0F0_6158
    ld hl, $C412
    call Func_0F0_6376
    ld hl, $C413
    ld a, h
    ld [$D7F1], a
    ld a, l
    ld [$D7F2], a
    call Func_0F0_63BA

Jump_0F0_6158::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F0_6160::
    ld de, Data_0F0_616E
    ld hl, $C410
    ld bc, $0801
    call Func_0F0_62B8
    jr Jump_0F0_6158

Data_0F0_616E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2

Jump_0F0_6176::
    xor a, a
    ld [$D7F5], a
    ld hl, Func_01D_6088
    ld b, $1D
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F0_6188::
    ld de, Data_01F_4990
    ld hl, $8CE0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld a, $01
    ld [$D7F1], a
    xor a, a
    ld [$D7F2], a
    ld hl, Func_01D_6320
    ld b, $1D
    rst $10
    ld a, [$D7AB]
    ld b, $BC
    ld hl, Data_0F0_6526
    call Func_0F0_66FB
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_0F0_61B7::
    call Func_0F0_632F
    ld bc, $140D
    ld de, $01CC
    call Func_0F0_62F2
    call Func_0F0_632F
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call Func_0F0_62F2
    call Func_0F0_6214
    ld a, $70
    ldh [$FFBA], a
    xor a, a
    ld [$D782], a
    ld a, $02
    ld [$D780], a
    ld a, $03
    ld [$D781], a
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ret

Func_0F0_61F6::
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

Func_0F0_6214::
    ld a, [$D7BC]
    ldh [$FFB9], a
    ld a, $80
    ldh [$FFBA], a
    ld a, [$D7BA]
    ldh [$FF8D], a
    ld a, [$D7BB]
    xor a, a
    ld [$CB7D], a
    ret

Func_0F0_622A::
    ld hl, $8800
    ld de, $1202
    call Func_000_2E98
    ld a, $01
    ld [$C8CB], a
    ld a, $00
    ld [$C8CC], a
    ld a, $02
    ldh [$FFB9], a

Jump_0F0_6241::
    ld hl, Func_002_69D0
    ld b, $02
    rst $10
    ld a, [$C8CB]
    and a, $03
    jr nz, Jump_0F0_6241
    ret

Func_0F0_624F::
    ld a, [$D7AB]
    ld l, a
    ld h, $00
    ld a, $04
    call Func_000_16D1
    ld [$D7AB], a
    ld a, l
    ld [$D7AF], a
    ret

Func_0F0_6262::
    call Func_0F0_632F
    ld de, $0041
    add hl, de
    ld de, Data_0F0_651B
    ld a, $06
    ld [$D7F3], a
    ld a, $06
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    call Func_0F0_66D5
    ret

Func_0F0_627E::
    ld b, $00

Jump_0F0_6280::
    push bc
    push hl
    push de
    ld a, b
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0F0_628A
    inc h

Jump_0F0_628A::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_0F0_62B0
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
    jr nc, Jump_0F0_629F
    inc h

Jump_0F0_629F::
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
    jr Jump_0F0_6280

Jump_0F0_62B0::
    pop de
    pop hl
    pop bc
    xor a, a
    ld [$D784], a
    ret

Func_0F0_62B8::
    push hl
    push bc

Jump_0F0_62BA::
    push bc
    push hl

Jump_0F0_62BC::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_0F0_62BC
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_0F0_62BA
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

Jump_0F0_62DE::
    push bc
    push hl

Jump_0F0_62E0::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_0F0_62E0
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_0F0_62DE
    xor a, a
    ldh [$FF70], a
    ret

Func_0F0_62F2::
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

Func_0F0_632F::
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
    jr nc, Jump_0F0_634F
    inc h

Jump_0F0_634F::
    ret

Func_0F0_6350::
    push de
    call Func_0F0_632F
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

Func_0F0_6376::
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

Func_0F0_6384::
    ld a, [$D7F1]
    ld d, a
    ld a, [$D7F2]
    ld e, a
    push de
    call Func_0F0_632F
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

Func_0F0_63BA::
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

Func_0F0_63D3::
    ld a, [de]
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Func_0F0_63D3
    ret

Func_0F0_63DC::
    ld a, $02
    ldh [$FF70], a

Jump_0F0_63E0::
    ld a, [de]
    and a, $07
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_0F0_63E0
    xor a, a
    ldh [$FF70], a
    ret

Func_0F0_63EE::
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
    call Func_0F0_63D3
    pop de
    pop hl
    ld a, [$C525]
    and a, a
    jr z, Jump_0F0_642F
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
    call Func_0F0_63DC
    pop de
    pop hl

Jump_0F0_642F::
    pop bc
    ld a, $14
    add a, l
    ld l, a
    jr nc, Jump_0F0_6437
    inc h

Jump_0F0_6437::
    ld a, $14
    add a, e
    ld e, a
    jr nc, Jump_0F0_643E
    inc d

Jump_0F0_643E::
    dec c
    jr nz, Func_0F0_63EE
    ret

Data_0F0_6442:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $20, $90, $30, $90, $40, $90, $50, $90, $60, $90, $70, $90, $80, $90, $90, $90
    db $A0, $90, $B0, $90, $C0, $90, $D0, $90, $E0, $90, $F0, $90, $00, $91, $10, $91
    db $20, $91, $30, $91, $40, $91, $50, $91, $60, $91, $70, $91, $80, $91, $90, $91
    db $A0, $91, $B0, $91, $C0, $91, $D0, $91, $E0, $91, $F0, $91, $F0, $96, $FF, $FF

Data_0F0_6482:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D0, $42, $B0, $42, $00, $43, $C0, $44, $00, $44, $B0, $4A, $10, $43, $F0, $43
    db $E0, $42, $F0, $42, $A0, $42, $20, $43, $60, $42, $90, $43, $B0, $47, $80, $46
    db $B0, $46, $D0, $49, $B0, $42, $E0, $43, $90, $48, $90, $47, $80, $48, $40, $44
    db $80, $43, $00, $45, $E0, $44, $C0, $42, $30, $4A, $70, $42, $D0, $4A, $FF, $FF

Data_0F0_64C2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $97, $10, $97, $20, $97, $30, $97, $40, $97, $50, $97, $60, $97, $FF, $FF

Data_0F0_64D2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $30, $41, $20, $43, $A0, $42, $30, $43, $90, $41, $50, $41, $FF, $FF

Data_0F0_64E0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $40, $44, $80, $44, $E0, $43, $E0, $42, $B0, $46, $B0, $47, $50, $46, $00, $44
    db $B0, $42, $30, $41, $20, $43, $A0

Data_0F0_64F7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $42, $30, $43, $90, $41, $50, $41, $FF, $FF

Data_0F0_6500:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C0, $97, $D0, $97, $E0, $97, $F0, $97, $F0, $8D, $E0, $8F, $F0, $8F, $70, $97
    db $80, $97, $00, $97, $10, $97, $20, $97, $30, $97, $40

Data_0F0_651B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $97, $50, $97, $60, $97, $FF, $FF

Data_0F0_6522:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $26, $C4, $4E, $C4

Data_0F0_6526:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $80, $C3, $A8, $C3, $D0, $C3, $F8, $C3, $20, $C4

Data_0F0_6530:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $3C2530, $CB

Data_0F0_65FB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B6, $C3, $70, $71, $72, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3
    db $73, $74, $75, $76, $B7, $B3, $B4, $B4, $B4, $B4, $B4, $B5

Data_0F0_6617:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $C3, $70, $71, $72, $73, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $74, $75, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_0F0_663F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $70, $71, $72, $B7, $B6, $C3, $C3, $C3
    db $C3, $B7, $B6, $C3, $73, $74, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B5

Data_0F0_665D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_0F0_6685:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5, $C3, $B6, $C3, $C3, $C3, $C3, $C3, $B7
    db $C3, $B6, $C3, $C3, $C3, $C3, $C3, $B7, $C3, $B6, $C3, $C3, $C3, $C3, $C3, $B7
    db $C3, $B3, $B4, $B4, $B4, $B4, $B4, $B5

Data_0F0_66AD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $28, $C3

Func_0F0_66D5::
    ld a, h
    ld [$D7F5], a
    ld a, l
    ld [$D7F6], a
    ld a, d
    ld [$D7F1], a
    ld a, e
    ld [$D7F2], a
    ld hl, Func_01F_5D2A
    ld b, $1F
    rst $10
    ret

Func_0F0_66EC::
    ld hl, Func_01D_5DA1
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ret

Func_0F0_66FB::
    push bc
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0F0_6702
    inc h

Jump_0F0_6702::
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop bc
    ld a, b
    ld [de], a
    ret

Func_0F0_6709::
    ld a, [$C563]
    bit 6, a
    jr nz, Jump_0F0_673E
    bit 7, a
    jr nz, Jump_0F0_674E
    ld a, [$C562]
    bit 0, a
    jr nz, Jump_0F0_6727
    bit 1, a
    jr nz, Jump_0F0_6735
    call Func_0F0_676D
    xor a, a
    ld [$D7F9], a
    ret

Jump_0F0_6727::
    ld a, $69
    call Func_000_1278
    call Func_0F0_678F
    ld a, $FF
    ld [$D7F9], a
    ret

Jump_0F0_6735::
    call Func_0F0_678F
    ld a, $FE
    ld [$D7F9], a
    ret

Jump_0F0_673E::
    call Func_0F0_678B
    ld a, [$D7B7]
    and a, a
    jr nz, Jump_0F0_674B
    ld a, $01
    jr Jump_0F0_675C

Jump_0F0_674B::
    dec a
    jr Jump_0F0_675C

Jump_0F0_674E::
    call Func_0F0_678B
    ld a, [$D7B7]
    cp a, $01
    jr c, Jump_0F0_675B
    xor a, a
    jr Jump_0F0_675C

Jump_0F0_675B::
    inc a

Jump_0F0_675C::
    ld [$D7B7], a
    call Func_0F0_6787
    ld a, $69
    call Func_000_1278
    ld a, $FD
    ld [$D7F9], a
    ret

Func_0F0_676D::
    ld a, [$C564]
    cp a, $14
    jr c, Func_0F0_6787
    ld a, [$D7B8]
    inc a
    ld [$D7B8], a
    cp a, $10
    jr c, Func_0F0_6787
    cp a, $18
    jr c, Func_0F0_678B
    xor a, a
    ld [$D7B8], a

Func_0F0_6787::
    ld b, $BB
    jr Jump_0F0_6791

Func_0F0_678B::
    ld b, $C3
    jr Jump_0F0_6791

Func_0F0_678F::
    ld b, $BC

Jump_0F0_6791::
    ld a, [$D7F2]
    add a, a
    ld hl, Data_0F0_67C0
    add a, l
    ld l, a
    jr nc, Jump_0F0_679D
    inc h

Jump_0F0_679D::
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, [$D7B7]
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_0F0_67A9
    inc d

Jump_0F0_67A9::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld d, a
    ld e, l
    push de
    call Func_0F0_632F
    pop de
    add hl, de
    call Func_000_24F8
    di
    call Func_000_120A
    ld a, b
    ld [hl], a
    ei
    ret

Data_0F0_67C0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C6, $67, $CA, $67, $CE, $67, $2D, $01, $6D, $01, $2E, $01, $6E, $01, $2F, $01
    db $6F, $01

Func_0F0_67D2::
    ld a, [$D7EC]
    cp a, $03
    jr z, Jump_0F0_67E5
    cp a, $04
    jr z, Jump_0F0_67E5
    xor a, a
    ld [$D7F1], a
    call Func_0F0_67EE
    ret

Jump_0F0_67E5::
    ld a, $01
    ld [$D7F1], a
    call Func_0F0_67EE
    ret

Func_0F0_67EE::
    ld de, $0000
    call Func_000_181B
    jr c, Jump_0F0_67FB
    ld hl, Data_0F0_6A08
    jr Jump_0F0_67FE

Jump_0F0_67FB::
    ld hl, Data_0F0_6A18

Jump_0F0_67FE::
    ld de, $CB7F
    ld b, $10
    call Func_0F0_68DF
    ld a, [$C5C7]
    and a, a
    jr nz, Jump_0F0_6811
    ld hl, Data_0F0_6A28
    jr Jump_0F0_6814

Jump_0F0_6811::
    ld hl, Data_0F0_6A38

Jump_0F0_6814::
    ld de, $CB8F
    ld b, $10
    call Func_0F0_68DF
    ld de, $0000
    call Func_000_181B
    jr c, Jump_0F0_6829
    ld hl, Data_0F0_69EA
    jr Jump_0F0_682C

Jump_0F0_6829::
    ld hl, Data_0F0_69F0

Jump_0F0_682C::
    ld de, $FFC6
    ld b, $06
    call Func_0F0_68DF
    ld hl, Func_004_431F
    ld b, $04
    rst $10
    ld a, [$C5C7]
    and a, a
    jr nz, Jump_0F0_6845
    ld hl, Data_0F0_69F6
    jr Jump_0F0_6848

Jump_0F0_6845::
    ld hl, Data_0F0_69FC

Jump_0F0_6848::
    ld de, $FFC6
    ld b, $06
    call Func_0F0_68DF
    ld hl, Func_004_431F
    ld b, $04
    rst $10
    ld a, $0D
    ldh [$FFC6], a
    ld hl, Func_012_6B98
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
    ld a, [$D7F1]
    and a, a
    jr z, Jump_0F0_68D3
    ld hl, Data_0F0_6A48
    ld de, $CB9F
    ld b, $10
    call Func_0F0_68DF
    ld a, [$D7EC]
    cp a, $03
    jr nz, Jump_0F0_6899
    ld a, [$C5A8]
    ld [$CBA1], a
    ld a, [$C5A9]
    ld [$CBA2], a
    jr Jump_0F0_68A5

Jump_0F0_6899::
    ld a, [$C5C8]
    ld [$CBA1], a
    ld a, [$C5C9]
    ld [$CBA2], a

Jump_0F0_68A5::
    ld hl, Data_0F0_6A02
    ld de, $FFC6
    ld b, $06
    call Func_0F0_68DF
    ld a, [$D7EC]
    cp a, $03
    jr nz, Jump_0F0_68C3
    ld a, [$C5A8]
    ldh [$FFC6], a
    ld a, [$C5A9]
    ldh [$FFC7], a
    jr Jump_0F0_68CD

Jump_0F0_68C3::
    ld a, [$C5C8]
    ldh [$FFC6], a
    ld a, [$C5C9]
    ldh [$FFC7], a

Jump_0F0_68CD::
    ld hl, Func_004_431F
    ld b, $04
    rst $10

Jump_0F0_68D3::
    ld a, [$C525]
    and a, a
    jr z, Jump_0F0_68DE
    ld a, $7F
    ld [$C527], a

Jump_0F0_68DE::
    ret

Func_0F0_68DF::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Func_0F0_68DF
    ret

Data_0F0_68E6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $104, $C3

Data_0F0_69EA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $01, $04, $00, $80

Data_0F0_69F0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $00, $01, $01, $00, $80

Data_0F0_69F6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $01, $04, $00, $81

Data_0F0_69FC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $00, $01, $01, $00, $81

Data_0F0_6A02:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $02, $00, $82

Data_0F0_6A08:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $00, $00, $F0, $40, $04, $01, $00, $00, $00, $F0, $40, $04, $00, $00

Data_0F0_6A18:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $01, $00, $F0, $40, $01, $01, $00, $00, $00, $F0, $40, $04, $00, $00

Data_0F0_6A28:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $00, $00, $F0, $40, $04, $03, $10, $00, $00, $F0, $40, $04, $00, $00

Data_0F0_6A38:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $01, $00, $F0, $40, $01, $03, $10, $00, $00, $F0, $40, $04, $00, $00

Data_0F0_6A48:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $48, $40, $02, $00, $20, $00, $00, $48, $40, $04, $00, $00

Data_0F0_6A58:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $A6, $FF

Func_0F0_6AFE::
    ld a, [$CE9E]
    and a, a
    ret z
    ld hl, $CF41
    ld b, $00

Jump_0F0_6B08::
    ld a, b
    cp a, $0F
    jr z, Jump_0F0_6B1C
    ld a, [hl]
    cp a, $03
    jr z, Jump_0F0_6B1C
    ld a, [$CE9E]
    dec a
    ld [$CE9E], a
    jp Jump_0F0_6B24

Jump_0F0_6B1C::
    inc hl
    inc b
    ld a, b
    cp a, $1B
    jr c, Jump_0F0_6B08
    ret

Jump_0F0_6B24::
    xor a, a
    ld [$CF8B], a

Jump_0F0_6B28::
    ld hl, $CF8C
    ld bc, $001C

Jump_0F0_6B2E::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_0F0_6B2E
    ld hl, $CF41
    ld de, $CF8C
    ld b, $00

Jump_0F0_6B3D::
    ld a, [hl]
    ld c, a
    ld a, [$CF8B]
    cp a, c
    jr nz, Jump_0F0_6B4F
    ld a, b
    ld [de], a
    inc de
    ld a, [$CFA7]
    inc a
    ld [$CFA7], a

Jump_0F0_6B4F::
    inc hl
    inc b
    ld a, b
    cp a, $1B
    jr c, Jump_0F0_6B3D
    ld a, [$CFA7]
    and a, a
    jr nz, Jump_0F0_6B68
    ld a, [$CF8B]
    cp a, $02
    ret z
    inc a
    ld [$CF8B], a
    jr Jump_0F0_6B28

Jump_0F0_6B68::
    ld a, [$CFA7]
    cp a, $01
    jr z, Jump_0F0_6B90
    ld b, a
    call Func_000_095B
    ld a, l

Jump_0F0_6B74::
    sub a, b
    cp a, b
    jr c, Jump_0F0_6B7C
    jr z, Jump_0F0_6B7C
    jr Jump_0F0_6B74

Jump_0F0_6B7C::
    and a, a
    jr z, Jump_0F0_6B80
    dec a

Jump_0F0_6B80::
    ld hl, $CF8C
    add a, l
    ld l, a
    jr nc, Jump_0F0_6B88
    inc h

Jump_0F0_6B88::
    ld a, [hl]
    cp a, $0F
    jp z, Func_0F0_6AFE
    jr Jump_0F0_6B93

Jump_0F0_6B90::
    ld a, [$CF8C]

Jump_0F0_6B93::
    ld hl, $CF41
    add a, l
    ld l, a
    jr nc, Jump_0F0_6B9B
    inc h

Jump_0F0_6B9B::
    ld a, [hl]
    inc a
    ld [hl], a
    jp Func_0F0_6AFE

Func_0F0_6BA1::
    ld a, [$CED9]
    ld [$D006], a
    ld a, [$CEDA]
    ld [$D007], a
    ld hl, Func_035_4001
    ld b, $35
    rst $10
    ld a, [$D010]
    ld [$CF0A], a
    ld a, [$D011]
    ld [$CF0B], a
    ld a, [$D012]
    ld [$CF0C], a
    ld hl, $D01A
    ld de, $CF41
    ld c, $1B

Jump_0F0_6BCD::
    ld a, [hl+]
    ld [de], a
    inc de
    dec c
    jr nz, Jump_0F0_6BCD
    ld a, [$CF2B]
    ld [$CF29], a
    ld a, [$CF2F]
    ld [$CF2D], a
    ret

Func_0F0_6BE0::
    xor a, a
    ld [$CF89], a

Jump_0F0_6BE4::
    ld hl, $CEC3
    ld c, $00
    ld b, $00
    ld e, $00

Jump_0F0_6BED::
    push hl
    ld a, c
    ld hl, $CF73
    add a, l
    ld l, a
    jr nc, Jump_0F0_6BF7
    inc h

Jump_0F0_6BF7::
    ld a, [hl]
    bit 7, a
    jr z, Jump_0F0_6BFF
    pop hl
    jr Jump_0F0_6C15

Jump_0F0_6BFF::
    pop hl
    ld a, [hl]
    cp a, b
    jr c, Jump_0F0_6C0A
    jr z, Jump_0F0_6C0C
    ld b, a

Jump_0F0_6C07::
    ld e, c
    jr Jump_0F0_6C15

Jump_0F0_6C0A::
    jr Jump_0F0_6C15

Jump_0F0_6C0C::
    call Func_000_095B
    bit 0, a
    jr nz, Jump_0F0_6C15
    jr Jump_0F0_6C07

Jump_0F0_6C15::
    inc hl
    inc c
    ld a, c
    cp a, $0B
    jr c, Jump_0F0_6BED
    ld hl, $CF7E
    ld a, [$CF89]
    add a, l
    ld l, a
    jr nc, Jump_0F0_6C27
    inc h

Jump_0F0_6C27::
    ld a, e
    ld [hl], a
    ld hl, $CF73
    ld a, e
    add a, l
    ld l, a
    jr nc, Jump_0F0_6C32
    inc h

Jump_0F0_6C32::
    set 7, a
    ld [hl], a
    ld a, [$CF89]
    inc a
    ld [$CF89], a
    cp a, $0B
    jr c, Jump_0F0_6BE4
    call Func_0F0_70AA
    ld [$CF8A], a
    xor a, a
    ld [$CF89], a
    ld hl, $CF7E
    ld b, $0A

Jump_0F0_6C4F::
    push hl
    push bc
    ld a, [hl]
    res 7, a
    add a, a
    ld de, Data_0F0_6CB5
    add a, e
    ld e, a
    jr nc, Jump_0F0_6C5D
    inc d

Jump_0F0_6C5D::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [$CF8A]
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_0F0_6C6B
    inc h

Jump_0F0_6C6B::
    ld e, [hl]
    inc hl
    ld d, [hl]

Jump_0F0_6C6E::
    inc de
    ld a, [de]
    dec de
    cp a, $FF
    jr z, Jump_0F0_6C89
    cp a, $FE
    jr z, Jump_0F0_6CA0
    push de
    ld b, $0F
    call Func_0F0_7097
    ld a, l
    bit 0, a
    jr nz, Jump_0F0_6CA4
    pop de
    inc de
    inc de
    jr Jump_0F0_6C6E

Jump_0F0_6C89::
    pop bc
    pop hl
    inc hl
    dec b
    jp nz, Jump_0F0_6C4F
    ld a, $0A
    ld [$CEDB], a
    ld a, $74
    ld [$CED9], a
    ld a, $01
    ld [$CEDA], a
    ret

Jump_0F0_6CA0::
    dec de
    dec de
    jr Jump_0F0_6CA5

Jump_0F0_6CA4::
    pop de

Jump_0F0_6CA5::
    ld a, [de]
    ld [$CED9], a
    inc de
    ld a, [de]
    ld [$CEDA], a
    pop bc
    pop hl
    ld a, [hl]
    ld [$CEDB], a
    ret

Data_0F0_6CB5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_0F0_6CCB
    dw Data_0F0_6D1F
    dw Data_0F0_6D7D
    dw Data_0F0_6DDD
    dw Data_0F0_6E33
    dw Data_0F0_6E89
    dw Data_0F0_6EDD
    dw Data_0F0_6F37
    dw Data_0F0_6F8D
    dw Data_0F0_6FED
    dw Data_0F0_704B

Data_0F0_6CCB:: ; heuristic: target of a monotone pointer table; C0
    dw Data_0F0_6CDB
    dw Data_0F0_6CE3
    dw Data_0F0_6CEF
    dw Data_0F0_6CF9
    dw Data_0F0_6D05
    dw Data_0F0_6D0F
    dw Data_0F0_6D17
    dw Data_0F0_6D1B

Data_0F0_6CDB:: ; heuristic: target of a monotone pointer table; C0
    db $02, $00, $05, $00, $0F, $00, $FE, $FE

Data_0F0_6CE3:: ; heuristic: target of a monotone pointer table; C0
    db $04, $00, $07, $00, $0A, $00, $14, $00, $1A, $00, $FE, $FE

Data_0F0_6CEF:: ; heuristic: target of a monotone pointer table; C0
    db $03, $00, $08, $00, $09, $00, $0B, $00, $FE, $FE

Data_0F0_6CF9:: ; heuristic: target of a monotone pointer table; C0
    db $01, $00, $06, $00, $0C, $00, $0D, $00, $0E, $00, $FE, $FE

Data_0F0_6D05:: ; heuristic: target of a monotone pointer table; C0
    db $11, $00, $13, $00, $15, $00, $16, $00, $FE, $FE

Data_0F0_6D0F:: ; heuristic: target of a monotone pointer table; C0
    db $10, $00, $12, $00, $17, $00, $FE, $FE

Data_0F0_6D17:: ; heuristic: target of a monotone pointer table; C0
    db $18, $00, $FE, $FE

Data_0F0_6D1B:: ; heuristic: target of a monotone pointer table; C0
    db $19, $00, $FE, $FE

Data_0F0_6D1F:: ; heuristic: target of a monotone pointer table; C0
    dw Data_0F0_6D2F
    dw Data_0F0_6D37
    dw Data_0F0_6D43
    dw Data_0F0_6D4F
    dw Data_0F0_6D59
    dw Data_0F0_6D67
    dw Data_0F0_6D71
    dw Data_0F0_6D79

; LZSS-compressed asset: 43 bytes expand to 40 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6D2F:: ; heuristic: target of a monotone pointer table; C0
    db $28, $00, $31, $00, $32, $00, $FE, $FE

; LZSS-compressed asset: 45 bytes expand to 42 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6D37:: ; heuristic: target of a monotone pointer table; C0
    db $2A, $00, $2E, $00, $34, $00, $36, $00, $39, $00, $FE, $FE

; LZSS-compressed asset: 39 bytes expand to 36 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6D43:: ; heuristic: target of a monotone pointer table; C0
    db $24, $00, $25, $00, $26, $00, $27, $00, $3A, $00, $FE, $FE

; LZSS-compressed asset: 46 bytes expand to 43 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6D4F:: ; heuristic: target of a monotone pointer table; C0
    db $2B, $00, $2C, $00, $30, $00, $35, $00, $FE, $FE

; LZSS-compressed asset: 44 bytes expand to 41 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6D59:: ; heuristic: target of a monotone pointer table; C0
    db $29, $00, $2D, $00, $2F, $00, $33, $00, $37, $00, $3B, $00, $FE, $FE

; LZSS-compressed asset: 59 bytes expand to 56 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6D67:: ; heuristic: target of a monotone pointer table; C0
    db $38, $00, $3D, $00, $3E, $00, $3F, $00, $FE, $FE

; LZSS-compressed asset: 63 bytes expand to 60 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6D71:: ; heuristic: target of a monotone pointer table; C0
    db $3C, $00, $40, $00, $42, $00, $FE, $FE

; LZSS-compressed asset: 40 bytes expand to 65 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6D79:: ; heuristic: target of a monotone pointer table; C0
    db $41, $00, $FE, $FE

Data_0F0_6D7D:: ; heuristic: target of a monotone pointer table; C0
    dw Data_0F0_6D8D
    dw Data_0F0_6D9B
    dw Data_0F0_6DA9
    dw Data_0F0_6DB7
    dw Data_0F0_6DC5
    dw Data_0F0_6DCF
    dw Data_0F0_6DD5
    dw Data_0F0_6DD9

; LZSS-compressed asset: 75 bytes expand to 72 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6D8D:: ; heuristic: target of a monotone pointer table; C0
    db $48, $00, $49, $00, $4A, $00, $4B, $00, $50, $00, $5B, $00, $FE, $FE

; LZSS-compressed asset: 80 bytes expand to 77 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6D9B:: ; heuristic: target of a monotone pointer table; C0
    db $4D, $00, $4E, $00, $53, $00, $54, $00, $57, $00, $5A, $00, $FE, $FE

; LZSS-compressed asset: 74 bytes expand to 71 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6DA9:: ; heuristic: target of a monotone pointer table; C0
    db $47, $00, $4F, $00, $51, $00, $52, $00, $58, $00, $59, $00, $FE, $FE

; LZSS-compressed asset: 88 bytes expand to 85 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6DB7:: ; heuristic: target of a monotone pointer table; C0
    db $55, $00, $56, $00, $5D, $00, $5E, $00, $65, $00, $66, $00, $FE

Data_0F0_6DC4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FE

; LZSS-compressed asset: 79 bytes expand to 76 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6DC5:: ; heuristic: target of a monotone pointer table; C0
    db $4C, $00, $5F, $00, $62, $00, $63, $00, $FE, $FE

; LZSS-compressed asset: 95 bytes expand to 92 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6DCF:: ; heuristic: target of a monotone pointer table; C0
    db $5C, $00, $61, $00, $FE, $FE

; LZSS-compressed asset: 55 bytes expand to 96 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6DD5:: ; heuristic: target of a monotone pointer table; C0
    db $60, $00, $FE, $FE

; LZSS-compressed asset: 51 bytes expand to 100 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6DD9:: ; heuristic: target of a monotone pointer table; C0
    db $64, $00, $FE, $FE

Data_0F0_6DDD:: ; heuristic: target of a monotone pointer table; C0
    dw Data_0F0_6DED
    dw Data_0F0_6DF3
    dw Data_0F0_6DFD
    dw Data_0F0_6E0B
    dw Data_0F0_6E19
    dw Data_0F0_6E23
    dw Data_0F0_6E29
    dw Data_0F0_6E2F

; LZSS-compressed asset: 109 bytes expand to 106 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6DED:: ; heuristic: target of a monotone pointer table; C0
    db $6A, $00, $73, $00, $FE, $FE

; LZSS-compressed asset: 112 bytes expand to 109 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6DF3:: ; heuristic: target of a monotone pointer table; C0
    db $6D, $00, $70, $00, $74, $00, $75, $00, $FE, $FE

; LZSS-compressed asset: 103 bytes expand to 108 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6DFD:: ; heuristic: target of a monotone pointer table; C0
    db $6C, $00, $71, $00, $72, $00, $76, $00, $77, $00, $84, $00, $FE, $FE

; LZSS-compressed asset: 56 bytes expand to 107 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6E0B:: ; heuristic: target of a monotone pointer table; C0
    db $6B, $00, $6E, $00, $6F, $00, $78, $00, $79, $00, $7A, $00, $FE, $FE

; LZSS-compressed asset: 126 bytes expand to 123 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6E19:: ; heuristic: target of a monotone pointer table; C0
    db $7B, $00, $7C, $00, $7D, $00, $80, $00, $FE, $FE

; LZSS-compressed asset: 129 bytes expand to 126 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6E23:: ; heuristic: target of a monotone pointer table; C0
    db $7E, $00, $7F, $00, $FE, $FE

; LZSS-compressed asset: 132 bytes expand to 129 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6E29:: ; heuristic: target of a monotone pointer table; C0
    db $81, $00, $83, $00, $FE, $FE

; LZSS-compressed asset: 73 bytes expand to 130 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6E2F:: ; heuristic: target of a monotone pointer table; C0
    db $82, $00, $FE, $FE

Data_0F0_6E33:: ; heuristic: target of a monotone pointer table; C0
    dw Data_0F0_6E43
    dw Data_0F0_6E4D
    dw Data_0F0_6E55
    dw Data_0F0_6E61
    dw Data_0F0_6E71
    dw Data_0F0_6E77
    dw Data_0F0_6E7D
    dw Data_0F0_6E81

; LZSS-compressed asset: 148 bytes expand to 145 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6E43:: ; heuristic: target of a monotone pointer table; C0
    db $91, $00, $93, $00, $95, $00, $A6, $00, $FE, $FE

; LZSS-compressed asset: 144 bytes expand to 141 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6E4D:: ; heuristic: target of a monotone pointer table; C0
    db $8D, $00, $90, $00, $97, $00, $FE, $FE

; LZSS-compressed asset: 145 bytes expand to 142 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6E55:: ; heuristic: target of a monotone pointer table; C0
    db $8E, $00, $8F, $00, $92, $00, $96, $00, $98, $00, $FE, $FE

; LZSS-compressed asset: 147 bytes expand to 148 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6E61:: ; heuristic: target of a monotone pointer table; C0
    db $94, $00, $99, $00, $9A, $00, $9D, $00, $9E, $00, $9F, $00, $A7, $00, $FE, $FE

; LZSS-compressed asset: 163 bytes expand to 160 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6E71:: ; heuristic: target of a monotone pointer table; C0
    db $A0, $00, $A1, $00, $FE, $FE

; LZSS-compressed asset: 157 bytes expand to 154 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6E77:: ; heuristic: target of a monotone pointer table; C0
    db $9A, $00, $9B, $00, $FE, $FE

; LZSS-compressed asset: 107 bytes expand to 162 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6E7D:: ; heuristic: target of a monotone pointer table; C0
    db $A2, $00

Data_0F0_6E7F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FE, $FE

; LZSS-compressed asset: 166 bytes expand to 163 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6E81:: ; heuristic: target of a monotone pointer table; C0
    db $A3, $00, $A4, $00, $A5, $00, $FE, $FE

Data_0F0_6E89:: ; heuristic: target of a monotone pointer table; C0
    dw Data_0F0_6E99
    dw Data_0F0_6EA3
    dw Data_0F0_6EAB
    dw Data_0F0_6EB7
    dw Data_0F0_6EC7
    dw Data_0F0_6ECD
    dw Data_0F0_6ED5
    dw Data_0F0_6ED9

; LZSS-compressed asset: 179 bytes expand to 176 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6E99:: ; heuristic: target of a monotone pointer table; C0
    db $B0, $00, $B5, $00, $B9, $00, $BB, $00, $FE, $FE

; LZSS-compressed asset: 181 bytes expand to 178 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6EA3:: ; heuristic: target of a monotone pointer table; C0
    db $B2, $00, $B3, $00, $BA, $00, $FE, $FE

; LZSS-compressed asset: 185 bytes expand to 182 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6EAB:: ; heuristic: target of a monotone pointer table; C0
    db $B6, $00, $B7, $00, $B8, $00, $BD, $00, $C2, $00, $FE, $FE

; LZSS-compressed asset: 180 bytes expand to 177 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6EB7:: ; heuristic: target of a monotone pointer table; C0
    db $B1, $00, $B4, $00, $BC, $00, $BE, $00, $BF, $00, $C1, $00, $C9, $00, $FE, $FE

; LZSS-compressed asset: 195 bytes expand to 192 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6EC7:: ; heuristic: target of a monotone pointer table; C0
    db $C0, $00, $C5, $00, $FE, $FE

; LZSS-compressed asset: 198 bytes expand to 195 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6ECD:: ; heuristic: target of a monotone pointer table; C0
    db $C3, $00, $C4, $00, $C7, $00, $FE, $FE

; LZSS-compressed asset: 103 bytes expand to 198 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6ED5:: ; heuristic: target of a monotone pointer table; C0
    db $C6, $00, $FE, $FE

; LZSS-compressed asset: 105 bytes expand to 200 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6ED9:: ; heuristic: target of a monotone pointer table; C0
    db $C8, $00, $FE, $FE

Data_0F0_6EDD:: ; heuristic: target of a monotone pointer table; C0
    dw Data_0F0_6EED
    dw Data_0F0_6EF3
    dw Data_0F0_6EF9
    dw Data_0F0_6EFF
    dw Data_0F0_6F0B
    dw Data_0F0_6F17
    dw Data_0F0_6F29
    dw Data_0F0_6F33

; LZSS-compressed asset: 214 bytes expand to 211 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6EED:: ; heuristic: target of a monotone pointer table; C0
    db $D3, $00, $D6, $00, $FE, $FE

; LZSS-compressed asset: 223 bytes expand to 220 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6EF3:: ; heuristic: target of a monotone pointer table; C0
    db $DC, $00, $DD, $00, $FE, $FE

; LZSS-compressed asset: 215 bytes expand to 212 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6EF9:: ; heuristic: target of a monotone pointer table; C0
    db $D4, $00, $D8, $00, $FE, $FE

; LZSS-compressed asset: 212 bytes expand to 215 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6EFF:: ; heuristic: target of a monotone pointer table; C0
    db $D7, $00, $D9, $00, $E1, $00, $EA, $00, $EC, $00, $FE, $FE

; LZSS-compressed asset: 221 bytes expand to 218 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6F0B:: ; heuristic: target of a monotone pointer table; C0
    db $DA, $00, $DB, $00, $DF, $00, $E2, $00, $E8, $00, $FE, $FE

; LZSS-compressed asset: 225 bytes expand to 222 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6F17:: ; heuristic: target of a monotone pointer table; C0
    db $DE, $00, $E0, $00, $E3, $00, $E4, $00, $E5, $00, $E6, $00, $E9, $00, $EB, $00
    db $FE, $FE

; LZSS-compressed asset: 234 bytes expand to 231 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6F29:: ; heuristic: target of a monotone pointer table; C0
    db $E7, $00, $ED, $00, $EE, $00, $F0, $00, $FE, $FE

; LZSS-compressed asset: 79 bytes expand to 239 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6F33:: ; heuristic: target of a monotone pointer table; C0
    db $EF, $00, $FE, $FE

Data_0F0_6F37:: ; heuristic: target of a monotone pointer table; C0
    dw Data_0F0_6F47
    dw Data_0F0_6F4B
    dw Data_0F0_6F55
    dw Data_0F0_6F67
    dw Data_0F0_6F75
    dw Data_0F0_6F79
    dw Data_0F0_6F7F
    dw Data_0F0_6F89

; LZSS-compressed asset: 121 bytes expand to 246 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6F47:: ; heuristic: target of a monotone pointer table; C0
    db $F6, $00, $FE, $FE

; LZSS-compressed asset: 245 bytes expand to 249 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6F4B:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $00, $01, $04, $01, $05, $01, $FE, $FE

; LZSS-compressed asset: 251 bytes expand to 248 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6F55:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $00, $FA, $00, $FD, $00, $FE, $00, $FF, $00, $01, $01, $02, $01, $0F, $01
    db $FE, $FE

; LZSS-compressed asset: 254 bytes expand to 251 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6F67:: ; heuristic: target of a monotone pointer table; C0
    db $FB, $00, $FC, $00, $03, $01, $06, $01, $09, $01, $0E, $01, $FE, $FE

Data_0F0_6F75:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $01, $FE, $FE

; LZSS-compressed asset: 250 bytes expand to 247 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6F79:: ; heuristic: target of a monotone pointer table; C0
    db $F7, $00, $0B, $01, $FE, $FE

; LZSS-compressed asset: 266 bytes expand to 263 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6F7F:: ; heuristic: target of a monotone pointer table; C0
    db $07, $01, $08, $01, $0D, $01, $10, $01, $FE, $FE

; LZSS-compressed asset: 52 bytes expand to 268 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6F89:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $01, $FE, $FE

Data_0F0_6F8D:: ; heuristic: target of a monotone pointer table; C0
    dw Data_0F0_6F9D
    dw Data_0F0_6FA9
    dw Data_0F0_6FB1
    dw Data_0F0_6FBB
    dw Data_0F0_6FCB
    dw Data_0F0_6FD9
    dw Data_0F0_6FE5
    dw Data_0F0_6FE9

; LZSS-compressed asset: 286 bytes expand to 283 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6F9D:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $01, $1D, $01, $1E, $01, $22, $01, $31, $01, $FE, $FE

; LZSS-compressed asset: 284 bytes expand to 281 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6FA9:: ; heuristic: target of a monotone pointer table; C0
    db $19, $01, $1C, $01, $28, $01, $FE, $FE

; LZSS-compressed asset: 285 bytes expand to 282 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6FB1:: ; heuristic: target of a monotone pointer table; C0
    db $1A, $01, $21, $01, $27, $01, $37, $01, $FE, $FE

; LZSS-compressed asset: 290 bytes expand to 287 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6FBB:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $01, $20, $01, $23, $01, $26, $01, $2B, $01, $2C, $01, $30, $01, $FE, $FE

; LZSS-compressed asset: 287 bytes expand to 292 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6FCB:: ; heuristic: target of a monotone pointer table; C0
    db $24, $01, $29, $01, $2F, $01, $32, $01, $34, $01, $38, $01, $FE, $FE

; LZSS-compressed asset: 296 bytes expand to 293 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6FD9:: ; heuristic: target of a monotone pointer table; C0
    db $25, $01, $2A, $01, $2D, $01, $2E, $01, $33, $01, $FE, $FE

Data_0F0_6FE5:: ; heuristic: target of a monotone pointer table; C0
    db $35, $01, $FE, $FE

; LZSS-compressed asset: 207 bytes expand to 310 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6FE9:: ; heuristic: target of a monotone pointer table; C0
    db $36, $01, $FE, $FE

Data_0F0_6FED:: ; heuristic: target of a monotone pointer table; C0
    dw Data_0F0_6FFD
    dw Data_0F0_7005
    dw Data_0F0_700F
    dw Data_0F0_701B
    dw Data_0F0_7029
    dw Data_0F0_7035
    dw Data_0F0_7041
    dw Data_0F0_7047

; LZSS-compressed asset: 319 bytes expand to 316 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_6FFD:: ; heuristic: target of a monotone pointer table; C0
    db $3C, $01, $3D, $01, $44, $01, $FE, $FE

; LZSS-compressed asset: 326 bytes expand to 323 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_7005:: ; heuristic: target of a monotone pointer table; C0
    db $43, $01, $49, $01, $4D, $01, $5B, $01, $FE, $FE

; LZSS-compressed asset: 323 bytes expand to 320 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_700F:: ; heuristic: target of a monotone pointer table; C0
    db $40, $01, $41, $01, $45, $01, $4C, $01, $5A, $01, $FE, $FE

; LZSS-compressed asset: 321 bytes expand to 318 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_701B:: ; heuristic: target of a monotone pointer table; C0
    db $3E, $01, $3F, $01, $42, $01, $46, $01, $47, $01, $4A, $01, $FE, $FE

; LZSS-compressed asset: 331 bytes expand to 328 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_7029:: ; heuristic: target of a monotone pointer table; C0
    db $48, $01, $4B, $01, $4E, $01, $4F, $01, $50, $01, $FE, $FE

; LZSS-compressed asset: 340 bytes expand to 337 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_7035:: ; heuristic: target of a monotone pointer table; C0
    db $51, $01, $52, $01, $54, $01, $55, $01, $57, $01, $FE, $FE

; LZSS-compressed asset: 345 bytes expand to 342 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_7041:: ; heuristic: target of a monotone pointer table; C0
    db $56, $01, $58, $01, $FE, $FE

; LZSS-compressed asset: 312 bytes expand to 345 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0F0_7047:: ; heuristic: target of a monotone pointer table; C0
    db $59, $01, $FE, $FE

Data_0F0_704B:: ; heuristic: target of a monotone pointer table; C0
    dw Data_0F0_705B
    dw Data_0F0_705D
    dw Data_0F0_705F
    dw Data_0F0_7061
    dw Data_0F0_7063
    dw Data_0F0_7065
    dw Data_0F0_7067
    dw Data_0F0_7085

Data_0F0_705B:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_0F0_705D:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_0F0_705F:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_0F0_7061:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_0F0_7063:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_0F0_7065:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_0F0_7067:: ; heuristic: target of a monotone pointer table; C0
    db $5F, $01, $60, $01, $62, $01, $63, $01, $65, $01, $66, $01, $68, $01, $6A, $01
    db $6B, $01, $6C, $01, $6D, $01, $6E, $01, $6F, $01, $74, $01, $FE, $FE

Data_0F0_7085:: ; heuristic: target of a monotone pointer table; C0
    db $61, $01, $64, $01, $67, $01, $69, $01, $70, $01, $71, $01, $72, $01, $73, $01
    db $FE, $FE

Func_0F0_7097::
    push bc
    call Func_000_095B
    pop bc
    ld a, [$C5E7]
    ld l, a
    rl a
    and a, b
    ld h, a
    ld a, $29
    call Func_000_16D1
    ret

Func_0F0_70AA::
    ld a, [$CE9E]
    cp a, $04
    jr c, Jump_0F0_70BC
    cp a, $06
    jr c, Jump_0F0_70BF
    cp a, $0A
    jr c, Jump_0F0_70C2
    ld a, $07
    ret

Jump_0F0_70BC::
    ld a, $04
    ret

Jump_0F0_70BF::
    ld a, $05
    ret

Jump_0F0_70C2::
    ld a, $06
    ret
    INCBIN "dwm2-cobi-us.gbc", $3C30C5, $180

Func_0F0_7245::
    ld a, [$CEBF]
    cp a, b
    jr z, Jump_0F0_7256
    ld a, [$CEC0]
    cp a, $FF
    jr z, Jump_0F0_7253
    inc a

Jump_0F0_7253::
    ld [$CEC0], a

Jump_0F0_7256::
    ld a, b
    ld [$CEBF], a
    ld hl, $CE9F
    ld e, a
    ld d, $00
    call Func_0F0_7CD4
    cp a, $FF
    jr z, Jump_0F0_7281
    ld a, [$CEBF]
    ld hl, $CE9F
    ld e, a
    ld d, $00
    call Func_0F0_7D03
    ld a, [$CE9E]
    cp a, $FF
    jr nc, Jump_0F0_727E
    inc a
    ld [$CE9E], a

Jump_0F0_727E::
    ld c, $00
    ret

Jump_0F0_7281::
    ld c, $FF
    ret

Func_0F0_7284::
    ld a, [$CEC2]
    cp a, $0F
    jr nc, Jump_0F0_728F
    inc a
    ld [$CEC2], a

Jump_0F0_728F::
    ld a, [$CEC1]
    and a, a
    jr z, Jump_0F0_72AD
    ld a, [$CEC2]
    ld c, $05
    call Func_000_1682
    ld a, $64
    sub a, l
    ld l, a
    push hl
    ld b, $0F
    call Func_0F0_7097
    pop de
    ld a, l
    cp a, e
    call c, Func_0F0_72C8

Jump_0F0_72AD::
    ld a, [$D7F1]
    ld [$CEC1], a
    ret

Func_0F0_72B4::
    ld a, [$CE9D]
    cp a, $3B
    ret nz
    ld a, [$CE9C]
    and a, a
    ret nz
    ld a, [$CE9B]
    and a, a
    ret nz
    xor a, a
    ld [$CEC2], a

Func_0F0_72C8::
    ld a, [$CEC1]
    rst $00
    dw Jump_0F0_7390
    dw Jump_0F0_739B
    dw Jump_0F0_73BD
    dw Jump_0F0_73DF
    dw Jump_0F0_7401
    dw Jump_0F0_7423
    dw Jump_0F0_7445
    dw Jump_0F0_7452
    dw Jump_0F0_7474
    dw Jump_0F0_7496
    dw Jump_0F0_74B8
    dw Jump_0F0_74DA
    dw Jump_0F0_74FC
    dw Jump_0F0_751E
    dw Jump_0F0_7536
    dw Jump_0F0_754E
    dw Jump_0F0_7566
    dw Jump_0F0_757E
    dw Jump_0F0_7596
    dw Jump_0F0_75AE
    dw Jump_0F0_75D0
    dw Jump_0F0_75F2
    dw Jump_0F0_7614
    dw Jump_0F0_7636
    dw Jump_0F0_7658
    dw Jump_0F0_767A
    dw Jump_0F0_7692
    dw Jump_0F0_76B4
    dw Jump_0F0_76D6
    dw Jump_0F0_76F8
    dw Jump_0F0_7712
    dw Jump_0F0_7729
    dw Jump_0F0_772E
    dw Jump_0F0_7746
    dw Jump_0F0_774B
    dw Jump_0F0_776D
    dw Jump_0F0_778F
    dw Jump_0F0_77B1
    dw Jump_0F0_77D3
    dw Jump_0F0_77F5
    dw Jump_0F0_7817
    dw Jump_0F0_7839
    dw Jump_0F0_785B
    dw Jump_0F0_787D
    dw Jump_0F0_7882
    dw Jump_0F0_7887
    dw Jump_0F0_788C
    dw Jump_0F0_787D
    dw Jump_0F0_787D
    dw Jump_0F0_787D
    dw Jump_0F0_787D
    dw Jump_0F0_787D
    dw Jump_0F0_787D
    dw Jump_0F0_787D
    dw Jump_0F0_787D
    dw Jump_0F0_787D
    dw Jump_0F0_787D
    dw Jump_0F0_787D
    dw Jump_0F0_787D
    dw Jump_0F0_787D
    dw Jump_0F0_787D
    dw Jump_0F0_787D
    dw Jump_0F0_787D
    dw Jump_0F0_787D
    dw Jump_0F0_7899
    dw Jump_0F0_78BB
    dw Jump_0F0_78DD
    dw Jump_0F0_78FF
    dw Jump_0F0_7921
    dw Jump_0F0_7943
    dw Jump_0F0_7965
    dw Jump_0F0_7987
    dw Jump_0F0_79A9
    dw Jump_0F0_79CB
    dw Jump_0F0_79ED
    dw Jump_0F0_7A0F
    dw Jump_0F0_7A31
    dw Jump_0F0_7A53
    dw Jump_0F0_7A75
    dw Jump_0F0_7A97
    dw Jump_0F0_7AB9
    dw Jump_0F0_7ADB
    dw Jump_0F0_7AFD
    dw Jump_0F0_7B1F
    dw Jump_0F0_787D
    dw Jump_0F0_787D
    dw Jump_0F0_787D
    dw Jump_0F0_787D
    dw Jump_0F0_787D
    dw Jump_0F0_787D
    dw Jump_0F0_7B41
    dw Jump_0F0_7B63
    dw Jump_0F0_7B85
    dw Jump_0F0_7BA7
    dw Jump_0F0_7BC9
    dw Jump_0F0_7BEB
    dw Jump_0F0_7C0D
    dw Jump_0F0_7C2F

Jump_0F0_7390::
    ld hl, $CECA
    ld b, $01
    ld c, $FE
    call Func_0F0_7C51
    ret

Jump_0F0_739B::
    ld hl, $CF2B
    ld b, $01
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC3
    ld b, $01
    ld c, $FE
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_73BD::
    ld hl, $CF2B
    ld b, $02
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CECC
    ld b, $01
    ld c, $FE
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_73DF::
    ld hl, $CF2B
    ld b, $03
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC4
    ld b, $02
    ld c, $FD
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7401::
    ld hl, $CF2F
    ld b, $01
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC9
    ld b, $01
    ld c, $FE
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7423::
    ld hl, $CF2F
    ld b, $03
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC7
    ld b, $02
    ld c, $FD
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7445::
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7452::
    ld hl, $CF31
    ld b, $01
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC5
    ld b, $01
    ld c, $FE
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7474::
    ld hl, $CF33
    ld b, $01
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC6
    ld b, $01
    ld c, $FE
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7496::
    ld hl, $CF35
    ld b, $01
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC8
    ld b, $01
    ld c, $FE
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_74B8::
    ld hl, $CF37
    ld b, $01
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CECB
    ld b, $01
    ld c, $FE
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_74DA::
    ld hl, $CF2F
    ld b, $03
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CECB
    ld b, $02
    ld c, $FD
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_74FC::
    ld hl, $CF2B
    ld b, $03
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC7
    ld b, $02
    ld c, $FD
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_751E::
    ld hl, $CF31
    ld b, $03
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7536::
    ld hl, $CF33
    ld b, $03
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_754E::
    ld hl, $CF35
    ld b, $03
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7566::
    ld hl, $CF37
    ld b, $03
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_757E::
    ld hl, $CF2B
    ld b, $05
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7596::
    ld hl, $CF2F
    ld b, $05
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_75AE::
    ld hl, $CF31
    ld b, $05
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC4
    ld b, $02
    ld c, $FD
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_75D0::
    ld hl, $CF33
    ld b, $05
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC5
    ld b, $05
    ld c, $FA
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_75F2::
    ld hl, $CF2B
    ld b, $05
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC6
    ld b, $02
    ld c, $FD
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7614::
    ld hl, $CF35
    ld b, $05
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC9
    ld b, $05
    ld c, $FA
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7636::
    ld hl, $CF37
    ld b, $05
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC7
    ld b, $05
    ld c, $FA
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7658::
    ld hl, $CF2F
    ld b, $05
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC3
    ld b, $05
    ld c, $FA
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_767A::
    ld hl, $CF2B
    ld b, $01
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7692::
    ld hl, $CF2B
    ld b, $01
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CECB
    ld b, $01
    ld c, $FE
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_76B4::
    ld hl, $CF2B
    ld b, $02
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC8
    ld b, $02
    ld c, $FD
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_76D6::
    ld hl, $CF2B
    ld b, $03
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CECC
    ld b, $02
    ld c, $FD
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_76F8::
    ld hl, $CF2B
    ld b, $01
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CECA
    ld b, $05
    ld c, $FA
    call Func_0F0_7C51
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7712::
    ld hl, $CECD
    ld b, $01
    ld c, $FE
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7729::
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_772E::
    ld hl, $CF2B
    ld b, $01
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7746::
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_774B::
    ld hl, $CF2F
    ld b, $01
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC9
    ld b, $02
    ld c, $FD
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_776D::
    ld hl, $CF31
    ld b, $02
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC5
    ld b, $02
    ld c, $FD
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_778F::
    ld hl, $CF33
    ld b, $02
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC3
    ld b, $02
    ld c, $FD
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_77B1::
    ld hl, $CF35
    ld b, $02
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC7
    ld b, $02
    ld c, $FD
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_77D3::
    ld hl, $CF37
    ld b, $02
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC8
    ld b, $02
    ld c, $FD
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_77F5::
    ld hl, $CF31
    ld b, $02
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC4
    ld b, $02
    ld c, $FD
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7817::
    ld hl, $CF33
    ld b, $02
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CECC
    ld b, $01
    ld c, $FE
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7839::
    ld hl, $CF35
    ld b, $02
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC6
    ld b, $01
    ld c, $FE
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_785B::
    ld hl, $CF37
    ld b, $02
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CECB
    ld b, $01
    ld c, $FE
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_787D::
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7882::
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7887::
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_788C::
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7899::
    ld hl, $CF2B
    ld b, $03
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC8
    ld b, $01
    ld c, $FE
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_78BB::
    ld hl, $CF2B
    ld b, $08
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC8
    ld b, $02
    ld c, $FD
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_78DD::
    ld hl, $CF2F
    ld b, $03
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC7
    ld b, $01
    ld c, $FE
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_78FF::
    ld hl, $CF2F
    ld b, $08
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC7
    ld b, $02
    ld c, $FD
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7921::
    ld hl, $CF31
    ld b, $01
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC5
    ld b, $01
    ld c, $FE
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7943::
    ld hl, $CF31
    ld b, $05
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC5
    ld b, $02
    ld c, $FD
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7965::
    ld hl, $CF33
    ld b, $01
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CECC
    ld b, $01
    ld c, $FE
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7987::
    ld hl, $CF33
    ld b, $05
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CECC
    ld b, $02
    ld c, $FD
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_79A9::
    ld hl, $CF35
    ld b, $01
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC3
    ld b, $01
    ld c, $FE
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_79CB::
    ld hl, $CF35
    ld b, $05
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC3
    ld b, $02
    ld c, $FD
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_79ED::
    ld hl, $CF37
    ld b, $01
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC9
    ld b, $01
    ld c, $FE
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7A0F::
    ld hl, $CF37
    ld b, $05
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC9
    ld b, $02
    ld c, $FD
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7A31::
    ld hl, $CF2F
    ld b, $08
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC6
    ld b, $02
    ld c, $FD
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7A53::
    ld hl, $CF31
    ld b, $03
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC4
    ld b, $02
    ld c, $FD
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7A75::
    ld hl, $CF35
    ld b, $03
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CECB
    ld b, $02
    ld c, $FD
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7A97::
    ld hl, $CF37
    ld b, $03
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CECB
    ld b, $02
    ld c, $FD
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7AB9::
    ld hl, $CF33
    ld b, $03
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CECD
    ld b, $02
    ld c, $FD
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7ADB::
    ld hl, $CF35
    ld b, $03
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CECC
    ld b, $02
    ld c, $FD
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7AFD::
    ld hl, $CF31
    ld b, $03
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC5
    ld b, $02
    ld c, $FD
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7B1F::
    ld hl, $CF2B
    ld b, $01
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC4
    ld b, $01
    ld c, $FE
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7B41::
    ld hl, $CF2B
    ld b, $03
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC8
    ld b, $02
    ld c, $FD
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7B63::
    ld hl, $CF2F
    ld b, $03
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC7
    ld b, $02
    ld c, $FD
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7B85::
    ld hl, $CF2B
    ld b, $03
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CECC
    ld b, $02
    ld c, $FD
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7BA7::
    ld hl, $CF2F
    ld b, $03
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC9
    ld b, $02
    ld c, $FD
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7BC9::
    ld hl, $CF31
    ld b, $03
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC5
    ld b, $02
    ld c, $FD
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7BEB::
    ld hl, $CF33
    ld b, $03
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CECB
    ld b, $02
    ld c, $FD
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7C0D::
    ld hl, $CF35
    ld b, $03
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC6
    ld b, $02
    ld c, $FD
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Jump_0F0_7C2F::
    ld hl, $CF37
    ld b, $03
    ld de, $03E7
    call Func_0F0_7C64
    ld hl, $CEC3
    ld b, $02
    ld c, $FD
    call Func_0F0_7C51
    ld hl, $CECA
    ld b, $02
    call Func_0F0_7C5B
    xor a, a
    ld [$CEC1], a
    ret

Func_0F0_7C51::
    inc c
    ld a, [hl]
    add a, b
    cp a, c
    jr c, Jump_0F0_7C59
    ld a, c
    dec a

Jump_0F0_7C59::
    ld [hl], a
    ret

Func_0F0_7C5B::
    ld a, [hl]
    sub a, b
    bit 7, a
    jr z, Jump_0F0_7C62
    xor a, a

Jump_0F0_7C62::
    ld [hl], a
    ret

Func_0F0_7C64::
    push hl
    ld a, [hl+]
    add a, b
    ld c, a
    ld a, [hl]
    adc a, $00
    ld h, a
    ld l, c
    call Func_0F0_7C81
    ld a, c
    cp a, $FF
    jr nz, Jump_0F0_7C7A
    pop hl
    ld [hl], e
    inc hl
    ld [hl], d
    ret

Jump_0F0_7C7A::
    pop bc
    ld a, l
    ld [bc], a
    inc bc
    ld a, h
    ld [bc], a
    ret

Func_0F0_7C81::
    ld a, h
    cp a, d
    jr c, Jump_0F0_7C90
    jr nz, Jump_0F0_7C8D
    ld a, l
    cp a, e
    jr c, Jump_0F0_7C90
    jr z, Jump_0F0_7C93

Jump_0F0_7C8D::
    ld c, $FF
    ret

Jump_0F0_7C90::
    ld c, $00
    ret

Jump_0F0_7C93::
    ld c, $01
    ret

Func_0F0_7C96::
    push de
    inc hl
    ld a, [hl-]
    and a, a
    jr nz, Jump_0F0_7CA1
    ld de, Data_0F0_4036
    jr Jump_0F0_7CA4

Jump_0F0_7CA1::
    ld de, Data_008_4038

Jump_0F0_7CA4::
    push hl
    ld b, $08
    call Func_000_18D6
    ld c, l
    ld b, h
    pop hl
    ld a, [hl]
    ld e, a
    ld d, $00
    sla e
    rl d
    ld l, c
    ld h, b
    add hl, de
    ld e, l
    ld d, h
    ld b, $08
    call Func_000_18D6
    ld e, l
    ld d, h
    pop hl

Jump_0F0_7CC2::
    ld b, $08
    call Func_000_1872
    ld a, c
    cp a, $F0
    jr z, Jump_0F0_7CD0
    ld [hl+], a
    inc de
    jr Jump_0F0_7CC2

Jump_0F0_7CD0::
    ld a, $F0
    ld [hl+], a
    ret

Func_0F0_7CD4::
    push de
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    add hl, de
    pop de
    push hl
    ld a, e
    and a, $07
    ld hl, Data_0F0_7CFB
    add a, l
    ld l, a
    jr nc, Jump_0F0_7CEF
    inc h

Jump_0F0_7CEF::
    ld a, [hl]
    ld d, a
    pop hl
    ld a, [hl]
    and a, d
    jr nz, Jump_0F0_7CF8
    xor a, a
    ret

Jump_0F0_7CF8::
    ld a, $FF
    ret

Data_0F0_7CFB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $80, $40, $20, $10, $08, $04, $02, $01

Func_0F0_7D03::
    call Func_0F0_7CD4
    ld a, [hl]
    or a, d
    ld [hl], a
    ret

Func_0F0_7D0A:: ; heuristic: follows a terminator; C0
    ld hl, $CE9B
    ld bc, $00D8

Jump_0F0_7D10::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_0F0_7D10
    ld hl, $CECE
    ld a, $01
    ld [hl+], a
    ld c, $0A

Jump_0F0_7D1F::
    ld a, $F0
    ld [hl+], a
    dec c
    jr nz, Jump_0F0_7D1F
    ld a, $1A
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld [hl+], a
    push hl
    ld b, $0F
    call Func_0F0_7097
    ld a, l
    and a, $01
    pop hl
    ld [hl+], a
    ld de, $C60C
    ld c, $0A

Jump_0F0_7D3B::
    ld a, [de]
    cp a, $F0
    jr z, Jump_0F0_7D47
    ld [hl+], a
    inc de
    dec c
    jr nz, Jump_0F0_7D3B
    jr Jump_0F0_7D4A

Jump_0F0_7D47::
    ld a, $F0
    ld [hl+], a

Jump_0F0_7D4A::
    ld hl, $CEE7
    ld a, [$C616]
    ld [hl+], a
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    call Func_0F0_7E50
    ld c, $06
    ld b, $F0
    call Func_0F0_7E4A
    ld a, $F0
    ld [hl+], a
    call Func_0F0_7E50
    ld c, $06
    ld b, $F0
    call Func_0F0_7E4A
    ld a, $F0
    ld [hl+], a
    ld c, $21

Jump_0F0_7D73::
    ld a, $FF
    ld [hl+], a
    dec c
    jr nz, Jump_0F0_7D73
    xor a, a
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $28
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    push hl
    ld b, $0F
    call Func_0F0_7097
    ld b, $20
    call Func_0F0_7E5D
    pop hl
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl+], a
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl+], a
    push hl
    ld b, $0F
    call Func_0F0_7097
    ld b, $20
    call Func_0F0_7E5D
    pop hl
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl+], a
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl+], a
    push hl
    ld b, $0F
    call Func_0F0_7097
    ld b, $20
    call Func_0F0_7E5D
    pop hl
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl+], a
    push hl
    ld b, $0F
    call Func_0F0_7097
    ld b, $20
    call Func_0F0_7E5D
    pop hl
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl+], a
    push hl
    ld b, $0F
    call Func_0F0_7097
    ld b, $20
    call Func_0F0_7E5D
    pop hl
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl+], a
    push hl
    ld b, $0F
    call Func_0F0_7097
    ld b, $20
    call Func_0F0_7E5D
    pop hl
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld [hl+], a
    xor a, a
    ld [hl+], a
    xor a, a
    ld [hl+], a
    push hl
    ld b, $0F
    call Func_0F0_7097
    ld b, $FE
    call Func_0F0_7E5D
    pop hl
    ld a, e
    ld [hl+], a
    push hl
    ld b, $0F
    call Func_0F0_7097
    ld b, $FE
    call Func_0F0_7E5D
    pop hl
    ld a, e
    ld [hl+], a
    push hl
    ld b, $0F
    call Func_0F0_7097
    ld b, $FE
    call Func_0F0_7E5D
    pop hl
    ld a, e
    ld [hl+], a
    push hl
    ld b, $0F
    call Func_0F0_7097
    ld b, $FE
    call Func_0F0_7E5D
    pop hl
    ld a, e
    ld [hl+], a
    ld c, $1B

Jump_0F0_7E2E::
    xor a, a
    ld [hl+], a
    dec c
    jr nz, Jump_0F0_7E2E
    ld c, $0A

Jump_0F0_7E35::
    ld a, $F0
    ld [hl+], a
    dec c
    jr nz, Jump_0F0_7E35
    xor a, a
    ld [hl+], a
    ld c, $0A

Jump_0F0_7E3F::
    ld a, $F0
    ld [hl+], a
    dec c
    jr nz, Jump_0F0_7E3F
    xor a, a
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ret

Func_0F0_7E4A::
    ld a, b
    ld [hl+], a
    dec c
    jr nz, Func_0F0_7E4A
    ret

Func_0F0_7E50::
    ld a, $98
    ld [hl+], a
    ld a, $98
    ld [hl+], a
    ld a, $98
    ld [hl+], a
    ld a, $F0
    ld [hl+], a
    ret

Func_0F0_7E5D::
    ld a, l

Jump_0F0_7E5E::
    cp a, b
    jr c, Jump_0F0_7E64
    sub a, b
    jr Jump_0F0_7E5E

Jump_0F0_7E64::
    inc a
    ld e, a
    ld d, $00
    ret

Func_0F0_7E69::
    ld a, [$CEC0]
    cp a, $05
    jr nc, Jump_0F0_7E72

Jump_0F0_7E70::
    xor a, a
    ret

Jump_0F0_7E72::
    cp a, $0D
    jr nc, Jump_0F0_7E80
    sub a, $04
    ld c, $0A
    call Func_000_1682
    ld e, l
    jr Jump_0F0_7E82

Jump_0F0_7E80::
    ld e, $50

Jump_0F0_7E82::
    push de
    ld b, $0F
    call Func_0F0_7097
    ld a, l
    pop de
    cp a, e
    jr nc, Jump_0F0_7E70
    ld a, $01
    ret
    ds $170, $00
