; ROM bank $46: map screens, attributes and tilesets
; The annotated listing of this bank is build/listing/bank46.asm.

SECTION "Bank 46", ROMX
    db $46

; Tiles: 2048 bytes = 128 tiles of 2bpp that fill vTiles1 ($8800-$8FFF); only 56 tiles are drawn,
; the rest are blank. Rendered: tiles 36-79 are the same letter, frame, icon, arrow and sign tiles
; as LetterFrameIconTiles (INFOTESKLPA, rounded window frame, skull and arrows, male and female
; signs, Ye), tiles 95-109 the digits 0-9, the level mark, H, M and a colon. It is the base tile set
; that the game mode initialisers expand into vTiles1: GameMode1_Init (field), GameMode5_Init_Boot,
; GameMode5_Init_TitleMenu, GameMode5_Init_ReturnToTitle, GameMode5_Init_ReloadTitle,
; GameMode5_Init_AfterLinkBattle, GameMode6_Init, GameMode8_Init, BreedMenu_ReturnToMap_LoadTiles,
; LibraryMenu_ShowMonsterEntry_Close, CloseShopMenu_ReloadTextTiles, CloseMenuE9_LoadTiles and
; others. (C1, E-0383)
; LZSS-compressed: 644 bytes that expand to 2048 (E-0016, E-0017)
LetterFrameIconDigitTiles::
    INCBIN "gfx/misc/letter_frame_icon_digit_tiles.lz"

; 12 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map00Screens0::
    dfar Map00Screens0_Y0X0 ; entry 0
    dfar Map00Screens0_Y0X0 ; entry 1
    dfar Map00Screens0_Y0X0 ; entry 2
    dfar Map00Screens0_Y0X0 ; entry 3
    dfar Map00Screens0_Y1X1 ; entry 4
    dfar Map00Screens0_Y1X2 ; entry 5
    dfar Map00Screens0_Y2X0 ; entry 6
    dfar Map00Screens0_Y2X1 ; entry 7
    dfar Map00Screens0_Y2X2 ; entry 8
    dfar Map00Screens0_Y3X0 ; entry 9
    dfar Map00Screens0_Y3X1 ; entry 10
    dfar Map00Screens0_Y3X2 ; entry 11

Map00Attrs0::
    dfar Map00Attrs0_Y0X0 ; entry 0
    dfar Map00Attrs0_Y0X0 ; entry 1
    dfar Map00Attrs0_Y0X0 ; entry 2
    dfar Map00Attrs0_Y0X0 ; entry 3
    dfar Map00Attrs0_Y1X1 ; entry 4
    dfar Map00Attrs0_Y1X2 ; entry 5
    dfar Map00Attrs0_Y2X0 ; entry 6
    dfar Map00Attrs0_Y2X1 ; entry 7
    dfar Map00Attrs0_Y2X2 ; entry 8
    dfar Map00Attrs0_Y3X0 ; entry 9
    dfar Map00Attrs0_Y3X1 ; entry 10
    dfar Map00Attrs0_Y3X2 ; entry 11

Map00Screens2::
    dfar Map00Screens0_Y0X0 ; entry 0
    dfar Map00Screens0_Y0X0 ; entry 1
    dfar Map00Screens0_Y0X0 ; entry 2
    dfar Map00Screens0_Y0X0 ; entry 3
    dfar Map00Screens2_Y1X1 ; entry 4
    dfar Map00Screens0_Y1X2 ; entry 5
    dfar Map00Screens0_Y2X0 ; entry 6
    dfar Map00Screens0_Y2X1 ; entry 7
    dfar Map00Screens2_Y2X2 ; entry 8
    dfar Map00Screens0_Y3X0 ; entry 9
    dfar Map00Screens2_Y3X1 ; entry 10
    dfar Map00Screens2_Y3X2 ; entry 11

Map00Attrs2::
    dfar Map00Attrs0_Y0X0 ; entry 0
    dfar Map00Attrs0_Y0X0 ; entry 1
    dfar Map00Attrs0_Y0X0 ; entry 2
    dfar Map00Attrs0_Y0X0 ; entry 3
    dfar Map00Attrs2_Y1X1 ; entry 4
    dfar Map00Attrs0_Y1X2 ; entry 5
    dfar Map00Attrs0_Y2X0 ; entry 6
    dfar Map00Attrs0_Y2X1 ; entry 7
    dfar Map00Attrs2_Y2X2 ; entry 8
    dfar Map00Attrs0_Y3X0 ; entry 9
    dfar Map00Attrs2_Y3X1 ; entry 10
    dfar Map00Attrs2_Y3X2 ; entry 11

Map00Screens3::
    dfar Map00Screens0_Y0X0 ; entry 0
    dfar Map00Screens0_Y0X0 ; entry 1
    dfar Map00Screens0_Y0X0 ; entry 2
    dfar Map00Screens0_Y0X0 ; entry 3
    dfar Map00Screens3_Y1X1 ; entry 4
    dfar Map00Screens0_Y1X2 ; entry 5
    dfar Map00Screens0_Y2X0 ; entry 6
    dfar Map00Screens0_Y2X1 ; entry 7
    dfar Map00Screens3_Y2X2 ; entry 8
    dfar Map00Screens0_Y3X0 ; entry 9
    dfar Map00Screens2_Y3X1 ; entry 10
    dfar Map00Screens2_Y3X2 ; entry 11

