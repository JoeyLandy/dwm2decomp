; ROM bank $7E: field graphics, sprites and palettes
; The annotated listing of this bank is build/listing/bank7e.asm.

SECTION "Bank 7E", ROMX
    db $7e

; compressed sprite graphics number $50 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 214 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx50::
    INCBIN "gfx/field_sprites/50.lz"

; compressed sprite graphics number $51 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 218 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx51::
    INCBIN "gfx/field_sprites/51.lz"

; compressed sprite graphics number $52 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 203 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx52::
    INCBIN "gfx/field_sprites/52.lz"

; compressed sprite graphics number $53 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 215 bytes that expand to 256 (E-0016, E-0017)
FieldSpriteGfx53::
    INCBIN "gfx/field_sprites/53.lz"

; compressed sprite graphics number $54 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 371 bytes that expand to 416 (E-0016, E-0017)
FieldSpriteGfx54::
    INCBIN "gfx/field_sprites/54.lz"

; compressed sprite graphics number $55 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 195 bytes that expand to 256 (E-0016, E-0017)
FieldSpriteGfx55::
    INCBIN "gfx/field_sprites/55.lz"

; compressed sprite graphics number $56 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 90 bytes that expand to 128 (E-0016, E-0017)
FieldSpriteGfx56::
    INCBIN "gfx/field_sprites/56.lz"

; compressed sprite graphics number $57 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 182 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx57::
    INCBIN "gfx/field_sprites/57.lz"

; compressed sprite graphics number $58 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 63 bytes that expand to 64 (E-0016, E-0017)
FieldSpriteGfx58::
    db $40, $00, $01, $01, $ff, $f0, $03, $03, $0f, $0c, $17, $18, $1e, $11, $29, $3f
    db $3f, $26, $01, $ff, $f0, $c0, $c0, $b0, $70, $f8, $68, $38, $c8, $fc, $1c, $94
    db $7c, $2d, $33, $38, $3f, $17, $1f, $1a, $1f, $0f, $0f, $03, $03, $01, $ff, $f0
    db $bc, $e4, $fc, $fc, $c8, $f8, $78, $f8, $30, $f0, $c0, $c0, $01, $a0, $f0

; compressed sprite graphics number $59 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 39 bytes that expand to 64 (E-0016, E-0017)
FieldSpriteGfx59::
    db $40, $00, $02, $01, $01, $1a, $1b, $24, $3f, $54, $7f, $70, $7f, $1f, $1f, $30
    db $3f, $3f, $2f, $1f, $18, $1f, $17, $1f, $1d, $26, $3f, $27, $3f, $1d, $1f, $0f
    db $0b, $1c, $1c, $02, $a0, $ff, $0d

; compressed sprite graphics number $5A of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 53 bytes that expand to 64 (E-0016, E-0017)
FieldSpriteGfx5A::
    db $40, $00, $00, $ff, $ff, $80, $ff, $d8, $a7, $f9, $86, $ff, $fe, $ff, $bf, $ff
    db $bf, $ff, $80, $c4, $bb, $ce, $b1, $fb, $84, $f8, $87, $cc, $b3, $c6, $b9, $ff
    db $80, $ff, $ff, $00, $00, $00, $da, $a5, $da, $a5, $d9, $a6, $fe, $81, $fd, $fe
    db $fa, $87, $00, $10, $0c

; compressed sprite graphics number $5B of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 63 bytes that expand to 64 (E-0016, E-0017)
FieldSpriteGfx5B::
    db $40, $00, $01, $01, $ff, $f0, $07, $07, $18, $1f, $2f, $3e, $5b, $7c, $b7, $ee
    db $da, $bf, $01, $ff, $f0, $e0, $e0, $18, $f8, $f4, $7c, $da, $3e, $ed, $77, $5b
    db $fd, $ef, $be, $ba, $df, $5e, $6f, $23, $3e, $1b, $1c, $07, $07, $01, $ff, $f0
    db $f7, $7d, $5d, $fb, $7a, $f6, $c4, $7c, $d8, $38, $e0, $e0, $01, $a0, $f0

; compressed sprite graphics number $5C of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 191 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx5C::
    INCBIN "gfx/field_sprites/5_c.lz"

; compressed sprite graphics number $5D of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 45 bytes that expand to 64 (E-0016, E-0017)
FieldSpriteGfx5D::
    db $40, $00, $02, $02, $ff, $fa, $01, $01, $00, $00, $1c, $1c, $6e, $72, $be, $ea
    db $7a, $46, $5c, $6c, $b4, $fc, $48, $c8, $1a, $1b, $15, $1f, $6b, $6d, $56, $7a
    db $2c, $34, $58, $68, $70, $70, $00, $00, $80, $80, $02, $a0, $fa

; compressed sprite graphics number $5E of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 119 bytes that expand to 128 (E-0016, E-0017)
FieldSpriteGfx5E::
    INCBIN "gfx/field_sprites/5_e.lz"

; compressed sprite graphics number $5F of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 231 bytes that expand to 256 (E-0016, E-0017)
FieldSpriteGfx5F::
    INCBIN "gfx/field_sprites/5_f.lz"

; compressed sprite graphics number $60 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 282 bytes that expand to 512 (E-0016, E-0017)
FieldSpriteGfx60::
    INCBIN "gfx/field_sprites/60.lz"

; compressed sprite graphics number $61 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 62 bytes that expand to 256 (E-0016, E-0017)
FieldSpriteGfx61::
    db $00, $01, $01, $43, $43, $74, $77, $49, $7f, $97, $fe, $a3, $ff, $60, $7f, $93
    db $ff, $97, $ff, $c2, $c2, $2e, $ee, $92, $fe, $e9, $7f, $c5, $ff, $16, $fe, $c9
    db $ff, $e9, $ff, $6f, $6d, $05, $06, $7a, $7f, $3b, $3f, $24, $3c, $64, $7c, $82
    db $fe, $fc, $fc, $01, $a0, $ff, $4d, $01, $8f, $0f, $4d, $01, $ef, $0c

; the palettes FieldSpritePaletteIndex selects; DecompressGraphicsTemp0ToTemp4 copies one to
; wOBJPaletteBuffer + 8 * hTemp3 (E-0143, C1)
; record: one CGB OBJ palette: 4 BGR555 colours
FieldSpritePalettes::
    dw $0000, $6bff, $663f, $0800 ; id 0
