; ROM bank $90: map screens, attributes and tilesets
; The annotated listing of this bank is build/listing/bank90.asm.

SECTION "Bank 90", ROMX[$4000], BANK[$90]
    db $90

; compressed BG tiles (2048 bytes, 128 tiles) of key-world kind 0: entry 0 of KeyWorldTilesetTable,
; decompressed to vTiles2 by LoadKeyWorldTilesetAndHeader
; LZSS-compressed: 1166 bytes that expand to 2048 (E-0016, E-0017)
KeyWorldTiles0::
    INCBIN "maps/key_worlds/tiles0.lz"

; entry 0 of KeyWorldTilesetTable; LoadKeyWorldTilesetAndHeader copies these $40 bytes to
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

; entry 2 of KeyWorldTilesetTable; LoadKeyWorldTilesetAndHeader copies these $40 bytes to
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
    INCBIN "maps/map26/tileset.lz"

; compressed tileset of map $29 (the first map record using it)
; LZSS-compressed: 1014 bytes that expand to 1264 (E-0016, E-0017)
Map29Tileset::
    INCBIN "maps/map29/tileset.lz"

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
    INCBIN "maps/map29/screens0_y0_x0.lz"

; LZSS-compressed: 114 bytes that expand to 360 (E-0016, E-0017)
Map29Attrs0_Y0X0::
    INCBIN "maps/map29/attrs0_y0_x0.lz"

; compressed tileset of map $3D (the first map record using it)
; LZSS-compressed: 676 bytes that expand to 1168 (E-0016, E-0017)
Map3DTileset::
    INCBIN "maps/map3_d/tileset.lz"

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
    INCBIN "maps/map3_d/screens0_y0_x0.lz"

; LZSS-compressed: 77 bytes that expand to 360 (E-0016, E-0017)
Map3DAttrs0_Y0X0::
    INCBIN "maps/map3_d/attrs0_y0_x0.lz"

; compressed tileset of map $4B (the first map record using it)
; LZSS-compressed: 697 bytes that expand to 912 (E-0016, E-0017)
Map4BTileset::
    INCBIN "maps/map4_b/tileset.lz"

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
    INCBIN "maps/map4_b/screens0_y0_x0.lz"

; LZSS-compressed: 74 bytes that expand to 360 (E-0016, E-0017)
Map4BAttrs0_Y0X0::
    INCBIN "maps/map4_b/attrs0_y0_x0.lz"

; Tiles, 736 bytes decompressed (46 tiles). The tileset of map record MapRecordX59E4 (a map record
; no MapTable entry points to), which LoadMapHeader decompresses to vTiles2 with a 20 x 18 tile
; screen indexing it from tile 0. Rendered together with IceDoorRoomTilemap, its attribute stream
; (at MapX59E4Attrs0_Y0X0, raw in the source) and MapX59E4Palettes: an ice room, blue striped
; ice-block walls and a white snow floor with a grey herringbone stone path running up the middle to
; a wooden door with gold hinges and a lock at the top. (C1, E-0383)
; LZSS-compressed: 575 bytes that expand to 736 (E-0016, E-0017)
IceDoorRoomTileset::
    INCBIN "gfx/misc/ice_door_room_tileset.lz"

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
    dfar IceDoorRoomTilemap ; entry 0

MapX59E4Attrs0::
    dfar MapX59E4Attrs0_Y0X0 ; entry 0

; Tile map, 360 bytes decompressed (20 x 18 screen, one tile number per cell, 0 to 45). Screen (0,0)
; of the 1 x 1 screen map record MapRecordX59E4, decompressed into wScreenTileBuffer by
; LoadMapScreen and indexing IceDoorRoomTileset; its attribute map is MapX59E4Attrs0_Y0X0. Rendered:
; the ice room (ice walls, snow, stone path, door at the top). (C1, E-0383)
; LZSS-compressed: 164 bytes that expand to 360 (E-0016, E-0017)
IceDoorRoomTilemap::
    INCBIN "gfx/misc/ice_door_room_tilemap.lz"

; LZSS-compressed: 61 bytes that expand to 360 (E-0016, E-0017)
MapX59E4Attrs0_Y0X0::
    db $68, $01, $04, $04, $ff, $f0, $02, $04, $04, $07, $04, $fc, $ff, $07, $04, $04
    db $04, $01, $01, $04, $0a, $06, $04, $2a, $0f, $05, $03, $04, $56, $03, $04, $4a
    db $0f, $0b, $04, $56, $04, $04, $5a, $02, $04, $76, $0f, $4d, $04, $ae, $0f, $1f
    db $04, $54, $0f, $13, $04, $50, $06, $04, $0c, $0c, $04, $48, $18

; compressed tileset of map $97 (the first map record using it)
; LZSS-compressed: 976 bytes that expand to 1792 (E-0016, E-0017)
Map97Tileset::
    INCBIN "maps/map97/tileset.lz"

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
    INCBIN "maps/map97/screens0_y0_x0.lz"

; LZSS-compressed: 189 bytes that expand to 360 (E-0016, E-0017)
Map98Screens0_Y0X0::
    INCBIN "maps/map98/screens0_y0_x0.lz"

; LZSS-compressed: 204 bytes that expand to 360 (E-0016, E-0017)
Map99Screens0_Y0X0::
    INCBIN "maps/map99/screens0_y0_x0.lz"

