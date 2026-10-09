SECTION "Bank 33", ROMX[$4000], BANK[$33]
    db $33

Func_033_4001::
    ld d, $00
    ld hl, $405F
    add hl, de
    add hl, de
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld c, [hl]
    inc hl
    push hl
    ld hl, $C198
    add hl, de
    pop de

Jump_033_4019::
    push bc
    push hl

Jump_033_401B::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_033_401B
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_033_4019
    ret

Func_033_402B::
    ld d, $00
    ld hl, $405F
    add hl, de
    add hl, de
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld c, [hl]
    inc hl
    push hl
    ld hl, $C198
    add hl, de
    pop de

Jump_033_4043::
    push bc
    push hl

Jump_033_4045::
    ld a, [de]
    cp a, $15
    jr c, Jump_033_4050
    cp a, $A4
    jr nc, Jump_033_4050
    ld a, $C3

Jump_033_4050::
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_033_4045
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_033_4043
    ret
    dw Data_033_40C5
    dw Data_033_4111
    dw Data_033_41B1
    dw Data_033_41D9
    dw Data_033_4219
    dw Data_033_42A1
    dw Data_033_42DD
    dw Data_033_4335
    dw Data_033_4411
    dw Data_033_444D
    dw Data_033_4529
    dw Data_033_4789
    dw Data_033_479F
    dw Data_033_480F
    dw Data_033_489F
    dw Data_033_4909
    dw Data_033_492B
    dw Data_033_4993
    dw Data_033_49DF
    dw Data_033_49DF
    dw Data_033_49DF
    dw Data_033_49DF
    dw Data_033_49DF
    dw Data_033_49DF
    dw Data_033_49DF
    dw Data_033_49DF
    dw Data_033_49DF
    dw Data_033_49DF
    dw Data_033_4A29
    dw Data_033_4A75
    dw Data_033_4B2D
    dw Data_033_4B2D
    dw Data_033_4B2D
    dw Data_033_4B79
    dw Data_033_4C40
    dw Data_033_4CA6
    dw Data_033_4D31
    dw Data_033_4D66
    dw Data_033_4D88
    dw Data_033_4DA1
    dw Data_033_4E08
    dw Data_033_4E8A
    dw Data_033_4EFA
    dw Data_033_4FDA
    dw Data_033_4FFC
    dw Data_033_505A
    db $35, $45, $94, $45, $41, $46, $49, $47, $D4, $48

Data_033_40C5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0CC0C5, $4C

Data_033_4111:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0CC111, $A0

Data_033_41B1:: ; heuristic: target of a monotone pointer table; C0
    db $61, $01, $06, $06, $5C, $5D, $5E, $5F, $60, $61
    dw Data_033_6362
    dw Data_033_6564
    dw Data_033_6766
    dw Data_033_6968
    dw Data_033_6B6A
    dw Data_033_6D6C
    dw Data_033_6F6E
    dw Data_033_7170
    dw Data_033_7372
    dw Data_033_7574
    dw Data_033_7776
    dw Data_033_7978
    dw Data_033_7B7A
    dw Data_033_7D7C
    dw Data_033_7F7E

Data_033_41D9:: ; heuristic: target of a monotone pointer table; C0
    db $A8, $01, $0C, $05, $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $F9, $FA, $ED, $C3, $C3, $C3, $BE, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $FB, $FA, $ED, $C3, $C3, $C3, $BE
    db $C3, $C3, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_033_4219:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0CC219, $88

Data_033_42A1:: ; heuristic: target of a monotone pointer table; C0
    db $60, $01, $08, $07, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B0, $B1, $B1, $B1
    db $B1, $B1, $B1, $B2, $B6, $35, $36, $37, $38, $39, $3A, $B7, $B6, $C3, $C3, $C3
    db $C3, $C3, $C3, $B7, $B6, $3B, $3C, $3D, $3E, $3F, $40, $B7, $B3, $B4, $B4, $B4
    db $B4, $B4, $B4, $B5, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3

Data_033_42DD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0CC2DD, $58

Data_033_4335:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0CC335, $DC

Data_033_4411:: ; heuristic: target of a monotone pointer table; C0
    db $60, $01, $08, $07
    ds $38, $C3

Data_033_444D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0CC44D, $DC

Data_033_4529:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0CC529, $11D
    ds $12, $B1
    db $B2, $B6, $D0, $D1, $D2, $D3, $D4, $C3, $D5, $D6, $D7, $D8, $D9, $C3, $DA, $DB
    db $DC, $DD, $DE, $C3, $B7, $B8
    ds $12, $B9
    db $BA, $B6, $EB, $C3, $C3, $C3, $C3, $C3, $EB, $C3, $C3, $C3, $C3, $C3, $EB, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6, $EC, $C3, $C3, $C3, $C3, $C3, $EC, $C3, $C3, $C3
    db $C3, $C3, $EC, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $EA, $ED, $C3, $C3, $C3, $C3
    db $EA, $ED, $C3, $C3, $C3, $C3, $EA, $ED, $C3, $C3, $C3, $C3, $B7, $B3
    ds $12, $B4
    INCBIN "dwm2-cobi-us.gbc", $0CC6D0, $B9

Data_033_4789:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $06, $03, $B0, $B1, $B1, $B1, $B1, $B2, $B6, $A4, $A8, $A9, $EC, $B7
    db $B3, $B4, $B4, $B4, $B4, $B5

Data_033_479F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0CC79F, $70

Data_033_480F:: ; heuristic: target of a monotone pointer table; C0
    db $40, $01, $14, $07, $B0
    ds $12, $B1
    db $B2, $B6, $23, $24, $25, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $2E, $2F, $30
    db $31, $32, $33, $34, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $35, $36, $37, $38, $39, $3A, $3B, $3C, $3D, $3E, $3F, $40, $41, $42
    db $43, $44, $45, $46, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $47, $48, $49, $4A, $4B, $4C, $4D, $4E, $4F, $50, $51, $52, $53, $54
    db $55, $56, $57, $58, $B7, $B3
    ds $12, $B4
    db $B5

Data_033_489F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0CC89F, $6A

Data_033_4909:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $06, $05, $B0, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $CE, $CF, $DF, $B7
    db $B6, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $A5, $F4, $C3, $B7, $B3, $B4, $B4, $B4
    db $B4, $B5

Data_033_492B:: ; heuristic: target of a monotone pointer table; C0
    db $A0, $01, $14, $05, $B0
    ds $12, $B1
    db $B2, $B6, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8A, $8B, $8C, $8D
    db $8E, $8F, $90, $91, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F
    db $A0, $A1, $A2, $A3, $B7, $B3
    ds $12, $B4
    db $B5

Data_033_4993:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0CC993, $4C

Data_033_49DF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0CC9DF, $4A

Data_033_4A29:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0CCA29, $4C

Data_033_4A75:: ; heuristic: target of a monotone pointer table; C0
    db $20, $01, $14, $09, $B0
    ds $12, $B1
    db $B2, $B6, $23, $24, $25, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $2E, $2F, $30
    db $31, $32, $33, $34, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $35, $36, $37, $38, $39, $3A, $3B, $3C, $3D, $3E, $3F, $40, $41, $42
    db $43, $44, $45, $46, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $47, $48, $49, $4A, $4B, $4C, $4D, $4E, $4F, $50, $51, $52, $53, $54
    db $55, $56, $57, $58, $B7, $B8
    ds $12, $B9
    db $BA, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $BE, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $B7, $B3
    ds $12, $B4
    db $B5

