; ROM bank $47: map screens, attributes and tilesets
; The annotated listing of this bank is build/listing/bank47.asm.

SECTION "Bank 47", ROMX
    db $47

; compressed tileset of map $05 (the first map record using it)
; LZSS-compressed: 1889 bytes that expand to 2048 (E-0016, E-0017)
Map05Tileset::
    INCBIN "maps/map05/tileset.lz"

; 3 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map05Screens0::
    dfar Map05Screens0_Y0X0 ; entry 0
    dfar Map05Screens0_Y0X1 ; entry 1
    dfar Map05Screens0_Y0X2 ; entry 2

Map05Attrs0::
    dfar Map05Attrs0_Y0X0 ; entry 0
    dfar Map05Attrs0_Y0X1 ; entry 1
    dfar Map05Attrs0_Y0X2 ; entry 2

Map05Screens7::
    dfar Map05Screens0_Y0X0 ; entry 0
    dfar Map05Screens7_Y0X1 ; entry 1
    dfar Map05Screens0_Y0X2 ; entry 2

Map05Attrs7::
    dfar Map05Attrs0_Y0X0 ; entry 0
    dfar Map05Attrs7_Y0X1 ; entry 1
    dfar Map05Attrs0_Y0X2 ; entry 2

; LZSS-compressed: 254 bytes that expand to 360 (E-0016, E-0017)
Map05Screens0_Y0X0::
    INCBIN "maps/map05/screens0_y0_x0.lz"

KeyWorldScreen47_1::
    INCBIN "maps/key_worlds/screen47_1.lz"

Map05Screens0_Y0X1::
    INCBIN "maps/map05/screens0_y0_x1.lz"

Map05Screens7_Y0X1::
    INCBIN "maps/map05/screens7_y0_x1.lz"

; LZSS-compressed: 261 bytes that expand to 360 (E-0016, E-0017)
Map05Screens0_Y0X2::
    INCBIN "maps/map05/screens0_y0_x2.lz"

; LZSS-compressed: 84 bytes that expand to 360 (E-0016, E-0017)
Map05Attrs0_Y0X0::
    INCBIN "maps/map05/attrs0_y0_x0.lz"

KeyWorldScreen47_2::
    INCBIN "maps/key_worlds/screen47_2.lz"

; LZSS-compressed: 50 bytes that expand to 360 (E-0016, E-0017)
Map05Attrs0_Y0X1::
    db $68, $01, $00, $03, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $a4, $0f, $30
    db $04, $04, $00, $f2, $0f, $01, $04, $04, $03, $00, $05, $17, $00, $18, $10, $00
    db $28, $12, $00, $1f, $1f, $00, $00, $19, $15, $00, $3b, $19, $00, $2e, $12, $00
    db $28, $13

; LZSS-compressed: 56 bytes that expand to 360 (E-0016, E-0017)
Map05Attrs7_Y0X1::
    db $68, $01, $00, $03, $00, $00, $0f, $4d, $00, $20, $0f, $0c, $06, $06, $00, $6e
    db $0f, $13, $00, $a4, $0f, $49, $04, $04, $00, $f2, $0f, $01, $04, $04, $03, $00
    db $05, $17, $00, $18, $10, $00, $28, $12, $00, $1f, $1f, $00, $00, $19, $15, $00
    db $3b, $19, $00, $2e, $12, $00, $28, $13

; LZSS-compressed: 73 bytes that expand to 360 (E-0016, E-0017)
Map05Attrs0_Y0X2::
    INCBIN "maps/map05/attrs0_y0_x2.lz"

; compressed BG tiles, entry 1 of AreaTilesetTable
; LZSS-compressed: 1128 bytes that expand to 1504 (E-0016, E-0017)
AreaTileset1::
    INCBIN "gfx/area_tilesets/1.lz"

; entry 1 of AreaPaletteTable (E-0145, C1)
; record: one CGB palette: 4 BGR555 colours
AreaPalettes1::
    dw $7da0, $7fff, $7fe0, $0063 ; entry 0
    dw $012f, $031d, $01d8, $0000 ; entry 1
    dw $012f, $67ff, $0214, $0000 ; entry 2
    dw $4c08, $67ff, $02c0, $0063 ; entry 3
    dw $012f, $67ff, $02c0, $0063 ; entry 4
    dw $01e0, $031d, $02c0, $0063 ; entry 5
    dw $012f, $031d, $7fe0, $0063 ; entry 6
    dw $0063, $0063, $0020, $0020 ; entry 7

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map07Screens0::
    dfar Map07Screens0_Y0X0 ; entry 0
    dfar Map07Screens0_Y1X0 ; entry 1

