; ROM bank $55: map screens, attributes and tilesets
; The annotated listing of this bank is build/listing/bank55.asm.

SECTION "Bank 55", ROMX[$4000], BANK[$55]
    db $55

; compressed tileset of map $8C (the first map record using it)
; LZSS-compressed: 731 bytes that expand to 1792 (E-0016, E-0017)
Map8CTileset::
    INCBIN "maps/map8_c/tileset.lz"

; 9 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map8CScreens0::
    dfar Map8CScreens0_Y0X0 ; entry 0
    dfar Map8CScreens0_Y0X1 ; entry 1
    dfar Map8CScreens0_Y0X2 ; entry 2
    dfar Map8CScreens0_Y1X0 ; entry 3
    dfar Map8CScreens0_Y1X1 ; entry 4
    dfar Map8CScreens0_Y1X2 ; entry 5
    dfar Map8CScreens0_Y2X0 ; entry 6
    dfar Map8CScreens0_Y2X1 ; entry 7
    dfar Map8CScreens0_Y2X2 ; entry 8

Map8CAttrs0::
    dfar Map8CAttrs0_Y0X0 ; entry 0
    dfar Map8CAttrs0_Y0X1 ; entry 1
    dfar Map8CAttrs0_Y0X2 ; entry 2
    dfar Map8CAttrs0_Y1X0 ; entry 3
    dfar Map8CAttrs0_Y1X1 ; entry 4
    dfar Map8CAttrs0_Y1X2 ; entry 5
    dfar Map8CAttrs0_Y2X0 ; entry 6
    dfar Map8CAttrs0_Y2X1 ; entry 7
    dfar Map8CAttrs0_Y2X2 ; entry 8

; LZSS-compressed: 194 bytes that expand to 360 (E-0016, E-0017)
Map8CScreens0_Y0X0::
    INCBIN "maps/map8_c/screens0_y0_x0.lz"

; LZSS-compressed: 128 bytes that expand to 360 (E-0016, E-0017)
Map8CScreens0_Y0X1::
    INCBIN "maps/map8_c/screens0_y0_x1.lz"

; LZSS-compressed: 170 bytes that expand to 360 (E-0016, E-0017)
Map8CScreens0_Y0X2::
    INCBIN "maps/map8_c/screens0_y0_x2.lz"

; LZSS-compressed: 203 bytes that expand to 360 (E-0016, E-0017)
Map8CScreens0_Y1X0::
    INCBIN "maps/map8_c/screens0_y1_x0.lz"

; LZSS-compressed: 215 bytes that expand to 360 (E-0016, E-0017)
Map8CScreens0_Y1X1::
    INCBIN "maps/map8_c/screens0_y1_x1.lz"

; LZSS-compressed: 152 bytes that expand to 360 (E-0016, E-0017)
Map8CScreens0_Y1X2::
    INCBIN "maps/map8_c/screens0_y1_x2.lz"

; LZSS-compressed: 135 bytes that expand to 360 (E-0016, E-0017)
Map8CScreens0_Y2X0::
    INCBIN "maps/map8_c/screens0_y2_x0.lz"

; LZSS-compressed: 221 bytes that expand to 360 (E-0016, E-0017)
Map8CScreens0_Y2X1::
    INCBIN "maps/map8_c/screens0_y2_x1.lz"

; LZSS-compressed: 106 bytes that expand to 360 (E-0016, E-0017)
Map8CScreens0_Y2X2::
    INCBIN "maps/map8_c/screens0_y2_x2.lz"

; LZSS-compressed: 42 bytes that expand to 360 (E-0016, E-0017)
Map8CAttrs0_Y0X0::
    db $68, $01, $00, $01, $00, $00, $0f, $3e, $02, $00, $52, $05, $00, $50, $04, $00
    db $50, $0f, $2f, $00, $a0, $0a, $00, $a0, $0f, $4d, $00, $c4, $0c, $00, $56, $04
    db $00, $18, $1f, $09, $00, $44, $0e, $00, $00, $0a

