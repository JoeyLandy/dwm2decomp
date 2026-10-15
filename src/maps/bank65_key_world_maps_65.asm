; ROM bank $65: key-world map screens
; The annotated listing of this bank is build/listing/bank65.asm.

SECTION "Bank 65", ROMX[$4000], BANK[$65]
    db $65

; entry 3 of KeyWorldTilesetTable; LoadKeyWorldTilesetAndHeader copies these $40 bytes to
; wBGPaletteBuffer (E-0139, C1)
; record: one CGB palette: 4 BGR555 colours
KeyWorldPalettes3::
    dw $7da0, $7fff, $7fe0, $0063 ; entry 0
    dw $026e, $3f7f, $02f3, $0188 ; entry 1
    dw $0152, $3f7f, $0218, $00c8 ; entry 2
    dw $2130, $3f7f, $39d9, $00c8 ; entry 3
    dw $158f, $3fbf, $2ab7, $0000 ; entry 4
    dw $0171, $3fbf, $2a13, $0000 ; entry 5
    dw $0018, $3f7f, $0218, $0000 ; entry 6
    dw $318c, $7fff, $5294, $0000 ; entry 7

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_65::
; another name for the data at KeyWorldScreenHeader_65, whose note is above (E-0381)
KeyWorld10_0_Y1X2_Header::
    db $06, $03, $08, $0b, $0d, $33, $2c, $00 ; entry 0

; LZSS-compressed: 123 bytes that expand to 360 (E-0016, E-0017)
KeyWorld10_0_Y1X2_Tiles::
    INCBIN "maps/key_worlds/10_0_y1_x2_tiles.lz"

KeyWorldScreenHeader_65_2::
; another name for the data at KeyWorldScreenHeader_65_2, whose note is above (E-0381)
KeyWorld15_1_Y1X2_Header::
    db $07, $03, $08, $0b, $0d, $33, $2d, $00 ; entry 0

; LZSS-compressed: 161 bytes that expand to 360 (E-0016, E-0017)
KeyWorld15_1_Y1X2_Tiles::
    INCBIN "maps/key_worlds/15_1_y1_x2_tiles.lz"

KeyWorldScreenHeader_65_3::
; another name for the data at KeyWorldScreenHeader_65_3, whose note is above (E-0381)
KeyWorld3C_1_Y3X2_Header::
    db $05, $05, $08, $0b, $0d, $33, $2e, $00 ; entry 0

KeyWorld3C_1_Y3X2_Tiles::
    INCBIN "maps/key_worlds/3_c_1_y3_x2_tiles.lz"

KeyWorldScreenHeader_65_4::
; another name for the data at KeyWorldScreenHeader_65_4, whose note is above (E-0381)
KeyWorld1E_0_Y1X2_Header::
    db $00, $03, $08, $0b, $0d, $33, $2f, $00 ; entry 0

; LZSS-compressed: 153 bytes that expand to 360 (E-0016, E-0017)
KeyWorld1E_0_Y1X2_Tiles::
    INCBIN "maps/key_worlds/1_e_0_y1_x2_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_65_5::
; another name for the data at KeyWorldScreenHeader_65_5, whose note is above (E-0381)
KeyWorld23_0_Y1X3_Header::
    db $03, $03, $08, $0b, $0d, $33, $30, $00 ; entry 0

; LZSS-compressed: 133 bytes that expand to 360 (E-0016, E-0017)
KeyWorld23_0_Y1X3_Tiles::
    INCBIN "maps/key_worlds/23_0_y1_x3_tiles.lz"

KeyWorldScreenHeader_65_6::
; another name for the data at KeyWorldScreenHeader_65_6, whose note is above (E-0381)
KeyWorld12_0_Y3X2_Header::
    db $00, $03, $08, $0b, $0d, $33, $31, $00 ; entry 0

; LZSS-compressed: 151 bytes that expand to 360 (E-0016, E-0017)
KeyWorld12_0_Y3X2_Tiles::
    INCBIN "maps/key_worlds/12_0_y3_x2_tiles.lz"

KeyWorldScreenHeader_65_7::
; another name for the data at KeyWorldScreenHeader_65_7, whose note is above (E-0381)
KeyWorld00_0_Y1X2_Header::
    db $ff, $02, $0b, $0d, $0f, $33, $32, $00 ; entry 0

; LZSS-compressed: 150 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y1X2_Tiles::
    INCBIN "maps/key_worlds/00_0_y1_x2_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_65_8::
; another name for the data at KeyWorldScreenHeader_65_8, whose note is above (E-0381)
KeyWorld32_1_Y2X0_Header::
    db $ff, $03, $08, $0b, $0d, $33, $33, $00 ; entry 0

; LZSS-compressed: 136 bytes that expand to 360 (E-0016, E-0017)
KeyWorld32_1_Y2X0_Tiles::
    INCBIN "maps/key_worlds/32_1_y2_x0_tiles.lz"

KeyWorldScreenHeader_65_9::
; another name for the data at KeyWorldScreenHeader_65_9, whose note is above (E-0381)
KeyWorld1F_1_Y0X2_Header::
    db $06, $02, $06, $09, $0d, $33, $34, $00 ; entry 0

; LZSS-compressed: 205 bytes that expand to 360 (E-0016, E-0017)
KeyWorld1F_1_Y0X2_Tiles::
    INCBIN "maps/key_worlds/1_f_1_y0_x2_tiles.lz"

; LZSS-compressed: 46 bytes that expand to 360 (E-0016, E-0017)
KeyWorld10_0_Y1X2_Attrs::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $40, $0f, $2c, $03, $03, $00, $8e
    db $0f, $15, $00, $a0, $0e, $00, $c8, $0f, $05, $00, $a0, $0c, $00, $f0, $0f, $07
    db $00, $a0, $0a, $00, $18, $1f, $09, $00, $a0, $08, $00, $40, $1f, $01

; LZSS-compressed: 85 bytes that expand to 360 (E-0016, E-0017)
KeyWorld15_1_Y1X2_Attrs::
    INCBIN "maps/key_worlds/15_1_y1_x2_attrs.lz"

; LZSS-compressed: 31 bytes that expand to 360 (E-0016, E-0017)
KeyWorld3C_1_Y3X2_Attrs::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $40, $0f, $2c, $03, $00, $a0, $03
    db $00, $94, $0f, $15, $00, $a6, $08, $00, $c8, $0f, $4d, $00, $00, $1f, $19

; LZSS-compressed: 57 bytes that expand to 360 (E-0016, E-0017)
KeyWorld1E_0_Y1X2_Attrs::
    db $68, $01, $00, $01, $00, $00, $0f, $1c, $02, $00, $30, $01, $00, $22, $0f, $0b
    db $00, $30, $02, $00, $30, $0a, $00, $54, $0e, $00, $58, $0c, $00, $76, $0f, $03
    db $03, $03, $03, $03, $00, $34, $0c, $00, $a0, $0f, $05, $00, $a0, $00, $00, $bc
    db $0f, $3d, $00, $ce, $08, $00, $18, $1f, $29

; LZSS-compressed: 36 bytes that expand to 360 (E-0016, E-0017)
KeyWorld23_0_Y1X3_Attrs::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $40, $0f, $2c, $03, $03, $00, $8e
    db $0f, $4d, $00, $b2, $0f, $05, $00, $b4, $0e, $00, $18, $1f, $05, $00, $40, $12
    db $00, $36, $1f, $0b

