; ROM bank $50: map screens, attributes and tilesets
; The annotated listing of this bank is build/listing/bank50.asm.

SECTION "Bank 50", ROMX[$4000], BANK[$50]
    db $50

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map70Palettes::
    dw $7da0, $7fff, $01d3, $0063 ; entry 0
    dw $01d3, $7fff, $0348, $0006 ; entry 1
    dw $01c4, $03ff, $0348, $0084 ; entry 2
    dw $01c4, $7fff, $0348, $0084 ; entry 3
    dw $001f, $7fff, $0348, $0000 ; entry 4
    dw $00d0, $01d9, $0348, $0084 ; entry 5
    dw $218c, $4f18, $3a52, $0000 ; entry 6
    dw $218c, $4f18, $3a52, $0000 ; entry 7

; 144 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map70Screens0::
    dfar Map70Screens0_Y0X0 ; entry 0
    dfar Map70Screens0_Y0X1 ; entry 1
    dfar Map70Screens0_Y0X2 ; entry 2
    dfar Map70Screens0_Y0X3 ; entry 3
    dfar Map70Screens0_Y0X4 ; entry 4
    dfar Map70Screens0_Y0X5 ; entry 5
    dfar Map70Screens0_Y0X0 ; entry 6
    dfar Map70Screens0_Y0X0 ; entry 7
    dfar Map70Screens0_Y0X0 ; entry 8
    dfar Map70Screens0_Y0X0 ; entry 9
    dfar Map70Screens0_Y0X0 ; entry 10
    dfar Map70Screens0_Y0X0 ; entry 11
    dfar Map70Screens0_Y0X0 ; entry 12
    dfar Map70Screens0_Y1X1 ; entry 13
    dfar Map70Screens0_Y1X2 ; entry 14
    dfar Map70Screens0_Y0X0 ; entry 15
    dfar Map70Screens0_Y1X4 ; entry 16
    dfar Map70Screens0_Y1X5 ; entry 17
    dfar Map70Screens0_Y1X6 ; entry 18
    dfar Map70Screens0_Y0X0 ; entry 19
    dfar Map70Screens0_Y0X0 ; entry 20
    dfar Map70Screens0_Y0X0 ; entry 21
    dfar Map70Screens0_Y1X10 ; entry 22
    dfar Map70Screens0_Y1X11 ; entry 23
    dfar Map70Screens0_Y0X0 ; entry 24
    dfar Map70Screens0_Y2X1 ; entry 25
    dfar Map70Screens0_Y0X0 ; entry 26
    dfar Map70Screens0_Y0X0 ; entry 27
    dfar Map70Screens0_Y2X4 ; entry 28
    dfar Map70Screens0_Y2X5 ; entry 29
    dfar Map70Screens0_Y2X6 ; entry 30
    dfar Map70Screens0_Y2X7 ; entry 31
    dfar Map70Screens0_Y0X0 ; entry 32
    dfar Map70Screens0_Y0X0 ; entry 33
    dfar Map70Screens0_Y2X10 ; entry 34
    dfar Map70Screens0_Y2X11 ; entry 35
    dfar Map70Screens0_Y0X0 ; entry 36
    dfar Map70Screens0_Y0X0 ; entry 37
    dfar Map70Screens0_Y3X2 ; entry 38
    dfar Map70Screens0_Y3X3 ; entry 39
    dfar Map70Screens0_Y0X0 ; entry 40
    dfar Map70Screens0_Y3X5 ; entry 41
    dfar Map70Screens0_Y3X6 ; entry 42
    dfar Map70Screens0_Y3X7 ; entry 43
    dfar Map70Screens0_Y3X8 ; entry 44
    dfar Map70Screens0_Y3X9 ; entry 45
    dfar Map70Screens0_Y3X10 ; entry 46
    dfar Map70Screens0_Y3X11 ; entry 47
    dfar Map70Screens0_Y4X0 ; entry 48
    dfar Map70Screens0_Y4X1 ; entry 49
    dfar Map70Screens0_Y4X2 ; entry 50
    dfar Map70Screens0_Y4X3 ; entry 51
    dfar Map70Screens0_Y4X4 ; entry 52
    dfar Map70Screens0_Y0X0 ; entry 53
    dfar Map70Screens0_Y4X6 ; entry 54
    dfar Map70Screens0_Y0X0 ; entry 55
    dfar Map70Screens0_Y4X8 ; entry 56
    dfar Map70Screens0_Y4X9 ; entry 57
    dfar Map70Screens0_Y4X10 ; entry 58
    dfar Map70Screens0_Y4X11 ; entry 59
    dfar Map70Screens0_Y5X0 ; entry 60
    dfar Map70Screens0_Y5X1 ; entry 61
    dfar Map70Screens0_Y5X2 ; entry 62
    dfar Map70Screens0_Y5X3 ; entry 63
    dfar Map70Screens0_Y5X4 ; entry 64
    dfar Map70Screens0_Y0X0 ; entry 65
    dfar Map70Screens0_Y5X6 ; entry 66
    dfar Map70Screens0_Y5X7 ; entry 67
    dfar Map70Screens0_Y5X8 ; entry 68
    dfar Map70Screens0_Y5X9 ; entry 69
    dfar Map70Screens0_Y0X0 ; entry 70
    dfar Map70Screens0_Y0X0 ; entry 71
    dfar Map70Screens0_Y0X0 ; entry 72
    dfar Map70Screens0_Y6X1 ; entry 73
    dfar Map70Screens0_Y6X2 ; entry 74
    dfar Map70Screens0_Y6X3 ; entry 75
    dfar Map70Screens0_Y6X4 ; entry 76
    dfar Map70Screens0_Y6X5 ; entry 77
    dfar Map70Screens0_Y6X6 ; entry 78
    dfar Map70Screens0_Y6X7 ; entry 79
    dfar Map70Screens0_Y6X8 ; entry 80
    dfar Map70Screens0_Y6X9 ; entry 81
    dfar Map70Screens0_Y0X0 ; entry 82
    dfar Map70Screens0_Y0X0 ; entry 83
    dfar Map70Screens0_Y0X0 ; entry 84
    dfar Map70Screens0_Y7X1 ; entry 85
    dfar Map70Screens0_Y7X2 ; entry 86
    dfar Map70Screens0_Y7X3 ; entry 87
    dfar Map70Screens0_Y7X4 ; entry 88
    dfar Map70Screens0_Y7X5 ; entry 89
    dfar Map70Screens0_Y7X6 ; entry 90
    dfar Map70Screens0_Y7X7 ; entry 91
    dfar Map70Screens0_Y7X8 ; entry 92
    dfar Map70Screens0_Y7X9 ; entry 93
    dfar Map70Screens0_Y0X0 ; entry 94
    dfar Map70Screens0_Y0X0 ; entry 95
    dfar Map70Screens0_Y8X0 ; entry 96
    dfar Map70Screens0_Y8X1 ; entry 97
    dfar Map70Screens0_Y0X0 ; entry 98
    dfar Map70Screens0_Y8X3 ; entry 99
    dfar Map70Screens0_Y8X4 ; entry 100
    dfar Map70Screens0_Y8X5 ; entry 101
    dfar Map70Screens0_Y8X6 ; entry 102
    dfar Map70Screens0_Y8X7 ; entry 103
    dfar Map70Screens0_Y8X8 ; entry 104
    dfar Map70Screens0_Y8X9 ; entry 105
    dfar Map70Screens0_Y0X0 ; entry 106
    dfar Map70Screens0_Y0X0 ; entry 107
    dfar Map70Screens0_Y9X0 ; entry 108
    dfar Map70Screens0_Y9X1 ; entry 109
    dfar Map70Screens0_Y0X0 ; entry 110
    dfar Map70Screens0_Y0X0 ; entry 111
    dfar Map70Screens0_Y9X4 ; entry 112
    dfar Map70Screens0_Y9X5 ; entry 113
    dfar Map70Screens0_Y9X6 ; entry 114
    dfar Map70Screens0_Y9X7 ; entry 115
    dfar Map70Screens0_Y9X8 ; entry 116
    dfar Map70Screens0_Y9X9 ; entry 117
    dfar Map70Screens0_Y9X10 ; entry 118
    dfar Map70Screens0_Y9X11 ; entry 119
    dfar Map70Screens0_Y10X0 ; entry 120
    dfar Map70Screens0_Y10X1 ; entry 121
    dfar Map70Screens0_Y10X2 ; entry 122
    dfar Map70Screens0_Y10X3 ; entry 123
    dfar Map70Screens0_Y10X4 ; entry 124
    dfar Map70Screens0_Y10X5 ; entry 125
    dfar Map70Screens0_Y10X6 ; entry 126
    dfar Map70Screens0_Y0X0 ; entry 127
    dfar Map70Screens0_Y0X0 ; entry 128
    dfar Map70Screens0_Y10X9 ; entry 129
    dfar Map70Screens0_Y10X10 ; entry 130
    dfar Map70Screens0_Y10X11 ; entry 131
    dfar Map70Screens0_Y11X0 ; entry 132
    dfar Map70Screens0_Y11X1 ; entry 133
    dfar Map70Screens0_Y11X2 ; entry 134
    dfar Map70Screens0_Y11X3 ; entry 135
    dfar Map70Screens0_Y11X4 ; entry 136
    dfar Map70Screens0_Y11X5 ; entry 137
    dfar Map70Screens0_Y11X6 ; entry 138
    dfar Map70Screens0_Y0X0 ; entry 139
    dfar Map70Screens0_Y0X0 ; entry 140
    dfar Map70Screens0_Y0X0 ; entry 141
    dfar Map70Screens0_Y11X10 ; entry 142
    dfar Map70Screens0_Y11X11 ; entry 143

