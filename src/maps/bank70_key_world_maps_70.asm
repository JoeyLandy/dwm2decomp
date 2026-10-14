; ROM bank $70: key-world map screens
; The annotated listing of this bank is build/listing/bank70.asm.

SECTION "Bank 70", ROMX[$4000], BANK[$70]
    db $70

; compressed BG tiles (2048 bytes, 128 tiles): entry 8 of MapType5TilesetTable, decompressed to
; vTiles2 by LoadMapType5TilesetAndHeader
; LZSS-compressed: 716 bytes that expand to 2048 (E-0016, E-0017)
MapType5Tiles8::
    INCBIN "gfx/map_types/5_tiles8.lz"

; LZSS-compressed: 1418 bytes that expand to 1478 (E-0016, E-0017)
Gfx70_1::
    INCBIN "gfx/misc/gfx70_1.lz"

; entry 8 of MapType5TilesetTable; copied to wBGPaletteBuffer (E-0140, C1)
; record: one CGB palette: 4 BGR555 colours
MapType5Palettes8::
    dw $7da0, $7fff, $7fe0, $0063 ; entry 0
    dw $150b, $5f17, $15ae, $0044 ; entry 1
    dw $3dea, $5f17, $4eae, $0000 ; entry 2
    dw $150b, $5f17, $15ae, $0000 ; entry 3
    dw $5d8c, $5f17, $5ab1, $0000 ; entry 4
    dw $218c, $5f17, $029a, $0000 ; entry 5
    dw $001b, $2bff, $023f, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; LZSS-compressed: 119 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom00_Y3X0_Tiles::
    INCBIN "maps/key_worlds/room00_y3_x0_tiles.lz"

; LZSS-compressed: 166 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom04_Y3X0_Tiles::
    INCBIN "maps/key_worlds/room04_y3_x0_tiles.lz"

; LZSS-compressed: 214 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom01_Y2X2_Tiles::
    INCBIN "maps/key_worlds/room01_y2_x2_tiles.lz"

; LZSS-compressed: 213 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom01_Y3X0_Tiles::
    INCBIN "maps/key_worlds/room01_y3_x0_tiles.lz"

; LZSS-compressed: 160 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom02_Y2X1_Tiles::
    INCBIN "maps/key_worlds/room02_y2_x1_tiles.lz"

; LZSS-compressed: 167 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom02_Y3X0_Tiles::
    INCBIN "maps/key_worlds/room02_y3_x0_tiles.lz"

; LZSS-compressed: 218 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom03_Y2X1_Tiles::
    INCBIN "maps/key_worlds/room03_y2_x1_tiles.lz"

; LZSS-compressed: 235 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom03_Y3X0_Tiles::
    INCBIN "maps/key_worlds/room03_y3_x0_tiles.lz"

; LZSS-compressed: 138 bytes that expand to 360 (E-0016, E-0017)
ScreenMap70_1::
    INCBIN "gfx/misc/screen_map70_1.lz"

; LZSS-compressed: 204 bytes that expand to 360 (E-0016, E-0017)
ScreenMap70_2::
    INCBIN "gfx/misc/screen_map70_2.lz"

; LZSS-compressed: 224 bytes that expand to 360 (E-0016, E-0017)
ScreenMap70_3::
    INCBIN "gfx/misc/screen_map70_3.lz"

; LZSS-compressed: 245 bytes that expand to 360 (E-0016, E-0017)
ScreenMap70_4::
    INCBIN "gfx/misc/screen_map70_4.lz"

; LZSS-compressed: 146 bytes that expand to 360 (E-0016, E-0017)
ScreenMap70_5::
    INCBIN "gfx/misc/screen_map70_5.lz"

; LZSS-compressed: 200 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom1B_Y2X1_Tiles::
    INCBIN "maps/key_worlds/room1_b_y2_x1_tiles.lz"

