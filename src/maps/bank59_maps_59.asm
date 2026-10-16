; ROM bank $59: map screens, attributes and tilesets
; The annotated listing of this bank is build/listing/bank59.asm.

SECTION "Bank 59", ROMX
    db $59

; compressed tileset of map $A8 (the first map record using it)
; LZSS-compressed: 1186 bytes that expand to 1856 (E-0016, E-0017)
MapA8Tileset::
    INCBIN "maps/mapa8/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
MapA8Palettes::
    dw $7da0, $7fff, $7fe0, $0063 ; entry 0
    dw $0160, $3fbf, $03e2, $0000 ; entry 1
    dw $012f, $3fbf, $03e2, $0000 ; entry 2
    dw $318c, $7fff, $03e2, $0000 ; entry 3
    dw $0160, $3fbf, $03e2, $0000 ; entry 4
    dw $0171, $3fbf, $03e2, $0000 ; entry 5
    dw $1415, $7fff, $03e2, $0000 ; entry 6
    dw $318c, $7fff, $5294, $0000 ; entry 7

; 36 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
MapA8Screens0::
    dfar MapA8Screens0_Y0X0 ; entry 0
    dfar MapA8Screens0_Y0X1 ; entry 1
    dfar MapA8Screens0_Y0X2 ; entry 2
    dfar MapA8Screens0_Y0X3 ; entry 3
    dfar MapA8Screens0_Y0X4 ; entry 4
    dfar MapA8Screens0_Y0X5 ; entry 5
    dfar MapA8Screens0_Y1X0 ; entry 6
    dfar MapA8Screens0_Y1X1 ; entry 7
    dfar MapA8Screens0_Y1X2 ; entry 8
    dfar MapA8Screens0_Y1X3 ; entry 9
    dfar MapA8Screens0_Y1X4 ; entry 10
    dfar MapA8Screens0_Y1X5 ; entry 11
    dfar MapA8Screens0_Y2X0 ; entry 12
    dfar MapA8Screens0_Y2X1 ; entry 13
    dfar MapA8Screens0_Y2X2 ; entry 14
    dfar MapA8Screens0_Y2X3 ; entry 15
    dfar MapA8Screens0_Y2X4 ; entry 16
    dfar MapA8Screens0_Y2X5 ; entry 17
    dfar MapA8Screens0_Y3X0 ; entry 18
    dfar MapA8Screens0_Y3X1 ; entry 19
    dfar MapA8Screens0_Y3X2 ; entry 20
    dfar MapA8Screens0_Y3X3 ; entry 21
    dfar MapA8Screens0_Y3X4 ; entry 22
    dfar MapA8Screens0_Y3X5 ; entry 23
    dfar MapA8Screens0_Y4X0 ; entry 24
    dfar MapA8Screens0_Y4X1 ; entry 25
    dfar MapA8Screens0_Y4X2 ; entry 26
    dfar MapA8Screens0_Y4X3 ; entry 27
    dfar MapA8Screens0_Y4X4 ; entry 28
    dfar MapA8Screens0_Y4X5 ; entry 29
    dfar MapA8Screens0_Y5X0 ; entry 30
    dfar MapA8Screens0_Y5X1 ; entry 31
    dfar MapA8Screens0_Y5X2 ; entry 32
    dfar MapA8Screens0_Y5X3 ; entry 33
    dfar MapA8Screens0_Y5X4 ; entry 34
    dfar MapA8Screens0_Y5X5 ; entry 35

MapA8Attrs0::
    dfar MapA8Attrs0_Y0X0 ; entry 0
    dfar MapA8Attrs0_Y0X1 ; entry 1
    dfar MapA8Attrs0_Y0X2 ; entry 2
    dfar MapA8Attrs0_Y0X3 ; entry 3
    dfar MapA8Attrs0_Y0X4 ; entry 4
    dfar MapA8Attrs0_Y0X5 ; entry 5
    dfar MapA8Attrs0_Y1X0 ; entry 6
    dfar MapA8Attrs0_Y1X1 ; entry 7
    dfar MapA8Attrs0_Y1X2 ; entry 8
    dfar MapA8Attrs0_Y1X3 ; entry 9
    dfar MapA8Attrs0_Y1X4 ; entry 10
    dfar MapA8Attrs0_Y1X5 ; entry 11
    dfar MapA8Attrs0_Y2X0 ; entry 12
    dfar MapA8Attrs0_Y2X1 ; entry 13
    dfar MapA8Attrs0_Y2X2 ; entry 14
    dfar MapA8Attrs0_Y2X3 ; entry 15
    dfar MapA8Attrs0_Y2X4 ; entry 16
    dfar MapA8Attrs0_Y2X5 ; entry 17
    dfar MapA8Attrs0_Y3X0 ; entry 18
    dfar MapA8Attrs0_Y3X1 ; entry 19
    dfar MapA8Attrs0_Y3X2 ; entry 20
    dfar MapA8Attrs0_Y3X3 ; entry 21
    dfar MapA8Attrs0_Y3X4 ; entry 22
    dfar MapA8Attrs0_Y3X5 ; entry 23
    dfar MapA8Attrs0_Y4X0 ; entry 24
    dfar MapA8Attrs0_Y4X1 ; entry 25
    dfar MapA8Attrs0_Y4X2 ; entry 26
    dfar MapA8Attrs0_Y4X3 ; entry 27
    dfar MapA8Attrs0_Y4X4 ; entry 28
    dfar MapA8Attrs0_Y4X5 ; entry 29
    dfar MapA8Attrs0_Y5X0 ; entry 30
    dfar MapA8Attrs0_Y5X1 ; entry 31
    dfar MapA8Attrs0_Y5X2 ; entry 32
    dfar MapA8Attrs0_Y5X3 ; entry 33
    dfar MapA8Attrs0_Y5X4 ; entry 34
    dfar MapA8Attrs0_Y5X5 ; entry 35

