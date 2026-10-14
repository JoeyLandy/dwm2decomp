; ROM bank $48: map screens, attributes and tilesets
; The annotated listing of this bank is build/listing/bank48.asm.

SECTION "Bank 48", ROMX[$4000], BANK[$48]
    db $48

; entry 0 of AreaPaletteTable (E-0145, C1)
; record: one CGB palette: 4 BGR555 colours
AreaPalettes0::
; data read by DebugStaffRoll_Scene00_DecompressToVRAM (32 words)
DebugStaffRoll_Scene00_DecompressToVRAM_BGPaletteBufferData::
    dw $7da0, $7fff, $7fe0, $0063 ; entry 0
    dw $7da0, $7fff, $5ad6, $0063 ; entry 1
    dw $02c0, $3f7f, $03e2, $0000 ; entry 2
    dw $012f, $3fbf, $01d5, $0000 ; entry 3
    dw $158f, $4298, $2a13, $0000 ; entry 4
    dw $012f, $3fbf, $03e2, $0000 ; entry 5
    dw $02c0, $3fbf, $7fe0, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
Map01Palettes::
    dw $7da0, $7fff, $7fe0, $0063 ; entry 0
    dw $7da0, $7fff, $5ad6, $0063 ; entry 1
    dw $02c0, $3fbf, $03e2, $0000 ; entry 2
    dw $012f, $3fbf, $01d5, $0000 ; entry 3
    dw $158f, $4298, $2a13, $0000 ; entry 4
    dw $1415, $2bff, $023f, $0000 ; entry 5
    dw $02c0, $3f7f, $7fe0, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

Map02Palettes::
DebugStaffRoll_Scene01_DecompressToVRAM_BGPaletteBufferData::
    dw $7da0, $7fff, $7fe0, $0063 ; entry 0
    dw $7da0, $7fff, $5ad6, $0063 ; entry 1
    dw $02c0, $3f7f, $03e2, $0000 ; entry 2
    dw $012f, $3fbf, $01d5, $0000 ; entry 3
    dw $00cc, $2bff, $0118, $0000 ; entry 4
    dw $001b, $2bff, $023f, $0000 ; entry 5
    dw $02c0, $3f7f, $7fe0, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; compressed tileset of map $06 (the first map record using it)
; LZSS-compressed: 871 bytes that expand to 1600 (E-0016, E-0017)
Map06Tileset::
    INCBIN "maps/map06/tileset.lz"

Map06Palettes::
    dw $1415, $7fff, $3c1f, $0000 ; entry 0
    dw $012f, $035f, $01da, $0000 ; entry 1
    dw $1528, $3695, $15ae, $0000 ; entry 2
    dw $1415, $035f, $01da, $0000 ; entry 3
    dw $1528, $7fff, $6b2b, $0020 ; entry 4
    dw $012f, $4fff, $01da, $0020 ; entry 5
    dw $31cf, $7f04, $5ad6, $0000 ; entry 6
    dw $29ce, $4fff, $3695, $0020 ; entry 7

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map06Screens0::
    dfar Map06Screens0_Y0X0 ; entry 0
    db $80, $44, $48, $80, $44, $48, $80, $44, $48

Map06Attrs0::
    dfar Map06Attrs0_Y0X0 ; entry 0
    db $4e, $45, $48, $4e, $45, $48, $4e, $45, $48

; LZSS-compressed: 206 bytes that expand to 360 (E-0016, E-0017)
Map06Screens0_Y0X0::
    INCBIN "maps/map06/screens0_y0_x0.lz"

; LZSS-compressed: 74 bytes that expand to 360 (E-0016, E-0017)
Map06Attrs0_Y0X0::
    INCBIN "maps/map06/attrs0_y0_x0.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map05Palettes::
    dw $7da0, $7fff, $7fe0, $0000 ; entry 0
    dw $1528, $3695, $01d5, $0000 ; entry 1
    dw $1528, $0301, $15ac, $0000 ; entry 2
    dw $012f, $3fbf, $01d5, $0000 ; entry 3
    dw $1528, $3695, $15ae, $0000 ; entry 4
    dw $1528, $3fbf, $01d5, $0000 ; entry 5
    dw $012f, $5fff, $5294, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; compressed tileset of map $16 (the first map record using it)
