; ROM bank $33: link sessions; strings
; The annotated listing of this bank is build/listing/bank33.asm.

SECTION "Bank 33", ROMX[$4000], BANK[$33]
    db $33

; DE = block number: the table at $405F gives each block an offset into wScreenTileBuffer (word), a
; width B and a height C, followed by B * C tile bytes; they are copied into wScreenTileBuffer rows
; 32 bytes apart (E-0351)
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
    dw TileRect_ScreenBlockTable_0 ; id 0
    dw TileRect_ScreenBlockTable_1 ; id 1
    dw TileRect_ScreenBlockTable_2 ; id 2
    dw TileRect_ScreenBlockTable_3 ; id 3
    dw TileRect_ScreenBlockTable_4 ; id 4
    dw TileRect_ScreenBlockTable_5 ; id 5
    dw TileRect_ScreenBlockTable_6 ; id 6
    dw TileRect_ScreenBlockTable_7 ; id 7
    dw TileRect_ScreenBlockTable_8 ; id 8
    dw TileRect_ScreenBlockTable_9 ; id 9
    dw TileRect_ScreenBlockTable_10 ; id 10
    dw TileRect_ScreenBlockTable_11 ; id 11
    dw TileRect_ScreenBlockTable_12 ; id 12
    dw TileRect_ScreenBlockTable_13 ; id 13
    dw TileRect_ScreenBlockTable_14 ; id 14
    dw TileRect_ScreenBlockTable_15 ; id 15
    dw TileRect_ScreenBlockTable_16 ; id 16
    dw TileRect_ScreenBlockTable_17 ; id 17
    dw TileRect_ScreenBlockTable_18 ; id 18
    dw TileRect_ScreenBlockTable_18 ; id 19
    dw TileRect_ScreenBlockTable_18 ; id 20
    dw TileRect_ScreenBlockTable_18 ; id 21
    dw TileRect_ScreenBlockTable_18 ; id 22
    dw TileRect_ScreenBlockTable_18 ; id 23
    dw TileRect_ScreenBlockTable_18 ; id 24
    dw TileRect_ScreenBlockTable_18 ; id 25
    dw TileRect_ScreenBlockTable_18 ; id 26
    dw TileRect_ScreenBlockTable_18 ; id 27
    dw TileRect_ScreenBlockTable_28 ; id 28
    dw TileRect_ScreenBlockTable_29 ; id 29
    dw TileRect_ScreenBlockTable_30 ; id 30
    dw TileRect_ScreenBlockTable_30 ; id 31
    dw TileRect_ScreenBlockTable_30 ; id 32
    dw TileRect_ScreenBlockTable_33 ; id 33
    dw TileRect_ScreenBlockTable_34 ; id 34
    dw TileRect_ScreenBlockTable_35 ; id 35
    dw TileRect_ScreenBlockTable_36 ; id 36
    dw TileRect_ScreenBlockTable_37 ; id 37
    dw TileRect_ScreenBlockTable_38 ; id 38
    dw TileRect_ScreenBlockTable_39 ; id 39
    dw TileRect_ScreenBlockTable_40 ; id 40
    dw TileRect_ScreenBlockTable_41 ; id 41
    dw TileRect_ScreenBlockTable_42 ; id 42
    dw TileRect_ScreenBlockTable_43 ; id 43
    dw TileRect_ScreenBlockTable_44 ; id 44
    dw TileRect_ScreenBlockTable_45 ; id 45
    dw TileRect_ScreenBlockTable_46 ; id 46
    dw TileRect_ScreenBlockTable_47 ; id 47
    dw TileRect_ScreenBlockTable_48 ; id 48
    dw TileRect_ScreenBlockTable_49 ; id 49
    dw TileRect_ScreenBlockTable_50 ; id 50

; a record of ScreenBlockTable (E-0232, C1)
; record: offset $0000 (row 0, column 0); 8 x 9 tiles
TileRect_ScreenBlockTable_0::
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
TileRect_ScreenBlockTable_1::
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
TileRect_ScreenBlockTable_2::
    dw $0161 ; entry 0: offset into wScreenTileBuffer
    db $06, $06 ; width, rows
    db $5c, $5d, $5e, $5f, $60, $61 ; row 0
    db $62, $63, $64, $65, $66, $67 ; row 1
    db $68, $69, $6a, $6b, $6c, $6d ; row 2
    db $6e, $6f, $70, $71, $72, $73 ; row 3
    db $74, $75, $76, $77, $78, $79 ; row 4
    db $7a, $7b, $7c, $7d, $7e, $7f ; row 5

; record: offset $01A8 (row 13, column 8); 12 x 5 tiles
TileRect_ScreenBlockTable_3::
    dw $01a8 ; entry 0: offset into wScreenTileBuffer
    db $0c, $05 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $f9, $fa, $ed, $c3, $c3, $c3, $be, $c3, $c3, $c3, $b7 ; row 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 2
    db $b6, $fb, $fa, $ed, $c3, $c3, $c3, $be, $c3, $c3, $c3, $b7 ; row 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 4

; a record of ScreenBlockTable (E-0232, C1)
; record: offset $0008 (row 0, column 8); 12 x 11 tiles
TileRect_ScreenBlockTable_4::
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
TileRect_ScreenBlockTable_5::
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
TileRect_ScreenBlockTable_6::
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
TileRect_ScreenBlockTable_7::
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
TileRect_ScreenBlockTable_8::
    dw $0160 ; entry 0: offset into wScreenTileBuffer
    db $08, $07 ; width, rows
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; row 0
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; row 1
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; row 2
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; row 3
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; row 4
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; row 5
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; row 6

TileRect_ScreenBlockTable_9::
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
TileRect_ScreenBlockTable_10::
    dw $0183 ; entry 0: offset into wScreenTileBuffer
    db $02, $04 ; width, rows
    db $c3, $0f ; row 0
    db $11, $10 ; row 1
    db $12, $10 ; row 2
    db $c3, $13 ; row 3

; record: offset $0000 (row 0, column 0); 7 x 13 tiles
TileRect_ScreenBlockTable_46::
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
TileRect_ScreenBlockTable_47::
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
TileRect_ScreenBlockTable_48::
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
TileRect_ScreenBlockTable_49::
    dw $01a4 ; entry 0: offset into wScreenTileBuffer
    db $0c, $05 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $80, $81, $82, $83, $84, $85, $86, $87, $88, $c3, $b7 ; row 1
    db $b6, $89, $8a, $8b, $8c, $8d, $8e, $8f, $90, $91, $c3, $b7 ; row 2
    db $b6, $92, $93, $94, $95, $96, $97, $98, $99, $9a, $c3, $b7 ; row 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 4

; record: offset $0000 (row 0, column 0); 6 x 3 tiles
TileRect_ScreenBlockTable_11::
    dw $0000 ; entry 0: offset into wScreenTileBuffer
    db $06, $03 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $a4, $a8, $a9, $ec, $b7 ; row 1
    db $b3, $b4, $b4, $b4, $b4, $b5 ; row 2

; record: offset $0008 (row 0, column 8); 12 x 9 tiles
TileRect_ScreenBlockTable_12::
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
TileRect_ScreenBlockTable_13::
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
TileRect_ScreenBlockTable_14::
    dw $0040 ; entry 0: offset into wScreenTileBuffer
    db $07, $07 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $ee, $ef, $f0, $f1, $c3, $b7 ; row 1
    db $b8, $b9, $b9, $b9, $b9, $b9, $ba ; row 2
    db $b6, $c3, $f2, $f3, $f5, $c3, $b7 ; row 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $c3, $f1, $f4, $f3, $f3, $b7 ; row 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b5 ; row 6

TileRect_ScreenBlockTable_50::
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
TileRect_ScreenBlockTable_15::
    dw $0100 ; entry 0: offset into wScreenTileBuffer
    db $06, $05 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $c3, $ce, $cf, $df, $b7 ; row 1
    db $b6, $c3, $c3, $c3, $c3, $b7 ; row 2
    db $b6, $c3, $a5, $f4, $c3, $b7 ; row 3
    db $b3, $b4, $b4, $b4, $b4, $b5 ; row 4

; record: offset $01A0 (row 13, column 0); 20 x 5 tiles
TileRect_ScreenBlockTable_16::
    dw $01a0 ; entry 0: offset into wScreenTileBuffer
    db $14, $05 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8a, $8b, $8c, $8d, $8e, $8f, $90, $91, $b7 ; row 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 2
    db $b6, $92, $93, $94, $95, $96, $97, $98, $99, $9a, $9b, $9c, $9d, $9e, $9f, $a0, $a1, $a2, $a3, $b7 ; row 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 4

; record: offset $0000 (row 0, column 0); 8 x 9 tiles
TileRect_ScreenBlockTable_17::
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
TileRect_ScreenBlockTable_18::
    dw $0120 ; entry 0: offset into wScreenTileBuffer
    db $0e, $05 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 4

TileRect_ScreenBlockTable_28::
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
TileRect_ScreenBlockTable_29::
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

TileRect_ScreenBlockTable_30::
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
TileRect_ScreenBlockTable_33::
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
TileRect_ScreenBlockTable_34::
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
TileRect_ScreenBlockTable_35::
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
TileRect_ScreenBlockTable_36::
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
TileRect_ScreenBlockTable_37::
    dw $00e0 ; entry 0: offset into wScreenTileBuffer
    db $06, $05 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $c3, $ce, $cf, $df, $b7 ; row 1
    db $b6, $c3, $c3, $c3, $c3, $b7 ; row 2
    db $b6, $c3, $a5, $f4, $c3, $b7 ; row 3
    db $b3, $b4, $b4, $b4, $b4, $b5 ; row 4

; record: offset $00CD (row 6, column 13); 7 x 3 tiles
TileRect_ScreenBlockTable_38::
    dw $00cd ; entry 0: offset into wScreenTileBuffer
    db $07, $03 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $d0, $d1, $d2, $d3, $d4, $b7 ; row 1
    db $b3, $b4, $b4, $b4, $b4, $b4, $b5 ; row 2

; a record of ScreenBlockTable (E-0232, C1)
; record: offset $0129 (row 9, column 9); 11 x 9 tiles
TileRect_ScreenBlockTable_39::
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
TileRect_ScreenBlockTable_40::
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
TileRect_ScreenBlockTable_41::
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
TileRect_ScreenBlockTable_42::
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
TileRect_ScreenBlockTable_43::
    dw $010e ; entry 0: offset into wScreenTileBuffer
    db $06, $05 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $c3, $ce, $cf, $df, $b7 ; row 1
    db $b6, $c3, $c3, $c3, $c3, $b7 ; row 2
    db $b6, $c3, $a5, $f4, $c3, $b7 ; row 3
    db $b3, $b4, $b4, $b4, $b4, $b5 ; row 4

; record: offset $0121 (row 9, column 1); 18 x 5 tiles
TileRect_ScreenBlockTable_44::
    dw $0121 ; entry 0: offset into wScreenTileBuffer
    db $12, $05 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $a6, $f0, $df, $f7, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $aa, $f2, $f4, $0b, $b7 ; row 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 2
    db $b6, $c3, $e1, $c3, $e2, $c3, $e3, $c3, $e4, $c3, $e5, $c3, $e6, $c3, $e7, $c3, $e8, $b7 ; row 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 4

; record: offset $0000 (row 0, column 0); 20 x 18 tiles
TileRect_ScreenBlockTable_45::
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

