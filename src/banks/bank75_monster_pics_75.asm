; ROM bank $75: compressed monster pictures
; The annotated listing of this bank is build/listing/bank75.asm.

SECTION "Bank 75", ROMX[$4000], BANK[$75]
    db $75

; compressed 6 x 6 picture (36 tiles) of monster id $03E (SkyDragon) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 470 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_SkyDragon::
    INCBIN "dwm2-cobi-us.gbc", $1D4001, $1D6

; compressed 6 x 6 picture (36 tiles) of monster id $03F (Serpentia) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 460 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Serpentia::
    INCBIN "dwm2-cobi-us.gbc", $1D41D7, $1CC

; compressed 6 x 6 picture (36 tiles) of monster id $040 (Divinegon) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPic_Divinegon::
    INCBIN "dwm2-cobi-us.gbc", $1D43A3, $1D6

; compressed 6 x 6 picture (36 tiles) of monster id $041 (Orligon) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 446 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Orligon::
    INCBIN "dwm2-cobi-us.gbc", $1D4579, $1BE

; compressed 6 x 6 picture (36 tiles) of monster id $042 (GigaDraco) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 481 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_GigaDraco::
    INCBIN "dwm2-cobi-us.gbc", $1D4737, $1E1

; compressed 6 x 6 picture (36 tiles) of monster id $047 (Tonguella) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 295 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Tonguella::
    INCBIN "dwm2-cobi-us.gbc", $1D4918, $127

; compressed 6 x 6 picture (36 tiles) of monster id $048 (Almiraj) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 226 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Almiraj::
    INCBIN "dwm2-cobi-us.gbc", $1D4A3F, $E2

; compressed 6 x 6 picture (36 tiles) of monster id $049 (CatFly) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 399 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_CatFly::
    INCBIN "dwm2-cobi-us.gbc", $1D4B21, $18F

; compressed 6 x 6 picture (36 tiles) of monster id $04A (PillowRat) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 196 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_PillowRat::
    INCBIN "dwm2-cobi-us.gbc", $1D4CB0, $C4

; compressed 6 x 6 picture (36 tiles) of monster id $04B (Saccer) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 286 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Saccer::
    INCBIN "dwm2-cobi-us.gbc", $1D4D74, $11E

; compressed 6 x 6 picture (36 tiles) of monster id $04C (GulpBeast) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 443 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_GulpBeast::
    INCBIN "dwm2-cobi-us.gbc", $1D4E92, $1BB

; compressed 6 x 6 picture (36 tiles) of monster id $04D (Skullroo) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 277 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Skullroo::
    INCBIN "dwm2-cobi-us.gbc", $1D504D, $115

; compressed 6 x 6 picture (36 tiles) of monster id $04E (WindBeast) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 409 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_WindBeast::
    INCBIN "dwm2-cobi-us.gbc", $1D5162, $199

; compressed 6 x 6 picture (36 tiles) of monster id $04F (Beavern) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 466 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Beavern::
    INCBIN "dwm2-cobi-us.gbc", $1D52FB, $1D2

; compressed 6 x 6 picture (36 tiles) of monster id $050 (Antbear) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 319 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Antbear::
    INCBIN "dwm2-cobi-us.gbc", $1D54CD, $13F

; compressed 6 x 6 picture (36 tiles) of monster id $051 (SuperTen) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 274 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_SuperTen::
    INCBIN "dwm2-cobi-us.gbc", $1D560C, $112

; compressed 6 x 6 picture (36 tiles) of monster id $052 (IronTurt) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 418 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_IronTurt::
    INCBIN "dwm2-cobi-us.gbc", $1D571E, $1A2

; compressed 6 x 6 picture (36 tiles) of monster id $053 (Mommonja) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 277 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Mommonja::
    INCBIN "dwm2-cobi-us.gbc", $1D58C0, $115

; compressed 6 x 6 picture (36 tiles) of monster id $054 (HammerMan) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 318 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_HammerMan::
    INCBIN "dwm2-cobi-us.gbc", $1D59D5, $13E

; compressed 6 x 6 picture (36 tiles) of monster id $055 (Grizzly) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 393 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Grizzly::
    INCBIN "dwm2-cobi-us.gbc", $1D5B13, $189

