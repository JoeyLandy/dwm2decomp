; ROM bank $49: map screens, attributes and tilesets
; The annotated listing of this bank is build/listing/bank49.asm.

SECTION "Bank 49", ROMX[$4000], BANK[$49]
    db $49

; compressed tileset of map $15 (the first map record using it)
; LZSS-compressed: 651 bytes that expand to 880 (E-0016, E-0017)
Map15Tileset::
    INCBIN "dwm2-cobi-us.gbc", $124001, $28B

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map15Palettes::
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
Map15Screens0::
    dfar Map15Screens0_Y0X0 ; entry 0

Map15Attrs0::
    dfar Map15Attrs0_Y0X0 ; entry 0

; LZSS-compressed: 227 bytes that expand to 360 (E-0016, E-0017)
Map15Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1242D2, $E3

; LZSS-compressed: 99 bytes that expand to 360 (E-0016, E-0017)
Map15Attrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1243B5, $63

; compressed tileset of map $0A (the first map record using it)
; LZSS-compressed: 708 bytes that expand to 1168 (E-0016, E-0017)
Map0ATileset::
    INCBIN "dwm2-cobi-us.gbc", $124418, $2C4

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map0APalettes::
BGPaletteBufferData_49_46DC::
    dw $7d00, $7fff, $7fe1, $0000 ; entry 0
    dw $7d00, $031d, $01d8, $0000 ; entry 1
    dw $012f, $67ff, $0214, $0000 ; entry 2
    dw $158f, $4298, $2a13, $0020 ; entry 3
    dw $001f, $2bff, $0214, $0000 ; entry 4
    dw $1415, $67ff, $3c1f, $0000 ; entry 5
    dw $29ce, $4fff, $3695, $0020 ; entry 6
    dw $29ce, $4fff, $3695, $0020 ; entry 7

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map0AScreens0::
    dfar Map0AScreens0_Y0X0 ; entry 0

Map0AAttrs0::
    dfar Map0AAttrs0_Y0X0 ; entry 0

; LZSS-compressed: 209 bytes that expand to 360 (E-0016, E-0017)
Map0AScreens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $124722, $D1

; LZSS-compressed: 63 bytes that expand to 360 (E-0016, E-0017)
Map0AAttrs0_Y0X0::
    db $68, $01, $06, $03, $03, $03, $03, $06, $f4, $fc, $06, $00, $0f, $41, $01, $06
    db $68, $07, $06, $10, $02, $05, $05, $05, $05, $02, $02, $04, $04, $02, $02, $02
    db $02, $06, $7a, $00, $06, $76, $0f, $05, $06, $82, $00, $06, $a2, $08, $06, $9e
    db $0f, $4d, $06, $d6, $0f, $1d, $06, $10, $04, $06, $3c, $1a, $06, $44, $1c

; compressed tileset of map $13 (the first map record using it)
; LZSS-compressed: 659 bytes that expand to 960 (E-0016, E-0017)
Map13Tileset::
    INCBIN "dwm2-cobi-us.gbc", $124832, $293

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map13Palettes::
BGPaletteBufferData_49_4AC5::
    dw $7d86, $7fff, $7fe1, $0000 ; entry 0
    dw $012f, $031d, $01d8, $0000 ; entry 1
    dw $012f, $67ff, $0214, $0000 ; entry 2
    dw $158f, $4298, $2a13, $0020 ; entry 3
    dw $158f, $4fff, $03e2, $0000 ; entry 4
    dw $49ae, $7fff, $4acd, $0000 ; entry 5
    dw $29ce, $4fff, $3695, $0020 ; entry 6
    dw $29ce, $4fff, $3695, $18ea ; entry 7

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map13Screens0::
    dfar Map13Screens0_Y0X0 ; entry 0

Map13Attrs0::
    dfar Map13Attrs0_Y0X0 ; entry 0

; LZSS-compressed: 191 bytes that expand to 360 (E-0016, E-0017)
Map13Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $124B0B, $BF

; LZSS-compressed: 81 bytes that expand to 360 (E-0016, E-0017)
Map13Attrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $124BCA, $51

