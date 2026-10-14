; ROM bank $62: key-world map screens
; The annotated listing of this bank is build/listing/bank62.asm.

SECTION "Bank 62", ROMX[$4000], BANK[$62]
    db $62

; data read by KeyWorldChunkGroup01 (8 bytes) (E-0347)
KeyWorld01_0_Y2X1_Header::
    db $03, $02, $04, $0b, $0d, $33, $01, $00

; LZSS-compressed: 97 bytes that expand to 360 (E-0016, E-0017)
KeyWorld01_0_Y2X1_Tiles::
    INCBIN "maps/key_worlds/01_0_y2_x1_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_62::
KeyWorld04_0_Y2X2_Header::
    db $05, $00, $01, $0e, $0f, $33, $02, $00 ; entry 0

; LZSS-compressed: 124 bytes that expand to 360 (E-0016, E-0017)
KeyWorld04_0_Y2X2_Tiles::
    INCBIN "maps/key_worlds/04_0_y2_x2_tiles.lz"

KeyWorldScreenHeader_62_2::
KeyWorld04_0_Y1X2_Header::
    db $07, $00, $07, $08, $0f, $33, $03, $00 ; entry 0

; LZSS-compressed: 211 bytes that expand to 360 (E-0016, E-0017)
KeyWorld04_0_Y1X2_Tiles::
    INCBIN "maps/key_worlds/04_0_y1_x2_tiles.lz"

KeyWorldScreenHeader_62_3::
KeyWorld11_1_Y1X1_Header::
    db $06, $04, $05, $0a, $0b, $33, $04, $00 ; entry 0

; LZSS-compressed: 105 bytes that expand to 360 (E-0016, E-0017)
KeyWorld11_1_Y1X1_Tiles::
    INCBIN "maps/key_worlds/11_1_y1_x1_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_62_4::
KeyWorld01_0_Y1X2_Header::
    db $04, $03, $07, $08, $0a, $33, $05, $00 ; entry 0

; LZSS-compressed: 113 bytes that expand to 360 (E-0016, E-0017)
KeyWorld01_0_Y1X2_Tiles::
    INCBIN "maps/key_worlds/01_0_y1_x2_tiles.lz"

KeyWorldScreenHeader_62_5::
KeyWorld04_0_Y2X1_Header::
    db $07, $04, $06, $09, $0b, $33, $06, $00 ; entry 0

; LZSS-compressed: 170 bytes that expand to 360 (E-0016, E-0017)
KeyWorld04_0_Y2X1_Tiles::
    INCBIN "maps/key_worlds/04_0_y2_x1_tiles.lz"

KeyWorldScreenHeader_62_6::
KeyWorld02_0_Y1X2_Header::
    db $00, $00, $06, $09, $0f, $33, $07, $00 ; entry 0

; LZSS-compressed: 93 bytes that expand to 360 (E-0016, E-0017)
KeyWorld02_0_Y1X2_Tiles::
    INCBIN "maps/key_worlds/02_0_y1_x2_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_62_7::
KeyWorld02_0_Y1X1_Header::
    db $01, $01, $06, $0c, $0e, $33, $08, $00 ; entry 0

; LZSS-compressed: 130 bytes that expand to 360 (E-0016, E-0017)
KeyWorld02_0_Y1X1_Tiles::
    INCBIN "maps/key_worlds/02_0_y1_x1_tiles.lz"

KeyWorldScreenHeader_62_8::
KeyWorld06_0_Y1X2_Header::
    db $00, $02, $05, $0a, $0d, $33, $09, $00 ; entry 0

; LZSS-compressed: 171 bytes that expand to 360 (E-0016, E-0017)
KeyWorld06_0_Y1X2_Tiles::
    INCBIN "maps/key_worlds/06_0_y1_x2_tiles.lz"

KeyWorldScreenHeader_62_9::
KeyWorld1C_1_Y2X2_Header::
    db $01, $03, $07, $08, $0f, $33, $0a, $00 ; entry 0

; LZSS-compressed: 152 bytes that expand to 360 (E-0016, E-0017)
KeyWorld1C_1_Y2X2_Tiles::
    INCBIN "maps/key_worlds/1_c_1_y2_x2_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_62_10::
KeyWorld2A_0_Y1X1_Header::
    db $04, $02, $04, $0b, $0d, $33, $0b, $00 ; entry 0

; LZSS-compressed: 147 bytes that expand to 360 (E-0016, E-0017)
KeyWorld2A_0_Y1X1_Tiles::
    INCBIN "maps/key_worlds/2_a_0_y1_x1_tiles.lz"

KeyWorldScreenHeader_62_11::
KeyWorld0F_0_Y1X1_Header::
    db $06, $00, $01, $09, $0f, $33, $0c, $00 ; entry 0

; LZSS-compressed: 130 bytes that expand to 360 (E-0016, E-0017)
KeyWorld0F_0_Y1X1_Tiles::
    INCBIN "maps/key_worlds/0_f_0_y1_x1_tiles.lz"

KeyWorldScreenHeader_62_12::
KeyWorld1E_0_Y3X2_Header::
    db $04, $00, $07, $08, $0f, $33, $0d, $00 ; entry 0

; LZSS-compressed: 95 bytes that expand to 360 (E-0016, E-0017)
KeyWorld1E_0_Y3X2_Tiles::
    INCBIN "maps/key_worlds/1_e_0_y3_x2_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_62_13::
KeyWorld1F_0_Y3X1_Header::
    db $05, $03, $07, $08, $0a, $33, $0e, $00 ; entry 0

; LZSS-compressed: 87 bytes that expand to 360 (E-0016, E-0017)
KeyWorld1F_0_Y3X1_Tiles::
    INCBIN "maps/key_worlds/1_f_0_y3_x1_tiles.lz"

KeyWorldScreenHeader_62_14::
KeyWorld28_0_Y2X3_Header::
    db $01, $05, $07, $08, $0c, $33, $0f, $00 ; entry 0