; LZSS-compressed: 29 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y0X0::
    db $68, $01, $00, $28, $29, $00, $00, $0e, $38, $39, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

; LZSS-compressed: 156 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y0X1::
    INCBIN "maps/map70/screens0_y0_x1.lz"

; LZSS-compressed: 191 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y0X2::
    INCBIN "maps/map70/screens0_y0_x2.lz"

; LZSS-compressed: 203 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y0X3::
    INCBIN "maps/map70/screens0_y0_x3.lz"

; LZSS-compressed: 177 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y0X4::
    INCBIN "maps/map70/screens0_y0_x4.lz"

; LZSS-compressed: 121 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y0X5::
    INCBIN "maps/map70/screens0_y0_x5.lz"

; LZSS-compressed: 196 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y1X1::
    INCBIN "maps/map70/screens0_y1_x1.lz"

; LZSS-compressed: 167 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y1X2::
    INCBIN "maps/map70/screens0_y1_x2.lz"

; LZSS-compressed: 200 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y1X4::
    INCBIN "maps/map70/screens0_y1_x4.lz"

; LZSS-compressed: 187 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y1X5::
    INCBIN "maps/map70/screens0_y1_x5.lz"

; LZSS-compressed: 145 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y1X6::
    INCBIN "maps/map70/screens0_y1_x6.lz"

