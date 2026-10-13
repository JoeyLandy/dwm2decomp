; ROM bank $5A: map screens, attributes and tilesets
; The annotated listing of this bank is build/listing/bank5a.asm.

SECTION "Bank 5A", ROMX[$4000], BANK[$5A]
    db $5a

; 12 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
MapAEScreens0::
    dfar MapAEScreens0_Y0X0 ; entry 0
    dfar MapAEScreens0_Y0X1 ; entry 1
    dfar MapAEScreens0_Y0X2 ; entry 2
    dfar MapAEScreens0_Y1X0 ; entry 3
    dfar MapAEScreens0_Y1X1 ; entry 4
    dfar MapAEScreens0_Y1X2 ; entry 5
    dfar MapAEScreens0_Y2X0 ; entry 6
    dfar MapAEScreens0_Y2X1 ; entry 7
    dfar MapAEScreens0_Y2X2 ; entry 8
    dfar MapAEScreens0_Y3X0 ; entry 9
    dfar MapAEScreens0_Y3X1 ; entry 10
    dfar MapAEScreens0_Y3X2 ; entry 11

MapAEAttrs0::
    dfar MapAEAttrs0_Y0X0 ; entry 0
    dfar MapAEAttrs0_Y0X1 ; entry 1
    dfar MapAEAttrs0_Y0X2 ; entry 2
    dfar MapAEAttrs0_Y1X0 ; entry 3
    dfar MapAEAttrs0_Y1X1 ; entry 4
    dfar MapAEAttrs0_Y1X2 ; entry 5
    dfar MapAEAttrs0_Y2X0 ; entry 6
    dfar MapAEAttrs0_Y2X1 ; entry 7
    dfar MapAEAttrs0_Y2X2 ; entry 8
    dfar MapAEAttrs0_Y3X0 ; entry 9
    dfar MapAEAttrs0_Y3X1 ; entry 10
    dfar MapAEAttrs0_Y3X2 ; entry 11

; LZSS-compressed: 29 bytes that expand to 360 (E-0016, E-0017)
MapAEScreens0_Y0X0::
    db $68, $01, $00, $20, $21, $00, $00, $0e, $30, $31, $00, $14, $0e, $00, $00, $0f
    db $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $f8, $0f, $0d

; LZSS-compressed: 155 bytes that expand to 360 (E-0016, E-0017)
MapAEScreens0_Y0X1::
    INCBIN "maps/mapae/screens0_y0_x1.lz"

; LZSS-compressed: 161 bytes that expand to 360 (E-0016, E-0017)
MapAEScreens0_Y0X2::
    INCBIN "maps/mapae/screens0_y0_x2.lz"

; LZSS-compressed: 159 bytes that expand to 360 (E-0016, E-0017)
MapAEScreens0_Y1X0::
    INCBIN "maps/mapae/screens0_y1_x0.lz"

; LZSS-compressed: 169 bytes that expand to 360 (E-0016, E-0017)
MapAEScreens0_Y1X1::
    INCBIN "maps/mapae/screens0_y1_x1.lz"

; LZSS-compressed: 145 bytes that expand to 360 (E-0016, E-0017)
MapAEScreens0_Y1X2::
    INCBIN "maps/mapae/screens0_y1_x2.lz"

; LZSS-compressed: 152 bytes that expand to 360 (E-0016, E-0017)
MapAEScreens0_Y2X0::
    INCBIN "maps/mapae/screens0_y2_x0.lz"

; LZSS-compressed: 194 bytes that expand to 360 (E-0016, E-0017)
MapAEScreens0_Y2X1::
    INCBIN "maps/mapae/screens0_y2_x1.lz"

; LZSS-compressed: 182 bytes that expand to 360 (E-0016, E-0017)
MapAEScreens0_Y2X2::
    INCBIN "maps/mapae/screens0_y2_x2.lz"

; LZSS-compressed: 190 bytes that expand to 360 (E-0016, E-0017)
MapAEScreens0_Y3X0::
    INCBIN "maps/mapae/screens0_y3_x0.lz"

; LZSS-compressed: 211 bytes that expand to 360 (E-0016, E-0017)
MapAEScreens0_Y3X1::
    INCBIN "maps/mapae/screens0_y3_x1.lz"

; LZSS-compressed: 233 bytes that expand to 360 (E-0016, E-0017)
MapAEScreens0_Y3X2::
    INCBIN "maps/mapae/screens0_y3_x2.lz"

; LZSS-compressed: 20 bytes that expand to 360 (E-0016, E-0017)
MapAEAttrs0_Y0X0::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

MapAEAttrs0_Y0X1::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

; LZSS-compressed: 39 bytes that expand to 360 (E-0016, E-0017)
MapAEAttrs0_Y0X2::
    db $68, $01, $00, $01, $00, $00, $0f, $4a, $04, $04, $00, $4c, $0f, $11, $04, $04
    db $00, $72, $0f, $11, $00, $84, $00, $00, $9a, $0f, $0f, $00, $aa, $0f, $13, $00
    db $80, $0f, $17, $00, $00, $0f, $35

; LZSS-compressed: 44 bytes that expand to 360 (E-0016, E-0017)
MapAEAttrs0_Y1X0::
    db $68, $01, $00, $01, $00, $00, $0f, $48, $04, $04, $04, $04, $00, $4c, $0f, $0b
    db $00, $5c, $00, $00, $5c, $0c, $00, $7e, $0f, $01, $00, $7c, $0f, $19, $00, $58
    db $02, $00, $c4, $0f, $13, $00, $fd, $0f, $4d, $00, $00, $06

