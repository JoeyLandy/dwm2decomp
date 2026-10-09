SECTION "Bank 33", ROMX[$4000], BANK[$33]
    db $33

Func_033_4001::
    ld d, $00
    ld hl, Data_033_405F
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
    ld hl, wC198
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
    ld hl, Data_033_405F
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
    ld hl, wC198
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

Data_033_405F:: ; heuristic: pointer load in the same bank (bank assumed); C0
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

; LZSS-compressed asset: 11 bytes expand to 8 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_033_4111:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0CC111, $A0

; LZSS-compressed asset: 342 bytes expand to 353 (tools/lzss_gfx.py, E-0016/E-0017; C1)
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

; LZSS-compressed asset: 424 bytes expand to 424 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_033_41D9:: ; heuristic: target of a monotone pointer table; C0
    db $A8, $01, $0C, $05, $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $F9, $FA, $ED, $C3, $C3, $C3, $BE, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $FB, $FA, $ED, $C3, $C3, $C3, $BE
    db $C3, $C3, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; LZSS-compressed asset: 11 bytes expand to 8 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_033_4219:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0CC219, $88

; LZSS-compressed asset: 342 bytes expand to 352 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_033_42A1:: ; heuristic: target of a monotone pointer table; C0
    db $60, $01, $08, $07, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B0, $B1, $B1, $B1
    db $B1, $B1, $B1, $B2, $B6, $35, $36, $37, $38, $39, $3A, $B7, $B6, $C3, $C3, $C3
    db $C3, $C3, $C3, $B7, $B6, $3B, $3C, $3D, $3E, $3F, $40, $B7, $B3, $B4, $B4, $B4
    db $B4, $B4, $B4, $B5, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3

; LZSS-compressed asset: 362 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_033_42DD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0CC2DD, $58

; LZSS-compressed asset: 11 bytes expand to 8 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_033_4335:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0CC335, $DC

; LZSS-compressed asset: 342 bytes expand to 352 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_033_4411:: ; heuristic: target of a monotone pointer table; C0
    db $60, $01, $08, $07
    ds $38, $C3

; LZSS-compressed asset: 11 bytes expand to 8 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_033_444D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0CC44D, $DC

; LZSS-compressed asset: 390 bytes expand to 387 (tools/lzss_gfx.py, E-0016/E-0017; C1)
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

; LZSS-compressed asset: 11 bytes expand to 8 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_033_479F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0CC79F, $70

; LZSS-compressed asset: 322 bytes expand to 320 (tools/lzss_gfx.py, E-0016/E-0017; C1)
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

; LZSS-compressed asset: 64 bytes expand to 64 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_033_489F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0CC89F, $6A

; LZSS-compressed asset: 259 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_033_4909:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $06, $05, $B0, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $CE, $CF, $DF, $B7
    db $B6, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $A5, $F4, $C3, $B7, $B3, $B4, $B4, $B4
    db $B4, $B5

; LZSS-compressed asset: 418 bytes expand to 416 (tools/lzss_gfx.py, E-0016/E-0017; C1)
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

; LZSS-compressed asset: 291 bytes expand to 288 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_033_49DF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0CC9DF, $4A

Data_033_4A29:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0CCA29, $4C

; LZSS-compressed asset: 291 bytes expand to 288 (tools/lzss_gfx.py, E-0016/E-0017; C1)
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

; LZSS-compressed asset: 9 bytes expand to 6 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_033_4C40:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0CCC40, $66

; LZSS-compressed asset: 296 bytes expand to 293 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_033_4CA6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0CCCA6, $8B

Data_033_4D31:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $07, $07, $B0, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $FD, $02, $FE, $FF
    db $C3, $B7, $B8, $B9, $B9, $B9, $B9, $B9, $BA, $B6, $C3, $00, $DF, $CF, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $FF, $F4, $DF, $DF, $B7, $B3, $B4
    db $B4, $B4, $B4, $B4, $B5

; LZSS-compressed asset: 223 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_033_4D66:: ; heuristic: target of a monotone pointer table; C0
    db $E0, $00, $06, $05, $B0, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $CE, $CF, $DF, $B7
    db $B6, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $A5, $F4, $C3, $B7, $B3, $B4, $B4, $B4
    db $B4, $B5

; LZSS-compressed asset: 202 bytes expand to 205 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_033_4D88:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $00, $07, $03, $B0, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $D0, $D1, $D2, $D3
    db $D4, $B7, $B3, $B4, $B4, $B4, $B4, $B4, $B5

; LZSS-compressed asset: 300 bytes expand to 297 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_033_4DA1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0CCDA1, $67

; LZSS-compressed asset: 69 bytes expand to 66 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_033_4E08:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0CCE08, $82

; LZSS-compressed asset: 299 bytes expand to 296 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_033_4E8A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0CCE8A, $70

; LZSS-compressed asset: 35 bytes expand to 32 (tools/lzss_gfx.py, E-0016/E-0017; C1)
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

; LZSS-compressed asset: 273 bytes expand to 270 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_033_4FDA:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $01, $06, $05, $B0, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $CE, $CF, $DF, $B7
    db $B6, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $A5, $F4, $C3, $B7, $B3, $B4, $B4, $B4
    db $B4, $B5

