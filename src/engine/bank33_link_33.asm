; ROM bank $33: link sessions; strings
; The annotated listing of this bank is build/listing/bank33.asm.

SECTION "Bank 33", ROMX
    db $33

; E = block number of ScreenBlockTable (D is overwritten with 0 and ignored). The record is a word
; offset into wScreenTileBuffer, a width B, a row count C and then B * C tile bytes; the tiles are
; copied to wScreenTileBuffer + offset one row at a time with 32 bytes from row to row, and the
; other bytes of the buffer are not touched. Far-called by the pause menu (bank $03) and the screens
; of bank $F1 to compose a screen from blocks. (C2, E-0380)
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

SECTION "Bank 33 CopyBlockToTileBufferBlankingText", ROMX

; E = block number of ScreenBlockTable (D is overwritten with 0 and ignored): like
; CopyBlockToTileBuffer, but every tile from $15 to $A3 (the text glyphs) is written as the blank
; tile $C3; tiles below $15 and from $A4 up are copied unchanged. Far-called by the pause menu (bank
; $03). (C2, E-0380)
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

SECTION "Bank 33 ScreenBlockTable", ROMX

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

; Game mode 5, state 5 frame: exchanges the joypad over the link and, on the link screens, draws the
; monster sprites (in screen state $0C the list entry's or the party's at steps $15/$20, in state
; $0D the partner's monster's). (C1, E-0357)
ExchangeJoypadAndDrawMonsters::
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
    jr z, .call_draw_list_entries_cell5_pedigree_sprites
    cp $15
    jr z, .call_draw_list_entries_cell5_species_sprite
    ret

.call_draw_list_entries_cell5_species_sprite:
    farcall DrawListEntriesCell5SpeciesSprite
    ret

.call_draw_list_entries_cell5_pedigree_sprites:
    farcall DrawListEntriesCell5PedigreeSprites
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

SECTION "Bank 33 TeamMode_Screen", ROMX

; Link session 6's screen (Team Mode): before the menu starts, the fee steps by
; wTitleScreenSubState; afterwards, once no fade runs, the screen states (waiting, the list, the
; info screens, the swap menu and the record panels). (C1, E-0357)
TeamMode_Screen::
    ld a, [wTitleScreenState]
    or a
    jr nz, .check_fade_state
    ld a, [wTitleScreenSubState]
    jumptable
    dw TeamMode_Screen_DrawFrameAndName
    dw RunLinkSession6Exchange_DrawTeamGold
    dw TeamMode_Screen_ShowForTeamMode1Hero
    dw TeamMode_Screen_ShowYourPalRefusedThe
    dw TeamMode_PayFee
    dw TeamMode_Screen_StartChoosing
    dw RunLinkSession6Exchange_ChooseTeamMonster
    dw TeamMode_Screen_ShowYouRefusedToPay
    dw TeamMode_BackToChoose
    dw TeamMode_WaitPartner
    dw TeamMode_Screen_QuitUnpaid
    dw TeamMode_Screen_ShowYourPalRefusedTo
    dw TeamMode_ReturnToChoice
    dw TeamMode_GiveUp

.check_fade_state:
    ld a, [wFadeState]
    or a
    ret nz
    ld a, [wScreenState]
    jumptable
    dw TeamMode_Screen_Start
    dw TeamMode_Screen_GoToPickAfterText
    dw TeamMode_Screen_Leave
    dw TeamMode_Screen_StartPick
    dw RunLinkSession6Exchange_Pick
    dw RunLinkSession6Exchange_FightInfo
    dw RunLinkSession6Exchange_RunStatsScreen
    dw RunLinkSession6Exchange_RunStatsScreen
    dw RunLinkSession6Exchange_RunStatsScreen
    dw RunLinkSession6Exchange_RunStatsScreen
    dw RunLinkSession6Exchange_RunStatsScreen
    dw RunLinkSession6Exchange_RunStatsScreen
    dw RunLinkSession6Exchange_RunStatsScreen
    dw RunLinkSession6Exchange_RunRecordScreens
    dw RunLinkSession6Exchange_BackFromStats
    dw RunLinkSession6Exchange_BackFromOwnStats

; Team Mode fee step 0 (wTitleScreenSubState 0 of TeamMode_Screen): copies the 8 x 3 tile rectangle
; TeamModeGoldBox_TileRect to wScreenTileBuffer + $C and the 10 x 11 frame
; PlayerWinLossWindow_TileRect to wScreenTileBuffer (CopyRectTo20ByteRowsJp_Bank33), draws the
; player's name and string 0 of category 1 (DrawPlayerNameAndString0Category1), sets the default
; string window and moves to step 1 (RunLinkSession6Exchange_DrawTeamGold). (C1, E-0372)
TeamMode_Screen_DrawFrameAndName::
    ld de, TeamModeGoldBox_TileRect
    ld hl, wScreenTileBuffer + $c
    lb bc, $08, $03
    call CopyRectTo20ByteRowsJp_Bank33
    ld de, PlayerWinLossWindow_TileRect
    ld hl, wScreenTileBuffer
    lb bc, $0a, $0b
    call CopyRectTo20ByteRowsJp_Bank33
    call DrawPlayerNameAndString0Category1
    call SetDefaultStringWindow_Bank33
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

SECTION "Bank 33 RunLinkSession6Exchange_DrawTeamGold", ROMX

; Team Mode, step 1: draws the gold and four numbers into the screen buffer and copies it to the BG
; map. (C1, E-0357)
RunLinkSession6Exchange_DrawTeamGold::
    xor a
    ld [wLinkSendByte], a
    call WriteGoldDigitsToScreenTileBufferRow1Col14
    ld de, wKeyNameBuf
    ld hl, wScreenTileBuffer + $43
    call DrawFourTwoDigitNumbers
    call BGMapAddressAtScroll_Bank33
    lb bc, $14, $0d
    ld de, $0000
    call DrawScreenBufferRectToBGMap_33
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

SECTION "Bank 33 TeamMode_Screen_ShowForTeamMode1Hero", ROMX

; Team Mode, step 2: after the fade 'For Team Mode, 1000G is charged.' (category 5, string $19).
; (C1, E-0357)
TeamMode_Screen_ShowForTeamMode1Hero::
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

SECTION "Bank 33 TeamMode_Screen_ShowYourPalRefusedThe", ROMX

; Team Mode, step 3: the partner's refusal ($FE) gives 'Your pal refused the Team Mode.' ($0A); this
; side's no gives 'You refused the Team Mode.' ($09); otherwise below 1000 gold 'Not enough money.
; Please wait.' (string 0) and sends $10; with enough pays 1000 gold, 'Please wait.' and sends 1.
; (C1, E-0357)
TeamMode_Screen_ShowYourPalRefusedThe::
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

SECTION "Bank 33 TeamMode_PayFee", ROMX

; Team Mode, step 4: the partner's refusal as above; the partner's 1 gives 'You paid the 1000G
; battle fee.' (string 7); its $10 gives "Your pal doesn't have enough gold." (string 1) and the
; offer to pay for both (three steps on). (C1, E-0357)
TeamMode_PayFee::
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

SECTION "Bank 33 TeamMode_Screen_StartChoosing", ROMX

; Team Mode fee step 5: clears wLinkSendByte and wLinkScreenFlag and moves to step 6
; (RunLinkSession6Exchange_ChooseTeamMonster, whose steps wLinkScreenFlag picks). Reached after 'You
; paid the 1000G battle fee.' (TeamMode_PayFee) and from TeamMode_ReturnToChoice, which sets step 5
; directly. (C2, E-0372; probed E-0380)
TeamMode_Screen_StartChoosing::
    xor a
    ld [wLinkSendByte], a
    ld hl, wTitleScreenSubState
    inc [hl]
    xor a
    ld [wLinkScreenFlag], a
    ret

SECTION "Bank 33 RunLinkSession6Exchange_ChooseTeamMonster", ROMX

; Step 6 of TeamMode_Screen (wTitleScreenSubState, wTitleScreenState 0), 'Choose a monster for the
; Team Mode.': runs the case of wLinkScreenFlag, 0 RunLinkSession6Exchange_ChooseTeamMonster_Clear,
; 1 RunLinkSession6Exchange_ShowChooseAMonsterFor, 2
; RunLinkSession6Exchange_ChooseTeamMonster_Finish. (C1, E-0380)
; by its step: 'Choose a monster for the Team ...'
RunLinkSession6Exchange_ChooseTeamMonster::
    ld a, [wLinkScreenFlag]
    jumptable
    dw RunLinkSession6Exchange_ChooseTeamMonster_Clear
    dw RunLinkSession6Exchange_ShowChooseAMonsterFor
    dw RunLinkSession6Exchange_ChooseTeamMonster_Finish

