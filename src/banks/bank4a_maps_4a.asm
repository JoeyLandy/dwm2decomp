; ROM bank $4A: map screens, attributes and tilesets
; The annotated listing of this bank is build/listing/bank4a.asm.

SECTION "Bank 4A", ROMX[$4000], BANK[$4A]
    db $4a

; compressed tileset of map $20 (the first map record using it)
; LZSS-compressed: 672 bytes that expand to 1792 (E-0016, E-0017)
Map20Tileset::
    INCBIN "maps/map20/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map20Palettes::
    dw $7c01, $7fff, $7fe1, $0000 ; entry 0
    dw $0152, $3f7f, $0218, $00c8 ; entry 1
    dw $026e, $3f7f, $02f3, $0188 ; entry 2
    dw $2130, $3f7f, $39d9, $00c8 ; entry 3
    dw $0018, $3f7f, $0218, $00c8 ; entry 4
    dw $7c01, $3f7f, $7fe1, $0000 ; entry 5
    dw $218c, $4f18, $3a52, $0000 ; entry 6
    dw $218c, $4f18, $3a52, $0000 ; entry 7

; 64 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map20Screens0::
    dfar Map20Screens0_Y0X0 ; entry 0
    dfar Map20Screens0_Y0X1 ; entry 1
    dfar Map20Screens0_Y0X2 ; entry 2
    dfar Map20Screens0_Y0X3 ; entry 3
    dfar Map20Screens0_Y0X4 ; entry 4
    dfar Map20Screens0_Y0X5 ; entry 5
    dfar Map20Screens0_Y0X6 ; entry 6
    dfar Map20Screens0_Y0X7 ; entry 7
    dfar Map20Screens0_Y1X0 ; entry 8
    dfar Map20Screens0_Y1X1 ; entry 9
    dfar Map20Screens0_Y1X2 ; entry 10
    dfar Map20Screens0_Y1X3 ; entry 11
    dfar Map20Screens0_Y1X4 ; entry 12
    dfar Map20Screens0_Y1X5 ; entry 13
    dfar Map20Screens0_Y1X6 ; entry 14
    dfar Map20Screens0_Y1X7 ; entry 15
    dfar Map20Screens0_Y2X0 ; entry 16
    dfar Map20Screens0_Y2X1 ; entry 17
    dfar Map20Screens0_Y2X2 ; entry 18
    dfar Map20Screens0_Y2X3 ; entry 19
    dfar Map20Screens0_Y2X4 ; entry 20
    dfar Map20Screens0_Y2X5 ; entry 21
    dfar Map20Screens0_Y2X6 ; entry 22
    dfar Map20Screens0_Y2X7 ; entry 23
    dfar Map20Screens0_Y3X0 ; entry 24
    dfar Map20Screens0_Y3X1 ; entry 25
    dfar Map20Screens0_Y3X2 ; entry 26
    dfar Map20Screens0_Y3X3 ; entry 27
    dfar Map20Screens0_Y3X4 ; entry 28
    dfar Map20Screens0_Y3X5 ; entry 29
    dfar Map20Screens0_Y3X6 ; entry 30
    dfar Map20Screens0_Y3X7 ; entry 31
    dfar Map20Screens0_Y4X0 ; entry 32
    dfar Map20Screens0_Y4X1 ; entry 33
    dfar Map20Screens0_Y4X2 ; entry 34
    dfar Map20Screens0_Y4X3 ; entry 35
    dfar Map20Screens0_Y4X4 ; entry 36
    dfar Map20Screens0_Y4X5 ; entry 37
    dfar Map20Screens0_Y4X6 ; entry 38
    dfar Map20Screens0_Y4X7 ; entry 39
    dfar Map20Screens0_Y5X0 ; entry 40
    dfar Map20Screens0_Y5X1 ; entry 41
    dfar Map20Screens0_Y5X2 ; entry 42
    dfar Map20Screens0_Y5X3 ; entry 43
    dfar Map20Screens0_Y5X4 ; entry 44
    dfar Map20Screens0_Y5X5 ; entry 45
    dfar Map20Screens0_Y5X6 ; entry 46
    dfar Map20Screens0_Y5X7 ; entry 47
    dfar Map20Screens0_Y6X0 ; entry 48
    dfar Map20Screens0_Y6X1 ; entry 49
    dfar Map20Screens0_Y6X2 ; entry 50
    dfar Map20Screens0_Y6X3 ; entry 51
    dfar Map20Screens0_Y6X4 ; entry 52
    dfar Map20Screens0_Y6X5 ; entry 53
    dfar Map20Screens0_Y6X6 ; entry 54
    dfar Map20Screens0_Y6X7 ; entry 55
    dfar Map20Screens0_Y7X0 ; entry 56
    dfar Map20Screens0_Y7X1 ; entry 57
    dfar Map20Screens0_Y7X2 ; entry 58
    dfar Map20Screens0_Y7X3 ; entry 59
    dfar Map20Screens0_Y7X4 ; entry 60
    dfar Map20Screens0_Y7X5 ; entry 61
    dfar Map20Screens0_Y7X6 ; entry 62
    dfar Map20Screens0_Y7X7 ; entry 63

