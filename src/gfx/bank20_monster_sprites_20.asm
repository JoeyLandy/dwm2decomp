; ROM bank $20: compressed monster sprites
; The annotated listing of this bank is build/listing/bank20.asm.

SECTION "Bank 20", ROMX[$4000], BANK[$20]
    db $20

; compressed sprite graphics of monster id $001 (DrakSlime); 68 other ids point here too
; (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed: 208 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_DrakSlime::
    INCBIN "gfx/monster_sprites/drak_slime.lz"

; compressed sprite graphics of monster id $002 (SpotSlime) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 233 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_SpotSlime::
    INCBIN "gfx/monster_sprites/spot_slime.lz"

; compressed sprite graphics of monster id $003 (WingSlime) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 186 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_WingSlime::
    INCBIN "gfx/monster_sprites/wing_slime.lz"

; compressed sprite graphics of monster id $004 (TreeSlime) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 175 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_TreeSlime::
    INCBIN "gfx/monster_sprites/tree_slime.lz"

; compressed sprite graphics of monster id $005 (Snaily) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 229 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Snaily::
    INCBIN "gfx/monster_sprites/snaily.lz"

; compressed sprite graphics of monster id $006 (SlimeNite) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 222 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_SlimeNite::
    INCBIN "gfx/monster_sprites/slime_nite.lz"

; compressed sprite graphics of monster id $007 (Babble) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 188 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Babble::
    INCBIN "gfx/monster_sprites/babble.lz"

; compressed sprite graphics of monster id $008 (BoxSlime) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 130 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_BoxSlime::
    INCBIN "gfx/monster_sprites/box_slime.lz"

; compressed sprite graphics of monster id $009 (PearlGel) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 192 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_PearlGel::
    INCBIN "gfx/monster_sprites/pearl_gel.lz"

; compressed sprite graphics of monster id $00A (Slime) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 102 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Slime::
    INCBIN "gfx/monster_sprites/slime.lz"

; compressed sprite graphics of monster id $00B (Healer) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 174 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Healer::
    INCBIN "gfx/monster_sprites/healer.lz"

; compressed sprite graphics of monster id $00C (FangSlime) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 225 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_FangSlime::
    INCBIN "gfx/monster_sprites/fang_slime.lz"

; compressed sprite graphics of monster id $00D (RockSlime) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 226 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_RockSlime::
    INCBIN "gfx/monster_sprites/rock_slime.lz"

; compressed sprite graphics of monster id $00E (SlimeBorg) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 195 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_SlimeBorg::
    INCBIN "gfx/monster_sprites/slime_borg.lz"

; compressed sprite graphics of monster id $00F (Slabbit) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 173 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Slabbit::
    INCBIN "gfx/monster_sprites/slabbit.lz"

; compressed sprite graphics of monster id $010 (KingSlime) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 184 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_KingSlime::
    INCBIN "gfx/monster_sprites/king_slime.lz"

; compressed sprite graphics of monster id $011 (Metaly) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 102 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Metaly::
    INCBIN "gfx/monster_sprites/metaly.lz"

; compressed sprite graphics of monster id $012 (Metabble) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 188 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Metabble::
    INCBIN "gfx/monster_sprites/metabble.lz"

; compressed sprite graphics of monster id $013 (SpotKing) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 226 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_SpotKing::
    INCBIN "gfx/monster_sprites/spot_king.lz"

; compressed sprite graphics of monster id $014 (TropicGel) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 209 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_TropicGel::
    INCBIN "gfx/monster_sprites/tropic_gel.lz"

; compressed sprite graphics of monster id $015 (MimeSlime) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 236 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MimeSlime::
    INCBIN "gfx/monster_sprites/mime_slime.lz"

; compressed sprite graphics of monster id $016 (HaloSlime) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 139 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_HaloSlime::
    INCBIN "gfx/monster_sprites/halo_slime.lz"

; compressed sprite graphics of monster id $017 (MetalKing) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 184 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MetalKing::
    INCBIN "gfx/monster_sprites/metal_king.lz"

; compressed sprite graphics of monster id $018 (GoldSlime) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 146 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_GoldSlime::
    INCBIN "gfx/monster_sprites/gold_slime.lz"

; compressed sprite graphics of monster id $019 (GranSlime) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 138 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_GranSlime::
    INCBIN "gfx/monster_sprites/gran_slime.lz"

; compressed sprite graphics of monster id $01A (WonderEgg) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 169 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_WonderEgg::
    INCBIN "gfx/monster_sprites/wonder_egg.lz"

; compressed sprite graphics of monster id $024 (DragonKid) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 200 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_DragonKid::
    INCBIN "gfx/monster_sprites/dragon_kid.lz"

; compressed sprite graphics of monster id $025 (Tortragon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 228 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Tortragon::
    INCBIN "gfx/monster_sprites/tortragon.lz"

; compressed sprite graphics of monster id $026 (Pteranod) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 221 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Pteranod::
    INCBIN "gfx/monster_sprites/pteranod.lz"

; compressed sprite graphics of monster id $027 (Gasgon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 246 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Gasgon::
    INCBIN "gfx/monster_sprites/gasgon.lz"

; compressed sprite graphics of monster id $028 (FairyDrak) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 222 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_FairyDrak::
    INCBIN "gfx/monster_sprites/fairy_drak.lz"

; compressed sprite graphics of monster id $029 (LizardMan) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 237 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_LizardMan::
    INCBIN "gfx/monster_sprites/lizard_man.lz"

; compressed sprite graphics of monster id $02A (Poisongon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 245 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Poisongon::
    INCBIN "gfx/monster_sprites/poisongon.lz"

; compressed sprite graphics of monster id $02B (Swordgon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 242 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Swordgon::
    INCBIN "gfx/monster_sprites/swordgon.lz"

; compressed sprite graphics of monster id $02C (Drygon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 238 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Drygon::
    INCBIN "gfx/monster_sprites/drygon.lz"

; compressed sprite graphics of monster id $02D (Dragon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 213 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Dragon::
    INCBIN "gfx/monster_sprites/dragon.lz"

; compressed sprite graphics of monster id $02E (MiniDrak) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 230 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MiniDrak::
    INCBIN "gfx/monster_sprites/mini_drak.lz"

; compressed sprite graphics of monster id $02F (MadDragon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 252 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MadDragon::
    INCBIN "gfx/monster_sprites/mad_dragon.lz"

; compressed sprite graphics of monster id $030 (Rayburn) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 231 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Rayburn::
    INCBIN "gfx/monster_sprites/rayburn.lz"

; compressed sprite graphics of monster id $031 (Chamelgon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 208 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Chamelgon::
    INCBIN "gfx/monster_sprites/chamelgon.lz"

; compressed sprite graphics of monster id $032 (LizardFly) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 194 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_LizardFly::
    INCBIN "gfx/monster_sprites/lizard_fly.lz"

; compressed sprite graphics of monster id $033 (Andreal) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 231 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Andreal::
    INCBIN "gfx/monster_sprites/andreal.lz"

; compressed sprite graphics of monster id $034 (KingCobra) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
MonsterSprite_KingCobra::
    INCBIN "gfx/monster_sprites/king_cobra.lz"

; compressed sprite graphics of monster id $035 (Vampirus) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 203 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Vampirus::
    INCBIN "gfx/monster_sprites/vampirus.lz"

; compressed sprite graphics of monster id $036 (SnakeBat) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 194 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_SnakeBat::
    INCBIN "gfx/monster_sprites/snake_bat.lz"

; compressed sprite graphics of monster id $037 (Spikerous) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 228 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Spikerous::
    INCBIN "gfx/monster_sprites/spikerous.lz"

; compressed sprite graphics of monster id $038 (GreatDrak) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 239 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_GreatDrak::
    INCBIN "gfx/monster_sprites/great_drak.lz"

; compressed sprite graphics of monster id $039 (Crestpent) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 236 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Crestpent::
    INCBIN "gfx/monster_sprites/crestpent.lz"

; compressed sprite graphics of monster id $03A (WingSnake) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 216 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_WingSnake::
    INCBIN "gfx/monster_sprites/wing_snake.lz"

; compressed sprite graphics of monster id $03B (Coatol) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 238 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Coatol::
    INCBIN "gfx/monster_sprites/coatol.lz"

; compressed sprite graphics of monster id $03C (Orochi) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 245 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Orochi::
    INCBIN "gfx/monster_sprites/orochi.lz"

; compressed sprite graphics of monster id $03D (BattleRex) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 232 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_BattleRex::
    INCBIN "gfx/monster_sprites/battle_rex.lz"

; compressed sprite graphics of monster id $03E (SkyDragon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 255 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_SkyDragon::
    INCBIN "gfx/monster_sprites/sky_dragon.lz"

; compressed sprite graphics of monster id $03F (Serpentia) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 245 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Serpentia::
    INCBIN "gfx/monster_sprites/serpentia.lz"

; compressed sprite graphics of monster id $040 (Divinegon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
MonsterSprite_Divinegon::
    INCBIN "gfx/monster_sprites/divinegon.lz"

; compressed sprite graphics of monster id $041 (Orligon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 227 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Orligon::
    INCBIN "gfx/monster_sprites/orligon.lz"

; compressed sprite graphics of monster id $042 (GigaDraco) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 239 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_GigaDraco::
    INCBIN "gfx/monster_sprites/giga_draco.lz"

; compressed sprite graphics of monster id $047 (Tonguella) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 232 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Tonguella::
    INCBIN "gfx/monster_sprites/tonguella.lz"

; compressed sprite graphics of monster id $048 (Almiraj) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 234 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Almiraj::
    INCBIN "gfx/monster_sprites/almiraj.lz"

; compressed sprite graphics of monster id $049 (CatFly) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 220 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_CatFly::
    INCBIN "gfx/monster_sprites/cat_fly.lz"

; compressed sprite graphics of monster id $04A (PillowRat) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 203 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_PillowRat::
    INCBIN "gfx/monster_sprites/pillow_rat.lz"

; compressed sprite graphics of monster id $04B (Saccer) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 168 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Saccer::
    INCBIN "gfx/monster_sprites/saccer.lz"

; compressed sprite graphics of monster id $04C (GulpBeast) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 243 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_GulpBeast::
    INCBIN "gfx/monster_sprites/gulp_beast.lz"

; compressed sprite graphics of monster id $04D (Skullroo) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 225 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Skullroo::
    INCBIN "gfx/monster_sprites/skullroo.lz"

; compressed sprite graphics of monster id $04E (WindBeast) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 253 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_WindBeast::
    INCBIN "gfx/monster_sprites/wind_beast.lz"

; compressed sprite graphics of monster id $04F (Beavern) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 218 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Beavern::
    INCBIN "gfx/monster_sprites/beavern.lz"

; compressed sprite graphics of monster id $050 (Antbear) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 222 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Antbear::
    INCBIN "gfx/monster_sprites/antbear.lz"

; compressed sprite graphics of monster id $051 (SuperTen) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 252 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_SuperTen::
    INCBIN "gfx/monster_sprites/super_ten.lz"

; compressed sprite graphics of monster id $052 (IronTurt) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 247 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_IronTurt::
    INCBIN "gfx/monster_sprites/iron_turt.lz"

; compressed sprite graphics of monster id $053 (Mommonja) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 230 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Mommonja::
    INCBIN "gfx/monster_sprites/mommonja.lz"

; compressed sprite graphics of monster id $054 (HammerMan) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 185 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_HammerMan::
    INCBIN "gfx/monster_sprites/hammer_man.lz"

; compressed sprite graphics of monster id $055 (Grizzly) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 214 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Grizzly::
    INCBIN "gfx/monster_sprites/grizzly.lz"

; compressed sprite graphics of monster id $056 (Yeti) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 212 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Yeti::
    INCBIN "gfx/monster_sprites/yeti.lz"

; compressed sprite graphics of monster id $057 (ArrowDog) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 216 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_ArrowDog::
    INCBIN "gfx/monster_sprites/arrow_dog.lz"

; compressed sprite graphics of monster id $058 (NoctoKing) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 177 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_NoctoKing::
    INCBIN "gfx/monster_sprites/nocto_king.lz"

; compressed sprite graphics of monster id $059 (BeastNite) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 232 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_BeastNite::
    INCBIN "gfx/monster_sprites/beast_nite.lz"
    ds $12c, $00