Map00Attrs3::
    dfar Map00Attrs0_Y0X0 ; entry 0
    dfar Map00Attrs0_Y0X0 ; entry 1
    dfar Map00Attrs0_Y0X0 ; entry 2
    dfar Map00Attrs0_Y0X0 ; entry 3
    dfar Map00Attrs3_Y1X1 ; entry 4
    dfar Map00Attrs0_Y1X2 ; entry 5
    dfar Map00Attrs0_Y2X0 ; entry 6
    dfar Map00Attrs0_Y2X1 ; entry 7
    dfar Map00Attrs3_Y2X2 ; entry 8
    dfar Map00Attrs0_Y3X0 ; entry 9
    dfar Map00Attrs2_Y3X1 ; entry 10
    dfar Map00Attrs2_Y3X2 ; entry 11

Map00Screens4::
    dfar Map00Screens0_Y0X0 ; entry 0
    dfar Map00Screens0_Y0X0 ; entry 1
    dfar Map00Screens0_Y0X0 ; entry 2
    dfar Map00Screens0_Y0X0 ; entry 3
    dfar Map00Screens3_Y1X1 ; entry 4
    dfar Map00Screens4_Y1X2 ; entry 5
    dfar Map00Screens0_Y2X0 ; entry 6
    dfar Map00Screens0_Y2X1 ; entry 7
    dfar Map00Screens3_Y2X2 ; entry 8
    dfar Map00Screens0_Y3X0 ; entry 9
    dfar Map00Screens2_Y3X1 ; entry 10
    dfar Map00Screens2_Y3X2 ; entry 11

Map00Attrs4::
    dfar Map00Attrs0_Y0X0 ; entry 0
    dfar Map00Attrs0_Y0X0 ; entry 1
    dfar Map00Attrs0_Y0X0 ; entry 2
    dfar Map00Attrs0_Y0X0 ; entry 3
    dfar Map00Attrs3_Y1X1 ; entry 4
    dfar Map00Attrs4_Y1X2 ; entry 5
    dfar Map00Attrs0_Y2X0 ; entry 6
    dfar Map00Attrs0_Y2X1 ; entry 7
    dfar Map00Attrs3_Y2X2 ; entry 8
    dfar Map00Attrs0_Y3X0 ; entry 9
    dfar Map00Attrs2_Y3X1 ; entry 10
    dfar Map00Attrs2_Y3X2 ; entry 11

Map00Screens5::
    dfar Map00Screens0_Y0X0 ; entry 0
    dfar Map00Screens0_Y0X0 ; entry 1
    dfar Map00Screens0_Y0X0 ; entry 2
    dfar Map00Screens0_Y0X0 ; entry 3
    dfar Map00Screens3_Y1X1 ; entry 4
    dfar Map00Screens4_Y1X2 ; entry 5
    dfar Map00Screens5_Y2X0 ; entry 6
    dfar Map00Screens0_Y2X1 ; entry 7
    dfar Map00Screens3_Y2X2 ; entry 8
    dfar Map00Screens0_Y3X0 ; entry 9
    dfar Map00Screens2_Y3X1 ; entry 10
    dfar Map00Screens2_Y3X2 ; entry 11

Map00Attrs5::
    dfar Map00Attrs0_Y0X0 ; entry 0
    dfar Map00Attrs0_Y0X0 ; entry 1
    dfar Map00Attrs0_Y0X0 ; entry 2
    dfar Map00Attrs0_Y0X0 ; entry 3
    dfar Map00Attrs3_Y1X1 ; entry 4
    dfar Map00Attrs4_Y1X2 ; entry 5
    dfar Map00Attrs5_Y2X0 ; entry 6
    dfar Map00Attrs0_Y2X1 ; entry 7
    dfar Map00Attrs3_Y2X2 ; entry 8
    dfar Map00Attrs0_Y3X0 ; entry 9
    dfar Map00Attrs2_Y3X1 ; entry 10
    dfar Map00Attrs2_Y3X2 ; entry 11

Map00Screens6::
    dfar Map00Screens0_Y0X0 ; entry 0
    dfar Map00Screens0_Y0X0 ; entry 1
    dfar Map00Screens0_Y0X0 ; entry 2
    dfar Map00Screens0_Y0X0 ; entry 3
    dfar Map00Screens0_Y1X1 ; entry 4
    dfar Map00Screens4_Y1X2 ; entry 5
    dfar Map00Screens5_Y2X0 ; entry 6
    dfar Map00Screens0_Y2X1 ; entry 7
    dfar Map00Screens3_Y2X2 ; entry 8
    dfar Map00Screens0_Y3X0 ; entry 9
    dfar Map00Screens2_Y3X1 ; entry 10
    dfar Map00Screens2_Y3X2 ; entry 11

