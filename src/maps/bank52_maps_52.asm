; ROM bank $52: map screens, attributes and tilesets
; The annotated listing of this bank is build/listing/bank52.asm.

SECTION "Bank 52", ROMX
    db $52

; compressed tileset of map $73 (the first map record using it)
; LZSS-compressed: 1346 bytes that expand to 1792 (E-0016, E-0017)
Map73Tileset::
    INCBIN "maps/map73/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map73Palettes::
    dw $7d86, $7fff, $7fe1, $0000 ; entry 0
    dw $48ec, $6bff, $4a6f, $0000 ; entry 1
    dw $0263, $3f7f, $03e7, $00a0 ; entry 2
    dw $0130, $36de, $1e7e, $0000 ; entry 3
    dw $0189, $535e, $35f3, $0000 ; entry 4
    dw $001b, $2bff, $023f, $0000 ; entry 5
    dw $484c, $7fff, $2bff, $0000 ; entry 6
    dw $00a0, $00a0, $00a0, $00a0 ; entry 7

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map73Screens0::
    dfar Map73Screens0_Y0X0 ; entry 0
    dfar Map73Screens0_Y0X1 ; entry 1
    dfar Map73Screens0_Y1X0 ; entry 2
    dfar Map73Screens0_Y1X1 ; entry 3

Map73Attrs0::
    dfar Map73Attrs0_Y0X0 ; entry 0
    dfar Map73Attrs0_Y0X1 ; entry 1
    dfar Map73Attrs0_Y1X0 ; entry 2
    dfar Map73Attrs0_Y1X1 ; entry 3

; LZSS-compressed: 188 bytes that expand to 360 (E-0016, E-0017)
Map73Screens0_Y0X0::
    INCBIN "maps/map73/screens0_y0_x0.lz"

; LZSS-compressed: 165 bytes that expand to 360 (E-0016, E-0017)
Map73Screens0_Y0X1::
    INCBIN "maps/map73/screens0_y0_x1.lz"

; LZSS-compressed: 227 bytes that expand to 360 (E-0016, E-0017)
Map73Screens0_Y1X0::
    INCBIN "maps/map73/screens0_y1_x0.lz"

; LZSS-compressed: 191 bytes that expand to 360 (E-0016, E-0017)
Map73Screens0_Y1X1::
    INCBIN "maps/map73/screens0_y1_x1.lz"

; LZSS-compressed: 74 bytes that expand to 360 (E-0016, E-0017)
Map73Attrs0_Y0X0::
    INCBIN "maps/map73/attrs0_y0_x0.lz"

; LZSS-compressed: 70 bytes that expand to 360 (E-0016, E-0017)
Map73Attrs0_Y0X1::
    INCBIN "maps/map73/attrs0_y0_x1.lz"

; LZSS-compressed: 78 bytes that expand to 360 (E-0016, E-0017)
Map73Attrs0_Y1X0::
    INCBIN "maps/map73/attrs0_y1_x0.lz"

; LZSS-compressed: 75 bytes that expand to 360 (E-0016, E-0017)
Map73Attrs0_Y1X1::
    INCBIN "maps/map73/attrs0_y1_x1.lz"

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map74Screens0::
    dfar Map74Screens0_Y0X0 ; entry 0
    dfar Map74Screens0_Y0X1 ; entry 1
    dfar Map74Screens0_Y1X0 ; entry 2
    dfar Map74Screens0_Y1X1 ; entry 3

Map74Attrs0::
    dfar Map74Attrs0_Y0X0 ; entry 0
    dfar Map74Attrs0_Y0X1 ; entry 1
    dfar Map74Attrs0_Y1X0 ; entry 2
    dfar Map74Attrs0_Y1X1 ; entry 3

; LZSS-compressed: 187 bytes that expand to 360 (E-0016, E-0017)
Map74Screens0_Y0X0::
    INCBIN "maps/map74/screens0_y0_x0.lz"

; LZSS-compressed: 153 bytes that expand to 360 (E-0016, E-0017)
Map74Screens0_Y0X1::
    INCBIN "maps/map74/screens0_y0_x1.lz"

