; ROM bank $75: compressed monster pictures
; The annotated listing of this bank is build/listing/bank75.asm.

SECTION "Bank 75", ROMX
    db $75

; compressed 6 x 6 picture (36 tiles) of monster id $03E (SkyDragon) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 470 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_SkyDragon::
    INCBIN "gfx/monster_pics/sky_dragon.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $03F (Serpentia) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 460 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Serpentia::
    INCBIN "gfx/monster_pics/serpentia.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $040 (Divinegon) (MonsterPictureTable /
; MonsterAttributeMapTable) (E-0138)
MonsterPic_Divinegon::
    INCBIN "gfx/monster_pics/divinegon.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $041 (Orligon) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 446 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Orligon::
    INCBIN "gfx/monster_pics/orligon.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $042 (GigaDraco) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 481 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_GigaDraco::
    INCBIN "gfx/monster_pics/giga_draco.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $047 (Tonguella) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 295 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Tonguella::
    INCBIN "gfx/monster_pics/tonguella.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $048 (Almiraj) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 226 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Almiraj::
    INCBIN "gfx/monster_pics/almiraj.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $049 (CatFly) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 399 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_CatFly::
    INCBIN "gfx/monster_pics/cat_fly.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $04A (PillowRat) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 196 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_PillowRat::
    INCBIN "gfx/monster_pics/pillow_rat.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $04B (Saccer) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 286 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Saccer::
    INCBIN "gfx/monster_pics/saccer.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $04C (GulpBeast) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 443 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_GulpBeast::
    INCBIN "gfx/monster_pics/gulp_beast.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $04D (Skullroo) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 277 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Skullroo::
    INCBIN "gfx/monster_pics/skullroo.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $04E (WindBeast) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 409 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_WindBeast::
    INCBIN "gfx/monster_pics/wind_beast.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $04F (Beavern) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 466 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Beavern::
    INCBIN "gfx/monster_pics/beavern.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $050 (Antbear) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 319 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Antbear::
    INCBIN "gfx/monster_pics/antbear.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $051 (SuperTen) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 274 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_SuperTen::
    INCBIN "gfx/monster_pics/super_ten.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $052 (IronTurt) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 418 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_IronTurt::
    INCBIN "gfx/monster_pics/iron_turt.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $053 (Mommonja) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 277 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Mommonja::
    INCBIN "gfx/monster_pics/mommonja.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $054 (HammerMan) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 318 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_HammerMan::
    INCBIN "gfx/monster_pics/hammer_man.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $055 (Grizzly) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 393 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Grizzly::
    INCBIN "gfx/monster_pics/grizzly.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $056 (Yeti) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 466 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Yeti::
    INCBIN "gfx/monster_pics/yeti.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $057 (ArrowDog) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 382 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_ArrowDog::
    INCBIN "gfx/monster_pics/arrow_dog.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $058 (NoctoKing) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 510 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_NoctoKing::
    INCBIN "gfx/monster_pics/nocto_king.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $059 (BeastNite) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 302 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_BeastNite::
    INCBIN "gfx/monster_pics/beast_nite.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $05A (MadGopher) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 232 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_MadGopher::
    INCBIN "gfx/monster_pics/mad_gopher.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $05B (FairyRat) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 249 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_FairyRat::
    INCBIN "gfx/monster_pics/fairy_rat.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $05C (Unicorn) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 419 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Unicorn::
    INCBIN "gfx/monster_pics/unicorn.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $05D (Goategon) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 261 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Goategon::
    INCBIN "gfx/monster_pics/goategon.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $05E (WildApe) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 388 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_WildApe::
    INCBIN "gfx/monster_pics/wild_ape.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $05F (Trumpeter) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 488 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Trumpeter::
    INCBIN "gfx/monster_pics/trumpeter.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $060 (KingLeo) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 562 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_KingLeo::
    INCBIN "gfx/monster_pics/king_leo.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $061 (DarkHorn) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 478 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_DarkHorn::
    INCBIN "gfx/monster_pics/dark_horn.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $062 (MadCat) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 361 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_MadCat::
    INCBIN "gfx/monster_pics/mad_cat.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $063 (BigEye) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 443 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_BigEye::
    INCBIN "gfx/monster_pics/big_eye.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $064 (Gorago) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 505 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Gorago::
    INCBIN "gfx/monster_pics/gorago.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $065 (CatMage) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 342 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_CatMage::
    INCBIN "gfx/monster_pics/cat_mage.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $066 (Dumbira) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 495 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Dumbira::
    INCBIN "gfx/monster_pics/dumbira.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $06B (Wyvern) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 310 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Wyvern::
    INCBIN "gfx/monster_pics/wyvern.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $06C (BullBird) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 342 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_BullBird::
    INCBIN "gfx/monster_pics/bull_bird.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $06D (Florajay) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 351 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Florajay::
    INCBIN "gfx/monster_pics/florajay.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $06E (DuckKite) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 501 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_DuckKite::
    INCBIN "gfx/monster_pics/duck_kite.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $17E (Kagebou) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 273 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Kagebou::
    INCBIN "gfx/monster_pics/kagebou.lz"
    ds $190, $00
