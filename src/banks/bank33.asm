SECTION "Bank 33", ROMX[$4000], BANK[$33]
    db $33

; DE = block number: the table at $405F gives each block an offset into wScreenTileBuffer (word), a width B and a height C, followed by B * C tile bytes; they are copied into wScreenTileBuffer rows 32 bytes apart
; 64 call sites from 38 routines (e.g. LoadScreenBlocks00To03, LoadScreenBlocks00And04To06, LoadScreenBlocks00_07_08, LoadScreenBlocks00_09_0A, ...)
; points at: wScreenTileBuffer
CopyBlockToTileBuffer::
Func_033_4001:: ; address name
    ld d, $00
    ld hl, ScreenBlockTable
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
    ld hl, ScreenBlockTable
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

; E-0232 (C1: CopyBlockToTileBuffer and CopyBlockToTileBufferBlankingText read the word at $405F + 2 * E and copy that record (word offset into wScreenTileBuffer, width, rows, tiles) into the screen buffer; 51 words, and the records tile $40C5-$51C6).
; record: screen block record
ScreenBlockTable::
Data_033_405F:: ; address name
    dw TileRect_33_40C5 ; id 0
    dw TileRect_33_4111 ; id 1
    dw TileRect_33_41B1 ; id 2
    dw TileRect_33_41D9 ; id 3
    dw TileRect_33_4219 ; id 4
    dw TileRect_33_42A1 ; id 5
    dw TileRect_33_42DD ; id 6
    dw TileRect_33_4335 ; id 7
    dw TileRect_33_4411 ; id 8
    dw TileRect_33_444D ; id 9
    dw TileRect_33_4529 ; id 10
    dw TileRect_33_4789 ; id 11
    dw TileRect_33_479F ; id 12
    dw TileRect_33_480F ; id 13
    dw TileRect_33_489F ; id 14
    dw TileRect_33_4909 ; id 15
    dw TileRect_33_492B ; id 16
    dw TileRect_33_4993 ; id 17
    dw TileRect_33_49DF ; id 18
    dw TileRect_33_49DF ; id 19
    dw TileRect_33_49DF ; id 20
    dw TileRect_33_49DF ; id 21
    dw TileRect_33_49DF ; id 22
    dw TileRect_33_49DF ; id 23
    dw TileRect_33_49DF ; id 24
    dw TileRect_33_49DF ; id 25
    dw TileRect_33_49DF ; id 26
    dw TileRect_33_49DF ; id 27
    dw TileRect_33_4A29 ; id 28
    dw TileRect_33_4A75 ; id 29
    dw TileRect_33_4B2D ; id 30
    dw TileRect_33_4B2D ; id 31
    dw TileRect_33_4B2D ; id 32
    dw TileRect_33_4B79 ; id 33
    dw TileRect_33_4C40 ; id 34
    dw TileRect_33_4CA6 ; id 35
    dw TileRect_33_4D31 ; id 36
    dw TileRect_33_4D66 ; id 37
    dw TileRect_33_4D88 ; id 38
    dw TileRect_33_4DA1 ; id 39
    dw TileRect_33_4E08 ; id 40
    dw TileRect_33_4E8A ; id 41
    dw TileRect_33_4EFA ; id 42
    dw TileRect_33_4FDA ; id 43
    dw TileRect_33_4FFC ; id 44
    dw TileRect_33_505A ; id 45
    dw TileRect_33_4535 ; id 46
    dw TileRect_33_4594 ; id 47
    dw TileRect_33_4641 ; id 48
    dw TileRect_33_4749 ; id 49
    dw TileRect_33_48D4 ; id 50

; E-0232 (C1: a record of ScreenBlockTable).
; record: offset $0000 (row 0, column 0); 8 x 9 tiles
TileRect_33_40C5::
Data_033_40C5:: ; address name
    dw $0000 ; entry 0
    db $08, $09
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $C3, $A4, $A5, $A6, $A7, $C3, $B7
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $BA
    db $B6, $C3, $D0, $D1, $D2, $D3, $D4, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $D5, $D6, $D7, $D8, $D9, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $DA, $DB, $DC, $DD, $DE, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; E-0232 (C1: a record of ScreenBlockTable).
; record: offset $0008 (row 0, column 8); 12 x 13 tiles
TileRect_33_4111::
Data_033_4111:: ; address name
    dw $0008 ; entry 0
    db $0C, $0D
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $C3, $EA, $ED, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA
    db $B6, $C3, $AE, $A8, $AB, $C3, $C3, $ED, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $EE, $A9, $A6, $C3, $C3, $ED, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $AE, $BF, $AC, $C3, $C3, $ED, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $A4, $A5, $A8, $C3, $C3, $ED, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $EF, $AC, $EE, $C3, $C3, $ED, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; E-0232 (C1: a record of ScreenBlockTable).
; record: offset $0161 (row 11, column 1); 6 x 6 tiles
TileRect_33_41B1::
Data_033_41B1:: ; address name
    dw $0161 ; entry 0
    db $06, $06
    db $5C, $5D, $5E, $5F, $60, $61
    db $62, $63, $64, $65, $66, $67
    db $68, $69, $6A, $6B, $6C, $6D
    db $6E, $6F, $70, $71, $72, $73
    db $74, $75, $76, $77, $78, $79
    db $7A, $7B, $7C, $7D, $7E, $7F

; E-0232 (C1: a record of ScreenBlockTable).
; record: offset $01A8 (row 13, column 8); 12 x 5 tiles
TileRect_33_41D9::
Data_033_41D9:: ; address name
    dw $01A8 ; entry 0
    db $0C, $05
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $F9, $FA, $ED, $C3, $C3, $C3, $BE, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $FB, $FA, $ED, $C3, $C3, $C3, $BE, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; E-0232 (C1: a record of ScreenBlockTable).
; record: offset $0008 (row 0, column 8); 12 x 11 tiles
TileRect_33_4219::
Data_033_4219:: ; address name
    dw $0008 ; entry 0
    db $0C, $0B
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $C3, $EA, $ED, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA
    db $B6, $4C, $4D, $4E, $4F, $50, $51, $52, $53, $54, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $55, $56, $57, $58, $59, $5A, $5B, $5C, $5D, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $EC, $EC, $ED, $47, $48, $49, $4A, $4B, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; E-0232 (C1: a record of ScreenBlockTable).
; record: offset $0160 (row 11, column 0); 8 x 7 tiles
TileRect_33_42A1::
Data_033_42A1:: ; address name
    dw $0160 ; entry 0
    db $08, $07
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $35, $36, $37, $38, $39, $3A, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $3B, $3C, $3D, $3E, $3F, $40, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3

; E-0232 (C1: a record of ScreenBlockTable).
; record: offset $0168 (row 11, column 8); 12 x 7 tiles
TileRect_33_42DD::
Data_033_42DD:: ; address name
    dw $0168 ; entry 0
    db $0C, $07
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $FD, $ED, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA
    db $B6, $A5, $CF, $F1, $F2, $C3, $AC, $CF, $F3, $CF, $F4, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $FD, $ED, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; E-0232 (C1: a record of ScreenBlockTable).
; record: offset $0008 (row 0, column 8); 12 x 18 tiles
TileRect_33_4335::
Data_033_4335:: ; address name
    dw $0008 ; entry 0
    db $0C, $12
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $C3, $38, $39, $3A, $3B, $3C, $3D, $3E, $3F, $40, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $41, $42, $43, $44, $45, $46, $47, $48, $49, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $4A, $4B, $4C, $4D, $4E, $4F, $50, $51, $52, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $53, $54, $55, $56, $57, $58, $59, $5A, $5B, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $5C, $5D, $5E, $5F, $60, $61, $62, $63, $64, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $65, $66, $67, $68, $69, $6A, $6B, $6C, $6D, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $6E, $6F, $70, $71, $72, $73, $74, $75, $76, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $77, $78, $79, $7A, $7B, $7C, $7D, $7E, $7F, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; E-0232 (C1: a record of ScreenBlockTable).
; record: offset $0160 (row 11, column 0); 8 x 7 tiles
TileRect_33_4411::
Data_033_4411:: ; address name
    dw $0160 ; entry 0
    db $08, $07
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3

; E-0232 (C1: a record of ScreenBlockTable).
; record: offset $0008 (row 0, column 8); 12 x 18 tiles
TileRect_33_444D::
Data_033_444D:: ; address name
    dw $0008 ; entry 0
    db $0C, $12
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $F5, $F6, $DF, $CF, $ED, $58, $59, $5A, $5B, $5C, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $5D, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $5E, $5F, $60, $61, $62, $63, $64, $65, $66, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $EC, $EC, $ED, $67, $68, $69, $6A, $6B, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $EC, $F6, $F2, $CF, $ED, $6C, $6D, $6E, $6F, $70, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $71, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $72, $73, $74, $75, $76, $77, $78, $79, $7A, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $EC, $EC, $ED, $7B, $7C, $7D, $7E, $7F, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; E-0232 (C1: a record of ScreenBlockTable).
; record: offset $0183 (row 12, column 3); 2 x 4 tiles
TileRect_33_4529::
Data_033_4529:: ; address name
    dw $0183 ; entry 0
    db $02, $04
    db $C3, $0F
    db $11, $10
    db $12, $10
    db $C3, $13

; E-0232 (C1: a record of ScreenBlockTable).
; record: offset $0000 (row 0, column 0); 7 x 13 tiles
TileRect_33_4535::
Data_033_4535:: ; address name
    dw $0000 ; entry 0
    db $07, $0D
    db $B0, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $D0, $D1, $D2, $D3, $D4, $B7
    db $B8, $B9, $B9, $B9, $B9, $B9, $BA
    db $B6, $EB, $C3, $C3, $C3, $C3, $B7
    db $B6, $EC, $C3, $C3, $C3, $C3, $B7
    db $B6, $EA, $ED, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B5
    db $C3, $14, $15, $16, $17, $18, $19
    db $C3, $1A, $1B, $1C, $1D, $1E, $1F
    db $C3, $20, $21, $22, $23, $24, $25
    db $C3, $26, $27, $28, $29, $2A, $2B
    db $C3, $2C, $2D, $2E, $2F, $30, $31
    db $C3, $32, $33, $34, $35, $36, $37

; E-0232 (C1: a record of ScreenBlockTable).
; record: offset $0000 (row 0, column 0); 13 x 13 tiles
TileRect_33_4594::
Data_033_4594:: ; address name
    dw $0000 ; entry 0
    db $0D, $0D
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $D0, $D1, $D2, $D3, $D4, $C3, $D5, $D6, $D7, $D8, $D9, $B7
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA
    db $B6, $EB, $C3, $C3, $C3, $C3, $C3, $EB, $C3, $C3, $C3, $C3, $B7
    db $B6, $EC, $C3, $C3, $C3, $C3, $C3, $EC, $C3, $C3, $C3, $C3, $B7
    db $B6, $EA, $ED, $C3, $C3, $C3, $C3, $EA, $ED, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5
    db $C3, $14, $15, $16, $17, $18, $19, $38, $39, $3A, $3B, $3C, $3D
    db $C3, $1A, $1B, $1C, $1D, $1E, $1F, $3E, $3F, $40, $41, $42, $43
    db $C3, $20, $21, $22, $23, $24, $25, $44, $45, $46, $47, $48, $49
    db $C3, $26, $27, $28, $29, $2A, $2B, $4A, $4B, $4C, $4D, $4E, $4F
    db $C3, $2C, $2D, $2E, $2F, $30, $31, $50, $51, $52, $53, $54, $55
    db $C3, $32, $33, $34, $35, $36, $37, $56, $57, $58, $59, $5A, $5B

