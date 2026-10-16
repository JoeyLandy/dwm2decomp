; ROM bank $56: map screens, attributes and tilesets
; The annotated listing of this bank is build/listing/bank56.asm.

SECTION "Bank 56", ROMX
    db $56

; 64 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map30Screens0::
    dfar Map30Screens0_Y0X0 ; entry 0
    dfar Map30Screens0_Y0X1 ; entry 1
    dfar Map30Screens0_Y0X2 ; entry 2
    dfar Map30Screens0_Y0X3 ; entry 3
    dfar Map30Screens0_Y0X4 ; entry 4
    dfar Map30Screens0_Y0X5 ; entry 5
    dfar Map30Screens0_Y0X6 ; entry 6
    dfar Map30Screens0_Y0X7 ; entry 7
    dfar Map30Screens0_Y0X0 ; entry 8
    dfar Map30Screens0_Y1X1 ; entry 9
    dfar Map30Screens0_Y1X2 ; entry 10
    dfar Map30Screens0_Y1X3 ; entry 11
    dfar Map30Screens0_Y1X4 ; entry 12
    dfar Map30Screens0_Y1X5 ; entry 13
    dfar Map30Screens0_Y1X6 ; entry 14
    dfar Map30Screens0_Y0X0 ; entry 15
    dfar Map30Screens0_Y0X0 ; entry 16
    dfar Map30Screens0_Y2X1 ; entry 17
    dfar Map30Screens0_Y2X2 ; entry 18
    dfar Map30Screens0_Y2X3 ; entry 19
    dfar Map30Screens0_Y2X4 ; entry 20
    dfar Map30Screens0_Y2X5 ; entry 21
    dfar Map30Screens0_Y2X6 ; entry 22
    dfar Map30Screens0_Y0X0 ; entry 23
    dfar Map30Screens0_Y3X0 ; entry 24
    dfar Map30Screens0_Y3X1 ; entry 25
    dfar Map30Screens0_Y3X2 ; entry 26
    dfar Map30Screens0_Y3X3 ; entry 27
    dfar Map30Screens0_Y3X4 ; entry 28
    dfar Map30Screens0_Y3X5 ; entry 29
    dfar Map30Screens0_Y3X6 ; entry 30
    dfar Map30Screens0_Y0X0 ; entry 31
    dfar Map30Screens0_Y4X0 ; entry 32
    dfar Map30Screens0_Y4X1 ; entry 33
    dfar Map30Screens0_Y4X2 ; entry 34
    dfar Map30Screens0_Y4X3 ; entry 35
    dfar Map30Screens0_Y0X0 ; entry 36
    dfar Map30Screens0_Y4X5 ; entry 37
    dfar Map30Screens0_Y4X6 ; entry 38
    dfar Map30Screens0_Y0X0 ; entry 39
    dfar Map30Screens0_Y5X0 ; entry 40
    dfar Map30Screens0_Y5X1 ; entry 41
    dfar Map30Screens0_Y5X2 ; entry 42
    dfar Map30Screens0_Y5X3 ; entry 43
    dfar Map30Screens0_Y5X4 ; entry 44
    dfar Map30Screens0_Y0X0 ; entry 45
    dfar Map30Screens0_Y5X6 ; entry 46
    dfar Map30Screens0_Y5X7 ; entry 47
    dfar Map30Screens0_Y6X0 ; entry 48
    dfar Map30Screens0_Y6X1 ; entry 49
    dfar Map30Screens0_Y6X2 ; entry 50
    dfar Map30Screens0_Y6X3 ; entry 51
    dfar Map30Screens0_Y6X4 ; entry 52
    dfar Map30Screens0_Y6X5 ; entry 53
    dfar Map30Screens0_Y6X6 ; entry 54
    dfar Map30Screens0_Y6X7 ; entry 55
    dfar Map30Screens0_Y0X0 ; entry 56
    dfar Map30Screens0_Y0X0 ; entry 57
    dfar Map30Screens0_Y7X2 ; entry 58
    dfar Map30Screens0_Y7X3 ; entry 59
    dfar Map30Screens0_Y7X4 ; entry 60
    dfar Map30Screens0_Y7X5 ; entry 61
    dfar Map30Screens0_Y7X6 ; entry 62
    dfar Map30Screens0_Y0X0 ; entry 63