; LZSS-compressed asset: 290 bytes expand to 289 (tools/lzss_gfx.py, E-0016/E-0017; C1)
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
    ld a, [wD06A]
    or a, a
    jr nz, Jump_033_51D0
    ret

Jump_033_51D0::
    ld a, [wD780]
    cp a, $0C
    jr z, Jump_033_51DC
    cp a, $0D
    jr z, Jump_033_51FB
    ret

Jump_033_51DC::
    ld a, [wD782]
    and a, a
    ret nz
    ld a, [wD781]
    cp a, $20
    jr z, Jump_033_51F4
    cp a, $15
    jr z, Jump_033_51ED
    ret

Jump_033_51ED::
    farcall Func_01D_5C35
    ret

Jump_033_51F4::
    farcall Func_01D_5BF2
    ret

Jump_033_51FB::
    ld a, [wD781]
    cp a, $15
    jr z, Jump_033_5207
    cp a, $20
    jr z, Jump_033_520E
    ret

Jump_033_5207::
    farcall Func_0F1_5719
    ret

Jump_033_520E::
    farcall Func_0F2_4EDD
    ret

Func_033_5215::
    ld a, [wD06A]
    or a, a
    jr nz, Jump_033_523B
    ld a, [wD06B]
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
    ld a, [wC56C]
    or a, a
    ret nz
    ld a, [wD780]
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
    ld de, Data_033_62AB
    ld hl, wC1A4
    ld bc, $0803
    call Func_033_6152
    ld de, Data_033_62C3
    ld hl, wC198
    ld bc, $0A0B
    call Func_033_6152
    call Func_033_6247
    call Func_033_6049
    ld hl, wD06B
    inc [hl]
    ret

Jump_033_5287::
    xor a, a
    ld [wC594], a
    call Func_033_6197
    ld de, wC895
    ld hl, wC1DB
    call Func_033_61FB
    call Func_033_60D3
    ld bc, $140D
    ld de, $0000
    call Func_033_60FC
    ld hl, wD06B
    inc [hl]
    ret

Jump_033_52A8::
    ld a, [wC56C]
    or a, a
    ret nz
    ld a, $19
    call Func_033_5550
    ld hl, wD06B
    inc [hl]
    xor a, a
    ld [wC594], a
    ret

Jump_033_52BB::
    ld a, [wC58F]
    cp a, $FE
    jr nz, Jump_033_52D7
    ld a, $FE
    ld [wC594], a
    ld a, $01
    ld [wD06A], a
    ld a, $02
    ld [wD780], a
    ld a, $0A
    call Func_033_5550
    ret

Jump_033_52D7::
    ld a, [wC52B]
    or a, a
    ret nz
    ld a, [wC552]
    and a, $01
    jr z, Jump_033_52F8
    ld a, $FE
    ld [wC594], a
    ld a, $01
    ld [wD06A], a
    ld a, $02
    ld [wD780], a
    ld a, $09
    call Func_033_5550
    ret

Jump_033_52F8::
    ld a, [wC617]
    sub a, $E8
    ld c, a
    ld a, [wC618]
    sbc a, $03
    ld b, a
    ld a, [wC619]
    sbc a, $00
    jr nc, Jump_033_531E
    ld a, $00
    call Func_033_5550
    ld a, [wD06B]
    add a, $08
    ld [wD06B], a
    ld a, $10
    ld [wC594], a
    ret

Jump_033_531E::
    ld [wC619], a
    ld a, b
    ld [wC618], a
    ld a, c
    ld [wC617], a
    ld a, $0C
    call Func_033_5550
    ld hl, wD06B
    inc [hl]
    ld a, $01
    ld [wC594], a
    ret

Jump_033_5338::
    ld a, [wC58F]
    cp a, $FE
    jr z, Jump_033_5348
    cp a, $01
    jr z, Jump_033_535D
    cp a, $10
    jr z, Jump_033_536B
    ret

Jump_033_5348::
    ld a, $FE
    ld [wC594], a
    ld a, $01
    ld [wD06A], a
    ld a, $02
    ld [wD780], a
    ld a, $0A
    call Func_033_5550
    ret

Jump_033_535D::
    ld a, $07
    call Func_033_5550
    ld hl, wD06B
    inc [hl]
    xor a, a
    ld [wC594], a
    ret

Jump_033_536B::
    ld a, $01
    call Func_033_5550
    ld hl, wD06B
    inc [hl]
    ld hl, wD06B
    inc [hl]
    ld hl, wD06B
    inc [hl]
    ret

Jump_033_537D::
    xor a, a
    ld [wC594], a
    ld hl, wD06B
    inc [hl]
    xor a, a
    ld [wD06C], a
    ret

Jump_033_538A::
    ld a, [wD06C]
    rst $00
    dw Jump_033_5394
    dw Jump_033_53AC
    dw Jump_033_53C2

Jump_033_5394::
    ld a, [wC52B]
    or a, a
    ret nz
    ld hl, wC198
    ld bc, $0104

Jump_033_539F::
    ld a, $C3
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_033_539F
    ld hl, wD06C
    inc [hl]
    ret