; LZSS-compressed: 204 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y1X10::
    INCBIN "maps/map70/screens0_y1_x10.lz"

; LZSS-compressed: 168 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y1X11::
    INCBIN "maps/map70/screens0_y1_x11.lz"

; LZSS-compressed: 241 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y2X1::
    INCBIN "maps/map70/screens0_y2_x1.lz"

; LZSS-compressed: 222 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y2X4::
    INCBIN "maps/map70/screens0_y2_x4.lz"

; LZSS-compressed: 173 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y2X5::
    INCBIN "maps/map70/screens0_y2_x5.lz"

; LZSS-compressed: 196 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y2X6::
    INCBIN "maps/map70/screens0_y2_x6.lz"

; LZSS-compressed: 190 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y2X7::
    INCBIN "maps/map70/screens0_y2_x7.lz"

; LZSS-compressed: 161 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y2X10::
    INCBIN "maps/map70/screens0_y2_x10.lz"

; LZSS-compressed: 151 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y2X11::
    INCBIN "maps/map70/screens0_y2_x11.lz"

; LZSS-compressed: 158 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y3X2::
    INCBIN "maps/map70/screens0_y3_x2.lz"

; LZSS-compressed: 223 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y3X3::
    INCBIN "maps/map70/screens0_y3_x3.lz"

