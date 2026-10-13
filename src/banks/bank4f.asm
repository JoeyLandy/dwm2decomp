SECTION "Bank 4F", ROMX[$4000], BANK[$4F]
    db $4f

; compressed tileset of map $5A (the first map record using it)
; LZSS-compressed: 907 bytes that expand to 1248 (E-0016, E-0017)
Map5ATileset::
    INCBIN "dwm2-cobi-us.gbc", $13C001, $38B

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map5APalettes::
    dw $218c, $7fff, $5ab1, $0000 ; entry 0
    dw $218c, $17e5, $0301, $0000 ; entry 1
    dw $012f, $7fff, $029a, $0000 ; entry 2
    dw $0160, $7fff, $5ab1, $0000 ; entry 3
    dw $0000, $0000, $0000, $0000 ; entry 4
    dw $0000, $0000, $0000, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map5AScreens0::
    dfar Map5AScreens0_Y0X0 ; entry 0
    dfar Map5AScreens0_Y0X1 ; entry 1

Map5AAttrs0::
    dfar Map5AAttrs0_Y0X0 ; entry 0
    dfar Map5AAttrs0_Y0X1 ; entry 1

; LZSS-compressed: 242 bytes that expand to 360 (E-0016, E-0017)
Map5AScreens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $13C3D8, $F2

; LZSS-compressed: 267 bytes that expand to 360 (E-0016, E-0017)
Map5AScreens0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $13C4CA, $10B

; LZSS-compressed: 59 bytes that expand to 360 (E-0016, E-0017)
Map5AAttrs0_Y0X0::
    db $68, $01, $02, $02, $ff, $ff, $0d, $01, $01, $02, $ff, $f2, $03, $03, $02, $16
    db $0f, $1b, $02, $20, $00, $02, $48, $0f, $09, $02, $18, $0a, $02, $70, $0a, $02
    db $80, $08, $02, $50, $08, $02, $98, $0f, $09, $02, $c7, $0f, $4d, $02, $ff, $ff
    db $05, $02, $28, $08, $02, $22, $04, $02, $40, $1f, $01

; LZSS-compressed: 50 bytes that expand to 360 (E-0016, E-0017)
Map5AAttrs0_Y0X1::
    db $68, $01, $01, $01, $ff, $ff, $27, $03, $03, $01, $28, $0f, $13, $01, $12, $0f
    db $3d, $01, $3a, $0f, $0f, $02, $02, $01, $ff, $fe, $01, $d4, $0f, $01, $01, $10
    db $0f, $1b, $01, $3a, $0c, $01, $26, $12, $01, $3e, $10, $01, $2e, $0a, $01, $3e
    db $1f, $03

; compressed tileset of map $5B (the first map record using it)
; LZSS-compressed: 1477 bytes that expand to 1728 (E-0016, E-0017)
Map5BTileset::
    INCBIN "dwm2-cobi-us.gbc", $13C642, $5C5

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map5BPalettes::
    dw $218c, $7fff, $5ab1, $0000 ; entry 0
    dw $00ed, $22ba, $11d4, $0000 ; entry 1
    dw $0160, $22ba, $02c0, $0000 ; entry 2
    dw $0160, $7fff, $5ab1, $0000 ; entry 3
    dw $1415, $3f7f, $01da, $0000 ; entry 4
    dw $001b, $2bff, $023f, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map5BScreens0::
    dfar Map5BScreens0_Y0X0 ; entry 0
    dfar Map5BScreens0_Y0X1 ; entry 1
    dfar Map5BScreens0_Y1X0 ; entry 2
    dfar Map5BScreens0_Y1X1 ; entry 3

Map5BAttrs0::
    dfar Map5BAttrs0_Y0X0 ; entry 0
    dfar Map5BAttrs0_Y0X1 ; entry 1
    dfar Map5BAttrs0_Y1X0 ; entry 2
    dfar Map5BAttrs0_Y1X1 ; entry 3

; LZSS-compressed: 260 bytes that expand to 360 (E-0016, E-0017)
Map5BScreens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $13CC5F, $104

; LZSS-compressed: 238 bytes that expand to 360 (E-0016, E-0017)
Map5BScreens0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $13CD63, $EE

