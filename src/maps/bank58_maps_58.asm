; ROM bank $58: map screens, attributes and tilesets
; The annotated listing of this bank is build/listing/bank58.asm.

SECTION "Bank 58", ROMX[$4000], BANK[$58]
    db $58

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map32Palettes::
    dw $7c01, $7fff, $7fe1, $0000 ; entry 0
    dw $218c, $4f18, $3a52, $0000 ; entry 1
    dw $02c0, $3f7f, $03e2, $0000 ; entry 2
    dw $010e, $3f7f, $0216, $0000 ; entry 3
    dw $0192, $3f7f, $03e2, $0000 ; entry 4
    dw $001b, $2bff, $023f, $0000 ; entry 5
    dw $7c01, $7fff, $56b5, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

Map33Palettes::
    dw $4044, $7fff, $0216, $0000 ; entry 0
    dw $01c2, $7fff, $0216, $0000 ; entry 1
    dw $010e, $3f7f, $0216, $0002 ; entry 2
    dw $1092, $39dc, $108c, $0084 ; entry 3
    dw $4908, $7fff, $6250, $0ca5 ; entry 4
    dw $4f18, $3a52, $218c, $0ca5 ; entry 5
    dw $4f18, $3a52, $3bff, $0ca5 ; entry 6
    dw $4f18, $3a52, $218c, $0ca5 ; entry 7

Map34Palettes::
    dw $1528, $7fff, $6b2b, $0000 ; entry 0
    dw $010e, $7bde, $22ba, $0000 ; entry 1
    dw $010e, $22ba, $11d4, $0000 ; entry 2
    dw $010e, $3f7f, $0216, $0000 ; entry 3
    dw $698b, $4f18, $1648, $0000 ; entry 4
    dw $001b, $2bff, $023f, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

Map35Palettes::
    dw $6080, $7fff, $6301, $0000 ; entry 0
    dw $0152, $3f7f, $025e, $0002 ; entry 1
    dw $001b, $2bff, $023f, $0000 ; entry 2
    dw $00cf, $3f7f, $0176, $0002 ; entry 3
    dw $4f18, $3a52, $218c, $0ca5 ; entry 4
    dw $4f18, $3a52, $218c, $0ca5 ; entry 5
    dw $4f18, $3a52, $218c, $0ca5 ; entry 6
    dw $4f18, $3a52, $218c, $0ca5 ; entry 7

Map36Palettes::
    dw $7da0, $7fff, $7fe0, $0000 ; entry 0
    dw $7da0, $4f18, $260c, $0000 ; entry 1
    dw $7da0, $4f18, $7fe0, $0000 ; entry 2
    dw $0941, $4f18, $1627, $0000 ; entry 3
    dw $7da0, $7fff, $5ad6, $0000 ; entry 4
    dw $012f, $4f3a, $01d5, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

Map37Palettes::
    dw $7c01, $7fff, $6301, $0000 ; entry 0
    dw $012f, $4f18, $01d8, $0000 ; entry 1
    dw $012f, $3fbf, $01d5, $0000 ; entry 2
    dw $0941, $3af3, $1627, $0000 ; entry 3
    dw $0949, $4ef5, $2dcd, $0000 ; entry 4
    dw $012f, $3af3, $01d5, $0000 ; entry 5
    dw $001b, $2bff, $023f, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; compressed tileset of map $40 (the first map record using it)
; LZSS-compressed: 1062 bytes that expand to 1792 (E-0016, E-0017)
Map40Tileset::
    INCBIN "maps/map40/tileset.lz"

Map40Palettes::
    dw $7da0, $7fff, $7fe0, $0000 ; entry 0
    dw $28c8, $3fbf, $4192, $0000 ; entry 1
    dw $3108, $72dc, $4992, $0ca5 ; entry 2
    dw $0106, $4f18, $020c, $0000 ; entry 3
    dw $2084, $2a56, $394a, $0000 ; entry 4
    dw $0106, $677a, $0210, $0000 ; entry 5
    dw $7da0, $7fff, $5ad6, $0000 ; entry 6
    dw $218c, $4f18, $3a52, $0ca5 ; entry 7

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map40Screens0::
    dfar Map40Screens0_Y0X0 ; entry 0
    dfar Map40Screens0_Y1X0 ; entry 1