Data_033_4B2D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0CCB2D, $4C

Data_033_4B79:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0CCB79, $C7

Data_033_4C40:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0CCC40, $66

Data_033_4CA6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0CCCA6, $8B

Data_033_4D31:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $07, $07, $B0, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $FD, $02, $FE, $FF
    db $C3, $B7, $B8, $B9, $B9, $B9, $B9, $B9, $BA, $B6, $C3, $00, $DF, $CF, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $FF, $F4, $DF, $DF, $B7, $B3, $B4
    db $B4, $B4, $B4, $B4, $B5

Data_033_4D66:: ; heuristic: target of a monotone pointer table; C0
    db $E0, $00, $06, $05, $B0, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $CE, $CF, $DF, $B7
    db $B6, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $A5, $F4, $C3, $B7, $B3, $B4, $B4, $B4
    db $B4, $B5

Data_033_4D88:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $00, $07, $03, $B0, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $D0, $D1, $D2, $D3
    db $D4, $B7, $B3, $B4, $B4, $B4, $B4, $B4, $B5

Data_033_4DA1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0CCDA1, $67

Data_033_4E08:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0CCE08, $82

Data_033_4E8A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0CCE8A, $70

Data_033_4EFA:: ; heuristic: target of a monotone pointer table; C0
    db $20, $00, $14, $0B, $B0
    ds $12, $B1
    db $B2, $B6, $05, $06, $07, $08, $09, $0A, $ED, $20, $21, $22, $23, $24, $C3, $C3
    db $C3, $ED, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $25, $26, $27, $28, $29, $2A, $C3, $EA, $ED, $C3, $C3, $C3, $C3, $C3
    db $37, $38, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $39, $3A, $C3, $C3, $B7, $B6, $2B, $2C, $2D, $2E, $2F, $30
    db $C3, $EA, $ED, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $31, $32, $33, $34, $35, $36, $C3, $EA, $ED, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $3B, $3C, $3D, $3E, $3F, $40, $41, $42, $43, $44, $45, $46, $47, $C3
    db $C3, $C3, $C3, $C3, $B7, $B3
    ds $12, $B4
    db $B5

Data_033_4FDA:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $01, $06, $05, $B0, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $CE, $CF, $DF, $B7
    db $B6, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $A5, $F4, $C3, $B7, $B3, $B4, $B4, $B4
    db $B4, $B5

Data_033_4FFC:: ; heuristic: target of a monotone pointer table; C0
    db $21, $01, $12, $05, $B0
    ds $10, $B1
    db $B2, $B6, $A6, $F0, $DF, $F7, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $AA, $F2
    db $F4, $0B, $B7, $B6
    ds $10, $C3
    db $B7, $B6, $C3, $E1, $C3, $E2, $C3, $E3, $C3, $E4, $C3, $E5, $C3, $E6, $C3, $E7
    db $C3, $E8, $B7, $B3
    ds $10, $B4
    db $B5

Data_033_505A:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $14, $12, $B0
    ds $12, $B1
    db $B2, $B6, $04, $F0, $DF, $F7, $CF, $F6, $ED, $30, $31, $32, $33, $34, $C3, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $C3, $A8, $13, $14, $CF, $ED, $C3, $C3, $C3, $ED, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $C3, $A6, $F0, $F6, $14, $ED, $04, $A7, $A5, $C3, $C3, $C3, $A9
    db $BF, $BF, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $AA, $F2, $CF, $CF, $F5, $ED, $04, $A7, $A5, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $B7, $B3
    ds $12, $B4
    db $B5, $B0
    ds $12, $B1
    db $B2, $B6, $C3, $C3, $01, $F0, $F7, $CF, $12, $F4, $F6, $13, $CF, $DF, $ED, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $20, $C3, $C3, $C3, $21, $C3, $C3, $C3, $22, $C3, $C3, $C3, $23
    db $C3, $C3, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $24, $C3, $C3, $C3, $25, $C3, $C3, $C3, $26, $C3, $C3, $C3, $27
    db $C3, $C3, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $28, $C3, $C3, $C3, $29, $C3, $C3, $C3, $2A, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $B7, $B3
    ds $12, $B4
    db $B5

Func_033_51C6::
    call Func_000_0535
    ld a, [$D06A]
    or a, a
    jr nz, Jump_033_51D0
    ret

Jump_033_51D0::
    ld a, [$D780]
    cp a, $0C
    jr z, Jump_033_51DC
    cp a, $0D
    jr z, Jump_033_51FB
    ret

Jump_033_51DC::
    ld a, [$D782]
    and a, a
    ret nz
    ld a, [$D781]
    cp a, $20
    jr z, Jump_033_51F4
    cp a, $15
    jr z, Jump_033_51ED
    ret

Jump_033_51ED::
    ld hl, $5C35
    ld b, $1D
    rst $10
    ret

Jump_033_51F4::
    ld hl, $5BF2
    ld b, $1D
    rst $10
    ret

Jump_033_51FB::
    ld a, [$D781]
    cp a, $15
    jr z, Jump_033_5207
    cp a, $20
    jr z, Jump_033_520E
    ret

Jump_033_5207::
    ld hl, $5719
    ld b, $F1
    rst $10
    ret

Jump_033_520E::
    ld hl, $4EDD
    ld b, $F2
    rst $10
    ret

Func_033_5215::
    ld a, [$D06A]
    or a, a
    jr nz, Jump_033_523B
    ld a, [$D06B]
    rst $00
    dw Jump_033_5264
    dw Jump_033_5287
    dw Jump_033_52A8
    dw Jump_033_52BB
    dw Jump_033_5338
    dw Jump_033_537D
    dw Jump_033_538A
    dw Jump_033_53D4
    dw Jump_033_5433
    dw Jump_033_545B
    dw Jump_033_5483
    dw Jump_033_5497
    dw Jump_033_5502
    dw Jump_033_552A

Jump_033_523B::
    ld a, [$C56C]
    or a, a
    ret nz
    ld a, [$D780]
    rst $00
    dw Jump_033_555F
    dw Jump_033_5564
    dw Jump_033_556F
    dw Jump_033_55E0
    dw Jump_033_55E5
    dw Jump_033_5883
    dw Jump_033_5C1A
    dw Jump_033_5C1A
    dw Jump_033_5C1A
    dw Jump_033_5C1A
    dw Jump_033_5C1A
    dw Jump_033_5C1A
    dw Jump_033_5C1A
    dw Jump_033_5C36
    dw Jump_033_5C4F
    dw Jump_033_5E57

Jump_033_5264::
    ld de, $62AB
    ld hl, $C1A4
    ld bc, $0803
    call Func_033_6152
    ld de, $62C3
    ld hl, $C198
    ld bc, $0A0B
    call Func_033_6152
    call Func_033_6247
    call Func_033_6049
    ld hl, $D06B
    inc [hl]
    ret

Jump_033_5287::
    xor a, a
    ld [$C594], a
    call Func_033_6197
    ld de, $C895
    ld hl, $C1DB
    call Func_033_61FB
    call Func_033_60D3
    ld bc, $140D
    ld de, $0000
    call Func_033_60FC
    ld hl, $D06B
    inc [hl]
    ret

Jump_033_52A8::
    ld a, [$C56C]
    or a, a
    ret nz
    ld a, $19
    call Func_033_5550
    ld hl, $D06B
    inc [hl]
    xor a, a
    ld [$C594], a
    ret

