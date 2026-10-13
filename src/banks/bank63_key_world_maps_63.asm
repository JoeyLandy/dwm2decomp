; ROM bank $63: key-world map screens
; The annotated listing of this bank is build/listing/bank63.asm.

SECTION "Bank 63", ROMX[$4000], BANK[$63]
    db $63

; compressed BG tiles (2048 bytes, 128 tiles) of key-world kind 1: entry 1 of KeyWorldTilesetTable,
; decompressed to vTiles2 by RunWCC44Type_420D_Case00
; LZSS-compressed: 1127 bytes that expand to 2048 (E-0016, E-0017)
KeyWorldTiles1::
    INCBIN "maps/key_worlds/tiles1.lz"

; entry 1 of KeyWorldTilesetTable; RunWCC44Type_420D_Case00 copies these $40 bytes to
; wBGPaletteBuffer (E-0139, C1)
; record: one CGB palette: 4 BGR555 colours
KeyWorldPalettes1::
    dw $7da0, $7fff, $7fe0, $0063 ; entry 0
    dw $0160, $3fbf, $03e2, $0000 ; entry 1
    dw $1415, $7dff, $7c18, $2c09 ; entry 2
    dw $318c, $5294, $03e2, $0000 ; entry 3
    dw $158f, $2ab7, $03e2, $0000 ; entry 4
    dw $0171, $3fbf, $03e2, $0000 ; entry 5
    dw $1415, $7fff, $03e2, $0000 ; entry 6
    dw $318c, $7fff, $5294, $0000 ; entry 7

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_63_44A8::
KeyWorld00_0_Y2X2_Header::
    db $02, $01, $05, $0e, $0f, $33, $11, $00 ; entry 0

; LZSS-compressed: 143 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y2X2_Tiles::
    INCBIN "maps/key_worlds/00_0_y2_x2_tiles.lz"

KeyWorldScreenHeader_63_453F::
KeyWorld12_1_Y2X2_Header::
    db $07, $01, $05, $0e, $0f, $33, $12, $00 ; entry 0

; LZSS-compressed: 156 bytes that expand to 360 (E-0016, E-0017)
KeyWorld12_1_Y2X2_Tiles::
    INCBIN "maps/key_worlds/12_1_y2_x2_tiles.lz"

KeyWorldScreenHeader_63_45E3::
KeyWorld15_1_Y2X2_Header::
    db $06, $01, $05, $0e, $0f, $33, $13, $00 ; entry 0

; LZSS-compressed: 161 bytes that expand to 360 (E-0016, E-0017)
KeyWorld15_1_Y2X2_Tiles::
    INCBIN "maps/key_worlds/15_1_y2_x2_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_63_468C::
KeyWorld10_0_Y2X2_Header::
    db $ff, $01, $06, $0e, $0f, $33, $14, $00 ; entry 0

; LZSS-compressed: 153 bytes that expand to 360 (E-0016, E-0017)
KeyWorld10_0_Y2X2_Tiles::
    INCBIN "maps/key_worlds/10_0_y2_x2_tiles.lz"

KeyWorldScreenHeader_63_472D::
KeyWorld30_3_Y1X1_Header::
    db $01, $01, $05, $0e, $0f, $33, $15, $00 ; entry 0

; LZSS-compressed: 159 bytes that expand to 360 (E-0016, E-0017)
KeyWorld30_3_Y1X1_Tiles::
    INCBIN "maps/key_worlds/30_3_y1_x1_tiles.lz"

KeyWorldScreenHeader_63_47D4::
KeyWorld31_1_Y2X2_Header::
    db $07, $01, $05, $0e, $0f, $33, $16, $00 ; entry 0

; LZSS-compressed: 139 bytes that expand to 360 (E-0016, E-0017)
KeyWorld31_1_Y2X2_Tiles::
    INCBIN "maps/key_worlds/31_1_y2_x2_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_63_4867::
KeyWorld1E_0_Y2X2_Header::
    db $ff, $01, $06, $0e, $0f, $33, $17, $00 ; entry 0

KeyWorld1E_0_Y2X2_Tiles::
    INCBIN "maps/key_worlds/1_e_0_y2_x2_tiles.lz"

KeyWorldScreenHeader_63_48FA::
KeyWorld30_1_Y3X0_Header::
    db $ff, $01, $03, $0e, $0f, $33, $18, $00 ; entry 0

; LZSS-compressed: 131 bytes that expand to 360 (E-0016, E-0017)
KeyWorld30_1_Y3X0_Tiles::
    INCBIN "maps/key_worlds/30_1_y3_x0_tiles.lz"

; an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling
; a gap (E-0222)
KeyWorldScreenHeader_63_4985::
    db $07, $01, $05, $0b, $0e, $33, $19, $00 ; entry 0

; LZSS-compressed: 169 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_63_498D::
    INCBIN "maps/key_worlds/screen_63_498_d.lz"

; LZSS-compressed: 47 bytes that expand to 360 (E-0016, E-0017)
KeyWorld00_0_Y2X2_Attrs::
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0a, $05, $00, $00, $0f, $09, $00
    db $0a, $06, $00, $26, $0f, $09, $00, $30, $08, $00, $4e, $0f, $07, $00, $56, $0a
    db $00, $76, $0f, $03, $00, $9f, $0f, $4d, $00, $ff, $0f, $4d, $00, $0a, $04

; LZSS-compressed: 80 bytes that expand to 360 (E-0016, E-0017)
KeyWorld12_1_Y2X2_Attrs::
    INCBIN "maps/key_worlds/12_1_y2_x2_attrs.lz"