; LZSS-compressed: 242 bytes that expand to 360 (E-0016, E-0017)
Map5BScreens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $13CE51, $F2

; LZSS-compressed: 228 bytes that expand to 360 (E-0016, E-0017)
Map5BScreens0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $13CF43, $E4

; LZSS-compressed: 85 bytes that expand to 360 (E-0016, E-0017)
Map5BAttrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $13D027, $55

; LZSS-compressed: 74 bytes that expand to 360 (E-0016, E-0017)
Map5BAttrs0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $13D07C, $4A

; LZSS-compressed: 63 bytes that expand to 360 (E-0016, E-0017)
Map5BAttrs0_Y1X0::
    db $68, $01, $02, $02, $ff, $f8, $03, $03, $03, $03, $02, $fc, $ff, $07, $01, $02
    db $2a, $03, $02, $1e, $0f, $0d, $04, $02, $52, $01, $02, $30, $04, $02, $0c, $02
    db $02, $52, $0f, $07, $04, $04, $02, $6e, $0f, $17, $02, $ff, $f6, $02, $a2, $0f
    db $4b, $02, $30, $00, $02, $b4, $0f, $0d, $02, $2c, $04, $02, $3f, $1f, $15

; LZSS-compressed: 58 bytes that expand to 360 (E-0016, E-0017)
Map5BAttrs0_Y1X1::
    db $68, $01, $01, $01, $ff, $f4, $03, $03, $03, $03, $01, $f8, $ff, $0d, $01, $08
    db $04, $01, $08, $08, $01, $2c, $0c, $01, $0a, $0c, $01, $0a, $00, $01, $50, $0f
    db $11, $01, $4c, $0f, $01, $01, $da, $ff, $1d, $01, $80, $0e, $01, $ca, $0f, $29
    db $01, $06, $08, $01, $36, $0e, $01, $8a, $0f, $1d

; compressed tileset of map $5C (the first map record using it)
; LZSS-compressed: 1022 bytes that expand to 1280 (E-0016, E-0017)
Map5CTileset::
    INCBIN "dwm2-cobi-us.gbc", $13D13F, $3FE

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map5CPalettes::
    dw $218c, $7fff, $5ab1, $0000 ; entry 0
    dw $112a, $7fff, $6b2b, $0020 ; entry 1
    dw $0160, $22ba, $02c0, $0000 ; entry 2
    dw $218c, $17e5, $0301, $0000 ; entry 3
    dw $1415, $3f7f, $01da, $0000 ; entry 4
    dw $1415, $7fff, $01da, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map5CScreens0::
    dfar Map5CScreens0_Y0X0 ; entry 0
    dfar Map5CScreens0_Y1X0 ; entry 1

Map5CAttrs0::
    dfar Map5CAttrs0_Y0X0 ; entry 0
    dfar Map5CAttrs0_Y1X0 ; entry 1

; LZSS-compressed: 158 bytes that expand to 360 (E-0016, E-0017)
Map5CScreens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $13D589, $9E

; LZSS-compressed: 235 bytes that expand to 360 (E-0016, E-0017)
Map5CScreens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $13D627, $EB

; LZSS-compressed: 39 bytes that expand to 360 (E-0016, E-0017)
Map5CAttrs0_Y0X0::
    db $68, $01, $01, $10, $10, $01, $ee, $ff, $13, $01, $cc, $ff, $21, $04, $01, $5c
    db $01, $01, $4e, $0f, $11, $05, $05, $01, $74, $0f, $13, $01, $5e, $0f, $13, $01
    db $d3, $0f, $4d, $01, $33, $1f, $21

; LZSS-compressed: 78 bytes that expand to 360 (E-0016, E-0017)
Map5CAttrs0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $13D739, $4E