; Step 0 of RunLinkSession6Exchange_ChooseTeamMonster (wLinkScreenFlag 0): once wTextFlags is clear,
; fills the $104 bytes from wScreenTileBuffer with blank tile $C3 and sets wLinkScreenFlag to 1
; (RunLinkSession6Exchange_ShowChooseAMonsterFor). (C2, E-0372; probed E-0380)
RunLinkSession6Exchange_ChooseTeamMonster_Clear::
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

SECTION "Bank 33 RunLinkSession6Exchange_ShowChooseAMonsterFor", ROMX

; Choosing the team monster, step 1: draws it and 'Choose a monster for the Team ...' (string 8).
; (C1, E-0357)
RunLinkSession6Exchange_ShowChooseAMonsterFor::
    call BGMapAddressAtScroll_Bank33
    lb bc, $14, $0d
    ld de, $0000
    call DrawScreenBufferRectToBGMap_33
    ld a, $08 ; 'Choose a monster for the Team'
    call BeginString_Bank07_Cat5
    ld hl, wLinkScreenFlag
    inc [hl]
    ret

SECTION "Bank 33 RunLinkSession6Exchange_ChooseTeamMonster_Finish", ROMX

; Step 2 of RunLinkSession6Exchange_ChooseTeamMonster (wLinkScreenFlag 2): clears
; wTitleScreenSubState and wLinkScreenFlag, sets wTitleScreenState to 1 and wScreenState to 0, so
; TeamMode_Screen now runs its screen-state table from TeamMode_Screen_AdvanceScreenState_2 (state
; 0) toward the pick list (RunLinkSession6Exchange_Pick, state 4). (C2, E-0372; probed E-0380)
RunLinkSession6Exchange_ChooseTeamMonster_Finish::
    xor a
    ld [wTitleScreenSubState], a
    xor a
    ld [wLinkScreenFlag], a
    ld a, $01
    ld [wTitleScreenState], a
    xor a
    ld [wScreenState], a
    ret

SECTION "Bank 33 TeamMode_Screen_ShowYouRefusedToPay", ROMX

; Team Mode, step 7 (paying for both): no gives 'You refused to pay the battle ...' (string 5, sends
; $40); below 1000 gold 'Insufficient gold for Team Mode.' (string 4, sends $30); otherwise pays
; 1000 more, 'You paid for both combatants.' (string 2, sends $20). (C1, E-0357)
TeamMode_Screen_ShowYouRefusedToPay::
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

SECTION "Bank 33 TeamMode_BackToChoose", ROMX

; Team Mode, step 8: the partner's refusal ends; on its $20 goes back two steps (to choosing the
; monster). (C1, E-0357)
TeamMode_BackToChoose::
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

SECTION "Bank 33 TeamMode_WaitPartner", ROMX

; Team Mode, step 9: the partner's refusal ends; on its $30 or $40 goes on. (C1, E-0357)
TeamMode_WaitPartner::
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

SECTION "Bank 33 TeamMode_Screen_QuitUnpaid", ROMX

; Team Mode fee step 10: sends $FE (wLinkSendByte), sets wTitleScreenState to 1, clears
; wTitleScreenSubState and sets wScreenState to 2 (TeamMode_Screen_Leave). Reached from
; TeamMode_WaitPartner (step 9) when the partner answers $30 or $40, after this side could not or
; would not pay for both ('Insufficient gold for Team Mode.' / 'You refused to pay the battle ...').
; (C2, E-0372; probed E-0380)
TeamMode_Screen_QuitUnpaid::
    ld a, $fe
    ld [wLinkSendByte], a
    ld a, $01
    ld [wTitleScreenState], a
    xor a
    ld [wTitleScreenSubState], a
    ld a, $02
    ld [wScreenState], a
    ret

SECTION "Bank 33 TeamMode_Screen_ShowYourPalRefusedTo", ROMX

; Team Mode, step 11 (waiting for the partner who pays): its $10 or $30 gives 'Insufficient gold for
; Team Mode.', $20 'Your pal paid your battle fee.' (string 3), $40 'Your pal refused to pay the
; ...' (string 6), echoing the byte. (C1, E-0357)
TeamMode_Screen_ShowYourPalRefusedTo::
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

SECTION "Bank 33 TeamMode_ReturnToChoice", ROMX

; Team Mode, step 12: the partner's refusal ends; 0 or $20 returns to step 5. (C1, E-0357)
TeamMode_ReturnToChoice::
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

SECTION "Bank 33 TeamMode_GiveUp", ROMX

; Team Mode, step 13: on the partner's $10, $30, $40 or $FE gives up (sends $FE, screen state 2).
; (C2, E-0357; probed E-0380)
TeamMode_GiveUp::
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

SECTION "Bank 33 BeginString_Bank07_Cat5", ROMX