Map20Attrs0::
    dfar Map20Attrs0_Y0X0 ; entry 0
    dfar Map20Attrs0_Y0X1 ; entry 1
    dfar Map20Attrs0_Y0X2 ; entry 2
    dfar Map20Attrs0_Y0X3 ; entry 3
    dfar Map20Attrs0_Y0X4 ; entry 4
    dfar Map20Attrs0_Y0X5 ; entry 5
    dfar Map20Attrs0_Y0X6 ; entry 6
    dfar Map20Attrs0_Y0X7 ; entry 7
    dfar Map20Attrs0_Y1X0 ; entry 8
    dfar Map20Attrs0_Y1X1 ; entry 9
    dfar Map20Attrs0_Y1X2 ; entry 10
    dfar Map20Attrs0_Y1X3 ; entry 11
    dfar Map20Attrs0_Y1X4 ; entry 12
    dfar Map20Attrs0_Y1X5 ; entry 13
    dfar Map20Attrs0_Y1X6 ; entry 14
    dfar Map20Attrs0_Y1X7 ; entry 15
    dfar Map20Attrs0_Y2X0 ; entry 16
    dfar Map20Attrs0_Y2X1 ; entry 17
    dfar Map20Attrs0_Y2X2 ; entry 18
    dfar Map20Attrs0_Y2X3 ; entry 19
    dfar Map20Attrs0_Y2X4 ; entry 20
    dfar Map20Attrs0_Y2X5 ; entry 21
    dfar Map20Attrs0_Y2X6 ; entry 22
    dfar Map20Attrs0_Y2X7 ; entry 23
    dfar Map20Attrs0_Y3X0 ; entry 24
    dfar Map20Attrs0_Y3X1 ; entry 25
    dfar Map20Attrs0_Y3X2 ; entry 26
    dfar Map20Attrs0_Y3X3 ; entry 27
    dfar Map20Attrs0_Y3X4 ; entry 28
    dfar Map20Attrs0_Y3X5 ; entry 29
    dfar Map20Attrs0_Y3X6 ; entry 30
    dfar Map20Attrs0_Y3X7 ; entry 31
    dfar Map20Attrs0_Y4X0 ; entry 32
    dfar Map20Attrs0_Y4X1 ; entry 33
    dfar Map20Attrs0_Y4X2 ; entry 34
    dfar Map20Attrs0_Y4X3 ; entry 35
    dfar Map20Attrs0_Y4X4 ; entry 36
    dfar Map20Attrs0_Y4X5 ; entry 37
    dfar Map20Attrs0_Y4X6 ; entry 38
    dfar Map20Attrs0_Y4X7 ; entry 39
    dfar Map20Attrs0_Y5X0 ; entry 40
    dfar Map20Attrs0_Y5X1 ; entry 41
    dfar Map20Attrs0_Y5X2 ; entry 42
    dfar Map20Attrs0_Y5X3 ; entry 43
    dfar Map20Attrs0_Y5X4 ; entry 44
    dfar Map20Attrs0_Y5X5 ; entry 45
    dfar Map20Attrs0_Y5X6 ; entry 46
    dfar Map20Attrs0_Y5X7 ; entry 47
    dfar Map20Attrs0_Y6X0 ; entry 48
    dfar Map20Attrs0_Y6X1 ; entry 49
    dfar Map20Attrs0_Y6X2 ; entry 50
    dfar Map20Attrs0_Y6X3 ; entry 51
    dfar Map20Attrs0_Y6X4 ; entry 52
    dfar Map20Attrs0_Y6X5 ; entry 53
    dfar Map20Attrs0_Y6X6 ; entry 54
    dfar Map20Attrs0_Y6X7 ; entry 55
    dfar Map20Attrs0_Y7X0 ; entry 56
    dfar Map20Attrs0_Y7X1 ; entry 57
    dfar Map20Attrs0_Y7X2 ; entry 58
    dfar Map20Attrs0_Y7X3 ; entry 59
    dfar Map20Attrs0_Y7X4 ; entry 60
    dfar Map20Attrs0_Y7X5 ; entry 61
    dfar Map20Attrs0_Y7X6 ; entry 62
    dfar Map20Attrs0_Y7X7 ; entry 63

; LZSS-compressed: 113 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y0X0::
    INCBIN "maps/map20/screens0_y0_x0.lz"

; LZSS-compressed: 118 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y0X1::
    INCBIN "maps/map20/screens0_y0_x1.lz"

; LZSS-compressed: 96 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y0X2::
    INCBIN "maps/map20/screens0_y0_x2.lz"

Map20Screens0_Y0X3::
    INCBIN "maps/map20/screens0_y0_x3.lz"

; LZSS-compressed: 81 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y0X4::
    INCBIN "maps/map20/screens0_y0_x4.lz"

; LZSS-compressed: 138 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y0X5::
    INCBIN "maps/map20/screens0_y0_x5.lz"

; LZSS-compressed: 106 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y0X6::
    INCBIN "maps/map20/screens0_y0_x6.lz"

; LZSS-compressed: 117 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y0X7::
    INCBIN "maps/map20/screens0_y0_x7.lz"

; LZSS-compressed: 120 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y1X0::
    INCBIN "maps/map20/screens0_y1_x0.lz"

Map20Screens0_Y1X1::
    INCBIN "maps/map20/screens0_y1_x1.lz"

; LZSS-compressed: 198 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y1X2::
    INCBIN "maps/map20/screens0_y1_x2.lz"

; LZSS-compressed: 133 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y1X3::
    INCBIN "maps/map20/screens0_y1_x3.lz"

