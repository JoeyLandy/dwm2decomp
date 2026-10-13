SECTION "Bank 54", ROMX[$4000], BANK[$54]
    db $54

; compressed tileset of map $81 (the first map record using it)
; LZSS-compressed: 811 bytes that expand to 1280 (E-0016, E-0017)
Map81Tileset::
    INCBIN "dwm2-cobi-us.gbc", $150001, $77

; LZSS-compressed: 1057 bytes that expand to 1239 (E-0016, E-0017)
Gfx_54_4078::
    INCBIN "dwm2-cobi-us.gbc", $150078, $2B4

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map81Palettes::
    dw $01d3, $7fff, $029a, $0000 ; entry 0
    dw $300c, $35b8, $4812, $0000 ; entry 1
    dw $218c, $4f18, $3a52, $0000 ; entry 2
    dw $012e, $02dc, $01d3, $0000 ; entry 3
    dw $001b, $2bff, $023f, $0000 ; entry 4
    dw $218c, $4f18, $3a52, $0000 ; entry 5
    dw $218c, $4f18, $3a52, $0000 ; entry 6
    dw $2008, $02dc, $4810, $0000 ; entry 7

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map81Screens0::
    dfar Map81Screens0_Y0X0 ; entry 0

Map81Attrs0::
    dfar Map81Attrs0_Y0X0 ; entry 0

; LZSS-compressed: 186 bytes that expand to 360 (E-0016, E-0017)
Map81Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $150372, $BA

; LZSS-compressed: 55 bytes that expand to 360 (E-0016, E-0017)
Map81Attrs0_Y0X0::
    db $68, $01, $02, $02, $ff, $ff, $19, $01, $02, $2c, $07, $02, $24, $0f, $07, $02
    db $2c, $08, $02, $34, $04, $02, $52, $0f, $05, $03, $02, $7e, $03, $02, $72, $0f
    db $0b, $02, $7e, $04, $02, $82, $02, $02, $9e, $0f, $2f, $02, $7c, $0f, $13, $02
    db $2a, $0f, $15, $02, $41, $1f, $13

; 9 screen far pointers, row by row (E-0142)
Map82Screens0::
    dfar Map82Screens0_Y0X0 ; entry 0
    dfar Map82Screens0_Y0X1 ; entry 1
    dfar Map82Screens0_Y0X2 ; entry 2
    dfar Map82Screens0_Y1X0 ; entry 3
    dfar Map82Screens0_Y1X1 ; entry 4
    dfar Map82Screens0_Y1X2 ; entry 5
    dfar Map82Screens0_Y2X0 ; entry 6
    dfar Map82Screens0_Y2X1 ; entry 7
    dfar Map82Screens0_Y2X2 ; entry 8

Map82Attrs0::
    dfar Map82Attrs0_Y0X0 ; entry 0
    dfar Map82Attrs0_Y0X1 ; entry 1
    dfar Map82Attrs0_Y0X2 ; entry 2
    dfar Map82Attrs0_Y1X0 ; entry 3
    dfar Map82Attrs0_Y1X1 ; entry 4
    dfar Map82Attrs0_Y1X2 ; entry 5
    dfar Map82Attrs0_Y2X0 ; entry 6
    dfar Map82Attrs0_Y2X1 ; entry 7
    dfar Map82Attrs0_Y2X2 ; entry 8

; LZSS-compressed: 203 bytes that expand to 360 (E-0016, E-0017)
Map82Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $150499, $CB

; LZSS-compressed: 273 bytes that expand to 360 (E-0016, E-0017)
Map82Screens0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $150564, $111

; LZSS-compressed: 214 bytes that expand to 360 (E-0016, E-0017)
Map82Screens0_Y0X2::
    INCBIN "dwm2-cobi-us.gbc", $150675, $D6

; LZSS-compressed: 186 bytes that expand to 360 (E-0016, E-0017)
Map82Screens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $15074B, $BA

