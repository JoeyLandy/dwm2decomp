SECTION "Bank 90", ROMX[$4000], BANK[$90]
    db $90

; compressed BG tiles (2048 bytes, 128 tiles) of key-world kind 0: entry 0 of KeyWorldTilesetTable,
; decompressed to vTiles2 by RunWCC44Type_420D_Case00
; LZSS-compressed: 1166 bytes that expand to 2048 (E-0016, E-0017)
KeyWorldTiles0::
    INCBIN "dwm2-cobi-us.gbc", $240001, $48E

; entry 0 of KeyWorldTilesetTable; RunWCC44Type_420D_Case00 copies these $40 bytes to
; wBGPaletteBuffer (E-0139, C1)
; record: one CGB palette: 4 BGR555 colours
KeyWorldPalettes0::
    dw $7da0, $7fff, $7fe0, $0063 ; entry 0
    dw $0160, $3fbf, $03e2, $0000 ; entry 1
    dw $012f, $3fbf, $03e2, $0000 ; entry 2
    dw $318c, $5294, $03e2, $0000 ; entry 3
    dw $158f, $2ab7, $03e2, $0000 ; entry 4
    dw $0171, $3fbf, $03e2, $0000 ; entry 5
    dw $1415, $7fff, $03e2, $0000 ; entry 6
    dw $318c, $7fff, $5294, $0000 ; entry 7

; entry 2 of KeyWorldTilesetTable; RunWCC44Type_420D_Case00 copies these $40 bytes to
; wBGPaletteBuffer (E-0139, C1)
KeyWorldPalettes2::
    dw $7da0, $7fff, $7fe0, $0063 ; entry 0
    dw $01c4, $7fff, $5652, $0084 ; entry 1
    dw $01b5, $7fff, $5652, $0006 ; entry 2
    dw $01c4, $7fff, $5294, $0000 ; entry 3
    dw $7da0, $7fff, $7fe0, $40e0 ; entry 4
    dw $0171, $7fff, $2a13, $0000 ; entry 5
    dw $1415, $7fff, $25f5, $0000 ; entry 6
    dw $318c, $7fff, $5294, $0000 ; entry 7

; compressed tileset of map $26 (the first map record using it)
; LZSS-compressed: 1529 bytes that expand to 1776 (E-0016, E-0017)
Map26Tileset::
    INCBIN "dwm2-cobi-us.gbc", $24050F, $5F9

; compressed tileset of map $29 (the first map record using it)
; LZSS-compressed: 1014 bytes that expand to 1264 (E-0016, E-0017)
Map29Tileset::
    INCBIN "dwm2-cobi-us.gbc", $240B08, $3F6

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map29Palettes::
    dw $3126, $7fff, $7e0a, $0000 ; entry 0
    dw $3126, $035f, $7e0a, $0000 ; entry 1
    dw $010b, $6bff, $1db0, $0000 ; entry 2
    dw $1929, $5f17, $2e0e, $0000 ; entry 3
    dw $30e9, $5f17, $49cd, $0044 ; entry 4
    dw $2cc9, $6bff, $49cd, $0000 ; entry 5
    dw $7fff, $7fff, $7fff, $7fff ; entry 6
    dw $7fff, $7fff, $7fff, $7fff ; entry 7

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map29Screens0::
    dfar Map29Screens0_Y0X0 ; entry 0

Map29Attrs0::
    dfar Map29Attrs0_Y0X0 ; entry 0

; LZSS-compressed: 289 bytes that expand to 360 (E-0016, E-0017)
Map29Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $240F44, $121

; LZSS-compressed: 114 bytes that expand to 360 (E-0016, E-0017)
Map29Attrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $241065, $72

