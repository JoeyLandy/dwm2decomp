; ROM bank $20: compressed monster sprites
; The annotated listing of this bank is build/listing/bank20.asm.

SECTION "Bank 20", ROMX[$4000], BANK[$20]
    db $20

; compressed sprite graphics of monster id $001 (DrakSlime); 68 other ids point here too
; (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed: 208 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_DrakSlime::
    INCBIN "dwm2-cobi-us.gbc", $080001, $D0

; compressed sprite graphics of monster id $002 (SpotSlime) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 233 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_SpotSlime::
    INCBIN "dwm2-cobi-us.gbc", $0800D1, $E9

; compressed sprite graphics of monster id $003 (WingSlime) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 186 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_WingSlime::
    INCBIN "dwm2-cobi-us.gbc", $0801BA, $BA

; compressed sprite graphics of monster id $004 (TreeSlime) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 175 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_TreeSlime::
    INCBIN "dwm2-cobi-us.gbc", $080274, $AF

; compressed sprite graphics of monster id $005 (Snaily) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 229 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Snaily::
    INCBIN "dwm2-cobi-us.gbc", $080323, $E5

; compressed sprite graphics of monster id $006 (SlimeNite) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 222 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_SlimeNite::
    INCBIN "dwm2-cobi-us.gbc", $080408, $DE

; compressed sprite graphics of monster id $007 (Babble) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 188 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Babble::
    INCBIN "dwm2-cobi-us.gbc", $0804E6, $BC

; compressed sprite graphics of monster id $008 (BoxSlime) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 130 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_BoxSlime::
    INCBIN "dwm2-cobi-us.gbc", $0805A2, $82

; compressed sprite graphics of monster id $009 (PearlGel) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 192 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_PearlGel::
    INCBIN "dwm2-cobi-us.gbc", $080624, $C0

; compressed sprite graphics of monster id $00A (Slime) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 102 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Slime::
    INCBIN "dwm2-cobi-us.gbc", $0806E4, $66

; compressed sprite graphics of monster id $00B (Healer) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 174 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Healer::
    INCBIN "dwm2-cobi-us.gbc", $08074A, $AE

; compressed sprite graphics of monster id $00C (FangSlime) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 225 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_FangSlime::
    INCBIN "dwm2-cobi-us.gbc", $0807F8, $E1

; compressed sprite graphics of monster id $00D (RockSlime) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 226 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_RockSlime::
    INCBIN "dwm2-cobi-us.gbc", $0808D9, $E2

; compressed sprite graphics of monster id $00E (SlimeBorg) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 195 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_SlimeBorg::
    INCBIN "dwm2-cobi-us.gbc", $0809BB, $C3

; compressed sprite graphics of monster id $00F (Slabbit) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 173 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Slabbit::
    INCBIN "dwm2-cobi-us.gbc", $080A7E, $AD

; compressed sprite graphics of monster id $010 (KingSlime) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 184 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_KingSlime::
    INCBIN "dwm2-cobi-us.gbc", $080B2B, $B8

; compressed sprite graphics of monster id $011 (Metaly) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 102 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Metaly::
    INCBIN "dwm2-cobi-us.gbc", $080BE3, $66

; compressed sprite graphics of monster id $012 (Metabble) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 188 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Metabble::
    INCBIN "dwm2-cobi-us.gbc", $080C49, $BC

; compressed sprite graphics of monster id $013 (SpotKing) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 226 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_SpotKing::
    INCBIN "dwm2-cobi-us.gbc", $080D05, $E2

; compressed sprite graphics of monster id $014 (TropicGel) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 209 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_TropicGel::
    INCBIN "dwm2-cobi-us.gbc", $080DE7, $D1

; compressed sprite graphics of monster id $015 (MimeSlime) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 236 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MimeSlime::
    INCBIN "dwm2-cobi-us.gbc", $080EB8, $EC

; compressed sprite graphics of monster id $016 (HaloSlime) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 139 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_HaloSlime::
    INCBIN "dwm2-cobi-us.gbc", $080FA4, $8B

; compressed sprite graphics of monster id $017 (MetalKing) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 184 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MetalKing::
    INCBIN "dwm2-cobi-us.gbc", $08102F, $B8

; compressed sprite graphics of monster id $018 (GoldSlime) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 146 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_GoldSlime::
    INCBIN "dwm2-cobi-us.gbc", $0810E7, $92

; compressed sprite graphics of monster id $019 (GranSlime) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 138 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_GranSlime::
    INCBIN "dwm2-cobi-us.gbc", $081179, $8A

; compressed sprite graphics of monster id $01A (WonderEgg) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 169 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_WonderEgg::
    INCBIN "dwm2-cobi-us.gbc", $081203, $A9

; compressed sprite graphics of monster id $024 (DragonKid) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 200 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_DragonKid::
    INCBIN "dwm2-cobi-us.gbc", $0812AC, $C8

; compressed sprite graphics of monster id $025 (Tortragon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 228 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Tortragon::
    INCBIN "dwm2-cobi-us.gbc", $081374, $E4

; compressed sprite graphics of monster id $026 (Pteranod) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 221 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Pteranod::
    INCBIN "dwm2-cobi-us.gbc", $081458, $DD

; compressed sprite graphics of monster id $027 (Gasgon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 246 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Gasgon::
    INCBIN "dwm2-cobi-us.gbc", $081535, $F6

; compressed sprite graphics of monster id $028 (FairyDrak) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 222 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_FairyDrak::
    INCBIN "dwm2-cobi-us.gbc", $08162B, $DE

; compressed sprite graphics of monster id $029 (LizardMan) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 237 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_LizardMan::
    INCBIN "dwm2-cobi-us.gbc", $081709, $ED

; compressed sprite graphics of monster id $02A (Poisongon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 245 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Poisongon::
    INCBIN "dwm2-cobi-us.gbc", $0817F6, $F5

; compressed sprite graphics of monster id $02B (Swordgon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 242 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Swordgon::
    INCBIN "dwm2-cobi-us.gbc", $0818EB, $F2

; compressed sprite graphics of monster id $02C (Drygon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 238 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Drygon::
    INCBIN "dwm2-cobi-us.gbc", $0819DD, $EE

; compressed sprite graphics of monster id $02D (Dragon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 213 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Dragon::
    INCBIN "dwm2-cobi-us.gbc", $081ACB, $D5

; compressed sprite graphics of monster id $02E (MiniDrak) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 230 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MiniDrak::
    INCBIN "dwm2-cobi-us.gbc", $081BA0, $E6

; compressed sprite graphics of monster id $02F (MadDragon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 252 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_MadDragon::
    INCBIN "dwm2-cobi-us.gbc", $081C86, $FC

; compressed sprite graphics of monster id $030 (Rayburn) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 231 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Rayburn::
    INCBIN "dwm2-cobi-us.gbc", $081D82, $E7

; compressed sprite graphics of monster id $031 (Chamelgon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 208 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Chamelgon::
    INCBIN "dwm2-cobi-us.gbc", $081E69, $D0

; compressed sprite graphics of monster id $032 (LizardFly) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 194 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_LizardFly::
    INCBIN "dwm2-cobi-us.gbc", $081F39, $C2

; compressed sprite graphics of monster id $033 (Andreal) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 231 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Andreal::
    INCBIN "dwm2-cobi-us.gbc", $081FFB, $E7

; compressed sprite graphics of monster id $034 (KingCobra) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
MonsterSprite_KingCobra::
    INCBIN "dwm2-cobi-us.gbc", $0820E2, $E7

; compressed sprite graphics of monster id $035 (Vampirus) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 203 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Vampirus::
    INCBIN "dwm2-cobi-us.gbc", $0821C9, $CB

; compressed sprite graphics of monster id $036 (SnakeBat) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 194 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_SnakeBat::
    INCBIN "dwm2-cobi-us.gbc", $082294, $C2

; compressed sprite graphics of monster id $037 (Spikerous) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 228 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Spikerous::
    INCBIN "dwm2-cobi-us.gbc", $082356, $E4

; compressed sprite graphics of monster id $038 (GreatDrak) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 239 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_GreatDrak::
    INCBIN "dwm2-cobi-us.gbc", $08243A, $EF

; compressed sprite graphics of monster id $039 (Crestpent) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 236 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Crestpent::
    INCBIN "dwm2-cobi-us.gbc", $082529, $EC

; compressed sprite graphics of monster id $03A (WingSnake) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 216 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_WingSnake::
    INCBIN "dwm2-cobi-us.gbc", $082615, $D8

; compressed sprite graphics of monster id $03B (Coatol) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 238 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Coatol::
    INCBIN "dwm2-cobi-us.gbc", $0826ED, $EE

; compressed sprite graphics of monster id $03C (Orochi) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 245 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Orochi::
    INCBIN "dwm2-cobi-us.gbc", $0827DB, $F5

; compressed sprite graphics of monster id $03D (BattleRex) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 232 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_BattleRex::
    INCBIN "dwm2-cobi-us.gbc", $0828D0, $E8

; compressed sprite graphics of monster id $03E (SkyDragon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 255 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_SkyDragon::
    INCBIN "dwm2-cobi-us.gbc", $0829B8, $FF

; compressed sprite graphics of monster id $03F (Serpentia) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 245 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Serpentia::
    INCBIN "dwm2-cobi-us.gbc", $082AB7, $F5

; compressed sprite graphics of monster id $040 (Divinegon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
MonsterSprite_Divinegon::
    INCBIN "dwm2-cobi-us.gbc", $082BAC, $FF

; compressed sprite graphics of monster id $041 (Orligon) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 227 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Orligon::
    INCBIN "dwm2-cobi-us.gbc", $082CAB, $E3

; compressed sprite graphics of monster id $042 (GigaDraco) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 239 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_GigaDraco::
    INCBIN "dwm2-cobi-us.gbc", $082D8E, $EF

; compressed sprite graphics of monster id $047 (Tonguella) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 232 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Tonguella::
    INCBIN "dwm2-cobi-us.gbc", $082E7D, $E8

; compressed sprite graphics of monster id $048 (Almiraj) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 234 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Almiraj::
    INCBIN "dwm2-cobi-us.gbc", $082F65, $EA

; compressed sprite graphics of monster id $049 (CatFly) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 220 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_CatFly::
    INCBIN "dwm2-cobi-us.gbc", $08304F, $DC

; compressed sprite graphics of monster id $04A (PillowRat) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 203 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_PillowRat::
    INCBIN "dwm2-cobi-us.gbc", $08312B, $CB

; compressed sprite graphics of monster id $04B (Saccer) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 168 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Saccer::
    INCBIN "dwm2-cobi-us.gbc", $0831F6, $A8

; compressed sprite graphics of monster id $04C (GulpBeast) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 243 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_GulpBeast::
    INCBIN "dwm2-cobi-us.gbc", $08329E, $F3

; compressed sprite graphics of monster id $04D (Skullroo) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 225 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Skullroo::
    INCBIN "dwm2-cobi-us.gbc", $083391, $E1

; compressed sprite graphics of monster id $04E (WindBeast) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 253 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_WindBeast::
    INCBIN "dwm2-cobi-us.gbc", $083472, $FD

; compressed sprite graphics of monster id $04F (Beavern) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 218 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Beavern::
    INCBIN "dwm2-cobi-us.gbc", $08356F, $DA

; compressed sprite graphics of monster id $050 (Antbear) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 222 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Antbear::
    INCBIN "dwm2-cobi-us.gbc", $083649, $DE

; compressed sprite graphics of monster id $051 (SuperTen) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 252 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_SuperTen::
    INCBIN "dwm2-cobi-us.gbc", $083727, $FC

; compressed sprite graphics of monster id $052 (IronTurt) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 247 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_IronTurt::
    INCBIN "dwm2-cobi-us.gbc", $083823, $F7

; compressed sprite graphics of monster id $053 (Mommonja) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 230 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Mommonja::
    INCBIN "dwm2-cobi-us.gbc", $08391A, $E6

; compressed sprite graphics of monster id $054 (HammerMan) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 185 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_HammerMan::
    INCBIN "dwm2-cobi-us.gbc", $083A00, $B9

; compressed sprite graphics of monster id $055 (Grizzly) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 214 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Grizzly::
    INCBIN "dwm2-cobi-us.gbc", $083AB9, $D6

; compressed sprite graphics of monster id $056 (Yeti) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 212 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_Yeti::
    INCBIN "dwm2-cobi-us.gbc", $083B8F, $D4

; compressed sprite graphics of monster id $057 (ArrowDog) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 216 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_ArrowDog::
    INCBIN "dwm2-cobi-us.gbc", $083C63, $D8

; compressed sprite graphics of monster id $058 (NoctoKing) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 177 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_NoctoKing::
    INCBIN "dwm2-cobi-us.gbc", $083D3B, $B1

; compressed sprite graphics of monster id $059 (BeastNite) (MonsterSpriteTable; the debug viewer
; decompresses it to vTiles0 + $200)
; LZSS-compressed: 232 bytes that expand to 256 (E-0016, E-0017)
MonsterSprite_BeastNite::
    INCBIN "dwm2-cobi-us.gbc", $083DEC, $E8
    ds $12c, $00
