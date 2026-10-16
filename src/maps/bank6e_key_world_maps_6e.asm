; ROM bank $6E: key-world map screens
; The annotated listing of this bank is build/listing/bank6e.asm.

SECTION "Bank 6E", ROMX[$4000], BANK[$6E]
    db $6e

; LZSS-compressed: 214 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom45_Y1X3_Tiles::
    INCBIN "maps/key_worlds/room45_y1_x3_tiles.lz"

; LZSS-compressed: 231 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom37_Y0X2_Tiles::
    INCBIN "maps/key_worlds/room37_y0_x2_tiles.lz"

; LZSS-compressed: 159 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom61_Y1X0_Tiles::
    INCBIN "maps/key_worlds/room61_y1_x0_tiles.lz"

; LZSS-compressed: 70 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom45_Y1X3_Attrs::
    INCBIN "maps/key_worlds/room45_y1_x3_attrs.lz"

; LZSS-compressed: 84 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom37_Y0X2_Attrs::
    INCBIN "maps/key_worlds/room37_y0_x2_attrs.lz"

; LZSS-compressed: 66 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom61_Y1X0_Attrs::
    INCBIN "maps/key_worlds/room61_y1_x0_attrs.lz"

; LZSS-compressed: 81 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom01_Y3X1_Attrs::
    INCBIN "maps/key_worlds/room01_y3_x1_attrs.lz"

KeyWorldRoom00_Y3X1_Attrs::
    INCBIN "maps/key_worlds/room00_y3_x1_attrs.lz"

; LZSS-compressed: 77 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom02_Y2X2_Attrs::
    INCBIN "maps/key_worlds/room02_y2_x2_attrs.lz"

; LZSS-compressed: 83 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom03_Y2X2_Attrs::
    INCBIN "maps/key_worlds/room03_y2_x2_attrs.lz"

; LZSS-compressed: 80 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom08_Y1X2_Attrs::
    INCBIN "maps/key_worlds/room08_y1_x2_attrs.lz"

; LZSS-compressed: 89 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom09_Y3X1_Attrs::
    INCBIN "maps/key_worlds/room09_y3_x1_attrs.lz"

; LZSS-compressed: 78 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0A_Y3X1_Attrs::
    INCBIN "maps/key_worlds/room0_a_y3_x1_attrs.lz"

; LZSS-compressed: 90 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0A_Y3X2_Attrs::
    INCBIN "maps/key_worlds/room0_a_y3_x2_attrs.lz"

KeyWorldScreen6E_1::
    INCBIN "maps/key_worlds/screen6_e_1.lz"

KeyWorldScreen6E_2::
    INCBIN "maps/key_worlds/screen6_e_2.lz"

; LZSS-compressed: 97 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen6E_3::
    INCBIN "maps/key_worlds/screen6_e_3.lz"

; LZSS-compressed: 92 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen6E_4::
    INCBIN "maps/key_worlds/screen6_e_4.lz"

; LZSS-compressed: 80 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom8B_Y3X1_Attrs::
    INCBIN "maps/key_worlds/room8_b_y3_x1_attrs.lz"

; LZSS-compressed: 81 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen6E_5::
    INCBIN "maps/key_worlds/screen6_e_5.lz"

; LZSS-compressed: 84 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen6E_6::
    INCBIN "maps/key_worlds/screen6_e_6.lz"

; LZSS-compressed: 85 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom22_Y1X2_Attrs::
    INCBIN "maps/key_worlds/room22_y1_x2_attrs.lz"

; compressed BG tiles (2048 bytes, 128 tiles): entry 3 of MapType5TilesetTable, decompressed to
; vTiles2 by LoadMapType5TilesetAndHeader
; LZSS-compressed: 916 bytes that expand to 2048 (E-0016, E-0017)
MapType5Tiles3::
    INCBIN "gfx/map_types/5_tiles3.lz"

