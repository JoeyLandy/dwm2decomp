SECTION "Bank 33", ROMX[$4000], BANK[$33]
    db $33

; DE = block number: the table at $405F gives each block an offset into wScreenTileBuffer (word), a width B and a height C, followed by B * C tile bytes; they are copied into wScreenTileBuffer rows 32 bytes apart
; 64 call sites from 38 routines (e.g. LoadScreenBlocks00To03, LoadScreenBlocks00And04To06, LoadScreenBlocks00_07_08, LoadScreenBlocks00_09_0A, ...)
; points at: wScreenTileBuffer
CopyBlockToTileBuffer::
Func_033_4001:: ; address name
    ld d, $00
    ld hl, Data_033_405F
    add hl, de
    add hl, de
    deref_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld c, [hl]
    inc hl
    push hl
    ld hl, wScreenTileBuffer
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

; E = block: copies the screen block from Data_033_405F[E] (word offset, width, rows, tiles) into wScreenTileBuffer like CopyBlockToTileBuffer, but writes tile $C3 for tiles $15-$A3 (the text glyphs) (E-0117)
; 14 call sites from 4 routines (e.g. LoadBlankedBlocks00To03WithCursor, LoadBlankedBlocks00And04To06WithCursor, LoadBlankedBlocks00_07_08WithCursor, LoadBlankedBlocks00_09_0AWithCursor)
; points at: wScreenTileBuffer
CopyBlockToTileBufferBlankingText::
Func_033_402B:: ; address name
    ld d, $00
    ld hl, Data_033_405F
    add hl, de
    add hl, de
    deref_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld c, [hl]
    inc hl
    push hl
    ld hl, wScreenTileBuffer
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

; only called from GameMode5_Update_Case05 (E-0047)
; 1 call site from 1 routine (e.g. GameMode5_Update_Case05)
; reads: wD06A, wD780, wD781, wD782
GameMode5_Update_Case05_Sub01::
Func_033_51C6:: ; address name
    call LinkExchangeJoypadPerFrame
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
    farcall DrawWD789Cell5SpeciesSprite
    ret

Jump_033_51F4::
    farcall CallFunc6899PreservingWD7F1AndHFFC6
    ret

Jump_033_51FB::
    ld a, [wD781]
    cp a, $15
    jr z, Jump_033_5207
    cp a, $20
    jr z, Jump_033_520E
    ret

Jump_033_5207::
    farcall DrawWCA36SpritePart_BankF1
    ret

Jump_033_520E::
    farcall DrawWCA2BSpeciesSprites
    ret

; only called from RunWC582State_450D_Case01 (E-0047)
; 1 call site from 1 routine (e.g. RunWC582State_450D_Case01)
; reads: wD06A, wD06B, wFadeState, wD780
RunWC582State_450D_Case01_Sub01::
Func_033_5215:: ; address name
    ld a, [wD06A]
    or a, a
    jr nz, Jump_033_523B
    ld a, [wD06B]
    rst $00
    dw Func_033_5215_Case00
    dw Func_033_5215_Case01
    dw Func_033_5215_Case02
    dw Func_033_5215_Case03
    dw Func_033_5215_Case04
    dw Func_033_5215_Case05
    dw Func_033_5215_Case06
    dw Func_033_5215_Case07
    dw Func_033_5215_Case08
    dw Func_033_5215_Case09
    dw Func_033_5215_Case0A
    dw Func_033_5215_Case0B
    dw Func_033_5215_Case0C
    dw Func_033_5215_Case0D

Jump_033_523B::
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, [wD780]
    rst $00
    dw Func_033_5215_Table2_Case00
    dw Func_033_5215_Table2_Case01
    dw Func_033_5215_Table2_Case02
    dw Func_033_5215_Table2_Case03
    dw Func_033_5215_Table2_Case04
    dw Func_033_5215_Table2_Case05
    dw Func_033_5215_Table2_Case06
    dw Func_033_5215_Table2_Case06
    dw Func_033_5215_Table2_Case06
    dw Func_033_5215_Table2_Case06
    dw Func_033_5215_Table2_Case06
    dw Func_033_5215_Table2_Case06
    dw Func_033_5215_Table2_Case06
    dw Func_033_5215_Table2_Case0D
    dw Func_033_5215_Table2_Case0E
    dw Func_033_5215_Table2_Case0F

; entry 0 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; points at: wScreenTileBuffer, wD06B
Func_033_5215_Case00::
Jump_033_5264:: ; address name
    ld de, Data_033_62AB
    ld hl, wScreenTileBuffer + $C
    ld bc, $0803
    call CopyRectTo20ByteRowsJp_Bank33
    ld de, Data_033_62C3
    ld hl, wScreenTileBuffer
    ld bc, $0A0B
    call CopyRectTo20ByteRowsJp_Bank33
    call DrawPlayerNameAndString0Category1
    call SetDefaultStringWindow_Bank33
    ld hl, wD06B
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; writes: wLinkSendByte
; points at: wKeyNameBuf, wD06B
Func_033_5215_Case01::
Jump_033_5287:: ; address name
    xor a, a
    ld [wLinkSendByte], a
    call WriteGoldDigitsToWC1BA
    ld de, wKeyNameBuf
    ld hl, wScreenTileBuffer + $43
    call RunFunc6204FourTimes
    call BGMapAddressAtScroll_Bank33
    ld bc, $140D
    ld de, $0000
    call DrawScreenBufferRectToBGMap_33
    ld hl, wD06B
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState
; writes: wLinkSendByte
; points at: wD06B
Func_033_5215_Case02::
Jump_033_52A8:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, $19
    call BeginString_Bank07_Cat5
    ld hl, wD06B
    inc [hl]
    xor a, a
    ld [wLinkSendByte], a
    ret

; entry 3 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wTextFlags, wTextYesNoResult, wGoldLo, wGoldMid, wGoldHi, wD06B
; writes: wLinkSendByte, wD06A, wD780, wD06B, wGoldHi, wGoldMid, wGoldLo
; points at: wD06B
Func_033_5215_Case03::
Jump_033_52BB:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr nz, Jump_033_52D7
    ld a, $FE
    ld [wLinkSendByte], a
    ld a, $01
    ld [wD06A], a
    ld a, $02
    ld [wD780], a
    ld a, $0A
    call BeginString_Bank07_Cat5
    ret

Jump_033_52D7::
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, [wTextYesNoResult]
    and a, $01
    jr z, Jump_033_52F8
    ld a, $FE
    ld [wLinkSendByte], a
    ld a, $01
    ld [wD06A], a
    ld a, $02
    ld [wD780], a
    ld a, $09
    call BeginString_Bank07_Cat5
    ret

Jump_033_52F8::
    ld a, [wGoldLo]
    sub a, $E8
    ld c, a
    ld a, [wGoldMid]
    sbc a, $03
    ld b, a
    ld a, [wGoldHi]
    sbc a, $00
    jr nc, Jump_033_531E
    ld a, $00
    call BeginString_Bank07_Cat5
    ld a, [wD06B]
    add a, $08
    ld [wD06B], a
    ld a, $10
    ld [wLinkSendByte], a
    ret

Jump_033_531E::
    ld [wGoldHi], a
    ld a, b
    ld [wGoldMid], a
    ld a, c
    ld [wGoldLo], a
    ld a, $0C
    call BeginString_Bank07_Cat5
    ld hl, wD06B
    inc [hl]
    ld a, $01
    ld [wLinkSendByte], a
    ret

; entry 4 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkSendByte, wD06A, wD780
; points at: wD06B
Func_033_5215_Case04::
Jump_033_5338:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr z, Jump_033_5348
    cp a, $01
    jr z, Jump_033_535D
    cp a, $10
    jr z, Jump_033_536B
    ret

Jump_033_5348::
    ld a, $FE
    ld [wLinkSendByte], a
    ld a, $01
    ld [wD06A], a
    ld a, $02
    ld [wD780], a
    ld a, $0A
    call BeginString_Bank07_Cat5
    ret

Jump_033_535D::
    ld a, $07
    call BeginString_Bank07_Cat5
    ld hl, wD06B
    inc [hl]
    xor a, a
    ld [wLinkSendByte], a
    ret

Jump_033_536B::
    ld a, $01
    call BeginString_Bank07_Cat5
    ld hl, wD06B
    inc [hl]
    ld hl, wD06B
    inc [hl]
    ld hl, wD06B
    inc [hl]
    ret

; entry 5 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; writes: wLinkSendByte, wD06C
; points at: wD06B
Func_033_5215_Case05::
Jump_033_537D:: ; address name
    xor a, a
    ld [wLinkSendByte], a
    ld hl, wD06B
    inc [hl]
    xor a, a
    ld [wD06C], a
    ret

; entry 6 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; reads: wD06C
Func_033_5215_Case06::
Jump_033_538A:: ; address name
    ld a, [wD06C]
    rst $00
    dw Func_033_5215_Case06_Case00
    dw Func_033_5215_Case06_Case01
    dw Func_033_5215_Case06_Case02

; entry 0 of the `rst $00` table in Func_033_5215_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; points at: wScreenTileBuffer, wD06C
Func_033_5215_Case06_Case00::
Jump_033_5394:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld hl, wScreenTileBuffer
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

