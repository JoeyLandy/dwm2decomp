SECTION "Bank 4E", ROMX[$4000], BANK[$4E]
    db $4e

; compressed tileset of map $4F (the first map record using it)
; LZSS-compressed: 1490 bytes that expand to 1776 (E-0016, E-0017)
Map4FTileset::
    INCBIN "dwm2-cobi-us.gbc", $138001, $5D2

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map4FScreens0::
    dfar Map4FScreens0_Y0X0 ; entry 0
    dfar Map4FScreens0_Y0X1 ; entry 1
    dfar Map4FScreens0_Y1X0 ; entry 2
    dfar Map4FScreens0_Y1X1 ; entry 3

Map4FAttrs0::
    dfar Map4FAttrs0_Y0X0 ; entry 0
    dfar Map4FAttrs0_Y0X1 ; entry 1
    dfar Map4FAttrs0_Y1X0 ; entry 2
    dfar Map4FAttrs0_Y1X1 ; entry 3

Map4FScreens2::
    dfar Map4FScreens0_Y0X0 ; entry 0
    dfar Map4FScreens0_Y0X1 ; entry 1
    dfar Map4FScreens2_Y1X0 ; entry 2
    dfar Map4FScreens2_Y1X1 ; entry 3

Map4FAttrs2::
    dfar Map4FAttrs0_Y0X0 ; entry 0
    dfar Map4FAttrs0_Y0X1 ; entry 1
    dfar Map4FAttrs2_Y1X0 ; entry 2
    dfar Map4FAttrs2_Y1X1 ; entry 3

; LZSS-compressed: 225 bytes that expand to 360 (E-0016, E-0017)
Map4FScreens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $138603, $E1

; LZSS-compressed: 241 bytes that expand to 360 (E-0016, E-0017)
Map4FScreens0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $1386E4, $F1

; LZSS-compressed: 228 bytes that expand to 360 (E-0016, E-0017)
Map4FScreens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $1387D5, $E4

; LZSS-compressed: 216 bytes that expand to 360 (E-0016, E-0017)
Map4FScreens2_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $1388B9, $D8

; LZSS-compressed: 231 bytes that expand to 360 (E-0016, E-0017)
Map4FScreens0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $138991, $E7

; LZSS-compressed: 200 bytes that expand to 360 (E-0016, E-0017)
Map4FScreens2_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $138A78, $C8

; LZSS-compressed: 79 bytes that expand to 360 (E-0016, E-0017)
Map4FAttrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $138B40, $4F

; LZSS-compressed: 90 bytes that expand to 360 (E-0016, E-0017)
Map4FAttrs0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $138B8F, $5A

; LZSS-compressed: 60 bytes that expand to 360 (E-0016, E-0017)
Map4FAttrs0_Y1X0::
    db $68, $01, $01, $01, $ff, $ff, $17, $02, $02, $01, $ff, $f4, $04, $01, $34, $01
    db $01, $26, $0f, $05, $01, $36, $04, $01, $46, $0f, $0f, $01, $ff, $fe, $01, $7a
    db $0f, $01, $01, $f0, $ff, $29, $01, $2a, $06, $01, $fa, $ff, $1d, $06, $01, $18
    db $17, $01, $16, $1a, $01, $1e, $1f, $07, $01, $3a, $1f, $09

Map4FAttrs2_Y1X0::
    db $68, $01, $01, $01, $ff, $ff, $17, $02, $02, $01, $ff, $f4, $04, $01, $34, $01
    db $01, $26, $0f, $05, $01, $36, $04, $01, $46, $0f, $0f, $01, $ff, $fe, $01, $7a
    db $0f, $01, $01, $f0, $ff, $29, $01, $2a, $06, $01, $fa, $ff, $1d, $06, $01, $18
    db $17, $01, $16, $1a, $01, $1e, $1f, $07, $01, $3a, $1f, $09

; LZSS-compressed: 61 bytes that expand to 360 (E-0016, E-0017)
Map4FAttrs0_Y1X1::
    db $68, $01, $01, $01, $ff, $ff, $05, $02, $02, $01, $fc, $ff, $09, $04, $04, $01
    db $18, $0e, $01, $36, $0f, $03, $04, $04, $01, $4e, $0f, $11, $01, $12, $04, $01
    db $18, $0f, $0b, $01, $12, $0f, $03, $01, $8c, $00, $01, $8e, $0f, $11, $01, $ff
    db $fc, $06, $01, $fa, $05, $01, $f0, $0f, $01, $01, $0e, $1f, $3d