; compressed tileset of map $1A (the first map record using it)
; LZSS-compressed: 1696 bytes that expand to 1984 (E-0016, E-0017)
Map1ATileset::
    INCBIN "dwm2-cobi-us.gbc", $124C1B, $6A0

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map1APalettes::
BGPaletteBufferData_49_52BB::
    dw $7d86, $7fff, $7f26, $0000 ; entry 0
    dw $012f, $031d, $01d8, $0000 ; entry 1
    dw $01e0, $031d, $0214, $0020 ; entry 2
    dw $7d86, $1bf0, $02c0, $0000 ; entry 3
    dw $01e0, $1bf0, $02c0, $0000 ; entry 4
    dw $158f, $1bf0, $2a13, $0000 ; entry 5
    dw $012f, $1bf0, $02c0, $0000 ; entry 6
    dw $0020, $0020, $0020, $0020 ; entry 7

; 3 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map1AScreens0::
    dfar Map1AScreens0_Y0X0 ; entry 0
    dfar Map1AScreens0_Y0X1 ; entry 1
    dfar Map1AScreens0_Y0X2 ; entry 2

Map1AAttrs0::
    dfar Map1AAttrs0_Y0X0 ; entry 0
    dfar Map1AAttrs0_Y0X1 ; entry 1
    dfar Map1AAttrs0_Y0X2 ; entry 2

Map1AScreens5::
    dfar Map1AScreens0_Y0X0 ; entry 0
    dfar Map1AScreens0_Y0X1 ; entry 1
    dfar Map1AScreens5_Y0X2 ; entry 2

Map1AAttrs5::
    dfar Map1AAttrs0_Y0X0 ; entry 0
    dfar Map1AAttrs0_Y0X1 ; entry 1
    dfar Map1AAttrs5_Y0X2 ; entry 2

; LZSS-compressed: 250 bytes that expand to 360 (E-0016, E-0017)
Map1AScreens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $12531F, $FA

; LZSS-compressed: 274 bytes that expand to 360 (E-0016, E-0017)
Map1AScreens0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $125419, $112

; LZSS-compressed: 251 bytes that expand to 360 (E-0016, E-0017)
Map1AScreens0_Y0X2::
    INCBIN "dwm2-cobi-us.gbc", $12552B, $FB

; LZSS-compressed: 263 bytes that expand to 360 (E-0016, E-0017)
Map1AScreens5_Y0X2::
    INCBIN "dwm2-cobi-us.gbc", $125626, $107

; LZSS-compressed: 163 bytes that expand to 360 (E-0016, E-0017)
Map1AAttrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $12572D, $A3

; LZSS-compressed: 147 bytes that expand to 360 (E-0016, E-0017)
Map1AAttrs0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $1257D0, $93

; LZSS-compressed: 153 bytes that expand to 360 (E-0016, E-0017)
Map1AAttrs0_Y0X2::
    INCBIN "dwm2-cobi-us.gbc", $125863, $99

; LZSS-compressed: 164 bytes that expand to 360 (E-0016, E-0017)
Map1AAttrs5_Y0X2::
    INCBIN "dwm2-cobi-us.gbc", $1258FC, $A4

; compressed tileset of map $0B (the first map record using it)
; LZSS-compressed: 1607 bytes that expand to 2048 (E-0016, E-0017)
Map0BTileset::
    INCBIN "dwm2-cobi-us.gbc", $1259A0, $647

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map0BPalettes::
    dw $5400, $7fff, $3071, $0000 ; entry 0
    dw $012f, $031d, $01d8, $0000 ; entry 1
    dw $306a, $46bf, $3071, $0020 ; entry 2
    dw $158f, $4298, $2a13, $0020 ; entry 3
    dw $306a, $6b79, $3071, $0000 ; entry 4
    dw $29ce, $4fff, $3695, $0020 ; entry 5
    dw $001f, $46bf, $3071, $0020 ; entry 6
    dw $0b02, $46bf, $3071, $0020 ; entry 7

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map0BScreens0::
    dfar Map0BScreens0_Y0X0 ; entry 0