; entry 1 of the `rst $00` table in Func_033_5215_Case06
; no direct call (reached through a table, a jump or a vector)
; points at: wD06C
Func_033_5215_Case06_Case01::
Jump_033_53AC:: ; address name
    call BGMapAddressAtScroll_Bank33
    ld bc, $140D
    ld de, $0000
    call DrawScreenBufferRectToBGMap_33
    ld a, $08
    call BeginString_Bank07_Cat5
    ld hl, wD06C
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_033_5215_Case06
; no direct call (reached through a table, a jump or a vector)
; writes: wD06B, wD06C, wD06A, wD780
Func_033_5215_Case06_Case02::
Jump_033_53C2:: ; address name
    xor a, a
    ld [wD06B], a
    xor a, a
    ld [wD06C], a
    ld a, $01
    ld [wD06A], a
    xor a, a
    ld [wD780], a
    ret

; entry 7 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wTextYesNoResult, wGoldLo, wGoldMid, wGoldHi
; writes: wLinkSendByte, wGoldHi, wGoldMid, wGoldLo
; points at: wD06B
Func_033_5215_Case07::
Jump_033_53D4:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, [wTextYesNoResult]
    and a, $01
    jr z, Jump_033_53F3
    ld a, $05
    call BeginString_Bank07_Cat5
    ld a, $40
    ld [wLinkSendByte], a
    ld hl, wD06B
    inc [hl]
    ld hl, wD06B
    inc [hl]
    ret

Jump_033_53F3::
    ld a, [wGoldLo]
    sub a, $E8
    ld c, a
    ld a, [wGoldMid]
    sbc a, $03
    ld b, a
    ld a, [wGoldHi]
    sbc a, $00
    jr nc, Jump_033_5419
    ld a, $04
    call BeginString_Bank07_Cat5
    ld a, $30
    ld [wLinkSendByte], a
    ld hl, wD06B
    inc [hl]
    ld hl, wD06B
    inc [hl]
    ret

Jump_033_5419::
    ld [wGoldHi], a
    ld a, b
    ld [wGoldMid], a
    ld a, c
    ld [wGoldLo], a
    ld a, $02
    call BeginString_Bank07_Cat5
    ld a, $20
    ld [wLinkSendByte], a
    ld hl, wD06B
    inc [hl]
    ret

; entry 8 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkSendByte, wD06A, wD780
; points at: wD06B
Func_033_5215_Case08::
Jump_033_5433:: ; address name
    ld a, [wLinkMessage]
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
    ld [wLinkSendByte], a
    ld a, $01
    ld [wD06A], a
    ld a, $02
    ld [wD780], a
    ld a, $0A
    call BeginString_Bank07_Cat5
    ret

; entry 9 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkSendByte, wD06A, wD780
; points at: wD06B
Func_033_5215_Case09::
Jump_033_545B:: ; address name
    ld a, [wLinkMessage]
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
    ld [wLinkSendByte], a
    ld a, $01
    ld [wD06A], a
    ld a, $02
    ld [wD780], a
    ld a, $0A
    call BeginString_Bank07_Cat5
    ret

; entry 10 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; writes: wLinkSendByte, wD06A, wD06B, wD780
Func_033_5215_Case0A::
Jump_033_5483:: ; address name
    ld a, $FE
    ld [wLinkSendByte], a
    ld a, $01
    ld [wD06A], a
    xor a, a
    ld [wD06B], a
    ld a, $02
    ld [wD780], a
    ret

; entry 11 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkSendByte, wD06A, wD780
; points at: wD06B
Func_033_5215_Case0B::
Jump_033_5497:: ; address name
    ld a, [wLinkMessage]
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
    ld [wLinkSendByte], a
    ld a, $06
    call BeginString_Bank07_Cat5
    ld hl, wD06B
    inc [hl]
    ld hl, wD06B
    inc [hl]
    ret

Jump_033_54BE::
    ld [wLinkSendByte], a
    ld a, $04
    call BeginString_Bank07_Cat5
    ld hl, wD06B
    inc [hl]
    ld hl, wD06B
    inc [hl]
    ret

Jump_033_54CF::
    ld [wLinkSendByte], a
    ld a, $03
    call BeginString_Bank07_Cat5
    ld hl, wD06B
    inc [hl]
    ret

Jump_033_54DC::
    ld [wLinkSendByte], a
    ld a, $04
    call BeginString_Bank07_Cat5
    ld hl, wD06B
    inc [hl]
    ld hl, wD06B
    inc [hl]
    ret

Jump_033_54ED::
    ld a, $FE
    ld [wLinkSendByte], a
    ld a, $01
    ld [wD06A], a
    ld a, $02
    ld [wD780], a
    ld a, $0A
    call BeginString_Bank07_Cat5
    ret

; entry 12 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wD06B, wLinkSendByte, wD06A, wD780
Func_033_5215_Case0C::
Jump_033_5502:: ; address name
    ld a, [wLinkMessage]
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
    ld [wLinkSendByte], a
    ld a, $01
    ld [wD06A], a
    ld a, $02
    ld [wD780], a
    ld a, $0A
    call BeginString_Bank07_Cat5
    ret

; entry 13 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkSendByte, wD06A, wD06B, wD780
Func_033_5215_Case0D::
Jump_033_552A:: ; address name
    ld a, [wLinkMessage]
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
    ld [wLinkSendByte], a
    ld a, $01
    ld [wD06A], a
    xor a, a
    ld [wD06B], a
    ld a, $02
    ld [wD780], a
    ret

; A = string index: wStringIndex = A, wStringCategory = 5, then BeginStringDisplay_Bank07
; 34 call sites from 19 routines (e.g. Func_033_5215_Case0C, Func_033_5215_Case0B, Func_033_5215_Case09, Func_033_5215_Case08, ...)
; writes: wStringIndex, wStringCategory
BeginString_Bank07_Cat5::
Func_033_5550:: ; address name
    ld [wStringIndex], a
    ld a, $05
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank07
    ret

; entry 0 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; points at: wD780
Func_033_5215_Table2_Case00::
Jump_033_555F:: ; address name
    ld hl, wD780
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; points at: wD780
Func_033_5215_Table2_Case01::
Jump_033_5564:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld hl, wD780
    inc [hl]
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
Func_033_5215_Table2_Case02::
Jump_033_556F:: ; address name
    ld a, [wD781]
    rst $00
    dw Func_033_5215_Table2_Case02_Case00
    dw Func_033_5215_Table2_Case02_Case01
    dw Func_033_5215_Table2_Case02_Case02
    dw Func_033_5215_Table2_Case02_Case03
    dw Func_033_5215_Table2_Case02_Case04

; entry 0 of the `rst $00` table in Func_033_5215_Table2_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wD781
; writes: wLinkSendByte, wD781
Func_033_5215_Table2_Case02_Case00::
Jump_033_557D:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 1 of the `rst $00` table in Func_033_5215_Table2_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; points at: wD781
Func_033_5215_Table2_Case02_Case01::
Jump_033_558F:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, $0C
    call ShowStringA10_Bank33
    ld hl, wD781
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_033_5215_Table2_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wLinkSendByte
; points at: wD781
Func_033_5215_Table2_Case02_Case02::
Jump_033_559E:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wD781
    inc [hl]
    ret

; entry 3 of the `rst $00` table in Func_033_5215_Table2_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkSendByte
; points at: wD781
Func_033_5215_Table2_Case02_Case03::
Jump_033_55AD:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld hl, wD781
    inc [hl]
    ret

; entry 4 of the `rst $00` table in Func_033_5215_Table2_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; points at: wD780, wGameMode, wModeChangeRequest
Func_033_5215_Table2_Case02_Case04::
Jump_033_55BC:: ; address name
    ld a, [wTextFlags]
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
    ld hl, wGameMode
    ld a, $05
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld [hl], a
    ld hl, wModeChangeRequest
    inc [hl]
    ret

; entry 3 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; points at: wD780
Func_033_5215_Table2_Case03::
Jump_033_55E0:: ; address name
    ld hl, wD780
    inc [hl]
    ret

; entry 4 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
Func_033_5215_Table2_Case04::
Jump_033_55E5:: ; address name
    ld a, [wD781]
    rst $00
    dw Func_033_5215_Table2_Case04_Case00
    dw Func_033_5215_Table2_Case04_Case00
    dw Func_033_5215_Table2_Case04_Case02
    dw Func_033_5215_Table2_Case04_Case00
    dw CallDrawWD789Cell5RecordPanel
    dw CallClearAndDrawWD789Cell5Name
    dw CopyRect62C3ToWC36EAndIncWD781
    dw Func_033_5215_Table2_Case04_Case07
    dw Func_033_5215_Table2_Case04_Case08
    dw Func_033_5215_Table2_Case04_Case09
    dw Func_033_5215_Table2_Case04_Case0A
    dw Func_033_5215_Table2_Case04_Case0B
    dw Func_033_5215_Table2_Case04_Case0C
    dw Func_033_5215_Table2_Case04_Case0D
    dw Func_033_5215_Table2_Case04_Case0E
    dw Func_033_5215_Table2_Case04_Case0F

; entry 0 of the `rst $00` table in Func_033_5215_Table2_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
Func_033_5215_Table2_Case04_Case00::
Jump_033_5609:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    farcall ScriptCommandED_Run
    ret

; entry 2 of the `rst $00` table in Func_033_5215_Table2_Case04
; no direct call (reached through a table, a jump or a vector)
Func_033_5215_Table2_Case04_Case02::
Jump_033_5615:: ; address name
    farcall DrawRecordListPageIndicators_1B
    ret

