SECTION "Bank 0F", ROMX[$4000], BANK[$0F]
    db $0F

Func_00F_4001::
    ld a, [$C923]
    rst $00
    dw Jump_00F_4077
    dw Jump_00F_404D
    dw Jump_00F_402D
    dw Jump_00F_400D

Jump_00F_400D::
    ldh a, [$FF91]
    call Func_00F_7ED8
    ldh a, [$FF91]
    call Func_00F_7ED8
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $1E
    ret nz
    ldh a, [$FF8C]
    and a, $FD
    ldh [$FF8C], a
    ld a, $80
    ld [$C919], a
    ret

Jump_00F_402D::
    ldh a, [$FF91]
    call Func_00F_7ED8
    ldh a, [$FF91]
    inc a
    ldh [$FF91], a
    ldh a, [$FF91]
    call Func_00F_7ED8
    ldh a, [$FF91]
    inc a
    ldh [$FF91], a
    cp a, $80
    ret nz
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_404D::
    ld a, $01
    ld [$C929], a
    ld a, $80
    ld [$C92A], a
    ld a, $40
    ld [$C928], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ldh a, [$FF8C]
    or a, $02
    ldh [$FF8C], a
    ld a, $63
    call Func_000_1278
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4077::
    ld a, [$C921]
    inc a
    ld [$C921], a
    and a, $01
    ret z
    ld a, [$CB9B]
    dec a
    ld [$CB9B], a
    cp a, $30
    ret nz
    ld hl, $CB9C
    call Func_00F_7ECE
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Func_00F_409A::
    ld a, [$C923]
    rst $00
    dw Jump_00F_40A2
    dw Jump_00F_7F93

Jump_00F_40A2::
    ld a, $0A
    ld [$0100], a
    ld hl, $C6FE
    ld a, [$C922]
    add a, l
    ld l, a
    jr nc, Jump_00F_40B2
    inc h

Jump_00F_40B2::
    push hl
    ld a, [hl]
    ld c, $0D
    call Func_000_1F80
    ldh a, [$FFC6]
    and a, $0F
    ld hl, $40DE
    add a, l
    ld l, a
    jr nc, Jump_00F_40C5
    inc h

Jump_00F_40C5::
    ld a, [hl]
    ld e, a
    pop hl
    ld a, [hl]
    push de
    call Func_000_2391
    pop de
    add a, e
    ld l, a
    ld h, $05
    call Func_00F_7F68
    xor a, a
    ld [$0100], a
    ld hl, $C923
    inc [hl]
    ret
    db $94, $AF, $CA, $AF, $94, $CA, $AF, $94, $CA, $CA, $E5

Func_00F_40E9::
    ld a, [$C923]
    rst $00
    dw Jump_00F_456A
    dw Jump_00F_4532
    dw Jump_00F_44F3
    dw Jump_00F_7F89
    dw Jump_00F_44D8
    dw Jump_00F_7F89
    dw Jump_00F_44C9
    dw Jump_00F_44B1
    dw Jump_00F_4493
    dw Jump_00F_448C
    dw Jump_00F_447A
    dw Jump_00F_447A
    dw Jump_00F_7F89
    dw Jump_00F_4468
    dw Jump_00F_4468
    dw Jump_00F_7F89
    dw Jump_00F_4456
    dw Jump_00F_7F89
    dw Jump_00F_4444
    dw Jump_00F_7F89
    dw Jump_00F_4419
    dw Jump_00F_7F89
    dw Jump_00F_43EF
    dw Jump_00F_439D
    dw Jump_00F_7F89
    dw Jump_00F_438B
    dw Jump_00F_7F89
    dw Jump_00F_435F
    dw Jump_00F_42E7
    dw Jump_00F_42D5
    dw Jump_00F_42CA
    dw Jump_00F_7F89
    dw Jump_00F_42B5
    dw Jump_00F_429F
    dw Jump_00F_7F89
    dw Jump_00F_42E7
    dw Jump_00F_42D5
    dw Jump_00F_42E7
    dw Jump_00F_427A
    dw Jump_00F_4270
    dw Jump_00F_4266
    dw Jump_00F_418E
    dw Jump_00F_4171
    dw Jump_00F_414D
    dw Jump_00F_4147

Jump_00F_4147::
    ld a, $80
    ld [$C919], a
    ret

Jump_00F_414D::
    ld a, $06
    ldh [$FF90], a
    xor a, a
    ldh [$FF8F], a
    ldh [$FF92], a
    ld a, $02
    ld [$C5DB], a
    ld a, $0B
    ld [$C5DC], a
    xor a, a
    ld [$C5DD], a
    xor a, a
    ld [$C0A0], a
    xor a, a
    ld [$C0A1], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4171::
    ld a, [$C921]
    ld l, a
    ld a, [$C922]
    ld h, a
    dec hl
    ld a, l
    ld [$C921], a
    ld a, h
    ld [$C922], a
    ld a, l
    or a, h
    ret nz
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_418E::
    xor a, a
    ld [$CB7D], a
    xor a, a
    ld [$CBCF], a
    ld a, $E0
    ldh [$FF8E], a
    ld [$C8F0], a
    ld hl, $8800
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0801
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    xor a, a
    ld [$C528], a
    ld a, $FB
    ld [$C529], a
    ld hl, Func_028_402B
    ld b, $28
    rst $10
    ld hl, $C198
    ld a, $C3
    ld bc, $0168
    call Func_000_0949
    ld hl, $C252
    ld b, $08
    ld a, $80

Jump_00F_41D4::
    ld [hl+], a
    inc a
    dec b
    jr nz, Jump_00F_41D4
    ld a, [$C525]
    or a, a
    jr z, Jump_00F_41F1
    ld a, $02
    ldh [$FF70], a
    ld hl, $D000
    xor a, a
    ld bc, $0168
    call Func_000_0949
    ld a, $00
    ldh [$FF70], a

Jump_00F_41F1::
    ld a, [$C524]
    or a, a
    jr z, Jump_00F_423E
    xor a, a
    ldh [$FF47], a
    ldh [$FF48], a
    ldh [$FF49], a
    ld a, [$C51F]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    ld [$C577], a
    ld a, h
    ld [$C578], a
    inc hl
    ld a, l
    ld [$C579], a
    ld a, h
    ld [$C57A], a
    inc hl
    ld a, l
    ld [$C57B], a
    ld a, h
    ld [$C57C], a
    inc hl
    ld a, l
    ld [$C57D], a
    ld a, h
    ld [$C57E], a
    call Func_000_05D1
    ld hl, Func_017_421A
    ld b, $17
    rst $10
    ld hl, $425E
    ld de, $C4FF
    ld bc, $0008
    call Func_000_0952

Jump_00F_423E::
    ld hl, Func_05F_6DDB
    ld b, $5F
    rst $10
    ld a, $FE
    call Func_000_0DF2
    ld hl, $0258
    ld a, l
    ld [$C921], a
    ld a, h
    ld [$C922], a
    ld a, $01
    ld [$C837], a
    ld hl, $C923
    inc [hl]
    ret
    db $DE, $67, $1F, $33, $3C, $12, $00, $00

Jump_00F_4266::
    ld a, [$C56C]
    or a, a
    ret nz
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4270::
    ld a, $3F
    call Func_000_0DF2
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_427A::
    ld de, $CBD4
    call Func_00F_7EE9
    ld hl, $CBAC
    call Func_00F_7EC4
    ld a, [$CBAA]
    dec a
    dec a
    ld [$CBAA], a
    cp a, $40
    ret nz
    ld a, $E0
    ld [$CB8A], a
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_429F::
    ld de, $C8F1
    call Func_00F_7EE9
    ret nc
    ld a, $01
    add a, $B9
    ld l, a
    ld h, $0D
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_42B5::
    ld a, [$C8F0]
    dec a
    dec a
    ld [$C8F0], a
    cp a, $78
    ret nz
    ld a, $02
    ld [$C8EF], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_42CA::
    ld hl, $0DB8
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_42D5::
    ld a, [$C921]
    ld hl, $431F
    add a, l
    ld l, a
    jr nc, Jump_00F_42E0
    inc h

Jump_00F_42E0::
    ld a, [hl]
    xor a, $FF
    inc a
    ld c, a
    jr Jump_00F_42F9

Jump_00F_42E7::
    ld a, $01
    ld [$CBA6], a
    ld a, [$C921]
    ld hl, $431F
    add a, l
    ld l, a
    jr nc, Jump_00F_42F7
    inc h

Jump_00F_42F7::
    ld a, [hl]
    ld c, a

Jump_00F_42F9::
    ld a, [$CBAA]
    add a, c
    ld [$CBAA], a
    ldh a, [$FF8E]
    add a, c
    ldh [$FF8E], a
    ld a, [$CBD3]
    add a, c
    ld [$CBD3], a
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $40
    ret nz
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret
    db $01, $00, $01, $00, $01, $01, $00, $FF, $01, $00, $00, $FF, $00, $FF, $FF, $00
    db $01, $00, $00, $00, $01, $01, $FF, $00, $00, $FF, $00, $00, $00, $FF, $01, $00
    db $01, $00, $01, $00, $00, $01, $01, $01, $00, $00, $FF, $00, $00, $00, $FF, $01
    db $FF, $00, $00, $01, $FF, $FF, $FF, $00, $00, $00, $FF, $00, $00, $FF, $FF, $00

Jump_00F_435F::
    ld a, [$C921]
    or a, a
    jr nz, Jump_00F_4376
    ld a, $02
    ldh [$FF98], a
    ldh a, [$FF91]
    dec a
    ldh [$FF91], a
    cp a, $30
    ret nz
    ld hl, $C921
    inc [hl]
    ret

Jump_00F_4376::
    ld a, $03
    ldh [$FF98], a
    ldh a, [$FF8E]
    dec a
    ldh [$FF8E], a
    cp a, $78
    ret nz
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_438B::
    ld de, $CBAB
    call Func_00F_7EE9
    ret nc
    ld hl, $0DB7
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_439D::
    ld a, $01
    ld [$C929], a
    ld a, [$C921]
    or a, a
    jr nz, Jump_00F_43C2
    ld a, $80
    ld [$C92A], a
    ld a, $40
    ld [$C928], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld hl, $C921
    inc [hl]
    ret

Jump_00F_43C2::
    ld a, $83
    ld [$C92A], a
    ld a, $58
    ld [$C928], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld a, $02
    ld [$CB96], a
    xor a, a
    ld [$CBA6], a
    ld hl, $0DB6
    call Func_00F_7F68
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_43EF::
    ld a, $01
    ld [$CB96], a
    ld [$CBA6], a
    ld de, $CBAB
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, Func_05F_6BCD
    ld b, $5F
    rst $10
    ld de, $CB9B
    call Func_00F_7EE9
    ret nc
    ld a, $03
    ld [$CB96], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4419::
    ld hl, $CB9C
    call Func_00F_7ED3
    ld hl, $CBAC
    call Func_00F_7ED3
    ld a, $80
    ld [$C928], a
    ld hl, Func_05F_6B17
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld a, $01
    add a, $B4
    ld l, a
    ld h, $0D
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4444::
    ld de, $CBAB
    call Func_00F_7EE9
    ret nc
    ld hl, $0DB3
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4456::
    ld de, $CB9B
    call Func_00F_7EE9
    ret nc
    ld hl, $0DB2
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4468::
    ld de, $CBAB
    call Func_00F_7EE9
    ret nc
    ld hl, $0DB1
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_447A::
    ld de, $CB9B
    call Func_00F_7EE9
    ret nc
    ld hl, $0DB0
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_448C::
    ld hl, Func_073_734D
    ld b, $73
    rst $10
    ret

Jump_00F_4493::
    ld a, $01
    ldh [$FFC6], a
    ld hl, Func_012_6B98
    ld b, $12
    rst $10
    ld a, $68
    ld [$CBD3], a
    ld a, $30
    ld [$CBD4], a
    ld a, $80
    ld [$CBCF], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_44B1::
    ld a, $10
    call Func_000_0DF2
    ld a, $00
    ld [$C5DB], a
    ld a, $08
    ld [$C5DC], a
    ld hl, $C5DF
    inc [hl]
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_44C9::
    ld a, $01
    ldh [$FF98], a
    ld b, $78
    call Func_00F_7EB2
    ret nc
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_44D8::
    ld a, $80
    ld [$CBCF], a
    ld hl, $CBD4
    dec [hl]
    ld de, $CBD4
    call Func_00F_7EE9
    ret nc
    ld hl, $0549
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_44F3::
    ld a, $03
    ldh [$FF98], a
    ld de, $FF91
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, Func_05F_6BCD
    ld b, $5F
    rst $10
    ld de, $CBAB
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, Func_05F_6BCD
    ld b, $5F
    rst $10
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $20
    ret nz
    ld hl, $0548
    call Func_00F_7F68
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4532::
    ld de, $0018
    ld a, [$C921]
    ld l, a
    ld a, [$C922]
    ld h, a
    add hl, de
    ld a, l
    ld [$C921], a
    ld a, h
    ld [$C922], a
    ld c, h
    ld a, [$CBBB]
    add a, c
    ld [$CBBB], a
    ld a, [$CBBA]
    inc a
    inc a
    ld [$CBBA], a
    cp a, $40
    ret nz
    ld a, $40
    ld [$CBBB], a
    xor a, a
    ld [$C921], a
    ld [$C922], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_456A::
    ld a, $13
    ldh [$FFC6], a
    ld hl, Func_012_6B98
    ld b, $12
    rst $10
    ld a, $40
    ld [$CBD3], a
    ld [$CBD4], a
    ld hl, $FE80
    ld a, l
    ld [$C921], a
    ld a, h
    ld [$C922], a
    ld a, $65
    call Func_000_1278
    ld a, $0E
    ldh [$FF8D], a
    ld hl, $C923
    inc [hl]
    ret

Func_00F_4595::
    ld a, [$C923]
    rst $00
    dw Jump_00F_5175
    dw Jump_00F_516A
    dw Jump_00F_512E
    dw Jump_00F_5122
    dw Jump_00F_516A
    dw Jump_00F_516A
    dw Jump_00F_511E
    dw Jump_00F_5113
    dw Jump_00F_7F89
    dw Jump_00F_5108
    dw Jump_00F_7F89
    dw Jump_00F_50D9
    dw Jump_00F_50D2
    dw Jump_00F_50BE
    dw Jump_00F_516A
    dw Jump_00F_50B8
    dw Jump_00F_50A9
    dw Jump_00F_7F89
    dw Jump_00F_516A
    dw Jump_00F_5097
    dw Jump_00F_516A
    dw Jump_00F_516A
    dw Jump_00F_5087
    dw Jump_00F_7F89
    dw Jump_00F_507C
    dw Jump_00F_50A0
    dw Jump_00F_505D
    dw Jump_00F_503E
    dw Jump_00F_505D
    dw Jump_00F_503E
    dw Jump_00F_505D
    dw Jump_00F_503E
    dw Jump_00F_505D
    dw Jump_00F_5020
    dw Jump_00F_7F89
    dw Jump_00F_4FF1
    dw Jump_00F_516A
    dw Jump_00F_4FCF
    dw Jump_00F_7F89
    dw Jump_00F_516A
    dw Jump_00F_5217
    dw Jump_00F_4FBB
    dw Jump_00F_7F89
    dw Jump_00F_5217
    dw Jump_00F_4F93
    dw Jump_00F_4F72
    dw Jump_00F_4F54
    dw Jump_00F_4F2D
    dw Jump_00F_516A
    dw Jump_00F_4F06
    dw Jump_00F_516A
    dw Jump_00F_516A
    dw Jump_00F_4EF7
    dw Jump_00F_4EDA
    dw Jump_00F_4ECA
    dw Jump_00F_4EA6
    dw Jump_00F_4E91
    dw Jump_00F_4E70
    dw Jump_00F_4E3D
    dw Jump_00F_4E31
    dw Jump_00F_4E15
    dw Jump_00F_516A
    dw Jump_00F_4F06
    dw Jump_00F_516A
    dw Jump_00F_516A
    dw Jump_00F_4E08
    dw Jump_00F_4DE7
    dw Jump_00F_4D87
    dw Jump_00F_516A
    dw Jump_00F_4D7B
    dw Jump_00F_4D7B
    dw Jump_00F_516A
    dw Jump_00F_4D1B
    dw Jump_00F_516A
    dw Jump_00F_4C56
    dw Jump_00F_4C4A
    dw Jump_00F_516A
    dw Jump_00F_4F06
    dw Jump_00F_516A
    dw Jump_00F_516A
    dw Jump_00F_4C3D
    dw Jump_00F_4C20
    dw Jump_00F_516A
    dw Jump_00F_4BEE
    dw Jump_00F_4BB6
    dw Jump_00F_4B8F
    dw Jump_00F_4B45
    dw Jump_00F_516A
    dw Jump_00F_4F06
    dw Jump_00F_516A
    dw Jump_00F_516A
    dw Jump_00F_4B38
    dw Jump_00F_4B1B
    dw Jump_00F_516A
    dw Jump_00F_516A
    dw Jump_00F_4AE3
    dw Jump_00F_4AD7
    dw Jump_00F_516A
    dw Jump_00F_4AB3
    dw Jump_00F_4A74
    dw Jump_00F_516A
    dw Jump_00F_4A09
    dw Jump_00F_49D5
    dw Jump_00F_516A
    dw Jump_00F_499C
    dw Jump_00F_516A
    dw Jump_00F_4F06
    dw Jump_00F_516A
    dw Jump_00F_516A
    dw Jump_00F_4985
    dw Jump_00F_4968
    dw Jump_00F_516A
    dw Jump_00F_4949
    dw Jump_00F_490E
    dw Jump_00F_516A
    dw Jump_00F_48EA
    dw Jump_00F_516A
    dw Jump_00F_48DE
    dw Jump_00F_48B7
    dw Jump_00F_516A
    dw Jump_00F_487C
    dw Jump_00F_485D
    dw Jump_00F_516A
    dw Jump_00F_4F06
    dw Jump_00F_516A
    dw Jump_00F_516A
    dw Jump_00F_4846
    dw Jump_00F_4829
    db $6A, $51
    dw Func_00F_47F5
    dw Func_00F_47BC
    dw Func_00F_47A8
    dw Func_00F_4774
    INCBIN "dwm2-cobi-us.gbc", $03C6A3, $D1

Func_00F_4774:: ; heuristic: target of a pointer table; C0
    ld a, $02
    ld [$C929], a
    ld a, $B0
    ld [$C928], a
    ld a, $81
    ld [$C92A], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, $03
    ld [$C929], a
    ld a, $C0
    ld [$C928], a
    ld a, $81
    ld [$C92A], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld hl, $C923
    inc [hl]
    ret

Func_00F_47A8:: ; heuristic: target of a pointer table; C0
    ld de, $CBAB
    call Func_00F_7EE9
    push af
    ld a, [$CBAB]
    ld [$CBBB], a
    pop af
    ret nc
    ld hl, $C923
    inc [hl]
    ret

Func_00F_47BC:: ; heuristic: target of a pointer table; C0
    ld a, [$C921]
    cp a, $1E
    jr nc, Jump_00F_47C9
    bit 1, a
    jr z, Jump_00F_47D9
    jr Jump_00F_47E0

Jump_00F_47C9::
    cp a, $3C
    jr nc, Jump_00F_47D3
    bit 2, a
    jr z, Jump_00F_47D9
    jr Jump_00F_47E0

Jump_00F_47D3::
    bit 3, a
    jr z, Jump_00F_47D9
    jr Jump_00F_47E0

Jump_00F_47D9::
    ld a, $E0
    ld [$CB9B], a
    jr Jump_00F_47E5

Jump_00F_47E0::
    ld a, $40
    ld [$CB9B], a

Jump_00F_47E5::
    ld b, $78
    call Func_00F_7EB2
    ret nc
    ld a, $40
    ld [$CB9B], a
    ld hl, $C923
    inc [hl]
    ret

