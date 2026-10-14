; ROM bank $4B: map screens, attributes and tilesets
; The annotated listing of this bank is build/listing/bank4b.asm.

SECTION "Bank 4B", ROMX[$4000], BANK[$4B]
    db $4b

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map26Screens0::
    dfar Map26Screens0_Y0X0 ; entry 0

Map26Attrs0::
    dfar Map26Attrs0_Y0X0 ; entry 0

Map26Screens1::
    dfar Map26Screens1_Y0X0 ; entry 0

Map26Attrs1::
    dfar Map26Attrs1_Y0X0 ; entry 0

; LZSS-compressed: 271 bytes that expand to 360 (E-0016, E-0017)
Map26Screens0_Y0X0::
    INCBIN "maps/map26/screens0_y0_x0.lz"

; LZSS-compressed: 199 bytes that expand to 360 (E-0016, E-0017)
Map26Screens1_Y0X0::
    INCBIN "maps/map26/screens1_y0_x0.lz"

; LZSS-compressed: 101 bytes that expand to 360 (E-0016, E-0017)
Map26Attrs0_Y0X0::
    INCBIN "maps/map26/attrs0_y0_x0.lz"

; LZSS-compressed: 74 bytes that expand to 360 (E-0016, E-0017)
Map26Attrs1_Y0X0::
    INCBIN "maps/map26/attrs1_y0_x0.lz"

; compressed tileset of map $28 (the first map record using it)
; LZSS-compressed: 877 bytes that expand to 1024 (E-0016, E-0017)
Map28Tileset::
    INCBIN "maps/map28/tileset.lz"

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map28Screens0::
    dfar Map28Screens0_Y0X0 ; entry 0
    dfar Map28Screens0_Y1X0 ; entry 1

Map28Attrs0::
    dfar Map28Attrs0_Y0X0 ; entry 0
    dfar Map28Attrs0_Y1X0 ; entry 1

; LZSS-compressed: 266 bytes that expand to 360 (E-0016, E-0017)
Map28Screens0_Y0X0::
    INCBIN "maps/map28/screens0_y0_x0.lz"

; LZSS-compressed: 252 bytes that expand to 360 (E-0016, E-0017)
Map28Screens0_Y1X0::
    INCBIN "maps/map28/screens0_y1_x0.lz"

; LZSS-compressed: 101 bytes that expand to 360 (E-0016, E-0017)
Map28Attrs0_Y0X0::
    INCBIN "maps/map28/attrs0_y0_x0.lz"

; LZSS-compressed: 102 bytes that expand to 360 (E-0016, E-0017)
Map28Attrs0_Y1X0::
    INCBIN "maps/map28/attrs0_y1_x0.lz"

; compressed tileset of map $2B (the first map record using it)
; LZSS-compressed: 1355 bytes that expand to 1792 (E-0016, E-0017)
Map2BTileset::
    INCBIN "maps/map2_b/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map2BPalettes::
    dw $7c01, $7fff, $6301, $0000 ; entry 0
    dw $1528, $2b3f, $15ae, $0000 ; entry 1
    dw $0188, $4fbf, $01d3, $0000 ; entry 2
    dw $012f, $2b3f, $01d8, $0000 ; entry 3
    dw $1528, $3695, $15ae, $0000 ; entry 4
    dw $001b, $2bff, $023f, $0000 ; entry 5
    dw $218c, $4f18, $3a52, $0ca5 ; entry 6
    dw $218c, $4f18, $3a52, $0ca5 ; entry 7