; LZSS-compressed: 64 bytes that expand to 360 (E-0016, E-0017)
KeyWorld15_1_Y2X2_Attrs::
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0a, $05, $00, $00, $0f, $4d, $00
    db $10, $06, $00, $1e, $06, $00, $74, $0f, $05, $01, $01, $02, $02, $00, $92, $0c
    db $00, $a0, $0f, $05, $00, $ca, $00, $00, $bc, $0f, $15, $00, $ca, $0a, $00, $f2
    db $0f, $01, $00, $f0, $06, $00, $e6, $0f, $01, $00, $a4, $0e, $00, $38, $1f, $0b

; LZSS-compressed: 48 bytes that expand to 360 (E-0016, E-0017)
KeyWorld10_0_Y2X2_Attrs::
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0a, $05, $00, $00, $0f, $09, $00
    db $0a, $06, $00, $26, $0f, $0b, $00, $08, $0f, $0f, $00, $12, $04, $00, $6e, $0f
    db $0b, $00, $0e, $06, $00, $96, $0f, $11, $00, $cd, $0f, $4d, $00, $08, $1f, $27

; LZSS-compressed: 75 bytes that expand to 360 (E-0016, E-0017)
KeyWorld30_3_Y1X1_Attrs::
    INCBIN "maps/key_worlds/30_3_y1_x1_attrs.lz"

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
KeyWorld31_1_Y2X2_Attrs::
    INCBIN "maps/key_worlds/31_1_y2_x2_attrs.lz"

; LZSS-compressed: 57 bytes that expand to 360 (E-0016, E-0017)
KeyWorld1E_0_Y2X2_Attrs::
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0a, $05, $00, $00, $0f, $33, $00
    db $08, $06, $00, $50, $0f, $0d, $00, $06, $04, $00, $78, $0f, $01, $00, $76, $0c
    db $00, $9c, $0f, $07, $00, $12, $02, $00, $c8, $08, $00, $c8, $0f, $0d, $00, $f8
    db $08, $00, $f4, $0f, $01, $00, $0c, $1f, $39

; LZSS-compressed: 47 bytes that expand to 360 (E-0016, E-0017)
KeyWorld30_1_Y3X0_Attrs::
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0a, $05, $00, $00, $0f, $33, $00
    db $08, $06, $00, $50, $0f, $03, $00, $10, $0e, $00, $78, $0f, $01, $00, $0c, $0c
    db $00, $9c, $0f, $0d, $00, $10, $04, $00, $c4, $0f, $39, $00, $14, $1f, $31

; LZSS-compressed: 76 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_63_4C1F::
    INCBIN "maps/key_worlds/screen_63_4_c1_f.lz"

; compressed BG tiles (2048 bytes, 128 tiles) of key-world kind 5: entry 5 of KeyWorldTilesetTable,
; decompressed to vTiles2 by RunWCC44Type_420D_Case00
; LZSS-compressed: 1285 bytes that expand to 2048 (E-0016, E-0017)
KeyWorldTiles5::
    INCBIN "maps/key_worlds/tiles5.lz"

; entry 5 of KeyWorldTilesetTable; RunWCC44Type_420D_Case00 copies these $40 bytes to
; wBGPaletteBuffer (E-0139, C1)
; record: one CGB palette: 4 BGR555 colours
KeyWorldPalettes5::
    dw $012f, $7fff, $2ab7, $0063 ; entry 0
    dw $0160, $3fbf, $03e2, $0000 ; entry 1
    dw $0142, $03ff, $034e, $0000 ; entry 2
    dw $318c, $5294, $03e2, $0000 ; entry 3
    dw $158f, $2ab7, $03e2, $0000 ; entry 4
    dw $0171, $3fbf, $03e2, $0000 ; entry 5
    dw $1415, $7fff, $03e2, $0000 ; entry 6
    dw $318c, $7fff, $5294, $0000 ; entry 7

; an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling
; a gap (E-0222)
; record: screen header
KeyWorldScreenHeader_63_51B0::
    db $05, $03, $04, $0a, $0d, $33, $3e, $00 ; entry 0

; LZSS-compressed: 113 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_63_51B8::
    INCBIN "maps/key_worlds/screen_63_51_b8.lz"

; the 8-byte header of the screen stream that follows (E-0222)
KeyWorldScreenHeader_63_5229::
KeyWorld39_1_Y2X1_Header::
    db $07, $03, $04, $0a, $0d, $33, $3f, $00 ; entry 0

KeyWorld39_1_Y2X1_Tiles::
    INCBIN "maps/key_worlds/39_1_y2_x1_tiles.lz"

KeyWorldScreenHeader_63_52A2::
KeyWorld30_2_Y1X3_Header::
    db $ff, $01, $04, $0d, $0f, $33, $40, $00 ; entry 0

; LZSS-compressed: 115 bytes that expand to 360 (E-0016, E-0017)
KeyWorld30_2_Y1X3_Tiles::
    INCBIN "maps/key_worlds/30_2_y1_x3_tiles.lz"

KeyWorldScreenHeader_63_531D::
KeyWorld32_0_Y3X3_Header::
    db $ff, $01, $04, $0a, $0f, $33, $41, $00 ; entry 0

; LZSS-compressed: 140 bytes that expand to 360 (E-0016, E-0017)
KeyWorld32_0_Y3X3_Tiles::
    INCBIN "maps/key_worlds/32_0_y3_x3_tiles.lz"

; record: screen header
KeyWorldScreenHeader_63_53B1::
KeyWorld31_1_Y2X1_Header::
    db $03, $04, $05, $08, $0c, $33, $42, $00 ; entry 0

; LZSS-compressed: 126 bytes that expand to 360 (E-0016, E-0017)
KeyWorld31_1_Y2X1_Tiles::
    INCBIN "maps/key_worlds/31_1_y2_x1_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
KeyWorldScreenHeader_63_5437::
KeyWorld3C_3_Y0X1_Header::
    db $05, $04, $08, $0a, $0d, $33, $43, $00 ; entry 0