; LZSS-compressed: 663 bytes that expand to 896 (E-0016, E-0017)
Map16Tileset::
    INCBIN "maps/map16/tileset.lz"

Map16Palettes::
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
Map16Screens0::
    dfar Map16Screens0_Y0X0 ; entry 0

Map16Attrs0::
    dfar Map16Attrs0_Y0X0 ; entry 0

; LZSS-compressed: 173 bytes that expand to 360 (E-0016, E-0017)
Map16Screens0_Y0X0::
    INCBIN "maps/map16/screens0_y0_x0.lz"

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
Map16Attrs0_Y0X0::
    INCBIN "maps/map16/attrs0_y0_x0.lz"

; compressed tileset of map $17 (the first map record using it)
; LZSS-compressed: 734 bytes that expand to 1120 (E-0016, E-0017)
Map17Tileset::
    INCBIN "maps/map17/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map17Palettes::
    dw $7d86, $7fff, $7fe1, $0000 ; entry 0
    dw $012f, $031d, $01d8, $0000 ; entry 1
    dw $012f, $67ff, $0214, $0000 ; entry 2
    dw $158f, $4298, $2a13, $0020 ; entry 3
    dw $49ae, $6b79, $4acd, $0000 ; entry 4
    dw $29ce, $4fff, $3695, $0020 ; entry 5
    dw $29ce, $4fff, $3695, $0020 ; entry 6
    dw $29ce, $4fff, $3695, $0020 ; entry 7

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map17Screens0::
    dfar Map17Screens0_Y0X0 ; entry 0

Map17Attrs0::
    dfar Map17Attrs0_Y0X0 ; entry 0

; LZSS-compressed: 205 bytes that expand to 360 (E-0016, E-0017)
Map17Screens0_Y0X0::
    INCBIN "maps/map17/screens0_y0_x0.lz"

; LZSS-compressed: 66 bytes that expand to 360 (E-0016, E-0017)
Map17Attrs0_Y0X0::
    INCBIN "maps/map17/attrs0_y0_x0.lz"

; compressed tileset of map $18 (the first map record using it)
; LZSS-compressed: 860 bytes that expand to 1536 (E-0016, E-0017)
Map18Tileset::
    INCBIN "maps/map18/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map18Palettes::
DebugStaffRoll_Scene02_DecompressToVRAM_BGPaletteBufferData::
    dw $7d86, $7fff, $7fe1, $0000 ; entry 0
    dw $012f, $031d, $01d8, $0000 ; entry 1
    dw $012f, $67ff, $0214, $0000 ; entry 2
    dw $158f, $4298, $2a13, $0020 ; entry 3
    dw $306a, $50bf, $3071, $0020 ; entry 4
    dw $29ce, $4fff, $3695, $0020 ; entry 5
    dw $04a9, $50ff, $092e, $0020 ; entry 6
    dw $294a, $7fff, $4a52, $0000 ; entry 7

; 6 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map18Screens0::
    dfar Map18Screens0_Y0X0 ; entry 0
    dfar Map18Screens0_Y0X1 ; entry 1
    dfar Map18Screens0_Y0X2 ; entry 2
    dfar Map18Screens0_Y1X0 ; entry 3
    dfar Map18Screens0_Y1X1 ; entry 4
    dfar Map18Screens0_Y1X2 ; entry 5

Map18Attrs0::
    dfar Map18Attrs0_Y0X0 ; entry 0
    dfar Map18Attrs0_Y0X1 ; entry 1
    dfar Map18Attrs0_Y0X2 ; entry 2
    dfar Map18Attrs0_Y1X0 ; entry 3
    dfar Map18Attrs0_Y1X1 ; entry 4
    dfar Map18Attrs0_Y1X2 ; entry 5

