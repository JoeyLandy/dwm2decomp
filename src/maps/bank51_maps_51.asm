; ROM bank $51: map screens, attributes and tilesets
; The annotated listing of this bank is build/listing/bank51.asm.

SECTION "Bank 51", ROMX
    db $51

; LZSS-compressed: 137 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y10X2::
    INCBIN "maps/map70/screens0_y10_x2.lz"

; LZSS-compressed: 222 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y10X3::
    INCBIN "maps/map70/screens0_y10_x3.lz"

; LZSS-compressed: 139 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y10X4::
    INCBIN "maps/map70/screens0_y10_x4.lz"

; LZSS-compressed: 230 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y10X5::
    INCBIN "maps/map70/screens0_y10_x5.lz"

; LZSS-compressed: 228 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y10X6::
    INCBIN "maps/map70/screens0_y10_x6.lz"

; LZSS-compressed: 193 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y10X9::
    INCBIN "maps/map70/screens0_y10_x9.lz"

; LZSS-compressed: 239 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y10X10::
    INCBIN "maps/map70/screens0_y10_x10.lz"

; LZSS-compressed: 212 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y10X11::
    INCBIN "maps/map70/screens0_y10_x11.lz"

; LZSS-compressed: 154 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y11X0::
    INCBIN "maps/map70/screens0_y11_x0.lz"

; LZSS-compressed: 166 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y11X1::
    INCBIN "maps/map70/screens0_y11_x1.lz"

; LZSS-compressed: 203 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y11X2::
    INCBIN "maps/map70/screens0_y11_x2.lz"

; LZSS-compressed: 191 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y11X3::
    INCBIN "maps/map70/screens0_y11_x3.lz"

; LZSS-compressed: 188 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y11X4::
    INCBIN "maps/map70/screens0_y11_x4.lz"

; LZSS-compressed: 186 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y11X5::
    INCBIN "maps/map70/screens0_y11_x5.lz"

; LZSS-compressed: 161 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y11X6::
    INCBIN "maps/map70/screens0_y11_x6.lz"

; LZSS-compressed: 179 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y11X10::
    INCBIN "maps/map70/screens0_y11_x10.lz"

Map70Screens0_Y11X11::
    INCBIN "maps/map70/screens0_y11_x11.lz"

; compressed tileset of map $70 (the first map record using it)
; LZSS-compressed: 1493 bytes that expand to 1920 (E-0016, E-0017)
Map70Tileset::
    INCBIN "maps/map70/tileset.lz"