; compressed tileset of map $5D (the first map record using it)
; LZSS-compressed: 454 bytes that expand to 1280 (E-0016, E-0017)
Map5DTileset::
    INCBIN "dwm2-cobi-us.gbc", $13D787, $1C6

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map5DPalettes::
    dw $01d3, $7fff, $029a, $0000 ; entry 0
    dw $0160, $3657, $15ae, $0044 ; entry 1
    dw $218c, $7fff, $15ae, $0000 ; entry 2
    dw $0160, $7fff, $62f3, $0000 ; entry 3
    dw $218c, $4f18, $3a52, $0000 ; entry 4
    dw $218c, $4f18, $3a52, $0000 ; entry 5
    dw $0160, $5ab1, $4a2d, $0000 ; entry 6
    dw $218c, $4f18, $3a52, $0000 ; entry 7

; 16 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map5DScreens0::
    dfar Map5DScreens0_Y0X0 ; entry 0
    dfar Map5DScreens0_Y0X1 ; entry 1
    dfar Map5DScreens0_Y0X2 ; entry 2
    dfar Map5DScreens0_Y0X3 ; entry 3
    dfar Map5DScreens0_Y1X0 ; entry 4
    dfar Map5DScreens0_Y1X1 ; entry 5
    dfar Map5DScreens0_Y1X2 ; entry 6
    dfar Map5DScreens0_Y1X3 ; entry 7
    dfar Map5DScreens0_Y2X0 ; entry 8
    dfar Map5DScreens0_Y2X1 ; entry 9
    dfar Map5DScreens0_Y2X2 ; entry 10
    dfar Map5DScreens0_Y2X3 ; entry 11
    dfar Map5DScreens0_Y3X0 ; entry 12
    dfar Map5DScreens0_Y3X1 ; entry 13
    dfar Map5DScreens0_Y3X2 ; entry 14
    dfar Map5DScreens0_Y3X3 ; entry 15

Map5DAttrs0::
    dfar Map5DAttrs0_Y0X0 ; entry 0
    dfar Map5DAttrs0_Y0X1 ; entry 1
    dfar Map5DAttrs0_Y0X2 ; entry 2
    dfar Map5DAttrs0_Y0X3 ; entry 3
    dfar Map5DAttrs0_Y1X0 ; entry 4
    dfar Map5DAttrs0_Y1X1 ; entry 5
    dfar Map5DAttrs0_Y1X2 ; entry 6
    dfar Map5DAttrs0_Y1X3 ; entry 7
    dfar Map5DAttrs0_Y2X0 ; entry 8
    dfar Map5DAttrs0_Y2X1 ; entry 9
    dfar Map5DAttrs0_Y2X2 ; entry 10
    dfar Map5DAttrs0_Y2X3 ; entry 11
    dfar Map5DAttrs0_Y3X0 ; entry 12
    dfar Map5DAttrs0_Y3X1 ; entry 13
    dfar Map5DAttrs0_Y3X2 ; entry 14
    dfar Map5DAttrs0_Y3X3 ; entry 15

; LZSS-compressed: 195 bytes that expand to 360 (E-0016, E-0017)
Map5DScreens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $13D9ED, $C3

; LZSS-compressed: 160 bytes that expand to 360 (E-0016, E-0017)
Map5DScreens0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $13DAB0, $A0

; LZSS-compressed: 205 bytes that expand to 360 (E-0016, E-0017)
Map5DScreens0_Y0X2::
    INCBIN "dwm2-cobi-us.gbc", $13DB50, $CD

; LZSS-compressed: 146 bytes that expand to 360 (E-0016, E-0017)
Map5DScreens0_Y0X3::
    INCBIN "dwm2-cobi-us.gbc", $13DC1D, $92

; LZSS-compressed: 170 bytes that expand to 360 (E-0016, E-0017)
Map5DScreens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $13DCAF, $AA

; LZSS-compressed: 157 bytes that expand to 360 (E-0016, E-0017)
Map5DScreens0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $13DD59, $9D

; LZSS-compressed: 181 bytes that expand to 360 (E-0016, E-0017)
Map5DScreens0_Y1X2::
    INCBIN "dwm2-cobi-us.gbc", $13DDF6, $B5

; LZSS-compressed: 182 bytes that expand to 360 (E-0016, E-0017)
Map5DScreens0_Y1X3::
    INCBIN "dwm2-cobi-us.gbc", $13DEAB, $B6