; LZSS-compressed: 56 bytes that expand to 360 (E-0016, E-0017)
Map8CAttrs0_Y0X1::
    db $68, $01, $03, $01, $03, $00, $0f, $14, $04, $03, $28, $0f, $14, $02, $03, $50
    db $0f, $3c, $03, $00, $0f, $15, $10, $03, $c8, $01, $03, $26, $04, $03, $c6, $04
    db $03, $ca, $0f, $07, $03, $9a, $04, $03, $c8, $01, $00, $03, $04, $10, $03, $f6
    db $07, $03, $05, $11, $03, $06, $1f, $3b

; LZSS-compressed: 60 bytes that expand to 360 (E-0016, E-0017)
Map8CAttrs0_Y0X2::
    db $68, $01, $03, $01, $03, $00, $0f, $14, $04, $03, $28, $0d, $03, $26, $0f, $03
    db $02, $03, $50, $0d, $03, $4e, $0f, $2b, $03, $00, $02, $03, $92, $0f, $0f, $03
    db $4a, $0e, $03, $c6, $0f, $03, $10, $00, $10, $00, $03, $e0, $0f, $17, $03, $a0
    db $08, $03, $16, $1f, $07, $03, $fa, $f4, $03, $38, $1f, $09

; LZSS-compressed: 62 bytes that expand to 360 (E-0016, E-0017)
Map8CAttrs0_Y1X0::
    db $68, $01, $00, $01, $01, $02, $02, $02, $02, $01, $00, $06, $0b, $00, $02, $0f
    db $07, $04, $00, $30, $05, $00, $26, $0f, $09, $00, $52, $08, $00, $4e, $0f, $2d
    db $00, $0e, $08, $00, $9a, $0f, $09, $00, $34, $04, $00, $58, $08, $00, $ca, $0f
    db $01, $00, $ea, $0a, $00, $ec, $0f, $37, $00, $9e, $0e, $00, $06, $08

; LZSS-compressed: 69 bytes that expand to 360 (E-0016, E-0017)
Map8CAttrs0_Y1X1::
    INCBIN "maps/map8_c/attrs0_y1_x1.lz"

; LZSS-compressed: 57 bytes that expand to 360 (E-0016, E-0017)
Map8CAttrs0_Y1X2::
    db $68, $01, $03, $01, $03, $00, $07, $02, $03, $0c, $01, $03, $00, $08, $03, $0a
    db $06, $04, $03, $28, $05, $03, $1e, $0f, $0b, $03, $0c, $02, $03, $4a, $08, $03
    db $4e, $0f, $4d, $03, $0e, $0f

; LZSS-compressed: 415 bytes that expand to 775 (E-0016, E-0017)
Gfx55_1::
    db $07, $03, $00, $0f, $01, $03, $f6, $f8, $03, $e8, $0f, $3d, $03, $00, $04, $03
    db $40, $1f, $01

; LZSS-compressed: 45 bytes that expand to 360 (E-0016, E-0017)
Map8CAttrs0_Y2X0::
    db $68, $01, $03, $01, $01, $02, $03, $02, $01, $01, $01, $03, $f6, $ff, $4d, $03
    db $42, $0f, $2d, $03, $a8, $08, $03, $a2, $0f, $09, $04, $03, $d2, $05, $03, $c8
    db $0f, $09, $03, $f2, $08, $03, $f0, $0f, $2b, $03, $40, $1f, $13

; LZSS-compressed: 64 bytes that expand to 360 (E-0016, E-0017)
Map8CAttrs0_Y2X1::
    db $68, $01, $00, $01, $00, $00, $09, $02, $02, $02, $02, $00, $00, $0a, $00, $0c
    db $06, $04, $00, $2a, $05, $00, $20, $0f, $0b, $00, $0e, $00, $00, $52, $02, $00
    db $48, $0f, $37, $00, $a0, $0a, $00, $a0, $0f, $01, $04, $00, $b5, $0f, $14, $00
    db $56, $08, $00, $f8, $0a, $00, $f6, $0f, $23, $00, $12, $0c, $00, $40, $1f, $05