; LZSS-compressed: 185 bytes that expand to 360 (E-0016, E-0017)
KeyWorld3C_3_Y0X1_Tiles::
    INCBIN "maps/key_worlds/3_c_3_y0_x1_tiles.lz"

KeyWorldScreenHeader_63_54F8::
KeyWorld30_3_Y1X0_Header::
    db $ff, $04, $05, $08, $0d, $33, $44, $00 ; entry 0

; LZSS-compressed: 122 bytes that expand to 360 (E-0016, E-0017)
KeyWorld30_3_Y1X0_Tiles::
    INCBIN "maps/key_worlds/30_3_y1_x0_tiles.lz"

; record: screen header
KeyWorldScreenHeader_63_557A::
KeyWorld23_0_Y2X2_Header::
    db $ff, $04, $08, $0b, $0d, $33, $45, $00 ; entry 0

; LZSS-compressed: 159 bytes that expand to 360 (E-0016, E-0017)
KeyWorld23_0_Y2X2_Tiles::
    INCBIN "maps/key_worlds/23_0_y2_x2_tiles.lz"

; an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling
; a gap (E-0222)
KeyWorldScreenHeader_63_5621::
    db $01, $03, $06, $08, $0d, $33, $46, $00 ; entry 0

; LZSS-compressed: 196 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_63_5629::
    INCBIN "maps/key_worlds/screen_63_5629.lz"

; LZSS-compressed: 31 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_63_56ED::
    db $68, $01, $00, $03, $00, $00, $0f, $4d, $00, $1e, $0f, $0a, $01, $00, $7e, $03
    db $00, $72, $0f, $07, $00, $7e, $04, $00, $a7, $0f, $4d, $00, $07, $1f, $4d

; LZSS-compressed: 56 bytes that expand to 360 (E-0016, E-0017)
KeyWorld39_1_Y2X1_Attrs::
    db $68, $01, $00, $03, $00, $00, $0f, $4d, $00, $40, $0f, $2c, $01, $00, $a0, $01
    db $02, $00, $a6, $03, $00, $a0, $02, $00, $a0, $0f, $03, $00, $a6, $04, $00, $a6
    db $08, $00, $ca, $0f, $01, $00, $c8, $0a, $00, $c2, $0f, $01, $00, $b0, $0f, $07
    db $00, $a2, $0f, $05, $00, $3a, $1f, $0f

; LZSS-compressed: 37 bytes that expand to 360 (E-0016, E-0017)
KeyWorld30_2_Y1X3_Attrs::
    db $68, $01, $00, $03, $00, $00, $0f, $4d, $00, $40, $0f, $2c, $01, $01, $01, $01
    db $00, $94, $0c, $00, $a0, $0f, $2d, $00, $a2, $06, $00, $ec, $06, $00, $f4, $0f
    db $03, $00, $12, $1f, $37

; LZSS-compressed: 67 bytes that expand to 360 (E-0016, E-0017)
KeyWorld32_0_Y3X3_Attrs::
    INCBIN "maps/key_worlds/32_0_y3_x3_attrs.lz"

KeyWorld31_1_Y2X1_Attrs::
    db $68, $01, $00, $03, $00, $00, $0f, $18, $01, $00, $2c, $07, $00, $24, $0f, $07
    db $00, $2c, $08, $00, $34, $04, $00, $52, $0f, $27, $00, $52, $0c, $00, $af, $0f
    db $4d, $00, $08, $1f, $45

; LZSS-compressed: 81 bytes that expand to 360 (E-0016, E-0017)
KeyWorld3C_3_Y0X1_Attrs::
    INCBIN "maps/key_worlds/3_c_3_y0_x1_attrs.lz"

; LZSS-compressed: 51 bytes that expand to 360 (E-0016, E-0017)
KeyWorld30_3_Y1X0_Attrs::
    db $68, $01, $00, $03, $00, $00, $0f, $1a, $01, $00, $2e, $01, $00, $20, $0f, $0d
    db $00, $2e, $0f, $13, $00, $2c, $0f, $13, $00, $2e, $02, $00, $30, $06, $00, $a0
    db $06, $00, $a6, $0f, $05, $00, $32, $02, $00, $c4, $0f, $11, $00, $fb, $0f, $4d
    db $00, $b0, $08

; LZSS-compressed: 85 bytes that expand to 360 (E-0016, E-0017)
KeyWorld23_0_Y2X2_Attrs::
    INCBIN "maps/key_worlds/23_0_y2_x2_attrs.lz"

; LZSS-compressed: 93 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_63_58AA::
    INCBIN "maps/key_worlds/screen_63_58_aa.lz"

; compressed BG tiles (2048 bytes, 128 tiles) of key-world kind 9: entry 9 of KeyWorldTilesetTable,
; decompressed to vTiles2 by RunWCC44Type_420D_Case00
; LZSS-compressed: 1190 bytes that expand to 2048 (E-0016, E-0017)
KeyWorldTiles9::
    INCBIN "maps/key_worlds/tiles9.lz"

; entry 9 of KeyWorldTilesetTable; RunWCC44Type_420D_Case00 copies these $40 bytes to
; wBGPaletteBuffer (E-0139, C1)
; record: one CGB palette: 4 BGR555 colours
KeyWorldPalettes9::
    dw $7da0, $7fff, $7fe0, $0063 ; entry 0
    dw $0160, $3fbf, $03e2, $0000 ; entry 1
    dw $012f, $3fbf, $03e2, $0000 ; entry 2
    dw $318c, $7fff, $03e2, $0000 ; entry 3
    dw $0160, $3fbf, $03e2, $0000 ; entry 4
    dw $0171, $3fbf, $03e2, $0000 ; entry 5
    dw $1415, $7fff, $03e2, $0000 ; entry 6
    dw $318c, $7fff, $5294, $0000 ; entry 7

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_63_5DED::
KeyWorld30_2_Y0X2_Header::
    db $01, $02, $04, $07, $0c, $33, $62, $00 ; entry 0