OBJPaletteBufferPlus28Data::
    dw $0000, $6bff, $001f, $0800 ; id 1
    dw $0000, $6bff, $0553, $0800 ; id 2
OBJPaletteBufferPlus10Data::
    dw $0000, $6bff, $7000, $0800 ; id 3
    dw $0000, $6bff, $03e0, $0800 ; id 4
    dw $0000, $6bff, $5ab4, $0800 ; id 5
OBJPaletteBufferPlus10Data_2::
    dw $0000, $6bff, $6017, $0800 ; id 6
OBJPaletteBufferPlus20Data::
    dw $0000, $6bff, $027f, $0800 ; id 7
    dw $0000, $6bff, $662c, $0800 ; id 8
    dw $0000, $6bff, $031d, $0800 ; id 9
    dw $0000, $037f, $0340, $0800 ; id 10
    dw $0000, $7f1f, $027f, $0800 ; id 11
    dw $0000, $035f, $026e, $0800 ; id 12
    dw $0000, $767f, $3d58, $0800 ; id 13
    dw $0000, $3afd, $0533, $0800 ; id 14
    dw $0000, $4f5d, $1415, $0000 ; id 15
    dw $0000, $5efd, $39b2, $0000 ; id 16
    dw $0000, $6bff, $6b2a, $0800 ; id 17
DebugStaffRoll_Scene00_Load_OBJPaletteBufferData::
    dw $0000, $6bff, $7da0, $0000 ; id 18
OBJPaletteBufferPlus8Data::
    dw $0000, $6bff, $2e0a, $0000 ; id 19
    dw $0000, $6bff, $7ec5, $0800 ; id 20

; A table of CGB OBJ palettes, 4 BGR555 colours (8 bytes) each, continuing FieldSpritePalettes. Its
; users copy 8-byte palettes from bank $7E to wOBJPaletteBuffer slots with CopyFromBankWaitVRAM at a
; byte offset into it: TitleOpening_Load (offset 0), RunWorldMapState_DrawCloseUp ($40),
; LoadPlayerAndFollowerSpriteGraphics_Followers ($C8), LoadSpriteGraphics7EToTiles0 ($D8),
; LoadAltObjectGraphicsIfPlayerStateFlagsBit3 ($108), RunWorldMapState_DrawOverview and
; LoadTriggerMarkerGraphics (an offset from its own table). (C1, E-0372); E-0238 (C1: copied 8 bytes
; at a time to wOBJPaletteBuffer slots by many loaders (bank $00 $22F0 with $4BBD + $C8, bank $07,
; $12, $A1, $E0 with $4C0D, $4C65 and $4CAD; RunFieldCommandTemp0_LoadGfxPalette4 with $4BBD + 8 *
; index); 38 palettes up to the stream at $4CED, continuing FieldSpritePalettes). (named from its
; reading, E-0372; was LoadPlayerAndFollowerSpriteGraphics_OBJPaletteBufferData)
SharedOBJPalettes::
    dw $0000, $037f, $027f, $0000 ; id 0
    dw $0000, $4f5d, $1415, $0000 ; id 1
    dw $0000, $4f5d, $02b0, $0000 ; id 2
    dw $0000, $4f5d, $662c, $0000 ; id 3
    dw $0000, $4f5d, $01fc, $0000 ; id 4
    dw $0000, $4f5d, $19b2, $0000 ; id 5
    dw $0000, $4f5d, $00f4, $0000 ; id 6
    dw $0000, $4f5d, $19b2, $0000 ; id 7
    dw $0000, $4f5d, $4a6d, $0000 ; id 8
    dw $0000, $4f5d, $01fc, $0000 ; id 9
OBJPaletteBufferPlus18Data_2::
    dw $0000, $4f5d, $2db0, $0000 ; id 10
    dw $0000, $7fff, $11ad, $0000 ; id 11
    dw $0000, $037f, $021c, $0000 ; id 12
    dw $0000, $7fff, $7dab, $0000 ; id 13
    dw $0000, $5efd, $39b2, $0000 ; id 14
    dw $0000, $7b1f, $6513, $0000 ; id 15
    dw $0000, $62f8, $3dcf, $0000 ; id 16
    dw $0000, $037f, $021c, $0000 ; id 17
    dw $0000, $6fb8, $7dab, $0000 ; id 18
    dw $0000, $027f, $001f, $0000 ; id 19
    dw $0000, $7fff, $316b, $0000 ; id 20
OBJPaletteBufferPlus30Data::
    dw $0000, $7fff, $316b, $0000 ; id 21
    dw $0000, $5eb5, $3dad, $0000 ; id 22
    dw $0000, $673c, $3190, $0000 ; id 23
    dw $0000, $6fb8, $7dab, $0000 ; id 24
    dw $0000, $7fff, $7dab, $0000 ; id 25
    dw $0000, $027f, $001f, $0000 ; id 26
    dw $0000, $0b5f, $15df, $0800 ; id 27
    dw $0000, $7ff5, $7ca0, $0800 ; id 28
    dw $0000, $037f, $021c, $0000 ; id 29
OBJPaletteBufferPlus8Data_2::
    dw $0000, $7fff, $021c, $0000 ; id 30
    dw $0000, $6bff, $035f, $0800 ; id 31
    dw $0000, $6bff, $035f, $0800 ; id 32
    dw $0000, $5fbf, $2a3d, $0000 ; id 33
    dw $0000, $6bff, $6652, $0000 ; id 34
    dw $0000, $4f5d, $19d3, $0000 ; id 35
    dw $0000, $027f, $001f, $0000 ; id 36
    dw $0000, $6bff, $027f, $0000 ; id 37

; LZSS-compressed: 45 bytes that expand to 64 (E-0016, E-0017)
Tiles0Gfx::
    db $40, $00, $02, $02, $ff, $fa, $01, $01, $00, $00, $1c, $1c, $6e, $72, $be, $ea
    db $7a, $46, $5c, $6c, $b4, $fc, $48, $c8, $1a, $1b, $15, $1f, $6b, $6d, $56, $7a
    db $2c, $34, $58, $68, $70, $70, $00, $00, $80, $80, $02, $a0, $fa