; 16 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map2BScreens0::
    dfar Map2BScreens0_Y0X0 ; entry 0
    dfar Map2BScreens0_Y0X0 ; entry 1
    dfar Map2BScreens0_Y0X0 ; entry 2
    dfar Map2BScreens0_Y0X0 ; entry 3
    dfar Map2BScreens0_Y1X0 ; entry 4
    dfar Map2BScreens0_Y1X1 ; entry 5
    dfar Map2BScreens0_Y1X2 ; entry 6
    dfar Map2BScreens0_Y0X0 ; entry 7
    dfar Map2BScreens0_Y2X0 ; entry 8
    dfar Map2BScreens0_Y2X1 ; entry 9
    dfar Map2BScreens0_Y2X2 ; entry 10
    dfar Map2BScreens0_Y0X0 ; entry 11
    dfar Map2BScreens0_Y3X0 ; entry 12
    dfar Map2BScreens0_Y3X1 ; entry 13
    dfar Map2BScreens0_Y3X2 ; entry 14
    dfar Map2BScreens0_Y3X3 ; entry 15

Map2BAttrs0::
    dfar Map2BAttrs0_Y0X0 ; entry 0
    dfar Map2BAttrs0_Y0X0 ; entry 1
    dfar Map2BAttrs0_Y0X0 ; entry 2
    dfar Map2BAttrs0_Y0X0 ; entry 3
    dfar Map2BAttrs0_Y1X0 ; entry 4
    dfar Map2BAttrs0_Y1X1 ; entry 5
    dfar Map2BAttrs0_Y1X2 ; entry 6
    dfar Map2BAttrs0_Y0X0 ; entry 7
    dfar Map2BAttrs0_Y2X0 ; entry 8
    dfar Map2BAttrs0_Y2X1 ; entry 9
    dfar Map2BAttrs0_Y2X2 ; entry 10
    dfar Map2BAttrs0_Y0X0 ; entry 11
    dfar Map2BAttrs0_Y3X0 ; entry 12
    dfar Map2BAttrs0_Y3X1 ; entry 13
    dfar Map2BAttrs0_Y3X2 ; entry 14
    dfar Map2BAttrs0_Y3X3 ; entry 15

Map2BScreens2::
    dfar Map2BScreens0_Y0X0 ; entry 0
    dfar Map2BScreens0_Y0X0 ; entry 1
    dfar Map2BScreens0_Y0X0 ; entry 2
    dfar Map2BScreens0_Y0X0 ; entry 3
    dfar Map2BScreens0_Y1X0 ; entry 4
    dfar Map2BScreens0_Y1X1 ; entry 5
    dfar Map2BScreens0_Y1X2 ; entry 6
    dfar Map2BScreens0_Y0X0 ; entry 7
    dfar Map2BScreens0_Y2X0 ; entry 8
    dfar Map2BScreens2_Y2X1 ; entry 9
    dfar Map2BScreens0_Y2X2 ; entry 10
    dfar Map2BScreens0_Y0X0 ; entry 11
    dfar Map2BScreens0_Y3X0 ; entry 12
    dfar Map2BScreens2_Y3X1 ; entry 13
    dfar Map2BScreens2_Y3X2 ; entry 14
    dfar Map2BScreens2_Y3X3 ; entry 15

Map2BAttrs2::
    dfar Map2BAttrs0_Y0X0 ; entry 0
    dfar Map2BAttrs0_Y0X0 ; entry 1
    dfar Map2BAttrs0_Y0X0 ; entry 2
    dfar Map2BAttrs0_Y0X0 ; entry 3
    dfar Map2BAttrs0_Y1X0 ; entry 4
    dfar Map2BAttrs0_Y1X1 ; entry 5
    dfar Map2BAttrs0_Y1X2 ; entry 6
    dfar Map2BAttrs0_Y0X0 ; entry 7
    dfar Map2BAttrs0_Y2X0 ; entry 8
    dfar Map2BAttrs2_Y2X1 ; entry 9
    dfar Map2BAttrs0_Y2X2 ; entry 10
    dfar Map2BAttrs0_Y0X0 ; entry 11
    dfar Map2BAttrs0_Y3X0 ; entry 12
    dfar Map2BAttrs2_Y3X1 ; entry 13
    dfar Map2BAttrs2_Y3X2 ; entry 14
    dfar Map2BAttrs2_Y3X3 ; entry 15

; LZSS-compressed: 169 bytes that expand to 360 (E-0016, E-0017)
Map2BScreens0_Y0X0::
    INCBIN "maps/map2_b/screens0_y0_x0.lz"