; LZSS-compressed: 76 bytes that expand to 360 (E-0016, E-0017)
KeyWorld12_0_Y3X2_Attrs::
    INCBIN "maps/key_worlds/12_0_y3_x2_attrs.lz"

; LZSS-compressed: 51 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y1X2_Attrs::
    db $68, $01, $00, $01, $00, $00, $0f, $44, $03, $03, $03, $03, $00, $48, $0f, $0f
    db $00, $58, $00, $00, $7e, $02, $00, $74, $0f, $05, $00, $5a, $00, $00, $7e, $06
    db $00, $9a, $0f, $09, $00, $80, $06, $00, $c0, $0f, $15, $00, $76, $0f, $17, $00
    db $fe, $0f, $2f

; LZSS-compressed: 63 bytes that expand to 360 (E-0016, E-0017)
KeyWorld32_1_Y2X0_Attrs::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $20, $0f, $0c, $02, $02, $02, $02
    db $00, $70, $0f, $09, $03, $03, $00, $9c, $02, $00, $a6, $00, $00, $80, $04, $00
    db $a0, $0f, $03, $00, $c8, $08, $00, $c2, $0f, $15, $00, $9a, $04, $00, $f2, $0f
    db $05, $00, $20, $0a, $00, $18, $1f, $07, $00, $1a, $1a, $00, $40, $1f, $01

; LZSS-compressed: 91 bytes that expand to 360 (E-0016, E-0017)
KeyWorld1F_1_Y0X2_Attrs::
    INCBIN "maps/key_worlds/1_f_1_y0_x2_attrs.lz"

; compressed BG tiles (2048 bytes, 128 tiles) of key-world kind 7: entry 7 of KeyWorldTilesetTable,
; decompressed to vTiles2 by LoadKeyWorldTilesetAndHeader
; LZSS-compressed: 1185 bytes that expand to 2048 (E-0016, E-0017)
KeyWorldTiles7::
    INCBIN "maps/key_worlds/tiles7.lz"

; entry 7 of KeyWorldTilesetTable; LoadKeyWorldTilesetAndHeader copies these $40 bytes to
; wBGPaletteBuffer (E-0139, C1)
; record: one CGB palette: 4 BGR555 colours
KeyWorldPalettes7::
    dw $1412, $7fff, $259f, $0063 ; entry 0
    dw $318c, $5ad6, $4631, $0000 ; entry 1
    dw $1415, $7dff, $7c18, $2c09 ; entry 2
    dw $318c, $5ad6, $4631, $0000 ; entry 3
    dw $318c, $5ad6, $2a13, $0000 ; entry 4
    dw $0171, $3fbf, $5294, $0000 ; entry 5
    dw $7da0, $3fbf, $5294, $0000 ; entry 6
    dw $318c, $7fff, $5294, $0000 ; entry 7

; an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling
; a gap (E-0222)
; record: screen header
KeyWorldScreenHeader65_1::
    db $03, $04, $06, $09, $0b, $33, $50, $00 ; entry 0

; LZSS-compressed: 136 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen65_1::
    INCBIN "maps/key_worlds/screen65_1.lz"

; the 8-byte header of the screen stream that follows (E-0222)
KeyWorldScreenHeader_65_10::
; another name for the data at KeyWorldScreenHeader_65_10, whose note is above (E-0381)
KeyWorld4C_4_Y0X3_Header::
    db $01, $04, $06, $09, $0b, $33, $51, $00 ; entry 0

; LZSS-compressed: 146 bytes that expand to 360 (E-0016, E-0017)
KeyWorld4C_4_Y0X3_Tiles::
    INCBIN "maps/key_worlds/4_c_4_y0_x3_tiles.lz"

KeyWorldScreenHeader_65_11::
; another name for the data at KeyWorldScreenHeader_65_11, whose note is above (E-0381)
KeyWorld41_2_Y2X2_Header::
    db $03, $04, $06, $09, $0b, $33, $52, $00 ; entry 0

; LZSS-compressed: 116 bytes that expand to 360 (E-0016, E-0017)
KeyWorld41_2_Y2X2_Tiles::
    INCBIN "maps/key_worlds/41_2_y2_x2_tiles.lz"

; an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling
; a gap (E-0222)
; record: screen header
KeyWorldScreenHeader65_2::
    db $01, $04, $06, $09, $0b, $33, $53, $00 ; entry 0

; LZSS-compressed: 182 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen65_2::
    INCBIN "maps/key_worlds/screen65_2.lz"

KeyWorldScreenHeader65_3::
    db $05, $04, $06, $09, $0b, $33, $54, $00 ; entry 0

; LZSS-compressed: 136 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen65_3::
    INCBIN "maps/key_worlds/screen65_3.lz"

; the 8-byte header of the screen stream that follows (E-0222)
KeyWorldScreenHeader_65_12::
; another name for the data at KeyWorldScreenHeader_65_12, whose note is above (E-0381)
KeyWorld4C_5_Y1X1_Header::
    db $04, $02, $07, $0b, $0f, $33, $55, $00 ; entry 0

; LZSS-compressed: 161 bytes that expand to 360 (E-0016, E-0017)
KeyWorld4C_5_Y1X1_Tiles::
    INCBIN "maps/key_worlds/4_c_5_y1_x1_tiles.lz"

; record: screen header
KeyWorldScreenHeader_65_13::
; another name for the data at KeyWorldScreenHeader_65_13, whose note is above (E-0381)
KeyWorld47_4_Y0X2_Header::
    db $ff, $02, $03, $04, $0b, $33, $56, $00 ; entry 0

; LZSS-compressed: 152 bytes that expand to 360 (E-0016, E-0017)
KeyWorld47_4_Y0X2_Tiles::
    INCBIN "maps/key_worlds/47_4_y0_x2_tiles.lz"

KeyWorldScreenHeader_65_14::
; another name for the data at KeyWorldScreenHeader_65_14, whose note is above (E-0381)
KeyWorld55_1_Y3X3_Header::
    db $ff, $00, $04, $0c, $0f, $33, $57, $00 ; entry 0

; LZSS-compressed: 172 bytes that expand to 360 (E-0016, E-0017)
KeyWorld55_1_Y3X3_Tiles::
    INCBIN "maps/key_worlds/55_1_y3_x3_tiles.lz"

; an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling
; a gap (E-0222)
KeyWorldScreenHeader65_4::
    db $01, $03, $06, $09, $0f, $33, $58, $00 ; entry 0

; LZSS-compressed: 216 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen65_4::
    INCBIN "maps/key_worlds/screen65_4.lz"

; LZSS-compressed: 62 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen65_5::
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0a, $05, $00, $00, $0f, $07, $00
    db $0a, $06, $00, $24, $0f, $09, $00, $2e, $0a, $00, $4e, $0f, $05, $00, $54, $0c
    db $00, $76, $0f, $03, $00, $7a, $0f, $13, $00, $52, $0f, $15, $00, $2c, $0f, $15
    db $00, $2c, $0a, $00, $02, $0e, $00, $22, $1f, $01, $00, $00, $0f, $0b

