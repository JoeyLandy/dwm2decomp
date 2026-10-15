; ROM bank $7E: field graphics, sprites and palettes
; The annotated listing of this bank is build/listing/bank7e.asm.

SECTION "Bank 7E", ROMX[$4000], BANK[$7E]
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
; another name for the data at SharedOBJPalettes, whose note is above (E-0381)
LoadPlayerAndFollowerSpriteGraphics_OBJPaletteBufferData::
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

; LZSS-compressed: 66 bytes that expand to 64 (E-0016, E-0017)
Gfx_TriggerSpriteTable_5::
    INCBIN "gfx/misc/gfx_trigger_sprite_table_5.lz"

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

Gfx_TriggerSpriteTable_8::
    INCBIN "gfx/misc/gfx_trigger_sprite_table_8.lz"

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

; LZSS-compressed: 65 bytes that expand to 64 (E-0016, E-0017)
Tiles0Plus300Gfx::
    INCBIN "gfx/misc/tiles0_plus300_gfx.lz"

; LZSS-compressed: 67 bytes that expand to 64 (E-0016, E-0017)
Gfx_FieldCommandSpriteTable_15::
    INCBIN "gfx/misc/gfx_field_command_sprite_table_15.lz"

; LZSS-compressed: 66 bytes that expand to 64 (E-0016, E-0017)
Gfx7E_1::
    INCBIN "gfx/misc/gfx7_e_1.lz"

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

Gfx7E_2::
    INCBIN "gfx/misc/gfx7_e_2.lz"

Gfx7E_3::
    INCBIN "gfx/misc/gfx7_e_3.lz"

; LZSS-compressed: 61 bytes that expand to 64 (E-0016, E-0017)
Gfx_FieldCommandSpriteTable_9::
    db $40, $00, $02, $02, $ff, $f2, $1f, $1f, $17, $18, $0d, $0e, $0b, $0f, $05, $07
    db $02, $ff, $f2, $80, $80, $60, $e0, $b0, $50, $68, $98, $b8, $c8, $03, $03, $01
    db $01, $1c, $1c, $3e, $22, $7a, $4e, $47, $7f, $3b, $3a, $01, $01, $44, $fc, $e4
    db $fc, $e8, $f8, $9b, $fb, $55, $77, $33, $33, $80, $80, $80, $80

; LZSS-compressed: 128 bytes that expand to 128 (E-0016, E-0017)
Gfx7E_4::
    INCBIN "gfx/misc/gfx7_e_4.lz"

; LZSS-compressed: 221 bytes that expand to 256 (E-0016, E-0017)
Gfx_FieldCommandSpriteTable_6::
    INCBIN "gfx/misc/gfx_field_command_sprite_table_6.lz"

; LZSS-compressed: 55 bytes that expand to 64 (E-0016, E-0017)
Gfx7E_5::
    db $40, $00, $01, $00, $00, $1f, $1f, $3f, $20, $7f, $40, $01, $06, $01, $49, $7f
    db $40, $00, $00, $f0, $f0, $f8, $08, $fc, $04, $01, $16, $01, $24, $fc, $04, $01
    db $06, $00, $3f, $20, $1f, $13, $1c, $14, $18, $18, $01, $fe, $f0, $01, $16, $00
    db $f8, $08, $f0, $f0, $01, $a0, $f4

Tiles0Plus600Gfx::
    db $40, $00, $01, $00, $00, $1f, $1f, $3f, $20, $7d, $43, $7f, $43, $7d, $43, $7f
    db $41, $7f, $40, $00, $00, $f0, $f0, $f8, $08, $7c, $84, $fc, $84, $7c, $84, $fc
    db $04, $fc, $04, $7d, $43, $7d, $43, $3f, $20, $1f, $13, $1c, $14, $18, $18, $01
    db $fe, $f0, $7c, $84, $7c, $84, $f8, $08, $f0, $f0, $01, $a0, $f4

; LZSS-compressed: 119 bytes that expand to 128 (E-0016, E-0017)
Gfx_FieldCommandSpriteTable_7::
    INCBIN "gfx/misc/gfx_field_command_sprite_table_7.lz"

; LZSS-compressed: 170 bytes that expand to 192 (E-0016, E-0017)
Gfx_FieldCommandSpriteTable_12::
    INCBIN "gfx/misc/gfx_field_command_sprite_table_12.lz"

; LZSS-compressed: 68 bytes that expand to 80 (E-0016, E-0017)
Gfx_FieldCommandSpriteTable_18::
    INCBIN "gfx/misc/gfx_field_command_sprite_table_18.lz"

; LZSS-compressed: 181 bytes that expand to 192 (E-0016, E-0017)
LoadPlayerAndFollowerSpriteGraphics_Followers_Data::
    INCBIN "gfx/misc/load_player_and_follower_sprite_graphics_followers_data.lz"