Map4FAttrs2_Y1X1::
    db $68, $01, $01, $01, $ff, $ff, $05, $02, $02, $01, $fc, $ff, $09, $04, $04, $01
    db $18, $0e, $01, $36, $0f, $03, $04, $04, $01, $4e, $0f, $11, $01, $12, $04, $01
    db $18, $0f, $0b, $01, $12, $0f, $03, $01, $8c, $00, $01, $8e, $0f, $11, $01, $ff
    db $fc, $06, $01, $fa, $05, $01, $f0, $0f, $01, $01, $0e, $1f, $3d

; compressed tileset of map $50 (the first map record using it)
; LZSS-compressed: 1182 bytes that expand to 1536 (E-0016, E-0017)
Map50Tileset::
    INCBIN "dwm2-cobi-us.gbc", $138CDB, $49E

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map50Screens0::
    dfar Map50Screens0_Y0X0 ; entry 0

Map50Attrs0::
    dfar Map50Attrs0_Y0X0 ; entry 0

Map51Screens0::
    dfar Map51Screens0_Y0X0 ; entry 0

Map51Attrs0::
    dfar Map51Attrs0_Y0X0 ; entry 0

; LZSS-compressed: 195 bytes that expand to 360 (E-0016, E-0017)
Map50Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $139185, $C3

; LZSS-compressed: 44 bytes that expand to 360 (E-0016, E-0017)
Map50Attrs0_Y0X0::
    db $68, $01, $01, $00, $00, $02, $02, $02, $02, $01, $f2, $ff, $01, $01, $04, $0c
    db $01, $16, $02, $01, $02, $0a, $01, $2a, $0f, $4d, $01, $8a, $0f, $4d, $01, $d6
    db $0f, $31, $01, $fe, $f2, $01, $f0, $ff, $01, $01, $a0, $f8

; LZSS-compressed: 190 bytes that expand to 360 (E-0016, E-0017)
Map51Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $139274, $BE

; LZSS-compressed: 70 bytes that expand to 360 (E-0016, E-0017)
Map51Attrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $139332, $46

; compressed tileset of map $52 (the first map record using it)
; LZSS-compressed: 811 bytes that expand to 1536 (E-0016, E-0017)
Map52Tileset::
    INCBIN "dwm2-cobi-us.gbc", $139378, $32B

; 6 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map52Screens0::
    dfar Map52Screens0_Y0X0 ; entry 0
    dfar Map52Screens0_Y0X1 ; entry 1
    dfar Map52Screens0_Y0X2 ; entry 2
    dfar Map52Screens0_Y1X0 ; entry 3
    dfar Map52Screens0_Y0X0 ; entry 4
    dfar Map52Screens0_Y0X0 ; entry 5

Map52Attrs0::
    dfar Map52Attrs0_Y0X0 ; entry 0
    dfar Map52Attrs0_Y0X1 ; entry 1
    dfar Map52Attrs0_Y0X2 ; entry 2
    dfar Map52Attrs0_Y1X0 ; entry 3
    dfar Map52Attrs0_Y0X0 ; entry 4
    dfar Map52Attrs0_Y0X0 ; entry 5

; LZSS-compressed: 248 bytes that expand to 360 (E-0016, E-0017)
Map52Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1396C7, $F8

; LZSS-compressed: 257 bytes that expand to 360 (E-0016, E-0017)
Map52Screens0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $1397BF, $101

; LZSS-compressed: 232 bytes that expand to 360 (E-0016, E-0017)
Map52Screens0_Y0X2::
    INCBIN "dwm2-cobi-us.gbc", $1398C0, $E8

; LZSS-compressed: 155 bytes that expand to 360 (E-0016, E-0017)
Map52Screens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $1399A8, $9B

; LZSS-compressed: 121 bytes that expand to 360 (E-0016, E-0017)
Map52Attrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $139A43, $79

; LZSS-compressed: 104 bytes that expand to 360 (E-0016, E-0017)
Map52Attrs0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $139ABC, $68

; LZSS-compressed: 108 bytes that expand to 360 (E-0016, E-0017)
Map52Attrs0_Y0X2::
    INCBIN "dwm2-cobi-us.gbc", $139B24, $6C