; LZSS-compressed: 223 bytes that expand to 360 (E-0016, E-0017)
Map82Screens0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $150805, $DF

; LZSS-compressed: 230 bytes that expand to 360 (E-0016, E-0017)
Map82Screens0_Y1X2::
    INCBIN "dwm2-cobi-us.gbc", $1508E4, $E6

; LZSS-compressed: 174 bytes that expand to 360 (E-0016, E-0017)
Map82Screens0_Y2X0::
    INCBIN "dwm2-cobi-us.gbc", $1509CA, $AE

; LZSS-compressed: 194 bytes that expand to 360 (E-0016, E-0017)
Map82Screens0_Y2X1::
    INCBIN "dwm2-cobi-us.gbc", $150A78, $C2

; LZSS-compressed: 247 bytes that expand to 360 (E-0016, E-0017)
Map82Screens0_Y2X2::
    INCBIN "dwm2-cobi-us.gbc", $150B3A, $F7

; LZSS-compressed: 76 bytes that expand to 360 (E-0016, E-0017)
Map82Attrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $150C31, $4C

; LZSS-compressed: 81 bytes that expand to 360 (E-0016, E-0017)
Map82Attrs0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $150C7D, $51

; LZSS-compressed: 57 bytes that expand to 360 (E-0016, E-0017)
Map82Attrs0_Y0X2::
    db $68, $01, $02, $01, $02, $00, $0b, $02, $fc, $ff, $15, $02, $0e, $00, $02, $28
    db $0f, $01, $03, $02, $50, $09, $02, $4a, $0f, $0b, $02, $00, $04, $02, $5a, $02
    db $02, $76, $0f, $03, $02, $00, $0a, $02, $9a, $0f, $07, $02, $fe, $fa, $02, $c2
    db $0f, $33, $02, $58, $06, $02, $12, $1f, $2f

; LZSS-compressed: 73 bytes that expand to 360 (E-0016, E-0017)
Map82Attrs0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $150D07, $49

; LZSS-compressed: 68 bytes that expand to 360 (E-0016, E-0017)
Map82Attrs0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $150D50, $44

; LZSS-compressed: 85 bytes that expand to 360 (E-0016, E-0017)
Map82Attrs0_Y1X2::
    INCBIN "dwm2-cobi-us.gbc", $150D94, $55

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
Map82Attrs0_Y2X0::
    INCBIN "dwm2-cobi-us.gbc", $150DE9, $47

; LZSS-compressed: 70 bytes that expand to 360 (E-0016, E-0017)
Map82Attrs0_Y2X1::
    INCBIN "dwm2-cobi-us.gbc", $150E30, $46

; LZSS-compressed: 81 bytes that expand to 360 (E-0016, E-0017)
Map82Attrs0_Y2X2::
    INCBIN "dwm2-cobi-us.gbc", $150E76, $51

; 9 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map83Screens0::
    dfar Map83Screens0_Y0X0 ; entry 0
    dfar Map83Screens0_Y0X1 ; entry 1
    dfar Map83Screens0_Y0X2 ; entry 2
    dfar Map83Screens0_Y1X0 ; entry 3
    dfar Map83Screens0_Y1X1 ; entry 4
    dfar Map83Screens0_Y1X2 ; entry 5
    dfar Map83Screens0_Y2X0 ; entry 6
    dfar Map83Screens0_Y2X1 ; entry 7
    dfar Map83Screens0_Y2X2 ; entry 8

Map83Attrs0::
    dfar Map83Attrs0_Y0X0 ; entry 0
    dfar Map83Attrs0_Y0X1 ; entry 1
    dfar Map83Attrs0_Y0X2 ; entry 2
    dfar Map83Attrs0_Y1X0 ; entry 3
    dfar Map83Attrs0_Y1X1 ; entry 4
    dfar Map83Attrs0_Y1X2 ; entry 5
    dfar Map83Attrs0_Y2X0 ; entry 6
    dfar Map83Attrs0_Y2X1 ; entry 7
    dfar Map83Attrs0_Y2X2 ; entry 8

