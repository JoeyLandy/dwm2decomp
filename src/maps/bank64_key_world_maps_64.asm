; ROM bank $64: key-world map screens
; The annotated listing of this bank is build/listing/bank64.asm.

SECTION "Bank 64", ROMX[$4000], BANK[$64]
    db $64

; compressed BG tiles (2048 bytes, 128 tiles) of key-world kind 2: entry 2 of KeyWorldTilesetTable,
; decompressed to vTiles2 by LoadKeyWorldTilesetAndHeader
; LZSS-compressed: 1227 bytes that expand to 2048 (E-0016, E-0017)
KeyWorldTiles2::
    INCBIN "maps/key_worlds/tiles2.lz"

KeyWorld12_0_Y2X1_Header::
    db $01, $02, $04, $09, $0d, $33, $23, $00

; LZSS-compressed: 123 bytes that expand to 360 (E-0016, E-0017)
KeyWorld12_0_Y2X1_Tiles::
    INCBIN "maps/key_worlds/12_0_y2_x1_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_64::
; another name for the data at KeyWorldScreenHeader_64, whose note is above (E-0381)
KeyWorld31_1_Y2X0_Header::
    db $00, $02, $04, $09, $0d, $33, $24, $00 ; entry 0

; LZSS-compressed: 183 bytes that expand to 360 (E-0016, E-0017)
KeyWorld31_1_Y2X0_Tiles::
    INCBIN "maps/key_worlds/31_1_y2_x0_tiles.lz"

KeyWorldScreenHeader_64_2::
; another name for the data at KeyWorldScreenHeader_64_2, whose note is above (E-0381)
KeyWorld1E_0_Y2X1_Header::
    db $03, $02, $04, $09, $0d, $33, $25, $00 ; entry 0

; LZSS-compressed: 145 bytes that expand to 360 (E-0016, E-0017)
KeyWorld1E_0_Y2X1_Tiles::
    INCBIN "maps/key_worlds/1_e_0_y2_x1_tiles.lz"

KeyWorldScreenHeader_64_3::
; another name for the data at KeyWorldScreenHeader_64_3, whose note is above (E-0381)
KeyWorld12_1_Y2X1_Header::
    db $ff, $02, $04, $05, $0d, $33, $26, $00 ; entry 0

; LZSS-compressed: 133 bytes that expand to 360 (E-0016, E-0017)
KeyWorld12_1_Y2X1_Tiles::
    INCBIN "maps/key_worlds/12_1_y2_x1_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_64_4::
; another name for the data at KeyWorldScreenHeader_64_4, whose note is above (E-0381)
KeyWorld10_0_Y2X1_Header::
    db $05, $02, $04, $09, $0d, $33, $27, $00 ; entry 0

; LZSS-compressed: 129 bytes that expand to 360 (E-0016, E-0017)
KeyWorld10_0_Y2X1_Tiles::
    INCBIN "maps/key_worlds/10_0_y2_x1_tiles.lz"

KeyWorldScreenHeader_64_5::
; another name for the data at KeyWorldScreenHeader_64_5, whose note is above (E-0381)
KeyWorld20_1_Y2X1_Header::
    db $05, $02, $04, $09, $0d, $33, $28, $00 ; entry 0

; LZSS-compressed: 126 bytes that expand to 360 (E-0016, E-0017)
KeyWorld20_1_Y2X1_Tiles::
    INCBIN "maps/key_worlds/20_1_y2_x1_tiles.lz"

KeyWorldScreenHeader_64_6::
; another name for the data at KeyWorldScreenHeader_64_6, whose note is above (E-0381)
KeyWorld36_0_Y2X1_Header::
    db $ff, $02, $04, $06, $0d, $33, $29, $00 ; entry 0

; LZSS-compressed: 143 bytes that expand to 360 (E-0016, E-0017)
KeyWorld36_0_Y2X1_Tiles::
    INCBIN "maps/key_worlds/36_0_y2_x1_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_64_7::
; another name for the data at KeyWorldScreenHeader_64_7, whose note is above (E-0381)
KeyWorld00_0_Y2X1_Header::
    db $ff, $02, $04, $09, $0d, $33, $2a, $00 ; entry 0

KeyWorld00_0_Y2X1_Tiles::
    INCBIN "maps/key_worlds/00_0_y2_x1_tiles.lz"

KeyWorldScreenHeader_64_8::
; another name for the data at KeyWorldScreenHeader_64_8, whose note is above (E-0381)
KeyWorld16_1_Y0X1_Header::
    db $00, $02, $09, $0b, $0c, $33, $2b, $00 ; entry 0

; LZSS-compressed: 196 bytes that expand to 360 (E-0016, E-0017)
KeyWorld16_1_Y0X1_Tiles::
    INCBIN "maps/key_worlds/16_1_y0_x1_tiles.lz"

; LZSS-compressed: 44 bytes that expand to 360 (E-0016, E-0017)
KeyWorld12_0_Y2X1_Attrs::
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0a, $05, $00, $00, $0f, $0b, $00
    db $08, $06, $00, $28, $0f, $0d, $00, $08, $04, $00, $50, $0f, $0f, $00, $08, $02
    db $00, $78, $0f, $11, $00, $af, $0f, $4d, $00, $08, $1f, $45

; LZSS-compressed: 81 bytes that expand to 360 (E-0016, E-0017)
KeyWorld31_1_Y2X0_Attrs::
    INCBIN "maps/key_worlds/31_1_y2_x0_attrs.lz"

; LZSS-compressed: 48 bytes that expand to 360 (E-0016, E-0017)
KeyWorld1E_0_Y2X1_Attrs::
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0a, $05, $00, $00, $0f, $07, $02
    db $02, $00, $1c, $0f, $11, $02, $02, $00, $42, $0f, $11, $00, $54, $02, $00, $04
    db $08, $00, $78, $0f, $03, $00, $a1, $0f, $4d, $00, $01, $1f, $4d, $00, $00, $02

; LZSS-compressed: 69 bytes that expand to 360 (E-0016, E-0017)
KeyWorld12_1_Y2X1_Attrs::
    INCBIN "maps/key_worlds/12_1_y2_x1_attrs.lz"

; LZSS-compressed: 37 bytes that expand to 360 (E-0016, E-0017)
KeyWorld10_0_Y2X1_Attrs::
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0a, $05, $00, $00, $0f, $0b, $00
    db $04, $06, $00, $28, $0f, $11, $00, $08, $00, $00, $50, $0f, $3b, $00, $b1, $0f
    db $4d, $00, $08, $1f, $43

KeyWorld20_1_Y2X1_Attrs::
    INCBIN "maps/key_worlds/20_1_y2_x1_attrs.lz"

