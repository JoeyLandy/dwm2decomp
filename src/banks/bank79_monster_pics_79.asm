; ROM bank $79: compressed monster pictures
; The annotated listing of this bank is build/listing/bank79.asm.

SECTION "Bank 79", ROMX[$4000], BANK[$79]
    db $79

; compressed 6 x 6 picture (36 tiles) of monster id $103 (Reaper) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 265 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Reaper::
    INCBIN "dwm2-cobi-us.gbc", $1E4001, $109

; compressed 6 x 6 picture (36 tiles) of monster id $104 (Inverzon) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 363 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Inverzon::
    INCBIN "dwm2-cobi-us.gbc", $1E410A, $16B

; compressed 6 x 6 picture (36 tiles) of monster id $105 (FoxFire) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 398 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_FoxFire::
    INCBIN "dwm2-cobi-us.gbc", $1E4275, $18E

; compressed 6 x 6 picture (36 tiles) of monster id $106 (CaptDead) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 463 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_CaptDead::
    INCBIN "dwm2-cobi-us.gbc", $1E4403, $1CF

; compressed 6 x 6 picture (36 tiles) of monster id $107 (DeadNoble) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 501 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_DeadNoble::
    INCBIN "dwm2-cobi-us.gbc", $1E45D2, $1F5

; compressed 6 x 6 picture (36 tiles) of monster id $108 (WhiteKing) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 350 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_WhiteKing::
    INCBIN "dwm2-cobi-us.gbc", $1E47C7, $15E

; compressed 6 x 6 picture (36 tiles) of monster id $109 (BoneSlave) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 352 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_BoneSlave::
    INCBIN "dwm2-cobi-us.gbc", $1E4925, $160

; compressed 6 x 6 picture (36 tiles) of monster id $10A (Skeletor) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 471 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Skeletor::
    INCBIN "dwm2-cobi-us.gbc", $1E4A85, $1D7

; compressed 6 x 6 picture (36 tiles) of monster id $10B (Servant) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 490 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Servant::
    INCBIN "dwm2-cobi-us.gbc", $1E4C5C, $1EA

; compressed 6 x 6 picture (36 tiles) of monster id $10C (Lazamanus) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 477 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Lazamanus::
    INCBIN "dwm2-cobi-us.gbc", $1E4E46, $1DD

; compressed 6 x 6 picture (36 tiles) of monster id $10D (Copycat) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 141 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Copycat::
    INCBIN "dwm2-cobi-us.gbc", $1E5023, $8D

; compressed 6 x 6 picture (36 tiles) of monster id $10E (MadSpirit) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 227 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_MadSpirit::
    INCBIN "dwm2-cobi-us.gbc", $1E50B0, $E3

; compressed 6 x 6 picture (36 tiles) of monster id $10F (PomPomBom) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 294 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_PomBom::
    INCBIN "dwm2-cobi-us.gbc", $1E5193, $126

; compressed 6 x 6 picture (36 tiles) of monster id $110 (Niterich) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 422 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Niterich::
    INCBIN "dwm2-cobi-us.gbc", $1E52B9, $1A6

; compressed 6 x 6 picture (36 tiles) of monster id $119 (JewelBag) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 353 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_JewelBag::
    INCBIN "dwm2-cobi-us.gbc", $1E545F, $161

; compressed 6 x 6 picture (36 tiles) of monster id $11A (EvilWand) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 186 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_EvilWand::
    INCBIN "dwm2-cobi-us.gbc", $1E55C0, $BA

; compressed 6 x 6 picture (36 tiles) of monster id $11B (MadCandle) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 204 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_MadCandle::
    INCBIN "dwm2-cobi-us.gbc", $1E567A, $CC

; compressed 6 x 6 picture (36 tiles) of monster id $11C (CoilBird) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 375 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_CoilBird::
    INCBIN "dwm2-cobi-us.gbc", $1E5746, $177

; compressed 6 x 6 picture (36 tiles) of monster id $11D (Facer) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 274 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Facer::
    INCBIN "dwm2-cobi-us.gbc", $1E58BD, $112

; compressed 6 x 6 picture (36 tiles) of monster id $11E (SpikyBoy) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 233 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_SpikyBoy::
    INCBIN "dwm2-cobi-us.gbc", $1E59CF, $E9

; compressed 6 x 6 picture (36 tiles) of monster id $11F (MadMirror) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 339 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_MadMirror::
    INCBIN "dwm2-cobi-us.gbc", $1E5AB8, $153

; compressed 6 x 6 picture (36 tiles) of monster id $120 (RogueNite) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 384 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_RogueNite::
    INCBIN "dwm2-cobi-us.gbc", $1E5C0B, $180