; LZSS-compressed: 112 bytes that expand to 360 (E-0016, E-0017)
MapA8Screens0_Y0X0::
    INCBIN "maps/mapa8/screens0_y0_x0.lz"

; LZSS-compressed: 137 bytes that expand to 360 (E-0016, E-0017)
MapA8Screens0_Y0X1::
    INCBIN "maps/mapa8/screens0_y0_x1.lz"

; LZSS-compressed: 136 bytes that expand to 360 (E-0016, E-0017)
MapA8Screens0_Y0X2::
    INCBIN "maps/mapa8/screens0_y0_x2.lz"

; LZSS-compressed: 89 bytes that expand to 360 (E-0016, E-0017)
MapA8Screens0_Y0X3::
    INCBIN "maps/mapa8/screens0_y0_x3.lz"

; LZSS-compressed: 29 bytes that expand to 360 (E-0016, E-0017)
MapA8Screens0_Y0X4::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

MapA8Screens0_Y0X5::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

MapA8Screens0_Y1X0::
    INCBIN "maps/mapa8/screens0_y1_x0.lz"

; LZSS-compressed: 158 bytes that expand to 360 (E-0016, E-0017)
MapA8Screens0_Y1X1::
    INCBIN "maps/mapa8/screens0_y1_x1.lz"

; LZSS-compressed: 80 bytes that expand to 360 (E-0016, E-0017)
MapA8Screens0_Y1X2::
    INCBIN "maps/mapa8/screens0_y1_x2.lz"

; LZSS-compressed: 130 bytes that expand to 360 (E-0016, E-0017)
MapA8Screens0_Y1X3::
    INCBIN "maps/mapa8/screens0_y1_x3.lz"

; LZSS-compressed: 114 bytes that expand to 360 (E-0016, E-0017)
MapA8Screens0_Y1X4::
    INCBIN "maps/mapa8/screens0_y1_x4.lz"

; LZSS-compressed: 139 bytes that expand to 360 (E-0016, E-0017)
MapA8Screens0_Y1X5::
    INCBIN "maps/mapa8/screens0_y1_x5.lz"

; LZSS-compressed: 120 bytes that expand to 360 (E-0016, E-0017)
MapA8Screens0_Y2X0::
    INCBIN "maps/mapa8/screens0_y2_x0.lz"

; LZSS-compressed: 137 bytes that expand to 360 (E-0016, E-0017)
MapA8Screens0_Y2X1::
    INCBIN "maps/mapa8/screens0_y2_x1.lz"

; LZSS-compressed: 128 bytes that expand to 360 (E-0016, E-0017)
MapA8Screens0_Y2X2::
    INCBIN "maps/mapa8/screens0_y2_x2.lz"

MapA8Screens0_Y2X3::
    INCBIN "maps/mapa8/screens0_y2_x3.lz"

; LZSS-compressed: 129 bytes that expand to 360 (E-0016, E-0017)
MapA8Screens0_Y2X4::
    INCBIN "maps/mapa8/screens0_y2_x4.lz"

; LZSS-compressed: 81 bytes that expand to 360 (E-0016, E-0017)
MapA8Screens0_Y2X5::
    INCBIN "maps/mapa8/screens0_y2_x5.lz"

; LZSS-compressed: 139 bytes that expand to 360 (E-0016, E-0017)
MapA8Screens0_Y3X0::
    INCBIN "maps/mapa8/screens0_y3_x0.lz"

; LZSS-compressed: 114 bytes that expand to 360 (E-0016, E-0017)
MapA8Screens0_Y3X1::
    INCBIN "maps/mapa8/screens0_y3_x1.lz"

; LZSS-compressed: 118 bytes that expand to 360 (E-0016, E-0017)
MapA8Screens0_Y3X2::
    INCBIN "maps/mapa8/screens0_y3_x2.lz"