; LZSS-compressed: 57 bytes that expand to 360 (E-0016, E-0017)
KeyWorld36_0_Y2X1_Attrs::
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0a, $05, $00, $00, $0f, $09, $00
    db $0a, $06, $00, $26, $0f, $09, $00, $30, $08, $00, $4e, $0f, $0f, $00, $7c, $06
    db $00, $7a, $0f, $09, $00, $a2, $08, $00, $a2, $0f, $05, $00, $b2, $0c, $00, $ca
    db $0f, $0d, $00, $fd, $0f, $4d, $00, $00, $06

; LZSS-compressed: 70 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y2X1_Attrs::
    INCBIN "maps/key_worlds/00_0_y2_x1_attrs.lz"

; LZSS-compressed: 90 bytes that expand to 360 (E-0016, E-0017)
KeyWorld16_1_Y0X1_Attrs::
    INCBIN "maps/key_worlds/16_1_y0_x1_attrs.lz"

; compressed BG tiles (2048 bytes, 128 tiles) of key-world kind 6: entry 6 of KeyWorldTilesetTable,
; decompressed to vTiles2 by LoadKeyWorldTilesetAndHeader
; LZSS-compressed: 1159 bytes that expand to 2048 (E-0016, E-0017)
KeyWorldTiles6::
    INCBIN "maps/key_worlds/tiles6.lz"

; entry 6 of KeyWorldTilesetTable; LoadKeyWorldTilesetAndHeader copies these $40 bytes to
; wBGPaletteBuffer (E-0139, C1)
; record: one CGB palette: 4 BGR555 colours
KeyWorldPalettes6::
    dw $1412, $7fff, $259f, $0063 ; entry 0
    dw $012f, $02bf, $01d5, $0000 ; entry 1
    dw $012f, $02bf, $01d5, $0000 ; entry 2
    dw $318c, $02bf, $5ad6, $0000 ; entry 3
    dw $318c, $02bf, $2a13, $0000 ; entry 4
    dw $0171, $02bf, $2a13, $0000 ; entry 5
    dw $7da0, $02bf, $25f5, $0000 ; entry 6
    dw $318c, $7fff, $5294, $0000 ; entry 7

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_64_9::
; another name for the data at KeyWorldScreenHeader_64_9, whose note is above (E-0381)
KeyWorld34_1_Y3X2_Header::
    db $05, $03, $05, $08, $0a, $33, $47, $00 ; entry 0

; LZSS-compressed: 117 bytes that expand to 360 (E-0016, E-0017)
KeyWorld34_1_Y3X2_Tiles::
    INCBIN "maps/key_worlds/34_1_y3_x2_tiles.lz"

KeyWorldScreenHeader_64_10::
; another name for the data at KeyWorldScreenHeader_64_10, whose note is above (E-0381)
KeyWorld40_1_Y3X2_Header::
    db $ff, $08, $09, $0a, $0d, $33, $48, $00 ; entry 0

; LZSS-compressed: 107 bytes that expand to 360 (E-0016, E-0017)
KeyWorld40_1_Y3X2_Tiles::
    INCBIN "maps/key_worlds/40_1_y3_x2_tiles.lz"

KeyWorldScreenHeader_64_11::
; another name for the data at KeyWorldScreenHeader_64_11, whose note is above (E-0381)
KeyWorld34_1_Y2X2_Header::
    db $ff, $0b, $0d, $0e, $0f, $33, $49, $00 ; entry 0

; LZSS-compressed: 100 bytes that expand to 360 (E-0016, E-0017)
KeyWorld34_1_Y2X2_Tiles::
    INCBIN "maps/key_worlds/34_1_y2_x2_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_64_12::
; another name for the data at KeyWorldScreenHeader_64_12, whose note is above (E-0381)
KeyWorld3C_1_Y2X0_Header::
    db $ff, $0b, $0c, $0d, $0f, $33, $4a, $00 ; entry 0

; LZSS-compressed: 132 bytes that expand to 360 (E-0016, E-0017)
KeyWorld3C_1_Y2X0_Tiles::
    INCBIN "maps/key_worlds/3_c_1_y2_x0_tiles.lz"

KeyWorldScreenHeader_64_13::
; another name for the data at KeyWorldScreenHeader_64_13, whose note is above (E-0381)
KeyWorld12_1_Y0X2_Header::
    db $06, $03, $07, $08, $0a, $33, $4b, $00 ; entry 0

; LZSS-compressed: 124 bytes that expand to 360 (E-0016, E-0017)
KeyWorld12_1_Y0X2_Tiles::
    INCBIN "maps/key_worlds/12_1_y0_x2_tiles.lz"

KeyWorldScreenHeader_64_14::
; another name for the data at KeyWorldScreenHeader_64_14, whose note is above (E-0381)
KeyWorld12_1_Y1X2_Header::
    db $07, $03, $05, $0b, $0d, $33, $4c, $00 ; entry 0

; LZSS-compressed: 177 bytes that expand to 360 (E-0016, E-0017)
KeyWorld12_1_Y1X2_Tiles::
    INCBIN "maps/key_worlds/12_1_y1_x2_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_64_15::
; another name for the data at KeyWorldScreenHeader_64_15, whose note is above (E-0381)
KeyWorld30_1_Y2X0_Header::
    db $04, $03, $04, $05, $0b, $33, $4d, $00 ; entry 0

; LZSS-compressed: 149 bytes that expand to 360 (E-0016, E-0017)
KeyWorld30_1_Y2X0_Tiles::
    INCBIN "maps/key_worlds/30_1_y2_x0_tiles.lz"

KeyWorldScreenHeader_64_16::
; another name for the data at KeyWorldScreenHeader_64_16, whose note is above (E-0381)
KeyWorld3F_3_Y1X2_Header::
    db $05, $00, $03, $07, $08, $33, $4e, $00 ; entry 0

; LZSS-compressed: 164 bytes that expand to 360 (E-0016, E-0017)
KeyWorld3F_3_Y1X2_Tiles::
    INCBIN "maps/key_worlds/3_f_3_y1_x2_tiles.lz"

; an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling
; a gap (E-0222)
KeyWorldScreenHeader64_1::
    db $07, $04, $06, $09, $0b, $33, $4f, $00 ; entry 0

; LZSS-compressed: 181 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen64_1::
    INCBIN "maps/key_worlds/screen64_1.lz"

; LZSS-compressed: 44 bytes that expand to 360 (E-0016, E-0017)
KeyWorld34_1_Y3X2_Attrs::
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0a, $05, $00, $00, $0f, $4d, $00
    db $10, $06, $00, $1e, $06, $00, $74, $0f, $09, $00, $7e, $0a, $00, $9e, $0f, $07
    db $00, $7c, $0f, $15, $00, $18, $0f, $4d, $00, $04, $1f, $01

; LZSS-compressed: 49 bytes that expand to 360 (E-0016, E-0017)
KeyWorld40_1_Y3X2_Attrs::
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0a, $05, $00, $00, $0f, $0f, $02
    db $02, $00, $24, $0f, $11, $02, $00, $5c, $01, $00, $4e, $0f, $4d, $00, $72, $0f
    db $03, $00, $4c, $0f, $01, $00, $24, $0f, $25, $00, $0c, $0f, $17, $00, $0e, $0f
    db $07