; LZSS-compressed: 190 bytes that expand to 360 (E-0016, E-0017)
Map83Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $150EFD, $BE

; LZSS-compressed: 224 bytes that expand to 360 (E-0016, E-0017)
Map83Screens0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $150FBB, $E0

; LZSS-compressed: 193 bytes that expand to 360 (E-0016, E-0017)
Map83Screens0_Y0X2::
    INCBIN "dwm2-cobi-us.gbc", $15109B, $C1

; LZSS-compressed: 208 bytes that expand to 360 (E-0016, E-0017)
Map83Screens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $15115C, $D0

; LZSS-compressed: 233 bytes that expand to 360 (E-0016, E-0017)
Map83Screens0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $15122C, $E9

; LZSS-compressed: 144 bytes that expand to 360 (E-0016, E-0017)
Map83Screens0_Y1X2::
    INCBIN "dwm2-cobi-us.gbc", $151315, $90

; LZSS-compressed: 19 bytes that expand to 360 (E-0016, E-0017)
Map83Screens0_Y2X0::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $5f, $0f, $4d, $01, $bf, $0f, $4d, $01
    db $1f, $1f, $35

; LZSS-compressed: 195 bytes that expand to 360 (E-0016, E-0017)
Map83Screens0_Y2X1::
    INCBIN "dwm2-cobi-us.gbc", $1513B8, $C3

; LZSS-compressed: 87 bytes that expand to 360 (E-0016, E-0017)
Map83Screens0_Y2X2::
    INCBIN "dwm2-cobi-us.gbc", $15147B, $57

; LZSS-compressed: 76 bytes that expand to 360 (E-0016, E-0017)
Map83Attrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1514D2, $4C

Map83Attrs0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $15151E, $57

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
Map83Attrs0_Y0X2::
    INCBIN "dwm2-cobi-us.gbc", $151575, $47

; LZSS-compressed: 80 bytes that expand to 360 (E-0016, E-0017)
Map83Attrs0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $1515BC, $50

; LZSS-compressed: 90 bytes that expand to 360 (E-0016, E-0017)
Map83Attrs0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $15160C, $5A

; LZSS-compressed: 50 bytes that expand to 360 (E-0016, E-0017)
Map83Attrs0_Y1X2::
    db $68, $01, $02, $00, $00, $01, $02, $02, $01, $02, $f4, $ff, $35, $02, $02, $00
    db $03, $03, $02, $42, $0f, $39, $03, $03, $02, $90, $0f, $11, $02, $a2, $00, $02
    db $b8, $0f, $15, $02, $04, $0c, $02, $f0, $0f, $01, $02, $02, $0f, $15, $02, $3f
    db $1f, $15

; LZSS-compressed: 19 bytes that expand to 360 (E-0016, E-0017)
Map83Attrs0_Y2X0::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $5f, $0f, $4d, $01, $bf, $0f, $4d, $01
    db $1f, $1f, $35

; LZSS-compressed: 76 bytes that expand to 360 (E-0016, E-0017)
Map83Attrs0_Y2X1::
    INCBIN "dwm2-cobi-us.gbc", $1516AB, $4C

; LZSS-compressed: 35 bytes that expand to 360 (E-0016, E-0017)
Map83Attrs0_Y2X2::
    db $68, $01, $02, $02, $a0, $ff, $4d, $02, $40, $0f, $2d, $01, $02, $a0, $0d, $02
    db $9e, $0f, $2b, $03, $02, $f0, $0b, $02, $ec, $0f, $05, $02, $a0, $0f, $15, $02
    db $3f, $1f, $15

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map84Screens0::
    dfar Map84Screens0_Y0X0 ; entry 0

Map84Attrs0::
    dfar Map84Attrs0_Y0X0 ; entry 0

; LZSS-compressed: 234 bytes that expand to 360 (E-0016, E-0017)
Map84Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $151720, $EA

