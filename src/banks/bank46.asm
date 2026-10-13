SECTION "Bank 46", ROMX[$4000], BANK[$46]
    db $46

; LZSS-compressed: 644 bytes that expand to 2048 (E-0016, E-0017)
Tiles1Gfx_46_4001::
    INCBIN "dwm2-cobi-us.gbc", $118001, $284

; 12 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map00Screens0::
    dfar Map00Screens0_Y0X0 ; entry 0
    dfar Map00Screens0_Y0X0 ; entry 1
    dfar Map00Screens0_Y0X0 ; entry 2
    dfar Map00Screens0_Y0X0 ; entry 3
    dfar Map00Screens0_Y1X1 ; entry 4
    dfar Map00Screens0_Y1X2 ; entry 5
    dfar Map00Screens0_Y2X0 ; entry 6
    dfar Map00Screens0_Y2X1 ; entry 7
    dfar Map00Screens0_Y2X2 ; entry 8
    dfar Map00Screens0_Y3X0 ; entry 9
    dfar Map00Screens0_Y3X1 ; entry 10
    dfar Map00Screens0_Y3X2 ; entry 11

Map00Attrs0::
    dfar Map00Attrs0_Y0X0 ; entry 0
    dfar Map00Attrs0_Y0X0 ; entry 1
    dfar Map00Attrs0_Y0X0 ; entry 2
    dfar Map00Attrs0_Y0X0 ; entry 3
    dfar Map00Attrs0_Y1X1 ; entry 4
    dfar Map00Attrs0_Y1X2 ; entry 5
    dfar Map00Attrs0_Y2X0 ; entry 6
    dfar Map00Attrs0_Y2X1 ; entry 7
    dfar Map00Attrs0_Y2X2 ; entry 8
    dfar Map00Attrs0_Y3X0 ; entry 9
    dfar Map00Attrs0_Y3X1 ; entry 10
    dfar Map00Attrs0_Y3X2 ; entry 11

Map00Screens2::
    dfar Map00Screens0_Y0X0 ; entry 0
    dfar Map00Screens0_Y0X0 ; entry 1
    dfar Map00Screens0_Y0X0 ; entry 2
    dfar Map00Screens0_Y0X0 ; entry 3
    dfar Map00Screens2_Y1X1 ; entry 4
    dfar Map00Screens0_Y1X2 ; entry 5
    dfar Map00Screens0_Y2X0 ; entry 6
    dfar Map00Screens0_Y2X1 ; entry 7
    dfar Map00Screens2_Y2X2 ; entry 8
    dfar Map00Screens0_Y3X0 ; entry 9
    dfar Map00Screens2_Y3X1 ; entry 10
    dfar Map00Screens2_Y3X2 ; entry 11

Map00Attrs2::
    dfar Map00Attrs0_Y0X0 ; entry 0
    dfar Map00Attrs0_Y0X0 ; entry 1
    dfar Map00Attrs0_Y0X0 ; entry 2
    dfar Map00Attrs0_Y0X0 ; entry 3
    dfar Map00Attrs2_Y1X1 ; entry 4
    dfar Map00Attrs0_Y1X2 ; entry 5
    dfar Map00Attrs0_Y2X0 ; entry 6
    dfar Map00Attrs0_Y2X1 ; entry 7
    dfar Map00Attrs2_Y2X2 ; entry 8
    dfar Map00Attrs0_Y3X0 ; entry 9
    dfar Map00Attrs2_Y3X1 ; entry 10
    dfar Map00Attrs2_Y3X2 ; entry 11

Map00Screens3::
    dfar Map00Screens0_Y0X0 ; entry 0
    dfar Map00Screens0_Y0X0 ; entry 1
    dfar Map00Screens0_Y0X0 ; entry 2
    dfar Map00Screens0_Y0X0 ; entry 3
    dfar Map00Screens3_Y1X1 ; entry 4
    dfar Map00Screens0_Y1X2 ; entry 5
    dfar Map00Screens0_Y2X0 ; entry 6
    dfar Map00Screens0_Y2X1 ; entry 7
    dfar Map00Screens3_Y2X2 ; entry 8
    dfar Map00Screens0_Y3X0 ; entry 9
    dfar Map00Screens2_Y3X1 ; entry 10
    dfar Map00Screens2_Y3X2 ; entry 11

Map00Attrs3::
    dfar Map00Attrs0_Y0X0 ; entry 0
    dfar Map00Attrs0_Y0X0 ; entry 1
    dfar Map00Attrs0_Y0X0 ; entry 2
    dfar Map00Attrs0_Y0X0 ; entry 3
    dfar Map00Attrs3_Y1X1 ; entry 4
    dfar Map00Attrs0_Y1X2 ; entry 5
    dfar Map00Attrs0_Y2X0 ; entry 6
    dfar Map00Attrs0_Y2X1 ; entry 7
    dfar Map00Attrs3_Y2X2 ; entry 8
    dfar Map00Attrs0_Y3X0 ; entry 9
    dfar Map00Attrs2_Y3X1 ; entry 10
    dfar Map00Attrs2_Y3X2 ; entry 11