; LZSS-compressed: 86 bytes that expand to 360 (E-0016, E-0017)
KeyWorld4C_4_Y0X3_Attrs::
    INCBIN "maps/key_worlds/4_c_4_y0_x3_attrs.lz"

; LZSS-compressed: 40 bytes that expand to 360 (E-0016, E-0017)
KeyWorld41_2_Y2X2_Attrs::
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0a, $05, $00, $00, $0f, $4d, $00
    db $10, $08, $00, $1e, $06, $00, $76, $0f, $03, $00, $80, $0f, $0d, $00, $ac, $0f
    db $27, $00, $14, $0f, $4d, $00, $f6, $0a

; LZSS-compressed: 75 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen65_6::
    INCBIN "maps/key_worlds/screen65_6.lz"

; LZSS-compressed: 45 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen65_7::
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0a, $05, $00, $00, $0f, $03, $00
    db $0a, $06, $00, $20, $0f, $4d, $00, $8e, $0f, $0b, $00, $3c, $0f, $4d, $00, $c2
    db $0f, $03, $00, $06, $0a, $00, $22, $1f, $01, $00, $00, $0f, $0b

KeyWorld4C_5_Y1X1_Attrs::
    INCBIN "maps/key_worlds/4_c_5_y1_x1_attrs.lz"

; LZSS-compressed: 67 bytes that expand to 360 (E-0016, E-0017)
KeyWorld47_4_Y0X2_Attrs::
    INCBIN "maps/key_worlds/47_4_y0_x2_attrs.lz"

; LZSS-compressed: 79 bytes that expand to 360 (E-0016, E-0017)
KeyWorld55_1_Y3X3_Attrs::
    INCBIN "maps/key_worlds/55_1_y3_x3_attrs.lz"

; LZSS-compressed: 101 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen65_8::
    INCBIN "maps/key_worlds/screen65_8.lz"

; an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling
; a gap (E-0222)
; record: screen header
KeyWorldScreenHeader65_5::
    db $00, $00, $02, $09, $0a, $33, $74, $00 ; entry 0

; LZSS-compressed: 116 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen65_9::
    INCBIN "maps/key_worlds/screen65_9.lz"

; the 8-byte header of the screen stream that follows (E-0222)
KeyWorldScreenHeader_65_15::
; another name for the data at KeyWorldScreenHeader_65_15, whose note is above (E-0381)
KeyWorld40_4_Y0X3_Header::
    db $ff, $ff, $ff, $ff, $ff, $33, $75, $00 ; entry 0

; LZSS-compressed: 83 bytes that expand to 360 (E-0016, E-0017)
KeyWorld40_4_Y0X3_Tiles::
    INCBIN "maps/key_worlds/40_4_y0_x3_tiles.lz"

KeyWorldScreenHeader_65_16::
; another name for the data at KeyWorldScreenHeader_65_16, whose note is above (E-0381)
KeyWorld47_0_Y2X3_Header::
    db $ff, $00, $02, $08, $09, $33, $76, $00 ; entry 0

; LZSS-compressed: 97 bytes that expand to 360 (E-0016, E-0017)
KeyWorld47_0_Y2X3_Tiles::
    INCBIN "maps/key_worlds/47_0_y2_x3_tiles.lz"

; record: screen header
KeyWorldScreenHeader_65_17::
; another name for the data at KeyWorldScreenHeader_65_17, whose note is above (E-0381)
KeyWorld56_0_Y2X2_Header::
    db $00, $ff, $ff, $ff, $ff, $33, $77, $00 ; entry 0

; LZSS-compressed: 101 bytes that expand to 360 (E-0016, E-0017)
KeyWorld56_0_Y2X2_Tiles::
    INCBIN "maps/key_worlds/56_0_y2_x2_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
KeyWorldScreenHeader_65_18::
; another name for the data at KeyWorldScreenHeader_65_18, whose note is above (E-0381)
KeyWorld3C_0_Y3X3_Header::
    db $02, $00, $09, $0a, $0c, $33, $78, $00 ; entry 0

; LZSS-compressed: 119 bytes that expand to 360 (E-0016, E-0017)
KeyWorld3C_0_Y3X3_Tiles::
    INCBIN "maps/key_worlds/3_c_0_y3_x3_tiles.lz"

KeyWorldScreenHeader_65_19::
; another name for the data at KeyWorldScreenHeader_65_19, whose note is above (E-0381)
KeyWorld30_0_Y2X3_Header::
    db $02, $00, $06, $0d, $0f, $33, $79, $00 ; entry 0

; LZSS-compressed: 145 bytes that expand to 360 (E-0016, E-0017)
KeyWorld30_0_Y2X3_Tiles::
    INCBIN "maps/key_worlds/30_0_y2_x3_tiles.lz"

; record: screen header
KeyWorldScreenHeader_65_20::
; another name for the data at KeyWorldScreenHeader_65_20, whose note is above (E-0381)
KeyWorld55_3_Y0X3_Header::
    db $ff, $04, $0b, $0c, $0e, $33, $7a, $00 ; entry 0

; LZSS-compressed: 122 bytes that expand to 360 (E-0016, E-0017)
KeyWorld55_3_Y0X3_Tiles::
    INCBIN "maps/key_worlds/55_3_y0_x3_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
KeyWorldScreenHeader_65_21::
; another name for the data at KeyWorldScreenHeader_65_21, whose note is above (E-0381)
KeyWorld42_1_Y2X0_Header::
    db $ff, $07, $09, $0c, $0f, $33, $7b, $00 ; entry 0

; LZSS-compressed: 127 bytes that expand to 360 (E-0016, E-0017)
KeyWorld42_1_Y2X0_Tiles::
    INCBIN "maps/key_worlds/42_1_y2_x0_tiles.lz"

; an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling
; a gap (E-0222)
; record: screen header
KeyWorldScreenHeader65_6::
    db $00, $06, $08, $09, $0d, $33, $7c, $00 ; entry 0

; LZSS-compressed: 182 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen65_10::
    INCBIN "maps/key_worlds/screen65_10.lz"

; LZSS-compressed: 40 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen65_11::
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0a, $05, $00, $00, $0f, $09, $00
    db $0a, $06, $00, $26, $0f, $33, $00, $04, $08, $00, $78, $0f, $01, $00, $22, $0f
    db $43, $00, $f5, $0f, $4d, $00, $08, $1e

; LZSS-compressed: 42 bytes that expand to 360 (E-0016, E-0017)
KeyWorld40_4_Y0X3_Attrs::
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0a, $05, $00, $00, $0f, $2f, $02
    db $02, $00, $0a, $06, $00, $4e, $0f, $09, $00, $58, $08, $00, $76, $0f, $03, $00
    db $9f, $0f, $4d, $00, $ff, $0f, $4d, $00, $0a, $04

; LZSS-compressed: 47 bytes that expand to 360 (E-0016, E-0017)
KeyWorld47_0_Y2X3_Attrs::
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0a, $05, $00, $00, $0f, $0b, $00
    db $08, $06, $00, $28, $0f, $2d, $00, $74, $08, $00, $74, $0f, $05, $00, $0c, $06
    db $00, $98, $0c, $00, $a6, $0f, $03, $00, $cf, $0f, $4d, $00, $08, $1f, $25