; LZSS-compressed: 50 bytes that expand to 360 (E-0016, E-0017)
Map8CAttrs0_Y2X2::
    db $68, $01, $03, $10, $03, $00, $06, $00, $03, $0a, $05, $03, $01, $0f, $4d, $03
    db $11, $0a, $03, $1e, $00, $03, $73, $0f, $06, $01, $03, $a0, $0f, $14, $04, $03
    db $c8, $0d, $03, $c6, $0f, $03, $02, $03, $f0, $0d, $03, $ee, $0f, $2b, $03, $a0
    db $0f, $15

; 6 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map90Screens0::
    dfar Map90Screens0_Y0X0 ; entry 0
    dfar Map90Screens0_Y0X1 ; entry 1
    dfar Map90Screens0_Y0X2 ; entry 2
    dfar Map90Screens0_Y1X0 ; entry 3
    dfar Map90Screens0_Y1X1 ; entry 4
    dfar Map90Screens0_Y1X2 ; entry 5

Map90Attrs0::
    dfar Map90Attrs0_Y0X0 ; entry 0
    dfar Map90Attrs0_Y0X1 ; entry 1
    dfar Map90Attrs0_Y0X2 ; entry 2
    dfar Map90Attrs0_Y1X0 ; entry 3
    dfar Map90Attrs0_Y1X1 ; entry 4
    dfar Map90Attrs0_Y1X2 ; entry 5

; LZSS-compressed: 201 bytes that expand to 360 (E-0016, E-0017)
Map90Screens0_Y0X0::
    INCBIN "maps/map90/screens0_y0_x0.lz"

; LZSS-compressed: 164 bytes that expand to 360 (E-0016, E-0017)
Map90Screens0_Y0X1::
    INCBIN "maps/map90/screens0_y0_x1.lz"

; LZSS-compressed: 175 bytes that expand to 360 (E-0016, E-0017)
Map90Screens0_Y0X2::
    INCBIN "maps/map90/screens0_y0_x2.lz"

; LZSS-compressed: 185 bytes that expand to 360 (E-0016, E-0017)
Map90Screens0_Y1X0::
    INCBIN "maps/map90/screens0_y1_x0.lz"

; LZSS-compressed: 193 bytes that expand to 360 (E-0016, E-0017)
Map90Screens0_Y1X1::
    INCBIN "maps/map90/screens0_y1_x1.lz"

; LZSS-compressed: 151 bytes that expand to 360 (E-0016, E-0017)
Map90Screens0_Y1X2::
    INCBIN "maps/map90/screens0_y1_x2.lz"

; LZSS-compressed: 86 bytes that expand to 360 (E-0016, E-0017)
Map90Attrs0_Y0X0::
    INCBIN "maps/map90/attrs0_y0_x0.lz"

; LZSS-compressed: 70 bytes that expand to 360 (E-0016, E-0017)
Map90Attrs0_Y0X1::
    INCBIN "maps/map90/attrs0_y0_x1.lz"

; LZSS-compressed: 72 bytes that expand to 360 (E-0016, E-0017)
Map90Attrs0_Y0X2::
    INCBIN "maps/map90/attrs0_y0_x2.lz"

; LZSS-compressed: 80 bytes that expand to 360 (E-0016, E-0017)
Map90Attrs0_Y1X0::
    INCBIN "maps/map90/attrs0_y1_x0.lz"

; LZSS-compressed: 82 bytes that expand to 360 (E-0016, E-0017)
Map90Attrs0_Y1X1::
    INCBIN "maps/map90/attrs0_y1_x1.lz"

; LZSS-compressed: 78 bytes that expand to 360 (E-0016, E-0017)
Map90Attrs0_Y1X2::
    INCBIN "maps/map90/attrs0_y1_x2.lz"

; compressed tileset of map $8E (the first map record using it)
; LZSS-compressed: 1566 bytes that expand to 1792 (E-0016, E-0017)
Map8ETileset::
    INCBIN "maps/map8_e/tileset.lz"

; 9 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map8EScreens0::
    dfar Map8EScreens0_Y0X0 ; entry 0
    dfar Map8EScreens0_Y0X1 ; entry 1
    dfar Map8EScreens0_Y0X2 ; entry 2
    dfar Map8EScreens0_Y1X0 ; entry 3
    dfar Map8EScreens0_Y1X1 ; entry 4
    dfar Map8EScreens0_Y1X2 ; entry 5
    dfar Map8EScreens0_Y2X0 ; entry 6
    dfar Map8EScreens0_Y2X1 ; entry 7
    dfar Map8EScreens0_Y2X2 ; entry 8