Jump_033_53AC::
    call Func_033_60D3
    ld bc, $140D
    ld de, $0000
    call Func_033_60FC
    ld a, $08
    call Func_033_5550
    ld hl, wD06C
    inc [hl]
    ret

Jump_033_53C2::
    xor a, a
    ld [wD06B], a
    xor a, a
    ld [wD06C], a
    ld a, $01
    ld [wD06A], a
    xor a, a
    ld [wD780], a
    ret

Jump_033_53D4::
    ld a, [wC52B]
    or a, a
    ret nz
    ld a, [wC552]
    and a, $01
    jr z, Jump_033_53F3
    ld a, $05
    call Func_033_5550
    ld a, $40
    ld [wC594], a
    ld hl, wD06B
    inc [hl]
    ld hl, wD06B
    inc [hl]
    ret

Jump_033_53F3::
    ld a, [wC617]
    sub a, $E8
    ld c, a
    ld a, [wC618]
    sbc a, $03
    ld b, a
    ld a, [wC619]
    sbc a, $00
    jr nc, Jump_033_5419
    ld a, $04
    call Func_033_5550
    ld a, $30
    ld [wC594], a
    ld hl, wD06B
    inc [hl]
    ld hl, wD06B
    inc [hl]
    ret

Jump_033_5419::
    ld [wC619], a
    ld a, b
    ld [wC618], a
    ld a, c
    ld [wC617], a
    ld a, $02
    call Func_033_5550
    ld a, $20
    ld [wC594], a
    ld hl, wD06B
    inc [hl]
    ret

Jump_033_5433::
    ld a, [wC58F]
    cp a, $FE
    jr z, Jump_033_5446
    cp a, $20
    ret nz
    ld hl, wD06B
    dec [hl]
    ld hl, wD06B
    dec [hl]
    ret

Jump_033_5446::
    ld a, $FE
    ld [wC594], a
    ld a, $01
    ld [wD06A], a
    ld a, $02
    ld [wD780], a
    ld a, $0A
    call Func_033_5550
    ret

Jump_033_545B::
    ld a, [wC58F]
    cp a, $FE
    jr z, Jump_033_546E
    cp a, $30
    jr z, Jump_033_5469
    cp a, $40
    ret nz

Jump_033_5469::
    ld hl, wD06B
    inc [hl]
    ret

Jump_033_546E::
    ld a, $FE
    ld [wC594], a
    ld a, $01
    ld [wD06A], a
    ld a, $02
    ld [wD780], a
    ld a, $0A
    call Func_033_5550
    ret

Jump_033_5483::
    ld a, $FE
    ld [wC594], a
    ld a, $01
    ld [wD06A], a
    xor a, a
    ld [wD06B], a
    ld a, $02
    ld [wD780], a
    ret

Jump_033_5497::
    ld a, [wC58F]
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
    ld [wC594], a
    ld a, $06
    call Func_033_5550
    ld hl, wD06B
    inc [hl]
    ld hl, wD06B
    inc [hl]
    ret

Jump_033_54BE::
    ld [wC594], a
    ld a, $04
    call Func_033_5550
    ld hl, wD06B
    inc [hl]
    ld hl, wD06B
    inc [hl]
    ret

Jump_033_54CF::
    ld [wC594], a
    ld a, $03
    call Func_033_5550
    ld hl, wD06B
    inc [hl]
    ret

Jump_033_54DC::
    ld [wC594], a
    ld a, $04
    call Func_033_5550
    ld hl, wD06B
    inc [hl]
    ld hl, wD06B
    inc [hl]
    ret

Jump_033_54ED::
    ld a, $FE
    ld [wC594], a
    ld a, $01
    ld [wD06A], a
    ld a, $02
    ld [wD780], a
    ld a, $0A
    call Func_033_5550
    ret

Jump_033_5502::
    ld a, [wC58F]
    cp a, $FE
    jr z, Jump_033_5515
    or a, a
    jr z, Jump_033_550F
    cp a, $20
    ret nz

Jump_033_550F::
    ld a, $05
    ld [wD06B], a
    ret

Jump_033_5515::
    ld a, $FE
    ld [wC594], a
    ld a, $01
    ld [wD06A], a
    ld a, $02
    ld [wD780], a
    ld a, $0A
    call Func_033_5550
    ret

Jump_033_552A::
    ld a, [wC58F]
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
    ld [wC594], a
    ld a, $01
    ld [wD06A], a
    xor a, a
    ld [wD06B], a
    ld a, $02
    ld [wD780], a
    ret

Func_033_5550::
    ld [wC529], a
    ld a, $05
    ld [wC528], a
    farcall Func_007_4001
    ret

Jump_033_555F::
    ld hl, wD780
    inc [hl]
    ret

Jump_033_5564::
    ld a, [wC52B]
    and a, a
    ret nz
    ld hl, wD780
    inc [hl]
    inc [hl]
    ret

Jump_033_556F::
    ld a, [wD781]
    rst $00
    dw Jump_033_557D
    dw Jump_033_558F
    dw Jump_033_559E
    dw Jump_033_55AD
    dw Jump_033_55BC

Jump_033_557D::
    ld a, [wC58F]
    cp a, $FE
    ret nz
    xor a, a
    ld [wC594], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_033_558F::
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, $0C
    call Func_033_6039
    ld hl, wD781
    inc [hl]
    ret

