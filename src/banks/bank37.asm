SECTION "Bank 37", ROMX[$4000], BANK[$37]
    db $37

Func_037_4001::
    ld de, Data_037_4016
    call Func_000_25C9
    ret
    db $11, $16

Data_037_400A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $40, $CD, $FE, $25, $C9, $CD, $01, $40, $CD, $11, $26, $C9

Data_037_4016:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $1A, $40, $86, $40, $C6, $40, $D9, $40, $F1, $40, $08, $41, $20, $41, $39, $41
    db $50, $41, $66, $41, $77

Data_037_402B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $41, $90, $41, $AC, $41, $CA, $41, $DC, $41, $E9, $41, $00, $42, $18, $42, $30
    db $42, $45, $42, $5A, $42, $6F, $42, $84, $42, $98, $42, $CE, $42, $27, $43, $3E
    db $43, $54, $43, $65, $43, $79, $43, $BA, $43, $EF, $43, $2A, $44, $67, $44, $AB
    db $44, $CD, $44, $E3, $44, $06, $45, $27, $45, $3C, $45, $59, $45, $7B

Data_037_4069:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0DC069, $91

Data_037_40FA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0DC0FA, $80D
    ds $10, $A4
    db $F1
    ds $10, $A4
    INCBIN "dwm2-cobi-us.gbc", $0DC928, $A7

Data_037_49CF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2C, $27, $90, $31, $32, $37, $90, $26, $32, $30, $28, $F1, $25, $24, $26, $2E
    db $90, $37, $32, $90, $2F, $2C, $29, $28, $A4, $F7, $F0, $0B, $38, $37, $90, $2C
    db $37, $90, $26, $32, $38, $2F, $27, $31, $41, $90, $25, $28, $F1, $38, $36, $28
    db $27, $90, $2B, $28, $35, $28, $B5, $F7, $F0, $0B, $38, $37

Data_037_4A0B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0DCA0B, $F2

Func_037_4AFD::
    ld a, [$C56C]
    and a, a
    ret nz
    ld a, [$D780]
    rst $00
    dw Jump_037_4B2A
    dw Jump_037_4B38
    dw Jump_037_4B7A
    dw Jump_037_4B8B
    dw Jump_037_4BEB
    dw Jump_037_4B5B
    dw Jump_037_4B6A
    dw Jump_037_4B38
    dw Jump_037_4B38
    dw Jump_037_4B38
    dw Jump_037_4B38
    dw Jump_037_4B38
    dw Jump_037_5301
    dw Jump_037_53C0
    dw Jump_037_57D0
    dw Jump_037_4B38
    dw Jump_037_4B38
    dw Jump_037_531D

Jump_037_4B2A::
    ld hl, Data_037_4069
    ld b, $1E
    rst $10
    ld a, [$D780]
    inc a
    ld [$D780], a
    ret

Jump_037_4B38::
    ld a, [$C52B]
    bit 0, a
    ret nz
    ld hl, $D780
    ld bc, $006F

Jump_037_4B44::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_037_4B44
    ld a, $05
    ld [$C5DB], a
    ld a, $01
    ld [$C5DC], a
    ld a, $01
    ld [$C5DF], a
    ret

Jump_037_4B5B::
    ld a, [$C52B]
    or a, a
    ret nz
    ld a, $03
    ld [$C594], a
    ld hl, $D780
    inc [hl]
    ret

Jump_037_4B6A::
    ld a, [$C58F]
    cp a, $03
    ret nz
    xor a, a
    ld [$C594], a
    ld a, $01
    ld [$D780], a
    ret

Jump_037_4B7A::
    ld a, [$D780]
    inc a
    ld [$D780], a
    ld a, $02
    ld [$C594], a
    ld hl, $D06A
    inc [hl]
    ret

Jump_037_4B8B::
    ld a, [$D781]
    rst $00
    dw Jump_037_4B97
    dw Jump_037_4BA4
    dw Jump_037_4BC9
    dw Jump_037_4BDA

Jump_037_4B97::
    ld a, [$C52B]
    and a, a
    ret nz
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_037_4BA4::
    ld a, [$C52B]
    and a, a
    ret nz
    ld a, [$C58F]
    or a, a
    jr z, Jump_037_4BC1
    cp a, $02
    ret nz
    ld a, $05
    ld [$D780], a
    xor a, a
    ld [$D781], a
    ld a, $15
    call Func_037_5999
    ret

Jump_037_4BC1::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_037_4BC9::
    xor a, a
    ld [$C594], a
    ld a, $09
    call Func_037_5999
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_037_4BDA::
    ld a, [$C52B]
    and a, a
    ret nz
    xor a, a
    ld [$D781], a
    ld a, [$D780]
    inc a
    ld [$D780], a
    ret

Jump_037_4BEB::
    ld a, [$D781]
    rst $00
    dw Jump_037_4C9D
    dw Jump_037_4C9D
    dw Jump_037_4C9D
    dw Jump_037_4C9D
    dw Jump_037_4D80
    dw Jump_037_4C9D
    dw Jump_037_4C9D
    dw Jump_037_4C9D
    dw Jump_037_4C5B
    dw Jump_037_523F
    dw Jump_037_525F
    dw Jump_037_526F
    dw Jump_037_4D43
    dw Jump_037_4C9D
    dw Jump_037_4C33
    dw Jump_037_4DC2
    dw Jump_037_4CA9
    dw Jump_037_4DE9
    dw Jump_037_4E75
    dw Jump_037_4EB6
    dw Jump_037_4EF9
    dw Jump_037_4F49
    dw Jump_037_4F5E
    dw Jump_037_4FFD
    dw Jump_037_5041
    dw Jump_037_50D9
    dw Jump_037_5136
    dw Jump_037_4EB6
    dw Jump_037_5216
    dw Jump_037_4FD5
    dw Func_037_5172
    dw Jump_037_4EC8
    dw Jump_037_52EA
    dw Jump_037_524E

Jump_037_4C33::
    ld a, [$C52B]
    and a, a
    ret nz
    ld a, [$C58F]
    cp a, $FD
    jr nz, Jump_037_4C54
    ld a, $09
    ld [$D781], a
    ld a, $14
    call Func_037_5999
    ld a, $FD
    ld [$C594], a
    ld a, $01
    ld [$D2CC], a
    ret

Jump_037_4C54::
    ld hl, Data_037_40FA
    ld b, $15
    rst $10
    ret

Jump_037_4C5B::
    ld a, [$C52B]
    and a, a
    ret nz
    ld a, [$C58F]
    cp a, $FD
    jr nz, Jump_037_4C7C
    ld a, $09
    ld [$D781], a
    ld a, $14
    call Func_037_5999
    ld a, $FD
    ld [$C594], a
    ld a, $01
    ld [$D2CC], a
    ret

Jump_037_4C7C::
    ld hl, Data_037_40FA
    ld b, $15
    rst $10
    ld a, [$D7F9]
    cp a, $FE
    ret nz
    ld a, $09
    ld [$D781], a
    ld a, $13
    call Func_037_5999
    ld a, $FD
    ld [$C594], a
    ld a, $00
    ld [$D2CC], a
    ret

Jump_037_4C9D::
    ld a, [$C52B]
    and a, a
    ret nz
    ld hl, Data_037_40FA
    ld b, $15
    rst $10
    ret

Jump_037_4CA9::
    ld a, [$D7B4]
    cp a, $FF
    jr z, Jump_037_4CC1
    ld a, [$C52B]
    and a, a
    ret nz
    ld hl, Data_037_40FA
    ld b, $15
    rst $10
    ld a, $09
    call Func_037_5999
    ret