; LZSS-compressed: 48 bytes that expand to 360 (E-0016, E-0017)
KeyWorld34_1_Y2X2_Attrs::
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0a, $05, $00, $00, $0f, $0b, $00
    db $08, $06, $00, $28, $0f, $0d, $00, $08, $04, $00, $50, $0f, $0f, $00, $08, $02
    db $00, $78, $0f, $4d, $00, $4c, $0f, $25, $00, $20, $0f, $13, $00, $0a, $0f, $0b

; LZSS-compressed: 57 bytes that expand to 360 (E-0016, E-0017)
KeyWorld3C_1_Y2X0_Attrs::
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0a, $05, $00, $00, $0f, $0b, $03
    db $03, $02, $02, $02, $02, $00, $24, $0f, $11, $00, $32, $00, $00, $4c, $0f, $15
    db $00, $36, $00, $00, $78, $0f, $4d, $00, $9c, $0c, $00, $34, $0f, $13, $00, $34
    db $04, $00, $16, $1f, $0d, $00, $0a, $0f, $0b

; LZSS-compressed: 41 bytes that expand to 360 (E-0016, E-0017)
KeyWorld12_1_Y0X2_Attrs::
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0a, $05, $00, $00, $0f, $05, $00
    db $0a, $06, $00, $22, $0f, $09, $00, $2c, $0c, $00, $4e, $0f, $4d, $00, $ae, $0f
    db $45, $00, $2a, $0f, $15, $00, $02, $0f, $13

; LZSS-compressed: 82 bytes that expand to 360 (E-0016, E-0017)
KeyWorld12_1_Y1X2_Attrs::
    INCBIN "maps/key_worlds/12_1_y1_x2_attrs.lz"

KeyWorld30_1_Y2X0_Attrs::
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0a, $05, $00, $00, $0f, $31, $00
    db $0a, $06, $00, $4e, $0f, $07, $00, $58, $08, $00, $74, $0f, $07, $00, $7c, $0c
    db $00, $9e, $0f, $09, $00, $04, $0a, $00, $c8, $0f, $2b, $00, $08, $00, $00, $06
    db $0e, $00, $1c, $1f, $01, $00, $04, $0f, $11

; LZSS-compressed: 70 bytes that expand to 360 (E-0016, E-0017)
KeyWorld3F_3_Y1X2_Attrs::
    INCBIN "maps/key_worlds/3_f_3_y1_x2_attrs.lz"

; LZSS-compressed: 81 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen64_2::
    INCBIN "maps/key_worlds/screen64_2.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_64_17::
; another name for the data at KeyWorldScreenHeader_64_17, whose note is above (E-0381)
KeyWorld40_0_Y2X3_Header::
    db $02, $02, $05, $06, $0b, $33, $6b, $00 ; entry 0

; LZSS-compressed: 122 bytes that expand to 360 (E-0016, E-0017)
KeyWorld40_0_Y2X3_Tiles::
    INCBIN "maps/key_worlds/40_0_y2_x3_tiles.lz"

KeyWorldScreenHeader_64_18::
; another name for the data at KeyWorldScreenHeader_64_18, whose note is above (E-0381)
KeyWorld40_0_Y2X2_Header::
    db $ff, $ff, $ff, $ff, $ff, $33, $6c, $00 ; entry 0

; LZSS-compressed: 97 bytes that expand to 360 (E-0016, E-0017)
KeyWorld40_0_Y2X2_Tiles::
    INCBIN "maps/key_worlds/40_0_y2_x2_tiles.lz"

KeyWorldScreenHeader_64_19::
; another name for the data at KeyWorldScreenHeader_64_19, whose note is above (E-0381)
KeyWorld34_2_Y0X3_Header::
    db $ff, $ff, $ff, $ff, $ff, $33, $6d, $00 ; entry 0

; LZSS-compressed: 99 bytes that expand to 360 (E-0016, E-0017)
KeyWorld34_2_Y0X3_Tiles::
    INCBIN "maps/key_worlds/34_2_y0_x3_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_64_20::
; another name for the data at KeyWorldScreenHeader_64_20, whose note is above (E-0381)
KeyWorld23_0_Y1X2_Header::
    db $ff, $ff, $ff, $ff, $ff, $33, $6e, $00 ; entry 0

; LZSS-compressed: 114 bytes that expand to 360 (E-0016, E-0017)
KeyWorld23_0_Y1X2_Tiles::
    INCBIN "maps/key_worlds/23_0_y1_x2_tiles.lz"

KeyWorldScreenHeader_64_21::
; another name for the data at KeyWorldScreenHeader_64_21, whose note is above (E-0381)
KeyWorld3C_0_Y3X2_Header::
    db $05, $00, $06, $07, $0b, $33, $6f, $00 ; entry 0

; LZSS-compressed: 152 bytes that expand to 360 (E-0016, E-0017)
KeyWorld3C_0_Y3X2_Tiles::
    INCBIN "maps/key_worlds/3_c_0_y3_x2_tiles.lz"

KeyWorldScreenHeader_64_22::
; another name for the data at KeyWorldScreenHeader_64_22, whose note is above (E-0381)
KeyWorld30_3_Y0X0_Header::
    db $04, $03, $06, $07, $08, $33, $70, $00 ; entry 0

; LZSS-compressed: 183 bytes that expand to 360 (E-0016, E-0017)
KeyWorld30_3_Y0X0_Tiles::
    INCBIN "maps/key_worlds/30_3_y0_x0_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_64_23::
; another name for the data at KeyWorldScreenHeader_64_23, whose note is above (E-0381)
KeyWorld31_1_Y1X1_Header::
    db $ff, $00, $09, $0a, $0c, $33, $71, $00 ; entry 0

; LZSS-compressed: 150 bytes that expand to 360 (E-0016, E-0017)
KeyWorld31_1_Y1X1_Tiles::
    INCBIN "maps/key_worlds/31_1_y1_x1_tiles.lz"

KeyWorldScreenHeader_64_24::
; another name for the data at KeyWorldScreenHeader_64_24, whose note is above (E-0381)
KeyWorld40_5_Y0X1_Header::
    db $ff, $00, $05, $07, $08, $33, $72, $00 ; entry 0

; LZSS-compressed: 159 bytes that expand to 360 (E-0016, E-0017)
KeyWorld40_5_Y0X1_Tiles::
    INCBIN "maps/key_worlds/40_5_y0_x1_tiles.lz"

; an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling
; a gap (E-0222)
KeyWorldScreenHeader64_2::
    db $00, $06, $07, $09, $0e, $33, $73, $00 ; entry 0

; LZSS-compressed: 195 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen64_3::
    INCBIN "maps/key_worlds/screen64_3.lz"

