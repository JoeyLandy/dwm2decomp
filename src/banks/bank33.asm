SECTION "Bank 33", ROMX[$4000], BANK[$33]
    db $33

; DE = block number: the table at $405F gives each block an offset into wScreenTileBuffer (word), a
; width B and a height C, followed by B * C tile bytes; they are copied into wScreenTileBuffer rows
; 32 bytes apart
CopyBlockToTileBuffer::
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

.loop:
    push bc
    push hl

.loop2:
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, .loop2
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, .loop
    ret

; E = block: copies the screen block from ScreenBlockTable[E] (word offset, width, rows, tiles) into
; wScreenTileBuffer like CopyBlockToTileBuffer, but writes tile $C3 for tiles $15-$A3 (the text
; glyphs) (E-0117)
CopyBlockToTileBufferBlankingText::
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

.loop:
    push bc
    push hl

.loop2:
    ld a, [de]
    cp $15
    jr c, .skip
    cp $a4
    jr nc, .skip
    ld a, $c3

.skip:
    ld [hli], a
    inc de
    dec b
    jr nz, .loop2
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, .loop
    ret

; CopyBlockToTileBuffer and CopyBlockToTileBufferBlankingText read the word at $405F + 2 * E and
; copy that record (word offset into wScreenTileBuffer, width, rows, tiles) into the screen buffer;
; 51 words, and the records tile $40C5-$51C6 (E-0232, C1)
; record: screen block record
ScreenBlockTable::
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

; a record of ScreenBlockTable (E-0232, C1)
; record: offset $0000 (row 0, column 0); 8 x 9 tiles
TileRect_33_40C5::
    dw $0000 ; entry 0: offset into wScreenTileBuffer
    db $08, $09 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $c3, $a4, $a5, $a6, $a7, $c3, $b7 ; row 1
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; row 2
    db $b6, $c3, $d0, $d1, $d2, $d3, $d4, $b7 ; row 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $c3, $d5, $d6, $d7, $d8, $d9, $b7 ; row 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 6
    db $b6, $c3, $da, $db, $dc, $dd, $de, $b7 ; row 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 8

; record: offset $0008 (row 0, column 8); 12 x 13 tiles
TileRect_33_4111::
    dw $0008 ; entry 0: offset into wScreenTileBuffer
    db $0c, $0d ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $c3, $ea, $ed, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 1
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; row 2
    db $b6, $c3, $ae, $a8, $ab, $c3, $c3, $ed, $c3, $c3, $c3, $b7 ; row 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $c3, $ee, $a9, $a6, $c3, $c3, $ed, $c3, $c3, $c3, $b7 ; row 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 6
    db $b6, $c3, $ae, $bf, $ac, $c3, $c3, $ed, $c3, $c3, $c3, $b7 ; row 7
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 8
    db $b6, $c3, $a4, $a5, $a8, $c3, $c3, $ed, $c3, $c3, $c3, $b7 ; row 9
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 10
    db $b6, $c3, $ef, $ac, $ee, $c3, $c3, $ed, $c3, $c3, $c3, $b7 ; row 11
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 12

; record: offset $0161 (row 11, column 1); 6 x 6 tiles
TileRect_33_41B1::
    dw $0161 ; entry 0: offset into wScreenTileBuffer
    db $06, $06 ; width, rows
    db $5c, $5d, $5e, $5f, $60, $61 ; row 0
    db $62, $63, $64, $65, $66, $67 ; row 1
    db $68, $69, $6a, $6b, $6c, $6d ; row 2
    db $6e, $6f, $70, $71, $72, $73 ; row 3
    db $74, $75, $76, $77, $78, $79 ; row 4
    db $7a, $7b, $7c, $7d, $7e, $7f ; row 5

; record: offset $01A8 (row 13, column 8); 12 x 5 tiles
TileRect_33_41D9::
    dw $01a8 ; entry 0: offset into wScreenTileBuffer
    db $0c, $05 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $f9, $fa, $ed, $c3, $c3, $c3, $be, $c3, $c3, $c3, $b7 ; row 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 2
    db $b6, $fb, $fa, $ed, $c3, $c3, $c3, $be, $c3, $c3, $c3, $b7 ; row 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 4

; a record of ScreenBlockTable (E-0232, C1)
; record: offset $0008 (row 0, column 8); 12 x 11 tiles
TileRect_33_4219::
    dw $0008 ; entry 0: offset into wScreenTileBuffer
    db $0c, $0b ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $c3, $ea, $ed, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 1
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; row 2
    db $b6, $4c, $4d, $4e, $4f, $50, $51, $52, $53, $54, $c3, $b7 ; row 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $55, $56, $57, $58, $59, $5a, $5b, $5c, $5d, $c3, $b7 ; row 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 6
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 7
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 8
    db $b6, $ec, $ec, $ed, $47, $48, $49, $4a, $4b, $c3, $c3, $b7 ; row 9
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 10

; record: offset $0160 (row 11, column 0); 8 x 7 tiles
TileRect_33_42A1::
    dw $0160 ; entry 0: offset into wScreenTileBuffer
    db $08, $07 ; width, rows
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; row 0
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 1
    db $b6, $35, $36, $37, $38, $39, $3a, $b7 ; row 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 3
    db $b6, $3b, $3c, $3d, $3e, $3f, $40, $b7 ; row 4
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 5
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; row 6

; record: offset $0168 (row 11, column 8); 12 x 7 tiles
TileRect_33_42DD::
    dw $0168 ; entry 0: offset into wScreenTileBuffer
    db $0c, $07 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $fd, $ed, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 1
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; row 2
    db $b6, $a5, $cf, $f1, $f2, $c3, $ac, $cf, $f3, $cf, $f4, $b7 ; row 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $fd, $ed, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 6

; record: offset $0008 (row 0, column 8); 12 x 18 tiles
TileRect_33_4335::
    dw $0008 ; entry 0: offset into wScreenTileBuffer
    db $0c, $12 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $c3, $38, $39, $3a, $3b, $3c, $3d, $3e, $3f, $40, $b7 ; row 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 2
    db $b6, $c3, $41, $42, $43, $44, $45, $46, $47, $48, $49, $b7 ; row 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $c3, $4a, $4b, $4c, $4d, $4e, $4f, $50, $51, $52, $b7 ; row 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 6
    db $b6, $c3, $53, $54, $55, $56, $57, $58, $59, $5a, $5b, $b7 ; row 7
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 8
    db $b6, $c3, $5c, $5d, $5e, $5f, $60, $61, $62, $63, $64, $b7 ; row 9
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 10
    db $b6, $c3, $65, $66, $67, $68, $69, $6a, $6b, $6c, $6d, $b7 ; row 11
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 12
    db $b6, $c3, $6e, $6f, $70, $71, $72, $73, $74, $75, $76, $b7 ; row 13
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 14
    db $b6, $c3, $77, $78, $79, $7a, $7b, $7c, $7d, $7e, $7f, $b7 ; row 15
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 16
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 17

; a record of ScreenBlockTable (E-0232, C1)
TileRect_33_4411::
    dw $0160 ; entry 0: offset into wScreenTileBuffer
    db $08, $07 ; width, rows
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; row 0
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; row 1
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; row 2
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; row 3
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; row 4
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; row 5
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; row 6

TileRect_33_444D::
    dw $0008 ; entry 0: offset into wScreenTileBuffer
    db $0c, $12 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $f5, $f6, $df, $cf, $ed, $58, $59, $5a, $5b, $5c, $b7 ; row 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 2
    db $b6, $5d, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $5e, $5f, $60, $61, $62, $63, $64, $65, $66, $c3, $b7 ; row 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 6
    db $b6, $ec, $ec, $ed, $67, $68, $69, $6a, $6b, $c3, $c3, $b7 ; row 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 8
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 9
    db $b6, $ec, $f6, $f2, $cf, $ed, $6c, $6d, $6e, $6f, $70, $b7 ; row 10
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 11
    db $b6, $71, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 12
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 13
    db $b6, $72, $73, $74, $75, $76, $77, $78, $79, $7a, $c3, $b7 ; row 14
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 15
    db $b6, $ec, $ec, $ed, $7b, $7c, $7d, $7e, $7f, $c3, $c3, $b7 ; row 16
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 17

; record: offset $0183 (row 12, column 3); 2 x 4 tiles
TileRect_33_4529::
    dw $0183 ; entry 0: offset into wScreenTileBuffer
    db $02, $04 ; width, rows
    db $c3, $0f ; row 0
    db $11, $10 ; row 1
    db $12, $10 ; row 2
    db $c3, $13 ; row 3

; record: offset $0000 (row 0, column 0); 7 x 13 tiles
TileRect_33_4535::
    dw $0000 ; entry 0: offset into wScreenTileBuffer
    db $07, $0d ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $d0, $d1, $d2, $d3, $d4, $b7 ; row 1
    db $b8, $b9, $b9, $b9, $b9, $b9, $ba ; row 2
    db $b6, $eb, $c3, $c3, $c3, $c3, $b7 ; row 3
    db $b6, $ec, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $ea, $ed, $c3, $c3, $c3, $b7 ; row 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b5 ; row 6
    db $c3, $14, $15, $16, $17, $18, $19 ; row 7
    db $c3, $1a, $1b, $1c, $1d, $1e, $1f ; row 8
    db $c3, $20, $21, $22, $23, $24, $25 ; row 9
    db $c3, $26, $27, $28, $29, $2a, $2b ; row 10
    db $c3, $2c, $2d, $2e, $2f, $30, $31 ; row 11
    db $c3, $32, $33, $34, $35, $36, $37 ; row 12

; record: offset $0000 (row 0, column 0); 13 x 13 tiles
TileRect_33_4594::
    dw $0000 ; entry 0: offset into wScreenTileBuffer
    db $0d, $0d ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $d0, $d1, $d2, $d3, $d4, $c3, $d5, $d6, $d7, $d8, $d9, $b7 ; row 1
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; row 2
    db $b6, $eb, $c3, $c3, $c3, $c3, $c3, $eb, $c3, $c3, $c3, $c3, $b7 ; row 3
    db $b6, $ec, $c3, $c3, $c3, $c3, $c3, $ec, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $ea, $ed, $c3, $c3, $c3, $c3, $ea, $ed, $c3, $c3, $c3, $b7 ; row 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 6
    db $c3, $14, $15, $16, $17, $18, $19, $38, $39, $3a, $3b, $3c, $3d ; row 7
    db $c3, $1a, $1b, $1c, $1d, $1e, $1f, $3e, $3f, $40, $41, $42, $43 ; row 8
    db $c3, $20, $21, $22, $23, $24, $25, $44, $45, $46, $47, $48, $49 ; row 9
    db $c3, $26, $27, $28, $29, $2a, $2b, $4a, $4b, $4c, $4d, $4e, $4f ; row 10
    db $c3, $2c, $2d, $2e, $2f, $30, $31, $50, $51, $52, $53, $54, $55 ; row 11
    db $c3, $32, $33, $34, $35, $36, $37, $56, $57, $58, $59, $5a, $5b ; row 12

; record: offset $0000 (row 0, column 0); 20 x 13 tiles
TileRect_33_4641::
    dw $0000 ; entry 0: offset into wScreenTileBuffer
    db $14, $0d ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $d0, $d1, $d2, $d3, $d4, $c3, $d5, $d6, $d7, $d8, $d9, $c3, $da, $db, $dc, $dd, $de, $c3, $b7 ; row 1
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; row 2
    db $b6, $eb, $c3, $c3, $c3, $c3, $c3, $eb, $c3, $c3, $c3, $c3, $c3, $eb, $c3, $c3, $c3, $c3, $c3, $b7 ; row 3
    db $b6, $ec, $c3, $c3, $c3, $c3, $c3, $ec, $c3, $c3, $c3, $c3, $c3, $ec, $c3, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $ea, $ed, $c3, $c3, $c3, $c3, $ea, $ed, $c3, $c3, $c3, $c3, $ea, $ed, $c3, $c3, $c3, $c3, $b7 ; row 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 6
    db $c3, $14, $15, $16, $17, $18, $19, $38, $39, $3a, $3b, $3c, $3d, $5c, $5d, $5e, $5f, $60, $61, $c3 ; row 7
    db $c3, $1a, $1b, $1c, $1d, $1e, $1f, $3e, $3f, $40, $41, $42, $43, $62, $63, $64, $65, $66, $67, $c3 ; row 8
    db $c3, $20, $21, $22, $23, $24, $25, $44, $45, $46, $47, $48, $49, $68, $69, $6a, $6b, $6c, $6d, $c3 ; row 9
    db $c3, $26, $27, $28, $29, $2a, $2b, $4a, $4b, $4c, $4d, $4e, $4f, $6e, $6f, $70, $71, $72, $73, $c3 ; row 10
    db $c3, $2c, $2d, $2e, $2f, $30, $31, $50, $51, $52, $53, $54, $55, $74, $75, $76, $77, $78, $79, $c3 ; row 11
    db $c3, $32, $33, $34, $35, $36, $37, $56, $57, $58, $59, $5a, $5b, $7a, $7b, $7c, $7d, $7e, $7f, $c3 ; row 12