; compressed tileset of map $3D (the first map record using it)
; LZSS-compressed: 676 bytes that expand to 1168 (E-0016, E-0017)
Map3DTileset::
    INCBIN "dwm2-cobi-us.gbc", $2410D7, $2A4

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map3DPalettes::
    dw $1528, $7fff, $6b2b, $0000 ; entry 0
    dw $010e, $7bde, $22ba, $0000 ; entry 1
    dw $0000, $0000, $0000, $0000 ; entry 2
    dw $010e, $3f7f, $0216, $0000 ; entry 3
    dw $0016, $2294, $11d4, $0000 ; entry 4
    dw $001b, $2bff, $023f, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map3DScreens0::
    dfar Map3DScreens0_Y0X0 ; entry 0

Map3DAttrs0::
    dfar Map3DAttrs0_Y0X0 ; entry 0

; LZSS-compressed: 203 bytes that expand to 360 (E-0016, E-0017)
Map3DScreens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $2413C1, $CB

; LZSS-compressed: 77 bytes that expand to 360 (E-0016, E-0017)
Map3DAttrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $24148C, $4D

; compressed tileset of map $4B (the first map record using it)
; LZSS-compressed: 697 bytes that expand to 912 (E-0016, E-0017)
Map4BTileset::
    INCBIN "dwm2-cobi-us.gbc", $2414D9, $2B9

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map4BPalettes::
    dw $218c, $7fff, $5ab1, $0000 ; entry 0
    dw $010e, $22ba, $11d4, $0000 ; entry 1
    dw $012f, $7fff, $6b2b, $0000 ; entry 2
    dw $0160, $7fff, $5ab1, $0000 ; entry 3
    dw $1415, $3f7f, $01da, $0000 ; entry 4
    dw $001b, $2bff, $023f, $0000 ; entry 5
    dw $012f, $7fff, $22ba, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map4BScreens0::
    dfar Map4BScreens0_Y0X0 ; entry 0

Map4BAttrs0::
    dfar Map4BAttrs0_Y0X0 ; entry 0

; LZSS-compressed: 199 bytes that expand to 360 (E-0016, E-0017)
Map4BScreens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $2417D8, $C7

; LZSS-compressed: 74 bytes that expand to 360 (E-0016, E-0017)
Map4BAttrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $24189F, $4A

; compressed tileset of map $X59E4 (the first map record using it)
; LZSS-compressed: 575 bytes that expand to 736 (E-0016, E-0017)
MapX59E4Tileset::
    INCBIN "dwm2-cobi-us.gbc", $2418E9, $23F

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
MapX59E4Palettes::
    dw $7da0, $7fff, $7fe0, $0000 ; entry 0
    dw $012f, $035f, $01da, $0000 ; entry 1
    dw $7da0, $7f75, $6b40, $0063 ; entry 2
    dw $396b, $7fff, $5a94, $0000 ; entry 3
    dw $0000, $0000, $0000, $0000 ; entry 4
    dw $0000, $0000, $0000, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
MapX59E4Screens0::
    dfar MapX59E4Screens0_Y0X0 ; entry 0

MapX59E4Attrs0::
    dfar MapX59E4Attrs0_Y0X0 ; entry 0

; LZSS-compressed: 164 bytes that expand to 360 (E-0016, E-0017)
MapX59E4Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $241B6E, $A4

; LZSS-compressed: 61 bytes that expand to 360 (E-0016, E-0017)
MapX59E4Attrs0_Y0X0::
    db $68, $01, $04, $04, $ff, $f0, $02, $04, $04, $07, $04, $fc, $ff, $07, $04, $04
    db $04, $01, $01, $04, $0a, $06, $04, $2a, $0f, $05, $03, $04, $56, $03, $04, $4a
    db $0f, $0b, $04, $56, $04, $04, $5a, $02, $04, $76, $0f, $4d, $04, $ae, $0f, $1f
    db $04, $54, $0f, $13, $04, $50, $06, $04, $0c, $0c, $04, $48, $18