Jump_037_4CC1::
    ld a, [$D782]
    rst $00
    dw Jump_037_4CDB
    dw Jump_037_4CF1
    dw Jump_037_4D03
    dw Jump_037_4D1A
    dw Jump_037_4CDB
    dw Jump_037_4CF1
    dw Jump_037_4D03
    dw Jump_037_4D1A
    dw Jump_037_4CDB
    dw Jump_037_4D2D
    dw Jump_037_4D1A

Jump_037_4CDB::
    ld a, [$C52B]
    and a, a
    ret nz
    xor a, a
    ld [$C594], a
    ld a, [$D782]
    inc a
    ld [$D782], a
    ld a, $07
    call Func_037_5999
    ret

Jump_037_4CF1::
    ld a, [$C52B]
    and a, a
    ret nz
    ld a, [$D782]
    inc a
    ld [$D782], a
    ld a, $01
    ld [$C594], a
    ret

Jump_037_4D03::
    ld a, [$C58F]
    cp a, $01
    ret nz
    xor a, a
    ld [$C594], a
    ld a, $09
    call Func_037_5999
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_037_4D1A::
    ld a, [$C52B]
    and a, a
    ret nz
    ld hl, Data_037_40FA
    ld b, $15
    rst $10
    xor a, a
    ld [$D7B4], a
    ld [$D782], a
    ret

Jump_037_4D2D::
    ld a, [$C52B]
    or a, a
    ret nz
    xor a, a
    ld [$C594], a
    ld a, $09
    call Func_037_5999
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_037_4D43::
    ld a, [$C52B]
    and a, a
    ret nz
    ld a, [$D782]
    and a, a
    jr nz, Jump_037_4D5B
    ld a, $04
    call Func_037_5999
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_037_4D5B::
    ld hl, Data_01F_40FA
    ld b, $15
    rst $10
    ld de, Data_01F_4510
    ld hl, $8EE0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4450
    ld hl, $8EF0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    xor a, a
    ld [$D782], a
    ret

Jump_037_4D80::
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
    ld a, $C7
    ld [$D7F1], a
    call Func_037_5AD3
    ld de, Data_037_647D
    ld hl, $C36C
    ld bc, $0C05
    call Func_037_5AFA
    pop af
    ld [$D7F1], a
    ld hl, $C386
    ld a, l
    ld [$D7F2], a
    ld a, h
    ld [$D7F3], a
    ld hl, Data_037_688D
    ld b, $15
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_037_4DC2::
    ld a, [$C52B]
    and a, a
    ret nz

Func_037_4DC7::
    ld b, $00
    ld c, $05
    ld hl, $0278
    ld de, $00AC
    xor a, a
    ld [$D7F1], a
    ld a, $08
    ld [$D7F2], a
    call Func_037_5A5D
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$D7B4], a
    ret

Jump_037_4DE9::
    ld a, [$C52B]
    and a, a
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
    push hl
    ld a, [hl]
    ld c, $56
    call Func_000_1F80
    ldh a, [$FFC6]
    cp a, $0A
    jr nc, Jump_037_4E25
    pop hl
    xor a, a
    ld [$1FFF], a
    ld a, [$D781]
    dec a
    dec a
    ld [$D781], a
    ld a, $05
    call Func_037_5999
    ret

Jump_037_4E25::
    pop hl
    ld a, [hl]
    ld c, a
    ld a, [$C6FD]
    ld b, a
    ld de, $C6FE

Jump_037_4E2F::
    ld a, [de]
    cp a, c
    jr z, Jump_037_4E39
    inc de
    dec b
    jr nz, Jump_037_4E2F
    jr Jump_037_4E4B

Jump_037_4E39::
    xor a, a
    ld [$1FFF], a
    ld a, [$D781]
    dec a
    dec a
    ld [$D781], a
    ld a, $06
    call Func_037_5999
    ret

Jump_037_4E4B::
    ld hl, $5D84
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld a, [hl]
    ld [$D7B4], a
    ld a, [$D7AB]
    ld [$D7B5], a
    ld a, [$D7AF]
    ld [$D7B6], a
    xor a, a
    ld [$1FFF], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_037_4E75::
    ld a, [$C52B]
    and a, a
    ret nz
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld a, [$D7B4]
    ld c, $A5
    call Func_000_1682
    ld de, $A000
    add hl, de
    ld de, $C986
    ld b, $A5

Jump_037_4E94::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_037_4E94
    xor a, a
    ld [$1FFF], a
    call Func_037_5BC6
    ld a, $07
    call Func_037_5999
    call Func_037_4DC7
    call Func_037_5B95
    ld bc, $140D
    ld de, $01CC
    call Func_037_5B3F
    ret

Jump_037_4EB6::
    ld a, [$C52B]
    and a, a
    ret nz
    ld a, [$D781]
    inc a
    ld [$D781], a
    ld a, $01
    ld [$C594], a
    ret

Jump_037_4EC8::
    ld a, $64
    ld [$C592], a
    xor a, a
    ld [$C593], a
    ld hl, $D09D
    ld a, l
    ld [$C595], a
    ld a, h
    ld [$C596], a
    ld hl, $D09D
    ld a, l
    ld [$C590], a
    ld a, h
    ld [$C591], a
    ld a, $FF
    ld [$C594], a
    ld a, $01
    ld [$C58C], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_037_4EF9::
    ld a, [$C58F]
    cp a, $01
    jr z, Jump_037_4F18
    cp a, $FD
    ret nz
    ld a, $09
    ld [$D781], a
    ld a, $14
    call Func_037_5999
    ld a, $FD
    ld [$C594], a
    ld a, $01
    ld [$D2CC], a
    ret

Jump_037_4F18::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ld a, $95
    ld [$C592], a
    xor a, a
    ld [$C593], a
    ld hl, $D09D
    ld a, l
    ld [$C595], a
    ld a, h
    ld [$C596], a
    ld hl, $D132
    ld a, l
    ld [$C590], a
    ld a, h
    ld [$C591], a
    ld a, $FF
    ld [$C594], a
    ld a, $01
    ld [$C58C], a
    ret

Jump_037_4F49::
    ld a, [$C58F]
    cp a, $F0
    ret nz
    xor a, a
    ld [$C58C], a
    call Func_037_5C4E
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_037_4F5E::
    ld a, [$C52B]
    and a, a
    ret nz
    ld hl, $C994
    ld a, [$C994]
    and a, $01
    ld b, a
    ld a, [$CA39]
    and a, $01
    cp a, b
    jr nz, Jump_037_4F89
    ld a, $08
    call Func_037_5999
    ld a, $10
    ld [$D781], a
    ld a, $08
    ld [$D782], a
    ld a, $FF
    ld [$D7B4], a
    ret

Jump_037_4F89::
    xor a, a
    ld [$C594], a
    ld a, $0F
    ld [$C529], a
    xor a, a
    ld [$C528], a
    ld hl, $9600
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0D01
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld hl, $537E
    ld b, $0E
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
    ld a, $0B
    call Func_037_5999
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_037_4FD5::
    ld a, [$C57F]
    bit 1, a
    jr nz, Jump_037_4FE7
    ld a, $02
    ld [$D7F1], a
    ld hl, $5688
    ld b, $0E
    rst $10

Jump_037_4FE7::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ld b, a

Jump_037_4FEF::
    push bc
    call Func_037_5172
    pop bc
    ld a, [$D781]
    cp a, b
    jr z, Jump_037_4FEF
    jp Jump_037_4EC8

