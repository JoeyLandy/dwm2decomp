; ROM bank $E1: screen graphics, tiles and palettes
; The annotated listing of this bank is build/listing/banke1.asm.

SECTION "Bank E1", ROMX[$4000], BANK[$E1]
    db $e1

; Tiles, 304 bytes decompressed (19 tiles). Decompressed to vTiles2 by
; GameMode5_Update_LoadScreens_Screen0_Load (intro screen 0), with IntroScreen0TileMap as its
; screen. Render: the letters of the words LICENSED BY NINTENDO, one letter per tile, in a plain 8x8
; capital font; the tile map spells the line across the middle of the screen. (C1, E-0383)
; LZSS-compressed: 213 bytes that expand to 304 (E-0016, E-0017)
LicensedByNintendoTiles::
    INCBIN "gfx/misc/licensed_by_nintendo_tiles.lz"

; LZSS-compressed (37 inline bytes) 20 x 18 tile map that expands to 360 bytes.
; GameMode5_Update_LoadScreens_Screen0_Load (intro screen 0, wTitleScreenState = 0) decompresses it
; to wScreenTileBuffer with DecompressToRAMLocked after LicensedByNintendoTiles goes to vTiles2, and
; draws it with DrawFullScreenBufferToBGMap. (C1, E-0373)
; LZSS-compressed: 37 bytes that expand to 360 (E-0016, E-0017)
IntroScreen0TileMap::
    db $68, $01, $13, $13, $a0, $ff, $4d, $13, $41, $0f, $2e, $01, $02, $03, $04, $05
    db $06, $07, $08, $09, $0a, $0b, $0c, $0d, $0e, $0f, $10, $11, $12, $13, $41, $0f
    db $4d, $13, $12, $1f, $42

; LZSS-compressed (19 bytes) CGB attribute map that expands to 360 bytes, one attribute byte per
; tile of IntroScreen0TileMap. On CGB only, GameMode5_Update_LoadScreens_Screen0_Load decompresses
; it to wScreenAttrBuffer with WRAM bank 2 selected (rSVBK = 2). (C1, E-0373)
; LZSS-compressed: 19 bytes that expand to 360 (E-0016, E-0017)
IntroScreen0AttrMap::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $5f, $0f, $4d, $01, $bf, $0f, $4d, $01
    db $1f, $1f, $35

; One CGB BG palette, four BGR555 colours (8 bytes): $56B5, $7FFF, $56D7, $0000. On CGB,
; GameMode5_Update_LoadScreens_Screen0_Load copies it to wBGPaletteBuffer (palette 0) with
; CopyFromBankWaitVRAM, C = 8. (C1, E-0373)
IntroScreen0Palette::
    db $b5, $56, $ff, $7f, $d7, $56, $00, $00

; Tiles, 1600 bytes decompressed (100 tiles). Decompressed to vTiles2 by
; GameMode5_Update_LoadScreens_Screen1_Load (intro screen 1), with IntroScreen1TileMap as its
; screen. Render: a 2001 copyright credit screen in a bold teal outlined font: the copyright sign
; and 2001 with ARMOR PROJECT, BIRD STUDIO, KOICHI SUGIYAMA, CHUN SOFT and ENIX, one per line, drawn
; from these tiles. (C1, E-0383)
; LZSS-compressed: 1169 bytes that expand to 1600 (E-0016, E-0017)
CopyrightCreditsTiles::
    INCBIN "gfx/misc/copyright_credits_tiles.lz"

; LZSS-compressed (85 bytes, an asset file) 20 x 18 tile map that expands to 360 bytes.
; GameMode5_Update_LoadScreens_Screen1_Load (intro screen 1, wTitleScreenState = 1) decompresses it
; to wScreenTileBuffer with DecompressToRAMLocked after CopyrightCreditsTiles goes to vTiles2, and
; draws it with DrawFullScreenBufferToBGMap. (C1, E-0373)
; LZSS-compressed: 85 bytes that expand to 360 (E-0016, E-0017)
IntroScreen1TileMap::
    INCBIN "gfx/misc/intro_screen1_tile_map.lz"