; compressed tileset of map $97 (the first map record using it)
; LZSS-compressed: 976 bytes that expand to 1792 (E-0016, E-0017)
Map97Tileset::
    INCBIN "dwm2-cobi-us.gbc", $241C4F, $3D0

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map97Palettes::
    dw $7da0, $7fff, $01d3, $0063 ; entry 0
    dw $396b, $7fff, $5a94, $0000 ; entry 1
    dw $3cc5, $6ad8, $5d12, $0000 ; entry 2
    dw $48ec, $6bff, $4a6f, $0000 ; entry 3
    dw $001b, $2bff, $023f, $0000 ; entry 4
    dw $396b, $7fff, $5a94, $0000 ; entry 5
    dw $012f, $035f, $01da, $0000 ; entry 6
    dw $218c, $4f18, $3a52, $0000 ; entry 7

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map97Screens0::
    dfar Map97Screens0_Y0X0 ; entry 0

Map97Attrs0::
    dfar Map97Attrs0_Y0X0 ; entry 0

Map98Screens0::
    dfar Map98Screens0_Y0X0 ; entry 0

Map98Attrs0::
    dfar Map98Attrs0_Y0X0 ; entry 0

Map99Screens0::
    dfar Map99Screens0_Y0X0 ; entry 0

Map99Attrs0::
    dfar Map99Attrs0_Y0X0 ; entry 0

Map9AScreens0::
    dfar Map9AScreens0_Y0X0 ; entry 0

Map9AAttrs0::
    dfar Map9AAttrs0_Y0X0 ; entry 0

; LZSS-compressed: 174 bytes that expand to 360 (E-0016, E-0017)
Map97Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $242077, $AE

; LZSS-compressed: 189 bytes that expand to 360 (E-0016, E-0017)
Map98Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $242125, $BD

; LZSS-compressed: 204 bytes that expand to 360 (E-0016, E-0017)
Map99Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $2421E2, $CC

; LZSS-compressed: 215 bytes that expand to 360 (E-0016, E-0017)
Map9AScreens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $2422AE, $D7

; LZSS-compressed: 42 bytes that expand to 360 (E-0016, E-0017)
Map97Attrs0_Y0X0::
    db $68, $01, $03, $02, $03, $00, $0f, $16, $01, $03, $2a, $0b, $03, $26, $0f, $1d
    db $03, $f8, $f4, $03, $5e, $0f, $0b, $03, $f4, $f8, $03, $88, $0f, $45, $03, $68
    db $0f, $15, $03, $2c, $0f, $13, $03, $00, $0f, $13

; LZSS-compressed: 47 bytes that expand to 360 (E-0016, E-0017)
Map98Attrs0_Y0X0::
    db $68, $01, $03, $02, $03, $00, $0f, $16, $01, $03, $2a, $0b, $03, $26, $0f, $1d
    db $03, $f8, $f4, $03, $5e, $0f, $0b, $03, $f4, $f8, $03, $88, $0f, $43, $04, $04
    db $03, $68, $0e, $03, $f2, $0f, $01, $03, $2a, $0f, $15, $03, $00, $0f, $13

Map99Attrs0_Y0X0::
    db $68, $01, $03, $02, $03, $00, $0f, $16, $01, $03, $2a, $0b, $03, $26, $0f, $1d
    db $03, $f8, $f4, $03, $5e, $0f, $0b, $03, $f4, $f8, $03, $88, $0f, $45, $03, $68
    db $0f, $15, $03, $2c, $0f, $13, $03, $00, $0f, $13

Map9AAttrs0_Y0X0::
    db $68, $01, $03, $02, $03, $00, $0f, $16, $01, $03, $2a, $0b, $03, $26, $0f, $1d
    db $03, $f8, $f4, $03, $5e, $0f, $0b, $03, $f4, $f8, $03, $88, $0f, $45, $03, $68
    db $0f, $15, $03, $2a, $08, $04, $04, $03, $16, $1f, $05, $03, $00, $0f, $13