; LZSS-compressed: 82 bytes that expand to 360 (E-0016, E-0017)
Map52Attrs0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $139B90, $52

; compressed tileset of map $53 (the first map record using it)
; LZSS-compressed: 1103 bytes that expand to 1760 (E-0016, E-0017)
Map53Tileset::
    INCBIN "dwm2-cobi-us.gbc", $139BE2, $44F

; 16 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map53Screens0::
    dfar Map53Screens0_Y0X0 ; entry 0
    dfar Map53Screens0_Y0X1 ; entry 1
    dfar Map53Screens0_Y0X2 ; entry 2
    dfar Map53Screens0_Y0X3 ; entry 3
    dfar Map53Screens0_Y1X0 ; entry 4
    dfar Map53Screens0_Y1X1 ; entry 5
    dfar Map53Screens0_Y1X2 ; entry 6
    dfar Map53Screens0_Y1X3 ; entry 7
    dfar Map53Screens0_Y2X0 ; entry 8
    dfar Map53Screens0_Y2X1 ; entry 9
    dfar Map53Screens0_Y2X2 ; entry 10
    dfar Map53Screens0_Y2X3 ; entry 11
    dfar Map53Screens0_Y3X0 ; entry 12
    dfar Map53Screens0_Y3X1 ; entry 13
    dfar Map53Screens0_Y3X2 ; entry 14
    dfar Map53Screens0_Y3X3 ; entry 15

Map53Attrs0::
    dfar Map53Attrs0_Y0X0 ; entry 0
    dfar Map53Attrs0_Y0X1 ; entry 1
    dfar Map53Attrs0_Y0X2 ; entry 2
    dfar Map53Attrs0_Y0X3 ; entry 3
    dfar Map53Attrs0_Y1X0 ; entry 4
    dfar Map53Attrs0_Y1X1 ; entry 5
    dfar Map53Attrs0_Y1X2 ; entry 6
    dfar Map53Attrs0_Y1X3 ; entry 7
    dfar Map53Attrs0_Y2X0 ; entry 8
    dfar Map53Attrs0_Y2X1 ; entry 9
    dfar Map53Attrs0_Y2X2 ; entry 10
    dfar Map53Attrs0_Y2X3 ; entry 11
    dfar Map53Attrs0_Y3X0 ; entry 12
    dfar Map53Attrs0_Y3X1 ; entry 13
    dfar Map53Attrs0_Y3X2 ; entry 14
    dfar Map53Attrs0_Y3X3 ; entry 15

; LZSS-compressed: 226 bytes that expand to 360 (E-0016, E-0017)
Map53Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $13A091, $E2

; LZSS-compressed: 90 bytes that expand to 360 (E-0016, E-0017)
Map53Screens0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $13A173, $5A

; LZSS-compressed: 239 bytes that expand to 360 (E-0016, E-0017)
Map53Screens0_Y0X2::
    INCBIN "dwm2-cobi-us.gbc", $13A1CD, $EF

; LZSS-compressed: 19 bytes that expand to 360 (E-0016, E-0017)
Map53Screens0_Y0X3::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $5f, $0f, $4d, $01, $bf, $0f, $4d, $01
    db $1f, $1f, $35

; LZSS-compressed: 198 bytes that expand to 360 (E-0016, E-0017)
Map53Screens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $13A2CF, $C6

; LZSS-compressed: 210 bytes that expand to 360 (E-0016, E-0017)
Map53Screens0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $13A395, $D2

; LZSS-compressed: 226 bytes that expand to 360 (E-0016, E-0017)
Map53Screens0_Y1X2::
    INCBIN "dwm2-cobi-us.gbc", $13A467, $E2

; LZSS-compressed: 174 bytes that expand to 360 (E-0016, E-0017)
Map53Screens0_Y1X3::
    INCBIN "dwm2-cobi-us.gbc", $13A549, $AE

; LZSS-compressed: 214 bytes that expand to 360 (E-0016, E-0017)
Map53Screens0_Y2X0::
    INCBIN "dwm2-cobi-us.gbc", $13A5F7, $D6

; LZSS-compressed: 254 bytes that expand to 360 (E-0016, E-0017)
Map53Screens0_Y2X1::
    INCBIN "dwm2-cobi-us.gbc", $13A6CD, $FE

; LZSS-compressed: 224 bytes that expand to 360 (E-0016, E-0017)
Map53Screens0_Y2X2::
    INCBIN "dwm2-cobi-us.gbc", $13A7CB, $E0