; a record of ScreenBlockTable (E-0232, C1)
; record: offset $01A4 (row 13, column 4); 12 x 5 tiles
TileRect_33_4749::
    dw $01a4 ; entry 0: offset into wScreenTileBuffer
    db $0c, $05 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $80, $81, $82, $83, $84, $85, $86, $87, $88, $c3, $b7 ; row 1
    db $b6, $89, $8a, $8b, $8c, $8d, $8e, $8f, $90, $91, $c3, $b7 ; row 2
    db $b6, $92, $93, $94, $95, $96, $97, $98, $99, $9a, $c3, $b7 ; row 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 4

; record: offset $0000 (row 0, column 0); 6 x 3 tiles
TileRect_33_4789::
    dw $0000 ; entry 0: offset into wScreenTileBuffer
    db $06, $03 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $a4, $a8, $a9, $ec, $b7 ; row 1
    db $b3, $b4, $b4, $b4, $b4, $b5 ; row 2

; record: offset $0008 (row 0, column 8); 12 x 9 tiles
TileRect_33_479F::
    dw $0008 ; entry 0: offset into wScreenTileBuffer
    db $0c, $09 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $c3, $5c, $5d, $5e, $5f, $60, $61, $62, $63, $64, $b7 ; row 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 2
    db $b6, $c3, $65, $66, $67, $68, $69, $6a, $6b, $6c, $6d, $b7 ; row 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $c3, $6e, $6f, $70, $71, $72, $73, $74, $75, $76, $b7 ; row 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 6
    db $b6, $c3, $77, $78, $79, $7a, $7b, $7c, $7d, $7e, $7f, $b7 ; row 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 8

; record: offset $0140 (row 10, column 0); 20 x 7 tiles
TileRect_33_480F::
    dw $0140 ; entry 0: offset into wScreenTileBuffer
    db $14, $07 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $23, $24, $25, $26, $27, $28, $29, $2a, $2b, $2c, $2d, $2e, $2f, $30, $31, $32, $33, $34, $b7 ; row 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 2
    db $b6, $35, $36, $37, $38, $39, $3a, $3b, $3c, $3d, $3e, $3f, $40, $41, $42, $43, $44, $45, $46, $b7 ; row 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $47, $48, $49, $4a, $4b, $4c, $4d, $4e, $4f, $50, $51, $52, $53, $54, $55, $56, $57, $58, $b7 ; row 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 6

; a record of ScreenBlockTable (E-0232, C1)
; record: offset $0040 (row 2, column 0); 7 x 7 tiles
TileRect_33_489F::
    dw $0040 ; entry 0: offset into wScreenTileBuffer
    db $07, $07 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $ee, $ef, $f0, $f1, $c3, $b7 ; row 1
    db $b8, $b9, $b9, $b9, $b9, $b9, $ba ; row 2
    db $b6, $c3, $f2, $f3, $f5, $c3, $b7 ; row 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $c3, $f1, $f4, $f3, $f3, $b7 ; row 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b5 ; row 6

TileRect_33_48D4::
    dw $0040 ; entry 0: offset into wScreenTileBuffer
    db $07, $07 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $ee, $ef, $f0, $f1, $c3, $b7 ; row 1
    db $b8, $b9, $b9, $b9, $b9, $b9, $ba ; row 2
    db $b6, $c3, $f2, $f3, $f4, $f5, $b7 ; row 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $c3, $f6, $f7, $f8, $f9, $b7 ; row 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b5 ; row 6

; record: offset $0100 (row 8, column 0); 6 x 5 tiles
TileRect_33_4909::
    dw $0100 ; entry 0: offset into wScreenTileBuffer
    db $06, $05 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $c3, $ce, $cf, $df, $b7 ; row 1
    db $b6, $c3, $c3, $c3, $c3, $b7 ; row 2
    db $b6, $c3, $a5, $f4, $c3, $b7 ; row 3
    db $b3, $b4, $b4, $b4, $b4, $b5 ; row 4

; record: offset $01A0 (row 13, column 0); 20 x 5 tiles
TileRect_33_492B::
    dw $01a0 ; entry 0: offset into wScreenTileBuffer
    db $14, $05 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8a, $8b, $8c, $8d, $8e, $8f, $90, $91, $b7 ; row 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 2
    db $b6, $92, $93, $94, $95, $96, $97, $98, $99, $9a, $9b, $9c, $9d, $9e, $9f, $a0, $a1, $a2, $a3, $b7 ; row 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 4

; record: offset $0000 (row 0, column 0); 8 x 9 tiles
TileRect_33_4993::
    dw $0000 ; entry 0: offset into wScreenTileBuffer
    db $08, $09 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $c3, $ee, $ef, $a7, $c3, $c3, $b7 ; row 1
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; row 2
    db $b6, $c3, $d0, $d1, $d2, $d3, $d4, $b7 ; row 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $c3, $d5, $d6, $d7, $d8, $d9, $b7 ; row 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 6
    db $b6, $c3, $da, $db, $dc, $dd, $de, $b7 ; row 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 8

; a record of ScreenBlockTable (E-0232, C1)
; record: offset $0120 (row 9, column 0); 14 x 5 tiles
TileRect_33_49DF::
    dw $0120 ; entry 0: offset into wScreenTileBuffer
    db $0e, $05 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 4

TileRect_33_4A29::
    dw $0000 ; entry 0: offset into wScreenTileBuffer
    db $08, $09 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $aa, $ab, $a4, $ac, $ac, $aa, $b7 ; row 1
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; row 2
    db $b6, $c3, $d0, $d1, $d2, $d3, $d4, $b7 ; row 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $c3, $d5, $d6, $d7, $d8, $d9, $b7 ; row 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 6
    db $b6, $c3, $da, $db, $dc, $dd, $de, $b7 ; row 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 8

; record: offset $0120 (row 9, column 0); 20 x 9 tiles
TileRect_33_4A75::
    dw $0120 ; entry 0: offset into wScreenTileBuffer
    db $14, $09 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $23, $24, $25, $26, $27, $28, $29, $2a, $2b, $2c, $2d, $2e, $2f, $30, $31, $32, $33, $34, $b7 ; row 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 2
    db $b6, $35, $36, $37, $38, $39, $3a, $3b, $3c, $3d, $3e, $3f, $40, $41, $42, $43, $44, $45, $46, $b7 ; row 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $47, $48, $49, $4a, $4b, $4c, $4d, $4e, $4f, $50, $51, $52, $53, $54, $55, $56, $57, $58, $b7 ; row 5
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; row 6
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $be, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 8

TileRect_33_4B2D::
    dw $0000 ; entry 0: offset into wScreenTileBuffer
    db $08, $09 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $c3, $f0, $f1, $f2, $c3, $c3, $b7 ; row 1
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; row 2
    db $b6, $c3, $d0, $d1, $d2, $d3, $d4, $b7 ; row 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $c3, $d5, $d6, $d7, $d8, $d9, $b7 ; row 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 6
    db $b6, $c3, $da, $db, $dc, $dd, $de, $b7 ; row 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 8

; record: offset $0000 (row 0, column 0); 13 x 15 tiles
TileRect_33_4B79::
    dw $0000 ; entry 0: offset into wScreenTileBuffer
    db $0d, $0f ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $c3, $c3, $c3, $ad, $ac, $ae, $a5, $c3, $c3, $c3, $c3, $b7 ; row 1
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; row 2
    db $b6, $c3, $ab, $cf, $fa, $df, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $c3, $ad, $f2, $f0, $f3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 6
    db $b6, $c3, $a8, $cf, $f9, $f7, $c3, $aa, $f5, $cf, $cf, $f1, $b7 ; row 7
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 8
    db $b6, $c3, $ee, $cf, $fb, $a7, $f6, $f1, $cf, $f6, $c3, $c3, $b7 ; row 9
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 10
    db $b6, $c3, $a4, $f3, $fc, $f4, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 11
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 12
    db $b6, $c3, $ef, $f4, $f8, $f6, $f3, $f0, $f2, $c3, $c3, $c3, $b7 ; row 13
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 14

; record: offset $0006 (row 0, column 6); 14 x 7 tiles
TileRect_33_4C40::
    dw $0006 ; entry 0: offset into wScreenTileBuffer
    db $0e, $07 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $2a, $2b, $b7 ; row 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 2
    db $b6, $2c, $2d, $2e, $2f, $30, $31, $32, $33, $34, $35, $36, $37, $b7 ; row 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $38, $39, $3a, $3b, $3c, $3d, $3e, $3f, $40, $41, $42, $43, $b7 ; row 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 6

; a record of ScreenBlockTable (E-0232, C1)
; record: offset $0125 (row 9, column 5); 15 x 9 tiles
TileRect_33_4CA6::
    dw $0125 ; entry 0: offset into wScreenTileBuffer
    db $0f, $09 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $c3, $c3, $44, $45, $46, $47, $48, $49, $4a, $4b, $4c, $4d, $4e, $b7 ; row 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 2
    db $b6, $c3, $c3, $50, $51, $52, $53, $54, $55, $56, $57, $58, $59, $5a, $b7 ; row 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $c3, $c3, $5c, $5d, $5e, $5f, $60, $61, $62, $63, $64, $65, $66, $b7 ; row 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 6
    db $b6, $c3, $c3, $68, $69, $6a, $6b, $6c, $6d, $6e, $6f, $70, $71, $72, $b7 ; row 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 8

; record: offset $0000 (row 0, column 0); 7 x 7 tiles
TileRect_33_4D31::
    dw $0000 ; entry 0: offset into wScreenTileBuffer
    db $07, $07 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $fd, $02, $fe, $ff, $c3, $b7 ; row 1
    db $b8, $b9, $b9, $b9, $b9, $b9, $ba ; row 2
    db $b6, $c3, $00, $df, $cf, $c3, $b7 ; row 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $c3, $ff, $f4, $df, $df, $b7 ; row 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b5 ; row 6

; record: offset $00E0 (row 7, column 0); 6 x 5 tiles
TileRect_33_4D66::
    dw $00e0 ; entry 0: offset into wScreenTileBuffer
    db $06, $05 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $c3, $ce, $cf, $df, $b7 ; row 1
    db $b6, $c3, $c3, $c3, $c3, $b7 ; row 2
    db $b6, $c3, $a5, $f4, $c3, $b7 ; row 3
    db $b3, $b4, $b4, $b4, $b4, $b5 ; row 4

; record: offset $00CD (row 6, column 13); 7 x 3 tiles
TileRect_33_4D88::
    dw $00cd ; entry 0: offset into wScreenTileBuffer
    db $07, $03 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $d0, $d1, $d2, $d3, $d4, $b7 ; row 1
    db $b3, $b4, $b4, $b4, $b4, $b4, $b5 ; row 2

; a record of ScreenBlockTable (E-0232, C1)
; record: offset $0129 (row 9, column 9); 11 x 9 tiles
TileRect_33_4DA1::
    dw $0129 ; entry 0: offset into wScreenTileBuffer
    db $0b, $09 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $c3, $01, $0a, $f0, $f6, $07, $cf, $c3, $c3, $b7 ; row 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 2
    db $b6, $c3, $04, $08, $f9, $cf, $f1, $c3, $c3, $c3, $b7 ; row 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $c3, $05, $cf, $fc, $cf, $f3, $06, $cf, $c3, $b7 ; row 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 6
    db $b6, $c3, $01, $f4, $09, $09, $f0, $f3, $f1, $c3, $b7 ; row 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 8