; compressed tileset of map $9B (the first map record using it)
; LZSS-compressed: 1521 bytes that expand to 2048 (E-0016, E-0017)
Map9BTileset::
    INCBIN "dwm2-cobi-us.gbc", $242437, $5F1

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map9BPalettes::
    dw $7da0, $7fff, $01d3, $0063 ; entry 0
    dw $012f, $7fff, $7da6, $0000 ; entry 1
    dw $3cc5, $6ad8, $5d12, $0000 ; entry 2
    dw $48ec, $6bff, $4a6f, $0000 ; entry 3
    dw $001b, $2bff, $023f, $0000 ; entry 4
    dw $012f, $035f, $01da, $0000 ; entry 5
    dw $396b, $7fff, $5a94, $0000 ; entry 6
    dw $218c, $4f18, $3a52, $0000 ; entry 7

; 3 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map9BScreens0::
    dfar Map9BScreens0_Y0X0 ; entry 0
    dfar Map9BScreens0_Y1X0 ; entry 1
    dfar Map9BScreens0_Y2X0 ; entry 2

Map9BAttrs0::
    dfar Map9BAttrs0_Y0X0 ; entry 0
    dfar Map9BAttrs0_Y1X0 ; entry 1
    dfar Map9BAttrs0_Y2X0 ; entry 2

Map9BScreens4::
    dfar Map9BScreens4_Y0X0 ; entry 0
    dfar Map9BScreens0_Y1X0 ; entry 1
    dfar Map9BScreens0_Y2X0 ; entry 2

Map9BAttrs4::
    dfar Map9BAttrs4_Y0X0 ; entry 0
    dfar Map9BAttrs0_Y1X0 ; entry 1
    dfar Map9BAttrs0_Y2X0 ; entry 2

; LZSS-compressed: 266 bytes that expand to 360 (E-0016, E-0017)
Map9BScreens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $242A8C, $10A

; LZSS-compressed: 198 bytes that expand to 360 (E-0016, E-0017)
Map9BScreens4_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $242B96, $C6

; LZSS-compressed: 273 bytes that expand to 360 (E-0016, E-0017)
Map9BScreens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $242C5C, $111

; LZSS-compressed: 217 bytes that expand to 360 (E-0016, E-0017)
Map9BScreens0_Y2X0::
    INCBIN "dwm2-cobi-us.gbc", $242D6D, $D9

; LZSS-compressed: 131 bytes that expand to 360 (E-0016, E-0017)
Map9BAttrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $242E46, $83

; LZSS-compressed: 99 bytes that expand to 360 (E-0016, E-0017)
Map9BAttrs4_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $242EC9, $63

; LZSS-compressed: 73 bytes that expand to 360 (E-0016, E-0017)
Map9BAttrs0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $242F2C, $49

; LZSS-compressed: 63 bytes that expand to 360 (E-0016, E-0017)
Map9BAttrs0_Y2X0::
    db $68, $01, $01, $02, $02, $03, $03, $03, $03, $01, $fa, $f2, $01, $04, $02, $02
    db $02, $01, $00, $0f, $0f, $01, $02, $00, $01, $26, $0f, $07, $01, $f8, $f4, $01
    db $48, $0f, $15, $01, $32, $02, $01, $76, $0f, $2f, $01, $04, $02, $01, $34, $02
    db $01, $c4, $0f, $0b, $01, $f2, $08, $01, $ee, $0f, $2d, $01, $3e, $1f, $13

; compressed tileset of map $X62F0 (the first map record using it)
; LZSS-compressed: 639 bytes that expand to 2048 (E-0016, E-0017)
MapX62F0Tileset::
    INCBIN "dwm2-cobi-us.gbc", $242FB4, $27F