Map30Attrs0::
    dfar Map30Attrs0_Y0X0 ; entry 0
    dfar Map30Attrs0_Y0X1 ; entry 1
    dfar Map30Attrs0_Y0X2 ; entry 2
    dfar Map30Attrs0_Y0X3 ; entry 3
    dfar Map30Attrs0_Y0X4 ; entry 4
    dfar Map30Attrs0_Y0X5 ; entry 5
    dfar Map30Attrs0_Y0X6 ; entry 6
    dfar Map30Attrs0_Y0X7 ; entry 7
    dfar Map30Attrs0_Y0X0 ; entry 8
    dfar Map30Attrs0_Y1X1 ; entry 9
    dfar Map30Attrs0_Y1X2 ; entry 10
    dfar Map30Attrs0_Y1X3 ; entry 11
    dfar Map30Attrs0_Y1X4 ; entry 12
    dfar Map30Attrs0_Y1X5 ; entry 13
    dfar Map30Attrs0_Y1X6 ; entry 14
    dfar Map30Attrs0_Y0X0 ; entry 15
    dfar Map30Attrs0_Y0X0 ; entry 16
    dfar Map30Attrs0_Y2X1 ; entry 17
    dfar Map30Attrs0_Y2X2 ; entry 18
    dfar Map30Attrs0_Y2X3 ; entry 19
    dfar Map30Attrs0_Y2X4 ; entry 20
    dfar Map30Attrs0_Y2X5 ; entry 21
    dfar Map30Attrs0_Y2X6 ; entry 22
    dfar Map30Attrs0_Y0X0 ; entry 23
    dfar Map30Attrs0_Y3X0 ; entry 24
    dfar Map30Attrs0_Y3X1 ; entry 25
    dfar Map30Attrs0_Y3X2 ; entry 26
    dfar Map30Attrs0_Y3X3 ; entry 27
    dfar Map30Attrs0_Y3X4 ; entry 28
    dfar Map30Attrs0_Y3X5 ; entry 29
    dfar Map30Attrs0_Y3X6 ; entry 30
    dfar Map30Attrs0_Y0X0 ; entry 31
    dfar Map30Attrs0_Y4X0 ; entry 32
    dfar Map30Attrs0_Y4X1 ; entry 33
    dfar Map30Attrs0_Y4X2 ; entry 34
    dfar Map30Attrs0_Y4X3 ; entry 35
    dfar Map30Attrs0_Y0X0 ; entry 36
    dfar Map30Attrs0_Y4X5 ; entry 37
    dfar Map30Attrs0_Y4X6 ; entry 38
    dfar Map30Attrs0_Y0X0 ; entry 39
    dfar Map30Attrs0_Y5X0 ; entry 40
    dfar Map30Attrs0_Y5X1 ; entry 41
    dfar Map30Attrs0_Y5X2 ; entry 42
    dfar Map30Attrs0_Y5X3 ; entry 43
    dfar Map30Attrs0_Y5X4 ; entry 44
    dfar Map30Attrs0_Y0X0 ; entry 45
    dfar Map30Attrs0_Y5X6 ; entry 46
    dfar Map30Attrs0_Y5X7 ; entry 47
    dfar Map30Attrs0_Y6X0 ; entry 48
    dfar Map30Attrs0_Y6X1 ; entry 49
    dfar Map30Attrs0_Y6X2 ; entry 50
    dfar Map30Attrs0_Y6X3 ; entry 51
    dfar Map30Attrs0_Y6X4 ; entry 52
    dfar Map30Attrs0_Y6X5 ; entry 53
    dfar Map30Attrs0_Y6X6 ; entry 54
    dfar Map30Attrs0_Y6X7 ; entry 55
    dfar Map30Attrs0_Y0X0 ; entry 56
    dfar Map30Attrs0_Y0X0 ; entry 57
    dfar Map30Attrs0_Y7X2 ; entry 58
    dfar Map30Attrs0_Y7X3 ; entry 59
    dfar Map30Attrs0_Y7X4 ; entry 60
    dfar Map30Attrs0_Y7X5 ; entry 61
    dfar Map30Attrs0_Y7X6 ; entry 62
    dfar Map30Attrs0_Y0X0 ; entry 63