; LZSS-compressed: 169 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y1X4::
    INCBIN "maps/map20/screens0_y1_x4.lz"

; LZSS-compressed: 150 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y1X5::
    INCBIN "maps/map20/screens0_y1_x5.lz"

; LZSS-compressed: 78 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y1X6::
    INCBIN "maps/map20/screens0_y1_x6.lz"

; LZSS-compressed: 134 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y1X7::
    INCBIN "maps/map20/screens0_y1_x7.lz"

; LZSS-compressed: 109 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y2X0::
    INCBIN "maps/map20/screens0_y2_x0.lz"

; LZSS-compressed: 135 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y2X1::
    INCBIN "maps/map20/screens0_y2_x1.lz"

; LZSS-compressed: 126 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y2X2::
    INCBIN "maps/map20/screens0_y2_x2.lz"

; LZSS-compressed: 129 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y2X3::
    INCBIN "maps/map20/screens0_y2_x3.lz"

; LZSS-compressed: 134 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y2X4::
    INCBIN "maps/map20/screens0_y2_x4.lz"

; LZSS-compressed: 114 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y2X5::
    INCBIN "maps/map20/screens0_y2_x5.lz"

; LZSS-compressed: 142 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y2X6::
    INCBIN "maps/map20/screens0_y2_x6.lz"

; LZSS-compressed: 94 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y2X7::
    INCBIN "maps/map20/screens0_y2_x7.lz"

; LZSS-compressed: 108 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y3X0::
    INCBIN "maps/map20/screens0_y3_x0.lz"

; LZSS-compressed: 151 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y3X1::
    INCBIN "maps/map20/screens0_y3_x1.lz"

; LZSS-compressed: 114 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y3X2::
    INCBIN "maps/map20/screens0_y3_x2.lz"

; LZSS-compressed: 143 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y3X3::
    INCBIN "maps/map20/screens0_y3_x3.lz"

; LZSS-compressed: 132 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y3X4::
    INCBIN "maps/map20/screens0_y3_x4.lz"

; LZSS-compressed: 153 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y3X5::
    INCBIN "maps/map20/screens0_y3_x5.lz"

; LZSS-compressed: 164 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y3X6::
    INCBIN "maps/map20/screens0_y3_x6.lz"

; LZSS-compressed: 57 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y3X7::
    db $68, $01, $00, $44, $45, $00, $00, $00, $2a, $2b, $00, $06, $08, $54, $55, $00
    db $14, $00, $3a, $3b, $00, $1a, $08, $00, $00, $0f, $41, $00, $06, $0a, $00, $12
    db $02, $00, $1a, $0a, $00, $76, $0f, $17, $00, $7c, $0c, $00, $06, $00, $00, $90
    db $0c, $00, $c4, $0f, $4d, $00, $fc, $0f, $09

; LZSS-compressed: 130 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y4X0::
    INCBIN "maps/map20/screens0_y4_x0.lz"

; LZSS-compressed: 123 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y4X1::
    INCBIN "maps/map20/screens0_y4_x1.lz"

; LZSS-compressed: 162 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y4X2::
    INCBIN "maps/map20/screens0_y4_x2.lz"

; LZSS-compressed: 135 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y4X3::
    INCBIN "maps/map20/screens0_y4_x3.lz"

Map20Screens0_Y4X4::
    INCBIN "maps/map20/screens0_y4_x4.lz"

; LZSS-compressed: 107 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y4X5::
    INCBIN "maps/map20/screens0_y4_x5.lz"

; LZSS-compressed: 180 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y4X6::
    INCBIN "maps/map20/screens0_y4_x6.lz"

; LZSS-compressed: 104 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y4X7::
    INCBIN "maps/map20/screens0_y4_x7.lz"

; LZSS-compressed: 76 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y5X0::
    INCBIN "maps/map20/screens0_y5_x0.lz"

; LZSS-compressed: 129 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y5X1::
    INCBIN "maps/map20/screens0_y5_x1.lz"

; LZSS-compressed: 93 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y5X2::
    INCBIN "maps/map20/screens0_y5_x2.lz"

; LZSS-compressed: 123 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y5X3::
    INCBIN "maps/map20/screens0_y5_x3.lz"

; LZSS-compressed: 92 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y5X4::
    INCBIN "maps/map20/screens0_y5_x4.lz"

; LZSS-compressed: 147 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y5X5::
    INCBIN "maps/map20/screens0_y5_x5.lz"

; LZSS-compressed: 159 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y5X6::
    INCBIN "maps/map20/screens0_y5_x6.lz"

; LZSS-compressed: 29 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y5X7::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

; LZSS-compressed: 97 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y6X0::
    INCBIN "maps/map20/screens0_y6_x0.lz"

; LZSS-compressed: 120 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y6X1::
    INCBIN "maps/map20/screens0_y6_x1.lz"

; LZSS-compressed: 149 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y6X2::
    INCBIN "maps/map20/screens0_y6_x2.lz"

; LZSS-compressed: 93 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y6X3::
    INCBIN "maps/map20/screens0_y6_x3.lz"

; LZSS-compressed: 125 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y6X4::
    INCBIN "maps/map20/screens0_y6_x4.lz"

; LZSS-compressed: 150 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y6X5::
    INCBIN "maps/map20/screens0_y6_x5.lz"

; LZSS-compressed: 174 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y6X6::
    INCBIN "maps/map20/screens0_y6_x6.lz"