; record: offset $0042 (row 2, column 2); 18 x 7 tiles
TileRect_33_4E08::
    dw $0042 ; entry 0: offset into wScreenTileBuffer
    db $12, $07 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2, $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7, $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5, $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 6

; record: offset $0128 (row 9, column 8); 12 x 9 tiles
TileRect_33_4E8A::
    dw $0128 ; entry 0: offset into wScreenTileBuffer
    db $0c, $09 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $d0, $d1, $d2, $d3, $d4, $cc, $ea, $ed, $c3, $c3, $b7 ; row 1
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; row 2
    db $b6, $c7, $20, $21, $22, $23, $24, $25, $26, $27, $28, $b7 ; row 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $02, $03, $ed, $c3, $c3, $c3, $be, $c3, $c3, $c3, $b7 ; row 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 6
    db $b6, $04, $03, $ed, $c3, $c3, $c3, $be, $c3, $c3, $c3, $b7 ; row 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 8

; record: offset $0020 (row 1, column 0); 20 x 11 tiles
TileRect_33_4EFA::
    dw $0020 ; entry 0: offset into wScreenTileBuffer
    db $14, $0b ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $05, $06, $07, $08, $09, $0a, $ed, $20, $21, $22, $23, $24, $c3, $c3, $c3, $ed, $c3, $c3, $b7 ; row 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 2
    db $b6, $25, $26, $27, $28, $29, $2a, $c3, $ea, $ed, $c3, $c3, $c3, $c3, $c3, $37, $38, $c3, $c3, $b7 ; row 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $39, $3a, $c3, $c3, $b7 ; row 4
    db $b6, $2b, $2c, $2d, $2e, $2f, $30, $c3, $ea, $ed, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 6
    db $b6, $31, $32, $33, $34, $35, $36, $c3, $ea, $ed, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 7
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 8
    db $b6, $3b, $3c, $3d, $3e, $3f, $40, $41, $42, $43, $44, $45, $46, $47, $c3, $c3, $c3, $c3, $c3, $b7 ; row 9
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 10

; a record of ScreenBlockTable (E-0232, C1)
; record: offset $010E (row 8, column 14); 6 x 5 tiles
TileRect_33_4FDA::
    dw $010e ; entry 0: offset into wScreenTileBuffer
    db $06, $05 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $c3, $ce, $cf, $df, $b7 ; row 1
    db $b6, $c3, $c3, $c3, $c3, $b7 ; row 2
    db $b6, $c3, $a5, $f4, $c3, $b7 ; row 3
    db $b3, $b4, $b4, $b4, $b4, $b5 ; row 4

; record: offset $0121 (row 9, column 1); 18 x 5 tiles
TileRect_33_4FFC::
    dw $0121 ; entry 0: offset into wScreenTileBuffer
    db $12, $05 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $a6, $f0, $df, $f7, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $aa, $f2, $f4, $0b, $b7 ; row 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 2
    db $b6, $c3, $e1, $c3, $e2, $c3, $e3, $c3, $e4, $c3, $e5, $c3, $e6, $c3, $e7, $c3, $e8, $b7 ; row 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 4

; record: offset $0000 (row 0, column 0); 20 x 18 tiles
TileRect_33_505A::
    dw $0000 ; entry 0: offset into wScreenTileBuffer
    db $14, $12 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $04, $f0, $df, $f7, $cf, $f6, $ed, $30, $31, $32, $33, $34, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 2
    db $b6, $c3, $c3, $a8, $13, $14, $cf, $ed, $c3, $c3, $c3, $ed, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $c3, $c3, $a6, $f0, $f6, $14, $ed, $04, $a7, $a5, $c3, $c3, $c3, $a9, $bf, $bf, $c3, $c3, $b7 ; row 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 6
    db $b6, $c3, $aa, $f2, $cf, $cf, $f5, $ed, $04, $a7, $a5, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 8
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 9
    db $b6, $c3, $c3, $01, $f0, $f7, $cf, $12, $f4, $f6, $13, $cf, $df, $ed, $c3, $c3, $c3, $c3, $c3, $b7 ; row 10
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 11
    db $b6, $c3, $20, $c3, $c3, $c3, $21, $c3, $c3, $c3, $22, $c3, $c3, $c3, $23, $c3, $c3, $c3, $c3, $b7 ; row 12
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 13
    db $b6, $c3, $24, $c3, $c3, $c3, $25, $c3, $c3, $c3, $26, $c3, $c3, $c3, $27, $c3, $c3, $c3, $c3, $b7 ; row 14
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 15
    db $b6, $c3, $28, $c3, $c3, $c3, $29, $c3, $c3, $c3, $2a, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 16
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 17

GameMode5_Update_Case05_LinkExchangeJoypadPerFrame::
    call LinkExchangeJoypadPerFrame
    ld a, [wTitleScreenState]
    or a
    jr nz, .check_screen_state
    ret

.check_screen_state:
    ld a, [wScreenState]
    cp $0c
    jr z, .check_screen_sub_step
    cp $0d
    jr z, .check_screen_step
    ret

.check_screen_sub_step:
    ld a, [wScreenSubStep]
    and a
    ret nz
    ld a, [wScreenStep]
    cp $20
    jr z, .call_call_draw_party_species_sprites
    cp $15
    jr z, .call_draw_list_entries_cell5_species_sprite
    ret

.call_draw_list_entries_cell5_species_sprite:
    farcall DrawListEntriesCell5SpeciesSprite
    ret

.call_call_draw_party_species_sprites:
    farcall CallDrawPartySpeciesSpritesPreservingArg1AndTemp0
    ret

.check_screen_step:
    ld a, [wScreenStep]
    cp $15
    jr z, .call_draw_wca36_sprite_part_bank_f1
    cp $20
    jr z, .call_draw_record_buf_b_species_sprites
    ret

.call_draw_wca36_sprite_part_bank_f1:
    farcall DrawWCA36SpritePart_BankF1
    ret

.call_draw_record_buf_b_species_sprites:
    farcall DrawRecordBufBSpeciesSprites
    ret

RunLinkSession6Exchange_Case01_ReadTitleScreenStateAndTitleScreenSubStateEtc::
    ld a, [wTitleScreenState]
    or a
    jr nz, .check_fade_state
    ld a, [wTitleScreenSubState]
    jumptable
    dw RunLinkSession6Exchange_Case01_Sub01_DrawPlayerNameAndString0Category1AndStep
    dw RunLinkSession6Exchange_Case01_Sub01_WriteGoldDigitsToWC1BAAndStep
    dw RunLinkSession6Exchange_Case01_Sub01_ShowForTeamMode1Hero
    dw RunLinkSession6Exchange_Case01_Sub01_ShowYourPalRefusedThe
    dw RunLinkSession6Exchange_Case01_Sub01_WriteLinkSendByteAndTitleScreenStateEtc
    dw RunLinkSession6Exchange_Case01_Sub01_SetLinkSendByte
    dw RunLinkSession6Exchange_ChooseTeamMonster
    dw RunLinkSession6Exchange_Case01_Sub01_ShowYouRefusedToPay
    dw RunLinkSession6Exchange_Case01_Sub01_WriteLinkSendByteAndTitleScreenStateEtc_Case08
    dw RunLinkSession6Exchange_Case01_Sub01_WriteLinkSendByteAndTitleScreenStateEtc_Case09
    dw RunLinkSession6Exchange_Case01_Sub01_SetLinkSendByte_Case0A
    dw RunLinkSession6Exchange_Case01_Sub01_ShowYourPalRefusedTo
    dw RunLinkSession6Exchange_Case01_Sub01_WriteTitleScreenSubStateAndLinkSendByteEtc
    dw RunLinkSession6Exchange_Case01_Sub01_WriteLinkSendByteAndTitleScreenStateEtc_Case0D

.check_fade_state:
    ld a, [wFadeState]
    or a
    ret nz
    ld a, [wScreenState]
    jumptable
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case00
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case01
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case02
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case03
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case04
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case05
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case06
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case06
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case06
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case06
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case06
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case06
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case06
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case0D
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case0E
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case0F

RunLinkSession6Exchange_Case01_Sub01_DrawPlayerNameAndString0Category1AndStep::
    ld de, TileRect_33_62AB
    ld hl, wScreenTileBuffer + $c
    ld bc, $0803
    call CopyRectTo20ByteRowsJp_Bank33
    ld de, TileRect_33_62C3
    ld hl, wScreenTileBuffer
    ld bc, $0a0b
    call CopyRectTo20ByteRowsJp_Bank33
    call DrawPlayerNameAndString0Category1
    call SetDefaultStringWindow_Bank33
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

RunLinkSession6Exchange_Case01_Sub01_WriteGoldDigitsToWC1BAAndStep::
    xor a
    ld [wLinkSendByte], a
    call WriteGoldDigitsToWC1BA
    ld de, wKeyNameBuf
    ld hl, wScreenTileBuffer + $43
    call RunFunc6204FourTimes
    call BGMapAddressAtScroll_Bank33
    ld bc, $140d
    ld de, $0000
    call DrawScreenBufferRectToBGMap_33
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

RunLinkSession6Exchange_Case01_Sub01_ShowForTeamMode1Hero::
    ld a, [wFadeState]
    or a
    ret nz
    ld a, $19 ; 'For Team Mode, 1000G is charged.'
    call BeginString_Bank07_Cat5
    ld hl, wTitleScreenSubState
    inc [hl]
    xor a
    ld [wLinkSendByte], a
    ret

RunLinkSession6Exchange_Case01_Sub01_ShowYourPalRefusedThe::
    ld a, [wLinkMessage]
    cp $fe
    jr nz, .check_text_flags
    ld a, $fe
    ld [wLinkSendByte], a
    ld a, $01
    ld [wTitleScreenState], a
    ld a, $02
    ld [wScreenState], a
    ld a, $0a ; 'Your pal refused the Team Mode.'
    call BeginString_Bank07_Cat5
    ret

.check_text_flags:
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, [wTextYesNoResult]
    and $01
    jr z, .read_gold_lo
    ld a, $fe
    ld [wLinkSendByte], a
    ld a, $01
    ld [wTitleScreenState], a
    ld a, $02
    ld [wScreenState], a
    ld a, $09 ; 'You refused the Team Mode.'
    call BeginString_Bank07_Cat5
    ret

.read_gold_lo:
    ld a, [wGoldLo]
    sub $e8
    ld c, a
    ld a, [wGoldMid]
    sbc $03
    ld b, a
    ld a, [wGoldHi]
    sbc $00
    jr nc, .set_gold_hi
    ld a, $00 ; 'Not enough money. Please wait.'
    call BeginString_Bank07_Cat5
    ld a, [wTitleScreenSubState]
    add $08
    ld [wTitleScreenSubState], a
    ld a, $10
    ld [wLinkSendByte], a
    ret

.set_gold_hi:
    ld [wGoldHi], a
    ld a, b
    ld [wGoldMid], a
    ld a, c
    ld [wGoldLo], a
    ld a, $0c ; 'Please wait.'
    call BeginString_Bank07_Cat5
    ld hl, wTitleScreenSubState
    inc [hl]
    ld a, $01
    ld [wLinkSendByte], a
    ret

RunLinkSession6Exchange_Case01_Sub01_WriteLinkSendByteAndTitleScreenStateEtc::
    ld a, [wLinkMessage]
    cp $fe
    jr z, .set_link_send_byte_to_FE
    cp $01
    jr z, .call_begin_string_bank07_cat5
    cp $10
    jr z, .call_begin_string_bank07_cat52
    ret

.set_link_send_byte_to_FE:
    ld a, $fe
    ld [wLinkSendByte], a
    ld a, $01
    ld [wTitleScreenState], a
    ld a, $02
    ld [wScreenState], a
    ld a, $0a ; 'Your pal refused the Team Mode.'
    call BeginString_Bank07_Cat5
    ret

.call_begin_string_bank07_cat5:
    ld a, $07 ; 'You paid the 1000G battle fee.'
    call BeginString_Bank07_Cat5
    ld hl, wTitleScreenSubState
    inc [hl]
    xor a
    ld [wLinkSendByte], a
    ret

.call_begin_string_bank07_cat52:
    ld a, $01 ; 'Your pal doesn't have enough gold.'
    call BeginString_Bank07_Cat5
    ld hl, wTitleScreenSubState
    inc [hl]
    ld hl, wTitleScreenSubState
    inc [hl]
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