Func_00F_47F5:: ; heuristic: target of a pointer table; C0
    ld a, $02
    ld [$C929], a
    ld a, $40
    ld [$C928], a
    ld a, $03
    ld [$C92A], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, $03
    ld [$C929], a
    ld a, $50
    ld [$C928], a
    ld a, $03
    ld [$C92A], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4829::
    ld a, $11
    ldh [$FFC6], a
    ld hl, Func_012_6B98
    ld b, $12
    rst $10
    ld a, $20
    ld [$CBD3], a
    ld a, $40
    ld [$CBD4], a
    xor a, a
    ld [$CBCF], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4846::
    ld a, $71
    ldh [$FF90], a
    xor a, a
    ldh [$FF8F], a
    ldh [$FF92], a
    ld a, $40
    ld [$CBD3], a
    ld a, $30
    ld [$CBD4], a
    call Func_00F_4FA1
    ret

Jump_00F_485D::
    ld a, $00
    ld [$C929], a
    ld a, $60
    ld [$C928], a
    ld a, $00
    ld [$C92A], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_487C::
    ld a, $01
    ld [$C929], a
    ld a, $30
    ld [$C928], a
    ld a, $03
    ld [$C92A], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, $02
    ld [$C929], a
    ld a, $60
    ld [$C928], a
    ld a, $01
    ld [$C92A], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    xor a, a
    ld [$CB96], a
    ld [$CBA6], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_48B7::
    ld a, $00
    ld [$C929], a
    ld a, $50
    ld [$C928], a
    ld a, $00
    ld [$C92A], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld a, $02
    ld [$CB96], a
    ld [$CBA6], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_48DE::
    ld a, $40
    ld [$C928], a
    ld a, $03
    ld [$C92A], a
    jr Jump_00F_48F4

Jump_00F_48EA::
    ld a, $50
    ld [$C928], a
    ld a, $01
    ld [$C92A], a

Jump_00F_48F4::
    ld a, $04
    ld [$C929], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld a, $02
    ld [$CBC6], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_490E::
    ld a, $01
    ld [$C929], a
    ld a, $40
    ld [$C928], a
    ld a, $81
    ld [$C92A], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, $02
    ld [$C929], a
    ld a, $50
    ld [$C928], a
    ld a, $83
    ld [$C92A], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    xor a, a
    ld [$CB96], a
    ld [$CBA6], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4949::
    ld a, $04
    ld [$C929], a
    ld a, $70
    ld [$C928], a
    ld a, $02
    ld [$C92A], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4968::
    ld a, $11
    ldh [$FFC6], a
    ld hl, Func_012_6B98
    ld b, $12
    rst $10
    ld a, $40
    ld [$CBD3], a
    ld a, $60
    ld [$CBD4], a
    xor a, a
    ld [$CBCF], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4985::
    ld a, $60
    ldh [$FF90], a
    xor a, a
    ldh [$FF8F], a
    ldh [$FF92], a
    ld a, $40
    ld [$CBD3], a
    ld a, $30
    ld [$CBD4], a
    call Func_00F_4FA1
    ret

Jump_00F_499C::
    ld a, [$C921]
    cp a, $1E
    jr nc, Jump_00F_49A9
    bit 1, a
    jr z, Jump_00F_49B9
    jr Jump_00F_49C0

Jump_00F_49A9::
    cp a, $3C
    jr nc, Jump_00F_49B3
    bit 2, a
    jr z, Jump_00F_49B9
    jr Jump_00F_49C0

Jump_00F_49B3::
    bit 3, a
    jr z, Jump_00F_49B9
    jr Jump_00F_49C0

Jump_00F_49B9::
    ld a, $E0
    ld [$CB8B], a
    jr Jump_00F_49C5

Jump_00F_49C0::
    ld a, $30
    ld [$CB8B], a

Jump_00F_49C5::
    ld b, $78
    call Func_00F_7EB2
    ret nc
    ld a, $30
    ld [$CB8B], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_49D5::
    ld a, $03
    ld [$C929], a
    ld a, $B0
    ld [$C928], a
    ld a, $80
    ld [$C92A], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, $04
    ld [$C929], a
    ld a, $B0
    ld [$C928], a
    ld a, $80
    ld [$C92A], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4A09::
    ld a, [$C921]
    or a, a
    jr nz, Jump_00F_4A42
    ld a, $02
    ld [$C929], a
    ld a, $40
    ld [$C928], a
    ld a, $83
    ld [$C92A], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$CBAA]
    ld [$CB9A], a
    ld a, [$C92C]
    or a, a
    ret z
    xor a, a
    ld [$CB96], a
    ld a, $01
    ld [$CBB6], a
    ld a, $03
    ld [$CBC6], a
    ld hl, $C921
    inc [hl]
    ret

Jump_00F_4A42::
    ld a, $02
    ld [$C929], a
    ld a, $C0
    ld [$C928], a
    ld a, $80
    ld [$C92A], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$CBAB]
    sub a, $08
    ld [$CB9B], a
    ld a, [$C92C]
    or a, a
    ret z
    xor a, a
    ld [$CBB6], a
    ld [$CBC6], a
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4A74::
    ld a, [$C921]
    and a, $03
    jr nz, Jump_00F_4A7F
    ld hl, $CB9B
    dec [hl]

Jump_00F_4A7F::
    ld a, [$C921]
    and a, $01
    jr nz, Jump_00F_4A8A
    ld hl, $CB9A
    inc [hl]

Jump_00F_4A8A::
    ld de, $CB9B
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, Func_05F_6BCD
    ld b, $5F
    rst $10
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $20
    ret nz
    ld a, $03
    ld [$CB96], a
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4AB3::
    ld a, $01
    ld [$C929], a
    ld a, $70
    ld [$C928], a
    ld a, $00
    ld [$C92A], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld a, $01
    ld [$CB96], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4AD7::
    ld de, $CB9B
    call Func_00F_7EE9
    ret nc
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4AE3::
    ld a, $03
    ld [$C929], a
    ld a, $80
    ld [$C928], a
    ld a, $02
    ld [$C92A], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, $04
    ld [$C929], a
    ld a, $80
    ld [$C928], a
    ld a, $02
    ld [$C92A], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    xor a, a
    ld [$CB96], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4B1B::
    ld a, $11
    ldh [$FFC6], a
    ld hl, Func_012_6B98
    ld b, $12
    rst $10
    ld a, $40
    ld [$CBD3], a
    ld a, $30
    ld [$CBD4], a
    xor a, a
    ld [$CBCF], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4B38::
    ld a, $49
    ldh [$FF90], a
    xor a, a
    ldh [$FF8F], a
    ldh [$FF92], a
    call Func_00F_4FA1
    ret

Jump_00F_4B45::
    ld a, [$C921]
    and a, $03
    jr nz, Jump_00F_4B64
    ld a, [$CB86]
    inc a
    and a, $03
    ld [$CB86], a
    ld a, [$CB96]
    inc a
    and a, $03
    ld [$CB96], a
    ld [$CBA6], a
    ld [$CBB6], a

Jump_00F_4B64::
    ld de, $CB9B
    call Func_00F_7EE9
    push af
    ld a, [$CB9B]
    ld [$CBAB], a
    ld [$CBBB], a
    sub a, $30
    ld [$CB8B], a
    pop af
    ret nc
    ld a, $02
    ld [$CB96], a
    ld [$CBA6], a
    ld [$CBB6], a
    xor a, a
    ld [$CB86], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4B8F::
    ld a, [$C921]
    inc a
    ld [$C921], a
    and a, $03
    ret nz
    ld a, [$CB9A]
    inc a
    ld [$CB9A], a
    add a, $10
    ld [$CBAA], a
    add a, $10
    ld [$CBBA], a
    cp a, $60
    ret nz
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4BB6::
    ld a, [$C921]
    and a, $03
    jr nz, Jump_00F_4BCC
    ld a, [$CB96]
    inc a
    and a, $03
    ld [$CB96], a
    ld [$CBA6], a
    ld [$CBB6], a

Jump_00F_4BCC::
    ld de, $CB9B
    call Func_00F_7EE9
    push af
    ld a, [$CB9B]
    ld [$CBAB], a
    ld [$CBBB], a
    pop af
    ret nc
    ld a, $01
    ld [$CB96], a
    ld [$CBA6], a
    ld [$CBB6], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4BEE::
    ld a, $03
    ld [$CB96], a
    ld [$CBA6], a
    ld [$CBB6], a
    ld a, [$C921]
    inc a
    ld [$C921], a
    and a, $03
    ret nz
    ld a, [$CB9A]
    dec a
    ld [$CB9A], a
    add a, $10
    ld [$CBAA], a
    add a, $10
    ld [$CBBA], a
    cp a, $50
    ret nz
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4C20::
    ld a, $11
    ldh [$FFC6], a
    ld hl, Func_012_6B98
    ld b, $12
    rst $10
    ld a, $40
    ld [$CBD3], a
    ld a, $20
    ld [$CBD4], a
    xor a, a
    ld [$CBCF], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4C3D::
    ld a, $41
    ldh [$FF90], a
    xor a, a
    ldh [$FF8F], a
    ldh [$FF92], a
    call Func_00F_4FA1
    ret

Jump_00F_4C4A::
    ld de, $CBBB
    call Func_00F_7EE9
    ret nc
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4C56::
    ld a, [$C921]
    or a, a
    jr nz, Jump_00F_4C90
    ld a, $60
    ld [$C928], a
    ld a, $02
    ld [$C929], a
    ld a, $02
    ld [$C92A], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, $60
    ld [$C928], a
    ld a, $01
    ld [$C929], a
    ld a, $02
    ld [$C92A], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld hl, $C921
    inc [hl]
    ret

Jump_00F_4C90::
    dec a
    jr nz, Jump_00F_4CDA
    ld a, [$CBAB]
    cp a, $60
    jr z, Jump_00F_4CA6
    ld a, $60
    ld [$C928], a
    ld a, $02
    ld [$C92A], a
    jr Jump_00F_4CB0

Jump_00F_4CA6::
    ld a, $20
    ld [$C928], a
    ld a, $03
    ld [$C92A], a

Jump_00F_4CB0::
    ld a, $02
    ld [$C929], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, $20
    ld [$C928], a
    ld a, $01
    ld [$C929], a
    ld a, $03
    ld [$C92A], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld hl, $C921
    inc [hl]
    ret

Jump_00F_4CDA::
    ld a, $20
    ld [$C928], a
    ld a, $02
    ld [$C929], a
    ld a, $03
    ld [$C92A], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, $50
    ld [$C928], a
    ld a, $01
    ld [$C929], a
    ld a, $02
    ld [$C92A], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    xor a, a
    ld [$CBB6], a
    ld a, $02
    ld [$CBA6], a
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4D1B::
    ld a, $01
    ld [$C929], a
    ld a, [$C921]
    or a, a
    jr nz, Jump_00F_4D40
    ld a, $60
    ld [$C928], a
    ld a, $80
    ld [$C92A], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld hl, $C921
    inc [hl]
    ret

Jump_00F_4D40::
    dec a
    jr nz, Jump_00F_4D5D
    ld a, $40
    ld [$C928], a
    ld a, $81
    ld [$C92A], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld hl, $C921
    inc [hl]
    ret

Jump_00F_4D5D::
    ld a, $B0
    ld [$C928], a
    ld a, $80
    ld [$C92A], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4D7B::
    ld de, $CB9B
    call Func_00F_7EE9
    ret nc
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4D87::
    ld a, $01
    ld [$C929], a
    ld a, [$C921]
    or a, a
    jr nz, Jump_00F_4DAC
    ld a, $60
    ld [$C928], a
    ld a, $02
    ld [$C92A], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld hl, $C921
    inc [hl]
    ret

Jump_00F_4DAC::
    dec a
    jr nz, Jump_00F_4DC9
    ld a, $20
    ld [$C928], a
    ld a, $03
    ld [$C92A], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld hl, $C921
    inc [hl]
    ret

Jump_00F_4DC9::
    ld a, $50
    ld [$C928], a
    ld a, $02
    ld [$C92A], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4DE7::
    ld a, $11
    ldh [$FFC6], a
    ld hl, Func_012_6B98
    ld b, $12
    rst $10
    ld a, $20
    ld [$CBD3], a
    ld a, $40
    ld [$CBD4], a
    xor a, a
    ld [$CBCF], a
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4E08::
    ld a, $33
    ldh [$FF90], a
    xor a, a
    ldh [$FF8F], a
    ldh [$FF92], a
    call Func_00F_4FA1
    ret

Jump_00F_4E15::
    ld a, $03
    ld [$CBA6], a
    ld a, [$CBAA]
    dec a
    ld [$CBAA], a
    ld de, $CBAB
    call Func_00F_7EE9
    ret nc
    xor a, a
    ld [$CBA6], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4E31::
    ld a, $02
    ld [$C929], a
    ld a, $60
    ld [$C928], a
    jr Jump_00F_4EB0

Jump_00F_4E3D::
    ld a, $00
    ld [$C929], a
    ld a, $E0
    ld [$C928], a
    ld a, $83
    ld [$C92A], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, $01
    ld [$CB96], a
    ld hl, $CB9A
    inc [hl]
    ld de, $CB9B
    call Func_00F_7EE9
    ret nc
    xor a, a
    ld [$CB96], a
    ld a, $30
    ld [$CBAB], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4E70::
    ld a, $00
    ld [$C929], a
    ld a, $E0
    ld [$C928], a
    ld a, $83
    ld [$C92A], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, $01
    ld [$C929], a
    ld a, $60
    ld [$C928], a
    jr Jump_00F_4EB0

Jump_00F_4E91::
    ld hl, $CB8A
    dec [hl]
    ld de, $CB8B
    call Func_00F_7EE9
    ret nc
    ld a, $30
    ld [$CB9B], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4EA6::
    ld a, $00
    ld [$C929], a
    ld a, $60
    ld [$C928], a

Jump_00F_4EB0::
    ld a, $80
    ld [$C92A], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld a, $03
    ld [$CB86], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4ECA::
    ld b, $5A
    call Func_00F_7EB2
    ret nc
    ld a, $30
    ld [$CB8B], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4EDA::
    ld a, $11
    ldh [$FFC6], a
    ld hl, Func_012_6B98
    ld b, $12
    rst $10
    ld a, $30
    ld [$CBD3], a
    ld a, $60
    ld [$CBD4], a
    xor a, a
    ld [$CBCF], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4EF7::
    ld a, $2F
    ldh [$FF90], a
    ld a, $01
    ldh [$FF8F], a
    xor a, a
    ldh [$FF92], a
    call Func_00F_4FA1
    ret

Jump_00F_4F06::
    ld a, $80
    ld [$CBCF], a
    ld a, [$C921]
    inc a
    ld [$C921], a
    and a, $01
    jr z, Jump_00F_4F1A
    ld hl, $CBD4
    dec [hl]

Jump_00F_4F1A::
    ld a, [$C921]
    cp a, $40
    ret nz
    xor a, a
    ld [$CBCF], a
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4F2D::
    ld a, [$C921]
    and a, $07
    jr nz, Jump_00F_4F40
    ld a, [$CBB6]
    inc a
    and a, $03
    ld [$CBB6], a
    ld [$CBC6], a

Jump_00F_4F40::
    ld de, $CBAB
    call Func_00F_7EE9
    ret nc
    ld a, $02
    ld [$CBB6], a
    ld [$CBC6], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4F54::
    ld a, [$C921]
    and a, $03
    jr nz, Jump_00F_4F67
    ld a, [$CBB6]
    inc a
    and a, $03
    ld [$CBB6], a
    ld [$CBC6], a

Jump_00F_4F67::
    ld b, $96
    call Func_00F_7EB2
    ret nc
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4F72::
    ld a, $11
    ldh [$FFC6], a
    ld hl, Func_012_6B98
    ld b, $12
    rst $10
    ld a, $40
    ld [$CBD3], a
    ld a, $10
    ld [$CBD4], a
    xor a, a
    ld [$CBCF], a
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4F93::
    ld a, $01
    ld [$C90F], a
    ld a, $26
    ldh [$FF90], a
    xor a, a
    ldh [$FF8F], a
    ldh [$FF92], a

Func_00F_4FA1::
    ld a, $E0
    ld [$C8C8], a
    ldh a, [$FF91]
    ld [$C8C9], a
    ld a, $04
    ld [$C8C6], a
    ld hl, Func_05F_6C5A
    ld b, $5F
    rst $10
    xor a, a
    ld [$CBCF], a
    ret

Jump_00F_4FBB::
    ld a, $01
    ld [$C90F], a
    ld hl, $053A
    call Func_00F_7F68
    xor a, a
    ld [$CBCF], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4FCF::
    ld a, $01
    ld [$C90F], a
    ld hl, $0539
    call Func_00F_7F68
    ld a, $11
    ldh [$FFC6], a
    ld hl, Func_012_6B98
    ld b, $12
    rst $10
    xor a, a
    ld [$CBCF], a
    xor a, a
    ld [$C92D], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_4FF1::
    xor a, a
    ld [$C90F], a
    ldh a, [$FF91]
    cp a, $40
    jr z, Jump_00F_5007
    ld a, $40
    ld [$C928], a
    ld hl, Func_05F_6A94
    ld b, $5F
    rst $10
    ret

Jump_00F_5007::
    ld a, $80
    ld [$C928], a
    ld hl, Func_05F_6ABF
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld a, $03
    ldh [$FF98], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_5020::
    ld a, $01
    ld [$CB86], a
    ld hl, $0538
    call Func_00F_7F68
    ld a, $01
    ld [$C90F], a
    ld a, [$C933]
    ld [$C6FD], a
    xor a, a
    ldh [$FF8D], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_503E::
    ld a, $00
    ld [$C929], a
    ld a, $00
    ld [$C92A], a
    ld a, $40
    ld [$C928], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_505D::
    ld a, $00
    ld [$C929], a
    ld a, $02
    ld [$C92A], a
    ld a, $20
    ld [$C928], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_507C::
    xor a, a
    ld [$C90F], a
    ld de, $FF91
    call Func_00F_7F0B
    ret

Jump_00F_5087::
    ld a, $01
    ld [$C90F], a
    ld hl, $0537
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_5097::
    ld a, $0C
    ld [$C90D], a
    xor a, a
    ld [$C90E], a

Jump_00F_50A0::
    xor a, a
    ld [$C90F], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_50A9::
    xor a, a
    ld [$C90F], a
    ld hl, $0DF7
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_50B8::
    ld b, $0F
    call Func_00F_72A0
    ret

Jump_00F_50BE::
    ld a, $30
    ld [$CB9B], a
    xor a, a
    ld [$CBCF], a
    ld hl, Func_05F_6E09
    ld b, $5F
    rst $10
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_50D2::
    ld hl, Func_05F_7363
    ld b, $5F
    rst $10
    ret

Jump_00F_50D9::
    ld a, $05
    ldh [$FF90], a
    ld a, $01
    ldh [$FF8F], a
    xor a, a
    ldh [$FF92], a
    ld a, $50
    ld [$C8C8], a
    ld a, $30
    ld [$C8C9], a
    ld a, $04
    ld [$C8C6], a
    xor a, a
    ld [$CCE9], a
    ld hl, Func_05F_6C5A
    ld b, $5F
    rst $10
    ld hl, $0533
    call Func_00F_7F68
    xor a, a
    ld [$C92D], a
    ret

Jump_00F_5108::
    ld hl, $055B
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_5113::
    ld hl, $055A
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_511E::
    ld hl, $CB8B
    inc [hl]

Jump_00F_5122::
    ld de, $CB8B
    call Func_00F_7EE9
    ret nc
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_512E::
    ldh a, [$FF8E]
    cp a, $40
    jr z, Jump_00F_5140
    ld a, $40
    ld [$C928], a
    ld hl, Func_05F_6B17
    ld b, $5F
    rst $10
    ret