; LZSS-compressed: 246 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom14_Y1X1_Tiles::
    INCBIN "maps/key_worlds/room14_y1_x1_tiles.lz"

; LZSS-compressed: 208 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom68_Y3X2_Tiles::
    INCBIN "maps/key_worlds/room68_y3_x2_tiles.lz"

; LZSS-compressed: 42 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom00_Y3X0_Attrs::
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0f, $4d, $00, $24, $0c, $00, $80, $04, $00, $78, $0f, $0d, $00, $18, $0c, $00
    db $a8, $0f, $29, $00, $f7, $0f, $4d, $00, $20, $0c

; LZSS-compressed: 62 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom04_Y3X0_Attrs::
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0f, $2b, $00, $08, $00, $00, $52, $08, $00, $4e, $0f, $09, $03, $00, $7e, $03
    db $00, $5c, $04, $00, $7a, $0f, $07, $00, $a2, $06, $00, $9e, $0f, $0b, $00, $80
    db $0f, $13, $00, $56, $0f, $15, $00, $56, $0f, $11, $00, $3e, $1f, $13

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom01_Y2X2_Attrs::
    INCBIN "maps/key_worlds/room01_y2_x2_attrs.lz"

; LZSS-compressed: 74 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom01_Y3X0_Attrs::
    INCBIN "maps/key_worlds/room01_y3_x0_attrs.lz"

; LZSS-compressed: 64 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom02_Y2X1_Attrs::
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0f, $03, $00, $08, $00, $00, $2a, $08, $00, $26, $0f, $05, $03, $03, $01, $01
    db $00, $52, $08, $00, $4e, $0f, $05, $00, $28, $0f, $17, $00, $50, $0a, $00, $9e
    db $0f, $09, $00, $28, $0a, $00, $c8, $0f, $09, $00, $f7, $0f, $4d, $00, $0c, $0c

KeyWorldRoom02_Y3X0_Attrs::
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0f, $4d, $00, $10, $0a, $03, $00, $82, $03, $00, $1e, $06, $00, $80, $0f, $01
    db $00, $1a, $02, $00, $88, $00, $00, $9e, $0f, $3b, $00, $22, $0e, $00, $fe, $0a
    db $00, $1c, $00, $00, $1e, $0c, $00, $20, $1f, $01, $00, $3a, $1f, $0d

KeyWorldRoom03_Y2X1_Attrs::
    INCBIN "maps/key_worlds/room03_y2_x1_attrs.lz"

; LZSS-compressed: 85 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom03_Y3X0_Attrs::
    INCBIN "maps/key_worlds/room03_y3_x0_attrs.lz"

; LZSS-compressed: 68 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen70_1::
    INCBIN "maps/key_worlds/screen70_1.lz"

; LZSS-compressed: 107 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen70_2::
    INCBIN "maps/key_worlds/screen70_2.lz"

; LZSS-compressed: 98 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen70_3::
    INCBIN "maps/key_worlds/screen70_3.lz"

; LZSS-compressed: 105 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen70_4::
    INCBIN "maps/key_worlds/screen70_4.lz"

; LZSS-compressed: 58 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen70_5::
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0f, $31, $00, $06, $00, $00, $48, $0f, $15, $05, $05, $05, $05, $00, $08, $0a
    db $00, $82, $0f, $05, $00, $08, $00, $00, $9e, $0f, $0d, $05, $05, $03, $03, $00
    db $c2, $0f, $11, $00, $f9, $0f, $4d, $00, $0c, $0a

; LZSS-compressed: 78 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom1B_Y2X1_Attrs::
    INCBIN "maps/key_worlds/room1_b_y2_x1_attrs.lz"

KeyWorldRoom14_Y1X1_Attrs::
    INCBIN "maps/key_worlds/room14_y1_x1_attrs.lz"

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom68_Y3X2_Attrs::
    INCBIN "maps/key_worlds/room68_y3_x2_attrs.lz"

