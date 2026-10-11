SECTION "Bank 78", ROMX[$4000], BANK[$78]
    db $78

; compressed 6 x 6 picture (36 tiles) of monster id $0D3 (Pixy) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 244 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Pixy:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E0001, $F4

; compressed 6 x 6 picture (36 tiles) of monster id $0D4 (MedusaEye) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 262 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_MedusaEye:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_40F5:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E00F5, $106

; compressed 6 x 6 picture (36 tiles) of monster id $0D5 (AgDevil) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 374 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_AgDevil:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_41FB:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E01FB, $176

; compressed 6 x 6 picture (36 tiles) of monster id $0D6 (Demonite) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 273 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Demonite:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_4371:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E0371, $111

; compressed 6 x 6 picture (36 tiles) of monster id $0D7 (DarkEye) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 254 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_DarkEye:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_4482:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E0482, $FE

; compressed 6 x 6 picture (36 tiles) of monster id $0D8 (EyeBall) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 215 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_EyeBall:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_4580:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E0580, $D7

; compressed 6 x 6 picture (36 tiles) of monster id $0D9 (SkulRider) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 337 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_SkulRider:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_4657:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E0657, $151

; compressed 6 x 6 picture (36 tiles) of monster id $0DA (EvilBeast) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 462 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_EvilBeast:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_47A8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E07A8, $1CE

; compressed 6 x 6 picture (36 tiles) of monster id $0DB (Bubblemon) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 434 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Bubblemon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_4976:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E0976, $1B2

; compressed 6 x 6 picture (36 tiles) of monster id $0DC (1EyeClown) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 305 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_1EyeClown:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_4B28:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E0B28, $131

; compressed 6 x 6 picture (36 tiles) of monster id $0DD (Gremlin) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 214 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Gremlin:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_4C59:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E0C59, $D6

; compressed 6 x 6 picture (36 tiles) of monster id $0DE (ArcDemon) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 462 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_ArcDemon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_4D2F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E0D2F, $1CE

; compressed 6 x 6 picture (36 tiles) of monster id $0DF (Lionex) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 516 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Lionex:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_4EFD:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E0EFD, $204

; compressed 6 x 6 picture (36 tiles) of monster id $0E0 (GoatHorn) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 421 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_GoatHorn:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_5101:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E1101, $1A5

; compressed 6 x 6 picture (36 tiles) of monster id $0E1 (Orc) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 359 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Orc:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_52A6:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E12A6, $167

; compressed 6 x 6 picture (36 tiles) of monster id $0E2 (Ogre) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 454 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Ogre:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_540D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E140D, $1C6

; compressed 6 x 6 picture (36 tiles) of monster id $0E3 (GateGuard) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 479 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_GateGuard:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_55D3:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E15D3, $1DF

; compressed 6 x 6 picture (36 tiles) of monster id $0E4 (ChopClown) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 464 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_ChopClown:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_57B2:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E17B2, $1D0

; compressed 6 x 6 picture (36 tiles) of monster id $0E5 (BossTroll) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 455 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_BossTroll:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_5982:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E1982, $1C7

; compressed 6 x 6 picture (36 tiles) of monster id $0E6 (Grendal) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 481 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Grendal:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_5B49:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E1B49, $1E1

; compressed 6 x 6 picture (36 tiles) of monster id $0E7 (Akubar) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 509 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Akubar:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_5D2A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E1D2A, $1FD

; compressed 6 x 6 picture (36 tiles) of monster id $0E8 (MadKnight) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 477 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_MadKnight:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_5F27:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E1F27, $1DD

; compressed 6 x 6 picture (36 tiles) of monster id $0E9 (EvilWell) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 481 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_EvilWell:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_6104:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E2104, $1E1

; compressed 6 x 6 picture (36 tiles) of monster id $0EA (Gigantes) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 522 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Gigantes:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_62E5:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E22E5, $20A

; compressed 6 x 6 picture (36 tiles) of monster id $0EB (Centasaur) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 416 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Centasaur:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_64EF:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E24EF, $1A0

; compressed 6 x 6 picture (36 tiles) of monster id $0EC (EvilArmor) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 456 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_EvilArmor:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_668F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E268F, $1C8

; compressed 6 x 6 picture (36 tiles) of monster id $0ED (Jamirus) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 484 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Jamirus:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_6857:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E2857, $1E4

; compressed 6 x 6 picture (36 tiles) of monster id $0EE (Durran) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 432 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Durran:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_6A3B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E2A3B, $1B0

; compressed 6 x 6 picture (36 tiles) of monster id $0EF (Titanis) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 538 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Titanis:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_6BEB:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E2BEB, $21A

; compressed 6 x 6 picture (36 tiles) of monster id $0F0 (LampGenie) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 438 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_LampGenie:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_6E05:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E2E05, $1B6

; compressed 6 x 6 picture (36 tiles) of monster id $0F6 (Spooky) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 221 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Spooky:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_6FBB:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E2FBB, $DD

; compressed 6 x 6 picture (36 tiles) of monster id $0F7 (Skullgon) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 518 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Skullgon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_7098:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E3098, $206

; compressed 6 x 6 picture (36 tiles) of monster id $0F8 (PutrePup) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 191 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_PutrePup:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_729E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E329E, $BF

; compressed 6 x 6 picture (36 tiles) of monster id $0F9 (RotRaven) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 252 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_RotRaven:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_735D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E335D, $FC

; compressed 6 x 6 picture (36 tiles) of monster id $0FA (Mummy) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 332 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Mummy:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_7459:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E3459, $14C

; compressed 6 x 6 picture (36 tiles) of monster id $0FB (DarkCrab) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 332 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_DarkCrab:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_75A5:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E35A5, $14C

; compressed 6 x 6 picture (36 tiles) of monster id $0FC (DeadNite) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 342 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_DeadNite:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_76F1:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E36F1, $156

; compressed 6 x 6 picture (36 tiles) of monster id $0FD (Shadow) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 260 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Shadow:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_7847:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E3847, $104

; compressed 6 x 6 picture (36 tiles) of monster id $0FE (Skulpent) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 234 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Skulpent:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_794B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E394B, $EA

; compressed 6 x 6 picture (36 tiles) of monster id $0FF (Hork) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 310 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Hork:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_7A35:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E3A35, $136

; compressed 6 x 6 picture (36 tiles) of monster id $100 (Mudron) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 414 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Mudron:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_7B6B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E3B6B, $19E

; compressed 6 x 6 picture (36 tiles) of monster id $101 (NiteWhip) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 217 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_NiteWhip:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_7D09:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E3D09, $D9

; compressed 6 x 6 picture (36 tiles) of monster id $102 (WindMerge) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 306 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_WindMerge:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_078_7DE2:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E3DE2, $132
    ds $EC, $00