; A = string index: stores A in wStringIndex and 5 in wStringCategory, then far-calls
; BeginStringDisplay_Bank07, which starts printing that string. Category 5 of the bank $07 table
; holds the Team Mode and fee messages ('Please wait.' is index $0C, 'Your pal refused the Team
; Mode.' index $0A). Called by the Team Mode steps of this bank. (C1, E-0380)
; A = string index: wStringIndex = A, wStringCategory = 5, then BeginStringDisplay_Bank07
BeginString_Bank07_Cat5::
    ld [wStringIndex], a
    ld a, $05
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank07
    ret

SECTION "Bank 33 TeamMode_Screen_Start", ROMX

; Team Mode screen state 0 (wScreenState 0 of TeamMode_Screen, set by
; RunLinkSession6Exchange_ChooseTeamMonster_Finish): moves to state 1
; (TeamMode_Screen_GoToPickAfterText). (C2, E-0372; probed E-0380)
TeamMode_Screen_Start::
    ld hl, wScreenState
    inc [hl]
    ret

SECTION "Bank 33 TeamMode_Screen_GoToPickAfterText", ROMX

; Team Mode screen state 1: once wTextFlags is clear, adds 2 to wScreenState, passing over state 2
; (TeamMode_Screen_Leave) to state 3 (TeamMode_Screen_StartPick), which leads to the pick list. (C2,
; E-0372; probed E-0380)
TeamMode_Screen_GoToPickAfterText::
    ld a, [wTextFlags]
    and a
    ret nz
    ld hl, wScreenState
    inc [hl]
    inc [hl]
    ret

SECTION "Bank 33 TeamMode_Screen_Leave", ROMX

; Session 6, screen state 2 (leaving): its five waiting steps. (C1, E-0357)
TeamMode_Screen_Leave::
    ld a, [wScreenStep]
    jumptable
    dw TeamMode_Screen_Leave_OnPartnerQuit
    dw TeamMode_Screen_Leave_ShowPleaseWait
    dw TeamMode_Screen_Leave_SendReady
    dw TeamMode_Screen_Leave_OnPartnerReady
    dw TeamMode_Screen_Leave_ExitToTitleMenu

; Step 0 of TeamMode_Screen_Leave (wScreenStep 0): waits until the partner's wLinkMessage is $FE
; (its quit byte), then clears wLinkSendByte and moves to step 1
; (TeamMode_Screen_Leave_ShowPleaseWait). (C2, E-0372; probed E-0380)
TeamMode_Screen_Leave_OnPartnerQuit::
    ld a, [wLinkMessage]
    cp $fe
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

SECTION "Bank 33 TeamMode_Screen_Leave_ShowPleaseWait", ROMX

; Leaving, step 1: after the text 'Please wait.'. (C1, E-0357)
TeamMode_Screen_Leave_ShowPleaseWait::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, $0c ; 'Please wait.'
    call ShowStringA10_Bank33
    ld hl, wScreenStep
    inc [hl]
    ret

SECTION "Bank 33 TeamMode_Screen_Leave_SendReady", ROMX

; Step 2 of TeamMode_Screen_Leave: once wTextFlags is clear (after 'Please wait.'), sends 1
; (wLinkSendByte) and moves to step 3. (C2, E-0372; probed E-0380)
TeamMode_Screen_Leave_SendReady::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wScreenStep
    inc [hl]
    ret

SECTION "Bank 33 TeamMode_Screen_Leave_OnPartnerReady", ROMX

; Step 3 of TeamMode_Screen_Leave: waits until the partner's wLinkMessage is 1, then clears
; wLinkSendByte and moves to step 4. (C2, E-0372; probed E-0380)
TeamMode_Screen_Leave_OnPartnerReady::
    ld a, [wLinkMessage]
    cp $01
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld hl, wScreenStep
    inc [hl]
    ret

SECTION "Bank 33 TeamMode_Screen_Leave_ExitToTitleMenu", ROMX

; Step 4 of TeamMode_Screen_Leave: once wTextFlags bit 0 is clear, zeroes the $6F bytes from
; wScreenState, then writes wGameMode = 5, wModeState = 1, wWorldMapState = 0, wGameMode2Arg = 0 and
; increments wModeChangeRequest, so the main loop restarts game mode 5 at GameMode5_Init entry 1
; (GameMode5_Init_TitleMenu). (C2, E-0372; probed E-0380)
TeamMode_Screen_Leave_ExitToTitleMenu::
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

SECTION "Bank 33 TeamMode_Screen_StartPick", ROMX

; Team Mode screen state 3: moves to state 4 (RunLinkSession6Exchange_Pick, the team pick list).
; (C2, E-0372; probed E-0380)
TeamMode_Screen_StartPick::
    ld hl, wScreenState
    inc [hl]
    ret

SECTION "Bank 33 RunLinkSession6Exchange_Pick", ROMX

; Session 6, screen state 4 (picking the team monster): sixteen steps: the list, the panel, the
; cursor, 'Info / OK', waiting and the record exchange. (C1, E-0357)
RunLinkSession6Exchange_Pick::
    ld a, [wScreenStep]
    jumptable
    dw RunLinkSession6Exchange_Pick_RunList
    dw RunLinkSession6Exchange_Pick_RunList
    dw RunLinkSession6Exchange_Pick_ListMonsters
    dw RunLinkSession6Exchange_Pick_RunList
    dw CallDrawListEntriesCell5RecordPanel
    dw CallClearAndDrawListEntriesCell5Name
    dw RunLinkSession6Exchange_DrawInfoWindow
    dw RunLinkSession6Exchange_Pick_MarkCursor
    dw RunLinkSession6Exchange_Pick_ShowYourPalRefusedThe
    dw RunLinkSession6Exchange_Pick_ShowInfoOKYesN
    dw RunLinkSession6Exchange_Pick_InfoOKChoice
    dw RunLinkSession6Exchange_Pick_ShowChooseAMonsterFor
    dw RunLinkSession6Exchange_Pick_ShowPleaseWait
    dw RunLinkSession6Exchange_Pick_CopyRecord
    dw RunLinkSession6Exchange_Pick_StartExchange
    dw RunLinkSession6Exchange_Pick_EndExchange

; Picking, steps 0, 1 and 3: after the text the list's steps (BreedMenu). (C1, E-0357)
RunLinkSession6Exchange_Pick_RunList::
    ld a, [wTextFlags]
    and a
    ret nz
    farcall BreedMenu
    ret

SECTION "Bank 33 RunLinkSession6Exchange_Pick_ListMonsters", ROMX

; Picking, step 2: lists the monsters that may be picked and draws the page indicator. (C1, E-0357)
RunLinkSession6Exchange_Pick_ListMonsters::
    farcall DrawRecordListPageIndicators_1B
    ret

SECTION "Bank 33 CallDrawListEntriesCell5RecordPanel", ROMX

; Far-calls DrawListEntriesCell5RecordPanel (bank $1B), which draws the family icon, level and sex
; mark of the record under the list cursor into the record panel and adds 1 to wScreenStep. It is
; step 4 of RunLinkSession6Exchange_Pick (picked by wScreenStep) and is also called by
; RunLinkSession6Exchange_BackFromOwnStats_DrawPanel. (C1, E-0380)
; far-calls DrawListEntriesCell5RecordPanel (E-0122)
CallDrawListEntriesCell5RecordPanel::
    farcall DrawListEntriesCell5RecordPanel
    ret

SECTION "Bank 33 CallClearAndDrawListEntriesCell5Name", ROMX

; Far-calls ClearAndDrawListEntriesCell5NameAtTiles1780 (bank $1B), which blanks 5 tiles at vTiles1
; + $780, draws the name of the record under the list cursor there and adds 1 to wScreenStep. It is
; step 5 of RunLinkSession6Exchange_Pick and is also called by
; RunLinkSession6Exchange_BackFromOwnStats_DrawName. (C1, E-0380)
; far-calls ClearAndDrawListEntriesCell5NameAtTiles1780 (E-0122)
CallClearAndDrawListEntriesCell5Name::
    farcall ClearAndDrawListEntriesCell5NameAtTiles1780
    ret

SECTION "Bank 33 RunLinkSession6Exchange_DrawInfoWindow", ROMX

; Copies the 10 x 11 info window PlayerWinLossWindow_TileRect (a name row of tiles $00-$04 over four
; labelled number rows) to wWindowTileBuffer + $6E (row 5, column 10) with
; CopyRectTo20ByteRowsJp_Bank33, then wScreenStep += 1. It is step 6 of RunLinkSession6Exchange_Pick
; (wScreenStep) and is called by RunLinkSession6Exchange_BackFromOwnStats_DrawInfo;
; RunLinkSession6Exchange_Pick_MarkCursor then writes the four numbers into it from wKeyNameBuf.
; (C2, E-0372; probed E-0380)
; copies the 10 x 11 rectangle PlayerWinLossWindow_TileRect into wWindowTileBuffer + $6E
; (CopyRectTo20ByteRowsJp_Bank33), then wScreenStep += 1 (E-0119) (E-0340: the address in its name
; read as its RAM name; was RunLinkSession6Exchange_DrawInfoWindow) (E-0344: the address in its name
; dropped or read as the label there; was RunLinkSession6Exchange_DrawInfoWindow)
RunLinkSession6Exchange_DrawInfoWindow::
    ld de, PlayerWinLossWindow_TileRect
    ld hl, wWindowTileBuffer + $6e
    lb bc, $0a, $0b
    call CopyRectTo20ByteRowsJp_Bank33
    ld hl, wScreenStep
    inc [hl]
    ret

SECTION "Bank 33 RunLinkSession6Exchange_Pick_MarkCursor", ROMX

; Picking, step 7: after the text marks the cursor, draws four numbers into the window and redraws,
; then clears the mark. (C1, E-0357)
RunLinkSession6Exchange_Pick_MarkCursor::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wListCursor]
    ld b, $bb
    ld hl, RunLinkSession6Exchange_Pick_MarkCursor_Data
    call StoreBAtWordTableEntry_Bank33
    ld de, wKeyNameBuf
    ld hl, wWindowTileBuffer + $b1
    call DrawFourTwoDigitNumbers
    call BGMapAddressAtScroll_Bank33
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_33
    ld a, [wListCursor]
    ld b, $c3
    ld hl, RunLinkSession6Exchange_Pick_MarkCursor_Data
    call StoreBAtWordTableEntry_Bank33
    call SetDefaultStringWindow_Bank33
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

SECTION "Bank 33 RunLinkSession6Exchange_Pick_ShowYourPalRefusedThe", ROMX

; Picking, step 8: the partner's refusal gives 'Your pal refused the Team Mode.' (to leaving); the
; list cursor: a page change back seven steps, $FD back four, B 'You refused the Team Mode.' (to
; leaving), A records the pick, marks it and asks 'Pick <name> for the team?' (bank-$1B string 2).
; (C1, E-0357)
RunLinkSession6Exchange_Pick_ShowYourPalRefusedThe::
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
    ld hl, RunLinkSession6Exchange_Pick_MarkCursor_Data
    call StoreBAtWordTableEntry_Bank33
    call CopyListEntriesCell5NameToTextBuf0_Bank33
    ld hl, wScreenStep
    inc [hl]
    ld a, $02 ; 'Pick 0 for the team?'
    call ShowStringA10_Bank33
    ret

SECTION "Bank 33 RunLinkSession6Exchange_Pick_ShowInfoOKYesN", ROMX

; Picking, step 9: after the text shows 'Info / OK' (bank-$1B string $1E) with sound $6C in its 8 x
; 5 box. (C1, E-0357)
RunLinkSession6Exchange_Pick_ShowInfoOKYesN::
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
    ld de, InfoOKBox_TileRect
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

SECTION "Bank 33 RunLinkSession6Exchange_Pick_InfoOKChoice", ROMX

; Picking, step 10: the partner's refusal as before; the Info / OK choice: B goes on; Info opens the
; stats screen (state $0C); OK records the pick and goes on two steps. (C1, E-0357)
RunLinkSession6Exchange_Pick_InfoOKChoice::
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

