; ROM bank $4C: map screens, attributes and tilesets
; The annotated listing of this bank is build/listing/bank4c.asm.

SECTION "Bank 4C", ROMX[$4000], BANK[$4C]
    db $4c

; compressed tileset of map $48 (the first map record using it)
; LZSS-compressed: 1404 bytes that expand to 2048 (E-0016, E-0017)
Map48Tileset::
    INCBIN "maps/map48/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map48Palettes::
    dw $7c01, $7fff, $7fe1, $0000 ; entry 0
    dw $01b5, $7fff, $5652, $0006 ; entry 1
    dw $0090, $7fff, $199f, $0000 ; entry 2
    dw $01c4, $7fff, $5652, $0084 ; entry 3
    dw $1415, $7fff, $5652, $0000 ; entry 4
    dw $014e, $131c, $0216, $0000 ; entry 5
    dw $001f, $7fff, $0348, $0000 ; entry 6
    dw $014e, $4f18, $3a52, $0000 ; entry 7

; 144 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map48Screens0::
    dfar Map48Screens0_Y0X0 ; entry 0
    dfar Map48Screens0_Y0X1 ; entry 1
    dfar Map48Screens0_Y0X2 ; entry 2
    dfar Map48Screens0_Y0X3 ; entry 3
    dfar Map48Screens0_Y0X4 ; entry 4
    dfar Map48Screens0_Y0X5 ; entry 5
    dfar Map48Screens0_Y0X6 ; entry 6
    dfar Map48Screens0_Y0X7 ; entry 7
    dfar Map48Screens0_Y0X8 ; entry 8
    dfar Map48Screens0_Y0X9 ; entry 9
    dfar Map48Screens0_Y0X10 ; entry 10
    dfar Map48Screens0_Y0X11 ; entry 11
    dfar Map48Screens0_Y1X0 ; entry 12
    dfar Map48Screens0_Y1X1 ; entry 13
    dfar Map48Screens0_Y1X2 ; entry 14
    dfar Map48Screens0_Y1X3 ; entry 15
    dfar Map48Screens0_Y1X4 ; entry 16
    dfar Map48Screens0_Y1X5 ; entry 17
    dfar Map48Screens0_Y1X6 ; entry 18
    dfar Map48Screens0_Y1X7 ; entry 19
    dfar Map48Screens0_Y1X8 ; entry 20
    dfar Map48Screens0_Y1X9 ; entry 21
    dfar Map48Screens0_Y1X10 ; entry 22
    dfar Map48Screens0_Y1X11 ; entry 23
    dfar Map48Screens0_Y2X0 ; entry 24
    dfar Map48Screens0_Y2X1 ; entry 25
    dfar Map48Screens0_Y2X2 ; entry 26
    dfar Map48Screens0_Y2X3 ; entry 27
    dfar Map48Screens0_Y2X4 ; entry 28
    dfar Map48Screens0_Y2X5 ; entry 29
    dfar Map48Screens0_Y2X6 ; entry 30
    dfar Map48Screens0_Y2X7 ; entry 31
    dfar Map48Screens0_Y2X8 ; entry 32
    dfar Map48Screens0_Y2X9 ; entry 33
    dfar Map48Screens0_Y2X10 ; entry 34
    dfar Map48Screens0_Y2X11 ; entry 35
    dfar Map48Screens0_Y3X0 ; entry 36
    dfar Map48Screens0_Y3X1 ; entry 37
    dfar Map48Screens0_Y3X2 ; entry 38
    dfar Map48Screens0_Y3X3 ; entry 39
    dfar Map48Screens0_Y3X4 ; entry 40
    dfar Map48Screens0_Y3X5 ; entry 41
    dfar Map48Screens0_Y3X6 ; entry 42
    dfar Map48Screens0_Y3X7 ; entry 43
    dfar Map48Screens0_Y3X8 ; entry 44
    dfar Map48Screens0_Y3X9 ; entry 45
    dfar Map48Screens0_Y3X10 ; entry 46
    dfar Map48Screens0_Y3X11 ; entry 47
    dfar Map48Screens0_Y4X0 ; entry 48
    dfar Map48Screens0_Y4X1 ; entry 49
    dfar Map48Screens0_Y4X2 ; entry 50
    dfar Map48Screens0_Y4X3 ; entry 51
    dfar Map48Screens0_Y4X4 ; entry 52
    dfar Map48Screens0_Y4X5 ; entry 53
    dfar Map48Screens0_Y4X6 ; entry 54
    dfar Map48Screens0_Y4X7 ; entry 55
    dfar Map48Screens0_Y4X8 ; entry 56
    dfar Map48Screens0_Y4X9 ; entry 57
    dfar Map48Screens0_Y4X10 ; entry 58
    dfar Map48Screens0_Y4X11 ; entry 59
    dfar Map48Screens0_Y5X0 ; entry 60
    dfar Map48Screens0_Y5X1 ; entry 61
    dfar Map48Screens0_Y5X2 ; entry 62
    dfar Map48Screens0_Y5X3 ; entry 63
    dfar Map48Screens0_Y5X4 ; entry 64
    dfar Map48Screens0_Y5X5 ; entry 65
    dfar Map48Screens0_Y5X6 ; entry 66
    dfar Map48Screens0_Y5X7 ; entry 67
    dfar Map48Screens0_Y5X8 ; entry 68
    dfar Map48Screens0_Y5X9 ; entry 69
    dfar Map48Screens0_Y5X10 ; entry 70
    dfar Map48Screens0_Y5X11 ; entry 71
    dfar Map48Screens0_Y6X0 ; entry 72
    dfar Map48Screens0_Y6X1 ; entry 73
    dfar Map48Screens0_Y6X2 ; entry 74
    dfar Map48Screens0_Y6X3 ; entry 75
    dfar Map48Screens0_Y6X4 ; entry 76
    dfar Map48Screens0_Y6X5 ; entry 77
    dfar Map48Screens0_Y6X6 ; entry 78
    dfar Map48Screens0_Y6X7 ; entry 79
    dfar Map48Screens0_Y6X8 ; entry 80
    dfar Map48Screens0_Y6X9 ; entry 81
    dfar Map48Screens0_Y6X10 ; entry 82
    dfar Map48Screens0_Y6X11 ; entry 83
    dfar Map48Screens0_Y7X0 ; entry 84
    dfar Map48Screens0_Y7X1 ; entry 85
    dfar Map48Screens0_Y7X2 ; entry 86
    dfar Map48Screens0_Y7X3 ; entry 87
    dfar Map48Screens0_Y7X4 ; entry 88
    dfar Map48Screens0_Y7X5 ; entry 89
    dfar Map48Screens0_Y7X6 ; entry 90
    dfar Map48Screens0_Y7X7 ; entry 91
    dfar Map48Screens0_Y7X8 ; entry 92
    dfar Map48Screens0_Y7X9 ; entry 93
    dfar Map48Screens0_Y7X10 ; entry 94
    dfar Map48Screens0_Y7X11 ; entry 95
    dfar Map48Screens0_Y8X0 ; entry 96
    dfar Map48Screens0_Y8X1 ; entry 97
    dfar Map48Screens0_Y8X2 ; entry 98
    dfar Map48Screens0_Y8X3 ; entry 99
    dfar Map48Screens0_Y8X4 ; entry 100
    dfar Map48Screens0_Y8X5 ; entry 101
    dfar Map48Screens0_Y8X6 ; entry 102
    dfar Map48Screens0_Y8X7 ; entry 103
    dfar Map48Screens0_Y8X8 ; entry 104
    dfar Map48Screens0_Y8X9 ; entry 105
    dfar Map48Screens0_Y8X10 ; entry 106
    dfar Map48Screens0_Y8X11 ; entry 107
    dfar Map48Screens0_Y9X0 ; entry 108
    dfar Map48Screens0_Y9X1 ; entry 109
    dfar Map48Screens0_Y9X2 ; entry 110
    dfar Map48Screens0_Y9X3 ; entry 111
    dfar Map48Screens0_Y9X4 ; entry 112
    dfar Map48Screens0_Y9X5 ; entry 113
    dfar Map48Screens0_Y9X6 ; entry 114
    dfar Map48Screens0_Y9X7 ; entry 115
    dfar Map48Screens0_Y9X8 ; entry 116
    dfar Map48Screens0_Y9X9 ; entry 117
    dfar Map48Screens0_Y9X10 ; entry 118
    dfar Map48Screens0_Y9X11 ; entry 119
    dfar Map48Screens0_Y10X0 ; entry 120
    dfar Map48Screens0_Y10X1 ; entry 121
    dfar Map48Screens0_Y10X2 ; entry 122
    dfar Map48Screens0_Y10X3 ; entry 123
    dfar Map48Screens0_Y10X4 ; entry 124
    dfar Map48Screens0_Y10X5 ; entry 125
    dfar Map48Screens0_Y10X6 ; entry 126
    dfar Map48Screens0_Y10X7 ; entry 127
    dfar Map48Screens0_Y10X8 ; entry 128
    dfar Map48Screens0_Y10X9 ; entry 129
    dfar Map48Screens0_Y10X10 ; entry 130
    dfar Map48Screens0_Y10X11 ; entry 131
    dfar Map48Screens0_Y11X0 ; entry 132
    dfar Map48Screens0_Y11X1 ; entry 133
    dfar Map48Screens0_Y11X2 ; entry 134
    dfar Map48Screens0_Y11X3 ; entry 135
    dfar Map48Screens0_Y11X4 ; entry 136
    dfar Map48Screens0_Y11X5 ; entry 137
    dfar Map48Screens0_Y11X6 ; entry 138
    dfar Map48Screens0_Y11X7 ; entry 139
    dfar Map48Screens0_Y11X8 ; entry 140
    dfar Map48Screens0_Y11X9 ; entry 141
    dfar Map48Screens0_Y11X10 ; entry 142
    dfar Map48Screens0_Y11X11 ; entry 143