; LZSS-compressed: 160 bytes that expand to 360 (E-0016, E-0017)
Map18Screens0_Y0X0::
    INCBIN "maps/map18/screens0_y0_x0.lz"

; LZSS-compressed: 151 bytes that expand to 360 (E-0016, E-0017)
Map18Screens0_Y0X1::
    INCBIN "maps/map18/screens0_y0_x1.lz"

; LZSS-compressed: 143 bytes that expand to 360 (E-0016, E-0017)
Map18Screens0_Y0X2::
    INCBIN "maps/map18/screens0_y0_x2.lz"

; LZSS-compressed: 113 bytes that expand to 360 (E-0016, E-0017)
Map18Screens0_Y1X0::
    INCBIN "maps/map18/screens0_y1_x0.lz"

; LZSS-compressed: 74 bytes that expand to 360 (E-0016, E-0017)
Map18Screens0_Y1X1::
    INCBIN "maps/map18/screens0_y1_x1.lz"

; LZSS-compressed: 95 bytes that expand to 360 (E-0016, E-0017)
Map18Screens0_Y1X2::
    INCBIN "maps/map18/screens0_y1_x2.lz"

; LZSS-compressed: 67 bytes that expand to 360 (E-0016, E-0017)
Map18Attrs0_Y0X0::
    INCBIN "maps/map18/attrs0_y0_x0.lz"

Map18Attrs0_Y0X1::
    INCBIN "maps/map18/attrs0_y0_x1.lz"

; LZSS-compressed: 59 bytes that expand to 360 (E-0016, E-0017)
Map18Attrs0_Y0X2::
    db $68, $01, $00, $03, $00, $00, $01, $01, $01, $00, $00, $02, $00, $00, $00, $02
    db $02, $00, $00, $0f, $37, $00, $06, $00, $00, $4e, $0f, $03, $04, $00, $78, $01
    db $01, $01, $00, $78, $00, $00, $70, $0f, $0f, $00, $a0, $04, $00, $9a, $0f, $3d
    db $00, $82, $00, $00, $ee, $0f, $39, $00, $9a, $0f, $07

; LZSS-compressed: 56 bytes that expand to 360 (E-0016, E-0017)
Map18Attrs0_Y1X0::
    db $68, $01, $00, $02, $02, $03, $03, $01, $01, $04, $00, $06, $09, $00, $00, $0f
    db $4d, $00, $10, $04, $06, $06, $00, $6a, $0f, $15, $00, $7c, $0a, $00, $a0, $0f
    db $05, $00, $7a, $00, $00, $18, $02, $00, $18, $02, $00, $c8, $0f, $07, $00, $f2
    db $0a, $00, $f0, $0f, $4d, $00, $ca, $00

; LZSS-compressed: 40 bytes that expand to 360 (E-0016, E-0017)
Map18Attrs0_Y1X1::
    db $68, $01, $00, $04, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $90, $0f, $1c
    db $03, $03, $01, $01, $04, $04, $00, $f2, $00, $00, $f4, $02, $01, $01, $03, $03
    db $00, $f0, $0f, $03, $00, $16, $1f, $3b

; LZSS-compressed: 54 bytes that expand to 360 (E-0016, E-0017)
Map18Attrs0_Y1X2::
    db $68, $01, $00, $04, $00, $00, $09, $01, $01, $03, $03, $02, $02, $00, $00, $0f
    db $4d, $00, $24, $0e, $04, $04, $00, $74, $0f, $13, $06, $06, $00, $9c, $0f, $09
    db $01, $01, $00, $a8, $06, $00, $c4, $0f, $05, $00, $d6, $00, $00, $f0, $0a, $00
    db $ee, $0f, $4d, $00, $d6, $02