Map40Attrs0::
    dfar Map40Attrs0_Y0X0 ; entry 0
    dfar Map40Attrs0_Y1X0 ; entry 1

Map40Screens2::
    dfar Map40Screens2_Y0X0 ; entry 0
    dfar Map40Screens2_Y1X0 ; entry 1

Map40Attrs2::
    dfar Map40Attrs2_Y0X0 ; entry 0
    dfar Map40Attrs2_Y1X0 ; entry 1

; LZSS-compressed: 263 bytes that expand to 360 (E-0016, E-0017)
Map40Screens0_Y0X0::
    INCBIN "maps/map40/screens0_y0_x0.lz"

; LZSS-compressed: 245 bytes that expand to 360 (E-0016, E-0017)
ScreenMap58_1::
    INCBIN "gfx/misc/screen_map58_1.lz"

; LZSS-compressed: 243 bytes that expand to 360 (E-0016, E-0017)
ScreenMap58_2::
    INCBIN "gfx/misc/screen_map58_2.lz"

; LZSS-compressed: 188 bytes that expand to 360 (E-0016, E-0017)
Map40Screens2_Y0X0::
    INCBIN "maps/map40/screens2_y0_x0.lz"

; LZSS-compressed: 274 bytes that expand to 360 (E-0016, E-0017)
Map40Screens0_Y1X0::
    INCBIN "maps/map40/screens0_y1_x0.lz"

; LZSS-compressed: 247 bytes that expand to 360 (E-0016, E-0017)
Map40Screens2_Y1X0::
    INCBIN "maps/map40/screens2_y1_x0.lz"

; LZSS-compressed: 143 bytes that expand to 360 (E-0016, E-0017)
Map40Attrs0_Y0X0::
    INCBIN "maps/map40/attrs0_y0_x0.lz"

; LZSS-compressed: 137 bytes that expand to 360 (E-0016, E-0017)
ScreenMap58_3::
    INCBIN "gfx/misc/screen_map58_3.lz"

; LZSS-compressed: 113 bytes that expand to 360 (E-0016, E-0017)
ScreenMap58_4::
    INCBIN "gfx/misc/screen_map58_4.lz"

; LZSS-compressed: 86 bytes that expand to 360 (E-0016, E-0017)
Map40Attrs2_Y0X0::
    INCBIN "maps/map40/attrs2_y0_x0.lz"

; LZSS-compressed: 133 bytes that expand to 360 (E-0016, E-0017)
Map40Attrs0_Y1X0::
    INCBIN "maps/map40/attrs0_y1_x0.lz"

; LZSS-compressed: 106 bytes that expand to 360 (E-0016, E-0017)
Map40Attrs2_Y1X0::
    INCBIN "maps/map40/attrs2_y1_x0.lz"

; compressed tileset of map $41 (the first map record using it)
; LZSS-compressed: 1379 bytes that expand to 1648 (E-0016, E-0017)
Map41Tileset::
    INCBIN "maps/map41/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map41Palettes::
    dw $7da0, $7fff, $7fe0, $0063 ; entry 0
    dw $5ad6, $7fff, $7fe0, $0063 ; entry 1
    dw $4cf4, $3fbf, $6238, $0000 ; entry 2
    dw $7da0, $3fbf, $6238, $0000 ; entry 3
    dw $4cf4, $7fe0, $6238, $0000 ; entry 4
    dw $0116, $03ff, $01fc, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map41Screens0::
    dfar Map41Screens0_Y0X0 ; entry 0
    dfar Map41Screens0_Y1X0 ; entry 1

Map41Attrs0::
    dfar Map41Attrs0_Y0X0 ; entry 0
    dfar Map41Attrs0_Y1X0 ; entry 1

; LZSS-compressed: 306 bytes that expand to 360 (E-0016, E-0017)
Map41Screens0_Y0X0::
    INCBIN "maps/map41/screens0_y0_x0.lz"

