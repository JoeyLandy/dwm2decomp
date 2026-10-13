; ROM bank $22: compressed monster sprites
; The annotated listing of this bank is build/listing/bank22.asm.

SECTION "Bank 22", ROMX[$4000], BANK[$22]
    db $22

; compressed sprite graphics of monster id $0B8 (Pyuro) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 210 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Pyuro::
    INCBIN "dwm2-cobi-us.gbc", $088001, $D2

; compressed sprite graphics of monster id $0B9 (ArmyAnt) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 199 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_ArmyAnt::
    INCBIN "dwm2-cobi-us.gbc", $0880D3, $C7

; compressed sprite graphics of monster id $0BA (GoHopper) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 181 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_GoHopper::
    INCBIN "dwm2-cobi-us.gbc", $08819A, $B5

; compressed sprite graphics of monster id $0BB (TailEater) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 224 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_TailEater::
    INCBIN "dwm2-cobi-us.gbc", $08824F, $E0

; compressed sprite graphics of monster id $0BC (ArmorPede) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 213 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_ArmorPede::
    INCBIN "dwm2-cobi-us.gbc", $08832F, $D5

; compressed sprite graphics of monster id $0BD (Eyeder) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 237 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Eyeder::
    INCBIN "dwm2-cobi-us.gbc", $088404, $ED

; compressed sprite graphics of monster id $0BE (GiantMoth) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 207 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_GiantMoth::
    INCBIN "dwm2-cobi-us.gbc", $0884F1, $CF

; compressed sprite graphics of monster id $0BF (Droll) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 211 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Droll::
    INCBIN "dwm2-cobi-us.gbc", $0885C0, $D3

; compressed sprite graphics of monster id $0C0 (ArmyCrab) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 203 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_ArmyCrab::
    INCBIN "dwm2-cobi-us.gbc", $088693, $CB

; compressed sprite graphics of monster id $0C1 (MadHornet) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 220 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MadHornet::
    INCBIN "dwm2-cobi-us.gbc", $08875E, $DC

; compressed sprite graphics of monster id $0C2 (Belzebub) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 209 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Belzebub::
    INCBIN "dwm2-cobi-us.gbc", $08883A, $D1

; compressed sprite graphics of monster id $0C3 (WarMantis) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 234 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_WarMantis::
    INCBIN "dwm2-cobi-us.gbc", $08890B, $EA

; compressed sprite graphics of monster id $0C4 (HornBeet) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 183 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_HornBeet::
    INCBIN "dwm2-cobi-us.gbc", $0889F5, $B7

; compressed sprite graphics of monster id $0C5 (Sickler) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 227 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Sickler::
    INCBIN "dwm2-cobi-us.gbc", $088AAC, $E3

; compressed sprite graphics of monster id $0C6 (Armorpion) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 246 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Armorpion::
    INCBIN "dwm2-cobi-us.gbc", $088B8F, $F6

; compressed sprite graphics of monster id $0C7 (Digster) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 243 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Digster::
    INCBIN "dwm2-cobi-us.gbc", $088C85, $F3

; compressed sprite graphics of monster id $0C8 (Skularach) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 241 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Skularach::
    INCBIN "dwm2-cobi-us.gbc", $088D78, $F1

; compressed sprite graphics of monster id $0C9 (MultiEyes) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 252 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MultiEyes::
    INCBIN "dwm2-cobi-us.gbc", $088E69, $FC

; compressed sprite graphics of monster id $0D3 (Pixy) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 187 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Pixy::
    INCBIN "dwm2-cobi-us.gbc", $088F65, $BB

; compressed sprite graphics of monster id $0D4 (MedusaEye) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 237 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MedusaEye::
    INCBIN "dwm2-cobi-us.gbc", $089020, $ED

; compressed sprite graphics of monster id $0D5 (AgDevil) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 224 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_AgDevil::
    INCBIN "dwm2-cobi-us.gbc", $08910D, $E0

; compressed sprite graphics of monster id $0D6 (Demonite) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 201 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Demonite::
    INCBIN "dwm2-cobi-us.gbc", $0891ED, $C9

