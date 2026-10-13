; ROM bank $6B: special map screens
; The annotated listing of this bank is build/listing/bank6b.asm.

SECTION "Bank 6B", ROMX[$4000], BANK[$6B]
    db $6b

; compressed tileset of special map record 6 (SpecialMapRecords)
; LZSS-compressed: 842 bytes that expand to 1536 (E-0016, E-0017)
SpecialMap06Tileset::
    INCBIN "maps/special_map06/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
SpecialMap06Palettes::
    dw $1c2e, $7fff, $357b, $0000 ; entry 0
    dw $012f, $3f7f, $01da, $0000 ; entry 1
    dw $49ae, $6b79, $4acd, $0000 ; entry 2
    dw $01c0, $3f7f, $03e2, $0000 ; entry 3
    dw $092e, $3f7f, $19d4, $0000 ; entry 4
    dw $7c01, $7fff, $7fe1, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap06Screens::
    dfar SpecialMap06Screens_Y0X0 ; entry 0
    dfar SpecialMap06Screens_Y0X1 ; entry 1
    dfar SpecialMap06Screens_Y1X0 ; entry 2
    dfar SpecialMap06Screens_Y1X1 ; entry 3

SpecialMap06Attrs::
    dfar SpecialMap06Attrs_Y0X0 ; entry 0
    dfar SpecialMap06Attrs_Y0X1 ; entry 1
    dfar SpecialMap06Attrs_Y1X0 ; entry 2
    dfar SpecialMap06Attrs_Y1X1 ; entry 3

; LZSS-compressed: 236 bytes that expand to 360 (E-0016, E-0017)
SpecialMap06Screens_Y0X0::
    INCBIN "maps/special_map06/screens_y0_x0.lz"

; LZSS-compressed: 203 bytes that expand to 360 (E-0016, E-0017)
SpecialMap06Screens_Y0X1::
    INCBIN "maps/special_map06/screens_y0_x1.lz"

; LZSS-compressed: 220 bytes that expand to 360 (E-0016, E-0017)
SpecialMap06Screens_Y1X0::
    INCBIN "maps/special_map06/screens_y1_x0.lz"

; LZSS-compressed: 212 bytes that expand to 360 (E-0016, E-0017)
SpecialMap06Screens_Y1X1::
    INCBIN "maps/special_map06/screens_y1_x1.lz"

; LZSS-compressed: 105 bytes that expand to 360 (E-0016, E-0017)
SpecialMap06Attrs_Y0X0::
    INCBIN "maps/special_map06/attrs_y0_x0.lz"

; LZSS-compressed: 86 bytes that expand to 360 (E-0016, E-0017)
SpecialMap06Attrs_Y0X1::
    INCBIN "maps/special_map06/attrs_y0_x1.lz"

; LZSS-compressed: 78 bytes that expand to 360 (E-0016, E-0017)
SpecialMap06Attrs_Y1X0::
    INCBIN "maps/special_map06/attrs_y1_x0.lz"

; LZSS-compressed: 80 bytes that expand to 360 (E-0016, E-0017)
SpecialMap06Attrs_Y1X1::
    INCBIN "maps/special_map06/attrs_y1_x1.lz"

; compressed tileset of special map record 7 (SpecialMapRecords)
; LZSS-compressed: 1231 bytes that expand to 1536 (E-0016, E-0017)
SpecialMap07Tileset::
    INCBIN "maps/special_map07/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
SpecialMap07Palettes::
    dw $49ae, $7fff, $4acd, $0000 ; entry 0
    dw $012f, $67ff, $01da, $0000 ; entry 1
    dw $0191, $3f7f, $029a, $0000 ; entry 2
    dw $01c0, $3f7f, $01d3, $0000 ; entry 3
    dw $092e, $3f7f, $19d4, $0000 ; entry 4
    dw $01da, $67ff, $1c2e, $0000 ; entry 5
    dw $7c01, $7fff, $7fe1, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap07Screens::
    dfar SpecialMap07Screens_Y0X0 ; entry 0
    dfar SpecialMap07Screens_Y0X1 ; entry 1
    dfar SpecialMap07Screens_Y1X0 ; entry 2
    dfar SpecialMap07Screens_Y1X1 ; entry 3

