SECTION "Bank 74", ROMX[$4000], BANK[$74]
    db $74

; compressed 6 x 6 picture (36 tiles) of monster id $001 (DrakSlime); 67 other ids point here too (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 240 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_DrakSlime:: ; heuristic: stream decompressed while the game ran on the emulator; C0
Data_074_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D0001, $F0

; compressed 6 x 6 picture (36 tiles) of monster id $002 (SpotSlime); 1 other ids point here too (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 145 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_SpotSlime:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_40F1:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D00F1, $91

; compressed 6 x 6 picture (36 tiles) of monster id $003 (WingSlime) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 290 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_WingSlime:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_4182:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D0182, $122

; compressed 6 x 6 picture (36 tiles) of monster id $004 (TreeSlime) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 163 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_TreeSlime:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_42A4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D02A4, $A3

; compressed 6 x 6 picture (36 tiles) of monster id $005 (Snaily) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 183 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Snaily:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_4347:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D0347, $B7

; compressed 6 x 6 picture (36 tiles) of monster id $006 (SlimeNite) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 251 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_SlimeNite:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_43FE:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D03FE, $FB

; compressed 6 x 6 picture (36 tiles) of monster id $007 (Babble) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 183 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Babble:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_44F9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D04F9, $B7

; compressed 6 x 6 picture (36 tiles) of monster id $008 (BoxSlime) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 182 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_BoxSlime:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_45B0:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D05B0, $B6

; compressed 6 x 6 picture (36 tiles) of monster id $009 (PearlGel) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 265 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_PearlGel:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_4666:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D0666, $109

; compressed 6 x 6 picture (36 tiles) of monster id $00A (Slime) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 101 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Slime:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_476F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D076F, $65

; compressed 6 x 6 picture (36 tiles) of monster id $00B (Healer) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 156 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Healer:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_47D4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D07D4, $9C

; compressed 6 x 6 picture (36 tiles) of monster id $00C (FangSlime) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 231 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_FangSlime:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_4870:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D0870, $E7

; compressed 6 x 6 picture (36 tiles) of monster id $00D (RockSlime) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 148 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_RockSlime:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_4957:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D0957, $94

; compressed 6 x 6 picture (36 tiles) of monster id $00E (SlimeBorg) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 172 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_SlimeBorg:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_49EB:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D09EB, $AC

; compressed 6 x 6 picture (36 tiles) of monster id $00F (Slabbit) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 196 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Slabbit:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_4A97:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D0A97, $C4

; compressed 6 x 6 picture (36 tiles) of monster id $010 (KingSlime) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 328 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_KingSlime:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_4B5B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D0B5B, $148

; compressed 6 x 6 picture (36 tiles) of monster id $011 (Metaly) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 101 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Metaly:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_4CA3:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D0CA3, $65

; compressed 6 x 6 picture (36 tiles) of monster id $012 (Metabble) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 183 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Metabble:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_4D08:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D0D08, $B7

; compressed 6 x 6 picture (36 tiles) of monster id $013 (SpotKing) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 358 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_SpotKing:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_4DBF:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D0DBF, $166

; compressed 6 x 6 picture (36 tiles) of monster id $014 (TropicGel) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 217 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_TropicGel:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_4F25:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D0F25, $D9

; compressed 6 x 6 picture (36 tiles) of monster id $015 (MimeSlime) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 266 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_MimeSlime:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_4FFE:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D0FFE, $10A

; compressed 6 x 6 picture (36 tiles) of monster id $016 (HaloSlime) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 171 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_HaloSlime:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_5108:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D1108, $AB

; compressed 6 x 6 picture (36 tiles) of monster id $017 (MetalKing) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 329 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_MetalKing:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_51B3:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D11B3, $149

; compressed 6 x 6 picture (36 tiles) of monster id $018 (GoldSlime) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 491 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_GoldSlime:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_52FC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D12FC, $1EB

; compressed 6 x 6 picture (36 tiles) of monster id $019 (GranSlime) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 509 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_GranSlime:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_54E7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D14E7, $1FD

; compressed 6 x 6 picture (36 tiles) of monster id $01A (WonderEgg) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 142 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_WonderEgg:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_56E4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D16E4, $8E

; compressed 6 x 6 picture (36 tiles) of monster id $024 (DragonKid) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 302 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_DragonKid:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_5772:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D1772, $12E

; compressed 6 x 6 picture (36 tiles) of monster id $025 (Tortragon) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 380 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Tortragon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_58A0:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D18A0, $17C

; compressed 6 x 6 picture (36 tiles) of monster id $026 (Pteranod) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 342 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Pteranod:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_5A1C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D1A1C, $156

; compressed 6 x 6 picture (36 tiles) of monster id $027 (Gasgon) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 437 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Gasgon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_5B72:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D1B72, $1B5

; compressed 6 x 6 picture (36 tiles) of monster id $028 (FairyDrak) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 301 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_FairyDrak:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_5D27:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D1D27, $12D

; compressed 6 x 6 picture (36 tiles) of monster id $029 (LizardMan) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 478 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_LizardMan:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_5E54:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D1E54, $1DE

; compressed 6 x 6 picture (36 tiles) of monster id $02A (Poisongon) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 384 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Poisongon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_6032:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D2032, $180

; compressed 6 x 6 picture (36 tiles) of monster id $02B (Swordgon) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 478 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Swordgon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_61B2:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D21B2, $1DE

; compressed 6 x 6 picture (36 tiles) of monster id $02C (Drygon) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 461 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Drygon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_6390:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D2390, $1CD

; compressed 6 x 6 picture (36 tiles) of monster id $02D (Dragon) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 382 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Dragon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_655D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D255D, $17E

; compressed 6 x 6 picture (36 tiles) of monster id $02E (MiniDrak) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 236 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_MiniDrak:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_66DB:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D26DB, $EC

; compressed 6 x 6 picture (36 tiles) of monster id $02F (MadDragon) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 495 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_MadDragon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_67C7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D27C7, $1EF

; compressed 6 x 6 picture (36 tiles) of monster id $030 (Rayburn) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 432 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Rayburn:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_69B6:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D29B6, $1B0

; compressed 6 x 6 picture (36 tiles) of monster id $031 (Chamelgon) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 287 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Chamelgon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_6B66:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D2B66, $11F

; compressed 6 x 6 picture (36 tiles) of monster id $032 (LizardFly) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 384 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_LizardFly:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_6C85:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D2C85, $180

; compressed 6 x 6 picture (36 tiles) of monster id $033 (Andreal) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 460 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Andreal:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_6E05:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D2E05, $1CC

; compressed 6 x 6 picture (36 tiles) of monster id $034 (KingCobra) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 240 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_KingCobra:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_6FD1:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D2FD1, $F0

; compressed 6 x 6 picture (36 tiles) of monster id $035 (Vampirus) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 444 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Vampirus:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_70C1:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D30C1, $1BC

; compressed 6 x 6 picture (36 tiles) of monster id $036 (SnakeBat) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 356 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_SnakeBat:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_727D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D327D, $164

; compressed 6 x 6 picture (36 tiles) of monster id $037 (Spikerous) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 320 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Spikerous:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_73E1:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D33E1, $140

; compressed 6 x 6 picture (36 tiles) of monster id $038 (GreatDrak) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 529 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_GreatDrak:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_7521:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D3521, $211

; compressed 6 x 6 picture (36 tiles) of monster id $039 (Crestpent) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 376 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Crestpent:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_7732:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D3732, $178

; compressed 6 x 6 picture (36 tiles) of monster id $03A (WingSnake) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 479 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_WingSnake:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_78AA:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D38AA, $1DF

; compressed 6 x 6 picture (36 tiles) of monster id $03B (Coatol) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 460 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Coatol:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_7A89:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D3A89, $1CC

; compressed 6 x 6 picture (36 tiles) of monster id $03C (Orochi) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 449 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Orochi:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_7C55:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D3C55, $1C1

; compressed 6 x 6 picture (36 tiles) of monster id $03D (BattleRex) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 416 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_BattleRex:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_074_7E16:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D3E16, $1A0
    ds $4A, $00
