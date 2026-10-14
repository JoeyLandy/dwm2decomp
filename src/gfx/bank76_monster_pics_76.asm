; ROM bank $76: compressed monster pictures
; The annotated listing of this bank is build/listing/bank76.asm.

SECTION "Bank 76", ROMX[$4000], BANK[$76]
    db $76

; compressed 6 x 6 picture (36 tiles) of monster id $06F (MadPecker) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 281 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_MadPecker::
    INCBIN "gfx/monster_pics/mad_pecker.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $070 (MadRaven) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 261 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_MadRaven::
    INCBIN "gfx/monster_pics/mad_raven.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $071 (MistyWing) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 221 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_MistyWing::
    INCBIN "gfx/monster_pics/misty_wing.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $072 (AquaHawk) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 368 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_AquaHawk::
    INCBIN "gfx/monster_pics/aqua_hawk.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $073 (Dracky) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 186 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Dracky::
    INCBIN "gfx/monster_pics/dracky.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $074 (KiteHawk) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 372 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_KiteHawk::
    INCBIN "gfx/monster_pics/kite_hawk.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $075 (BigRoost) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 432 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_BigRoost::
    INCBIN "gfx/monster_pics/big_roost.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $076 (StubBird) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 286 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_StubBird::
    INCBIN "gfx/monster_pics/stub_bird.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $077 (LandOwl) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 397 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_LandOwl::
    INCBIN "gfx/monster_pics/land_owl.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $078 (MadGoose) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 380 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_MadGoose::
    INCBIN "gfx/monster_pics/mad_goose.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $079 (MadCondor) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 438 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_MadCondor::
    INCBIN "gfx/monster_pics/mad_condor.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $07A (Emyu) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 311 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Emyu::
    INCBIN "gfx/monster_pics/emyu.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $07B (Blizzardy) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 451 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Blizzardy::
    INCBIN "gfx/monster_pics/blizzardy.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $07C (Phoenix) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 454 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Phoenix::
    INCBIN "gfx/monster_pics/phoenix.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $07D (ZapBird) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 448 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_ZapBird::
    INCBIN "gfx/monster_pics/zap_bird.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $07E (Garudian) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 491 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Garudian::
    INCBIN "gfx/monster_pics/garudian.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $07F (WhipBird) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 461 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_WhipBird::
    INCBIN "gfx/monster_pics/whip_bird.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $080 (FunkyBird) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 382 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_FunkyBird::
    INCBIN "gfx/monster_pics/funky_bird.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $081 (RainHawk) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 509 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_RainHawk::
    INCBIN "gfx/monster_pics/rain_hawk.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $082 (Azurile) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 472 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Azurile::
    INCBIN "gfx/monster_pics/azurile.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $083 (Shantak) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 524 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Shantak::
    INCBIN "gfx/monster_pics/shantak.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $084 (CragDevil) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 288 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_CragDevil::
    INCBIN "gfx/monster_pics/crag_devil.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $08E (FireWeed) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 363 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_FireWeed::
    INCBIN "gfx/monster_pics/fire_weed.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $08F (FloraMan) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 484 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_FloraMan::
    INCBIN "gfx/monster_pics/flora_man.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $090 (WingTree) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 360 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_WingTree::
    INCBIN "gfx/monster_pics/wing_tree.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $091 (CactiBall) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 344 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_CactiBall::
    INCBIN "gfx/monster_pics/cacti_ball.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $092 (Gulpple) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 271 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Gulpple::
    INCBIN "gfx/monster_pics/gulpple.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $093 (Toadstool) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 270 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Toadstool::
    INCBIN "gfx/monster_pics/toadstool.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $094 (AmberWeed) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 398 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_AmberWeed::
    INCBIN "gfx/monster_pics/amber_weed.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $095 (Slurperon) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 271 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Slurperon::
    INCBIN "gfx/monster_pics/slurperon.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $096 (Stubsuck) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 336 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Stubsuck::
    INCBIN "gfx/monster_pics/stubsuck.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $097 (Oniono) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 317 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Oniono::
    INCBIN "gfx/monster_pics/oniono.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $098 (DanceVegi) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 296 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_DanceVegi::
    INCBIN "gfx/monster_pics/dance_vegi.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $099 (TreeBoy) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 382 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_TreeBoy::
    INCBIN "gfx/monster_pics/tree_boy.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $09A (Devipine) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 242 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Devipine::
    INCBIN "gfx/monster_pics/devipine.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $09B (FaceTree) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 440 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_FaceTree::
    INCBIN "gfx/monster_pics/face_tree.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $09C (HerbMan) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 428 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_HerbMan::
    INCBIN "gfx/monster_pics/herb_man.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $09D (BeanMan) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 320 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_BeanMan::
    INCBIN "gfx/monster_pics/bean_man.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $09E (EvilSeed) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 242 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_EvilSeed::
    INCBIN "gfx/monster_pics/evil_seed.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $09F (ManEater) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 385 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_ManEater::
    INCBIN "gfx/monster_pics/man_eater.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0A0 (Snapper) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 369 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Snapper::
    INCBIN "gfx/monster_pics/snapper.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0A1 (GhosTree) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 293 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_GhosTree::
    INCBIN "gfx/monster_pics/ghos_tree.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $0A2 (Rosevine) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 529 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Rosevine::
    INCBIN "gfx/monster_pics/rosevine.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $17C (Lamia) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 503 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Lamia::
    INCBIN "gfx/monster_pics/lamia.lz"
    ds $81, $00