; entry 3 of MapType5TilesetTable; copied to wBGPaletteBuffer (E-0140, C1)
; record: one CGB palette: 4 BGR555 colours
MapType5Palettes3::
    dw $7da0, $7fff, $7fe0, $0063 ; entry 0
    dw $24c6, $7fd9, $7fe0, $0063 ; entry 1
    dw $7da0, $7f75, $6b40, $0063 ; entry 2
    dw $7da0, $7fd9, $7380, $0063 ; entry 3
    dw $5d8c, $7fd9, $5ab1, $0000 ; entry 4
    dw $7da0, $7fd9, $7fe0, $0000 ; entry 5
    dw $001b, $2bff, $023f, $0000 ; entry 6
    dw $1529, $7fd9, $3631, $0063 ; entry 7

; LZSS-compressed: 128 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom00_Y2X1_Tiles::
    INCBIN "maps/key_worlds/room00_y2_x1_tiles.lz"

; LZSS-compressed: 221 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom07_Y1X0_Tiles::
    INCBIN "maps/key_worlds/room07_y1_x0_tiles.lz"

; LZSS-compressed: 181 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom02_Y1X0_Tiles::
    INCBIN "maps/key_worlds/room02_y1_x0_tiles.lz"

; LZSS-compressed: 224 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom08_Y1X0_Tiles::
    INCBIN "maps/key_worlds/room08_y1_x0_tiles.lz"

; LZSS-compressed: 229 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom08_Y2X0_Tiles::
    INCBIN "maps/key_worlds/room08_y2_x0_tiles.lz"

; LZSS-compressed: 220 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom09_Y1X1_Tiles::
    INCBIN "maps/key_worlds/room09_y1_x1_tiles.lz"

; LZSS-compressed: 230 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom09_Y2X1_Tiles::
    INCBIN "maps/key_worlds/room09_y2_x1_tiles.lz"

KeyWorldRoom0A_Y1X2_Tiles::
    INCBIN "maps/key_worlds/room0_a_y1_x2_tiles.lz"

; tile map, 360 bytes after decompression (20 x 18 tile numbers, one screen, highest tile number
; $55): a key-world cave screen of cyan ice-floor screen with a dark pit at the centre and blue ice
; blocks above it. Decoded and drawn with tileset 3 (MapType5Tiles3 and MapType5Palettes3, the ice
; cave), using the attribute map KeyWorldScreen6E_7 (the entry at the same position in the attribute
; list of the bank) for palettes and flips; the picture is coherent, which supports that tile set.
; No loader reaches it: it is one of the screens stored after that tile set, but no room record of
; KeyWorldRooms holds a far pointer to it (searched the ROM for its 3-byte address and bank pattern:
; no hit, or only a hit in an unrelated table), so LoadMapScreen_Type5 never decompresses it in the
; shipped ROM (C1, E-0383)
; LZSS-compressed: 133 bytes that expand to 360 (E-0016, E-0017)
KeyWorldIceCenterPitTilemap::
    INCBIN "maps/key_worlds/ice_center_pit_tilemap.lz"

; tile map, 360 bytes after decompression (20 x 18 tile numbers, one screen, highest tile number
; $55): a key-world cave screen of cyan ice-floor screen with a dark pit stepping down to the lower
; centre. Decoded and drawn with tileset 3 (MapType5Tiles3 and MapType5Palettes3, the ice cave),
; using the attribute map KeyWorldScreen6E_8 (the entry at the same position in the attribute list
; of the bank) for palettes and flips; the picture is coherent, which supports that tile set. No
; loader reaches it: it is one of the screens stored after that tile set, but no room record of
; KeyWorldRooms holds a far pointer to it (searched the ROM for its 3-byte address and bank pattern:
; no hit, or only a hit in an unrelated table), so LoadMapScreen_Type5 never decompresses it in the
; shipped ROM (C1, E-0383)
; LZSS-compressed: 190 bytes that expand to 360 (E-0016, E-0017)
KeyWorldIceLowerPitTilemap::
    INCBIN "maps/key_worlds/ice_lower_pit_tilemap.lz"