; LZSS-compressed: 98 bytes that expand to 360 (E-0016, E-0017)
KeyWorld30_2_Y0X2_Tiles::
    INCBIN "maps/key_worlds/30_2_y0_x2_tiles.lz"

KeyWorldScreenHeader_63_5E57::
KeyWorld41_2_Y1X1_Header::
    db $ff, $02, $04, $05, $07, $33, $63, $00 ; entry 0

; LZSS-compressed: 80 bytes that expand to 360 (E-0016, E-0017)
KeyWorld41_2_Y1X1_Tiles::
    INCBIN "maps/key_worlds/41_2_y1_x1_tiles.lz"

KeyWorldScreenHeader_63_5EAF::
KeyWorld3F_3_Y0X0_Header::
    db $ff, $00, $01, $02, $04, $33, $64, $00 ; entry 0

; LZSS-compressed: 89 bytes that expand to 360 (E-0016, E-0017)
KeyWorld3F_3_Y0X0_Tiles::
    INCBIN "maps/key_worlds/3_f_3_y0_x0_tiles.lz"

; an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling
; a gap (E-0222)
; record: screen header
KeyWorldScreenHeader_63_5F10::
    db $ff, $00, $01, $02, $07, $33, $65, $00 ; entry 0

; LZSS-compressed: 129 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_63_5F18::
    INCBIN "maps/key_worlds/screen_63_5_f18.lz"

; the 8-byte header of the screen stream that follows (E-0222)
KeyWorldScreenHeader_63_5F99::
KeyWorld12_1_Y1X1_Header::
    db $05, $02, $06, $0c, $0d, $33, $66, $00 ; entry 0

; LZSS-compressed: 166 bytes that expand to 360 (E-0016, E-0017)
KeyWorld12_1_Y1X1_Tiles::
    INCBIN "maps/key_worlds/12_1_y1_x1_tiles.lz"

KeyWorldScreenHeader_63_6047::
KeyWorld34_1_Y2X1_Header::
    db $00, $04, $06, $09, $0c, $33, $67, $00 ; entry 0

; LZSS-compressed: 139 bytes that expand to 360 (E-0016, E-0017)
KeyWorld34_1_Y2X1_Tiles::
    INCBIN "maps/key_worlds/34_1_y2_x1_tiles.lz"

; record: screen header
KeyWorldScreenHeader_63_60DA::
KeyWorld40_2_Y2X2_Header::
    db $00, $02, $03, $06, $0f, $33, $68, $00 ; entry 0

; LZSS-compressed: 102 bytes that expand to 360 (E-0016, E-0017)
KeyWorld40_2_Y2X2_Tiles::
    INCBIN "maps/key_worlds/40_2_y2_x2_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
KeyWorldScreenHeader_63_6148::
KeyWorld12_1_Y0X1_Header::
    db $ff, $03, $08, $09, $0b, $33, $69, $00 ; entry 0

; LZSS-compressed: 114 bytes that expand to 360 (E-0016, E-0017)
KeyWorld12_1_Y0X1_Tiles::
    INCBIN "maps/key_worlds/12_1_y0_x1_tiles.lz"

; an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling
; a gap (E-0222)
; record: screen header
KeyWorldScreenHeader_63_61C2::
    db $01, $03, $05, $0a, $0b, $33, $6a, $00 ; entry 0

; LZSS-compressed: 206 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_63_61CA::
    INCBIN "maps/key_worlds/screen_63_61_ca.lz"

; LZSS-compressed: 43 bytes that expand to 360 (E-0016, E-0017)
KeyWorld30_2_Y0X2_Attrs::
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0a, $05, $00, $00, $0f, $4d, $00
    db $10, $0a, $00, $1a, $06, $00, $78, $0f, $0f, $00, $1c, $02, $00, $a0, $0f, $0f
    db $00, $72, $0f, $11, $00, $1e, $0f, $4d, $00, $f6, $0a

; LZSS-compressed: 27 bytes that expand to 360 (E-0016, E-0017)
KeyWorld41_2_Y1X1_Attrs::
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0a, $05, $00, $00, $0f, $4d, $00
    db $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $21

; LZSS-compressed: 37 bytes that expand to 360 (E-0016, E-0017)
KeyWorld3F_3_Y0X0_Attrs::
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0a, $05, $00, $00, $0f, $2d, $00
    db $0a, $06, $00, $4a, $0f, $4d, $00, $82, $0f, $23, $00, $8e, $0c, $00, $f0, $0f
    db $07, $00, $06, $0f, $37

; LZSS-compressed: 56 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_63_6303::
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0a, $05, $00, $00, $0f, $31, $00
    db $0a, $06, $00, $4e, $0f, $09, $02, $02, $00, $6c, $0f, $11, $00, $7e, $0a, $00
    db $9e, $0f, $31, $00, $f4, $00, $00, $e6, $0f, $0f, $00, $7c, $00, $00, $08, $0e
    db $00, $1e, $1f, $01, $00, $06, $0f, $0f

; LZSS-compressed: 72 bytes that expand to 360 (E-0016, E-0017)
KeyWorld12_1_Y1X1_Attrs::
    INCBIN "maps/key_worlds/12_1_y1_x1_attrs.lz"

; LZSS-compressed: 76 bytes that expand to 360 (E-0016, E-0017)
KeyWorld34_1_Y2X1_Attrs::
    INCBIN "maps/key_worlds/34_1_y2_x1_attrs.lz"

