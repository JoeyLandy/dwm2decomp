SECTION "Bank 75", ROMX[$4000], BANK[$75]
    db $75

; compressed 6 x 6 picture (36 tiles) of monster id $03E (SkyDragon) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 470 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_SkyDragon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D4001, $1D6

; compressed 6 x 6 picture (36 tiles) of monster id $03F (Serpentia) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 460 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Serpentia:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_41D7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D41D7, $1CC

; compressed 6 x 6 picture (36 tiles) of monster id $040 (Divinegon) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 470 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Divinegon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_43A3:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D43A3, $1D6

; compressed 6 x 6 picture (36 tiles) of monster id $041 (Orligon) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 446 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Orligon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_4579:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D4579, $1BE

; compressed 6 x 6 picture (36 tiles) of monster id $042 (GigaDraco) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 481 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_GigaDraco:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_4737:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D4737, $1E1

; compressed 6 x 6 picture (36 tiles) of monster id $047 (Tonguella) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 295 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Tonguella:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_4918:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D4918, $127

; compressed 6 x 6 picture (36 tiles) of monster id $048 (Almiraj) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 226 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Almiraj:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_4A3F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D4A3F, $E2

; compressed 6 x 6 picture (36 tiles) of monster id $049 (CatFly) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 399 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_CatFly:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_4B21:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D4B21, $18F

; compressed 6 x 6 picture (36 tiles) of monster id $04A (PillowRat) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 196 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_PillowRat:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_4CB0:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D4CB0, $C4

; compressed 6 x 6 picture (36 tiles) of monster id $04B (Saccer) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 286 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Saccer:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_4D74:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D4D74, $11E

; compressed 6 x 6 picture (36 tiles) of monster id $04C (GulpBeast) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 443 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_GulpBeast:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_4E92:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D4E92, $1BB

; compressed 6 x 6 picture (36 tiles) of monster id $04D (Skullroo) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 277 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Skullroo:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_504D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D504D, $115

; compressed 6 x 6 picture (36 tiles) of monster id $04E (WindBeast) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 409 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_WindBeast:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_5162:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D5162, $199

; compressed 6 x 6 picture (36 tiles) of monster id $04F (Beavern) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 466 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Beavern:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_52FB:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D52FB, $1D2

; compressed 6 x 6 picture (36 tiles) of monster id $050 (Antbear) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 319 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Antbear:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_54CD:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D54CD, $13F

; compressed 6 x 6 picture (36 tiles) of monster id $051 (SuperTen) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 274 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_SuperTen:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_560C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D560C, $112

; compressed 6 x 6 picture (36 tiles) of monster id $052 (IronTurt) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 418 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_IronTurt:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_571E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D571E, $1A2

; compressed 6 x 6 picture (36 tiles) of monster id $053 (Mommonja) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 277 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Mommonja:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_58C0:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D58C0, $115

; compressed 6 x 6 picture (36 tiles) of monster id $054 (HammerMan) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 318 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_HammerMan:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_59D5:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D59D5, $13E

; compressed 6 x 6 picture (36 tiles) of monster id $055 (Grizzly) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 393 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Grizzly:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_5B13:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D5B13, $189

; compressed 6 x 6 picture (36 tiles) of monster id $056 (Yeti) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 466 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Yeti:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_5C9C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D5C9C, $1D2

; compressed 6 x 6 picture (36 tiles) of monster id $057 (ArrowDog) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 382 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_ArrowDog:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_5E6E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D5E6E, $17E

; compressed 6 x 6 picture (36 tiles) of monster id $058 (NoctoKing) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 510 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_NoctoKing:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_5FEC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D5FEC, $1FE

; compressed 6 x 6 picture (36 tiles) of monster id $059 (BeastNite) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 302 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_BeastNite:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_61EA:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D61EA, $12E

; compressed 6 x 6 picture (36 tiles) of monster id $05A (MadGopher) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 232 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_MadGopher:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_6318:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D6318, $E8

; compressed 6 x 6 picture (36 tiles) of monster id $05B (FairyRat) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 249 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_FairyRat:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_6400:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D6400, $F9

; compressed 6 x 6 picture (36 tiles) of monster id $05C (Unicorn) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 419 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Unicorn:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_64F9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D64F9, $1A3

; compressed 6 x 6 picture (36 tiles) of monster id $05D (Goategon) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 261 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Goategon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_669C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D669C, $105

; compressed 6 x 6 picture (36 tiles) of monster id $05E (WildApe) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 388 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_WildApe:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_67A1:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D67A1, $184

; compressed 6 x 6 picture (36 tiles) of monster id $05F (Trumpeter) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 488 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Trumpeter:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_6925:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D6925, $1E8

; compressed 6 x 6 picture (36 tiles) of monster id $060 (KingLeo) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 562 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_KingLeo:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_6B0D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D6B0D, $232

; compressed 6 x 6 picture (36 tiles) of monster id $061 (DarkHorn) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 478 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_DarkHorn:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_6D3F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D6D3F, $1DE

; compressed 6 x 6 picture (36 tiles) of monster id $062 (MadCat) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 361 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_MadCat:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_6F1D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D6F1D, $169

; compressed 6 x 6 picture (36 tiles) of monster id $063 (BigEye) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 443 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_BigEye:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_7086:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D7086, $1BB

; compressed 6 x 6 picture (36 tiles) of monster id $064 (Gorago) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 505 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Gorago:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_7241:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D7241, $1F9

; compressed 6 x 6 picture (36 tiles) of monster id $065 (CatMage) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 342 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_CatMage:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_743A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D743A, $156

; compressed 6 x 6 picture (36 tiles) of monster id $066 (Dumbira) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 495 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Dumbira:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_7590:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D7590, $1EF

; compressed 6 x 6 picture (36 tiles) of monster id $06B (Wyvern) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 310 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Wyvern:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_777F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D777F, $136

; compressed 6 x 6 picture (36 tiles) of monster id $06C (BullBird) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 342 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_BullBird:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_78B5:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D78B5, $156

; compressed 6 x 6 picture (36 tiles) of monster id $06D (Florajay) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 351 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Florajay:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_7A0B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D7A0B, $15F

; compressed 6 x 6 picture (36 tiles) of monster id $06E (DuckKite) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 501 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_DuckKite:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_7B6A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D7B6A, $1F5

; compressed 6 x 6 picture (36 tiles) of monster id $17E (Kagebou) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 273 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Kagebou:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_075_7D5F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D7D5F, $111
    ds $190, $00
