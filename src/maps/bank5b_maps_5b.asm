; ROM bank $5B: map screens, attributes and tilesets
; The annotated listing of this bank is build/listing/bank5b.asm.

SECTION "Bank 5B", ROMX
    db $5b

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map4CPalettes::
    dw $218c, $7fff, $5ab1, $0000 ; entry 0
    dw $00ed, $22ba, $11d4, $0000 ; entry 1
    dw $012f, $6b2b, $7d48, $0000 ; entry 2
    dw $0160, $7fff, $5ab1, $0000 ; entry 3
    dw $1415, $3f7f, $01da, $0000 ; entry 4
    dw $001b, $2bff, $023f, $0000 ; entry 5
    dw $1415, $7fff, $01da, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

Map53Palettes::
    dw $1415, $7fff, $3c1f, $0000 ; entry 0
    dw $012f, $6b2b, $7d48, $0000 ; entry 1
    dw $184c, $0217, $1116, $0000 ; entry 2
    dw $0854, $029e, $315f, $0000 ; entry 3
    dw $001b, $2bff, $023f, $0000 ; entry 4
    dw $0186, $3f3d, $02af, $0084 ; entry 5
    dw $0160, $22ba, $02c0, $0000 ; entry 6
    dw $01c4, $67f8, $4b00, $0000 ; entry 7

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map55Screens0::
    dfar Map55Screens0_Y0X0 ; entry 0
    dfar Map55Screens0_Y0X1 ; entry 1

Map55Attrs0::
    dfar Map55Attrs0_Y0X0 ; entry 0
    dfar Map55Attrs0_Y0X1 ; entry 1

; LZSS-compressed: 163 bytes that expand to 360 (E-0016, E-0017)
Map55Screens0_Y0X0::
    INCBIN "maps/map55/screens0_y0_x0.lz"

; LZSS-compressed: 191 bytes that expand to 360 (E-0016, E-0017)
Map55Screens0_Y0X1::
    INCBIN "maps/map55/screens0_y0_x1.lz"

; LZSS-compressed: 66 bytes that expand to 360 (E-0016, E-0017)
Map55Attrs0_Y0X0::
    INCBIN "maps/map55/attrs0_y0_x0.lz"

Map55Attrs0_Y0X1::
    INCBIN "maps/map55/attrs0_y0_x1.lz"

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map66Screens0::
    dfar Map66Screens0_Y0X0 ; entry 0
    dfar Map66Screens0_Y0X1 ; entry 1
    dfar Map66Screens0_Y1X0 ; entry 2
    dfar Map66Screens0_Y1X1 ; entry 3

Map66Attrs0::
    dfar Map66Attrs0_Y0X0 ; entry 0
    dfar Map66Attrs0_Y0X1 ; entry 1
    dfar Map66Attrs0_Y1X0 ; entry 2
    dfar Map66Attrs0_Y1X1 ; entry 3

; LZSS-compressed: 154 bytes that expand to 360 (E-0016, E-0017)
Map66Screens0_Y0X0::
    INCBIN "maps/map66/screens0_y0_x0.lz"

; LZSS-compressed: 164 bytes that expand to 360 (E-0016, E-0017)
Map66Screens0_Y0X1::
    INCBIN "maps/map66/screens0_y0_x1.lz"

; LZSS-compressed: 172 bytes that expand to 360 (E-0016, E-0017)
Map66Screens0_Y1X0::
    INCBIN "maps/map66/screens0_y1_x0.lz"

; LZSS-compressed: 165 bytes that expand to 360 (E-0016, E-0017)
Map66Screens0_Y1X1::
    INCBIN "maps/map66/screens0_y1_x1.lz"

; LZSS-compressed: 66 bytes that expand to 360 (E-0016, E-0017)
Map66Attrs0_Y0X0::
    INCBIN "maps/map66/attrs0_y0_x0.lz"

; LZSS-compressed: 75 bytes that expand to 360 (E-0016, E-0017)
Map66Attrs0_Y0X1::
    INCBIN "maps/map66/attrs0_y0_x1.lz"

; LZSS-compressed: 77 bytes that expand to 360 (E-0016, E-0017)
Map66Attrs0_Y1X0::
    INCBIN "maps/map66/attrs0_y1_x0.lz"

; LZSS-compressed: 105 bytes that expand to 360 (E-0016, E-0017)
Map66Attrs0_Y1X1::
    INCBIN "maps/map66/attrs0_y1_x1.lz"