; LZSS-compressed: 47 bytes that expand to 360 (E-0016, E-0017)
KeyWorld40_2_Y2X2_Attrs::
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0a, $05, $00, $00, $0f, $2f, $00
    db $0a, $06, $00, $4c, $0f, $33, $00, $04, $0a, $00, $a0, $0f, $0d, $00, $06, $04
    db $00, $c8, $0f, $11, $00, $08, $00, $00, $f0, $0f, $0b, $00, $0a, $0f, $33

; LZSS-compressed: 70 bytes that expand to 360 (E-0016, E-0017)
KeyWorld12_1_Y0X1_Attrs::
    INCBIN "maps/key_worlds/12_1_y0_x1_attrs.lz"

; LZSS-compressed: 89 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_63_6444::
    INCBIN "maps/key_worlds/screen_63_6444.lz"

; an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling
; a gap (E-0222)
; record: screen header
KeyWorldScreenHeader_63_649D::
    db $03, $03, $06, $07, $09, $33, $86, $00 ; entry 0

; LZSS-compressed: 78 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_63_64A5::
    INCBIN "maps/key_worlds/screen_63_64_a5.lz"

; the 8-byte header of the screen stream that follows (E-0222)
KeyWorldScreenHeader_63_64F3::
KeyWorld42_3_Y0X0_Header::
    db $ff, $ff, $ff, $ff, $ff, $33, $87, $00 ; entry 0

; LZSS-compressed: 83 bytes that expand to 360 (E-0016, E-0017)
KeyWorld42_3_Y0X0_Tiles::
    INCBIN "maps/key_worlds/42_3_y0_x0_tiles.lz"

; an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling
; a gap (E-0222)
; record: screen header
KeyWorldScreenHeader_63_654E::
    db $ff, $03, $04, $05, $06, $33, $88, $00 ; entry 0

; LZSS-compressed: 104 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_63_6556::
    INCBIN "maps/key_worlds/screen_63_6556.lz"

; the 8-byte header of the screen stream that follows (E-0222)
KeyWorldScreenHeader_63_65BE::
KeyWorld34_2_Y1X3_Header::
    db $01, $03, $06, $07, $09, $33, $89, $00 ; entry 0

; LZSS-compressed: 112 bytes that expand to 360 (E-0016, E-0017)
KeyWorld34_2_Y1X3_Tiles::
    INCBIN "maps/key_worlds/34_2_y1_x3_tiles.lz"

KeyWorldScreenHeader_63_6636::
KeyWorld3C_2_Y0X3_Header::
    db $05, $05, $06, $08, $0b, $33, $8a, $00 ; entry 0

; LZSS-compressed: 113 bytes that expand to 360 (E-0016, E-0017)
KeyWorld3C_2_Y0X3_Tiles::
    INCBIN "maps/key_worlds/3_c_2_y0_x3_tiles.lz"

; record: screen header
KeyWorldScreenHeader_63_66AF::
KeyWorld40_2_Y3X3_Header::
    db $01, $04, $09, $0b, $0d, $33, $8b, $00 ; entry 0

; LZSS-compressed: 141 bytes that expand to 360 (E-0016, E-0017)
KeyWorld40_2_Y3X3_Tiles::
    INCBIN "maps/key_worlds/40_2_y3_x3_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
KeyWorldScreenHeader_63_6744::
KeyWorld40_5_Y1X0_Header::
    db $ff, $02, $04, $0a, $0c, $33, $8c, $00 ; entry 0

; LZSS-compressed: 143 bytes that expand to 360 (E-0016, E-0017)
KeyWorld40_5_Y1X0_Tiles::
    INCBIN "maps/key_worlds/40_5_y1_x0_tiles.lz"

KeyWorldScreenHeader_63_67DB::
KeyWorld3F_3_Y1X1_Header::
    db $ff, $02, $05, $0b, $0d, $33, $8d, $00 ; entry 0

; LZSS-compressed: 136 bytes that expand to 360 (E-0016, E-0017)
KeyWorld3F_3_Y1X1_Tiles::
    INCBIN "maps/key_worlds/3_f_3_y1_x1_tiles.lz"

; an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling
; a gap (E-0222)
; record: screen header
KeyWorldScreenHeader_63_686B::
    db $01, $04, $09, $02, $0c, $33, $8e, $00 ; entry 0

; LZSS-compressed: 184 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_63_6873::
    INCBIN "maps/key_worlds/screen_63_6873.lz"

; LZSS-compressed: 34 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_63_692B::
    db $68, $01, $00, $03, $00, $00, $0f, $4d, $00, $1e, $0f, $0a, $01, $00, $7e, $03
    db $00, $72, $0f, $07, $00, $7e, $04, $00, $94, $0f, $3f, $00, $74, $0e, $00, $f8
    db $0f, $49

; LZSS-compressed: 48 bytes that expand to 360 (E-0016, E-0017)
KeyWorld42_3_Y0X0_Attrs::
    db $68, $01, $00, $03, $00, $00, $0f, $4d, $00, $40, $0f, $2c, $01, $01, $02, $02
    db $00, $90, $0f, $15, $00, $a2, $0c, $00, $c8, $0f, $07, $00, $a2, $0a, $00, $f0
    db $0f, $09, $00, $a2, $08, $00, $18, $1f, $03, $00, $40, $14, $00, $36, $1f, $0b

; LZSS-compressed: 43 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_63_697D::
    db $68, $01, $00, $03, $00, $00, $0f, $42, $01, $01, $00, $44, $0f, $0f, $01, $00
    db $7a, $01, $00, $6c, $0f, $0d, $00, $7a, $02, $00, $7c, $0a, $00, $a0, $0f, $0b
    db $00, $56, $06, $00, $c8, $0f, $4d, $00, $9c, $0f, $19