; LZSS-compressed: 201 bytes that expand to 360 (E-0016, E-0017)
Map2BScreens0_Y1X0::
    INCBIN "maps/map2_b/screens0_y1_x0.lz"

; LZSS-compressed: 179 bytes that expand to 360 (E-0016, E-0017)
Map2BScreens0_Y1X1::
    INCBIN "maps/map2_b/screens0_y1_x1.lz"

; LZSS-compressed: 166 bytes that expand to 360 (E-0016, E-0017)
Map2BScreens0_Y1X2::
    INCBIN "maps/map2_b/screens0_y1_x2.lz"

; LZSS-compressed: 196 bytes that expand to 360 (E-0016, E-0017)
Map2BScreens0_Y2X0::
    INCBIN "maps/map2_b/screens0_y2_x0.lz"

Map2BScreens0_Y2X1::
    INCBIN "maps/map2_b/screens0_y2_x1.lz"

; LZSS-compressed: 163 bytes that expand to 360 (E-0016, E-0017)
Map2BScreens2_Y2X1::
    INCBIN "maps/map2_b/screens2_y2_x1.lz"

; LZSS-compressed: 180 bytes that expand to 360 (E-0016, E-0017)
Map2BScreens0_Y2X2::
    INCBIN "maps/map2_b/screens0_y2_x2.lz"

; LZSS-compressed: 246 bytes that expand to 360 (E-0016, E-0017)
Map2BScreens0_Y3X0::
    INCBIN "maps/map2_b/screens0_y3_x0.lz"

; LZSS-compressed: 242 bytes that expand to 360 (E-0016, E-0017)
Map2BScreens0_Y3X1::
    INCBIN "maps/map2_b/screens0_y3_x1.lz"

; LZSS-compressed: 205 bytes that expand to 360 (E-0016, E-0017)
Map2BScreens2_Y3X1::
    INCBIN "maps/map2_b/screens2_y3_x1.lz"

; LZSS-compressed: 121 bytes that expand to 360 (E-0016, E-0017)
Map2BScreens0_Y3X2::
    INCBIN "maps/map2_b/screens0_y3_x2.lz"

; LZSS-compressed: 117 bytes that expand to 360 (E-0016, E-0017)
Map2BScreens2_Y3X2::
    INCBIN "maps/map2_b/screens2_y3_x2.lz"

; LZSS-compressed: 222 bytes that expand to 360 (E-0016, E-0017)
Map2BScreens0_Y3X3::
    INCBIN "maps/map2_b/screens0_y3_x3.lz"

; LZSS-compressed: 221 bytes that expand to 360 (E-0016, E-0017)
Map2BScreens2_Y3X3::
    INCBIN "maps/map2_b/screens2_y3_x3.lz"

; LZSS-compressed: 45 bytes that expand to 360 (E-0016, E-0017)
Map2BAttrs0_Y0X0::
    db $68, $01, $01, $02, $01, $00, $0f, $18, $04, $04, $01, $f6, $fe, $01, $2c, $0e
    db $04, $04, $01, $2c, $08, $04, $04, $01, $4e, $0f, $31, $01, $2c, $06, $01, $9c
    db $0f, $0d, $01, $2c, $04, $01, $c4, $0f, $4d, $01, $fc, $0f, $1d

; LZSS-compressed: 93 bytes that expand to 360 (E-0016, E-0017)
Map2BAttrs0_Y1X0::
    INCBIN "maps/map2_b/attrs0_y1_x0.lz"

; LZSS-compressed: 66 bytes that expand to 360 (E-0016, E-0017)
Map2BAttrs0_Y1X1::
    INCBIN "maps/map2_b/attrs0_y1_x1.lz"

; LZSS-compressed: 94 bytes that expand to 360 (E-0016, E-0017)
Map2BAttrs0_Y1X2::
    INCBIN "maps/map2_b/attrs0_y1_x2.lz"

; LZSS-compressed: 86 bytes that expand to 360 (E-0016, E-0017)
Map2BAttrs0_Y2X0::
    INCBIN "maps/map2_b/attrs0_y2_x0.lz"