Map00Screens4::
    dfar Map00Screens0_Y0X0 ; entry 0
    dfar Map00Screens0_Y0X0 ; entry 1
    dfar Map00Screens0_Y0X0 ; entry 2
    dfar Map00Screens0_Y0X0 ; entry 3
    dfar Map00Screens3_Y1X1 ; entry 4
    dfar Map00Screens4_Y1X2 ; entry 5
    dfar Map00Screens0_Y2X0 ; entry 6
    dfar Map00Screens0_Y2X1 ; entry 7
    dfar Map00Screens3_Y2X2 ; entry 8
    dfar Map00Screens0_Y3X0 ; entry 9
    dfar Map00Screens2_Y3X1 ; entry 10
    dfar Map00Screens2_Y3X2 ; entry 11

Map00Attrs4::
    dfar Map00Attrs0_Y0X0 ; entry 0
    dfar Map00Attrs0_Y0X0 ; entry 1
    dfar Map00Attrs0_Y0X0 ; entry 2
    dfar Map00Attrs0_Y0X0 ; entry 3
    dfar Map00Attrs3_Y1X1 ; entry 4
    dfar Map00Attrs4_Y1X2 ; entry 5
    dfar Map00Attrs0_Y2X0 ; entry 6
    dfar Map00Attrs0_Y2X1 ; entry 7
    dfar Map00Attrs3_Y2X2 ; entry 8
    dfar Map00Attrs0_Y3X0 ; entry 9
    dfar Map00Attrs2_Y3X1 ; entry 10
    dfar Map00Attrs2_Y3X2 ; entry 11

Map00Screens5::
    dfar Map00Screens0_Y0X0 ; entry 0
    dfar Map00Screens0_Y0X0 ; entry 1
    dfar Map00Screens0_Y0X0 ; entry 2
    dfar Map00Screens0_Y0X0 ; entry 3
    dfar Map00Screens3_Y1X1 ; entry 4
    dfar Map00Screens4_Y1X2 ; entry 5
    dfar Map00Screens5_Y2X0 ; entry 6
    dfar Map00Screens0_Y2X1 ; entry 7
    dfar Map00Screens3_Y2X2 ; entry 8
    dfar Map00Screens0_Y3X0 ; entry 9
    dfar Map00Screens2_Y3X1 ; entry 10
    dfar Map00Screens2_Y3X2 ; entry 11

Map00Attrs5::
    dfar Map00Attrs0_Y0X0 ; entry 0
    dfar Map00Attrs0_Y0X0 ; entry 1
    dfar Map00Attrs0_Y0X0 ; entry 2
    dfar Map00Attrs0_Y0X0 ; entry 3
    dfar Map00Attrs3_Y1X1 ; entry 4
    dfar Map00Attrs4_Y1X2 ; entry 5
    dfar Map00Attrs5_Y2X0 ; entry 6
    dfar Map00Attrs0_Y2X1 ; entry 7
    dfar Map00Attrs3_Y2X2 ; entry 8
    dfar Map00Attrs0_Y3X0 ; entry 9
    dfar Map00Attrs2_Y3X1 ; entry 10
    dfar Map00Attrs2_Y3X2 ; entry 11

Map00Screens6::
    dfar Map00Screens0_Y0X0 ; entry 0
    dfar Map00Screens0_Y0X0 ; entry 1
    dfar Map00Screens0_Y0X0 ; entry 2
    dfar Map00Screens0_Y0X0 ; entry 3
    dfar Map00Screens0_Y1X1 ; entry 4
    dfar Map00Screens4_Y1X2 ; entry 5
    dfar Map00Screens5_Y2X0 ; entry 6
    dfar Map00Screens0_Y2X1 ; entry 7
    dfar Map00Screens3_Y2X2 ; entry 8
    dfar Map00Screens0_Y3X0 ; entry 9
    dfar Map00Screens2_Y3X1 ; entry 10
    dfar Map00Screens2_Y3X2 ; entry 11

Map00Attrs6::
    dfar Map00Attrs0_Y0X0 ; entry 0
    dfar Map00Attrs0_Y0X0 ; entry 1
    dfar Map00Attrs0_Y0X0 ; entry 2
    dfar Map00Attrs0_Y0X0 ; entry 3
    dfar Map00Attrs0_Y1X1 ; entry 4
    dfar Map00Attrs4_Y1X2 ; entry 5
    dfar Map00Attrs5_Y2X0 ; entry 6
    dfar Map00Attrs0_Y2X1 ; entry 7
    dfar Map00Attrs3_Y2X2 ; entry 8
    dfar Map00Attrs0_Y3X0 ; entry 9
    dfar Map00Attrs2_Y3X1 ; entry 10
    dfar Map00Attrs2_Y3X2 ; entry 11