Map07Attrs0::
    dfar Map07Attrs0_Y0X0 ; entry 0
    dfar Map07Attrs0_Y1X0 ; entry 1

Map07Screens7::
    dfar Map07Screens7_Y0X0 ; entry 0
    dfar Map07Screens0_Y1X0 ; entry 1

Map07Attrs7::
    dfar Map07Attrs7_Y0X0 ; entry 0
    dfar Map07Attrs0_Y1X0 ; entry 1

; LZSS-compressed: 182 bytes that expand to 360 (E-0016, E-0017)
Map07Screens0_Y0X0::
    INCBIN "maps/map07/screens0_y0_x0.lz"

; LZSS-compressed: 192 bytes that expand to 360 (E-0016, E-0017)
Map07Screens7_Y0X0::
    INCBIN "maps/map07/screens7_y0_x0.lz"

; LZSS-compressed: 237 bytes that expand to 360 (E-0016, E-0017)
Map07Screens0_Y1X0::
    INCBIN "maps/map07/screens0_y1_x0.lz"

; LZSS-compressed: 64 bytes that expand to 360 (E-0016, E-0017)
Map07Attrs0_Y0X0::
    db $68, $01, $03, $01, $03, $00, $0f, $16, $02, $03, $2a, $0b, $03, $26, $0f, $2d
    db $03, $28, $00, $03, $28, $06, $03, $00, $02, $00, $00, $02, $02, $03, $8e, $00
    db $03, $2a, $02, $03, $fe, $f2, $03, $8e, $0f, $01, $03, $7a, $0f, $01, $03, $52
    db $0f, $4d, $03, $76, $0f, $05, $03, $24, $08, $03, $1c, $0f, $01, $03, $88, $02

Map07Attrs7_Y0X0::
    db $68, $01, $03, $01, $03, $00, $0f, $16, $02, $03, $2a, $0b, $03, $26, $0f, $2d
    db $03, $28, $00, $03, $28, $06, $03, $00, $02, $00, $00, $02, $02, $03, $8e, $00
    db $03, $2a, $02, $03, $fe, $f2, $03, $8e, $0f, $01, $03, $7a, $0f, $01, $03, $52
    db $0f, $4d, $03, $76, $0f, $05, $03, $24, $08, $03, $1c, $0f, $01, $03, $88, $02

; LZSS-compressed: 101 bytes that expand to 360 (E-0016, E-0017)
Map07Attrs0_Y1X0::
    INCBIN "maps/map07/attrs0_y1_x0.lz"

; compressed tileset of map $08 (the first map record using it)
; LZSS-compressed: 591 bytes that expand to 1904 (E-0016, E-0017)
Map08Tileset::
    INCBIN "maps/map08/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map08Palettes::
    dw $39ce, $7fff, $56b5, $0063 ; entry 0
    dw $012f, $031d, $01d8, $0000 ; entry 1
    dw $012f, $67ff, $0214, $0000 ; entry 2
    dw $001b, $2bff, $023f, $0000 ; entry 3
    dw $158f, $4298, $2a13, $0000 ; entry 4
    dw $29ce, $4fff, $3695, $0020 ; entry 5
    dw $29ce, $4fff, $3695, $0020 ; entry 6
    dw $29ce, $4fff, $3695, $0020 ; entry 7

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map09Screens0::
    dfar Map09Screens0_Y0X0 ; entry 0

Map09Attrs0::
    dfar Map09Attrs0_Y0X0 ; entry 0

; LZSS-compressed: 132 bytes that expand to 360 (E-0016, E-0017)
Map08Screens0_Y0X0::
    INCBIN "maps/map08/screens0_y0_x0.lz"

; LZSS-compressed: 64 bytes that expand to 360 (E-0016, E-0017)
Map08Attrs0_Y0X0::
    db $68, $01, $05, $00, $00, $04, $05, $02, $09, $05, $fc, $ff, $31, $03, $03, $03
    db $03, $02, $02, $02, $02, $05, $48, $0f, $0d, $01, $05, $7c, $03, $05, $70, $0f
    db $0f, $05, $58, $00, $05, $58, $02, $05, $9c, $0f, $4d, $05, $c0, $0f, $01, $05
    db $82, $00, $05, $14, $1f, $09, $05, $02, $00, $05, $5a, $02, $05, $3a, $1f, $07