; called from GameMode5_Update_ToGameMode5_Update_LinkExchangeJoypadPerFrame: calls
; LinkExchangeJoypadPerFrame; branches on wTitleScreenState; branches on wScreenState; returns
; unless wScreenSubStep is 0; branches on wScreenStep; calls DrawListEntriesCell5SpeciesSprite;
; calls CallDrawPartySpeciesSpritesPreservingArg1AndTemp0; branches on wScreenStep; calls
; DrawRecordBufBSpeciesSpritePart_BankF1; calls DrawRecordBufBSpeciesSprites (E-0347)
; why: a helper of GameMode5_Update_ToGameMode5_Update_LinkExchangeJoypadPerFrame, in step 5 of
; GameMode5_Update (when wModeState = 5); GameMode5_Update: per-frame routine for wGameMode = 5
; (E-0352)
GameMode5_Update_LinkExchangeJoypadPerFrame_4::
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
    jr z, .call_draw_record_buf_b_species_sprite_part
    cp $20
    jr z, .call_draw_record_buf_b_species_sprites
    ret

.call_draw_record_buf_b_species_sprite_part:
    farcall DrawRecordBufBSpeciesSpritePart_BankF1
    ret

.call_draw_record_buf_b_species_sprites:
    farcall DrawRecordBufBSpeciesSprites
    ret

; called from RunLinkSession6Exchange_LinkReceiveStepWithBuffer: branches on wTitleScreenState;
; dispatches on wTitleScreenSubState; returns unless wFadeState is 0; dispatches on wScreenState
; (E-0347)
; why: a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in step 1 of
; RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the routine
; for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc::
    ld a, [wTitleScreenState]
    or a
    jr nz, .check_fade_state
    ld a, [wTitleScreenSubState]
    jumptable
    dw RunLinkSession6Exchange_DrawPlayerNameAndString0Category1AndStep
    dw RunLinkSession6Exchange_WriteGoldDigitsToScreenTileBufferRow1Col14
    dw RunLinkSession6Exchange_ShowForTeamMode1Hero
    dw RunLinkSession6Exchange_ShowYourPalRefusedThe
    dw RunLinkSession6Exchange_WriteLinkSendByteAndTitleScreenStateEtc
    dw RunLinkSession6Exchange_SetLinkSendByte_2
    dw RunLinkSession6Exchange_ChooseTeamMonster
    dw RunLinkSession6Exchange_ShowYouRefusedToPay
    dw RunLinkSession6Exchange_BackTitleScreenSubState
    dw RunLinkSession6Exchange_WriteLinkSendByteAndTitleScreenStateEtc_2
    dw RunLinkSession6Exchange_SetLinkSendByte
    dw RunLinkSession6Exchange_ShowYourPalRefusedTo
    dw RunLinkSession6Exchange_WriteTitleScreenSubStateAndLinkSendByteEtc
    dw RunLinkSession6Exchange_WriteLinkSendByteAndTitleScreenStateEtc_3

.check_fade_state:
    ld a, [wFadeState]
    or a
    ret nz
    ld a, [wScreenState]
    jumptable
    dw RunLinkSession6Exchange_AdvanceScreenState
    dw RunLinkSession6Exchange_AdvanceScreenState_2
    dw RunLinkSession6Exchange_PleaseWaitSteps
    dw RunLinkSession6Exchange_AdvanceScreenState_3
    dw RunLinkSession6Exchange_BreedMenuSteps
    dw RunLinkSession6Exchange_FightInfoExSteps
    dw RunLinkSession6Exchange_SwapMonstersMenu
    dw RunLinkSession6Exchange_SwapMonstersMenu
    dw RunLinkSession6Exchange_SwapMonstersMenu
    dw RunLinkSession6Exchange_SwapMonstersMenu
    dw RunLinkSession6Exchange_SwapMonstersMenu
    dw RunLinkSession6Exchange_SwapMonstersMenu
    dw RunLinkSession6Exchange_SwapMonstersMenu
    dw RunLinkSession6Exchange_RunScreenStateWhenNotFading_F1
    dw RunLinkSession6Exchange_ClearRecordPanelTilesSteps
    dw RunLinkSession6Exchange_ClearRecordPanelTilesSteps_2

; step 0 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc: calls
; CopyRectTo20ByteRowsJp_Bank33; calls DrawPlayerNameAndString0Category1; calls
; SetDefaultStringWindow_Bank33; advances wTitleScreenSubState (E-0347)
; why: step 0 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when
; wTitleScreenSubState = 0), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in
; step 1 of RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the
; routine for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_DrawPlayerNameAndString0Category1AndStep::
    ld de, RunLinkSession6Exchange_DrawPlayerNameAndString0Category1AndStep_TileRect
    ld hl, wScreenTileBuffer + $c
    lb bc, $08, $03
    call CopyRectTo20ByteRowsJp_Bank33
    ld de, RunLinkSession6Exchange_DrawPlayerNameAndString0Category1AndStep_TileRect_2
    ld hl, wScreenTileBuffer
    lb bc, $0a, $0b
    call CopyRectTo20ByteRowsJp_Bank33
    call DrawPlayerNameAndString0Category1
    call SetDefaultStringWindow_Bank33
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; step 1 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc: sets
; wLinkSendByte to 0; calls WriteGoldDigitsToScreenTileBufferRow1Col14; calls RunFourTimes; calls
; BGMapAddressAtScroll_Bank33; calls DrawScreenBufferRectToBGMap_33; advances wTitleScreenSubState
; (E-0347)
; why: step 1 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when
; wTitleScreenSubState = 1), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in
; step 1 of RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the
; routine for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_WriteGoldDigitsToScreenTileBufferRow1Col14::
    xor a
    ld [wLinkSendByte], a
    call WriteGoldDigitsToScreenTileBufferRow1Col14
    ld de, wKeyNameBuf
    ld hl, wScreenTileBuffer + $43
    call RunFourTimes
    call BGMapAddressAtScroll_Bank33
    lb bc, $14, $0d
    ld de, $0000
    call DrawScreenBufferRectToBGMap_33
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; step 2 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc: returns unless
; wFadeState is 0; calls BeginString_Bank07_Cat5; advances wTitleScreenSubState; sets wLinkSendByte
; to 0 (E-0347)
; why: step 2 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when
; wTitleScreenSubState = 2), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in
; step 1 of RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the
; routine for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_ShowForTeamMode1Hero::
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

; step 3 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc: branches on
; wLinkMessage; sets wLinkSendByte to $fe; sets wTitleScreenState to 1; sets wScreenState to 2;
; calls BeginString_Bank07_Cat5; returns unless wTextFlags is 0; branches on wTextFlags; sets
; wLinkSendByte to $fe; sets wTitleScreenState to 1; sets wScreenState to 2; calls
; BeginString_Bank07_Cat5; sets wTitleScreenSubState; then 7 more steps (see the code) (E-0347)
; why: step 3 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when
; wTitleScreenSubState = 3), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in
; step 1 of RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the
; routine for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_ShowYourPalRefusedThe::
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

; step 4 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc: branches on
; wLinkMessage; sets wLinkSendByte to $fe; sets wTitleScreenState to 1; sets wScreenState to 2;
; calls BeginString_Bank07_Cat5; advances wTitleScreenSubState; sets wLinkSendByte to 0; calls
; BeginString_Bank07_Cat5; advances wTitleScreenSubState (E-0347)
; why: step 4 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when
; wTitleScreenSubState = 4), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in
; step 1 of RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the
; routine for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_WriteLinkSendByteAndTitleScreenStateEtc::
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

; step 5 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc: sets
; wLinkSendByte to 0; advances wTitleScreenSubState; sets wLinkScreenFlag to 0 (E-0347)
; why: step 5 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when
; wTitleScreenSubState = 5), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in
; step 1 of RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the
; routine for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_SetLinkSendByte_2::
    xor a
    ld [wLinkSendByte], a
    ld hl, wTitleScreenSubState
    inc [hl]
    xor a
    ld [wLinkScreenFlag], a
    ret

; by its step: 'Choose a monster for the Team ...' (E-0294)
RunLinkSession6Exchange_ChooseTeamMonster::
    ld a, [wLinkScreenFlag]
    jumptable
    dw RunLinkSession6Exchange_ChooseTeamMonster_WaitTextFlags
    dw RunLinkSession6Exchange_ChooseTeamMonster_ShowChooseAMonsterFor
    dw RunLinkSession6Exchange_ChooseTeamMonster_SetTitleScreenSubState

; step 0 of RunLinkSession6Exchange_ChooseTeamMonster: returns unless wTextFlags is 0; branches on
; wTextFlags; increments wLinkScreenFlag (E-0347)
; why: step 0 of RunLinkSession6Exchange_ChooseTeamMonster (when wLinkScreenFlag = 0);
; RunLinkSession6Exchange_ChooseTeamMonster: by its step: 'Choose a monster for the Team ...'
; (E-0352)
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

; step 1 of RunLinkSession6Exchange_ChooseTeamMonster: calls BGMapAddressAtScroll_Bank33; calls
; DrawScreenBufferRectToBGMap_33; calls BeginString_Bank07_Cat5; increments wLinkScreenFlag (E-0347)
; why: step 1 of RunLinkSession6Exchange_ChooseTeamMonster (when wLinkScreenFlag = 1);
; RunLinkSession6Exchange_ChooseTeamMonster: by its step: 'Choose a monster for the Team ...'
; (E-0352)
RunLinkSession6Exchange_ChooseTeamMonster_ShowChooseAMonsterFor::
    call BGMapAddressAtScroll_Bank33
    lb bc, $14, $0d
    ld de, $0000
    call DrawScreenBufferRectToBGMap_33
    ld a, $08 ; 'Choose a monster for the Team'
    call BeginString_Bank07_Cat5
    ld hl, wLinkScreenFlag
    inc [hl]
    ret

; step 2 of RunLinkSession6Exchange_ChooseTeamMonster: sets wTitleScreenSubState to 0; sets
; wLinkScreenFlag to 0; sets wTitleScreenState to 1; sets wScreenState to 0 (E-0347)
; why: step 2 of RunLinkSession6Exchange_ChooseTeamMonster (when wLinkScreenFlag = 2);
; RunLinkSession6Exchange_ChooseTeamMonster: by its step: 'Choose a monster for the Team ...'
; (E-0352)
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

; step 7 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc: returns unless
; wTextFlags is 0; branches on wTextFlags; calls BeginString_Bank07_Cat5; sets wLinkSendByte to $40;
; advances wTitleScreenSubState; calls BeginString_Bank07_Cat5; sets wLinkSendByte to $30; advances
; wTitleScreenSubState; sets wGoldHi to $30; copies B to wGoldMid; copies C to wGoldLo; calls
; BeginString_Bank07_Cat5; then 2 more steps (see the code) (E-0347)
; why: step 7 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when
; wTitleScreenSubState = 7), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in
; step 1 of RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the
; routine for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_ShowYouRefusedToPay::
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

; step 8 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc: branches on
; wLinkMessage; returns unless wLinkMessage is $20; decrements wTitleScreenSubState; sets
; wLinkSendByte to $fe; sets wTitleScreenState to 1; sets wScreenState to 2; calls
; BeginString_Bank07_Cat5 (E-0347)
; why: step 8 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when
; wTitleScreenSubState = 8), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in
; step 1 of RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the
; routine for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_BackTitleScreenSubState::
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

; step 9 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc: branches on
; wLinkMessage; returns unless wLinkMessage is $40; advances wTitleScreenSubState; sets
; wLinkSendByte to $fe; sets wTitleScreenState to 1; sets wScreenState to 2; calls
; BeginString_Bank07_Cat5 (E-0347)
; why: step 9 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when
; wTitleScreenSubState = 9), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in
; step 1 of RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the
; routine for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_WriteLinkSendByteAndTitleScreenStateEtc_2::
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