; LZSS-compressed (19 bytes, the same bytes as IntroScreen0AttrMap) CGB attribute map that expands
; to 360 bytes, one attribute byte per tile of IntroScreen1TileMap. On CGB only,
; GameMode5_Update_LoadScreens_Screen1_Load decompresses it to wScreenAttrBuffer with WRAM bank 2
; selected (rSVBK = 2). (C1, E-0373)
; LZSS-compressed: 19 bytes that expand to 360 (E-0016, E-0017)
IntroScreen1AttrMap::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $5f, $0f, $4d, $01, $bf, $0f, $4d, $01
    db $1f, $1f, $35

; One CGB BG palette, four BGR555 colours (8 bytes): $3160, $56B5, $62E8, $0000. On CGB,
; GameMode5_Update_LoadScreens_Screen1_Load copies it to wBGPaletteBuffer (palette 0) with
; CopyFromBankWaitVRAM, C = 8. (C1, E-0373)
IntroScreen1Palette::
    db $60, $31, $b5, $56, $e8, $62, $00, $00

; Tiles, 1552 bytes decompressed (97 tiles). Decompressed to vTiles2 by
; GameMode5_Update_LoadScreens_Screen2_Load (intro screen 2), with IntroScreen2TileMap as its
; screen. Render: the Enix swoosh logo as large light shapes, the word ENIX with a registered mark
; under it, and the script text enix presents across the middle, drawn from these tiles. (C1,
; E-0383)
; LZSS-compressed: 815 bytes that expand to 1552 (E-0016, E-0017)
EnixPresentsLogoTiles::
    INCBIN "gfx/misc/enix_presents_logo_tiles.lz"

; LZSS-compressed (120 bytes, an asset file) 20 x 18 tile map that expands to 360 bytes.
; GameMode5_Update_LoadScreens_Screen2_Load (intro screen 2, wTitleScreenState = 2) decompresses it
; to wScreenTileBuffer with DecompressToRAMLocked after EnixPresentsLogoTiles goes to vTiles2, and
; draws it with DrawFullScreenBufferToBGMap. (C1, E-0373)
; LZSS-compressed: 120 bytes that expand to 360 (E-0016, E-0017)
IntroScreen2TileMap::
    INCBIN "gfx/misc/intro_screen2_tile_map.lz"

; LZSS-compressed (20 bytes) CGB attribute map that expands to 360 bytes, one attribute byte per
; tile of IntroScreen2TileMap. On CGB only, GameMode5_Update_LoadScreens_Screen2_Load decompresses
; it to wScreenAttrBuffer with WRAM bank 2 selected (rSVBK = 2). (C1, E-0373)
; LZSS-compressed: 20 bytes that expand to 360 (E-0016, E-0017)
IntroScreen2AttrMap::
    db $68, $01, $00, $08, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $08, $1f, $34

; One CGB BG palette, four BGR555 colours (8 bytes): $3E0F, $73BF, $56D7, $0000. On CGB,
; GameMode5_Update_LoadScreens_Screen2_Load copies it to wBGPaletteBuffer (palette 0) with
; CopyFromBankWaitVRAM, C = 8. (C1, E-0373)
IntroScreen2Palette::
    db $0f, $3e, $bf, $73, $d7, $56, $00, $00

; Tiles, 2048 bytes decompressed (128 tiles). Decompressed to vTiles1 (tile numbers $80-$FF) by
; TitleOpening_LoadTitle (opening title, with TitleLogoTiles and TitleOpeningKeyBGMap) and by
; GameMode5_Update_LoadScreens_ScreenWithMusic_Load (title screen with music). Render: the big
; golden key in pieces (round bow with holes, shaft, teeth) and a banner row of text reading TARAS
; ADVENTURE. The title maps drawn here use the key pieces; the TARAS ADVENTURE banner row is not
; placed by them (the US title shows the COBI JOURNEY subtitle from Tiles2Gfx_7), so it looks like a
; leftover from the sibling release. (C1, E-0383)
; LZSS-compressed: 1165 bytes that expand to 2048 (E-0016, E-0017)
TitleKeyAndTarasAdventureTiles::
    INCBIN "gfx/misc/title_key_and_taras_adventure_tiles.lz"