; LZSS-compressed: 102 bytes that expand to 360 (E-0016, E-0017)
Map2BAttrs0_Y2X1::
    INCBIN "maps/map2_b/attrs0_y2_x1.lz"

; LZSS-compressed: 77 bytes that expand to 360 (E-0016, E-0017)
Map2BAttrs2_Y2X1::
    INCBIN "maps/map2_b/attrs2_y2_x1.lz"

; LZSS-compressed: 67 bytes that expand to 360 (E-0016, E-0017)
Map2BAttrs0_Y2X2::
    INCBIN "maps/map2_b/attrs0_y2_x2.lz"

; LZSS-compressed: 92 bytes that expand to 360 (E-0016, E-0017)
Map2BAttrs0_Y3X0::
    INCBIN "maps/map2_b/attrs0_y3_x0.lz"

; LZSS-compressed: 119 bytes that expand to 360 (E-0016, E-0017)
Map2BAttrs0_Y3X1::
    INCBIN "maps/map2_b/attrs0_y3_x1.lz"

; LZSS-compressed: 79 bytes that expand to 360 (E-0016, E-0017)
Map2BAttrs2_Y3X1::
    INCBIN "maps/map2_b/attrs2_y3_x1.lz"

; LZSS-compressed: 44 bytes that expand to 360 (E-0016, E-0017)
Map2BAttrs0_Y3X2::
    db $68, $01, $01, $01, $ff, $ff, $15, $02, $01, $28, $0f, $44, $04, $01, $80, $01
    db $01, $72, $0f, $07, $01, $20, $0a, $01, $1a, $0f, $01, $01, $ff, $f2, $01, $80
    db $02, $01, $cd, $0f, $4d, $01, $e0, $0e, $01, $28, $0f, $15

; LZSS-compressed: 41 bytes that expand to 360 (E-0016, E-0017)
Map2BAttrs2_Y3X2::
    db $68, $01, $01, $01, $ff, $ff, $15, $02, $01, $28, $0f, $3c, $01, $ff, $f4, $04
    db $01, $80, $01, $01, $ff, $fa, $01, $80, $0f, $01, $01, $e0, $ff, $35, $01, $80
    db $02, $01, $f0, $0f, $37, $01, $50, $0f, $15

; LZSS-compressed: 84 bytes that expand to 360 (E-0016, E-0017)
Map2BAttrs0_Y3X3::
    INCBIN "maps/map2_b/attrs0_y3_x3.lz"

; LZSS-compressed: 752 bytes that expand to 770 (E-0016, E-0017)
Gfx4B_1::
    db $02, $03, $f0, $0f, $0d, $03, $9c, $04, $03, $90, $0f, $05, $03, $30, $08, $03
    db $3c, $1f, $05

; LZSS-compressed: 81 bytes that expand to 360 (E-0016, E-0017)
Map2BAttrs2_Y3X3::
    INCBIN "maps/map2_b/attrs2_y3_x3.lz"

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map2EScreens0::
    dfar Map2EScreens0_Y0X0 ; entry 0

Map2EAttrs0::
    dfar Map2EAttrs0_Y0X0 ; entry 0

Map2EScreens3::
    dfar Map2EScreens3_Y0X0 ; entry 0

Map2EAttrs3::
    dfar Map2EAttrs3_Y0X0 ; entry 0

; LZSS-compressed: 189 bytes that expand to 360 (E-0016, E-0017)
Map2EScreens0_Y0X0::
    INCBIN "maps/map2_e/screens0_y0_x0.lz"

Map2EScreens3_Y0X0::
    INCBIN "maps/map2_e/screens3_y0_x0.lz"