; LZSS-compressed: 28 bytes that expand to 360 (E-0016, E-0017)
Map00Screens0_Y0X0::
    db $68, $01, $02, $00, $01, $02, $00, $0e, $02, $01, $0f, $00, $02, $ff, $ff, $4d
    db $02, $5f, $0f, $4d, $02, $bf, $0f, $4d, $02, $f7, $0f, $0e

; LZSS-compressed: 197 bytes that expand to 360 (E-0016, E-0017)
Map00Screens0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $118451, $C5

; LZSS-compressed: 165 bytes that expand to 360 (E-0016, E-0017)
Map00Screens2_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $118516, $A5

; LZSS-compressed: 203 bytes that expand to 360 (E-0016, E-0017)
Map00Screens3_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $1185BB, $CB

; LZSS-compressed: 147 bytes that expand to 360 (E-0016, E-0017)
Map00Screens0_Y1X2::
    INCBIN "dwm2-cobi-us.gbc", $118686, $93

; LZSS-compressed: 153 bytes that expand to 360 (E-0016, E-0017)
Map00Screens4_Y1X2::
    INCBIN "dwm2-cobi-us.gbc", $118719, $99

; LZSS-compressed: 218 bytes that expand to 360 (E-0016, E-0017)
Map00Screens0_Y2X0::
    INCBIN "dwm2-cobi-us.gbc", $1187B2, $DA

; LZSS-compressed: 223 bytes that expand to 360 (E-0016, E-0017)
Map00Screens5_Y2X0::
    INCBIN "dwm2-cobi-us.gbc", $11888C, $DF

; LZSS-compressed: 139 bytes that expand to 360 (E-0016, E-0017)
Map00Screens0_Y2X1::
    INCBIN "dwm2-cobi-us.gbc", $11896B, $8B

; LZSS-compressed: 178 bytes that expand to 360 (E-0016, E-0017)
Map00Screens0_Y2X2::
    INCBIN "dwm2-cobi-us.gbc", $1189F6, $B2

; LZSS-compressed: 184 bytes that expand to 360 (E-0016, E-0017)
Map00Screens2_Y2X2::
    INCBIN "dwm2-cobi-us.gbc", $118AA8, $B8

; LZSS-compressed: 189 bytes that expand to 360 (E-0016, E-0017)
Map00Screens3_Y2X2::
    INCBIN "dwm2-cobi-us.gbc", $118B60, $BD

; LZSS-compressed: 217 bytes that expand to 360 (E-0016, E-0017)
Map00Screens0_Y3X0::
    INCBIN "dwm2-cobi-us.gbc", $118C1D, $D9

; LZSS-compressed: 162 bytes that expand to 360 (E-0016, E-0017)
Map00Screens0_Y3X1::
    INCBIN "dwm2-cobi-us.gbc", $118CF6, $A2

; LZSS-compressed: 152 bytes that expand to 360 (E-0016, E-0017)
Map00Screens2_Y3X1::
    INCBIN "dwm2-cobi-us.gbc", $118D98, $98

; LZSS-compressed: 158 bytes that expand to 360 (E-0016, E-0017)
Map00Screens0_Y3X2::
    INCBIN "dwm2-cobi-us.gbc", $118E30, $9E

; LZSS-compressed: 129 bytes that expand to 360 (E-0016, E-0017)
Map00Screens2_Y3X2::
    INCBIN "dwm2-cobi-us.gbc", $118ECE, $81

; LZSS-compressed: 28 bytes that expand to 360 (E-0016, E-0017)
Map00Attrs0_Y0X0::
    db $68, $01, $01, $10, $01, $ff, $ff, $00, $01, $ff, $ff, $01, $01, $00, $0f, $4d
    db $01, $60, $0f, $4d, $01, $c0, $0f, $4d, $01, $f8, $0f, $0d

; LZSS-compressed: 132 bytes that expand to 360 (E-0016, E-0017)
Map00Attrs0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $118F6B, $84

; LZSS-compressed: 131 bytes that expand to 360 (E-0016, E-0017)
Map00Attrs2_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $118FEF, $83

; LZSS-compressed: 193 bytes that expand to 360 (E-0016, E-0017)
Map00Attrs3_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $119072, $C1

; LZSS-compressed: 116 bytes that expand to 360 (E-0016, E-0017)
Map00Attrs0_Y1X2::
    INCBIN "dwm2-cobi-us.gbc", $119133, $5A

; LZSS-compressed: 257 bytes that expand to 258 (E-0016, E-0017)
Gfx_46_518D::
    db $02, $01, $40, $02, $01, $58, $0f, $0c, $01, $29, $01, $01, $19, $00, $01, $56
    db $04, $01, $60, $03, $01, $15, $01, $01, $48, $18

; LZSS-compressed: 118 bytes that expand to 360 (E-0016, E-0017)
Map00Attrs4_Y1X2::
    INCBIN "dwm2-cobi-us.gbc", $1191A7, $76