; LZSS-compressed: 37 bytes that expand to 360 (E-0016, E-0017)
KeyWorld40_0_Y2X3_Attrs::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $40, $0f, $2c, $03, $00, $a0, $01
    db $00, $98, $0a, $00, $a0, $0f, $2f, $00, $a4, $02, $00, $ea, $0a, $00, $f6, $0f
    db $03, $00, $10, $1f, $35

; LZSS-compressed: 38 bytes that expand to 360 (E-0016, E-0017)
KeyWorld40_0_Y2X2_Attrs::
    db $68, $01, $00, $01, $00, $00, $0f, $20, $02, $02, $00, $22, $0f, $11, $00, $34
    db $0f, $11, $02, $00, $7e, $01, $00, $70, $0f, $09, $03, $00, $a0, $0f, $4d, $00
    db $00, $1f, $4d, $00, $08, $13

; LZSS-compressed: 36 bytes that expand to 360 (E-0016, E-0017)
KeyWorld34_2_Y0X3_Attrs::
    db $68, $01, $00, $01, $00, $00, $0f, $42, $03, $00, $56, $03, $00, $4a, $0f, $0b
    db $00, $56, $04, $00, $5a, $08, $00, $7c, $0c, $00, $7c, $08, $00, $ab, $0f, $4d
    db $00, $08, $1f, $49

; LZSS-compressed: 53 bytes that expand to 360 (E-0016, E-0017)
KeyWorld23_0_Y1X2_Attrs::
    db $68, $01, $00, $01, $00, $00, $0f, $20, $02, $02, $02, $02, $00, $24, $0f, $09
    db $00, $34, $00, $03, $03, $03, $03, $00, $34, $00, $00, $36, $04, $00, $54, $0e
    db $00, $54, $04, $00, $58, $04, $00, $76, $0f, $03, $00, $7e, $04, $00, $a7, $0f
    db $4d, $00, $07, $1f, $4d

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
KeyWorld3C_0_Y3X2_Attrs::
    INCBIN "maps/key_worlds/3_c_0_y3_x2_attrs.lz"

KeyWorld30_3_Y0X0_Attrs::
    INCBIN "maps/key_worlds/30_3_y0_x0_attrs.lz"

; LZSS-compressed: 55 bytes that expand to 360 (E-0016, E-0017)
KeyWorld31_1_Y1X1_Attrs::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $1e, $0f, $0a, $03, $03, $03, $03
    db $00, $6e, $0f, $0b, $00, $80, $02, $00, $7e, $08, $00, $7e, $04, $00, $a6, $0e
    db $00, $7e, $00, $00, $80, $04, $00, $cc, $04, $00, $cc, $0e, $00, $ec, $04, $00
    db $e6, $0f, $15, $00, $14, $1f, $33

; LZSS-compressed: 72 bytes that expand to 360 (E-0016, E-0017)
KeyWorld40_5_Y0X1_Attrs::
    INCBIN "maps/key_worlds/40_5_y0_x1_attrs.lz"

; LZSS-compressed: 92 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen64_4::
    INCBIN "maps/key_worlds/screen64_4.lz"

; an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling
; a gap (E-0222)
; record: screen header
KeyWorldScreenHeader64_3::
    db $07, $05, $06, $0c, $0d, $33, $8f, $00 ; entry 0

; LZSS-compressed: 100 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen64_5::
    INCBIN "maps/key_worlds/screen64_5.lz"

; the 8-byte header of the screen stream that follows (E-0222)
KeyWorldScreenHeader_64_25::
; another name for the data at KeyWorldScreenHeader_64_25, whose note is above (E-0381)
KeyWorld40_4_Y1X3_Header::
    db $ff, $ff, $ff, $ff, $ff, $33, $90, $00 ; entry 0

; LZSS-compressed: 79 bytes that expand to 360 (E-0016, E-0017)
KeyWorld40_4_Y1X3_Tiles::
    INCBIN "maps/key_worlds/40_4_y1_x3_tiles.lz"

KeyWorldScreenHeader_64_26::
; another name for the data at KeyWorldScreenHeader_64_26, whose note is above (E-0381)
KeyWorld41_2_Y1X2_Header::
    db $ff, $06, $07, $0c, $0f, $33, $91, $00 ; entry 0

; LZSS-compressed: 93 bytes that expand to 360 (E-0016, E-0017)
KeyWorld41_2_Y1X2_Tiles::
    INCBIN "maps/key_worlds/41_2_y1_x2_tiles.lz"

; record: screen header
KeyWorldScreenHeader_64_27::
; another name for the data at KeyWorldScreenHeader_64_27, whose note is above (E-0381)
KeyWorld50_4_Y1X3_Header::
    db $ff, $09, $0a, $0d, $0f, $33, $92, $00 ; entry 0

; LZSS-compressed: 101 bytes that expand to 360 (E-0016, E-0017)
KeyWorld50_4_Y1X3_Tiles::
    INCBIN "maps/key_worlds/50_4_y1_x3_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
KeyWorldScreenHeader_64_28::
; another name for the data at KeyWorldScreenHeader_64_28, whose note is above (E-0381)
KeyWorld3C_3_Y0X0_Header::
    db $05, $02, $05, $06, $0c, $33, $93, $00 ; entry 0

; LZSS-compressed: 120 bytes that expand to 360 (E-0016, E-0017)
KeyWorld3C_3_Y0X0_Tiles::
    INCBIN "maps/key_worlds/3_c_3_y0_x0_tiles.lz"

KeyWorldScreenHeader_64_29::
; another name for the data at KeyWorldScreenHeader_64_29, whose note is above (E-0381)
KeyWorld4C_4_Y0X0_Header::
    db $07, $00, $08, $09, $07, $33, $94, $00 ; entry 0

; LZSS-compressed: 165 bytes that expand to 360 (E-0016, E-0017)
KeyWorld4C_4_Y0X0_Tiles::
    INCBIN "maps/key_worlds/4_c_4_y0_x0_tiles.lz"

; record: screen header
KeyWorldScreenHeader_64_30::
; another name for the data at KeyWorldScreenHeader_64_30, whose note is above (E-0381)
KeyWorld30_0_Y3X3_Header::
    db $ff, $00, $03, $04, $0a, $33, $95, $00 ; entry 0

; LZSS-compressed: 151 bytes that expand to 360 (E-0016, E-0017)
KeyWorld30_0_Y3X3_Tiles::
    INCBIN "maps/key_worlds/30_0_y3_x3_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
KeyWorldScreenHeader_64_31::
; another name for the data at KeyWorldScreenHeader_64_31, whose note is above (E-0381)
KeyWorld40_5_Y1X1_Header::
    db $ff, $00, $03, $07, $09, $33, $96, $00 ; entry 0

; LZSS-compressed: 145 bytes that expand to 360 (E-0016, E-0017)
KeyWorld40_5_Y1X1_Tiles::
    INCBIN "maps/key_worlds/40_5_y1_x1_tiles.lz"

; an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling
; a gap (E-0222)
; record: screen header
KeyWorldScreenHeader64_4::
    db $07, $02, $06, $07, $09, $33, $97, $00 ; entry 0