; 144 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map70Attrs0::
    dfar Map70Attrs0_Y0X0 ; entry 0
    dfar Map70Attrs0_Y0X1 ; entry 1
    dfar Map70Attrs0_Y0X2 ; entry 2
    dfar Map70Attrs0_Y0X3 ; entry 3
    dfar Map70Attrs0_Y0X4 ; entry 4
    dfar Map70Attrs0_Y0X5 ; entry 5
    dfar Map70Attrs0_Y0X0 ; entry 6
    dfar Map70Attrs0_Y0X0 ; entry 7
    dfar Map70Attrs0_Y0X0 ; entry 8
    dfar Map70Attrs0_Y0X0 ; entry 9
    dfar Map70Attrs0_Y0X0 ; entry 10
    dfar Map70Attrs0_Y0X0 ; entry 11
    dfar Map70Attrs0_Y0X0 ; entry 12
    dfar Map70Attrs0_Y1X1 ; entry 13
    dfar Map70Attrs0_Y1X2 ; entry 14
    dfar Map70Attrs0_Y0X0 ; entry 15
    dfar Map70Attrs0_Y1X4 ; entry 16
    dfar Map70Attrs0_Y1X5 ; entry 17
    dfar Map70Attrs0_Y1X6 ; entry 18
    dfar Map70Attrs0_Y0X0 ; entry 19
    dfar Map70Attrs0_Y0X0 ; entry 20
    dfar Map70Attrs0_Y0X0 ; entry 21
    dfar Map70Attrs0_Y1X10 ; entry 22
    dfar Map70Attrs0_Y1X11 ; entry 23
    dfar Map70Attrs0_Y0X0 ; entry 24
    dfar Map70Attrs0_Y2X1 ; entry 25
    dfar Map70Attrs0_Y0X0 ; entry 26
    dfar Map70Attrs0_Y0X0 ; entry 27
    dfar Map70Attrs0_Y2X4 ; entry 28
    dfar Map70Attrs0_Y2X5 ; entry 29
    dfar Map70Attrs0_Y2X6 ; entry 30
    dfar Map70Attrs0_Y2X7 ; entry 31
    dfar Map70Attrs0_Y0X0 ; entry 32
    dfar Map70Attrs0_Y0X0 ; entry 33
    dfar Map70Attrs0_Y2X10 ; entry 34
    dfar Map70Attrs0_Y2X11 ; entry 35
    dfar Map70Attrs0_Y0X0 ; entry 36
    dfar Map70Attrs0_Y0X0 ; entry 37
    dfar Map70Attrs0_Y3X2 ; entry 38
    dfar Map70Attrs0_Y3X3 ; entry 39
    dfar Map70Attrs0_Y0X0 ; entry 40
    dfar Map70Attrs0_Y3X5 ; entry 41
    dfar Map70Attrs0_Y3X6 ; entry 42
    dfar Map70Attrs0_Y3X7 ; entry 43
    dfar Map70Attrs0_Y3X8 ; entry 44
    dfar Map70Attrs0_Y3X9 ; entry 45
    dfar Map70Attrs0_Y3X10 ; entry 46
    dfar Map70Attrs0_Y3X11 ; entry 47
    dfar Map70Attrs0_Y4X0 ; entry 48
    dfar Map70Attrs0_Y4X1 ; entry 49
    dfar Map70Attrs0_Y4X2 ; entry 50
    dfar Map70Attrs0_Y4X3 ; entry 51
    dfar Map70Attrs0_Y4X4 ; entry 52
    dfar Map70Attrs0_Y0X0 ; entry 53
    dfar Map70Attrs0_Y4X6 ; entry 54
    dfar Map70Attrs0_Y0X0 ; entry 55
    dfar Map70Attrs0_Y4X8 ; entry 56
    dfar Map70Attrs0_Y4X9 ; entry 57
    dfar Map70Attrs0_Y4X10 ; entry 58
    dfar Map70Attrs0_Y4X11 ; entry 59
    dfar Map70Attrs0_Y5X0 ; entry 60
    dfar Map70Attrs0_Y5X1 ; entry 61
    dfar Map70Attrs0_Y5X2 ; entry 62
    dfar Map70Attrs0_Y5X3 ; entry 63
    dfar Map70Attrs0_Y5X4 ; entry 64
    dfar Map70Attrs0_Y0X0 ; entry 65
    dfar Map70Attrs0_Y5X6 ; entry 66
    dfar Map70Attrs0_Y5X7 ; entry 67
    dfar Map70Attrs0_Y5X8 ; entry 68
    dfar Map70Attrs0_Y5X9 ; entry 69
    dfar Map70Attrs0_Y0X0 ; entry 70
    dfar Map70Attrs0_Y0X0 ; entry 71
    dfar Map70Attrs0_Y0X0 ; entry 72
    dfar Map70Attrs0_Y6X1 ; entry 73
    dfar Map70Attrs0_Y6X2 ; entry 74
    dfar Map70Attrs0_Y6X3 ; entry 75
    dfar Map70Attrs0_Y6X4 ; entry 76
    dfar Map70Attrs0_Y6X5 ; entry 77
    dfar Map70Attrs0_Y6X6 ; entry 78
    dfar Map70Attrs0_Y6X7 ; entry 79
    dfar Map70Attrs0_Y6X8 ; entry 80
    dfar Map70Attrs0_Y6X9 ; entry 81
    dfar Map70Attrs0_Y0X0 ; entry 82
    dfar Map70Attrs0_Y0X0 ; entry 83
    dfar Map70Attrs0_Y0X0 ; entry 84
    dfar Map70Attrs0_Y7X1 ; entry 85
    dfar Map70Attrs0_Y7X2 ; entry 86
    dfar Map70Attrs0_Y7X3 ; entry 87
    dfar Map70Attrs0_Y7X4 ; entry 88
    dfar Map70Attrs0_Y7X5 ; entry 89
    dfar Map70Attrs0_Y7X6 ; entry 90
    dfar Map70Attrs0_Y7X7 ; entry 91
    dfar Map70Attrs0_Y7X8 ; entry 92
    dfar Map70Attrs0_Y7X9 ; entry 93
    dfar Map70Attrs0_Y0X0 ; entry 94
    dfar Map70Attrs0_Y0X0 ; entry 95
    dfar Map70Attrs0_Y8X0 ; entry 96
    dfar Map70Attrs0_Y8X1 ; entry 97
    dfar Map70Attrs0_Y0X0 ; entry 98
    dfar Map70Attrs0_Y8X3 ; entry 99
    dfar Map70Attrs0_Y8X4 ; entry 100
    dfar Map70Attrs0_Y8X5 ; entry 101
    dfar Map70Attrs0_Y8X6 ; entry 102
    dfar Map70Attrs0_Y8X7 ; entry 103
    dfar Map70Attrs0_Y8X8 ; entry 104
    dfar Map70Attrs0_Y8X9 ; entry 105
    dfar Map70Attrs0_Y0X0 ; entry 106
    dfar Map70Attrs0_Y0X0 ; entry 107
    dfar Map70Attrs0_Y9X0 ; entry 108
    dfar Map70Attrs0_Y9X1 ; entry 109
    dfar Map70Attrs0_Y0X0 ; entry 110
    dfar Map70Attrs0_Y0X0 ; entry 111
    dfar Map70Attrs0_Y9X4 ; entry 112
    dfar Map70Attrs0_Y9X5 ; entry 113
    dfar Map70Attrs0_Y9X6 ; entry 114
    dfar Map70Attrs0_Y9X7 ; entry 115
    dfar Map70Attrs0_Y9X8 ; entry 116
    dfar Map70Attrs0_Y9X9 ; entry 117
    dfar Map70Attrs0_Y9X10 ; entry 118
    dfar Map70Attrs0_Y9X11 ; entry 119
    dfar Map70Attrs0_Y10X0 ; entry 120
    dfar Map70Attrs0_Y10X1 ; entry 121
    dfar Map70Attrs0_Y10X2 ; entry 122
    dfar Map70Attrs0_Y10X3 ; entry 123
    dfar Map70Attrs0_Y10X4 ; entry 124
    dfar Map70Attrs0_Y10X5 ; entry 125
    dfar Map70Attrs0_Y10X6 ; entry 126
    dfar Map70Attrs0_Y0X0 ; entry 127
    dfar Map70Attrs0_Y0X0 ; entry 128
    dfar Map70Attrs0_Y10X9 ; entry 129
    dfar Map70Attrs0_Y10X10 ; entry 130
    dfar Map70Attrs0_Y10X11 ; entry 131
    dfar Map70Attrs0_Y11X0 ; entry 132
    dfar Map70Attrs0_Y11X1 ; entry 133
    dfar Map70Attrs0_Y11X2 ; entry 134
    dfar Map70Attrs0_Y11X3 ; entry 135
    dfar Map70Attrs0_Y11X4 ; entry 136
    dfar Map70Attrs0_Y11X5 ; entry 137
    dfar Map70Attrs0_Y11X6 ; entry 138
    dfar Map70Attrs0_Y0X0 ; entry 139
    dfar Map70Attrs0_Y0X0 ; entry 140
    dfar Map70Attrs0_Y0X0 ; entry 141
    dfar Map70Attrs0_Y11X10 ; entry 142
    dfar Map70Attrs0_Y11X11 ; entry 143

; LZSS-compressed: 19 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y0X0::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $5f, $0f, $4d, $01, $bf, $0f, $4d, $01
    db $1f, $1f, $35

; LZSS-compressed: 44 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y0X1::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $22, $0f, $0f, $02, $01, $82, $01, $01
    db $74, $0f, $0b, $01, $82, $02, $01, $a6, $04, $01, $a0, $0f, $05, $01, $a6, $0a
    db $01, $c6, $0f, $2f, $01, $a4, $0f, $15, $01, $1c, $1f, $11

; LZSS-compressed: 47 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y0X2::
    db $68, $01, $01, $01, $ff, $ff, $41, $02, $02, $02, $02, $01, $44, $0f, $0f, $01
    db $54, $00, $01, $7a, $02, $01, $70, $0f, $09, $01, $7a, $06, $01, $54, $06, $01
    db $a0, $0f, $33, $01, $70, $0f, $13, $01, $6e, $0f, $01, $01, $20, $1f, $21

; LZSS-compressed: 62 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y0X3::
    db $68, $01, $01, $01, $ff, $ff, $17, $02, $02, $01, $18, $0f, $15, $01, $2a, $0e
    db $01, $52, $0f, $01, $01, $50, $02, $01, $2a, $04, $01, $52, $04, $01, $7c, $0f
    db $07, $01, $a4, $06, $01, $a0, $0f, $05, $01, $a2, $0c, $01, $c8, $0f, $07, $01
    db $c8, $0a, $01, $f0, $0f, $0d, $01, $4e, $0f, $1b, $01, $51, $1f, $03

; LZSS-compressed: 54 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y0X4::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $18, $0f, $05, $02, $01, $78, $01, $01
    db $6a, $0f, $15, $01, $7c, $02, $01, $78, $04, $01, $a0, $0f, $09, $01, $c8, $0f
    db $3b, $03, $03, $03, $03, $01, $0e, $1f, $0b, $01, $18, $00, $01, $1e, $10, $01
    db $1e, $18, $01, $40, $1f, $01