; LZSS-compressed: 59 bytes that expand to 360 (E-0016, E-0017)
Map2EAttrs0_Y0X0::
    db $68, $01, $00, $01, $01, $01, $01, $03, $00, $04, $07, $00, $00, $00, $00, $00
    db $0f, $07, $05, $00, $2e, $03, $00, $22, $0f, $0f, $00, $00, $00, $00, $48, $0f
    db $0b, $00, $0a, $06, $00, $7a, $0f, $35, $00, $10, $04, $00, $c6, $06, $00, $ca
    db $0f, $4d, $00, $00, $0c, $00, $7c, $0a, $00, $06, $08

Map2EAttrs3_Y0X0::
    db $68, $01, $00, $01, $01, $01, $01, $03, $00, $04, $07, $00, $00, $00, $00, $00
    db $0f, $07, $05, $00, $2e, $03, $00, $22, $0f, $0f, $00, $00, $00, $00, $48, $0f
    db $0b, $00, $0a, $06, $00, $7a, $0f, $35, $00, $10, $04, $00, $c6, $06, $00, $ca
    db $0f, $4d, $00, $00, $0c, $00, $7c, $0a, $00, $06, $08

; 12 screen far pointers, row by row (E-0142)
Map39Screens0::
    dfar Map39Screens0_Y0X0 ; entry 0
    dfar Map39Screens0_Y0X1 ; entry 1
    dfar Map39Screens0_Y0X2 ; entry 2
    dfar Map39Screens0_Y0X3 ; entry 3
    dfar Map39Screens0_Y1X0 ; entry 4
    dfar Map39Screens0_Y1X1 ; entry 5
    dfar Map39Screens0_Y1X2 ; entry 6
    dfar Map39Screens0_Y1X3 ; entry 7
    dfar Map39Screens0_Y2X0 ; entry 8
    dfar Map39Screens0_Y2X1 ; entry 9
    dfar Map39Screens0_Y2X2 ; entry 10
    dfar Map39Screens0_Y2X3 ; entry 11

Map39Attrs0::
    dfar Map39Attrs0_Y0X0 ; entry 0
    dfar Map39Attrs0_Y0X1 ; entry 1
    dfar Map39Attrs0_Y0X2 ; entry 2
    dfar Map39Attrs0_Y0X3 ; entry 3
    dfar Map39Attrs0_Y1X0 ; entry 4
    dfar Map39Attrs0_Y1X1 ; entry 5
    dfar Map39Attrs0_Y1X2 ; entry 6
    dfar Map39Attrs0_Y1X3 ; entry 7
    dfar Map39Attrs0_Y2X0 ; entry 8
    dfar Map39Attrs0_Y2X1 ; entry 9
    dfar Map39Attrs0_Y2X2 ; entry 10
    dfar Map39Attrs0_Y2X3 ; entry 11

Map39Screens3::
    dfar Map39Screens0_Y0X0 ; entry 0
    dfar Map39Screens0_Y0X1 ; entry 1
    dfar Map39Screens0_Y0X2 ; entry 2
    dfar Map39Screens0_Y0X3 ; entry 3
    dfar Map39Screens0_Y1X0 ; entry 4
    dfar Map39Screens3_Y1X1 ; entry 5
    dfar Map39Screens0_Y1X2 ; entry 6
    dfar Map39Screens0_Y1X3 ; entry 7
    dfar Map39Screens0_Y2X0 ; entry 8
    dfar Map39Screens0_Y2X1 ; entry 9
    dfar Map39Screens0_Y2X2 ; entry 10
    dfar Map39Screens0_Y2X3 ; entry 11

Map39Attrs3::
    dfar Map39Attrs0_Y0X0 ; entry 0
    dfar Map39Attrs0_Y0X1 ; entry 1
    dfar Map39Attrs0_Y0X2 ; entry 2
    dfar Map39Attrs0_Y0X3 ; entry 3
    dfar Map39Attrs0_Y1X0 ; entry 4
    dfar Map39Attrs3_Y1X1 ; entry 5
    dfar Map39Attrs0_Y1X2 ; entry 6
    dfar Map39Attrs0_Y1X3 ; entry 7
    dfar Map39Attrs0_Y2X0 ; entry 8
    dfar Map39Attrs0_Y2X1 ; entry 9
    dfar Map39Attrs0_Y2X2 ; entry 10
    dfar Map39Attrs0_Y2X3 ; entry 11