; far-calls DrawWD789Cell5RecordPanel (E-0122)
; 1 call site from 1 routine (e.g. Func_033_5215_Table2_Case0F_Case03)
CallDrawWD789Cell5RecordPanel::
Func_033_561C:: ; address name
    farcall DrawWD789Cell5RecordPanel
    ret

; far-calls ClearAndDrawWD789Cell5NameAtTiles1780 (E-0122)
; 1 call site from 1 routine (e.g. Func_033_5215_Table2_Case0F_Case04)
CallClearAndDrawWD789Cell5Name::
Func_033_5623:: ; address name
    farcall ClearAndDrawWD789Cell5NameAtTiles1780
    ret

; copies the 10 x 11 rectangle Data_033_62C3 into wC36E (CopyRectTo20ByteRowsJp_Bank33), then wD781 += 1 (E-0119)
; 1 call site from 1 routine (e.g. Func_033_5215_Table2_Case0F_Case05)
; points at: wD781
CopyRect62C3ToWC36EAndIncWD781::
Func_033_562A:: ; address name
    ld de, Data_033_62C3
    ld hl, wWindowTileBuffer + $6E
    ld bc, $0A0B
    call CopyRectTo20ByteRowsJp_Bank33
    ld hl, wD781
    inc [hl]
    ret

; entry 7 of the `rst $00` table in Func_033_5215_Table2_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wD7AB, wD781
; writes: wD781
; points at: wKeyNameBuf
Func_033_5215_Table2_Case04_Case07::
Jump_033_563B:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, [wD7AB]
    ld b, $BB
    ld hl, Data_033_63EF
    call StoreBAtWordTableEntry_Bank33
    ld de, wKeyNameBuf
    ld hl, wWindowTileBuffer + $B1
    call RunFunc6204FourTimes
    call BGMapAddressAtScroll_Bank33
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_33
    ld a, [wD7AB]
    ld b, $C3
    ld hl, Data_033_63EF
    call StoreBAtWordTableEntry_Bank33
    call SetDefaultStringWindow_Bank33
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 8 of the `rst $00` table in Func_033_5215_Table2_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wMenuInputResult, wD7AB, wD781
; writes: wD780, wD781, wD782, wLinkSendByte, wMenuInputResult
; points at: wD781
Func_033_5215_Table2_Case04_Case08::
Jump_033_5676:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr nz, Jump_033_5694
    ld a, $02
    ld [wD780], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $0A
    call BeginString_Bank07_Cat5
    ld a, $FE
    ld [wLinkSendByte], a
    ret

Jump_033_5694::
    xor a, a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
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
    call BeginString_Bank07_Cat5
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $FE
    ld [wLinkSendByte], a
    ret

Jump_033_56E1::
    call StoreWD789Cell5RecordInWD7DD
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_033_63EF
    call StoreBAtWordTableEntry_Bank33
    call CopyWD789Cell5NameToWC130_Bank33
    ld hl, wD781
    inc [hl]
    ld a, $02
    call ShowStringA10_Bank33
    ret

; entry 9 of the `rst $00` table in Func_033_5215_Table2_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex, wD7AD
; points at: wD781
Func_033_5215_Table2_Case04_Case09::
Jump_033_56FC:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld hl, vTiles2 + $700
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0C01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a, a
    ld [wStringCategory], a
    ld a, $1E
    ld [wStringIndex], a
    farcall ShowString_Bank1B_481A
    ld a, $6C
    call QueueSoundEffect
    ld de, Data_033_63C7
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRowsJp_Bank33
    call BGMapAddressAtScroll_Bank33
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_33
    call SetDefaultStringWindow_Bank33
    xor a, a
    ld [wD7AD], a
    ld hl, wD781
    inc [hl]
    ret

; entry 10 of the `rst $00` table in Func_033_5215_Table2_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wD7F5, wD7AD, wD780, wD781
; writes: wD780, wD781, wD782, wLinkSendByte, wD7F5, wD7B2, wD7B3
; points at: wD781
Func_033_5215_Table2_Case04_Case0A::
Jump_033_574F:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr nz, Jump_033_576D
    ld a, $02
    ld [wD780], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $0A
    call BeginString_Bank07_Cat5
    ld a, $FE
    ld [wLinkSendByte], a
    ret

Jump_033_576D::
    xor a, a
    ld [wD7F5], a
    farcall HandleTwoChoiceCursorInput_0D
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
    call StoreWD789Cell5RecordInWD7DD
    ld hl, wD781
    inc [hl]
    inc [hl]
    ret

; entry 11 of the `rst $00` table in Func_033_5215_Table2_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wD781
; writes: wD781
Func_033_5215_Table2_Case04_Case0B::
Jump_033_57B2:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld c, $05
    ld hl, Data_033_63EF
    call WriteC3AtWordTableEntries_Bank33
    call DrawBox639FAndKeyRows
    call BGMapAddressAtScroll_Bank33
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_33
    ld a, $08
    call BeginString_Bank07_Cat5
    ld a, [wD781]
    sub a, $03
    ld [wD781], a
    ret

; entry 12 of the `rst $00` table in Func_033_5215_Table2_Case04
; no direct call (reached through a table, a jump or a vector)
; points at: wD7DC
Func_033_5215_Table2_Case04_Case0C::
Jump_033_57DC:: ; address name
    call DrawBox639FAndKeyRows
    call BGMapAddressAtScroll_Bank33
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_33
    ld hl, wD7DC
    inc [hl]
    ld a, $0C
    call ShowStringA10_Bank33
    call FinishWD7DDEntryAndStep_33
    ret

; entry 13 of the `rst $00` table in Func_033_5215_Table2_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wD7DD
; writes: rRAMG, rRAMB, wLinkTimeoutLo, wLinkTimeoutHi, wLinkBufferPtrLo, wLinkBufferPtrHi, wLinkSceneByte4B, wLinkSendByte
; points at: wRecordBufA, wRecordBufB, wD781
Func_033_5215_Table2_Case04_Case0D::
Jump_033_57F8:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wD7DD]
    ld c, $00
    call SRAMRecordAddress
    ld de, wRecordBufA
    ld a, e
    ld [wLinkTimeoutLo], a
    ld a, d
    ld [wLinkTimeoutHi], a
    ld b, $A5

Jump_033_5816::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_033_5816
    ld de, wRecordBufB
    ld a, e
    ld [wLinkBufferPtrLo], a
    ld a, d
    ld [wLinkBufferPtrHi], a
    xor a, a
    ld [rRAMG], a
    xor a, a
    ld [wLinkSceneByte4B], a
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wD781
    inc [hl]
    ret

; entry 14 of the `rst $00` table in Func_033_5215_Table2_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wD780, wD781, wD782, wLinkSendByte, wLinkBufferCountLo, wLinkBufferCountHi, wLinkReady
; points at: wD781
Func_033_5215_Table2_Case04_Case0E::
Jump_033_5839:: ; address name
    ld a, [wLinkMessage]
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
    call BeginString_Bank07_Cat5
    ld a, $FE
    ld [wLinkSendByte], a
    ret

Jump_033_585A::
    ld hl, $00A5
    ld a, l
    ld [wLinkBufferCountLo], a
    ld a, h
    ld [wLinkBufferCountHi], a
    ld a, $FF
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ld hl, wD781
    inc [hl]
    ret

; entry 15 of the `rst $00` table in Func_033_5215_Table2_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wD781
; points at: wD780
Func_033_5215_Table2_Case04_Case0F::
Jump_033_5874:: ; address name
    ld a, [wLinkMessage]
    cp a, $F0
    ret nz
    ld hl, wD780
    inc [hl]
    xor a, a
    ld [wD781], a
    ret

; entry 5 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
Func_033_5215_Table2_Case05::
Jump_033_5883:: ; address name
    ld a, [wD781]
    rst $00
    dw Func_033_5215_Table2_Case05_Case00
    dw Func_033_5215_Table2_Case05_Case01
    dw Func_033_5215_Table2_Case05_Case02
    dw Func_033_5215_Table2_Case05_Case03
    dw Func_033_5215_Table2_Case05_Case04
    dw Func_033_5215_Table2_Case05_Case05
    dw Func_033_5215_Table2_Case05_Case06
    dw Func_033_5215_Table2_Case05_Case07
    dw Func_033_5215_Table2_Case05_Case08
    dw Func_033_5215_Table2_Case05_Case09
    dw Func_033_5215_Table2_Case05_Case0A
    dw Func_033_5215_Table2_Case05_Case0B
    dw Func_033_5215_Table2_Case05_Case0C
    dw Func_033_5215_Table2_Case05_Case0D
    dw Func_033_5215_Table2_Case05_Case0E
    dw Func_033_5215_Table2_Case05_Case0F
    dw Func_033_5215_Table2_Case05_Case10
    dw Func_033_5215_Table2_Case05_Case11

; entry 0 of the `rst $00` table in Func_033_5215_Table2_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wLinkSendByte
; points at: wD781, wKeyNameBuf, wLinkRecvBuffer, wPlayerName
Func_033_5215_Table2_Case05_Case00::
Jump_033_58AB:: ; address name
    ld hl, wD781
    inc [hl]
    xor a, a
    ld [wLinkSendByte], a
    ld hl, wKeyNameBuf
    ld de, wLinkRecvBuffer
    ld b, $04
    call CopyBBytesThenMark1
    ld hl, wPlayerName
    ld b, $0B