; LZSS-compressed: 147 bytes that expand to 360 (E-0016, E-0017)
KeyWorld28_0_Y2X3_Tiles::
    INCBIN "maps/key_worlds/28_0_y2_x3_tiles.lz"

; an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling
; a gap (E-0222)
KeyWorldScreenHeader62_1::
    db $06, $04, $06, $09, $0b, $33, $10, $00 ; entry 0

; LZSS-compressed: 119 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen62_1::
    INCBIN "maps/key_worlds/screen62_1.lz"

; LZSS-compressed: 20 bytes that expand to 360 (E-0016, E-0017)
KeyWorld01_0_Y2X1_Attrs::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

; LZSS-compressed: 26 bytes that expand to 360 (E-0016, E-0017)
KeyWorld04_0_Y2X2_Attrs::
    db $68, $01, $00, $01, $00, $00, $0f, $42, $09, $09, $00, $44, $0f, $13, $00, $7d
    db $0f, $4d, $00, $dd, $0f, $4d, $00, $00, $0f, $17

; LZSS-compressed: 85 bytes that expand to 360 (E-0016, E-0017)
KeyWorld04_0_Y1X2_Attrs::
    INCBIN "maps/key_worlds/04_0_y1_x2_attrs.lz"

; LZSS-compressed: 28 bytes that expand to 360 (E-0016, E-0017)
KeyWorld11_1_Y1X1_Attrs::
    db $68, $01, $00, $01, $00, $00, $0f, $42, $09, $09, $00, $44, $0f, $39, $09, $09
    db $00, $92, $0f, $4d, $00, $b6, $0f, $03, $00, $00, $0f, $39

KeyWorld01_0_Y1X2_Attrs::
    db $68, $01, $00, $01, $00, $00, $0f, $42, $09, $09, $00, $44, $0f, $39, $09, $09
    db $00, $92, $0f, $3b, $00, $f3, $0f, $4d, $00, $00, $0f, $01

; LZSS-compressed: 67 bytes that expand to 360 (E-0016, E-0017)
KeyWorld04_0_Y2X1_Attrs::
    INCBIN "maps/key_worlds/04_0_y2_x1_attrs.lz"

KeyWorld02_0_Y1X2_Attrs::
    db $68, $01, $00, $01, $00, $00, $0f, $42, $09, $09, $00, $44, $0f, $39, $09, $09
    db $00, $92, $0f, $13, $00, $54, $0f, $3d, $00, $00, $0f, $39

; LZSS-compressed: 43 bytes that expand to 360 (E-0016, E-0017)
KeyWorld02_0_Y1X1_Attrs::
    db $68, $01, $00, $01, $00, $00, $0f, $48, $03, $03, $00, $4a, $0f, $0d, $03, $00
    db $7e, $01, $00, $5a, $0a, $00, $7e, $0f, $05, $00, $4c, $0e, $00, $5c, $0c, $00
    db $a6, $0f, $13, $00, $5a, $0f, $11, $00, $00, $0f, $3f

; LZSS-compressed: 69 bytes that expand to 360 (E-0016, E-0017)
KeyWorld06_0_Y1X2_Attrs::
    INCBIN "maps/key_worlds/06_0_y1_x2_attrs.lz"

; LZSS-compressed: 45 bytes that expand to 360 (E-0016, E-0017)
KeyWorld1C_1_Y2X2_Attrs::
    db $68, $01, $00, $01, $00, $00, $0f, $1c, $03, $03, $00, $1e, $0f, $11, $03, $00
    db $56, $01, $00, $48, $0f, $15, $00, $30, $0a, $00, $7e, $0f, $01, $00, $7c, $0f
    db $17, $00, $a8, $0f, $1b, $00, $48, $0f, $0f, $00, $12, $1f, $35

; LZSS-compressed: 55 bytes that expand to 360 (E-0016, E-0017)
KeyWorld2A_0_Y1X1_Attrs::
    db $68, $01, $00, $01, $00, $00, $0f, $1a, $03, $03, $00, $1c, $0f, $11, $03, $00
    db $54, $01, $00, $46, $0f, $0d, $00, $54, $02, $00, $6c, $0f, $0f, $00, $52, $02
    db $00, $44, $0f, $01, $00, $1c, $0f, $03, $00, $58, $0e, $00, $2c, $0f, $05, $00
    db $a6, $0f, $15, $00, $12, $1f, $31

; LZSS-compressed: 53 bytes that expand to 360 (E-0016, E-0017)
KeyWorld0F_0_Y1X1_Attrs::
    db $68, $01, $00, $01, $00, $00, $0f, $1c, $03, $03, $00, $1e, $0f, $11, $03, $00
    db $56, $03, $00, $4a, $0f, $11, $00, $46, $0f, $01, $00, $84, $0f, $0d, $00, $7c
    db $0f, $0b, $00, $5a, $08, $00, $cc, $0f, $01, $00, $54, $0f, $17, $00, $a2, $0f
    db $17, $00, $00, $0f, $0d

; LZSS-compressed: 20 bytes that expand to 360 (E-0016, E-0017)
KeyWorld1E_0_Y3X2_Attrs::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

KeyWorld1F_0_Y3X1_Attrs::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

; LZSS-compressed: 31 bytes that expand to 360 (E-0016, E-0017)
KeyWorld28_0_Y2X3_Attrs::
    db $68, $01, $00, $01, $00, $00, $0f, $46, $02, $00, $5a, $01, $00, $4c, $0f, $35
    db $00, $5a, $02, $00, $9a, $0f, $3d, $00, $4c, $0f, $0f, $00, $00, $0f, $35

; LZSS-compressed: 34 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen62_2::
    db $68, $01, $00, $01, $00, $00, $0f, $40, $02, $00, $54, $03, $00, $48, $0f, $0b
    db $00, $54, $04, $00, $58, $08, $00, $7a, $0f, $4d, $00, $4e, $0f, $19, $00, $00
    db $0f, $3b