Map0BAttrs0::
    dfar Map0BAttrs0_Y0X0 ; entry 0

; LZSS-compressed: 271 bytes that expand to 360 (E-0016, E-0017)
Map0BScreens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $12602D, $10F

; LZSS-compressed: 150 bytes that expand to 360 (E-0016, E-0017)
Map0BAttrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $12613C, $96

; compressed tileset of map $22 (the first map record using it)
; LZSS-compressed: 650 bytes that expand to 1088 (E-0016, E-0017)
Map22Tileset::
    INCBIN "dwm2-cobi-us.gbc", $1261D2, $28A

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map22Palettes::
    dw $01d5, $7fff, $029a, $0000 ; entry 0
    dw $01d3, $3f7f, $029a, $0000 ; entry 1
    dw $012f, $029a, $01d5, $0000 ; entry 2
    dw $0248, $3f7f, $029a, $0000 ; entry 3
    dw $498c, $7fff, $6652, $0000 ; entry 4
    dw $001b, $2bff, $023f, $0000 ; entry 5
    dw $218c, $4f18, $3a52, $0000 ; entry 6
    dw $218c, $4f18, $3a52, $0000 ; entry 7

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map22Screens0::
    dfar Map22Screens0_Y0X0 ; entry 0

Map22Attrs0::
    dfar Map22Attrs0_Y0X0 ; entry 0

; LZSS-compressed: 209 bytes that expand to 360 (E-0016, E-0017)
Map22Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1264A2, $D1

; LZSS-compressed: 110 bytes that expand to 360 (E-0016, E-0017)
Map22Attrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $126573, $6E

; compressed tileset of map $23 (the first map record using it)
; LZSS-compressed: 676 bytes that expand to 1088 (E-0016, E-0017)
Map23Tileset::
    INCBIN "dwm2-cobi-us.gbc", $1265E1, $2A4

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map23Palettes::
    dw $01d5, $7fff, $029a, $0000 ; entry 0
    dw $01d3, $3f7f, $029a, $0000 ; entry 1
    dw $012f, $029a, $01d5, $0000 ; entry 2
    dw $0248, $3f7f, $029a, $0000 ; entry 3
    dw $498c, $7fff, $6652, $0000 ; entry 4
    dw $001b, $2bff, $023f, $0000 ; entry 5
    dw $218c, $4f18, $3a52, $0000 ; entry 6
    dw $218c, $4f18, $3a52, $0000 ; entry 7

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map23Screens0::
    dfar Map23Screens0_Y0X0 ; entry 0

Map23Attrs0::
    dfar Map23Attrs0_Y0X0 ; entry 0

; LZSS-compressed: 192 bytes that expand to 360 (E-0016, E-0017)
Map23Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1268CB, $C0

; LZSS-compressed: 91 bytes that expand to 360 (E-0016, E-0017)
Map23Attrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $12698B, $5B

; compressed tileset of map $24 (the first map record using it)
; LZSS-compressed: 1312 bytes that expand to 1776 (E-0016, E-0017)
Map24Tileset::
    INCBIN "dwm2-cobi-us.gbc", $1269E6, $520

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map24Palettes::
    dw $014f, $7fff, $029a, $0000 ; entry 0
    dw $0110, $3f7f, $0214, $0042 ; entry 1
    dw $0308, $3f7f, $029a, $0042 ; entry 2
    dw $2111, $3a5c, $21b8, $0044 ; entry 3
    dw $318c, $6318, $4a52, $0842 ; entry 4
    dw $7d68, $7fff, $7f32, $0000 ; entry 5
    dw $001b, $2bff, $023f, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map24Screens0::
    dfar Map24Screens0_Y0X0 ; entry 0
    dfar Map24Screens0_Y0X1 ; entry 1
    dfar Map24Screens0_Y1X0 ; entry 2
    dfar Map24Screens0_Y1X1 ; entry 3