; LZSS-compressed: 296 bytes that expand to 360 (E-0016, E-0017)
Map41Screens0_Y1X0::
    INCBIN "maps/map41/screens0_y1_x0.lz"

; LZSS-compressed: 132 bytes that expand to 360 (E-0016, E-0017)
Map41Attrs0_Y0X0::
    INCBIN "maps/map41/attrs0_y0_x0.lz"

; LZSS-compressed: 119 bytes that expand to 360 (E-0016, E-0017)
Map41Attrs0_Y1X0::
    INCBIN "maps/map41/attrs0_y1_x0.lz"

; 3 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map42Screens0::
    dfar Map42Screens0_Y0X0 ; entry 0
    dfar Map42Screens0_Y0X1 ; entry 1
    dfar Map42Screens0_Y0X2 ; entry 2

Map42Attrs0::
    dfar Map42Attrs0_Y0X0 ; entry 0
    dfar Map42Attrs0_Y0X1 ; entry 1
    dfar Map42Attrs0_Y0X2 ; entry 2

; LZSS-compressed: 284 bytes that expand to 360 (E-0016, E-0017)
Map42Screens0_Y0X0::
    INCBIN "maps/map42/screens0_y0_x0.lz"

; LZSS-compressed: 274 bytes that expand to 360 (E-0016, E-0017)
Map42Screens0_Y0X1::
    INCBIN "maps/map42/screens0_y0_x1.lz"

; LZSS-compressed: 260 bytes that expand to 360 (E-0016, E-0017)
Map42Screens0_Y0X2::
    INCBIN "maps/map42/screens0_y0_x2.lz"

; LZSS-compressed: 45 bytes that expand to 360 (E-0016, E-0017)
Map42Attrs0_Y0X0::
    db $68, $01, $00, $03, $00, $00, $05, $05, $00, $00, $06, $00, $0b, $0f, $08, $06
    db $00, $30, $01, $03, $03, $05, $00, $0a, $07, $00, $30, $0f, $01, $00, $4e, $0f
    db $3f, $00, $4c, $0f, $01, $00, $4c, $0f, $4b, $00, $4e, $0f, $39

; LZSS-compressed: 64 bytes that expand to 360 (E-0016, E-0017)
Map42Attrs0_Y0X1::
    db $68, $01, $02, $03, $03, $03, $03, $05, $02, $00, $00, $02, $03, $02, $02, $04
    db $02, $02, $10, $0f, $02, $01, $01, $02, $28, $02, $02, $10, $08, $02, $fe, $f0
    db $02, $fe, $f2, $02, $34, $0f, $0b, $05, $05, $02, $64, $02, $02, $1e, $0f, $29
    db $06, $06, $02, $5c, $0e, $02, $aa, $08, $02, $c9, $0f, $4d, $02, $08, $1f, $2b

; LZSS-compressed: 50 bytes that expand to 360 (E-0016, E-0017)
Map42Attrs0_Y0X2::
    db $68, $01, $00, $03, $03, $03, $03, $05, $00, $00, $00, $00, $03, $02, $00, $04
    db $02, $00, $10, $0f, $10, $05, $00, $0f, $0f, $00, $00, $38, $0f, $29, $00, $10
    db $0f, $13, $02, $02, $02, $02, $00, $9e, $0f, $07, $00, $60, $0f, $3b, $00, $08
    db $1f, $3b

; compressed tileset of map $44 (the first map record using it)
; LZSS-compressed: 1164 bytes that expand to 1568 (E-0016, E-0017)
Map44Tileset::
    INCBIN "maps/map44/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map44Palettes::
    dw $294a, $7fff, $4f18, $0000 ; entry 0
    dw $012f, $4f18, $01d8, $0000 ; entry 1
    dw $012f, $3fbf, $01d5, $0000 ; entry 2
    dw $0941, $3af3, $1627, $0000 ; entry 3
    dw $1410, $02d7, $4d15, $0000 ; entry 4
    dw $012f, $3af3, $01d8, $0000 ; entry 5
    dw $001b, $2bff, $023f, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map44Screens0::
    dfar Map44Screens0_Y0X0 ; entry 0