Map48Screens2::
    dfar Map48Screens0_Y0X0 ; entry 0
    dfar Map48Screens0_Y0X1 ; entry 1
    dfar Map48Screens0_Y0X2 ; entry 2
    dfar Map48Screens0_Y0X3 ; entry 3
    dfar Map48Screens0_Y0X4 ; entry 4
    dfar Map48Screens0_Y0X5 ; entry 5
    dfar Map48Screens0_Y0X6 ; entry 6
    dfar Map48Screens0_Y0X7 ; entry 7
    dfar Map48Screens0_Y0X8 ; entry 8
    dfar Map48Screens0_Y0X9 ; entry 9
    dfar Map48Screens0_Y0X10 ; entry 10
    dfar Map48Screens0_Y0X11 ; entry 11
    dfar Map48Screens0_Y1X0 ; entry 12
    dfar Map48Screens0_Y1X1 ; entry 13
    dfar Map48Screens0_Y1X2 ; entry 14
    dfar Map48Screens0_Y1X3 ; entry 15
    dfar Map48Screens0_Y1X4 ; entry 16
    dfar Map48Screens0_Y1X5 ; entry 17
    dfar Map48Screens0_Y1X6 ; entry 18
    dfar Map48Screens0_Y1X7 ; entry 19
    dfar Map48Screens0_Y1X8 ; entry 20
    dfar Map48Screens0_Y1X9 ; entry 21
    dfar Map48Screens0_Y1X10 ; entry 22
    dfar Map48Screens0_Y1X11 ; entry 23
    dfar Map48Screens0_Y2X0 ; entry 24
    dfar Map48Screens0_Y2X1 ; entry 25
    dfar Map48Screens0_Y2X2 ; entry 26
    dfar Map48Screens0_Y2X3 ; entry 27
    dfar Map48Screens0_Y2X4 ; entry 28
    dfar Map48Screens0_Y2X5 ; entry 29
    dfar Map48Screens0_Y2X6 ; entry 30
    dfar Map48Screens0_Y2X7 ; entry 31
    dfar Map48Screens0_Y2X8 ; entry 32
    dfar Map48Screens0_Y2X9 ; entry 33
    dfar Map48Screens0_Y2X10 ; entry 34
    dfar Map48Screens0_Y2X11 ; entry 35
    dfar Map48Screens0_Y3X0 ; entry 36
    dfar Map48Screens0_Y3X1 ; entry 37
    dfar Map48Screens0_Y3X2 ; entry 38
    dfar Map48Screens0_Y3X3 ; entry 39
    dfar Map48Screens0_Y3X4 ; entry 40
    dfar Map48Screens0_Y3X5 ; entry 41
    dfar Map48Screens0_Y3X6 ; entry 42
    dfar Map48Screens0_Y3X7 ; entry 43
    dfar Map48Screens0_Y3X8 ; entry 44
    dfar Map48Screens0_Y3X9 ; entry 45
    dfar Map48Screens0_Y3X10 ; entry 46
    dfar Map48Screens0_Y3X11 ; entry 47
    dfar Map48Screens0_Y4X0 ; entry 48
    dfar Map48Screens0_Y4X1 ; entry 49
    dfar Map48Screens0_Y4X2 ; entry 50
    dfar Map48Screens0_Y4X3 ; entry 51
    dfar Map48Screens0_Y4X4 ; entry 52
    dfar Map48Screens0_Y4X5 ; entry 53
    dfar Map48Screens0_Y4X6 ; entry 54
    dfar Map48Screens0_Y4X7 ; entry 55
    dfar Map48Screens0_Y4X8 ; entry 56
    dfar Map48Screens2_Y4X9 ; entry 57
    dfar Map48Screens2_Y4X10 ; entry 58
    dfar Map48Screens0_Y4X11 ; entry 59
    dfar Map48Screens0_Y5X0 ; entry 60
    dfar Map48Screens0_Y5X1 ; entry 61
    dfar Map48Screens0_Y5X2 ; entry 62
    dfar Map48Screens0_Y5X3 ; entry 63
    dfar Map48Screens0_Y5X4 ; entry 64
    dfar Map48Screens0_Y5X5 ; entry 65
    dfar Map48Screens2_Y5X6 ; entry 66
    dfar Map48Screens2_Y5X7 ; entry 67
    dfar Map48Screens2_Y5X8 ; entry 68
    dfar Map48Screens2_Y5X9 ; entry 69
    dfar Map48Screens0_Y5X10 ; entry 70
    dfar Map48Screens0_Y5X11 ; entry 71
    dfar Map48Screens0_Y6X0 ; entry 72
    dfar Map48Screens0_Y6X1 ; entry 73
    dfar Map48Screens0_Y6X2 ; entry 74
    dfar Map48Screens0_Y6X3 ; entry 75
    dfar Map48Screens0_Y6X4 ; entry 76
    dfar Map48Screens0_Y6X5 ; entry 77
    dfar Map48Screens0_Y6X6 ; entry 78
    dfar Map48Screens2_Y6X7 ; entry 79
    dfar Map48Screens2_Y6X8 ; entry 80
    dfar Map48Screens2_Y6X9 ; entry 81
    dfar Map48Screens0_Y6X10 ; entry 82
    dfar Map48Screens0_Y6X11 ; entry 83
    dfar Map48Screens0_Y7X0 ; entry 84
    dfar Map48Screens0_Y7X1 ; entry 85
    dfar Map48Screens0_Y7X2 ; entry 86
    dfar Map48Screens0_Y7X3 ; entry 87
    dfar Map48Screens0_Y7X4 ; entry 88
    dfar Map48Screens0_Y7X5 ; entry 89
    dfar Map48Screens0_Y7X6 ; entry 90
    dfar Map48Screens2_Y7X7 ; entry 91
    dfar Map48Screens2_Y7X8 ; entry 92
    dfar Map48Screens2_Y7X9 ; entry 93
    dfar Map48Screens0_Y7X10 ; entry 94
    dfar Map48Screens0_Y7X11 ; entry 95
    dfar Map48Screens0_Y8X0 ; entry 96
    dfar Map48Screens0_Y8X1 ; entry 97
    dfar Map48Screens0_Y8X2 ; entry 98
    dfar Map48Screens0_Y8X3 ; entry 99
    dfar Map48Screens0_Y8X4 ; entry 100
    dfar Map48Screens2_Y8X5 ; entry 101
    dfar Map48Screens2_Y8X6 ; entry 102
    dfar Map48Screens2_Y8X7 ; entry 103
    dfar Map48Screens2_Y8X8 ; entry 104
    dfar Map48Screens0_Y8X9 ; entry 105
    dfar Map48Screens0_Y8X10 ; entry 106
    dfar Map48Screens0_Y8X11 ; entry 107
    dfar Map48Screens0_Y9X0 ; entry 108
    dfar Map48Screens0_Y9X1 ; entry 109
    dfar Map48Screens0_Y9X2 ; entry 110
    dfar Map48Screens0_Y9X3 ; entry 111
    dfar Map48Screens0_Y9X4 ; entry 112
    dfar Map48Screens0_Y9X5 ; entry 113
    dfar Map48Screens0_Y9X6 ; entry 114
    dfar Map48Screens0_Y9X7 ; entry 115
    dfar Map48Screens0_Y9X8 ; entry 116
    dfar Map48Screens0_Y9X9 ; entry 117
    dfar Map48Screens0_Y9X10 ; entry 118
    dfar Map48Screens0_Y9X11 ; entry 119
    dfar Map48Screens0_Y10X0 ; entry 120
    dfar Map48Screens0_Y10X1 ; entry 121
    dfar Map48Screens0_Y10X2 ; entry 122
    dfar Map48Screens0_Y10X3 ; entry 123
    dfar Map48Screens0_Y10X4 ; entry 124
    dfar Map48Screens0_Y10X5 ; entry 125
    dfar Map48Screens0_Y10X6 ; entry 126
    dfar Map48Screens0_Y10X7 ; entry 127
    dfar Map48Screens0_Y10X8 ; entry 128
    dfar Map48Screens0_Y10X9 ; entry 129
    dfar Map48Screens0_Y10X10 ; entry 130
    dfar Map48Screens0_Y10X11 ; entry 131
    dfar Map48Screens0_Y11X0 ; entry 132
    dfar Map48Screens0_Y11X1 ; entry 133
    dfar Map48Screens0_Y11X2 ; entry 134
    dfar Map48Screens0_Y11X3 ; entry 135
    dfar Map48Screens0_Y11X4 ; entry 136
    dfar Map48Screens0_Y11X5 ; entry 137
    dfar Map48Screens0_Y11X6 ; entry 138
    dfar Map48Screens0_Y11X7 ; entry 139
    dfar Map48Screens0_Y11X8 ; entry 140
    dfar Map48Screens0_Y11X9 ; entry 141
    dfar Map48Screens0_Y11X10 ; entry 142
    dfar Map48Screens0_Y11X11 ; entry 143