; LZSS-compressed: 43 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y0X5::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $5f, $0f, $4d, $01, $68, $04, $02, $01
    db $c8, $01, $01, $ba, $0f, $15, $01, $cc, $0a, $01, $f0, $0f, $09, $01, $c8, $08
    db $01, $18, $1f, $0d, $01, $10, $1f, $01, $01, $68, $04

Map70Attrs0_Y1X1::
    db $68, $01, $01, $01, $ff, $f2, $02, $01, $06, $09, $01, $00, $0f, $2d, $01, $06
    db $0a, $01, $4e, $0f, $15, $03, $03, $01, $78, $0f, $03, $01, $7c, $0c, $01, $9e
    db $0f, $05, $01, $04, $08, $01, $c4, $04, $01, $ca, $0f, $03, $01, $04, $06, $01
    db $fa, $ff, $01, $01, $f6, $fe, $01, $f4, $ff, $01, $01, $a0, $ff, $1d

; LZSS-compressed: 61 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y1X2::
    db $68, $01, $01, $02, $01, $00, $03, $01, $f4, $ff, $15, $01, $06, $08, $01, $28
    db $0f, $0b, $01, $06, $06, $01, $50, $0f, $01, $03, $03, $01, $66, $0f, $15, $01
    db $78, $02, $03, $03, $01, $f6, $f6, $01, $a0, $0f, $01, $01, $9c, $04, $01, $f0
    db $fc, $01, $cc, $0f, $01, $01, $f3, $0f, $4d, $01, $53, $1f, $01

; LZSS-compressed: 99 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y1X4::
    INCBIN "maps/map70/attrs0_y1_x4.lz"

; LZSS-compressed: 60 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y1X5::
    db $68, $01, $01, $02, $01, $00, $07, $01, $f8, $ff, $3d, $01, $08, $04, $01, $50
    db $0f, $01, $03, $03, $03, $03, $01, $50, $0c, $01, $78, $0f, $05, $01, $a0, $02
    db $01, $96, $0f, $0b, $01, $88, $06, $01, $7a, $0a, $01, $cc, $0f, $01, $01, $98
    db $0a, $01, $ee, $0f, $0f, $01, $86, $04, $01, $18, $1f, $29

; LZSS-compressed: 53 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y1X6::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $18, $0f, $05, $02, $01, $78, $01, $01
    db $6a, $0f, $15, $01, $7a, $0a, $01, $a0, $0f, $0b, $01, $7c, $06, $01, $c8, $0f
    db $0d, $01, $7c, $04, $01, $f0, $0f, $01, $03, $03, $01, $06, $1f, $15, $01, $18
    db $18, $01, $3a, $1f, $07

; LZSS-compressed: 66 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y1X10::
    INCBIN "maps/map70/attrs0_y1_x10.lz"

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y1X11::
    INCBIN "maps/map70/attrs0_y1_x11.lz"

; LZSS-compressed: 80 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y2X1::
    INCBIN "maps/map70/attrs0_y2_x1.lz"

; LZSS-compressed: 91 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y2X4::
    INCBIN "maps/map70/attrs0_y2_x4.lz"

; LZSS-compressed: 72 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y2X5::
    INCBIN "maps/map70/attrs0_y2_x5.lz"

; LZSS-compressed: 64 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y2X6::
    db $68, $01, $01, $03, $03, $03, $03, $02, $01, $04, $05, $01, $fa, $ff, $09, $01
    db $04, $06, $01, $0a, $04, $01, $28, $0f, $03, $01, $28, $0a, $01, $4c, $0f, $09
    db $01, $28, $0c, $01, $78, $0f, $07, $01, $28, $0a, $01, $a0, $0f, $07, $01, $0a
    db $04, $01, $c2, $0f, $09, $01, $f2, $fa, $01, $ec, $0f, $05, $01, $a0, $ff, $3d

; LZSS-compressed: 51 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y2X7::
    db $68, $01, $01, $01, $ff, $ff, $1d, $02, $02, $02, $02, $01, $20, $0f, $0b, $01
    db $30, $00, $01, $52, $04, $01, $4a, $0f, $07, $01, $52, $08, $01, $70, $0f, $15
    db $01, $4a, $0f, $11, $01, $24, $0c, $01, $cc, $0f, $01, $01, $20, $0f, $11, $01
    db $17, $1f, $3d

; LZSS-compressed: 52 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y2X10::
    db $68, $01, $01, $01, $ff, $f2, $03, $03, $02, $01, $08, $07, $01, $00, $0f, $2d
    db $03, $01, $54, $01, $01, $46, $0f, $3d, $01, $06, $06, $01, $a0, $0f, $05, $01
    db $52, $0c, $01, $c8, $0f, $07, $01, $52, $02, $01, $e8, $0f, $11, $01, $f6, $08
    db $01, $18, $1f, $29

; LZSS-compressed: 37 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y2X11::
    db $68, $01, $01, $02, $01, $00, $07, $03, $03, $03, $03, $01, $fc, $ff, $39, $01
    db $0a, $04, $01, $50, $0f, $39, $01, $4c, $0f, $01, $01, $b0, $0f, $4d, $01, $be
    db $04, $01, $18, $1f, $29

Map70Attrs0_Y3X2::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $24, $0f, $11, $02, $01, $84, $03, $01
    db $78, $0f, $07, $01, $84, $04, $01, $9a, $0f, $0b, $01, $a6, $0a, $01, $c6, $0f
    db $3b, $03, $03, $03, $03, $01, $18, $1f, $05, $01, $82, $06, $01, $28, $10, $01
    db $3e, $1f, $03

; LZSS-compressed: 83 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y3X3::
    INCBIN "maps/map70/attrs0_y3_x3.lz"

; LZSS-compressed: 43 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y3X5::
    db $68, $01, $01, $01, $ff, $f4, $03, $01, $08, $03, $01, $fc, $ff, $0d, $01, $06
    db $04, $01, $24, $0f, $13, $01, $f8, $ff, $01, $01, $5e, $0f, $4d, $01, $70, $0e
    db $01, $d0, $0f, $03, $01, $f9, $0f, $4d, $01, $59, $1a

Map70Attrs0_Y3X6::
    db $68, $01, $01, $01, $ff, $ff, $1b, $02, $01, $2e, $05, $01, $24, $0f, $09, $01
    db $2e, $06, $01, $32, $06, $01, $54, $0f, $29, $01, $52, $0c, $01, $a0, $0f, $2b
    db $01, $54, $0f, $4b, $01, $4c, $0f, $01, $01, $a0, $f0

; LZSS-compressed: 57 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y3X7::
    db $68, $01, $01, $01, $ff, $ff, $1f, $02, $02, $02, $02, $01, $22, $0f, $07, $01
    db $32, $04, $01, $32, $00, $01, $50, $08, $01, $54, $0f, $01, $01, $78, $06, $01
    db $2c, $06, $01, $7c, $0f, $31, $01, $2a, $08, $01, $cc, $0c, $01, $56, $04, $01
    db $24, $0e, $01, $34, $0e, $01, $1b, $1f, $39