; E-0232 (C1: a record of ScreenBlockTable).
; record: offset $0000 (row 0, column 0); 20 x 13 tiles
TileRect_33_4641::
Data_033_4641:: ; address name
    dw $0000 ; entry 0
    db $14, $0D
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $D0, $D1, $D2, $D3, $D4, $C3, $D5, $D6, $D7, $D8, $D9, $C3, $DA, $DB, $DC, $DD, $DE, $C3, $B7
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA
    db $B6, $EB, $C3, $C3, $C3, $C3, $C3, $EB, $C3, $C3, $C3, $C3, $C3, $EB, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $EC, $C3, $C3, $C3, $C3, $C3, $EC, $C3, $C3, $C3, $C3, $C3, $EC, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $EA, $ED, $C3, $C3, $C3, $C3, $EA, $ED, $C3, $C3, $C3, $C3, $EA, $ED, $C3, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5
    db $C3, $14, $15, $16, $17, $18, $19, $38, $39, $3A, $3B, $3C, $3D, $5C, $5D, $5E, $5F, $60, $61, $C3
    db $C3, $1A, $1B, $1C, $1D, $1E, $1F, $3E, $3F, $40, $41, $42, $43, $62, $63, $64, $65, $66, $67, $C3
    db $C3, $20, $21, $22, $23, $24, $25, $44, $45, $46, $47, $48, $49, $68, $69, $6A, $6B, $6C, $6D, $C3
    db $C3, $26, $27, $28, $29, $2A, $2B, $4A, $4B, $4C, $4D, $4E, $4F, $6E, $6F, $70, $71, $72, $73, $C3
    db $C3, $2C, $2D, $2E, $2F, $30, $31, $50, $51, $52, $53, $54, $55, $74, $75, $76, $77, $78, $79, $C3
    db $C3, $32, $33, $34, $35, $36, $37, $56, $57, $58, $59, $5A, $5B, $7A, $7B, $7C, $7D, $7E, $7F, $C3

; E-0232 (C1: a record of ScreenBlockTable).
; record: offset $01A4 (row 13, column 4); 12 x 5 tiles
TileRect_33_4749::
Data_033_4749:: ; address name
    dw $01A4 ; entry 0
    db $0C, $05
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $80, $81, $82, $83, $84, $85, $86, $87, $88, $C3, $B7
    db $B6, $89, $8A, $8B, $8C, $8D, $8E, $8F, $90, $91, $C3, $B7
    db $B6, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; E-0232 (C1: a record of ScreenBlockTable).
; record: offset $0000 (row 0, column 0); 6 x 3 tiles
TileRect_33_4789::
Data_033_4789:: ; address name
    dw $0000 ; entry 0
    db $06, $03
    db $B0, $B1, $B1, $B1, $B1, $B2
    db $B6, $A4, $A8, $A9, $EC, $B7
    db $B3, $B4, $B4, $B4, $B4, $B5

; E-0232 (C1: a record of ScreenBlockTable).
; record: offset $0008 (row 0, column 8); 12 x 9 tiles
TileRect_33_479F::
Data_033_479F:: ; address name
    dw $0008 ; entry 0
    db $0C, $09
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $C3, $5C, $5D, $5E, $5F, $60, $61, $62, $63, $64, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $65, $66, $67, $68, $69, $6A, $6B, $6C, $6D, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $6E, $6F, $70, $71, $72, $73, $74, $75, $76, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $77, $78, $79, $7A, $7B, $7C, $7D, $7E, $7F, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; E-0232 (C1: a record of ScreenBlockTable).
; record: offset $0140 (row 10, column 0); 20 x 7 tiles
TileRect_33_480F::
Data_033_480F:: ; address name
    dw $0140 ; entry 0
    db $14, $07
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $23, $24, $25, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $2E, $2F, $30, $31, $32, $33, $34, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $35, $36, $37, $38, $39, $3A, $3B, $3C, $3D, $3E, $3F, $40, $41, $42, $43, $44, $45, $46, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $47, $48, $49, $4A, $4B, $4C, $4D, $4E, $4F, $50, $51, $52, $53, $54, $55, $56, $57, $58, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; E-0232 (C1: a record of ScreenBlockTable).
; record: offset $0040 (row 2, column 0); 7 x 7 tiles
TileRect_33_489F::
Data_033_489F:: ; address name
    dw $0040 ; entry 0
    db $07, $07
    db $B0, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $EE, $EF, $F0, $F1, $C3, $B7
    db $B8, $B9, $B9, $B9, $B9, $B9, $BA
    db $B6, $C3, $F2, $F3, $F5, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $F1, $F4, $F3, $F3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B5

; E-0232 (C1: a record of ScreenBlockTable).
; record: offset $0040 (row 2, column 0); 7 x 7 tiles
TileRect_33_48D4::
Data_033_48D4:: ; address name
    dw $0040 ; entry 0
    db $07, $07
    db $B0, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $EE, $EF, $F0, $F1, $C3, $B7
    db $B8, $B9, $B9, $B9, $B9, $B9, $BA
    db $B6, $C3, $F2, $F3, $F4, $F5, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $F6, $F7, $F8, $F9, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B5

; E-0232 (C1: a record of ScreenBlockTable).
; record: offset $0100 (row 8, column 0); 6 x 5 tiles
TileRect_33_4909::
Data_033_4909:: ; address name
    dw $0100 ; entry 0
    db $06, $05
    db $B0, $B1, $B1, $B1, $B1, $B2
    db $B6, $C3, $CE, $CF, $DF, $B7
    db $B6, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $A5, $F4, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B5

; E-0232 (C1: a record of ScreenBlockTable).
; record: offset $01A0 (row 13, column 0); 20 x 5 tiles
TileRect_33_492B::
Data_033_492B:: ; address name
    dw $01A0 ; entry 0
    db $14, $05
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8A, $8B, $8C, $8D, $8E, $8F, $90, $91, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F, $A0, $A1, $A2, $A3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; E-0232 (C1: a record of ScreenBlockTable).
; record: offset $0000 (row 0, column 0); 8 x 9 tiles
TileRect_33_4993::
Data_033_4993:: ; address name
    dw $0000 ; entry 0
    db $08, $09
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $C3, $EE, $EF, $A7, $C3, $C3, $B7
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $BA
    db $B6, $C3, $D0, $D1, $D2, $D3, $D4, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $D5, $D6, $D7, $D8, $D9, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $DA, $DB, $DC, $DD, $DE, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; E-0232 (C1: a record of ScreenBlockTable).
; record: offset $0120 (row 9, column 0); 14 x 5 tiles
TileRect_33_49DF::
Data_033_49DF:: ; address name
    dw $0120 ; entry 0
    db $0E, $05
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; E-0232 (C1: a record of ScreenBlockTable).
; record: offset $0000 (row 0, column 0); 8 x 9 tiles
TileRect_33_4A29::
Data_033_4A29:: ; address name
    dw $0000 ; entry 0
    db $08, $09
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $AA, $AB, $A4, $AC, $AC, $AA, $B7
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $BA
    db $B6, $C3, $D0, $D1, $D2, $D3, $D4, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $D5, $D6, $D7, $D8, $D9, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $DA, $DB, $DC, $DD, $DE, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; E-0232 (C1: a record of ScreenBlockTable).
; record: offset $0120 (row 9, column 0); 20 x 9 tiles
TileRect_33_4A75::
Data_033_4A75:: ; address name
    dw $0120 ; entry 0
    db $14, $09
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $23, $24, $25, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $2E, $2F, $30, $31, $32, $33, $34, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $35, $36, $37, $38, $39, $3A, $3B, $3C, $3D, $3E, $3F, $40, $41, $42, $43, $44, $45, $46, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $47, $48, $49, $4A, $4B, $4C, $4D, $4E, $4F, $50, $51, $52, $53, $54, $55, $56, $57, $58, $B7
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $BE, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; E-0232 (C1: a record of ScreenBlockTable).
; record: offset $0000 (row 0, column 0); 8 x 9 tiles
TileRect_33_4B2D::
Data_033_4B2D:: ; address name
    dw $0000 ; entry 0
    db $08, $09
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $C3, $F0, $F1, $F2, $C3, $C3, $B7
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $BA
    db $B6, $C3, $D0, $D1, $D2, $D3, $D4, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $D5, $D6, $D7, $D8, $D9, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $DA, $DB, $DC, $DD, $DE, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; E-0232 (C1: a record of ScreenBlockTable).
; record: offset $0000 (row 0, column 0); 13 x 15 tiles
TileRect_33_4B79::
Data_033_4B79:: ; address name
    dw $0000 ; entry 0
    db $0D, $0F
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $C3, $C3, $C3, $AD, $AC, $AE, $A5, $C3, $C3, $C3, $C3, $B7
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA
    db $B6, $C3, $AB, $CF, $FA, $DF, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $AD, $F2, $F0, $F3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $A8, $CF, $F9, $F7, $C3, $AA, $F5, $CF, $CF, $F1, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $EE, $CF, $FB, $A7, $F6, $F1, $CF, $F6, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $A4, $F3, $FC, $F4, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $EF, $F4, $F8, $F6, $F3, $F0, $F2, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; E-0232 (C1: a record of ScreenBlockTable).
; record: offset $0006 (row 0, column 6); 14 x 7 tiles
TileRect_33_4C40::
Data_033_4C40:: ; address name
    dw $0006 ; entry 0
    db $0E, $07
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $2A, $2B, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $2C, $2D, $2E, $2F, $30, $31, $32, $33, $34, $35, $36, $37, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $38, $39, $3A, $3B, $3C, $3D, $3E, $3F, $40, $41, $42, $43, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; E-0232 (C1: a record of ScreenBlockTable).
; record: offset $0125 (row 9, column 5); 15 x 9 tiles
TileRect_33_4CA6::
Data_033_4CA6:: ; address name
    dw $0125 ; entry 0
    db $0F, $09
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $C3, $C3, $44, $45, $46, $47, $48, $49, $4A, $4B, $4C, $4D, $4E, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $50, $51, $52, $53, $54, $55, $56, $57, $58, $59, $5A, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $5C, $5D, $5E, $5F, $60, $61, $62, $63, $64, $65, $66, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $68, $69, $6A, $6B, $6C, $6D, $6E, $6F, $70, $71, $72, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; E-0232 (C1: a record of ScreenBlockTable).
; record: offset $0000 (row 0, column 0); 7 x 7 tiles
TileRect_33_4D31::
Data_033_4D31:: ; address name
    dw $0000 ; entry 0
    db $07, $07
    db $B0, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $FD, $02, $FE, $FF, $C3, $B7
    db $B8, $B9, $B9, $B9, $B9, $B9, $BA
    db $B6, $C3, $00, $DF, $CF, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $FF, $F4, $DF, $DF, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B5