; LZSS-compressed: 113 bytes that expand to 360 (E-0016, E-0017)
Map00Attrs0_Y2X0::
    INCBIN "dwm2-cobi-us.gbc", $11921D, $71

; LZSS-compressed: 115 bytes that expand to 360 (E-0016, E-0017)
Map00Attrs5_Y2X0::
    INCBIN "dwm2-cobi-us.gbc", $11928E, $73

; LZSS-compressed: 98 bytes that expand to 360 (E-0016, E-0017)
Map00Attrs0_Y2X1::
    INCBIN "dwm2-cobi-us.gbc", $119301, $62

; LZSS-compressed: 152 bytes that expand to 360 (E-0016, E-0017)
Map00Attrs0_Y2X2::
    INCBIN "dwm2-cobi-us.gbc", $119363, $98

; LZSS-compressed: 153 bytes that expand to 360 (E-0016, E-0017)
Map00Attrs2_Y2X2::
    INCBIN "dwm2-cobi-us.gbc", $1193FB, $99

; LZSS-compressed: 135 bytes that expand to 360 (E-0016, E-0017)
Map00Attrs3_Y2X2::
    INCBIN "dwm2-cobi-us.gbc", $119494, $87

; LZSS-compressed: 178 bytes that expand to 360 (E-0016, E-0017)
Map00Attrs0_Y3X0::
    INCBIN "dwm2-cobi-us.gbc", $11951B, $B2

; LZSS-compressed: 99 bytes that expand to 360 (E-0016, E-0017)
Map00Attrs0_Y3X1::
    INCBIN "dwm2-cobi-us.gbc", $1195CD, $63

; LZSS-compressed: 104 bytes that expand to 360 (E-0016, E-0017)
Map00Attrs2_Y3X1::
    INCBIN "dwm2-cobi-us.gbc", $119630, $68

; LZSS-compressed: 70 bytes that expand to 360 (E-0016, E-0017)
Map00Attrs0_Y3X2::
    INCBIN "dwm2-cobi-us.gbc", $119698, $46

; LZSS-compressed: 46 bytes that expand to 360 (E-0016, E-0017)
Map00Attrs2_Y3X2::
    db $68, $01, $01, $02, $01, $00, $05, $03, $03, $03, $03, $01, $fa, $ff, $37, $01
    db $0a, $00, $01, $48, $0f, $15, $01, $f8, $fc, $01, $80, $0e, $01, $80, $08, $01
    db $9e, $0f, $03, $01, $58, $08, $01, $c0, $0f, $31, $01, $17, $1f, $3d

; compressed tileset of map $01 (the first map record using it)
; LZSS-compressed: 1352 bytes that expand to 1712 (E-0016, E-0017)
Map01Tileset::
    INCBIN "dwm2-cobi-us.gbc", $11970C, $548

; 12 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map01Screens0::
    dfar Map01Screens0_Y0X0 ; entry 0
    dfar Map01Screens0_Y0X1 ; entry 1
    dfar Map01Screens0_Y0X0 ; entry 2
    dfar Map01Screens0_Y0X0 ; entry 3
    dfar Map01Screens0_Y1X0 ; entry 4
    dfar Map01Screens0_Y1X1 ; entry 5
    dfar Map01Screens0_Y1X2 ; entry 6
    dfar Map01Screens0_Y1X3 ; entry 7
    dfar Map01Screens0_Y2X0 ; entry 8
    dfar Map01Screens0_Y2X1 ; entry 9
    dfar Map01Screens0_Y2X2 ; entry 10
    dfar Map01Screens0_Y2X3 ; entry 11

Map01Attrs0::
    dfar Map01Attrs0_Y0X0 ; entry 0
    dfar Map01Attrs0_Y0X1 ; entry 1
    dfar Map01Attrs0_Y0X0 ; entry 2
    dfar Map01Attrs0_Y0X0 ; entry 3
    dfar Map01Attrs0_Y1X0 ; entry 4
    dfar Map01Attrs0_Y1X1 ; entry 5
    dfar Map01Attrs0_Y1X2 ; entry 6
    dfar Map01Attrs0_Y1X3 ; entry 7
    dfar Map01Attrs0_Y2X0 ; entry 8
    dfar Map01Attrs0_Y2X1 ; entry 9
    dfar Map01Attrs0_Y2X2 ; entry 10
    dfar Map01Attrs0_Y2X3 ; entry 11

Map01Screens3::
    dfar Map01Screens0_Y0X0 ; entry 0
    dfar Map01Screens0_Y0X1 ; entry 1
    dfar Map01Screens0_Y0X0 ; entry 2
    dfar Map01Screens0_Y0X0 ; entry 3
    dfar Map01Screens0_Y1X0 ; entry 4
    dfar Map01Screens0_Y1X1 ; entry 5
    dfar Map01Screens3_Y1X2 ; entry 6
    dfar Map01Screens3_Y1X3 ; entry 7
    dfar Map01Screens0_Y2X0 ; entry 8
    dfar Map01Screens0_Y2X1 ; entry 9
    dfar Map01Screens3_Y2X2 ; entry 10
    dfar Map01Screens3_Y2X3 ; entry 11