; LZSS-compressed: 29 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y0X0::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

Map48Screens0_Y0X1::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

Map48Screens0_Y0X2::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

Map48Screens0_Y0X3::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

; LZSS-compressed: 62 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y0X4::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $3d, $44, $45, $44, $45, $00, $64, $0c, $54, $55, $54, $55
    db $00, $ca, $0e, $00, $da, $0c, $00, $ec, $00, $00, $ee, $0a, $00, $d8, $00, $42
    db $43, $42, $43, $00, $e0, $0c, $52, $53, $52, $53, $00, $18, $1f, $15

; LZSS-compressed: 136 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y0X5::
    INCBIN "maps/map48/screens0_y0_x5.lz"

Map48Screens0_Y0X6::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

Map48Screens0_Y0X7::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

Map48Screens0_Y0X8::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

Map48Screens0_Y0X9::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

Map48Screens0_Y0X10::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

Map48Screens0_Y0X11::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

Map48Screens0_Y1X0::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

Map48Screens0_Y1X1::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

Map48Screens0_Y1X2::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

Map48Screens0_Y1X3::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

; LZSS-compressed: 110 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y1X4::
    INCBIN "maps/map48/screens0_y1_x4.lz"

; LZSS-compressed: 139 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y1X5::
    INCBIN "maps/map48/screens0_y1_x5.lz"