; LZSS-compressed: 32 bytes that expand to 360 (E-0016, E-0017)
MapAEAttrs0_Y1X1::
    db $68, $01, $00, $01, $00, $00, $0f, $42, $04, $00, $56, $03, $00, $4a, $0f, $0d
    db $00, $54, $0f, $1d, $00, $46, $0f, $01, $00, $00, $0f, $43, $00, $00, $0f, $3d

; LZSS-compressed: 52 bytes that expand to 360 (E-0016, E-0017)
MapAEAttrs0_Y1X2::
    db $68, $01, $00, $01, $00, $00, $0f, $46, $04, $04, $00, $48, $0f, $0f, $04, $00
    db $7e, $03, $00, $72, $0f, $0b, $00, $7e, $04, $00, $82, $08, $00, $a4, $0f, $0d
    db $00, $5a, $04, $00, $cc, $0f, $03, $00, $7a, $06, $00, $52, $0a, $00, $80, $0e
    db $00, $00, $0f, $35

; LZSS-compressed: 48 bytes that expand to 360 (E-0016, E-0017)
MapAEAttrs0_Y2X0::
    db $68, $01, $00, $01, $00, $00, $0f, $4c, $04, $04, $00, $4e, $0f, $11, $04, $04
    db $00, $74, $0f, $11, $03, $03, $00, $9a, $0f, $11, $00, $86, $00, $00, $60, $0c
    db $00, $d2, $0f, $05, $00, $76, $0f, $11, $00, $5e, $0f, $15, $00, $00, $0f, $0b

; LZSS-compressed: 49 bytes that expand to 360 (E-0016, E-0017)
MapAEAttrs0_Y2X1::
    db $68, $01, $00, $01, $00, $00, $0f, $42, $04, $04, $04, $04, $00, $54, $00, $00
    db $4a, $0f, $0b, $00, $56, $00, $00, $7c, $06, $00, $76, $0f, $2f, $00, $7a, $0a
    db $00, $c6, $0f, $09, $00, $7a, $06, $00, $4a, $0c, $00, $fc, $0c, $00, $00, $0f
    db $35

; LZSS-compressed: 45 bytes that expand to 360 (E-0016, E-0017)
MapAEAttrs0_Y2X2::
    db $68, $01, $00, $01, $00, $00, $0f, $4a, $04, $04, $04, $04, $00, $4e, $0f, $13
    db $00, $4c, $0f, $01, $00, $4e, $0f, $27, $00, $5e, $0e, $00, $d4, $0e, $00, $d4
    db $02, $00, $ec, $0f, $0f, $00, $84, $0f, $15, $00, $00, $0f, $0b

; LZSS-compressed: 20 bytes that expand to 360 (E-0016, E-0017)
MapAEAttrs0_Y3X0::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

; LZSS-compressed: 44 bytes that expand to 360 (E-0016, E-0017)
MapAEAttrs0_Y3X1::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $24, $0f, $10, $04, $04, $00, $72
    db $0f, $0f, $04, $00, $a8, $01, $00, $9a, $0f, $0d, $00, $a8, $02, $00, $aa, $0a
    db $00, $ce, $0f, $01, $00, $a6, $0f, $15, $00, $24, $0f, $37

; LZSS-compressed: 34 bytes that expand to 360 (E-0016, E-0017)
MapAEAttrs0_Y3X2::
    db $68, $01, $00, $01, $00, $00, $0f, $24, $04, $04, $00, $26, $0f, $11, $04, $04
    db $03, $03, $00, $4e, $0f, $11, $00, $85, $0f, $4d, $00, $e5, $0f, $4d, $00, $00
    db $0f, $0f

; compressed tileset of map $B0 (the first map record using it)
; LZSS-compressed: 1219 bytes that expand to 1856 (E-0016, E-0017)
MapB0Tileset::
    INCBIN "maps/mapb0/tileset.lz"

; 6 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
MapB0Screens0::
    dfar MapB0Screens0_Y0X0 ; entry 0
    dfar MapB0Screens0_Y0X1 ; entry 1
    dfar MapB0Screens0_Y0X2 ; entry 2
    dfar MapB0Screens0_Y1X0 ; entry 3
    dfar MapB0Screens0_Y1X1 ; entry 4
    dfar MapB0Screens0_Y1X2 ; entry 5

MapB0Attrs0::
    dfar MapB0Attrs0_Y0X0 ; entry 0
    dfar MapB0Attrs0_Y0X1 ; entry 1
    dfar MapB0Attrs0_Y0X2 ; entry 2
    dfar MapB0Attrs0_Y1X0 ; entry 3
    dfar MapB0Attrs0_Y1X1 ; entry 4
    dfar MapB0Attrs0_Y1X2 ; entry 5

; LZSS-compressed: 157 bytes that expand to 360 (E-0016, E-0017)
MapB0Screens0_Y0X0::
    INCBIN "maps/mapb0/screens0_y0_x0.lz"

; LZSS-compressed: 170 bytes that expand to 360 (E-0016, E-0017)
MapB0Screens0_Y0X1::
    INCBIN "maps/mapb0/screens0_y0_x1.lz"

; LZSS-compressed: 151 bytes that expand to 360 (E-0016, E-0017)
MapB0Screens0_Y0X2::
    INCBIN "maps/mapb0/screens0_y0_x2.lz"

; LZSS-compressed: 173 bytes that expand to 360 (E-0016, E-0017)
MapB0Screens0_Y1X0::
    INCBIN "maps/mapb0/screens0_y1_x0.lz"

; LZSS-compressed: 141 bytes that expand to 360 (E-0016, E-0017)
MapB0Screens0_Y1X1::
    INCBIN "maps/mapb0/screens0_y1_x1.lz"