SECTION "Bank 33 RunLinkSession6Exchange_Pick_ShowChooseAMonsterFor", ROMX

; Picking, step 11: clears the five marks, redraws and asks 'Choose a monster for the Team ...'
; again (three steps back). (C1, E-0357)
RunLinkSession6Exchange_Pick_ShowChooseAMonsterFor::
    ld a, [wTextFlags]
    and a
    ret nz
    ld c, $05
    ld hl, RunLinkSession6Exchange_Pick_MarkCursor_Data
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

SECTION "Bank 33 RunLinkSession6Exchange_Pick_ShowPleaseWait", ROMX

; Picking, step 12: redraws, counts the pick, 'Please wait.' and finishes the picks
; (FinishPickedRecordsEntryAndStep_33). (C1, E-0357)
RunLinkSession6Exchange_Pick_ShowPleaseWait::
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

SECTION "Bank 33 RunLinkSession6Exchange_Pick_CopyRecord", ROMX

; Picking, step 13: copies the picked SRAM record into wRecordBufA for the exchange (into
; wRecordBufB), clears the link scene and sends 1. (C2, E-0357; probed E-0380)
RunLinkSession6Exchange_Pick_CopyRecord::
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

SECTION "Bank 33 RunLinkSession6Exchange_Pick_StartExchange", ROMX

; Picking, step 14: on the partner's 1 starts the $A5-byte record exchange; on $FE 'Your pal refused
; the Team Mode.'. (C1, E-0357)
RunLinkSession6Exchange_Pick_StartExchange::
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

SECTION "Bank 33 RunLinkSession6Exchange_Pick_EndExchange", ROMX

; Step 15 of RunLinkSession6Exchange_Pick: waits for wLinkMessage $F0 (the end of the $A5-byte
; record exchange started in step 14), then increments wScreenState to 5
; (RunLinkSession6Exchange_FightInfo) and clears wScreenStep. (C2, E-0372; probed E-0380)
RunLinkSession6Exchange_Pick_EndExchange::
    ld a, [wLinkMessage]
    cp $f0
    ret nz
    ld hl, wScreenState
    inc [hl]
    xor a
    ld [wScreenStep], a
    ret

SECTION "Bank 33 RunLinkSession6Exchange_FightInfo", ROMX

; Session 6, screen state 5 (the fight info): its eighteen steps. (C1, E-0357)
RunLinkSession6Exchange_FightInfo::
    ld a, [wScreenStep]
    jumptable
    dw RunLinkSession6Exchange_FightInfo_Pack
    dw RunLinkSession6Exchange_FightInfo_SendReady
    dw RunLinkSession6Exchange_FightInfo_StartExchange
    dw RunLinkSession6Exchange_FightInfo_EndExchange
    dw RunLinkSession6Exchange_FightInfo_DrawWindow
    dw RunLinkSession6Exchange_FightInfo_AskBattle
    dw RunLinkSession6Exchange_FightInfo_Choice
    dw RunLinkSession6Exchange_FightInfo_RecordNotice
    dw RunLinkSession6Exchange_FightInfo_ConfirmRecord
    dw RunLinkSession6Exchange_FightInfo_ShowPleaseWait
    dw RunLinkSession6Exchange_FightInfo_ReadyToSave
    dw RunLinkSession6Exchange_FightInfo_SaveAnswer
    dw RunLinkSession6Exchange_FightInfo_Save
    dw RunLinkSession6Exchange_FightInfo_KeepPartner
    dw RunLinkSession6Exchange_FightInfo_ExchangeSeed
    dw RunLinkSession6Exchange_FightInfo_SyncSeed
    dw RunLinkSession6Exchange_FightInfo_SendStart
    dw RunLinkSession6Exchange_FightInfo_StartLinkBattle

; Fight info, step 0: packs this side's key bytes and the player's name to send. (C2, E-0357; probed
; E-0380)
RunLinkSession6Exchange_FightInfo_Pack::
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

; HL = source, DE = destination, B = count: copies B bytes (B = 0 copies 256) and then stores 1 at
; the next destination byte; on return DE points at that 1, HL is just past the source, A = 1 and B
; = 0. RunLinkSession6Exchange_FightInfo_Pack calls it for the four key bytes and then falls into it
; again for the 11 bytes of the name, so the first name byte overwrites the 1 after the key bytes
; and one final 1 ends the 16-byte block. (C2, E-0380)
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

SECTION "Bank 33 RunLinkSession6Exchange_FightInfo_SendReady", ROMX

; Step 1 of RunLinkSession6Exchange_FightInfo: sends 1 (wLinkSendByte) and moves to step 2, which
; waits for the partner's 1. (C2, E-0372; probed E-0380)
RunLinkSession6Exchange_FightInfo_SendReady::
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wScreenStep
    inc [hl]
    ret

SECTION "Bank 33 RunLinkSession6Exchange_FightInfo_StartExchange", ROMX

; Step 2 of RunLinkSession6Exchange_FightInfo: on the partner's 1, starts a 16-byte exchange: the
; word at wLinkTimeoutLo/Hi = wLinkRecvBuffer (where step 0 packed this side's four key bytes, the
; 11-byte player name and a 1), wLinkBufferPtrLo/Hi = wLinkPartnerName, wLinkBufferCountLo = $10,
; sends $FF and moves to step 3. (C2, E-0372; probed E-0380)
RunLinkSession6Exchange_FightInfo_StartExchange::
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

SECTION "Bank 33 RunLinkSession6Exchange_FightInfo_EndExchange", ROMX

; Step 3 of RunLinkSession6Exchange_FightInfo: waits for wLinkMessage $F0 (the 16-byte exchange of
; step 2 has ended), then clears wLinkSendByte and moves to step 4
; (RunLinkSession6Exchange_FightInfo_DrawWindow). (C2, E-0372; probed E-0380)
RunLinkSession6Exchange_FightInfo_EndExchange::
    ld a, [wLinkMessage]
    cp $f0
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld hl, wScreenStep
    inc [hl]
    ret

SECTION "Bank 33 RunLinkSession6Exchange_FightInfo_DrawWindow", ROMX

; Fight info, step 4: draws the 10 x 11 info window with the partner's name and four numbers, 'Fight
; / Info / Ex' (bank-$1B string $20) in its 9 x 7 box and string 1 of category 1. (C1, E-0357)
RunLinkSession6Exchange_FightInfo_DrawWindow::
    ld de, PartnerWinLossWindow_TileRect
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
    call DrawFourTwoDigitNumbers
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
    ld de, FightInfoExitBox_TileRect
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

SECTION "Bank 33 RunLinkSession6Exchange_FightInfo_AskBattle", ROMX

; Fight info, step 5: redraws and asks 'Battle in Team Mode?' (category 5, string $0D). (C1, E-0357)
RunLinkSession6Exchange_FightInfo_AskBattle::
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

SECTION "Bank 33 RunLinkSession6Exchange_FightInfo_Choice", ROMX

; Fight info, step 6: the partner's refusal ends; the three-way choice: Fight goes on, Info opens
; the partner's monster's stats (state $0D, keeping the list place), Ex or B 'You refused the Team
; Mode.' (to leaving). (C1, E-0357)
RunLinkSession6Exchange_FightInfo_Choice::
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

SECTION "Bank 33 RunLinkSession6Exchange_FightInfo_RecordNotice", ROMX

; Fight info, step 7: copies $104 bytes from wWindowTileBuffer + $64 to wScreenTileBuffer, starts
; 'The battle results will be recorded.' (BeginString_Bank07_Cat5, string $0E), sets wLinkSendByte =
; 0 and goes on to step 8. (C1, E-0372)
RunLinkSession6Exchange_FightInfo_RecordNotice::
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

SECTION "Bank 33 RunLinkSession6Exchange_FightInfo_ConfirmRecord", ROMX

; Step 8 of RunLinkSession6Exchange_FightInfo, the answer to 'The battle results will be recorded.'
; (step 7): on the partner's $FE goes to screen state 2 (TeamMode_Screen_Leave) with 'Your pal
; refused the Team Mode.' and sends $FE; otherwise once wTextFlags is clear, wTextYesNoResult bit 0
; set (no) asks 'Battle in Team Mode?' again and goes back two steps to step 6 (the three-way
; choice); bit 0 clear (yes) moves to step 9. (C1, E-0372)
RunLinkSession6Exchange_FightInfo_ConfirmRecord::
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

SECTION "Bank 33 RunLinkSession6Exchange_FightInfo_ShowPleaseWait", ROMX