; LZSS-compressed: 47 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y3X8::
    db $68, $01, $01, $01, $ff, $ff, $25, $02, $02, $02, $02, $01, $28, $0f, $0f, $01
    db $38, $00, $01, $4e, $0f, $0d, $01, $5e, $02, $01, $74, $0f, $0d, $01, $82, $06
    db $01, $9e, $0f, $31, $01, $a8, $08, $01, $ee, $0f, $31, $01, $a6, $0f, $0f

Map70Attrs0_Y3X9::
    db $68, $01, $01, $01, $ff, $ff, $15, $02, $02, $02, $02, $01, $18, $0f, $15, $01
    db $50, $02, $01, $46, $0f, $15, $01, $2a, $06, $01, $78, $0f, $0d, $01, $2a, $04
    db $01, $a0, $0f, $37, $01, $2a, $02, $01, $f0, $0f, $37, $01, $9a, $0f, $07

; LZSS-compressed: 62 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y3X10::
    db $68, $01, $01, $01, $ff, $f6, $03, $03, $03, $03, $02, $01, $0e, $01, $01, $00
    db $0f, $0d, $01, $0e, $02, $01, $26, $0f, $35, $01, $30, $04, $03, $03, $01, $78
    db $0f, $33, $01, $0c, $04, $01, $c6, $0f, $0b, $01, $32, $06, $01, $ee, $0f, $09
    db $01, $f8, $08, $01, $16, $1f, $07, $01, $0a, $06, $01, $3a, $1f, $07

; LZSS-compressed: 65 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y3X11::
    INCBIN "maps/map70/attrs0_y3_x11.lz"

; LZSS-compressed: 59 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y4X0::
    db $68, $01, $01, $01, $ff, $ff, $23, $02, $02, $01, $24, $0f, $0d, $02, $01, $58
    db $05, $01, $4e, $0f, $09, $01, $58, $06, $01, $5e, $06, $01, $7e, $0e, $01, $7e
    db $0a, $01, $9e, $0f, $07, $01, $7c, $0f, $15, $01, $7a, $0c, $01, $f0, $0f, $09
    db $01, $56, $0f, $15, $01, $54, $08, $01, $40, $1f, $01

; LZSS-compressed: 80 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y4X1::
    INCBIN "maps/map70/attrs0_y4_x1.lz"

; LZSS-compressed: 76 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y4X2::
    INCBIN "maps/map70/attrs0_y4_x2.lz"

; LZSS-compressed: 53 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y4X3::
    db $68, $01, $01, $03, $01, $00, $01, $02, $01, $06, $03, $01, $fa, $ff, $0b, $01
    db $06, $04, $01, $20, $0f, $35, $01, $2a, $0c, $01, $78, $0f, $11, $01, $06, $00
    db $01, $a0, $0f, $07, $01, $a4, $0a, $01, $c8, $0f, $4d, $01, $d8, $08, $01, $2a
    db $08, $01, $40, $1f, $01

; LZSS-compressed: 40 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y4X4::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $40, $0f, $2d, $02, $02, $02, $02, $01
    db $90, $0f, $15, $01, $a0, $0c, $01, $c8, $0f, $09, $01, $a2, $08, $01, $f0, $0f
    db $0b, $01, $a2, $06, $01, $18, $1f, $29

; LZSS-compressed: 56 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y4X6::
    db $68, $01, $01, $01, $ff, $f0, $02, $01, $04, $07, $01, $fc, $ff, $15, $01, $0e
    db $04, $01, $2c, $0e, $01, $2c, $0a, $01, $4c, $0f, $15, $01, $26, $0f, $07, $01
    db $02, $08, $01, $fa, $ff, $01, $01, $fa, $fe, $01, $f8, $ff, $01, $01, $f6, $fc
    db $01, $f2, $ff, $01, $01, $a0, $ff, $49

; LZSS-compressed: 50 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y4X8::
    db $68, $01, $01, $01, $ff, $f4, $02, $01, $08, $07, $01, $00, $0f, $07, $01, $08
    db $08, $01, $26, $0f, $4d, $01, $5e, $0f, $1f, $01, $6a, $0a, $01, $c6, $0f, $15
    db $01, $64, $0f, $07, $01, $04, $0a, $01, $16, $1f, $13, $01, $fc, $ff, $01, $01
    db $a0, $f0

; LZSS-compressed: 57 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y4X9::
    db $68, $01, $03, $02, $03, $00, $09, $03, $fa, $ff, $3b, $03, $f8, $ff, $01, $03
    db $f8, $fe, $03, $f6, $ff, $01, $03, $f6, $fe, $01, $01, $03, $96, $0f, $13, $03
    db $80, $0f, $0d, $03, $fe, $f6, $03, $e6, $0f, $0d, $03, $fe, $f2, $03, $f0, $ff
    db $01, $03, $ee, $ff, $01, $03, $34, $1f, $0d

; LZSS-compressed: 73 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y4X10::
    INCBIN "maps/map70/attrs0_y4_x10.lz"

; LZSS-compressed: 82 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y4X11::
    INCBIN "maps/map70/attrs0_y4_x11.lz"

; LZSS-compressed: 36 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y5X0::
    db $68, $01, $01, $01, $ff, $f8, $02, $01, $0c, $03, $01, $00, $0f, $35, $01, $0a
    db $04, $01, $50, $0f, $0f, $01, $0a, $02, $01, $78, $0f, $11, $01, $af, $0f, $4d
    db $01, $0f, $1f, $45

; LZSS-compressed: 76 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y5X1::
    INCBIN "maps/map70/attrs0_y5_x1.lz"

; LZSS-compressed: 86 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y5X2::
    INCBIN "maps/map70/attrs0_y5_x2.lz"

; LZSS-compressed: 68 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y5X3::
    INCBIN "maps/map70/attrs0_y5_x3.lz"

; LZSS-compressed: 65 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y5X4::
    INCBIN "maps/map70/attrs0_y5_x4.lz"

; LZSS-compressed: 42 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y5X6::
    db $68, $01, $01, $01, $ff, $ff, $21, $02, $02, $01, $22, $0f, $11, $02, $01, $5a
    db $01, $01, $4c, $0f, $0d, $01, $5a, $02, $01, $5a, $0a, $01, $80, $0f, $29, $01
    db $7e, $08, $01, $c8, $0f, $4d, $01, $00, $1f, $19

; LZSS-compressed: 41 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y5X7::
    db $68, $01, $01, $01, $ff, $ff, $25, $02, $02, $01, $26, $0f, $0f, $02, $01, $5c
    db $03, $01, $50, $0f, $01, $01, $5e, $06, $01, $70, $0a, $01, $7c, $0f, $03, $01
    db $a5, $0f, $4d, $01, $05, $1f, $4d, $02, $02

; LZSS-compressed: 53 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y5X8::
    db $68, $01, $01, $01, $ff, $f4, $02, $01, $08, $03, $01, $fc, $ff, $2d, $01, $48
    db $08, $01, $0e, $04, $01, $50, $0f, $05, $01, $78, $06, $01, $72, $0f, $0f, $01
    db $02, $04, $01, $9c, $0f, $0b, $01, $00, $08, $01, $c6, $0f, $0f, $01, $78, $0f
    db $0f, $01, $10, $1f, $37