; tile map, 360 bytes after decompression (20 x 18 tile numbers, one screen, highest tile number
; $55): a key-world cave screen of cyan ice-floor screen with a small dark pit under blue ice blocks
; at the upper right. Decoded and drawn with tileset 3 (MapType5Tiles3 and MapType5Palettes3, the
; ice cave), using the attribute map KeyWorldScreen6E_9 (the entry at the same position in the
; attribute list of the bank) for palettes and flips; the picture is coherent, which supports that
; tile set. No loader reaches it: it is one of the screens stored after that tile set, but no room
; record of KeyWorldRooms holds a far pointer to it (searched the ROM for its 3-byte address and
; bank pattern: no hit, or only a hit in an unrelated table), so LoadMapScreen_Type5 never
; decompresses it in the shipped ROM (C1, E-0383)
; LZSS-compressed: 225 bytes that expand to 360 (E-0016, E-0017)
KeyWorldIceUpperRightPitTilemap::
    INCBIN "maps/key_worlds/ice_upper_right_pit_tilemap.lz"

; tile map, 360 bytes after decompression (20 x 18 tile numbers, one screen, highest tile number
; $55): a key-world cave screen of cyan ice-floor screen with a dark pit as a diagonal band from
; lower left to upper right. Decoded and drawn with tileset 3 (MapType5Tiles3 and MapType5Palettes3,
; the ice cave), using the attribute map KeyWorldScreen6E_10 (the entry at the same position in the
; attribute list of the bank) for palettes and flips; the picture is coherent, which supports that
; tile set. No loader reaches it: it is one of the screens stored after that tile set, but no room
; record of KeyWorldRooms holds a far pointer to it (searched the ROM for its 3-byte address and
; bank pattern: no hit, or only a hit in an unrelated table), so LoadMapScreen_Type5 never
; decompresses it in the shipped ROM (C1, E-0383)
; LZSS-compressed: 245 bytes that expand to 360 (E-0016, E-0017)
KeyWorldIceDiagonalPitTilemap::
    INCBIN "maps/key_worlds/ice_diagonal_pit_tilemap.lz"

; tile map, 360 bytes after decompression (20 x 18 tile numbers, one screen, highest tile number
; $55): a key-world cave screen of cyan ice-floor screen with about eight blue crystal clusters
; scattered over the middle. Decoded and drawn with tileset 3 (MapType5Tiles3 and MapType5Palettes3,
; the ice cave), using the attribute map KeyWorldScreen6E_11 (the entry at the same position in the
; attribute list of the bank) for palettes and flips; the picture is coherent, which supports that
; tile set. No loader reaches it: it is one of the screens stored after that tile set, but no room
; record of KeyWorldRooms holds a far pointer to it (searched the ROM for its 3-byte address and
; bank pattern: no hit, or only a hit in an unrelated table), so LoadMapScreen_Type5 never
; decompresses it in the shipped ROM (C1, E-0383)
; LZSS-compressed: 230 bytes that expand to 360 (E-0016, E-0017)
KeyWorldIceScatteredCrystalsTilemap::
    INCBIN "maps/key_worlds/ice_scattered_crystals_tilemap.lz"

; tile map, 360 bytes after decompression (20 x 18 tile numbers, one screen, highest tile number
; $55): a key-world cave screen of cyan ice-floor screen with a column of five blue crystal clusters
; on the right. Decoded and drawn with tileset 3 (MapType5Tiles3 and MapType5Palettes3, the ice
; cave), using the attribute map KeyWorldScreen6E_12 (the entry at the same position in the
; attribute list of the bank) for palettes and flips; the picture is coherent, which supports that
; tile set. No loader reaches it: it is one of the screens stored after that tile set, but no room
; record of KeyWorldRooms holds a far pointer to it (searched the ROM for its 3-byte address and
; bank pattern: no hit, or only a hit in an unrelated table), so LoadMapScreen_Type5 never
; decompresses it in the shipped ROM (C1, E-0383)
; LZSS-compressed: 226 bytes that expand to 360 (E-0016, E-0017)
KeyWorldIceCrystalColumnTilemap::
    INCBIN "maps/key_worlds/ice_crystal_column_tilemap.lz"