Map30Screens2::
    dfar Map30Screens0_Y0X0 ; entry 0
    dfar Map30Screens0_Y0X1 ; entry 1
    dfar Map30Screens0_Y0X2 ; entry 2
    dfar Map30Screens0_Y0X3 ; entry 3
    dfar Map30Screens0_Y0X4 ; entry 4
    dfar Map30Screens0_Y0X5 ; entry 5
    dfar Map30Screens0_Y0X6 ; entry 6
    dfar Map30Screens0_Y0X7 ; entry 7
    dfar Map30Screens0_Y0X0 ; entry 8
    dfar Map30Screens0_Y1X1 ; entry 9
    dfar Map30Screens0_Y1X2 ; entry 10
    dfar Map30Screens0_Y1X3 ; entry 11
    dfar Map30Screens0_Y1X4 ; entry 12
    dfar Map30Screens0_Y1X5 ; entry 13
    dfar Map30Screens0_Y1X6 ; entry 14
    dfar Map30Screens0_Y0X0 ; entry 15
    dfar Map30Screens0_Y0X0 ; entry 16
    dfar Map30Screens0_Y2X1 ; entry 17
    dfar Map30Screens0_Y2X2 ; entry 18
    dfar Map30Screens0_Y2X3 ; entry 19
    dfar Map30Screens2_Y2X4 ; entry 20
    dfar Map30Screens0_Y2X5 ; entry 21
    dfar Map30Screens2_Y2X6 ; entry 22
    dfar Map30Screens0_Y0X0 ; entry 23
    dfar Map30Screens0_Y3X0 ; entry 24
    dfar Map30Screens0_Y3X1 ; entry 25
    dfar Map30Screens0_Y3X2 ; entry 26
    dfar Map30Screens0_Y3X3 ; entry 27
    dfar Map30Screens0_Y3X4 ; entry 28
    dfar Map30Screens2_Y3X5 ; entry 29
    dfar Map30Screens2_Y3X6 ; entry 30
    dfar Map30Screens0_Y0X0 ; entry 31
    dfar Map30Screens0_Y4X0 ; entry 32
    dfar Map30Screens0_Y4X1 ; entry 33
    dfar Map30Screens0_Y4X2 ; entry 34
    dfar Map30Screens0_Y4X3 ; entry 35
    dfar Map30Screens0_Y0X0 ; entry 36
    dfar Map30Screens2_Y4X5 ; entry 37
    dfar Map30Screens2_Y4X6 ; entry 38
    dfar Map30Screens0_Y0X0 ; entry 39
    dfar Map30Screens0_Y5X0 ; entry 40
    dfar Map30Screens2_Y5X1 ; entry 41
    dfar Map30Screens0_Y5X2 ; entry 42
    dfar Map30Screens0_Y5X3 ; entry 43
    dfar Map30Screens0_Y5X4 ; entry 44
    dfar Map30Screens0_Y0X0 ; entry 45
    dfar Map30Screens0_Y0X0 ; entry 46
    dfar Map30Screens0_Y5X7 ; entry 47
    dfar Map30Screens2_Y6X0 ; entry 48
    dfar Map30Screens2_Y6X1 ; entry 49
    dfar Map30Screens0_Y6X2 ; entry 50
    dfar Map30Screens0_Y6X3 ; entry 51
    dfar Map30Screens0_Y6X4 ; entry 52
    dfar Map30Screens0_Y6X5 ; entry 53
    dfar Map30Screens2_Y6X6 ; entry 54
    dfar Map30Screens0_Y6X7 ; entry 55
    dfar Map30Screens0_Y0X0 ; entry 56
    dfar Map30Screens0_Y0X0 ; entry 57
    dfar Map30Screens0_Y7X2 ; entry 58
    dfar Map30Screens0_Y7X3 ; entry 59
    dfar Map30Screens0_Y7X4 ; entry 60
    dfar Map30Screens0_Y7X5 ; entry 61
    dfar Map30Screens0_Y7X6 ; entry 62
    dfar Map30Screens0_Y0X0 ; entry 63