; compressed BG tiles (2048 bytes, 128 tiles) of key-world kind 4: entry 4 of KeyWorldTilesetTable,
; decompressed to vTiles2 by LoadKeyWorldTilesetAndHeader
; LZSS-compressed: 1366 bytes that expand to 2048 (E-0016, E-0017)
KeyWorldTiles4::
    INCBIN "maps/key_worlds/tiles4.lz"

; entry 4 of KeyWorldTilesetTable; LoadKeyWorldTilesetAndHeader copies these $40 bytes to
; wBGPaletteBuffer (E-0139, C1)
; record: one CGB palette: 4 BGR555 colours
KeyWorldPalettes4::
    dw $7da0, $7fff, $2ab7, $0063 ; entry 0
    dw $0160, $3fbf, $03e2, $0000 ; entry 1
    dw $01c4, $03ff, $0348, $0084 ; entry 2
    dw $01c4, $7fff, $0348, $0084 ; entry 3
    dw $158f, $2ab7, $03e2, $0000 ; entry 4
    dw $0171, $3fbf, $03e2, $0000 ; entry 5
    dw $1415, $7fff, $03e2, $0000 ; entry 6
    dw $318c, $7fff, $5294, $0000 ; entry 7

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_62_15::
KeyWorld00_0_Y1X1_Header::
    db $03, $04, $05, $0c, $0e, $33, $35, $00 ; entry 0

; LZSS-compressed: 144 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y1X1_Tiles::
    INCBIN "maps/key_worlds/00_0_y1_x1_tiles.lz"

KeyWorldScreenHeader_62_16::
KeyWorld23_0_Y1X1_Header::
    db $04, $04, $05, $0c, $0e, $33, $36, $00 ; entry 0

; LZSS-compressed: 155 bytes that expand to 360 (E-0016, E-0017)
KeyWorld23_0_Y1X1_Tiles::
    INCBIN "maps/key_worlds/23_0_y1_x1_tiles.lz"

KeyWorldScreenHeader_62_17::
KeyWorld40_1_Y2X1_Header::
    db $06, $00, $04, $05, $0e, $33, $37, $00 ; entry 0

; LZSS-compressed: 125 bytes that expand to 360 (E-0016, E-0017)
KeyWorld40_1_Y2X1_Tiles::
    INCBIN "maps/key_worlds/40_1_y2_x1_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_62_18::
KeyWorld10_0_Y1X1_Header::
    db $00, $04, $05, $0c, $0e, $33, $38, $00 ; entry 0

; LZSS-compressed: 161 bytes that expand to 360 (E-0016, E-0017)
KeyWorld10_0_Y1X1_Tiles::
    INCBIN "maps/key_worlds/10_0_y1_x1_tiles.lz"

KeyWorldScreenHeader_62_19::
KeyWorld12_0_Y1X1_Header::
    db $05, $04, $05, $0c, $0e, $33, $39, $00 ; entry 0

; LZSS-compressed: 136 bytes that expand to 360 (E-0016, E-0017)
KeyWorld12_0_Y1X1_Tiles::
    INCBIN "maps/key_worlds/12_0_y1_x1_tiles.lz"

KeyWorldScreenHeader_62_20::
KeyWorld39_1_Y1X0_Header::
    db $06, $04, $05, $0c, $0e, $33, $3a, $00 ; entry 0

; LZSS-compressed: 182 bytes that expand to 360 (E-0016, E-0017)
KeyWorld39_1_Y1X0_Tiles::
    INCBIN "maps/key_worlds/39_1_y1_x0_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_62_21::
KeyWorld12_0_Y3X1_Header::
    db $01, $04, $05, $0d, $0e, $33, $3b, $00 ; entry 0

; LZSS-compressed: 140 bytes that expand to 360 (E-0016, E-0017)
KeyWorld12_0_Y3X1_Tiles::
    INCBIN "maps/key_worlds/12_0_y3_x1_tiles.lz"

KeyWorldScreenHeader_62_22::
KeyWorld1E_0_Y1X1_Header::
    db $00, $04, $05, $07, $0e, $33, $3c, $00 ; entry 0

; LZSS-compressed: 122 bytes that expand to 360 (E-0016, E-0017)
KeyWorld1E_0_Y1X1_Tiles::
    INCBIN "maps/key_worlds/1_e_0_y1_x1_tiles.lz"

KeyWorldScreenHeader_62_23::
KeyWorld16_0_Y3X1_Header::
    db $01, $04, $06, $08, $0b, $33, $3d, $00 ; entry 0

; LZSS-compressed: 204 bytes that expand to 360 (E-0016, E-0017)
KeyWorld16_0_Y3X1_Tiles::
    INCBIN "maps/key_worlds/16_0_y3_x1_tiles.lz"

; LZSS-compressed: 45 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y1X1_Attrs::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $52, $0f, $3e, $03, $03, $00, $a0
    db $0f, $11, $03, $03, $00, $c6, $0f, $11, $00, $d8, $00, $00, $ee, $0f, $0f, $00
    db $fe, $02, $00, $16, $1f, $0d, $00, $24, $14, $00, $3e, $1f, $03

; LZSS-compressed: 67 bytes that expand to 360 (E-0016, E-0017)
KeyWorld23_0_Y1X1_Attrs::
    INCBIN "maps/key_worlds/23_0_y1_x1_attrs.lz"

; LZSS-compressed: 31 bytes that expand to 360 (E-0016, E-0017)
KeyWorld40_1_Y2X1_Attrs::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $4c, $0f, $38, $03, $00, $ac, $03
    db $00, $a0, $0f, $0b, $00, $ac, $04, $00, $c6, $0f, $4d, $00, $fe, $0f, $1b