; copies B bytes from HL to DE, then stores 1 after them (E-0115)
; 1 call site from 1 routine (e.g. Func_033_5215_Table2_Case05_Case00)
CopyBBytesThenMark1::
Func_033_58C3:: ; address name
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, CopyBBytesThenMark1
    ld a, $01
    ld [de], a
    ret

; entry 1 of the `rst $00` table in Func_033_5215_Table2_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wLinkSendByte
; points at: wD781
Func_033_5215_Table2_Case05_Case01::
Jump_033_58CD:: ; address name
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wD781
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_033_5215_Table2_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkTimeoutLo, wLinkTimeoutHi, wLinkBufferPtrLo, wLinkBufferPtrHi, wLinkBufferCountLo, wLinkSendByte
; points at: wLinkRecvBuffer, wLinkPartnerName, wD781
Func_033_5215_Table2_Case05_Case02::
Jump_033_58D7:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    ret nz
    ld hl, wLinkRecvBuffer
    ld a, l
    ld [wLinkTimeoutLo], a
    ld a, h
    ld [wLinkTimeoutHi], a
    ld hl, wLinkPartnerName
    ld a, l
    ld [wLinkBufferPtrLo], a
    ld a, h
    ld [wLinkBufferPtrHi], a
    ld a, $10
    ld [wLinkBufferCountLo], a
    ld a, $FF
    ld [wLinkSendByte], a
    ld hl, wD781
    inc [hl]
    ret

; entry 3 of the `rst $00` table in Func_033_5215_Table2_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkSendByte
; points at: wD781
Func_033_5215_Table2_Case05_Case03::
Jump_033_5902:: ; address name
    ld a, [wLinkMessage]
    cp a, $F0
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld hl, wD781
    inc [hl]
    ret

; entry 4 of the `rst $00` table in Func_033_5215_Table2_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkTradeByte
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wNameGlyphBuf, wBattleByte63, wStringCategory, wStringIndex
; points at: wNameGlyphBuf, wRandomSeed2Hi, wLinkPartnerName, wD781
Func_033_5215_Table2_Case05_Case04::
Jump_033_5911:: ; address name
    ld de, Data_033_6331
    ld hl, wWindowTileBuffer + $64
    ld bc, $0A0B
    call CopyRectTo20ByteRowsJp_Bank33
    ld hl, vTiles2 + $50
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0501
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld de, wNameGlyphBuf
    ld hl, wRandomSeed2Hi
    ld bc, $000A
    call CopyBytes
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    ld de, vTiles2 + $50
    call CopyGlyphTilesToVRAM
    ld a, [wLinkTradeByte]
    ld [wBattleByte63], a
    ld de, wLinkPartnerName
    ld hl, wWindowTileBuffer + $A7
    call RunFunc6204FourTimes
    ld hl, vTiles2 + $300
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0E01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a, a
    ld [wStringCategory], a
    ld a, $20
    ld [wStringIndex], a
    farcall ShowString_Bank1B_481A
    ld de, Data_033_63F9
    ld hl, wWindowTileBuffer + $E7
    ld bc, $0907
    call CopyRectTo20ByteRowsJp_Bank33
    ld hl, vTiles1 + $4E0
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0201
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, $01
    ld [wStringCategory], a
    ld [wStringIndex], a
    farcall ShowString_Bank07
    call SetDefaultStringWindow_Bank33
    ld hl, wD781
    inc [hl]
    ret

; entry 5 of the `rst $00` table in Func_033_5215_Table2_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wTwoChoiceCursor
; points at: wD781
Func_033_5215_Table2_Case05_Case05::
Jump_033_59B9:: ; address name
    call BGMapAddressAtScroll_Bank33
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_33
    ld a, $0D
    call BeginString_Bank07_Cat5
    xor a, a
    ld [wTwoChoiceCursor], a
    ld hl, wD781
    inc [hl]
    ret

; entry 6 of the `rst $00` table in Func_033_5215_Table2_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wMenuInputResult, wTwoChoiceCursor, wD780, wD781, wD7AB, wD7AF
; writes: wD780, wD781, wD782, wLinkSendByte, wD7B2, wD7B3, wD7B5, wD7B6, ...
; points at: wD781
Func_033_5215_Table2_Case05_Case06::
Jump_033_59D3:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr nz, Jump_033_59F1
    ld a, $02
    ld [wD780], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $0A
    call BeginString_Bank07_Cat5
    ld a, $FE
    ld [wLinkSendByte], a
    ret

Jump_033_59F1::
    farcall HandleThreeChoiceCursorInput_F1
    ld a, [wMenuInputResult]
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
    call BeginString_Bank07_Cat5
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $FE
    ld [wLinkSendByte], a
    ret

Jump_033_5A1C::
    ld a, [wTwoChoiceCursor]
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

; entry 7 of the `rst $00` table in Func_033_5215_Table2_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wLinkSendByte
; points at: wScreenTileBuffer, wD781
Func_033_5215_Table2_Case05_Case07::
Jump_033_5A58:: ; address name
    ld de, wScreenTileBuffer
    ld hl, wWindowTileBuffer + $64
    ld bc, $0104
    call CopyBytes
    ld a, $0E
    call BeginString_Bank07_Cat5
    xor a, a
    ld [wLinkSendByte], a
    ld hl, wD781
    inc [hl]
    ret

; entry 8 of the `rst $00` table in Func_033_5215_Table2_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wTextFlags, wTextYesNoResult
; writes: wD780, wD781, wD782, wLinkSendByte
; points at: wD781
Func_033_5215_Table2_Case05_Case08::
Jump_033_5A72:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr nz, Jump_033_5A90
    ld a, $02
    ld [wD780], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $0A
    call BeginString_Bank07_Cat5
    ld a, $FE
    ld [wLinkSendByte], a
    ret

Jump_033_5A90::
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, [wTextYesNoResult]
    and a, $01
    jr z, Jump_033_5AAA
    ld a, $0D
    call BeginString_Bank07_Cat5
    ld hl, wD781
    dec [hl]
    ld hl, wD781
    dec [hl]
    ret

Jump_033_5AAA::
    ld hl, wD781
    inc [hl]
    ret

; entry 9 of the `rst $00` table in Func_033_5215_Table2_Case05
; no direct call (reached through a table, a jump or a vector)
; points at: wD781
Func_033_5215_Table2_Case05_Case09::
Jump_033_5AAF:: ; address name
    ld hl, wD781
    inc [hl]
    ld a, $0C
    call BeginString_Bank07_Cat5
    ret

; entry 10 of the `rst $00` table in Func_033_5215_Table2_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wLinkSendByte
; points at: wD781
Func_033_5215_Table2_Case05_Case0A::
Jump_033_5AB9:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld hl, wD781
    inc [hl]
    ld a, $01
    ld [wLinkSendByte], a
    ret

; entry 11 of the `rst $00` table in Func_033_5215_Table2_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkSendByte, wD780, wD781, wD782
; points at: wD781
Func_033_5215_Table2_Case05_Case0B::
Jump_033_5AC8:: ; address name
    ld a, [wLinkMessage]
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
    call BeginString_Bank07_Cat5
    ld a, $FE
    ld [wLinkSendByte], a
    ret

Jump_033_5AEB::
    xor a, a
    ld [wLinkSendByte], a
    ld hl, wD781
    inc [hl]
    ld a, $1A
    call BeginString_Bank07_Cat5
    ret

; entry 12 of the `rst $00` table in Func_033_5215_Table2_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wGoldLo, wGoldMid, wGoldHi, wD09D, wD09E, wD09F
; writes: wD09D, wD09E, wD09F, wGoldLo, wGoldMid, wGoldHi, wLinkSendByte
; points at: wD781
Func_033_5215_Table2_Case05_Case0C::
Jump_033_5AF9:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld hl, wD781
    inc [hl]
    ld a, [wGoldLo]
    ld [wD09D], a
    ld a, [wGoldMid]
    ld [wD09E], a
    ld a, [wGoldHi]
    ld [wD09F], a
    farcall VerifySaveChecksum
    ld a, [wD09D]
    ld [wGoldLo], a
    ld a, [wD09E]
    ld [wGoldMid], a
    ld a, [wD09F]
    ld [wGoldHi], a
    farcall SaveGameToSRAMWithChecksum
    ld a, $05
    ld [wLinkSendByte], a
    ret

; entry 13 of the `rst $00` table in Func_033_5215_Table2_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wD7F5, wD7F6, wD781
; writes: wLinkSendByte, wD065, wD781
; points at: wRandomSeed2Hi, wD05A
Func_033_5215_Table2_Case05_Case0D::
Jump_033_5B38:: ; address name
    ld a, [wLinkMessage]
    cp a, $05
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld hl, wRandomSeed2Hi
    ld de, wD05A
    ld bc, $000B
    call CopyBytes
    farcall SetWD7F5ToWD789Cell5
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