RunLinkSession6Exchange_Case01_Sub01_SetLinkSendByte::
    xor a
    ld [wLinkSendByte], a
    ld hl, wTitleScreenSubState
    inc [hl]
    xor a
    ld [wLinkScreenFlag], a
    ret

; by its step: 'Choose a monster for the Team ...'
RunLinkSession6Exchange_ChooseTeamMonster::
    ld a, [wLinkScreenFlag]
    jumptable
    dw RunLinkSession6Exchange_ChooseTeamMonster_WaitTextFlags
    dw RunLinkSession6Exchange_ChooseTeamMonster_ShowChooseAMonsterFor
    dw RunLinkSession6Exchange_ChooseTeamMonster_SetTitleScreenSubState

RunLinkSession6Exchange_ChooseTeamMonster_WaitTextFlags::
    ld a, [wTextFlags]
    or a
    ret nz
    ld hl, wScreenTileBuffer
    ld bc, $0104

.loop:
    ld a, $c3
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ld hl, wLinkScreenFlag
    inc [hl]
    ret

RunLinkSession6Exchange_ChooseTeamMonster_ShowChooseAMonsterFor::
    call BGMapAddressAtScroll_Bank33
    ld bc, $140d
    ld de, $0000
    call DrawScreenBufferRectToBGMap_33
    ld a, $08 ; 'Choose a monster for the Team'
    call BeginString_Bank07_Cat5
    ld hl, wLinkScreenFlag
    inc [hl]
    ret

RunLinkSession6Exchange_ChooseTeamMonster_SetTitleScreenSubState::
    xor a
    ld [wTitleScreenSubState], a
    xor a
    ld [wLinkScreenFlag], a
    ld a, $01
    ld [wTitleScreenState], a
    xor a
    ld [wScreenState], a
    ret

RunLinkSession6Exchange_Case01_Sub01_ShowYouRefusedToPay::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, [wTextYesNoResult]
    and $01
    jr z, .read_gold_lo
    ld a, $05 ; 'You refused to pay the battle'
    call BeginString_Bank07_Cat5
    ld a, $40
    ld [wLinkSendByte], a
    ld hl, wTitleScreenSubState
    inc [hl]
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

.read_gold_lo:
    ld a, [wGoldLo]
    sub $e8
    ld c, a
    ld a, [wGoldMid]
    sbc $03
    ld b, a
    ld a, [wGoldHi]
    sbc $00
    jr nc, .set_gold_hi
    ld a, $04 ; 'Insufficient gold for Team Mode.'
    call BeginString_Bank07_Cat5
    ld a, $30
    ld [wLinkSendByte], a
    ld hl, wTitleScreenSubState
    inc [hl]
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

.set_gold_hi:
    ld [wGoldHi], a
    ld a, b
    ld [wGoldMid], a
    ld a, c
    ld [wGoldLo], a
    ld a, $02 ; 'You paid for both combatants.'
    call BeginString_Bank07_Cat5
    ld a, $20
    ld [wLinkSendByte], a
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

RunLinkSession6Exchange_Case01_Sub01_WriteLinkSendByteAndTitleScreenStateEtc_Case08::
    ld a, [wLinkMessage]
    cp $fe
    jr z, .set_link_send_byte_to_FE
    cp $20
    ret nz
    ld hl, wTitleScreenSubState
    dec [hl]
    ld hl, wTitleScreenSubState
    dec [hl]
    ret

.set_link_send_byte_to_FE:
    ld a, $fe
    ld [wLinkSendByte], a
    ld a, $01
    ld [wTitleScreenState], a
    ld a, $02
    ld [wScreenState], a
    ld a, $0a ; 'Your pal refused the Team Mode.'
    call BeginString_Bank07_Cat5
    ret

RunLinkSession6Exchange_Case01_Sub01_WriteLinkSendByteAndTitleScreenStateEtc_Case09::
    ld a, [wLinkMessage]
    cp $fe
    jr z, .set_link_send_byte_to_FE
    cp $30
    jr z, .done
    cp $40
    ret nz

.done:
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

.set_link_send_byte_to_FE:
    ld a, $fe
    ld [wLinkSendByte], a
    ld a, $01
    ld [wTitleScreenState], a
    ld a, $02
    ld [wScreenState], a
    ld a, $0a ; 'Your pal refused the Team Mode.'
    call BeginString_Bank07_Cat5
    ret

RunLinkSession6Exchange_Case01_Sub01_SetLinkSendByte_Case0A::
    ld a, $fe
    ld [wLinkSendByte], a
    ld a, $01
    ld [wTitleScreenState], a
    xor a
    ld [wTitleScreenSubState], a
    ld a, $02
    ld [wScreenState], a
    ret

RunLinkSession6Exchange_Case01_Sub01_ShowYourPalRefusedTo::
    ld a, [wLinkMessage]
    cp $fe
    jr z, .set_link_send_byte_to_FE
    cp $10
    jr z, .set_link_send_byte
    cp $20
    jr z, .set_link_send_byte2
    cp $30
    jr z, .set_link_send_byte3
    cp $40
    ret nz
    ld [wLinkSendByte], a
    ld a, $06 ; 'Your pal refused to pay the'
    call BeginString_Bank07_Cat5
    ld hl, wTitleScreenSubState
    inc [hl]
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

.set_link_send_byte:
    ld [wLinkSendByte], a
    ld a, $04 ; 'Insufficient gold for Team Mode.'
    call BeginString_Bank07_Cat5
    ld hl, wTitleScreenSubState
    inc [hl]
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

.set_link_send_byte2:
    ld [wLinkSendByte], a
    ld a, $03 ; 'Your pal paid your battle fee.'
    call BeginString_Bank07_Cat5
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

.set_link_send_byte3:
    ld [wLinkSendByte], a
    ld a, $04 ; 'Insufficient gold for Team Mode.'
    call BeginString_Bank07_Cat5
    ld hl, wTitleScreenSubState
    inc [hl]
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

.set_link_send_byte_to_FE:
    ld a, $fe
    ld [wLinkSendByte], a
    ld a, $01
    ld [wTitleScreenState], a
    ld a, $02
    ld [wScreenState], a
    ld a, $0a ; 'Your pal refused the Team Mode.'
    call BeginString_Bank07_Cat5
    ret

RunLinkSession6Exchange_Case01_Sub01_WriteTitleScreenSubStateAndLinkSendByteEtc::
    ld a, [wLinkMessage]
    cp $fe
    jr z, .set_link_send_byte_to_FE
    or a
    jr z, .set_title_screen_sub_state_to_05
    cp $20
    ret nz

.set_title_screen_sub_state_to_05:
    ld a, $05
    ld [wTitleScreenSubState], a
    ret

.set_link_send_byte_to_FE:
    ld a, $fe
    ld [wLinkSendByte], a
    ld a, $01
    ld [wTitleScreenState], a
    ld a, $02
    ld [wScreenState], a
    ld a, $0a ; 'Your pal refused the Team Mode.'
    call BeginString_Bank07_Cat5
    ret

RunLinkSession6Exchange_Case01_Sub01_WriteLinkSendByteAndTitleScreenStateEtc_Case0D::
    ld a, [wLinkMessage]
    cp $10
    jr z, .set_link_send_byte_to_FE
    cp $30
    jr z, .set_link_send_byte_to_FE
    cp $40
    jr z, .set_link_send_byte_to_FE
    cp $fe
    ret nz

.set_link_send_byte_to_FE:
    ld a, $fe
    ld [wLinkSendByte], a
    ld a, $01
    ld [wTitleScreenState], a
    xor a
    ld [wTitleScreenSubState], a
    ld a, $02
    ld [wScreenState], a
    ret

; A = string index: wStringIndex = A, wStringCategory = 5, then BeginStringDisplay_Bank07
BeginString_Bank07_Cat5::
    ld [wStringIndex], a
    ld a, $05
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank07
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case00::
    ld hl, wScreenState
    inc [hl]
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case01::
    ld a, [wTextFlags]
    and a
    ret nz
    ld hl, wScreenState
    inc [hl]
    inc [hl]
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case02::
    ld a, [wScreenStep]
    jumptable
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case02_Case00
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case02_Case01
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case02_Case02
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case02_Case03
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case02_Case04

RunLinkSession6Exchange_Case01_Sub01_Table2_Case02_Case00::
    ld a, [wLinkMessage]
    cp $fe
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case02_Case01::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, $0c ; 'Please wait.'
    call ShowStringA10_Bank33
    ld hl, wScreenStep
    inc [hl]
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case02_Case02::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wScreenStep
    inc [hl]
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case02_Case03::
    ld a, [wLinkMessage]
    cp $01
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld hl, wScreenStep
    inc [hl]
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case02_Case04::
    ld a, [wTextFlags]
    bit 0, a
    ret nz
    ld hl, wScreenState
    ld bc, $006f

.loop:
    xor a
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ld hl, wGameMode
    ld a, $05
    ld [hli], a
    ld a, $01
    ld [hli], a
    xor a
    ld [hli], a
    ld [hl], a
    ld hl, wModeChangeRequest
    inc [hl]
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case03::
    ld hl, wScreenState
    inc [hl]
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case04::
    ld a, [wScreenStep]
    jumptable
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case04_Case00
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case04_Case00
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case04_Case02
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case04_Case00
    dw CallDrawListEntriesCell5RecordPanel
    dw CallClearAndDrawListEntriesCell5Name
    dw CopyRect62C3ToWC36EAndIncScreenStep
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case04_Case07
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case04_Case08
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case04_Case09
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case04_Case0A
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case04_Case0B
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case04_Case0C
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case04_Case0D
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case04_Case0E
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case04_Case0F

RunLinkSession6Exchange_Case01_Sub01_Table2_Case04_Case00::
    ld a, [wTextFlags]
    and a
    ret nz
    farcall BreedMenu
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case04_Case02::
    farcall DrawRecordListPageIndicators_1B
    ret

; far-calls DrawListEntriesCell5RecordPanel (E-0122)
CallDrawListEntriesCell5RecordPanel::
    farcall DrawListEntriesCell5RecordPanel
    ret

; far-calls ClearAndDrawListEntriesCell5NameAtTiles1780 (E-0122)
CallClearAndDrawListEntriesCell5Name::
    farcall ClearAndDrawListEntriesCell5NameAtTiles1780
    ret

; copies the 10 x 11 rectangle TileRect_33_62C3 into wWindowTileBuffer + $6E
; (CopyRectTo20ByteRowsJp_Bank33), then wScreenStep += 1 (E-0119)
CopyRect62C3ToWC36EAndIncScreenStep::
    ld de, TileRect_33_62C3
    ld hl, wWindowTileBuffer + $6e
    ld bc, $0a0b
    call CopyRectTo20ByteRowsJp_Bank33
    ld hl, wScreenStep
    inc [hl]
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case04_Case07::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wListCursor]
    ld b, $bb
    ld hl, RunLinkSession6Exchange_Case01_Sub01_Table2_Case04_Case07_Data
    call StoreBAtWordTableEntry_Bank33
    ld de, wKeyNameBuf
    ld hl, wWindowTileBuffer + $b1
    call RunFunc6204FourTimes
    call BGMapAddressAtScroll_Bank33
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_33
    ld a, [wListCursor]
    ld b, $c3
    ld hl, RunLinkSession6Exchange_Case01_Sub01_Table2_Case04_Case07_Data
    call StoreBAtWordTableEntry_Bank33
    call SetDefaultStringWindow_Bank33
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case04_Case08::
    ld a, [wLinkMessage]
    cp $fe
    jr nz, .clear_menu_input_result
    ld a, $02
    ld [wScreenState], a
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $0a ; 'Your pal refused the Team Mode.'
    call BeginString_Bank07_Cat5
    ld a, $fe
    ld [wLinkSendByte], a
    ret

.clear_menu_input_result:
    xor a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fb
    jr z, .read_screen_step
    cp $fc
    jr z, .read_screen_step
    cp $fd
    jr z, .read_screen_step2
    cp $fe
    jr z, .set_screen_state_to_02
    cp $ff
    jr z, .call_store_list_entries_cell5_record_in
    ret

.read_screen_step:
    ld a, [wScreenStep]
    sub $07
    ld [wScreenStep], a
    ret

.read_screen_step2:
    ld a, [wScreenStep]
    sub $04
    ld [wScreenStep], a
    ret