; Tiles, 2048 bytes decompressed (128 tiles). Decompressed to vTiles2 (tile numbers $00-$7F) by
; TitleOpening_LoadTitle and by GameMode5_Update_LoadScreens_ScreenWithMusic_Load. Render: the title
; logo, DRAGON WARRIOR in big brown letters with an orange gradient, the MONSTERS pill banner with a
; large 2, the COBI JOURNEY subtitle, the registered mark, and the top of the key; drawn with
; TitleKeyAndTarasAdventureTiles it makes the whole title screen. (C1, E-0383)
; LZSS-compressed: 1438 bytes that expand to 2048 (E-0016, E-0017)
TitleLogoTiles::
    INCBIN "gfx/misc/title_logo_tiles.lz"

; Tiles, 1152 bytes decompressed (72 tiles). Decompressed to vTiles2 by TitleOpening_LoadNextScreen
; (the screen after the title opening fades), with DragonWarriorLogoTilemap as the screen. Render:
; the plain DRAGON WARRIOR wordmark, brown letters with a purple outline and a registered mark, on
; its own, without the MONSTERS banner. (C1, E-0383)
; LZSS-compressed: 887 bytes that expand to 1152 (E-0016, E-0017)
DragonWarriorLogoTiles::
    INCBIN "gfx/misc/dragon_warrior_logo_tiles.lz"

; Tiles, 256 bytes decompressed (16 tiles). Decompressed to vTiles0 (object tile area, tiles 0-15)
; by GameMode5_Update_LoadScreens_ScreenWithMusic_Load, the title screen with music, which also
; loads TitleKeyAndTarasAdventureTiles and TitleLogoTiles. Render: scattered thin grey diagonal
; strokes, short dashes and dots plus one small plus-shaped tile; no letters. Not identified: the
; shapes read as glint or spark fragments but nothing in the loader says which object draws them
; (the sparkle meta-sprites of TitleOpening_MoveSparkles use tile offset $10, so tiles 0-15 are not
; those), and that title state draws no sprite by itself. (C1, E-0383)
; LZSS-compressed: 175 bytes that expand to 256 (E-0016, E-0017)
Tiles0Gfx_4::
    INCBIN "gfx/misc/tiles0_gfx_4.lz"

; Tile map, 360 bytes decompressed (20 x 18). GameMode5_Update_LoadScreens_ScreenWithMusic_Load
; decompresses it into wScreenTileBuffer (with the attribute map TitleScreenAttrMap into
; wScreenAttrBuffer on CGB) and draws it to vBGMap0 with DrawFullScreenBufferToBGMap; it indexes
; TitleLogoTiles (tiles $00-$7F) and TitleKeyAndTarasAdventureTiles (tiles $80-$FF). Rendered: the
; full title screen, the DRAGON WARRIOR MONSTERS 2 COBI JOURNEY logo with the golden key above it,
; on white. (C1, E-0383)
; LZSS-compressed: 152 bytes that expand to 360 (E-0016, E-0017)
TitleScreenTilemap::
    INCBIN "gfx/misc/title_screen_tilemap.lz"

; Attribute map, 360 bytes decompressed (20 x 18, one byte per cell of TitleScreenTilemap, palette
; numbers in the low bits). GameMode5_Update_LoadScreens_ScreenWithMusic_Load decompresses it into
; wScreenAttrBuffer (WRAM bank 2) on CGB only, then copies the 8 BG palettes of
; TitleOpening_LoadTitle_BGPaletteBufferData. It colours the title logo: orange, brown and purple
; letters, gold key. (C1, E-0383)
; LZSS-compressed: 76 bytes that expand to 360 (E-0016, E-0017)
TitleScreenAttrMap::
    INCBIN "gfx/misc/title_screen_attr_map.lz"

; Tile map, 360 bytes decompressed (20 x 18). TitleOpening_LoadNextScreen decompresses it into
; wScreenTileBuffer after loading DragonWarriorLogoTiles to vTiles2 (attributes
; TitleOpening_LoadNextScreen_ScreenAttrBufferGfx, palette
; TitleOpening_LoadNextScreen_BGPaletteBufferData) and draws it to vBGMap0. Rendered with
; DragonWarriorLogoTiles: the DRAGON WARRIOR wordmark across the middle of a white screen. (C1,
; E-0383)
; LZSS-compressed: 101 bytes that expand to 360 (E-0016, E-0017)
DragonWarriorLogoTilemap::
    INCBIN "gfx/misc/dragon_warrior_logo_tilemap.lz"