; compressed BG tiles (2048 bytes, 128 tiles): entry 9 of MapType5TilesetTable, decompressed to
; vTiles2 by LoadMapType5TilesetAndHeader
; LZSS-compressed: 653 bytes that expand to 2048 (E-0016, E-0017)
MapType5Tiles9::
    INCBIN "gfx/map_types/5_tiles9.lz"

; entry 9 of MapType5TilesetTable; copied to wBGPaletteBuffer (E-0140, C1)
; record: one CGB palette: 4 BGR555 colours
MapType5Palettes9::
    dw $7da0, $7fff, $7fe0, $0063 ; entry 0
    dw $150b, $6bff, $4d8c, $0044 ; entry 1
    dw $4d8c, $6bff, $5e73, $0000 ; entry 2
    dw $7da0, $7fff, $7fe0, $0063 ; entry 3
    dw $5d8c, $6bff, $5ab1, $0000 ; entry 4
    dw $218c, $6bff, $029a, $0000 ; entry 5
    dw $001b, $2bff, $023f, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; LZSS-compressed: 139 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom01_Y3X3_Tiles::
    INCBIN "maps/key_worlds/room01_y3_x3_tiles.lz"

; LZSS-compressed: 183 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom00_Y2X2_Tiles::
    INCBIN "maps/key_worlds/room00_y2_x2_tiles.lz"

; LZSS-compressed: 217 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom02_Y3X3_Tiles::
    INCBIN "maps/key_worlds/room02_y3_x3_tiles.lz"

; LZSS-compressed: 169 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom03_Y2X3_Tiles::
    INCBIN "maps/key_worlds/room03_y2_x3_tiles.lz"

; LZSS-compressed: 194 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom04_Y2X2_Tiles::
    INCBIN "maps/key_worlds/room04_y2_x2_tiles.lz"

; LZSS-compressed: 236 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom04_Y3X3_Tiles::
    INCBIN "maps/key_worlds/room04_y3_x3_tiles.lz"

; LZSS-compressed: 238 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom08_Y1X3_Tiles::
    INCBIN "maps/key_worlds/room08_y1_x3_tiles.lz"

; LZSS-compressed: 222 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom08_Y3X3_Tiles::
    INCBIN "maps/key_worlds/room08_y3_x3_tiles.lz"

; LZSS-compressed: 162 bytes that expand to 360 (E-0016, E-0017)
ScreenMap70_6::
    INCBIN "gfx/misc/screen_map70_6.lz"

; LZSS-compressed: 199 bytes that expand to 360 (E-0016, E-0017)
ScreenMap70_7::
    INCBIN "gfx/misc/screen_map70_7.lz"

; LZSS-compressed: 224 bytes that expand to 360 (E-0016, E-0017)
ScreenMap70_8::
    INCBIN "gfx/misc/screen_map70_8.lz"

; LZSS-compressed: 216 bytes that expand to 360 (E-0016, E-0017)
ScreenMap70_9::
    INCBIN "gfx/misc/screen_map70_9.lz"

; LZSS-compressed: 149 bytes that expand to 360 (E-0016, E-0017)
ScreenMap70_10::
    INCBIN "gfx/misc/screen_map70_10.lz"

; LZSS-compressed: 214 bytes that expand to 360 (E-0016, E-0017)
ScreenMap70_11::
    INCBIN "gfx/misc/screen_map70_11.lz"

; LZSS-compressed: 218 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom29_Y2X3_Tiles::
    INCBIN "maps/key_worlds/room29_y2_x3_tiles.lz"

; LZSS-compressed: 215 bytes that expand to 360 (E-0016, E-0017)
ScreenMap70_12::
    INCBIN "gfx/misc/screen_map70_12.lz"

; LZSS-compressed: 53 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom01_Y3X3_Attrs::
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0f, $09, $00, $20, $0f, $17, $00, $1e, $0f, $01, $00, $0a, $06, $00, $08, $00
    db $00, $78, $04, $00, $70, $0f, $0b, $03, $03, $00, $90, $0f, $39, $00, $ef, $0f
    db $4d, $00, $20, $0f, $05