; LZSS-compressed: 76 bytes that expand to 360 (E-0016, E-0017)
Map84Attrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $15180A, $4C

; compressed tileset of map $85 (the first map record using it)
; LZSS-compressed: 1231 bytes that expand to 1792 (E-0016, E-0017)
Map85Tileset::
    INCBIN "dwm2-cobi-us.gbc", $151856, $4CF

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map85Palettes::
    dw $7da0, $7fff, $01d3, $0063 ; entry 0
    dw $48ec, $6bff, $4a6f, $0000 ; entry 1
    dw $28cb, $4e11, $316f, $0c66 ; entry 2
    dw $50c6, $7e94, $7d4a, $0084 ; entry 3
    dw $0014, $03fe, $01bf, $0000 ; entry 4
    dw $218c, $4f18, $3a52, $0000 ; entry 5
    dw $28cb, $4e11, $316f, $0c66 ; entry 6
    dw $350e, $773c, $4616, $0c69 ; entry 7

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map85Screens0::
    dfar Map85Screens0_Y0X0 ; entry 0
    dfar Map85Screens0_Y0X1 ; entry 1
    dfar Map85Screens0_Y1X0 ; entry 2
    dfar Map85Screens0_Y1X1 ; entry 3

Map85Attrs0::
    dfar Map85Attrs0_Y0X0 ; entry 0
    dfar Map85Attrs0_Y0X1 ; entry 1
    dfar Map85Attrs0_Y1X0 ; entry 2
    dfar Map85Attrs0_Y1X1 ; entry 3

; LZSS-compressed: 232 bytes that expand to 360 (E-0016, E-0017)
Map85Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $151D7D, $E8

; LZSS-compressed: 228 bytes that expand to 360 (E-0016, E-0017)
Map85Screens0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $151E65, $E4

; LZSS-compressed: 243 bytes that expand to 360 (E-0016, E-0017)
Map85Screens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $151F49, $F3

; LZSS-compressed: 272 bytes that expand to 360 (E-0016, E-0017)
Map85Screens0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $15203C, $110

; LZSS-compressed: 43 bytes that expand to 360 (E-0016, E-0017)
Map85Attrs0_Y0X0::
    db $68, $01, $00, $02, $00, $00, $0f, $1c, $01, $01, $00, $2e, $02, $00, $24, $0f
    db $31, $01, $00, $7c, $07, $00, $74, $0f, $07, $00, $7c, $08, $00, $84, $04, $00
    db $a2, $0f, $4d, $00, $da, $0f, $19, $00, $7a, $0f, $13

; LZSS-compressed: 59 bytes that expand to 360 (E-0016, E-0017)
Map85Attrs0_Y0X1::
    db $68, $01, $00, $02, $00, $00, $0f, $44, $01, $01, $04, $04, $01, $01, $00, $4a
    db $0f, $0d, $01, $00, $7e, $05, $00, $74, $0f, $09, $00, $7e, $06, $00, $84, $06
    db $00, $a4, $0f, $01, $00, $52, $04, $00, $ce, $06, $00, $ca, $0f, $0f, $00, $4a
    db $0c, $00, $fc, $0f, $25, $00, $c0, $0e, $00, $46, $1a

; LZSS-compressed: 94 bytes that expand to 360 (E-0016, E-0017)
Map85Attrs0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $1521B2, $5E

; LZSS-compressed: 83 bytes that expand to 360 (E-0016, E-0017)
Map85Attrs0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $152210, $53

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map86Screens0::
    dfar Map86Screens0_Y0X0 ; entry 0
    dfar Map86Screens0_Y0X1 ; entry 1
    dfar Map86Screens0_Y1X0 ; entry 2
    dfar Map86Screens0_Y1X1 ; entry 3

