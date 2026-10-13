SECTION "Bank 53", ROMX[$4000], BANK[$53]
    db $53

; compressed tileset of map $7B (the first map record using it)
; LZSS-compressed: 717 bytes that expand to 1536 (E-0016, E-0017)
Map7BTileset::
    INCBIN "dwm2-cobi-us.gbc", $14C001, $2CD

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map7BPalettes::
    dw $7d86, $7fff, $7fe1, $0000 ; entry 0
    dw $0189, $5bbf, $32d6, $00c8 ; entry 1
    dw $184c, $0217, $1116, $0000 ; entry 2
    dw $218c, $4f18, $3a52, $0000 ; entry 3
    dw $218c, $4f18, $3a52, $0000 ; entry 4
    dw $218c, $4f18, $3a52, $0000 ; entry 5
    dw $218c, $4f18, $3a52, $0000 ; entry 6
    dw $218c, $4f18, $3a52, $0000 ; entry 7

; 3 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map7BScreens0::
    dfar Map7BScreens0_Y0X0 ; entry 0
    dfar Map7BScreens0_Y1X0 ; entry 1
    dfar Map7BScreens0_Y2X0 ; entry 2

Map7BAttrs0::
    dfar Map7BAttrs0_Y0X0 ; entry 0
    dfar Map7BAttrs0_Y1X0 ; entry 1
    dfar Map7BAttrs0_Y2X0 ; entry 2

; LZSS-compressed: 198 bytes that expand to 360 (E-0016, E-0017)
Map7BScreens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $14C320, $C6

; LZSS-compressed: 117 bytes that expand to 360 (E-0016, E-0017)
Map7BScreens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $14C3E6, $75

; LZSS-compressed: 193 bytes that expand to 360 (E-0016, E-0017)
Map7BScreens0_Y2X0::
    INCBIN "dwm2-cobi-us.gbc", $14C45B, $C1

; LZSS-compressed: 59 bytes that expand to 360 (E-0016, E-0017)
Map7BAttrs0_Y0X0::
    db $68, $01, $03, $03, $ff, $f2, $02, $03, $06, $03, $03, $fa, $ff, $0b, $03, $06
    db $04, $03, $0a, $08, $03, $2c, $0f, $05, $01, $01, $01, $01, $03, $48, $0f, $0f
    db $03, $58, $00, $03, $58, $02, $03, $74, $0f, $4d, $03, $84, $0a, $03, $56, $0f
    db $13, $03, $8e, $04, $03, $0c, $0c, $03, $20, $1f, $21

; LZSS-compressed: 30 bytes that expand to 360 (E-0016, E-0017)
Map7BAttrs0_Y1X0::
    db $68, $01, $03, $03, $ff, $f2, $02, $02, $01, $01, $01, $01, $02, $02, $03, $fa
    db $ff, $4d, $03, $5a, $0f, $4d, $03, $ba, $0f, $4d, $03, $06, $1f, $27

; LZSS-compressed: 58 bytes that expand to 360 (E-0016, E-0017)
Map7BAttrs0_Y2X0::
    db $68, $01, $03, $03, $ff, $f2, $02, $02, $01, $01, $01, $01, $02, $02, $03, $fa
    db $ff, $0b, $02, $02, $03, $06, $04, $03, $0c, $06, $03, $2c, $0f, $2b, $03, $08
    db $00, $03, $08, $0a, $03, $7c, $0f, $4d, $03, $28, $0f, $19, $03, $2a, $02, $03
    db $10, $1a, $03, $1c, $1f, $03, $03, $45, $1f, $0f

; compressed tileset of map $7C (the first map record using it)
; LZSS-compressed: 1515 bytes that expand to 1776 (E-0016, E-0017)
Map7CTileset::
    INCBIN "dwm2-cobi-us.gbc", $14C5AF, $5EB

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map7CPalettes::
    dw $7da0, $7fff, $7fe0, $0000 ; entry 0
    dw $00ed, $7fff, $11d4, $0000 ; entry 1
    dw $00ed, $22ba, $11d4, $0000 ; entry 2
    dw $01c4, $3f7f, $0348, $0000 ; entry 3
    dw $00ed, $3f7f, $01da, $0000 ; entry 4
    dw $001b, $2bff, $023f, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map7CScreens0::
    dfar Map7CScreens0_Y0X0 ; entry 0
    dfar Map7CScreens0_Y0X1 ; entry 1
    dfar Map7CScreens0_Y1X0 ; entry 2
    dfar Map7CScreens0_Y1X1 ; entry 3