.set_screen_state_to_02:
    ld a, $02
    ld [wScreenState], a
    ld a, $09 ; 'You refused the Team Mode.'
    call BeginString_Bank07_Cat5
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $fe
    ld [wLinkSendByte], a
    ret

.call_store_list_entries_cell5_record_in:
    call StoreListEntriesCell5RecordInPickedRecords
    ld a, [wListCursor]
    ld b, $bc
    ld hl, RunLinkSession6Exchange_Case01_Sub01_Table2_Case04_Case07_Data
    call StoreBAtWordTableEntry_Bank33
    call CopyListEntriesCell5NameToTextBuf0_Bank33
    ld hl, wScreenStep
    inc [hl]
    ld a, $02 ; 'Pick 0 for the team?'
    call ShowStringA10_Bank33
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case04_Case09::
    ld a, [wTextFlags]
    and a
    ret nz
    ld hl, vTiles2 + $700
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0c01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a
    ld [wStringCategory], a
    ld a, $1e
    ld [wStringIndex], a ; 'InfoOKYesN'
    farcall ShowString_Bank1B_481A
    ld a, $6c
    call QueueSoundEffect
    ld de, TileRect_33_63C7
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRowsJp_Bank33
    call BGMapAddressAtScroll_Bank33
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_33
    call SetDefaultStringWindow_Bank33
    xor a
    ld [wChoiceCursor], a
    ld hl, wScreenStep
    inc [hl]
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case04_Case0A::
    ld a, [wLinkMessage]
    cp $fe
    jr nz, .clear_arg5
    ld a, $02
    ld [wScreenState], a
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $0a ; 'Your pal refused the Team Mode.'
    call BeginString_Bank07_Cat5
    ld a, $fe
    ld [wLinkSendByte], a
    ret

.clear_arg5:
    xor a
    ld [wArg5], a
    farcall HandleTwoChoiceCursorInput_0D
    ld a, [wArg5]
    and a
    ret z
    cp $fe
    jr z, .done
    cp $ff
    jr z, .check_choice_cursor
    ret

.done:
    ld hl, wScreenStep
    inc [hl]
    ret

.check_choice_cursor:
    ld a, [wChoiceCursor]
    and a
    jr nz, .call_store_list_entries_cell5_record_in
    ld a, [wScreenState]
    ld [wScreenByteB2], a
    ld a, [wScreenStep]
    ld [wScreenByteB3], a
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $0c
    ld [wScreenState], a
    ret

.call_store_list_entries_cell5_record_in:
    call StoreListEntriesCell5RecordInPickedRecords
    ld hl, wScreenStep
    inc [hl]
    inc [hl]
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case04_Case0B::
    ld a, [wTextFlags]
    and a
    ret nz
    ld c, $05
    ld hl, RunLinkSession6Exchange_Case01_Sub01_Table2_Case04_Case07_Data
    call WriteC3AtWordTableEntries_Bank33
    call DrawBox639FAndKeyRows
    call BGMapAddressAtScroll_Bank33
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_33
    ld a, $08 ; 'Choose a monster for the Team'
    call BeginString_Bank07_Cat5
    ld a, [wScreenStep]
    sub $03
    ld [wScreenStep], a
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case04_Case0C::
    call DrawBox639FAndKeyRows
    call BGMapAddressAtScroll_Bank33
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_33
    ld hl, wPickCount
    inc [hl]
    ld a, $0c ; 'Please wait.'
    call ShowStringA10_Bank33
    call FinishPickedRecordsEntryAndStep_33
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case04_Case0D::
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld a, [wPickedRecords]
    ld c, MON_STATE
    call SRAMRecordAddress
    ld de, wRecordBufA
    ld a, e
    ld [wLinkTimeoutLo], a
    ld a, d
    ld [wLinkTimeoutHi], a
    ld b, $a5

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ld de, wRecordBufB
    ld a, e
    ld [wLinkBufferPtrLo], a
    ld a, d
    ld [wLinkBufferPtrHi], a
    xor a
    ld [rRAMG], a
    xor a
    ld [wLinkSceneByte4B], a
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wScreenStep
    inc [hl]
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case04_Case0E::
    ld a, [wLinkMessage]
    cp $01
    jr z, .set_link_buffer_count_lo
    cp $fe
    ret nz
    ld a, $02
    ld [wScreenState], a
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $0a ; 'Your pal refused the Team Mode.'
    call BeginString_Bank07_Cat5
    ld a, $fe
    ld [wLinkSendByte], a
    ret

.set_link_buffer_count_lo:
    ld hl, $00a5
    ld a, l
    ld [wLinkBufferCountLo], a
    ld a, h
    ld [wLinkBufferCountHi], a
    ld a, $ff
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ld hl, wScreenStep
    inc [hl]
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case04_Case0F::
    ld a, [wLinkMessage]
    cp $f0
    ret nz
    ld hl, wScreenState
    inc [hl]
    xor a
    ld [wScreenStep], a
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case05::
    ld a, [wScreenStep]
    jumptable
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case05_Case00
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case05_Case01
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case05_Case02
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case05_Case03
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case05_Case04
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case05_Case05
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case05_Case06
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case05_Case07
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case05_Case08
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case05_Case09
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case05_Case0A
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case05_Case0B
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case05_Case0C
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case05_Case0D
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case05_Case0E
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case05_Case0F
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case05_Case10
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case05_Case11

RunLinkSession6Exchange_Case01_Sub01_Table2_Case05_Case00::
    ld hl, wScreenStep
    inc [hl]
    xor a
    ld [wLinkSendByte], a
    ld hl, wKeyNameBuf
    ld de, wLinkRecvBuffer
    ld b, $04
    call CopyBBytesThenMark1
    ld hl, wPlayerName
    ld b, $0b

; copies B bytes from HL to DE, then stores 1 after them (E-0115)
CopyBBytesThenMark1::
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, CopyBBytesThenMark1
    ld a, $01
    ld [de], a
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case05_Case01::
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wScreenStep
    inc [hl]
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case05_Case02::
    ld a, [wLinkMessage]
    cp $01
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
    ld a, $ff
    ld [wLinkSendByte], a
    ld hl, wScreenStep
    inc [hl]
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case05_Case03::
    ld a, [wLinkMessage]
    cp $f0
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld hl, wScreenStep
    inc [hl]
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case05_Case04::
    ld de, TileRect_33_6331
    ld hl, wWindowTileBuffer + $64
    ld bc, $0a0b
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
    ld bc, $000a
    call CopyBytes
    ld a, $f0
    ld [wNameGlyphBuf + $a], a
    ld de, vTiles2 + $50
    call CopyGlyphTilesToVRAM
    ld a, [wLinkTradeByte]
    ld [wBattleByte63], a
    ld de, wLinkPartnerName
    ld hl, wWindowTileBuffer + $a7
    call RunFunc6204FourTimes
    ld hl, vTiles2 + $300
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0e01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a
    ld [wStringCategory], a
    ld a, $20
    ld [wStringIndex], a ; 'FightInfoEx'
    farcall ShowString_Bank1B_481A
    ld de, TileRect_33_63F9
    ld hl, wWindowTileBuffer + $e7
    ld bc, $0907
    call CopyRectTo20ByteRowsJp_Bank33
    ld hl, vTiles1 + $4e0
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

RunLinkSession6Exchange_Case01_Sub01_Table2_Case05_Case05::
    call BGMapAddressAtScroll_Bank33
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_33
    ld a, $0d ; 'Battle in Team Mode?'
    call BeginString_Bank07_Cat5
    xor a
    ld [wTwoChoiceCursor], a
    ld hl, wScreenStep
    inc [hl]
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case05_Case06::
    ld a, [wLinkMessage]
    cp $fe
    jr nz, .call_handle_three_choice_cursor_input_f1
    ld a, $02
    ld [wScreenState], a
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $0a ; 'Your pal refused the Team Mode.'
    call BeginString_Bank07_Cat5
    ld a, $fe
    ld [wLinkSendByte], a
    ret

.call_handle_three_choice_cursor_input_f1:
    farcall HandleThreeChoiceCursorInput_F1
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fe
    jr z, .set_screen_state_to_02
    cp $ff
    jr z, .check_two_choice_cursor
    ret

.set_screen_state_to_02:
    ld a, $02
    ld [wScreenState], a
    ld a, $09 ; 'You refused the Team Mode.'
    call BeginString_Bank07_Cat5
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $fe
    ld [wLinkSendByte], a
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    and a
    jr z, .done
    cp $01
    jr z, .read_screen_state
    jr .set_screen_state_to_02

.done:
    ld hl, wScreenStep
    inc [hl]
    ret

.read_screen_state:
    ld a, [wScreenState]
    ld [wScreenByteB2], a
    ld a, [wScreenStep]
    ld [wScreenByteB3], a
    ld a, $0d
    ld [wScreenState], a
    ld a, [wListCursor]
    ld [wItemGridX], a
    ld a, [wListPageIndex]
    ld [wItemGridY], a
    xor a
    ld [wListCursor], a
    ld [wListPageIndex], a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case05_Case07::
    ld de, wScreenTileBuffer
    ld hl, wWindowTileBuffer + $64
    ld bc, $0104
    call CopyBytes
    ld a, $0e ; 'The battle results will be recorded.'
    call BeginString_Bank07_Cat5
    xor a
    ld [wLinkSendByte], a
    ld hl, wScreenStep
    inc [hl]
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case05_Case08::
    ld a, [wLinkMessage]
    cp $fe
    jr nz, .check_text_flags
    ld a, $02
    ld [wScreenState], a
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $0a ; 'Your pal refused the Team Mode.'
    call BeginString_Bank07_Cat5
    ld a, $fe
    ld [wLinkSendByte], a
    ret

.check_text_flags:
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, [wTextYesNoResult]
    and $01
    jr z, .done
    ld a, $0d ; 'Battle in Team Mode?'
    call BeginString_Bank07_Cat5
    ld hl, wScreenStep
    dec [hl]
    ld hl, wScreenStep
    dec [hl]
    ret

.done:
    ld hl, wScreenStep
    inc [hl]
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case05_Case09::
    ld hl, wScreenStep
    inc [hl]
    ld a, $0c ; 'Please wait.'
    call BeginString_Bank07_Cat5
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case05_Case0A::
    ld a, [wTextFlags]
    and a
    ret nz
    ld hl, wScreenStep
    inc [hl]
    ld a, $01
    ld [wLinkSendByte], a
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case05_Case0B::
    ld a, [wLinkMessage]
    cp $fe
    jr z, .set_screen_state_to_02
    cp $01
    jr z, .clear_link_send_byte
    ret

.set_screen_state_to_02:
    ld a, $02
    ld [wScreenState], a
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $0a ; 'Your pal refused the Team Mode.'
    call BeginString_Bank07_Cat5
    ld a, $fe
    ld [wLinkSendByte], a
    ret

.clear_link_send_byte:
    xor a
    ld [wLinkSendByte], a
    ld hl, wScreenStep
    inc [hl]
    ld a, $1a ; 'Saving Please wait.'
    call BeginString_Bank07_Cat5
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case05_Case0C::
    ld a, [wTextFlags]
    and a
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

RunLinkSession6Exchange_Case01_Sub01_Table2_Case05_Case0D::
    ld a, [wLinkMessage]
    cp $05
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld hl, wRandomSeed2Hi
    ld de, wLinkSeedCopy
    ld bc, $000b
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

RunLinkSession6Exchange_Case01_Sub01_Table2_Case05_Case0E::
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
    xor a
    ld [wLinkBufferCountHi], a
    ld a, $ff
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case05_Case0F::
    ld a, [wLinkMessage]
    cp $f0
    ret nz
    xor a
    ld [wLinkSendByte], a
    xor a
    ld [wLinkReady], a
    ld a, [wLinkRole]
    bit 1, a
    jr nz, .read_random_seed2_lo
    ld a, [wRandomLo]
    ld [wRandomSeed2Lo], a
    ld a, [wRandomHi]
    ld [wRandomSeed2Hi], a
    jr .check_screen_step