; LZSS-compressed: 132 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y1X6::
    INCBIN "maps/map48/screens0_y1_x6.lz"

; LZSS-compressed: 126 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y1X7::
    INCBIN "maps/map48/screens0_y1_x7.lz"

; LZSS-compressed: 29 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y1X8::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

Map48Screens0_Y1X9::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

Map48Screens0_Y1X10::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

Map48Screens0_Y1X11::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

Map48Screens0_Y2X0::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

Map48Screens0_Y2X1::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f

; LZSS-compressed: 63 bytes that expand to 77 (E-0016, E-0017)
Gfx4C_1::
    db $4d, $00, $f8, $0f, $0d

Map48Screens0_Y2X2::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

Map48Screens0_Y2X3::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

; LZSS-compressed: 101 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y2X4::
    INCBIN "maps/map48/screens0_y2_x4.lz"

; LZSS-compressed: 134 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y2X5::
    INCBIN "maps/map48/screens0_y2_x5.lz"

; LZSS-compressed: 145 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y2X6::
    INCBIN "maps/map48/screens0_y2_x6.lz"

; LZSS-compressed: 160 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y2X7::
    INCBIN "maps/map48/screens0_y2_x7.lz"

; LZSS-compressed: 140 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y2X8::
    INCBIN "maps/map48/screens0_y2_x8.lz"