Map7CAttrs0::
    dfar Map7CAttrs0_Y0X0 ; entry 0
    dfar Map7CAttrs0_Y0X1 ; entry 1
    dfar Map7CAttrs0_Y1X0 ; entry 2
    dfar Map7CAttrs0_Y1X1 ; entry 3

; LZSS-compressed: 332 bytes that expand to 360 (E-0016, E-0017)
Map7CScreens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $14CBF2, $14C

; LZSS-compressed: 311 bytes that expand to 360 (E-0016, E-0017)
Map7CScreens0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $14CD3E, $137

Map7CScreens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $14CE75, $14C

; LZSS-compressed: 300 bytes that expand to 360 (E-0016, E-0017)
Map7CScreens0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $14CFC1, $12C

; LZSS-compressed: 113 bytes that expand to 360 (E-0016, E-0017)
Map7CAttrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $14D0ED, $71

; LZSS-compressed: 76 bytes that expand to 360 (E-0016, E-0017)
Map7CAttrs0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $14D15E, $4C

; LZSS-compressed: 116 bytes that expand to 360 (E-0016, E-0017)
Map7CAttrs0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $14D1AA, $74

; LZSS-compressed: 75 bytes that expand to 360 (E-0016, E-0017)
Map7CAttrs0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $14D21E, $4B

; compressed tileset of map $7D (the first map record using it)
; LZSS-compressed: 1112 bytes that expand to 1248 (E-0016, E-0017)
Map7DTileset::
    INCBIN "dwm2-cobi-us.gbc", $14D269, $458

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map7DPalettes::
    dw $00ed, $7fff, $11d4, $0000 ; entry 0
    dw $004f, $3f7f, $11d4, $0000 ; entry 1
    dw $00ed, $22ba, $11d4, $0000 ; entry 2
    dw $2c8a, $3f7f, $11d4, $0000 ; entry 3
    dw $00ed, $3f7f, $01da, $0000 ; entry 4
    dw $001b, $2bff, $023f, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map7DScreens0::
    dfar Map7DScreens0_Y0X0 ; entry 0

Map7DAttrs0::
    dfar Map7DAttrs0_Y0X0 ; entry 0

; LZSS-compressed: 193 bytes that expand to 360 (E-0016, E-0017)
Map7DScreens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $14D707, $C1

; LZSS-compressed: 67 bytes that expand to 360 (E-0016, E-0017)
Map7DAttrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $14D7C8, $43

Map7EScreens0::
    dfar Map7EScreens0_Y0X0 ; entry 0

Map7EAttrs0::
    dfar Map7EAttrs0_Y0X0 ; entry 0

; LZSS-compressed: 178 bytes that expand to 360 (E-0016, E-0017)
Map7EScreens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $14D811, $B2

; LZSS-compressed: 60 bytes that expand to 360 (E-0016, E-0017)
Map7EAttrs0_Y0X0::
    db $68, $01, $00, $02, $00, $00, $02, $04, $04, $00, $00, $03, $00, $09, $07, $00
    db $07, $0b, $01, $01, $01, $01, $04, $00, $2e, $01, $01, $01, $00, $22, $0f, $09
    db $00, $2e, $02, $00, $2e, $02, $00, $4a, $0f, $09, $00, $79, $0f, $4d, $00, $92
    db $0f, $05, $03, $03, $00, $e0, $0f, $13, $00, $08, $1f, $3b

; compressed tileset of map $7F (the first map record using it)
; LZSS-compressed: 1001 bytes that expand to 1088 (E-0016, E-0017)
Map7FTileset::
    INCBIN "dwm2-cobi-us.gbc", $14D8FF, $3E9

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map7FPalettes::
    dw $7da0, $7fff, $7fe0, $0000 ; entry 0
    dw $00ed, $01c4, $001f, $0000 ; entry 1
    dw $00ed, $22ba, $11d4, $0000 ; entry 2
    dw $01c4, $3f7f, $0348, $0000 ; entry 3
    dw $00ed, $3f7f, $01da, $0000 ; entry 4
    dw $001b, $2bff, $023f, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map7FScreens0::
    dfar Map7FScreens0_Y0X0 ; entry 0
    dfar Map7FScreens0_Y1X0 ; entry 1