; tile map, 360 bytes after decompression (20 x 18 tile numbers, one screen, highest tile number
; $55): a key-world cave screen of cyan ice-floor screen with about ten blue crystal clusters in
; groups of two and three. Decoded and drawn with tileset 3 (MapType5Tiles3 and MapType5Palettes3,
; the ice cave), using the attribute map KeyWorldScreen6E_13 (the entry at the same position in the
; attribute list of the bank) for palettes and flips; the picture is coherent, which supports that
; tile set. No loader reaches it: it is one of the screens stored after that tile set, but no room
; record of KeyWorldRooms holds a far pointer to it (searched the ROM for its 3-byte address and
; bank pattern: no hit, or only a hit in an unrelated table), so LoadMapScreen_Type5 never
; decompresses it in the shipped ROM (C1, E-0383)
KeyWorldIceCrystalClustersTilemap::
    INCBIN "maps/key_worlds/ice_crystal_clusters_tilemap.lz"

; tile map, 360 bytes after decompression (20 x 18 tile numbers, one screen, highest tile number
; $55): a key-world cave screen of cyan ice-floor screen with six blue crystal clusters in pairs.
; Decoded and drawn with tileset 3 (MapType5Tiles3 and MapType5Palettes3, the ice cave), using the
; attribute map KeyWorldScreen6E_14 (the entry at the same position in the attribute list of the
; bank) for palettes and flips; the picture is coherent, which supports that tile set. No loader
; reaches it: it is one of the screens stored after that tile set, but no room record of
; KeyWorldRooms holds a far pointer to it (searched the ROM for its 3-byte address and bank pattern:
; no hit, or only a hit in an unrelated table), so LoadMapScreen_Type5 never decompresses it in the
; shipped ROM (C1, E-0383)
; LZSS-compressed: 231 bytes that expand to 360 (E-0016, E-0017)
KeyWorldIceCrystalPairsTilemap::
    INCBIN "maps/key_worlds/ice_crystal_pairs_tilemap.lz"

; LZSS-compressed: 53 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom00_Y2X1_Attrs::
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0f, $4d, $00, $24, $0c, $03, $03, $03, $03, $00, $1c, $08, $00, $80, $0f, $01
    db $00, $7e, $04, $00, $9c, $0f, $13, $00, $d2, $02, $00, $c8, $0f, $09, $00, $1c
    db $0f, $4d, $00, $08, $1c

; LZSS-compressed: 74 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom07_Y1X0_Attrs::
    INCBIN "maps/key_worlds/room07_y1_x0_attrs.lz"

; LZSS-compressed: 63 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom02_Y1X0_Attrs::
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0f, $35, $01, $01, $03, $03, $00, $4c, $0f, $0d, $00, $04, $02, $03, $03, $00
    db $08, $0c, $00, $84, $0f, $03, $00, $58, $02, $00, $a0, $0f, $31, $00, $5a, $02
    db $00, $9e, $0e, $00, $fc, $0f, $01, $00, $9c, $0f, $15, $00, $0c, $0f, $09

; LZSS-compressed: 75 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom08_Y1X0_Attrs::
    INCBIN "maps/key_worlds/room08_y1_x0_attrs.lz"

; LZSS-compressed: 84 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom08_Y2X0_Attrs::
    INCBIN "maps/key_worlds/room08_y2_x0_attrs.lz"

; LZSS-compressed: 73 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom09_Y1X1_Attrs::
    INCBIN "maps/key_worlds/room09_y1_x1_attrs.lz"

; LZSS-compressed: 82 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom09_Y2X1_Attrs::
    INCBIN "maps/key_worlds/room09_y2_x1_attrs.lz"

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0A_Y1X2_Attrs::
    INCBIN "maps/key_worlds/room0_a_y1_x2_attrs.lz"

; LZSS-compressed: 66 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen6E_7::
    INCBIN "maps/key_worlds/screen6_e_7.lz"

; LZSS-compressed: 69 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen6E_8::
    INCBIN "maps/key_worlds/screen6_e_8.lz"

; LZSS-compressed: 86 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen6E_9::
    INCBIN "maps/key_worlds/screen6_e_9.lz"

; LZSS-compressed: 108 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen6E_10::
    INCBIN "maps/key_worlds/screen6_e_10.lz"

; LZSS-compressed: 92 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen6E_11::
    INCBIN "maps/key_worlds/screen6_e_11.lz"