; LZSS-compressed: 201 bytes that expand to 360 (E-0016, E-0017)
Map74Screens0_Y1X0::
    INCBIN "maps/map74/screens0_y1_x0.lz"

; LZSS-compressed: 181 bytes that expand to 360 (E-0016, E-0017)
Map74Screens0_Y1X1::
    INCBIN "maps/map74/screens0_y1_x1.lz"

; LZSS-compressed: 73 bytes that expand to 360 (E-0016, E-0017)
Map74Attrs0_Y0X0::
    INCBIN "maps/map74/attrs0_y0_x0.lz"

; LZSS-compressed: 62 bytes that expand to 360 (E-0016, E-0017)
Map74Attrs0_Y0X1::
    db $68, $01, $02, $01, $02, $00, $0b, $02, $fc, $ff, $15, $02, $0e, $00, $02, $28
    db $0f, $13, $02, $50, $0f, $03, $04, $02, $78, $07, $02, $70, $0f, $15, $02, $82
    db $04, $02, $a0, $0f, $01, $02, $6c, $0c, $02, $c4, $0f, $11, $02, $d2, $0f, $09
    db $02, $7a, $0a, $02, $12, $1f, $07, $02, $76, $06, $02, $36, $1f, $0b

; LZSS-compressed: 67 bytes that expand to 360 (E-0016, E-0017)
Map74Attrs0_Y1X0::
    INCBIN "maps/map74/attrs0_y1_x0.lz"

Map74Attrs0_Y1X1::
    INCBIN "maps/map74/attrs0_y1_x1.lz"

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map75Screens0::
    dfar Map75Screens0_Y0X0 ; entry 0
    dfar Map75Screens0_Y0X1 ; entry 1
    dfar Map75Screens0_Y1X0 ; entry 2
    dfar Map75Screens0_Y1X1 ; entry 3

Map75Attrs0::
    dfar Map75Attrs0_Y0X0 ; entry 0
    dfar Map75Attrs0_Y0X1 ; entry 1
    dfar Map75Attrs0_Y1X0 ; entry 2
    dfar Map75Attrs0_Y1X1 ; entry 3

; LZSS-compressed: 228 bytes that expand to 360 (E-0016, E-0017)
Map75Screens0_Y0X0::
    INCBIN "maps/map75/screens0_y0_x0.lz"

; LZSS-compressed: 208 bytes that expand to 360 (E-0016, E-0017)
Map75Screens0_Y0X1::
    INCBIN "maps/map75/screens0_y0_x1.lz"

; LZSS-compressed: 180 bytes that expand to 360 (E-0016, E-0017)
Map75Screens0_Y1X0::
    INCBIN "maps/map75/screens0_y1_x0.lz"

Map75Screens0_Y1X1::
    INCBIN "maps/map75/screens0_y1_x1.lz"

; LZSS-compressed: 94 bytes that expand to 360 (E-0016, E-0017)
Map75Attrs0_Y0X0::
    INCBIN "maps/map75/attrs0_y0_x0.lz"

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
Map75Attrs0_Y0X1::
    INCBIN "maps/map75/attrs0_y0_x1.lz"

; LZSS-compressed: 54 bytes that expand to 360 (E-0016, E-0017)
Map75Attrs0_Y1X0::
    db $68, $01, $00, $01, $00, $00, $09, $04, $04, $04, $04, $00, $00, $0a, $00, $0c
    db $0f, $25, $00, $0e, $00, $00, $58, $02, $00, $4e, $0f, $0b, $00, $76, $0f, $3d
    db $00, $70, $0f, $01, $00, $d0, $0f, $07, $00, $10, $00, $00, $10, $06, $00, $f8
    db $0f, $01, $00, $56, $0f, $35