; LZSS-compressed: 113 bytes that expand to 360 (E-0016, E-0017)
MapB0Screens0_Y1X2::
    INCBIN "maps/mapb0/screens0_y1_x2.lz"

; LZSS-compressed: 59 bytes that expand to 360 (E-0016, E-0017)
MapB0Attrs0_Y0X0::
    db $68, $01, $00, $03, $00, $00, $0f, $1a, $02, $02, $02, $02, $00, $1e, $0f, $0f
    db $00, $2e, $00, $02, $02, $01, $00, $5a, $01, $00, $4c, $0f, $07, $00, $54, $08
    db $00, $5a, $04, $00, $7a, $0f, $05, $00, $80, $08, $00, $9e, $0f, $05, $03, $03
    db $00, $a6, $0a, $00, $c6, $0f, $4d, $00, $fe, $0f, $1b

; LZSS-compressed: 53 bytes that expand to 360 (E-0016, E-0017)
MapB0Attrs0_Y0X1::
    db $68, $01, $00, $03, $00, $00, $0f, $1a, $01, $00, $2e, $02, $00, $21, $0f, $0c
    db $00, $2e, $03, $00, $30, $09, $00, $54, $0c, $00, $54, $08, $02, $00, $84, $01
    db $00, $76, $0f, $0b, $05, $05, $00, $7c, $06, $00, $a0, $0f, $09, $00, $cf, $0f
    db $4d, $00, $08, $1f, $25

; LZSS-compressed: 64 bytes that expand to 360 (E-0016, E-0017)
MapB0Attrs0_Y0X2::
    db $68, $01, $00, $03, $00, $00, $0f, $40, $02, $02, $02, $02, $00, $44, $0f, $0f
    db $00, $54, $00, $00, $54, $00, $01, $01, $00, $70, $0f, $09, $00, $80, $00, $00
    db $a2, $06, $00, $9a, $0f, $07, $00, $a2, $08, $01, $01, $00, $56, $02, $00, $c8
    db $0f, $11, $00, $56, $00, $00, $f0, $0f, $0d, $00, $7a, $02, $00, $16, $1f, $2b

; LZSS-compressed: 73 bytes that expand to 360 (E-0016, E-0017)
MapB0Attrs0_Y1X0::
    INCBIN "maps/mapb0/attrs0_y1_x0.lz"

; LZSS-compressed: 56 bytes that expand to 360 (E-0016, E-0017)
MapB0Attrs0_Y1X1::
    db $68, $01, $00, $01, $00, $00, $0f, $20, $02, $00, $34, $03, $00, $28, $0f, $0b
    db $00, $34, $02, $03, $03, $03, $03, $00, $50, $0f, $09, $00, $5c, $04, $00, $74
    db $0f, $0d, $00, $84, $04, $00, $9c, $0f, $09, $00, $a8, $08, $00, $c4, $0f, $05
    db $00, $ef, $0f, $4d, $00, $08, $1f, $05

; LZSS-compressed: 61 bytes that expand to 360 (E-0016, E-0017)
MapB0Attrs0_Y1X2::
    db $68, $01, $00, $01, $00, $00, $07, $02, $00, $0c, $01, $03, $03, $00, $00, $0f
    db $01, $00, $0c, $00, $00, $06, $08, $00, $24, $0f, $05, $00, $4e, $00, $00, $32
    db $04, $00, $48, $0f, $15, $00, $4e, $02, $00, $76, $0f, $2f, $00, $26, $02, $00
    db $c0, $0a, $00, $cc, $0f, $03, $00, $f5, $0f, $4d, $00, $08, $1e

; compressed tileset of map $B1 (the first map record using it)
; LZSS-compressed: 1045 bytes that expand to 1280 (E-0016, E-0017)
MapB1Tileset::
    INCBIN "maps/mapb1/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
MapB1Palettes::
    dw $192c, $7fff, $31cf, $0000 ; entry 0
    dw $056f, $331f, $01f5, $0000 ; entry 1
    dw $00ec, $3216, $1572, $0000 ; entry 2
    dw $012f, $331f, $01da, $0000 ; entry 3
    dw $7e04, $7fff, $1415, $0000 ; entry 4
    dw $04e6, $3f7f, $03e7, $0000 ; entry 5
    dw $3128, $331f, $45cc, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
MapB1Screens0::
    dfar MapB1Screens0_Y0X0 ; entry 0

MapB1Attrs0::
    dfar MapB1Attrs0_Y0X0 ; entry 0

; LZSS-compressed: 228 bytes that expand to 360 (E-0016, E-0017)
MapB1Screens0_Y0X0::
    INCBIN "maps/mapb1/screens0_y0_x0.lz"

; LZSS-compressed: 84 bytes that expand to 360 (E-0016, E-0017)
MapB1Attrs0_Y0X0::
    INCBIN "maps/mapb1/attrs0_y0_x0.lz"

; compressed tileset of map $B3 (the first map record using it)
; LZSS-compressed: 707 bytes that expand to 896 (E-0016, E-0017)
MapB3Tileset::
    INCBIN "maps/mapb3/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
MapB3Palettes::
    dw $7d86, $7fff, $7fe1, $0000 ; entry 0
    dw $0191, $5bbf, $32d6, $00c8 ; entry 1
    dw $0263, $3f7f, $03e7, $00a0 ; entry 2
    dw $01d3, $5bbf, $029a, $0000 ; entry 3
    dw $3189, $7fff, $4e4f, $0000 ; entry 4
    dw $1415, $4fff, $3c1f, $0000 ; entry 5
    dw $00a0, $00a0, $00a0, $00a0 ; entry 6
    dw $00a0, $00a0, $00a0, $00a0 ; entry 7

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
MapB3Screens0::
    dfar MapB3Screens0_Y0X0 ; entry 0
    dfar MapB3Screens0_Y0X1 ; entry 1
    dfar MapB3Screens0_Y1X0 ; entry 2
    dfar MapB3Screens0_Y1X1 ; entry 3