; LZSS-compressed: 61 bytes that expand to 360 (E-0016, E-0017)
KeyWorld10_0_Y1X1_Attrs::
    db $68, $01, $00, $01, $00, $00, $0f, $1e, $02, $00, $32, $01, $00, $24, $0f, $0b
    db $00, $32, $02, $00, $36, $0a, $00, $56, $0e, $00, $32, $0f, $11, $00, $30, $0c
    db $03, $03, $03, $03, $00, $a0, $0f, $07, $00, $aa, $06, $00, $c4, $0f, $09, $00
    db $a8, $08, $00, $ec, $0f, $07, $00, $f4, $0c, $00, $16, $1f, $2b

; LZSS-compressed: 38 bytes that expand to 360 (E-0016, E-0017)
KeyWorld12_0_Y1X1_Attrs::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $52, $0f, $3e, $03, $03, $00, $a0
    db $0f, $4d, $00, $c4, $0f, $01, $03, $03, $00, $16, $1f, $0d, $00, $28, $10, $00
    db $4a, $12, $00, $40, $1f, $01

; LZSS-compressed: 65 bytes that expand to 360 (E-0016, E-0017)
KeyWorld39_1_Y1X0_Attrs::
    INCBIN "maps/key_worlds/39_1_y1_x0_attrs.lz"

; LZSS-compressed: 54 bytes that expand to 360 (E-0016, E-0017)
KeyWorld12_0_Y3X1_Attrs::
    db $68, $01, $00, $01, $00, $00, $0f, $48, $03, $03, $03, $03, $00, $4c, $0f, $15
    db $00, $5e, $0c, $00, $84, $0f, $07, $00, $5e, $0a, $00, $ac, $0f, $01, $00, $82
    db $0f, $17, $00, $58, $02, $00, $f0, $0f, $0b, $00, $5c, $04, $00, $16, $1f, $11
    db $00, $84, $0c, $00, $4a, $16

; LZSS-compressed: 41 bytes that expand to 360 (E-0016, E-0017)
KeyWorld1E_0_Y1X1_Attrs::
    db $68, $01, $00, $01, $00, $00, $0f, $46, $03, $00, $5a, $01, $00, $4c, $0f, $15
    db $00, $5e, $0a, $00, $82, $0f, $01, $00, $80, $0f, $11, $00, $82, $04, $00, $c2
    db $0f, $35, $00, $ca, $0a, $00, $18, $1f, $29

; LZSS-compressed: 81 bytes that expand to 360 (E-0016, E-0017)
KeyWorld16_0_Y3X1_Attrs::
    INCBIN "maps/key_worlds/16_0_y3_x1_attrs.lz"

; compressed BG tiles (2048 bytes, 128 tiles) of key-world kind 8: entry 8 of KeyWorldTilesetTable,
; decompressed to vTiles2 by LoadKeyWorldTilesetAndHeader
; LZSS-compressed: 1243 bytes that expand to 2048 (E-0016, E-0017)
KeyWorldTiles8::
    INCBIN "maps/key_worlds/tiles8.lz"

; entry 8 of KeyWorldTilesetTable; LoadKeyWorldTilesetAndHeader copies these $40 bytes to
; wBGPaletteBuffer (E-0139, C1)
; record: one CGB palette: 4 BGR555 colours
KeyWorldPalettes8::
    dw $7da0, $7fff, $7fe0, $0063 ; entry 0
    dw $0188, $3fbf, $0210, $0000 ; entry 1
    dw $012f, $3fbf, $01d5, $0000 ; entry 2
    dw $012f, $3fbf, $01d5, $0000 ; entry 3
    dw $318c, $3fbf, $2a13, $0000 ; entry 4
    dw $0171, $3fbf, $2a13, $0000 ; entry 5
    dw $1415, $3fbf, $25f5, $0000 ; entry 6
    dw $318c, $7fff, $5294, $0000 ; entry 7

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_62_24::
KeyWorld32_0_Y3X2_Header::
    db $05, $02, $06, $09, $0d, $33, $59, $00 ; entry 0

; LZSS-compressed: 125 bytes that expand to 360 (E-0016, E-0017)
KeyWorld32_0_Y3X2_Tiles::
    INCBIN "maps/key_worlds/32_0_y3_x2_tiles.lz"

; an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling
; a gap (E-0222)
KeyWorldScreenHeader62_2::
    db $06, $02, $07, $09, $0f, $33, $5a, $00 ; entry 0

; LZSS-compressed: 151 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen62_3::
    INCBIN "maps/key_worlds/screen62_3.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_62_25::
KeyWorld50_5_Y0X0_Header::
    db $07, $02, $06, $09, $0d, $33, $5b, $00 ; entry 0

; LZSS-compressed: 127 bytes that expand to 360 (E-0016, E-0017)
KeyWorld50_5_Y0X0_Tiles::
    INCBIN "maps/key_worlds/50_5_y0_x0_tiles.lz"

; an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling
; a gap (E-0222)
KeyWorldScreenHeader62_3::
    db $02, $02, $03, $06, $0d, $33, $5c, $00 ; entry 0

; LZSS-compressed: 156 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen62_4::
    INCBIN "maps/key_worlds/screen62_4.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_62_26::
KeyWorld47_2_Y0X2_Header::
    db $03, $01, $04, $09, $0a, $33, $5d, $00 ; entry 0

; LZSS-compressed: 191 bytes that expand to 360 (E-0016, E-0017)
KeyWorld47_2_Y0X2_Tiles::
    INCBIN "maps/key_worlds/47_2_y0_x2_tiles.lz"

KeyWorldScreenHeader_62_27::
KeyWorld40_2_Y1X3_Header::
    db $07, $04, $07, $09, $0b, $33, $5e, $00 ; entry 0

; LZSS-compressed: 179 bytes that expand to 360 (E-0016, E-0017)
KeyWorld40_2_Y1X3_Tiles::
    INCBIN "maps/key_worlds/40_2_y1_x3_tiles.lz"

KeyWorldScreenHeader_62_28::
KeyWorld44_3_Y3X1_Header::
    db $ff, $02, $03, $07, $0b, $33, $5f, $00 ; entry 0

; LZSS-compressed: 155 bytes that expand to 360 (E-0016, E-0017)
KeyWorld44_3_Y3X1_Tiles::
    INCBIN "maps/key_worlds/44_3_y3_x1_tiles.lz"