; LZSS-compressed: 151 bytes that expand to 360 (E-0016, E-0017)
Map53Screens0_Y2X3::
    INCBIN "dwm2-cobi-us.gbc", $13A8AB, $97

; LZSS-compressed: 233 bytes that expand to 360 (E-0016, E-0017)
Map53Screens0_Y3X0::
    INCBIN "dwm2-cobi-us.gbc", $13A942, $E9

; LZSS-compressed: 175 bytes that expand to 360 (E-0016, E-0017)
Map53Screens0_Y3X1::
    INCBIN "dwm2-cobi-us.gbc", $13AA2B, $AF

; LZSS-compressed: 215 bytes that expand to 360 (E-0016, E-0017)
Map53Screens0_Y3X2::
    INCBIN "dwm2-cobi-us.gbc", $13AADA, $D7

; LZSS-compressed: 207 bytes that expand to 360 (E-0016, E-0017)
Map53Screens0_Y3X3::
    INCBIN "dwm2-cobi-us.gbc", $13ABB1, $CF

; LZSS-compressed: 86 bytes that expand to 360 (E-0016, E-0017)
Map53Attrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $13AC80, $56

; LZSS-compressed: 34 bytes that expand to 360 (E-0016, E-0017)
Map53Attrs0_Y0X1::
    db $68, $01, $01, $01, $ff, $ff, $3d, $05, $01, $50, $0f, $14, $02, $01, $78, $0f
    db $14, $03, $01, $a0, $0f, $4d, $01, $b8, $0f, $04, $01, $50, $0f, $15, $01, $a0
    db $ff, $15

; LZSS-compressed: 82 bytes that expand to 360 (E-0016, E-0017)
Map53Attrs0_Y0X2::
    INCBIN "dwm2-cobi-us.gbc", $13ACF8, $52

; LZSS-compressed: 19 bytes that expand to 360 (E-0016, E-0017)
Map53Attrs0_Y0X3::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $5f, $0f, $4d, $01, $bf, $0f, $4d, $01
    db $1f, $1f, $35

; LZSS-compressed: 83 bytes that expand to 360 (E-0016, E-0017)
Map53Attrs0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $13AD5D, $53

; LZSS-compressed: 86 bytes that expand to 360 (E-0016, E-0017)
Map53Attrs0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $13ADB0, $56

; LZSS-compressed: 97 bytes that expand to 360 (E-0016, E-0017)
Map53Attrs0_Y1X2::
    INCBIN "dwm2-cobi-us.gbc", $13AE06, $61

; LZSS-compressed: 65 bytes that expand to 360 (E-0016, E-0017)
Map53Attrs0_Y1X3::
    INCBIN "dwm2-cobi-us.gbc", $13AE67, $41

; LZSS-compressed: 89 bytes that expand to 360 (E-0016, E-0017)
Map53Attrs0_Y2X0::
    INCBIN "dwm2-cobi-us.gbc", $13AEA8, $59

; LZSS-compressed: 98 bytes that expand to 360 (E-0016, E-0017)
Map53Attrs0_Y2X1::
    INCBIN "dwm2-cobi-us.gbc", $13AF01, $62

; LZSS-compressed: 96 bytes that expand to 360 (E-0016, E-0017)
Map53Attrs0_Y2X2::
    INCBIN "dwm2-cobi-us.gbc", $13AF63, $60

; LZSS-compressed: 55 bytes that expand to 360 (E-0016, E-0017)
Map53Attrs0_Y2X3::
    db $68, $01, $01, $01, $ff, $f0, $05, $05, $03, $01, $06, $01, $05, $05, $01, $fa
    db $ff, $3d, $01, $0c, $06, $01, $54, $0f, $09, $02, $02, $01, $72, $0f, $0d, $01
    db $04, $0e, $01, $a4, $0f, $01, $01, $a2, $06, $01, $c2, $0f, $0d, $01, $02, $04
    db $01, $ea, $0f, $4d, $01, $0e, $16

; LZSS-compressed: 84 bytes that expand to 360 (E-0016, E-0017)
Map53Attrs0_Y3X0::
    INCBIN "dwm2-cobi-us.gbc", $13AFFA, $54

; LZSS-compressed: 66 bytes that expand to 360 (E-0016, E-0017)
Map53Attrs0_Y3X1::
    INCBIN "dwm2-cobi-us.gbc", $13B04E, $42