Map30Attrs2::
    dfar Map30Attrs0_Y0X0 ; entry 0
    dfar Map30Attrs0_Y0X1 ; entry 1
    dfar Map30Attrs0_Y0X2 ; entry 2
    dfar Map30Attrs0_Y0X3 ; entry 3
    dfar Map30Attrs0_Y0X4 ; entry 4
    dfar Map30Attrs0_Y0X5 ; entry 5
    dfar Map30Attrs0_Y0X6 ; entry 6
    dfar Map30Attrs0_Y0X7 ; entry 7
    dfar Map30Attrs0_Y0X0 ; entry 8
    dfar Map30Attrs0_Y1X1 ; entry 9
    dfar Map30Attrs0_Y1X2 ; entry 10
    dfar Map30Attrs0_Y1X3 ; entry 11
    dfar Map30Attrs0_Y1X4 ; entry 12
    dfar Map30Attrs0_Y1X5 ; entry 13
    dfar Map30Attrs0_Y1X6 ; entry 14
    dfar Map30Attrs0_Y0X0 ; entry 15
    dfar Map30Attrs0_Y0X0 ; entry 16
    dfar Map30Attrs0_Y2X1 ; entry 17
    dfar Map30Attrs0_Y2X2 ; entry 18
    dfar Map30Attrs0_Y2X3 ; entry 19
    dfar Map30Attrs2_Y2X4 ; entry 20
    dfar Map30Attrs0_Y2X5 ; entry 21
    dfar Map30Attrs2_Y2X6 ; entry 22
    dfar Map30Attrs0_Y0X0 ; entry 23
    dfar Map30Attrs0_Y3X0 ; entry 24
    dfar Map30Attrs0_Y3X1 ; entry 25
    dfar Map30Attrs0_Y3X2 ; entry 26
    dfar Map30Attrs0_Y3X3 ; entry 27
    dfar Map30Attrs0_Y3X4 ; entry 28
    dfar Map30Attrs2_Y3X5 ; entry 29
    dfar Map30Attrs2_Y3X6 ; entry 30
    dfar Map30Attrs0_Y0X0 ; entry 31
    dfar Map30Attrs0_Y4X0 ; entry 32
    dfar Map30Attrs0_Y4X1 ; entry 33
    dfar Map30Attrs0_Y4X2 ; entry 34
    dfar Map30Attrs0_Y4X3 ; entry 35
    dfar Map30Attrs0_Y0X0 ; entry 36
    dfar Map30Attrs2_Y4X5 ; entry 37
    dfar Map30Attrs2_Y4X6 ; entry 38
    dfar Map30Attrs0_Y0X0 ; entry 39
    dfar Map30Attrs0_Y5X0 ; entry 40
    dfar Map30Attrs2_Y5X1 ; entry 41
    dfar Map30Attrs0_Y5X2 ; entry 42
    dfar Map30Attrs0_Y5X3 ; entry 43
    dfar Map30Attrs0_Y5X4 ; entry 44
    dfar Map30Attrs0_Y0X0 ; entry 45
    dfar Map30Attrs0_Y0X0 ; entry 46
    dfar Map30Attrs0_Y5X7 ; entry 47
    dfar Map30Attrs2_Y6X0 ; entry 48
    dfar Map30Attrs2_Y6X1 ; entry 49
    dfar Map30Attrs0_Y6X2 ; entry 50
    dfar Map30Attrs0_Y6X3 ; entry 51
    dfar Map30Attrs0_Y6X4 ; entry 52
    dfar Map30Attrs0_Y6X5 ; entry 53
    dfar Map30Attrs2_Y6X6 ; entry 54
    dfar Map30Attrs0_Y6X7 ; entry 55
    dfar Map30Attrs0_Y0X0 ; entry 56
    dfar Map30Attrs0_Y0X0 ; entry 57
    dfar Map30Attrs0_Y7X2 ; entry 58
    dfar Map30Attrs0_Y7X3 ; entry 59
    dfar Map30Attrs0_Y7X4 ; entry 60
    dfar Map30Attrs0_Y7X5 ; entry 61
    dfar Map30Attrs0_Y7X6 ; entry 62
    dfar Map30Attrs0_Y0X0 ; entry 63

; LZSS-compressed: 28 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y0X0::
    db $68, $01, $02, $00, $01, $02, $00, $0e, $02, $01, $0f, $00, $02, $ff, $ff, $4d
    db $02, $5f, $0f, $4d, $02, $bf, $0f, $4d, $02, $f7, $0f, $0e

; LZSS-compressed: 216 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y0X1::
    INCBIN "maps/map30/screens0_y0_x1.lz"

; LZSS-compressed: 175 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y0X2::
    INCBIN "maps/map30/screens0_y0_x2.lz"

; LZSS-compressed: 106 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y0X3::
    INCBIN "maps/map30/screens0_y0_x3.lz"

; LZSS-compressed: 103 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y0X4::
    INCBIN "maps/map30/screens0_y0_x4.lz"

; LZSS-compressed: 144 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y0X5::
    INCBIN "maps/map30/screens0_y0_x5.lz"

; LZSS-compressed: 180 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y0X6::
    INCBIN "maps/map30/screens0_y0_x6.lz"

; LZSS-compressed: 190 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y0X7::
    INCBIN "maps/map30/screens0_y0_x7.lz"

; LZSS-compressed: 166 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y1X1::
    INCBIN "maps/map30/screens0_y1_x1.lz"

; LZSS-compressed: 178 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y1X2::
    INCBIN "maps/map30/screens0_y1_x2.lz"

Map30Screens0_Y1X3::
    INCBIN "maps/map30/screens0_y1_x3.lz"

; LZSS-compressed: 206 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y1X4::
    INCBIN "maps/map30/screens0_y1_x4.lz"

; LZSS-compressed: 210 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y1X5::
    INCBIN "maps/map30/screens0_y1_x5.lz"

; LZSS-compressed: 168 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y1X6::
    INCBIN "maps/map30/screens0_y1_x6.lz"

Map30Screens0_Y2X1::
    INCBIN "maps/map30/screens0_y2_x1.lz"

; LZSS-compressed: 176 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y2X2::
    INCBIN "maps/map30/screens0_y2_x2.lz"

; LZSS-compressed: 179 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y2X3::
    INCBIN "maps/map30/screens0_y2_x3.lz"

; LZSS-compressed: 199 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y2X4::
    INCBIN "maps/map30/screens0_y2_x4.lz"

; LZSS-compressed: 173 bytes that expand to 360 (E-0016, E-0017)
Map30Screens2_Y2X4::
    INCBIN "maps/map30/screens2_y2_x4.lz"

; LZSS-compressed: 132 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y2X5::
    INCBIN "maps/map30/screens0_y2_x5.lz"

Map30Screens0_Y2X6::
    INCBIN "maps/map30/screens0_y2_x6.lz"