; LZSS-compressed: 53 bytes that expand to 64 (E-0016, E-0017)
Gfx_TriggerSpriteTable_2::
    db $40, $00, $00, $ff, $ff, $80, $ff, $d8, $a7, $f9, $86, $ff, $fe, $ff, $bf, $ff
    db $bf, $ff, $80, $c4, $bb, $ce, $b1, $fb, $84, $f8, $87, $cc, $b3, $c6, $b9, $ff
    db $80, $ff, $ff, $00, $00, $00, $da, $a5, $da, $a5, $d9, $a6, $fe, $81, $fd, $fe
    db $fa, $87, $00, $10, $0c

; LZSS-compressed: 59 bytes that expand to 64 (E-0016, E-0017)
Gfx_TriggerSpriteTable_4::
    db $40, $00, $01, $01, $ff, $f0, $0e, $00, $0f, $04, $1f, $06, $19, $0f, $1a, $0d
    db $1e, $05, $01, $ff, $f0, $7c, $00, $fc, $38, $cc, $f8, $2c, $d8, $5c, $b0, $18
    db $f0, $0c, $07, $0e, $03, $1f, $05, $3f, $08, $3c, $10, $38, $01, $ff, $f1, $38
    db $e0, $dc, $30, $9c, $f8, $fc, $60, $f0, $01, $a0, $f3

; LZSS tile data, 64 bytes after decompression (4 tiles, one 16 x 16 sprite as 2 x 2 tiles, 2bpp).
; Record 5 of TriggerSpriteTable (a dfar into bank $7E); LoadTriggerMarkerGraphics decompresses it
; to vTiles0 + $400 (DecompressToVRAM) and copies the OBJ palette at SharedOBJPalettes + $18 to OBJ
; palette 4; DrawTriggerMarkerSprite then draws meta-sprite set $03
; (DrawTriggerMarkerSprite_Data1[5]) with tile offset $40. Marker kind 5 is the kind
; RandomGoldOrItem_PickFind_RollFind_Data2 gives to item ids $02-$05 and $20 (ITEM_LOVEWATER,
; ITEM_WORLDDEW, ITEM_POTION, ITEM_ELFWATER, ITEM_REPELLENT). The render shows a round flask with a
; narrow neck and a stopper, which fits a potion or water bottle. (C1, E-0383)
; LZSS-compressed: 66 bytes that expand to 64 (E-0016, E-0017)
FoundItemBottleSpriteTiles::
    INCBIN "gfx/misc/found_item_bottle_sprite_tiles.lz"

; LZSS-compressed: 58 bytes that expand to 64 (E-0016, E-0017)
Gfx_TriggerSpriteTable_6::
    db $40, $00, $01, $01, $ff, $f6, $07, $00, $0f, $03, $7d, $06, $00, $00, $3c, $00
    db $7e, $18, $76, $2c, $e6, $3c, $fe, $58, $fc, $a0, $70, $c0, $fb, $3c, $df, $60
    db $de, $71, $bf, $69, $77, $3d, $79, $1f, $37, $0e, $0f, $00, $e0, $40, $60, $c0
    db $e0, $80, $c0, $00, $80, $01, $37, $01, $00, $00

; LZSS-compressed: 49 bytes that expand to 64 (E-0016, E-0017)
Gfx_TriggerSpriteTable_7::
    db $40, $00, $01, $01, $ff, $f4, $07, $00, $0f, $03, $1c, $07, $3b, $0c, $01, $ff
    db $f4, $c0, $00, $e0, $80, $70, $c0, $38, $e0, $34, $1b, $3a, $0d, $1c, $07, $0f
    db $03, $07, $01, $ff, $f3, $58, $b0, $38, $e0, $70, $c0, $e0, $80, $c0, $01, $a0
    db $f3

; LZSS tile data, 64 bytes after decompression (4 tiles, one 16 x 16 sprite as 2 x 2 tiles, 2bpp).
; Record 8 of TriggerSpriteTable (a dfar into bank $7E); LoadTriggerMarkerGraphics decompresses it
; to vTiles0 + $400 (DecompressToVRAM) and copies the OBJ palette at SharedOBJPalettes + $30 to OBJ
; palette 4; DrawTriggerMarkerSprite then draws meta-sprite set $06
; (DrawTriggerMarkerSprite_Data1[8]) with tile offset $40. Marker kind 8 is the kind
; RandomGoldOrItem_PickFind_RollFind_Data2 gives to item ids $19-$1D (ITEM_BEEFJERKY, ITEM_PORKCHOP,
; ITEM_RIB, ITEM_SIRLOIN, ITEM_BADMEAT). The render shows a diagonal slab of meat with a bone knob
; at each end. (C1, E-0383)
FoundItemMeatSpriteTiles::
    INCBIN "gfx/misc/found_item_meat_sprite_tiles.lz"

Gfx_TriggerSpriteTable_9::
    db $40, $00, $02, $02, $ff, $f0, $01, $00, $03, $00, $03, $01, $03, $01, $03, $00
    db $07, $00, $00, $00, $fc, $00, $fe, $78, $87, $fc, $23, $fe, $f3, $de, $f3, $1e
    db $e3, $fe, $1f, $03, $3c, $0f, $71, $1f, $67, $3e, $7f, $18, $3c, $02, $ff, $f1
    db $07, $fc, $7e, $f8, $fc, $80, $c0, $02, $a0, $f5

; LZSS-compressed: 62 bytes that expand to 64 (E-0016, E-0017)
Tiles0Gfx_2::
    db $40, $00, $02, $02, $ff, $f0, $03, $00, $07, $01, $0e, $03, $1f, $04, $1e, $09
    db $1e, $09, $78, $00, $d4, $38, $7c, $e8, $ea, $9c, $ee, $34, $ba, $cc, $74, $b8
    db $dc, $68, $1e, $09, $1c, $0b, $1c, $0b, $3d, $0b, $3a, $17, $3b, $16, $3f, $0c
    db $1e, $00, $dc, $b0, $f8, $60, $b0, $c0, $c0, $00, $80, $02, $a0, $f3