; an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling
; a gap (E-0222)
; record: screen header
KeyWorldScreenHeader62_4::
    db $ff, $00, $08, $07, $0f, $33, $60, $00 ; entry 0

; LZSS-compressed: 164 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen62_5::
    INCBIN "maps/key_worlds/screen62_5.lz"

KeyWorldScreenHeader62_5::
    db $07, $05, $0a, $0b, $0d, $33, $61, $00 ; entry 0

; LZSS-compressed: 189 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen62_6::
    INCBIN "maps/key_worlds/screen62_6.lz"

; LZSS-compressed: 59 bytes that expand to 360 (E-0016, E-0017)
KeyWorld32_0_Y3X2_Attrs::
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0a, $05, $00, $00, $0f, $0b, $00
    db $06, $06, $00, $28, $0f, $0f, $00, $08, $02, $00, $50, $0f, $11, $00, $08, $00
    db $00, $78, $0f, $01, $00, $76, $0f, $29, $00, $4c, $0f, $05, $00, $26, $0f, $17
    db $00, $26, $0a, $00, $18, $1f, $09, $00, $12, $0f, $0d

; LZSS-compressed: 77 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen62_7::
    INCBIN "maps/key_worlds/screen62_7.lz"

; LZSS-compressed: 46 bytes that expand to 360 (E-0016, E-0017)
KeyWorld50_5_Y0X0_Attrs::
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0a, $05, $00, $00, $0f, $4d, $00
    db $10, $0a, $00, $1c, $06, $00, $78, $0f, $01, $00, $72, $0e, $00, $1c, $04, $00
    db $a6, $0f, $01, $00, $76, $0f, $19, $00, $e6, $0f, $4d, $00, $f6, $0a

; LZSS-compressed: 72 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen62_8::
    INCBIN "maps/key_worlds/screen62_8.lz"

; LZSS-compressed: 70 bytes that expand to 360 (E-0016, E-0017)
KeyWorld47_2_Y0X2_Attrs::
    INCBIN "maps/key_worlds/47_2_y0_x2_attrs.lz"

; LZSS-compressed: 90 bytes that expand to 360 (E-0016, E-0017)
KeyWorld40_2_Y1X3_Attrs::
    INCBIN "maps/key_worlds/40_2_y1_x3_attrs.lz"

; LZSS-compressed: 64 bytes that expand to 360 (E-0016, E-0017)
KeyWorld44_3_Y3X1_Attrs::
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0a, $05, $00, $00, $0f, $0b, $00
    db $08, $06, $00, $28, $0f, $0d, $00, $04, $04, $00, $50, $0f, $29, $00, $12, $02
    db $00, $0e, $0a, $00, $a0, $0f, $05, $00, $0a, $06, $00, $a0, $04, $00, $ca, $0f
    db $01, $00, $f0, $0a, $00, $ec, $0f, $0d, $00, $28, $0f, $15, $00, $12, $0f, $0d

; LZSS-compressed: 79 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen62_9::
    INCBIN "maps/key_worlds/screen62_9.lz"

; LZSS-compressed: 88 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen62_10::
    INCBIN "maps/key_worlds/screen62_10.lz"

; an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling
; a gap (E-0222)
; record: screen header
KeyWorldScreenHeader62_6::
    db $06, $06, $08, $09, $0b, $33, $7d, $00 ; entry 0

KeyWorldScreen62_11::
    INCBIN "maps/key_worlds/screen62_11.lz"

; the 8-byte header of the screen stream that follows (E-0222)
KeyWorldScreenHeader_62_29::
KeyWorld30_2_Y0X3_Header::
    db $ff, $ff, $ff, $ff, $ff, $33, $7e, $00 ; entry 0

; LZSS-compressed: 84 bytes that expand to 360 (E-0016, E-0017)
KeyWorld30_2_Y0X3_Tiles::
    INCBIN "maps/key_worlds/30_2_y0_x3_tiles.lz"

KeyWorldScreenHeader_62_30::
KeyWorld3C_1_Y3X0_Header::
    db $ff, $08, $09, $0a, $0b, $33, $7f, $00 ; entry 0

; LZSS-compressed: 117 bytes that expand to 360 (E-0016, E-0017)
KeyWorld3C_1_Y3X0_Tiles::
    INCBIN "maps/key_worlds/3_c_1_y3_x0_tiles.lz"

; an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling
; a gap (E-0222)
; record: screen header
KeyWorldScreenHeader62_7::
    db $ff, $ff, $ff, $ff, $ff, $33, $80, $00 ; entry 0

KeyWorldScreen62_12::
    INCBIN "maps/key_worlds/screen62_12.lz"

; the 8-byte header of the screen stream that follows (E-0222)
KeyWorldScreenHeader_62_31::
KeyWorld4E_2_Y3X0_Header::
    db $04, $05, $06, $0b, $0c, $33, $81, $00 ; entry 0

; LZSS-compressed: 123 bytes that expand to 360 (E-0016, E-0017)
KeyWorld4E_2_Y3X0_Tiles::
    INCBIN "maps/key_worlds/4_e_2_y3_x0_tiles.lz"

KeyWorldScreenHeader_62_32::
KeyWorld40_2_Y2X3_Header::
    db $01, $04, $06, $07, $09, $33, $82, $00 ; entry 0

; LZSS-compressed: 179 bytes that expand to 360 (E-0016, E-0017)
KeyWorld40_2_Y2X3_Tiles::
    INCBIN "maps/key_worlds/40_2_y2_x3_tiles.lz"

KeyWorldScreenHeader_62_33::
KeyWorld40_5_Y0X0_Header::
    db $04, $03, $05, $0a, $0b, $33, $83, $00 ; entry 0

; LZSS-compressed: 130 bytes that expand to 360 (E-0016, E-0017)
KeyWorld40_5_Y0X0_Tiles::
    INCBIN "maps/key_worlds/40_5_y0_x0_tiles.lz"

