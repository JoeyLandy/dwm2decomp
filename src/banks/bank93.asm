SECTION "Bank 93", ROMX[$4000], BANK[$93]
    db $93

; compressed BG tiles, entry 0 of AreaTilesetTable
; LZSS-compressed: 1313 bytes that expand to 1536 (E-0016, E-0017)
AreaTileset0::
    INCBIN "dwm2-cobi-us.gbc", $24C001, $521

; compressed tileset of map $03 (the first map record using it)
; LZSS-compressed: 977 bytes that expand to 1232 (E-0016, E-0017)
Map03Tileset::
    INCBIN "dwm2-cobi-us.gbc", $24C522, $3D1

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map03Palettes::
    dw $7da0, $7fff, $7fe0, $0000 ; entry 0
    dw $3126, $035f, $7e0a, $0000 ; entry 1
    dw $00cf, $4299, $0175, $0000 ; entry 2
    dw $21aa, $6bff, $3a91, $0000 ; entry 3
    dw $014d, $035f, $2a55, $0000 ; entry 4
    dw $014d, $6bff, $2a55, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map03Screens0::
    dfar Map03Screens0_Y0X0 ; entry 0

Map03Attrs0::
    dfar Map03Attrs0_Y0X0 ; entry 0

; LZSS-compressed: 268 bytes that expand to 360 (E-0016, E-0017)
Map03Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $24C939, $10C

; LZSS-compressed: 89 bytes that expand to 360 (E-0016, E-0017)
Map03Attrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $24CA45, $59

; compressed tileset of map $11 (the first map record using it)
; LZSS-compressed: 693 bytes that expand to 1120 (E-0016, E-0017)
Map11Tileset::
    INCBIN "dwm2-cobi-us.gbc", $24CA9E, $2B5

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map11Palettes::
    dw $7d86, $7fff, $7fe1, $0000 ; entry 0
    dw $012f, $031d, $01d8, $0000 ; entry 1
    dw $012f, $67ff, $0214, $0000 ; entry 2
    dw $158f, $4298, $2a13, $0020 ; entry 3
    dw $158f, $4fff, $03e2, $0000 ; entry 4
    dw $29ce, $4fff, $3695, $0020 ; entry 5
    dw $29ce, $4fff, $3695, $0020 ; entry 6
    dw $29ce, $4fff, $3695, $18ea ; entry 7

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map11Screens0::
    dfar Map11Screens0_Y0X0 ; entry 0
    dfar Map11Screens0_Y1X0 ; entry 1

Map11Attrs0::
    dfar Map11Attrs0_Y0X0 ; entry 0
    dfar Map11Attrs0_Y1X0 ; entry 1

; LZSS-compressed: 170 bytes that expand to 360 (E-0016, E-0017)
Map11Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $24CD9F, $AA

; LZSS-compressed: 134 bytes that expand to 360 (E-0016, E-0017)
Map11Screens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $24CE49, $86

; LZSS-compressed: 62 bytes that expand to 360 (E-0016, E-0017)
Map11Attrs0_Y0X0::
    db $68, $01, $04, $03, $04, $00, $00, $04, $fc, $f3, $04, $fc, $f5, $04, $01, $0f
    db $05, $04, $24, $0d, $01, $04, $3e, $01, $04, $38, $06, $04, $3a, $0f, $1f, $02
    db $04, $80, $01, $04, $40, $04, $04, $80, $02, $04, $8e, $06, $04, $8a, $0f, $19
    db $04, $7c, $02, $04, $ca, $06, $04, $c6, $0f, $41, $04, $8e, $0f, $27

; LZSS-compressed: 63 bytes that expand to 360 (E-0016, E-0017)
Map11Attrs0_Y1X0::
    db $68, $01, $00, $03, $03, $02, $00, $02, $0b, $03, $03, $00, $00, $0f, $07, $04
    db $00, $2e, $03, $00, $0e, $0f, $0d, $01, $01, $00, $52, $06, $00, $4e, $0f, $0b
    db $00, $7e, $02, $00, $72, $0f, $0d, $00, $06, $0f, $15, $00, $ba, $0f, $39, $00
    db $32, $04, $00, $0a, $0f, $0d, $00, $3e, $12, $00, $3a, $1a, $00, $42, $1e