MapB3Attrs0::
    dfar MapB3Attrs0_Y0X0 ; entry 0
    dfar MapB3Attrs0_Y0X1 ; entry 1
    dfar MapB3Attrs0_Y1X0 ; entry 2
    dfar MapB3Attrs0_Y1X1 ; entry 3

; LZSS-compressed: 208 bytes that expand to 360 (E-0016, E-0017)
MapB3Screens0_Y0X0::
    INCBIN "maps/mapb3/screens0_y0_x0.lz"

; LZSS-compressed: 216 bytes that expand to 360 (E-0016, E-0017)
MapB3Screens0_Y0X1::
    INCBIN "maps/mapb3/screens0_y0_x1.lz"

; LZSS-compressed: 252 bytes that expand to 360 (E-0016, E-0017)
MapB3Screens0_Y1X0::
    INCBIN "maps/mapb3/screens0_y1_x0.lz"

; LZSS-compressed: 165 bytes that expand to 360 (E-0016, E-0017)
MapB3Screens0_Y1X1::
    INCBIN "maps/mapb3/screens0_y1_x1.lz"

; LZSS-compressed: 27 bytes that expand to 360 (E-0016, E-0017)
MapB3Attrs0_Y0X0::
    db $68, $01, $00, $01, $00, $00, $0f, $3e, $04, $00, $52, $0d, $00, $50, $0f, $4d
    db $00, $b0, $0f, $4d, $00, $c2, $04, $00, $18, $1f, $29

MapB3Attrs0_Y0X1::
    db $68, $01, $00, $01, $00, $00, $0f, $3c, $04, $00, $50, $0d, $00, $4e, $0f, $4d
    db $00, $ae, $0f, $43, $00, $b2, $0e, $00, $16, $1f, $2b

; LZSS-compressed: 30 bytes that expand to 360 (E-0016, E-0017)
MapB3Attrs0_Y1X0::
    db $68, $01, $00, $01, $01, $04, $00, $02, $0b, $01, $01, $00, $00, $0f, $4d, $00
    db $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $d0, $0a, $00, $3e, $1f, $13

MapB3Attrs0_Y1X1::
    db $68, $01, $00, $01, $01, $04, $00, $02, $0b, $01, $01, $00, $00, $0f, $4d, $00
    db $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $d0, $0a, $00, $3e, $1f, $13

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
MapB4Screens0::
    dfar MapB4Screens0_Y0X0 ; entry 0
    dfar MapB4Screens0_Y0X1 ; entry 1
    dfar MapB4Screens0_Y1X0 ; entry 2
    dfar MapB4Screens0_Y1X1 ; entry 3

MapB4Attrs0::
    dfar MapB4Attrs0_Y0X0 ; entry 0
    dfar MapB4Attrs0_Y0X1 ; entry 1
    dfar MapB4Attrs0_Y1X0 ; entry 2
    dfar MapB4Attrs0_Y1X1 ; entry 3

; LZSS-compressed: 194 bytes that expand to 360 (E-0016, E-0017)
MapB4Screens0_Y0X0::
    INCBIN "maps/mapb4/screens0_y0_x0.lz"

; LZSS-compressed: 225 bytes that expand to 360 (E-0016, E-0017)
MapB4Screens0_Y0X1::
    INCBIN "maps/mapb4/screens0_y0_x1.lz"

; LZSS-compressed: 246 bytes that expand to 360 (E-0016, E-0017)
MapB4Screens0_Y1X0::
    INCBIN "maps/mapb4/screens0_y1_x0.lz"

; LZSS-compressed: 247 bytes that expand to 360 (E-0016, E-0017)
MapB4Screens0_Y1X1::
    INCBIN "maps/mapb4/screens0_y1_x1.lz"

; LZSS-compressed: 32 bytes that expand to 360 (E-0016, E-0017)
MapB4Attrs0_Y0X0::
    db $68, $01, $00, $01, $00, $00, $0f, $3e, $04, $00, $52, $0d, $00, $50, $0f, $33
    db $00, $46, $0f, $01, $00, $aa, $0f, $2d, $00, $9a, $0f, $01, $00, $fe, $0f, $43

; LZSS-compressed: 36 bytes that expand to 360 (E-0016, E-0017)
MapB4Attrs0_Y0X1::
    db $68, $01, $00, $01, $00, $00, $0f, $3c, $04, $00, $50, $0d, $00, $4e, $0f, $2b
    db $00, $4a, $0e, $00, $9e, $0f, $2b, $00, $50, $0f, $3d, $00, $9a, $08, $00, $48
    db $08, $00, $00, $0c

; LZSS-compressed: 33 bytes that expand to 360 (E-0016, E-0017)
MapB4Attrs0_Y1X0::
    db $68, $01, $00, $01, $01, $04, $00, $02, $03, $01, $01, $00, $00, $04, $00, $00
    db $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d, $00, $d0, $0a, $00, $40, $1f
    db $13

; LZSS-compressed: 43 bytes that expand to 360 (E-0016, E-0017)
MapB4Attrs0_Y1X1::
    db $68, $01, $00, $04, $04, $04, $04, $01, $00, $04, $0b, $00, $00, $0f, $31, $00
    db $00, $00, $00, $58, $02, $00, $4e, $0f, $4d, $00, $5e, $06, $00, $c8, $0a, $00
    db $c6, $0f, $4d, $00, $00, $0f, $01, $00, $3e, $1f, $07

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
MapB5Screens0::
    dfar MapB5Screens0_Y0X0 ; entry 0
    dfar MapB5Screens0_Y0X0 ; entry 1
    dfar MapB5Screens0_Y1X0 ; entry 2
    dfar MapB5Screens0_Y1X1 ; entry 3