; LZSS-compressed: 152 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y2X9::
    INCBIN "maps/map48/screens0_y2_x9.lz"

; LZSS-compressed: 106 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y2X10::
    INCBIN "maps/map48/screens0_y2_x10.lz"

; LZSS-compressed: 29 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y2X11::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

Map48Screens0_Y3X0::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

Map48Screens0_Y3X1::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

Map48Screens0_Y3X2::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f

; LZSS-compressed: 63 bytes that expand to 77 (E-0016, E-0017)
Gfx4C_2::
    db $4d, $00, $f8, $0f, $0d

Map48Screens0_Y3X3::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

Map48Screens0_Y3X4::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

; LZSS-compressed: 119 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y3X5::
    INCBIN "maps/map48/screens0_y3_x5.lz"

; LZSS-compressed: 160 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y3X6::
    INCBIN "maps/map48/screens0_y3_x6.lz"

; LZSS-compressed: 157 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y3X7::
    INCBIN "maps/map48/screens0_y3_x7.lz"

; LZSS-compressed: 138 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y3X8::
    INCBIN "maps/map48/screens0_y3_x8.lz"

; LZSS-compressed: 122 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y3X9::
    INCBIN "maps/map48/screens0_y3_x9.lz"

; LZSS-compressed: 115 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y3X10::
    INCBIN "maps/map48/screens0_y3_x10.lz"