; compressed tileset of map $12 (the first map record using it)
; LZSS-compressed: 711 bytes that expand to 896 (E-0016, E-0017)
Map12Tileset::
    INCBIN "dwm2-cobi-us.gbc", $24CF4C, $2C7

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map12Palettes::
    dw $7d86, $7fff, $7fe1, $0000 ; entry 0
    dw $012f, $031d, $01d8, $0000 ; entry 1
    dw $012f, $67ff, $0214, $0000 ; entry 2
    dw $158f, $4298, $2a13, $0020 ; entry 3
    dw $158f, $4fff, $03e2, $0000 ; entry 4
    dw $29ce, $4fff, $3695, $0020 ; entry 5
    dw $29ce, $4fff, $3695, $0020 ; entry 6
    dw $29ce, $4fff, $3695, $18ea ; entry 7

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map12Screens0::
    dfar Map12Screens0_Y0X0 ; entry 0

Map12Attrs0::
    dfar Map12Attrs0_Y0X0 ; entry 0

; LZSS-compressed: 160 bytes that expand to 360 (E-0016, E-0017)
Map12Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $24D259, $A0

; LZSS-compressed: 68 bytes that expand to 360 (E-0016, E-0017)
Map12Attrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $24D2F9, $44

; compressed tileset of map $2F (the first map record using it)
; LZSS-compressed: 1059 bytes that expand to 1280 (E-0016, E-0017)
Map2FTileset::
    INCBIN "dwm2-cobi-us.gbc", $24D33D, $3B6

; LZSS-compressed: 359 bytes that expand to 366 (E-0016, E-0017)
Gfx_93_56F3::
    INCBIN "dwm2-cobi-us.gbc", $24D6F3, $6D

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map2FPalettes::
    dw $7c01, $7fff, $6301, $0000 ; entry 0
    dw $01d3, $3f7f, $029a, $0042 ; entry 1
    dw $02c0, $3f7f, $03e2, $0000 ; entry 2
    dw $012f, $2b3f, $01d8, $0000 ; entry 3
    dw $001b, $2bff, $023f, $0000 ; entry 4
    dw $218c, $4f18, $3a52, $0000 ; entry 5
    dw $218c, $4f18, $3a52, $0000 ; entry 6
    dw $218c, $4f18, $3a52, $0000 ; entry 7

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map2FScreens0::
    dfar Map2FScreens0_Y0X0 ; entry 0
    dfar Map2FScreens0_Y0X1 ; entry 1
    dfar Map2FScreens0_Y1X0 ; entry 2
    dfar Map2FScreens0_Y1X1 ; entry 3

Map2FAttrs0::
    dfar Map2FAttrs0_Y0X0 ; entry 0
    dfar Map2FAttrs0_Y0X1 ; entry 1
    dfar Map2FAttrs0_Y1X0 ; entry 2
    dfar Map2FAttrs0_Y1X1 ; entry 3

Map2FScreens4::
    dfar Map2FScreens0_Y0X0 ; entry 0
    dfar Map2FScreens0_Y0X1 ; entry 1
    dfar Map2FScreens4_Y1X0 ; entry 2
    dfar Map2FScreens0_Y1X1 ; entry 3

Map2FAttrs4::
    dfar Map2FAttrs0_Y0X0 ; entry 0
    dfar Map2FAttrs0_Y0X1 ; entry 1
    dfar Map2FAttrs4_Y1X0 ; entry 2
    dfar Map2FAttrs0_Y1X1 ; entry 3

Map2FScreens5::
    dfar Map2FScreens5_Y0X0 ; entry 0
    dfar Map2FScreens5_Y0X1 ; entry 1
    dfar Map2FScreens0_Y1X0 ; entry 2
    dfar Map2FScreens5_Y1X1 ; entry 3

