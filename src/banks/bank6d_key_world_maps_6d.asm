; ROM bank $6D: key-world map screens
; The annotated listing of this bank is build/listing/bank6d.asm.

SECTION "Bank 6D", ROMX[$4000], BANK[$6D]
    db $6d

; compressed BG tiles (2048 bytes, 128 tiles): entry 0 of MapType5TilesetTable, decompressed to
; vTiles2 by LoadMapType5TilesetAndHeader
; LZSS-compressed: 938 bytes that expand to 2048 (E-0016, E-0017)
MapType5Tiles0::
    INCBIN "gfx/map_types/5_tiles0.lz"

; entry 0 of MapType5TilesetTable; copied to wBGPaletteBuffer (E-0140, C1)
; record: one CGB palette: 4 BGR555 colours
MapType5Palettes0::
    dw $7da0, $7fff, $7fe0, $0063 ; entry 0
    dw $0140, $03e7, $01a0, $00a0 ; entry 1
    dw $012f, $3f7f, $01d5, $0044 ; entry 2
    dw $012f, $029a, $01d5, $0044 ; entry 3
    dw $5d8c, $3f7f, $5ab1, $0000 ; entry 4
    dw $218c, $3f7f, $029a, $0000 ; entry 5
    dw $001b, $2bff, $023f, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; LZSS-compressed: 171 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom08_Y1X1_Tiles::
    INCBIN "maps/key_worlds/room08_y1_x1_tiles.lz"

; LZSS-compressed: 208 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom07_Y1X2_Tiles::
    INCBIN "maps/key_worlds/room07_y1_x2_tiles.lz"

; LZSS-compressed: 238 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom08_Y2X1_Tiles::
    INCBIN "maps/key_worlds/room08_y2_x1_tiles.lz"

; LZSS-compressed: 187 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0B_Y2X1_Tiles::
    INCBIN "maps/key_worlds/room0_b_y2_x1_tiles.lz"

; LZSS-compressed: 221 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom10_Y2X1_Tiles::
    INCBIN "maps/key_worlds/room10_y2_x1_tiles.lz"

; LZSS-compressed: 233 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom10_Y2X2_Tiles::
    INCBIN "maps/key_worlds/room10_y2_x2_tiles.lz"

; LZSS-compressed: 215 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom11_Y1X2_Tiles::
    INCBIN "maps/key_worlds/room11_y1_x2_tiles.lz"

; LZSS-compressed: 227 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom16_Y2X2_Tiles::
    INCBIN "maps/key_worlds/room16_y2_x2_tiles.lz"

; LZSS-compressed: 241 bytes that expand to 360 (E-0016, E-0017)
ScreenMap6D_1::
    INCBIN "gfx/misc/screen_map6_d_1.lz"

; LZSS-compressed: 160 bytes that expand to 360 (E-0016, E-0017)
ScreenMap6D_2::
    INCBIN "gfx/misc/screen_map6_d_2.lz"

; LZSS-compressed: 211 bytes that expand to 360 (E-0016, E-0017)
ScreenMap6D_3::
    INCBIN "gfx/misc/screen_map6_d_3.lz"

; LZSS-compressed: 261 bytes that expand to 360 (E-0016, E-0017)
ScreenMap6D_4::
    INCBIN "gfx/misc/screen_map6_d_4.lz"

; LZSS-compressed: 190 bytes that expand to 360 (E-0016, E-0017)
ScreenMap6D_5::
    INCBIN "gfx/misc/screen_map6_d_5.lz"

; LZSS-compressed: 209 bytes that expand to 360 (E-0016, E-0017)
ScreenMap6D_6::
    INCBIN "gfx/misc/screen_map6_d_6.lz"

; LZSS-compressed: 246 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom29_Y1X2_Tiles::
    INCBIN "maps/key_worlds/room29_y1_x2_tiles.lz"

; LZSS-compressed: 192 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom30_Y1X2_Tiles::
    INCBIN "maps/key_worlds/room30_y1_x2_tiles.lz"

; LZSS-compressed: 59 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom08_Y1X1_Attrs::
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0f, $4d, $00, $18, $04, $00, $78, $04, $00, $72, $0e, $00, $82, $0f, $03, $00
    db $0a, $00, $00, $9e, $0c, $00, $ac, $06, $00, $84, $0f, $13, $00, $14, $0f, $1d
    db $00, $06, $00, $00, $10, $1f, $11, $00, $08, $0f, $0d