; LZSS-compressed: 47 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y5X9::
    db $68, $01, $01, $01, $ff, $f2, $02, $02, $01, $f4, $ff, $15, $01, $06, $0e, $01
    db $2e, $0f, $05, $01, $06, $0c, $01, $56, $0f, $07, $01, $06, $0a, $01, $7e, $0e
    db $01, $7e, $0f, $41, $01, $e4, $0f, $17, $01, $06, $06, $01, $18, $1f, $29

; LZSS-compressed: 79 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y6X1::
    INCBIN "maps/map70/attrs0_y6_x1.lz"

; LZSS-compressed: 58 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y6X2::
    db $68, $01, $00, $03, $00, $00, $0f, $3c, $02, $02, $02, $02, $00, $48, $06, $00
    db $4a, $0f, $0b, $00, $5c, $0c, $00, $78, $0f, $0b, $00, $7a, $0a, $00, $a4, $0f
    db $03, $00, $c8, $04, $00, $c2, $0f, $15, $00, $86, $08, $00, $f6, $0f, $0b, $00
    db $52, $00, $00, $18, $1f, $11, $00, $ec, $0f, $05

; LZSS-compressed: 57 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y6X3::
    db $68, $01, $00, $03, $00, $00, $03, $02, $00, $08, $03, $00, $00, $04, $00, $04
    db $0f, $2b, $00, $0a, $0e, $00, $54, $0f, $01, $00, $08, $04, $00, $4a, $0e, $00
    db $0c, $0e, $01, $01, $00, $06, $02, $00, $9c, $0f, $0b, $00, $00, $06, $00, $c4
    db $0f, $13, $00, $fd, $0f, $4d, $00, $10, $06

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y6X4::
    INCBIN "maps/map70/attrs0_y6_x4.lz"

; LZSS-compressed: 48 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y6X5::
    db $68, $01, $01, $01, $ff, $ff, $43, $02, $02, $01, $44, $0f, $11, $02, $01, $7c
    db $01, $01, $78, $04, $01, $76, $0f, $03, $01, $7c, $02, $02, $02, $04, $04, $04
    db $04, $01, $a0, $04, $01, $a0, $0f, $09, $01, $cf, $0f, $4d, $01, $08, $1f, $25

Map70Attrs0_Y6X6::
    db $68, $01, $01, $01, $ff, $f6, $02, $01, $0a, $05, $01, $00, $0f, $2f, $01, $0a
    db $06, $01, $4c, $0f, $09, $01, $56, $0a, $01, $76, $0f, $03, $01, $9f, $0f, $4d
    db $01, $ca, $0f, $17, $03, $03, $01, $18, $1f, $11, $03, $03, $01, $3e, $1f, $03

; LZSS-compressed: 59 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y6X7::
    db $68, $01, $01, $02, $01, $00, $0f, $44, $01, $fa, $ff, $01, $01, $fa, $fe, $01
    db $f6, $ff, $01, $01, $7e, $0f, $29, $01, $56, $02, $01, $48, $0f, $01, $01, $00
    db $08, $03, $03, $01, $00, $0e, $01, $f4, $0c, $03, $01, $18, $13, $01, $f2, $02
    db $01, $1e, $12, $01, $18, $1f, $09, $01, $3e, $1f, $0d

; LZSS-compressed: 61 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y6X8::
    db $68, $01, $01, $02, $01, $00, $0f, $4d, $01, $4c, $0f, $38, $03, $03, $01, $aa
    db $00, $01, $ac, $00, $01, $a2, $0f, $0d, $01, $d4, $02, $01, $c8, $0f, $0b, $01
    db $d4, $04, $01, $ee, $0f, $03, $01, $b0, $04, $01, $d4, $04, $01, $fc, $f0, $01
    db $18, $1f, $05, $01, $fa, $06, $01, $fa, $f2, $01, $40, $1f, $01

; LZSS-compressed: 70 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y6X9::
    INCBIN "maps/map70/attrs0_y6_x9.lz"

; LZSS-compressed: 39 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y7X1::
    db $68, $01, $01, $01, $ff, $f8, $02, $01, $0c, $03, $01, $00, $0f, $4d, $01, $24
    db $0c, $01, $1e, $04, $01, $78, $0f, $0f, $01, $1c, $02, $01, $a0, $0f, $13, $01
    db $d9, $0f, $4d, $01, $39, $1f, $1b

; LZSS-compressed: 62 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y7X2::
    db $68, $01, $01, $02, $01, $00, $0b, $03, $03, $03, $03, $01, $00, $0f, $11, $01
    db $0e, $00, $01, $28, $0f, $3b, $01, $fe, $fe, $01, $88, $0f, $01, $01, $fc, $ff
    db $01, $01, $fa, $ff, $01, $01, $c4, $0f, $07, $01, $fe, $f0, $01, $fa, $fa, $01
    db $f0, $0f, $05, $01, $f6, $fc, $01, $18, $1f, $0f, $01, $4d, $1f, $07

; LZSS-compressed: 59 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y7X3::
    db $68, $01, $04, $03, $04, $00, $0f, $4d, $04, $18, $0f, $04, $00, $00, $02, $02
    db $02, $02, $04, $6a, $0f, $11, $04, $fc, $f0, $02, $02, $01, $01, $03, $03, $04
    db $7c, $04, $04, $a0, $0f, $09, $04, $ce, $04, $04, $c4, $0f, $05, $04, $ce, $06
    db $04, $f0, $0f, $33, $04, $c8, $0c, $04, $3c, $1f, $05

; LZSS-compressed: 64 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y7X4::
    db $68, $01, $01, $03, $01, $00, $05, $02, $01, $0a, $05, $01, $00, $0f, $4d, $01
    db $10, $0a, $01, $1c, $06, $01, $78, $0f, $09, $01, $12, $02, $01, $9a, $0f, $0b
    db $01, $20, $08, $01, $c4, $0f, $05, $01, $ec, $0a, $01, $18, $0c, $01, $fa, $0c
    db $01, $fc, $f0, $01, $c2, $0c, $01, $1e, $1e, $01, $f8, $f4, $01, $38, $1f, $09

; LZSS-compressed: 45 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y7X5::
    db $68, $01, $00, $02, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $90, $0f, $1c
    db $03, $03, $00, $e2, $0c, $00, $00, $10, $00, $f2, $0f, $01, $00, $f0, $00, $00
    db $02, $14, $00, $14, $14, $00, $1a, $1f, $03, $00, $3a, $1f, $11

; LZSS-compressed: 70 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y7X6::
    INCBIN "maps/map70/attrs0_y7_x6.lz"

