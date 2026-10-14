; ROM bank $74: compressed monster pictures
; The annotated listing of this bank is build/listing/bank74.asm.

SECTION "Bank 74", ROMX[$4000], BANK[$74]
    db $74

; compressed 6 x 6 picture (36 tiles) of monster id $001 (DrakSlime); 67 other ids point here too
; (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed: 240 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_DrakSlime::
    INCBIN "gfx/monster_pics/drak_slime.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $002 (SpotSlime); 1 other ids point here too
; (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed: 145 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_SpotSlime::
    INCBIN "gfx/monster_pics/spot_slime.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $003 (WingSlime) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 290 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_WingSlime::
    INCBIN "gfx/monster_pics/wing_slime.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $004 (TreeSlime) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 163 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_TreeSlime::
    INCBIN "gfx/monster_pics/tree_slime.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $005 (Snaily) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 183 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Snaily::
    INCBIN "gfx/monster_pics/snaily.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $006 (SlimeNite) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 251 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_SlimeNite::
    INCBIN "gfx/monster_pics/slime_nite.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $007 (Babble) (MonsterPictureTable /
; MonsterAttributeMapTable) (E-0138)
MonsterPic_Babble::
    INCBIN "gfx/monster_pics/babble.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $008 (BoxSlime) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 182 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_BoxSlime::
    INCBIN "gfx/monster_pics/box_slime.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $009 (PearlGel) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 265 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_PearlGel::
    INCBIN "gfx/monster_pics/pearl_gel.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $00A (Slime) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 101 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Slime::
    INCBIN "gfx/monster_pics/slime.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $00B (Healer) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 156 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Healer::
    INCBIN "gfx/monster_pics/healer.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $00C (FangSlime) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 231 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_FangSlime::
    INCBIN "gfx/monster_pics/fang_slime.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $00D (RockSlime) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 148 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_RockSlime::
    INCBIN "gfx/monster_pics/rock_slime.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $00E (SlimeBorg) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 172 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_SlimeBorg::
    INCBIN "gfx/monster_pics/slime_borg.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $00F (Slabbit) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 196 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Slabbit::
    INCBIN "gfx/monster_pics/slabbit.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $010 (KingSlime) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 328 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_KingSlime::
    INCBIN "gfx/monster_pics/king_slime.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $011 (Metaly) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 101 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Metaly::
    INCBIN "gfx/monster_pics/metaly.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $012 (Metabble) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 183 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Metabble::
    INCBIN "gfx/monster_pics/metabble.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $013 (SpotKing) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 358 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_SpotKing::
    INCBIN "gfx/monster_pics/spot_king.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $014 (TropicGel) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 217 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_TropicGel::
    INCBIN "gfx/monster_pics/tropic_gel.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $015 (MimeSlime) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 266 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_MimeSlime::
    INCBIN "gfx/monster_pics/mime_slime.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $016 (HaloSlime) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 171 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_HaloSlime::
    INCBIN "gfx/monster_pics/halo_slime.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $017 (MetalKing) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 329 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_MetalKing::
    INCBIN "gfx/monster_pics/metal_king.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $018 (GoldSlime) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 491 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_GoldSlime::
    INCBIN "gfx/monster_pics/gold_slime.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $019 (GranSlime) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 509 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_GranSlime::
    INCBIN "gfx/monster_pics/gran_slime.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $01A (WonderEgg) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 142 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_WonderEgg::
    INCBIN "gfx/monster_pics/wonder_egg.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $024 (DragonKid) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 302 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_DragonKid::
    INCBIN "gfx/monster_pics/dragon_kid.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $025 (Tortragon) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 380 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Tortragon::
    INCBIN "gfx/monster_pics/tortragon.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $026 (Pteranod) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 342 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Pteranod::
    INCBIN "gfx/monster_pics/pteranod.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $027 (Gasgon) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 437 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Gasgon::
    INCBIN "gfx/monster_pics/gasgon.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $028 (FairyDrak) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 301 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_FairyDrak::
    INCBIN "gfx/monster_pics/fairy_drak.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $029 (LizardMan) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 478 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_LizardMan::
    INCBIN "gfx/monster_pics/lizard_man.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $02A (Poisongon) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 384 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Poisongon::
    INCBIN "gfx/monster_pics/poisongon.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $02B (Swordgon) (MonsterPictureTable /
; MonsterAttributeMapTable) (E-0138)
MonsterPic_Swordgon::
    INCBIN "gfx/monster_pics/swordgon.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $02C (Drygon) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 461 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Drygon::
    INCBIN "gfx/monster_pics/drygon.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $02D (Dragon) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 382 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Dragon::
    INCBIN "gfx/monster_pics/dragon.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $02E (MiniDrak) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 236 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_MiniDrak::
    INCBIN "gfx/monster_pics/mini_drak.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $02F (MadDragon) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 495 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_MadDragon::
    INCBIN "gfx/monster_pics/mad_dragon.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $030 (Rayburn) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 432 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Rayburn::
    INCBIN "gfx/monster_pics/rayburn.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $031 (Chamelgon) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 287 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Chamelgon::
    INCBIN "gfx/monster_pics/chamelgon.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $032 (LizardFly) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 384 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_LizardFly::
    INCBIN "gfx/monster_pics/lizard_fly.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $033 (Andreal) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 460 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Andreal::
    INCBIN "gfx/monster_pics/andreal.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $034 (KingCobra) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 240 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_KingCobra::
    INCBIN "gfx/monster_pics/king_cobra.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $035 (Vampirus) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 444 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Vampirus::
    INCBIN "gfx/monster_pics/vampirus.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $036 (SnakeBat) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 356 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_SnakeBat::
    INCBIN "gfx/monster_pics/snake_bat.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $037 (Spikerous) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 320 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Spikerous::
    INCBIN "gfx/monster_pics/spikerous.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $038 (GreatDrak) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 529 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_GreatDrak::
    INCBIN "gfx/monster_pics/great_drak.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $039 (Crestpent) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 376 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Crestpent::
    INCBIN "gfx/monster_pics/crestpent.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $03A (WingSnake) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 479 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_WingSnake::
    INCBIN "gfx/monster_pics/wing_snake.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $03B (Coatol) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 460 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Coatol::
    INCBIN "gfx/monster_pics/coatol.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $03C (Orochi) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 449 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Orochi::
    INCBIN "gfx/monster_pics/orochi.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $03D (BattleRex) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 416 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_BattleRex::
    INCBIN "gfx/monster_pics/battle_rex.lz"
    ds $4a, $00