; LZSS-compressed: 88 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y3X11::
    INCBIN "maps/map48/screens0_y3_x11.lz"

; LZSS-compressed: 29 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y4X0::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

Map48Screens0_Y4X1::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

Map48Screens0_Y4X2::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f

; LZSS-compressed: 63 bytes that expand to 77 (E-0016, E-0017)
Gfx4C_3::
    db $4d, $00, $f8, $0f, $0d

Map48Screens0_Y4X3::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

Map48Screens0_Y4X4::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

; LZSS-compressed: 107 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y4X5::
    INCBIN "maps/map48/screens0_y4_x5.lz"

; LZSS-compressed: 126 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y4X6::
    INCBIN "maps/map48/screens0_y4_x6.lz"

; LZSS-compressed: 108 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y4X7::
    INCBIN "maps/map48/screens0_y4_x7.lz"

; LZSS-compressed: 150 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y4X8::
    INCBIN "maps/map48/screens0_y4_x8.lz"

; LZSS-compressed: 149 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y4X9::
    INCBIN "maps/map48/screens0_y4_x9.lz"

; LZSS-compressed: 140 bytes that expand to 360 (E-0016, E-0017)
Map48Screens2_Y4X9::
    INCBIN "maps/map48/screens2_y4_x9.lz"

; LZSS-compressed: 177 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y4X10::
    INCBIN "maps/map48/screens0_y4_x10.lz"

; LZSS-compressed: 175 bytes that expand to 360 (E-0016, E-0017)
Map48Screens2_Y4X10::
    INCBIN "maps/map48/screens2_y4_x10.lz"

; LZSS-compressed: 151 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y4X11::
    INCBIN "maps/map48/screens0_y4_x11.lz"

; LZSS-compressed: 29 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y5X0::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

Map48Screens0_Y5X1::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f

; LZSS-compressed: 63 bytes that expand to 77 (E-0016, E-0017)
Gfx4C_4::
    db $4d, $00, $f8, $0f, $0d

Map48Screens0_Y5X2::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

Map48Screens0_Y5X3::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

; LZSS-compressed: 123 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y5X4::
    INCBIN "maps/map48/screens0_y5_x4.lz"

; LZSS-compressed: 138 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y5X5::
    INCBIN "maps/map48/screens0_y5_x5.lz"

; LZSS-compressed: 172 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y5X6::
    INCBIN "maps/map48/screens0_y5_x6.lz"

; LZSS-compressed: 170 bytes that expand to 360 (E-0016, E-0017)
Map48Screens2_Y5X6::
    INCBIN "maps/map48/screens2_y5_x6.lz"

; LZSS-compressed: 175 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y5X7::
    INCBIN "maps/map48/screens0_y5_x7.lz"

; LZSS-compressed: 152 bytes that expand to 360 (E-0016, E-0017)
Map48Screens2_Y5X7::
    INCBIN "maps/map48/screens2_y5_x7.lz"

; LZSS-compressed: 148 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y5X8::
    INCBIN "maps/map48/screens0_y5_x8.lz"

; LZSS-compressed: 149 bytes that expand to 360 (E-0016, E-0017)
Map48Screens2_Y5X8::
    INCBIN "maps/map48/screens2_y5_x8.lz"

; LZSS-compressed: 133 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y5X9::
    INCBIN "maps/map48/screens0_y5_x9.lz"

; LZSS-compressed: 139 bytes that expand to 360 (E-0016, E-0017)
Map48Screens2_Y5X9::
    INCBIN "maps/map48/screens2_y5_x9.lz"

; LZSS-compressed: 189 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y5X10::
    INCBIN "maps/map48/screens0_y5_x10.lz"

; LZSS-compressed: 102 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y5X11::
    INCBIN "maps/map48/screens0_y5_x11.lz"

; LZSS-compressed: 29 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y6X0::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

; LZSS-compressed: 90 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y6X1::
    INCBIN "maps/map48/screens0_y6_x1.lz"

; LZSS-compressed: 136 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y6X2::
    INCBIN "maps/map48/screens0_y6_x2.lz"

; LZSS-compressed: 124 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y6X3::
    INCBIN "maps/map48/screens0_y6_x3.lz"