MapB5Attrs0::
    dfar MapB5Attrs0_Y0X0 ; entry 0
    dfar MapB5Attrs0_Y0X0 ; entry 1
    dfar MapB5Attrs0_Y1X0 ; entry 2
    dfar MapB5Attrs0_Y1X1 ; entry 3

; LZSS-compressed: 171 bytes that expand to 360 (E-0016, E-0017)
MapB5Screens0_Y0X0::
    INCBIN "maps/mapb5/screens0_y0_x0.lz"

; LZSS-compressed: 242 bytes that expand to 360 (E-0016, E-0017)
MapB5Screens0_Y1X0::
    INCBIN "maps/mapb5/screens0_y1_x0.lz"

; LZSS-compressed: 227 bytes that expand to 360 (E-0016, E-0017)
MapB5Screens0_Y1X1::
    INCBIN "maps/mapb5/screens0_y1_x1.lz"

; LZSS-compressed: 34 bytes that expand to 360 (E-0016, E-0017)
MapB5Attrs0_Y0X0::
    db $68, $01, $00, $01, $00, $00, $0f, $3e, $04, $00, $52, $0b, $00, $4e, $0f, $4d
    db $00, $ae, $0f, $4d, $00, $d2, $0f, $0d, $00, $4c, $06, $00, $42, $0f, $01, $00
    db $00, $04

; LZSS-compressed: 50 bytes that expand to 360 (E-0016, E-0017)
MapB5Attrs0_Y1X0::
    db $68, $01, $00, $01, $00, $00, $03, $04, $04, $04, $04, $00, $00, $04, $00, $00
    db $0f, $2b, $00, $08, $00, $00, $52, $08, $00, $4e, $0f, $15, $00, $0a, $00, $00
    db $7a, $0f, $4d, $00, $9e, $0f, $01, $00, $4e, $0f, $29, $00, $0c, $0c, $00, $3e
    db $1f, $07

; LZSS-compressed: 45 bytes that expand to 360 (E-0016, E-0017)
MapB5Attrs0_Y1X1::
    db $68, $01, $00, $01, $00, $00, $0f, $1c, $04, $04, $04, $04, $00, $20, $0f, $0b
    db $00, $30, $00, $00, $52, $08, $00, $4e, $0f, $03, $00, $52, $0c, $00, $74, $0f
    db $4d, $00, $5c, $0f, $09, $00, $f0, $0f, $2b, $00, $00, $0f, $13

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
MapB6Screens0::
    dfar MapB6Screens0_Y0X0 ; entry 0

MapB6Attrs0::
    dfar MapB6Attrs0_Y0X0 ; entry 0

; LZSS-compressed: 248 bytes that expand to 360 (E-0016, E-0017)
MapB6Screens0_Y0X0::
    INCBIN "maps/mapb6/screens0_y0_x0.lz"

; LZSS-compressed: 79 bytes that expand to 360 (E-0016, E-0017)
MapB6Attrs0_Y0X0::
    INCBIN "maps/mapb6/attrs0_y0_x0.lz"

; compressed tileset of map $B8 (the first map record using it)
; LZSS-compressed: 1222 bytes that expand to 1920 (E-0016, E-0017)
MapB8Tileset::
    INCBIN "maps/mapb8/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
MapB8Palettes::
    dw $7da0, $7fff, $7fe0, $0063 ; entry 0
    dw $0160, $3fbf, $03e2, $0000 ; entry 1
    dw $012f, $3fbf, $03e2, $0000 ; entry 2
    dw $318c, $5294, $03e2, $0000 ; entry 3
    dw $158f, $2ab7, $03e2, $0000 ; entry 4
    dw $0171, $3fbf, $03e2, $0000 ; entry 5
    dw $1415, $7fff, $03e2, $0000 ; entry 6
    dw $318c, $7fff, $5294, $0000 ; entry 7

; 25 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
MapB8Screens0::
    dfar MapB8Screens0_Y0X0 ; entry 0
    dfar MapB8Screens0_Y0X1 ; entry 1
    dfar MapB8Screens0_Y0X2 ; entry 2
    dfar MapB8Screens0_Y0X3 ; entry 3
    dfar MapB8Screens0_Y0X4 ; entry 4
    dfar MapB8Screens0_Y1X0 ; entry 5
    dfar MapB8Screens0_Y1X1 ; entry 6
    dfar MapB8Screens0_Y1X2 ; entry 7
    dfar MapB8Screens0_Y1X3 ; entry 8
    dfar MapB8Screens0_Y1X4 ; entry 9
    dfar MapB8Screens0_Y2X0 ; entry 10
    dfar MapB8Screens0_Y2X1 ; entry 11
    dfar MapB8Screens0_Y2X2 ; entry 12
    dfar MapB8Screens0_Y2X3 ; entry 13
    dfar MapB8Screens0_Y2X4 ; entry 14
    dfar MapB8Screens0_Y3X0 ; entry 15
    dfar MapB8Screens0_Y3X1 ; entry 16
    dfar MapB8Screens0_Y3X2 ; entry 17
    dfar MapB8Screens0_Y3X3 ; entry 18
    dfar MapB8Screens0_Y3X4 ; entry 19
    dfar MapB8Screens0_Y4X0 ; entry 20
    dfar MapB8Screens0_Y4X1 ; entry 21
    dfar MapB8Screens0_Y4X2 ; entry 22
    dfar MapB8Screens0_Y4X3 ; entry 23
    dfar MapB8Screens0_Y4X4 ; entry 24

