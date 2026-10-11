SECTION "Bank 22", ROMX[$4000], BANK[$22]
    db $22

; compressed sprite graphics of monster id $0B8 (Pyuro) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 210 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Pyuro:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $088001, $D2

; compressed sprite graphics of monster id $0B9 (ArmyAnt) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 199 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_ArmyAnt:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_40D3:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0880D3, $C7

; compressed sprite graphics of monster id $0BA (GoHopper) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 181 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_GoHopper:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_419A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08819A, $B5

; compressed sprite graphics of monster id $0BB (TailEater) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 224 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_TailEater:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_424F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08824F, $E0

; compressed sprite graphics of monster id $0BC (ArmorPede) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 213 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_ArmorPede:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_432F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08832F, $D5

; compressed sprite graphics of monster id $0BD (Eyeder) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 237 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Eyeder:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_4404:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $088404, $ED

; compressed sprite graphics of monster id $0BE (GiantMoth) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 207 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_GiantMoth:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_44F1:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0884F1, $CF

; compressed sprite graphics of monster id $0BF (Droll) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 211 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Droll:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_45C0:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0885C0, $D3

; compressed sprite graphics of monster id $0C0 (ArmyCrab) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 203 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_ArmyCrab:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_4693:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $088693, $CB

; compressed sprite graphics of monster id $0C1 (MadHornet) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 220 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_MadHornet:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_475E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08875E, $DC

; compressed sprite graphics of monster id $0C2 (Belzebub) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 209 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Belzebub:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_483A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08883A, $D1

; compressed sprite graphics of monster id $0C3 (WarMantis) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 234 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_WarMantis:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_490B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08890B, $EA

; compressed sprite graphics of monster id $0C4 (HornBeet) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 183 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_HornBeet:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_49F5:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0889F5, $B7

; compressed sprite graphics of monster id $0C5 (Sickler) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 227 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Sickler:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_4AAC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $088AAC, $E3

; compressed sprite graphics of monster id $0C6 (Armorpion) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 246 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Armorpion:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_4B8F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $088B8F, $F6

; compressed sprite graphics of monster id $0C7 (Digster) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 243 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Digster:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_4C85:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $088C85, $F3

; compressed sprite graphics of monster id $0C8 (Skularach) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 241 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Skularach:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_4D78:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $088D78, $F1

; compressed sprite graphics of monster id $0C9 (MultiEyes) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 252 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_MultiEyes:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_4E69:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $088E69, $FC

; compressed sprite graphics of monster id $0D3 (Pixy) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 187 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Pixy:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_4F65:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $088F65, $BB

; compressed sprite graphics of monster id $0D4 (MedusaEye) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 237 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_MedusaEye:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_5020:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $089020, $ED

; compressed sprite graphics of monster id $0D5 (AgDevil) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 224 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_AgDevil:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_510D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08910D, $E0

; compressed sprite graphics of monster id $0D6 (Demonite) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 201 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Demonite:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_51ED:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0891ED, $C9

; compressed sprite graphics of monster id $0D7 (DarkEye) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 197 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_DarkEye:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_52B6:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0892B6, $C5

; compressed sprite graphics of monster id $0D8 (EyeBall) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 202 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_EyeBall:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_537B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08937B, $CA

; compressed sprite graphics of monster id $0D9 (SkulRider) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 208 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_SkulRider:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_5445:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $089445, $D0

; compressed sprite graphics of monster id $0DA (EvilBeast) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 257 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_EvilBeast:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_5515:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $089515, $101

; compressed sprite graphics of monster id $0DB (Bubblemon) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 207 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Bubblemon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_5616:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $089616, $CF

; compressed sprite graphics of monster id $0DC (1EyeClown) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 219 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_1EyeClown:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_56E5:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0896E5, $DB

; compressed sprite graphics of monster id $0DD (Gremlin) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 174 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Gremlin:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_57C0:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0897C0, $AE

; compressed sprite graphics of monster id $0DE (ArcDemon) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 236 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_ArcDemon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_586E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08986E, $EC

; compressed sprite graphics of monster id $0DF (Lionex) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 254 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Lionex:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_595A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08995A, $FE

; compressed sprite graphics of monster id $0E0 (GoatHorn) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 225 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_GoatHorn:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_5A58:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $089A58, $E1

; compressed sprite graphics of monster id $0E1 (Orc) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 254 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Orc:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_5B39:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $089B39, $FE

; compressed sprite graphics of monster id $0E2 (Ogre) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 233 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Ogre:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_5C37:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $089C37, $E9

; compressed sprite graphics of monster id $0E3 (GateGuard) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 219 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_GateGuard:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_5D20:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $089D20, $DB