; LZSS-compressed: 19 bytes that expand to 360 (E-0016, E-0017)
TitleOpening_LoadNextScreen_ScreenAttrBufferGfx::
    db $68, $01, $01, $01, $a0, $ff, $4d, $01, $5f, $0f, $4d, $01, $bf, $0f, $4d, $01
    db $1f, $1f, $35

; Tile map, 1024 bytes decompressed (a full 32 x 32 background map). TitleOpening_LoadTitle
; decompresses it straight to vBGMap0, with BGMap0Gfx (the 1024-byte attribute map) to the same map
; in VRAM bank 1 on CGB, after TitleKeyAndTarasAdventureTiles goes to vTiles1 and TitleLogoTiles to
; vTiles2. Rendered with those tiles: the golden key leaning diagonally in the top left of the map,
; the rest a plain dark brown field; the screen then scrolls (hScrollY) while sparkles fall. (C1,
; E-0383)
; LZSS-compressed: 112 bytes that expand to 1024 (E-0016, E-0017)
TitleOpeningKeyBGMap::
    INCBIN "gfx/misc/title_opening_key_bgmap.lz"

; LZSS-compressed: 48 bytes that expand to 1024 (E-0016, E-0017)
BGMap0Gfx::
    db $00, $04, $00, $03, $00, $00, $0f, $4d, $00, $60, $0f, $4d, $00, $c0, $0f, $4d
    db $00, $20, $1f, $4d, $00, $80, $1f, $4d, $00, $e0, $1f, $4d, $00, $40, $2f, $4d
    db $00, $a0, $2f, $4d, $00, $00, $3f, $4d, $00, $60, $3f, $4d, $00, $a0, $3f, $2c

TitleOpening_LoadTitle_BGPaletteBufferData::
    db $0f, $54, $ff, $7f, $1f, $13, $aa, $04, $0f, $54, $ff, $7f, $1f, $13, $d5, $09
    db $33, $05, $ff, $03, $bd, $21, $aa, $04, $33, $05, $ff, $7f, $1f, $13, $aa, $04
    db $33, $05, $ff, $7f, $bd, $21, $aa, $04, $36, $04, $ff, $7f, $1f, $13, $aa, $04
    db $36, $04, $ff, $7f, $1f, $13, $d5, $09, $ff, $7f, $ff, $7f, $ff, $7f, $ff, $7f

TitleOpening_LoadNextScreen_BGPaletteBufferData::
    db $0f, $54, $ff, $7f, $1f, $13, $aa, $04, $0f, $54, $ff, $7f, $1f, $13, $d5, $09
    db $33, $05, $ff, $03, $bd, $21, $aa, $04, $33, $05, $ff, $7f, $1f, $13, $aa, $04
    db $33, $05, $ff, $7f, $bd, $21, $aa, $04, $36, $04, $ff, $7f, $1f, $13, $aa, $04
    db $36, $04, $ff, $7f, $1f, $13, $d5, $09, $ff, $7f, $ff, $7f, $ff, $7f, $ff, $7f

GameMode5_Update_LoadScreens_OBJPaletteBufferData::
    db $20, $7c, $ff, $7f, $a8, $14, $00, $00, $20, $7c, $ff, $7f, $35, $04, $00, $00

; Draws one meta-sprite: loads DE with DrawMetaSpriteSet_BankE1_Data (a table of one pointer, to
; UnreferencedMetaSpriteSet_E1) and calls DrawMetaSpriteSet_BankE1_BuildOam, which writes the OAM
; entries for set hSpriteSetIndex, frame hSpriteSubIndex, at the origin hSpriteOriginX /
; hSpriteOriginY. Its only caller is the far call in DrawCGBMetaSpriteAt38_30 (bank $07), which sets
; set 0, frame 0 at X $38, Y $30 and which nothing in src reaches. (C1, E-0385)
; runs DrawMetaSpriteSet_BankE1_BuildOam with DE = DrawMetaSpriteSet_BankE1_Data (E-0122) (E-0344:
; the address in its name dropped or read as the label there; was DrawMetaSpriteSet_BankE1; a
; trailing preposition left by the dropped address removed)
DrawMetaSpriteSet_BankE1::
    ld de, DrawMetaSpriteSet_BankE1_Data
    call DrawMetaSpriteSet_BankE1_BuildOam
    ret