Gfx_FieldCommandSpriteTable_16::
    db $40, $00, $01, $01, $ff, $f4, $07, $00, $0f, $03, $1f, $04, $1c, $0b, $01, $ff
    db $f4, $e0, $00, $f0, $c0, $b8, $60, $58, $b0, $1d, $0a, $1c, $0b, $1f, $04, $0f
    db $03, $07, $01, $ff, $f3, $d8, $30, $d8, $30, $b8, $60, $f0, $c0, $e0, $01, $a0
    db $f3

; LZSS tile data, 64 bytes after decompression (4 tiles, one 16 x 16 sprite, 2bpp). Records 0 and 1
; of FieldCommandSpriteTable (selector $0A: meta-sprite set $0A, palette id 10 of
; SharedOBJPalettes): RunFieldCommandTemp0_LoadGfxPalette4 decompresses it to vTiles0 + $400 for the
; scene object. Field command 0 is run by Talk_SceneSpinning and field command 1 by the Vault keeper
; talk, two Great Log talks (Mama, Warubou at the plug) and SceneHomecoming_ShowObject.
; DebugStaffRoll_Scene00_Load also decompresses it to vTiles0 + $300. The render is one faceted gray
; lump with light highlights, a single frame. What the lump stands for in those scenes is not shown
; by the code. (C1, E-0383)
; LZSS-compressed: 65 bytes that expand to 64 (E-0016, E-0017)
FacetedGrayLumpSpriteTiles::
    INCBIN "gfx/misc/faceted_gray_lump_sprite_tiles.lz"

; LZSS tile data, 64 bytes after decompression (4 tiles, 2bpp). Record 15 of FieldCommandSpriteTable
; (field command $0F): RunFieldCommandTemp0_LoadGfxPalette4 decompresses it to vTiles0 + $400 and
; copies the OBJ palette SharedOBJPalettes + 8 * $0B to OBJ palette 4; the record selector $0B names
; meta-sprite set $0B (selector bit 7 set means DrawFieldSprites_AnimateSubIndex steps its frames).
; Field command $0F is chosen by BossWinScene_LoadSprites after EVENT_SCENE_SHIELD2_023 (the last of
; its four story stages; the earlier ones use commands 3, 8 and $0A), together with message set 3 of
; StartMessageFromTable_Data ($0534-$0536), whose text calls the object the MagicPlug, so this is
; the MagicPlug prop; the object is placed at ($50, $30). The render is one flat round object: a
; dome cap with a rim over a wider disc, a plug shape. (C1, E-0383)
; LZSS-compressed: 67 bytes that expand to 64 (E-0016, E-0017)
MagicPlugSpriteTiles::
    INCBIN "gfx/misc/magic_plug_sprite_tiles.lz"

; LZSS tile data, 64 bytes after decompression (4 tiles, two 16 x 8 halves of one 16 x 16 object).
; No reader was found: the label and every address alias of bank $7E $4FA6 occur only as definitions
; or in jump and pointer tables of other banks, no ld, dw or dfar of the address or of its bytes
; ($A6 $4F) loads it, FieldCommandSpriteTable and TriggerSpriteTable do not list it, and the loads
; of bank $7E tiles (DecompressToVRAM with b = $7E) name other streams. Drawn as a 2 x 2 tile object
; it is a round pot or keg: a stepped dome top with a ring and a wide banded body. Its size and
; layout match the item props of FieldCommandSpriteTable (MagicPlugSpriteTiles, the MagicPlug, sits
; directly before it in the bank and has a similar dome-over-disc build). (C1, E-0383)
; LZSS-compressed: 66 bytes that expand to 64 (E-0016, E-0017)
BandedPotSpriteTiles::
    INCBIN "gfx/misc/banded_pot_sprite_tiles.lz"

; LZSS-compressed: 63 bytes that expand to 64 (E-0016, E-0017)
Gfx_FieldCommandSpriteTable_8::
    db $40, $00, $01, $01, $ff, $f0, $07, $07, $1d, $1a, $37, $2f, $73, $5c, $e6, $b9
    db $ad, $f2, $01, $ff, $f0, $e0, $e0, $b8, $58, $ec, $f4, $7e, $8a, $ef, $15, $d5
    db $2f, $bb, $e4, $f7, $a8, $7e, $51, $37, $2f, $1d, $1a, $07, $07, $01, $ff, $f0
    db $a5, $5f, $47, $bd, $8e, $7a, $ec, $f4, $b8, $58, $e0, $e0, $01, $a0, $f0

Gfx_FieldCommandSpriteTable_10::
    db $40, $00, $01, $01, $ff, $f0, $07, $07, $18, $1f, $2f, $3e, $5b, $7c, $b7, $ee
    db $da, $bf, $01, $ff, $f0, $e0, $e0, $18, $f8, $f4, $7c, $da, $3e, $ed, $77, $5b
    db $fd, $ef, $be, $ba, $df, $5e, $6f, $23, $3e, $1b, $1c, $07, $07, $01, $ff, $f0
    db $f7, $7d, $5d, $fb, $7a, $f6, $c4, $7c, $d8, $38, $e0, $e0, $01, $a0, $f0

; LZSS tile data, 64 bytes after decompression (4 tiles, two 16 x 8 halves of one 16 x 16 object).
; No reader was found (the label and aliases of $5066 only occur as definitions or other-bank table
; and code entries; no pointer bytes $66 $50 load it; it is not in FieldCommandSpriteTable or
; TriggerSpriteTable). Drawn as a 2 x 2 tile object it is a plain round disc with a light face and a
; dark outline, like a coin, plate or hand mirror without a handle. (C1, E-0383)
; LZSS-compressed: 67 bytes that expand to 64 (E-0016, E-0017)
RoundDiscSpriteTiles::
    INCBIN "gfx/misc/round_disc_sprite_tiles.lz"

; LZSS tile data, 64 bytes after decompression (4 tiles, two 16 x 8 halves of one 16 x 16 object).
; No reader was found (the label and aliases of $50A9 occur only as definitions or in jump tables of
; other banks; no pointer bytes $A9 $50 load it). Drawn as a 2 x 2 tile object it is a small figure
; seen from the front: a head with two horns or ears and a spiky crown line, arms or sleeves out to
; both sides and a banded body on a flat base. (C1, E-0383)
; LZSS-compressed: 66 bytes that expand to 64 (E-0016, E-0017)
HornedFigureSpriteTiles::
    INCBIN "gfx/misc/horned_figure_sprite_tiles.lz"