; compressed tileset of map $B9 (the first map record using it)
; LZSS-compressed: 1289 bytes that expand to 1536 (E-0016, E-0017)
MapB9Tileset::
    INCBIN "maps/mapb9/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
MapB9Palettes::
    dw $212a, $7fff, $31cf, $0000 ; entry 0
    dw $0111, $3f7f, $0175, $0009 ; entry 1
    dw $01a0, $3f7f, $03e7, $00a0 ; entry 2
    dw $49ae, $7fff, $4acd, $0000 ; entry 3
    dw $48c6, $5254, $796b, $0000 ; entry 4
    dw $2111, $3a5c, $21b8, $0044 ; entry 5
    dw $001b, $2bff, $023f, $0000 ; entry 6
    dw $0000, $0044, $0000, $0044 ; entry 7

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
MapB9Screens0::
    dfar MapB9Screens0_Y0X0 ; entry 0
    dfar MapB9Screens0_Y0X1 ; entry 1
    dfar MapB9Screens0_Y1X0 ; entry 2
    dfar MapB9Screens0_Y1X1 ; entry 3

MapB9Attrs0::
    dfar MapB9Attrs0_Y0X0 ; entry 0
    dfar MapB9Attrs0_Y0X1 ; entry 1
    dfar MapB9Attrs0_Y1X0 ; entry 2
    dfar MapB9Attrs0_Y1X1 ; entry 3

; LZSS-compressed: 240 bytes that expand to 360 (E-0016, E-0017)
MapB9Screens0_Y0X0::
    INCBIN "maps/mapb9/screens0_y0_x0.lz"

; LZSS-compressed: 231 bytes that expand to 360 (E-0016, E-0017)
MapB9Screens0_Y0X1::
    INCBIN "maps/mapb9/screens0_y0_x1.lz"

; LZSS-compressed: 229 bytes that expand to 360 (E-0016, E-0017)
MapB9Screens0_Y1X0::
    INCBIN "maps/mapb9/screens0_y1_x0.lz"

; LZSS-compressed: 253 bytes that expand to 360 (E-0016, E-0017)
MapB9Screens0_Y1X1::
    INCBIN "maps/mapb9/screens0_y1_x1.lz"

; LZSS-compressed: 99 bytes that expand to 360 (E-0016, E-0017)
MapB9Attrs0_Y0X0::
    INCBIN "maps/mapb9/attrs0_y0_x0.lz"

; LZSS-compressed: 119 bytes that expand to 360 (E-0016, E-0017)
MapB9Attrs0_Y0X1::
    INCBIN "maps/mapb9/attrs0_y0_x1.lz"

; LZSS-compressed: 122 bytes that expand to 360 (E-0016, E-0017)
MapB9Attrs0_Y1X0::
    INCBIN "maps/mapb9/attrs0_y1_x0.lz"

; LZSS-compressed: 145 bytes that expand to 360 (E-0016, E-0017)
MapB9Attrs0_Y1X1::
    INCBIN "maps/mapb9/attrs0_y1_x1.lz"

; compressed tileset of map $BA (the first map record using it)
; LZSS-compressed: 1080 bytes that expand to 1264 (E-0016, E-0017)
MapBATileset::
    INCBIN "maps/mapba/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
MapBAPalettes::
    dw $218c, $7fff, $66b3, $0000 ; entry 0
    dw $01d3, $3f7f, $029a, $0044 ; entry 1
    dw $012f, $029a, $01d5, $0044 ; entry 2
    dw $012f, $3f7f, $1d78, $0063 ; entry 3
    dw $2111, $3a5c, $21b8, $0044 ; entry 4
    dw $31cf, $7da0, $5ad6, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
MapBAScreens0::
    dfar MapBAScreens0_Y0X0 ; entry 0
    dfar MapBAScreens0_Y1X0 ; entry 1

MapBAAttrs0::
    dfar MapBAAttrs0_Y0X0 ; entry 0
    dfar MapBAAttrs0_Y1X0 ; entry 1

; LZSS-compressed: 214 bytes that expand to 360 (E-0016, E-0017)
MapBAScreens0_Y0X0::
    INCBIN "maps/mapba/screens0_y0_x0.lz"

; LZSS-compressed: 272 bytes that expand to 360 (E-0016, E-0017)
MapBAScreens0_Y1X0::
    INCBIN "maps/mapba/screens0_y1_x0.lz"

; LZSS-compressed: 75 bytes that expand to 360 (E-0016, E-0017)
MapBAAttrs0_Y0X0::
    INCBIN "maps/mapba/attrs0_y0_x0.lz"