; LZSS-compressed: 137 bytes that expand to 360 (E-0016, E-0017)
MapA8Screens0_Y3X3::
    INCBIN "maps/mapa8/screens0_y3_x3.lz"

; LZSS-compressed: 130 bytes that expand to 360 (E-0016, E-0017)
MapA8Screens0_Y3X4::
    INCBIN "maps/mapa8/screens0_y3_x4.lz"

; LZSS-compressed: 156 bytes that expand to 360 (E-0016, E-0017)
MapA8Screens0_Y3X5::
    INCBIN "maps/mapa8/screens0_y3_x5.lz"

; LZSS-compressed: 88 bytes that expand to 360 (E-0016, E-0017)
MapA8Screens0_Y4X0::
    INCBIN "maps/mapa8/screens0_y4_x0.lz"

; LZSS-compressed: 127 bytes that expand to 360 (E-0016, E-0017)
MapA8Screens0_Y4X1::
    INCBIN "maps/mapa8/screens0_y4_x1.lz"

; LZSS-compressed: 128 bytes that expand to 360 (E-0016, E-0017)
MapA8Screens0_Y4X2::
    INCBIN "maps/mapa8/screens0_y4_x2.lz"

; LZSS-compressed: 131 bytes that expand to 360 (E-0016, E-0017)
MapA8Screens0_Y4X3::
    INCBIN "maps/mapa8/screens0_y4_x3.lz"

; LZSS-compressed: 150 bytes that expand to 360 (E-0016, E-0017)
MapA8Screens0_Y4X4::
    INCBIN "maps/mapa8/screens0_y4_x4.lz"

; LZSS-compressed: 153 bytes that expand to 360 (E-0016, E-0017)
MapA8Screens0_Y4X5::
    INCBIN "maps/mapa8/screens0_y4_x5.lz"

; LZSS-compressed: 29 bytes that expand to 360 (E-0016, E-0017)
MapA8Screens0_Y5X0::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

MapA8Screens0_Y5X1::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

MapA8Screens0_Y5X2::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

MapA8Screens0_Y5X3::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

; LZSS-compressed: 105 bytes that expand to 360 (E-0016, E-0017)
MapA8Screens0_Y5X4::
    INCBIN "maps/mapa8/screens0_y5_x4.lz"

; LZSS-compressed: 147 bytes that expand to 360 (E-0016, E-0017)
MapA8Screens0_Y5X5::
    INCBIN "maps/mapa8/screens0_y5_x5.lz"

; LZSS-compressed: 50 bytes that expand to 360 (E-0016, E-0017)
MapA8Attrs0_Y0X0::
    db $68, $01, $00, $0b, $00, $00, $0f, $22, $09, $00, $36, $01, $00, $28, $0f, $09
    db $00, $36, $02, $00, $4a, $0f, $09, $00, $58, $08, $00, $72, $0f, $31, $0a, $0a
    db $00, $b8, $0f, $15, $00, $ca, $0c, $00, $f0, $0f, $07, $00, $ca, $0a, $00, $18
    db $1f, $29

; LZSS-compressed: 55 bytes that expand to 360 (E-0016, E-0017)
MapA8Attrs0_Y0X1::
    db $68, $01, $00, $0b, $00, $00, $0f, $14, $09, $09, $09, $09, $00, $1e, $08, $0a
    db $0a, $0a, $0a, $00, $28, $0f, $05, $00, $50, $06, $00, $38, $00, $00, $4e, $0f
    db $0f, $00, $5e, $02, $00, $76, $0f, $0f, $00, $5c, $0f, $15, $00, $5a, $04, $00
    db $c8, $0f, $4d, $00, $00, $1f, $19

; LZSS-compressed: 80 bytes that expand to 360 (E-0016, E-0017)
MapA8Attrs0_Y0X2::
    INCBIN "maps/mapa8/attrs0_y0_x2.lz"

; LZSS-compressed: 52 bytes that expand to 360 (E-0016, E-0017)
MapA8Attrs0_Y0X3::
    db $68, $01, $00, $0b, $00, $00, $0f, $3c, $0a, $00, $50, $01, $00, $42, $0f, $3d
    db $00, $54, $0a, $00, $a0, $0f, $03, $09, $09, $00, $b8, $0f, $11, $09, $00, $f0
    db $01, $00, $e2, $0f, $13, $00, $e0, $0f, $01, $00, $e0, $0f, $01, $00, $00, $0c
    db $00, $40, $1f, $01

; LZSS-compressed: 20 bytes that expand to 360 (E-0016, E-0017)
MapA8Attrs0_Y0X4::
    db $68, $01, $00, $0b, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

MapA8Attrs0_Y0X5::
    db $68, $01, $00, $0b, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