; LZSS-compressed: 149 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y6X4::
    INCBIN "maps/map48/screens0_y6_x4.lz"

; LZSS-compressed: 133 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y6X5::
    INCBIN "maps/map48/screens0_y6_x5.lz"

; LZSS-compressed: 116 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y6X6::
    INCBIN "maps/map48/screens0_y6_x6.lz"

; LZSS-compressed: 86 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y6X7::
    INCBIN "maps/map48/screens0_y6_x7.lz"

; LZSS-compressed: 28 bytes that expand to 360 (E-0016, E-0017)
Map48Screens2_Y6X7::
    db $68, $01, $02, $00, $01, $02, $00, $0e, $02, $01, $0f, $00, $02, $ff, $ff, $4d
    db $02, $5f, $0f, $4d, $02, $bf, $0f, $4d, $02, $f7, $0f, $0e

; LZSS-compressed: 68 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y6X8::
    INCBIN "maps/map48/screens0_y6_x8.lz"

Map48Screens2_Y6X8::
    db $68, $01, $02, $00, $01, $02, $00, $0e, $02, $01, $0f, $00, $02, $ff, $ff, $4d
    db $02, $5f, $0f, $4d, $02, $bf, $0f, $4d, $02, $f7, $0f, $0e

; LZSS-compressed: 155 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y6X9::
    INCBIN "maps/map48/screens0_y6_x9.lz"

; LZSS-compressed: 135 bytes that expand to 360 (E-0016, E-0017)
Map48Screens2_Y6X9::
    INCBIN "maps/map48/screens2_y6_x9.lz"

; LZSS-compressed: 148 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y6X10::
    INCBIN "maps/map48/screens0_y6_x10.lz"

; LZSS-compressed: 83 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y6X11::
    INCBIN "maps/map48/screens0_y6_x11.lz"

; LZSS-compressed: 29 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y7X0::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

; LZSS-compressed: 114 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y7X1::
    INCBIN "maps/map48/screens0_y7_x1.lz"

; LZSS-compressed: 149 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y7X2::
    INCBIN "maps/map48/screens0_y7_x2.lz"

; LZSS-compressed: 144 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y7X3::
    INCBIN "maps/map48/screens0_y7_x3.lz"

; LZSS-compressed: 158 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y7X4::
    INCBIN "maps/map48/screens0_y7_x4.lz"

; LZSS-compressed: 148 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y7X5::
    INCBIN "maps/map48/screens0_y7_x5.lz"

; LZSS-compressed: 164 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y7X6::
    INCBIN "maps/map48/screens0_y7_x6.lz"

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y7X7::
    INCBIN "maps/map48/screens0_y7_x7.lz"

; LZSS-compressed: 28 bytes that expand to 360 (E-0016, E-0017)
Map48Screens2_Y7X7::
    db $68, $01, $02, $00, $01, $02, $00, $0e, $02, $01, $0f, $00, $02, $ff, $ff, $4d
    db $02, $5f, $0f, $4d, $02, $bf, $0f, $4d, $02, $f7, $0f, $0e

; LZSS-compressed: 126 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y7X8::
    INCBIN "maps/map48/screens0_y7_x8.lz"

; LZSS-compressed: 138 bytes that expand to 360 (E-0016, E-0017)
Map48Screens2_Y7X8::
    INCBIN "maps/map48/screens2_y7_x8.lz"

; LZSS-compressed: 194 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y7X9::
    INCBIN "maps/map48/screens0_y7_x9.lz"

; LZSS-compressed: 173 bytes that expand to 360 (E-0016, E-0017)
Map48Screens2_Y7X9::
    INCBIN "maps/map48/screens2_y7_x9.lz"

; LZSS-compressed: 131 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y7X10::
    INCBIN "maps/map48/screens0_y7_x10.lz"

; LZSS-compressed: 29 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y7X11::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

Map48Screens0_Y8X0::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

Map48Screens0_Y8X1::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

; LZSS-compressed: 110 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y8X2::
    INCBIN "maps/map48/screens0_y8_x2.lz"

; LZSS-compressed: 149 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y8X3::
    INCBIN "maps/map48/screens0_y8_x3.lz"

; LZSS-compressed: 135 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y8X4::
    INCBIN "maps/map48/screens0_y8_x4.lz"

; LZSS-compressed: 77 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y8X5::
    INCBIN "maps/map48/screens0_y8_x5.lz"