Jump_033_52BB::
    ld a, [$C58F]
    cp a, $FE
    jr nz, Jump_033_52D7
    ld a, $FE
    ld [$C594], a
    ld a, $01
    ld [$D06A], a
    ld a, $02
    ld [$D780], a
    ld a, $0A
    call Func_033_5550
    ret

Jump_033_52D7::
    ld a, [$C52B]
    or a, a
    ret nz
    ld a, [$C552]
    and a, $01
    jr z, Jump_033_52F8
    ld a, $FE
    ld [$C594], a
    ld a, $01
    ld [$D06A], a
    ld a, $02
    ld [$D780], a
    ld a, $09
    call Func_033_5550
    ret

Jump_033_52F8::
    ld a, [$C617]
    sub a, $E8
    ld c, a
    ld a, [$C618]
    sbc a, $03
    ld b, a
    ld a, [$C619]
    sbc a, $00
    jr nc, Jump_033_531E
    ld a, $00
    call Func_033_5550
    ld a, [$D06B]
    add a, $08
    ld [$D06B], a
    ld a, $10
    ld [$C594], a
    ret

Jump_033_531E::
    ld [$C619], a
    ld a, b
    ld [$C618], a
    ld a, c
    ld [$C617], a
    ld a, $0C
    call Func_033_5550
    ld hl, $D06B
    inc [hl]
    ld a, $01
    ld [$C594], a
    ret

Jump_033_5338::
    ld a, [$C58F]
    cp a, $FE
    jr z, Jump_033_5348
    cp a, $01
    jr z, Jump_033_535D
    cp a, $10
    jr z, Jump_033_536B
    ret

Jump_033_5348::
    ld a, $FE
    ld [$C594], a
    ld a, $01
    ld [$D06A], a
    ld a, $02
    ld [$D780], a
    ld a, $0A
    call Func_033_5550
    ret

Jump_033_535D::
    ld a, $07
    call Func_033_5550
    ld hl, $D06B
    inc [hl]
    xor a, a
    ld [$C594], a
    ret

Jump_033_536B::
    ld a, $01
    call Func_033_5550
    ld hl, $D06B
    inc [hl]
    ld hl, $D06B
    inc [hl]
    ld hl, $D06B
    inc [hl]
    ret

Jump_033_537D::
    xor a, a
    ld [$C594], a
    ld hl, $D06B
    inc [hl]
    xor a, a
    ld [$D06C], a
    ret

Jump_033_538A::
    ld a, [$D06C]
    rst $00
    dw Jump_033_5394
    dw Jump_033_53AC
    dw Jump_033_53C2

Jump_033_5394::
    ld a, [$C52B]
    or a, a
    ret nz
    ld hl, $C198
    ld bc, $0104

Jump_033_539F::
    ld a, $C3
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_033_539F
    ld hl, $D06C
    inc [hl]
    ret

Jump_033_53AC::
    call Func_033_60D3
    ld bc, $140D
    ld de, $0000
    call Func_033_60FC
    ld a, $08
    call Func_033_5550
    ld hl, $D06C
    inc [hl]
    ret

Jump_033_53C2::
    xor a, a
    ld [$D06B], a
    xor a, a
    ld [$D06C], a
    ld a, $01
    ld [$D06A], a
    xor a, a
    ld [$D780], a
    ret

Jump_033_53D4::
    ld a, [$C52B]
    or a, a
    ret nz
    ld a, [$C552]
    and a, $01
    jr z, Jump_033_53F3
    ld a, $05
    call Func_033_5550
    ld a, $40
    ld [$C594], a
    ld hl, $D06B
    inc [hl]
    ld hl, $D06B
    inc [hl]
    ret

Jump_033_53F3::
    ld a, [$C617]
    sub a, $E8
    ld c, a
    ld a, [$C618]
    sbc a, $03
    ld b, a
    ld a, [$C619]
    sbc a, $00
    jr nc, Jump_033_5419
    ld a, $04
    call Func_033_5550
    ld a, $30
    ld [$C594], a
    ld hl, $D06B
    inc [hl]
    ld hl, $D06B
    inc [hl]
    ret

Jump_033_5419::
    ld [$C619], a
    ld a, b
    ld [$C618], a
    ld a, c
    ld [$C617], a
    ld a, $02
    call Func_033_5550
    ld a, $20
    ld [$C594], a
    ld hl, $D06B
    inc [hl]
    ret

Jump_033_5433::
    ld a, [$C58F]
    cp a, $FE
    jr z, Jump_033_5446
    cp a, $20
    ret nz
    ld hl, $D06B
    dec [hl]
    ld hl, $D06B
    dec [hl]
    ret

Jump_033_5446::
    ld a, $FE
    ld [$C594], a
    ld a, $01
    ld [$D06A], a
    ld a, $02
    ld [$D780], a
    ld a, $0A
    call Func_033_5550
    ret

Jump_033_545B::
    ld a, [$C58F]
    cp a, $FE
    jr z, Jump_033_546E
    cp a, $30
    jr z, Jump_033_5469
    cp a, $40
    ret nz

Jump_033_5469::
    ld hl, $D06B
    inc [hl]
    ret

Jump_033_546E::
    ld a, $FE
    ld [$C594], a
    ld a, $01
    ld [$D06A], a
    ld a, $02
    ld [$D780], a
    ld a, $0A
    call Func_033_5550
    ret

Jump_033_5483::
    ld a, $FE
    ld [$C594], a
    ld a, $01
    ld [$D06A], a
    xor a, a
    ld [$D06B], a
    ld a, $02
    ld [$D780], a
    ret

Jump_033_5497::
    ld a, [$C58F]
    cp a, $FE
    jr z, Jump_033_54ED
    cp a, $10
    jr z, Jump_033_54BE
    cp a, $20
    jr z, Jump_033_54CF
    cp a, $30
    jr z, Jump_033_54DC
    cp a, $40
    ret nz
    ld [$C594], a
    ld a, $06
    call Func_033_5550
    ld hl, $D06B
    inc [hl]
    ld hl, $D06B
    inc [hl]
    ret

Jump_033_54BE::
    ld [$C594], a
    ld a, $04
    call Func_033_5550
    ld hl, $D06B
    inc [hl]
    ld hl, $D06B
    inc [hl]
    ret

Jump_033_54CF::
    ld [$C594], a
    ld a, $03
    call Func_033_5550
    ld hl, $D06B
    inc [hl]
    ret

Jump_033_54DC::
    ld [$C594], a
    ld a, $04
    call Func_033_5550
    ld hl, $D06B
    inc [hl]
    ld hl, $D06B
    inc [hl]
    ret

Jump_033_54ED::
    ld a, $FE
    ld [$C594], a
    ld a, $01
    ld [$D06A], a
    ld a, $02
    ld [$D780], a
    ld a, $0A
    call Func_033_5550
    ret

Jump_033_5502::
    ld a, [$C58F]
    cp a, $FE
    jr z, Jump_033_5515
    or a, a
    jr z, Jump_033_550F
    cp a, $20
    ret nz

Jump_033_550F::
    ld a, $05
    ld [$D06B], a
    ret

Jump_033_5515::
    ld a, $FE
    ld [$C594], a
    ld a, $01
    ld [$D06A], a
    ld a, $02
    ld [$D780], a
    ld a, $0A
    call Func_033_5550
    ret

Jump_033_552A::
    ld a, [$C58F]
    cp a, $10
    jr z, Jump_033_553C
    cp a, $30
    jr z, Jump_033_553C
    cp a, $40
    jr z, Jump_033_553C
    cp a, $FE
    ret nz