; LZSS-compressed: 62 bytes that expand to 360 (E-0016, E-0017)
MapA8Attrs0_Y1X0::
    db $68, $01, $00, $0b, $0b, $0a, $00, $02, $01, $09, $00, $08, $07, $00, $00, $0f
    db $07, $00, $08, $08, $00, $26, $0f, $09, $00, $04, $0a, $00, $50, $0f, $03, $00
    db $78, $00, $00, $02, $0a, $00, $78, $0f, $0d, $00, $04, $04, $00, $a0, $0f, $11
    db $00, $02, $00, $00, $c8, $0f, $2d, $00, $ce, $0a, $00, $16, $1f, $2b

; LZSS-compressed: 65 bytes that expand to 360 (E-0016, E-0017)
MapA8Attrs0_Y1X1::
    INCBIN "maps/mapa8/attrs0_y1_x1.lz"

; LZSS-compressed: 51 bytes that expand to 360 (E-0016, E-0017)
MapA8Attrs0_Y1X2::
    db $68, $01, $00, $0a, $00, $00, $09, $09, $00, $0e, $01, $00, $00, $0f, $0d, $00
    db $0e, $02, $00, $26, $0f, $2b, $00, $10, $08, $00, $70, $0f, $0d, $00, $7a, $0f
    db $11, $00, $00, $0a, $00, $0c, $02, $00, $c8, $0f, $37, $00, $0e, $0f, $13, $00
    db $0c, $0f, $09

; LZSS-compressed: 67 bytes that expand to 360 (E-0016, E-0017)
MapA8Attrs0_Y1X3::
    INCBIN "maps/mapa8/attrs0_y1_x3.lz"

MapA8Attrs0_Y1X4::
    INCBIN "maps/mapa8/attrs0_y1_x4.lz"

; LZSS-compressed: 69 bytes that expand to 360 (E-0016, E-0017)
MapA8Attrs0_Y1X5::
    INCBIN "maps/mapa8/attrs0_y1_x5.lz"

; LZSS-compressed: 57 bytes that expand to 360 (E-0016, E-0017)
MapA8Attrs0_Y2X0::
    db $68, $01, $00, $0b, $0b, $0b, $0b, $0a, $00, $04, $0b, $00, $00, $0f, $2b, $00
    db $04, $02, $01, $01, $00, $46, $0f, $0f, $01, $00, $7c, $03, $00, $70, $0f, $0b
    db $00, $7c, $04, $00, $80, $06, $00, $a0, $0f, $0f, $00, $58, $02, $00, $c8, $0f
    db $0f, $00, $9a, $0f, $29, $00, $c2, $0f, $1b

; LZSS-compressed: 63 bytes that expand to 360 (E-0016, E-0017)
MapA8Attrs0_Y2X1::
    db $68, $01, $00, $0a, $00, $00, $03, $09, $09, $09, $09, $00, $00, $04, $00, $00
    db $0f, $07, $00, $08, $00, $00, $08, $0c, $00, $2e, $0f, $09, $00, $0a, $08, $00
    db $56, $0e, $00, $56, $06, $00, $72, $0f, $17, $00, $0a, $04, $00, $a4, $0f, $0f
    db $00, $0a, $02, $00, $cc, $0f, $01, $00, $a2, $0f, $25, $00, $9e, $0f, $29

; LZSS-compressed: 70 bytes that expand to 360 (E-0016, E-0017)
MapA8Attrs0_Y2X2::
    INCBIN "maps/mapa8/attrs0_y2_x2.lz"

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
MapA8Attrs0_Y2X3::
    INCBIN "maps/mapa8/attrs0_y2_x3.lz"

; LZSS-compressed: 84 bytes that expand to 360 (E-0016, E-0017)
MapA8Attrs0_Y2X4::
    INCBIN "maps/mapa8/attrs0_y2_x4.lz"

; LZSS-compressed: 48 bytes that expand to 360 (E-0016, E-0017)
MapA8Attrs0_Y2X5::
    db $68, $01, $00, $0a, $00, $00, $07, $0b, $00, $0c, $03, $00, $00, $0f, $31, $00
    db $0c, $04, $00, $4c, $0f, $4d, $00, $0c, $04, $09, $09, $00, $b6, $0f, $15, $00
    db $c8, $04, $00, $08, $06, $00, $f0, $0f, $05, $00, $f2, $0c, $00, $18, $1f, $29

; LZSS-compressed: 47 bytes that expand to 360 (E-0016, E-0017)
MapA8Attrs0_Y3X0::
    db $68, $01, $00, $0b, $0b, $01, $00, $02, $09, $0a, $0a, $0a, $0a, $00, $00, $0f
    db $03, $00, $00, $0a, $00, $24, $0f, $15, $00, $0e, $00, $00, $50, $0f, $3b, $01
    db $01, $00, $a0, $0f, $4d, $00, $b0, $02, $00, $b8, $0c, $00, $16, $1f, $2b