; LZSS-compressed: 28 bytes that expand to 360 (E-0016, E-0017)
Map48Screens2_Y8X5::
    db $68, $01, $02, $00, $01, $02, $00, $0e, $02, $01, $0f, $00, $02, $ff, $ff, $4d
    db $02, $5f, $0f, $4d, $02, $bf, $0f, $4d, $02, $f7, $0f, $0e

; LZSS-compressed: 86 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y8X6::
    db $68, $01, $02, $00, $01, $02, $00, $0e

; Not an asset. The bytes at $725A lie 8 bytes inside the stream Map48Screens0_Y8X6 (bank $4C,
; $7252-$72A8, 86 bytes that expand to 360), so a decompression from here only reads the middle of
; that screen stream as if it were a header. It yields 258 bytes (not a whole number of tiles) and
; its read runs on to $733B, past the end of that stream into Map48Screens2_Y8X6. Rendered as tiles:
; noise. Map48Screens0_Y8X6 is a normal map screen with a table pointer, so the label Gfx4C_5 is a
; false stream start of the scan. No loader exists to read. (C1, E-0383)
; LZSS-compressed: 225 bytes that expand to 258 (E-0016, E-0017)
Gfx4C_5::
    INCBIN "gfx/misc/gfx4_c_5.lz"

Map48Screens2_Y8X6::
    db $68, $01, $02, $00, $01, $02, $00, $0e, $02, $01, $0f, $00, $02, $ff, $ff, $4d
    db $02, $5f, $0f, $4d, $02, $bf, $0f, $4d, $02, $f7, $0f, $0e

; LZSS-compressed: 119 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y8X7::
    INCBIN "maps/map48/screens0_y8_x7.lz"

; LZSS-compressed: 69 bytes that expand to 360 (E-0016, E-0017)
Map48Screens2_Y8X7::
    INCBIN "maps/map48/screens2_y8_x7.lz"

; LZSS-compressed: 131 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y8X8::
    INCBIN "maps/map48/screens0_y8_x8.lz"

; LZSS-compressed: 78 bytes that expand to 360 (E-0016, E-0017)
Map48Screens2_Y8X8::
    INCBIN "maps/map48/screens2_y8_x8.lz"

; LZSS-compressed: 143 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y8X9::
    INCBIN "maps/map48/screens0_y8_x9.lz"

; LZSS-compressed: 88 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y8X10::
    INCBIN "maps/map48/screens0_y8_x10.lz"

; LZSS-compressed: 29 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y8X11::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

Map48Screens0_Y9X0::
    db $68, $01, $00, $2a, $2b, $00, $00, $0e, $3a, $3b, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

; LZSS-compressed: 76 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y9X1::
    INCBIN "maps/map48/screens0_y9_x1.lz"

; LZSS-compressed: 181 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y9X2::
    INCBIN "maps/map48/screens0_y9_x2.lz"

; LZSS-compressed: 164 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y9X3::
    INCBIN "maps/map48/screens0_y9_x3.lz"

; LZSS-compressed: 221 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y9X4::
    INCBIN "maps/map48/screens0_y9_x4.lz"

; LZSS-compressed: 143 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y9X5::
    INCBIN "maps/map48/screens0_y9_x5.lz"

; LZSS-compressed: 135 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y9X6::
    INCBIN "maps/map48/screens0_y9_x6.lz"

; LZSS-compressed: 192 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y9X7::
    INCBIN "maps/map48/screens0_y9_x7.lz"

; LZSS-compressed: 162 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y9X8::
    INCBIN "maps/map48/screens0_y9_x8.lz"

; LZSS-compressed: 187 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y9X9::
    INCBIN "maps/map48/screens0_y9_x9.lz"

; LZSS-compressed: 148 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y9X10::
    INCBIN "maps/map48/screens0_y9_x10.lz"

; LZSS-compressed: 85 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y9X11::
    INCBIN "maps/map48/screens0_y9_x11.lz"

Map48Screens0_Y10X0::
    INCBIN "maps/map48/screens0_y10_x0.lz"

; LZSS-compressed: 173 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y10X1::
    INCBIN "maps/map48/screens0_y10_x1.lz"

; LZSS-compressed: 184 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y10X2::
    INCBIN "maps/map48/screens0_y10_x2.lz"

; LZSS-compressed: 191 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y10X3::
    INCBIN "maps/map48/screens0_y10_x3.lz"

; LZSS-compressed: 192 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y10X4::
    INCBIN "maps/map48/screens0_y10_x4.lz"

; LZSS-compressed: 119 bytes that expand to 360 (E-0016, E-0017)
Map48Screens0_Y10X5::
    INCBIN "maps/map48/screens0_y10_x5.lz"
    ds $40, $00