Jump_033_553C::
    ld a, $FE
    ld [$C594], a
    ld a, $01
    ld [$D06A], a
    xor a, a
    ld [$D06B], a
    ld a, $02
    ld [$D780], a
    ret

Func_033_5550::
    ld [$C529], a
    ld a, $05
    ld [$C528], a
    ld hl, $4001
    ld b, $07
    rst $10
    ret

Jump_033_555F::
    ld hl, $D780
    inc [hl]
    ret

Jump_033_5564::
    ld a, [$C52B]
    and a, a
    ret nz
    ld hl, $D780
    inc [hl]
    inc [hl]
    ret

Jump_033_556F::
    ld a, [$D781]
    rst $00
    dw Jump_033_557D
    dw Jump_033_558F
    dw Jump_033_559E
    dw Jump_033_55AD
    dw Jump_033_55BC

Jump_033_557D::
    ld a, [$C58F]
    cp a, $FE
    ret nz
    xor a, a
    ld [$C594], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_033_558F::
    ld a, [$C52B]
    and a, a
    ret nz
    ld a, $0C
    call Func_033_6039
    ld hl, $D781
    inc [hl]
    ret

Jump_033_559E::
    ld a, [$C52B]
    and a, a
    ret nz
    ld a, $01
    ld [$C594], a
    ld hl, $D781
    inc [hl]
    ret

Jump_033_55AD::
    ld a, [$C58F]
    cp a, $01
    ret nz
    xor a, a
    ld [$C594], a
    ld hl, $D781
    inc [hl]
    ret

Jump_033_55BC::
    ld a, [$C52B]
    bit 0, a
    ret nz
    ld hl, $D780
    ld bc, $006F

Jump_033_55C8::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_033_55C8
    ld hl, $C5DB
    ld a, $05
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld [hl], a
    ld hl, $C5DF
    inc [hl]
    ret

Jump_033_55E0::
    ld hl, $D780
    inc [hl]
    ret

Jump_033_55E5::
    ld a, [$D781]
    rst $00
    dw Jump_033_5609
    dw Jump_033_5609
    dw Jump_033_5615
    dw Jump_033_5609
    dw Func_033_561C
    dw Func_033_5623
    dw Func_033_562A
    dw Jump_033_563B
    dw Jump_033_5676
    dw Jump_033_56FC
    dw Jump_033_574F
    dw Jump_033_57B2
    dw Jump_033_57DC
    dw Jump_033_57F8
    dw Jump_033_5839
    dw Jump_033_5874

Jump_033_5609::
    ld a, [$C52B]
    and a, a
    ret nz
    ld hl, $40FA
    ld b, $15
    rst $10
    ret

Jump_033_5615::
    ld hl, $675F
    ld b, $1B
    rst $10
    ret

Func_033_561C::
    ld hl, $67A5
    ld b, $1B
    rst $10
    ret

Func_033_5623::
    ld hl, $67F0
    ld b, $1B
    rst $10
    ret

Func_033_562A::
    ld de, $62C3
    ld hl, $C36E
    ld bc, $0A0B
    call Func_033_6152
    ld hl, $D781
    inc [hl]
    ret

Jump_033_563B::
    ld a, [$C52B]
    and a, a
    ret nz
    ld a, [$D7AB]
    ld b, $BB
    ld hl, $63EF
    call Func_033_60C3
    ld de, $C895
    ld hl, $C3B1
    call Func_033_61FB
    call Func_033_60D3
    ld bc, $140D
    ld de, $01CC
    call Func_033_60FC
    ld a, [$D7AB]
    ld b, $C3
    ld hl, $63EF
    call Func_033_60C3
    call Func_033_6049
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_033_5676::
    ld a, [$C58F]
    cp a, $FE
    jr nz, Jump_033_5694
    ld a, $02
    ld [$D780], a
    xor a, a
    ld [$D781], a
    ld [$D782], a
    ld a, $0A
    call Func_033_5550
    ld a, $FE
    ld [$C594], a
    ret

Jump_033_5694::
    xor a, a
    ld [$D7F9], a
    ld hl, $66B6
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_033_56B8
    cp a, $FC
    jr z, Jump_033_56B8
    cp a, $FD
    jr z, Jump_033_56C1
    cp a, $FE
    jr z, Jump_033_56CA
    cp a, $FF
    jr z, Jump_033_56E1
    ret

Jump_033_56B8::
    ld a, [$D781]
    sub a, $07
    ld [$D781], a
    ret

Jump_033_56C1::
    ld a, [$D781]
    sub a, $04
    ld [$D781], a
    ret

Jump_033_56CA::
    ld a, $02
    ld [$D780], a
    ld a, $09
    call Func_033_5550
    xor a, a
    ld [$D781], a
    ld [$D782], a
    ld a, $FE
    ld [$C594], a
    ret

Jump_033_56E1::
    call Func_033_6060
    ld a, [$D7AB]
    ld b, $BC
    ld hl, $63EF
    call Func_033_60C3
    call Func_033_6074
    ld hl, $D781
    inc [hl]
    ld a, $02
    call Func_033_6039
    ret

Jump_033_56FC::
    ld a, [$C52B]
    and a, a
    ret nz
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
    ld a, $1E
    ld [$C529], a
    ld hl, $481A
    ld b, $1B
    rst $10
    ld a, $6C
    call Func_000_1278
    ld de, $63C7
    ld hl, $C410
    ld bc, $0805
    call Func_033_6152
    call Func_033_60D3
    ld bc, $140D
    ld de, $01CC
    call Func_033_60FC
    call Func_033_6049
    xor a, a
    ld [$D7AD], a
    ld hl, $D781
    inc [hl]
    ret

Jump_033_574F::
    ld a, [$C58F]
    cp a, $FE
    jr nz, Jump_033_576D
    ld a, $02
    ld [$D780], a
    xor a, a
    ld [$D781], a
    ld [$D782], a
    ld a, $0A
    call Func_033_5550
    ld a, $FE
    ld [$C594], a
    ret

Jump_033_576D::
    xor a, a
    ld [$D7F5], a
    ld hl, $4D24
    ld b, $0D
    rst $10
    ld a, [$D7F5]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_033_5785
    cp a, $FF
    jr z, Jump_033_578A
    ret

Jump_033_5785::
    ld hl, $D781
    inc [hl]
    ret

Jump_033_578A::
    ld a, [$D7AD]
    and a, a
    jr nz, Jump_033_57A9
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

Jump_033_57A9::
    call Func_033_6060
    ld hl, $D781
    inc [hl]
    inc [hl]
    ret

Jump_033_57B2::
    ld a, [$C52B]
    and a, a
    ret nz
    ld c, $05
    ld hl, $63EF
    call Func_033_6227
    call Func_033_5F83
    call Func_033_60D3
    ld bc, $140D
    ld de, $01CC
    call Func_033_60FC
    ld a, $08
    call Func_033_5550
    ld a, [$D781]
    sub a, $03
    ld [$D781], a
    ret

Jump_033_57DC::
    call Func_033_5F83
    call Func_033_60D3
    ld bc, $140D
    ld de, $01CC
    call Func_033_60FC
    ld hl, $D7DC
    inc [hl]
    ld a, $0C
    call Func_033_6039
    call Func_033_60A7
    ret

Jump_033_57F8::
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld a, [$D7DD]
    ld c, $00
    call Func_000_1FD1
    ld de, $C986
    ld a, e
    ld [$C595], a
    ld a, d
    ld [$C596], a
    ld b, $A5