Map86Attrs0::
    dfar Map86Attrs0_Y0X0 ; entry 0
    dfar Map86Attrs0_Y0X1 ; entry 1
    dfar Map86Attrs0_Y1X0 ; entry 2
    dfar Map86Attrs0_Y1X1 ; entry 3

; LZSS-compressed: 249 bytes that expand to 360 (E-0016, E-0017)
Map86Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $15227B, $F9

; LZSS-compressed: 248 bytes that expand to 360 (E-0016, E-0017)
Map86Screens0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $152374, $F8

; LZSS-compressed: 224 bytes that expand to 360 (E-0016, E-0017)
Map86Screens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $15246C, $E0

; LZSS-compressed: 216 bytes that expand to 360 (E-0016, E-0017)
Map86Screens0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $15254C, $D8

; LZSS-compressed: 72 bytes that expand to 360 (E-0016, E-0017)
Map86Attrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $152624, $48

; LZSS-compressed: 77 bytes that expand to 360 (E-0016, E-0017)
Map86Attrs0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $15266C, $4D

; LZSS-compressed: 90 bytes that expand to 360 (E-0016, E-0017)
Map86Attrs0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $1526B9, $5A

; LZSS-compressed: 96 bytes that expand to 360 (E-0016, E-0017)
Map86Attrs0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $152713, $60

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map87Screens0::
    dfar Map87Screens0_Y0X0 ; entry 0
    dfar Map87Screens0_Y0X1 ; entry 1
    dfar Map87Screens0_Y1X0 ; entry 2
    dfar Map87Screens0_Y1X1 ; entry 3

Map87Attrs0::
    dfar Map87Attrs0_Y0X0 ; entry 0
    dfar Map87Attrs0_Y0X1 ; entry 1
    dfar Map87Attrs0_Y1X0 ; entry 2
    dfar Map87Attrs0_Y1X1 ; entry 3

; LZSS-compressed: 195 bytes that expand to 360 (E-0016, E-0017)
Map87Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $15278B, $C3

; LZSS-compressed: 250 bytes that expand to 360 (E-0016, E-0017)
Map87Screens0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $15284E, $FA

; LZSS-compressed: 210 bytes that expand to 360 (E-0016, E-0017)
Map87Screens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $152948, $D2

; LZSS-compressed: 203 bytes that expand to 360 (E-0016, E-0017)
Map87Screens0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $152A1A, $CB

; LZSS-compressed: 104 bytes that expand to 360 (E-0016, E-0017)
Map87Attrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $152AE5, $68

; LZSS-compressed: 100 bytes that expand to 360 (E-0016, E-0017)
Map87Attrs0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $152B4D, $64

; LZSS-compressed: 101 bytes that expand to 360 (E-0016, E-0017)
Map87Attrs0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $152BB1, $65

; LZSS-compressed: 89 bytes that expand to 360 (E-0016, E-0017)
Map87Attrs0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $152C16, $59

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map88Screens0::
    dfar Map88Screens0_Y0X0 ; entry 0
    dfar Map88Screens0_Y0X1 ; entry 1
    dfar Map88Screens0_Y1X0 ; entry 2
    dfar Map88Screens0_Y1X1 ; entry 3

Map88Attrs0::
    dfar Map88Attrs0_Y0X0 ; entry 0
    dfar Map88Attrs0_Y0X1 ; entry 1
    dfar Map88Attrs0_Y1X0 ; entry 2
    dfar Map88Attrs0_Y1X1 ; entry 3

; LZSS-compressed: 167 bytes that expand to 360 (E-0016, E-0017)
Map88Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $152C87, $A7

; LZSS-compressed: 203 bytes that expand to 360 (E-0016, E-0017)
Map88Screens0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $152D2E, $CB

; LZSS-compressed: 155 bytes that expand to 360 (E-0016, E-0017)
Map88Screens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $152DF9, $9B

; LZSS-compressed: 198 bytes that expand to 360 (E-0016, E-0017)
Map88Screens0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $152E94, $C6

; LZSS-compressed: 91 bytes that expand to 360 (E-0016, E-0017)
Map88Attrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $152F5A, $5B