; Fight info, step 9: 'Please wait.'. (C1, E-0357)
RunLinkSession6Exchange_FightInfo_ShowPleaseWait::
    ld hl, wScreenStep
    inc [hl]
    ld a, $0c ; 'Please wait.'
    call BeginString_Bank07_Cat5
    ret

SECTION "Bank 33 RunLinkSession6Exchange_FightInfo_ReadyToSave", ROMX

; Step 10 of RunLinkSession6Exchange_FightInfo: once wTextFlags is clear (after 'Please wait.', step
; 9), moves to step 11 and sends 1; step 11 (RunLinkSession6Exchange_FightInfo_SaveAnswer) starts
; saving on the partner's 1. (C2, E-0372; probed E-0380)
RunLinkSession6Exchange_FightInfo_ReadyToSave::
    ld a, [wTextFlags]
    and a
    ret nz
    ld hl, wScreenStep
    inc [hl]
    ld a, $01
    ld [wLinkSendByte], a
    ret

SECTION "Bank 33 RunLinkSession6Exchange_FightInfo_SaveAnswer", ROMX

; Fight info, step 11: on the partner's 1 'Saving... Please wait.' (string $1A); on $FE 'Your pal
; refused the Team Mode.'. (C1, E-0357)
RunLinkSession6Exchange_FightInfo_SaveAnswer::
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

SECTION "Bank 33 RunLinkSession6Exchange_FightInfo_Save", ROMX

; Fight info, step 12: after the text checks the save (ReloadSaveBlocksWithChecksum, keeping the
; gold) and saves, then sends 5. (C2, E-0357; probed E-0380)
RunLinkSession6Exchange_FightInfo_Save::
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
    farcall ReloadSaveBlocksWithChecksum
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

SECTION "Bank 33 RunLinkSession6Exchange_FightInfo_KeepPartner", ROMX

; Fight info, step 13: on the partner's 5 keeps the partner's name (wLinkSeedCopy) and the picked
; record number. (C2, E-0357; probed E-0380)
RunLinkSession6Exchange_FightInfo_KeepPartner::
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

SECTION "Bank 33 RunLinkSession6Exchange_FightInfo_ExchangeSeed", ROMX

; Fight info, step 14: starts a 2-byte exchange of the random seed. (C2, E-0357; probed E-0380)
RunLinkSession6Exchange_FightInfo_ExchangeSeed::
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

SECTION "Bank 33 RunLinkSession6Exchange_FightInfo_SyncSeed", ROMX

; Step 15 of RunLinkSession6Exchange_FightInfo: waits for wLinkMessage $F0 (the 2-byte seed exchange
; of step 14 has ended), clears wLinkSendByte and wLinkReady, then makes both sides use one seed:
; with wLinkRole bit 1 clear it copies wRandomLo/Hi to wRandomSeed2Lo/Hi; with bit 1 set it copies
; the received wRandomSeed2Lo/Hi into wRandomLo/Hi. Moves to step 16. (C2, E-0372; probed E-0380)
RunLinkSession6Exchange_FightInfo_SyncSeed::
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

SECTION "Bank 33 RunLinkSession6Exchange_FightInfo_SendStart", ROMX

; Step 16 of RunLinkSession6Exchange_FightInfo: moves to step 17 and sends $D2 (wLinkSendByte); step
; 17 starts the battle when the partner's $D2 arrives. (C2, E-0372; probed E-0380)
RunLinkSession6Exchange_FightInfo_SendStart::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $d2
    ld [wLinkSendByte], a
    ret

SECTION "Bank 33 RunLinkSession6Exchange_FightInfo_StartLinkBattle", ROMX

; Step 17 of RunLinkSession6Exchange_FightInfo: on the partner's $D2 clears wLinkSendByte, sets
; wGameMode = 7 with wModeState, wWorldMapState and wGameMode2Arg cleared and wModeChangeRequest = 1
; (RunGameModeInit entry 7, RunGameModeInit_LinkBattle), sets wLinkSession = 7 and
; wLinkExchangeState = 0, and clears wLinkSendByte and wLinkMessage. (C2, E-0372; probed E-0380)
RunLinkSession6Exchange_FightInfo_StartLinkBattle::
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

SECTION "Bank 33 RunLinkSession6Exchange_RunStatsScreen", ROMX

; Session 6, screen states 6-12: runs the stats screen until its step $0A, then three states on.
; (C1, E-0357)
RunLinkSession6Exchange_RunStatsScreen::
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

SECTION "Bank 33 RunLinkSession6Exchange_RunRecordScreens", ROMX

; Session 6, screen state 13: runs the record screens (RunScreenStateWhenNotFading_F1); back in
; state $0E restores the list place. (C1, E-0357)
RunLinkSession6Exchange_RunRecordScreens::
    farcall RunScreenStateWhenNotFading_F1
    ld a, [wScreenState]
    cp $0e
    ret nz
    ld a, [wItemGridX]
    ld [wListCursor], a
    ld a, [wItemGridY]
    ld [wListPageIndex], a
    ret

SECTION "Bank 33 RunLinkSession6Exchange_BackFromStats", ROMX