Jump_033_5816::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_033_5816
    ld de, $CA2B
    ld a, e
    ld [$C590], a
    ld a, d
    ld [$C591], a
    xor a, a
    ld [$0100], a
    xor a, a
    ld [$C94B], a
    ld a, $01
    ld [$C594], a
    ld hl, $D781
    inc [hl]
    ret

Jump_033_5839::
    ld a, [$C58F]
    cp a, $01
    jr z, Jump_033_585A
    cp a, $FE
    ret nz
    ld a, $02
    ld [$D780], a
    xor a, a
    ld [$D781], a
    ld [$D782], a
    ld a, $0A
    call Func_033_5550
    ld a, $FE
    ld [$C594], a
    ret

Jump_033_585A::
    ld hl, $00A5
    ld a, l
    ld [$C592], a
    ld a, h
    ld [$C593], a
    ld a, $FF
    ld [$C594], a
    ld a, $01
    ld [$C58C], a
    ld hl, $D781
    inc [hl]
    ret

Jump_033_5874::
    ld a, [$C58F]
    cp a, $F0
    ret nz
    ld hl, $D780
    inc [hl]
    xor a, a
    ld [$D781], a
    ret

Jump_033_5883::
    ld a, [$D781]
    rst $00
    dw Jump_033_58AB
    dw Jump_033_58CD
    dw Jump_033_58D7
    dw Jump_033_5902
    dw Jump_033_5911
    dw Jump_033_59B9
    dw Jump_033_59D3
    dw Jump_033_5A58
    dw Jump_033_5A72
    dw Jump_033_5AAF
    dw Jump_033_5AB9
    dw Jump_033_5AC8
    dw Jump_033_5AF9
    dw Jump_033_5B38
    dw Jump_033_5B68
    dw Jump_033_5BA5
    dw Jump_033_5BDC
    dw Jump_033_5BE9

Jump_033_58AB::
    ld hl, $D781
    inc [hl]
    xor a, a
    ld [$C594], a
    ld hl, $C895
    ld de, $C597
    ld b, $04
    call Func_033_58C3
    ld hl, $C60C
    ld b, $0B

Func_033_58C3::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Func_033_58C3
    ld a, $01
    ld [de], a
    ret

Jump_033_58CD::
    ld a, $01
    ld [$C594], a
    ld hl, $D781
    inc [hl]
    ret

Jump_033_58D7::
    ld a, [$C58F]
    cp a, $01
    ret nz
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
    ld a, $10
    ld [$C592], a
    ld a, $FF
    ld [$C594], a
    ld hl, $D781
    inc [hl]
    ret

Jump_033_5902::
    ld a, [$C58F]
    cp a, $F0
    ret nz
    xor a, a
    ld [$C594], a
    ld hl, $D781
    inc [hl]
    ret

Jump_033_5911::
    ld de, $6331
    ld hl, $C364
    ld bc, $0A0B
    call Func_033_6152
    ld hl, $9050
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
    ld de, $C8CF
    ld hl, $C5BB
    ld bc, $000A
    call Func_000_0952
    ld a, $F0
    ld [$C8D9], a
    ld de, $9050
    call Func_000_21A1
    ld a, [$C5C6]
    ld [$C963], a
    ld de, $C5B7
    ld hl, $C3A7
    call Func_033_61FB
    ld hl, $9300
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0E01
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    xor a, a
    ld [$C528], a
    ld a, $20
    ld [$C529], a
    ld hl, $481A
    ld b, $1B
    rst $10
    ld de, $63F9
    ld hl, $C3E7
    ld bc, $0907
    call Func_033_6152
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
    ld a, $01
    ld [$C528], a
    ld [$C529], a
    ld hl, $400F
    ld b, $07
    rst $10
    call Func_033_6049
    ld hl, $D781
    inc [hl]
    ret

Jump_033_59B9::
    call Func_033_60D3
    ld bc, $140D
    ld de, $01CC
    call Func_033_60FC
    ld a, $0D
    call Func_033_5550
    xor a, a
    ld [$D7FA], a
    ld hl, $D781
    inc [hl]
    ret

Jump_033_59D3::
    ld a, [$C58F]
    cp a, $FE
    jr nz, Jump_033_59F1
    ld a, $02
    ld [$D780], a
    xor a, a
    ld [$D781], a
    ld [$D782], a
    ld a, $0A
    call Func_033_5550
    ld a, $FE
    ld [$C594], a
    ret

Jump_033_59F1::
    ld hl, $5842
    ld b, $F1
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_033_5A05
    cp a, $FF
    jr z, Jump_033_5A1C
    ret

Jump_033_5A05::
    ld a, $02
    ld [$D780], a
    ld a, $09
    call Func_033_5550
    xor a, a
    ld [$D781], a
    ld [$D782], a
    ld a, $FE
    ld [$C594], a
    ret

Jump_033_5A1C::
    ld a, [$D7FA]
    and a, a
    jr z, Jump_033_5A28
    cp a, $01
    jr z, Jump_033_5A2D
    jr Jump_033_5A05

Jump_033_5A28::
    ld hl, $D781
    inc [hl]
    ret

Jump_033_5A2D::
    ld a, [$D780]
    ld [$D7B2], a
    ld a, [$D781]
    ld [$D7B3], a
    ld a, $0D
    ld [$D780], a
    ld a, [$D7AB]
    ld [$D7B5], a
    ld a, [$D7AF]
    ld [$D7B6], a
    xor a, a
    ld [$D7AB], a
    ld [$D7AF], a
    ld [$D781], a
    ld [$D782], a
    ret

Jump_033_5A58::
    ld de, $C198
    ld hl, $C364
    ld bc, $0104
    call Func_000_0952
    ld a, $0E
    call Func_033_5550
    xor a, a
    ld [$C594], a
    ld hl, $D781
    inc [hl]
    ret

Jump_033_5A72::
    ld a, [$C58F]
    cp a, $FE
    jr nz, Jump_033_5A90
    ld a, $02
    ld [$D780], a
    xor a, a
    ld [$D781], a
    ld [$D782], a
    ld a, $0A
    call Func_033_5550
    ld a, $FE
    ld [$C594], a
    ret

Jump_033_5A90::
    ld a, [$C52B]
    or a, a
    ret nz
    ld a, [$C552]
    and a, $01
    jr z, Jump_033_5AAA
    ld a, $0D
    call Func_033_5550
    ld hl, $D781
    dec [hl]
    ld hl, $D781
    dec [hl]
    ret

Jump_033_5AAA::
    ld hl, $D781
    inc [hl]
    ret

Jump_033_5AAF::
    ld hl, $D781
    inc [hl]
    ld a, $0C
    call Func_033_5550
    ret

Jump_033_5AB9::
    ld a, [$C52B]
    and a, a
    ret nz
    ld hl, $D781
    inc [hl]
    ld a, $01
    ld [$C594], a
    ret

Jump_033_5AC8::
    ld a, [$C58F]
    cp a, $FE
    jr z, Jump_033_5AD4
    cp a, $01
    jr z, Jump_033_5AEB
    ret

Jump_033_5AD4::
    ld a, $02
    ld [$D780], a
    xor a, a
    ld [$D781], a
    ld [$D782], a
    ld a, $0A
    call Func_033_5550
    ld a, $FE
    ld [$C594], a
    ret

Jump_033_5AEB::
    xor a, a
    ld [$C594], a
    ld hl, $D781
    inc [hl]
    ld a, $1A
    call Func_033_5550
    ret