Jump_037_4FFD::
    ld a, [$C52B]
    and a, a
    ret nz
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
    ld [$D7FA], a
    ld a, $6C
    call Func_000_1278
    ld de, Data_037_64D7
    ld hl, $C3E7
    ld bc, $0907
    call Func_037_5AFA
    call Func_037_5B95
    ld bc, $140D
    ld de, $01CC
    call Func_037_5B3F
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_037_5041::
    ld a, [$C52B]
    and a, a
    ret nz
    ld a, [$C58F]
    cp a, $FE
    jr nz, Jump_037_5065
    call Func_037_5976
    ld a, $21
    ld [$D781], a
    ld a, $14
    call Func_037_5999
    ld a, $FE
    ld [$C594], a
    ld a, $01
    ld [$D2CC], a
    ret

Jump_037_5065::
    call Func_037_59A3
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_037_5073
    cp a, $FF
    jr z, Jump_037_508B
    ret

Jump_037_5073::
    call Func_037_5976
    ld a, $21
    ld [$D781], a
    ld a, $13
    call Func_037_5999
    ld a, $FE
    ld [$C594], a
    ld a, $00
    ld [$D2CC], a
    ret

Jump_037_508B::
    ld a, [$D7FA]
    cp a, $02
    jr z, Jump_037_5073
    cp a, $01
    jr z, Jump_037_50AE
    ld a, [$D7FA]
    ld b, $BC
    ld hl, Data_037_6516
    call Func_037_5BB6
    ld a, [$D781]
    inc a
    ld [$D781], a
    ld a, $0C
    call Func_037_5999
    ret

Jump_037_50AE::
    ld a, [$D780]
    ld [$D7B2], a
    ld a, [$D781]
    ld [$D7B3], a
    ld a, [$D7AB]
    ld [$D7B5], a
    ld a, [$D7AF]
    ld [$D7B6], a
    xor a, a
    ld [$D781], a
    ld [$D782], a
    ld [$D7AB], a
    ld [$D7AF], a
    ld a, $0D
    ld [$D780], a
    ret

Jump_037_50D9::
    ld a, [$C52B]
    and a, a
    ret nz
    ld de, Data_01F_4230
    ld hl, $9700
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4290
    ld hl, $9710
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4370
    ld hl, $9720
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4180
    ld hl, $9760
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    xor a, a
    ld [$D7FA], a
    ld de, Data_037_64B9
    ld hl, $C412
    ld bc, $0605
    call Func_037_5AFA
    call Func_037_5B95
    ld bc, $140D
    ld de, $01CC
    call Func_037_5B3F
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_037_5136::
    ld a, [$C52B]
    and a, a
    ret nz
    ld hl, Data_037_6540
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_037_514F
    cp a, $FF
    jr z, Jump_037_515A
    ret

Jump_037_514F::
    ld a, $0B
    call Func_037_5999
    ld a, $17
    ld [$D781], a
    ret

Jump_037_515A::
    ld a, [$D7FA]
    cp a, $01
    jr z, Jump_037_514F
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$D782], a
    ld a, $07
    call Func_037_5999
    ret

Func_037_5172::
    ld a, [$C52B]
    and a, a
    ret nz
    ld a, [$D782]
    and a, a
    jr z, Jump_037_5189
    xor a, a
    ld [$D782], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_037_5189::
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_037_5198
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_037_5198::
    ld a, [$D7B5]
    ld [$D7AB], a
    ld a, [$D7B6]
    ld [$D7AF], a
    ld hl, $5D84
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld a, [hl]
    ld [$D7F1], a
    ld a, $01
    ld [$D7F2], a
    ld hl, Data_037_7E96
    ld b, $14
    rst $10
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld a, [$D7F6]
    ld l, a
    ld a, [$D7F7]
    ld h, a
    ld de, $CAD0
    ld b, $A5

Jump_037_51D7::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_037_51D7
    xor a, a
    ld [$1FFF], a
    xor a, a
    ld [$C8C3], a
    ld [$C8C4], a
    ld hl, $CADB
    ld a, [hl+]
    ld [$D7F1], a
    ld a, [hl]
    ld [$D7F2], a
    ld de, $C7FC
    ld a, e
    ld [$D7F3], a
    ld a, d
    ld [$D7F4], a
    ld hl, Data_037_68F3
    ld b, $15
    rst $10
    ld hl, $D7E0
    ld b, $07

Jump_037_5209::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_037_5209
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_037_5216::
    ld a, [$C58F]
    cp a, $01
    jr z, Jump_037_5235
    cp a, $FE
    ret nz
    ld a, $21
    ld [$D781], a
    ld a, $14
    call Func_037_5999
    ld a, $FE
    ld [$C594], a
    ld a, $01
    ld [$D2CC], a
    ret

Jump_037_5235::
    ld a, [$D781]
    inc a
    ld [$D781], a
    jp Jump_037_4FD5

Jump_037_523F::
    ld a, [$C58F]
    cp a, $FD
    ret nz
    ld a, [$D781]
    inc a
    ld [$D781], a
    jr Jump_037_525F

Jump_037_524E::
    ld a, [$C58F]
    cp a, $FE
    ret nz
    xor a, a
    ld [$C594], a
    ld a, $0A
    ld [$D781], a
    jr Jump_037_525F

Jump_037_525F::
    ld a, [$C52B]
    and a, a
    ret nz
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$D782], a

Jump_037_526F::
    ld a, [$D782]
    rst $00
    dw Jump_037_5277
    dw Jump_037_52BF

Jump_037_5277::
    ld a, [$C52B]
    and a, a
    ret nz
    ld a, [$D782]
    inc a
    ld [$D782], a
    ld b, $64
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_037_5296
    ld b, $48
    ld a, [$D2CC]
    or a, a
    jr z, Jump_037_5296
    ld b, $45

Jump_037_5296::
    ld a, b
    ld [$C592], a
    xor a, a
    ld [$C593], a
    ld hl, $D09D
    ld a, l
    ld [$C595], a
    ld a, h
    ld [$C596], a
    ld hl, $D09D
    ld a, l
    ld [$C590], a
    ld a, h
    ld [$C591], a
    ld a, $FF
    ld [$C594], a
    ld a, $01
    ld [$C58C], a
    ret

Jump_037_52BF::
    ld a, [$C58F]
    cp a, $F0
    ret nz
    xor a, a
    ld [$C58C], a
    ld hl, $D780
    ld bc, $006F

Jump_037_52CF::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_037_52CF
    ld a, $05
    ld [$C5DB], a
    ld a, $01
    ld [$C5DC], a
    ld a, $01
    ld [$C5DF], a
    xor a, a
    ld [$C594], a
    ret

Jump_037_52EA::
    ld a, [$C58F]
    cp a, $F0
    jr z, Jump_037_52F2
    ret

Jump_037_52F2::
    xor a, a
    ld [$C594], a
    ld a, $01
    ld [$C94B], a
    ld a, $01
    ld [$D7EB], a
    ret

Jump_037_5301::
    ld hl, Data_037_4069
    ld b, $1E
    rst $10
    ld a, [$D781]
    cp a, $0A
    ret nz
    xor a, a
    ld [$D781], a
    ld [$D782], a
    ld a, [$D780]
    add a, $05
    ld [$D780], a
    ret

Jump_037_531D::
    ld a, [$D781]
    rst $00
    dw Jump_037_533C
    dw Func_037_5344
    dw Jump_037_5335
    dw Jump_037_5335
    dw Jump_037_5335
    dw Jump_037_4D80
    dw Jump_037_5352
    dw Jump_037_539F
    dw Jump_037_5335
    dw Jump_037_5335

