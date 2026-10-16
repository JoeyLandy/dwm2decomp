; ROM bank $79: compressed monster pictures
; The annotated listing of this bank is build/listing/bank79.asm.

SECTION "Bank 79", ROMX
    db $79

; compressed 6 x 6 picture (36 tiles) of monster id $103 (Reaper) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 265 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Reaper::
    INCBIN "gfx/monster_pics/reaper.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $104 (Inverzon) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 363 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Inverzon::
    INCBIN "gfx/monster_pics/inverzon.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $105 (FoxFire) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 398 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_FoxFire::
    INCBIN "gfx/monster_pics/fox_fire.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $106 (CaptDead) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 463 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_CaptDead::
    INCBIN "gfx/monster_pics/capt_dead.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $107 (DeadNoble) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 501 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_DeadNoble::
    INCBIN "gfx/monster_pics/dead_noble.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $108 (WhiteKing) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 350 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_WhiteKing::
    INCBIN "gfx/monster_pics/white_king.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $109 (BoneSlave) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 352 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_BoneSlave::
    INCBIN "gfx/monster_pics/bone_slave.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $10A (Skeletor) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 471 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Skeletor::
    INCBIN "gfx/monster_pics/skeletor.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $10B (Servant) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 490 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Servant::
    INCBIN "gfx/monster_pics/servant.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $10C (Lazamanus) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 477 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Lazamanus::
    INCBIN "gfx/monster_pics/lazamanus.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $10D (Copycat) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 141 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Copycat::
    INCBIN "gfx/monster_pics/copycat.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $10E (MadSpirit) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 227 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_MadSpirit::
    INCBIN "gfx/monster_pics/mad_spirit.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $10F (PomPomBom) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 294 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_PomBom::
    INCBIN "gfx/monster_pics/pom_bom.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $110 (Niterich) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 422 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Niterich::
    INCBIN "gfx/monster_pics/niterich.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $119 (JewelBag) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 353 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_JewelBag::
    INCBIN "gfx/monster_pics/jewel_bag.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $11A (EvilWand) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 186 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_EvilWand::
    INCBIN "gfx/monster_pics/evil_wand.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $11B (MadCandle) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 204 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_MadCandle::
    INCBIN "gfx/monster_pics/mad_candle.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $11C (CoilBird) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 375 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_CoilBird::
    INCBIN "gfx/monster_pics/coil_bird.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $11D (Facer) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 274 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Facer::
    INCBIN "gfx/monster_pics/facer.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $11E (SpikyBoy) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 233 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_SpikyBoy::
    INCBIN "gfx/monster_pics/spiky_boy.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $11F (MadMirror) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 339 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_MadMirror::
    INCBIN "gfx/monster_pics/mad_mirror.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $120 (RogueNite) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 384 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_RogueNite::
    INCBIN "gfx/monster_pics/rogue_nite.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $121 (Puppetor) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 333 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Puppetor::
    INCBIN "gfx/monster_pics/puppetor.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $122 (Goopi) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 208 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Goopi::
    INCBIN "gfx/monster_pics/goopi.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $123 (Voodoll) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 306 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Voodoll::
    INCBIN "gfx/monster_pics/voodoll.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $124 (MetalDrak) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 500 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_MetalDrak::
    INCBIN "gfx/monster_pics/metal_drak.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $125 (Balzak) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 480 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Balzak::
    INCBIN "gfx/monster_pics/balzak.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $126 (SabreMan) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 187 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_SabreMan::
    INCBIN "gfx/monster_pics/sabre_man.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $127 (CurseLamp) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 245 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_CurseLamp::
    INCBIN "gfx/monster_pics/curse_lamp.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $128 (Brushead) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 390 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Brushead::
    INCBIN "gfx/monster_pics/brushead.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $129 (Roboster) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 438 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Roboster::
    INCBIN "gfx/monster_pics/roboster.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $12A (Roboster2) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 450 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Roboster2::
    INCBIN "gfx/monster_pics/roboster2.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $12B (EvilPot) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 253 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_EvilPot::
    INCBIN "gfx/monster_pics/evil_pot.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $12C (Gismo) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 236 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Gismo::
    INCBIN "gfx/monster_pics/gismo.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $12D (LavaMan) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 330 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_LavaMan::
    INCBIN "gfx/monster_pics/lava_man.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $12E (IceMan) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 329 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_IceMan::
    INCBIN "gfx/monster_pics/ice_man.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $12F (Mimic) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 244 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Mimic::
    INCBIN "gfx/monster_pics/mimic.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $130 (Exaucers) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 362 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Exaucers::
    INCBIN "gfx/monster_pics/exaucers.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $131 (MudDoll) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 275 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_MudDoll::
    INCBIN "gfx/monster_pics/mud_doll.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $132 (Golem) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 462 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Golem::
    INCBIN "gfx/monster_pics/golem.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $133 (StoneMan) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 372 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_StoneMan::
    INCBIN "gfx/monster_pics/stone_man.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $134 (BombCrag) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 277 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_BombCrag::
    INCBIN "gfx/monster_pics/bomb_crag.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $135 (GoldGolem) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 547 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_GoldGolem::
    INCBIN "gfx/monster_pics/gold_golem.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $136 (DarkMate) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 497 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_DarkMate::
    INCBIN "gfx/monster_pics/dark_mate.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $137 (ProtoMech) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 407 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_ProtoMech::
    INCBIN "gfx/monster_pics/proto_mech.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $138 (CloudKing) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 477 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_CloudKing::
    INCBIN "gfx/monster_pics/cloud_king.lz"
    ds $d9, $00