; step 10 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc: sets
; wLinkSendByte to $fe; sets wTitleScreenState to 1; sets wTitleScreenSubState to 0; sets
; wScreenState to 2 (E-0347)
; why: step 10 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when
; wTitleScreenSubState = 10), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in
; step 1 of RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the
; routine for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_SetLinkSendByte::
    ld a, $fe
    ld [wLinkSendByte], a
    ld a, $01
    ld [wTitleScreenState], a
    xor a
    ld [wTitleScreenSubState], a
    ld a, $02
    ld [wScreenState], a
    ret

; step 11 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc: branches on
; wLinkMessage; returns unless wLinkMessage is $40; copies wLinkMessage to wLinkSendByte; calls
; BeginString_Bank07_Cat5; advances wTitleScreenSubState; sets wLinkSendByte; calls
; BeginString_Bank07_Cat5; advances wTitleScreenSubState; sets wLinkSendByte; calls
; BeginString_Bank07_Cat5; advances wTitleScreenSubState; sets wLinkSendByte; then 6 more steps (see
; the code) (E-0347)
; why: step 11 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when
; wTitleScreenSubState = 11), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in
; step 1 of RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the
; routine for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_ShowYourPalRefusedTo::
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

; step 12 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc: branches on
; wLinkMessage; returns unless wLinkMessage is $20; sets wTitleScreenSubState to 5; sets
; wLinkSendByte to $fe; sets wTitleScreenState to 1; sets wScreenState to 2; calls
; BeginString_Bank07_Cat5 (E-0347)
; why: step 12 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when
; wTitleScreenSubState = 12), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in
; step 1 of RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the
; routine for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_WriteTitleScreenSubStateAndLinkSendByteEtc::
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

; step 13 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc: branches on
; wLinkMessage; returns unless wLinkMessage is $fe; sets wLinkSendByte to $fe; sets
; wTitleScreenState to 1; sets wTitleScreenSubState to 0; sets wScreenState to 2 (E-0347)
; why: step 13 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when
; wTitleScreenSubState = 13), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in
; step 1 of RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the
; routine for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_WriteLinkSendByteAndTitleScreenStateEtc_3::
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

; A = string index: wStringIndex = A, wStringCategory = 5, then BeginStringDisplay_Bank07 (E-0351)
BeginString_Bank07_Cat5::
    ld [wStringIndex], a
    ld a, $05
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank07
    ret

; step 0 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc: advances
; wScreenState (E-0347)
; why: step 0 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when
; wTitleScreenSubState = 0), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in
; step 1 of RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the
; routine for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_AdvanceScreenState::
    ld hl, wScreenState
    inc [hl]
    ret

; step 1 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc: returns unless
; wTextFlags is 0; advances wScreenState (E-0347)
; why: step 1 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when
; wTitleScreenSubState = 1), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in
; step 1 of RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the
; routine for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_AdvanceScreenState_2::
    ld a, [wTextFlags]
    and a
    ret nz
    ld hl, wScreenState
    inc [hl]
    inc [hl]
    ret

; step 2 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc: dispatches on
; wScreenStep (E-0347)
; why: step 2 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when
; wTitleScreenSubState = 2), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in
; step 1 of RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the
; routine for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_PleaseWaitSteps::
    ld a, [wScreenStep]
    jumptable
    dw RunLinkSession6Exchange_SetLinkSendByte_3
    dw RunLinkSession6Exchange_PleaseWait
    dw RunLinkSession6Exchange_SetLinkSendByte_4
    dw RunLinkSession6Exchange_SetLinkSendByte_5
    dw RunLinkSession6Exchange_AdvanceModeChangeRequest

; step 0 of RunLinkSession6Exchange_PleaseWaitSteps: returns unless wLinkMessage is $fe; sets
; wLinkSendByte to 0; increments wScreenStep (E-0347)
; why: step 0 of RunLinkSession6Exchange_PleaseWaitSteps (when wScreenStep = 0), in step 2 of
; RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when wTitleScreenSubState =
; 2), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in step 1 of
; RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the routine
; for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_SetLinkSendByte_3::
    ld a, [wLinkMessage]
    cp $fe
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 1 of RunLinkSession6Exchange_PleaseWaitSteps: returns unless wTextFlags is 0; calls
; ShowStringA10_Bank33; advances wScreenStep (E-0347)
; why: step 1 of RunLinkSession6Exchange_PleaseWaitSteps (when wScreenStep = 1), in step 2 of
; RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when wTitleScreenSubState =
; 2), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in step 1 of
; RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the routine
; for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_PleaseWait::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, $0c ; 'Please wait.'
    call ShowStringA10_Bank33
    ld hl, wScreenStep
    inc [hl]
    ret

; step 2 of RunLinkSession6Exchange_PleaseWaitSteps: returns unless wTextFlags is 0; sets
; wLinkSendByte to 1; advances wScreenStep (E-0347)
; why: step 2 of RunLinkSession6Exchange_PleaseWaitSteps (when wScreenStep = 2), in step 2 of
; RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when wTitleScreenSubState =
; 2), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in step 1 of
; RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the routine
; for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_SetLinkSendByte_4::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wScreenStep
    inc [hl]
    ret

; step 3 of RunLinkSession6Exchange_PleaseWaitSteps: returns unless wLinkMessage is $01; sets
; wLinkSendByte to 0; advances wScreenStep (E-0347)
; why: step 3 of RunLinkSession6Exchange_PleaseWaitSteps (when wScreenStep = 3), in step 2 of
; RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when wTitleScreenSubState =
; 2), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in step 1 of
; RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the routine
; for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_SetLinkSendByte_5::
    ld a, [wLinkMessage]
    cp $01
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld hl, wScreenStep
    inc [hl]
    ret

; step 4 of RunLinkSession6Exchange_PleaseWaitSteps: returns if bit 0 of wTextFlags is set; branches
; on wTextFlags; increments wModeChangeRequest (E-0347)
; why: step 4 of RunLinkSession6Exchange_PleaseWaitSteps (when wScreenStep = 4), in step 2 of
; RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when wTitleScreenSubState =
; 2), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in step 1 of
; RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the routine
; for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_AdvanceModeChangeRequest::
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

; step 3 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc: advances
; wScreenState (E-0347)
; why: step 3 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when
; wTitleScreenSubState = 3), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in
; step 1 of RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the
; routine for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_AdvanceScreenState_3::
    ld hl, wScreenState
    inc [hl]
    ret

; step 4 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc: dispatches on
; wScreenStep (E-0347)
; why: step 4 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when
; wTitleScreenSubState = 4), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in
; step 1 of RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the
; routine for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_BreedMenuSteps::
    ld a, [wScreenStep]
    jumptable
    dw RunLinkSession6Exchange_BreedMenu
    dw RunLinkSession6Exchange_BreedMenu
    dw RunLinkSession6Exchange_DrawRecordListPageIndicators_1B
    dw RunLinkSession6Exchange_BreedMenu
    dw CallDrawListEntriesCell5RecordPanel
    dw CallClearAndDrawListEntriesCell5Name
    dw CopyRectToWindowTileBufferRow5Col10AndIncScreenStep
    dw RunLinkSession6Exchange_RunFourTimes
    dw RunLinkSession6Exchange_YourPalRefusedThe
    dw RunLinkSession6Exchange_InfoOKYesN
    dw RunLinkSession6Exchange_YourPalRefusedThe_2
    dw RunLinkSession6Exchange_ChooseAMonsterFor
    dw RunLinkSession6Exchange_PleaseWait_2
    dw RunLinkSession6Exchange_SetLinkTimeoutLo
    dw RunLinkSession6Exchange_YourPalRefusedThe_3
    dw RunLinkSession6Exchange_AdvanceScreenState_4

; step 0 of RunLinkSession6Exchange_BreedMenuSteps: returns unless wTextFlags is 0; calls BreedMenu
; (E-0347)
; why: step 0 of RunLinkSession6Exchange_BreedMenuSteps (when wScreenStep = 0), in step 4 of
; RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when wTitleScreenSubState =
; 4), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in step 1 of
; RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the routine
; for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_BreedMenu::
    ld a, [wTextFlags]
    and a
    ret nz
    farcall BreedMenu
    ret

; step 2 of RunLinkSession6Exchange_BreedMenuSteps: calls DrawRecordListPageIndicators_1B (E-0347)
; why: step 2 of RunLinkSession6Exchange_BreedMenuSteps (when wScreenStep = 2), in step 4 of
; RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when wTitleScreenSubState =
; 4), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in step 1 of
; RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the routine
; for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_DrawRecordListPageIndicators_1B::
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

; copies the 10 x 11 rectangle
; RunLinkSession6Exchange_DrawPlayerNameAndString0Category1AndStep_TileRect_2 into wWindowTileBuffer
; + $6E (CopyRectTo20ByteRowsJp_Bank33), then wScreenStep += 1 (E-0119) (E-0340: the address in its
; name read as its RAM name; was CopyRectToWindowTileBufferRow5Col10AndIncScreenStep) (E-0344: the
; address in its name dropped or read as the label there; was
; CopyRectToWindowTileBufferRow5Col10AndIncScreenStep)
CopyRectToWindowTileBufferRow5Col10AndIncScreenStep::
    ld de, RunLinkSession6Exchange_DrawPlayerNameAndString0Category1AndStep_TileRect_2
    ld hl, wWindowTileBuffer + $6e
    lb bc, $0a, $0b
    call CopyRectTo20ByteRowsJp_Bank33
    ld hl, wScreenStep
    inc [hl]
    ret

; step 7 of RunLinkSession6Exchange_BreedMenuSteps: returns unless wTextFlags is 0; calls
; StoreBAtWordTableEntry_Bank33; calls RunFourTimes; calls BGMapAddressAtScroll_Bank33; calls
; DrawScreenBufferRectToBGMap_33; calls StoreBAtWordTableEntry_Bank33; calls
; SetDefaultStringWindow_Bank33; increments wScreenStep (E-0347)
; why: step 7 of RunLinkSession6Exchange_BreedMenuSteps (when wScreenStep = 7), in step 4 of
; RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when wTitleScreenSubState =
; 4), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in step 1 of
; RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the routine
; for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_RunFourTimes::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wListCursor]
    ld b, $bb
    ld hl, RunLinkSession6Exchange_Data
    call StoreBAtWordTableEntry_Bank33
    ld de, wKeyNameBuf
    ld hl, wWindowTileBuffer + $b1
    call RunFourTimes
    call BGMapAddressAtScroll_Bank33
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_33
    ld a, [wListCursor]
    ld b, $c3
    ld hl, RunLinkSession6Exchange_Data
    call StoreBAtWordTableEntry_Bank33
    call SetDefaultStringWindow_Bank33
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 8 of RunLinkSession6Exchange_BreedMenuSteps: branches on wLinkMessage; sets wScreenState to
; 2; sets wScreenStep to 0; sets wScreenSubStep to 0; calls BeginString_Bank07_Cat5; sets
; wLinkSendByte to $fe; sets wMenuInputResult to 0; calls UpdatePagedListCursor; returns if
; wMenuInputResult is 0; branches on wMenuInputResult; sets wScreenStep; sets wScreenState to 2;
; then 9 more steps (see the code) (E-0347)
; why: step 8 of RunLinkSession6Exchange_BreedMenuSteps (when wScreenStep = 8), in step 4 of
; RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when wTitleScreenSubState =
; 4), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in step 1 of
; RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the routine
; for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_YourPalRefusedThe::
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
    ld hl, RunLinkSession6Exchange_Data
    call StoreBAtWordTableEntry_Bank33
    call CopyListEntriesCell5NameToTextBuf0_Bank33
    ld hl, wScreenStep
    inc [hl]
    ld a, $02 ; 'Pick 0 for the team?'
    call ShowStringA10_Bank33
    ret