; LZSS-compressed: 167 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen64_6::
    INCBIN "maps/key_worlds/screen64_6.lz"

; LZSS-compressed: 37 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen64_7::
    db $68, $01, $00, $03, $00, $00, $0f, $4d, $00, $1e, $0f, $0a, $01, $00, $7e, $03
    db $00, $72, $0f, $15, $00, $80, $08, $00, $a6, $0f, $29, $00, $a2, $0a, $00, $f0
    db $0f, $4d, $00, $7e, $00

; LZSS-compressed: 41 bytes that expand to 360 (E-0016, E-0017)
KeyWorld40_4_Y1X3_Attrs::
    db $68, $01, $00, $03, $00, $00, $0f, $4d, $00, $50, $0f, $3c, $01, $01, $01, $01
    db $00, $a0, $0f, $0f, $00, $b0, $00, $00, $c6, $0f, $0f, $00, $d6, $02, $00, $ee
    db $0f, $0d, $00, $fc, $04, $00, $16, $1f, $2b

; LZSS-compressed: 51 bytes that expand to 360 (E-0016, E-0017)
KeyWorld41_2_Y1X2_Attrs::
    db $68, $01, $00, $03, $00, $00, $0f, $4d, $00, $28, $0f, $14, $01, $01, $00, $76
    db $0f, $0f, $01, $00, $ac, $03, $00, $a0, $0f, $09, $00, $ac, $04, $00, $c4, $0f
    db $0b, $00, $d0, $08, $00, $ee, $0f, $09, $00, $ce, $0f, $15, $00, $cc, $0a, $00
    db $40, $1f, $01

; LZSS-compressed: 47 bytes that expand to 360 (E-0016, E-0017)
KeyWorld50_4_Y1X3_Attrs::
    db $68, $01, $00, $03, $00, $00, $0f, $4d, $00, $22, $0f, $0e, $02, $02, $02, $02
    db $00, $72, $0f, $15, $02, $02, $01, $01, $01, $01, $00, $a0, $0f, $0d, $00, $b0
    db $00, $00, $c4, $0f, $4d, $00, $e8, $0e, $00, $e8, $04, $00, $3e, $1f, $03

KeyWorld3C_3_Y0X0_Attrs::
    db $68, $01, $00, $03, $00, $00, $0f, $18, $01, $00, $2c, $03, $00, $20, $0f, $15
    db $00, $30, $08, $00, $54, $0f, $29, $00, $52, $0a, $00, $32, $04, $00, $a6, $0f
    db $01, $00, $52, $0f, $4b, $00, $18, $1f, $29

; LZSS-compressed: 76 bytes that expand to 360 (E-0016, E-0017)
KeyWorld4C_4_Y0X0_Attrs::
    INCBIN "maps/key_worlds/4_c_4_y0_x0_attrs.lz"

; LZSS-compressed: 62 bytes that expand to 360 (E-0016, E-0017)
KeyWorld30_0_Y3X3_Attrs::
    db $68, $01, $00, $03, $00, $00, $0f, $16, $01, $01, $00, $18, $0f, $15, $00, $2a
    db $06, $00, $2a, $04, $00, $52, $0f, $0b, $00, $7a, $0f, $0f, $00, $2a, $02, $00
    db $a2, $02, $00, $2a, $00, $00, $a2, $0f, $07, $00, $ca, $08, $00, $c8, $0f, $2b
    db $00, $a8, $08, $00, $12, $1f, $0d, $00, $1a, $1a, $00, $40, $1f, $01

; LZSS-compressed: 67 bytes that expand to 360 (E-0016, E-0017)
KeyWorld40_5_Y1X1_Attrs::
    INCBIN "maps/key_worlds/40_5_y1_x1_attrs.lz"

; LZSS-compressed: 90 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen64_8::
    INCBIN "maps/key_worlds/screen64_8.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_64_32::
; another name for the data at KeyWorldScreenHeader_64_32, whose note is above (E-0381)
KeyWorld20_0_Y1X3_Header::
    db $03, $04, $05, $0c, $0e, $03, $b3, $00 ; entry 0

; LZSS-compressed: 149 bytes that expand to 360 (E-0016, E-0017)
KeyWorld20_0_Y1X3_Tiles::
    INCBIN "maps/key_worlds/20_0_y1_x3_tiles.lz"

KeyWorldScreenHeader_64_33::
; another name for the data at KeyWorldScreenHeader_64_33, whose note is above (E-0381)
KeyWorld02_0_Y2X1_Header::
    db $04, $04, $05, $0c, $0e, $03, $b4, $00 ; entry 0

; LZSS-compressed: 153 bytes that expand to 360 (E-0016, E-0017)
KeyWorld02_0_Y2X1_Tiles::
    INCBIN "maps/key_worlds/02_0_y2_x1_tiles.lz"

KeyWorldScreenHeader_64_34::
; another name for the data at KeyWorldScreenHeader_64_34, whose note is above (E-0381)
KeyWorld0F_0_Y1X2_Header::
    db $06, $00, $04, $05, $0e, $2e, $b5, $00 ; entry 0

; LZSS-compressed: 137 bytes that expand to 360 (E-0016, E-0017)
KeyWorld0F_0_Y1X2_Tiles::
    INCBIN "maps/key_worlds/0_f_0_y1_x2_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_64_35::
; another name for the data at KeyWorldScreenHeader_64_35, whose note is above (E-0381)
KeyWorld0A_0_Y1X1_Header::
    db $00, $04, $05, $0c, $0e, $2e, $b6, $00 ; entry 0

; LZSS-compressed: 180 bytes that expand to 360 (E-0016, E-0017)
KeyWorld0A_0_Y1X1_Tiles::
    INCBIN "maps/key_worlds/0_a_0_y1_x1_tiles.lz"

KeyWorldScreenHeader_64_36::
; another name for the data at KeyWorldScreenHeader_64_36, whose note is above (E-0381)
KeyWorld10_0_Y3X2_Header::
    db $05, $04, $05, $0c, $0e, $03, $b7, $00 ; entry 0

; LZSS-compressed: 146 bytes that expand to 360 (E-0016, E-0017)
KeyWorld10_0_Y3X2_Tiles::
    INCBIN "maps/key_worlds/10_0_y3_x2_tiles.lz"

KeyWorldScreenHeader_64_37::
; another name for the data at KeyWorldScreenHeader_64_37, whose note is above (E-0381)
KeyWorld14_1_Y1X2_Header::
    db $06, $04, $05, $0c, $0e, $03, $b8, $00 ; entry 0

; LZSS-compressed: 189 bytes that expand to 360 (E-0016, E-0017)
KeyWorld14_1_Y1X2_Tiles::
    INCBIN "maps/key_worlds/14_1_y1_x2_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_64_38::
; another name for the data at KeyWorldScreenHeader_64_38, whose note is above (E-0381)
KeyWorld01_0_Y2X2_Header::
    db $01, $04, $05, $0d, $0e, $03, $b9, $00 ; entry 0