; LZSS-compressed: 85 bytes that expand to 360 (E-0016, E-0017)
MapBAAttrs0_Y1X0::
    INCBIN "maps/mapba/attrs0_y1_x0.lz"

; compressed tileset of map $BB (the first map record using it)
; LZSS-compressed: 485 bytes that expand to 512 (E-0016, E-0017)
MapBBTileset::
    INCBIN "maps/mapbb/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
MapBBPalettes::
    dw $192c, $7fff, $31cf, $0000 ; entry 0
    dw $0175, $5b7f, $1e7e, $0009 ; entry 1
    dw $01c4, $3f7f, $03e7, $00a0 ; entry 2
    dw $192c, $7fff, $03e7, $0000 ; entry 3
    dw $1415, $4fff, $3c1f, $0000 ; entry 4
    dw $31cf, $7fff, $5ad6, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $04e6, $7ff1, $03e7, $0004 ; entry 7

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
MapBBScreens0::
    dfar MapBBScreens0_Y0X0 ; entry 0
    dfar MapBBScreens0_Y1X0 ; entry 1

MapBBAttrs0::
    dfar MapBBAttrs0_Y0X0 ; entry 0
    dfar MapBBAttrs0_Y1X0 ; entry 1

MapBBScreens1::
    dfar MapBBScreens1_Y0X0 ; entry 0
    dfar MapBBScreens0_Y1X0 ; entry 1

MapBBAttrs1::
    dfar MapBBAttrs1_Y0X0 ; entry 0
    dfar MapBBAttrs0_Y1X0 ; entry 1

; LZSS-compressed: 276 bytes that expand to 360 (E-0016, E-0017)
MapBBScreens0_Y0X0::
    INCBIN "maps/mapbb/screens0_y0_x0.lz"

MapBBScreens1_Y0X0::
    INCBIN "maps/mapbb/screens1_y0_x0.lz"

; LZSS-compressed: 191 bytes that expand to 360 (E-0016, E-0017)
MapBBScreens0_Y1X0::
    INCBIN "maps/mapbb/screens0_y1_x0.lz"

; LZSS-compressed: 84 bytes that expand to 360 (E-0016, E-0017)
MapBBAttrs0_Y0X0::
    INCBIN "maps/mapbb/attrs0_y0_x0.lz"

MapBBAttrs1_Y0X0::
    INCBIN "maps/mapbb/attrs1_y0_x0.lz"

; LZSS-compressed: 20 bytes that expand to 360 (E-0016, E-0017)
MapBBAttrs0_Y1X0::
    db $68, $01, $00, $02, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

; compressed tileset of map $BC (the first map record using it)
; LZSS-compressed: 675 bytes that expand to 880 (E-0016, E-0017)
MapBCTileset::
    INCBIN "maps/mapbc/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
MapBCPalettes::
    dw $01d5, $7fff, $029a, $0000 ; entry 0
    dw $01d3, $3f7f, $029a, $0000 ; entry 1
    dw $0130, $029a, $01d5, $0008 ; entry 2
    dw $0248, $3f7f, $029a, $0000 ; entry 3
    dw $498c, $7fff, $6652, $0000 ; entry 4
    dw $001b, $2bff, $023f, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
MapBCScreens0::
    dfar MapBCScreens0_Y0X0 ; entry 0

MapBCAttrs0::
    dfar MapBCAttrs0_Y0X0 ; entry 0

; LZSS-compressed: 192 bytes that expand to 360 (E-0016, E-0017)
MapBCScreens0_Y0X0::
    INCBIN "maps/mapbc/screens0_y0_x0.lz"

; LZSS-compressed: 87 bytes that expand to 360 (E-0016, E-0017)
MapBCAttrs0_Y0X0::
    INCBIN "maps/mapbc/attrs0_y0_x0.lz"

; compressed tileset of map $BD (the first map record using it)
; LZSS-compressed: 676 bytes that expand to 1440 (E-0016, E-0017)
MapBDTileset::
    INCBIN "maps/mapbd/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
MapBDPalettes::
    dw $7da0, $7fff, $7fe0, $0063 ; entry 0
    dw $150b, $6bff, $4d8c, $0044 ; entry 1
    dw $4d8c, $6bff, $5e73, $0000 ; entry 2
    dw $1415, $4fff, $3c1f, $0000 ; entry 3
    dw $0000, $0000, $0000, $0000 ; entry 4
    dw $218c, $6bff, $029a, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
MapBDScreens0::
    dfar MapBDScreens0_Y0X0 ; entry 0