; E-0232 (C1: a record of ScreenBlockTable).
; record: offset $00E0 (row 7, column 0); 6 x 5 tiles
TileRect_33_4D66::
Data_033_4D66:: ; address name
    dw $00E0 ; entry 0
    db $06, $05
    db $B0, $B1, $B1, $B1, $B1, $B2
    db $B6, $C3, $CE, $CF, $DF, $B7
    db $B6, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $A5, $F4, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B5

; E-0232 (C1: a record of ScreenBlockTable).
; record: offset $00CD (row 6, column 13); 7 x 3 tiles
TileRect_33_4D88::
Data_033_4D88:: ; address name
    dw $00CD ; entry 0
    db $07, $03
    db $B0, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $D0, $D1, $D2, $D3, $D4, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B5

; E-0232 (C1: a record of ScreenBlockTable).
; record: offset $0129 (row 9, column 9); 11 x 9 tiles
TileRect_33_4DA1::
Data_033_4DA1:: ; address name
    dw $0129 ; entry 0
    db $0B, $09
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $C3, $01, $0A, $F0, $F6, $07, $CF, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $04, $08, $F9, $CF, $F1, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $05, $CF, $FC, $CF, $F3, $06, $CF, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $01, $F4, $09, $09, $F0, $F3, $F1, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; E-0232 (C1: a record of ScreenBlockTable).
; record: offset $0042 (row 2, column 2); 18 x 7 tiles
TileRect_33_4E08::
Data_033_4E08:: ; address name
    dw $0042 ; entry 0
    db $12, $07
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; E-0232 (C1: a record of ScreenBlockTable).
; record: offset $0128 (row 9, column 8); 12 x 9 tiles
TileRect_33_4E8A::
Data_033_4E8A:: ; address name
    dw $0128 ; entry 0
    db $0C, $09
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $D0, $D1, $D2, $D3, $D4, $CC, $EA, $ED, $C3, $C3, $B7
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA
    db $B6, $C7, $20, $21, $22, $23, $24, $25, $26, $27, $28, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $02, $03, $ED, $C3, $C3, $C3, $BE, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $04, $03, $ED, $C3, $C3, $C3, $BE, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; E-0232 (C1: a record of ScreenBlockTable).
; record: offset $0020 (row 1, column 0); 20 x 11 tiles
TileRect_33_4EFA::
Data_033_4EFA:: ; address name
    dw $0020 ; entry 0
    db $14, $0B
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $05, $06, $07, $08, $09, $0A, $ED, $20, $21, $22, $23, $24, $C3, $C3, $C3, $ED, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $25, $26, $27, $28, $29, $2A, $C3, $EA, $ED, $C3, $C3, $C3, $C3, $C3, $37, $38, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $39, $3A, $C3, $C3, $B7
    db $B6, $2B, $2C, $2D, $2E, $2F, $30, $C3, $EA, $ED, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $31, $32, $33, $34, $35, $36, $C3, $EA, $ED, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $3B, $3C, $3D, $3E, $3F, $40, $41, $42, $43, $44, $45, $46, $47, $C3, $C3, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; E-0232 (C1: a record of ScreenBlockTable).
; record: offset $010E (row 8, column 14); 6 x 5 tiles
TileRect_33_4FDA::
Data_033_4FDA:: ; address name
    dw $010E ; entry 0
    db $06, $05
    db $B0, $B1, $B1, $B1, $B1, $B2
    db $B6, $C3, $CE, $CF, $DF, $B7
    db $B6, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $A5, $F4, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B5

; E-0232 (C1: a record of ScreenBlockTable).
; record: offset $0121 (row 9, column 1); 18 x 5 tiles
TileRect_33_4FFC::
Data_033_4FFC:: ; address name
    dw $0121 ; entry 0
    db $12, $05
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $A6, $F0, $DF, $F7, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $AA, $F2, $F4, $0B, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $E1, $C3, $E2, $C3, $E3, $C3, $E4, $C3, $E5, $C3, $E6, $C3, $E7, $C3, $E8, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; E-0232 (C1: a record of ScreenBlockTable).
; record: offset $0000 (row 0, column 0); 20 x 18 tiles
TileRect_33_505A::
Data_033_505A:: ; address name
    dw $0000 ; entry 0
    db $14, $12
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $04, $F0, $DF, $F7, $CF, $F6, $ED, $30, $31, $32, $33, $34, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $A8, $13, $14, $CF, $ED, $C3, $C3, $C3, $ED, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $A6, $F0, $F6, $14, $ED, $04, $A7, $A5, $C3, $C3, $C3, $A9, $BF, $BF, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $AA, $F2, $CF, $CF, $F5, $ED, $04, $A7, $A5, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2
    db $B6, $C3, $C3, $01, $F0, $F7, $CF, $12, $F4, $F6, $13, $CF, $DF, $ED, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $20, $C3, $C3, $C3, $21, $C3, $C3, $C3, $22, $C3, $C3, $C3, $23, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $24, $C3, $C3, $C3, $25, $C3, $C3, $C3, $26, $C3, $C3, $C3, $27, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $28, $C3, $C3, $C3, $29, $C3, $C3, $C3, $2A, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; only called from GameMode5_Update_Case05 (E-0047)
; 1 call site from 1 routine (e.g. GameMode5_Update_Case05)
; reads: wLinkScreenState, wScreenState, wScreenStep, wScreenSubStep
GameMode5_Update_Case05_Sub01::
Func_033_51C6:: ; address name
    call LinkExchangeJoypadPerFrame
    ld a, [wLinkScreenState]
    or a, a
    jr nz, Jump_033_51D0
    ret

Jump_033_51D0::
    ld a, [wScreenState]
    cp a, $0C
    jr z, Jump_033_51DC
    cp a, $0D
    jr z, Jump_033_51FB
    ret

Jump_033_51DC::
    ld a, [wScreenSubStep]
    and a, a
    ret nz
    ld a, [wScreenStep]
    cp a, $20
    jr z, Jump_033_51F4
    cp a, $15
    jr z, Jump_033_51ED
    ret

Jump_033_51ED::
    farcall DrawListEntriesCell5SpeciesSprite
    ret

Jump_033_51F4::
    farcall CallFunc6899PreservingArg1AndTemp0
    ret

Jump_033_51FB::
    ld a, [wScreenStep]
    cp a, $15
    jr z, Jump_033_5207
    cp a, $20
    jr z, Jump_033_520E
    ret

Jump_033_5207::
    farcall DrawWCA36SpritePart_BankF1
    ret

Jump_033_520E::
    farcall DrawRecordBufBSpeciesSprites
    ret

; only called from RunLinkExchangeState_450D_Case01 (E-0047)
; 1 call site from 1 routine (e.g. RunLinkExchangeState_450D_Case01)
; reads: wLinkScreenState, wLinkScreenSubState, wFadeState, wScreenState
RunLinkExchangeState_450D_Case01_Sub01::
Func_033_5215:: ; address name
    ld a, [wLinkScreenState]
    or a, a
    jr nz, Jump_033_523B
    ld a, [wLinkScreenSubState]
    rst $00
    dw RunLinkExchangeState_450D_Case01_Sub01_Case00
    dw RunLinkExchangeState_450D_Case01_Sub01_Case01
    dw RunLinkExchangeState_450D_Case01_Sub01_Case02
    dw RunLinkExchangeState_450D_Case01_Sub01_Case03
    dw RunLinkExchangeState_450D_Case01_Sub01_Case04
    dw RunLinkExchangeState_450D_Case01_Sub01_Case05
    dw RunLinkExchangeState_450D_Case01_Sub01_Case06
    dw RunLinkExchangeState_450D_Case01_Sub01_Case07
    dw RunLinkExchangeState_450D_Case01_Sub01_Case08
    dw RunLinkExchangeState_450D_Case01_Sub01_Case09
    dw RunLinkExchangeState_450D_Case01_Sub01_Case0A
    dw RunLinkExchangeState_450D_Case01_Sub01_Case0B
    dw RunLinkExchangeState_450D_Case01_Sub01_Case0C
    dw RunLinkExchangeState_450D_Case01_Sub01_Case0D

Jump_033_523B::
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, [wScreenState]
    rst $00
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case00
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case01
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case02
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case03
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case06
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case06
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case06
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case06
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case06
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case06
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case06
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0D
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0E
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0F

; entry 0 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; points at: wScreenTileBuffer, wLinkScreenSubState
RunLinkExchangeState_450D_Case01_Sub01_Case00::
Jump_033_5264:: ; address name
    ld de, TileRect_33_62AB
    ld hl, wScreenTileBuffer + $C
    ld bc, $0803
    call CopyRectTo20ByteRowsJp_Bank33
    ld de, TileRect_33_62C3
    ld hl, wScreenTileBuffer
    ld bc, $0A0B
    call CopyRectTo20ByteRowsJp_Bank33
    call DrawPlayerNameAndString0Category1
    call SetDefaultStringWindow_Bank33
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; writes: wLinkSendByte
; points at: wKeyNameBuf, wLinkScreenSubState
RunLinkExchangeState_450D_Case01_Sub01_Case01::
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
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState
; writes: wLinkSendByte
; points at: wLinkScreenSubState
RunLinkExchangeState_450D_Case01_Sub01_Case02::
Jump_033_52A8:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, $19
    call BeginString_Bank07_Cat5
    ld hl, wLinkScreenSubState
    inc [hl]
    xor a, a
    ld [wLinkSendByte], a
    ret

; entry 3 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wTextFlags, wTextYesNoResult, wGoldLo, wGoldMid, wGoldHi, wLinkScreenSubState
; writes: wLinkSendByte, wLinkScreenState, wScreenState, wLinkScreenSubState, wGoldHi, wGoldMid, wGoldLo
; points at: wLinkScreenSubState
RunLinkExchangeState_450D_Case01_Sub01_Case03::
Jump_033_52BB:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr nz, Jump_033_52D7
    ld a, $FE
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkScreenState], a
    ld a, $02
    ld [wScreenState], a
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
    ld [wLinkScreenState], a
    ld a, $02
    ld [wScreenState], a
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
    ld a, [wLinkScreenSubState]
    add a, $08
    ld [wLinkScreenSubState], a
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
    ld hl, wLinkScreenSubState
    inc [hl]
    ld a, $01
    ld [wLinkSendByte], a
    ret