Map00Attrs6::
    dfar Map00Attrs0_Y0X0 ; entry 0
    dfar Map00Attrs0_Y0X0 ; entry 1
    dfar Map00Attrs0_Y0X0 ; entry 2
    dfar Map00Attrs0_Y0X0 ; entry 3
    dfar Map00Attrs0_Y1X1 ; entry 4
    dfar Map00Attrs4_Y1X2 ; entry 5
    dfar Map00Attrs5_Y2X0 ; entry 6
    dfar Map00Attrs0_Y2X1 ; entry 7
    dfar Map00Attrs3_Y2X2 ; entry 8
    dfar Map00Attrs0_Y3X0 ; entry 9
    dfar Map00Attrs2_Y3X1 ; entry 10
    dfar Map00Attrs2_Y3X2 ; entry 11

; LZSS-compressed: 28 bytes that expand to 360 (E-0016, E-0017)
Map00Screens0_Y0X0::
    db $68, $01, $02, $00, $01, $02, $00, $0e, $02, $01, $0f, $00, $02, $ff, $ff, $4d
    db $02, $5f, $0f, $4d, $02, $bf, $0f, $4d, $02, $f7, $0f, $0e

; LZSS-compressed: 197 bytes that expand to 360 (E-0016, E-0017)
Map00Screens0_Y1X1::
    INCBIN "maps/map00/screens0_y1_x1.lz"

; LZSS-compressed: 165 bytes that expand to 360 (E-0016, E-0017)
Map00Screens2_Y1X1::
    INCBIN "maps/map00/screens2_y1_x1.lz"

; LZSS-compressed: 203 bytes that expand to 360 (E-0016, E-0017)
Map00Screens3_Y1X1::
    INCBIN "maps/map00/screens3_y1_x1.lz"

; LZSS-compressed: 147 bytes that expand to 360 (E-0016, E-0017)
Map00Screens0_Y1X2::
    INCBIN "maps/map00/screens0_y1_x2.lz"

; LZSS-compressed: 153 bytes that expand to 360 (E-0016, E-0017)
Map00Screens4_Y1X2::
    INCBIN "maps/map00/screens4_y1_x2.lz"

; LZSS-compressed: 218 bytes that expand to 360 (E-0016, E-0017)
Map00Screens0_Y2X0::
    INCBIN "maps/map00/screens0_y2_x0.lz"

; LZSS-compressed: 223 bytes that expand to 360 (E-0016, E-0017)
Map00Screens5_Y2X0::
    INCBIN "maps/map00/screens5_y2_x0.lz"

; LZSS-compressed: 139 bytes that expand to 360 (E-0016, E-0017)
Map00Screens0_Y2X1::
    INCBIN "maps/map00/screens0_y2_x1.lz"

; LZSS-compressed: 178 bytes that expand to 360 (E-0016, E-0017)
Map00Screens0_Y2X2::
    INCBIN "maps/map00/screens0_y2_x2.lz"

; LZSS-compressed: 184 bytes that expand to 360 (E-0016, E-0017)
Map00Screens2_Y2X2::
    INCBIN "maps/map00/screens2_y2_x2.lz"

; LZSS-compressed: 189 bytes that expand to 360 (E-0016, E-0017)
Map00Screens3_Y2X2::
    INCBIN "maps/map00/screens3_y2_x2.lz"

; LZSS-compressed: 217 bytes that expand to 360 (E-0016, E-0017)
Map00Screens0_Y3X0::
    INCBIN "maps/map00/screens0_y3_x0.lz"

; LZSS-compressed: 162 bytes that expand to 360 (E-0016, E-0017)
Map00Screens0_Y3X1::
    INCBIN "maps/map00/screens0_y3_x1.lz"

; LZSS-compressed: 152 bytes that expand to 360 (E-0016, E-0017)
Map00Screens2_Y3X1::
    INCBIN "maps/map00/screens2_y3_x1.lz"

; LZSS-compressed: 158 bytes that expand to 360 (E-0016, E-0017)
Map00Screens0_Y3X2::
    INCBIN "maps/map00/screens0_y3_x2.lz"

; LZSS-compressed: 129 bytes that expand to 360 (E-0016, E-0017)
Map00Screens2_Y3X2::
    INCBIN "maps/map00/screens2_y3_x2.lz"

; LZSS-compressed: 28 bytes that expand to 360 (E-0016, E-0017)
Map00Attrs0_Y0X0::
    db $68, $01, $01, $10, $01, $ff, $ff, $00, $01, $ff, $ff, $01, $01, $00, $0f, $4d
    db $01, $60, $0f, $4d, $01, $c0, $0f, $4d, $01, $f8, $0f, $0d

; LZSS-compressed: 132 bytes that expand to 360 (E-0016, E-0017)
Map00Attrs0_Y1X1::
    INCBIN "maps/map00/attrs0_y1_x1.lz"

; LZSS-compressed: 131 bytes that expand to 360 (E-0016, E-0017)
Map00Attrs2_Y1X1::
    INCBIN "maps/map00/attrs2_y1_x1.lz"

; LZSS-compressed: 193 bytes that expand to 360 (E-0016, E-0017)
Map00Attrs3_Y1X1::
    INCBIN "maps/map00/attrs3_y1_x1.lz"