; LZSS-compressed: 68 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom07_Y1X2_Attrs::
    INCBIN "maps/key_worlds/room07_y1_x2_attrs.lz"

; LZSS-compressed: 82 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom08_Y2X1_Attrs::
    INCBIN "maps/key_worlds/room08_y2_x1_attrs.lz"

KeyWorldRoom0B_Y2X1_Attrs::
    INCBIN "maps/key_worlds/room0_b_y2_x1_attrs.lz"

; LZSS-compressed: 76 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom10_Y2X1_Attrs::
    INCBIN "maps/key_worlds/room10_y2_x1_attrs.lz"

; LZSS-compressed: 98 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom10_Y2X2_Attrs::
    INCBIN "maps/key_worlds/room10_y2_x2_attrs.lz"

; LZSS-compressed: 94 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom11_Y1X2_Attrs::
    INCBIN "maps/key_worlds/room11_y1_x2_attrs.lz"

; LZSS-compressed: 88 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom16_Y2X2_Attrs::
    INCBIN "maps/key_worlds/room16_y2_x2_attrs.lz"

; LZSS-compressed: 103 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen6D_1::
    INCBIN "maps/key_worlds/screen6_d_1.lz"

; LZSS-compressed: 70 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen6D_2::
    INCBIN "maps/key_worlds/screen6_d_2.lz"

; LZSS-compressed: 87 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen6D_3::
    INCBIN "maps/key_worlds/screen6_d_3.lz"

; LZSS-compressed: 102 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen6D_4::
    INCBIN "maps/key_worlds/screen6_d_4.lz"

; LZSS-compressed: 81 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen6D_5::
    INCBIN "maps/key_worlds/screen6_d_5.lz"

; LZSS-compressed: 78 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen6D_6::
    INCBIN "maps/key_worlds/screen6_d_6.lz"

; LZSS-compressed: 96 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom29_Y1X2_Attrs::
    INCBIN "maps/key_worlds/room29_y1_x2_attrs.lz"

; LZSS-compressed: 74 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom30_Y1X2_Attrs::
    INCBIN "maps/key_worlds/room30_y1_x2_attrs.lz"

; compressed BG tiles (2048 bytes, 128 tiles): entry 1 of MapType5TilesetTable, decompressed to
; vTiles2 by LoadMapType5TilesetAndHeader
; LZSS-compressed: 909 bytes that expand to 2048 (E-0016, E-0017)
MapType5Tiles1::
    INCBIN "gfx/map_types/5_tiles1.lz"

; entry 1 of MapType5TilesetTable; copied to wBGPaletteBuffer (E-0140, C1)
; record: one CGB palette: 4 BGR555 colours
MapType5Palettes1::
    dw $7da0, $7fff, $7fe0, $0063 ; entry 0
    dw $012f, $3f7f, $01d5, $0044 ; entry 1
    dw $012f, $3f7f, $01d5, $0044 ; entry 2
    dw $012f, $029a, $01d5, $0044 ; entry 3
    dw $5d8c, $3f7f, $5ab1, $0000 ; entry 4
    dw $218c, $3f7f, $029a, $0000 ; entry 5
    dw $001b, $2bff, $023f, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; LZSS-compressed: 162 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom01_Y0X1_Tiles::
    INCBIN "maps/key_worlds/room01_y0_x1_tiles.lz"

; LZSS-compressed: 193 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom06_Y1X1_Tiles::
    INCBIN "maps/key_worlds/room06_y1_x1_tiles.lz"

; LZSS-compressed: 235 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom08_Y0X1_Tiles::
    INCBIN "maps/key_worlds/room08_y0_x1_tiles.lz"

; LZSS-compressed: 236 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom08_Y0X2_Tiles::
    INCBIN "maps/key_worlds/room08_y0_x2_tiles.lz"

; LZSS-compressed: 242 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom1D_Y0X1_Tiles::
    INCBIN "maps/key_worlds/room1_d_y0_x1_tiles.lz"