; One word, $5D3C: the address in bank $E1 of UnreferencedMetaSpriteSet_E1, which
; DrawMetaSpriteSet_BankE1 passes in DE to DrawMetaSpriteSet_BankE1_BuildOam as the table of
; meta-sprite sets (a table of one set pointer; the set holds two frame pointers). (C1, E-0381)
DrawMetaSpriteSet_BankE1_Data::
    db $3c, $5d

; Builds the meta-sprite into OAM; the same code as DrawMetaSpriteSet_Bank27_BuildOam with this
; bank's frames. (C1, E-0357)
DrawMetaSpriteSet_BankE1_BuildOam::
    ldh a, [hOamNextEntry]
    cp $27
    ret nc
    ldh a, [hSpriteScrollYLo]
    ld c, a
    ldh a, [hSpriteScrollYHi]
    ld b, a
    ldh a, [hSpriteOriginY]
    add c
    ldh [hMetaSpriteYLo], a
    ldh a, [hSpriteOriginYHi]
    adc b
    ldh [hMetaSpriteYHi], a
    ldh a, [hSpriteScrollXLo]
    ld c, a
    ldh a, [hSpriteScrollXHi]
    ld b, a
    ld hl, hMetaSpriteXLo
    ldh a, [hSpriteOriginX]
    add c
    ld c, a
    ld [hli], a
    ldh a, [hSpriteOriginXHi]
    adc b
    ld b, a
    ld [hli], a
    ld a, c
    sub $08
    ld [hli], a
    ld a, b
    sbc $00
    ld [hl], a
    ldh a, [hSpriteSetIndex]
    add a
    add e
    ld l, a
    ld a, $00
    adc d
    ld h, a
    ld a, [hli]
    ld d, [hl]
    ld e, a
    ldh a, [hSpriteSubIndex]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, de
    deref_hl
    ldh a, [hOamNextEntry]
    add a
    add a
    ld e, a
    ld d, $c0
    ldh a, [hSpriteWindowClipMode]
    or a
    jp nz, .check_sprite_attr_xor
    ldh a, [hSpriteTileOffset]
    ld c, a
    ldh a, [hSpriteAttrXor]
    and $20
    jr nz, .loop2

.loop:
    ld a, [hli]
    cp $80
    ret z
    ld b, a
    jr nc, .read_meta_sprite_y_lo
    ldh a, [hMetaSpriteYLo]
    add b
    ld b, a
    ldh a, [hMetaSpriteYHi]
    adc $00
    jr nz, .next
    ld a, b
    cp $a8
    jr c, .skip
    jr .next

.read_meta_sprite_y_lo:
    ldh a, [hMetaSpriteYLo]
    add b
    ld b, a
    ldh a, [hMetaSpriteYHi]
    adc $ff
    jr nz, .next
    ld a, b
    cp $a8
    jr c, .skip

.next:
    inc hl
    inc hl
    inc hl
    jr .loop

.skip:
    ld a, b
    ld [de], a
    inc e
    ld a, [hli]
    ld b, a
    rlca
    jr c, .read_meta_sprite_x_lo
    ldh a, [hMetaSpriteXLo]
    add b
    ld b, a
    ldh a, [hMetaSpriteXHi]
    adc $00
    jr nz, .next2
    ld a, b
    cp $b8
    jr c, .skip2
    jr .next2

.read_meta_sprite_x_lo:
    ldh a, [hMetaSpriteXLo]
    add b
    ld b, a
    ldh a, [hMetaSpriteXHi]
    adc $ff
    jr nz, .next2
    ld a, b
    cp $b8
    jr c, .skip2

.next2:
    inc hl
    inc hl
    dec e
    xor a
    ld [de], a
    jr .loop