; step 9 of RunLinkSession6Exchange_BreedMenuSteps: returns unless wTextFlags is 0; copies L to
; wTextWindowTileLo; copies H to wTextWindowTileHi; copies L to wTextWindowRows; copies H to
; wTextWindowWidth; sets wStringCategory to 0; sets wStringIndex to $1e; calls ShowString_Bank1B;
; plays sound $6c; calls CopyRectTo20ByteRowsJp_Bank33; calls BGMapAddressAtScroll_Bank33; calls
; DrawScreenBufferRectToBGMap_33; then 3 more steps (see the code) (E-0347)
; why: step 9 of RunLinkSession6Exchange_BreedMenuSteps (when wScreenStep = 9), in step 4 of
; RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when wTitleScreenSubState =
; 4), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in step 1 of
; RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the routine
; for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_InfoOKYesN::
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
    farcall ShowString_Bank1B
    ld a, $6c
    call QueueSoundEffect
    ld de, RunLinkSession6Exchange_InfoOKYesN_TileRect
    ld hl, wWindowTileBuffer + $110
    lb bc, $08, $05
    call CopyRectTo20ByteRowsJp_Bank33
    call BGMapAddressAtScroll_Bank33
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_33
    call SetDefaultStringWindow_Bank33
    xor a
    ld [wChoiceCursor], a
    ld hl, wScreenStep
    inc [hl]
    ret

; step 10 of RunLinkSession6Exchange_BreedMenuSteps: branches on wLinkMessage; sets wScreenState to
; 2; sets wScreenStep to 0; sets wScreenSubStep to 0; calls BeginString_Bank07_Cat5; sets
; wLinkSendByte to $fe; sets wArg5 to 0; calls HandleTwoChoiceCursorInput_0D; returns if wArg5 is 0;
; branches on wArg5; advances wScreenStep; branches on wChoiceCursor; then 7 more steps (see the
; code) (E-0347)
; why: step 10 of RunLinkSession6Exchange_BreedMenuSteps (when wScreenStep = 10), in step 4 of
; RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when wTitleScreenSubState =
; 4), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in step 1 of
; RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the routine
; for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_YourPalRefusedThe_2::
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
    ld [wReturnScreenState], a
    ld a, [wScreenStep]
    ld [wReturnScreenStep], a
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

; step 11 of RunLinkSession6Exchange_BreedMenuSteps: returns unless wTextFlags is 0; calls
; WriteC3AtWordTableEntries_Bank33; calls DrawBoxAndKeyRows; calls BGMapAddressAtScroll_Bank33;
; calls DrawScreenBufferRectToBGMap_33; calls BeginString_Bank07_Cat5; sets wScreenStep (E-0347)
; why: step 11 of RunLinkSession6Exchange_BreedMenuSteps (when wScreenStep = 11), in step 4 of
; RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when wTitleScreenSubState =
; 4), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in step 1 of
; RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the routine
; for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_ChooseAMonsterFor::
    ld a, [wTextFlags]
    and a
    ret nz
    ld c, $05
    ld hl, RunLinkSession6Exchange_Data
    call WriteC3AtWordTableEntries_Bank33
    call DrawBoxAndKeyRows
    call BGMapAddressAtScroll_Bank33
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_33
    ld a, $08 ; 'Choose a monster for the Team'
    call BeginString_Bank07_Cat5
    ld a, [wScreenStep]
    sub $03
    ld [wScreenStep], a
    ret

; step 12 of RunLinkSession6Exchange_BreedMenuSteps: calls DrawBoxAndKeyRows; calls
; BGMapAddressAtScroll_Bank33; calls DrawScreenBufferRectToBGMap_33; increments wPickCount; calls
; ShowStringA10_Bank33; calls FinishPickedRecordsEntryAndStep_33 (E-0347)
; why: step 12 of RunLinkSession6Exchange_BreedMenuSteps (when wScreenStep = 12), in step 4 of
; RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when wTitleScreenSubState =
; 4), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in step 1 of
; RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the routine
; for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_PleaseWait_2::
    call DrawBoxAndKeyRows
    call BGMapAddressAtScroll_Bank33
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_33
    ld hl, wPickCount
    inc [hl]
    ld a, $0c ; 'Please wait.'
    call ShowStringA10_Bank33
    call FinishPickedRecordsEntryAndStep_33
    ret

; step 13 of RunLinkSession6Exchange_BreedMenuSteps: sets rRAMG to $0a; sets rRAMB to 0; calls
; SRAMRecordAddress; copies E to wLinkTimeoutLo; copies D to wLinkTimeoutHi; copies E to
; wLinkBufferPtrLo; copies D to wLinkBufferPtrHi; sets rRAMG to 0; sets wLinkScene to 0; sets
; wLinkSendByte to 1; advances wScreenStep (E-0347)
; why: step 13 of RunLinkSession6Exchange_BreedMenuSteps (when wScreenStep = 13), in step 4 of
; RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when wTitleScreenSubState =
; 4), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in step 1 of
; RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the routine
; for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_SetLinkTimeoutLo::
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
    ld [wLinkScene], a
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wScreenStep
    inc [hl]
    ret

; step 14 of RunLinkSession6Exchange_BreedMenuSteps: branches on wLinkMessage; returns unless
; wLinkMessage is $fe; sets wScreenState to 2; sets wScreenStep to 0; sets wScreenSubStep to 0;
; calls BeginString_Bank07_Cat5; sets wLinkSendByte to $fe; copies L to wLinkBufferCountLo; copies H
; to wLinkBufferCountHi; sets wLinkSendByte to $ff; sets wLinkReady to 1; advances wScreenStep
; (E-0347)
; why: step 14 of RunLinkSession6Exchange_BreedMenuSteps (when wScreenStep = 14), in step 4 of
; RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when wTitleScreenSubState =
; 4), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in step 1 of
; RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the routine
; for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_YourPalRefusedThe_3::
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

; step 15 of RunLinkSession6Exchange_BreedMenuSteps: returns unless wLinkMessage is $f0; advances
; wScreenState; sets wScreenStep to 0 (E-0347)
; why: step 15 of RunLinkSession6Exchange_BreedMenuSteps (when wScreenStep = 15), in step 4 of
; RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when wTitleScreenSubState =
; 4), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in step 1 of
; RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the routine
; for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_AdvanceScreenState_4::
    ld a, [wLinkMessage]
    cp $f0
    ret nz
    ld hl, wScreenState
    inc [hl]
    xor a
    ld [wScreenStep], a
    ret

; step 5 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc: dispatches on
; wScreenStep (E-0347)
; why: step 5 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when
; wTitleScreenSubState = 5), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in
; step 1 of RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the
; routine for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_FightInfoExSteps::
    ld a, [wScreenStep]
    jumptable
    dw RunLinkSession6Exchange_AdvanceScreenStep
    dw RunLinkSession6Exchange_SetLinkSendByte_6
    dw RunLinkSession6Exchange_SetLinkTimeoutLo_2
    dw RunLinkSession6Exchange_SetLinkSendByte_7
    dw RunLinkSession6Exchange_FightInfoEx
    dw RunLinkSession6Exchange_BattleInTeamMode
    dw RunLinkSession6Exchange_YourPalRefusedThe_4
    dw RunLinkSession6Exchange_TheBattleResultsWill
    dw RunLinkSession6Exchange_YourPalRefusedThe_5
    dw RunLinkSession6Exchange_PleaseWait_3
    dw RunLinkSession6Exchange_AdvanceScreenStep_2
    dw RunLinkSession6Exchange_YourPalRefusedThe_6
    dw RunLinkSession6Exchange_VerifySaveChecksum
    dw RunLinkSession6Exchange_SetArg5ToListEntriesCell5
    dw RunLinkSession6Exchange_SetScreenStep
    dw RunLinkSession6Exchange_SetLinkSendByte_8
    dw RunLinkSession6Exchange_SetScreenStep_2
    dw RunLinkSession6Exchange_SetLinkSendByte_9

; step 0 of RunLinkSession6Exchange_FightInfoExSteps: advances wScreenStep; sets wLinkSendByte to 0;
; calls CopyBBytesThenMark1 (E-0347)
; why: step 0 of RunLinkSession6Exchange_FightInfoExSteps (when wScreenStep = 0), in step 5 of
; RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when wTitleScreenSubState =
; 5), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in step 1 of
; RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the routine
; for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_AdvanceScreenStep::
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

; step 1 of RunLinkSession6Exchange_FightInfoExSteps: sets wLinkSendByte to 1; advances wScreenStep
; (E-0347)
; why: step 1 of RunLinkSession6Exchange_FightInfoExSteps (when wScreenStep = 1), in step 5 of
; RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when wTitleScreenSubState =
; 5), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in step 1 of
; RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the routine
; for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_SetLinkSendByte_6::
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wScreenStep
    inc [hl]
    ret

; step 2 of RunLinkSession6Exchange_FightInfoExSteps: returns unless wLinkMessage is $01; copies L
; to wLinkTimeoutLo; copies H to wLinkTimeoutHi; copies L to wLinkBufferPtrLo; copies H to
; wLinkBufferPtrHi; sets wLinkBufferCountLo to $10; sets wLinkSendByte to $ff; advances wScreenStep
; (E-0347)
; why: step 2 of RunLinkSession6Exchange_FightInfoExSteps (when wScreenStep = 2), in step 5 of
; RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when wTitleScreenSubState =
; 5), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in step 1 of
; RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the routine
; for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_SetLinkTimeoutLo_2::
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

; step 3 of RunLinkSession6Exchange_FightInfoExSteps: returns unless wLinkMessage is $f0; sets
; wLinkSendByte to 0; advances wScreenStep (E-0347)
; why: step 3 of RunLinkSession6Exchange_FightInfoExSteps (when wScreenStep = 3), in step 5 of
; RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when wTitleScreenSubState =
; 5), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in step 1 of
; RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the routine
; for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_SetLinkSendByte_7::
    ld a, [wLinkMessage]
    cp $f0
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld hl, wScreenStep
    inc [hl]
    ret

; step 4 of RunLinkSession6Exchange_FightInfoExSteps: calls CopyRectTo20ByteRowsJp_Bank33; copies L
; to wTextWindowTileLo; copies H to wTextWindowTileHi; copies L to wTextWindowRows; copies H to
; wTextWindowWidth; calls FillTilesFromRequest; calls CopyBytes; calls CopyGlyphTilesToVRAM; copies
; wLinkTradeByte to wLinkFightInfo; calls RunFourTimes; copies L to wTextWindowTileLo; copies H to
; wTextWindowTileHi; then 15 more steps (see the code) (E-0347)
; why: step 4 of RunLinkSession6Exchange_FightInfoExSteps (when wScreenStep = 4), in step 5 of
; RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when wTitleScreenSubState =
; 5), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in step 1 of
; RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the routine
; for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_FightInfoEx::
    ld de, RunLinkSession6Exchange_FightInfoEx_TileRect
    ld hl, wWindowTileBuffer + $64
    lb bc, $0a, $0b
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
    ld [wLinkFightInfo], a
    ld de, wLinkPartnerName
    ld hl, wWindowTileBuffer + $a7
    call RunFourTimes
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
    farcall ShowString_Bank1B
    ld de, RunLinkSession6Exchange_FightInfoEx_TileRect_2
    ld hl, wWindowTileBuffer + $e7
    lb bc, $09, $07
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

