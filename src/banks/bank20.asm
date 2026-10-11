SECTION "Bank 20", ROMX[$4000], BANK[$20]
    db $20

; compressed sprite graphics of monster id $001 (DrakSlime); 68 other ids point here too (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 208 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_DrakSlime:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $080001, $D0

; compressed sprite graphics of monster id $002 (SpotSlime) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 233 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_SpotSlime:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_40D1:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0800D1, $E9

; compressed sprite graphics of monster id $003 (WingSlime) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 186 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_WingSlime:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_41BA:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0801BA, $BA

; compressed sprite graphics of monster id $004 (TreeSlime) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 175 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_TreeSlime:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_4274:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $080274, $AF

; compressed sprite graphics of monster id $005 (Snaily) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 229 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Snaily:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_4323:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $080323, $E5

; compressed sprite graphics of monster id $006 (SlimeNite) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 222 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_SlimeNite:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_4408:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $080408, $DE

; compressed sprite graphics of monster id $007 (Babble) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 188 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Babble:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_44E6:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0804E6, $BC

; compressed sprite graphics of monster id $008 (BoxSlime) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 130 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_BoxSlime:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_45A2:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0805A2, $82

; compressed sprite graphics of monster id $009 (PearlGel) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 192 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_PearlGel:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_4624:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $080624, $C0

; compressed sprite graphics of monster id $00A (Slime) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 102 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Slime:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_46E4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0806E4, $66

; compressed sprite graphics of monster id $00B (Healer) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 174 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Healer:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_474A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08074A, $AE

; compressed sprite graphics of monster id $00C (FangSlime) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 225 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_FangSlime:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_47F8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0807F8, $E1

; compressed sprite graphics of monster id $00D (RockSlime) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 226 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_RockSlime:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_48D9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0808D9, $E2

; compressed sprite graphics of monster id $00E (SlimeBorg) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 195 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_SlimeBorg:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_49BB:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0809BB, $C3

; compressed sprite graphics of monster id $00F (Slabbit) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 173 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Slabbit:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_4A7E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $080A7E, $AD

; compressed sprite graphics of monster id $010 (KingSlime) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 184 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_KingSlime:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_4B2B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $080B2B, $B8

; compressed sprite graphics of monster id $011 (Metaly) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 102 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Metaly:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_4BE3:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $080BE3, $66

; compressed sprite graphics of monster id $012 (Metabble) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 188 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Metabble:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_4C49:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $080C49, $BC

; compressed sprite graphics of monster id $013 (SpotKing) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 226 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_SpotKing:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_4D05:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $080D05, $E2

; compressed sprite graphics of monster id $014 (TropicGel) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 209 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_TropicGel:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_4DE7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $080DE7, $D1

; compressed sprite graphics of monster id $015 (MimeSlime) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 236 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_MimeSlime:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_4EB8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $080EB8, $EC

; compressed sprite graphics of monster id $016 (HaloSlime) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 139 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_HaloSlime:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_4FA4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $080FA4, $8B

; compressed sprite graphics of monster id $017 (MetalKing) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 184 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_MetalKing:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_502F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08102F, $B8

; compressed sprite graphics of monster id $018 (GoldSlime) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 146 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_GoldSlime:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_50E7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0810E7, $92

; compressed sprite graphics of monster id $019 (GranSlime) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 138 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_GranSlime:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_5179:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $081179, $8A

; compressed sprite graphics of monster id $01A (WonderEgg) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 169 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_WonderEgg:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_5203:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $081203, $A9

; compressed sprite graphics of monster id $024 (DragonKid) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 200 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_DragonKid:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_52AC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0812AC, $C8

; compressed sprite graphics of monster id $025 (Tortragon) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 228 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Tortragon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_5374:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $081374, $E4

; compressed sprite graphics of monster id $026 (Pteranod) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 221 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Pteranod:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_5458:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $081458, $DD

; compressed sprite graphics of monster id $027 (Gasgon) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 246 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Gasgon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_5535:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $081535, $F6

; compressed sprite graphics of monster id $028 (FairyDrak) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 222 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_FairyDrak:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_562B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08162B, $DE

; compressed sprite graphics of monster id $029 (LizardMan) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 237 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_LizardMan:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_5709:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $081709, $ED

; compressed sprite graphics of monster id $02A (Poisongon) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 245 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Poisongon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_57F6:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0817F6, $F5

; compressed sprite graphics of monster id $02B (Swordgon) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 242 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Swordgon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_58EB:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0818EB, $F2

; compressed sprite graphics of monster id $02C (Drygon) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 238 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Drygon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_59DD:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0819DD, $EE

; compressed sprite graphics of monster id $02D (Dragon) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 213 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Dragon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_5ACB:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $081ACB, $D5

; compressed sprite graphics of monster id $02E (MiniDrak) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 230 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_MiniDrak:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_5BA0:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $081BA0, $E6

; compressed sprite graphics of monster id $02F (MadDragon) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 252 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_MadDragon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_5C86:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $081C86, $FC

; compressed sprite graphics of monster id $030 (Rayburn) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 231 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Rayburn:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_5D82:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $081D82, $E7

; compressed sprite graphics of monster id $031 (Chamelgon) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 208 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Chamelgon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_5E69:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $081E69, $D0

; compressed sprite graphics of monster id $032 (LizardFly) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 194 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_LizardFly:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_5F39:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $081F39, $C2

; compressed sprite graphics of monster id $033 (Andreal) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 231 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Andreal:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_5FFB:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $081FFB, $E7

; compressed sprite graphics of monster id $034 (KingCobra) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 231 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_KingCobra:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_60E2:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0820E2, $E7

; compressed sprite graphics of monster id $035 (Vampirus) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 203 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Vampirus:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_61C9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0821C9, $CB

; compressed sprite graphics of monster id $036 (SnakeBat) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 194 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_SnakeBat:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_6294:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $082294, $C2

; compressed sprite graphics of monster id $037 (Spikerous) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 228 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Spikerous:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_6356:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $082356, $E4

; compressed sprite graphics of monster id $038 (GreatDrak) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 239 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_GreatDrak:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_643A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08243A, $EF

; compressed sprite graphics of monster id $039 (Crestpent) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 236 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Crestpent:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_6529:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $082529, $EC

; compressed sprite graphics of monster id $03A (WingSnake) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 216 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_WingSnake:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_6615:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $082615, $D8

; compressed sprite graphics of monster id $03B (Coatol) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 238 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Coatol:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_66ED:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0826ED, $EE

; compressed sprite graphics of monster id $03C (Orochi) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 245 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Orochi:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_67DB:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0827DB, $F5

; compressed sprite graphics of monster id $03D (BattleRex) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 232 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_BattleRex:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_68D0:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0828D0, $E8

; compressed sprite graphics of monster id $03E (SkyDragon) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 255 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_SkyDragon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_69B8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0829B8, $FF

; compressed sprite graphics of monster id $03F (Serpentia) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 245 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Serpentia:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_6AB7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $082AB7, $F5

; compressed sprite graphics of monster id $040 (Divinegon) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 255 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Divinegon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_6BAC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $082BAC, $FF

; compressed sprite graphics of monster id $041 (Orligon) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 227 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Orligon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_6CAB:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $082CAB, $E3

; compressed sprite graphics of monster id $042 (GigaDraco) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 239 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_GigaDraco:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_6D8E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $082D8E, $EF

; compressed sprite graphics of monster id $047 (Tonguella) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 232 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Tonguella:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_6E7D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $082E7D, $E8

; compressed sprite graphics of monster id $048 (Almiraj) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 234 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Almiraj:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_6F65:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $082F65, $EA

; compressed sprite graphics of monster id $049 (CatFly) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 220 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_CatFly:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_704F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08304F, $DC

; compressed sprite graphics of monster id $04A (PillowRat) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 203 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_PillowRat:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_712B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08312B, $CB

; compressed sprite graphics of monster id $04B (Saccer) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 168 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Saccer:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_71F6:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0831F6, $A8

; compressed sprite graphics of monster id $04C (GulpBeast) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 243 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_GulpBeast:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_729E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08329E, $F3

; compressed sprite graphics of monster id $04D (Skullroo) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 225 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Skullroo:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_7391:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $083391, $E1

; compressed sprite graphics of monster id $04E (WindBeast) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 253 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_WindBeast:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_7472:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $083472, $FD

; compressed sprite graphics of monster id $04F (Beavern) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 218 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Beavern:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_756F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08356F, $DA

; compressed sprite graphics of monster id $050 (Antbear) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 222 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Antbear:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_7649:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $083649, $DE

; compressed sprite graphics of monster id $051 (SuperTen) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 252 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_SuperTen:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_7727:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $083727, $FC

; compressed sprite graphics of monster id $052 (IronTurt) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 247 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_IronTurt:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_7823:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $083823, $F7

; compressed sprite graphics of monster id $053 (Mommonja) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 230 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Mommonja:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_791A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08391A, $E6

; compressed sprite graphics of monster id $054 (HammerMan) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 185 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_HammerMan:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_7A00:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $083A00, $B9

; compressed sprite graphics of monster id $055 (Grizzly) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 214 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Grizzly:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_7AB9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $083AB9, $D6

; compressed sprite graphics of monster id $056 (Yeti) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 212 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Yeti:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_7B8F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $083B8F, $D4

; compressed sprite graphics of monster id $057 (ArrowDog) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 216 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_ArrowDog:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_7C63:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $083C63, $D8

; compressed sprite graphics of monster id $058 (NoctoKing) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 177 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_NoctoKing:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_7D3B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $083D3B, $B1

; compressed sprite graphics of monster id $059 (BeastNite) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 232 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_BeastNite:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_020_7DEC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $083DEC, $E8
    ds $12C, $00