MapBDAttrs0::
    dfar MapBDAttrs0_Y0X0 ; entry 0

; LZSS-compressed: 206 bytes that expand to 360 (E-0016, E-0017)
MapBDScreens0_Y0X0::
    INCBIN "maps/mapbd/screens0_y0_x0.lz"

; LZSS-compressed: 42 bytes that expand to 360 (E-0016, E-0017)
MapBDAttrs0_Y0X0::
    db $68, $01, $00, $02, $00, $00, $0f, $3e, $05, $05, $00, $50, $00, $00, $56, $02
    db $00, $50, $02, $00, $50, $0f, $2d, $00, $a2, $0a, $00, $9e, $0f, $07, $00, $54
    db $0f, $4d, $00, $a0, $0f, $03, $00, $00, $0f, $13

MapBEScreens0::
    dfar MapBEScreens0_Y0X0 ; entry 0

MapBEAttrs0::
    dfar MapBEAttrs0_Y0X0 ; entry 0

; LZSS-compressed: 128 bytes that expand to 360 (E-0016, E-0017)
MapBEScreens0_Y0X0::
    INCBIN "maps/mapbe/screens0_y0_x0.lz"

; LZSS-compressed: 53 bytes that expand to 360 (E-0016, E-0017)
MapBEAttrs0_Y0X0::
    db $68, $01, $04, $02, $04, $00, $0f, $3e, $05, $04, $52, $0b, $04, $4e, $0f, $09
    db $00, $00, $01, $01, $03, $03, $00, $00, $04, $72, $0f, $0f, $04, $fa, $f2, $04
    db $9a, $0f, $35, $04, $56, $0f, $15, $04, $56, $0f, $11, $04, $4c, $06, $04, $42
    db $0f, $01, $04, $00, $04

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
MapBFScreens0::
    dfar MapBFScreens0_Y0X0 ; entry 0
    dfar MapBFScreens0_Y0X1 ; entry 1
    dfar MapBFScreens0_Y1X0 ; entry 2
    dfar MapBFScreens0_Y1X1 ; entry 3

MapBFAttrs0::
    dfar MapBFAttrs0_Y0X0 ; entry 0
    dfar MapBFAttrs0_Y0X1 ; entry 1
    dfar MapBFAttrs0_Y1X0 ; entry 2
    dfar MapBFAttrs0_Y1X1 ; entry 3

MapBFScreens2::
    dfar MapBFScreens0_Y0X0 ; entry 0
    dfar MapBFScreens2_Y0X1 ; entry 1
    dfar MapBFScreens0_Y1X0 ; entry 2
    dfar MapBFScreens0_Y1X1 ; entry 3

MapBFAttrs2::
    dfar MapBFAttrs0_Y0X0 ; entry 0
    dfar MapBFAttrs2_Y0X1 ; entry 1
    dfar MapBFAttrs0_Y1X0 ; entry 2
    dfar MapBFAttrs0_Y1X1 ; entry 3

; LZSS-compressed: 66 bytes that expand to 360 (E-0016, E-0017)
MapBFScreens0_Y0X0::
    INCBIN "maps/mapbf/screens0_y0_x0.lz"

; LZSS-compressed: 98 bytes that expand to 360 (E-0016, E-0017)
MapBFScreens0_Y0X1::
    INCBIN "maps/mapbf/screens0_y0_x1.lz"

MapBFScreens2_Y0X1::
    INCBIN "maps/mapbf/screens2_y0_x1.lz"

; LZSS-compressed: 43 bytes that expand to 360 (E-0016, E-0017)
MapBFScreens0_Y1X0::
    db $68, $01, $00, $08, $09, $40, $41, $00, $02, $0c, $18, $19, $50, $51, $00, $16
    db $0c, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $45, $20, $21, $02
    db $03, $00, $42, $1c, $30, $31, $12, $13, $00, $56, $1c

; LZSS-compressed: 89 bytes that expand to 360 (E-0016, E-0017)
MapBFScreens0_Y1X1::
    INCBIN "maps/mapbf/screens0_y1_x1.lz"

; LZSS-compressed: 24 bytes that expand to 360 (E-0016, E-0017)
MapBFAttrs0_Y0X0::
    db $68, $01, $00, $02, $00, $00, $0f, $3e, $05, $00, $52, $0d, $00, $50, $0f, $4d
    db $00, $b0, $0f, $4d, $00, $fc, $0f, $31