; LZSS-compressed: 130 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y3X5::
    INCBIN "maps/map70/screens0_y3_x5.lz"

; LZSS-compressed: 215 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y3X6::
    INCBIN "maps/map70/screens0_y3_x6.lz"

; LZSS-compressed: 239 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y3X7::
    INCBIN "maps/map70/screens0_y3_x7.lz"

; LZSS-compressed: 155 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y3X8::
    INCBIN "maps/map70/screens0_y3_x8.lz"

; LZSS-compressed: 158 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y3X9::
    INCBIN "maps/map70/screens0_y3_x9.lz"

; LZSS-compressed: 164 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y3X10::
    INCBIN "maps/map70/screens0_y3_x10.lz"

; LZSS-compressed: 170 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y3X11::
    INCBIN "maps/map70/screens0_y3_x11.lz"

; LZSS-compressed: 193 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y4X0::
    INCBIN "maps/map70/screens0_y4_x0.lz"

; LZSS-compressed: 205 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y4X1::
    INCBIN "maps/map70/screens0_y4_x1.lz"

; LZSS-compressed: 194 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y4X2::
    INCBIN "maps/map70/screens0_y4_x2.lz"

; LZSS-compressed: 169 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y4X3::
    INCBIN "maps/map70/screens0_y4_x3.lz"

; LZSS-compressed: 127 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y4X4::
    INCBIN "maps/map70/screens0_y4_x4.lz"

; LZSS-compressed: 200 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y4X6::
    INCBIN "maps/map70/screens0_y4_x6.lz"

; LZSS-compressed: 170 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y4X8::
    INCBIN "maps/map70/screens0_y4_x8.lz"

; LZSS-compressed: 191 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y4X9::
    INCBIN "maps/map70/screens0_y4_x9.lz"

; LZSS-compressed: 198 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y4X10::
    INCBIN "maps/map70/screens0_y4_x10.lz"

; LZSS-compressed: 256 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y4X11::
    INCBIN "maps/map70/screens0_y4_x11.lz"

; LZSS-compressed: 113 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y5X0::
    INCBIN "maps/map70/screens0_y5_x0.lz"

; LZSS-compressed: 242 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y5X1::
    INCBIN "maps/map70/screens0_y5_x1.lz"

; LZSS-compressed: 178 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y5X2::
    INCBIN "maps/map70/screens0_y5_x2.lz"

; LZSS-compressed: 176 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y5X3::
    INCBIN "maps/map70/screens0_y5_x3.lz"

; LZSS-compressed: 235 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y5X4::
    INCBIN "maps/map70/screens0_y5_x4.lz"

; LZSS-compressed: 167 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y5X6::
    INCBIN "maps/map70/screens0_y5_x6.lz"

; LZSS-compressed: 169 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y5X7::
    INCBIN "maps/map70/screens0_y5_x7.lz"

; LZSS-compressed: 219 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y5X8::
    INCBIN "maps/map70/screens0_y5_x8.lz"

; LZSS-compressed: 188 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y5X9::
    INCBIN "maps/map70/screens0_y5_x9.lz"

; LZSS-compressed: 234 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y6X1::
    INCBIN "maps/map70/screens0_y6_x1.lz"

; LZSS-compressed: 122 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y6X2::
    INCBIN "maps/map70/screens0_y6_x2.lz"

; LZSS-compressed: 116 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y6X3::
    INCBIN "maps/map70/screens0_y6_x3.lz"

; LZSS-compressed: 203 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y6X4::
    INCBIN "maps/map70/screens0_y6_x4.lz"

; LZSS-compressed: 205 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y6X5::
    INCBIN "maps/map70/screens0_y6_x5.lz"

; LZSS-compressed: 166 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y6X6::
    INCBIN "maps/map70/screens0_y6_x6.lz"