.read_random_seed2_lo:
    ld a, [wRandomSeed2Lo]
    ld [wRandomLo], a
    ld a, [wRandomSeed2Hi]
    ld [wRandomHi], a

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case05_Case10::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $d2
    ld [wLinkSendByte], a
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case05_Case11::
    ld a, [wLinkMessage]
    cp $d2
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld a, $07
    ld [wGameMode], a
    xor a
    ld [wModeState], a
    ld [wGameMode2State], a
    ld [wGameMode2Arg], a
    ld a, $01
    ld [wModeChangeRequest], a
    ld a, $07
    ld [wLinkSession], a
    ld a, $00
    ld [wLinkExchangeState], a
    xor a
    ld [wLinkSendByte], a
    xor a
    ld [wLinkMessage], a
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case06::
    farcall SwapMonstersMenu
    ld a, [wScreenStep]
    cp $0a
    ret nz
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, [wScreenState]
    add $03
    ld [wScreenState], a
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case0D::
    farcall RunScreenStateWhenNotFading_F1
    ld a, [wScreenState]
    cp $0e
    ret nz
    ld a, [wItemGridX]
    ld [wListCursor], a
    ld a, [wItemGridY]
    ld [wListPageIndex], a
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case0E::
    ld a, [wScreenStep]
    jumptable
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case0E_Case00
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case0E_Case01
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case0E_Case01
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case0E_Case03
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case0E_Case04
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case0E_Case05
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case0E_Case06
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case0E_Case07

RunLinkSession6Exchange_Case01_Sub01_Table2_Case0E_Case00::
    farcall ClearRecordPanelTiles
    ld de, TileRect_33_6331
    ld hl, wWindowTileBuffer + $64
    ld bc, $0a0b
    call CopyRectTo20ByteRowsJp_Bank33
    call DrawPlayerNameAndString0Category1
    ld hl, vTiles1 + $4e0
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

RunLinkSession6Exchange_Case01_Sub01_Table2_Case0E_Case01::
    ld hl, wScreenStep
    inc [hl]
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case0E_Case03::
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld b, a
    push af
    ld a, $c7
    ld [wArg1], a
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, b
    ld c, MON_FAMILY
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and $0f
    ld [wWorkBuf], a
    ld a, [wArg1]
    ld [wWorkBuf + $1], a
    farcall LoadFamilyIconTileForWorkBuf
    xor a
    ld [rRAMG2], a
    ld de, TileRect_33_5D5F
    ld hl, wWindowTileBuffer + $140
    ld bc, $0d02
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
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, b
    ld c, MON_LEVEL
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    farcall BlankLeadingZeroDigits_F
    ld a, [wDigits + $1]
    add $e0
    pop hl
    push hl
    ld [hli], a
    ld a, [wDigits + $2]
    add $e0
    ld [hli], a
    pop hl
    pop bc
    ld a, l
    add $07
    ld l, a
    ld a, h
    adc $00
    ld h, a
    push hl
    ld a, b
    ld c, MON_SEX
    ld b, $01
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and $01
    add $cc
    pop hl
    ld [hl], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 13 x 2 tiles, one row per line
TileRect_33_5D5F::
    db $b6, $ea, $ed, $c3, $c3, $f8, $f9, $fa, $fb, $fc, $c3, $c7, $b7 ; id 0
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 1

RunLinkSession6Exchange_Case01_Sub01_Table2_Case0E_Case04::
    farcall ClearAndDrawListEntriesCell5NameAtTiles1780
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case0E_Case05::
    ld de, TileRect_33_62C3
    ld hl, wWindowTileBuffer + $6e
    ld bc, $0a0b
    call CopyRectTo20ByteRowsJp_Bank33
    ld de, wKeyNameBuf
    ld hl, wWindowTileBuffer + $b1
    call RunFunc6204FourTimes
    ld de, TileRect_33_6331
    ld hl, wWindowTileBuffer + $64
    ld bc, $0a0b
    call CopyRectTo20ByteRowsJp_Bank33
    ld de, wLinkPartnerName
    ld hl, wWindowTileBuffer + $a7
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
    ld bc, $000a
    call CopyBytes
    ld a, $f0
    ld [wNameGlyphBuf + $a], a
    ld de, vTiles2 + $50
    call CopyGlyphTilesToVRAM
    ld hl, wScreenStep
    inc [hl]
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case0E_Case06::
    ld hl, vTiles2 + $300
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0e01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a
    ld [wStringCategory], a
    ld a, $20
    ld [wStringIndex], a ; 'FightInfoEx'
    farcall ShowString_Bank1B_481A
    ld de, TileRect_33_63F9
    ld hl, wWindowTileBuffer + $e7
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

RunLinkSession6Exchange_Case01_Sub01_Table2_Case0E_Case07::
    call BGMapAddressAtScroll_Bank33
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_33
    call BGMapAddressAtScroll_Bank33
    ld de, $01a0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call DrawScreenBufferRectToBGMap_33
    ld a, $70
    ldh [hSpriteHideTile], a
    xor a
    ld [wScreenSubStep], a
    ld a, [wScreenByteB2]
    ld [wScreenState], a
    ld a, [wScreenByteB3]
    ld [wScreenStep], a
    call SetDefaultStringWindow_Bank33
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case0F::
    ld a, [wScreenStep]
    jumptable
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case0F_Case00
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case0F_Case01
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case0F_Case02
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case0F_Case03
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case0F_Case04
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case0F_Case05
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case0F_Case06
    dw RunLinkSession6Exchange_Case01_Sub01_Table2_Case0F_Case07

RunLinkSession6Exchange_Case01_Sub01_Table2_Case0F_Case00::
    farcall ClearRecordPanelTiles
    ld de, TileRect_33_6438
    ld hl, wWindowTileBuffer + $64
    ld bc, $080b
    call CopyRectTo20ByteRowsJp_Bank33
    ld a, [wListCursor]
    ld b, $bc
    ld hl, RunLinkSession6Exchange_Case01_Sub01_Table2_Case04_Case07_Data
    call StoreBAtWordTableEntry_Bank33
    call DrawPlayerNameAndString0Category1
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case0F_Case03::
    call CallDrawListEntriesCell5RecordPanel
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case0F_Case01::
    call ListAvailableRecordsForSelection_Bank33
    farcall ClampRecordListPageCursor5
    ld a, [wListPages]
    cp $02
    jr c, .check_screen_step
    ld hl, wWindowTileBuffer + $12e
    call StoreC5BEC6AtHLStride2_Bank33
    ld hl, wWindowTileBuffer + $12f
    ld a, h
    ld [wArg1], a
    ld a, l
    ld [wArg2], a
    farcall DrawPageOfPagesAtArg1_Bank1E

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case0F_Case02::
    farcall DrawRecordListPageNames
    xor a
    ld [wArg1], a
    farcall MarkPartyMembersInRecordListPage
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case0F_Case04::
    call CallClearAndDrawListEntriesCell5Name
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case0F_Case05::
    call CopyRect62C3ToWC36EAndIncScreenStep
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case0F_Case06::
    ld hl, vTiles2 + $700
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0c01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a
    ld [wStringCategory], a
    ld a, $1e
    ld [wStringIndex], a ; 'InfoOKYesN'
    farcall ShowString_Bank1B_481A
    call CopyListEntriesCell5NameToTextBuf0_Bank33
    call SetDefaultStringWindow_Bank33
    xor a
    ld a, $12
    ld [wStringIndex], a
    farcall ShowString_Bank1B_481A
    ld de, wKeyNameBuf
    ld hl, wWindowTileBuffer + $b1
    call RunFunc6204FourTimes
    ld de, TileRect_33_63C7
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRowsJp_Bank33
    xor a
    ld [wChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

RunLinkSession6Exchange_Case01_Sub01_Table2_Case0F_Case07::
    call BGMapAddressAtScroll_Bank33
    ld bc, $140d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_33
    call BGMapAddressAtScroll_Bank33
    ld de, $01a0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call DrawScreenBufferRectToBGMap_33
    ld a, $70
    ldh [hSpriteHideTile], a
    xor a
    ld [wScreenSubStep], a
    ld a, [wScreenByteB2]
    ld [wScreenState], a
    ld a, [wScreenByteB3]
    ld [wScreenStep], a
    call SetDefaultStringWindow_Bank33
    ret

; with SRAM bank 0 enabled, LoadSRAMRecordByte with A = wPickedRecords (C = field from the caller);
; then disables SRAM (E-0119)
LoadRecordByteForPickedRecords::
    ld hl, wPickedRecords
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, [hl]
    call LoadSRAMRecordByte
    xor a
    ld [rRAMG2], a
    ld [rRAMB], a
    ret

; copies box TileRect_33_639F to wWindowTileBuffer + $110 and runs RunFunc6204FourTimes for
; wKeyNameBuf at wWindowTileBuffer + $B1 (E-0126)
DrawBox639FAndKeyRows::
    ld de, TileRect_33_639F
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRowsJp_Bank33
    ld de, wKeyNameBuf
    ld hl, wWindowTileBuffer + $b1
    call RunFunc6204FourTimes
    ret

; lists in wListEntries the stored records (state 1, or 2 unless wPickCount is 3) whose field $6E is
; clear and that are not already chosen in wPickedRecords; count in wListCount (E-0130)
ListAvailableRecordsForSelection_Bank33::
    ld hl, wListEntries
    ld b, $1e

.loop:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop
    ld hl, wListEntries2
    ld b, $1e

.loop2:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop2
    xor a
    ld [wListCount], a
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld [wRecordsFlagged], a
    ld de, sRecords
    ld hl, wListEntries
    ld b, $00
    ld c, $00

.loop3:
    ld a, [de]
    and a
    jr z, .skip3
    cp $01
    jr z, .skip
    ld a, [wPickCount]
    cp $03
    jr z, .skip3
    ld a, [de]
    cp $02
    jr z, .skip
    jr .skip3

.skip:
    push de
    ld a, $6e
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    and a
    jr nz, .check_records_flagged
    pop de
    ld a, [wPickCount]
    and a
    jr z, .next
    cp $03
    jr nc, .next
    push hl
    push de
    push bc
    ld d, b
    ld hl, wPickedRecords
    ld a, [wPickCount]
    ld b, a

.loop4:
    ld a, [hli]
    cp d
    jr z, .restore
    dec b
    jr nz, .loop4
    pop bc
    pop de
    pop hl
    jr .next

.restore:
    pop bc
    pop de
    pop hl
    jr .skip3

.next:
    inc c
    ld a, b
    ld [hli], a
    jr .skip3

.check_records_flagged:
    pop de
    ld a, [wRecordsFlagged]
    inc a
    ld [wRecordsFlagged], a

.skip3:
    ld a, $a5
    add e
    ld e, a
    jr nc, .next2
    inc d

.next2:
    inc b
    ld a, b
    cp $1e
    jr c, .loop3
    ld a, c
    ld [wListCount], a
    xor a
    ld [rRAMG2], a
    farcall MovePartyRecordsToFrontOfList
    ret

; the same 16 bytes as ShowStringA10_Bank1B (ShowStringA10_Bank1B)
ShowStringA10_Bank33::
    add $10
    ld [wStringIndex], a
    xor a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank1B_480C
    ret

; sets the string window: wTextWindowTileLo/wTextWindowTileHi = vTiles1 ($8800),
; wTextWindowRows/wTextWindowWidth = $02, $12 (E-0067) (the same 23 bytes appear in 2 banks)
SetDefaultStringWindow_Bank33::
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

; wPickedRecords = the record index at WD789 cell 5 (E-0126)
StoreListEntriesCell5RecordInPickedRecords::
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld de, wPickedRecords
    ld a, [hl]
    ld [de], a
    ret

; copies the name of the record at WD789 cell 5 (11 bytes) to wTextBuf0 (E-0124)
CopyListEntriesCell5NameToTextBuf0_Bank33::
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld c, MON_NAME
    call CopyRecordNameToNameGlyphBuf
    ld hl, wNameGlyphBuf
    ld de, wTextBuf0
    ld b, $0b

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    xor a
    ld [rRAMB], a
    ld [rRAMG], a
    ret

; wSelectedRecord = wPickCount, wPackWork = $FF, wPickCount = 4, wScreenSubStep = 0 and wScreenStep
; += 1 (E-0126)
FinishPickedRecordsEntryAndStep_33::
    ld a, [wPickCount]
    ld [wSelectedRecord], a
    ld a, $ff
    ld [wPackWork], a
    ld a, $04
    ld [wPickCount], a
    xor a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; HL = table of 16-bit addresses, A = index: stores B at the address in entry A; keeps BC; clobbers
; A, DE, HL (the same 16 bytes appear in 4 banks)
StoreBAtWordTableEntry_Bank33::
    push bc
    sla a
    add_a_to_hl
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    pop bc
    ld a, b
    ld [de], a
    ret

; HL = $9800 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY);
; clobbers A, DE (the same 41 bytes appear in 3 banks)
BGMapAddressAtScroll_Bank33::
    ldh a, [hScrollY]
    and $f8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add $00
    ld e, a
    ld a, d
    adc $98
    ld d, a
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, e
    ld l, a
    ld a, d
    ld h, a
    ret