MapB8Attrs0::
    dfar MapB8Attrs0_Y0X0 ; entry 0
    dfar MapB8Attrs0_Y0X1 ; entry 1
    dfar MapB8Attrs0_Y0X2 ; entry 2
    dfar MapB8Attrs0_Y0X3 ; entry 3
    dfar MapB8Attrs0_Y0X4 ; entry 4
    dfar MapB8Attrs0_Y1X0 ; entry 5
    dfar MapB8Attrs0_Y1X1 ; entry 6
    dfar MapB8Attrs0_Y1X2 ; entry 7
    dfar MapB8Attrs0_Y1X3 ; entry 8
    dfar MapB8Attrs0_Y1X4 ; entry 9
    dfar MapB8Attrs0_Y2X0 ; entry 10
    dfar MapB8Attrs0_Y2X1 ; entry 11
    dfar MapB8Attrs0_Y2X2 ; entry 12
    dfar MapB8Attrs0_Y2X3 ; entry 13
    dfar MapB8Attrs0_Y2X4 ; entry 14
    dfar MapB8Attrs0_Y3X0 ; entry 15
    dfar MapB8Attrs0_Y3X1 ; entry 16
    dfar MapB8Attrs0_Y3X2 ; entry 17
    dfar MapB8Attrs0_Y3X3 ; entry 18
    dfar MapB8Attrs0_Y3X4 ; entry 19
    dfar MapB8Attrs0_Y4X0 ; entry 20
    dfar MapB8Attrs0_Y4X1 ; entry 21
    dfar MapB8Attrs0_Y4X2 ; entry 22
    dfar MapB8Attrs0_Y4X3 ; entry 23
    dfar MapB8Attrs0_Y4X4 ; entry 24

; LZSS-compressed: 114 bytes that expand to 360 (E-0016, E-0017)
MapB8Screens0_Y0X0::
    INCBIN "maps/mapb8/screens0_y0_x0.lz"

; LZSS-compressed: 139 bytes that expand to 360 (E-0016, E-0017)
MapB8Screens0_Y0X1::
    INCBIN "maps/mapb8/screens0_y0_x1.lz"

; LZSS-compressed: 99 bytes that expand to 360 (E-0016, E-0017)
MapB8Screens0_Y0X2::
    INCBIN "maps/mapb8/screens0_y0_x2.lz"

; LZSS-compressed: 81 bytes that expand to 360 (E-0016, E-0017)
MapB8Screens0_Y0X3::
    INCBIN "maps/mapb8/screens0_y0_x3.lz"

; LZSS-compressed: 96 bytes that expand to 360 (E-0016, E-0017)
MapB8Screens0_Y0X4::
    INCBIN "maps/mapb8/screens0_y0_x4.lz"

; LZSS-compressed: 144 bytes that expand to 360 (E-0016, E-0017)
MapB8Screens0_Y1X0::
    INCBIN "maps/mapb8/screens0_y1_x0.lz"

; LZSS-compressed: 162 bytes that expand to 360 (E-0016, E-0017)
MapB8Screens0_Y1X1::
    INCBIN "maps/mapb8/screens0_y1_x1.lz"

; LZSS-compressed: 110 bytes that expand to 360 (E-0016, E-0017)
MapB8Screens0_Y1X2::
    INCBIN "maps/mapb8/screens0_y1_x2.lz"

; LZSS-compressed: 128 bytes that expand to 360 (E-0016, E-0017)
MapB8Screens0_Y1X3::
    INCBIN "maps/mapb8/screens0_y1_x3.lz"

; LZSS-compressed: 154 bytes that expand to 360 (E-0016, E-0017)
MapB8Screens0_Y1X4::
    INCBIN "maps/mapb8/screens0_y1_x4.lz"

; LZSS-compressed: 106 bytes that expand to 360 (E-0016, E-0017)
MapB8Screens0_Y2X0::
    INCBIN "maps/mapb8/screens0_y2_x0.lz"

; LZSS-compressed: 132 bytes that expand to 360 (E-0016, E-0017)
MapB8Screens0_Y2X1::
    INCBIN "maps/mapb8/screens0_y2_x1.lz"

; LZSS-compressed: 105 bytes that expand to 360 (E-0016, E-0017)
MapB8Screens0_Y2X2::
    INCBIN "maps/mapb8/screens0_y2_x2.lz"

; LZSS-compressed: 134 bytes that expand to 360 (E-0016, E-0017)
MapB8Screens0_Y2X3::
    INCBIN "maps/mapb8/screens0_y2_x3.lz"

; LZSS-compressed: 125 bytes that expand to 360 (E-0016, E-0017)
MapB8Screens0_Y2X4::
    INCBIN "maps/mapb8/screens0_y2_x4.lz"

; LZSS-compressed: 113 bytes that expand to 360 (E-0016, E-0017)
MapB8Screens0_Y3X0::
    INCBIN "maps/mapb8/screens0_y3_x0.lz"

; LZSS-compressed: 136 bytes that expand to 360 (E-0016, E-0017)
MapB8Screens0_Y3X1::
    INCBIN "maps/mapb8/screens0_y3_x1.lz"

; LZSS-compressed: 129 bytes that expand to 360 (E-0016, E-0017)
MapB8Screens0_Y3X2::
    INCBIN "maps/mapb8/screens0_y3_x2.lz"

; LZSS-compressed: 149 bytes that expand to 360 (E-0016, E-0017)
MapB8Screens0_Y3X3::
    INCBIN "maps/mapb8/screens0_y3_x3.lz"

