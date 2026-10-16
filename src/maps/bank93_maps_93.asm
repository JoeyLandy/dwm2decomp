; ROM bank $93: map screens, attributes and tilesets
; The annotated listing of this bank is build/listing/bank93.asm.

SECTION "Bank 93", ROMX
    db $93

; compressed BG tiles, entry 0 of AreaTilesetTable
; LZSS-compressed: 1313 bytes that expand to 1536 (E-0016, E-0017)
AreaTileset0::
    INCBIN "gfx/area_tilesets/0.lz"

; compressed tileset of map $03 (the first map record using it)
; LZSS-compressed: 977 bytes that expand to 1232 (E-0016, E-0017)
Map03Tileset::
    INCBIN "maps/map03/tileset.lz"

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
    INCBIN "maps/map03/screens0_y0_x0.lz"

; LZSS-compressed: 89 bytes that expand to 360 (E-0016, E-0017)
Map03Attrs0_Y0X0::
    INCBIN "maps/map03/attrs0_y0_x0.lz"

; compressed tileset of map $11 (the first map record using it)
; LZSS-compressed: 693 bytes that expand to 1120 (E-0016, E-0017)
Map11Tileset::
    INCBIN "maps/map11/tileset.lz"

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
    INCBIN "maps/map11/screens0_y0_x0.lz"

; LZSS-compressed: 134 bytes that expand to 360 (E-0016, E-0017)
Map11Screens0_Y1X0::
    INCBIN "maps/map11/screens0_y1_x0.lz"

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
    INCBIN "maps/map12/tileset.lz"

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
    INCBIN "maps/map12/screens0_y0_x0.lz"

; LZSS-compressed: 68 bytes that expand to 360 (E-0016, E-0017)
Map12Attrs0_Y0X0::
    INCBIN "maps/map12/attrs0_y0_x0.lz"

; compressed tileset of map $2F (the first map record using it)
; LZSS-compressed: 1059 bytes that expand to 1280 (E-0016, E-0017)
Map2FTileset::
    INCBIN "maps/map2_f/tileset.lz"

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
    INCBIN "maps/map2_f/screens0_y0_x0.lz"

; LZSS-compressed: 205 bytes that expand to 360 (E-0016, E-0017)
Map2FScreens5_Y0X0::
    INCBIN "maps/map2_f/screens5_y0_x0.lz"

; LZSS-compressed: 77 bytes that expand to 360 (E-0016, E-0017)
Map2FScreens0_Y0X1::
    INCBIN "maps/map2_f/screens0_y0_x1.lz"

; LZSS-compressed: 285 bytes that expand to 360 (E-0016, E-0017)
Map2FScreens5_Y0X1::
    INCBIN "maps/map2_f/screens5_y0_x1.lz"

; LZSS-compressed: 165 bytes that expand to 360 (E-0016, E-0017)
Map2FScreens0_Y1X0::
    INCBIN "maps/map2_f/screens0_y1_x0.lz"

; LZSS-compressed: 179 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_ScreenAnimationTable_2::
    INCBIN "maps/screen_maps/screen_animation_table_2.lz"

; LZSS-compressed: 176 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_ScreenAnimationTable_6::
    INCBIN "maps/screen_maps/screen_animation_table_6.lz"

; LZSS-compressed: 178 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_ScreenAnimationTable_10::
    INCBIN "maps/screen_maps/screen_animation_table_10.lz"

; LZSS-compressed: 170 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_ScreenAnimationTable_14::
    INCBIN "maps/screen_maps/screen_animation_table_14.lz"

; LZSS-compressed: 161 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_ScreenAnimationTable_18::
    INCBIN "maps/screen_maps/screen_animation_table_18.lz"

; LZSS-compressed: 159 bytes that expand to 360 (E-0016, E-0017)
Map2FScreens4_Y1X0::
    INCBIN "maps/map2_f/screens4_y1_x0.lz"

; LZSS-compressed: 115 bytes that expand to 360 (E-0016, E-0017)
Map2FScreens0_Y1X1::
    INCBIN "maps/map2_f/screens0_y1_x1.lz"

; LZSS-compressed: 162 bytes that expand to 360 (E-0016, E-0017)
Map2FScreens5_Y1X1::
    INCBIN "maps/map2_f/screens5_y1_x1.lz"

; LZSS-compressed: 20 bytes that expand to 360 (E-0016, E-0017)
Map2FAttrs0_Y0X0::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

; LZSS-compressed: 67 bytes that expand to 360 (E-0016, E-0017)
Map2FAttrs5_Y0X0::
    INCBIN "maps/map2_f/attrs5_y0_x0.lz"