Map8EAttrs0::
    dfar Map8EAttrs0_Y0X0 ; entry 0
    dfar Map8EAttrs0_Y0X1 ; entry 1
    dfar Map8EAttrs0_Y0X2 ; entry 2
    dfar Map8EAttrs0_Y1X0 ; entry 3
    dfar Map8EAttrs0_Y1X1 ; entry 4
    dfar Map8EAttrs0_Y1X2 ; entry 5
    dfar Map8EAttrs0_Y2X0 ; entry 6
    dfar Map8EAttrs0_Y2X1 ; entry 7
    dfar Map8EAttrs0_Y2X2 ; entry 8

Map8EScreens3::
    dfar Map8EScreens0_Y0X0 ; entry 0
    dfar Map8EScreens3_Y0X1 ; entry 1
    dfar Map8EScreens0_Y0X2 ; entry 2
    dfar Map8EScreens0_Y1X0 ; entry 3
    dfar Map8EScreens0_Y1X1 ; entry 4
    dfar Map8EScreens0_Y1X2 ; entry 5
    dfar Map8EScreens0_Y2X0 ; entry 6
    dfar Map8EScreens0_Y2X1 ; entry 7
    dfar Map8EScreens0_Y2X2 ; entry 8

Map8EAttrs3::
    dfar Map8EAttrs0_Y0X0 ; entry 0
    dfar Map8EAttrs3_Y0X1 ; entry 1
    dfar Map8EAttrs0_Y0X2 ; entry 2
    dfar Map8EAttrs0_Y1X0 ; entry 3
    dfar Map8EAttrs0_Y1X1 ; entry 4
    dfar Map8EAttrs0_Y1X2 ; entry 5
    dfar Map8EAttrs0_Y2X0 ; entry 6
    dfar Map8EAttrs0_Y2X1 ; entry 7
    dfar Map8EAttrs0_Y2X2 ; entry 8

; LZSS-compressed: 265 bytes that expand to 360 (E-0016, E-0017)
Map8EScreens0_Y0X0::
    INCBIN "maps/map8_e/screens0_y0_x0.lz"

; LZSS-compressed: 227 bytes that expand to 360 (E-0016, E-0017)
Map8EScreens0_Y0X1::
    INCBIN "maps/map8_e/screens0_y0_x1.lz"

Map8EScreens3_Y0X1::
    INCBIN "maps/map8_e/screens3_y0_x1.lz"

; LZSS-compressed: 267 bytes that expand to 360 (E-0016, E-0017)
Map8EScreens0_Y0X2::
    INCBIN "maps/map8_e/screens0_y0_x2.lz"

; LZSS-compressed: 203 bytes that expand to 360 (E-0016, E-0017)
Map8EScreens0_Y1X0::
    INCBIN "maps/map8_e/screens0_y1_x0.lz"

; LZSS-compressed: 175 bytes that expand to 360 (E-0016, E-0017)
Map8EScreens0_Y1X1::
    INCBIN "maps/map8_e/screens0_y1_x1.lz"

; LZSS-compressed: 256 bytes that expand to 360 (E-0016, E-0017)
Map8EScreens0_Y1X2::
    INCBIN "maps/map8_e/screens0_y1_x2.lz"

; LZSS-compressed: 254 bytes that expand to 360 (E-0016, E-0017)
Map8EScreens0_Y2X0::
    INCBIN "maps/map8_e/screens0_y2_x0.lz"

; LZSS-compressed: 247 bytes that expand to 360 (E-0016, E-0017)
Map8EScreens0_Y2X1::
    INCBIN "maps/map8_e/screens0_y2_x1.lz"

; LZSS-compressed: 251 bytes that expand to 360 (E-0016, E-0017)
Map8EScreens0_Y2X2::
    INCBIN "maps/map8_e/screens0_y2_x2.lz"

; LZSS-compressed: 113 bytes that expand to 360 (E-0016, E-0017)
Map8EAttrs0_Y0X0::
    INCBIN "maps/map8_e/attrs0_y0_x0.lz"