; LZSS-compressed: 59 bytes that expand to 360 (E-0016, E-0017)
Map75Attrs0_Y1X1::
    db $68, $01, $00, $01, $00, $00, $0f, $42, $04, $04, $00, $44, $0f, $11, $04, $00
    db $7c, $01, $00, $54, $0a, $00, $7c, $0e, $00, $7c, $02, $00, $7c, $04, $00, $9c
    db $0f, $05, $00, $7c, $06, $00, $be, $0f, $0f, $00, $ce, $0a, $00, $ee, $0f, $07
    db $00, $a8, $0a, $00, $16, $1f, $03, $00, $00, $0f, $15

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map76Screens0::
    dfar Map76Screens0_Y0X0 ; entry 0
    dfar Map76Screens0_Y0X1 ; entry 1
    dfar Map76Screens0_Y1X0 ; entry 2
    dfar Map76Screens0_Y1X1 ; entry 3

Map76Attrs0::
    dfar Map76Attrs0_Y0X0 ; entry 0
    dfar Map76Attrs0_Y0X1 ; entry 1
    dfar Map76Attrs0_Y1X0 ; entry 2
    dfar Map76Attrs0_Y1X1 ; entry 3

; LZSS-compressed: 246 bytes that expand to 360 (E-0016, E-0017)
Map76Screens0_Y0X0::
    INCBIN "maps/map76/screens0_y0_x0.lz"

; LZSS-compressed: 188 bytes that expand to 360 (E-0016, E-0017)
Map76Screens0_Y0X1::
    INCBIN "maps/map76/screens0_y0_x1.lz"

; LZSS-compressed: 201 bytes that expand to 360 (E-0016, E-0017)
Map76Screens0_Y1X0::
    INCBIN "maps/map76/screens0_y1_x0.lz"

; LZSS-compressed: 198 bytes that expand to 360 (E-0016, E-0017)
Map76Screens0_Y1X1::
    INCBIN "maps/map76/screens0_y1_x1.lz"

; LZSS-compressed: 125 bytes that expand to 360 (E-0016, E-0017)
Map76Attrs0_Y0X0::
    INCBIN "maps/map76/attrs0_y0_x0.lz"

; LZSS-compressed: 75 bytes that expand to 360 (E-0016, E-0017)
Map76Attrs0_Y0X1::
    INCBIN "maps/map76/attrs0_y0_x1.lz"

; LZSS-compressed: 53 bytes that expand to 360 (E-0016, E-0017)
Map76Attrs0_Y1X0::
    db $68, $01, $02, $00, $01, $02, $01, $0e, $02, $00, $0f, $01, $02, $15, $0f, $1b
    db $04, $04, $04, $04, $02, $46, $0f, $11, $02, $54, $00, $02, $7e, $06, $02, $78
    db $0f, $07, $02, $80, $0f, $13, $02, $7c, $08, $02, $c4, $0f, $0d, $02, $a4, $0f
    db $19, $02, $18, $1f, $31

; LZSS-compressed: 66 bytes that expand to 360 (E-0016, E-0017)
Map76Attrs0_Y1X1::
    INCBIN "maps/map76/attrs0_y1_x1.lz"

; compressed tileset of map $77 (the first map record using it)
; LZSS-compressed: 1299 bytes that expand to 1536 (E-0016, E-0017)
Map77Tileset::
    INCBIN "maps/map77/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map77Palettes::
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
Map77Screens0::
    dfar Map77Screens0_Y0X0 ; entry 0
    dfar Map77Screens0_Y0X1 ; entry 1
    dfar Map77Screens0_Y0X2 ; entry 2

Map77Attrs0::
    dfar Map77Attrs0_Y0X0 ; entry 0
    dfar Map77Attrs0_Y0X1 ; entry 1
    dfar Map77Attrs0_Y0X2 ; entry 2

; LZSS-compressed: 313 bytes that expand to 360 (E-0016, E-0017)
Map77Screens0_Y0X0::
    INCBIN "maps/map77/screens0_y0_x0.lz"

; LZSS-compressed: 82 bytes that expand to 360 (E-0016, E-0017)
Map77Screens0_Y0X1::
    INCBIN "maps/map77/screens0_y0_x1.lz"

; LZSS-compressed: 308 bytes that expand to 360 (E-0016, E-0017)
Map77Screens0_Y0X2::
    INCBIN "maps/map77/screens0_y0_x2.lz"

; LZSS-compressed: 103 bytes that expand to 360 (E-0016, E-0017)
Map77Attrs0_Y0X0::
    INCBIN "maps/map77/attrs0_y0_x0.lz"