; LZSS-compressed: 53 bytes that expand to 360 (E-0016, E-0017)
KeyWorld56_0_Y2X2_Attrs::
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0a, $05, $00, $00, $0f, $09, $02
    db $02, $00, $1e, $0f, $11, $02, $02, $00, $44, $0f, $11, $00, $56, $00, $00, $6c
    db $0f, $0d, $00, $0a, $02, $00, $90, $0f, $01, $00, $90, $0f, $03, $00, $cf, $0f
    db $4d, $00, $08, $1f, $25

KeyWorld3C_0_Y3X3_Attrs::
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0a, $05, $00, $00, $0f, $33, $00
    db $06, $06, $00, $50, $0f, $29, $00, $4c, $0c, $00, $9c, $0f, $31, $00, $10, $08
    db $00, $ec, $0f, $0d, $00, $14, $1f, $35

; LZSS-compressed: 75 bytes that expand to 360 (E-0016, E-0017)
KeyWorld30_0_Y2X3_Attrs::
    INCBIN "maps/key_worlds/30_0_y2_x3_attrs.lz"

; LZSS-compressed: 56 bytes that expand to 360 (E-0016, E-0017)
KeyWorld55_3_Y0X3_Attrs::
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0a, $05, $00, $00, $0f, $0f, $00
    db $06, $02, $00, $28, $0f, $0b, $00, $02, $06, $00, $50, $0f, $29, $00, $12, $04
    db $00, $32, $06, $00, $9e, $0f, $0f, $00, $0a, $0c, $00, $d0, $0a, $00, $aa, $08
    db $00, $ea, $0f, $0b, $00, $0c, $1f, $39

; LZSS-compressed: 59 bytes that expand to 360 (E-0016, E-0017)
KeyWorld42_1_Y2X0_Attrs::
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0a, $05, $00, $00, $0f, $09, $02
    db $00, $30, $05, $00, $26, $0f, $0b, $00, $2c, $06, $00, $4e, $0f, $0f, $00, $2c
    db $02, $00, $76, $0f, $03, $00, $9e, $0a, $00, $9a, $0f, $39, $00, $5a, $06, $00
    db $f0, $0f, $09, $00, $fa, $0f, $13, $00, $3c, $1f, $0f

; LZSS-compressed: 101 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen65_12::
    INCBIN "maps/key_worlds/screen65_12.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_65_22::
; another name for the data at KeyWorldScreenHeader_65_22, whose note is above (E-0381)
KeyWorld42_1_Y3X0_Header::
    db $ff, $ff, $ff, $ff, $ff, $33, $17, $01 ; entry 0

; LZSS-compressed: 29 bytes that expand to 360 (E-0016, E-0017)
KeyWorld42_1_Y3X0_Tiles::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

; LZSS-compressed: 20 bytes that expand to 360 (E-0016, E-0017)
KeyWorld42_1_Y3X0_Attrs::
    db $68, $01, $00, $03, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

KeyWorldScreenHeader_65_23::
; another name for the data at KeyWorldScreenHeader_65_23, whose note is above (E-0381)
KeyWorld29_1_Y2X2_Header::
    db $02, $01, $05, $0e, $0f, $00, $98, $00 ; entry 0

; LZSS-compressed: 152 bytes that expand to 360 (E-0016, E-0017)
KeyWorld29_1_Y2X2_Tiles::
    INCBIN "maps/key_worlds/29_1_y2_x2_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_65_24::
; another name for the data at KeyWorldScreenHeader_65_24, whose note is above (E-0381)
KeyWorld05_0_Y2X2_Header::
    db $07, $01, $05, $0e, $0f, $00, $99, $00 ; entry 0

; LZSS-compressed: 164 bytes that expand to 360 (E-0016, E-0017)
KeyWorld05_0_Y2X2_Tiles::
    INCBIN "maps/key_worlds/05_0_y2_x2_tiles.lz"

KeyWorldScreenHeader_65_25::
; another name for the data at KeyWorldScreenHeader_65_25, whose note is above (E-0381)
KeyWorld24_1_Y2X0_Header::
    db $06, $01, $05, $0e, $0f, $31, $9a, $00 ; entry 0

; LZSS-compressed: 175 bytes that expand to 360 (E-0016, E-0017)
KeyWorld24_1_Y2X0_Tiles::
    INCBIN "maps/key_worlds/24_1_y2_x0_tiles.lz"

KeyWorldScreenHeader_65_26::
; another name for the data at KeyWorldScreenHeader_65_26, whose note is above (E-0381)
KeyWorld13_0_Y1X1_Header::
    db $ff, $01, $06, $0e, $0f, $31, $9b, $00 ; entry 0

; LZSS-compressed: 176 bytes that expand to 360 (E-0016, E-0017)
KeyWorld13_0_Y1X1_Tiles::
    INCBIN "maps/key_worlds/13_0_y1_x1_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_65_27::
; another name for the data at KeyWorldScreenHeader_65_27, whose note is above (E-0381)
KeyWorld17_1_Y0X1_Header::
    db $01, $01, $05, $0e, $0f, $00, $9c, $00 ; entry 0

; LZSS-compressed: 174 bytes that expand to 360 (E-0016, E-0017)
KeyWorld17_1_Y0X1_Tiles::
    INCBIN "maps/key_worlds/17_1_y0_x1_tiles.lz"

KeyWorldScreenHeader_65_28::
; another name for the data at KeyWorldScreenHeader_65_28, whose note is above (E-0381)
KeyWorld01_0_Y1X1_Header::
    db $07, $01, $05, $0e, $0f, $00, $9d, $00 ; entry 0

; LZSS-compressed: 155 bytes that expand to 360 (E-0016, E-0017)
KeyWorld01_0_Y1X1_Tiles::
    db $68, $01, $02, $00, $01, $02, $00, $03, $27, $42, $43, $40, $41, $02, $0c, $02
    db $01, $00, $01, $11, $12, $13, $35, $36, $36, $37, $52, $53, $50, $51, $02, $20
    db $02, $02, $06, $02, $02, $2c, $02, $02, $0c, $05, $11, $02, $1c, $00, $02, $40

; LZSS-compressed: 485 bytes that expand to 514 (E-0016, E-0017)
Gfx65_1::
    INCBIN "gfx/misc/gfx65_1.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_65_29::
; another name for the data at KeyWorldScreenHeader_65_29, whose note is above (E-0381)
KeyWorld10_1_Y0X1_Header::
    db $ff, $01, $06, $0e, $0f, $00, $9e, $00 ; entry 0

; LZSS-compressed: 181 bytes that expand to 360 (E-0016, E-0017)
KeyWorld10_1_Y0X1_Tiles::
    INCBIN "maps/key_worlds/10_1_y0_x1_tiles.lz"

KeyWorldScreenHeader_65_30::
; another name for the data at KeyWorldScreenHeader_65_30, whose note is above (E-0381)
KeyWorld16_0_Y2X1_Header::
    db $ff, $01, $03, $0e, $0f, $00, $9f, $00 ; entry 0

; LZSS-compressed: 180 bytes that expand to 360 (E-0016, E-0017)
KeyWorld16_0_Y2X1_Tiles::
    INCBIN "maps/key_worlds/16_0_y2_x1_tiles.lz"

KeyWorld29_0_Y1X2_Header::
    db $07

; LZSS-compressed: 1253 bytes that expand to 1281 (E-0016, E-0017)
Gfx65_2::
    db $01, $05, $0b, $0e, $00, $a0, $00