Jump_00F_5140::
    ld a, $20
    ld [$C928], a
    ld hl, Func_05F_6AEB
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld a, $10
    ld [$CB8B], a
    ld a, $54
    ld [$C1C8], a
    ld a, $55
    ld [$C1C9], a
    ld hl, Func_05F_6DDB
    ld b, $5F
    rst $10
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_516A::
    ld b, $3C
    call Func_00F_7EB2
    ret nc
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_5175::
    ld a, $01
    ldh [$FFC6], a
    ld a, $30
    ldh [$FFC7], a
    ld hl, Func_05F_6BF8
    ld b, $5F
    rst $10
    ldh a, [$FFC6]
    or a, a
    ret z
    ld a, $01
    ld [$CB7D], a
    ld de, $00D1
    call Func_000_1845
    ld a, [$CC3C]
    set 0, a
    ld [$CC3C], a
    ld hl, $C923
    inc [hl]
    ret
    INCBIN "dwm2-cobi-us.gbc", $03D19F, $78

Jump_00F_5217::
    xor a, a
    ld [$C90F], a
    ld a, $80
    ld [$CBCF], a
    ld a, [$C922]
    and a, $0F
    rst $00
    dw Jump_00F_522A
    dw Jump_00F_526C

Jump_00F_522A::
    ld a, [$C92D]
    bit 0, a
    jr z, Jump_00F_5236
    inc a
    ld [$C92D], a
    ret

Jump_00F_5236::
    and a, $FE
    ld de, $5284
    add a, e
    ld e, a
    jr nc, Jump_00F_5240
    inc d

Jump_00F_5240::
    push de
    ld a, [$C922]
    and a, $70
    swap a
    ld c, $30
    call Func_000_1682
    pop de
    add hl, de
    ld a, [hl+]
    ld [$CBD4], a
    ld a, [hl]
    ld [$CBD3], a
    ld a, [$C92D]
    inc a
    ld [$C92D], a
    srl a
    cp a, $17
    ret nz
    xor a, a
    ld [$C92D], a
    ld hl, $C922
    inc [hl]
    ret

Jump_00F_526C::
    ld a, [$C922]
    add a, $10
    and a, $F0
    cp a, $80
    jr nz, Jump_00F_5280
    xor a, a
    ld [$C92D], a
    ld hl, $C923
    inc [hl]
    xor a, a

Jump_00F_5280::
    ld [$C922], a
    ret
    INCBIN "dwm2-cobi-us.gbc", $03D284, $180

Func_00F_5404::
    ld a, [$C923]
    rst $00
    dw Jump_00F_56C2
    dw Jump_00F_56BC
    dw Jump_00F_56B1
    dw Jump_00F_7F89
    dw Jump_00F_5662
    dw Jump_00F_7F89
    dw Jump_00F_5657
    dw Jump_00F_7F89
    dw Jump_00F_564D
    dw Jump_00F_7F89
    dw Jump_00F_5642
    dw Jump_00F_7F89
    dw Jump_00F_5612
    dw Jump_00F_7F89
    dw Jump_00F_55E5
    dw Jump_00F_7F89
    dw Jump_00F_55DA
    dw Jump_00F_7F89
    dw Jump_00F_55CF
    dw Jump_00F_7F89
    dw Jump_00F_55B8
    dw Jump_00F_55A7
    dw Jump_00F_5577
    dw Jump_00F_5558
    dw Jump_00F_554E
    dw Jump_00F_7F89
    dw Jump_00F_5543
    dw Jump_00F_7F89
    dw Jump_00F_5538
    dw Jump_00F_7F89
    dw Jump_00F_550B
    dw Jump_00F_7F89
    dw Jump_00F_55B3
    dw Jump_00F_55AC
    dw Jump_00F_54E0
    dw Jump_00F_7F89
    dw Jump_00F_56C2
    dw Jump_00F_56BC
    dw Jump_00F_54D5
    dw Jump_00F_7F89
    dw Jump_00F_549F
    dw Jump_00F_7F89
    dw Jump_00F_5495
    dw Jump_00F_5460

Jump_00F_5460::
    xor a, a
    call Func_00F_7F75
    ret nc
    ld a, $05
    ldh [$FFC6], a
    ld hl, Func_05F_6DAC
    ld b, $5F
    rst $10
    ld a, [$CC37]
    set 4, a
    ld [$CC37], a
    ld hl, Func_012_6990
    ld b, $12
    rst $10
    ld a, $06
    ldh [$FFC7], a
    ld hl, Func_012_6955
    ld b, $12
    rst $10
    ld a, [$C836]
    set 7, a
    ld [$C836], a
    ld a, $80
    ld [$C919], a
    ret

Jump_00F_5495::
    ld de, $FF91
    ld hl, $0A7E
    call Func_00F_7F24
    ret

Jump_00F_549F::
    ld a, $01
    ld [$C929], a
    ld a, $81
    ld [$C92A], a
    ld a, $B0
    ld [$C928], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld de, $00C3
    call Func_000_1845
    ld hl, Func_002_6050
    ld b, $02
    rst $10
    ld a, $01
    ld [$CB7D], a
    ld hl, $0A7D
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_54D5::
    ld hl, $0A7C
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_54E0::
    ld hl, Func_012_64F8
    ld b, $12
    rst $10
    ld hl, Func_002_5E85
    ld b, $02
    rst $10
    ld hl, Func_002_5E85
    ld b, $02
    rst $10
    call Func_000_222B
    ld hl, Func_004_4AA8
    ld b, $04
    rst $10
    ld a, $7F
    ld [$C527], a
    ld hl, $0A7B
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_550B::
    ld a, $05
    ldh [$FF90], a
    ld a, $01
    ldh [$FF8F], a
    xor a, a
    ldh [$FF92], a
    ld a, $50
    ld [$C8C8], a
    ld a, $30
    ld [$C8C9], a
    ld de, $0024
    call Func_000_1845
    ld a, $04
    ld [$C8C6], a
    ld hl, Func_05F_6C5A
    ld b, $5F
    rst $10
    ld hl, $0A7A
    call Func_00F_7F68
    ret

Jump_00F_5538::
    ld hl, $0491
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_5543::
    ld hl, $0490
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_554E::
    ld de, $CBAB
    ld hl, $048F
    call Func_00F_7F24
    ret

Jump_00F_5558::
    ld a, [$C921]
    swap a
    srl a
    srl a
    and a, $01
    add a, a
    inc a
    ld [$CB86], a
    ld b, $B4
    call Func_00F_7EB2
    ret nc
    xor a, a
    ld [$CB86], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_5577::
    ld a, [$CC3B]
    set 3, a
    ld [$CC3B], a
    ld de, $00C2
    call Func_000_1845
    ldh a, [$FF8E]
    ld [$C8C8], a
    ldh a, [$FF91]
    ld [$C8C9], a
    ld a, $01
    call Func_000_0DF2
    ld a, $03
    ld [$C8C6], a
    ld a, $04
    ld [$C5DC], a
    xor a, a
    ld [$C8C5], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_55A7::
    ld a, $01
    ld [$CB7D], a

Jump_00F_55AC::
    ld hl, Func_012_653F
    ld b, $12
    rst $10
    ret

Jump_00F_55B3::
    ld a, $7A
    call Func_000_1278

Jump_00F_55B8::
    ld a, [$C525]
    or a, a
    jr z, Jump_00F_55CA
    ld hl, $C49F
    ld de, $C0F0
    ld bc, $0040
    call Func_000_0952

Jump_00F_55CA::
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_55CF::
    ld hl, $048E
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_55DA::
    ld hl, $048D
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_55E5::
    ld a, [$C5F0]
    bit 2, a
    jr z, Jump_00F_55F2
    xor a, a
    ld [$CBCF], a
    jr Jump_00F_55F7

Jump_00F_55F2::
    ld a, $80
    ld [$CBCF], a

Jump_00F_55F7::
    ldh a, [$FF91]
    ld c, a
    ld a, [$CBD4]
    inc a
    ld [$CBD4], a
    cp a, c
    ret nz
    xor a, a
    ld [$CBCF], a
    ld hl, $048C
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_5612::
    ld a, [$C552]
    or a, a
    jr z, Jump_00F_5623
    ld hl, $C48A
    call Func_00F_7F68
    ld hl, $C923
    dec [hl]
    ret

Jump_00F_5623::
    ld hl, $848B
    call Func_00F_7F68
    ld a, $04
    ldh [$FFC6], a
    ld hl, Func_012_6B98
    ld b, $12
    rst $10
    ldh a, [$FF8E]
    ld [$CBD3], a
    ld a, $E0
    ld [$CBD4], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_5642::
    ld hl, $4487
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_564D::
    ld de, $CB8B
    ld hl, $0486
    call Func_00F_7F24
    ret

Jump_00F_5657::
    ld hl, $0485
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_5662::
    ld a, [$C921]
    or a, a
    jr nz, Jump_00F_566D
    ld a, $1F
    call Func_000_122D

Jump_00F_566D::
    ld a, $18
    ld [$CBBB], a
    ld a, [$C921]
    cp a, $1E
    jr nc, Jump_00F_567F
    bit 1, a
    jr z, Jump_00F_568F
    jr Jump_00F_5696

Jump_00F_567F::
    cp a, $3C
    jr nc, Jump_00F_5689
    bit 2, a
    jr z, Jump_00F_568F
    jr Jump_00F_5696

Jump_00F_5689::
    bit 3, a
    jr z, Jump_00F_568F
    jr Jump_00F_5696

Jump_00F_568F::
    ld a, $10
    ld [$CB9B], a
    jr Jump_00F_569B

Jump_00F_5696::
    ld a, $C0
    ld [$CB9B], a

Jump_00F_569B::
    ld b, $78
    call Func_00F_7EB2
    ret nc
    ld a, $02
    ld [$CB86], a
    ld hl, $0484
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_56B1::
    ld hl, $0483
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_56BC::
    ld b, $78
    call Func_00F_72A0
    ret

Jump_00F_56C2::
    ld hl, Func_05F_6E09
    ld b, $5F
    rst $10
    ld hl, $C923
    inc [hl]
    ret

Func_00F_56CD::
    ld a, [$C923]
    rst $00
    dw Jump_00F_5717
    dw Jump_00F_7F89
    dw Jump_00F_56F3
    dw Jump_00F_7F89
    dw Jump_00F_56DB

Jump_00F_56DB::
    ld a, $40
    ldh [$FFC7], a
    ld a, $01
    ldh [$FFC6], a
    ld hl, Func_05F_6BF8
    ld b, $5F
    rst $10
    ldh a, [$FFC6]
    or a, a
    ret z
    ld a, $80
    ld [$C919], a
    ret

Jump_00F_56F3::
    ld hl, $C923
    inc [hl]
    ld a, [$C552]
    or a, a
    jr nz, Jump_00F_570A
    ld hl, $8416
    call Func_00F_7F68
    ld de, $00A6
    call Func_000_1845
    ret

Jump_00F_570A::
    ld hl, $8417
    call Func_00F_7F68
    ld de, $00A5
    call Func_000_1845
    ret

Jump_00F_5717::
    ld a, $40
    ld [$CB9B], a
    ld a, [$C921]
    cp a, $1E
    jr nc, Jump_00F_5729
    bit 1, a
    jr z, Jump_00F_5739
    jr Jump_00F_5740

Jump_00F_5729::
    cp a, $3C
    jr nc, Jump_00F_5733
    bit 2, a
    jr z, Jump_00F_5739
    jr Jump_00F_5740

Jump_00F_5733::
    bit 3, a
    jr z, Jump_00F_5739
    jr Jump_00F_5740

Jump_00F_5739::
    ld a, $02
    ld [$CB7D], a
    jr Jump_00F_5745

Jump_00F_5740::
    ld a, $01
    ld [$CB7D], a

Jump_00F_5745::
    ld b, $78
    call Func_00F_7EB2
    ret nc
    ld a, $02
    ld [$CB7D], a
    xor a, a
    ld [$C921], a
    ld de, $00C2
    call Func_000_181B
    jp c, Jump_00F_57DE
    ld de, $00A7
    call Func_000_181B
    jr c, Jump_00F_57D2
    ld de, $00A6
    call Func_000_181B
    jr c, Jump_00F_57C6
    ld de, $00A5
    call Func_000_181B
    jr c, Jump_00F_57BB
    ld de, $00A4
    call Func_000_181B
    jr c, Jump_00F_579D
    ld de, $00A0
    call Func_000_181B
    jr c, Jump_00F_5791
    ld hl, $040C
    call Func_00F_7F68
    ld a, $03
    ld [$C923], a
    ret

Jump_00F_5791::
    ld hl, $040D
    call Func_00F_7F68
    ld a, $03
    ld [$C923], a
    ret

Jump_00F_579D::
    ld de, $00A0
    call Func_000_181B
    jr c, Jump_00F_57B0
    ld hl, $4415
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_57B0::
    ld hl, $4418
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_57BB::
    ld hl, $4419
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_57C6::
    ld hl, $0416
    call Func_00F_7F68
    ld a, $03
    ld [$C923], a
    ret

Jump_00F_57D2::
    ld hl, $0452
    call Func_00F_7F68
    ld a, $03
    ld [$C923], a
    ret

Jump_00F_57DE::
    ld hl, $0493
    call Func_00F_7F68
    ld a, $03
    ld [$C923], a
    ret

Func_00F_57EA::
    ld a, [$C923]
    rst $00
    dw Jump_00F_59C8
    dw Jump_00F_59B8
    dw Jump_00F_59AD
    dw Jump_00F_5993
    dw Jump_00F_7F89
    dw Jump_00F_59AD
    dw Jump_00F_5971
    dw Jump_00F_59AD
    dw Jump_00F_5962
    dw Jump_00F_59AD
    dw Jump_00F_594A
    dw Jump_00F_5906
    dw Jump_00F_7F89
    dw Jump_00F_58E5
    dw Jump_00F_58D5
    dw Jump_00F_58C5
    dw Jump_00F_7F89
    dw Jump_00F_5890
    dw Jump_00F_5889
    dw Jump_00F_585B
    dw Jump_00F_583A
    dw Jump_00F_7F89
    dw Jump_00F_581C

Jump_00F_581C::
    ld de, $0023
    call Func_000_1845
    ld a, $04
    ldh [$FFC6], a
    ld hl, Func_05F_6DAC
    ld b, $5F
    rst $10
    ld a, [$CC37]
    set 3, a
    ld [$CC37], a
    ld a, $80
    ld [$C919], a
    ret

Jump_00F_583A::
    ldh a, [$FF91]
    ld c, a
    ld a, [$CBD4]
    inc a
    ld [$CBD4], a
    cp a, c
    ret nz
    xor a, a
    ld [$CBCF], a
    ld hl, $0DCB
    call Func_00F_7F68
    ld de, $001E
    call Func_000_1845
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_585B::
    ldh a, [$FF98]
    inc a
    inc a
    and a, $03
    ld [$CB86], a
    ld a, $11
    ldh [$FFC6], a
    ld hl, Func_012_6B98
    ld b, $12
    rst $10
    ldh a, [$FF8E]
    ld [$CBD3], a
    ldh a, [$FF91]
    sub a, $20
    ld [$CBD4], a
    ld a, $80
    ld [$CBCF], a
    ld a, $85
    call Func_000_1278
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_5889::
    ld hl, Func_05F_7363
    ld b, $5F
    rst $10
    ret

Jump_00F_5890::
    ld a, $05
    ldh [$FF90], a
    ld a, $01
    ldh [$FF8F], a
    xor a, a
    ldh [$FF92], a
    ld a, $50
    ld [$C8C8], a
    ld a, $30
    ld [$C8C9], a
    ld a, $01
    ld [$C8C6], a
    xor a, a
    ld [$CCE9], a
    ld hl, Func_05F_6C5A
    ld b, $5F
    rst $10
    ld hl, $02A7
    call Func_00F_7F68
    xor a, a
    ld [$C92D], a
    ld hl, $FF8C
    call Func_00F_7ED3
    ret

Jump_00F_58C5::
    xor a, a
    call Func_00F_7F75
    ret nc
    ld hl, $0A0A
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_58D5::
    xor a, a
    call Func_00F_7F75
    ret nc
    ld hl, $0A09
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_58E5::
    ld hl, $CB8B
    inc [hl]
    ld de, $CB8B
    call Func_00F_7EE9
    ret nc
    ld a, $E0
    ld [$CB8B], a
    ld hl, $0A08
    call Func_00F_7F68
    ld de, $01E5
    call Func_000_1845
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_5906::
    ld a, $18
    ld [$CBAB], a
    ld a, [$C921]
    cp a, $1E
    jr nc, Jump_00F_5918
    bit 1, a
    jr z, Jump_00F_5928
    jr Jump_00F_592F

Jump_00F_5918::
    cp a, $3C
    jr nc, Jump_00F_5922
    bit 2, a
    jr z, Jump_00F_5928
    jr Jump_00F_592F

Jump_00F_5922::
    bit 3, a
    jr z, Jump_00F_5928
    jr Jump_00F_592F

Jump_00F_5928::
    ld a, $03
    ld [$CB7D], a
    jr Jump_00F_5934

Jump_00F_592F::
    ld a, $02
    ld [$CB7D], a

Jump_00F_5934::
    ld b, $78
    call Func_00F_7EB2
    ret nc
    ld a, $03
    ld [$CB7D], a
    ld hl, $0A07
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_594A::
    ld a, $49
    ldh [$FF90], a
    ld a, $00
    ldh [$FF8F], a
    ld a, $00
    ldh [$FF92], a
    ld a, $40
    ld [$C8C9], a
    ld hl, Func_05F_6C5A
    ld b, $5F
    rst $10
    ret

Jump_00F_5962::
    ld a, [$CC3A]
    set 1, a
    ld [$CC3A], a
    ld hl, Func_05F_6C5A
    ld b, $5F
    rst $10
    ret

Jump_00F_5971::
    ld a, $48
    ldh [$FF90], a
    ld a, $07
    ldh [$FF8F], a
    ld a, $05
    ldh [$FF92], a
    ldh a, [$FF8E]
    ld [$C8C8], a
    ld a, $E0
    ld [$C8C9], a
    ld a, $03
    ld [$C8C6], a
    ld hl, Func_05F_6C5A
    ld b, $5F
    rst $10
    ret

Jump_00F_5993::
    ld hl, $CBD4
    dec [hl]
    ld de, $CBD4
    call Func_00F_7EE9
    ret nc
    xor a, a
    ld [$CBCF], a
    ld hl, $0DCA
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_59AD::
    ld b, $3C
    call Func_00F_7EB2
    ret nc
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_59B8::
    ld hl, $CBD4
    dec [hl]
    ld de, $CBD4
    call Func_00F_7EE9
    ret nc
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_59C8::
    ld a, $10
    ldh [$FFC6], a
    ld hl, Func_012_6B98
    ld b, $12
    rst $10
    ldh a, [$FF8E]
    ld [$CBD3], a
    ldh a, [$FF91]
    ld [$CBD4], a
    ld a, $80
    ld [$CBCF], a
    ld hl, $C923
    inc [hl]
    ret

Func_00F_59E6::
    ld a, [$C923]
    rst $00
    dw Jump_00F_5AB9
    dw Jump_00F_5AB2
    dw Jump_00F_5A73
    dw Jump_00F_7F89
    dw Jump_00F_5A56
    dw Jump_00F_5A42
    dw Jump_00F_5A31
    dw Jump_00F_7F89
    dw Jump_00F_5A13
    dw Jump_00F_7F89
    dw Jump_00F_5A02
    dw Jump_00F_7F93