Jump_033_559E::
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, $01
    ld [wC594], a
    ld hl, wD781
    inc [hl]
    ret

Jump_033_55AD::
    ld a, [wC58F]
    cp a, $01
    ret nz
    xor a, a
    ld [wC594], a
    ld hl, wD781
    inc [hl]
    ret

Jump_033_55BC::
    ld a, [wC52B]
    bit 0, a
    ret nz
    ld hl, wD780
    ld bc, $006F

Jump_033_55C8::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_033_55C8
    ld hl, wC5DB
    ld a, $05
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld [hl], a
    ld hl, wC5DF
    inc [hl]
    ret

Jump_033_55E0::
    ld hl, wD780
    inc [hl]
    ret

Jump_033_55E5::
    ld a, [wD781]
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
    ld a, [wC52B]
    and a, a
    ret nz
    farcall Func_015_40FA
    ret

Jump_033_5615::
    farcall Func_01B_675F
    ret

Func_033_561C::
    farcall Func_01B_67A5
    ret

Func_033_5623::
    farcall Func_01B_67F0
    ret

Func_033_562A::
    ld de, Data_033_62C3
    ld hl, wC36E
    ld bc, $0A0B
    call Func_033_6152
    ld hl, wD781
    inc [hl]
    ret

Jump_033_563B::
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, [wD7AB]
    ld b, $BB
    ld hl, Data_033_63EF
    call Func_033_60C3
    ld de, wC895
    ld hl, wC3B1
    call Func_033_61FB
    call Func_033_60D3
    ld bc, $140D
    ld de, $01CC
    call Func_033_60FC
    ld a, [wD7AB]
    ld b, $C3
    ld hl, Data_033_63EF
    call Func_033_60C3
    call Func_033_6049
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_033_5676::
    ld a, [wC58F]
    cp a, $FE
    jr nz, Jump_033_5694
    ld a, $02
    ld [wD780], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $0A
    call Func_033_5550
    ld a, $FE
    ld [wC594], a
    ret

Jump_033_5694::
    xor a, a
    ld [wD7F9], a
    farcall Func_01D_66B6
    ld a, [wD7F9]
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
    ld a, [wD781]
    sub a, $07
    ld [wD781], a
    ret

Jump_033_56C1::
    ld a, [wD781]
    sub a, $04
    ld [wD781], a
    ret

Jump_033_56CA::
    ld a, $02
    ld [wD780], a
    ld a, $09
    call Func_033_5550
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $FE
    ld [wC594], a
    ret

Jump_033_56E1::
    call Func_033_6060
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_033_63EF
    call Func_033_60C3
    call Func_033_6074
    ld hl, wD781
    inc [hl]
    ld a, $02
    call Func_033_6039
    ret

Jump_033_56FC::
    ld a, [wC52B]
    and a, a
    ret nz
    ld hl, vTiles2 + $700
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0C01
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wC528], a
    ld a, $1E
    ld [wC529], a
    farcall Func_01B_481A
    ld a, $6C
    call StoreWC60B
    ld de, Data_033_63C7
    ld hl, wC410
    ld bc, $0805
    call Func_033_6152
    call Func_033_60D3
    ld bc, $140D
    ld de, $01CC
    call Func_033_60FC
    call Func_033_6049
    xor a, a
    ld [wD7AD], a
    ld hl, wD781
    inc [hl]
    ret

Jump_033_574F::
    ld a, [wC58F]
    cp a, $FE
    jr nz, Jump_033_576D
    ld a, $02
    ld [wD780], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $0A
    call Func_033_5550
    ld a, $FE
    ld [wC594], a
    ret

Jump_033_576D::
    xor a, a
    ld [wD7F5], a
    farcall Func_00D_4D24
    ld a, [wD7F5]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_033_5785
    cp a, $FF
    jr z, Jump_033_578A
    ret

Jump_033_5785::
    ld hl, wD781
    inc [hl]
    ret

Jump_033_578A::
    ld a, [wD7AD]
    and a, a
    jr nz, Jump_033_57A9
    ld a, [wD780]
    ld [wD7B2], a
    ld a, [wD781]
    ld [wD7B3], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $0C
    ld [wD780], a
    ret

Jump_033_57A9::
    call Func_033_6060
    ld hl, wD781
    inc [hl]
    inc [hl]
    ret

Jump_033_57B2::
    ld a, [wC52B]
    and a, a
    ret nz
    ld c, $05
    ld hl, Data_033_63EF
    call Func_033_6227
    call Func_033_5F83
    call Func_033_60D3
    ld bc, $140D
    ld de, $01CC
    call Func_033_60FC
    ld a, $08
    call Func_033_5550
    ld a, [wD781]
    sub a, $03
    ld [wD781], a
    ret

Jump_033_57DC::
    call Func_033_5F83
    call Func_033_60D3
    ld bc, $140D
    ld de, $01CC
    call Func_033_60FC
    ld hl, wD7DC
    inc [hl]
    ld a, $0C
    call Func_033_6039
    call Func_033_60A7
    ret

Jump_033_57F8::
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wD7DD]
    ld c, $00
    call SRAMRecordAddress
    ld de, wC986
    ld a, e
    ld [wC595], a
    ld a, d
    ld [wC596], a
    ld b, $A5