Map44Attrs0::
    dfar Map44Attrs0_Y0X0 ; entry 0

; LZSS-compressed: 275 bytes that expand to 360 (E-0016, E-0017)
Map44Screens0_Y0X0::
    INCBIN "maps/map44/screens0_y0_x0.lz"

; LZSS-compressed: 119 bytes that expand to 360 (E-0016, E-0017)
Map44Attrs0_Y0X0::
    INCBIN "maps/map44/attrs0_y0_x0.lz"

; compressed tileset of map $A0 (the first map record using it)
; LZSS-compressed: 974 bytes that expand to 1792 (E-0016, E-0017)
MapA0Tileset::
    INCBIN "maps/mapa0/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
MapA0Palettes::
    dw $0173, $7fff, $0235, $0063 ; entry 0
    dw $0110, $51ce, $0235, $0063 ; entry 1
    dw $0142, $03ff, $034e, $0000 ; entry 2
    dw $0110, $03ff, $034e, $0000 ; entry 3
    dw $384e, $03ff, $5956, $0000 ; entry 4
    dw $300c, $35b8, $4812, $0000 ; entry 5
    dw $218c, $4f18, $3a52, $0000 ; entry 6
    dw $218c, $4f18, $3a52, $0000 ; entry 7

; 12 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
MapA0Screens0::
    dfar MapA0Screens0_Y0X0 ; entry 0
    dfar MapA0Screens0_Y0X1 ; entry 1
    dfar MapA0Screens0_Y0X2 ; entry 2
    dfar MapA0Screens0_Y0X3 ; entry 3
    dfar MapA0Screens0_Y1X0 ; entry 4
    dfar MapA0Screens0_Y1X1 ; entry 5
    dfar MapA0Screens0_Y1X2 ; entry 6
    dfar MapA0Screens0_Y1X3 ; entry 7
    dfar MapA0Screens0_Y2X0 ; entry 8
    dfar MapA0Screens0_Y2X1 ; entry 9
    dfar MapA0Screens0_Y2X2 ; entry 10
    dfar MapA0Screens0_Y2X3 ; entry 11

MapA0Attrs0::
    dfar MapA0Attrs0_Y0X0 ; entry 0
    dfar MapA0Attrs0_Y0X1 ; entry 1
    dfar MapA0Attrs0_Y0X2 ; entry 2
    dfar MapA0Attrs0_Y0X3 ; entry 3
    dfar MapA0Attrs0_Y1X0 ; entry 4
    dfar MapA0Attrs0_Y1X1 ; entry 5
    dfar MapA0Attrs0_Y1X2 ; entry 6
    dfar MapA0Attrs0_Y1X3 ; entry 7
    dfar MapA0Attrs0_Y2X0 ; entry 8
    dfar MapA0Attrs0_Y2X1 ; entry 9
    dfar MapA0Attrs0_Y2X2 ; entry 10
    dfar MapA0Attrs0_Y2X3 ; entry 11

MapA0Screens1::
    dfar MapA0Screens0_Y0X0 ; entry 0
    dfar MapA0Screens0_Y0X1 ; entry 1
    dfar MapA0Screens0_Y0X2 ; entry 2
    dfar MapA0Screens0_Y0X3 ; entry 3
    dfar MapA0Screens0_Y1X0 ; entry 4
    dfar MapA0Screens1_Y1X1 ; entry 5
    dfar MapA0Screens0_Y1X2 ; entry 6
    dfar MapA0Screens0_Y1X3 ; entry 7
    dfar MapA0Screens0_Y2X0 ; entry 8
    dfar MapA0Screens0_Y2X1 ; entry 9
    dfar MapA0Screens0_Y2X2 ; entry 10
    dfar MapA0Screens0_Y2X3 ; entry 11

