; ROM bank $91: monster sprites and battle effect graphics
; The annotated listing of this bank is build/listing/bank91.asm.

SECTION "Bank 91", ROMX
    db $91

; compressed sprite graphics of monster id $15F (DracoLord) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 240 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_DracoLord::
    INCBIN "gfx/monster_sprites/draco_lord.lz"

; compressed sprite graphics of monster id $160 (DracoLord) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 246 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_DracoLord_160::
    INCBIN "gfx/monster_sprites/draco_lord_160.lz"

; compressed sprite graphics of monster id $161 (LordDraco) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 227 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_LordDraco::
    INCBIN "gfx/monster_sprites/lord_draco.lz"

; compressed sprite graphics of monster id $162 (Hargon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 237 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Hargon::
    INCBIN "gfx/monster_sprites/hargon.lz"

; compressed sprite graphics of monster id $163 (Sidoh) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 201 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Sidoh::
    INCBIN "gfx/monster_sprites/sidoh.lz"

; compressed sprite graphics of monster id $164 (Genosidoh) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 229 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Genosidoh::
    INCBIN "gfx/monster_sprites/genosidoh.lz"

; compressed sprite graphics of monster id $165 (Baramos) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 221 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Baramos::
    INCBIN "gfx/monster_sprites/baramos.lz"

; compressed sprite graphics of monster id $166 (Zoma) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 211 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Zoma::
    INCBIN "gfx/monster_sprites/zoma.lz"

; compressed sprite graphics of monster id $167 (AsuraZoma) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 199 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_AsuraZoma::
    INCBIN "gfx/monster_sprites/asura_zoma.lz"

; compressed sprite graphics of monster id $168 (Pizzaro) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 214 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Pizzaro::
    INCBIN "gfx/monster_sprites/pizzaro.lz"

; compressed sprite graphics of monster id $169 (PsychoPiz) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 226 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_PsychoPiz::
    INCBIN "gfx/monster_sprites/psycho_piz.lz"

; compressed sprite graphics of monster id $16A (Esterk) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 239 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Esterk::
    INCBIN "gfx/monster_sprites/esterk.lz"

; compressed sprite graphics of monster id $16B (Mirudraas) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 202 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Mirudraas::
    INCBIN "gfx/monster_sprites/mirudraas.lz"

; compressed sprite graphics of monster id $16C (Mirudraas) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 214 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Mirudraas_16C::
    INCBIN "gfx/monster_sprites/mirudraas_16_c.lz"

; compressed sprite graphics of monster id $16D (Mudou) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 236 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Mudou::
    INCBIN "gfx/monster_sprites/mudou.lz"

; compressed sprite graphics of monster id $16E (DeathMore) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200) (E-0138)
MonsterSprite_DeathMore::
    INCBIN "gfx/monster_sprites/death_more.lz"

; compressed sprite graphics of monster id $16F (DeathMore) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 248 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_DeathMore_16F::
    INCBIN "gfx/monster_sprites/death_more_16_f.lz"

; compressed sprite graphics of monster id $170 (DeathMore) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 183 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_DeathMore_170::
    INCBIN "gfx/monster_sprites/death_more_170.lz"

; compressed sprite graphics of monster id $171 (Darkdrium) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 255 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Darkdrium::
    INCBIN "gfx/monster_sprites/darkdrium.lz"

; compressed sprite graphics of monster id $172 (Orgodemir) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 222 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Orgodemir::
    INCBIN "gfx/monster_sprites/orgodemir.lz"

; compressed sprite graphics of monster id $173 (Orgodemir) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 230 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Orgodemir_173::
    INCBIN "gfx/monster_sprites/orgodemir_173.lz"

; compressed sprite graphics of monster id $174 (Darck) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 247 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Darck::
    INCBIN "gfx/monster_sprites/darck.lz"

; compressed battle effect graphics, entry 38 of BattleEffectGraphicsTable
; LZSS-compressed: 665 bytes that expand to 768 (E-0016, E-0017)
BattleEffectGfx26::
    INCBIN "gfx/battle_effects/26.lz"

; compressed battle effect graphics, entry 39 of BattleEffectGraphicsTable
; LZSS-compressed: 624 bytes that expand to 768 (E-0016, E-0017)
BattleEffectGfx27::
    INCBIN "gfx/battle_effects/27.lz"

; compressed battle effect graphics, entry 40 of BattleEffectGraphicsTable
; LZSS-compressed: 593 bytes that expand to 768 (E-0016, E-0017)
BattleEffectGfx28::
    INCBIN "gfx/battle_effects/28.lz"

; compressed battle effect graphics, entry 41 of BattleEffectGraphicsTable
; LZSS-compressed: 590 bytes that expand to 752 (E-0016, E-0017)
BattleEffectGfx29::
    INCBIN "gfx/battle_effects/29.lz"

; compressed battle effect graphics, entry 42 of BattleEffectGraphicsTable
; LZSS-compressed: 541 bytes that expand to 672 (E-0016, E-0017)
BattleEffectGfx2A::
    INCBIN "gfx/battle_effects/2_a.lz"