; compressed tileset of map $1D (the first map record using it)
; LZSS-compressed: 875 bytes that expand to 1024 (E-0016, E-0017)
Map1DTileset::
    INCBIN "dwm2-cobi-us.gbc", $243233, $36B

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map1DPalettes::
    dw $7da0, $7fff, $7fe0, $0063 ; entry 0
    dw $7da0, $3fbf, $01d5, $0063 ; entry 1
    dw $7da0, $3fbf, $7fe0, $0063 ; entry 2
    dw $012f, $3fbf, $01d5, $0000 ; entry 3
    dw $318c, $7fff, $5ad6, $0000 ; entry 4
    dw $318c, $7fff, $5ad6, $0000 ; entry 5
    dw $318c, $7fff, $5ad6, $0000 ; entry 6
    dw $318c, $7fff, $5ad6, $0000 ; entry 7

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map1DScreens0::
    dfar Map1DScreens0_Y0X0 ; entry 0
    dfar Map1DScreens0_Y0X1 ; entry 1

Map1DAttrs0::
    dfar Map1DAttrs0_Y0X0 ; entry 0
    dfar Map1DAttrs0_Y0X1 ; entry 1

; LZSS-compressed: 246 bytes that expand to 360 (E-0016, E-0017)
Map1DScreens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $2435EA, $F6

; LZSS-compressed: 260 bytes that expand to 360 (E-0016, E-0017)
Map1DScreens0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $2436E0, $104

; LZSS-compressed: 55 bytes that expand to 360 (E-0016, E-0017)
Map1DAttrs0_Y0X0::
    db $68, $01, $02, $00, $00, $00, $03, $01, $02, $04, $04, $10, $03, $03, $02, $fc
    db $fc, $03, $01, $02, $0e, $06, $02, $2b, $08, $02, $04, $00, $02, $28, $0f, $11
    db $02, $2b, $00, $02, $50, $0f, $4d, $02, $88, $0f, $1c, $01, $02, $e0, $0f, $14
    db $02, $8f, $0f, $29, $02, $25, $0d

; LZSS-compressed: 90 bytes that expand to 360 (E-0016, E-0017)
Map1DAttrs0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $24381B, $5A

; compressed tileset of map $1C (the first map record using it)
; LZSS-compressed: 1129 bytes that expand to 2304 (E-0016, E-0017)
Map1CTileset::
    INCBIN "dwm2-cobi-us.gbc", $243875, $469

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map1CPalettes::
    dw $7da0, $7fff, $7f08, $0000 ; entry 0
    dw $158f, $3f5c, $1244, $0000 ; entry 1
    dw $7da0, $03e2, $1244, $0000 ; entry 2
    dw $7da0, $3f5c, $1244, $0000 ; entry 3
    dw $7da0, $2297, $1244, $0000 ; entry 4
    dw $158f, $03e2, $1244, $0000 ; entry 5
    dw $158f, $3f5c, $2297, $0000 ; entry 6
    dw $158f, $3f5c, $7da0, $0000 ; entry 7

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map1CScreens0::
    dfar Map1CScreens0_Y0X0 ; entry 0
    dfar Map1CScreens0_Y1X0 ; entry 1

Map1CAttrs0::
    dfar Map1CAttrs0_Y0X0 ; entry 0
    dfar Map1CAttrs0_Y1X0 ; entry 1

; LZSS-compressed: 153 bytes that expand to 360 (E-0016, E-0017)
Map1CScreens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $243D2A, $99

; LZSS-compressed: 28 bytes that expand to 360 (E-0016, E-0017)
Map1CScreens0_Y1X0::
    db $68, $01, $02, $01, $02, $ff, $ff, $00, $02, $ff, $ff, $01, $02, $00, $0f, $4d
    db $02, $60, $0f, $4d, $02, $c0, $0f, $4d, $02, $f8, $0f, $0d

; LZSS-compressed: 99 bytes that expand to 360 (E-0016, E-0017)
Map1CAttrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $243DDF, $63

; LZSS-compressed: 19 bytes that expand to 360 (E-0016, E-0017)
Map1CAttrs0_Y1X0::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $5f, $0f, $4d, $01, $bf, $0f, $4d, $01
    db $1f, $1f, $35
    ds $1ab, $00