; compressed tileset of map $19 (the first map record using it)
; LZSS-compressed: 1627 bytes that expand to 1920 (E-0016, E-0017)
Map19Tileset::
    INCBIN "maps/map19/tileset.lz"

; 6 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map19Screens0::
    dfar Map19Screens0_Y0X0 ; entry 0
    dfar Map19Screens0_Y0X0 ; entry 1
    dfar Map19Screens0_Y1X0 ; entry 2
    dfar Map19Screens0_Y1X1 ; entry 3
    dfar Map19Screens0_Y2X0 ; entry 4
    dfar Map19Screens0_Y0X0 ; entry 5

Map19Attrs0::
    dfar Map19Attrs0_Y0X0 ; entry 0
    dfar Map19Attrs0_Y0X0 ; entry 1
    dfar Map19Attrs0_Y1X0 ; entry 2
    dfar Map19Attrs0_Y1X1 ; entry 3
    dfar Map19Attrs0_Y2X0 ; entry 4
    dfar Map19Attrs0_Y0X0 ; entry 5

Map19Screens6::
    dfar Map19Screens6_Y0X0 ; entry 0
    dfar Map19Screens0_Y0X0 ; entry 1
    dfar Map19Screens0_Y1X0 ; entry 2
    dfar Map19Screens0_Y1X1 ; entry 3
    dfar Map19Screens0_Y2X0 ; entry 4
    dfar Map19Screens0_Y0X0 ; entry 5

Map19Attrs6::
    dfar Map19Attrs6_Y0X0 ; entry 0
    dfar Map19Attrs0_Y0X0 ; entry 1
    dfar Map19Attrs0_Y1X0 ; entry 2
    dfar Map19Attrs0_Y1X1 ; entry 3
    dfar Map19Attrs0_Y2X0 ; entry 4
    dfar Map19Attrs0_Y0X0 ; entry 5

; LZSS-compressed: 229 bytes that expand to 360 (E-0016, E-0017)
Map19Screens0_Y0X0::
    INCBIN "maps/map19/screens0_y0_x0.lz"

; LZSS-compressed: 231 bytes that expand to 360 (E-0016, E-0017)
Map19Screens6_Y0X0::
    INCBIN "maps/map19/screens6_y0_x0.lz"

; LZSS-compressed: 235 bytes that expand to 360 (E-0016, E-0017)
Map19Screens0_Y1X0::
    INCBIN "maps/map19/screens0_y1_x0.lz"

; LZSS-compressed: 226 bytes that expand to 360 (E-0016, E-0017)
ScreenMap48_1::
    INCBIN "gfx/misc/screen_map48_1.lz"

; LZSS-compressed: 201 bytes that expand to 360 (E-0016, E-0017)
Map19Screens0_Y1X1::
    INCBIN "maps/map19/screens0_y1_x1.lz"

; LZSS-compressed: 275 bytes that expand to 360 (E-0016, E-0017)
Map19Screens0_Y2X0::
    INCBIN "maps/map19/screens0_y2_x0.lz"

; LZSS-compressed: 130 bytes that expand to 360 (E-0016, E-0017)
Map19Attrs0_Y0X0::
    INCBIN "maps/map19/attrs0_y0_x0.lz"

; LZSS-compressed: 132 bytes that expand to 360 (E-0016, E-0017)
Map19Attrs6_Y0X0::
    INCBIN "maps/map19/attrs6_y0_x0.lz"

; LZSS-compressed: 111 bytes that expand to 360 (E-0016, E-0017)
Map19Attrs0_Y1X0::
    INCBIN "maps/map19/attrs0_y1_x0.lz"

; LZSS-compressed: 110 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen48_1::
    INCBIN "maps/key_worlds/screen48_1.lz"

; LZSS-compressed: 93 bytes that expand to 360 (E-0016, E-0017)
Map19Attrs0_Y1X1::
    INCBIN "maps/map19/attrs0_y1_x1.lz"