Map01Attrs3::
    dfar Map01Attrs0_Y0X0 ; entry 0
    dfar Map01Attrs0_Y0X1 ; entry 1
    dfar Map01Attrs0_Y0X0 ; entry 2
    dfar Map01Attrs0_Y0X0 ; entry 3
    dfar Map01Attrs0_Y1X0 ; entry 4
    dfar Map01Attrs0_Y1X1 ; entry 5
    dfar Map01Attrs3_Y1X2 ; entry 6
    dfar Map01Attrs3_Y1X3 ; entry 7
    dfar Map01Attrs0_Y2X0 ; entry 8
    dfar Map01Attrs0_Y2X1 ; entry 9
    dfar Map01Attrs3_Y2X2 ; entry 10
    dfar Map01Attrs3_Y2X3 ; entry 11

Map01Screens4::
    dfar Map01Screens0_Y0X0 ; entry 0
    dfar Map01Screens0_Y0X1 ; entry 1
    dfar Map01Screens0_Y0X0 ; entry 2
    dfar Map01Screens0_Y0X0 ; entry 3
    dfar Map01Screens0_Y1X0 ; entry 4
    dfar Map01Screens0_Y1X1 ; entry 5
    dfar Map01Screens3_Y1X2 ; entry 6
    dfar Map01Screens3_Y1X3 ; entry 7
    dfar Map01Screens4_Y2X0 ; entry 8
    dfar Map01Screens0_Y2X1 ; entry 9
    dfar Map01Screens3_Y2X2 ; entry 10
    dfar Map01Screens3_Y2X3 ; entry 11

Map01Attrs4::
    dfar Map01Attrs0_Y0X0 ; entry 0
    dfar Map01Attrs0_Y0X1 ; entry 1
    dfar Map01Attrs0_Y0X0 ; entry 2
    dfar Map01Attrs0_Y0X0 ; entry 3
    dfar Map01Attrs0_Y1X0 ; entry 4
    dfar Map01Attrs0_Y1X1 ; entry 5
    dfar Map01Attrs3_Y1X2 ; entry 6
    dfar Map01Attrs3_Y1X3 ; entry 7
    dfar Map01Attrs4_Y2X0 ; entry 8
    dfar Map01Attrs0_Y2X1 ; entry 9
    dfar Map01Attrs3_Y2X2 ; entry 10
    dfar Map01Attrs3_Y2X3 ; entry 11

Map01Screens5::
    dfar Map01Screens0_Y0X0 ; entry 0
    dfar Map01Screens0_Y0X1 ; entry 1
    dfar Map01Screens0_Y0X0 ; entry 2
    dfar Map01Screens0_Y0X0 ; entry 3
    dfar Map01Screens0_Y1X0 ; entry 4
    dfar Map01Screens0_Y1X1 ; entry 5
    dfar Map01Screens3_Y1X2 ; entry 6
    dfar Map01Screens3_Y1X3 ; entry 7
    dfar Map01Screens4_Y2X0 ; entry 8
    dfar Map01Screens5_Y2X1 ; entry 9
    dfar Map01Screens5_Y2X2 ; entry 10
    dfar Map01Screens3_Y2X3 ; entry 11

Map01Attrs5::
    dfar Map01Attrs0_Y0X0 ; entry 0
    dfar Map01Attrs0_Y0X1 ; entry 1
    dfar Map01Attrs0_Y0X0 ; entry 2
    dfar Map01Attrs0_Y0X0 ; entry 3
    dfar Map01Attrs0_Y1X0 ; entry 4
    dfar Map01Attrs0_Y1X1 ; entry 5
    dfar Map01Attrs3_Y1X2 ; entry 6
    dfar Map01Attrs3_Y1X3 ; entry 7
    dfar Map01Attrs4_Y2X0 ; entry 8
    dfar Map01Attrs5_Y2X1 ; entry 9
    dfar Map01Attrs5_Y2X2 ; entry 10
    dfar Map01Attrs3_Y2X3 ; entry 11

Map01Screens6::
    dfar Map01Screens0_Y0X0 ; entry 0
    dfar Map01Screens0_Y0X1 ; entry 1
    dfar Map01Screens0_Y0X0 ; entry 2
    dfar Map01Screens0_Y0X0 ; entry 3
    dfar Map01Screens0_Y1X0 ; entry 4
    dfar Map01Screens0_Y1X1 ; entry 5
    dfar Map01Screens0_Y1X2 ; entry 6
    dfar Map01Screens0_Y1X3 ; entry 7
    dfar Map01Screens4_Y2X0 ; entry 8
    dfar Map01Screens0_Y2X1 ; entry 9
    dfar Map01Screens0_Y2X2 ; entry 10
    dfar Map01Screens0_Y2X3 ; entry 11