; LZSS-compressed: 39 bytes that expand to 360 (E-0016, E-0017)
MapBFAttrs0_Y0X1::
    db $68, $01, $00, $02, $00, $00, $0f, $3c, $05, $00, $50, $01, $00, $4c, $04, $03
    db $03, $00, $54, $00, $00, $50, $0f, $0f, $00, $52, $02, $00, $78, $0f, $4d, $00
    db $d8, $0f, $4d, $00, $fc, $0f, $09

MapBFAttrs2_Y0X1::
    db $68, $01, $00, $02, $00, $00, $0f, $3c, $05, $00, $50, $01, $00, $4c, $04, $03
    db $03, $00, $54, $00, $00, $50, $0f, $0f, $00, $52, $02, $00, $78, $0f, $4d, $00
    db $d8, $0f, $4d, $00, $fc, $0f, $09

; LZSS-compressed: 28 bytes that expand to 360 (E-0016, E-0017)
MapBFAttrs0_Y1X0::
    db $68, $01, $00, $02, $02, $05, $00, $02, $0d, $00, $00, $0f, $4d, $00, $60, $0f
    db $4d, $00, $c0, $0f, $4d, $00, $d0, $0a, $00, $40, $1f, $13

; LZSS-compressed: 45 bytes that expand to 360 (E-0016, E-0017)
MapBFAttrs0_Y1X1::
    db $68, $01, $00, $05, $00, $00, $01, $02, $02, $02, $02, $00, $00, $02, $00, $04
    db $00, $00, $00, $0f, $4d, $00, $10, $06, $00, $78, $08, $00, $76, $0f, $35, $01
    db $01, $00, $c0, $0f, $13, $00, $6e, $0f, $33, $00, $3e, $1f, $15

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
MapC0Screens0::
    dfar MapC0Screens0_Y0X0 ; entry 0
    dfar MapC0Screens0_Y0X1 ; entry 1
    dfar MapC0Screens0_Y1X0 ; entry 2
    dfar MapC0Screens0_Y1X1 ; entry 3

MapC0Attrs0::
    dfar MapC0Attrs0_Y0X0 ; entry 0
    dfar MapC0Attrs0_Y0X1 ; entry 1
    dfar MapC0Attrs0_Y1X0 ; entry 2
    dfar MapC0Attrs0_Y1X1 ; entry 3

; LZSS-compressed: 68 bytes that expand to 360 (E-0016, E-0017)
MapC0Screens0_Y0X0::
    INCBIN "maps/mapc0/screens0_y0_x0.lz"

; LZSS-compressed: 154 bytes that expand to 360 (E-0016, E-0017)
MapC0Screens0_Y0X1::
    INCBIN "maps/mapc0/screens0_y0_x1.lz"

; LZSS-compressed: 129 bytes that expand to 360 (E-0016, E-0017)
MapC0Screens0_Y1X0::
    INCBIN "maps/mapc0/screens0_y1_x0.lz"

MapC0Screens0_Y1X1::
    INCBIN "maps/mapc0/screens0_y1_x1.lz"

; LZSS-compressed: 31 bytes that expand to 360 (E-0016, E-0017)
MapC0Attrs0_Y0X0::
    db $68, $01, $00, $02, $00, $00, $0f, $3e, $05, $00, $52, $0d, $00, $50, $0f, $4d
    db $00, $b0, $0f, $4d, $00, $e8, $0f, $17, $00, $4a, $0f, $01, $00, $00, $02

; LZSS-compressed: 49 bytes that expand to 360 (E-0016, E-0017)
MapC0Attrs0_Y0X1::
    db $68, $01, $00, $02, $00, $00, $0f, $3c, $05, $00, $50, $01, $00, $4c, $04, $01
    db $01, $00, $54, $00, $00, $50, $0f, $0f, $00, $52, $02, $00, $78, $0f, $33, $00
    db $4c, $04, $00, $c6, $0f, $31, $00, $18, $18, $00, $16, $1f, $03, $00, $00, $0f
    db $15

; LZSS-compressed: 57 bytes that expand to 360 (E-0016, E-0017)
MapC0Attrs0_Y1X0::
    db $68, $01, $01, $02, $02, $05, $01, $02, $07, $02, $01, $0e, $03, $01, $02, $0f
    db $35, $01, $08, $04, $01, $52, $0f, $2b, $00, $00, $01, $92, $0f, $15, $01, $a4
    db $0a, $01, $c8, $0f, $09, $01, $a4, $08, $01, $f0, $0f, $03, $03, $03, $01, $f8
    db $f4, $01, $10, $1f, $0b, $01, $40, $1f, $13