; entry 4 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkSendByte, wLinkScreenState, wScreenState
; points at: wLinkScreenSubState
RunLinkExchangeState_450D_Case01_Sub01_Case04::
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
    ld [wLinkScreenState], a
    ld a, $02
    ld [wScreenState], a
    ld a, $0A
    call BeginString_Bank07_Cat5
    ret

Jump_033_535D::
    ld a, $07
    call BeginString_Bank07_Cat5
    ld hl, wLinkScreenSubState
    inc [hl]
    xor a, a
    ld [wLinkSendByte], a
    ret

Jump_033_536B::
    ld a, $01
    call BeginString_Bank07_Cat5
    ld hl, wLinkScreenSubState
    inc [hl]
    ld hl, wLinkScreenSubState
    inc [hl]
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 5 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; writes: wLinkSendByte, wLinkScreenFlag
; points at: wLinkScreenSubState
RunLinkExchangeState_450D_Case01_Sub01_Case05::
Jump_033_537D:: ; address name
    xor a, a
    ld [wLinkSendByte], a
    ld hl, wLinkScreenSubState
    inc [hl]
    xor a, a
    ld [wLinkScreenFlag], a
    ret

; entry 6 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkScreenFlag
RunLinkExchangeState_450D_Case01_Sub01_Case06::
Jump_033_538A:: ; address name
    ld a, [wLinkScreenFlag]
    rst $00
    dw RunLinkExchangeState_450D_Case01_Sub01_Case06_Case00
    dw RunLinkExchangeState_450D_Case01_Sub01_Case06_Case01
    dw RunLinkExchangeState_450D_Case01_Sub01_Case06_Case02

; entry 0 of the `rst $00` table in Func_033_5215_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; points at: wScreenTileBuffer, wLinkScreenFlag
RunLinkExchangeState_450D_Case01_Sub01_Case06_Case00::
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
    ld hl, wLinkScreenFlag
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_033_5215_Case06
; no direct call (reached through a table, a jump or a vector)
; points at: wLinkScreenFlag
RunLinkExchangeState_450D_Case01_Sub01_Case06_Case01::
Jump_033_53AC:: ; address name
    call BGMapAddressAtScroll_Bank33
    ld bc, $140D
    ld de, $0000
    call DrawScreenBufferRectToBGMap_33
    ld a, $08
    call BeginString_Bank07_Cat5
    ld hl, wLinkScreenFlag
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_033_5215_Case06
; no direct call (reached through a table, a jump or a vector)
; writes: wLinkScreenSubState, wLinkScreenFlag, wLinkScreenState, wScreenState
RunLinkExchangeState_450D_Case01_Sub01_Case06_Case02::
Jump_033_53C2:: ; address name
    xor a, a
    ld [wLinkScreenSubState], a
    xor a, a
    ld [wLinkScreenFlag], a
    ld a, $01
    ld [wLinkScreenState], a
    xor a, a
    ld [wScreenState], a
    ret

; entry 7 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wTextYesNoResult, wGoldLo, wGoldMid, wGoldHi
; writes: wLinkSendByte, wGoldHi, wGoldMid, wGoldLo
; points at: wLinkScreenSubState
RunLinkExchangeState_450D_Case01_Sub01_Case07::
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
    ld hl, wLinkScreenSubState
    inc [hl]
    ld hl, wLinkScreenSubState
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
    ld hl, wLinkScreenSubState
    inc [hl]
    ld hl, wLinkScreenSubState
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
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

; entry 8 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkSendByte, wLinkScreenState, wScreenState
; points at: wLinkScreenSubState
RunLinkExchangeState_450D_Case01_Sub01_Case08::
Jump_033_5433:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr z, Jump_033_5446
    cp a, $20
    ret nz
    ld hl, wLinkScreenSubState
    dec [hl]
    ld hl, wLinkScreenSubState
    dec [hl]
    ret

Jump_033_5446::
    ld a, $FE
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkScreenState], a
    ld a, $02
    ld [wScreenState], a
    ld a, $0A
    call BeginString_Bank07_Cat5
    ret

; entry 9 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkSendByte, wLinkScreenState, wScreenState
; points at: wLinkScreenSubState
RunLinkExchangeState_450D_Case01_Sub01_Case09::
Jump_033_545B:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr z, Jump_033_546E
    cp a, $30
    jr z, Jump_033_5469
    cp a, $40
    ret nz

Jump_033_5469::
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

Jump_033_546E::
    ld a, $FE
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkScreenState], a
    ld a, $02
    ld [wScreenState], a
    ld a, $0A
    call BeginString_Bank07_Cat5
    ret

; entry 10 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; writes: wLinkSendByte, wLinkScreenState, wLinkScreenSubState, wScreenState
RunLinkExchangeState_450D_Case01_Sub01_Case0A::
Jump_033_5483:: ; address name
    ld a, $FE
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkScreenState], a
    xor a, a
    ld [wLinkScreenSubState], a
    ld a, $02
    ld [wScreenState], a
    ret

; entry 11 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkSendByte, wLinkScreenState, wScreenState
; points at: wLinkScreenSubState
RunLinkExchangeState_450D_Case01_Sub01_Case0B::
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
    ld hl, wLinkScreenSubState
    inc [hl]
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

Jump_033_54BE::
    ld [wLinkSendByte], a
    ld a, $04
    call BeginString_Bank07_Cat5
    ld hl, wLinkScreenSubState
    inc [hl]
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

Jump_033_54CF::
    ld [wLinkSendByte], a
    ld a, $03
    call BeginString_Bank07_Cat5
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

Jump_033_54DC::
    ld [wLinkSendByte], a
    ld a, $04
    call BeginString_Bank07_Cat5
    ld hl, wLinkScreenSubState
    inc [hl]
    ld hl, wLinkScreenSubState
    inc [hl]
    ret

Jump_033_54ED::
    ld a, $FE
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkScreenState], a
    ld a, $02
    ld [wScreenState], a
    ld a, $0A
    call BeginString_Bank07_Cat5
    ret

; entry 12 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkScreenSubState, wLinkSendByte, wLinkScreenState, wScreenState
RunLinkExchangeState_450D_Case01_Sub01_Case0C::
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
    ld [wLinkScreenSubState], a
    ret

Jump_033_5515::
    ld a, $FE
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkScreenState], a
    ld a, $02
    ld [wScreenState], a
    ld a, $0A
    call BeginString_Bank07_Cat5
    ret

; entry 13 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkSendByte, wLinkScreenState, wLinkScreenSubState, wScreenState
RunLinkExchangeState_450D_Case01_Sub01_Case0D::
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
    ld [wLinkScreenState], a
    xor a, a
    ld [wLinkScreenSubState], a
    ld a, $02
    ld [wScreenState], a
    ret

; A = string index: wStringIndex = A, wStringCategory = 5, then BeginStringDisplay_Bank07
; 34 call sites from 19 routines (e.g. RunLinkExchangeState_450D_Case01_Sub01_Case0C, RunLinkExchangeState_450D_Case01_Sub01_Case0B, RunLinkExchangeState_450D_Case01_Sub01_Case09, RunLinkExchangeState_450D_Case01_Sub01_Case08, ...)
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
; points at: wScreenState
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case00::
Jump_033_555F:: ; address name
    ld hl, wScreenState
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; points at: wScreenState
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case01::
Jump_033_5564:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld hl, wScreenState
    inc [hl]
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case02::
Jump_033_556F:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case02_Case00
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case02_Case01
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case02_Case02
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case02_Case03
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case02_Case04

; entry 0 of the `rst $00` table in Func_033_5215_Table2_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenStep
; writes: wLinkSendByte, wScreenStep
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case02_Case00::
Jump_033_557D:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 1 of the `rst $00` table in Func_033_5215_Table2_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; points at: wScreenStep
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case02_Case01::
Jump_033_558F:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, $0C
    call ShowStringA10_Bank33
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_033_5215_Table2_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wLinkSendByte
; points at: wScreenStep
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case02_Case02::
Jump_033_559E:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in Func_033_5215_Table2_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkSendByte
; points at: wScreenStep
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case02_Case03::
Jump_033_55AD:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in Func_033_5215_Table2_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; points at: wScreenState, wGameMode, wModeChangeRequest
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case02_Case04::
Jump_033_55BC:: ; address name
    ld a, [wTextFlags]
    bit 0, a
    ret nz
    ld hl, wScreenState
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
; points at: wScreenState
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case03::
Jump_033_55E0:: ; address name
    ld hl, wScreenState
    inc [hl]
    ret

; entry 4 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04::
Jump_033_55E5:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case00
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case00
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case02
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case00
    dw CallDrawListEntriesCell5RecordPanel
    dw CallClearAndDrawListEntriesCell5Name
    dw CopyRect62C3ToWC36EAndIncScreenStep
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case07
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case08
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case09
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case0A
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case0B
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case0C
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case0D
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case0E
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case0F

; entry 0 of the `rst $00` table in Func_033_5215_Table2_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case00::
Jump_033_5609:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    farcall BreedMenu
    ret

; entry 2 of the `rst $00` table in Func_033_5215_Table2_Case04
; no direct call (reached through a table, a jump or a vector)
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case02::
Jump_033_5615:: ; address name
    farcall DrawRecordListPageIndicators_1B
    ret

; far-calls DrawListEntriesCell5RecordPanel (E-0122)
; 1 call site from 1 routine (e.g. RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0F_Case03)
CallDrawListEntriesCell5RecordPanel::
Func_033_561C:: ; address name
    farcall DrawListEntriesCell5RecordPanel
    ret

; far-calls ClearAndDrawListEntriesCell5NameAtTiles1780 (E-0122)
; 1 call site from 1 routine (e.g. RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0F_Case04)
CallClearAndDrawListEntriesCell5Name::
Func_033_5623:: ; address name
    farcall ClearAndDrawListEntriesCell5NameAtTiles1780
    ret

; copies the 10 x 11 rectangle Data_033_62C3 into wC36E (CopyRectTo20ByteRowsJp_Bank33), then wD781 += 1 (E-0119)
; 1 call site from 1 routine (e.g. RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0F_Case05)
; points at: wScreenStep
CopyRect62C3ToWC36EAndIncScreenStep::
Func_033_562A:: ; address name
    ld de, TileRect_33_62C3
    ld hl, wWindowTileBuffer + $6E
    ld bc, $0A0B
    call CopyRectTo20ByteRowsJp_Bank33
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in Func_033_5215_Table2_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wListCursor, wScreenStep
; writes: wScreenStep
; points at: wKeyNameBuf
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case07::
Jump_033_563B:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, [wListCursor]
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
    ld a, [wListCursor]
    ld b, $C3
    ld hl, Data_033_63EF
    call StoreBAtWordTableEntry_Bank33
    call SetDefaultStringWindow_Bank33
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 8 of the `rst $00` table in Func_033_5215_Table2_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wMenuInputResult, wListCursor, wScreenStep
; writes: wScreenState, wScreenStep, wScreenSubStep, wLinkSendByte, wMenuInputResult
; points at: wScreenStep
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case08::
Jump_033_5676:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr nz, Jump_033_5694
    ld a, $02
    ld [wScreenState], a
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
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
    ld a, [wScreenStep]
    sub a, $07
    ld [wScreenStep], a
    ret

