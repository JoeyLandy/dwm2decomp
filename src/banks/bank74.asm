SECTION "Bank 74", ROMX[$4000], BANK[$74]
    db $74

; compressed 6 x 6 picture (36 tiles) of monster id $001 (DrakSlime); 67 other ids point here too
; (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed: 240 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_DrakSlime::
    INCBIN "dwm2-cobi-us.gbc", $1D0001, $F0

; compressed 6 x 6 picture (36 tiles) of monster id $002 (SpotSlime); 1 other ids point here too
; (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed: 145 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_SpotSlime::
    INCBIN "dwm2-cobi-us.gbc", $1D00F1, $91

; compressed 6 x 6 picture (36 tiles) of monster id $003 (WingSlime) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 290 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_WingSlime::
    INCBIN "dwm2-cobi-us.gbc", $1D0182, $122

; compressed 6 x 6 picture (36 tiles) of monster id $004 (TreeSlime) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 163 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_TreeSlime::
    INCBIN "dwm2-cobi-us.gbc", $1D02A4, $A3

; compressed 6 x 6 picture (36 tiles) of monster id $005 (Snaily) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 183 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Snaily::
    INCBIN "dwm2-cobi-us.gbc", $1D0347, $B7

; compressed 6 x 6 picture (36 tiles) of monster id $006 (SlimeNite) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 251 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_SlimeNite::
    INCBIN "dwm2-cobi-us.gbc", $1D03FE, $FB

; compressed 6 x 6 picture (36 tiles) of monster id $007 (Babble) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPic_Babble::
    INCBIN "dwm2-cobi-us.gbc", $1D04F9, $B7

; compressed 6 x 6 picture (36 tiles) of monster id $008 (BoxSlime) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 182 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_BoxSlime::
    INCBIN "dwm2-cobi-us.gbc", $1D05B0, $B6

; compressed 6 x 6 picture (36 tiles) of monster id $009 (PearlGel) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 265 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_PearlGel::
    INCBIN "dwm2-cobi-us.gbc", $1D0666, $109

; compressed 6 x 6 picture (36 tiles) of monster id $00A (Slime) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 101 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Slime::
    INCBIN "dwm2-cobi-us.gbc", $1D076F, $65

; compressed 6 x 6 picture (36 tiles) of monster id $00B (Healer) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 156 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Healer::
    INCBIN "dwm2-cobi-us.gbc", $1D07D4, $9C

; compressed 6 x 6 picture (36 tiles) of monster id $00C (FangSlime) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 231 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_FangSlime::
    INCBIN "dwm2-cobi-us.gbc", $1D0870, $E7

; compressed 6 x 6 picture (36 tiles) of monster id $00D (RockSlime) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 148 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_RockSlime::
    INCBIN "dwm2-cobi-us.gbc", $1D0957, $94

; compressed 6 x 6 picture (36 tiles) of monster id $00E (SlimeBorg) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 172 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_SlimeBorg::
    INCBIN "dwm2-cobi-us.gbc", $1D09EB, $AC

; compressed 6 x 6 picture (36 tiles) of monster id $00F (Slabbit) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 196 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Slabbit::
    INCBIN "dwm2-cobi-us.gbc", $1D0A97, $C4

; compressed 6 x 6 picture (36 tiles) of monster id $010 (KingSlime) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 328 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_KingSlime::
    INCBIN "dwm2-cobi-us.gbc", $1D0B5B, $148

; compressed 6 x 6 picture (36 tiles) of monster id $011 (Metaly) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 101 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Metaly::
    INCBIN "dwm2-cobi-us.gbc", $1D0CA3, $65

; compressed 6 x 6 picture (36 tiles) of monster id $012 (Metabble) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 183 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Metabble::
    INCBIN "dwm2-cobi-us.gbc", $1D0D08, $B7

; compressed 6 x 6 picture (36 tiles) of monster id $013 (SpotKing) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 358 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_SpotKing::
    INCBIN "dwm2-cobi-us.gbc", $1D0DBF, $166

; compressed 6 x 6 picture (36 tiles) of monster id $014 (TropicGel) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 217 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_TropicGel::
    INCBIN "dwm2-cobi-us.gbc", $1D0F25, $D9

; compressed 6 x 6 picture (36 tiles) of monster id $015 (MimeSlime) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 266 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_MimeSlime::
    INCBIN "dwm2-cobi-us.gbc", $1D0FFE, $10A

; compressed 6 x 6 picture (36 tiles) of monster id $016 (HaloSlime) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 171 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_HaloSlime::
    INCBIN "dwm2-cobi-us.gbc", $1D1108, $AB

; compressed 6 x 6 picture (36 tiles) of monster id $017 (MetalKing) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 329 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_MetalKing::
    INCBIN "dwm2-cobi-us.gbc", $1D11B3, $149

; compressed 6 x 6 picture (36 tiles) of monster id $018 (GoldSlime) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 491 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_GoldSlime::
    INCBIN "dwm2-cobi-us.gbc", $1D12FC, $1EB

; compressed 6 x 6 picture (36 tiles) of monster id $019 (GranSlime) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 509 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_GranSlime::
    INCBIN "dwm2-cobi-us.gbc", $1D14E7, $1FD

; compressed 6 x 6 picture (36 tiles) of monster id $01A (WonderEgg) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 142 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_WonderEgg::
    INCBIN "dwm2-cobi-us.gbc", $1D16E4, $8E

; compressed 6 x 6 picture (36 tiles) of monster id $024 (DragonKid) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 302 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_DragonKid::
    INCBIN "dwm2-cobi-us.gbc", $1D1772, $12E

; compressed 6 x 6 picture (36 tiles) of monster id $025 (Tortragon) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 380 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Tortragon::
    INCBIN "dwm2-cobi-us.gbc", $1D18A0, $17C

; compressed 6 x 6 picture (36 tiles) of monster id $026 (Pteranod) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 342 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Pteranod::
    INCBIN "dwm2-cobi-us.gbc", $1D1A1C, $156

; compressed 6 x 6 picture (36 tiles) of monster id $027 (Gasgon) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 437 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Gasgon::
    INCBIN "dwm2-cobi-us.gbc", $1D1B72, $1B5

; compressed 6 x 6 picture (36 tiles) of monster id $028 (FairyDrak) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 301 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_FairyDrak::
    INCBIN "dwm2-cobi-us.gbc", $1D1D27, $12D

; compressed 6 x 6 picture (36 tiles) of monster id $029 (LizardMan) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 478 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_LizardMan::
    INCBIN "dwm2-cobi-us.gbc", $1D1E54, $1DE

; compressed 6 x 6 picture (36 tiles) of monster id $02A (Poisongon) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 384 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Poisongon::
    INCBIN "dwm2-cobi-us.gbc", $1D2032, $180

; compressed 6 x 6 picture (36 tiles) of monster id $02B (Swordgon) (MonsterPictureTable /
; MonsterAttributeMapTable)
MonsterPic_Swordgon::
    INCBIN "dwm2-cobi-us.gbc", $1D21B2, $1DE

; compressed 6 x 6 picture (36 tiles) of monster id $02C (Drygon) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 461 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Drygon::
    INCBIN "dwm2-cobi-us.gbc", $1D2390, $1CD

; compressed 6 x 6 picture (36 tiles) of monster id $02D (Dragon) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 382 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Dragon::
    INCBIN "dwm2-cobi-us.gbc", $1D255D, $17E

; compressed 6 x 6 picture (36 tiles) of monster id $02E (MiniDrak) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 236 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_MiniDrak::
    INCBIN "dwm2-cobi-us.gbc", $1D26DB, $EC

; compressed 6 x 6 picture (36 tiles) of monster id $02F (MadDragon) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 495 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_MadDragon::
    INCBIN "dwm2-cobi-us.gbc", $1D27C7, $1EF

; compressed 6 x 6 picture (36 tiles) of monster id $030 (Rayburn) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 432 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Rayburn::
    INCBIN "dwm2-cobi-us.gbc", $1D29B6, $1B0

; compressed 6 x 6 picture (36 tiles) of monster id $031 (Chamelgon) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 287 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Chamelgon::
    INCBIN "dwm2-cobi-us.gbc", $1D2B66, $11F

; compressed 6 x 6 picture (36 tiles) of monster id $032 (LizardFly) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 384 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_LizardFly::
    INCBIN "dwm2-cobi-us.gbc", $1D2C85, $180

; compressed 6 x 6 picture (36 tiles) of monster id $033 (Andreal) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 460 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Andreal::
    INCBIN "dwm2-cobi-us.gbc", $1D2E05, $1CC

; compressed 6 x 6 picture (36 tiles) of monster id $034 (KingCobra) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 240 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_KingCobra::
    INCBIN "dwm2-cobi-us.gbc", $1D2FD1, $F0

; compressed 6 x 6 picture (36 tiles) of monster id $035 (Vampirus) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 444 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Vampirus::
    INCBIN "dwm2-cobi-us.gbc", $1D30C1, $1BC

; compressed 6 x 6 picture (36 tiles) of monster id $036 (SnakeBat) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 356 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_SnakeBat::
    INCBIN "dwm2-cobi-us.gbc", $1D327D, $164

; compressed 6 x 6 picture (36 tiles) of monster id $037 (Spikerous) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 320 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Spikerous::
    INCBIN "dwm2-cobi-us.gbc", $1D33E1, $140

; compressed 6 x 6 picture (36 tiles) of monster id $038 (GreatDrak) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 529 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_GreatDrak::
    INCBIN "dwm2-cobi-us.gbc", $1D3521, $211

; compressed 6 x 6 picture (36 tiles) of monster id $039 (Crestpent) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 376 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Crestpent::
    INCBIN "dwm2-cobi-us.gbc", $1D3732, $178

; compressed 6 x 6 picture (36 tiles) of monster id $03A (WingSnake) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 479 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_WingSnake::
    INCBIN "dwm2-cobi-us.gbc", $1D38AA, $1DF

; compressed 6 x 6 picture (36 tiles) of monster id $03B (Coatol) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 460 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Coatol::
    INCBIN "dwm2-cobi-us.gbc", $1D3A89, $1CC

; compressed 6 x 6 picture (36 tiles) of monster id $03C (Orochi) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 449 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Orochi::
    INCBIN "dwm2-cobi-us.gbc", $1D3C55, $1C1

; compressed 6 x 6 picture (36 tiles) of monster id $03D (BattleRex) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 416 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_BattleRex::
    INCBIN "dwm2-cobi-us.gbc", $1D3E16, $1A0
    ds $4a, $00