; LZSS-compressed: 78 bytes that expand to 360 (E-0016, E-0017)
Map88Attrs0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $152FB5, $4E

; LZSS-compressed: 80 bytes that expand to 360 (E-0016, E-0017)
Map88Attrs0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $153003, $50

; LZSS-compressed: 98 bytes that expand to 360 (E-0016, E-0017)
Map88Attrs0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $153053, $62

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map8AScreens0::
    dfar Map8AScreens0_Y0X0 ; entry 0

Map8AAttrs0::
    dfar Map8AAttrs0_Y0X0 ; entry 0

; LZSS-compressed: 315 bytes that expand to 360 (E-0016, E-0017)
Map8AScreens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1530BB, $13B

; LZSS-compressed: 84 bytes that expand to 360 (E-0016, E-0017)
Map8AAttrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1531F6, $54

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map8BPalettes::
    dw $192c, $7fff, $45f2, $0000 ; entry 0
    dw $4ca9, $5b7f, $4d8c, $0000 ; entry 1
    dw $240f, $7fff, $45f2, $0000 ; entry 2
    dw $2940, $45f2, $4d8c, $0000 ; entry 3
    dw $0000, $0000, $0000, $0000 ; entry 4
    dw $0000, $0000, $0000, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; compressed tileset of map $8D (the first map record using it)
; LZSS-compressed: 994 bytes that expand to 1216 (E-0016, E-0017)
Map8DTileset::
    INCBIN "dwm2-cobi-us.gbc", $15328A, $3E2

Map8DPalettes::
    dw $192c, $7fff, $45f2, $0000 ; entry 0
    dw $4ca9, $5b7f, $4d8c, $0000 ; entry 1
    dw $240f, $7fff, $45f2, $0000 ; entry 2
    dw $2940, $45f2, $4d8c, $0000 ; entry 3
    dw $18c6, $03ff, $45f2, $0000 ; entry 4
    dw $18c6, $7fff, $45f2, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map8DScreens0::
    dfar Map8DScreens0_Y0X0 ; entry 0

Map8DAttrs0::
    dfar Map8DAttrs0_Y0X0 ; entry 0

Map8DScreens1::
    dfar Map8DScreens1_Y0X0 ; entry 0

Map8DAttrs1::
    dfar Map8DAttrs1_Y0X0 ; entry 0

; LZSS-compressed: 282 bytes that expand to 360 (E-0016, E-0017)
Map8DScreens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1536B8, $11A

; LZSS-compressed: 272 bytes that expand to 360 (E-0016, E-0017)
Map8DScreens1_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1537D2, $110

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
Map8DAttrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1538E2, $47

Map8DAttrs1_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $153929, $47

; compressed tileset of map $91 (the first map record using it)
; LZSS-compressed: 1000 bytes that expand to 1280 (E-0016, E-0017)
Map91Tileset::
    INCBIN "dwm2-cobi-us.gbc", $153970, $3E8

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map91Palettes::
    dw $240f, $7fff, $45f2, $0000 ; entry 0
    dw $4ca9, $5b7f, $4d8c, $0000 ; entry 1
    dw $240f, $2bff, $023f, $0000 ; entry 2
    dw $2940, $45f2, $4d8c, $0000 ; entry 3
    dw $240f, $023f, $18c6, $0000 ; entry 4
    dw $001b, $2bff, $023f, $0000 ; entry 5
    dw $2940, $2bff, $023f, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map91Screens0::
    dfar Map91Screens0_Y0X0 ; entry 0

Map91Attrs0::
    dfar Map91Attrs0_Y0X0 ; entry 0

; LZSS-compressed: 297 bytes that expand to 360 (E-0016, E-0017)
Map91Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $153D9E, $129

; LZSS-compressed: 111 bytes that expand to 360 (E-0016, E-0017)
Map91Attrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $153EC7, $6F
    ds $ca, $00