SpecialMap07Attrs::
    dfar SpecialMap07Attrs_Y0X0 ; entry 0
    dfar SpecialMap07Attrs_Y0X1 ; entry 1
    dfar SpecialMap07Attrs_Y1X0 ; entry 2
    dfar SpecialMap07Attrs_Y1X1 ; entry 3

; LZSS-compressed: 216 bytes that expand to 360 (E-0016, E-0017)
SpecialMap07Screens_Y0X0::
    INCBIN "maps/special_map07/screens_y0_x0.lz"

; LZSS-compressed: 229 bytes that expand to 360 (E-0016, E-0017)
SpecialMap07Screens_Y0X1::
    INCBIN "maps/special_map07/screens_y0_x1.lz"

; LZSS-compressed: 211 bytes that expand to 360 (E-0016, E-0017)
SpecialMap07Screens_Y1X0::
    INCBIN "maps/special_map07/screens_y1_x0.lz"

; LZSS-compressed: 248 bytes that expand to 360 (E-0016, E-0017)
SpecialMap07Screens_Y1X1::
    INCBIN "maps/special_map07/screens_y1_x1.lz"

; LZSS-compressed: 89 bytes that expand to 360 (E-0016, E-0017)
SpecialMap07Attrs_Y0X0::
    INCBIN "maps/special_map07/attrs_y0_x0.lz"

; LZSS-compressed: 97 bytes that expand to 360 (E-0016, E-0017)
SpecialMap07Attrs_Y0X1::
    INCBIN "maps/special_map07/attrs_y0_x1.lz"

; LZSS-compressed: 95 bytes that expand to 360 (E-0016, E-0017)
SpecialMap07Attrs_Y1X0::
    INCBIN "maps/special_map07/attrs_y1_x0.lz"

; LZSS-compressed: 84 bytes that expand to 360 (E-0016, E-0017)
SpecialMap07Attrs_Y1X1::
    INCBIN "maps/special_map07/attrs_y1_x1.lz"

; compressed tileset of special map record 8 (SpecialMapRecords)
; LZSS-compressed: 1213 bytes that expand to 1552 (E-0016, E-0017)
SpecialMap08Tileset::
    INCBIN "maps/special_map08/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
SpecialMap08Palettes::
    dw $49ae, $7fff, $4acd, $0000 ; entry 0
    dw $012f, $67ff, $01da, $0000 ; entry 1
    dw $0191, $3f7f, $029a, $0000 ; entry 2
    dw $01c0, $3f7f, $03e2, $0000 ; entry 3
    dw $092e, $3f7f, $19d4, $0000 ; entry 4
    dw $012f, $7fff, $01da, $0000 ; entry 5
    dw $7c01, $7fff, $7fe1, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap08Screens::
    dfar SpecialMap08Screens_Y0X0 ; entry 0
    dfar SpecialMap08Screens_Y0X1 ; entry 1
    dfar SpecialMap08Screens_Y1X0 ; entry 2
    dfar SpecialMap08Screens_Y1X1 ; entry 3

SpecialMap08Attrs::
    dfar SpecialMap08Attrs_Y0X0 ; entry 0
    dfar SpecialMap08Attrs_Y0X1 ; entry 1
    dfar SpecialMap08Attrs_Y1X0 ; entry 2
    dfar SpecialMap08Attrs_Y1X1 ; entry 3

; LZSS-compressed: 221 bytes that expand to 360 (E-0016, E-0017)
SpecialMap08Screens_Y0X0::
    INCBIN "maps/special_map08/screens_y0_x0.lz"

; LZSS-compressed: 219 bytes that expand to 360 (E-0016, E-0017)
SpecialMap08Screens_Y0X1::
    INCBIN "maps/special_map08/screens_y0_x1.lz"

; LZSS-compressed: 257 bytes that expand to 360 (E-0016, E-0017)
SpecialMap08Screens_Y1X0::
    INCBIN "maps/special_map08/screens_y1_x0.lz"

; LZSS-compressed: 249 bytes that expand to 360 (E-0016, E-0017)
SpecialMap08Screens_Y1X1::
    INCBIN "maps/special_map08/screens_y1_x1.lz"