; LZSS-compressed: 61 bytes that expand to 64 (E-0016, E-0017)
Gfx_FieldCommandSpriteTable_9::
    db $40, $00, $02, $02, $ff, $f2, $1f, $1f, $17, $18, $0d, $0e, $0b, $0f, $05, $07
    db $02, $ff, $f2, $80, $80, $60, $e0, $b0, $50, $68, $98, $b8, $c8, $03, $03, $01
    db $01, $1c, $1c, $3e, $22, $7a, $4e, $47, $7f, $3b, $3a, $01, $01, $44, $fc, $e4
    db $fc, $e8, $f8, $9b, $fb, $55, $77, $33, $33, $80, $80, $80, $80

; LZSS tile data, 128 bytes after decompression (8 tiles, two 16 x 16 objects of 2 x 2 tiles). No
; reader was found (the label and aliases of $5128 only occur as definitions, as dfar entries of
; screen headers in other banks and as jump-table entries; no pointer bytes $28 $51 in a graphics
; load). The render is irregular jagged pieces with hatched shading, arranged as shards around a
; gap, like the fragments of a broken object. (C1, E-0383)
; LZSS-compressed: 128 bytes that expand to 128 (E-0016, E-0017)
ShatteredPiecesSpriteTiles::
    INCBIN "gfx/misc/shattered_pieces_sprite_tiles.lz"

; LZSS tile data, 256 bytes after decompression (16 tiles, 2bpp). Record 6 of
; FieldCommandSpriteTable (field command $06): RunFieldCommandTemp0_LoadGfxPalette4 decompresses it
; to vTiles0 + $400 and copies the OBJ palette SharedOBJPalettes + 8 * $13 to OBJ palette 4; the
; record selector $93 names meta-sprite set $13 (selector bit 7 set means
; DrawFieldSprites_AnimateSubIndex steps its frames). The animation has 4 frames (set $13,
; animated): a low spiky tuft that grows, peaks and shrinks again. The palette (SharedOBJPalettes id
; 19: orange and red) suggests flame, so the picture reads as a flame tuft. No literal caller sets
; hTemp0 to 6 (every call of RunFieldCommandTemp0 was read), but InitFieldScreen runs the command in
; wFieldInitFlag, set by script command $9F, which could select it.
; RunFieldCommandTemp0_LoadSceneObject6 would show it at ($40, $70) with its animation reset. (C1,
; E-0383)
; LZSS-compressed: 221 bytes that expand to 256 (E-0016, E-0017)
FlameTuftSpriteTiles::
    INCBIN "gfx/misc/flame_tuft_sprite_tiles.lz"

; LZSS-compressed: 55 bytes that expand to 64 (E-0016, E-0017)
Gfx7E_1::
    db $40, $00, $01, $00, $00, $1f, $1f, $3f, $20, $7f, $40, $01, $06, $01, $49, $7f
    db $40, $00, $00, $f0, $f0, $f8, $08, $fc, $04, $01, $16, $01, $24, $fc, $04, $01
    db $06, $00, $3f, $20, $1f, $13, $1c, $14, $18, $18, $01, $fe, $f0, $01, $16, $00
    db $f8, $08, $f0, $f0, $01, $a0, $f4

; LZSS-compressed: 61 bytes that expand to 64 (E-0016, E-0017)
Tiles0Plus600Gfx::
    db $40, $00, $01, $00, $00, $1f, $1f, $3f, $20, $7d, $43, $7f, $43, $7d, $43, $7f
    db $41, $7f, $40, $00, $00, $f0, $f0, $f8, $08, $7c, $84, $fc, $84, $7c, $84, $fc
    db $04, $fc, $04, $7d, $43, $7d, $43, $3f, $20, $1f, $13, $1c, $14, $18, $18, $01
    db $fe, $f0, $7c, $84, $7c, $84, $f8, $08, $f0, $f0, $01, $a0, $f4

; LZSS tile data, 128 bytes after decompression (8 tiles, 2bpp). Record 7 of FieldCommandSpriteTable
; (field command $07): RunFieldCommandTemp0_LoadGfxPalette4 decompresses it to vTiles0 + $400 and
; copies the OBJ palette SharedOBJPalettes + 8 * $16 to OBJ palette 4; the record selector $16 names
; meta-sprite set $16 (selector bit 7 set means DrawFieldSprites_AnimateSubIndex steps its frames).
; Field command 7 is run by SceneKamehaFlees_MoveObjectsUp, which shows the scene object above the
; screen and plays sound $65; SceneKamehaFlees_DropObject then drops it while the party hops and the
; screen shakes. Two frames (set $16): a dark round ball with jagged crack lines, the second frame
; slightly wider. Palette id 22 is gray-lilac. (C1, E-0383)
; LZSS-compressed: 119 bytes that expand to 128 (E-0016, E-0017)
DarkCrackedBallSpriteTiles::
    INCBIN "gfx/misc/dark_cracked_ball_sprite_tiles.lz"

; LZSS tile data, 192 bytes after decompression (12 tiles, 2bpp). Record 12 of
; FieldCommandSpriteTable (field command $0C): RunFieldCommandTemp0_LoadGfxPalette4 decompresses it
; to vTiles0 + $400 and copies the OBJ palette SharedOBJPalettes + 8 * $17 to OBJ palette 4; the
; record selector $97 names meta-sprite set $17 (selector bit 7 set means
; DrawFieldSprites_AnimateSubIndex steps its frames). Field command $0C is run by
; SceneRealKing_Separate (the scene before the line I am the real King, you fake), which places the
; scene object at ($40, $48) while the two king objects separate. Three frames (set $17, animated):
; a small cluster of blobs, a larger puffy cloud, then separate flecks scattering. Palette id 23 is
; pale gray-blue. It reads as a puff of smoke or dust. (C1, E-0383)
; LZSS-compressed: 170 bytes that expand to 192 (E-0016, E-0017)
SmokePuffSpriteTiles::
    INCBIN "gfx/misc/smoke_puff_sprite_tiles.lz"