Jump_033_56C1::
    ld a, [wScreenStep]
    sub a, $04
    ld [wScreenStep], a
    ret

Jump_033_56CA::
    ld a, $02
    ld [wScreenState], a
    ld a, $09
    call BeginString_Bank07_Cat5
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $FE
    ld [wLinkSendByte], a
    ret

Jump_033_56E1::
    call StoreListEntriesCell5RecordInPickedRecords
    ld a, [wListCursor]
    ld b, $BC
    ld hl, Data_033_63EF
    call StoreBAtWordTableEntry_Bank33
    call CopyListEntriesCell5NameToTextBuf0_Bank33
    ld hl, wScreenStep
    inc [hl]
    ld a, $02
    call ShowStringA10_Bank33
    ret

; entry 9 of the `rst $00` table in Func_033_5215_Table2_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex, wChoiceCursor
; points at: wScreenStep
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case09::
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
    ld de, TileRect_33_63C7
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRowsJp_Bank33
    call BGMapAddressAtScroll_Bank33
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_33
    call SetDefaultStringWindow_Bank33
    xor a, a
    ld [wChoiceCursor], a
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 10 of the `rst $00` table in Func_033_5215_Table2_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wArg5, wChoiceCursor, wScreenState, wScreenStep
; writes: wScreenState, wScreenStep, wScreenSubStep, wLinkSendByte, wArg5, wScreenByteB2, wScreenByteB3
; points at: wScreenStep
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case0A::
Jump_033_574F:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr nz, Jump_033_576D
    ld a, $02
    ld [wScreenState], a
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $0A
    call BeginString_Bank07_Cat5
    ld a, $FE
    ld [wLinkSendByte], a
    ret

Jump_033_576D::
    xor a, a
    ld [wArg5], a
    farcall HandleTwoChoiceCursorInput_0D
    ld a, [wArg5]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_033_5785
    cp a, $FF
    jr z, Jump_033_578A
    ret

Jump_033_5785::
    ld hl, wScreenStep
    inc [hl]
    ret

Jump_033_578A::
    ld a, [wChoiceCursor]
    and a, a
    jr nz, Jump_033_57A9
    ld a, [wScreenState]
    ld [wScreenByteB2], a
    ld a, [wScreenStep]
    ld [wScreenByteB3], a
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $0C
    ld [wScreenState], a
    ret

Jump_033_57A9::
    call StoreListEntriesCell5RecordInPickedRecords
    ld hl, wScreenStep
    inc [hl]
    inc [hl]
    ret

; entry 11 of the `rst $00` table in Func_033_5215_Table2_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenStep
; writes: wScreenStep
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case0B::
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
    ld a, [wScreenStep]
    sub a, $03
    ld [wScreenStep], a
    ret

; entry 12 of the `rst $00` table in Func_033_5215_Table2_Case04
; no direct call (reached through a table, a jump or a vector)
; points at: wPickCount
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case0C::
Jump_033_57DC:: ; address name
    call DrawBox639FAndKeyRows
    call BGMapAddressAtScroll_Bank33
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_33
    ld hl, wPickCount
    inc [hl]
    ld a, $0C
    call ShowStringA10_Bank33
    call FinishPickedRecordsEntryAndStep_33
    ret

; entry 13 of the `rst $00` table in Func_033_5215_Table2_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wPickedRecords
; writes: rRAMG, rRAMB, wLinkTimeoutLo, wLinkTimeoutHi, wLinkBufferPtrLo, wLinkBufferPtrHi, wLinkSceneByte4B, wLinkSendByte
; points at: wRecordBufA, wRecordBufB, wScreenStep
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case0D::
Jump_033_57F8:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wPickedRecords]
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
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 14 of the `rst $00` table in Func_033_5215_Table2_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wScreenState, wScreenStep, wScreenSubStep, wLinkSendByte, wLinkBufferCountLo, wLinkBufferCountHi, wLinkReady
; points at: wScreenStep
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case0E::
Jump_033_5839:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    jr z, Jump_033_585A
    cp a, $FE
    ret nz
    ld a, $02
    ld [wScreenState], a
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
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
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 15 of the `rst $00` table in Func_033_5215_Table2_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wScreenStep
; points at: wScreenState
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case0F::
Jump_033_5874:: ; address name
    ld a, [wLinkMessage]
    cp a, $F0
    ret nz
    ld hl, wScreenState
    inc [hl]
    xor a, a
    ld [wScreenStep], a
    ret

; entry 5 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05::
Jump_033_5883:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05_Case00
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05_Case01
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05_Case02
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05_Case03
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05_Case04
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05_Case05
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05_Case06
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05_Case07
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05_Case08
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05_Case09
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05_Case0A
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05_Case0B
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05_Case0C
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05_Case0D
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05_Case0E
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05_Case0F
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05_Case10
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05_Case11

; entry 0 of the `rst $00` table in Func_033_5215_Table2_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wLinkSendByte
; points at: wScreenStep, wKeyNameBuf, wLinkRecvBuffer, wPlayerName
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05_Case00::
Jump_033_58AB:: ; address name
    ld hl, wScreenStep
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
; 1 call site from 1 routine (e.g. RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05_Case00)
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
; points at: wScreenStep
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05_Case01::
Jump_033_58CD:: ; address name
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_033_5215_Table2_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkTimeoutLo, wLinkTimeoutHi, wLinkBufferPtrLo, wLinkBufferPtrHi, wLinkBufferCountLo, wLinkSendByte
; points at: wLinkRecvBuffer, wLinkPartnerName, wScreenStep
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05_Case02::
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
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in Func_033_5215_Table2_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkSendByte
; points at: wScreenStep
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05_Case03::
Jump_033_5902:: ; address name
    ld a, [wLinkMessage]
    cp a, $F0
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in Func_033_5215_Table2_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkTradeByte
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wNameGlyphBuf, wBattleByte63, wStringCategory, wStringIndex
; points at: wNameGlyphBuf, wRandomSeed2Hi, wLinkPartnerName, wScreenStep
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05_Case04::
Jump_033_5911:: ; address name
    ld de, TileRect_33_6331
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
    ld de, TileRect_33_63F9
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
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in Func_033_5215_Table2_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wTwoChoiceCursor
; points at: wScreenStep
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05_Case05::
Jump_033_59B9:: ; address name
    call BGMapAddressAtScroll_Bank33
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_33
    ld a, $0D
    call BeginString_Bank07_Cat5
    xor a, a
    ld [wTwoChoiceCursor], a
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in Func_033_5215_Table2_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wMenuInputResult, wTwoChoiceCursor, wScreenState, wScreenStep, wListCursor, wListPageIndex
; writes: wScreenState, wScreenStep, wScreenSubStep, wLinkSendByte, wScreenByteB2, wScreenByteB3, wItemGridX, wItemGridY, ...
; points at: wScreenStep
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05_Case06::
Jump_033_59D3:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr nz, Jump_033_59F1
    ld a, $02
    ld [wScreenState], a
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
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
    ld [wScreenState], a
    ld a, $09
    call BeginString_Bank07_Cat5
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
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
    ld hl, wScreenStep
    inc [hl]
    ret

Jump_033_5A2D::
    ld a, [wScreenState]
    ld [wScreenByteB2], a
    ld a, [wScreenStep]
    ld [wScreenByteB3], a
    ld a, $0D
    ld [wScreenState], a
    ld a, [wListCursor]
    ld [wItemGridX], a
    ld a, [wListPageIndex]
    ld [wItemGridY], a
    xor a, a
    ld [wListCursor], a
    ld [wListPageIndex], a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ret

; entry 7 of the `rst $00` table in Func_033_5215_Table2_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wLinkSendByte
; points at: wScreenTileBuffer, wScreenStep
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05_Case07::
Jump_033_5A58:: ; address name
    ld de, wScreenTileBuffer
    ld hl, wWindowTileBuffer + $64
    ld bc, $0104
    call CopyBytes
    ld a, $0E
    call BeginString_Bank07_Cat5
    xor a, a
    ld [wLinkSendByte], a
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 8 of the `rst $00` table in Func_033_5215_Table2_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wTextFlags, wTextYesNoResult
; writes: wScreenState, wScreenStep, wScreenSubStep, wLinkSendByte
; points at: wScreenStep
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05_Case08::
Jump_033_5A72:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr nz, Jump_033_5A90
    ld a, $02
    ld [wScreenState], a
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
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
    ld hl, wScreenStep
    dec [hl]
    ld hl, wScreenStep
    dec [hl]
    ret

Jump_033_5AAA::
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in Func_033_5215_Table2_Case05
; no direct call (reached through a table, a jump or a vector)
; points at: wScreenStep
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05_Case09::
Jump_033_5AAF:: ; address name
    ld hl, wScreenStep
    inc [hl]
    ld a, $0C
    call BeginString_Bank07_Cat5
    ret

; entry 10 of the `rst $00` table in Func_033_5215_Table2_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wLinkSendByte
; points at: wScreenStep
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05_Case0A::
Jump_033_5AB9:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld hl, wScreenStep
    inc [hl]
    ld a, $01
    ld [wLinkSendByte], a
    ret

; entry 11 of the `rst $00` table in Func_033_5215_Table2_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkSendByte, wScreenState, wScreenStep, wScreenSubStep
; points at: wScreenStep
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05_Case0B::
Jump_033_5AC8:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr z, Jump_033_5AD4
    cp a, $01
    jr z, Jump_033_5AEB
    ret

Jump_033_5AD4::
    ld a, $02
    ld [wScreenState], a
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $0A
    call BeginString_Bank07_Cat5
    ld a, $FE
    ld [wLinkSendByte], a
    ret

Jump_033_5AEB::
    xor a, a
    ld [wLinkSendByte], a
    ld hl, wScreenStep
    inc [hl]
    ld a, $1A
    call BeginString_Bank07_Cat5
    ret

; entry 12 of the `rst $00` table in Func_033_5215_Table2_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wGoldLo, wGoldMid, wGoldHi, wWorkBuf
; writes: wWorkBuf, wGoldLo, wGoldMid, wGoldHi, wLinkSendByte
; points at: wScreenStep
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05_Case0C::
Jump_033_5AF9:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld hl, wScreenStep
    inc [hl]
    ld a, [wGoldLo]
    ld [wWorkBuf], a
    ld a, [wGoldMid]
    ld [wWorkBuf + $1], a
    ld a, [wGoldHi]
    ld [wWorkBuf + $2], a
    farcall VerifySaveChecksum
    ld a, [wWorkBuf]
    ld [wGoldLo], a
    ld a, [wWorkBuf + $1]
    ld [wGoldMid], a
    ld a, [wWorkBuf + $2]
    ld [wGoldHi], a
    farcall SaveGameToSRAMWithChecksum
    ld a, $05
    ld [wLinkSendByte], a
    ret