; compressed tileset of map $09 (the first map record using it)
; LZSS-compressed: 601 bytes that expand to 1600 (E-0016, E-0017)
Map09Tileset::
    INCBIN "maps/map09/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map09Palettes::
    dw $39ce, $7fff, $56b5, $0063 ; entry 0
    dw $012f, $031d, $01d8, $0000 ; entry 1
    dw $012f, $67ff, $0214, $0000 ; entry 2
    dw $1415, $4fff, $3c1f, $0000 ; entry 3
    dw $158f, $4298, $2a13, $0000 ; entry 4
    dw $3dec, $7fe0, $5ed4, $0063 ; entry 5
    dw $29ce, $4fff, $3695, $0020 ; entry 6
    dw $29ce, $4fff, $3695, $0020 ; entry 7

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map08Screens0::
    dfar Map08Screens0_Y0X0 ; entry 0

Map08Attrs0::
    dfar Map08Attrs0_Y0X0 ; entry 0

; LZSS-compressed: 140 bytes that expand to 360 (E-0016, E-0017)
Map09Screens0_Y0X0::
    INCBIN "maps/map09/screens0_y0_x0.lz"

; LZSS-compressed: 52 bytes that expand to 360 (E-0016, E-0017)
Map09Attrs0_Y0X0::
    db $68, $01, $03, $04, $03, $00, $0d, $03, $fe, $ff, $2d, $05, $05, $02, $03, $54
    db $07, $03, $4c, $0f, $2f, $03, $54, $04, $01, $03, $aa, $01, $03, $9c, $0f, $0f
    db $03, $96, $0f, $01, $03, $96, $0f, $49, $03, $00, $00, $03, $5e, $00, $03, $0a
    db $0c, $03, $46, $1a

; compressed tileset of map $0C (the first map record using it)
; LZSS-compressed: 937 bytes that expand to 1280 (E-0016, E-0017)
Map0CTileset::
    INCBIN "maps/map0_c/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map0CPalettes::
    dw $7d86, $7fff, $7fe1, $0000 ; entry 0
    dw $012f, $031d, $01d8, $0000 ; entry 1
    dw $012f, $67ff, $0214, $0000 ; entry 2
    dw $158f, $4298, $2a13, $0020 ; entry 3
    dw $158f, $4fff, $03e2, $0000 ; entry 4
    dw $29ce, $4fff, $3695, $0020 ; entry 5
    dw $0020, $0020, $0020, $0020 ; entry 6
    dw $0020, $0020, $0020, $0020 ; entry 7

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map0CScreens0::
    dfar Map0CScreens0_Y0X0 ; entry 0
    dfar Map0CScreens0_Y0X1 ; entry 1

Map0CAttrs0::
    dfar Map0CAttrs0_Y0X0 ; entry 0
    dfar Map0CAttrs0_Y0X1 ; entry 1

; LZSS-compressed: 150 bytes that expand to 360 (E-0016, E-0017)
Map0CScreens0_Y0X0::
    INCBIN "maps/map0_c/screens0_y0_x0.lz"

; LZSS-compressed: 230 bytes that expand to 360 (E-0016, E-0017)
Map0CScreens0_Y0X1::
    INCBIN "maps/map0_c/screens0_y0_x1.lz"

; LZSS-compressed: 60 bytes that expand to 360 (E-0016, E-0017)
Map0CAttrs0_Y0X0::
    db $68, $01, $00, $03, $00, $00, $0f, $3e, $02, $00, $52, $09, $04, $04, $00, $4e
    db $0e, $02, $02, $00, $00, $08, $01, $01, $00, $00, $0e, $00, $82, $0f, $21, $00
    db $66, $0f, $01, $00, $ca, $0f, $11, $00, $74, $00, $00, $f2, $0f, $01, $03, $03
    db $04, $04, $04, $04, $00, $ce, $0f, $11, $00, $00, $0f, $11

; LZSS-compressed: 79 bytes that expand to 360 (E-0016, E-0017)
Map0CAttrs0_Y0X1::
    INCBIN "maps/map0_c/attrs0_y0_x1.lz"