; LZSS-compressed: 145 bytes that expand to 360 (E-0016, E-0017)
Map19Attrs0_Y2X0::
    INCBIN "maps/map19/attrs0_y2_x0.lz"

; compressed tileset of map $1B (the first map record using it)
; LZSS-compressed: 571 bytes that expand to 1024 (E-0016, E-0017)
Map1BTileset::
    INCBIN "maps/map1_b/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map1BPalettes::
    dw $7d86, $7fff, $7d86, $0000 ; entry 0
    dw $012f, $031d, $01d8, $0000 ; entry 1
    dw $012f, $67ff, $0214, $0000 ; entry 2
    dw $0020, $0020, $0020, $0020 ; entry 3
    dw $001b, $2bff, $023f, $0000 ; entry 4
    dw $0020, $0020, $0020, $0020 ; entry 5
    dw $0020, $0020, $0020, $0020 ; entry 6
    dw $0020, $0020, $0020, $0020 ; entry 7

; 3 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map1BScreens0::
    dfar Map1BScreens0_Y0X0 ; entry 0
    dfar Map1BScreens0_Y1X0 ; entry 1
    dfar Map1BScreens0_Y2X0 ; entry 2

Map1BAttrs0::
    dfar Map1BAttrs0_Y0X0 ; entry 0
    dfar Map1BAttrs0_Y1X0 ; entry 1
    dfar Map1BAttrs0_Y2X0 ; entry 2
    db $62, $67, $48, $c7, $68, $48, $5e, $69, $48, $3e, $6a, $48, $dc, $6a, $48, $1c
    db $6b, $48

; LZSS-compressed: 206 bytes that expand to 360 (E-0016, E-0017)
Map1BScreens0_Y0X0::
    INCBIN "maps/map1_b/screens0_y0_x0.lz"

; LZSS-compressed: 151 bytes that expand to 360 (E-0016, E-0017)
Map1BScreens0_Y1X0::
    INCBIN "maps/map1_b/screens0_y1_x0.lz"

KeyWorldScreen48_2::
    INCBIN "maps/key_worlds/screen48_2.lz"

; LZSS-compressed: 224 bytes that expand to 360 (E-0016, E-0017)
Map1BScreens0_Y2X0::
    INCBIN "maps/map1_b/screens0_y2_x0.lz"

; LZSS-compressed: 94 bytes that expand to 360 (E-0016, E-0017)
Map1BAttrs0_Y0X0::
    INCBIN "maps/map1_b/attrs0_y0_x0.lz"

; LZSS-compressed: 64 bytes that expand to 360 (E-0016, E-0017)
Map1BAttrs0_Y1X0::
    db $68, $01, $03, $00, $00, $02, $02, $02, $02, $01, $03, $06, $01, $03, $02, $00
    db $03, $fb, $f7, $02, $03, $0a, $02, $03, $0f, $04, $03, $00, $04, $03, $1f, $09
    db $03, $fd, $f1, $01, $01, $03, $a0, $ff, $4d, $03, $a5, $0f, $4d, $03, $c4, $ff
    db $2b, $03, $44, $00, $03, $44, $14, $03, $3c, $06, $03, $58, $14, $03, $e4, $02

KeyWorldScreen48_3::
    db $68, $01, $03, $00, $00, $02, $02, $02, $02, $01, $03, $06, $01, $03, $02, $00
    db $03, $fb, $f7, $02, $03, $0a, $02, $03, $0f, $04, $03, $00, $04, $03, $1f, $09
    db $03, $fd, $f1, $01, $01, $03, $a0, $ff, $4d, $03, $a5, $0f, $4d, $03, $c4, $ff
    db $2b, $03, $44, $00, $03, $44, $14, $03, $3c, $06, $03, $58, $14, $03, $e4, $02

; LZSS-compressed: 102 bytes that expand to 360 (E-0016, E-0017)
Map1BAttrs0_Y2X0::
    INCBIN "maps/map1_b/attrs0_y2_x0.lz"