; Session 6, screen state 14 (back from the partner's stats): its eight steps. (C1, E-0357)
RunLinkSession6Exchange_BackFromStats::
    ld a, [wScreenStep]
    jumptable
    dw RunLinkSession6Exchange_BackFromStats_DrawInfo
    dw RunLinkSession6Exchange_BackFromStats_Delay
    dw RunLinkSession6Exchange_BackFromStats_Delay
    dw RunLinkSession6Exchange_BackFromStats_DrawPanel
    dw RunLinkSession6Exchange_BackFromStats_DrawName
    dw RunLinkSession6Exchange_BackFromStats_DrawWindows
    dw RunLinkSession6Exchange_BackFromStats_ShowChoices
    dw RunLinkSession6Exchange_BackFromStats_Return

; Back from stats, step 0: clears the record panel tiles, draws the info window, the name and
; heading and string 1 of category 1. (C1, E-0357)
RunLinkSession6Exchange_BackFromStats_DrawInfo::
    farcall ClearRecordPanelTiles
    ld de, PartnerWinLossWindow_TileRect
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

SECTION "Bank 33 RunLinkSession6Exchange_BackFromStats_Delay", ROMX

; Steps 1 and 2 of RunLinkSession6Exchange_BackFromStats: each only increments wScreenStep, so the
; redraw waits two calls between drawing the info window (step 0) and the panel (step 3). (C2,
; E-0372; probed E-0380)
RunLinkSession6Exchange_BackFromStats_Delay::
    ld hl, wScreenStep
    inc [hl]
    ret

SECTION "Bank 33 RunLinkSession6Exchange_BackFromStats_DrawPanel", ROMX

; Back from stats, step 3: draws the picked monster's family icon, level and sex mark in its 13 x 2
; panel. (C1, E-0357)
RunLinkSession6Exchange_BackFromStats_DrawPanel::
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
    ld de, RunLinkSession6Exchange_PickedPanelTileRect
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

SECTION "Bank 33 RunLinkSession6Exchange_PickedPanelTileRect", ROMX

; A tile rectangle 13 wide and 2 rows high, 26 bytes. Row 0: frame $B6, $EA and $ED, blanks $C3,
; five name tiles $F8 to $FC, blank $C3, tile $C7 and frame $B7; row 1: the bottom frame $B3, $B4
; (11 times) and $B5. RunLinkSession6Exchange_BackFromStats_DrawPanel copies it to wWindowTileBuffer
; + $140 and then writes two level digit tiles into the blanks at columns 3 and 4 and the sex mark
; ($CC plus MON_SEX bit 0) into the blank at column 10. (C1, E-0381)
; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 13 x 2 tiles, one row per line
RunLinkSession6Exchange_PickedPanelTileRect::
    db $b6, $ea, $ed, $c3, $c3, $f8, $f9, $fa, $fb, $fc, $c3, $c7, $b7 ; id 0
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 1

; Back from stats, step 4: draws the picked monster's name. (C1, E-0357)
RunLinkSession6Exchange_BackFromStats_DrawName::
    farcall ClearAndDrawListEntriesCell5NameAtTiles1780
    ret

SECTION "Bank 33 RunLinkSession6Exchange_BackFromStats_DrawWindows", ROMX

; Back from stats, step 5: draws both info windows with their four numbers and the partner's name.
; (C1, E-0357)
RunLinkSession6Exchange_BackFromStats_DrawWindows::
    ld de, PlayerWinLossWindow_TileRect
    ld hl, wWindowTileBuffer + $6e
    lb bc, $0a, $0b
    call CopyRectTo20ByteRowsJp_Bank33
    ld de, wKeyNameBuf
    ld hl, wWindowTileBuffer + $b1
    call DrawFourTwoDigitNumbers
    ld de, PartnerWinLossWindow_TileRect
    ld hl, wWindowTileBuffer + $64
    lb bc, $0a, $0b
    call CopyRectTo20ByteRowsJp_Bank33
    ld de, wLinkPartnerName
    ld hl, wWindowTileBuffer + $a7
    call DrawFourTwoDigitNumbers
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

SECTION "Bank 33 RunLinkSession6Exchange_BackFromStats_ShowChoices", ROMX

; Back from stats, step 6: shows 'Fight / Info / Ex' in its box with the cursor on Info. (C1,
; E-0357)
RunLinkSession6Exchange_BackFromStats_ShowChoices::
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
    ld de, FightInfoExitBox_TileRect
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

SECTION "Bank 33 RunLinkSession6Exchange_BackFromStats_Return", ROMX

; Back from stats, step 7: redraws, restores hide tile $70 and returns to the saved state and step.
; (C1, E-0357)
RunLinkSession6Exchange_BackFromStats_Return::
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

SECTION "Bank 33 RunLinkSession6Exchange_BackFromOwnStats", ROMX

; Session 6, screen state 15 (back from this side's stats): its eight steps. (C1, E-0357)
RunLinkSession6Exchange_BackFromOwnStats::
    ld a, [wScreenStep]
    jumptable
    dw RunLinkSession6Exchange_BackFromOwnStats_DrawBox
    dw RunLinkSession6Exchange_BackFromOwnStats_ListPage
    dw RunLinkSession6Exchange_BackFromOwnStats_DrawNames
    dw RunLinkSession6Exchange_BackFromOwnStats_DrawPanel
    dw RunLinkSession6Exchange_BackFromOwnStats_DrawName
    dw RunLinkSession6Exchange_BackFromOwnStats_DrawInfo
    dw RunLinkSession6Exchange_BackFromOwnStats_AskPick
    dw RunLinkSession6Exchange_BackFromOwnStats_Return

; Back from this side's stats, step 0: clears the record panel tiles, draws the list box with the
; cursor mark and the name and heading. (C1, E-0357)
RunLinkSession6Exchange_BackFromOwnStats_DrawBox::
    farcall ClearRecordPanelTiles
    ld de, RunLinkSession6Exchange_ListBoxTileRect
    ld hl, wWindowTileBuffer + $64
    lb bc, $08, $0b
    call CopyRectTo20ByteRowsJp_Bank33
    ld a, [wListCursor]
    ld b, $bc
    ld hl, RunLinkSession6Exchange_Pick_MarkCursor_Data
    call StoreBAtWordTableEntry_Bank33
    call DrawPlayerNameAndString0Category1
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

SECTION "Bank 33 RunLinkSession6Exchange_BackFromOwnStats_DrawPanel", ROMX

; Back from this side's stats, step 3: draws the record panel. (C1, E-0357)
RunLinkSession6Exchange_BackFromOwnStats_DrawPanel::
    call CallDrawListEntriesCell5RecordPanel
    ret

SECTION "Bank 33 RunLinkSession6Exchange_BackFromOwnStats_ListPage", ROMX

; Back from this side's stats, step 1: lists the monsters that may be picked, clamps the page cursor
; of five and draws the page indicator. (C1, E-0357)
RunLinkSession6Exchange_BackFromOwnStats_ListPage::
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

SECTION "Bank 33 RunLinkSession6Exchange_BackFromOwnStats_DrawNames", ROMX

; Back from this side's stats, step 2: draws the page's names and marks the party members. (C1,
; E-0357)
RunLinkSession6Exchange_BackFromOwnStats_DrawNames::
    farcall DrawRecordListPageNames
    xor a
    ld [wArg1], a
    farcall MarkPartyMembersInRecordListPage
    ret

SECTION "Bank 33 RunLinkSession6Exchange_BackFromOwnStats_DrawName", ROMX

; Back from this side's stats, step 4: draws the cursor entry's name. (C1, E-0357)
RunLinkSession6Exchange_BackFromOwnStats_DrawName::
    call CallClearAndDrawListEntriesCell5Name
    ret

SECTION "Bank 33 RunLinkSession6Exchange_BackFromOwnStats_DrawInfo", ROMX

; Back from this side's stats, step 5: draws the info window. (C2, E-0357; probed E-0380)
RunLinkSession6Exchange_BackFromOwnStats_DrawInfo::
    call RunLinkSession6Exchange_DrawInfoWindow
    ret

SECTION "Bank 33 RunLinkSession6Exchange_BackFromOwnStats_AskPick", ROMX

; Back from this side's stats, step 6: shows 'Info / OK' and the pick question (bank-$1B string
; $12), the four numbers and the choice box. (C1, E-0357)
RunLinkSession6Exchange_BackFromOwnStats_AskPick::
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
    call DrawFourTwoDigitNumbers
    ld de, InfoOKBox_TileRect
    ld hl, wWindowTileBuffer + $110
    lb bc, $08, $05
    call CopyRectTo20ByteRowsJp_Bank33
    xor a
    ld [wChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

SECTION "Bank 33 RunLinkSession6Exchange_BackFromOwnStats_Return", ROMX

; Back from this side's stats, step 7: redraws, restores hide tile $70 and returns to the saved
; state and step. (C1, E-0357)
RunLinkSession6Exchange_BackFromOwnStats_Return::
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

SECTION "Bank 33 LoadRecordByteForPickedRecords", ROMX

; C = field offset: enables SRAM, selects SRAM bank 0, loads field C of record number
; [wPickedRecords] (the first picked record) into hTemp0 with LoadSRAMRecordByte, then disables SRAM
; and selects bank 0 again. HL = wPickedRecords and A = 0 on return. No label or table in the source
; names it, so it appears to be unused. (C2, E-0380; probed E-0384)
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

SECTION "Bank 33 DrawBoxAndKeyRows", ROMX

; Copies the 8 x 5 tile rectangle DrawBoxAndKeyRows_TileRect to wWindowTileBuffer + $110
; (CopyRectTo20ByteRowsJp_Bank33), then draws the four numbers at wKeyNameBuf as two-digit tiles
; from wWindowTileBuffer + $B1, two rows apart (DrawFourTwoDigitNumbers); the fourth number lands on
; columns 5 and 6 of the second row of the rectangle and overwrites them. Called by
; RunLinkSession6Exchange_Pick_ShowChooseAMonsterFor and
; RunLinkSession6Exchange_Pick_ShowPleaseWait. (C2, E-0380)
; copies box DrawBoxAndKeyRows_TileRect to wWindowTileBuffer + $110 and runs DrawFourTwoDigitNumbers
; for wKeyNameBuf at wWindowTileBuffer + $B1 (E-0126) (E-0344: the address in its name dropped or
; read as the label there; was DrawBoxAndKeyRows)
DrawBoxAndKeyRows::
    ld de, DrawBoxAndKeyRows_TileRect
    ld hl, wWindowTileBuffer + $110
    lb bc, $08, $05
    call CopyRectTo20ByteRowsJp_Bank33
    ld de, wKeyNameBuf
    ld hl, wWindowTileBuffer + $b1
    call DrawFourTwoDigitNumbers
    ret

SECTION "Bank 33 ListAvailableRecordsForSelection_Bank33", ROMX

; Builds the pick list wListEntries from the first $1E stored records (sRecords, SRAM bank 0); the
; 30 bytes of wListEntries and of wListEntries2 are zeroed first. A record is listed when its
; MON_STATE is 1, or 2 while wPickCount is not 3, and its MON_EGG byte is 0; while wPickCount is 1
; or 2 a record already in the first wPickCount bytes of wPickedRecords is left out. Each listed
; record index is appended to wListEntries and wListCount is the length; wRecordsFlagged counts the
; records with a fitting state whose MON_EGG byte is not 0. SRAM is switched off at the end and
; MovePartyRecordsToFrontOfList puts the party members first. Called by
; RunLinkSession6Exchange_BackFromOwnStats_ListPage. (C2, E-0380; probed E-0384)
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

SECTION "Bank 33 ShowStringA10_Bank33", ROMX

; A = string number minus $10: sets wStringIndex = A + $10 and wStringCategory = 0, then farcalls
; BeginStringDisplay_Bank1B to start showing that string of category 0 of bank $1B in the current
; text window. Callers pass A = $0C ('Please wait.') from
; RunLinkSession6Exchange_Pick_ShowPleaseWait and TeamMode_Screen_Leave_ShowPleaseWait, and A = $02
; ('Pick 0 for the team?') from RunLinkSession6Exchange_Pick_ShowYourPalRefusedThe. (C1, E-0380)
; the same 16 bytes as ShowStringA10_Bank1B (ShowStringA10_Bank1B) (E-0063)
ShowStringA10_Bank33::
    add $10
    ld [wStringIndex], a
    xor a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank1B
    ret

SECTION "Bank 33 SetDefaultStringWindow_Bank33", ROMX

; Sets the text window for the next string: wTextWindowTileLo/Hi = vTiles1 ($8800), wTextWindowRows
; = 2 and wTextWindowWidth = $12, so BeginStringDisplay clears and fills 18 tiles per line for 2
; lines. Called after the Team Mode screens draw a frame or window (for example
; TeamMode_Screen_DrawFrameAndName and RunLinkSession6Exchange_BackFromStats_DrawInfo). (C1, E-0380)
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

SECTION "Bank 33 StoreListEntriesCell5RecordInPickedRecords", ROMX

; wPickedRecords (its first byte only) = the record index in the list cell under the cursor,
; wListEntries + 5 * wListPageIndex + wListCursor (SetArg5ToListEntriesCell5). Called by
; RunLinkSession6Exchange_Pick_ShowYourPalRefusedThe and RunLinkSession6Exchange_Pick_InfoOKChoice.
; (C2, E-0380)
; wPickedRecords = the record index at wListEntries cell 5 (E-0126)
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

SECTION "Bank 33 CopyListEntriesCell5NameToTextBuf0_Bank33", ROMX

; Copies the name of the record in the list cell under the cursor (wListEntries + 5 * wListPageIndex
; + wListCursor) to wTextBuf0 so a message with <BUF0> shows it: with SRAM bank 0 enabled,
; CopyRecordNameToNameGlyphBuf reads its 10 name bytes (MON_NAME) into wNameGlyphBuf, then 11 bytes
; of wNameGlyphBuf go to wTextBuf0 (the 11th is whatever follows the name, normally the $F0 end mark
; that DrawPlayerNameAndString0Category1 left there); SRAM is switched off again. Called by
; RunLinkSession6Exchange_Pick_ShowYourPalRefusedThe,
; RunLinkSession6Exchange_BackFromStats_ShowChoices and
; RunLinkSession6Exchange_BackFromOwnStats_AskPick. (C2, E-0380; probed E-0384)
; copies the name of the record at wListEntries cell 5 (11 bytes) to wTextBuf0 (E-0124)
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

SECTION "Bank 33 FinishPickedRecordsEntryAndStep_33", ROMX

; Closes the pick: wSelectedRecord = wPickCount, wPackWork = $FF, wPickCount = 4 (the RAM notes call
; 4 the end of the picks and $FF a finished pick), wScreenSubStep = 0 and wScreenStep += 1. Called
; by RunLinkSession6Exchange_Pick_ShowPleaseWait right after it incremented wPickCount. (C2, E-0380)
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

SECTION "Bank 33 StoreBAtWordTableEntry_Bank33", ROMX

; HL = table of 16-bit addresses, A = index, B = tile number: stores B at the address held by entry
; A (the index is doubled in 8 bits, so it wraps above $7F); BC is kept, A, DE and HL are clobbered.
; The Team Mode pick steps call it with RunLinkSession6Exchange_Pick_MarkCursor_Data and A =
; wListCursor to put a cursor tile ($BB, $BC) or the blank $C3 at the mark position of that list
; row. (C2, E-0380)
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

SECTION "Bank 33 BGMapAddressAtScroll_Bank33", ROMX

; HL = $9800 + (hScrollY AND $F8) * 4 + hScrollX / 8: the BG map address of the tile at the current
; scroll position (hScrollX, hScrollY); A and DE are clobbered (DE ends equal to HL). Called before
; DrawScreenBufferRectToBGMap_33 to give it the top-left BG map address of the screen. (C2, E-0380)
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

SECTION "Bank 33 DrawScreenBufferRectToBGMap_33", ROMX

; HL = BG map address, DE = offset into wScreenTileBuffer, B = width, C = rows: copies that
; rectangle of the screen buffer to the BG map at HL (CopyRectFromBankToBGMapWrapped) and sets
; wTextCursorLo/Hi = HL + $1C1. When wIsCGB is non-zero it then selects VRAM bank 1 and WRAM bank 2
; and copies the same rectangle of wScreenAttrBuffer (offset DE) to the same map address, and
; selects bank 0 of both again. BC, DE and HL are kept. Callers set HL with
; BGMapAddressAtScroll_Bank33 and use B = $14, C = $0D to draw the whole 20 x 13 screen. (C1,
; E-0380)
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

SECTION "Bank 33 CopyRectTo20ByteRowsJp_Bank33", ROMX

; DE = source, HL = destination, B = width, C = rows: copies the B x C rectangle from DE to HL with
; the destination rows 20 bytes ($14) apart; BC and HL are kept and DE ends just past the source.
; When wIsCGB is non-zero it then also fills the same B x C rectangle with 0 at HL + $0E68 (the
; attribute copy of the window buffer, with rSVBK = 2, restored to 0), leaving HL at the row after
; the last one and C = 0. (C2, E-0380)
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

SECTION "Bank 33 WriteGoldDigitsToScreenTileBufferRow1Col14", ROMX

; Writes the gold (wGoldLo, wGoldMid, wGoldHi) as up to five digit tiles ($E0 + digit) at
; wScreenTileBuffer + $22 to + $26, without leading zeros: a leading zero leaves its tile unchanged,
; the last digit is always written, and the sixth digit (hundred-thousands) is ignored, so 100000
; shows as 0. Called by RunLinkSession6Exchange_DrawTeamGold. (C2, E-0380)
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

SECTION "Bank 33 DrawFourTwoDigitNumbers", ROMX

; DE = four bytes, HL = tile buffer address: draws the four bytes at DE as four two-digit numbers
; with RunFourTimes_DrawTwoDigitByte, called three times and entered once more by falling into it;
; the numbers go to HL, HL + $28, HL + $50 and HL + $78 (two 20-byte rows apart). DE ends 4 bytes on
; and HL at HL + $A0. Called by DrawBoxAndKeyRows and by several Team Mode steps, for example
; RunLinkSession6Exchange_DrawTeamGold, which passes wKeyNameBuf. (C2, E-0380)
; calls RunFourTimes_DrawTwoDigitByte three times and falls into it once more (E-0122) (E-0344: the
; address in its name dropped or read as the label there; was DrawFourTwoDigitNumbers)
DrawFourTwoDigitNumbers::
    call RunFourTimes_DrawTwoDigitByte
    call RunFourTimes_DrawTwoDigitByte
    call RunFourTimes_DrawTwoDigitByte

; DE = byte, HL = tile buffer address: converts the byte at DE (HLToDecimalDigits) and writes the
; tens digit as tile $E0 + digit at HL only when it is non-zero (a zero leaves that tile unchanged),
; then the ones digit at HL + 1; returns DE + 1 and HL + $28 (two 20-byte rows down from the start).
; DrawFourTwoDigitNumbers calls it three times and falls into it once, drawing four numbers. (C2,
; E-0372; probed E-0380)
RunFourTimes_DrawTwoDigitByte::
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

SECTION "Bank 33 WriteC3AtWordTableEntries_Bank33", ROMX

; HL = table of 16-bit addresses, C = count: stores $C3 (a tile number) at the addresses held by
; entries 0 to C - 1; C = 0 still writes entry 0, because the loop tests the count after each write.
; Called by RunLinkSession6Exchange_Pick_ShowChooseAMonsterFor with C = 5 and
; RunLinkSession6Exchange_Pick_MarkCursor_Data (the five cursor mark addresses) to clear the five
; marks. (C2, E-0380)
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

SECTION "Bank 33 DrawPlayerNameAndString0Category1", ROMX

; Draws the player name heading of the Team Mode window: blanks 5 tiles at vTiles2
; (FillTilesFromRequest), copies the 10 bytes of wPlayerName to wNameGlyphBuf with $F0 after them
; and draws them as glyph tiles at vTiles2 (CopyGlyphTilesToVRAM); then sets the text window to
; vTiles2 + $100 (16 tiles, 1 row), wStringCategory = 1, wStringIndex = 0 and farcalls
; ShowString_Bank07 to print string 0 of category 1 (a short heading text beside the name). Called
; by TeamMode_Screen_DrawFrameAndName, RunLinkSession6Exchange_BackFromStats_DrawInfo and
; RunLinkSession6Exchange_BackFromOwnStats_DrawBox. (C1, E-0380)
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

SECTION "Bank 33 StoreC5BEC6AtHLStride2_Bank33", ROMX

; HL = address: stores $C5 at HL, $BE at HL + 2 and $C6 at HL + 4 (three tile numbers two bytes
; apart) and leaves HL = the old HL + 4 and A = $C6. Called by
; RunLinkSession6Exchange_BackFromOwnStats_ListPage to draw three tiles of the page indicator at
; wWindowTileBuffer + $12E when wListPages is 2 or more. (C2, E-0380)
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

SECTION "Bank 33 TeamModeGoldBox_TileRect", ROMX

; A tile rectangle 8 wide and 3 high, 24 bytes: a top frame ($B0, $B1 six times, $B2), a middle row
; $B6, $BF, six blanks $C3 and $B7, and a bottom frame ($B3, $B4 six times, $B5).
; TeamMode_Screen_DrawFrameAndName copies it to wScreenTileBuffer + $C as the small box for the team
; gold. (C1, E-0381)
; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 8 x 3 tiles, one row per line
TeamModeGoldBox_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $bf, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 2

; A 10 x 11 framed window. Row 1 holds tiles $00-$04, where DrawPlayerNameAndString0Category1 draws
; the name of the player (wPlayerName) at vTiles2; row 2 is a divider ($B8-$BA); rows 3, 5, 7 and 9
; hold tiles $10-$12 or $13-$15, then $16 or $17 and $ED: glyphs of string 0 of category 1
; ('DuoOwnWL:') drawn at vTiles2 + $100, which read 'Duo W', 'Own W', 'Duo L' and 'Own L' when each
; glyph takes one tile; DrawFourTwoDigitNumbers writes four numbers from wKeyNameBuf beside them.
; Copied with CopyRectTo20ByteRowsJp_Bank33 to wScreenTileBuffer by Team Mode step 0 and to
; wWindowTileBuffer + $6E by RunLinkSession6Exchange_DrawInfoWindow and
; RunLinkSession6Exchange_BackFromStats_DrawWindows. (C1, E-0372)
; record: 10 x 11 tiles, one row per line
PlayerWinLossWindow_TileRect::
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

; The same 10 x 11 window as PlayerWinLossWindow_TileRect but with tiles $05-$09 in row 1, where the
; callers draw the 10 bytes at wRandomSeed2Hi as name glyphs at vTiles2 + $50 (the partner's name in
; the earlier readings); DrawFourTwoDigitNumbers writes four numbers from wLinkPartnerName beside
; the 'Duo W' to 'Own L' rows. Copied to wWindowTileBuffer + $64 by
; RunLinkSession6Exchange_FightInfo_DrawWindow, RunLinkSession6Exchange_BackFromStats_DrawInfo and
; RunLinkSession6Exchange_BackFromStats_DrawWindows. (C1, E-0372)
; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
PartnerWinLossWindow_TileRect::
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

; An 8 x 5 framed box whose rows 1 and 3 show tiles $70-$73 and $74-$75, the glyphs
; ShowString_Bank1B draws for string $1E (Text_InfoOKYesN, 'InfoOKYesN') at vTiles2 + $700: 'Info'
; and 'OK' when each glyph takes one tile. Copied to wWindowTileBuffer + $110 with
; CopyRectTo20ByteRowsJp_Bank33 by RunLinkSession6Exchange_Pick_ShowInfoOKYesN and
; RunLinkSession6Exchange_BackFromOwnStats_AskPick. (C1, E-0372)
InfoOKBox_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $70, $71, $72, $73, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $74, $75, $c3, $c3, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

RunLinkSession6Exchange_Pick_MarkCursor_Data::
    db $79, $c3, $a1, $c3, $c9, $c3, $f1, $c3, $19, $c4

; A 9 x 7 framed box whose rows 1, 3 and 5 show tiles $30-$34, $35-$38 and $39 $3A $31 $34, the
; glyphs ShowString_Bank1B draws for string $20 (Text_FightInfoEx, 'FightInfoEx') at vTiles2 + $300:
; 'Fight', 'Info' and, reusing the 'i' and 't' of 'Fight', 'Exit' when each glyph takes one tile.
; Copied to wWindowTileBuffer + $E7 by RunLinkSession6Exchange_FightInfo_DrawWindow and
; RunLinkSession6Exchange_BackFromStats_ShowChoices. (C1, E-0372)
; record: 9 x 7 tiles, one row per line
FightInfoExitBox_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $30, $31, $32, $33, $34, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $35, $36, $37, $38, $c3, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $39, $3a, $31, $34, $c3, $c3, $b7 ; id 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 6

; An 8 x 11 framed list box (88 bytes, one row of 8 tile ids per line) with five text rows of tile
; ids $D0-$D4, $D5-$D9, $DA-$DE, $F0-$F4 and $A4 $A5 $A6 $CE $CF in rows 1, 3, 5, 7 and 9, blank
; rows between them. RunLinkSession6Exchange_BackFromOwnStats_DrawBox (screen state 15, step 0)
; copies it to wWindowTileBuffer + $64 (row 5, column 0) with CopyRectTo20ByteRowsJp_Bank33, then
; marks the wListCursor row with tile $BC through RunLinkSession6Exchange_Pick_MarkCursor_Data. (C1,
; E-0373)
; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 8 x 11 tiles, one row per line
RunLinkSession6Exchange_ListBoxTileRect::
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

; Starts showing string wStringIndex of category wStringCategory from this bank first string table
; (BeginStringDisplay_Bank33_StringCategories, class, prize and Magic Key messages) by loading DE
; with the table and calling BeginStringDisplay; the glyphs are then printed a few per frame. Seven
; unlabelled bytes after its ret repeat the same instructions as data. Far-called by the debug
; message test (DebugMessageTest_Update_ShowBank33) and called by ShowString_Bank33. (C1, E-0380)
; ld de, this bank's string table / BeginStringDisplay (E-0344: the address in its name dropped or
; read as the label there; was BeginStringDisplay_Bank33)
BeginStringDisplay_Bank33::
    ld de, BeginStringDisplay_Bank33_StringCategories
    call BeginStringDisplay
    ret
    db $11, $a5, $64, $cd, $fe, $25, $c9

; Shows string wStringIndex of category wStringCategory from the first string table of this bank
; (BeginStringDisplay_Bank33) and prints it to the end at once (RunStringDisplayToEnd). Far-called
; by the library and arena code of bank $0C. (C1, E-0380)
; BeginStringDisplay_Bank33 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; (E-0344: the address in its name dropped or read as the label there; was ShowString_Bank33)
ShowString_Bank33::
    call BeginStringDisplay_Bank33
    call RunStringDisplayToEnd
    ret

SECTION "Bank 33 BeginStringDisplay_Bank33_StringCategories", ROMX

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

; Starts showing string wStringIndex of category wStringCategory from the second string table of
; this bank (BeginStringDisplay_Bank33_2_StringCategories: draw, win and lose lines, 'Received',
; 'Switch with which?', 'There are no eggs.') by loading DE with the table and calling
; BeginStringDisplay. Seven unlabelled bytes after its ret repeat the same instructions as data.
; Far-called by the debug message test (DebugMessageTest_Update_ShowBank33Second) and by the link
; priest screens; called by ShowString_Bank33_2. (C1, E-0380)
; ld de, this bank's string table / BeginStringDisplay (E-0344: the address in its name dropped or
; read as the label there; was BeginStringDisplay_Bank33_2)
BeginStringDisplay_Bank33_2::
    ld de, BeginStringDisplay_Bank33_2_StringCategories
    call BeginStringDisplay
    ret
    db $11, $4c, $70, $cd, $fe, $25, $c9

; Shows string wStringIndex of category wStringCategory from the second string table of this bank
; (BeginStringDisplay_Bank33_2) and prints it to the end at once (RunStringDisplayToEnd). Far-called
; by the link priest screens. (C1, E-0380)
; BeginStringDisplay_Bank33_2 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; (E-0344: the address in its name dropped or read as the label there; was ShowString_Bank33_2)
ShowString_Bank33_2::
    call BeginStringDisplay_Bank33_2
    call RunStringDisplayToEnd
    ret

SECTION "Bank 33 BeginStringDisplay_Bank33_2_StringCategories", ROMX

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