.skip2:
    ld a, b
    ld [de], a
    inc e
    ldh a, [hSpriteTileOffset]
    ld c, a
    ld a, [hli]
    add c
    ld [de], a
    inc e
    ldh a, [hSpriteAttrXor]
    ld c, a
    ld a, [hli]
    xor c
    ld [de], a
    inc e
    ldh a, [hOamNextEntry]
    inc a
    ldh [hOamNextEntry], a
    cp $28
    jr nz, .loop
    ret

.loop2:
    ld a, [hli]
    cp $80
    ret z
    ld b, a
    jr nc, .read_meta_sprite_y_lo2
    ldh a, [hMetaSpriteYLo]
    add b
    ld b, a
    ldh a, [hMetaSpriteYHi]
    adc $00
    jr nz, .next3
    ld a, b
    cp $a8
    jr c, .skip3
    jr .next3

.read_meta_sprite_y_lo2:
    ldh a, [hMetaSpriteYLo]
    add b
    ld b, a
    ldh a, [hMetaSpriteYHi]
    adc $ff
    jr nz, .next3
    ld a, b
    cp $a8
    jr c, .skip3

.next3:
    inc hl
    inc hl
    inc hl
    jr .loop2

.skip3:
    ld a, b
    ld [de], a
    inc e
    ld a, [hli]
    ld b, a
    rlca
    jr c, .read_meta_sprite_x_flip_lo
    ldh a, [hMetaSpriteXFlipLo]
    sub b
    ld b, a
    ldh a, [hMetaSpriteXFlipHi]
    sbc $00
    jr z, .skip4
    jr nz, .next4
    ld a, b
    cp $b8
    jr c, .skip4
    jr .next4

.read_meta_sprite_x_flip_lo:
    ldh a, [hMetaSpriteXFlipLo]
    sub b
    ld b, a
    ldh a, [hMetaSpriteXFlipHi]
    sbc $ff
    jr nz, .next4
    ld a, b
    cp $b8
    jr c, .skip4

.next4:
    inc hl
    inc hl
    dec e
    xor a
    ld [de], a
    jr .loop2

.skip4:
    ld a, b
    ld [de], a
    inc e
    ldh a, [hSpriteTileOffset]
    ld c, a
    ld a, [hli]
    add c
    ld [de], a
    inc e
    ldh a, [hSpriteAttrXor]
    ld c, a
    ld a, [hli]
    xor c
    ld [de], a
    inc e
    ldh a, [hOamNextEntry]
    inc a
    ldh [hOamNextEntry], a
    cp $28
    jr nz, .loop2
    ret

.check_sprite_attr_xor:
    ldh a, [hSpriteAttrXor]
    and $20
    jr nz, .loop5

.loop3:
    ld a, [hli]
    cp $80
    ret z
    ld c, a
    ld b, $00
    rlca
    jr nc, .read_meta_sprite_y_lo3
    dec b

.read_meta_sprite_y_lo3:
    ldh a, [hMetaSpriteYLo]
    add c
    ld c, a
    ldh a, [hMetaSpriteYHi]
    adc b
    jr nz, .next5
    ld a, c
    cp $b8
    jr nc, .next5
    ldh a, [hSpriteWindowClipMode]
    or a
    jr z, .skip6
    cp $01
    jr nz, .cp_02
    ld a, c
    cp $34
    jr c, .next5
    jr .skip6

.cp_02:
    cp $02
    jr nz, .skip5
    ld a, c
    cp $71
    jr c, .skip6
    jr .next5

.skip5:
    jr .skip6

.next5:
    inc hl
    inc hl
    inc hl
    jr .loop3

.skip6:
    ld a, c
    ld [de], a
    inc e
    ld a, [hli]
    ld c, a
    ld b, $00
    rlca
    jr nc, .read_meta_sprite_x_lo2
    dec b

.read_meta_sprite_x_lo2:
    ldh a, [hMetaSpriteXLo]
    add c
    ld c, a
    ldh a, [hMetaSpriteXHi]
    adc b
    jr nz, .loop4
    ld a, c
    cp $b8
    jr c, .call_bg_tile_under_point_is_sprite_hide_tile

.loop4:
    inc hl
    inc hl
    dec e
    xor a
    ld [de], a
    jr .loop3