; LZSS-compressed: 237 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom09_Y0X1_Tiles::
    INCBIN "maps/key_worlds/room09_y0_x1_tiles.lz"

KeyWorldRoom0A_Y0X1_Tiles::
    INCBIN "maps/key_worlds/room0_a_y0_x1_tiles.lz"

KeyWorldRoom0A_Y0X2_Tiles::
    INCBIN "maps/key_worlds/room0_a_y0_x2_tiles.lz"

; LZSS-compressed: 152 bytes that expand to 360 (E-0016, E-0017)
ScreenMap6D_7::
    INCBIN "gfx/misc/screen_map6_d_7.lz"

; LZSS-compressed: 222 bytes that expand to 360 (E-0016, E-0017)
ScreenMap6D_8::
    INCBIN "gfx/misc/screen_map6_d_8.lz"

; LZSS-compressed: 257 bytes that expand to 360 (E-0016, E-0017)
ScreenMap6D_9::
    INCBIN "gfx/misc/screen_map6_d_9.lz"

; LZSS-compressed: 226 bytes that expand to 360 (E-0016, E-0017)
ScreenMap6D_10::
    INCBIN "gfx/misc/screen_map6_d_10.lz"

; LZSS-compressed: 215 bytes that expand to 360 (E-0016, E-0017)
ScreenMap6D_11::
    INCBIN "gfx/misc/screen_map6_d_11.lz"

; LZSS-compressed: 187 bytes that expand to 360 (E-0016, E-0017)
ScreenMap6D_12::
    INCBIN "gfx/misc/screen_map6_d_12.lz"

; LZSS-compressed: 244 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom06_Y1X2_Tiles::
    INCBIN "maps/key_worlds/room06_y1_x2_tiles.lz"

; LZSS-compressed: 192 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom05_Y0X1_Tiles::
    INCBIN "maps/key_worlds/room05_y0_x1_tiles.lz"

; LZSS-compressed: 68 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom01_Y0X1_Attrs::
    INCBIN "maps/key_worlds/room01_y0_x1_attrs.lz"

; LZSS-compressed: 53 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom06_Y1X1_Attrs::
    db $68, $01, $00, $02, $00, $00, $0f, $42, $03, $03, $01, $01, $01, $01, $03, $03
    db $00, $4a, $0f, $07, $00, $58, $00, $00, $5a, $00, $00, $7e, $02, $00, $78, $02
    db $00, $78, $0f, $07, $00, $9a, $0f, $37, $00, $00, $04, $00, $ec, $08, $00, $f0
    db $0f, $4d, $00, $00, $00

; LZSS-compressed: 76 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom08_Y0X1_Attrs::
    INCBIN "maps/key_worlds/room08_y0_x1_attrs.lz"

; LZSS-compressed: 91 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom08_Y0X2_Attrs::
    INCBIN "maps/key_worlds/room08_y0_x2_attrs.lz"

; LZSS-compressed: 81 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom1D_Y0X1_Attrs::
    INCBIN "maps/key_worlds/room1_d_y0_x1_attrs.lz"

; LZSS-compressed: 82 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom09_Y0X1_Attrs::
    INCBIN "maps/key_worlds/room09_y0_x1_attrs.lz"

; LZSS-compressed: 70 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0A_Y0X1_Attrs::
    INCBIN "maps/key_worlds/room0_a_y0_x1_attrs.lz"

; LZSS-compressed: 74 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0A_Y0X2_Attrs::
    INCBIN "maps/key_worlds/room0_a_y0_x2_attrs.lz"

; LZSS-compressed: 69 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen6D_7::
    INCBIN "maps/key_worlds/screen6_d_7.lz"

; LZSS-compressed: 101 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen6D_8::
    INCBIN "maps/key_worlds/screen6_d_8.lz"

; LZSS-compressed: 90 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen6D_9::
    INCBIN "maps/key_worlds/screen6_d_9.lz"

; LZSS-compressed: 88 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen6D_10::
    INCBIN "maps/key_worlds/screen6_d_10.lz"

; LZSS-compressed: 86 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen6D_11::
    INCBIN "maps/key_worlds/screen6_d_11.lz"

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen6D_12::
    INCBIN "maps/key_worlds/screen6_d_12.lz"