; LZSS-compressed: 56 bytes that expand to 360 (E-0016, E-0017)
KeyWorld34_2_Y1X3_Attrs::
    db $68, $01, $00, $03, $00, $00, $0f, $4d, $00, $20, $0f, $0c, $02, $02, $02, $02
    db $00, $70, $0f, $09, $01, $00, $a0, $01, $00, $80, $00, $00, $80, $06, $00, $a0
    db $0f, $07, $00, $a4, $02, $00, $98, $0a, $00, $ce, $0f, $03, $01, $01, $00, $20
    db $06, $00, $f0, $0f, $4d, $00, $20, $00

; LZSS-compressed: 49 bytes that expand to 360 (E-0016, E-0017)
KeyWorld3C_2_Y0X3_Attrs::
    db $68, $01, $00, $03, $00, $00, $0f, $1c, $01, $00, $30, $01, $00, $22, $0f, $15
    db $00, $34, $0a, $00, $58, $0c, $00, $58, $04, $00, $70, $0f, $09, $00, $7c, $08
    db $00, $34, $04, $00, $a0, $0f, $4d, $00, $78, $0a, $00, $4e, $0e, $00, $20, $1f
    db $21

; LZSS-compressed: 80 bytes that expand to 360 (E-0016, E-0017)
KeyWorld40_2_Y3X3_Attrs::
    INCBIN "maps/key_worlds/40_2_y3_x3_attrs.lz"

; LZSS-compressed: 63 bytes that expand to 360 (E-0016, E-0017)
KeyWorld40_5_Y1X0_Attrs::
    db $68, $01, $00, $03, $00, $00, $0f, $18, $01, $01, $00, $1a, $0f, $3d, $00, $2c
    db $06, $00, $2c, $04, $00, $7c, $0c, $00, $7c, $00, $00, $7c, $06, $00, $7c, $02
    db $00, $a0, $0f, $0d, $00, $a2, $04, $00, $c8, $0f, $09, $00, $c8, $0e, $00, $f6
    db $0f, $09, $00, $76, $06, $00, $1c, $1f, $07, $00, $72, $0a, $00, $44, $1c

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
KeyWorld3F_3_Y1X1_Attrs::
    INCBIN "maps/key_worlds/3_f_3_y1_x1_attrs.lz"

; LZSS-compressed: 92 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_63_6AE7::
    INCBIN "maps/key_worlds/screen_63_6_ae7.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_63_6B43::
KeyWorld20_1_Y1X0_Header::
    db $06, $03, $08, $0b, $0d, $02, $aa, $00 ; entry 0

; LZSS-compressed: 130 bytes that expand to 360 (E-0016, E-0017)
KeyWorld20_1_Y1X0_Tiles::
    INCBIN "maps/key_worlds/20_1_y1_x0_tiles.lz"

KeyWorldScreenHeader_63_6BCD::
KeyWorld08_0_Y1X1_Header::
    db $07, $03, $08, $0b, $0d, $02, $ab, $00 ; entry 0

; LZSS-compressed: 164 bytes that expand to 360 (E-0016, E-0017)
KeyWorld08_0_Y1X1_Tiles::
    INCBIN "maps/key_worlds/08_0_y1_x1_tiles.lz"

KeyWorldScreenHeader_63_6C79::
KeyWorld13_0_Y2X1_Header::
    db $05, $05, $08, $0b, $0d, $2f, $ac, $00 ; entry 0

; LZSS-compressed: 138 bytes that expand to 360 (E-0016, E-0017)
KeyWorld13_0_Y2X1_Tiles::
    INCBIN "maps/key_worlds/13_0_y2_x1_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_63_6D0B::
KeyWorld08_0_Y2X2_Header::
    db $00, $03, $08, $0b, $0d, $2f, $ad, $00 ; entry 0

; LZSS-compressed: 160 bytes that expand to 360 (E-0016, E-0017)
KeyWorld08_0_Y2X2_Tiles::
    INCBIN "maps/key_worlds/08_0_y2_x2_tiles.lz"

KeyWorldScreenHeader_63_6DB3::
KeyWorld27_0_Y1X3_Header::
    db $03, $03, $08, $0b, $0d, $02, $ae, $00 ; entry 0

; LZSS-compressed: 147 bytes that expand to 360 (E-0016, E-0017)
KeyWorld27_0_Y1X3_Tiles::
    INCBIN "maps/key_worlds/27_0_y1_x3_tiles.lz"

KeyWorldScreenHeader_63_6E4E::
KeyWorld10_0_Y3X1_Header::
    db $00, $03, $08, $0b, $0d, $02, $af, $00 ; entry 0

; LZSS-compressed: 169 bytes that expand to 360 (E-0016, E-0017)
KeyWorld10_0_Y3X1_Tiles::
    INCBIN "maps/key_worlds/10_0_y3_x1_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_63_6EFF::
KeyWorld14_1_Y1X1_Header::
    db $ff, $02, $0b, $0d, $0f, $02, $b0, $00 ; entry 0

; LZSS-compressed: 185 bytes that expand to 360 (E-0016, E-0017)
KeyWorld14_1_Y1X1_Tiles::
    INCBIN "maps/key_worlds/14_1_y1_x1_tiles.lz"

KeyWorldScreenHeader_63_6FC0::
KeyWorld16_1_Y1X1_Header::
    db $ff, $03, $08, $0b, $0d, $02, $b1, $00 ; entry 0

; LZSS-compressed: 171 bytes that expand to 360 (E-0016, E-0017)
KeyWorld16_1_Y1X1_Tiles::
    INCBIN "maps/key_worlds/16_1_y1_x1_tiles.lz"

KeyWorldScreenHeader_63_7073::
KeyWorld07_0_Y1X2_Header::
    db $06, $02, $06, $09, $0d, $02, $b2, $00 ; entry 0