; step 5 of RunLinkSession6Exchange_FightInfoExSteps: calls BGMapAddressAtScroll_Bank33; calls
; DrawScreenBufferRectToBGMap_33; calls BeginString_Bank07_Cat5; sets wTwoChoiceCursor to 0;
; advances wScreenStep (E-0347)
; why: step 5 of RunLinkSession6Exchange_FightInfoExSteps (when wScreenStep = 5), in step 5 of
; RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when wTitleScreenSubState =
; 5), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in step 1 of
; RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the routine
; for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_BattleInTeamMode::
    call BGMapAddressAtScroll_Bank33
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_33
    ld a, $0d ; 'Battle in Team Mode?'
    call BeginString_Bank07_Cat5
    xor a
    ld [wTwoChoiceCursor], a
    ld hl, wScreenStep
    inc [hl]
    ret

; step 6 of RunLinkSession6Exchange_FightInfoExSteps: branches on wLinkMessage; sets wScreenState to
; 2; sets wScreenStep to 0; sets wScreenSubStep to 0; calls BeginString_Bank07_Cat5; sets
; wLinkSendByte to $fe; calls HandleThreeChoiceCursorInput_F1; returns if wMenuInputResult is 0;
; branches on wMenuInputResult; sets wScreenState to 2; calls BeginString_Bank07_Cat5; sets
; wScreenStep to 0; then 13 more steps (see the code) (E-0347)
; why: step 6 of RunLinkSession6Exchange_FightInfoExSteps (when wScreenStep = 6), in step 5 of
; RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when wTitleScreenSubState =
; 5), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in step 1 of
; RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the routine
; for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_YourPalRefusedThe_4::
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
    ld [wReturnScreenState], a
    ld a, [wScreenStep]
    ld [wReturnScreenStep], a
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

; step 7 of RunLinkSession6Exchange_FightInfoExSteps: calls CopyBytes; calls
; BeginString_Bank07_Cat5; sets wLinkSendByte to 0; advances wScreenStep (E-0347)
; why: step 7 of RunLinkSession6Exchange_FightInfoExSteps (when wScreenStep = 7), in step 5 of
; RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when wTitleScreenSubState =
; 5), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in step 1 of
; RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the routine
; for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_TheBattleResultsWill::
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

; step 8 of RunLinkSession6Exchange_FightInfoExSteps: branches on wLinkMessage; sets wScreenState to
; 2; sets wScreenStep to 0; sets wScreenSubStep to 0; calls BeginString_Bank07_Cat5; sets
; wLinkSendByte to $fe; returns unless wTextFlags is 0; branches on wTextFlags; calls
; BeginString_Bank07_Cat5; decrements wScreenStep; advances wScreenStep (E-0347)
; why: step 8 of RunLinkSession6Exchange_FightInfoExSteps (when wScreenStep = 8), in step 5 of
; RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when wTitleScreenSubState =
; 5), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in step 1 of
; RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the routine
; for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_YourPalRefusedThe_5::
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

; step 9 of RunLinkSession6Exchange_FightInfoExSteps: advances wScreenStep; calls
; BeginString_Bank07_Cat5 (E-0347)
; why: step 9 of RunLinkSession6Exchange_FightInfoExSteps (when wScreenStep = 9), in step 5 of
; RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when wTitleScreenSubState =
; 5), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in step 1 of
; RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the routine
; for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_PleaseWait_3::
    ld hl, wScreenStep
    inc [hl]
    ld a, $0c ; 'Please wait.'
    call BeginString_Bank07_Cat5
    ret

; step 10 of RunLinkSession6Exchange_FightInfoExSteps: returns unless wTextFlags is 0; advances
; wScreenStep; sets wLinkSendByte to 1 (E-0347)
; why: step 10 of RunLinkSession6Exchange_FightInfoExSteps (when wScreenStep = 10), in step 5 of
; RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when wTitleScreenSubState =
; 5), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in step 1 of
; RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the routine
; for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_AdvanceScreenStep_2::
    ld a, [wTextFlags]
    and a
    ret nz
    ld hl, wScreenStep
    inc [hl]
    ld a, $01
    ld [wLinkSendByte], a
    ret

; step 11 of RunLinkSession6Exchange_FightInfoExSteps: branches on wLinkMessage; sets wScreenState
; to 2; sets wScreenStep to 0; sets wScreenSubStep to 0; calls BeginString_Bank07_Cat5; sets
; wLinkSendByte to $fe; sets wLinkSendByte to 0; advances wScreenStep; calls BeginString_Bank07_Cat5
; (E-0347)
; why: step 11 of RunLinkSession6Exchange_FightInfoExSteps (when wScreenStep = 11), in step 5 of
; RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when wTitleScreenSubState =
; 5), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in step 1 of
; RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the routine
; for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_YourPalRefusedThe_6::
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
    ld a, $1a ; 'Saving… Please wait.'
    call BeginString_Bank07_Cat5
    ret

; step 12 of RunLinkSession6Exchange_FightInfoExSteps: returns unless wTextFlags is 0; advances
; wScreenStep; copies wGoldLo to wWorkBuf; calls VerifySaveChecksum; copies wWorkBuf to wGoldLo;
; sets wGoldMid; sets wGoldHi; calls SaveGameToSRAMWithChecksum; sets wLinkSendByte to 5 (E-0347)
; why: step 12 of RunLinkSession6Exchange_FightInfoExSteps (when wScreenStep = 12), in step 5 of
; RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when wTitleScreenSubState =
; 5), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in step 1 of
; RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the routine
; for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_VerifySaveChecksum::
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

; step 13 of RunLinkSession6Exchange_FightInfoExSteps: returns unless wLinkMessage is $05; sets
; wLinkSendByte to 0; calls CopyBytes; calls SetArg5ToListEntriesCell5; copies the byte at
; wRandomSeed2Hi to wLinkReceivedByte; increments wScreenStep (E-0347)
; why: step 13 of RunLinkSession6Exchange_FightInfoExSteps (when wScreenStep = 13), in step 5 of
; RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when wTitleScreenSubState =
; 5), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in step 1 of
; RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the routine
; for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_SetArg5ToListEntriesCell5::
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

; step 14 of RunLinkSession6Exchange_FightInfoExSteps: increments wScreenStep; copies wRandomLo to
; wBattleSetupFlagsLo; copies wRandomHi to wBattleSetupFlagsHi; copies L to wLinkTimeoutLo; copies H
; to wLinkTimeoutHi; copies L to wLinkBufferPtrLo; copies H to wLinkBufferPtrHi; sets
; wLinkBufferCountLo to 2; sets wLinkBufferCountHi to 0; sets wLinkSendByte to $ff; sets wLinkReady
; to 1 (E-0347)
; why: step 14 of RunLinkSession6Exchange_FightInfoExSteps (when wScreenStep = 14), in step 5 of
; RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when wTitleScreenSubState =
; 5), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in step 1 of
; RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the routine
; for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_SetScreenStep::
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

; step 15 of RunLinkSession6Exchange_FightInfoExSteps: returns unless wLinkMessage is $f0; sets
; wLinkSendByte to 0; sets wLinkReady to 0; branches on wLinkRole; copies wRandomLo to
; wRandomSeed2Lo; copies wRandomHi to wRandomSeed2Hi; copies wRandomSeed2Lo to wRandomLo; copies
; wRandomSeed2Hi to wRandomHi; increments wScreenStep (E-0347)
; why: step 15 of RunLinkSession6Exchange_FightInfoExSteps (when wScreenStep = 15), in step 5 of
; RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when wTitleScreenSubState =
; 5), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in step 1 of
; RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the routine
; for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_SetLinkSendByte_8::
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

; step 16 of RunLinkSession6Exchange_FightInfoExSteps: increments wScreenStep; sets wLinkSendByte to
; $d2 (E-0347)
; why: step 16 of RunLinkSession6Exchange_FightInfoExSteps (when wScreenStep = 16), in step 5 of
; RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when wTitleScreenSubState =
; 5), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in step 1 of
; RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the routine
; for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_SetScreenStep_2::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $d2
    ld [wLinkSendByte], a
    ret

; step 17 of RunLinkSession6Exchange_FightInfoExSteps: returns unless wLinkMessage is $d2; sets
; wLinkSendByte to 0; sets wGameMode to 7; sets wModeState to 0; sets wWorldMapState to 0; sets
; wGameMode2Arg to 0; sets wModeChangeRequest to 1; sets wLinkSession to 7; sets wLinkExchangeState
; to 0; sets wLinkSendByte to 0; sets wLinkMessage to 0 (E-0347)
; why: step 17 of RunLinkSession6Exchange_FightInfoExSteps (when wScreenStep = 17), in step 5 of
; RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when wTitleScreenSubState =
; 5), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in step 1 of
; RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the routine
; for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_SetLinkSendByte_9::
    ld a, [wLinkMessage]
    cp $d2
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld a, $07
    ld [wGameMode], a
    xor a
    ld [wModeState], a
    ld [wWorldMapState], a
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

; step 6 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc: calls
; SwapMonstersMenu; returns unless wScreenStep is $0a; sets wScreenStep to 0; sets wScreenSubStep to
; 0; sets wScreenState (E-0347)
; why: step 6 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when
; wTitleScreenSubState = 6), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in
; step 1 of RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the
; routine for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_SwapMonstersMenu::
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

; step 13 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc: calls
; RunScreenStateWhenNotFading_F1; returns unless wScreenState is $0e; copies wItemGridX to
; wListCursor; copies wItemGridY to wListPageIndex (E-0347)
; why: step 13 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when
; wTitleScreenSubState = 13), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in
; step 1 of RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the
; routine for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_RunScreenStateWhenNotFading_F1::
    farcall RunScreenStateWhenNotFading_F1
    ld a, [wScreenState]
    cp $0e
    ret nz
    ld a, [wItemGridX]
    ld [wListCursor], a
    ld a, [wItemGridY]
    ld [wListPageIndex], a
    ret

; step 14 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc: dispatches on
; wScreenStep (E-0347)
; why: step 14 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when
; wTitleScreenSubState = 14), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in
; step 1 of RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the
; routine for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_ClearRecordPanelTilesSteps::
    ld a, [wScreenStep]
    jumptable
    dw RunLinkSession6Exchange_ClearRecordPanelTiles
    dw RunLinkSession6Exchange_AdvanceScreenStep_3
    dw RunLinkSession6Exchange_AdvanceScreenStep_3
    dw RunLinkSession6Exchange_SetArg5ToListEntriesCell5_2
    dw RunLinkSession6Exchange_ClearAndDrawListEntriesCell5NameAtTiles1780
    dw RunLinkSession6Exchange_RunFourTimes_2
    dw RunLinkSession6Exchange_FightInfoEx_2
    dw RunLinkSession6Exchange_SetSpriteHideTile

; step 0 of RunLinkSession6Exchange_ClearRecordPanelTilesSteps: calls ClearRecordPanelTiles; calls
; CopyRectTo20ByteRowsJp_Bank33; calls DrawPlayerNameAndString0Category1; copies L to
; wTextWindowTileLo; copies H to wTextWindowTileHi; copies L to wTextWindowRows; copies H to
; wTextWindowWidth; sets wStringCategory to 1; sets wStringIndex to 1; calls ShowString_Bank07;
; calls SetDefaultStringWindow_Bank33; increments wScreenStep (E-0347)
; why: step 0 of RunLinkSession6Exchange_ClearRecordPanelTilesSteps (when wScreenStep = 0), in step
; 14 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when
; wTitleScreenSubState = 14), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in
; step 1 of RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the
; routine for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_ClearRecordPanelTiles::
    farcall ClearRecordPanelTiles
    ld de, RunLinkSession6Exchange_FightInfoEx_TileRect
    ld hl, wWindowTileBuffer + $64
    lb bc, $0a, $0b
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

; step 1 of RunLinkSession6Exchange_ClearRecordPanelTilesSteps: advances wScreenStep (E-0347)
; why: step 1 of RunLinkSession6Exchange_ClearRecordPanelTilesSteps (when wScreenStep = 1), in step
; 14 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when
; wTitleScreenSubState = 14), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in
; step 1 of RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the
; routine for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_AdvanceScreenStep_3::
    ld hl, wScreenStep
    inc [hl]
    ret