; LZSS-compressed: 66 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom00_Y2X2_Attrs::
    INCBIN "maps/key_worlds/room00_y2_x2_attrs.lz"

; LZSS-compressed: 61 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom02_Y3X3_Attrs::
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0f, $31, $00, $06, $02, $00, $0a, $0c, $00, $5a, $06, $00, $5a, $02, $00, $78
    db $06, $00, $74, $0f, $09, $00, $76, $06, $00, $02, $08, $00, $a6, $0c, $00, $00
    db $06, $00, $ca, $0f, $09, $00, $ef, $0f, $4d, $00, $08, $1f, $05

; LZSS-compressed: 76 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom03_Y2X3_Attrs::
    INCBIN "maps/key_worlds/room03_y2_x3_attrs.lz"

; LZSS-compressed: 73 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom04_Y2X2_Attrs::
    INCBIN "maps/key_worlds/room04_y2_x2_attrs.lz"

; LZSS-compressed: 75 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom04_Y3X3_Attrs::
    INCBIN "maps/key_worlds/room04_y3_x3_attrs.lz"

; LZSS-compressed: 89 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom08_Y1X3_Attrs::
    INCBIN "maps/key_worlds/room08_y1_x3_attrs.lz"

; LZSS-compressed: 74 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom08_Y3X3_Attrs::
    INCBIN "maps/key_worlds/room08_y3_x3_attrs.lz"

; LZSS-compressed: 3295 bytes that expand to 3359 (E-0016, E-0017)
Gfx70_2::
    db $1f, $0d

; LZSS-compressed: 81 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen70_6::
    INCBIN "maps/key_worlds/screen70_6.lz"

; LZSS-compressed: 104 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen70_7::
    INCBIN "maps/key_worlds/screen70_7.lz"

; LZSS-compressed: 93 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen70_8::
    INCBIN "maps/key_worlds/screen70_8.lz"

; LZSS-compressed: 102 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen70_9::
    INCBIN "maps/key_worlds/screen70_9.lz"

; LZSS-compressed: 61 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen70_10::
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0f, $31, $05, $05, $00, $46, $0f, $0b, $00, $08, $00, $03, $03, $05, $05, $05
    db $05, $03, $03, $00, $70, $0f, $0f, $00, $7c, $02, $00, $98, $0f, $0d, $00, $c8
    db $02, $00, $be, $0f, $0b, $00, $ef, $0f, $4d, $00, $08, $1f, $05

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen70_11::
    INCBIN "maps/key_worlds/screen70_11.lz"

; LZSS-compressed: 72 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom29_Y2X3_Attrs::
    INCBIN "maps/key_worlds/room29_y2_x3_attrs.lz"

; LZSS-compressed: 80 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen70_12::
    INCBIN "maps/key_worlds/screen70_12.lz"

; compressed BG tiles (2048 bytes, 128 tiles): entry 10 of MapType5TilesetTable, decompressed to
; vTiles2 by LoadMapType5TilesetAndHeader
; LZSS-compressed: 660 bytes that expand to 2048 (E-0016, E-0017)
MapType5Tiles10::
    INCBIN "gfx/map_types/5_tiles10.lz"

; entry 10 of MapType5TilesetTable; copied to wBGPaletteBuffer (E-0140, C1)
; record: one CGB palette: 4 BGR555 colours
MapType5Palettes10::
    dw $01a2, $7fff, $0348, $0063 ; entry 0
    dw $01a2, $3f7f, $0348, $0084 ; entry 1
    dw $01a2, $3f7f, $0348, $0084 ; entry 2
    dw $01a2, $7fff, $0348, $0084 ; entry 3
    dw $5d8c, $3f7f, $5ab1, $0000 ; entry 4
    dw $218c, $3f7f, $029a, $0000 ; entry 5
    dw $001b, $2bff, $023f, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; LZSS-compressed: 58 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom00_Y1X0_Tiles::
    db $68, $01, $00, $20, $21, $00, $00, $00, $08, $09, $40, $41, $40, $41, $06, $07
    db $00, $00, $02, $30, $31, $00, $14, $00, $18, $19, $50, $51, $50, $51, $16, $17
    db $00, $14, $02, $00, $00, $0f, $4d, $00, $60, $0f, $35, $42, $43, $00, $5a, $0e
    db $52, $53, $00, $be, $0f, $27, $00, $58, $0f, $35