; LZSS-compressed: 130 bytes that expand to 128 (E-0016, E-0017)
Gfx_FieldCommandSpriteTable_11::
    INCBIN "gfx/misc/gfx_field_command_sprite_table_11.lz"

; LZSS-compressed: 171 bytes that expand to 192 (E-0016, E-0017)
Tiles0Plus700Gfx::
    INCBIN "gfx/misc/tiles0_plus700_gfx.lz"

; LZSS-compressed: 131 bytes that expand to 128 (E-0016, E-0017)
Gfx7E_6::
    INCBIN "gfx/misc/gfx7_e_6.lz"

; LZSS-compressed: 67 bytes that expand to 64 (E-0016, E-0017)
Gfx_FieldCommandSpriteTable_3::
    INCBIN "gfx/misc/gfx_field_command_sprite_table_3.lz"

; LZSS-compressed: 80 bytes that expand to 96 (E-0016, E-0017)
Tiles0Plus100Gfx::
    INCBIN "gfx/misc/tiles0_plus100_gfx.lz"

; LZSS-compressed: 282 bytes that expand to 512 (E-0016, E-0017)
Gfx_FieldCommandSpriteTable_13::
    INCBIN "gfx/misc/gfx_field_command_sprite_table_13.lz"

; LZSS-compressed: 143 bytes that expand to 512 (E-0016, E-0017)
Gfx_FieldCommandSpriteTable_20::
    INCBIN "gfx/misc/gfx_field_command_sprite_table_20.lz"

; LZSS-compressed: 75 bytes that expand to 256 (E-0016, E-0017)
Tiles0Plus700Gfx_2::
    INCBIN "gfx/misc/tiles0_plus700_gfx_2.lz"

; LZSS-compressed: 74 bytes that expand to 256 (E-0016, E-0017)
Tiles0Plus700Gfx_3::
    INCBIN "gfx/misc/tiles0_plus700_gfx_3.lz"

; LZSS-compressed: 129 bytes that expand to 256 (E-0016, E-0017)
Gfx7E_7::
    INCBIN "gfx/misc/gfx7_e_7.lz"

; LZSS-compressed: 133 bytes that expand to 256 (E-0016, E-0017)
SpawnScriptSpriteInFrontOfPlayer_Data::
    INCBIN "gfx/misc/spawn_script_sprite_in_front_of_player_data.lz"

; LZSS-compressed: 92 bytes that expand to 256 (E-0016, E-0017)
Tiles0Plus700Gfx_4::
    INCBIN "gfx/misc/tiles0_plus700_gfx_4.lz"

; 16 bytes copied into a palette buffer by CopyFromBank, CopyBytesDEToHL_Bank00 or
; LoadBGPaletteBufferFromBank (E-0164)
; record: one CGB palette: 4 BGR555 colours
Palettes_7E::
; another name for the data at Palettes_7E, whose note is above (E-0381)
OBJPaletteBufferPlus8Data_3::
    dw $0000, $6bff, $0279, $0000 ; id 0
    dw $7c00, $7c00, $7c00, $7c00 ; id 1
    db $00, $7c, $00, $7c, $00, $7c, $00, $7c

; LZSS-compressed: 25 bytes that expand to 256 (E-0016, E-0017)
Tiles0Plus100Gfx_2::
    db $00, $01, $01, $50, $50, $f8, $a8, $f8, $88, $f8, $a8, $d8, $d8, $01, $a0, $ff
    db $4d, $01, $69, $0f, $4d, $01, $c9, $0f, $23

; LZSS-compressed: 31 bytes that expand to 256 (E-0016, E-0017)
Tiles0Plus100Gfx_3::
    db $00, $01, $01, $10, $10, $38, $28, $7c, $44, $fe, $82, $fe, $82, $7c, $44, $38
    db $28, $10, $10, $01, $a0, $ff, $4d, $01, $6f, $0f, $4d, $01, $cf, $0f, $1d

; LZSS-compressed: 29 bytes that expand to 256 (E-0016, E-0017)
Tiles0Plus200Gfx::
    db $00, $01, $01, $d6, $d6, $fe, $aa, $fe, $82, $01, $04, $01, $ba, $ee, $aa, $ee
    db $ee, $01, $a0, $ff, $4d, $01, $6f, $0f, $4d, $01, $cf, $0f, $1d

; LZSS-compressed: 85 bytes that expand to 512 (E-0016, E-0017)
Tiles0Gfx_3::
    INCBIN "gfx/misc/tiles0_gfx_3.lz"

; 8 bytes copied into a palette buffer by CopyFromBank, CopyBytesDEToHL_Bank00 or
; LoadBGPaletteBufferFromBank (E-0164)
; record: one CGB palette: 4 BGR555 colours
Palettes_7E_2::
; another name for the data at Palettes_7E_2, whose note is above (E-0381)
DrawTitleSaveSummaryScreen_OBJPaletteBufferData::
    dw $0000, $3d7d, $2011, $0000 ; id 0
    ds $2440, $00