; LZSS-compressed: 65 bytes that expand to 360 (E-0016, E-0017)
Map53Attrs0_Y3X2::
    INCBIN "dwm2-cobi-us.gbc", $13B090, $41

; LZSS-compressed: 79 bytes that expand to 360 (E-0016, E-0017)
Map53Attrs0_Y3X3::
    INCBIN "dwm2-cobi-us.gbc", $13B0D1, $4F

; 3 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map56Screens0::
    dfar Map56Screens0_Y0X0 ; entry 0
    dfar Map56Screens0_Y1X0 ; entry 1
    dfar Map56Screens0_Y2X0 ; entry 2

Map56Attrs0::
    dfar Map56Attrs0_Y0X0 ; entry 0
    dfar Map56Attrs0_Y1X0 ; entry 1
    dfar Map56Attrs0_Y2X0 ; entry 2

; LZSS-compressed: 154 bytes that expand to 360 (E-0016, E-0017)
Map56Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $13B132, $9A

; LZSS-compressed: 219 bytes that expand to 360 (E-0016, E-0017)
Map56Screens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $13B1CC, $DB

; LZSS-compressed: 247 bytes that expand to 360 (E-0016, E-0017)
Map56Screens0_Y2X0::
    INCBIN "dwm2-cobi-us.gbc", $13B2A7, $F7

; LZSS-compressed: 63 bytes that expand to 360 (E-0016, E-0017)
Map56Attrs0_Y0X0::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $1e, $0f, $0b, $05, $01, $7e, $05, $01
    db $74, $0f, $09, $01, $7e, $00, $02, $01, $a8, $01, $01, $84, $06, $01, $a4, $0f
    db $03, $02, $02, $03, $01, $d0, $01, $01, $ac, $00, $01, $c6, $0f, $09, $01, $d0
    db $02, $01, $d0, $00, $01, $ec, $0f, $33, $01, $7e, $00, $01, $36, $1f, $0b

; LZSS-compressed: 85 bytes that expand to 360 (E-0016, E-0017)
Map56Attrs0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $13B3DD, $55

Map56Attrs0_Y2X0::
    INCBIN "dwm2-cobi-us.gbc", $13B432, $55

; compressed tileset of map $57 (the first map record using it)
; LZSS-compressed: 1345 bytes that expand to 1520 (E-0016, E-0017)
Map57Tileset::
    INCBIN "dwm2-cobi-us.gbc", $13B487, $541

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map57Palettes::
    dw $1415, $7fff, $3c1f, $0000 ; entry 0
    dw $184c, $7fff, $6980, $0000 ; entry 1
    dw $184c, $0217, $1116, $0000 ; entry 2
    dw $0854, $029e, $1116, $0000 ; entry 3
    dw $001b, $2bff, $023f, $0000 ; entry 4
    dw $0186, $3f3d, $02af, $0084 ; entry 5
    dw $218c, $4f18, $3a52, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 3 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map57Screens0::
    dfar Map57Screens0_Y0X0 ; entry 0
    dfar Map57Screens0_Y0X1 ; entry 1
    dfar Map57Screens0_Y0X2 ; entry 2

Map57Attrs0::
    dfar Map57Attrs0_Y0X0 ; entry 0
    dfar Map57Attrs0_Y0X1 ; entry 1
    dfar Map57Attrs0_Y0X2 ; entry 2

; LZSS-compressed: 292 bytes that expand to 360 (E-0016, E-0017)
Map57Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $13BA1A, $124

; LZSS-compressed: 312 bytes that expand to 360 (E-0016, E-0017)
Map57Screens0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $13BB3E, $138

; LZSS-compressed: 304 bytes that expand to 360 (E-0016, E-0017)
Map57Screens0_Y0X2::
    INCBIN "dwm2-cobi-us.gbc", $13BC76, $130

; LZSS-compressed: 108 bytes that expand to 360 (E-0016, E-0017)
Map57Attrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $13BDA6, $6C

; LZSS-compressed: 117 bytes that expand to 360 (E-0016, E-0017)
Map57Attrs0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $13BE12, $75

; LZSS-compressed: 103 bytes that expand to 360 (E-0016, E-0017)
Map57Attrs0_Y0X2::
    INCBIN "dwm2-cobi-us.gbc", $13BE87, $67
    ds $112, $00