; LZSS-compressed: 62 bytes that expand to 360 (E-0016, E-0017)
MapA8Attrs0_Y3X1::
    db $68, $01, $00, $02, $00, $00, $01, $01, $00, $06, $09, $00, $00, $0f, $4d, $00
    db $10, $06, $00, $18, $0a, $00, $78, $0f, $01, $00, $76, $06, $00, $18, $08, $00
    db $a2, $0f, $01, $00, $10, $0c, $00, $d2, $06, $00, $d0, $0e, $00, $12, $06, $00
    db $16, $08, $00, $f8, $0f, $01, $00, $a0, $0f, $19, $00, $78, $0f, $09

; LZSS-compressed: 56 bytes that expand to 360 (E-0016, E-0017)
MapA8Attrs0_Y3X2::
    db $68, $01, $00, $01, $00, $00, $05, $02, $00, $0a, $05, $00, $00, $0f, $0b, $00
    db $08, $06, $00, $28, $0f, $0d, $00, $06, $04, $00, $50, $0f, $11, $00, $78, $0f
    db $2d, $00, $76, $0f, $01, $00, $c8, $0f, $03, $00, $4e, $0f, $27, $00, $4c, $0f
    db $05, $00, $4e, $0c, $00, $4a, $0f, $01

; LZSS-compressed: 72 bytes that expand to 360 (E-0016, E-0017)
MapA8Attrs0_Y3X3::
    INCBIN "maps/mapa8/attrs0_y3_x3.lz"

; LZSS-compressed: 79 bytes that expand to 360 (E-0016, E-0017)
MapA8Attrs0_Y3X4::
    INCBIN "maps/mapa8/attrs0_y3_x4.lz"

; LZSS-compressed: 96 bytes that expand to 360 (E-0016, E-0017)
MapA8Attrs0_Y3X5::
    INCBIN "maps/mapa8/attrs0_y3_x5.lz"

; LZSS-compressed: 35 bytes that expand to 360 (E-0016, E-0017)
MapA8Attrs0_Y4X0::
    db $68, $01, $00, $0b, $0b, $01, $00, $02, $0d, $00, $00, $0f, $4d, $00, $38, $0f
    db $1b, $00, $3c, $0e, $00, $a0, $0f, $2d, $00, $3c, $0c, $00, $f0, $0f, $2f, $00
    db $40, $1f, $0f

; LZSS-compressed: 49 bytes that expand to 360 (E-0016, E-0017)
MapA8Attrs0_Y4X1::
    db $68, $01, $00, $01, $00, $00, $07, $02, $00, $0c, $03, $00, $00, $0f, $0d, $00
    db $0a, $04, $00, $28, $0f, $37, $00, $0a, $02, $00, $78, $0f, $37, $00, $22, $0f
    db $13, $00, $0c, $0f, $13, $00, $0c, $04, $00, $16, $1f, $03, $0b, $00, $40, $1f
    db $14

; LZSS-compressed: 62 bytes that expand to 360 (E-0016, E-0017)
MapA8Attrs0_Y4X2::
    db $68, $01, $00, $02, $00, $00, $01, $01, $00, $06, $09, $00, $00, $0f, $4d, $00
    db $10, $06, $00, $18, $0a, $00, $78, $0f, $09, $06, $06, $06, $06, $00, $74, $08
    db $00, $a4, $0f, $05, $00, $c4, $0f, $1b, $0b, $00, $fe, $01, $00, $f0, $0f, $07
    db $00, $fe, $02, $00, $1e, $14, $00, $18, $1f, $01, $00, $32, $1f, $15

; LZSS-compressed: 73 bytes that expand to 360 (E-0016, E-0017)
MapA8Attrs0_Y4X3::
    INCBIN "maps/mapa8/attrs0_y4_x3.lz"

; LZSS-compressed: 75 bytes that expand to 360 (E-0016, E-0017)
MapA8Attrs0_Y4X4::
    INCBIN "maps/mapa8/attrs0_y4_x4.lz"

; LZSS-compressed: 90 bytes that expand to 360 (E-0016, E-0017)
MapA8Attrs0_Y4X5::
    INCBIN "maps/mapa8/attrs0_y4_x5.lz"

; LZSS-compressed: 20 bytes that expand to 360 (E-0016, E-0017)
MapA8Attrs0_Y5X0::
    db $68, $01, $00, $0b, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

MapA8Attrs0_Y5X1::
    db $68, $01, $00, $0b, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

MapA8Attrs0_Y5X2::
    db $68, $01, $00, $0b, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

MapA8Attrs0_Y5X3::
    db $68, $01, $00, $0b, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

; LZSS-compressed: 66 bytes that expand to 360 (E-0016, E-0017)
MapA8Attrs0_Y5X4::
    INCBIN "maps/mapa8/attrs0_y5_x4.lz"

