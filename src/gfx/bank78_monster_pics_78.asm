; ROM bank $78: compressed monster pictures
; The annotated listing of this bank is build/listing/bank78.asm.

SECTION "Bank 78", ROMX
    db $78

; compressed 6 x 6 picture (36 tiles) of monster id $0D3 (Pixy) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 244 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Pixy::
    INCBIN "gfx/monster_pics/pixy.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0D4 (MedusaEye) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 262 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_MedusaEye::
    INCBIN "gfx/monster_pics/medusa_eye.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0D5 (AgDevil) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 374 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_AgDevil::
    INCBIN "gfx/monster_pics/ag_devil.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0D6 (Demonite) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 273 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Demonite::
    INCBIN "gfx/monster_pics/demonite.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0D7 (DarkEye) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 254 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_DarkEye::
    INCBIN "gfx/monster_pics/dark_eye.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0D8 (EyeBall) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 215 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_EyeBall::
    INCBIN "gfx/monster_pics/eye_ball.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0D9 (SkulRider) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 337 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_SkulRider::
    INCBIN "gfx/monster_pics/skul_rider.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0DA (EvilBeast) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 462 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_EvilBeast::
    INCBIN "gfx/monster_pics/evil_beast.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0DB (Bubblemon) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 434 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Bubblemon::
    INCBIN "gfx/monster_pics/bubblemon.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0DC (1EyeClown) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 305 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_1EyeClown::
    INCBIN "gfx/monster_pics/1_eye_clown.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0DD (Gremlin) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 214 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Gremlin::
    INCBIN "gfx/monster_pics/gremlin.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0DE (ArcDemon) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 462 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_ArcDemon::
    INCBIN "gfx/monster_pics/arc_demon.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0DF (Lionex) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 516 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Lionex::
    INCBIN "gfx/monster_pics/lionex.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0E0 (GoatHorn) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 421 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_GoatHorn::
    INCBIN "gfx/monster_pics/goat_horn.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0E1 (Orc) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 359 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Orc::
    INCBIN "gfx/monster_pics/orc.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0E2 (Ogre) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 454 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Ogre::
    INCBIN "gfx/monster_pics/ogre.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0E3 (GateGuard) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 479 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_GateGuard::
    INCBIN "gfx/monster_pics/gate_guard.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0E4 (ChopClown) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 464 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_ChopClown::
    INCBIN "gfx/monster_pics/chop_clown.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0E5 (BossTroll) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 455 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_BossTroll::
    INCBIN "gfx/monster_pics/boss_troll.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0E6 (Grendal) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 481 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Grendal::
    INCBIN "gfx/monster_pics/grendal.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0E7 (Akubar) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 509 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Akubar::
    INCBIN "gfx/monster_pics/akubar.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0E8 (MadKnight) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 477 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_MadKnight::
    INCBIN "gfx/monster_pics/mad_knight.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0E9 (EvilWell) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 481 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_EvilWell::
    INCBIN "gfx/monster_pics/evil_well.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0EA (Gigantes) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 522 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Gigantes::
    INCBIN "gfx/monster_pics/gigantes.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0EB (Centasaur) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 416 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Centasaur::
    INCBIN "gfx/monster_pics/centasaur.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0EC (EvilArmor) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 456 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_EvilArmor::
    INCBIN "gfx/monster_pics/evil_armor.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0ED (Jamirus) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 484 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Jamirus::
    INCBIN "gfx/monster_pics/jamirus.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0EE (Durran) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 432 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Durran::
    INCBIN "gfx/monster_pics/durran.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0EF (Titanis) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 538 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Titanis::
    INCBIN "gfx/monster_pics/titanis.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0F0 (LampGenie) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 438 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_LampGenie::
    INCBIN "gfx/monster_pics/lamp_genie.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0F6 (Spooky) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 221 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Spooky::
    INCBIN "gfx/monster_pics/spooky.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0F7 (Skullgon) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 518 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Skullgon::
    INCBIN "gfx/monster_pics/skullgon.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0F8 (PutrePup) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 191 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_PutrePup::
    INCBIN "gfx/monster_pics/putre_pup.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0F9 (RotRaven) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 252 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_RotRaven::
    INCBIN "gfx/monster_pics/rot_raven.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0FA (Mummy) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 332 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Mummy::
    INCBIN "gfx/monster_pics/mummy.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0FB (DarkCrab) (MonsterPictureTable /
; MonsterAttributeMapTable) (E-0138)
MonsterPic_DarkCrab::
    INCBIN "gfx/monster_pics/dark_crab.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0FC (DeadNite) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 342 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_DeadNite::
    INCBIN "gfx/monster_pics/dead_nite.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0FD (Shadow) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 260 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Shadow::
    INCBIN "gfx/monster_pics/shadow.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0FE (Skulpent) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 234 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Skulpent::
    INCBIN "gfx/monster_pics/skulpent.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0FF (Hork) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 310 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Hork::
    INCBIN "gfx/monster_pics/hork.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $100 (Mudron) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 414 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Mudron::
    INCBIN "gfx/monster_pics/mudron.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $101 (NiteWhip) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 217 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_NiteWhip::
    INCBIN "gfx/monster_pics/nite_whip.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $102 (WindMerge) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 306 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_WindMerge::
    INCBIN "gfx/monster_pics/wind_merge.lz"
    ds $ec, $00