Jump_00F_5A02::
    ld hl, $0A05
    call Func_00F_7F68
    ld de, $01E4
    call Func_000_1845
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_5A13::
    ld a, [$C922]
    ldh [$FFC7], a
    ld a, $01
    ldh [$FFC6], a
    ld hl, Func_05F_6BF8
    ld b, $5F
    rst $10
    ldh a, [$FFC6]
    or a, a
    ret z
    ld hl, $0DDF
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_5A31::
    ld hl, $0A04
    call Func_00F_7F68
    ld a, [$CB9B]
    ld [$C922], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_5A42::
    xor a, a
    call Func_00F_7F75
    ret nc
    ld a, $19
    ldh [$FFC6], a
    ld hl, Func_00A_47A4
    ld b, $0A
    rst $10
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_5A56::
    ld a, [$C552]
    or a, a
    jr nz, Jump_00F_5A67
    ld hl, $8DD0
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_5A67::
    ld hl, $8DD1
    call Func_00F_7F68
    ld a, $0B
    ld [$C923], a
    ret

Jump_00F_5A73::
    ld a, [$C921]
    cp a, $1E
    jr nc, Jump_00F_5A80
    bit 1, a
    jr z, Jump_00F_5A90
    jr Jump_00F_5A97

Jump_00F_5A80::
    cp a, $3C
    jr nc, Jump_00F_5A8A
    bit 2, a
    jr z, Jump_00F_5A90
    jr Jump_00F_5A97

Jump_00F_5A8A::
    bit 3, a
    jr z, Jump_00F_5A90
    jr Jump_00F_5A97

Jump_00F_5A90::
    ld a, $20
    ld [$CB9B], a
    jr Jump_00F_5A9C

Jump_00F_5A97::
    ld a, $E0
    ld [$CB9B], a

Jump_00F_5A9C::
    ld b, $78
    call Func_00F_7EB2
    ret nc
    ld a, $20
    ld [$CB9B], a
    ld hl, $4A02
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_5AB2::
    ld hl, Func_012_653F
    ld b, $12
    rst $10
    ret

Jump_00F_5AB9::
    ld de, $01E3
    call Func_000_181B
    jr nc, Jump_00F_5AD2
    ld hl, $0A03
    call Func_00F_7F68
    ld a, $01
    ld [$C922], a
    ld a, $05
    ld [$C923], a
    ret

Jump_00F_5AD2::
    ld a, [$C525]
    or a, a
    jr z, Jump_00F_5AE4
    ld hl, $C49F
    ld de, $C0F0
    ld bc, $0040
    call Func_000_0952

Jump_00F_5AE4::
    ld de, $01E3
    call Func_000_1845
    xor a, a
    ld [$C922], a
    ld hl, $C923
    inc [hl]
    ret

Func_00F_5AF3::
    ld a, [$C923]
    rst $00
    dw Jump_00F_5C06
    dw Jump_00F_7F89
    dw Jump_00F_5BC2
    dw Jump_00F_7F89
    dw Jump_00F_5BA5
    dw Jump_00F_5B91
    dw Jump_00F_5B86
    dw Jump_00F_7F89
    dw Jump_00F_5B5F
    dw Jump_00F_7F89
    dw Jump_00F_5B3B
    dw Jump_00F_7F89
    dw Jump_00F_5B2C
    dw Jump_00F_7F89
    dw Jump_00F_5B17
    dw Jump_00F_7F93

Jump_00F_5B17::
    xor a, a
    ld [$CB86], a
    ld hl, $0AF5
    call Func_00F_7F68
    ld de, $01E2
    call Func_000_1845
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_5B2C::
    ld a, $02
    ld [$CB96], a
    ld de, $CB9B
    ld hl, $0AF4
    call Func_00F_7F24
    ret

Jump_00F_5B3B::
    ld de, $4C21
    ld b, $7D
    ld hl, $8500
    call Func_000_0CF5
    xor a, a
    ld [$CB86], a
    ld a, $0F
    ld [$CB81], a
    ld a, $01
    ld [$CB86], a
    ld hl, $0AF3
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_5B5F::
    ld a, $02
    ldh [$FFC6], a
    ld a, $20
    ldh [$FFC7], a
    ld hl, Func_05F_6BF8
    ld b, $5F
    rst $10
    ldh a, [$FFC6]
    or a, a
    ret z
    ld a, $02
    ld [$CB7D], a
    ld a, $03
    ld [$CB96], a
    ld hl, $0AF2
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_5B86::
    ld hl, $0AF0
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_5B91::
    xor a, a
    call Func_00F_7F75
    ret nc
    ld a, $04
    ldh [$FFC6], a
    ld hl, Func_00A_47A4
    ld b, $0A
    rst $10
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_5BA5::
    ld a, [$C552]
    or a, a
    jr nz, Jump_00F_5BB6
    ld hl, $8DCE
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_5BB6::
    ld hl, $8DCF
    call Func_00F_7F68
    ld a, $0F
    ld [$C923], a
    ret

Jump_00F_5BC2::
    ld a, $20
    ld [$CBAB], a
    ld a, [$C921]
    cp a, $1E
    jr nc, Jump_00F_5BD4
    bit 1, a
    jr z, Jump_00F_5BE4
    jr Jump_00F_5BEB

Jump_00F_5BD4::
    cp a, $3C
    jr nc, Jump_00F_5BDE
    bit 2, a
    jr z, Jump_00F_5BE4
    jr Jump_00F_5BEB

Jump_00F_5BDE::
    bit 3, a
    jr z, Jump_00F_5BE4
    jr Jump_00F_5BEB

Jump_00F_5BE4::
    ld a, $03
    ld [$CB7D], a
    jr Jump_00F_5BF0

Jump_00F_5BEB::
    ld a, $02
    ld [$CB7D], a

Jump_00F_5BF0::
    ld b, $78
    call Func_00F_7EB2
    ret nc
    ld a, $03
    ld [$CB7D], a
    ld hl, $4AEE
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_5C06::
    ld de, $01E1
    call Func_000_181B
    jr c, Jump_00F_5C2F
    ld hl, $0AED
    call Func_00F_7F68
    ld a, $34
    ldh [$FFC6], a
    ld hl, Func_012_7DCE
    ld b, $12
    rst $10
    ld hl, Func_012_7DF1
    ld b, $12
    rst $10
    ld de, $01E1
    call Func_000_1845
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_5C2F::
    ld hl, $0AEF
    call Func_00F_7F68
    ld a, $05
    ld [$C923], a
    ret

Func_00F_5C3B::
    ld a, [$C923]
    rst $00
    dw Jump_00F_5D1A
    dw Jump_00F_5D03
    dw Jump_00F_5CA9
    dw Jump_00F_5C47

Jump_00F_5C47::
    ld a, [$CB9B]
    cp a, $40
    jr z, Jump_00F_5C65
    ld a, $01
    ld [$C929], a
    ld a, $02
    ld [$C92A], a
    ld a, $40
    ld [$C928], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    jr Jump_00F_5C7A

Jump_00F_5C65::
    ld a, $01
    ld [$C929], a
    ld a, $01
    ld [$C92A], a
    ld a, $50
    ld [$C928], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10

Jump_00F_5C7A::
    ldh a, [$FF91]
    cp a, $40
    jr z, Jump_00F_5C8C
    ld a, $40
    ld [$C928], a
    ld hl, Func_05F_6AEB
    ld b, $5F
    rst $10
    ret

Jump_00F_5C8C::
    ld a, $40
    ld [$C928], a
    ld hl, Func_05F_6ABF
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld a, $02
    ldh [$FF98], a
    ld [$CB96], a
    ld a, $80
    ld [$C919], a
    ret

Jump_00F_5CA9::
    ld a, [$CB9A]
    cp a, $30
    jr z, Jump_00F_5CC7
    ld a, $01
    ld [$C929], a
    ld a, $03
    ld [$C92A], a
    ld a, $30
    ld [$C928], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    jr Jump_00F_5CDC

Jump_00F_5CC7::
    ld a, $01
    ld [$C929], a
    ld a, $02
    ld [$C92A], a
    ld a, $40
    ld [$C928], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10

Jump_00F_5CDC::
    ldh a, [$FF91]
    cp a, $70
    jr z, Jump_00F_5CEE
    ld a, $70
    ld [$C928], a
    ld hl, Func_05F_6AEB
    ld b, $5F
    rst $10
    ret

Jump_00F_5CEE::
    ld a, $30
    ld [$C928], a
    ld hl, Func_05F_6B17
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_5D03::
    ld hl, Func_002_541B
    ld b, $02
    rst $10
    ld hl, Func_002_5BD7
    ld b, $02
    rst $10
    ld a, [$C468]
    bit 7, a
    ret nz
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_5D1A::
    ld a, [$CB8A]
    cp a, $50
    jr z, Jump_00F_5D38
    ld a, $00
    ld [$C929], a
    ld a, $03
    ld [$C92A], a
    ld a, $50
    ld [$C928], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    jr Jump_00F_5D4D

Jump_00F_5D38::
    ld a, $00
    ld [$C929], a
    ld a, $02
    ld [$C92A], a
    ld a, $E0
    ld [$C928], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10

Jump_00F_5D4D::
    ldh a, [$FF8E]
    cp a, $50
    jr z, Jump_00F_5D5F
    ld a, $30
    ld [$C928], a
    ld hl, Func_05F_6B17
    ld b, $5F
    rst $10
    ret

Jump_00F_5D5F::
    ld a, $00
    ld [$C928], a
    ld hl, Func_05F_6AEB
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld a, $80
    ld [$C468], a
    ld a, $04
    ld [$C46A], a
    ld hl, $FF92
    dec [hl]
    ldh a, [$FF8C]
    or a, $01
    ldh [$FF8C], a
    ld hl, $FF80
    ld a, l
    ldh [$FF9D], a
    ld a, h
    ldh [$FF9E], a
    ld hl, Func_002_541B
    ld b, $02
    rst $10
    ld hl, Func_002_5BD7
    ld b, $02
    rst $10
    ld hl, $C923
    inc [hl]
    ret

Func_00F_5D9D::
    ld a, [$C923]
    rst $00
    dw Jump_00F_5EE8
    dw Jump_00F_5E70
    dw Jump_00F_5E3A
    dw Jump_00F_7F89
    dw Jump_00F_5E07
    dw Jump_00F_7F89
    dw Jump_00F_5DF8
    dw Jump_00F_5DED
    dw Jump_00F_7F89
    dw Jump_00F_5DCC
    dw Jump_00F_7F89
    dw Jump_00F_5DBB
    dw Jump_00F_7F93

Jump_00F_5DBB::
    ld hl, $0AD5
    call Func_00F_7F68
    ld de, $009D
    call Func_000_1845
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_5DCC::
    ld a, $02
    ldh [$FFC6], a
    ld a, $30
    ldh [$FFC7], a
    ld hl, Func_05F_6BF8
    ld b, $5F
    rst $10
    ldh a, [$FFC6]
    or a, a
    ret z
    ld hl, $CB7D
    dec [hl]
    ld hl, $0AD0
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_5DED::
    ld hl, $0AD4
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_5DF8::
    ld a, $18
    ldh [$FFC6], a
    ld hl, Func_00A_47A4
    ld b, $0A
    rst $10
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_5E07::
    ld a, $33
    ldh [$FFC6], a
    ld hl, Func_012_7DCE
    ld b, $12
    rst $10
    ldh a, [$FFC6]
    bit 7, a
    jr nz, Jump_00F_5E1D
    ld hl, Func_012_7DF1
    ld b, $12
    rst $10

Jump_00F_5E1D::
    ld a, [$C552]
    or a, a
    jr nz, Jump_00F_5E2E
    ld hl, $8DCC
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_5E2E::
    ld hl, $8DCD
    call Func_00F_7F68
    ld a, $0C
    ld [$C923], a
    ret

Jump_00F_5E3A::
    ld a, [$C922]
    or a, a
    jr nz, Jump_00F_5E46
    ld hl, $CB8B
    dec [hl]
    jr Jump_00F_5E4A

Jump_00F_5E46::
    ld hl, $CB8B
    inc [hl]

Jump_00F_5E4A::
    ld de, $CB8B
    call Func_00F_7EE9
    ret nc
    ld hl, $C923
    inc [hl]
    ld de, $009C
    call Func_000_181B
    jr c, Jump_00F_5E6A
    ld hl, $4AD2
    call Func_00F_7F68
    ld de, $009C
    call Func_000_1845
    ret

Jump_00F_5E6A::
    ld a, $06
    ld [$C923], a
    ret

Jump_00F_5E70::
    ld hl, $CB9A
    dec [hl]
    ld hl, $CB9B
    inc [hl]
    ld de, $CB9B
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, Func_05F_6BCD
    ld b, $5F
    rst $10
    ld a, [$C921]
    inc a
    ld [$C921], a
    and a, $03
    jr nz, Jump_00F_5E9D
    ld a, [$CB96]
    inc a
    and a, $03
    ld [$CB96], a

Jump_00F_5E9D::
    ld a, [$C921]
    cp a, $20
    ret nz
    ld a, [$CB86]
    ld [$CB96], a
    ld [$CBA6], a
    ld a, [$CB9A]
    ld [$CBAA], a
    ld a, [$CB9B]
    ld [$CBAB], a
    ld a, $E0
    ld [$CB9A], a
    ld a, $63
    call Func_000_1278
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    xor a, a
    ld [$C922], a
    ldh a, [$FF91]
    cp a, $20
    jr z, Jump_00F_5EE2
    cp a, $40
    ret z
    ld a, [$C6FD]
    dec a
    ret z
    ld a, [$C8F6]
    cp a, $20
    ret nz

Jump_00F_5EE2::
    ld a, $01
    ld [$C922], a
    ret

Jump_00F_5EE8::
    ld a, [$CB9A]
    cp a, $80
    jr nz, Jump_00F_5F00
    ld a, [$CB9B]
    cp a, $10
    jr nz, Jump_00F_5F00
    ld a, $65
    call Func_000_1278
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_5F00::
    ld a, $06
    ld [$C923], a
    ret

Func_00F_5F06::
    ld a, [$C923]
    rst $00
    dw Jump_00F_6066
    dw Jump_00F_6019
    dw Jump_00F_6003
    dw Jump_00F_5FEC
    dw Jump_00F_5FD6
    dw Jump_00F_5FEC
    dw Jump_00F_5FD6
    dw Jump_00F_5FC0
    dw Jump_00F_7F89
    dw Jump_00F_5FB9
    dw Jump_00F_5F8E
    dw Jump_00F_5F65
    dw Jump_00F_5F4A
    dw Jump_00F_7F89
    dw Jump_00F_5F3D
    dw Jump_00F_5F36
    dw Jump_00F_5F2C

Jump_00F_5F2C::
    ld a, $02
    ldh [$FF98], a
    ld a, $80
    ld [$C919], a
    ret

Jump_00F_5F36::
    ld hl, Func_05F_70D2
    ld b, $5F
    rst $10
    ret

Jump_00F_5F3D::
    xor a, a
    ld [$C92D], a
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_5F4A::
    ld a, $40
    ld [$C928], a
    ld hl, Func_05F_6AEB
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld hl, $03A1
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_5F65::
    ldh a, [$FF8E]
    cp a, $40
    jr nz, Jump_00F_5F70
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_5F70::
    jr nc, Jump_00F_5F80
    ldh a, [$FF8E]
    call Func_00F_7ED8
    ld a, $01
    ldh [$FF98], a
    ld hl, $FF8E
    inc [hl]
    ret

Jump_00F_5F80::
    ldh a, [$FF8E]
    call Func_00F_7ED8
    ld a, $03
    ldh [$FF98], a
    ld hl, $FF8E
    dec [hl]
    ret

Jump_00F_5F8E::
    ld a, $02
    ld [$C929], a
    ld a, $00
    ld [$C92A], a
    ld a, $A0
    ld [$C928], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld hl, $FF8C
    call Func_00F_7ECE
    ld hl, Func_002_6050
    ld b, $02
    rst $10
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_5FB9::
    ld de, $CBAB
    call Func_00F_7F0B
    ret

Jump_00F_5FC0::
    ld a, $02
    ld [$CBA6], a
    ld hl, $CBAC
    call Func_00F_7ED3
    ld hl, $03A0
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_5FD6::
    ld b, $4B
    call Func_00F_7EB2
    ret nc
    ld a, $01
    ld [$CBA6], a
    ld hl, $CBAC
    call Func_00F_7EC9
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_5FEC::
    ld hl, $CBAC
    call Func_00F_7ECE
    ld b, $1E
    call Func_00F_7EB2
    ret nc
    ld hl, $CBAC
    call Func_00F_7EC4
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_6003::
    ld b, $4B
    call Func_00F_7EB2
    ret nc
    ld a, $03
    ld [$CBA6], a
    ld hl, $CBAC
    call Func_00F_7EC9
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_6019::
    ld hl, $CBAC
    call Func_00F_7ECE
    ld a, [$C5F0]
    srl a
    srl a
    srl a
    and a, $03
    ld [$CBA6], a
    ld de, $CBAB
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, Func_05F_6BCD
    ld b, $5F
    rst $10
    ld a, [$C921]
    and a, $01
    jr nz, Jump_00F_6049
    ld hl, $CBAA
    inc [hl]

Jump_00F_6049::
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $20
    ret nz
    xor a, a
    ld [$CBA6], a
    ld hl, $CBAC
    call Func_00F_7EC4
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_6066::
    ld a, [$C921]
    or a, a
    jr nz, Jump_00F_608E
    ld a, $02
    ld [$C929], a
    ld a, $01
    ld [$C92A], a
    ld a, $70
    ld [$C928], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    call Func_00F_60D9
    ld a, [$C92C]
    or a, a
    ret z
    ld hl, $C921
    inc [hl]
    ret

Jump_00F_608E::
    dec a
    jr nz, Jump_00F_60B3
    ld a, $02
    ld [$C929], a
    ld a, $03
    ld [$C92A], a
    ld a, $20
    ld [$C928], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    call Func_00F_60D9
    ld a, [$C92C]
    or a, a
    ret z
    ld hl, $C921
    inc [hl]
    ret

Jump_00F_60B3::
    ld a, $02
    ld [$C929], a
    ld a, $01
    ld [$C92A], a
    ld a, $40
    ld [$C928], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    call Func_00F_60D9
    ld a, [$C92C]
    or a, a
    ret z
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Func_00F_60D9::
    ld a, [$C5F0]
    srl a
    srl a
    and a, $03
    ld [$CBA6], a
    ret

Func_00F_60E6::
    ld a, [$C923]
    rst $00
    dw Jump_00F_6252
    dw Jump_00F_622E
    dw Jump_00F_61BC
    dw Jump_00F_61A8
    dw Jump_00F_619D
    dw Jump_00F_7F89
    dw Jump_00F_614C
    dw Jump_00F_6140
    dw Jump_00F_613A
    dw Jump_00F_60FE

Jump_00F_60FE::
    ld a, [$CBD4]
    inc a
    inc a
    ld [$CBD4], a
    cp a, $10
    ret nz
    ld a, $72
    call Func_000_1278
    ld a, $52
    ld [$CBA1], a
    ldh [$FFC6], a
    xor a, a
    ldh [$FFC7], a
    ld a, $01
    ldh [$FFC8], a
    ld a, $07
    ldh [$FFC9], a
    ld hl, $8700
    ld a, l
    ldh [$FFCA], a
    ld a, h
    ldh [$FFCB], a
    ld hl, Func_004_431F
    ld b, $04
    rst $10
    ld a, $7F
    ld [$C527], a
    ld a, $80
    ld [$C919], a
    ret

Jump_00F_613A::
    ld b, $0F
    call Func_00F_72A0
    ret

Jump_00F_6140::
    ld a, $E0
    ld [$CB8A], a
    ld hl, Func_012_653F
    ld b, $12
    rst $10
    ret

Jump_00F_614C::
    ld hl, $FF8C
    call Func_00F_7ECE
    ld a, [$C921]
    inc a
    ld [$C921], a
    and a, $03
    ret nz
    ldh a, [$FF91]
    inc a
    ldh [$FF91], a
    ld [$C8F1], a
    ld [$C8F6], a
    ld [$C8FB], a
    cp a, $40
    ret nz
    ld a, $09
    ldh [$FFC6], a
    ld hl, Func_012_6B98
    ld b, $12
    rst $10
    ld a, [$C525]
    or a, a
    jr z, Jump_00F_6189
    ld hl, $C49F
    ld de, $C0F0
    ld bc, $0040
    call Func_000_0952