; LZSS-compressed: 161 bytes that expand to 360 (E-0016, E-0017)
KeyWorld01_0_Y2X2_Tiles::
    INCBIN "maps/key_worlds/01_0_y2_x2_tiles.lz"

KeyWorldScreenHeader_64_39::
; another name for the data at KeyWorldScreenHeader_64_39, whose note is above (E-0381)
KeyWorld11_1_Y2X2_Header::
    db $00, $04, $05, $07, $0e, $03, $ba, $00 ; entry 0

; LZSS-compressed: 193 bytes that expand to 360 (E-0016, E-0017)
KeyWorld11_1_Y2X2_Tiles::
    INCBIN "maps/key_worlds/11_1_y2_x2_tiles.lz"

KeyWorldScreenHeader_64_40::
; another name for the data at KeyWorldScreenHeader_64_40, whose note is above (E-0381)
KeyWorld17_0_Y1X2_Header::
    db $01, $04, $06, $08, $0b, $03, $bb, $00 ; entry 0

; LZSS-compressed: 216 bytes that expand to 360 (E-0016, E-0017)
KeyWorld17_0_Y1X2_Tiles::
    INCBIN "maps/key_worlds/17_0_y1_x2_tiles.lz"

; LZSS-compressed: 47 bytes that expand to 360 (E-0016, E-0017)
KeyWorld20_0_Y1X3_Attrs::
    db $68, $01, $02, $01, $02, $00, $0f, $4d, $02, $52, $0f, $3e, $02, $fe, $ff, $01
    db $02, $fe, $fe, $02, $fc, $ff, $01, $02, $fc, $fe, $02, $fa, $ff, $01, $02, $fa
    db $fe, $02, $f8, $ff, $01, $02, $f8, $fe, $02, $f6, $ff, $01, $02, $a0, $f6

; LZSS-compressed: 69 bytes that expand to 360 (E-0016, E-0017)
KeyWorld02_0_Y2X1_Attrs::
    INCBIN "maps/key_worlds/02_0_y2_x1_attrs.lz"

; LZSS-compressed: 31 bytes that expand to 360 (E-0016, E-0017)
KeyWorld0F_0_Y1X2_Attrs::
    db $68, $01, $02, $01, $02, $00, $0f, $4d, $02, $4c, $0f, $38, $02, $f8, $ff, $01
    db $02, $f8, $fe, $02, $f6, $ff, $01, $02, $d2, $0f, $4d, $02, $f6, $0f, $0f

; LZSS-compressed: 60 bytes that expand to 360 (E-0016, E-0017)
KeyWorld0A_0_Y1X1_Attrs::
    db $68, $01, $03, $01, $03, $00, $0f, $1e, $02, $03, $32, $01, $03, $24, $0f, $0b
    db $03, $32, $02, $03, $36, $0a, $03, $56, $0e, $03, $32, $0f, $11, $03, $30, $0c
    db $03, $fc, $f2, $03, $a2, $0f, $05, $03, $aa, $06, $03, $c4, $0f, $09, $03, $a8
    db $08, $03, $ec, $0f, $07, $03, $f4, $0c, $03, $16, $1f, $2b

; LZSS-compressed: 34 bytes that expand to 360 (E-0016, E-0017)
KeyWorld10_0_Y3X2_Attrs::
    db $68, $01, $02, $01, $02, $00, $0f, $4d, $02, $52, $0f, $3e, $02, $fe, $ff, $01
    db $02, $b2, $0f, $4d, $02, $c4, $00, $02, $16, $1f, $0d, $02, $f6, $ff, $01, $02
    db $a0, $f6

; LZSS-compressed: 66 bytes that expand to 360 (E-0016, E-0017)
KeyWorld14_1_Y1X2_Attrs::
    INCBIN "maps/key_worlds/14_1_y1_x2_attrs.lz"

; LZSS-compressed: 54 bytes that expand to 360 (E-0016, E-0017)
KeyWorld01_0_Y2X2_Attrs::
    db $68, $01, $02, $01, $02, $00, $0f, $48, $02, $fc, $ff, $01, $02, $5c, $0f, $05
    db $02, $fe, $fc, $02, $84, $0f, $07, $02, $fe, $fa, $02, $f8, $ff, $03, $02, $84
    db $0f, $15, $02, $58, $02, $02, $f0, $0f, $0b, $02, $fc, $f4, $02, $16, $1f, $11
    db $02, $fa, $fc, $02, $a0, $f6

; LZSS-compressed: 62 bytes that expand to 360 (E-0016, E-0017)
KeyWorld11_1_Y2X2_Attrs::
    db $68, $01, $03, $01, $03, $00, $0f, $1c, $02, $02, $02, $02, $03, $20, $0f, $0f
    db $03, $30, $00, $03, $fa, $fc, $03, $56, $0f, $0b, $03, $fe, $f6, $03, $7e, $0e
    db $03, $30, $00, $03, $7e, $0c, $03, $a4, $0e, $03, $7e, $08, $03, $c2, $0f, $35
    db $03, $32, $00, $03, $0e, $1f, $0d, $03, $00, $04, $03, $36, $1f, $0b

; LZSS-compressed: 83 bytes that expand to 360 (E-0016, E-0017)
KeyWorld17_0_Y1X2_Attrs::
    INCBIN "maps/key_worlds/17_0_y1_x2_attrs.lz"

; an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling
; a gap (E-0222)
; record: screen header
KeyWorldScreenHeader64_5::
    db $05, $02, $06, $09, $0d, $07, $d7, $00 ; entry 0

; LZSS-compressed: 140 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen64_9::
    INCBIN "maps/key_worlds/screen64_9.lz"

; the 8-byte header of the screen stream that follows (E-0222)
KeyWorldScreenHeader_64_41::
; another name for the data at KeyWorldScreenHeader_64_41, whose note is above (E-0381)
KeyWorld18_0_Y3X1_Header::
    db $06, $02, $07, $09, $0f, $07, $d8, $00 ; entry 0

; LZSS-compressed: 164 bytes that expand to 360 (E-0016, E-0017)
KeyWorld18_0_Y3X1_Tiles::
    INCBIN "maps/key_worlds/18_0_y3_x1_tiles.lz"

KeyWorldScreenHeader_64_42::
; another name for the data at KeyWorldScreenHeader_64_42, whose note is above (E-0381)
KeyWorld0B_0_Y2X1_Header::
    db $07, $02, $06, $09, $0d, $07, $d9, $00 ; entry 0

; LZSS-compressed: 152 bytes that expand to 360 (E-0016, E-0017)
KeyWorld0B_0_Y2X1_Tiles::
    INCBIN "maps/key_worlds/0_b_0_y2_x1_tiles.lz"

; record: screen header
KeyWorldScreenHeader_64_43::
; another name for the data at KeyWorldScreenHeader_64_43, whose note is above (E-0381)
KeyWorld17_0_Y3X1_Header::
    db $02, $02, $03, $06, $0d, $07, $da, $00 ; entry 0