; LZSS-compressed: 82 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom06_Y1X2_Attrs::
    INCBIN "maps/key_worlds/room06_y1_x2_attrs.lz"

; LZSS-compressed: 67 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom05_Y0X1_Attrs::
    INCBIN "maps/key_worlds/room05_y0_x1_attrs.lz"

; compressed BG tiles (2048 bytes, 128 tiles): entry 2 of MapType5TilesetTable, decompressed to
; vTiles2 by LoadMapType5TilesetAndHeader
; LZSS-compressed: 913 bytes that expand to 2048 (E-0016, E-0017)
MapType5Tiles2::
    INCBIN "gfx/map_types/5_tiles2.lz"

; LZSS-compressed: 992 bytes that expand to 989 (E-0016, E-0017)
Gfx6D_1::
    INCBIN "gfx/misc/gfx6_d_1.lz"

; entry 2 of MapType5TilesetTable; copied to wBGPaletteBuffer (E-0140, C1)
; record: one CGB palette: 4 BGR555 colours
MapType5Palettes2::
    dw $7da0, $7fff, $7fe0, $0063 ; entry 0
    dw $012f, $3f7f, $01d5, $0044 ; entry 1
    dw $012f, $3f7f, $01d5, $0044 ; entry 2
    dw $012f, $029a, $01d5, $0044 ; entry 3
    dw $5d8c, $3f7f, $5ab1, $0000 ; entry 4
    dw $7da0, $3f7f, $7fe0, $0000 ; entry 5
    dw $001b, $2bff, $023f, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; LZSS-compressed: 179 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom01_Y3X1_Tiles::
    INCBIN "maps/key_worlds/room01_y3_x1_tiles.lz"

; LZSS-compressed: 204 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom00_Y3X1_Tiles::
    INCBIN "maps/key_worlds/room00_y3_x1_tiles.lz"

; LZSS-compressed: 213 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom02_Y2X2_Tiles::
    INCBIN "maps/key_worlds/room02_y2_x2_tiles.lz"

; LZSS-compressed: 273 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom03_Y2X2_Tiles::
    INCBIN "maps/key_worlds/room03_y2_x2_tiles.lz"

; LZSS-compressed: 238 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom08_Y1X2_Tiles::
    INCBIN "maps/key_worlds/room08_y1_x2_tiles.lz"

KeyWorldRoom09_Y3X1_Tiles::
    INCBIN "maps/key_worlds/room09_y3_x1_tiles.lz"

; LZSS-compressed: 265 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0A_Y3X1_Tiles::
    INCBIN "maps/key_worlds/room0_a_y3_x1_tiles.lz"

; LZSS-compressed: 233 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0A_Y3X2_Tiles::
    INCBIN "maps/key_worlds/room0_a_y3_x2_tiles.lz"

; LZSS-compressed: 178 bytes that expand to 360 (E-0016, E-0017)
ScreenMap6D_13::
    INCBIN "gfx/misc/screen_map6_d_13.lz"

; LZSS-compressed: 236 bytes that expand to 360 (E-0016, E-0017)
ScreenMap6D_14::
    INCBIN "gfx/misc/screen_map6_d_14.lz"

; LZSS-compressed: 243 bytes that expand to 360 (E-0016, E-0017)
ScreenMap6D_15::
    INCBIN "gfx/misc/screen_map6_d_15.lz"

; LZSS-compressed: 217 bytes that expand to 360 (E-0016, E-0017)
ScreenMap6D_16::
    INCBIN "gfx/misc/screen_map6_d_16.lz"

; LZSS-compressed: 218 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom8B_Y3X1_Tiles::
    INCBIN "maps/key_worlds/room8_b_y3_x1_tiles.lz"

; LZSS-compressed: 213 bytes that expand to 360 (E-0016, E-0017)
ScreenMap6D_17::
    INCBIN "gfx/misc/screen_map6_d_17.lz"

; LZSS-compressed: 222 bytes that expand to 360 (E-0016, E-0017)
ScreenMap6D_18::
    INCBIN "gfx/misc/screen_map6_d_18.lz"

; LZSS-compressed: 206 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom22_Y1X2_Tiles::
    INCBIN "maps/key_worlds/room22_y1_x2_tiles.lz"
    ds $16c, $00
