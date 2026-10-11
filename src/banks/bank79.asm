SECTION "Bank 79", ROMX[$4000], BANK[$79]
    db $79

; compressed 6 x 6 picture (36 tiles) of monster id $103 (Reaper) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 265 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Reaper:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E4001, $109

; compressed 6 x 6 picture (36 tiles) of monster id $104 (Inverzon) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 363 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Inverzon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_410A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E410A, $16B

; compressed 6 x 6 picture (36 tiles) of monster id $105 (FoxFire) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 398 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_FoxFire:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_4275:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E4275, $18E

; compressed 6 x 6 picture (36 tiles) of monster id $106 (CaptDead) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 463 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_CaptDead:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_4403:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E4403, $1CF

; compressed 6 x 6 picture (36 tiles) of monster id $107 (DeadNoble) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 501 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_DeadNoble:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_45D2:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E45D2, $1F5

; compressed 6 x 6 picture (36 tiles) of monster id $108 (WhiteKing) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 350 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_WhiteKing:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_47C7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E47C7, $15E

; compressed 6 x 6 picture (36 tiles) of monster id $109 (BoneSlave) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 352 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_BoneSlave:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_4925:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E4925, $160

; compressed 6 x 6 picture (36 tiles) of monster id $10A (Skeletor) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 471 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Skeletor:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_4A85:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E4A85, $1D7

; compressed 6 x 6 picture (36 tiles) of monster id $10B (Servant) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 490 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Servant:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_4C5C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E4C5C, $1EA

; compressed 6 x 6 picture (36 tiles) of monster id $10C (Lazamanus) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 477 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Lazamanus:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_4E46:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E4E46, $1DD

; compressed 6 x 6 picture (36 tiles) of monster id $10D (Copycat) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 141 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Copycat:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_5023:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E5023, $8D

; compressed 6 x 6 picture (36 tiles) of monster id $10E (MadSpirit) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 227 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_MadSpirit:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_50B0:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E50B0, $E3

; compressed 6 x 6 picture (36 tiles) of monster id $10F (PomPomBom) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 294 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_PomPomBom:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_5193:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E5193, $126

; compressed 6 x 6 picture (36 tiles) of monster id $110 (Niterich) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 422 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Niterich:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_52B9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E52B9, $1A6

; compressed 6 x 6 picture (36 tiles) of monster id $119 (JewelBag) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 353 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_JewelBag:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_545F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E545F, $161

; compressed 6 x 6 picture (36 tiles) of monster id $11A (EvilWand) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 186 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_EvilWand:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_55C0:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E55C0, $BA

; compressed 6 x 6 picture (36 tiles) of monster id $11B (MadCandle) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 204 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_MadCandle:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_567A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E567A, $CC

; compressed 6 x 6 picture (36 tiles) of monster id $11C (CoilBird) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 375 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_CoilBird:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_5746:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E5746, $177

; compressed 6 x 6 picture (36 tiles) of monster id $11D (Facer) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 274 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Facer:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_58BD:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E58BD, $112

; compressed 6 x 6 picture (36 tiles) of monster id $11E (SpikyBoy) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 233 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_SpikyBoy:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_59CF:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E59CF, $E9

; compressed 6 x 6 picture (36 tiles) of monster id $11F (MadMirror) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 339 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_MadMirror:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_5AB8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E5AB8, $153

; compressed 6 x 6 picture (36 tiles) of monster id $120 (RogueNite) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 384 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_RogueNite:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_5C0B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E5C0B, $180

; compressed 6 x 6 picture (36 tiles) of monster id $121 (Puppetor) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 333 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Puppetor:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_5D8B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E5D8B, $14D

; compressed 6 x 6 picture (36 tiles) of monster id $122 (Goopi) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 208 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Goopi:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_5ED8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E5ED8, $D0

; compressed 6 x 6 picture (36 tiles) of monster id $123 (Voodoll) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 306 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Voodoll:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_5FA8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E5FA8, $132

; compressed 6 x 6 picture (36 tiles) of monster id $124 (MetalDrak) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 500 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_MetalDrak:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_60DA:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E60DA, $1F4

; compressed 6 x 6 picture (36 tiles) of monster id $125 (Balzak) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 480 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Balzak:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_62CE:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E62CE, $1E0

; compressed 6 x 6 picture (36 tiles) of monster id $126 (SabreMan) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 187 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_SabreMan:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_64AE:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E64AE, $BB

; compressed 6 x 6 picture (36 tiles) of monster id $127 (CurseLamp) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 245 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_CurseLamp:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_6569:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E6569, $F5

; compressed 6 x 6 picture (36 tiles) of monster id $128 (Brushead) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 390 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Brushead:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_665E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E665E, $186

; compressed 6 x 6 picture (36 tiles) of monster id $129 (Roboster) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 438 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Roboster:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_67E4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E67E4, $1B6

; compressed 6 x 6 picture (36 tiles) of monster id $12A (Roboster2) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 450 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Roboster2:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_699A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E699A, $1C2

; compressed 6 x 6 picture (36 tiles) of monster id $12B (EvilPot) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 253 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_EvilPot:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_6B5C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E6B5C, $FD

; compressed 6 x 6 picture (36 tiles) of monster id $12C (Gismo) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 236 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Gismo:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_6C59:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E6C59, $EC

; compressed 6 x 6 picture (36 tiles) of monster id $12D (LavaMan) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 330 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_LavaMan:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_6D45:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E6D45, $14A

; compressed 6 x 6 picture (36 tiles) of monster id $12E (IceMan) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 329 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_IceMan:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_6E8F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E6E8F, $149

; compressed 6 x 6 picture (36 tiles) of monster id $12F (Mimic) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 244 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Mimic:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_6FD8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E6FD8, $F4

; compressed 6 x 6 picture (36 tiles) of monster id $130 (Exaucers) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 362 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Exaucers:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_70CC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E70CC, $16A

; compressed 6 x 6 picture (36 tiles) of monster id $131 (MudDoll) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 275 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_MudDoll:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_7236:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E7236, $113

; compressed 6 x 6 picture (36 tiles) of monster id $132 (Golem) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 462 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Golem:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_7349:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E7349, $1CE

; compressed 6 x 6 picture (36 tiles) of monster id $133 (StoneMan) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 372 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_StoneMan:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_7517:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E7517, $174

; compressed 6 x 6 picture (36 tiles) of monster id $134 (BombCrag) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 277 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_BombCrag:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_768B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E768B, $115

; compressed 6 x 6 picture (36 tiles) of monster id $135 (GoldGolem) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 547 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_GoldGolem:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_77A0:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E77A0, $223

; compressed 6 x 6 picture (36 tiles) of monster id $136 (DarkMate) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 497 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_DarkMate:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_79C3:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E79C3, $1F1

; compressed 6 x 6 picture (36 tiles) of monster id $137 (ProtoMech) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 407 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_ProtoMech:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_7BB4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E7BB4, $197

; compressed 6 x 6 picture (36 tiles) of monster id $138 (CloudKing) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 477 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_CloudKing:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_079_7D4B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E7D4B, $1DC
    ds $D9, $00