; LZSS-compressed: 28 bytes that expand to 360 (E-0016, E-0017)
MapC0Attrs0_Y1X1::
    db $68, $01, $00, $02, $00, $00, $0f, $3c, $05, $00, $50, $0d, $00, $4e, $0f, $4d
    db $00, $ae, $0f, $4d, $00, $d2, $0f, $0b, $00, $00, $0f, $15

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
MapC1Screens0::
    dfar MapC1Screens0_Y0X0 ; entry 0
    dfar MapC1Screens0_Y0X1 ; entry 1
    dfar MapC1Screens0_Y1X0 ; entry 2
    dfar MapC1Screens0_Y1X1 ; entry 3

MapC1Attrs0::
    dfar MapC1Attrs0_Y0X0 ; entry 0
    dfar MapC1Attrs0_Y0X1 ; entry 1
    dfar MapC1Attrs0_Y1X0 ; entry 2
    dfar MapC1Attrs0_Y1X1 ; entry 3

; LZSS-compressed: 173 bytes that expand to 360 (E-0016, E-0017)
MapC1Screens0_Y0X0::
    INCBIN "maps/mapc1/screens0_y0_x0.lz"

; LZSS-compressed: 166 bytes that expand to 360 (E-0016, E-0017)
MapC1Screens0_Y0X1::
    INCBIN "maps/mapc1/screens0_y0_x1.lz"

; LZSS-compressed: 143 bytes that expand to 360 (E-0016, E-0017)
MapC1Screens0_Y1X0::
    INCBIN "maps/mapc1/screens0_y1_x0.lz"

; LZSS-compressed: 155 bytes that expand to 360 (E-0016, E-0017)
MapC1Screens0_Y1X1::
    INCBIN "maps/mapc1/screens0_y1_x1.lz"

; LZSS-compressed: 62 bytes that expand to 360 (E-0016, E-0017)
MapC1Attrs0_Y0X0::
    db $68, $01, $00, $02, $00, $00, $0f, $40, $05, $00, $54, $05, $01, $01, $05, $05
    db $00, $4e, $0f, $11, $00, $54, $00, $00, $76, $0f, $0f, $00, $48, $0f, $01, $00
    db $48, $0e, $00, $46, $0f, $01, $00, $46, $0e, $00, $ec, $0c, $00, $f4, $0f, $0b
    db $00, $84, $06, $00, $1c, $1f, $0b, $00, $ea, $0f, $03, $00, $00, $00

; LZSS-compressed: 31 bytes that expand to 360 (E-0016, E-0017)
MapC1Attrs0_Y0X1::
    db $68, $01, $00, $02, $00, $00, $0f, $42, $05, $00, $56, $05, $00, $4c, $0f, $4d
    db $00, $70, $0e, $00, $46, $0f, $01, $00, $60, $0f, $47, $00, $c8, $0f, $15

; LZSS-compressed: 44 bytes that expand to 360 (E-0016, E-0017)
MapC1Attrs0_Y1X0::
    db $68, $01, $00, $02, $02, $02, $02, $05, $05, $05, $05, $00, $00, $00, $00, $08
    db $08, $00, $04, $0f, $2d, $00, $54, $04, $00, $4c, $0f, $31, $00, $10, $0f, $35
    db $00, $44, $0f, $05, $00, $f0, $0f, $35, $00, $40, $1f, $09

; LZSS-compressed: 46 bytes that expand to 360 (E-0016, E-0017)
MapC1Attrs0_Y1X1::
    db $68, $01, $00, $02, $00, $00, $01, $05, $05, $05, $05, $00, $00, $02, $00, $0a
    db $06, $00, $06, $0f, $2d, $00, $56, $02, $00, $4c, $0f, $33, $00, $00, $0f, $37
    db $00, $56, $06, $00, $5a, $06, $00, $f0, $0f, $29, $00, $3c, $1f, $15

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
MapC2Screens0::
    dfar MapC2Screens0_Y0X0 ; entry 0
    dfar MapC2Screens0_Y0X1 ; entry 1
    dfar MapC2Screens0_Y1X0 ; entry 2
    dfar MapC2Screens0_Y1X1 ; entry 3

MapC2Attrs0::
    dfar MapC2Attrs0_Y0X0 ; entry 0
    dfar MapC2Attrs0_Y0X1 ; entry 1
    dfar MapC2Attrs0_Y1X0 ; entry 2
    dfar MapC2Attrs0_Y1X1 ; entry 3