; LZSS-compressed: 107 bytes that expand to 360 (E-0016, E-0017)
Map8EAttrs0_Y0X1::
    INCBIN "maps/map8_e/attrs0_y0_x1.lz"

Map8EAttrs3_Y0X1::
    INCBIN "maps/map8_e/attrs3_y0_x1.lz"

; LZSS-compressed: 130 bytes that expand to 360 (E-0016, E-0017)
Map8EAttrs0_Y0X2::
    INCBIN "maps/map8_e/attrs0_y0_x2.lz"

Map8EAttrs0_Y1X0::
    INCBIN "maps/map8_e/attrs0_y1_x0.lz"

; LZSS-compressed: 82 bytes that expand to 360 (E-0016, E-0017)
Map8EAttrs0_Y1X1::
    INCBIN "maps/map8_e/attrs0_y1_x1.lz"

; LZSS-compressed: 120 bytes that expand to 360 (E-0016, E-0017)
Map8EAttrs0_Y1X2::
    INCBIN "maps/map8_e/attrs0_y1_x2.lz"

; LZSS-compressed: 113 bytes that expand to 360 (E-0016, E-0017)
Map8EAttrs0_Y2X0::
    INCBIN "maps/map8_e/attrs0_y2_x0.lz"

; LZSS-compressed: 92 bytes that expand to 360 (E-0016, E-0017)
Map8EAttrs0_Y2X1::
    INCBIN "maps/map8_e/attrs0_y2_x1.lz"

Map8EAttrs0_Y2X2::
    INCBIN "maps/map8_e/attrs0_y2_x2.lz"

; compressed tileset of map $94 (the first map record using it)
; LZSS-compressed: 1084 bytes that expand to 1792 (E-0016, E-0017)
Map94Tileset::
    INCBIN "maps/map94/tileset.lz"

; 9 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map94Screens0::
    dfar Map94Screens0_Y0X0 ; entry 0
    dfar Map94Screens0_Y0X1 ; entry 1
    dfar Map94Screens0_Y0X2 ; entry 2
    dfar Map94Screens0_Y1X0 ; entry 3
    dfar Map94Screens0_Y1X1 ; entry 4
    dfar Map94Screens0_Y1X2 ; entry 5
    dfar Map94Screens0_Y2X0 ; entry 6
    dfar Map94Screens0_Y2X1 ; entry 7
    dfar Map94Screens0_Y2X2 ; entry 8

Map94Attrs0::
    dfar Map94Attrs0_Y0X0 ; entry 0
    dfar Map94Attrs0_Y0X1 ; entry 1
    dfar Map94Attrs0_Y0X2 ; entry 2
    dfar Map94Attrs0_Y1X0 ; entry 3
    dfar Map94Attrs0_Y1X1 ; entry 4
    dfar Map94Attrs0_Y1X2 ; entry 5
    dfar Map94Attrs0_Y2X0 ; entry 6
    dfar Map94Attrs0_Y2X1 ; entry 7
    dfar Map94Attrs0_Y2X2 ; entry 8

; LZSS-compressed: 193 bytes that expand to 360 (E-0016, E-0017)
Map94Screens0_Y0X0::
    INCBIN "maps/map94/screens0_y0_x0.lz"

; LZSS-compressed: 210 bytes that expand to 360 (E-0016, E-0017)
Map94Screens0_Y0X1::
    INCBIN "maps/map94/screens0_y0_x1.lz"

Map94Screens0_Y0X2::
    INCBIN "maps/map94/screens0_y0_x2.lz"

; LZSS-compressed: 215 bytes that expand to 360 (E-0016, E-0017)
Map94Screens0_Y1X0::
    INCBIN "maps/map94/screens0_y1_x0.lz"

; LZSS-compressed: 194 bytes that expand to 360 (E-0016, E-0017)
Map94Screens0_Y1X1::
    INCBIN "maps/map94/screens0_y1_x1.lz"

Map94Screens0_Y1X2::
    INCBIN "maps/map94/screens0_y1_x2.lz"

; LZSS-compressed: 188 bytes that expand to 360 (E-0016, E-0017)
Map94Screens0_Y2X0::
    INCBIN "maps/map94/screens0_y2_x0.lz"