Map2FAttrs0_Y0X1::
    db $68, $01, $00, $01, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

; LZSS-compressed: 111 bytes that expand to 360 (E-0016, E-0017)
Map2FAttrs5_Y0X1::
    INCBIN "maps/map2_f/attrs5_y0_x1.lz"

; LZSS-compressed: 47 bytes that expand to 360 (E-0016, E-0017)
Map2FAttrs0_Y1X0::
    db $68, $01, $03, $01, $01, $01, $01, $03, $f0, $ff, $3d, $03, $02, $00, $02, $02
    db $02, $02, $03, $4c, $06, $03, $52, $0f, $05, $02, $02, $03, $02, $00, $03, $60
    db $06, $03, $7a, $0f, $05, $03, $a5, $0f, $4d, $03, $05, $1f, $4d, $01, $01

; Attribute map, 360 bytes decompressed (20 x 18, palette numbers 0-3 plus a few cells with value
; $10). It is the attribute half of an entry pair in ScreenAnimationTable: ScenePoorChurch_LoadFrame
; decompresses it into wScreenAttrBuffer (WRAM bank 2, CGB only) as the frame 1 attributes of
; animation id 0 and the frame 0 attributes of id 1, always paired with the tile map
; ScreenMap_ScreenAnimationTable_2. Rendered with that tile map, the Map2F tileset and
; Map2FPalettes: a sand screen with bones and a skull, three palm trees and a small pool, and a bay
; of water at the top whose shore is stepped differently from the previous frame. (C1, E-0383)
; LZSS-compressed: 65 bytes that expand to 360 (E-0016, E-0017)
SandShoreWaterAttrMap::
    INCBIN "gfx/misc/sand_shore_water_attr_map.lz"

; LZSS-compressed: 59 bytes that expand to 360 (E-0016, E-0017)
ScriptScreenAttrMap_ScreenAnimationTable_7::
    db $68, $01, $03, $01, $03, $00, $01, $03, $f2, $ff, $0e, $03, $00, $02, $03, $04
    db $02, $03, $05, $02, $03, $27, $04, $03, $27, $06, $03, $39, $09, $02, $02, $02
    db $02, $03, $39, $0c, $03, $58, $0e, $03, $5a, $00, $03, $37, $0c, $03, $7e, $0f
    db $01, $03, $a5, $0f, $4d, $03, $05, $1f, $4d, $01, $01

; LZSS-compressed: 57 bytes that expand to 360 (E-0016, E-0017)
ScriptScreenAttrMap_ScreenAnimationTable_11::
    db $68, $01, $03, $01, $03, $00, $01, $03, $f3, $ff, $00, $03, $04, $01, $03, $04
    db $03, $03, $13, $04, $03, $13, $06, $03, $25, $0c, $03, $37, $0d, $02, $02, $02
    db $02, $03, $48, $0f, $0f, $03, $5a, $00, $03, $23, $0c, $03, $7e, $0f, $01, $03
    db $a5, $0f, $4d, $03, $05, $1f, $4d, $01, $01

; LZSS-compressed: 52 bytes that expand to 360 (E-0016, E-0017)
ScriptScreenAttrMap_ScreenAnimationTable_15::
    db $68, $01, $03, $01, $03, $00, $02, $03, $fc, $f2, $03, $fb, $f8, $03, $12, $05
    db $03, $0f, $0f, $00, $03, $25, $0f, $10, $02, $02, $02, $02, $03, $48, $0f, $0f
    db $03, $5a, $00, $03, $10, $0c, $03, $7e, $0f, $01, $03, $a5, $0f, $4d, $03, $05
    db $1f, $4d, $01, $01

; LZSS-compressed: 42 bytes that expand to 360 (E-0016, E-0017)
ScriptScreenAttrMap_ScreenAnimationTable_19::
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
    INCBIN "maps/map32/tileset.lz"

; compressed tileset of map $3E (the first map record using it)
; LZSS-compressed: 762 bytes that expand to 1536 (E-0016, E-0017)
Map3ETileset::
    INCBIN "maps/map3_e/tileset.lz"

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
    INCBIN "maps/map3_e/screens0_y0_x0.lz"

; LZSS-compressed: 272 bytes that expand to 360 (E-0016, E-0017)
Map3EScreens0_Y0X1::
    INCBIN "maps/map3_e/screens0_y0_x1.lz"

Map3EScreens0_Y1X0::
    INCBIN "maps/map3_e/screens0_y1_x0.lz"