; compressed sprite graphics of monster id $0E4 (ChopClown) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 232 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_ChopClown:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_5DFB:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $089DFB, $E8

; compressed sprite graphics of monster id $0E5 (BossTroll) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 231 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_BossTroll:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_5EE3:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $089EE3, $E7

; compressed sprite graphics of monster id $0E6 (Grendal) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 220 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Grendal:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_5FCA:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $089FCA, $DC

; compressed sprite graphics of monster id $0E7 (Akubar) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 256 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Akubar:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_60A6:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08A0A6, $100

; compressed sprite graphics of monster id $0E8 (MadKnight) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 251 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_MadKnight:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_61A6:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08A1A6, $FB

; compressed sprite graphics of monster id $0E9 (EvilWell) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 241 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_EvilWell:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_62A1:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08A2A1, $F1

; compressed sprite graphics of monster id $0EA (Gigantes) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 241 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Gigantes:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_6392:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08A392, $F1

; compressed sprite graphics of monster id $0EB (Centasaur) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 248 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Centasaur:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_6483:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08A483, $F8

; compressed sprite graphics of monster id $0EC (EvilArmor) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 222 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_EvilArmor:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_657B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08A57B, $DE

; compressed sprite graphics of monster id $0ED (Jamirus) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 244 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Jamirus:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_6659:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08A659, $F4

; compressed sprite graphics of monster id $0EE (Durran) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 255 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Durran:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_674D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08A74D, $FF

; compressed sprite graphics of monster id $0EF (Titanis) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 232 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Titanis:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_684C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08A84C, $E8

; compressed sprite graphics of monster id $0F0 (LampGenie) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 197 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_LampGenie:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_6934:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08A934, $C5

; compressed sprite graphics of monster id $0F6 (Spooky) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 197 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Spooky:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_69F9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08A9F9, $C5

; compressed sprite graphics of monster id $0F7 (Skullgon) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 257 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Skullgon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_6ABE:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08AABE, $101

; compressed sprite graphics of monster id $0F8 (PutrePup) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 225 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_PutrePup:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_6BBF:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08ABBF, $E1

; compressed sprite graphics of monster id $0F9 (RotRaven) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 229 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_RotRaven:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_6CA0:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08ACA0, $E5

; compressed sprite graphics of monster id $0FA (Mummy) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 220 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Mummy:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_6D85:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08AD85, $DC

; compressed sprite graphics of monster id $0FB (DarkCrab) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 202 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_DarkCrab:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_6E61:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08AE61, $CA

; compressed sprite graphics of monster id $0FC (DeadNite) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 215 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_DeadNite:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_6F2B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08AF2B, $D7

; compressed sprite graphics of monster id $0FD (Shadow) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 180 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Shadow:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_7002:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08B002, $B4

; compressed sprite graphics of monster id $0FE (Skulpent) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 233 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Skulpent:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_70B6:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08B0B6, $E9

; compressed sprite graphics of monster id $0FF (Hork) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 216 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Hork:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_719F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08B19F, $D8

; compressed sprite graphics of monster id $100 (Mudron) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 232 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Mudron:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_7277:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08B277, $E8

; compressed sprite graphics of monster id $101 (NiteWhip) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 238 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_NiteWhip:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_735F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08B35F, $EE

; compressed sprite graphics of monster id $102 (WindMerge) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 209 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_WindMerge:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_744D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08B44D, $D1

; compressed sprite graphics of monster id $103 (Reaper) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 182 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Reaper:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_751E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08B51E, $B6

; compressed sprite graphics of monster id $104 (Inverzon) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 226 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Inverzon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_75D4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08B5D4, $E2

; compressed sprite graphics of monster id $105 (FoxFire) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 239 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_FoxFire:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_76B6:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08B6B6, $EF

; compressed sprite graphics of monster id $106 (CaptDead) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 239 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_CaptDead:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_77A5:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08B7A5, $EF

; compressed sprite graphics of monster id $107 (DeadNoble) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 249 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_DeadNoble:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_7894:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08B894, $F9

; compressed sprite graphics of monster id $108 (WhiteKing) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 213 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_WhiteKing:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_798D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08B98D, $D5

; compressed sprite graphics of monster id $17C (Lamia) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 210 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Lamia:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_7A62:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08BA62, $D2

; compressed sprite graphics of monster id $17D (Dimensaur) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 226 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Dimensaur:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_7B34:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08BB34, $E2

; compressed sprite graphics of monster id $17E (Kagebou) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 195 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Kagebou:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_022_7C16:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $08BC16, $C3
    ds $327, $00