; LZSS-compressed: 116 bytes that expand to 360 (E-0016, E-0017)
Map00Attrs0_Y1X2::
    INCBIN "maps/map00/attrs0_y1_x2.lz"

; LZSS-compressed: 118 bytes that expand to 360 (E-0016, E-0017)
Map00Attrs4_Y1X2::
    INCBIN "maps/map00/attrs4_y1_x2.lz"

; LZSS-compressed: 113 bytes that expand to 360 (E-0016, E-0017)
Map00Attrs0_Y2X0::
    INCBIN "maps/map00/attrs0_y2_x0.lz"

; LZSS-compressed: 115 bytes that expand to 360 (E-0016, E-0017)
Map00Attrs5_Y2X0::
    INCBIN "maps/map00/attrs5_y2_x0.lz"

; LZSS-compressed: 98 bytes that expand to 360 (E-0016, E-0017)
Map00Attrs0_Y2X1::
    INCBIN "maps/map00/attrs0_y2_x1.lz"

; LZSS-compressed: 152 bytes that expand to 360 (E-0016, E-0017)
Map00Attrs0_Y2X2::
    INCBIN "maps/map00/attrs0_y2_x2.lz"

; LZSS-compressed: 153 bytes that expand to 360 (E-0016, E-0017)
Map00Attrs2_Y2X2::
    INCBIN "maps/map00/attrs2_y2_x2.lz"

; LZSS-compressed: 135 bytes that expand to 360 (E-0016, E-0017)
Map00Attrs3_Y2X2::
    INCBIN "maps/map00/attrs3_y2_x2.lz"

; LZSS-compressed: 178 bytes that expand to 360 (E-0016, E-0017)
Map00Attrs0_Y3X0::
    INCBIN "maps/map00/attrs0_y3_x0.lz"

; LZSS-compressed: 99 bytes that expand to 360 (E-0016, E-0017)
Map00Attrs0_Y3X1::
    INCBIN "maps/map00/attrs0_y3_x1.lz"

; LZSS-compressed: 104 bytes that expand to 360 (E-0016, E-0017)
Map00Attrs2_Y3X1::
    INCBIN "maps/map00/attrs2_y3_x1.lz"

; LZSS-compressed: 70 bytes that expand to 360 (E-0016, E-0017)
Map00Attrs0_Y3X2::
    INCBIN "maps/map00/attrs0_y3_x2.lz"

; LZSS-compressed: 46 bytes that expand to 360 (E-0016, E-0017)
Map00Attrs2_Y3X2::
    db $68, $01, $01, $02, $01, $00, $05, $03, $03, $03, $03, $01, $fa, $ff, $37, $01
    db $0a, $00, $01, $48, $0f, $15, $01, $f8, $fc, $01, $80, $0e, $01, $80, $08, $01
    db $9e, $0f, $03, $01, $58, $08, $01, $c0, $0f, $31, $01, $17, $1f, $3d

; compressed tileset of map $01 (the first map record using it)
; LZSS-compressed: 1352 bytes that expand to 1712 (E-0016, E-0017)
Map01Tileset::
    INCBIN "maps/map01/tileset.lz"

; 12 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map01Screens0::
    dfar Map01Screens0_Y0X0 ; entry 0
    dfar Map01Screens0_Y0X1 ; entry 1
    dfar Map01Screens0_Y0X0 ; entry 2
    dfar Map01Screens0_Y0X0 ; entry 3
    dfar Map01Screens0_Y1X0 ; entry 4
    dfar Map01Screens0_Y1X1 ; entry 5
    dfar Map01Screens0_Y1X2 ; entry 6
    dfar Map01Screens0_Y1X3 ; entry 7
    dfar Map01Screens0_Y2X0 ; entry 8
    dfar Map01Screens0_Y2X1 ; entry 9
    dfar Map01Screens0_Y2X2 ; entry 10
    dfar Map01Screens0_Y2X3 ; entry 11

Map01Attrs0::
    dfar Map01Attrs0_Y0X0 ; entry 0
    dfar Map01Attrs0_Y0X1 ; entry 1
    dfar Map01Attrs0_Y0X0 ; entry 2
    dfar Map01Attrs0_Y0X0 ; entry 3
    dfar Map01Attrs0_Y1X0 ; entry 4
    dfar Map01Attrs0_Y1X1 ; entry 5
    dfar Map01Attrs0_Y1X2 ; entry 6
    dfar Map01Attrs0_Y1X3 ; entry 7
    dfar Map01Attrs0_Y2X0 ; entry 8
    dfar Map01Attrs0_Y2X1 ; entry 9
    dfar Map01Attrs0_Y2X2 ; entry 10
    dfar Map01Attrs0_Y2X3 ; entry 11