; LZSS tile data, 80 bytes after decompression (5 tiles, 2bpp). Record 18 of FieldCommandSpriteTable
; (field command $12): RunFieldCommandTemp0_LoadGfxPalette4 decompresses it to vTiles0 + $400 and
; copies the OBJ palette SharedOBJPalettes + 8 * $18 to OBJ palette 4; the record selector $98 names
; meta-sprite set $18 (selector bit 7 set means DrawFieldSprites_AnimateSubIndex steps its frames).
; Field command $12 is run on entry by PlaceSpecialMapObjectsOnEntry on map $7F or $92 at screen (0,
; 0) and on map type $82, which places the scene object at ($40, $10), ($40, $40) or ($40, $30). The
; picture (set $18, two frames of 32 frames each) is a 16 x 16 pinwheel: four curved blades
; spiralling around a center, in pale cyan and blue (palette id 24); frame 1 draws no visible tiles,
; so the swirl blinks. It reads as a whirlpool or warp swirl. (C1, E-0383)
; LZSS-compressed: 68 bytes that expand to 80 (E-0016, E-0017)
SwirlSpriteTiles::
    INCBIN "gfx/misc/swirl_sprite_tiles.lz"

; LZSS tile data, 192 bytes after decompression (12 tiles, 2bpp), loaded by
; LoadPlayerAndFollowerSpriteGraphics_Followers in bank $00 for a party member whose MON_STATUS has
; the dead bit: DecompressToVRAM puts it in that follower slot of vTiles0 + $100 (a slot is $100
; bytes) and the OBJ palette SharedOBJPalettes + $C8 (id 25) goes to the member OBJ palette.
; DrawPartyFollowerSprites draws a follower whose species word has high byte $FF as meta-sprite set
; $19 (DrawMetaSprite, MetaSprites7FTable_2) at tile offset $10, $20 or $30 by member. Drawn that
; way the 12 tiles are a hexagonal coffin with a light cross on its lid: a front view for facing
; down (frames 0 and 1), a horizontal side view for left and right (frames 2 and 3) and a narrower
; view for facing up (frames 4 and 5). (C1, E-0383)
; LZSS-compressed: 181 bytes that expand to 192 (E-0016, E-0017)
FallenFollowerCoffinTiles::
    INCBIN "gfx/misc/fallen_follower_coffin_tiles.lz"

; LZSS tile data, 128 bytes after decompression (8 tiles, 2bpp). Record 11 of
; FieldCommandSpriteTable (field command $0B): RunFieldCommandTemp0_LoadGfxPalette4 decompresses it
; to vTiles0 + $400 and copies the OBJ palette SharedOBJPalettes + 8 * $1A to OBJ palette 4; the
; record selector $9A names meta-sprite set $1A (selector bit 7 set means
; DrawFieldSprites_AnimateSubIndex steps its frames). Field command $0B is run by
; RunScriptSubStep_FollowersSpread (walking sub-step 1 of RunScriptSubStep, used by SceneCheerYuna
; and SceneMonsterInspection) after the followers have spread to the sides; the scene object is put
; at the player position, hidden, with its animation reset, and later hops
; (RunScriptSubStep_HopObject5) and sinks (RunScriptSubStep_SinkObject5). Two frames (set $1A): a
; tall outlined spiky shape that flickers. The palette (id 26, orange and red) and the flickering
; outline read as a flame. (C1, E-0383)
; LZSS-compressed: 130 bytes that expand to 128 (E-0016, E-0017)
FlameSpriteTiles::
    INCBIN "gfx/misc/flame_sprite_tiles.lz"

; LZSS tile data, 192 bytes after decompression (12 tiles, 2bpp). LoadSpriteGraphics7EToTiles0 (bank
; $12) decompresses it to vTiles0 + $300 when hTemp0 is 0 or to vTiles0 + $700 otherwise, sets
; wSpriteFloatY to $30 and on CGB copies SharedOBJPalettes + $D8 (id 27: yellow-orange) to OBJ
; palette 3 or 7. BossWinScene_LoadSprites (hTemp0 = 1) and the Warubou food scenes of bank $73
; (hTemp0 = 0) far-call it; DrawAnimatedMetaSprite1B draws meta-sprite set $1B at ($48,
; wSpriteFloatY + $10) while CycleSpriteFloatYDown moves it up two pixels a frame. Six frames: a
; round ball that cycles small checkered, plain and large checkered (sub-index 0, 1, 2, each shown
; 10 frames), so it is a pulsing floating orb. (C1, E-0383)
; LZSS-compressed: 171 bytes that expand to 192 (E-0016, E-0017)
FloatingOrbSpriteTiles::
    INCBIN "gfx/misc/floating_orb_sprite_tiles.lz"

; LZSS tile data, 128 bytes after decompression (8 tiles, two 16 x 16 objects of 2 x 2 tiles). No
; reader was found (the label and aliases of $5640 occur only as definitions, MetaSprites26 data and
; battle code of other banks; no pointer bytes $40 $56 load it; it is not in FieldCommandSpriteTable
; or TriggerSpriteTable). Drawn as two 2 x 2 tile objects they are round stippled discs with
; concentric swirl lines, like carved stone wheels or woven round mats; the second has a darker rim.
; (C1, E-0383)
; LZSS-compressed: 131 bytes that expand to 128 (E-0016, E-0017)
CarvedDiscsSpriteTiles::
    INCBIN "gfx/misc/carved_discs_sprite_tiles.lz"

; LZSS tile data, 64 bytes after decompression (4 tiles, 2bpp). Record 3 of FieldCommandSpriteTable
; (field command $03): RunFieldCommandTemp0_LoadGfxPalette4 decompresses it to vTiles0 + $400 and
; copies the OBJ palette SharedOBJPalettes + 8 * $1D to OBJ palette 4; the record selector $1D names
; meta-sprite set $1D (selector bit 7 set means DrawFieldSprites_AnimateSubIndex steps its frames).
; SceneLimbo_PlaceItem picks the field command from SceneLimbo_PlaceItem_Data ($03, $08, $0A) by
; wScriptParam1 and SceneLimbo_ShowMessage shows message $052C + the same wScriptParam1 (TidalBell,
; HarMirror, SkyShield received), so command 3 is the TidalBell prop; BossWinScene_LoadSprites also
; uses command 3 for the first boss win (the rival) and KalkaTalkEvents_MonsterFan runs it. The
; render is one 16 x 16 object: a ribbed bell shape with a rounded body, vertical bands and a flared
; base, in yellow-orange (palette id 29). (C1, E-0383)
; LZSS-compressed: 67 bytes that expand to 64 (E-0016, E-0017)
TidalBellSpriteTiles::
    INCBIN "gfx/misc/tidal_bell_sprite_tiles.lz"