; record: screen header
KeyWorldScreenHeader_62_34::
KeyWorld3F_3_Y0X1_Header::
    db $06, $04, $06, $0d, $0e, $33, $84, $00 ; entry 0

; LZSS-compressed: 146 bytes that expand to 360 (E-0016, E-0017)
KeyWorld3F_3_Y0X1_Tiles::
    INCBIN "maps/key_worlds/3_f_3_y0_x1_tiles.lz"

; an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling
; a gap (E-0222)
KeyWorldScreenHeader62_8::
    db $06, $00, $03, $07, $08, $33, $85, $00 ; entry 0

; LZSS-compressed: 211 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen62_13::
    INCBIN "maps/key_worlds/screen62_13.lz"

; LZSS-compressed: 39 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen62_14::
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0a, $05, $00, $00, $0f, $4d, $00
    db $10, $06, $00, $1e, $06, $00, $74, $0f, $13, $00, $14, $06, $00, $a4, $0f, $2b
    db $00, $f5, $0f, $4d, $00, $08, $1e

; LZSS-compressed: 40 bytes that expand to 360 (E-0016, E-0017)
KeyWorld30_2_Y0X3_Attrs::
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0a, $05, $00, $00, $0f, $33, $03
    db $03, $02, $02, $02, $02, $00, $4c, $0f, $11, $00, $5a, $00, $00, $74, $0f, $13
    db $00, $ad, $0f, $4d, $00, $08, $1f, $47

; LZSS-compressed: 50 bytes that expand to 360 (E-0016, E-0017)
KeyWorld3C_1_Y3X0_Attrs::
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0a, $05, $00, $00, $0f, $09, $00
    db $0a, $06, $00, $26, $0f, $33, $00, $08, $0f, $15, $00, $06, $04, $00, $a0, $08
    db $00, $a8, $0f, $07, $00, $b0, $0c, $00, $d2, $0f, $03, $00, $fb, $0f, $4d, $00
    db $a0, $08

; LZSS-compressed: 52 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen62_15::
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0a, $05, $00, $00, $0f, $0f, $02
    db $02, $00, $24, $0f, $11, $00, $36, $02, $00, $4e, $0f, $0d, $00, $5c, $04, $00
    db $76, $0f, $0f, $02, $02, $00, $00, $06, $00, $a4, $0f, $07, $00, $d1, $0f, $4d
    db $00, $08, $1f, $23

; LZSS-compressed: 48 bytes that expand to 360 (E-0016, E-0017)
KeyWorld4E_2_Y3X0_Attrs::
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0a, $05, $00, $00, $0f, $09, $00
    db $0a, $06, $00, $26, $0f, $31, $00, $30, $08, $00, $76, $0f, $13, $00, $00, $0f
    db $1d, $00, $08, $0f, $09, $00, $00, $06, $00, $f2, $0f, $05, $00, $10, $1f, $37

; LZSS-compressed: 81 bytes that expand to 360 (E-0016, E-0017)
KeyWorld40_2_Y2X3_Attrs::
    INCBIN "maps/key_worlds/40_2_y2_x3_attrs.lz"

; LZSS-compressed: 54 bytes that expand to 360 (E-0016, E-0017)
KeyWorld40_5_Y0X0_Attrs::
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0a, $05, $00, $00, $0f, $07, $00
    db $0a, $06, $00, $24, $0f, $09, $00, $2e, $0a, $00, $4e, $0f, $2d, $00, $2e, $0f
    db $13, $00, $08, $02, $00, $06, $06, $00, $c4, $0f, $09, $00, $00, $08, $00, $ec
    db $0f, $07, $00, $14, $1f, $3b

; LZSS-compressed: 80 bytes that expand to 360 (E-0016, E-0017)
KeyWorld3F_3_Y0X1_Attrs::
    INCBIN "maps/key_worlds/3_f_3_y0_x1_attrs.lz"

; LZSS-compressed: 100 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen62_16::
    INCBIN "maps/key_worlds/screen62_16.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_62_35::
KeyWorld10_1_Y0X2_Header::
    db $01, $02, $04, $09, $0d, $01, $a1, $00 ; entry 0

; LZSS-compressed: 130 bytes that expand to 360 (E-0016, E-0017)
KeyWorld10_1_Y0X2_Tiles::
    INCBIN "maps/key_worlds/10_1_y0_x2_tiles.lz"

KeyWorldScreenHeader_62_36::
KeyWorld08_0_Y1X2_Header::
    db $00, $02, $04, $09, $0d, $01, $a2, $00 ; entry 0

; LZSS-compressed: 192 bytes that expand to 360 (E-0016, E-0017)
KeyWorld08_0_Y1X2_Tiles::
    INCBIN "maps/key_worlds/08_0_y1_x2_tiles.lz"

KeyWorldScreenHeader_62_37::
KeyWorld05_0_Y2X1_Header::
    db $03, $02, $04, $09, $0d, $30, $a3, $00 ; entry 0

; LZSS-compressed: 161 bytes that expand to 360 (E-0016, E-0017)
KeyWorld05_0_Y2X1_Tiles::
    INCBIN "maps/key_worlds/05_0_y2_x1_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_62_38::
KeyWorld17_1_Y0X2_Header::
    db $ff, $02, $04, $05, $0d, $30, $a4, $00 ; entry 0

; LZSS-compressed: 172 bytes that expand to 360 (E-0016, E-0017)
KeyWorld17_1_Y0X2_Tiles::
    INCBIN "maps/key_worlds/17_1_y0_x2_tiles.lz"

KeyWorldScreenHeader_62_39::
KeyWorld1C_1_Y1X2_Header::
    db $05, $02, $04, $09, $0d, $01, $a5, $00 ; entry 0

; LZSS-compressed: 148 bytes that expand to 360 (E-0016, E-0017)
KeyWorld1C_1_Y1X2_Tiles::
    INCBIN "maps/key_worlds/1_c_1_y1_x2_tiles.lz"