; LZSS-compressed: 194 bytes that expand to 360 (E-0016, E-0017)
KeyWorld17_0_Y3X1_Tiles::
    INCBIN "maps/key_worlds/17_0_y3_x1_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
KeyWorldScreenHeader_64_44::
; another name for the data at KeyWorldScreenHeader_64_44, whose note is above (E-0381)
KeyWorld0C_0_Y1X2_Header::
    db $03, $01, $04, $09, $0a, $07, $db, $00 ; entry 0

; LZSS-compressed: 205 bytes that expand to 360 (E-0016, E-0017)
KeyWorld0C_0_Y1X2_Tiles::
    INCBIN "maps/key_worlds/0_c_0_y1_x2_tiles.lz"

KeyWorldScreenHeader_64_45::
; another name for the data at KeyWorldScreenHeader_64_45, whose note is above (E-0381)
KeyWorld3A_0_Y1X3_Header::
    db $07, $04, $07, $09, $0b, $07, $dc, $00 ; entry 0

; LZSS-compressed: 202 bytes that expand to 360 (E-0016, E-0017)
KeyWorld3A_0_Y1X3_Tiles::
    INCBIN "maps/key_worlds/3_a_0_y1_x3_tiles.lz"

; record: screen header
KeyWorldScreenHeader_64_46::
; another name for the data at KeyWorldScreenHeader_64_46, whose note is above (E-0381)
KeyWorld0B_0_Y1X2_Header::
    db $ff, $02, $03, $07, $0b, $07, $dd, $00 ; entry 0

; LZSS-compressed: 207 bytes that expand to 360 (E-0016, E-0017)
KeyWorld0B_0_Y1X2_Tiles::
    INCBIN "maps/key_worlds/0_b_0_y1_x2_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
KeyWorldScreenHeader_64_47::
; another name for the data at KeyWorldScreenHeader_64_47, whose note is above (E-0381)
KeyWorld1E_1_Y2X1_Header::
    db $ff, $00, $08, $07, $0f, $07, $de, $00 ; entry 0

; LZSS-compressed: 205 bytes that expand to 360 (E-0016, E-0017)
KeyWorld1E_1_Y2X1_Tiles::
    INCBIN "maps/key_worlds/1_e_1_y2_x1_tiles.lz"

KeyWorldScreenHeader_64_48::
; another name for the data at KeyWorldScreenHeader_64_48, whose note is above (E-0381)
KeyWorld19_1_Y2X1_Header::
    db $07, $05, $0a, $0b, $0d, $07, $df, $00 ; entry 0

; LZSS-compressed: 222 bytes that expand to 360 (E-0016, E-0017)
KeyWorld19_1_Y2X1_Tiles::
    INCBIN "maps/key_worlds/19_1_y2_x1_tiles.lz"

; LZSS-compressed: 55 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen64_10::
    db $68, $01, $02, $01, $02, $00, $05, $02, $f6, $ff, $15, $02, $06, $06, $02, $28
    db $0f, $0f, $02, $08, $02, $02, $50, $0f, $11, $02, $08, $00, $02, $78, $0f, $01
    db $02, $76, $0f, $29, $02, $4c, $0f, $05, $02, $26, $0f, $17, $02, $26, $0a, $02
    db $18, $1f, $09, $02, $fe, $ff, $0d

; LZSS-compressed: 73 bytes that expand to 360 (E-0016, E-0017)
KeyWorld18_0_Y3X1_Attrs::
    INCBIN "maps/key_worlds/18_0_y3_x1_attrs.lz"

; LZSS-compressed: 43 bytes that expand to 360 (E-0016, E-0017)
KeyWorld0B_0_Y2X1_Attrs::
    db $68, $01, $02, $01, $02, $00, $05, $02, $f6, $ff, $4d, $02, $1a, $0f, $05, $02
    db $1c, $06, $02, $78, $0f, $01, $02, $72, $0e, $02, $1c, $04, $02, $a6, $0f, $01
    db $02, $76, $0f, $19, $02, $e6, $0f, $4d, $02, $0a, $1a

; LZSS-compressed: 68 bytes that expand to 360 (E-0016, E-0017)
KeyWorld17_0_Y3X1_Attrs::
    INCBIN "maps/key_worlds/17_0_y3_x1_attrs.lz"

; LZSS-compressed: 66 bytes that expand to 360 (E-0016, E-0017)
KeyWorld0C_0_Y1X2_Attrs::
    INCBIN "maps/key_worlds/0_c_0_y1_x2_attrs.lz"

; LZSS-compressed: 84 bytes that expand to 360 (E-0016, E-0017)
KeyWorld3A_0_Y1X3_Attrs::
    INCBIN "maps/key_worlds/3_a_0_y1_x3_attrs.lz"

; LZSS-compressed: 57 bytes that expand to 360 (E-0016, E-0017)
KeyWorld0B_0_Y1X2_Attrs::
    db $68, $01, $02, $01, $02, $00, $05, $02, $f6, $ff, $15, $02, $08, $06, $02, $28
    db $0f, $0d, $02, $04, $04, $02, $50, $0f, $29, $02, $fe, $f2, $02, $fa, $fa, $02
    db $a0, $0f, $05, $02, $f4, $fc, $02, $c8, $0f, $03, $02, $f2, $fe, $02, $f0, $0f
    db $09, $02, $28, $0f, $15, $02, $fe, $ff, $0d

; LZSS-compressed: 72 bytes that expand to 360 (E-0016, E-0017)
KeyWorld1E_1_Y2X1_Attrs::
    INCBIN "maps/key_worlds/1_e_1_y2_x1_attrs.lz"

KeyWorld19_1_Y2X1_Attrs::
    INCBIN "maps/key_worlds/19_1_y2_x1_attrs.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_64_49::
; another name for the data at KeyWorldScreenHeader_64_49, whose note is above (E-0381)
KeyWorld08_0_Y2X1_Header::
    db $06, $06, $08, $09, $0b, $3c, $fb, $00 ; entry 0

; LZSS-compressed: 116 bytes that expand to 360 (E-0016, E-0017)
KeyWorld08_0_Y2X1_Tiles::
    INCBIN "maps/key_worlds/08_0_y2_x1_tiles.lz"

KeyWorldScreenHeader_64_50::
; another name for the data at KeyWorldScreenHeader_64_50, whose note is above (E-0381)
KeyWorld05_0_Y3X0_Header::
    db $ff, $ff, $ff, $ff, $ff, $0b, $fc, $00 ; entry 0

; LZSS-compressed: 97 bytes that expand to 360 (E-0016, E-0017)
KeyWorld05_0_Y3X0_Tiles::
    INCBIN "maps/key_worlds/05_0_y3_x0_tiles.lz"

KeyWorldScreenHeader_64_51::
; another name for the data at KeyWorldScreenHeader_64_51, whose note is above (E-0381)
KeyWorld10_0_Y3X0_Header::
    db $ff, $08, $09, $0a, $0b, $25, $fd, $00 ; entry 0