; LZSS-compressed: 156 bytes that expand to 360 (E-0016, E-0017)
MapB8Screens0_Y3X4::
    INCBIN "maps/mapb8/screens0_y3_x4.lz"

; LZSS-compressed: 123 bytes that expand to 360 (E-0016, E-0017)
MapB8Screens0_Y4X0::
    INCBIN "maps/mapb8/screens0_y4_x0.lz"

; LZSS-compressed: 133 bytes that expand to 360 (E-0016, E-0017)
MapB8Screens0_Y4X1::
    INCBIN "maps/mapb8/screens0_y4_x1.lz"

; LZSS-compressed: 116 bytes that expand to 360 (E-0016, E-0017)
MapB8Screens0_Y4X2::
    INCBIN "maps/mapb8/screens0_y4_x2.lz"

; LZSS-compressed: 94 bytes that expand to 360 (E-0016, E-0017)
MapB8Screens0_Y4X3::
    INCBIN "maps/mapb8/screens0_y4_x3.lz"

; LZSS-compressed: 120 bytes that expand to 360 (E-0016, E-0017)
MapB8Screens0_Y4X4::
    INCBIN "maps/mapb8/screens0_y4_x4.lz"

; LZSS-compressed: 49 bytes that expand to 360 (E-0016, E-0017)
MapB8Attrs0_Y0X0::
    db $68, $01, $00, $03, $00, $00, $0f, $44, $02, $00, $58, $03, $00, $4c, $0f, $13
    db $01, $00, $86, $01, $00, $78, $0f, $05, $00, $80, $08, $00, $9c, $0f, $0d, $00
    db $aa, $06, $00, $c6, $0f, $0b, $00, $a8, $0f, $39, $00, $56, $00, $00, $34, $1f
    db $0d

; LZSS-compressed: 56 bytes that expand to 360 (E-0016, E-0017)
MapB8Attrs0_Y0X1::
    db $68, $01, $00, $03, $00, $00, $0f, $40, $02, $02, $02, $02, $00, $00, $00, $01
    db $00, $5c, $03, $00, $50, $0f, $01, $01, $01, $00, $54, $00, $00, $6a, $0f, $11
    db $00, $78, $02, $00, $94, $0f, $11, $00, $78, $02, $00, $c0, $0a, $00, $cc, $0f
    db $03, $00, $f5, $0f, $4d, $00, $08, $1e

; LZSS-compressed: 28 bytes that expand to 360 (E-0016, E-0017)
MapB8Attrs0_Y0X2::
    db $68, $01, $00, $03, $00, $00, $0f, $3c, $01, $00, $50, $05, $00, $46, $0f, $15
    db $00, $81, $0f, $4d, $00, $e1, $0f, $4d, $00, $08, $1f, $13

; LZSS-compressed: 38 bytes that expand to 360 (E-0016, E-0017)
MapB8Attrs0_Y0X3::
    db $68, $01, $00, $03, $00, $00, $0f, $4d, $00, $18, $0f, $04, $01, $00, $78, $03
    db $00, $6c, $0f, $15, $00, $7e, $08, $00, $a0, $0f, $0b, $00, $7e, $06, $00, $c8
    db $0f, $4d, $00, $00, $1f, $19

; LZSS-compressed: 50 bytes that expand to 360 (E-0016, E-0017)
MapB8Attrs0_Y0X4::
    db $68, $01, $00, $03, $00, $00, $0f, $4d, $00, $1c, $0f, $08, $01, $00, $7c, $05
    db $00, $72, $0f, $0f, $05, $05, $00, $80, $0a, $00, $a4, $0e, $00, $7c, $06, $00
    db $c0, $0f, $33, $00, $c8, $0a, $00, $14, $1f, $09, $02, $02, $02, $02, $00, $34
    db $1f, $0d

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
MapB8Attrs0_Y1X0::
    INCBIN "maps/mapb8/attrs0_y1_x0.lz"

; LZSS-compressed: 44 bytes that expand to 360 (E-0016, E-0017)
MapB8Attrs0_Y1X1::
    db $68, $01, $02, $01, $02, $00, $0f, $42, $02, $fc, $ff, $01, $02, $56, $0f, $05
    db $02, $fe, $fc, $02, $7e, $0f, $07, $02, $fe, $fa, $02, $f8, $ff, $01, $05, $05
    db $02, $bc, $0f, $13, $02, $54, $0f, $17, $02, $0e, $0f, $35

; LZSS-compressed: 32 bytes that expand to 360 (E-0016, E-0017)
MapB8Attrs0_Y1X2::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $9c, $0f, $28
    db $03, $03, $03, $03, $00, $ec, $0f, $0f, $00, $fc, $0f, $13, $00, $fa, $0f, $0d

; LZSS-compressed: 65 bytes that expand to 360 (E-0016, E-0017)
MapB8Attrs0_Y1X3::
    INCBIN "maps/mapb8/attrs0_y1_x3.lz"

; LZSS-compressed: 89 bytes that expand to 360 (E-0016, E-0017)
MapB8Attrs0_Y1X4::
    INCBIN "maps/mapb8/attrs0_y1_x4.lz"

; LZSS-compressed: 66 bytes that expand to 360 (E-0016, E-0017)
MapB8Attrs0_Y2X0::
    INCBIN "maps/mapb8/attrs0_y2_x0.lz"

; LZSS-compressed: 39 bytes that expand to 360 (E-0016, E-0017)
MapB8Attrs0_Y2X1::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $18, $0f, $04, $02, $02, $00, $66
    db $0f, $15, $00, $78, $0e, $00, $a0, $0f, $05, $00, $78, $0c, $00, $c8, $0f, $2d
    db $00, $90, $0f, $29, $00, $18, $0c