; LZSS-compressed: 176 bytes that expand to 360 (E-0016, E-0017)
KeyWorld29_0_Y1X2_Tiles::
    INCBIN "maps/key_worlds/29_0_y1_x2_tiles.lz"

; LZSS-compressed: 46 bytes that expand to 360 (E-0016, E-0017)
KeyWorld29_1_Y2X2_Attrs::
    db $68, $01, $02, $02, $ff, $f6, $01, $02, $0a, $05, $02, $00, $0f, $09, $02, $0a
    db $06, $02, $26, $0f, $09, $02, $30, $08, $02, $4e, $0f, $07, $02, $56, $0a, $02
    db $76, $0f, $03, $02, $9f, $0f, $4d, $02, $ff, $0f, $4d, $02, $0c, $04

; LZSS-compressed: 79 bytes that expand to 360 (E-0016, E-0017)
KeyWorld05_0_Y2X2_Attrs::
    INCBIN "maps/key_worlds/05_0_y2_x2_attrs.lz"

; LZSS-compressed: 63 bytes that expand to 360 (E-0016, E-0017)
KeyWorld24_1_Y2X0_Attrs::
    db $68, $01, $03, $03, $ff, $f6, $01, $03, $0a, $05, $03, $00, $0f, $4d, $03, $10
    db $06, $03, $1e, $06, $03, $74, $0f, $05, $01, $01, $02, $02, $03, $92, $0c, $03
    db $a0, $0f, $05, $03, $ca, $00, $03, $bc, $0f, $15, $03, $ca, $0a, $03, $f2, $0f
    db $01, $03, $f0, $06, $03, $e6, $0f, $01, $03, $a4, $0e, $03, $38, $1f, $0b

; LZSS-compressed: 47 bytes that expand to 360 (E-0016, E-0017)
KeyWorld13_0_Y1X1_Attrs::
    db $68, $01, $02, $02, $ff, $f6, $01, $02, $0a, $05, $02, $00, $0f, $09, $02, $0a
    db $06, $02, $26, $0f, $0b, $02, $08, $0f, $0f, $02, $12, $04, $02, $6e, $0f, $0b
    db $02, $0e, $06, $02, $96, $0f, $11, $02, $cd, $0f, $4d, $02, $08, $1f, $27

; LZSS-compressed: 74 bytes that expand to 360 (E-0016, E-0017)
KeyWorld17_1_Y0X1_Attrs::
    INCBIN "maps/key_worlds/17_1_y0_x1_attrs.lz"

; LZSS-compressed: 70 bytes that expand to 360 (E-0016, E-0017)
KeyWorld01_0_Y1X1_Attrs::
    INCBIN "maps/key_worlds/01_0_y1_x1_attrs.lz"

; LZSS-compressed: 53 bytes that expand to 360 (E-0016, E-0017)
KeyWorld10_1_Y0X1_Attrs::
    db $68, $01, $02, $02, $ff, $f6, $01, $02, $0a, $05, $02, $00, $0f, $33, $02, $08
    db $06, $02, $50, $0f, $0d, $02, $06, $04, $02, $fa, $ff, $03, $02, $8e, $0f, $15
    db $02, $12, $02, $02, $c8, $08, $02, $c8, $0f, $0d, $02, $f8, $08, $02, $f4, $0f
    db $01, $02, $0c, $1f, $39

; LZSS-compressed: 46 bytes that expand to 360 (E-0016, E-0017)
KeyWorld16_0_Y2X1_Attrs::
    db $68, $01, $02, $02, $ff, $f6, $01, $02, $0a, $05, $02, $00, $0f, $33, $02, $08
    db $06, $02, $50, $0f, $03, $02, $10, $0e, $02, $78, $0f, $01, $02, $0c, $0c, $02
    db $9c, $0f, $0d, $02, $10, $04, $02, $c4, $0f, $39, $02, $14, $1f, $31

; LZSS-compressed: 75 bytes that expand to 360 (E-0016, E-0017)
KeyWorld29_0_Y1X2_Attrs::
    INCBIN "maps/key_worlds/29_0_y1_x2_attrs.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_65_31::
; another name for the data at KeyWorldScreenHeader_65_31, whose note is above (E-0381)
KeyWorld07_0_Y0X1_Header::
    db $05, $03, $04, $0a, $0d, $37, $bc, $00 ; entry 0

; LZSS-compressed: 131 bytes that expand to 360 (E-0016, E-0017)
KeyWorld07_0_Y0X1_Tiles::
    INCBIN "maps/key_worlds/07_0_y0_x1_tiles.lz"

KeyWorldScreenHeader_65_32::
; another name for the data at KeyWorldScreenHeader_65_32, whose note is above (E-0381)
KeyWorld01_0_Y0X2_Header::
    db $07, $03, $04, $0a, $0d, $04, $bd, $00 ; entry 0

; LZSS-compressed: 116 bytes that expand to 360 (E-0016, E-0017)
KeyWorld01_0_Y0X2_Tiles::
    INCBIN "maps/key_worlds/01_0_y0_x2_tiles.lz"

KeyWorldScreenHeader_65_33::
; another name for the data at KeyWorldScreenHeader_65_33, whose note is above (E-0381)
KeyWorld00_0_Y0X1_Header::
    db $ff, $01, $04, $0d, $0f, $04, $be, $00 ; entry 0

; LZSS-compressed: 156 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y0X1_Tiles::
    INCBIN "maps/key_worlds/00_0_y0_x1_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_65_34::
; another name for the data at KeyWorldScreenHeader_65_34, whose note is above (E-0381)
KeyWorld04_0_Y0X2_Header::
    db $ff, $01, $04, $0a, $0f, $04, $bf, $00 ; entry 0

; LZSS-compressed: 161 bytes that expand to 360 (E-0016, E-0017)
KeyWorld04_0_Y0X2_Tiles::
    INCBIN "maps/key_worlds/04_0_y0_x2_tiles.lz"

; LZSS-compressed: 512 bytes that expand to 512 (E-0016, E-0017)
Gfx65_3::
    INCBIN "gfx/misc/gfx65_3.lz"

KeyWorldScreenHeader_65_35::
; another name for the data at KeyWorldScreenHeader_65_35, whose note is above (E-0381)
KeyWorld04_0_Y0X1_Header::
    db $03, $04, $05, $08, $0c, $37, $c0, $00 ; entry 0

; LZSS-compressed: 155 bytes that expand to 360 (E-0016, E-0017)
KeyWorld04_0_Y0X1_Tiles::
    INCBIN "maps/key_worlds/04_0_y0_x1_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_65_36::
; another name for the data at KeyWorldScreenHeader_65_36, whose note is above (E-0381)
KeyWorld00_0_Y0X2_Header::
    db $05, $08, $09, $0a, $0d, $37, $c1, $00 ; entry 0

; LZSS-compressed: 202 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y0X2_Tiles::
    INCBIN "maps/key_worlds/00_0_y0_x2_tiles.lz"

KeyWorldScreenHeader_65_37::
; another name for the data at KeyWorldScreenHeader_65_37, whose note is above (E-0381)
KeyWorld06_0_Y0X1_Header::
    db $ff, $04, $05, $08, $0d, $37, $c2, $00 ; entry 0