Jump_033_5816::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_033_5816
    ld de, wCA2B
    ld a, e
    ld [wC590], a
    ld a, d
    ld [wC591], a
    xor a, a
    ld [rRAMG], a
    xor a, a
    ld [wC94B], a
    ld a, $01
    ld [wC594], a
    ld hl, wD781
    inc [hl]
    ret

Jump_033_5839::
    ld a, [wC58F]
    cp a, $01
    jr z, Jump_033_585A
    cp a, $FE
    ret nz
    ld a, $02
    ld [wD780], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $0A
    call Func_033_5550
    ld a, $FE
    ld [wC594], a
    ret

Jump_033_585A::
    ld hl, $00A5
    ld a, l
    ld [wC592], a
    ld a, h
    ld [wC593], a
    ld a, $FF
    ld [wC594], a
    ld a, $01
    ld [wC58C], a
    ld hl, wD781
    inc [hl]
    ret

Jump_033_5874::
    ld a, [wC58F]
    cp a, $F0
    ret nz
    ld hl, wD780
    inc [hl]
    xor a, a
    ld [wD781], a
    ret

Jump_033_5883::
    ld a, [wD781]
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
    ld hl, wD781
    inc [hl]
    xor a, a
    ld [wC594], a
    ld hl, wC895
    ld de, wC597
    ld b, $04
    call Func_033_58C3
    ld hl, wC60C
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
    ld [wC594], a
    ld hl, wD781
    inc [hl]
    ret

Jump_033_58D7::
    ld a, [wC58F]
    cp a, $01
    ret nz
    ld hl, wC597
    ld a, l
    ld [wC595], a
    ld a, h
    ld [wC596], a
    ld hl, wC5B7
    ld a, l
    ld [wC590], a
    ld a, h
    ld [wC591], a
    ld a, $10
    ld [wC592], a
    ld a, $FF
    ld [wC594], a
    ld hl, wD781
    inc [hl]
    ret

Jump_033_5902::
    ld a, [wC58F]
    cp a, $F0
    ret nz
    xor a, a
    ld [wC594], a
    ld hl, wD781
    inc [hl]
    ret

Jump_033_5911::
    ld de, Data_033_6331
    ld hl, wC364
    ld bc, $0A0B
    call Func_033_6152
    ld hl, vTiles2 + $50
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0501
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ld de, wC8CF
    ld hl, wC5BB
    ld bc, $000A
    call CopyBytes
    ld a, $F0
    ld [wC8D9], a
    ld de, vTiles2 + $50
    call Func_000_21A1
    ld a, [wC5C6]
    ld [wC963], a
    ld de, wC5B7
    ld hl, wC3A7
    call Func_033_61FB
    ld hl, vTiles2 + $300
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0E01
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wC528], a
    ld a, $20
    ld [wC529], a
    farcall Func_01B_481A
    ld de, Data_033_63F9
    ld hl, wC3E7
    ld bc, $0907
    call Func_033_6152
    ld hl, vTiles1 + $4E0
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0201
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld a, $01
    ld [wC528], a
    ld [wC529], a
    farcall Func_007_400F
    call Func_033_6049
    ld hl, wD781
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
    ld [wD7FA], a
    ld hl, wD781
    inc [hl]
    ret

Jump_033_59D3::
    ld a, [wC58F]
    cp a, $FE
    jr nz, Jump_033_59F1
    ld a, $02
    ld [wD780], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $0A
    call Func_033_5550
    ld a, $FE
    ld [wC594], a
    ret

Jump_033_59F1::
    farcall Func_0F1_5842
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_033_5A05
    cp a, $FF
    jr z, Jump_033_5A1C
    ret

Jump_033_5A05::
    ld a, $02
    ld [wD780], a
    ld a, $09
    call Func_033_5550
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $FE
    ld [wC594], a
    ret

Jump_033_5A1C::
    ld a, [wD7FA]
    and a, a
    jr z, Jump_033_5A28
    cp a, $01
    jr z, Jump_033_5A2D
    jr Jump_033_5A05

Jump_033_5A28::
    ld hl, wD781
    inc [hl]
    ret

Jump_033_5A2D::
    ld a, [wD780]
    ld [wD7B2], a
    ld a, [wD781]
    ld [wD7B3], a
    ld a, $0D
    ld [wD780], a
    ld a, [wD7AB]
    ld [wD7B5], a
    ld a, [wD7AF]
    ld [wD7B6], a
    xor a, a
    ld [wD7AB], a
    ld [wD7AF], a
    ld [wD781], a
    ld [wD782], a
    ret

Jump_033_5A58::
    ld de, wC198
    ld hl, wC364
    ld bc, $0104
    call CopyBytes
    ld a, $0E
    call Func_033_5550
    xor a, a
    ld [wC594], a
    ld hl, wD781
    inc [hl]
    ret

Jump_033_5A72::
    ld a, [wC58F]
    cp a, $FE
    jr nz, Jump_033_5A90
    ld a, $02
    ld [wD780], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $0A
    call Func_033_5550
    ld a, $FE
    ld [wC594], a
    ret