; LZSS-compressed: 229 bytes that expand to 360 (E-0016, E-0017)
Map94Screens0_Y2X1::
    INCBIN "maps/map94/screens0_y2_x1.lz"

; LZSS-compressed: 231 bytes that expand to 360 (E-0016, E-0017)
Map94Screens0_Y2X2::
    INCBIN "maps/map94/screens0_y2_x2.lz"

; LZSS-compressed: 48 bytes that expand to 360 (E-0016, E-0017)
Map94Attrs0_Y0X0::
    db $68, $01, $00, $04, $00, $00, $0f, $1a, $01, $01, $00, $2a, $06, $00, $26, $0f
    db $2f, $02, $00, $7c, $07, $00, $74, $0f, $07, $00, $7c, $08, $00, $84, $04, $00
    db $a2, $0f, $4d, $00, $76, $0f, $19, $00, $76, $04, $00, $00, $0e, $00, $3a, $18

; LZSS-compressed: 55 bytes that expand to 360 (E-0016, E-0017)
Map94Attrs0_Y0X1::
    db $68, $01, $00, $04, $00, $00, $0f, $1a, $01, $01, $00, $2a, $06, $00, $26, $0f
    db $2f, $02, $00, $7c, $07, $00, $74, $0f, $07, $00, $82, $04, $00, $80, $08, $00
    db $a2, $0f, $07, $00, $7e, $0a, $00, $ca, $0f, $29, $00, $7a, $0f, $15, $00, $76
    db $04, $00, $00, $0e, $00, $3a, $18

; LZSS-compressed: 57 bytes that expand to 360 (E-0016, E-0017)
Map94Attrs0_Y0X2::
    db $68, $01, $00, $04, $00, $00, $0f, $1a, $01, $01, $00, $2a, $06, $00, $26, $0f
    db $2f, $02, $00, $7c, $07, $00, $74, $0f, $07, $00, $7c, $02, $05, $05, $00, $80
    db $08, $00, $a2, $0f, $07, $00, $7e, $0a, $00, $ca, $0f, $29, $00, $7a, $0f, $15
    db $00, $76, $04, $00, $00, $0e, $00, $3a, $18

; LZSS-compressed: 76 bytes that expand to 360 (E-0016, E-0017)
Map94Attrs0_Y1X0::
    INCBIN "maps/map94/attrs0_y1_x0.lz"

; LZSS-compressed: 74 bytes that expand to 360 (E-0016, E-0017)
Map94Attrs0_Y1X1::
    INCBIN "maps/map94/attrs0_y1_x1.lz"

; LZSS-compressed: 80 bytes that expand to 360 (E-0016, E-0017)
Map94Attrs0_Y1X2::
    INCBIN "maps/map94/attrs0_y1_x2.lz"

; LZSS-compressed: 68 bytes that expand to 360 (E-0016, E-0017)
Map94Attrs0_Y2X0::
    INCBIN "maps/map94/attrs0_y2_x0.lz"

Map94Attrs0_Y2X1::
    INCBIN "maps/map94/attrs0_y2_x1.lz"

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
Map94Attrs0_Y2X2::
    INCBIN "maps/map94/attrs0_y2_x2.lz"

; 6 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map95Screens0::
    dfar Map95Screens0_Y0X0 ; entry 0
    dfar Map95Screens0_Y0X1 ; entry 1
    dfar Map95Screens0_Y1X0 ; entry 2
    dfar Map95Screens0_Y1X1 ; entry 3
    dfar Map95Screens0_Y2X0 ; entry 4
    dfar Map95Screens0_Y2X1 ; entry 5

Map95Attrs0::
    dfar Map95Attrs0_Y0X0 ; entry 0
    dfar Map95Attrs0_Y0X1 ; entry 1
    dfar Map95Attrs0_Y1X0 ; entry 2
    dfar Map95Attrs0_Y1X1 ; entry 3
    dfar Map95Attrs0_Y2X0 ; entry 4
    dfar Map95Attrs0_Y2X1 ; entry 5

; LZSS-compressed: 196 bytes that expand to 360 (E-0016, E-0017)
Map95Screens0_Y0X0::
    INCBIN "maps/map95/screens0_y0_x0.lz"