; step 3 of RunLinkSession6Exchange_ClearRecordPanelTilesSteps: calls SetArg5ToListEntriesCell5;
; sets wArg1 to $c7; sets rRAMG2 to $0a; sets rRAMB to 0; calls LoadSRAMRecordByte; copies hTemp0 &
; $0f to wWorkBuf; calls LoadFamilyIconTileForWorkBuf; sets rRAMG2 to 0; calls
; CopyRectTo20ByteRowsJp_Bank33; sets wArg1; copies L to wArg2; copies H to wArg3; then 7 more steps
; (see the code) (E-0347)
; why: step 3 of RunLinkSession6Exchange_ClearRecordPanelTilesSteps (when wScreenStep = 3), in step
; 14 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when
; wTitleScreenSubState = 14), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in
; step 1 of RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the
; routine for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_SetArg5ToListEntriesCell5_2::
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
    ld de, RunLinkSession6Exchange_SetArg5ToListEntriesCell5_2_TileRect
    ld hl, wWindowTileBuffer + $140
    lb bc, $0d, $02
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
RunLinkSession6Exchange_SetArg5ToListEntriesCell5_2_TileRect::
    db $b6, $ea, $ed, $c3, $c3, $f8, $f9, $fa, $fb, $fc, $c3, $c7, $b7 ; id 0
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 1

; step 4 of RunLinkSession6Exchange_ClearRecordPanelTilesSteps: calls
; ClearAndDrawListEntriesCell5NameAtTiles1780 (E-0347)
; why: step 4 of RunLinkSession6Exchange_ClearRecordPanelTilesSteps (when wScreenStep = 4), in step
; 14 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when
; wTitleScreenSubState = 14), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in
; step 1 of RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the
; routine for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_ClearAndDrawListEntriesCell5NameAtTiles1780::
    farcall ClearAndDrawListEntriesCell5NameAtTiles1780
    ret

; step 5 of RunLinkSession6Exchange_ClearRecordPanelTilesSteps: calls CopyRectTo20ByteRowsJp_Bank33;
; calls RunFourTimes; calls CopyRectTo20ByteRowsJp_Bank33; calls RunFourTimes; copies L to
; wTextWindowTileLo; copies H to wTextWindowTileHi; copies L to wTextWindowRows; copies H to
; wTextWindowWidth; calls FillTilesFromRequest; calls CopyBytes; calls CopyGlyphTilesToVRAM;
; advances wScreenStep (E-0347)
; why: step 5 of RunLinkSession6Exchange_ClearRecordPanelTilesSteps (when wScreenStep = 5), in step
; 14 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when
; wTitleScreenSubState = 14), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in
; step 1 of RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the
; routine for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_RunFourTimes_2::
    ld de, RunLinkSession6Exchange_DrawPlayerNameAndString0Category1AndStep_TileRect_2
    ld hl, wWindowTileBuffer + $6e
    lb bc, $0a, $0b
    call CopyRectTo20ByteRowsJp_Bank33
    ld de, wKeyNameBuf
    ld hl, wWindowTileBuffer + $b1
    call RunFourTimes
    ld de, RunLinkSession6Exchange_FightInfoEx_TileRect
    ld hl, wWindowTileBuffer + $64
    lb bc, $0a, $0b
    call CopyRectTo20ByteRowsJp_Bank33
    ld de, wLinkPartnerName
    ld hl, wWindowTileBuffer + $a7
    call RunFourTimes
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

; step 6 of RunLinkSession6Exchange_ClearRecordPanelTilesSteps: copies L to wTextWindowTileLo;
; copies H to wTextWindowTileHi; copies L to wTextWindowRows; copies H to wTextWindowWidth; sets
; wStringCategory to 0; sets wStringIndex to $20; calls ShowString_Bank1B; calls
; CopyRectTo20ByteRowsJp_Bank33; calls CopyListEntriesCell5NameToTextBuf0_Bank33; calls
; SetDefaultStringWindow_Bank33; sets wTwoChoiceCursor to 1; increments wScreenStep (E-0347)
; why: step 6 of RunLinkSession6Exchange_ClearRecordPanelTilesSteps (when wScreenStep = 6), in step
; 14 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when
; wTitleScreenSubState = 14), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in
; step 1 of RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the
; routine for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_FightInfoEx_2::
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
    farcall ShowString_Bank1B
    ld de, RunLinkSession6Exchange_FightInfoEx_TileRect_2
    ld hl, wWindowTileBuffer + $e7
    lb bc, $09, $07
    call CopyRectTo20ByteRowsJp_Bank33
    call CopyListEntriesCell5NameToTextBuf0_Bank33
    call SetDefaultStringWindow_Bank33
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 7 of RunLinkSession6Exchange_ClearRecordPanelTilesSteps: calls BGMapAddressAtScroll_Bank33;
; calls DrawScreenBufferRectToBGMap_33; calls BGMapAddressAtScroll_Bank33; calls
; DrawScreenBufferRectToBGMap_33; sets hSpriteHideTile to $70; sets wScreenSubStep to 0; copies
; wReturnScreenState to wScreenState; copies wReturnScreenStep to wScreenStep; calls
; SetDefaultStringWindow_Bank33 (E-0347)
; why: step 7 of RunLinkSession6Exchange_ClearRecordPanelTilesSteps (when wScreenStep = 7), in step
; 14 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when
; wTitleScreenSubState = 14), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in
; step 1 of RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the
; routine for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_SetSpriteHideTile::
    call BGMapAddressAtScroll_Bank33
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_33
    call BGMapAddressAtScroll_Bank33
    ld de, $01a0
    add hl, de
    lb bc, $14, $05
    ld de, $0168
    call DrawScreenBufferRectToBGMap_33
    ld a, $70
    ldh [hSpriteHideTile], a
    xor a
    ld [wScreenSubStep], a
    ld a, [wReturnScreenState]
    ld [wScreenState], a
    ld a, [wReturnScreenStep]
    ld [wScreenStep], a
    call SetDefaultStringWindow_Bank33
    ret

; step 15 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc: dispatches on
; wScreenStep (E-0347)
; why: step 15 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when
; wTitleScreenSubState = 15), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in
; step 1 of RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the
; routine for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_ClearRecordPanelTilesSteps_2::
    ld a, [wScreenStep]
    jumptable
    dw RunLinkSession6Exchange_ClearRecordPanelTiles_2
    dw RunLinkSession6Exchange_ListAvailableRecordsForSelection_Bank33
    dw RunLinkSession6Exchange_DrawRecordListPageNames
    dw RunLinkSession6Exchange_CallDrawListEntriesCell5RecordPanel
    dw RunLinkSession6Exchange_CallClearAndDrawListEntriesCell5Name
    dw RunLinkSession6Exchange_CopyRectToWindowTileBufferRow5Col10AndIncScreenStep
    dw RunLinkSession6Exchange_InfoOKYesN_2
    dw RunLinkSession6Exchange_SetSpriteHideTile_2

; step 0 of RunLinkSession6Exchange_ClearRecordPanelTilesSteps_2: calls ClearRecordPanelTiles; calls
; CopyRectTo20ByteRowsJp_Bank33; calls StoreBAtWordTableEntry_Bank33; calls
; DrawPlayerNameAndString0Category1; increments wScreenStep (E-0347)
; why: step 0 of RunLinkSession6Exchange_ClearRecordPanelTilesSteps_2 (when wScreenStep = 0), in
; step 15 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when
; wTitleScreenSubState = 15), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in
; step 1 of RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the
; routine for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_ClearRecordPanelTiles_2::
    farcall ClearRecordPanelTiles
    ld de, RunLinkSession6Exchange_ClearRecordPanelTiles_2_TileRect
    ld hl, wWindowTileBuffer + $64
    lb bc, $08, $0b
    call CopyRectTo20ByteRowsJp_Bank33
    ld a, [wListCursor]
    ld b, $bc
    ld hl, RunLinkSession6Exchange_Data
    call StoreBAtWordTableEntry_Bank33
    call DrawPlayerNameAndString0Category1
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 3 of RunLinkSession6Exchange_ClearRecordPanelTilesSteps_2: calls
; CallDrawListEntriesCell5RecordPanel (E-0347)
; why: step 3 of RunLinkSession6Exchange_ClearRecordPanelTilesSteps_2 (when wScreenStep = 3), in
; step 15 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when
; wTitleScreenSubState = 15), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in
; step 1 of RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the
; routine for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_CallDrawListEntriesCell5RecordPanel::
    call CallDrawListEntriesCell5RecordPanel
    ret

; step 1 of RunLinkSession6Exchange_ClearRecordPanelTilesSteps_2: calls
; ListAvailableRecordsForSelection_Bank33; calls ClampRecordListPageCursor5; branches on wListPages;
; calls StoreC5BEC6AtHLStride2_Bank33; copies H to wArg1; copies L to wArg2; calls
; DrawPageOfPagesAtArg1_Bank1E; increments wScreenStep (E-0347)
; why: step 1 of RunLinkSession6Exchange_ClearRecordPanelTilesSteps_2 (when wScreenStep = 1), in
; step 15 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when
; wTitleScreenSubState = 15), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in
; step 1 of RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the
; routine for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_ListAvailableRecordsForSelection_Bank33::
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

; step 2 of RunLinkSession6Exchange_ClearRecordPanelTilesSteps_2: calls DrawRecordListPageNames;
; sets wArg1 to 0; calls MarkPartyMembersInRecordListPage (E-0347)
; why: step 2 of RunLinkSession6Exchange_ClearRecordPanelTilesSteps_2 (when wScreenStep = 2), in
; step 15 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when
; wTitleScreenSubState = 15), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in
; step 1 of RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the
; routine for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_DrawRecordListPageNames::
    farcall DrawRecordListPageNames
    xor a
    ld [wArg1], a
    farcall MarkPartyMembersInRecordListPage
    ret

; step 4 of RunLinkSession6Exchange_ClearRecordPanelTilesSteps_2: calls
; CallClearAndDrawListEntriesCell5Name (E-0347)
; why: step 4 of RunLinkSession6Exchange_ClearRecordPanelTilesSteps_2 (when wScreenStep = 4), in
; step 15 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when
; wTitleScreenSubState = 15), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in
; step 1 of RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the
; routine for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_CallClearAndDrawListEntriesCell5Name::
    call CallClearAndDrawListEntriesCell5Name
    ret

; step 5 of RunLinkSession6Exchange_ClearRecordPanelTilesSteps_2: calls
; CopyRectToWindowTileBufferRow5Col10AndIncScreenStep (E-0347)
; why: step 5 of RunLinkSession6Exchange_ClearRecordPanelTilesSteps_2 (when wScreenStep = 5), in
; step 15 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when
; wTitleScreenSubState = 15), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in
; step 1 of RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the
; routine for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_CopyRectToWindowTileBufferRow5Col10AndIncScreenStep::
    call CopyRectToWindowTileBufferRow5Col10AndIncScreenStep
    ret