Map01Attrs6::
    dfar Map01Attrs0_Y0X0 ; entry 0
    dfar Map01Attrs0_Y0X1 ; entry 1
    dfar Map01Attrs0_Y0X0 ; entry 2
    dfar Map01Attrs0_Y0X0 ; entry 3
    dfar Map01Attrs0_Y1X0 ; entry 4
    dfar Map01Attrs0_Y1X1 ; entry 5
    dfar Map01Attrs0_Y1X2 ; entry 6
    dfar Map01Attrs0_Y1X3 ; entry 7
    dfar Map01Attrs4_Y2X0 ; entry 8
    dfar Map01Attrs0_Y2X1 ; entry 9
    dfar Map01Attrs0_Y2X2 ; entry 10
    dfar Map01Attrs0_Y2X3 ; entry 11

; LZSS-compressed: 196 bytes that expand to 360 (E-0016, E-0017)
Map01Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $119DBC, $C4

; LZSS-compressed: 218 bytes that expand to 360 (E-0016, E-0017)
Map01Screens0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $119E80, $DA

; LZSS-compressed: 115 bytes that expand to 360 (E-0016, E-0017)
Map01Screens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $119F5A, $73

; LZSS-compressed: 205 bytes that expand to 360 (E-0016, E-0017)
Map01Screens0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $119FCD, $CD

; LZSS-compressed: 207 bytes that expand to 360 (E-0016, E-0017)
Map01Screens0_Y1X2::
    INCBIN "dwm2-cobi-us.gbc", $11A09A, $CF

; LZSS-compressed: 235 bytes that expand to 360 (E-0016, E-0017)
Map01Screens3_Y1X2::
    INCBIN "dwm2-cobi-us.gbc", $11A169, $EB

Map01Screens0_Y1X3::
    INCBIN "dwm2-cobi-us.gbc", $11A254, $EB

; LZSS-compressed: 156 bytes that expand to 360 (E-0016, E-0017)
Map01Screens3_Y1X3::
    INCBIN "dwm2-cobi-us.gbc", $11A33F, $9C

; LZSS-compressed: 197 bytes that expand to 360 (E-0016, E-0017)
Map01Screens0_Y2X0::
    INCBIN "dwm2-cobi-us.gbc", $11A3DB, $C5

; LZSS-compressed: 220 bytes that expand to 360 (E-0016, E-0017)
Map01Screens4_Y2X0::
    INCBIN "dwm2-cobi-us.gbc", $11A4A0, $DC

; LZSS-compressed: 150 bytes that expand to 360 (E-0016, E-0017)
Map01Screens0_Y2X1::
    INCBIN "dwm2-cobi-us.gbc", $11A57C, $96

; LZSS-compressed: 149 bytes that expand to 360 (E-0016, E-0017)
Map01Screens5_Y2X1::
    INCBIN "dwm2-cobi-us.gbc", $11A612, $95

; LZSS-compressed: 169 bytes that expand to 360 (E-0016, E-0017)
Map01Screens0_Y2X2::
    INCBIN "dwm2-cobi-us.gbc", $11A6A7, $A9

; LZSS-compressed: 227 bytes that expand to 360 (E-0016, E-0017)
Map01Screens3_Y2X2::
    INCBIN "dwm2-cobi-us.gbc", $11A750, $E3

; LZSS-compressed: 203 bytes that expand to 360 (E-0016, E-0017)
Map01Screens5_Y2X2::
    INCBIN "dwm2-cobi-us.gbc", $11A833, $CB

; LZSS-compressed: 231 bytes that expand to 360 (E-0016, E-0017)
Map01Screens0_Y2X3::
    INCBIN "dwm2-cobi-us.gbc", $11A8FE, $E7

; LZSS-compressed: 182 bytes that expand to 360 (E-0016, E-0017)
Map01Screens3_Y2X3::
    INCBIN "dwm2-cobi-us.gbc", $11A9E5, $B6

; LZSS-compressed: 86 bytes that expand to 360 (E-0016, E-0017)
Map01Attrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $11AA9B, $56

; LZSS-compressed: 103 bytes that expand to 360 (E-0016, E-0017)
Map01Attrs0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $11AAF1, $67

; LZSS-compressed: 48 bytes that expand to 360 (E-0016, E-0017)
Map01Attrs0_Y1X0::
    db $68, $01, $01, $00, $00, $04, $01, $02, $0d, $01, $00, $0f, $29, $02, $02, $01
    db $3e, $0f, $4d, $01, $62, $0f, $05, $03, $03, $04, $04, $01, $ca, $00, $01, $cc
    db $04, $01, $c6, $0f, $07, $01, $f2, $0c, $01, $f0, $0f, $03, $01, $66, $0f, $3b

; LZSS-compressed: 94 bytes that expand to 360 (E-0016, E-0017)
Map01Attrs0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $11AB88, $5E