.call_bg_tile_under_point_is_sprite_hide_tile:
    ld a, c
    ld [de], a
    call BGTileUnderPointIsSpriteHideTile_BankE1
    jr nc, .loop4
    inc e
    ldh a, [hSpriteTileOffset]
    ld b, a
    ld a, [hli]
    add b
    ld [de], a
    inc e
    ldh a, [hSpriteAttrXor]
    ld c, a
    ld a, [hli]
    xor c
    ld [de], a
    inc e
    ldh a, [hOamNextEntry]
    inc a
    ldh [hOamNextEntry], a
    cp $28
    jr nz, .loop3
    ret

.loop5:
    ld a, [hli]
    cp $80
    ret z
    ld c, a
    ld b, $00
    rlca
    jr nc, .read_meta_sprite_y_lo4
    dec b

.read_meta_sprite_y_lo4:
    ldh a, [hMetaSpriteYLo]
    add c
    ld c, a
    ldh a, [hMetaSpriteYHi]
    adc b
    jr nz, .next6
    ld a, c
    cp $b8
    jr nc, .next6
    ldh a, [hSpriteWindowClipMode]
    or a
    jr z, .skip8
    cp $01
    jr nz, .cp_022
    ld a, c
    cp $34
    jr c, .next6
    jr .skip8

.cp_022:
    cp $02
    jr nz, .skip7
    ld a, c
    cp $71
    jr c, .skip8
    jr .next6

.skip7:
    jr .skip8

.next6:
    inc hl
    inc hl
    inc hl
    jr .loop5

.skip8:
    ld a, c
    ld [de], a
    inc e
    ld a, [hli]
    ld c, a
    ld b, $00
    rlca
    jr nc, .read_meta_sprite_x_flip_lo2
    dec b

.read_meta_sprite_x_flip_lo2:
    ldh a, [hMetaSpriteXFlipLo]
    sub c
    ld c, a
    ldh a, [hMetaSpriteXFlipHi]
    sbc b
    jr nz, .loop6
    ld a, c
    cp $b8
    jr c, .call_bg_tile_under_point_is_sprite_hide_tile2

.loop6:
    inc hl
    inc hl
    dec e
    xor a
    ld [de], a
    jr .loop5

.call_bg_tile_under_point_is_sprite_hide_tile2:
    ld a, c
    ld [de], a
    call BGTileUnderPointIsSpriteHideTile_BankE1
    jr nc, .loop6
    inc e
    ldh a, [hSpriteTileOffset]
    ld b, a
    ld a, [hli]
    add b
    ld [de], a
    inc e
    ldh a, [hSpriteAttrXor]
    ld c, a
    ld a, [hli]
    xor c
    ld [de], a
    inc e
    ldh a, [hOamNextEntry]
    inc a
    ldh [hOamNextEntry], a
    cp $28
    jr nz, .loop5
    ret

; DE = address of the X byte of a sprite part in screen coordinates, with its Y byte at DE - 1.
; Takes the entry of the $9800 BG map under the point (X + hScrollX - 4, Y + hScrollY - 12), rows
; wrapping inside the 32 x 32 map, waits with interrupts off for rSTAT bit 1 to clear, reads the
; tile id, executes ei, and returns A = that tile id with the flags of cp A, hSpriteHideTile: carry
; set when the tile id is below hSpriteHideTile, Z set when equal. BC and HL are kept. Both callers
; in DrawMetaSpriteSet_BankE1_BuildOam keep the sprite part only when carry is set (they skip it on
; jr nc), so a tile id at or above hSpriteHideTile hides the part. The interrupt flag is set again
; whatever it was before. (C1, E-0385)
; DE = address of an X byte with its Y byte at DE - 1 (screen coordinates): HL = the $9800 BG map
; entry under (X + hScrollX - 4, Y + hScrollY - 12), rows wrapping inside the map; reads it after
; rSTAT bit 1 clears (interrupts off) and compares with hSpriteHideTile: Z set when equal, A = the
; tile; BC, HL kept (E-0065) (the same 54 bytes appear in 6 banks)
BGTileUnderPointIsSpriteHideTile_BankE1::
    push hl
    push bc
    ldh a, [hScrollY]
    ld b, a
    dec e
    ld a, [de]
    inc e
    add b
    sub $0c
    and $f8
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ldh a, [hScrollX]
    ld b, a
    ld a, [de]
    add b
    sub $04
    and $f8
    rrca
    rrca
    rrca
    add l
    ld l, a
    ld a, h
    and $03
    adc $98
    ld h, a
    ldh a, [hSpriteHideTile]
    ld b, a
    di