; entry 14 of the `rst $00` table in Func_033_5215_Table2_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wD781, wRandomLo, wRandomHi
; writes: wD781, wBattleSetupFlagsLo, wBattleSetupFlagsHi, wLinkTimeoutLo, wLinkTimeoutHi, wLinkBufferPtrLo, wLinkBufferPtrHi, wLinkBufferCountLo, ...
; points at: wBattleSetupFlagsLo, wRandomSeed2Lo
Func_033_5215_Table2_Case05_Case0E::
Jump_033_5B68:: ; address name
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, [wRandomLo]
    ld [wBattleSetupFlagsLo], a
    ld a, [wRandomHi]
    ld [wBattleSetupFlagsHi], a
    ld hl, wBattleSetupFlagsLo
    ld a, l
    ld [wLinkTimeoutLo], a
    ld a, h
    ld [wLinkTimeoutHi], a
    ld hl, wRandomSeed2Lo
    ld a, l
    ld [wLinkBufferPtrLo], a
    ld a, h
    ld [wLinkBufferPtrHi], a
    ld a, $02
    ld [wLinkBufferCountLo], a
    xor a, a
    ld [wLinkBufferCountHi], a
    ld a, $FF
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ret

; entry 15 of the `rst $00` table in Func_033_5215_Table2_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wLinkRole, wRandomLo, wRandomHi, wD781, wRandomSeed2Lo, wRandomSeed2Hi
; writes: wLinkSendByte, wLinkReady, wRandomSeed2Lo, wRandomSeed2Hi, wD781, wRandomLo, wRandomHi
Func_033_5215_Table2_Case05_Case0F::
Jump_033_5BA5:: ; address name
    ld a, [wLinkMessage]
    cp a, $F0
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    xor a, a
    ld [wLinkReady], a
    ld a, [wLinkRole]
    bit 1, a
    jr nz, Jump_033_5BC8
    ld a, [wRandomLo]
    ld [wRandomSeed2Lo], a
    ld a, [wRandomHi]
    ld [wRandomSeed2Hi], a
    jr Jump_033_5BD4

Jump_033_5BC8::
    ld a, [wRandomSeed2Lo]
    ld [wRandomLo], a
    ld a, [wRandomSeed2Hi]
    ld [wRandomHi], a

Jump_033_5BD4::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 16 of the `rst $00` table in Func_033_5215_Table2_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781, wLinkSendByte
Func_033_5215_Table2_Case05_Case10::
Jump_033_5BDC:: ; address name
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, $D2
    ld [wLinkSendByte], a
    ret

; entry 17 of the `rst $00` table in Func_033_5215_Table2_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkSendByte, wGameMode, wModeState, wGameMode2State, wGameMode2Arg, wModeChangeRequest, wLinkSession, wLinkExchangeState, ...
Func_033_5215_Table2_Case05_Case11::
Jump_033_5BE9:: ; address name
    ld a, [wLinkMessage]
    cp a, $D2
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld a, $07
    ld [wGameMode], a
    xor a, a
    ld [wModeState], a
    ld [wGameMode2State], a
    ld [wGameMode2Arg], a
    ld a, $01
    ld [wModeChangeRequest], a
    ld a, $07
    ld [wLinkSession], a
    ld a, $00
    ld [wLinkExchangeState], a
    xor a, a
    ld [wLinkSendByte], a
    xor a, a
    ld [wLinkMessage], a
    ret

; entry 6 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; reads: wD781, wD780
; writes: wD781, wD782, wD780
Func_033_5215_Table2_Case06::
Jump_033_5C1A:: ; address name
    farcall ScriptCommandE8_Run
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

; entry 13 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; reads: wD780, wD7B5, wD7B6
; writes: wD7AB, wD7AF
Func_033_5215_Table2_Case0D::
Jump_033_5C36:: ; address name
    farcall RunWD780StateWhenNotFading_F1
    ld a, [wD780]
    cp a, $0E
    ret nz
    ld a, [wD7B5]
    ld [wD7AB], a
    ld a, [wD7B6]
    ld [wD7AF], a
    ret

; entry 14 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
Func_033_5215_Table2_Case0E::
Jump_033_5C4F:: ; address name
    ld a, [wD781]
    rst $00
    dw Func_033_5215_Table2_Case0E_Case00
    dw Func_033_5215_Table2_Case0E_Case01
    dw Func_033_5215_Table2_Case0E_Case01
    dw Func_033_5215_Table2_Case0E_Case03
    dw Func_033_5215_Table2_Case0E_Case04
    dw Func_033_5215_Table2_Case0E_Case05
    dw Func_033_5215_Table2_Case0E_Case06
    dw Func_033_5215_Table2_Case0E_Case07

; entry 0 of the `rst $00` table in Func_033_5215_Table2_Case0E
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex, wD781
Func_033_5215_Table2_Case0E_Case00::
Jump_033_5C63:: ; address name
    farcall ClearRecordPanelTiles
    ld de, Data_033_6331
    ld hl, wWindowTileBuffer + $64
    ld bc, $0A0B
    call CopyRectTo20ByteRowsJp_Bank33
    call DrawPlayerNameAndString0Category1
    ld hl, vTiles1 + $4E0
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0201
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, $01
    ld [wStringCategory], a
    ld [wStringIndex], a
    farcall ShowString_Bank07
    call SetDefaultStringWindow_Bank33
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 1 of the `rst $00` table in Func_033_5215_Table2_Case0E
; no direct call (reached through a table, a jump or a vector)
; points at: wD781
Func_033_5215_Table2_Case0E_Case01::
Jump_033_5CA7:: ; address name
    ld hl, wD781
    inc [hl]
    ret

; entry 3 of the `rst $00` table in Func_033_5215_Table2_Case0E
; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD7F6, hTemp0, wD7F1, wD7F2, wD7F3, wDigits, wD781
; writes: wD7F1, rRAMG2, rRAMB, wD09D, wD09E, wD7F2, wD7F3, wD781
Func_033_5215_Table2_Case0E_Case03::
Jump_033_5CAC:: ; address name
    farcall SetWD7F5ToWD789Cell5
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
    ldh a, [hTemp0]
    and a, $0F
    ld [wD09D], a
    ld a, [wD7F1]
    ld [wD09E], a
    farcall LoadFamilyIconTileForWD09D
    xor a, a
    ld [rRAMG2], a
    ld de, Data_033_5D5F
    ld hl, wWindowTileBuffer + $140
    ld bc, $0D02
    call CopyRectTo20ByteRowsJp_Bank33
    pop af
    ld [wD7F1], a
    ld hl, wWindowTileBuffer + $143
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
    ldh a, [hTemp0]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    farcall BlankLeadingZeroDigitsWC8C0
    ld a, [wDigits + $1]
    add a, $E0
    pop hl
    push hl
    ld [hl+], a
    ld a, [wDigits + $2]
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
    ldh a, [hTemp0]
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

; entry 4 of the `rst $00` table in Func_033_5215_Table2_Case0E
; no direct call (reached through a table, a jump or a vector)
Func_033_5215_Table2_Case0E_Case04::
Jump_033_5D79:: ; address name
    farcall ClearAndDrawWD789Cell5NameAtTiles1780
    ret

; entry 5 of the `rst $00` table in Func_033_5215_Table2_Case0E
; no direct call (reached through a table, a jump or a vector)
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wNameGlyphBuf
; points at: wKeyNameBuf, wLinkPartnerName, wNameGlyphBuf, wRandomSeed2Hi, wD781
Func_033_5215_Table2_Case0E_Case05::
Jump_033_5D80:: ; address name
    ld de, Data_033_62C3
    ld hl, wWindowTileBuffer + $6E
    ld bc, $0A0B
    call CopyRectTo20ByteRowsJp_Bank33
    ld de, wKeyNameBuf
    ld hl, wWindowTileBuffer + $B1
    call RunFunc6204FourTimes
    ld de, Data_033_6331
    ld hl, wWindowTileBuffer + $64
    ld bc, $0A0B
    call CopyRectTo20ByteRowsJp_Bank33
    ld de, wLinkPartnerName
    ld hl, wWindowTileBuffer + $A7
    call RunFunc6204FourTimes
    ld hl, vTiles2 + $50
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0501
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld de, wNameGlyphBuf
    ld hl, wRandomSeed2Hi
    ld bc, $000A
    call CopyBytes
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    ld de, vTiles2 + $50
    call CopyGlyphTilesToVRAM
    ld hl, wD781
    inc [hl]
    ret

; entry 6 of the `rst $00` table in Func_033_5215_Table2_Case0E
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex, wTwoChoiceCursor, wD781
Func_033_5215_Table2_Case0E_Case06::
Jump_033_5DDF:: ; address name
    ld hl, vTiles2 + $300
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0E01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a, a
    ld [wStringCategory], a
    ld a, $20
    ld [wStringIndex], a
    farcall ShowString_Bank1B_481A
    ld de, Data_033_63F9
    ld hl, wWindowTileBuffer + $E7
    ld bc, $0907
    call CopyRectTo20ByteRowsJp_Bank33
    call CopyWD789Cell5NameToWC130_Bank33
    call SetDefaultStringWindow_Bank33
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 7 of the `rst $00` table in Func_033_5215_Table2_Case0E
; no direct call (reached through a table, a jump or a vector)
; reads: wD7B2, wD7B3
; writes: hSpriteHideTile, wD782, wD780, wD781
Func_033_5215_Table2_Case0E_Case07::
Jump_033_5E23:: ; address name
    call BGMapAddressAtScroll_Bank33
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_33
    call BGMapAddressAtScroll_Bank33
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call DrawScreenBufferRectToBGMap_33
    ld a, $70
    ldh [hSpriteHideTile], a
    xor a, a
    ld [wD782], a
    ld a, [wD7B2]
    ld [wD780], a
    ld a, [wD7B3]
    ld [wD781], a
    call SetDefaultStringWindow_Bank33
    ret