; copies a rectangle of the screen buffer (offset DE) to the BG map at HL, sets wTextCursorLo = HL +
; $1C1, and on CGB copies its attributes (E-0127)
DrawScreenBufferRectToBGMap_33::
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
    xor a
    call CopyRectFromBankToBGMapWrapped
    pop hl
    push hl
    ld a, l
    add $c1
    ld l, a
    ld a, h
    adc $01
    ld h, a
    ld a, l
    ld [wTextCursorLo], a
    ld a, h
    ld [wTextCursorHi], a
    pop hl
    pop bc
    pop de
    ld a, [wIsCGB]
    or a
    ret z
    push de
    call WaitForVRAMAccess
    push bc
    ld c, $4f
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
    xor a
    call CopyRectFromBankToBGMapWrapped
    call WaitForVRAMAccess
    ld a, $00
    ldh [rSVBK], a
    ld c, $4f
    ld a, $00
    ldh [c], a
    ret

; the same instructions as CopyRectTo20ByteRowsJp_Bank24: copies a B x C rectangle from DE to HL
; with rows 20 bytes apart; on CGB zero-fills the same rectangle at HL + $0E68 with rSVBK = 2
; (E-0072)
CopyRectTo20ByteRowsJp_Bank33::
    push hl
    push bc

.loop:
    push hl
    push bc

.loop2:
    ld a, [de]
    inc de
    ld [hli], a
    dec b
    jr nz, .loop2
    pop bc
    pop hl
    ld a, l
    add $14
    ld l, a
    ld a, h
    adc $00
    ld h, a
    dec c
    jp nz, .loop
    pop bc
    pop hl
    ld a, [wIsCGB]
    or a
    ret z
    ld a, l
    add $68
    ld l, a
    ld a, h
    adc $0e
    ld h, a
    ld a, $02
    ldh [rSVBK], a

.loop3:
    push hl
    push bc

.loop4:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop4
    pop bc
    pop hl
    ld a, l
    add $14
    ld l, a
    ld a, h
    adc $00
    ld h, a
    dec c
    jp nz, .loop3
    ld a, $00
    ldh [rSVBK], a
    ret

; writes the gold as up to five decimal digit tiles without leading zeros at wScreenTileBuffer + $22
; (E-0127)
WriteGoldDigitsToWC1BA::
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
    and $0f
    jr z, .read_temp1
    add $e0
    ld [hl], a
    set 0, c

.read_temp1:
    inc hl
    ldh a, [hTemp1]
    swap a
    and $0f
    jr nz, .skip
    bit 0, c
    jr z, .check_temp1

.skip:
    add $e0
    ld [hl], a
    set 0, c

.check_temp1:
    inc hl
    ldh a, [hTemp1]
    and $0f
    jr nz, .skip2
    bit 0, c
    jr z, .read_temp0

.skip2:
    add $e0
    ld [hl], a
    set 0, c

.read_temp0:
    inc hl
    ldh a, [hTemp0]
    swap a
    and $0f
    jr nz, .skip3
    bit 0, c
    jr z, .check_temp0

.skip3:
    add $e0
    ld [hl], a

.check_temp0:
    inc hl
    ldh a, [hTemp0]
    and $0f
    add $e0
    ld [hl], a
    ret

; calls RunFunc6204FourTimes_HLToDecimalDigits three times and falls into it once more (E-0122)
RunFunc6204FourTimes::
    call RunFunc6204FourTimes_HLToDecimalDigits
    call RunFunc6204FourTimes_HLToDecimalDigits
    call RunFunc6204FourTimes_HLToDecimalDigits

RunFunc6204FourTimes_HLToDecimalDigits::
    push hl
    ld a, [de]
    inc de
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    pop hl
    ld a, [wDigits + $1]
    or a
    jr z, .read_digits
    add $e0
    ld [hl], a

.read_digits:
    inc hl
    ld a, [wDigits + $2]
    add $e0
    ld [hl], a
    ld a, l
    add $27
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ret

; writes $C3 at the addresses held by entries 0 to C - 1 of the word table at HL (E-0124)
WriteC3AtWordTableEntries_Bank33::
    ld a, c
    ld b, a
    ld c, $00

.loop:
    ld a, c
    push bc
    ld b, $c3
    push hl
    push bc
    sla a
    add_a_to_hl
    ld a, [hli]
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
    cp b
    jr c, .loop
    ret

; clears vTiles2 (size $0105), draws the 10-byte player name wPlayerName there, then shows string 0
; of category 1 (ShowString_Bank07) at vTiles2 + $100 with size $0110 (E-0121)
DrawPlayerNameAndString0Category1::
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
    ld bc, $000a
    call CopyBytes
    ld a, $f0
    ld [wNameGlyphBuf + $a], a
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
    xor a
    ld [wStringIndex], a
    farcall ShowString_Bank07
    ret

; [HL] = $C5, [HL+2] = $BE, [HL+4] = $C6; HL ends at HL+4; clobbers A (the same 14 bytes appear in 8
; banks)
StoreC5BEC6AtHLStride2_Bank33::
    ld a, $c5
    ld [hl], a
    inc hl
    inc hl
    ld a, $be
    ld [hl], a
    inc hl
    inc hl
    ld a, $c6
    ld [hl], a
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 8 x 3 tiles, one row per line
TileRect_33_62AB::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $bf, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 2

; record: 10 x 11 tiles, one row per line
TileRect_33_62C3::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $00, $01, $02, $03, $04, $c3, $c3, $c3, $b7 ; id 1
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; id 2
    db $b6, $10, $11, $12, $c3, $16, $ed, $c3, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $13, $14, $15, $c3, $16, $ed, $c3, $c3, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $10, $11, $12, $c3, $17, $ed, $c3, $c3, $b7 ; id 7
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 8
    db $b6, $13, $14, $15, $c3, $17, $ed, $c3, $c3, $b7 ; id 9
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 10

TileRect_33_6331::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $05, $06, $07, $08, $09, $c3, $c3, $c3, $b7 ; id 1
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; id 2
    db $b6, $10, $11, $12, $c3, $16, $ed, $c3, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $13, $14, $15, $c3, $16, $ed, $c3, $c3, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $10, $11, $12, $c3, $17, $ed, $c3, $c3, $b7 ; id 7
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 8
    db $b6, $13, $14, $15, $c3, $17, $ed, $c3, $c3, $b7 ; id 9
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 10

; record: 8 x 5 tiles, one row per line
TileRect_33_639F::
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 0
    db $14, $15, $c3, $17, $ed, $c3, $c3, $b7 ; id 1
    db $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 2
    db $b7, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 3
    db $b5, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 4

TileRect_33_63C7::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $70, $71, $72, $73, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $74, $75, $c3, $c3, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

RunLinkSession6Exchange_Case01_Sub01_Table2_Case04_Case07_Data::
    db $79, $c3, $a1, $c3, $c9, $c3, $f1, $c3, $19, $c4

; record: 9 x 7 tiles, one row per line
TileRect_33_63F9::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $30, $31, $32, $33, $34, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $35, $36, $37, $38, $c3, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $39, $3a, $31, $34, $c3, $c3, $b7 ; id 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 6

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 8 x 11 tiles, one row per line
TileRect_33_6438::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $d0, $d1, $d2, $d3, $d4, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $d5, $d6, $d7, $d8, $d9, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $da, $db, $dc, $dd, $de, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $f0, $f1, $f2, $f3, $f4, $b7 ; id 7
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 8
    db $b6, $c3, $a4, $a5, $a6, $ce, $cf, $b7 ; id 9
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 10

; ld de, this bank's string table / BeginStringDisplay
BeginStringDisplay_Bank33_6490::
    ld de, StringCategories_33_64A5
    call BeginStringDisplay
    ret
    db $11, $a5, $64, $cd, $fe, $25, $c9

; BeginStringDisplay_Bank33_6490 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
ShowString_Bank33_649E::
    call BeginStringDisplay_Bank33_6490
    call RunStringDisplayToEnd
    ret

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_33_64A5::
    dw StringList_33_64A7 ; id 0

; category list of StringCategories_33_64A5; one pointer per wStringIndex (E-0217)
; record: string
StringList_33_64A7::
    dw String_33_64A5_00_00 ; id 0
    dw String_33_64A5_00_00 ; id 1
    dw String_33_64A5_00_02 ; id 2
    dw String_33_64A5_00_03 ; id 3
    dw String_33_64A5_00_04 ; id 4
    dw String_33_64A5_00_05 ; id 5
    dw String_33_64A5_00_06 ; id 6
    dw String_33_64A5_00_07 ; id 7
    dw String_33_64A5_00_07 ; id 8
    dw String_33_64A5_00_07 ; id 9
    dw String_33_64A5_00_0A ; id 10
    dw String_33_64A5_00_0B ; id 11
    dw String_33_64A5_00_0C ; id 12
    dw String_33_64A5_00_0D ; id 13
    dw String_33_64A5_00_0E ; id 14
    dw String_33_64A5_00_0F ; id 15
    dw String_33_64A5_00_10 ; id 16
    dw String_33_64A5_00_11 ; id 17
    dw String_33_64A5_00_12 ; id 18
    dw String_33_64A5_00_13 ; id 19
    dw String_33_64A5_00_14 ; id 20
    dw String_33_64A5_00_15 ; id 21
    dw String_33_64A5_00_15 ; id 22
    dw String_33_64A5_00_17 ; id 23
    dw String_33_64A5_00_18 ; id 24
    dw String_33_64A5_00_19 ; id 25
    dw String_33_64A5_00_1A ; id 26
    dw String_33_64A5_00_1B ; id 27
    dw String_33_64A5_00_1B ; id 28
    dw String_33_64A5_00_1B ; id 29
    dw String_33_64A5_00_1B ; id 30
    dw String_33_64A5_00_1B ; id 31
    dw String_33_64A5_00_1B ; id 32
    dw String_33_64A5_00_21 ; id 33
    dw String_33_64A5_00_22 ; id 34
    dw String_33_64A5_00_23 ; id 35
    dw String_33_64A5_00_24 ; id 36
    dw String_33_64A5_00_25 ; id 37
    dw String_33_64A5_00_26 ; id 38
    dw String_33_64A5_00_27 ; id 39
    dw String_33_64A5_00_28 ; id 40
    dw String_33_64A5_00_28 ; id 41
    dw String_33_64A5_00_2A ; id 42
    dw String_33_64A5_00_2B ; id 43
    dw String_33_64A5_00_2C ; id 44
    dw String_33_64A5_00_2D ; id 45
    dw String_33_64A5_00_2E ; id 46
    dw String_33_64A5_00_2F ; id 47
    dw String_33_64A5_00_30 ; id 48
    dw String_33_64A5_00_31 ; id 49
    dw String_33_64A5_00_32 ; id 50
    dw String_33_64A5_00_33 ; id 51
    dw String_33_64A5_00_34 ; id 52
    dw String_33_64A5_00_35 ; id 53
    dw BeginStringDisplay_Bank33_7037 ; id 54

String_33_64A5_00_00::
    db $eb, "*: You've finished", $f1
    db "that Class.", $f7
    db $f0

String_33_64A5_00_02::
    db $eb, "*: Which Class will", $f1
    db "you challenge?", $f0

String_33_64A5_00_03::
    db $eb, "*: Train some more,", $f1
    db "and see you again!", $f7
    db $f0

String_33_64A5_00_04::
    db $eb, "*: Let me confirm", $f1
    db "that-the ", $f9, "0 Class?", $f0

String_33_64A5_00_05::
    db $eb, "*: Good luck! I'll", $f1
    db "cheer for you!", $f7
    db $f0

String_33_64A5_00_06::
    db $eb, "*: Not enough gold", $f1
    db "for that Class!", $f7
    db $f0