; compressed battle effect graphics, entry 43 of BattleEffectGraphicsTable
; LZSS-compressed: 506 bytes that expand to 544 (E-0016, E-0017)
BattleEffectGfx2B::
    INCBIN "gfx/battle_effects/2_b.lz"

; compressed battle effect graphics, entry 44 of BattleEffectGraphicsTable
; LZSS-compressed: 52 bytes that expand to 64 (E-0016, E-0017)
BattleEffectGfx2C::
    db $40, $00, $02, $02, $ff, $f7, $01, $02, $0a, $01, $02, $ff, $f0, $40, $40, $f0
    db $70, $f8, $f8, $fc, $9c, $fe, $8c, $fe, $01, $03, $01, $1f, $1f, $3f, $3f, $7f
    db $1e, $7f, $00, $3f, $02, $ff, $f0, $84, $de, $04, $ce, $00, $8c, $00, $84, $00
    db $80, $02, $a0, $f2

; compressed battle effect graphics, entry 45 of BattleEffectGraphicsTable
; LZSS-compressed: 641 bytes that expand to 768 (E-0016, E-0017)
BattleEffectGfx2D::
    INCBIN "gfx/battle_effects/2_d.lz"

; compressed battle effect graphics, entry 46 of BattleEffectGraphicsTable
; LZSS-compressed: 593 bytes that expand to 720 (E-0016, E-0017)
BattleEffectGfx2E::
    INCBIN "gfx/battle_effects/2_e.lz"

; compressed battle effect graphics, entry 47 of BattleEffectGraphicsTable
; LZSS-compressed: 685 bytes that expand to 768 (E-0016, E-0017)
BattleEffectGfx2F::
    INCBIN "gfx/battle_effects/2_f.lz"

; compressed battle effect graphics, entry 48 of BattleEffectGraphicsTable
; LZSS-compressed: 644 bytes that expand to 720 (E-0016, E-0017)
BattleEffectGfx30::
    INCBIN "gfx/battle_effects/30.lz"

; compressed battle effect graphics, entry 49 of BattleEffectGraphicsTable
; LZSS-compressed: 156 bytes that expand to 176 (E-0016, E-0017)
BattleEffectGfx31::
    INCBIN "gfx/battle_effects/31.lz"

; compressed battle effect graphics, entry 50 of BattleEffectGraphicsTable
; LZSS-compressed: 74 bytes that expand to 96 (E-0016, E-0017)
BattleEffectGfx32::
    INCBIN "gfx/battle_effects/32.lz"

; compressed battle effect graphics, entry 51 of BattleEffectGraphicsTable
; LZSS-compressed: 637 bytes that expand to 720 (E-0016, E-0017)
BattleEffectGfx33::
    INCBIN "gfx/battle_effects/33.lz"

; compressed battle effect graphics, entry 52 of BattleEffectGraphicsTable
; LZSS-compressed: 679 bytes that expand to 768 (E-0016, E-0017)
BattleEffectGfx34::
    INCBIN "gfx/battle_effects/34.lz"

; compressed battle effect graphics, entry 53 of BattleEffectGraphicsTable
; LZSS-compressed: 630 bytes that expand to 768 (E-0016, E-0017)
BattleEffectGfx35::
    INCBIN "gfx/battle_effects/35.lz"

; compressed battle effect graphics, entry 54 of BattleEffectGraphicsTable
; LZSS-compressed: 397 bytes that expand to 544 (E-0016, E-0017)
BattleEffectGfx36::
    INCBIN "gfx/battle_effects/36.lz"

; compressed battle effect graphics, entry 55 of BattleEffectGraphicsTable
; LZSS-compressed: 658 bytes that expand to 768 (E-0016, E-0017)
BattleEffectGfx37::
    INCBIN "gfx/battle_effects/37.lz"

; compressed battle effect graphics, entry 56 of BattleEffectGraphicsTable
; LZSS-compressed: 661 bytes that expand to 768 (E-0016, E-0017)
BattleEffectGfx38::
    INCBIN "gfx/battle_effects/38.lz"

; compressed battle effect graphics, entry 57 of BattleEffectGraphicsTable
; LZSS-compressed: 277 bytes that expand to 368 (E-0016, E-0017)
BattleEffectGfx39::
    INCBIN "gfx/battle_effects/39.lz"

; compressed battle effect graphics, entry 58 of BattleEffectGraphicsTable
; LZSS-compressed: 409 bytes that expand to 544 (E-0016, E-0017)
BattleEffectGfx3A::
    INCBIN "gfx/battle_effects/3_a.lz"

; compressed battle effect graphics, entry 59 of BattleEffectGraphicsTable
; LZSS-compressed: 554 bytes that expand to 768 (E-0016, E-0017)
BattleEffectGfx3B::
    INCBIN "gfx/battle_effects/3_b.lz"
    ds $b1, $00