; LZSS-compressed: 205 bytes that expand to 360 (E-0016, E-0017)
Map39Screens0_Y0X0::
    INCBIN "maps/map39/screens0_y0_x0.lz"

; LZSS-compressed: 89 bytes that expand to 360 (E-0016, E-0017)
Map39Screens0_Y0X1::
    INCBIN "maps/map39/screens0_y0_x1.lz"

; LZSS-compressed: 86 bytes that expand to 360 (E-0016, E-0017)
Map39Screens0_Y0X2::
    INCBIN "maps/map39/screens0_y0_x2.lz"

; LZSS-compressed: 179 bytes that expand to 360 (E-0016, E-0017)
Map39Screens0_Y0X3::
    INCBIN "maps/map39/screens0_y0_x3.lz"

; LZSS-compressed: 218 bytes that expand to 360 (E-0016, E-0017)
Map39Screens0_Y1X0::
    INCBIN "maps/map39/screens0_y1_x0.lz"

; LZSS-compressed: 186 bytes that expand to 360 (E-0016, E-0017)
Map39Screens0_Y1X1::
    INCBIN "maps/map39/screens0_y1_x1.lz"

; LZSS-compressed: 233 bytes that expand to 360 (E-0016, E-0017)
Map39Screens3_Y1X1::
    INCBIN "maps/map39/screens3_y1_x1.lz"

; LZSS-compressed: 210 bytes that expand to 360 (E-0016, E-0017)
Map39Screens0_Y1X2::
    INCBIN "maps/map39/screens0_y1_x2.lz"

; LZSS-compressed: 132 bytes that expand to 360 (E-0016, E-0017)
Map39Screens0_Y1X3::
    INCBIN "maps/map39/screens0_y1_x3.lz"

; LZSS-compressed: 101 bytes that expand to 360 (E-0016, E-0017)
Map39Screens0_Y2X0::
    INCBIN "maps/map39/screens0_y2_x0.lz"

; LZSS-compressed: 200 bytes that expand to 360 (E-0016, E-0017)
Map39Screens0_Y2X1::
    INCBIN "maps/map39/screens0_y2_x1.lz"

; LZSS-compressed: 19 bytes that expand to 360 (E-0016, E-0017)
Map39Screens0_Y2X2::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $5f, $0f, $4d, $01, $bf, $0f, $4d, $01
    db $1f, $1f, $35

; LZSS-compressed: 180 bytes that expand to 360 (E-0016, E-0017)
Map39Screens0_Y2X3::
    INCBIN "maps/map39/screens0_y2_x3.lz"

; LZSS-compressed: 64 bytes that expand to 360 (E-0016, E-0017)
Map39Attrs0_Y0X0::
    db $68, $01, $02, $02, $ff, $ff, $19, $01, $02, $2c, $07, $02, $24, $0f, $07, $02
    db $2c, $00, $03, $02, $56, $03, $02, $32, $04, $02, $52, $0f, $03, $02, $56, $04
    db $02, $56, $04, $02, $78, $0f, $4d, $02, $88, $04, $02, $54, $0f, $13, $02, $50
    db $06, $02, $34, $0c, $02, $20, $1c, $02, $8c, $04, $02, $3a, $18, $02, $44, $1c

; LZSS-compressed: 34 bytes that expand to 360 (E-0016, E-0017)
Map39Attrs0_Y0X1::
    db $68, $01, $02, $02, $ff, $ff, $3d, $01, $02, $50, $05, $02, $46, $0f, $0b, $03
    db $02, $78, $03, $02, $6c, $0f, $4d, $02, $90, $0c, $02, $50, $0f, $15, $02, $17
    db $1f, $3d

; LZSS-compressed: 31 bytes that expand to 360 (E-0016, E-0017)
Map39Attrs0_Y0X2::
    db $68, $01, $02, $02, $ff, $ff, $43, $01, $02, $56, $03, $02, $4a, $0f, $0f, $03
    db $03, $03, $03, $02, $70, $0f, $4d, $02, $d0, $0f, $4d, $02, $08, $1f, $11