; LZSS-compressed: 94 bytes that expand to 360 (E-0016, E-0017)
SpecialMap08Attrs_Y0X0::
    INCBIN "maps/special_map08/attrs_y0_x0.lz"

; LZSS-compressed: 70 bytes that expand to 360 (E-0016, E-0017)
SpecialMap08Attrs_Y0X1::
    INCBIN "maps/special_map08/attrs_y0_x1.lz"

; LZSS-compressed: 72 bytes that expand to 360 (E-0016, E-0017)
SpecialMap08Attrs_Y1X0::
    INCBIN "maps/special_map08/attrs_y1_x0.lz"

; LZSS-compressed: 63 bytes that expand to 360 (E-0016, E-0017)
SpecialMap08Attrs_Y1X1::
    db $68, $01, $01, $06, $06, $06, $01, $f1, $fb, $03, $03, $01, $02, $0c, $01, $10
    db $0a, $06, $01, $32, $01, $01, $10, $00, $01, $f6, $f9, $01, $35, $0f, $26, $01
    db $0c, $04, $01, $76, $0f, $13, $01, $74, $0f, $01, $01, $74, $0f, $01, $05, $05
    db $01, $c6, $0f, $13, $01, $c0, $ff, $2d, $01, $88, $00, $01, $40, $1f, $11

; compressed tileset of special map record 9 (SpecialMapRecords)
; LZSS-compressed: 1114 bytes that expand to 1536 (E-0016, E-0017)
SpecialMap09Tileset::
    INCBIN "maps/special_map09/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
SpecialMap09Palettes::
    dw $218c, $7fff, $5ab1, $0000 ; entry 0
    dw $012f, $67ff, $01da, $0000 ; entry 1
    dw $012f, $3f7f, $029a, $0000 ; entry 2
    dw $1586, $7fff, $02c0, $0000 ; entry 3
    dw $218c, $2e7f, $1415, $0000 ; entry 4
    dw $7c01, $7fff, $7fe1, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap09Screens::
    dfar SpecialMap09Screens_Y0X0 ; entry 0
    dfar SpecialMap09Screens_Y0X1 ; entry 1
    dfar SpecialMap09Screens_Y1X0 ; entry 2
    dfar SpecialMap09Screens_Y1X1 ; entry 3

SpecialMap09Attrs::
    dfar SpecialMap09Attrs_Y0X0 ; entry 0
    dfar SpecialMap09Attrs_Y0X1 ; entry 1
    dfar SpecialMap09Attrs_Y1X0 ; entry 2
    dfar SpecialMap09Attrs_Y1X1 ; entry 3

; LZSS-compressed: 298 bytes that expand to 360 (E-0016, E-0017)
SpecialMap09Screens_Y0X0::
    INCBIN "maps/special_map09/screens_y0_x0.lz"

; LZSS-compressed: 234 bytes that expand to 360 (E-0016, E-0017)
SpecialMap09Screens_Y0X1::
    INCBIN "maps/special_map09/screens_y0_x1.lz"

; LZSS-compressed: 260 bytes that expand to 360 (E-0016, E-0017)
SpecialMap09Screens_Y1X0::
    INCBIN "maps/special_map09/screens_y1_x0.lz"

; LZSS-compressed: 253 bytes that expand to 360 (E-0016, E-0017)
SpecialMap09Screens_Y1X1::
    INCBIN "maps/special_map09/screens_y1_x1.lz"

; LZSS-compressed: 82 bytes that expand to 360 (E-0016, E-0017)
SpecialMap09Attrs_Y0X0::
    INCBIN "maps/special_map09/attrs_y0_x0.lz"

; LZSS-compressed: 49 bytes that expand to 360 (E-0016, E-0017)
SpecialMap09Attrs_Y0X1::
    db $68, $01, $01, $03, $01, $00, $0f, $3c, $01, $a4, $ff, $49, $04, $04, $02, $02
    db $01, $9c, $0f, $0f, $04, $01, $d2, $01, $01, $c4, $0f, $0f, $01, $d0, $02, $01
    db $ec, $0f, $11, $01, $d6, $ff, $1b, $01, $f6, $f6, $02, $01, $5c, $11, $01, $4c
    db $02