; entry 13 of the `rst $00` table in Func_033_5215_Table2_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wArg5, wArg6, wScreenStep
; writes: wLinkSendByte, wLinkReceivedByte, wScreenStep
; points at: wRandomSeed2Hi, wLinkSeedCopy
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05_Case0D::
Jump_033_5B38:: ; address name
    ld a, [wLinkMessage]
    cp a, $05
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld hl, wRandomSeed2Hi
    ld de, wLinkSeedCopy
    ld bc, $000B
    call CopyBytes
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld [wLinkReceivedByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 14 of the `rst $00` table in Func_033_5215_Table2_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep, wRandomLo, wRandomHi
; writes: wScreenStep, wBattleSetupFlagsLo, wBattleSetupFlagsHi, wLinkTimeoutLo, wLinkTimeoutHi, wLinkBufferPtrLo, wLinkBufferPtrHi, wLinkBufferCountLo, ...
; points at: wBattleSetupFlagsLo, wRandomSeed2Lo
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05_Case0E::
Jump_033_5B68:: ; address name
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
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
; reads: wLinkMessage, wLinkRole, wRandomLo, wRandomHi, wScreenStep, wRandomSeed2Lo, wRandomSeed2Hi
; writes: wLinkSendByte, wLinkReady, wRandomSeed2Lo, wRandomSeed2Hi, wScreenStep, wRandomLo, wRandomHi
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05_Case0F::
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
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 16 of the `rst $00` table in Func_033_5215_Table2_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep, wLinkSendByte
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05_Case10::
Jump_033_5BDC:: ; address name
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $D2
    ld [wLinkSendByte], a
    ret

; entry 17 of the `rst $00` table in Func_033_5215_Table2_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkSendByte, wGameMode, wModeState, wGameMode2State, wGameMode2Arg, wModeChangeRequest, wLinkSession, wLinkExchangeState, ...
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05_Case11::
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
; reads: wScreenStep, wScreenState
; writes: wScreenStep, wScreenSubStep, wScreenState
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case06::
Jump_033_5C1A:: ; address name
    farcall SwapMonstersMenu
    ld a, [wScreenStep]
    cp a, $0A
    ret nz
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, [wScreenState]
    add a, $03
    ld [wScreenState], a
    ret

; entry 13 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState, wItemGridX, wItemGridY
; writes: wListCursor, wListPageIndex
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0D::
Jump_033_5C36:: ; address name
    farcall RunScreenStateWhenNotFading_F1
    ld a, [wScreenState]
    cp a, $0E
    ret nz
    ld a, [wItemGridX]
    ld [wListCursor], a
    ld a, [wItemGridY]
    ld [wListPageIndex], a
    ret

; entry 14 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0E::
Jump_033_5C4F:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0E_Case00
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0E_Case01
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0E_Case01
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0E_Case03
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0E_Case04
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0E_Case05
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0E_Case06
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0E_Case07

; entry 0 of the `rst $00` table in Func_033_5215_Table2_Case0E
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex, wScreenStep
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0E_Case00::
Jump_033_5C63:: ; address name
    farcall ClearRecordPanelTiles
    ld de, TileRect_33_6331
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
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 1 of the `rst $00` table in Func_033_5215_Table2_Case0E
; no direct call (reached through a table, a jump or a vector)
; points at: wScreenStep
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0E_Case01::
Jump_033_5CA7:: ; address name
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in Func_033_5215_Table2_Case0E
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, hTemp0, wArg1, wArg2, wArg3, wDigits, wScreenStep
; writes: wArg1, rRAMG2, rRAMB, wWorkBuf, wArg2, wArg3, wScreenStep
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0E_Case03::
Jump_033_5CAC:: ; address name
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld b, a
    push af
    ld a, $C7
    ld [wArg1], a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, b
    ld c, $0D
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a, $0F
    ld [wWorkBuf], a
    ld a, [wArg1]
    ld [wWorkBuf + $1], a
    farcall LoadFamilyIconTileForWorkBuf
    xor a, a
    ld [rRAMG2], a
    ld de, TileRect_33_5D5F
    ld hl, wWindowTileBuffer + $140
    ld bc, $0D02
    call CopyRectTo20ByteRowsJp_Bank33
    pop af
    ld [wArg1], a
    ld hl, wWindowTileBuffer + $143
    ld a, l
    ld [wArg2], a
    ld a, h
    ld [wArg3], a
    ld a, [wArg1]
    ld b, a
    ld a, [wArg2]
    ld l, a
    ld a, [wArg3]
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
    farcall BlankLeadingZeroDigits_F
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
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 13 x 2 tiles, one row per line
TileRect_33_5D5F::
Data_033_5D5F:: ; address name
    db $B6, $EA, $ED, $C3, $C3, $F8, $F9, $FA, $FB, $FC, $C3, $C7, $B7 ; id 0
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 1

; entry 4 of the `rst $00` table in Func_033_5215_Table2_Case0E
; no direct call (reached through a table, a jump or a vector)
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0E_Case04::
Jump_033_5D79:: ; address name
    farcall ClearAndDrawListEntriesCell5NameAtTiles1780
    ret

; entry 5 of the `rst $00` table in Func_033_5215_Table2_Case0E
; no direct call (reached through a table, a jump or a vector)
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wNameGlyphBuf
; points at: wKeyNameBuf, wLinkPartnerName, wNameGlyphBuf, wRandomSeed2Hi, wScreenStep
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0E_Case05::
Jump_033_5D80:: ; address name
    ld de, TileRect_33_62C3
    ld hl, wWindowTileBuffer + $6E
    ld bc, $0A0B
    call CopyRectTo20ByteRowsJp_Bank33
    ld de, wKeyNameBuf
    ld hl, wWindowTileBuffer + $B1
    call RunFunc6204FourTimes
    ld de, TileRect_33_6331
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
    ld hl, wScreenStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in Func_033_5215_Table2_Case0E
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex, wTwoChoiceCursor, wScreenStep
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0E_Case06::
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
    ld de, TileRect_33_63F9
    ld hl, wWindowTileBuffer + $E7
    ld bc, $0907
    call CopyRectTo20ByteRowsJp_Bank33
    call CopyListEntriesCell5NameToTextBuf0_Bank33
    call SetDefaultStringWindow_Bank33
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 7 of the `rst $00` table in Func_033_5215_Table2_Case0E
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenByteB2, wScreenByteB3
; writes: hSpriteHideTile, wScreenSubStep, wScreenState, wScreenStep
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0E_Case07::
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
    ld [wScreenSubStep], a
    ld a, [wScreenByteB2]
    ld [wScreenState], a
    ld a, [wScreenByteB3]
    ld [wScreenStep], a
    call SetDefaultStringWindow_Bank33
    ret

; entry 15 of the `rst $00` table in Func_033_5215
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0F::
Jump_033_5E57:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0F_Case00
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0F_Case01
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0F_Case02
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0F_Case03
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0F_Case04
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0F_Case05
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0F_Case06
    dw RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0F_Case07

; entry 0 of the `rst $00` table in Func_033_5215_Table2_Case0F
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor, wScreenStep
; writes: wScreenStep
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0F_Case00::
Jump_033_5E6B:: ; address name
    farcall ClearRecordPanelTiles
    ld de, TileRect_33_6438
    ld hl, wWindowTileBuffer + $64
    ld bc, $080B
    call CopyRectTo20ByteRowsJp_Bank33
    ld a, [wListCursor]
    ld b, $BC
    ld hl, Data_033_63EF
    call StoreBAtWordTableEntry_Bank33
    call DrawPlayerNameAndString0Category1
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 3 of the `rst $00` table in Func_033_5215_Table2_Case0F
; no direct call (reached through a table, a jump or a vector)
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0F_Case03::
Jump_033_5E93:: ; address name
    call CallDrawListEntriesCell5RecordPanel
    ret

; entry 1 of the `rst $00` table in Func_033_5215_Table2_Case0F
; no direct call (reached through a table, a jump or a vector)
; reads: wListPages, wScreenStep
; writes: wArg1, wArg2, wScreenStep
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0F_Case01::
Jump_033_5E97:: ; address name
    call ListAvailableRecordsForSelection_Bank33
    farcall ClampRecordListPageCursor5
    ld a, [wListPages]
    cp a, $02
    jr c, Jump_033_5EBE
    ld hl, wWindowTileBuffer + $12E
    call StoreC5BEC6AtHLStride2_Bank33
    ld hl, wWindowTileBuffer + $12F
    ld a, h
    ld [wArg1], a
    ld a, l
    ld [wArg2], a
    farcall DrawPageOfPagesAtArg1_Bank1E

Jump_033_5EBE::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 2 of the `rst $00` table in Func_033_5215_Table2_Case0F
; no direct call (reached through a table, a jump or a vector)
; writes: wArg1
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0F_Case02::
Jump_033_5EC6:: ; address name
    farcall DrawRecordListPageNames
    xor a, a
    ld [wArg1], a
    farcall MarkPartyMembersInRecordListPage
    ret

; entry 4 of the `rst $00` table in Func_033_5215_Table2_Case0F
; no direct call (reached through a table, a jump or a vector)
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0F_Case04::
Jump_033_5ED7:: ; address name
    call CallClearAndDrawListEntriesCell5Name
    ret

; entry 5 of the `rst $00` table in Func_033_5215_Table2_Case0F
; no direct call (reached through a table, a jump or a vector)
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0F_Case05::
Jump_033_5EDB:: ; address name
    call CopyRect62C3ToWC36EAndIncScreenStep
    ret

; entry 6 of the `rst $00` table in Func_033_5215_Table2_Case0F
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex, wChoiceCursor, wScreenStep
; points at: wKeyNameBuf
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0F_Case06::
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
    call CopyListEntriesCell5NameToTextBuf0_Bank33
    call SetDefaultStringWindow_Bank33
    xor a, a
    ld a, $12
    ld [wStringIndex], a
    farcall ShowString_Bank1B_481A
    ld de, wKeyNameBuf
    ld hl, wWindowTileBuffer + $B1
    call RunFunc6204FourTimes
    ld de, TileRect_33_63C7
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRowsJp_Bank33
    xor a, a
    ld [wChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 7 of the `rst $00` table in Func_033_5215_Table2_Case0F
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenByteB2, wScreenByteB3
; writes: hSpriteHideTile, wScreenSubStep, wScreenState, wScreenStep
RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0F_Case07::
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
    ld [wScreenSubStep], a
    ld a, [wScreenByteB2]
    ld [wScreenState], a
    ld a, [wScreenByteB3]
    ld [wScreenStep], a
    call SetDefaultStringWindow_Bank33
    ret

; with SRAM bank 0 enabled, LoadSRAMRecordByte with A = wD7DD (C = field from the caller); then disables SRAM (E-0119)
; no direct call (reached through a table, a jump or a vector)
; writes: rRAMG2, rRAMB
; points at: wPickedRecords
LoadRecordByteForPickedRecords:: ; heuristic: follows a terminator; C0
Func_033_5F6B:: ; address name
    ld hl, wPickedRecords
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
; 2 call sites from 2 routines (e.g. RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case0C, RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case0B)
; points at: wKeyNameBuf
DrawBox639FAndKeyRows::
Func_033_5F83:: ; address name
    ld de, TileRect_33_639F
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRowsJp_Bank33
    ld de, wKeyNameBuf
    ld hl, wWindowTileBuffer + $B1
    call RunFunc6204FourTimes
    ret

; lists in wD789 the stored records (state 1, or 2 unless wD7DC is 3) whose field $6E is clear and that are not already chosen in wD7DD; count in wD7A9 (E-0130)
; 1 call site from 1 routine (e.g. RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0F_Case01)
; reads: wPickCount, wRecordsFlagged
; writes: wListCount, rRAMG2, rRAMB, wRecordsFlagged
; points at: wListEntries, wListEntries2, sRecords, wPickedRecords
ListAvailableRecordsForSelection_Bank33::
Func_033_5F99:: ; address name
    ld hl, wListEntries
    ld b, $1E

Jump_033_5F9E::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_033_5F9E
    ld hl, wListEntries2
    ld b, $1E

Jump_033_5FA8::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_033_5FA8
    xor a, a
    ld [wListCount], a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld [wRecordsFlagged], a
    ld de, sRecords
    ld hl, wListEntries
    ld b, $00
    ld c, $00

Jump_033_5FC7::
    ld a, [de]
    and a, a
    jr z, Jump_033_601D
    cp a, $01
    jr z, Jump_033_5FDD
    ld a, [wPickCount]
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
    ld a, [wPickCount]
    and a, a
    jr z, Jump_033_6010
    cp a, $03
    jr nc, Jump_033_6010
    push hl
    push de
    push bc
    ld d, b
    ld hl, wPickedRecords
    ld a, [wPickCount]
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
    ld a, [wRecordsFlagged]
    inc a
    ld [wRecordsFlagged], a

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
    ld [wListCount], a
    xor a, a
    ld [rRAMG2], a
    farcall MovePartyRecordsToFrontOfList
    ret

; the same 16 bytes as ShowStringA10_Bank1B (1B:7439)
; 3 call sites from 3 routines (e.g. RunLinkExchangeState_450D_Case01_Sub01_Table2_Case02_Case01, RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case0C, RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case08)
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
; 9 call sites from 9 routines (e.g. RunLinkExchangeState_450D_Case01_Sub01_Case00, RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case09, RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case07, RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05_Case04, ...)
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
; 2 call sites from 2 routines (e.g. RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case0A, RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case08)
; reads: wArg5, wArg6
; points at: wPickedRecords
StoreListEntriesCell5RecordInPickedRecords::
Func_033_6060:: ; address name
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld de, wPickedRecords
    ld a, [hl]
    ld [de], a
    ret

; copies the name of the record at WD789 cell 5 (11 bytes) to wC130 (E-0124)
; 3 call sites from 3 routines (e.g. RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case08, RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0E_Case06, RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0F_Case06)
; reads: wArg5, wArg6
; writes: rRAMG2, rRAMB, rRAMG
; points at: wNameGlyphBuf, wTextBuf0
CopyListEntriesCell5NameToTextBuf0_Bank33::
Func_033_6074:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld c, $01
    call CopyRecordNameToNameGlyphBuf
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
; 1 call site from 1 routine (e.g. RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case0C)
; reads: wPickCount, wScreenStep
; writes: wSelectedRecord, wPackWork, wPickCount, wScreenSubStep, wScreenStep
FinishPickedRecordsEntryAndStep_33::
Func_033_60A7:: ; address name
    ld a, [wPickCount]
    ld [wSelectedRecord], a
    ld a, $FF
    ld [wPackWork], a
    ld a, $04
    ld [wPickCount], a
    xor a, a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; HL = table of 16-bit addresses, A = index: stores B at the address in entry A; keeps BC; clobbers A, DE, HL (the same 16 bytes appear in 4 banks)
; 4 call sites from 3 routines (e.g. RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case08, RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case07, RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0F_Case00)
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
; 11 call sites from 9 routines (e.g. RunLinkExchangeState_450D_Case01_Sub01_Case01, RunLinkExchangeState_450D_Case01_Sub01_Case06_Case01, RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case0C, RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case0B, ...)
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
; 11 call sites from 9 routines (e.g. RunLinkExchangeState_450D_Case01_Sub01_Case01, RunLinkExchangeState_450D_Case01_Sub01_Case06_Case01, RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case0C, RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case0B, ...)
; reads: wIsCGB
; writes: wTextCursorLo, wTextCursorHi, rSVBK
; points at: wScreenTileBuffer, wScreenAttrBuffer
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
    ld hl, wScreenAttrBuffer
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
; 14 call sites from 11 routines (e.g. RunLinkExchangeState_450D_Case01_Sub01_Case00, DrawBox639FAndKeyRows, RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case09, CopyRect62C3ToWC36EAndIncScreenStep, ...)
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
; 1 call site from 1 routine (e.g. RunLinkExchangeState_450D_Case01_Sub01_Case01)
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
; 7 call sites from 6 routines (e.g. RunLinkExchangeState_450D_Case01_Sub01_Case01, DrawBox639FAndKeyRows, RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case07, RunLinkExchangeState_450D_Case01_Sub01_Table2_Case05_Case04, ...)
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
; 1 call site from 1 routine (e.g. RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case0B)
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
; 3 call sites from 3 routines (e.g. RunLinkExchangeState_450D_Case01_Sub01_Case00, RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0E_Case00, RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0F_Case00)
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
; 1 call site from 1 routine (e.g. RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0F_Case01)
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

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 3 tiles, one row per line
TileRect_33_62AB::
Data_033_62AB:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $BF, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 2

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 10 x 11 tiles, one row per line
TileRect_33_62C3::
Data_033_62C3:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $00, $01, $02, $03, $04, $C3, $C3, $C3, $B7 ; id 1
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA ; id 2
    db $B6, $10, $11, $12, $C3, $16, $ED, $C3, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $13, $14, $15, $C3, $16, $ED, $C3, $C3, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $10, $11, $12, $C3, $17, $ED, $C3, $C3, $B7 ; id 7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 8
    db $B6, $13, $14, $15, $C3, $17, $ED, $C3, $C3, $B7 ; id 9
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 10

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 10 x 11 tiles, one row per line
TileRect_33_6331::
Data_033_6331:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $05, $06, $07, $08, $09, $C3, $C3, $C3, $B7 ; id 1
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA ; id 2
    db $B6, $10, $11, $12, $C3, $16, $ED, $C3, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $13, $14, $15, $C3, $16, $ED, $C3, $C3, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $10, $11, $12, $C3, $17, $ED, $C3, $C3, $B7 ; id 7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 8
    db $B6, $13, $14, $15, $C3, $17, $ED, $C3, $C3, $B7 ; id 9
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 10

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 5 tiles, one row per line
TileRect_33_639F::
Data_033_639F:: ; address name
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 0
    db $14, $15, $C3, $17, $ED, $C3, $C3, $B7 ; id 1
    db $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 2
    db $B7, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 3
    db $B5, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 5 tiles, one row per line
TileRect_33_63C7::
Data_033_63C7:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $70, $71, $72, $73, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $74, $75, $C3, $C3, $C3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 4

; address loaded by RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case07, RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case08, RunLinkExchangeState_450D_Case01_Sub01_Table2_Case04_Case0B, RunLinkExchangeState_450D_Case01_Sub01_Table2_Case0F_Case00
Data_033_63EF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $79, $C3, $A1, $C3, $C9, $C3, $F1, $C3, $19, $C4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 9 x 7 tiles, one row per line
TileRect_33_63F9::
Data_033_63F9:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $30, $31, $32, $33, $34, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $35, $36, $37, $38, $C3, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $39, $3A, $31, $34, $C3, $C3, $B7 ; id 5
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 6

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 11 tiles, one row per line
TileRect_33_6438::
Data_033_6438:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $D0, $D1, $D2, $D3, $D4, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $D5, $D6, $D7, $D8, $D9, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $DA, $DB, $DC, $DD, $DE, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $F0, $F1, $F2, $F3, $F4, $B7 ; id 7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 8
    db $B6, $C3, $A4, $A5, $A6, $CE, $CF, $B7 ; id 9
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 10

; ld de, this bank's string table / BeginStringDisplay
; 2 call sites from 2 routines (e.g. ShowString_Bank33_649E, DebugMessageTest_Update_Case1A)
BeginStringDisplay_Bank33_6490::
Func_033_6490:: ; address name
    ld de, StringCategories_33_64A5
    call BeginStringDisplay
    ret
    db $11, $A5, $64, $CD, $FE, $25, $C9

; Func_033_6490 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; 3 call sites from 1 routine (e.g. ArenaMenu_Case00)
ShowString_Bank33_649E::
Func_033_649E:: ; address name
    call BeginStringDisplay_Bank33_6490
    call RunStringDisplayToEnd
    ret

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_33_64A5::
Data_033_64A5:: ; address name
    dw StringList_33_64A7 ; id 0

; E-0217 (derived: category list of StringCategories_33_64A5; one pointer per wStringIndex)
; record: string
StringList_33_64A7::
Data_033_64A7:: ; address name
    dw Data_033_6515 ; id 0
    dw Data_033_6515 ; id 1
    dw Data_033_6534 ; id 2
    dw Data_033_6557 ; id 3
    dw Data_033_657F ; id 4
    dw Data_033_65A4 ; id 5
    dw Data_033_65C6 ; id 6
    dw Data_033_65EA ; id 7
    dw Data_033_65EA ; id 8
    dw Data_033_65EA ; id 9
    dw Data_033_660F ; id 10
    dw Data_033_6631 ; id 11
    dw Data_033_6652 ; id 12
    dw Data_033_6695 ; id 13
    dw Data_033_66D8 ; id 14
    dw Data_033_671B ; id 15
    dw Data_033_6760 ; id 16
    dw Data_033_67A5 ; id 17
    dw Data_033_67E3 ; id 18
    dw Data_033_67F6 ; id 19
    dw Data_033_680E ; id 20
    dw Data_033_6832 ; id 21
    dw Data_033_6832 ; id 22
    dw Data_033_6853 ; id 23
    dw Data_033_6860 ; id 24
    dw Data_033_686D ; id 25
    dw Data_033_6879 ; id 26
    dw Data_033_6886 ; id 27
    dw Data_033_6886 ; id 28
    dw Data_033_6886 ; id 29
    dw Data_033_6886 ; id 30
    dw Data_033_6886 ; id 31
    dw Data_033_6886 ; id 32
    dw Data_033_69CE ; id 33
    dw Data_033_6A2E ; id 34
    dw Data_033_6A8E ; id 35
    dw Data_033_6AEE ; id 36
    dw Data_033_6C08 ; id 37
    dw Data_033_6C8D ; id 38
    dw Data_033_6D17 ; id 39
    dw Data_033_6D70 ; id 40
    dw Data_033_6D70 ; id 41
    dw Data_033_6DCA ; id 42
    dw Data_033_6DEA ; id 43
    dw Data_033_6E4D ; id 44
    dw Data_033_6E6F ; id 45
    dw Data_033_6E90 ; id 46
    dw Data_033_6EB3 ; id 47
    dw Data_033_6F10 ; id 48
    dw Data_033_6F2F ; id 49
    dw Data_033_6F4F ; id 50
    dw Data_033_6F69 ; id 51
    dw Data_033_6F88 ; id 52
    dw Data_033_6FD6 ; id 53
    dw BeginStringDisplay_Bank33_7037 ; id 54

Data_033_6515:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " You", $42, "e finished", $F1
    db "that Class.", $F7
    db $F0

Data_033_6534:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Which Class will", $F1
    db "you challenge?", $F0

Data_033_6557:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Train some"

Data_033_6564:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " more,", $F1
    db "and see you again!", $F7
    db $F0

Data_033_657F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Let me confirm", $F1
    db "that-the ", $F9, "0 Class?", $F0

Data_033_65A4:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Good luck! I'll", $F1
    db "cheer for you!", $F7
    db $F0

Data_033_65C6:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Not enough gold", $F1
    db "for that Class!", $F7
    db $F0

Data_033_65EA:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Oh", $A4, " The crowd", $F1
    db "wanted to see you", $A4, $F7
    db $F0

Data_033_660F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " How many masters", $F1
    db "in the group?", $F0

Data_033_6631:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Will you try a", $F1
    db "Master Battle?", $F0

Data_033_6652:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " The S Class", $F1
    db "should be good.", $FA, $F7
    db $EF, $EE, "Which Class will", $EF, $EE, "you challenge?", $F0

Data_033_6695:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " The A Class", $F1
    db "should be good.", $FA, $F7
    db $EF, $EE, "Which Class will", $EF, $EE, "you challenge?", $F0

Data_033_66D8:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " The B Class", $F1
    db "should be good.", $FA, $F7
    db $EF, $EE, "Which Class will", $EF, $EE, "you challenge?", $F0

Data_033_671B:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " It could get", $F1
    db "rough out there.", $FA, $F7
    db $EF, $EE, "Which Class will", $EF, $EE, "you challenge?", $F0

Data_033_6760:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " It "

Data_033_6766:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "could get", $F1
    db "rough out there.", $FA, $F7
    db $EF, $EE, "Which Class will", $EF, $EE, "you challenge?", $F0

Data_033_67A5:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " The E Class", $F1
    db "should do.", $FA, $F7
    db $EF, $EE, "Which Class will", $EF, $EE, "you challenge?", $F0

Data_033_67E3:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Is ", $F9, "0 Class OK?", $F0

Data_033_67F6:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I hope you do", $F1
    db "well!", $F7
    db $F0

Data_033_680E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " You need more", $F1
    db "gold to register.", $F7
    db $F0

Data_033_6832:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " You can't try", $F1
    db "that Class yet.", $F7
    db $F0

Data_033_6853:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "lasSABCDE", $AC, "No", $F0

Data_033_6860:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Battles Cost", $F0

Data_033_686D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "INFOTESKLPA", $F0

Data_033_6879:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "lasSABCDE", $AC, "No", $F0

Data_033_6886:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Congratulations!", $F1
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
    db $F0

Data_033_69CE:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Congratulations!", $F1
    db "You did it!", $FA, $F7
    db $EF, $EE, "You", $42, "e won the", $EF, $EE, "C Class!", $FA, $F7
    db $EF, $EE, "Here's your prize", $EF, $EE, "-a  Magic Key!", $F7
    db $F0

Data_033_6A2E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Congratulations!", $F1
    db "You did it!", $FA, $F7
    db $EF, $EE, "You", $42, "e won the", $EF, $EE, "B Class!", $FA, $F7
    db $EF, $EE, "Here's your prize", $EF, $EE, "-a  Magic Key!", $F7
    db $F0

Data_033_6A8E:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Congratulations!", $F1
    db "You did it!", $FA, $F7
    db $EF, $EE, "You", $42, "e won the", $EF, $EE, "A Class!", $FA, $F7
    db $EF, $EE, "Here's your prize", $EF, $EE, "-a  Magic Key!", $F7
    db $F0

Data_033_6AEE:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Congratulations!", $F1
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
    db $F0

Data_033_6C08:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Too bad you", $F1
    db "didn't make it.", $FA, $F7
    db $EF, $EE, "It's hard to win", $EF, $EE, "if your monsters", $FA, $F7
    db $EF, $EE, "aren't leveled up", $EF, $EE, "enough.", $FA, $F7
    db $EF, $EE, "I hope you do", $EF, $EE, "better next time.", $F7
    db $F0

Data_033_6C8D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Too bad you", $F1
    db "didn't make it.", $FA, $F7
    db $EF, $EE, "You can create", $EF, $EE, "tougher monsters", $FA, $F7
    db $EF, $EE, "by leveling up", $EF, $EE, "those you bred.", $FA, $F7
    db $EF, $EE, "I hope you do", $EF, $EE, "better next time.", $F7
    db $F0

Data_033_6D17:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Congratulations!", $F1
    db $F9, "0 does it!", $FA, $F7
    db $EF, $EE, "You", $42, "e won", $EF, $EE, $F9, "GG!", $FA, $F7
    db $EF, $EE, "We hope you'll", $EF, $EE, "battle here agai"

Data_033_6D6C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "n!", $F7
    db $F0

Data_033_6D70:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " You lost?", $F1
    db "That's too bad.", $FA, $F7
    db $EF, $EE, "Try again after", $EF, $EE, "leveling up your", $FA, $F7
    db $EF, $EE, "monsters some", $EF, $EE, "more.", $F7
    db $F0

Data_033_6DCA:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received", $F1
    db "the Magic Key.", $E5, $58, $F7
    db $E9, $FF, $F0

Data_033_6DEA:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " ", $A4, "Oh, but your", $F1
    db "key ring is full.", $FA, $F7
    db $EF, $EE, "You'll have to", $EF, $EE, "make room, and", $FA, $F7
    db $EF, $EE, "come back for this", $EF, $EE, "later.", $F7
    db $F0

Data_033_6E4D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Here's the Magic", $F1
    db "Key you", $44, " won!", $F7
    db $F0

Data_033_6E6F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 received", $F1
    db "the Pirate Key.", $E5, $58, $F7
    db $E9, $FF, $F0

Data_033_6E90:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Here's the Pirate", $F1
    db "Key you", $44, " won!", $F7
    db $F0

Data_033_6EB3:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Congratulations!", $F1
    db "You did it!", $FA, $F7
    db $EF, $EE, "You", $42, "e won the", $EF, $EE, $F9, "0 Class!", $FA, $F7
    db $EF, $EE, "Choose one of", $EF, $EE, "these chests!", $F7
    db $F0

Data_033_6F10:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Do you want the", $F1
    db "left chest?", $F0

Data_033_6F2F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Do you want the", $F1
    db "right chest?", $F0

Data_033_6F4F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Your prize is", $F1
    db "one ", $F9, "G!", $F7
    db $F0

Data_033_6F69:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Yo"

Data_033_6F6E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "ur prize is", $F1
    db "a Magic Key!", $F7
    db $F0

Data_033_6F88:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " ", $A4, "Oh, but you", $F1
    db "have no room.", $FA, $F7
    db $EF, $EE, "Well, instead of", $EF, $EE, "the ", $F9, "G,", $FA, $F7
    db $EF, $EE, "here's 6000G.", $EF, $EE, $F7
    db $F0

Data_033_6FD6:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " ", $A4, "Oh, but your", $F1
    db "key ring is full.", $FA, $F7
    db $EF, $EE, "Well, instead of", $EF, $EE, "the Magic Key,", $FA, $F7
    db $EF, $EE, "here's 6000G", $EF, $EE, "instead.", $F7
    db $F0

; ld de, this bank's string table / BeginStringDisplay
; 3 call sites from 3 routines (e.g. ShowString_Bank33_7045, DebugMessageTest_Update_Case1F, ShowStringAInDefaultWindow_Bank24)
BeginStringDisplay_Bank33_7037::
Func_033_7037:: ; address name
    ld de, StringCategories_33_704C
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

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_33_704C::
Data_033_704C:: ; address name
    dw StringList_33_704E ; id 0

; E-0217 (derived: category list of StringCategories_33_704C; one pointer per wStringIndex)
; record: string
StringList_33_704E::
Data_033_704E:: ; address name
    dw Data_033_7074 ; id 0
    dw Data_033_7089 ; id 1
    dw Data_033_70A7 ; id 2
    dw Data_033_70BE ; id 3
    dw Data_033_70D0 ; id 4
    dw Data_033_70DE ; id 5
    dw Data_033_711F ; id 6
    dw Data_033_7157 ; id 7
    dw Data_033_716A ; id 8
    dw Data_033_717D ; id 9
    dw Data_033_718F ; id 10
    dw Data_033_71A2 ; id 11
    dw Data_033_71AD ; id 12
    dw Data_033_71B3 ; id 13
    dw Data_033_71BE ; id 14
    dw Data_033_71BE ; id 15
    dw Data_033_71BE ; id 16
    dw Data_033_71BE ; id 17
    dw Data_033_71D1 ; id 18

Data_033_7074:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "It ends in a draw!", $FA, $F7
    db $F0

Data_033_7089:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Congratulations!", $F1
    db "You", $42, "e won!", $FA, $F7
    db $F0

Data_033_70A7:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Too bad!", $F1
    db "You", $42, "e lost!", $FA, $F7
    db $F0

Data_033_70BE:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Turned over", $F1
    db $F9, "0", $A4, $FA, $F7
    db $F0

Data_033_70D0:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Received", $F1
    db $F9, "0", $FA, $F7
    db $F0

Data_033_70DE:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "But you have no", $F1
    db "room for it", $A4, $FA, $F7
    db $EF, $EE, "Switch it with", $EF, $EE, "another monster?", $F0

Data_033_711F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Gave up on getting", $F1
    db $F9, "0 and released", $FA, $F7
    db $EF, $EE, "it in the wild", $A4, $FA, $F7
    db $F0

Data_033_7157:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Switch with which?", $F0

Data_033_716A:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Switch"

Data_033_7170:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " with which?", $F0

Data_033_717D:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Switch which egg?", $F0

Data_033_718F:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0", $F1
    db "was released.", $FA, $F7
    db $F0

Data_033_71A2:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "MonsterE?g", $F0

Data_033_71AD:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "YesNo", $F0

Data_033_71B3:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "InfoOKYesN", $F0

Data_033_71BE:: ; heuristic: string; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "There are no eggs.", $F0

Data_033_71D1:: ; heuristic: string; C0
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