; LZSS tile data, 96 bytes after decompression (6 tiles, 2bpp). Two loaders: TitleOpening_Load
; decompresses it to vTiles0 + $100 (the sparkles or falling stars of the title opening, with
; Tiles0Gfx at vTiles0), and record 17 of FieldCommandSpriteTable (selector $9E: meta-sprite set
; $1E, animated, palette id 30: white and orange) loads it to vTiles0 + $400 for field command $11,
; run by the Darck defeated scene steps, the rival, Mermaid Kingdom and Shield 2 scenes (object 32
; pixels above the player, sound $85) and ScriptCommand4C_Run_PlaceObject. Four frames (set $1E): a
; tiny dot, a small X, a four-point star and a thin bright cross. It is a sparkle that grows. (C1,
; E-0383)
; LZSS-compressed: 80 bytes that expand to 96 (E-0016, E-0017)
SparkleSpriteTiles::
    INCBIN "gfx/misc/sparkle_sprite_tiles.lz"

; LZSS tile data, 512 bytes after decompression (32 tiles, 2bpp). Record 13 of
; FieldCommandSpriteTable (field command $0D): RunFieldCommandTemp0_LoadGfxPalette3 decompresses it
; to vTiles0 + $300 and copies the OBJ palette SharedOBJPalettes + 8 * $1F to OBJ palette 3; the
; record selector $1F names meta-sprite set $1F (selector bit 7 set means
; DrawFieldSprites_AnimateSubIndex steps its frames). Records 13 and 14 of FieldCommandSpriteTable
; (14 has the animation bit): field commands $0D and $0E share
; RunFieldCommandTemp0_LoadSceneObject13, which loads it to vTiles0 + $300 with palette 3 (yellow)
; at ($50, $3C) or ($48, $40). Callers are the breeding child scene
; (BreedChildScene_LoadChildGraphics, BreedChildScene_StartEffect), the hatching scenes
; (HatchingScene_ShowEgg, RunLinkSession8Exchange_EggHatched_ShowEgg, UnusedStepObject1LeftShowEgg)
; and the egg hand-over setups (GameMode6_Update_SetUpPrizeScene, GameMode8_Update_SetUpScene). The
; 8 frames of set $1F are an egg, a rocking egg, a cracking egg and then flying shell pieces: a
; monster egg hatching. (C1, E-0383)
; LZSS-compressed: 282 bytes that expand to 512 (E-0016, E-0017)
EggHatchSpriteTiles::
    INCBIN "gfx/misc/egg_hatch_sprite_tiles.lz"

; LZSS tile data, 512 bytes after decompression (32 tiles, 2bpp). Record 20 of
; FieldCommandSpriteTable (field command $14): RunFieldCommandTemp0_LoadGfxPalette4 decompresses it
; to vTiles0 + $400 and copies the OBJ palette SharedOBJPalettes + 8 * $20 to OBJ palette 4; the
; record selector $20 names meta-sprite set $20 (selector bit 7 set means
; DrawFieldSprites_AnimateSubIndex steps its frames). Records 20 and 21 (21 has the animation bit):
; field command $14 is run by GreatLogTalkEvents_ShowEgg when the egg receives gifts (wGiftRecord
; 1), and $15 by RunFieldReturnPhase_RunReturnAction_ShowGiftEgg on map 0 at screen (0, 3);
; RunFieldCommandTemp0_LoadSceneObject20 shows it at ($40, $40). The 7 frames of set $20 are a
; smooth pale oval, an egg, that wobbles and squashes a little; palette id 32 is yellow. It is the
; egg that is fed gifts. (C1, E-0383)
; LZSS-compressed: 143 bytes that expand to 512 (E-0016, E-0017)
GiftEggSpriteTiles::
    INCBIN "gfx/misc/gift_egg_sprite_tiles.lz"

; LZSS tile data, 256 bytes after decompression (16 tiles, 2bpp), loaded to vTiles0 + $700 with the
; OBJ palette SharedOBJPalettes + $108 (id 33: pale pink) in OBJ palette 7 by
; FieldScene01_LoadSprite (field scene 1, variant 1: the party gathers, the sprite appears 16 pixels
; in front of the player, the player hops on it) and by LoadAltObjectGraphicsIfPlayerStateFlagsBit3
; (player sprite mode 2, drawn by DrawPlayerOverlaySprite21Or22 as meta-sprite set $21 with tile
; offset $70). Set $21 has one frame using tiles 0-3: a ribbed scallop-shell shape with a small
; foot. The other tiles are not used by that frame. (C1, E-0383)
; LZSS-compressed: 75 bytes that expand to 256 (E-0016, E-0017)
ScallopShellSpriteTiles::
    INCBIN "gfx/misc/scallop_shell_sprite_tiles.lz"

; LZSS tile data, 256 bytes after decompression (16 tiles, 2bpp), loaded to vTiles0 + $700 with the
; OBJ palette SharedOBJPalettes + $108 (id 33: pale pink) in OBJ palette 7 by
; FieldScene01_LoadSprite2 (field scene 1, variant 2: the party gathers, the sprite appears 16
; pixels in front of the player and the player hops on and rides it until land,
; FieldScene01_Variant2_RideUntilLand). DrawScriptMetaSprite21AtScrollOffset draws it as meta-sprite
; set $22 (wMapSpriteKind low nibble not 1). The picture is one wide lumpy rounded blob made of two
; halves, gray with a darker lower edge. (C1, E-0383)
; LZSS-compressed: 74 bytes that expand to 256 (E-0016, E-0017)
LumpyBlobSpriteTiles::
    INCBIN "gfx/misc/lumpy_blob_sprite_tiles.lz"