Jump_037_5335::
    ld hl, Data_037_40FA
    ld b, $15
    rst $10
    ret

Jump_037_533C::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_037_5344::
    ld hl, Data_037_4A0B
    ld b, $F2
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_037_5352::
    ld hl, $8A70
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0901
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
    ld hl, $0501
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
    ld hl, $D781
    inc [hl]
    ret

Jump_037_539F::
    ld hl, $5D84
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
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

Jump_037_53C0::
    ld a, [$D781]
    rst $00
    dw Jump_037_5407
    dw Jump_037_5415
    dw Jump_037_5424
    dw Jump_037_5452
    dw Jump_037_5471
    dw Jump_037_547F
    dw Jump_037_5486
    dw Jump_037_54D1
    dw Jump_037_5406
    dw Jump_037_5406
    dw Jump_037_5406
    dw Jump_037_5406
    dw Jump_037_5406
    dw Jump_037_5406
    dw Jump_037_550A
    dw Jump_037_552B
    dw Jump_037_5565
    dw Jump_037_5570
    dw Jump_037_5593
    dw Jump_037_55A0
    dw Jump_037_55C6
    dw Jump_037_5611
    dw Jump_037_564E
    dw Jump_037_565A
    dw Jump_037_5668
    dw Jump_037_5676
    dw Jump_037_5683
    dw Jump_037_5691
    dw Jump_037_56F3
    dw Jump_037_5715
    dw Jump_037_5760
    dw Jump_037_5789
    dw Jump_037_579B

Jump_037_5406::
    ret

Jump_037_5407::
    ld hl, Data_037_7494
    ld b, $1F
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_037_5415::
    ld hl, Data_037_49CF
    ld b, $F2
    rst $10
    ld hl, Data_037_7375
    ld b, $1F
    rst $10
    call Func_037_542C

Jump_037_5424::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_037_542C::
    ld hl, $8D00
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
    ld hl, $CA2C
    call Func_037_5912
    ld de, $8D00
    call Func_000_21A1
    ret

Jump_037_5452::
    call Func_037_5B95
    ld de, Data_037_687F
    ld a, $14
    ld [$D7F3], a
    ld a, $12
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    call Func_037_595F
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_037_5471::
    ld hl, $5002
    ld b, $F2
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_037_547F::
    ld hl, Data_037_73EC
    ld b, $1F
    rst $10
    ret

Jump_037_5486::
    ld a, [$C563]
    res 7, a
    res 6, a
    ld [$C563], a
    xor a, a
    ld [$D7F9], a
    ld hl, Data_037_66B6
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_037_54A8
    cp a, $FF
    jr z, Jump_037_54B0
    ret

Jump_037_54A8::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_037_54B0::
    call Func_037_5B95
    ld de, $0161
    add hl, de
    ld de, Data_037_651B
    ld a, $06
    ld [$D7F3], a
    ld a, $06
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    call Func_037_595F
    ld a, $0E
    ld [$D781], a
    ret

Jump_037_54D1::
    call Func_037_5B95
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
    ld [$D781], a
    ld [$D782], a
    ld a, [$D780]
    inc a
    ld [$D780], a
    ret

Jump_037_550A::
    ld hl, $9200
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0F02
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    call Func_000_290E
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_037_552B::
    ld hl, $8A70
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0901
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
    ld hl, $0501
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    call Func_000_290E
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_037_5565::
    call Func_037_5929
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_037_5570::
    call Func_037_5B95
    ld de, $0068
    add hl, de
    ld de, Data_037_6577
    ld a, $0C
    ld [$D7F3], a
    ld a, $0F
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    call Func_037_595F
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_037_5593::
    ld hl, $4AFE
    ld b, $F2
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a

Jump_037_55A0::
    ld a, $6D
    ld [$D7F1], a
    xor a, a
    ld [$D7F2], a
    ld a, $EA
    ld [$D7F3], a
    ld a, $C7
    ld [$D7F4], a
    ld hl, $50E2
    ld b, $F2
    rst $10
    ld hl, $4B05
    ld b, $F2
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a

Jump_037_55C6::
    ld a, [$CA36]
    ld [$D7F1], a
    ld a, [$CA37]
    ld [$D7F2], a
    xor a, a
    ld [$D7F3], a
    ld [$D7F4], a
    ld a, $80
    ld [$D7F5], a
    ld hl, Data_037_6973
    ld b, $1D
    rst $10
    ld a, $F0
    ldh [$FFBA], a
    ld hl, $4BD0
    ld b, $F2
    rst $10
    call Func_037_5B95
    ld de, $0160
    add hl, de
    ld de, Data_037_66DF
    ld a, $08
    ld [$D7F3], a
    ld a, $07
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    call Func_037_595F
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_037_5611::
    ld a, [$C563]
    res 7, a
    res 6, a
    ld [$C563], a
    xor a, a
    ld [$D7F9], a
    ld hl, Data_037_66B6
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_037_563F
    cp a, $FF
    jr z, Jump_037_5633
    ret

Jump_037_5633::
    xor a, a
    ldh [$FFBA], a
    ld a, [$D781]
    inc a
    inc a
    ld [$D781], a
    ret

Jump_037_563F::
    xor a, a
    ldh [$FFBA], a
    ld hl, Data_037_74E3
    ld b, $1F
    rst $10
    ld a, $04
    ld [$D781], a
    ret

Jump_037_564E::
    ld hl, $4F47
    ld b, $F2
    rst $10
    ld a, $0F
    ld [$D781], a
    ret

Jump_037_565A::
    ld hl, Data_037_753A
    ld b, $1F
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_037_5668::
    ld hl, Data_037_7591
    ld b, $1F
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_037_5676::
    ld hl, Data_037_7601
    ld b, $1F
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a

Jump_037_5683::
    ld hl, $4BFC
    ld b, $F2
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_037_5691::
    ld a, [$C563]
    res 7, a
    res 6, a
    ld [$C563], a
    xor a, a
    ld [$D7F9], a
    ld hl, Data_037_66B6
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_037_56B3
    cp a, $FF
    jr z, Jump_037_56D4
    ret

Jump_037_56B3::
    ld hl, $9200
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $1504
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    call Func_000_290E
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_037_56D4::
    ld hl, $9730
    ld de, Data_01F_42D0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    call Func_037_5895
    ld hl, Data_037_76B5
    ld b, $1F
    rst $10
    ld a, [$D781]
    add a, $03
    ld [$D781], a
    ret

Jump_037_56F3::
    ld a, [$D782]
    and a, a
    jr nz, Jump_037_5707
    ld hl, Data_037_7754
    ld b, $1F
    rst $10
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_037_5707::
    ld hl, Data_037_49CF
    ld b, $F2
    rst $10
    call Func_037_5344
    xor a, a
    ld [$D782], a
    ret

Jump_037_5715::
    ld hl, $4F47
    ld b, $F2
    rst $10
    ld hl, $8A70
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0901
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    call Func_000_290E
    call Func_037_5929
    ld de, Data_01F_4AD0
    ld hl, $96F0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
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
    ld a, $11
    ld [$D781], a
    ret

Jump_037_5760::
    call Func_037_5B95
    ld de, $0008
    add hl, de
    ld de, Data_037_63D7
    ld a, $0C
    ld [$D7F3], a
    ld a, $12
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    call Func_037_595F
    ld hl, $4E76
    ld b, $F2
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_037_5789::
    ld hl, $4C36
    ld b, $F2
    rst $10
    ld a, $F0
    ldh [$FFBA], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_037_579B::
    ld a, [$C563]
    res 7, a
    res 6, a
    ld [$C563], a
    xor a, a
    ld [$D7F9], a
    ld hl, Data_037_66B6
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    jr z, Jump_037_57BD
    cp a, $FE
    jr z, Jump_037_57BE
    cp a, $FF
    jr z, Jump_037_57C7