Map2FAttrs5::
    dfar Map2FAttrs5_Y0X0 ; entry 0
    dfar Map2FAttrs5_Y0X1 ; entry 1
    dfar Map2FAttrs0_Y1X0 ; entry 2
    dfar Map2FAttrs5_Y1X1 ; entry 3

; LZSS-compressed: 114 bytes that expand to 360 (E-0016, E-0017)
Map2FScreens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $24D7E8, $72

; LZSS-compressed: 205 bytes that expand to 360 (E-0016, E-0017)
Map2FScreens5_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $24D85A, $CD

; LZSS-compressed: 77 bytes that expand to 360 (E-0016, E-0017)
Map2FScreens0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $24D927, $4D

; LZSS-compressed: 285 bytes that expand to 360 (E-0016, E-0017)
Map2FScreens5_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $24D974, $11D

; LZSS-compressed: 165 bytes that expand to 360 (E-0016, E-0017)
Map2FScreens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $24DA91, $A5

; LZSS-compressed: 179 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_93_5B36::
    INCBIN "dwm2-cobi-us.gbc", $24DB36, $B3

; LZSS-compressed: 176 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_93_5BE9::
    INCBIN "dwm2-cobi-us.gbc", $24DBE9, $B0

; LZSS-compressed: 178 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_93_5C99::
    INCBIN "dwm2-cobi-us.gbc", $24DC99, $B2

; LZSS-compressed: 170 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_93_5D4B::
    INCBIN "dwm2-cobi-us.gbc", $24DD4B, $AA

; LZSS-compressed: 161 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_93_5DF5::
    INCBIN "dwm2-cobi-us.gbc", $24DDF5, $A1

; LZSS-compressed: 159 bytes that expand to 360 (E-0016, E-0017)
Map2FScreens4_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $24DE96, $9F

; LZSS-compressed: 115 bytes that expand to 360 (E-0016, E-0017)
Map2FScreens0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $24DF35, $73

; LZSS-compressed: 162 bytes that expand to 360 (E-0016, E-0017)
Map2FScreens5_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $24DFA8, $A2

; LZSS-compressed: 20 bytes that expand to 360 (E-0016, E-0017)
Map2FAttrs0_Y0X0::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

; LZSS-compressed: 67 bytes that expand to 360 (E-0016, E-0017)
Map2FAttrs5_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $24E05E, $43

Map2FAttrs0_Y0X1::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

; LZSS-compressed: 111 bytes that expand to 360 (E-0016, E-0017)
Map2FAttrs5_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $24E0B5, $6F

; LZSS-compressed: 47 bytes that expand to 360 (E-0016, E-0017)
Map2FAttrs0_Y1X0::
    db $68, $01, $03, $01, $01, $01, $01, $03, $f0, $ff, $3d, $03, $02, $00, $02, $02
    db $02, $02, $03, $4c, $06, $03, $52, $0f, $05, $02, $02, $03, $02, $00, $03, $60
    db $06, $03, $7a, $0f, $05, $03, $a5, $0f, $4d, $03, $05, $1f, $4d, $01, $01

; LZSS-compressed: 65 bytes that expand to 360 (E-0016, E-0017)
ScriptScreenAttrMap_93_6153::
    INCBIN "dwm2-cobi-us.gbc", $24E153, $41

; LZSS-compressed: 59 bytes that expand to 360 (E-0016, E-0017)
ScriptScreenAttrMap_93_6194::
    db $68, $01, $03, $01, $03, $00, $01, $03, $f2, $ff, $0e, $03, $00, $02, $03, $04
    db $02, $03, $05, $02, $03, $27, $04, $03, $27, $06, $03, $39, $09, $02, $02, $02
    db $02, $03, $39, $0c, $03, $58, $0e, $03, $5a, $00, $03, $37, $0c, $03, $7e, $0f
    db $01, $03, $a5, $0f, $4d, $03, $05, $1f, $4d, $01, $01