Jump_00F_6189::
    ld a, $7A
    call Func_000_1278
    ld hl, $FF8C
    call Func_00F_7ED3
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_619D::
    ld hl, $0348
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_61A8::
    xor a, a
    call Func_00F_7F75
    ret nc
    ld a, $03
    ldh [$FFC6], a
    ld hl, Func_00A_47A4
    ld b, $0A
    rst $10
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_61BC::
    ld b, $3C
    call Func_00F_72A0
    ld hl, $FF91
    inc [hl]
    ld de, $FF91
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, Func_05F_6BCD
    ld b, $5F
    rst $10
    ld hl, $C8F1
    inc [hl]
    ld de, $C8F1
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, Func_05F_6BCD
    ld b, $5F
    rst $10
    ld hl, $C8F6
    inc [hl]
    ld de, $C8F6
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, Func_05F_6BCD
    ld b, $5F
    rst $10
    ld hl, $C8FB
    inc [hl]
    ld de, $C8FB
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, Func_05F_6BCD
    ld b, $5F
    rst $10
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $20
    ret nz
    ld hl, $0346
    call Func_00F_7F68
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_622E::
    ld a, $20
    ld [$C928], a
    ld a, $00
    ld [$C929], a
    ld a, $80
    ld [$C92A], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld a, $66
    call Func_000_1278
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_6252::
    ld de, $0085
    call Func_000_181B
    jr c, Jump_00F_626B
    ld hl, Func_05F_6E09
    ld b, $5F
    rst $10
    ld de, $0085
    call Func_000_1845
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_626B::
    ld hl, $0347
    call Func_00F_7F68
    ld a, $03
    ld [$C923], a
    ret

Func_00F_6277::
    ld a, [$C923]
    rst $00
    dw Jump_00F_62C0
    dw Jump_00F_62AF
    dw Jump_00F_62A0
    dw Jump_00F_6283

Jump_00F_6283::
    ld a, $00
    ldh [$FFC6], a
    ld a, $40
    ldh [$FFC7], a
    ld hl, Func_05F_6BF8
    ld b, $5F
    rst $10
    ldh a, [$FFC6]
    or a, a
    ret z
    ld a, $E0
    ld [$CB8B], a
    ld a, $80
    ld [$C919], a
    ret

Jump_00F_62A0::
    ld a, $0C
    ldh [$FFC6], a
    ld hl, Func_00A_47A4
    ld b, $0A
    rst $10
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_62AF::
    ld b, $1E
    call Func_00F_7EB2
    ret nc
    ld de, $0093
    call Func_000_1845
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_62C0::
    ld de, $0093
    call Func_000_181B
    jr nc, Jump_00F_62D1
    ld hl, $C923
    inc [hl]
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_62D1::
    ld a, [$CBA6]
    ld [$CB86], a
    ld a, [$C921]
    cp a, $1E
    jr nc, Jump_00F_62E4
    bit 1, a
    jr z, Jump_00F_62F4
    jr Jump_00F_6300

Jump_00F_62E4::
    cp a, $3C
    jr nc, Jump_00F_62EE
    bit 2, a
    jr z, Jump_00F_62F4
    jr Jump_00F_6300

Jump_00F_62EE::
    bit 3, a
    jr z, Jump_00F_62F4
    jr Jump_00F_6300

Jump_00F_62F4::
    ld a, $40
    ld [$CB8B], a
    ld a, $E0
    ld [$CBAB], a
    jr Jump_00F_630A

Jump_00F_6300::
    ld a, $E0
    ld [$CB8B], a
    ld a, $40
    ld [$CBAB], a

Jump_00F_630A::
    ld b, $78
    call Func_00F_7EB2
    ret nc
    ld a, $40
    ld [$CB8B], a
    ld a, $E0
    ld [$CBAB], a
    ld hl, $C923
    inc [hl]
    ret

Func_00F_631F::
    ld a, [$C923]
    rst $00
    dw Jump_00F_64D4
    dw Jump_00F_64BA
    dw Jump_00F_7F89
    dw Jump_00F_6473
    dw Jump_00F_6D00
    dw Jump_00F_6D00
    dw Jump_00F_6D00
    dw Jump_00F_6433
    dw Jump_00F_6416
    dw Jump_00F_63E5
    dw Jump_00F_6383
    dw Jump_00F_7F89
    dw Jump_00F_633D

Jump_00F_633D::
    ld a, [$CB9B]
    cp a, $50
    jr z, Jump_00F_635A
    ld a, $50
    ld [$C928], a
    ld a, $01
    ld [$C929], a
    ld a, $80
    ld [$C92A], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ret

Jump_00F_635A::
    ld a, [$CB9A]
    cp a, $30
    jr z, Jump_00F_6372
    dec a
    dec a
    ld [$CB9A], a
    ld hl, $CB9C
    call Func_00F_7ECE
    ld a, $03
    ld [$CB96], a
    ret

Jump_00F_6372::
    ld a, $01
    ld [$CB96], a
    ld hl, $CB9C
    call Func_00F_7ED3
    ld a, $80
    ld [$C919], a
    ret

Jump_00F_6383::
    ld hl, $CB9B
    inc [hl]
    ld de, $CB9B
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, Func_05F_6BCD
    ld b, $5F
    rst $10
    ld b, $3C
    call Func_00F_72A0
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $20
    ret nz
    ld a, [$C922]
    cp a, $30
    jr z, Jump_00F_63BD
    ld hl, $0362
    call Func_00F_7F68
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_63BD::
    ld a, [$CC3A]
    set 0, a
    ld [$CC3A], a
    ld a, $38
    ld [$C19E], a
    ld a, $39
    ld [$C19F], a
    ld a, $3A
    ld [$C1B2], a
    ld a, $3B
    ld [$C1B3], a
    ld hl, Func_05F_6DDB
    ld b, $5F
    rst $10
    ld a, $80
    ld [$C919], a
    ret

Jump_00F_63E5::
    ld a, $00
    ld [$C928], a
    ld a, $01
    ld [$C929], a
    ld a, $82
    ld [$C92A], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld hl, $C923
    inc [hl]
    ld a, [$C922]
    cp a, $30
    jr z, Jump_00F_6410
    ld a, $63
    call Func_000_1278
    ret

Jump_00F_6410::
    ld a, $66
    call Func_000_1278
    ret

Jump_00F_6416::
    ld a, [$C921]
    inc a
    ld [$C921], a
    and a, $07
    ret nz
    ld a, [$CB9B]
    inc a
    ld [$CB9B], a
    cp a, $30
    ret nz
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_6433::
    ld hl, $CB9C
    call Func_00F_7ECE
    ld a, [$C922]
    ld c, a
    ld a, [$CB9A]
    cp a, c
    jr z, Jump_00F_644E
    inc a
    inc a
    ld [$CB9A], a
    ld a, $01
    ld [$CB96], a
    ret

Jump_00F_644E::
    ld a, $20
    ld [$C928], a
    ld a, $01
    ld [$C929], a
    ld a, $82
    ld [$C92A], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld hl, $CB9C
    call Func_00F_7ED3
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_6473::
    ld hl, $FF8C
    call Func_00F_7ECE
    ldh a, [$FF8E]
    call Func_00F_7ED8
    ld a, [$C922]
    cp a, $40
    jr nc, Jump_00F_6490
    ldh a, [$FF8E]
    inc a
    ldh [$FF8E], a
    ld a, $01
    ldh [$FF98], a
    jr Jump_00F_6499

Jump_00F_6490::
    ldh a, [$FF8E]
    dec a
    ldh [$FF8E], a
    ld a, $03
    ldh [$FF98], a

Jump_00F_6499::
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $10
    ret nz
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ldh a, [$FF98]
    inc a
    inc a
    and a, $03
    ldh [$FF98], a
    ld hl, $FF8C
    call Func_00F_7ED3
    ret

Jump_00F_64BA::
    ld b, $3C
    call Func_00F_7EB2
    ret nc
    xor a, a
    ld [$CBCF], a
    ld hl, $C923
    inc [hl]
    ldh a, [$FF8E]
    ld [$C922], a
    ld hl, $0361
    call Func_00F_7F68
    ret

Jump_00F_64D4::
    ld hl, Func_05F_6E09
    ld b, $5F
    rst $10
    ld a, $05
    ldh [$FFC6], a
    ld hl, Func_012_6B98
    ld b, $12
    rst $10
    ld a, $30
    ld [$CBD3], a
    ld a, $40
    ld [$CBD4], a
    ld hl, $C923
    inc [hl]
    ret

Func_00F_64F3::
    ld a, [$C923]
    rst $00
    dw Jump_00F_6767
    dw Jump_00F_6750
    dw Jump_00F_66F4
    dw Jump_00F_6676
    dw Jump_00F_7F89
    dw Jump_00F_666A
    dw Jump_00F_6628
    dw Jump_00F_7F89
    dw Jump_00F_6606
    dw Jump_00F_6D00
    dw Jump_00F_65F3
    dw Jump_00F_6D00
    dw Jump_00F_65DF
    dw Jump_00F_6D00
    dw Jump_00F_65D6
    dw Jump_00F_65A5
    dw Jump_00F_6586
    dw Jump_00F_651B

Jump_00F_651B::
    ld a, [$C922]
    or a, a
    jr nz, Jump_00F_652D
    ldh a, [$FF91]
    cp a, $40
    jr nz, Jump_00F_654D
    ld hl, $C922
    inc [hl]
    jr Jump_00F_654D

Jump_00F_652D::
    dec a
    jr nz, Jump_00F_654D
    ld de, $CB8B
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, Func_05F_6BCD
    ld b, $5F
    rst $10
    ld de, $CB9B
    call Func_00F_7EE9
    jr nc, Jump_00F_654D
    ld hl, $C922
    inc [hl]

Jump_00F_654D::
    ldh a, [$FF91]
    cp a, $40
    jr z, Jump_00F_6557
    inc a
    inc a
    ldh [$FF91], a

Jump_00F_6557::
    ld a, [$C8F1]
    cp a, $40
    jr z, Jump_00F_6563
    inc a
    inc a
    ld [$C8F1], a

Jump_00F_6563::
    ld a, [$C8F6]
    cp a, $40
    jr z, Jump_00F_656F
    inc a
    inc a
    ld [$C8F6], a

Jump_00F_656F::
    ld a, [$C8FB]
    inc a
    inc a
    ld [$C8FB], a
    cp a, $40
    ret nz
    ld hl, $FF8C
    call Func_00F_7EC9
    ld a, $80
    ld [$C919], a
    ret

Jump_00F_6586::
    ld hl, $FF8C
    call Func_00F_7EC4
    ld a, $D0
    ld [$C8F1], a
    ld a, $C0
    ld [$C8F6], a
    ld a, $B0
    ld [$C8FB], a
    ld a, $65
    call Func_000_1278
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_65A5::
    ld a, $E0
    ldh [$FF8E], a
    ld [$C8F0], a
    ld [$C8F5], a
    ld [$C8FA], a
    xor a, a
    ldh [$FF8D], a
    ld a, $4D
    ldh [$FF90], a
    xor a, a
    ldh [$FF8F], a
    ld a, $01
    ldh [$FF92], a
    ld a, $40
    ld [$C8C8], a
    ld a, $E0
    ld [$C8C9], a
    ld a, $01
    ld [$C8C6], a
    ld hl, Func_05F_6C5A
    ld b, $5F
    rst $10
    ret

Jump_00F_65D6::
    ld a, $0F
    ldh [$FF8D], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_65DF::
    ld hl, $C923
    inc [hl]
    ld a, $07
    ldh [$FF8D], a
    ld a, [$C6FD]
    dec a
    dec a
    ret nz
    ld a, $0F
    ld [$C923], a
    ret

Jump_00F_65F3::
    ld hl, $C923
    inc [hl]
    ld a, $03
    ldh [$FF8D], a
    ld a, [$C6FD]
    dec a
    ret nz
    ld a, $0F
    ld [$C923], a
    ret

Jump_00F_6606::
    ld a, $6A
    ld [$C240], a
    ld [$C241], a
    ld [$C254], a
    ld [$C255], a
    ld hl, Func_05F_6DDB
    ld b, $5F
    rst $10
    ld a, $01
    ldh [$FF8D], a
    ld a, $65
    call Func_000_1278
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_6628::
    ld a, [$CB9A]
    cp a, $40
    jr z, Jump_00F_6645
    ld a, $60
    ld [$C928], a
    ld a, $01
    ld [$C929], a
    ld a, $81
    ld [$C92A], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ret

Jump_00F_6645::
    ld a, $A0
    ld [$C928], a
    ld a, $01
    ld [$C929], a
    ld a, $80
    ld [$C92A], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld hl, $035B
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_666A::
    ld a, $02
    ld [$CB96], a
    ld de, $CB9B
    call Func_00F_7F0B
    ret

Jump_00F_6676::
    ld hl, $035A
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Func_00F_6681::
    ld a, [$C923]
    rst $00
    dw Jump_00F_6767
    dw Jump_00F_6750
    dw Jump_00F_66F4
    dw Jump_00F_7F89
    dw Jump_00F_66B6
    dw Jump_00F_6750
    dw Jump_00F_66A1
    dw Jump_00F_6D00
    dw Jump_00F_6D00
    dw Jump_00F_6D00
    dw Jump_00F_669B

Jump_00F_669B::
    ld a, $80
    ld [$C919], a
    ret

Jump_00F_66A1::
    ld a, $10
    ld [$C928], a
    ld hl, Func_05F_6A94
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_66B6::
    ld a, $80
    ld [$C928], a
    ld hl, Func_05F_6A94
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld a, $80
    ld [$C468], a
    ld a, $08
    ld [$C46A], a
    ld hl, $FF92
    inc [hl]
    ldh a, [$FF8C]
    or a, $01
    ldh [$FF8C], a
    ld hl, $FF80
    ld a, l
    ldh [$FF9D], a
    ld a, h
    ldh [$FF9E], a
    ld hl, Func_002_541B
    ld b, $02
    rst $10
    ld hl, Func_002_5BD7
    ld b, $02
    rst $10
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_66F4::
    ld a, [$CB9B]
    cp a, $60
    jr z, Jump_00F_6712
    ld a, $60
    ld [$C928], a
    ld a, $01
    ld [$C929], a
    ld a, $02
    ld [$C92A], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    jr Jump_00F_6735

Jump_00F_6712::
    ld a, [$CB9A]
    cp a, $30
    jr z, Jump_00F_6730
    ld a, $30
    ld [$C928], a
    ld a, $01
    ld [$C929], a
    ld a, $03
    ld [$C92A], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    jr Jump_00F_6735

Jump_00F_6730::
    ld a, $01
    ld [$CB96], a

Jump_00F_6735::
    ld a, $40
    ld [$C928], a
    ld hl, Func_05F_6AEB
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld hl, $0322
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_6750::
    ld hl, Func_002_541B
    ld b, $02
    rst $10
    ld hl, Func_002_5BD7
    ld b, $02
    rst $10
    ld a, [$C468]
    bit 7, a
    ret nz
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_6767::
    ld a, $01
    ld [$C929], a
    ld a, $02
    ld [$C92A], a
    ld a, $E0
    ld [$C928], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, $00
    ld [$C928], a
    ld hl, Func_05F_6AEB
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld a, $80
    ld [$C468], a
    ld a, $04
    ld [$C46A], a
    ld hl, $FF92
    dec [hl]
    ldh a, [$FF8C]
    or a, $01
    ldh [$FF8C], a
    ld hl, $0080
    ld a, l
    ldh [$FF9D], a
    ld a, h
    ldh [$FF9E], a
    ld hl, Func_002_541B
    ld b, $02
    rst $10
    ld hl, Func_002_5BD7
    ld b, $02
    rst $10
    ld hl, $C923
    inc [hl]
    ret

Func_00F_67BA::
    ld a, [$C923]
    rst $00
    dw Jump_00F_6D07
    dw Jump_00F_6D00
    dw Jump_00F_6D00
    dw Jump_00F_6D00
    dw Jump_00F_6CAB
    dw Jump_00F_7F89
    dw Jump_00F_6BF6
    dw Jump_00F_6BBA
    dw Jump_00F_6BA3
    dw Jump_00F_6B99
    dw Jump_00F_7F89
    dw Jump_00F_6B4B
    dw Jump_00F_6B31
    dw Jump_00F_7F89
    dw Jump_00F_6ADD
    dw Jump_00F_6AD3
    dw Jump_00F_7F89
    dw Jump_00F_6ABC
    dw Jump_00F_6AB2
    dw Jump_00F_7F89
    dw Jump_00F_6AA1
    dw Jump_00F_6A9B
    dw Jump_00F_6AA1
    dw Jump_00F_6A9B
    dw Jump_00F_6AA1
    dw Jump_00F_6A9B
    dw Jump_00F_6AA1
    dw Jump_00F_6A9B
    dw Jump_00F_6AA1
    dw Jump_00F_6A9B
    dw Jump_00F_6A77
    dw Jump_00F_6A3F
    dw Jump_00F_6A21
    dw Jump_00F_69D5
    dw Jump_00F_69A6
    dw Jump_00F_7F89
    dw Jump_00F_693F
    dw Jump_00F_6924
    dw Jump_00F_6910
    dw Jump_00F_6905
    dw Jump_00F_68EB
    dw Jump_00F_7F89
    dw Jump_00F_68E0
    dw Jump_00F_7F89
    dw Jump_00F_689B
    dw Jump_00F_6894
    dw Jump_00F_6866
    dw Jump_00F_6845
    dw Jump_00F_7F89
    dw Jump_00F_6822

Jump_00F_6822::
    ld de, $0022
    call Func_000_1845
    ld a, $03
    ldh [$FFC6], a
    ld hl, Func_05F_6DAC
    ld b, $5F
    rst $10
    ld a, [$CC37]
    set 2, a
    ld [$CC37], a
    ld a, $02
    ld [$C7C7], a
    ld a, $80
    ld [$C919], a
    ret

Jump_00F_6845::
    ldh a, [$FF91]
    ld c, a
    ld a, [$CBD4]
    inc a
    ld [$CBD4], a
    cp a, c
    ret nz
    xor a, a
    ld [$CBCF], a
    ld hl, $0DC1
    call Func_00F_7F68
    ld de, $001F
    call Func_000_1845
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_6866::
    ldh a, [$FF98]
    inc a
    inc a
    and a, $03
    ld [$CB86], a
    ld a, $11
    ldh [$FFC6], a
    ld hl, Func_012_6B98
    ld b, $12
    rst $10
    ldh a, [$FF8E]
    ld [$CBD3], a
    ldh a, [$FF91]
    sub a, $20
    ld [$CBD4], a
    ld a, $80
    ld [$CBCF], a
    ld a, $85
    call Func_000_1278
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_6894::
    ld hl, Func_05F_7363
    ld b, $5F
    rst $10
    ret

Jump_00F_689B::
    ld a, $05
    ldh [$FF90], a
    ld a, $01
    ldh [$FF8F], a
    xor a, a
    ldh [$FF92], a
    ld a, $50
    ld [$C8C8], a
    ld a, $30
    ld [$C8C9], a
    ld a, $01
    ld [$C8C6], a
    xor a, a
    ld [$CCE9], a
    ld hl, Func_05F_6C5A
    ld b, $5F
    rst $10
    ld a, $50
    ld [$CBD3], a
    ld a, $30
    ld [$CBD4], a
    ld hl, $02A7
    call Func_00F_7F68
    xor a, a
    ld [$C92D], a
    ld hl, $FF8C
    call Func_00F_7ED3
    ldh a, [$FF8C]
    and a, $BF
    ldh [$FF8C], a
    ret