.loop:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop
    ld a, [hl]
    ei
    cp b
    pop bc
    pop hl
    ret

; shape only; no reference found and the bytes occur nowhere else in the ROM; two words point at the
; two frames that follow, each laid out as the E-0147 meta-sprite frames: 4-byte sprites (Y offset,
; X offset, tile, attribute) ending with $80 (E-0236, C1)
; record: frame
UnreferencedMetaSpriteSet_E1::
    dw UnreferencedMetaSpriteSet_E1_Frame0 ; id 0
    dw UnreferencedMetaSpriteSet_E1_Frame1 ; id 1

; shape only; frame 0 of UnreferencedMetaSpriteSet_E1; ends with $80 (E-0236, C1)
; record: sprite: Y offset, X offset, tile, attribute
UnreferencedMetaSpriteSet_E1_Frame0::
    db $f0, $25, $0b, $01 ; entry 0
    db $08, $15, $05, $00 ; entry 1
    db $08, $08, $07, $00 ; entry 2
    db $10, $08, $09, $00 ; entry 3
    db $10, $10, $0a, $00 ; entry 4
    db $10, $01, $07, $00 ; entry 5
    db $18, $03, $07, $00 ; entry 6
    db $18, $ff, $08, $00 ; entry 7
    db $f8, $18, $0c, $00 ; entry 8
    db $f8, $28, $0d, $00 ; entry 9
    db $00, $1b, $0e, $00 ; entry 10
    db $00, $28, $0f, $00 ; entry 11
    db $80 ; end

; shape only; frame 1 of UnreferencedMetaSpriteSet_E1; ends with $80 (E-0236, C1)
UnreferencedMetaSpriteSet_E1_Frame1::
    db $f7, $1f, $0b, $01 ; entry 0
    db $f0, $20, $00, $00 ; entry 1
    db $f8, $18, $01, $00 ; entry 2
    db $f8, $20, $02, $00 ; entry 3
    db $f8, $28, $03, $00 ; entry 4
    db $00, $1b, $04, $00 ; entry 5
    db $08, $15, $05, $00 ; entry 6
    db $02, $28, $06, $00 ; entry 7
    db $08, $08, $07, $00 ; entry 8
    db $10, $08, $09, $00 ; entry 9
    db $10, $10, $0a, $00 ; entry 10
    db $10, $01, $07, $00 ; entry 11
    db $18, $03, $07, $00 ; entry 12
    db $18, $ff, $08, $00 ; entry 13
    db $80 ; end

; Super Game Boy border set 4: border tiles $00-$7F (4096 bytes, sent with packet set $10);
; LoadSGBBorderForSetA decompresses it into the cleared vTiles1 and sends it (SGBTransferCompressed)
; LZSS-compressed asset: 3046 bytes expand to 4096 into a zero-filled buffer (tools/lzss_gfx.py,
; E-0016/E-0017; C1)
SGBBorder4TilesA::
    INCBIN "gfx/sgb_border/4_tiles_a.lz"

; Super Game Boy border set 4: border tiles $80-$FF (4096 bytes, packet set $11);
; LoadSGBBorderForSetA decompresses it into the cleared vTiles1 and sends it (SGBTransferCompressed)
; LZSS-compressed asset: 3410 bytes expand to 4096 into a zero-filled buffer (tools/lzss_gfx.py,
; E-0016/E-0017; C1)
SGBBorder4TilesB::
    INCBIN "gfx/sgb_border/4_tiles_b.lz"

; Super Game Boy border set 4: border map and palettes ($880 bytes, packet set $0F);
; LoadSGBBorderForSetA decompresses it into the cleared vTiles1 and sends it (SGBTransferCompressed)
; LZSS-compressed: 1133 bytes that expand to 2176 (E-0016, E-0017)
SGBBorder4MapAndPalettes::
    INCBIN "gfx/sgb_border/4_map_and_palettes.lz"
    ds $4a9, $00