MapA0Attrs1::
    dfar MapA0Attrs0_Y0X0 ; entry 0
    dfar MapA0Attrs0_Y0X1 ; entry 1
    dfar MapA0Attrs0_Y0X2 ; entry 2
    dfar MapA0Attrs0_Y0X3 ; entry 3
    dfar MapA0Attrs0_Y1X0 ; entry 4
    dfar MapA0Attrs1_Y1X1 ; entry 5
    dfar MapA0Attrs0_Y1X2 ; entry 6
    dfar MapA0Attrs0_Y1X3 ; entry 7
    dfar MapA0Attrs0_Y2X0 ; entry 8
    dfar MapA0Attrs0_Y2X1 ; entry 9
    dfar MapA0Attrs0_Y2X2 ; entry 10
    dfar MapA0Attrs0_Y2X3 ; entry 11

; LZSS-compressed: 77 bytes that expand to 360 (E-0016, E-0017)
MapA0Screens0_Y0X0::
    INCBIN "maps/mapa0/screens0_y0_x0.lz"

; LZSS-compressed: 165 bytes that expand to 360 (E-0016, E-0017)
MapA0Screens0_Y0X1::
    INCBIN "maps/mapa0/screens0_y0_x1.lz"

; LZSS-compressed: 28 bytes that expand to 360 (E-0016, E-0017)
MapA0Screens0_Y0X2::
    db $68, $01, $02, $00, $01, $02, $00, $0e, $02, $01, $0f, $00, $02, $ff, $ff, $4d
    db $02, $5f, $0f, $4d, $02, $bf, $0f, $4d, $02, $f7, $0f, $0e

MapA0Screens0_Y0X3::
    db $68, $01, $02, $00, $01, $02, $00, $0e, $02, $01, $0f, $00, $02, $ff, $ff, $4d
    db $02, $5f, $0f, $4d, $02, $bf, $0f, $4d, $02, $f7, $0f, $0e

; LZSS-compressed: 128 bytes that expand to 360 (E-0016, E-0017)
MapA0Screens0_Y1X0::
    INCBIN "maps/mapa0/screens0_y1_x0.lz"

; LZSS-compressed: 230 bytes that expand to 360 (E-0016, E-0017)
MapA0Screens0_Y1X1::
    INCBIN "maps/mapa0/screens0_y1_x1.lz"

; LZSS-compressed: 223 bytes that expand to 360 (E-0016, E-0017)
MapA0Screens1_Y1X1::
    INCBIN "maps/mapa0/screens1_y1_x1.lz"

; LZSS-compressed: 174 bytes that expand to 360 (E-0016, E-0017)
MapA0Screens0_Y1X2::
    INCBIN "maps/mapa0/screens0_y1_x2.lz"

; LZSS-compressed: 28 bytes that expand to 360 (E-0016, E-0017)
MapA0Screens0_Y1X3::
    db $68, $01, $02, $00, $01, $02, $00, $0e, $02, $01, $0f, $00, $02, $ff, $ff, $4d
    db $02, $5f, $0f, $4d, $02, $bf, $0f, $4d, $02, $f7, $0f, $0e

; LZSS-compressed: 106 bytes that expand to 360 (E-0016, E-0017)
MapA0Screens0_Y2X0::
    INCBIN "maps/mapa0/screens0_y2_x0.lz"

; LZSS-compressed: 224 bytes that expand to 360 (E-0016, E-0017)
MapA0Screens0_Y2X1::
    INCBIN "maps/mapa0/screens0_y2_x1.lz"

; LZSS-compressed: 132 bytes that expand to 360 (E-0016, E-0017)
MapA0Screens0_Y2X2::
    INCBIN "maps/mapa0/screens0_y2_x2.lz"

MapA0Screens0_Y2X3::
    db $68, $01, $02, $00, $01, $02, $00, $0e, $02, $01, $0f, $00, $02, $ff, $ff, $4d
    db $02, $5f, $0f, $4d, $02, $bf, $0f, $4d, $02, $f7, $0f, $0e

; LZSS-compressed: 37 bytes that expand to 360 (E-0016, E-0017)
MapA0Attrs0_Y0X0::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $7a, $0f, $06
    db $02, $02, $00, $c8, $0f, $0f, $02, $00, $fe, $01, $00, $f0, $0f, $0d, $00, $fe
    db $02, $00, $16, $1f, $2b