; LZSS-compressed: 167 bytes that expand to 360 (E-0016, E-0017)
KeyWorld06_0_Y0X1_Tiles::
    db $68, $01, $02, $00, $01, $02, $00, $0e, $02, $01, $01, $11, $12, $13, $02, $1a
    db $00, $14, $02, $00, $03, $02, $00, $01, $27, $42, $43, $02, $2e, $00, $08, $02
    db $0d, $06, $11, $36, $37, $52, $53, $02, $42, $00, $18, $02, $21, $06, $07, $02
    db $2e, $02, $20, $21

; LZSS-compressed: 509 bytes that expand to 526 (E-0016, E-0017)
Gfx65_4::
    INCBIN "gfx/misc/gfx65_4.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_65_38::
; another name for the data at KeyWorldScreenHeader_65_38, whose note is above (E-0381)
KeyWorld06_0_Y0X2_Header::
    db $ff, $04, $08, $0b, $0d, $37, $c3, $00 ; entry 0

; LZSS-compressed: 210 bytes that expand to 360 (E-0016, E-0017)
KeyWorld06_0_Y0X2_Tiles::
    INCBIN "maps/key_worlds/06_0_y0_x2_tiles.lz"

KeyWorldScreenHeader_65_39::
; another name for the data at KeyWorldScreenHeader_65_39, whose note is above (E-0381)
KeyWorld27_0_Y0X2_Header::
    db $01, $03, $06, $08, $0d, $37, $c4, $00 ; entry 0

; LZSS-compressed: 216 bytes that expand to 360 (E-0016, E-0017)
KeyWorld27_0_Y0X2_Tiles::
    INCBIN "maps/key_worlds/27_0_y0_x2_tiles.lz"

; LZSS-compressed: 517 bytes that expand to 514 (E-0016, E-0017)
Gfx65_5::
    db $02, $02, $b6, $00, $02, $ee, $02, $02, $f2, $00, $02, $a8, $02, $02, $18, $12
    db $02, $b8, $00, $02, $06, $10, $02, $bc, $02, $02, $2c, $12, $02, $18, $12, $02
    db $7c, $00, $02, $40, $14, $02, $2a, $14, $02, $90, $00, $02, $54, $14, $50, $51

; LZSS-compressed: 30 bytes that expand to 360 (E-0016, E-0017)
KeyWorld07_0_Y0X1_Attrs::
    db $68, $01, $02, $02, $a0, $ff, $4d, $02, $1e, $0f, $0b, $01, $02, $7e, $03, $02
    db $72, $0f, $07, $02, $7e, $04, $02, $a7, $0f, $4d, $02, $07, $1f, $4d

; LZSS-compressed: 55 bytes that expand to 360 (E-0016, E-0017)
KeyWorld01_0_Y0X2_Attrs::
    db $68, $01, $03, $03, $a0, $ff, $4d, $03, $40, $0f, $2d, $01, $03, $a0, $01, $02
    db $03, $a6, $03, $03, $a0, $02, $03, $a0, $0f, $03, $03, $a6, $04, $03, $a6, $08
    db $03, $ca, $0f, $01, $03, $c8, $0a, $03, $c2, $0f, $01, $03, $b0, $0f, $07, $03
    db $a2, $0f, $05, $03, $3a, $1f, $0f

; LZSS-compressed: 36 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y0X1_Attrs::
    db $68, $01, $02, $02, $a0, $ff, $4d, $02, $40, $0f, $2d, $01, $01, $01, $01, $02
    db $94, $0c, $02, $a0, $0f, $2d, $02, $a2, $06, $02, $ec, $06, $02, $f4, $0f, $03
    db $02, $12, $1f, $37

; LZSS-compressed: 66 bytes that expand to 360 (E-0016, E-0017)
KeyWorld04_0_Y0X2_Attrs::
    INCBIN "maps/key_worlds/04_0_y0_x2_attrs.lz"

KeyWorld04_0_Y0X1_Attrs::
    db $68, $01, $02, $02, $ff, $ff, $19, $01, $02, $2c, $07, $02, $24, $0f, $07, $02
    db $2c, $08, $02, $34, $04, $02, $52, $0f, $27, $02, $52, $0c, $02, $af, $0f, $4d
    db $02, $08, $1f, $45

; LZSS-compressed: 79 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y0X2_Attrs::
    INCBIN "maps/key_worlds/00_0_y0_x2_attrs.lz"

; LZSS-compressed: 50 bytes that expand to 360 (E-0016, E-0017)
KeyWorld06_0_Y0X1_Attrs::
    db $68, $01, $02, $02, $ff, $ff, $1b, $01, $02, $2e, $01, $02, $20, $0f, $0d, $02
    db $2e, $0f, $13, $02, $2c, $0f, $13, $02, $2e, $02, $02, $30, $06, $02, $a0, $06
    db $02, $a6, $0f, $05, $02, $32, $02, $02, $c4, $0f, $11, $02, $fb, $0f, $4d, $02
    db $b2, $08

; LZSS-compressed: 84 bytes that expand to 360 (E-0016, E-0017)
KeyWorld06_0_Y0X2_Attrs::
    INCBIN "maps/key_worlds/06_0_y0_x2_attrs.lz"

; LZSS-compressed: 92 bytes that expand to 360 (E-0016, E-0017)
KeyWorld27_0_Y0X2_Attrs::
    db $68, $01, $03, $03, $ff, $ff, $1d, $02, $02, $02, $02, $03, $20, $0f, $0d, $03
    db $30, $00, $04, $04, $03, $30, $00, $03, $32, $06, $03, $54, $0e, $02, $02, $01
    db $03

; LZSS-compressed: 97 bytes that expand to 380 (E-0016, E-0017)
Gfx65_6::
    db $7c, $01, $04, $04, $03, $58, $02, $03, $76, $0f, $03, $03, $7c, $02, $03, $a0
    db $04, $03, $58, $00, $03, $a0, $0a, $03, $ac, $0f, $01, $04, $04, $03, $b2, $0c
    db $03, $d2, $0a, $03, $56, $00, $03, $ae, $0c, $03, $f4, $0f, $01, $03, $f2, $00
    db $03, $d6, $0e, $03, $1e, $1f, $01, $03, $34, $1f, $0f

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_65_40::
; another name for the data at KeyWorldScreenHeader_65_40, whose note is above (E-0381)
KeyWorld03_0_Y1X2_Header::
    db $01, $02, $04, $07, $0c, $39, $e0, $00 ; entry 0

; LZSS-compressed: 132 bytes that expand to 360 (E-0016, E-0017)
KeyWorld03_0_Y1X2_Tiles::
    INCBIN "maps/key_worlds/03_0_y1_x2_tiles.lz"

KeyWorldScreenHeader_65_41::
; another name for the data at KeyWorldScreenHeader_65_41, whose note is above (E-0381)
KeyWorld04_0_Y1X3_Header::
    db $ff, $02, $04, $05, $07, $08, $e1, $00 ; entry 0

; LZSS-compressed: 80 bytes that expand to 360 (E-0016, E-0017)
KeyWorld04_0_Y1X3_Tiles::
    INCBIN "maps/key_worlds/04_0_y1_x3_tiles.lz"