; compressed tileset of map $04 (the first map record using it)
; LZSS-compressed: 946 bytes that expand to 1264 (E-0016, E-0017)
Map04Tileset::
    INCBIN "maps/map04/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map04Palettes::
    dw $7d86, $7fff, $7fe1, $0000 ; entry 0
    dw $012f, $031d, $01d8, $0000 ; entry 1
    dw $012f, $67ff, $0214, $0000 ; entry 2
    dw $158f, $4298, $2a13, $0020 ; entry 3
    dw $001b, $2bff, $023f, $0000 ; entry 4
    dw $29ce, $4fff, $3695, $0020 ; entry 5
    dw $34eb, $50bf, $3071, $0020 ; entry 6
    dw $0020, $0020, $0020, $0020 ; entry 7

; 3 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map04Screens0::
    dfar Map04Screens0_Y0X0 ; entry 0
    dfar Map04Screens0_Y0X1 ; entry 1
    dfar Map04Screens0_Y0X2 ; entry 2

Map04Attrs0::
    dfar Map04Attrs0_Y0X0 ; entry 0
    dfar Map04Attrs0_Y0X1 ; entry 1
    dfar Map04Attrs0_Y0X2 ; entry 2

; LZSS-compressed: 233 bytes that expand to 360 (E-0016, E-0017)
Map04Screens0_Y0X0::
    INCBIN "maps/map04/screens0_y0_x0.lz"

; LZSS-compressed: 196 bytes that expand to 360 (E-0016, E-0017)
Map04Screens0_Y0X1::
    INCBIN "maps/map04/screens0_y0_x1.lz"

; LZSS-compressed: 218 bytes that expand to 360 (E-0016, E-0017)
Map04Screens0_Y0X2::
    INCBIN "maps/map04/screens0_y0_x2.lz"

; LZSS-compressed: 96 bytes that expand to 360 (E-0016, E-0017)
Map04Attrs0_Y0X0::
    INCBIN "maps/map04/attrs0_y0_x0.lz"

; LZSS-compressed: 87 bytes that expand to 360 (E-0016, E-0017)
Map04Attrs0_Y0X1::
    INCBIN "maps/map04/attrs0_y0_x1.lz"

; LZSS-compressed: 108 bytes that expand to 360 (E-0016, E-0017)
Map04Attrs0_Y0X2::
    INCBIN "maps/map04/attrs0_y0_x2.lz"

; compressed tileset of map $14 (the first map record using it)
; LZSS-compressed: 1329 bytes that expand to 2048 (E-0016, E-0017)
Map14Tileset::
    INCBIN "maps/map14/tileset.lz"

; LZSS-compressed: 1494 bytes that expand to 2048 (E-0016, E-0017)
Tiles2Gfx::
    INCBIN "gfx/misc/tiles2_gfx.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map14Palettes::
    dw $7d86, $7fff, $7fe1, $0000 ; entry 0
    dw $0453, $6bff, $201f, $0000 ; entry 1
    dw $012f, $6bff, $025a, $0000 ; entry 2
    dw $5d8c, $7fff, $7e75, $0000 ; entry 3
    dw $7d86, $7fff, $7fe1, $0000 ; entry 4
    dw $0000, $0000, $0000, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map14Screens0::
    dfar Map14Screens0_Y0X0 ; entry 0

Map14Attrs0::
    dfar Map14Attrs0_Y0X0 ; entry 0

; LZSS-compressed: 292 bytes that expand to 360 (E-0016, E-0017)
Map14Screens0_Y0X0::
    INCBIN "maps/map14/screens0_y0_x0.lz"

; LZSS-compressed: 67 bytes that expand to 360 (E-0016, E-0017)
Map14Attrs0_Y0X0::
    INCBIN "maps/map14/attrs0_y0_x0.lz"
    ds $1c, $00