; LZSS-compressed: 186 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom00_Y1X3_Tiles::
    INCBIN "maps/key_worlds/room00_y1_x3_tiles.lz"

; LZSS-compressed: 206 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom01_Y1X3_Tiles::
    INCBIN "maps/key_worlds/room01_y1_x3_tiles.lz"

; LZSS-compressed: 215 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom02_Y1X2_Tiles::
    INCBIN "maps/key_worlds/room02_y1_x2_tiles.lz"

; LZSS-compressed: 161 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom02_Y1X3_Tiles::
    INCBIN "maps/key_worlds/room02_y1_x3_tiles.lz"

; LZSS-compressed: 229 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom02_Y2X0_Tiles::
    INCBIN "maps/key_worlds/room02_y2_x0_tiles.lz"

; LZSS-compressed: 185 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom03_Y1X0_Tiles::
    INCBIN "maps/key_worlds/room03_y1_x0_tiles.lz"

; LZSS-compressed: 218 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom03_Y1X3_Tiles::
    INCBIN "maps/key_worlds/room03_y1_x3_tiles.lz"

; LZSS-compressed: 61 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen70_13::
    db $68, $01, $00, $20, $21, $00, $00, $00, $08, $09, $40, $41, $40, $41, $06, $07
    db $00, $00, $02, $30, $31, $00, $14, $00, $18, $19, $50, $51, $50, $51, $16, $17
    db $00, $14, $02, $00, $00, $0f, $45, $28, $29, $28, $29, $00, $0c, $0c, $38, $39
    db $38, $39, $00, $70, $0f, $4d, $00, $08, $0f, $4d, $00, $08, $1c

; LZSS-compressed: 193 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen70_14::
    INCBIN "maps/key_worlds/screen70_14.lz"

KeyWorldScreen70_15::
    INCBIN "maps/key_worlds/screen70_15.lz"

; LZSS-compressed: 201 bytes that expand to 360 (E-0016, E-0017)
ScreenMap70_13::
    INCBIN "gfx/misc/screen_map70_13.lz"

; LZSS-compressed: 189 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0D_Y1X0_Tiles::
    INCBIN "maps/key_worlds/room0_d_y1_x0_tiles.lz"

; LZSS-compressed: 257 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom3E_Y1X2_Tiles::
    INCBIN "maps/key_worlds/room3_e_y1_x2_tiles.lz"

; LZSS-compressed: 185 bytes that expand to 360 (E-0016, E-0017)
ScreenMap70_14::
    INCBIN "gfx/misc/screen_map70_14.lz"

; LZSS-compressed: 221 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom37_Y2X0_Tiles::
    INCBIN "maps/key_worlds/room37_y2_x0_tiles.lz"

; LZSS-compressed: 33 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom00_Y1X0_Attrs::
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0f, $4d, $00, $60, $0f, $49, $00, $6a, $00, $00, $c0, $0f, $39, $00, $6c, $0f
    db $35

; LZSS-compressed: 58 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom00_Y1X3_Attrs::
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0f, $2d, $00, $08, $00, $00, $54, $06, $00, $4e, $0f, $05, $00, $56, $0e, $00
    db $78, $0f, $0d, $00, $4a, $0f, $01, $00, $ac, $0f, $1f, $00, $52, $06, $00, $e8
    db $0f, $0d, $00, $78, $0f, $17, $00, $06, $0f, $0f

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom01_Y1X3_Attrs::
    INCBIN "maps/key_worlds/room01_y1_x3_attrs.lz"