; entry 15 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
Func_033_5215_Table2_Case0F::
Jump_033_5E57:: ; address name
    ld a, [wD781]
    rst $00
    dw Func_033_5215_Table2_Case0F_Case00
    dw Func_033_5215_Table2_Case0F_Case01
    dw Func_033_5215_Table2_Case0F_Case02
    dw Func_033_5215_Table2_Case0F_Case03
    dw Func_033_5215_Table2_Case0F_Case04
    dw Func_033_5215_Table2_Case0F_Case05
    dw Func_033_5215_Table2_Case0F_Case06
    dw Func_033_5215_Table2_Case0F_Case07

; entry 0 of the `rst $00` table in Func_033_5215_Table2_Case0F
; no direct call (reached through a table, a jump or a vector)
; reads: wD7AB, wD781
; writes: wD781
Func_033_5215_Table2_Case0F_Case00::
Jump_033_5E6B:: ; address name
    farcall ClearRecordPanelTiles
    ld de, Data_033_6438
    ld hl, wWindowTileBuffer + $64
    ld bc, $080B
    call CopyRectTo20ByteRowsJp_Bank33
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_033_63EF
    call StoreBAtWordTableEntry_Bank33
    call DrawPlayerNameAndString0Category1
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 3 of the `rst $00` table in Func_033_5215_Table2_Case0F
; no direct call (reached through a table, a jump or a vector)
Func_033_5215_Table2_Case0F_Case03::
Jump_033_5E93:: ; address name
    call CallDrawWD789Cell5RecordPanel
    ret

; entry 1 of the `rst $00` table in Func_033_5215_Table2_Case0F
; no direct call (reached through a table, a jump or a vector)
; reads: wD7B0, wD781
; writes: wD7F1, wD7F2, wD781
Func_033_5215_Table2_Case0F_Case01::
Jump_033_5E97:: ; address name
    call ListAvailableRecordsForSelection_Bank33
    farcall ClampRecordListPageCursor5
    ld a, [wD7B0]
    cp a, $02
    jr c, Jump_033_5EBE
    ld hl, wWindowTileBuffer + $12E
    call StoreC5BEC6AtHLStride2_Bank33
    ld hl, wWindowTileBuffer + $12F
    ld a, h
    ld [wD7F1], a
    ld a, l
    ld [wD7F2], a
    farcall DrawPageOfPagesAtWD7F1_Bank1E

Jump_033_5EBE::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 2 of the `rst $00` table in Func_033_5215_Table2_Case0F
; no direct call (reached through a table, a jump or a vector)
; writes: wD7F1
Func_033_5215_Table2_Case0F_Case02::
Jump_033_5EC6:: ; address name
    farcall DrawRecordListPageNames
    xor a, a
    ld [wD7F1], a
    farcall MarkPartyMembersInRecordListPage
    ret

; entry 4 of the `rst $00` table in Func_033_5215_Table2_Case0F
; no direct call (reached through a table, a jump or a vector)
Func_033_5215_Table2_Case0F_Case04::
Jump_033_5ED7:: ; address name
    call CallClearAndDrawWD789Cell5Name
    ret

; entry 5 of the `rst $00` table in Func_033_5215_Table2_Case0F
; no direct call (reached through a table, a jump or a vector)
Func_033_5215_Table2_Case0F_Case05::
Jump_033_5EDB:: ; address name
    call CopyRect62C3ToWC36EAndIncWD781
    ret

; entry 6 of the `rst $00` table in Func_033_5215_Table2_Case0F
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex, wD7AD, wD781
; points at: wKeyNameBuf
Func_033_5215_Table2_Case0F_Case06::
Jump_033_5EDF:: ; address name
    ld hl, vTiles2 + $700
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0C01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a, a
    ld [wStringCategory], a
    ld a, $1E
    ld [wStringIndex], a
    farcall ShowString_Bank1B_481A
    call CopyWD789Cell5NameToWC130_Bank33
    call SetDefaultStringWindow_Bank33
    xor a, a
    ld a, $12
    ld [wStringIndex], a
    farcall ShowString_Bank1B_481A
    ld de, wKeyNameBuf
    ld hl, wWindowTileBuffer + $B1
    call RunFunc6204FourTimes
    ld de, Data_033_63C7
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRowsJp_Bank33
    xor a, a
    ld [wD7AD], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 7 of the `rst $00` table in Func_033_5215_Table2_Case0F
; no direct call (reached through a table, a jump or a vector)
; reads: wD7B2, wD7B3
; writes: hSpriteHideTile, wD782, wD780, wD781
Func_033_5215_Table2_Case0F_Case07::
Jump_033_5F37:: ; address name
    call BGMapAddressAtScroll_Bank33
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_33
    call BGMapAddressAtScroll_Bank33
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call DrawScreenBufferRectToBGMap_33
    ld a, $70
    ldh [hSpriteHideTile], a
    xor a, a
    ld [wD782], a
    ld a, [wD7B2]
    ld [wD780], a
    ld a, [wD7B3]
    ld [wD781], a
    call SetDefaultStringWindow_Bank33
    ret

; with SRAM bank 0 enabled, LoadSRAMRecordByte with A = wD7DD (C = field from the caller); then disables SRAM (E-0119)
; no direct call (reached through a table, a jump or a vector)
; writes: rRAMG2, rRAMB
; points at: wD7DD
LoadRecordByteForWD7DD:: ; heuristic: follows a terminator; C0
Func_033_5F6B:: ; address name
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

; copies box Data_033_639F to wC410 and runs RunFunc6204FourTimes for wC895 at wC3B1 (E-0126)
; 2 call sites from 2 routines (e.g. Func_033_5215_Table2_Case04_Case0C, Func_033_5215_Table2_Case04_Case0B)
; points at: wKeyNameBuf
DrawBox639FAndKeyRows::
Func_033_5F83:: ; address name
    ld de, Data_033_639F
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRowsJp_Bank33
    ld de, wKeyNameBuf
    ld hl, wWindowTileBuffer + $B1
    call RunFunc6204FourTimes
    ret

; lists in wD789 the stored records (state 1, or 2 unless wD7DC is 3) whose field $6E is clear and that are not already chosen in wD7DD; count in wD7A9 (E-0130)
; 1 call site from 1 routine (e.g. Func_033_5215_Table2_Case0F_Case01)
; reads: wD7DC, wD7B9
; writes: wD7A9, rRAMG2, rRAMB, wD7B9
; points at: wD789, wD7BE, sA000, wD7DD
ListAvailableRecordsForSelection_Bank33::
Func_033_5F99:: ; address name
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
    farcall MovePartyRecordsToFrontOfList
    ret

; the same 16 bytes as ShowStringA10_Bank1B (1B:7439)
; 3 call sites from 3 routines (e.g. Func_033_5215_Table2_Case02_Case01, Func_033_5215_Table2_Case04_Case0C, Func_033_5215_Table2_Case04_Case08)
; writes: wStringIndex, wStringCategory
ShowStringA10_Bank33::
Func_033_6039:: ; address name
    add a, $10
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank1B_480C
    ret

; sets the string window: wC52D/wC52E = vTiles1 ($8800), wC52F/wC530 = $02, $12 (E-0067) (the same 23 bytes appear in 2 banks)
; 9 call sites from 9 routines (e.g. Func_033_5215_Case00, Func_033_5215_Table2_Case04_Case09, Func_033_5215_Table2_Case04_Case07, Func_033_5215_Table2_Case05_Case04, ...)
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
SetDefaultStringWindow_Bank33::
Func_033_6049:: ; address name
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ret

; wD7DD = the record index at WD789 cell 5 (E-0126)
; 2 call sites from 2 routines (e.g. Func_033_5215_Table2_Case04_Case0A, Func_033_5215_Table2_Case04_Case08)
; reads: wD7F5, wD7F6
; points at: wD7DD
StoreWD789Cell5RecordInWD7DD::
Func_033_6060:: ; address name
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld de, wD7DD
    ld a, [hl]
    ld [de], a
    ret

; copies the name of the record at WD789 cell 5 (11 bytes) to wC130 (E-0124)
; 3 call sites from 3 routines (e.g. Func_033_5215_Table2_Case04_Case08, Func_033_5215_Table2_Case0E_Case06, Func_033_5215_Table2_Case0F_Case06)
; reads: wD7F5, wD7F6
; writes: rRAMG2, rRAMB, rRAMG
; points at: wNameGlyphBuf, wTextBuf0
CopyWD789Cell5NameToWC130_Bank33::
Func_033_6074:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld c, $01
    call CopyRecordNameToWC8CF
    ld hl, wNameGlyphBuf
    ld de, wTextBuf0
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

; wD7B4 = wD7DC, wD7E0 = $FF, wD7DC = 4, wD782 = 0 and wD781 += 1 (E-0126)
; 1 call site from 1 routine (e.g. Func_033_5215_Table2_Case04_Case0C)
; reads: wD7DC, wD781
; writes: wD7B4, wD7E0, wD7DC, wD782, wD781
FinishWD7DDEntryAndStep_33::
Func_033_60A7:: ; address name
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