Jump_033_5AF9::
    ld a, [$C52B]
    and a, a
    ret nz
    ld hl, $D781
    inc [hl]
    ld a, [$C617]
    ld [$D09D], a
    ld a, [$C618]
    ld [$D09E], a
    ld a, [$C619]
    ld [$D09F], a
    ld hl, $760B
    ld b, $02
    rst $10
    ld a, [$D09D]
    ld [$C617], a
    ld a, [$D09E]
    ld [$C618], a
    ld a, [$D09F]
    ld [$C619], a
    ld hl, $7688
    ld b, $02
    rst $10
    ld a, $05
    ld [$C594], a
    ret

Jump_033_5B38::
    ld a, [$C58F]
    cp a, $05
    ret nz
    xor a, a
    ld [$C594], a
    ld hl, $C5BB
    ld de, $D05A
    ld bc, $000B
    call Func_000_0952
    ld hl, $5D84
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld a, [hl]
    ld [$D065], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_033_5B68::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ld a, [$C5E7]
    ld [$C59A], a
    ld a, [$C5E8]
    ld [$C59B], a
    ld hl, $C59A
    ld a, l
    ld [$C595], a
    ld a, h
    ld [$C596], a
    ld hl, $C5BA
    ld a, l
    ld [$C590], a
    ld a, h
    ld [$C591], a
    ld a, $02
    ld [$C592], a
    xor a, a
    ld [$C593], a
    ld a, $FF
    ld [$C594], a
    ld a, $01
    ld [$C58C], a
    ret

Jump_033_5BA5::
    ld a, [$C58F]
    cp a, $F0
    ret nz
    xor a, a
    ld [$C594], a
    xor a, a
    ld [$C58C], a
    ld a, [$C57F]
    bit 1, a
    jr nz, Jump_033_5BC8
    ld a, [$C5E7]
    ld [$C5BA], a
    ld a, [$C5E8]
    ld [$C5BB], a
    jr Jump_033_5BD4

Jump_033_5BC8::
    ld a, [$C5BA]
    ld [$C5E7], a
    ld a, [$C5BB]
    ld [$C5E8], a

Jump_033_5BD4::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_033_5BDC::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ld a, $D2
    ld [$C594], a
    ret

Jump_033_5BE9::
    ld a, [$C58F]
    cp a, $D2
    ret nz
    xor a, a
    ld [$C594], a
    ld a, $07
    ld [$C5DB], a
    xor a, a
    ld [$C5DC], a
    ld [$C5DD], a
    ld [$C5DE], a
    ld a, $01
    ld [$C5DF], a
    ld a, $07
    ld [$C581], a
    ld a, $00
    ld [$C582], a
    xor a, a
    ld [$C594], a
    xor a, a
    ld [$C58F], a
    ret

Jump_033_5C1A::
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

Jump_033_5C36::
    ld hl, $4AD0
    ld b, $F1
    rst $10
    ld a, [$D780]
    cp a, $0E
    ret nz
    ld a, [$D7B5]
    ld [$D7AB], a
    ld a, [$D7B6]
    ld [$D7AF], a
    ret

Jump_033_5C4F::
    ld a, [$D781]
    rst $00
    dw Jump_033_5C63
    dw Jump_033_5CA7
    dw Jump_033_5CA7
    dw Jump_033_5CAC
    dw Jump_033_5D79
    dw Jump_033_5D80
    dw Jump_033_5DDF
    dw Jump_033_5E23

Jump_033_5C63::
    ld hl, $7205
    ld b, $1B
    rst $10
    ld de, $6331
    ld hl, $C364
    ld bc, $0A0B
    call Func_033_6152
    call Func_033_6247
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
    ld a, $01
    ld [$C528], a
    ld [$C529], a
    ld hl, $400F
    ld b, $07
    rst $10
    call Func_033_6049
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_033_5CA7::
    ld hl, $D781
    inc [hl]
    ret

Jump_033_5CAC::
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
    ld hl, $7A48
    ld b, $16
    rst $10
    xor a, a
    ld [$1FFF], a
    ld de, $5D5F
    ld hl, $C440
    ld bc, $0D02
    call Func_033_6152
    pop af
    ld [$D7F1], a
    ld hl, $C443
    ld a, l
    ld [$D7F2], a
    ld a, h
    ld [$D7F3], a
    ld a, [$D7F1]
    ld b, a
    ld a, [$D7F2]
    ld l, a
    ld a, [$D7F3]
    ld h, a
    push bc
    push hl
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld a, b
    ld c, $56
    call Func_000_1F80
    ldh a, [$FFC6]
    ld l, a
    ld h, $00
    call Func_000_16F5
    ld hl, $75B3
    ld b, $1E
    rst $10
    ld a, [$C8C1]
    add a, $E0
    pop hl
    push hl
    ld [hl+], a
    ld a, [$C8C2]
    add a, $E0
    ld [hl+], a
    pop hl
    pop bc
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    push hl
    ld a, b
    ld c, $0E
    ld b, $01
    call Func_000_1F80
    ldh a, [$FFC6]
    and a, $01
    add a, $CC
    pop hl
    ld [hl], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret
    db $B6, $EA, $ED, $C3, $C3, $F8, $F9, $FA, $FB, $FC, $C3, $C7, $B7, $B3, $B4, $B4
    db $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Jump_033_5D79::
    ld hl, $67F0
    ld b, $1B
    rst $10
    ret

Jump_033_5D80::
    ld de, $62C3
    ld hl, $C36E
    ld bc, $0A0B
    call Func_033_6152
    ld de, $C895
    ld hl, $C3B1
    call Func_033_61FB
    ld de, $6331
    ld hl, $C364
    ld bc, $0A0B
    call Func_033_6152
    ld de, $C5B7
    ld hl, $C3A7
    call Func_033_61FB
    ld hl, $9050
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
    ld de, $C8CF
    ld hl, $C5BB
    ld bc, $000A
    call Func_000_0952
    ld a, $F0
    ld [$C8D9], a
    ld de, $9050
    call Func_000_21A1
    ld hl, $D781
    inc [hl]
    ret

Jump_033_5DDF::
    ld hl, $9300
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0E01
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    xor a, a
    ld [$C528], a
    ld a, $20
    ld [$C529], a
    ld hl, $481A
    ld b, $1B
    rst $10
    ld de, $63F9
    ld hl, $C3E7
    ld bc, $0907
    call Func_033_6152
    call Func_033_6074
    call Func_033_6049
    ld a, $01
    ld [$D7FA], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_033_5E23::
    call Func_033_60D3
    ld bc, $140D
    ld de, $01CC
    call Func_033_60FC
    call Func_033_60D3
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call Func_033_60FC
    ld a, $70
    ldh [$FFBA], a
    xor a, a
    ld [$D782], a
    ld a, [$D7B2]
    ld [$D780], a
    ld a, [$D7B3]
    ld [$D781], a
    call Func_033_6049
    ret

Jump_033_5E57::
    ld a, [$D781]
    rst $00
    dw Jump_033_5E6B
    dw Jump_033_5E97
    dw Jump_033_5EC6
    dw Jump_033_5E93
    dw Jump_033_5ED7
    dw Jump_033_5EDB
    dw Jump_033_5EDF
    dw Jump_033_5F37

Jump_033_5E6B::
    ld hl, $7205
    ld b, $1B
    rst $10
    ld de, $6438
    ld hl, $C364
    ld bc, $080B
    call Func_033_6152
    ld a, [$D7AB]
    ld b, $BC
    ld hl, $63EF
    call Func_033_60C3
    call Func_033_6247
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_033_5E93::
    call Func_033_561C
    ret