Jump_00F_68E0::
    ld hl, $0873
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_68EB::
    ld hl, $CBD4
    inc [hl]
    ld de, $CBD4
    call Func_00F_7EE9
    ret nc
    xor a, a
    ld [$CBCF], a
    ld hl, $0872
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_6905::
    ld b, $1E
    call Func_00F_7EB2
    ret nc
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_6910::
    ld hl, $CBD3
    inc [hl]
    ld hl, $CBD4
    dec [hl]
    ld de, $CBD4
    call Func_00F_7EE9
    ret nc
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_6924::
    ld a, $50
    ld [$C928], a
    ld hl, Func_05F_6B17
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld de, $005F
    call Func_000_1845
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_693F::
    ld a, [$C921]
    or a, a
    jr nz, Jump_00F_6951
    ld a, $83
    ld [$C92A], a
    ld a, $70
    ld [$C928], a
    jr Jump_00F_6979

Jump_00F_6951::
    dec a
    jr nz, Jump_00F_6960
    ld a, $82
    ld [$C92A], a
    ld a, $30
    ld [$C928], a
    jr Jump_00F_6979

Jump_00F_6960::
    dec a
    jr nz, Jump_00F_696F
    ld a, $83
    ld [$C92A], a
    ld a, $50
    ld [$C928], a
    jr Jump_00F_6979

Jump_00F_696F::
    ld a, $82
    ld [$C92A], a
    ld a, $00
    ld [$C928], a

Jump_00F_6979::
    ld a, $00
    ld [$C929], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $04
    ret nz
    xor a, a
    ld [$CB7D], a
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ld hl, Func_002_6050
    ld b, $02
    rst $10
    ret

Jump_00F_69A6::
    ld a, [$C921]
    srl a
    srl a
    srl a
    and a, $03
    ld [$CB86], a
    ld b, $38
    call Func_00F_7EB2
    ret nc
    ld de, $42BD
    ld b, $7D
    ld hl, $8500
    call Func_000_0CF5
    ld a, $03
    ld [$CB81], a
    ld hl, $0871
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_69D5::
    ld a, [$C921]
    or a, a
    jr nz, Jump_00F_69F0
    ld a, $10
    ld [$C928], a
    ld hl, Func_05F_6A94
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld hl, $C921
    inc [hl]
    ret

Jump_00F_69F0::
    dec a
    jr nz, Jump_00F_6A08
    ld a, $80
    ld [$C928], a
    ld hl, Func_05F_6ABF
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld hl, $C921
    inc [hl]
    ret

Jump_00F_6A08::
    ld a, $30
    ld [$C928], a
    ld hl, Func_05F_6A94
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_6A21::
    ld a, [$CBD4]
    dec a
    dec a
    ld [$CBD4], a
    ld de, $CBD4
    call Func_00F_7EE9
    ret nc
    ld a, $65
    call Func_000_1278
    ld a, $01
    ld [$CB7D], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_6A3F::
    ld a, [$C921]
    inc a
    ld [$C921], a
    push af
    bit 4, a
    jr z, Jump_00F_6A4F
    ld a, $01
    jr Jump_00F_6A51

Jump_00F_6A4F::
    ld a, $03

Jump_00F_6A51::
    ld [$CB96], a
    inc a
    inc a
    and a, $03
    ld [$CBA6], a
    pop af
    cp a, $78
    ret nz
    ld a, $80
    ld [$CBCF], a
    ld a, $65
    call Func_000_1278
    ld a, $E0
    ld [$CB9A], a
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_6A77::
    ld a, [$CC39]
    set 3, a
    ld [$CC39], a
    ld de, $007F
    call Func_000_1845
    ldh a, [$FF8E]
    ld [$C8C8], a
    ldh a, [$FF91]
    ld [$C8C9], a
    ld a, $00
    ld [$C8C6], a
    ld hl, Func_05F_6C5A
    ld b, $5F
    rst $10
    ret

Jump_00F_6A9B::
    ld b, $0F
    call Func_00F_72A0
    ret

Jump_00F_6AA1::
    ld de, $CBAB
    call Func_00F_7EE9
    ret nc
    ld a, $63
    call Func_000_1278
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_6AB2::
    ld de, $CBAB
    ld hl, $0870
    call Func_00F_7F24
    ret

Jump_00F_6ABC::
    ld a, [$CBD4]
    inc a
    ld [$CBD4], a
    ld de, $CBD4
    call Func_00F_7EE9
    ret nc
    xor a, a
    ld [$CBCF], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_6AD3::
    ld de, $CB8B
    ld hl, $086F
    call Func_00F_7F24
    ret

Jump_00F_6ADD::
    xor a, a
    ld [$CB80], a
    ld a, $E3
    ld [$CB81], a
    ldh [$FFC6], a
    xor a, a
    ldh [$FFC7], a
    ld a, $00
    ldh [$FFC8], a
    ld a, $05
    ldh [$FFC9], a
    ld hl, $8500
    ld a, l
    ldh [$FFCA], a
    ld a, h
    ldh [$FFCB], a
    ld hl, Func_004_431F
    ld b, $04
    rst $10
    xor a, a
    ld [$CB90], a
    ld a, $D6
    ld [$CB91], a
    ldh [$FFC6], a
    xor a, a
    ldh [$FFC7], a
    ld a, $00
    ldh [$FFC8], a
    ld a, $06
    ldh [$FFC9], a
    ld hl, $8600
    ld a, l
    ldh [$FFCA], a
    ld a, h
    ldh [$FFCB], a
    ld hl, Func_004_431F
    ld b, $04
    rst $10
    ld a, $7F
    ld [$C527], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_6B31::
    ld a, [$CBD4]
    dec a
    dec a
    ld [$CBD4], a
    ld de, $CBD4
    call Func_00F_7EE9
    ret nc
    ld hl, $086E
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_6B4B::
    ld a, $00
    ld [$C929], a
    ld a, $00
    ld [$C92A], a
    ld a, $50
    ld [$C928], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, $01
    ld [$C929], a
    ld a, $00
    ld [$C92A], a
    ld a, $50
    ld [$C928], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld a, $08
    ldh [$FFC6], a
    ld hl, Func_012_6B98
    ld b, $12
    rst $10
    ld a, $40
    ld [$CBD3], a
    ld a, $60
    ld a, a
    ld [$CBD4], a
    ld a, $80
    ld [$CBCF], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_6B99::
    ld de, $CBAB
    ld hl, $086D
    call Func_00F_7F24
    ret

Jump_00F_6BA3::
    ld a, [$CBAA]
    cp a, $80
    jr z, Jump_00F_6BAF
    inc a
    inc a
    ld [$CBAA], a

Jump_00F_6BAF::
    ld b, $3C
    call Func_00F_7EB2
    ret nc
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_6BBA::
    ld a, [$C922]
    or a, a
    jr nz, Jump_00F_6BDA
    ld a, [$C921]
    inc a
    ld [$C921], a
    and a, $03
    ret nz
    ld a, [$CB9A]
    dec a
    ld [$CB9A], a
    cp a, $30
    ret nz
    ld a, $01
    ld [$C922], a
    ret

Jump_00F_6BDA::
    ld a, [$CB9A]
    inc a
    inc a
    ld [$CB9A], a
    cp a, $40
    ret nz
    ld a, $63
    call Func_000_1278
    xor a, a
    ld [$C921], a
    ld [$C922], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_6BF6::
    ld hl, $CB9C
    call Func_00F_7ECE
    ld a, [$C921]
    or a, a
    jr nz, Jump_00F_6C17
    ld a, $03
    ld [$CB96], a
    ld a, [$CB9A]
    dec a
    dec a
    ld [$CB9A], a
    cp a, $40
    ret nz
    ld hl, $C921
    inc [hl]
    ret

Jump_00F_6C17::
    dec a
    jr nz, Jump_00F_6C2F
    ld a, $00
    ld [$CB96], a
    ld a, [$CB9B]
    inc a
    inc a
    ld [$CB9B], a
    cp a, $50
    ret nz
    ld hl, $C921
    inc [hl]
    ret

Jump_00F_6C2F::
    dec a
    jr nz, Jump_00F_6C47
    ld a, $01
    ld [$CB96], a
    ld a, [$CB9A]
    inc a
    inc a
    ld [$CB9A], a
    cp a, $60
    ret nz
    ld hl, $C921
    inc [hl]
    ret

Jump_00F_6C47::
    dec a
    jr nz, Jump_00F_6C5F
    ld a, $02
    ld [$CB96], a
    ld a, [$CB9B]
    dec a
    dec a
    ld [$CB9B], a
    cp a, $30
    ret nz
    ld hl, $C921
    inc [hl]
    ret

Jump_00F_6C5F::
    dec a
    jr nz, Jump_00F_6C77
    ld a, $03
    ld [$CB96], a
    ld a, [$CB9A]
    dec a
    dec a
    ld [$CB9A], a
    cp a, $40
    ret nz
    ld hl, $C921
    inc [hl]
    ret

Jump_00F_6C77::
    ld a, $00
    ld [$CB96], a
    ld a, [$CB9B]
    inc a
    inc a
    ld [$CB9B], a
    cp a, $40
    ret nz
    ld a, $01
    ld [$CB96], a
    ld hl, $CB9C
    call Func_00F_7ED3
    ld de, $7705
    ld b, $7D
    ld hl, $8700
    call Func_000_0CF5
    ld a, $45
    ld [$CBA1], a
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_6CAB::
    ld a, $00
    ld [$C929], a
    ld a, $80
    ld [$C92A], a
    ld a, $40
    ld [$C928], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, $01
    ld [$C929], a
    ld a, $80
    ld [$C92A], a
    ld a, $40
    ld [$C928], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, $02
    ld [$C929], a
    ld a, $80
    ld [$C92A], a
    ld a, $40
    ld [$C928], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld hl, Func_05F_6E09
    ld b, $5F
    rst $10
    ld hl, $086C
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_6D00::
    ld hl, Func_012_61EF
    ld b, $12
    rst $10
    ret

Jump_00F_6D07::
    ldh a, [$FF8E]
    cp a, $40
    jr nz, Jump_00F_6D13
    ld a, $04
    ld [$C923], a
    ret

Jump_00F_6D13::
    ld a, $40
    ld [$C928], a
    ld hl, Func_05F_6B17
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    xor a, a
    ldh [$FF98], a
    ld hl, $C923
    inc [hl]
    ret

Func_00F_6D2B::
    ld a, [$C923]
    rst $00
    dw Jump_00F_6F4C
    dw Jump_00F_6F4C
    dw Jump_00F_6F4C
    dw Jump_00F_6EB0
    dw Jump_00F_6F0C
    dw Jump_00F_6EF0
    dw Jump_00F_6ECD
    dw Jump_00F_6EB0
    dw Jump_00F_6E54
    dw Jump_00F_6E31
    dw Jump_00F_6DD1
    dw Jump_00F_6D80
    dw Jump_00F_6D49

Jump_00F_6D49::
    call Func_00F_6D4D
    ret

Func_00F_6D4D::
    ld hl, $CBD3
    inc [hl]
    ld a, [$C921]
    inc a
    and a, $07
    ld [$C921], a
    ld hl, $6D78
    add a, l
    ld l, a
    jr nc, Jump_00F_6D62
    inc h

Jump_00F_6D62::
    ld a, [hl]
    ld [$CBD4], a
    ld a, [$CBD3]
    cp a, $A0
    ret nz
    ld de, $007E
    call Func_000_1845
    ld a, $80
    ld [$C919], a
    ret
    db $40, $3F, $40, $3F, $40, $3E, $40, $41

Jump_00F_6D80::
    call Func_00F_6D4D
    ld a, $00
    ld [$C929], a
    ld a, $81
    ld [$C92A], a
    ld a, $A0
    ld [$C928], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, $01
    ld [$C929], a
    ld a, $81
    ld [$C92A], a
    ld a, $A0
    ld [$C928], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, $02
    ld [$C929], a
    ld a, $81
    ld [$C92A], a
    ld a, $A0
    ld [$C928], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$CBAA]
    cp a, $A0
    ret nz
    xor a, a
    ld [$CB7D], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_6DD1::
    ld de, $CB8B
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, Func_05F_6BCD
    ld b, $5F
    rst $10
    ld de, $CB9B
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, Func_05F_6BCD
    ld b, $5F
    rst $10
    ld de, $CBAB
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, Func_05F_6BCD
    ld b, $5F
    rst $10
    ld a, [$C5F0]
    and a, $03
    bit 0, a
    jr nz, Jump_00F_6E16
    dec a
    sla a
    ld c, a
    ldh a, [$FFA1]
    add a, c
    ldh [$FFA1], a

Jump_00F_6E16::
    ld b, $20
    call Func_00F_7EB2
    ret nc
    ldh a, [$FFA1]
    add a, $07
    and a, $F8
    ldh [$FFA1], a
    ld a, $7D
    call Func_000_1278
    ld hl, $C923
    inc [hl]
    xor a, a
    ldh [$FF8D], a
    ret

Jump_00F_6E31::
    ld a, [$CBD4]
    inc a
    inc a
    ld [$CBD4], a
    cp a, $40
    ret nz
    ld hl, Func_05F_6E09
    ld b, $5F
    rst $10
    ld a, $66
    call Func_000_1278
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ld a, $0E
    ldh [$FF8D], a
    ret

Jump_00F_6E54::
    ld b, $03
    ld hl, $CB8B

Jump_00F_6E59::
    push hl
    ld a, [hl]
    cp a, $40
    jr z, Jump_00F_6E64
    dec a
    dec a
    ld [hl], a
    jr Jump_00F_6E6F

Jump_00F_6E64::
    dec hl
    ld a, [hl]
    dec a
    dec a
    ld [hl], a
    dec hl
    dec hl
    dec hl
    dec hl
    ld [hl], $03

Jump_00F_6E6F::
    pop hl
    ld a, $10
    add a, l
    ld l, a
    jr nc, Jump_00F_6E77
    inc h

Jump_00F_6E77::
    dec b
    jr nz, Jump_00F_6E59
    ld a, [$CB8A]
    cp a, $40
    ret nz
    ld a, $03
    ld [$CBA6], a
    ld hl, $CB8C
    call Func_00F_7ED3
    ld hl, $CB9C
    call Func_00F_7ED3
    ld hl, $CBAC
    call Func_00F_7ED3
    ld a, $07
    ldh [$FFC6], a
    ld hl, Func_012_6B98
    ld b, $12
    rst $10
    ld a, $80
    ld [$CBCF], a
    ld a, $65
    call Func_000_1278
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_6EB0::
    ld b, $3C
    call Func_00F_7EB2
    ret nc
    ld hl, $CB8C
    call Func_00F_7ECE
    ld hl, $CB9C
    call Func_00F_7ECE
    ld hl, $CBAC
    call Func_00F_7ECE
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_6ECD::
    ldh a, [$FF91]
    call Func_00F_7ED8
    ldh a, [$FF91]
    call Func_00F_7ED8
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $1E
    ret nz
    ld hl, $FF8C
    call Func_00F_7EC9
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_6EF0::
    ldh a, [$FF91]
    call Func_00F_7ED8
    ldh a, [$FF91]
    dec a
    ldh [$FF91], a
    ldh a, [$FF91]
    call Func_00F_7ED8
    ldh a, [$FF91]
    dec a
    ldh [$FF91], a
    cp a, $30
    ret nz
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_6F0C::
    xor a, a
    ldh [$FF98], a
    ld a, [$CBAB]
    dec a
    dec a
    ld [$CBAB], a
    ld a, [$CB9B]
    dec a
    dec a
    ld [$CB9B], a
    ld a, [$CB8B]
    dec a
    dec a
    ld [$CB8B], a
    cp a, $70
    ret nz
    ld hl, $CB8C
    call Func_00F_7ED3
    ld hl, $CB9C
    call Func_00F_7ED3
    ld hl, $CBAC
    call Func_00F_7ED3
    ld hl, $FF8C
    call Func_00F_7EC4
    ld a, $63
    call Func_000_1278
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_6F4C::
    ld hl, Func_012_61EF
    ld b, $12
    rst $10
    ld hl, $CB8C
    call Func_00F_7ECE
    ld hl, $CB9C
    call Func_00F_7ECE
    ld hl, $CBAC
    call Func_00F_7ECE
    ret

Func_00F_6F65::
    ld a, [$C923]
    rst $00
    dw Jump_00F_7002
    dw Jump_00F_6FB5
    dw Jump_00F_6F9A
    dw Jump_00F_6F71

Jump_00F_6F71::
    ld a, [$C921]
    inc a
    ld [$C921], a
    push af
    bit 4, a
    jr z, Jump_00F_6F81
    ld a, $01
    jr Jump_00F_6F83

Jump_00F_6F81::
    ld a, $03

Jump_00F_6F83::
    ld [$CB86], a
    ld [$CBA6], a
    inc a
    inc a
    and a, $03
    ld [$CB96], a
    pop af
    cp a, $78
    ret nz
    ld a, $80
    ld [$C919], a
    ret

Jump_00F_6F9A::
    ld hl, $CB8C
    call Func_00F_7ECE
    ld hl, $CB9C
    call Func_00F_7ECE
    ld hl, $CBAC
    call Func_00F_7ECE
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_6FB5::
    ld a, [$C5F0]
    and a, $03
    bit 0, a
    jr nz, Jump_00F_6FC7
    dec a
    sla a
    ld c, a
    ldh a, [$FFA1]
    add a, c
    ldh [$FFA1], a

Jump_00F_6FC7::
    ld b, $78
    call Func_00F_7EB2
    ret nc
    ldh a, [$FFA1]
    add a, $07
    and a, $F8
    ldh [$FFA1], a
    ld de, $007D
    call Func_000_1845
    ld a, [$CC39]
    set 2, a
    ld [$CC39], a
    ldh a, [$FF8E]
    ld [$C8C8], a
    ldh a, [$FF91]
    ld [$C8C9], a
    ld a, $00
    ld [$C8C6], a
    xor a, a
    ld [$C8C7], a
    ld hl, Func_05F_6C5A
    ld b, $5F
    rst $10
    ld a, $00
    call Func_000_1278
    ret

Jump_00F_7002::
    ld hl, $CB8C
    call Func_00F_7ECE
    ld hl, $CB9C
    call Func_00F_7ECE
    ld hl, $CBAC
    call Func_00F_7ECE
    ld b, $03
    ld hl, $CB8A

Jump_00F_7019::
    ld a, [hl]
    inc a
    inc a
    ld [hl], a
    ld a, $10
    add a, l
    ld l, a
    jr nc, Jump_00F_7024
    inc h

Jump_00F_7024::
    dec b
    jr nz, Jump_00F_7019
    ld a, [$CB8A]
    cp a, $60
    ret nz
    ld hl, $CB8C
    call Func_00F_7ED3
    ld hl, $CB9C
    call Func_00F_7ED3
    ld hl, $CBAC
    call Func_00F_7ED3
    ld a, $7D
    call Func_000_1278
    ld hl, $C923
    inc [hl]
    ret

Func_00F_7049::
    ld a, [$C923]
    rst $00
    dw Jump_00F_7051
    dw Jump_00F_706C

Jump_00F_7051::
    ld hl, $CB8C
    call Func_00F_7ECE
    ld hl, $CB9C
    call Func_00F_7ECE
    ld hl, $CBAC
    call Func_00F_7ECE
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_706C::
    ld b, $03
    ld hl, $CB8B

Jump_00F_7071::
    ld a, [hl]
    cp a, $E0
    jr z, Jump_00F_7079
    dec a
    dec a
    ld [hl], a

Jump_00F_7079::
    ld a, $10
    add a, l
    ld l, a
    jr nc, Jump_00F_7080
    inc h

Jump_00F_7080::
    dec b
    jr nz, Jump_00F_7071
    ld a, [$CBAB]
    cp a, $E0
    ret nz
    xor a, a
    ld [$CB7D], a
    ld a, $80
    ld [$C919], a
    ret