; LZSS-compressed: 168 bytes that expand to 360 (E-0016, E-0017)
Map30Screens2_Y2X6::
    INCBIN "maps/map30/screens2_y2_x6.lz"

; LZSS-compressed: 175 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y3X0::
    INCBIN "maps/map30/screens0_y3_x0.lz"

; LZSS-compressed: 201 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y3X1::
    INCBIN "maps/map30/screens0_y3_x1.lz"

; LZSS-compressed: 170 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y3X2::
    INCBIN "maps/map30/screens0_y3_x2.lz"

; LZSS-compressed: 205 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y3X3::
    INCBIN "maps/map30/screens0_y3_x3.lz"

; LZSS-compressed: 211 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y3X4::
    INCBIN "maps/map30/screens0_y3_x4.lz"

; LZSS-compressed: 196 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y3X5::
    INCBIN "maps/map30/screens0_y3_x5.lz"

; LZSS-compressed: 182 bytes that expand to 360 (E-0016, E-0017)
Map30Screens2_Y3X5::
    INCBIN "maps/map30/screens2_y3_x5.lz"

; LZSS-compressed: 176 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y3X6::
    INCBIN "maps/map30/screens0_y3_x6.lz"

Map30Screens2_Y3X6::
    INCBIN "maps/map30/screens2_y3_x6.lz"

; LZSS-compressed: 189 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y4X0::
    INCBIN "maps/map30/screens0_y4_x0.lz"

; LZSS-compressed: 198 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y4X1::
    INCBIN "maps/map30/screens0_y4_x1.lz"

Map30Screens0_Y4X2::
    INCBIN "maps/map30/screens0_y4_x2.lz"

; LZSS-compressed: 203 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y4X3::
    INCBIN "maps/map30/screens0_y4_x3.lz"

; LZSS-compressed: 180 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y4X5::
    INCBIN "maps/map30/screens0_y4_x5.lz"

; LZSS-compressed: 183 bytes that expand to 360 (E-0016, E-0017)
Map30Screens2_Y4X5::
    INCBIN "maps/map30/screens2_y4_x5.lz"

; LZSS-compressed: 163 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y4X6::
    INCBIN "maps/map30/screens0_y4_x6.lz"

; LZSS-compressed: 144 bytes that expand to 360 (E-0016, E-0017)
Map30Screens2_Y4X6::
    INCBIN "maps/map30/screens2_y4_x6.lz"

; LZSS-compressed: 140 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y5X0::
    INCBIN "maps/map30/screens0_y5_x0.lz"

; LZSS-compressed: 211 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y5X1::
    INCBIN "maps/map30/screens0_y5_x1.lz"

; LZSS-compressed: 192 bytes that expand to 360 (E-0016, E-0017)
Map30Screens2_Y5X1::
    INCBIN "maps/map30/screens2_y5_x1.lz"

; LZSS-compressed: 186 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y5X2::
    INCBIN "maps/map30/screens0_y5_x2.lz"

; LZSS-compressed: 194 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y5X3::
    INCBIN "maps/map30/screens0_y5_x3.lz"

; LZSS-compressed: 220 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y5X4::
    INCBIN "maps/map30/screens0_y5_x4.lz"

; LZSS-compressed: 117 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y5X6::
    INCBIN "maps/map30/screens0_y5_x6.lz"

; LZSS-compressed: 160 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y5X7::
    INCBIN "maps/map30/screens0_y5_x7.lz"

; LZSS-compressed: 159 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y6X0::
    INCBIN "maps/map30/screens0_y6_x0.lz"

; LZSS-compressed: 135 bytes that expand to 360 (E-0016, E-0017)
Map30Screens2_Y6X0::
    INCBIN "maps/map30/screens2_y6_x0.lz"

; LZSS-compressed: 169 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y6X1::
    INCBIN "maps/map30/screens0_y6_x1.lz"

; LZSS-compressed: 187 bytes that expand to 360 (E-0016, E-0017)
Map30Screens2_Y6X1::
    INCBIN "maps/map30/screens2_y6_x1.lz"

; LZSS-compressed: 180 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y6X2::
    INCBIN "maps/map30/screens0_y6_x2.lz"

; LZSS-compressed: 153 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y6X3::
    INCBIN "maps/map30/screens0_y6_x3.lz"

; LZSS-compressed: 167 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y6X4::
    INCBIN "maps/map30/screens0_y6_x4.lz"

; LZSS-compressed: 157 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y6X5::
    INCBIN "maps/map30/screens0_y6_x5.lz"

; LZSS-compressed: 213 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y6X6::
    INCBIN "maps/map30/screens0_y6_x6.lz"

; LZSS-compressed: 200 bytes that expand to 360 (E-0016, E-0017)
Map30Screens2_Y6X6::
    INCBIN "maps/map30/screens2_y6_x6.lz"

; LZSS-compressed: 206 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y6X7::
    INCBIN "maps/map30/screens0_y6_x7.lz"