; LZSS-compressed: 140 bytes that expand to 360 (E-0016, E-0017)
KeyWorld10_0_Y3X0_Tiles::
    INCBIN "maps/key_worlds/10_0_y3_x0_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_64_52::
; another name for the data at KeyWorldScreenHeader_64_52, whose note is above (E-0381)
KeyWorld02_0_Y3X0_Header::
    db $ff, $ff, $ff, $ff, $ff, $25, $fe, $00 ; entry 0

; LZSS-compressed: 130 bytes that expand to 360 (E-0016, E-0017)
KeyWorld02_0_Y3X0_Tiles::
    INCBIN "maps/key_worlds/02_0_y3_x0_tiles.lz"

KeyWorldScreenHeader_64_53::
; another name for the data at KeyWorldScreenHeader_64_53, whose note is above (E-0381)
KeyWorld01_0_Y3X0_Header::
    db $04, $05, $06, $0b, $0c, $3c, $ff, $00 ; entry 0

; LZSS-compressed: 166 bytes that expand to 360 (E-0016, E-0017)
KeyWorld01_0_Y3X0_Tiles::
    INCBIN "maps/key_worlds/01_0_y3_x0_tiles.lz"

KeyWorldScreenHeader_64_54::
; another name for the data at KeyWorldScreenHeader_64_54, whose note is above (E-0381)
KeyWorld00_0_Y3X0_Header::
    db $01, $04, $06, $07, $09, $3c, $00, $01 ; entry 0

; LZSS-compressed: 209 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y3X0_Tiles::
    INCBIN "maps/key_worlds/00_0_y3_x0_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_64_55::
; another name for the data at KeyWorldScreenHeader_64_55, whose note is above (E-0381)
KeyWorld04_0_Y3X0_Header::
    db $04, $03, $05, $0a, $0b, $3c, $01, $01 ; entry 0

; LZSS-compressed: 182 bytes that expand to 360 (E-0016, E-0017)
KeyWorld04_0_Y3X0_Tiles::
    INCBIN "maps/key_worlds/04_0_y3_x0_tiles.lz"

KeyWorldScreenHeader_64_56::
; another name for the data at KeyWorldScreenHeader_64_56, whose note is above (E-0381)
KeyWorld07_0_Y3X2_Header::
    db $06, $04, $06, $0d, $0e, $3c, $02, $01 ; entry 0

; LZSS-compressed: 185 bytes that expand to 360 (E-0016, E-0017)
KeyWorld07_0_Y3X2_Tiles::
    INCBIN "maps/key_worlds/07_0_y3_x2_tiles.lz"

KeyWorldScreenHeader_64_57::
; another name for the data at KeyWorldScreenHeader_64_57, whose note is above (E-0381)
KeyWorld06_0_Y3X0_Header::
    db $06, $00, $03, $07, $08, $3c, $03, $01 ; entry 0

; LZSS-compressed: 247 bytes that expand to 360 (E-0016, E-0017)
KeyWorld06_0_Y3X0_Tiles::
    INCBIN "maps/key_worlds/06_0_y3_x0_tiles.lz"

; LZSS-compressed: 39 bytes that expand to 360 (E-0016, E-0017)
KeyWorld08_0_Y2X1_Attrs::
    db $68, $01, $02, $02, $ff, $f6, $01, $02, $0a, $05, $02, $00, $0f, $4d, $02, $10
    db $06, $02, $1e, $06, $02, $74, $0f, $13, $02, $fe, $ff, $01, $02, $ae, $0f, $21
    db $02, $f5, $0f, $4d, $02, $55, $1e

KeyWorld05_0_Y3X0_Attrs::
    db $68, $01, $03, $03, $ff, $f6, $01, $03, $0a, $05, $03, $00, $0f, $33, $00, $00
    db $02, $02, $02, $02, $03, $4c, $0f, $11, $03, $5a, $00, $03, $74, $0f, $13, $03
    db $ad, $0f, $4d, $03, $0d, $1f, $47

; LZSS-compressed: 47 bytes that expand to 360 (E-0016, E-0017)
KeyWorld10_0_Y3X0_Attrs::
    db $68, $01, $02, $02, $ff, $f6, $01, $02, $0a, $05, $02, $00, $0f, $09, $02, $0a
    db $06, $02, $26, $0f, $33, $02, $08, $0f, $15, $02, $06, $04, $02, $fa, $ff, $01
    db $02, $fa, $fe, $02, $f8, $ff, $01, $02, $a0, $ff, $4d, $02, $49, $1f, $0b

; LZSS-compressed: 51 bytes that expand to 360 (E-0016, E-0017)
KeyWorld02_0_Y3X0_Attrs::
    db $68, $01, $03, $03, $ff, $f6, $01, $03, $0a, $05, $03, $00, $0f, $0f, $02, $02
    db $03, $24, $0f, $11, $03, $36, $02, $03, $4e, $0f, $0d, $03, $5c, $04, $03, $76
    db $0f, $0f, $02, $02, $03, $fa, $fc, $03, $aa, $0f, $01, $03, $d1, $0f, $4d, $03
    db $31, $1f, $23

; LZSS-compressed: 44 bytes that expand to 360 (E-0016, E-0017)
KeyWorld01_0_Y3X0_Attrs::
    db $68, $01, $02, $02, $ff, $f6, $01, $02, $0a, $05, $02, $00, $0f, $09, $02, $0a
    db $06, $02, $26, $0f, $31, $02, $30, $08, $02, $76, $0f, $13, $02, $00, $0f, $1d
    db $02, $08, $0f, $09, $02, $fc, $ff, $01, $02, $a0, $ff, $45

; LZSS-compressed: 80 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y3X0_Attrs::
    INCBIN "maps/key_worlds/00_0_y3_x0_attrs.lz"

; LZSS-compressed: 53 bytes that expand to 360 (E-0016, E-0017)
KeyWorld04_0_Y3X0_Attrs::
    db $68, $01, $02, $02, $ff, $f6, $01, $02, $0a, $05, $02, $00, $0f, $07, $02, $0a
    db $06, $02, $24, $0f, $09, $02, $2e, $0a, $02, $4e, $0f, $2d, $02, $2e, $0f, $13
    db $02, $08, $02, $02, $06, $06, $02, $c4, $0f, $09, $02, $00, $08, $02, $ec, $0f
    db $07, $02, $19, $1f, $3b

; LZSS-compressed: 79 bytes that expand to 360 (E-0016, E-0017)
KeyWorld07_0_Y3X2_Attrs::
    INCBIN "maps/key_worlds/07_0_y3_x2_attrs.lz"

; LZSS-compressed: 99 bytes that expand to 360 (E-0016, E-0017)
KeyWorld06_0_Y3X0_Attrs::
    INCBIN "maps/key_worlds/06_0_y3_x0_attrs.lz"
    ds $19, $00