; LZSS-compressed: 57 bytes that expand to 360 (E-0016, E-0017)
ScriptScreenAttrMap_93_61CF::
    db $68, $01, $03, $01, $03, $00, $01, $03, $f3, $ff, $00, $03, $04, $01, $03, $04
    db $03, $03, $13, $04, $03, $13, $06, $03, $25, $0c, $03, $37, $0d, $02, $02, $02
    db $02, $03, $48, $0f, $0f, $03, $5a, $00, $03, $23, $0c, $03, $7e, $0f, $01, $03
    db $a5, $0f, $4d, $03, $05, $1f, $4d, $01, $01

; LZSS-compressed: 52 bytes that expand to 360 (E-0016, E-0017)
ScriptScreenAttrMap_93_6208::
    db $68, $01, $03, $01, $03, $00, $02, $03, $fc, $f2, $03, $fb, $f8, $03, $12, $05
    db $03, $0f, $0f, $00, $03, $25, $0f, $10, $02, $02, $02, $02, $03, $48, $0f, $0f
    db $03, $5a, $00, $03, $10, $0c, $03, $7e, $0f, $01, $03, $a5, $0f, $4d, $03, $05
    db $1f, $4d, $01, $01

; LZSS-compressed: 42 bytes that expand to 360 (E-0016, E-0017)
ScriptScreenAttrMap_93_623C::
    db $68, $01, $03, $01, $03, $00, $08, $03, $fd, $fc, $03, $10, $0f, $28, $02, $02
    db $02, $02, $03, $48, $0f, $0f, $03, $5a, $00, $03, $0e, $0c, $03, $7e, $0f, $01
    db $03, $a5, $0f, $4d, $03, $05, $1f, $4d, $01, $01

; LZSS-compressed: 36 bytes that expand to 360 (E-0016, E-0017)
Map2FAttrs4_Y1X0::
    db $68, $01, $03, $01, $03, $00, $0f, $44, $02, $02, $02, $02, $03, $48, $0f, $0f
    db $03, $5a, $00, $03, $fe, $fc, $03, $7e, $0f, $01, $03, $a5, $0f, $4d, $03, $05
    db $1f, $4d, $01, $01

; LZSS-compressed: 20 bytes that expand to 360 (E-0016, E-0017)
Map2FAttrs0_Y1X1::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

; LZSS-compressed: 56 bytes that expand to 360 (E-0016, E-0017)
Map2FAttrs5_Y1X1::
    db $68, $01, $03, $03, $ff, $f2, $02, $03, $06, $09, $03, $00, $0f, $05, $03, $06
    db $02, $01, $01, $01, $01, $03, $22, $0f, $07, $03, $48, $06, $03, $58, $02, $03
    db $44, $0a, $03, $5a, $08, $03, $76, $0c, $03, $74, $0f, $01, $03, $74, $0f, $03
    db $03, $b3, $0f, $4d, $03, $08, $1f, $41

; compressed tileset of map $32 (the first map record using it)
; LZSS-compressed: 1544 bytes that expand to 1776 (E-0016, E-0017)
Map32Tileset::
    INCBIN "dwm2-cobi-us.gbc", $24E2D6, $608

; compressed tileset of map $3E (the first map record using it)
; LZSS-compressed: 762 bytes that expand to 1536 (E-0016, E-0017)
Map3ETileset::
    INCBIN "dwm2-cobi-us.gbc", $24E8DE, $2FA

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map3EPalettes::
    dw $7da0, $7fff, $7fe0, $0000 ; entry 0
    dw $28c8, $3fbf, $4192, $0000 ; entry 1
    dw $001b, $2bff, $023f, $0000 ; entry 2
    dw $0106, $4f18, $020c, $0000 ; entry 3
    dw $0106, $677a, $0210, $0000 ; entry 4
    dw $0108, $3f7f, $0216, $0002 ; entry 5
    dw $218c, $4f18, $3a52, $0ca5 ; entry 6
    dw $218c, $4f18, $3a52, $0ca5 ; entry 7

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map3EScreens0::
    dfar Map3EScreens0_Y0X0 ; entry 0
    dfar Map3EScreens0_Y0X1 ; entry 1
    dfar Map3EScreens0_Y1X0 ; entry 2
    dfar Map3EScreens0_Y1X1 ; entry 3