; LZSS-compressed: 73 bytes that expand to 360 (E-0016, E-0017)
Map01Attrs0_Y1X2::
    INCBIN "dwm2-cobi-us.gbc", $11ABE6, $49

; LZSS-compressed: 92 bytes that expand to 360 (E-0016, E-0017)
Map01Attrs3_Y1X2::
    INCBIN "dwm2-cobi-us.gbc", $11AC2F, $5C

; LZSS-compressed: 72 bytes that expand to 360 (E-0016, E-0017)
Map01Attrs0_Y1X3::
    INCBIN "dwm2-cobi-us.gbc", $11AC8B, $48

; LZSS-compressed: 69 bytes that expand to 360 (E-0016, E-0017)
Map01Attrs3_Y1X3::
    INCBIN "dwm2-cobi-us.gbc", $11ACD3, $45

; LZSS-compressed: 87 bytes that expand to 360 (E-0016, E-0017)
Map01Attrs0_Y2X0::
    INCBIN "dwm2-cobi-us.gbc", $11AD18, $57

; LZSS-compressed: 99 bytes that expand to 360 (E-0016, E-0017)
Map01Attrs4_Y2X0::
    INCBIN "dwm2-cobi-us.gbc", $11AD6F, $63

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
Map01Attrs0_Y2X1::
    INCBIN "dwm2-cobi-us.gbc", $11ADD2, $47

; LZSS-compressed: 78 bytes that expand to 360 (E-0016, E-0017)
Map01Attrs5_Y2X1::
    INCBIN "dwm2-cobi-us.gbc", $11AE19, $4E

; LZSS-compressed: 57 bytes that expand to 360 (E-0016, E-0017)
Map01Attrs0_Y2X2::
    db $68, $01, $01, $02, $01, $00, $05, $03, $03, $02, $02, $01, $fa, $ff, $15, $03
    db $03, $01, $24, $0f, $13, $01, $0c, $02, $01, $50, $0f, $11, $01, $84, $0a, $01
    db $82, $0e, $03, $01, $a8, $01, $01, $9a, $0f, $07, $01, $a8, $02, $01, $c8, $0f
    db $0f, $01, $a0, $0f, $15, $01, $12, $1f, $3d

; LZSS-compressed: 100 bytes that expand to 360 (E-0016, E-0017)
Map01Attrs3_Y2X2::
    INCBIN "dwm2-cobi-us.gbc", $11AEA0, $64

; LZSS-compressed: 97 bytes that expand to 360 (E-0016, E-0017)
Map01Attrs5_Y2X2::
    INCBIN "dwm2-cobi-us.gbc", $11AF04, $61

; LZSS-compressed: 99 bytes that expand to 360 (E-0016, E-0017)
Map01Attrs0_Y2X3::
    INCBIN "dwm2-cobi-us.gbc", $11AF65, $63

; LZSS-compressed: 93 bytes that expand to 360 (E-0016, E-0017)
Map01Attrs3_Y2X3::
    INCBIN "dwm2-cobi-us.gbc", $11AFC8, $5D

; compressed tileset of map $02 (the first map record using it)
; LZSS-compressed: 827 bytes that expand to 1136 (E-0016, E-0017)
Map02Tileset::
    INCBIN "dwm2-cobi-us.gbc", $11B025, $33B

; 3 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map02Screens0::
    dfar Map02Screens0_Y0X0 ; entry 0
    dfar Map02Screens0_Y0X1 ; entry 1
    dfar Map02Screens0_Y0X2 ; entry 2

Map02Attrs0::
    dfar Map02Attrs0_Y0X0 ; entry 0
    dfar Map02Attrs0_Y0X1 ; entry 1
    dfar Map02Attrs0_Y0X2 ; entry 2

Map02Screens1::
    dfar Map02Screens1_Y0X0 ; entry 0
    dfar Map02Screens0_Y0X1 ; entry 1
    dfar Map02Screens0_Y0X2 ; entry 2

Map02Attrs1::
    dfar Map02Attrs1_Y0X0 ; entry 0
    dfar Map02Attrs0_Y0X1 ; entry 1
    dfar Map02Attrs0_Y0X2 ; entry 2

Map02Screens3::
    dfar Map02Screens0_Y0X0 ; entry 0
    dfar Map02Screens0_Y0X1 ; entry 1
    dfar Map02Screens3_Y0X2 ; entry 2

Map02Attrs3::
    dfar Map02Attrs0_Y0X0 ; entry 0
    dfar Map02Attrs0_Y0X1 ; entry 1
    dfar Map02Attrs3_Y0X2 ; entry 2

Map02Screens4::
    dfar Map02Screens4_Y0X0 ; entry 0
    dfar Map02Screens0_Y0X1 ; entry 1
    dfar Map02Screens3_Y0X2 ; entry 2

Map02Attrs4::
    dfar Map02Attrs4_Y0X0 ; entry 0
    dfar Map02Attrs0_Y0X1 ; entry 1
    dfar Map02Attrs3_Y0X2 ; entry 2