; compressed tileset of map $0D (the first map record using it)
; LZSS-compressed: 1352 bytes that expand to 1616 (E-0016, E-0017)
Map0DTileset::
    INCBIN "maps/map0_d/tileset.lz"

; The palette set of map $0D, which the breeding menu also uses: eight CGB background palettes of 4
; BGR555 colours ($40 bytes) that BreedMenu_RedrawListScreen_LoadTileset copies to wBGPaletteBuffer
; with CopyFromBankWaitVRAM (C = $40) after decompressing the matching tileset (Map0DTileset, bank
; $47), then sets wBGPaletteUploadRequest = $7F. (C1, E-0372)
; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map0DPalettes::
    dw $7da0, $7fff, $7fe0, $0063 ; entry 0
    dw $012f, $4fff, $01d8, $0c63 ; entry 1
    dw $1528, $2bff, $00ff, $0000 ; entry 2
    dw $012f, $2b3f, $01d8, $0000 ; entry 3
    dw $1528, $3695, $15ae, $0000 ; entry 4
    dw $001b, $2bff, $023f, $0000 ; entry 5
    dw $0188, $4fbf, $01d3, $0000 ; entry 6
    dw $0020, $0020, $0020, $0020 ; entry 7

; 8 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map0DScreens0::
    dfar Map0DScreens0_Y0X0 ; entry 0
    dfar Map0DScreens0_Y0X0 ; entry 1
    dfar Map0DScreens0_Y0X0 ; entry 2
    dfar Map0DScreens0_Y0X0 ; entry 3
    dfar Map0DScreens0_Y1X0 ; entry 4
    dfar Map0DScreens0_Y1X1 ; entry 5
    dfar Map0DScreens0_Y1X2 ; entry 6
    dfar Map0DScreens0_Y1X3 ; entry 7

Map0DAttrs0::
    dfar Map0DAttrs0_Y0X0 ; entry 0
    dfar Map0DAttrs0_Y0X0 ; entry 1
    dfar Map0DAttrs0_Y0X0 ; entry 2
    dfar Map0DAttrs0_Y0X0 ; entry 3
    dfar Map0DAttrs0_Y1X0 ; entry 4
    dfar Map0DAttrs0_Y1X1 ; entry 5
    dfar Map0DAttrs0_Y1X2 ; entry 6
    dfar Map0DAttrs0_Y1X3 ; entry 7

Map0DScreens4::
    dfar Map0DScreens0_Y0X0 ; entry 0
    dfar Map0DScreens0_Y0X0 ; entry 1
    dfar Map0DScreens0_Y0X0 ; entry 2
    dfar Map0DScreens0_Y0X0 ; entry 3
    dfar Map0DScreens0_Y1X0 ; entry 4
    dfar Map0DScreens0_Y1X1 ; entry 5
    dfar Map0DScreens0_Y1X2 ; entry 6
    dfar Map0DScreens0_Y1X3 ; entry 7

Map0DAttrs4::
    dfar Map0DAttrs0_Y0X0 ; entry 0
    dfar Map0DAttrs0_Y0X0 ; entry 1
    dfar Map0DAttrs0_Y0X0 ; entry 2
    dfar Map0DAttrs0_Y0X0 ; entry 3
    dfar Map0DAttrs0_Y1X0 ; entry 4
    dfar Map0DAttrs0_Y1X1 ; entry 5
    dfar Map0DAttrs0_Y1X2 ; entry 6
    dfar Map0DAttrs0_Y1X3 ; entry 7

Map0DScreens7::
    dfar Map0DScreens0_Y0X0 ; entry 0
    dfar Map0DScreens0_Y0X0 ; entry 1
    dfar Map0DScreens0_Y0X0 ; entry 2
    dfar Map0DScreens0_Y0X0 ; entry 3
    dfar Map0DScreens0_Y1X0 ; entry 4
    dfar Map0DScreens0_Y1X1 ; entry 5
    dfar Map0DScreens7_Y1X2 ; entry 6
    dfar Map0DScreens7_Y1X3 ; entry 7