; LZSS tile data, 256 bytes after decompression (16 tiles, 2bpp, only the first 8 non-empty).
; SetupScriptSpriteInFrontOfPlayer (RandomGoldOrItem step 0, and SceneStrongestMaster_SetUpSprite)
; loads it through SpawnScriptSpriteInFrontOfPlayer_LoadAndPlace to vTiles0 + $700 (the code names
; the address by the bank $12 label KeyWorldBossBattle_ShowMessage, which has the same address) with
; OBJ palette 7 (SharedOBJPalettes id 35). ScriptStepAnimateSpriteBySteps draws it as meta-sprite
; set $23 with sub-index 0-4 for 30 frames after sound $83. The 5 frames: a four-point twinkle star,
; the star over small flying bits, a puffy ring of debris, then scattered round pieces and dots: a
; burst of sparkles and debris at the spot, followed by the found item or gold in RandomGoldOrItem,
; or by the block redrawn in SceneStrongestMaster. (C1, E-0383)
; LZSS-compressed: 129 bytes that expand to 256 (E-0016, E-0017)
StarBurstDebrisSpriteTiles::
    INCBIN "gfx/misc/star_burst_debris_sprite_tiles.lz"

; LZSS tile data, 256 bytes after decompression (16 tiles, 2bpp). SpawnScriptSpriteInFrontOfPlayer
; loads it (when A is 1, otherwise SparkleAndCurvedStreakTiles) through
; SpawnScriptSpriteInFrontOfPlayer_LoadAndPlace to vTiles0 + $700, but that routine has no caller in
; src or the listing. The tiles are 8 pieces: two jagged spiky mounds and two halved gray domes
; (each pair forms a 16 x 8 shape). Drawn with the only meta-sprite set that routine path uses (set
; $23, via DrawScriptMetaSpriteAtScrollOffset) the frames come out as hourglass-like shapes that are
; not a coherent picture, so that set does not match this data. Its use is from the loader only; the
; picture is not identified. (C1, E-0383)
; LZSS-compressed: 133 bytes that expand to 256 (E-0016, E-0017)
SpawnScriptSpriteInFrontOfPlayer_Data::
    INCBIN "gfx/misc/spawn_script_sprite_in_front_of_player_data.lz"

; Tiles, 256 bytes decompressed (16 tiles). Decompressed by SpawnScriptSpriteInFrontOfPlayer (any A
; other than 1) through SpawnScriptSpriteInFrontOfPlayer_LoadAndPlace to vTiles0 + $700, the object
; tile area at tiles $70-$7F, together with a CGB object palette. Render: a four-point sparkle star,
; then several thin curved streaks and crescent pieces and one small diagonal tick, grey on white;
; no letters. It is a sibling of the other two $7E sprite sheets loaded by the same routine
; (SpawnScriptSpriteInFrontOfPlayer_Data and StarBurstDebrisSpriteTiles). Its use is from the loader
; only: SpawnScriptSpriteInFrontOfPlayer has no caller in src/ or the listing, so this sheet is
; probably never loaded in the shipped game. (C1, E-0383)
; LZSS-compressed: 92 bytes that expand to 256 (E-0016, E-0017)
SparkleAndCurvedStreakTiles::
    INCBIN "gfx/misc/sparkle_and_curved_streak_tiles.lz"

; 16 bytes copied into a palette buffer by CopyFromBank, CopyBytesDEToHL_Bank00 or
; LoadBGPaletteBufferFromBank (E-0164)
; record: one CGB palette: 4 BGR555 colours
OBJPaletteBufferPlus8Data_3::
    dw $0000, $6bff, $0279, $0000 ; id 0
    dw $7c00, $7c00, $7c00, $7c00 ; id 1
    db $00, $7c, $00, $7c, $00, $7c, $00, $7c

; LZSS-compressed: 25 bytes that expand to 256 (E-0016, E-0017)
Tiles0Plus100Gfx::
    db $00, $01, $01, $50, $50, $f8, $a8, $f8, $88, $f8, $a8, $d8, $d8, $01, $a0, $ff
    db $4d, $01, $69, $0f, $4d, $01, $c9, $0f, $23

; LZSS-compressed: 31 bytes that expand to 256 (E-0016, E-0017)
Tiles0Plus100Gfx_2::
    db $00, $01, $01, $10, $10, $38, $28, $7c, $44, $fe, $82, $fe, $82, $7c, $44, $38
    db $28, $10, $10, $01, $a0, $ff, $4d, $01, $6f, $0f, $4d, $01, $cf, $0f, $1d

; LZSS-compressed: 29 bytes that expand to 256 (E-0016, E-0017)
Tiles0Plus200Gfx::
    db $00, $01, $01, $d6, $d6, $fe, $aa, $fe, $82, $01, $04, $01, $ba, $ee, $aa, $ee
    db $ee, $01, $a0, $ff, $4d, $01, $6f, $0f, $4d, $01, $cf, $0f, $1d

; Tiles, 512 bytes decompressed (32 tiles, only tiles 0-3 are not blank). Decompressed by
; DrawTitleSaveSummaryScreen to vTiles0 (object tile area, tile 0 up), followed on CGB by an 8-byte
; object palette copy (DrawTitleSaveSummaryScreen_OBJPaletteBufferData) and the title save-summary
; drawing (DrawTitleSaveSummaryScreen_DrawSummary). Render: two small black and grey pixel shapes in
; tiles 0-3, one crown or bat-like shape and one rounded helmet or beetle-like shape, each two tiles
; wide, nothing else. Not identified: the shapes are too small to name, and
; DrawTitleSaveSummaryScreen has no caller in src/ or the listing (the live path is
; DecompressA4GraphicsAndContinue, which loads graphics $A4 instead and falls into the same summary
; drawing), so no screen is known to show them. (C1, E-0383)
; LZSS-compressed: 85 bytes that expand to 512 (E-0016, E-0017)
Tiles0Gfx_3::
    INCBIN "gfx/misc/tiles0_gfx_3.lz"

; 8 bytes copied into a palette buffer by CopyFromBank, CopyBytesDEToHL_Bank00 or
; LoadBGPaletteBufferFromBank (E-0164)
; record: one CGB palette: 4 BGR555 colours
DrawTitleSaveSummaryScreen_OBJPaletteBufferData::
    dw $0000, $3d7d, $2011, $0000 ; id 0
    ds $2440, $00