Map24Attrs0::
    dfar Map24Attrs0_Y0X0 ; entry 0
    dfar Map24Attrs0_Y0X1 ; entry 1
    dfar Map24Attrs0_Y1X0 ; entry 2
    dfar Map24Attrs0_Y1X1 ; entry 3

; LZSS-compressed: 241 bytes that expand to 360 (E-0016, E-0017)
Map24Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $126F5E, $F1

; LZSS-compressed: 191 bytes that expand to 360 (E-0016, E-0017)
Map24Screens0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $12704F, $BF

; LZSS-compressed: 227 bytes that expand to 360 (E-0016, E-0017)
Map24Screens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $12710E, $E3

; LZSS-compressed: 230 bytes that expand to 360 (E-0016, E-0017)
Map24Screens0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $1271F1, $E6

; LZSS-compressed: 81 bytes that expand to 360 (E-0016, E-0017)
Map24Attrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1272D7, $51

; LZSS-compressed: 82 bytes that expand to 360 (E-0016, E-0017)
Map24Attrs0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $127328, $52

; LZSS-compressed: 79 bytes that expand to 360 (E-0016, E-0017)
Map24Attrs0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $12737A, $4F

; LZSS-compressed: 75 bytes that expand to 360 (E-0016, E-0017)
Map24Attrs0_Y1X1::
    INCBIN "dwm2-cobi-us.gbc", $1273C9, $4B

; compressed tileset of map $25 (the first map record using it)
; LZSS-compressed: 1170 bytes that expand to 1536 (E-0016, E-0017)
Map25Tileset::
    INCBIN "dwm2-cobi-us.gbc", $127414, $492

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map25Palettes::
    dw $0173, $7fff, $6b2b, $0000 ; entry 0
    dw $01d3, $3f7f, $029a, $0042 ; entry 1
    dw $012f, $3f7f, $01da, $0000 ; entry 2
    dw $2111, $3a5c, $21b8, $0044 ; entry 3
    dw $18d0, $3fff, $01da, $0042 ; entry 4
    dw $001b, $2bff, $023f, $0000 ; entry 5
    dw $0308, $3f7f, $029a, $0042 ; entry 6
    dw $218c, $4f18, $3a52, $0000 ; entry 7

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map25Screens0::
    dfar Map25Screens0_Y0X0 ; entry 0
    dfar Map25Screens0_Y0X1 ; entry 1

Map25Attrs0::
    dfar Map25Attrs0_Y0X0 ; entry 0
    dfar Map25Attrs0_Y0X1 ; entry 1

; LZSS-compressed: 232 bytes that expand to 360 (E-0016, E-0017)
Map25Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1278F2, $E8

; LZSS-compressed: 244 bytes that expand to 360 (E-0016, E-0017)
Map25Screens0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $1279DA, $F4

; LZSS-compressed: 79 bytes that expand to 360 (E-0016, E-0017)
Map25Attrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $127ACE, $4F

; LZSS-compressed: 98 bytes that expand to 360 (E-0016, E-0017)
Map25Attrs0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $127B1D, $62

; compressed tileset of map $2D (the first map record using it)
; LZSS-compressed: 751 bytes that expand to 880 (E-0016, E-0017)
Map2DTileset::
    INCBIN "dwm2-cobi-us.gbc", $127B7F, $2EF

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map2DPalettes::
    dw $318c, $7fff, $4a52, $0000 ; entry 0
    dw $012f, $5ad6, $029a, $0042 ; entry 1
    dw $00eb, $5ad6, $318c, $0000 ; entry 2
    dw $2111, $3a5c, $21b8, $0044 ; entry 3
    dw $0000, $0000, $0000, $0000 ; entry 4
    dw $0000, $0000, $0000, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map2DScreens0::
    dfar Map2DScreens0_Y0X0 ; entry 0

Map2DAttrs0::
    dfar Map2DAttrs0_Y0X0 ; entry 0

; LZSS-compressed: 223 bytes that expand to 360 (E-0016, E-0017)
Map2DScreens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $127EB4, $DF

; LZSS-compressed: 91 bytes that expand to 360 (E-0016, E-0017)
Map2DAttrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $127F93, $5B
    ds $12, $00