; LZSS-compressed: 72 bytes that expand to 360 (E-0016, E-0017)
Map39Attrs0_Y0X3::
    INCBIN "maps/map39/attrs0_y0_x3.lz"

; LZSS-compressed: 83 bytes that expand to 360 (E-0016, E-0017)
Map39Attrs0_Y1X0::
    INCBIN "maps/map39/attrs0_y1_x0.lz"

; LZSS-compressed: 67 bytes that expand to 360 (E-0016, E-0017)
Map39Attrs0_Y1X1::
    INCBIN "maps/map39/attrs0_y1_x1.lz"

; LZSS-compressed: 80 bytes that expand to 360 (E-0016, E-0017)
Map39Attrs3_Y1X1::
    INCBIN "maps/map39/attrs3_y1_x1.lz"

; LZSS-compressed: 75 bytes that expand to 360 (E-0016, E-0017)
Map39Attrs0_Y1X2::
    INCBIN "maps/map39/attrs0_y1_x2.lz"

; LZSS-compressed: 63 bytes that expand to 360 (E-0016, E-0017)
Map39Attrs0_Y1X3::
    db $68, $01, $02, $00, $00, $01, $01, $02, $f6, $fe, $02, $02, $0f, $35, $01, $01
    db $02, $4c, $0f, $09, $02, $02, $04, $02, $7a, $0f, $0f, $02, $74, $0f, $01, $02
    db $a6, $0f, $07, $03, $03, $02, $c2, $0f, $0b, $03, $03, $03, $03, $02, $e4, $0f
    db $05, $02, $00, $06, $02, $06, $1f, $03, $02, $f8, $fe, $02, $2e, $1f, $13

; LZSS-compressed: 34 bytes that expand to 360 (E-0016, E-0017)
Map39Attrs0_Y2X0::
    db $68, $01, $02, $02, $ff, $ff, $41, $01, $02, $54, $0b, $02, $50, $0f, $07, $03
    db $02, $7e, $09, $02, $78, $0f, $4d, $02, $88, $06, $02, $56, $0f, $13, $02, $1b
    db $1f, $39

; LZSS-compressed: 66 bytes that expand to 360 (E-0016, E-0017)
Map39Attrs0_Y2X1::
    INCBIN "maps/map39/attrs0_y2_x1.lz"

; LZSS-compressed: 19 bytes that expand to 360 (E-0016, E-0017)
Map39Attrs0_Y2X2::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $5f, $0f, $4d, $01, $bf, $0f, $4d, $01
    db $1f, $1f, $35

; LZSS-compressed: 89 bytes that expand to 360 (E-0016, E-0017)
Map39Attrs0_Y2X3::
    INCBIN "maps/map39/attrs0_y2_x3.lz"

; 9 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map3AScreens0::
    dfar Map3AScreens0_Y0X0 ; entry 0
    dfar Map3AScreens0_Y0X1 ; entry 1
    dfar Map3AScreens0_Y0X2 ; entry 2
    dfar Map3AScreens0_Y1X0 ; entry 3
    dfar Map3AScreens0_Y1X1 ; entry 4
    dfar Map3AScreens0_Y1X2 ; entry 5
    dfar Map3AScreens0_Y2X0 ; entry 6
    dfar Map3AScreens0_Y2X1 ; entry 7
    dfar Map3AScreens0_Y2X2 ; entry 8

Map3AAttrs0::
    dfar Map3AAttrs0_Y0X0 ; entry 0
    dfar Map3AAttrs0_Y0X1 ; entry 1
    dfar Map3AAttrs0_Y0X2 ; entry 2
    dfar Map3AAttrs0_Y1X0 ; entry 3
    dfar Map3AAttrs0_Y1X1 ; entry 4
    dfar Map3AAttrs0_Y1X2 ; entry 5
    dfar Map3AAttrs0_Y2X0 ; entry 6
    dfar Map3AAttrs0_Y2X1 ; entry 7
    dfar Map3AAttrs0_Y2X2 ; entry 8