; LZSS-compressed: 37 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y7X7::
    db $68, $01, $01, $03, $01, $00, $0f, $3e, $01, $fc, $ff, $01, $01, $fc, $fe, $01
    db $fa, $ff, $01, $01, $78, $0f, $4d, $01, $88, $06, $01, $fe, $fa, $01, $f0, $0f
    db $2f, $01, $ce, $0f, $0f

; LZSS-compressed: 56 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y7X8::
    db $68, $01, $01, $03, $01, $00, $09, $01, $fa, $ff, $11, $02, $02, $02, $02, $01
    db $22, $0f, $0f, $01, $32, $06, $01, $4e, $0f, $09, $01, $32, $00, $01, $6e, $0f
    db $17, $01, $32, $04, $01, $a0, $0f, $07, $01, $a4, $08, $02, $02, $01, $c8, $0f
    db $2f, $01, $d0, $08, $01, $16, $1f, $2b

; LZSS-compressed: 68 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y7X9::
    INCBIN "maps/map70/attrs0_y7_x9.lz"

; LZSS-compressed: 40 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y8X0::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $50, $0f, $3d, $02, $02, $02, $02, $01
    db $a0, $0f, $09, $01, $b0, $00, $01, $d0, $04, $01, $c8, $0f, $07, $01, $d0, $08
    db $01, $ee, $0f, $31, $01, $ce, $0f, $0f

; LZSS-compressed: 54 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y8X1::
    db $68, $01, $01, $01, $ff, $ff, $43, $02, $02, $02, $02, $01, $46, $0f, $0d, $01
    db $56, $00, $01, $7a, $02, $01, $70, $0f, $09, $01, $7a, $06, $01, $56, $06, $01
    db $a0, $0f, $0d, $01, $98, $0f, $01, $01, $72, $0f, $1b, $01, $ee, $0f, $1f, $01
    db $6e, $0f, $01, $01, $a0, $f8

; LZSS-compressed: 43 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y8X3::
    db $68, $01, $01, $01, $ff, $f2, $02, $01, $06, $09, $01, $00, $0f, $2d, $01, $06
    db $0a, $01, $4e, $0f, $4d, $01, $0e, $0f, $21, $01, $04, $06, $01, $fa, $ff, $01
    db $01, $f8, $fe, $01, $f6, $ff, $01, $01, $a0, $ff, $1b

; LZSS-compressed: 69 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y8X4::
    INCBIN "maps/map70/attrs0_y8_x4.lz"

Map70Attrs0_Y8X5::
    db $68, $01, $00, $03, $00, $00, $0f, $4d, $00, $44, $0f, $30, $02, $02, $00, $9a
    db $08, $00, $a4, $02, $00, $a4, $0e, $00, $b0, $00, $00, $a4, $04, $00, $ca, $04
    db $00, $ca, $0e, $00, $ef, $0f, $4d, $00, $08, $1f, $05

; LZSS-compressed: 66 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y8X6::
    INCBIN "maps/map70/attrs0_y8_x6.lz"

; LZSS-compressed: 62 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y8X7::
    db $68, $01, $01, $01, $ff, $f2, $03, $01, $06, $09, $01, $00, $0f, $2d, $01, $06
    db $06, $02, $02, $01, $4c, $0f, $07, $01, $56, $06, $01, $82, $00, $01, $74, $0f
    db $05, $01, $7a, $0a, $01, $9a, $0f, $17, $01, $9a, $08, $01, $d0, $0e, $01, $d0
    db $06, $01, $98, $06, $01, $f6, $0e, $01, $f6, $0a, $01, $16, $1f, $2b

; LZSS-compressed: 93 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y8X8::
    INCBIN "maps/map70/attrs0_y8_x8.lz"

; LZSS-compressed: 59 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y8X9::
    db $68, $01, $01, $02, $01, $00, $0b, $01, $fc, $ff, $0d, $05, $05, $01, $1e, $0f
    db $0d, $01, $30, $00, $01, $30, $08, $01, $4e, $0f, $05, $01, $50, $06, $01, $f8
    db $f8, $01, $7c, $0f, $01, $01, $08, $08, $01, $9c, $0f, $0f, $01, $f6, $ff, $01
    db $01, $f4, $fc, $01, $f0, $ff, $01, $01, $a0, $ff, $4b

; LZSS-compressed: 55 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y9X0::
    db $68, $01, $01, $01, $ff, $f4, $02, $01, $08, $07, $01, $00, $0f, $2f, $01, $08
    db $08, $01, $4e, $0f, $15, $03, $03, $01, $78, $0f, $05, $01, $7e, $0a, $01, $9e
    db $0f, $11, $01, $b0, $00, $01, $c6, $0f, $2d, $01, $cc, $0c, $01, $16, $1f, $0b
    db $01, $24, $14, $01, $3c, $1f, $05

; LZSS-compressed: 51 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y9X1::
    db $68, $01, $01, $02, $01, $00, $03, $01, $f4, $ff, $15, $01, $06, $08, $01, $28
    db $0f, $05, $03, $03, $01, $42, $0f, $0f, $03, $03, $01, $54, $02, $01, $04, $08
    db $01, $78, $0f, $33, $01, $6e, $0f, $01, $01, $d2, $0f, $21, $01, $02, $0e, $01
    db $18, $1f, $29

; LZSS-compressed: 52 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y9X4::
    db $68, $01, $01, $01, $ff, $f2, $02, $01, $06, $09, $01, $00, $0f, $2f, $01, $02
    db $0a, $01, $50, $0f, $0b, $01, $00, $04, $01, $f4, $ff, $01, $01, $80, $0f, $13
    db $01, $54, $0f, $1b, $01, $44, $0f, $01, $01, $44, $0f, $0b, $01, $fa, $ff, $01
    db $01, $a0, $ff, $1d

Map70Attrs0_Y9X5::
    db $68, $01, $04, $02, $04, $00, $0f, $4d, $04, $18, $0f, $04, $04, $f8, $ff, $01
    db $04, $78, $0f, $09, $01, $01, $01, $01, $04, $98, $0f, $11, $04, $fe, $f6, $03
    db $03, $04, $c8, $0f, $31, $04, $d2, $06, $04, $16, $1f, $09, $04, $18, $06, $04
    db $3c, $1f, $05

; LZSS-compressed: 81 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y9X6::
    INCBIN "maps/map70/attrs0_y9_x6.lz"

; LZSS-compressed: 61 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y9X7::
    db $68, $01, $01, $03, $03, $03, $03, $02, $01, $04, $0b, $01, $00, $0f, $2b, $01
    db $fa, $f2, $01, $44, $0f, $0d, $01, $f8, $f4, $01, $6c, $0f, $13, $01, $72, $06
    db $01, $9c, $0f, $09, $01, $72, $0a, $01, $a0, $0c, $01, $d8, $0f, $07, $01, $de
    db $0f, $05, $01, $f0, $fc, $01, $18, $1f, $01, $01, $3f, $1f, $15

; LZSS-compressed: 69 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y9X8::
    INCBIN "maps/map70/attrs0_y9_x8.lz"