Jump_033_5E97::
    call Func_033_5F99
    ld hl, $7163
    ld b, $1E
    rst $10
    ld a, [$D7B0]
    cp a, $02
    jr c, Jump_033_5EBE
    ld hl, $C42E
    call Func_033_629D
    ld hl, $C42F
    ld a, h
    ld [$D7F1], a
    ld a, l
    ld [$D7F2], a
    ld hl, $759A
    ld b, $1E
    rst $10

Jump_033_5EBE::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_033_5EC6::
    ld hl, $5C15
    ld b, $1F
    rst $10
    xor a, a
    ld [$D7F1], a
    ld hl, $6AA5
    ld b, $1D
    rst $10
    ret

Jump_033_5ED7::
    call Func_033_5623
    ret

Jump_033_5EDB::
    call Func_033_562A
    ret

Jump_033_5EDF::
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
    ld a, $1E
    ld [$C529], a
    ld hl, $481A
    ld b, $1B
    rst $10
    call Func_033_6074
    call Func_033_6049
    xor a, a
    ld a, $12
    ld [$C529], a
    ld hl, $481A
    ld b, $1B
    rst $10
    ld de, $C895
    ld hl, $C3B1
    call Func_033_61FB
    ld de, $63C7
    ld hl, $C410
    ld bc, $0805
    call Func_033_6152
    xor a, a
    ld [$D7AD], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_033_5F37::
    call Func_033_60D3
    ld bc, $140D
    ld de, $01CC
    call Func_033_60FC
    call Func_033_60D3
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call Func_033_60FC
    ld a, $70
    ldh [$FFBA], a
    xor a, a
    ld [$D782], a
    ld a, [$D7B2]
    ld [$D780], a
    ld a, [$D7B3]
    ld [$D781], a
    call Func_033_6049
    ret

Func_033_5F6B:: ; heuristic: follows a terminator; C0
    ld hl, $D7DD
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld a, [hl]
    call Func_000_1F80
    xor a, a
    ld [$1FFF], a
    ld [$4100], a
    ret

Func_033_5F83::
    ld de, $639F
    ld hl, $C410
    ld bc, $0805
    call Func_033_6152
    ld de, $C895
    ld hl, $C3B1
    call Func_033_61FB
    ret

Func_033_5F99::
    ld hl, $D789
    ld b, $1E

Jump_033_5F9E::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_033_5F9E
    ld hl, $D7BE
    ld b, $1E

Jump_033_5FA8::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_033_5FA8
    xor a, a
    ld [$D7A9], a
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld [$D7B9], a
    ld de, $A000
    ld hl, $D789
    ld b, $00
    ld c, $00

Jump_033_5FC7::
    ld a, [de]
    and a, a
    jr z, Jump_033_601D
    cp a, $01
    jr z, Jump_033_5FDD
    ld a, [$D7DC]
    cp a, $03
    jr z, Jump_033_601D
    ld a, [de]
    cp a, $02
    jr z, Jump_033_5FDD
    jr Jump_033_601D

Jump_033_5FDD::
    push de
    ld a, $6E
    add a, e
    ld e, a
    jr nc, Jump_033_5FE5
    inc d

Jump_033_5FE5::
    ld a, [de]
    and a, a
    jr nz, Jump_033_6015
    pop de
    ld a, [$D7DC]
    and a, a
    jr z, Jump_033_6010
    cp a, $03
    jr nc, Jump_033_6010
    push hl
    push de
    push bc
    ld d, b
    ld hl, $D7DD
    ld a, [$D7DC]
    ld b, a

Jump_033_5FFF::
    ld a, [hl+]
    cp a, d
    jr z, Jump_033_600B
    dec b
    jr nz, Jump_033_5FFF
    pop bc
    pop de
    pop hl
    jr Jump_033_6010

Jump_033_600B::
    pop bc
    pop de
    pop hl
    jr Jump_033_601D

Jump_033_6010::
    inc c
    ld a, b
    ld [hl+], a
    jr Jump_033_601D

Jump_033_6015::
    pop de
    ld a, [$D7B9]
    inc a
    ld [$D7B9], a

Jump_033_601D::
    ld a, $A5
    add a, e
    ld e, a
    jr nc, Jump_033_6024
    inc d

Jump_033_6024::
    inc b
    ld a, b
    cp a, $1E
    jr c, Jump_033_5FC7
    ld a, c
    ld [$D7A9], a
    xor a, a
    ld [$1FFF], a
    ld hl, $5F9C
    ld b, $1D
    rst $10
    ret

Func_033_6039::
    add a, $10
    ld [$C529], a
    xor a, a
    ld [$C528], a
    ld hl, $480C
    ld b, $1B
    rst $10
    ret

Func_033_6049::
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

Func_033_6060::
    ld hl, $5D84
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld de, $D7DD
    ld a, [hl]
    ld [de], a
    ret

Func_033_6074::
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
    ld c, $01
    call Func_000_1FA4
    ld hl, $C8CF
    ld de, $C130
    ld b, $0B

Jump_033_6099::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_033_6099
    xor a, a
    ld [$4100], a
    ld [$0100], a
    ret

Func_033_60A7::
    ld a, [$D7DC]
    ld [$D7B4], a
    ld a, $FF
    ld [$D7E0], a
    ld a, $04
    ld [$D7DC], a
    xor a, a
    ld [$D782], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_033_60C3::
    push bc
    sla a
    add a, l
    ld l, a
    jr nc, Jump_033_60CB
    inc h

Jump_033_60CB::
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    pop bc
    ld a, b
    ld [de], a
    ret

Func_033_60D3::
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
    jr nc, Jump_033_60F7
    inc d

Jump_033_60F7::
    ld a, e
    ld l, a
    ld a, d
    ld h, a
    ret

Func_033_60FC::
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

Func_033_6152::
    push hl
    push bc

Jump_033_6154::
    push hl
    push bc

Jump_033_6156::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_033_6156
    pop bc
    pop hl
    ld a, l
    add a, $14
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec c
    jp nz, Jump_033_6154
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

Jump_033_617D::
    push hl
    push bc

Jump_033_617F::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_033_617F
    pop bc
    pop hl
    ld a, l
    add a, $14
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec c
    jp nz, Jump_033_617D
    ld a, $00
    ldh [$FF70], a
    ret

Func_033_6197::
    ld a, [$C617]
    ld l, a
    ld a, [$C618]
    ld h, a
    ld a, l
    ld [$C8C0], a
    ld a, h
    ld [$C8C1], a
    ld a, [$C619]
    ld [$C8C2], a
    call Func_000_173A
    ld c, $00
    ld hl, $C1BA
    ldh a, [$FFC8]
    and a, $0F
    jr z, Jump_033_61C0
    add a, $E0
    ld [hl], a
    set 0, c

Jump_033_61C0::
    inc hl
    ldh a, [$FFC7]
    swap a
    and a, $0F
    jr nz, Jump_033_61CD
    bit 0, c
    jr z, Jump_033_61D2

Jump_033_61CD::
    add a, $E0
    ld [hl], a
    set 0, c

Jump_033_61D2::
    inc hl
    ldh a, [$FFC7]
    and a, $0F
    jr nz, Jump_033_61DD
    bit 0, c
    jr z, Jump_033_61E2

Jump_033_61DD::
    add a, $E0
    ld [hl], a
    set 0, c