Jump_037_57BD::
    ret

Jump_037_57BE::
    xor a, a
    ldh [$FFBA], a
    ld a, $17
    ld [$D781], a
    ret

Jump_037_57C7::
    xor a, a
    ldh [$FFBA], a
    ld a, $07
    ld [$D781], a
    ret

Jump_037_57D0::
    ld a, [$D781]
    rst $00
    dw Jump_037_57E8
    dw Func_037_5344
    dw Jump_037_580D
    dw Jump_037_580D
    dw Jump_037_580D
    dw Jump_037_4D80
    dw Jump_037_5352
    dw Jump_037_539F
    dw Jump_037_5821
    dw Jump_037_57FC

Jump_037_57E8::
    ld a, [$D7B5]
    ld [$D7AB], a
    ld a, [$D7B6]
    ld [$D7AF], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_037_57FC::
    ld a, [$D780]
    push af
    ld a, $11
    ld [$D780], a
    ld hl, Data_037_40FA
    ld b, $15
    rst $10
    pop af
    ret

Jump_037_580D::
    ld a, [$D780]
    push af
    ld a, $11
    ld [$D780], a
    ld hl, Data_037_40FA
    ld b, $15
    rst $10
    pop af
    ld [$D780], a
    ret

Jump_037_5821::
    ld de, Data_037_64D7
    ld hl, $C3E7
    ld bc, $0907
    call Func_037_5AFA
    ld a, $0F
    ld [$C529], a
    xor a, a
    ld [$C528], a
    ld hl, $9600
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0D01
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld hl, $537E
    ld b, $0E
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
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_037_5870:: ; heuristic: follows a terminator; C0
    ld a, [$CA36]
    ld [$D7F1], a
    ld a, [$CA37]
    ld [$D7F2], a
    xor a, a
    ld [$D7F3], a
    ld a, $90
    ld [$D7F4], a
    ld a, $40
    ld [$D7F5], a
    xor a, a
    ld [$D7F6], a
    ld hl, Data_037_6A3D
    ld b, $1D
    rst $10
    ret

Func_037_5895::
    ld hl, Data_037_58AE
    ld de, $96E0
    call Func_037_58FE
    call Func_037_58FE
    ld de, $97C0
    call Func_037_58FE
    call Func_037_58FE
    call Func_037_58FE
    ret

Data_037_58AE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0DD8AE, $50

Func_037_58FE::
    xor a, a

Jump_037_58FF::
    push af
    di

Jump_037_5901::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_037_5901
    ld a, [hl+]
    ld [de], a
    inc de
    ei
    pop af
    inc a
    cp a, $10
    jr c, Jump_037_58FF
    ret

Func_037_5912::
    ld de, $C8CF
    ld c, $00

Jump_037_5917::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_037_5925
    ld [de], a
    inc hl
    inc de
    inc c
    ld a, c
    cp a, $0A
    jr c, Jump_037_5917

Jump_037_5925::
    ld a, $F0
    ld [de], a
    ret

Func_037_5929::
    ld hl, $CA2C
    call Func_037_5912
    ld de, $8F80
    call Func_000_21A1
    ld hl, $CA36
    ld a, [hl+]
    ld [$C529], a
    ld a, [hl]
    add a, $02
    ld [$C528], a
    ld hl, $8A70
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0901
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld hl, Data_037_402B
    ld b, $08
    rst $10
    ret

Func_037_595F::
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

Func_037_5976::
    ld b, $00
    ld c, $07
    ld hl, $024F
    ld de, $0083
    xor a, a
    ld [$D7F1], a
    ld a, $09
    ld [$D7F2], a
    call Func_037_5A5D
    call Func_037_5B95
    ld bc, $140D
    ld de, $01CC
    call Func_037_5B3F
    ret

Func_037_5999::
    ld [$C529], a
    ld hl, $5370
    ld b, $0E
    rst $10
    ret

Func_037_59A3::
    ld a, [$C563]
    bit 6, a
    jr nz, Jump_037_59C1
    bit 7, a
    jr nz, Jump_037_59D7
    ld a, [$C562]
    bit 0, a
    jr nz, Jump_037_59FD
    bit 1, a
    jr nz, Jump_037_5A0B
    call Func_037_5A11
    xor a, a
    ld [$D7F9], a
    ret

Jump_037_59C1::
    call Func_037_5A2F
    ld a, [$D7FA]
    and a, a
    jr nz, Jump_037_59D1
    ld a, $02
    ld [$D7FA], a
    jr Jump_037_59EB

Jump_037_59D1::
    dec a
    ld [$D7FA], a
    jr Jump_037_59EB

Jump_037_59D7::
    call Func_037_5A2F
    ld a, [$D7FA]
    cp a, $02
    jr c, Jump_037_59E7
    xor a, a
    ld [$D7FA], a
    jr Jump_037_59EB

Jump_037_59E7::
    inc a
    ld [$D7FA], a

Jump_037_59EB::
    xor a, a
    ld [$D783], a
    call Func_037_5A2B
    ld a, $69
    call Func_000_1278
    ld a, $FD
    ld [$D7F9], a
    ret

Jump_037_59FD::
    call Func_037_5A33
    ld a, $69
    call Func_000_1278
    ld a, $FF
    ld [$D7F9], a
    ret

Jump_037_5A0B::
    ld a, $FE
    ld [$D7F9], a
    ret

Func_037_5A11::
    ld a, [$C564]
    cp a, $14
    jr c, Func_037_5A2B
    ld a, [$D783]
    inc a
    ld [$D783], a
    cp a, $10
    jr c, Func_037_5A2B
    cp a, $18
    jr c, Func_037_5A2F
    xor a, a
    ld [$D783], a

Func_037_5A2B::
    ld b, $BB
    jr Jump_037_5A35

Func_037_5A2F::
    ld b, $C3
    jr Jump_037_5A35

Func_037_5A33::
    ld b, $BC

Jump_037_5A35::
    ld a, [$D7FA]
    sla a
    ld hl, Data_037_5A57
    add a, l
    ld l, a
    jr nc, Jump_037_5A42
    inc h

Jump_037_5A42::
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    push de
    call Func_037_5B95
    pop de
    add hl, de
    call Func_000_24F8
    di
    call Func_000_120A
    ld a, b
    ld [hl], a
    ei
    ret

Data_037_5A57:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $EC, $00, $2C, $01, $6C, $01

Func_037_5A5D::
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
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    pop hl
    ld a, [$D7F1]
    ld b, a
    ld a, [$D7F2]
    ld c, a
    call Func_037_5AB7
    pop de
    pop hl
    ld a, [$C525]
    and a, a
    jr z, Jump_037_5AA2
    push hl
    push de
    ld de, $D000
    add hl, de
    pop de
    push de
    push hl
    ld hl, $D000
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    pop hl
    ld a, [$D7F1]
    ld b, a
    ld a, [$D7F2]
    ld c, a
    call Func_037_5AC0
    pop de
    pop hl

Jump_037_5AA2::
    pop bc
    ld a, $14
    add a, l
    ld l, a
    jr nc, Jump_037_5AAA
    inc h

Jump_037_5AAA::
    ld a, $14
    add a, e
    ld e, a
    jr nc, Jump_037_5AB1
    inc d

Jump_037_5AB1::
    inc b
    ld a, b
    cp a, c
    jr c, Func_037_5A5D
    ret