Map3EAttrs0::
    dfar Map3EAttrs0_Y0X0 ; entry 0
    dfar Map3EAttrs0_Y0X1 ; entry 1
    dfar Map3EAttrs0_Y1X0 ; entry 2
    dfar Map3EAttrs0_Y1X1 ; entry 3

; LZSS-compressed: 249 bytes that expand to 360 (E-0016, E-0017)
Map3EScreens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $24EC30, $F9

; LZSS-compressed: 272 bytes that expand to 360 (E-0016, E-0017)
Map3EScreens0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $24ED29, $110

Map3EScreens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $24EE39, $F9

; LZSS-compressed: 220 bytes that expand to 360 (E-0016, E-0017)
Map3EScreens0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $24EF32, $DC

; LZSS-compressed: 84 bytes that expand to 360 (E-0016, E-0017)
Map3EAttrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $24F00E, $54

; LZSS-compressed: 77 bytes that expand to 360 (E-0016, E-0017)
Map3EAttrs0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $24F062, $4D

; LZSS-compressed: 82 bytes that expand to 360 (E-0016, E-0017)
Map3EAttrs0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $24F0AF, $52

; LZSS-compressed: 48 bytes that expand to 360 (E-0016, E-0017)
Map3EAttrs0_Y1X1::
    db $68, $01, $04, $01, $04, $00, $0f, $40, $03, $04, $54, $07, $04, $4c, $0f, $07
    db $04, $54, $06, $02, $02, $04, $5c, $04, $04, $7a, $0f, $0b, $04, $5a, $06, $04
    db $a2, $0f, $4d, $04, $4e, $0f, $17, $04, $fe, $fe, $04, $fc, $ff, $01, $00, $00

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map3FScreens0::
    dfar Map3FScreens0_Y0X0 ; entry 0
    dfar Map3FScreens0_Y0X1 ; entry 1
    dfar Map3FScreens0_Y1X0 ; entry 2
    dfar Map3FScreens0_Y1X1 ; entry 3

Map3FAttrs0::
    dfar Map3FAttrs0_Y0X0 ; entry 0
    dfar Map3FAttrs0_Y0X1 ; entry 1
    dfar Map3FAttrs0_Y1X0 ; entry 2
    dfar Map3FAttrs0_Y1X1 ; entry 3

; LZSS-compressed: 255 bytes that expand to 360 (E-0016, E-0017)
Map3FScreens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $24F149, $FF

; LZSS-compressed: 217 bytes that expand to 360 (E-0016, E-0017)
Map3FScreens0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $24F248, $D9

; LZSS-compressed: 267 bytes that expand to 360 (E-0016, E-0017)
Map3FScreens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $24F321, $10B

; LZSS-compressed: 244 bytes that expand to 360 (E-0016, E-0017)
Map3FScreens0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $24F42C, $F4

; LZSS-compressed: 70 bytes that expand to 360 (E-0016, E-0017)
Map3FAttrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $24F520, $46

; LZSS-compressed: 65 bytes that expand to 360 (E-0016, E-0017)
Map3FAttrs0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $24F566, $41

; LZSS-compressed: 78 bytes that expand to 360 (E-0016, E-0017)
Map3FAttrs0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $24F5A7, $4E

; LZSS-compressed: 80 bytes that expand to 360 (E-0016, E-0017)
Map3FAttrs0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $24F5F5, $50

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map8CPalettes::
    dw $100e, $7fff, $70ca, $0000 ; entry 0
    dw $150b, $4a52, $4d8c, $0000 ; entry 1
    dw $194a, $4a52, $020a, $0000 ; entry 2
    dw $001b, $2bff, $023f, $0000 ; entry 3
    dw $10ca, $4a52, $4d8c, $0000 ; entry 4
    dw $3c6b, $3a52, $2510, $0000 ; entry 5
    dw $18eb, $67ff, $01da, $0000 ; entry 6
    dw $218c, $4f18, $3a52, $0000 ; entry 7