Func_00F_7093::
    ld a, [$C923]
    rst $00
    dw Jump_00F_7099

Jump_00F_7099::
    ld de, $0075
    call Func_000_181B
    jr c, Jump_00F_70BD
    ld a, $00
    ldh [$FFC6], a
    ld a, $20
    ldh [$FFC7], a
    ld hl, Func_05F_6BF8
    ld b, $5F
    rst $10
    ldh a, [$FFC6]
    or a, a
    ret z
    xor a, a
    ld [$CB7D], a
    ld a, $80
    ld [$C919], a
    ret

Jump_00F_70BD::
    ld a, $00
    ldh [$FFC6], a
    ld a, $40
    ldh [$FFC7], a
    ld hl, Func_05F_6BF8
    ld b, $5F
    rst $10
    ldh a, [$FFC6]
    or a, a
    ret z
    ld de, $009B
    call Func_000_181B
    jr nc, Jump_00F_70E2
    ld a, $33
    ld [$C928], a
    ld hl, Func_05F_6C8C
    ld b, $5F
    rst $10

Jump_00F_70E2::
    xor a, a
    ld [$CB7D], a
    ld a, $80
    ld [$C919], a
    ret

Func_00F_70EC::
    ld a, [$C923]
    rst $00
    dw Jump_00F_7225
    dw Jump_00F_7210
    dw Jump_00F_7F89
    dw Jump_00F_7209
    dw Jump_00F_71DD
    dw Jump_00F_7F89
    dw Jump_00F_7198
    dw Jump_00F_714A
    dw Jump_00F_712A
    dw Jump_00F_7104

Jump_00F_7104::
    ldh a, [$FF8E]
    call Func_00F_7ED8
    ldh a, [$FF8E]
    call Func_00F_7ED8
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $1E
    ret nz
    ldh a, [$FF8C]
    and a, $FD
    ldh [$FF8C], a
    ld de, $0064
    call Func_000_1845
    ld a, $80
    ld [$C919], a
    ret

Jump_00F_712A::
    ldh a, [$FF8E]
    call Func_00F_7ED8
    ldh a, [$FF8E]
    inc a
    ldh [$FF8E], a
    ldh a, [$FF8E]
    call Func_00F_7ED8
    ldh a, [$FF8E]
    inc a
    ldh [$FF8E], a
    cp a, $70
    ret nz
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_714A::
    ld a, [$C922]
    or a, a
    jr nz, Jump_00F_716A
    ld a, [$C921]
    inc a
    ld [$C921], a
    and a, $03
    ret nz
    ld a, [$CB8A]
    dec a
    ld [$CB8A], a
    cp a, $20
    ret nz
    ld a, $01
    ld [$C922], a
    ret

Jump_00F_716A::
    ld a, $00
    ld [$C929], a
    ld a, $81
    ld [$C92A], a
    ld a, $30
    ld [$C928], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ldh a, [$FF8C]
    or a, $02
    ldh [$FF8C], a
    ld a, $63
    call Func_000_1278
    xor a, a
    ld [$C922], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_7198::
    ld a, [$CB8A]
    cp a, $30
    jr z, Jump_00F_71B5
    ld a, $00
    ld [$C929], a
    ld a, $03
    ld [$C92A], a
    ld a, $30
    ld [$C928], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ret

Jump_00F_71B5::
    ld a, $00
    ld [$C929], a
    ld a, $00
    ld [$C92A], a
    ld a, $70
    ld [$C928], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld a, $01
    ld [$CB86], a
    ld a, $03
    ldh [$FF98], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_71DD::
    xor a, a
    ld [$CB96], a
    ld [$CBA6], a
    ld a, $00
    ld [$C929], a
    ld a, $00
    ld [$C92A], a
    ld a, $60
    ld [$C928], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld hl, $0833
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_7209::
    ld de, $CB8B
    call Func_00F_7F0B
    ret

Jump_00F_7210::
    xor a, a
    call Func_00F_7F75
    ret nc
    ld a, $01
    ld [$CB96], a
    ld hl, $0832
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_7225::
    ld hl, $CB8C
    call Func_00F_7ECE
    ld hl, $CB9C
    call Func_00F_7ECE
    ld hl, $CBAC
    call Func_00F_7ECE
    ld hl, $CB8B
    ld b, $03

Jump_00F_723C::
    ld a, [hl]
    inc a
    ld [hl], a
    ld a, $10
    add a, l
    ld l, a
    jr nc, Jump_00F_7246
    inc h

Jump_00F_7246::
    dec b
    jr nz, Jump_00F_723C
    ld a, [$CB8B]
    cp a, $40
    ret nz
    ld hl, $CB8C
    call Func_00F_7ED3
    ld hl, $CB9C
    call Func_00F_7ED3
    ld hl, $CBAC
    call Func_00F_7ED3
    ld a, $03
    ld [$CBA6], a
    ld hl, $0831
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Func_00F_7271::
    ld a, [$C923]
    rst $00
    dw Jump_00F_727B
    dw Jump_00F_728B
    dw Jump_00F_7291

Jump_00F_727B::
    ld hl, Func_05F_6E09
    ld b, $5F
    rst $10
    ld a, $7D
    call Func_000_1278
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_728B::
    ld b, $78
    call Func_00F_72A0
    ret

Jump_00F_7291::
    ld a, $00
    call Func_000_1278
    ld a, $80
    ld [$C919], a
    ret

Func_00F_729C::
    ld a, [$C928]
    ld b, a

Func_00F_72A0::
    ld a, [$C5F0]
    and a, $03
    bit 0, a
    jr nz, Jump_00F_72CB
    dec a
    add a, a
    ld c, a
    bit 7, a
    jr z, Jump_00F_72C0
    cpl
    inc a
    ld c, a
    ldh a, [$FFA1]
    sub a, c
    ldh [$FFA1], a
    ldh a, [$FFA2]
    sbc a, $00
    ldh [$FFA2], a
    jr Jump_00F_72CB

Jump_00F_72C0::
    ldh a, [$FFA1]
    add a, c
    ldh [$FFA1], a
    ldh a, [$FFA2]
    adc a, $00
    ldh [$FFA2], a

Jump_00F_72CB::
    call Func_00F_7EB2
    ret nc
    xor a, a
    ldh [$FFA1], a
    ldh [$FFA2], a
    ld hl, $C923
    inc [hl]
    ret

Func_00F_72D9::
    ld a, [$C923]
    rst $00
    dw Jump_00F_7601
    dw Jump_00F_75C3
    dw Jump_00F_7F89
    dw Jump_00F_75AA
    dw Jump_00F_6F4C
    dw Jump_00F_6F4C
    dw Jump_00F_6F4C
    dw Jump_00F_756F
    dw Jump_00F_7F89
    dw Jump_00F_7546
    dw Jump_00F_753B
    dw Jump_00F_7F89
    dw Jump_00F_7546
    dw Jump_00F_7530
    dw Jump_00F_7F89
    dw Jump_00F_74F7
    dw Jump_00F_749D
    dw Jump_00F_7473
    dw Jump_00F_7F89
    dw Jump_00F_7450
    dw Jump_00F_743A
    dw Jump_00F_7F89
    dw Jump_00F_740C
    dw Jump_00F_7F89
    dw Jump_00F_7401
    dw Jump_00F_7F89
    dw Jump_00F_73D8
    dw Jump_00F_7F89
    dw Jump_00F_73CD
    dw Jump_00F_7F89
    dw Jump_00F_739E
    dw Jump_00F_7397
    dw Jump_00F_7369
    dw Jump_00F_7348
    dw Jump_00F_7F89
    dw Jump_00F_7325

Jump_00F_7325::
    ld de, $0021
    call Func_000_1845
    ld a, $02
    ldh [$FFC6], a
    ld hl, Func_05F_6DAC
    ld b, $5F
    rst $10
    ld a, [$CC37]
    set 1, a
    ld [$CC37], a
    ld a, $01
    ld [$C7C7], a
    ld a, $80
    ld [$C919], a
    ret

Jump_00F_7348::
    ldh a, [$FF91]
    ld c, a
    ld a, [$CBD4]
    inc a
    ld [$CBD4], a
    cp a, c
    ret nz
    xor a, a
    ld [$CBCF], a
    ld hl, $0DC0
    call Func_00F_7F68
    ld de, $001D
    call Func_000_1845
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_7369::
    ldh a, [$FF98]
    inc a
    inc a
    and a, $03
    ld [$CB86], a
    ld a, $11
    ldh [$FFC6], a
    ld hl, Func_012_6B98
    ld b, $12
    rst $10
    ldh a, [$FF8E]
    ld [$CBD3], a
    ldh a, [$FF91]
    sub a, $20
    ld [$CBD4], a
    ld a, $80
    ld [$CBCF], a
    ld a, $85
    call Func_000_1278
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_7397::
    ld hl, Func_05F_7363
    ld b, $5F
    rst $10
    ret

Jump_00F_739E::
    ld a, $05
    ldh [$FF90], a
    ld a, $01
    ldh [$FF8F], a
    xor a, a
    ldh [$FF92], a
    ld a, $50
    ld [$C8C8], a
    ld a, $30
    ld [$C8C9], a
    ld a, $01
    ld [$C8C6], a
    xor a, a
    ld [$CCE9], a
    ld hl, Func_05F_6C5A
    ld b, $5F
    rst $10
    ld hl, $0125
    call Func_00F_7F68
    xor a, a
    ld [$C92D], a
    ret

Jump_00F_73CD::
    ld hl, $01A2
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_73D8::
    ld a, $00
    ld [$C929], a
    ld a, $00
    ld [$C92A], a
    ld a, $A0
    ld [$C928], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    xor a, a
    ld [$CB7D], a
    ld hl, $01A1
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_7401::
    ld hl, $01A0
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_740C::
    ld hl, $CBD3
    dec [hl]
    ld hl, $CBD4
    inc [hl]
    ld de, $CBD4
    call Func_00F_7EE9
    ret nc
    ld hl, $019F
    call Func_00F_7F68
    xor a, a
    ld [$CBCF], a
    ld a, [$C933]
    ld [$C6FD], a
    ld a, $50
    ld [$CBD3], a
    ld a, $30
    ld [$CBD4], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_743A::
    ld hl, $CBD4
    dec [hl]
    ld de, $CBD4
    call Func_00F_7EE9
    ret nc
    ld hl, $019E
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_7450::
    ld a, $40
    ld [$CBD3], a
    ld a, $20
    ld [$CBD4], a
    ld a, $80
    ld [$CBCF], a
    ld a, [$C6FD]
    ld [$C933], a
    cp a, $03
    jr nz, Jump_00F_746E
    ld a, $02
    ld [$C6FD], a

Jump_00F_746E::
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_7473::
    ld a, $00
    ld [$C929], a
    ld a, $00
    ld [$C92A], a
    ld a, $20
    ld [$C928], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld hl, $019D
    call Func_00F_7F68
    ld a, $03
    ld [$CB86], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_749D::
    ld a, $00
    ld [$C92A], a
    ld a, $A0
    ld [$C928], a
    ld a, $00
    ld [$C929], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, $01
    ld [$C929], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, $02
    ld [$C929], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, $03
    ld [$C929], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld a, $01
    ld [$CB7D], a
    ld de, $5B5F
    ld b, $7D
    ld hl, $8500
    call Func_000_0CF5
    ld a, $22
    ld [$CB81], a
    ld a, $E0
    ld [$CB8B], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_74F7::
    ld a, $E0
    ld [$CBAB], a
    ld a, $B0
    ld [$CBBB], a
    ld a, $D0
    ld [$CB8B], a
    ld a, $C0
    ld [$CB9B], a
    ld de, $5F6E
    ld b, $7D
    ld hl, $8500
    call Func_000_0CF5
    ld a, $27
    ld [$CB81], a
    ld de, $5F6E
    ld b, $7D
    ld hl, $8600
    call Func_000_0CF5
    ld a, $27
    ld [$CB91], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_7530::
    ld hl, $019C
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_753B::
    ld hl, $019B
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_7546::
    ld a, [$C921]
    or a, a
    jr nz, Jump_00F_7553
    ld a, $7C
    call Func_000_1278
    jr Jump_00F_755C

Jump_00F_7553::
    cp a, $3C
    jr nz, Jump_00F_755C
    ld a, $81
    call Func_000_1278

Jump_00F_755C::
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $78
    ret nz
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_756F::
    ld a, $02
    ld [$C92A], a
    ld a, $E0
    ld [$C928], a
    ld a, $01
    ld [$C929], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, $02
    ld [$C929], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, $03
    ld [$C929], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld hl, $019A
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_75AA::
    ld a, $30
    ld [$C928], a
    ld hl, Func_05F_6B17
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld a, $01
    ldh [$FF98], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_75C3::
    ld a, $02
    ld [$C92A], a
    ld a, $40
    ld [$C928], a
    ld a, $03
    ld [$C929], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, $02
    ld [$C929], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, $01
    ld [$C929], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    xor a, a
    ldh [$FF98], a
    ld hl, $0199
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_7601::
    xor a, a
    ldh [$FFC6], a
    ld a, $10
    ldh [$FFC7], a
    ld hl, Func_05F_6BF8
    ld b, $5F
    rst $10
    ldh a, [$FFC6]
    or a, a
    ret z
    ld a, [$CC38]
    set 5, a
    ld [$CC38], a
    ld de, $005A
    call Func_000_1845
    ld hl, $C923
    inc [hl]
    ret

Func_00F_7625::
    ld a, [$C923]
    rst $00
    dw Jump_00F_7707
    dw Jump_00F_76E3
    dw Jump_00F_766D
    dw Jump_00F_7639
    dw Jump_00F_7633

Jump_00F_7633::
    ld a, $80
    ld [$C919], a
    ret

Jump_00F_7639::
    ld a, $20
    ld [$C928], a
    ld hl, Func_05F_6B17
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld a, $2E
    ldh [$FF90], a
    xor a, a
    ldh [$FF8F], a
    ldh [$FF92], a
    ld a, $20
    ld [$C8C8], a
    ld a, $60
    ld [$C8C9], a
    ld a, $01
    ld [$C8C6], a
    ld hl, Func_05F_6C5A
    ld b, $5F
    rst $10
    ld a, $60
    call Func_000_1278
    ret

Jump_00F_766D::
    ld a, [$C921]
    and a, $0F
    jr nz, Jump_00F_768B
    ld a, $60
    ld [$C928], a
    ld hl, Func_05F_6A94
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    jr z, Jump_00F_7696
    ld hl, $C921
    inc [hl]
    jr Jump_00F_7696

Jump_00F_768B::
    ld a, $30
    ld [$C928], a
    ld hl, Func_05F_6B17
    ld b, $5F
    rst $10

Jump_00F_7696::
    ld a, $00
    ld [$C929], a
    ld a, [$C921]
    and a, $F0
    jr nz, Jump_00F_76C0
    ld a, $00
    ld [$C92A], a
    ld a, $60
    ld [$C928], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld a, [$C921]
    or a, $10
    ld [$C921], a
    ret

Jump_00F_76C0::
    ld a, $03
    ld [$C92A], a
    ld a, $20
    ld [$C928], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld a, $E0
    ld [$CB8A], a
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_76E3::
    ld a, $25
    ldh [$FF90], a
    xor a, a
    ldh [$FF8F], a
    ldh [$FF92], a
    ld a, $40
    ld [$C8C8], a
    ld a, $08
    ld [$C8C9], a
    ld a, $01
    ld [$C8C6], a
    ld hl, Func_05F_6C5A
    ld b, $5F
    rst $10
    ld a, $60
    call Func_000_1278
    ret

Jump_00F_7707::
    ldh a, [$FF8E]
    cp a, $40
    jr z, Jump_00F_7719
    ld a, $40
    ld [$C928], a
    ld hl, Func_05F_6B17
    ld b, $5F
    rst $10
    ret

Jump_00F_7719::
    ld a, $80
    ld [$C928], a
    ld hl, Func_05F_6A94
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld hl, $C923
    inc [hl]
    ret

Func_00F_772E::
    ld a, [$C923]
    rst $00
    dw Jump_00F_7746
    dw Jump_00F_776B
    dw Jump_00F_777E
    dw Jump_00F_7F89
    dw Jump_00F_7795
    dw Jump_00F_77C9
    dw Jump_00F_77F1
    dw Jump_00F_7806
    dw Jump_00F_780D
    dw Jump_00F_785B

Jump_00F_7746::
    ld a, $25
    ldh [$FF90], a
    xor a, a
    ldh [$FF8F], a
    ldh [$FF92], a
    ld a, $50
    ld [$C8C8], a
    ld a, $30
    ld [$C8C9], a
    ld a, $03
    ld [$C8C6], a
    ld hl, Func_05F_6C5A
    ld b, $5F
    rst $10
    ld hl, $0151
    call Func_00F_7F68
    ret

Jump_00F_776B::
    xor a, a
    call Func_00F_7F75
    ret nc
    ld a, $6D
    call Func_000_1278
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_777E::
    ld b, $B4
    call Func_00F_7EB2
    ret nc
    ld hl, Func_002_604B
    ld b, $02
    rst $10
    ld hl, $0152
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_7795::
    ld a, $00
    ld [$C928], a
    ld hl, Func_05F_6AEB
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld a, $26
    ldh [$FF90], a
    xor a, a
    ldh [$FF8F], a
    ldh [$FF92], a
    ld a, $50
    ld [$C8C8], a
    ld a, $80
    ld [$C8C9], a
    ld a, $03
    ld [$C8C6], a
    ld hl, Func_05F_6C5A
    ld b, $5F
    rst $10
    ld a, $60
    call Func_000_1278
    ret

Jump_00F_77C9::
    ld a, $40
    ld [$C928], a
    ld hl, Func_05F_6AEB
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld hl, $FF8C
    call Func_00F_7ED3
    ld a, $02
    ldh [$FF98], a
    ld a, $6D
    call Func_000_1278
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_77F1::
    ld b, $B4
    call Func_00F_7EB2
    ret nc
    ld hl, Func_002_604B
    ld b, $02
    rst $10
    xor a, a
    ld [$C92D], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_7806::
    ld hl, Func_05F_70D2
    ld b, $5F
    rst $10
    ret

Jump_00F_780D::
    ld a, [$C921]
    or a, a
    jr nz, Jump_00F_781C
    inc a
    ld [$C921], a
    ld a, $6D
    call Func_000_1278

Jump_00F_781C::
    ld a, $80
    ld [$C928], a
    ld hl, Func_05F_6A94
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld a, $25
    ldh [$FF90], a
    ld a, $01
    ldh [$FF8F], a
    xor a, a
    ldh [$FF92], a
    ld a, $30
    ld [$C8C8], a
    ld a, $40
    ld [$C8C9], a
    ld a, $01
    ld [$C8C6], a
    ld hl, Func_05F_6C5A
    ld b, $5F
    rst $10
    ld a, $02
    call Func_000_122D
    ld a, $60
    call Func_000_1278
    xor a, a
    ld [$C921], a
    ret

Jump_00F_785B::
    ld hl, Func_002_6050
    ld b, $02
    rst $10
    ld a, [$CC38]
    or a, $01
    ld [$CC38], a
    ld a, $80
    ld [$C919], a
    ret

Func_00F_786F::
    ld a, [$C923]
    rst $00
    dw Jump_00F_7F89
    dw Jump_00F_79EC
    dw Jump_00F_79D1
    dw Jump_00F_7F89
    dw Jump_00F_7968
    dw Jump_00F_7937
    dw Jump_00F_7F89
    dw Jump_00F_790A
    dw Jump_00F_78E7
    dw Jump_00F_78CB
    dw Jump_00F_78B7
    dw Jump_00F_789B
    dw Jump_00F_788D

Jump_00F_788D::
    ld a, [$CC37]
    set 0, a
    ld [$CC37], a
    ld a, $80
    ld [$C919], a
    ret