; compressed 6 x 6 picture (36 tiles) of monster id $121 (Puppetor) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 333 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Puppetor::
    INCBIN "dwm2-cobi-us.gbc", $1E5D8B, $14D

; compressed 6 x 6 picture (36 tiles) of monster id $122 (Goopi) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 208 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Goopi::
    INCBIN "dwm2-cobi-us.gbc", $1E5ED8, $D0

; compressed 6 x 6 picture (36 tiles) of monster id $123 (Voodoll) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 306 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Voodoll::
    INCBIN "dwm2-cobi-us.gbc", $1E5FA8, $132

; compressed 6 x 6 picture (36 tiles) of monster id $124 (MetalDrak) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 500 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_MetalDrak::
    INCBIN "dwm2-cobi-us.gbc", $1E60DA, $1F4

; compressed 6 x 6 picture (36 tiles) of monster id $125 (Balzak) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 480 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Balzak::
    INCBIN "dwm2-cobi-us.gbc", $1E62CE, $1E0

; compressed 6 x 6 picture (36 tiles) of monster id $126 (SabreMan) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 187 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_SabreMan::
    INCBIN "dwm2-cobi-us.gbc", $1E64AE, $BB

; compressed 6 x 6 picture (36 tiles) of monster id $127 (CurseLamp) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 245 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_CurseLamp::
    INCBIN "dwm2-cobi-us.gbc", $1E6569, $F5

; compressed 6 x 6 picture (36 tiles) of monster id $128 (Brushead) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 390 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Brushead::
    INCBIN "dwm2-cobi-us.gbc", $1E665E, $186

; compressed 6 x 6 picture (36 tiles) of monster id $129 (Roboster) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 438 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Roboster::
    INCBIN "dwm2-cobi-us.gbc", $1E67E4, $1B6

; compressed 6 x 6 picture (36 tiles) of monster id $12A (Roboster2) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 450 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Roboster2::
    INCBIN "dwm2-cobi-us.gbc", $1E699A, $1C2

; compressed 6 x 6 picture (36 tiles) of monster id $12B (EvilPot) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 253 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_EvilPot::
    INCBIN "dwm2-cobi-us.gbc", $1E6B5C, $FD

; compressed 6 x 6 picture (36 tiles) of monster id $12C (Gismo) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 236 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Gismo::
    INCBIN "dwm2-cobi-us.gbc", $1E6C59, $EC

; compressed 6 x 6 picture (36 tiles) of monster id $12D (LavaMan) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 330 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_LavaMan::
    INCBIN "dwm2-cobi-us.gbc", $1E6D45, $14A

; compressed 6 x 6 picture (36 tiles) of monster id $12E (IceMan) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 329 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_IceMan::
    INCBIN "dwm2-cobi-us.gbc", $1E6E8F, $149

; compressed 6 x 6 picture (36 tiles) of monster id $12F (Mimic) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 244 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Mimic::
    INCBIN "dwm2-cobi-us.gbc", $1E6FD8, $F4

; compressed 6 x 6 picture (36 tiles) of monster id $130 (Exaucers) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 362 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Exaucers::
    INCBIN "dwm2-cobi-us.gbc", $1E70CC, $16A

; compressed 6 x 6 picture (36 tiles) of monster id $131 (MudDoll) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 275 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_MudDoll::
    INCBIN "dwm2-cobi-us.gbc", $1E7236, $113

; compressed 6 x 6 picture (36 tiles) of monster id $132 (Golem) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 462 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Golem::
    INCBIN "dwm2-cobi-us.gbc", $1E7349, $1CE

; compressed 6 x 6 picture (36 tiles) of monster id $133 (StoneMan) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 372 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_StoneMan::
    INCBIN "dwm2-cobi-us.gbc", $1E7517, $174

; compressed 6 x 6 picture (36 tiles) of monster id $134 (BombCrag) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 277 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_BombCrag::
    INCBIN "dwm2-cobi-us.gbc", $1E768B, $115

; compressed 6 x 6 picture (36 tiles) of monster id $135 (GoldGolem) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 547 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_GoldGolem::
    INCBIN "dwm2-cobi-us.gbc", $1E77A0, $223

; compressed 6 x 6 picture (36 tiles) of monster id $136 (DarkMate) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 497 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_DarkMate::
    INCBIN "dwm2-cobi-us.gbc", $1E79C3, $1F1

; compressed 6 x 6 picture (36 tiles) of monster id $137 (ProtoMech) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 407 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_ProtoMech::
    INCBIN "dwm2-cobi-us.gbc", $1E7BB4, $197

; compressed 6 x 6 picture (36 tiles) of monster id $138 (CloudKing) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 477 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_CloudKing::
    INCBIN "dwm2-cobi-us.gbc", $1E7D4B, $1DC
    ds $d9, $00