Map7FAttrs0::
    dfar Map7FAttrs0_Y0X0 ; entry 0
    dfar Map7FAttrs0_Y1X0 ; entry 1

; LZSS-compressed: 279 bytes that expand to 360 (E-0016, E-0017)
Map7FScreens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $14DD34, $117

; LZSS-compressed: 286 bytes that expand to 360 (E-0016, E-0017)
Map7FScreens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $14DE4B, $11E

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
Map7FAttrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $14DF69, $47

; LZSS-compressed: 57 bytes that expand to 360 (E-0016, E-0017)
Map7FAttrs0_Y1X0::
    db $68, $01, $00, $02, $02, $02, $01, $01, $02, $04, $00, $06, $03, $00, $02, $00
    db $00, $11, $01, $00, $03, $0f, $00, $00, $06, $04, $00, $06, $05, $00, $27, $0f
    db $04, $00, $11, $02, $00, $44, $0f, $0f, $00, $2a, $0f, $4d, $00, $8a, $0f, $4d
    db $00, $ea, $0e, $00, $9e, $06, $00, $42, $1e

; compressed tileset of map $80 (the first map record using it)
; LZSS-compressed: 1298 bytes that expand to 1536 (E-0016, E-0017)
Map80Tileset::
    INCBIN "dwm2-cobi-us.gbc", $14DFE9, $512

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map80Palettes::
    dw $7da0, $7fff, $7fe0, $0000 ; entry 0
    dw $48ec, $6bff, $4a6f, $0000 ; entry 1
    dw $00ed, $22ba, $11d4, $0000 ; entry 2
    dw $01c4, $3f7f, $0348, $0000 ; entry 3
    dw $7da0, $3f7f, $01da, $0000 ; entry 4
    dw $00ed, $7fff, $11d4, $0000 ; entry 5
    dw $012f, $3fbf, $01d5, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 3 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map80Screens0::
    dfar Map80Screens0_Y0X0 ; entry 0
    dfar Map80Screens0_Y0X1 ; entry 1
    dfar Map80Screens0_Y0X2 ; entry 2

Map80Attrs0::
    dfar Map80Attrs0_Y0X0 ; entry 0
    dfar Map80Attrs0_Y0X1 ; entry 1
    dfar Map80Attrs0_Y0X2 ; entry 2

; LZSS-compressed: 291 bytes that expand to 360 (E-0016, E-0017)
Map80Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $14E54D, $123

; LZSS-compressed: 150 bytes that expand to 360 (E-0016, E-0017)
Map80Screens0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $14E670, $96

; LZSS-compressed: 296 bytes that expand to 360 (E-0016, E-0017)
Map80Screens0_Y0X2::
    INCBIN "dwm2-cobi-us.gbc", $14E706, $128

; LZSS-compressed: 80 bytes that expand to 360 (E-0016, E-0017)
Map80Attrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $14E82E, $50

; LZSS-compressed: 69 bytes that expand to 360 (E-0016, E-0017)
Map80Attrs0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $14E87E, $45

; LZSS-compressed: 89 bytes that expand to 360 (E-0016, E-0017)
Map80Attrs0_Y0X2::
    INCBIN "dwm2-cobi-us.gbc", $14E8C3, $59

; compressed tileset of map $89 (the first map record using it)
; LZSS-compressed: 1552 bytes that expand to 1728 (E-0016, E-0017)
Map89Tileset::
    INCBIN "dwm2-cobi-us.gbc", $14E91C, $610

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map89Palettes::
    dw $7da0, $7fff, $7fe0, $0000 ; entry 0
    dw $48ec, $6bff, $4a6f, $0000 ; entry 1
    dw $00ed, $7fff, $11d4, $0000 ; entry 2
    dw $01c4, $3f7f, $0348, $0000 ; entry 3
    dw $48ec, $3f7f, $01da, $0000 ; entry 4
    dw $0000, $0000, $0000, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map89Screens0::
    dfar Map89Screens0_Y0X0 ; entry 0
    dfar Map89Screens0_Y0X0 ; entry 1
    dfar Map89Screens0_Y1X0 ; entry 2
    dfar Map89Screens0_Y1X1 ; entry 3