Map01Screens3::
    dfar Map01Screens0_Y0X0 ; entry 0
    dfar Map01Screens0_Y0X1 ; entry 1
    dfar Map01Screens0_Y0X0 ; entry 2
    dfar Map01Screens0_Y0X0 ; entry 3
    dfar Map01Screens0_Y1X0 ; entry 4
    dfar Map01Screens0_Y1X1 ; entry 5
    dfar Map01Screens3_Y1X2 ; entry 6
    dfar Map01Screens3_Y1X3 ; entry 7
    dfar Map01Screens0_Y2X0 ; entry 8
    dfar Map01Screens0_Y2X1 ; entry 9
    dfar Map01Screens3_Y2X2 ; entry 10
    dfar Map01Screens3_Y2X3 ; entry 11

Map01Attrs3::
    dfar Map01Attrs0_Y0X0 ; entry 0
    dfar Map01Attrs0_Y0X1 ; entry 1
    dfar Map01Attrs0_Y0X0 ; entry 2
    dfar Map01Attrs0_Y0X0 ; entry 3
    dfar Map01Attrs0_Y1X0 ; entry 4
    dfar Map01Attrs0_Y1X1 ; entry 5
    dfar Map01Attrs3_Y1X2 ; entry 6
    dfar Map01Attrs3_Y1X3 ; entry 7
    dfar Map01Attrs0_Y2X0 ; entry 8
    dfar Map01Attrs0_Y2X1 ; entry 9
    dfar Map01Attrs3_Y2X2 ; entry 10
    dfar Map01Attrs3_Y2X3 ; entry 11

Map01Screens4::
    dfar Map01Screens0_Y0X0 ; entry 0
    dfar Map01Screens0_Y0X1 ; entry 1
    dfar Map01Screens0_Y0X0 ; entry 2
    dfar Map01Screens0_Y0X0 ; entry 3
    dfar Map01Screens0_Y1X0 ; entry 4
    dfar Map01Screens0_Y1X1 ; entry 5
    dfar Map01Screens3_Y1X2 ; entry 6
    dfar Map01Screens3_Y1X3 ; entry 7
    dfar Map01Screens4_Y2X0 ; entry 8
    dfar Map01Screens0_Y2X1 ; entry 9
    dfar Map01Screens3_Y2X2 ; entry 10
    dfar Map01Screens3_Y2X3 ; entry 11

Map01Attrs4::
    dfar Map01Attrs0_Y0X0 ; entry 0
    dfar Map01Attrs0_Y0X1 ; entry 1
    dfar Map01Attrs0_Y0X0 ; entry 2
    dfar Map01Attrs0_Y0X0 ; entry 3
    dfar Map01Attrs0_Y1X0 ; entry 4
    dfar Map01Attrs0_Y1X1 ; entry 5
    dfar Map01Attrs3_Y1X2 ; entry 6
    dfar Map01Attrs3_Y1X3 ; entry 7
    dfar Map01Attrs4_Y2X0 ; entry 8
    dfar Map01Attrs0_Y2X1 ; entry 9
    dfar Map01Attrs3_Y2X2 ; entry 10
    dfar Map01Attrs3_Y2X3 ; entry 11

Map01Screens5::
    dfar Map01Screens0_Y0X0 ; entry 0
    dfar Map01Screens0_Y0X1 ; entry 1
    dfar Map01Screens0_Y0X0 ; entry 2
    dfar Map01Screens0_Y0X0 ; entry 3
    dfar Map01Screens0_Y1X0 ; entry 4
    dfar Map01Screens0_Y1X1 ; entry 5
    dfar Map01Screens3_Y1X2 ; entry 6
    dfar Map01Screens3_Y1X3 ; entry 7
    dfar Map01Screens4_Y2X0 ; entry 8
    dfar Map01Screens5_Y2X1 ; entry 9
    dfar Map01Screens5_Y2X2 ; entry 10
    dfar Map01Screens3_Y2X3 ; entry 11

Map01Attrs5::
    dfar Map01Attrs0_Y0X0 ; entry 0
    dfar Map01Attrs0_Y0X1 ; entry 1
    dfar Map01Attrs0_Y0X0 ; entry 2
    dfar Map01Attrs0_Y0X0 ; entry 3
    dfar Map01Attrs0_Y1X0 ; entry 4
    dfar Map01Attrs0_Y1X1 ; entry 5
    dfar Map01Attrs3_Y1X2 ; entry 6
    dfar Map01Attrs3_Y1X3 ; entry 7
    dfar Map01Attrs4_Y2X0 ; entry 8
    dfar Map01Attrs5_Y2X1 ; entry 9
    dfar Map01Attrs5_Y2X2 ; entry 10
    dfar Map01Attrs3_Y2X3 ; entry 11

Map01Screens6::
    dfar Map01Screens0_Y0X0 ; entry 0
    dfar Map01Screens0_Y0X1 ; entry 1
    dfar Map01Screens0_Y0X0 ; entry 2
    dfar Map01Screens0_Y0X0 ; entry 3
    dfar Map01Screens0_Y1X0 ; entry 4
    dfar Map01Screens0_Y1X1 ; entry 5
    dfar Map01Screens0_Y1X2 ; entry 6
    dfar Map01Screens0_Y1X3 ; entry 7
    dfar Map01Screens4_Y2X0 ; entry 8
    dfar Map01Screens0_Y2X1 ; entry 9
    dfar Map01Screens0_Y2X2 ; entry 10
    dfar Map01Screens0_Y2X3 ; entry 11