Jump_033_5A90::
    ld a, [wC52B]
    or a, a
    ret nz
    ld a, [wC552]
    and a, $01
    jr z, Jump_033_5AAA
    ld a, $0D
    call Func_033_5550
    ld hl, wD781
    dec [hl]
    ld hl, wD781
    dec [hl]
    ret

Jump_033_5AAA::
    ld hl, wD781
    inc [hl]
    ret

Jump_033_5AAF::
    ld hl, wD781
    inc [hl]
    ld a, $0C
    call Func_033_5550
    ret

Jump_033_5AB9::
    ld a, [wC52B]
    and a, a
    ret nz
    ld hl, wD781
    inc [hl]
    ld a, $01
    ld [wC594], a
    ret

Jump_033_5AC8::
    ld a, [wC58F]
    cp a, $FE
    jr z, Jump_033_5AD4
    cp a, $01
    jr z, Jump_033_5AEB
    ret

Jump_033_5AD4::
    ld a, $02
    ld [wD780], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $0A
    call Func_033_5550
    ld a, $FE
    ld [wC594], a
    ret

Jump_033_5AEB::
    xor a, a
    ld [wC594], a
    ld hl, wD781
    inc [hl]
    ld a, $1A
    call Func_033_5550
    ret

Jump_033_5AF9::
    ld a, [wC52B]
    and a, a
    ret nz
    ld hl, wD781
    inc [hl]
    ld a, [wC617]
    ld [wD09D], a
    ld a, [wC618]
    ld [wD09E], a
    ld a, [wC619]
    ld [wD09F], a
    farcall Func_002_760B
    ld a, [wD09D]
    ld [wC617], a
    ld a, [wD09E]
    ld [wC618], a
    ld a, [wD09F]
    ld [wC619], a
    farcall Func_002_7688
    ld a, $05
    ld [wC594], a
    ret

Jump_033_5B38::
    ld a, [wC58F]
    cp a, $05
    ret nz
    xor a, a
    ld [wC594], a
    ld hl, wC5BB
    ld de, wD05A
    ld bc, $000B
    call CopyBytes
    farcall Func_01D_5D84
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld [wD065], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_033_5B68::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, [wC5E7]
    ld [wC59A], a
    ld a, [wC5E8]
    ld [wC59B], a
    ld hl, wC59A
    ld a, l
    ld [wC595], a
    ld a, h
    ld [wC596], a
    ld hl, wC5BA
    ld a, l
    ld [wC590], a
    ld a, h
    ld [wC591], a
    ld a, $02
    ld [wC592], a
    xor a, a
    ld [wC593], a
    ld a, $FF
    ld [wC594], a
    ld a, $01
    ld [wC58C], a
    ret

Jump_033_5BA5::
    ld a, [wC58F]
    cp a, $F0
    ret nz
    xor a, a
    ld [wC594], a
    xor a, a
    ld [wC58C], a
    ld a, [wC57F]
    bit 1, a
    jr nz, Jump_033_5BC8
    ld a, [wC5E7]
    ld [wC5BA], a
    ld a, [wC5E8]
    ld [wC5BB], a
    jr Jump_033_5BD4

Jump_033_5BC8::
    ld a, [wC5BA]
    ld [wC5E7], a
    ld a, [wC5BB]
    ld [wC5E8], a

Jump_033_5BD4::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_033_5BDC::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, $D2
    ld [wC594], a
    ret

Jump_033_5BE9::
    ld a, [wC58F]
    cp a, $D2
    ret nz
    xor a, a
    ld [wC594], a
    ld a, $07
    ld [wC5DB], a
    xor a, a
    ld [wC5DC], a
    ld [wC5DD], a
    ld [wC5DE], a
    ld a, $01
    ld [wC5DF], a
    ld a, $07
    ld [wC581], a
    ld a, $00
    ld [wC582], a
    xor a, a
    ld [wC594], a
    xor a, a
    ld [wC58F], a
    ret

Jump_033_5C1A::
    farcall Func_01E_4069
    ld a, [wD781]
    cp a, $0A
    ret nz
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, [wD780]
    add a, $03
    ld [wD780], a
    ret

Jump_033_5C36::
    farcall Func_0F1_4AD0
    ld a, [wD780]
    cp a, $0E
    ret nz
    ld a, [wD7B5]
    ld [wD7AB], a
    ld a, [wD7B6]
    ld [wD7AF], a
    ret

Jump_033_5C4F::
    ld a, [wD781]
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
    farcall Func_01B_7205
    ld de, Data_033_6331
    ld hl, wC364
    ld bc, $0A0B
    call Func_033_6152
    call Func_033_6247
    ld hl, vTiles1 + $4E0
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0201
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld a, $01
    ld [wC528], a
    ld [wC529], a
    farcall Func_007_400F
    call Func_033_6049
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_033_5CA7::
    ld hl, wD781
    inc [hl]
    ret