; LZSS-compressed: 91 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen6E_12::
    INCBIN "maps/key_worlds/screen6_e_12.lz"

; LZSS-compressed: 94 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen6E_13::
    INCBIN "maps/key_worlds/screen6_e_13.lz"

; LZSS-compressed: 96 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen6E_14::
    INCBIN "maps/key_worlds/screen6_e_14.lz"

; compressed BG tiles (2048 bytes, 128 tiles): entry 4 of MapType5TilesetTable, decompressed to
; vTiles2 by LoadMapType5TilesetAndHeader
; LZSS-compressed: 1071 bytes that expand to 2048 (E-0016, E-0017)
MapType5Tiles4::
    INCBIN "gfx/map_types/5_tiles4.lz"

; entry 4 of MapType5TilesetTable; copied to wBGPaletteBuffer (E-0140, C1)
; record: one CGB palette: 4 BGR555 colours
MapType5Palettes4::
    dw $000f, $7fff, $3c1f, $0063 ; entry 0
    dw $150b, $269f, $0157, $0044 ; entry 1
    dw $000f, $269f, $0157, $0044 ; entry 2
    dw $00cc, $269f, $01d5, $0044 ; entry 3
    dw $5d8c, $269f, $5ab1, $0000 ; entry 4
    dw $218c, $269f, $029a, $0000 ; entry 5
    dw $001b, $2bff, $023f, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; LZSS-compressed: 130 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom01_Y1X2_Tiles::
    INCBIN "maps/key_worlds/room01_y1_x2_tiles.lz"

; LZSS-compressed: 213 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0B_Y1X1_Tiles::
    INCBIN "maps/key_worlds/room0_b_y1_x1_tiles.lz"

; LZSS-compressed: 230 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom01_Y2X3_Tiles::
    INCBIN "maps/key_worlds/room01_y2_x3_tiles.lz"

; LZSS-compressed: 214 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom02_Y2X3_Tiles::
    INCBIN "maps/key_worlds/room02_y2_x3_tiles.lz"

; LZSS-compressed: 218 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom04_Y1X3_Tiles::
    INCBIN "maps/key_worlds/room04_y1_x3_tiles.lz"

; LZSS-compressed: 228 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0A_Y1X1_Tiles::
    INCBIN "maps/key_worlds/room0_a_y1_x1_tiles.lz"

; LZSS-compressed: 215 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0A_Y1X3_Tiles::
    INCBIN "maps/key_worlds/room0_a_y1_x3_tiles.lz"

; LZSS-compressed: 201 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0A_Y2X1_Tiles::
    INCBIN "maps/key_worlds/room0_a_y2_x1_tiles.lz"

; Tile map, 360 bytes (20 x 18 tile numbers, tile ids $02-$55) of one key-world floor screen. It has
; the shape of the records LoadMapScreen_Type5 decompresses into wScreenTileBuffer (the far pointers
; in KeyWorldRooms), but none of the 336 distinct stream pointers in the 160 KeyWorldRooms records
; points at it, and no other pointer to it exists in the ROM, so no loader reaches it; its use as a
; screen is from its shape only. It sits in the run of tile maps of bank $6E and its attribute map
; is the stream in the same position of the next run, KeyWorldScreen6E_15. Rendered with the paired
; attributes and a MapType5 tile set (tile set 4 shown; the real set depends on the floor): a
; horizontal passage on the left meeting a vertical passage right of centre, with a dark L-shaped
; patch between them. The numbering is shared with the listed key-world screens, so the tile set
; cannot be fixed from this stream. (C1, E-0383)
; LZSS-compressed: 162 bytes that expand to 360 (E-0016, E-0017)
KeyWorldUnlistedScreen6E_A_Tilemap::
    INCBIN "maps/key_worlds/unlisted_screen6_e_a_tilemap.lz"