KeyWorldScreenHeader_65_42::
; another name for the data at KeyWorldScreenHeader_65_42, whose note is above (E-0381)
KeyWorld00_0_Y2X3_Header::
    db $ff, $00, $01, $02, $04, $08, $e2, $00 ; entry 0

; LZSS-compressed: 118 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y2X3_Tiles::
    INCBIN "maps/key_worlds/00_0_y2_x3_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_65_43::
; another name for the data at KeyWorldScreenHeader_65_43, whose note is above (E-0381)
KeyWorld00_0_Y1X3_Header::
    db $ff, $00, $01, $02, $07, $08, $e3, $00 ; entry 0

; LZSS-compressed: 160 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y1X3_Tiles::
    INCBIN "maps/key_worlds/00_0_y1_x3_tiles.lz"

KeyWorldScreenHeader_65_44::
; another name for the data at KeyWorldScreenHeader_65_44, whose note is above (E-0381)
KeyWorld02_0_Y1X3_Header::
    db $05, $02, $06, $0c, $0d, $39, $e4, $00 ; entry 0

; LZSS-compressed: 221 bytes that expand to 360 (E-0016, E-0017)
KeyWorld02_0_Y1X3_Tiles::
    INCBIN "maps/key_worlds/02_0_y1_x3_tiles.lz"

KeyWorldScreenHeader_65_45::
; another name for the data at KeyWorldScreenHeader_65_45, whose note is above (E-0381)
KeyWorld08_0_Y2X3_Header::
    db $00, $04, $06, $09, $0c, $39, $e5, $00 ; entry 0

; LZSS-compressed: 171 bytes that expand to 360 (E-0016, E-0017)
KeyWorld08_0_Y2X3_Tiles::
    INCBIN "maps/key_worlds/08_0_y2_x3_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_65_46::
; another name for the data at KeyWorldScreenHeader_65_46, whose note is above (E-0381)
KeyWorld06_0_Y2X3_Header::
    db $00, $02, $03, $06, $0f, $39, $e6, $00 ; entry 0

; LZSS-compressed: 146 bytes that expand to 360 (E-0016, E-0017)
KeyWorld06_0_Y2X3_Tiles::
    INCBIN "maps/key_worlds/06_0_y2_x3_tiles.lz"

KeyWorldScreenHeader_65_47::
; another name for the data at KeyWorldScreenHeader_65_47, whose note is above (E-0381)
KeyWorld05_0_Y1X1_Header::
    db $ff, $03, $08, $09, $0b, $39, $e7, $00 ; entry 0

; LZSS-compressed: 156 bytes that expand to 360 (E-0016, E-0017)
KeyWorld05_0_Y1X1_Tiles::
    INCBIN "maps/key_worlds/05_0_y1_x1_tiles.lz"

KeyWorldScreenHeader_65_48::
; another name for the data at KeyWorldScreenHeader_65_48, whose note is above (E-0381)
KeyWorld07_0_Y2X1_Header::
    db $01, $03, $05, $0a, $0b, $39, $e8, $00 ; entry 0

; LZSS-compressed: 232 bytes that expand to 360 (E-0016, E-0017)
KeyWorld07_0_Y2X1_Tiles::
    INCBIN "maps/key_worlds/07_0_y2_x1_tiles.lz"

; LZSS-compressed: 40 bytes that expand to 360 (E-0016, E-0017)
KeyWorld03_0_Y1X2_Attrs::
    db $68, $01, $02, $01, $02, $00, $05, $02, $f6, $ff, $4d, $02, $1a, $0f, $05, $02
    db $1a, $06, $02, $78, $0f, $0f, $02, $1c, $02, $02, $a0, $0f, $0f, $02, $72, $0f
    db $11, $02, $1e, $0f, $4d, $02, $f6, $0a

; LZSS-compressed: 23 bytes that expand to 360 (E-0016, E-0017)
KeyWorld04_0_Y1X3_Attrs::
    db $68, $01, $02, $01, $02, $00, $05, $02, $f6, $ff, $4d, $02, $56, $0f, $4d, $02
    db $b6, $0f, $4d, $02, $02, $1f, $2b

; LZSS-compressed: 34 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y2X3_Attrs::
    db $68, $01, $02, $01, $02, $00, $05, $02, $f6, $ff, $37, $02, $f0, $ff, $01, $02
    db $54, $0f, $4d, $02, $8c, $0f, $19, $02, $8e, $0c, $02, $f0, $0f, $07, $02, $06
    db $0f, $37

; LZSS-compressed: 52 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y1X3_Attrs::
    db $68, $01, $03, $01, $03, $00, $05, $03, $f6, $ff, $3b, $03, $f4, $ff, $01, $03
    db $f4, $fe, $02, $02, $03, $6c, $0f, $11, $03, $7e, $0a, $03, $9e, $0f, $31, $03
    db $f4, $00, $03, $e6, $0f, $0f, $03, $7c, $00, $03, $08, $0e, $03, $1e, $1f, $01
    db $03, $06, $0f, $0f

; LZSS-compressed: 78 bytes that expand to 360 (E-0016, E-0017)
KeyWorld02_0_Y1X3_Attrs::
    INCBIN "maps/key_worlds/02_0_y1_x3_attrs.lz"

; LZSS-compressed: 72 bytes that expand to 360 (E-0016, E-0017)
KeyWorld08_0_Y2X3_Attrs::
    INCBIN "maps/key_worlds/08_0_y2_x3_attrs.lz"

; LZSS-compressed: 44 bytes that expand to 360 (E-0016, E-0017)
KeyWorld06_0_Y2X3_Attrs::
    db $68, $01, $02, $01, $02, $00, $05, $02, $f6, $ff, $39, $02, $f2, $ff, $01, $02
    db $56, $0f, $29, $02, $04, $0a, $02, $a0, $0f, $0d, $02, $06, $04, $02, $c8, $0f
    db $11, $02, $08, $00, $02, $f0, $0f, $0b, $02, $f6, $ff, $33

; LZSS-compressed: 66 bytes that expand to 360 (E-0016, E-0017)
KeyWorld05_0_Y1X1_Attrs::
    INCBIN "maps/key_worlds/05_0_y1_x1_attrs.lz"

; LZSS-compressed: 85 bytes that expand to 360 (E-0016, E-0017)
KeyWorld07_0_Y2X1_Attrs::
    INCBIN "maps/key_worlds/07_0_y2_x1_attrs.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_65_49::
; another name for the data at KeyWorldScreenHeader_65_49, whose note is above (E-0381)
KeyWorld01_0_Y0X3_Header::
    db $03, $03, $06, $07, $09, $3d, $04, $01 ; entry 0

; LZSS-compressed: 111 bytes that expand to 360 (E-0016, E-0017)
KeyWorld01_0_Y0X3_Tiles::
    INCBIN "maps/key_worlds/01_0_y0_x3_tiles.lz"

KeyWorldScreenHeader_65_50::
; another name for the data at KeyWorldScreenHeader_65_50, whose note is above (E-0381)
KeyWorld03_0_Y0X2_Header::
    db $ff, $ff, $ff, $ff, $ff, $0c, $05, $01 ; entry 0

; LZSS-compressed: 95 bytes that expand to 360 (E-0016, E-0017)
KeyWorld03_0_Y0X2_Tiles::
    INCBIN "maps/key_worlds/03_0_y0_x2_tiles.lz"