; LZSS-compressed: 163 bytes that expand to 360 (E-0016, E-0017)
MapC2Screens0_Y0X0::
    INCBIN "maps/mapc2/screens0_y0_x0.lz"

; LZSS-compressed: 169 bytes that expand to 360 (E-0016, E-0017)
MapC2Screens0_Y0X1::
    INCBIN "maps/mapc2/screens0_y0_x1.lz"

; LZSS-compressed: 175 bytes that expand to 360 (E-0016, E-0017)
MapC2Screens0_Y1X0::
    INCBIN "maps/mapc2/screens0_y1_x0.lz"

; LZSS-compressed: 141 bytes that expand to 360 (E-0016, E-0017)
MapC2Screens0_Y1X1::
    INCBIN "maps/mapc2/screens0_y1_x1.lz"

; LZSS-compressed: 57 bytes that expand to 360 (E-0016, E-0017)
MapC2Attrs0_Y0X0::
    db $68, $01, $00, $02, $00, $00, $0f, $46, $05, $00, $5a, $03, $00, $4e, $0f, $0b
    db $00, $5a, $04, $00, $74, $0f, $0b, $00, $80, $06, $00, $5e, $06, $00, $a6, $0e
    db $00, $a6, $0a, $00, $c6, $0f, $15, $00, $a0, $0f, $19, $00, $a4, $0f, $03, $00
    db $54, $08, $00, $4c, $0f, $01, $00, $00, $00

; LZSS-compressed: 65 bytes that expand to 360 (E-0016, E-0017)
MapC2Attrs0_Y0X1::
    INCBIN "maps/mapc2/attrs0_y0_x1.lz"

; LZSS-compressed: 63 bytes that expand to 360 (E-0016, E-0017)
MapC2Attrs0_Y1X0::
    db $68, $01, $01, $02, $01, $00, $05, $05, $01, $0a, $01, $01, $00, $06, $01, $06
    db $0f, $27, $01, $0a, $02, $01, $54, $04, $01, $4e, $0f, $0b, $01, $fa, $f2, $01
    db $0a, $06, $01, $7c, $0f, $29, $01, $52, $0a, $01, $4c, $0f, $01, $01, $00, $0c
    db $01, $ea, $0f, $0f, $01, $52, $06, $01, $16, $1f, $0d, $01, $3e, $1f, $0b

; LZSS-compressed: 55 bytes that expand to 360 (E-0016, E-0017)
MapC2Attrs0_Y1X1::
    db $68, $01, $00, $02, $00, $00, $0f, $3e, $05, $00, $52, $09, $00, $4c, $0f, $05
    db $00, $52, $04, $03, $03, $00, $6e, $0f, $13, $00, $6c, $0f, $01, $00, $58, $0f
    db $07, $00, $4a, $0f, $01, $00, $4a, $0e, $00, $48, $0f, $01, $00, $48, $0e, $00
    db $46, $0f, $01, $00, $00, $0f, $1f

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
MapC3Screens0::
    dfar MapC3Screens0_Y0X0 ; entry 0
    dfar MapC3Screens0_Y0X1 ; entry 1
    dfar MapC3Screens0_Y1X0 ; entry 2
    dfar MapC3Screens0_Y1X1 ; entry 3

MapC3Attrs0::
    dfar MapC3Attrs0_Y0X0 ; entry 0
    dfar MapC3Attrs0_Y0X1 ; entry 1
    dfar MapC3Attrs0_Y1X0 ; entry 2
    dfar MapC3Attrs0_Y1X1 ; entry 3

; LZSS-compressed: 186 bytes that expand to 360 (E-0016, E-0017)
MapC3Screens0_Y0X0::
    INCBIN "maps/mapc3/screens0_y0_x0.lz"

; LZSS-compressed: 113 bytes that expand to 360 (E-0016, E-0017)
MapC3Screens0_Y0X1::
    INCBIN "maps/mapc3/screens0_y0_x1.lz"

; LZSS-compressed: 165 bytes that expand to 360 (E-0016, E-0017)
MapC3Screens0_Y1X0::
    INCBIN "maps/mapc3/screens0_y1_x0.lz"

MapC3Screens0_Y1X1::
    INCBIN "maps/mapc3/screens0_y1_x1.lz"