; LZSS-compressed: 90 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y6X7::
    INCBIN "maps/map20/screens0_y6_x7.lz"

; LZSS-compressed: 29 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y7X0::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

Map20Screens0_Y7X1::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

; LZSS-compressed: 122 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y7X2::
    INCBIN "maps/map20/screens0_y7_x2.lz"

; LZSS-compressed: 142 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y7X3::
    INCBIN "maps/map20/screens0_y7_x3.lz"

; LZSS-compressed: 152 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y7X4::
    INCBIN "maps/map20/screens0_y7_x4.lz"

; LZSS-compressed: 100 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y7X5::
    INCBIN "maps/map20/screens0_y7_x5.lz"

; LZSS-compressed: 107 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y7X6::
    INCBIN "maps/map20/screens0_y7_x6.lz"

; LZSS-compressed: 117 bytes that expand to 360 (E-0016, E-0017)
Map20Screens0_Y7X7::
    INCBIN "maps/map20/screens0_y7_x7.lz"

; LZSS-compressed: 65 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y0X0::
    INCBIN "maps/map20/attrs0_y0_x0.lz"

; LZSS-compressed: 63 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y0X1::
    db $68, $01, $00, $03, $00, $00, $0f, $4d, $00, $18, $0f, $04, $02, $00, $78, $01
    db $00, $6e, $0c, $00, $7a, $0f, $05, $00, $7c, $04, $00, $9c, $08, $00, $a6, $0f
    db $03, $00, $7a, $02, $00, $c2, $0f, $07, $01, $01, $00, $c2, $0e, $00, $f0, $0f
    db $03, $00, $18, $14, $00, $10, $1e, $00, $20, $1f, $03, $00, $3e, $1f, $0b

; LZSS-compressed: 56 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y0X2::
    db $68, $01, $00, $03, $00, $00, $0f, $4d, $00, $18, $0f, $04, $02, $00, $78, $01
    db $00, $6a, $0f, $15, $00, $7c, $0a, $00, $a0, $0f, $09, $00, $7a, $08, $00, $c8
    db $0f, $0d, $00, $7c, $04, $00, $f0, $0f, $01, $01, $00, $18, $11, $00, $0a, $1f
    db $15, $00, $1a, $14, $00, $3a, $1f, $07

; LZSS-compressed: 59 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y0X3::
    db $68, $01, $00, $03, $00, $00, $0f, $20, $01, $01, $00, $22, $0f, $11, $01, $00
    db $5a, $01, $00, $4c, $0f, $15, $00, $34, $0a, $00, $82, $0e, $00, $82, $04, $00
    db $5c, $08, $00, $a8, $0f, $27, $00, $a8, $08, $00, $ee, $0f, $07, $00, $82, $06
    db $00, $12, $1f, $11, $00, $54, $06, $00, $40, $1f, $01

; LZSS-compressed: 34 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y0X4::
    db $68, $01, $00, $03, $00, $00, $0f, $4d, $00, $40, $0f, $2c, $01, $00, $a0, $01
    db $00, $92, $0f, $15, $00, $a4, $0a, $00, $c8, $0f, $31, $00, $a4, $08, $00, $18
    db $1f, $29

; LZSS-compressed: 55 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y0X5::
    db $68, $01, $00, $03, $00, $00, $0f, $1e, $01, $01, $01, $01, $00, $22, $0f, $0f
    db $00, $32, $00, $00, $58, $04, $00, $50, $0f, $07, $00, $58, $08, $00, $76, $0f
    db $31, $00, $54, $0a, $00, $c8, $0f, $09, $00, $58, $0f, $11, $00, $7e, $0a, $00
    db $16, $1f, $07, $00, $7c, $0f, $11

; LZSS-compressed: 28 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y0X6::
    db $68, $01, $00, $03, $00, $00, $0f, $20, $01, $00, $34, $03, $00, $28, $0f, $01
    db $00, $4f, $0f, $4d, $00, $af, $0f, $4d, $00, $08, $1f, $45

; LZSS-compressed: 65 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y0X7::
    INCBIN "maps/map20/attrs0_y0_x7.lz"

; LZSS-compressed: 56 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y1X0::
    db $68, $01, $00, $03, $00, $00, $03, $02, $02, $02, $02, $01, $00, $0c, $03, $00
    db $00, $0f, $35, $00, $0a, $04, $00, $50, $0f, $09, $00, $06, $08, $00, $78, $0f
    db $33, $03, $03, $00, $0c, $0c, $00, $d0, $0f, $01, $00, $0c, $04, $00, $ec, $0f
    db $0b, $00, $f8, $08, $00, $16, $1f, $2b

; LZSS-compressed: 34 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y1X1::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $c8, $03, $03, $03, $03, $03, $00, $18, $1f, $0f, $00, $28, $10, $00, $3e
    db $1f, $03

; LZSS-compressed: 93 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y1X2::
    INCBIN "maps/map20/attrs0_y1_x2.lz"

; LZSS-compressed: 64 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y1X3::
    db $68, $01, $00, $03, $03, $03, $03, $01, $00, $04, $01, $00, $00, $00, $00, $02
    db $02, $00, $00, $0f, $03, $00, $04, $02, $00, $1c, $0f, $0d, $00, $3e, $0f, $07
    db $00, $44, $0f, $07, $00, $70, $0f, $0d, $00, $7e, $0a, $00, $0e, $06, $00, $00
    db $0c, $00, $b8, $0f, $1b, $00, $74, $0e, $00, $98, $0f, $07, $00, $12, $1f, $2f