; Tile map, 360 bytes (20 x 18 tile numbers, tile ids $00-$55) of one key-world floor screen. It has
; the shape of the records LoadMapScreen_Type5 decompresses into wScreenTileBuffer (the far pointers
; in KeyWorldRooms), but none of the 336 distinct stream pointers in the 160 KeyWorldRooms records
; points at it, and no other pointer to it exists in the ROM, so no loader reaches it; its use as a
; screen is from its shape only. It sits in the run of tile maps of bank $6E and its attribute map
; is the stream in the same position of the next run, KeyWorldScreen6E_16. Rendered with the paired
; attributes and a MapType5 tile set (tile set 4 shown; the real set depends on the floor): an open
; area at left with a small boulder-like object low in the middle and a dark strip beside it. The
; numbering is shared with the listed key-world screens, so the tile set cannot be fixed from this
; stream. (C1, E-0383)
; LZSS-compressed: 197 bytes that expand to 360 (E-0016, E-0017)
KeyWorldUnlistedScreen6E_B_Tilemap::
    INCBIN "maps/key_worlds/unlisted_screen6_e_b_tilemap.lz"

; Tile map, 360 bytes (20 x 18 tile numbers, tile ids $00-$55) of one key-world floor screen. It has
; the shape of the records LoadMapScreen_Type5 decompresses into wScreenTileBuffer (the far pointers
; in KeyWorldRooms), but none of the 336 distinct stream pointers in the 160 KeyWorldRooms records
; points at it, and no other pointer to it exists in the ROM, so no loader reaches it; its use as a
; screen is from its shape only. It sits in the run of tile maps of bank $6E and its attribute map
; is the stream in the same position of the next run, KeyWorldScreen6E_17. Rendered with the paired
; attributes and a MapType5 tile set (tile set 4 shown; the real set depends on the floor): a
; diagonal passage running lower-left to upper-right with a dark patch in the middle. The numbering
; is shared with the listed key-world screens, so the tile set cannot be fixed from this stream.
; (C1, E-0383)
; LZSS-compressed: 240 bytes that expand to 360 (E-0016, E-0017)
KeyWorldUnlistedScreen6E_C_Tilemap::
    INCBIN "maps/key_worlds/unlisted_screen6_e_c_tilemap.lz"

; Tile map, 360 bytes (20 x 18 tile numbers, tile ids $00-$55) of one key-world floor screen. It has
; the shape of the records LoadMapScreen_Type5 decompresses into wScreenTileBuffer (the far pointers
; in KeyWorldRooms), but none of the 336 distinct stream pointers in the 160 KeyWorldRooms records
; points at it, and no other pointer to it exists in the ROM, so no loader reaches it; its use as a
; screen is from its shape only. It sits in the run of tile maps of bank $6E and its attribute map
; is the stream in the same position of the next run, KeyWorldScreen6E_18. Rendered with the paired
; attributes and a MapType5 tile set (tile set 4 shown; the real set depends on the floor): a rock
; wall cutting diagonally down the right side and a dark diagonal patch left of centre. The
; numbering is shared with the listed key-world screens, so the tile set cannot be fixed from this
; stream. (C1, E-0383)
; LZSS-compressed: 231 bytes that expand to 360 (E-0016, E-0017)
KeyWorldUnlistedScreen6E_D_Tilemap::
    INCBIN "maps/key_worlds/unlisted_screen6_e_d_tilemap.lz"

; LZSS-compressed: 184 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom22_Y2X1_Tiles::
    INCBIN "maps/key_worlds/room22_y2_x1_tiles.lz"

; LZSS-compressed: 205 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom4C_Y1X3_Tiles::
    INCBIN "maps/key_worlds/room4_c_y1_x3_tiles.lz"

; Tile map, 360 bytes (20 x 18 tile numbers, tile ids $00-$55) of one key-world floor screen. It has
; the shape of the records LoadMapScreen_Type5 decompresses into wScreenTileBuffer (the far pointers
; in KeyWorldRooms), but none of the 336 distinct stream pointers in the 160 KeyWorldRooms records
; points at it, and no other pointer to it exists in the ROM, so no loader reaches it; its use as a
; screen is from its shape only. It sits in the run of tile maps of bank $6E and its attribute map
; is the stream in the same position of the next run, KeyWorldScreen6E_19. Rendered with the paired
; attributes and a MapType5 tile set (tile set 4 shown; the real set depends on the floor): an open
; cave floor with two small boulder-like objects at the upper right. The numbering is shared with
; the listed key-world screens, so the tile set cannot be fixed from this stream. (C1, E-0383)
; LZSS-compressed: 236 bytes that expand to 360 (E-0016, E-0017)
KeyWorldUnlistedScreen6E_E_Tilemap::
    INCBIN "maps/key_worlds/unlisted_screen6_e_e_tilemap.lz"