; LZSS-compressed: 61 bytes that expand to 360 (E-0016, E-0017)
MapC3Attrs0_Y0X0::
    db $68, $01, $03, $02, $03, $00, $0f, $48, $05, $05, $01, $01, $05, $05, $03, $4e
    db $0f, $11, $00, $00, $03, $74, $0f, $0d, $05, $05, $03, $84, $02, $03, $9c, $0f
    db $0f, $03, $ac, $0c, $03, $ce, $0f, $05, $03, $f8, $02, $03, $ec, $0f, $09, $03
    db $84, $00, $03, $86, $0c, $03, $1c, $1f, $03, $03, $fa, $0f, $0f

; LZSS-compressed: 34 bytes that expand to 360 (E-0016, E-0017)
MapC3Attrs0_Y0X1::
    db $68, $01, $00, $02, $00, $00, $0f, $42, $05, $00, $56, $03, $00, $4a, $0f, $15
    db $00, $5c, $08, $00, $7e, $0f, $4d, $00, $b6, $0f, $21, $00, $4a, $0f, $29, $00
    db $00, $02

; LZSS-compressed: 60 bytes that expand to 360 (E-0016, E-0017)
MapC3Attrs0_Y1X0::
    db $68, $01, $01, $02, $02, $02, $02, $05, $01, $04, $03, $01, $00, $00, $01, $0c
    db $04, $01, $04, $0f, $2d, $00, $00, $01, $08, $0a, $01, $54, $0f, $01, $01, $52
    db $0f, $23, $01, $0a, $06, $01, $a8, $0f, $01, $01, $52, $0f, $1d, $01, $08, $0f
    db $11, $01, $02, $04, $01, $18, $1f, $0f, $01, $40, $1f, $07

MapC3Attrs0_Y1X1::
    db $68, $01, $01, $02, $01, $00, $01, $05, $01, $06, $03, $01, $00, $02, $01, $00
    db $0f, $33, $00, $00, $01, $0a, $0a, $01, $56, $0e, $01, $06, $02, $01, $6e, $0f
    db $0b, $01, $06, $04, $01, $fc, $f0, $01, $98, $0f, $3b, $01, $08, $06, $01, $f0
    db $0f, $09, $01, $08, $08, $01, $18, $1f, $01, $01, $3a, $1f, $15

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
MapC4Screens0::
    dfar MapC4Screens0_Y0X0 ; entry 0

MapC4Attrs0::
    dfar MapC4Attrs0_Y0X0 ; entry 0

; LZSS-compressed: 210 bytes that expand to 360 (E-0016, E-0017)
MapC4Screens0_Y0X0::
    INCBIN "maps/mapc4/screens0_y0_x0.lz"

; LZSS-compressed: 69 bytes that expand to 360 (E-0016, E-0017)
MapC4Attrs0_Y0X0::
    INCBIN "maps/mapc4/attrs0_y0_x0.lz"

; 2 screen far pointers, row by row (E-0142)
MapC8Screens0::
    dfar MapC8Screens0_Y0X0 ; entry 0
    dfar MapC8Screens0_Y1X0 ; entry 1

MapC8Attrs0::
    dfar MapC8Attrs0_Y0X0 ; entry 0
    dfar MapC8Attrs0_Y1X0 ; entry 1

; LZSS-compressed: 109 bytes that expand to 360 (E-0016, E-0017)
MapC8Screens0_Y0X0::
    INCBIN "maps/mapc8/screens0_y0_x0.lz"

; LZSS-compressed: 138 bytes that expand to 360 (E-0016, E-0017)
MapC8Screens0_Y1X0::
    INCBIN "maps/mapc8/screens0_y1_x0.lz"

; LZSS-compressed: 54 bytes that expand to 360 (E-0016, E-0017)
MapC8Attrs0_Y0X0::
    db $68, $01, $00, $03, $00, $00, $0f, $46, $02, $02, $00, $48, $0f, $11, $02, $00
    db $80, $01, $00, $72, $0f, $0d, $02, $02, $01, $01, $00, $96, $0f, $13, $00, $ce
    db $04, $00, $c4, $0f, $31, $00, $ce, $06, $00, $82, $06, $00, $1c, $1f, $0d, $00
    db $14, $1f, $01, $00, $00, $00

MapC8Attrs0_Y1X0::
    db $68, $01, $00, $03, $03, $03, $03, $02, $00, $04, $07, $00, $00, $00, $00, $00
    db $0f, $2b, $00, $04, $0f, $3b, $00, $00, $0a, $00, $9a, $0f, $13, $00, $9a, $06
    db $00, $ca, $0f, $03, $00, $02, $04, $00, $e8, $0f, $13, $00, $e8, $0a, $00, $1c
    db $1f, $03, $00, $36, $1f, $0f
    ds $787, $00