; HL = table of 16-bit addresses, A = index: stores B at the address in entry A; keeps BC; clobbers A, DE, HL (the same 16 bytes appear in 4 banks)
; 4 call sites from 3 routines (e.g. Func_033_5215_Table2_Case04_Case08, Func_033_5215_Table2_Case04_Case07, Func_033_5215_Table2_Case0F_Case00)
StoreBAtWordTableEntry_Bank33::
Func_033_60C3:: ; address name
    push bc
    sla a
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    pop bc
    ld a, b
    ld [de], a
    ret

; HL = $9800 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY); clobbers A, DE (the same 41 bytes appear in 3 banks)
; 11 call sites from 9 routines (e.g. Func_033_5215_Case01, Func_033_5215_Case06_Case01, Func_033_5215_Table2_Case04_Case0C, Func_033_5215_Table2_Case04_Case0B, ...)
; reads: hScrollY, hScrollX
BGMapAddressAtScroll_Bank33::
Func_033_60D3:: ; address name
    ldh a, [hScrollY]
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
    ldh a, [hScrollX]
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

; copies a rectangle of the screen buffer (offset DE) to the BG map at HL, sets wC554 = HL + $1C1, and on CGB copies its attributes (E-0127)
; 11 call sites from 9 routines (e.g. Func_033_5215_Case01, Func_033_5215_Case06_Case01, Func_033_5215_Table2_Case04_Case0C, Func_033_5215_Table2_Case04_Case0B, ...)
; reads: wIsCGB
; writes: wTextCursorLo, wTextCursorHi, rSVBK
; points at: wScreenTileBuffer
DrawScreenBufferRectToBGMap_33::
Func_033_60FC:: ; address name
    push de
    push bc
    push hl
    ld hl, wScreenTileBuffer
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    pop hl
    push hl
    xor a, a
    call CopyRectFromBankToBGMapWrapped
    pop hl
    push hl
    ld a, l
    add a, $C1
    ld l, a
    ld a, h
    adc a, $01
    ld h, a
    ld a, l
    ld [wTextCursorLo], a
    ld a, h
    ld [wTextCursorHi], a
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
    ld hl, wRecordBufferData + $12
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    pop hl
    xor a, a
    call CopyRectFromBankToBGMapWrapped
    call WaitForVRAMAccess
    ld a, $00
    ldh [rSVBK], a
    ld c, $4F
    ld a, $00
    ldh [c], a
    ret

; the same instructions as CopyRectTo20ByteRowsJp_Bank24: copies a B x C rectangle from DE to HL with rows 20 bytes apart; on CGB zero-fills the same rectangle at HL + $0E68 with rSVBK = 2 (E-0072)
; 14 call sites from 11 routines (e.g. Func_033_5215_Case00, DrawBox639FAndKeyRows, Func_033_5215_Table2_Case04_Case09, CopyRect62C3ToWC36EAndIncWD781, ...)
; reads: wIsCGB
; writes: rSVBK
CopyRectTo20ByteRowsJp_Bank33::
Func_033_6152:: ; address name
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

; writes the gold as up to five decimal digit tiles without leading zeros at wC1BA (E-0127)
; 1 call site from 1 routine (e.g. Func_033_5215_Case01)
; reads: wGoldLo, wGoldMid, wGoldHi, hTemp2, hTemp1, hTemp0
; writes: wDigits
WriteGoldDigitsToWC1BA::
Func_033_6197:: ; address name
    ld a, [wGoldLo]
    ld l, a
    ld a, [wGoldMid]
    ld h, a
    ld a, l
    ld [wDigits], a
    ld a, h
    ld [wDigits + $1], a
    ld a, [wGoldHi]
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    ld c, $00
    ld hl, wScreenTileBuffer + $22
    ldh a, [hTemp2]
    and a, $0F
    jr z, Jump_033_61C0
    add a, $E0
    ld [hl], a
    set 0, c

Jump_033_61C0::
    inc hl
    ldh a, [hTemp1]
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
    ldh a, [hTemp1]
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
    ldh a, [hTemp0]
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
    ldh a, [hTemp0]
    and a, $0F
    add a, $E0
    ld [hl], a
    ret

; calls Func_033_6204 three times and falls into it once more (E-0122)
; 7 call sites from 6 routines (e.g. Func_033_5215_Case01, DrawBox639FAndKeyRows, Func_033_5215_Table2_Case04_Case07, Func_033_5215_Table2_Case05_Case04, ...)
; reads: wDigits
RunFunc6204FourTimes::
Func_033_61FB:: ; address name
    call RunFunc6204FourTimes_Sub01
    call RunFunc6204FourTimes_Sub01
    call RunFunc6204FourTimes_Sub01

; only called from RunFunc6204FourTimes (E-0047)
; 3 call sites from 1 routine (e.g. RunFunc6204FourTimes)
; reads: wDigits
RunFunc6204FourTimes_Sub01::
Func_033_6204:: ; address name
    push hl
    ld a, [de]
    inc de
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    pop hl
    ld a, [wDigits + $1]
    or a, a
    jr z, Jump_033_6217
    add a, $E0
    ld [hl], a

Jump_033_6217::
    inc hl
    ld a, [wDigits + $2]
    add a, $E0
    ld [hl], a
    ld a, l
    add a, $27
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ret

; writes $C3 at the addresses held by entries 0 to C - 1 of the word table at HL (E-0124)
; 1 call site from 1 routine (e.g. Func_033_5215_Table2_Case04_Case0B)
WriteC3AtWordTableEntries_Bank33::
Func_033_6227:: ; address name
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
    add_a_to_hl
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

; clears vTiles2 (size $0105), draws the 10-byte player name wC60C there, then shows string 0 of category 1 (ShowString_Bank07) at vTiles2 + $100 with size $0110 (E-0121)
; 3 call sites from 3 routines (e.g. Func_033_5215_Case00, Func_033_5215_Table2_Case0E_Case00, Func_033_5215_Table2_Case0F_Case00)
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wNameGlyphBuf, wStringCategory, wStringIndex
; points at: wNameGlyphBuf, wPlayerName
DrawPlayerNameAndString0Category1::
Func_033_6247:: ; address name
    ld hl, vTiles2
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0501
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld de, wNameGlyphBuf
    ld hl, wPlayerName
    ld bc, $000A
    call CopyBytes
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    ld de, vTiles2
    call CopyGlyphTilesToVRAM
    ld hl, vTiles2 + $100
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1001
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, $01
    ld [wStringCategory], a
    xor a, a
    ld [wStringIndex], a
    farcall ShowString_Bank07
    ret

; [HL] = $C5, [HL+2] = $BE, [HL+4] = $C6; HL ends at HL+4; clobbers A (the same 14 bytes appear in 8 banks)
; 1 call site from 1 routine (e.g. Func_033_5215_Table2_Case0F_Case01)
StoreC5BEC6AtHLStride2_Bank33::
Func_033_629D:: ; address name
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

; ld de, this bank's string table / BeginStringDisplay
; 2 call sites from 2 routines (e.g. ShowString_Bank33_649E, DebugMessageTest_Update_Case1A)
BeginStringDisplay_Bank33_6490::
Func_033_6490:: ; address name
    ld de, Data_033_64A5
    call BeginStringDisplay
    ret
    db $11, $A5, $64, $CD, $FE, $25, $C9

; Func_033_6490 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; 3 call sites from 1 routine (e.g. ScriptCommandF7_Run_Case00)
ShowString_Bank33_649E::
Func_033_649E:: ; address name
    call BeginStringDisplay_Bank33_6490
    call RunStringDisplayToEnd
    ret

Data_033_64A5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0CE4A5, $72
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You", $42, "e finished", $F1
    db "that Class.", $F7
    db $F0, $EB
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Which Class will", $F1
    db "you challenge?", $F0, $EB
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Train some"

Data_033_6564:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " more,", $F1
    db "and see you again!", $F7
    db $F0, $EB
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Let me confirm", $F1
    db "that-the ", $F9, "0 Class?", $F0, $EB
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Good luck! I'll", $F1
    db "cheer for you!", $F7
    db $F0, $EB
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Not enough gold", $F1
    db "for that Class!", $F7
    db $F0, $EB
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh", $A4, " The crowd", $F1
    db "wanted to see you", $A4, $F7
    db $F0, $EB
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " How many masters", $F1
    db "in the group?", $F0, $EB
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Will you try a", $F1
    db "Master Battle?", $F0, $EB
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The S Class", $F1
    db "should be good.", $FA, $F7
    db $EF, $EE, "Which Class will", $EF, $EE, "you challenge?", $F0, $EB
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The A Class", $F1
    db "should be good.", $FA, $F7
    db $EF, $EE, "Which Class will", $EF, $EE, "you challenge?", $F0, $EB
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The B Class", $F1
    db "should be good.", $FA, $F7
    db $EF, $EE, "Which Class will", $EF, $EE, "you challenge?", $F0, $EB
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " It could get", $F1
    db "rough out there.", $FA, $F7
    db $EF, $EE, "Which Class will", $EF, $EE, "you challenge?", $F0, $EB
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " It "