String_33_64A5_00_07::
    db $eb, "*: Oh", $a4, " The crowd", $f1
    db "wanted to see you", $a4, $f7
    db $f0

String_33_64A5_00_0A::
    db $eb, "*: How many masters", $f1
    db "in the group?", $f0

String_33_64A5_00_0B::
    db $eb, "*: Will you try a", $f1
    db "Master Battle?", $f0

String_33_64A5_00_0C::
    db $eb, "*: The S Class", $f1
    db "should be good.", $fa, $f7
    db $ef, $ee, "Which Class will", $ef, $ee, "you challenge?", $f0

String_33_64A5_00_0D::
    db $eb, "*: The A Class", $f1
    db "should be good.", $fa, $f7
    db $ef, $ee, "Which Class will", $ef, $ee, "you challenge?", $f0

String_33_64A5_00_0E::
    db $eb, "*: The B Class", $f1
    db "should be good.", $fa, $f7
    db $ef, $ee, "Which Class will", $ef, $ee, "you challenge?", $f0

String_33_64A5_00_0F::
    db $eb, "*: It could get", $f1
    db "rough out there.", $fa, $f7
    db $ef, $ee, "Which Class will", $ef, $ee, "you challenge?", $f0

String_33_64A5_00_10::
    db $eb, "*: It could get", $f1
    db "rough out there.", $fa, $f7
    db $ef, $ee, "Which Class will", $ef, $ee, "you challenge?", $f0

String_33_64A5_00_11::
    db $eb, "*: The E Class", $f1
    db "should do.", $fa, $f7
    db $ef, $ee, "Which Class will", $ef, $ee, "you challenge?", $f0

String_33_64A5_00_12::
    db $eb, "*: Is ", $f9, "0 Class OK?", $f0

String_33_64A5_00_13::
    db $eb, "*: I hope you do", $f1
    db "well!", $f7
    db $f0

String_33_64A5_00_14::
    db $eb, "*: You need more", $f1
    db "gold to register.", $f7
    db $f0

String_33_64A5_00_15::
    db $eb, "*: You can't try", $f1
    db "that Class yet.", $f7
    db $f0

String_33_64A5_00_17::
    db "lasSABCDE", $ac, "No", $f0

String_33_64A5_00_18::
    db "Battles Cost", $f0

String_33_64A5_00_19::
    db "INFOTESKLPA", $f0

String_33_64A5_00_1A::
    db "lasSABCDE", $ac, "No", $f0

String_33_64A5_00_1B::
    db $eb, "*: Congratulations!", $f1
    db "You did it!", $fa, $f7
    db $ef, $ee, "You've won the", $ef, $ee, "Kids' Class!", $fa, $f7
    db $ef, $ee, "The King will give", $ef, $ee, "you his official", $fa, $f7
    db $ef, $ee, "recognition as a", $ef, $ee, "monster master.", $fa, $f7
    db $ef, $ee, "You can use the", $ef, $ee, "Starry Shrine and", $fa, $f7
    db $ef, $ee, "the Egg Evaluator's", $ef, $ee, "services now.", $fa, $f7
    db $ef, $ee, "You'll be facing", $ef, $ee, "grownups here from", $fa, $f7
    db $ef, $ee, "now on, so keep", $ef, $ee, "training hard.", $fa, $f7
    db $ef, $ee, "Here's your prize", $ef, $ee, "-the Pirate Key!", $f7
    db $f0

String_33_64A5_00_21::
    db $eb, "*: Congratulations!", $f1
    db "You did it!", $fa, $f7
    db $ef, $ee, "You've won the", $ef, $ee, "C Class!", $fa, $f7
    db $ef, $ee, "Here's your prize", $ef, $ee, "-a  Magic Key!", $f7
    db $f0

String_33_64A5_00_22::
    db $eb, "*: Congratulations!", $f1
    db "You did it!", $fa, $f7
    db $ef, $ee, "You've won the", $ef, $ee, "B Class!", $fa, $f7
    db $ef, $ee, "Here's your prize", $ef, $ee, "-a  Magic Key!", $f7
    db $f0

String_33_64A5_00_23::
    db $eb, "*: Congratulations!", $f1
    db "You did it!", $fa, $f7
    db $ef, $ee, "You've won the", $ef, $ee, "A Class!", $fa, $f7
    db $ef, $ee, "Here's your prize", $ef, $ee, "-a  Magic Key!", $f7
    db $f0

String_33_64A5_00_24::
    db $eb, "*: Congratulations!", $f1
    db "You did it!", $fa, $f7
    db $ef, $ee, "You've finally won", $ef, $ee, "the S Class!", $fa, $f7
    db $ef, $ee, "You can now choose", $ef, $ee, "any Class you want", $fa, $f7
    db $ef, $ee, "by paying the", $ef, $ee, "class entry fee.", $fa, $f7
    db $ef, $ee, "There are prizes", $ef, $ee, "for winners too.", $fa, $f7
    db $ef, $ee, "Naturally, the", $ef, $ee, "level of battling", $fa, $f7
    db $ef, $ee, "becomes much more", $ef, $ee, "difficult.", $fa, $f7
    db $ef, $ee, "Plan and prepare", $ef, $ee, "wisely!", $f7
    db $f0

String_33_64A5_00_25::
    db $eb, "*: Too bad you", $f1
    db "didn't make it.", $fa, $f7
    db $ef, $ee, "It's hard to win", $ef, $ee, "if your monsters", $fa, $f7
    db $ef, $ee, "aren't leveled up", $ef, $ee, "enough.", $fa, $f7
    db $ef, $ee, "I hope you do", $ef, $ee, "better next time.", $f7
    db $f0

String_33_64A5_00_26::
    db $eb, "*: Too bad you", $f1
    db "didn't make it.", $fa, $f7
    db $ef, $ee, "You can create", $ef, $ee, "tougher monsters", $fa, $f7
    db $ef, $ee, "by leveling up", $ef, $ee, "those you bred.", $fa, $f7
    db $ef, $ee, "I hope you do", $ef, $ee, "better next time.", $f7
    db $f0

String_33_64A5_00_27::
    db $eb, "*: Congratulations!", $f1
    db $f9, "0 does it!", $fa, $f7
    db $ef, $ee, "You've won", $ef, $ee, $f9, "GG!", $fa, $f7
    db $ef, $ee, "We hope you'll", $ef, $ee, "battle here again!", $f7
    db $f0

String_33_64A5_00_28::
    db $eb, "*: You lost?", $f1
    db "That's too bad.", $fa, $f7
    db $ef, $ee, "Try again after", $ef, $ee, "leveling up your", $fa, $f7
    db $ef, $ee, "monsters some", $ef, $ee, "more.", $f7
    db $f0

String_33_64A5_00_2A::
    db $f9, "0 received", $f1
    db "the Magic Key.", $e5, $58, $f7
    db $e9, $ff, $f0

String_33_64A5_00_2B::
    db $eb, "*: ", $a4, "Oh, but your", $f1
    db "key ring is full.", $fa, $f7
    db $ef, $ee, "You'll have to", $ef, $ee, "make room, and", $fa, $f7
    db $ef, $ee, "come back for this", $ef, $ee, "later.", $f7
    db $f0

String_33_64A5_00_2C::
    db $eb, "*: Here's the Magic", $f1
    db "Key you", $44, " won!", $f7
    db $f0

String_33_64A5_00_2D::
    db $f9, "0 received", $f1
    db "the Pirate Key.", $e5, $58, $f7
    db $e9, $ff, $f0

String_33_64A5_00_2E::
    db $eb, "*: Here's the Pirate", $f1
    db "Key you", $44, " won!", $f7
    db $f0

String_33_64A5_00_2F::
    db $eb, "*: Congratulations!", $f1
    db "You did it!", $fa, $f7
    db $ef, $ee, "You've won the", $ef, $ee, $f9, "0 Class!", $fa, $f7
    db $ef, $ee, "Choose one of", $ef, $ee, "these chests!", $f7
    db $f0

String_33_64A5_00_30::
    db $eb, "*: Do you want the", $f1
    db "left chest?", $f0

String_33_64A5_00_31::
    db $eb, "*: Do you want the", $f1
    db "right chest?", $f0

String_33_64A5_00_32::
    db $eb, "*: Your prize is", $f1
    db "one ", $f9, "G!", $f7
    db $f0

String_33_64A5_00_33::
    db $eb, "*: Your prize is", $f1
    db "a Magic Key!", $f7
    db $f0

String_33_64A5_00_34::
    db $eb, "*: ", $a4, "Oh, but you", $f1
    db "have no room.", $fa, $f7
    db $ef, $ee, "Well, instead of", $ef, $ee, "the ", $f9, "G,", $fa, $f7
    db $ef, $ee, "here's 6000G.", $ef, $ee, $f7
    db $f0

String_33_64A5_00_35::
    db $eb, "*: ", $a4, "Oh, but your", $f1
    db "key ring is full.", $fa, $f7
    db $ef, $ee, "Well, instead of", $ef, $ee, "the Magic Key,", $fa, $f7
    db $ef, $ee, "here's 6000G", $ef, $ee, "instead.", $f7
    db $f0

; ld de, this bank's string table / BeginStringDisplay
BeginStringDisplay_Bank33_7037::
    ld de, StringCategories_33_704C
    call BeginStringDisplay
    ret
    db $11, $4c, $70, $cd, $fe, $25, $c9

; BeginStringDisplay_Bank33_7037 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
ShowString_Bank33_7045::
    call BeginStringDisplay_Bank33_7037
    call RunStringDisplayToEnd
    ret

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_33_704C::
    dw StringList_33_704E ; id 0

; category list of StringCategories_33_704C; one pointer per wStringIndex (E-0217)
; record: string
StringList_33_704E::
    dw String_33_704C_00_00 ; id 0
    dw String_33_704C_00_01 ; id 1
    dw String_33_704C_00_02 ; id 2
    dw String_33_704C_00_03 ; id 3
    dw String_33_704C_00_04 ; id 4
    dw String_33_704C_00_05 ; id 5
    dw String_33_704C_00_06 ; id 6
    dw String_33_704C_00_07 ; id 7
    dw String_33_704C_00_08 ; id 8
    dw String_33_704C_00_09 ; id 9
    dw String_33_704C_00_0A ; id 10
    dw String_33_704C_00_0B ; id 11
    dw String_33_704C_00_0C ; id 12
    dw String_33_704C_00_0D ; id 13
    dw String_33_704C_00_0E ; id 14
    dw String_33_704C_00_0E ; id 15
    dw String_33_704C_00_0E ; id 16
    dw String_33_704C_00_0E ; id 17
    dw String_33_704C_00_12 ; id 18

String_33_704C_00_00::
    db "It ends in a draw!", $fa, $f7
    db $f0

String_33_704C_00_01::
    db "Congratulations!", $f1
    db "You've won!", $fa, $f7
    db $f0

String_33_704C_00_02::
    db "Too bad!", $f1
    db "You've lost!", $fa, $f7
    db $f0

String_33_704C_00_03::
    db "Turned over", $f1
    db $f9, "0", $a4, $fa, $f7
    db $f0

String_33_704C_00_04::
    db "Received", $f1
    db $f9, "0", $fa, $f7
    db $f0

String_33_704C_00_05::
    db "But you have no", $f1
    db "room for it", $a4, $fa, $f7
    db $ef, $ee, "Switch it with", $ef, $ee, "another monster?", $f0

String_33_704C_00_06::
    db "Gave up on getting", $f1
    db $f9, "0 and released", $fa, $f7
    db $ef, $ee, "it in the wild", $a4, $fa, $f7
    db $f0

String_33_704C_00_07::
    db "Switch with which?", $f0

String_33_704C_00_08::
    db "Switch with which?", $f0

String_33_704C_00_09::
    db "Switch which egg?", $f0

String_33_704C_00_0A::
    db $f9, "0", $f1
    db "was released.", $fa, $f7
    db $f0

String_33_704C_00_0B::
    db "MonsterE?g", $f0

String_33_704C_00_0C::
    db "YesNo", $f0

String_33_704C_00_0D::
    db "InfoOKYesN", $f0

String_33_704C_00_0E::
    db "There are no eggs.", $f0

String_33_704C_00_12::
    db "You'll be left", $f1
    db "with no monster.", $f0
    ds $e10, $00