; LZSS-compressed: 220 bytes that expand to 360 (E-0016, E-0017)
Map3EScreens0_Y1X1::
    INCBIN "maps/map3_e/screens0_y1_x1.lz"

; LZSS-compressed: 84 bytes that expand to 360 (E-0016, E-0017)
Map3EAttrs0_Y0X0::
    INCBIN "maps/map3_e/attrs0_y0_x0.lz"

; LZSS-compressed: 77 bytes that expand to 360 (E-0016, E-0017)
Map3EAttrs0_Y0X1::
    INCBIN "maps/map3_e/attrs0_y0_x1.lz"

; LZSS-compressed: 82 bytes that expand to 360 (E-0016, E-0017)
Map3EAttrs0_Y1X0::
    INCBIN "maps/map3_e/attrs0_y1_x0.lz"

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
    INCBIN "maps/map3_f/screens0_y0_x0.lz"

; LZSS-compressed: 217 bytes that expand to 360 (E-0016, E-0017)
Map3FScreens0_Y0X1::
    INCBIN "maps/map3_f/screens0_y0_x1.lz"

; LZSS-compressed: 267 bytes that expand to 360 (E-0016, E-0017)
Map3FScreens0_Y1X0::
    INCBIN "maps/map3_f/screens0_y1_x0.lz"

; LZSS-compressed: 244 bytes that expand to 360 (E-0016, E-0017)
Map3FScreens0_Y1X1::
    INCBIN "maps/map3_f/screens0_y1_x1.lz"

; LZSS-compressed: 70 bytes that expand to 360 (E-0016, E-0017)
Map3FAttrs0_Y0X0::
    INCBIN "maps/map3_f/attrs0_y0_x0.lz"

; LZSS-compressed: 65 bytes that expand to 360 (E-0016, E-0017)
Map3FAttrs0_Y0X1::
    INCBIN "maps/map3_f/attrs0_y0_x1.lz"

; LZSS-compressed: 78 bytes that expand to 360 (E-0016, E-0017)
Map3FAttrs0_Y1X0::
    INCBIN "maps/map3_f/attrs0_y1_x0.lz"

; LZSS-compressed: 80 bytes that expand to 360 (E-0016, E-0017)
Map3FAttrs0_Y1X1::
    INCBIN "maps/map3_f/attrs0_y1_x1.lz"

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

; Tiles, 608 bytes decompressed (38 tiles). Tileset of map record MapRecordX6248 (pointed at by no
; MapTable entry), loaded to vTiles2 by LoadMapHeader. Rendered with StoneDoorRoomTilemap,
; StoneDoorRoomAttrMap and MapX6248Palettes: a dark stone-brick room, grey-green and purple brick
; walls, black floor to either side of a grey herringbone path that runs up to a wooden door with
; gold hinges and a lock at the top. Same layout as the ice and sand door rooms. (C1, E-0383)
; LZSS-compressed: 399 bytes that expand to 608 (E-0016, E-0017)
StoneDoorRoomTileset::
    INCBIN "gfx/misc/stone_door_room_tileset.lz"

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
    dfar StoneDoorRoomTilemap ; entry 0

MapX6248Attrs0::
    dfar StoneDoorRoomAttrMap ; entry 0

; Tile map, 360 bytes decompressed (20 x 18, tile numbers 0 to 37). Screen (0,0) of the 1 x 1 screen
; map record MapRecordX6248, decompressed into wScreenTileBuffer by LoadMapScreen, indexing
; StoneDoorRoomTileset. Rendered: the dark stone-brick room with the herringbone path and the door
; at the top. (C1, E-0383)
; LZSS-compressed: 156 bytes that expand to 360 (E-0016, E-0017)
StoneDoorRoomTilemap::
    INCBIN "gfx/misc/stone_door_room_tilemap.lz"

; Attribute map, 360 bytes decompressed (20 x 18, palette numbers 0-3, no flips seen). Attribute
; half of screen (0,0) of MapRecordX6248, decompressed into wScreenAttrBuffer by LoadMapScreen on
; CGB, one byte per cell of StoneDoorRoomTilemap; the palettes come from MapX6248Palettes (four
; used, entries 4-7 are all zero). (C1, E-0383)
; LZSS-compressed: 76 bytes that expand to 360 (E-0016, E-0017)
StoneDoorRoomAttrMap::
    INCBIN "gfx/misc/stone_door_room_attr_map.lz"

; compressed tileset of map $8F (the first map record using it)
; LZSS-compressed: 1318 bytes that expand to 1536 (E-0016, E-0017)
Map8FTileset::
    INCBIN "maps/map8_f/tileset.lz"

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