KeyWorldScreenHeader_62_40::
KeyWorld10_1_Y2X1_Header::
    db $05, $02, $04, $09, $0d, $01, $a6, $00 ; entry 0

; LZSS-compressed: 141 bytes that expand to 360 (E-0016, E-0017)
KeyWorld10_1_Y2X1_Tiles::
    INCBIN "maps/key_worlds/10_1_y2_x1_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_62_41::
KeyWorld1C_1_Y0X1_Header::
    db $ff, $02, $04, $06, $0d, $01, $a7, $00 ; entry 0

; LZSS-compressed: 172 bytes that expand to 360 (E-0016, E-0017)
KeyWorld1C_1_Y0X1_Tiles::
    INCBIN "maps/key_worlds/1_c_1_y0_x1_tiles.lz"

KeyWorldScreenHeader_62_42::
KeyWorld22_1_Y1X0_Header::
    db $ff, $02, $04, $09, $0d, $01, $a8, $00 ; entry 0

; LZSS-compressed: 170 bytes that expand to 360 (E-0016, E-0017)
KeyWorld22_1_Y1X0_Tiles::
    INCBIN "maps/key_worlds/22_1_y1_x0_tiles.lz"

KeyWorldScreenHeader_62_43::
KeyWorld28_1_Y2X0_Header::
    db $00, $02, $09, $0b, $0c, $01, $a9, $00 ; entry 0

; LZSS-compressed: 215 bytes that expand to 360 (E-0016, E-0017)
KeyWorld28_1_Y2X0_Tiles::
    INCBIN "maps/key_worlds/28_1_y2_x0_tiles.lz"

; LZSS-compressed: 40 bytes that expand to 360 (E-0016, E-0017)
KeyWorld10_1_Y0X2_Attrs::
    db $68, $01, $02, $01, $02, $00, $05, $02, $f6, $ff, $15, $02, $08, $06, $02, $28
    db $0f, $0d, $02, $08, $04, $02, $50, $0f, $0f, $02, $08, $02, $02, $78, $0f, $11
    db $02, $af, $0f, $4d, $02, $08, $1f, $45

; LZSS-compressed: 77 bytes that expand to 360 (E-0016, E-0017)
KeyWorld08_0_Y1X2_Attrs::
    INCBIN "maps/key_worlds/08_0_y1_x2_attrs.lz"

; LZSS-compressed: 44 bytes that expand to 360 (E-0016, E-0017)
KeyWorld05_0_Y2X1_Attrs::
    db $68, $01, $03, $01, $03, $00, $05, $03, $f6, $ff, $11, $02, $02, $03, $1c, $0f
    db $11, $02, $02, $03, $42, $0f, $11, $03, $54, $02, $03, $04, $08, $03, $78, $0f
    db $03, $03, $a1, $0f, $4d, $03, $01, $1f, $4d, $03, $04, $02

; LZSS-compressed: 65 bytes that expand to 360 (E-0016, E-0017)
KeyWorld17_1_Y0X2_Attrs::
    INCBIN "maps/key_worlds/17_1_y0_x2_attrs.lz"

; LZSS-compressed: 33 bytes that expand to 360 (E-0016, E-0017)
KeyWorld1C_1_Y1X2_Attrs::
    db $68, $01, $02, $01, $02, $00, $05, $02, $f6, $ff, $15, $02, $04, $06, $02, $28
    db $0f, $11, $02, $08, $00, $02, $50, $0f, $3b, $02, $b1, $0f, $4d, $02, $08, $1f
    db $43

KeyWorld10_1_Y2X1_Attrs::
    INCBIN "maps/key_worlds/10_1_y2_x1_attrs.lz"

; LZSS-compressed: 54 bytes that expand to 360 (E-0016, E-0017)
KeyWorld1C_1_Y0X1_Attrs::
    db $68, $01, $02, $01, $02, $00, $05, $02, $f6, $ff, $13, $02, $f4, $ff, $01, $02
    db $f4, $fe, $02, $f2, $ff, $01, $02, $56, $0f, $07, $02, $7c, $06, $02, $7a, $0f
    db $09, $02, $a2, $08, $02, $a2, $0f, $05, $02, $b2, $0c, $02, $ca, $0f, $0d, $02
    db $fd, $0f, $4d, $02, $00, $06

KeyWorld22_1_Y1X0_Attrs::
    INCBIN "maps/key_worlds/22_1_y1_x0_attrs.lz"

; LZSS-compressed: 86 bytes that expand to 360 (E-0016, E-0017)
KeyWorld28_1_Y2X0_Attrs::
    INCBIN "maps/key_worlds/28_1_y2_x0_attrs.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_62_44::
KeyWorld10_0_Y1X0_Header::
    db $05, $03, $05, $08, $0a, $38, $c5, $00 ; entry 0

; LZSS-compressed: 145 bytes that expand to 360 (E-0016, E-0017)
KeyWorld10_0_Y1X0_Tiles::
    INCBIN "maps/key_worlds/10_0_y1_x0_tiles.lz"

KeyWorldScreenHeader_62_45::
KeyWorld02_0_Y1X0_Header::
    db $ff, $08, $09, $0a, $0d, $05, $c6, $00 ; entry 0

; LZSS-compressed: 110 bytes that expand to 360 (E-0016, E-0017)
KeyWorld02_0_Y1X0_Tiles::
    INCBIN "maps/key_worlds/02_0_y1_x0_tiles.lz"

KeyWorldScreenHeader_62_46::
KeyWorld02_0_Y2X0_Header::
    db $ff, $0b, $0d, $0e, $0f, $05, $c7, $00 ; entry 0

; LZSS-compressed: 128 bytes that expand to 360 (E-0016, E-0017)
KeyWorld02_0_Y2X0_Tiles::
    INCBIN "maps/key_worlds/02_0_y2_x0_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_62_47::
KeyWorld00_0_Y1X0_Header::
    db $ff, $0b, $0c, $0d, $0f, $05, $c8, $00 ; entry 0