Map02Screens5::
    dfar Map02Screens4_Y0X0 ; entry 0
    dfar Map02Screens5_Y0X1 ; entry 1
    dfar Map02Screens5_Y0X2 ; entry 2

Map02Attrs5::
    dfar Map02Attrs4_Y0X0 ; entry 0
    dfar Map02Attrs5_Y0X1 ; entry 1
    dfar Map02Attrs5_Y0X2 ; entry 2

Map02Screens6::
    dfar Map02Screens4_Y0X0 ; entry 0
    dfar Map02Screens0_Y0X1 ; entry 1
    dfar Map02Screens0_Y0X2 ; entry 2

Map02Attrs6::
    dfar Map02Attrs4_Y0X0 ; entry 0
    dfar Map02Attrs0_Y0X1 ; entry 1
    dfar Map02Attrs0_Y0X2 ; entry 2

; LZSS-compressed: 215 bytes that expand to 360 (E-0016, E-0017)
Map02Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $11B3CC, $D7

; LZSS-compressed: 213 bytes that expand to 360 (E-0016, E-0017)
Map02Screens1_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $11B4A3, $D5

; LZSS-compressed: 210 bytes that expand to 360 (E-0016, E-0017)
Map02Screens4_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $11B578, $D2

; LZSS-compressed: 154 bytes that expand to 360 (E-0016, E-0017)
Map02Screens0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $11B64A, $9A

; LZSS-compressed: 150 bytes that expand to 360 (E-0016, E-0017)
Map02Screens5_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $11B6E4, $96

; LZSS-compressed: 133 bytes that expand to 360 (E-0016, E-0017)
Map02Screens0_Y0X2::
    INCBIN "dwm2-cobi-us.gbc", $11B77A, $85

; LZSS-compressed: 168 bytes that expand to 360 (E-0016, E-0017)
Map02Screens3_Y0X2::
    INCBIN "dwm2-cobi-us.gbc", $11B7FF, $A8

; LZSS-compressed: 165 bytes that expand to 360 (E-0016, E-0017)
Map02Screens5_Y0X2::
    INCBIN "dwm2-cobi-us.gbc", $11B8A7, $A5

; LZSS-compressed: 70 bytes that expand to 360 (E-0016, E-0017)
Map02Attrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $11B94C, $46

; LZSS-compressed: 65 bytes that expand to 360 (E-0016, E-0017)
Map02Attrs1_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $11B992, $41

; LZSS-compressed: 79 bytes that expand to 360 (E-0016, E-0017)
Map02Attrs4_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $11B9D3, $4F

; LZSS-compressed: 60 bytes that expand to 360 (E-0016, E-0017)
Map02Attrs0_Y0X1::
    db $68, $01, $01, $01, $ff, $fc, $02, $02, $02, $02, $01, $00, $0f, $01, $03, $01
    db $28, $01, $04, $04, $04, $04, $05, $05, $01, $28, $00, $01, $24, $0f, $0b, $01
    db $50, $0f, $47, $01, $4c, $0f, $01, $01, $10, $02, $01, $28, $00, $01, $04, $0a
    db $01, $c8, $0f, $03, $01, $f1, $0f, $4d, $01, $51, $1f, $03

; LZSS-compressed: 63 bytes that expand to 360 (E-0016, E-0017)
Map02Attrs5_Y0X1::
    db $68, $01, $01, $01, $ff, $fc, $06, $06, $06, $06, $01, $fc, $ff, $01, $03, $01
    db $28, $01, $04, $04, $04, $04, $05, $05, $01, $28, $00, $01, $24, $0f, $0b, $01
    db $50, $0f, $47, $06, $06, $02, $02, $01, $50, $0c, $00, $00, $02, $02, $01, $26
    db $02, $01, $04, $0a, $01, $c8, $0e, $01, $ed, $0f, $4d, $01, $4d, $1f, $07

; LZSS-compressed: 54 bytes that expand to 360 (E-0016, E-0017)
Map02Attrs0_Y0X2::
    db $68, $01, $01, $02, $01, $00, $0f, $3c, $03, $01, $50, $0f, $16, $01, $4e, $06
    db $01, $48, $06, $01, $7a, $0e, $01, $16, $0f, $29, $01, $3e, $0f, $01, $01, $fe
    db $fa, $01, $50, $02, $01, $f0, $0f, $03, $01, $fe, $f6, $01, $14, $14, $01, $18
    db $1f, $05, $01, $43, $1f, $11

; LZSS-compressed: 80 bytes that expand to 360 (E-0016, E-0017)
Map02Attrs3_Y0X2::
    INCBIN "dwm2-cobi-us.gbc", $11BAD3, $50

; LZSS-compressed: 69 bytes that expand to 360 (E-0016, E-0017)
Map02Attrs5_Y0X2::
    INCBIN "dwm2-cobi-us.gbc", $11BB23, $45
    ds $498, $00