; LZSS-compressed: 64 bytes that expand to 360 (E-0016, E-0017)
MapA0Attrs0_Y0X1::
    db $68, $01, $00, $01, $00, $00, $0f, $1e, $03, $03, $00, $20, $0f, $11, $02, $02
    db $02, $02, $00, $32, $0c, $00, $58, $0e, $00, $58, $00, $00, $58, $0c, $00, $7e
    db $0c, $00, $7e, $04, $00, $5a, $00, $00, $9a, $0f, $07, $00, $a2, $0f, $13, $00
    db $a0, $0a, $00, $76, $0c, $00, $f8, $0f, $01, $00, $ac, $06, $00, $16, $1f, $2b

; LZSS-compressed: 20 bytes that expand to 360 (E-0016, E-0017)
MapA0Attrs0_Y0X2::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

MapA0Attrs0_Y0X3::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

; LZSS-compressed: 48 bytes that expand to 360 (E-0016, E-0017)
MapA0Attrs0_Y1X0::
    db $68, $01, $00, $01, $00, $00, $07, $02, $00, $0c, $03, $00, $00, $0f, $0b, $00
    db $0c, $04, $00, $26, $0f, $0b, $00, $32, $06, $00, $4e, $0f, $0b, $00, $30, $0f
    db $15, $00, $08, $0f, $17, $00, $be, $0f, $3f, $00, $0a, $04, $00, $18, $1f, $29

; LZSS-compressed: 85 bytes that expand to 360 (E-0016, E-0017)
MapA0Attrs0_Y1X1::
    INCBIN "maps/mapa0/attrs0_y1_x1.lz"

; LZSS-compressed: 82 bytes that expand to 360 (E-0016, E-0017)
MapA0Attrs1_Y1X1::
    INCBIN "maps/mapa0/attrs1_y1_x1.lz"

; LZSS-compressed: 57 bytes that expand to 360 (E-0016, E-0017)
MapA0Attrs0_Y1X2::
    db $68, $01, $00, $01, $00, $00, $0f, $40, $02, $00, $54, $01, $00, $46, $0f, $0b
    db $00, $54, $02, $03, $03, $00, $56, $08, $00, $78, $0f, $05, $03, $00, $a4, $01
    db $00, $56, $06, $00, $a0, $0f, $2d, $00, $7c, $0f, $15, $00, $18, $16, $00, $12
    db $1f, $13, $00, $10, $1f, $01, $00, $00, $04

; LZSS-compressed: 20 bytes that expand to 360 (E-0016, E-0017)
MapA0Attrs0_Y1X3::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

; LZSS-compressed: 41 bytes that expand to 360 (E-0016, E-0017)
MapA0Attrs0_Y2X0::
    db $68, $01, $00, $01, $00, $00, $09, $02, $00, $0e, $01, $00, $00, $0f, $0d, $00
    db $0e, $02, $00, $26, $0f, $37, $00, $0c, $0f, $15, $00, $0a, $04, $00, $a0, $0f
    db $11, $00, $d7, $0f, $4d, $00, $08, $1f, $1d

; LZSS-compressed: 84 bytes that expand to 360 (E-0016, E-0017)
MapA0Attrs0_Y2X1::
    INCBIN "maps/mapa0/attrs0_y2_x1.lz"

; LZSS-compressed: 45 bytes that expand to 360 (E-0016, E-0017)
MapA0Attrs0_Y2X2::
    db $68, $01, $00, $02, $00, $00, $07, $01, $00, $0c, $03, $00, $00, $0f, $29, $00
    db $12, $06, $00, $48, $06, $00, $50, $0f, $03, $00, $10, $02, $00, $6e, $0c, $00
    db $7c, $0f, $03, $00, $a5, $0f, $4d, $00, $05, $1f, $4d, $01, $01

MapA0Attrs0_Y2X3::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

; compressed tileset of map $A1 (the first map record using it)
; LZSS-compressed: 1332 bytes that expand to 1664 (E-0016, E-0017)
MapA1Tileset::
    INCBIN "maps/mapa1/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