; LZSS-compressed: 118 bytes that expand to 360 (E-0016, E-0017)
Map3AScreens0_Y0X0::
    INCBIN "maps/map3_a/screens0_y0_x0.lz"

; LZSS-compressed: 209 bytes that expand to 360 (E-0016, E-0017)
Map3AScreens0_Y0X1::
    INCBIN "maps/map3_a/screens0_y0_x1.lz"

; LZSS-compressed: 208 bytes that expand to 360 (E-0016, E-0017)
Map3AScreens0_Y0X2::
    INCBIN "maps/map3_a/screens0_y0_x2.lz"

; LZSS-compressed: 173 bytes that expand to 360 (E-0016, E-0017)
Map3AScreens0_Y1X0::
    INCBIN "maps/map3_a/screens0_y1_x0.lz"

; LZSS-compressed: 179 bytes that expand to 360 (E-0016, E-0017)
Map3AScreens0_Y1X1::
    INCBIN "maps/map3_a/screens0_y1_x1.lz"

; LZSS-compressed: 80 bytes that expand to 360 (E-0016, E-0017)
Map3AScreens0_Y1X2::
    INCBIN "maps/map3_a/screens0_y1_x2.lz"

; LZSS-compressed: 147 bytes that expand to 360 (E-0016, E-0017)
Map3AScreens0_Y2X0::
    INCBIN "maps/map3_a/screens0_y2_x0.lz"

; LZSS-compressed: 174 bytes that expand to 360 (E-0016, E-0017)
Map3AScreens0_Y2X1::
    INCBIN "maps/map3_a/screens0_y2_x1.lz"

; LZSS-compressed: 19 bytes that expand to 360 (E-0016, E-0017)
Map3AScreens0_Y2X2::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $5f, $0f, $4d, $01, $bf, $0f, $4d, $01
    db $1f, $1f, $35

; LZSS-compressed: 72 bytes that expand to 360 (E-0016, E-0017)
Map3AAttrs0_Y0X0::
    INCBIN "maps/map3_a/attrs0_y0_x0.lz"

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
Map3AAttrs0_Y0X1::
    INCBIN "maps/map3_a/attrs0_y0_x1.lz"

; LZSS-compressed: 88 bytes that expand to 360 (E-0016, E-0017)
Map3AAttrs0_Y0X2::
    INCBIN "maps/map3_a/attrs0_y0_x2.lz"

; LZSS-compressed: 74 bytes that expand to 360 (E-0016, E-0017)
Map3AAttrs0_Y1X0::
    INCBIN "maps/map3_a/attrs0_y1_x0.lz"

; LZSS-compressed: 69 bytes that expand to 360 (E-0016, E-0017)
Map3AAttrs0_Y1X1::
    INCBIN "maps/map3_a/attrs0_y1_x1.lz"

; LZSS-compressed: 35 bytes that expand to 360 (E-0016, E-0017)
Map3AAttrs0_Y1X2::
    db $68, $01, $02, $02, $ff, $ff, $3d, $01, $02, $50, $07, $02, $48, $0f, $09, $03
    db $02, $78, $05, $02, $6e, $0f, $33, $02, $50, $0f, $15, $02, $ef, $0f, $4d, $02
    db $4f, $1f, $05

; LZSS-compressed: 80 bytes that expand to 360 (E-0016, E-0017)
Map3AAttrs0_Y2X0::
    INCBIN "maps/map3_a/attrs0_y2_x0.lz"

; LZSS-compressed: 65 bytes that expand to 360 (E-0016, E-0017)
Map3AAttrs0_Y2X1::
    INCBIN "maps/map3_a/attrs0_y2_x1.lz"

; LZSS-compressed: 19 bytes that expand to 360 (E-0016, E-0017)
Map3AAttrs0_Y2X2::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $5f, $0f, $4d, $01, $bf, $0f, $4d, $01
    db $1f, $1f, $35
    ds $c26, $00