; LZSS-compressed: 184 bytes that expand to 360 (E-0016, E-0017)
Map5DScreens0_Y2X0::
    INCBIN "dwm2-cobi-us.gbc", $13DF61, $B8

Map5DScreens0_Y2X1::
    INCBIN "dwm2-cobi-us.gbc", $13E019, $B6

; LZSS-compressed: 170 bytes that expand to 360 (E-0016, E-0017)
Map5DScreens0_Y2X2::
    INCBIN "dwm2-cobi-us.gbc", $13E0CF, $AA

; LZSS-compressed: 192 bytes that expand to 360 (E-0016, E-0017)
Map5DScreens0_Y2X3::
    INCBIN "dwm2-cobi-us.gbc", $13E179, $C0

; LZSS-compressed: 135 bytes that expand to 360 (E-0016, E-0017)
Map5DScreens0_Y3X0::
    INCBIN "dwm2-cobi-us.gbc", $13E239, $87

; LZSS-compressed: 162 bytes that expand to 360 (E-0016, E-0017)
Map5DScreens0_Y3X1::
    INCBIN "dwm2-cobi-us.gbc", $13E2C0, $A2

; LZSS-compressed: 181 bytes that expand to 360 (E-0016, E-0017)
Map5DScreens0_Y3X2::
    INCBIN "dwm2-cobi-us.gbc", $13E362, $B5

; LZSS-compressed: 153 bytes that expand to 360 (E-0016, E-0017)
Map5DScreens0_Y3X3::
    INCBIN "dwm2-cobi-us.gbc", $13E417, $99

; LZSS-compressed: 20 bytes that expand to 360 (E-0016, E-0017)
Map5DAttrs0_Y0X0::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

Map5DAttrs0_Y0X1::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

; LZSS-compressed: 62 bytes that expand to 360 (E-0016, E-0017)
Map5DAttrs0_Y0X2::
    db $68, $01, $00, $01, $03, $00, $01, $0d, $01, $00, $00, $0f, $09, $02, $02, $02
    db $02, $00, $20, $0f, $0f, $02, $02, $01, $01, $01, $01, $00, $30, $03, $00, $4f
    db $0f, $03, $01, $01, $00, $55, $03, $00, $7e, $02, $02, $02, $00, $76, $01, $01
    db $00, $7c, $0a, $00, $7e, $06, $00, $a7, $0f, $4d, $00, $07, $1f, $4d

Map5DAttrs0_Y0X3::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

Map5DAttrs0_Y1X0::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

Map5DAttrs0_Y1X1::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

Map5DAttrs0_Y1X2::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

Map5DAttrs0_Y1X3::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

Map5DAttrs0_Y2X0::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

Map5DAttrs0_Y2X1::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

Map5DAttrs0_Y2X2::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

Map5DAttrs0_Y2X3::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

Map5DAttrs0_Y3X0::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

Map5DAttrs0_Y3X1::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

Map5DAttrs0_Y3X2::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

Map5DAttrs0_Y3X3::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

; compressed tileset of map $5E (the first map record using it)
; LZSS-compressed: 1501 bytes that expand to 1776 (E-0016, E-0017)
Map5ETileset::
    INCBIN "dwm2-cobi-us.gbc", $13E61A, $5DD

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map5EPalettes::
    dw $218c, $7fff, $5ab1, $0000 ; entry 0
    dw $012f, $7fff, $01da, $0000 ; entry 1
    dw $012f, $3f7f, $029a, $0000 ; entry 2
    dw $0160, $3f7f, $029a, $0000 ; entry 3
    dw $1415, $3f7f, $01da, $0000 ; entry 4
    dw $001b, $2bff, $023f, $0000 ; entry 5
    dw $7c01, $7fff, $7fe1, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map5EScreens0::
    dfar Map5EScreens0_Y0X0 ; entry 0
    dfar Map5EScreens0_Y0X1 ; entry 1
    dfar Map5EScreens0_Y1X0 ; entry 2
    dfar Map5EScreens0_Y1X1 ; entry 3