; LZSS-compressed: 215 bytes that expand to 360 (E-0016, E-0017)
Map9AScreens0_Y0X0::
    INCBIN "maps/map9_a/screens0_y0_x0.lz"

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
    INCBIN "maps/map9_b/tileset.lz"

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
    INCBIN "maps/map9_b/screens0_y0_x0.lz"

; LZSS-compressed: 198 bytes that expand to 360 (E-0016, E-0017)
Map9BScreens4_Y0X0::
    INCBIN "maps/map9_b/screens4_y0_x0.lz"

; LZSS-compressed: 273 bytes that expand to 360 (E-0016, E-0017)
Map9BScreens0_Y1X0::
    INCBIN "maps/map9_b/screens0_y1_x0.lz"

; LZSS-compressed: 217 bytes that expand to 360 (E-0016, E-0017)
Map9BScreens0_Y2X0::
    INCBIN "maps/map9_b/screens0_y2_x0.lz"

; LZSS-compressed: 131 bytes that expand to 360 (E-0016, E-0017)
Map9BAttrs0_Y0X0::
    INCBIN "maps/map9_b/attrs0_y0_x0.lz"

; LZSS-compressed: 99 bytes that expand to 360 (E-0016, E-0017)
Map9BAttrs4_Y0X0::
    INCBIN "maps/map9_b/attrs4_y0_x0.lz"

; LZSS-compressed: 73 bytes that expand to 360 (E-0016, E-0017)
Map9BAttrs0_Y1X0::
    INCBIN "maps/map9_b/attrs0_y1_x0.lz"

; LZSS-compressed: 63 bytes that expand to 360 (E-0016, E-0017)
Map9BAttrs0_Y2X0::
    db $68, $01, $01, $02, $02, $03, $03, $03, $03, $01, $fa, $f2, $01, $04, $02, $02
    db $02, $01, $00, $0f, $0f, $01, $02, $00, $01, $26, $0f, $07, $01, $f8, $f4, $01
    db $48, $0f, $15, $01, $32, $02, $01, $76, $0f, $2f, $01, $04, $02, $01, $34, $02
    db $01, $c4, $0f, $0b, $01, $f2, $08, $01, $ee, $0f, $2d, $01, $3e, $1f, $13

; Tiles, 2048 bytes decompressed (128 tiles). Tileset of map record MapRecordX62F0 (a map record no
; MapTable entry points to), loaded to vTiles2 by LoadMapHeader. Its screen
; (UnusedStoneHallScreenMap) and palettes (MapX62F0Palettes) sit in bank $68, not beside it.
; Rendered with them: the same room layout and the same attribute bytes as the ice room, in a sand
; version: grey-green stone-block walls, sand floor with sand-pile or pyramid shapes at the sides,
; orange herringbone path to a wooden door at the top. The screen uses only tiles 0-45; the other 82
; tiles are not used by that one screen. (C1, E-0383)
; LZSS-compressed: 639 bytes that expand to 2048 (E-0016, E-0017)
SandDoorRoomTileset::
    INCBIN "gfx/misc/sand_door_room_tileset.lz"

; compressed tileset of map $1D (the first map record using it)
; LZSS-compressed: 875 bytes that expand to 1024 (E-0016, E-0017)
Map1DTileset::
    INCBIN "maps/map1_d/tileset.lz"

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
    INCBIN "maps/map1_d/screens0_y0_x0.lz"

; LZSS-compressed: 260 bytes that expand to 360 (E-0016, E-0017)
Map1DScreens0_Y0X1::
    INCBIN "maps/map1_d/screens0_y0_x1.lz"

; LZSS-compressed: 55 bytes that expand to 360 (E-0016, E-0017)
Map1DAttrs0_Y0X0::
    db $68, $01, $02, $00, $00, $00, $03, $01, $02, $04, $04, $10, $03, $03, $02, $fc
    db $fc, $03, $01, $02, $0e, $06, $02, $2b, $08, $02, $04, $00, $02, $28, $0f, $11
    db $02, $2b, $00, $02, $50, $0f, $4d, $02, $88, $0f, $1c, $01, $02, $e0, $0f, $14
    db $02, $8f, $0f, $29, $02, $25, $0d

; LZSS-compressed: 90 bytes that expand to 360 (E-0016, E-0017)
Map1DAttrs0_Y0X1::
    INCBIN "maps/map1_d/attrs0_y0_x1.lz"

; compressed tileset of map $1C (the first map record using it)
; LZSS-compressed: 1129 bytes that expand to 2304 (E-0016, E-0017)
Map1CTileset::
    INCBIN "maps/map1_c/tileset.lz"

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
    INCBIN "maps/map1_c/screens0_y0_x0.lz"

; LZSS-compressed: 28 bytes that expand to 360 (E-0016, E-0017)
Map1CScreens0_Y1X0::
    db $68, $01, $02, $01, $02, $ff, $ff, $00, $02, $ff, $ff, $01, $02, $00, $0f, $4d
    db $02, $60, $0f, $4d, $02, $c0, $0f, $4d, $02, $f8, $0f, $0d

; LZSS-compressed: 99 bytes that expand to 360 (E-0016, E-0017)
Map1CAttrs0_Y0X0::
    INCBIN "maps/map1_c/attrs0_y0_x0.lz"

; LZSS-compressed: 19 bytes that expand to 360 (E-0016, E-0017)
Map1CAttrs0_Y1X0::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $5f, $0f, $4d, $01, $bf, $0f, $4d, $01
    db $1f, $1f, $35
    ds $1ab, $00