; LZSS-compressed: 83 bytes that expand to 360 (E-0016, E-0017)
MapA8Attrs0_Y5X5::
    INCBIN "maps/mapa8/attrs0_y5_x5.lz"

; compressed tileset of map $A9 (the first map record using it)
; LZSS-compressed: 1314 bytes that expand to 1488 (E-0016, E-0017)
MapA9Tileset::
    INCBIN "maps/mapa9/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
MapA9Palettes::
    dw $192c, $7fff, $31cf, $0000 ; entry 0
    dw $0175, $5b7f, $1e7e, $0009 ; entry 1
    dw $01c4, $3f7f, $03e7, $00a0 ; entry 2
    dw $192c, $7fff, $03e7, $0000 ; entry 3
    dw $001b, $2bff, $023f, $0000 ; entry 4
    dw $31cf, $7da0, $5ad6, $0000 ; entry 5
    dw $0cec, $3f7f, $0175, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
MapA9Screens0::
    dfar MapA9Screens0_Y0X0 ; entry 0
    dfar MapA9Screens0_Y0X1 ; entry 1
    dfar MapA9Screens0_Y1X0 ; entry 2
    dfar MapA9Screens0_Y1X1 ; entry 3

MapA9Attrs0::
    dfar MapA9Attrs0_Y0X0 ; entry 0
    dfar MapA9Attrs0_Y0X1 ; entry 1
    dfar MapA9Attrs0_Y1X0 ; entry 2
    dfar MapA9Attrs0_Y1X1 ; entry 3

; LZSS-compressed: 249 bytes that expand to 360 (E-0016, E-0017)
MapA9Screens0_Y0X0::
    INCBIN "maps/mapa9/screens0_y0_x0.lz"

; LZSS-compressed: 255 bytes that expand to 360 (E-0016, E-0017)
MapA9Screens0_Y0X1::
    INCBIN "maps/mapa9/screens0_y0_x1.lz"

; LZSS-compressed: 216 bytes that expand to 360 (E-0016, E-0017)
MapA9Screens0_Y1X0::
    INCBIN "maps/mapa9/screens0_y1_x0.lz"

; LZSS-compressed: 212 bytes that expand to 360 (E-0016, E-0017)
MapA9Screens0_Y1X1::
    INCBIN "maps/mapa9/screens0_y1_x1.lz"

; LZSS-compressed: 81 bytes that expand to 360 (E-0016, E-0017)
MapA9Attrs0_Y0X0::
    INCBIN "maps/mapa9/attrs0_y0_x0.lz"

; LZSS-compressed: 90 bytes that expand to 360 (E-0016, E-0017)
MapA9Attrs0_Y0X1::
    INCBIN "maps/mapa9/attrs0_y0_x1.lz"

; LZSS-compressed: 73 bytes that expand to 360 (E-0016, E-0017)
MapA9Attrs0_Y1X0::
    INCBIN "maps/mapa9/attrs0_y1_x0.lz"

MapA9Attrs0_Y1X1::
    INCBIN "maps/mapa9/attrs0_y1_x1.lz"

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
MapAAScreens0::
    dfar MapAAScreens0_Y0X0 ; entry 0
    dfar MapAAScreens0_Y1X0 ; entry 1

MapAAAttrs0::
    dfar MapAAAttrs0_Y0X0 ; entry 0
    dfar MapAAAttrs0_Y1X0 ; entry 1

; LZSS-compressed: 200 bytes that expand to 360 (E-0016, E-0017)
MapAAScreens0_Y0X0::
    INCBIN "maps/mapaa/screens0_y0_x0.lz"

; LZSS-compressed: 214 bytes that expand to 360 (E-0016, E-0017)
MapAAScreens0_Y1X0::
    INCBIN "maps/mapaa/screens0_y1_x0.lz"

; LZSS-compressed: 20 bytes that expand to 360 (E-0016, E-0017)
MapAAAttrs0_Y0X0::
    db $68, $01, $00, $02, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

MapAAAttrs0_Y1X0::
    db $68, $01, $00, $02, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
MapABScreens0::
    dfar MapABScreens0_Y0X0 ; entry 0

MapABAttrs0::
    dfar MapABAttrs0_Y0X0 ; entry 0

; LZSS-compressed: 268 bytes that expand to 360 (E-0016, E-0017)
MapABScreens0_Y0X0::
    INCBIN "maps/mapab/screens0_y0_x0.lz"

; LZSS-compressed: 63 bytes that expand to 360 (E-0016, E-0017)
MapABAttrs0_Y0X0::
    db $68, $01, $03, $02, $03, $00, $0f, $18, $06, $03, $2c, $09, $03, $26, $0f, $09
    db $01, $01, $01, $01, $03, $2c, $00, $00, $00, $03, $4c, $0f, $0c, $03, $2c, $03
    db $03, $58, $00, $03, $76, $0f, $39, $03, $4a, $09, $03, $cf, $0f, $15, $03, $0a
    db $13, $03, $36, $0a, $03, $56, $04, $03, $14, $1f, $09, $03, $00, $0f, $11