Data_033_6766:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "could get", $F1
    db "rough out there.", $FA, $F7
    db $EF, $EE, "Which Class will", $EF, $EE, "you challenge?", $F0, $EB
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " The E Class", $F1
    db "should do.", $FA, $F7
    db $EF, $EE, "Which Class will", $EF, $EE, "you challenge?", $F0, $EB
    db $45, $90, $12, $36, $90, $F9, $00, $90, $0C, $2F, $24, $36, $36, $90, $18, $14
    db $98, $F0, $EB, $45, $90, $12, $90, $2B, $32, $33, $28, $90, $3C, $32, $38, $90
    db $27, $32, $F1, $3A, $28, $2F, $2F, $99, $F7, $F0, $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You need more", $F1
    db "gold to register.", $F7
    db $F0, $EB
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You can't try", $F1
    db "that Class yet.", $F7
    db $F0, "lasSABCDE"
    db $AC, $17, $32, $F0, $0B, $24, $37, $37, $2F, $28, $36, $90, $0C, $32, $36, $37
    db $F0, $12, $17, $0F, $18, $1D, $0E, $1C, $14, $15, $19, $0A, $F0, $2F, $24, $36
    db $1C, $0A, $0B, $0C, $0D, $0E, $AC, $17, $32, $F0, $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Congratulations!", $F1
    db "You did it!", $FA, $F7
    db $EF, $EE, "You", $42, "e won the", $EF, $EE, "Kids", $95, " Class!", $FA, $F7
    db $EF, $EE, "The King will give", $EF, $EE, "you his official", $FA, $F7
    db $EF, $EE, "recognition as a", $EF, $EE, "monster master.", $FA, $F7
    db $EF, $EE, "You can use the", $EF, $EE, "Starry Shrine and", $FA, $F7
    db $EF, $EE, "the Egg Evaluator's", $EF, $EE, "services now.", $FA, $F7
    db $EF, $EE, "You'll be"

Data_033_6968:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " facing", $EF, $EE, "grownups here from", $FA, $F7
    db $EF, $EE, "now on, so keep", $EF, $EE, "training hard.", $FA, $F7
    db $EF, $EE, "Here's your prize", $EF, $EE, "-the Pirate Key!", $F7
    db $F0, $EB
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Congratulations!", $F1
    db "You did it!", $FA, $F7
    db $EF, $EE, "You", $42, "e won the", $EF, $EE, "C Class!", $FA, $F7
    db $EF, $EE, "Here's your prize", $EF, $EE, "-a  Magic Key!", $F7
    db $F0, $EB
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Congratulations!", $F1
    db "You did it!", $FA, $F7
    db $EF, $EE, "You", $42, "e won the", $EF, $EE, "B Class!", $FA, $F7
    db $EF, $EE, "Here's your prize", $EF, $EE, "-a  Magic Key!", $F7
    db $F0, $EB
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Congratulations!", $F1
    db "You did it!", $FA, $F7
    db $EF, $EE, "You", $42, "e won the", $EF, $EE, "A Class!", $FA, $F7
    db $EF, $EE, "Here's your prize", $EF, $EE, "-a  Magic Key!", $F7
    db $F0, $EB
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Congratulations!", $F1
    db "You did it!", $FA, $F7
    db $EF, $EE, "You", $42, "e finally won", $EF, $EE, "the S Class!", $FA, $F7
    db $EF, $EE, "You can now choose", $EF, $EE, "any Class you want", $FA, $F7
    db $EF, $EE, "by paying th"

Data_033_6B6A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "e", $EF, $EE, "class entry fee.", $FA, $F7
    db $EF, $EE, "There are prizes", $EF, $EE, "for winners too.", $FA, $F7
    db $EF, $EE, "Naturally, the", $EF, $EE, "level of battling", $FA, $F7
    db $EF, $EE, "becomes much more", $EF, $EE, "difficult.", $FA, $F7
    db $EF, $EE, "Plan and prepare", $EF, $EE, "wisely!", $F7
    db $F0, $EB
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Too bad you", $F1
    db "didn't make it.", $FA, $F7
    db $EF, $EE, "It's hard to win", $EF, $EE, "if your monsters", $FA, $F7
    db $EF, $EE, "aren't leveled up", $EF, $EE, "enough.", $FA, $F7
    db $EF, $EE, "I hope you do", $EF, $EE, "better next time.", $F7
    db $F0, $EB
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Too bad you", $F1
    db "didn't make it.", $FA, $F7
    db $EF, $EE, "You can create", $EF, $EE, "tougher monsters", $FA, $F7
    db $EF, $EE, "by leveling up", $EF, $EE, "those you bred.", $FA, $F7
    db $EF, $EE, "I hope you do", $EF, $EE, "better next time.", $F7
    db $F0, $EB
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Congratulations!", $F1
    db $F9, "0 does it!", $FA, $F7
    db $EF, $EE, "You", $42, "e won", $EF, $EE, $F9, "GG!", $FA, $F7
    db $EF, $EE, "We hope you'll", $EF, $EE, "battle here agai"

Data_033_6D6C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "n!", $F7
    db $F0, $EB
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You lost?", $F1
    db "That's too bad.", $FA, $F7
    db $EF, $EE, "Try again after", $EF, $EE, "leveling up your", $FA, $F7
    db $EF, $EE, "monsters some", $EF, $EE, "more.", $F7
    db $F0, $F9, "0 received", $F1
    db "the Magic Key."
    db $E5, $58, $F7, $E9, $FF, $F0, $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $A4, "Oh, but your", $F1
    db "key ring is full.", $FA, $F7
    db $EF, $EE, "You'll have to", $EF, $EE, "make room, and", $FA, $F7
    db $EF, $EE, "come back for this", $EF, $EE, "later.", $F7
    db $F0, $EB
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Here's the Magic", $F1
    db "Key you"
    db $44
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " won!", $F7
    db $F0, $F9, "0 received", $F1
    db "the Pirate Key."
    db $E5, $58, $F7, $E9, $FF, $F0, $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Here's the Pirate", $F1
    db "Key you"
    db $44, $90, $3A, $32, $31, $99, $F7, $F0, $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Congratulations!", $F1
    db "You did it!", $FA, $F7
    db $EF, $EE, "You", $42, "e won the", $EF, $EE, $F9, "0 Class!", $FA, $F7
    db $EF, $EE, "Choose one of", $EF, $EE, "these chests!", $F7
    db $F0, $EB
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Do you want the", $F1
    db "left chest?", $F0, $EB
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Do you want the", $F1
    db "right chest?", $F0, $EB
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Your prize is", $F1
    db "one ", $F9, "G!", $F7
    db $F0, $EB
    db $45, $90, $22, $32

Data_033_6F6E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ur prize is", $F1
    db "a Magic Key!", $F7
    db $F0, $EB
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $A4, "Oh, but you", $F1
    db "have no room.", $FA, $F7
    db $EF, $EE, "Well, instead of", $EF, $EE, "the ", $F9, "G,", $FA, $F7
    db $EF, $EE, "here's 6000G.", $EF, $EE, $F7
    db $F0, $EB
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $A4, "Oh, but your", $F1
    db "key ring is full.", $FA, $F7
    db $EF, $EE, "Well, instead of", $EF, $EE, "the Magic Key,", $FA, $F7
    db $EF, $EE, "here's 6000G", $EF, $EE, "instead.", $F7
    db $F0

; ld de, this bank's string table / BeginStringDisplay
; 3 call sites from 3 routines (e.g. ShowString_Bank33_7045, DebugMessageTest_Update_Case1F, ShowStringAInDefaultWindow_Bank24)
BeginStringDisplay_Bank33_7037::
Func_033_7037:: ; address name
    ld de, Data_033_704C
    call BeginStringDisplay
    ret
    db $11, $4C, $70, $CD, $FE, $25, $C9

; Func_033_7037 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; 7 call sites from 7 routines (e.g. GameMode6_Update_Case05_Case07, GameMode6_Update_Case0E_Case00, GameMode6_Update_Case0E_Case04, GameMode6_Update_Case0F_Case00, ...)
ShowString_Bank33_7045::
Func_033_7045:: ; address name
    call BeginStringDisplay_Bank33_7037
    call RunStringDisplayToEnd
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
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "It ends in a draw!", $FA, $F7
    db $F0

Data_033_7089:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Congratulations!", $F1
    db "You", $42, "e won!", $FA, $F7
    db $F0

Data_033_70A7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Too bad!", $F1
    db "You", $42, "e lost!", $FA, $F7
    db $F0

Data_033_70BE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Turned over", $F1
    db $F9, "0", $A4, $FA, $F7
    db $F0

Data_033_70D0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Received", $F1
    db $F9, "0", $FA, $F7
    db $F0

Data_033_70DE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "But you have no", $F1
    db "room for it", $A4, $FA, $F7
    db $EF, $EE, "Switch it with", $EF, $EE, "another monster?", $F0

Data_033_711F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gave up on getting", $F1
    db $F9, "0 and released", $FA, $F7
    db $EF, $EE, "it in the wild", $A4, $FA, $F7
    db $F0

Data_033_7157:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Switch with which?", $F0

Data_033_716A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Switch"

Data_033_7170:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " with which?", $F0

Data_033_717D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Switch which egg?", $F0

Data_033_718F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0", $F1
    db "was released.", $FA, $F7
    db $F0

Data_033_71A2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MonsterE?g", $F0

Data_033_71AD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "YesNo", $F0

Data_033_71B3:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "InfoOKYesN", $F0

Data_033_71BE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "There are no eggs.", $F0

Data_033_71D1:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "You'll be left", $F1
    db "with no monster.", $F0
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