; LZSS-compressed: 171 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y7X2::
    INCBIN "maps/map30/screens0_y7_x2.lz"

; LZSS-compressed: 187 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y7X3::
    INCBIN "maps/map30/screens0_y7_x3.lz"

; LZSS-compressed: 137 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y7X4::
    INCBIN "maps/map30/screens0_y7_x4.lz"

; LZSS-compressed: 148 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y7X5::
    INCBIN "maps/map30/screens0_y7_x5.lz"

; LZSS-compressed: 139 bytes that expand to 360 (E-0016, E-0017)
Map30Screens0_Y7X6::
    INCBIN "maps/map30/screens0_y7_x6.lz"

; LZSS-compressed: 19 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y0X0::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $5f, $0f, $4d, $01, $bf, $0f, $4d, $01
    db $1f, $1f, $35

; LZSS-compressed: 91 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y0X1::
    INCBIN "maps/map30/attrs0_y0_x1.lz"

; LZSS-compressed: 79 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y0X2::
    INCBIN "maps/map30/attrs0_y0_x2.lz"

; LZSS-compressed: 54 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y0X3::
    db $68, $01, $03, $03, $a0, $ff, $4d, $03, $4e, $0f, $3b, $01, $03, $ae, $01, $03
    db $a0, $0f, $0d, $03, $ae, $00, $02, $02, $02, $02, $03, $c8, $0f, $09, $03, $ae
    db $02, $03, $d8, $00, $03, $ee, $0f, $09, $03, $f8, $08, $03, $16, $1f, $0f, $03
    db $46, $14, $03, $40, $1f, $01

; LZSS-compressed: 51 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y0X4::
    db $68, $01, $03, $03, $a0, $ff, $4d, $03, $40, $0f, $2d, $01, $01, $01, $01, $03
    db $90, $0f, $11, $02, $02, $03, $a0, $0e, $03, $c8, $0f, $03, $03, $c8, $0e, $03
    db $f0, $0f, $01, $01, $01, $03, $f0, $0e, $03, $18, $1f, $03, $03, $40, $14, $03
    db $36, $1f, $0b

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y0X5::
    INCBIN "maps/map30/attrs0_y0_x5.lz"

; LZSS-compressed: 89 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y0X6::
    INCBIN "maps/map30/attrs0_y0_x6.lz"

; LZSS-compressed: 73 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y0X7::
    INCBIN "maps/map30/attrs0_y0_x7.lz"

; LZSS-compressed: 65 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y1X1::
    INCBIN "maps/map30/attrs0_y1_x1.lz"

; LZSS-compressed: 88 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y1X2::
    INCBIN "maps/map30/attrs0_y1_x2.lz"

; LZSS-compressed: 80 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y1X3::
    INCBIN "maps/map30/attrs0_y1_x3.lz"

; LZSS-compressed: 94 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y1X4::
    INCBIN "maps/map30/attrs0_y1_x4.lz"

; LZSS-compressed: 89 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y1X5::
    INCBIN "maps/map30/attrs0_y1_x5.lz"

; LZSS-compressed: 73 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y1X6::
    INCBIN "maps/map30/attrs0_y1_x6.lz"

; LZSS-compressed: 65 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y2X1::
    INCBIN "maps/map30/attrs0_y2_x1.lz"

; LZSS-compressed: 68 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y2X2::
    INCBIN "maps/map30/attrs0_y2_x2.lz"

; LZSS-compressed: 78 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y2X3::
    INCBIN "maps/map30/attrs0_y2_x3.lz"

; LZSS-compressed: 99 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y2X4::
    INCBIN "maps/map30/attrs0_y2_x4.lz"

; LZSS-compressed: 74 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs2_Y2X4::
    INCBIN "maps/map30/attrs2_y2_x4.lz"

; LZSS-compressed: 62 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y2X5::
    db $68, $01, $03, $03, $ff, $fa, $02, $02, $01, $01, $01, $01, $03, $00, $0f, $39
    db $03, $0e, $00, $03, $50, $0f, $0d, $01, $01, $03, $5e, $00, $02, $02, $03, $78
    db $0f, $0f, $03, $84, $02, $03, $a0, $0f, $0d, $03, $aa, $02, $03, $12, $0c, $03
    db $d6, $0f, $01, $03, $aa, $02, $03, $f0, $0f, $11, $03, $27, $1f, $2d

; LZSS-compressed: 107 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y2X6::
    INCBIN "maps/map30/attrs0_y2_x6.lz"

; LZSS-compressed: 68 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs2_Y2X6::
    INCBIN "maps/map30/attrs2_y2_x6.lz"

; LZSS-compressed: 69 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y3X0::
    INCBIN "maps/map30/attrs0_y3_x0.lz"

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y3X1::
    INCBIN "maps/map30/attrs0_y3_x1.lz"