; compressed tileset of map $AC (the first map record using it)
; LZSS-compressed: 848 bytes that expand to 1024 (E-0016, E-0017)
MapACTileset::
    INCBIN "maps/mapac/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
MapACPalettes::
    dw $7d86, $7fff, $7fe1, $0000 ; entry 0
    dw $0189, $5b7f, $122f, $00a0 ; entry 1
    dw $0175, $5b7f, $1efa, $0009 ; entry 2
    dw $7d86, $5b7f, $0346, $00a0 ; entry 3
    dw $01a0, $5b7f, $0346, $00a0 ; entry 4
    dw $0189, $7fe1, $122f, $00a0 ; entry 5
    dw $01a0, $7fe1, $0346, $00a0 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
MapACScreens0::
    dfar MapACScreens0_Y0X0 ; entry 0

MapACAttrs0::
    dfar MapACAttrs0_Y0X0 ; entry 0

; LZSS-compressed: 276 bytes that expand to 360 (E-0016, E-0017)
MapACScreens0_Y0X0::
    INCBIN "maps/mapac/screens0_y0_x0.lz"

; LZSS-compressed: 149 bytes that expand to 360 (E-0016, E-0017)
MapACAttrs0_Y0X0::
    INCBIN "maps/mapac/attrs0_y0_x0.lz"

; compressed tileset of map $AD (the first map record using it)
; LZSS-compressed: 584 bytes that expand to 1440 (E-0016, E-0017)
MapADTileset::
    INCBIN "maps/mapad/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
MapADPalettes::
    dw $01a2, $7fff, $0348, $0063 ; entry 0
    dw $01a2, $3f7f, $0348, $0084 ; entry 1
    dw $012f, $3f7f, $01d5, $0044 ; entry 2
    dw $1415, $4fff, $3c1f, $0000 ; entry 3
    dw $5d8c, $3f7f, $5ab1, $0000 ; entry 4
    dw $218c, $3f7f, $029a, $0000 ; entry 5
    dw $0000, $294a, $56b5, $7fff ; entry 6
    dw $0000, $294a, $56b5, $7fff ; entry 7

; 12 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
MapADScreens0::
    dfar MapADScreens0_Y0X0 ; entry 0
    dfar MapADScreens0_Y0X1 ; entry 1
    dfar MapADScreens0_Y0X2 ; entry 2
    dfar MapADScreens0_Y1X0 ; entry 3
    dfar MapADScreens0_Y1X1 ; entry 4
    dfar MapADScreens0_Y1X2 ; entry 5
    dfar MapADScreens0_Y2X0 ; entry 6
    dfar MapADScreens0_Y2X1 ; entry 7
    dfar MapADScreens0_Y2X2 ; entry 8
    dfar MapADScreens0_Y3X0 ; entry 9
    dfar MapADScreens0_Y3X1 ; entry 10
    dfar MapADScreens0_Y3X2 ; entry 11

MapADAttrs0::
    dfar MapADAttrs0_Y0X0 ; entry 0
    dfar MapADAttrs0_Y0X1 ; entry 1
    dfar MapADAttrs0_Y0X2 ; entry 2
    dfar MapADAttrs0_Y1X0 ; entry 3
    dfar MapADAttrs0_Y1X1 ; entry 4
    dfar MapADAttrs0_Y1X2 ; entry 5
    dfar MapADAttrs0_Y2X0 ; entry 6
    dfar MapADAttrs0_Y2X1 ; entry 7
    dfar MapADAttrs0_Y2X2 ; entry 8
    dfar MapADAttrs0_Y3X0 ; entry 9
    dfar MapADAttrs0_Y3X1 ; entry 10
    dfar MapADAttrs0_Y3X2 ; entry 11

; LZSS-compressed: 170 bytes that expand to 360 (E-0016, E-0017)
MapADScreens0_Y0X0::
    INCBIN "maps/mapad/screens0_y0_x0.lz"

; LZSS-compressed: 182 bytes that expand to 360 (E-0016, E-0017)
MapADScreens0_Y0X1::
    INCBIN "maps/mapad/screens0_y0_x1.lz"

; LZSS-compressed: 190 bytes that expand to 360 (E-0016, E-0017)
MapADScreens0_Y0X2::
    INCBIN "maps/mapad/screens0_y0_x2.lz"

; LZSS-compressed: 142 bytes that expand to 360 (E-0016, E-0017)
MapADScreens0_Y1X0::
    INCBIN "maps/mapad/screens0_y1_x0.lz"

; LZSS-compressed: 183 bytes that expand to 360 (E-0016, E-0017)
MapADScreens0_Y1X1::
    INCBIN "maps/mapad/screens0_y1_x1.lz"