; LZSS-compressed: 64 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y9X9::
    db $68, $01, $03, $03, $a0, $ff, $4d, $03, $20, $0f, $0d, $02, $02, $02, $02, $03
    db $7c, $08, $03, $7c, $0f, $03, $02, $02, $01, $01, $03, $80, $00, $03, $aa, $02
    db $03, $a0, $0f, $09, $03, $ce, $08, $03, $c8, $0f, $07, $03, $cc, $0a, $03, $f0
    db $0f, $09, $03, $cc, $08, $03, $18, $1f, $0b, $03, $cc, $06, $03, $40, $1f, $01

; LZSS-compressed: 56 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y9X10::
    db $68, $01, $01, $01, $ff, $ff, $1b, $02, $01, $2e, $01, $01, $28, $04, $01, $28
    db $0f, $03, $01, $2e, $02, $01, $3a, $08, $01, $50, $0f, $01, $01, $52, $0a, $01
    db $72, $0f, $19, $01, $50, $0c, $01, $4c, $06, $01, $1e, $0f, $01, $01, $cc, $0f
    db $29, $01, $ca, $0c, $01, $18, $1f, $29

; LZSS-compressed: 63 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y9X11::
    db $68, $01, $01, $01, $ff, $ff, $15, $02, $02, $01, $20, $0f, $15, $01, $28, $02
    db $01, $50, $00, $01, $28, $04, $01, $50, $0f, $03, $01, $22, $0c, $01, $76, $0f
    db $03, $01, $f2, $ff, $2d, $01, $cc, $0f, $03, $01, $5c, $0c, $01, $f2, $0f, $07
    db $01, $52, $04, $03, $03, $01, $16, $1f, $11, $01, $1c, $0a, $01, $94, $08

; LZSS-compressed: 75 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y10X0::
    INCBIN "maps/map70/attrs0_y10_x0.lz"

; LZSS-compressed: 87 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y10X1::
    INCBIN "maps/map70/attrs0_y10_x1.lz"

; LZSS-compressed: 49 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y10X2::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $40, $0f, $2d, $02, $02, $02, $02, $01
    db $90, $0f, $15, $01, $a2, $0c, $01, $c8, $0f, $07, $01, $c8, $0a, $01, $f0, $0f
    db $01, $03, $03, $01, $f0, $0e, $01, $18, $1f, $03, $01, $40, $10, $01, $32, $1f
    db $0f

; LZSS-compressed: 55 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y10X3::
    db $68, $01, $01, $01, $ff, $ff, $1f, $02, $02, $01, $20, $0f, $0d, $02, $01, $54
    db $07, $01, $4c, $0f, $07, $01, $54, $08, $01, $5c, $04, $01, $7a, $0f, $29, $01
    db $78, $0c, $01, $c6, $0f, $13, $01, $4c, $0f, $09, $01, $52, $04, $01, $24, $0c
    db $01, $20, $1e, $01, $45, $1f, $0f

; LZSS-compressed: 59 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y10X4::
    db $68, $01, $01, $01, $a0, $ff, $4d, $00, $00, $03, $03, $01, $50, $0f, $11, $03
    db $03, $01, $76, $0f, $11, $03, $03, $02, $02, $02, $02, $01, $a0, $0f, $0d, $01
    db $ae, $02, $01, $c6, $0f, $0f, $01, $d6, $02, $01, $ee, $0f, $0d, $01, $d4, $04
    db $01, $16, $1f, $0b, $01, $88, $00, $01, $38, $1f, $09

; LZSS-compressed: 85 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y10X5::
    INCBIN "maps/map70/attrs0_y10_x5.lz"

; LZSS-compressed: 78 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y10X6::
    INCBIN "maps/map70/attrs0_y10_x6.lz"

; LZSS-compressed: 54 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y10X9::
    db $68, $01, $01, $01, $ff, $f8, $02, $01, $0c, $03, $01, $00, $0f, $0b, $01, $0c
    db $04, $01, $26, $0f, $09, $01, $32, $06, $01, $4c, $0f, $09, $01, $56, $0a, $01
    db $76, $0f, $2f, $01, $54, $0f, $15, $01, $04, $0f, $1b, $01, $08, $06, $01, $18
    db $1f, $0f, $01, $4d, $1f, $07

; LZSS-compressed: 70 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y10X10::
    INCBIN "maps/map70/attrs0_y10_x10.lz"

; LZSS-compressed: 69 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y10X11::
    INCBIN "maps/map70/attrs0_y10_x11.lz"

; LZSS-compressed: 50 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y11X0::
    db $68, $01, $01, $01, $ff, $f6, $02, $01, $0a, $05, $01, $00, $0f, $09, $01, $0a
    db $06, $01, $26, $0f, $33, $01, $08, $0f, $15, $01, $06, $08, $01, $a0, $0f, $0d
    db $01, $08, $04, $01, $c8, $0f, $0f, $01, $08, $00, $01, $f8, $ff, $01, $01, $a0
    db $ff, $3f

; LZSS-compressed: 67 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y11X1::
    INCBIN "maps/map70/attrs0_y11_x1.lz"

; LZSS-compressed: 73 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y11X2::
    INCBIN "maps/map70/attrs0_y11_x2.lz"

; LZSS-compressed: 53 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y11X3::
    db $68, $01, $01, $01, $ff, $ff, $1f, $02, $02, $01, $20, $0f, $0d, $02, $01, $54
    db $05, $01, $4a, $0f, $07, $01, $54, $06, $01, $32, $06, $01, $78, $0f, $0b, $01
    db $4a, $0f, $11, $01, $24, $0c, $01, $ca, $0f, $03, $01, $22, $0e, $01, $32, $0f
    db $01, $01, $19, $1f, $3b

Map70Attrs0_Y11X4::
    INCBIN "maps/map70/attrs0_y11_x4.lz"

; LZSS-compressed: 49 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y11X5::
    db $68, $01, $03, $02, $03, $00, $0f, $4d, $03, $40, $0f, $2c, $03, $fe, $f4, $01
    db $01, $03, $98, $06, $03, $a0, $0f, $03, $03, $fe, $fa, $03, $f8, $ff, $01, $03
    db $f6, $fe, $03, $f4, $ff, $01, $03, $f2, $fe, $03, $f0, $ff, $01, $03, $a0, $ff
    db $1d

; LZSS-compressed: 44 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y11X6::
    db $68, $01, $01, $02, $01, $00, $0b, $01, $fc, $ff, $3b, $01, $fa, $ff, $01, $01
    db $fa, $fe, $01, $f8, $ff, $01, $01, $f6, $fe, $01, $f4, $ff, $01, $01, $f2, $fe
    db $01, $f0, $ff, $01, $01, $a0, $ff, $4d, $01, $43, $1f, $11

; LZSS-compressed: 65 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y11X10::
    INCBIN "maps/map70/attrs0_y11_x10.lz"

; LZSS-compressed: 68 bytes that expand to 360 (E-0016, E-0017)
Map70Attrs0_Y11X11::
    INCBIN "maps/map70/attrs0_y11_x11.lz"