; LZSS-compressed: 68 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y1X4::
    INCBIN "maps/map20/attrs0_y1_x4.lz"

; LZSS-compressed: 57 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y1X5::
    db $68, $01, $00, $03, $00, $00, $01, $01, $00, $06, $09, $00, $00, $0f, $2b, $00
    db $4e, $02, $00, $52, $04, $00, $4c, $0f, $05, $00, $10, $04, $00, $4a, $06, $00
    db $76, $0f, $07, $00, $6a, $0e, $00, $a2, $0f, $03, $00, $92, $0f, $01, $00, $92
    db $0f, $03, $00, $f5, $0f, $4d, $00, $aa, $0e

; LZSS-compressed: 20 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y1X6::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

; LZSS-compressed: 66 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y1X7::
    INCBIN "maps/map20/attrs0_y1_x7.lz"

; LZSS-compressed: 43 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y2X0::
    db $68, $01, $00, $03, $00, $00, $01, $01, $00, $06, $09, $00, $00, $0f, $4d, $00
    db $10, $06, $00, $18, $0a, $00, $78, $0f, $09, $00, $16, $06, $00, $a0, $08, $00
    db $aa, $0f, $03, $00, $d3, $0f, $4d, $00, $08, $1f, $21

; LZSS-compressed: 55 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y2X1::
    db $68, $01, $00, $01, $00, $00, $09, $03, $00, $0e, $01, $00, $00, $0f, $2f, $00
    db $0e, $02, $00, $56, $04, $00, $50, $0f, $05, $00, $58, $0e, $00, $7a, $0e, $00
    db $56, $0f, $13, $00, $7a, $0f, $13, $00, $52, $08, $00, $02, $0e, $00, $f6, $0e
    db $00, $00, $0a, $00, $16, $1f, $2b

; LZSS-compressed: 61 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y2X2::
    db $68, $01, $00, $03, $03, $03, $03, $01, $00, $04, $07, $00, $00, $00, $00, $00
    db $0f, $03, $00, $04, $08, $02, $02, $00, $24, $0f, $11, $02, $02, $00, $4a, $0f
    db $07, $00, $52, $0f, $13, $00, $02, $06, $00, $5c, $06, $00, $9e, $0f, $09, $00
    db $5c, $00, $00, $be, $0f, $37, $00, $ce, $0a, $00, $16, $1f, $2b

Map20Attrs0_Y2X3::
    db $68, $01, $00, $03, $00, $00, $03, $01, $00, $08, $07, $00, $00, $0f, $07, $00
    db $08, $08, $00, $26, $0f, $0f, $00, $54, $06, $00, $52, $0f, $09, $00, $52, $08
    db $00, $7a, $0f, $0b, $00, $20, $0e, $00, $aa, $0a, $00, $a6, $0a, $00, $c6, $0f
    db $0b, $00, $1e, $0f, $2b, $00, $20, $0f, $07, $00, $00, $0f, $05

; LZSS-compressed: 37 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y2X4::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $48, $0f, $34, $03, $03, $00, $96
    db $0f, $11, $00, $a8, $0f, $0f, $00, $a8, $0f, $13, $00, $ee, $0f, $19, $00, $bc
    db $0f, $01, $00, $a8, $0e

; LZSS-compressed: 20 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y2X5::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

; LZSS-compressed: 45 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y2X6::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $26, $0f, $12, $03, $00, $86, $01
    db $00, $78, $0f, $07, $00, $8a, $02, $00, $86, $02, $00, $9e, $0f, $07, $00, $8a
    db $08, $00, $c4, $0f, $09, $00, $f3, $0f, $4d, $00, $08, $1f, $01

Map20Attrs0_Y2X7::
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0a, $05, $00, $00, $0f, $31, $00
    db $0a, $06, $00, $4e, $0f, $03, $00, $77, $0f, $4d, $00, $90, $0f, $05, $00, $68
    db $0f, $01, $00, $f0, $0f, $05, $00, $6a, $0c, $00, $18, $1f, $29

Map20Attrs0_Y3X0::
    db $68, $01, $00, $03, $00, $00, $0f, $46, $01, $00, $5a, $05, $00, $50, $0f, $07
    db $00, $5a, $06, $00, $74, $0f, $09, $00, $7e, $0a, $00, $9e, $0f, $05, $00, $a4
    db $0c, $00, $c6, $0f, $4d, $00, $ea, $0f, $05, $00, $a0, $0f, $03

; LZSS-compressed: 79 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y3X1::
    INCBIN "maps/map20/attrs0_y3_x1.lz"

; LZSS-compressed: 64 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y3X2::
    db $68, $01, $00, $01, $01, $01, $01, $02, $00, $04, $01, $03, $00, $0a, $05, $00
    db $00, $0f, $2b, $00, $04, $02, $00, $44, $0f, $0d, $00, $52, $04, $00, $6c, $0f
    db $15, $00, $0a, $06, $00, $9e, $0f, $07, $00, $00, $00, $00, $bc, $0f, $0f, $00
    db $00, $00, $00, $e2, $0f, $0f, $00, $f2, $02, $00, $cc, $0a, $00, $18, $1f, $29

; LZSS-compressed: 68 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y3X3::
    INCBIN "maps/map20/attrs0_y3_x3.lz"