Map8EPalettes::
    dw $100e, $7fff, $70ca, $0000 ; entry 0
    dw $0143, $4e15, $01c7, $0000 ; entry 1
    dw $192c, $7fff, $45f2, $0000 ; entry 2
    dw $3c0b, $4e15, $2d52, $0000 ; entry 3
    dw $0143, $4a52, $012f, $00a0 ; entry 4
    dw $0143, $7fff, $45f2, $00a0 ; entry 5
    dw $0143, $4a52, $01c7, $0000 ; entry 6
    dw $218c, $4f18, $3a52, $0000 ; entry 7

Map92Palettes::
    dw $7da0, $7fff, $7fe0, $0000 ; entry 0
    dw $48ec, $6bff, $4a6f, $0000 ; entry 1
    dw $0000, $0000, $0000, $0000 ; entry 2
    dw $0000, $0000, $0000, $0000 ; entry 3
    dw $0000, $0000, $0000, $0000 ; entry 4
    dw $0000, $0000, $0000, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

Map94Palettes::
    dw $3cc5, $7fff, $1415, $0000 ; entry 0
    dw $400c, $025c, $0015, $0000 ; entry 1
    dw $00ef, $5ad6, $2a13, $0000 ; entry 2
    dw $3cc5, $3f7f, $1415, $0000 ; entry 3
    dw $3cc5, $6ad8, $5d12, $0000 ; entry 4
    dw $001b, $2bff, $023f, $0000 ; entry 5
    dw $218c, $4f18, $3a52, $0000 ; entry 6
    dw $218c, $4f18, $3a52, $0000 ; entry 7

; compressed tileset of map $X6248 (the first map record using it)
; LZSS-compressed: 399 bytes that expand to 608 (E-0016, E-0017)
MapX6248Tileset::
    INCBIN "dwm2-cobi-us.gbc", $24F745, $18F

MapX6248Palettes::
    dw $7da0, $7fff, $7fe0, $0000 ; entry 0
    dw $012f, $035f, $01da, $0000 ; entry 1
    dw $48ec, $6bff, $4a6f, $0000 ; entry 2
    dw $396b, $7fff, $5a94, $0000 ; entry 3
    dw $0000, $0000, $0000, $0000 ; entry 4
    dw $0000, $0000, $0000, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
MapX6248Screens0::
    dfar MapX6248Screens0_Y0X0 ; entry 0

MapX6248Attrs0::
    dfar MapX6248Attrs0_Y0X0 ; entry 0

; LZSS-compressed: 156 bytes that expand to 360 (E-0016, E-0017)
MapX6248Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $24F91A, $9C

; LZSS-compressed: 76 bytes that expand to 360 (E-0016, E-0017)
MapX6248Attrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $24F9B6, $4C

; compressed tileset of map $8F (the first map record using it)
; LZSS-compressed: 1318 bytes that expand to 1536 (E-0016, E-0017)
Map8FTileset::
    INCBIN "dwm2-cobi-us.gbc", $24FA02, $526

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map8FPalettes::
    dw $18eb, $7fff, $01da, $0000 ; entry 0
    dw $150b, $4a52, $4d8c, $0000 ; entry 1
    dw $194a, $4a52, $020a, $0000 ; entry 2
    dw $192c, $7fff, $45f2, $0000 ; entry 3
    dw $194a, $03ff, $020a, $0000 ; entry 4
    dw $18c6, $03ff, $020a, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

MapB0Palettes::
    dw $7da0, $7fff, $7fe0, $0063 ; entry 0
    dw $01c4, $7fff, $5652, $0084 ; entry 1
    dw $01b5, $7fff, $5652, $0006 ; entry 2
    dw $01c4, $7fff, $5294, $0000 ; entry 3
    dw $7da0, $7fff, $7fe0, $40e0 ; entry 4
    dw $0171, $7fff, $2a13, $0000 ; entry 5
    dw $1415, $7fff, $25f5, $0000 ; entry 6
    dw $318c, $7fff, $5294, $0000 ; entry 7
    ds $58, $00