; LZSS-compressed: 60 bytes that expand to 360 (E-0016, E-0017)
MapB8Attrs0_Y2X2::
    db $68, $01, $00, $01, $00, $00, $05, $03, $03, $03, $03, $00, $00, $06, $00, $04
    db $0f, $07, $00, $08, $00, $00, $22, $0f, $15, $00, $0c, $0f, $11, $00, $0a, $00
    db $00, $82, $02, $00, $78, $0f, $31, $00, $82, $06, $00, $c6, $0f, $09, $00, $d0
    db $08, $00, $ee, $0f, $07, $00, $f6, $0a, $00, $16, $1f, $2b

; LZSS-compressed: 64 bytes that expand to 360 (E-0016, E-0017)
MapB8Attrs0_Y2X3::
    db $68, $01, $00, $01, $00, $00, $0f, $40, $03, $00, $54, $03, $00, $00, $02, $02
    db $02, $00, $50, $0f, $01, $00, $54, $04, $00, $58, $04, $02, $02, $00, $76, $0f
    db $09, $00, $76, $04, $00, $9a, $0f, $0b, $00, $9c, $08, $00, $c4, $0f, $0b, $00
    db $52, $06, $00, $ec, $0f, $09, $00, $50, $08, $00, $54, $08, $00, $20, $1f, $21

; LZSS-compressed: 70 bytes that expand to 360 (E-0016, E-0017)
MapB8Attrs0_Y2X4::
    INCBIN "maps/mapb8/attrs0_y2_x4.lz"

; LZSS-compressed: 68 bytes that expand to 360 (E-0016, E-0017)
MapB8Attrs0_Y3X0::
    INCBIN "maps/mapb8/attrs0_y3_x0.lz"

; LZSS-compressed: 33 bytes that expand to 360 (E-0016, E-0017)
MapB8Attrs0_Y3X1::
    db $68, $01, $00, $02, $02, $02, $02, $01, $00, $04, $0b, $00, $00, $0f, $4d, $00
    db $10, $02, $00, $18, $0c, $00, $76, $0f, $2b, $00, $c7, $0f, $4d, $00, $08, $1f
    db $2d

; LZSS-compressed: 54 bytes that expand to 360 (E-0016, E-0017)
MapB8Attrs0_Y3X2::
    db $68, $01, $00, $01, $01, $01, $01, $03, $00, $04, $0b, $00, $00, $0f, $05, $00
    db $28, $02, $00, $1e, $0f, $15, $00, $00, $06, $00, $50, $0f, $0f, $00, $85, $0f
    db $4d, $00, $c6, $0f, $2d, $02, $02, $02, $02, $00, $16, $1f, $0f, $00, $26, $10
    db $00, $26, $1c, $00, $4c, $14

; LZSS-compressed: 65 bytes that expand to 360 (E-0016, E-0017)
MapB8Attrs0_Y3X3::
    INCBIN "maps/mapb8/attrs0_y3_x3.lz"

; LZSS-compressed: 72 bytes that expand to 360 (E-0016, E-0017)
MapB8Attrs0_Y3X4::
    INCBIN "maps/mapb8/attrs0_y3_x4.lz"

; LZSS-compressed: 67 bytes that expand to 360 (E-0016, E-0017)
MapB8Attrs0_Y4X0::
    INCBIN "maps/mapb8/attrs0_y4_x0.lz"

; LZSS-compressed: 56 bytes that expand to 360 (E-0016, E-0017)
MapB8Attrs0_Y4X1::
    db $68, $01, $00, $01, $00, $00, $0f, $46, $02, $02, $00, $48, $0f, $0f, $02, $00
    db $7e, $03, $00, $7c, $02, $00, $78, $0f, $05, $00, $7e, $04, $00, $7e, $06, $00
    db $a2, $0e, $00, $a4, $06, $03, $00, $d2, $05, $00, $c8, $0f, $09, $00, $d2, $06
    db $00, $ee, $0f, $03, $00, $0c, $1f, $3d

MapB8Attrs0_Y4X2::
    db $68, $01, $00, $01, $00, $00, $07, $02, $00, $0c, $03, $00, $00, $0f, $05, $00
    db $26, $04, $00, $20, $0f, $0b, $00, $32, $06, $00, $48, $0f, $09, $00, $68, $0f
    db $3d, $03, $03, $00, $c4, $02, $00, $ce, $00, $00, $c0, $0f, $0b, $00, $f0, $0a
    db $00, $ec, $0f, $15, $00, $18, $1f, $2d

; LZSS-compressed: 52 bytes that expand to 360 (E-0016, E-0017)
MapB8Attrs0_Y4X3::
    db $68, $01, $00, $02, $00, $00, $05, $01, $00, $0a, $05, $00, $00, $0f, $09, $00
    db $0a, $06, $00, $26, $0f, $33, $00, $08, $0f, $1d, $03, $03, $03, $03, $00, $a0
    db $0f, $07, $00, $aa, $06, $00, $c4, $0f, $09, $00, $b0, $00, $00, $e4, $0f, $0d
    db $00, $10, $1f, $3d

; LZSS-compressed: 47 bytes that expand to 360 (E-0016, E-0017)
MapB8Attrs0_Y4X4::
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0a, $05, $00, $00, $0f, $33, $00
    db $06, $06, $00, $50, $0f, $0f, $00, $08, $02, $00, $78, $0f, $01, $00, $4c, $0c
    db $00, $9c, $0f, $39, $00, $0a, $06, $00, $f2, $0f, $03, $00, $10, $1f, $39
    ds $32, $00