Map01Attrs6::
    dfar Map01Attrs0_Y0X0 ; entry 0
    dfar Map01Attrs0_Y0X1 ; entry 1
    dfar Map01Attrs0_Y0X0 ; entry 2
    dfar Map01Attrs0_Y0X0 ; entry 3
    dfar Map01Attrs0_Y1X0 ; entry 4
    dfar Map01Attrs0_Y1X1 ; entry 5
    dfar Map01Attrs0_Y1X2 ; entry 6
    dfar Map01Attrs0_Y1X3 ; entry 7
    dfar Map01Attrs4_Y2X0 ; entry 8
    dfar Map01Attrs0_Y2X1 ; entry 9
    dfar Map01Attrs0_Y2X2 ; entry 10
    dfar Map01Attrs0_Y2X3 ; entry 11

; LZSS-compressed: 196 bytes that expand to 360 (E-0016, E-0017)
Map01Screens0_Y0X0::
    INCBIN "maps/map01/screens0_y0_x0.lz"

; LZSS-compressed: 218 bytes that expand to 360 (E-0016, E-0017)
Map01Screens0_Y0X1::
    INCBIN "maps/map01/screens0_y0_x1.lz"

; LZSS-compressed: 115 bytes that expand to 360 (E-0016, E-0017)
Map01Screens0_Y1X0::
    INCBIN "maps/map01/screens0_y1_x0.lz"

; LZSS-compressed: 205 bytes that expand to 360 (E-0016, E-0017)
Map01Screens0_Y1X1::
    INCBIN "maps/map01/screens0_y1_x1.lz"

; LZSS-compressed: 207 bytes that expand to 360 (E-0016, E-0017)
Map01Screens0_Y1X2::
    INCBIN "maps/map01/screens0_y1_x2.lz"

; LZSS-compressed: 235 bytes that expand to 360 (E-0016, E-0017)
Map01Screens3_Y1X2::
    INCBIN "maps/map01/screens3_y1_x2.lz"

Map01Screens0_Y1X3::
    INCBIN "maps/map01/screens0_y1_x3.lz"

; LZSS-compressed: 156 bytes that expand to 360 (E-0016, E-0017)
Map01Screens3_Y1X3::
    INCBIN "maps/map01/screens3_y1_x3.lz"

; LZSS-compressed: 197 bytes that expand to 360 (E-0016, E-0017)
Map01Screens0_Y2X0::
    INCBIN "maps/map01/screens0_y2_x0.lz"

; LZSS-compressed: 220 bytes that expand to 360 (E-0016, E-0017)
Map01Screens4_Y2X0::
    INCBIN "maps/map01/screens4_y2_x0.lz"

; LZSS-compressed: 150 bytes that expand to 360 (E-0016, E-0017)
Map01Screens0_Y2X1::
    INCBIN "maps/map01/screens0_y2_x1.lz"

; LZSS-compressed: 149 bytes that expand to 360 (E-0016, E-0017)
Map01Screens5_Y2X1::
    INCBIN "maps/map01/screens5_y2_x1.lz"

; LZSS-compressed: 169 bytes that expand to 360 (E-0016, E-0017)
Map01Screens0_Y2X2::
    INCBIN "maps/map01/screens0_y2_x2.lz"

; LZSS-compressed: 227 bytes that expand to 360 (E-0016, E-0017)
Map01Screens3_Y2X2::
    INCBIN "maps/map01/screens3_y2_x2.lz"

; LZSS-compressed: 203 bytes that expand to 360 (E-0016, E-0017)
Map01Screens5_Y2X2::
    INCBIN "maps/map01/screens5_y2_x2.lz"

; LZSS-compressed: 231 bytes that expand to 360 (E-0016, E-0017)
Map01Screens0_Y2X3::
    INCBIN "maps/map01/screens0_y2_x3.lz"

; LZSS-compressed: 182 bytes that expand to 360 (E-0016, E-0017)
Map01Screens3_Y2X3::
    INCBIN "maps/map01/screens3_y2_x3.lz"

; LZSS-compressed: 86 bytes that expand to 360 (E-0016, E-0017)
Map01Attrs0_Y0X0::
    INCBIN "maps/map01/attrs0_y0_x0.lz"

; LZSS-compressed: 103 bytes that expand to 360 (E-0016, E-0017)
Map01Attrs0_Y0X1::
    INCBIN "maps/map01/attrs0_y0_x1.lz"

; LZSS-compressed: 48 bytes that expand to 360 (E-0016, E-0017)
Map01Attrs0_Y1X0::
    db $68, $01, $01, $00, $00, $04, $01, $02, $0d, $01, $00, $0f, $29, $02, $02, $01
    db $3e, $0f, $4d, $01, $62, $0f, $05, $03, $03, $04, $04, $01, $ca, $00, $01, $cc
    db $04, $01, $c6, $0f, $07, $01, $f2, $0c, $01, $f0, $0f, $03, $01, $66, $0f, $3b

; LZSS-compressed: 94 bytes that expand to 360 (E-0016, E-0017)
Map01Attrs0_Y1X1::
    INCBIN "maps/map01/attrs0_y1_x1.lz"