Jump_00F_789B::
    xor a, a
    call Func_00F_7F75
    ret nc
    ld a, $01
    ld [$C8C6], a
    ld hl, Func_05F_6C5A
    ld b, $5F
    rst $10
    ld a, $01
    ld [$C6FD], a
    ld de, $0002
    call Func_000_1845
    ret

Jump_00F_78B7::
    xor a, a
    call Func_00F_7F75
    ret nc
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ld hl, $0093
    call Func_00F_7F68
    ret

Jump_00F_78CB::
    ld de, $FF91
    call Func_00F_7EE9
    push af
    ldh a, [$FF91]
    ld [$C8F1], a
    pop af
    ret nc
    ld a, $01
    ldh [$FF98], a
    ld a, $03
    ld [$C8EF], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_78E7::
    xor a, a
    call Func_00F_7F75
    ret nc
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ld de, $0000
    call Func_000_181B
    jr c, Jump_00F_7903
    ld hl, $009A
    call Func_00F_7F68
    ret

Jump_00F_7903::
    ld hl, $0092
    call Func_00F_7F68
    ret

Jump_00F_790A::
    ld a, $00
    ld [$C929], a
    ld a, $03
    ld [$C92A], a
    ld a, $70
    ld [$C928], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    xor a, a
    ld [$CB86], a
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ld hl, $0091
    call Func_00F_7F68
    ret

Jump_00F_7937::
    ld de, $CB8B
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, Func_05F_6BCD
    ld b, $5F
    rst $10
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $20
    ret nz
    ld a, $02
    ldh [$FF98], a
    ld [$C8EF], a
    ld hl, $0090
    call Func_00F_7F68
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_7968::
    ld a, [$C921]
    or a, a
    jr nz, Jump_00F_798D
    ld a, $00
    ld [$C929], a
    ld a, $03
    ld [$C92A], a
    ld a, $60
    ld [$C928], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld hl, $C921
    inc [hl]
    ret

Jump_00F_798D::
    ld a, [$CB8B]
    cp a, $40
    jr z, Jump_00F_79AA
    ld a, $00
    ld [$C929], a
    ld a, $02
    ld [$C92A], a
    ld a, $40
    ld [$C928], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ret

Jump_00F_79AA::
    ld a, $00
    ld [$C929], a
    ld a, $01
    ld [$C92A], a
    ld a, $78
    ld [$C928], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    xor a, a
    ld [$CB86], a
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_79D1::
    xor a, a
    call Func_00F_7F75
    ret nc
    ld a, [$C924]
    ld l, a
    ld a, [$C925]
    ld h, a
    dec hl
    ld a, l
    ld [$C924], a
    ld a, h
    ld [$C925], a
    ld hl, $C923
    dec [hl]
    ret

Jump_00F_79EC::
    ld a, [$C552]
    or a, a
    jr nz, Jump_00F_7A12
    ld a, [$C924]
    ld l, a
    ld a, [$C925]
    ld h, a
    ld h, $80
    inc hl
    inc hl
    ld a, l
    ld [$C924], a
    ld a, h
    ld [$C925], a
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_7A12::
    ld a, [$C924]
    ld l, a
    ld a, [$C925]
    ld h, a
    ld h, $C0
    inc hl
    ld a, l
    ld [$C924], a
    ld a, h
    ld [$C925], a
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Func_00F_7A2D::
    ld a, [$C923]
    rst $00
    dw Jump_00F_7AA2
    dw Jump_00F_7A70
    dw Jump_00F_7F89
    dw Jump_00F_7A3B
    dw Jump_00F_7F93

Jump_00F_7A3B::
    ld hl, $C923
    inc [hl]
    ld a, [$C552]
    or a, a
    jr nz, Jump_00F_7A5A
    ld a, [$C924]
    ld l, a
    ld a, [$C925]
    ld h, a
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $40
    ld h, a
    inc hl
    call Func_00F_7F68
    ret

Jump_00F_7A5A::
    ld a, [$C924]
    ld l, a
    ld a, [$C925]
    ld h, a
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $40
    ld h, a
    inc hl
    inc hl
    call Func_00F_7F68
    ret

Jump_00F_7A70::
    ld a, $01
    ld [$C8EF], a
    ld a, [$C8F0]
    inc a
    ld [$C8F0], a
    cp a, $80
    ret nz
    ld a, $01
    ldh [$FF98], a
    ld a, $03
    ld [$C8EF], a
    ld hl, $C923
    inc [hl]
    ld de, $0000
    call Func_000_181B
    jr c, Jump_00F_7A9B
    ld hl, $4094
    call Func_00F_7F68
    ret

Jump_00F_7A9B::
    ld hl, $4089
    call Func_00F_7F68
    ret

Jump_00F_7AA2::
    xor a, a
    call Func_00F_7F75
    ret nc
    ld a, $06
    ldh [$FF90], a
    xor a, a
    ldh [$FF8F], a
    ldh [$FF92], a
    ld a, $70
    ld [$C8C8], a
    ld a, $50
    ld [$C8C9], a
    ld a, $02
    ld [$C8C6], a
    ld hl, Func_05F_6C5A
    ld b, $5F
    rst $10
    ret

Func_00F_7AC6::
    ld a, [$C923]
    rst $00
    dw Jump_00F_7C84
    dw Jump_00F_7C72
    dw Jump_00F_7C4F
    dw Jump_00F_7C22
    dw Jump_00F_7C22
    dw Jump_00F_7C22
    dw Jump_00F_7C22
    dw Jump_00F_7C22
    dw Jump_00F_7C22
    dw Jump_00F_7C19
    dw Jump_00F_7B3B
    dw Jump_00F_7B2A
    dw Jump_00F_7F89
    dw Jump_00F_7AF9
    dw Jump_00F_7AE8

Jump_00F_7AE8::
    ld a, $0A
    ld [$C917], a
    ld a, $02
    ld [$C916], a
    ld hl, Func_013_405C
    ld b, $13
    rst $10
    ret

Jump_00F_7AF9::
    ld a, $00
    ldh [$FF90], a
    ld a, $01
    ldh [$FF8F], a
    ld a, $02
    ldh [$FF92], a
    ld a, $50
    ld [$C8C8], a
    ld [$C8C9], a
    ld a, $01
    ld [$C8C6], a
    ld hl, Func_05F_6C5A
    ld b, $5F
    rst $10
    ld de, $001B
    call Func_000_1845
    ld a, $01
    ldh [$FF8B], a
    xor a, a
    ld [$C924], a
    ld [$C925], a
    ret

Jump_00F_7B2A::
    ld b, $78
    call Func_00F_7EB2
    ret nc
    ld hl, $0014
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_7B3B::
    ld a, [$C921]
    inc a
    ld [$C921], a
    and a, $03
    ret nz
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
    jr nc, Jump_00F_7B69
    inc d

Jump_00F_7B69::
    ld a, e
    sub a, $20
    ld e, a
    ld a, d
    sbc a, $00
    ld d, a
    ld a, d
    cp a, $97
    jr nz, Jump_00F_7B7E
    ld a, e
    add a, $00
    ld e, a
    ld a, d
    adc a, $04
    ld d, a

Jump_00F_7B7E::
    ld a, [$C469]
    srl a
    srl a
    srl a
    ld c, a
    ld a, $11
    sub a, c
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add a, l
    ld l, a
    jr nc, Jump_00F_7B95
    inc h

Jump_00F_7B95::
    add hl, hl
    add hl, hl
    ld a, l
    add a, $98
    ld l, a
    ld a, h
    adc a, $C1
    ld h, a
    call Func_00F_7BC3
    ldh a, [$FFA5]
    sub a, $01
    ldh [$FFA5], a
    ld hl, $C469
    inc [hl]
    ld a, [$C469]
    cp a, $90
    jr nc, Jump_00F_7BB4
    ret

Jump_00F_7BB4::
    ldh a, [$FFA5]
    and a, $F8
    ldh [$FFA5], a
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Func_00F_7BC3::
    ld a, e
    ld [$C0C0], a
    ld a, d
    ld [$C0C1], a
    xor a, a
    ld [$C0C2], a
    ld a, $14
    ld [$C0C3], a
    push hl
    push de
    ld b, $14
    ld de, $C0C4

Jump_00F_7BDB::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_00F_7BDB
    pop de
    pop hl
    ld a, [$C525]
    or a, a
    ret z
    ld a, e
    ld [$C0D8], a
    ld a, d
    ld [$C0D9], a
    ld a, $00
    ld [$C0DA], a
    ld a, $14
    ld [$C0DB], a
    ld de, $0E68
    add hl, de
    ld b, $14
    ld de, $C0DC

Jump_00F_7C03::
    ld a, $02
    ldh [$FF70], a
    ld a, [hl+]
    ldh [$FFC6], a
    ld a, $00
    ldh [$FF70], a
    ldh a, [$FFC6]
    and a, $07
    ld [de], a
    ld [de], a
    inc de
    dec b
    jr nz, Jump_00F_7C03
    ret

Jump_00F_7C19::
    xor a, a
    ld [$C469], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_7C22::
    ld a, [$C921]
    inc a
    ld [$C921], a
    and a, $03
    ret nz
    ld a, [$C921]
    srl a
    srl a
    cp a, $10
    jr z, Jump_00F_7C3F
    ld hl, $FFA5
    dec [hl]
    call Func_000_252D
    ret

Jump_00F_7C3F::
    xor a, a
    ld [$C921], a
    ldh [$FFA5], a
    ldh [$FFA6], a
    call Func_000_252D
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_7C4F::
    ld hl, $CB8C
    call Func_00F_7ECE
    ld a, [$C921]
    inc a
    ld [$C921], a
    and a, $03
    ret nz
    ld a, [$CB8B]
    dec a
    ld [$CB8B], a
    cp a, $50
    ret nz
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_7C72::
    ld b, $3C
    call Func_00F_7EB2
    ret nc
    ld hl, $FF92
    dec [hl]
    call Func_000_19A9
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_7C84::
    ld a, $1C
    ldh [$FF90], a
    xor a, a
    ldh [$FF8F], a
    ld a, $01
    ldh [$FF92], a
    ld a, $E0
    ld [$C8C8], a
    ld a, $00
    ld [$C8C9], a
    ld a, $03
    ld [$C8C6], a
    ld hl, Func_05F_6C5A
    ld b, $5F
    rst $10
    ret

Func_00F_7CA5::
    ld a, [$C923]
    rst $00
    dw Jump_00F_7CD6
    dw Jump_00F_7CD6
    dw Jump_00F_7F89
    dw Jump_00F_7CB1

Jump_00F_7CB1::
    ld a, $76
    call Func_000_1278
    ld de, $001B
    call Func_000_1845
    ld a, $03
    ld [$C8EF], a
    ld a, $60
    ld [$C8F0], a
    ld a, $50
    ld [$C8F1], a
    ld a, $E0
    ld [$CBBB], a
    ld a, $80
    ld [$C919], a
    ret

Jump_00F_7CD6::
    ld de, $CBBB
    call Func_00F_7EE9
    ret nc
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ld de, $0001
    call Func_000_181B
    jr nc, Jump_00F_7CF4
    ld hl, $0076
    call Func_00F_7F68
    ret

Jump_00F_7CF4::
    ld hl, $0078
    call Func_00F_7F68
    ret

Func_00F_7CFB::
    ld a, [$C923]
    rst $00
    dw Jump_00F_7D3C
    dw Jump_00F_7D31
    dw Jump_00F_7D1C
    dw Jump_00F_7D07

Jump_00F_7D07::
    ld hl, $CBBA
    dec [hl]
    ld hl, $CBBB
    inc [hl]
    ld de, $CBBB
    call Func_00F_7EE9
    ret nc
    ld a, $80
    ld [$C919], a
    ret

Jump_00F_7D1C::
    ld a, [$CBBB]
    inc a
    inc a
    ld [$CBBB], a
    cp a, $30
    ret nz
    ld a, $03
    ld [$CBB6], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_7D31::
    ld b, $5A
    call Func_00F_7EB2
    ret nc
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_7D3C::
    ld a, $1D
    ldh [$FF90], a
    ld a, $01
    ldh [$FF8F], a
    ld a, $00
    ldh [$FF92], a
    ld a, $50
    ld [$C8C8], a
    ld a, $40
    ld [$C8C9], a
    ld a, $02
    ld [$C8C6], a
    ld hl, Func_05F_6C5A
    ld b, $5F
    rst $10
    ld a, $01
    ldh [$FF8B], a
    ret

Func_00F_7D62::
    ld a, [$C923]
    rst $00
    dw Jump_00F_7D86
    dw Jump_00F_7D6C
    dw Jump_00F_7F93

Jump_00F_7D6C::
    ld hl, $C923
    inc [hl]
    ld de, $0000
    call Func_000_181B
    jr c, Jump_00F_7D7F
    ld hl, $0021
    call Func_00F_7F68
    ret

Jump_00F_7D7F::
    ld hl, $001F
    call Func_00F_7F68
    ret

Jump_00F_7D86::
    ldh a, [$FF98]
    ld [$C8EF], a
    ld de, $C8F1
    call Func_00F_7EE9
    ret nc
    ld hl, $C923
    inc [hl]
    ret

Func_00F_7D97::
    ld a, [$C923]
    rst $00
    dw Jump_00F_7DF6
    dw Jump_00F_7DCF
    dw Jump_00F_7DB9
    dw Jump_00F_7DA3

Jump_00F_7DA3::
    call Func_00F_7E1E
    ld de, $CB8B
    call Func_00F_7EE9
    ret nc
    ld hl, $FF8C
    call Func_00F_7ED3
    ld a, $80
    ld [$C919], a
    ret

Jump_00F_7DB9::
    call Func_00F_7E1E
    ld a, [$C924]
    inc a
    ld [$C924], a
    cp a, $20
    ret nz
    xor a, a
    ld [$C924], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_7DCF::
    call Func_00F_7E1E
    ld a, $00
    ld [$C92A], a
    ld a, $00
    ld [$C929], a
    ld a, $50
    ld [$C928], a
    ld hl, Func_05F_6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld a, $01
    ld [$CB86], a
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_7DF6::
    call Func_00F_7E1E
    ld a, [$C924]
    ld l, a
    ld a, [$C925]
    ld h, a
    inc hl
    ld a, l
    ld [$C924], a
    ld a, h
    ld [$C925], a
    ld a, h
    cp a, $01
    ret nz
    ld a, l
    cp a, $40
    ret nz
    xor a, a
    ld [$C924], a
    ld [$C925], a
    ld hl, $C923
    inc [hl]
    ret

Func_00F_7E1E::
    ld a, [$C922]
    or a, a
    jr nz, Jump_00F_7E37
    ld a, $40
    ld [$C928], a
    ld hl, Func_05F_6B17
    ld b, $5F
    rst $10
    ld hl, Func_05F_6B17
    ld b, $5F
    rst $10
    jr Jump_00F_7EA0

Jump_00F_7E37::
    dec a
    jr nz, Jump_00F_7E4D
    ld a, $80
    ld [$C928], a
    ld hl, Func_05F_6A94
    ld b, $5F
    rst $10
    ld hl, Func_05F_6A94
    ld b, $5F
    rst $10
    jr Jump_00F_7EA0

Jump_00F_7E4D::
    dec a
    jr nz, Jump_00F_7E63
    ld a, $80
    ld [$C928], a
    ld hl, Func_05F_6ABF
    ld b, $5F
    rst $10
    ld hl, Func_05F_6ABF
    ld b, $5F
    rst $10
    jr Jump_00F_7EA0

Jump_00F_7E63::
    dec a
    jr nz, Jump_00F_7E79
    ld a, $60
    ld [$C928], a
    ld hl, Func_05F_6AEB
    ld b, $5F
    rst $10
    ld hl, Func_05F_6AEB
    ld b, $5F
    rst $10
    jr Jump_00F_7EA0

Jump_00F_7E79::
    dec a
    jr nz, Jump_00F_7E8F
    ld a, $70
    ld [$C928], a
    ld hl, Func_05F_6B17
    ld b, $5F
    rst $10
    ld hl, Func_05F_6B17
    ld b, $5F
    rst $10
    jr Jump_00F_7EA0

Jump_00F_7E8F::
    ld a, $50
    ld [$C928], a
    ld hl, Func_05F_6AEB
    ld b, $5F
    rst $10
    ld hl, Func_05F_6AEB
    ld b, $5F
    rst $10

Jump_00F_7EA0::
    ld a, [$C92C]
    or a, a
    ret z
    ld a, [$C922]
    inc a
    cp a, $06
    jr nz, Jump_00F_7EAE
    xor a, a

Jump_00F_7EAE::
    ld [$C922], a
    ret

Func_00F_7EB2::
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, b
    jr z, Jump_00F_7EBE
    sub a, a
    ret

Jump_00F_7EBE::
    xor a, a
    ld [$C921], a
    scf
    ret

Func_00F_7EC4:: ; heuristic: follows a terminator; C0
    ld a, [hl]
    or a, $02
    ld [hl], a
    ret

Func_00F_7EC9:: ; heuristic: follows a terminator; C0
    ld a, [hl]
    and a, $FD
    ld [hl], a
    ret

Func_00F_7ECE:: ; heuristic: follows a terminator; C0
    ld a, [hl]
    or a, $04
    ld [hl], a
    ret

Func_00F_7ED3::
    ld a, [hl]
    and a, $FB
    ld [hl], a
    ret

Func_00F_7ED8:: ; heuristic: follows a terminator; C0
    and a, $0F
    jr nz, Jump_00F_7EE2
    ld hl, Func_002_5923
    ld b, $02
    rst $10

Jump_00F_7EE2::
    ld hl, Func_002_5946
    ld b, $02
    rst $10
    ret

Func_00F_7EE9::
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, Func_05F_6BCD
    ld b, $5F
    rst $10
    ld a, [$C921]
    inc a
    inc a
    ld [$C921], a
    cp a, $20
    jr z, Jump_00F_7F05
    sub a, a
    ret

Jump_00F_7F05::
    xor a, a
    ld [$C921], a
    scf
    ret

Func_00F_7F0B:: ; heuristic: follows a terminator; C0
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, Func_05F_6BCD
    ld b, $5F
    rst $10
    ld b, $20
    call Func_00F_7EB2
    ret nc
    ld hl, $C923
    inc [hl]
    ret

Func_00F_7F24:: ; heuristic: follows a terminator; C0
    push hl
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, Func_05F_6BCD
    ld b, $5F
    rst $10
    ld b, $20
    call Func_00F_7EB2
    pop hl
    ret nc
    call Func_00F_7F68
    ld hl, $C923
    inc [hl]
    ret

Func_00F_7F42:: ; heuristic: follows a terminator; C0
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, Func_05F_6BCD
    ld b, $5F
    rst $10
    ld b, $20
    call Func_00F_7EB2
    ret nc
    ld a, $80
    ld [$C919], a
    ret

Func_00F_7F5C:: ; heuristic: follows a terminator; C0
    ld a, [$C921]
    and a, $1F
    ret nz
    ld a, [de]
    inc a
    and a, $03
    ld [de], a
    ret

Func_00F_7F68::
    ld a, l
    ld [$C924], a
    ld a, h
    ld [$C925], a
    xor a, a
    ld [$C926], a
    ret

Func_00F_7F75::
    ld [$C928], a
    ld hl, Func_05F_6936
    ld b, $5F
    rst $10
    ld a, [$C926]
    cp a, $FF
    jr z, Jump_00F_7F87
    sub a, a
    ret

Jump_00F_7F87::
    scf
    ret

Jump_00F_7F89::
    xor a, a
    call Func_00F_7F75
    ret nc
    ld hl, $C923
    inc [hl]
    ret

Jump_00F_7F93::
    xor a, a
    call Func_00F_7F75
    ret nc
    ld a, $80
    ld [$C919], a
    ret
    ds $62, $00