Map0DAttrs7::
    dfar Map0DAttrs0_Y0X0 ; entry 0
    dfar Map0DAttrs0_Y0X0 ; entry 1
    dfar Map0DAttrs0_Y0X0 ; entry 2
    dfar Map0DAttrs0_Y0X0 ; entry 3
    dfar Map0DAttrs0_Y1X0 ; entry 4
    dfar Map0DAttrs0_Y1X1 ; entry 5
    dfar Map0DAttrs7_Y1X2 ; entry 6
    dfar Map0DAttrs7_Y1X3 ; entry 7

; LZSS-compressed: 179 bytes that expand to 360 (E-0016, E-0017)
Map0DScreens0_Y0X0::
    INCBIN "maps/map0_d/screens0_y0_x0.lz"

; LZSS-compressed: 108 bytes that expand to 360 (E-0016, E-0017)
Map0DScreens0_Y1X0::
    INCBIN "maps/map0_d/screens0_y1_x0.lz"

; Tile map: 360 bytes = one 20 x 18 screen of tile numbers, stored in the Map0D screen run of bank
; $47 between Map0DScreens0_Y1X0 and Map0DScreens0_Y1X1. It differs from Map0DScreens0_Y1X0 in four
; bytes only: the 2 x 2 block at columns 10-11, rows 16-17 holds tiles $42 $43 $42 $43 instead of
; $30 $31 $32 $33. No pointer to it exists: the Map0DScreens0, Map0DScreens4 and Map0DScreens7
; tables never list it and no ld de load of $69D1 was found. Rendered with Map0DTileset (vTiles2):
; rocky cave floor on black, only the lower right part of a room, the same picture as
; Map0DScreens0_Y1X0 apart from the small block. (C1, E-0383)
; LZSS-compressed: 107 bytes that expand to 360 (E-0016, E-0017)
Map0DScreenY1X0AltBlock::
    INCBIN "maps/map0_d/screen_y1_x0_alt_block.lz"

; LZSS-compressed: 206 bytes that expand to 360 (E-0016, E-0017)
Map0DScreens0_Y1X1::
    INCBIN "maps/map0_d/screens0_y1_x1.lz"

; LZSS-compressed: 73 bytes that expand to 360 (E-0016, E-0017)
Map0DScreens0_Y1X2::
    INCBIN "maps/map0_d/screens0_y1_x2.lz"

; LZSS-compressed: 72 bytes that expand to 360 (E-0016, E-0017)
Map0DScreens7_Y1X2::
    INCBIN "maps/map0_d/screens7_y1_x2.lz"

; LZSS-compressed: 111 bytes that expand to 360 (E-0016, E-0017)
Map0DScreens0_Y1X3::
    INCBIN "maps/map0_d/screens0_y1_x3.lz"

; LZSS-compressed: 109 bytes that expand to 360 (E-0016, E-0017)
Map0DScreens7_Y1X3::
    INCBIN "maps/map0_d/screens7_y1_x3.lz"

; LZSS-compressed: 139 bytes that expand to 360 (E-0016, E-0017)
Map0DAttrs0_Y0X0::
    INCBIN "maps/map0_d/attrs0_y0_x0.lz"

; LZSS-compressed: 29 bytes that expand to 360 (E-0016, E-0017)
Map0DAttrs0_Y1X0::
    db $68, $01, $00, $04, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $76, $0f, $02
    db $02, $02, $00, $c4, $0f, $13, $00, $fd, $0f, $4d, $00, $08, $16, $68, $01, $00
    db $04, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $76, $0f, $02, $02, $02, $00
    db $c4, $0f, $13, $00, $fd, $0f, $4d, $00, $08, $16

; LZSS-compressed: 110 bytes that expand to 360 (E-0016, E-0017)
Map0DAttrs0_Y1X1::
    INCBIN "maps/map0_d/attrs0_y1_x1.lz"

Map0DAttrs0_Y1X2::
    db $68, $01, $00, $04, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $6c, $07, $02
    db $02, $00, $ba, $0f, $13, $00, $f3, $0f, $4d, $00, $08, $1f, $01

Map0DAttrs7_Y1X2::
    db $68, $01, $00, $04, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $6c, $07, $02
    db $02, $00, $c4, $0f, $13, $00, $f3, $0f, $4d, $00, $08, $1f, $01

Map0DAttrs0_Y1X3::
    db $68, $01, $00, $04, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $6c, $07, $02
    db $02, $00, $ba, $0f, $13, $00, $f3, $0f, $4d, $00, $08, $1f, $01