; LZSS-compressed: 73 bytes that expand to 360 (E-0016, E-0017)
Map01Attrs0_Y1X2::
    INCBIN "maps/map01/attrs0_y1_x2.lz"

; LZSS-compressed: 92 bytes that expand to 360 (E-0016, E-0017)
Map01Attrs3_Y1X2::
    INCBIN "maps/map01/attrs3_y1_x2.lz"

; LZSS-compressed: 72 bytes that expand to 360 (E-0016, E-0017)
Map01Attrs0_Y1X3::
    INCBIN "maps/map01/attrs0_y1_x3.lz"

; LZSS-compressed: 69 bytes that expand to 360 (E-0016, E-0017)
Map01Attrs3_Y1X3::
    INCBIN "maps/map01/attrs3_y1_x3.lz"

; LZSS-compressed: 87 bytes that expand to 360 (E-0016, E-0017)
Map01Attrs0_Y2X0::
    INCBIN "maps/map01/attrs0_y2_x0.lz"

; LZSS-compressed: 99 bytes that expand to 360 (E-0016, E-0017)
Map01Attrs4_Y2X0::
    INCBIN "maps/map01/attrs4_y2_x0.lz"

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
Map01Attrs0_Y2X1::
    INCBIN "maps/map01/attrs0_y2_x1.lz"

; LZSS-compressed: 78 bytes that expand to 360 (E-0016, E-0017)
Map01Attrs5_Y2X1::
    INCBIN "maps/map01/attrs5_y2_x1.lz"

; LZSS-compressed: 57 bytes that expand to 360 (E-0016, E-0017)
Map01Attrs0_Y2X2::
    db $68, $01, $01, $02, $01, $00, $05, $03, $03, $02, $02, $01, $fa, $ff, $15, $03
    db $03, $01, $24, $0f, $13, $01, $0c, $02, $01, $50, $0f, $11, $01, $84, $0a, $01
    db $82, $0e, $03, $01, $a8, $01, $01, $9a, $0f, $07, $01, $a8, $02, $01, $c8, $0f
    db $0f, $01, $a0, $0f, $15, $01, $12, $1f, $3d

; LZSS-compressed: 100 bytes that expand to 360 (E-0016, E-0017)
Map01Attrs3_Y2X2::
    INCBIN "maps/map01/attrs3_y2_x2.lz"

; LZSS-compressed: 97 bytes that expand to 360 (E-0016, E-0017)
Map01Attrs5_Y2X2::
    INCBIN "maps/map01/attrs5_y2_x2.lz"

; LZSS-compressed: 99 bytes that expand to 360 (E-0016, E-0017)
Map01Attrs0_Y2X3::
    INCBIN "maps/map01/attrs0_y2_x3.lz"

; LZSS-compressed: 93 bytes that expand to 360 (E-0016, E-0017)
Map01Attrs3_Y2X3::
    INCBIN "maps/map01/attrs3_y2_x3.lz"

; compressed tileset of map $02 (the first map record using it)
; LZSS-compressed: 827 bytes that expand to 1136 (E-0016, E-0017)
Map02Tileset::
    INCBIN "maps/map02/tileset.lz"

; 3 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map02Screens0::
    dfar Map02Screens0_Y0X0 ; entry 0
    dfar Map02Screens0_Y0X1 ; entry 1
    dfar Map02Screens0_Y0X2 ; entry 2

Map02Attrs0::
    dfar Map02Attrs0_Y0X0 ; entry 0
    dfar Map02Attrs0_Y0X1 ; entry 1
    dfar Map02Attrs0_Y0X2 ; entry 2

Map02Screens1::
    dfar Map02Screens1_Y0X0 ; entry 0
    dfar Map02Screens0_Y0X1 ; entry 1
    dfar Map02Screens0_Y0X2 ; entry 2

Map02Attrs1::
    dfar Map02Attrs1_Y0X0 ; entry 0
    dfar Map02Attrs0_Y0X1 ; entry 1
    dfar Map02Attrs0_Y0X2 ; entry 2

Map02Screens3::
    dfar Map02Screens0_Y0X0 ; entry 0
    dfar Map02Screens0_Y0X1 ; entry 1
    dfar Map02Screens3_Y0X2 ; entry 2

Map02Attrs3::
    dfar Map02Attrs0_Y0X0 ; entry 0
    dfar Map02Attrs0_Y0X1 ; entry 1
    dfar Map02Attrs3_Y0X2 ; entry 2

Map02Screens4::
    dfar Map02Screens4_Y0X0 ; entry 0
    dfar Map02Screens0_Y0X1 ; entry 1
    dfar Map02Screens3_Y0X2 ; entry 2

Map02Attrs4::
    dfar Map02Attrs4_Y0X0 ; entry 0
    dfar Map02Attrs0_Y0X1 ; entry 1
    dfar Map02Attrs3_Y0X2 ; entry 2

Map02Screens5::
    dfar Map02Screens4_Y0X0 ; entry 0
    dfar Map02Screens5_Y0X1 ; entry 1
    dfar Map02Screens5_Y0X2 ; entry 2