Func_037_5AB7::
    ld a, [de]
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Func_037_5AB7
    ret

Func_037_5AC0::
    ld a, $02
    ldh [$FF70], a

Jump_037_5AC4::
    ld a, [de]
    and a, $07
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_037_5AC4
    ld a, $00
    ldh [$FF70], a
    ret

Func_037_5AD3::
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
    ld a, [$D7F1]
    ld [$D09E], a
    ld hl, Data_037_7A48
    ld b, $16
    rst $10
    xor a, a
    ld [$1FFF], a
    ret

Func_037_5AFA::
    push hl
    push bc

Jump_037_5AFC::
    push hl
    push bc

Jump_037_5AFE::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_037_5AFE
    pop bc
    pop hl
    ld a, l
    add a, $14
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec c
    jp nz, Jump_037_5AFC
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

Jump_037_5B25::
    push hl
    push bc

Jump_037_5B27::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_037_5B27
    pop bc
    pop hl
    ld a, l
    add a, $14
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec c
    jp nz, Jump_037_5B25
    ld a, $00
    ldh [$FF70], a
    ret

Func_037_5B3F::
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
    xor a, a
    call Func_000_160B
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
    xor a, a
    call Func_000_160B
    call Func_000_120A
    ld a, $00
    ldh [$FF70], a
    ld c, $4F
    ld a, $00
    ldh [c], a
    ret

Func_037_5B95::
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
    jr nc, Jump_037_5BB5
    inc h

Jump_037_5BB5::
    ret

Func_037_5BB6::
    push bc
    sla a
    add a, l
    ld l, a
    jr nc, Jump_037_5BBE
    inc h

Jump_037_5BBE::
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    pop bc
    ld a, b
    ld [de], a
    ret

Func_037_5BC6::
    ld hl, $D09D
    ld de, $C986
    ld a, [de]
    ld [hl+], a
    inc de
    call Func_037_5D5E
    call Func_037_5DA9
    call Func_037_5DBC
    ld a, [de]
    and a, $01
    ld [hl+], a
    inc de
    call Func_037_5D5E
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    dec de
    and a, c
    ld [$D043], a
    cp a, $FF
    jr nz, Jump_037_5BF5
    call Func_037_5CBC
    jr Jump_037_5C07

Jump_037_5BF5::
    call Func_037_5DA9
    call Func_037_5DA9
    call Func_037_5D5E
    ld a, [de]
    ld [hl+], a
    inc de
    call Func_037_5D5E
    ld a, [de]
    ld [hl+], a
    inc de

Jump_037_5C07::
    call Func_037_5DEB
    ld b, $12
    call Func_037_5D08
    call Func_037_5E3E
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, $28
    ld [hl+], a
    inc de
    ld a, $E6
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, $E6
    ld [hl+], a
    inc de
    ld b, $1A
    call Func_037_5D08
    ld a, $00
    ld [hl+], a
    inc de
    ld a, [$D043]
    cp a, $FF
    jr nz, Jump_037_5C3C
    call Func_037_5CC8
    jr Jump_037_5C47

Jump_037_5C3C::
    call Func_037_5D5E
    ld a, [de]
    ld [hl+], a
    inc de
    call Func_037_5D5E
    ld a, [de]
    ld [hl], a

Jump_037_5C47::
    ld hl, $5453
    ld b, $81
    rst $10
    ret

Func_037_5C4E::
    ld hl, $CA2B
    ld de, $D132
    ld a, [de]
    ld [hl+], a
    inc de
    call Func_037_5EC0
    call Func_037_5ED0
    ld a, c
    ld [$D006], a
    ld a, b
    ld [$D007], a
    call Func_037_5EE7
    ld a, [de]
    and a, $01
    ld [hl+], a
    inc de
    call Func_037_5EC0
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [$D043], a
    cp a, $FF
    jr nz, Jump_037_5C80
    call Func_037_5CE6
    jr Jump_037_5C95

Jump_037_5C80::
    call Func_037_5ED0
    call Func_037_5ED0
    call Func_037_5FB8
    call Func_037_5EC0
    ld a, [de]
    ld [hl+], a
    inc de
    call Func_037_5EC0
    ld a, [de]
    ld [hl+], a
    inc de

Jump_037_5C95::
    call Func_037_5EF7
    ld b, $12
    call Func_037_5D08
    call Func_037_5F4A
    ld b, $06
    call Func_037_5D08
    call Func_037_5FAD
    call Func_037_5EC0
    ld a, [de]
    ld [hl+], a
    inc de
    call Func_037_5EC0
    ld a, [de]
    ld [hl+], a
    ld [hl], $00
    ld hl, Data_037_73DF
    ld b, $19
    rst $10
    ret

Func_037_5CBC::
    ld a, e
    add a, $04
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    ld a, $FF
    ld [hl+], a
    ld [hl+], a

Func_037_5CC8::
    call Func_037_5CCB

Func_037_5CCB::
    ld a, e
    add a, $0B
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    ld a, $98
    ld [hl+], a
    ld a, $98
    ld [hl+], a
    ld a, $98
    ld [hl+], a
    ld a, $F0
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ret

Func_037_5CE6::
    inc de
    inc de
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    call Func_037_5CF1

Func_037_5CF1::
    ld a, e
    add a, $09
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    ld a, $F0
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ret

Func_037_5D08::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Func_037_5D08
    ret

Func_037_5D0F::
    cp a, $5C
    jr z, Jump_037_5D43
    cp a, $5E
    jr z, Jump_037_5D47
    cp a, $5F
    jr z, Jump_037_5D4B
    cp a, $60
    jr z, Jump_037_5D4F
    cp a, $61
    jr z, Jump_037_5D53
    cp a, $63
    jr z, Jump_037_5D57
    cp a, $64
    jr z, Jump_037_5D5B
    cp a, $0E
    jr nc, Jump_037_5D37
    cp a, $0A
    jr c, Jump_037_5D37
    sub a, $0A
    jr Jump_037_5D5D

Jump_037_5D37::
    cp a, $58
    jr nc, Jump_037_5D5D
    cp a, $24
    jr c, Jump_037_5D5D
    sub a, $1A
    jr Jump_037_5D5D

Jump_037_5D43::
    ld a, $95
    jr Jump_037_5D5D

Jump_037_5D47::
    ld a, $AB
    jr Jump_037_5D5D

Jump_037_5D4B::
    ld a, $B5
    jr Jump_037_5D5D

Jump_037_5D4F::
    ld a, $94
    jr Jump_037_5D5D

Jump_037_5D53::
    ld a, $93
    jr Jump_037_5D5D

Jump_037_5D57::
    ld a, $99
    jr Jump_037_5D5D

Jump_037_5D5B::
    ld a, $98

Jump_037_5D5D::
    ret

Func_037_5D5E::
    ld c, $00
    ld b, $08

Jump_037_5D62::
    ld a, [de]
    cp a, $95
    jr z, Jump_037_5D83
    cp a, $AB
    jr z, Jump_037_5D87
    cp a, $B5
    jr z, Jump_037_5D8B
    cp a, $94
    jr z, Jump_037_5D8F
    cp a, $93
    jr z, Jump_037_5D93
    cp a, $0A
    jr c, Jump_037_5D95
    cp a, $3E
    jr nc, Jump_037_5D95
    add a, $1A
    jr Jump_037_5D95

Jump_037_5D83::
    ld a, $5C
    jr Jump_037_5D95

Jump_037_5D87::
    ld a, $5E
    jr Jump_037_5D95

Jump_037_5D8B::
    ld a, $5F
    jr Jump_037_5D95