Map5EAttrs0::
    dfar Map5EAttrs0_Y0X0 ; entry 0
    dfar Map5EAttrs0_Y0X1 ; entry 1
    dfar Map5EAttrs0_Y1X0 ; entry 2
    dfar Map5EAttrs0_Y1X1 ; entry 3

; LZSS-compressed: 232 bytes that expand to 360 (E-0016, E-0017)
Map5EScreens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $13EC4F, $E8

; LZSS-compressed: 216 bytes that expand to 360 (E-0016, E-0017)
Map5EScreens0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $13ED37, $D8

; LZSS-compressed: 259 bytes that expand to 360 (E-0016, E-0017)
Map5EScreens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $13EE0F, $103

; LZSS-compressed: 252 bytes that expand to 360 (E-0016, E-0017)
Map5EScreens0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $13EF12, $FC

; LZSS-compressed: 96 bytes that expand to 360 (E-0016, E-0017)
Map5EAttrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $13F00E, $60

; LZSS-compressed: 78 bytes that expand to 360 (E-0016, E-0017)
Map5EAttrs0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $13F06E, $4E

; LZSS-compressed: 88 bytes that expand to 360 (E-0016, E-0017)
Map5EAttrs0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $13F0BC, $58

; LZSS-compressed: 89 bytes that expand to 360 (E-0016, E-0017)
Map5EAttrs0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $13F114, $59

; compressed tileset of map $60 (the first map record using it)
; LZSS-compressed: 1325 bytes that expand to 1632 (E-0016, E-0017)
Map60Tileset::
    INCBIN "dwm2-cobi-us.gbc", $13F16D, $52D

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map60Palettes::
    dw $218c, $7fff, $5ab1, $0000 ; entry 0
    dw $00ed, $22ba, $11d4, $0000 ; entry 1
    dw $012f, $3f7f, $029a, $0000 ; entry 2
    dw $0160, $3f7f, $5ab1, $0000 ; entry 3
    dw $1415, $3f7f, $01da, $0000 ; entry 4
    dw $001b, $2bff, $023f, $0000 ; entry 5
    dw $0014, $7fff, $01da, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 3 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map60Screens0::
    dfar Map60Screens0_Y0X0 ; entry 0
    dfar Map60Screens0_Y1X0 ; entry 1
    dfar Map60Screens0_Y2X0 ; entry 2

Map60Attrs0::
    dfar Map60Attrs0_Y0X0 ; entry 0
    dfar Map60Attrs0_Y1X0 ; entry 1
    dfar Map60Attrs0_Y2X0 ; entry 2

; LZSS-compressed: 266 bytes that expand to 360 (E-0016, E-0017)
Map60Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $13F6EC, $10A

; LZSS-compressed: 244 bytes that expand to 360 (E-0016, E-0017)
Map60Screens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $13F7F6, $F4

; LZSS-compressed: 216 bytes that expand to 360 (E-0016, E-0017)
Map60Screens0_Y2X0::
    INCBIN "dwm2-cobi-us.gbc", $13F8EA, $D8

; LZSS-compressed: 68 bytes that expand to 360 (E-0016, E-0017)
Map60Attrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $13F9C2, $44

; LZSS-compressed: 73 bytes that expand to 360 (E-0016, E-0017)
Map60Attrs0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $13FA06, $49

; LZSS-compressed: 69 bytes that expand to 360 (E-0016, E-0017)
Map60Attrs0_Y2X0::
    INCBIN "dwm2-cobi-us.gbc", $13FA4F, $45

; compressed tileset of map $61 (the first map record using it)
; LZSS-compressed: 1088 bytes that expand to 1344 (E-0016, E-0017)
Map61Tileset::
    INCBIN "dwm2-cobi-us.gbc", $13FA94, $440

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map61Palettes::
    dw $218c, $7fff, $5ab1, $0000 ; entry 0
    dw $00ed, $22ba, $11d4, $0000 ; entry 1
    dw $012f, $3f7f, $029a, $0000 ; entry 2
    dw $1528, $7fff, $6b2b, $0020 ; entry 3
    dw $1415, $3f7f, $01da, $0000 ; entry 4
    dw $001b, $2bff, $023f, $0000 ; entry 5
    dw $0014, $7fff, $01da, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7
    ds $ec, $00