; LZSS-compressed: 214 bytes that expand to 360 (E-0016, E-0017)
KeyWorld07_0_Y1X2_Tiles::
    INCBIN "maps/key_worlds/07_0_y1_x2_tiles.lz"

; LZSS-compressed: 48 bytes that expand to 360 (E-0016, E-0017)
KeyWorld20_1_Y1X0_Attrs::
    db $68, $01, $02, $01, $02, $00, $0f, $4d, $02, $40, $0f, $2c, $02, $fe, $ff, $01
    db $02, $a0, $0f, $03, $02, $fe, $fe, $02, $c8, $0f, $05, $02, $fe, $fc, $02, $f0
    db $0f, $07, $02, $fe, $fa, $02, $18, $1f, $09, $02, $fe, $f8, $02, $40, $1f, $01

; LZSS-compressed: 83 bytes that expand to 360 (E-0016, E-0017)
KeyWorld08_0_Y1X1_Attrs::
    INCBIN "maps/key_worlds/08_0_y1_x1_attrs.lz"

; LZSS-compressed: 31 bytes that expand to 360 (E-0016, E-0017)
KeyWorld13_0_Y2X1_Attrs::
    db $68, $01, $02, $01, $02, $00, $0f, $4d, $02, $40, $0f, $2c, $02, $f8, $ff, $01
    db $02, $a0, $0f, $09, $02, $fe, $f8, $02, $c8, $0f, $4d, $02, $00, $1f, $19

; LZSS-compressed: 56 bytes that expand to 360 (E-0016, E-0017)
KeyWorld08_0_Y2X2_Attrs::
    db $68, $01, $03, $01, $03, $00, $0f, $1c, $02, $03, $30, $01, $03, $22, $0f, $0b
    db $03, $30, $02, $03, $30, $0a, $03, $54, $0e, $03, $58, $0c, $03, $76, $0f, $03
    db $03, $fc, $f0, $03, $34, $0c, $03, $a0, $0f, $05, $03, $fc, $fc, $03, $c8, $0f
    db $31, $03, $fe, $f8, $03, $18, $1f, $29

; LZSS-compressed: 37 bytes that expand to 360 (E-0016, E-0017)
KeyWorld27_0_Y1X3_Attrs::
    db $68, $01, $02, $01, $02, $00, $0f, $4d, $02, $40, $0f, $2c, $02, $fe, $ff, $01
    db $02, $a0, $0f, $4d, $02, $b0, $02, $02, $fe, $fe, $02, $18, $1f, $05, $02, $fa
    db $fc, $02, $40, $1f, $01

; LZSS-compressed: 74 bytes that expand to 360 (E-0016, E-0017)
KeyWorld10_0_Y3X1_Attrs::
    INCBIN "maps/key_worlds/10_0_y3_x1_attrs.lz"

; LZSS-compressed: 47 bytes that expand to 360 (E-0016, E-0017)
KeyWorld14_1_Y1X1_Attrs::
    db $68, $01, $02, $01, $02, $00, $0f, $44, $02, $fc, $ff, $01, $02, $fc, $fe, $02
    db $f6, $ff, $01, $02, $f6, $fa, $02, $fe, $f0, $02, $f4, $fc, $02, $a0, $0f, $03
    db $02, $f8, $f6, $02, $c0, $0f, $15, $02, $76, $0f, $17, $02, $12, $1f, $2f

; LZSS-compressed: 61 bytes that expand to 360 (E-0016, E-0017)
KeyWorld16_1_Y1X1_Attrs::
    db $68, $01, $03, $01, $03, $00, $0f, $4d, $03, $20, $0f, $0c, $02, $02, $02, $02
    db $03, $70, $0f, $09, $03, $fe, $f2, $03, $fa, $f2, $03, $80, $04, $03, $a0, $0f
    db $03, $03, $f4, $f8, $03, $c2, $0f, $15, $03, $9a, $04, $03, $f2, $0f, $05, $03
    db $20, $0a, $03, $18, $1f, $07, $03, $fc, $fa, $03, $40, $1f, $01

; LZSS-compressed: 86 bytes that expand to 360 (E-0016, E-0017)
KeyWorld07_0_Y1X2_Attrs::
    INCBIN "maps/key_worlds/07_0_y1_x2_attrs.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_63_735C::
KeyWorld19_1_Y2X2_Header::
    db $03, $04, $06, $09, $0b, $06, $ce, $00 ; entry 0

; LZSS-compressed: 148 bytes that expand to 360 (E-0016, E-0017)
KeyWorld19_1_Y2X2_Tiles::
    INCBIN "maps/key_worlds/19_1_y2_x2_tiles.lz"

KeyWorldScreenHeader_63_73F8::
KeyWorld3E_1_Y3X0_Header::
    db $01, $04, $06, $09, $0b, $06, $cf, $00 ; entry 0

; LZSS-compressed: 164 bytes that expand to 360 (E-0016, E-0017)
KeyWorld3E_1_Y3X0_Tiles::
    INCBIN "maps/key_worlds/3_e_1_y3_x0_tiles.lz"

KeyWorldScreenHeader_63_74A4::
KeyWorld0D_0_Y1X2_Header::
    db $03, $04, $06, $09, $0b, $06, $d0, $00 ; entry 0

; LZSS-compressed: 153 bytes that expand to 360 (E-0016, E-0017)
KeyWorld0D_0_Y1X2_Tiles::
    INCBIN "maps/key_worlds/0_d_0_y1_x2_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_63_7545::
KeyWorld0B_0_Y2X2_Header::
    db $01, $04, $06, $09, $0b, $06, $d1, $00 ; entry 0

; LZSS-compressed: 217 bytes that expand to 360 (E-0016, E-0017)
KeyWorld0B_0_Y2X2_Tiles::
    INCBIN "maps/key_worlds/0_b_0_y2_x2_tiles.lz"