Jump_037_5D8F::
    ld a, $60
    jr Jump_037_5D95

Jump_037_5D93::
    ld a, $61

Jump_037_5D95::
    inc c
    bit 2, c
    jr z, Jump_037_5DA1
    bit 0, c
    jr z, Jump_037_5DA1
    dec c
    ld a, $F0

Jump_037_5DA1::
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_037_5D62
    inc de
    inc de
    ret

Func_037_5DA9::
    push hl
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    inc de
    ld a, l
    add a, $75
    ld l, a
    ld a, h
    adc a, $61
    ld h, a
    ld a, [hl]
    pop hl
    ld [hl+], a
    ret

Func_037_5DBC::
    ld a, [de]
    and a, $0F
    inc de
    cp a, $09
    jr nz, Jump_037_5DE3
    push hl
    dec hl
    ld a, [hl]
    ld hl, Data_037_5FC7
    ld c, a
    ld b, $00
    add hl, bc
    add hl, bc
    ld a, [hl+]
    ld [$D006], a
    ld a, [hl]
    ld [$D007], a
    push de
    ld hl, Data_037_400A
    ld b, $35
    rst $10
    pop de
    pop hl
    ld a, [$D008]

Jump_037_5DE3::
    cp a, $0A
    jr nz, Jump_037_5DE9
    ld a, $09

Jump_037_5DE9::
    ld [hl+], a
    ret

Func_037_5DEB::
    ld b, $21
    push hl

Jump_037_5DEE::
    ld a, [de]
    inc de
    cp a, $FF
    jr z, Jump_037_5DFF
    push hl
    ld hl, Data_037_63D3
    add a, l
    ld l, a
    jr nc, Jump_037_5DFD
    inc h

Jump_037_5DFD::
    ld a, [hl]
    pop hl

Jump_037_5DFF::
    ld [hl+], a
    dec b
    jr nz, Jump_037_5DEE
    pop hl
    push de
    push hl
    ld de, $D21D
    ld b, $21
    ld a, $FF

Jump_037_5E0D::
    ld [de], a
    inc de
    dec b
    jr nz, Jump_037_5E0D
    ld b, $08
    ld de, $D21D

Jump_037_5E17::
    ld a, [hl+]
    cp a, $FE
    jr nc, Jump_037_5E1E
    ld [de], a
    inc de

Jump_037_5E1E::
    dec b
    jr nz, Jump_037_5E17
    ld b, $19
    ld de, $D225

Jump_037_5E26::
    ld a, [hl+]
    cp a, $FE
    jr nc, Jump_037_5E2D
    ld [de], a
    inc de

Jump_037_5E2D::
    dec b
    jr nz, Jump_037_5E26
    pop hl
    ld b, $21
    ld de, $D21D

Jump_037_5E36::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_037_5E36
    pop de
    ret

Func_037_5E3E::
    push hl
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    inc de
    ld hl, $03E7
    call Func_000_3E7A
    jr nz, Jump_037_5E52
    ld bc, $01FF
    jr Jump_037_5E64

Jump_037_5E52::
    push de
    ld a, $33
    call Func_000_16AA
    ld a, $64
    call Func_000_16E2
    or a, a
    jr z, Jump_037_5E61
    inc hl

Jump_037_5E61::
    ld b, h
    ld c, l
    pop de

Jump_037_5E64::
    pop hl
    ld [hl], c
    inc hl
    ld [hl], b
    inc hl
    push hl
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    inc de
    ld hl, $03E7
    call Func_000_3E7A
    jr nz, Jump_037_5E7D
    ld bc, $00FF
    jr Jump_037_5E8F

Jump_037_5E7D::
    push de
    ld a, $19
    call Func_000_16AA
    ld a, $64
    call Func_000_16E2
    or a, a
    jr z, Jump_037_5E8C
    inc hl

Jump_037_5E8C::
    ld b, h
    ld c, l
    pop de

Jump_037_5E8F::
    pop hl
    ld [hl], c
    inc hl
    ld [hl], b
    inc hl
    push hl
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    inc de
    ld hl, $03E7
    call Func_000_3E7A
    jr nz, Jump_037_5EA8
    ld bc, $00FF
    jr Jump_037_5EBA

Jump_037_5EA8::
    push de
    ld a, $19
    call Func_000_16AA
    ld a, $64
    call Func_000_16E2
    or a, a
    jr z, Jump_037_5EB7
    inc hl

Jump_037_5EB7::
    ld b, h
    ld c, l
    pop de

Jump_037_5EBA::
    pop hl
    ld [hl], c
    inc hl
    ld [hl], b
    inc hl
    ret

Func_037_5EC0::
    ld b, $08

Jump_037_5EC2::
    ld a, [de]
    call Func_037_5D0F
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_037_5EC2
    ld a, $F0
    ld [hl+], a
    ld [hl+], a
    ret

Func_037_5ED0::
    ld a, [de]
    inc de
    push hl
    ld l, a
    ld h, $00
    add hl, hl
    ld a, l
    add a, $C7
    ld l, a
    ld a, h
    adc a, $5F
    ld h, a
    ld a, [hl+]
    ld b, [hl]
    pop hl
    ld [hl+], a
    ld [hl], b
    ld c, a
    inc hl
    ret

Func_037_5EE7::
    push hl
    push de
    ld hl, Func_037_4001
    ld b, $35
    rst $10
    pop de
    pop hl
    ld a, [$D008]
    ld [hl+], a
    inc de
    ret

Func_037_5EF7::
    ld b, $21
    push hl

Jump_037_5EFA::
    ld a, [de]
    inc de
    cp a, $FF
    jr z, Jump_037_5F0B
    push hl
    ld hl, Data_037_62F5
    add a, l
    ld l, a
    jr nc, Jump_037_5F09
    inc h

Jump_037_5F09::
    ld a, [hl]
    pop hl

Jump_037_5F0B::
    ld [hl+], a
    dec b
    jr nz, Jump_037_5EFA
    pop hl
    push de
    push hl
    ld de, $D21D
    ld b, $21
    ld a, $FF

Jump_037_5F19::
    ld [de], a
    inc de
    dec b
    jr nz, Jump_037_5F19
    ld b, $08
    ld de, $D21D

Jump_037_5F23::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_037_5F2A
    ld [de], a
    inc de

Jump_037_5F2A::
    dec b
    jr nz, Jump_037_5F23
    ld b, $19
    ld de, $D225

Jump_037_5F32::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_037_5F39
    ld [de], a
    inc de

Jump_037_5F39::
    dec b
    jr nz, Jump_037_5F32
    pop hl
    ld b, $21
    ld de, $D21D

Jump_037_5F42::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_037_5F42
    pop de
    ret

Func_037_5F4A::
    push hl
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    inc de
    ld hl, $01FF
    call Func_000_3E7A
    jr nz, Jump_037_5F5E
    ld bc, $03E7
    jr Jump_037_5F70

Jump_037_5F5E::
    push de
    ld a, $C3
    call Func_000_16AA
    ld a, $64
    call Func_000_16E2
    or a, a
    jr z, Jump_037_5F6D
    inc hl

Jump_037_5F6D::
    ld b, h
    ld c, l
    pop de

Jump_037_5F70::
    pop hl
    ld [hl], c
    inc hl
    ld [hl], b
    inc hl
    call Func_037_5F78

Func_037_5F78::
    push hl
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    inc de
    ld hl, $00FF
    call Func_000_3E7A
    jr nz, Jump_037_5F8C
    ld bc, $03E7
    jr Jump_037_5FA7