KeyWorldScreenHeader_65_51::
; another name for the data at KeyWorldScreenHeader_65_51, whose note is above (E-0381)
KeyWorld07_0_Y0X3_Header::
    db $ff, $03, $04, $05, $06, $26, $06, $01 ; entry 0

; LZSS-compressed: 126 bytes that expand to 360 (E-0016, E-0017)
KeyWorld07_0_Y0X3_Tiles::
    INCBIN "maps/key_worlds/07_0_y0_x3_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_65_52::
; another name for the data at KeyWorldScreenHeader_65_52, whose note is above (E-0381)
KeyWorld02_0_Y0X3_Header::
    db $01, $03, $06, $07, $09, $3d, $07, $01 ; entry 0

; LZSS-compressed: 150 bytes that expand to 360 (E-0016, E-0017)
KeyWorld02_0_Y0X3_Tiles::
    INCBIN "maps/key_worlds/02_0_y0_x3_tiles.lz"

KeyWorldScreenHeader_65_53::
; another name for the data at KeyWorldScreenHeader_65_53, whose note is above (E-0381)
KeyWorld00_0_Y0X3_Header::
    db $05, $05, $06, $08, $0b, $3d, $08, $01 ; entry 0

; LZSS-compressed: 164 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y0X3_Tiles::
    INCBIN "maps/key_worlds/00_0_y0_x3_tiles.lz"

KeyWorldScreenHeader_65_54::
; another name for the data at KeyWorldScreenHeader_65_54, whose note is above (E-0381)
KeyWorld04_0_Y0X3_Header::
    db $01, $04, $09, $0b, $0d, $3d, $09, $01 ; entry 0

; LZSS-compressed: 175 bytes that expand to 360 (E-0016, E-0017)
KeyWorld04_0_Y0X3_Tiles::
    INCBIN "maps/key_worlds/04_0_y0_x3_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_65_55::
; another name for the data at KeyWorldScreenHeader_65_55, whose note is above (E-0381)
KeyWorld11_1_Y0X3_Header::
    db $ff, $02, $04, $0a, $0c, $3d, $0a, $01 ; entry 0

; LZSS-compressed: 204 bytes that expand to 360 (E-0016, E-0017)
KeyWorld11_1_Y0X3_Tiles::
    INCBIN "maps/key_worlds/11_1_y0_x3_tiles.lz"

KeyWorldScreenHeader_65_56::
; another name for the data at KeyWorldScreenHeader_65_56, whose note is above (E-0381)
KeyWorld1D_1_Y2X3_Header::
    db $ff, $02, $05, $0b, $0d, $3d, $0b, $01 ; entry 0

; LZSS-compressed: 202 bytes that expand to 360 (E-0016, E-0017)
KeyWorld1D_1_Y2X3_Tiles::
    INCBIN "maps/key_worlds/1_d_1_y2_x3_tiles.lz"

KeyWorldScreenHeader_65_57::
; another name for the data at KeyWorldScreenHeader_65_57, whose note is above (E-0381)
KeyWorld17_0_Y3X2_Header::
    db $01, $04, $09, $02, $0c, $3d, $0c, $01 ; entry 0

; LZSS-compressed: 222 bytes that expand to 360 (E-0016, E-0017)
KeyWorld17_0_Y3X2_Tiles::
    INCBIN "maps/key_worlds/17_0_y3_x2_tiles.lz"

; LZSS-compressed: 33 bytes that expand to 360 (E-0016, E-0017)
KeyWorld01_0_Y0X3_Attrs::
    db $68, $01, $02, $02, $a0, $ff, $4d, $02, $1e, $0f, $0b, $01, $02, $7e, $03, $02
    db $72, $0f, $07, $02, $7e, $04, $02, $94, $0f, $3f, $02, $74, $0e, $02, $f8, $0f
    db $49

; LZSS-compressed: 47 bytes that expand to 360 (E-0016, E-0017)
KeyWorld03_0_Y0X2_Attrs::
    db $68, $01, $03, $03, $a0, $ff, $4d, $03, $40, $0f, $2d, $01, $01, $02, $02, $03
    db $90, $0f, $15, $03, $a2, $0c, $03, $c8, $0f, $07, $03, $a2, $0a, $03, $f0, $0f
    db $09, $03, $a2, $08, $03, $18, $1f, $03, $03, $40, $14, $03, $36, $1f, $0b

; LZSS-compressed: 42 bytes that expand to 360 (E-0016, E-0017)
KeyWorld07_0_Y0X3_Attrs::
    db $68, $01, $02, $02, $ff, $ff, $43, $01, $01, $02, $44, $0f, $0f, $01, $02, $7a
    db $01, $02, $6c, $0f, $0d, $02, $7a, $02, $02, $7c, $0a, $02, $a0, $0f, $0b, $02
    db $56, $06, $02, $c8, $0f, $4d, $02, $9c, $0f, $19

; LZSS-compressed: 55 bytes that expand to 360 (E-0016, E-0017)
KeyWorld02_0_Y0X3_Attrs::
    db $68, $01, $03, $03, $a0, $ff, $4d, $03, $20, $0f, $0d, $02, $02, $02, $02, $03
    db $70, $0f, $09, $01, $03, $a0, $01, $03, $80, $00, $03, $80, $06, $03, $a0, $0f
    db $07, $03, $a4, $02, $03, $98, $0a, $03, $ce, $0f, $03, $01, $01, $03, $20, $06
    db $03, $f0, $0f, $4d, $03, $63, $10

; LZSS-compressed: 48 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y0X3_Attrs::
    db $68, $01, $02, $02, $ff, $ff, $1d, $01, $02, $30, $01, $02, $22, $0f, $15, $02
    db $34, $0a, $02, $58, $0c, $02, $58, $04, $02, $70, $0f, $09, $02, $7c, $08, $02
    db $34, $04, $02, $a0, $0f, $4d, $02, $78, $0a, $02, $4e, $0e, $02, $20, $1f, $21

; LZSS-compressed: 79 bytes that expand to 360 (E-0016, E-0017)
KeyWorld04_0_Y0X3_Attrs::
    INCBIN "maps/key_worlds/04_0_y0_x3_attrs.lz"

; LZSS-compressed: 62 bytes that expand to 360 (E-0016, E-0017)
KeyWorld11_1_Y0X3_Attrs::
    db $68, $01, $02, $02, $ff, $ff, $19, $01, $01, $02, $1a, $0f, $3d, $02, $2c, $06
    db $02, $2c, $04, $02, $7c, $0c, $02, $7c, $00, $02, $7c, $06, $02, $7c, $02, $02
    db $a0, $0f, $0d, $02, $a2, $04, $02, $c8, $0f, $09, $02, $c8, $0e, $02, $f6, $0f
    db $09, $02, $76, $06, $02, $1c, $1f, $07, $02, $72, $0a, $02, $44, $1c

; LZSS-compressed: 70 bytes that expand to 360 (E-0016, E-0017)
KeyWorld1D_1_Y2X3_Attrs::
    INCBIN "maps/key_worlds/1_d_1_y2_x3_attrs.lz"

; LZSS-compressed: 91 bytes that expand to 360 (E-0016, E-0017)
KeyWorld17_0_Y3X2_Attrs::
    INCBIN "maps/key_worlds/17_0_y3_x2_attrs.lz"
    ds $3c1, $00