; step 6 of RunLinkSession6Exchange_ClearRecordPanelTilesSteps_2: copies L to wTextWindowTileLo;
; copies H to wTextWindowTileHi; copies L to wTextWindowRows; copies H to wTextWindowWidth; sets
; wStringCategory to 0; sets wStringIndex to $1e; calls ShowString_Bank1B; calls
; CopyListEntriesCell5NameToTextBuf0_Bank33; calls SetDefaultStringWindow_Bank33; sets wStringIndex
; to $12; calls ShowString_Bank1B; calls RunFourTimes; then 3 more steps (see the code) (E-0347)
; why: step 6 of RunLinkSession6Exchange_ClearRecordPanelTilesSteps_2 (when wScreenStep = 6), in
; step 15 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when
; wTitleScreenSubState = 15), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in
; step 1 of RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the
; routine for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_InfoOKYesN_2::
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
    farcall ShowString_Bank1B
    call CopyListEntriesCell5NameToTextBuf0_Bank33
    call SetDefaultStringWindow_Bank33
    xor a
    ld a, $12
    ld [wStringIndex], a
    farcall ShowString_Bank1B
    ld de, wKeyNameBuf
    ld hl, wWindowTileBuffer + $b1
    call RunFourTimes
    ld de, RunLinkSession6Exchange_InfoOKYesN_TileRect
    ld hl, wWindowTileBuffer + $110
    lb bc, $08, $05
    call CopyRectTo20ByteRowsJp_Bank33
    xor a
    ld [wChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; step 7 of RunLinkSession6Exchange_ClearRecordPanelTilesSteps_2: calls BGMapAddressAtScroll_Bank33;
; calls DrawScreenBufferRectToBGMap_33; calls BGMapAddressAtScroll_Bank33; calls
; DrawScreenBufferRectToBGMap_33; sets hSpriteHideTile to $70; sets wScreenSubStep to 0; copies
; wReturnScreenState to wScreenState; copies wReturnScreenStep to wScreenStep; calls
; SetDefaultStringWindow_Bank33 (E-0347)
; why: step 7 of RunLinkSession6Exchange_ClearRecordPanelTilesSteps_2 (when wScreenStep = 7), in
; step 15 of RunLinkSession6Exchange_ReadTitleScreenStateAndTitleScreenSubStateEtc (when
; wTitleScreenSubState = 15), in a helper of RunLinkSession6Exchange_LinkReceiveStepWithBuffer, in
; step 1 of RunLinkSession6Exchange (when wLinkExchangeState = 1); RunLinkSession6Exchange: runs the
; routine for wLinkExchangeState (jump table of two) (E-0352, E-0122)
RunLinkSession6Exchange_SetSpriteHideTile_2::
    call BGMapAddressAtScroll_Bank33
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_33
    call BGMapAddressAtScroll_Bank33
    ld de, $01a0
    add hl, de
    lb bc, $14, $05
    ld de, $0168
    call DrawScreenBufferRectToBGMap_33
    ld a, $70
    ldh [hSpriteHideTile], a
    xor a
    ld [wScreenSubStep], a
    ld a, [wReturnScreenState]
    ld [wScreenState], a
    ld a, [wReturnScreenStep]
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

; copies box DrawBoxAndKeyRows_TileRect to wWindowTileBuffer + $110 and runs RunFourTimes for
; wKeyNameBuf at wWindowTileBuffer + $B1 (E-0126) (E-0344: the address in its name dropped or read
; as the label there; was DrawBoxAndKeyRows)
DrawBoxAndKeyRows::
    ld de, DrawBoxAndKeyRows_TileRect
    ld hl, wWindowTileBuffer + $110
    lb bc, $08, $05
    call CopyRectTo20ByteRowsJp_Bank33
    ld de, wKeyNameBuf
    ld hl, wWindowTileBuffer + $b1
    call RunFourTimes
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

; the same 16 bytes as ShowStringA10_Bank1B (ShowStringA10_Bank1B) (E-0063)
ShowStringA10_Bank33::
    add $10
    ld [wStringIndex], a
    xor a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank1B
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
; A, DE, HL (the same 16 bytes appear in 4 banks) (E-0351)
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
; clobbers A, DE (the same 41 bytes appear in 3 banks) (E-0351)
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
; (E-0127) (E-0340: the address in its name read as its RAM name; was
; WriteGoldDigitsToScreenTileBufferRow1Col14)
WriteGoldDigitsToScreenTileBufferRow1Col14::
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

; calls RunFourTimes_HLToDecimalDigits three times and falls into it once more (E-0122) (E-0344: the
; address in its name dropped or read as the label there; was RunFourTimes)
RunFourTimes::
    call RunFourTimes_HLToDecimalDigits
    call RunFourTimes_HLToDecimalDigits
    call RunFourTimes_HLToDecimalDigits

; called from RunFourTimes: calls HLToDecimalDigits (E-0347)
; why: a helper of RunFourTimes; RunFourTimes: calls RunFourTimes_HLToDecimalDigits three times and
; falls into it once more (E-0352, E-0122, E-0344)
RunFourTimes_HLToDecimalDigits::
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
; banks) (E-0351)
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
RunLinkSession6Exchange_DrawPlayerNameAndString0Category1AndStep_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $bf, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 2

; record: 10 x 11 tiles, one row per line
RunLinkSession6Exchange_DrawPlayerNameAndString0Category1AndStep_TileRect_2::
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

RunLinkSession6Exchange_FightInfoEx_TileRect::
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
DrawBoxAndKeyRows_TileRect::
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 0
    db $14, $15, $c3, $17, $ed, $c3, $c3, $b7 ; id 1
    db $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 2
    db $b7, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 3
    db $b5, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 4

RunLinkSession6Exchange_InfoOKYesN_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $70, $71, $72, $73, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $74, $75, $c3, $c3, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

RunLinkSession6Exchange_Data::
    db $79, $c3, $a1, $c3, $c9, $c3, $f1, $c3, $19, $c4

; record: 9 x 7 tiles, one row per line
RunLinkSession6Exchange_FightInfoEx_TileRect_2::
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
RunLinkSession6Exchange_ClearRecordPanelTiles_2_TileRect::
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

; ld de, this bank's string table / BeginStringDisplay (E-0344: the address in its name dropped or
; read as the label there; was BeginStringDisplay_Bank33)
BeginStringDisplay_Bank33::
    ld de, BeginStringDisplay_Bank33_StringCategories
    call BeginStringDisplay
    ret
    db $11, $a5, $64, $cd, $fe, $25, $c9

; BeginStringDisplay_Bank33 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; (E-0344: the address in its name dropped or read as the label there; was ShowString_Bank33)
ShowString_Bank33::
    call BeginStringDisplay_Bank33
    call RunStringDisplayToEnd
    ret

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
BeginStringDisplay_Bank33_StringCategories::
    dw StringList_Bank33_StringCategories_0 ; id 0

; category list of BeginStringDisplay_Bank33_StringCategories; one pointer per wStringIndex (E-0217)
; record: string
StringList_Bank33_StringCategories_0::
    dw Text_YouveFinishedThatClass ; id 0
    dw Text_YouveFinishedThatClass ; id 1
    dw Text_WhichClassWillYou ; id 2
    dw Text_TrainSomeMoreAnd ; id 3
    dw Text_LetMeConfirmThat ; id 4
    dw Text_GoodLuckIllCheer ; id 5
    dw Text_NotEnoughGoldFor ; id 6
    dw Text_OhTheCrowdWanted ; id 7
    dw Text_OhTheCrowdWanted ; id 8
    dw Text_OhTheCrowdWanted ; id 9
    dw Text_HowManyMastersIn ; id 10
    dw Text_WillYouTryA ; id 11
    dw Text_TheSClassShould ; id 12
    dw Text_TheAClassShould ; id 13
    dw Text_TheBClassShould ; id 14
    dw Text_ItCouldGetRough ; id 15
    dw Text_ItCouldGetRough_2 ; id 16
    dw Text_TheEClassShould ; id 17
    dw Text_IsClassOK ; id 18
    dw Text_IHopeYouDo ; id 19
    dw Text_YouNeedMoreGold ; id 20
    dw Text_YouCantTryThat ; id 21
    dw Text_YouCantTryThat ; id 22
    dw Text_LasSABCDENo ; id 23
    dw Text_BattlesCost ; id 24
    dw Text_INFOTESKLPA ; id 25
    dw Text_LasSABCDENo_2 ; id 26
    dw Text_CongratulationsYouDidIt ; id 27
    dw Text_CongratulationsYouDidIt ; id 28
    dw Text_CongratulationsYouDidIt ; id 29
    dw Text_CongratulationsYouDidIt ; id 30
    dw Text_CongratulationsYouDidIt ; id 31
    dw Text_CongratulationsYouDidIt ; id 32
    dw Text_CongratulationsYouDidIt_2 ; id 33
    dw Text_CongratulationsYouDidIt_3 ; id 34
    dw Text_CongratulationsYouDidIt_4 ; id 35
    dw Text_CongratulationsYouDidIt_5 ; id 36
    dw Text_TooBadYouDidnt ; id 37
    dw Text_TooBadYouDidnt_2 ; id 38
    dw Text_CongratulationsDoesItYouve ; id 39
    dw Text_YouLostThatsToo ; id 40
    dw Text_YouLostThatsToo ; id 41
    dw Text_ReceivedTheMagicKey ; id 42
    dw Text_OhButYourKey ; id 43
    dw Text_HeresTheMagicKey ; id 44
    dw Text_ReceivedThePirateKey ; id 45
    dw Text_HeresThePirateKey ; id 46
    dw Text_CongratulationsYouDidIt_6 ; id 47
    dw Text_DoYouWantThe ; id 48
    dw Text_DoYouWantThe_2 ; id 49
    dw Text_YourPrizeIsOne ; id 50
    dw Text_YourPrizeIsA ; id 51
    dw Text_OhButYouHave ; id 52
    dw Text_OhButYourKey_2 ; id 53
    dw BeginStringDisplay_Bank33_2 ; id 54

Text_YouveFinishedThatClass::
    db "<VOICE2>*: You've finished<LINE>"
    db "that Class.<WAIT>"
    db "@"

Text_WhichClassWillYou::
    db "<VOICE2>*: Which Class will<LINE>"
    db "you challenge?@"

Text_TrainSomeMoreAnd::
    db "<VOICE2>*: Train some more,<LINE>"
    db "and see you again!<WAIT>"
    db "@"

Text_LetMeConfirmThat::
    db "<VOICE2>*: Let me confirm<LINE>"
    db "that-the <BUF0> Class?@"

Text_GoodLuckIllCheer::
    db "<VOICE2>*: Good luck! I'll<LINE>"
    db "cheer for you!<WAIT>"
    db "@"

Text_NotEnoughGoldFor::
    db "<VOICE2>*: Not enough gold<LINE>"
    db "for that Class!<WAIT>"
    db "@"

Text_OhTheCrowdWanted::
    db "<VOICE2>*: Oh… The crowd<LINE>"
    db "wanted to see you…<WAIT>"
    db "@"

Text_HowManyMastersIn::
    db "<VOICE2>*: How many masters<LINE>"
    db "in the group?@"

Text_WillYouTryA::
    db "<VOICE2>*: Will you try a<LINE>"
    db "Master Battle?@"

Text_TheSClassShould::
    db "<VOICE2>*: The S Class<LINE>"
    db "should be good.<PROMPT>"
    db "<NEXT>Which Class will"
    db "<NEXT>you challenge?@"

Text_TheAClassShould::
    db "<VOICE2>*: The A Class<LINE>"
    db "should be good.<PROMPT>"
    db "<NEXT>Which Class will"
    db "<NEXT>you challenge?@"

Text_TheBClassShould::
    db "<VOICE2>*: The B Class<LINE>"
    db "should be good.<PROMPT>"
    db "<NEXT>Which Class will"
    db "<NEXT>you challenge?@"

Text_ItCouldGetRough::
    db "<VOICE2>*: It could get<LINE>"
    db "rough out there.<PROMPT>"
    db "<NEXT>Which Class will"
    db "<NEXT>you challenge?@"

Text_ItCouldGetRough_2::
    db "<VOICE2>*: It could get<LINE>"
    db "rough out there.<PROMPT>"
    db "<NEXT>Which Class will"
    db "<NEXT>you challenge?@"