Map0DAttrs7_Y1X3::
    db $68, $01, $00, $04, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $6c, $07, $02
    db $02, $00, $ba, $0f, $13, $00, $f3, $0f, $4d, $00, $08, $1f, $01

; compressed tileset of map $0E (the first map record using it)
; LZSS-compressed: 845 bytes that expand to 1040 (E-0016, E-0017)
Map0ETileset::
    INCBIN "maps/map0_e/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map0EPalettes::
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
Map0EScreens0::
    dfar Map0EScreens0_Y0X0 ; entry 0

Map0EAttrs0::
    dfar Map0EAttrs0_Y0X0 ; entry 0

; LZSS-compressed: 200 bytes that expand to 360 (E-0016, E-0017)
Map0EScreens0_Y0X0::
    INCBIN "maps/map0_e/screens0_y0_x0.lz"

; LZSS-compressed: 69 bytes that expand to 360 (E-0016, E-0017)
Map0EAttrs0_Y0X0::
    INCBIN "maps/map0_e/attrs0_y0_x0.lz"

; compressed tileset of map $0F (the first map record using it)
; LZSS-compressed: 1370 bytes that expand to 1568 (E-0016, E-0017)
Map0FTileset::
    INCBIN "maps/map0_f/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map0FPalettes::
    dw $7d86, $7fff, $7fe1, $0000 ; entry 0
    dw $012f, $031d, $01d8, $0000 ; entry 1
    dw $012f, $67ff, $0214, $0000 ; entry 2
    dw $158f, $4298, $2a13, $0020 ; entry 3
    dw $012f, $4fff, $5d1f, $0000 ; entry 4
    dw $001b, $2bff, $023f, $0000 ; entry 5
    dw $03e2, $4fff, $5d1f, $0020 ; entry 6
    dw $0020, $0020, $0020, $0020 ; entry 7

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map0FScreens0::
    dfar Map0FScreens0_Y0X0 ; entry 0

Map0FAttrs0::
    dfar Map0FAttrs0_Y0X0 ; entry 0

Map0FScreens7::
    dfar Map0FScreens7_Y0X0 ; entry 0

Map0FAttrs7::
    dfar Map0FAttrs7_Y0X0 ; entry 0

; LZSS-compressed: 191 bytes that expand to 360 (E-0016, E-0017)
Map0FScreens0_Y0X0::
    INCBIN "maps/map0_f/screens0_y0_x0.lz"

; LZSS-compressed: 264 bytes that expand to 360 (E-0016, E-0017)
Map0FScreens7_Y0X0::
    INCBIN "maps/map0_f/screens7_y0_x0.lz"

; LZSS-compressed: 95 bytes that expand to 360 (E-0016, E-0017)
Map0FAttrs0_Y0X0::
    INCBIN "maps/map0_f/attrs0_y0_x0.lz"

; LZSS-compressed: 128 bytes that expand to 360 (E-0016, E-0017)
Map0FAttrs7_Y0X0::
    INCBIN "maps/map0_f/attrs7_y0_x0.lz"

; compressed tileset of map $10 (the first map record using it)
; LZSS-compressed: 666 bytes that expand to 800 (E-0016, E-0017)
Map10Tileset::
    INCBIN "maps/map10/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map10Palettes::
    dw $7d86, $7fff, $7fe1, $0000 ; entry 0
    dw $012f, $031d, $01d8, $0000 ; entry 1
    dw $012f, $67ff, $0214, $0000 ; entry 2
    dw $158f, $4298, $2a13, $0020 ; entry 3
    dw $158f, $4fff, $03e2, $0000 ; entry 4
    dw $012f, $4fff, $5d1f, $0020 ; entry 5
    dw $03e2, $4fff, $5d1f, $0020 ; entry 6
    dw $29ce, $4fff, $5a3f, $0020 ; entry 7

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map10Screens0::
    dfar Map10Screens0_Y0X0 ; entry 0

Map10Attrs0::
    dfar Map10Attrs0_Y0X0 ; entry 0

; LZSS-compressed: 166 bytes that expand to 360 (E-0016, E-0017)
Map10Screens0_Y0X0::
    INCBIN "maps/map10/screens0_y0_x0.lz"

; LZSS-compressed: 107 bytes that expand to 360 (E-0016, E-0017)
Map10Attrs0_Y0X0::
    INCBIN "maps/map10/attrs0_y0_x0.lz"
    ds $105, $00