; compressed sprite graphics of monster id $0D7 (DarkEye) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 197 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_DarkEye::
    INCBIN "dwm2-cobi-us.gbc", $0892B6, $C5

; compressed sprite graphics of monster id $0D8 (EyeBall) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 202 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_EyeBall::
    INCBIN "dwm2-cobi-us.gbc", $08937B, $CA

; compressed sprite graphics of monster id $0D9 (SkulRider) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 208 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_SkulRider::
    INCBIN "dwm2-cobi-us.gbc", $089445, $D0

; compressed sprite graphics of monster id $0DA (EvilBeast) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 257 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_EvilBeast::
    INCBIN "dwm2-cobi-us.gbc", $089515, $101

; compressed sprite graphics of monster id $0DB (Bubblemon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 207 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Bubblemon::
    INCBIN "dwm2-cobi-us.gbc", $089616, $CF

; compressed sprite graphics of monster id $0DC (1EyeClown) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 219 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_1EyeClown::
    INCBIN "dwm2-cobi-us.gbc", $0896E5, $DB

; compressed sprite graphics of monster id $0DD (Gremlin) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 174 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Gremlin::
    INCBIN "dwm2-cobi-us.gbc", $0897C0, $AE

; compressed sprite graphics of monster id $0DE (ArcDemon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 236 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_ArcDemon::
    INCBIN "dwm2-cobi-us.gbc", $08986E, $EC

; compressed sprite graphics of monster id $0DF (Lionex) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 254 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Lionex::
    INCBIN "dwm2-cobi-us.gbc", $08995A, $FE

; compressed sprite graphics of monster id $0E0 (GoatHorn) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 225 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_GoatHorn::
    INCBIN "dwm2-cobi-us.gbc", $089A58, $E1

; compressed sprite graphics of monster id $0E1 (Orc) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
MonsterSprite_Orc::
    INCBIN "dwm2-cobi-us.gbc", $089B39, $FE

; compressed sprite graphics of monster id $0E2 (Ogre) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 233 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Ogre::
    INCBIN "dwm2-cobi-us.gbc", $089C37, $E9

; compressed sprite graphics of monster id $0E3 (GateGuard) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 219 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_GateGuard::
    INCBIN "dwm2-cobi-us.gbc", $089D20, $DB

; compressed sprite graphics of monster id $0E4 (ChopClown) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 232 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_ChopClown::
    INCBIN "dwm2-cobi-us.gbc", $089DFB, $E8

; compressed sprite graphics of monster id $0E5 (BossTroll) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 231 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_BossTroll::
    INCBIN "dwm2-cobi-us.gbc", $089EE3, $E7

; compressed sprite graphics of monster id $0E6 (Grendal) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 220 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Grendal::
    INCBIN "dwm2-cobi-us.gbc", $089FCA, $DC

; compressed sprite graphics of monster id $0E7 (Akubar) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 256 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Akubar::
    INCBIN "dwm2-cobi-us.gbc", $08A0A6, $100

; compressed sprite graphics of monster id $0E8 (MadKnight) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 251 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MadKnight::
    INCBIN "dwm2-cobi-us.gbc", $08A1A6, $FB

; compressed sprite graphics of monster id $0E9 (EvilWell) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 241 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_EvilWell::
    INCBIN "dwm2-cobi-us.gbc", $08A2A1, $F1

; compressed sprite graphics of monster id $0EA (Gigantes) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
MonsterSprite_Gigantes::
    INCBIN "dwm2-cobi-us.gbc", $08A392, $F1

; compressed sprite graphics of monster id $0EB (Centasaur) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 248 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Centasaur::
    INCBIN "dwm2-cobi-us.gbc", $08A483, $F8

; compressed sprite graphics of monster id $0EC (EvilArmor) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 222 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_EvilArmor::
    INCBIN "dwm2-cobi-us.gbc", $08A57B, $DE

; compressed sprite graphics of monster id $0ED (Jamirus) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 244 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Jamirus::
    INCBIN "dwm2-cobi-us.gbc", $08A659, $F4

; compressed sprite graphics of monster id $0EE (Durran) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 255 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Durran::
    INCBIN "dwm2-cobi-us.gbc", $08A74D, $FF

; compressed sprite graphics of monster id $0EF (Titanis) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 232 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Titanis::
    INCBIN "dwm2-cobi-us.gbc", $08A84C, $E8

; compressed sprite graphics of monster id $0F0 (LampGenie) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 197 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_LampGenie::
    INCBIN "dwm2-cobi-us.gbc", $08A934, $C5

; compressed sprite graphics of monster id $0F6 (Spooky) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
MonsterSprite_Spooky::
    INCBIN "dwm2-cobi-us.gbc", $08A9F9, $C5

; compressed sprite graphics of monster id $0F7 (Skullgon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 257 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Skullgon::
    INCBIN "dwm2-cobi-us.gbc", $08AABE, $101

; compressed sprite graphics of monster id $0F8 (PutrePup) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 225 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_PutrePup::
    INCBIN "dwm2-cobi-us.gbc", $08ABBF, $E1

; compressed sprite graphics of monster id $0F9 (RotRaven) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 229 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_RotRaven::
    INCBIN "dwm2-cobi-us.gbc", $08ACA0, $E5

; compressed sprite graphics of monster id $0FA (Mummy) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 220 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Mummy::
    INCBIN "dwm2-cobi-us.gbc", $08AD85, $DC

; compressed sprite graphics of monster id $0FB (DarkCrab) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 202 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_DarkCrab::
    INCBIN "dwm2-cobi-us.gbc", $08AE61, $CA

; compressed sprite graphics of monster id $0FC (DeadNite) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 215 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_DeadNite::
    INCBIN "dwm2-cobi-us.gbc", $08AF2B, $D7

; compressed sprite graphics of monster id $0FD (Shadow) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 180 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Shadow::
    INCBIN "dwm2-cobi-us.gbc", $08B002, $B4

; compressed sprite graphics of monster id $0FE (Skulpent) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 233 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Skulpent::
    INCBIN "dwm2-cobi-us.gbc", $08B0B6, $E9

; compressed sprite graphics of monster id $0FF (Hork) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 216 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Hork::
    INCBIN "dwm2-cobi-us.gbc", $08B19F, $D8

; compressed sprite graphics of monster id $100 (Mudron) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 232 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Mudron::
    INCBIN "dwm2-cobi-us.gbc", $08B277, $E8

; compressed sprite graphics of monster id $101 (NiteWhip) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 238 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_NiteWhip::
    INCBIN "dwm2-cobi-us.gbc", $08B35F, $EE

; compressed sprite graphics of monster id $102 (WindMerge) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 209 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_WindMerge::
    INCBIN "dwm2-cobi-us.gbc", $08B44D, $D1

; compressed sprite graphics of monster id $103 (Reaper) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 182 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Reaper::
    INCBIN "dwm2-cobi-us.gbc", $08B51E, $B6

; compressed sprite graphics of monster id $104 (Inverzon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 226 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Inverzon::
    INCBIN "dwm2-cobi-us.gbc", $08B5D4, $E2

; compressed sprite graphics of monster id $105 (FoxFire) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 239 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_FoxFire::
    INCBIN "dwm2-cobi-us.gbc", $08B6B6, $EF

; compressed sprite graphics of monster id $106 (CaptDead) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
MonsterSprite_CaptDead::
    INCBIN "dwm2-cobi-us.gbc", $08B7A5, $EF

; compressed sprite graphics of monster id $107 (DeadNoble) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 249 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_DeadNoble::
    INCBIN "dwm2-cobi-us.gbc", $08B894, $F9

; compressed sprite graphics of monster id $108 (WhiteKing) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 213 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_WhiteKing::
    INCBIN "dwm2-cobi-us.gbc", $08B98D, $D5

; compressed sprite graphics of monster id $17C (Lamia) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 210 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Lamia::
    INCBIN "dwm2-cobi-us.gbc", $08BA62, $D2

; compressed sprite graphics of monster id $17D (Dimensaur) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 226 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Dimensaur::
    INCBIN "dwm2-cobi-us.gbc", $08BB34, $E2

; compressed sprite graphics of monster id $17E (Kagebou) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 195 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Kagebou::
    INCBIN "dwm2-cobi-us.gbc", $08BC16, $C3
    ds $327, $00