Map89Attrs0::
    dfar Map89Attrs0_Y0X0 ; entry 0
    dfar Map89Attrs0_Y0X0 ; entry 1
    dfar Map89Attrs0_Y1X0 ; entry 2
    dfar Map89Attrs0_Y1X1 ; entry 3

; LZSS-compressed: 275 bytes that expand to 360 (E-0016, E-0017)
Map89Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $14EF84, $113

; LZSS-compressed: 324 bytes that expand to 360 (E-0016, E-0017)
Map89Screens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $14F097, $144

; LZSS-compressed: 312 bytes that expand to 360 (E-0016, E-0017)
Map89Screens0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $14F1DB, $138

; LZSS-compressed: 63 bytes that expand to 360 (E-0016, E-0017)
Map89Attrs0_Y0X0::
    db $68, $01, $02, $02, $ff, $ff, $22, $01, $02, $35, $02, $02, $29, $0f, $00, $02
    db $3b, $08, $02, $48, $04, $02, $3b, $07, $02, $5b, $05, $02, $3b, $04, $02, $6e
    db $06, $02, $39, $05, $02, $7f, $09, $02, $8b, $0f, $42, $02, $92, $0a, $02, $ee
    db $0f, $13, $04, $04, $02, $16, $1f, $05, $02, $92, $0a, $02, $3c, $1f, $05

; LZSS-compressed: 73 bytes that expand to 360 (E-0016, E-0017)
Map89Attrs0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $14F352, $49

; LZSS-compressed: 98 bytes that expand to 360 (E-0016, E-0017)
Map89Attrs0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $14F39B, $62

; compressed tileset of map $8A (the first map record using it)
; LZSS-compressed: 910 bytes that expand to 1056 (E-0016, E-0017)
Map8ATileset::
    INCBIN "dwm2-cobi-us.gbc", $14F3FD, $38E

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map8APalettes::
    dw $100e, $7fff, $70ca, $0000 ; entry 0
    dw $18eb, $67ff, $01da, $0000 ; entry 1
    dw $28e8, $4f18, $0dd5, $0000 ; entry 2
    dw $3c6b, $3a52, $2510, $0000 ; entry 3
    dw $012f, $4a52, $01c7, $00a0 ; entry 4
    dw $00c2, $4a52, $01c7, $00a0 ; entry 5
    dw $218c, $4f18, $3a52, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 12 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map8BScreens0::
    dfar Map8BScreens0_Y0X0 ; entry 0
    dfar Map8BScreens0_Y0X0 ; entry 1
    dfar Map8BScreens0_Y0X0 ; entry 2
    dfar Map8BScreens0_Y1X0 ; entry 3
    dfar Map8BScreens0_Y1X1 ; entry 4
    dfar Map8BScreens0_Y1X2 ; entry 5
    dfar Map8BScreens0_Y0X0 ; entry 6
    dfar Map8BScreens0_Y2X1 ; entry 7
    dfar Map8BScreens0_Y0X0 ; entry 8
    dfar Map8BScreens0_Y0X0 ; entry 9
    dfar Map8BScreens0_Y3X1 ; entry 10
    dfar Map8BScreens0_Y0X0 ; entry 11

Map8BAttrs0::
    dfar Map8BAttrs0_Y0X0 ; entry 0
    dfar Map8BAttrs0_Y0X0 ; entry 1
    dfar Map8BAttrs0_Y0X0 ; entry 2
    dfar Map8BAttrs0_Y1X0 ; entry 3
    dfar Map8BAttrs0_Y1X1 ; entry 4
    dfar Map8BAttrs0_Y1X2 ; entry 5
    dfar Map8BAttrs0_Y0X0 ; entry 6
    dfar Map8BAttrs0_Y2X1 ; entry 7
    dfar Map8BAttrs0_Y0X0 ; entry 8
    dfar Map8BAttrs0_Y0X0 ; entry 9
    dfar Map8BAttrs0_Y3X1 ; entry 10
    dfar Map8BAttrs0_Y0X0 ; entry 11

; LZSS-compressed: 261 bytes that expand to 360 (E-0016, E-0017)
Map8BScreens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $14F813, $105