; LZSS-compressed: 59 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y3X2::
    db $68, $01, $03, $03, $ff, $ff, $47, $01, $03, $5a, $01, $03, $4c, $0f, $09, $03
    db $5a, $00, $02, $03, $80, $01, $03, $5c, $06, $03, $7c, $0c, $03, $80, $02, $03
    db $a0, $06, $03, $7c, $06, $03, $a6, $0e, $03, $5a, $02, $03, $a2, $0e, $03, $b2
    db $08, $03, $5a, $02, $03, $f5, $0f, $4d, $03, $08, $1e

; LZSS-compressed: 93 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y3X3::
    INCBIN "maps/map30/attrs0_y3_x3.lz"

; LZSS-compressed: 81 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y3X4::
    INCBIN "maps/map30/attrs0_y3_x4.lz"

; LZSS-compressed: 77 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y3X5::
    INCBIN "maps/map30/attrs0_y3_x5.lz"

; LZSS-compressed: 67 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs2_Y3X5::
    INCBIN "maps/map30/attrs2_y3_x5.lz"

; LZSS-compressed: 83 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y3X6::
    INCBIN "maps/map30/attrs0_y3_x6.lz"

Map30Attrs2_Y3X6::
    INCBIN "maps/map30/attrs2_y3_x6.lz"

; LZSS-compressed: 80 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y4X0::
    INCBIN "maps/map30/attrs0_y4_x0.lz"

; LZSS-compressed: 74 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y4X1::
    INCBIN "maps/map30/attrs0_y4_x1.lz"

Map30Attrs0_Y4X2::
    INCBIN "maps/map30/attrs0_y4_x2.lz"

Map30Attrs0_Y4X3::
    INCBIN "maps/map30/attrs0_y4_x3.lz"

; LZSS-compressed: 87 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y4X5::
    INCBIN "maps/map30/attrs0_y4_x5.lz"

; LZSS-compressed: 66 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs2_Y4X5::
    INCBIN "maps/map30/attrs2_y4_x5.lz"

; LZSS-compressed: 96 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y4X6::
    INCBIN "maps/map30/attrs0_y4_x6.lz"

; LZSS-compressed: 61 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs2_Y4X6::
    db $68, $01, $03, $02, $03, $00, $05, $01, $01, $01, $01, $03, $fa, $ff, $0f, $03
    db $0a, $00, $03, $20, $0f, $0f, $03, $30, $02, $03, $48, $0f, $0d, $03, $56, $0a
    db $03, $76, $0f, $03, $03, $56, $04, $03, $94, $0f, $0d, $03, $9c, $06, $03, $f2
    db $fa, $03, $cc, $0f, $01, $03, $f3, $0f, $4d, $03, $53, $1f, $01

; LZSS-compressed: 65 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y5X0::
    INCBIN "maps/map30/attrs0_y5_x0.lz"

; LZSS-compressed: 92 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y5X1::
    INCBIN "maps/map30/attrs0_y5_x1.lz"

; LZSS-compressed: 72 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs2_Y5X1::
    INCBIN "maps/map30/attrs2_y5_x1.lz"

; LZSS-compressed: 56 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y5X2::
    db $68, $01, $03, $00, $00, $01, $01, $02, $03, $04, $0b, $03, $00, $0f, $05, $03
    db $02, $02, $03, $2a, $04, $03, $26, $0f, $05, $03, $28, $02, $03, $2a, $02, $03
    db $02, $02, $03, $50, $0f, $0d, $03, $54, $04, $03, $78, $0f, $4d, $03, $b0, $0f
    db $1d, $03, $b6, $0c, $03, $18, $1f, $29

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y5X3::
    INCBIN "maps/map30/attrs0_y5_x3.lz"

; LZSS-compressed: 80 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y5X4::
    INCBIN "maps/map30/attrs0_y5_x4.lz"

; LZSS-compressed: 65 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y5X6::
    INCBIN "maps/map30/attrs0_y5_x6.lz"

; LZSS-compressed: 59 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y5X7::
    db $68, $01, $03, $03, $ff, $ff, $21, $01, $01, $03, $22, $0f, $0f, $01, $03, $58
    db $01, $03, $4a, $0f, $0d, $03, $58, $00, $02, $02, $03, $5a, $0a, $03, $7e, $0e
    db $03, $7e, $02, $03, $96, $0f, $17, $03, $82, $08, $03, $cc, $0f, $29, $03, $32
    db $00, $03, $0c, $1f, $1d, $03, $2a, $08, $03, $48, $18

; LZSS-compressed: 91 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y6X0::
    INCBIN "maps/map30/attrs0_y6_x0.lz"