Jump_033_5CAC::
    farcall Func_01D_5D84
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld b, a
    push af
    ld a, $C7
    ld [wD7F1], a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, b
    ld c, $0D
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    and a, $0F
    ld [wD09D], a
    ld a, [wD7F1]
    ld [wD09E], a
    farcall Func_016_7A48
    xor a, a
    ld [rRAMG2], a
    ld de, Data_033_5D5F
    ld hl, wC440
    ld bc, $0D02
    call Func_033_6152
    pop af
    ld [wD7F1], a
    ld hl, wC443
    ld a, l
    ld [wD7F2], a
    ld a, h
    ld [wD7F3], a
    ld a, [wD7F1]
    ld b, a
    ld a, [wD7F2]
    ld l, a
    ld a, [wD7F3]
    ld h, a
    push bc
    push hl
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, b
    ld c, $56
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    farcall Func_01E_75B3
    ld a, [wC8C1]
    add a, $E0
    pop hl
    push hl
    ld [hl+], a
    ld a, [wC8C2]
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
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    and a, $01
    add a, $CC
    pop hl
    ld [hl], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Data_033_5D5F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B6, $EA, $ED, $C3, $C3, $F8, $F9, $FA, $FB, $FC, $C3, $C7, $B7, $B3, $B4, $B4
    db $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Jump_033_5D79::
    farcall Func_01B_67F0
    ret

Jump_033_5D80::
    ld de, Data_033_62C3
    ld hl, wC36E
    ld bc, $0A0B
    call Func_033_6152
    ld de, wC895
    ld hl, wC3B1
    call Func_033_61FB
    ld de, Data_033_6331
    ld hl, wC364
    ld bc, $0A0B
    call Func_033_6152
    ld de, wC5B7
    ld hl, wC3A7
    call Func_033_61FB
    ld hl, vTiles2 + $50
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0501
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ld de, wC8CF
    ld hl, wC5BB
    ld bc, $000A
    call CopyBytes
    ld a, $F0
    ld [wC8D9], a
    ld de, vTiles2 + $50
    call Func_000_21A1
    ld hl, wD781
    inc [hl]
    ret

Jump_033_5DDF::
    ld hl, vTiles2 + $300
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0E01
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wC528], a
    ld a, $20
    ld [wC529], a
    farcall Func_01B_481A
    ld de, Data_033_63F9
    ld hl, wC3E7
    ld bc, $0907
    call Func_033_6152
    call Func_033_6074
    call Func_033_6049
    ld a, $01
    ld [wD7FA], a
    ld a, [wD781]
    inc a
    ld [wD781], a
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
    ldh [hFFBA], a
    xor a, a
    ld [wD782], a
    ld a, [wD7B2]
    ld [wD780], a
    ld a, [wD7B3]
    ld [wD781], a
    call Func_033_6049
    ret

Jump_033_5E57::
    ld a, [wD781]
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
    farcall Func_01B_7205
    ld de, Data_033_6438
    ld hl, wC364
    ld bc, $080B
    call Func_033_6152
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_033_63EF
    call Func_033_60C3
    call Func_033_6247
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_033_5E93::
    call Func_033_561C
    ret

Jump_033_5E97::
    call Func_033_5F99
    farcall Func_01E_7163
    ld a, [wD7B0]
    cp a, $02
    jr c, Jump_033_5EBE
    ld hl, wC42E
    call Func_033_629D
    ld hl, wC42F
    ld a, h
    ld [wD7F1], a
    ld a, l
    ld [wD7F2], a
    farcall Func_01E_759A

Jump_033_5EBE::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_033_5EC6::
    farcall Func_01F_5C15
    xor a, a
    ld [wD7F1], a
    farcall Func_01D_6AA5
    ret

Jump_033_5ED7::
    call Func_033_5623
    ret

Jump_033_5EDB::
    call Func_033_562A
    ret

Jump_033_5EDF::
    ld hl, vTiles2 + $700
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0C01
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wC528], a
    ld a, $1E
    ld [wC529], a
    farcall Func_01B_481A
    call Func_033_6074
    call Func_033_6049
    xor a, a
    ld a, $12
    ld [wC529], a
    farcall Func_01B_481A
    ld de, wC895
    ld hl, wC3B1
    call Func_033_61FB
    ld de, Data_033_63C7
    ld hl, wC410
    ld bc, $0805
    call Func_033_6152
    xor a, a
    ld [wD7AD], a
    ld a, [wD781]
    inc a
    ld [wD781], a
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
    ldh [hFFBA], a
    xor a, a
    ld [wD782], a
    ld a, [wD7B2]
    ld [wD780], a
    ld a, [wD7B3]
    ld [wD781], a
    call Func_033_6049
    ret

Func_033_5F6B:: ; heuristic: follows a terminator; C0
    ld hl, wD7DD
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    call LoadSRAMRecordByte
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    ret

Func_033_5F83::
    ld de, Data_033_639F
    ld hl, wC410
    ld bc, $0805
    call Func_033_6152
    ld de, wC895
    ld hl, wC3B1
    call Func_033_61FB
    ret

Func_033_5F99::
    ld hl, wD789
    ld b, $1E

Jump_033_5F9E::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_033_5F9E
    ld hl, wD7BE
    ld b, $1E

Jump_033_5FA8::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_033_5FA8
    xor a, a
    ld [wD7A9], a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld [wD7B9], a
    ld de, sA000
    ld hl, wD789
    ld b, $00
    ld c, $00