Map20Attrs0_Y3X4::
    db $68, $01, $00, $03, $03, $03, $03, $01, $00, $04, $0b, $00, $00, $0f, $03, $00
    db $04, $0c, $00, $26, $0f, $03, $00, $4f, $0f, $4d, $00, $a2, $0f, $3f, $00, $28
    db $0f, $13, $00, $00, $0f, $13, $00, $00, $00, $00, $3e, $1f, $03

; LZSS-compressed: 55 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y3X5::
    db $68, $01, $00, $01, $00, $00, $0f, $48, $03, $03, $00, $4a, $0f, $11, $03, $03
    db $00, $70, $0f, $0f, $00, $82, $00, $00, $5c, $0c, $00, $a6, $0f, $01, $00, $5a
    db $0f, $0f, $00, $a8, $0f, $13, $00, $a6, $02, $00, $82, $06, $00, $16, $16, $00
    db $1c, $1f, $05, $00, $3a, $1f, $0d

; LZSS-compressed: 59 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y3X6::
    db $68, $01, $00, $01, $00, $00, $0f, $42, $03, $03, $00, $50, $0a, $00, $52, $0f
    db $05, $00, $50, $04, $00, $72, $0f, $15, $00, $44, $0f, $07, $00, $ae, $0f, $13
    db $00, $84, $0e, $00, $84, $00, $00, $f0, $0f, $07, $00, $16, $18, $00, $16, $1f
    db $05, $00, $56, $00, $00, $3e, $1a, $00, $40, $1f, $01

; LZSS-compressed: 33 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y3X7::
    db $68, $01, $00, $01, $00, $00, $01, $03, $00, $06, $09, $00, $00, $0f, $4d, $00
    db $10, $04, $00, $1a, $0a, $00, $76, $0f, $2b, $00, $c7, $0f, $4d, $00, $08, $1f
    db $2d

; LZSS-compressed: 53 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y4X0::
    db $68, $01, $00, $03, $03, $01, $00, $02, $0b, $03, $03, $00, $00, $0f, $4d, $00
    db $10, $02, $00, $14, $0c, $00, $76, $0f, $13, $00, $76, $02, $00, $a2, $0f, $03
    db $00, $14, $08, $00, $c4, $0f, $0b, $00, $14, $00, $00, $f6, $02, $00, $ec, $0f
    db $0d, $00, $12, $1f, $35

; LZSS-compressed: 78 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y4X1::
    INCBIN "maps/map20/attrs0_y4_x1.lz"

; LZSS-compressed: 76 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y4X2::
    INCBIN "maps/map20/attrs0_y4_x2.lz"

; LZSS-compressed: 48 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y4X3::
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0a, $05, $00, $00, $0f, $09, $00
    db $0a, $06, $00, $26, $0f, $05, $00, $0a, $0a, $00, $4c, $0f, $05, $00, $74, $0a
    db $00, $72, $0f, $0d, $00, $72, $0f, $15, $00, $cd, $0f, $4d, $00, $08, $1f, $27

; LZSS-compressed: 39 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y4X4::
    db $68, $01, $00, $01, $00, $00, $09, $03, $00, $0e, $01, $00, $00, $0f, $4d, $00
    db $24, $0c, $00, $22, $02, $00, $76, $0f, $35, $00, $84, $04, $00, $c6, $0f, $33
    db $00, $d2, $06, $00, $16, $1f, $2b

; LZSS-compressed: 61 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y4X5::
    db $68, $01, $00, $03, $00, $00, $0f, $4a, $02, $02, $01, $01, $01, $01, $00, $50
    db $0f, $0b, $02, $02, $00, $5e, $02, $00, $76, $0f, $0b, $00, $82, $06, $00, $9e
    db $0f, $0d, $00, $ac, $04, $00, $c6, $0f, $09, $00, $a8, $08, $00, $ee, $0f, $0d
    db $00, $aa, $0c, $00, $1e, $1f, $07, $00, $84, $0a, $00, $46, $1a

; LZSS-compressed: 92 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y4X6::
    INCBIN "maps/map20/attrs0_y4_x6.lz"

; LZSS-compressed: 68 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y4X7::
    INCBIN "maps/map20/attrs0_y4_x7.lz"

; LZSS-compressed: 37 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y5X0::
    db $68, $01, $00, $03, $00, $00, $0f, $4d, $00, $50, $0f, $3c, $01, $01, $01, $01
    db $00, $a0, $0f, $0f, $00, $b0, $00, $00, $c6, $0f, $0d, $00, $d6, $02, $00, $ec
    db $0f, $4d, $00, $fa, $04

; LZSS-compressed: 75 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y5X1::
    INCBIN "maps/map20/attrs0_y5_x1.lz"

; LZSS-compressed: 59 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y5X2::
    db $68, $01, $00, $02, $00, $00, $0b, $01, $01, $01, $01, $00, $00, $0f, $11, $00
    db $0e, $00, $00, $28, $0f, $39, $00, $10, $0f, $0d, $04, $04, $04, $04, $00, $98
    db $0f, $11, $00, $08, $0f, $13, $00, $12, $06, $00, $ec, $0f, $09, $00, $f6, $0a
    db $00, $16, $1f, $07, $00, $1e, $1a, $00, $3e, $1f, $03