; LZSS-compressed: 208 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y6X7::
    INCBIN "maps/map70/screens0_y6_x7.lz"

; LZSS-compressed: 162 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y6X8::
    INCBIN "maps/map70/screens0_y6_x8.lz"

; LZSS-compressed: 194 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y6X9::
    INCBIN "maps/map70/screens0_y6_x9.lz"

; LZSS-compressed: 116 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y7X1::
    INCBIN "maps/map70/screens0_y7_x1.lz"

; LZSS-compressed: 228 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y7X2::
    INCBIN "maps/map70/screens0_y7_x2.lz"

; LZSS-compressed: 151 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y7X3::
    INCBIN "maps/map70/screens0_y7_x3.lz"

; LZSS-compressed: 170 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y7X4::
    INCBIN "maps/map70/screens0_y7_x4.lz"

; LZSS-compressed: 171 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y7X5::
    INCBIN "maps/map70/screens0_y7_x5.lz"

; LZSS-compressed: 161 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y7X6::
    INCBIN "maps/map70/screens0_y7_x6.lz"

; LZSS-compressed: 95 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y7X7::
    INCBIN "maps/map70/screens0_y7_x7.lz"

; LZSS-compressed: 164 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y7X8::
    INCBIN "maps/map70/screens0_y7_x8.lz"

; LZSS-compressed: 197 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y7X9::
    INCBIN "maps/map70/screens0_y7_x9.lz"

; LZSS-compressed: 136 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y8X0::
    INCBIN "maps/map70/screens0_y8_x0.lz"

; LZSS-compressed: 180 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y8X1::
    INCBIN "maps/map70/screens0_y8_x1.lz"

; LZSS-compressed: 208 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y8X3::
    INCBIN "maps/map70/screens0_y8_x3.lz"

; LZSS-compressed: 184 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y8X4::
    INCBIN "maps/map70/screens0_y8_x4.lz"

; LZSS-compressed: 122 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y8X5::
    INCBIN "maps/map70/screens0_y8_x5.lz"

; LZSS-compressed: 169 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y8X6::
    INCBIN "maps/map70/screens0_y8_x6.lz"

; LZSS-compressed: 148 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y8X7::
    INCBIN "maps/map70/screens0_y8_x7.lz"

; LZSS-compressed: 215 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y8X8::
    INCBIN "maps/map70/screens0_y8_x8.lz"

; LZSS-compressed: 207 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y8X9::
    INCBIN "maps/map70/screens0_y8_x9.lz"

; LZSS-compressed: 147 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y9X0::
    INCBIN "maps/map70/screens0_y9_x0.lz"

; LZSS-compressed: 157 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y9X1::
    INCBIN "maps/map70/screens0_y9_x1.lz"

; LZSS-compressed: 258 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y9X4::
    INCBIN "maps/map70/screens0_y9_x4.lz"

; LZSS-compressed: 177 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y9X5::
    INCBIN "maps/map70/screens0_y9_x5.lz"

; LZSS-compressed: 231 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y9X6::
    INCBIN "maps/map70/screens0_y9_x6.lz"

; LZSS-compressed: 237 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y9X7::
    INCBIN "maps/map70/screens0_y9_x7.lz"

; LZSS-compressed: 207 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y9X8::
    INCBIN "maps/map70/screens0_y9_x8.lz"

; LZSS-compressed: 166 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y9X9::
    INCBIN "maps/map70/screens0_y9_x9.lz"

; LZSS-compressed: 249 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y9X10::
    INCBIN "maps/map70/screens0_y9_x10.lz"

; LZSS-compressed: 243 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y9X11::
    INCBIN "maps/map70/screens0_y9_x11.lz"

; LZSS-compressed: 171 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y10X0::
    INCBIN "maps/map70/screens0_y10_x0.lz"

; LZSS-compressed: 200 bytes that expand to 360 (E-0016, E-0017)
Map70Screens0_Y10X1::
    INCBIN "maps/map70/screens0_y10_x1.lz"
    ds $84, $00