; compressed 6 x 6 picture (36 tiles) of monster id $056 (Yeti) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 466 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Yeti::
    INCBIN "dwm2-cobi-us.gbc", $1D5C9C, $1D2

; compressed 6 x 6 picture (36 tiles) of monster id $057 (ArrowDog) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 382 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_ArrowDog::
    INCBIN "dwm2-cobi-us.gbc", $1D5E6E, $17E

; compressed 6 x 6 picture (36 tiles) of monster id $058 (NoctoKing) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 510 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_NoctoKing::
    INCBIN "dwm2-cobi-us.gbc", $1D5FEC, $1FE

; compressed 6 x 6 picture (36 tiles) of monster id $059 (BeastNite) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 302 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_BeastNite::
    INCBIN "dwm2-cobi-us.gbc", $1D61EA, $12E

; compressed 6 x 6 picture (36 tiles) of monster id $05A (MadGopher) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 232 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_MadGopher::
    INCBIN "dwm2-cobi-us.gbc", $1D6318, $E8

; compressed 6 x 6 picture (36 tiles) of monster id $05B (FairyRat) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 249 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_FairyRat::
    INCBIN "dwm2-cobi-us.gbc", $1D6400, $F9

; compressed 6 x 6 picture (36 tiles) of monster id $05C (Unicorn) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 419 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Unicorn::
    INCBIN "dwm2-cobi-us.gbc", $1D64F9, $1A3

; compressed 6 x 6 picture (36 tiles) of monster id $05D (Goategon) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 261 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Goategon::
    INCBIN "dwm2-cobi-us.gbc", $1D669C, $105

; compressed 6 x 6 picture (36 tiles) of monster id $05E (WildApe) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 388 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_WildApe::
    INCBIN "dwm2-cobi-us.gbc", $1D67A1, $184

; compressed 6 x 6 picture (36 tiles) of monster id $05F (Trumpeter) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 488 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Trumpeter::
    INCBIN "dwm2-cobi-us.gbc", $1D6925, $1E8

; compressed 6 x 6 picture (36 tiles) of monster id $060 (KingLeo) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 562 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_KingLeo::
    INCBIN "dwm2-cobi-us.gbc", $1D6B0D, $232

; compressed 6 x 6 picture (36 tiles) of monster id $061 (DarkHorn) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 478 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_DarkHorn::
    INCBIN "dwm2-cobi-us.gbc", $1D6D3F, $1DE

; compressed 6 x 6 picture (36 tiles) of monster id $062 (MadCat) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 361 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_MadCat::
    INCBIN "dwm2-cobi-us.gbc", $1D6F1D, $169

; compressed 6 x 6 picture (36 tiles) of monster id $063 (BigEye) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 443 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_BigEye::
    INCBIN "dwm2-cobi-us.gbc", $1D7086, $1BB

; compressed 6 x 6 picture (36 tiles) of monster id $064 (Gorago) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 505 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Gorago::
    INCBIN "dwm2-cobi-us.gbc", $1D7241, $1F9

; compressed 6 x 6 picture (36 tiles) of monster id $065 (CatMage) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 342 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_CatMage::
    INCBIN "dwm2-cobi-us.gbc", $1D743A, $156

; compressed 6 x 6 picture (36 tiles) of monster id $066 (Dumbira) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 495 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Dumbira::
    INCBIN "dwm2-cobi-us.gbc", $1D7590, $1EF

; compressed 6 x 6 picture (36 tiles) of monster id $06B (Wyvern) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 310 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Wyvern::
    INCBIN "dwm2-cobi-us.gbc", $1D777F, $136

; compressed 6 x 6 picture (36 tiles) of monster id $06C (BullBird) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 342 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_BullBird::
    INCBIN "dwm2-cobi-us.gbc", $1D78B5, $156

; compressed 6 x 6 picture (36 tiles) of monster id $06D (Florajay) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 351 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Florajay::
    INCBIN "dwm2-cobi-us.gbc", $1D7A0B, $15F

; compressed 6 x 6 picture (36 tiles) of monster id $06E (DuckKite) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 501 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_DuckKite::
    INCBIN "dwm2-cobi-us.gbc", $1D7B6A, $1F5

; compressed 6 x 6 picture (36 tiles) of monster id $17E (Kagebou) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 273 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Kagebou::
    INCBIN "dwm2-cobi-us.gbc", $1D7D5F, $111
    ds $190, $00