; LZSS-compressed: 40 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y5X3::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $46, $0f, $32, $02, $02, $00, $94
    db $0f, $13, $00, $a4, $00, $00, $a6, $0e, $00, $d0, $0f, $01, $00, $ce, $0f, $19
    db $00, $f8, $0f, $1b, $00, $46, $0f, $03

; LZSS-compressed: 41 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y5X4::
    db $68, $01, $00, $01, $00, $00, $03, $03, $00, $08, $07, $00, $00, $0f, $2f, $00
    db $08, $08, $00, $4e, $0f, $09, $00, $06, $0f, $17, $00, $06, $08, $00, $a0, $0f
    db $31, $00, $08, $0f, $3b, $00, $06, $0f, $0f

; LZSS-compressed: 86 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y5X5::
    INCBIN "maps/map20/attrs0_y5_x5.lz"

; LZSS-compressed: 83 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y5X6::
    INCBIN "maps/map20/attrs0_y5_x6.lz"

; LZSS-compressed: 20 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y5X7::
    db $68, $01, $00, $03, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

; LZSS-compressed: 37 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y6X0::
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0a, $05, $00, $00, $0f, $33, $00
    db $08, $06, $00, $50, $0f, $35, $00, $06, $04, $00, $a0, $0f, $11, $00, $d7, $0f
    db $4d, $00, $08, $1f, $1d

; LZSS-compressed: 58 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y6X1::
    db $68, $01, $00, $01, $00, $00, $01, $02, $00, $06, $09, $00, $00, $0f, $05, $00
    db $0c, $06, $00, $22, $0f, $11, $00, $00, $06, $00, $50, $0f, $03, $00, $10, $06
    db $00, $7e, $06, $00, $7a, $0f, $03, $03, $00, $a4, $03, $00, $98, $0f, $09, $00
    db $a4, $04, $00, $cf, $0f, $4d, $00, $08, $1f, $25

; LZSS-compressed: 56 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y6X2::
    db $68, $01, $00, $02, $00, $00, $07, $01, $00, $0c, $03, $00, $00, $0f, $07, $00
    db $12, $00, $00, $0c, $04, $00, $26, $0f, $07, $00, $32, $06, $00, $4a, $0f, $07
    db $00, $68, $0f, $3d, $03, $03, $00, $b6, $0f, $15, $00, $f0, $00, $00, $e2, $0f
    db $15, $00, $c8, $0a, $00, $18, $1f, $29

; LZSS-compressed: 26 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y6X3::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $48, $0f, $34, $02, $02, $00, $96
    db $0f, $13, $00, $cf, $0f, $4d, $00, $08, $1f, $25

; LZSS-compressed: 42 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y6X4::
    db $68, $01, $00, $01, $00, $00, $03, $03, $00, $08, $07, $00, $00, $0f, $4d, $00
    db $10, $08, $00, $1a, $08, $00, $78, $0f, $33, $00, $1a, $02, $00, $c8, $08, $00
    db $d0, $0f, $05, $00, $fb, $0f, $4d, $00, $c8, $08

; LZSS-compressed: 69 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y6X5::
    INCBIN "maps/map20/attrs0_y6_x5.lz"

; LZSS-compressed: 89 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y6X6::
    INCBIN "maps/map20/attrs0_y6_x6.lz"

; LZSS-compressed: 53 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y6X7::
    db $68, $01, $00, $03, $00, $00, $0f, $14, $02, $02, $02, $02, $00, $18, $0f, $15
    db $00, $2a, $0c, $00, $50, $0f, $2f, $00, $2a, $0a, $00, $a0, $0f, $29, $01, $01
    db $00, $a0, $0e, $00, $f0, $0f, $03, $00, $f0, $04, $00, $0e, $1f, $0f, $00, $f0
    db $02, $00, $36, $1f, $0b

; LZSS-compressed: 20 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y7X0::
    db $68, $01, $00, $03, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

Map20Attrs0_Y7X1::
    db $68, $01, $00, $03, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

; LZSS-compressed: 63 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y7X2::
    db $68, $01, $00, $03, $00, $00, $03, $01, $00, $08, $07, $00, $00, $0f, $07, $02
    db $02, $00, $1c, $0f, $15, $00, $2e, $08, $00, $50, $0f, $0b, $00, $56, $06, $00
    db $78, $0f, $07, $00, $7c, $0a, $00, $a0, $0f, $0d, $00, $02, $04, $00, $c8, $0f
    db $09, $00, $2c, $00, $00, $f0, $06, $00, $f2, $0f, $09, $00, $10, $1f, $33

; LZSS-compressed: 47 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y7X3::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $22, $0f, $0e, $03, $03, $03, $03
    db $00, $72, $0f, $0f, $00, $82, $00, $00, $98, $0f, $17, $00, $84, $0a, $00, $d0
    db $08, $00, $ea, $04, $00, $f6, $0a, $00, $f2, $0f, $01, $00, $0a, $1f, $3b

; LZSS-compressed: 48 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y7X4::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $78, $0f, $04
    db $03, $03, $03, $03, $00, $c8, $0f, $01, $00, $da, $0a, $00, $ec, $02, $00, $f0
    db $0f, $03, $00, $ec, $06, $00, $12, $1a, $00, $1e, $1f, $03, $00, $38, $1f, $0d