; LZSS-compressed: 24 bytes that expand to 360 (E-0016, E-0017)
Map77Attrs0_Y0X1::
    db $68, $01, $01, $01, $ff, $ff, $29, $04, $01, $3c, $0f, $3c, $01, $a0, $ff, $4d
    db $01, $eb, $0f, $4d, $01, $4b, $1f, $09

; LZSS-compressed: 111 bytes that expand to 360 (E-0016, E-0017)
Map77Attrs0_Y0X2::
    INCBIN "maps/map77/attrs0_y0_x2.lz"

; compressed tileset of map $78 (the first map record using it)
; LZSS-compressed: 1374 bytes that expand to 1520 (E-0016, E-0017)
Map78Tileset::
    INCBIN "maps/map78/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map78Palettes::
    dw $7da0, $7fff, $7fe0, $0000 ; entry 0
    dw $00ed, $7fff, $11d4, $0000 ; entry 1
    dw $00ed, $22ba, $11d4, $0000 ; entry 2
    dw $01c4, $3f7f, $0348, $0000 ; entry 3
    dw $00ed, $3f7f, $01da, $0000 ; entry 4
    dw $00ed, $033f, $34d9, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 4 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map78Screens0::
    dfar Map78Screens0_Y0X0 ; entry 0
    dfar Map78Screens0_Y0X1 ; entry 1
    dfar Map78Screens0_Y1X0 ; entry 2
    dfar Map78Screens0_Y1X1 ; entry 3

Map78Attrs0::
    dfar Map78Attrs0_Y0X0 ; entry 0
    dfar Map78Attrs0_Y0X1 ; entry 1
    dfar Map78Attrs0_Y1X0 ; entry 2
    dfar Map78Attrs0_Y1X1 ; entry 3

; LZSS-compressed: 295 bytes that expand to 360 (E-0016, E-0017)
Map78Screens0_Y0X0::
    INCBIN "maps/map78/screens0_y0_x0.lz"

; LZSS-compressed: 292 bytes that expand to 360 (E-0016, E-0017)
Map78Screens0_Y0X1::
    INCBIN "maps/map78/screens0_y0_x1.lz"

; LZSS-compressed: 311 bytes that expand to 360 (E-0016, E-0017)
Map78Screens0_Y1X0::
    INCBIN "maps/map78/screens0_y1_x0.lz"

; LZSS-compressed: 288 bytes that expand to 360 (E-0016, E-0017)
Map78Screens0_Y1X1::
    INCBIN "maps/map78/screens0_y1_x1.lz"

; LZSS-compressed: 91 bytes that expand to 360 (E-0016, E-0017)
Map78Attrs0_Y0X0::
    INCBIN "maps/map78/attrs0_y0_x0.lz"

; LZSS-compressed: 137 bytes that expand to 360 (E-0016, E-0017)
Map78Attrs0_Y0X1::
    INCBIN "maps/map78/attrs0_y0_x1.lz"

; LZSS-compressed: 108 bytes that expand to 360 (E-0016, E-0017)
Map78Attrs0_Y1X0::
    INCBIN "maps/map78/attrs0_y1_x0.lz"

; LZSS-compressed: 55 bytes that expand to 360 (E-0016, E-0017)
Map78Attrs0_Y1X1::
    db $68, $01, $00, $03, $00, $00, $03, $04, $04, $04, $04, $00, $00, $04, $00, $00
    db $0f, $01, $02, $00, $28, $03, $00, $08, $00, $00, $30, $02, $00, $26, $0f, $4d
    db $00, $08, $02, $00, $30, $06, $00, $96, $0f, $33, $00, $2e, $02, $00, $f0, $0a
    db $00, $03, $1f, $4d, $00, $3c, $00

; compressed tileset of map $79 (the first map record using it)
; LZSS-compressed: 1106 bytes that expand to 1280 (E-0016, E-0017)
Map79Tileset::
    INCBIN "maps/map79/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map79Palettes::
    dw $7da0, $7fff, $7fe0, $0000 ; entry 0
    dw $00ed, $3f7f, $11d4, $0000 ; entry 1
    dw $00ed, $22ba, $11d4, $0000 ; entry 2
    dw $00ed, $7fff, $11d4, $0000 ; entry 3
    dw $00ed, $3f7f, $01da, $0000 ; entry 4
    dw $0000, $0000, $0000, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map79Screens0::
    dfar Map79Screens0_Y0X0 ; entry 0
    dfar Map79Screens0_Y1X0 ; entry 1