Map30Attrs2_Y6X0::
    db $68, $01, $03, $03, $a0, $ff, $4d, $03, $24, $0f, $11, $01, $03, $84, $03, $03
    db $78, $0f, $07, $01, $01, $02, $02, $03, $a6, $04, $02, $02, $03, $a0, $0f, $05
    db $03, $a6, $02, $03, $84, $00, $03, $a8, $02, $03, $c8, $0f, $07, $03, $9c, $08
    db $03, $8a, $02, $03, $f4, $0f, $01, $03, $1b, $1f, $39

; LZSS-compressed: 104 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y6X1::
    INCBIN "maps/map30/attrs0_y6_x1.lz"

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs2_Y6X1::
    INCBIN "maps/map30/attrs2_y6_x1.lz"

; LZSS-compressed: 58 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y6X2::
    db $68, $01, $02, $02, $ff, $f2, $01, $02, $06, $09, $02, $00, $0f, $07, $02, $04
    db $0a, $02, $28, $0f, $09, $02, $02, $08, $02, $50, $0f, $03, $02, $24, $0e, $02
    db $78, $0f, $0b, $02, $0a, $08, $02, $a2, $0f, $01, $02, $2a, $0f, $1b, $02, $1c
    db $0f, $13, $02, $06, $0f, $15, $02, $06, $0f, $0f

; LZSS-compressed: 54 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y6X3::
    db $68, $01, $00, $01, $00, $00, $09, $02, $00, $0e, $01, $00, $00, $0f, $0d, $00
    db $0e, $02, $00, $26, $0f, $0b, $00, $34, $04, $00, $4c, $0f, $0b, $00, $58, $0f
    db $13, $00, $32, $0f, $13, $00, $08, $04, $00, $00, $0a, $00, $cc, $0f, $05, $00
    db $f7, $0f, $4d, $00, $d2, $0c

; LZSS-compressed: 76 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y6X4::
    INCBIN "maps/map30/attrs0_y6_x4.lz"

; LZSS-compressed: 69 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y6X5::
    INCBIN "maps/map30/attrs0_y6_x5.lz"

; LZSS-compressed: 92 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y6X6::
    INCBIN "maps/map30/attrs0_y6_x6.lz"

; LZSS-compressed: 83 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs2_Y6X6::
    INCBIN "maps/map30/attrs2_y6_x6.lz"

; LZSS-compressed: 87 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y6X7::
    INCBIN "maps/map30/attrs0_y6_x7.lz"

; LZSS-compressed: 60 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y7X2::
    db $68, $01, $03, $03, $ff, $f2, $01, $03, $06, $09, $03, $00, $0f, $05, $03, $06
    db $0a, $03, $26, $0f, $05, $02, $02, $03, $40, $0f, $13, $03, $02, $0f, $17, $03
    db $02, $06, $03, $04, $02, $03, $a0, $0f, $09, $03, $ff, $f0, $02, $02, $03, $f4
    db $fe, $03, $d4, $0f, $01, $03, $fb, $0f, $4d, $03, $5b, $18

; LZSS-compressed: 41 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y7X3::
    db $68, $01, $02, $01, $02, $00, $0f, $4d, $02, $44, $0f, $30, $02, $fe, $ff, $01
    db $02, $fe, $fc, $02, $fa, $ff, $01, $02, $c8, $0f, $07, $02, $fe, $f4, $02, $fc
    db $f2, $02, $f0, $0f, $09, $02, $1f, $1f, $35

; LZSS-compressed: 58 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y7X4::
    db $68, $01, $03, $01, $03, $00, $0f, $4d, $03, $2a, $0f, $16, $02, $02, $03, $78
    db $0f, $0f, $02, $03, $ae, $01, $03, $a0, $0f, $09, $03, $ae, $02, $03, $ae, $00
    db $03, $fe, $f6, $03, $d0, $0e, $03, $d4, $04, $03, $fa, $f8, $03, $f6, $0a, $03
    db $fe, $f2, $03, $f0, $ff, $01, $03, $a0, $ff, $23

Map30Attrs0_Y7X5::
    db $68, $01, $03, $01, $01, $01, $01, $02, $03, $04, $01, $03, $00, $00, $03, $0a
    db $06, $03, $04, $0f, $05, $03, $0a, $0a, $03, $2a, $0f, $01, $03, $04, $04, $03
    db $fe, $f2, $03, $4c, $0f, $05, $03, $52, $06, $03, $6e, $0f, $0f, $03, $f4, $ff
    db $01, $03, $f4, $fc, $03, $a0, $ff, $4d, $03, $27, $1f, $2d

; LZSS-compressed: 38 bytes that expand to 360 (E-0016, E-0017)
Map30Attrs0_Y7X6::
    db $68, $01, $02, $01, $02, $00, $09, $02, $fa, $ff, $3b, $02, $f8, $ff, $01, $02
    db $5c, $0f, $25, $02, $f4, $ff, $01, $02, $f2, $fc, $02, $ee, $ff, $01, $02, $a0
    db $ff, $4d, $02, $3f, $1f, $15
    ds $7d, $00