; LZSS-compressed: 46 bytes that expand to 360 (E-0016, E-0017)
SpecialMap09Attrs_Y1X0::
    db $68, $01, $04, $04, $ff, $ff, $2b, $02, $02, $04, $32, $0f, $05, $01, $01, $04
    db $32, $0e, $04, $58, $04, $04, $3e, $0a, $04, $e8, $ff, $43, $03, $03, $03, $03
    db $04, $3c, $0c, $04, $d8, $02, $04, $b2, $0f, $17, $04, $18, $1f, $39

; LZSS-compressed: 55 bytes that expand to 360 (E-0016, E-0017)
SpecialMap09Attrs_Y1X1::
    db $68, $01, $01, $01, $ff, $ff, $1f, $05, $01, $32, $01, $01, $ff, $f2, $02, $02
    db $02, $02, $01, $2e, $0c, $01, $2a, $0c, $03, $03, $01, $50, $0f, $0b, $01, $ff
    db $f4, $01, $76, $0f, $2b, $01, $76, $0f, $0d, $01, $3e, $04, $01, $ff, $ff, $15
    db $01, $c6, $00, $01, $18, $1f, $39

; compressed tileset of special map record 10 (SpecialMapRecords)
; LZSS-compressed: 990 bytes that expand to 1536 (E-0016, E-0017)
SpecialMap0ATileset::
    INCBIN "maps/special_map0/atileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
SpecialMap0APalettes::
    dw $49ae, $7fff, $4acd, $0000 ; entry 0
    dw $012f, $67ff, $01da, $0000 ; entry 1
    dw $012f, $3f7f, $029a, $0000 ; entry 2
    dw $1586, $3f7f, $02c0, $0000 ; entry 3
    dw $012f, $2e7f, $3cae, $0000 ; entry 4
    dw $7c01, $7fff, $7fe1, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap0AScreens::
    dfar SpecialMap0AScreens_Y0X0 ; entry 0
    dfar SpecialMap0AScreens_Y0X1 ; entry 1
    dfar SpecialMap0AScreens_Y1X0 ; entry 2
    dfar SpecialMap0AScreens_Y1X1 ; entry 3

SpecialMap0AAttrs::
    dfar SpecialMap0AAttrs_Y0X0 ; entry 0
    dfar SpecialMap0AAttrs_Y0X1 ; entry 1
    dfar SpecialMap0AAttrs_Y1X0 ; entry 2
    dfar SpecialMap0AAttrs_Y1X1 ; entry 3

; LZSS-compressed: 221 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0AScreens_Y0X0::
    INCBIN "maps/special_map0/ascreens_y0_x0.lz"

; LZSS-compressed: 237 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0AScreens_Y0X1::
    INCBIN "maps/special_map0/ascreens_y0_x1.lz"

; LZSS-compressed: 223 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0AScreens_Y1X0::
    INCBIN "maps/special_map0/ascreens_y1_x0.lz"

; LZSS-compressed: 265 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0AScreens_Y1X1::
    INCBIN "maps/special_map0/ascreens_y1_x1.lz"

; LZSS-compressed: 99 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0AAttrs_Y0X0::
    INCBIN "maps/special_map0/aattrs_y0_x0.lz"

; LZSS-compressed: 93 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0AAttrs_Y0X1::
    INCBIN "maps/special_map0/aattrs_y0_x1.lz"

; LZSS-compressed: 67 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0AAttrs_Y1X0::
    INCBIN "maps/special_map0/aattrs_y1_x0.lz"

; LZSS-compressed: 88 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0AAttrs_Y1X1::
    INCBIN "maps/special_map0/aattrs_y1_x1.lz"

; compressed tileset of special map record 11 (SpecialMapRecords)
; LZSS-compressed: 1143 bytes that expand to 1504 (E-0016, E-0017)
SpecialMap0BTileset::
    INCBIN "maps/special_map0/btileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