Map79Attrs0::
    dfar Map79Attrs0_Y0X0 ; entry 0
    dfar Map79Attrs0_Y1X0 ; entry 1

; LZSS-compressed: 281 bytes that expand to 360 (E-0016, E-0017)
Map79Screens0_Y0X0::
    INCBIN "maps/map79/screens0_y0_x0.lz"

; LZSS-compressed: 213 bytes that expand to 360 (E-0016, E-0017)
Map79Screens0_Y1X0::
    INCBIN "maps/map79/screens0_y1_x0.lz"

; LZSS-compressed: 62 bytes that expand to 360 (E-0016, E-0017)
Map79Attrs0_Y0X0::
    db $68, $01, $04, $02, $04, $00, $02, $04, $f5, $fe, $02, $03, $04, $f5, $fe, $04
    db $1a, $08, $04, $ff, $ff, $00, $04, $fe, $fe, $01, $04, $12, $04, $04, $06, $07
    db $04, $5f, $05, $04, $06, $05, $04, $5e, $06, $04, $05, $06, $04, $85, $07, $04
    db $a2, $0f, $4d, $04, $17, $00, $03, $04, $04, $12, $04, $a6, $0f, $47

; LZSS-compressed: 41 bytes that expand to 360 (E-0016, E-0017)
Map79Attrs0_Y1X0::
    db $68, $01, $00, $02, $00, $00, $0f, $0a, $04, $04, $00, $0c, $0f, $01, $00, $32
    db $02, $00, $26, $0f, $35, $00, $7e, $0f, $49, $03, $03, $00, $dc, $02, $00, $dc
    db $08, $00, $f1, $0f, $4d, $00, $00, $0f, $03

; compressed tileset of map $7A (the first map record using it)
; LZSS-compressed: 1569 bytes that expand to 1728 (E-0016, E-0017)
Map7ATileset::
    INCBIN "maps/map7_a/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map7APalettes::
    dw $7d86, $7fff, $7fe1, $0000 ; entry 0
    dw $01a0, $3f7f, $03e7, $0000 ; entry 1
    dw $00ed, $3f7f, $01da, $0000 ; entry 2
    dw $7d86, $3f7f, $01da, $0000 ; entry 3
    dw $001b, $2bff, $023f, $0000 ; entry 4
    dw $00ed, $17e5, $01da, $0000 ; entry 5
    dw $00ed, $7fff, $01da, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map7AScreens0::
    dfar Map7AScreens0_Y0X0 ; entry 0
    dfar Map7AScreens0_Y1X0 ; entry 1

Map7AAttrs0::
    dfar Map7AAttrs0_Y0X0 ; entry 0
    dfar Map7AAttrs0_Y1X0 ; entry 1

; LZSS-compressed: 273 bytes that expand to 360 (E-0016, E-0017)
Map7AScreens0_Y0X0::
    INCBIN "maps/map7_a/screens0_y0_x0.lz"

; LZSS-compressed: 265 bytes that expand to 360 (E-0016, E-0017)
Map7AScreens0_Y1X0::
    INCBIN "maps/map7_a/screens0_y1_x0.lz"

; LZSS-compressed: 145 bytes that expand to 360 (E-0016, E-0017)
Map7AAttrs0_Y0X0::
    INCBIN "maps/map7_a/attrs0_y0_x0.lz"

; LZSS-compressed: 79 bytes that expand to 360 (E-0016, E-0017)
Map7AAttrs0_Y1X0::
    INCBIN "maps/map7_a/attrs0_y1_x0.lz"

; compressed tileset of map $8B (the first map record using it)
; LZSS-compressed: 1042 bytes that expand to 1344 (E-0016, E-0017)
Map8BTileset::
    INCBIN "maps/map8_b/tileset.lz"