; LZSS-compressed: 229 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom4B_Y1X2_Tiles::
    INCBIN "maps/key_worlds/room4_b_y1_x2_tiles.lz"

; LZSS-compressed: 57 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom01_Y1X2_Attrs::
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0f, $33, $03, $03, $00, $48, $0f, $09, $00, $08, $00, $00, $78, $02, $00, $6e
    db $0f, $11, $00, $6a, $0f, $01, $00, $6a, $0e, $00, $68, $0f, $01, $00, $54, $0f
    db $07, $00, $0a, $0f, $3d, $00, $0a, $0f, $0b

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0B_Y1X1_Attrs::
    INCBIN "maps/key_worlds/room0_b_y1_x1_attrs.lz"

; LZSS-compressed: 77 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom01_Y2X3_Attrs::
    INCBIN "maps/key_worlds/room01_y2_x3_attrs.lz"

; LZSS-compressed: 90 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom02_Y2X3_Attrs::
    INCBIN "maps/key_worlds/room02_y2_x3_attrs.lz"

; LZSS-compressed: 78 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom04_Y1X3_Attrs::
    INCBIN "maps/key_worlds/room04_y1_x3_attrs.lz"

; LZSS-compressed: 83 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0A_Y1X1_Attrs::
    INCBIN "maps/key_worlds/room0_a_y1_x1_attrs.lz"

; LZSS-compressed: 79 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0A_Y1X3_Attrs::
    INCBIN "maps/key_worlds/room0_a_y1_x3_attrs.lz"

; LZSS-compressed: 73 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0A_Y2X1_Attrs::
    INCBIN "maps/key_worlds/room0_a_y2_x1_attrs.lz"

; LZSS-compressed: 82 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen6E_15::
    INCBIN "maps/key_worlds/screen6_e_15.lz"

; LZSS-compressed: 91 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen6E_16::
    INCBIN "maps/key_worlds/screen6_e_16.lz"

; LZSS-compressed: 93 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen6E_17::
    INCBIN "maps/key_worlds/screen6_e_17.lz"

; LZSS-compressed: 92 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen6E_18::
    INCBIN "maps/key_worlds/screen6_e_18.lz"

; LZSS-compressed: 70 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom22_Y2X1_Attrs::
    INCBIN "maps/key_worlds/room22_y2_x1_attrs.lz"

; LZSS-compressed: 77 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom4C_Y1X3_Attrs::
    INCBIN "maps/key_worlds/room4_c_y1_x3_attrs.lz"

; LZSS-compressed: 78 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen6E_19::
    INCBIN "maps/key_worlds/screen6_e_19.lz"

; LZSS-compressed: 100 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom4B_Y1X2_Attrs::
    INCBIN "maps/key_worlds/room4_b_y1_x2_attrs.lz"

; compressed BG tiles (2048 bytes, 128 tiles): entry 5 of MapType5TilesetTable, decompressed to
; vTiles2 by LoadMapType5TilesetAndHeader
; LZSS-compressed: 764 bytes that expand to 2048 (E-0016, E-0017)
MapType5Tiles5::
    INCBIN "gfx/map_types/5_tiles5.lz"

; entry 5 of MapType5TilesetTable; copied to wBGPaletteBuffer (E-0140, C1)
; record: one CGB palette: 4 BGR555 colours
MapType5Palettes5::
    dw $7da0, $7fff, $7fe0, $0063 ; entry 0
    dw $150b, $5f17, $15ae, $0044 ; entry 1
    dw $1528, $5f17, $15ae, $0000 ; entry 2
    dw $218c, $5f17, $15ae, $0044 ; entry 3
    dw $5d8c, $5f17, $5ab1, $0000 ; entry 4
    dw $218c, $5f17, $029a, $0000 ; entry 5
    dw $001b, $2bff, $023f, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7
    ds $7e0, $00