; LZSS-compressed: 148 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y1X0_Tiles::
    INCBIN "maps/key_worlds/00_0_y1_x0_tiles.lz"

KeyWorldScreenHeader_62_48::
KeyWorld00_0_Y2X0_Header::
    db $06, $03, $07, $08, $0a, $38, $c9, $00 ; entry 0

; LZSS-compressed: 153 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y2X0_Tiles::
    INCBIN "maps/key_worlds/00_0_y2_x0_tiles.lz"

KeyWorldScreenHeader_62_49::
KeyWorld01_0_Y2X0_Header::
    db $07, $03, $05, $0b, $0d, $38, $ca, $00 ; entry 0

; LZSS-compressed: 205 bytes that expand to 360 (E-0016, E-0017)
KeyWorld01_0_Y2X0_Tiles::
    INCBIN "maps/key_worlds/01_0_y2_x0_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_62_50::
KeyWorld04_0_Y1X0_Header::
    db $04, $03, $04, $05, $0b, $38, $cb, $00 ; entry 0

; LZSS-compressed: 189 bytes that expand to 360 (E-0016, E-0017)
KeyWorld04_0_Y1X0_Tiles::
    INCBIN "maps/key_worlds/04_0_y1_x0_tiles.lz"

KeyWorldScreenHeader_62_51::
KeyWorld04_0_Y2X0_Header::
    db $05, $00, $03, $07, $08, $38, $cc, $00 ; entry 0

; LZSS-compressed: 213 bytes that expand to 360 (E-0016, E-0017)
KeyWorld04_0_Y2X0_Tiles::
    INCBIN "maps/key_worlds/04_0_y2_x0_tiles.lz"

KeyWorldScreenHeader_62_52::
KeyWorld1E_0_Y2X0_Header::
    db $07, $04, $06, $09, $0b, $38, $cd, $00 ; entry 0

; LZSS-compressed: 209 bytes that expand to 360 (E-0016, E-0017)
KeyWorld1E_0_Y2X0_Tiles::
    INCBIN "maps/key_worlds/1_e_0_y2_x0_tiles.lz"

; LZSS-compressed: 43 bytes that expand to 360 (E-0016, E-0017)
KeyWorld10_0_Y1X0_Attrs::
    db $68, $01, $02, $02, $ff, $f6, $01, $02, $0a, $05, $02, $00, $0f, $4d, $02, $10
    db $06, $02, $1e, $06, $02, $74, $0f, $09, $02, $7e, $0a, $02, $9e, $0f, $07, $02
    db $7c, $0f, $15, $02, $18, $0f, $4d, $02, $04, $1f, $01

; LZSS-compressed: 48 bytes that expand to 360 (E-0016, E-0017)
KeyWorld02_0_Y1X0_Attrs::
    db $68, $01, $03, $03, $ff, $f6, $01, $03, $0a, $05, $03, $00, $0f, $0f, $02, $02
    db $03, $24, $0f, $11, $02, $03, $5c, $01, $03, $4e, $0f, $4d, $03, $72, $0f, $03
    db $03, $4c, $0f, $01, $03, $24, $0f, $25, $03, $0c, $0f, $17, $03, $0e, $0f, $07

; LZSS-compressed: 47 bytes that expand to 360 (E-0016, E-0017)
KeyWorld02_0_Y2X0_Attrs::
    db $68, $01, $02, $02, $ff, $f6, $01, $02, $0a, $05, $02, $00, $0f, $0b, $02, $08
    db $06, $02, $28, $0f, $0d, $02, $08, $04, $02, $50, $0f, $0f, $02, $08, $02, $02
    db $78, $0f, $4d, $02, $4c, $0f, $25, $02, $20, $0f, $13, $02, $0a, $0f, $0b

; LZSS-compressed: 56 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y1X0_Attrs::
    db $68, $01, $03, $03, $ff, $f6, $01, $03, $0a, $05, $03, $00, $0f, $0b, $00, $00
    db $02, $02, $02, $02, $03, $24, $0f, $11, $03, $32, $00, $03, $4c, $0f, $15, $03
    db $36, $00, $03, $78, $0f, $4d, $03, $9c, $0c, $03, $34, $0f, $13, $03, $34, $04
    db $03, $16, $1f, $0d, $03, $0a, $0f, $0b

; LZSS-compressed: 40 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y2X0_Attrs::
    db $68, $01, $02, $02, $ff, $f6, $01, $02, $0a, $05, $02, $00, $0f, $05, $02, $0a
    db $06, $02, $22, $0f, $09, $02, $2c, $0c, $02, $4e, $0f, $4d, $02, $ae, $0f, $45
    db $02, $2a, $0f, $15, $02, $02, $0f, $13

; LZSS-compressed: 93 bytes that expand to 360 (E-0016, E-0017)
KeyWorld01_0_Y2X0_Attrs::
    INCBIN "maps/key_worlds/01_0_y2_x0_attrs.lz"

KeyWorld04_0_Y1X0_Attrs::
    db $68, $01, $02, $02, $ff, $f6, $01, $02, $0a, $05, $02, $00, $0f, $31, $02, $0a
    db $06, $02, $4e, $0f, $07, $02, $58, $08, $02, $74, $0f, $07, $02, $7c, $0c, $02
    db $9e, $0f, $09, $02, $04, $0a, $02, $c8, $0f, $2b, $02, $08, $00, $02, $06, $0e
    db $02, $1c, $1f, $01, $02, $04, $0f, $11

; LZSS-compressed: 69 bytes that expand to 360 (E-0016, E-0017)
KeyWorld04_0_Y2X0_Attrs::
    INCBIN "maps/key_worlds/04_0_y2_x0_attrs.lz"

; LZSS-compressed: 80 bytes that expand to 360 (E-0016, E-0017)
KeyWorld1E_0_Y2X0_Attrs::
    INCBIN "maps/key_worlds/1_e_0_y2_x0_attrs.lz"
    ds $2b1, $00