Map02Attrs5::
    dfar Map02Attrs4_Y0X0 ; entry 0
    dfar Map02Attrs5_Y0X1 ; entry 1
    dfar Map02Attrs5_Y0X2 ; entry 2

Map02Screens6::
    dfar Map02Screens4_Y0X0 ; entry 0
    dfar Map02Screens0_Y0X1 ; entry 1
    dfar Map02Screens0_Y0X2 ; entry 2

Map02Attrs6::
    dfar Map02Attrs4_Y0X0 ; entry 0
    dfar Map02Attrs0_Y0X1 ; entry 1
    dfar Map02Attrs0_Y0X2 ; entry 2

; LZSS-compressed: 215 bytes that expand to 360 (E-0016, E-0017)
Map02Screens0_Y0X0::
    INCBIN "maps/map02/screens0_y0_x0.lz"

; LZSS-compressed: 213 bytes that expand to 360 (E-0016, E-0017)
Map02Screens1_Y0X0::
    INCBIN "maps/map02/screens1_y0_x0.lz"

; LZSS-compressed: 210 bytes that expand to 360 (E-0016, E-0017)
Map02Screens4_Y0X0::
    INCBIN "maps/map02/screens4_y0_x0.lz"

; LZSS-compressed: 154 bytes that expand to 360 (E-0016, E-0017)
Map02Screens0_Y0X1::
    INCBIN "maps/map02/screens0_y0_x1.lz"

; LZSS-compressed: 150 bytes that expand to 360 (E-0016, E-0017)
Map02Screens5_Y0X1::
    INCBIN "maps/map02/screens5_y0_x1.lz"

; LZSS-compressed: 133 bytes that expand to 360 (E-0016, E-0017)
Map02Screens0_Y0X2::
    INCBIN "maps/map02/screens0_y0_x2.lz"

; LZSS-compressed: 168 bytes that expand to 360 (E-0016, E-0017)
Map02Screens3_Y0X2::
    INCBIN "maps/map02/screens3_y0_x2.lz"

; LZSS-compressed: 165 bytes that expand to 360 (E-0016, E-0017)
Map02Screens5_Y0X2::
    INCBIN "maps/map02/screens5_y0_x2.lz"

; LZSS-compressed: 70 bytes that expand to 360 (E-0016, E-0017)
Map02Attrs0_Y0X0::
    INCBIN "maps/map02/attrs0_y0_x0.lz"

; LZSS-compressed: 65 bytes that expand to 360 (E-0016, E-0017)
Map02Attrs1_Y0X0::
    INCBIN "maps/map02/attrs1_y0_x0.lz"

; LZSS-compressed: 79 bytes that expand to 360 (E-0016, E-0017)
Map02Attrs4_Y0X0::
    INCBIN "maps/map02/attrs4_y0_x0.lz"

; LZSS-compressed: 60 bytes that expand to 360 (E-0016, E-0017)
Map02Attrs0_Y0X1::
    db $68, $01, $01, $01, $ff, $fc, $02, $02, $02, $02, $01, $00, $0f, $01, $03, $01
    db $28, $01, $04, $04, $04, $04, $05, $05, $01, $28, $00, $01, $24, $0f, $0b, $01
    db $50, $0f, $47, $01, $4c, $0f, $01, $01, $10, $02, $01, $28, $00, $01, $04, $0a
    db $01, $c8, $0f, $03, $01, $f1, $0f, $4d, $01, $51, $1f, $03

; LZSS-compressed: 63 bytes that expand to 360 (E-0016, E-0017)
Map02Attrs5_Y0X1::
    db $68, $01, $01, $01, $ff, $fc, $06, $06, $06, $06, $01, $fc, $ff, $01, $03, $01
    db $28, $01, $04, $04, $04, $04, $05, $05, $01, $28, $00, $01, $24, $0f, $0b, $01
    db $50, $0f, $47, $06, $06, $02, $02, $01, $50, $0c, $00, $00, $02, $02, $01, $26
    db $02, $01, $04, $0a, $01, $c8, $0e, $01, $ed, $0f, $4d, $01, $4d, $1f, $07

; LZSS-compressed: 54 bytes that expand to 360 (E-0016, E-0017)
Map02Attrs0_Y0X2::
    db $68, $01, $01, $02, $01, $00, $0f, $3c, $03, $01, $50, $0f, $16, $01, $4e, $06
    db $01, $48, $06, $01, $7a, $0e, $01, $16, $0f, $29, $01, $3e, $0f, $01, $01, $fe
    db $fa, $01, $50, $02, $01, $f0, $0f, $03, $01, $fe, $f6, $01, $14, $14, $01, $18
    db $1f, $05, $01, $43, $1f, $11

; LZSS-compressed: 80 bytes that expand to 360 (E-0016, E-0017)
Map02Attrs3_Y0X2::
    INCBIN "maps/map02/attrs3_y0_x2.lz"

; LZSS-compressed: 69 bytes that expand to 360 (E-0016, E-0017)
Map02Attrs5_Y0X2::
    INCBIN "maps/map02/attrs5_y0_x2.lz"
    ds $498, $00