Text_TheEClassShould::
    db "<VOICE2>*: The E Class<LINE>"
    db "should do.<PROMPT>"
    db "<NEXT>Which Class will"
    db "<NEXT>you challenge?@"

Text_IsClassOK::
    db "<VOICE2>*: Is <BUF0> Class OK?@"

Text_IHopeYouDo::
    db "<VOICE2>*: I hope you do<LINE>"
    db "well!<WAIT>"
    db "@"

Text_YouNeedMoreGold::
    db "<VOICE2>*: You need more<LINE>"
    db "gold to register.<WAIT>"
    db "@"

Text_YouCantTryThat::
    db "<VOICE2>*: You can't try<LINE>"
    db "that Class yet.<WAIT>"
    db "@"

Text_LasSABCDENo::
    db "lasSABCDE★No@"

Text_BattlesCost::
    db "Battles Cost@"

Text_INFOTESKLPA::
    db "INFOTESKLPA@"

Text_LasSABCDENo_2::
    db "lasSABCDE★No@"

Text_CongratulationsYouDidIt::
    db "<VOICE2>*: Congratulations!<LINE>"
    db "You did it!<PROMPT>"
    db "<NEXT>You've won the"
    db "<NEXT>Kids' Class!<PROMPT>"
    db "<NEXT>The King will give"
    db "<NEXT>you his official<PROMPT>"
    db "<NEXT>recognition as a"
    db "<NEXT>monster master.<PROMPT>"
    db "<NEXT>You can use the"
    db "<NEXT>Starry Shrine and<PROMPT>"
    db "<NEXT>the Egg Evaluator's"
    db "<NEXT>services now.<PROMPT>"
    db "<NEXT>You'll be facing"
    db "<NEXT>grownups here from<PROMPT>"
    db "<NEXT>now on, so keep"
    db "<NEXT>training hard.<PROMPT>"
    db "<NEXT>Here's your prize"
    db "<NEXT>-the Pirate Key!<WAIT>"
    db "@"

Text_CongratulationsYouDidIt_2::
    db "<VOICE2>*: Congratulations!<LINE>"
    db "You did it!<PROMPT>"
    db "<NEXT>You've won the"
    db "<NEXT>C Class!<PROMPT>"
    db "<NEXT>Here's your prize"
    db "<NEXT>-a  Magic Key!<WAIT>"
    db "@"

Text_CongratulationsYouDidIt_3::
    db "<VOICE2>*: Congratulations!<LINE>"
    db "You did it!<PROMPT>"
    db "<NEXT>You've won the"
    db "<NEXT>B Class!<PROMPT>"
    db "<NEXT>Here's your prize"
    db "<NEXT>-a  Magic Key!<WAIT>"
    db "@"

Text_CongratulationsYouDidIt_4::
    db "<VOICE2>*: Congratulations!<LINE>"
    db "You did it!<PROMPT>"
    db "<NEXT>You've won the"
    db "<NEXT>A Class!<PROMPT>"
    db "<NEXT>Here's your prize"
    db "<NEXT>-a  Magic Key!<WAIT>"
    db "@"

Text_CongratulationsYouDidIt_5::
    db "<VOICE2>*: Congratulations!<LINE>"
    db "You did it!<PROMPT>"
    db "<NEXT>You've finally won"
    db "<NEXT>the S Class!<PROMPT>"
    db "<NEXT>You can now choose"
    db "<NEXT>any Class you want<PROMPT>"
    db "<NEXT>by paying the"
    db "<NEXT>class entry fee.<PROMPT>"
    db "<NEXT>There are prizes"
    db "<NEXT>for winners too.<PROMPT>"
    db "<NEXT>Naturally, the"
    db "<NEXT>level of battling<PROMPT>"
    db "<NEXT>becomes much more"
    db "<NEXT>difficult.<PROMPT>"
    db "<NEXT>Plan and prepare"
    db "<NEXT>wisely!<WAIT>"
    db "@"

Text_TooBadYouDidnt::
    db "<VOICE2>*: Too bad you<LINE>"
    db "didn't make it.<PROMPT>"
    db "<NEXT>It's hard to win"
    db "<NEXT>if your monsters<PROMPT>"
    db "<NEXT>aren't leveled up"
    db "<NEXT>enough.<PROMPT>"
    db "<NEXT>I hope you do"
    db "<NEXT>better next time.<WAIT>"
    db "@"

Text_TooBadYouDidnt_2::
    db "<VOICE2>*: Too bad you<LINE>"
    db "didn't make it.<PROMPT>"
    db "<NEXT>You can create"
    db "<NEXT>tougher monsters<PROMPT>"
    db "<NEXT>by leveling up"
    db "<NEXT>those you bred.<PROMPT>"
    db "<NEXT>I hope you do"
    db "<NEXT>better next time.<WAIT>"
    db "@"

Text_CongratulationsDoesItYouve::
    db "<VOICE2>*: Congratulations!<LINE>"
    db "<BUF0> does it!<PROMPT>"
    db "<NEXT>You've won"
    db "<NEXT><BUF1>G!<PROMPT>"
    db "<NEXT>We hope you'll"
    db "<NEXT>battle here again!<WAIT>"
    db "@"

Text_YouLostThatsToo::
    db "<VOICE2>*: You lost?<LINE>"
    db "That's too bad.<PROMPT>"
    db "<NEXT>Try again after"
    db "<NEXT>leveling up your<PROMPT>"
    db "<NEXT>monsters some"
    db "<NEXT>more.<WAIT>"
    db "@"

Text_ReceivedTheMagicKey::
    db "<BUF0> received<LINE>"
    db "the Magic Key.<MUSIC_WAIT>", $58, "<WAIT>"
    db "<MAP_MUSIC>@"

Text_OhButYourKey::
    db "<VOICE2>*: …Oh, but your<LINE>"
    db "key ring is full.<PROMPT>"
    db "<NEXT>You'll have to"
    db "<NEXT>make room, and<PROMPT>"
    db "<NEXT>come back for this"
    db "<NEXT>later.<WAIT>"
    db "@"

Text_HeresTheMagicKey::
    db "<VOICE2>*: Here's the Magic<LINE>"
    db "Key you", $44, " won!<WAIT>"
    db "@"

Text_ReceivedThePirateKey::
    db "<BUF0> received<LINE>"
    db "the Pirate Key.<MUSIC_WAIT>", $58, "<WAIT>"
    db "<MAP_MUSIC>@"

Text_HeresThePirateKey::
    db "<VOICE2>*: Here's the Pirate<LINE>"
    db "Key you", $44, " won!<WAIT>"
    db "@"

Text_CongratulationsYouDidIt_6::
    db "<VOICE2>*: Congratulations!<LINE>"
    db "You did it!<PROMPT>"
    db "<NEXT>You've won the"
    db "<NEXT><BUF0> Class!<PROMPT>"
    db "<NEXT>Choose one of"
    db "<NEXT>these chests!<WAIT>"
    db "@"

Text_DoYouWantThe::
    db "<VOICE2>*: Do you want the<LINE>"
    db "left chest?@"

Text_DoYouWantThe_2::
    db "<VOICE2>*: Do you want the<LINE>"
    db "right chest?@"

Text_YourPrizeIsOne::
    db "<VOICE2>*: Your prize is<LINE>"
    db "one <BUF1>!<WAIT>"
    db "@"

Text_YourPrizeIsA::
    db "<VOICE2>*: Your prize is<LINE>"
    db "a Magic Key!<WAIT>"
    db "@"

Text_OhButYouHave::
    db "<VOICE2>*: …Oh, but you<LINE>"
    db "have no room.<PROMPT>"
    db "<NEXT>Well, instead of"
    db "<NEXT>the <BUF1>,<PROMPT>"
    db "<NEXT>here's 6000G."
    db "<NEXT><WAIT>"
    db "@"

Text_OhButYourKey_2::
    db "<VOICE2>*: …Oh, but your<LINE>"
    db "key ring is full.<PROMPT>"
    db "<NEXT>Well, instead of"
    db "<NEXT>the Magic Key,<PROMPT>"
    db "<NEXT>here's 6000G"
    db "<NEXT>instead.<WAIT>"
    db "@"

; ld de, this bank's string table / BeginStringDisplay (E-0344: the address in its name dropped or
; read as the label there; was BeginStringDisplay_Bank33_2)
BeginStringDisplay_Bank33_2::
    ld de, BeginStringDisplay_Bank33_2_StringCategories
    call BeginStringDisplay
    ret
    db $11, $4c, $70, $cd, $fe, $25, $c9

; BeginStringDisplay_Bank33_2 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; (E-0344: the address in its name dropped or read as the label there; was ShowString_Bank33_2)
ShowString_Bank33_2::
    call BeginStringDisplay_Bank33_2
    call RunStringDisplayToEnd
    ret

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
BeginStringDisplay_Bank33_2_StringCategories::
    dw StringList_Bank33_2_StringCategories_0 ; id 0

; category list of BeginStringDisplay_Bank33_2_StringCategories; one pointer per wStringIndex
; (E-0217)
; record: string
StringList_Bank33_2_StringCategories_0::
    dw Text_ItEndsInA ; id 0
    dw Text_CongratulationsYouveWon ; id 1
    dw Text_TooBadYouveLost ; id 2
    dw Text_TurnedOver ; id 3
    dw Text_Received ; id 4
    dw Text_ButYouHaveNo ; id 5
    dw Text_GaveUpOnGetting ; id 6
    dw Text_SwitchWithWhich ; id 7
    dw Text_SwitchWithWhich_2 ; id 8
    dw Text_SwitchWhichEgg ; id 9
    dw Text_WasReleased ; id 10
    dw Text_MonsterEG ; id 11
    dw Text_YesNo ; id 12
    dw Text_InfoOKYesN_2 ; id 13
    dw Text_ThereAreNoEggs ; id 14
    dw Text_ThereAreNoEggs ; id 15
    dw Text_ThereAreNoEggs ; id 16
    dw Text_ThereAreNoEggs ; id 17
    dw Text_YoullBeLeftWith ; id 18

Text_ItEndsInA::
    db "It ends in a draw!<PROMPT>"
    db "@"

Text_CongratulationsYouveWon::
    db "Congratulations!<LINE>"
    db "You've won!<PROMPT>"
    db "@"

Text_TooBadYouveLost::
    db "Too bad!<LINE>"
    db "You've lost!<PROMPT>"
    db "@"

Text_TurnedOver::
    db "Turned over<LINE>"
    db "<BUF0>…<PROMPT>"
    db "@"

Text_Received::
    db "Received<LINE>"
    db "<BUF0><PROMPT>"
    db "@"

Text_ButYouHaveNo::
    db "But you have no<LINE>"
    db "room for it…<PROMPT>"
    db "<NEXT>Switch it with"
    db "<NEXT>another monster?@"

Text_GaveUpOnGetting::
    db "Gave up on getting<LINE>"
    db "<BUF0> and released<PROMPT>"
    db "<NEXT>it in the wild…<PROMPT>"
    db "@"

Text_SwitchWithWhich::
    db "Switch with which?@"

Text_SwitchWithWhich_2::
    db "Switch with which?@"

Text_SwitchWhichEgg::
    db "Switch which egg?@"

Text_WasReleased::
    db "<BUF0><LINE>"
    db "was released.<PROMPT>"
    db "@"

Text_MonsterEG::
    db "MonsterE?g@"

Text_YesNo::
    db "YesNo@"

Text_InfoOKYesN_2::
    db "InfoOKYesN@"

Text_ThereAreNoEggs::
    db "There are no eggs.@"

Text_YoullBeLeftWith::
    db "You'll be left<LINE>"
    db "with no monster.@"
    ds $e10, $00