; LZSS-compressed: 81 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom02_Y1X2_Attrs::
    INCBIN "maps/key_worlds/room02_y1_x2_attrs.lz"

KeyWorldRoom02_Y1X3_Attrs::
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0f, $2f, $00, $08, $00, $00, $08, $0c, $00, $56, $0e, $00, $56, $04, $00, $08
    db $08, $00, $7c, $0e, $00, $7c, $08, $00, $08, $04, $00, $a2, $0f, $29, $00, $7a
    db $0f, $15, $00, $52, $0f, $17, $00, $04, $0f, $11

; LZSS-compressed: 78 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom02_Y2X0_Attrs::
    INCBIN "maps/key_worlds/room02_y2_x0_attrs.lz"

; LZSS-compressed: 63 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom03_Y1X0_Attrs::
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0f, $09, $00, $06, $00, $00, $20, $0f, $39, $00, $08, $00, $03, $00, $84, $01
    db $00, $76, $0f, $0b, $00, $7c, $06, $00, $9e, $0f, $39, $00, $9a, $0f, $01, $00
    db $86, $0a, $03, $03, $00, $fc, $0e, $00, $20, $1f, $01, $00, $08, $0f, $0d

; LZSS-compressed: 67 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom03_Y1X3_Attrs::
    INCBIN "maps/key_worlds/room03_y1_x3_attrs.lz"

; LZSS-compressed: 43 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen70_16::
    db $68, $01, $03, $02, $03, $00, $03, $01, $01, $01, $01, $03, $00, $04, $03, $00
    db $0f, $4d, $03, $20, $08, $00, $02, $03, $ff, $f5, $03, $77, $06, $03, $fd, $f7
    db $03, $78, $0f, $45, $03, $1c, $0f, $4d, $03, $08, $1c

; LZSS-compressed: 99 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen70_17::
    INCBIN "maps/key_worlds/screen70_17.lz"

; LZSS-compressed: 74 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen70_18::
    INCBIN "maps/key_worlds/screen70_18.lz"

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen70_19::
    INCBIN "maps/key_worlds/screen70_19.lz"

; LZSS-compressed: 76 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0D_Y1X0_Attrs::
    INCBIN "maps/key_worlds/room0_d_y1_x0_attrs.lz"

; LZSS-compressed: 83 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom3E_Y1X2_Attrs::
    INCBIN "maps/key_worlds/room3_e_y1_x2_attrs.lz"

; LZSS-compressed: 69 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen70_20::
    INCBIN "maps/key_worlds/screen70_20.lz"

; LZSS-compressed: 75 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom37_Y2X0_Attrs::
    INCBIN "maps/key_worlds/room37_y2_x0_attrs.lz"

; compressed BG tiles (2048 bytes, 128 tiles): entry 11 of MapType5TilesetTable, decompressed to
; vTiles2 by LoadMapType5TilesetAndHeader
; LZSS-compressed: 1053 bytes that expand to 2048 (E-0016, E-0017)
MapType5Tiles11::
    INCBIN "gfx/map_types/5_tiles11.lz"

; entry 11 of MapType5TilesetTable; copied to wBGPaletteBuffer (E-0140, C1)
; record: one CGB palette: 4 BGR555 colours
MapType5Palettes11::
    dw $7da0, $7fff, $7fe0, $0063 ; entry 0
    dw $218c, $3f7f, $029a, $0000 ; entry 1
    dw $3523, $42d8, $318c, $0044 ; entry 2
    dw $218c, $3f7f, $318c, $0084 ; entry 3
    dw $5d8c, $3f7f, $5ab1, $0000 ; entry 4
    dw $218c, $3f7f, $029a, $0000 ; entry 5
    dw $001b, $2bff, $023f, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7
    ds $106, $00