; LZSS-compressed: 240 bytes that expand to 360 (E-0016, E-0017)
Map8BScreens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $14F918, $F0

; LZSS-compressed: 200 bytes that expand to 360 (E-0016, E-0017)
Map8BScreens0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $14FA08, $C8

; LZSS-compressed: 197 bytes that expand to 360 (E-0016, E-0017)
Map8BScreens0_Y1X2::
    INCBIN "dwm2-cobi-us.gbc", $14FAD0, $C5

; LZSS-compressed: 291 bytes that expand to 360 (E-0016, E-0017)
Map8BScreens0_Y2X1::
    INCBIN "dwm2-cobi-us.gbc", $14FB95, $123

; LZSS-compressed: 303 bytes that expand to 360 (E-0016, E-0017)
Map8BScreens0_Y3X1::
    INCBIN "dwm2-cobi-us.gbc", $14FCB8, $12F

; LZSS-compressed: 61 bytes that expand to 360 (E-0016, E-0017)
Map8BAttrs0_Y0X0::
    db $68, $01, $02, $01, $02, $00, $0f, $18, $03, $02, $2c, $07, $02, $24, $0f, $07
    db $03, $03, $02, $f4, $f8, $02, $36, $02, $02, $52, $0f, $01, $02, $f0, $ff, $01
    db $02, $7a, $0f, $05, $02, $9e, $08, $02, $9e, $0f, $0b, $02, $52, $02, $02, $34
    db $04, $02, $ca, $0f, $07, $02, $94, $0f, $01, $02, $f8, $0f, $49

; LZSS-compressed: 59 bytes that expand to 360 (E-0016, E-0017)
Map8BAttrs0_Y1X0::
    db $68, $01, $02, $01, $02, $00, $0f, $18, $03, $02, $2c, $0b, $02, $28, $0f, $03
    db $03, $03, $02, $f0, $fe, $02, $52, $0f, $01, $02, $f4, $ff, $01, $02, $7a, $0f
    db $0f, $02, $38, $02, $02, $a2, $0f, $0f, $02, $74, $0f, $01, $02, $d8, $0f, $1b
    db $02, $78, $08, $02, $12, $1f, $0b, $02, $00, $0f, $11

; LZSS-compressed: 60 bytes that expand to 360 (E-0016, E-0017)
Map8BAttrs0_Y1X1::
    db $68, $01, $02, $01, $01, $02, $fc, $f6, $02, $fa, $f4, $02, $00, $0f, $01, $03
    db $03, $02, $16, $0f, $13, $02, $48, $0a, $02, $4a, $0f, $07, $02, $76, $04, $02
    db $6c, $0f, $0d, $03, $02, $a0, $03, $02, $94, $0f, $0d, $02, $ee, $ff, $05, $02
    db $cc, $0f, $4d, $02, $7c, $0a, $02, $74, $06, $02, $32, $1c

; LZSS-compressed: 63 bytes that expand to 360 (E-0016, E-0017)
Map8BAttrs0_Y1X2::
    db $68, $01, $02, $10, $02, $00, $01, $01, $02, $06, $09, $02, $00, $0f, $0b, $03
    db $03, $00, $00, $03, $03, $02, $24, $0f, $0d, $02, $32, $00, $02, $fc, $f0, $02
    db $36, $00, $02, $50, $0f, $09, $02, $f6, $f6, $02, $76, $0f, $4d, $02, $ae, $0f
    db $23, $02, $ba, $04, $02, $10, $0a, $02, $22, $1f, $01, $02, $0a, $0f, $0b

Map8BAttrs0_Y2X1::
    db $68, $01, $04, $01, $01, $03, $03, $04, $f4, $f8, $03, $03, $01, $01, $04, $00
    db $0f, $03, $04, $fa, $f2, $02, $02, $02, $02, $04, $fa, $f4, $04, $28, $0f, $4d
    db $04, $38, $04, $04, $44, $00, $04, $a4, $04, $04, $9c, $0f, $31, $04, $40, $0f
    db $3b, $04, $3c, $02, $04, $44, $04, $04, $3e, $12, $04, $42, $1e

; LZSS-compressed: 75 bytes that expand to 360 (E-0016, E-0017)
Map8BAttrs0_Y3X1::
    INCBIN "dwm2-cobi-us.gbc", $14FF17, $4B
    ds $9e, $00
