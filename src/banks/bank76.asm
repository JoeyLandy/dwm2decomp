SECTION "Bank 76", ROMX[$4000], BANK[$76]
    db $76

; compressed 6 x 6 picture (36 tiles) of monster id $06F (MadPecker) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 281 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_MadPecker:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D8001, $119

; compressed 6 x 6 picture (36 tiles) of monster id $070 (MadRaven) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 261 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_MadRaven:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_411A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D811A, $105

; compressed 6 x 6 picture (36 tiles) of monster id $071 (MistyWing) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 221 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_MistyWing:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_421F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D821F, $DD

; compressed 6 x 6 picture (36 tiles) of monster id $072 (AquaHawk) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 368 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_AquaHawk:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_42FC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D82FC, $170

; compressed 6 x 6 picture (36 tiles) of monster id $073 (Dracky) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 186 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Dracky:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_446C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D846C, $BA

; compressed 6 x 6 picture (36 tiles) of monster id $074 (KiteHawk) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 372 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_KiteHawk:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_4526:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D8526, $174

; compressed 6 x 6 picture (36 tiles) of monster id $075 (BigRoost) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 432 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_BigRoost:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_469A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D869A, $1B0

; compressed 6 x 6 picture (36 tiles) of monster id $076 (StubBird) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 286 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_StubBird:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_484A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D884A, $11E

; compressed 6 x 6 picture (36 tiles) of monster id $077 (LandOwl) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 397 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_LandOwl:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_4968:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D8968, $18D

; compressed 6 x 6 picture (36 tiles) of monster id $078 (MadGoose) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 380 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_MadGoose:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_4AF5:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D8AF5, $17C

; compressed 6 x 6 picture (36 tiles) of monster id $079 (MadCondor) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 438 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_MadCondor:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_4C71:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D8C71, $1B6

; compressed 6 x 6 picture (36 tiles) of monster id $07A (Emyu) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 311 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Emyu:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_4E27:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D8E27, $137

; compressed 6 x 6 picture (36 tiles) of monster id $07B (Blizzardy) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 451 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Blizzardy:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_4F5E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D8F5E, $1C3

; compressed 6 x 6 picture (36 tiles) of monster id $07C (Phoenix) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 454 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Phoenix:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_5121:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D9121, $1C6

; compressed 6 x 6 picture (36 tiles) of monster id $07D (ZapBird) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 448 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_ZapBird:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_52E7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D92E7, $1C0

; compressed 6 x 6 picture (36 tiles) of monster id $07E (Garudian) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 491 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Garudian:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_54A7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D94A7, $1EB

; compressed 6 x 6 picture (36 tiles) of monster id $07F (WhipBird) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 461 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_WhipBird:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_5692:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D9692, $1CD

; compressed 6 x 6 picture (36 tiles) of monster id $080 (FunkyBird) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 382 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_FunkyBird:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_585F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D985F, $17E

; compressed 6 x 6 picture (36 tiles) of monster id $081 (RainHawk) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 509 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_RainHawk:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_59DD:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D99DD, $1FD

; compressed 6 x 6 picture (36 tiles) of monster id $082 (Azurile) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 472 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Azurile:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_5BDA:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D9BDA, $1D8

; compressed 6 x 6 picture (36 tiles) of monster id $083 (Shantak) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 524 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Shantak:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_5DB2:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D9DB2, $20C

; compressed 6 x 6 picture (36 tiles) of monster id $084 (CragDevil) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 288 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_CragDevil:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_5FBE:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1D9FBE, $120

; compressed 6 x 6 picture (36 tiles) of monster id $08E (FireWeed) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 363 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_FireWeed:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_60DE:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1DA0DE, $16B

; compressed 6 x 6 picture (36 tiles) of monster id $08F (FloraMan) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 484 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_FloraMan:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_6249:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1DA249, $1E4

; compressed 6 x 6 picture (36 tiles) of monster id $090 (WingTree) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 360 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_WingTree:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_642D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1DA42D, $168

; compressed 6 x 6 picture (36 tiles) of monster id $091 (CactiBall) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 344 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_CactiBall:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_6595:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1DA595, $158

; compressed 6 x 6 picture (36 tiles) of monster id $092 (Gulpple) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 271 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Gulpple:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_66ED:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1DA6ED, $10F

; compressed 6 x 6 picture (36 tiles) of monster id $093 (Toadstool) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 270 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Toadstool:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_67FC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1DA7FC, $10E

; compressed 6 x 6 picture (36 tiles) of monster id $094 (AmberWeed) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 398 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_AmberWeed:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_690A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1DA90A, $18E

; compressed 6 x 6 picture (36 tiles) of monster id $095 (Slurperon) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 271 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Slurperon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_6A98:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1DAA98, $10F

; compressed 6 x 6 picture (36 tiles) of monster id $096 (Stubsuck) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 336 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Stubsuck:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_6BA7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1DABA7, $150

; compressed 6 x 6 picture (36 tiles) of monster id $097 (Oniono) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 317 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Oniono:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_6CF7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1DACF7, $13D

; compressed 6 x 6 picture (36 tiles) of monster id $098 (DanceVegi) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 296 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_DanceVegi:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_6E34:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1DAE34, $128

; compressed 6 x 6 picture (36 tiles) of monster id $099 (TreeBoy) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 382 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_TreeBoy:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_6F5C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1DAF5C, $17E

; compressed 6 x 6 picture (36 tiles) of monster id $09A (Devipine) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 242 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Devipine:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_70DA:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1DB0DA, $F2

; compressed 6 x 6 picture (36 tiles) of monster id $09B (FaceTree) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 440 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_FaceTree:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_71CC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1DB1CC, $1B8

; compressed 6 x 6 picture (36 tiles) of monster id $09C (HerbMan) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 428 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_HerbMan:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_7384:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1DB384, $1AC

; compressed 6 x 6 picture (36 tiles) of monster id $09D (BeanMan) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 320 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_BeanMan:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_7530:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1DB530, $140

; compressed 6 x 6 picture (36 tiles) of monster id $09E (EvilSeed) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 242 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_EvilSeed:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_7670:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1DB670, $F2

; compressed 6 x 6 picture (36 tiles) of monster id $09F (ManEater) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 385 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_ManEater:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_7762:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1DB762, $181

; compressed 6 x 6 picture (36 tiles) of monster id $0A0 (Snapper) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 369 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Snapper:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_78E3:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1DB8E3, $171

; compressed 6 x 6 picture (36 tiles) of monster id $0A1 (GhosTree) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 293 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_GhosTree:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_7A54:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1DBA54, $125

; compressed 6 x 6 picture (36 tiles) of monster id $0A2 (Rosevine) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 529 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Rosevine:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_7B79:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1DBB79, $211

; compressed 6 x 6 picture (36 tiles) of monster id $17C (Lamia) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 503 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Lamia:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_076_7D8A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1DBD8A, $1F5
    ds $81, $00