Jump_033_5FC7::
    ld a, [de]
    and a, a
    jr z, Jump_033_601D
    cp a, $01
    jr z, Jump_033_5FDD
    ld a, [wD7DC]
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
    ld a, [wD7DC]
    and a, a
    jr z, Jump_033_6010
    cp a, $03
    jr nc, Jump_033_6010
    push hl
    push de
    push bc
    ld d, b
    ld hl, wD7DD
    ld a, [wD7DC]
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
    ld a, [wD7B9]
    inc a
    ld [wD7B9], a

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
    ld [wD7A9], a
    xor a, a
    ld [rRAMG2], a
    farcall Func_01D_5F9C
    ret

Func_033_6039::
    add a, $10
    ld [wC529], a
    xor a, a
    ld [wC528], a
    farcall Func_01B_480C
    ret

Func_033_6049::
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

Func_033_6060::
    farcall Func_01D_5D84
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld de, wD7DD
    ld a, [hl]
    ld [de], a
    ret

Func_033_6074::
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    farcall Func_01D_5D84
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld c, $01
    call Func_000_1FA4
    ld hl, wC8CF
    ld de, wC130
    ld b, $0B

Jump_033_6099::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_033_6099
    xor a, a
    ld [rRAMB], a
    ld [rRAMG], a
    ret

Func_033_60A7::
    ld a, [wD7DC]
    ld [wD7B4], a
    ld a, $FF
    ld [wD7E0], a
    ld a, $04
    ld [wD7DC], a
    xor a, a
    ld [wD782], a
    ld a, [wD781]
    inc a
    ld [wD781], a
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
    ldh a, [hFFA5]
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
    ldh a, [hFFA1]
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
    ld hl, wC198
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
    call WaitForVRAMAccess
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
    xor a, a
    call Func_000_160B
    call WaitForVRAMAccess
    ld a, $00
    ldh [rSVBK], a
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
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, l
    add a, $68
    ld l, a
    ld a, h
    adc a, $0E
    ld h, a
    ld a, $02
    ldh [rSVBK], a

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
    ldh [rSVBK], a
    ret

Func_033_6197::
    ld a, [wC617]
    ld l, a
    ld a, [wC618]
    ld h, a
    ld a, l
    ld [wC8C0], a
    ld a, h
    ld [wC8C1], a
    ld a, [wC619]
    ld [wC8C2], a
    call Func_000_173A
    ld c, $00
    ld hl, wC1BA
    ldh a, [hFFC8]
    and a, $0F
    jr z, Jump_033_61C0
    add a, $E0
    ld [hl], a
    set 0, c

Jump_033_61C0::
    inc hl
    ldh a, [hFFC7]
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
    ldh a, [hFFC7]
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
    ldh a, [hFFC6]
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
    ldh a, [hFFC6]
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
    call HLToDecimalDigits
    pop hl
    ld a, [wC8C1]
    or a, a
    jr z, Jump_033_6217
    add a, $E0
    ld [hl], a

Jump_033_6217::
    inc hl
    ld a, [wC8C2]
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
    ld hl, vTiles2
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0501
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ld de, wC8CF
    ld hl, wC60C
    ld bc, $000A
    call CopyBytes
    ld a, $F0
    ld [wC8D9], a
    ld de, vTiles2
    call Func_000_21A1
    ld hl, vTiles2 + $100
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1001
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld a, $01
    ld [wC528], a
    xor a, a
    ld [wC529], a
    farcall Func_007_400F
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

Data_033_62AB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $BF, $C3, $C3, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_033_62C3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0CE2C3, $6E

Data_033_6331:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $05, $06, $07, $08, $09
    db $C3, $C3, $C3, $B7, $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA, $B6, $10
    db $11, $12, $C3, $16, $ED, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3

Data_033_6362:: ; heuristic: target of a monotone pointer table; C0
    db $B7, $B6, $13, $14, $15, $C3, $16, $ED, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6, $10, $11, $12, $C3, $17, $ED, $C3, $C3, $B7, $B6
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $13, $14, $15, $C3, $17, $ED
    db $C3, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_033_639F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $14, $15, $C3, $17, $ED, $C3, $C3, $B7
    db $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5, $B7, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $B5, $C3, $C3, $C3, $C3, $C3, $C3, $C3

Data_033_63C7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $70, $71, $72, $73, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $74, $75, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_033_63EF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $79, $C3, $A1, $C3, $C9, $C3, $F1, $C3, $19, $C4

Data_033_63F9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $30, $31, $32, $33, $34
    db $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $35, $36, $37
    db $38, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $39
    db $3A, $31, $34, $C3, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_033_6438:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0CE438, $58

Func_033_6490::
    ld de, Data_033_64A5
    call Func_000_25C9
    ret
    db $11, $A5, $64, $CD, $FE, $25, $C9

Func_033_649E::
    call Func_033_6490
    call Func_000_2611
    ret

Data_033_64A5:: ; heuristic: pointer load in the same bank (bank assumed); C0
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
    ld de, Data_033_704C
    call Func_000_25C9
    ret
    db $11, $4C, $70, $CD, $FE, $25, $C9

Func_033_7045::
    call Func_033_7037
    call Func_000_2611
    ret

Data_033_704C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_033_704E

Data_033_704E:: ; heuristic: target of a monotone pointer table; C0
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