MapA1Palettes::
    dw $0160, $7fff, $4a2d, $0000 ; entry 0
    dw $1154, $53de, $229a, $0000 ; entry 1
    dw $0142, $03ff, $034e, $0000 ; entry 2
    dw $008c, $035f, $00dc, $0000 ; entry 3
    dw $350e, $773c, $4616, $0c69 ; entry 4
    dw $0160, $5ab1, $4a2d, $0000 ; entry 5
    dw $05a4, $53de, $0e29, $0084 ; entry 6
    dw $7fff, $7fff, $7fff, $7fff ; entry 7

; 3 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
MapA1Screens0::
    dfar MapA1Screens0_Y0X0 ; entry 0
    dfar MapA1Screens0_Y1X0 ; entry 1
    dfar MapA1Screens0_Y2X0 ; entry 2

MapA1Attrs0::
    dfar MapA1Attrs0_Y0X0 ; entry 0
    dfar MapA1Attrs0_Y1X0 ; entry 1
    dfar MapA1Attrs0_Y2X0 ; entry 2

MapA1Screens1::
    dfar MapA1Screens1_Y0X0 ; entry 0
    dfar MapA1Screens0_Y1X0 ; entry 1
    dfar MapA1Screens0_Y2X0 ; entry 2

MapA1Attrs1::
    dfar MapA1Attrs1_Y0X0 ; entry 0
    dfar MapA1Attrs0_Y1X0 ; entry 1
    dfar MapA1Attrs0_Y2X0 ; entry 2

; LZSS-compressed: 249 bytes that expand to 360 (E-0016, E-0017)
MapA1Screens0_Y0X0::
    INCBIN "maps/mapa1/screens0_y0_x0.lz"

; LZSS-compressed: 145 bytes that expand to 360 (E-0016, E-0017)
MapA1Screens1_Y0X0::
    INCBIN "maps/mapa1/screens1_y0_x0.lz"

; LZSS-compressed: 278 bytes that expand to 360 (E-0016, E-0017)
MapA1Screens0_Y1X0::
    INCBIN "maps/mapa1/screens0_y1_x0.lz"

; LZSS-compressed: 243 bytes that expand to 360 (E-0016, E-0017)
MapA1Screens0_Y2X0::
    INCBIN "maps/mapa1/screens0_y2_x0.lz"

; LZSS-compressed: 63 bytes that expand to 360 (E-0016, E-0017)
MapA1Attrs0_Y0X0::
    db $68, $01, $02, $02, $ff, $f0, $06, $02, $04, $07, $02, $fc, $ff, $4d, $02, $0c
    db $08, $02, $15, $03, $02, $f4, $ff, $01, $02, $f9, $f7, $03, $03, $02, $90, $0f
    db $13, $01, $01, $02, $7c, $06, $02, $a2, $01, $02, $c7, $0f, $10, $02, $ca, $01
    db $02, $ef, $0f, $04, $02, $7a, $08, $02, $12, $1f, $15, $02, $86, $0f, $07

; LZSS-compressed: 57 bytes that expand to 360 (E-0016, E-0017)
MapA1Attrs1_Y0X0::
    db $68, $01, $02, $02, $ff, $ff, $45, $06, $06, $02, $46, $0f, $12, $06, $06, $02
    db $58, $0e, $02, $7f, $0b, $03, $03, $02, $90, $0f, $13, $01, $01, $02, $7c, $06
    db $02, $a2, $01, $02, $c7, $0f, $10, $02, $ca, $01, $02, $ef, $0f, $04, $02, $7a
    db $08, $02, $12, $1f, $15, $02, $72, $0f, $07

; LZSS-compressed: 98 bytes that expand to 360 (E-0016, E-0017)
MapA1Attrs0_Y1X0::
    INCBIN "maps/mapa1/attrs0_y1_x0.lz"

; LZSS-compressed: 83 bytes that expand to 360 (E-0016, E-0017)
MapA1Attrs0_Y2X0::
    INCBIN "maps/mapa1/attrs0_y2_x0.lz"
    ds $6b4, $00