KeyWorldScreenHeader_63_7626::
KeyWorld1A_0_Y3X2_Header::
    db $05, $04, $06, $09, $0b, $06, $d2, $00 ; entry 0

; LZSS-compressed: 157 bytes that expand to 360 (E-0016, E-0017)
KeyWorld1A_0_Y3X2_Tiles::
    INCBIN "maps/key_worlds/1_a_0_y3_x2_tiles.lz"

KeyWorldScreenHeader_63_76CB::
KeyWorld0E_0_Y1X1_Header::
    db $04, $02, $07, $0b, $0f, $06, $d3, $00 ; entry 0

; LZSS-compressed: 192 bytes that expand to 360 (E-0016, E-0017)
KeyWorld0E_0_Y1X1_Tiles::
    INCBIN "maps/key_worlds/0_e_0_y1_x1_tiles.lz"

; the 8-byte header of the screen stream that follows (E-0222)
; record: screen header
KeyWorldScreenHeader_63_7793::
KeyWorld1B_1_Y1X1_Header::
    db $ff, $02, $03, $04, $0b, $06, $d4, $00 ; entry 0

; LZSS-compressed: 194 bytes that expand to 360 (E-0016, E-0017)
KeyWorld1B_1_Y1X1_Tiles::
    INCBIN "maps/key_worlds/1_b_1_y1_x1_tiles.lz"

KeyWorldScreenHeader_63_785D::
KeyWorld1C_0_Y1X2_Header::
    db $ff, $00, $04, $0c, $0f, $06, $d5, $00 ; entry 0

; LZSS-compressed: 237 bytes that expand to 360 (E-0016, E-0017)
KeyWorld1C_0_Y1X2_Tiles::
    INCBIN "maps/key_worlds/1_c_0_y1_x2_tiles.lz"

KeyWorldScreenHeader_63_7952::
KeyWorld1A_0_Y1X1_Header::
    db $01, $03, $06, $09, $0f, $06, $d6, $00 ; entry 0

; LZSS-compressed: 242 bytes that expand to 360 (E-0016, E-0017)
KeyWorld1A_0_Y1X1_Tiles::
    INCBIN "maps/key_worlds/1_a_0_y1_x1_tiles.lz"

; LZSS-compressed: 61 bytes that expand to 360 (E-0016, E-0017)
KeyWorld19_1_Y2X2_Attrs::
    db $68, $01, $02, $02, $ff, $f6, $01, $02, $0a, $05, $02, $00, $0f, $07, $02, $0a
    db $06, $02, $24, $0f, $09, $02, $2e, $0a, $02, $4e, $0f, $05, $02, $54, $0c, $02
    db $76, $0f, $03, $02, $7a, $0f, $13, $02, $52, $0f, $15, $02, $2c, $0f, $15, $02
    db $2c, $0a, $02, $02, $0e, $02, $22, $1f, $01, $02, $00, $0f, $0b

; LZSS-compressed: 85 bytes that expand to 360 (E-0016, E-0017)
KeyWorld3E_1_Y3X0_Attrs::
    INCBIN "maps/key_worlds/3_e_1_y3_x0_attrs.lz"

; LZSS-compressed: 39 bytes that expand to 360 (E-0016, E-0017)
KeyWorld0D_0_Y1X2_Attrs::
    db $68, $01, $02, $02, $ff, $f6, $01, $02, $0a, $05, $02, $00, $0f, $4d, $02, $10
    db $08, $02, $1e, $06, $02, $76, $0f, $03, $02, $80, $0f, $0d, $02, $ac, $0f, $27
    db $02, $14, $0f, $4d, $02, $f6, $0a

; LZSS-compressed: 74 bytes that expand to 360 (E-0016, E-0017)
KeyWorld0B_0_Y2X2_Attrs::
    INCBIN "maps/key_worlds/0_b_0_y2_x2_attrs.lz"

; LZSS-compressed: 44 bytes that expand to 360 (E-0016, E-0017)
KeyWorld1A_0_Y3X2_Attrs::
    db $68, $01, $02, $02, $ff, $f6, $01, $02, $0a, $05, $02, $00, $0f, $03, $02, $0a
    db $06, $02, $20, $0f, $4d, $02, $8e, $0f, $0b, $02, $3c, $0f, $4d, $02, $c2, $0f
    db $03, $02, $06, $0a, $02, $22, $1f, $01, $02, $00, $0f, $0b

; LZSS-compressed: 87 bytes that expand to 360 (E-0016, E-0017)
KeyWorld0E_0_Y1X1_Attrs::
    INCBIN "maps/key_worlds/0_e_0_y1_x1_attrs.lz"

; LZSS-compressed: 64 bytes that expand to 360 (E-0016, E-0017)
KeyWorld1B_1_Y1X1_Attrs::
    db $68, $01, $02, $02, $ff, $f6, $01, $02, $0a, $05, $02, $00, $0f, $05, $02, $0a
    db $06, $02, $22, $0f, $09, $02, $20, $0e, $02, $50, $0f, $09, $02, $04, $08, $02
    db $78, $0f, $01, $02, $0e, $0e, $02, $78, $0a, $02, $ac, $0f, $05, $02, $5a, $08
    db $02, $fe, $ff, $01, $02, $e4, $0f, $15, $02, $12, $0f, $07, $02, $12, $1f, $1b

; LZSS-compressed: 78 bytes that expand to 360 (E-0016, E-0017)
KeyWorld1C_0_Y1X2_Attrs::
    INCBIN "maps/key_worlds/1_c_0_y1_x2_attrs.lz"

; LZSS-compressed: 100 bytes that expand to 360 (E-0016, E-0017)
KeyWorld1A_0_Y1X1_Attrs::
    INCBIN "maps/key_worlds/1_a_0_y1_x1_attrs.lz"
    ds $33c, $00