; LZSS-compressed: 174 bytes that expand to 360 (E-0016, E-0017)
Map95Screens0_Y0X1::
    INCBIN "maps/map95/screens0_y0_x1.lz"

; LZSS-compressed: 169 bytes that expand to 360 (E-0016, E-0017)
Map95Screens0_Y1X0::
    INCBIN "maps/map95/screens0_y1_x0.lz"

; LZSS-compressed: 178 bytes that expand to 360 (E-0016, E-0017)
Map95Screens0_Y1X1::
    INCBIN "maps/map95/screens0_y1_x1.lz"

; LZSS-compressed: 180 bytes that expand to 360 (E-0016, E-0017)
Map95Screens0_Y2X0::
    INCBIN "maps/map95/screens0_y2_x0.lz"

; LZSS-compressed: 193 bytes that expand to 360 (E-0016, E-0017)
Map95Screens0_Y2X1::
    INCBIN "maps/map95/screens0_y2_x1.lz"

; LZSS-compressed: 81 bytes that expand to 360 (E-0016, E-0017)
Map95Attrs0_Y0X0::
    INCBIN "maps/map95/attrs0_y0_x0.lz"

; LZSS-compressed: 78 bytes that expand to 360 (E-0016, E-0017)
Map95Attrs0_Y0X1::
    INCBIN "maps/map95/attrs0_y0_x1.lz"

; LZSS-compressed: 74 bytes that expand to 360 (E-0016, E-0017)
Map95Attrs0_Y1X0::
    INCBIN "maps/map95/attrs0_y1_x0.lz"

; LZSS-compressed: 73 bytes that expand to 360 (E-0016, E-0017)
Map95Attrs0_Y1X1::
    INCBIN "maps/map95/attrs0_y1_x1.lz"

Map95Attrs0_Y2X0::
    INCBIN "maps/map95/attrs0_y2_x0.lz"

Map95Attrs0_Y2X1::
    INCBIN "maps/map95/attrs0_y2_x1.lz"

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map96Screens0::
    dfar Map96Screens0_Y0X0 ; entry 0
    dfar Map96Screens0_Y0X1 ; entry 1
    dfar Map96Screens0_Y1X0 ; entry 2
    dfar Map96Screens0_Y1X1 ; entry 3

Map96Attrs0::
    dfar Map96Attrs0_Y0X0 ; entry 0
    dfar Map96Attrs0_Y0X1 ; entry 1
    dfar Map96Attrs0_Y1X0 ; entry 2
    dfar Map96Attrs0_Y1X1 ; entry 3

; LZSS-compressed: 182 bytes that expand to 360 (E-0016, E-0017)
Map96Screens0_Y0X0::
    INCBIN "maps/map96/screens0_y0_x0.lz"

; LZSS-compressed: 190 bytes that expand to 360 (E-0016, E-0017)
Map96Screens0_Y0X1::
    INCBIN "maps/map96/screens0_y0_x1.lz"

; LZSS-compressed: 194 bytes that expand to 360 (E-0016, E-0017)
Map96Screens0_Y1X0::
    INCBIN "maps/map96/screens0_y1_x0.lz"

; LZSS-compressed: 160 bytes that expand to 360 (E-0016, E-0017)
Map96Screens0_Y1X1::
    INCBIN "maps/map96/screens0_y1_x1.lz"

; LZSS-compressed: 73 bytes that expand to 360 (E-0016, E-0017)
Map96Attrs0_Y0X0::
    INCBIN "maps/map96/attrs0_y0_x0.lz"

; LZSS-compressed: 83 bytes that expand to 360 (E-0016, E-0017)
Map96Attrs0_Y0X1::
    INCBIN "maps/map96/attrs0_y0_x1.lz"

; LZSS-compressed: 79 bytes that expand to 360 (E-0016, E-0017)
Map96Attrs0_Y1X0::
    INCBIN "maps/map96/attrs0_y1_x0.lz"

; LZSS-compressed: 70 bytes that expand to 360 (E-0016, E-0017)
Map96Attrs0_Y1X1::
    INCBIN "maps/map96/attrs0_y1_x1.lz"
    ds $258, $00