; LZSS-compressed: 38 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y7X5::
    db $68, $01, $00, $01, $00, $00, $0f, $4a, $03, $00, $5e, $01, $00, $50, $0f, $09
    db $00, $5e, $02, $00, $72, $0f, $0b, $00, $80, $08, $00, $9c, $0f, $05, $00, $c7
    db $0f, $4d, $00, $08, $1f, $2d

; LZSS-compressed: 66 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y7X6::
    INCBIN "maps/map20/attrs0_y7_x6.lz"

; LZSS-compressed: 72 bytes that expand to 360 (E-0016, E-0017)
Map20Attrs0_Y7X7::
    INCBIN "maps/map20/attrs0_y7_x7.lz"

; compressed tileset of map $21 (the first map record using it)
; LZSS-compressed: 1248 bytes that expand to 1536 (E-0016, E-0017)
Map21Tileset::
    INCBIN "maps/map21/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map21Palettes::
    dw $7c01, $7fff, $6301, $0000 ; entry 0
    dw $0110, $3f7f, $0214, $0000 ; entry 1
    dw $02c4, $3f7f, $029a, $0000 ; entry 2
    dw $014f, $7fff, $029a, $0000 ; entry 3
    dw $318c, $6318, $4a52, $0000 ; entry 4
    dw $2894, $3f7f, $029a, $0000 ; entry 5
    dw $2111, $3a5c, $21b8, $0000 ; entry 6
    dw $218c, $4f18, $3a52, $0000 ; entry 7

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map21Screens0::
    dfar Map21Screens0_Y0X0 ; entry 0
    dfar Map21Screens0_Y0X1 ; entry 1

Map21Attrs0::
    dfar Map21Attrs0_Y0X0 ; entry 0
    dfar Map21Attrs0_Y0X1 ; entry 1

; LZSS-compressed: 235 bytes that expand to 360 (E-0016, E-0017)
Map21Screens0_Y0X0::
    INCBIN "maps/map21/screens0_y0_x0.lz"

; LZSS-compressed: 231 bytes that expand to 360 (E-0016, E-0017)
Map21Screens0_Y0X1::
    INCBIN "maps/map21/screens0_y0_x1.lz"

; LZSS-compressed: 84 bytes that expand to 360 (E-0016, E-0017)
Map21Attrs0_Y0X0::
    INCBIN "maps/map21/attrs0_y0_x0.lz"

; LZSS-compressed: 114 bytes that expand to 360 (E-0016, E-0017)
Map21Attrs0_Y0X1::
    INCBIN "maps/map21/attrs0_y0_x1.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map26Palettes::
    dw $5816, $7fff, $699a, $0000 ; entry 0
    dw $218c, $4f18, $3a52, $0ca5 ; entry 1
    dw $0116, $03ff, $01fc, $0ca5 ; entry 2
    dw $2111, $3a5c, $21b8, $0044 ; entry 3
    dw $02c6, $3f7f, $029a, $0044 ; entry 4
    dw $2217, $03ff, $5b9c, $0842 ; entry 5
    dw $218c, $4f18, $3a52, $0ca5 ; entry 6
    dw $218c, $4f18, $3a52, $0ca5 ; entry 7

Map28Palettes::
    dw $7c01, $7fff, $6301, $0000 ; entry 0
    dw $01d3, $3f7f, $029a, $0042 ; entry 1
    dw $02c0, $3f7f, $03e2, $0000 ; entry 2
    dw $012f, $2b3f, $01d8, $0000 ; entry 3
    dw $001b, $2bff, $023f, $0000 ; entry 4
    dw $1528, $4f18, $3a52, $0000 ; entry 5
    dw $218c, $4f18, $3a52, $0000 ; entry 6
    dw $218c, $4f18, $3a52, $0000 ; entry 7

; compressed tileset of map $2A (the first map record using it)
; LZSS-compressed: 714 bytes that expand to 1280 (E-0016, E-0017)
Map2ATileset::
    INCBIN "maps/map2_a/tileset.lz"

Map2APalettes::
    dw $7c01, $7fff, $6301, $0000 ; entry 0
    dw $01d3, $3f7f, $029a, $0042 ; entry 1
    dw $01ca, $7fff, $029a, $0042 ; entry 2
    dw $2111, $3a5c, $21b8, $0000 ; entry 3
    dw $012f, $7fff, $01da, $0000 ; entry 4
    dw $218c, $4f18, $3a52, $0000 ; entry 5
    dw $0173, $7fff, $6b2b, $0084 ; entry 6
    dw $218c, $4f18, $3a52, $0000 ; entry 7

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map2AScreens0::
    dfar Map2AScreens0_Y0X0 ; entry 0

Map2AAttrs0::
    dfar Map2AAttrs0_Y0X0 ; entry 0

; LZSS-compressed: 188 bytes that expand to 360 (E-0016, E-0017)
Map2AScreens0_Y0X0::
    INCBIN "maps/map2_a/screens0_y0_x0.lz"

; LZSS-compressed: 52 bytes that expand to 360 (E-0016, E-0017)
Map2AAttrs0_Y0X0::
    db $68, $01, $05, $03, $05, $00, $09, $04, $04, $05, $00, $0a, $05, $0a, $08, $01
    db $05, $2a, $05, $05, $fa, $f6, $05, $2a, $0f, $4d, $05, $24, $04, $05, $10, $0e
    db $05, $a4, $0f, $27, $05, $3e, $06, $05, $3e, $00, $02, $02, $05, $ee, $0f, $2d
    db $05, $a2, $0f, $13
    ds $3b1, $00