Jump_037_5F8C::
    push de
    push bc
    ld a, $5B
    call Func_000_16AA
    ld a, $64
    call Func_000_16E2
    or a, a
    jr z, Jump_037_5F9C
    inc hl

Jump_037_5F9C::
    ld b, h
    ld c, l
    pop hl
    ld d, h
    ld e, l
    add hl, hl
    add hl, de
    add hl, bc
    ld b, h
    ld c, l
    pop de

Jump_037_5FA7::
    pop hl
    ld [hl], c
    inc hl
    ld [hl], b
    inc hl
    ret

Func_037_5FAD::
    ld b, $1A
    call Func_037_5D08
    ld a, [$D034]
    ld [hl+], a
    inc de
    ret

Func_037_5FB8::
    push af
    push bc
    push de
    push hl
    ld hl, Func_037_4001
    ld b, $81
    rst $10
    pop hl
    pop de
    pop bc
    pop af
    ret

Data_037_5FC7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0DDFC7, $85
    dw Data_037_6100
    dw Data_037_6200
    dw Data_037_6300
    dw Data_037_6A00
    dw Data_037_6B00
    dw Data_037_6C00
    dw Data_037_6D00
    dw Data_037_6E00
    dw Data_037_6F00
    dw Data_037_7000
    dw Data_037_7100
    dw Data_037_7300
    dw Data_037_7500
    dw Data_037_7600
    dw Data_037_7700
    dw Data_037_7800
    dw Data_037_7900
    dw Data_037_7B00
    dw Data_037_7C00
    dw Data_037_7D00
    dw Data_037_7F00
    INCBIN "dwm2-cobi-us.gbc", $0DE076, $8A

Data_037_6100:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0DE100, $5A
    dw Data_037_6201
    dw Data_037_6301
    dw Data_037_6501
    dw Data_037_6601
    dw Data_037_6801
    dw Data_037_6A01
    dw Data_037_6B01
    dw Data_037_6C01
    dw Data_037_6D01
    dw Data_037_6E01
    dw Data_037_6F01
    dw Data_037_7001
    dw Data_037_7101
    INCBIN "dwm2-cobi-us.gbc", $0DE174, $8C

Data_037_6200:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_037_6201:: ; heuristic: target of a monotone pointer table; C0
    db $00, $5A, $5B, $5C, $5D, $5E, $5F, $60, $61, $6A, $62, $63, $64, $65, $5F, $66
    db $67, $68, $69, $6A, $6B, $67, $6C, $6C, $6D, $6D, $63, $65, $00, $00, $00, $00
    db $00, $00, $00, $00
    dw Data_037_6F6E
    dw Data_037_7170
    dw Data_037_7372
    dw Data_037_7574
    dw Data_037_7678
    dw Data_037_7877
    dw Data_037_7A79
    dw Data_037_7C7B
    dw Data_037_7E7D
    INCBIN "dwm2-cobi-us.gbc", $0DE237, $BE

Data_037_62F5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B

Data_037_6300:: ; heuristic: target of a monotone pointer table; C0
    db $0C

Data_037_6301:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0DE301, $A4
    ds $25, $FF
    db $3B, $54, $58, $59, $67, $34, $C8, $35, $8F

Data_037_63D3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $3A, $00, $01, $02

Data_037_63D7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0DE3D7, $A6

Data_037_647D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $F8, $F9, $FA
    db $FB, $FC, $C3, $EA, $ED, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $B7, $B6, $C7, $A7, $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_037_64B9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $70, $71, $72, $B7, $B6, $C3, $C3, $C3
    db $C3, $B7, $B6, $C3, $76, $73, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B5

Data_037_64D7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $C3, $60, $61, $62, $62
    db $63, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $64, $65
    db $66, $67, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3

Data_037_6501:: ; heuristic: target of a monotone pointer table; C0
    db $C3, $C3, $B7, $B6, $C3, $C3, $68, $69, $6A, $6B, $C3, $B7, $B3, $B4, $B4, $B4
    db $B4, $B4, $B4, $B4, $B5

Data_037_6516:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FC, $C3, $24, $C4, $4C

Data_037_651B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C4
    ds $24, $00

Data_037_6540:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $37, $00

Data_037_6577:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $8A, $00

Data_037_6601:: ; heuristic: target of a monotone pointer table; C0
    ds $B5, $00

Data_037_66B6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $29, $00

Data_037_66DF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $122, $00

Data_037_6801:: ; heuristic: target of a monotone pointer table; C0
    ds $7E, $00

Data_037_687F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Data_037_688D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $66, $00

Data_037_68F3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $80, $00

Data_037_6973:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $8D, $00

Data_037_6A00:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_037_6A01:: ; heuristic: target of a monotone pointer table; C0
    ds $3C, $00

Data_037_6A3D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $C3, $00

Data_037_6B00:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_037_6B01:: ; heuristic: target of a monotone pointer table; C0
    ds $FF, $00

Data_037_6C00:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_037_6C01:: ; heuristic: target of a monotone pointer table; C0
    ds $FF, $00

Data_037_6D00:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_037_6D01:: ; heuristic: target of a monotone pointer table; C0
    ds $FF, $00

Data_037_6E00:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_037_6E01:: ; heuristic: target of a monotone pointer table; C0
    ds $FF, $00

Data_037_6F00:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_037_6F01:: ; heuristic: target of a monotone pointer table; C0
    ds $6D, $00

Data_037_6F6E:: ; heuristic: target of a monotone pointer table; C0
    ds $92, $00

Data_037_7000:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_037_7001:: ; heuristic: target of a monotone pointer table; C0
    ds $FF, $00

Data_037_7100:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_037_7101:: ; heuristic: target of a monotone pointer table; C0
    ds $6F, $00

Data_037_7170:: ; heuristic: target of a monotone pointer table; C0
    ds $190, $00

Data_037_7300:: ; heuristic: target of a monotone pointer table; C0
    ds $72, $00

Data_037_7372:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00

Data_037_7375:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $6A, $00

Data_037_73DF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Data_037_73EC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $A8, $00

Data_037_7494:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $4F, $00

Data_037_74E3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $1D, $00

Data_037_7500:: ; heuristic: target of a monotone pointer table; C0
    ds $3A, $00

Data_037_753A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $3A, $00

Data_037_7574:: ; heuristic: target of a monotone pointer table; C0
    ds $1D, $00

Data_037_7591:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $6F, $00

Data_037_7600:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_037_7601:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $77, $00

Data_037_7678:: ; heuristic: target of a monotone pointer table; C0
    ds $3D, $00

Data_037_76B5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $4B, $00

Data_037_7700:: ; heuristic: target of a monotone pointer table; C0
    ds $54, $00

Data_037_7754:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $AC, $00

Data_037_7800:: ; heuristic: target of a monotone pointer table; C0
    ds $77, $00

Data_037_7877:: ; heuristic: target of a monotone pointer table; C0
    ds $89, $00

Data_037_7900:: ; heuristic: target of a monotone pointer table; C0
    ds $148, $00

Data_037_7A48:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $31, $00

Data_037_7A79:: ; heuristic: target of a monotone pointer table; C0
    ds $87, $00

Data_037_7B00:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_037_7C00:: ; heuristic: target of a monotone pointer table; C0
    ds $7B, $00

Data_037_7C7B:: ; heuristic: target of a monotone pointer table; C0
    ds $85, $00

Data_037_7D00:: ; heuristic: target of a monotone pointer table; C0
    ds $17D, $00

Data_037_7E7D:: ; heuristic: target of a monotone pointer table; C0
    ds $19, $00

Data_037_7E96:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $6A, $00

Data_037_7F00:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00