; LZSS-compressed: 195 bytes that expand to 360 (E-0016, E-0017)
MapADScreens0_Y1X2::
    INCBIN "maps/mapad/screens0_y1_x2.lz"

; LZSS-compressed: 140 bytes that expand to 360 (E-0016, E-0017)
MapADScreens0_Y2X0::
    INCBIN "maps/mapad/screens0_y2_x0.lz"

; LZSS-compressed: 146 bytes that expand to 360 (E-0016, E-0017)
MapADScreens0_Y2X1::
    INCBIN "maps/mapad/screens0_y2_x1.lz"

; LZSS-compressed: 29 bytes that expand to 360 (E-0016, E-0017)
MapADScreens0_Y2X2::
    db $68, $01, $00, $20, $21, $00, $00, $0e, $30, $31, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

; LZSS-compressed: 192 bytes that expand to 360 (E-0016, E-0017)
MapADScreens0_Y3X0::
    INCBIN "maps/mapad/screens0_y3_x0.lz"

; LZSS-compressed: 185 bytes that expand to 360 (E-0016, E-0017)
MapADScreens0_Y3X1::
    INCBIN "maps/mapad/screens0_y3_x1.lz"

; LZSS-compressed: 149 bytes that expand to 360 (E-0016, E-0017)
MapADScreens0_Y3X2::
    INCBIN "maps/mapad/screens0_y3_x2.lz"

; LZSS-compressed: 61 bytes that expand to 360 (E-0016, E-0017)
MapADAttrs0_Y0X0::
    db $68, $01, $00, $01, $00, $00, $0f, $1a, $04, $04, $04, $04, $00, $1e, $0f, $15
    db $00, $30, $0c, $00, $56, $0f, $01, $00, $54, $04, $00, $30, $0a, $00, $80, $0f
    db $05, $03, $03, $00, $2e, $0a, $00, $a8, $0f, $01, $00, $54, $0f, $1d, $00, $1e
    db $0f, $11, $00, $2c, $00, $00, $14, $1f, $13, $00, $00, $0f, $07

; LZSS-compressed: 20 bytes that expand to 360 (E-0016, E-0017)
MapADAttrs0_Y0X1::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

MapADAttrs0_Y0X2::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

; LZSS-compressed: 41 bytes that expand to 360 (E-0016, E-0017)
MapADAttrs0_Y1X0::
    db $68, $01, $00, $01, $00, $00, $0f, $4a, $04, $04, $00, $4c, $0f, $0f, $04, $00
    db $82, $01, $00, $74, $0f, $0d, $00, $82, $0f, $13, $00, $7e, $04, $00, $c2, $0f
    db $15, $00, $ac, $0f, $13, $00, $00, $0f, $31

; LZSS-compressed: 34 bytes that expand to 360 (E-0016, E-0017)
MapADAttrs0_Y1X1::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $1e, $0f, $0a, $04, $04, $00, $6c
    db $0f, $11, $04, $00, $a4, $01, $00, $96, $0f, $3b, $00, $94, $0f, $01, $00, $1e
    db $0f, $49

; LZSS-compressed: 43 bytes that expand to 360 (E-0016, E-0017)
MapADAttrs0_Y1X2::
    db $68, $01, $00, $01, $00, $00, $0f, $16, $04, $04, $00, $18, $0f, $13, $00, $28
    db $00, $00, $2a, $0e, $00, $54, $0f, $01, $00, $28, $0f, $15, $00, $2a, $0f, $19
    db $00, $2c, $0f, $15, $00, $f7, $0f, $4d, $00, $00, $0c

MapADAttrs0_Y2X0::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

; LZSS-compressed: 42 bytes that expand to 360 (E-0016, E-0017)
MapADAttrs0_Y2X1::
    db $68, $01, $00, $01, $00, $00, $0f, $48, $04, $00, $5c, $01, $00, $4e, $0f, $0d
    db $00, $5c, $02, $00, $74, $0f, $15, $00, $4e, $0f, $0f, $00, $5a, $02, $00, $c4
    db $0f, $13, $00, $4a, $0f, $01, $00, $00, $0f, $43

; LZSS-compressed: 20 bytes that expand to 360 (E-0016, E-0017)
MapADAttrs0_Y2X2::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

; LZSS-compressed: 45 bytes that expand to 360 (E-0016, E-0017)
MapADAttrs0_Y3X0::
    db $68, $01, $00, $01, $00, $00, $0f, $20, $04, $00, $34, $01, $00, $26, $0f, $0d
    db $00, $34, $02, $00, $4c, $0f, $0d, $00, $5a, $0f, $13, $00, $30, $04, $00, $24
    db $0f, $01, $00, $00, $0f, $21, $00, $f5, $0f, $4d, $00, $00, $0e

MapADAttrs0_Y3X1::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

MapADAttrs0_Y3X2::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34
    ds $444, $00