SpecialMap0BPalettes::
    dw $49ae, $7fff, $4acd, $0000 ; entry 0
    dw $012f, $67ff, $01da, $0000 ; entry 1
    dw $194a, $5f17, $3a33, $0000 ; entry 2
    dw $3c6b, $3a52, $2510, $0000 ; entry 3
    dw $3c6b, $4f18, $2510, $0000 ; entry 4
    dw $28e8, $4f18, $0dd5, $0000 ; entry 5
    dw $7c01, $7fff, $7fe1, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap0BScreens::
    dfar SpecialMap0BScreens_Y0X0 ; entry 0
    dfar SpecialMap0BScreens_Y0X1 ; entry 1
    dfar SpecialMap0BScreens_Y1X0 ; entry 2
    dfar SpecialMap0BScreens_Y1X1 ; entry 3

SpecialMap0BAttrs::
    dfar SpecialMap0BAttrs_Y0X0 ; entry 0
    dfar SpecialMap0BAttrs_Y0X1 ; entry 1
    dfar SpecialMap0BAttrs_Y1X0 ; entry 2
    dfar SpecialMap0BAttrs_Y1X1 ; entry 3

; LZSS-compressed: 289 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0BScreens_Y0X0::
    INCBIN "maps/special_map0/bscreens_y0_x0.lz"

; LZSS-compressed: 238 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0BScreens_Y0X1::
    INCBIN "maps/special_map0/bscreens_y0_x1.lz"

; LZSS-compressed: 288 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0BScreens_Y1X0::
    INCBIN "maps/special_map0/bscreens_y1_x0.lz"

; LZSS-compressed: 265 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0BScreens_Y1X1::
    INCBIN "maps/special_map0/bscreens_y1_x1.lz"

; LZSS-compressed: 121 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0BAttrs_Y0X0::
    INCBIN "maps/special_map0/battrs_y0_x0.lz"

; LZSS-compressed: 120 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0BAttrs_Y0X1::
    INCBIN "maps/special_map0/battrs_y0_x1.lz"

; LZSS-compressed: 124 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0BAttrs_Y1X0::
    INCBIN "maps/special_map0/battrs_y1_x0.lz"

; LZSS-compressed: 105 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0BAttrs_Y1X1::
    INCBIN "maps/special_map0/battrs_y1_x1.lz"

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap0CScreens::
    dfar SpecialMap0CScreens_Y0X0 ; entry 0
    dfar SpecialMap0CScreens_Y0X1 ; entry 1
    dfar SpecialMap0CScreens_Y1X0 ; entry 2
    dfar SpecialMap0CScreens_Y1X1 ; entry 3

SpecialMap0CAttrs::
    dfar SpecialMap0CAttrs_Y0X0 ; entry 0
    dfar SpecialMap0CAttrs_Y0X1 ; entry 1
    dfar SpecialMap0CAttrs_Y1X0 ; entry 2
    dfar SpecialMap0CAttrs_Y1X1 ; entry 3

; LZSS-compressed: 274 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0CScreens_Y0X0::
    INCBIN "maps/special_map0/cscreens_y0_x0.lz"

; LZSS-compressed: 237 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0CScreens_Y0X1::
    INCBIN "maps/special_map0/cscreens_y0_x1.lz"

; LZSS-compressed: 202 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0CScreens_Y1X0::
    INCBIN "maps/special_map0/cscreens_y1_x0.lz"

; LZSS-compressed: 249 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0CScreens_Y1X1::
    INCBIN "maps/special_map0/cscreens_y1_x1.lz"

; LZSS-compressed: 84 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0CAttrs_Y0X0::
    INCBIN "maps/special_map0/cattrs_y0_x0.lz"

; LZSS-compressed: 50 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0CAttrs_Y0X1::
    db $68, $01, $03, $02, $03, $00, $0f, $3e, $06, $03, $52, $01, $03, $44, $0f, $0d
    db $03, $52, $02, $06, $06, $01, $03, $80, $05, $03, $76, $0f, $11, $00, $00, $03
    db $9c, $0f, $13, $03, $86, $0f, $15, $03, $86, $0f, $07, $03, $50, $04, $03, $0c
    db $1f, $35

; LZSS-compressed: 79 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0CAttrs_Y1X0::
    INCBIN "maps/special_map0/cattrs_y1_x0.lz"

; LZSS-compressed: 69 bytes that expand to 360 (E-0016, E-0017)
SpecialMap0CAttrs_Y1X1::
    INCBIN "maps/special_map0/cattrs_y1_x1.lz"
    ds $c8, $00