Jump_033_61E2::
    inc hl
    ldh a, [$FFC6]
    swap a
    and a, $0F
    jr nz, Jump_033_61EF
    bit 0, c
    jr z, Jump_033_61F2

Jump_033_61EF::
    add a, $E0
    ld [hl], a

Jump_033_61F2::
    inc hl
    ldh a, [$FFC6]
    and a, $0F
    add a, $E0
    ld [hl], a
    ret

Func_033_61FB::
    call Func_033_6204
    call Func_033_6204
    call Func_033_6204

Func_033_6204::
    push hl
    ld a, [de]
    inc de
    ld l, a
    ld h, $00
    call Func_000_16F5
    pop hl
    ld a, [$C8C1]
    or a, a
    jr z, Jump_033_6217
    add a, $E0
    ld [hl], a

Jump_033_6217::
    inc hl
    ld a, [$C8C2]
    add a, $E0
    ld [hl], a
    ld a, l
    add a, $27
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ret

Func_033_6227::
    ld a, c
    ld b, a
    ld c, $00

Jump_033_622B::
    ld a, c
    push bc
    ld b, $C3
    push hl
    push bc
    sla a
    add a, l
    ld l, a
    jr nc, Jump_033_6238
    inc h

Jump_033_6238::
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    pop bc
    ld a, b
    ld [de], a
    pop hl
    pop bc
    inc c
    ld a, c
    cp a, b
    jr c, Jump_033_622B
    ret

Func_033_6247::
    ld hl, $9000
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
    ld de, $C8CF
    ld hl, $C60C
    ld bc, $000A
    call Func_000_0952
    ld a, $F0
    ld [$C8D9], a
    ld de, $9000
    call Func_000_21A1
    ld hl, $9100
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $1001
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld a, $01
    ld [$C528], a
    xor a, a
    ld [$C529], a
    ld hl, $400F
    ld b, $07
    rst $10
    ret

Func_033_629D::
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
    INCBIN "dwm2-cobi-us.gbc", $0CE2AB, $B7

Data_033_6362:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0CE362, $12E

Func_033_6490::
    ld de, $64A5
    call Func_000_25C9
    ret
    db $11, $A5, $64, $CD, $FE, $25, $C9

Func_033_649E::
    call Func_033_6490
    call Func_000_2611
    ret
    INCBIN "dwm2-cobi-us.gbc", $0CE4A5, $BF

Data_033_6564:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0CE564, $202

Data_033_6766:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0CE766, $202

Data_033_6968:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0CE968, $202

Data_033_6B6A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0CEB6A, $202

Data_033_6D6C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0CED6C, $202

Data_033_6F6E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0CEF6E, $C9

Func_033_7037::
    ld de, $704C
    call Func_000_25C9
    ret
    db $11, $4C, $70, $CD, $FE, $25, $C9

Func_033_7045::
    call Func_033_7037
    call Func_000_2611
    ret
    db $4E, $70
    dw Data_033_7074
    dw Data_033_7089
    dw Data_033_70A7
    dw Data_033_70BE
    dw Data_033_70D0
    dw Data_033_70DE
    dw Data_033_711F
    dw Data_033_7157
    dw Data_033_716A
    dw Data_033_717D
    dw Data_033_718F
    dw Data_033_71A2
    dw Data_033_71AD
    dw Data_033_71B3
    dw Data_033_71BE
    dw Data_033_71BE
    dw Data_033_71BE
    dw Data_033_71BE
    dw Data_033_71D1

Data_033_7074:: ; heuristic: target of a monotone pointer table; C0
    db $12, $37, $90, $28, $31, $27, $36, $90, $2C, $31, $90, $24, $90, $27, $35, $24
    db $3A, $99, $FA, $F7, $F0

Data_033_7089:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $32, $31, $2A, $35, $24, $37, $38, $2F, $24, $37, $2C, $32, $31, $36, $99
    db $F1, $22, $32, $38, $42, $28, $90, $3A, $32, $31, $99, $FA, $F7, $F0

Data_033_70A7:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $32, $32, $90, $25, $24, $27, $99, $F1, $22, $32, $38, $42, $28, $90, $2F
    db $32, $36, $37, $99, $FA, $F7, $F0

Data_033_70BE:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $38, $35, $31, $28, $27, $90, $32, $39, $28, $35, $F1, $F9, $00, $A4, $FA
    db $F7, $F0

Data_033_70D0:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $26, $28, $2C, $39, $28, $27, $F1, $F9, $00, $FA, $F7, $F0

Data_033_70DE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0CF0DE, $41

Data_033_711F:: ; heuristic: target of a monotone pointer table; C0
    db $10, $24, $39, $28, $90, $38, $33, $90, $32, $31, $90, $2A, $28, $37, $37, $2C
    db $31, $2A, $F1, $F9, $00, $90, $24, $31, $27, $90, $35, $28, $2F, $28, $24, $36
    db $28, $27, $FA, $F7, $EF, $EE, $2C, $37, $90, $2C, $31, $90, $37, $2B, $28, $90
    db $3A, $2C, $2F, $27, $A4, $FA, $F7, $F0

Data_033_7157:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $3A, $2C, $37, $26, $2B, $90, $3A, $2C, $37, $2B, $90, $3A, $2B, $2C, $26
    db $2B, $98, $F0

Data_033_716A:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $3A, $2C, $37, $26, $2B

Data_033_7170:: ; heuristic: target of a monotone pointer table; C0
    db $90, $3A, $2C, $37, $2B, $90, $3A, $2B, $2C, $26, $2B, $98, $F0

Data_033_717D:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $3A, $2C, $37, $26, $2B, $90, $3A, $2B, $2C, $26, $2B, $90, $28, $2A, $2A
    db $98, $F0

Data_033_718F:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $F1, $3A, $24, $36, $90, $35, $28, $2F, $28, $24, $36, $28, $27, $B5
    db $FA, $F7, $F0

Data_033_71A2:: ; heuristic: target of a monotone pointer table; C0
    db $16, $32, $31, $36, $37, $28, $35, $0E, $98, $2A, $F0

Data_033_71AD:: ; heuristic: target of a monotone pointer table; C0
    db $22, $28, $36, $17, $32, $F0

Data_033_71B3:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $29, $32, $18, $14, $22, $28, $36, $17, $F0

Data_033_71BE:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $35, $28, $90, $24, $35, $28, $90, $31, $32, $90, $28, $2A, $2A
    db $36, $B5, $F0

Data_033_71D1:: ; heuristic: target of a monotone pointer table; C0
    db $22, $32, $38, $43, $2F, $90, $25, $28, $90, $2F, $28, $29, $37, $F1, $3A, $2C
    db $37, $2B, $90, $31, $32, $90, $30, $32, $31, $36, $37, $28, $35, $B5, $F0
    ds $182, $00

Data_033_7372:: ; heuristic: target of a monotone pointer table; C0
    ds $202, $00

Data_033_7574:: ; heuristic: target of a monotone pointer table; C0
    ds $202, $00

Data_033_7776:: ; heuristic: target of a monotone pointer table; C0
    ds $202, $00

Data_033_7978:: ; heuristic: target of a monotone pointer table; C0
    ds $202, $00

Data_033_7B7A:: ; heuristic: target of a monotone pointer table; C0
    ds $202, $00

Data_033_7D7C:: ; heuristic: target of a monotone pointer table; C0
    ds $202, $00

Data_033_7F7E:: ; heuristic: target of a monotone pointer table; C0
    ds $82, $00