; compressed tileset of map $71 (the first map record using it)
; LZSS-compressed: 1006 bytes that expand to 1136 (E-0016, E-0017)
Map71Tileset::
    INCBIN "maps/map71/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map71Palettes::
    dw $7da0, $7fff, $7fe0, $0000 ; entry 0
    dw $00ed, $7fff, $11d4, $0000 ; entry 1
    dw $00ed, $22ba, $11d4, $0000 ; entry 2
    dw $01c4, $3f7f, $0348, $0000 ; entry 3
    dw $48ec, $3f7f, $01da, $0000 ; entry 4
    dw $48ec, $6bff, $0348, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 3 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map71Screens0::
    dfar Map71Screens0_Y0X0 ; entry 0
    dfar Map71Screens0_Y0X1 ; entry 1
    dfar Map71Screens0_Y0X2 ; entry 2

Map71Attrs0::
    dfar Map71Attrs0_Y0X0 ; entry 0
    dfar Map71Attrs0_Y0X1 ; entry 1
    dfar Map71Attrs0_Y0X2 ; entry 2

; LZSS-compressed: 235 bytes that expand to 360 (E-0016, E-0017)
Map71Screens0_Y0X0::
    INCBIN "maps/map71/screens0_y0_x0.lz"

; LZSS-compressed: 212 bytes that expand to 360 (E-0016, E-0017)
Map71Screens0_Y0X1::
    INCBIN "maps/map71/screens0_y0_x1.lz"

; LZSS-compressed: 291 bytes that expand to 360 (E-0016, E-0017)
Map71Screens0_Y0X2::
    INCBIN "maps/map71/screens0_y0_x2.lz"

; LZSS-compressed: 58 bytes that expand to 360 (E-0016, E-0017)
Map71Attrs0_Y0X0::
    db $68, $01, $01, $03, $01, $00, $0f, $1e, $02, $01, $32, $05, $01, $28, $0f, $03
    db $04, $01, $52, $01, $01, $30, $00, $01, $fa, $f2, $01, $4e, $0f, $35, $01, $52
    db $02, $01, $a4, $08, $01, $a8, $0f, $03, $01, $a8, $06, $01, $c8, $0f, $0d, $01
    db $00, $06, $01, $f2, $0f, $29, $01, $00, $0f, $13

; LZSS-compressed: 64 bytes that expand to 360 (E-0016, E-0017)
Map71Attrs0_Y0X1::
    db $68, $01, $00, $03, $00, $00, $03, $04, $04, $04, $04, $00, $00, $04, $00, $00
    db $0f, $0d, $02, $00, $34, $03, $00, $28, $0f, $2f, $00, $08, $00, $00, $6e, $0f
    db $0b, $00, $7e, $02, $00, $a0, $0f, $37, $00, $7a, $06, $00, $ea, $06, $00, $f0
    db $0f, $05, $00, $f2, $06, $00, $10, $0c, $00, $08, $0f, $01, $00, $3a, $1f, $0b

; LZSS-compressed: 133 bytes that expand to 360 (E-0016, E-0017)
Map71Attrs0_Y0X2::
    INCBIN "maps/map71/attrs0_y0_x2.lz"

; compressed tileset of map $72 (the first map record using it)
; LZSS-compressed: 564 bytes that expand to 608 (E-0016, E-0017)
Map72Tileset::
    INCBIN "maps/map72/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map72Palettes::
    dw $7da0, $7fff, $7fe0, $0000 ; entry 0
    dw $00ed, $7fff, $11d4, $0000 ; entry 1
    dw $00ed, $22ba, $11d4, $0000 ; entry 2
    dw $01c4, $3f7f, $0348, $0000 ; entry 3
    dw $00ed, $3f7f, $01da, $0000 ; entry 4
    dw $48ec, $6bff, $0348, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map72Screens0::
    dfar Map72Screens0_Y0X0 ; entry 0

Map72Attrs0::
    dfar Map72Attrs0_Y0X0 ; entry 0

; LZSS-compressed: 197 bytes that expand to 360 (E-0016, E-0017)
Map72Screens0_Y0X0::
    INCBIN "maps/map72/screens0_y0_x0.lz"

; LZSS-compressed: 42 bytes that expand to 360 (E-0016, E-0017)
Map72Attrs0_Y0X0::
    db $68, $01, $00, $02, $00, $00, $0f, $18, $04, $00, $2c, $03, $00, $20, $0f, $35
    db $00, $00, $0e, $01, $01, $00, $8a, $04, $00, $8e, $02, $00, $9d, $0f, $4d, $00
    db $86, $0f, $35, $00, $6e, $0f, $01, $00, $32, $0a

Map8FScreens0::
    dfar Map8FScreens0_Y0X0 ; entry 0

Map8FAttrs0::
    dfar Map8FAttrs0_Y0X0 ; entry 0

Map8FScreens2::
    dfar Map8FScreens2_Y0X0 ; entry 0

Map8FAttrs2::
    dfar Map8FAttrs2_Y0X0 ; entry 0

; LZSS-compressed: 297 bytes that expand to 360 (E-0016, E-0017)
Map8FScreens0_Y0X0::
    INCBIN "maps/map8_f/screens0_y0_x0.lz"

Map8FScreens2_Y0X0::
    INCBIN "maps/map8_f/screens2_y0_x0.lz"

; LZSS-compressed: 120 bytes that expand to 360 (E-0016, E-0017)
Map8FAttrs0_Y0X0::
    INCBIN "maps/map8_f/attrs0_y0_x0.lz"

Map8FAttrs2_Y0X0::
    INCBIN "maps/map8_f/attrs2_y0_x0.lz"

; compressed tileset of map $93 (the first map record using it)
; LZSS-compressed: 789 bytes that expand to 880 (E-0016, E-0017)
Map93Tileset::
    INCBIN "maps/map93/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map93Palettes::
    dw $3cc5, $7fff, $1415, $0000 ; entry 0
    dw $0142, $6ad8, $0348, $0084 ; entry 1
    dw $00ef, $6ad8, $2a13, $0000 ; entry 2
    dw $0142, $3f7f, $0348, $0084 ; entry 3
    dw $3cc5, $6ad8, $5d12, $0000 ; entry 4
    dw $218c, $4f18, $3a52, $0000 ; entry 5
    dw $218c, $4f18, $3a52, $0000 ; entry 6
    dw $218c, $4f18, $3a52, $0000 ; entry 7

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map93Screens0::
    dfar Map93Screens0_Y0X0 ; entry 0

Map93Attrs0::
    dfar Map93Attrs0_Y0X0 ; entry 0

; LZSS-compressed: 246 bytes that expand to 360 (E-0016, E-0017)
Map93Screens0_Y0X0::
    INCBIN "maps/map93/screens0_y0_x0.lz"

; LZSS-compressed: 86 bytes that expand to 360 (E-0016, E-0017)
Map93Attrs0_Y0X0::
    INCBIN "maps/map93/attrs0_y0_x0.lz"
    ds $19, $00
